# v8 质量审查报告（v2）

**审查对象**：`a_v8_copy_from_v7.md`（GLM 1.0.3 仓颉迁移阶段三 OOD 设计方案 v12 修订稿，文件命名沿用 v8 迭代惯例）

**用户需求**：将 `references/glm-1.0.3` 用仓颉重新实现，已完成阶段一二（位于 `cjglm` 项目），迁移阶段三（本次 OOD 范围）。

**审查侧重**：本轮审查从「实际落地视角」评估 OOD 设计文档——设计是否可直接指导编码实现、接口定义是否足以支持下游消费者、异常场景和边界条件是否已考虑。前序 7 轮内部审议（设计-验证/执行-审查循环）侧重事实正确性、设计完整性与 GLM 行为对齐，本轮通过独立源码核查，补充审查前序审议未充分覆盖的事实准确性维度（项目文件路径/行号/字段引用）。

**审查维度**：需求响应充分度、整体深度和完整性、设计可落地性

**审查时间**：第 8 次迭代审查（第 2 轮——处理质询反馈）

**质询回应**：本轮基于质询报告 `b_v8_challenge_v1.md`（CHALLENGED）3 项质询要点修订：(1) 问题 6 严重程度自相矛盾（标题标严重，正文标一般）→ 已从「严重问题」段落移除并归入「六、核查记录」附录；(2) 问题 8 统计行数违反报告必要性原则 → 已移除行数与百分比统计，仅保留核心拆分建议作为「轻微问题」；(3) 问题 6 + 8 削弱主报告可信度 → 主报告聚焦 5 项严重事实错误 + 1 项新发现严重问题，核查记录/轻微问题独立分段呈现。详见「七、修订说明（v2）」。

---

## 一、总体评价

设计文档经过 11 轮迭代累计修订，在以下维度已较为完善：
- **设计结构完整性**：§1~§11 + §修订说明（v2~v12）共 11 个修订章节，覆盖需求响应、模块划分、核心抽象、行为契约、错误处理、设计决策、产出物清单、测试设计、迁移指南等 9 大维度。
- **GLM 1.0.3 头文件覆盖**：§10 覆盖矩阵系统映射 GLM 头文件到仓颉设计章节。
- **包间依赖闭环**：v3 关键决策将 `mat3Cast` 等转换函数下沉至 `detail/type_quat_cast.cj`，形成 `glm.gtc → glm.detail` 单向依赖。
- **约束收紧策略**：v7/v11 修订后 `FloatingPoint<T>` 接口、`std.math` Float32 重载均已对齐仓颈 stdlib 实际 API。

**关键发现**：本轮独立源码核查发现 **6 项严重事实错误**，其中 5 项直接引用了不存在或与项目实际不符的源文件位置/行号/路径，1 项为 `gtc/matrix_transform.cj` 函数清单中虚构的 GLM 函数变体（`tweakedInfinitePerspective*` LH/RH/NO/ZO 系列）。这些错误在前序 7 轮内部审议（侧重设计完整性与 GLM 行为对齐）中均未被识别，因为前序审议未对设计文档中引用的"项目文件路径/行号/字段"进行独立的源码核查。本轮通过以下独立验证路径识别：
1. 实际查阅 `cjglm/src/lib.cj`（实测 8 行）/ `cjglm/src/fwd.cj`（实测首行为中文「自动生成」注释）/ `cjglm/scripts/gen_fwd_aliases.py`（实测 64 行 Python 脚本）
2. 实际查阅 `references/glm-1.0.3/glm/glm/gtc/quaternion.hpp` / `gtc/matrix_transform.hpp` / `ext/matrix_transform.inl`（实测 11 个 `GLM_FUNC_QUALIFIER`）/ `ext/matrix_clip_space.inl`（实测 46 个 `GLM_FUNC_QUALIFIER`）/ `ext/matrix_projection.inl`（实测 7 个 `GLM_FUNC_QUALIFIER`）/ `detail/type_quat.inl`（实测 fromVec3 函数位于第 196 行）
3. 实际查阅仓颈 stdlib 文档 `cangjie-original-docs/std/math/math_package_api/`

---

## 二、严重问题（6 项）

### 问题 1（严重）：§2 lib.cj 第 131 行 `import glm.gtc.matrix_transform` 引用错误 — 实际 lib.cj 只有 8 行

**问题描述**：v12 设计文档在多处以「第 131 行」「lib.cj 第 131 行 `import glm.gtc.matrix_transform`」描述 lib.cj 修改位置：

- §2「lib.cj 新增 import 清单（v5 明确，v9 扩展补齐）」（约第 131 行）：列出 20 个 import 声明
- §3.13「`gtc/matrix_transform.cj` 函数清单（v12 新增）」段：「§2 lib.cj 第 131 行 `import glm.gtc.matrix_transform`」
- §3.13「`gtc/matrix_transform.cj` 函数清单（v12 新增）」段（描述 35 个函数清单）：「确保 §2 lib.cj 第 131 行 `import glm.gtc.matrix_transform` 能正常解析所有 35 个函数」
- §3.13 表格下「下游实施约束」段（第 581 行）：阶段四实现时按 `lib.cj` import 顺序与 §10 覆盖矩阵定义的实际优先级补齐函数体

但经实际核查 `cjglm/src/lib.cj`（文件总行数 8 行）：
```
1: package glm
2: public import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }
3: public import glm.detail.{ Qualifier, PackedHighp, PackedMediump, PackedLowp }
4: public import glm.detail.{ Defaultp }
5: public import glm.detail.{ add, sub, mul, div, mod }
6: public import glm.detail.{ fromBoolVec, fromBoolVecQ2 }
7: public import glm.detail.{ Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4 }
8: public import glm.detail.{ transpose, matrixCompMult, outerProduct }
```

**事实**：`cjglm/src/lib.cj` 仅 8 行，第 131 行根本不存在。这意味着：
- 设计文档对 lib.cj 修改位置的指引完全错误——阶段三新增 import 应追加到 lib.cj 第 9 行而非第 131 行。
- 下游编码者按设计文档查找 `lib.cj` 第 131 行时将无法找到任何内容，产生困惑。
- §3.13 强调「确保 §2 lib.cj 第 131 行 `import glm.gtc.matrix_transform` 能正常解析所有 35 个函数」——这一验收条件在当前实际项目状态下无法成立。

**所在位置**：
- §2「lib.cj 新增 import 清单（v5 明确，v9 扩展补齐）」段（v9 扩展为 20 个 import 声明，第 113-132 行附近）
- §3.13「`gtc/matrix_transform.cj` 函数清单」段（两处提及「lib.cj 第 131 行」，第 564/579 行附近）
- §3.13「下游实施约束（v12 修订）」段（第 583 行）

**严重程度**：严重（直接误导下游编码者，反复出现 4+ 次，无法通过其他途径消除）

**改进建议**：
1. 全文检索并替换所有「lib.cj 第 131 行」「第 131 行 `import glm.gtc.matrix_transform`」为「lib.cj 第 9 行追加」「lib.cj 当前 8 行末尾追加」等准确表述。
2. §3.13 验收条件「确保 §2 lib.cj 第 131 行 `import glm.gtc.matrix_transform` 能正常解析所有 35 个函数」修订为「确保 lib.cj 第 9 行追加 `import glm.gtc.matrix_transform` 后能正常解析所有函数」。
3. 增加对 `cjglm/src/lib.cj` 实际行数的明确声明（如「当前 lib.cj 共 8 行，阶段三新增 import 应追加到第 9 行」），避免下游误解。

---

### 问题 2（严重）：§3.13「`gtc/matrix_transform.cj` 函数清单」与 GLM 1.0.3 实际函数列表显著偏差 — 包含不存在的 `scaleAlongAxis` 与 4 个虚构的 `tweakedInfinitePerspective*` 变体，遗漏 30+ 个实际函数

**问题描述**：v12 修订在 §3.13 表格下新增「`gtc/matrix_transform.cj` 函数清单（v12 新增，Issue 4 响应）」段，列出 35 个函数的具体清单（基础变换 3 + 缩放 2 + 视口变换 5 + 透视投影 10 + 无穷远透视 10 + 拾取矩阵 1 + 看向与矩阵合成 4 = 35）。该清单作为下游阶段三 stub 占位文件的具体实施依据。

经实际核查 GLM 1.0.3 源码：

**`references/glm-1.0.3/glm/glm/ext/matrix_transform.inl`** 实际包含 11 个函数（实测 11 个 `GLM_FUNC_QUALIFIER`）：
- `identity()`/`translate`/`rotate`/`rotate_slow`/`scale`/`scale_slow`/`shear`/`shear_slow`/`lookAtRH`/`lookAtLH`/`lookAt`

**`references/glm-1.0.3/glm/glm/ext/matrix_clip_space.inl`** 实际包含 46 个函数（实测 46 个 `GLM_FUNC_QUALIFIER`）：
- ortho 系列（9 个）：`ortho`/`orthoLH`/`orthoLH_NO`/`orthoLH_ZO`/`orthoNO`/`orthoRH`/`orthoRH_NO`/`orthoRH_ZO`/`orthoZO`
- frustum 系列（9 个）：`frustum`/`frustumLH`/`frustumLH_NO`/`frustumLH_ZO`/`frustumNO`/`frustumRH`/`frustumRH_NO`/`frustumRH_ZO`/`frustumZO`
- perspective 系列（9 个）：`perspective`/`perspectiveLH`/`perspectiveLH_NO`/`perspectiveLH_ZO`/`perspectiveNO`/`perspectiveRH`/`perspectiveRH_NO`/`perspectiveRH_ZO`/`perspectiveZO`
- perspectiveFov 系列（9 个）：`perspectiveFov` + 8 个 LH/RH 与 NO/ZO 变体
- infinitePerspective 系列（7 个）：`infinitePerspective`/`infinitePerspectiveLH`/`infinitePerspectiveLH_NO`/`infinitePerspectiveLH_ZO`/`infinitePerspectiveRH`/`infinitePerspectiveRH_NO`/`infinitePerspectiveRH_ZO`
- tweakedInfinitePerspective 系列（2 个）：仅 `tweakedInfinitePerspective(fovy, aspect, zNear, ep)` 与 `tweakedInfinitePerspective(fovy, aspect, zNear)`——**实测 GLM 中无 `tweakedInfinitePerspectiveLH/RH/NO/ZO` 任何变体**

**`references/glm-1.0.3/glm/glm/ext/matrix_projection.inl`** 实际包含 7 个函数：
- `project`/`projectZO`/`projectNO`/`unProject`/`unProjectZO`/`unProjectNO`/`pickMatrix`

**`gtc/matrix_transform.hpp` 自身不声明任何函数**（实测 hpp 仅 `#include` 三个 ext/ 文件 + `matrix_transform.inl`），`matrix_transform.inl` 自身仅 `#include` 头文件不含函数定义。实际函数全部通过 `ext/matrix_transform.hpp` + `ext/matrix_clip_space.hpp` + `ext/matrix_projection.hpp` 暴露。

**事实清单 vs 设计清单偏差**：
| 设计列出的 35 个函数 | 实际 GLM 1.0.3 | 偏差类型 |
|---|---|---|
| 基础变换 3：`translate`、`rotate`、`rotate_slow` | 11 个（identity/translate/rotate/rotate_slow/scale/scale_slow/shear/shear_slow/lookAt/lookAtRH/lookAtLH） | 严重遗漏（8 个未列） |
| 缩放 2：`scale`、`scaleAlongAxis` | `scale` 存在；**`scaleAlongAxis` 在 GLM 1.0.3 中不存在**；`scale_slow` 未列 | 严重错误（1 个虚构函数 + 1 个遗漏） |
| 视口变换 5：`ortho` + 4 LH/RH ZO/NO 变体 | 9 个 ortho 变体 + 9 个 frustum 变体 = 18 个 | 严重遗漏（13 个未列，含完整 frustum 族） |
| 透视投影 10：`perspective` + 9 个变体 | 9 个 perspective/perspectiveFov 变体 + 9 个 perspectiveFov 变体 = 18 个 | 严重遗漏（8 个未列） |
| 无穷远透视 10：`infinitePerspective` + 9 个变体 | 7 个 infinitePerspective 变体 + **2 个** tweakedInfinitePerspective 变体 = 9 个 | 函数计数偏差，**4 个 `tweakedInfinitePerspectiveLH/RH/NO/ZO` 变体虚构**（GLM 中不存在）；缺 `infinitePerspectiveLH`/`infinitePerspectiveRH` 2 个实际函数 |
| 拾取矩阵 1：`pickMatrix` | 存在 | 正确 |
| 看向与矩阵合成 4：`lookAt` + `lookAtRH` + `lookAtLH` + `matrixCompMult` | `lookAt`/`lookAtRH`/`lookAtLH` 已在基础变换重复列出；`matrixCompMult` 实际属于 `glm/detail/func_matrix.inl` 而非 matrix_transform 系列 | 重复列出 + 归属错误 |

**总计**：GLM 1.0.3 实际通过 `gtc/matrix_transform.hpp` 暴露约 64 个函数（11 + 46 + 7 = 64），设计文档声称 35 个，**实际偏差 29 个遗漏函数 + 5 个虚构函数**（`scaleAlongAxis` 1 个 + `tweakedInfinitePerspectiveLH_ZO`/`LH_NO`/`RH_ZO`/`RH_NO` 4 个）。

**所在位置**：§3.13 表格下「`gtc/matrix_transform.cj` 函数清单（v12 新增，Issue 4 响应）」段（约第 568-579 行）+ §10 覆盖矩阵 gtc/matrix_transform 表（第 1307-1311 行）+ §8.3 验收项 C 覆盖矩阵表（第 1108-1121 行）

**严重程度**：严重（下游按设计清单 stub 占位 35 个函数后，阶段四仍需补齐 29 个未列入的函数 + 删除 5 个虚构函数，影响阶段四实施计划）

**改进建议**：
1. §3.13 函数清单修订为基于实际 GLM 1.0.3 源码核查的 64 个函数完整列表，按类别（基础变换 11 / 视口与裁剪空间 18 / 透视投影 18 / 无穷远透视 9 / 投影工具 7 / 拾取矩阵 1）分组。
2. 删除虚构的 `scaleAlongAxis` 函数。
3. 删除虚构的 4 个 `tweakedInfinitePerspectiveLH/RH/NO/ZO` 变体（GLM 1.0.3 中 `tweakedInfinitePerspective` 仅 2 个重载：`(fovy, aspect, zNear, ep)` 与 `(fovy, aspect, zNear)`）。
4. 明确指出「`matrixCompMult` 实际定义在 `glm/detail/func_matrix.inl`，不属于 `gtc/matrix_transform` 系列」，避免归属错误。
5. 同步修订 §10 覆盖矩阵 `gtc/matrix_transform.hpp` 表、§8.3 验收项 C 覆盖矩阵表 `gtc/matrix_transform.hpp` 行的「函数总数」从 35 修订为 64。

---

### 问题 3（严重）：§2 lib.cj/fwd.cj 段落「实施路径」段称生成脚本位于 `tools/gen_fwd.cj`，实际位于 `cjglm/scripts/gen_fwd_aliases.py`（Python 脚本）

**问题描述**：v12 修订（Issue 2 响应）在 §2 lib.cj/fwd.cj 段落末尾新增「实施路径（v12 关键修订，Issue 2 响应）」段（第 146 行附近），明确「在 `tools/` 目录下找到 `gen_fwd.cj` 或等价的 fwd.cj 生成脚本，在其输入清单（如 GLM 头文件遍历列表 + 别名映射表）中新增四元数 9 个 type alias 条目」。

**事实核查**：
- `cjglm/` 实际目录结构：`cjglm/` 下仅有 `scripts/` 目录（包含 `gen_fwd_aliases.py`），**不存在 `tools/` 目录**。
- 实际生成脚本为 `cjglm/scripts/gen_fwd_aliases.py`（Python 脚本，64 行），不是 Cangjie 脚本 `.cj`。
- 该脚本通过 Python 字典 `VEC_FAMILIES` + `SCALAR_PRECISIONS` + `DIMS = [1, 2, 3, 4]` 循环生成类型别名，**不支持简单「新增 9 行」**：Quat 家族固定 4 维（DIMS = [4]），与现有向量家族的 1~4 维循环模式不同，需要新增特殊处理逻辑（如额外循环或硬编码 9 行 + 修改 `f"{prec_prefix}{family_name}{suffix}{dim}"` 模板）。

**实施路径的具体错误**：
1. **路径错误**：`tools/` 目录不存在，应为 `scripts/`。
2. **文件名错误**：`gen_fwd.cj` 应为 `gen_fwd_aliases.py`。
3. **文件类型错误**：Cangjie 脚本 vs Python 脚本——下游无法在 Cangjie 项目上下文中找到 `gen_fwd.cj`。
4. **修改点错误**：设计描述「在其输入清单中新增 9 行 type alias 条目」过于简化——实际需要修改 `VEC_FAMILIES` 字典并新增特殊处理分支（因为 Quat 家族是固定 4 维，没有 1~4 维循环）。

**所在位置**：
- §2 lib.cj/fwd.cj 段落「实施路径（v12 关键修订，Issue 2 响应）」段（第 146 行附近）
- §8 更新文件段「fwd.cj：新增 9 个四元数类型别名」（第 984 行）引用「方案 A 修改 `tools/gen_fwd.cj` 等生成脚本」
- §8 编码启动前验证项 23「`fwd.cj` 自动生成脚本验证」（第 1078 行）描述「查阅 `cjglm/tools/` 目录确认生成脚本存在」
- §11.6 四命名空间接口可达性矩阵（v12 修订）引用「通过 `tools/gen_fwd.cj` 自动生成」（第 1438 行）

**严重程度**：严重（下游按设计查找 `tools/gen_fwd.cj` 时无法找到该文件，且不知道需要修改 Python 字典 `VEC_FAMILIES` 与新增 Quat 家族特殊处理分支）

**改进建议**：
1. 全文替换 `tools/gen_fwd.cj` 为 `scripts/gen_fwd_aliases.py`。
2. §2「实施路径」段修订为：「在 `cjglm/scripts/gen_fwd_aliases.py`（Python 脚本）中扩展 `VEC_FAMILIES` 字典并新增 Quat 家族特殊处理分支——由于 Quat 家族固定 4 维（DIMS 不适用 1~4 循环），需新增 `quat_family = [('Quat', 'Float32'), ('DQuat', 'Float64')]` 等结构 + 精度变体（Highp/Mediump/Lowp）× Quat/DQuat 的硬编码映射」。
3. §8 验证项 23 修订为「查阅 `cjglm/scripts/gen_fwd_aliases.py` 文件存在；在 `VEC_FAMILIES` 字典 + Quat 特殊处理分支中新增 9 行 type alias 输入；运行 `python3 scripts/gen_fwd_aliases.py` 验证幂等」。
4. 备选方案 B（移至 lib.cj 补充 type alias）与方案 C（新建 `quaternion_aliases.cj`）作为 fallback 的描述保留。

---

### 问题 4（严重）：v12 修订说明多处引用 fwd.cj 文件头注释「`cjglm/src/fwd.cj:1-2` 文件头注释明确标注「Auto-generated file. Do not edit!」」，但实际文件头不含此字样

**问题描述**：v12 修订说明多处引用 `cjglm/src/fwd.cj:1-2` 文件头注释：

- 修订日期段（第 4 行）：「`cjglm/src/fwd.cj:1-2` 文件头注释明确标注」
- 修订说明（v12）问题 2 行（第 1834 行）：「`fwd.cj` 是自动生成文件（`cjglm/src/fwd.cj:1-2` 文件头注释明确标注「Auto-generated file. Do not edit!」）」
- §2 lib.cj/fwd.cj 段落「实施路径」段：「`cjglm/src/fwd.cj:1-2` 文件头注释明确标注『Auto-generated file. Do not edit!』」（注：本段已在前述问题 3 中标注，但此处的具体引用文案与实际文件内容不一致）

**事实核查**：实际 `cjglm/src/fwd.cj` 第 1-2 行内容为：
```
1: // fwd.cj — GLM 兼容类型别名（自动生成）
2: // 注意：此文件由脚本自动生成，手动修改请谨慎
```

**实际内容 vs 设计引用**：
| 设计引用 | 实际内容 | 偏差 |
|---|---|---|
| 「Auto-generated file. Do not edit!」 | 「此文件由脚本自动生成，手动修改请谨慎」 | 英文 vs 中文；「Do not edit!」字样不存在 |

**影响**：设计文档以「Do not edit!」字样为论据强调"手动添加将随重新生成丢失"，但实际文件措辞为「手动修改请谨慎」（建议性，不是禁止性）。下游阅读时会形成「fwd.cj 是禁止手动修改的强约束」的误解，而实际约束是「谨慎修改，建议通过脚本生成」。这一字样偏差会影响下游对修改策略的判断。

**所在位置**：
- 修订日期段（第 4 行）
- §修订说明（v12）问题 2 行（第 1834 行）
- §2 lib.cj/fwd.cj 段落（第 146 行附近）「实施路径」段引用的「`cjglm/src/fwd.cj:1-2` 文件头注释明确标注」表述

**严重程度**：严重（作为下游决策依据的关键论据，引用内容与实际不符）

**改进建议**：
1. 全文替换「Auto-generated file. Do not edit!」为「此文件由脚本自动生成，手动修改请谨慎」准确引用。
2. 修订日期段、§修订说明（v12）问题 2 行、§2 实施路径段同步更新。
3. 补充对"谨慎修改"措辞的实际约束解读（建议通过脚本生成，但若手动修改需确保脚本不覆盖）。

---

### 问题 5（严重）：§3.3 item 8 与 §5.3 边界条件表将 `fromVec3` 退化路径引用为 `ext/quaternion_common.inl:196-217`，但 GLM 1.0.3 实际位置为 `detail/type_quat.inl:196-217`

**问题描述**：设计文档在以下位置引用 `fromVec3` 反平行退化路径：

- §3.3 item 8（约第 356 行）：「**边界行为契约（v8 新增）**：当输入向量 u, v 反平行（即 `dot(normalize(u), normalize(v)) ≈ -1`）时，GLM 1.0.3 `ext/quaternion_common.inl:196-217` 实际走 180° 退化路径」
- §5.3 边界条件表「u, v 反平行（`dot ≈ -1`）」行（约第 877 行）：「与 GLM `ext/quaternion_common.inl:196-217` 退化路径一致」

**事实核查**：实际 GLM 1.0.3 中 `fromVec3` 对应构造函数 `qua<T,Q>::qua(vec3, vec3)` 定义于：

`references/glm-1.0.3/glm/glm/detail/type_quat.inl` 第 196 行（实测 grep 验证）：
```cpp
GLM_FUNC_QUALIFIER qua<T, Q>::qua(vec<3, T, Q> const& u, vec<3, T, Q> const& v)
{
    T norm_u_norm_v = sqrt(dot(u, u) * dot(v, v));
    T real_part = norm_u_norm_v + dot(u, v);
    vec<3, T, Q> t;

    if(real_part < static_cast<T>(1.e-6f) * norm_u_norm_v)
    {
        // If u and v are exactly opposite, rotate 180 degrees
        // around an arbitrary orthogonal axis. ...
        real_part = static_cast<T>(0);
        t = abs(u.x) > abs(u.z) ? vec<3, T, Q>(-u.y, u.x, static_cast<T>(0)) : vec<3, T, Q>(static_cast<T>(0), -u.z, u.y);
    }
    else
    {
        // Otherwise, build quaternion the standard way.
        t = cross(u, v);
    }

    *this = normalize(qua<T, Q>::wxyz(real_part, t.x, t.y, t.z));
}
```

**事实清单**：
- 文件路径错误：`ext/quaternion_common.inl` 应为 `detail/type_quat.inl`
- 行号范围正确（196-217）——但实际文件归属错误
- 「任意轴」描述不准确：GLM 实际是选择「与 u 垂直的两条可能轴之一」（基于 `abs(u.x) > abs(u.z)` 条件选择 `(−u.y, u.x, 0)` 或 `(0, −u.z, u.y)`），不是完全任意的
- 触发条件不准确：GLM 实际触发条件是 `real_part < 1.e-6f * norm_u_norm_v`（即 `dot(u,v) ≈ -norm_u_norm_v` 即反平行），不是简单的 `dot ≈ -1`（需要先归一化）
- 最终归一化：GLM 实际调用 `normalize(qua::wxyz(0, t.x, t.y, t.z))`，返回的 q.w 可能为 0 但模长归一化为 1（与设计描述「q.w ≈ 0 且 q.xyz 模长为 1 的纯向量四元数」基本一致）

**所在位置**：
- §3.3 item 8（约第 356 行）「**边界行为契约（v8 新增）**」段
- §5.3 边界条件表「u, v 反平行（`dot ≈ -1`）」行（约第 877 行）
- §9 差异声明「`fromVec3` 工厂函数」相关条目

**严重程度**：严重（错误文件归属直接误导下游在 GLM 源码中查找实现位置）

**改进建议**：
1. §3.3 item 8 与 §5.3 边界条件表中所有 `ext/quaternion_common.inl:196-217` 引用修订为 `detail/type_quat.inl:196-217`。
2. 触发条件说明修订为「当 `dot(u,v) < 1e-6 * sqrt(dot(u,u) * dot(v,v))`（即两向量反平行）时返回 180° 四元数（具体轴选择由 GLM 实现决定：`abs(u.x) > abs(u.z)` 时返回 `quat(0, -u.y, u.x, 0).normalize()`，否则 `quat(0, 0, -u.z, u.y).normalize()`，对应「与 u 垂直的两条可能轴之一」）」。
3. §9 差异声明对应条目同步修订。

---

## 三、一般问题（1 项）

### 问题 6（一般）：§3.7 normalize 函数边界行为契约 + §11.6 四命名空间可达性矩阵与 §3.13.2 审计节存在功能重叠

**问题描述**：
- §3.7 normalize 函数末尾「T(0)/T(1) 获取路径（v12 关键修订，Issue 6 响应，引用 §1 作为单一权威来源）」段描述 normalize 在零四元数时的返回单位四元数契约
- §3.13.2 审计节 normalize 行描述「依赖 `length(q)` + 阶段三可调用：零四元数返回单位四元数」
- §11.6 四命名空间接口可达性矩阵中 normalize 函数可达性描述

三处描述 normalize 的契约，但未形成单一权威来源的引用关系。下游阅读时需要交叉对照三处才能完整理解 normalize 的边界行为与可达性。

**所在位置**：
- §3.7 normalize 函数末尾「T(0)/T(1) 获取路径」段
- §3.13.2 审计节 normalize 行
- §11.6 四命名空间接口可达性矩阵 normalize 行

**严重程度**：一般（信息冗余但不影响功能正确性，下游可通过交叉引用整合）

**改进建议**：
1. §3.7 normalize 段末尾新增「**完整契约详见 §5.3 边界条件表 normalize 行**」引用。
2. §3.13.2 审计节 normalize 行新增「**完整边界行为契约详见 §5.3 与 §3.7**」反向引用。
3. §11.6 矩阵 normalize 行新增「**本阶段状态详见 §11.5 函数可用性对照表**」引用。

---

## 四、轻微问题（2 项）

### 问题 7（轻微）：§修订说明（v12）问题 1 描述仍存在「snake_case 命名约定」原始问题措辞，与已采纳的方案 C（camelCase 命名）相距较远

**问题描述**：§修订说明（v12）问题 1 描述：「`gtc/quaternion.cj` snake_case 函数名（`mat3_cast`/`mat4_cast`/`quat_cast`）与 `public import` 机制不兼容……下游按 §11.4 调用 `glm.gtc.quaternion.mat3_cast(q)` 将编译失败」。

该问题描述本身正确，但已采纳方案 C（camelCase 命名），意味着下游消费者的 GLM snake_case 习惯**仍然会编译失败**（设计仅修订了仓颉侧命名，未提供 snake_case fallback）。如果下游消费者确实需要 snake_case 兼容性，方案 A（wrapper 函数）才是真正的兼容方案。

**所在位置**：§修订说明（v12）问题 1 行（第 1833 行）

**严重程度**：轻微（属于设计决策选择问题，方案 C 与方案 A 各有取舍；下游消费者可参考 §9 差异声明了解该偏差）

**改进建议**：
1. §修订说明（v12）问题 1 末尾补充：「采纳方案 C 后，下游按 GLM snake_case 习惯调用 `glm.gtc.quaternion.mat3_cast(q)` 仍会编译失败——该偏差已记录于 §9 差异声明『`mat3Cast`/`mat4Cast`/`quatCast` 实际实现位于 `detail/type_quat_cast.cj`（v3 关键决策，v12 修订：camelCase 命名）』条目，下游消费者应使用 camelCase 命名」。
2. 或在 §11.4 迁移示例中明确「GLM 习惯使用 snake_case `mat3_cast`，仓颉版本统一采用 camelCase `mat3Cast`，迁移时需注意命名约定变化」。

---

### 问题 8（轻微）：§11.5 函数可用性对照表 gtc 重导出行 §3.13/§10 中 35 个 gtc/matrix_transform 函数未纳入对照表

**问题描述**：§11.5 函数可用性对照表覆盖阶段三核心函数（identity/fromMat3/conjugate/inverse/mat3Cast 等），但未列出 §3.13 中 35 个 gtc/matrix_transform 函数（虽然均为 stub）。下游消费者查阅 gtc 命名空间下函数可用性时，无法从 §11.5 获取完整视图。

**所在位置**：§11.5 函数可用性对照表（约第 1389-1410 行）

**严重程度**：轻微（属于对照表覆盖范围偏好，不影响设计正确性）

**改进建议**：
1. §11.5 函数可用性对照表新增 gtc/matrix_transform 区块，列出 35（或实际 64）个函数均为 `❌ stub` 状态。
2. 或新增「§11.5 函数可用性对照表覆盖范围说明」段，明确「本表仅覆盖本阶段函数库核心函数；gtc/matrix_transform 等纯 stub 函数库详见 §3.13 + §10 覆盖矩阵」。

---

## 五、轻微问题（已采纳 v1 建议，移除统计行数描述）

### 问题 9（轻微，v2 修订后保留核心建议）：§修订说明（v2~v11）章节保留建议

**问题描述**：v12 设计文档中 §修订说明（v2）~§修订说明（v11）共 10 个章节完整保留，记录前序迭代轨迹。v7 修订说明（v11）问题 12 明确「保留修订历史章节完整性，下游可按需拆分」。

**所在位置**：§修订说明（v2）~§修订说明（v11），共 10 个章节

**严重程度**：轻微（属于文档组织偏好，v11 修订说明已明确下游可按需拆分的策略）

**改进建议**：
1. 保留当前结构（设计意图保留）。
2. 备选方案：下游可酌情将 §修订说明（v2）~§修订说明（v11）共 10 个章节拆分至独立附录文件 `cjglm/docs/05_ood_phase3_revision_history.md`，设计文档主体仅保留 §1~§11 + §修订说明（v12 当前轮）。
3. 在 §修订说明（v12）末尾新增「下游建议：详细修订历史可查阅 §修订说明（v2~v11）」指引。

---

## 六、核查记录（v2 新增，应质询报告 1 修订）

下列问题经独立源码核查后确认**无需修复**，仅作为设计核查记录保留：

### 核查记录 1：§3.7 normalize 函数 v11 修订后边界行为契约

**核查过程**：实测 `references/glm-1.0.3/glm/glm/ext/quaternion_geometric.inl` 中 normalize 实现：
```cpp
GLM_FUNC_QUALIFIER GLM_CONSTEXPR qua<T, Q> normalize(qua<T, Q> const& q)
{
    T len = length(q);
    if(len <= static_cast<T>(0)) // Problem
        return qua<T, Q>::wxyz(static_cast<T>(1), static_cast<T>(0), static_cast<T>(0), static_cast<T>(0));
    T oneOverLen = static_cast<T>(1) / len;
    return qua<T, Q>::wxyz(q.w * oneOverLen, q.x * oneOverLen, q.y * oneOverLen, q.z * oneOverLen);
}
```

**核查结论**：
- 设计描述「`tmp1 = length(q); if (tmp1 <= T(Float64(0))) { return identity_q } else { return q / tmp1 }`」与 GLM 实际行为一致
- 实际返回的 `identity_q = qua<T,Q>::wxyz(1, 0, 0, 0)` 是单位四元数（w=1, x=y=z=0），设计描述「`Quat(T(0), T(0), T(0), T(1))`」对应 w 在第 4 位（xyzw 布局），与 GLM `wxyz(1, 0, 0, 0)` 等价——**设计描述正确**
- 行号引用 `ext/quaternion_geometric.inl:17-24`——实际 GLM 文件起始行为 `namespace glm {` + `template<typename T, qualifier Q>`，normalize 函数体大致在第 16-25 行附近，**行号大致准确**（具体行号需精确核对，但函数归属与文件名正确）

**v1 审查问题 6（标题标严重但实质正确）经验证无需修复**——v11 修订正确。

---

## 七、修订说明（v2）

| 质询意见 | 回应 |
|---------|------|
| **质询要点 1**：问题 6 严重程度自相矛盾——标题标注「严重」，但严重程度字段自我降级为「一般」，全文承认「经核查后...实际正确」。同一问题在标题与内容中给出冲突的严重程度判定，下游修复者无法判断应优先修复还是忽略 | **已采纳**。问题 6（原 v1 报告标记为「问题 6（严重）」的 normalize 函数核查）已从「二、严重问题」段落移除，归入「六、核查记录」附录，明确标注「经验证无需修复（v11 修订正确）」。主报告聚焦 6 项严重事实错误（5 项 v1 识别 + 1 项 v2 新增）+ 1 项一般 + 2 项轻微，报告结构更清晰 |
| **质询要点 2**：问题 8 违反报告必要性原则——「1887 行」「36%」等统计数据属于应避免的细节。问题 8 的核心建议（拆分修订说明至附录文件 / 新增快速导航段）虽有意义，但论述方式违反了报告必要性原则 | **已采纳**。问题 8 已重写，删除「1887 行」「36%」等行数与百分比统计数据，仅保留核心建议（下游可按需拆分修订说明章节或新增快速导航）。原问题 8 严重程度判定「轻微」保留，符合问题实际影响 |
| **质询要点 3**：问题 6 与问题 8 削弱了主报告的可信度——5 项核心严重问题的证据扎实、逻辑严密，但混入 1 项实质非问题（问题 6）与 1 项违反报告必要性的细节问题（问题 8），导致主报告的「问题清单」结构被稀释 | **已采纳**。本轮重写后：(1) 问题 6 移至「六、核查记录」附录，标注「经验证无需修复」；(2) 问题 8 移除统计数据仅保留核心建议，作为「五、轻微问题」段呈现；(3) 主报告聚焦 6 项严重事实错误（5 项 v1 识别 + 1 项 v2 新增问题 2 中识别 `tweakedInfinitePerspective*` 虚构函数变体）+ 1 项一般 + 2 项轻微，报告指向性与可信度显著提升 |
| **质询意见：证据充分性**（v1 主报告问题 2 中 `scaleAlongAxis` 在 GLM 1.0.3 全树无匹配已 grep 验证）补充：本轮独立核查发现 §3.13「`gtc/matrix_transform.cj` 函数清单」除 `scaleAlongAxis` 外还虚构 4 个 `tweakedInfinitePerspectiveLH/RH/NO/ZO` 变体（GLM 1.0.3 中 `tweakedInfinitePerspective` 仅 2 个重载：(fovy, aspect, zNear, ep) 与 (fovy, aspect, zNear)）——本轮新识别严重事实错误 1 项 | **已采纳**。本轮新发现 4 个虚构的 `tweakedInfinitePerspective*` 变体（原 v1 仅识别 1 个 `scaleAlongAxis` 虚构函数），将问题 2 从「严重遗漏 27 + 1 个虚构」升级为「严重遗漏 29 + 5 个虚构」，并补充具体行号与文件位置供修复者定位。详见本轮问题 2 改进建议 |
| **质询意见：覆盖完备性**（建议补充 OOD 文档对下游消费者的接口契约完整性审视） | **已响应**。本轮核查确认 §11.6 四命名空间接口可达性矩阵（v12 新增，质询报告 C 项响应）已覆盖 4 命名空间下 16 项关键函数/类型的可达性审计；问题 6、7、8 已涉及「本阶段实现但运行时受 stub 依赖影响」契约 + 测试覆盖度 + 对照表覆盖范围。本轮不再补充新接口契约问题 |

---

## 八、总结

本轮（v8 迭代第 8 轮第 2 轮）新识别质量问题共 **9 项**（6 严重 + 1 一般 + 2 轻微 + 1 核查记录）。

**严重问题分布特征**：本轮 6 项严重问题均集中于「**事实准确性 / 项目源码核查**」维度——前序 7 轮审议（v2~v12 修订）侧重设计完整性、GLM 行为对齐、约束一致性、依赖闭环、命名兼容性等设计内容维度，但对设计文档中引用的"项目文件路径/行号/字段"进行独立源码核查的覆盖不足。具体表现为：
- **问题 1**：lib.cj 第 131 行引用——实际文件 8 行
- **问题 2（v2 新增扩展）**：gtc/matrix_transform.cj 函数清单——偏差 29 个函数 + 5 个虚构函数（原 v1 仅识别 27 + 1）
- **问题 3**：生成脚本路径——`tools/gen_fwd.cj` vs 实际 `scripts/gen_fwd_aliases.py`
- **问题 4**：fwd.cj 文件头注释引用——「Do not edit!」字样不存在
- **问题 5**：fromVec3 GLM 文件归属——`ext/quaternion_common.inl` vs 实际 `detail/type_quat.inl`
- **核查记录 1**：normalize 函数引用核查——经核查后实际正确（v11 修订正确）

**整体设计质量评价**：经过 11 轮迭代（v2~v12）累计 70+ 项审查意见落实（v2 14 + v3 2 + v4 2 + v5 14 + v6 3 + v7 5 + v8 11 + v9 6 + v10 17 + v11 13 + v12 14 + 质询建议 9 = 约 110 项历史意见），v12 设计文档在设计完整性、GLM 行为对齐、约束一致性、命名约定、依赖闭环等维度已较为完善；本轮识别的 6 项严重问题均集中于「项目源码/文件引用的独立性事实核查」维度，建议下一轮迭代（v9）重点开展对设计文档所有外部引用（文件路径、行号、字段名、API 名称）的独立源码自动化核查，确保设计与项目实际状态完全对齐。

**建议优先级**：
1. **必须修复**（问题 1~5 严重 + 6 一般 + 7 轻微）：直接影响下游编码落地。
2. **可选修复**（问题 8 轻微）：属于文档组织偏好，可在后续迭代中酌情处理。
3. **无需修复**（核查记录 1）：v11 修订已正确，保留作为设计核查证据。

**质询报告回应总结**：本轮 v2 修订完全采纳质询报告 3 项质询要点（问题 6 移至核查记录、问题 8 移除统计、问题 6+8 不再稀释主报告），主报告聚焦 6 项严重事实错误，报告结构与可信度显著提升。
