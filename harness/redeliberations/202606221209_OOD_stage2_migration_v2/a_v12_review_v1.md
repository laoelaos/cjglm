# OOD 设计方案审查报告（v23）

## 审查结果

REJECTED

## 逐维度审查

### 1. 类型系统可行性

**[通过]** 9 个独立泛型结构体（Mat2x2~Mat4x4）的类型形态选择与 Cangjie struct 值语义匹配，各类型以 `var c0: VecR<T,Q>` 为列向量成员，与阶段一 Vec 类型的设计模式一致

**[通过]** 继承/实现关系（Q <: Qualifier）与 Cangjie 单继承多接口实现的约束范围一致

**[通过]** 泛型约束 `T <: Number<T>`、`T <: Equatable<T>`、`Q <: Qualifier` 等均已在现有 Vec 类型代码中验证可行

**[通过]** extend 块中的静态泛型工厂函数（identity、filled、fromParts、fromMat）在 Cangjie 语言能力范围内（generic §2.2(e) 明确支持 extend 中定义静态泛型函数）

**[通过]** 运算符重载（算术/比较）在 extend 块中实现的模式与 Vec 类型一致

**[通过]** @Derive[Hashable] 在泛型结构体上的使用与 Vec1 一致

**[通过]** const init 逐分量构造与 Vec1 的 `public const init(x: T)` 模式一致

**[通过]** fromMat 6a/6b/7 的签名设计（含跨 Qualifier 的泛型参数 P）在 Cangjie 泛型系统能力范围内

**[通过]** Bool 矩阵的限制范围（不实现 Number<T>，不支持算术/identity/filled/equalEpsilon）与 Cangjie 类型约束逻辑一致

**[一般]** fromParts 签名表中所有 9 个矩阵类型的 `fromParts<U, P>` 均声明了类型参数 `P`，但 `P` 未在任何参数类型或返回类型中使用（与 fromColumns 不同——fromColumns 中 P 用于 `VecR<U,P>` 的 Qualifier 参数）。Cangjie 要求函数级类型参数须在函数签名中使用（generic §2.2 及 extend §2.3 的类型参数使用规则），未使用的 `P` 将导致编译错误。**解决方法**：将 `fromParts` 签名中的 `<U, P>` 简化为 `<U>`，移除 `P` 参数及 `where P <: Qualifier` 约束。

**[轻微]** fromMat 6a/6b/7 的 where 子句在各条目中写为函数级约束（如 `where T <: Number<T>, Q <: Qualifier, P <: Qualifier`），但 `T` 和 `Q` 的约束实际应在 extend 块级声明（而非函数级）。函数级约束应仅声明新引入的泛型参数（如 `P <: Qualifier` 或 `U` 的约束）。当前写法不影响可行性但可能误导实现者。

### 2. 标准库与生态覆盖

**[通过]** Number<T>、Equatable<T>、Comparable<T>、Hashable 等核心接口均来自 `std.math` 和自动导入的 `std.core`

**[通过]** @OverflowWrapping/@Derive[Hashable] 等注解均为标准库/编译器内置能力

**[通过]** 设计未假设任何外部库能力

### 3. 语言特性可行性

**[通过]** 错误处理策略（下标越界抛 Exception、stub 函数抛 Exception）与 Cangjie 异常处理机制一致

**[通过]** 并发设计——本阶段不引入并发，值类型天然线程安全

**[通过]** T(0) 通过 `Number<T>` 约束下的 `someValue - someValue` 演算，策略正确（已在 Vec 类型中验证）

**[通过]** T(1) 通过参数显式传入，因 `Number<T>` 接口内无通用演算路径，策略正确

**[通过]** 包组织（glm.detail / glm / glm.ext）符合 Cangjie 包声明规则，ext/ 子包方案已有原型验证计划

### 4. 设计一致性

**[通过]** 各矩阵类型的职责描述清晰（值对象、列主序存储、列向量成员等）

**[通过]** fromMat 6a/6b/7 的三分法及各自的行为契约（填充规则、T(0)/T(1) 获取策略）形成闭环

**[通过]** B 类方向与非 B 类方向的 GLM 对照分析完整，偏差已记录并有编码阶段处理方案

**[通过]** 模块间依赖方向合理（detail → type_vecN，无循环依赖）

**[通过]** 复合赋值运算符的手动定义回退方案完整（60 个运算符的分布表）

### 5. 设计质量

**[通过]** 职责划分遵循单一职责原则——每个矩阵类型是一个独立的值对象

**[通过]** 抽象层次恰当——架构级设计，未过度包含实现细节

**[通过]** 设计便于后续详细设计——每个函数有明确签名和行为契约

**[通过]** 设计便于单元测试——值类型、无副作用、运算符返回新实例

## 修改要求（REJECTED 时存在）

### 问题 1（一般）：fromParts 签名中类型参数 P 未使用

- **问题**：所有 9 个矩阵类型的 `fromParts<U, P>` 声明了泛型参数 `P`，但 `P` 未出现在任何参数类型（参数均为 `conv: (U) -> T` 和 `a{列}{行}: U`）或返回类型（`Mat{C}x{R}<T,Q>`）中。仅 `where P <: Qualifier` 约束了 P，但 P 本身未被使用。
- **原因**：Cangjie 语言要求函数级声明（包括 extend 块中的成员函数）的类型参数必须在函数签名中实际使用（generic §2.2 和 extend §2.3 的类型参数使用规则）。未使用的 P 会导致编译错误。
- **建议方向**：直接从 `fromParts` 签名中移除类型参数 `P`：将 `public static func fromParts<U, P>` 改为 `public static func fromParts<U>`，删除 `where P <: Qualifier` 约束。`P` 在 fromParts 中没有实际用途（与 fromColumns 不同——fromColumns 中 P 用于列向量的 Qualifier 参数）。若需对称性，也可在 §7 设计决策中记录此差异。
