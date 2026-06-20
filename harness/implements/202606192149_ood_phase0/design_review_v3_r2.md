# 设计审查报告（v3 r2）

## 审查结果
REJECTED

## 发现

- **[严重]** 所有算术/位/比较/具名函数运算符依赖对 T 的运算符操作（如 `this.x + rhs.x`、`!this.x`、`ComputeEqual<T>.call(this.x, rhs.x)`、`T(1)` 等），但 Vec 结构体对泛型参数 T 无任何约束。仓颉语言泛型约束规则明确：**无约束的泛型参数只能传递/返回，不能进行任何运算符操作**（见 `.opencode/skills/cangjie-lang-features/generic/README.md` §7.1）。这将导致以下所有定义在编译时失败：

  - Vec1~Vec4 struct 体内的二元算术运算符（`+` `-` `*` `/` `%`）和一元 `-` 运算符，其实现体 `this.x + rhs.x` 等要求 `T <: Number<T>`
  - extend 块中的位运算符（`&` `|` `^` `<<` `>>` `bitwiseNot`），实现体 `this.x & rhs.x` 等要求 `T <: Integer<T>`
  - extend 块中的比较运算符（`==`），委托 `ComputeEqual<T>.call` 要求 `T <: Equatable<T>`
  - extend 块中的 `equalExact`/`equalEpsilon`，分别要求 `T <: Equatable<T>` 和 `T <: Number<T> & Equatable<T> & Comparable<T>`
  - extend 块中的 `increment`/`decrement`，实现体 `this + T(1)` 要求 `T <: Number<T>` 且 T 支持从整数构造
  - extend 块中的 `add`/`sub`/`mul`/`div`/`mod`，委托给二元运算符，间接要求 `T <: Number<T>`
  - extend 块中的 `logicalAnd`/`logicalOr`，实现体 `this.x && other.x` 要求 T == Bool
  - Vec1→VecN 和 VecN→Vec1 广播运算符，同样依赖 T 的运算符

  **修正方向**：将所有运算符和具名函数从 struct 体移至 extend 块，每个 extend 块按所需运算符添加对应的泛型约束：

  - 算术运算符 extend：`extend<T, Q> VecN<T, Q> where T <: Number<T>, Q <: Qualifier { + - * / % 一元- increment/decrement add/sub/mul/div/mod }`
  - 位运算 extend：`extend<T, Q> VecN<T, Q> where T <: Integer<T>, Q <: Qualifier { & | ^ << >> bitwiseNot }`
  - 比较 extend：`extend<T, Q> VecN<T, Q> where T <: Equatable<T>, Q <: Qualifier { == != equalExact }`
  - epsilon 比较 extend：`extend<T, Q> VecN<T, Q> where T <: Number<T> & Equatable<T> & Comparable<T>, Q <: Qualifier { equalEpsilon }`
  - Bool 逻辑运算 extend：`extend<Q> VecN<Bool, Q> where Q <: Qualifier { logicalAnd logicalOr }`
  - Vec struct 体仅保留：数据成员、构造函数、`length()`、`operator[]`（取值+赋值）、`componentAt`（这些不依赖对 T 的运算符操作）

- **[严重]** `increment()`/`decrement()` 实现 `this + T(1)` 中的 `T(1)` 表达式要求 T 具有接受 `Int64` 的构造函数，无约束 T 无法通过编译。修正方向同上。

## 修改要求

所有问题共享同一根因：**Vec 结构体泛型参数 T 无约束，但运算符实现体要求对 T 执行受限操作**。必须将全部运算符从 struct 体和无约束 extend 块移至带正确约束的 extend 块中，具体约束分布如上所述。

此修正会影响以下设计文档位置的全体现有运算符签名：
- detail_v3.md §类型定义（Vec1~Vec4）struct 体内的算术运算符
- detail_v3.md §类型定义 Vec1 extend 块中的广播运算符
- detail_v3.md §类型定义 Vec2/3/4 extend 块中的 Vec1 广播和位运算
- detail_v3.md §行为契约中的运算符相关条目
- detail_v3.md §Vec 关键设计约束的第 4/5/6/7/8/9 条
