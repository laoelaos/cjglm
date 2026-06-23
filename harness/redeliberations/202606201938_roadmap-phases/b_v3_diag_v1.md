# 质量审查报告 — 第 3 轮

**审查产出**：`a_v3_output_v1.md` — GLM 1.0.3 仓颉迁移阶段化路线图
**审查维度**：需求响应充分度、事实准确性、逻辑一致性、深度和完整性

---

## 1. `ext/scalar_constants.cj` 跨阶段归属错误

- **问题描述**：Stage 4 **"范围"**中标注 `ext/scalar_constants.cj` 为"（阶段 3 已完成，沿用）"，但经全文检索，Stage 3 的 **"范围"**、**"关键依赖"**和**"产出物"**中均未提及 `ext/scalar_constants.cj`。基线文档（`01_roadmap.md` 第 220 行）显示 `gtc/constants.hpp` 的 C++ 依赖链为 `gtc/constants.hpp → ../ext/scalar_constants.hpp → detail/setup.hpp`，`ext/scalar_constants` 是 `gtc/constants` 的硬性前置依赖。Stage 3 将 `gtc/constants.cj` 列为"完整实现"但未说明其依赖的 `ext/scalar_constants.cj` 如何处理，Stage 4 却声称该文件已在 Stage 3 完成——矛盾。
- **所在位置**：Stage 4 "范围"（第 133 行）；Stage 3 "范围"（第 82-90 行）、"关键依赖"（第 92-96 行）、"产出物"（第 98-108 行）
- **严重程度**：严重
- **改进建议**：在 Stage 3 中明确 `ext/scalar_constants.cj` 的处理方式：若随 `gtc/constants.cj` 一并完整实现，则加入 Stage 3 产出物清单；若与 `gtc/constants.cj` 合并在同一文件中不单独产出，则修改 Stage 4 的描述为"无限定前缀的 `gtc/constants.cj`（阶段 3 已完成，沿用）"。两种方案均需在 Stage 3 中对应调整。

## 2. `ext/quaternion_transform.cj`、`ext/quaternion_common.cj` 等四元数函数库文件实现状态未定义

- **问题描述**：Stage 3 **"范围"**中列出"四元数相关函数库（`ext/quaternion_transform.cj`、`ext/quaternion_common.cj` 等）"，**"产出物"**中列出"四元数相关函数库文件（`ext/quaternion_transform.cj`、`ext/quaternion_common.cj` 等）"，但两处均未标注实现状态——既不像 `ext/vector_relational.cj` 那样标注"完整实现"，也不像 `gtc/matrix_transform.cj` 那样标注"空桩占位"。Stage 4 的 ext/ 和 gtc/ 内容中同样未提及这些文件。这造成以下后果：(a) Stage 3 实施者无法判断交付要求——是完整实现、仅 stub 占位、还是只需创建空壳；(b) 若 Stage 3 以 stub 占位，Stage 4 也未安排替换为完整实现，这些文件可能永远停留在 stub 状态。
- **所在位置**：Stage 3 "范围"（第 90 行）、"产出物"（第 107 行）；Stage 4 "范围"（第 122-138 行）
- **严重程度**：严重
- **改进建议**：根据这些文件的实现复杂度确定归属——若实施复杂度低、可在 Stage 3 随四元数类型一并完整实现，则标注"完整实现"并补充对应验证标准；若需推迟至函数库集中处理，则标注"空桩占位"并在 Stage 4 中列入替换清单。无论哪种方案，两个阶段需同步修正。

## 3. Stage 3 验证标准未覆盖全部产出物

- **问题描述**：Stage 3 的验证标准仅检验四元数核心类型（构造、乘法、共轭逆归一化、slerp、别名可用性），未覆盖同阶段的其他交付物：`ext/vector_relational.cj`（向量关系运算函数）、`ext/quaternion_relational.cj`（四元数关系运算函数）、`gtc/constants.cj`（数学常量定义）的功能正确性。Stage 2 的验证标准也存在类似问题但程度较轻——范围中提及 stub 文件的编译依赖但验证标准未包含 stub 可编译性。
- **所在位置**：Stage 3 "验证标准"（第 110-114 行）
- **严重程度**：一般
- **改进建议**：为每个非桩非存疑交付物补充最少验证标准。例如：`ext/vector_relational.cj` 验证"向量分量比较函数与标量重载可编译且语义正确"；`gtc/constants.cj` 验证"常量值可用且类型正确"。

## 4. `lib.cj` 更新未覆盖 Stage 2 和 Stage 3

- **问题描述**：Stage 1 **"产出物"**中创建 `cjglm/src/lib.cj`（当前已存在的文件内容为 `package glm` 的公共重导出入口，涵盖 Vec1~Vec4、Qualifier 系列及辅助函数）。Stage 4 **"产出物"**中标注"更新 `lib.cj` 公共 API 重导出"。但 Stage 2（新增 9 个矩阵类型 + 别名）和 Stage 3（新增四元数类型 + 四元数别名）均未提及 `lib.cj` 的更新。按现有 lib.cj 的模式，新增的矩阵和四元数类型若需通过 `package glm` 命名空间对外暴露，同样需要在 `lib.cj` 中添加 `public import` 声明。产出物清单未提示此工作，可能导致实施者遗漏公共导出入口的更新。
- **所在位置**：Stage 1 "产出物"（第 35 行）、Stage 4 "产出物"（第 147 行）；Stage 2 "产出物"（第 63-68 行）、Stage 3 "产出物"（第 98-108 行）
- **严重程度**：一般
- **改进建议**：在 Stage 2 和 Stage 3 的产出物中分别补充"更新 `lib.cj`，添加矩阵/四元数类型的公共重导出"（若架构上通过 `lib.cj` 统一暴露公共 API），或在 Stage 2 和 Stage 3 的依赖中注明 `lib.cj` 不作为本阶段交付物（若类型通过其他路径对外暴露）。

---

## 整体评价

该产出在先前两轮审查基础上已有显著改进，跨阶段 stub 归属、方阵与非方阵依赖差异等历史问题均已妥善修复。本次发现的四个问题均为当前轮次（v3）新引入或历史遗留未被覆盖的缺陷。问题 1 和 2 为严重级别，需要在下一轮修订中优先处理；问题 3 和 4 为一般级别，可在同轮一并修正。修正后该产出可具备足够的完整性和准确性，适合写入 `docs/migration_phases.md` 作为后续实施参考。
