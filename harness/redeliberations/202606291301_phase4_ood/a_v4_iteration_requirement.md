根据以下审查结果，迭代上一轮的产出，形成新版的文件，从而更好地满足用户需求。

## 当前审查结果

### P1 — Vec1 normalize 零输入行为自相矛盾
- **严重程度**：严重
- **问题描述**：§3.1 geometric.cj 第275行描述Vec1 normalize零值时"0 × Inf = NaN"，第278行general描述为"零向量保护返回零向量"，§5错误表也描述为返回零向量。三者矛盾，系第2轮P2审查修复不完整所致。
- **改进建议**：选择方案A（统一零向量保护）或方案B（Vec1例外并加脚注），全局同步。

### P2 — `inversesqrt(0)` 返回 +Inf 依赖 CangJie 浮点除零行为，未经验证
- **严重程度**：严重
- **问题描述**：设计声称 `inversesqrt(0) = T(1) / sqrt(0) = T(1) / 0 = +Inf`，依赖 CangJie 运行时浮点除以零返回 `+Inf`（而非抛出异常）。现有代码库中存在反向证据（quaternion_geometric.cj:25-27、ext/quaternion_trigonometric.cj:15-16 均有保护分支）。该假设未被列入H1/H2/H3确定性声明。
- **改进建议**：新增验证项确认 `Float64(1) / Float64(0)` 是否返回 `+Inf`。若返回 +Inf 则在 §1.7 补充为 H4 确定性声明；若不返回则需增加零值保护分支。

### P3 — `lib.cj` 中 `mix` 和 `exp/log/pow/sqrt` 的跨包同符号导入存在编译风险
- **严重程度**：严重
- **问题描述**：Phase 4 新增 `public import glm.detail.{mix, ...}`，而现有 `lib.cj:14` 已导入 `mix` 来自 `glm.ext`。类似地 `exp/log/pow/sqrt` 从 detail 导入与现有从 ext 导入冲突。设计仅分析了 `mix` 的冲突，声称"仓颉支持函数重载可自动区分"，但此断言未经验证，且 `exp/log/pow/sqrt` 的冲突被完全忽视。
- **改进建议**：1) 新增验证项确认 CangJie 跨 public import 同名函数重载解析行为；2) 将 `exp/log/pow/sqrt` 纳入命名冲突分析；3) 验证失败则在 §7 中新增替代方案。

### P4 — `gtc/packing.cj` 设计粒度不足，无法指导编码
- **严重程度**：一般
- **问题描述**：仅列出函数名称（"packUnorm4x8/packSnorm4x8/..."），未给出任何一个函数的完整签名（参数类型、返回类型、泛型约束），也未说明实现路径。对比同节中其他模块（ulp.cj、round.cj）都有明确的函数签名描述。
- **改进建议**：为每个 packing 函数补充完整签名（参考 `glm/gtc/packing.inl`），至少包含 2–3 个典例函数的完整签名作为格式示范；说明使用 CangJie 原生位操作 API 的路径。

### P5 — `gtc/random.cj` 线程本地存储方案缺少可行性验证
- **严重程度**：一般
- **问题描述**：选择 `ThreadLocal<Random>` 作为随机数引擎管理方案，但未说明 CangJie 中 `ThreadLocal` 是否可用、`Random` 是否为 `Send`/`Sync`。未指定种子初始化时机和全局种子管理策略。
- **改进建议**：新增验证项确认 `ThreadLocal<Random>` 可编译运行；在 D19 中补充初始化和竞态保护策略；提供备选方案（如 `Mutex<Random>` 或全局初始化）。

### P6 — `ext/matrix_transform.cj` 与 `ext/matrix_clip_space.cj` 实际函数范围未明确
- **严重程度**：一般
- **问题描述**：`ext/matrix_transform.cj` 的 stub 仅有 1 个函数（`translate`），设计表示"替换 stub 为完整实现"但仅列出 `translate/rotate/scale` 三个函数，未明确完整函数清单。`ext/matrix_clip_space.cj` 同样未明确补充的完整函数列表。对比 `gtc/matrix_transform.cj` 在第388–396行给出了详细的系族分类，`ext/` 的对应文件缺乏类似粒度。
- **改进建议**：为每个 `ext/` 矩阵文件列出完整的函数签名清单（可参考 GLM 1.0.3 对应头文件），或明确标注"函数范围与 GLM 1.0.3 对应头文件一致"并给出参考行号。

## 历史迭代回顾

### 已解决的问题（出现在历史反馈但当前反馈中不再提及）
- **第1轮P1**（全部 stub 替换完成 vs. quaternion_exponential stub 矛盾）：已在 v1→v2 修订中通过新增 §1.5 不覆盖范围章节解决。
- **第1轮P2**（acos clamp 矛盾）：已在 v1→v2 修订中通过新增 D17 设计决策条目解决。
- **第1轮P3**（type_precision 别名范围未定义）：已在 v1→v2 修订中补充完整别名清单解决。
- **第1轮P4**（Common<T> 未定义约束）：已在 v1→v2 修订中修正措辞解决。
- **第1轮P5**（T(0)/T(1) 字面量）：已在 v1→v2 修订中增加简写约定说明解决。
- **第1轮P6**（mod 约束策略）：已在 v1→v2 修订中新增 D15 设计决策条目解决。
- **第1轮P7**（geometric.cj 约束收紧未标记向后不兼容）：已在 v1→v2 修订中新增 D16 设计决策条目解决。
- **第2轮P3**（trigonometric 协作关系事实错误：sqrt 归属）：已在 v2→v3 修订中修正并同步更新实施批次依赖解决。
- **第2轮P4**（lib.cj perspective/ortho/frustum 导入冲突）：已在 v2→v3 修订中删除重复导入行解决。
- **第2轮P6**（random.cj 状态管理矛盾）：已在 v2→v3 修订中补充引擎管理策略和 §6 例外说明解决。
- **第2轮P7**（noise.cj 排列表存储方式）：已在 v2→v3 修订中补充纯算法说明和 GLM 参考行号解决。
- **第2轮P8**（matrix inverse Mat4x4 实现策略）：已在 v2→v3 修订中明确余子式展开并新增 D18 解决。
- **第2轮P9**（angle/angleAxis stub 未纳入范围）：已在 v2→v3 修订中纳入补齐范围并新增 D22 解决。

### 持续存在的问题（在多轮反馈中反复出现，需重点解决）
- **Vec1 normalize 零输入行为矛盾**（第2轮 P2 → 第3轮 P1 → 第4轮 P1）：第2轮 P2 要求明确 Vec1 normalize 语义，v2→v3 修订中修改为"零值时返回 NaN"，但同步修改不完整导致 general 描述和 §5 错误表矛盾。该问题已连续三轮出现，是修复引入矛盾而非新缺陷，需彻底统一。
- **inversesqrt(0) 依赖 CangJie IEEE 754 除零语义**（第2轮 P1 → 第3轮 P2 → 第4轮 P2）：第2轮 P1 要求明确边界行为，v2→v3 修订中在 §3.1/§5/D20 中补充行为说明，但未实际验证 CangJie 运行期语义，也未纳入确定性声明。该问题连续三轮出现，核心障碍是"未验证假设"，需实际执行验证。
- **lib.cj 跨包同符号导入编译风险**（第2轮 P5 → 第3轮 P3 → 第4轮 P3）：第2轮 P5 指出 common.cj 导出和 mix 命名冲突隐患，v2→v3 修订中新增 mix 冲突分析段落，但分析结论（"仓颉函数重载可自动区分"）未经验证，且 exp/log/pow/sqrt 的冲突被完全忽视。问题范围比第2轮更大，需验证后确认方案可行性。
- **gtc/random.cj ThreadLocal 方案可行性**（第2轮 P6 → 第3轮 P5 → 第4轮 P5）：第2轮 P6 要求补充引擎管理策略，v2→v3 修订中补充了 ThreadLocal 方案和 D19，但未验证 ThreadLocal 在 CangJie 中的实际可行性。连续三轮出现，需实际验证。

### 新发现的问题（本轮新识别的问题）
- **P4 — gtc/packing.cj 粒度不足**：第3轮首次识别的问题，本轮持续存在，未在上轮修复中解决。
- **P6 — ext/ 矩阵函数范围未明确**：第3轮首次识别的问题，本轮持续存在，未在上轮修复中解决。

## 上一轮产出路径
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606291301_phase4_ood\a_v3_design_v1.md

## 用户需求
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606291301_phase4_ood\requirement.md
