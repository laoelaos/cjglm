# OOD 设计方案审查报告（v8）

## 审查结果

REJECTED

## 逐维度审查

### 1. 类型系统可行性

**[通过]** Vec1~Vec4 维度展开策略（§3.2 符号约定）正确规避了仓颉不支持整数维度泛型参数的限制，FloatingPoint<T>/Number<T>/Comparable<T> 等接口约束使用正确。

**[通过]** gtc/ulp.cj 改用 Float32/Float64 具体类型重载而非泛型（D27），正确回避了 FloatingPoint<T> 接口不提供 toBits()/fromBits() 的问题。

**[一般]** frexp\`<T>(x: T): (T, Int64) where T <: FloatingPoint\<T\>\` 提供签名但缺乏可行实现路径（§3.1 common.cj）。FloatingPoint\<T\> 不提供 toBits()/fromBits()，数学分解方案（log2+pow）在 x=0/denormal/NaN/Inf 场景面临精度退化和失败风险。设计应注明至少一种可行实现策略（如具体类型重载 + toBits()，或 log2+pow + 前置检查），或将该函数标记为后续编码阶段验证项。

### 2. 标准库与生态覆盖

**[通过]** stdmath_shim.cj 包装层正确解决了 std.math 仅提供 Float64 签名的问题，采用 `(x as Float64).getOrThrow() → std.math → (result as T).getOrThrow()` 模式适用于所有浮点类型。

**[通过]** ThreadLocal\<Random\> 方案（H5）经仓颉并发编程文档确认可用，来自 core 包且不对 T 施加 Send/Sync 约束。

**[通过]** Float32.toBits()/fromBits() 等位操作 API 为仓颉标准库原生能力，可用于 gtc/packing.cj 和 gtc/ulp.cj 的具体类型重载。

**[轻微]** Float64→Float16 转型（stdmath_shim.cj）在中间值超过 ±65504 时 `(result as Float16).getOrThrow()` 将抛出异常，而 GLM 1.0.3 返回 ±Inf。此差异已被记录为已知限制，编码阶段需在 §1.4 或 stdmath_shim 注释中补充 Float16 范围约束说明。

### 3. 语言特性可行性

**[通过]** 仓颉函数重载规则（H6）确认基于参数类型和数量可自动区分同名函数。ext.mix(Quat param) 和 detail.mix(scalar/vector param) 无歧义；detail.exp/log/pow/sqrt(scalar/vector) 和 ext.exp/log/pow/sqrt(quat) 无歧义。

**[通过]** ThreadLocal\<T\>（H5）使用正确，每个线程独立 Random 实例，无需加锁。

**[通过]** 包结构（glm.detail / glm.ext / glm.gtc / glm）与 cjpm 项目组织方式一致，依赖方向合理（单向、无循环依赖）。

### 4. 设计一致性

**[严重]** lib.cj 增量更新（§8）在行 910 从 ext 导入 `translate/rotate/scale/shear/lookAt/lookAtRH/lookAtLH`，而行 911-912 注释确认 gtc 模块已通过 lib.cj 第 24-27 行导入。如果 gtc 使用 public import 重导出（§3.3 第 525 行），则同一函数名经双路径导入未验证；如果 gtc 使用转发函数，则同签名双导入构成编译错误。注释声称"仅导入 gtc 未覆盖的符号"与事实矛盾——gtc/matrix_transform.cj（§3.3 第 136-143 行）明确包含这些函数。迭代要求中已提出三种解决方案（方案A/B/C），但本设计均未采纳。

**[一般]** quaternion_common.cj 依赖关系（§2 行 187-188）列出了 trigonometric + geometric + scalar_constants，但遗漏了 glm.detail.common。其说明文字"mix 依赖 common.cj 的 mix 标量函数"证实了此依赖存在但依赖链中缺失。

**[轻微]** gtc/noise.cj（§3.3 行 611-613）未给出任何函数的完整仓颉签名（参数类型、返回类型、泛型约束），对比 packing.cj 的 40+ 个完整签名设计粒度显著不足。虽不阻塞通过，但应在后续迭代中补充。

### 5. 设计质量

**[通过]** 职责划分清晰，core/ext/gtc 三层架构合理，依赖方向整洁。

**[通过]** 采用增量式 lib.cj 更新策略（不修改已有行），保持向后兼容。

**[通过]** 实施批次按拓扑依赖排序，分四批实施，批次内文件可并行编码。

**[通过]** 模块间职责分离良好：ext 层作为实现细节，gtc 层作为稳定 API 面。

## 修改要求（REJECTED 时存在）

### 问题 1：lib.cj 导入命名冲突（严重）

- **问题**：§8 lib.cj 行 910 新增的 ext 层导入（`translate/rotate/scale/shear/lookAt/lookAtRH/lookAtLH`）与现有 lib.cj 第 24-27 行 gtc 导入在相同函数名上形成重复。注释声称"仅导入 gtc 未覆盖的符号"与事实不符。
- **原因**：gtc/matrix_transform.cj（§3.3）明确包含这 7 个函数。若 gtc 使用 public import 重导出（§3.3 第 525 行方案一），同一函数经双路径导入编译器行为未验证；若 gtc 使用转发函数（方案二），同签名双导入必然编译错误。无论哪种方案，均导致设计不可实现。
- **建议方向**：采纳迭代要求提出的三方案之一——方案A（gtc 转发，lib.cj 从 ext 统一导入）、方案B（gtc 重导出，lib.cj 只从 gtc 导入）、方案C（明确验证双路径 import 在仓颉中的可行性并记录决策）。注意：方案C 需在编码前完成编译验证，并在文档中记录验证结果。

### 问题 2：frexp 缺乏可行实现路径（一般）

- **问题**：`frexp<T>(x: T): (T, Int64) where T <: FloatingPoint<T>`（§3.1）给出了签名设计但未提供可行的实现策略。
- **原因**：FloatingPoint<T> 接口不提供 toBits()/fromBits() 方法。数学分解方案（log2+pow）在 x=0/denormal/NaN/Inf 等边界场景面临精度退化风险。若不指明实现路径，后续编码阶段可能无法完成。
- **建议方向**：至少标注一种可行方案——例如"编码阶段为 Float32/Float64 提供基于 toBits() 的具体类型重载，为 Float16 回退到 Float32 精度的 log2+pow 数学分解"，或"使用数学分解（frexp = (x / pow(T(2), exp), floor(log2(abs(x)))) + 零值/Inf/NaN 前置检查"。

### 问题 3：quaternion_common.cj 依赖链遗漏 glm.detail.common（一般）

- **问题**：§2 模块间依赖表中 quaternion_common.cj 的依赖链列出 `trigonometric + geometric + ext/scalar_constants`，但其说明文字明确提到"mix 依赖 common.cj 的 mix 标量函数"。
- **原因**：依赖关系表与实际依赖不一致，编码阶段可能导致 import 遗漏和编译错误。
- **建议方向**：在依赖链中补充 `glm.detail.common`。
