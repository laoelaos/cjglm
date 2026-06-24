# 详细设计（v12）

## 概述
在 `test_integration_matrix.cj` 末尾追加 `testIntegrationFromMatRowShrink` 测试函数，覆盖纯 `rowSh`（仅行收缩）模式的 fromMat 集成测试：`Mat4x4→Mat4x3`。

## 文件规划
| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `tests/glm/test_integration_matrix.cj` | 编辑（追加到文件末尾 `:565` 之后） | 添加 `testIntegrationFromMatRowShrink` 集成测试函数 |

## 类型定义
不涉及新类型定义。

## 错误处理
不涉及自定义错误处理。测试函数使用 `@Expect` 宏断言，测试失败由 unittest 框架报告。

## 行为契约
### testIntegrationFromMatRowShrink
- **前置条件**：`Mat4x4`、`Mat4x3` 类型已定义，`Mat4x3.fromMat(Mat4x4, one: T)` 已实现
- **测试数据**：`Mat4x4<Float32>` 列主序布局，c0=(1,2,3,4), c1=(5,6,7,8), c2=(9,10,11,12), c3=(13,14,15,16)
- **调用**：`Mat4x3.fromMat(m44, Float32(1.0))`
- **预期结果（RowShrink R=4→3，截断每列末行）**：
  - `m.c0` = Vec3(1.0, 2.0, 3.0)
  - `m.c1` = Vec3(5.0, 6.0, 7.0)
  - `m.c2` = Vec3(9.0, 10.0, 11.0)
  - `m.c3` = Vec3(13.0, 14.0, 15.0)
- **断言方式**：使用 `@Expect` 逐分量断言，共 12 个断言（4 列 × 3 分量）
- **后置条件**：无副作用

## 依赖关系
- 依赖：`Mat4x4`、`Mat4x3` 类型定义及其 `fromMat` 方法（`src/detail/type_mat4x3.cj:197-200`）
- 不依赖外部模块或额外数据
- 暴露给后续任务：无（仅追加测试函数，不修改公共接口）
