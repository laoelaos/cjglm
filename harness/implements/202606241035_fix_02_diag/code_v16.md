# 实现报告（v16）

## 概述

实现 T13 验证方案的模式 A（零侵入）：在 `src/ext/` 下创建最小验证文件 `test_ext_alias.cj`，执行 `cjpm build` 验证子包路由机制。

## 文件变更清单

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 新建 | `src/ext/test_ext_alias.cj` | 最小验证文件：声明 `package glm.ext` + 导出简单函数 |

## 编译验证

`cjpm build` 退出码为 0。模式 A 验证通过，确认 cjpm 正确发现 `src/ext/` 子包并编译 `package glm.ext`。

## 设计偏差说明

无偏差。
