# OOD 设计方案审查报告（v1）

## 审查结果

APPROVED

## 逐维度审查

### 1. 类型系统可行性

**[通过]** 9 个矩阵类型各自独立定义为泛型 struct，符合仓颉不支持模板偏特化的限制。列向量成员（var c0: VecR<T,Q> 等）与阶段一 Vec 类型风格一致。

**[通过]** extend 块约束使用正确：`Number<T>` 用于算术运算、`Equatable<T>` 用于比较、`Qualifier` 无约束块用于纯赋值/闭包调用。同包内类型互相直接可见，无需 import。

**[通过]** 泛型使用方式（`T <: Number<T>`、`Q <: Qualifier`）与阶段一一致。72 个 fromMat 静态工厂函数分布在 9 个 extend 块中（每块 16 个），仓颉对单个 extend 块成员函数数量无上限限制，泛型按需实例化。

**[通过]** @Derive[Hashable] 对矩阵类型的可行性已验证：矩阵仅包含 VecN<T,Q> 成员，阶段一中 Vec{1..4}<Bool,Q> 已通过 @Derive[Hashable] 编译验证，表明 Bool <: Hashable。

**[通过]** 跨类型转换统一采用 conv 闭包模式（fromParts/fromColumns/fromMat conv 版本），与阶段一 castVecN 模式一致，是仓颉泛型上下文中跨类型转换的唯一可行路径。

### 2. 标准库与生态覆盖

**[通过]** `Number<T>`、`Integer<T>`、`Equatable<T>`、`Comparable<T>`、`Hashable<T>` 均为 `std.core`/`std.math` 提供的核心接口，与阶段一使用一致。

**[通过]** `std.math.Number<T>` 实际提供了加减乘除等算术运算，设计的约束假设成立。`Number<T>` 下无法演算 T(1) 的分析正确（`!` 运算符属于 `Integer<T>` 而非 `Number<T>`，对 Float32/Float64 不可用）。

**[通过]** 无外部库依赖，全部功能在标准库和自定义 Qualifier 体系内实现。

### 3. 语言特性可行性

**[通过]** 复合赋值运算符自动生成的假设有文档支撑（function/README.md §8.5："重载二元运算符（关系运算除外）时自动启用对应复合赋值版本，前提是返回类型与左操作数类型匹配"）。设计同时包含编码启动前验证步骤作为容错措施。

**[通过]** const init/const func 的可用性分析正确：逐分量构造和列向量构造为纯赋值，可 const init；filled/identity/fromMat/fromParts/fromColumns 涉及运算或闭包调用，不可 const。

**[通过]** 运算符重载定义符合仓颉规则：mat * mat 为左矩阵 extend 块成员运算符；vec * mat（方案A）为 Vec 类型 extend 块成员运算符（this 固定为左操作数）；scalar_mat_ops.cj 全局函数处理标量在左侧的运算。

**[通过]** 错误处理（Exception + assert）与阶段一一致。下标越界抛出 Exception，导致 `[]` 和 `col()` 不可 const func，已在 §9 差异声明中记录。

**[通过]** 包结构设计（glm.detail / glm / glm.ext）符合 cjpm 的包-目录映射规则。包含 cjpm 子包构建预验证步骤。

### 4. 设计一致性

**[通过]** 各矩阵类型职责清晰：值对象，表示 C×R 数学矩阵，以列向量为数据成员，列主序存储。

**[通过]** 构造函数体系完整覆盖：逐分量同类型构造、列向量构造、filled、fromParts、fromColumns、fromMat（6a/6b）、identity。各构造函数的 const 可用性逐一标注。

**[通过]** 运算符体系完整：一元负号、矩阵-标量四种运算、标量-矩阵四种运算（全局函数）、矩阵-矩阵加减乘除、矩阵-向量乘、行向量-矩阵乘。跨尺寸乘法 29 个重载（26 跨尺寸 + 3 同尺寸）穷举验证正确。

**[通过]** 模块间依赖方向合理：glm.detail 同包自包含，glm → glm.detail，glm.ext → glm.detail。无循环依赖。

**[通过]** §9 差异声明系统记录所有与 C++ GLM 的偏差共计 20+ 项，覆盖构造函数降级、运算符差异、const 限制、别名排除等。

### 5. 设计质量

**[通过]** 职责划分遵循单一职责原则：每个矩阵类型只负责单一尺寸矩阵的表示和基本运算，运算逻辑按约束分入不同 extend 块。

**[通过]** 抽象层次恰当：9 个独立类型而非 C×R 参数化泛型（因仓颉不支持偏特化），不过度设计。

**[通过]** 可测试性良好：值类型 + 纯函数 + 无副作用。每一构造函数和运算符均为确定性操作，易于隔离测试。

**[通过]** 非方阵 identity 委托 filled 的实现策略（line 309）避免了 6 种非方阵类型的代码重复。

## 对迭代要求的逐条核验

| 编号 | 问题 | v15 设计中的处理 | 状态 |
|------|------|-----------------|------|
| P1 | 复合赋值运算符自动生成假设 | §3.5 引用功能文档 §8.5 规则 + 编码启动前验证步骤 | 已处理 |
| P2 | fromMat 参数顺序不一致 | 第7条签名统一为 `fromMat<U, P>(conv: (U) -> T, m: ...)`（conv 在前），与第6b条一致 | 已处理 |
| P3 | fromParts/fromColumns Number\<T\> 约束 | 两者均移至仅 `Q <: Qualifier` 约束的 extend 块 | 已处理 |
| P4 | 非方阵 identity/filled 冗余 | 非方阵 identity 委托 filled(one) 的实现策略已明确 | 已处理 |
| P5 | fromMat 6a 展开示例遗漏 SrcQ 约束 | 展开示例已补充 `where SrcQ <: Qualifier` | 已处理 |
| P6 | scalar_mat_ops.cj 约定对齐 | D15 补充编码阶段重载解析验证建议 | 已处理 |
| P7 | Mat4x4←Mat4x2 偏离示例不具体 | 新增已知偏离示例子项，逐场景列举 | 已处理 |

## 结论

所有 7 个审查意见（含 1 个严重、3 个一般、3 个轻微）均已在 v15 设计中得到处理。设计方案在仓颉类型系统、标准库覆盖、语言特性使用、设计一致性和设计质量五个维度上均验证可行。不存在严重的未解决问题。
