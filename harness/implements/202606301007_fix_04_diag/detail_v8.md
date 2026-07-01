# 详细设计（v8）

## 概述

修复 `gtc/ulp.cj` 中 `float_distance` 函数（Float32 和 Float64 两个重载版本）的编译错误。`x.toBits()` 返回位宽类型（`UInt32` / `UInt64`），`as Int32` / `as Int64` 转型在仓颉中返回 `Option`，而非直接转型后的值。`-` 运算符无法在 `Option` 类型上执行，需通过 `.getOrThrow()` 展开 `Option` 获取底层值后再参与算术运算。

该编译错误非 v7 引入，但之前被增量编译掩盖。v7 验证时 `cjpm test` 全量构建暴露了此预存问题。本 v8 修复后全量构建即可通过并确认 P2-5（G9 ±0 符号保留）完成。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `cjglm/src/gtc/ulp.cj:55-57,63-65` | 修改 | `(x.toBits() as Int32)` / `(x.toBits() as Int64)` 后加 `.getOrThrow()` 展开 Option |

## 类型定义

无新增/修改类型。仅修改函数体中的表达式，添加 `.getOrThrow()` 调用以展开 `Option` 类型。

### 被修改的函数

| 函数 | 包路径 | 行号 | 修改前 | 修改后 |
|------|-------|------|--------|--------|
| `float_distance(x: Float32, y: Float32): Int32` | `glm.gtc` | 55-56 | `let a = (x.toBits() as Int32)`<br>`let b = (y.toBits() as Int32)` | `let a = (x.toBits() as Int32).getOrThrow()`<br>`let b = (y.toBits() as Int32).getOrThrow()` |
| `float_distance(x: Float64, y: Float64): Int64` | `glm.gtc` | 63-64 | `let a = (x.toBits() as Int64)`<br>`let b = (y.toBits() as Int64)` | `let a = (x.toBits() as Int64).getOrThrow()`<br>`let b = (y.toBits() as Int64).getOrThrow()` |

### 不变的行为

- `@OverflowWrapping` 属性保持不变（第 52 行、第 60 行）
- NaN/Inf 守卫分支（行 54、行 62）保持不变
- `return` 表达式中的 `abs(a - b)` 保持不变
- 顶部 `import glm.detail.{ abs }` 已存在，无需新增

## 错误处理

`toBits()` 转型为带符号类型时可能溢出（`UInt32` → `Int32` 或 `UInt64` → `Int64`），仓颉 `as` 转型返回 `Option` 以处理此情况。对于 IEEE 754 浮点位模式，最高位为符号位，`UInt32` → `Int32` 和 `UInt64` → `Int64` 的 reinterpret cast 始终成功（位模式保留），因此 `.getOrThrow()` 安全。

## 行为契约

- **前置条件**：无变更
- **后置条件**：无变更（行为完全等价，仅修复编译错误）
- **兼容性**：不影响运行时行为。所有输入（含 NaN/Inf/±0/正常值）的浮点距离计算结果与之前预期一致

## 依赖关系

| 修改文件 | 新增依赖 | 移除了依赖 |
|---------|---------|-----------|
| `gtc/ulp.cj` | 无 | 无（仅修改表达式，`getOrThrow()` 是 `Option` 的标准方法，无需额外 import） |
