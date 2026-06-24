# 实现报告（v12）

## 概述
为 9 个矩阵类型文件（type_mat2x2 ~ type_mat4x4）各追加两个 extend 块，实现了 `==`/`!=`/`equalExact`（Equatable 约束）和 `equalEpsilon`（Number&Equatable&Comparable 约束）。同步创建了 `test_type_mat_compare.cj` 测试文件覆盖所有 9 种矩阵类型的比较操作。

## 文件变更清单
| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 修改 | src/detail/type_mat2x2.cj | 追加 Equatable 和 Numerical 两个 extend 块 |
| 修改 | src/detail/type_mat2x3.cj | 同上 |
| 修改 | src/detail/type_mat2x4.cj | 同上 |
| 修改 | src/detail/type_mat3x2.cj | 同上 |
| 修改 | src/detail/type_mat3x3.cj | 同上 |
| 修改 | src/detail/type_mat3x4.cj | 同上 |
| 修改 | src/detail/type_mat4x2.cj | 同上 |
| 修改 | src/detail/type_mat4x3.cj | 同上 |
| 修改 | src/detail/type_mat4x4.cj | 同上 |
| 新建 | tests/glm/detail/test_type_mat_compare.cj | 覆盖 9 种矩阵类型的 ==/!=/equalExact/equalEpsilon 及 Bool 矩阵比较 |

## 编译验证
`cjpm build` 成功，0 error，仅产生预存的 warning（unused variables / import conflicts / shadowed imports，与本次修改无关）。

## 设计偏差说明
无偏差。严格按详细设计规格实现：
- `==` / `equalExact` 委托 `ComputeEqual<T>.call` 逐分量列主序比较
- `!=` 为 `==` 的逻辑取反
- `equalEpsilon` 委托 `ComputeEqualNumeric<T>.callConst` 逐分量列主序比较
- 测试用例覆盖全部 9 种矩阵类型的 Float32 和 Bool 变体
