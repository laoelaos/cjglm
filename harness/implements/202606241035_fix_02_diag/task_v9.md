# 任务指令（v9）

## 动作
NEW

## 任务描述
T9: 补充 stub 测试文件的显式 import

在以下三个文件的首行（`package glm.detail` 之后）各添加两行 `import`，使其与其他测试文件的导入风格一致：

1. `tests/glm/detail/test_common.cj:1` — 当前仅有 `package glm.detail`
2. `tests/glm/detail/test_geometric.cj:1` — 当前仅有 `package glm.detail`
3. `tests/glm/detail/test_geometric_refract.cj:1` — 当前仅有 `package glm.detail`

每个文件在 `package glm.detail` 之后添加：
```
import std.unittest.*
import std.unittest.testmacro.*
```

参考文件：`tests/glm/detail/test_matrix.cj:1-4`（已有正确的导入顺序）。

## 选择理由
Route 表格顺序中的下一个待完成任务（T2 已验证 PASSED）；T9 须在 T10 之前完成（T9 和 T10 共享 `test_common.cj`、`test_geometric.cj`、`test_geometric_refract.cj` 三个文件，并行执行会产生合并冲突）。

## 任务上下文
- 诊断报告 §5 T9 精确定位 3 个文件缺少显式 import
- 项目内其他测试文件（如 `test_matrix.cj:3-4`、`test_scalar_mat_ops.cj:3-4`、`test_type_mat2x2.cj:3-4`）均显式导入这两行
- `std.unittest` 文档 §1.2 说明测试模式下自动导入，非功能性缺陷，仅为代码风格一致性

## 已有代码上下文
- 三个目标文件均以 `package glm.detail` 开头，后续直接是 `@Test` 测试函数
- 贴靠参考：`test_matrix.cj:1-4`:
  ```
  package glm.detail

  import std.unittest.*
  import std.unittest.testmacro.*
  ```
- 不涉及行为、测试通过率或测试逻辑变更
