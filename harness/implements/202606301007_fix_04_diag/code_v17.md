# 实现报告（v17）

## 概述

完成 P4-4 末批（G35+G36+G37）：为 noise_test.cj 补充 18 个测试函数（8 isFinite + 6 零向量 + 4 边界输入），为 ulp_test.cj 补充 4 个 prev_float 测试函数（Float64/±0/NaN/Inf），标记 04_diag.md 三处 G35/G36/G37 为已修复，更新 plan.md 路线表 v17 列。全部 37 个问题至此处理完毕。

## 文件变更清单

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 追加 | `cjglm/tests/glm/gtc/noise_test.cj` | 追加 18 个测试函数（isFinite 验证 ×8、零向量输入 ×6、边界输入 ×4） |
| 追加 | `cjglm/tests/glm/gtc/ulp_test.cj` | 追加 4 个测试函数（testPrevFloatFloat64/Zero/NaN/Inf） |
| 修改 | `docs/diag/impl/04_diag.md` | G35(:416)、G36(:422)、G37(:429) 追加 `✅ 已修复` |
| 修改 | `harness/implements/202606301007_fix_04_diag/plan.md` | 路线表 v17 列 P4-4 标记 ✅ |

## 编译验证

`cjpm build` 通过，仅预存 warnings，无新 errors。

## 设计偏差说明

- noisc_test.cj 按设计追加 18 个测试函数，使用 `.isFinite()` 实例方法和 `Float32.MinNormal` 静态属性
- ulp_test.cj 按设计追加 4 个测试函数（设计概述中写"5 个"但详细签名列出 4 个，以签名细节为准实现 4 个）
- `testPrevFloatInf` 使用 `result.isFinite() || result.isInf()` 匹配"结果 finite 或 Inf"的行为契约
- G36 追加标记前确认 ulp_test.cj 已有 `testFloatDistanceNaN`、`testFloatDistanceInf`、`testFloatDistanceNegative` 及其 Float64 版本（与 S2/G7 联动已修复）
