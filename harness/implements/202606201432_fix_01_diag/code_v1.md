# 实现报告（v1）

## 概述

修改 `src/detail/setup.cj`，将 7 个 `public let` 配置常量替换为 `public const`。

## 文件变更清单
| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 修改 | `src/detail/setup.cj:3-9` | 7 行 `public let` → `public const`，初始化表达式改为纯字面量 |

## 编译验证
`cjpm build` 成功（4 个预存 warning，均与本次修改无关）。  
`cjpm test` 成功，303/303 全部 PASSED，包括 `setup_test.cj` 中所有版本和配置常量测试。

## 设计偏差说明
| 设计规格 | 偏差原因 | 实际处理 |
|---------|---------|---------|
| `public const GLM_VERSION_MAJOR: Int64 = Int64(1)` | `Int64(n)` 构造函数无 `const init`，不能作为 const 表达式编译 | 改为 `public const GLM_VERSION_MAJOR: Int64 = 1`，利用 `Int64` 类型注解自动推断字面量类型 |
| 同上，其余 6 个 Int64/Bool 常量 | 同上 | 分别替换为纯整数/布尔字面量（`0`, `3`, `103`, `false`, `false`, `false`） |

运行时值完全等价，仅消除对 `Int64()` 构造函数的运行时调用依赖。
