根据以下审查结果，迭代上一轮的产出，形成新版的文件，从而更好地满足用户需求。

## 当前审查结果

### 1. Stage 4 内部拓扑顺序缺失（一般）
Stage 4 是文件量最大、跨包依赖最复杂的阶段（约 20+ 文件），产出明确指出"函数库之间可能存在相互调用，需按拓扑顺序分批迁移"，但未给出任何分批顺序指引。实施者拿到产出后无法直接判断"应该先实现哪些文件，后实现哪些文件"。
**改进建议**：补充概要性内部拓扑顺序，例如按批次划分（第一批无内部函数库依赖的文件如 `common.cj`、`exponential.cj`、`scalar_common.cj`；第二批依赖基础函数库的文件如 `trigonometric.cj`、`matrix.cj`；第三批依赖前两批的文件如 `geometric.cj`、`vector_common.cj`；第四批 ext/ 矩阵函数库 + gtc/ 完整实现）。无需深入到函数签名，仅给出批次划分即可。

### 2. Stage 5 验证标准缺少前置条件检查（一般）
Stage 5 关键依赖已引用基线文档结论——"CangJie 当前版本不提供 SIMD 基础类型"，说明实施前需确认仓颉版本是否已新增 SIMD 支持。但验证标准中没有任何前置检查项。
**改进建议**：在验证标准首条补充前置条件检查项，如 `[前置条件] 确认当前仓颉编译器版本已提供 SIMD 基础类型——若未提供则本阶段 SIMD 加速路径不可实施，降级为纯标量路径验证或推迟`。

### 3. Stage 6 swizzle 替代 API 范围界定不足（一般）
基线文档（4.5 节）将 swizzle 替代方案列为高风险重新设计任务。当前产出仅在范围中以"`_swizzle.hpp` 的 swizzle 功能替代机制设计"一笔带过，在产出物中列"swizzle 替代 API"。但未说明：替代方案是成员函数路线还是操作符路线；设计约束是什么；实施前提是什么。
**改进建议**：补充 swizzle 替代机制的范围说明——至少明确①设计路线选择倾向（成员函数/操作符/其他）；②设计约束（兼容 GLM API 或提供新 API）；③实施前提（是否需要 CangJie 特定特性支持）。

### 4. Stage 4 产出物中 `common.cj` 和 `trigonometric.cj` 的 stub 替换标注不一致（轻微）
- `common.cj` 在 Stage 2 即被创建为 stub，但 Stage 4 产出物中仅标注"完整实现"，未注明"替换阶段 2 的 stub"，而 `matrix.cj`、`geometric.cj` 均标注了"(替换阶段 2/3 的 stub)"
- `trigonometric.cj` 的 stub 是 Stage 3 首次创建的，但 Stage 4 产出物将其与 `matrix.cj`、`geometric.cj` 统一标注为"替换阶段 2/3 的 stub"，包含不正确的 Stage 2 归属信息
**改进建议**：
- 将 `common.cj` 与 `matrix.cj`、`geometric.cj` 并列标注为"完整实现（替换阶段 2 的 stub）"
- 将 `trigonometric.cj` 单独标注为"完整实现（替换阶段 3 的 stub）"，或整体标注改为统一的"完整实现（替换前序阶段 stub）"

### 5. Stage 6 缺少 gtx 扩展选择准则（轻微）
产出将 Stage 6 描述为"按实际需求选择性迁移"和"按需驱动"，但未提供任何选择优先级或筛选依据。
**改进建议**：补充 2-3 条选择准则作为参考，例如：①被已交付组件直接引用的 gtx 模块优先；②与已迁移类型紧密耦合的模块优先；③剩余模块按实际项目需求排序。

## 历史迭代回顾

### 已解决的问题
- **迭代 1-4 的全部问题**：Stage 3 产出物模糊、Stage 3/4 范围边界模糊、Stage 2 矩阵依赖描述不准确、Stage 2 stub 归属问题、Stage 4 重复列出已交付文件等——已在前序轮次中解决，本轮不再提及
- **迭代 5 问题 1**（Stage 6 前置依赖不应包括 Stage 5）：已在 v6 产出中修正
- **迭代 5 问题 2**（Stage 4 产出物清单粒度不足）：已在 v6 产出中按 core/ext/gtc 分组补充具体文件清单

### 持续存在的问题（本轮仍需解决）
- **Stage 4 内部拓扑顺序缺失**（迭代 6 问题 1 → 本轮问题 1）：连续两轮提出同一问题，v6 产出未处理。此为产出中最大的完整性缺口，直接影响实施者开工效率
- **Stage 5 验证标准缺少 SIMD 前置条件检查**（迭代 6 问题 2 → 本轮问题 2）：连续两轮提出同一问题，v6 产出未处理
- **Stage 6 swizzle 替代 API 范围未界定**（迭代 6 问题 3 → 本轮问题 3）：连续两轮提出同一问题，v6 产出未处理

### 新发现的问题（本轮首次识别）
- **问题 4**（Stage 4 common.cj/trigonometric.cj stub 替换标注不一致）：本轮新识别的事实准确性缺陷
- **问题 5**（Stage 6 gtx 扩展缺少选择准则）：本轮新识别的完整性不足问题

## 上一轮产出路径
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606201938_roadmap-phases\a_v6_output_v1.md

## 用户需求
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606201938_roadmap-phases\requirement.md
