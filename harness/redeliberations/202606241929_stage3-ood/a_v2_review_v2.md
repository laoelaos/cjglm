# OOD 设计方案审查报告（v2）

> **审查范围**：C:/Develop/Software/cjglm_wp/harness/redeliberations/202606241929_stage3-ood/a_v2_design_v2.md
> **审查定位**：v3 修订设计（迭代第 2 轮），依据组件 B 诊断报告（19 项问题）、组件 B 质询报告（LOCATED）、上一轮审查报告（a_v2_review_v1.md，2 项问题）开展独立审查
> **审查方法**：从仓颉语言类型系统、标准库、语言特性、设计一致性、设计质量五个维度独立评估当前交付物；不沿用上一轮结论

---

## 审查结果

**REJECTED**

---

## 逐维度审查

### 1. 类型系统可行性

**[通过]** `Quat<T, Q>` 泛型结构体定义与仓颉类型系统能力匹配——结构体声明 `Quat<T, Q> where T <: Number<T>, Q <: Qualifier` 符合 `struct/README.md` 第 5 节「泛型结构体」语法；extend 块约束 `extend<T, Q> Quat<T, Q> where T <: Number<T>, Q <: Qualifier` 与阶段一 Vec3（`type_vec3.cj:63`）、阶段二 Mat（`type_mat*.cj`）的实践模式一致。

**[通过]** 运算符重载设计合理——所有算术运算符定义在 `extend Quat<T, Q> where T <: Number<T>` 块中（与阶段一/二一致）；按 `function/README.md` 第 8.1 节，运算符函数允许在 class/struct/extend 中定义、不能为 static、不能为泛型——本设计将运算符置于泛型 extend 块中（类型参数 T 来自 extend 而非运算符函数自身），符合仓颉运算符重载规则。

**[通过]** 跨 Qualifier 构造 `init<Q2>(q: Quat<T,Q2>) where Q2 <: Qualifier`——`struct/README.md` 第 1.4 节规定多个 `init` 构造函数只要构成有效重载即可，类型参数维度差异符合重载规则。

**[通过]** 跨类型构造 `fromQuat<U, P>(conv: (U) -> T, q: Quat<U,P>) where P <: Qualifier`——`extend/README.md` 第 2.3 节允许在泛型 extend 内定义带额外类型参数的成员函数；闭包类型 `(U) -> T` 符合仓颉函数类型语法。

**[通过]** `@Derive[Hashable]` 派生约束——按 `cangjie-std/deriving/README.md` 第 4 节「参与派生的字段类型必须已实现对应接口」要求，字段类型 T、Q 需实现 `Hashable`。设计 §3.1 明确说明 `T <: Number<T>` 约束下数字类型均实现 Hashable；`Q <: Qualifier` 标记类型的派生需在编码启动前验证项 11 中确认；阶段一 Vec3 已在 `type_vec3.cj:6` 实践使用 `@Derive[Hashable]`，模式与 Quat 一致。

**[通过]** `Quat`/`FQuat` 双别名机制——`type_system/README.md` 第 5.5 节明确支持泛型类型别名（无 `where` 约束）；`fwd.cj` 中阶段二矩阵已采用 `Mat2x2`/`FMat2x2` 双别名模式（实测 `public type Mat2x2 = ...`、`public type FMat2x2 = ...` 形式可用），Quat 沿用此模式可行。

**[一般]** **`isnan`/`isinf` 函数缺少类型约束**——设计 §3.11 将 `isnan(q: Quat<T,Q>): Vec4<Bool,Q>` 与 `isinf(q: Quat<T,Q>): Vec4<Bool,Q>` 列为「完整实现」，但函数体内部使用 `q.x.isNaN()`、`q.x.isInf()` 实例方法路径（`Vec4(q.x.isNaN(), q.y.isNaN(), q.z.isNaN(), q.w.isNaN())`）。按 `cangjie-std/math/README.md` 第 5 节，`x.isNaN()`/`x.isInf()` 仅属于浮点类型（`FloatingPoint<T>` 接口），整数类型无此方法。当用户实例化 `Quat<Int64, PackedHighp>` 调用 `isnan(q)` 时，函数体内部 `q.x.isNaN()` 因 Int64 不实现 `isNaN()` 而**编译失败**。设计未对 `isnan`/`isinf` 添加 `where T <: FloatingPointNumber<T>` 约束（与同节 `epsilon<T>()`/`pi<T>()`/`cos_one_over_two<T>()` 设计 §3.12 明确收紧约束 + 运行时 fallback 的处理方式不一致），导致非浮点实例化场景下设计契约不闭环。

### 2. 标准库与生态覆盖

**[通过]** `std.math.sqrt` 仅支持 Float64 输入/输出的限制已识别——设计 §3.7 `length(q)` 小节明确说明「Float32 实例需显式转换（实现阶段明确采用 `T(Float64.sqrt(Float64(dot_qq)))` 路径或额外声明 Float32 重载）」，§8 编码启动前验证项 12 同步列入。设计无对其他未在标准库支持的能力的依赖。

**[通过]** `x.isNaN()`/`x.isInf()` 实例方法路径——按 `cangjie-std/math/README.md` 第 5 节「x.isNaN() 是否为 NaN（实例方法）」「x.isInf() 是否为无穷（实例方法）」，`std.math` 标准库确实仅提供实例方法而非顶层函数；设计采用 `q.x.isNaN()` 实例方法路径正确。

**[通过]** `@Derive[Hashable]`、`@OverflowWrapping` 注解均为标准库机制——前者来自 `std.deriving.*`，后者来自 `std.overflow` 注解体系；两者均已在阶段一 Vec3、阶段二 Mat 中实践使用。

**[通过]** `match (hint) { case _: Float32 => ... case _: Float64 => ... case _ => throw ... }` 类型模式匹配——属于标准 Cangjie 模式匹配（结合 generic 函数 hint 参数辅助类型推断），与 deviations.md DV-04 `isIec559Of` 实现模式一致。

**[通过]** `ext/vector_relational.cj` 内联 `abs` 策略——使用 `if (d >= T(0)) { d } else { -d }` 模式替代依赖 `common.cj` stub，在 `Number<T> & Comparable<T>` 约束下可行（`Comparable<T>` 来自 std.core 接口），消除对 stub 文件的运行时依赖风险。

**[通过]** `clamp`、`abs` 等常用数学函数可从 `std.math` 标准库直接获取（`cangjie-std/math/README.md` 第 1 节），无需自定义。

**[通过]** 设计对阶段二 ext/ 子包与本阶段新增 gtc/ 子包均沿用阶段二验证通过的策略；唯一新增不确定性（`src/gtc/` + `package glm.gtc` 子包发现机制）已列入 §2 末尾 cjpm 子包构建预验证 + §8 验证项 1，附回退方案（迁移至 `src/` 根目录降级为 `package glm`）。

### 3. 语言特性可行性

**[通过]** `const init(x: T, y: T, z: T, w: T)` 主构造函数——按 `const/README.md` 第 4.2 节「const init 内可以使用赋值表达式 = 对实例成员变量赋值」，struct 的 `const init` 允许对 var 成员通过 `=` 赋值；Quat 的 4 个 var 字段 `var x, var y, var z, var w` 在 const init 内可通过简单赋值完成构造，编译期可求值。

**[通过]** `lerp` 函数非 const 决策——`const/README.md` 第 2 节 const 表达式列表中无 `assert`，按第 3.2 节规则 3「const 函数中的表达式都必须是 const 表达式」，含 `assert(a >= 0 && a <= 1)` 的 `lerp` 不可声明为 `const func`。设计与 deviations.md IF-03（`componentAt` 不可在 const 上下文使用，理由为 assert 不是 const）一致。

**[通过]** 一元 `+` 运算符不可用——按 `function/README.md` 第 8.2 节，可重载运算符列表中不含一元 `+`，设计明确说明「仓颉不支持重载一元 + 运算符（与 deviations.md IF-01 一致），`+q` 不可编译，直接使用 `q` 即可」，处理正确。

**[通过]** `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 重导出——按 `package/README.md` 第 4.6 节「`public import`、`protected import`、`internal import` 重新导出导入的成员」，`public import` 将导入成员重新导出至当前包；`gtc/quaternion.cj` 通过此机制将 detail 中的转换函数重导出为 gtc 命名空间下的同名 API，符合仓颉包导入/重导出规则。

**[通过]** 子包目录结构与包声明匹配——`src/ext/`、`src/gtc/`、`src/detail/` 三个子目录分别声明 `package glm.ext`、`package glm.gtc`、`package glm.detail`，按 `package/README.md` 第 2.1 节「包声明须与相对于 src/ 的目录路径匹配」，目录名与包名匹配规则满足。

**[通过]** **包间依赖方向严格单向 `glm.gtc → glm.detail`（v3 关键修复）**——按 `package/README.md` 第 4.2 节规则「不允许循环依赖」+ `cjpm check` 命令（第 2.7 节）会报告循环路径并终止构建。v3 设计将 `mat3Cast`/`mat4Cast`/`quatCast` 下沉至 `glm.detail.type_quat_cast.cj`，让 `type_quat.cj` 中 `fromMat3`/`fromMat4` 工厂函数直接调用同包函数（无需跨包 import），`gtc/quaternion.cj` 通过 `public import` 重导出。修复后形成单向依赖 DAG：`glm.gtc → glm.detail`、`glm.ext → glm.detail`、`glm` 顶层聚合，彻底解决 v1 审查识别的严重包间循环依赖问题。

**[通过]** `@OverflowWrapping` 注解应用于运算符函数——按 `reflect_and_annotation/README.md` 第 1.1 节「三种内置注解控制函数的溢出策略（只能标记于函数声明上，作用于函数内的整数运算和整型转换）」，`@OverflowWrapping` 可标记于函数声明；运算符函数属于函数声明，标注合法。对浮点类型无效果（仅作用于整数溢出行为），但保持跨整数/浮点实例化的统一行为——设计与阶段一 Vec3（`type_vec3.cj:54-80`）、阶段二全部矩阵类型（`type_mat*.cj` 200+ 处标注）实践一致。

**[通过]** 复合赋值运算符自动生成——按 `function/README.md` 第 8.5 节「重载二元运算符（关系运算除外）时自动启用对应复合赋值版本（+=、-= 等），前提是返回类型与左操作数类型匹配或为其子类型」，`+=`/`-=`/`*=`/`/=` 由编译器自动生成；设计正确依赖此机制，无需在 Quat 中显式声明。

**[通过]** `throw Exception("stub")` stub 占位模式——与阶段二 `geometric.cj`、`common.cj` 等现有 stub 文件（实测均为 `throw Exception("stub")`）实践一致。

### 4. 设计一致性

**[通过]** **v3 设计正确消解 v1 审查识别的严重包间循环依赖问题**——`type_quat.cj` (package `glm.detail`) 中 `fromMat3`/`fromMat4` 工厂函数改为调用同包 `type_quat_cast.cj` 的 `mat3Cast`/`mat4Cast`/`quatCast` 函数（无需跨包 import）；`gtc/quaternion.cj` (package `glm.gtc`) 通过 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 将 detail 函数重导出为 gtc 命名空间下的同名 API。修复后形成 `glm.gtc → glm.detail` 单向依赖，无循环依赖。

**[通过]** 依赖方向表述一致——§1「gtc/quaternion.cj 设计决策（v3 决策，采纳审查报告 Solution 1）」段、§2 模块间依赖图、§3.2 协作关系表、§3.15「与 type_quat.cj、type_quat_cast.cj 三方协作」段四处均统一描述为「形成 `glm.gtc → glm.detail` 的**单向依赖**，**无循环依赖**（v3 关键修复）」，与修复后的实际依赖结构一致（v1 审查识别的「依赖方向内部矛盾」一般问题已修复）。

**[通过]** 协作关系表（§3.2）覆盖完整——包含 Quat×Vec3/Vec4 旋转、Vec3/Vec4×Quat 逆旋转、Mat↔Quat 双向转换（4 重导出）、`fromMat3`/`fromMat4` 工厂函数路径、`Mat↔Quat` 转换重导出行，闭环完整无缺失环节。

**[通过]** 函数归属一致性——`mat3Cast`/`mat4Cast`/`quatCast` 在 §1 核心抽象表、§2 包组织、§3.2 协作关系表、§3.15 gtc/quaternion.cj 小节、§7 D11 设计决策、§8 产出物清单、§10 覆盖矩阵中均一致标注为「detail/type_quat_cast.cj 承载实现 + gtc/quaternion.cj 重导出」（v1 审查识别的「mat3_cast 等函数归属矛盾」严重问题已修复）。

**[通过]** 边界条件契约（§5.3）覆盖 8 类边界场景——`axis` 零四元数、`inverse` 浮点/整数零除差异、`mix`/`slerp` cosTheta 退化、`fromMat3`/`fromMat4` 非纯旋转矩阵、`lerp` 断言失败、`equal` epsilon=0、整型 `epsilon<T>()` 抛异常、`lerp` 非 const 约束——覆盖全面且与 GLM 行为对齐声明清晰。

**[通过]** GLM 1.0.3 API 阶段覆盖矩阵（§10）逐一列举各 GLM 头文件下的函数与本阶段覆盖状态（完整实现/stub/重导出），可作为实现完成度的核查清单；gtc/quaternion.hpp 表中正确标注 `eulerAngles`/`roll`/`pitch`/`yaw` 为 stub（v1 审查识别的「分类逻辑矛盾」一般问题已修复）。

### 5. 设计质量

**[通过]** 单一职责原则——`type_quat.cj` 仅承载 Quat 类型定义与核心运算符；`quaternion_common.cj`/`quaternion_geometric.cj`/`quaternion_trigonometric.cj`/`quaternion_exponential.cj`/`quaternion_transform.cj`/`quaternion_relational.cj` 按功能类别清晰拆分；`gtc/quaternion.cj` 承载 GLM gtc 层特有的转换/比较/欧拉/看向函数；三层结构职责分明。

**[通过]** 抽象层次恰当——detail（核心类型）/ext（功能扩展）/gtc（GLM 风格 gtc 命名空间）三层包结构层次分明，避免过度设计的同时也未设计不足。

**[通过]** 测试规划（§8.2）覆盖完整——13 个测试文件对应 13 个实现文件，≥171 测试用例，按模块拆分；测试覆盖维度包括构造路径、运算符正常路径、ext 函数库正常路径、gtc/quaternion.cj 正常路径（含 v3 新增 type_quat_cast 单元测试）、stub 函数异常路径、跨 Qualifier 实例化、跨类型实例化；浮点比较策略明确（epsilon 版本 + 精确比较 + 角度比较 + v3 新增「旋转矩阵 * 向量 = 四元数 * 向量」等价性测试）；阶段三可验证 vs 待阶段四拆分清晰。

**[通过]** 便于下游消费——§11 新增「下游消费者迁移指南」独立章节，覆盖 5 类常见迁移场景（构造单位四元数、跨类型转换、旋转应用、矩阵-四元数互转、函数可用性对照表），提供 GLM 与仓颉版本对照示例；§11.5 函数可用性对照表清晰列出 19 个函数的本阶段/阶段四状态。

**[通过]** 模块间依赖图（§2）合理——除 v3 已修复的循环依赖外，其他跨包依赖方向合理，无隐藏循环（`ext` 子包对 `detail` 的依赖、`gtc` 子包对 `detail`/`ext` 的依赖方向均符合「上层依赖下层」的层级关系）。

**[轻微]** **Quat 结构体字段可见性未明确为 `public`**——设计 §3.1 描述 Quat 数据成员为 `var x: T, var y: T, var z: T, var w: T`，未显式标注 `public`。按 `cangjie-std/deriving/README.md` 第 4 节「参与派生的字段/属性必须为 public」，`@Derive[Hashable]` 派生要求字段为 public；按 `struct/README.md` 第 1.7 节，struct 字段默认可见性为 internal（仅当前包及子包），外部包或 `public` 成员派生均需显式 `public var`。实测阶段一 Vec3 (`type_vec3.cj:8-10`)、阶段二全部 Mat (`type_mat*.cj:8+`) 均使用 `public var` 标注（200+ 处统一实践），Quat 字段可见性需与阶段一/二实践对齐以保证 `@Derive[Hashable]` 派生成功。设计 §8 验证项 11 已在编码启动前覆盖此验证，但设计描述层未明确约束。

---

## 修改要求（REJECTED 时存在）

### 问题 1（一般）：`isnan`/`isinf` 函数缺少 `where T <: FloatingPointNumber<T>` 约束

**问题**：`ext/quaternion_common.cj` 中 `isnan(q: Quat<T,Q>): Vec4<Bool,Q>` 与 `isinf(q: Quat<T,Q>): Vec4<Bool,Q>` 函数设计 §3.11 列为「完整实现」，但函数体内部使用 `q.x.isNaN()`/`q.x.isInf()` 实例方法路径（`Vec4(q.x.isNaN(), q.y.isNaN(), q.z.isNaN(), q.w.isNaN())`）。`std.math` 标准库的 `isNaN()`/`isInf()` 实例方法仅定义于浮点类型（`FloatingPoint<T>` 接口），整数类型（Int8/16/32/64）无此方法。当用户实例化 `Quat<Int64, PackedHighp>`（或任何整数 T）并调用 `isnan(q)` 时，函数体内部 `q.x.isNaN()` 因 Int64 不实现 `isNaN()` 而编译失败。

**原因**：函数签名未对 T 添加浮点类型约束，与 `Quat<T, Q>` 的 `T <: Number<T>` 约束（包含整数与浮点）不匹配，导致非浮点实例化场景下设计契约不闭环。同时与同节 `epsilon<T>()`/`pi<T>()`/`cos_one_over_two<T>()` 设计 §3.12 中明确约束收紧为 `T <: FloatingPointNumber<T>` + 运行时 fallback 异常分支的处理方式不一致，存在设计一致性缺陷。

**建议方向**：在 `isnan`/`isinf` 函数签名上添加 `where T <: FloatingPointNumber<T>` 约束（或等价约束如 `where T <: Float32 | Float64`），限制函数仅对浮点类型 T 可调用。仓颉泛型约束使用具体接口或类型，多个接口用 `&` 连接（如 `where T <: Number<T> & FloatingPointNumber<T>`）；若仓颉泛型不支持窄类型约束（如 `FloatingPointNumber<T>` 不可用），可在函数体内采用与 `epsilon<T>()` 相同的 `match (hint)` 运行时分派 + `case _ => throw Exception(...)` 显式错误分支模式。修复后需在设计 §5.3 边界条件表新增对应行（类似整型 `epsilon<T>()` 的处理）；§9 差异声明同步说明；§11.5 函数可用性对照表将 `isnan`/`isinf` 标注为「仅浮点 T 可用」。

### 问题 2（轻微）：Quat 结构体字段可见性未明确为 `public`

**问题**：设计 §3.1 描述 Quat 数据成员为 `var x: T, var y: T, var z: T, var w: T`，未显式标注 `public`。按 `cangjie-std/deriving/README.md` 第 4 节约束「参与派生的字段/属性必须为 public」，`@Derive[Hashable]` 派生要求字段为 public；按 `struct/README.md` 第 1.7 节，struct 字段默认可见性为 internal，不满足 public 派生要求。阶段一 Vec3 (`type_vec3.cj:8-10`)、阶段二全部 Mat (`type_mat*.cj:8+`) 均使用 `public var` 标注以保证 `@Derive[Hashable]` 派生成功（实测 200+ 处统一实践），Quat 设计描述应与该实践对齐。

**原因**：设计描述层未明确字段可见性约束，可能导致实现阶段沿用设计描述时遗漏 `public` 关键字，进而 `@Derive[Hashable]` 派生失败。虽然 §8 验证项 11 已在编码启动前覆盖此验证，但设计描述层应明确约束以避免实现偏差。

**建议方向**：在设计 §3.1 数据成员描述中将 `var x: T, var y: T, var z: T, var w: T` 修订为 `public var x: T, public var y: T, public var z: T, public var w: T`，与阶段一/二全部泛型类型（Vec、Mat）的字段可见性实践对齐。同时可在 §3.1 末尾或 §5 错误处理策略中新增一行说明「`@Derive[Hashable]` 派生要求所有参与字段为 public，Quat 数据成员统一标注 `public var`」。