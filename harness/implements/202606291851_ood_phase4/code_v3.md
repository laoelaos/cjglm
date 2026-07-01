# 实现报告（v3）

## 概述

修复 R2 回归：修正 `src/detail/stdmath_shim.cj` 中因同包函数名遮蔽导致的无限递归问题。通过移除与 `exponential.cj`/`common.cj` 同名的 `std.math` 函数导入项，改用 `math.xxx()` 包别名限定名调用标准库函数，消除名称解析歧义。

## 文件变更清单

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 修改 | src/detail/stdmath_shim.cj | 移除冲突的 `std.math` 函数导入，改用 `import std.math as math` 包别名 + `math.xxx()` 全限定调用 |

## 编译验证

`cjpm build` 零错误，`cjpm test` 全部 435 项测试 PASSED（0 ERROR、0 FAILED），包含 7 个 quat_cast 测试。

## 设计偏差说明

| 设计规格 | 偏差原因 | 实际处理 |
|---------|---------|---------|
| 使用 `std.math.sqrt(...)` 全限定名调用 | 仓颉不支持 `std.math.sqrt(...)` 点号路径作为调用限定符——`std.math` 是包名而非命名空间路径 | 改用 `import std.math as math` + `math.sqrt(...)` 模式。`FloatingPoint` 类型仍需单独 `import std.math.FloatingPoint` 用于 where 子句 |

## 修订说明（v3 R1）

| 审查意见 | 修改措施 |
|---------|---------|
| v2 验证失败：R2 引入回归，`stdmath_shim.cj` 函数名被同包函数遮蔽，导致 quat_cast 测试 StackOverflowError | 全量修改 `stdmath_shim.cj`：移除与 common/exponential 同名的 `std.math` 函数导入项，改用 `import std.math as math` 包别名 + `math.xxx()` 限定名调用 |
