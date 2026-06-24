# 测试报告（v2）

## 概述

为 8 个矩阵类型 skeleton 结构体编写单元测试，覆盖 Mat2x3、Mat2x4、Mat3x2、Mat3x3、Mat3x4、Mat4x2、Mat4x3、Mat4x4 的公开行为契约。

## 文件变更清单

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 新建 | tests/glm/detail/test_type_mat2x3.cj | Mat2x3<T,Q> 单元测试 |
| 新建 | tests/glm/detail/test_type_mat2x4.cj | Mat2x4<T,Q> 单元测试 |
| 新建 | tests/glm/detail/test_type_mat3x2.cj | Mat3x2<T,Q> 单元测试 |
| 新建 | tests/glm/detail/test_type_mat3x3.cj | Mat3x3<T,Q> 单元测试 |
| 新建 | tests/glm/detail/test_type_mat3x4.cj | Mat3x4<T,Q> 单元测试 |
| 新建 | tests/glm/detail/test_type_mat4x2.cj | Mat4x2<T,Q> 单元测试 |
| 新建 | tests/glm/detail/test_type_mat4x3.cj | Mat4x3<T,Q> 单元测试 |
| 新建 | tests/glm/detail/test_type_mat4x4.cj | Mat4x4<T,Q> 单元测试 |

## 测试覆盖

每个测试文件包含以下用例：

| 测试维度 | 用例 | 验证点 |
|---------|------|--------|
| 正常路径 - 标量填充 | test{C}x{R}ScalarInit | 每个列向量的所有分量均被设为 scalar |
| 正常路径 - 逐分量 | test{C}x{R}ConstInitElementwise | 列主序参数正确映射到各列向量的各行 |
| 正常路径 - 列向量 | test{C}x{R}ConstInitColumn | 列向量参数与数据成员一一对应 |
| 正常路径 - length | test{C}x{R}Length | length() 返回正确的列数 C |
| 正常路径 - 下标取值 | test{C}x{R}IndexAccess | `[]` 返回每个有效下标的列向量 |
| 正常路径 - 下标赋值 | test{C}x{R}IndexMutate | `[]` 赋值后通过 `[]` 读回验证 |
| 正常路径 - col 访问 | test{C}x{R}ColAccess | col() 返回每个有效下标的列向量 |
| 错误路径 - 越界 | test{C}x{R}IndexOutOfBounds | 下标 == C 时抛出 Exception |
| 错误路径 - 负下标 | test{C}x{R}NegativeIndex | 下标 == -1 时抛出 Exception |
| 状态交互 | test{C}x{R}MutateThenRead | 通过 `[]` 赋值后通过 col() 读回验证 |

## 测试风格

遵循项目已有测试惯例：`package glm.detail`、`@Test` 函数标识、`@Expect` 断言、`try/catch` 异常断言。

## 设计偏差说明

无偏差。测试覆盖与详细设计 v2 行为契约完全一致。
