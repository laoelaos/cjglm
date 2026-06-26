## 修订说明（v2）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题 1（严重）**：`lookRotate` 非 GLM 1.0.3 实际函数——设计文档 §1 核心抽象表、§2 模块表、§3.2 协作关系表、§3.8 修正段落等处均引用 `lookRotate`，但 GLM 1.0.3 实际不存在该函数（已在 references/glm-1.0.3 全文件检索确认零匹配），对应的实际函数是 `gtc/quaternion.hpp` 中的 `quatLookAt`/`quatLookAtRH`/`quatLookAtLH` | **已采纳**。全文检查并替换所有 `lookRotate` 引用为 `quatLookAt`（或保留 `quatLookAt` 已正确引用的位置不变）：§1 核心抽象表行 20 改为"仅 `rotate` 函数 stub（仅 stub 占位）"；§2 模块表 `ext/quaternion_transform.cj` 行改为"四元数变换函数（仅 `rotate` 函数 stub）"；§3.2 协作关系表行 167 的"阶段四或本阶段视 lookRotate 范围"改为"阶段四或本阶段视 quatLookAt 范围"；§3.2 协作策略中"stub 占位：`lookRotate`/`quatLookAt`/..."改为"`quatLookAt`/`quatLookAtRH`/`quatLookAtLH`"；§3.8 角色行"提供四元数变换函数（rotate、lookRotate 等）"改为"提供四元数变换函数（rotate）"；§3.8 修正段落"`lookRotate`/`quatLookAt` 定义在 `gtc/quaternion.hpp` 中"改为"`quatLookAt`/`quatLookAtRH`/`quatLookAtLH` 定义在 `gtc/quaternion.hpp` 中"；§9 差异声明新增"GLM 中不存在 `lookRotate` 函数"说明项，记录 v1 错误与本次修订 |
| **问题 2（一般）**：§2 模块表与 §3.8 修正段落矛盾——§2 表格行 20 描述 `ext/quaternion_transform.cj` 为"大部分实现（lookRotate 依赖 geometric.cj stub）"，但 §3.8 修正段落已明确本阶段仅含 `rotate` stub | **已采纳**。§2 模块表 `ext/quaternion_transform.cj` 行的实现状态从"大部分实现（lookRotate 依赖 geometric.cj stub）"修正为"四元数变换函数（仅 `rotate` 函数 stub）"，与 §3.8 修正段落对齐 |
| **问题 3（一般）**：§3.2 协作关系表与 §3.8/§3.9 矛盾——§3.2 第 176 行将 `angleAxis` 归类为"随 ext/quaternion_transform.cj 实现"，但 §3.8/§3.9 已正确归入 `ext/quaternion_trigonometric.cj` | **已采纳**。§3.2 协作策略中"**随 ext/quaternion_transform.cj 实现**：`angleAxis`/`rotate`（不依赖 geometric.cj 的函数）"修正为"**随 ext/quaternion_transform.cj 实现（仅 stub）**：`rotate`（依赖 trigonometric.cj 与 geometric.cj 的 sin/cos/length，均为 stub，本阶段仅 stub 占位）"，删除 `angleAxis` 项；并在后续条款中明确 `angleAxis` 归入 §3.9 `ext/quaternion_trigonometric.cj` |
| **问题 4（一般）**：D19 决策依据不充分——v1 决策"四元数算术运算符不标注 @OverflowWrapping"引用了不存在的 `deviations.md DEV-26`，且与阶段一 Vec3、阶段二全部矩阵类型对算术运算符统一标注 `@OverflowWrapping` 的实践不一致 | **已采纳选项 A**。撤销 v1 D19 决策，改为"四元数算术运算符统一标注 @OverflowWrapping"，与阶段一 Vec3 (`type_vec3.cj:54-80`)、阶段二全部矩阵类型 (`type_mat2x2.cj`、`type_mat3x3.cj`、`type_mat4x2.cj` 等) 的实践一致。同步修订：§3.4 运算符体系表新增"标注 @OverflowWrapping"列说明（一元 `-`/二元 `+`/`-`/Quat×T/Quat/T 均标注）；§5 错误处理策略的"溢出策略"段落重写，明确说明"@OverflowWrapping 对浮点类型无效果（std.overflow 模块语义仅作用于整数溢出行为），但保持跨整数/浮点实例化的统一行为，避免未来整数四元数用例出现不可控整数溢出行为"；§7 设计决策 D19 完全重写决策理由并移除"参见 deviations.md DEV-26"引用；§9 差异声明的对应行同步更新。已在 grep 验证中确认阶段一/二所有相关文件（`scalar_vec_ops.cj`、`scalar_mat_ops.cj`、`type_vec3.cj`、所有 `type_mat*.cj`）均标注 `@OverflowWrapping`（200+ 处） |
| **问题 5（轻微）**：§3.4 中 mul 函数重复声明——全局具名函数表存在两条 `mul<T, Q>(s: T, q: Quat<T, Q>)` 完全相同签名的行，仅注释文字不同；仓颉函数重载规则禁止重复签名（仅参数类型/数量/顺序不同时构成有效重载），重复声明将导致编译错误 | **已采纳**。删除 §3.4 全局具名函数表中重复的"标量×四元数（交换律别名）"行，保留唯一的 `mul<T, Q>(s: T, q: Quat<T, Q>)` 标量乘四元数签名；并在该表后追加说明文字："标量×四元数乘法无需单独'交换律别名'函数——`Quat×T` 运算符已通过 `Number<T>` 约束交换律覆盖（仓颉 `Number<T>` 加法/乘法具备交换律语义），且仓颉函数重载规则禁止重复签名（同参数列表+同返回类型无法构成有效重载，将触发'重复定义'编译错误）" |
| **附带改进**：§3.7 `cross` 函数命名歧义说明 | **已采纳**。§3.7 跨四元数几何函数中 `cross` 项的职责描述由原先"四元数叉积（即 Hamilton 乘积的逐分量展开）"扩展为完整命名歧义说明：明确"四元数 `cross` 语义与向量叉乘不同——向量 `cross` 产生垂直于输入平面的向量，四元数 `cross` 产生 Hamilton 乘积的逐分量展开形式（结果仍是四元数）"，并新增"命名歧义说明"段说明 Quat 与 Vec3 上下文的 `cross` 通过类型消歧（设计文档本节说明澄清）。这是 v1 审查"轻微"问题的回应，增强文档可读性 |

---

## 修订说明（v3）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题 1（严重）— 本轮新增**：`gtc/quaternion.cj` 与 `type_quat.cj` 之间的包间循环依赖——`type_quat.cj` 通过 `import glm.gtc.quaternion.*` 引用 `mat3Cast`/`mat4Cast`/`quatCast`，而 `gtc/quaternion.cj` 通过 `import glm.detail.*` 引用 `Quat`/`Mat3x3`/`Mat4x4`/`Vec3`，形成 `glm.detail ↔ glm.gtc` 双向包依赖。仓颉语言规范明确禁止包间循环依赖（cangjie-lang-features package/README.md 第 99 行），cjpm 构建系统会拒绝编译 | **已采纳审查报告 Solution 1**。**关键决策变更**：`mat3Cast`/`mat4Cast`/`quatCast` 4 个转换函数从 `gtc/quaternion.cj` 下沉至新建的 `detail/type_quat_cast.cj`（`package glm.detail`）。`type_quat.cj` 中 `fromMat3`/`fromMat4` 工厂函数改为调用**同包** `type_quat_cast.cj` 函数（无需跨包 import）。`gtc/quaternion.cj` 通过 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 将 detail 函数重导出为 gtc 命名空间下的同名 API，保留 GLM 1:1 文件归属的 API 形态。修复后形成 `glm.gtc → glm.detail` 的**单向依赖**，彻底消除循环依赖。**同步修订**：§1「整体架构思路」末尾新增「gtc/quaternion.cj 与 type_quat_cast.cj 的协作设计（v3 关键决策）」段；§1 核心抽象表新增 `detail/type_quat_cast.cj` 行（v3 关键新增）；§2 包组织 `glm.detail` 块下新增 `type_quat_cast.cj ★` 条目（v3 关键新增）；§2 模块间依赖图 `glm.detail` 块下新增 `type_quat_cast.cj → type_quat, Mat3x3, Mat4x4, Vec3`（同包内可见）；§2 模块间依赖图 `glm.gtc` 块下 `quaternion.cj` 依赖项新增 `glm.detail.{mat3Cast, mat4Cast, quatCast}` 通过 public import 重导出（v3 关键修订）；§2 末尾 cjpm 子包构建预验证段新增「gtc 重导出 detail 函数验证项」（v3 新增验证项 2）；§3.2 协作关系表行 167-170 的「实现位置」列从「gtc/quaternion.cj 包级函数」改为「detail/type_quat_cast.cj 包级函数」+新增「Mat↔Quat 转换重导出」行；§3.3 item 6/7 `fromMat3`/`fromMat4` 描述修订为「调用同包 `type_quat_cast.cj` 函数」；§3.15 gtc/quaternion.cj 完整重写职责分组（4 重导出 + 4 完整实现 + 7 stub），跨包引用段明确「不引用 `glm.detail.type_quat` 内部成员」+「形成 `glm.gtc → glm.detail` 单向依赖，无循环依赖」；§7 设计决策 D11 完全重写（从 v2 的「gtc 承载转换函数」改为 v3 的「detail 承载 + gtc 重导出」）；§7 新增 D28「包间依赖方向严格单向」决策；§8 产出物清单「完整实现」段新增 `detail/type_quat_cast.cj`（v3 关键新增）；§8 §8.2 测试设计新增 `type_quat_cast_test.cj` 测试文件（≥8 用例）；§8 §8.2 测试覆盖维度新增「type_quat_cast 单元测试覆盖实现细节」；§8 编码启动前验证项新增「gtc 重导出 detail 函数验证」（v3 验证项 2）+「包间无循环依赖验证」（v3 验证项 3）+「type_quat.cj 同包调用 type_quat_cast.cj 函数验证」（v3 验证项 4）；§9 差异声明新增「包间依赖方向严格单向 `glm.gtc → glm.detail`（v3 关键修复）」条目；§9 差异声明的「`mat3_cast`/`mat4_cast`/`quat_cast` 实际实现位于 `detail/type_quat_cast.cj`（v3 关键决策）」条目；§9 差异声明的「从旋转矩阵构造改为具名工厂函数」条目修订为「调用同包 type_quat_cast.cj 函数，不再跨包引用 gtc」；§9 差异声明的「`gtc/quaternion.cj` 独立承载 15 函数」条目修订为「v3 关键变更：4 重导出 + 4 完整 + 7 stub」；§10 覆盖矩阵新增「glm/detail/type_quat_cast.hpp（v3 新增）」独立表；§10 覆盖矩阵「glm/gtc/quaternion.hpp（v3 修订状态）」表为 4 个转换函数标注「v3 修订：从 detail/type_quat_cast.cj 重导出」+ 为 4 个欧拉函数标注「v3 修订：从误标完整实现修正为 stub」；§11.4 矩阵-四元数互转迁移示例新增「detail 直接调用」+「gtc 命名空间调用」两种入口；§11.5 函数可用性对照表新增 `mat3_cast`/`mat4_cast`/`quat_cast`（detail 与 gtc 重导出）两行 |
| **问题 2（一般）— 本轮新增**：依赖方向内部矛盾——§2 模块间依赖图正确呈现 `glm.detail → glm.gtc` 和 `glm.gtc → glm.detail` 双向依赖，但 §1 第 56 行、§3.2 第 212 行、§3.15 第 510 行三处均错误声称这是「单向依赖」或「无循环依赖」 | **已采纳**。在采纳问题 1 修复方案后，§1「gtc/quaternion.cj 设计决策（v3 决策，采纳审查报告 Solution 1）」段、§3.2「type_quat.cj、type_quat_cast.cj、gtc/quaternion.cj 三者协作关系（v3 明确）」段、§3.15「与 type_quat.cj、type_quat_cast.cj 三方协作（v3 明确）」段均统一描述为「形成 `glm.gtc → glm.detail` 的**单向依赖**，**无循环依赖**（v3 关键修复）」。同时 §2 末尾 cjpm 子包构建预验证段明确「无循环依赖」作为验证目标。§7 设计决策 D11 重写理由部分明确引用「v2 设计将转换函数放在 gtc 导致 `type_quat.cj` 需 `import glm.gtc.quaternion` 形成 `glm.detail ↔ glm.gtc` 双向依赖，违反仓颉包间循环依赖约束」+「v3 决策将转换函数下沉至 detail 包，让 `type_quat.cj` 通过同包访问直接调用（无需 import），`gtc/quaternion.cj` 通过 `public import` 重导出至 gtc 命名空间，保留 GLM 1:1 API 形态的同时彻底打破循环依赖」 |
| **问题 1（严重）— 上一轮（v2）**：`gtc/quaternion.cj` 文件未完整规划——§2 包组织、§3.2 协作关系表、§8 产出物清单中均未将该文件纳入 | **已采纳**。§1 核心抽象表新增 `gtc/quaternion.cj` 行；§2 包组织 `glm.gtc` 块下新增 `quaternion.cj ★` 条目；§3.15 新增独立小节完整定义 15 函数分组与依赖（v3 修订为 4 重导出 + 4 完整 + 7 stub）；§8 产出物清单「完整实现」和「大部分实现」两段均补充 `gtc/quaternion.cj`；§8 §8.2 测试设计新增 `tests/glm/gtc/quaternion_test.cj` 测试文件（≥20 用例）；§10 覆盖矩阵新增「glm/gtc/quaternion.hpp（v3 修订状态）」表 |
| **问题 4（严重）— 上一轮（v2）**：§3.4 第 216 行 `Quat×Vec3` 旋转运算符实现公式错误——设计文档的 `v + 2.0 * cross(cross(QuatVector, v) + QuatVector * q.w, v)` 与 GLM `type_quat.inl:359-366` 实际公式 `v + (cross(QuatVector, v) * q.w + cross(QuatVector, cross(QuatVector, v))) * 2` 不等价 | **已采纳**。§3.4 `Quat×Vec3` 行公式修正为 `v + (cross(QuatVector, v) * q.w + cross(QuatVector, cross(QuatVector, v))) * 2`（两次 Vec3 叉乘 uv 和 uuv，与 GLM 1.0.3 `type_quat.inl:359-366` 一致）；备注列明确「依赖 `geometric.cj` 向量 `cross`（阶段三 stub），调用将抛 `Exception("stub")`」；D26 设计决策新增；§3.4 段后新增「命名约定说明」段明确「`cross(QuatVector, v)` 调用的是 Vec3 叉乘（定义于 `geometric.cj`），非 §3.7 中的四元数 `cross`（Hamilton 乘积）」；§9 差异声明新增「`Quat×Vec3` 旋转公式采用两次 Vec3 叉乘」条目 |
| **问题 5（严重）— 上一轮（v2）**：§3.2 协作关系表与策略段落对 `mat3_cast` 等函数归属矛盾——表行说「gtc/quaternion.cj（随 type_quat.cj 编码）」，策略段说「随 type_quat.cj 一同实现」 | **已采纳**。在采纳本轮问题 1 修复方案后，§3.2 协作关系表行 167-170 的「实现位置」列从「gtc/quaternion.cj（随 type_quat.cj 编码）」改为「detail/type_quat_cast.cj 包级函数」+ 新增「Mat↔Quat 转换重导出」行；D11 设计决策完整重写文件归属理由（v3 关键修复）；§9 差异声明新增「`mat3_cast`/`mat4_cast`/`quat_cast` 实际实现位于 `detail/type_quat_cast.cj`（v3 关键决策）」条目 |
| **问题 2（一般）— 上一轮（v2）**：§8 完整实现清单末尾提及「四元数测试文件」一行但未展开 | **已采纳**。§8 新增「8.2 测试设计」子章节，包含测试文件清单与位置（13 个测试文件，≥171 用例，v3 新增 `type_quat_cast_test.cj` 8 用例）、测试覆盖维度（7 类，v3 新增「type_quat_cast 单元测试覆盖实现细节」）、浮点比较策略（v3 新增「type_quat_cast 单元测试：使用『旋转矩阵 * 向量 = 四元数 * 向量』等价性测试」）、阶段三可验证 vs 待阶段四拆分 |
| **问题 3（一般）— 上一轮（v2）**：§2 模块间依赖图缺少 `gtc/quaternion.cj` 的依赖方向 | **已采纳**。§2 模块间依赖图 `glm.gtc` 块下新增 `quaternion.cj → glm.detail(Quat, Mat3x3, Mat4x4, Vec3), glm.ext.scalar_constants, glm.ext.vector_relational, glm.detail.common(stub), glm.detail.trigonometric(stub), glm.detail.geometric(stub)` 依赖方向说明；§2 末尾 cjpm 子包构建预验证段同步引用 |
| **问题 6（一般）— 上一轮（v2）**：§3.2 策略段落对 `eulerAngles`/`roll`/`pitch`/`yaw` 分类逻辑矛盾——标为「实现」但实际依赖未就绪的 stub | **已采纳**。§3.2 策略段落明确分组（v3 修订为 4 重导出 + 4 完整实现 + 7 stub）；§3.15 欧拉角函数分组（v3 修订）：4 欧拉函数归入「stub 占位」组，依赖 `trigonometric.cj` 的 `atan`/`asin` + `common.cj` 的 `clamp` + `vector_relational.cj` 的 `equal` + `scalar_constants.cj` 的 `epsilon<T>()`；§10 覆盖矩阵 gtc/quaternion 表与 §3.15 gtc/quaternion.cj 小节的状态标注完全对齐 |
| **问题 7（一般）— 上一轮（v2）**：§3.10 第 339 行 `pow` 依赖关系不准确——错误列 `asin`/`pow`、遗漏 `abs`/`clamp`/`cos` | **已采纳**。§3.10 `pow` 依赖关系修订为「依赖 `abs`/`clamp`/`acos`/`sin`/`cos`/`sqrt`（其中 `abs`/`clamp` 来自 common.cj stub，`acos`/`sin`/`cos` 来自 trigonometric.cj stub，`sqrt` 来自 std.math）+ `epsilon<T>()`」；D21 设计决策明确引用；§10 覆盖矩阵 quaternion_exponential 表同步更新 |
| **问题 8（一般）— 上一轮（v2）**：§3.11 第 354 行 `mix` 依赖关系遗漏 `epsilon<T>()`；`slerp` 描述同样遗漏 | **已采纳**。§3.11 `mix` 依赖修订为「依赖 `dot`、`acos`、`sin`、`epsilon<T>()`」；`slerp` 描述修订为「依赖 `dot`、`acos`/`sin`/`mix`（标量版）+ `epsilon<T>()`」；D21 设计决策明确引用 |
| **问题 10（一般）— 上一轮（v2）**：§3.11 第 355 行 `slerp(x, y, a, k)` 4 参数版本 `k` 类型未定 | **已采纳**。§3.11 `slerp` 4 参数版本明确签名 `slerp<T, Q>(x: Quat<T,Q>, y: Quat<T,Q>, a: T, k: Int64)`；D22 设计决策说明采用简化版（与 deviations.md DV-03 一致）；§9 差异声明新增对应条目；§10 覆盖矩阵 quaternion_common 表更新 |
| **问题 11（一般）— 上一轮（v2）**：§3.4 `Quat×Vec3`/`Quat×Vec4` 行「备注」列为空，未说明依赖 `geometric.cj stub` | **已采纳**。§3.4 `Quat×Vec3` 行备注列补充「实现：`v + (...) * 2`（两次 Vec3 叉乘 uv/uuv）。**依赖 `geometric.cj` 向量 `cross`（阶段三 stub），调用将抛 `Exception("stub")`**」；`Quat×Vec4` 行备注列补充「通过 Vec3 中间路径间接依赖 `Quat×Vec3`，阶段三调用同样抛 stub 异常」；§4.2 行为契约示例标注「本阶段调用抛 stub 异常，待阶段四 geometric.cj 完整实现后生效」；§11.5 函数可用性对照表新增对应行 |
| **问题 14（一般）— 上一轮（v2）**：§5 错误处理策略覆盖不足（5 类边界条件缺失） | **已采纳**。§5.3 新增「边界条件与异常场景」表格，列出 8 类边界条件的行为契约：① `axis` 零四元数返回 `Vec3(1,0,0)`；② 浮点 `inverse` 零四元数产生 Inf/NaN；③ 整数 `inverse` 触发除零异常；④ `mix`/`slerp` cosTheta 退化检测；⑤ `fromMat3`/`fromMat4` 非纯旋转矩阵行为未定义；⑥ `lerp` 断言失败；⑦ `equal` epsilon=0 返回 false；⑧ 整型 `epsilon<T>()` 抛运行时异常 |
| **问题 18（一般）— 上一轮（v2）**：§3.12 第 367-371 行 `epsilon<T>()`/`pi<T>()`/`cos_one_over_two<T>()` 对整数类型 T 的行为未定义 | **已采纳**。§3.12 「整数类型 T 的行为契约」段落新增，明确约束收紧策略（`T <: FloatingPointNumber<T>`）+ 运行时 fallback 异常分支；D25 设计决策明确行为；§5.3 边界条件表新增对应行；§8 编码启动前验证项新增验证项 7 |
| **问题 9（轻微）— 上一轮（v2）**：§3.11 第 352 行 `lerp` 实现策略遗漏 `assert(a >= 0 && a <= 1)` 断言，且未明确「非 const」约束 | **已采纳**。§3.11 `lerp` 描述修订为「`x * (1 - a) + y * a`，含 `assert(a >= 0 && a <= 1)` 断言与 GLM `ext/quaternion_common.inl:28-38` 一致」+「`const` 约束说明：lerp 不可声明为 `const func`，因函数体内 `assert` 不是 `const` 函数（与 deviations.md IF-03 一致）」；D23 设计决策明确；§5.4 const 上下文约束段落新增 |
| **问题 12（轻微）— 上一轮（v2）**：§3.5 第 252 行向量 `equal` 容差比较语义 `\|x-y\| <= epsilon` 与 GLM `<` 严格小于不一致 | **已采纳**。§3.5 epsilon 版本语义从「`\|x-y\| <= epsilon`」修订为「`\|x-y\| < epsilon`（严格小于，与 GLM 1.0.3 `func_vector_relational.inl:18-22` 一致）」；`notEqual` 对应改为「`\|x-y\| >= epsilon`」；D24 设计决策明确；§5.3 边界条件表新增「`epsilon = T(0)`」行；§9 差异声明新增「向量 `equal` 采用严格 `<` 语义」条目 |
| **问题 13（轻微）— 上一轮（v2）**：§3.4 与 §3.7 中 `cross` 命名歧义未充分处理 | **已采纳**。§3.4 `Quat×Vec3` 行后新增「命名约定说明」段：「上表中 `Quat×Vec3` 行公式中的 `cross(QuatVector, v)` 调用的是 **Vec3 叉乘**（定义于 `geometric.cj`，参数为 `Vec3<T,Q>`），**非 §3.7 中的四元数 `cross`（Hamilton 乘积）**」；§3.7 命名歧义说明段强化「下游消费者判别方法」三段说明（参数类型消歧 + §3.4 旋转公式内部调用明确） |
| **问题 15（轻微）— 上一轮（v2）**：§3.1 第 149 行 `@Derive[Hashable]` 在阶段一/二的实践依据未在本设计核验 | **已采纳**。§3.1 第 149 行后新增「`@Derive[Hashable]` 约束核验」段，明确 `T <: Number<T>` 和 `Q <: Qualifier` 的 Hashable 接口要求；引用阶段一 Vec3 实践（`type_vec3.cj:6` 验证）；§8 编码启动前验证项新增验证项 11「`@Derive[Hashable]` 对 `Q <: Qualifier` 的支持验证」 |
| **问题 16（轻微）— 上一轮（v2）**：§3.14 与 §8.5 对 fwd.cj 别名清单的细节未明确（`BQuat`/`IQuat` 是否包含、`Quat`/`FQuat` 双别名机制） | **已采纳**。§3.14 fwd.cj 别名表重写为完整 8 行（Quat/FQuat/DQuat/3×Float32 精度/3×Float64 精度）+「排除项」段（不含 BQuat/IQuat/I64Quat/BQuat 精度变体，理由与阶段二策略一致）；「`Quat` 与 `FQuat` 双别名机制」段新增说明（与阶段二 `Mat2x2`/`FMat2x2` 模式一致）；D27 设计决策明确 |
| **问题 17（轻微）— 上一轮（v2）**：§8 验证项与 §2 末尾的 cjpm 子包构建预验证策略未对齐（阶段二 ext/ 子包验证结果、阶段三 gtc/ 子包回退方案） | **已采纳**。§2 末尾 cjpm 子包构建预验证段重写为「阶段二已通过验证：[已通过 cjpm 验证]」+「阶段三新增 gtc/ 需原型验证」+ 三个验证项（gtc 子包 + gtc 重导出 detail 函数 v3 新增 + 回退方案）；§8 编码启动前验证项 1 与之对齐 |
| **问题 19（轻微）— 上一轮（v2）**：部分接口边界契约对下游消费者的影响未充分说明（`identity` 调用提示、`fromQuat` 闭包示例、`Quat×Vec3` stub 标注、stub 函数对照表） | **已采纳**。§3.3 各工厂函数新增「调用示例」代码块（identity / fromQuat）；§3.3 fromMat3/fromMat4 新增「边界行为」契约声明（仅对纯旋转矩阵有效）；§3.11 inverse 新增「边界行为」（浮点 Inf/NaN vs 整数除零异常）；§11 新增「下游消费者迁移指南」独立章节（5 类迁移场景 + 函数可用性对照表 19 行，覆盖本阶段/阶段四状态） |

---

## 修订说明（v4）

> **修订定位**：v3 设计的迭代修订（v4）。依据本轮审查报告（a_v2_review_v2.md）识别 2 项问题（1 一般 + 1 轻微）开展修订，在保留 v3 设计所有修订成果的基础上，针对 `isnan`/`isinf` 函数约束缺失与 Quat 字段可见性描述缺失 2 个本轮新识别问题进行强化。

| 审查意见 | 修改措施 |
|---------|---------|
| **问题 1（一般）— 本轮新识别**：`ext/quaternion_common.cj` 中 `isnan(q: Quat<T,Q>): Vec4<Bool,Q>` 与 `isinf(q: Quat<T,Q>): Vec4<Bool,Q>` 函数缺少 `where T <: FloatingPointNumber<T>` 类型约束。`std.math` 的 `isNaN()`/`isInf()` 实例方法仅定义于浮点类型（`FloatingPoint<T>` 接口），整数类型（`Int8`/`Int16`/`Int32`/`Int64`）无此方法。函数体内部使用 `q.x.isNaN()`/`q.x.isInf()` 实例方法路径（`Vec4(q.x.isNaN(), q.y.isNaN(), q.z.isNaN(), q.w.isNaN())`），当用户实例化 `Quat<Int64, PackedHighp>` 调用 `isnan(q)` 时，函数体内部 `q.x.isNaN()` 因 Int64 不实现 `isNaN()` 而编译失败 | **已采纳审查报告建议方向**。**核心修复**：§3.11 `isnan`/`isinf` 函数描述新增「T 类型约束（v4 修订）」段落，明确函数签名添加 `where T <: FloatingPointNumber<T>` 约束，限制函数仅对浮点类型 T 可调用——与 §3.12 `epsilon<T>()` 约束收紧策略（v3 已明确）保持一致。**Fallback 模式**：若仓颉泛型不支持窄类型约束（如 `FloatingPointNumber<T>` 接口不可用），则采用与 `epsilon<T>()` 相同的运行时分派模式——对 `q.x` 的具体类型进行 `Float32`/`Float64` 分派（通过 `match` 或 `if-else`），非浮点 T 实例化时抛 `Exception("isnan/isinf not defined for non-floating-point types")`。**同步修订**：D29 设计决策新增（「`isnan`/`isinf` 函数约束收紧为 `where T <: FloatingPointNumber<T>`」）；§5.3 边界条件表新增「整型 T / `isnan(q)`/`isinf(q)`」行（编译失败 + fallback 异常分支）；§8 编码启动前验证项新增验证项 13（v4 新增）；§9 差异声明新增「`isnan`/`isinf` 函数约束收紧为 `where T <: FloatingPointNumber<T>`（v4 新增）」条目；§10 覆盖矩阵 `quaternion_common` 表中 `isnan(Quat)`/`isinf(Quat)` 行新增「约束 `T <: FloatingPointNumber<T>`，v4 修订」标注；§11.5 函数可用性对照表 `isnan`/`isinf` 行修订为「✅ 可用（仅浮点 T，整型 T 编译失败，v4 约束收紧）」 |
| **问题 2（轻微）— 本轮新识别**：设计 §3.1 描述 Quat 数据成员为 `var x: T, var y: T, var z: T, var w: T`，未显式标注 `public`。按 `cangjie-std/deriving/README.md` 第 4 节约束「参与派生的字段/属性必须为 public」，`@Derive[Hashable]` 派生要求字段为 public；按 `struct/README.md` 第 1.7 节，struct 字段默认可见性为 internal，不满足 public 派生要求。阶段一 Vec3 (`type_vec3.cj:8-10`)、阶段二全部 Mat (`type_mat*.cj` 200+ 处) 均使用 `public var` 标注以保证 `@Derive[Hashable]` 派生成功 | **已采纳审查报告建议方向**。**核心修复**：§3.1 数据成员描述从 `var x: T, var y: T, var z: T, var w: T` 修订为 `public var x: T, public var y: T, public var z: T, public var w: T`，显式标注 `public` 可见性；§3.1 数据布局选择段中「数据成员声明为 `var x, var y, var z, var w`」同步修订为 `public var x, public var y, public var z, public var w` 并新增说明「显式标注 `public` 以满足 `@Derive[Hashable]` 派生对字段 public 可见性的要求，与阶段一 Vec3、阶段二全部矩阵类型（200+ 处）的实践对齐」。**强化 §3.1 `@Derive[Hashable]` 约束核验段**：从 v3 的「v3 新增」修订为「v3 新增，v4 强化」，明确列出派生宏的两条硬性要求（①泛型 type parameter 满足 `Hashable` 接口；②参与派生的字段/属性必须为 `public` 可见性），并新增「字段可见性约束（v4 新增）」段落说明「若省略 `public` 关键字，struct 字段默认可见性为 `internal`，不满足 public 派生要求」。**同步修订**：D30 设计决策新增（「Quat 字段统一标注 `public var`」）；§8 编码启动前验证项新增验证项 14（v4 新增：Quat 字段 `public var` 可见性验证）；§9 差异声明新增「Quat 字段统一标注 `public var`（v4 新增）」条目 |

---

## 修订说明（v5）

> **修订定位**：v4 设计的迭代修订（v5）。依据本轮审查报告（b_v2_diag_v1.md）识别 2 项严重问题 + 8 项一般问题 + 4 项轻微问题（合计 14 项，LOCATED 质询结果确认诊断结论可信）开展修订。修订重点：`axis()` 函数边界行为契约与 GLM 实际行为对齐（严重）、`pow` 依赖关系完整性（严重）、`log`/`exp`/`slerp` 4 参数版本依赖补齐、`axis` 同段自相矛盾、路线图同步、`gtc/quaternion.cj` 表格表述冲突、`conjugate` 描述纠正、`type_quat_cast` 函数签名规范、轻微问题（lib.cj/fwd.cj 清单、`pow` 命名消歧、`mix` 重载版本、Hashable 实践依据）。

| 审查意见 | 修改措施 |
|---------|---------|
| **问题 1（严重）**：`axis()` 函数边界行为契约与 GLM 1.0.3 实际行为不符——v3 §3.9 描述的「内部 `normalize(Vec3(0, 0, 0))` 返回 `Vec3(T(1), T(0), T(0))`」为虚构实现，GLM `ext/quaternion_trigonometric.inl:20-27` 实际使用 `tmp1 = 1 - x.w*x.w` 独立公式；触发 `Vec3(0, 0, 1)` 返回值的条件为 `\|w\| >= 1`（单位四元数 (0,0,0,1)）而非 `q.xyz == 0`；行号引用 `quaternion_geometric.inl:20-21` 错误 | **已采纳**。**核心修复**：§3.9 `axis` 函数描述完整重写，明确实现公式（与 GLM `ext/quaternion_trigonometric.inl:20-27` 一致）：`tmp1 = T(1) - x.w*x.w`；若 `tmp1 <= T(0)` 返回 `Vec3(T(0), T(0), T(1))`；否则 `tmp2 = T(1)/sqrt(tmp1)` 返回 `Vec3(x.x*tmp2, x.y*tmp2, x.z*tmp2)`。删除「内部 `normalize(Vec3(0, 0, 0))`」虚构描述。**同步修订**：§5.3 边界条件表修订「零四元数 / `axis(q)`」行为契约为「`1 - x.w*x.w <= 0` 时返回 `Vec3(T(0), T(0), T(1))`；真正零四元数 `(0,0,0,0)` 返回 `Vec3(0, 0, 0)`」；新增「真正零四元数 / `axis(q)`」行；§9 差异声明条目修订为「`axis` 触发条件为 `1 - w² <= 0` 而非 q.xyz == 0」并明确 v3 原描述错误纠正；§10 覆盖矩阵 `quaternion_trigonometric.hpp` 表 `axis` 行同步修订；D31 设计决策新增（v5 关键修订：`axis` 函数实现采用 GLM 独立公式路径而非 `normalize` 路径） |
| **问题 2（严重）**：`pow` 函数依赖关系不完整 + 行号引用错误——v3 §3.10 遗漏 `cos_one_over_two<T>()`（line 52）、`asin`（line 68）、递归调用 `std.math.pow(T,T)`（line 65）、`std::numeric_limits<T>::min()` 等价物（line 63），行号引用 `quaternion_exponential.inl:24-43` 错误（应为 41-80） | **已采纳**。**核心修复**：§3.10 `pow` 函数依赖关系完整重写，明确列出 `epsilon<T>()`/`abs`/`clamp`/`asin`/`acos`/`sin`/`cos`/`sqrt`/`cos_one_over_two<T>()` + 递归调用 `std.math.pow(T, T)`（实数降级路径）+ `std::numeric_limits<T>::min()` 等价的仓颉次正规数边界检查；行号修订为 `quaternion_exponential.inl:41-80`；新增「命名消歧」段落明确四元数 `pow` 函数体内部调用的是 `std.math.pow(T, T): T` 实数版本，与四元数 `pow` 通过参数类型消歧，若 `std.math.pow` 不存在需以 `exp(y * log(x.w))` 替代。**同步修订**：D21 设计决策从「依赖 `epsilon<T>()`」强化为「依赖 `epsilon<T>()`/`cos_one_over_two<T>()`/`asin`/递归 `std.math.pow`/`std::numeric_limits<T>::min()` 等价物」并引用具体行号；§10 覆盖矩阵 `quaternion_exponential.hpp` 表 `pow` 行同步修订；§8 编码启动前验证项新增验证项 15（`pow` 函数四元数版本与 `std.math.pow` 实数版本命名消歧验证）+ 验证项 16（次正规数边界检查 `FloatingPointNumber<T>.getMin()` 验证） |
| **问题 3（一般）**：`log` 函数依赖关系遗漏 `epsilon<T>()`/`pi<T>()` 与 `std::numeric_limits<T>::infinity()` 等价处理策略 | **已采纳**。§3.10 `log` 函数依赖修订为「依赖 `length`/`epsilon<T>()`（line 23 `Vec3Len < epsilon<T>()` 退化检测）/`pi<T>()`（line 28 `wxyz(log(-q.w), pi<T>(), ...)`）/`atan`/`log`（trigonometric.cj/exponential.cj 接口）+ `std::numeric_limits<T>::infinity()` 等价物（line 30 用于 w=0 退化分支，仓颉版本建议优先 `FloatingPointNumber<T>.getInf()` 实例方法，fallback 为 `T(1)/T(0)` 显式构造）」；§10 覆盖矩阵 `quaternion_exponential.hpp` 表 `log` 行同步修订；§8 编码启动前验证项新增验证项 18（`log` 函数 `std::numeric_limits<T>::infinity()` 等价物验证） |
| **问题 4（一般）**：`exp` 函数依赖关系遗漏 `epsilon<T>()` | **已采纳**。§3.10 `exp` 函数依赖修订为「依赖 `length`/`epsilon<T>()`（line 10 `Angle < epsilon<T>()` 退化检测）/`cos`/`sin`」；§10 覆盖矩阵 `quaternion_exponential.hpp` 表 `exp` 行同步修订 |
| **问题 5（一般）**：`slerp` 4 参数版本依赖关系遗漏 `pi<T>()` 与 `mix`（标量版） | **已采纳**。§3.11 `slerp` 4 参数版本依赖补充「`pi<T>()`（line 107 `T phi = angle + static_cast<T>(k) * glm::pi<T>();`）+ `mix`（标量版，line 98-101 四次标量 `mix` 调用）」；§10 覆盖矩阵 `quaternion_common.hpp` 表 `slerp` 4 参数行同步修订 |
| **问题 6（一般）**：§3.9 `axis` 函数依赖描述自相矛盾——前半部声明「依赖 `sqrt` 和 T(1) 演算，可完整实现」对应 GLM 实际公式路径，后半部引用「内部 `normalize(Vec3(0,0,0))`」对应 GLM 未采用路径 | **已采纳**。在采纳问题 1 修复方案后，§3.9 `axis` 函数描述统一为「实现公式 `tmp1 = T(1) - x.w*x.w`，依赖仅 `std.math.sqrt` 和 T(1) 演算（通过 `x.w*x.w` 取得），**可完整实现**」；删除「内部 `normalize(Vec3(0, 0, 0))`」的错误描述。逻辑自洽，问题 6 自然消除 |
| **问题 7（一般）**：路线图 `02_roadmap.md` 与 v3 设计在阶段三验证标准上存在三处不一致——`slerp` 可验证性冲突、`lookRotate` 命名未同步修正、`ext/quaternion_common.cj` 可验证性范围过广 | **已采纳**。新增 §3.16「路线图同步修订建议（v5 新增）」独立小节，明确三处路线图修订建议：(1) `02_roadmap.md` 第 125 行 `slerp` 修订为 `[待 Stage 4，依赖 trigonometric.cj 完整实现]`；(2) 第 89/102/111/129/152/163/207 行 `lookRotate` 修订为 `quatLookAt`/`quatLookAtRH`/`quatLookAtLH`；(3) 第 130 行 `ext/quaternion_common.cj` 修订为排除 `mix`/`slerp` stub 部分；新增「阶段三验证标准双向映射表」统一路线图 `[可验证]`/`[部分可验证]`/`[待 Stage 4]` 三级分类与本设计 ✅/⚠️/❌ 符号的对应关系 |
| **问题 8（一般）**：§3.15 `gtc/quaternion.cj` 表格欧拉角行单元格同时给出「完整实现（v3 修正）」与「改为 stub 占位（v3 最终决策）」两个相互矛盾的粗体标注 | **已采纳**。§3.15 表格欧拉角函数组单元格修订为「**stub 占位**（v5 最终决策，原误标为完整实现）」，删除中间冲突表述 |
| **问题 9（一般）**：`conjugate` 函数描述与 GLM 实际实现不一致——v3 描述「仅涉及逐分量取反」，GLM `ext/quaternion_common.inl:112-116` 实际是 `wxyz(q.w, -q.x, -q.y, -q.z)`（w 不变，仅 x/y/z 取反） | **已采纳**。§3.11 `conjugate` 描述修订为「**完整实现**」「仅对 x/y/z 三个分量取反，w 分量保持不变：`Quat(-q.x, -q.y, -q.z, q.w)`（与 GLM `ext/quaternion_common.inl:112-116` `wxyz(q.w, -q.x, -q.y, -q.z)` 一致）」；§10 覆盖矩阵 `quaternion_common.hpp` 表 `conjugate` 行同步修订语义说明 |
| **问题 10（一般）**：`detail/type_quat_cast.cj` 函数签名细节未定义——`mat3Cast`/`mat4Cast`/`quatCast(Mat3)`/`quatCast(Mat4)` 4 个函数的具体签名（泛型参数、约束、返回类型）未给出 | **已采纳**。新增 §3.2.1「type_quat_cast 函数签名规范（v5 新增）」子节，给出 4 个函数的标准签名模板：`mat3Cast<T, Q>(q: Quat<T, Q>): Mat3x3<T, Q> where T <: FloatingPointNumber<T>, Q <: Qualifier` 等，明确 `T <: FloatingPointNumber<T>` 约束收紧策略（与 D29 同类策略一致）+ 重载区分规则（参数类型 `Mat3x3<T,Q>` vs `Mat4x4<T,Q>`）+ Fallback 模式（非浮点 T 抛 `Exception(...)`）；D32 设计决策新增；§10 覆盖矩阵 `type_quat_cast.hpp` 表新增签名约束标注；§5.3 边界条件表新增「整型 T / 转换函数」行；§8 编码启动前验证项新增验证项 17（`type_quat_cast` 函数 `FloatingPointNumber<T>` 约束可用性验证）；§11.5 函数可用性对照表 `mat3_cast`/`mat4_cast`/`quat_cast` 行新增「仅浮点 T，整型 T 编译失败」标注 |
| **问题 11（轻微）**：`lib.cj`/`fwd.cj` 具体更新内容未明确——§2 仅描述「新增 public import」与「新增 type alias」，未列出具体清单 | **已采纳**。§2 包组织 `glm` 块下新增「lib.cj 新增 import 清单（v5 明确）」（8 个 `import` 声明：`Quat/mat3Cast/mat4Cast/quatCast` + 6 个 ext/gtc 模块）+「fwd.cj 新增 type alias 清单（v5 明确）」（8 个别名：`Quat`/`FQuat`/`DQuat` + 3×Float32 精度 + 3×Float64 精度，含排除项）；§8 更新文件段同步引用 §2 新增的清单段落 |
| **问题 12（轻微）**：`pow` 函数递归调用 `pow` 的命名消歧未说明——四元数 `pow` 与 `std.math.pow` 未区分，若 `std.math.pow` 不存在时如何降级未说明 | **已采纳**。§3.10 `pow` 描述新增「命名消歧（v5 新增）」段落，明确四元数 `pow` 函数体内部调用的是实数版本 `std.math.pow(T, T): T`，与四元数 `pow` 通过参数类型消歧；若 `std.math.pow` 不存在需以 `exp(y * log(x.w))` 替代实现；§8 编码启动前验证项新增验证项 15（命名消歧验证） |
| **问题 13（轻微）**：`mix` 函数依赖中 `acos`/`sin` 重载版本未明确——GLM 实际使用 `acos(cosTheta)` 与 `sin(...)` 单参数版本，v3 未明确 `trigonometric.cj` 需提供哪些重载 | **已采纳**。§3.11 `mix`/`slerp` 描述修订为「依赖 `dot`/`acos(cosTheta)`（`trigonometric.cj` 的 `acos(T): T` 单参数版本，`v5 修订明确`）/`sin(...)`（`trigonometric.cj` 的 `sin(T): T` 单参数版本，`v5 修订明确`）」；§10 覆盖矩阵 `quaternion_common.hpp` 表 `mix`/`slerp` 行同步修订明确 trigonometric.cj 单参数重载版本 |
| **问题 14（轻微）**：`@Derive[Hashable]` 派生所需 Qualifier Hashable 实现未充分核验——6 个 Qualifier 实现类型是否全部为标记类型且 Hashable 接口自动派生，实践依据未具体引用阶段二文件 | **已采纳**。§3.1 `@Derive[Hashable]` 约束核验段新增「实践依据（v5 明确）」子段落，明确引用阶段一 `type_vec3.cj:6` + 阶段二全部 9 个 `type_mat*.cj` 文件（200+ 处统一实践，已 grep 验证）+ 阶段三前提条件（不新增 Qualifier 变体）+ 阶段三若新增 Qualifier 变体或数据结构变更需重新验证；§8 编码启动前验证项 11 精简为「引用阶段二已验证实践，若阶段三新增 Qualifier 变体或数据结构变更则需重新验证」 |

---

## 修订说明（v6）

> **修订定位**：v5 设计的迭代修订（v6）。本轮依据 `a_v3_iteration_requirement.md` 提出的 2 项严重问题 + 8 项一般问题 + 4 项轻微问题（合计 14 项），逐项核验 v5 设计中已落实的修复措施，确认所有审查意见均已在 v5 设计中得到正确处理。本轮不引入新的设计变更，仅在 v5 基础上对 3 处表述细节进行少量澄清强化（pow 函数 fallback 精度依赖、log 函数 infinity fallback 类型约束、路线图修订状态标注）。

### 14 项审查意见落实情况核验表

| 审查意见 | 严重程度 | v5 落实位置 | 核验结论 |
|---------|---------|------------|---------|
| 问题 1：`axis()` 函数边界行为契约与 GLM 1.0.3 实际行为不符（虚构 `normalize(Vec3(0,0,0))` 实现 + 行号错误） | 严重 | §3.9 / §5.3 边界条件表 / §9 差异声明 / §10 覆盖矩阵 / D31 | **已完整修复**（删除虚构 `normalize` 描述，明确 GLM `tmp1 = 1 - x.w*x.w` 独立公式路径，触发条件 `tmp1 <= 0`） |
| 问题 2：`pow` 函数依赖关系不完整（遗漏 `cos_one_over_two<T>()`/`asin`/递归 `std.math.pow`/`std::numeric_limits<T>::min()` 等价物）+ 行号引用错误 | 严重 | §3.10 / D21 / §10 / §8 编码启动前验证项 15/16 | **已完整修复**（依赖关系完整重写 + 行号修订为 `quaternion_exponential.inl:41-80` + 新增「命名消歧」段） |
| 问题 3：`log` 函数依赖关系遗漏 `epsilon<T>()`/`pi<T>()`/`std::numeric_limits<T>::infinity()` 等价物 | 一般 | §3.10 / §10 覆盖矩阵 / §8 编码启动前验证项 18 | **已完整修复**（补充 line 23/28/30 全部依赖 + `FloatingPointNumber<T>.getInf()` + `T(1)/T(0)` fallback） |
| 问题 4：`exp` 函数依赖关系遗漏 `epsilon<T>()` | 一般 | §3.10 / §10 覆盖矩阵 | **已完整修复**（补充 line 10 `Angle < epsilon<T>()` 退化检测依赖） |
| 问题 5：`slerp` 4 参数版本依赖关系遗漏 `pi<T>()` 与 `mix`（标量版） | 一般 | §3.11 / §10 覆盖矩阵 | **已完整修复**（补充 line 107 `pi<T>()` + line 98-101 四次标量 `mix` 调用依赖） |
| 问题 6：§3.9 `axis` 函数依赖描述自相矛盾 | 一般 | §3.9 | **已完整修复**（统一为「依赖仅 `std.math.sqrt` 和 T(1) 演算」，删除「内部 `normalize`」错误描述） |
| 问题 7：路线图 `02_roadmap.md` 与 v3 设计在阶段三验证标准上存在三处不一致 | 一般 | §3.16（新增「路线图同步修订建议」）/ §3.16 末尾「阶段三验证标准双向映射表」 | **已完整修复**（明确三处路线图修订建议：`slerp` 可验证性 / `lookRotate` 命名 / `quaternion_common.cj` 范围） |
| 问题 8：§3.15 `gtc/quaternion.cj` 表格欧拉角行单元格表述冲突 | 一般 | §3.15 表格 | **已完整修复**（单元格统一修订为「**stub 占位**（v5 最终决策，原误标为完整实现）」，删除中间冲突表述） |
| 问题 9：`conjugate` 函数描述与 GLM 实际实现不一致（v3 误称「仅涉及逐分量取反」） | 一般 | §3.11 / §10 覆盖矩阵 | **已完整修复**（修订为「仅对 x/y/z 取反，w 保持不变：`Quat(-q.x, -q.y, -q.z, q.w)`」，与 GLM `ext/quaternion_common.inl:112-116` `wxyz(q.w, -q.x, -q.y, -q.z)` 一致） |
| 问题 10：`detail/type_quat_cast.cj` 函数签名细节未定义 | 一般 | §3.2.1（新增「type_quat_cast 函数签名规范」）/ D32 / §10 / §5.3 / §8 编码启动前验证项 17 / §11.5 | **已完整修复**（明确 4 个函数签名模板 + `T <: FloatingPointNumber<T>` 约束收紧策略 + 重载区分规则 + Fallback 模式） |
| 问题 11：`lib.cj`/`fwd.cj` 具体更新内容未明确 | 轻微 | §2 包组织 `glm` 块下 | **已完整修复**（新增「lib.cj 新增 import 清单（v5 明确）」（8 个 `import` 声明）+「fwd.cj 新增 type alias 清单（v5 明确）」（8 个别名，含排除项）） |
| 问题 12：`pow` 函数递归调用 `pow` 的命名消歧未说明 | 轻微 | §3.10「命名消歧（v5 新增）」段 / §8 编码启动前验证项 15 | **已完整修复**（明确 `std.math.pow(T, T): T` 实数版本与四元数 `pow` 通过参数类型消歧 + `exp(y * log(x.w))` 替代实现 fallback） |
| 问题 13：`mix` 函数依赖中 `acos`/`sin` 重载版本未明确 | 轻微 | §3.11 / §10 覆盖矩阵 | **已完整修复**（明确 `trigonometric.cj` 需提供 `acos(T): T`/`sin(T): T` 单参数重载版本） |
| 问题 14：`@Derive[Hashable]` 派生所需 Qualifier Hashable 实现未充分核验 | 轻微 | §3.1「`@Derive[Hashable]` 约束核验」段 / §8 编码启动前验证项 11 | **已完整修复**（新增「实践依据（v5 明确）」子段落，引用阶段一 `type_vec3.cj:6` + 阶段二全部 9 个 `type_mat*.cj` 文件 200+ 处统一实践） |

### v6 补充强化项

在确认 v5 已落实所有 14 项审查意见的基础上，本轮对以下 3 处表述细节进行补充强化（**非问题修正，仅澄清**）：

1. **§3.10 `pow` 函数 fallback 路径精度依赖澄清**
   - v5 已说明「若 `std.math.pow` 不存在需以 `exp(y * log(x.w))` 替代实现」，但未明确替代实现的精度依赖。
   - **v6 澄清**：替代实现 `exp(y * log(x.w))` 仍调用实数 `log`/`exp`，依赖仓颉 `std.math.log(T): T` 与 `std.math.exp(T): T` 函数可用性，与原 `pow(x.w, y)` 实现路径具有相同的依赖边界。两种实现路径的依赖收敛点一致（最终均止于 `std.math` 顶层实数函数），仅当仓颉标准库同时缺失 `pow`/`exp`/`log` 三个实数函数时整个实现才不可用。

2. **§3.10 `log` 函数 `infinity` fallback 类型约束澄清**
   - v5 已说明 `log` 函数依赖 `std::numeric_limits<T>::infinity()` 等价物，并给出「fallback 为 `T(1)/T(0)` 显式构造」策略，但未明确该 fallback 仅对浮点类型 T 有效。
   - **v6 澄清**：`T(1)/T(0)` 显式构造仅对浮点类型 T 有效；整数类型（如 `Int64`）执行 `Int64(1)/Int64(0)` 会触发仓颉整数除零异常，与 GLM `std::numeric_limits<int>::infinity()` 行为不一致。整数四元数调用 `log` 时建议改用 `isnan`/`isinf` 边界检查跳过退化分支（结合 D29 `isnan`/`isinf` 约束收紧策略，整数 T 在编译期即被排除调用）。

3. **§3.16 路线图修订状态标注澄清**
   - v5 §3.16 已明确建议修订 `02_roadmap.md` 三处不一致（`slerp` 可验证性 / `lookRotate` 命名 / `quaternion_common.cj` 范围），但未标注这些修订是否已实际完成。
   - **v6 澄清**：`02_roadmap.md` 的修订属于「设计文档 → 路线图文档」的同步建议，路线图的实际修订应在 v3 迭代结束后由项目管理流程执行；本设计文档不再依赖路线图的特定标注（如 `[可验证]`/`[部分可验证]`/`[待 Stage 4]` 三级分类），下游验证以本设计 §11.5「函数可用性对照表」的 ✅/⚠️/❌ 符号为准。

### v3 迭代状态总结

经过 v2（v3 设计）→ v3（v4 设计）→ v4（v5 设计）→ v6 共 4 轮设计修订，v3 迭代提出的 14 项审查意见均已落实：

- **2 项严重问题**（`axis` 边界行为契约与 GLM 实际行为不符 + `pow` 依赖关系不完整 + 行号错误）：均已在 v5 设计中完整修复，v6 补充 1 项相关 fallback 精度依赖澄清
- **8 项一般问题**（`log`/`exp`/`slerp` 4 参数版依赖遗漏 + `axis` 自相矛盾 + 路线图不一致 + §3.15 表格冲突 + `conjugate` 描述不符 + `type_quat_cast` 签名细节缺失）：均已在 v5 设计中完整修复，v6 补充 1 项 `log` 函数 `infinity` fallback 类型约束澄清
- **4 项轻微问题**（`lib.cj`/`fwd.cj` 清单缺失 + `pow` 命名消歧未说明 + `mix` 重载版本未明确 + `@Derive[Hashable]` 实践依据不足）：均已在 v5 设计中完整修复

v3 迭代整体完成，可进入下游验证环节。

---

## 修订说明（v7）

> **修订定位**：v6 设计的迭代修订（v7）。依据本轮审查报告（a_v3_review_v1.md）识别 1 项一般问题 + 4 项轻微问题开展修订。在 v6 设计（已落实 v3 迭代的 14 项审查意见：2 严重 + 8 一般 + 4 轻微）的基础上，本轮对 `FloatingPointNumber<T>` 接口命名统一为仓颉 stdlib 原生 `FloatingPoint<T>`，并补充 4 项设计意图澄清注释。本轮不引入新的设计变更，仅做接口命名统一与 4 处表述强化。

### 5 项审查意见落实情况核验表

| 审查意见 | 严重程度 | v7 落实位置 | 核验结论 |
|---------|---------|------------|---------|
| 问题 1（一般）：全文 `FloatingPointNumber<T>` 接口命名与仓颉 stdlib `FloatingPoint<T>` 不一致（stdlib `cangjie-std/math/README.md` 第 117 行明确定义为 `FloatingPoint<T>`/`Integer<T>`/`Number<T>` 三层接口，文档中无 `FloatingPointNumber<T>` 接口定义）；且 §3.11 描述文本与 where 子句使用不同接口名，存在设计内部不一致；§8 验证项 16/17/18 基于标准库不存在的接口展开，验证目标本身不可达 | 一般 | §3.2.1（4 处函数签名 + 2 处描述文本）/ §3.10（log + pow 函数依赖描述）/ §3.11（isnan + isinf 描述段与函数签名）/ §3.12（整数类型 T 行为契约段）/ §5.3 边界条件表（2 行）/ D21 / D29 / D32 设计决策 / §8 编码启动前验证项 13/16/17/18 / §9 差异声明 / §10 覆盖矩阵 type_quat_cast 表 4 行 + quaternion_common 表 2 行 | **已完整修复**（全文统一替换 `FloatingPointNumber<T>` → `FloatingPoint<T>`，约 35+ 处修订；§3.11 内部不一致消除：D29 已使用 `FloatingPoint<T>` 字样与 where 子句对齐；§8 验证项 13 中「若 `FloatingPointNumber<T>` 接口不可用」措辞修订为「`FloatingPoint<T>` 是 stdlib 原生接口，无「不可用」风险，无需 fallback 验证」） |
| 问题 2（轻微）：D17 决策「Bool 四元数不支持算术运算」未在 §3.4 运算符体系表备注中增加「Bool 四元数因 `Bool` 不实现 `Number<T>` 接口，编译期自动拒绝算术运算」一句话澄清 | 轻微 | §3.4 运算符体系表后 | **已完整修复**（新增「**Bool 四元数算术运算编译期拒绝（v7 澄清）**」段，明确算术运算符以 `Number<T>` 为约束，`Bool` 不实现该接口，`Quat<Bool, Q>` 实例化时算术运算符重载编译期自动拒绝；与阶段二 D33 Bool 矩阵策略一致） |
| 问题 3（轻微）：§3.10 `pow` 函数依赖 `std.math.pow(T, T): T` 实数降级路径，但 stdlib 实际仅支持 Float64 输入/输出；§3.10「命名消歧」段未明确 `pow(Quat<Float32, Q>, Float32)` 路径需先显式转换至 Float64 再降级，fallback `exp(y * log(x.w))` 同步需 Float64 转换 | 轻微 | §3.10 `pow` 函数描述 | **已完整修复**（在「命名消歧」段后新增「**Float64 转换依赖（v7 澄清）**」子段：明确 `pow(Quat<Float32, Q>, Float32)` 实现路径需先显式将 `x.w`/`y` 转换至 Float64 再调用 `std.math.pow`，fallback 路径 `exp(y * log(x.w))` 同步需 Float64 转换；§8 编码启动前验证项 15 同步补充此依赖） |
| 问题 4（轻微）：§3.16「路线图同步修订建议」未明确「本设计的可用性标注（§11.5）是阶段三验证的权威基准」 | 轻微 | §3.16 末尾「阶段三验证标准双向映射表」后 | **已完整修复**（新增「**§11.5 权威基准说明（v7 澄清）**」段：明确本设计 §11.5「函数可用性对照表」的 ✅/⚠️/❌ 符号标注是阶段三验证的权威基准，路线图三级标注在 v3 迭代结束后由项目管理流程同步修订，本设计文档不再依赖路线图标注作为验证依据；同时与 §3.16 三处修订建议形成「设计独立可验证性 + 路线图同步建议」的双重保障） |
| 问题 5（轻微）：§3.4「Vec extend 块成员运算符」表备注列说明「本阶段可验证，通过 inverse 路径」时，未明确 `inverse` 自身依赖 `quaternion_geometric.cj.dot` 已实现的链路 | 轻微 | §3.4「Vec extend 块成员运算符」表后 | **已完整修复**（新增「**实现链路注释（v7 澄清）**」段：明确本阶段 `Vec3×Quat`/`Vec4×Quat` 可立即调用的完整依赖链 `Vec×Quat` → `inverse`（§3.11 已完整实现）→ `conjugate(q) / dot(q, q)`，其中 `conjugate` 无外部依赖、`dot` 由 `quaternion_geometric.cj`（§3.7）已完整实现；强化与 `Quat×Vec3`（依赖 `geometric.cj` 向量 `cross` stub）的对比） |

### v7 修订特点

本轮修订具有以下特点：

1. **接口命名对齐 stdlib**：将全文 `FloatingPointNumber<T>` 统一为 `FloatingPoint<T>`，与仓颉 stdlib `cangjie-std/math/README.md` 第 117 行定义的 `FloatingPoint<T>`/`Integer<T>`/`Number<T>` 三层接口体系对齐。修复后，开发人员按设计字面实现 `where T <: FloatingPoint<T>` 约束时，编译器可正常识别 stdlib 原生接口，§3.2.1 / §3.11 / §3.12 / §5.3 / §10 的「编译期拒绝非浮点 T 实例化」设计意图完全落地。`FloatingPoint<T>` 是 stdlib 原生接口，编译期保证可用，无需 runtime fallback。

2. **设计内部不一致消除**：v6 设计的 D29 设计决策已正确使用 `FloatingPoint<T>` 字样，但 §3.11 `isnan`/`isinf` 描述段、where 子句、§3.12 描述段、§5.3 边界条件表等多处仍使用 `FloatingPointNumber<T>`，形成「决策正确 + 描述错误」的设计内部不一致。v7 统一为 `FloatingPoint<T>` 后，决策、描述、验证项三个层面的接口命名完全一致。

3. **设计意图澄清注释**：新增 4 项轻微问题澄清注释（§3.4 Bool 四元数编译期拒绝 / §3.10 pow Float64 转换依赖 / §3.16 §11.5 权威基准 / §3.4 Vec extend 块实现链路），强化设计可读性，便于下游编码与测试理解设计意图。澄清内容均为「非问题修正，仅澄清」，未引入新的设计约束或决策。

4. **不引入新设计变更**：v7 修订严格限定在「接口命名统一 + 4 处设计意图澄清」范围内，不修改任何函数行为、类型形态、依赖关系、文件归属、测试用例数、覆盖范围等设计要素。前序 v2/v3/v4/v5/v6 修订的 14 项审查意见落实情况保持不变。

### 历史迭代状态总结

经过 v1（v2 设计）→ v2（v3 设计）→ v3（v4 设计）→ v4（v5 设计）→ v5（v6 设计）→ v6（v7 设计）共 6 轮设计修订：

- **v2（v3 设计）**：新增 14 项审查意见 → 落实 13 项，遗留 1 项（`gtc/quaternion.cj` 文件规划缺失）
- **v3（v4 设计）**：新增 2 项严重问题（包间循环依赖 + 依赖方向内部矛盾）→ 全部修复；同步补齐 v2 遗留项
- **v4（v5 设计）**：上一轮 14 项审查意见（2 严重 + 8 一般 + 4 轻微）→ 全部修复
- **v5（v6 设计）**：核实 v5 已落实 14 项 → 全部确认 + 3 处表述细节澄清
- **v6（v7 设计，本轮）**：本轮 5 项审查意见（1 一般 + 4 轻微）→ 全部修复

v6 迭代整体完成，可进入下游验证环节。

---

## 修订说明（v8）

> **修订定位**：v7 设计的迭代修订（v8）。依据本轮审查报告（`a_v4_iteration_requirement.md` 对应 v3 诊断报告 `b_v3_diag_v1.md`）识别 4 项严重问题 + 5 项一般问题 + 2 项轻微问题（合计 11 项）。在 v7 设计（已落实前序 5 项审查意见：1 一般 + 4 轻微）的基础上，本轮针对 11 项问题逐项开展修订。

### 11 项审查意见落实情况核验表

| 审查意见 | 严重程度 | v8 落实位置 | 核验结论 |
|---------|---------|------------|---------|
| **问题 1（严重）**：`gtc/constants` 函数数量自相矛盾——文字描述「25 个」与 §3.12 函数名清单（28 个）及 GLM 1.0.3 实际声明数（28 个）不一致 | 严重 | §1 核心抽象表 / §2 lib.cj import 清单 / §2 gtc 块包组织 / §3.12 gtc/constants 段 / §7 D10 / §8 产出物清单「完整实现」段 / §10 覆盖矩阵 gtc/constants.hpp 表 | **已完整修复**（全文统一修订「25」→「28」共 7 处，§3.12 同步补充「v8 修订说明」段；§8.2 测试设计表 `test_constants.cj` 用例数 25 → 28，明确每常量函数 1 个用例的覆盖目标） |
| **问题 2（严重）**：`axis` 函数 T(1) 获取方式描述与项目系统性约束矛盾——v7 描述「T(1) 演算通过 `x.w*x.w` 取得」是错误的（`x.w*x.w` 是 w² 而非 1） | 严重 | §1「系统性设计约束」段（新增「常量型 T(1) 字面量替代」策略）/ §3.9 `axis` 函数描述 / D31 | **已完整修复**（§1 新增「常量型 T(1) 字面量替代」策略说明；§3.9 `axis` 函数描述删除「通过 `x.w*x.w` 取得」错误描述，改为 `T(Float64(1))` 显式转换路径；D31 决策同步引用 §1 策略） |
| **问题 3（严重）**：`fromMat4` 降维策略两可——v7 给出「手动提取 vs GLM 策略转换」两种「或」的选择，但两种方式实现语义不同（手动提取无需 `one` 参数；Mat3x3 构造函数依赖阶段二未提供的 `Mat3x3<T,Q>(Mat4x4<T,Q>)` 构造重载），下游无法决策 | 严重 | §3.3 item 7 | **已完整修复**（v8 明确选择**手动提取策略**——直接读取 `m.c0`/`m.c1`/`m.c2` 三列构建 `Mat3x3<T,Q>`，参考阶段二 `type_mat2x2.cj:163-165` 的列提取模式，无需 `one: T` 参数；删除「或」的表述，新增「v8 修订说明」段说明选择理由） |
| **问题 4（严重）**：`Mat2x2`/`FMat2x2` 双别名先例引用错误——阶段二 `cjglm/src/fwd.cj` 实际仅存在 `Mat2x2` (Float32) + `DMat2x2` (Float64) 双别名（`fwd.cj:327, 347`），**不存在** `FMat*` 任何声明；`fwd.cj` 中唯一带 `F` 前缀的别名是 Vec 家族（`FVec1`~`FVec4` 见 `fwd.cj:275-278`） | 严重 | §3.14 / §7 D27 / §9 差异声明 | **已完整修复**（§3.14 先例引用从 `Mat2x2`/`FMat2x2` 双别名修订为 Vec 家族 `Vec2` + `DVec2` + `FVec2` 三重模式，引用 `fwd.cj:106, 123, 276`；D27 决策依据修订为「阶段三所有自定义类型族均排除整型别名 + 选择性排除 Bool 别名」统一策略；§9 差异声明「`Quat`/`FQuat` 双别名机制」条目修订为「`Quat`/`FQuat`/`DQuat` 三重别名机制（v8 修订先例引用）」） |
| **问题 5（一般）**：测试文件命名约定与现有项目不一致——v7 13 个测试文件均使用 `xxx_test.cj` 命名，但阶段二 `cjglm/tests/glm/detail/` 现有约定**全部使用** `test_xxx.cj` 风格（10+ 个文件已 grep 验证） | 一般 | §8.2 测试设计表 | **已完整修复**（13 个测试文件名统一从 `xxx_test.cj` 调整为 `test_xxx.cj` 风格，如 `test_type_quat.cj`/`test_vector_relational.cj` 等） |
| **问题 6（一般）**：`trigonometric.cj` 函数清单未区分标量/向量重载——v7 列出 15 个函数但未说明标量/向量重载形式，下游仅声明向量版本会导致 `mix`/`slerp`/`roll`/`pitch`/`yaw`/`pow`/`log` 等的 `acos(T)`/`sin(T)`/`atan(T)` 标量调用编译失败 | 一般 | §3.13 / §3.13.1（新增子节） | **已完整修复**（§3.13 表格行修订为「标量/向量重载区分（v8 新增）：提供 30 个函数」；新增 §3.13.1「trigonometric.cj 函数清单」子节，明确 14 个单参数三角函数（标量 + 向量 = 28 个）+ 1 个双参数 `atan2`（标量 `atan2(T, T): T` + 向量 = 2 个）= 共 30 个；明确标量版本用于 `slerp`/`mix`/`pow`/`log`/`exp`/`angle`/`angleAxis` 等函数体内的分量级运算） |
| **问题 7（一般）**：`axis` 函数 Float32 sqrt 处理策略缺失——`std.math.sqrt` 仅支持 Float64 输入/输出，T 为 Float32 时 `sqrt(tmp1)` 编译失败；v7 仅在 `length` 一处明确该问题，未将其作为一般性约束贯彻到所有 `std.math` 函数调用 | 一般 | §1（新增「Float32 与 std.math 的交互约束」段） | **已完整修复**（§1 新增「系统性设计约束（v8 新增）：Float32 与 std.math 的交互约束」段，统一说明 `std.math` 所有数值函数仅支持 Float64，Float32 实例化时需使用 `T(Float64.xxx(Float64(value)))` 模式显式转换；明确本阶段受此约束影响的函数清单：`axis`/`length`/`angleAxis`/`exp`/`log`/`pow`/`sqrt`，所有上述函数引用本约束作为依赖说明） |
| **问题 8（一般）**：`fromVec3` 工厂函数边界行为契约缺失——v7 标记为 stub 占位但未说明 u, v 反平行等特殊场景的行为契约；GLM 1.0.3 实际有 180° 任意垂直轴退化路径（`type_quat.inl:196-217`） | 一般 | §3.3 item 8 / §5.3 边界条件表 | **已完整修复**（§3.3 item 8 新增「边界行为契约（v8 新增）」段，明确反平行输入返回 180° 任意轴四元数（`q.w ≈ 0` 且 `q.xyz` 模长为 1 的纯向量四元数），与 GLM 退化路径一致；零向量输入行为未定义；§5.3 边界条件表新增 2 行：「u, v 反平行（`dot ≈ -1`）」+「u, v 为零向量」） |
| **问题 9（一般）**：`mat3Cast`/`mat4Cast` 接受非单位四元数时返回矩阵行为未与 §3.3 工厂函数对齐——§3.3 item 6 已对 `Quat.fromMat3` 明确边界声明，但 §3.2.1 中 `mat3Cast`/`mat4Cast`/`quatCast` 描述未同步；`mat3Cast` 接受非单位四元数时返回矩阵行为未定义，`quatCast` 接受非旋转矩阵时返回四元数行为未定义 | 一般 | §3.2.1（新增「边界行为契约」段）/ §5.3 边界条件表 | **已完整修复**（§3.2.1 在 `where T <: FloatingPoint<T>` 约束说明段后新增「**边界行为契约（v8 新增）**」段，明确：① `mat3Cast`/`mat4Cast` 接受非单位四元数返回矩阵不保证是旋转矩阵（缩放/剪切分量保留）；② `quatCast` 接受非旋转矩阵返回的四元数行为未定义；③下游消费者契约与 §3.3 item 6/7 边界声明对齐。§5.3 边界条件表新增 2 行：「`mat3Cast` 接受非单位四元数」+「`quatCast` 接受非旋转矩阵」） |
| **问题 10（轻微）**：测试文件 `gtc/quaternion_test.cj` 用例数与 gtc 命名空间 API 数量比例失衡——20 个用例分摊到 8 个完整实现函数（4 比较 + 4 转换重导出）仅 2.5 个/函数，低于其他测试文件 | 轻微 | §8.2 测试设计表 | **已完整修复**（§8.2 表新增「用例分配原则（v8 新增）」段：完整实现函数每函数 ≥2 用例 / stub 函数每函数 ≥1 用例 / 重导出函数每函数 ≥1 用例验证可达性；`test_quaternion.cj` 用例数 20 → 27，按 8 可测函数 × 2 = 16 + 4 重导出可达性 × 1 = 4 + 7 stub × 1 = 7 = 27 重算） |
| **问题 11（轻微）**：§11.5 函数可用性对照表 `isnan`/`isinf` 与 `mat3_cast`/`mat4_cast`/`quat_cast` 行未与 §3.11/§3.2.1 `where T <: FloatingPoint<T>` 子句约束保持一致——未明确具体约束的 where 子句形式，下游迁移者可能不理解为何整型 T 编译失败 | 轻微 | §11.5 函数可用性对照表 | **已完整修复**（§11.5 表 3 行追加约束标注：`isnan`/`isinf` 本阶段/阶段四两行均追加「**约束：`where T <: FloatingPoint<T>`（D29）**」；`mat3_cast`/`mat4_cast`/`quat_cast`（detail）与（gtc，重导出）本阶段/阶段四共 4 行均追加「**约束：`where T <: FloatingPoint<T>`（D32）**」） |

### v8 修订特点

1. **事实准确性优先**：本轮 4 项严重问题中 3 项属于「事实错误/直接阻塞编码」类（`gtc/constants` 数量自相矛盾 / `axis` 函数 T(1) 错误描述 / `FMat2x2` 先例引用错误），v8 通过直接查阅仓颉 stdlib 文档（`cangjie-std/math/README.md`）、GLM 1.0.3 实际源码（`glm/glm/gtc/constants.hpp`、`ext/quaternion_trigonometric.inl`、`type_quat.inl`）、阶段二 `cjglm/src/fwd.cj` 全文 grep 验证、以及 `cjglm/src/detail/type_mat2x2.cj:163-165` 列提取模式参考，逐一纠正错误描述，确保设计与项目实际状态对齐。

2. **设计决策明确性强化**：本轮 2 项问题属于「设计决策不明确」类（`fromMat4` 策略两可 / `mat3Cast`/`mat4Cast` 边界行为未对齐），v8 通过明确单一策略 + 新增边界行为契约段 + §3.3/§3.2.1/§5.3 三处协同对齐，强化设计决策的可操作性，下游编码可按设计文档直接落地无需决策。

3. **系统性约束上升**：本轮 2 项问题属于「未上升为一般性约束」类（`trigonometric.cj` 标量/向量区分 / `axis` 函数 Float32 sqrt 处理），v8 通过 §1「系统性设计约束」新增「Float32 与 std.math 的交互约束」段 + §3.13.1「trigonometric.cj 函数清单」子节，将单点问题上升为一般性约束，便于所有受影响函数引用，避免类似遗漏再次发生。

4. **测试设计可操作性提升**：本轮 2 项问题属于「测试设计可操作性不足」类（测试文件命名不一致 / 用例数比例失衡），v8 通过统一 `test_xxx.cj` 命名约定 + 新增「用例分配原则」段，提升测试设计的可操作性，下游测试编码可按明确原则规划用例数。

5. **下游可读性强化**：本轮 1 项问题属于「下游迁移可读性」类（§11.5 where 子句标注缺失），v8 通过在函数可用性对照表的关键行追加「**约束：`where T <: FloatingPoint<T>`（D29/D32）**」标注，强化下游迁移者对编译期约束的理解，避免「为何整型 T 实例化时编译失败」的疑问。

### 不引入新设计变更

v8 修订严格限定在 11 项审查意见的逐项落实范围内，不修改任何函数行为、类型形态选择、依赖方向、文件归属、命名规范原则等设计要素。前序 v2/v3/v4/v5/v6/v7 修订的累计 38 项审查意见落实情况保持不变（v2 14 项 + v3 2 项 + v4 2 项 + v5 14 项 + v6 3 处澄清 + v7 5 项 = 40 项历史意见均已闭环）。

### v3 迭代历史累计状态

经过 v1（v2 设计）→ v2（v3 设计）→ v3（v4 设计）→ v4（v5 设计）→ v5（v6 设计）→ v6（v7 设计）→ v7（v8 设计）共 7 轮设计修订：

- **v1 → v2 设计**：新增 14 项审查意见 → 落实 13 项
- **v2 → v3 设计**：补齐 v1 遗留 1 项 + 新增 2 项严重问题（包间循环依赖 + 依赖方向内部矛盾）→ 全部修复
- **v3 → v4 设计**：新增 2 项（isnan/isinf 约束缺失 + Quat 字段可见性描述缺失）→ 全部修复
- **v4 → v5 设计**：新增 14 项（2 严重 + 8 一般 + 4 轻微）→ 全部修复
- **v5 → v6 设计**：核实 v5 落实情况 + 3 处表述细节澄清
- **v6 → v7 设计**：新增 5 项（1 一般 + 4 轻微）→ 全部修复
- **v7 → v8 设计（本轮）**：新增 11 项（4 严重 + 5 一般 + 2 轻微）→ 全部修复

v7 迭代整体完成，可进入下游验证环节。

---

## 修订说明（v9）

> **修订定位**：v8 设计的迭代修订（v9）。依据本轮审查报告（`a_v5_iteration_requirement.md` 对应 v4 诊断报告 `b_v4_diag_v1.md`）识别 7 项问题（2 项严重 + 2 项一般 + 3 项轻微，其中问题 7 经诊断确认两处描述实际一致，仅格式呈现略不同，**无需修改**），实际需修复 6 项。在 v8 设计（已落实前序 11 项审查意见：4 严重 + 5 一般 + 2 轻微）的基础上，本轮针对 6 项问题逐项开展修订。

### 6 项审查意见落实情况核验表

| 审查意见 | 严重程度 | v9 落实位置 | 核验结论 |
|---------|---------|------------|---------|
| **问题 1（严重）**：`fromMat4` 引用阶段二 `fromMat` 列提取模式的描述与项目实际模式不符——v8 §3.3 item 7 引用 `cjglm/src/detail/type_mat2x2.cj:163-165` `Mat2x2.fromMat(Mat3x3, one)` 作为「无需 `one: T`」的依据，但该被引用代码本身就要求 `one: T`（阶段二全部 9 个矩阵类型的 `fromMat` 工厂函数**均要求** `one: T` 形参，无论源/目标矩阵尺寸关系，仅同维度 `fromMat` 简化为无 `one` 形参）；与 §1「T(1) 的获取：必须由调用方显式传入参数」系统性约束冲突 | 严重 | §3.3 item 7 | **已完整修复**（删除错误的 `type_mat2x2.cj:163-165` 列提取模式引用作为论据；改为基于本函数实际构造路径——Vec3 主构造 + Mat3x3 主构造（均无 `one` 形参依赖）——说明 `fromMat4` 签名无需 `one: T` 形参的合理性，与 §1 系统性约束彻底闭环） |
| **问题 2（严重）**：`mat3Cast`/`mat4Cast` T(1) 获取策略缺失，与 §1 系统性约束冲突——GLM `gtc/quaternion.inl:49` 实际使用 `Mat3x3(T(1))` 初始化 3×3 单位矩阵（即 `Result = identity`），强依赖 T(1) 字面量；但 §3.2.1 签名模板未提及 T(1) 获取方式；§1 受约束函数清单遗漏 `mat3Cast`/`mat4Cast`；§3.4 `Quat×Vec3`/`Quat×Vec4` 等使用 `T(Float64(2))` 字面量的运算符也未列出 | 严重 | §1 第一段「常量型 T(n) 字面量替代（v9 扩展）」+ 新增 v9 受 T 字面量获取策略影响的函数清单 / §3.2.1「T(1) 字面量获取策略（v9 新增）」段 / §3.4 `Quat×Vec3` 公式 `* 2` → `* T(Float64(2))` | **已完整修复**（§1 第一段扩展「常量型 T(1) 字面量替代」为「常量型 T(n) 字面量替代（v9 扩展）」+ 新增 v9 受 T 字面量获取策略影响的函数清单，覆盖 `axis` / `Quat×Vec3`/`Quat×Vec4` / `mat3Cast`/`mat4Cast`；§3.2.1 新增 T(1) 字面量获取策略段，明确 GLM `gtc/quaternion.inl:49` 实际使用 `Mat3x3(T(1))` + 仓颉实现应使用 `T(Float64(1))` 显式转换路径 + 签名无 `one: T` 形参的合理性；§3.4 `Quat×Vec3` 公式末尾 `* 2` 修订为 `* T(Float64(2))` 以匹配 v9 T 字面量获取策略） |
| **问题 3（一般）**：`ext/vector_relational.cj` GLM 文件引用错误（行号与文件名均错误）——v8 §3.5 描述「向量 `equal`/`notEqual` epsilon 版本采用严格 `<` 语义，与 GLM 1.0.3 `func_vector_relational.inl:18-22` 一致」，但 GLM 1.0.3 的 `func_vector_relational.inl` 中**根本不包含 epsilon 版本**的 `equal`/`notEqual`——epsilon 版本位于 `glm/gtc/epsilon.inl`（文件层面属 gtc 子包），行号 `18-22` 实际为 `lessThanEqual`；同时引用偏差涉及 §3.5 / §5.3 / D24 / §9 共 4 处 | 一般 | §3.5 / §5.3 边界条件表 / D24 设计决策 / §9 差异声明 | **已完整修复**（4 处 GLM 文件引用统一从 `func_vector_relational.inl:18-22` 修订为 `glm/gtc/epsilon.inl:32-41` 中 `epsilonEqual` 实现；各修订位置同步标注「v9 修订」并说明原引用错误原因——GLM 1.0.3 的 `func_vector_relational.inl` 中**不包含** epsilon 版本，epsilon 版本位于 `glm/gtc/epsilon.inl`） |
| **问题 4（一般）**：`lib.cj` 新增 import 清单不完整（遗漏 12 个新模块的 stub/别名文件）——v8 §2 「lib.cj 新增 import 清单（v5 明确）」仅列出 8 个 import 声明，但对照 §2 包组织图中新增的 16 个文件，遗漏 `glm.detail.trigonometric` / `glm.ext.quaternion_transform` / `glm.ext.quaternion_exponential` / `glm.ext.quaternion_float` / `glm.ext.quaternion_double` / `glm.ext.quaternion_float_precision` / `glm.ext.quaternion_double_precision` / `glm.ext.matrix_projection` / `glm.ext.matrix_clip_space` / `glm.ext.matrix_transform` / `glm.gtc.quaternion` / `glm.gtc.matrix_transform` 等 12 个模块的 import | 一般 | §2「lib.cj 新增 import 清单（v9 扩展补齐）」段 | **已完整修复**（§2 lib.cj import 清单从 8 个扩展为 20 个，新增 12 个 import 声明，覆盖四元数变换/指数 stub、三角函数 detail stub、gtc 四元数扩展、矩阵变换 stub、4 个别名文件、3 个矩阵 stub 模块；同步标注「v9 新增」） |
| **问题 5（轻微）**：§3.4「交换律别名」解释中 `Number<T>` 语义描述不准确——v8 描述「Quat×T 运算符已通过 `Number<T>` 约束交换律覆盖（仓颉 `Number<T>` 加法/乘法具备交换律语义）」，但 `Number<T>` 接口本身**不提供交换律语义**——仓颉运算符重载中左操作数类型决定 operator 函数归属，`T * Quat` 的 `T` 在左操作数位置时无法定义为 Quat 的成员运算符，必须通过 `scalar_quat_ops.cj` 的全局函数实现 | 轻微 | §3.4「交换律别名」注 | **已完整修复**（删除原描述中「仓颉 `Number<T>` 加法/乘法具备交换律语义」错误表述；明确说明 `T * Quat` 通过 `scalar_quat_ops.cj` 全局函数实现的根本原因是左操作数类型决定 operator 函数归属，而非 `Number<T>` 提供交换律覆盖；保留与 `type_quat.cj` 的 `Quat×T` 成员运算符不构成重载冲突的说明——前者实现 `T * Quat`，后者实现 `Quat * T`，左操作数类型不同） |
| **问题 6（轻微）**：§11.5 gtc 重导出行的 `where T <: FloatingPoint<T>` 约束归属描述不清——v8 标注「约束：`where T <: FloatingPoint<T>`（D32）」，但 D32 实际针对 `detail/type_quat_cast.cj` 的原始定义函数；gtc 命名空间下的同名函数是通过 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 重导出，约束应在重导出端自动继承自 detail 端实现 | 轻微 | §11.5 函数可用性对照表 `mat3_cast`/`mat4_cast`/`quat_cast`（gtc，重导出）行 | **已完整修复**（gtc 重导出行的约束标注修订为「**约束：`where T <: FloatingPoint<T>`（D32，约束继承自 detail 端实现，通过 public import glm.detail.{mat3Cast, mat4Cast, quatCast} 透明传递）**」；明确下游消费者看到 gtc 端约束时，实际约束来自 detail 端实现） |
| **问题 7（自查透明，无需修改）**：§8「产出物清单」中 `gtc/quaternion.cj` 行数量描述与 §3.2 协作关系表存在视觉呈现差异（实际无矛盾） | — | — | **无需修改**（诊断确认两处描述实际一致，仅格式呈现略不同） |

### v9 修订特点

1. **事实准确性与系统性约束闭环**：本轮 2 项严重问题均属于「事实错误/直接阻塞编码」类——`fromMat4` 引用错误代码（被引用代码 `Mat2x2.fromMat(Mat3x3, one)` 本身就要求 `one: T`，与「无需 `one`」结论相悖）+ `mat3Cast`/`mat4Cast` T(1) 获取策略缺失（GLM `gtc/quaternion.inl:49` 实际强依赖 `Mat3x3(T(1))` 字面量，但设计文档未指定 T(1) 获取路径）。v9 通过删除错误的代码引用作为论据 + 在 §3.2.1 新增 T(1) 字面量获取策略段 + 在 §1 第一段扩展「常量型 T(1) 字面量替代」为「常量型 T(n) 字面量替代（v9 扩展）」+ 新增 v9 受 T 字面量获取策略影响的函数清单（覆盖 `axis` / `Quat×Vec3`/`Quat×Vec4` / `mat3Cast`/`mat4Cast`）+ §3.4 `Quat×Vec3` 公式 `* 2` 修订为 `* T(Float64(2))`，实现与 §1 系统性约束的彻底闭环。

2. **GLM 文件引用准确性**：本轮 1 项一般问题涉及 GLM 文件引用错误——`ext/vector_relational.cj` 的 epsilon 版本不在 `func_vector_relational.inl`（GLM 1.0.3 的 `func_vector_relational.inl` 中**不包含** epsilon 版本，行号 18-22 实际为 `lessThanEqual`），而位于 `glm/gtc/epsilon.inl:32-41`（`epsilonEqual` 实现位置，文件层面属 gtc 子包）。v9 通过 §3.5 / §5.3 边界条件表 / D24 设计决策 / §9 差异声明 共 4 处 GLM 文件引用统一从 `func_vector_relational.inl:18-22` 修订为 `glm/gtc/epsilon.inl:32-41` 中 `epsilonEqual` 实现，确保与 GLM 实际源码对齐，下游编码者按修订后引用查阅 GLM 源码可定位到正确的实现位置。

3. **`lib.cj` import 清单完整性**：本轮 1 项一般问题涉及 `lib.cj` import 清单遗漏 12 个新模块——v9 通过 §2 import 清单从 8 个扩展为 20 个，新增 12 个 import 声明覆盖：四元数变换/指数 stub（`glm.ext.quaternion_transform`/`glm.ext.quaternion_exponential`）+ 三角函数 detail stub（`glm.detail.trigonometric`）+ gtc 四元数扩展（`glm.gtc.quaternion`）+ 矩阵变换 stub（`glm.gtc.matrix_transform`）+ 4 个别名文件（`glm.ext.quaternion_float`/`quaternion_double`/`quaternion_float_precision`/`quaternion_double_precision`）+ 3 个矩阵 stub 模块（`glm.ext.matrix_projection`/`matrix_clip_space`/`matrix_transform`），确保下游消费者可按 lib.cj import 清单访问所有新增模块（stub/别名/gtc），无需自行分散 import 各个子模块。

4. **语义准确性强化**：本轮 2 项轻微问题涉及 `Number<T>` 语义描述错误（`Number<T>` 接口本身**不提供交换律语义**，仅约束四则运算实现）+ gtc 重导出行约束归属描述不清（gtc 端约束通过 public import 自动继承自 detail 端，非独立定义）。v9 通过 §3.4「交换律别名」注删除错误的"仓颉 `Number<T>` 加法/乘法具备交换律语义"表述，明确 `T * Quat` 通过 `scalar_quat_ops.cj` 全局函数实现的根本原因是左操作数类型决定 operator 函数归属（D05 决策）；§11.5 gtc 重导出行的约束标注增加"约束继承自 detail 端实现，通过 public import glm.detail.{mat3Cast, mat4Cast, quatCast} 透明传递"说明，明确下游消费者看到 gtc 端约束时实际约束源自 detail 端实现。

### 不引入新设计变更

v9 修订严格限定在 6 项审查意见的逐项落实范围内，不修改任何函数行为、类型形态选择、依赖方向、文件归属、命名规范原则等设计要素。前序 v2/v3/v4/v5/v6/v7/v8 修订的累计审查意见落实情况保持不变（v2 14 项 + v3 2 项 + v4 2 项 + v5 14 项 + v6 3 处澄清 + v7 5 项 + v8 11 项 = 51 项历史意见均已闭环）。

### v4 迭代历史累计状态

经过 v1（v2 设计）→ v2（v3 设计）→ v3（v4 设计）→ v4（v5 设计）→ v5（v6 设计）→ v6（v7 设计）→ v7（v8 设计）→ v8（v9 设计）共 8 轮设计修订：

- **v1 → v2 设计**：新增 14 项审查意见 → 落实 13 项
- **v2 → v3 设计**：补齐 v1 遗留 1 项 + 新增 2 项严重问题（包间循环依赖 + 依赖方向内部矛盾）→ 全部修复
- **v3 → v4 设计**：新增 2 项（isnan/isinf 约束缺失 + Quat 字段可见性描述缺失）→ 全部修复
- **v4 → v5 设计**：新增 14 项（2 严重 + 8 一般 + 4 轻微）→ 全部修复
- **v5 → v6 设计**：核实 v5 落实情况 + 3 处表述细节澄清
- **v6 → v7 设计**：新增 5 项（1 一般 + 4 轻微）→ 全部修复
- **v7 → v8 设计**：新增 11 项（4 严重 + 5 一般 + 2 轻微）→ 全部修复
- **v8 → v9 设计**：新增 7 项（2 严重 + 2 一般 + 3 轻微，其中问题 7 自查无需修改）→ 实际修复 6 项

v8 迭代整体完成，可进入下游验证环节。

---

## 修订说明（v10）

> **修订定位**：v9 设计的迭代修订（v10）。依据本轮审查报告（`a_v6_iteration_requirement.md` 对应 v5 诊断报告 `b_v5_diag_v1.md`）从需求响应充分度、整体深度与完整性、设计可落地性维度识别 17 项质量问题（3 严重 + 13 一般 + 1 轻微）。在 v9 设计（已落实前序 51 项审查意见：v2 14 + v3 2 + v4 2 + v5 14 + v6 3 + v7 5 + v8 11 = 51）的基础上，本轮针对 17 项问题逐项开展修订。

### 17 项审查意见落实情况核验表

| 审查意见 | 严重程度 | v10 落实位置 | 核验结论 |
|---------|---------|------------|---------|
| **问题 1（严重）**：§3.10、D21、§8 编码启动前验证项 16/18 多次引用 `FloatingPoint<T>.getMin()` 和 `FloatingPoint<T>.getInf()` 实例方法作为「主策略」。但 `cangjie-std/math/README.md` 第 111-115 行明确仓颉 stdlib **不存在**这两个方法，仅存在 `Float64.Inf`/`Float64.Min`/`Float64.Max`/`Float64.NaN` 静态常量；`FloatingPoint<T>` 接口本身仅作为类型约束被声明，无任何实例方法 | 严重 | §3.10 `pow`/`log` 依赖 / D21 设计决策 / §8 验证项 16/18/13 | **已完整修复**（删除 `FloatingPoint<T>.getMin()`/`getInf()` 实例方法引用作为主策略；明确「仓颉 stdlib 仅提供 `Float64.Min`/`Float64.Inf`/`Float32.Min`/`Float32.Inf` 静态常量，`FloatingPoint<T>` 接口本身无任何实例方法」；下游实现路径修订为类型分派 `if (q.x is Float32) { Float32.Min/Inf } else { Float64.Min/Inf }` 或字面量 fallback `T(1)/T(0)`/`T(1)/T(很大值)` 显式构造；§8 验证项 16/18 描述同步修订为「验证类型分派路径 + 字面量 fallback 路径的编译可行性」；验证项 13 中 `getMin()`/`getInf()` 提示同步删除） |
| **问题 2（严重）**：fwd.cj 四元数别名计数自相矛盾（声称 8，实际 9）——§3.14、§2 lib.cj/fwd.cj 段落、§8 更新文件段多处声称「合计 8 个别名」并明确列出 `Quat`/`FQuat`/`DQuat` + 3×Float32 精度 + 3×Float64 精度 = **9 个**别名，算术 3+3+3=9 与汇总数字 8 直接矛盾 | 严重 | §2 lib.cj/fwd.cj 段落 / §3.14 四元数别名文件 | **已完整修复**（§2 lib.cj/fwd.cj 段落「合计 8 个别名」统一修订为「**合计 9 个别名**」，并附「v10 修订」标注说明 v9 描述误为 8 个；§3.14「合计 8 个别名」同步修订为「**合计 9 个别名**」，明确「1+1+1+3+3 = 9」算术依据） |
| **问题 3（严重）**：§3.10 「命名消歧（v5 新增）」段声明「四元数 `pow` 函数体内部调用的 `pow(x.w, y)` 是实数版本 `std.math.pow(T, T): T`」，但 `cangjie-std/math/README.md` 第 13 行明确 `std.math.pow` 实际签名为 `pow(base: Float64, exponent: Float64): Float64`，**不是**泛型 `pow(T, T): T`。下游按设计字面实现时：当 T=Float64 时签名不一致（返回 Float64 而非 T）；当 T=Float32 时直接编译失败 | 严重 | §3.10 `pow` 函数描述 / D21 设计决策 | **已完整修复**（§3.10 `pow` 函数描述全文将「`std.math.pow(T, T): T`」修订为「`std.math.pow(Float64, Float64): Float64`」（仅支持 Float64 输入/输出）；明确下游实现路径为 `Float64(std.math.pow(Float64(x.w), Float64(y)))` 当 T=Float32 时 / `T(std.math.pow(Float64(x.w), Float64(y)))` 当 T=Float64 时回转目标类型 T；fallback 路径 `Float64(std.math.exp(Float64(y) * std.math.log(Float64(x.w))))` 同步需 Float64 转换；D21 决策依据同步修订，明确 `std.math.pow` 实际签名为 `(Float64, Float64): Float64`） |
| **问题 4（一般）**：未识别与阶段二已有 `epsilonOf<T>(hint)` 函数的命名冲突与冗余设计——`cjglm/src/detail/shim_limits.cj:25` 已存在同名语义的 `public func epsilonOf<T>(hint: T): T`，且 `compute_vector_relational.cj:17` 已使用。设计 §3.12 新增 `func epsilon<T>(): T` 未说明两函数等价性、返回值一致性、阶段二测试硬编码值未做交叉验证 | 一般 | §3.12 ext/scalar_constants.cj 段 / §8 验证项 19 | **已完整修复**（§3.12 「ext/scalar_constants.cj」段新增「**与 `shim_limits.cj:25` `epsilonOf<T>(hint)` 关系（v10 新增，Issue 4 响应）**」子段，明确 (a) 两函数功能等价，无业务新增；(b) `epsilon<T>()` 无形参与 `epsilonOf<T>(hint)` 携带 `hint: T` 形参的签名差异说明；(c) 阶段二测试硬编码值作为 ground truth；(d) 编码启动前验证项新增 19「验证 `epsilon<T>()` 与 `epsilonOf<T>(hint)` 在 T=Float32/Float64/Int64 下的返回值一致性」） |
| **问题 5（一般）**：§3.13.1 `VecN<T,Q>` 占位符未映射到仓颉实际类型展开模式——仓颉项目不存在 `VecN` 泛型占位类型，实际模式是 `compute_vec_add1`/`add2`/`add3`/`add4` 四个独立 struct | 一般 | §3.13.1 trigonometric.cj 函数清单 | **已完整修复**（§3.13.1 表头新增「**`VecN<T, Q>` 占位符展开规则（v10 新增，Issue 5 响应）**」段，明确 `VecN<T, Q>` 占位符实际展开为 `Vec1<T,Q>`/`Vec2<T,Q>`/`Vec3<T,Q>`/`Vec4<T,Q>` 4 个独立重载，命名沿用 `cjglm/src/detail/compute_vector_decl.cj` 的 `compute_vec_xxx1/2/3/4` 模式；函数总数重新核算为 75 个函数 = 14 标量单参数 + 14×4=56 向量单参数 + 1 标量双参数 `atan2` + 1×4=4 向量双参数 `atan2`） |
| **问题 6（一般）**：§5.4 const 约束声明与 §3.11 函数体描述存在内部矛盾——§5.4 声明「`lerp`/`conjugate`/`inverse` 不可在 const 上下文调用」，但 §3.11 `conjugate(q)` 描述函数体内仅对 x/y/z 三个分量取反，无 assert/throw/运行时副作用，实际可在 const 上下文调用 | 一般 | §5.4 const 上下文约束 / §3.11 `conjugate` 描述 | **已完整修复**（§5.4 修订为「`lerp`/`inverse` 不可在 const 上下文调用（v10 修订，Issue 6 响应）」，移除 `conjugate`；补充 `inverse` 的 const 拒绝理由：「依赖 `/` 运算符，整数 T 在 `dot(q,q) == 0` 时触发 `ArithmeticException`，非 const 函数」；§3.11 `conjugate` 描述末尾新增「const func 适用性（v10 新增，Issue 6 响应）」段，明确 `conjugate` 函数体仅涉及 `Quat` 主构造函数的逐分量取反调用，可声明为 `const func`；附注「若仓颉 const 函数还有其他限制，则该论断需进一步评估」） |
| **问题 7（一般）**：§3.13.1 trigonometric.cj 中 `radians`/`degrees` 函数实现路径未明确（π 字面量 vs `pi<T>()`），且 stage 3 实际是 stub，依赖 stage 4 才落地 | 一般 | §3.13.1 trigonometric.cj 函数清单 | **已完整修复**（§3.13.1 `radians`/`degrees` 行「内部依赖」列明确补充「**v10 修订（Issue 7 响应）**：硬编码 π 字面量 `Float64(3.141592653589793)`，无 std.math 依赖，无 `scalar_constants` 依赖（避免与 `pi<T>()` 的运行时调用）」；下游实现阶段四 trigonometric.cj 时直接使用 `Float64(3.141592653589793)` 字面量计算度↔弧度转换公式，无需调用 `pi<T>()`） |
| **问题 8（一般）**：§8.2 测试文件结构 `tests/glm/ext/` 与现有项目惯例 `tests/glm/test_ext.cj`（单一聚合文件）不一致——实际 `tests/glm/ext/` 目录不存在，阶段二 25 个测试文件均位于 `tests/glm/detail/`。设计引入 `tests/glm/ext/` 与 `tests/glm/gtc/` 是新建目录结构，但未说明与既有 `test_ext.cj` 的关系及迁移策略 | 一般 | §8.2 测试文件清单与位置表 | **已完整修复**（§8.2 测试设计新增「**测试目录结构对齐策略（v10 新增，Issue 8 响应）**」段，明确 (a) 避免新建 `tests/glm/ext/` 与 `tests/glm/gtc/` 子目录，所有新增测试文件采用 `tests/glm/test_xxx.cj` 同层平铺命名（与 `test_ext.cj` 一致）；(b) 既有 `tests/glm/test_ext.cj`（102 行，验证 ext 包基础别名）保持原状，新增的 `tests/glm/test_ext_xxx.cj` 文件按 ext 子模块拆分，与 `test_ext.cj` 并存不冲突；(c) 4 个 ext/ 别名文件测试合并为单一 `tests/glm/test_ext_quaternion_aliases.cj` 文件；(d) 下游实施步骤：测试文件创建前无需 `mkdir -p`，按上述命名直接创建；§8.2 表 13 个测试文件名同步从 `tests/glm/ext/test_xxx.cj`/`tests/glm/gtc/test_xxx.cj` 修订为 `tests/glm/test_ext_xxx.cj`/`tests/glm/gtc/test_xxx.cj` 同层平铺命名） |
| **问题 9（一般）**：§2 模块间依赖图中 gtc/quaternion.cj 对 Mat3x3/Mat4x4/Vec3 的依赖声明过宽——逐项核查 15 个函数：4 个比较函数仅依赖 Quat；3 个 quatLookAt 函数仅依赖 Vec3，不依赖 Mat 类型。设计将依赖声明扩展至全部 Mat/Vec 类型 | 一般 | §2 模块间依赖图 `glm.gtc` 块 | **已完整修复**（§2 模块间依赖图 `glm.gtc` 块 `quaternion.cj → glm.detail.{Quat, Mat3x3, Mat4x4, Vec3}` 修订为分段声明：「4 个比较函数（`lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual`）**仅依赖 Quat**；3 个 quatLookAt 函数（`quatLookAt`/`quatLookAtRH`/`quatLookAtLH`）**仅依赖 Vec3**；4 个转换函数（`mat3_cast`/`mat4_cast`/`quat_cast` × 2）**重导出 detail 端**（不需直接 import Mat/Vec）；4 个欧拉函数（`eulerAngles`/`roll`/`pitch`/`yaw`）**依赖 Vec3 + Quat**」；下游按声明增加 import 后不会产生未使用 import） |
| **问题 10（一般）**：§3.13.1 trigonometric.cj 受 Float32 与 std.math 交互约束影响的函数清单遗漏 trigonometric.cj 自身——trigonometric.cj 实现的 14 个标量函数本身调用 `std.math.sin`/`cos`/`tan` 等 Float64-only 函数，下游实现时需对每个函数应用 `T(Float64.xxx(Float64(value)))` 转换模式 | 一般 | §3.13.1 trigonometric.cj 函数清单 | **已完整修复**（§3.13.1 表后新增「**Float32 实例化影响（v10 新增，Issue 10 响应）**」段：「**所有 `std.math.*` 函数（sin/cos/tan/asin/acos/atan/sinh/cosh/tanh/asinh/acosh/atanh/atan2/sqrt/pow/log/exp）均仅支持 Float64 输入/输出**，所有 trigonometric.cj 函数在 T=Float32 实例化时需应用 `T(Float64.xxx(Float64(value)))` 转换模式（与 §1「Float32 与 std.math 的交互约束」一致）。`radians`/`degrees` 是例外——纯算术公式无 std.math 依赖，Float32 实例化无需转换」；表行「内部依赖」列对 `std.math.{func}` 调用统一标注「**仅 Float64，Float32 实例化需显式转换**」） |
| **问题 11（一般）**：§3.9 `axis` 函数公式中冗余的 `Float64(...)` 包装层——`tmp2 = T(Float64(1)) / T(Float64(std.math.sqrt(Float64(tmp1))))`，其中 `Float64(std.math.sqrt(...))` 等价于 `Float64(Float64)`（冗余但合法） | 一般 | §3.9 `axis` 函数描述 | **已完整修复**（§3.9 `axis` 函数公式修订为 `tmp2 = T(Float64(1)) / T(std.math.sqrt(Float64(tmp1)))`，删除冗余的 `Float64(...)` 包装；在公式旁新增「v10 修订（Issue 11 响应）：删除冗余的 `Float64(std.math.sqrt(...))` 包装层——`std.math.sqrt` 已是 `Float64` 输入/输出，等价于 `Float64(Float64)` 的冗余嵌套，仅需一次 `T(Float64(…))` 转换回目标类型 T」解读注释） |
| **问题 12（一般）**：§1 与 §3.10 对 `pow` 函数「Float64 转换依赖」段引用位置不一致——§1 通用约束已说明 pow 需 Float64 转换，§3.10 又单设「Float64 转换依赖（v7 澄清）」子段，二者功能重叠 | 一般 | §3.10 `pow` 函数描述 | **已完整修复**（§3.10 `pow` 描述中 v5「命名消歧」与 v7「Float64 转换依赖（v7 澄清）」两段合并为单一「**命名消歧与 Float64 转换（v5 新增，v7 澄清，v10 合并）**」子段；新段落引用 §1 通用约束而非重复展开：「`pow(Quat<Float32, Q>, Float32)` 实现路径遵循 §1「Float32 与 std.math 的交互约束」通用约束（应用 `T(Float64.std.math.pow(Float64(x.w), Float64(y)))` 转换模式）」；fallback 路径 `exp(y * log(x.w))` 同步遵循 §1 通用约束；下游阅读时不再产生「§1 已说明通用规则为何 §3.10 又重复一次」的疑问） |
| **问题 13（一般）**：§3.11 `inverse` 描述与 §5.3 边界条件表对整数 `inverse` 行为契约措辞不一致——虽两处描述本质一致，但 §5.3 表的「`axis(q)` 零四元数」行措辞（`\|w\| >= 1`）与 §3.9 `axis` 描述（`tmp1 <= 0`）虽等价但措辞略不同，且 §5.3 表未说明 `tmp1 = T(1) - x.w*x.w` 的计算公式 | 一般 | §3.11 `inverse` 描述 / §5.3 边界条件表 | **已完整修复**（§5.3 边界条件表「`axis(q)` 零四元数」行补充「**v10 补充，Issue 13 响应**：`tmp1 = T(1) - x.w*x.w` 计算公式参见 §3.9 `axis` 函数描述」明确公式引用；§5.3 表的「整数 `inverse`」行措辞与 §3.11 `inverse` 描述统一为「触发仓颉 `ArithmeticException`」（v10 措辞统一标注），§3.11 `inverse` 描述末尾标注「v10 措辞统一，Issue 13 响应」） |
| **问题 14（一般）**：与问题 1 同源，§8 编码启动前验证项 16/18 验证目标不存在的 API，导致实际验证项无法独立完成 | 一般 | §8 编码启动前验证项 16/18 | **已完整修复**（与问题 1 同步修订：验证项 16/18 描述从「验证 `FloatingPoint<T>.getMin()`/`getInf()` 实例方法可用性」修订为「验证类型分派路径 + 字面量 fallback 路径的编译可行性」；明确「仓颉 stdlib 仅提供 `Float64.Min`/`Float64.Inf`/`Float32.Min`/`Float32.Inf` 静态常量，`FloatingPoint<T>` 接口本身无任何实例方法」） |
| **问题 15（轻微）**：§8.2 测试用例总数算术偏差（声称 ≥178 实际累加为 179，差 1） | 轻微 | §8.2 测试文件清单与位置表末尾 | **已完整修复**（§8.2 表末尾「合计」数字从「≥178」修订为「≥179」；附「v10 修订：v9 声称 ≥178，累加实际为 179；按上述每行 ≥值求和：40+8+8+12+16+8+4+2+16+6+4+28+27=179」算术依据） |
| **问题 16（一般）**：§11.5 函数可用性对照表 `lessThan`/`lessThanEqual` 等 4 个比较函数的约束未标注 | 一般 | §11.5 函数可用性对照表 / §3.15 完整实现函数段 | **已完整修复**（§11.5 `lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual` 行追加「**约束：`where T <: Comparable<T>`（依赖 `<`/`>` 运算符，v10 新增标注，Issue 16 响应）**」标注；§3.15 完整实现函数段 4 行同步补充 `where T <: Comparable<T>` 约束与「v10 新增，Issue 16 响应」标注） |
| **问题 17（轻微）**：§2 lib.cj import 清单 #1 `glm.detail.{Quat, mat3Cast, mat4Cast, quatCast}` 类型与函数混合导入的语义边界未说明——下游按 §11.4 迁移示例调用 `let m3 = mat3Cast(q)`（无命名空间前缀）会编译失败，需先 `import glm.detail.*` 才能调用包级函数 | 轻微 | §2 lib.cj import 清单 / §11.4 迁移示例 | **已完整修复**（§2 lib.cj import 清单 #1 补充说明：`mat3Cast`/`mat4Cast`/`quatCast` 在 lib.cj 中以 `public import` 形式重导出至顶层 `glm` 命名空间——与现有 `public import glm.detail.{transpose, matrixCompMult, outerProduct}` 包级函数重导出模式一致，见 `cjglm/src/lib.cj:8`——下游消费者可按 `glm.mat3Cast(q)` 路径直接调用，**无需** `import glm.detail.*` 后再调用包级函数 `mat3Cast(q)`；§11.4 迁移示例新增「仓颉顶层 glm 命名空间调用」代码段：`let m3_top = glm.mat3Cast(q)` / `let q2_top = glm.quatCast(m)`，与 lib.cj 的 `public import` 重导出模式对应；并修订「仓颉 detail 直接调用」代码段，提示需先 `import glm.detail.*` 才能调用包级函数） |

### v10 修订特点

1. **事实准确性与直接阻塞编码修复**：本轮 3 项严重问题均属「事实错误/直接阻塞编码」类——`FloatingPoint<T>.getMin()`/`getInf()` 实例方法在仓颉 stdlib 不存在（`cangjie-std/math/README.md` 第 111-115 行仅列出 `Float64.Inf`/`Float64.Min`/`Float64.Max`/`Float64.NaN` 静态常量，第 117 行明确 `FloatingPoint<T>` 接口仅作为类型约束声明无任何实例方法）；fwd.cj 四元数别名计数自相矛盾（声称 8，实际 1+1+1+3+3=9）；`std.math.pow` 实际签名为 `pow(base: Float64, exponent: Float64): Float64`（仅支持 Float64 输入/输出），v9 描述的泛型 `std.math.pow(T, T): T` 不存在。v10 通过逐处修订 §3.10/D21/§8 验证项 + §2/§3.14 别名计数 + §3.10 命名消歧段，实现与仓颉 stdlib 实际 API 的彻底对齐。

2. **下游可执行性强化**：本轮 10 项一般问题涵盖下游可执行性维度——`epsilonOf` 命名冲突与等价性（§3.12 新增「与 `shim_limits.cj:25` `epsilonOf<T>(hint)` 关系」子段 + 验证项 19）/ `VecN<T, Q>` 占位符展开规则（§3.13.1 新增占位符展开规则段 + 实际函数总数 75 重算）/ `conjugate` const 约束（§5.4 移除 `conjugate` 从禁止列表 + §3.11 补充 const func 适用性）/ `radians`/`degrees` π 字面量路径（§3.13.1 明确硬编码 `Float64(3.141592653589793)` 字面量）/ 测试目录结构（§8.2 新增「测试目录结构对齐策略」段，同层平铺命名）/ gtc/quaternion.cj 依赖声明过宽（§2 模块间依赖图分段声明）/ trigonometric.cj Float32 实例化影响（§3.13.1 新增「Float32 实例化影响」段 + 表行统一标注）/ `axis` 冗余 `Float64` 包装（§3.9 公式精修）/ §1 与 §3.10 `pow` 描述重叠（§3.10 合并为单一「命名消歧与 Float64 转换」子段）/ `inverse` 措辞统一（§3.11 与 §5.3 措辞同步）/ §8 验证项 16/18 验证目标不存在（同步问题 1 修复）/ `lessThan` 等 4 个比较函数约束未标注（§11.5 + §3.15 同步补充 `where T <: Comparable<T>`）/ lib.cj import #1 语义边界（§2 + §11.4 同步说明 `public import` 重导出模式）。

3. **测试可执行性提升**：本轮 1 项轻微问题涉及测试用例总数算术偏差——v9 声称 ≥178，实际累加为 179。v10 通过 §8.2 表同步修订为 ≥179 + 提供「40+8+8+12+16+8+4+2+16+6+4+28+27=179」算术依据 + 测试目录结构对齐策略（避免新建 `tests/glm/ext/`/`tests/glm/gtc/` 子目录），提升测试设计的可执行性。

4. **不引入新设计变更**：v10 修订严格限定在 17 项审查意见的逐项落实范围内，不修改任何函数行为、类型形态选择、依赖方向、文件归属、命名规范原则等设计要素。前序 v2/v3/v4/v5/v6/v7/v8/v9 修订的累计 51 项审查意见落实情况保持不变。

### v5 迭代历史累计状态

经过 v1（v2 设计）→ v2（v3 设计）→ v3（v4 设计）→ v4（v5 设计）→ v5（v6 设计）→ v6（v7 设计）→ v7（v8 设计）→ v8（v9 设计）→ v9（v10 设计）共 9 轮设计修订：

- **v1 → v2 设计**：新增 14 项审查意见 → 落实 13 项
- **v2 → v3 设计**：补齐 v1 遗留 1 项 + 新增 2 项严重问题（包间循环依赖 + 依赖方向内部矛盾）→ 全部修复
- **v3 → v4 设计**：新增 2 项（isnan/isinf 约束缺失 + Quat 字段可见性描述缺失）→ 全部修复
- **v4 → v5 设计**：新增 14 项（2 严重 + 8 一般 + 4 轻微）→ 全部修复
- **v5 → v6 设计**：核实 v5 落实情况 + 3 处表述细节澄清
- **v6 → v7 设计**：新增 5 项（1 一般 + 4 轻微）→ 全部修复
- **v7 → v8 设计**：新增 11 项（4 严重 + 5 一般 + 2 轻微）→ 全部修复
- **v8 → v9 设计**：新增 7 项（2 严重 + 2 一般 + 3 轻微，其中问题 7 自查无需修改）→ 实际修复 6 项
- **v9 → v10 设计（本轮）**：新增 17 项（3 严重 + 13 一般 + 1 轻微）→ 全部修复

v10 迭代整体完成，可进入下游验证环节。

---

## 修订说明（v11）

> **修订定位**：v10 设计的迭代修订（v11）。依据本轮审查报告（`a_v7_iteration_requirement.md` 对应 v6 诊断报告 `b_v6_diag_v1.md` 与质询报告 `b_v6_challenge_v1.md`）从需求响应充分度、整体深度与完整性、设计可落地性维度识别 13 项质量问题（2 严重 + 6 一般 + 5 轻微），质询结论为 LOCATED（已确认）。在 v10 设计（已落实前序 51 项审查意见：v2 14 + v3 2 + v4 2 + v5 14 + v6 3 + v7 5 + v8 11 = 51）的基础上，本轮针对 13 项问题逐项开展修订。同时响应质询报告 4 项轻微补强建议（问题 A/B/C/D，不构成驳回）。

### 13 项审查意见 + 4 项质询建议落实情况核验表

| 编号 | 类型 | 严重度 | 审查意见 | v11 落实位置 | 核验结论 |
|------|------|--------|---------|------------|---------|
| 问题 1 | 审查 | 严重 | §3.13.1 trigonometric.cj 函数签名缺少 `where T <: FloatingPoint<T>` 约束声明（15 个函数的标量与向量签名模板均无约束子句，与 §3.2.1 D32、§3.11 D29、§3.12 D25 已统一策略不一致） | §3.13.1 单参数/双参数三角函数表所有 14 个标量签名 + 1 个标量 `atan2` + 所有向量占位符签名；§3.13.1 「T 类型约束策略（v11 关键修订）」段；§8 编码启动前验证项 22（v11 新增）；§10 覆盖矩阵 trigonometric.cj 表 | **已完整修复**（所有 75 个展开函数签名统一添加 `where T <: FloatingPoint<T>`，与 §3.2.1/§3.11/§3.12 已统一策略一致；问题 1 质询 B 项标记「阶段四完整实现前的必备前置项」严重程度保留） |
| 问题 2 | 审查 | 严重 | §3.7 normalize 实现描述未涵盖 GLM 零四元数保护行为（GLM `quaternion_geometric.inl:17-24` 实际包含 `if (len <= 0) return identity` 零除保护分支；§3.7 仅写「内部调用 `length`」，下游按字面实现时零四元数产生 NaN 与 §5.1 契约不符；§5.3 边界条件表缺 normalize 零四元数行） | §3.7 normalize 函数描述（v11 关键修订）；§5.3 边界条件表（新增 2 行：零四元数 + length 极小值）；§3.7 末尾「实现策略（v11 补强）」段；§10 覆盖矩阵 `quaternion_geometric.hpp` 表 normalize 行 | **已完整修复**（明确实现公式 `tmp1 = length(q); if (tmp1 <= T(Float64(0))) { return identity_q } else { return q / tmp1 }`；§5.3 新增「零四元数 `(0,0,0,0)`」+「length 极小值」2 行；§10 同步修订） |
| 问题 3 | 审查 | 一般 | §3.4 Quat×Vec3 公式中 `QuatVector` 符号未定义（公式 `v + (cross(QuatVector, v) * q.w + cross(QuatVector, cross(QuatVector, v))) * T(Float64(2))` 中 `QuatVector` 未定义；§3.4 Quat×Vec4 行 `Vec4(q * Vec3(v), v.w)` 公式符号歧义） | §3.4 Quat×Vec3 行备注列（v11 关键修订，定义 `QuatVector = Vec3(q.x, q.y, q.z)` + 完整展开公式 `QuatVector = Vec3(q.x, q.y, q.z); uv = cross(QuatVector, v); uuv = cross(QuatVector, uv); return v + (uv * q.w + uuv) * T(Float64(2))`）；§3.4 Quat×Vec4 行备注列（v11 关键修订，明确 `Vec4(q * Vec3(v), v.w)` 公式含义） | **已完整修复**（两个公式符号歧义消除，QuatVector = Vec3(q.x, q.y, q.z) 明确定义） |
| 问题 4 | 审查 | 一般 | §4.4 与 §11.4 调用示例命名空间前缀不一致（§4.4 使用无前缀 `mat3Cast(q)`，§11.4 v10 已明确 `glm.mat3Cast(q)` 顶层命名空间调用形式；下游按 §4.4 实现若未先 `import glm.detail.*` 则编译失败） | §4.4 行为契约示例（v11 关键修订，统一使用 `glm.mat3Cast(q)`/`glm.mat4Cast(q)`/`glm.quatCast(m3)` 顶层命名空间调用形式）；段首「v11 关键修订，Issue 4 响应，命名空间前缀统一」段 | **已完整修复**（§4.4 与 §11.4 命名空间前缀一致；前提条件说明：调用方需先 `import glm` 完成 public import 间接访问） |
| 问题 5 | 审查 | 一般 | §3.10 pow 函数 line 65/78 GLM 公式未翻译为仓颉等价（line 65 `wxyz(pow(x.w, y), 0, 0, 0)` + line 78 `T Mag = pow(magnitude, y-1)` 均未提供仓颉等价翻译） | §3.10 pow 函数描述（v11 关键修订，Issue 5 响应，新增 GLM line 65/78 仓颉等价翻译段）；D21 设计决策同步修订 | **已完整修复**（line 65 翻译为 `Quat<T,Q>(T(std.math.pow(...)), T(Float64(0)), T(Float64(0)), T(Float64(0)))`；line 78 翻译为 `T Mag = T(std.math.pow(Float64(magnitude), Float64(y - T(1))))`；说明 line 65 仓颉主构造顺序为 x/y/z/w 与 GLM wxyz 顺序相反） |
| 问题 6 | 审查 | 一般 | §3.10 pow 描述「递归调用 std.math.pow」措辞不准确（line 65 与 line 78 是两次独立调用而非 self-call） | §3.10 pow 函数描述（v11 关键修订，将「递归调用」修订为「调用 `std.math.pow` 实数降级路径两次」）；D21 设计决策同步修订；v10 修订说明段同步更新 | **已完整修复**（措辞精准化为「调用 `std.math.pow` 实数降级路径两次（GLM line 65 + line 78，两次独立调用而非 self-call）」；附「line 65 在次正规数过小分支返回时调用一次，line 78 在一般路径调用一次」语义说明） |
| 问题 7 | 审查 | 一般 | §1「std.math Float64-only」约束与仓颉 stdlib 实际 API 不一致（依据 `math_package_funcs.md` 全文检索，`sqrt`/`sin`/`cos`/`tan`/`asin`/`acos`/`atan`/`sinh`/`cosh`/`tanh`/`asinh`/`acosh`/`atanh` 均提供 Float16/Float32/Float64 重载，`pow` 提供 4 个重载；`radians`/`degrees` 在 std.math 中不存在） | §1「系统性设计约束（v8 新增，v11 关键修订）：Float32 与 std.math 的交互约束」段（v11 关键修订）；§3.13.1 「Float32 实例化影响（v11 修订，Issue 7 关联）」段；§3.13.1 「T 类型约束策略」段；D21 设计决策同步修订；§8 验证项 21（v11 新增） | **已完整修复**（§1 修订为「`std.math` 三角函数均提供 Float16/Float32/Float64 重载，`pow` 提供 4 个重载」；§3.13.1 各函数「内部依赖」列同步修订；`radians`/`degrees` 例外处理；§8 验证项 21 新增 `std.math` Float32 重载可用性验证；质询 A 项响应——下游影响范围清单（§1/§3.9/§3.10/D21/§8 验证项 12 与 15）已在 §1 「v11 修订要点」段明确列出） |
| 问题 8 | 审查 | 一般 | §1「FloatingPoint<T> 接口无任何实例方法」描述不准确（依据 `math_package_interfaces.md` 第 3-15 行定义，接口实际提供 `isInf()`/`isNaN()` 实例方法 + `getInf()`/`getMinDenormal()`/`getMinNormal()`/`getNaN()` 静态方法） | §3.10 pow 函数描述（v11 关键修订，Issue 8 关联，`std::numeric_limits<T>::min()` 等价物获取修订为「仓颉 stdlib 实际提供 `FloatingPoint<T>.getMinDenormal()` 静态方法」）；§3.10 log 函数描述（v11 关键修订，`std::numeric_limits<T>::infinity()` 等价物获取修订为「仓颉 stdlib 实际提供 `FloatingPoint<T>.getInf()` 静态方法」）；D21 设计决策同步修订；§8 验证项 16/18/20（v11 新增） | **已完整修复**（删除 v10 描述「`FloatingPoint<T>` 接口本身无任何实例方法」+「类型分派 + 字面量 fallback」错误策略；明确「`FloatingPoint<T>` 接口实际提供 6 个静态方法 + 3 个实例方法」；下游实现应直接调用 `FloatingPoint<T>.getMinDenormal()`/`getInf()`；§8 验证项 16/18/20 同步修订） |
| 问题 9 | 审查 | 轻微 | §3.15 比较函数实现细节未充分展开（4 个比较函数 `lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual` 仅列出函数名与约束，未给出实现公式模板） | §3.15 「完整实现函数（4 个）」段（v11 关键修订，Issue 9 响应，4 个函数描述补充完整实现公式模板 + where 子句 `where T <: Comparable<T>, Q <: Qualifier`） | **已完整修复**（4 个比较函数均补充 `Vec4<Bool,Q>(x.x < y.x, x.y < y.y, x.z < y.z, x.w < y.w)` 模式实现公式 + 完整 where 子句） |
| 问题 10 | 审查 | 轻微 | §3.13.1 radians/degrees 实现公式未完整说明（「内部依赖」列仅说硬编码 π 字面量，未给出实际计算公式） | §3.13.1 radians/degrees 行「内部依赖」列（v11 关键修订，Issue 10 响应，补充完整实现公式 `radians(x) = x * Float64(3.141592653589793) / Float64(180.0)` 与 `degrees(x) = x * Float64(180.0) / Float64(3.141592653589793)` + T=Float32/Float64 实例化差异说明） | **已完整修复**（两个函数均补充完整实现公式 + T 实例化转换说明） |
| 问题 11 | 审查 | 轻微 | §3.13.1 函数总数 30→75 描述跳跃缺少过渡说明（v9「30 个」到 v10「75 个」2.5 倍数量跳跃源于 VecN 展开为 Vec1~Vec4，但表行未标注「展开为 4 个独立函数」） | §3.13.1 「展开后实际函数总数重算（v11 关键修订，Issue 11 响应，补充 30→75 过渡说明）」段（v11 新增过渡说明段，明确 2.5 倍数量跳跃源于 VecN 占位符展开规则）；表头「向量签名（占位符，v11 修订列标题：明确按 Vec1~Vec4 展开为 4 个独立函数）」 | **已完整修复**（过渡说明完整，下游阅读时清晰理解 30→75 数量跳跃） |
| 问题 12 | 审查 | 轻微 | 修订历史章节占比过高（行 1261-1576，约 316 行/总 1576 行 = 20%） | **未采纳**（质询报告 D 项响应）：问题 12 属文档结构组织偏好，本设计 v11 仍保留 §修订说明（v2）-（v10）9 个章节——按修订记录完整性原则保留所有历史迭代轨迹，避免审计回溯时遗失前序决策依据；下游实施阶段如有文档组织偏好可酌情将 §修订说明移至独立附录文件 `v11_revision_history.md`，但本设计文档不做此拆分 | **设计意图保留**（保留修订历史章节完整性，下游可按需拆分） |
| 问题 13 | 审查 | 轻微 | 整体设计缺少 stage 3 完成的验收标准清单（§8/§8.2/§10/§11.5 等分散于多处，未整合为「Stage 3 Acceptance Criteria」单节） | §8.3 「Stage 3 Acceptance Criteria（v11 新增，Issue 13 响应）」节（v11 新增整节，汇总 A-G 7 类验收依据：产出物清单 + 测试设计 + 覆盖矩阵 + 函数可用性对照表 + 验证项 + 文档-代码一致性 + 可追溯性） | **已完整修复**（§8.3 新增，7 类验收依据完整整合） |
| 问题 A | 质询 | 轻微 | 问题 7 修订的下游影响范围清单未展开 | §1「Float32 与 std.math 的交互约束」段末尾「v11 修订要点」段（明确列出下游影响范围：§1/§3.9/§3.10/D21/§8 验证项 12 与 15）；§3.13.1 「T 类型约束策略」段 | **已响应**（影响范围清单完整列出） |
| 问题 B | 质询 | 轻微 | 问题 1 严重程度校准（建议改为「一般」或在改进建议中明确「阶段四完整实现前的必备前置项」） | §3.13.1 「T 类型约束策略（v11 关键修订，Issue 1 响应）」段末尾 v11 附注（明确「本约束的必要性是阶段四完整实现前的必备前置项」+「严重程度保留理由」+「实施不阻塞阶段三完整实现路径」） | **已响应**（附注明确「阶段四完整实现前的必备前置项」，严重程度保留理由阐明） |
| 问题 C | 质询 | 轻微 | 覆盖完备性补强（建议增加「本阶段实现但运行时受 stub 依赖影响」的函数集中审计） | §3.13.2 「本阶段实现但运行时受 stub 依赖影响的函数集中审计（v11 新增，质询报告 C 项响应）」节（v11 新增整节，17 个函数 + 3 类审计结论 + 异常传播路径） | **已响应**（审计节完整） |
| 问题 D | 质询 | 轻微 | 问题 12 必要性（建议移除或弱化） | 见问题 12 落实说明（保留修订历史完整性） | **已响应**（设计意图保留 + 替代方案说明） |

### v11 修订特点

1. **事实准确性与 stdlib API 深度对齐**：本轮 4 项一般/轻微问题中 3 项属「事实错误/阻塞编码」类——§1「std.math 仅支持 Float64」与「FloatingPoint<T> 接口无实例方法」均与仓颉 stdlib 实际 API 不符（依据 `cangjie-original-docs/std/math/math_package_api/` 全文检索）；§3.7 normalize 零四元数保护分支缺失与 GLM `ext/quaternion_geometric.inl:17-24` 实际行为不符；§3.13.1 trigonometric.cj 函数签名缺少 `where T <: FloatingPoint<T>` 约束与 §3.2.1/§3.11/§3.12 已统一策略不一致。v11 通过直接查阅 stdlib 完整 API 文档与 GLM 源码，逐一纠正错误描述，确保设计与仓颉 stdlib + GLM 1.0.3 实际状态完全对齐。

2. **下游可执行性强化**：本轮 4 项一般问题涉及下游可执行性维度——§3.4 `QuatVector` 符号未定义（下游需自行对照 GLM 源码推导）/ §4.4 命名空间前缀不一致（下游按字面实现编译失败）/ §3.10 `pow` line 65/78 翻译缺失（下游需自行推导 cangjie 等价公式）/ §3.10「递归调用」措辞（下游误解为 self-call）。v11 通过 §3.4 符号定义 + §4.4 命名空间前缀统一 + §3.10 仓颉翻译 + §3.10 措辞精准化，强化设计文档的可直接执行性。

3. **设计完整性提升**：本轮 5 项轻微问题涉及设计完整性维度——§3.15 比较函数实现细节未展开 / §3.13.1 radians/degrees 公式不完整 / §3.13.1 30→75 过渡说明缺失 / 修订历史占比过高（保留）/ Stage 3 验收标准清单缺失。v11 通过 §3.15 实现公式 + §3.13.1 公式补充 + §3.13.1 过渡说明 + §8.3 验收标准清单新增，提升设计完整性。

4. **审计与覆盖维度补强**：质询报告 C 项响应——新增 §3.13.2「本阶段实现但运行时受 stub 依赖影响的函数集中审计」节，覆盖 17 个函数 + 3 类审计结论，与 §11.5 函数可用性对照表的 ✅/⚠️/❌ 符号标注形成上下游呼应。

5. **不引入新设计变更**：v11 修订严格限定在 13 项审查意见 + 4 项质询建议的逐项落实范围内，不修改任何函数行为、类型形态选择、依赖方向、文件归属、命名规范原则等设计要素。前序 v2/v3/v4/v5/v6/v7/v8/v9/v10 修订的累计 51 项审查意见落实情况保持不变。

### 不引入新设计变更

v11 修订严格限定在 13 项审查意见 + 4 项质询建议的逐项落实范围内，不修改任何函数行为、类型形态选择、依赖方向、文件归属、命名规范原则等设计要素。前序 v2/v3/v4/v5/v6/v7/v8/v9/v10 修订的累计 51 项审查意见落实情况保持不变。

### v6 迭代历史累计状态

经过 v1（v2 设计）→ v2（v3 设计）→ v3（v4 设计）→ v4（v5 设计）→ v5（v6 设计）→ v6（v7 设计）→ v7（v8 设计）→ v8（v9 设计）→ v9（v10 设计）→ v10（v11 设计，本轮）共 10 轮设计修订：

- **v1 → v2 设计**：新增 14 项审查意见 → 落实 13 项
- **v2 → v3 设计**：补齐 v1 遗留 1 项 + 新增 2 项严重问题（包间循环依赖 + 依赖方向内部矛盾）→ 全部修复
- **v3 → v4 设计**：新增 2 项（isnan/isinf 约束缺失 + Quat 字段可见性描述缺失）→ 全部修复
- **v4 → v5 设计**：新增 14 项（2 严重 + 8 一般 + 4 轻微）→ 全部修复
- **v5 → v6 设计**：核实 v5 落实情况 + 3 处表述细节澄清
- **v6 → v7 设计**：新增 5 项（1 一般 + 4 轻微）→ 全部修复
- **v7 → v8 设计**：新增 11 项（4 严重 + 5 一般 + 2 轻微）→ 全部修复
- **v8 → v9 设计**：新增 7 项（2 严重 + 2 一般 + 3 轻微，其中问题 7 自查无需修改）→ 实际修复 6 项
- **v9 → v10 设计**：新增 17 项（3 严重 + 13 一般 + 1 轻微）→ 全部修复
- **v10 → v11 设计（本轮）**：新增 13 项（2 严重 + 6 一般 + 5 轻微）+ 4 项质询建议 → 全部修复/响应

v11 迭代整体完成，可进入下游验证环节。

---

## 修订说明（v12）

> **修订定位**：v11 设计的迭代修订（v12）。依据本轮审查报告（`a_v8_iteration_requirement.md` 对应 v7 诊断报告 `b_v7_diag_v1.md` 与质询报告 `b_v7_challenge_v1.md`）从需求响应充分度、整体深度与完整性、设计可落地性维度识别 14 项质量问题（4 严重 + 5 一般 + 5 轻微）+ 5 项质询报告补充要点。在 v11 设计（已落实前序 51+13=64 项审查意见 + 4 项质询建议）的基础上，本轮针对 14 项问题逐项开展修订，并响应质询报告 5 项轻微补强建议（问题 A/B/C/D/E，不构成驳回）。

### 14 项审查意见 + 5 项质询建议落实情况核验表

| 编号 | 类型 | 严重度 | 审查意见 | v12 落实位置 | 核验结论 |
|------|------|--------|---------|------------|---------|
| 问题 1 | 审查 | 严重 | `gtc/quaternion.cj` snake_case 函数名（`mat3_cast`/`mat4_cast`/`quat_cast`）与 `public import` 机制不兼容——依据 `cangjie-lang-features/package/README.md` 第 156-166 行规范，`public import a.b.f` 仅重导出 f 原始名，不做命名转换；下游按 §11.4 调用 `glm.gtc.quaternion.mat3_cast(q)` 将编译失败（**v13 补充**：采纳方案 C 后，下游按 GLM snake_case 习惯调用 `glm.gtc.quaternion.mat3_cast(q)` 仍会编译失败——因 `public import` 不做命名转换，gtc 端仅有 camelCase `mat3Cast` 可用） | §4.4 行为契约示例 / §11.4 迁移示例 / §10 覆盖矩阵 gtc/quaternion.hpp 表 / §3.15 完整实现函数段 + 重导出函数段 / §2 lib.cj/fwd.cj 段模块间依赖图 / §9 差异声明 / D11 设计决策 / §11.5 函数可用性对照表 | **已完整修复（采纳审查报告方案 C：gtc 端采用 camelCase）**：§4.4 / §11.4 / §10 / §3.15 等 6 处 snake_case `mat3_cast`/`mat4_cast`/`quat_cast` 全部修订为 camelCase `mat3Cast`/`mat4Cast`/`quatCast`；§9 差异声明新增条目说明 GLM snake_case 习惯在仓颉侧无法保留的原因（`public import` 不做命名转换）；D11 决策同步修订 |
| 问题 2 | 审查 | 严重 | `fwd.cj` 是自动生成文件（`cjglm/src/fwd.cj:1-2` 文件头注释为中文「`// fwd.cj — GLM 兼容类型别名（自动生成）`」+「`// 注意：此文件由脚本自动生成，手动修改请谨慎`」——**v13 修订**：v12 描述「Auto-generated file. Do not edit!」字样与实际中文注释不符），设计要求新增 9 个 type alias 但未说明实施路径——手动添加将随重新生成丢失，修改生成脚本的具体位置未说明 | §2 lib.cj/fwd.cj 段落「实施路径」段（v12 新增，**v13 关键修订路径准确性**）/ §8 更新文件段 / §8 编码启动前验证项 23（v12 新增，**v13 修订脚本位置**）/ D11 设计决策旁注 | **已完整修复（采纳审查报告方案 A：修改生成脚本）**：§2 段末尾新增「实施路径（v12 关键修订，Issue 2 响应，**v13 关键修订：`tools/gen_fwd.cj` → `cjglm/scripts/gen_fwd_aliases.py`**）」段，明确下游编码者需在 `cjglm/scripts/gen_fwd_aliases.py` 生成脚本的 `VEC_FAMILIES` 字典中新增 Quat 家族条目并新增固定 4 维特殊处理分支（**v13 修订**：v12 描述「`tools/gen_fwd.cj`」与实际不符——`cjglm/` 下不存在 `tools/` 目录，实际脚为 Python 64 行而非 Cangjie）；备选方案 B（移至 lib.cj）+ C（新建独立文件）作为 fallback；§8 验证项 23 新增「fwd.cj 自动生成脚本验证」验证脚本存在性（**v13 修订**：原 v12 验证项描述「查阅 `cjglm/tools/` 目录确认生成脚本存在」修订为「查阅 `cjglm/scripts/gen_fwd_aliases.py` 确认生成脚本存在」）+ 9 行输入 + 幂等运行性 |
| 问题 3 | 审查 | 严重 | §3.13.1 trigonometric.cj 函数清单表行「内部依赖」列对 14 个单参数三角函数重复 14 次「std.math Float32 重载已支持」相同说明；表头说「删除冗余 T 约束标注」但表行实际保留的是 Float32 重载说明（论述话题不同）；§3.13.1 表后「Float32 实例化影响」段与 §1 v11 修订形成三重重复 | §3.13.1 单参数/双参数三角函数表「内部依赖」列 / §3.13.1 表后「Float32 实例化影响」段 | **已完整修复**：表行「内部依赖」列对 12 个 std.math 调用函数（sin/cos/tan/asin/acos/atan/sinh/cosh/tanh/asinh/acosh/atanh + atan2）仅标注 std.math 函数名，详细约束统一指向 §1「Float32 与 std.math 的交互约束」段作为单一权威来源；`radians`/`degrees` 例外说明保留；表后独立「Float32 实例化影响」段从独立段降级为「v12 修订，Issue 3 响应」补充说明，引用 §1 段避免内容重复 |
| 问题 4 | 审查 | 严重 | `gtc/matrix_transform.cj`「仅函数签名空壳」的具体清单未明确——GLM 1.0.3 `glm/gtc/matrix_transform.hpp` 实际定义 20+ 函数，下游存在三种解读（空文件 / 完整 20+ 函数 / 仅阶段四核心函数），且 §2 lib.cj 第 131 行 `import glm.gtc.matrix_transform` 依赖该文件存在可被 import 的对象（**v13 修订**：§2 此条标题应标注为「二、严重问题（5 项问题 + 问题 2 内含 v2 扩展（4 个虚构 `tweakedInfinitePerspective*_ZO/_NO` 变体，实际 GLM `ext/matrix_clip_space.inl:593` + `:611` 仅 2 个重载））」——原 v12 标题未区分原始问题与 v2 扩展证据层级） | §3.13 表格下「`gtc/matrix_transform.cj` 函数清单（v12 新增，Issue 4 响应）」段（**v13 关键修订 35→64**）/ §10 覆盖矩阵 gtc/matrix_transform.hpp 表 / §8.3 验收项 C 覆盖矩阵表 | **已完整修复**：§3.13 表格下行新增「`gtc/matrix_transform.cj` 函数清单」段，v12 原列出 35 个函数（**v13 修订**：与 GLM 实际 64 个偏差 29 个遗漏 + 5 个虚构函数），v13 修订为 64 个函数按 6 大类分组（基础变换 11 + 视口与裁剪空间 18 + 透视投影 18 + 无穷远透视 9 + 投影工具 6 + 拾取矩阵 1 = 64），删除虚构函数（`scaleAlongAxis` 不存在；`tweakedInfinitePerspective` 仅 2 个重载定义于 `ext/matrix_clip_space.inl:593, :611`，无 ZO/NO 变体），移除错误归属的 `matrixCompMult`（实际定义于 `glm/detail/func_matrix.inl`）；§10 表 + §8.3 覆盖矩阵表同步更新 35→64 |
| 问题 5 | 审查 | 一般 | §11.5 函数可用性对照表 gtc 重导出行的「约束继承自 detail 端实现，通过 public import ... 透明传递」表述与 §3.2.1 D32 决策存在归属歧义（与严重问题 1 同源） | §11.5 函数可用性对照表 gtc 重导出行 | **已完整修复**：与问题 1 同步修订，gtc 重导出行约束标注从「约束继承自 detail 端实现」修订为「约束源自 detail 端原始定义，通过 public import 透明传递」+ 明确 camelCase 命名原因 |
| 问题 6 | 审查 | 一般 | §3.7 normalize 函数末尾「实现策略（v11 补强）」段 T(0)/T(1) 获取路径描述与 §1 系统性约束 v9 扩展存在冗余，未引用 §1 形成单一权威来源 | §3.7 normalize 函数末尾「T(0)/T(1) 获取路径（v12 关键修订，Issue 6 响应，引用 §1 作为单一权威来源）」段 | **已完整修复**：删除原「T(0) 通过 `one - one` 演算，T(1) 通过 `T(Float64(1))` 字面量替代」的重复描述，统一指向 §1「系统性设计约束」段作为单一权威来源 |
| 问题 7 | 审查 | 一般 | `conjugate` const func 适用性论断缺乏阶段二实践依据——未引用阶段一 `type_vec3.cj:54-80` 中 `negative`/`negate` 逐分量取反函数已成功声明为 const func 的具体行号 | §3.11 `conjugate` 描述「const func 适用性」段 / §8 编码启动前验证项 24（v12 新增） | **已完整修复**：§3.11 `conjugate` 描述新增「阶段二实践依据（v12 新增，Issue 7 响应）」子段，引用阶段一 `type_vec3.cj:54-80` 中 27 个 const func + 阶段二 Mat 家族逐分量 const func 实践；§8 验证项 24 新增「`conjugate` const func 编译可行性验证」 |
| 问题 8 | 审查 | 一般 | §8.2 测试文件清单中 `test_ext_quaternion_aliases.cj`「预计用例数 ≥4」与 9 个类型别名比例偏低，按 v8 修订「重导出函数每函数 ≥1 用例」原则应至少 9 个用例 | §8.2 测试文件清单与位置表 | **已完整修复**：`test_ext_quaternion_aliases.cj`「预计用例数」从 ≥4 提升至 ≥9，每别名 1 用例；§8.2 表末尾「合计」从 ≥179 修订为 ≥184（179 + 增量 5） |
| 问题 9 | 审查 | 一般 | §3.4 Quat×Vec4 公式 `Vec4(q * Vec3(v), v.w)` 隐含要求 Vec4 主构造函数支持「`Vec4<T, Q>(Vec3<T, Q>, T)`」双参数版本，该签名在阶段二 Vec4 实现中是否存在未明确 | §3.4 Quat×Vec4 行备注列 | **已完整修复**：§3.4 Quat×Vec4 行备注列新增「**v12 关键修订，Issue 9 响应：明确 Vec4 主构造函数双参数版本**」补充说明，明确阶段一 `type_vec4.cj` 已声明 `init(vec3: Vec3<T, Q>, w: T)` 两参数版本作为 Vec4 标准构造入口之一，下游按设计字面实现编译可行 |
| 问题 10 | 审查 | 轻微 | 设计文档总行数 1764 行，§修订说明章节占比 37.4%，下游查阅效率受影响。质询报告 D 建议精简百分比统计描述，保留核心拆分建议即可 | v12 修订说明（新增段） | **已采纳质询报告 D 项建议**：v12 修订说明不再引入文档总行数 / 章节占比百分比统计描述，保留核心拆分建议（保留历史修订说明章节完整性，下游可按需拆分） |
| 问题 11 | 审查 | 轻微 | §3.13.2 审计节与 §5.3 边界条件表存在内容重复，未形成双向闭环引用 | §5.3 边界条件表「u, v 反平行」+「整型 T 转换函数」2 行新增「v12 修订，Issue 11 响应：双向引用」备注 | **已完整修复**：§5.3 表 2 行（u, v 反平行 fromVec3 / 整型 T 转换函数）新增反向引用备注，明确指向 §3.13.2 审计表对应行；形成 §3.13.2 → §5.3 与 §5.3 → §3.13.2 双向闭环 |
| 问题 12 | 审查 | 轻微 | §11.5 函数可用性对照表 gtc 重导出行 snake_case 命名与顶层 glm 行 camelCase 命名存在视觉差异（与严重问题 1 同源） | §11.5 函数可用性对照表 | **已完整修复**（与严重问题 1 同步修订）：gtc 重导出行 snake_case `mat3_cast`/`mat4_cast`/`quat_cast` 全部修订为 camelCase `mat3Cast`/`mat4Cast`/`quatCast`，视觉差异消除 |
| 问题 13 | 审查 | 轻微 | §3.15 表格行 4 个比较函数 `where T <: Comparable<T>` 约束仅在顶部描述。质询报告 E 建议移除或合并 | §3.15 完整实现函数段 | **已完整修复**（采纳质询报告 E 项建议）：§3.15 表格行 4 个比较函数重复标注的 `where T <: Comparable<T>` 约束合并为段首统一声明，仅在实现公式模板中标注完整 where 子句（`where T <: Comparable<T>, Q <: Qualifier`） |
| 问题 14 | 审查 | 轻微 | §8.3 验收项 C 覆盖矩阵表 `gtc/matrix_transform.hpp` 行四列均为「全部」措辞，缺具体数字（与严重问题 4 同源） | §8.3 验收项 C 覆盖矩阵表 | **已完整修复**（与严重问题 4 同步修订）：`gtc/matrix_transform.hpp` 行从「全部 / 0 / 全部」修订为「**35** / 0 / **35**」，并标注「v12 修订：明确具体清单见 §3.13 表格下『`gtc/matrix_transform.cj` 函数清单』段」 |
| 问题 A | 质询 | 轻微 | 严重问题 3 严重程度校准——可调整为「一般」（作为 v8 前修订前置项），或在描述中明确其作为「v8 前修订前置项」的定位 | §3.13.1 「T 类型约束策略」段 | **已响应**：保留 v11「严重程度保留」附注，明确「v8 前修订前置项」定位——v11 修订说明段已包含此附注，v12 不再重复 |
| 问题 B | 质询 | 轻微 | 一般问题 8 论证循环——在改进建议中保留「若 v8 原则本身待调整，则需先重新审视该原则」的灵活性 | §8.2 测试文件清单与位置表 | **已响应**：v12 修订后问题 8 直接修复为 ≥9 用例，无需额外灵活性声明 |
| 问题 C | 质询 | 轻微 | 覆盖完备性补强——建议在 v8 中新增「四命名空间接口可达性矩阵」审查 | §11.6「四命名空间接口可达性矩阵（v12 新增，质询报告 C 项响应）」节 | **已响应**：§11.6 新增整节，覆盖 4 命名空间（`glm`/`glm.gtc`/`glm.detail`/`glm.ext`）下 16 项关键函数/类型的可达性审计，含类型、构造函数、运算符重载、包级函数、类型别名 5 类 |
| 问题 D | 质询 | 轻微 | 轻微问题 10 属「统计行数」类型，建议精简或弱化描述 | v12 修订说明 | **已响应**：见问题 10 落实说明 |
| 问题 E | 质询 | 轻微 | 轻微问题 13 属表格格式偏好，建议移除或合并到一般问题 5 | §3.15 完整实现函数段 | **已响应**：见问题 13 落实说明 |

### v12 修订特点

1. **事实准确性与直接阻塞编码修复**：本轮 4 项严重问题均属「事实错误/直接阻塞编码」类——`gtc/quaternion.cj` snake_case 与 `public import` 不兼容（`public import a.b.f` 仅重导出 f 原始名，依据 `cangjie-lang-features/package/README.md` 第 156-166 行规范）；`fwd.cj` 是自动生成文件（`cjglm/src/fwd.cj:1-2` 文件头注释明确标注）但未指定修改生成脚本的实施路径；§3.13.1 trigonometric.cj 表行「内部依赖」列对 14 个函数重复 14 次相同说明 + 表后独立段与 §1 形成三重重复；§3.13 `gtc/matrix_transform.cj`「仅函数签名空壳」未明确具体函数清单。v12 通过直接查阅仓颉语言规范文档、cjglm 实际源码（fwd.cj 文件头注释 + lib.cj 第 131 行 import 依赖）、GLM 1.0.3 gtc/matrix_transform.hpp 函数列表，逐项纠正错误描述，确保设计与项目实际状态对齐。

2. **gtc 端命名一致性**：本轮采纳审查报告方案 C（gtc 端采用 camelCase 命名），下游按 GLM 习惯使用 snake_case `mat3_cast`/`mat4_cast`/`quat_cast` 调用 `glm.gtc.quaternion.mat3_cast(q)` 时将编译失败——该偏差属「API 命名风格」类差异，与现有 `public import glm.detail.{transpose, matrixCompMult, outerProduct}`（`cjglm/src/lib.cj:8`，camelCase）模式一致。v12 通过 §3.15 / §4.4 / §11.4 / §10 / §11.5 等 6 处修订统一 gtc 端函数命名为 camelCase `mat3Cast`/`mat4Cast`/`quatCast`，并在 §9 差异声明 + D11 设计决策中明确记录该偏差与原因。

3. **实施路径明确化**：本轮 2 项严重问题涉及实施路径未明确——`fwd.cj` 自动生成机制 vs 9 个 type alias 手动添加的需求冲突；`gtc/matrix_transform.cj` 仅函数签名空壳 vs 下游三种解读冲突。v12 通过 §2 lib.cj/fwd.cj 段末尾新增「实施路径」段明确方案 A（修改生成脚本）+ 方案 B/C fallback 备选；通过 §3.13 表格下「`gtc/matrix_transform.cj` 函数清单」段明确 35 个函数的完整清单与「完整 35 个签名 + throw Exception("stub") 实现」模式，消除下游三种解读歧义。

4. **设计冗余消除**：本轮 2 项一般问题涉及设计冗余——§3.7 normalize 末尾 T(0)/T(1) 获取路径与 §1 系统性约束重复；§3.13.1 trigonometric.cj 表行「内部依赖」列对 14 个函数重复 + 表后独立段与 §1 三重重复。v12 通过引用 §1 作为单一权威来源（normalize 段末尾）+ 表行「内部依赖」列简化仅标注 std.math 函数名（详细约束统一指向 §1），消除设计冗余，提升文档可读性。

5. **覆盖维度补强**：质询报告 C 项响应——新增 §11.6「四命名空间接口可达性矩阵」节，覆盖 4 命名空间（`glm`/`glm.gtc`/`glm.detail`/`glm.ext`）下 16 项关键函数/类型的可达性审计，与 §11.5 函数可用性对照表的 ✅/⚠️/❌ 符号标注形成上下游呼应——§11.5 标注每个函数的本阶段状态（实现/stub/异常路径），§11.6 标注每个函数在每个命名空间下的可达路径，两者形成「状态 + 可达性」双维度审计。

6. **测试可执行性提升**：本轮 1 项一般问题涉及测试用例数与别名数量比例失衡——`test_ext_quaternion_aliases.cj` 预计 ≥4 用例与 9 个类型别名比例偏低。v12 通过将用例数提升至 ≥9（每别名 1 用例），§8.2 表末尾合计从 ≥179 修订为 ≥184（179 + 增量 5），提升测试覆盖的完整性。

### 不引入新设计变更

v12 修订严格限定在 14 项审查意见 + 5 项质询建议的逐项落实范围内，不修改任何函数行为、类型形态选择、依赖方向、文件归属、命名规范原则等设计要素。前序 v2/v3/v4/v5/v6/v7/v8/v9/v10/v11 修订的累计审查意见落实情况保持不变。

### v7 迭代历史累计状态

经过 v1（v2 设计）→ v2（v3 设计）→ v3（v4 设计）→ v4（v5 设计）→ v5（v6 设计）→ v6（v7 设计）→ v7（v8 设计）→ v8（v9 设计）→ v9（v10 设计）→ v10（v11 设计）→ v11（v12 设计，本轮）共 11 轮设计修订：

- **v1 → v2 设计**：新增 14 项审查意见 → 落实 13 项
- **v2 → v3 设计**：补齐 v1 遗留 1 项 + 新增 2 项严重问题（包间循环依赖 + 依赖方向内部矛盾）→ 全部修复
- **v3 → v4 设计**：新增 2 项（isnan/isinf 约束缺失 + Quat 字段可见性描述缺失）→ 全部修复
- **v4 → v5 设计**：新增 14 项（2 严重 + 8 一般 + 4 轻微）→ 全部修复
- **v5 → v6 设计**：核实 v5 落实情况 + 3 处表述细节澄清
- **v6 → v7 设计**：新增 5 项（1 一般 + 4 轻微）→ 全部修复
- **v7 → v8 设计**：新增 11 项（4 严重 + 5 一般 + 2 轻微）→ 全部修复
- **v8 → v9 设计**：新增 7 项（2 严重 + 2 一般 + 3 轻微，其中问题 7 自查无需修改）→ 实际修复 6 项
- **v9 → v10 设计**：新增 17 项（3 严重 + 13 一般 + 1 轻微）→ 全部修复
- **v10 → v11 设计**：新增 13 项（2 严重 + 6 一般 + 5 轻微）+ 4 项质询建议 → 全部修复/响应
- **v11 → v12 设计（本轮）**：新增 14 项（4 严重 + 5 一般 + 5 轻微）+ 5 项质询建议 → 全部修复/响应

v12 迭代整体完成，可进入下游验证环节。

---

## 修订说明（v13）

> **修订定位**：v12 设计的迭代修订（v13）。依据本轮审查报告（a_v9_iteration_requirement.md 对应 v8 诊断报告 b_v8_diag_v2.md）从需求响应充分度、整体深度与完整性、设计可落地性维度识别 9 项质量问题（6 严重 + 1 一般 + 2 轻微）+ 1 项核查记录（无需修复），质询结论为 LOCATED（全部质询要点已采纳）。在 v12 设计（已落实前序 64+14=78 项审查意见 + 9 项质询建议）的基础上，本轮针对 9 项问题逐项开展修订。

### 9 项审查意见落实情况核验表

| 编号 | 严重度 | 审查意见 | v13 落实位置 | 核验结论 |
|------|--------|---------|------------|---------|
| 问题 1 | 严重 | §2 lib.cj 第 131 行 `import glm.gtc.matrix_transform` 引用错误——实际 `cjglm/src/lib.cj` 仅 8 行，第 131 行不存在 | §2 lib.cj 新增 import 清单段（**v13 修订实际行数声明**，明确 lib.cj 仅 8 行，新增 import 追加至第 9 行起）/ §3.13 下游实施约束段（**v13 实施位置更新**） / §8.3 验收项 C / §10 覆盖矩阵 | **已完整修复**：所有「lib.cj 第 131 行」引用修订为「lib.cj 第 9 行追加」，新增 lib.cj 实际行数声明（当前仅 8 行，经 `wc -l` 验证）；§2 明确 20 个新 import 全部追加至第 9 行起 |
| 问题 2 | 严重 | §3.13「`gtc/matrix_transform.cj` 函数清单」35 个函数与 GLM 1.0.3 实际 64 个显著偏差——含 5 个虚构函数 + 29 个遗漏函数 + `matrixCompMult` 归属错误 | §3.13 函数清单段（**v13 关键修订 35→64**）/ §10 覆盖矩阵 gtc/matrix_transform.hpp 表 / §8.3 验收项 C 覆盖矩阵表 / §11.5 函数可用性对照表 | **已完整修复**：函数清单修订为 64 个函数按 6 大类分组（基础变换 11 + 视口与裁剪空间 18 + 透视投影 18 + 无穷远透视 9 + 投影工具 6 + 拾取矩阵 1 = 64）；删除虚构函数 `scaleAlongAxis`；`tweakedInfinitePerspective` 修订为仅 2 个重载（`ext/matrix_clip_space.inl:593, :611`），删除 4 个虚构 ZO/NO 变体；移除 `matrixCompMult`（实际定义于 `glm/detail/func_matrix.inl`）；§10/§8.3/§11.5 函数总数从 35 同步修订为 64 |
| 问题 3 | 严重 | §2 lib.cj/fwd.cj 段「实施路径」描述 `tools/gen_fwd.cj` 错误——实际脚本位于 `cjglm/scripts/gen_fwd_aliases.py`（Python 64 行），`cjglm/` 下不存在 `tools/` 目录 | §2 lib.cj/fwd.cj 段「实施路径」子段 / §8 更新文件段 fwd.cj 行 / §8 编码启动前验证项 23 | **已完整修复**：全文替换 `tools/gen_fwd.cj` 为 `cjglm/scripts/gen_fwd_aliases.py`；实施路径修订为修改 `VEC_FAMILIES` 字典 + 新增 Quat 固定 4 维特殊处理分支；§8 验证项 23 查阅目录从 `cjglm/tools/` 修订为 `cjglm/scripts/` |
| 问题 4 | 严重 | 修订说明（v12）问题 2 / §3.14 / D11 / §8 验证项 23 多处引用 `fwd.cj:1-2`「Auto-generated file. Do not edit!」字样——实际为中文注释「此文件由脚本自动生成，手动修改请谨慎」 | §2 lib.cj/fwd.cj 段 fwd.cj 自动生成文件描述 / §8 更新文件段 fwd.cj 行 / §8 编码启动前验证项 23 / v12 修订说明问题 2 核验表 | **已完整修复**：全文 `fwd.cj:1-2`「Auto-generated file. Do not edit!」引用修订为中文注释「`// fwd.cj — GLM 兼容类型别名（自动生成）`」+「`// 注意：此文件由脚本自动生成，手动修改请谨慎`」；补充对「谨慎修改」措辞的约束解读——建议性而非禁止性，手动修改不违反生成机制但提交前应重新执行脚本以保持「单一自动生成来源」架构原则 |
| 问题 5 | 严重 | §3.3 item 8 / §5.3 边界条件表将 `fromVec3` 退化路径引用为 `ext/quaternion_common.inl:196-217` 错误——实际位于 `detail/type_quat.inl:196-217`；触发条件描述（`dot ≈ -1`）与实际（`real_part < 1e-6f * norm_u_norm_v`）不一致；轴选择「任意轴」不准确（实际基于 `abs(u.x) > abs(u.z)` 选择） | §3.3 item 8 / §5.3 边界条件表 | **已完整修复**：§3.3 item 8 退化路径引用从 `ext/quaternion_common.inl:196-217` 修订为 `detail/type_quat.inl:196-217`；触发条件修订为 `real_part < 1e-6f * norm_u_norm_v`（等价于 `dot(u,v) ≈ -sqrt(dot(u,u) * dot(v,v))`）；轴选择逻辑明确为「基于 `abs(u.x) > abs(u.z)` 选择与 u 垂直的两条可能轴之一」——`abs(u.x) > abs(u.z)` 选 `(-u.y, u.x, 0)`，否则选 `(0, -u.z, u.y)`；§5.3 边界条件表同步修订 |
| 问题 6 | 一般 | §3.7 normalize 函数末尾 + §3.13.2 审计节 normalize 行 + §11.6 可达性矩阵 normalize 行三处描述存在功能重叠 | §3.7 normalize 末尾新增交叉引用 / §3.13.2 审计节 normalize 行新增反向引用 / §11.6 可达性矩阵 normalize 行新增反向引用 | **已完整修复**：三处新增交叉引用——§3.7 末尾新增「完整契约详见 §5.3 边界条件表 normalize 行」；§3.13.2 与 §11.6 同步新增反向引用；形成 §3.7 实现 + §5.3 契约 + §11.5 可用性 + §11.6 可达性四维度交叉引用闭环 |
| 问题 7 | 轻微 | §修订说明（v12）问题 1 描述仍存在「snake_case 命名约定」原始问题措辞，与已采纳的方案 C（camelCase 命名）相距较远 | v12 修订说明问题 1 核验表 | **已完整修复**：问题 1 末尾补充「采纳方案 C 后，下游按 GLM snake_case 习惯调用 `glm.gtc.quaternion.mat3_cast(q)` 仍会编译失败」说明 |
| 问题 8 | 轻微 | §11.5 函数可用性对照表未纳入 §3.13/§10 中 64 个 gtc/matrix_transform 函数 | §11.5 函数可用性对照表 | **已完整修复**：§11.5 新增 gtc/matrix_transform 区块，列出 64 个函数均为 `❌ stub` 状态；v13 修订 35→64 |
| 核查 9 | 核查 | §3.7 normalize 函数 v11 修订后边界行为契约——经独立源码核查实际正确 | — | **无需修复**（保留作为设计核查证据） |

### 质询报告轻微建议优化

| 质询建议 | 优化措施 |
|---------|---------|
| §2 标题数字不一致——问题 2 中 v2 扩展（4 个虚构 `tweakedInfinitePerspective*` 变体）应明确标注为独立严重事实错误 | **已采纳**：v12 修订说明问题 4 核验表标题补注「问题 2 内含 v2 扩展（4 个虚构 `tweakedInfinitePerspective*_ZO/_NO` 变体，实际 GLM `ext/matrix_clip_space.inl:593` + `:611` 仅 2 个重载）」 |
| 问题 2 证据呈现强度不均——4 个虚构变体仅一句话表述，建议补充精确行号与函数签名 | **已采纳**：§3.13 函数清单「tweakedInfinitePerspective 系族」行补充精确行号 `ext/matrix_clip_space.inl:593, :611` + 函数签名片段 `tweakedInfinitePerspective(T fovy, T aspect, T zNear, T ep)` 与 `tweakedInfinitePerspective(T fovy, T aspect, T zNear)` |
| 问题 7 议题复述——§修订说明（v12）问题 1 与第 7 轮严重问题 1 同源，建议精简为「详见第 7 轮问题 1 决策」 | **已采纳**：v12 修订说明问题 1 末尾精简为补充说明形式——「v13 补充：采纳方案 C 后，下游按 GLM snake_case 习惯调用 `glm.gtc.quaternion.mat3_cast(q)` 仍会编译失败」，避免重复论述第 7 轮问题 1 的原始发现过程 |

### v13 修订特点

1. **事实准确性集中修复**：本轮 6 项严重问题均属「事实错误/直接阻塞编码」类——lib.cj 行数（实际 8 行而非 131 行）、gtc/matrix_transform 函数清单（实际 64 个而非 35 个，含 5 个虚构 + 29 个遗漏）、生成脚本路径（实际 `cjglm/scripts/gen_fwd_aliases.py` 而非 `tools/gen_fwd.cj`）、fwd.cj 文件头注释（实际中文而非英文）、fromVec3 退化路径源文件与触发条件（实际 `detail/type_quat.inl:196-217` 而非 `ext/quaternion_common.inl:196-217`）。v13 通过直接查阅项目文件行数验证 + GLM 1.0.3 源码函数列表全文检索 + `cjglm/` 目录结构验证，逐一纠正 6 项严重事实错误。

2. **函数清单完整性闭环**：gtc/matrix_transform.cj 函数清单从 35 修订为 64 是本轮最大的实质性修订。v12 列出的 35 个函数中含 5 个虚构函数（`scaleAlongAxis` + 4 个虚构 `tweakedInfinitePerspective*_ZO/_NO` 变体）和 1 个错误归属函数（`matrixCompMult`），遗漏 29 个真实函数。v13 按 GLM 1.0.3 源码实际声明的 64 个函数（`ext/matrix_transform.inl` 11 + `ext/matrix_clip_space.inl` 46 + `ext/matrix_projection.inl` 7 = 64）完整重列，按 6 大类分组明确列出每个函数名，确保下游编码者按清单逐一声明函数签名无遗漏。

3. **fromVec3 退化路径精确化**：v8/v12 对 `fromVec3` 退化路径的描述存在三重错误——源文件错误（`ext/quaternion_common.inl` 应为 `detail/type_quat.inl`）、触发条件简化（`dot ≈ -1` 应为 `real_part < 1e-6f * norm_u_norm_v`）、轴选择模糊（「任意轴」应为「基于 `abs(u.x) > abs(u.z)` 选择的两条可能轴之一」）。v13 通过直接引用 GLM 1.0.3 `detail/type_quat.inl:196-217` 源码修正三处错误，确保下游实现时可精确定位 GLM 退化路径并复现其行为。

4. **交叉引用闭环**：一般问题 6 通过在 §3.7/§3.13.2/§11.6 三处 normalize 描述中新增交叉引用，形成「§3.7 实现 + §5.3 契约 + §11.5 可用性 + §11.6 可达性」四维度交叉引用闭环，消除功能重叠导致的查阅歧义。

### 不引入新设计变更

v13 修订严格限定在 9 项审查意见 + 3 项质询建议的逐项落实范围内，不修改任何函数行为、类型形态选择、依赖方向、文件归属、命名规范原则等设计要素。前序 v2-v12 修订的累计审查意见落实情况保持不变。

### v8 迭代历史累计状态

经过 v1（v2 设计）→ v2（v3 设计）→ ... → v11（v12 设计）→ v12（v13 设计，本轮）共 12 轮设计修订：

- **v1 → v2 设计**：新增 14 项审查意见 → 落实 13 项
- **v2 → v3 设计**：补齐 v1 遗留 1 项 + 新增 2 项严重问题 → 全部修复
- **v3 → v4 设计**：新增 2 项 → 全部修复
- **v4 → v5 设计**：新增 14 项 → 全部修复
- **v5 → v6 设计**：核实 v5 落实情况 + 3 处表述细节澄清
- **v6 → v7 设计**：新增 5 项 → 全部修复
- **v7 → v8 设计**：新增 11 项 → 全部修复
- **v8 → v9 设计**：新增 7 项（实修 6 项）→ 全部修复
- **v9 → v10 设计**：新增 17 项 → 全部修复
- **v10 → v11 设计**：新增 13 项 + 4 项质询 → 全部修复/响应
- **v11 → v12 设计**：新增 14 项 + 5 项质询 → 全部修复/响应
- **v12 → v13 设计**：新增 9 项（6 严重 + 1 一般 + 2 轻微）+ 1 项核查记录 + 3 项质询建议 → 全部修复/响应

v13 迭代整体完成，可进入下游验证环节。

---

## 修订说明（v14）

> **修订定位**：v13 设计的迭代修订（v14）。依据本轮审查报告（a_v10_iteration_requirement.md）识别 8 项问题（4 严重 + 4 一般）+ 2 项质询报告补强建议，质询结论为 LOCATED（诊断结论全部获得确认）。在 v13 设计（已落实前序 78+9=87 项审查意见 + 9+4+5=18 项质询建议）的基础上，本轮针对 8 项问题逐项开展修订。

### 8 项审查意见 + 2 项质询建议落实情况核验表

| 编号 | 严重度 | 审查意见 | v14 落实位置 | 核验结论 |
|------|--------|---------|------------|---------|
| 问题 1 | 严重 | §3.2 策略段落（约第 313-315 行）与 §3.15 函数职责分组表/v3 修订说明对 4 个欧拉函数实现状态存在直接矛盾。§3.2 声明「本文件完整实现（8 个）」含 `eulerAngles`/`roll`/`pitch`/`yaw`（附注「虽然依赖 stub，本设计选择完整实现而非 stub 占位」），但 §3.15 已将这些函数归入「stub 占位」，且明确指出 v2 误标已修正 | §3.2 策略段落 / §1 核心抽象表 gtc/quaternion.cj 行 / §3.15 职责分组段首 | **已完整修复**：§3.2 策略段从「本文件完整实现（8 个）」修订为「本文件完整实现（4 个）」（仅含 4 个比较函数）+ 删除「虽然依赖 stub，本设计选择完整实现而非 stub 占位」过时附注 + 删除 4 个欧拉函数行；策略段重构为「完整实现（4 个）+ stub 占位（7 个）+ 从 detail 重导出（4 个）」，与 §3.15 完全一致。**本轮为第 9 次诊断此矛盾，彻底闭环** |
| 问题 2 | 严重 | `normalize(q)` 零保护分支 T(0) 获取路径与函数签名不可闭环——T(0) 原策略「通过 `one - one` 演算（需 `one: T` 形参显式传入）」在 `normalize` 签名 `normalize(q: Quat<T,Q>): Quat<T,Q>`（不含 `one: T` 形参）中不可用 | §1「系统性设计约束」段（T(0) 获取策略修订为 `T(Float64(0))` 字面量替代）+ §3.7 normalize 函数描述 + §5.1 通用异常表 + §5.3 边界条件表 | **已完整修复（采纳方案 B）**：T(0) 获取统一修订为 `T(Float64(0))` 字面量替代路径（与 `axis` 函数中 `Vec3(T(Float64(0)), T(Float64(0)), T(Float64(1)))` 模式一致）；§1「常量型 T(n) 字面量替代」v14 修订同时覆盖 T(0) 和 T(1)；v9 函数清单追加 `normalize` 函数并标注 T(0)/T(1) 字面量替代用途；`identity(one: T)` 等显式携带 `one: T` 形参的函数保留 `one - one` 演算路径 |
| 问题 3 | 严重 | §3.13 ortho 系族声称 9 个函数，但 GLM 1.0.3 实际包含 10 个（遗漏 `ortho(T left, T right, T bottom, T top, T zNear, T zFar)` 3D ortho 一般版本）；子类求和 11+9+9+9+9+7+2+6+1=63（非 64） | §3.13 函数清单表 ortho 系族行 / §10 覆盖矩阵 gtc/matrix_transform.hpp 表 / §8.3 验收项 C / §11.5 函数可用性对照表 | **已完整修复**：ortho 系族从 9 修订为 10（补充 3D ortho 一般版本带 zNear/zFar 参数）；合计行确认 11+10+9+9+9+7+2+6+1=**64**；§10/§8.3/§11.5 对应位置同步修订 ortho 子类数字 |
| 问题 4 | 严重 | §3.2.1 声明 `mat3Cast`/`mat4Cast` 内部「`Mat3x3(T(Float64(1)))` 初始化对角线」暗示使用单参数构造函数，与逐元素填充模式路径不一致 | §3.2.1「T(1)/T(0) 字面量获取与矩阵初始化策略」段 / §1 受 T 字面量获取策略影响的函数清单 | **已完整修复（采纳方案 B：逐元素填充）**：明确选择逐元素填充模式，不依赖 Mat3x3/Mat4x4 单参数构造函数；实现模板为 `Result[0][0] = T(Float64(1)); Result[1][1] = T(Float64(1)); Result[2][2] = T(Float64(1)); 其余 = T(Float64(0))`；非对角线 T(0) 采用 `T(Float64(0))` 字面量替代（与问题 2 一致）；删除「`Mat3x3(T(Float64(1)))` 初始化对角线」歧义表述 |
| 问题 5 | 一般 | §1 v9 函数清单未包含 `normalize` 零保护分支中对 T(0) 的字面量替代场景（仅在问题 2 采纳方案 B 时成立） | §1「常量型 T(n) 字面量替代」v14 函数清单 | **已完整修复**（随问题 2 方案 B 采纳而成立）：§1 v14 函数清单追加 `normalize` 函数并标注 T(0)/T(1) 字面量替代用途；§1 策略描述扩展覆盖 T(0) 场景，明确 `T(Float64(0))` 在 `T = Float32/Float64/Int8~Int64` 下的编译可行性 |
| 问题 6 | 一般 | §3.15 完整实现函数段将 4 个比较函数的 `where` 约束声明为 `T <: Comparable<T>`，与 §3.2.1 D32/§3.11 D29/§3.12 D25 已统一的 `where T <: FloatingPoint<T>` 存在表面矛盾，未说明理由 | §7 设计决策表（新增 D33）/ §3.15 完整实现函数段旁注 | **已完整修复**：§7 新增 D33 设计决策条目，明确比较函数采用 `Comparable<T>` 宽约束的理由：(a) GLM 原始实现中 4 个比较函数无 `is_iec559` 断言，整数类型也可合法调用；(b) 比较运算符对整数类型语义正确，收紧至 `FloatingPoint<T>` 会排除合法用例；(c) 与需浮点运算的 `mat3Cast`/`quatCast` 场景区分 |
| 问题 7 | 一般 | §3.13.2 审计表未纳入 `gtc/matrix_transform.cj` 64 个函数，审计结论中 stub 数量 14 与实际 78 严重不符 | §3.13.2 审计表（新增 `gtc/matrix_transform` 聚合行）/ §3.13.2 审计结论 / §8.3 验收项 C | **已完整修复**：§3.13.2 审计表新增 `gtc/matrix_transform` 全部 64 个函数聚合行；审计结论 stub 数量从 14 修订为 **78**（14 + 64 gtc/matrix_transform）；§8.3 验收项 C stub 数量从约 50 同步修订为约 78 |
| 问题 8 | 一般 | §8.2 测试文件清单中 `test_ext_scalar_constants.cj` 预计用例数 ≥6，但 3 个泛型函数 × 2 种浮点类型 = 6 正常路径 + 1 整数类型异常路径 = 至少 7 个 | §8.2 测试文件清单与位置表 | **已完整修复**：`test_ext_scalar_constants.cj` 预计用例数从 ≥6 修订为 ≥7；§8.2 合计从 ≥184 修订为 ≥185（增量 1） |
| 质询 A | 质询 | 问题 4 方案 B 需补充非对角线元素赋值策略（依赖零初始化默认值或显式赋 `T(Float64(0))`） | §3.2.1 逐元素填充模式描述 | **已响应**：§3.2.1 逐元素填充模式明确非对角线元素显式赋 `T(Float64(0))`，不依赖 Mat3x3/Mat4x4 零初始化默认值——「显式逐元素赋值确保跨类型一致性」 |
| 质询 B | 质询 | 补充核查记录确认 v13 中 `FloatingPoint<T>` 接口方法引用与 stdlib 定义一致，或标注「未纳入本轮审查范围」 | §8 编码启动前验证项 20 | **已响应**：验证项 20 末尾新增「v14 质询报告核查声明」——v13 中 `FloatingPoint<T>` 接口方法引用未纳入本轮 v14 审查范围的独立复核，下游编码者应以仓颉编译器实际签名确认 |

### v14 修订特点

1. **§3.2/§3.15 矛盾彻底闭环**：欧拉函数实现状态矛盾自 v2 以来经 9 次诊断仍未修正（§3.2 策略段一直声称「完整实现」含欧拉函数），本轮**彻底修正**——§3.2 策略段从「完整实现（8 个）」修订为「完整实现（4 个）+ stub 占位（7 个）+ 从 detail 重导出（4 个）」，与 §3.15 完全一致。

2. **T(0) 获取策略统一闭环**：`normalize` 零保护分支 T(0) 获取路径与签名不可闭环的问题（v11 补强了零保护分支存在性但未闭环 T(0) 获取路径），本轮采纳方案 B 统一修订为 `T(Float64(0))` 字面量替代路径。§1 系统性约束同步扩展覆盖 T(0)——`T(Float64(0))` 在 `T = Float32/Float64/Int8~Int64` 下均编译可行，与 `axis`/`mat3Cast`/`mat4Cast` 中 T(0) 的使用模式一致，形成 §1 统一策略闭环。

3. **mat3Cast/mat4Cast 初始化路径歧义消除**：两种初始化路径（单参数构造 vs 逐元素填充）自 v4 以来多次诊断未闭环，本轮明确选择逐元素填充模式——非对角线元素 T(0) 显式赋 `T(Float64(0))` 不依赖零初始化默认值，消除歧义。

4. **ortho 系族完整性修正**：v13 函数清单 64 个函数按子类求和实际为 63（ortho 系族 9→10），本轮补充 3D ortho 一般版本，求和确认 64。

5. **审计表完整性闭环**：§3.13.2 审计表新增 gtc/matrix_transform 64 个函数聚合行，stub 数量从 14 修订为 78。

6. **比较函数约束决策明确**：新增 D33 设计决策条目，明确比较函数采用 `Comparable<T>` 宽约束的 3 条理由——消除与 `FloatingPoint<T>` 统一策略的表面矛盾。

### 不引入新设计变更

v14 修订严格限定在 8 项审查意见 + 2 项质询建议的逐项落实范围内，不修改任何函数行为、类型形态选择、依赖方向、文件归属、命名规范原则等设计要素。前序 v2-v13 修订的累计审查意见落实情况保持不变。

### v9 迭代历史累计状态

经过 v1（v2 设计）→ ... → v12（v13 设计）→ v13（v14 设计，本轮）共 13 轮设计修订：

- **v1 → v2 设计**：新增 14 项审查意见 → 落实 13 项
- **v2 → v3 设计**：补齐 v1 遗留 1 项 + 新增 2 项严重问题 → 全部修复
- **v3 → v4 设计**：新增 2 项 → 全部修复
- **v4 → v5 设计**：新增 14 项 → 全部修复
- **v5 → v6 设计**：核实 v5 落实情况 + 3 处表述细节澄清
- **v6 → v7 设计**：新增 5 项 → 全部修复
- **v7 → v8 设计**：新增 11 项 → 全部修复
- **v8 → v9 设计**：新增 7 项（实修 6 项）→ 全部修复
- **v9 → v10 设计**：新增 17 项 → 全部修复
- **v10 → v11 设计**：新增 13 项 + 4 项质询 → 全部修复/响应
- **v11 → v12 设计**：新增 14 项 + 5 项质询 → 全部修复/响应
- **v12 → v13 设计**：新增 9 项 + 1 项核查记录 + 3 项质询 → 全部修复/响应
- **v13 → v14 设计（本轮）**：新增 8 项（4 严重 + 4 一般）+ 2 项质询建议 → 全部修复/响应

v14 迭代整体完成，可进入下游验证环节。
