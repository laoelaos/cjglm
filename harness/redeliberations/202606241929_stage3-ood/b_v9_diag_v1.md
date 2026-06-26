# 质量审查诊断报告

**审查目标**：`a_v9_copy_from_v8.md`（GLM 1.0.3 仓颉迁移阶段三 OOD 设计方案，v13 修订版）
**审查轮次**：第 9 次迭代，首轮质量审查
**审查维度**：需求响应充分度、事实错误/逻辑矛盾、深度与完整性（OOD 可落地性视角）

---

## 问题 1（严重）

**问题描述**：§3.2 `gtc/quaternion.cj` 处理策略段落（约第 313-315 行）与 §3.15 函数职责分组表（约第 719-724 行）/ §3.15 v3 修订说明（约第 726-732 行）对 4 个欧拉函数的实现状态存在**直接矛盾**。§3.2 策略段落声明「本文件完整实现（8 个）」包含 `eulerAngles`/`roll`/`pitch`/`yaw`（并附注「虽然依赖 stub，本设计选择完整实现而非 stub 占位」），但 §3.15 表格与 v3 修订说明已将这些函数明确归入「stub 占位」类别，且 v3 修订说明（第 730 行）明确指出「v2 中误标为"完整实现"」已修正。下游编码者按 §3.2 策略段落实施时会按「完整实现」编写函数体，而按 §3.15 表格实施则为 stub 占位——两种路径产出截然不同，直接阻塞编码落地。

**所在位置**：§3.2「本阶段对 gtc/quaternion 函数的处理策略」段落（约第 313-315 行）vs §3.15 职责分组表（约第 719-724 行）+ §3.15 v3 修订说明（约第 726-732 行）

**严重程度**：严重（同一文档内部对 4 个核心函数的实现策略自相矛盾，下游无法决策）

**改进建议**：§3.2 策略段落第 313-315 行修订为与 §3.15 一致的「stub 占位」分类，删除「本文件完整实现（8 个）」中的欧拉函数行，将策略段重构为「本文件完整实现（4 个）：lessThan/lessThanEqual/greaterThan/greaterThanEqual；stub 占位（7 个）：eulerAngles/roll/pitch/yaw/quatLookAt/quatLookAtRH/quatLookAtLH；从 detail 重导出（4 个）：mat3Cast/mat4Cast/quatCast(Mat3)/quatCast(Mat4）」；删除「虽然依赖 stub，本设计选择完整实现而非 stub 占位」的过时附注。

---

## 问题 2（严重）

**问题描述**：`normalize(q)` 函数零四元数保护分支中 `T(0)` 的获取策略与函数签名存在不可闭环矛盾。§3.7 normalize 函数描述（约第 461 行）声明零保护分支返回 `Quat(T(0), T(0), T(0), T(1))`，并在 T(0)/T(1) 获取路径段引用 §1「系统性设计约束」说明「T(0) 通过 `one - one` 演算（需 `one: T` 形参显式传入）」。但 `normalize` 函数签名 `normalize(q: Quat<T,Q>): Quat<T,Q>` 不含 `one: T` 形参，下游编码者按此签名实现时无法在函数体内获取 `T(0)`——`one - one` 演算路径需要 `one: T` 形参，而该形参不存在于签名中。§1 v9 扩展的「常量型 T(n) 字面量替代」策略（如 `T(Float64(1))`）仅覆盖了常量型 T(1) 的场景，**未覆盖 T(0)** 的字面量替代方案。对比 `axis` 函数（§3.9）将 `T(0)` 写为 `T(Float64(0))`（字面量替代），`normalize` 仍依赖不可能获取的 `one - one` 演算路径。§5.3 边界条件表 normalize 行（约第 876 行）同样标注「T(0) 通过 `one - one` 演算」，与签名不可闭环。整条信息链（§3.7 → §1 → §5.3 → §11.6）均声称 T(0) 通过 `one - one` 获取，但无一处说明 `normalize` 函数签名中如何提供 `one`。

**所在位置**：§3.7 normalize 函数描述（约第 461 行）、§5.3 边界条件表 normalize 行（约第 876 行）、§1「系统性设计约束」（约第 46-48 行）

**严重程度**：严重（`normalize` 是 4 个完整实现函数之一，零四元数保护是其核心边界行为，T(0) 不可获取直接阻塞编码落地）

**改进建议**：二选其一：(A) 将 `normalize` 签名修订为 `normalize(q: Quat<T,Q>, one: T): Quat<T,Q>`（与 `identity(one)` 风格一致），函数体内部 T(0) 通过 `one - one` 获取，T(1) 通过 `T(Float64(1))` 字面量替代——但需同步修订所有调用 `normalize` 的下游位置（`fromVec3` stub 等）；(B) 将 `normalize` 零保护分支的 T(0) 也改用 `T(Float64(0))` 字面量替代路径（与 `axis` 函数的 `T(Float64(0))` 模式一致），并将 §1「常量型 T(n) 字面量替代」策略从仅覆盖 T(1) 扩展为同时覆盖 T(0) 和 T(1)（理由：`T(Float64(0))` 在 `T = Float32/Float64` 下均返回正确零值，与 `T(Float64(1))` 路径对等），§3.7 / §5.3 / §1 同步修订。

---

## 问题 3（严重）

**问题描述**：§3.13 `gtc/matrix_transform.cj` 函数清单中「视口与裁剪空间（ortho 系族）」声称 9 个函数（§3.13 表格约第 580 行），但经直接核对 GLM 1.0.3 `glm/glm/ext/matrix_clip_space.inl` 源码，ortho 系族实际包含 **10** 个函数（而非 9 个）。GLM 源码中的 ortho 函数为：(1) `ortho(T left, T right, T bottom, T top)` (无 zNear/zFar 的 2D ortho)、(2) `orthoLH_ZO`、(3) `orthoLH_NO`、(4) `orthoRH_ZO`、(5) `orthoRH_NO`、(6) `orthoZO`、(7) `orthoNO`、(8) `orthoLH`、(9) `orthoRH`、(10) `ortho(T left, T right, T bottom, T top, T zNear, T zFar)` (带 zNear/zFar 的 3D ortho)。设计文档的函数清单仅列出「ortho（无 zNear/zFar）」1 个 + 8 个变体 = 9 个，遗漏了「ortho（含 zNear/zFar）」这一 3D 版本。类似地，frustum 系族表中列了 9 个函数但实际 GLM 也包含 `frustum(T, T, T, T, T, T)` 这一一般版本——恰好清单已列出。合计数字 64 来自 11 + 9 + 9 + 9 + 9 + 7 + 2 + 6 + 1 = 63（非 64），ortho 系族实际应为 10 个，修正后 11 + 10 + 9 + 9 + 9 + 7 + 2 + 6 + 1 = 64。验证：`grep "GLM_FUNC_QUALIFIER" matrix_clip_space.inl | wc -l` 得 46，`matrix_transform.inl` 11 个，`matrix_projection.inl` 7 个，11 + 46 + 7 = 64 函数总计数正确，但 ortho 子类 9→10 导致内部子类求和与 ortho 行不一致。

**所在位置**：§3.13 函数清单「视口与裁剪空间（ortho 系族）」行（约第 580 行）、合计行（约第 588 行）

**严重程度**：严重（ortho 系族函数数量错误导致下游 stub 声明时遗漏 1 个函数，lena.cj import 解析时函数列表不完整）

**改进建议**：§3.13 ortho 系族函数列表从 9 个修订为 10 个，补充 `ortho(T left, T right, T bottom, T top, T zNear, T zFar)` （3D ortho 一般版本，与 2D ortho 无 zNear/zFar 版本区分）；同步检查 frustum 系族函数列表完整性；合计行数字确认仍为 64；§10 / §8.3 / §11.5 对应位置同步修订 ortho 子类数字。

---

## 问题 4（严重）

**问题描述**：§3.13 `mat3Cast` 函数体内部使用 `Mat3x3(T(1))` 初始化单位矩阵（引用 GLM `gtc/quaternion.inl:49`），设计文档 §3.2.1 声明 `mat3Cast`/`mat4Cast` 的 T(1) 通过 `T(Float64(1))` 字面量替代获取。但经核对 GLM 1.0.3 源码 `glm/glm/gtc/quaternion.inl:51`（`mat3_cast` 函数实现），GLM 实际使用的是 `mat<3, 3, T, Q> Result(T(1))`——这是 **Mat3x3 的单参数构造函数**（接受标量 T(1) 作为对角元素初始化值），C++ 中 `T(1)` 可通过 `static_cast<T>(1)` 直接获取。但在仓颉版 Mat3x3 中，**Mat3x3 是否存在接受单个 T 参数的构造函数**未在设计文档中核验。设计文档选择的方案是手动填充 `Result[0][0] = T(Float64(1))` 等 9 个元素（逐元素通过字面量替代初始化），但 §3.2.1 声明「内部 `Mat3x3(T(Float64(1)))` 初始化对角线」暗示使用单参数构造——这两种路径不一致。若 Mat3x3 存在单参数构造，则需要 `one: T` 形参（与阶段二矩阵 identity 模式一致）；若不存在，则必须逐元素填充。设计文档未明确选择哪种路径，且两种路径的签名约束不同。

**所在位置**：§3.2.1 T(1) 字面量获取策略段（约第 301-304 行）、§3.2.1 签名模板（约第 290-293 行）

**严重程度**：严重（`mat3Cast`/`mat4Cast` 的 T(1) 获取路径不明确，两种实现路径的签名约束不同，直接阻塞编码落地）

**改进建议**：在 §3.2.1 明确选择一种初始化路径（二选一）：(A) 若 Mat3x3 存在单标量参数构造函数 `init(scalar: T)`，则直接使用 `Mat3x3(T(Float64(1)))` 初始化（仅填对角线），但需核验阶段二 Mat3x3 是否已提供此构造函数；(B) 逐元素填充（不依赖 Mat3x3 构造函数），明确给出逐元素赋值模板 `Result[0][0] = T(Float64(1)) ... ; Result[1][1] = T(Float64(1)) ... ; Result[2][2] = T(Float64(1))` 等。删除「`Mat3x3(T(Float64(1)))` 初始化对角线」的歧义表述，改为明确的逐元素赋值或构造函数调用路径，确保下游编码者无需自行猜测实现方式。

---

## 问题 5（一般）

**问题描述**：§3.9 `axis` 函数公式中 `T(Float64(0))` 使用了字面量替代策略获取 T(0)，但 §1「系统性设计约束」的 v9 扩展「常量型 T(n) 字面量替代」段落（约第 49-52 行）仅列出 `axis`/`Quat×Vec3`/`Quat×Vec4`/`mat3Cast`/`mat4Cast` 五类使用 `T(Float64(n))` 的函数，**未包含 `normalize` 零保护分支中对 T(0) 的字面量替代场景**（参见问题 2）。如果问题 2 采纳方案 B（T(0) 也使用字面量替代），则 §1 v9 函数清单需追加 `normalize` 函数——当前清单遗漏。此外，`normalize` 的零保护分支中 `T(Float64(0))` 在 `T = Int64` 等整数类型下的行为需评估：`Int64(Float64(0))` 是否编译通过且返回 `Int64(0)`。§1 约束段未将 T(0) 纳入字面量替代范围，可能导致下游实现 `normalize` 时对 T(0) 处理策略不一致。

**所在位置**：§1「系统性设计约束」「常量型 T(n) 字面量替代（v8 新增，v9 扩展）」段落（约第 49-52 行）、§3.7 normalize 描述（约第 461 行）

**严重程度**：一般（在问题 2 修复后联动此问题；若问题 2 采纳方案 A 则此问题不成立）

**改进建议**：若问题 2 采纳方案 B（T(0) 字面量替代），则 §1 v9 函数清单追加 `normalize` 函数并标注「使用 `T(Float64(0))` 字面量实现零保护分支 xyz 分量 + `T(Float64(1))` 字面量实现零保护分支 w 分量」；同步在 §1「常量型 T(n) 字面量替代」策略描述中扩展覆盖 T(0) 场景，明确 `T(Float64(0))` 在 `T = Float32/Float64/Int8~Int64` 下的编译可行性。

---

## 问题 6（一般）

**问题描述**：§3.15 完整实现函数段（约第 734-740 行）将 `lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual` 4 个比较函数签名的 `where` 约束声明为 `T <: Comparable<T>, Q <: Qualifier`，这与 §3.2.1 D32、§3.11 D29、§3.12 D25、§3.13.1 T 约束策略已统一的 `where T <: FloatingPoint<T>` 存在表面矛盾。4 个比较函数的语义是逐分量 `<`/`<=`/`>`/`>=` 比较——若 `where T <: Comparable<T>`，则整数四元数（`Quat<Int64, Q>`）也可调用 `lessThan` 等，返回 `Vec4<Bool, Q>` 结果，这在语义上合理。但 §11.5 函数可用性对照表（约第 1420 行）追加的约束标注为 `where T <: Comparable<T>`，而同表 `mat3Cast`/`mat4Cast` 标注 `where T <: FloatingPoint<T>`——两者 T 约束不一致。设计文档未说明**为何比较函数使用更宽的 `Comparable<T>` 约束而非统一的 `FloatingPoint<T>` 约束**，也未说明 GLM 原始实现中这些函数的约束（GLM 1.0.3 `gtc/quaternion.hpp` 中比较函数无 `GLM_STATIC_ASSERT(is_iec559)` 断言，即 GLM 未限制为浮点类型），下游编码者可能困惑是否需要收紧至 `FloatingPoint<T>` 以与其他函数一致。

**所在位置**：§3.15 完整实现函数段（约第 734-740 行）、§11.5 比较函数行（约第 1420 行）

**严重程度**：一般（不阻塞功能实现，但约束策略缺乏设计决策依据，下游可能产生约束收紧/放宽分歧）

**改进建议**：在 §3.15 完整实现函数段或 §7 设计决策表新增决策条目，明确比较函数采用 `Comparable<T>` 宽约束的理由：(a) GLM 原始实现中 `lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual` 无 `is_iec559` 静态断言，整数类型在 GLM 中也可调用；(b) 比较运算符本身对整数类型语义正确（无浮点专用依赖），收紧至 `FloatingPoint<T>` 会排除合法用例；(c) 与 `mat3Cast`/`quatCast` 需收紧至 `FloatingPoint<T>` 的场景（含浮点运算如 `sqrt`/`trace`）区分。

---

## 问题 7（一般）

**问题描述**：§3.13.2 审计表（约第 659-677 行）中 `gtc/matrix_transform.cj` 64 个函数未纳入审计。审计表覆盖了「完整实现」「大部分实现」「stub」三类函数的运行时行为契约，但 64 个 `gtc/matrix_transform.cj` stub 函数仅出现在 §3.13 空桩占位段与 §8.3 覆盖矩阵中，未在 §3.13.2 审计表中体现。下游消费者调用 `gtc/matrix_transform.cj` 的 64 个函数时运行时行为（抛 `Exception("stub")`）未在审计结论中计入 stub 函数计数，导致审计结论中「本阶段 stub 占位的函数」数量（约第 681 行列出 14 个）与实际 stub 数量（14 + 64 = 78 个）严重不符，审计覆盖面不完整。

**所在位置**：§3.13.2 审计表（约第 659-677 行）、审计结论行（约第 680-681 行）

**严重程度**：一般（审计结论函数数量统计不完整，下游按审计结论评估项目完整性时会低估 stub 比例）

**改进建议**：§3.13.2 审计表新增 `gtc/matrix_transform.cj` 64 个函数行（可聚合为一行），标注「本阶段 stub 占位，运行时抛 `Exception("stub")`」；审计结论「本阶段 stub 占位的函数」数量从 14 修订为 78（或明确标注「14 + 64 gtc/matrix_transform = 78」）。

---

## 问题 8（一般）

**问题描述**：§8.2 测试文件清单（约第 1003-1018 行）中 `test_ext_scalar_constants.cj` 行的预计用例数标注为「≥6」，但 §3.12 `scalar_constants.cj` 提供 3 个泛型函数（`epsilon<T>()`/`pi<T>()`/`cos_one_over_two<T>()`）× 2 种浮点类型（Float32/Float64）= 6 个正常路径用例 + 1 个整数类型异常路径用例 = **至少 7 个**。按 §8.2 「完整实现函数：每函数 ≥2 个用例」原则，3 个函数 × 2 类型 × 2（正常 + 边界）= 12 个更合理。当前 ≥6 对应每函数 1 种类型 1 个用例，覆盖比例偏低。

**所在位置**：§8.2 测试文件清单表 `test_ext_scalar_constants.cj` 行（约第 1014 行）

**严重程度**：轻微（测试覆盖不足不影响设计正确性，但阶段三验证标准可能偏低）

**改进建议**：§8.2 表 `test_ext_scalar_constants.cj` 行预计用例数从 ≥6 修订为 ≥7（3 函数 × 2 类型 + 1 整数异常 = 7）或 ≥12（按用例分配原则）。

---

## 核查记录（无需修复）

**记录 1**：v13 修订的 6 项关键事实错误（lib.cj 行数、matrix_transform 函数数 35→64、生成脚本路径、fwd.cj 注释字样、fromVec3 GLM 引用路径与触发条件、matrix_transform 遗漏/虚构函数）经独立核验均确认已正确修复：(1) `cjglm/src/lib.cj` 实际 8 行（已核验）；(2) GLM 1.0.3 `matrix_clip_space.inl` 46 个 + `matrix_transform.inl` 11 个 + `matrix_projection.inl` 7 个 = 64 个函数（已核验 `grep GLM_FUNC_QUALIFIER` 结果一致）；(3) 生成脚本实际位于 `cjglm/scripts/gen_fwd_aliases.py`（已核验文件存在，Python 64 行）；(4) `fwd.cj:1-2` 确为中文注释「自动生成」+「手动修改请谨慎」（已核验）；(5) `fromVec3` 实际位于 `detail/type_quat.inl:196-217`，触发条件为 `real_part < 1e-6f * norm_u_norm_v`，轴选择为 `abs(u.x) > abs(u.z)` 条件分支（已核验 GLM 源码 confirm）。上述 6 项修复准确无误，无需再次修改。
