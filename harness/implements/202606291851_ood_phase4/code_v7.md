# 实现报告（v7）

## 概述

将 `src/detail/matrix.cj` 中 6 个 stub（`determinant` Mat2x2/Mat3x3/Mat4x4 + `inverse` Mat2x2/Mat3x3/Mat4x4）替换为完整实现。修改 `tests/glm/detail/matrix_test.cj` 中对应的 6 个 stub 测试为 18 个真实测试覆盖。

## 文件变更清单

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 修改 | `src/detail/matrix.cj` | 替换 6 个 stub 为完整实现；`inverse` 约束从 `Number<T>` 改为 `FloatingPoint<T>`；追加 `import FloatingPoint` |
| 修改 | `tests/glm/detail/matrix_test.cj` | 替换 6 个 stub 测试为 18 个真实测试用例 |

## 编译验证

`cjpm build` success（仅 warnings，无 errors）；`cjpm test` 全部 435 tests PASSED / 0 FAILED。

## 设计偏差说明

1. **`T(Float64(1))` 不可编译**：设计规格使用 `T(Float64(1))` 构造泛型字面量 1，但仓颉编译器报 `'()' is not a static member of exposed generic parameter 'T'`。改用项目已存在模式 `(Float64(1) as T).getOrThrow()` 解决，与 `common.cj` 中 `let o: T = (Float64(1) as T).getOrThrow()` 一致。
