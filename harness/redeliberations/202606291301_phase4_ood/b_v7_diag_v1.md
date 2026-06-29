# 质量审查诊断报告 — 阶段四 OOD 设计方案（v7）

- **审查对象**: `a_v7_design_v2.md`
- **审查批次**: 第 7 轮
- **审查维度**: 需求响应充分度、事实准确性、深度与完整性（侧重内部审议未充分覆盖的方向）

---

## 整体评价

经过 7 轮迭代，本设计文档在需求覆盖度、事实准确性和可落地性方面已达到较高成熟度。文档完整覆盖了需求中的架构视图、模块划分、核心类型与接口设计、关键数据流与控制流、与已有阶段集成方式五大维度。内部审议（技术可行性验证、编译器特性确认等）扎实充分。

以下问题属于内部审议未充分覆盖的领域——主要是**设计自洽性（跨章节一致）**、**lib.cj 导出方案的编译可行性**、以及**部分函数的实际编码可行性**。罗列如下，供编码阶段参考。

---

## 发现的问题

### P1（严重）— lib.cj 增量更新与现有 gtc 导入形成命名冲突

**位置**: §8 lib.cj 更新（第 909–910 行）、现有 lib.cj 第 23 行

**问题描述**: §8 新增的 ext 层导入与现有 lib.cj 第 23 行的 gtc 导入在 `translate/rotate/scale/shear/lookAt/lookAtRH/lookAtLH` 上重复，且第 910 行的注释声称"仅导入 gtc 未覆盖的符号"，与事实矛盾：

- 现有 lib.cj:23: `public import glm.gtc.{identity, translate, rotate, rotate_slow, scale, scale_slow, shear, shear_slow, lookAt, lookAtRH, lookAtLH}`
- 第 910 行拟新增: `public import glm.ext.{translate, rotate, scale, shear, lookAt, lookAtRH, lookAtLH}`

影响分析：
- 若 `gtc/matrix_transform.cj` 使用 `public import glm.ext.{...}`（重导出），则 `glm.gtc.translate` 与 `glm.ext.translate` 指向同一底层函数，CangJie 是否接受同函数从两路径导入未经验证（H6 仅验证了"参数类型不同时的重载决议"，未验证"同签名同函数双路径导入"）。
- 若 `gtc/matrix_transform.cj` 使用转发函数（非重导出），则 `glm.gtc.translate` 与 `glm.ext.translate` 是不同函数，同签名双导入必然导致编译错误。
- 无论哪种路径，当前设计均存在编译风险。§8 的"增量追加、不修改已有行"策略在此处不可直接执行。

**改进建议**: 明确选型——方案A：gtc 层使用转发函数，lib.cj 中删除对应符号的 gtc import（修改现有行），改为从 ext 统一导入；方案B：gtc 层使用 `public import` 重导出，lib.cj 只从 gtc 导入，删除 ext 重复行；方案C：验证 CangJie 是否允许同函数双路径 `public import`，若通过则在注释中记录验证结果。

---

### P2（严重）— `frexp` 缺乏可行实现路径，编码阶段不可直接实现

**位置**: §3.1 common.cj 职责（第 248–249 行）

**问题描述**: `frexp<T>(x: T): (T, Int64) where T <: FloatingPoint<T>` 提供了签名设计，但未提供可行的实现策略。具体而言：

1. `FloatingPoint<T>` 接口不提供 `toBits()`/`fromBits()` 方法（D27 已确认此限制），无法通过位操作提取浮点数的指数和尾数。
2. 数学分解方案（`exponent = floor(log2(abs(x)))`，`mantissa = x / pow(T(2), T(exponent))`）在以下场景失效：
   - **x = 0**：log2(0) = -Inf，pow(T(2), -Inf) = 0，0 / 0 = NaN
   - **非规范化数（denormals）**：exponent 计算错误
   - **NaN/Inf 输入**：需前置检查
3. 文档为 `modf` 提供了具体实现公式（`integer = trunc(x)`），为 `ldexp` 提供了实现路径（`x * pow(T(2), T(exp))`），但未为 `frexp` 提供任何实现指引。

**改进建议**: 补充 `frexp` 的实现策略。建议方案：
   - 对输入 x 做零值/Inf/NaN 前置检查
   - 对合法值使用 `log2 + `pow` 数学分解
   - 在 §7 新增设计决策条目，记录 denormal 处理策略（接受边缘误差、或将实现降级为具体类型重载使用 `toBits()`）
   - 或在 `stdmath_shim.cj` 中为 Float32/Float64 各提供基于 `toBits()` 的具体类型实现，标量版本直接委托 shim

---

### P3（一般）— 依赖关系表遗漏 `glm.detail.common`

**位置**: §2 模块间依赖表（第 187–188 行）

**问题描述**: `ext/quaternion_common.cj` 的依赖关系列出了 `glm.detail.trigonometric + glm.detail.geometric + ext/scalar_constants`，但遗漏了 `glm.detail.common`。其 `mix` 函数使用 `common.cj` 的 `clamp`（D10 明确写道"mix 使用 clamp(a, T(0), T(1)) 而非 assert"），且 `slerp` 中 `clamp(dot(x,y), -T(1), T(1))` 也依赖 `common.cj` 的 `clamp`。依赖关系表与实际设计不一致。

**改进建议**: 在第 187 行依赖链中补充 `glm.detail.common`。

---

### P4（一般）— `gtc/noise.cj` 函数签名未定义，编码阶段无法直接使用

**位置**: §3.3 gtc/noise.cj（第 611–615 行）

**问题描述**: noise.cj 职责描述为"perlin 系列：Perlin 噪声（1D/2D/3D/4D）"和"simplex 系列：Simplex 噪声（1D/2D/3D/4D）"，未给出任何一个函数的具体仓颉签名（参数类型、返回类型、约束）。对比本文件其他模块（如 packing.cj 提供了 40+ 个完整函数签名、scalar_common.cj 提供了 17 个完整签名），noise.cj 的设计粒度显著不足。编码团队无法仅凭"1D/2D/3D/4D"确定函数签名——尤其是返回类型不明确（Perlin 噪声返回标量 T、Simplex 噪声返回的是 T 还是 Vec<T> 也不明确）。

**改进建议**: 补充至少每个函数的完整签名，格式参考 packing.cj 的代码块样式。GLM 1.0.3 中 Perlin 噪声返回 T（1D/2D/3D/4D 输入各返回标量 T），Simplex 噪声返回 Vec<T, Q>（各维度返回对应维度向量，1D 特殊返回标量 T）。建议直接列出 8 个函数的完整签名。

---

### P5（一般）— `stdmath_shim.cj` 的 Float64→Float16 转型可能运行时崩溃

**位置**: §1.4 `stdmath_shim.cj` 模式（第 50 行）、§3.1 exponential.cj 实现路径（第 266 行）

**问题描述**: `stdmath_shim.cj` 的通用模式 `(result as T).getOrThrow()` 在 `T = Float16` 且计算中间值超过 Float16 范围（±65504）时，`as` 转型返回 `None`，`getOrThrow()` 抛出异常。这在以下场景可触发：
- `exp(Float16(89.0))`：std.math.exp 返回 ~1.2e38，远超 Float16 上限
- `pow` 的任意大指数值
- `ldexp(x, large_exp)`：`pow(T(2), T(exp))` 产生大值后作为侧支输入

而 GLM 1.0.3 在相同输入下返回 ±Inf（由 IEEE 754 自然产生）。此行为差异未被文档记录。文档仅说此模式"已通过编译验证"，未提及运行时崩溃风险。

**改进建议**: 在 §1.4 或 D29 中补充 Float16 范围约束说明，标注已知行为差异：当中间计算结果超出 Float16 范围时抛异常而非返回 Inf。可接受的备选方案：在 `stdmath_shim.cj` 中为 Float16 添加 `result > Float16.MAX → T.getInf()` 保护。

---

### P6（轻微）— `isnan/isinf` 的描述存在"实例方法"与"静态方法"矛盾

**位置**: §3.1 common.cj 约束策略（第 243 行）vs. §1.4 H2（第 49 行）

**问题描述**: §3.1 称 `isnan/isinf`"需要 isNaN/isInf 实例方法"，但 §1.4 H2 明确记录已验证的是"**静态方法**`T.getInf()/T.isNaN()`"。实例方法（`x.isNaN()`）与静态方法（`T.isNaN(x)`）在调用语法上不同。虽然两者可能同时存在，但文档应统一描述以免编码时犯语法错误。

**改进建议**: 统一表述为"静态方法 `T.isNaN(x)`/`T.isInf(x)`"，或核实 `FloatingPoint<T>` 接口是否同时提供实例方法后同步全文。

---

## 未发现的问题（已由内部审议充分覆盖的维度）

以下维度经审查确认无显著质量问题，不再重复验证：
- **技术可行性**：H1–H6 确定性声明的编译验证依据充分
- **包结构与模块划分**：§2 的组织方案与现有阶段一~三一致
- **函数签名映射的准确性**：各 core/ext/gtc 模块的函数清单经逐轮修正已基本对齐 GLM 1.0.3
- **错误处理策略**：§5 的异常场景覆盖完整，行为描述已收敛
- **并发设计**：random.cj 的 ThreadLocal 方案验证充分，例外声明清晰
- **实施批次**：拓扑排序正确，无循环依赖
- **与已有阶段集成**：§9 的反向兼容分析合理
