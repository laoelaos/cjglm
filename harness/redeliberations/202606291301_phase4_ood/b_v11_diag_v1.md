# 质量审查报告 — v11 产出

## 审查范围

本次审查聚焦内部审议（设计-验证/执行-审查循环）未充分覆盖的维度：需求响应充分度、整体深度和完整性、实际落地可行性。

## 审查发现

### 发现 1（中等 — 事实错误）：`frexp` 指数计算公式错误

**所在位置**：§3.1 common.cj 职责，第 248 行

**问题描述**：文档声明的 mantissa 范围为 `[0.5, 1)`，但给出的指数公式 `exponent = floor(log2(abs(x)))` 实际产生 mantissa 在 `[1, 2)` 范围内，与声明自相矛盾。

**验证**：以 x=8.0 验证 —— `floor(log2(8)) = 3`，`mantissa = 8/2³ = 1.0`，不在 `[0.5, 1)` 内。正确的公式应为 `exponent = floor(log2(abs(x))) + 1`，此时 `mantissa = 8/2⁴ = 0.5 ∈ [0.5, 1)`。所有合法输入均存在此偏差。

**严重程度**：中等。编码阶段若不修正会导致 `frexp` 返回错误的分量值，影响下游依赖方。

**建议**：将 `exponent = floor(log2(abs(x)))` 修正为 `exponent = floor(log2(abs(x))) + 1`，并在 D25 中补充公式推导验证。

---

### 发现 2（中等 — 事实错误）：`ulp(x)` 实现公式不适用于任意 x

**所在位置**：§3.3 gtc/ulp.cj 实现路径，第 684 行

**问题描述**：文档描述的 `ulp(x)` 公式为 `T.fromBits(T(1).toBits() - T(1))`，该表达式：
1. 存在类型不匹配问题：`T(1).toBits()` 返回无符号整数（`UInt32`/`UInt64`），而 `T(1)` 为浮点数，两者不能直接相减
2. 即使假设表述不精确，公式也仅计算 `ulp(1.0)` 这个常量，而非与 x 的指数相关的 `ulp(x)`。对于 x ≠ 1.0（如 x=65536.0），ULP 应为 `ulp(1.0) * 2^exponent(x)`，而公式忽略了 x 的指数信息

**验证**：查阅 IEEE 754 标准，浮点数的 ULP 取决于其指数部分，不同数量级的 x 对应不同 ULP 大小。`ulp(65536.0) = 2^(16-23) = 2^-7 = 0.0078125`（Float32），而 `ulp(1.0) ≈ 1.19e-7`，两者相差 65536 倍。

**严重程度**：中等。编码阶段若按此公式实现，除 x=1.0 外所有输入的 `ulp` 计算结果均不正确。

**建议**：将 `ulp(x)` 实现路径修正为基于 x 自身位模式的操作，如正数 `ulp(x) = T.fromBits(x.toBits() + 1u) - x`（等价于 `next_float(x) - x`），或使用 `next_float`/`prev_float` 推导。在 D27 中记录修正理由和实现细节。

---

### 发现 3（轻微 — 边缘场景遗漏）：`uround` 负数输入行为与 GLM 不一致

**所在位置**：§3.2 ext/scalar_common.cj，第 362–368 行

**问题描述**：文档声称 `iround`/`uround` 的实现"与 GLM 行为一致"，但未验证 `UInt64(negative_rounded_value)` 在仓颉中的行为。经查阅仓颉语言文档（`@OverflowThrowing` 为默认整数溢出策略），浮点到无符号整数的转换在值为负数时触发溢出 → 抛 `ArithmeticException`。而 GLM C++ 的 `unsigned int(round(x))` 对负数采取模运算回绕（wrapping），产生大正数。

**验证**：仓颉反射与注解文档（reflect_and_annotation）确认默认溢出策略为 `@OverflowThrowing`：溢出时抛出 `ArithmeticException`。类型系统文档（type_system）确认"运行时转换可能溢出 → 异常"。

**严重程度**：轻微。`uround` 的负数输入属边缘场景，但设计文档作为编码依据应标注此行为差异或给出处理策略（如增加前置检查或使用 `@OverflowWrapping` 注解）。

**建议**：在 §3.2 ext/scalar_common.cj 或 D24 中补充 `uround` 负数输入的行为声明，明确选型：方案 A — 增加 `x < T(0)` 前置检查返回 `UInt64(0)` 或抛出；方案 B — 使用 `@OverflowWrapping` 模拟 GLM 回绕行为；方案 C — 接受运行时异常并标注为已知差异。

---

### 发现 4（轻微 — 完整性遗漏）：`ext/quaternion_trigonometric.cj` 未出现在 §2 依赖表中

**所在位置**：§2 模块间依赖，glm.ext 依赖清单，第 181–189 行

**问题描述**：`ext/quaternion_trigonometric.cj`（angle/angleAxis 补齐）已在 §2 包组织（第 128 行）和 §3.2（第 497–504 行）中描述，但在 glm.ext 依赖表中缺少对应条目。根据 §3.2 的描述，其依赖关系为 `glm.detail.trigonometric（acos/sin/cos）+ glm.detail.common（clamp）`。

**验证**：§3.2 ext/quaternion_trigonometric.cj 职责（第 500 行）明确 `angle(x)` 使用 `clamp(x.w, T(-1), T(1))`（依赖 common.cj 的 clamp）和 `acos`（依赖 trigonometric.cj）。

**严重程度**：轻微。编码团队可从 §3.2 推导出依赖关系，但依赖表不完整会降低设计文档作为一站式参考的可用性。

**建议**：在 §2 glm.ext 依赖表中补充条目：`quaternion_trigonometric.cj angle/angleAxis → glm.detail.trigonometric（acos/sin/cos）+ glm.detail.common（clamp）`。

---

## 整体质量评价

经 10 轮迭代后，文档在需求响应充分度方面表现良好——覆盖了架构视图、模块划分、核心类型与接口设计、关键数据流与控制流、与已有阶段集成等全部要求维度。模块划分清晰，设计决策记录充分（30 条），30 条设计决策中大部分已被验证或附有仓颉语言文档支撑。

发现 1 和发现 2 属于未被前序审查捕获的较隐蔽事实错误，两类错误均与数学公式推导有关——前序审查多次迭代后可能形成了"函数签名已定型，公式细节无需深究"的定势，导致这些计算核心的公式错误未被检出。修复后可编码性将进一步提升。
