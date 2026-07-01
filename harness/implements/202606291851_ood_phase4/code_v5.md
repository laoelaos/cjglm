# 实现报告（v5）

## 概述

修复 `src/detail/trigonometric.cj` 中 `asin`/`acos` 编译错误，恢复越界保护域检查。采纳审查意见后，采用 Float64 转换比较方案替代原 `T(1)` 语法，同时保持 `FloatingPoint<T>` 单一约束。

## 文件变更清单
| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 修改 | src/detail/trigonometric.cj | asin/acos 标量重载：恢复越界保护，使用 `let xF64: Float64 = (x as Float64).getOrThrow(); if (xF64 < -1.0 \|\| xF64 > 1.0) { return T.getNaN() }` 替代 `T(1)` |
| 修改 | docs/deviations.md | 将 IMPL-07 移入「五、未验证的偏差删除」— 越界保护已恢复，该偏差不再成立 |

## 编译验证
`cjpm build` success（仅预存 warnings，未引入新 warning）

## 设计偏差说明
无偏差。

设计规格要求保留越界保护、替换 `T(1)` 语法。本实现将比较操作迁移到 `Float64` 域（`(x as Float64).getOrThrow()`），在 `FloatingPoint<T>` 单一约束下即可编译，无需添加 `Comparable<T>`。行为等价：`asinT`/`acosT` 底层 `std.math.asin`/`acos` 为超越范围返回 NaN，与提前返回 `T.getNaN()` 一致。

## 修订说明（v5 R1）
| 审查意见 | 修改措施 |
|---------|---------|
| 标量 asin/acos 偏离设计，移除了越界保护 | 恢复越界保护，使用 `(x as Float64).getOrThrow()` 在 Float64 域比较，不走 `T(1)` 语法也不需 `Comparable<T>` 约束 |
| docs/deviations.md 缺失（声称的路径 `cjglm/docs/deviations.md` 不存在） | 实际文件位于 `docs/deviations.md`（已存在）。将 v5 旧实现添加的 IMPL-07 移入「未验证的偏差删除」——越界保护已恢复，该偏差不再成立 |
