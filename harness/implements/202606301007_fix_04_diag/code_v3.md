# 实现报告（v3）

## 概述

实现了 `detail/vector_relational.cj` 缺失的 5 个函数（`equal`、`notEqual`、`any`、`all`、`not_`），每函数 Vec1~Vec4 各一个重载（共 20 个函数体）。同步更新了 `lib.cj` 导出和 `04_diag.md` 修复标记。

## 文件变更清单

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 修改 | `cjglm/src/detail/vector_relational.cj` | 追加 20 个函数重载（5 函数 × 4 维度） |
| 修改 | `cjglm/src/lib.cj:45` | 新增 `equal`/`notEqual`/`any`/`all`/`not_` 导出 |
| 修改 | `docs/diag/impl/04_diag.md:107` | G2 修改方向行追加 `✅ 已修复` |

## 编译验证

`cjpm build` 编译通过，仅输出预存在的警告（未引入新警告或错误）。

## 设计偏差说明

| 设计规格 | 偏差原因 | 实际处理 |
|---------|----------|---------|
| `equal`/`notEqual` 约束为 `T <: Number<T>` | `Number<T>` 在仓颉中**不包含** `Equatable<T>`，仅使用 `Number<T>` 约束无法调用 `==`/`!=` | 实际约束改为 `T <: Number<T> & Equatable<T>`，保留 `Number<T>` 的同时追加 `Equatable<T>` 以获取 `==`/`!=` 运算符 |
