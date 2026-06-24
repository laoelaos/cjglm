# 测试报告（v1）

## 概述

为 `Mat4x4.fromMat(Mat4x2, one)` DEVIATION 行为编写专用单元测试，覆盖正常路径、边界条件和零值源输入，对 6a（同类型）和 6b（带转换函数）两种变体分别独立验证。

## 文件变更清单

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 新增 | `cjglm/tests/glm/detail/test_from_mat_deviation.cj` | `Mat4x4.fromMat(Mat4x2, *)` DEVIATION 行为单元测试 |

## 测试用例清单

| 测试函数 | 变体 | 维度 | 验证要点 |
|---------|------|------|---------|
| `testFromMatDeviation6aMat4x2FullContract` | 6a | 正常路径 | col 0-1 保留源数据，col 2-3 为 identity |
| `testFromMatDeviation6aMat4x2OneIsZero` | 6a | 边界条件 | `one = 0` 时 col 2-3 全零 |
| `testFromMatDeviation6aMat4x2OneIsNegative` | 6a | 边界条件 | `one = -1` 时 identity 值为 -1 |
| `testFromMatDeviation6aMat4x2AllZeroSource` | 6a | 边界条件 | 源矩阵全零时 col 0-1 为零 |
| `testFromMatDeviation6bMat4x2FullContract` | 6b | 正常路径 | 带 conv 时 col 0-1 保留，col 2-3 为 identity |
| `testFromMatDeviation6bMat4x2OneIsZero` | 6b | 边界条件 | `one = 0` 时 col 2-3 全零 |
| `testFromMatDeviation6bMat4x2AllZeroSource` | 6b | 边界条件 | 源全零 + conv 时 col 0-1 为零 |

## 验证依据

- 全部测试用例预期值与 `type_mat4x4.cj:235-239`（6a 实现）、`:287-291`（6b 实现）的 DEVIATION 行为一致
- 正常路径用例预期值与已有单元测试 `test_type_mat4x4.cj:633-653`（6a）、`:837-857`（6b）一致
- 边界条件用例验证 `one` 参数变化时 identity 值的正确传播

## 设计偏差说明

无偏差。
