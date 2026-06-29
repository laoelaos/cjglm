# 质量审查报告 — 阶段四 OOD 设计方案 v5

## 审查概要

**审查对象**：`a_v5_design_v3.md`（阶段四 OOD 设计方案，迭代 5 轮后版本）
**审查视角**：需求响应充分度、事实准确性、深度与完整性（侧重内部审议未充分覆盖的维度）
**审查方法**：对照 GLM 1.0.3 参考实现源码验证设计描述的事实准确性

**整体评价**：设计文档经过 5 轮内部审议迭代后，在技术可行性、边界条件处理、约束策略等维度已达到较高成熟度。但仍存在若干内部审议未覆盖的维度的问题：(1) ext/scalar_common.cj 和 ext/vector_common.cj 的设计描述与 GLM 1.0.3 实际内容存在显著偏差或深度不足，属于事实错误和设计盲区；(2) 个别函数计数存在自我矛盾。以下逐一说明。

---

## 发现的问题

### P1 — 严重 · ext/scalar_common.cj 职责描述与 GLM 1.0.3 事实不符

**所在位置**：§3.2 · ext/scalar_common.cj（第 323–326 行）

**问题描述**：设计文档声称 ext/scalar_common.cj 包含 "min/max/clamp/mix/step/smoothstep 的额外重载形式，如 Bool 选择器版本的 mix"。经查阅 GLM 1.0.3 `ext/scalar_common.hpp` 及 `ext/scalar_common.inl` 确认，实际函数集为：

| 函数 | 参数形态 |
|------|---------|
| min(a, b, c) | 3 输入标量 min |
| min(a, b, c, d) | 4 输入标量 min |
| max(a, b, c) | 3 输入标量 max |
| max(a, b, c, d) | 4 输入标量 max |
| fmin(a, b) / fmin(a, b, c) / fmin(a, b, c, d) | NaN 安全 min |
| fmax(a, b) / fmax(a, b, c) / fmax(a, b, c, d) | NaN 安全 max |
| fclamp(x, minVal, maxVal) | NaN 安全 clamp |
| clamp(Texcoord) | GL_CLAMP 纹理环绕模拟（仅 1 参） |
| repeat(Texcoord) | GL_REPEAT 纹理环绕模拟 |
| mirrorClamp(Texcoord) | GL_MIRRORED_REPEAT 环绕模拟 |
| mirrorRepeat(Texcoord) | GL_MIRROR_REPEAT 环绕模拟 |
| iround(x) | 浮点 → int 舍入 |
| uround(x) | 浮点 → uint 舍入 |

设计描述的 `mix`/`step`/`smoothstep` 在 GLM `ext/scalar_common.hpp` 中**不存在**；同时设计遗漏了 `fmin`/`fmax`/`fclamp`、纹理环绕模式系列（`clamp`(1参)/`repeat`/`mirrorClamp`/`mirrorRepeat`）和 `iround`/`uround` 等实际存在的函数。

**严重程度**：严重

**改进建议**：以 GLM 1.0.3 `ext/scalar_common.hpp` 的实际内容为准，重新编写节，列出完整函数签名清单（包括约束策略和实现路径）。如果仓颉移植选择性地扩展或裁剪函数集，需在设计决策章节明确记录理由。

---

### P2 — 严重 · ext/vector_common.cj 缺乏完整函数清单，编码不可直接行动

**所在位置**：§3.2 · ext/vector_common.cj（第 328–332 行）

**问题描述**：设计仅以 3 句模糊描述（"提供向量级别的公共运算"、"与 core common.cj 的 min 重叠"、"主要提供 GLM ext/vector_common.hpp 中定义的补充函数"）概括，未列出任何函数签名或完整清单。

经查阅 GLM 1.0.3 `ext/vector_common.hpp`，实际包含约 20 个函数：

| 函数 | 说明 |
|------|------|
| min(v, v, v) / min(v, v, v, v) | 3/4 输入向量逐分量 min |
| max(v, v, v) / max(v, v, v, v) | 3/4 输入向量逐分量 max |
| fmin(v, T) / fmin(v, v) / fmin(v, v, v) / fmin(v, v, v, v) | NaN 安全向量 min 系列 |
| fmax(v, T) / fmax(v, v) / fmax(v, v, v) / fmax(v, v, v, v) | NaN 安全向量 max 系列 |
| fclamp(v, T, T) / fclamp(v, v, v) | NaN 安全向量 clamp |
| clamp(v) | GL_CLAMP 纹理环绕（1 参） |
| repeat(v) | GL_REPEAT 纹理环绕 |
| mirrorClamp(v) / mirrorRepeat(v) | 镜像纹理环绕 |
| iround(v) / uround(v) | 浮点向量 → 整数向量舍入 |

当前描述不足以指导编码。开发者无法仅从设计文档确定应实现哪些函数、各函数的签名形态、约束策略。

**严重程度**：严重

**改进建议**：参照 P1 的改进方式，列出 ext/vector_common.cj 的完整函数签名清单，明确每个函数的约束策略和实现路径（可委托 core common.cj 或直接实现）。此文件与 ext/scalar_common.cj 共享大量类似的模式（fmin/fmax/fclamp、纹理环绕、iround/uround），建议两文件的设计描述对齐。

---

### P3 — 一般 · ext/matrix_clip_space.cj ortho 系族函数计数与 GLM 实际不符

**所在位置**：§3.2 · ext/matrix_clip_space.cj（第 371 行）

**问题描述**：文档称 "ortho 系族（11 个）"。经查阅 GLM 1.0.3 `ext/matrix_clip_space.hpp` 确认，ortho 系族实际为 10 个函数：

1. ortho(T left, T right, T bottom, T top)
2. orthoLH_ZO
3. orthoLH_NO
4. orthoRH_ZO
5. orthoRH_NO
6. orthoZO
7. orthoNO
8. orthoLH
9. orthoRH
10. ortho(T left, T right, T bottom, T top, T zNear, T zFar)

总数 46 的声明与系族清单求和（10+9+9+9+7+2=46）一致，表明是 ortho 子项计数偏离而非总数错误。

**严重程度**：一般（不改变实现内容，但影响文档可信度）

**改进建议**：修正 ortho 系族计数为 "10 个"。

---

### P4 — 一般 · gtc/matrix_transform.cj 函数总数与分项求和自相矛盾

**所在位置**：§3.3 · gtc/matrix_transform.cj（第 418 行称"64 个 stub 函数"）、§9.1（第 847 行称"全部 64 个 GLM 矩阵变换 API"）

**问题描述**：文档多处声称 gtc/matrix_transform.cj 包含 64 个函数，但 §3.3 的分类列举求和结果为 62（基础变换 9 + ortho 10 + frustum 9 + perspective 9 + perspectiveFov 9 + infinitePerspective 7 + tweakedInfinitePerspective 2 + 投影工具 6 + 拾取矩阵 1 = 62）。

**严重程度**：一般（不影响编码内容，但与 P3 的计数偏差叠加，降低了文档的数据可信度）

**改进建议**：核实 GLM 1.0.3 `gtc/matrix_transform.hpp` 及 `ext/` 层的实际函数总数，统一全文表述。同时注意：GLM 1.0.3 的 `gtc/matrix_transform.hpp` 是纯聚合头文件（自身不定义任何函数，仅 `#include` ext 层头文件），建议在设计中说明 gtc 层与 ext 层在仓颉实现中的具体关系（转发委托 vs. 独立实现 vs. 混合），避免编码时重复实现。

---

## 未发现的问题

以下维度经审查确认无显著质量问题：
- **需求响应充分度**：覆盖了路线图定义的全部阶段四范围，包括 quaternion 补齐（angle/angleAxis）、quaternion_exponential 排除理由等均已记录
- **错误处理策略**：与 GLM 1.0.3 行为一致，acosin 越界保护、奇异矩阵求逆的 IEEE 754 自然行为等均描述清晰
- **并发设计**：random.cj 的 ThreadLocal 策略已通过 H5 验证
- **lib.cj 导出兼容性**：与现有 lib.cj 的已有导入行无冲突，trigonometric 函数已在阶段三导入，无需重复导出
- **实施批次划分**：拓扑依赖分析正确

---

## 总结

本设计文档的主体部分（core 函数库的 5 个文件 + ext 矩阵变换类 + gtc 扩展库）描述详尽、签名完整、边界条件清晰，可直接指导编码。主要质量短板集中在 **ext/scalar_common.cj** 和 **ext/vector_common.cj** 两个文件的设计描述——前者存在事实错误，后者描述过于笼统，两者均不足以支撑编码阶段直接行动。建议在进入编码前优先修复 P1 和 P2，避免开发者基于错误或模糊的设计描述产生返工。
