根据以下审查结果，迭代上一轮的产出，形成新版的文件，从而更好地满足用户需求。

## 当前审查结果

1. **严重**：`ext/scalar_constants.cj` 跨阶段归属错误——Stage 4 标注该文件"（阶段 3 已完成，沿用）"，但 Stage 3 全文（范围、关键依赖、产出物）均未提及该文件。基线文档显示 `ext/scalar_constants` 是 `gtc/constants` 的硬性前置依赖。Stage 3 将 `gtc/constants.cj` 列为完整实现但未说明其前置依赖 `ext/scalar_constants.cj` 的处理方式。建议：在 Stage 3 中明确 `ext/scalar_constants.cj` 的处理方式——若随 `gtc/constants.cj` 一并完整实现则加入产出物清单；若合并则修改 Stage 4 描述。

2. **严重**：`ext/quaternion_transform.cj`、`ext/quaternion_common.cj` 等四元数函数库文件实现状态未定义——Stage 3 范围列出这些文件但既未标注"完整实现"也未标注"空桩占位"，Stage 4 也未安排替换。实施者无法判断交付要求。建议：根据实现复杂度确定归属——若可在 Stage 3 完整实现则标注并补充验证标准；若需推迟则标注"空桩占位"并在 Stage 4 列入替换清单。

3. **一般**：Stage 3 验证标准未覆盖全部产出物——仅检验四元数核心类型，未覆盖 `ext/vector_relational.cj`、`ext/quaternion_relational.cj`、`gtc/constants.cj` 的功能正确性。建议：为每个非桩交付物补充最少验证标准。

4. **一般**：`lib.cj` 更新未覆盖 Stage 2 和 Stage 3——Stage 1 和 Stage 4 提及 `lib.cj` 更新，但 Stage 2（新增矩阵类型）和 Stage 3（新增四元数类型）未提及。可能导致公共导出入口遗漏。建议：在 Stage 2 和 Stage 3 的产出物中补充 `lib.cj` 更新说明。

## 历史迭代回顾

- **已解决的问题**：Stage 3 产出物量化模糊（第1轮）、Stage 3-4 范围边界模糊（第1轮）、Stage 6 缺验证标准（第1轮）、空桩文件数量未量化（第1轮）、文件扩展名引用错误（第1轮）、方阵/非方阵依赖差异未区分（第2轮）、stub 归属矛盾（第2轮）、跨阶段文件沿用标注不完整（第2轮）——以上问题在 v2 或 v3 中已修复
- **持续存在的问题（本轮重点）**：上述 4 个问题均为第 3 轮已识别但未修复的问题，需在本轮（第 4 轮）彻底解决
- **新发现的问题**：无

## 上一轮产出路径
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606201938_roadmap-phases\a_v3_output_v1.md

## 用户需求
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606201938_roadmap-phases\requirement.md
