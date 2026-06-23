# 质量审查报告 — v11

**审查对象**：`a_v11_output_v1.md`（阶段化路线图，第 11 次迭代）
**审查范围**：需求响应充分度、事实正确性、逻辑一致性、深度和完整性

---

## 问题 1：`ext/vector_common.cj` 在 Stage 4 验证标准中被误标为 `[替换 stub]`

**问题描述**：Stage 4 验证标准第二批将 `ext/vector_common.cj` 标记为 `[替换 stub]`，但该文件在前序任何阶段（Stage 2、Stage 3）中均未作为 stub 或空桩出现过。Stage 2 创建的 3 个 stub 为 `common.cj`、`matrix.cj`、`geometric.cj`；Stage 3 创建的 6 个 stub/空桩为 `gtc/matrix_transform.cj`、`ext/matrix_projection.cj`、`ext/matrix_clip_space.cj`、`ext/matrix_transform.cj`、`trigonometric.cj`，加上继承自 Stage 2 的 `geometric.cj` 和 `matrix.cj`。`ext/vector_common.cj` 是 Stage 4 新增的文件，应标记为 `[新建]`。

**所在位置**：第 198 行，Stage 4 验证标准第二批

**严重程度**：一般

**改进建议**：将第 198 行的 `ext/vector_common.cj` 标签从 `[替换 stub]` 修正为 `[新建]`，与同批的 `trigonometric.cj`、`matrix.cj` 区分开。参考第 192 行第一批的格式，可在批次标签内分别标注：
```
**第二批（`[替换 stub]` `trigonometric.cj`、`matrix.cj`；`[新建]` `ext/vector_common.cj`）**：
```

---

## 问题 2：Stage 4 验证标准第四批 `gtc/` 功能库泛标 `[新建]` 与事实不符

**问题描述**：Stage 4 验证标准第四批将全部 `gtc/` 扩展函数库统一标记为 `[新建]`，但 `gtc/` 下实际包含三种不同状态的交付物：`gtc/matrix_transform.cj` 在 Stage 3 中已作为空桩占位，Stage 4 的角色是替换 stub（应标 `[替换 stub]`）；`gtc/constants.cj` 已在 Stage 3 完整实现，Stage 4 仅为沿用（应标 `[沿用]`）；其余 7 个 `gtc/` 文件（`matrix_inverse`、`matrix_access`、`packing`、`noise`、`random`、`type_precision`、`ulp`、`round`）为新增（`[新建]` 正确）。笼统标注 `[新建]` 可能误导实施者对 `gtc/matrix_transform.cj` 的处理方式，且与第 183-186 行产出物清单中 "替换阶段 3 的 stub" 和 "沿用自阶段 3" 的精确表述矛盾。

**所在位置**：第 210 行，Stage 4 验证标准第四批

**严重程度**：一般

**改进建议**：将第四批标签细化为：
```
**第四批（`[替换 stub]` `gtc/matrix_transform.cj`；`[新建]` `gtc/matrix_inverse.cj`、`gtc/matrix_access.cj`、`gtc/packing.cj`、`gtc/noise.cj`、`gtc/random.cj`、`gtc/type_precision.cj`、`gtc/ulp.cj`、`gtc/round.cj`；`gtc/constants.cj` [沿用自阶段 3]）**：
```
或至少将批次的笼统 `[新建]` 改为 `混合状态，详见各文件标注` 并逐文件标注。

---

## 问题 3：Stage 5 降级路径性能基线工作项中 `type_vec4` "叉积" 错误已在 v10 修复，但仍需确认其未在依赖关系描述段落残留

**问题描述**：该问题的 v10 修订说明确认已将 Stage 5 降级路径验证标准中的 Vec4 "叉积" 替换为"分量乘法"（见第 373 行修订说明），当前文件第 253 行验证标准描述已修正为 "`Vec4` 5 个核心运算（构造、加法、点积、分量乘法、归一化）"。但 Stage 5 "范围" 中降级路径定义（第 231 行）描述为 "`type_vec3.cj`/`type_vec4.cj` 在当前标量路径下的数值正确性验证通过（覆盖全部向量运算、几何函数、矩阵运算场景）"，"全部向量运算" 在纯标量路径下对 Vec4 而言仍可能被误解为包含 cross 运算。**此问题已于 v10 修复主体部分，此处仅建议对范围描述做预防性澄清**。

**所在位置**：第 231 行，Stage 5 范围降级路径定义；第 253 行验证标准（已正确）

**严重程度**：轻微

**改进建议**：在降级路径定义中将"全部向量运算"改为"全部适用的向量运算（含构造、加法、点积、分量乘法、归一化等，排除 Vec4 不适用的 cross）"，使范围描述与验证标准精确对齐，避免实施者根据范围描述自行推演时产生歧义。

---

## 问题 4：Stage 2 可选文件 `type_float.cj`/`type_half.cj` 后续状态未跟踪

**问题描述**：Stage 2 范围（第 58 行）将 `type_float.cj`、`type_half.cj` 标记为 "可选"，并说明 "仅依赖 `setup.cj`"。但这 2 个文件此后未被任何阶段提及——Stage 2 产出物中未包含、后续阶段也未涉及。若它们被创建，则属于已交付资产但缺少在哪个阶段交付、后续是否需更新的明确标记；若未被创建，则 "可选" 的决策结果未被记录，后续实施者或维护者无从知晓最终决定。

**所在位置**：第 58 行（Stage 2 范围）

**严重程度**：轻微

**改进建议**：方案 A：若确认需要，在 Stage 2 产出物中明确列出；方案 B：若确认不需要，在 Stage 2 范围中将 "可选" 改为 "确认不需要" 或删除；方案 C：建立 "可选/待决事项跟踪表" 统管所有阶段中标注为 "可选" 的项目及其决策结果。

---

## 总体评价

经过 10 轮迭代，产出整体质量很高：阶段划分合理、各阶段目标/范围/依赖/产出物/验证标准五要素齐全、跨阶段边界清晰、路径一致、具体度恰当。本审查发现的主要问题集中在 Stage 4 验证标准的实施状态标注上，存在 2 处标签与事实不符（均为 `[替换 stub]`/`[新建]` 混淆），整体不影响产出的可用性，修复成本低。
