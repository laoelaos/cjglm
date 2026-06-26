# OOD 设计方案审查报告（v4）

## 审查结果

APPROVED

## 审查范围

- 待审查文件：`a_v4_copy_from_v3.md`（v8 设计）
- 完整需求：`requirement.md`（GLM 1.0.3 仓颉迁移阶段三 OOD）
- 本轮迭代需求：`a_v4_iteration_requirement.md`（v3 诊断报告 11 项问题）

本审查独立基于 v8 设计文档、仓颉语言规范（cangjie-lang-features / cangjie-std）、GLM 1.0.3 参考实现、阶段二 `cjglm` 实际代码现状进行，未受前序审议结论约束。

## 逐维度审查

### 1. 类型系统可行性

**[通过]** `Quat<T, Q>` 选择为泛型 struct（与阶段一 Vec / 阶段二 Mat 形态一致），符合仓颉类型系统能力——struct 为值类型、字段可直接标注 `public var` 满足 `@Derive[Hashable]` 派生宏要求（`cangjie-std/deriving/README.md` 第 4 节硬性要求「参与派生的字段/属性必须为 public」），与 `type_vec3.cj:6-10` 既有模式完全对齐。

**[通过]** `where T <: Number<T>, Q <: Qualifier` 约束策略贯穿所有运算符/扩展函数，与阶段二 `scalar_vec_ops.cj:6-81`、`scalar_mat_ops.cj`、`matrix.cj` 100+ 处统一实践对齐；`@OverflowWrapping` 注解在算术运算符上一致标注（已通过 grep 验证阶段一 Vec3 与阶段二全部矩阵类型均采用此模式）。

**[通过]** `where T <: FloatingPoint<T>` 用于 `isnan`/`isinf`/`mat3Cast`/`mat4Cast`/`quatCast` 函数签名——`FloatingPoint<T>` 为仓颉 stdlib 原生接口（`cangjie-std/math/README.md` 第 117 行定义 `FloatingPoint<T>`/`Integer<T>`/`Number<T>` 三层接口体系），编译期保证可用；约束收紧策略与 D29/D32 设计决策一致。

**[通过]** 重载区分可行——`mat3Cast`/`mat4Cast` 通过 `Mat3x3<T,Q>` vs `Mat4x4<T,Q>` 参数类型区分；`quatCast` 的 Mat3 / Mat4 重载同样通过参数类型区分，仓颉泛型重载规则支持此场景。

**[通过]** `const init(x, y, z, w)` 编译期构造函数、`extend<T, Q>` 块成员运算符（Vec3×Quat / Vec4×Quat 通过 Vec 的 extend 块反向引用 Quat）、`public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 重导出——三种语法形态均与 `lib.cj` 既有的 `public import glm.detail.{...}` 重导出模式一致（`lib.cj:2-8` 现存 7 个 `public import` 声明），cjpm 构建系统对该模式已验证可行。

**[通过]** Vec3×Quat / Vec4×Quat 跨类型运算符——左操作数类型为 Vec，通过 Vec 的 extend 块成员运算符定义，依赖同包前向引用延迟解析。设计文档明确标注「已通过阶段二原型验证，仅为防御性确认」，与阶段二 `type_vec3.cj:163-184` 中 `Vec3 * Mat3x3` 模式同构。

**[通过]** 类型形态选择（class / interface / abstract class / enum / sealed class）未涉及——本设计全部采用 struct + extend 块模式 + 包级 public func 模式，与阶段一/二既有架构完全一致，不引入新的类型形态。

**[轻微]** §3.3 item 7 `fromMat4` 决策的论证文字与项目实际状态略有出入：v8 文档解释 v7 双选项时称「Mat3x3 构造函数依赖阶段二未提供的 `Mat3x3<T,Q>(Mat4x4<T,Q>)` 构造重载」，但 `cjglm/src/detail/type_mat3x3.cj:192` 已存在工厂函数 `public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat3x3<T, Q>`（带 `one: T` 参数）。该工厂函数与构造函数 `Mat3x3<T,Q>(Mat4x4<T,Q>)` 是不同的概念——v8 的论述在语义上正确（构造函数确实未提供），但未明确说明工厂函数的存在，可能让读者误以为 Mat3x3→Mat4x4 维度的全部降维能力均缺失。**最终决策（手动提取三列）合理且可行**，与 `type_mat3x2.cj` 等阶段二 `fromMat` 实现的列提取模式同构（`type_mat2x2.cj:163-165` `Mat2x2.fromMat(Mat3x3, one: T)` 即采用 `Vec2(m.c0.x, m.c0.y)` 列提取写法）。此条仅为表述细节，不影响设计可行性。

### 2. 标准库与生态覆盖

**[通过]** `std.math.sqrt` / `pow` / `log` / `exp` / `sin` / `cos` / `asin` / `acos` / `atan` / `atan2` 等数值函数仅支持 Float64 输入/输出——v8 设计在 §1「Float32 与 std.math 的交互约束」段已明确该约束（依据 `cangjie-std/math/README.md` 第 13 行「math 库提供的是面向 Float64 的数值函数」），并提出「方案 A（推荐）」：`T(Float64.xxx(Float64(value)))` 显式转换路径。该模式虽未在现有代码中大规模使用（因阶段二 `length` 等 stub 不涉及 Float32 sqrt），但语法上可行——`Float64` 字面量可显式构造为 Float32 或 Float64，与阶段二 `shim_limits.cj` 中硬编码类型特定值（如 `Float32(1.1920929e-7)`、`Float64(2.220446049250313e-16)`）的模式一致。

**[通过]** `x.isNaN()` / `x.isInf()` 实例方法——`cangjie-std/math/README.md` 第 114-115 行确认存在，限浮点类型；`where T <: FloatingPoint<T>` 约束保证编译器在整数 T 实例化时拒绝该方法（`Int64` 不实现 `FloatingPoint<Int64>` 接口），与 GLM `GLM_STATIC_ASSERT(is_iec559, ...)` 行为等价。

**[通过]** `Float64.NaN` / `Float64.Inf` / `Float64.Max` / `Float64.Min` 常量可用于次正规数边界检查与退化分支处理；`Number<T>` / `Comparable<T>` / `Equatable<T>` / `Hashable` 接口覆盖本设计所需的全部类型约束。

**[通过]** `Number<T>` 约束在无参泛型构造函数不可用（与阶段二 D29 一致），通过「`someValue - someValue` 演算 T(0) + `one: T` 形参获取 T(1)」+「`T(Float64(1))` 字面量替代」策略应对——与 `deviations.md DV-04`（`epsilonOf<T>(hint: T)` 需要 hint 参数辅助类型推断）所确立的「带值参数的运行时分派」模式完全一致，且 `scalar_constants.cj` 中 `match` 类型模式匹配（`case _: Float32 => ... case _: Float64 => ...`）与阶段一 `isIec559Of` 既有实现同构。

**[通过]** ULP 比较函数本阶段以空桩占位——仓颉无浮点位表示直接访问能力（无 `reinterpret_cast`/`union` 等价机制）的判断正确；与阶段一 `equalEpsilon` 仅提供绝对容差、不实现 ULP 比较的实际状态一致。

**[轻微]** §3.10 `pow`/`log` 依赖 `FloatingPoint<T>.getMin()` / `FloatingPoint<T>.getInf()` 实例方法的描述与 stdlib 公开 API 状态可能存在小偏差——`cangjie-std/math/README.md` 仅展示 `Float64` 类型上的静态常量（`Float64.Inf`、`Float64.Min`、`Float64.Max`、`Float64.NaN`），未明确 `FloatingPoint<T>` 接口是否提供 `getMin()`/`getInf()` 通用实例方法。v8 设计已在 §8 编码启动前验证项 16/18 中给出「若不提供则采用 fallback 路径」的应对方案（`T(1)/T(0)` 显式构造、硬编码类型最小正值等），约束覆盖完备。**但下游编码可能需要进一步核实 `FloatingPoint<T>` 接口的方法集**，或在无法确认时直接采用 fallback 实现（如 `exp(y * log(x.w))` 完全规避 `pow`）。本条已在验证项中识别，不构成阻塞。

### 3. 语言特性可行性

**[通过]** 错误处理策略——`throw Exception("stub")` 占位、`assert(...)` 运行时断言（`lerp` 中 `assert(a >= 0 && a <= 1)`）、`throw Exception("not defined for non-floating-point types")` 运行时分派错误——三种策略均与阶段一/二既有实践一致（`common.cj:5-16` `abs`/`min`/`max`/`clamp` 等 stub 函数统一 `throw Exception("stub")`；`type_vec3.cj:33-49` `assert` + `throw Exception(...)` 双重保护）。

**[通过]** 算术溢出策略——`@OverflowWrapping` 标注于所有算术运算符，对浮点无效果但保持跨整数/浮点实例化的一致性，与 `deviations.md` 既有策略对齐。

**[通过]** const 上下文约束——`lerp`/`conjugate`/`inverse` 不可在 const 上下文调用的设计（因 `assert`/`throw` 非 const 函数），与 `deviations.md IF-03`（`componentAt` 不可在 const 上下文使用）模式一致。

**[通过]** 模块/包结构——`src/gtc/` + `package glm.gtc` 是 cjpm 子包发现机制的扩展应用，§2 末尾已明确 cjpm 子包构建预验证策略（阶段二 `src/ext/` + `package glm.ext` 已通过验证，阶段三 `src/gtc/` 需原型验证）+ 失败回退方案（迁移至 `src/` 根目录 + 降级 `package glm`）。预验证策略完备，不构成设计缺陷。

**[通过]** 包间依赖方向——`glm.gtc → glm.detail` 单向依赖（`cangjie-lang-features package/README.md` 第 99 行「不允许循环依赖」），`type_quat.cj` 调用同包 `type_quat_cast.cj` 函数（同包内可见无需 import），`gtc/quaternion.cj` 通过 `public import` 重导出——依赖 DAG 无环，cjpm 构建系统可编译。

**[通过]** `Vec3×Quat` / `Vec4×Quat` 跨包运算符——`Vec3×Quat` 通过 `inverse(q) * v` 路径（§3.4 实现链路注释段已明确完整依赖链：`Vec×Quat` → `inverse`（§3.11 已完整实现）→ `conjugate(q) / dot(q, q)`，其中 `conjugate` 无外部依赖、`dot` 由 `quaternion_geometric.cj` §3.7 已完整实现）。整条依赖链终止于已实现的算术运算和 `dot` 函数，**无 stub 中转**，与 `Quat×Vec3`（依赖 `geometric.cj` 向量 `cross` stub）形成对比，符合阶段二既有模式（`type_vec3.cj:163-184` 中 `Vec3 * Mat3x3`）。

**[通过]** `Number<T>` 与 `Bool` 的类型约束关系——`Bool` 不实现 `Number<T>` 接口（`cangjie-std/core/README.md` 基础类型表），`Quat<Bool, Q>` 实例化时算术运算符因约束不满足编译期自动拒绝，与 §3.4 v7 修订「Bool 四元数算术运算编译期拒绝」段一致；比较运算符 `==`/`!=` 通过 `Equatable<Bool>`（stdlib 派生支持）单独可调用，符合 D17 决策意图。

### 4. 设计一致性

**[通过]** §2 模块间依赖图与文件归属一致——`type_quat.cj` 调用同包 `type_quat_cast.cj`（无需 import）、`gtc/quaternion.cj` 通过 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 重导出——依赖方向严格单向（`glm.gtc → glm.detail` + `glm.ext → glm.detail` + `glm.detail` 不依赖任何上层包）。

**[通过]** 协作关系闭环——`Quat×Vec3` / `Vec3×Quat` / `Quat×Vec4` / `Vec4×Quat` 四种交叉模式全部有明确的实现位置（Quat extend 块 / Vec extend 块）与依赖链；`Mat3←Quat` / `Mat4←Quat` / `Quat←Mat3` / `Quat←Mat4` 四种矩阵-四元数互转通过 `detail/type_quat_cast.cj` + `gtc/quaternion.cj` 重导出闭环。

**[通过]** 行为契约描述——§3.3 各构造函数、`§3.4` 运算符表、`§4` 关键行为契约（提供 5 类典型用例代码块）、`§5.3` 边界条件表（13 行场景 × 函数 × 行为）四层契约描述互为镜像，闭环完备。

**[通过]** stub 占位策略一致性——所有 stub 函数统一 `throw Exception("stub")`、测试用例统一「验证抛 stub 异常」、路线图标注 `[待 Stage 4]` 三层标注口径统一（§3.16 阶段三验证标准双向映射表），下游验证可按统一符号操作。

**[通过]** lib.cj 新增 import 清单（§2 已明确 8 个 `import` 声明）与 fwd.cj 新增 type alias 清单（§3.14 已明确 8 个别名 + 排除项）——清单具体可操作，不依赖下游推断；与阶段二 `lib.cj` 现有 7 个 `public import` 声明模式一致。

**[通过]** 测试设计一致性——13 个测试文件统一使用 `test_xxx.cj` 命名约定（v8 修订后），与项目阶段二 `tests/glm/detail/` 现有 25+ 文件全部采用 `test_xxx.cj` 风格一致（已通过 grep 验证）；用例分配原则（完整实现 ≥2 / stub ≥1 / 重导出 ≥1）逻辑自洽，27 个 `test_quaternion.cj` 用例分配符合公式（8 × 2 + 4 × 1 + 7 × 1 = 27）。

### 5. 设计质量

**[通过]** 单一职责原则——`type_quat.cj` 承载类型定义 + 运算符、`type_quat_cast.cj` 承载矩阵-四元数互转、`quaternion_geometric.cj` 承载几何函数、`quaternion_common.cj` 承载公共函数、`quaternion_trigonometric.cj` 承载三角函数、`quaternion_exponential.cj` 承载指数函数——每个抽象的职责单一明确。

**[通过]** 抽象层次恰当——`glm.detail` 核心实现层（不依赖上层）+ `glm.ext` 扩展函数库 + `glm.gtc` gtc 命名空间 + `glm` 顶层公共 API 面——四层抽象层次清晰，未引入过度设计（无 abstract class / interface 多余抽象），也未设计不足（边界行为契约完备）。

**[通过]** 详细设计与实现的桥梁——§3.2.1 给出 `mat3Cast`/`mat4Cast`/`quatCast` 4 个函数完整签名模板（与 `cangjie` 类型约束语法一致）、§3.13.1 给出 `trigonometric.cj` 30 个函数的完整签名模式、§3.3 给出 10 个构造函数/工厂函数完整签名模板——下游编码可直接按模板实现。

**[通过]** 可测试性——stub 函数统一 `throw Exception("stub")` 便于测试断言；完整实现函数提供 `identity(1.0f)` / `wxyz(...)` 等明确调用入口；`Quat×Vec3` 旋转公式采用两次 Vec3 叉乘可独立测试；§8.2「type_quat_cast 单元测试：使用『旋转矩阵 * 向量 = 四元数 * 向量』等价性测试」提供可 mock 的等价性验证路径。

**[通过]** §9 差异声明完备——33 项差异条目（包含 v8 修订的 `Quat`/`FQuat`/`DQuat` 三重别名机制、`Mat2x2/FMat2x2` 先例引用纠正、`Quat×Vec3` 两次叉乘公式、`isnan`/`isinf` 约束收紧、字段 `public var` 标注、包间依赖方向严格单向、`FloatingPoint<T>` 接口命名对齐等）——下游消费者可逐项理解与 GLM C++ 的偏差与原因。

**[通过]** 命名一致性——`Quat` / `FQuat` / `DQuat` + 精度变体的三重别名模式与阶段一 `Vec2` / `DVec2` / `FVec2` 三重模式对齐（已通过 fwd.cj:106/123/276 验证）；运算符/函数命名（`cross`、`length`、`normalize`、`dot` 等）与 Vec/Mat 既有命名一致。

**[通过]** 编码启动前验证项完备——18 个验证项（v3 新增 3 项 + v4 新增 2 项 + v5 新增 4 项 + v7 新增 1 项 + v8 新增 1 项）覆盖 cjpm 子包构建、约束收紧、命名消歧、Float32/64 转换、字段可见性等关键风险点，下游编码可按验证项顺序推进。

## 综合结论

v8 设计在五个审查维度上均无严重或一般问题，存在 2 条轻微级改进建议（不阻塞）：

- **轻微 1**：§3.3 item 7 关于 v7 双选项的论证文字与项目实际状态存在小偏差——`cjglm/src/detail/type_mat3x3.cj:192` 已存在 `Mat3x3.fromMat(Mat4x4, one: T)` 工厂函数（带 `one: T` 参数），v8 决策的最终方案（手动提取三列）合理可行且与项目既有模式同构，仅论证描述略需澄清。

- **轻微 2**：§3.10 `pow`/`log` 依赖 `FloatingPoint<T>.getMin()`/`getInf()` 实例方法的描述需下游编码启动前核实 `FloatingPoint<T>` 接口实际方法集——若接口未提供，fallback 路径（`T(1)/T(0)` 显式构造 + 硬编码类型最小正值）已完备；§8 验证项 16/18 已识别此风险。

设计在类型系统、标准库覆盖、语言特性、设计一致性、设计质量五个维度均与仓颉语言能力对齐，与阶段一/二既有架构与实践一致。下游可按本设计文档直接推进编码实现。

## 修改要求

无（仅含 2 条轻微改进建议，不阻塞设计通过）。