# OOD 设计方案审查报告（v6）

## 审查结果

REJECTED

## 逐维度审查

### 1. 类型系统可行性

**[一般]** `Vec<L, T, Q>` 记号在 ext/vector_common.cj（第 371–402 行）中用作函数签名中的实际类型标识符。然而 CangJie 不支持非类型模板参数（整数维度参数 L），且代码库中不存在 `Vec<L, T, Q>` 泛型类型——现有类型是 `Vec1<T,Q>`、`Vec2<T,Q>`、`Vec3<T,Q>`、`Vec4<T,Q>` 四个独立 struct。已有编码模式（如 `compute_vector_decl.cj`、`geometric.cj`、`scalar_vec_ops.cj`）均对每个 Vec 维度编写独立重载。若 `Vec<L, T, Q>` 意图为设计级记号简写，需明确声明并给出到 Vec1~Vec4 的具体展开示例；否则编码阶段无法直接实现。

**[通过]** 其余类型形态选择（包级泛型函数）、继承/实现关系（无 OOP 继承，仅接口约束 `Number<T>`/`FloatingPoint<T>`/`Comparable<T>`/`Integer<T>`）、泛型用法（where 约束 + 接口边界）均与 CangJie 类型系统能力匹配。`Qualifier` 标记类型体系已存在且可行。

### 2. 标准库与生态覆盖

**[一般]** `std.math.pow` 不提供 `Float16` 重载。原始文档确认其重载集为：`pow(Float32, Float32)`、`pow(Float32, Int32)`、`pow(Float64, Float64)`、`pow(Float64, Int64)`。设计在 exponential.cj（第 258–260 行）中将 `pow` 的约束标注为 `T <: FloatingPoint<T>` 并声称"直接委托 `std.math.pow`"，但该委托路径在 `T = Float16` 时不可行（编译错误）。此外，`ldexp` 实现路径 `x * pow(T(2), T(exp))`（第 244 行）在 `T = Float16` 时同样不可行。需明确 Float16 pow 的处理策略（如限制 Float16 不支持 pow、或使用 `exp(log(a)*b)` 恒等式回退、或在实现批次中标注 Float16 为暂不支持）。

**[通过]** 其余标准库能力均可用：`std.math` 的 Float16/Float32/Float64 三重载对 sin/cos/sqrt/exp/log/exp2/log2 等函数可用；`Float32.toBits(): UInt32`/`Float32.fromBits()` 等位操作方法已确认存在于 `core` 包；`ThreadLocal<T>` 来自 `core` 包且不支持 `Send`/`Sync` 约束已验证；`std.random.Random` 提供 `nextFloat64()`/`nextGaussianFloat64()` 等所需方法；`std.time.DateTime` 提供 `toUnixMillisecond()`。

### 3. 语言特性可行性

**[通过]** 函数重载可基于参数类型自动区分同名函数（H6，已文档验证）；`ThreadLocal<T>` 可用且不要求 `Send`/`Sync` 约束（H5，已文档验证）；`Float16`/`Float32`/`Float64` 遵循 IEEE 754，浮点除零返回 ±Inf（H4，已编译验证）；包结构（`glm.detail`/`glm.ext`/`glm.gtc`）符合 cjpm 项目组织方式，依赖方向单向无循环（已编译验证 H3）；错误处理策略（acos/asin 越界返回 NaN、奇异矩阵 IEEE 754 自然传播）在 CangJie 中均可行。

### 4. 设计一致性

**[通过]** 上一轮迭代识别的 4 个问题（P1: ext/scalar_common.cj 事实错误、P2: ext/vector_common.cj 缺乏细节、P3: ortho 计数错误、P4: gtc/matrix_transform.cj 总数矛盾）在本版中已全部修正：ext/scalar_common.cj 现在列出正确的 17 个函数并标注"不包含" mix/step/smoothstep；ext/vector_common.cj 列出完整 20 个函数签名；ortho 计数修正为 10；gtc/matrix_transform.cj 基础变换计数修正为 11、全族求和 11+10+9+9+9+7+2+6+1=64 与声明一致。

**[通过]** 各抽象职责描述清晰、协作关系形成闭环、模块间依赖方向合理无循环。GTC 与 EXT 的委托关系和差异已通过 D14/D24 说明。

### 5. 设计质量

**[通过]** 职责划分符合单一职责原则；抽象层次恰当（不包含实现细节，但留有足够的编码指导）；实施批次按拓扑依赖合理编排；便于单元测试（函数库为纯函数，random.cj 用 ThreadLocal 隔离状态）。

## 修改要求（REJECTED 时存在）

### 问题 1 — 一般 · ext/vector_common.cj 使用不存在的 `Vec<L, T, Q>` 类型

- **问题**：§3.2 ext/vector_common.cj（第 371–402 行）中所有函数签名使用 `Vec<L, T, Q>` 作为参数/返回类型，但 CangJie 不支持整数维度泛型参数，且代码库中 `Vec1<T,Q>`~`Vec4<T,Q>` 是四个独立 struct，不存在泛型 `Vec<L, T, Q>`。
- **原因**：此记号若作为简写，会误导编码者尝试使用不存在的类型；若作为设计假设，则类型不可行。
- **建议方向**：在 ext/vector_common.cj 开头或 §1 概述中明确声明 `Vec<L, T, Q>` 是设计级简写记号，表示"对 Vec1~Vec4 各定义一个同构重载"。提供一个具体展开示例（如展示 `min` 如何展开为 Vec1~Vec4 的 4 个重载）。其余 core 函数库（§3.1）已正确使用文字描述"为 Vec1~Vec4 各定义"，应保持此风格一致或采用同一简写约定。

### 问题 2 — 一般 · `std.math.pow` 不提供 Float16 重载导致 generic pow 和 ldexp 不可行

- **问题**：exponential.cj 中 `pow<T>(base: T, exponent: T): T where T <: FloatingPoint<T>` 委托 `std.math.pow`，且 `ldexp<T>(x: T, exp: Int64): T` 的实现路径为 `x * pow(T(2), T(exp))`。但 `std.math.pow` 仅提供 Float32 和 Float64 重载，无 Float16 重载。当 `T = Float16` 时代码无法编译。
- **原因**：设计的约束标注 `T <: FloatingPoint<T>` 允许 Float16，但实现路径不支持该类型，构成设计与实现的矛盾。
- **建议方向**：（a）标注 Float16 pow 为暂不支持（约束收紧为 `T <: FloatingPoint<T> & (T == Float32 | T == Float64)` 或类似方式），或（b）为 Float16 提供回退实现（如 `exp(T(log(a) + log(b)))` 恒等式），或（c）在 §3.1 exponential.cj 职责或设计决策表中新增一条说明 Float16 pow 的约束策略及实现路径。
