根据以下审查结果，迭代上一轮的产出，形成新版的文件，从而更好地满足用户需求。

## 当前审查结果

### 问题 1（严重）：Stage 2 矩阵 .inl 函数库依赖描述不精确

Stage 2 "范围"中描述"矩阵 `.inl` 实现中引用的函数库头文件（`matrix.cj`、`common.cj`、`geometric.cj`）——首版以 stub 占位"，暗示全部 9 个矩阵类型的 `.inl` 文件均存在此类依赖。但经逐文件审查确认：仅有 3 个方阵的 `.inl` 引入了额外的函数库头文件（`type_mat2x2.inl` → `matrix.hpp`；`type_mat3x3.inl` → `matrix.hpp`、`common.hpp`；`type_mat4x4.inl` → `matrix.hpp`、`geometric.hpp`），其余 6 个非方阵 `.inl`（`type_mat2x3`、`type_mat2x4`、`type_mat3x2`、`type_mat3x4`、`type_mat4x2`、`type_mat4x3`）均无额外函数库头文件引入。

- 所在位置：Stage 2 "范围"（第 53 行）
- 严重程度：严重
- 改进建议：明确区分方阵与非方阵的依赖差异，改为："`type_mat2x2`/`type_mat3x3`/`type_mat4x4` 的 `.inl` 实现分别引用 `matrix.cj`/`common.cj`/`geometric.cj`，本阶段以 stub 占位；其余 6 个非方阵 `.inl` 无此依赖，无需 stub。"

### 问题 2（严重）：Stage 2 与 Stage 3 之间 stub 文件归属存在逻辑矛盾

(a) Stage 2 "范围"（第 53 行）声明 `matrix.cj`、`common.cj`、`geometric.cj` 需以 stub 占位以使矩阵 `.inl` 可编译，但 Stage 2 "产出物"（第 62-66 行）中**未包含**这些 stub 文件。
(b) Stage 3 "产出物"（第 101-102 行）包含 `geometric.cj` 和 `matrix.cj` 的空桩，但 `common.cj` 的 stub 未被任何阶段的产出物覆盖——该文件在 Stage 2 范围中被提及需要 stub，在 Stage 3 产出物中未出现，在 Stage 4 范围（第 121 行）中仅作为待完整实现的函数库列出。
(c) 这造成 Stage 2 实施者无法判断 `common.cj` 等 stub 是应由本阶段创建、还是等待 Stage 3 创建。

- 所在位置：Stage 2 "范围"（第 53 行）、Stage 2 "产出物"（第 62-66 行）、Stage 3 "产出物"（第 101-102 行）
- 严重程度：严重
- 改进建议：方案 A：将 Stage 2 所需的 3 个 stub（`common.cj`、`matrix.cj`、`geometric.cj`）明确纳入 Stage 2 的产出物清单，确保 Stage 2 编译验证的依赖闭合性。方案 B：在 Stage 2 范围中说明"本阶段仅编译矩阵 `.hpp` 声明文件层，`.inl` 实现文件的编译验证延至 Stage 3"，以消除对 stub 的编译期依赖。

### 问题 3（一般）：跨阶段文件归属标注不完整，易导致重复实施

多个在 Stage 3 中已标注为"完整实现"的文件，在 Stage 4 的文件列表中被再次列出且未加说明，易被误解为需要 Stage 4 重新实现：
- `gtc/constants.cj`：Stage 3 产出物（第 100 行）标注"完整实现"；Stage 4 范围（第 135 行）再次列在 `gtc/` 文件清单中
- `ext/vector_relational.cj`：Stage 3 产出物（第 98 行）标注"完整实现"；Stage 4 范围（第 130 行）再次列在 `ext/` 文件清单中

- 所在位置：Stage 3 "产出物"（第 98、100 行）、Stage 4 "范围"（第 130、135 行）
- 严重程度：一般
- 改进建议：在 Stage 4 的 `gtc/` 和 `ext/` 文件清单中，对已在 Stage 3 完整实现的文件加注"（Stage 3 已完成，沿用）"标记，与标注"本阶段完整实现（阶段 3 中仅 stub）"的文件形成明确区分。

### 问题 4（轻微）：缺少最终产出物写入目的地的说明

用户需求要求"产出格式为 Markdown，写入 `docs/` 目录供后续参考"。当前产出文件位于审议工作目录下，未在文档中指定最终应写入 `docs/` 下的具体文件名或路径。

- 所在位置：文件头部（第 1-4 行）
- 严重程度：轻微
- 改进建议：在文件末尾或头部添加说明，如"本阶段规划文档最终应写入 `docs/migration_phases.md`（或类似路径）"。

## 历史迭代回顾

### 已解决的问题（出现在历史反馈但当前反馈中不再提及的问题）
- 第1轮 - 问题1：Stage 3 产出物量化模糊（已通过具体文件清单替换模糊区间）
- 第1轮 - 问题2：Stage 3/4 之间 `gtc/matrix_transform` 范围边界模糊（已标注空桩占位策略）
- 第1轮 - 问题3：Stage 6 缺少可执行的验证标准（已补充 4 条具体标准）
- 第1轮 - 问题4：Stage 3 关键依赖中空桩文件数量未量化（已明确列出 6 个空桩文件清单）
- 第1轮 - 问题5：Stage 2 验证标准引用 C++ 扩展名 `.hpp`（已改为 `.cj`）

### 持续存在的问题（在多轮反馈中反复出现的问题，需重点解决）
- **问题1（第2轮=问题1，第3轮=问题1）**：Stage 2 矩阵 `.inl` 函数库依赖描述不精确——方阵与非方阵的依赖差异仍未区分，连续两轮被指出
- **问题2（第2轮=问题2，第3轮=问题2）**：Stage 2 与 Stage 3 之间 stub 文件归属逻辑矛盾——`common.cj` stub 归属悬空、Stage 2 产出物与范围不一致，连续两轮被指出
- **问题3（第2轮=问题3，第3轮=问题3）**：跨阶段文件归属标注不完整——Stage 3 已完成文件在 Stage 4 中未加沿用标注，连续两轮被指出

### 新发现的问题（本轮新识别的问题）
- **问题4**：缺少最终产出物写入目的地的说明——未指定最终应写入 `docs/` 下的具体路径

## 上一轮产出路径
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606201938_roadmap-phases\a_v2_output_v1.md

## 用户需求
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606201938_roadmap-phases\requirement.md
