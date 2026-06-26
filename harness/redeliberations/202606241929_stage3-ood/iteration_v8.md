# 再审议判定报告（v8）

## 判定结果

RETRY

## 判定理由

组件B诊断报告（v2）经独立源码核查识别出 **6 项严重事实错误** + **1 项一般问题** + **2 项轻微问题**：

**严重问题（6 项）**：
1. §2 lib.cj 第 131 行引用错误——实际 `cjglm/src/lib.cj` 仅 8 行（第 131 行不存在）
2. §3.13 `gtc/matrix_transform.cj` 函数清单与 GLM 1.0.3 实际显著偏差——29 个遗漏函数 + 5 个虚构函数（含 `scaleAlongAxis` 与 4 个 `tweakedInfinitePerspective*` 变体）
3. §2 实施路径描述生成脚本位于 `tools/gen_fwd.cj`，实际位于 `cjglm/scripts/gen_fwd_aliases.py`（Python 脚本）
4. v12 修订说明引用 `fwd.cj:1-2` 文件头「Auto-generated file. Do not edit!」字样，实际为中文「自动生成」注释
5. §3.3 item 8 与 §5.3 边界条件表将 `fromVec3` 退化路径引用为 `ext/quaternion_common.inl:196-217`，实际为 `detail/type_quat.inl:196-217`

**一般问题（1 项）**：§3.7 normalize 函数边界行为契约 + §11.6 + §3.13.2 三处描述存在功能重叠，未形成单一权威来源。

**质询报告（v2）结论**：LOCATED，确认诊断报告质量问题已被准确识别，证据基本充分；质询要点为「无」（仅提出轻微改进建议，均不构成对主问题的挑战）。

根据判定标准：审查报告包含严重或一般等级的问题，且质询报告确认问题成立（LOCATED），应判定为 RETRY，触发组件A重新运行。

## 需要解决的问题

- **问题描述**：§2 lib.cj 第 131 行引用错误——设计文档多处引用「lib.cj 第 131 行 `import glm.gtc.matrix_transform`」，但实际 `cjglm/src/lib.cj` 仅 8 行，第 131 行不存在
- **所在位置**：§2「lib.cj 新增 import 清单」段（约第 113-132 行）；§3.13 `gtc/matrix_transform.cj` 函数清单段（约第 564/579 行）；§3.13「下游实施约束」段（第 583 行）
- **严重程度**：严重
- **改进建议**：全文替换「lib.cj 第 131 行」为「lib.cj 第 9 行追加」等准确表述；§3.13 验收条件同步修订；新增对 `cjglm/src/lib.cj` 实际行数（8 行）的明确声明

- **问题描述**：§3.13 `gtc/matrix_transform.cj` 函数清单与 GLM 1.0.3 实际严重偏差——实际通过 `gtc/matrix_transform.hpp` 暴露约 64 个函数（11 + 46 + 7），设计文档声称 35 个，偏差 29 个遗漏 + 5 个虚构函数
- **所在位置**：§3.13 表格下「`gtc/matrix_transform.cj` 函数清单（v12 新增）」段（约第 568-579 行）；§10 覆盖矩阵 gtc/matrix_transform 表（第 1307-1311 行）；§8.3 验收项 C 覆盖矩阵表（第 1108-1121 行）
- **严重程度**：严重
- **改进建议**：函数清单修订为基于实际 GLM 1.0.3 源码核查的 64 个函数完整列表；删除虚构的 `scaleAlongAxis` 与 4 个 `tweakedInfinitePerspectiveLH/RH/NO/ZO` 变体；明确 `matrixCompMult` 实际定义在 `glm/detail/func_matrix.inl`；§10 + §8.3 覆盖矩阵表「函数总数」从 35 修订为 64

- **问题描述**：§2 lib.cj/fwd.cj 段落「实施路径」段称生成脚本位于 `tools/gen_fwd.cj`，实际位于 `cjglm/scripts/gen_fwd_aliases.py`（Python 脚本，64 行）；且 `cjglm/` 下不存在 `tools/` 目录
- **所在位置**：§2 lib.cj/fwd.cj 段落「实施路径」段（第 146 行附近）；§8 更新文件段「fwd.cj」（第 984 行）；§8 编码启动前验证项 23（第 1078 行）；§11.6 四命名空间接口可达性矩阵（第 1438 行）
- **严重程度**：严重
- **改进建议**：全文替换 `tools/gen_fwd.cj` 为 `scripts/gen_fwd_aliases.py`；§2 实施路径段修订为修改 `VEC_FAMILIES` 字典并新增 Quat 家族特殊处理分支；§8 验证项 23 同步修订

- **问题描述**：v12 修订说明多处引用 `cjglm/src/fwd.cj:1-2` 文件头「Auto-generated file. Do not edit!」字样，实际为中文「此文件由脚本自动生成，手动修改请谨慎」注释
- **所在位置**：修订日期段（第 4 行）；§修订说明（v12）问题 2 行（第 1834 行）；§2 lib.cj/fwd.cj 段落「实施路径」段（第 146 行附近）
- **严重程度**：严重
- **改进建议**：全文替换「Auto-generated file. Do not edit!」为「此文件由脚本自动生成，手动修改请谨慎」准确引用；补充对「谨慎修改」措辞的实际约束解读

- **问题描述**：§3.3 item 8 与 §5.3 边界条件表将 `fromVec3` 退化路径引用为 `ext/quaternion_common.inl:196-217`，实际为 `detail/type_quat.inl:196-217`；触发条件描述（`dot ≈ -1`）与实际（`real_part < 1e-6f * norm_u_norm_v`）不一致；「任意轴」描述不准确（GLM 实际是选择「与 u 垂直的两条可能轴之一」）
- **所在位置**：§3.3 item 8（约第 356 行）；§5.3 边界条件表「u, v 反平行」行（约第 877 行）；§9 差异声明对应条目
- **严重程度**：严重
- **改进建议**：所有 `ext/quaternion_common.inl:196-217` 引用修订为 `detail/type_quat.inl:196-217`；触发条件说明修订为「`dot(u,v) < 1e-6 * sqrt(dot(u,u) * dot(v,v))`」；明确轴选择逻辑（`abs(u.x) > abs(u.z)` 条件分支）；§9 差异声明同步修订

- **问题描述**：§3.7 normalize 函数末尾「T(0)/T(1) 获取路径」段 + §3.13.2 审计节 normalize 行 + §11.6 四命名空间可达性矩阵 normalize 行三处描述存在功能重叠，未形成单一权威来源的引用关系
- **所在位置**：§3.7 normalize 函数末尾；§3.13.2 审计节 normalize 行；§11.6 四命名空间接口可达性矩阵 normalize 行
- **严重程度**：一般
- **改进建议**：§3.7 末尾新增「完整契约详见 §5.3 边界条件表 normalize 行」引用；§3.13.2 与 §11.6 同步新增反向引用

- **问题描述**：§修订说明（v12）问题 1 描述仍存在「snake_case 命名约定」原始问题措辞，与已采纳的方案 C（camelCase 命名）相距较远
- **所在位置**：§修订说明（v12）问题 1 行（第 1833 行）
- **严重程度**：轻微
- **改进建议**：问题 1 末尾补充「采纳方案 C 后，下游按 GLM snake_case 习惯调用 `glm.gtc.quaternion.mat3_cast(q)` 仍会编译失败」说明

- **问题描述**：§11.5 函数可用性对照表未纳入 §3.13/§10 中 35 个 gtc/matrix_transform 函数，下游消费者查阅 gtc 命名空间下函数可用性时无法从 §11.5 获取完整视图
- **所在位置**：§11.5 函数可用性对照表（约第 1389-1410 行）
- **严重程度**：轻微
- **改进建议**：§11.5 新增 gtc/matrix_transform 区块，列出 35（或实际 64）个函数均为 `❌ stub` 状态；或新增「§11.5 函数可用性对照表覆盖范围说明」段