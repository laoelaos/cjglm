# 再审议判定报告（v2）

## 判定结果

RETRY

## 判定理由

组件B诊断报告确认存在 1 个**严重**问题（S1 副作用评估事实错误）和 3 个**中等**问题（G14 修改方向自相矛盾、G31 诊断信息不足无法操作、S2/G7 优先级矛盾）。组件B质询报告结论为 **LOCATED**（审查被确认），实际轮次（2）未达最大轮次（12），说明问题已被有效定位。根据判定标准，审查报告包含严重或一般等级的问题，应判定为 RETRY。

## 需要解决的问题

- **问题描述**：S1 副作用评估中声称 gtc 层 `rotate_slow`/`shear_slow` 委托 ext 的 rotate/shear，修复 ext 会自动传递。经查代码，两者均为独立实现，完全不依赖 ext.rotate/ext.shear。
- **所在位置**：a_v2_diag_v1.md 第 31 行
- **严重程度**：严重
- **改进建议**：修正为：gtc 层通过 `public import glm.ext.*` 暴露的 `gtc.rotate` 和 `gtc.shear` 会因 ext 修复自动受益；但 `gtc.rotate_slow` 和 `gtc.shear_slow` 有独立实现，不受影响。

- **问题描述**：G14 要求"补充 inversesqrt(0) 期望值为无穷的断言"，但证据已确认该测试已存在（testInversesqrtZero 中已有相关断言），修改方向与证据自相矛盾。
- **所在位置**：a_v2_diag_v1.md 第 276-277 行
- **严重程度**：一般
- **改进建议**：删除修改方向中的 `inversesqrt(0)` 项，仅保留 log(0)/log(-1) 边界测试补充。

- **问题描述**：G31 仅有一句话"补充 gtc 入口函数的委托路径测试"，无任何证据引用、无具体函数列表、无测试文件路径，无法操作。
- **所在位置**：a_v2_diag_v1.md 第 387-391 行
- **严重程度**：一般
- **改进建议**：(1) 列出 gtc 重导出 ext 的具体函数清单；(2) 区分两类测试：gtc 自有实现（identity/shear/rotate_slow/scale_slow/shear_slow）的独立路径测试，和 ext 重导出函数（translate/rotate/scale/lookAt/ortho/frustum/perspective 等）的 gtc 入口测试。

- **问题描述**：S2（第一优先）与 G7（第二优先）位于同一函数 `gtc/ulp.cj:51-57`，诊断自身要求"应同时修复"但将两者分入不同优先级组，执行者困惑是否应同时提交。
- **所在位置**：a_v2_diag_v1.md 第 459 行 vs 第 474 行
- **严重程度**：一般
- **改进建议**：将 G7 提升至第一优先，与 S2 合并为同一工作单元。
