# 实现报告（v4）

## 概述

在 `ext/vector_common.cj` 补齐 `fmin`/`fmax` 缺失的 3/4 输入向量版本（G5），每函数 8 个重载（Vec1~Vec4 × 3输入 + 4输入），共 16 个。同步更新 `04_diag.md` G5 修复标记。

## 文件变更清单

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 修改 | `cjglm/src/ext/vector_common.cj:108-171` | 在现有 fmin/fmax 2-输入版本后追加 16 个函数重载（fmin/fmax 3/4-输入 × Vec1~Vec4） |
| 修改 | `docs/diag/impl/04_diag.md:135` | G5 修改方向行追加 `✅ 已修复` |

## 编译验证

`cjpm build` 编译通过，无新增错误或警告（仅预存 warning）。

## 设计偏差说明

无偏差。
