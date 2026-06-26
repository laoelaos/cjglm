根据以下审查结果，迭代上一轮的产出，形成新版的文件，从而更好地满足用户需求。

## 当前审查结果

本轮（v6 对应 b_v6_diag_v1.md）共识别 13 项质量问题（2 严重 + 6 一般 + 5 轻微），质询结论为 LOCATED（已确认）。问题清单按严重度排序如下：

**严重问题（2 项）**

1. **§3.13.1 trigonometric.cj 函数签名缺少 T 约束声明**（行 573-596 附近）：15 个函数（14 单参数三角函数 + atan2）的标量与向量签名模板均无 `where T <: FloatingPoint<T>` 子句，与 §3.2.1 D32、§3.11 D29、§3.12 D25 已统一策略不一致；下游对 T 约束决策无明确依据；整数 T 实例化将编译失败但无前置告警。**改进**：表头新增「T 类型约束（v11 新增）」段，所有 15 个函数签名修订为 `where T <: FloatingPoint<T>`；表行「内部依赖」列对 std.math 调用统一追加「T 必须为 FloatingPoint<T>」标注。

2. **§3.7 normalize 实现描述未涵盖 GLM 零四元数保护行为**（行 453 附近 + §5.3 表行 789-805 附近）：GLM `quaternion_geometric.inl:17-24` 实际包含 `if (len <= 0) return identity` 零除保护分支；§3.7 仅写「内部调用 length」，下游按字面实现时零四元数产生 NaN 与 §5.1 契约不符；§5.3 边界条件表缺 normalize 零四元数行。**改进**：§3.7 补充完整公式 `tmp1 = length(q); if (tmp1 <= T(Float64(0))) { return identity_q } else { return q / tmp1 }`；§5.3 表新增零四元数 + length 极小值两行；§3.7 末尾新增「实现策略（v11 补强）」段。

**一般问题（6 项）**

3. **§3.4 Quat×Vec3 公式中 `QuatVector` 符号未定义**（行 367 附近）：公式 `v + (cross(QuatVector, v) * q.w + cross(QuatVector, cross(QuatVector, v))) * T(Float64(2))` 中 `QuatVector` 未定义；下游需自行对照 GLM `type_quat.inl:359-366` 推导为 `Vec3(q.x, q.y, q.z)`。**改进**：备注列补充完整公式定义 `QuatVector = Vec3(q.x, q.y, q.z); uv = cross(QuatVector, v); uuv = cross(QuatVector, uv); return v + (uv * q.w + uuv) * T(Float64(2))`；同步检查 Quat×Vec4 行的 `Vec4(q * Vec3(v), v.w)` 公式符号歧义。

4. **§4.4 与 §11.4 调用示例命名空间前缀不一致**（行 747-754 vs 行 1213-1233）：§4.4 使用无前缀 `mat3Cast(q)` 但 §11.4 v10 已明确 `glm.mat3Cast(q)` 顶层命名空间调用形式；下游按 §4.4 实现若未先 `import glm.detail.*` 则编译失败。**改进**：§4.4 示例统一使用 `glm.mat3Cast(q)` 顶层形式；段首补充「前提：调用方已通过 lib.cj 完成 public import 间接访问」。

5. **§3.10 pow 函数 line 65/78 GLM 公式未翻译为仓颉等价**（行 497 + D21 行 850）：line 65 的 `wxyz(pow(x.w, y), 0, 0, 0)`（wxyz 顺序）与 line 78 的 `T Mag = pow(magnitude, y-1)` 均未提供仓颉等价翻译。**改进**：§3.10 补充 line 65 的 `Quat.wxyz(T(std.math.pow(Float64(x.w), Float64(y))), T(Float64(0)), T(Float64(0)), T(Float64(0)))` 与 line 78 的 `T Mag = T(std.math.pow(Float64(magnitude), Float64(y - T(1))))`；D21 决策清单追加 line 65/78 翻译路径。

6. **§3.10 pow 描述「递归调用 std.math.pow」措辞不准确**（行 497）：line 65 与 line 78 是两次独立调用而非 self-call。**改进**：将「递归调用 `std.math.pow(Float64, Float64): Float64`」修订为「**调用 `std.math.pow(Float64, Float64): Float64` 实数降级路径两次**（GLM line 65 + line 78）」；v10 修订说明段同步更新。

7. **§1「std.math Float64-only」约束与仓颉 stdlib 实际 API 不一致**（行 54-63 + §3.13.1 表头行 598）：依据简化 README 声称 std.math 仅 Float64，但详细 API 文档（`cangjie-original-docs/std/math/math_package_funcs.md`）显示 `sqrt`/`sin`/`cos`/`tan`/`asin`/`acos`/`atan`/`sinh`/`cosh`/`tanh`/`asinh`/`acosh`/`atanh` 均提供 Float16/Float32/Float64 重载，`pow` 提供 Float32/Float64 重载；`radians`/`degrees` 在 std.math 中不存在。**改进**：§1 修订为「T = Float32 实例化优先调用 std.math Float32 重载，无需显式转换；T = Float64 实例化维持现状；`radians`/`degrees` 硬编码 π 字面量路径」；§3.13.1 表头同步修订。

8. **§1「FloatingPoint<T> 接口无任何实例方法」描述不准确**（§1 修订说明 v10 + §3.10 行 496-497 + D21 行 850 + §8 验证项行 993-998）：详细 API 文档（`cangjie-original-docs/std/math/math_package_interfaces.md` 第 3-15 行）明确定义接口包含 `isInf()`/`isNaN()` 实例方法 + `getInf()`/`getMinDenormal()`/`getMinNormal()`/`getNaN()` 静态方法。**改进**：§1/§3.10/D21/§8 措辞修订为「`FloatingPoint<T>` 接口提供 `isInf()`/`isNaN()` 实例方法 + `getInf()`/`getMinDenormal()`/`getMinNormal()`/`getNaN()` 静态方法」；D21 决策依据同步修订。

**轻微问题（5 项）**

9. **§3.15 比较函数实现细节未充分展开**（行 656-659）：4 个比较函数 `lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual` 仅列出函数名与约束，未给出实现公式模板。**改进**：4 个比较函数描述补充实现公式模板 `lessThan(x: Quat<T,Q>, y: Quat<T,Q>): Vec4<Bool,Q> = Vec4<Bool,Q>(x.x < y.x, x.y < y.y, x.z < y.z, x.w < y.w)`，where 子句为 `where T <: Comparable<T>, Q <: Qualifier`。

10. **§3.13.1 radians/degrees 实现公式未完整说明**（行 589-590）：「内部依赖」列仅说硬编码 π 字面量，未给出实际计算公式。**改进**：补充完整公式 `radians(x) = x * Float64(3.141592653589793) / Float64(180.0)` 与 `degrees(x) = x * Float64(180.0) / Float64(3.141592653589793)`；T 实例化为 Float32 时需 `T(Float64(...))` 转换。

11. **§3.13.1 函数总数 30→75 描述跳跃缺少过渡说明**（行 573-596）：v9「30 个」到 v10「75 个」2.5 倍数量跳跃源于 VecN 展开为 Vec1~Vec4，但表行未标注「展开为 4 个独立函数」。**改进**：表头新增「符号约定」说明「`VecN<T, Q>` 形参为占位符，按 Vec1/Vec2/Vec3/Vec4 展开为 4 个独立函数签名」；列标题修订为「向量签名（占位符，展开为 4 个独立函数）」。

12. **修订历史章节占比过高**（行 1261-1576，约 316 行/总 1576 行 = 20%）：建议将 §修订说明（v2）~（v10）9 个章节移至独立附录文件 `v10_revision_history.md`，主文档仅保留 §1-§11。

13. **整体设计缺少 stage 3 完成的验收标准清单**：§8/§8.2/§10/§11.5 等分散于多处，未整合为「Stage 3 Acceptance Criteria」单节。**改进**：新增 §8.3「Stage 3 Acceptance Criteria」子节，汇总产出物清单、测试设计、覆盖矩阵、可用性对照表、验证项 5 类验收依据。

**质询报告（b_v6_challenge_v1.md）确认结论 LOCATED**，并提出 4 项轻微补强建议（不构成驳回）：
- 问题 A（问题 7 影响范围未展开）：建议补充问题 7 修订的下游影响范围清单（§1/§3.9/§3.10/D21/§8 验证项等联动位置）
- 问题 B（问题 1 严重程度校准）：建议问题 1 改为「一般」或在改进建议中明确「阶段四完整实现前的必备前置项」
- 问题 C（覆盖完备性补强）：建议增加「本阶段实现但运行时受 stub 依赖影响」的函数集中审计
- 问题 D（问题 12 必要性）：问题 12 属文档结构组织偏好，建议移除或弱化

## 历史迭代回顾

历史共 6 轮迭代，累计处理约 50+ 项意见。本轮（v6）审查结果与历史反馈的关系分析如下：

**持续存在的问题（多轮反复出现，本轮必须彻底解决）**：

1. **§1「std.math Float32/Float64 重载可得性」与「FloatingPoint<T> 接口实例方法」**：第 5 轮问题 1（getMin/getInf 实例方法不存在）、第 5 轮问题 3（std.math.pow 签名误为泛型）、第 5 轮问题 14（验证项 16/18 目标不存在）→ 第 6 轮问题 7（std.math Float32 重载可获得性）、第 6 轮问题 8（FloatingPoint<T> 有实例方法）。该问题已持续 2 轮，本次必须彻底修订 §1 通用约束段 + §3.10 log/pow 依赖描述 + D21 决策依据 + §8 验证项 13/16/18 全部 4 处位置。

2. **§3.13 trigonometric.cj 函数清单完备性**：第 3 轮问题 6（未区分标量/向量重载）、第 5 轮问题 5（VecN 占位符展开规则缺失）、第 5 轮问题 10（未受 §1 约束管辖）、第 5 轮问题 11（axis 公式冗余 Float64 包装）→ 第 6 轮问题 1（T 约束缺失）、第 6 轮问题 10（radians/degrees 公式不完整）、第 6 轮问题 11（30→75 过渡说明缺失）。本轮问题 1（严重）必须落实 T 约束，问题 10/11 必须补充公式与展开规则。

3. **§3.10 pow 描述准确性**：第 2 轮问题 2（依赖关系不完整）、第 2 轮问题 12（递归/命名消歧）、第 5 轮问题 3（std.math.pow 签名误为泛型）→ 第 6 轮问题 5（line 65/78 翻译缺失）、第 6 轮问题 6（「递归」措辞）。本轮问题 5/6 需同步修订。

4. **§3.4 Quat×Vec3 旋转公式与命名约定**：第 1 轮问题 2（公式错误/只含一次叉乘）、第 1 轮问题 11（cross 命名歧义）→ 第 6 轮问题 3（QuatVector 符号未定义）。公式本身在前几轮已修订正确，本轮补充 QuatVector 定义。

5. **normalize 边界行为契约**：第 1 轮问题 12（边界条件未覆盖 §3.7 normalize）、第 2 轮问题 1（axis 边界行为与 GLM 不符，作为类似边界场景）→ 第 6 轮问题 2（normalize 零四元数保护分支缺失）。本轮问题 2（严重）必须彻底解决。

6. **文档结构与可读性**：第 5 轮问题 8（测试文件目录结构与现有约定不一致）→ 第 6 轮问题 12（修订历史占比 20%）。问题 12 质询报告建议移除或弱化（D 项），可酌情处理。

**已解决的问题（出现在历史但当前反馈中不再提及）**：

- §2 包组织 / gtc/quaternion.cj 归属决策（第 1 轮问题 1/3/5）
- §3.10 `pow`/`log`/`exp` 依赖关系整体完整性（第 2 轮问题 2/3/4、第 5 轮问题 14）
- §3.2.1 type_quat_cast 签名规范（第 3 轮问题 10）
- §3.3 工厂函数边界行为契约（第 3 轮问题 9、第 4 轮问题 1）
- §3.4 全局具名函数 Number<T> 语义（第 4 轮问题 5）
- §3.5 vector_relational GLM 文件引用错误（第 4 轮问题 3）
- §3.12 与 shim_limits.cj epsilonOf 关系（第 5 轮问题 4）
- §4.4 行为契约示例格式（第 4 轮问题 1、第 5 轮问题 17）
- §2 lib.cj/fwd.cj 具体清单（第 5 轮问题 11、第 5 轮问题 17）
- §8.2 测试设计目录结构与命名（第 5 轮问题 8）
- §8.2 测试用例数累加（第 5 轮问题 15）
- §11.5 约束标注一致性（第 5 轮问题 11/16）
- fwd.cj 9 个别名计数（第 5 轮问题 2）
- gtc/quaternion.cj 欧拉角函数组决策矛盾（第 2 轮问题 8）
- axis 函数 T(1) 获取方式（第 3 轮问题 2）
- fromMat4 降维策略（第 3 轮问题 3、第 4 轮问题 1）
- Mat2x2/FMat2x2 双别名机制引用（第 3 轮问题 4）
- FQuat 是否需要双别名（第 3 轮问题 4）
- conjugate 函数 const 可调用性（第 5 轮问题 6）
- 路线图与 v3 设计不一致（第 2 轮问题 7）

**新发现的问题（本轮新识别）**：

- §3.7 normalize 零四元数保护分支缺失（问题 2，严重）——本轮新增
- §3.13.1 trigonometric.cj T 约束声明缺失（问题 1，严重）——本轮新增
- §3.10 pow line 65/78 GLM 公式未翻译为仓颉等价（问题 5，一般）——本轮新增
- §3.13.1 函数总数 30→75 过渡说明缺失（问题 11，轻微）——本轮新增
- 整体设计缺少 Stage 3 Acceptance Criteria（问题 13，轻微）——本轮新增
- §1「std.math Float32/Float64 重载可得性」事实偏差（问题 7，一般）——本轮细化（区别于第 5 轮关于 getMin/getInf 不存在的问题，本轮揭示 std.math 实际有 Float32 重载）
- §1「FloatingPoint<T> 接口无任何实例方法」事实偏差（问题 8，一般）——本轮细化（区别于第 5 轮关于 getMin/getInf 实例方法不存在的问题，本轮揭示接口实际有 isInf/isNaN 实例方法）

## 上一轮产出路径

C:/Develop/Software/cjglm_wp/harness/redeliberations/202606241929_stage3-ood/a_v6_copy_from_v5.md（1576 行）

> **行数检查**：上一轮产出为 1576 行，超过 1000 行阈值。本轮采用 **EDIT_MODE:COPY_AND_EDIT** 策略——组件 A 内部每轮均需先复制上轮产出（重命名为 a_v7_*.md）再定向修改，避免从零重写时丢失已稳定的 v1-v10 决策轨迹。

## 用户需求

C:/Develop/Software/cjglm_wp/harness/redeliberations/202606241929_stage3-ood/requirement.md
