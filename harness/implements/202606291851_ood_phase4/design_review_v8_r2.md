# 设计审查报告（v8 r2）

## 审查结果
REJECTED

## 发现

### A.1 src/detail/geometric.cj

- **[一般] normalize Vec2~Vec4 零值检查使用 `==`，但约束不含 `Equatable<T>`**: 设计说明写 `lenSq == T(0)`，但函数约束仅为 `FloatingPoint<T> & Comparable<T>`。仓颉中 `==` 需要 `Equatable<T>`，而 `Comparable<T>` 不提供 `==`（参见 `src/detail/compute_vector_relational.cj`）。现有同包代码 `quaternion_geometric.cj:25` 使用 `len <= zero`（`<=` 来自 `Comparable<T>`）。应统一为 `lenSq <= zero` 以保持行为一致。

### A.2 src/ext/matrix_transform.cj

- **[一般] `T(n)` 字面量构造与项目规范不一致**: rotate 矩阵字面量（第 254-258 行）多处使用 `T(0)`/`T(1)`，但项目规范要求使用 `(Float64(n) as T).getOrThrow()`（见偏差提示第 3 条及 `common.cj` 全部代码均遵循此模式）。同一函数内已正确声明 `let one = (Float64(1) as T).getOrThrow()`，矩阵字面量应复用 `one` 和 `zero`，而非 `T(n)`。

### A.4 src/ext/matrix_projection.cj

- **[一般] pickMatrix 缺少 `zero` 变量声明**: 第 529-534 行的矩阵字面量使用了 `zero`，但在 pickMatrix 函数作用域内未声明该变量（`zero` 仅在 project/unProject 函数中定义，属不同作用域）。需要添加 `let zero = (Float64(0) as T).getOrThrow()`。

## 修改要求

1. **A.1 geometric.cj normalize Vec2~Vec4**: 将零值检查从 `lenSq == T(0)` 改为 `lenSq <= zero`，零向量构造从 `VecN(T(0), ...)` 改为 `VecN(zero, ...)`，其中 `zero` 通过 `(Float64(0) as T).getOrThrow()` 定义。

2. **A.2 ext/matrix_transform.cj rotate**: 移除矩阵字面量中所有 `T(0)`/`T(1)`，使用已声明的 `zero`/`one` 变量替代。

3. **A.4 ext/matrix_projection.cj pickMatrix**: 补充 `zero` 变量声明。
