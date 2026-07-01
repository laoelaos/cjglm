# 实现报告（v8）

## 概述
修复 `gtc/ulp.cj` 中 `float_distance` 函数（Float32 和 Float64 两个重载版本）的编译错误。`x.toBits()` 返回 `UInt32`/`UInt64`，`as Int32`/`as Int64` 转型在仓颉中返回 `Option`，需通过 `.getOrThrow()` 展开后再参与 `-` 运算。

## 文件变更清单
| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 修改 | `cjglm/src/gtc/ulp.cj:55-56` | `x.toBits() as Int32` → `(x.toBits() as Int32).getOrThrow()` |
| 修改 | `cjglm/src/gtc/ulp.cj:63-64` | `x.toBits() as Int64` → `(x.toBits() as Int64).getOrThrow()` |

## 编译验证
`cjpm build` 成功，无新增 warning/error。

## 设计偏差说明
无偏差。
