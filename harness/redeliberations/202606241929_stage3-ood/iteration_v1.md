# 再审议判定报告（v1）

## 判定结果

RETRY

## 判定理由

组件B诊断报告（`b_v1_diag_v1.md`）共识别 19 个质量问题，其中 **3 项严重**、**10 项一般**、**6 项轻微**。组件B质询报告（`b_v1_challenge_v1.md`）对诊断报告的证据充分性、逻辑完整性、覆盖完备性、报告必要性四个维度进行了审查，结论为 **LOCATED**（质询通过），并确认诊断报告所列严重级与一般级问题真实存在、设计作者可据此开展修订。

质询过程中识别的轻微问题（如问题间交叉覆盖、二级核验深度、报告必要性边界判断等）均属于"v1 报告可继续优化"层面的反馈，**不构成驳回理由**。当前 v1 报告已达到"产出作者可据此改进"的质量门槛。

本次组件B内部循环实际轮次为 1（< 最大轮次 12），诊断报告产出已 LOCATED，可直接驱动组件A重新运行以修订设计文档。

依据判定标准——审查报告包含严重或一般等级的问题——判定为 **RETRY**。组件A 需基于诊断报告的严重级（3 项）与一般级（10 项）问题开展设计文档 v3 修订，轻微级问题可纳入后续实施阶段逐步落实。

## 需要解决的问题（仅 RETRY 时存在）

- **问题描述**：设计文档在 §2 包组织（行 82-85）、§3.2 协作关系表与策略段落（行 167-170、行 175-178）、§8 产出物清单、§10 覆盖矩阵等多处反复引用 `gtc/quaternion.cj` 作为承载 `mat3_cast`/`mat4_cast`/`quat_cast`/`eulerAngles`/`roll`/`pitch`/`yaw`/`lessThan*`/`greaterThan*`/`quatLookAt*` 等 17 个函数的核心载体，但 §2 包组织图未列出该文件、§8 产出物清单也未将其归入任何状态分类。修复者无法确定该文件的目录归属、包名声明、与 `type_quat.cj` 的函数归属边界等关键决策。
- **所在位置**：§2 包组织（行 82-85）、§3.2 协作关系表与策略段落、§8 产出物清单、§10 覆盖矩阵
- **严重程度**：严重
- **改进建议**：在 §2 `glm.gtc` 包组织下补充 `quaternion.cj ★` 条目并明确状态（如「混合型：5 完整实现 + 9 比较函数 + 3 stub」）；在 §3.2 策略段落明确 `gtc/quaternion.cj` 的归属决策（独立文件 vs 合并到 `type_quat.cj`）并消除与策略段表述的矛盾；在 §8 产出物清单中按「完整实现」「大部分实现」「空桩占位」三类补充 `gtc/quaternion.cj` 的明确分类；在 §2 模块间依赖图的 `glm.gtc` 块下补充该文件对 `glm.detail`/`glm.ext.scalar_constants`/`glm.ext.vector_relational`/`glm.detail.common(stub)`/`glm.detail.trigonometric(stub)` 的依赖方向。

- **问题描述**：§3.4 运算符体系表第 216 行将 `Quat×Vec3` 旋转运算符的实现公式标注为 `v + 2.0 * cross(cross(QuatVector, v) + QuatVector * q.w, v)`，但 GLM 1.0.3 `glm/glm/detail/type_quat.inl:359-366` 的实际实现公式为 `v + (cross(QuatVector, v) * q.w + cross(QuatVector, cross(QuatVector, v))) * 2`（两次 Vec3 叉乘 `uv`/`uuv` 组成）。设计公式只包含一次叉乘且第二次叉乘的左操作数错误地写成 `QuatVector`，两个公式数学上不等价。直接照搬设计公式实现会产生错误的旋转结果。此外，公式中 `cross` 是 Vec3 叉乘，但 §3.7 将 `cross` 描述为四元数 Hamilton 乘积函数，存在概念混用。
- **所在位置**：§3.4 运算符体系表第 216 行
- **严重程度**：严重
- **改进建议**：将公式修正为 `v + (cross(QuatVector, v) * q.w + cross(QuatVector, cross(QuatVector, v))) * 2`（两次 Vec3 叉乘，调用 `geometric.cj stub` 的向量 `cross`）；在公式旁明确 `cross` 调用的是 Vec3 叉乘（参数为 `Vec3<T,Q>`）而非四元数 `cross`，避免与 §3.7 的四元数 `cross` 概念混淆；在 §3.4 表格备注列明确 `cross(QuatVector, v)` 依赖 `geometric.cj` 的向量 `cross`（当前为 stub），因此 `Quat×Vec3` 旋转运算符在阶段三可能也需 stub 占位或采用替代实现策略。

- **问题描述**：§3.2 协作关系表行 167-170 标注 `mat3_cast`/`mat4_cast`/`quat_cast` 归入「gtc/quaternion.cj（随 type_quat.cj 编码）」，但策略段落标注「**随 type_quat.cj 一同实现**：`mat3_cast`/`mat4_cast`/`quat_cast`」。两处表述在文件归属上不一致：表行说「gtc/quaternion.cj」，策略段说「type_quat.cj」。加上 §2 包组织未包含 `gtc/quaternion.cj`，三处描述自相矛盾，修复者无法确定这 3 个函数应定义在哪个文件的哪个包名下。
- **所在位置**：§3.2 协作关系表行 167-170 与 §3.2 策略段落
- **严重程度**：严重
- **改进建议**：明确决策——`mat3_cast`/`mat4_cast`/`quat_cast` 三个函数是定义在 `glm.detail.type_quat`（包级函数）还是 `glm.gtc.quaternion`（包级函数）；同步修订 §3.2 表行与策略段落、§2 包组织图、§8 产出物清单的相应位置；在 D11 设计决策中补充文件归属决策的完整理由（含跨包依赖权衡）。

- **问题描述**：§8 完整实现清单末尾提及「四元数测试文件」一行但未展开。设计文档未对测试文件做以下规划：测试文件数量与位置、至少需覆盖的测试维度（构造/运算符/各 ext 函数库正常路径、stub 函数异常路径、跨 Qualifier 实例化覆盖）、测试用例数与覆盖目标、阶段三可验证 vs 待阶段四验证的测试拆分策略、浮点比较策略、跨类型/跨 Qualifier 测试的覆盖深度。路线图 02_roadmap.md §3 第 123-133 行明确列出本阶段验证标准，但 OOD 文档未给出对应的测试设计与覆盖策略。
- **所在位置**：§8 完整实现清单第 510 行
- **严重程度**：一般
- **改进建议**：在 §8 末尾或新增 §8.2「测试设计」章节补充测试文件清单、覆盖维度、可验证/待阶段四拆分策略、跨类型覆盖范围、至少用例数目标。确保测试文件结构与路线图验证标准一一对应。

- **问题描述**：§2 模块间依赖图（行 116-119）中，`glm.gtc` 块只列出 `constants.cj` 和 `matrix_transform.cj` 的依赖关系，缺少 `gtc/quaternion.cj` 的依赖方向说明。从 §3.2 的描述推断，`gtc/quaternion.cj` 应依赖 `glm.detail`（`Quat`/`Mat3x3`/`Mat4x4`）、`glm.ext.scalar_constants`（`epsilon<T>()`）、`glm.ext.vector_relational`（`equal`）、`glm.detail.common(stub)`/`trigonometric(stub)`（`atan`/`asin`），但这些依赖关系在 §2 依赖图中未呈现。
- **所在位置**：§2 模块间依赖图（行 116-119）
- **严重程度**：一般
- **改进建议**：在 §2 依赖图的 `glm.gtc` 块下补充 `quaternion.cj → glm.detail(Quat, Mat3x3, Mat4x4), glm.ext.scalar_constants, glm.ext.vector_relational, glm.detail.common(stub), glm.detail.trigonometric(stub)` 等依赖关系。

- **问题描述**：§3.2 策略段落标注「**随 gtc/quaternion.cj 实现**：`eulerAngles`/`roll`/`pitch`/`yaw`/`lessThan*`/`greaterThan*`」，但紧接其后说明「roll/pitch/yaw 依赖 common.cj 和 trigonometric.cj 均为 stub」，表明这些函数依赖未就绪的 stub——若依赖未就绪，本阶段无法完整实现。对比 §10 覆盖矩阵将 `eulerAngles`/`roll`/`pitch`/`yaw` 标注为「本阶段 stub（依赖 common.cj/trigonometric.cj stub）」，与 §3.2 策略段落直接矛盾。
- **所在位置**：§3.2 策略段落最后一项
- **严重程度**：一般
- **改进建议**：将 §3.2 策略段落改为「**stub 占位（归入 gtc/quaternion.cj）**：`eulerAngles`/`roll`/`pitch`/`yaw`（依赖 trigonometric.cj 的 atan/asin 和 common.cj 的 clamp），随 gtc/quaternion.cj 完整实现的：`lessThan*`/`greaterThan*`（不依赖 stub）」；同步修订 §3.2 协作关系表行 168-170 的实现状态标注，与策略段落和 §10 覆盖矩阵对齐。

- **问题描述**：§3.10 第 339 行将 `pow(x: Quat<T,Q>, y: T)` 的依赖标注为「`sqrt`/`acos`/`asin`/`sin`/`pow` 和 `epsilon<T>()`」。实际 GLM `pow` 实现（`ext/quaternion_exponential.inl:24-43`）依赖 `abs`（来自 `common.cj`）、`clamp`（来自 `common.cj`）、`acos`（来自 `trigonometric.cj`）、`sin`/`cos`（来自 `trigonometric.cj`）、`sqrt`（来自 `std.math`，仓颉标准库）、`epsilon<T>()`（来自 `scalar_constants.cj`）。设计文档错误地列出了 `asin`（实际 GLM pow 不用 `asin`）和 `pow`（递归引用自身，意义不明），同时遗漏了 `abs`/`clamp`/`cos` 三个关键依赖。
- **所在位置**：§3.10 第 339 行
- **严重程度**：一般
- **改进建议**：将 §3.10 第 339 行修正为「依赖 `abs`/`clamp`/`acos`/`sin`/`cos`/`sqrt` 和 `epsilon<T>()`」，与 GLM 实际依赖对齐。

- **问题描述**：§3.11 第 354 行将 `mix(x, y, a): Quat<T,Q>` 的依赖标注为「依赖 `dot`、`acos`、`sin`. **stub 占位**」。实际 GLM `mix` 实现（`ext/quaternion_common.inl:4-26`）的关键依赖是 `epsilon<T>()`，用于 `cosTheta > 1 - epsilon<T>()` 的退化检测分支。设计文档遗漏 `epsilon<T>()` 依赖。§3.11 `slerp` 描述（第 353 行）的依赖中虽已提到 `acos`/`sin`/`mix`，但同样遗漏了 `epsilon<T>()`。
- **所在位置**：§3.11 第 353-354 行
- **严重程度**：一般
- **改进建议**：将 §3.11 第 354 行修订为「依赖 `dot`、`acos`、`sin`、`epsilon<T>()`。**stub 占位**」；§3.11 `slerp` 描述同步修订为「依赖 `dot`、`acos`/`sin`/`mix`（标量版）和 `epsilon<T>()`」。

- **问题描述**：§3.11 第 355 行将 `slerp(x, y, a, k)` 标注为「多旋转 slerp。**stub 占位**」，但未指定 `k` 参数的类型。GLM 1.0.3 4-arg `slerp` 签名为 `slerp<T, S, Q>(x, y, a, k)`，其中 `S` 是独立于 `T` 的整型类型。设计文档对 `k` 类型未做决策（选项：`k: Int64` / `k: T` / 泛型 `K` + 约束 `K <: Integer<K>`）。
- **所在位置**：§3.11 第 355 行
- **严重程度**：一般
- **改进建议**：在 §3.11 第 355 行明确 `slerp(x, y, a, k)` 签名为 `slerp<T, K, Q>(x, y, a, k: K) where K <: Integer<K>`（与 GLM 风格一致）或 `slerp<T, Q>(x, y, a, k: Int64)`（简化版），并说明 `k` 类型的选定理由。

- **问题描述**：§3.4 运算符体系表中 `Quat×Vec3` 和 `Quat×Vec4` 行的「备注」列为空，但这两个运算符的实际实现依赖几何函数库：`Quat×Vec3` 依赖向量 `cross`（`geometric.cj` 中为 stub），`Quat×Vec4` 通过 `Vec3×Quat` 中间路径间接依赖 `Quat×Vec3`。设计文档将这两个运算符与同表基本算术运算符并列展示并要求标注 `@OverflowWrapping`，但未说明依赖 `geometric.cj stub`——意味着 `Quat×Vec3`/`Quat×Vec4` 运算符在阶段三不可调用，但设计文档将其与基本算术运算符同等对待，编码阶段可能误判为可立即使用的核心功能。
- **所在位置**：§3.4 运算符体系表第 216-217 行
- **严重程度**：一般
- **改进建议**：在 §3.4 运算符体系表的 `Quat×Vec3`/`Quat×Vec4` 行「备注」列添加「依赖 `geometric.cj` 向量 `cross`（阶段三 stub），本阶段实现后调用将抛 `Exception("stub")`」说明；在 §8 产出物清单的「完整实现」中明确「`Quat×Vec3`/`Quat×Vec4` 运算符本阶段实现，但运行时因 `geometric.cj stub` 不可用而抛异常，待阶段四 `geometric.cj` 完整实现后生效」；§4.2 行为契约示例也应标注「本阶段调用将抛异常，待阶段四」。

- **问题描述**：§3.7 已注意到四元数 `cross`（Hamilton 乘积）与 `Vec3` `cross`（向量叉乘）的命名歧义，但 §3.4 第 216 行的 `Quat×Vec3` 旋转公式中使用了 `cross(...)` 函数，未明确该 `cross` 调用的是 `Vec3` 叉乘而非四元数 `cross`。下游消费者看到 `cross(QuatVector, v)` 这样的调用时，必须查阅上下文才能判断是哪种 `cross`。
- **所在位置**：§3.4 第 216 行、§3.7 第 299-301 行
- **严重程度**：一般
- **改进建议**：在 §3.4 第 216 行公式旁添加命名约定说明，例如：「注：此处的 `cross` 为 `Vec3` 叉乘（定义于 `geometric.cj`），非 §3.7 中的四元数 `cross`（Hamilton 乘积）。」同时在 §3.7 命名歧义说明段落中补充「`Quat×Vec3` 旋转公式内部调用 `Vec3` 叉乘，与四元数 `cross` 不冲突」的反向说明。

- **问题描述**：§5 错误处理策略列出 5 条异常/边界行为（下标越界、normalize 零四元数、stub 抛异常、inverse 零四元数除零、标量/四元数 `div` 语义），但未覆盖以下边界条件：(1) `axis(q)` 在 q 接近零四元数时 `normalize(Vec3(q.x, q.y, q.z))` 返回单位 Vec3 的行为；(2) `conjugate(q)` 与 `inverse(q)` 对整数四元数的支持（整数除零抛 ArithmeticException 而非 Inf/NaN）；(3) `inverse(q)` 零四元数时整数与浮点行为的差异；(4) `mix`/`slerp` 在 `cosTheta == 0` 时的退化行为；(5) `fromMat3`/`fromMat4` 对非纯旋转矩阵的输入行为。
- **所在位置**：§5 错误处理策略
- **严重程度**：一般
- **改进建议**：在 §5 新增「边界条件与异常场景」小节，逐项列出上述 5 类边界条件的行为契约；在 §3.9 `axis` 函数描述中补充「零四元数输入时返回 `Vec3(1, 0, 0)`（沿用 `normalize` 零向量行为）」说明；在 §3.11 `inverse` 描述中补充「整数四元数 `inverse` 在 `dot(q, q) == 0` 时触发仓颉整数除零异常（与浮点 Inf/NaN 行为不同）」说明；在 §3.3 `fromMat3`/`fromMat4` 工厂函数描述中补充「仅对纯旋转矩阵产生有意义的四元数；对非旋转矩阵（如含缩放/平移/剪切）行为未定义」契约声明。

- **问题描述**：§3.12 第 367-371 行将 `epsilon<T>()` 描述为「`func epsilon<T>(): T where T <: Number<T>`」，但 `Number<T>` 约束下 T 还可以是 `Int8`~`Int64`/`UInt8`~`UInt64` 等整数类型。设计文档对整数类型 T 的 `epsilon<T>()` 返回值未定义——既无 `match` fallback 分支也无更窄的约束。GLM 1.0.3 `scalar_constants.inl:36-43` 使用 `static_assert(std::numeric_limits<genType>::is_iec559, ...)` 静态断言非浮点类型时编译失败。类似地，`pi<T>()`/`cos_one_over_two<T>()` 对整数类型的返回值也未定义。
- **所在位置**：§3.12 第 367-371 行
- **严重程度**：一般
- **改进建议**：在 §3.12 第 367-371 行将 `epsilon<T>()`/`pi<T>()`/`cos_one_over_two<T>()` 的约束从 `T <: Number<T>` 收紧为 `T <: Float32 | Float64` 或 `T <: FloatingPointNumber<T>`（若仓颉支持）；若保持 `T <: Number<T>` 宽约束，在 `match` 中增加 `case _ => throw Exception("epsilon/pi/cos_one_over_two not defined for non-floating-point types")` 显式错误分支；在 §3.12 段落末尾或 §5 错误处理策略中明确这些函数对非浮点类型的契约。