根据以下审查结果，迭代上一轮的产出，形成新版的文件，从而更好地满足用户需求。

## 当前审查结果

### P1 — 严重 · ext/scalar_common.cj 职责描述与 GLM 1.0.3 事实不符
**所在位置**：§3.2 · ext/scalar_common.cj（第 323–326 行）

设计文档声称 ext/scalar_common.cj 包含 "min/max/clamp/mix/step/smoothstep 的额外重载形式，如 Bool 选择器版本的 mix"。经查阅 GLM 1.0.3 `ext/scalar_common.hpp` 及 `ext/scalar_common.inl` 确认，实际函数集为：
- min(a, b, c) / min(a, b, c, d)：3/4 输入标量 min
- max(a, b, c) / max(a, b, c, d)：3/4 输入标量 max
- fmin(a, b) / fmin(a, b, c) / fmin(a, b, c, d)：NaN 安全 min
- fmax(a, b) / fmax(a, b, c) / fmax(a, b, c, d)：NaN 安全 max
- fclamp(x, minVal, maxVal)：NaN 安全 clamp
- clamp(Texcoord) / repeat(Texcoord) / mirrorClamp(Texcoord) / mirrorRepeat(Texcoord)：纹理环绕模式模拟
- iround(x) / uround(x)：浮点→整数舍入

设计描述的 `mix`/`step`/`smoothstep` 在 GLM `ext/scalar_common.hpp` 中**不存在**；同时遗漏了 `fmin`/`fmax`/`fclamp`、纹理环绕模式系列和 `iround`/`uround` 等实际存在的函数。

**改进建议**：以 GLM 1.0.3 `ext/scalar_common.hpp` 的实际内容为准，重新编写该节，列出完整函数签名清单（包括约束策略和实现路径）。如果仓颉移植选择性地扩展或裁剪函数集，需在设计决策章节明确记录理由。

---

### P2 — 严重 · ext/vector_common.cj 缺乏完整函数清单，编码不可直接行动
**所在位置**：§3.2 · ext/vector_common.cj（第 328–332 行）

设计仅以 3 句模糊描述概括，未列出任何函数签名或完整清单。经查阅 GLM 1.0.3 `ext/vector_common.hpp`，实际包含约 20 个函数：
- min(v, v, v) / min(v, v, v, v)：3/4 输入向量逐分量 min
- max(v, v, v) / max(v, v, v, v)：3/4 输入向量逐分量 max
- fmin(v, T) / fmin(v, v) / fmin(v, v, v) / fmin(v, v, v, v)：NaN 安全向量 min 系列
- fmax(v, T) / fmax(v, v) / fmax(v, v, v) / fmax(v, v, v, v)：NaN 安全向量 max 系列
- fclamp(v, T, T) / fclamp(v, v, v)：NaN 安全向量 clamp
- clamp(v) / repeat(v) / mirrorClamp(v) / mirrorRepeat(v)：纹理环绕
- iround(v) / uround(v)：浮点向量→整数向量舍入

当前描述不足以指导编码。

**改进建议**：参照 P1 的改进方式，列出 ext/vector_common.cj 的完整函数签名清单，明确每个函数的约束策略和实现路径。两文件设计描述对齐。

---

### P3 — 一般 · ext/matrix_clip_space.cj ortho 系族函数计数错误
**所在位置**：§3.2 · ext/matrix_clip_space.cj（第 371 行）

文档称 ortho 系族有 11 个函数，实际为 10 个（2D 版 ortho + orthoLH_ZO + orthoLH_NO + orthoRH_ZO + orthoRH_NO + orthoZO + orthoNO + orthoLH + orthoRH + 6 参数版 ortho）。

**改进建议**：修正 ortho 系族计数为 "10 个"。

---

### P4 — 一般 · gtc/matrix_transform.cj 函数总数与分项求和自相矛盾
**所在位置**：§3.3（第 418 行称"64 个 stub 函数"）、§9.1（第 847 行）

文档多处声称 gtc/matrix_transform.cj 包含 64 个函数，但 §3.3 的分类列举求和结果为 62（基础变换9 + ortho10 + frustum9 + perspective9 + perspectiveFov9 + infinitePerspective7 + tweakedInfinitePerspective2 + 投影工具6 + 拾取矩阵1 = 62）。

**改进建议**：核实 GLM 1.0.3 `gtc/matrix_transform.hpp` 及 `ext/` 层的实际函数总数，统一全文表述。同时注意：GLM 1.0.3 的 `gtc/matrix_transform.hpp` 是纯聚合头文件，建议在设计中说明 gtc 层与 ext 层在仓颉实现中的具体关系（转发委托 vs. 独立实现 vs. 混合）。

## 历史迭代回顾

### 持续存在的问题（多轮反复出现，需重点解决）
- **P1 (ext/scalar_common.cj 事实错误)**：首次出现于第 5 轮迭代反馈（问题 1），已在 v5 设计中尝试修复但仍未修正——设计描述中 mix/step/smoothstep 的虚假内容和 fmin/fmax/fclamp/纹理环绕/iround/uround 的遗漏完全未更新。需彻底重写该节。
- **P2 (ext/vector_common.cj 缺乏细节)**：首次出现于第 5 轮迭代反馈（问题 2），v5 设计对该节的 3 句模糊描述未做实质性扩充。需列出完整函数签名清单。
- **P3 (ortho 系族计数错误)**：首次出现于第 5 轮迭代反馈（问题 3），v5 设计未修正 11→10 的计数。
- **P4 (gtc/matrix_transform.cj 总数矛盾)**：首次出现于第 5 轮迭代反馈（问题 4），v5 设计未修正 64→62 的矛盾。

### 已解决的问题（出现在历史反馈但当前反馈中不再提及）
第 1–4 轮中的全部问题（包括 stub 范围矛盾、acos clamp 策略、type_precision 范围、common.cj 约束、字面量写法、mod 约束、geometric 约束、inversesqrt 边界、Vec1 normalize 语义、三角函数协作关系、lib.cj 命名冲突、packing.cj 签名、random.cj 状态管理、noise.cj 存储、matrix.cj 逆策略、modf/frexp/ldexp 签名、奇异矩阵逆描述等）已在第 5 轮审查中确认为已解决，当前不再提及。

### 新发现的问题
本轮无全新识别的问题。当前 4 个问题均为第 5 轮反馈中已识别但未修复的持续问题。

## 上一轮产出路径
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606291301_phase4_ood\a_v5_design_v3.md

## 用户需求
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606291301_phase4_ood\requirement.md
