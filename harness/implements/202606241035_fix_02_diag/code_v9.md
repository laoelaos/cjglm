# 实现报告（v9）

## 概述
为三个 stub 测试文件补充 `import std.unittest.*` 和 `import std.unittest.testmacro.*`，使其与 `test_matrix.cj` 的导入风格一致。

## 文件变更清单
| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 编辑 | `tests/glm/detail/test_common.cj` | `package` 后添加 2 行 import |
| 编辑 | `tests/glm/detail/test_geometric.cj` | `package` 后添加 2 行 import |
| 编辑 | `tests/glm/detail/test_geometric_refract.cj` | `package` 后添加 2 行 import |

## 编译验证
cjpm build success（仅 pre-existing warnings，无新增 warning/error）

## 设计偏差说明
无偏差
