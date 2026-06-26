# 第 3 轮质量审查诊断报告（v3 设计）

> **审查对象**：`a_v3_design_v2.md`（即 v7 设计，已在 v1→v6 共 6 轮内部审议中完成 19 项审查意见闭环）
> **审查定位**：本轮侧重于内部审议未充分覆盖的维度——需求响应充分度、整体深度和完整性、事实准确性、逻辑一致性
> **审查方法**：直接查阅仓颉 stdlib 文档（`cangjie-std/math/README.md`）、GLM 1.0.3 实际源码（`references/glm-1.0.3/glm/glm/...`）、项目阶段二实际实现（`cjglm/src/fwd.cj`、`cjglm/src/detail/type_*.cj`、`cjglm/tests/glm/...`）和 `docs/deviations.md`，不依赖文档自证

---

## 一、严重问题（事实错误/直接阻塞编码）

### 问题 1：`gtc/constants` 函数数量自相矛盾——文字计数与函数名清单不一致

- **问题描述**：设计文档多处以"25 个常量函数"作总数描述，但 §3.12 自身列出的常量名清单为 28 个：zero、one、two_pi、tau、root_pi、half_pi、three_over_two_pi、quarter_pi、one_over_pi、one_over_two_pi、two_over_pi、four_over_pi、two_over_root_pi、one_over_root_two、root_half_pi、root_two_pi、root_ln_four、e、euler、root_two、root_three、root_five、ln_two、ln_ten、ln_ln_two、third、two_thirds、golden_ratio。GLM 1.0.3 `glm/glm/gtc/constants.hpp` 实际 `GLM_FUNC_DECL GLM_CONSTEXPR genType` 声明数亦为 28 个。文字与清单相差 3 个。
- **所在位置**：§3.12 末段（"提供 25 个常量函数（...）"）、§8.2 测试设计表（"`gtc/constants_test.cj` ≥25 用例"）、§8「更新文件」段（间接涉及）
- **严重程度**：严重
- **改进建议**：将所有"25"修订为"28"（与 GLM 1.0.3 实际声明数一致），并核对 `gtc/constants_test.cj` 至少 28 个测试用例的覆盖目标。同步核验是否设计有意省略某些常量，若是，需明确说明省略原因（避免被读者误读为偏差）。

### 问题 2：`axis` 函数 T(1) 获取方式描述与项目系统性约束矛盾

- **问题描述**：§3.9 `axis` 函数签名 `axis(x: Quat<T,Q>): Vec3<T,Q>` 无 `one: T` 参数，但实现公式需要 T(1) 两处（`tmp1 = T(1) - x.w*x.w` 与 `tmp2 = T(1) / sqrt(tmp1)`）。§1「系统性设计约束」明确指出："T(1) 的获取：必须由调用方显式传入参数（`one: T`），因为在 `Number<T>` 约束上下文中不存在通用的演算路径"——但 `axis` 函数本身没有 `one` 参数。§3.9 给出的解释 "T(1) 演算（通过 `x.w*x.w` 取得）" 不正确：`x.w*x.w` 计算结果是 w² 而非 1，无法获得 T(1)。阶段二所有需要 T(1) 的工厂函数（如 `Mat3x3.identity(one: T)`、`Mat3x3.diagonal(scalar: T)`）均通过 `one` 参数显式传入 T(1)（见 `cjglm/src/detail/type_mat3x3.cj:125-130`），未发现仅靠 `x.w*x.w` 演算获得 T(1) 的先例。下游编码者按设计字面实现时，将无法确定 T(1) 应如何获得——可能直接复制公式导致编译错误（"expected 'Generics-T', found 'Int64'"），或需自行重新设计接口。
- **所在位置**：§3.9 `axis` 函数描述（约第 443 行附近）
- **严重程度**：严重
- **改进建议**：二选一：
  - (A) 将 `axis` 签名修订为 `axis(x: Quat<T,Q>, one: T): Vec3<T,Q>`，与 `identity(one: T)` 风格一致；公式 `T(1)` 替换为 `one`；
  - (B) 显式说明 T(1) 的替代获取路径（如通过 cangjie stdlib 提供的 `T(Float64(1))` 转换在函数体内显式构造，并标注该转换在 `Number<T>` 约束下需 `T` 实现 `Float64` 转换的事实），并在 §8 编码启动前验证项新增 "T(1) 替代获取方式" 验证项。
  - 同时删除/修正"通过 `x.w*x.w` 取得"的错误描述。

### 问题 3：`fromMat4` 降维策略未明确，与阶段二 fromMat 模式不一致

- **问题描述**：§3.3 item 7 描述 `fromMat4(m: Mat4x4<T,Q>)` "内部先降维至 3×3 矩阵（提取左上 3×3 子矩阵**或**按 GLM 策略转换为 Mat3x3）再调用同包 `quatCast`"。GLM 1.0.3 实现是 `quat_cast(mat3x3(m4))`（即依赖 `mat<3,3,T,Q>(mat<4,4,T,Q>)` 构造函数）。但 §3.3 item 7 的签名缺少 `one: T` 参数——这与阶段二 `Mat3x3.fromMat4(m: Mat4x4<T, SrcQ>, one: T): Mat3x3<T, Q>` 模式（`cjglm/src/detail/type_mat3x3.cj:192`）不一致。阶段二的 `fromMat` 模式要求显式 `one: T` 参数处理维度截断/扩展时填充值。设计给出"或"的选择（"提取左上 3×3 子矩阵 **或** 按 GLM 策略转换为 Mat3x3"），但两种方式的语义不同：手动提取不需要 `one` 参数；Mat3x3 构造函数则依赖仓颇是否存在 `Mat3x3<T,Q>(Mat4x4<T,Q>)` 构造重载（阶段二未提供）。下游编码者无法决定采用哪种。
- **所在位置**：§3.3 item 7（约第 308 行）
- **严重程度**：严重
- **改进建议**：
  - 明确选择其中一种策略；
  - 若选"提取左上 3×3 子矩阵"：需明确说明提取方式（手动逐元素构造 `Mat3x3(Vec3(m4.c0.x, m4.c1.x, m4.c2.x), ...)` 模式，与阶段二 `cjglm/src/detail/matrix.cj:22` 中 `transpose` 的实现一致）；
  - 若选"按 GLM 策略转换为 Mat3x3"：需先在阶段二 `Mat3x3` 扩展 `fromMat4x4(m: Mat4x4<T, SrcQ>): Mat3x3<T, Q>` 工厂函数（无需 `one: T`），并明确这是阶段三的并行任务；
  - 删除"或"的表述，避免两可。
  - 同时核对 §3.3 item 6（`fromMat3`）是否也需类似调整——若阶段二 `Mat3x3` 已有 `fromMat3(m: Mat3x3<T, SrcQ>, one: T): Mat3x3<T, Q>` 模式，阶段三 `fromMat3(m: Mat3x3<T, Q>)` 反而偏离了"同类型赋值"语义；建议明确 `fromMat3` 主要用途是同类型构造（直接用主构造即可），还是用于跨 Qualifier 构造。

### 问题 4：`Mat2x2/FMat2x2` 双别名机制引用错误——阶段二并不存在 `FMat2x2`

- **问题描述**：§3.14 与 D27 决策反复引用 "阶段二矩阵采用了 `Mat2x2` 和 `FMat2x2` 双别名机制" 作为阶段三 `Quat`/`FQuat` 双别名设计的依据。但 `cjglm/src/fwd.cj` 实际仅存在：
  - `public type Mat2x2 = detail.Mat2x2<Float32, detail.PackedHighp>`（行 327）
  - `public type DMat2x2 = detail.Mat2x2<Float64, detail.PackedHighp>`（行 347）
  
  阶段二矩阵的真正双别名机制是 **`Mat2x2` (Float32) + `DMat2x2` (Float64)**，而非 `Mat2x2` + `FMat2x2`（Float32 + Float32）。`fwd.cj` 中无 `FMat*` 任何声明。整个 `fwd.cj`（394 行）唯一带 `F` 前缀的别名是 `FVec1`~`FVec4`（行 275-278，`Float32`）和 `F32Vec1`~`F32Vec4`（行 292-295，`Float32`）——这是 Vec 家族的现象，不适用于 Mat 家族。设计错误地套用了 Vec 家族的 `FVec*` 模式到 Mat 家族作为先例。§9 差异声明的 "`Quat`/`FQuat` 双别名机制（v3 新增）" 条目同样基于错误先例。
- **所在位置**：§3.14（约第 539 行 `FQuat` 段落）、§7 D27、§9 差异声明对应条目
- **严重程度**：严重
- **改进建议**：
  - 修订 §3.14 先例引用为：`Vec2` 家族有 `Vec2` (Float32 主别名) + `DVec2` (Float64 主别名) + `FVec2` (Float32 显式别名) 三重模式（见 `fwd.cj:106, 270, 275`），`Quat` 家族的 `Quat`/`FQuat`/`DQuat` 设计沿用此模式；
  - 修订 D27 决策依据；
  - 同步修订 §9 差异声明对应条目；
  - 同时核验：阶段二 Vec 家族既有 `Vec2`/`DVec2` 也有 `FVec2`，那么阶段三 Quat 家族是否也需要 `FQuat` 双重别名（Vec 家族有重复别名，Mat 家族无 `FMat*`）——这种内部不一致是设计依据而非新问题，但应在 §3.14 明确说明阶段三的决策理由。

---

## 二、一般问题（关键遗漏/可读性不足/影响可操作性）

### 问题 5：测试文件命名约定与现有项目不一致

- **问题描述**：§8.2 测试设计表 13 个测试文件均使用 `xxx_test.cj` 命名（如 `type_quat_test.cj`、`type_quat_cast_test.cj`）。但阶段二实际项目 `cjglm/tests/glm/detail/` 25 个测试文件全部使用 `test_xxx.cj` 命名（如 `test_type_mat2x2.cj`、`test_common.cj`、`test_geometric.cj`），无任何 `xxx_test.cj` 形式。下游按设计字面创建测试文件将导致与现有测试目录命名风格不一致，增加 grep/file list 工具的使用成本。
- **所在位置**：§8.2 测试设计表
- **严重程度**：一般
- **改进建议**：将 13 个测试文件名统一调整为 `test_xxx.cj` 风格（`test_type_quat.cj`、`test_type_quat_cast.cj`、`test_vector_relational.cj` 等），与 `cjglm/tests/glm/detail/` 现有约定对齐。

### 问题 6：`trigonometric.cj` 函数清单未区分标量/向量重载

- **问题描述**：§3.13 表行描述 `trigonometric.cj` 含 15 个函数（`sin`/`cos`/`tan`/`asin`/`acos`/`atan`/`atan2`/`sinh`/`cosh`/`tanh`/`asinh`/`acosh`/`atanh`/`radians`/`degrees`），但 §3.11 `mix`/`slerp` 描述明确要求 `trigonometric.cj` 提供 `acos(T): T`/`sin(T): T` **单参数标量版本**。GLM 1.0.3 `glm/glm/trigonometric.hpp` + `detail/func_trigonometric.inl` 实际同时提供标量版本（`sin(genType)` 通过 `using ::std::sin;` 引入 C++ 标准库的标量版本）和向量版本（`sin(vec<L, T, Q>)` 通过 functor1 包封）。`atan` 还有单参数和双参数两种标量形式。设计未在 §3.13 明确这些重载形式，下游编码者只声明 15 个函数名（默认向量版本）会导致 `mix`/`slerp`/`roll`/`pitch`/`yaw`/`pow`/`log` 等的 `acos(T)`/`sin(T)`/`atan(T)` 调用编译失败。
- **所在位置**：§3.13 表（约第 503-509 行）
- **严重程度**：一般
- **改进建议**：在 §3.13 表中明确 `trigonometric.cj` 应提供 30 个函数（15 标量 + 15 向量），并补充 `atan` 的双参数标量版本（`atan2(T, T): T`）。或新增 §3.13.1 子节明确"标量版本用于 `slerp`/`mix`/`pow` 等内部分量运算；向量版本用于后续阶段四的 vec 级运算"。

### 问题 7：`axis` 函数 Float32 sqrt 处理策略缺失

- **问题描述**：§3.7 `length` 函数描述已明确："`std.math.sqrt` 签名仅支持 Float64 输入/输出，Float32 实例需显式转换（实现阶段明确采用 `T(Float64.sqrt(Float64(dot_qq)))` 路径或额外声明 Float32 重载）"。但 §3.9 `axis` 函数同样使用 `sqrt(tmp1)`（其中 `tmp1: T`），对 T 为 `Float32` 时如何处理未作说明。`std.math.sqrt` 仅接受 `Float64`（见 `cangjie-std/math/README.md` 第 11 行），`Float32` 实例化时 `sqrt(tmp1)` 编译失败。设计仅在 `length` 一处明确该问题，未将 Float32 sqrt 处理策略作为一般性约束贯彻到所有 `std.math` 函数调用。
- **所在位置**：§3.9 `axis` 函数描述
- **严重程度**：一般
- **改进建议**：在 §1「系统性设计约束」中新增"Float32 与 std.math 的交互约束"段落，统一说明 `std.math` 所有函数（sqrt/pow/log/exp/sin/cos/asin/acos/atan）仅支持 Float64，Float32 实例化时需显式 `T(Float64.xxx(Float64(...)))` 转换，或额外声明 Float32 重载；将 `axis`/`length`/`angleAxis`/`exp`/`log`/`pow`/`sqrt` 等所有使用 `std.math` 的函数均引用该一般性约束，避免逐函数重复说明。

### 问题 8：`fromVec3` 工厂函数边界行为契约缺失

- **问题描述**：§3.3 item 8 将 `fromVec3(u, v)` 标记为 "stub 占位"，但未说明 `u` 和 `v` 平行/反平行等特殊场景的行为契约。GLM 1.0.3 `type_quat.inl:196-217` 实际有特殊处理：当 `real_part = norm_u_norm_v + dot(u, v) < 1.e-6 * norm_u_norm_v`（即 u, v 接近反平行）时，采用 180° 任意垂直轴的退化路径。设计未说明此边界场景，编码阶段如按字面 stub 实现（`throw Exception("stub")`），将无法告知下游"何时可以调用、何时不应调用"。
- **所在位置**：§3.3 item 8、§5 错误处理策略、§5.3 边界条件表
- **严重程度**：一般
- **改进建议**：在 §3.3 item 8 补充"边界场景：u, v 反平行时返回 180° 任意轴四元数（GLM 退化路径）；与 GLM `type_quat.inl:196-217` 一致"契约说明；在 §5.3 边界条件表新增"`fromVec3(u, v)` u/v 反平行"行；§11.5 函数可用性对照表新增对应条目（虽为 stub，但契约应明确）。

### 问题 9：`mat3Cast`/`mat4Cast` 接受非旋转矩阵的边界行为契约未与 §3.3 工厂函数对齐

- **问题描述**：§3.3 item 6 已对 `Quat.fromMat3` 明确"仅对纯旋转矩阵产生有意义的四元数；对非旋转矩阵行为未定义"契约。但 §3.2.1 中 `mat3Cast<T, Q>(q: Quat<T, Q>): Mat3x3<T, Q>` 的描述未同步这一边界声明。`mat3Cast` 接受任意 Quat 输入（即使 Quat 是非单位四元数），返回的 3×3 矩阵行为也未定义——GLM 1.0.3 同样无保护。下游消费者可能误以为 `mat3Cast(q)` 总是返回旋转矩阵。
- **所在位置**：§3.2.1（type_quat_cast 函数签名规范段）、§5 错误处理策略
- **严重程度**：一般
- **改进建议**：在 §3.2.1 签名模板后新增"边界行为契约"段，明确 `mat3Cast`/`mat4Cast` 接受非单位四元数时返回的矩阵不保证是旋转矩阵（缩放/剪切分量保留）；`quatCast` 接受非旋转矩阵时返回的四元数行为未定义。同步在 §5.3 边界条件表新增对应行。

---

## 三、轻微问题（表述/可读性）

### 问题 10：测试文件 `gtc/quaternion_test.cj` 用例数与 gtc 命名空间 API 数量比例失衡

- **问题描述**：§8.2 测试设计表分配 `tests/glm/gtc/quaternion_test.cj` ≥20 个用例，覆盖 15 个 gtc 函数（4 转换重导出 + 4 比较 + 4 欧拉 stub + 3 看向 stub）。其中 7 个 stub 函数仅需验证"抛 stub 异常"，4 个比较函数 + 4 个重导出函数实际只 8 个完整实现。20 个用例分摊到 8 个完整实现函数仅 2.5 个/函数，低于其他测试文件（如 `vector_relational.cj` 16 用例/16 重载 = 1:1、`quaternion_geometric.cj` 12 用例/4 函数 = 3:1）。建议明确用例分配规则。
- **所在位置**：§8.2 测试设计表 `gtc/quaternion_test.cj` 行
- **严重程度**：轻微
- **改进建议**：在 §8.2 测试设计补充"用例分配原则"段（完整实现函数每函数 ≥2 用例，stub 函数每函数 ≥1 用例，重导出函数每函数 ≥1 用例验证可达性），并按此原则重算 `gtc/quaternion_test.cj` 用例数（如 8×2 + 7×1 + 4×1 = 27 个）。

### 问题 11：§11.5 函数可用性对照表 `isnan`/`isinf` 行未与 §3.11 `where` 子句约束保持一致

- **问题描述**：§3.11 已明确 `isnan`/`isinf` 添加 `where T <: FloatingPoint<T>` 约束（v7 修订后），§5.3 边界条件表也明确"整型 T 编译期约束收紧为 `where T <: FloatingPoint<T>`"。但 §11.5 函数可用性对照表对应行仅写"✅ 可用（仅浮点 T，整型 T 编译失败，v4 约束收紧，v7 接口名修订）"，未明确具体约束的 where 子句形式。下游迁移者可能不理解为何整型 T 编译失败。
- **所在位置**：§11.5 函数可用性对照表 `isnan`/`isinf` 行（约第 1121 行）、`mat3_cast`/`mat4_cast`/`quat_cast` 行（约第 1130-1131 行）
- **严重程度**：轻微
- **改进建议**：在 §11.5 对应行末尾追加约束标注，如"约束：`where T <: FloatingPoint<T>`（D29/D32）"，便于下游快速理解。

---

## 四、未在本次发现但建议下一轮关注的事项

以下事项不在本轮质量审查范围内（前序内部审议已充分覆盖），但作为下游实施的提醒：

1. **§1 系统性约束中 T(0) 通过 `someValue - someValue` 演算**：在 `Number<T>` 约束下，`-` 运算符对 `Bool` 不可用。`Quat<Bool, PackedHighp>` 实例化时所有依赖 T(0) 演算的函数（如 `identity`）将无法编译。设计已通过 D17 排除 Bool 算术运算，但 `identity` 是否包含在排除范围未明确。
2. **§3.11 `slerp` 4 参数版本 `k: Int64` 简化签名**：GLM 4 参数 `slerp` 的 `S` 是与 `T` 独立的整型参数（`GLM_STATIC_ASSERT(std::numeric_limits<S>::is_integer, ...)`）。设计固定为 `Int64` 牺牲了泛型灵活性，但对阶段三 stub 状态无实际影响。
3. **§4.1 单位四元数 `identity` 调用示例**：`let q = Quat<Float32, PackedHighp>.identity(1.0f)` 在 extend 块中实现时不是 `const`（依据 deviations.md DV-05），不能用于 `const val q = ...` 上下文——设计 §4.1 示例中未提示此限制。
4. **§10 覆盖矩阵 `quaternion_exponential.hpp` 表** `sqrt(Quat)` 行描述 "本阶段 stub"，但 §3.10 描述 `sqrt` 实现为 `pow(x, 0.5)`——若 `pow` 本身为 stub，则 `sqrt` 是否独立声明函数体未明确（stub 函数委托 stub 函数将是双层 stub，行为不变但实现冗余）。

---

## 五、整体质量评价

v7 设计在 v1→v6 内部审议 19 项审查意见闭环后已相当成熟：

- **结构完整**：11 个章节覆盖了目标范围、模块划分、核心抽象、行为契约、错误处理、设计决策、产出物清单、GLM 覆盖矩阵、下游迁移指南。
- **关键决策清晰**：D11 包间循环依赖规避、D28 单向依赖约束、D29/D32 约束收紧、D31 `axis` 公式路径修订均为高质量设计决策，且与仓颉 stdlib/包模型约束一致。
- **§3.16 路线图同步 + §11.5 权威基准**双重保障机制设计良好，避免设计文档与外部文档状态不一致。

但本轮发现 4 项严重问题（事实错误/阻塞编码）+ 5 项一般问题 + 2 项轻微问题，其中：

- **问题 1**（常量函数数量自相矛盾）和 **问题 2**（`axis` T(1) 获取方式）属于**设计内部不自洽**，即使未依赖外部参考也能发现——说明前序审议对"设计自身一致性"维度覆盖不足；
- **问题 3**（`fromMat4` 降维策略）和 **问题 4**（`FMat2x2` 先例引用）属于**与项目实际状态不一致**，可通过直接查阅阶段二代码确认——前序审议主要依赖文档自证，未充分交叉对照实现。

建议下一轮重点针对 §3.3（构造函数体系）、§3.12（scalar_constants / gtc constants）、§3.13（trigonometric 空桩清单）三处进行项目实现层面的对照核验，并在 §1 系统性约束中增补"Float32 与 std.math 交互约束"作为一般性约束，避免重复说明。

---

**完成。本报告共识别 11 项质量问题（4 严重 + 5 一般 + 2 轻微），不重复前序 19 项内部审议已闭环问题。**
