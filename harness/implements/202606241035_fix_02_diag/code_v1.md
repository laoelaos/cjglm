# 实现报告（v1）

## 概述

修改 `test_integration_matrix.cj` 中 `testIntegrationFromMatDeviation` 函数的 4 个 `@Expect` 断言预期值，并补充缺失的 3 个列向量分量断言，使其与 OOD §3.3 的 DEVIATION 行为一致。

## 文件变更清单

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 修改 | `cjglm/tests/glm/test_integration_matrix.cj` | 修正 `testIntegrationFromMatDeviation` 的预期断言值 |

## 编译验证

`cjpm build` 成功，无新增错误。

## 设计偏差说明

无偏差。
