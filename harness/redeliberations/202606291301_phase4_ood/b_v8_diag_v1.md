# 质量审查报告：阶段四 OOD 设计方案 v8

## 审查概述

本报告对 v8 产出进行质量审查，侧重评估需求响应充分度、事实准确性、深度完整性及编码可行动性。

**整体评价**：经过 7 轮迭代，文档质量显著提升，核心设计决策清晰、架构合理、约束策略明确。但仍存在 2 个严重质量问题和 5 个一般问题，以下逐项说明。

---

## 一、严重问题

### P1. lib.cj 中 translate/rotate/scale/shear/lookAt/lookAtRH/lookAtLH 跨包重复导入冲突未解决

**位置**：第 909–910 行（§8 lib.cj 更新）、现有 `lib.cj` 第 23 行

**问题描述**：
§8 lib.cj 更新方案从 `glm.ext` 导入 `translate/rotate/scale/shear/lookAt/lookAtRH/lookAtLH`（第 910 行），但现有 `lib.cj` 第 23 行已从 `glm.gtc` 导入完全相同的一组函数名（同签名、同参数类型）。此冲突已由 v7 第 1 个问题（严重）明确指出，v8 未做任何消歧处理。

D23 和 H6 关于"函数重载可自动区分"的分析不适用于此场景——`glm.ext.translate` 与 `glm.gtc.translate` 均接受 `Mat4x4` 参数（签名完全相同），不属于重载关系，而是真正的一对一符号冲突。仓颉编译器无法通过参数类型区分。

v7 已提出三个备选方案（方案 A：gtc 层转发 + lib.cj 只从 ext 导入；方案 B：lib.cj 只从 gtc 导入，删除 ext 重复行；方案 C：验证 CangJie 允许双路径 import），v8 未选择任一方案，也未新增验证项。

此问题若不修复，编译阶段可能报错（重复定义）或产生预期外的符号遮蔽（一个包中的版本静默覆盖另一个）。

**改进建议**：
明确选型并执行以下任一方案：
- **推荐方案**：修改现有 `lib.cj` 第 23 行，删除 `translate/rotate/scale/shear/lookAt/lookAtRH/lookAtLH` 的 gtc import；§8 lib.cj 更新中从 ext 导入这些符号。gtc 层内部通过 `public import` 从 ext 转发。
- **备选方案**：保持 lib.cj 第 23 行不变，§8 lib.cj 更新中不导入这些符号，改为从 gtc 统一提供。gtc 层可直接提供实现，不依赖 ext。
- 无论选择哪一方案，均需在 D23 或新增设计决策中记录选型理由和验证结果。

---

### P2. frexp 零值/NaN/Inf/非规范化数边缘场景实现策略缺失

**位置**：第 248 行（§3.1 common.cj）

**问题描述**：
`frexp<T>(x: T): (T, Int64)` 仅描述了返回签名和尾数范围 `[0.5, 1)`，但未提供可行的边缘场景实现策略。v7 第 2 个问题（严重）已指出数学分解方案（`floor(log2(|x|))`）在零值/NaN/Inf/非规范化数场景失效，v8 未做实质性补充。

具体风险：
- **零值**：`log2(0) = -Inf`，计算 `floor(log2(|0|))` 得到 `-Inf`，无法得到正确的 `(0.0, 0)`。
- **NaN**：`log2(NaN) = NaN`，无法正确透传。
- **Inf**：`log2(Inf) = Inf`，无法得到正确的 `(Inf, 0)`。
- **非规范化数**：`log2(denormal)` 的浮点精度不足以正确推导指数。

`FloatingPoint<T>` 接口不提供 `toBits()`/`fromBits()`，因此无法在泛型内通过位操作实现标准 frexp 算法。当前设计未给出权威的通用实现替代方案。

**改进建议**：
以下方案至少选择其一：
1. **数学分解加前置检查**：`if x.isNaN() → (T.getNaN(), 0)`、`if x.isInf() → (x, 0)`、`if x == T(0) → (T(0), 0)`，合法值使用 `exponent = floor(log2(abs(x)))` + `mantissa = x / pow(T(2), T(exponent))`。注意非规范化数场景的精度损失需标记为已知行为差异。
2. **具体类型重载**：为 Float32/Float64 各提供基于 `toBits()` 的位操作实现，标量版本委托 shim，类似 D27（ulp.cj）的处理方式。
3. 在 D25 中补充策略选型理由，并新增关于非规范化数的行为声明。

---

## 二、一般问题

### G1. ext/quaternion_common.cj 依赖链遗漏 glm.detail.common

**位置**：第 187 行（§2 模块间依赖表）

**问题描述**：
依赖表中 `quaternion_common.cj mix/slerp → glm.detail.trigonometric + glm.detail.geometric + ext/scalar_constants`，但该行下方的说明（第 188 行）明确指出 "mix 依赖 common.cj 的 mix 标量函数"。依赖链中缺少 `glm.detail.common`。

此问题在 v7 第 3 个问题中已指出，v8 未修正。虽然说明性文字已列出依赖关系，但结构化的依赖表中遗漏会使编码阶段执行拓扑排序时忽略此约束，可能导致批次排序错误。

**改进建议**：
在第 187 行依赖链中补充 `glm.detail.common`，例如 `→ glm.detail.trigonometric + glm.detail.geometric + glm.detail.common + ext/scalar_constants`。

---

### G2. gtc/noise.cj 缺少完整函数签名

**位置**：第 610–615 行（§3.3 gtc/noise.cj）

**问题描述**：
gtc/noise.cj 仅以文字描述 perlin 和 simplex 噪声的维度范围（1D/2D/3D/4D），未给出任何一个函数的完整仓颉签名。与 packing.cj 形成了明显的质量落差——packing.cj 已按 v7 要求补齐了每个函数的完整签名（第 555–601 行），而 noise.cj 仍然停留在"实现参考 GLM 1.0.3"的描述层级。

v7 第 4 个问题已指出"编码团队无法实现"，v8 虽补充了存储机制（纯算法方式、约 250–300 行有效代码），但关键的函数签名（参数类型、返回类型、约束）仍然缺失。

**改进建议**：
为每个函数补充完整签名，格式参考 packing.cj 的代码块样式：
- `perlin1D<T, Q>(x: T): T where T <: FloatingPoint<T>, Q <: Qualifier`
- `perlin2D<T, Q>(v: Vec2<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier`
- `simplex1D<T, Q>(x: T): T where T <: FloatingPoint<T>, Q <: Qualifier`
- `simplex2D<T, Q>(v: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier`（注意：Simplex 2D 返回 Vec2，Perlin 2D 返回标量 T——GLM 的此差异需在签名中反映）

根据 GLM 1.0.3 `gtc/noise.inl` 确认每个函数的具体返回类型（Perlin 系列返回标量 T，Simplex 1D 返回标量 T，Simplex 2D/3D/4D 返回对应向量）。

---

### G3. ext/scalar_common.cj 的 iround/uround 负数输入行为偏离 GLM 且差异仅以行内注释记录

**位置**：第 362–364 行（§3.2 ext/scalar_common.cj）

**问题描述**：
公式 `Int64(x + T(0.5))` 对负数输入产生错误结果：`iround(-3.7)` → `Int64(-3.7 + 0.5)` → `Int64(-3.2) → -3`，而非正确的 `-4`。行注释标注"非负输入"限定了输入范围，但：

1. **函数签名无约束**：签名 `T <: FloatingPoint<T>` 不限制输入值域，调用方传入负数时编译通过但语义错误。
2. **与 GLM 不一致**：GLM 1.0.3 的 `iround` 通过 `static_cast<int>(round(x))` 正确处理全值域，无此限制。
3. **记录不充分**：此行为差异仅以一行注释记录，未在 §7 设计决策或 §1 偏差记录中系统化标注。若编码团队按 GLM 测试用例验证，将发现结果不匹配。

**改进建议**：
- **方案 A（推荐）**：改用 `Int64(round(x))` 公式（委托 `std.math.roundT` 通过 shim），消除负数语义偏差，与 GLM 行为一致。
- **方案 B**：若因性能或其他原因保留当前公式，必须在 D24 或新增设计决策条目中记录此行为偏差，说明与 GLM 的差异、约束范围和已知后果。同时在函数签名前增加 `@pre(input >= T(0))` 或等效文档注释。

---

### G4. stdmath_shim.cj 在 Float16 上的溢出行为差异未记录

**位置**：第 50 行（§1.4 stdmath_shim.cj 模式）、第 837 行（D29）

**问题描述**：
`(result as T).getOrThrow()` 模式在 `T = Float16` 时存在行为差异：当中间计算结果超出 Float16 范围（±65504）时，GLM 1.0.3 返回 ±Inf（IEEE 754 自然溢出），而仓颉的 `as T` 转型可能抛异常或产生其他未定义行为。此差异在 v7 第 5 个问题中已指出，v8 未做任何处理。

**改进建议**：
在 §1.4 或 D29 中补充以下内容之一：
- 标注已知行为差异：`(result as T).getOrThrow()` 在 `T = Float16` 且中间值超过 ±65504 时，与 GLM 的 ±Inf 返回行为不同。建议编码阶段为 `stdmath_shim.cj` 添加 `Float16` 溢出保护：`if result > Float16.MAX → T.getInf()`。
- 或声明本设计接受此差异（因 Float16 主要用于低精度图形场景，溢出概率极低），并在偏差文档中记录。

---

### G5. `mod` 函数标量浮点重载的设计决策仍为"编码阶段可选"，留下不确定性

**位置**：第 244 行（§3.1 common.cj）、第 823 行（D15）

**问题描述**：
D15 将标量浮点 `mod` 重载定为"编码阶段按需决策的可选增强"，但现有 stub 代码的测试用例可能依赖浮点 `mod` 的可用性。若编码阶段选择不实现，调用方需通过 `scalar_vec_ops.cj` 的向量重载间接调用（用单分量 Vec1 包装标量），产生不自然的使用模式。

此外，lib.cj 第 5 行已导出 `glm.detail.{..., mod}`，若 common.cj 的泛型 `mod` 保持 `Integer<T>` 约束，则 `mod(Float32(3.14), Float32(2.0))` 无法通过编译（不满足 Integer 约束），而 `scalar_vec_ops.cj` 中仅提供 `(scalar, Vec)` 形式的浮点重载，缺乏 `(scalar, scalar)` 形式。

**改进建议**：
在 D15 中将标量浮点 `mod` 重载由"可选"升级为"推荐实现"，并明确参数类型和约束（3 个具体类型重载：Float32, Float64, Float16），使 GLSL 的 `mod(float, float)` 调用可直接编译。

---

## 三、整体评价

文档整体质量较高，核心设计清晰，约束策略和实现路径描述详实。上述问题主要集中在前序审查已指出但未充分修复的遗留项，以及个别函数的设计粒度尚不足以直接指导编码。建议在下一轮迭代中优先解决 P1（编译阻塞风险）和 P2（编码不可行动性），其余一般问题可在同一轮次一并修复。
