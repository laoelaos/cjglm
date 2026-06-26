## 迭代第 1 轮

1. **问题描述**：设计文档在 §2 包组织（行 82-85）、§3.2 协作关系表与策略段落（行 167-170、行 175-178）、§8 产出物清单、§10 覆盖矩阵等多处反复引用 `gtc/quaternion.cj` 作为承载 `mat3_cast`/`mat4_cast`/`quat_cast`/`eulerAngles`/`roll`/`pitch`/`yaw`/`lessThan*`/`greaterThan*`/`quatLookAt*` 等 17 个函数的核心载体，但 §2 包组织图未列出该文件、§8 产出物清单也未将其归入任何状态分类。修复者无法确定该文件的目录归属、包名声明、与 `type_quat.cj` 的函数归属边界等关键决策。
   - 所在位置：§2 包组织（行 82-85）、§3.2 协作关系表与策略段落、§8 产出物清单、§10 覆盖矩阵
   - 严重程度：严重
   - 改进建议：在 §2 `glm.gtc` 包组织下补充 `quaternion.cj ★` 条目并明确状态（如「混合型：5 完整实现 + 9 比较函数 + 3 stub」）；在 §3.2 策略段落明确 `gtc/quaternion.cj` 的归属决策（独立文件 vs 合并到 `type_quat.cj`）并消除与策略段表述的矛盾；在 §8 产出物清单中按「完整实现」「大部分实现」「空桩占位」三类补充 `gtc/quaternion.cj` 的明确分类；在 §2 模块间依赖图的 `glm.gtc` 块下补充该文件对 `glm.detail`/`glm.ext.scalar_constants`/`glm.ext.vector_relational`/`glm.detail.common(stub)`/`glm.detail.trigonometric(stub)` 的依赖方向。
2. **问题描述**：§3.4 运算符体系表第 216 行将 `Quat×Vec3` 旋转运算符的实现公式标注为 `v + 2.0 * cross(cross(QuatVector, v) + QuatVector * q.w, v)`，但 GLM 1.0.3 `glm/glm/detail/type_quat.inl:359-366` 的实际实现公式为 `v + (cross(QuatVector, v) * q.w + cross(QuatVector, cross(QuatVector, v))) * 2`（两次 Vec3 叉乘 `uv`/`uuv` 组成）。设计公式只包含一次叉乘且第二次叉乘的左操作数错误地写成 `QuatVector`，两个公式数学上不等价。直接照搬设计公式实现会产生错误的旋转结果。此外，公式中 `cross` 是 Vec3 叉乘，但 §3.7 将 `cross` 描述为四元数 Hamilton 乘积函数，存在概念混用。
   - 所在位置：§3.4 运算符体系表第 216 行
   - 严重程度：严重
   - 改进建议：将公式修正为 `v + (cross(QuatVector, v) * q.w + cross(QuatVector, cross(QuatVector, v))) * 2`（两次 Vec3 叉乘，调用 `geometric.cj stub` 的向量 `cross`）；在公式旁明确 `cross` 调用的是 Vec3 叉乘（参数为 `Vec3<T,Q>`）而非四元数 `cross`，避免与 §3.7 的四元数 `cross` 概念混淆；在 §3.4 表格备注列明确 `cross(QuatVector, v)` 依赖 `geometric.cj` 的向量 `cross`（当前为 stub），因此 `Quat×Vec3` 旋转运算符在阶段三可能也需 stub 占位或采用替代实现策略。
3. **问题描述**：§3.2 协作关系表行 167-170 标注 `mat3_cast`/`mat4_cast`/`quat_cast` 归入「gtc/quaternion.cj（随 type_quat.cj 编码）」，但策略段落标注「**随 type_quat.cj 一同实现**：`mat3_cast`/`mat4_cast`/`quat_cast`」。两处表述在文件归属上不一致：表行说「gtc/quaternion.cj」，策略段说「type_quat.cj」。加上 §2 包组织未包含 `gtc/quaternion.cj`，三处描述自相矛盾，修复者无法确定这 3 个函数应定义在哪个文件的哪个包名下。
   - 所在位置：§3.2 协作关系表行 167-170 与 §3.2 策略段落
   - 严重程度：严重
   - 改进建议：明确决策——`mat3_cast`/`mat4_cast`/`quat_cast` 三个函数是定义在 `glm.detail.type_quat`（包级函数）还是 `glm.gtc.quaternion`（包级函数）；同步修订 §3.2 表行与策略段落、§2 包组织图、§8 产出物清单的相应位置；在 D11 设计决策中补充文件归属决策的完整理由（含跨包依赖权衡）。
4. **问题描述**：§8 完整实现清单末尾提及「四元数测试文件」一行但未展开。设计文档未对测试文件做以下规划：测试文件数量与位置、至少需覆盖的测试维度（构造/运算符/各 ext 函数库正常路径、stub 函数异常路径、跨 Qualifier 实例化覆盖）、测试用例数与覆盖目标、阶段三可验证 vs 待阶段四验证的测试拆分策略、浮点比较策略、跨类型/跨 Qualifier 测试的覆盖深度。路线图 02_roadmap.md §3 第 123-133 行明确列出本阶段验证标准，但 OOD 文档未给出对应的测试设计与覆盖策略。
   - 所在位置：§8 完整实现清单第 510 行
   - 严重程度：一般
   - 改进建议：在 §8 末尾或新增 §8.2「测试设计」章节补充测试文件清单、覆盖维度、可验证/待阶段四拆分策略、跨类型覆盖范围、至少用例数目标。确保测试文件结构与路线图验证标准一一对应。
5. **问题描述**：§2 模块间依赖图（行 116-119）中，`glm.gtc` 块只列出 `constants.cj` 和 `matrix_transform.cj` 的依赖关系，缺少 `gtc/quaternion.cj` 的依赖方向说明。从 §3.2 的描述推断，`gtc/quaternion.cj` 应依赖 `glm.detail`（`Quat`/`Mat3x3`/`Mat4x4`）、`glm.ext.scalar_constants`（`epsilon<T>()`）、`glm.ext.vector_relational`（`equal`）、`glm.detail.common(stub)`/`trigonometric(stub)`（`atan`/`asin`），但这些依赖关系在 §2 依赖图中未呈现。
   - 所在位置：§2 模块间依赖图（行 116-119）
   - 严重程度：一般
   - 改进建议：在 §2 依赖图的 `glm.gtc` 块下补充 `quaternion.cj → glm.detail(Quat, Mat3x3, Mat4x4), glm.ext.scalar_constants, glm.ext.vector_relational, glm.detail.common(stub), glm.detail.trigonometric(stub)` 等依赖关系。
6. **问题描述**：§3.2 策略段落标注「**随 gtc/quaternion.cj 实现**：`eulerAngles`/`roll`/`pitch`/`yaw`/`lessThan*`/`greaterThan*`」，但紧接其后说明「roll/pitch/yaw 依赖 common.cj 和 trigonometric.cj 均为 stub」，表明这些函数依赖未就绪的 stub——若依赖未就绪，本阶段无法完整实现。对比 §10 覆盖矩阵将 `eulerAngles`/`roll`/`pitch`/`yaw` 标注为「本阶段 stub（依赖 common.cj/trigonometric.cj stub）」，与 §3.2 策略段落直接矛盾。
   - 所在位置：§3.2 策略段落最后一项
   - 严重程度：一般
   - 改进建议：将 §3.2 策略段落改为「**stub 占位（归入 gtc/quaternion.cj）**：`eulerAngles`/`roll`/`pitch`/`yaw`（依赖 trigonometric.cj 的 atan/asin 和 common.cj 的 clamp），随 gtc/quaternion.cj 完整实现的：`lessThan*`/`greaterThan*`（不依赖 stub）」；同步修订 §3.2 协作关系表行 168-170 的实现状态标注，与策略段落和 §10 覆盖矩阵对齐。
7. **问题描述**：§3.10 第 339 行将 `pow(x: Quat<T,Q>, y: T)` 的依赖标注为「`sqrt`/`acos`/`asin`/`sin`/`pow` 和 `epsilon<T>()`」。实际 GLM `pow` 实现（`ext/quaternion_exponential.inl:24-43`）依赖 `abs`（来自 `common.cj`）、`clamp`（来自 `common.cj`）、`acos`（来自 `trigonometric.cj`）、`sin`/`cos`（来自 `trigonometric.cj`）、`sqrt`（来自 `std.math`，仓颉标准库）、`epsilon<T>()`（来自 `scalar_constants.cj`）。设计文档错误地列出了 `asin`（实际 GLM pow 不用 `asin`）和 `pow`（递归引用自身，意义不明），同时遗漏了 `abs`/`clamp`/`cos` 三个关键依赖。
   - 所在位置：§3.10 第 339 行
   - 严重程度：一般
   - 改进建议：将 §3.10 第 339 行修正为「依赖 `abs`/`clamp`/`acos`/`sin`/`cos`/`sqrt` 和 `epsilon<T>()`」，与 GLM 实际依赖对齐。
8. **问题描述**：§3.11 第 354 行将 `mix(x, y, a): Quat<T,Q>` 的依赖标注为「依赖 `dot`、`acos`、`sin`. **stub 占位**」。实际 GLM `mix` 实现（`ext/quaternion_common.inl:4-26`）的关键依赖是 `epsilon<T>()`，用于 `cosTheta > 1 - epsilon<T>()` 的退化检测分支。设计文档遗漏 `epsilon<T>()` 依赖。§3.11 `slerp` 描述（第 353 行）的依赖中虽已提到 `acos`/`sin`/`mix`，但同样遗漏了 `epsilon<T>()`。
   - 所在位置：§3.11 第 353-354 行
   - 严重程度：一般
   - 改进建议：将 §3.11 第 354 行修订为「依赖 `dot`、`acos`、`sin`、`epsilon<T>()`。**stub 占位**」；§3.11 `slerp` 描述同步修订为「依赖 `dot`、`acos`/`sin`/`mix`（标量版）和 `epsilon<T>()`」。
9. **问题描述**：§3.11 第 355 行将 `slerp(x, y, a, k)` 标注为「多旋转 slerp。**stub 占位**」，但未指定 `k` 参数的类型。GLM 1.0.3 4-arg `slerp` 签名为 `slerp<T, S, Q>(x, y, a, k)`，其中 `S` 是独立于 `T` 的整型类型。设计文档对 `k` 类型未做决策（选项：`k: Int64` / `k: T` / 泛型 `K` + 约束 `K <: Integer<K>`）。
   - 所在位置：§3.11 第 355 行
   - 严重程度：一般
   - 改进建议：在 §3.11 第 355 行明确 `slerp(x, y, a, k)` 签名为 `slerp<T, K, Q>(x, y, a, k: K) where K <: Integer<K>`（与 GLM 风格一致）或 `slerp<T, Q>(x, y, a, k: Int64)`（简化版），并说明 `k` 类型的选定理由。
10. **问题描述**：§3.4 运算符体系表中 `Quat×Vec3` 和 `Quat×Vec4` 行的「备注」列为空，但这两个运算符的实际实现依赖几何函数库：`Quat×Vec3` 依赖向量 `cross`（`geometric.cj` 中为 stub），`Quat×Vec4` 通过 `Vec3×Quat` 中间路径间接依赖 `Quat×Vec3`。设计文档将这两个运算符与同表基本算术运算符并列展示并要求标注 `@OverflowWrapping`，但未说明依赖 `geometric.cj stub`——意味着 `Quat×Vec3`/`Quat×Vec4` 运算符在阶段三不可调用，但设计文档将其与基本算术运算符同等对待，编码阶段可能误判为可立即使用的核心功能。
   - 所在位置：§3.4 运算符体系表第 216-217 行
   - 严重程度：一般
   - 改进建议：在 §3.4 运算符体系表的 `Quat×Vec3`/`Quat×Vec4` 行「备注」列添加「依赖 `geometric.cj` 向量 `cross`（阶段三 stub），本阶段实现后调用将抛 `Exception("stub")`」说明；在 §8 产出物清单的「完整实现」中明确「`Quat×Vec3`/`Quat×Vec4` 运算符本阶段实现，但运行时因 `geometric.cj stub` 不可用而抛异常，待阶段四 `geometric.cj` 完整实现后生效」；§4.2 行为契约示例也应标注「本阶段调用将抛异常，待阶段四」。
11. **问题描述**：§3.7 已注意到四元数 `cross`（Hamilton 乘积）与 `Vec3` `cross`（向量叉乘）的命名歧义，但 §3.4 第 216 行的 `Quat×Vec3` 旋转公式中使用了 `cross(...)` 函数，未明确该 `cross` 调用的是 `Vec3` 叉乘而非四元数 `cross`。下游消费者看到 `cross(QuatVector, v)` 这样的调用时，必须查阅上下文才能判断是哪种 `cross`。
   - 所在位置：§3.4 第 216 行、§3.7 第 299-301 行
   - 严重程度：一般
   - 改进建议：在 §3.4 第 216 行公式旁添加命名约定说明，例如：「注：此处的 `cross` 为 `Vec3` 叉乘（定义于 `geometric.cj`），非 §3.7 中的四元数 `cross`（Hamilton 乘积）。」同时在 §3.7 命名歧义说明段落中补充「`Quat×Vec3` 旋转公式内部调用 `Vec3` 叉乘，与四元数 `cross` 不冲突」的反向说明。
12. **问题描述**：§5 错误处理策略列出 5 条异常/边界行为（下标越界、normalize 零四元数、stub 抛异常、inverse 零四元数除零、标量/四元数 `div` 语义），但未覆盖以下边界条件：(1) `axis(q)` 在 q 接近零四元数时 `normalize(Vec3(q.x, q.y, q.z))` 返回单位 Vec3 的行为；(2) `conjugate(q)` 与 `inverse(q)` 对整数四元数的支持（整数除零抛 ArithmeticException 而非 Inf/NaN）；(3) `inverse(q)` 零四元数时整数与浮点行为的差异；(4) `mix`/`slerp` 在 `cosTheta == 0` 时的退化行为；(5) `fromMat3`/`fromMat4` 对非纯旋转矩阵的输入行为。
   - 所在位置：§5 错误处理策略
   - 严重程度：一般
   - 改进建议：在 §5 新增「边界条件与异常场景」小节，逐项列出上述 5 类边界条件的行为契约；在 §3.9 `axis` 函数描述中补充「零四元数输入时返回 `Vec3(1, 0, 0)`（沿用 `normalize` 零向量行为）」说明；在 §3.11 `inverse` 描述中补充「整数四元数 `inverse` 在 `dot(q, q) == 0` 时触发仓颉整数除零异常（与浮点 Inf/NaN 行为不同）」说明；在 §3.3 `fromMat3`/`fromMat4` 工厂函数描述中补充「仅对纯旋转矩阵产生有意义的四元数；对非旋转矩阵（如含缩放/平移/剪切）行为未定义」契约声明。
13. **问题描述**：§3.12 第 367-371 行将 `epsilon<T>()` 描述为「`func epsilon<T>(): T where T <: Number<T>`」，但 `Number<T>` 约束下 T 还可以是 `Int8`~`Int64`/`UInt8`~`UInt64` 等整数类型。设计文档对整数类型 T 的 `epsilon<T>()` 返回值未定义——既无 `match` fallback 分支也无更窄的约束。GLM 1.0.3 `scalar_constants.inl:36-43` 使用 `static_assert(std::numeric_limits<genType>::is_iec559, ...)` 静态断言非浮点类型时编译失败。类似地，`pi<T>()`/`cos_one_over_two<T>()` 对整数类型的返回值也未定义。
   - 所在位置：§3.12 第 367-371 行
   - 严重程度：一般
   - 改进建议：在 §3.12 第 367-371 行将 `epsilon<T>()`/`pi<T>()`/`cos_one_over_two<T>()` 的约束从 `T <: Number<T>` 收紧为 `T <: Float32 | Float64` 或 `T <: FloatingPointNumber<T>`（若仓颉支持）；若保持 `T <: Number<T>` 宽约束，在 `match` 中增加 `case _ => throw Exception("epsilon/pi/cos_one_over_two not defined for non-floating-point types")` 显式错误分支；在 §3.12 段落末尾或 §5 错误处理策略中明确这些函数对非浮点类型的契约。

## 迭代第 2 轮

1. **问题描述**：`axis()` 函数边界行为契约与 GLM 1.0.3 实际实现不符——v3 设计 §3.9 描述的实现策略、零四元数返回值、行号引用均存在错误，且与同段「可完整实现」声明自相矛盾
   - 所在位置：§3.9 `axis` 函数描述（第 399 行附近）、§5.3 边界条件表「`axis(q)` 零四元数」行、§9 差异声明「`axis` 零四元数返回 `Vec3(1, 0, 0)`」条目、§10 覆盖矩阵 `quaternion_trigonometric.hpp` 表 `axis` 行
   - 严重程度：严重
   - 改进建议：§3.9 修订为「`axis(x)` 计算 `tmp1 = 1 - x.w*x.w`；若 `tmp1 <= 0` 返回 `Vec3(0, 0, 1)`；否则 `tmp2 = 1 / sqrt(tmp1)`，返回 `Vec3(x.x*tmp2, x.y*tmp2, x.z*tmp2)`」；§5.3 / §9 / §10 对应行同步修订；删除「内部 `normalize(Vec3(0, 0, 0))`」虚构实现描述；统一为「依赖仅 `std.math.sqrt` 和 T(1) 演算（通过 `x.w*x.w` 取得），**可完整实现**」
2. **问题描述**：`pow` 函数依赖关系不完整（遗漏 `cos_one_over_two<T>()`、`asin`、递归 `std.math.pow(T,T)`、`std::numeric_limits<T>::min()` 等价物），且行号引用 `quaternion_exponential.inl:24-43` 错误
   - 所在位置：§3.10 `pow` 依赖描述、D21 设计决策、§10 覆盖矩阵 `quaternion_exponential.hpp` 表 `pow` 行
   - 严重程度：严重
   - 改进建议：§3.10 `pow` 依赖补充 `cos_one_over_two<T>()`、`asin`、递归 `std.math.pow` 与次正规数边界检查；行号修订为 `quaternion_exponential.inl:41-80`；D21 决策补充对应依赖；§8 编码启动前验证项新增「四元数 `pow` 与 `std.math.pow` 命名消歧验证」+「次正规数边界检查的仓颉等价物验证」
3. **问题描述**：`log` 函数依赖关系遗漏 `epsilon<T>()`、`pi<T>()` 与 `std::numeric_limits<T>::infinity()` 等价处理策略
   - 所在位置：§3.10 `log` 依赖描述、§10 覆盖矩阵 `quaternion_exponential.hpp` 表 `log` 行
   - 严重程度：一般
   - 改进建议：§3.10 `log` 依赖修订为「依赖 `length`/`epsilon<T>()`/`pi<T>()`/`atan`/`log`」；明确 `std::numeric_limits<T>::infinity()` 的仓颉等价处理策略（建议优先 `FloatingPointNumber<T>.getInf()`，fallback 为 `T(1)/T(0)` 显式构造）
4. **问题描述**：`exp` 函数依赖关系遗漏 `epsilon<T>()`
   - 所在位置：§3.10 `exp` 依赖描述、§10 覆盖矩阵 `quaternion_exponential.hpp` 表 `exp` 行
   - 严重程度：一般
   - 改进建议：§3.10 `exp` 依赖修订为「依赖 `length`/`epsilon<T>()`/`cos`/`sin`」
5. **问题描述**：`slerp` 4 参数版本依赖关系遗漏 `pi<T>()` 与 `mix`（标量版）
   - 所在位置：§3.11 `slerp` 4 参数版本描述、D22 设计决策
   - 严重程度：一般
   - 改进建议：§3.11 `slerp` 4 参数版本依赖补充「`pi<T>()`（来自 scalar_constants.cj，line 107）+ `mix`（标量版，line 98-101）」
6. **问题描述**：§3.9 `axis` 函数依赖描述自相矛盾——前半部声明「依赖 `sqrt` 和 T(1) 演算，可完整实现」，后半部引用「内部 `normalize(Vec3(0, 0, 0))`」依赖 `geometric.cj` 的向量 `normalize`（阶段三为 stub）
   - 所在位置：§3.9 `axis` 函数描述（第 399 行附近）
   - 严重程度：一般
   - 改进建议：在采纳问题 1 修复方案后统一为「实现公式 `tmp1 = 1 - x.w*x.w`，依赖仅 `std.math.sqrt` 和 T(1) 演算（通过 `x.w*x.w` 取得），**可完整实现**」；删除「内部 `normalize(Vec3(0, 0, 0))`」的错误描述
7. **问题描述**：路线图 `02_roadmap.md` 与 v3 设计在阶段三验证标准上存在三处不一致——`slerp` 可验证性冲突（路线图标 `[可验证]`，v3 设计标 stub）；`lookRotate` 命名未同步修正（路线图多处仍引用 `lookRotate`，v3 设计已修正为 `quatLookAt*`）；`ext/quaternion_common.cj` 可验证性范围过广（未排除 `mix`/`slerp`）
   - 所在位置：v3 设计 §3.11、§8、§10、§11.5；路线图 `docs/02_roadmap.md` 第 89、102、111、125、129、130、152、163、207 行
   - 严重程度：一般
   - 改进建议：v3 设计 §3.11 / §8 / §11.5 明确「slerp stub 是设计相对路线图的合理偏差」并新增「路线图同步修订建议」段落（第 125 行修订为 `[待 Stage 4，依赖 trigonometric.cj 完整实现]`）；§3.15 + §9 增补 `lookRotate` → `quatLookAt*` 同步修订建议（第 89/102/111/129/152/163/207 行）；路线图修订或 v3 设计新增「阶段三验证标准差异说明」附录，统一 `[可验证]`/`[部分可验证]`/`[待 Stage 4]` 三级分类与 ✅/⚠️/❌ 符号的双向映射表
8. **问题描述**：§3.15 `gtc/quaternion.cj` 表格欧拉角函数组行（507 行）单元格同时给出「**完整实现**（v3 修正）」与「**改为 stub 占位**（v3 最终决策）」两个相互矛盾的粗体标注
   - 所在位置：§3.15 `gtc/quaternion.cj` 表格欧拉角函数组行（第 507 行）
   - 严重程度：一般
   - 改进建议：表格单元格修订为「**stub 占位**（v3 最终决策，原误标为完整实现）」，删除中间冲突表述；或拆分为两行清晰展示决策历程
9. **问题描述**：`conjugate` 函数描述与 GLM 实际实现不一致——v3 设计描述为「仅涉及逐分量取反」，GLM `ext/quaternion_common.inl:112-116` 实际是 `wxyz(q.w, -q.x, -q.y, -q.z)`（w 不变，仅 x/y/z 取反）
   - 所在位置：§3.11 `conjugate` 函数描述
   - 严重程度：一般
   - 改进建议：§3.11 `conjugate` 描述修订为「**完整实现**」「仅对 x/y/z 三个分量取反，w 分量保持不变：`Quat(-q.x, -q.y, -q.z, q.w)`（与 GLM `ext/quaternion_common.inl:112-116` 一致）」
10. **问题描述**：`detail/type_quat_cast.cj` 中 `mat3Cast`/`mat4Cast`/`quatCast(Mat3)`/`quatCast(Mat4)` 4 个函数的具体签名（泛型参数、约束、返回类型）未定义
   - 所在位置：§3.2 协作关系表（行 215-218）、§3.15 跨包引用（行 540-541）、§10 覆盖矩阵 `glm/detail/type_quat_cast.hpp` 表
   - 严重程度：一般
   - 改进建议：新增 §3.2.1「type_quat_cast 函数签名规范」子节，给出 4 个函数的标准签名模板（建议 `where T <: FloatingPointNumber<T>, Q <: Qualifier` 约束）；明确 GLM `GLM_STATIC_ASSERT(std::numeric_limits<T>::is_iec559, ...)` 通过 `FloatingPointNumber<T>` 约束实现等价行为
11. **问题描述**：`lib.cj`/`fwd.cj` 具体更新内容未明确——v3 设计 §2 包组织仅描述「新增 public import」与「新增 type alias」，未列出具体清单
   - 所在位置：§2 包组织 glm 包块（行 86-88）、§8 更新文件段（行 734-737）
   - 严重程度：轻微
   - 改进建议：§2 包组织 glm 块下为 `lib.cj`/`fwd.cj` 增加「具体 import/alias 清单」段落，列出新增 6 个 import 与 8 个 type alias
12. **问题描述**：`pow` 函数递归调用 `pow` 的命名消歧未说明——四元数 `pow` 与实数 `std.math.pow` 未区分
   - 所在位置：§3.10 `pow` 描述、D21 设计决策
   - 严重程度：轻微
   - 改进建议：§3.10 `pow` 描述补充「递归调用 `std.math.pow(x.w, y)`（实数降级路径，T 为浮点类型时来自仓颉标准库；若不存在需以 `exp(y * ln(x.w))` 替代）」
13. **问题描述**：`mix` 函数依赖中 `acos`/`sin` 重载版本未明确——GLM 实际使用 `acos(cosTheta)` 与 `sin(...)` 单参数版本，v3 设计未明确 trigonometric.cj 需提供哪些重载
   - 所在位置：§3.11 `mix` 描述、§3.10 `mix`/`slerp`/`pow` 描述
   - 严重程度：轻微
   - 改进建议：§3.11 `mix` 描述修订为「依赖 `dot`/`acos(cosTheta)`（单参数版本）/`sin(...)`（单参数版本）/`epsilon<T>()`，其中 `epsilon<T>()` 用于 `cosTheta > 1 - epsilon<T>()` 退化分支」
14. **问题描述**：`@Derive[Hashable]` 派生所需 Qualifier Hashable 实现未充分核验——6 个 Qualifier 实现类型是否全部为标记类型且 Hashable 接口自动派生，实践依据未具体引用阶段二文件
   - 所在位置：§3.1 `@Derive[Hashable]` 约束核验段（行 203）、§8 编码启动前验证项 11（行 797）
   - 严重程度：轻微
   - 改进建议：§3.1 段落补充「实践依据」段落，引用阶段二 `type_mat2x2.cj` 等使用 `@Derive[Hashable]` 的具体文件与行号；§8 验证项 11 精简为「引用阶段二已验证实践，若阶段三新增 Qualifier 变体或数据结构变更则需重新验证」

## 迭代第 3 轮

1. **问题描述**：`gtc/constants` 函数数量自相矛盾——文字计数（25 个）与 §3.12 函数名清单（28 个）及 GLM 1.0.3 实际声明数（28 个）不一致，文字与清单相差 3 个。
   - 所在位置：§3.12 末段、§1 核心抽象表、§2 包组织、§7 D10、§8 产出物清单、§8.2 测试设计表、§10 覆盖矩阵等所有"25"出现位置
   - 严重程度：严重
   - 改进建议：将所有"25"修订为"28"（与 GLM 1.0.3 实际声明数一致），并核对 `gtc/constants_test.cj` 至少 28 个测试用例的覆盖目标。
2. **问题描述**：`axis` 函数 T(1) 获取方式描述与项目系统性约束矛盾——签名 `axis(x: Quat<T,Q>): Vec3<T,Q>` 无 `one: T` 参数，但实现公式需要 T(1) 两处，且 §1 明确"T(1) 必须由调用方显式传入参数"，设计给出的"`x.w*x.w` 演算"解释错误（x.w*x.w 是 w² 而非 1）。
   - 所在位置：§3.9 `axis` 函数描述（约第 443 行）
   - 严重程度：严重
   - 改进建议：二选一：(A) 将签名修订为 `axis(x: Quat<T,Q>, one: T): Vec3<T,Q>`，与 `identity(one: T)` 风格一致，公式 `T(1)` 替换为 `one`；(B) 显式说明 T(1) 的替代获取路径（如 `T(Float64(1))` 转换），并在 §8 编码启动前验证项新增对应验证项。同时删除/修正"通过 `x.w*x.w` 取得"的错误描述。
3. **问题描述**：`fromMat4` 降维策略未明确，与阶段二 `Mat3x3.fromMat4(m, one: T)` 模式不一致——设计给出"或"的选择（手动提取 vs GLM 策略转换），但两种方式语义不同（手动提取不需要 `one` 参数；Mat3x3 构造函数依赖阶段二未提供的构造重载），下游无法决策。
   - 所在位置：§3.3 item 7（约第 308 行）
   - 严重程度：严重
   - 改进建议：明确选择一种策略。若选手动提取，需说明实现路径（参考 `cjglm/src/detail/matrix.cj:22` 的 `transpose` 模式）；若选 Mat3x3 构造，需先在阶段二 `Mat3x3` 扩展 `fromMat4x4(m: Mat4x4<T, SrcQ>): Mat3x3<T, Q>` 工厂函数。删除"或"的表述。同时核对 `fromMat3` 是否也需类似调整。
4. **问题描述**：`Mat2x2/FMat2x2` 双别名机制引用错误——阶段二 `cjglm/src/fwd.cj` 实际仅存在 `Mat2x2` (Float32) + `DMat2x2` (Float64) 双别名，不存在 `FMat*` 任何声明；`fwd.cj` 中唯一带 `F` 前缀的别名是 Vec 家族（`FVec1`~`FVec4`、`F32Vec1`~`F32Vec4`）。设计错误地套用 Vec 家族的 `FVec*` 模式到 Mat 家族作为先例。
   - 所在位置：§3.14（约第 539 行 `FQuat` 段落）、§7 D27、§9 差异声明对应条目
   - 严重程度：严重
   - 改进建议：修订 §3.14 先例引用为 Vec 家族的 `Vec` + `DVec` + `FVec` + `F32Vec` 四重模式（见 `fwd.cj:105, 122, 275, 292`）；修订 D27 决策依据；同步修订 §9 差异声明对应条目；明确阶段三 `Quat` 家族决策理由（是否需要 `FQuat` 双重别名）。
5. **问题描述**：测试文件命名约定与现有项目不一致——设计 13 个测试文件均使用 `xxx_test.cj` 命名，但阶段二 `cjglm/tests/glm/detail/` 25 个测试文件全部使用 `test_xxx.cj` 命名。
   - 所在位置：§8.2 测试设计表
   - 严重程度：一般
   - 改进建议：将 13 个测试文件名统一调整为 `test_xxx.cj` 风格，与现有约定对齐。
6. **问题描述**：`trigonometric.cj` 函数清单未区分标量/向量重载——设计列出 15 个函数但未说明标量/向量重载形式，下游只声明向量版本会导致 `mix`/`slerp`/`roll`/`pitch`/`yaw`/`pow`/`log` 等的 `acos(T)`/`sin(T)`/`atan(T)` 标量调用编译失败。
   - 所在位置：§3.13 表（约第 503-509 行）
   - 严重程度：一般
   - 改进建议：在 §3.13 表中明确 `trigonometric.cj` 应提供 30 个函数（15 标量 + 15 向量），并补充 `atan` 的双参数标量版本（`atan2(T, T): T`）。或新增子节明确标量/向量的用途分工。
7. **问题描述**：`axis` 函数 Float32 sqrt 处理策略缺失——`std.math.sqrt` 仅支持 Float64 输入/输出，T 为 Float32 时 `sqrt(tmp1)` 编译失败；设计仅在 `length` 一处明确该问题，未将其作为一般性约束贯彻到所有 `std.math` 函数调用。
   - 所在位置：§3.9 `axis` 函数描述
   - 严重程度：一般
   - 改进建议：在 §1「系统性设计约束」中新增"Float32 与 std.math 的交互约束"段落，统一说明 `std.math` 所有函数（sqrt/pow/log/exp/sin/cos/asin/acos/atan）仅支持 Float64，Float32 实例化时需显式 `T(Float64.xxx(Float64(...)))` 转换，或额外声明 Float32 重载；将 `axis`/`length`/`angleAxis`/`exp`/`log`/`pow`/`sqrt` 等所有使用 `std.math` 的函数均引用该一般性约束。
8. **问题描述**：`fromVec3` 工厂函数边界行为契约缺失——设计标记为 stub 占位但未说明 u, v 反平行等特殊场景的行为契约；GLM 1.0.3 实际有 180° 任意垂直轴退化路径（`type_quat.inl:196-217`）。
   - 所在位置：§3.3 item 8、§5 错误处理策略、§5.3 边界条件表
   - 严重程度：一般
   - 改进建议：在 §3.3 item 8 补充"边界场景：u, v 反平行时返回 180° 任意轴四元数（GLM 退化路径）"契约说明；在 §5.3 边界条件表新增对应行；§11.5 函数可用性对照表新增对应条目。
9. **问题描述**：`mat3Cast`/`mat4Cast` 接受非旋转矩阵的边界行为契约未与 §3.3 工厂函数对齐——§3.3 item 6 已对 `Quat.fromMat3` 明确边界声明，但 §3.2.1 中 `mat3Cast`/`mat4Cast` 描述未同步；`mat3Cast` 接受非单位四元数时返回矩阵行为未定义。
   - 所在位置：§3.2.1（type_quat_cast 函数签名规范段）、§5 错误处理策略
   - 严重程度：一般
   - 改进建议：在 §3.2.1 签名模板后新增"边界行为契约"段，明确 `mat3Cast`/`mat4Cast` 接受非单位四元数时返回矩阵不保证是旋转矩阵（缩放/剪切分量保留）；`quatCast` 接受非旋转矩阵时返回的四元数行为未定义。同步在 §5.3 边界条件表新增对应行。
10. **问题描述**：测试文件 `gtc/quaternion_test.cj` 用例数与 gtc 命名空间 API 数量比例失衡——20 个用例分摊到 8 个完整实现函数仅 2.5 个/函数，低于其他测试文件。
   - 所在位置：§8.2 测试设计表 `gtc/quaternion_test.cj` 行
   - 严重程度：轻微
   - 改进建议：在 §8.2 测试设计补充"用例分配原则"段，并按此原则重算 `gtc/quaternion_test.cj` 用例数。
11. **问题描述**：§11.5 函数可用性对照表 `isnan`/`isinf` 行未与 §3.11 `where` 子句约束保持一致——未明确具体约束的 where 子句形式，下游迁移者可能不理解为何整型 T 编译失败。
   - 所在位置：§11.5 函数可用性对照表 `isnan`/`isinf` 行（约第 1121 行）、`mat3_cast`/`mat4_cast`/`quat_cast` 行（约第 1130-1131 行）
   - 严重程度：轻微
   - 改进建议：在 §11.5 对应行末尾追加约束标注，如"约束：`where T <: FloatingPoint<T>`（D29/D32）"。

## 迭代第 4 轮

1. **问题描述**：`fromMat4` 引用阶段二 `fromMat` 列提取模式的描述与项目实际模式不符。§3.3 item 7 声明「无需 `one: T` 参数」并以 `type_mat2x2.cj:163-165` 中「Mat2x2.fromMat(Mat3x3, one)」为论据，但该被引用代码本身要求 `one: T`；实际项目模式为「同维度构造才省略 `one: T`，跨维度构造一律要求 `one: T`」。同时与 §1「T(1) 必须由调用方显式传入」的系统性约束存在内部矛盾。
   - 所在位置：§3.3 item 7（约第 326 行）
   - 严重程度：严重
   - 改进建议：重新审视 `fromMat4` 的实现路径。建议路径 A（与 GLM `gtc/quaternion.inl:128` 一致）：签名改为 `fromMat4(m: Mat4x4<T, Q>, one: T): Quat<T, Q>`，内部直接提取 9 分量（不构造中间 Mat3x3），与阶段二 `fromMat` 系列签名风格一致。同时同步在 §3.3 item 6（`fromMat3`）明确相同的 `one: T` 处理策略，保持描述对齐。
2. **问题描述**：`mat3Cast`/`mat4Cast` T(1) 获取策略缺失，与 §1 系统性约束冲突。GLM `gtc/quaternion.inl:49` 实际使用 `Mat3x3(T(1))` 初始化单位矩阵，但设计 §3.2.1 中 `mat3Cast`/`mat4Cast`/`quatCast` 签名模板未提及 T(1) 获取方式，且 §1 受约束函数清单未包含这三个函数，下游编码者需自行决策引入 `one: T` 参数或使用 `T(Float64(1))` 字面量，可能产生实现分歧。
   - 所在位置：§3.2.1（type_quat_cast 函数签名规范）、§1（系统性设计约束）
   - 严重程度：严重
   - 改进建议：在 §3.2.1 `mat3Cast`/`mat4Cast` 签名后追加「**实现策略（v8 补强）**：内部 `Mat3x3(T(Float64(1)))` 初始化对角线，按 GLM `gtc/quaternion.inl:49-71` 公式逐项修改。T(1) 通过 §1「Float64(1) 字面量替代策略」获取，无需 `one: T` 形参污染函数签名」。同时 §1 受约束函数清单补充 `mat3Cast`/`mat4Cast`/`Quat×Vec3`/`Quat×Vec4` 等所有使用 T(1) 或 T(2) 字面量的函数，确保约束引用闭环。
3. **问题描述**：`ext/vector_relational.cj` GLM 文件引用错误，行号与文件名均错误。§3.5 描述「向量 `equal`/`notEqual` epsilon 版本采用严格 `<` 语义，与 GLM 1.0.3 `func_vector_relational.inl:18-22` 一致」，但 GLM 1.0.3 的 `func_vector_relational.inl` 中根本不包含 epsilon 版本，epsilon 版本实际位于 `glm/gtc/epsilon.inl:32-41`（`epsilonEqual`）与 `55-59`（`epsilonNotEqual`）。
   - 所在位置：§3.5（第 388 行）、D24 设计决策（第 812 行）、§9 差异声明（第 972 行）、§10 覆盖矩阵（第 1030-1033 行）
   - 严重程度：一般
   - 改进建议：将 4 处文件/行号引用统一修正为 `gtc/epsilon.inl:32-41`（`epsilonEqual` 严格 `<` 语义）。§9 差异声明新增「向量 `equal`/`notEqual` epsilon 版本放置于 ext/ 层而非 gtc 层，与 GLM `glm/gtc/epsilon.hpp` 文件归属不一致」并说明本阶段架构选择理由。§3.5 表格补充 `notEqual`（epsilon 版本）的 `>=` 互补语义说明（与 `gtc/epsilon.inl:55-59` 一致）。
4. **问题描述**：`lib.cj` 新增 import 清单不完整。§2「lib.cj 新增 import 清单」列出 8 个 import 声明，对照 §2 包组织图中新增的 16 个文件，遗漏 `ext/quaternion_transform.cj`、`ext/quaternion_exponential.cj`、`ext/quaternion_trigonometric.cj`、`detail/trigonometric.cj`、`gtc/quaternion.cj`、`gtc/matrix_transform.cj`、4 个四元数别名文件（`quaternion_float.cj`/`quaternion_double.cj`/`quaternion_float_precision.cj`/`quaternion_double_precision.cj`）、3 个矩阵新增空桩（`matrix_projection.cj`/`matrix_clip_space.cj`/`matrix_transform.cj`）等模块的 import。
   - 所在位置：§2 lib.cj import 清单段（第 102-110 行）
   - 严重程度：一般
   - 改进建议：§2 lib.cj 新增 import 清单扩充至完整 15-16 个 import 声明，覆盖所有 ext/、detail/、gtc/ 新增文件。对 stub 文件的 import 策略明确说明（建议采用 `public import` 让 stub 函数也可通过命名空间调用，便于测试 stub 异常路径），并同步修订 §8 更新文件段 lib.cj 描述。
5. **问题描述**：§3.4「交换律别名」解释中 `Number<T>` 语义描述不准确。原文称「`Quat×T` 运算符已通过 `Number<T>` 约束交换律覆盖」，但 `Number<T>` 接口本身不提供交换律语义，仓颉运算符重载中左操作数类型决定 operator 函数归属，`T * Quat` 的 `T` 在左操作数位置时无法定义为 Quat 的成员运算符，必须通过 `scalar_quat_ops.cj` 的全局函数实现。
   - 所在位置：§3.4 全局具名函数表后说明（第 375 行）
   - 严重程度：轻微
   - 改进建议：将「`Number<T>` 约束交换律覆盖」修订为「通过 `scalar_quat_ops.cj` 全局具名函数提供 `T * Quat` 等标量左侧运算（与阶段二 `scalar_mat_ops.cj` 模式一致）；仓颉 operator func 限制——左操作数类型非 Quat 时不能定义为 Quat 成员运算符，必须通过全局函数实现（依据 D05 决策）」。保持原有「无需单独交换律别名函数」的结论不变。
6. **问题描述**：§11.5 gtc 重导出行的 `where T <: FloatingPoint<T>` 约束归属描述不清。§11.5 标注「**约束：`where T <: FloatingPoint<T>`（D32）**」，但 D32 实际针对 `detail/type_quat_cast.cj` 的原始定义函数，gtc 端通过 public import 重导出后约束应自动继承，下游消费者可能误以为 D32 在 gtc 端独立定义。
   - 所在位置：§11.5（第 1202 行）
   - 严重程度：轻微
   - 改进建议：在 gtc 重导出行的约束标注后追加「（约束继承自 detail 端实现，通过 public import 透明传递）」，避免下游误读为 gtc 端独立约束定义。
7. **问题描述**：§8「产出物清单」中 `gtc/quaternion.cj` 行数量描述与 §3.2 协作关系表存在视觉呈现差异（实际无矛盾）。
   - 所在位置：§8 第 840 行、§3.2 第 250-253 行
   - 严重程度：轻微
   - 改进建议：无需修改——两处描述实际一致，仅格式呈现略不同。

## 迭代第 5 轮

1. **问题描述**：设计 §3.10、D21、§8 编码启动前验证项 16/18 多次引用 `FloatingPoint<T>.getMin()` 和 `FloatingPoint<T>.getInf()` 实例方法作为「主策略」。但经查 `cangjie-std/math/README.md` 第 111-115 行，仓颉 stdlib 不存在这两个方法，仅存在 `Float64.Inf`/`Float64.Min`/`Float64.Max`/`Float64.NaN` 等静态常量。`FloatingPoint<T>` 接口本身仅作为类型约束被声明，未列出任何实例方法。验证项 16/18 的「主验证目标」100% 不存在，下游即使启动验证也只能命中 fallback 路径。
   - 所在位置：§3.10（约第 496-497 行）、D21 设计决策（约第 830 行）、§8 编码启动前验证项 16（第 968 行）、§8 编码启动前验证项 18（第 970 行）
   - 严重程度：严重
   - 改进建议：- §3.10 `pow`/`log` 依赖描述修订为「通过类型分派 `if (q.x is Float32) { Float32.Min } else { Float64.Min }` 或运行时 fallback `T(1)/T(0)` 显式构造」，并明确「仓颉 stdlib 不提供 `getMin()`/`getInf()` 实例方法，仅提供 `Float64.Inf`/`Float64.Min`/`Float64.Max` 等静态常量」   - D21 决策依据修订为「stdlib 仅提供类型级常量（`Float64.Inf`/`Float64.Min` 等），无实例方法；仓颉实现路径为类型分派 + 字面量构造」   - §8 验证项 16 修订为「验证仓颉浮点类型最小正值获取路径」并补充 fallback（类型分派）   - §8 验证项 18 修订为「验证仓颉浮点类型 Infinity 获取路径」并补充 fallback（类型分派）  ### 问题 2（严重）
2. **问题描述**：§3.14、§2 lib.cj/fwd.cj 段落、§8 更新文件段多处声称 fwd.cj 新增「8 个别名」并明确列出 `Quat` / `FQuat` / `DQuat` + 3×Float32 精度（`HighpQuat`/`MediumpQuat`/`LowpQuat`）+ 3×Float64 精度（`HighpDQuat`/`MediumpDQuat`/`LowpDQuat`）= 9 个别名。算术与文字直接矛盾（3+3+3=9 vs 汇总数字 8）。下游按设计实现 fwd.cj 时会产生 9 个 type alias（与文档声称的 8 不一致），§8 测试文件清单、§11.5 函数可用性对照表的引用统计也将偏差 1。
   - 所在位置：§3.14（约第 609 行、第 614 行）、§2 lib.cj/fwd.cj 段落（约第 138 行）
   - 严重程度：严重
   - 改进建议：- §3.14 / §2 三处「合计 8 个别名」统一修订为「合计 9 个别名」   - §2 lib.cj/fwd.cj 段「v5 修正」附注修订为「v5 修正：原描述遗漏 1 个，完整应为 Quat/FQuat/DQuat + 3×Float32 精度 + 3×Float64 精度 = 9 个」  ### 问题 3（严重）
3. **问题描述**：§3.10 「命名消歧（v5 新增）」段声明「四元数 `pow` 函数体内部调用的 `pow(x.w, y)` 是实数版本 `std.math.pow(T, T): T`」。但按 `cangjie-std/math/README.md` 第 13 行，`std.math.pow` 实际签名为 `pow(base: Float64, exponent: Float64): Float64`，不是泛型 `pow(T, T): T`。下游编码者按设计字面实现「`pow(x.w, y)`」时：当 `T = Float64` 时签名不一致（返回类型不是 T 而是 Float64）；当 `T = Float32` 时直接编译失败（不存在该重载）。§3.10 「命名消歧」段与「Float64 转换依赖」段描述不一致，下游实现 pow 时按哪段描述为准存在歧义。
   - 所在位置：§3.10 「命名消歧（v5 新增）」段与「Float64 转换依赖（v7 澄清）」段（约第 497 行附近）
   - 严重程度：严重
   - 改进建议：- §3.10 「命名消歧」段将「`std.math.pow(T, T): T`」修订为「`std.math.pow(Float64, Float64): Float64`（仅支持 Float64 输入）」   - 与「Float64 转换依赖」段统一，明确下游实现路径为：`Float64(std.math.pow(Float64(x.w), Float64(y)))` 或 fallback `Float64(std.math.exp(Float64(y) * std.math.log(Float64(x.w))))`，最终结果通过 `T(...)` 转换回目标类型   - §8 验证项 15 同步修订为「验证 std.math.pow 的 Float64-only 签名 + T(…) 转换路径的编译可行性」  ### 问题 4（一般）
4. **问题描述**：设计 §3.12 提出在 `detail/scalar_constants.cj` 新增 `func epsilon<T>(): T where T <: FloatingPoint<T>` 函数，但 `cjglm/src/detail/shim_limits.cj` 第 25 行已存在同名语义的 `public func epsilonOf<T>(hint: T): T where T <: Number<T>`，且 `cjglm/src/detail/compute_vector_relational.cj` 第 17 行已使用 `epsilonOf(a)` 进行浮点容差比较。设计 §3.12 未说明：(a) `epsilon<T>()`（无参）与 `epsilonOf<T>(hint)`（带 hint）的功能等价性与新增「无参版本」是否为 API 形态对齐 GLM 的冗余代价；(b) 若阶段三同时存在两者，返回值是否始终一致；(c) 阶段二测试 `shim_limits_test.cj` 的硬编码值与设计 §3.12 的「具体类型硬编码值」是否一致未做交叉验证。
   - 所在位置：§3.12 ext/scalar_constants.cj（约第 523-530 行）
   - 严重程度：一般
   - 改进建议：- §3.12 段落新增「与 `shim_limits.cj:25` `epsilonOf<T>(hint)` 关系」子节，明确：(a) 两函数功能等价，阶段三新增 `epsilon<T>()` 是为了对齐 GLM API 形态（无参调用），无业务新增；(b) 两者返回值需严格一致（建议 `epsilon<T>()` 函数体内部直接调用 `epsilonOf<T>(epsilonOf<T> placeholder hint)` 或复刻相同 match 分派逻辑）；(c) 阶段二测试 `shim_limits_test.cj` 的硬编码值已作为数值正确性的 ground truth   - 编码启动前验证项新增「验证 `epsilon<T>()` 与 `epsilonOf<T>(hint)` 在 `T = Float32`/`Float64`/`Int64` 下的返回值一致性」  ### 问题 5（一般）
5. **问题描述**：§3.13.1 表头中向量版本签名统一使用 `VecN<T, Q>: VecN<T, Q>` 形式（如 `sin<T, Q>(x: VecN<T, Q>): VecN<T, Q>`），设计汇总「30 个函数」。但仓颉项目不存在 `VecN` 这种泛型占位类型——实际模式是 `compute_vec_add1`/`add2`/`add3`/`add4` 四个独立 struct。下游按设计实现 trigonometric.cj 时，「30 个函数」实际需展开为大量重载签名，设计未说明此展开规则，下游编码者需自行推断展开策略，可能与既有命名/结构惯例不一致。
   - 所在位置：§3.13.1（约第 553-580 行）
   - 严重程度：一般
   - 改进建议：- §3.13.1 表头新增说明「`VecN<T, Q>` 是占位符，实际展开为 `Vec1<T, Q>`/`Vec2<T, Q>`/`Vec3<T, Q>`/`Vec4<T, Q>` 4 个独立重载，命名沿用 `cjglm/src/detail/compute_vector_decl.cj` 的 `compute_vec_xxx1/2/3/4` 模式」   - 函数总数重新核算实际函数数量；或将 14 个单参数三角函数的向量版本改用 `compute_vec_sin1`/`sin2`/`sin3`/`sin4` 命名惯例（与 compute_vector_decl.cj 对齐）  ### 问题 6（一般）
6. **问题描述**：§5.4 声明「`lerp`/`conjugate`/`inverse` 不可在 const 上下文调用」，理由为「函数体内 `assert` 或 `throw` 不是 const 函数」。但 §3.11 描述 `conjugate(q)` 仅对 x/y/z 三个分量取反，函数体内无 assert/throw/运行时副作用，因此 `conjugate` 实际可在 const 上下文调用（与 §5.4 声明矛盾）。§5.4 将 `conjugate` 与 `inverse`/`lerp` 列为同类，但 `conjugate` 缺少使其无法 const 的理由。内部描述不一致，下游编码者按 §5.4 实现 conjugate 时会因「函数体无 assert/throw 仍标 non-const」产生困惑。
   - 所在位置：§5.4 const 上下文约束（约第 789-792 行）、§3.11 `conjugate` 描述（约第 508 行）
   - 严重程度：一般
   - 改进建议：- §5.4 修订为「`lerp`/`inverse` 不可在 const 上下文调用」，移除 `conjugate`   - §5.4 补充 `inverse` 的 const 拒绝理由：「依赖 `/` 运算符，整数 T 在 `dot(q,q) == 0` 时触发 `ArithmeticException`，非 const 函数」   - §3.11 `conjugate` 描述末尾新增「可声明为 `const func`（与 `Vec`/`Mat` 的逐分量运算符策略一致）」；若仓颉 const 函数还有其他限制（如不能调用非 const 自由函数），则该论断需进一步评估  ### 问题 7（一般，质询建议可降为轻微）
7. **问题描述**：§3.13.1 表中 `radians`/`degrees` 行「内部依赖」列标注「纯算术（度→弧度，无 std.math 依赖）」，意味着 `radians(x) = x * π/180` 类公式中 `π` 的来源未明确（硬编码字面量 vs 调用 `scalar_constants.cj` 的 `pi<T>()`）。§2 模块间依赖图未列出该依赖。设计两处描述自相矛盾：表头说「无 std.math 依赖」，但又说「标量版本用于 `slerp`/`mix`/`pow`/`log`/`exp`/`angle`/`angleAxis` 等函数体内的分量级运算」——而这些函数在 stage 3 都是 stub，radians/degrees 在 stage 3 也是 stub，所以实际依赖在 stage 4 才落地。
   - 所在位置：§3.13.1 表（约第 573-574 行）
   - 严重程度：一般（质询报告建议可降为轻微，因仅影响阶段四实现）
   - 改进建议：- §3.13.1 `radians`/`degrees` 行「内部依赖」列补充明确：「硬编码 π 字面量 `Float64(3.141592653589793)`，无 std.math 依赖，无 `scalar_constants` 依赖」   - 或补充：「调用 `scalar_constants.cj` 的 `pi<T>()`，新增 `trigonometric.cj → scalar_constants.cj` 依赖」，并在 §2 模块间依赖图 `glm.detail` 块下新增此依赖  ### 问题 8（一般）
8. **问题描述**：§8.2 测试文件清单建议阶段三测试文件采用 `tests/glm/ext/` 结构（如 `tests/glm/ext/test_vector_relational.cj` 等共 10 个文件）。但项目现有测试结构为 `cjglm/tests/glm/test_ext.cj`（单一文件涵盖所有 `ext.*` 别名测试），且实际 `cjglm/tests/glm/ext/` 目录不存在。阶段二 25 个测试文件均位于 `tests/glm/detail/` 下，但阶段二并无 `ext/` 子目录的测试文件先例。设计引入 `tests/glm/ext/` 是新建目录结构，但未说明：(1) 与既有的 `tests/glm/test_ext.cj` 的关系——阶段三是否合并/拆分？(2) 是否同步新增 `tests/glm/gtc/` 子目录——设计清单中有 `tests/glm/gtc/` 下的测试文件，但 `tests/glm/gtc/` 当前不存在。
   - 所在位置：§8.2 测试文件清单与位置表（约第 894-913 行）
   - 严重程度：一般
   - 改进建议：- §8.2 测试设计新增「测试目录结构对齐策略」段，明确：(a) `tests/glm/ext/` 为新增目录（项目当前无此目录先例），下游需先 `mkdir -p`；(b) 既有的 `tests/glm/test_ext.cj`（聚合测试）保留为 ext 别名兼容测试，新增的 `tests/glm/ext/test_xxx.cj` 为逐函数单元测试，二者并存；(c) `tests/glm/gtc/` 同样为新增目录，与 `src/gtc/` 子目录结构对齐   - 或修订测试文件结构为 `tests/glm/test_ext_xxx.cj` 命名（与现有 `test_ext.cj` 风格对齐），避免新建子目录  ### 问题 9（一般）
9. **问题描述**：§2 模块间依赖图 `glm.gtc` 块声明 `quaternion.cj → glm.detail.{Quat, Mat3x3, Mat4x4, Vec3}`。但逐项核查 §3.15 的 15 个 gtc/quaternion.cj 函数：4 个比较函数（`lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual`）仅依赖 `Quat`，完全不依赖 `Mat3x3`/`Mat4x4`/`Vec3`；3 个 quatLookAt 函数仅依赖 `Vec3`，不依赖任何 Mat 类型。设计将依赖声明扩展至全部 Mat/Vec 类型，下游按声明增加 import 后会产生未使用 import（造成代码冗余）。
   - 所在位置：§2 模块间依赖图（约第 198 行）、§3.2.1 与 §3.15
   - 严重程度：一般
   - 改进建议：- §2 模块间依赖图 `glm.gtc` 块修订为：`quaternion.cj → glm.detail.Quat, glm.detail.{Mat3x3, Mat4x4} (仅 mat3_cast/mat4_cast/quat_cast 重导出需要), glm.detail.Vec3 (仅 eulerAngles/roll/pitch/yaw/quatLookAt* stub 需要)`   - 或修订为分段声明：`比较函数仅依赖 Quat；转换函数重导出 detail 的 Mat3x3/Mat4x4；欧拉/看向 stub 依赖 Vec3`  ### 问题 10（一般）
10. **问题描述**：§1 「本阶段受此约束影响的函数」清单列出 7 个函数，但 §3.13.1 三角函数表中列出 trigonometric.cj 函数时，未将 `trigonometric.cj` 自身标注「受 §1 Float32 与 std.math 交互约束管辖」——而 trigonometric.cj 实现的 14 个标量函数本身就调用 `std.math.sin`/`cos`/`tan` 等 Float64-only 函数，下游实现 trigonometric.cj 时需对每个函数应用 `T(Float64.xxx(Float64(value)))` 转换模式。设计 §3.13.1 表头虽写「受 §1 管辖」，但表行内容未充分映射此约束对每个函数的影响。
   - 所在位置：§3.13.1 三角函数表（约第 559-580 行）
   - 严重程度：一般
   - 改进建议：- §3.13.1 表头说明强化：「**所有 `std.math.*` 函数仅支持 Float64 输入/输出（依据 `cangjie-std/math/README.md` 第 13 行），所有 trigonometric.cj 函数在 `T = Float32` 实例化时需应用 `T(Float64.xxx(Float64(value)))` 转换模式**」   - 表行「内部依赖」列统一标注「`std.math.{func}`（仅 Float64，Float32 实例化需显式转换）」  ### 问题 11（一般，质询建议可降为轻微）
11. **问题描述**：§3.9 `axis` 函数公式（约第 482 行）：`tmp2 = T(Float64(1)) / T(Float64(std.math.sqrt(Float64(tmp1))))`。`std.math.sqrt` 本身签名为 `sqrt(x: Float64): Float64`，返回值已是 `Float64`，公式中 `Float64(std.math.sqrt(Float64(tmp1)))` 等价于 `Float64(Float64)`（冗余但合法），下游可正常工作但语义不清晰。冗余嵌套增加了维护负担。
   - 所在位置：§3.9 `axis` 函数描述（约第 482 行）
   - 严重程度：一般（质询报告建议可降为轻微，属纯风格问题，不影响功能）
   - 改进建议：- §3.9 公式修订为 `tmp2 = T(Float64(1)) / T(std.math.sqrt(Float64(tmp1)))`，删除冗余的 `Float64(...)` 包装   - 在公式旁新增公式解读注释：「`std.math.sqrt` 已是 Float64 输入/输出，仅需一次 `T(Float64(…))` 转换回目标类型 T」  ### 问题 12（一般）
12. **问题描述**：§1 「系统性设计约束」段说明 `Float32 与 std.math 的交互约束`「统一处理策略」——所有引用 std.math 的函数应统一引用此约束。但 §3.10 `pow` 描述在「命名消歧（v5 新增）」段后又单设「Float64 转换依赖（v7 澄清）」子段，二者功能重叠：§1 通用约束已说明 `pow(Quat<Float32, Q>, Float32)` 需 Float64 转换，§3.10 又单独说明 `pow` 的 Float64 转换细节。下游阅读时会产生「§1 已说明的通用规则为何 §3.10 又重复一次」的疑问，且「命名消歧」段与「Float64 转换依赖」段描述同一约束但行文分散。
   - 所在位置：§1 通用约束段（约第 54-63 行）、§3.10 `pow` 描述（约第 497 行）
   - 严重程度：一般
   - 改进建议：- §3.10 `pow` 「Float64 转换依赖」段精简为「`pow(Quat<Float32, Q>, Float32)` 实现路径遵循 §1 通用约束，应用 `T(Float64.std.math.pow(...))` 转换模式」，删除与 §1 重复的展开说明   - 或将 §3.10 的「Float64 转换依赖」段并入「命名消歧」段，统一为「命名消歧与 Float64 转换」单一小节  ### 问题 13（一般）
13. **问题描述**：§3.11 `inverse` 描述与 §5.3 边界条件表对整数 inverse 行为契约措辞不一致——虽两处描述本质一致，但 §5.3 表的「`axis(q)` 零四元数」行措辞（`\|w\| >= 1`）与 §3.9 `axis` 描述（`tmp1 <= 0`）虽等价但措辞略不同，且 §5.3 表未说明 `tmp1 = T(1) - w*w` 的计算公式，下游需对照 §3.9 才能完全理解边界条件。
   - 所在位置：§3.11 inverse 描述（约第 509 行）、§5.3 边界条件表（约第 773-776 行）
   - 严重程度：一般
   - 改进建议：- §5.3 边界条件表「`axis(q)` 零四元数」行补充「`tmp1 = T(1) - x.w*x.w`（参见 §3.9 公式）」明确公式引用   - §5.3 表的「整数 `inverse`」行措辞与 §3.11 inverse 描述统一为「触发仓颉 `ArithmeticException`」  ### 问题 14（一般）
14. **问题描述**：§8 编码启动前验证项 16/18 验证目标不存在的 API（`getMin`/`getInf`），导致实际验证项无法独立完成。此问题与问题 1 同源，但单独标记是因该问题还影响「验证流程可执行性」维度——内部审议可能因「验证项已列出」即视为流程完备，未深入核验验证目标的可达性。
   - 所在位置：§8 编码启动前验证项 16（约第 968 行）、验证项 18（约第 970 行）
   - 严重程度：一般
   - 改进建议：同问题 1。修订后同步验证项 16/18 描述为「验证类型分派路径 + 字面量 fallback 路径的编译可行性」  ### 问题 15（轻微）
15. **问题描述**：§8.2 测试文件清单末尾声称合计 ≥178 个用例，但累加各测试文件预计用例数为 179，差 1。下游按设计规划测试用例数时会与文档声称值偏差 1。
   - 所在位置：§8.2 测试文件清单与位置表末尾（约第 913 行）
   - 严重程度：轻微
   - 改进建议：- §8.2 表末尾「合计」数字修订为「≥179」   - 同步检查 §3.16 「阶段三验证标准双向映射表」等引用总数的位置，确保一致  ### 问题 16（一般）
16. **问题描述**：§11.5 函数可用性对照表对 `isnan`/`isinf` 与 `mat3_cast`/`mat4_cast`/`quat_cast` 共 6 行均追加了「约束：`where T <: FloatingPoint<T>`（D29/D32）」标注，但对同表的 `lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual` 4 个比较函数行未追加任何约束标注。下游阅读对照表时会产生「比较函数无约束 → 任何 T 均可调用」的误解。实际 `lessThan` 等函数依赖 `<`/`>` 运算符，约束为 `T <: Comparable<T>`。
   - 所在位置：§11.5 函数可用性对照表最后一行（约第 1224 行）
   - 严重程度：一般
   - 改进建议：- §11.5 `lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual` 行追加「**约束：`where T <: Comparable<T>`（依赖 `<`/`>` 运算符）**」标注   - §3.15 完整实现函数段（行 638-641）补充 `lessThan` 等 4 个函数的 where 子句约束（`where T <: Comparable<T>, Q <: Qualifier`）  ### 问题 17（轻微）
17. **问题描述**：§2 lib.cj import 清单 #1 合并导入类型 `Quat` 与函数 `mat3Cast`/`mat4Cast`/`quatCast`，但 §2 未说明下游是否需要在 `lib.cj` 内部对 `mat3Cast` 等做进一步 `public import` 以暴露到顶层 `glm` 命名空间。下游消费者按 §11.4 迁移示例调用 `let m3 = mat3Cast(q)`（无命名空间前缀）会编译失败，需先 `import glm.detail.*` 才能调用包级函数。
   - 所在位置：§2 lib.cj import 清单 #1（约第 106 行）、§11.4 迁移示例（约第 1188-1195 行）
   - 严重程度：轻微
   - 改进建议：- §2 lib.cj 段补充说明：「`glm.detail.{mat3Cast, mat4Cast, quatCast}` 在 lib.cj 中以 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 形式重导出至顶层 `glm` 命名空间（与现有 `public import glm.detail.{transpose, matrixCompMult, outerProduct}` 模式一致，见 `cjglm/src/lib.cj:8`）」   - 或 §11.4 迁移示例修订为 `let m3 = glm.detail.mat3Cast(q)`，明确调用路径

## 迭代第 6 轮

1. **问题描述**：§3.13.1 trigonometric.cj 函数清单中 15 个函数（14 个单参数三角函数 + atan2 双参数）的标量签名与向量签名模板均无 `where T <: FloatingPoint<T>` 约束子句，与 §3.2.1 D32、§3.11 D29、§3.12 D25 已统一的 `where T <: FloatingPoint<T>` 策略不一致；下游编码者实现时对 T 约束决策无明确依据；整数 T 实例化将编译失败但文档无前置告警
   - 所在位置：§3.13.1 trigonometric.cj 函数清单（行 573-596 附近）所有 15 个函数的标量签名与向量签名列
   - 严重程度：严重
   - 改进建议：§3.13.1 表头新增「**T 类型约束（v11 新增）**」段，所有 15 个函数签名模板修订为 `sin<T>(x: T): T where T <: FloatingPoint<T>` 与 `sin<T, Q>(x: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier`；表行「内部依赖」列对 `std.math.{func}` 调用统一追加「**T 必须为 FloatingPoint<T>**」标注  ### 问题 2（来自诊断报告严重问题 2）
2. **问题描述**：§3.7 normalize 函数描述仅写「内部调用 length」，未提及 GLM `quaternion_geometric.inl:17-24` 的零四元数保护分支 `if(len <= 0) return identity`；下游按 §3.7 字面实现 `q / length(q)` 时零四元数将产生 NaN，与 §5.1 已确认的「normalize 零四元数返回 identity」契约不符；§5.3 边界条件表也缺少 normalize 零四元数行
   - 所在位置：§3.7 normalize 函数描述（行 453 附近）+ §5.3 边界条件表（行 789-805 附近）缺少 normalize 零四元数行
   - 严重程度：严重
   - 改进建议：1. §3.7 补充完整实现公式 `tmp1 = length(q); if (tmp1 <= T(Float64(0))) { return identity_q } else { return q / tmp1 }`，末尾新增「**实现策略（v11 补强）**」段   2. §5.3 边界条件表新增 2 行（零四元数保护、length 极小值精度损失）  ### 问题 3（来自诊断报告一般问题 3）
3. **问题描述**：§3.4 运算符体系表 Quat×Vec3 行公式 `v + (cross(QuatVector, v) * q.w + cross(QuatVector, cross(QuatVector, v))) * T(Float64(2))` 中 `QuatVector` 符号未定义，下游需自行对照 GLM `type_quat.inl:359-366` 推导 `QuatVector = Vec3(q.x, q.y, q.z)`
   - 所在位置：§3.4 运算符体系表 Quat×Vec3 行备注列（行 367 附近）
   - 严重程度：一般
   - 改进建议：§3.4 Quat×Vec3 行备注列补充完整公式定义 `QuatVector = Vec3(q.x, q.y, q.z); uv = cross(QuatVector, v); uuv = cross(QuatVector, uv); return v + (uv * q.w + uuv) * T(Float64(2))`；同步检查 §3.4 Quat×Vec4 行  ### 问题 4（来自诊断报告一般问题 4）
4. **问题描述**：§4.4 行为契约示例使用 `let m3 = mat3Cast(q)` 等无命名空间前缀形式，与 §11.4 v10 已明确的「顶层 `glm` 命名空间调用」示例不一致，下游按 §4.4 字面实现若未先 `import glm.detail.*` 则编译失败
   - 所在位置：§4.4 矩阵-四元数互转行为契约示例（行 747-754 附近）
   - 严重程度：一般
   - 改进建议：§4.4 行为契约示例统一使用顶层 `glm` 命名空间调用形式（与 §11.4 v10 对齐），段首补充「前提：调用方已通过 lib.cj 完成 public import 间接访问」  ### 问题 5（来自诊断报告一般问题 5）
5. **问题描述**：§3.10 pow 函数依赖描述引用 GLM `quaternion_exponential.inl` line 65/78 两处 pow 调用，但未提供 line 65 仓颉等价翻译（GLM wxyz 与仓颉 Quat 主构造 xyzw 顺序差异），未提及 line 78 的 magnitude 缩放逻辑
   - 所在位置：§3.10 pow 函数依赖描述（行 497 附近）+ D21 设计决策（行 850 附近）
   - 严重程度：一般
   - 改进建议：§3.10 补充 line 65 仓颉等价 `Quat.wxyz(...)` 或 `Quat(0,0,0,...)` 翻译路径；补充 line 78 `T Mag = T(std.math.pow(Float64(magnitude), Float64(y - T(1))))` 引用；D21 决策清单追加 line 65/78 翻译路径  ### 问题 6（来自诊断报告一般问题 6）
6. **问题描述**：§3.10 pow 描述「命名消歧与 Float64 转换」段使用「递归调用 `std.math.pow`」措辞不准确，GLM `quaternion_exponential.inl` line 65 与 line 78 是两次独立调用而非 pow self-call
   - 所在位置：§3.10 pow 函数描述「命名消歧与 Float64 转换」段（行 497 附近）
   - 严重程度：一般
   - 改进建议：将「递归调用 `std.math.pow(Float64, Float64): Float64`」修订为「**调用 `std.math.pow(Float64, Float64): Float64` 实数降级路径两次**（GLM line 65 + line 78）」  ### 问题 7（来自诊断报告一般问题 7）
7. **问题描述**：§1「Float32 与 std.math 的交互约束」段依据简化 README（`cangjie-std/math/README.md`）声明「std.math 数值函数仅支持 Float64 输入/输出」，但详细 API 文档（`cangjie-original-docs/std/math/math_package_api/math_package_funcs.md`）显示 `sqrt`/`sin`/`cos`/`tan`/`asin`/`acos`/`atan`/`sinh`/`cosh`/`tanh`/`asinh`/`acosh`/`atanh` 均提供 `Float16`/`Float32`/`Float64` 重载，`pow` 提供 `Float32`/`Float64` 重载；`radians`/`degrees` 在 std.math 中不存在
   - 所在位置：§1「Float32 与 std.math 的交互约束」段（行 54-63 附近）+ §3.13.1 trigonometric.cj 表头说明（行 598 附近）
   - 严重程度：一般
   - 改进建议：1. §1 修订为对 T = Float32 实例化场景优先调用 std.math Float32 重载；保留 T = Float64 实例化现状；新增 `radians`/`degrees` 硬编码 π 字面量路径风险提示   2. §3.13.1 表头说明同步修订，删除强制要求 `T(Float64.xxx(Float64(value)))` 转换模式，改为 Float32 重载优先 + 必要时 fallback 策略  ### 问题 8（来自诊断报告一般问题 8）
8. **问题描述**：§1 修订说明（v10）和 §3.10 多处声明「`FloatingPoint<T>` 接口本身无任何实例方法」，但 `cangjie-original-docs/std/math/math_package_api/math_package_interfaces.md` 第 3-15 行明确定义接口包含 `isInf()`/`isNaN()` 实例方法 + `getInf()`/`getMinDenormal()`/`getMinNormal()`/`getNaN()` 静态方法
   - 所在位置：§1 修订说明 v10 + §3.10 log/pow 依赖描述（行 496-497）+ D21「std::numeric_limits<T>::infinity() 等价物获取」段（行 850）+ §8 验证项 13/16/18（行 993-998）
   - 严重程度：一般
   - 改进建议：§1/§3.10/D21/§8 措辞修订为「`FloatingPoint<T>` 接口提供 `isInf()`/`isNaN()` 实例方法 + `getInf()`/`getMinDenormal()`/`getMinNormal()`/`getNaN()` 静态方法」，D21 决策依据同步修订

## 迭代第 7 轮

1. **问题描述**：`gtc/quaternion.cj` snake_case 函数名（`mat3_cast`/`mat4_cast`/`quat_cast`）与 `public import` 机制不兼容——`public import a.b.f` 仅重导出 f 原始名，不进行命名转换。下游按 §11.4 调用 `glm.gtc.quaternion.mat3_cast(q)` 将编译失败；实测 `cjglm/src/lib.cj:8` 现有 `public import glm.detail.{transpose, matrixCompMult, outerProduct}` 在 glm 顶层仍以原始 camelCase 名暴露，未发生 snake_case 转换。
   - 所在位置：§2 lib.cj/fwd.cj 段（约第 132 行）、§3.2.1 `mat3Cast`/`mat4Cast`/`quatCast` 函数签名定义（第 285-292 行）、§3.15 gtc/quaternion.cj 重导出函数段（第 708-712 行）、§10 覆盖矩阵 gtc/quaternion 表（第 1291-1294 行）、§11.4 迁移示例（第 1354-1355 行）
   - 严重程度：严重（直接阻塞下游编码落地）
   - 改进建议：三选其一——方案 A：在 `gtc/quaternion.cj` 中显式定义 wrapper 函数（保留 GLM snake_case 习惯，同时提供 gtc 端 camelCase 路径）；方案 B：detail 端函数名直接采用 snake_case（与 GLM 完全对齐，代价是 detail 端 API 偏离仓颉 camelCase 惯用命名）；方案 C：gtc 端采用 camelCase 命名与 detail 端一致，同步修订 §11.4 迁移示例与 §10 覆盖矩阵。
2. **问题描述**：`fwd.cj` 是自动生成文件（`cjglm/src/fwd.cj:1-2` 文件头注释明确标注），设计要求新增 9 个 type alias 但未说明实施路径（手动添加 vs 修改生成脚本），下游任何重新生成操作将覆盖手动修改，9 个别名全部丢失，且生成脚本位置、内容、修改方法未说明。
   - 所在位置：§2 lib.cj/fwd.cj 段（第 134-145 行）、§3.14 四元数别名文件（第 653-679 行）、§8 更新文件段（第 960 行）、§8.3 验收项 F（第 1119 行）
   - 严重程度：严重（直接阻塞下游编码落地，且无明确实施路径）
   - 改进建议：三选其一——方案 A（推荐）：明确说明修改 `tools/` 目录下生成 fwd.cj 的脚本，在 Quat 家族生成规则下新增 9 个 type alias，或在生成脚本中预留 manual_appendix 段；方案 B：将 Quat 家族别名从 `fwd.cj` 移至 `lib.cj`（作为 type alias 补充声明）；方案 C：新建独立手动维护文件 `cjglm/src/quaternion_aliases.cj`（`package glm`），在 `lib.cj` 中 `public import` 暴露到顶层 glm 命名空间。
3. **问题描述**：§3.13.1 trigonometric.cj 函数清单表行「内部依赖」列对 14 个单参数三角函数重复 14 次「std.math Float32 重载已支持」的相同说明；表头说「删除冗余 T 约束标注」但表行实际保留的是 Float32 重载说明（与表头论述话题不同）；§3.13.1 表后「Float32 实例化影响」段与 §1 v11 修订形成三重重复。设计内部表述冗余 + 修订未闭环，影响下游查阅效率与维护性。
   - 所在位置：§1 系统性设计约束段（第 54-69 行）、§3.13.1 表头（第 584 行）、§3.13.1 表行「内部依赖」列（第 586-597 行）、§3.13.1 表后「Float32 实例化影响」段（第 609 行）
   - 严重程度：严重（建议采纳质询报告问题 A 调整为一般，作为「v8 前修订前置项」）
   - 改进建议：§3.13.1 表行「内部依赖」列删除 14 行重复的长说明，统一替换为简短引用「见 §1 v11 修订 + §3.13.1 表后段」；§3.13.1 表后段删除与 §1 重复的 std.math 重载说明，仅保留 trigonometric.cj 自身实现策略；§3.13.1 表头修订为「T 约束统一在签名 where 子句；std.math Float32 重载支持详见 §1 + §3.13.1 表后段」。
4. **问题描述**：`gtc/matrix_transform.cj` 「仅函数签名空壳」的具体清单未明确——GLM 1.0.3 `glm/gtc/matrix_transform.hpp` 实际定义 20+ 函数，但设计未列出本阶段应包含哪些函数签名。下游实施存在三种解读（空文件 / 完整 20+ 函数 / 仅阶段四核心函数），每种解读对应不同的 cjpm 构建结果，且 §2 lib.cj 第 131 行 `import glm.gtc.matrix_transform` 依赖该文件存在可被 import 的对象。
   - 所在位置：§3.13 表格行（第 563 行）、§8 空桩占位段（第 946 行）、§8.3 验收项 A 覆盖矩阵（第 1065 行）、§2 lib.cj import 清单（第 131 行）
   - 严重程度：严重（下游实施存在多种可能解读，影响 cjpm 构建结果）
   - 改进建议：明确 `gtc/matrix_transform.cj` 的「函数签名空壳」具体清单——从 GLM 1.0.3 `gtc/matrix_transform.hpp` 抽取阶段四将完整实现的核心函数（建议 5-8 个），每个函数以 `public func <name><T, Q>(...): <R> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }` 形式声明；在 §8 空桩占位段补充「文件存在 + cjpm build 通过 + 至少 N 个 public func 签名声明」验收依据；在 §3.13 表格行补充「预计签名数：N」。
5. **问题描述**：§11.5 函数可用性对照表 gtc 重导出行的「约束继承自 detail 端实现，通过 public import ... 透明传递」表述与 §3.2.1 D32 决策存在归属歧义——`public import` 不改变函数名（与严重问题 1 同源），「透明传递」措辞本身依赖 gtc 端通过 wrapper 函数或命名一致才能成立；若按严重问题 1 方案 A 在 gtc 端定义 wrapper 函数，则 wrapper 函数本身的约束是「gtc 端独立声明」。
   - 所在位置：§11.5 函数可用性对照表 gtc 重导出行（第 1383 行）、§3.2.1 D32 设计决策（第 912 行）
   - 严重程度：一般（与严重问题 1 关联，在采纳严重问题 1 修复方案后该问题自然消除）
   - 改进建议：在采纳严重问题 1 方案 A 后，§11.5 gtc 重导出行约束标注修订为「约束：`where T <: FloatingPoint<T>`（D32），gtc 端 wrapper 函数独立声明，与 detail 端约束对齐」；在采纳方案 B/C 后，§11.5 gtc 重导出行约束标注修订为「约束：`where T <: FloatingPoint<T>`（D32，与 detail 端命名一致 + 透明传递）」。
6. **问题描述**：§3.7 normalize 函数末尾「实现策略（v11 补强）」段中 T(0)/T(1) 获取路径描述与 §1 系统性约束 v9 扩展「常量型 T(n) 字面量替代」策略存在冗余，未引用 §1 形成单一权威来源。
   - 所在位置：§3.7 normalize 函数末尾「实现策略（v11 补强）」段（第 459 行附近）、§1 系统性设计约束段 v9 函数清单（第 49-52 行）
   - 严重程度：一般（与严重问题 3 同类，文档冗余但不影响功能正确性）
   - 改进建议：§3.7 normalize 函数末尾「实现策略（v11 补强）」段精简为「T(0)/T(1) 获取遵循 §1 v9 扩展的『常量型 T(n) 字面量替代』策略（T(0) 通过 `one - one` 演算，T(1) 通过 `T(Float64(1))` 字面量替代，无 `one: T` 形参污染）」；在 §1 v9 函数清单中追加 normalize 函数，保持策略引用闭环。
7. **问题描述**：`quaternion_common.cj` 中 `conjugate` const func 适用性论断缺乏阶段二实践依据——未引用阶段二 Vec/Mat 中类似逐分量取反函数（`negative`/`negate`）已成功声明为 const func 的具体行号与文件；v5 修订在 §3.1 `@Derive[Hashable]` 实践依据段已引用具体文件与行号（200+ 处统一实践），但 §3.11 `conjugate` 未对应引用；附注「若仓颉 const 函数还有其他限制……则该论断需进一步评估」是不确定表述。
   - 所在位置：§3.11 `conjugate` 描述「const func 适用性」段（第 517 行附近）、§5.4 const 上下文约束段（第 862 行附近）
   - 严重程度：一般（缺乏实践依据但不影响功能正确性，下游可通过验证项兜底）
   - 改进建议：§3.11 `conjugate` 描述「const func 适用性」段补充「实践依据：阶段一 `type_vec3.cj:54-80` 中 `negative`/`negate` 逐分量取反函数已成功声明为 const func 并通过编译（grep 验证）」；§5.4 const 上下文约束段同步补充对应行号引用；§8 编码启动前验证项新增「`conjugate` const func 编译可行性验证」。
8. **问题描述**：§8.2 测试文件清单中 `test_ext_quaternion_aliases.cj` 「预计用例数 ≥4」与 9 个类型别名数量比例偏低——4 个 ext/ 别名文件共暴露 9 个类型别名（`quat`/`dquat` + 6 个精度变体），按 v8 修订「重导出函数每函数 ≥1 用例」原则应至少 9 个用例，实际仅 ≥4 用例，比例偏低约 56%。质询报告问题 B 指出论证存在轻微循环（v8 原则本身的合理性未论证）。
   - 所在位置：§8.2 测试文件清单表 `test_ext_quaternion_aliases.cj` 行（第 981 行）
   - 严重程度：一般（与 §8.2 测试设计可操作性相关，下游测试实施可能遗漏部分别名覆盖）
   - 改进建议：§8.2 表 `test_ext_quaternion_aliases.cj` 行「预计用例数」从 ≥4 修订为 ≥9（与 9 个类型别名一一对应）；§8.2 表注释补充「合并测试文件中每别名 ≥1 用例」；改进建议中保留「若 v8 原则本身待调整，则需先重新审视该原则」的灵活性。
9. **问题描述**：§3.4 Quat×Vec4 公式 `Vec4(q * Vec3(v), v.w)` 隐含要求仓颉 Vec4 主构造函数支持「`Vec4<T, Q>(Vec3<T, Q>, T)`」双参数版本，该签名在阶段二 Vec4 实现中是否存在、其泛型参数与 Quat×Vec4 操作的泛型参数是否一致未在 §3.4 中明确。
   - 所在位置：§3.4 Quat×Vec4 行备注列（第 374 行附近）
   - 严重程度：一般（可能影响下游实现路径选择，但不阻塞功能正确性）
   - 改进建议：§3.4 Quat×Vec4 行备注列补充「仓颉 Vec4 主构造函数签名约束：需支持 `Vec4<T, Q>(Vec3<T, Q>, T)` 双参数版本；若 Vec4 主构造仅支持四标量版本，则需先 `let v3 = Vec3<T, Q>(v.x, v.y, v.z); q * v3` 构造中间变量再调用 `Vec4<T, Q>(q * v3, v.w)`」；引用阶段二 `type_vec4.cj` 中 Vec4 主构造函数的具体签名行号验证与设计假设一致。
10. **问题描述**：设计文档总行数 1764 行，§修订说明章节占比 37.4%（660/1764），下游查阅效率受影响。质询报告问题 D 指出该问题属「统计行数」类型，与任务核心维度关系不大，建议精简或弱化描述。
   - 所在位置：§修订说明（v2）~§修订说明（v11），共 10 个章节
   - 严重程度：轻微（属于文档组织偏好，不影响设计正确性）
   - 改进建议：采纳质询报告建议，精简百分比统计描述，保留「将 §修订说明（v2）~§修订说明（v11）共 10 个章节拆分至独立附录文件」或「新增快速导航段列出 §1~§11 各章节锚点链接」的核心建议。
11. **问题描述**：§3.13.2 审计节中「本阶段实现但运行时受 stub 依赖影响」行的运行时行为契约与 §5.3 边界条件表存在内容重复，未引用 §5.3 形成单一权威来源。
   - 所在位置：§3.13.2 审计节（第 623-651 行）、§5.3 边界条件表（第 838-856 行）
   - 严重程度：轻微（信息冗余但不影响功能正确性）
   - 改进建议：§3.13.2 审计节每行「运行时行为契约」列末尾追加「完整边界行为契约详见 §5.3 边界条件表」引用；§5.3 边界条件表每行末尾追加「本阶段可调用性详见 §3.13.2 审计节」反向引用，形成双向闭环。
12. **问题描述**：§11.5 函数可用性对照表 gtc 重导出行使用 snake_case（`mat3_cast`/`mat4_cast`/`quat_cast`），顶层 glm 行使用 camelCase（`mat3Cast`/`mat4Cast`/`quatCast`），两处命名约定不一致。该问题根因与严重问题 1 相同。
   - 所在位置：§11.5 函数可用性对照表（第 1382-1383 行）
   - 严重程度：轻微（与严重问题 1 同源，采纳严重问题 1 修复方案后该问题自然消除）
   - 改进建议：在采纳严重问题 1 修复方案后，§11.5 对照表 gtc 重导出行与 detail 端 / glm 顶层行命名约定统一。
13. **问题描述**：§3.15 完整实现函数段 4 个比较函数 `where` 子句约束（`where T <: Comparable<T>, Q <: Qualifier`）仅在顶部描述，每个函数行未单独标注，下游阅读 §3.15 表格时需对照完整实现函数段才能获取约束，存在视觉跳转。质询报告问题 E 指出该问题属表格格式偏好，建议移除或合并。
   - 所在位置：§3.15 完整实现函数段（第 703-706 行）vs §3.15 表格行（第 690-691 行）
   - 严重程度：轻微（信息可获取但查阅路径分散）
   - 改进建议：采纳质询报告建议，移除该问题或合并到一般问题 5（§11.5 约束归属）的反向延伸讨论中。
14. **问题描述**：§8.3 验收项 C 覆盖矩阵表 `gtc/matrix_transform.hpp` 行「函数总数」「本阶段实现」「本阶段 stub」三列未给出具体数字，四列均为「全部」措辞，下游按 §8.3 验收时无法核验实际 stub 函数数量与设计声称值是否一致。该问题与严重问题 4 同源但表现于验收矩阵格式不一致。
   - 所在位置：§8.3 验收项 C 覆盖矩阵表 `gtc/matrix_transform.hpp` 行（第 1095 行）
   - 严重程度：轻微（与严重问题 4 同源但表现于验收矩阵的格式不一致）
   - 改进建议：在采纳严重问题 4 修复方案后，§8.3 表 `gtc/matrix_transform.hpp` 行补充具体数字（预计签名数 / 本阶段 stub / 阶段四补齐），或在该行增加「函数总数待 §3.13 表格明确后填入」占位说明。

## 迭代第 8 轮

1. **问题描述**：§2 lib.cj 第 131 行引用错误——设计文档多处引用「lib.cj 第 131 行 `import glm.gtc.matrix_transform`」，但实际 `cjglm/src/lib.cj` 仅 8 行，第 131 行不存在
   - 所在位置：§2「lib.cj 新增 import 清单」段（约第 113-132 行）；§3.13 `gtc/matrix_transform.cj` 函数清单段（约第 564/579 行）；§3.13「下游实施约束」段（第 583 行）
   - 严重程度：严重
   - 改进建议：全文替换「lib.cj 第 131 行」为「lib.cj 第 9 行追加」等准确表述；§3.13 验收条件同步修订；新增对 `cjglm/src/lib.cj` 实际行数（8 行）的明确声明
2. **问题描述**：§3.13 `gtc/matrix_transform.cj` 函数清单与 GLM 1.0.3 实际严重偏差——实际通过 `gtc/matrix_transform.hpp` 暴露约 64 个函数（11 + 46 + 7），设计文档声称 35 个，偏差 29 个遗漏 + 5 个虚构函数
   - 所在位置：§3.13 表格下「`gtc/matrix_transform.cj` 函数清单（v12 新增）」段（约第 568-579 行）；§10 覆盖矩阵 gtc/matrix_transform 表（第 1307-1311 行）；§8.3 验收项 C 覆盖矩阵表（第 1108-1121 行）
   - 严重程度：严重
   - 改进建议：函数清单修订为基于实际 GLM 1.0.3 源码核查的 64 个函数完整列表；删除虚构的 `scaleAlongAxis` 与 4 个 `tweakedInfinitePerspectiveLH/RH/NO/ZO` 变体；明确 `matrixCompMult` 实际定义在 `glm/detail/func_matrix.inl`；§10 + §8.3 覆盖矩阵表「函数总数」从 35 修订为 64
3. **问题描述**：§2 lib.cj/fwd.cj 段落「实施路径」段称生成脚本位于 `tools/gen_fwd.cj`，实际位于 `cjglm/scripts/gen_fwd_aliases.py`（Python 脚本，64 行）；且 `cjglm/` 下不存在 `tools/` 目录
   - 所在位置：§2 lib.cj/fwd.cj 段落「实施路径」段（第 146 行附近）；§8 更新文件段「fwd.cj」（第 984 行）；§8 编码启动前验证项 23（第 1078 行）；§11.6 四命名空间接口可达性矩阵（第 1438 行）
   - 严重程度：严重
   - 改进建议：全文替换 `tools/gen_fwd.cj` 为 `scripts/gen_fwd_aliases.py`；§2 实施路径段修订为修改 `VEC_FAMILIES` 字典并新增 Quat 家族特殊处理分支；§8 验证项 23 同步修订
4. **问题描述**：v12 修订说明多处引用 `cjglm/src/fwd.cj:1-2` 文件头「Auto-generated file. Do not edit!」字样，实际为中文「此文件由脚本自动生成，手动修改请谨慎」注释
   - 所在位置：修订日期段（第 4 行）；§修订说明（v12）问题 2 行（第 1834 行）；§2 lib.cj/fwd.cj 段落「实施路径」段（第 146 行附近）
   - 严重程度：严重
   - 改进建议：全文替换「Auto-generated file. Do not edit!」为「此文件由脚本自动生成，手动修改请谨慎」准确引用；补充对「谨慎修改」措辞的实际约束解读
5. **问题描述**：§3.3 item 8 与 §5.3 边界条件表将 `fromVec3` 退化路径引用为 `ext/quaternion_common.inl:196-217`，实际为 `detail/type_quat.inl:196-217`；触发条件描述（`dot ≈ -1`）与实际（`real_part < 1e-6f * norm_u_norm_v`）不一致；「任意轴」描述不准确（GLM 实际是选择「与 u 垂直的两条可能轴之一」）
   - 所在位置：§3.3 item 8（约第 356 行）；§5.3 边界条件表「u, v 反平行」行（约第 877 行）；§9 差异声明对应条目
   - 严重程度：严重
   - 改进建议：所有 `ext/quaternion_common.inl:196-217` 引用修订为 `detail/type_quat.inl:196-217`；触发条件说明修订为「`dot(u,v) < 1e-6 * sqrt(dot(u,u) * dot(v,v))`」；明确轴选择逻辑（`abs(u.x) > abs(u.z)` 条件分支）；§9 差异声明同步修订
6. **问题描述**：§3.7 normalize 函数末尾「T(0)/T(1) 获取路径」段 + §3.13.2 审计节 normalize 行 + §11.6 四命名空间可达性矩阵 normalize 行三处描述存在功能重叠，未形成单一权威来源的引用关系
   - 所在位置：§3.7 normalize 函数末尾；§3.13.2 审计节 normalize 行；§11.6 四命名空间接口可达性矩阵 normalize 行
   - 严重程度：一般
   - 改进建议：§3.7 末尾新增「完整契约详见 §5.3 边界条件表 normalize 行」引用；§3.13.2 与 §11.6 同步新增反向引用
7. **问题描述**：§修订说明（v12）问题 1 描述仍存在「snake_case 命名约定」原始问题措辞，与已采纳的方案 C（camelCase 命名）相距较远
   - 所在位置：§修订说明（v12）问题 1 行（第 1833 行）
   - 严重程度：轻微
   - 改进建议：问题 1 末尾补充「采纳方案 C 后，下游按 GLM snake_case 习惯调用 `glm.gtc.quaternion.mat3_cast(q)` 仍会编译失败」说明
8. **问题描述**：§11.5 函数可用性对照表未纳入 §3.13/§10 中 35 个 gtc/matrix_transform 函数，下游消费者查阅 gtc 命名空间下函数可用性时无法从 §11.5 获取完整视图
   - 所在位置：§11.5 函数可用性对照表（约第 1389-1410 行）
   - 严重程度：轻微
   - 改进建议：§11.5 新增 gtc/matrix_transform 区块，列出 35（或实际 64）个函数均为 `❌ stub` 状态；或新增「§11.5 函数可用性对照表覆盖范围说明」段

## 迭代第 9 轮

1. **问题描述**：§3.2 策略段落与 §3.15 表格/v3 修订说明对 4 个欧拉函数（eulerAngles/roll/pitch/yaw）的实现状态自相矛盾（完整实现 vs stub 占位）
   - 所在位置：§3.2「本阶段对 gtc/quaternion 函数的处理策略」段落（约第 313-315 行）vs §3.15 职责分组表（约第 719-724 行）+ §3.15 v3 修订说明（约第 726-732 行）
   - 严重程度：严重
   - 改进建议：§3.2 策略段落修订为与 §3.15 一致的 stub 占位分类，删除「本文件完整实现（8 个）」中的欧拉函数行，重构策略段为「完整实现（4 个）+ stub 占位（7 个）+ 从 detail 重导出（4 个）」，删除过时附注
2. **问题描述**：`normalize(q)` 零四元数保护分支中 T(0) 通过 `one - one` 演算获取，但函数签名不含 `one: T` 形参，信息链不可闭环
   - 所在位置：§3.7 normalize 函数描述（约第 461 行）、§5.3 边界条件表 normalize 行（约第 876 行）、§1「系统性设计约束」（约第 46-48 行）
   - 严重程度：严重
   - 改进建议：(A) 签名加 `one: T` 形参，或 (B) 零保护分支 T(0) 改用 `T(Float64(0))` 字面量替代路径，§1/§3.7/§5.3 同步修订
3. **问题描述**：ortho 系族函数数 9 应为 10，遗漏 `ortho(T left, T right, T bottom, T top, T zNear, T zFar)` 3D 版本
   - 所在位置：§3.13 函数清单「视口与裁剪空间（ortho 系族）」行（约第 580 行）、合计行（约第 588 行）
   - 严重程度：严重
   - 改进建议：ortho 系族从 9 个修订为 10 个，补充 3D ortho 一般版本，§10/§8.3/§11.5 对应位置同步修订
4. **问题描述**：`mat3Cast`/`mat4Cast` 的 T(1) 初始化路径未明确选择（单参数构造 vs 逐元素填充），两种路径签名约束不同
   - 所在位置：§3.2.1 T(1) 字面量获取策略段（约第 301-304 行）、§3.2.1 签名模板（约第 290-293 行）
   - 严重程度：严重
   - 改进建议：明确选择一种初始化路径：核验阶段二 Mat3x3/Mat4x4 是否提供单标量参数构造函数后决定使用构造函数还是逐元素填充，删除歧义表述
5. **问题描述**：§1 字面量替代函数清单遗漏 `normalize` 零保护分支 T(0) 场景（若问题 2 采纳方案 B 时需补充）
   - 所在位置：§1「系统性设计约束」「常量型 T(n) 字面量替代」段落（约第 49-52 行）
   - 严重程度：一般
   - 改进建议：若问题 2 采纳方案 B，§1 函数清单追加 `normalize` 并扩展 T(0) 字面量替代覆盖范围
6. **问题描述**：比较函数使用 `Comparable<T>` 而非统一 `FloatingPoint<T>` 约束，缺乏设计决策依据
   - 所在位置：§3.15 完整实现函数段（约第 734-740 行）、§11.5 比较函数行（约第 1420 行）
   - 严重程度：一般
   - 改进建议：新增设计决策条目，明确比较函数采用 `Comparable<T>` 宽约束的理由（GLM 无 is_iec559 断言、整数类型语义正确、与浮点专用函数区分）
7. **问题描述**：§3.13.2 审计表未纳入 gtc/matrix_transform.cj 64 个 stub 函数，审计结论函数数量 14 实际应为 78
   - 所在位置：§3.13.2 审计表（约第 659-677 行）、审计结论行（约第 680-681 行）
   - 严重程度：一般
   - 改进建议：审计表新增 gtc/matrix_transform.cj 64 个函数行，审计结论 stub 数量修订为 78

## 迭代第 10 轮

1. **问题描述**：文档结构使下游无法直接实施——"考古式阅读"模式，累积修订附录与原文分离，真理分散在13个修订章节中
   - 所在位置：全文结构性问题，尤其 §1~§11 正文与 §修订说明(v2)~§修订说明(v14) 的分离
   - 严重程度：严重
   - 改进建议：将 §修订说明(v2)~(v14) 剥离至独立文件，重写 §1~§11 正文，将 v2~v14 所有修订的最终结果直接写入原文
2. **问题描述**：`T(Float64(n))` 字面量替代路径的核心假设未经验证——声称对所有 `T <: Number<T>` 编译可行，但仓颉编译器是否支持此语法未经任何编译验证
   - 所在位置：§1"系统性设计约束"段、§3.7 normalize、§3.9 axis、§3.2.1 mat3Cast/mat4Cast、§3.4 Quat×Vec3/Quat×Vec4、§5.1、§5.3
   - 严重程度：严重
   - 改进建议：新增最高优先级验证项验证 `T(Float64(0))`/`T(Float64(1))` 对 Int8~Int64/UInt8~UInt64/Float32/Float64 的编译可行性；验证通过前所有依赖此路径的函数标注"待验证"
3. **问题描述**：mat3Cast/mat4Cast 逐元素填充模式依赖 Mat4x4 `[]` operator 的 mutable 返回，未经验证
   - 所在位置：§3.2.1"T(1)/T(0) 字面量获取与矩阵初始化策略"段、§3.13 gtc/matrix_transform.cj 函数清单段
   - 严重程度：一般
   - 改进建议：新增验证项验证 Mat4x4 `[]` 运算符返回类型为可赋值引用；若不可赋值则改用 Vec4 构造路径
4. **问题描述**：fromMat4 中 `m.c0`/`m.c1`/`m.c2` 列名引用未经验证——Mat4x4 数据成员命名是否确为 `.c0`/`.c1`/`.c2`/`.c3` 取决于阶段二实现
   - 所在位置：§3.3 item 7
   - 严重程度：一般
   - 改进建议：新增验证项确认 Mat4x4 公共数据字段名是否与设计一致，并修订 §3.3 与实际命名对齐
5. **问题描述**：函数实现状态的跟踪散落在 6+ 个位置（§1/§3.2/§3.15/§8/§10/§11.5/§11.6），维护成本极高，迭代历史表明每轮审查都能发现不一致
   - 所在位置：§1 核心抽象表、§3.2 策略段落、§3.15 职责分组表、§8 产出物清单、§10 覆盖矩阵、§11.5 函数可用性对照表、§11.6 可达性矩阵
   - 严重程度：一般
   - 改进建议：选取一个位置作为单一权威来源（建议 §11.5），其余位置仅用引用，不再独立列出完整清单
6. **问题描述**：§3.4 Quat×Vec3/Quat×Vec4 公式中的 Vec4 构造依赖未充分验证——Vec4<T,Q>(Vec3<T,Q>, T) 双参数版本是否在所有 6 个 Qualifier 变体上均可用
   - 所在位置：§3.4 Quat×Vec4 行备注列
   - 严重程度：一般
   - 改进建议：新增验证项验证双参数构造在所有 6 个 Qualifier 变体上均编译通过
7. **问题描述**：`identity(one: T)` 中 T(0) 通过 `one - one` 演算，但 T 为无符号类型时溢出语义依赖未显式声明
   - 所在位置：§3.3 item 5 `identity(one: T)` 描述
   - 严重程度：一般
   - 改进建议：补充说明 `one - one` 演算在无符号整数类型上依赖模 2^n 溢出语义；或统一采纳 `T(Float64(0))` 路径
8. **问题描述**：`fromVec3` 反平行退化分支的轴选择逻辑描述与实际 GLM 仍存在偏差——缺少 `normalize(t)` 归一化步骤
   - 所在位置：§3.3 item 8（第 357 行附近）、§5.3 边界条件表"u, v 反平行"行
   - 严重程度：一般
   - 改进建议：§3.3 item 8 和 §5.3 边界条件表补充 `normalize(t)` 归一化步骤
9. **问题描述**：文档自身版本号混乱——文件名为 v10，文档头声称 v14
   - 所在位置：文档头部（第 4 行）、文件名
   - 严重程度：轻微
   - 改进建议：统一版本号，建立命名约定避免双轨制
10. **问题描述**：§5.3 边界条件表缺少"std.math 函数在整型 T 实例化时的行为"条目
   - 所在位置：§5.3 边界条件表
   - 严重程度：轻微
   - 改进建议：新增一行覆盖整型 T 调用 `FloatingPoint<T>` 约束函数时的行为契约

## 迭代第 11 轮

1. **问题描述**：§3.7 `length` 函数依赖描述与§1自相矛盾，保留v11修订前的错误描述
   - 所在位置：§3.7 `length` 函数描述（行461）
   - 严重程度：严重
   - 改进建议：同步§1 v11修订，删除「仅支持Float64」错误描述
2. **问题描述**：§3.9 `axis` 函数依赖描述引用已废弃的Float64转换模式
   - 所在位置：§3.9 `axis` 函数依赖描述（行491附近）
   - 严重程度：严重
   - 改进建议：删除「统一使用T(Float64.xxx(Float64(value)))」旧策略引用，与§1方案A保持一致
3. **问题描述**：§3.7 `length` 函数同一段落内存在自相矛盾的描述
   - 所在位置：§3.7 `length` 函数描述（行461）
   - 严重程度：严重
   - 改进建议：统一为「std.math.sqrt提供Float16/Float32/Float64重载」表述
4. **问题描述**：`gtc/matrix_transform.cj`的64个stub函数无对应测试文件
   - 所在位置：§8.2测试文件清单表（行1007-1022）
   - 严重程度：一般
   - 改进建议：新增测试文件覆盖64个stub函数
5. **问题描述**：§8.2用例计算中使用snake_case命名，与§3.2.1/D11确定的camelCase命名矛盾
   - 所在位置：§8.2（行1040-1043）
   - 严重程度：一般
   - 改进建议：统一修订为camelCase形式
6. **问题描述**：`FloatingPoint<T>`接口方法可用性标为未经验证，但无闭环计划
   - 所在位置：§8编码启动前验证项20（行1089）
   - 严重程度：一般
   - 改进建议：新增高优先级验证子节，编写最小仓颉测试文件确认编译通过
7. **问题描述**：测试策略缺少「已实现但被stub阻塞」函数类别的覆盖定义
   - 所在位置：§8.2「测试覆盖维度」段（行1047-1053）
   - 严重程度：一般
   - 改进建议：新增第8类覆盖要求，含编译期+运行时assertThrows测试

## 迭代第 12 轮

1. **问题描述**：§11.5 函数可用性对照表缺失3组关键函数条目（`scalar_quat_ops.cj`的4个全局函数、`ext/quaternion_transform.cj`的`rotate`函数、Vec3×Quat/Vec4×Quat运算符`v*q`）
   - 所在位置：§11.5 行1420-1441
   - 严重程度：一般
   - 改进建议：补充缺失的7个函数至§11.5表，按⚠️/❌/✅三档标注状态；在表头补充范围边界声明；新增编码后验证项确保无遗漏
2. **问题描述**：`fromMat3`/`fromMat4`工厂函数未声明`FloatingPoint<T>`约束传递性，整数类型T实例化时因内部调用`quatCast`导致编译失败
   - 所在位置：§3.3 item 6/7（行354-356）、§11.5（行1423）
   - 严重程度：一般
   - 改进建议：在§3.3 item 6/7函数描述末尾追加约束传递性声明；在§11.5对应行补充约束注记
3. **问题描述**：`rotate`函数（`ext/quaternion_transform.cj`）的状态信息散布于§3.8、§8、§8.2、§10、§11.5、§11.6多处，§11.5缺失该函数，下游无法一次性获取完整状态画像
   - 所在位置：§3.8行479、§8行978、§8.2行1016、§10行1308-1310、§11.5行1420-1441、§11.6行1449-1466
   - 严重程度：一般
   - 改进建议：(a)§11.5补充`rotate`行（❌ stub）；(b)§11.6补充`rotate`行；(c)§8.2测试文件备注补充"仅测试stub异常路径"
4. **问题描述**：§3.9 `axis`公式使用`T(std.math.sqrt(Float64(tmp1)))`显式转换，与§1方案A"直接调用、无需转换"的描述矛盾
   - 所在位置：§3.9行491
   - 严重程度：轻微
   - 改进建议：将公式修改为`T(std.math.sqrt(tmp1))`或加注防御性转换说明
5. **问题描述**：§8验证项20与29、25与30内容重复，宣称30项但仅覆盖28个独立验证目标
   - 所在位置：§8行1084、1088、1096、1105、1107
   - 严重程度：轻微
   - 改进建议：删除被继承项，顺移至28项，保持"一项验证一个目标"
6. **问题描述**：§8.2约15个测试用例无法追溯分配依据，用例到函数的逐项映射缺失
   - 所在位置：§8.2行1007-1023、行1035-1038
   - 严重程度：轻微
   - 改进建议：为每个测试文件补充用例分配合计列，将剩余用例明确归因

## 迭代第 13 轮

1. **问题描述**：设计擅自决定修改路线图而未寻求对齐，slerp/angleAxis标注与路线图预期偏差大
   - 所在位置：§3.16（第772-796行）
   - 严重程度：严重
   - 改进建议：删除单方面修订论断，改写为待确认状态标注；增加替代路径可行性讨论
2. **问题描述**：函数实现状态在三章中使用三套互不兼容的分类体系，下游难以确定实际可用状态
   - 所在位置：§8（第954-995行）、§3.13.2（第656-686行）、§11.5（第1456-1488行）
   - 严重程度：一般
   - 改进建议：统一为三档分类（✅/⚠️/❌），对齐§11.5为最终基准
3. **问题描述**：25+源文件的实施顺序缺失，开发者无从下手
   - 所在位置：§8 产出物清单（第954-995行）及编码启动前验证项（第1110-1148行）
   - 严重程度：一般
   - 改进建议：新增§8.4实施批次建议，按拓扑依赖排序给出3~4批

## 迭代第 14 轮

1. **问题描述**：§8 产出物分类说明文字声称「不抛 Exception("stub")」，但 `detail/type_quat.cj` 包含 Quat×Vec3 和 Quat×Vec4 两个 ⚠️ 运算符，调用将抛 `Exception("stub")`
   - 所在位置：§8 第 977 行
   - 严重程度：严重
   - 改进建议：将说明文字修订为「以上文件中标记为 ✅ 的函数均为真完整实现……」或将 `detail/type_quat.cj` 从 ✅ 分类移至 ⚠️/❌ 混合分类
2. **问题描述**：版本号体系存在 v13↔v14↔v15↔v16 四重矛盾，文件名暗示 v14，文件头部称 v16，§修订说明称 v15 或 v13，设计决策无法追溯
   - 所在位置：文件头（行3-4）、§修订说明(v15)（行1557）、§修订说明(v13)（行1611）
   - 严重程度：严重
   - 改进建议：建立单一版本号序列，文件名、文件头、修订说明引用均使用同一版本号，确保§修订说明(vN)的定位描述与文件名 vN 一致
3. **问题描述**：§3.13.2 审计表仅 14 行，缺少 `dot`/`cross(Quat)`/`equal(Quat)`/`notEqual(Quat)` 共 4 个函数的独立行，审计结论声称 18 个真完整实现但表中仅有 14 行
   - 所在位置：§3.13.2 审计表（行 662-679）、审计结论（行 683）
   - 严重程度：一般
   - 改进建议：在审计表中新增 4 行，分别列出缺失函数，标注为 ✅ 可用、无 stub 依赖
4. **问题描述**：`lerp` 和 `inverse` 的单一签名模板限定 x 与 y 的 Qualifier 固定为同一 Q，未定义跨 Qualifier 调用（如 Highp vs PackedHighp）的编译期行为
   - 所在位置：§3.11 `lerp` 描述（行 524）、`inverse` 描述（行 521-523）
   - 严重程度：一般
   - 改进建议：在 §3.11 新增跨 Qualifier 行为说明，明确是否提供跨 Qualifier 重载，建议新增设计决策 D34
5. **问题描述**：§8.2 测试用例计数 ≥199 的构成中，两个文件的 ≥ 下限值与分配表小计差值合计 7，设计称「增补 5 个用例可达 ≥199」但与 7 的差值矛盾
   - 所在位置：§8.2 测试文件清单表（行 1013-1029）与用例分配表（行 1056-1088）
   - 严重程度：一般
   - 改进建议：二选一——(a) 将上方 ≥ 值修正为与分配表一致（13 和 4），核算合计为 ≥194；(b) 补齐分配表差值至 ≥16 和 ≥8，使合计 ≥199 成立
6. **问题描述**：两项 P0 核心假设——`T(Float64(n))` 语法编译可行性和 `FloatingPoint<T>` 提供 `getMinDenormal()`/`getInf()` 等静态方法——验证失败将导致大面积设计失效，但全文未提供任何回退方案或 B 计划
   - 所在位置：§8 编码启动前验证项 20（行 1158）与 25（行 1163）
   - 严重程度：严重
   - 改进建议：在 §1「系统性设计约束」段末尾新增「回退方案」子节，为每条回退路径标注影响范围和备用实现策略的决策树
7. **问题描述**：D21 决策的 `pow` 依赖叙述体量巨大（单行超 2000 字符被截断），与 §3.10 和 §1 高度重复，包含对已过时版本（v10）错误的逐行修正追溯，维护负担极大
   - 所在位置：§7 D21 设计决策（行 944-945）、§3.10 `pow` 依赖描述（行 506-509）
   - 严重程度：一般
   - 改进建议：精简 D21 决策中 `pow` 依赖的描述体量，移除对 v10 错误的修正追溯，仅保留最终结论并引用 §3.10 和 §1 作为单一权威来源

## 迭代第 15 轮

1. **问题描述**：版本号体系未彻底修复，文档标题声明为v15但正文≥11处标注为「v16修订」或「v16新增」，§修订说明(v15)问题2声称已统一但未实际修改
   - 所在位置：文档头部行3-4、§3.3 item 6-7（行382/384）、§3.13.2（行687）、§3.16（行807）、§8（行994）、§8.4（行1150）、§8.3（行1214/1233）、§10（行1326）、§11.5（行1519/1528）、§修订说明(v15)问题2（行1598）
   - 严重程度：严重
   - 改进建议：全文搜索并替换「v16 修订」和「v16 新增」为「v15 修订」；建立核验机制在版本发布前用 `grep -n "v[0-9]"` 检查一致性
2. **问题描述**：§3.13.2声明18个真完整实现函数，§8声明20个，根因为quatCast计数口径差异，且按§8口径实际仅列19个
   - 所在位置：§3.13.2审计结论（行716）、§8产出物清单 ✅ 可用说明（行1010）
   - 严重程度：一般
   - 改进建议：统一计数口径并在全文档一致使用；补齐或修正§8行1010的函数计数；同步修订§8.3验收项A表计数
3. **问题描述**：§3.16列出设计与路线图的三项不一致但无裁定时限、默认实施策略和影响评估，下游编码者将在slerp等决策点上停滞
   - 所在位置：§3.16需求对齐说明（行807-835）
   - 严重程度：一般
   - 改进建议：补充临时实施建议；补充工期影响评估；或将不一致升级为正式设计决策

## 迭代第 16 轮

1. **问题描述**：§11.5 权威对照表遗漏 4 个「真完整实现」函数（axis(q)、cross(Quat,Quat)、equal(Quat)/notEqual(Quat) 共 4 个重载）
   - 所在位置：§11.5 函数可用性对照表（行 1534-1559）
   - 严重程度：严重
   - 改进建议：在 §11.5 表中补充 4 行，同步核查 §8.3 验收项 D 对 §11.5 的引用
2. **问题描述**：§8.2 测试文件清单合计（≥194）与逐项累加（192）不一致，且文件清单（40）与分配表（42）使用不同基准值
   - 所在位置：§8.2 测试文件清单表（行 1072）与用例到函数分配依据表（行 1131）
   - 严重程度：严重
   - 改进建议：统一两表基准值—(a) 文件清单 `test_type_quat.cj` ≥40→≥42，合计 ≥196；或 (b) 分配表 42→40，合计 192，同步调整备注
3. **问题描述**：gtc/matrix_transform 64 个 stub 函数测试覆盖原则（≥1 用例/函数）与实施（仅 8 个用例）不一致，抽样策略未声明
   - 所在位置：§8.2 用例分配原则（行 1085）与分配依据表（行 1130）
   - 严重程度：一般
   - 改进建议：新增抽样策略说明，明确分组覆盖条件及抽样率；或修订分配原则以匹配实际策略
4. **问题描述**：§11.5 表函数分组粒度不统一（合并行 vs 单行），且行名未覆盖全部函数（如 cross 隐含缺失），影响「权威来源」可查阅性
   - 所在位置：§11.5 函数可用性对照表（行 1534-1559）
   - 严重程度：一般
   - 改进建议：将分组行改为显式枚举（如 `dot/length/normalize/cross`），或拆分为逐函数行的完整表

## 迭代第 17 轮

1. **问题描述**：`glm.detail` 包对 `glm.ext` 的依赖声明构成潜在包间循环依赖，未经实现验证
   - 所在位置：§2 模块间依赖图（行 208、217）
   - 严重程度：严重
   - 改进建议：在 §8 编码启动前验证项中新增跨包导入可行性验证项；逐项核查 `type_quat.cj` 各函数是否实际需要 `glm.ext` 符号；若不需要则删除依赖声明；若需要则重新设计包结构
2. **问题描述**：v17 修订说明声称的 6 项修复多处未实际落实到正文，修复闭环不完整（修订说明排序仍乱、验收项 B 数字仍为 ≥199）
   - 所在位置：§修订说明（行 1639-1730）、§8.3 验收项 B（行 1240）
   - 严重程度：严重
   - 改进建议：按版本号升序重排修订说明；将验收项 B 数量列修正为 ≥192；建立发布前核验机制
3. **问题描述**：Vec3×Quat/Vec4×Quat 运算符的定义位置未明确
   - 所在位置：§3.4（行 415-420）
   - 严重程度：一般
   - 改进建议：在 §3.4 表后新增定义位置说明行；若定义在 `glm.detail` 层需同步验证跨包导入可行性
4. **问题描述**：编码启动前验证项缺少验证失败后的快速修复指引
   - 所在位置：§8 编码启动前验证项 1-28（行 1184-1211）
   - 严重程度：一般
   - 改进建议：在 §1 回退方案子节的每条路径后补充影响章节清单，或在 §8 验证项末尾补充标准格式的受影响章节清单

## 迭代第 18 轮

1. **问题描述**：§10 覆盖矩阵合计行计数声明 80 个 ❌/⚠️，逐行统计实际为 88 个，偏差 8 个（~10%），且历经多个迭代版本未修复
   - 所在位置：§10 覆盖矩阵合计行（行 1299）
   - 严重程度：严重
   - 改进建议：将合计行修订为「87 个 ❌ + 1 个 ⚠️ = 88 个 ⚠️/❌」；全文档 grep 同步修正所有引用位置；在 §8.3 新增自动化核验项
2. **问题描述**：§8.2 用例分配表 test_ext_quaternion_trigonometric.cj 小计行附注引用已废弃的 ≥8 下限，与当前文件清单表的 ≥4 下限自相矛盾
   - 所在位置：§8.2 用例到函数的逐项分配依据表（行 1118）
   - 严重程度：一般
   - 改进建议：删除或修正附注，与文件清单表下限一致
3. **问题描述**：§2 gen_fwd_aliases.py 修改指南仅有高层思路，缺少代码片段、污染规避逻辑、输出验证标准和测试策略
   - 所在位置：§2 lib.cj/fwd.cj 段落（行 165-177）
   - 严重程度：严重
   - 改进建议：补充 (a) 现有代码上下文片段；(b) 修改后的完整 Python 代码（含 QUAT_FAMILIES 独立列表）；(c) grep 验证命令；(d) 幂等性验证方案
4. **问题描述**：§3.16 正文仍以「⚠️ 待确认」标题和过渡性措辞描述 D35-D37 三项已决策内容，与 §7 决策表不一致
   - 所在位置：§3.16 需求对齐说明（行 806-840）
   - 严重程度：一般
   - 改进建议：将标题改为「✅ D{N} 已决策」；删除「待确认」等过渡性措辞；保留替代路径作为历史选项存档
5. **问题描述**：§3.3 item 5 identity 函数使用 one - one 演算获取 T(0)，与 §1「T(Float64(0)) 统一替代」策略存在未声明的偏差
   - 所在位置：§3.3 item 5（行 375-379）、§1 系统性设计约束段（行 46-47）
   - 严重程度：一般
   - 改进建议：在 §3.3 item 5 末尾追加明确关联，标注为 §1 统一策略的刻意例外
6. **问题描述**：§3.13.1 三角函数表 radians/degrees 行的「内部依赖」列残留公式实现细节，实现策略分散在表行、表上段、§1 三处
   - 所在位置：§3.13.1 三角函数表 radians/degrees 行（行 659-660）
   - 严重程度：一般
   - 改进建议：表行删除重复公式，替换为交叉引用；表下段追加与 §3.12 pi<T>() 的 π 值一致性交叉引用
7. **问题描述**：§8 验证项 27 fromMat4 列字段名验证失败修复指引未区分设计和编码修复归属
   - 所在位置：§8 编码启动前验证项 27（行 1209）、映射表（行 1217-1245）
   - 严重程度：轻微
   - 改进建议：映射表标注修复归属标签（设计者/编码者）

## 迭代第 19 轮

1. **问题描述**：§11.5 函数可用性对照表自称"单一权威来源"，但缺失 `wxyz`、`fromQuat`、`[]` 下标运算符、`static func length(): Int64`、复合赋值运算符 `+=`/`-=`/`*=`/`/=` 共 5 个条目的阶段三可用 API 标记
   - 所在位置：§11.5 函数可用性对照表（行 1637-1699）
   - 严重程度：严重
   - 改进建议：将缺失条目补齐至 §11.5 表，确保 §11.5 函数行总数与 §10 覆盖矩阵一致

2. **问题描述**：§3.13.2 审计结论的 78 个 stub 计数与 §10 覆盖矩阵合计行的 88 个 ⚠️/❌ 存在 10 个差值，口径不一致
   - 所在位置：§3.13.2 审计结论（行 776-778）与 §10 覆盖矩阵合计行（行 1358）
   - 严重程度：一般
   - 改进建议：新增计数口径映射表，将 §10 的 13 个头文件 ✅/⚠️/❌ 映射到 §3.13.2 的三类分类；修订 §3.13.2 中的 78 为与 §10 对齐的 88

3. **问题描述**：§8 编码启动前验证项 20 对 `FloatingPoint<T>` 接口方法的依赖自 v11 轮核实后未重新核验，跨度 8 个迭代版本
   - 所在位置：§8 编码启动前验证项 20（行 1261）
   - 严重程度：一般
   - 改进建议：补充 Cangjie stdlib 版本号记录，在执行 P0 验证前用最小测试文件确认 `FloatingPoint<T>` 实际 API 形态

4. **问题描述**：§11.5 自称"单一权威来源"但缺失条目导致下游消费者无法依赖此入口获得完整阶段三 API 可用性视图
   - 所在位置：§11.5 函数可用性对照表（行 1631-1633 权威声明 + 行 1637-1699 表内容）
   - 严重程度：一般
   - 改进建议：三选一或组合执行——(a) 修正"单一权威来源"声明为"主入口，§10 覆盖矩阵作为补充"；(b) 补齐缺失条目（同问题 1）；(c) 在 §8.3 H 节新增 §11.5 与 §10 交叉验证核验项

## 迭代第 20 轮

1. **问题描述**：缺少对 GLM 1.0.3 stage 3 API 范围的系统性覆盖声明确认
   - 所在位置：§10 覆盖矩阵全文、§3.16 需求对齐说明段
   - 严重程度：严重
   - 改进建议：在 §10 覆盖矩阵前方新增「GLM 1.0.3 stage 3 API 基准声明」段——列出 GLM 1.0.3 中与 stage 3 直接相关的所有头文件及每个头文件的函数总数，然后与本设计的覆盖状态做逐项对比。对确认为「本阶段不覆盖」的函数，标注推迟至 stage 4 的理由。

2. **问题描述**：§8.3 与 §11.5 权威声明矛盾历经 8 个迭代版本未闭环修复
   - 所在位置：§8.3 D 节第 1362 行（「权威基准」）vs §11.5 首段第 1633 行（「主要参考来源」）
   - 严重程度：严重
   - 改进建议：将 §8.3 第 1362 行同步降级为「主要参考基准」，与 §11.5 措辞一致，并注明补齐后升级计划。

3. **问题描述**：gen_fwd_aliases.py 验证命令模板存在事实错误，直接导致验证步骤不可执行
   - 所在位置：§2 lib.cj/fwd.cj 段落「实施路径」验证命令模板（第 213-225 行）
   - 严重程度：严重
   - 改进建议：修正 grep 匹配模式为 `grep -c "detail.Quat<" cjglm/src/fwd.cj` 或 `grep -c '^public type.*= detail.Quat<' cjglm/src/fwd.cj`；修正不应生成模式的检查；补充 FQuat 精度前缀冗余检测命令。

4. **问题描述**：落地可实施性：关键信息碎片化严重，下游实施需要考古式跨节阅读
   - 所在位置：全文散布的修订标注（§1/§3.7/§3.9/§3.11 等）均可能遗漏被修改函数的集中参考清单
   - 严重程度：严重
   - 改进建议：对 §3.7~§3.15 中每个「完整实现」函数，在其函数描述末尾新增「集中参考清单」子节，列出该函数涉及的所有跨节位置。

5. **问题描述**：编码启动前验证项缺少独立验证报告模板，baseline 假设管理纪律缺失
   - 所在位置：§8 编码启动前验证项（第 1242-1270 行）
   - 严重程度：一般
   - 改进建议：在 §8 末尾新增「验证结果记录表」模板，包含列：验证项编号、假设描述、验证通过/失败、验证日期、验证人、失败后处置路径。

6. **问题描述**：§3.3 item 7 fromMat4 手动提取策略依赖未验证的字段名假设
   - 所在位置：§3.3 item 7（第 444 行 fromMat4 实现描述）、§8 验证项 27（第 1269 行）
   - 严重程度：一般
   - 改进建议：直接查阅阶段二 `cjglm/src/detail/type_mat4x4.cj` 确认列字段实际命名，将 `m.c0`/`m.c1`/`m.c2` 修正为实际字段名。

7. **问题描述**：§11.5 表缺少恒等性映射标注，下游按需查找定位成本高
   - 所在位置：§11.5 函数可用性对照表（第 1639-1705 行）
   - 严重程度：一般
   - 改进建议：在 §11.5 表中新增「设计章节」列，为每个函数列出其在 §3.x 中的主要描述位置。

## 迭代第 21 轮

1. **问题描述**：§3.7 length 函数 Float32 处理路径写为「`std.math.sqrt(Float64(dot_qq))`」，与 §1 v11 修订中"直接调用 std.math 函数，无需显式转换"的策略矛盾

## 迭代第 22 轮

1. **问题描述**："100% 修复率"的反复声称为系统性虚假声明，严重损害文档可信度
   - 所在位置：§修订说明(v15)~§修订说明(v22) 末段，共8处
   - 严重程度：严重
   - 改进建议：删除所有"审查意见修复率累计达 100%"的声称，改为诚实地记录每轮修复状态
2. **问题描述**：§11.5 自认不完整却作为多处核心引用依据，形成递归依赖
   - 所在位置：§11.5 首段（第1751行）自陈不完整声明；§8.3 D节（第1438行）；§8（第1103行）；§3.13.2（第763行）
   - 严重程度：严重
   - 改进建议：三个方案任选其一——同步将§11.5升级回"单一权威来源"；或将三处引用降级；或在§11.5末尾新增已知缺失条目清单
3. **问题描述**：文档的自我核验机制未能阻断版本号混乱的反复出现
   - 所在位置：§修订说明(v12) 第1908行、§修订说明(v13) 第1935行、§修订说明(v17) 第1997行等
   - 严重程度：严重
   - 改进建议：在§8.3 H节新增"版本号一致性自动化核验项H3"
4. **问题描述**：v22 新增的演进指南缺乏签名冻结的验证机制
   - 所在位置：§3.16 "阶段三→阶段四演进指南"第917-941行，责任边界总表第931-940行
   - 严重程度：一般
   - 改进建议：增加签名冻结核验项和例外审批流程
5. **问题描述**：§11.7 集中参考索引仅覆盖 ✅ 函数，⚠️/❌ 函数仍然碎片化
   - 所在位置：§11.7 第1859-1898行，表头限定"✅ 可用"
   - 严重程度：一般
   - 改进建议：将§11.7扩展为全函数集中参考索引，覆盖三类全部函数
6. **问题描述**：设计对阶段二 Mat4x4 列字段名的依赖为单点验证，未做系统性覆盖
   - 所在位置：§3.3 item 7 `fromMat4` 描述（第450行）、验证项26/27/28（第1307-1309行）、验证失败后受影响章节清单（第1316-1344行）
   - 严重程度：一般
   - 改进建议：对全部29项验证项补充"修复责任人"列
7. **问题描述**：δ 覆盖矩阵合计的自我核验机制不足
   - 所在位置：§8.3 H节（第1465-1469行）、§9a 基准声明表（第1518-1533行）、§10 覆盖矩阵合计行（第1434行）
   - 严重程度：一般
   - 改进建议：将H1核验项关联自动化工具；合并或建立§9a与§10单向引用关系；新增核验职责声明
   - 所在位置：§3.7 `length` 函数描述段（第 555 行）
   - 严重程度：一般
   - 改进建议：将 `std.math.sqrt(Float64(dot_qq))` 修订为 `std.math.sqrt(dot_qq)`（直接利用 Float32 重载），与 §3.9 axis 公式的处理方式一致
2. **问题描述**：产出全文档建立了密集的交叉引用网络，但剩余约 50+ 个函数仍散布于多个章节且无聚合索引，下游编码者获取完整信息需手动跳转查阅多处
   - 所在位置：全文（§3.1~§3.16、§5.3、§8.2、§10、§11.5、§11.6）
   - 严重程度：一般
   - 改进建议：在 §11.5 基础上扩展为统一的「函数信息聚合表」，或为所有 ✅ 可用函数补充集中参考清单
3. **问题描述**：设计将 88 个 ⚠️/❌ 函数推迟至阶段四，但未说明 stub 函数在阶段四实现时是否需要修改阶段三已完成的接口签名，也未提供阶段三→阶段四的 API 兼容性承诺与迁移指南
   - 所在位置：§3.13.2（审计结论）、§8.2（测试覆盖维度第 5 类"stub 函数异常路径"）
   - 严重程度：一般
    - 改进建议：在 §3.16 或新增 §12「阶段三→阶段四演进指南」中明确：(a) 所有 stub 函数的签名（含 where 子句约束）在阶段四实现时保持不变；(b) ⚠️ 函数的运行时行为过渡路径及测试迁移指南；(c) 阶段三已实现的 ✅ 函数的阶段四补充测试要求

## 迭代第 23 轮

1. **问题描述**：§5.4 对 `inverse` 不可声明为 const 的推理存在概念混淆——将运行时异常作为 const 拒绝理由，因果倒置
   - 所在位置：§5.4（行 1045-1046）
   - 严重程度：严重
   - 改进建议：将拒绝理由修订为「`/` 运算符在仓颉整数类型上非 constexpr 兼容，故不可声明为 `const func`」，删除「运行时抛算术异常」的错误归因

2. **问题描述**：§1 声称 `T(Float64(n))` 对整型 T 编译可行，但 §3.12 对整型 epsilon/pi/cos_one_over_two 使用运行时异常拒绝，两处策略逻辑不相容
   - 所在位置：§1（行 46-53）vs §3.12（行 640-646）vs D25（行 1090）
   - 严重程度：严重
   - 改进建议：二选一——(a) 将 §1 的 `T(Float64(n))` 支持限定为浮点类型，整型降级为 match/one 形参路径；(b) 确认语法可行，将 epsilon/pi/cos_one_over_two 的 T 约束收紧为 `FloatingPoint<T>` 或允许整型返回截断值

3. **问题描述**：§3.13.1 trigonometric.cj 75 个 stub 函数的「内部依赖」标注（`std.math.sin`）会误导下游认为当前编译时就需要这些依赖，与 stub 实际为 `throw Exception("stub")` 矛盾
   - 所在位置：§3.13.1 三角函数表（行 724-743）与表前说明（行 757）
   - 严重程度：一般
   - 改进建议：表头添加说明「标注为阶段四依赖」；将 `std.math.sin` 等改为 `std.math.sin（阶段四依赖）` 格式

4. **问题描述**：§3.13.2 审计结论说「18 个真完整实现」，使用函数名粒度，但 §11.7.1 和 §11.5 使用行粒度，两处粒度不一致产生计数错觉
   - 所在位置：§3.13.2（行 792）；§11.7.1（行 1886-1916）；§8.3 A 表（行 1405）
   - 严重程度：一般
   - 改进建议：在「18 个函数」后添加附注「按函数名计数（不含重载）；按 §11.5 表行粒度展开为 21 行」

5. **问题描述**：P0 核心假设（`T(Float64(n))` 语法可行性和 `FloatingPoint<T>` 接口方法可用性）仍停留在「待验证」状态，风险敞口未关闭
   - 所在位置：§1 回退方案（行 89-115）；§8 编码启动前验证项 20/25/29（行 1353-1359）
   - 严重程度：一般
   - 改进建议：在 §1 决策树末尾增加「验证时限承诺」；将受影响的函数清单标注「依赖假设：H1/H2」

6. **问题描述**：§3.13 gtc/matrix_transform.cj 64 个函数和 trigonometric.cj 75 个函数缺乏可编码粒度的完整签名模板，实际将签名设计责任下放给了编码者；§8.3 E 节声称「所有 stub 函数签名已记录于 §11.5」但 §11.5 实际无逐函数签名
   - 所在位置：§3.13 表格（行 681-694）；§11.5 可用性表（行 1847）；§8.3 E 节（行 1447-1457）
   - 严重程度：一般
   - 改进建议：(a) 在 §3.13 下为大类函数各提供代表性完整签名模板；(b) 在 §11.5 补充聚合行；(c) 在 §8.3 E 节补充签名记录位置的范围限定

7. **问题描述**：§5.3 边界条件表遗漏 5 类边界场景——NaN/Inf 输入传播、`lerp` 参数 `a` 为 NaN、`fromMat3`/`fromMat4` 对单位矩阵/零矩阵输入、`axis` 对 NaN w 分量、`inverse` 对非单位四元数输入
   - 所在位置：§5.3 边界条件表（行 1022-1041）
   - 严重程度：一般
   - 改进建议：在 §5.3 表中逐条新增对应行，声明各场景的行为定义

## 迭代第 24 轮

1. **问题描述**：H1（`T(Float64(n))` 语法编译可行性）和 H2（`FloatingPoint<T>` 接口方法可用性）两项 P0 基础假设自 v11 轮独立核实以来历经 13 个迭代版本未重新核验，v24 仍为"待验证"状态
   - 所在位置：§1「回退方案」节、§8.3 H 节验证项 20/25、§8 验证结果记录表模板
   - 严重程度：严重
   - 改进建议：在输出最终设计版本前，先建造最小仓颉测试文件（2 个文件，各 ~20 行）验证 H1 和 H2，将验证结果记录于 §8 验证结果记录表中
2. **问题描述**：从迭代历史识别出计数偏差、版本号混乱、§11.5 缺失 API 条目、公式与约束策略不一致等 6 类问题在多个轮次中反复出现，其中计数偏差在"终极修复"后再次检出，版本号混乱横跨 14 轮才引入核验项，虚假 100% 修复率声称持续 8 轮
   - 所在位置：全文档分散；系统性问题模式体现在迭代历史各轮次的重复问题描述中
   - 严重程度：严重
   - 改进建议：引入自动化一致性检查、核验前置化、质量门禁三项结构性预防措施
3. **问题描述**：165 个对标 API 中约 53%（88 个）以 stub 或抛 stub 异常占位，但 §1 概述声称"使库具备旋转/插值表达能力"，两者矛盾且缺乏前置风险声明
   - 所在位置：§1 概述第 12 行、§9a 合计行、§10 各文件覆盖矩阵
   - 严重程度：一般
   - 改进建议：在 §1 插入显式的阶段三 API 可用率声明，同步修订"插值表达能力"措辞
4. **问题描述**：§9a/§10/§11.5 三表覆盖同一组 API 函数，数据冗余度接近 100%，v13→v19 间合计计数偏差恰恰证明多表冗余直接导致维护负担和不一致风险
   - 所在位置：§9a 全节、§10 全节、§11.5 首段定位声明
   - 严重程度：一般
   - 改进建议：将 §9a 与 §10 合并为单一张表，或至少移除 §10 的重复状态列与合计行
5. **问题描述**：v12~v24 共 13 个修订说明章节约 500 行（占全文 22%），新读者难以辨别当前有效设计与历史修订，修订说明中"问题描述"列描述前序版本错误可能被误读
   - 所在位置：§修订说明(v12) 至 §修订说明(v24)，约第 1991-2310 行
   - 严重程度：一般
   - 改进建议：将所有修订说明剥离至独立文件（如 `a_v24_revision_history.md`），正文仅保留一条变更摘要行

## 迭代第 25 轮

1. **问题描述**：§1 API可用率声明（约77个函数/47%为真完整实现）与§3.13.2审计结论（18个函数）的计数口径差异未做充分说明，可能误导读者对阶段三实际交付能力的判断
   - 所在位置：§1第14-20行、§3.13.2第822-825行
   - 严重程度：一般
   - 改进建议：在§1表格下方补充注记明确77个✅的组成（28个常量函数+16个epsilon重载+构造函数/运算符重载等变体），或拆分为「独立函数范式」与「含重载变体展开」两行分别计数
2. **问题描述**：`normalize`函数整数T实例化时的边界行为在§3.7和§5.3中存在契约缺失，整数除法截断可能导致非单位四元数结果且未在边界条件表中声明
   - 所在位置：§3.7第574行附近、§5.3第1057-1058行
   - 严重程度：一般
    - 改进建议：在§5.3新增「整数T实例化」行明确行为契约，或收紧T约束为FloatingPoint<T>在编译期拒绝整数T实例化

## 迭代第 26 轮

1. **问题描述**：§1 计数口径的实质性矛盾未在可实施层面解决，47% 声明具有误导性
   - 所在位置：§1 设计目标表格及下方注记（行 14-22）
   - 严重程度：严重
   - 改进建议：将 ✅ 计数拆分为独立函数范式行与含重载/常量展开行，或改用 11% 口径
2. **问题描述**：v26 修订说明声称的 5 项修复未与正文实际内容完成闭环验证
   - 所在位置：§修订说明（v26）全文（行 1881-1903）vs 正文 §1/§3.4/§3.7/§8/§9
   - 严重程度：严重
   - 改进建议：逐条比照修订说明与正文对应位置确认已实际修改，新增正文修改位置标记
3. **问题描述**：103 个 stub 函数缺乏可编码粒度的完整 Cangjie 签名模板
   - 所在位置：§3.13 gtc/matrix_transform 函数清单段、§3.13.1 trigonometric.cj 函数表
   - 严重程度：严重
   - 改进建议：对每类函数提供至少 1-2 个完整签名模板作为模式参考，或新增附录文件列出全部签名
4. **问题描述**：不存在测试用例到函数的可追溯映射
   - 所在位置：§8.2 用例到函数的逐项分配依据表（行 1242-1274）
   - 严重程度：一般
   - 改进建议：新增逐函数测试映射模板，明确 stub 抽样策略选中的类别和函数名
5. **问题描述**：修订说明剥离后正文残留过时修订标注
   - 所在位置：全文各处散布的 "v{N} 修订"/"Issue {N} 响应" 标注
   - 严重程度：一般
   - 改进建议：逐处清理版本标注，将结果直接写入正文，删除版本标记
6. **问题描述**：§11.5 函数可用性对照表缺少质量声明与已知限制
   - 所在位置：§11.5 函数可用性对照表（行 1675-1750）
   - 严重程度：一般
   - 改进建议：新增权威声明和质量状态段，补充合计行与 §9a 交叉引用
7. **问题描述**：版本号混淆持续存在
   - 所在位置：文件名 vs 文档头部（行 3-4）vs 正文各处版本标注
   - 严重程度：一般
   - 改进建议：文件名、头部、正文版本号三方一致，H3 核验范围扩展
8. **问题描述**：演进指南未覆盖 stub 函数实现阶段四时的回归测试策略
   - 所在位置：§3.16 阶段三→阶段四演进指南（行 950-978）
   - 严重程度：一般
   - 改进建议：新增阶段四回归测试策略子节，明确受影响 ✅ 函数清单及迁移策略
9. **问题描述**：P0 验证时序与设计发布流程之间存在根本性矛盾
   - 所在位置：§8.4 编码启动前验证项 20/25（行 1344-1397）、§8.3 I 节 O-06（行 1530）
   - 严重程度：一般
   - 改进建议：将 O-06 优先级提升为 "下一轮必须实施"，将 P0 假设验证设为设计发布前置门禁

## 迭代第 27 轮

1. **问题描述**：核心用户用例（旋转/插值）在阶段三设计中被实质性放弃，但文档未做前置风险声明
   - 所在位置：§1 设计目标段（行 12-13）、§11.5 中旋转/插值函数全部 ❌/⚠️
   - 严重程度：严重
   - 改进建议：在 §1 概述首段后插入阶段三功能限制声明，在 §3.16 新增可用性缺口汇总子节，同步修订路线图验证标准标注
2. **问题描述**：路线图承诺与设计交付的偏差未被系统性量化和前置化，D35-D37 决策削弱了问题严重性而非解决
   - 所在位置：§3.16（行 959-976）D35-D37 决策段、§1 概述（行 12-13）、§9a 覆盖矩阵（行 1728）
   - 严重程度：严重
   - 改进建议：在 §3.16 新增偏差影响量化子节，在 §1 概述新增路线图偏差指数，评估每个 ❌ 函数在阶段三下的降级路径
3. **问题描述**：编码启动前验证项 29（P0）仍未完成，P0 通过条件不满足即输出 v27
   - 所在位置：§8 验证结果记录表（行 1531-1561）、§8.3 I 节 P0 通过条件（行 1561）
   - 严重程度：一般
   - 改进建议：补充验证项 29 的实际执行或降级 P0 通过条件措辞
4. **问题描述**：88 个 ❌/⚠️ 函数的签名模板覆盖率不足，58/64 个函数的展开方式依赖下游自行推断
   - 所在位置：§3.13 代表性函数签名模板段（行 728-735）、函数分类表（行 714-726）
   - 严重程度：一般
   - 改进建议：为每个函数类别提供完整命名规则文档，补充同类签名模板引用
5. **问题描述**：§8.2 测试策略缺少编译期签名正确性验证覆盖，88 个 ❌/⚠️ 函数的编译正确性无保障
   - 所在位置：§8.2 测试覆盖维度列表（行 1358-1367）、test_matrix_transform_stubs.cj（行 1292）
   - 严重程度：一般
   - 改进建议：新增第 9 类编译期签名正确性验证维度，增加编译覆盖率验证

## 迭代第 27 轮

1. **问题描述**：核心用户用例（旋转/插值）在阶段三设计中被实质性放弃，但文档未做前置风险声明
   - 所在位置：§1 设计目标段（行 12-13）、§11.5 中旋转/插值函数全部 ❌/⚠️
   - 严重程度：严重
   - 改进建议：在 §1 概述首段后插入阶段三功能限制声明，在 §3.16 新增可用性缺口汇总子节，同步修订路线图验证标准标注
2. **问题描述**：路线图承诺与设计交付的偏差未被系统性量化和前置化，D35-D37 决策削弱了问题严重性而非解决
   - 所在位置：§3.16（行 959-976）D35-D37 决策段、§1 概述（行 12-13）、§9a 覆盖矩阵（行 1728）
   - 严重程度：严重
   - 改进建议：在 §3.16 新增偏差影响量化子节，在 §1 概述新增路线图偏差指数，评估每个 ❌ 函数在阶段三下的降级路径
3. **问题描述**：编码启动前验证项 29（P0）仍未完成，P0 通过条件不满足即输出 v27
   - 所在位置：§8 验证结果记录表（行 1531-1561）、§8.3 I 节 P0 通过条件（行 1561）
   - 严重程度：一般
   - 改进建议：补充验证项 29 的实际执行或降级 P0 通过条件措辞
4. **问题描述**：88 个 ❌/⚠️ 函数的签名模板覆盖率不足，58/64 个函数的展开方式依赖下游自行推断
   - 所在位置：§3.13 代表性函数签名模板段（行 728-735）、函数分类表（行 714-726）
   - 严重程度：一般
   - 改进建议：为每个函数类别提供完整命名规则文档，补充同类签名模板引用
5. **问题描述**：§8.2 测试策略缺少编译期签名正确性验证覆盖，88 个 ❌/⚠️ 函数的编译正确性无保障
   - 所在位置：§8.2 测试覆盖维度列表（行 1358-1367）、test_matrix_transform_stubs.cj（行 1292）
   - 严重程度：一般
   - 改进建议：新增第 9 类编译期签名正确性验证维度，增加编译覆盖率验证

## 迭代第 28 轮

1. **问题描述**：设计未从用户需求响应充分度角度评估阶段三的实际交付能力，缺乏用户场景级交付能力声明、"用户能做 vs 不能做"的能力边界声明，降级路径实际可操作性不足
   - 所在位置：§1 设计目标段（line 12-14）、§1 前置风险声明（line 14-16）、§3.16 临时降级路径一览表（line 1102-1108）
   - 严重程度：严重
   - 改进建议：新增「阶段三用户能力视图」小节分组展示 165 个 API 状态；补充 5-8 个典型场景端到端代码示例；降级路径补充 GLM 源函数名、仓颉代码骨架、行为差异量化评估、成本分解依据
2. **问题描述**：§11.5 合计行算术表述存在误导（18+1+87=88 应为 106），且与 §9a 合计行的计数口径映射关系缺失
   - 所在位置：§11.5 合计行（line 2029）、§9a 合计行（line 1874）
   - 严重程度：严重
   - 改进建议：拆分合计行为独立函数口径行和 ⚠️/❌ 小计行；新增与 §9a 的口径映射注记；标注本表使用的计数口径
3. **问题描述**：`inverse` 对整数 T 的非零除截断行为未在契约中声明，与 `normalize` 的约束收紧策略不一致
   - 所在位置：§3.11 inverse 描述（line 654-656）、§5.3 边界条件表 inverse 行（line 1274-1275）
   - 严重程度：一般
   - 改进建议：将 `inverse` 约束收紧为 `FloatingPoint<T>` 或在契约中显式声明整数截断行为
4. **问题描述**：trigonometric.cj 75 个函数签名仍依赖下游手工推断，与 gtc/matrix_transform 64 个签名的完全展开形成不对称处理
   - 所在位置：§3.13.1 完整签名模板示例段（line 890-915）
   - 严重程度：一般
   - 改进建议：仿照 gtc/matrix_transform 完全展开 trigonometric.cj 全部 75 个签名模板
5. **问题描述**：跨 Qualifier 行为契约在除 `lerp` 外的所有函数中未声明，40+ 函数无相关说明
   - 所在位置：§3.4 运算符表、§3.7（dot/length/normalize/cross）、§3.9（axis）、§3.11（inverse/conjugate/isnan/isinf）
   - 严重程度：一般
    - 改进建议：新增统驭全篇的跨 Qualifier 行为统一契约声明，补充到 §5.3 边界条件表

## 迭代第 29 轮

1. **问题描述**：§11.5 自称权威来源但缺失 Quat×Vec4 条目
   - 所在位置：§11.5 函数可用性对照表
   - 严重程度：严重
   - 改进建议：确认 v29 是否已修复 Quat×Vec4 条目遗漏；建立发布前 grep 自动化核验机制

2. **问题描述**：需求响应充分度的结构性不足未被设计自身承认——文档叙述基调积极正面，未对 88 个 stub（53%）的不利影响做等量级显著性声明
   - 所在位置：§1 设计目标段、§1 前置风险声明段、§1 计数声明表、§1.2 用户能力视图
   - 严重程度：严重
   - 改进建议：在 §1 首句后插入醒目格式的风险声明；使 11%（18/165）作为首要口径突出显示，47% 仅作附注；新增典型用户场景覆盖度段；明确陈述阶段三后仍需等待阶段四

3. **问题描述**：降级路径的实际可操作性存在关键依赖悬空——quatLookAt* 降级路径依赖 cross(up, dir) 为 stub；slerp→lerp 降级路径成本分解标注为 0 人日未考虑角度阈值适配成本；未提及 nlerp 中间方案
   - 所在位置：§3.16 临时降级路径一览表
   - 严重程度：严重
   - 改进建议：明确给出 Vec3 cross 自行实现方式和成本估算；补充 slerp→lerp 角度差阈值判断适配成本；补充 nlerp 中间方案及适用场景说明

4. **问题描述**：版本标注清理未闭环——30+ 处非决策性版本标注经多轮承诺清理仍未完成
   - 所在位置：§3.2/§3.3/§3.4/§3.7/§3.9/§3.10/§3.11 等章节正文
   - 严重程度：一般
   - 改进建议：在版本发布流程中增加 grep -n "**v[0-9]" 自动化门禁，确保零残留

5. **问题描述**：§11.5 计数口径与 §9a/§11.7.2 的不一致
   - 所在位置：§11.5 合计行、§9a 合计行
   - 严重程度：一般
   - 改进建议：确认 v29 是否已拆分合计行为独立函数范式口径行与 ⚠️/❌ 小计行

6. **问题描述**：P0 核心假设 H1 的验证未覆盖泛型上下文
   - 所在位置：§1 验证执行记录段
   - 严重程度：一般
   - 改进建议：补充 H1 的泛型上下文最小测试文件

7. **问题描述**：T(0) 字面量替代函数清单范围声明不完整
   - 所在位置：§1 常量型 T(n) 字面量替代段末尾函数清单
   - 严重程度：一般
   - 改进建议：在清单段首补充过滤规则说明

8. **问题描述**：阶段四依赖风险未做关键路径分析——88 个 stub 补齐依赖于 geometric/trigonometric/common 三个基础函数库
   - 所在位置：§3.16 回归测试策略、§8.2 测试增量规划
   - 严重程度：一般
   - 改进建议：在 §3.16 末尾新增阶段四 stub 函数实施优先级排序段（P0/P1/P2）

9. **问题描述**：文档对 11% 真完整实现的事实未做后续演进承诺
   - 所在位置：§3.16 阶段三→阶段四演进指南、§10 覆盖矩阵
   - 严重程度：一般
   - 改进建议：在 §3.16 末尾补充 API 可用率增长路线图段，以时间线形式列出阶段四各批次交付后的累计可用率

## 迭代第 30 轮

1. **问题描述**：版本标注噪音持续严重损害文档可实施性，v27/v28清理承诺未闭环
   - 所在位置：§3.2、§3.2.1、§3.3、§3.4、§3.5、§3.7、§3.9、§3.10、§3.11、§3.13.1、§3.15、§11.4、§11.5 等（全文约200+处）
   - 严重程度：严重
   - 改进建议：全文自动扫描并移除非决策性版本标注，保留设计内容文字，移除`**v{N} 关键修订**`等版本标记外层包装

2. **问题描述**：函数状态信息在6+处位置冗余存储，构成持续的不一致风险源
   - 所在位置：§1、§3.2、§3.15、§8、§9a、§11.5、§11.6、§11.7
   - 严重程度：严重
   - 改进建议：选择§11.5为唯一权威来源，移除其余位置中的函数状态行/状态表格，替换为交叉引用

3. **问题描述**：v30轮次才修正Vec3×Quat/Vec4×Quat状态，反映根本原因分析流程仍存在缺口
   - 所在位置：§3.4 Vec extend块运算符表、"实现链路注释"段
   - 严重程度：严重
   - 改进建议：对所有⚠️/✅但依赖stub的函数新增"运行时调用链依赖分析"子段，纳入编码启动前验证项覆盖范围

4. **问题描述**：§11.5合计行算术仍然存在误导性表述
   - 所在位置：§11.5合计行
   - 严重程度：一般
   - 改进建议：新增"总函数数（独立函数范式口径）= 106"行，列出与165的差值59的来源分类

5. **问题描述**：§5.3边界条件表仍然缺少跨函数组合场景的边界契约
   - 所在位置：§5.3边界条件表
   - 严重程度：一般
   - 改进建议：新增4行覆盖NaN/Inf输入组合场景的行为契约

6. **问题描述**：三角函数标量签名的`where T <: FloatingPoint<T>`约束实际限制了下游使用场景，但与§1中泛型假设存在张力
   - 所在位置：§3.13.1函数表 + §1系统性设计约束段
   - 严重程度：一般
   - 改进建议：补充说明约束收紧在阶段三仅影响编译行为，提供整型T实例化的降级路径

7. **问题描述**：§8编码启动前验证项的表单填写状态存在不一致
   - 所在位置：§8"验证结果记录表"
   - 严重程度：一般
   - 改进建议：新增状态汇总声明，明确列示已完成/编码阶段执行/待定验证项

8. **问题描述**：§3.16的API可用率增长路线图批次数量与§8.4实施批次建议编号冲突
   - 所在位置：§3.16表头、§8.4表头
   - 严重程度：一般
   - 改进建议：将阶段四的4个交付批次重新编号为"阶段四批次A~D"

## 迭代第 31 轮

1. **问题描述**：v31 声称已清理全部非决策性版本标注，但正文仍广泛分布 `（v{N} 修订）`、`（v{N} 新增）`、`（Issue {N} 响应）`、`***v{N}` 等模式，涉及 100+ 处，横跨 14 个迭代版本未根治
   - 所在位置：§3.2、§3.2.1、§3.3、§3.4、§3.5、§3.7、§3.9、§3.10、§3.11、§3.12、§3.13.1、§3.15、§3.16、§5.3、§11.5 等章节
   - 严重程度：严重
   - 改进建议：增加自动化 grep 门禁确保零残留；或将版本标注全部剥离至独立修订历史文件，正文仅保留变更摘要行

2. **问题描述**：文档未主动回答「11% API 可用率（18/165 ✅）是否满足路线图阶段三预期」这一根本问题，三项已决策偏差（D35-D37）仅记录为「已闭环」但未做自我评估
   - 所在位置：§1 设计目标段、§1.2 用户能力视图、§3.16 需求对齐说明
   - 严重程度：严重
   - 改进建议：在 §3.16 新增阶段三交付能力与路线图预期差距评估子节；若结论为不满足则主动提出路线图修订建议

3. **问题描述**：§11.5 自称「单一权威来源」但与 §8.3 D 节定位声明措辞不一致，函数状态信息仍冗余存储于 9 处位置
   - 所在位置：§8.3 D 节 vs §11.5 首段；§1/§3.2/§3.15/§8/§10/§11.6/§11.7
   - 严重程度：一般
   - 改进建议：统一定位声明措辞；冗余状态表格替换为指向 §11.5 的交叉引用；新增 §11.5 vs §10 覆盖矩阵交叉验证核验项

4. **问题描述**：P0 核心假设（H1/H2）在 v25 才通过编译验证，v1~v24 共 24 轮设计在未经验证假设上发布；O-06 验证前置化制度未见实施证据
   - 所在位置：§1「回退方案」节、「验证执行记录」段；§8.3 I 节 O-06
   - 严重程度：一般
   - 改进建议：新增验证时序审计声明，明确 v1~v24 核心决策是否受影响；将 O-06 从「下一轮必须实施」升级为「当前轮次已实施」并补充证据

5. **问题描述**：§3.13.1 三角函数表 75 个 stub 函数的「内部依赖」列标注了具体函数名（如 `std.math.sin`），表前说明虽澄清为阶段四依赖但认知负荷仍偏高；`radians`/`degrees` 行的 `PIVAL<T>` 共享常量构成跨节假设链
   - 所在位置：§3.13.1 三角函数表及表前说明
   - 严重程度：一般
   - 改进建议：统一「内部依赖」列标注为「（阶段四依赖）」不区分具体函数名；`radians`/`degrees` 行实现细节移至表下；新增 `PIVAL<T>` 可行性验证项或明确 `pi<T>()` 的 π 值来源

## 迭代第 32 轮

1. **问题描述**：§9a 覆盖矩阵合计行声明「3 ⚠️」与 §11.5 函数可用性对照表合计行「4 ⚠️」不一致，H2b 核验项未能检出
   - 所在位置：§9a（line 2132）、§11.5（line 2288）、§8.3 H 节 H2b（line 2030）
   - 严重程度：严重
   - 改进建议：核实 ⚠️ 实际个数（应为 4），修正 §9a 合计行；扩展 H2b 核验项范围，要求 §9a 与 §11.5 的 ⚠️/❌/✅ 三项计数分别交叉核对

2. **问题描述**：v32 声称非决策性版本标注已移除但正文仍存在大量「（：v{N}）」残留，H7 门禁 grep 模式存在绕过漏洞
   - 所在位置：全文散布，涉及 §3.2.1、§3.3、§3.9、§3.10、§3.11、§3.15 等章节
   - 严重程度：严重
   - 改进建议：扩展 H7 grep 模式为 `grep -n "（v[0-9]\|（Issue [0-9]\|\*\*v[0-9]\|：v[0-9]" *.md` 以捕获  前缀残留；对已识别的残留标注执行第二轮清理

3. **问题描述**：§1「系统性设计约束」段声明整数类型  编译可行性「尚待验证」，但同一文档验证执行记录声称「已验证通过」，两处直接矛盾
   - 所在位置：§1（line 63-64）与 §1 回退方案节（line 138）
   - 严重程度：严重
   - 改进建议：统一两处陈述，在验证结果记录表中为整数类型设置单独的验证子项，明确标注验证状态

4. **问题描述**：§3.13 三角函数表 radians/degrees 行例外标注未与表头说明对齐，例外信息分散在表行和表下两处
   - 所在位置：§3.13.1（line 1008-1009、line 1019）
   - 严重程度：一般
   - 改进建议：将表下段关于 radians/degrees 的例外说明以脚注形式引用至表行

5. **问题描述**：§5.3 边界条件表中 normalize 零四元数保护分支的返回值描述与 §3.7 策略描述重叠不一致，且单行约 400 字远超其他行
   - 所在位置：§5.3（line 1539）、§3.7（line 718）
   - 严重程度：一般
   - 改进建议：将 §5.3 行精简为「返回单位四元数（实现策略详见 §3.7 + §1）」，删除重复的 T(0) 路径讨论

6. **问题描述**：§3.15 gtc/quaternion.cj 的 7 个 stub 函数签名模板缺失，下游需跨 3 章推断完整签名
   - 所在位置：§3.15（line 1225-1232）
   - 严重程度：一般
   - 改进建议：在 §3.15 新增完整签名模板代码块，与 gtc/matrix_transform.cj 的 64 个签名模板展开风格一致

7. **问题描述**：`test_matrix_transform_stubs.cj` 预计用例数 ≥8 与实际抽样策略 9 个代表性函数直接冲突
   - 所在位置：§8.2（line 1675、line 1782-1793）
   - 严重程度：一般
   - 改进建议：将预计用例数从 ≥8 修订为 ≥9，同步更新合计行和分配表

8. **问题描述**：O-06「已实施」声称与验证记录表 26 项留空的实证存在缝隙，且 §1 与 §8.3 I 节措辞不一致
   - 所在位置：§1（line 266-277）、§8.3 I 节（line 2051）、验证结果记录表（line 1919-1949）
   - 严重程度：一般
   - 改进建议：为非 P0 验证项统一标注「—（编码阶段执行）」标记；统一 O-06 描述措辞

9. **问题描述**：§11.6 四命名空间可达性矩阵关于 `glm.Quat` 的来源描述与 §2 lib.cj 段落存在路径歧义
   - 所在位置：§11.6（line 2303）、§2（line 304）、§3.14（line 1177-1182）
   - 严重程度：一般
   - 改进建议：在 §11.6 表补充脚注标注 Quat 别名在 fwd.cj 中定义，lib.cj 的 public import 机制使其在 `glm` 命名空间下可直接访问

10. **问题描述**：验证项 15 描述仍引用已废弃的「`std.math.pow` 仅 Float64」策略
   - 所在位置：§8 验证项 15（line 1853）、§1（line 77）
   - 严重程度：轻微
   - 改进建议：将验证项 15 描述更新为 Float32 实例化时直接调用 `std.math.pow(Float32, Float32)` 重载

## 迭代第 32 轮

1. **问题描述**：§9a 覆盖矩阵合计行声明「3 ⚠️」与 §11.5 函数可用性对照表合计行「4 ⚠️」不一致，H2b 核验项未能检出
   - 所在位置：§9a（line 2132）、§11.5（line 2288）、§8.3 H 节 H2b（line 2030）
   - 严重程度：严重
   - 改进建议：核实 ⚠️ 实际个数（应为 4），修正 §9a 合计行；扩展 H2b 核验项范围，要求 §9a 与 §11.5 的 ⚠️/❌/✅ 三项计数分别交叉核对

2. **问题描述**：v32 声称非决策性版本标注已移除但正文仍存在大量「（：v{N}）」残留，H7 门禁 grep 模式存在绕过漏洞
   - 所在位置：全文散布，涉及 §3.2.1、§3.3、§3.9、§3.10、§3.11、§3.15 等章节
   - 严重程度：严重
   - 改进建议：扩展 H7 grep 模式为 `grep -n "（v[0-9]\|（Issue [0-9]\|\*\*v[0-9]\|：v[0-9]" *.md` 以捕获 `：v{N}` 前缀残留；对已识别的残留标注执行第二轮清理

3. **问题描述**：§1「系统性设计约束」段声明整数类型 `T(Float64(n))` 编译可行性「尚待验证」，但同一文档验证执行记录声称「已验证通过」，两处直接矛盾
   - 所在位置：§1（line 63-64）与 §1 回退方案节（line 138）
   - 严重程度：严重
   - 改进建议：统一两处陈述，在验证结果记录表中为整数类型设置单独的验证子项，明确标注验证状态

4. **问题描述**：§3.13 三角函数表 radians/degrees 行例外标注未与表头说明对齐，例外信息分散在表行和表下两处
   - 所在位置：§3.13.1（line 1008-1009、line 1019）
   - 严重程度：一般
   - 改进建议：将表下段关于 radians/degrees 的例外说明以脚注形式引用至表行

5. **问题描述**：§5.3 边界条件表中 normalize 零四元数保护分支的返回值描述与 §3.7 策略描述重叠不一致，且单行约 400 字远超其他行
   - 所在位置：§5.3（line 1539）、§3.7（line 718）
   - 严重程度：一般
   - 改进建议：将 §5.3 行精简为「返回单位四元数（实现策略详见 §3.7 + §1）」，删除重复的 T(0) 路径讨论

6. **问题描述**：§3.15 gtc/quaternion.cj 的 7 个 stub 函数签名模板缺失，下游需跨 3 章推断完整签名
   - 所在位置：§3.15（line 1225-1232）
   - 严重程度：一般
   - 改进建议：在 §3.15 新增完整签名模板代码块，与 gtc/matrix_transform.cj 的 64 个签名模板展开风格一致

7. **问题描述**：`test_matrix_transform_stubs.cj` 预计用例数 ≥8 与实际抽样策略 9 个代表性函数直接冲突
   - 所在位置：§8.2（line 1675、line 1782-1793）
   - 严重程度：一般
   - 改进建议：将预计用例数从 ≥8 修订为 ≥9，同步更新合计行和分配表

8. **问题描述**：O-06「已实施」声称与验证记录表 26 项留空的实证存在缝隙，且 §1 与 §8.3 I 节措辞不一致
   - 所在位置：§1（line 266-277）、§8.3 I 节（line 2051）、验证结果记录表（line 1919-1949）
   - 严重程度：一般
   - 改进建议：为非 P0 验证项统一标注「—（编码阶段执行）」标记；统一 O-06 描述措辞

9. **问题描述**：§11.6 四命名空间可达性矩阵关于 `glm.Quat` 的来源描述与 §2 lib.cj 段落存在路径歧义
   - 所在位置：§11.6（line 2303）、§2（line 304）、§3.14（line 1177-1182）
   - 严重程度：一般
   - 改进建议：在 §11.6 表补充脚注标注 Quat 别名在 fwd.cj 中定义，lib.cj 的 public import 机制使其在 `glm` 命名空间下可直接访问

10. **问题描述**：验证项 15 描述仍引用已废弃的「`std.math.pow` 仅 Float64」策略
    - 所在位置：§8 验证项 15（line 1853）、§1（line 77）
    - 严重程度：轻微
     - 改进建议：将验证项 15 描述更新为 Float32 实例化时直接调用 `std.math.pow(Float32, Float32)` 重载

## 迭代第 33 轮

1. **问题描述**：版本标注清理声明不实——本轮修复后仍存在大量残留（50 处以上），横跨 §3.13、§3.13.1、§3.13.2、§3.15、§3.16、§4.4、§5.3 等章节，且 H7 门禁扩展未实际执行
   - 所在位置：全文散布，尤其 §3.13.2、§3.15、§3.16 密集
   - 严重程度：严重
   - 改进建议：将"已移除"声明降级为诚实的"部分已清理，仍在推进中"；立即执行扩展后的 H7 grep 模式并逐处清理；核查 H7 门禁为何未被实际执行
2. **问题描述**：函数状态信息 9 处冗余存储的系统性风险仍未消除（§1、§3.2、§3.15、§8、§9a、§10、§11.5、§11.6、§11.7），迭代历史中计数不一致反复出现
   - 所在位置：§1（line 24）、§3.2（lines 568-575）、§3.15（lines 1196-1201）、§8、§9a、§10、§11.5、§11.6、§11.7
   - 严重程度：严重
   - 改进建议：选择一处作为唯一权威来源（推荐 §11.5），其余 8 处移除函数状态行/表格，替换为交叉引用；在 §8.3 新增自动化交叉核验项
3. **问题描述**：11% 可用率与用户"迁移"预期之间的根本性鸿沟未主动面对——评估基调偏积极（"基本满足阶段三路线图目标"），未评估用户叙事层面的影响，未提供决策者的决策依据
   - 所在位置：§1（line 12-13 "为库提供基础的旋转表达和插值运算框架"）、§3.16 差距评估（lines 1440-1468）
   - 严重程度：严重
   - 改进建议：将 §3.16 差距评估结论从"基本满足"修订为"部分满足，存在重大差距"；在 §1 增加醒目格式的阶段三功能限制前置声明；新增"发布决策支持"段
4. **问题描述**：§11.5 自称"单一权威来源"的完整性仍未审计——迭代历史反复检出缺失 API 条目
   - 所在位置：§11.5 函数可用性对照表
   - 严重程度：一般
   - 改进建议：对 §11.5 执行系统性覆盖率审计，将 §10 覆盖矩阵所有函数与 §11.5 逐行比对
5. **问题描述**：gtc/matrix_transform 64 个签名模板与 trigonometric.cj 75 个函数的签名模板不对称处理（100% 覆盖 vs 27% 覆盖）
   - 所在位置：§3.13.1（lines 1082-1088）+ §3.13（lines 862-962）
   - 严重程度：一般
   - 改进建议：将 trigonometric.cj 的 75 个签名同样展开为完整可复制代码块
6. **问题描述**：三角函数表内部依赖列标注"（阶段四依赖）"粒度过粗，radians/degrees 的例外说明需多处跳转查阅
   - 所在位置：§3.13.1（lines 994-1015）
   - 严重程度：一般
   - 改进建议：将 radians/degrees 的例外说明直接写入表行"内部依赖"列


## 迭代第 34 轮

1. **问题描述**：Vec4(Vec3, T) 双参数构造函数在阶段一不存在，Quat×Vec4 实现路径中断
   - 所在位置：§3.4 运算符体系表 Quat×Vec4 行
   - 严重程度：严重
   - 改进建议：方案A：在阶段三 Quat extend 块中手动逐分量构造 Vec4，消除对 Vec4(Vec3, T) 的依赖；方案B：在阶段三补充 init(v: Vec3<T,Q>, w: T) 构造函数。同步修正 §11.5、§3.13.2、§8 等处的状态标注
2. **问题描述**：阶段一