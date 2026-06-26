# OOD 设计方案审查报告（v3）

## 审查结果

REJECTED

## 逐维度审查

### 1. 类型系统可行性

**[通过]** 设计中的核心类型形态选择（`Quat<T, Q>` 泛型结构体、`public var` 字段 + `@Derive[Hashable]` 派生、`T <: Number<T>, Q <: Qualifier` 约束、extend 块成员运算符、全局具名函数 `add/sub/mul/div`）与仓颉类型系统能力匹配：

- 双泛型参数结构体 + `@Derive[Hashable]` 派生模式与阶段二 `type_mat2x2.cj:7` 等 9 个矩阵文件（200+ 处统一实践）完全一致
- `@Derive[Hashable]` 派生宏对字段 `public` 可见性的硬性要求在 `cangjie-std/deriving/README.md` 第 4 节明确规定，本设计 §3.1 v4 修订已显式标注 `public var x: T, public var y: T, public var z: T, public var w: T`，与阶段一 Vec3、阶段二全部矩阵类型对齐
- 运算符重载体系（Quat 的 extend 块成员运算符、Vec3/Vec4 的 extend 块成员运算符、全局具名函数 `add/sub/mul/div` 处理标量左侧运算）与阶段二 `type_mat2x2.cj:49-72` + `scalar_mat_ops.cj` 模式完全一致，仓颉 operator func 限制已被现有实践验证
- `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 的重导出模式符合 `cangjie-lang-features/package/README.md` 第 91 行 `import fullPkg.{a, b}` 语法与第 156-167 行「重新导出」语义
- 重载区分（`mat3Cast`/`mat4Cast` 通过 `Mat3x3<T,Q>` vs `Mat4x4<T,Q>` 参数类型区分；`quatCast` 的 Mat3/Mat4 重载同理）符合仓颉泛型重载规则

**[轻微]** D17 决策「Bool 四元数不支持算术运算」与阶段二 D33 策略一致，但未明确 Bool 四元数（`Quat<Bool, PackedHighp>`）是否注册到 `fwd.cj` 别名清单（§3.14 仅明确「不含 BQuat 别名」但未在类型层禁用 Quat<Bool, *> 的实例化）。如未来用户实例化 Bool 四元数，运算符重载因 `Bool` 不实现 `Number<T>` 接口而编译期失败，行为已隐式正确，但建议在 §3.4 运算符体系表备注中增加「Bool 四元数因 `Bool` 不实现 `Number<T>` 接口，编译期自动拒绝算术运算」一句话澄清，提升设计意图可读性。

### 2. 标准库与生态覆盖

**[通过]** 设计中需要的能力均在仓颉标准库覆盖范围内：

- `std.math.sqrt(Float64): Float64`、`std.math.pow(Float64, Float64): Float64`、`std.math.log(Float64): Float64`、`std.math.exp(Float64): Float64`、`std.math.abs(...)` 等在 `cangjie-std/math/README.md` 第 10-19 行明确提供
- `x.isNaN()`/`x.isInf()` 实例方法在 `cangjie-std/math/README.md` 第 114-115 行明确提供，`Float64.NaN`/`Float64.Inf`/`Float64.Max`/`Float64.Min` 常量在第 111-113 行明确提供
- 设计 §3.7 已正确识别 `std.math.sqrt` 仅支持 Float64 输入/输出，Float32 实例需显式转换（`T(Float64.sqrt(Float64(dot_qq)))`），与 stdlib 实际签名匹配
- `clamp(v, min, max)` 在 `cangjie-std/math/README.md` 第 19 行提供（设计 §3.10/§3.11 已引用）
- ULP 比较以空桩占位策略合理——仓颉无 `reinterpret_cast`/`union` 等价机制（已由 v2/v3 验证），待阶段四评估 `std.math.Float` 位级方案
- 「包级 import + 函数 + 重导出」模式已在阶段二 `lib.cj`（`public import glm.detail.{ Vec1, Vec2, ... }`）与 `fwd.cj` 验证可行
- `cjpm` 子包发现机制对 `src/ext/` + `package glm.ext` 已由阶段二验证（§2 末尾 cjpm 子包构建预验证段），新增 `src/gtc/` + `package glm.gtc` 已设计回退方案

**[轻微]** §3.10 `pow` 函数依赖 `std.math.pow(T, T): T` 实数降级路径，但 `cangjie-std/math/README.md` 第 13 行明确 `pow(base: Float64, exponent: Float64): Float64` 仅支持 Float64 输入/输出。设计 §3.10 已通过 v5 命名消歧段（参数类型 `T` 区分）与 §8 验证项 15（`std.math.pow` 对 `Float32`/`Float64` 的可用性验证）+ v6 补充的 fallback 精度依赖澄清（`exp(y * log(x.w))` 替代路径）覆盖此风险。建议在 §3.10「命名消歧」段额外补充一句：「若 `std.math.pow` 仅支持 Float64，则 `pow(Quat<Float32, Q>, Float32)` 实现路径需先显式转换至 Float64 再降级，fallback `exp(y * log(x.w))` 同步需 Float64 转换」，进一步降低实现歧义。

### 3. 语言特性可行性

**[一般]** 设计在多处使用 `where T <: FloatingPointNumber<T>` 类型约束（§3.2.1 mat3Cast/mat4Cast/quatCast 4 个函数签名、§3.11 isnan/isinf、§3.12 scalar_constants、D29、D32、§5.3 边界条件表、§10 覆盖矩阵、§8 验证项 13/16/17/18），但仓颉标准库数学接口在 `cangjie-std/math/README.md` 第 117 行明确为 `FloatingPoint<T>`、`Integer<T>`、`Number<T>`，**文档中无 `FloatingPointNumber<T>` 接口定义**。更关键的是，本设计自身在 §3.11 描述文本（关于 isnan/isinf 的段落）中使用了 `FloatingPoint<T>` 字样，与同段 where 子句的 `FloatingPointNumber<T>` 形成设计内部不一致。详见「修改要求」段。

**[通过]** 包间依赖方向严格单向（`glm.gtc → glm.detail`、`glm.ext → glm.detail`、上层不依赖下层）符合 `cangjie-lang-features/package/README.md` 第 99 行「不允许循环依赖」约束。D11 决策（`mat3Cast`/`mat4Cast`/`quatCast` 下沉至 `detail/type_quat_cast.cj`，gtc 通过 `public import` 重导出）解决了 v2 设计的 `glm.detail ↔ glm.gtc` 循环依赖问题，与 `cangjie-lang-features/package/README.md` 第 91 + 156-167 行重导出语义匹配。

**[通过]** 错误处理策略与仓颉错误处理能力匹配：
- `throw Exception("stub")` 占位策略符合 `cangjie-lang-features/error_handle/README.md` 异常体系
- `assert(a >= 0 && a <= 1)`（lerp 边界检查）符合 assert 语义
- `Option<>`/空安全类型未在设计中引入，符合「不引入额外语言特性」的迁移原则

**[通过]** 资源管理方案无特殊要求（本阶段不涉及 IO/网络/文件）。模块/包结构设计（`glm/detail` + `glm` + `glm.ext` + `glm.gtc` 四层 + `src/ext/`、`src/gtc/` 子目录）符合 `cangjie-lang-features/package/README.md` 第 2 节「包声明须与相对于 `src/` 的目录路径匹配」与阶段二已验证模式。cjpm 子包构建预验证（§2 末尾）已为 `src/gtc/` + `package glm.gtc` 新不确定性设计验证项 1 + 验证项 2（gtc 重导出 detail 函数验证）+ 回退方案。

**[通过]** 并发设计与资源管理：§6 已明确本阶段不引入并发场景，四元数为值类型，运算符返回新实例，天然线程安全。符合仓颉 `cangjie-lang-features/struct/README.md` 值语义规则。

### 4. 设计一致性

**[通过]** 各抽象的职责描述清晰无歧义：
- §3.1 Quat<T, Q> 数据布局（xyzw）+ 运算符体系 + 工厂函数（identity / fromMat3 / fromMat4 / fromVec3 / fromEuler / wxyz）覆盖 GLM 全部构造路径
- §3.3-§3.15 每个 ext/gtc 文件均明确函数清单 + 本阶段状态 + 依赖关系
- §5 错误处理策略 + 行为契约覆盖 11 类边界条件
- §7 设计决策 D01-D32 完整记录决策依据

**[通过]** 协作关系形成闭环，无缺失环节：
- §3.2 协作关系表覆盖 10 类 Quat×Vec / Quat×Mat 交互
- §3.15 gtc/quaternion.cj 三方协作（type_quat.cj / type_quat_cast.cj / gtc/quaternion.cj）明确定义调用路径
- §2 模块间依赖图覆盖全部新增/沿用文件的 import 方向

**[通过]** 行为契约的描述完整到足以指导后续实现：
- §4「关键行为契约」给出 6 类典型调用示例（构造/旋转/插值/矩阵互转/常量/欧拉角 stub）
- §5.3 边界条件表给出 11 类异常场景的行为契约
- §8 测试设计覆盖 7 类测试维度（含浮点比较策略）+ 13 个测试文件 + ≥171 用例

**[通过]** 模块间依赖方向合理，无循环依赖：
- `glm.gtc → glm.detail` 单向（v3 关键修复）
- `glm.ext → glm.detail` 单向
- `glm` 顶层聚合
- `glm.detail` 不依赖任何上层包

**[轻微]** §3.16「路线图同步修订建议」明确建议 `02_roadmap.md` 三处修订（slerp 可验证性 / lookRotate 命名 / quaternion_common.cj 范围），但设计本身承认「下游验证以本设计 §11.5 函数可用性对照表的 ✅/⚠️/❌ 符号为准」（v6.3 澄清段）。这种「设计文档独立于路线图」的策略有效规避了跨文档不一致风险，但路线图与设计文档的语义分裂可能给项目管理者带来额外解读成本。建议在 §3.16 末尾补充一句：「本设计的可用性标注（§11.5）是阶段三验证的权威基准；路线图的 `[可验证]`/`[部分可验证]`/`[待 Stage 4]` 标注在 v3 迭代结束后由项目管理流程同步修订」，强化跨文档治理责任归属。

### 5. 设计质量

**[通过]** 职责划分遵循单一职责原则：
- `type_quat.cj` 仅承载 Quat 类型定义与运算符
- `type_quat_cast.cj` 仅承载 4 个矩阵-四元数互转函数
- `scalar_quat_ops.cj` 仅承载标量-四元数全局函数
- `scalar_constants.cj` 仅承载 3 个标量常量函数
- 每个 ext/gtc 文件均聚焦于单一职责（trigonometric/geometric/common/exponential/relational）

**[通过]** 抽象层次恰当：
- 不过度设计：未引入额外的设计模式（如策略模式、访问者模式），仅在必要处使用工厂函数（identity/fromMat3/fromMat4/fromVec3/fromEuler/wxyz）
- 不设计不足：所有 GLM 1.0.3 公共 API 均有对应设计项（§10 覆盖矩阵完整映射 12 个 GLM 头文件）

**[通过]** 便于后续详细设计和实现：
- §3.2.1 给出 4 个 `type_quat_cast` 函数签名模板（含泛型参数、约束、返回类型），可直接编码
- §3.3 给出 10 个构造函数的详细签名 + 调用示例
- §3.11 给出 isnan/isinf 的具体实现路径（实例方法 `Vec4(q.x.isNaN(), ...)`）
- §11 下游消费者迁移指南给出 5 类典型迁移场景的 GLM vs 仓颉对比

**[通过]** 便于单元测试（可 mock、可隔离）：
- §8.2 测试设计文件清单与位置明确（13 个测试文件，≥171 用例）
- 浮点比较策略（epsilon 容差 + 旋转等价性 + type_quat_cast 单元测试的「旋转矩阵 * 向量 = 四元数 * 向量」等价性）完整覆盖
- stub 函数以 `Exception("stub")` 占位，测试可断言捕获异常验证 stub 状态
- 跨 Qualifier 实例化（PackedHighp/.../AlignedLowp 6 种精度）+ 跨类型实例化（Float32/Float64 + 整型边界）覆盖完整

**[轻微]** §3.4「Vec extend 块成员运算符」表定义 `Vec3×Quat = inverse(q) * v` 依赖 `quaternion_common.cj.inverse`（已实现），但 `inverse` 函数体内的 `conjugate(q) / dot(q, q)` 又依赖 `dot`（quaternion_geometric.cj 实现）。当 §3.4 表备注列说明「本阶段可验证，通过 inverse 路径」时，未明确 `inverse` 自身依赖 `quaternion_geometric.cj.dot` 已实现的链路（虽然 §3.11 描述中已说明 `inverse` 依赖 `dot`，但 §3.4 表备注未同步引用）。建议在 §3.4「Vec extend 块成员运算符」表后追加一句「注：本阶段 `Vec3×Quat`/`Vec4×Quat` 可立即调用，依赖链 `inverse` → `conjugate`（无依赖） + `dot`（quaternion_geometric.cj §3.7 已完整实现），无 stub 中转」，强化可验证性证据链。

## 修改要求（REJECTED 时存在）

### 问题 1（一般）：`FloatingPointNumber<T>` 接口命名与仓颉标准库不一致

**问题**：本设计在多处使用 `where T <: FloatingPointNumber<T>` 类型约束：

- §3.2.1 mat3Cast/mat4Cast/quatCast 两个重载共 4 个函数签名
- §3.11 `isnan(q: Quat<T,Q>)` / `isinf(q: Quat<T,Q>)` 函数签名
- §3.12 scalar_constants 的 epsilon<T>() / pi<T>() / cos_one_over_two<T>() 约束收紧策略
- D29 / D32 设计决策
- §5.3 边界条件表多行
- §10 覆盖矩阵 type_quat_cast / quaternion_common / scalar_constants 多个表行
- §8 编码启动前验证项 13、16、17、18

但仓颉标准库数学接口在 `cangjie-std/math/README.md` 第 117 行明确为 `FloatingPoint<T>`、`Integer<T>`、`Number<T>`，**文档中无 `FloatingPointNumber<T>` 接口定义**。

更严重的是，本设计自身在 §3.11 描述文本（关于 `isnan`/`isinf` 的段落）中使用了 `FloatingPoint<T>` 字样，与同段 where 子句的 `FloatingPointNumber<T>` 形成设计内部不一致。

§8 验证项 16/17/18 还基于「`FloatingPointNumber<T>` 接口是否提供 `getMin()`/`getInf()` 实例方法」展开验证，但 `FloatingPointNumber<T>` 接口本身在标准库中不存在，因此验证目标无法落地。

**原因**：

1. **编译期直接失败**：若开发人员按设计字面实现 `where T <: FloatingPointNumber<T>` 约束，编译器将报「未定义的接口 `FloatingPointNumber<T>`」错误，§3.2.1 / §3.11 / §3.12 / §5.3 / §10 的「编译期拒绝非浮点 T 实例化」设计意图完全失效。
2. **fallback 路径绕过约束收紧目标**：虽然设计 §3.2.1 / §3.11 / §3.12 提供了 fallback（将约束放宽为 `T <: Number<T>` + `match` 分派 + 抛 `Exception`），但 fallback 是运行时异常而非编译期类型检查，与 GLM 1.0.3 `GLM_STATIC_ASSERT(std::numeric_limits<T>::is_iec559, ...)` 编译期拒绝的语义偏差较大；fallback 还会引入运行时分支开销。
3. **设计内部不一致**：§3.11 描述文本与 where 子句使用不同接口名，破坏设计文档自身的一致性，给后续维护与编码带来歧义。
4. **验证项失效**：§8 验证项 13/16/17/18 基于一个标准库不存在的接口展开，验证目标本身不可达。

**建议方向**：

将设计全文中所有 `where T <: FloatingPointNumber<T>` 统一替换为 `where T <: FloatingPoint<T>`（仓颉 std.math 标准接口名，依据 `cangjie-std/math/README.md` 第 117 行）。具体修订位置：

1. §3.2.1 函数签名模板 4 处：替换 `FloatingPointNumber<T>` 为 `FloatingPoint<T>`
2. §3.11 `isnan`/`isinf` 描述段与函数签名：统一为 `FloatingPoint<T>`，删除设计内部不一致
3. §3.12 scalar_constants 整数类型 T 行为契约段：替换为 `FloatingPoint<T>`
4. §5.3 边界条件表中 3 处 `FloatingPointNumber<T>` 引用：替换为 `FloatingPoint<T>`
5. §10 覆盖矩阵 type_quat_cast / quaternion_common / scalar_constants 表行约束标注：替换为 `FloatingPoint<T>`
6. §8 验证项 13/16/17/18：相应替换为 `FloatingPoint<T>`，并删除 §8 验证项 13 中关于「若 `FloatingPointNumber<T>` 接口不可用则 fallback」的措辞（因 `FloatingPoint<T>` 是标准库原生接口，无「不可用」风险，验证项应改为确认实例方法 `getMin()`/`getInf()` 在 `FloatingPoint<T>` 接口中的可用性——若不存在则 fallback）
7. D29 / D32 设计决策：同步替换接口名
8. §11.5 函数可用性对照表「仅浮点 T，整型 T 编译失败」注释：确认 `FloatingPoint<T>` 约束编译期行为符合预期

替换完成后，设计意图（编译期拒绝非浮点 T 实例化）与 stdlib 原生能力完全匹配，无需依赖 fallback 运行时路径，整数 T 实例化时编译器直接报类型不匹配错误，与 GLM `GLM_STATIC_ASSERT(is_iec559, ...)` 编译期失败语义对齐。
