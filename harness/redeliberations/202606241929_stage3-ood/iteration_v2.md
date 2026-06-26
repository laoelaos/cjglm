# 再审议判定报告（v2）

## 判定结果

RETRY

## 判定理由

组件B诊断报告（b_v2_diag_v1.md）识别出 **2 项严重问题 + 8 项一般问题 + 4 项轻微问题**，质询报告（b_v2_challenge_v1.md）结果为 **LOCATED**，即组件B的审查结论被确认成立（实际轮次 1 < 最大轮次 12，非循环耗尽；非质询挑战）。

逐项判定依据：

1. **问题 1（严重）**：`axis()` 函数边界行为契约与 GLM 1.0.3 `ext/quaternion_trigonometric.inl:20-27` 实际实现不符——v3 设计声称调用 `normalize(Vec3(0,0,0))` 属虚构实现；零四元数实际返回值应为 `Vec3(0,0,0)` 而非 `Vec3(1,0,0)`；行号引用指向错误的文件（`quaternion_geometric.inl` 而非 `quaternion_trigonometric.inl`）。属于事实错误，影响实施正确性，**严重等级成立**。

2. **问题 2（严重）**：`pow` 函数依赖关系遗漏 `cos_one_over_two<T>()`、`asin`、递归 `std::pow(T,T)`、`std::numeric_limits<T>::min()`；同时行号引用 `quaternion_exponential.inl:24-43` 错误（实际 `pow` 位于 line 41-80）。属于关键遗漏 + 事实错误，影响编码启动，**严重等级成立**。

3. **问题 3-10（一般）**：涵盖 `log`/`exp`/`slerp` 4 参数版的依赖遗漏、`axis` 自相矛盾、路线图与设计在 `slerp` 可验证性/`lookRotate` 命名/`ext/quaternion_common.cj` 范围的多处不一致、`gtc/quaternion.cj` 表格欧拉角行表述冲突、`conjugate` 描述与 GLM `wxyz(q.w, -q.x, -q.y, -q.z)` 不符、`detail/type_quat_cast.cj` 4 个函数签名未定义。质询报告确认这些一般问题集中于依赖完整性补齐与跨文档同步，与 OOD 编码实施所需粒度匹配，**一般等级成立**。

4. **问题 11-14（轻微）**：`lib.cj`/`fwd.cj` import 清单未列、`pow` 命名消歧未说明、`mix` 中 `acos`/`sin` 重载版本未明确、`@Derive[Hashable]` 实践依据未引用。质询报告认可轻微问题分类合理，但指出问题 14 与 OOD 文档完备性关系较弱，建议精简——**轻微等级成立**。

5. **质询报告自身瑕疵**：报告审查总结中"19 项问题"统计与 `iteration_history.md` 实际 13 项不符，证据强度区分、原码佐证要求等建议均为轻微瑕疵，不影响诊断报告核心结论。

**综合判定**：诊断报告包含 2 项严重问题与 8 项一般问题，质询报告 LOCATED 确认审查结论成立。依据判定标准，**满足 RETRY 条件**（审查报告包含严重或一般等级的问题），需重新运行组件 A 进行设计文档修订。

## 需要解决的问题（仅 RETRY 时存在）

- **问题描述**：`axis()` 函数边界行为契约与 GLM 1.0.3 实际实现不符——v3 设计 §3.9 描述的实现策略、零四元数返回值、行号引用均存在错误，且与同段「可完整实现」声明自相矛盾
- **所在位置**：§3.9 `axis` 函数描述（第 399 行附近）、§5.3 边界条件表「`axis(q)` 零四元数」行、§9 差异声明「`axis` 零四元数返回 `Vec3(1, 0, 0)`」条目、§10 覆盖矩阵 `quaternion_trigonometric.hpp` 表 `axis` 行
- **严重程度**：严重
- **改进建议**：§3.9 修订为「`axis(x)` 计算 `tmp1 = 1 - x.w*x.w`；若 `tmp1 <= 0` 返回 `Vec3(0, 0, 1)`；否则 `tmp2 = 1 / sqrt(tmp1)`，返回 `Vec3(x.x*tmp2, x.y*tmp2, x.z*tmp2)`」；§5.3 / §9 / §10 对应行同步修订；删除「内部 `normalize(Vec3(0, 0, 0))`」虚构实现描述；统一为「依赖仅 `std.math.sqrt` 和 T(1) 演算（通过 `x.w*x.w` 取得），**可完整实现**」

- **问题描述**：`pow` 函数依赖关系不完整（遗漏 `cos_one_over_two<T>()`、`asin`、递归 `std.math.pow(T,T)`、`std::numeric_limits<T>::min()` 等价物），且行号引用 `quaternion_exponential.inl:24-43` 错误
- **所在位置**：§3.10 `pow` 依赖描述、D21 设计决策、§10 覆盖矩阵 `quaternion_exponential.hpp` 表 `pow` 行
- **严重程度**：严重
- **改进建议**：§3.10 `pow` 依赖补充 `cos_one_over_two<T>()`、`asin`、递归 `std.math.pow` 与次正规数边界检查；行号修订为 `quaternion_exponential.inl:41-80`；D21 决策补充对应依赖；§8 编码启动前验证项新增「四元数 `pow` 与 `std.math.pow` 命名消歧验证」+「次正规数边界检查的仓颉等价物验证」

- **问题描述**：`log` 函数依赖关系遗漏 `epsilon<T>()`、`pi<T>()` 与 `std::numeric_limits<T>::infinity()` 等价处理策略
- **所在位置**：§3.10 `log` 依赖描述、§10 覆盖矩阵 `quaternion_exponential.hpp` 表 `log` 行
- **严重程度**：一般
- **改进建议**：§3.10 `log` 依赖修订为「依赖 `length`/`epsilon<T>()`/`pi<T>()`/`atan`/`log`」；明确 `std::numeric_limits<T>::infinity()` 的仓颉等价处理策略（建议优先 `FloatingPointNumber<T>.getInf()`，fallback 为 `T(1)/T(0)` 显式构造）

- **问题描述**：`exp` 函数依赖关系遗漏 `epsilon<T>()`
- **所在位置**：§3.10 `exp` 依赖描述、§10 覆盖矩阵 `quaternion_exponential.hpp` 表 `exp` 行
- **严重程度**：一般
- **改进建议**：§3.10 `exp` 依赖修订为「依赖 `length`/`epsilon<T>()`/`cos`/`sin`」

- **问题描述**：`slerp` 4 参数版本依赖关系遗漏 `pi<T>()` 与 `mix`（标量版）
- **所在位置**：§3.11 `slerp` 4 参数版本描述、D22 设计决策
- **严重程度**：一般
- **改进建议**：§3.11 `slerp` 4 参数版本依赖补充「`pi<T>()`（来自 scalar_constants.cj，line 107）+ `mix`（标量版，line 98-101）」

- **问题描述**：§3.9 `axis` 函数依赖描述自相矛盾——前半部声明「依赖 `sqrt` 和 T(1) 演算，可完整实现」，后半部引用「内部 `normalize(Vec3(0, 0, 0))`」依赖 `geometric.cj` 的向量 `normalize`（阶段三为 stub）
- **所在位置**：§3.9 `axis` 函数描述（第 399 行附近）
- **严重程度**：一般
- **改进建议**：在采纳问题 1 修复方案后统一为「实现公式 `tmp1 = 1 - x.w*x.w`，依赖仅 `std.math.sqrt` 和 T(1) 演算（通过 `x.w*x.w` 取得），**可完整实现**」；删除「内部 `normalize(Vec3(0, 0, 0))`」的错误描述

- **问题描述**：路线图 `02_roadmap.md` 与 v3 设计在阶段三验证标准上存在三处不一致——`slerp` 可验证性冲突（路线图标 `[可验证]`，v3 设计标 stub）；`lookRotate` 命名未同步修正（路线图多处仍引用 `lookRotate`，v3 设计已修正为 `quatLookAt*`）；`ext/quaternion_common.cj` 可验证性范围过广（未排除 `mix`/`slerp`）
- **所在位置**：v3 设计 §3.11、§8、§10、§11.5；路线图 `docs/02_roadmap.md` 第 89、102、111、125、129、130、152、163、207 行
- **严重程度**：一般
- **改进建议**：v3 设计 §3.11 / §8 / §11.5 明确「slerp stub 是设计相对路线图的合理偏差」并新增「路线图同步修订建议」段落（第 125 行修订为 `[待 Stage 4，依赖 trigonometric.cj 完整实现]`）；§3.15 + §9 增补 `lookRotate` → `quatLookAt*` 同步修订建议（第 89/102/111/129/152/163/207 行）；路线图修订或 v3 设计新增「阶段三验证标准差异说明」附录，统一 `[可验证]`/`[部分可验证]`/`[待 Stage 4]` 三级分类与 ✅/⚠️/❌ 符号的双向映射表

- **问题描述**：§3.15 `gtc/quaternion.cj` 表格欧拉角函数组行（507 行）单元格同时给出「**完整实现**（v3 修正）」与「**改为 stub 占位**（v3 最终决策）」两个相互矛盾的粗体标注
- **所在位置**：§3.15 `gtc/quaternion.cj` 表格欧拉角函数组行（第 507 行）
- **严重程度**：一般
- **改进建议**：表格单元格修订为「**stub 占位**（v3 最终决策，原误标为完整实现）」，删除中间冲突表述；或拆分为两行清晰展示决策历程

- **问题描述**：`conjugate` 函数描述与 GLM 实际实现不一致——v3 设计描述为「仅涉及逐分量取反」，GLM `ext/quaternion_common.inl:112-116` 实际是 `wxyz(q.w, -q.x, -q.y, -q.z)`（w 不变，仅 x/y/z 取反）
- **所在位置**：§3.11 `conjugate` 函数描述
- **严重程度**：一般
- **改进建议**：§3.11 `conjugate` 描述修订为「**完整实现**」「仅对 x/y/z 三个分量取反，w 分量保持不变：`Quat(-q.x, -q.y, -q.z, q.w)`（与 GLM `ext/quaternion_common.inl:112-116` 一致）」

- **问题描述**：`detail/type_quat_cast.cj` 中 `mat3Cast`/`mat4Cast`/`quatCast(Mat3)`/`quatCast(Mat4)` 4 个函数的具体签名（泛型参数、约束、返回类型）未定义
- **所在位置**：§3.2 协作关系表（行 215-218）、§3.15 跨包引用（行 540-541）、§10 覆盖矩阵 `glm/detail/type_quat_cast.hpp` 表
- **严重程度**：一般
- **改进建议**：新增 §3.2.1「type_quat_cast 函数签名规范」子节，给出 4 个函数的标准签名模板（建议 `where T <: FloatingPointNumber<T>, Q <: Qualifier` 约束）；明确 GLM `GLM_STATIC_ASSERT(std::numeric_limits<T>::is_iec559, ...)` 通过 `FloatingPointNumber<T>` 约束实现等价行为

- **问题描述**：`lib.cj`/`fwd.cj` 具体更新内容未明确——v3 设计 §2 包组织仅描述「新增 public import」与「新增 type alias」，未列出具体清单
- **所在位置**：§2 包组织 glm 包块（行 86-88）、§8 更新文件段（行 734-737）
- **严重程度**：轻微
- **改进建议**：§2 包组织 glm 块下为 `lib.cj`/`fwd.cj` 增加「具体 import/alias 清单」段落，列出新增 6 个 import 与 8 个 type alias

- **问题描述**：`pow` 函数递归调用 `pow` 的命名消歧未说明——四元数 `pow` 与实数 `std.math.pow` 未区分
- **所在位置**：§3.10 `pow` 描述、D21 设计决策
- **严重程度**：轻微
- **改进建议**：§3.10 `pow` 描述补充「递归调用 `std.math.pow(x.w, y)`（实数降级路径，T 为浮点类型时来自仓颉标准库；若不存在需以 `exp(y * ln(x.w))` 替代）」

- **问题描述**：`mix` 函数依赖中 `acos`/`sin` 重载版本未明确——GLM 实际使用 `acos(cosTheta)` 与 `sin(...)` 单参数版本，v3 设计未明确 trigonometric.cj 需提供哪些重载
- **所在位置**：§3.11 `mix` 描述、§3.10 `mix`/`slerp`/`pow` 描述
- **严重程度**：轻微
- **改进建议**：§3.11 `mix` 描述修订为「依赖 `dot`/`acos(cosTheta)`（单参数版本）/`sin(...)`（单参数版本）/`epsilon<T>()`，其中 `epsilon<T>()` 用于 `cosTheta > 1 - epsilon<T>()` 退化分支」

- **问题描述**：`@Derive[Hashable]` 派生所需 Qualifier Hashable 实现未充分核验——6 个 Qualifier 实现类型是否全部为标记类型且 Hashable 接口自动派生，实践依据未具体引用阶段二文件
- **所在位置**：§3.1 `@Derive[Hashable]` 约束核验段（行 203）、§8 编码启动前验证项 11（行 797）
- **严重程度**：轻微
- **改进建议**：§3.1 段落补充「实践依据」段落，引用阶段二 `type_mat2x2.cj` 等使用 `@Derive[Hashable]` 的具体文件与行号；§8 验证项 11 精简为「引用阶段二已验证实践，若阶段三新增 Qualifier 变体或数据结构变更则需重新验证」
