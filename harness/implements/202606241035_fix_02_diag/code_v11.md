# 实现报告（v11）

## 概述

在 `test_type_mat3x3.cj` 和 `test_type_mat4x4.cj` 末尾各追加 2 个 `@Test` 函数，测试 `col()` 方法的越界和负数索引边界场景。

## 文件变更清单

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 修改 | `tests/glm/detail/test_type_mat3x3.cj` | 追加 `testMat3x3ColOutOfBounds` / `testMat3x3ColNegative` |
| 修改 | `tests/glm/detail/test_type_mat4x4.cj` | 追加 `testMat4x4ColOutOfBounds` / `testMat4x4ColNegative` |

## 编译验证

`cjpm build` 成功，无新增警告或错误。

## 设计偏差说明

无偏差。
