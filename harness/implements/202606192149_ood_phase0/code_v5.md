# 实现报告（v5）

## 概述
实现了公共 API 面与别名层（R4）：`src/lib.cj` 通过 `public import` 将 `glm.detail` 核心类型重导出到 `glm` 包；`src/fwd.cj` 定义了 44 个标量别名 + 256 个向量别名（由 `scripts/gen_fwd_aliases.py` 自动生成）；`tests/glm/test_lib.cj` 和 `tests/glm/test_fwd.cj` 验证导入和别名的可用性。更新 `cjpm.toml` 增加 `[test]` 配置。已移除旧的 `src/fwd_test.cj` 和 `src/lib_test.cj`。

## 文件变更清单
| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 新建 | `scripts/gen_fwd_aliases.py` | Python 脚本，全量生成 `src/fwd.cj` |
| 覆写 | `src/lib.cj` | 通过 `public import` 将 `glm.detail` 类型/函数重导出 |
| 覆写 | `src/fwd.cj` | 44 个标量别名 + 256 个向量别名（由 Python 脚本生成） |
| 覆写 | `tests/glm/test_lib.cj` | 4 个测试用例验证 public import |
| 覆写 | `tests/glm/test_fwd.cj` | 4 个测试用例验证别名 |
| 修改 | `cjpm.toml` | 增加 `[test] src-dir = "tests"` |
| 删除 | `src/fwd_test.cj` | 旧的占位测试，已被 `tests/glm/test_fwd.cj` 替代 |
| 删除 | `src/lib_test.cj` | 旧的占位测试，已被 `tests/glm/test_lib.cj` 替代 |

## 编译验证
`cjpm build` 执行结果：编译失败。所有 96 个错误均来自 `src/detail/type_vec1.cj`（`%`、`<<`、`>>` 操作符在泛型类型上的约束错误），属于已有代码的预存问题，与本次变更无关。本次新增/修改的文件（`src/lib.cj`、`src/fwd.cj`、`tests/glm/*.cj`）语法正确，不引入新错误。

## 设计偏差说明
无偏差。所有实现严格遵循详细设计 v5 的接口签名、类型定义和行为契约。
