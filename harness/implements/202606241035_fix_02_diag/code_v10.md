# 实现报告（v10）

## 概述

将 `tests/glm/detail/` 下 4 个测试文件中全部 38 处 `@ExpectThrows[Exception](...)` 替换为 `try-catch` 块，在验证异常类型的同时验证异常消息内容为 `"stub"`。

## 文件变更清单

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 修改 | `tests/glm/detail/test_common.cj` | 替换 12 处 stub 测试 |
| 修改 | `tests/glm/detail/test_geometric.cj` | 替换 17 处 stub 测试 |
| 修改 | `tests/glm/detail/test_geometric_refract.cj` | 替换 3 处 stub 测试 |
| 修改 | `tests/glm/detail/test_matrix.cj` | 替换 6 处 stub 测试 |

## 编译验证

`cjpm build` — 编译成功。无新增 warning。

## 设计偏差说明

无偏差。严格按详细设计模板替换。
