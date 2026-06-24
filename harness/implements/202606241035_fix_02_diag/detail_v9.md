# 详细设计（v9）

## 概述
为三个 stub 测试文件补充显式 `import` 语句，使其与其他测试文件（如 `test_matrix.cj`）的导入风格一致。不影响测试行为或通过率。

## 文件规划
| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `tests/glm/detail/test_common.cj` | 编辑 | 在 `package glm.detail` 后添加两行 import |
| `tests/glm/detail/test_geometric.cj` | 编辑 | 在 `package glm.detail` 后添加两行 import |
| `tests/glm/detail/test_geometric_refract.cj` | 编辑 | 在 `package glm.detail` 后添加两行 import |

## 类型定义
无新增类型。

## 错误处理
无变更。仅添加 import 语句，不影响错误处理逻辑。

## 行为契约
- 三个文件的 `package` 声明保持不变
- `package` 与第一个 `@Test` 之间插入空行 + `import std.unittest.*` + `import std.unittest.testmacro.*`，参考 `test_matrix.cj` 格式
- 不修改任何函数体、签名、注释或其他内容

## 依赖关系
- 依赖 `std.unittest` 和 `std.unittest.testmacro` 标准库包
- 不暴露新接口，不引入新依赖
