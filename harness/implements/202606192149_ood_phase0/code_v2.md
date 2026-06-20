# 实现报告（v2）

## 概述
实现了 OOD Phase0 R2 02 核心抽象层，包含 ComputeEqual\<T\>/ComputeEqualNumeric\<T\> 相等比较策略、Functor 映射体系（16 个结构体）、ComputeVec* 运算策略体系（52 个结构体），以及 Vec1~Vec4 最小桩类型（Strategy B）。共创建 8 个文件。

## 文件变更清单
| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 新建 | `src/detail/type_vec_stubs.cj` | Vec1~Vec4 最小桩类型（仅 var 成员 + init 构造函数），Strategy B 临时文件 |
| 新建 | `src/detail/compute_vector_relational.cj` | ComputeEqual\<T\> + ComputeEqualNumeric\<T\> |
| 新建 | `src/detail/vectorize.cj` | Functor1Vec1~Functor2VecIntVec4 共 16 个结构体 |
| 新建 | `src/detail/compute_vector_decl.cj` | ComputeVec* 13 策略族 × 4 分量数 = 52 个结构体 |
| 新建 | `src/detail/compute_vector_relational_test.cj` | ComputeEqual 单元测试（Int32/Float32/Float64/Bool） |
| 新建 | `src/detail/vectorize_test.cj` | Functor 实例化和一元/二元映射功能验证 |
| 新建 | `src/detail/compute_vector_decl_test.cj` | ComputeVec* 实例化和逐分量运算验证 |

## 编译验证
`cjpm build` 成功，`cjpm test` 全部 53 个用例 PASS（含已有 22 个 + 本轮新增 31 个）。

## 设计偏差说明
| 设计规格 | 偏差原因 | 实际处理 |
|---------|---------|---------|
| ComputeVec* 各 struct 的 where 约束仅 `Q <: Qualifier`，未约束 T | Cangjie 类型系统要求：`+` `-` `*` `/` 需 `Number<T>`，`%` `&` `|` `^` `!` `<<` `>>` 需 `Integer<T>`，`==` `!=` 需 `Equatable<T>`，`<` `<=` 需 `Comparable<T>` | 按实际所需运算符添加对应约束：算术族用 `T <: Number<T>`，位运算族用 `T <: Integer<T>`，比较族用 `T <: Equatable<T>` |
| `compute_vec_shift_left/right{N}` 签名：`b: VecN<T, Q>` | Cangjie `Integer<T>::<<(n: Int64)` / `>>(n: Int64)` 的 RHS 为 `Int64`，非 `T` | 改为 `b: VecN<Int64, Q>`，与 Cangjie 标移位运算符签名对齐 |
| `compute_vec_shift_left/right{N}` 内部运算委托给 Functor2VecIntVecN | `Functor2VecIntVecN.call(callable, v, i)` 的 `i` 为标量 `Int64`，非向量 | 改为直接逐分量构造 VecN（仍遵循策略模式，未使用 Functor） |
| `ComputeEqualNumeric.callConst` 使用 `std.math.abs(a - b)` | `std.math.abs` 为 7 个具体类型的独立重载，非泛型函数，无法对 `T <: Number<T>` 调用 | 手动实现绝对值：`diff < zero ? -diff : diff`（利用 `Number<T>` 的 `-` 一元运算和 `Comparable<T>` 的 `<`） |
| `ComputeEqualNumeric.callConst` 约束仅为 `T <: Number<T>` | `==` 需 `Equatable<T>`，`<` `<=` 需 `Comparable<T>` | 改为 `T <: Number<T> & Equatable<T> & Comparable<T>` |
| `compute_vec_equal/nequal{N}` 内部运算未通过 Functor 委托 | `Functor2VecN` 为同质映射 `(T,T)->T`，无法产生 `VecN<Bool,Q>` | 直接逐分量构造 `VecN<Bool,Q>`，在报告中标注偏差 |
| 未创建 VecN 类型文件 | VecN 类型在依赖链中前向引用，尚无实现 | 按 Strategy B 创建 `type_vec_stubs.cj` 临时桩，含 4 个 VecN 的最小定义（仅 `var` 成员 + `init`），待 Vec 层实现时删除或替换 |
