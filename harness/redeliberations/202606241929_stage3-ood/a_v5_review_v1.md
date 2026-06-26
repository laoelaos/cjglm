# OOD 设计方案审查报告（v5/v9）

## 审查结果

APPROVED

## 逐维度审查

### 1. 类型系统可行性

**[通过]**
- Quat<T, Q> 作为泛型结构体，`@Derive[Hashable]` + `public var x, y, z, w` 数据成员模式，与阶段一 `type_vec3.cj:6,8-10` 与阶段二 9 个 `type_mat*.cj:6,8+` 已验证实践完全一致（通过实际读取项目源码确认）。
- 泛型约束 `where T <: Number<T>`、`where T <: FloatingPoint<T>`、`where T <: Number<T> & Comparable<T>`、`where Q <: Qualifier` 均为仓颉标准库原生接口（`cangjie-std/math/README.md` 第 117 行明确定义 `FloatingPoint<T>`/`Integer<T>`/`Number<T>` 三层接口），约束收紧策略可行。
- 跨 Qualifier 构造 `init<Q2>(q: Quat<T, Q2>) where Q2 <: Qualifier` 与跨类型构造 `fromQuat<U, P>(conv: (U) -> T, q: Quat<U, P>) where P <: Qualifier` 均符合仓颉泛型子类型规则（`cangjie-lang-features/generic/README.md`）。
- `extend` 块中定义运算符（Quat×Vec3、Vec3×Quat 等）符合 `cangjie-lang-features/extend/README.md` 第 2.2 节「为类型添加属性和运算符」+ `function/README.md` 第 8 节运算符重载约束：二元运算符仅一个参数（右操作数）。
- `Quat × T` 标量乘定义为 Quat 成员运算符、`T × Quat` 通过 `scalar_quat_ops.cj` 全局函数实现（因左操作数类型决定 operator 归属）—— `function/README.md` 第 8 节明确规定，与本设计策略一致。
- 同包内文件可直接互相访问（`package/README.md` 第 2.1 节「同一包中所有文件须有相同的包声明」+ 同包直接可见），`type_quat.cj` 调用 `type_quat_cast.cj` 函数无需 import 设计可行。
- `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 重导出符合 `package/README.md` 第 4.6 节「重新导出」语法（已 grep 验证）。
- 测试文件命名 `test_xxx.cj` 与阶段二 `cjglm/tests/glm/detail/` 现有 10+ 个测试文件命名约定一致。

### 2. 标准库与生态覆盖

**[通过]**
- `std.math.sqrt/pow/log/exp/sin/cos/asin/acos/atan/atan2/sinh/cosh/tanh/asinh/acosh/atanh/radians/degrees` 均存在但仅支持 Float64（`cangjie-std/math/README.md` 第 11-16、47-53 行确认），设计 §1「系统性设计约束（v8 新增）：Float32 与 std.math 的交互约束」+ 方案 A「`T(Float64.xxx(Float64(value)))` 模式」对此约束作出系统应对，覆盖 `axis`/`length`/`angleAxis`/`exp`/`log`/`pow`/`sqrt`/`trigonometric.cj` 全部 30 个 stub 函数。
- `FloatingPoint<T>` 接口存在（`math/README.md` 第 117 行），约束收紧策略（D29/D32）将 `where T <: FloatingPoint<T>` 用于 `isnan`/`isinf`/`mat3Cast`/`mat4Cast`/`quatCast`/`epsilon`/`pi`/`cos_one_over_two` 全部 7 处非浮点拒绝场景，编译期保证可用。
- `x.isNaN()`/`x.isInf()` 实例方法存在（`math/README.md` 第 114-115 行），`isnan(q)`/`isinf(q)` 内部实现 `Vec4(q.x.isNaN(), ...)` 路径可行。
- `@Derive[Hashable]` 宏存在（`deriving/README.md`），要求字段 `public` 可见性（第 4 节），与 §3.1 字段标注 `public var` 一致。
- `std.math.abs` 支持 Float16/32/64 与整数（`math/README.md` 第 10 行）；但设计 §3.5/§3.6 选择「内联 abs」而非依赖 `common.cj` stub，规避了对 stub 的运行时依赖风险，设计合理。
- `Public import` 重导出（`package/README.md` 第 4.6 节）+ 同包访问 + 跨包单向依赖，构成完整的包间协作机制。

### 3. 语言特性可行性

**[通过]**
- 运算符重载左操作数类型归属规则（`function/README.md` 第 8.1 节）与 D05 决策一致；本设计 `Quat × T` 通过 Quat 成员运算符实现 + `T × Quat` 通过 `scalar_quat_ops.cj` 全局函数实现的分工符合规则。
- 一元 `-` 运算符可重载（`function/README.md` 第 8.2 节）；一元 `+` 不可重载与 `deviations.md IF-01` 一致，设计 §3.4 明确「仓颉不支持重载一元 + 运算符」正确。
- `const init` 主构造函数（`cangjie-lang-features/const/README.md` 已引用）支持编译期求值，与 `Quat<T,Q>(x, y, z, w)` 等主构造函数标注一致。
- `@OverflowWrapping` 注解（`cangjie-lang-features/reflect_and_annotation/README.md` 已引用）虽对浮点无效果（D19 决策理由），但保持跨整数/浮点实例化统一行为，避免未来整数四元数用例的不可控整数溢出。
- 包间禁止循环依赖（`package/README.md` 第 99 行明文规定）+ 设计采用「detail 承载转换函数 + gtc 通过 public import 重导出」的单向依赖方案（D11/D28 决策），打破循环依赖，符合仓颉规范。
- 模块/包结构（`glm.detail` → `glm.ext` → `glm.gtc` → `glm` 顶层聚合）符合 `cangjie-regulations` 第 1.3 节「包之间的依赖关系应形成有向无环图（DAG）」与 `cjpm` 子包发现机制。
- 资源管理策略（值类型 Quat 自动释放 + 异常路径清晰）与仓颉 RAII/异常模型（`cangjie-lang-features/error_handle/README.md`）匹配。
- §3.7 `cross(Quat)` 与 `cross(Vec3)` 命名歧义通过类型消歧（参数类型 Quat vs Vec3）+ §3.4 「命名约定说明」段澄清，编码可行。
- v9 §1「常量型 T(n) 字面量替代（v9 扩展）」策略 + §3.2.1「T(1) 字面量获取策略」段 + §3.4 `Quat×Vec3` 公式末尾 `* T(Float64(2))` 修订，彻底解决 v8 漏掉的 T(1)/T(2) 字面量获取路径问题，与 GLM `gtc/quaternion.inl:49` `Mat3x3(T(1))` 实际用法对齐。

### 4. 设计一致性

**[通过]**
- 包依赖方向 `glm.gtc → glm.detail` 单向 + `glm.ext → glm.detail` 单向 + `glm` 顶层聚合，符合 cangjie-lang-features package/README.md 第 99 行规定。
- v9 修订严格落实了迭代需求识别的 6 项问题（2 严重 + 2 一般 + 2 轻微）：
  - 问题 1：`fromMat4` 删除错误的 `type_mat2x2.cj:163-165` 列提取模式引用，改为基于「Vec3 主构造 + Mat3x3 主构造（均无 `one` 形参）」的实际构造路径说明，与 §1「T(1) 必须由调用方显式传入参数（`one: T`）」系统性约束闭环。
  - 问题 2：`mat3Cast`/`mat4Cast` T(1) 获取策略在 §3.2.1 明确为「`T(Float64(1))` 显式转换路径」+ §1 扩展为「常量型 T(n) 字面量替代（v9 扩展）」+ 新增 v9 受影响函数清单（`axis`/`Quat×Vec3`/`Quat×Vec4`/`mat3Cast`/`mat4Cast`）。
  - 问题 3：`ext/vector_relational.cj` 的 GLM 文件引用从 `func_vector_relational.inl:18-22`（实际为 `lessThanEqual`）修订为 `glm/gtc/epsilon.inl:32-41`（`epsilonEqual` 实际位置），§3.5 / §5.3 / D24 / §9 共 4 处同步修订。
  - 问题 4：`lib.cj` import 清单从 8 个扩展为 20 个，覆盖 4 个别名文件 + 3 个矩阵 stub + 2 个 gtc 模块 + 2 个四元数 ext stub + 1 个 detail trigonometric stub + 8 个原有声明。
  - 问题 5：`§3.4「交换律别名」` 注中删除错误的「仓颉 `Number<T>` 加法/乘法具备交换律语义」表述，明确 `T * Quat` 通过 `scalar_quat_ops.cj` 全局函数实现的根本原因是左操作数类型决定 operator 函数归属。
  - 问题 6：`§11.5` gtc 重导出行的约束标注修订为「约束继承自 detail 端实现，通过 public import glm.detail.{mat3Cast, mat4Cast, quatCast} 透明传递」，下游消费者明确约束源自 detail 端。
- 边界行为契约（§3.2.1 / §3.3 item 6/7/8 / §5.3）覆盖全面：非单位四元数 `mat3Cast`、非旋转矩阵 `quatCast`、反平行向量 `fromVec3`、零四元数 `axis`、零四元数 `inverse`、整型 T 调用 `isnan`/`isinf`/`epsilon`/`pi`/`转换函数`、`mix`/`slerp` cosTheta 退化、`lerp` a 越界、`equal(v, v, 0)` 返回 false 等均有契约声明。
- §3.15 `gtc/quaternion.cj` 4 重导出 + 4 完整实现 + 7 stub 的职责分组与 §10 覆盖矩阵、§11.5 函数可用性对照表三处完全对齐，无矛盾。
- §3.13.1 `trigonometric.cj` 30 个函数的标量/向量重载区分（14 单参数 × 2 + 1 双参数 × 2 = 30）与 §3.10/§3.11 各 stub 函数对 `acos(T)`/`sin(T)`/`atan(T)` 等标量调用的依赖一致。

### 5. 设计质量

**[通过]**
- 单一职责：每个模块聚焦一类职责（`type_quat.cj` 核心类型 + 成员运算符 / `type_quat_cast.cj` 转换函数 / `quaternion_geometric.cj` 几何 / `quaternion_common.cj` 公共 / `quaternion_trigonometric.cj` 三角 / `quaternion_exponential.cj` 指数 / `scalar_quat_ops.cj` 标量混合）。
- 抽象层次恰当：detail（核心实现层）→ ext（扩展函数库）→ gtc（标准模板库）→ glm（顶层聚合），四层架构清晰。
- 协作关系形成闭环：`type_quat.cj` ↔ `type_quat_cast.cj`（同包）↔ `gtc/quaternion.cj`（public import 重导出）三方协作无缺失环节。
- 测试设计充分：14 个测试文件 + ≥178 用例（v8 修订数）+ `test_xxx.cj` 命名与阶段二一致 + 用例分配原则（完整实现 ≥2/stub ≥1/重导出 ≥1）。
- stub 策略合理：依赖未实现函数（`trigonometric.cj`/`geometric.cj` 向量 `cross`/`common.cj`）的函数统一以 `throw Exception("stub")` 占位，待阶段四补齐；不阻塞本阶段可验证函数的实施。
- 模块间依赖单向、无循环，符合 DAG 要求。
- 下游消费者迁移指南（§11.1-§11.5）覆盖构造、跨类型转换、旋转应用、矩阵-四元数互转等典型场景，附本阶段/阶段四可用性对照表。

## 修改要求

无（所有严重和一般问题均已在 v9 修订中落实）。