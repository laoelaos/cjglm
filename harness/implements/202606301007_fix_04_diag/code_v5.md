# 实现报告（v5）

## 概述

修改 `ext/scalar_common.cj` 中 `iround`/`uround` 函数，改用 `roundT` 委托路径（G6）。更新 `04_diag.md` G6 修复标记。

## 文件变更清单

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 修改 | `cjglm/src/ext/scalar_common.cj:5` | import 列表追加 `roundT` |
| 修改 | `cjglm/src/ext/scalar_common.cj:104-108` | `iround` 函数体改为委托 `roundT` |
| 修改 | `cjglm/src/ext/scalar_common.cj:110-114` | `uround` 函数体改为委托 `roundT` |
| 修改 | `docs/diag/impl/04_diag.md:152` | G6 修改方向行追加 `✅ 已修复` |

## 编译验证

`cjpm build` 编译通过（仅 warnings，无 errors）。

## 设计偏差说明

无偏差。
