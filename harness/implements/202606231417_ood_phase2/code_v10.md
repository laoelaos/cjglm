# 实现报告（v10）

## 概述

新建 `tests/glm/test_integration_matrix.cj`，通过 `glm` 包的 public API（fwd.cj 别名 + lib.cj re-export）实现了 40 个集成测试用例，覆盖全部 9 种矩阵类型（Mat2x2~Mat4x4）及其 DMat 对应类型的 7 个测试维度。

## 文件变更清单

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 新建 | `tests/glm/test_integration_matrix.cj` | 矩阵集成测试，40 用例，7 个维度 |

## 编译验证

`cjpm build` 成功，`cjpm test` 全部 476 个测试 PASSED（包含新增 40 个）。

## 设计偏差说明

1. **`testIntegrationCrossSizeMatMul` 第三组**：设计规格 `Mat2x2×Mat2x4→Mat2x4` 维度不匹配（Mat2x2 2列 × Mat2x4 4行，内维 2≠4）。已替换为 `Mat4x4×Mat2x4→Mat2x4`（Mat4x4 有 `*(Mat2x4)` 运算符）。

2. **`testIntegrationMatMulChain`**：设计规格 `Mat2x2×Mat2x4×Mat4x2` 中 `Mat2x2×Mat2x4` 维度不匹配。已替换为 `Mat2x2×Mat3x2×Mat2x3` 链（各步均有运算符支持，结果类型为 Mat2x2）。

3. **`testIntegrationScalarLeftMul`**：设计称"成员运算符"，但标量×Mat 无 `*` 运算符重载。使用 lib.cj re-export 的 `mul(s, m)` 函数实现。

其他设计规格均严格遵循。
