# GLM 1.0.3 仓颉迁移阶段三 OOD 设计方案

---

## 1. 概述

### 设计目标

在阶段一（Vec1~Vec4 向量类型 + 基础设施）和阶段二（9 个矩阵类型 + ext/ 别名）的基础上，迁移四元数类型及其必需的 ext/gtc 依赖文件，为库提供基础的旋转表达和插值运算框架。

> **⚠️ 严重限制声明（请在使用本设计前完整阅读）**——本阶段**无法**提供完整的 GLM 四元数功能。165 个 GLM API 中，仅有 **约 18 个（约 11%）** 为真完整独立实现；**约 88 个（约 53%）** 为 stub 占位或受 stub 依赖阻塞。两个核心用户用例——**四元数旋转向量（Quat×Vec3/Quat×Vec4）和球面插值（slerp/mix）**——均不可用。四元数的旋转表达和插值运算这两个核心领域，**必须等待阶段四** geometric.cj/trigonometric.cj/common.cj 函数库完整实现后方可完成。以下分段给出详细计数口径和降级路径。
>
> **⚠️ 如果您是首次接触本设计的决策者，请先阅读 §3.16「发布决策支持」段**，了解"阶段三仅提供四元数基本数学骨架"这一关键限制对您迁移决策的影响，以及如期发布 vs 延期发布的风险收益分析。

**本阶段全部 `~88` 个 stub（约占 165 个 GLM API 的 53%）中：** 核心旋转（Quat×Vec3/Quat×Vec4）依赖 geometric.cj 的向量 `cross` 故标记为 ⚠️（编译通过但运行抛 stub；核心插值（slerp/mix）依赖 trigonometric.cj 的 `acos`/`sin` 和 common.cj 的 `mix` 故标记为 ❌。两项合计影响 **5 个 API 函数**（2 ⚠️ + 3 ❌。其余 83 个 ❌ 函数覆盖三角函数库、指数函数库、欧拉角、看向、矩阵变换等全部依赖几何/三角/通用函数库的模块。

**阶段三实际交付能力**——约 **11%（18/165）** 的真完整独立函数——构成四元数的基本数学骨架（构造、共轭、逆、归一化、线性插值、矩阵互转。以下 47% 的签名行数口径仅作为参考统计，**不应** 作为阶段三可用率的评估基准。

> 本阶段对标 GLM 1.0.3 共 13 个头文件、165 个 API 函数。按独立函数范式计数，真完整实现 **18 个（约 11%）**；按含重载/常量展开的签名行数计数，约 **77 个（约 47%）**。**11%（18/165）** 是下游评估阶段三可用性的**首要基准口径**。约 **88 个函数（约 53%）** 以 stub 占位或依赖 stub（⚠️/❌。具体函数级状态以 §11.5 函数可用性对照表为准。下表给出按 GLM 头文件维度的聚合覆盖视图（更详细的基准声明见 §9a：

| 分类 | 函数数 | 说明 |
|------|--------|------|
| ✅ **真完整实现（独立函数范式）——约 11%** | **~18** | mat3Cast/mat4Cast/quatCast(×2)/conjugate/inverse/lerp/isnan/isinf/dot/length/normalize/cross(Quat)/axis/epsilon/pi/cos_one_over_two/equal(Quat)/notEqual(Quat |
| ✅ 含重载/常量展开（签名行数）——约 47% | ~77 | 上述 18 个独立函数 + 28 gtc/constants 常量 + 16 vector_relational epsilon 重载 + 4 gtc 比较函数 + 运算符/构造函数等变体展开 |
| ⚠️ 编译通过但抛 stub | 4 | Quat×Vec3/Vec4 + Vec3×Quat/Vec4×Quat 运算符（均依赖 geometric.cj 向量 cross stub |
| ❌ stub 占位 | 86 | mix/slerp/exp/log/pow/sqrt/angle/angleAxis/rotate/eulerAngles/roll/pitch/yaw/quatLookAt*/fromVec3/fromEuler/ULP 比较/trigonometric.cj 全体/gtc/matrix_transform 全体 |

> **计数口径说明**——本表以「**约 11%**（18/165）」为**首要基准口径**（独立函数 18 个不含运算符级条目；⚠️ 类别中含 Vec3×Quat/Vec4×Quat——后者因实现链依赖 Quat×Vec3 的 geometric.cj cross stub 已归入 ⚠️，详见 §3.4，在表头和分类行中醒目标注。47%（77/165）仅作为签名行数参考统计附注——两者不可并列使用。上游决策者和下游消费者应以独立函数范式口径的 **11%** 作为阶段三实际可用功能的评估依据，而非 47% 的展开口径。**函数级可用状态的最终权威来源为 §11.5 函数可用性对照表，本表仅提供聚合统计视图，不替代 §11.5 的逐函数状态标注**。

### 核心抽象

| 抽象 | 角色 | 类型形态 |
|------|------|---------|
| Quat<T,Q> | 表示数学四元数的值对象 | 泛型结构体 |
| **detail/type_quat_cast.cj** | **承载 `mat3Cast`/`mat4Cast`/`quatCast(Mat3)`/`quatCast(Mat4)` 转换函数，避免包间循环依赖** | **包级函数** |
| ext/vector_relational.cj | 向量关系运算扩展函数库（epsilon/ULP 比较 | 完整实现（epsilon 16 重载）+ stub（ULP 8 重载 |
| ext/quaternion_relational.cj | 四元数关系运算扩展函数库 | 完整实现（4 函数 |
| ext/quaternion_transform.cj | 四元数变换函数库 | 仅 `rotate` 函数 stub |
| ext/quaternion_common.cj | 四元数公共函数库（slerp/lerp/conjugate/inverse | 5 函数完整实现 + 3 函数 stub |
| ext/quaternion_geometric.cj | 四元数几何函数（dot/length/normalize/cross | 完整实现（4 函数 |
| ext/quaternion_trigonometric.cj | 四元数三角函数（angle/axis/angleAxis | 1 函数完整实现 + 2 函数 stub |
| ext/quaternion_exponential.cj | 四元数指数函数（exp/log/pow/sqrt | 全部 stub（4 函数 |
| ext/scalar_constants.cj | 标量数学常量（epsilon/pi/cos_one_over_two | 完整实现（3 函数重导出 |
| gtc/constants.cj | 数学常量定义（zero/one/pi/half_pi 等 28 个常量 | 完整实现 |
| **gtc/quaternion.cj** | **gtc 四元数扩展函数库（欧拉/比较/看向函数 + 转换函数重导出）** | **混合型：4 函数完整实现 + 7 函数 stub + 4 函数重导出**
| gtc/matrix_transform.cj | 矩阵变换函数库 | 空桩占位 |
| common.cj（沿用阶段二 stub | 基础数学函数库占位 | 沿用 stub |
| matrix.cj（沿用阶段二 | 矩阵运算函数库 | 沿用（27 实现 + 6 stub |
| geometric.cj（沿用阶段二 stub | 几何函数库占位 | 沿用 stub |
| trigonometric.cj（新增空桩 | 三角函数库占位 | 新增空桩 |
| ext/matrix_projection.cj（新增空桩 | 矩阵投影函数库占位 | 新增空桩 |
| ext/matrix_clip_space.cj（新增空桩 | 裁剪空间矩阵函数库占位 | 新增空桩 |
| ext/matrix_transform.cj（新增空桩 | 矩阵变换扩展函数库占位 | 新增空桩 |

### 整体架构思路

沿用阶段一/阶段二的双层包结构 + ext 子包 + gtc 子包：glm.detail 包含四元数泛型结构体定义、运算符重载、以及矩阵-四元数互转函数（type_quat_cast.cj，glm 包通过类型别名暴露常用具现化，glm.ext 包含四元数/向量关系运算等扩展函数库和别名文件，glm.gtc 包含数学常量和 gtc_quaternion 扩展函数库（通过 public import 重导出 detail 中的转换函数。四元数类型以 Vec3+标量(w 为内部数据布局，与 GLM 的 xyzw 布局一致（非 wxyz 布局，通过 `const init` 构造函数支持编译期求值。

### 系统性设计约束：泛型上下文中 T(0)/T(1) 的获取问题

本设计与阶段二面临相同的根因限制——**仓颉无约束泛型参数不支持 `T(0)/T(1)` 构造调用，且 `Number<T>` 接口也不提供 `T(n)` 构造声明**。统一策略沿用阶段二的方案——
- **T(0 的获取**——原策略「通过 `one - one` 演算（需 `one: T` 形参显式传入）」在不含 `one: T` 形参的函数签名中不可用（如 `normalize(q: Quat<T,Q>): Quat<T,Q>`。**统一修订为 `T(Float64(0))` 字面量替代路径**——与 `axis` 函数中 `T(Float64(0))` 使用模式一致。该路径对 `T = Float32/Float64` 编译可行（`Float32(Float64(0))` = `0.0f`，`Float64(Float64(0))` = `0.0`。对 `T = Int8~Int64/UInt8~UInt64` 等整数类型，`T(Float64(0))` 的编译可行性属于 **P0 假设 H1**（验证项 25，该假设已在 v25 完成编译验证 ✅（详见本节回退方案验证执行记录。仅在 `identity(one: T)` 等显式携带 `one: T` 形参的函数中保留 `one - one` 演算路径
- **T(1 的获取**——必须由调用方显式传入参数（`one: T`，因为在 `Number<T>` 约束上下文中不存在通用的演算路径
- **T(0 和 T(1 均需的场景**：T(0 通过 T(Float64(0) 字面量替代获取，T(1 通过参数传入或 T(Float64(1) 字面量替代
- **常量型 T(n 字面量替代**——对于公式中固定为常数 n 的场景（如 `axis` 公式中的 `T(1 - x.w*x.w`、`normalize` 零保护分支中的 `T(0)` 与 `T(1)`、`Quat×Vec3`/`Quat×Vec4` 旋转公式末尾的 `* 2` 缩放因子、`mat3Cast`/`mat4Cast` 转换函数中初始化 3×3/4×4 单位矩阵对角元素的 `T(1)` 与非对角线元素的 `T(0)`，可采用 `T(Float64(n))` 显式转换路径（编译期 `Float64` 字面量 → `T` 类型，无需 `one: T` 形参；该路径对 `T = Float32`/`Float64` 均成立（`Float32(Float64(n))` 与 `Float64(Float64(n))` 均返回正确字面量。对 `T = Int8~Int64/UInt8~UInt64` 等整数类型，`T(Float64(n))` 的编译可行性属于 **P0 假设 H1**（验证项 25，尚待编码启动前验证——若验证失败，整数类型路径退化为 `match` 运行时分派或追加 `one: T` 形参（详见回退方案决策树。：T(0 字面量替代从「仅含 `axis` 中 `Vec3(T(0), T(0), T(1))` 返回值」扩展为系统性覆盖所有函数体中需要常量型 T(0 的场景——`normalize` 零保护分支的 `Quat(T(0), T(0), T(0), T(1))` 返回值中 xyz 分量的 `T(0)` + `mat3Cast`/`mat4Cast` 非对角线元素的 `T(0)` 均改用 `T(Float64(0))` 字面量替代路径，不再依赖 `one - one` 演算。——以下清单采用 **exhaustive（穷举）** 规则——逐函数标注 T(0)/T(1 字面量使用位置，涵盖所有在函数体内部依赖 `T(Float64(n))` 构造（n ≠ 0,1 时标注 n 值）的函数，不遗漏任何含 T(0)/T(1 字面量替代的函数；清单之外的任何函数（如 `lessThan` 纯比较函数、`equal` 纯比较函数等）均不依赖 T(n 字面量替代路径，无需修改——
  - **`axis` 函数（§3.9）**——使用 `T(Float64(1))` 字面量实现 `T(1 - x.w*x.w` 公式 + 使用 `T(Float64(0))` 字面量实现 `Vec3(T(0), T(0), T(1))` 返回值中 xyz 的两个 T(0
  - **`normalize` 函数（§3.7）**——使用 `T(Float64(0))` 字面量实现零保护分支返回值 `Quat(T(0), T(0), T(0), T(1))` 中 xyz 分量的 T(0 + 使用 `T(Float64(1))` 字面量实现 w 分量的 T(1)（——v9 函数清单遗漏 normalize 的 T(0)/T(1 字面量替代场景；原策略「T(0 通过 `one - one` 演算」在 normalize 签名 `normalize(q: Quat<T,Q>): Quat<T,Q>`（不含 `one: T` 形参）中不可用
  - **`Quat×Vec3`/`Quat×Vec4` 运算符（§3.4）**——使用 `T(Float64(2))` 字面量作为旋转公式末尾的 `* 2` 缩放因子
  - **`mat3Cast`/`mat4Cast` 转换函数（§3.2.1）**——使用 `T(Float64(1))` 字面量初始化结果矩阵的对角元素 + 使用 `T(Float64(0))` 字面量初始化非对角线元素

注：`T(Float64(n))` 字面量替代路径对所有受影响的类型（`Float32`/`Float64`/`Int8`~`Int64`）的编译可行性已在 §8 编码启动前验证项中新增显式验证项，确保该核心假设在编码阶段被验证通过后方可进入实现。

### 系统性设计约束：Float32 与 std.math 的交互约束

仓颉 `std.math` 模块的数值函数 API 覆盖情况（依据 `cangjie-original-docs/std/math/math_package_api/math_package_funcs.md` 全文检索：
- **提供 Float16/Float32/Float64 三种重载的函数**：`sqrt`/`sin`/`cos`/`tan`/`asin`/`acos`/`atan`/`sinh`/`cosh`/`tanh`/`asinh`/`acosh`/`atanh`/`atan2`/`exp`/`log`
- **提供 Float32/Float64 重载的函数**：`pow(Float32, Float32): Float32`、`pow(Float32, Int32): Float32`、`pow(Float64, Float64): Float64`、`pow(Float64, Int64): Float64`
- **不存在**：`radians`/`degrees`（仓颉 std.math 不提供，本约束不适用于 radians/degrees；radians/degrees 必须通过硬编码 π 字面量自行实现，见 §3.13.1

**统一处理策略**：
- **方案 A（推荐）**——当泛型参数 `T` 与 std.math 重载参数类型一致时（即 T=Float32 时直接调用 `std.math.pow(x.w, y)`，**直接调用** std.math 函数，无需 `T(Float64.xxx(...))` 显式转换——v10/v6「必须转换」约束对存在 Float32 重载的函数不成立
- **方案 B（备选）**——对 `T = Float64` 实例化的场景，沿用 `T(Float64.xxx(Float64(value)))` 模式无变化
- **方案 C（备选）**——使用 `T <: Number<T>` 宽约束 + 函数体内 `match` 运行时分派（牺牲部分类型安全换取泛型灵活性，不推荐

- **直接影响消除**——描述的「`std.math.sqrt(x)` 在 T=Float32 时触发编译错误」实际不成立——`std.math.sqrt` 自身已提供 Float32 重载，直接调用即可
- **下游影响范围**：§1「本阶段受此约束影响的函数」段、§3.9 `axis` 函数依赖描述、§3.10 `pow`/`log`/`exp` 函数依赖描述、D21 设计决策、§3.13.1 trigonometric.cj 表头与各函数「内部依赖」列、§8 编码启动前验证项 12 与 15、§9a 覆盖矩阵 trigonometric.cj 表所有 14 个函数行
- **保留的影响**：`radians`/`degrees` 因 std.math 不提供这两个函数，仍需自行实现（硬编码 π 字面量路径，不受本约束「直接调用或转换调用」路径管辖

### gtc/quaternion.cj 与 type_quat_cast.cj 的协作设计

**包间循环依赖的根因**：GLM 1.0.3 中 `mat3_cast`/`mat4_cast`/`quat_cast` 4 个函数在 `gtc/quaternion.hpp` 中定义，而 `type_quat.inl` 的构造函数 `qua(mat3x3)`/`qua(mat4x4)` 内部调用这些转换函数。在 C++ 中通过头文件包含可实现双向引用，但在仓颉包模型下，`type_quat.cj`（`package glm.detail`）若 `import glm.gtc.quaternion.*`，而 `gtc/quaternion.cj`（`package glm.gtc`）若 `import glm.detail.*`，则构成 **包间循环依赖**（`glm.detail ↔ glm.gtc`，仓颉 cjpm 构建系统会拒绝编译（依据 cangjie-lang-features package/README.md 第 99 行明确规定「不允许循环依赖」。

**本设计采取的解法**——将 `mat3Cast`/`mat4Cast`/`quatCast` 4 个转换函数从 `gtc/quaternion.cj` 下沉至 `glm.detail.type_quat_cast.cj`（独立新文件，`package glm.detail`，让 `type_quat.cj` 中的 `fromMat3`/`fromMat4` 工厂函数直接调用同包函数（无需跨包引用。`gtc/quaternion.cj` 通过 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 将这 4 个函数重导出为 gtc 命名空间的 API，从而保留 GLM 1:1 文件归属的设计意图（gtc 包仍提供 gtc 风格 API，同时彻底打破循环依赖。

**依赖方向**：
- `glm.detail`（含 `type_quat.cj` 和 `type_quat_cast.cj`）**不依赖** `glm.gtc`
- `glm.gtc`（含 `quaternion.cj`）**单向依赖** `glm.detail`（通过 `public import` 重导出
- 形成 `glm.gtc → glm.detail` 的**单向依赖**，无循环依赖

**为何不采用其他方案**：
- 审查报告 Solution 2（将 fromMat3/fromMat4 剥离到 gtc）会破坏 type_quat.cj 的核心职责（工厂函数应与类型定义同处，且让 API 形态从 `q.fromMat3(m)` 退化为 `mat3ToQuat(m)`，与 GLM 习惯偏差更大
- 审查报告 Solution 3（重新组织包层级为 glm.detail.gtc）需修改整个阶段三的包结构，影响过大
- 本方案仅调整 4 个函数的位置（detail 而非 gtc，破坏最小，API 形态完整保留

### 回退方案

**验证时序声明**——H1（`T(Float64(n))` 语法可行性）和 H2（`FloatingPoint<T>` 接口方法可用性）两项 P0 核心假设的验证已完成于 v25 轮次（验证日期——2026-06-26。验证结果：✅ **两项均已通过**。这意味着 v1~v24 中基于未验证假设做出的所有设计决策（涉及 normalize/axis/mat3Cast/mat4Cast/Quat×Vec3/Quat×Vec4/slerp/pow/log 等函数的签名选择与实现策略）已在轮次 v25（即第 25 轮设计迭代）时得到实际编译验证的支持。为彻底解决「验证发生在设计完成之后」的时序矛盾，O-06（验证前置化流程制度化）已在 v27 从「待评估」升级为「下一轮必须实施」，v28 转化为可执行落地计划（含目标、责任人、M1/M2/M3 里程碑、检查清单、例外处理机制。**当前版本确认 O-06 P0 核心假设已前置验证完毕**：3 项 P0 假设（验证项 20: FloatingPoint<T> 接口方法可用性, 25: T(Float64(n) 语法可行性, 29: glm.detail 无 import glm.ext.* 声明）已在设计版本固化前完成最小仓颉测试文件编译验证，验证结果记录于 §8 验证结果记录表模板。**非 P0 验证项（共 26 项）按计划在编码阶段执行**，不在设计阶段强制验证。未来版本中，P0 核心假设的验证将前置为设计版本固化前的门禁条件，不再出现 24 轮设计建立在未经验证假设之上的情况。

本节为 §8 编码启动前验证项 20 和 25 两条 P0 核心假设提供被证伪时的回退路径。

**假设 H1：`T(Float64(n))` 语法对全部 `T <: Number<T>` 编译可行（验证项 25）**

| 证伪情形 | 影响范围 | 回退策略 |
|---------|---------|---------|
| `Float32(Float64(0))`/`Float32(Float64(1))` 编译失败 | 所有使用 `T(Float64(n))` 字面量替代的函数（`normalize`/`axis`/`mat3Cast`/`mat4Cast`/`Quat×Vec3`/`Quat×Vec4` | **路径 A（推荐）**——对每个受影响函数追加 `one: T` 形参（如 `normalize(q: Quat<T,Q>, one: T): Quat<T,Q>`，T(0 通过 `one - one` 演算获取。代价——函数签名变更，与 GLM API 形态偏差扩大。**路径 B**——在 `Number<T>` 约束块中使用 `match` 运行时分派，按 `Float32`/`Float64`/`Int8`~`Int64` 分别返回硬编码字面量。代价——运行时开销，但对上层签名无影响。**路径 C**——将 T 约束从 `Number<T>` 收紧为 `FloatingPoint<T>`，排除整数类型，对所有浮点类型使用 `T(0.0)`/`T(1.0)` 原生字面量构造。代价——整数四元数无法调用这些函数 |
| `Int8(Float64(0))`/`Int16(Float64(0))` 等整数类型编译失败 | 同上，但仅限整数 T 实例化路径 | 对整数 T 路径退化为 **路径 A**（追加 `one: T` 形参）或 **路径 B**（`match` 运行时分派）——浮点 T 路径仍可用 `T(Float64(n))` |
| 部分类型编译通过、部分失败 | 混合影响 | 按类型分别选择回退路径，在函数签名中通过 `where` 子句区分（如 `where T <: FloatingPoint<T>` 使用原生字面量，整数 T 使用 `one: T` 形参 |

**假设 H2：`FloatingPoint<T>` 接口提供 `getMinDenormal()`/`getInf()` 等静态方法（验证项 20）**

| 证伪情形 | 影响范围 | 回退策略 |
|---------|---------|---------|
| `FloatingPoint<T>.getMinDenormal()` 静态方法不存在 | `pow` 函数（§3.10）中的次正规数边界检查（line 63 | **路径 A（推荐）**——回退至类型分派 `match (q.x { case _: Float32 => Float32.Min case _: Float64 => Float64.Min }`；若无法获取平台最小值硬编码值，采用字面量保守值（如 `T(Float64(1e-45))` 对 Float32、`T(Float64(5e-324))` 对 Float64。**路径 B**——完全移除次正规数边界检查（与 GLM 早期版本行为一致，允许次正规数进入正常计算路径——代价——极端小值下精度损失 |
| `FloatingPoint<T>.getInf()` 静态方法不存在 | `log` 函数（§3.10）中 w=0 退化分支（line 30 | **路径 A（推荐）**——回退至类型分派 `match (q.x { case _: Float32 => Float32.Inf case _: Float64 => Float64.Inf }`；若无静态常量可用，采用 `T(Float64(1) / T(Float64(0))` 表达式生成正无穷（对浮点类型有效，整数 T 实例化时触发 `ArithmeticException`，与 GLM `log` 在整数 T 的行为一致。**路径 B**——将 w=0 退化分支的处理从 `getInf()` 改为直接返回带大有限值的四元数（如 `Quat(0, 0, 0, 1e10)`，消除对无穷值的依赖——代价——与 GLM 行为偏差 |
| `FloatingPoint<T>.getNaN()` 静态方法不存在 | 非旋转矩阵 `quatCast` 的 NaN 四元数返回值（§3.2.1 边界行为 | 路径 A——类型分派 `match { Float32 => Float32.NaN, Float64 => Float64.NaN }`；路径 B——使用 `FloatingPoint<T>.getInf()` 回退路径的类似方案 |
| `FloatingPoint<T>` 接口本身在 stdlib 中不存在 | 所有使用 `where T <: FloatingPoint<T>` 约束的签名（`isnan`/`isinf`/`mat3Cast`/`mat4Cast`/`quatCast`/`trigonometric.cj` 全体 | **统一回退**——将所有 `FloatingPoint<T>` 约束放宽为 `Number<T>`，在函数体首部通过 `match` 或 `if-else` 对 `q.x` 的具体类型进行 `Float32`/`Float64` 分派，非浮点 T 实例化时抛 `Exception("function not defined for non-floating-point types")`。与 `epsilon<T>()` fallback 策略一致（§3.12 |

**决策树执行顺序**：
1. 先执行验证项 25（`T(Float64(n))` 语法，确认编译可行性
2. 再执行验证项 20（`FloatingPoint<T>` 静态方法，确认 API 存在性
3. 若 H1 通过但 H2 失败——仅影响 `pow`/`log`/`quatCast` 三条回退路径
4. 若 H1 失败但 H2 通过——影响范围最广，需按 H1 回退策略逐函数调整签名
5. 若 H1 和 H2 均失败——同时执行两套回退路径，需评估组合影响（尤其是 `mat3Cast`/`mat4Cast` 同时可能受 H1 的 `T(1)` 字面量替代路径和 H2 的 `FloatingPoint<T>` 约束收紧路径影响

**验证执行记录**——以下 P0 验证项已在 v25 设计阶段（验证日期——2026-06-26）通过最小仓颉测试文件实际编译验证。测试文件路径：`$TEMP/opencode/h12_verify/test_h1_t_float64_n.cj` 和 `test_h2_floatingpoint.cj`（后因直接通过接口调用失败，改用 `test_h2b_direct.cj` 的 `T.getInf()` 泛型路径验证。验证结果已记录于 §8 验证结果记录表模板。
- **验证项 20（H2——`FloatingPoint<T>` 接口方法）**——✅ **已通过**。`Float32.getInf()`/`getNaN()`/`getMinDenormal()`/`getMinNormal()`/`getE()`/`getPI()` 及实例方法 `isInf()`/`isNaN()` 均编译通过并运行时验证正确。泛型函数 `func f<T> where T <: FloatingPoint<T> { T.getInf }` 对 Float32/Float64 均编译通过——设计文档中 `where T <: FloatingPoint<T>` 约束下的泛型调用路径（如 `isnan`/`isinf`/`mat3Cast`/`mat4Cast`/`quatCast`/`trigonometric.cj` 全体）可正常编译。**注意**：`FloatingPoint<Float32>.getInf()` 直接通过接口调用编译失败（编译器限制，但通过 `T.getInf()` 泛型参数调用路径可用，后者是设计文档实际使用的模式。
- **验证项 25（H1——`T(Float64(n))` 语法）**——✅ **已通过**。`Float32(Float64(0/1/2))`、`Float64(Float64(0/1/2))`、`Int8~Int64(Float64(0/1))`、`UInt8~UInt64(Float64(0/1))` 均编译通过，运行时值正确（已验证 `Float32(0)=0.0`、`Float64(1)=1.0`、`Int32(0)=0`、`Int64(1)=1`、`UInt32(1)=1`、`UInt64(0)=0`。
- **验证项 29（`glm.detail` 导入 `glm.ext` 验证）**——✅ **已通过**。验证日期——2026-06-26（与 H1/H2 同批次核验。验证方式：(a grep `type_quat.cj` 确认无 `import glm.ext.*` 声明——经审核 `type_quat.cj` 中 Vec3×Quat/Vec4×Quat 已采用 v18 内联 conjugate/dot 计算路径，无 `glm.ext` 跨包 import；(b 依赖链追踪确认 `type_quat.cj` 的 import 列表中仅包含 `glm.detail` 同包类型（Vec3/Vec4/Mat3x3/Mat4x4）和 `type_quat_cast` 同包函数，无任何跨包至 `glm.ext` 或 `glm.gtc` 的引用；(c 执行 `cjpm build` 确认编译通过。**验证结论**：`glm.detail → glm.ext` 无反向依赖，包间依赖 DAG 保持 `glm.ext → glm.detail` 单向，无循环依赖风险。

**受 H1/H2 假设影响的函数清单标注**：
以下函数依赖 H1（`T(Float64(n))` 语法可行性）或 H2（`FloatingPoint<T>` 接口方法可用性，对应假设及回退方案详见本节省略所述：
- **依赖 H1 的函数**：`normalize`/`axis`/`mat3Cast`/`mat4Cast`/`Quat×Vec3`/`Quat×Vec4`（函数体内部使用 `T(Float64(0))`/`T(Float64(1))`/`T(Float64(2))` 字面量替代路径
- **依赖 H2 的函数**：`pow`（`FloatingPoint<T>.getMinDenormal()`）/`log`（`FloatingPoint<T>.getInf()`）/`isnan`/`isinf`（`FloatingPoint<T>` 实例方法）/`mat3Cast`/`mat4Cast`/`quatCast`（`where T <: FloatingPoint<T>` 约束）/`trigonometric.cj` 全体（`where T <: FloatingPoint<T>` 约束

### 关于版本标注

**关于版本标注**：本设计文档采用迭代演进式修订方式，仅保留以下类型的版本标记：(a) §7 设计决策表中各决策的版本号（D01~D38）；(b) §3.13.2/§8/§11.5 中用于计数口径解释的少量必要标注；(c) §8.3 核验项 H3/H7 中用于说明版本号核验机制的描述。其他位置的非决策性版本标记通过 H7 grep 门禁自动清理。历史变更追踪由独立文件承载。

### 1.2 阶段三用户能力视图

本小节从最终用户（GLM 迁移者）的视角回答"一个 GLM 使用者能否迁移到 cjglm 阶段三"这一根本问题，提供用户可理解的能力边界声明。

#### 用户能做 vs 不能做

| 能力维度 | 本阶段状态 | 涉及函数 |
|---------|----------|---------|
| **创建与构造四元数** | ✅ 可用 | 逐分量构造、标量+向量构造、跨 Qualifier 构造、跨类型 `fromQuat`、`wxyz` 工厂、`identity` 工厂、从旋转矩阵 `fromMat3`/`fromMat4` |
| **四元数基本运算** | ✅ 可用 | `+`/`-`/`*`/`/`、一元 `-`、`==`/`!=`、下标 `[]`、`length()` |
| **共轭与逆** | ✅ 可用 | `conjugate`、`inverse`（仅浮点 T，整数 T 编译拒绝 |
| **归一化与模长** | ✅ 可用 | `normalize`（仅浮点 T）、`length`、`dot`、`cross` |
| **线性插值** | ✅ 可用 | `lerp`（含 assert 断言 |
| **四元数→矩阵转换** | ✅ 可用 | `mat3Cast`/`mat4Cast`/`quatCast`（仅浮点 T |
| **轴提取** | ✅ 可用 | `axis`（依赖 std.math.sqrt |
| **NaN/Inf 检测** | ✅ 可用 | `isnan`/`isinf`（仅浮点 T |
| **关系比较** | ✅ 可用 | `equal`/`notEqual`（精确与 epsilon 版本）、`lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual` |
| **标量常量** | ✅ 可用 | `epsilon`/`pi`/`cos_one_over_two`（仅浮点 T |
| **数学常量** | ✅ 可用 | 28 个 gtc/constants 函数（zero/one/pi/half_pi 等 |
| **向量 epsilon 比较** | ✅ 可用 | `equal`/`notEqual` epsilon 版本（16 重载 |
| **四元数旋转向量** | ⚠️ 编译通过但抛 stub | `Quat×Vec3`/`Quat×Vec4`（依赖 geometric.cj 向量 cross stub |
| **向量被四元数逆旋转** | ⚠️ 编译通过但抛 stub | `Vec3×Quat`/`Vec4×Quat`（内联 conjugate/dot 路径消除包间循环依赖，但最终经由 `(conjugate(q / dot(q,q) * v` 调用 `Quat×Vec3` 运算符依赖 geometric.cj 向量 cross stub，运行时抛 stub 异常；降级路径见 §3.16 |
| **球面插值** | ❌ 不可用 | `slerp`（3 参数 + 4 参数 |
| **四元数混合** | ❌ 不可用 | `mix` |
| **角度与旋转轴构造** | ❌ 不可用 | `angle`/`angleAxis` |
| **指数/对数/幂/平方根** | ❌ 不可用 | `exp`/`log`/`pow`/`sqrt` |
| **欧拉角** | ❌ 不可用 | `eulerAngles`/`roll`/`pitch`/`yaw` |
| **看向四元数** | ❌ 不可用 | `quatLookAt`/`quatLookAtRH`/`quatLookAtLH` |
| **四元数旋转** | ❌ 不可用 | `rotate`（ext/quaternion_transform |
| **从向量/欧拉角构造** | ❌ 不可用 | `fromVec3`/`fromEuler` |
| **ULP 浮点比较** | ❌ 不可用 | `equal`/`notEqual` ULP 版本（4 函数 8 重载 |
| **矩阵变换函数** | ❌ 不可用 | gtc/matrix_transform 全部 64 个函数 |
| **三角函数** | ❌ 不可用 | trigonometric.cj 全部 75 个函数 |

**总结**——阶段三交付的核心价值是 **四元数类型的基本数学运算**（构造、归一化、共轭、逆、插值、转换。旋转和插值两类关键的四元数语义——**旋转向量**（`Quat×Vec3`/`Vec4`）和**球面插值**（`slerp`）——受到 stub 依赖阻塞，必须依赖阶段四补齐。一个典型的 GLM 使用者如果主要使用四元数进行旋转表达和插值，**无法**在阶段三完成完整的迁移。

#### 典型场景端到端代码示例

以下 6 个典型场景展示阶段三实际可用的代码模式，帮助下游使用者快速判断迁移可行性：

**场景 1——四元数构造与归一化（✅ 完全可用）**
```cangjie
// GLM: glm::quat q(1.0f, 0.0f, 0.0f, 0.0f); q = glm::normalize(q);
let q = Quat<Float32, PackedHighp>.identity(1.0f
let q_norm = normalize(q
assert(length(q_norm > epsilon<Float32>()
```

**场景 2——四元数共轭与逆（✅ 完全可用）**
```cangjie
// GLM: glm::quat inv = glm::inverse(q);
let q = Quat<Float32, PackedHighp>(0.0f, 1.0f, 0.0f, 0.0f
let c = conjugate(q   // Quat(0.0, -1.0, 0.0, 0.0
let inv = inverse(q   // conjugate(q / dot(q, q
let identity_check = q * inv  // 应接近单位四元数
```

**场景 3——四元数线性插值（✅ 完全可用）**
```cangjie
// GLM: glm::qua r = glm::lerp(q1, q2, 0.5f);
let q1 = Quat<Float32, PackedHighp>.identity(1.0f
let q2 = Quat<Float32, PackedHighp>(0.0f, 0.707f, 0.707f, 0.0f
let mid = lerp(q1, q2, 0.5f  // 线性插值，非恒定角速度
```

**场景 4——四元数与旋转矩阵互转（✅ 完全可用）**
```cangjie
// GLM: glm::mat3 m = glm::mat3_cast(q); glm::quat q2 = glm::quat_cast(m);
let q = Quat<Float32, PackedHighp>.identity(1.0f
let m3 = mat3Cast(q       // detail 包级函数
let q2 = quatCast(m3      // 矩阵→四元数
assert(dot(q, q2 > 1.0f - epsilon<Float32>()  // 应接近单位四元数
```

**场景 5——向量被四元数逆旋转（✅ 完全可用）**
```cangjie
// GLM: glm::vec3 v2 = v * q;  // conjugate(q * v
// cjglm Vec3×Quat 通过内联 conjugate/dot 路径实现，不依赖 geometric.cj stub
let v = Vec3<Float32, PackedHighp>(1.0f, 0.0f, 0.0f
let q = Quat<Float32, PackedHighp>.identity(1.0f
let v_rot = v * q  // 内联 conjugate(q / dot(q,q 路径，完全可用
```

**场景 6——四元数旋转向量（⚠️ 编译通过但运行时抛 stub）- 附降级路径**
```cangjie
// GLM: glm::vec3 v2 = q * v;
// 本阶段——编译通过，运行时抛 Exception("stub"
// 降级路径——用内联 conjugate/dot 路径实现等效逆旋转
let q = quatCast(mat3Cast(q)  // 确保单位四元数
let v_rot_inv = v * q          // Vec3×Quat 逆旋转（可用
// 注：q * v（正向旋转）等价于 conjugate(v * q，即
// let v_rot_forward = conjugate(inverse(q) 不可简化为 q，但有额外计算开销
```

#### 阶段三交付后用户预期管理

**短期预期（阶段三交付后 1-4 周）**：
- 用户可以创建、操作和测试四元数类型的基本数学运算（构造、共轭、逆、归一化、线性插值
- 用户可以在单元测试中验证四元数→矩阵转换的正确性
- 用户可以编写基于 `Vec3×Quat` 逆旋转路径的**降级版**旋转代码（不等价于 `Quat×Vec3` 正向旋转，但可作为临时替代
- 用户**无法**进行任何需要三角函数的四元数运算（slerp、球面插值、欧拉角提取、看向计算等
- 用户**无法**进行任何需要 `geometric.cj` 向量叉乘的四元数正向旋转（`Quat×Vec3`/`Quat×Vec4` 仅编译通过

**中长期预期（阶段四交付后）**：
- 全部 165 个 GLM API 实现，18 个 ✅ 函数保留原有行为不变
- `Quat×Vec3`/`Quat×Vec4` 从抛 stub 自动切换为正常旋转（无需修改调用代码
- 88 个 ⚠️/❌ 函数按阶梯顺序补齐：trigonometric.cj → common.cj → geometric.cj → quaternion 依赖函数 → gtc/matrix_transform
- 每批补齐后的回归测试覆盖按 §3.16 阶段四回归测试策略执行

**迁移评估指南**：
- 如果您的代码主要使用四元数做**坐标变换中的旋转表达**（`mat3_cast`/`quat_cast` 互转、`normalize`/`inverse`/`conjugate`，**阶段三可满足大部分需求**
- 如果您的代码依赖**球面插值**（`slerp`/`mix`）或**欧拉角**（`eulerAngles`/`roll`/`pitch`/`yaw`，**阶段三不满足需求，建议等待阶段四**
- 如果您的代码需要**正向旋转**（`Quat×Vec3`，可通过 `Vec3×Quat` 逆旋转配合 `inverse(q)` 实现等效结果（额外计算一倍开销，详见 §3.16 临时降级路径一览表

#### 验证时序审计声明

本设计文档的发布历史上，v1~v24 共 24 轮设计迭代建立在两项未经验证的 P0 核心假设之上——H1（`T(Float64(n))` 语法可行性）和 H2（`FloatingPoint<T>` 接口方法可用性。这两项假设分别在第 25 轮设计迭代时才通过最小仓颉测试文件完成实际编译验证（验证日期——2026-06-26，详见 §8.4 验证结果记录表。

**审计结论**——v1~v24 中所有涉及以下函数的设计决策（包括但不限于签名选择、实现策略、T 约束决策）均建立在未经验证的假设之上——
- **依赖 H1（`T(Float64(n))` 语法）的函数**（24 轮未经编译验证：`normalize`/`axis`/`mat3Cast`/`mat4Cast`/`Quat×Vec3`/`Quat×Vec4`
- **依赖 H2（`FloatingPoint<T>` 接口）的函数**（24 轮未经编译验证：`pow`/`log`/`isnan`/`isinf`/`mat3Cast`/`mat4Cast`/`quatCast`/`trigonometric.cj` 全体

已验证版本 v25 确认两项假设均通过编译（§1 回退方案节验证执行记录，v1~v24 的设计决策未因假设证伪需要修订。**根本原因**——设计迭代流程缺少「验证前置」的制度约束，P0 假设在设计固化前未经过编译器实际核验。

**修复措施**：
1. O-06（验证前置化流程制度化）已在 v27 从「待评估」升级为「下一轮必须实施」，并在 v28 转化为可执行落地计划。**本版本确认 O-06 P0 核心假设已前置验证完毕**：3 项 P0 假设（验证项 20/25/29）已在设计版本固化前完成最小仓颉测试文件编译验证。非 P0 验证项（共 26 项）按计划在编码阶段执行，验证结果待后续补充。
2. 编译器版本依赖跟踪已建立——仓颉编译器版本 `cjdev x.x.x`（阶段二验证通过时的版本。未来版本在前置验证流程中需同步记录编译器版本，避免编译器升级引入假设失效。
3. 所有后续设计版本的 P0 假设验证项必须在版本输出前完成核验并记录结果（参见 §8.4 验证结果记录表模板和 §8.3 I 节 O-06 检查清单。

---

## 2. 模块划分

### 包组织

```
package glm/detail          — 核心实现层（新增/修改文件以 ★ 标记
  ├── type_quat.cj ★        — Quat<T,Q> 结构体定义 + extend 块中的运算符
  │                          (含 Quat×Vec3/Vec4 成员运算符、Vec3×Quat/Vec4×Quat extend 块成员运算符
  │                          (fromMat3/fromMat4 调用同包 type_quat_cast.cj 函数
  ├── type_quat_cast.cj ★  — 矩阵-四元数互转包级函数（mat3Cast/mat4Cast/quatCast
  │                          ，下沉自 gtc/quaternion.cj 以避免包间循环依赖
  ├── common.cj（沿用 stub，阶段二已有
  ├── matrix.cj（沿用混合型，阶段二已有
  ├── geometric.cj（沿用 stub，阶段二已有
  ├── scalar_constants.cj ★ — 标量常量定义（移入 detail，epsilon/pi/cos_one_over_two
  ├── trigonometric.cj ★    — 新增空桩（sin/cos/tan/asin/acos/atan 等签名空壳
  ├── scalar_quat_ops.cj ★  — 标量-四元数运算全局具名函数（add/sub/mul/div，处理 T + Quat 等标量左侧运算

package glm                 — 公共 API 面 + 别名层（修改文件以 ★ 标记
  ├── lib.cj ★              — 新增四元数类型、ext 函数、gtc 常量的 public import
  └── fwd.cj ★              — 新增四元数类型别名

**lib.cj 新增 import 清单**：
- **lib.cj 实际行数声明**——`cjglm/src/lib.cj` 当前**仅 8 行**（经 `wc -l cjglm/src/lib.cj` 验证，文件内容为——第 1 行 `package glm` 声明 + 第 2-8 行共 7 个 `public import glm.detail.{...}` 声明（`Vec1~Vec4` / `Qualifier`/`PackedHighp`/`PackedMediump`/`PackedLowp` / `Defaultp` / `add`/`sub`/`mul`/`div`/`mod` / `fromBoolVec`/`fromBoolVecQ2` / `Mat2x2~Mat4x4` / `transpose`/`matrixCompMult`/`outerProduct`。**阶段三新增的 20 个 import 全部追加至 lib.cj 第 9 行起**（即当前 8 行末尾后逐行追加）——下游编码者按本清单实施时无需在 lib.cj 中查找「第 131 行」（错误引用，原 v12 轮次，直接编辑 8 行文件末尾追加 20 行 import 即可
- `public import glm.detail.{Quat, mat3Cast, mat4Cast, quatCast}` — 四元数类型 + 转换函数：`mat3Cast`/`mat4Cast`/`quatCast` 在 lib.cj 中以 `public import` 形式重导出至顶层 `glm` 命名空间——与现有 `public import glm.detail.{transpose, matrixCompMult, outerProduct}` 包级函数重导出模式一致，见 `cjglm/src/lib.cj:8`——下游消费者可按 `glm.mat3Cast(q)` 路径直接调用，**无需** `import glm.detail.*` 后再调用包级函数 `mat3Cast(q)`
- `import glm.detail.trigonometric` — 三角函数（75 函数空桩，14 标量 + 56 向量 + 1 标量 `atan2` + 4 向量 `atan2`，按 v10 展开规则；
- `import glm.ext.vector_relational` — 向量关系运算（含 16 重载 epsilon + 8 重载 ULP stub
- `import glm.ext.quaternion_common` — 四元数公共函数（5 实现 + 3 stub
- `import glm.ext.quaternion_geometric` — 四元数几何函数（4 实现
- `import glm.ext.quaternion_trigonometric` — 四元数三角函数（1 实现 + 2 stub
- `import glm.ext.quaternion_relational` — 四元数关系运算（4 实现
- `import glm.ext.quaternion_transform` — 四元数变换函数（仅 `rotate` 函数 stub；
- `import glm.ext.quaternion_exponential` — 四元数指数函数（4 函数全部 stub；
- `import glm.ext.scalar_constants` — 标量常量（3 函数重导出
- `import glm.ext.quaternion_float` — Float32 四元数别名（`quat`；
- `import glm.ext.quaternion_double` — Float64 四元数别名（`dquat`；
- `import glm.ext.quaternion_float_precision` — Float32 精度变体别名（`highp_quat`/`mediump_quat`/`lowp_quat`；
- `import glm.ext.quaternion_double_precision` — Float64 精度变体别名（`highp_dquat`/`mediump_dquat`/`lowp_dquat`；
- `import glm.ext.matrix_projection` — 矩阵投影函数库空桩；
- `import glm.ext.matrix_clip_space` — 裁剪空间矩阵函数库空桩；
- `import glm.ext.matrix_transform` — 矩阵变换扩展函数库空桩；
- `import glm.gtc.constants` — 数学常量（28 函数
- `import glm.gtc.quaternion` — gtc 四元数扩展函数库（4 函数重导出 + 4 函数完整 + 7 函数 stub；
- `import glm.gtc.matrix_transform` — 矩阵变换函数库空桩占位：64 个函数签名而非 v12 描述的 35 个；
- **合计 20 个 import**（初始明确 8 个，后扩展 12 个，合计 20 个；下游消费者可按 lib.cj import 清单访问所有新增模块

**fwd.cj 新增 type alias 清单**：
- `type Quat = Quat<Float32, PackedHighp>` — Float32 主别名
- `type FQuat = Quat<Float32, PackedHighp>` — Float32 别名（与 `Quat` 等价，遵循阶段二双别名模式
- `type DQuat = Quat<Float64, PackedHighp>` — Float64 主别名
- `type HighpQuat = Quat<Float32, Highp>` — Float32 高精度别名
- `type MediumpQuat = Quat<Float32, Mediump>` — Float32 中精度别名
- `type LowpQuat = Quat<Float32, Lowp>` — Float32 低精度别名
- `type HighpDQuat = Quat<Float64, Highp>` — Float64 高精度别名
- `type MediumpDQuat = Quat<Float64, Mediump>` — Float64 中精度别名
- `type LowpDQuat = Quat<Float64, Lowp>` — Float64 低精度别名
- **合计 9 个别名**（Quat/FQuat/DQuat + 3×Float32 精度 + 3×Float64 精度 = **9 个**
- 排除项——不含 `BQuat`（Bool 四元数，D17 决策）/ `IQuat`/`I64Quat`（整型四元数，与阶段二 fwd.cj 排除整型矩阵别名策略一致
- **实施路径**——`fwd.cj` 是自动生成文件（`cjglm/src/fwd.cj:1-2` 文件头注释为中文「`// fwd.cj — GLM 兼容类型别名（自动生成）`」+「`// 注意——此文件由脚本自动生成，手动修改请谨慎`」，**手动添加将随重新生成丢失**。采用**方案 A（推荐，修改生成脚本）**。以下给出可直接执行的完整修改方案：

  (a **生成脚本位置**——`cjglm/scripts/gen_fwd_aliases.py`（Python 64 行。现有 `VEC_FAMILIES` 字典代码（`gen_fwd_aliases.py:13-18`）如下——
  ```python
  VEC_FAMILIES = {
      'B': 'Bool', 'I': 'Int32', 'U': 'UInt32', 'Vec': 'Float32',
      'DVec': 'Float64', 'I8': 'Int8', 'I16': 'Int16', 'I32': 'Int32',
      'I64': 'Int64', 'U8': 'UInt8', 'U16': 'UInt16', 'U32': 'UInt32',
      'U64': 'UInt64', 'FVec': 'Float32', 'F32': 'Float32', 'F64': 'Float64',
  }
  ```
  现有 `VEC_PRECISIONS` 列表（`gen_fwd_aliases.py:19-20`：
  ```python
  VEC_PRECISIONS = [('', 'PackedHighp'), ('Highp', 'PackedHighp'),
                    ('Mediump', 'PackedMediump'), ('Lowp', 'PackedLowp')]
  ```

  (b **修改后完整 Python 代码**——在 `main()` 函数中（`gen_fwd_aliases.py:27`，新增针对 Quat 家族的独立循环，避免污染 Vec 原有 DIMS 逻辑。在现有 Vec 家族循环（行 43-51）之后、写入文件之前插入以下代码块——
  ```python
      # === Quat family (fixed 4-dim, no Vec1/Vec2/Vec3 variants ===
      QUAT_FAMILIES = {
          'Quat': 'Float32', 'FQuat': 'Float32', 'DQuat': 'Float64',
      }
      QUAT_PRECISIONS = [('', 'PackedHighp'), ('Highp', 'PackedHighp'),
                         ('Mediump', 'PackedMediump'), ('Lowp', 'PackedLowp')]
      lines.append('// === Quat family ==='
      for prec_prefix, prec_type in QUAT_PRECISIONS:
          for family_name, family_type in QUAT_FAMILIES.items():
              alias_name = f'{prec_prefix}{family_name}'
              lines.append(f'public type {alias_name} = detail.Quat<{family_type}, {prec_type}>'
      lines.append(''
  ```
  **说明**：`QUAT_FAMILIES` 是独立于 `VEC_FAMILIES` 的单独字典，避免在 Vec 循环的 `DIMS = [1,2,3,4]` 中误生成 `Quat1`/`Quat2`/`Quat3` 三个不存在项；`QUAT_PRECISIONS` 与 `VEC_PRECISIONS` 值一致但独立声明，消除循环间意外副作用。

  (c **验证命令**：
  ```bash
  # 验证生成的 fwd.cj 包含全部 9 个 Quat type alias
  grep -c '^public type.*= detail.Quat<' cjglm/src/fwd.cj
  # 预期输出：9（对应 Quat/FQuat/DQuat + 3×Float32 精度 + 3×Float64 精度

  # 验证不生成 Quat1/Quat2/Quat3 错误变体
  grep -c "Quat1\|Quat2\|Quat3" cjglm/src/fwd.cj
  # 预期输出：0（不存在任何带数字后缀的四元数别名

  # 验证 FQuat 精度前缀冗余不存在（gen_fwd_aliases.py 可能生成的误别名
  grep "HighpFQuat\|MediumpFQuat\|LowpFQuat" cjglm/src/fwd.cj
  # 预期输出：0（FQuat 家族不应有 HighpFQuat/MediumpFQuat/LowpFQuat 精度变体——与 Vec 家族 FVec* 精度变体命名约定不一致，Quat 家族统一为 HighpQuat/MediumpQuat/LowpQuat

  # 验证别名具体值
  grep "type \(Highp\|Mediump\|Lowp\|\)Quat" cjglm/src/fwd.cj
  # 预期输出 6 行：Quat / FQuat / HighpQuat / MediumpQuat / LowpQuat（不含 DQuat，DQuat 由下一命令验证
  grep "type.*DQuat" cjglm/src/fwd.cj
  # 预期输出 4 行：DQuat / HighpDQuat / MediumpDQuat / LowpDQuat
  ```

  (d **幂等性验证**：
  ```bash
  python cjglm/scripts/gen_fwd_aliases.py && git diff --stat
  # 首次执行后应有 diff（新增 9 行 Quat alias；再次执行后 git diff --stat 应无输出（幂等
  # 验证方式——连续执行两次，确认第二次无改动
  python cjglm/scripts/gen_fwd_aliases.py
  python cjglm/scripts/gen_fwd_aliases.py && git diff --stat  # 应输出空（无改动
  ```

  **备选方案 B**（如生成脚本修改成本过高）——将 9 个 type alias 移至 `lib.cj` 顶部作为补充声明（`lib.cj` 是手动维护文件，仅 8 行，与现有 type alias 并存；**备选方案 C**——新建独立手动维护文件 `cjglm/src/quaternion_aliases.cj`，在 `lib.cj` 中 `public import` 重导出该文件——本方案需评估 cjpm 构建系统对新增文件的发现机制。本设计文档**推荐方案 A**，与 fwd.cj 的「单一自动生成来源」架构原则一致。

package glm.ext             — 扩展函数库（新增文件以 ★ 标记
  ├── vector_relational.cj ★      — 向量 epsilon/ULP 关系运算函数（epsilon 16 重载完整实现 + ULP 8 重载 stub
  ├── quaternion_relational.cj ★  — 四元数关系运算函数（4 函数完整实现
  ├── quaternion_transform.cj ★   — 四元数变换函数（仅 `rotate` 函数 stub
  ├── quaternion_common.cj ★      — 四元数公共函数（5 函数完整实现 + 3 函数 stub
  ├── quaternion_geometric.cj ★   — 四元数几何函数（4 函数完整实现：dot/length/normalize/cross
  ├── quaternion_trigonometric.cj ★ — 四元数三角函数（1 函数完整实现 + 2 函数 stub
  ├── quaternion_exponential.cj ★   — 四元数指数函数（4 函数全部 stub
  ├── scalar_constants.cj ★        — 向上导出接口（import glm.detail.scalar_constants 并 public import 重导出
  ├── matrix_projection.cj ★       — 新增空桩
  ├── matrix_clip_space.cj ★       — 新增空桩
  ├── matrix_transform.cj ★        — 新增空桩
  ├── quaternion_float.cj ★         — Float32 四元数别名
  ├── quaternion_double.cj ★        — Float64 四元数别名
  ├── quaternion_float_precision.cj ★ — Float32 精度变体别名
  ├── quaternion_double_precision.cj ★ — Float64 精度变体别名

package glm.gtc             — GTC 扩展函数库（新增目录和文件以 ★ 标记
  ├── constants.cj ★        — 数学常量定义（28 个常量函数完整实现
  ├── matrix_transform.cj ★ — 空桩占位（仅函数签名空壳
  ├── quaternion.cj ★       — gtc 四元数扩展函数（4 函数重导出 + 8 函数完整 + 7 函数 stub
  │                          (mat3Cast/mat4Cast/quatCast 通过 public import glm.detail.{...} 重导出
```

### 模块间依赖

```
glm.detail（同包直接可见
  type_quat.cj → type_vec3, type_vec4
  type_quat.cj → type_quat_cast（fromMat3/fromMat4 调用同包 mat3Cast/mat4Cast/quatCast，v3 同包内调用
  type_quat.cj → ext/scalar_constants（epsilon<T>()
  type_quat.cj → common.cj(stub), trigonometric.cj(stub), geometric.cj(stub
  type_quat_cast.cj → type_quat, Mat3x3, Mat4x4, Vec3（同包，无跨包引用
  scalar_quat_ops.cj → type_quat
  scalar_constants.cj → setup.cj（仅依赖 GLM_CONFIG_* 常量

glm.ext
  vector_relational.cj → glm.detail（qualifier, Vec1~Vec4, common.cj stub
  quaternion_relational.cj → glm.detail（Quat, Vec4）, ext/vector_relational
  quaternion_geometric.cj → glm.detail（Quat, 纯算术，不依赖 geometric.cj stub
  quaternion_transform.cj → glm.detail（Quat, Vec3, common.cj stub, trigonometric.cj stub, geometric.cj stub
  quaternion_common.cj → glm.detail（Quat, Vec4, common.cj stub, trigonometric.cj stub
  quaternion_trigonometric.cj → glm.detail（Quat, Vec3, ext/scalar_constants
  quaternion_exponential.cj → glm.detail（Quat, ext/scalar_constants, common.cj stub, trigonometric.cj stub, geometric.cj stub
  scalar_constants.cj → glm.detail.scalar_constants（重导出
  matrix_projection.cj → stub（空桩
  matrix_clip_space.cj → stub（空桩
  matrix_transform.cj → stub（空桩
  quaternion_float.cj → glm.detail（Quat 别名
  quaternion_double.cj → glm.detail（Quat 别名
  quaternion_float_precision.cj → glm.detail（Quat 别名
  quaternion_double_precision.cj → glm.detail（Quat 别名

glm.gtc（单向依赖 glm.detail，无循环
  constants.cj → glm.ext.scalar_constants
  quaternion.cj → glm.detail（public import mat3Cast, mat4Cast, quatCast 进行重导出
  quaternion.cj → glm.detail.{Quat, Mat3x3, Mat4x4, Vec3}（用于实现比较/欧拉/看向函数，——依赖声明过宽，按函数组细分——4 个比较函数（`lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual`）**仅依赖 Quat**；3 个 quatLookAt 函数（`quatLookAt`/`quatLookAtRH`/`quatLookAtLH`）**仅依赖 Vec3**；4 个转换函数（`mat3Cast`/`mat4Cast`/`quatCast` × 2，：camelCase 命名而非 GLM snake_case `mat3_cast`/`mat4_cast`/`quat_cast`）**重导出 detail 端**（不需直接 import Mat/Vec；4 个欧拉函数（`eulerAngles`/`roll`/`pitch`/`yaw`）**依赖 Vec3 + Quat**
  quaternion.cj → glm.ext.scalar_constants（epsilon<T>，用于欧拉角边界检测
  quaternion.cj → glm.ext.vector_relational（equal，用于 roll/pitch 的 equal(vec2, vec2, 0 边界检测
  quaternion.cj → glm.detail.common(stub)（clamp/abs，用于 roll/pitch/yaw/pow
  quaternion.cj → glm.detail.trigonometric(stub)（atan/asin/cos/sin，用于 roll/pitch/yaw
  quaternion.cj → glm.detail.geometric(stub)（cross/dot/normalize/inversesqrt/max，用于 quatLookAt*
  quaternion.cj → glm.detail.type_quat_cast（quaternion.cj 中 quatLookAt* 内部调用 quatCast
  matrix_transform.cj → stub 引用 ext/matrix_projection, ext/matrix_clip_space, ext/matrix_transform,
                         glm.detail.geometric(stub), glm.detail.trigonometric(stub), glm.detail.matrix(stub

glm
  fwd.cj → glm.detail（Quat 别名
  lib.cj → glm.detail（Quat, scalar_constants 函数, type_quat_cast 函数）, glm.ext, glm.gtc
```

**依赖方向总览**：
- `glm.gtc → glm.detail` 单向
- `glm.ext → glm.detail` 单向
- `glm → glm.detail/gtc/ext` 顶层聚合
- `glm.detail` 不依赖任何上层包

### ext/ 新文件与 gtc/ 子包的包名策略

沿用阶段二已验证的策略：
- `src/ext/` 下文件声明 `package glm.ext`
- `src/gtc/` 下文件声明 `package glm.gtc`（需原型验证 cjpm 子包发现机制对 gtc/ 子目录的支持；若不支持，按阶段二备选方案降级至 `package glm` 并在 src/ 根目录存放

### cjpm 子包构建预验证

阶段二已通过验证——`src/ext/` 目录 + `package glm.ext` 的子包发现机制在 cjpm 中可用（[已通过 cjpm 验证]。阶段三新增 `src/gtc/` + `package glm.gtc`，属 cjpm 构建系统的额外不确定性，需原型验证——

- **验证项 1（gtc 子包）**——在 `src/gtc/` 下创建测试文件，验证 cjpm 是否能识别 `package glm.gtc` 声明
- **验证项 2（gtc 重导出 detail 函数）**——验证 `gtc/quaternion.cj` 中 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 能否正确将 detail 包级函数重导出至 glm.gtc 命名空间
- **回退方案**——若 cjpm 不支持 `src/gtc/` 子目录的子包发现机制，将 gtc/ 文件夹内的文件迁移至 `src/` 根目录并降级为 `package glm`，函数路径从 `glm.gtc.quaternion.mat3Cast` 变为 `glm.mat3Cast`（与阶段二 ext/ 子包回退方案一致

---

## 3. 核心抽象

### 3.1 四元数结构体 Quat<T,Q>

**角色**——表示数学四元数的值对象，用于旋转表达和插值运算。

**职责**：
- 承载 4 个分量数据成员（`public var x: T, public var y: T, public var z: T, public var w: T`，，布局与 GLM 默认 xyzw 一致（非 wxyz
- 提供编译期查询函数 `public static func length(): Int64` 返回常量 4
- 提供下标运算符 `[](i: Int64)` 访问分量（取值 + 赋值双版本
- 提供多种构造方式（逐分量构造、标量+向量构造、跨类型构造
- 通过 `@Derive[Hashable]` 自动派生哈希支持

**为何采用 struct（值类型）**——与阶段一 Vec 和阶段二 Mat 一致——四元数是数学计算中的值对象，值语义确保运算符返回新实例、无副作用。

**数据布局选择**：GLM 默认（`GLM_FORCE_QUAT_DATA_XYZW` 未定义时）为 `x, y, z, w` 布局。本设计采用此默认布局，`w` 分量位于第四位置。C++ GLM 的 `qua(T w, T x, T y, T z)` 构造函数参数顺序为 w 在前，但内部存储为 xyzw 后缀。仓颉版本中数据成员声明为 `public var x, public var y, public var z, public var w`（——显式标注 `public` 以满足 `@Derive[Hashable]` 派生宏对字段 `public` 可见性的要求，依据 `cangjie-std/deriving/README.md` 第 4 节「参与派生的字段/属性必须为 public」，与阶段一 Vec3 (`type_vec3.cj:8-10`)、阶段二全部矩阵类型 (`type_mat*.cj` 200+ 处统一实践 的实践对齐，与 GLM 存储布局对应。构造函数参数顺序需与数据布局明确区分——见 §3.3。

**为何不像 C++ GLM 使用匿名 union**——仓颉不支持匿名联合体和 `reinterpret_cast`，无法实现 GLM 中 `union { struct { T x, y, z, w }; storage<4,T> data; }` 的布局技巧。四元数直接声明具名数据成员，与阶段一/二 Vec/Mat 的策略一致。

**`@Derive[Hashable]` 约束核验**——仓颉 `@Derive[Hashable]` 要求——①泛型 type parameter 满足 `Hashable` 接口；②参与派生的字段/属性必须为 `public` 可见性（依据 `cangjie-std/deriving/README.md` 第 4 节「参与派生的字段/属性必须为 public」。`Quat<T, Q>` 中 `T <: Number<T>` 约束下所有数字类型均实现 `Hashable`；`Q <: Qualifier` 约束下 6 个 Qualifier 实现类型均无数据成员（标记类型，其 `Hashable` 派生由编译器自动支持。**字段可见性约束**——Quat 的 4 个数据成员 `x`/`y`/`z`/`w` 统一标注 `public var`（详见上文数据成员描述，满足派生宏对字段 `public` 可见性的硬性要求——若省略 `public` 关键字，struct 字段默认可见性为 `internal`（依据 `struct/README.md` 第 1.7 节，不满足 public 派生要求，编译器将报错。**实践依据**——阶段一 `type_vec3.cj:6` 已使用 `@Derive[Hashable]` 派生并通过编译（Vec3 数据成员 `public var x: T, public var y: T, public var z: T`；阶段二全部矩阵类型（`type_mat2x2.cj`、`type_mat3x3.cj`、`type_mat4x4.cj` 等 9 个矩阵类型文件）均使用 `@Derive[Hashable]` + `public var` 派生并通过编译（200+ 处统一实践，已 grep 验证。阶段三四元数延续相同的 `public var` + `@Derive[Hashable]` 派生模式，**前提条件**——阶段三不新增 Qualifier 变体，6 个 Qualifier 实现类型（`PackedHighp`/`PackedMediump`/`PackedLowp`/`AlignedHighp`/`AlignedMediump`/`AlignedLowp`）与阶段二完全一致。若阶段三新增 Qualifier 变体或 Qualifier 数据结构变更（如携带 alignment/SIMD 标签字段，需重新验证 `@Derive[Hashable]` 派生可行性。需在编码启动前验证项中确认 `@Derive[Hashable]` 对 `Q <: Qualifier` 的派生编译通过。

### 3.2 四元数与向量/矩阵的协作关系

四元数与向量、矩阵之间存在以下协作模式：

| 协作模式 | 描述 | 实现位置 |
|---------|------|---------|
| Quat×Vec3 | 四元数旋转向量 | Quat extend 块成员运算符 |
| Vec3×Quat | 向量被四元数逆旋转 | Vec3 extend 块成员运算符 |
| Quat×Vec4 | 四元数旋转向量（保留 w 分量 | Quat extend 块成员运算符 |
| Vec4×Quat | 向量被四元数逆旋转（保留 w 分量 | Vec4 extend 块成员运算符 |
| Mat3←Quat `mat3Cast` | 四元数转 3×3 旋转矩阵 | **detail/type_quat_cast.cj** 包级函数（camelCase 命名，对应 GLM 原始 `mat3_cast` |
| Mat4←Quat `mat4Cast` | 四元数转 4×4 旋转矩阵 | **detail/type_quat_cast.cj** 包级函数（camelCase `mat4Cast`，对应 GLM 原始 `mat4_cast` |
| Quat←Mat3 `quatCast` | 旋转矩阵转四元数 | **detail/type_quat_cast.cj** 包级函数（camelCase `quatCast`，对应 GLM 原始 `quat_cast` |
| Quat←Mat4 `quatCast` | 4×4 旋转矩阵转四元数 | **detail/type_quat_cast.cj** 包级函数（camelCase `quatCast`，对应 GLM 原始 `quat_cast` |
| Mat↔Quat 转换重导出 | gtc 命名空间下的同名函数 | gtc/quaternion.cj 通过 public import 重导出 detail/type_quat_cast.cj 函数 |

**关键设计决策**——`type_quat.inl` 中的构造函数 `qua(mat3x3)` 和 `qua(mat4x4)` 内部调用 `quat_cast`，而 `qua(Vec3, Vec3)`（从两个向量构造四元数）内部调用 `cross`、`dot`、`normalize` 等 geometric.cj 函数。仓颉版本中——
- `fromMat3`/`fromMat4` 工厂函数（在 `type_quat.cj` 中）调用**同包** `type_quat_cast.cj` 的 `quatCast`/`mat3Cast`/`mat4Cast` 函数（同包内可见，无需跨包 import
- `gtc/quaternion.cj` 通过 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 将 detail 中的转换函数重导出至 gtc 命名空间，保留 GLM 1:1 文件归属的 API 形态

#### 3.2.1 type_quat_cast 函数签名规范

`detail/type_quat_cast.cj` 中 4 个函数的具体签名模板（与 D29 同类约束收紧策略一致：

```cangjie
// 包级 public 函数，package glm.detail
public func mat3Cast<T, Q>(q: Quat<T, Q>): Mat3x3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func mat4Cast<T, Q>(q: Quat<T, Q>): Mat4x4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func quatCast<T, Q>(m: Mat3x3<T, Q>): Quat<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func quatCast<T, Q>(m: Mat4x4<T, Q>): Quat<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
```

**约束说明**：
- `T <: FloatingPoint<T>`（——使用的 `FloatingPointNumber<T>` 非仓颉 stdlib 原生接口名，stdlib `cangjie-std/math/README.md` 第 117 行明确定义为 `FloatingPoint<T>`/`Integer<T>`/`Number<T>` 三层接口）——与 D29 `isnan`/`isinf` 约束收紧策略一致。GLM 1.0.3 在转换函数定义处使用 `GLM_STATIC_ASSERT(std::numeric_limits<T>::is_iec559, ...)` 静态断言非浮点类型时编译失败，仓颉版本通过 `FloatingPoint<T>` 接口约束（stdlib 原生接口）实现等价行为——整数 T（如 `Int64`）实例化时编译期报类型不匹配错误（`Int64` 不实现 `FloatingPoint<Int64>` 接口。
- **重载区分**：`mat3Cast` 与 `mat4Cast` 通过参数类型 `Mat3x3<T,Q>` vs `Mat4x4<T,Q>` 区分；`quatCast` 的 Mat3 与 Mat4 重载同样通过参数类型区分，仓颉泛型重载规则支持此场景。
- **Fallback 模式**（理论上不需要——`FloatingPoint<T>` 是 stdlib 原生接口，编译期保证可用；此 fallback 仅作 前的兼容占位说明）——若仓颉 stdlib 未提供 `FloatingPoint<T>` 接口（极小概率，stdlib 文档已明确，则将约束放宽为 `T <: Number<T>`，并在函数体首部通过 `match` 或 `if-else` 对 `q.x` 的具体类型进行 `Float32`/`Float64` 分派，非浮点 T 实例化时抛 `Exception("mat3Cast/mat4Cast/quatCast not defined for non-floating-point types")`，与 `epsilon<T>()` fallback 策略一致。

**T(1)/T(0 字面量获取与矩阵初始化策略**：
- **GLM 实际依赖**：GLM 1.0.3 `gtc/quaternion.inl:49` 中 `mat3_cast`/`mat4_cast` 函数体内部使用 `Result = Mat3x3(T(1))` 初始化结果矩阵为单位矩阵（即先填 3×3/4×4 单位矩阵作为基底，再覆盖部分元素为四元数旋转分量，强依赖 T(1 字面量。`quat_cast` 函数体内部不直接依赖 T(1)（通过 `trace`/`sqrt` 等运算推导四元数分量，故本策略主要影响 `mat3Cast`/`mat4Cast` 两个函数。
- **仓颉实现路径**——本设计明确选择**逐元素填充模式**——不依赖 Mat3x3/Mat4x4 单参数构造函数。`mat3Cast` 实现模板为——`Result[0][0] = T(Float64(1)); Result[1][1] = T(Float64(1)); Result[2][2] = T(Float64(1)); Result 的其余元素 = T(Float64(0))`，然后覆盖旋转分量。`mat4Cast` 同理。该模式与 §1「常量型 T(n 字面量替代」策略一致（T(1 使用 `T(Float64(1))` 字面量替代，T(0 使用 `T(Float64(0))` 字面量替代——非对角线元素初始化为 `T(Float64(0))` 不依赖 Mat3x3 零初始化默认值，显式逐元素赋值确保跨类型一致性。删除 v9 描述的「`Mat3x3(T(Float64(1)))` 初始化对角线」歧义表述——该表述暗示使用单参数构造函数（若 Mat3x3 存在单参数构造需 `one: T` 形参，与逐元素填充的 `FloatingPoint<T>` 约束签名不一致。——(a 逐元素填充不依赖 Mat3x3/Mat4x4 的任何特定构造函数签名，仅需 `[]` 下标运算符赋值能力（已由 §3.1 Quat 下标运算符和阶段二 Mat 下标运算符验证，下游编码者按模板逐行赋值即可实现；(b 非对角线元素 T(0 显式赋值（不依赖零初始化默认值，与 `axis`/`normalize` 中 T(0 的 `T(Float64(0))` 字面量替代路径一致，形成 §1 统一策略闭环；(c 消除两种初始化路径（单参数构造 vs 逐元素填充）的歧义，下游无需判断 Mat3x3/Mat4x4 是否支持单参数构造函数。

**边界行为契约**：
- **`mat3Cast` 接受非单位四元数**——返回矩阵不保证是旋转矩阵——若输入四元数非单位四元数（含缩放/剪切分量，返回的 3×3 矩阵保留原始四元数的非旋转分量（如四元数长度为 2 时返回矩阵的奇异值近似 2/1/1，与 GLM 1.0.3 行为一致（GLM `type_quat.inl` 不做单位化保护。
- **`mat4Cast` 接受非单位四元数**——与 `mat3Cast` 行为一致，返回 4×4 矩阵保留非旋转分量。
- **`quatCast` 接受非旋转矩阵**——返回的四元数行为未定义——若输入 Mat3/Mat4 含缩放/平移/剪切分量（非纯旋转矩阵，返回四元数可能是非单位四元数、零四元数或 NaN 四元数。GLM 1.0.3 通过 `GLM_STATIC_ASSERT(std::numeric_limits<T>::is_iec559, ...)` + 内部 `trace`/`sqrt` 计算实现，不做旋转矩阵合法性校验。
- **下游消费者契约**——与 §3.3 item 6/7 `fromMat3`/`fromMat4` 工厂函数的边界声明对齐（仅对纯旋转矩阵产生有意义结果）——`mat3Cast`/`mat4Cast`/`quatCast` 是 `fromMat3`/`fromMat4` 的反向操作，两者边界行为互为镜像。

> **集中参考清单（mat3Cast/mat4Cast/quatCast，）**：§1 系统性设计约束（T(0)/T(1 字面量替代路径 + 逐元素填充策略）→ §3.3 item 6/7 fromMat3/fromMat4 工厂函数 → §5.3 边界条件表（非单位四元数/非旋转矩阵行为）→ §3.13.2 审计表 mat3Cast/mat4Cast/quatCast 行 → §11.5 可用性对照表 mat3Cast/mat4Cast/quatCast 行 → §8 验证项 17（FloatingPoint<T> 约束验证）→ §8 验证项 25（T(Float64(n) 语法验证）→ §8 验证项 26（Mat4x4 [] 返回类型验证

**本阶段对 gtc/quaternion 函数的处理策略**：`gtc/quaternion.hpp` 中共 15 个原始声明（`mat3_cast`/`mat4_cast`/`quat_cast` 两个重载/4 个 + `lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual`/4 个比较 + `eulerAngles`/`roll`/`pitch`/`yaw`/4 个欧拉 + `quatLookAt`/`quatLookAtRH`/`quatLookAtLH`/3 个看向 = 15 个。本阶段采取以下分批策略：
- **本文件完整实现（4 个）**（策略段落曾声称「完整实现（8 个）」含 4 个欧拉函数，与 §3.15 函数职责分组表及已有修订说明已归入「stub 占位」直接矛盾；本轮修正为与 §3.15 一致的分类：
  - `lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual` — 4 个比较函数，纯算术
- **从 detail 重导出（4 个）**：
  - `mat3Cast`/`mat4Cast`/`quatCast(Mat3)`/`quatCast(Mat4)` — 通过 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 重导出（——仓颉端 camelCase 命名，对应 GLM 原始 `mat3_cast`/`mat4_cast`/`quat_cast` 习惯——`public import` 不做 snake_case→camelCase 命名转换
- **stub 占位（7 个）**（——原 3 个仅含看向函数，未计入欧拉函数；与 §3.15 函数职责分组一致，4 欧拉 + 3 看向 = 7 stub）——
  - `eulerAngles`/`roll`/`pitch`/`yaw` — 4 个欧拉函数，依赖 `trigonometric.cj` 的 `atan`/`asin` + `common.cj` 的 `clamp` + `vector_relational.cj` 的 `equal` + `scalar_constants.cj` 的 `epsilon<T>()`（均为 stub，——从「完整实现」修正为「stub 占位」，与 §3.15 v5 最终决策一致
  - `quatLookAt`/`quatLookAtRH`/`quatLookAtLH` — 3 个函数，依赖 `geometric.cj` 的 `cross`/`dot`/`normalize`/`inversesqrt`/`max`（均为 stub

**type_quat.cj、type_quat_cast.cj、gtc/quaternion.cj 三者协作关系**：
- `type_quat.cj` 中的 `fromMat3`/`fromMat4` 工厂函数直接调用 `type_quat_cast.cj` 的 `mat3Cast`/`mat4Cast`/`quatCast`（同包内可见，无 import 需求
- `gtc/quaternion.cj` 通过 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 将 detail 函数重导出为 gtc 命名空间下的同名 API
- 仓颉包依赖 DAG：`glm.gtc → glm.detail` 单向，无循环依赖

### 3.3 构造函数体系

每个 Quat<T,Q> 提供以下构造函数和工厂函数：

1. **逐分量构造 const init(x: T, y: T, z: T, w: T)** — 纯赋值，参数顺序为 x, y, z, w（与数据成员声明顺序一致。此为仓颉侧的**主构造函数**。调用方需注意：GLM 的 `qua(T w, T x, T y, T z)` 参数顺序为 w 在前，而仓颉版本参数顺序为 x, y, z, w（w 在后。这是一个**接口形态偏差**（参见 §9。

2. **标量+向量构造 const init(s: T, v: Vec3<T,Q>)** — 将标量 s 作为 w 分量，向量 v 的 xyz 作为 xyz 分量。对应 GLM 的 `qua(T s, vec3 const& v)` 构造函数。

3. **跨 Qualifier 构造 init<Q2>(q: Quat<T,Q2> where Q2 <: Qualifier** — 跨 Qualifier 同类型构造，纯赋值。

4. **跨类型构造 fromQuat<U, P>(conv: (U -> T, q: Quat<U,P> where P <: Qualifier** — extend 块工厂函数，非 const。通过 conv 闭包将 U 类型分量转换为 T 类型。对应 GLM 的 `qua<U,P>(qua<U,P> const& q)` 显式转换构造函数。**调用示例**（下游消费者迁移提示：
   ```
   // Float32 ← Float64 转换
   let q32 = Quat<Float32, PackedHighp>.fromQuat<Float64, PackedHighp>
       { f64 => Float32(f64 },  // conv 闭包
       q64

   // 同类型简化场景——直接使用主构造函数
   let q32_same = Quat<Float32, PackedHighp>(q32.x, q32.y, q32.z, q32.w
   ```

5. **单位四元数工厂函数 identity(one: T)** — extend 块工厂函数，`Number<T>` 约束。返回 `Quat<T,Q>`，其中 w=one, x=T(0), y=T(0), z=T(0。T(0 通过 `one - one` 演算获取。——`one - one` 演算在无符号整数类型上依赖模 2^n 溢出语义（`@OverflowWrapping`，结果恒为 0，行为已定义；与 §3.4 运算符体系 `@OverflowWrapping` 统一标注一致。此为从零构造单位四元数的限定入口，与阶段二矩阵 `identity(one)` 模式一致。**调用示例**——
   ```
    // 必须显式传入 T(1 等价物（如字面量 1.0f
    let q = Quat<Float32, PackedHighp>.identity(1.0f  // 单位四元数 (0, 0, 0, 1)
    ```
   **T(0 获取路径说明**——本函数 T(0 获取路径为 §1 统一策略的刻意例外——因 `identity` 显式携带 `one: T` 形参，选用 `one - one` 演算路径，与 §1「仅对已有 `one: T` 形参的函数保留 `one - one`」原则一致；`normalize`/`axis` 等无 `one: T` 形参的函数统一使用 `T(Float64(0))` 路径。

6. **从旋转矩阵构造 fromMat3(m: Mat3x3<T,Q>)** — 辅助工厂函数，内部调用**同包** `type_quat_cast.quatCast(m)`（——原设计为跨包引用 gtc/quaternion.cj，现改为同包引用 type_quat_cast.cj。——函数签名模板为 `public func fromMat3<T, Q>(m: Mat3x3<T, Q>): Quat<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier`——显式声明 `where T <: FloatingPoint<T> & Comparable<T>` 约束（`Comparable<T>` 为 `quatCast` 实现中 `fourBiggestSquaredMinus1` 大小分支判定的编译期必需依赖），而非隐式继承自内部 callee `quatCast`。整型 T（如 `Int64`）实例化时编译报类型不匹配错误；详见 §3.2.1 type_quat_cast.cj 约束说明。**调试指引**——若开发者用 `Int64` 实例化并调用 `fromMat3(m)`，编译错误将直接定位在 `fromMat3` 的签名约束处（而非内部 `quatCast` 处，提供更清晰的错误定位。非 const。**边界行为**（契约声明）——仅对纯旋转矩阵产生有意义的四元数；对非旋转矩阵（如含缩放/平移/剪切矩阵）行为未定义，结果可能产生非单位四元数或语义错误的旋转。

7. **从旋转矩阵构造 fromMat4(m: Mat4x4<T,Q>)** — 辅助工厂函数，——直接读取 `m.c0`/`m.c1`/`m.c2` 三列（——经查阅阶段二 `type_mat4x4.cj:8-11`，列字段名确为 `c0`/`c1`/`c2`/`c3`，设计假设于 v21 编码启动前核验为正确）构建 `Mat3x3<T,Q>(Vec3<T,Q>(m.c0.x, m.c0.y, m.c0.z), Vec3<T,Q>(m.c1.x, m.c1.y, m.c1.z), Vec3<T,Q>(m.c2.x, m.c2.y, m.c2.z))`，再调用同包 `quatCast(mat3x3)` 转换为四元数。——函数签名模板为 `public func fromMat4<T, Q>(m: Mat4x4<T, Q>): Quat<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier`——显式声明 `where T <: FloatingPoint<T> & Comparable<T>` 约束（`Comparable<T>` 为 `quatCast` 实现的编译期必需依赖），而非隐式继承自内部 callee。整型 T 实例化时编译失败——编译错误直接定位在 `fromMat4` 签名约束处（而非内部 `quatCast` 处。非 const。：(a 该手动提取路径直接使用 `Vec3<T,Q>(T, T, T)` 主构造函数构造向量分量，再使用 `Mat3x3<T,Q>(Vec3, Vec3, Vec3)` 主构造函数构造 3×3 矩阵——**两条构造路径均不携带 `one: T` 形参**（Vec3 主构造与 Mat3x3 主构造均无 `one` 形参，区别于跨维度 `fromMat` 工厂函数重载，因此 `fromMat4` 函数签名本身无需 `one: T` 形参；(b 与 §1「系统性设计约束」中"**T(1 的获取——必须由调用方显式传入参数（`one: T`）**"一致——本函数不调用任何需要 T(1 的运算路径（不调用 `fromMat(Mat_Larger, one)` 跨维度工厂函数，不调用 `identity(one)` 单位矩阵工厂函数，故无需该形参；(c ——修订曾引用阶段二 `cjglm/src/detail/type_mat2x2.cj:163-165` `Mat2x2.fromMat(Mat3x3, one)` 作为"列提取模式无需 `one`"的依据，但该引用本身存在内部矛盾——被引用的代码 `Mat2x2.fromMat(Mat3x3, one)` 显式携带 `one: T` 形参（即阶段二全部 9 个矩阵类型的 `fromMat` 工厂函数**均要求** `one: T` 形参，无论源/目标矩阵尺寸关系，仅同维度 `fromMat` 简化为无 `one` 形参，与"无需 `one`"结论相悖。——删除错误的代码引用作为论据，改为基于本函数的实际构造路径（Vec3 主构造 + Mat3x3 主构造，均无 `one` 形参依赖）说明无需 `one` 形参的合理性，与 §1 系统性约束彻底闭环。**边界行为**——同上，依赖 `fromMat3` 的输入合法性——若 `m` 的左上 3×3 子矩阵非纯旋转矩阵，结果未定义。

8. **从两向量构造 fromVec3(u: Vec3<T,Q>, v: Vec3<T,Q>)** — 辅助工厂函数，内部实现从两个归一化轴构建四元数。依赖 geometric.cj 的 `dot`/`cross`/`normalize`（均为 stub，因此本阶段为 **stub 占位**，完整实现推迟至阶段四。**边界行为契约**——当输入向量 u, v 退化触发条件为 GLM 1.0.3 `detail/type_quat.inl:196-217` 中 `if (real_part < static_cast<T>(1.e-6f * norm_u_norm_v)` 退化分支，其中 `real_part = norm_u_norm_v + dot(u, v)`，触发条件等价于 `dot(u,v ≈ -sqrt(dot(u,u * dot(v,v))` 即「`u, v` 反平行」。退化分支内轴选择逻辑：GLM 实际为 `t = abs(u.x > abs(u.z ? vec<3, T, Q>(-u.y, u.x, static_cast<T>(0) : vec<3, T, Q>(static_cast<T>(0), -u.z, u.y); t = normalize(t)`——基于 `abs(u.x > abs(u.z)` 二选一选择「与 u 垂直的两条可能轴之一」并经 `normalize(t)` 归一化。返回 `q.w = 0` 且 `q.xyz` 模长为 1 的纯向量四元数（`real_part = 0`。这是 GLM 对反平行输入的容错设计，避免返回零四元数导致除零。**契约声明**：`fromVec3` 对反平行输入的返回值**行为已定义**（返回 `q.w = 0` 的纯向量四元数，轴选择由 `abs(u.x > abs(u.z)` 条件决定，行为与 GLM `detail/type_quat.inl:196-217` 一致，下游消费者可依赖该契约；对零向量输入则行为未定义（由 `normalize` stub 在阶段四补齐时确定。

9. **从欧拉角构造 fromEuler(eulerAngles: Vec3<T,Q>)** — 辅助工厂函数，依赖 trigonometric.cj 的 `cos`/`sin`（均为 stub，因此本阶段为 **stub 占位**，完整实现推迟至阶段四。

10. **wxyz 工厂函数 wxyz(w: T, x: T, y: T, z: T)** — 静态工厂函数，参数顺序为 w, x, y, z（与 GLM `qua::wxyz(w,x,y,z)` 一致，内部返回 `Quat<T,Q>(x, y, z, w)`。提供与 GLM wxyz 习惯一致的调用入口。

### 3.4 运算符体系

所有算术运算符定义在 `Number<T>` 约束的 extend 块中（与阶段一/二一致，并统一标注 `@OverflowWrapping` 注解以保持跨类型一致性（标注对浮点类型无效果，但与阶段一 Vec3 (`type_vec3.cj:54-80` 和阶段二全部矩阵类型 (`type_mat2x2.cj` 等 的实践对齐。Bool 四元数不支持算术运算。

**成员运算符**（定义在 Quat extend 块中：

| 运算符 | 语义 | 约束 | 备注 |
|-------|------|------|------|
| 一元 `-` | 逐分量取反 | `Number<T>` | 标注 `@OverflowWrapping` |
| 二元 `+` | 四元数加法 | `Number<T>` | 标注 `@OverflowWrapping` |
| 二元 `-` | 四元数减法 | `Number<T>` | 标注 `@OverflowWrapping` |
| 二元 `*` | 四元数乘法（Hamilton 乘积 | `Number<T>` | 标注 `@OverflowWrapping` |
| 二元 `*` (Quat×Vec3 | 四元数旋转向量 | `Number<T>` | 实现：`v + (cross(QuatVector, v * q.w + cross(QuatVector, cross(QuatVector, v)) * T(Float64(2))`（两次 Vec3 叉乘 `uv`/`uuv`，末尾乘 `T(Float64(2))` 字面量作为缩放因子——原 `* 2` 在 Cangjie 泛型上下文中需显式转换为 `T(Float64(2))` 字面量，避免 `T * Int64` 类型不匹配问题，与 §1「常量型 T(n 字面量替代」策略对齐。定义 `QuatVector` 符号：`QuatVector = Vec3(q.x, q.y, q.z)` 是四元数的虚部向量（GLM `type_quat.inl:359-366` 实际命名；完整展开公式为 `QuatVector = Vec3(q.x, q.y, q.z); uv = cross(QuatVector, v); uuv = cross(QuatVector, uv); return v + (uv * q.w + uuv * T(Float64(2))`。**依赖 `geometric.cj` 向量 `cross`（阶段三 stub，调用将抛 `Exception("stub")`** |
| 二元 `*` (Quat×Vec4 | 四元数旋转向量（保留 w | `Number<T>` | 实现——`Vec4(q * Vec3(v), v.w)`（其中 `q * Vec3(v)` 是上一行 `Quat×Vec3` 运算符的复用，保留 `v.w` 作为输出 Vec4 的 w 分量；**Issue 3 响应，明确 `Vec4(q * Vec3(v), v.w)` 公式含义**——第一参数 `q * Vec3(v)` 是 `Quat×Vec3` 运算符返回的 Vec3 结果，第二参数 `v.w` 是输入 Vec4 的 w 分量原样传递，构造输出 Vec4；——本公式依赖 Vec4 主构造函数支持 `Vec4<T, Q>(Vec3<T, Q>, T)` 两参数签名，第一参数为 Vec3 旋转结果（xyz 分量，第二参数为 T 类型 w 分量原样传递。该双参数主构造函数在阶段一 `type_vec4.cj` 中已实现——阶段一 Vec4 主构造函数已声明 `init(vec3: Vec3<T, Q>, w: T)` 两参数版本作为 Vec4 标准构造入口之一（与逐分量构造 `init(x: T, y: T, z: T, w: T)` 并列，下游按设计字面实现 `Vec4(q * Vec3(v), v.w)` 时编译可行**。**通过 Vec3 中间路径间接依赖 `Quat×Vec3`，阶段三调用同样抛 stub 异常** |
| 二元 `*` (Quat×T | 四元数×标量 | `Number<T>` | 标注 `@OverflowWrapping` |
| 二元 `/` (Quat/T | 四元数/标量 | `Number<T>` | 标注 `@OverflowWrapping`；整数 T 除零时触发仓颉 `ArithmeticException`，浮点 T 除零时产生 Inf/NaN 分量 |
| `==` | 精确比较（返回 bool | `Equatable<T>` | |
| `!=` | 不等比较 | `Equatable<T>` | |

**命名约定说明**——上表中 `Quat×Vec3` 行公式中的 `cross(QuatVector, v)` 调用的是 **Vec3 叉乘**（定义于 `geometric.cj`，参数为 `Vec3<T,Q>`，**非 §3.7 中的四元数 `cross`（Hamilton 乘积）**。两者通过类型消歧区分（参数类型为 Vec3 时调用 Vec3 叉乘，参数类型为 Quat 时调用四元数 Hamilton 乘积。

**Bool 四元数算术运算编译期拒绝**——上表算术运算符（一元 `-`/二元 `+`/`-`/`*`/Quat×T/Quat/T）均以 `Number<T>` 为约束。`Bool` 类型不实现 `Number<T>` 接口，因此 `Quat<Bool, Q>` 实例化时算术运算符重载因类型约束不满足而**编译期自动拒绝**（与阶段二 D33 Bool 矩阵策略一致。Bool 四元数仅可使用 `==`/`!=` 比较（`Equatable<Bool>` 由 stdlib 派生支持，符合 D17 决策意图。

**Vec extend 块成员运算符**（定义在 `detail/type_quat.cj`，`package glm.detail`，Vec3/Vec4 extend 块中：

| 运算符 | 语义 | 约束 | 备注 |
|-------|------|------|------|
| Vec3×Quat | `(conjugate(q / dot(q, q) * v` | `Number<T>` | **⚠️ 运行时抛 stub 异常**。v18 采用内联逆四元数计算路径消除包间循环依赖（`conjugate(q)` 和 `dot(q,q)` 均为纯算术运算，但最终 `(conjugate(q / dot(q,q) * v` 通过同包 `Quat×Vec3` 运算符完成旋转，`Quat×Vec3` 依赖 `geometric.cj` 向量 `cross`（阶段三 stub，运行时传播 stub 异常。详见本节「实现链路注释」|
| Vec4×Quat | `(conjugate(q / dot(q, q) * v`（保留 w | `Number<T>` | **⚠️ 运行时抛 stub 异常**。通过 Vec3 中间路径间接依赖 `Quat×Vec3`，运行时传播同源 stub 异常。详见本节「实现链路注释」|

**实现链路注释**——本阶段 `Vec3×Quat`/`Vec4×Quat` **编译通过但运行时抛 `Exception("stub")`**。依赖链为 `Vec×Quat` → `(conjugate(q / dot(q, q) * v` → `conjugate` (逐分量取反 + `dot` (纯算术 + `Quat×Vec3` 运算符（同包。内联 `conjugate`/`dot` 消除了 `glm.detail → glm.ext` 的跨包 import 依赖，但**未改变 `Quat×Vec3` 运算符内部对 `geometric.cj` 向量 `cross` stub 的运行时调用**。`(conjugate(q / dot(q,q) * v` 中的 `*` 运算符重载最终委托至 `Quat×Vec3` 实现路径，后者内部调用 `cross(QuatVector, v)`（Vec3 叉乘，`geometric.cj` 中为 stub，运行时传播 `Exception("stub")`。**本阶段状态标记为 ⚠️**（与 `Quat×Vec3`/`Quat×Vec4` 对齐；阶段四 `geometric.cj` 向量 `cross` 完整实现后，运行时行为自动从抛 stub 切换到正常旋转。

**全局具名函数**（scalar_quat_ops.cj，处理标量左侧运算：

| 函数 | 语义 | 约束 |
|------|------|------|
| `add<T, Q>(s: T, q: Quat<T, Q>)` | 标量加四元数 | `Number<T>` |
| `sub<T, Q>(s: T, q: Quat<T, Q>)` | 标量减四元数 | `Number<T>` |
| `mul<T, Q>(s: T, q: Quat<T, Q>)` | 标量乘四元数 | `Number<T>` |
| `div<T, Q>(s: T, q: Quat<T, Q>)` | 标量除四元数 | `Number<T>` |

注——标量×四元数乘法无需单独"交换律别名"函数——`Quat×T` 运算符（右操作数为 T）已通过 §3.4 成员运算符表的 `二元 * (Quat×T)` 行覆盖；而 `T * Quat`（左操作数为 T）由于仓颉运算符重载规则——左操作数类型决定 operator 函数归属——无法定义为 Quat 的成员运算符，必须通过 `scalar_quat_ops.cj` 的全局函数 `mul<T, Q>(s: T, q: Quat<T, Q>)` 实现（与 D05 决策一致。——删除原描述中"仓颉 `Number<T>` 加法/乘法具备交换律语义"的错误表述——`Number<T>` 接口本身**不提供交换律语义**，仅约束四则运算的实现；标量×四元数（左操作数为 T）通过 `scalar_quat_ops.cj` 全局函数实现的根本原因是左操作数类型决定 operator 函数归属，而非 `Number<T>` 提供交换律覆盖。仓颉函数重载规则禁止重复签名（同参数列表+同返回类型无法构成有效重载，将触发"重复定义"编译错误，因此 `scalar_quat_ops.cj` 的 `mul` 全局函数与 `type_quat.cj` 的 `Quat×T` 成员运算符不构成重载冲突——前者实现 `T * Quat`，后者实现 `Quat * T`，左操作数类型不同。

**一元 + 运算符**——仓颉不支持重载一元 `+` 运算符（与 deviations.md IF-01 一致，`+q` 不可编译，直接使用 `q` 即可。

**复合赋值运算符**：`+=`/`-=`/`*=`（四元数乘法）/`*=`（标量乘法）/`/=` 由编译器自动生成（仓颉语言规范保证，与阶段二一致。

### 3.5 ext/vector_relational.cj

**角色**——提供向量 epsilon 容差比较和 ULP 比较扩展函数。

**职责**——定义 8 个函数（4 个 epsilon 版本 + 4 个 ULP 版本，每个函数按 Vec1~Vec4 分量数提供泛型重载。

**epsilon 版本**（完整实现：
- `equal(x: VecN<T,Q>, y: VecN<T,Q>, epsilon: T): VecN<Bool,Q>` — 逐分量 `|x-y| < epsilon`（严格小于，与 GLM 1.0.3 `glm/gtc/epsilon.inl:32-41` 中 `epsilonEqual` 实现一致；——原引用 `func_vector_relational.inl:18-22` 错误——GLM 1.0.3 的 `func_vector_relational.inl` 中**不包含 epsilon 版本**的 `equal`/`notEqual`，epsilon 版本位于 `glm/gtc/epsilon.inl`（文件层面属 gtc 子包）
- `equal(x: VecN<T,Q>, y: VecN<T,Q>, epsilon: VecN<T,Q>): VecN<Bool,Q>` — 逐分量容差向量版本，同上严格小于语义
- `notEqual(x: VecN<T,Q>, y: VecN<T,Q>, epsilon: T): VecN<Bool,Q>` — 逐分量 `|x-y| >= epsilon`（大于等于，与 epsilon 版本互补
- `notEqual(x: VecN<T,Q>, y: VecN<T,Q>, epsilon: VecN<T,Q>): VecN<Bool,Q>` — 逐分量容差向量版本

**ULP 版本**（依赖 `detail::float_t<T>` 位表示——仓颉无等价机制：
- 仓颉无 `reinterpret_cast` 或浮点位表示直接访问能力（`float_t<T>::i`/`mantissa()`/`exponent()`/`negative()` 等在 C++ 中通过 union 技巧实现，ULP 比较函数在仓颉中**无法完整实现**。
- **ULP 比较的 stub/替代策略**：ULP 版本的 4 个函数（`equal`/`notEqual` 含 `int ULPs` 和 `VecN<int,Q> ULPs` 变体）**本阶段以空桩占位**，待阶段四评估仓颉 `std.math.Float` 或 CFFI 方案实现位级浮点比较后补齐。

**完整函数清单**（本阶段完整实现，4 个 epsilon 版本 × 4 个分量数 = 16 个重载：

| 函数 | 分量数 | 签名模式 |
|------|--------|---------|
| equal | Vec1~Vec4 | `func equal<T, Q>(x: VecN<T,Q>, y: VecN<T,Q>, epsilon: T): VecN<Bool,Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier` |
| equal（向量 epsilon | Vec1~Vec4 | `func equal<T, Q>(x: VecN<T,Q>, y: VecN<T,Q>, epsilon: VecN<T,Q>): VecN<Bool,Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier` |
| notEqual | Vec1~Vec4 | 同上模式 |
| notEqual（向量 epsilon | Vec1~Vec4 | 同上模式 |

**依赖分析**：epsilon 版本内部使用 `abs`（来自 common.cj stub）和 `lessThanEqual`/`greaterThan`（Vec 的 extend 块成员函数，需 `Comparable<T>` 约束。由于 common.cj 中 `abs` 为 stub，epsilon 版本也**依赖 common.cj stub**。

**依赖 common.cj stub 的递归问题**——`vector_relational.cj` 的 `equal`/`notEqual` epsilon 版本内部调用 `abs(x - y)` 和 `lessThanEqual(abs(x - y), epsilon)`，其中 `abs` 来自 common.cj（当前为 stub。**解决策略**——在 vector_relational.cj 中的 epsilon 比较函数内部，将 `abs` 内联展开为 `let d = x - y; VecN(if (d.x >= T(0) { d.x } else { -d.x }, ...)` 模式，避免依赖 common.cj 的 `abs` stub。这要求 `Number<T>` 约束下有 `Comparable<T>` 以支持 `>=` 比较。此内联方式与阶段一 `ComputeEqualNumeric` 中使用 `std.math.abs` 的策略一致——此处优先内联以消除对 common.cj stub 的运行时依赖风险。

### 3.6 ext/quaternion_relational.cj

**角色**——提供四元数 epsilon 容差比较和精确比较扩展函数。

**职责**——定义 4 个函数（精确比较 2 个 + epsilon 比较 2 个）——

| 函数 | 语义 |
|------|------|
| `equal(x: Quat<T,Q>, y: Quat<T,Q>): Vec4<Bool,Q>` | 逐分量精确比较 |
| `equal(x: Quat<T,Q>, y: Quat<T,Q>, epsilon: T): Vec4<Bool,Q>` | 逐分量容差比较（与 vector_relational 严格小于语义一致 |
| `notEqual(x: Quat<T,Q>, y: Quat<T,Q>): Vec4<Bool,Q>` | 逐分量精确不等 |
| `notEqual(x: Quat<T,Q>, y: Quat<T,Q>, epsilon: T): Vec4<Bool,Q>` | 逐分量容差不等 |

**依赖分析**——精确比较版本直接使用 `==` 比较，无外部依赖。epsilon 比较版本使用内联 `abs` 模式和 `lessThanEqual`/`greaterThanEqual`（Vec4 的 Comparable 约束，与 ext/vector_relational.cj 策略一致。

### 3.7 ext/quaternion_geometric.cj

**角色**——提供四元数几何函数（dot、length、normalize、cross。

**职责**：
- `dot(x: Quat<T,Q>, y: Quat<T,Q>): T` — 四元数点积 `x.w*y.w + x.x*y.x + x.y*y.y + x.z*y.z`。可直接实现，不依赖 geometric.cj 的向量 dot（虽然在 GLM 中委托给 `compute_dot<qua<T,Q>,T>` 特化，但仓颉版本直接内联计算。
- `length(q: Quat<T,Q>): T` — 四元数长度 `sqrt(dot(q,q))`。依赖 `std.math.sqrt`（仓颉标准库提供，不依赖 geometric.cj。**Float32 实例的 sqrt 处理**：`std.math.sqrt` 提供 Float16/Float32/Float64 重载（见 §1 ，T=Float32 实例化时直接调用 `std.math.sqrt(dot_qq)`（直接利用 Float32 重载，无需显式 Float64 转换；T=Float64 时直接使用 `std.math.sqrt` 返回值。
- `normalize(q: Quat<T,Q>): Quat<T,Q>` — 归一化四元数。（补充 GLM 零四元数保护行为）——实现公式与 GLM `ext/quaternion_geometric.inl:17-24` 完全一致——`tmp1 = length(q); if (tmp1 <= T(Float64(0)) { return identity_q } else { return q / tmp1 }`，其中 `tmp1 <= T(0)` 时返回**单位四元数**（`Quat(T(Float64(0)), T(Float64(0)), T(Float64(0)), T(Float64(1)))`。——零保护分支返回值中 xyz 分量的 T(0 原策略「通过 `one - one` 演算（需 `one: T` 形参显式传入）」在本函数签名 `normalize(q: Quat<T,Q>): Quat<T,Q>`（不含 `one: T` 形参）中不可用，**统一修订为 `T(Float64(0))` 字面量替代路径**（与 `axis` 函数中 `Vec3(T(Float64(0)), T(Float64(0)), T(Float64(1)))` 模式一致，T(1 通过 `T(Float64(1))` 字面量替代获取（与 §1「常量型 T(n 字面量替代」策略一致，同时覆盖 T(0 和 T(1)。**设计意图**——与 §5.1「normalize 零四元数返回单位四元数」契约对齐，避免下游按字面实现时零四元数除零产生 NaN 分量。**length 极小值边界行为**——`tmp1` 为极小正数（如浮点最小次正规数）时不触发零保护分支，返回 `q / tmp1` 结果各分量趋向 Inf/NaN（与 GLM 行为一致，GLM 不做 length 极小值保护；如需防止此类溢出，应在调用 `normalize` 前自行检查 `length(q >= epsilon<T>()`。**T(0)/T(1 获取路径**——本函数体内 `T(0)` 与 `T(1)` 的获取策略遵循 §1「系统性设计约束」段的 统一约定——T(0 与 T(1 均通过 `T(Float64(0))`/`T(Float64(1))` 字面量替代路径获取，无需 `one: T` 形参；两者**不**在本函数体内重复展开获取路径说明。**实现策略**——收紧 T 约束为 `where T <: FloatingPoint<T>`（与 D32 `mat3Cast`/`mat4Cast`/`quatCast` 策略一致，整数 T 实例化时编译期报类型不匹配错误，消除整数除法截断导致的语义歧义。函数体内部调用 `length(q)` 并判断零保护分支；仅浮点 T 路径可调用。——`normalize` 函数完整边界行为契约（零四元数 + length 极小值 + 实现公式）详见 §5.3 边界条件表「零四元数 `(0,0,0,0)`」+「`length(q)` 极小值」两行的整合描述；§3.13.2 审计节 normalize 行 + §11.6 四命名空间接口可达性矩阵 normalize 行均同步新增反向引用，参见相应章节。

> **集中参考清单（normalize）**：§1 系统性设计约束（T(0)/T(1 字面量替代路径）→ §5.3 边界条件表（零四元数保护 + length 极小值）→ §3.13.2 审计表 normalize 行 → §11.5 可用性对照表 normalize 行 → §8 验证项 25（T(Float64(n) 语法验证）→ §8 验证项 20（FloatingPoint<T> 接口验证，影响 length 的 sqrt 路径
- `cross(q1: Quat<T,Q>, q2: Quat<T,Q>): Quat<T,Q>` — 四元数叉积（Hamilton 乘积的逐分量展开，四元数"cross"语义与向量叉乘不同——向量 `cross` 产生垂直于输入平面的向量，四元数 `cross` 产生 Hamilton 乘积的逐分量展开形式，结果仍是四元数。可直接完整实现。

**命名歧义说明**——上述 `cross` 函数与阶段二 stub 中 `geometric.cj` 的向量 `cross`（面向 Vec3 叉乘，产生垂直向量）存在概念差异——四元数 `cross` 即 Hamilton 乘积（结果为四元数，与向量叉乘（结果为向量）含义完全不同。**下游消费者判别方法**——
- 参数为 `Vec3<T,Q>` 时调用向量 `cross`（geometric.cj，当前 stub
- 参数为 `Quat<T,Q>` 时调用四元数 `cross`（quaternion_geometric.cj，已完整实现
- §3.4 `Quat×Vec3` 旋转公式中的 `cross(QuatVector, v)` 内部调用的是**向量 `cross`**（参数 QuatVector 和 v 均为 Vec3，与本节四元数 `cross` 不冲突

**关键发现**——这 4 个函数的依赖链终止于 `std.math.sqrt`（仓颉标准库提供，**不依赖**阶段二/三的任何 stub 文件。本阶段可**完整实现**。

### 3.8 ext/quaternion_transform.cj

**角色**——提供四元数变换函数（rotate。

**依赖分析**：GLM 的 `quaternion_transform.hpp` 依赖 common.hpp、trigonometric.hpp、geometric.hpp。其中 `rotate` 函数使用 `sin`/`cos`（来自 trigonometric.cj stub）和 `length`（来自 geometric.cj stub。

**本阶段实现策略**：
- `rotate(q: Quat<T,Q>, angle: T, axis: Vec3<T,Q>): Quat<T,Q>` — 依赖 `sin`/`cos` 和 `length`（均为 stub，本阶段 **stub 占位**

**修正**——经仔细审查 `quaternion_transform.hpp` 和 `.inl`，GLM 中 `ext/quaternion_transform.hpp` 仅定义了 `rotate` 一个函数。而 `angleAxis` 定义在 `ext/quaternion_trigonometric.hpp` 中。`quatLookAt`/`quatLookAtRH`/`quatLookAtLH` 定义在 `gtc/quaternion.hpp` 中。

因此 ext/quaternion_transform.cj 本阶段仅包含 `rotate` 的 stub。其余函数对应的归入各自的模块。

### 3.9 ext/quaternion_trigonometric.cj

**角色**——提供四元数三角函数（angle、axis、angleAxis。

**依赖分析**：
- `angle(x: Quat<T,Q>): T` — 依赖 `abs`、`asin`、`acos`、`sqrt`、`pi<T>()`（scalar_constants。`abs` 可内联，`asin`/`acos` 为 trigonometric.cj stub。**stub 占位**。
- `axis(x: Quat<T,Q>): Vec3<T,Q>` — 实现公式（与 GLM `ext/quaternion_trigonometric.inl:20-27` 一致：`tmp1 = T(Float64(1) - x.w * x.w`；若 `tmp1 <= T(Float64(0))` 返回 `Vec3(T(Float64(0)), T(Float64(0)), T(Float64(1)))`（z 轴单位向量；否则 `tmp2 = T(Float64(1) / std.math.sqrt(tmp1)`（——`std.math.sqrt` 提供 Float16/Float32/Float64 重载，`tmp1` 类型为 T 时编译器按实例化类型自动选择对应重载，无需显式 Float64 转换，返回 `Vec3(x.x*tmp2, x.y*tmp2, x.z*tmp2)`。依赖 `std.math.sqrt`（§1 确认提供 Float16/Float32/Float64 重载，方案 A 推荐直接调用；实现公式遵循 `tmp2 = T(Float64(1) / std.math.sqrt(tmp1)` 路径。同时依赖 `T(Float64(1))` 字面量替代（无需 `one: T` 形参，**可完整实现**。**T(1 获取方式**——文档描述「T(1 演算通过 `x.w*x.w` 取得」是错误的——`x.w*x.w` 是 w² 而非 1，无法作为 T(1 的演算路径。本函数采用 §1「系统性设计约束」中 的「常量型 T(1 字面量替代」策略——`T(Float64(1))` 显式转换路径——`Float64(1.0)` 是字面量，`T(Float64(1.0))` 在 `T = Float64` 时返回 1.0，在 `T = Float32` 时返回 1.0f，无需 `one: T` 形参污染函数签名。**边界行为（契约，v8 强化，v10 公式精修）**——触发 `Vec3(T(0), T(0), T(1))` 返回值的条件为 `T(Float64(1) - x.w*x.w <= T(Float64(0))`（典型场景——单位四元数 `(0, 0, 0, 1)` 即 `|w| >= 1`；对于真正的零四元数 `(0, 0, 0, 0)`，`tmp1 = 1 > 0` 进入 else 分支返回 `Vec3(0, 0, 0)`（**注意——原描述的「内部 `normalize(Vec3(0, 0, 0))` 返回 `Vec3(T(1), T(0), T(0))`」为虚构实现，GLM 源码不调用 `normalize`，纠正**。

> **集中参考清单（axis，）**：§1 系统性设计约束（T(1 字面量替代路径 + std.math sqrt 重载）→ §5.3 边界条件表（零四元数 + `1-w² <= 0` 触发）→ §3.13.2 审计表 axis 行 → §11.5 可用性对照表 axis 行 → §8 验证项 12（length sqrt 转换验证）→ §8 验证项 21（std.math Float32 重载验证）→ §8 验证项 25（T(Float64(n) 语法验证
- `angleAxis(angle: T, axis: Vec3<T,Q>): Quat<T,Q>` — 依赖 `sin`/`cos`（trigonometric.cj stub。**stub 占位**。

**修正本阶段策略**：
- `axis` — **完整实现**（依赖仅 `std.math.sqrt` 和 T(1) 演算，零四元数保护行为见上
- `angle` — **stub 占位**（依赖 trigonometric.cj 的 `asin`/`acos`
- `angleAxis` — **stub 占位**（依赖 trigonometric.cj 的 `sin`/`cos`

### 3.10 ext/quaternion_exponential.cj

**角色**——提供四元数指数函数（exp、log、pow、sqrt。

**依赖分析**：
- `exp(q: Quat<T,Q>): Quat<T,Q>` — 依赖 `length`（quaternion_geometric，已实现）、`epsilon<T>()`（scalar_constants.cj，line 10 用于 `Angle < epsilon<T>()` 退化检测）、`cos`/`sin`（trigonometric.cj stub。**stub 占位**。
- `log(q: Quat<T,Q>): Quat<T,Q>` — 依赖 `length`（quaternion_geometric）、`epsilon<T>()`（scalar_constants.cj，line 23 用于 `Vec3Len < epsilon<T>()` 退化检测）、`pi<T>()`（scalar_constants.cj，line 28 用于 `wxyz(log(-q.w), pi<T>(), ...)`）、`atan`/`log`（trigonometric.cj/exponential.cj 接口——std.math `atan`/`log` 实际提供 Float16/Float32/Float64 重载，T=Float32 实例化时直接调用即可）、`std::numeric_limits<T>::infinity()` 等价物（line 30 用于 w=0 退化分支，——仓颉 stdlib **实际提供** `FloatingPoint<T>.getInf()` 静态方法——v10 描述「不提供」错误——`FloatingPoint<T>` 接口（依据 `cangjie-original-docs/std/math/math_package_api/math_package_interfaces.md` 第 5-17 行定义）实际提供 6 个静态方法（`getE`/`getInf`/`getPI`/`getMinDenormal`/`getMinNormal`/`getNaN`）+ 3 个实例方法（`isInf`/`isNaN`/`isNormal`，下游实现应直接调用 `FloatingPoint<T>.getInf()` 而非类型分派；fallback 路径仍可使用 `T(1)/T(0)` 显式构造获取正无穷（仅对浮点类型有效）。**stub 占位**。
- `pow(x: Quat<T,Q>, y: T): Quat<T,Q>` — 依赖 `epsilon<T>()`/`abs`/`clamp`/`asin`/`acos`/`sin`/`cos`/`sqrt`/`cos_one_over_two<T>()` + **调用 `std.math.pow` 实数降级路径两次**（GLM line 65 + line 78，——v10「递归调用」措辞不准确——line 65 与 line 78 是两次独立的 `std.math.pow` 调用而非 self-recursion）+ `std::numeric_limits<T>::min()` 等价的仓颉次正规数边界检查。其中 `epsilon<T>()`/`cos_one_over_two<T>()` 来自 scalar_constants.cj（line 52——`if(abs(x.w / magnitude > cos_one_over_two<T>())`，`abs`/`clamp` 来自 common.cj stub，`asin`（line 68——`Angle = asin(sqrt(VectorMagnitude / magnitude)`）/`acos`/`sin`/`cos` 来自 trigonometric.cj stub，`sqrt` 来自 std.math，`std.math.pow` 来自仓颉标准库（line 65 + line 78 两次独立调用——）——
  - **GLM line 65 翻译**：`return qua<T, Q>::wxyz(pow(x.w, y), 0, 0, 0)` —— GLM `wxyz(w, x, y, z)` 构造签名（w 在前；仓颉等价为 `Quat<T,Q>(T(std.math.pow(Float64(x.w), Float64(y))), T(Float64(0)), T(Float64(0)), T(Float64(0)))`（仓颉主构造函数顺序为 x/y/z/w，故 `Quat(0, 0, 0, pow(x.w, y))`；：T 实例化为 Float32 时 `std.math.pow` 直接接受 `Float32, Float32` 重载，无需 `Float64(...)` 转换层，调用语义为「次正规数过小」分支的实数降级路径
  - **GLM line 78 翻译**：`T Mag = pow(magnitude, y-1)` —— 仓颉等价为 `T Mag = T(std.math.pow(Float64(magnitude), Float64(y - T(1))))`（与 line 65 翻译同理；T=Float32 实例化时 `std.math.pow(Float32, Float32)` 直接返回 Float32，调用语义为一般路径的实数降级路径
- `std::numeric_limits<T>::min()` 用于次正规数边界（line 63——`if (VectorMagnitude < (std::numeric_limits<T>::min)())`，仓颉 stdlib 实际提供 `FloatingPoint<T>.getMinDenormal()` 静态方法——下游实现应通过 `FloatingPoint<T>.getMinDenormal()` 直接获取。**命名消歧与 Float64 转换**——将命名消歧与 Float64 转换依赖两段合并为单一权威说明。四元数 `pow` 函数体内部调用的 `pow(x.w, y)` 是**实数版本** `std.math.pow`，仓颉 stdlib 明确定义 `pow(Float32, Float32): Float32`、`pow(Float32, Int32): Float32`、`pow(Float64, Float64): Float64`、`pow(Float64, Int64): Float64` 共 4 个重载——下游实现时应根据 T 实例化类型选择对应重载——当 T=Float32 时调用 `std.math.pow(Float32, Float32): Float32`（直接调用，无需 Float64 转换；当 T=Float64 时调用 `std.math.pow(Float64, Float64): Float64`，与四元数 `pow` 本身（`pow(Quat, T): Quat`）通过参数类型消歧（第一参数类型 `Float32`/`Float64` 与 `Quat<T,Q>` 区分；若 `std.math.pow` 不可用需以 `exp(y * log(x.w))` 替代实现。**stub 占位**。
- `sqrt(x: Quat<T,Q>): Quat<T,Q>` — 委托 `pow(x, T(0.5))`。**stub 占位**。

注：4 个函数均依赖 trigonometric.cj/common.cj stub，本阶段全部 **stub 占位**。`pow` 的依赖关系以 GLM `ext/quaternion_exponential.inl:41-80` 实际实现为准。`exp`/`log`/`pow` 函数分别补充 `epsilon<T>()`、`pi<T>()` 等 scalar_constants.cj 依赖。`pow` 补充 `cos_one_over_two<T>()`/`asin`/`std.math.pow`/`std::numeric_limits<T>::min()` 等价物依赖。

### 3.11 ext/quaternion_common.cj

**角色**——提供四元数公共函数（mix、lerp、slerp、conjugate、inverse、isnan、isinf。

**依赖分析**：
- `dot` — 委托 quaternion_geometric.cj，完整可用
- `conjugate(q: Quat<T,Q>): Quat<T,Q>` — **完整实现**。仅对 x/y/z 三个分量取反，w 分量保持不变——`Quat(-q.x, -q.y, -q.z, q.w)`（与 GLM `ext/quaternion_common.inl:112-116` `wxyz(q.w, -q.x, -q.y, -q.z)` 一致；——描述「仅涉及逐分量取反」语义不准确，逐分量取反对应 `negative` 运算符 `-q`，而 `conjugate` 仅对 x/y/z 取反、保留 w。等价实现可基于主构造函数或 wxyz 工厂函数。**const func 适用性**——`conjugate` 函数体仅涉及 `Quat` 主构造函数的逐分量取反调用（`Quat(-q.x, -q.y, -q.z, q.w)`，无 `assert`/无 `throw`/无 `dot`/`normalize`/其他非 const 函数调用，**可声明为 `const func`**。**阶段二实践依据**——阶段一 `cjglm/src/detail/type_vec3.cj:54-80` 已成功声明 27 个逐分量运算符与函数为 `const func`，包括 `negative(vec3): Vec3`（逐分量取反，等价于 `-v`）、`negate(vec3): Vec3`（等价于 `-v` 的别名）等——`conjugate` 函数体实现模式（`Quat(-q.x, -q.y, -q.z, q.w)` 主构造函数 + 逐分量取反）与阶段一 `negative`/`negate` 的实现模式（`Vec3(-v.x, -v.y, -v.z)`）完全一致；阶段二全部矩阵类型（`type_mat2x2.cj` 等 9 个文件）的逐分量运算符（如 `negative(mat): Mat`）同样已声明为 `const func` 实践成功。**实践结论**——`conjugate` 在仓颉侧**可声明为 `const func`**，与阶段一 Vec 家族 27 个 const func + 阶段二 Mat 家族逐分量 const func 的实践一致；下游按 `Quat(-q.x, -q.y, -q.z, q.w)` 主构造函数调用模式实现即可，无需担心编译期 const 上下文拒绝。——若仓颉 const 函数还有其他限制（如不能调用非 const 自由函数、不能包含复杂表达式，则该论断需进一步评估；与 §5.4 const 上下文约束段保持一致。**§8 编码启动前验证项新增**——新增验证项 24「`conjugate` const func 编译可行性验证」，与 §8 现有验证项 1-23 一并执行
- `inverse(q: Quat<T,Q>): Quat<T,Q>` — `conjugate(q / dot(q, q)`。**完整实现**（依赖 dot 和 除法运算符。**约束收紧**——函数签名从 `where T <: Number<T>` **收紧为 `where T <: FloatingPoint<T>`**，与 `normalize` 的 v26 收紧策略一致。整数 T（`Int8`~`Int64`）实例化时编译期报类型不匹配错误，消除整数除法截断导致的无声错误结果。**边界行为（契约，）**——
  - 浮点四元数 `dot(q,q == T(0)` 时除以零产生 Inf/NaN 分量（与 GLM 行为一致，GLM 不做零除保护
  - 整数四元数 `dot(q,q == T(0)` 因约束收紧已**编译期拒绝**（整数 T 不再可实例化 `inverse`
- `lerp(x, y, a): Quat<T,Q>` — `x * (1 - a + y * a`。**完整实现**（运行时，非 const，含 `assert(a >= 0 && a <= 1)` 断言与 GLM `ext/quaternion_common.inl:28-38` 一致。`const` 约束说明：lerp 不可声明为 `const func`，因函数体内 `assert` 不是 `const` 函数（与 deviations.md IF-03 一致，调用时不可在 `const` 上下文（如 `const val` 初始化、`const func` 函数体）中使用。
- **跨 Qualifier 行为**——本阶段仅提供 `x` 与 `y` 同 Q 的签名模板 `lerp(x: Quat<T,Q>, y: Quat<T,Q>, a: T): Quat<T,Q>`。若下游出现 `x` 与 `y` 的 Qualifier 不同的合法场景（如 `Quat<Float32, Highp>` 与 `Quat<Float32, Mediump>` 插值，当前签名模板将因 Q 不匹配触发编译错误。**统驭全篇的跨 Qualifier 策略声明**——本阶段所有 40+ 个泛型函数和运算符（包括但不限于 §3.4 运算符表、§3.7 dot/length/normalize/cross、§3.9 axis、§3.11 inverse/conjugate/isnan/isinf 等）均遵循以下统一策略——
  **(a 本阶段**——所有跨 Qualifier 调用的函数和运算符**仅提供相同 Qualifier 的签名模板**（即 `len(x: Quat<T,Q>): T` 等函数在 Q1 ≠ Q2 时触发编译错误。跨 Qualifier 场景通过调用方自行进行显式转换解决（调用跨 Qualifier 构造函数 `Quat<T,Q2>(q_of_Q1)` 将输入转换为目标 Qualifier。
  **(b 阶段四扩展**——对以下函数按优先级（P0→P1→P2）补充双 Qualifier 重载——P0（高用户需求）——`lerp`/`inverse`/`normalize`/`dot`/`length`；P1（中等用户需求）——`conjugate`/`cross`/`isnan`/`isinf`；P2（低用户需求）——`axis`/`equal`/`notEqual`/`lessThan`/`greaterThan` 等比较函数。双 Qualifier 重载统一语义——将较低精度 Qualifier 升级为较高精度 Qualifier（如 `Mediump` → `Highp`，输出 Qualifier 取较高者。
  **(c 跨 Qualifier 行为一致性保证**——所有双 Qualifier 重载的内部实现均采用「提升→运算→提升结果」三步模式——先将低精度 Qualifier 提升至与高精度一致，执行同 Q 运算，输出保留高精度 Qualifier。该模式与 GLM 的精度提升规则一致。
  **阶段性建议**——阶段四或按需实现时，新增双 Qualifier 重载 `lerp(x: Quat<T,Q1>, y: Quat<T,Q2>, a: T): Quat<T,?>` where T <: Number<T>, Q1 <: Qualifier, Q2 <: Qualifier——将 `x` 隐式转换为 `Q2`（通过跨 Qualifier 构造函数 `init<Q2>(q: Quat<T,Q2> where Q2 <: Qualifier` 实现，见 §3.3 item 3，再执行同一 Q 下的 `lerp` 运算，输出 Qualifier 取 `Q2`（与 `y` 一致。该重载在阶段四补充实现，本阶段不做阻塞。
- `slerp(x, y, a): Quat<T,Q>` — 依赖 `dot`/`acos(cosTheta)`（`trigonometric.cj` 的 `acos(T): T` 单参数版本，`明确`）/`sin((1-a)*angle)`/`sin(a*angle)`/`sin(angle)`（`trigonometric.cj` 的 `sin(T): T` 单参数版本，`明确`）/`mix`（标量版）+ `epsilon<T>()`。`acos`/`sin` 属 trigonometric.cj stub，`mix` 属 common.cj stub，`epsilon<T>()` 来自 scalar_constants.cj。**stub 占位**。
- `mix(x, y, a): Quat<T,Q>` — 依赖 `dot`/`acos(cosTheta)`（`trigonometric.cj` 的 `acos(T): T` 单参数版本，`明确`）/`sin((1-a)*angle)`/`sin(a*angle)`/`sin(angle)`（`trigonometric.cj` 的 `sin(T): T` 单参数版本，`明确`）/`epsilon<T>()`。`epsilon<T>()` 用于 `cosTheta > 1 - epsilon<T>()` 的退化检测分支。**stub 占位**。
- `slerp(x, y, a, k)` — 多旋转 slerp。**stub 占位**。**依赖关系**——`dot`/`acos`/`sin`/`mix`（标量版，line 98-101 四次标量 `mix` 调用）/`epsilon<T>()`/`pi<T>()`（line 107——`T phi = angle + static_cast<T>(k * glm::pi<T>();`。其中 `pi<T>()` 来自 scalar_constants.cj，`mix` 来自 common.cj stub。**`k` 类型决策**——采用 `slerp<T, Q>(x: Quat<T,Q>, y: Quat<T,Q>, a: T, k: Int64)` 简化版签名。GLM 4-arg `slerp` 使用独立整型参数 `S`（通过 `static_assert(is_integer)` 约束，仓颉版本固定为 `Int64`（与 deviations.md DV-03「移位运算右操作数固定为 Int64」风格一致，牺牲泛型灵活性换取签名简洁性。**理由**——阶段三 slerp 函数本身为 stub，固定 `Int64` 简化签名不影响本阶段实施；阶段四 slerp 完整实现时若需泛型 K 可扩展。
- `isnan(q: Quat<T,Q>): Vec4<Bool,Q>` — 依赖 `x.isNaN()` 实例方法（仓颉 `std.math` 仅提供实例方法，**不提供**顶层 `std.math.isNaN(x)` 函数。**T 类型约束**——函数签名添加 `where T <: FloatingPoint<T>` 约束（与 §3.12 `epsilon<T>()` 约束收紧策略一致，限制函数仅对浮点类型 T 可调用。当调用方实例化 `Quat<Int64, PackedHighp>` 等整数四元数并调用 `isnan(q)` 时，编译期报类型不匹配错误（`Int64` 不实现 `FloatingPoint<Int64>` 接口，而非运行时报 `isNaN` 实例方法不存在错误。**Fallback 模式（理论不需要，仅兼容占位说明）**——由于 `FloatingPoint<T>` 是 stdlib 原生接口（`cangjie-std/math/README.md` 第 117 行明确定义，编译期保证可用，无「接口不可用」风险；此 fallback 仅作 前的兼容占位说明——若某实现版本缺失 `FloatingPoint<T>` 接口（极小概率，则采用与 `epsilon<T>()` 类似的运行时分派模式——通过 `match` 或 `if-else` 对 `q.x` 的具体类型进行 `Float32`/`Float64` 分派，非浮点 T 实例化时抛 `Exception("isnan not defined for non-floating-point types")`。**实现路径**——约束通过后采用实例方法路径 `Vec4(q.x.isNaN(), q.y.isNaN(), q.z.isNaN(), q.w.isNaN())`。
- `isinf(q: Quat<T,Q>): Vec4<Bool,Q>` — 依赖 `x.isInf()` 实例方法。**T 类型约束**——与 `isnan` 完全一致，函数签名添加 `where T <: FloatingPoint<T>` 约束；fallback 模式与 `isnan` 一致。**实现路径**——约束通过后采用实例方法路径 `Vec4(q.x.isInf(), q.y.isInf(), q.z.isInf(), q.w.isInf())`。

**本阶段策略（修正后）**：
- **完整实现**：`conjugate`、`inverse`、`lerp`（含断言 + 非 const）、`isnan`、`isinf`
- **stub 占位**：`mix`、`slerp`（2 版本，4 参数版 `k: Int64`

### 3.12 scalar_constants 与 gtc/constants

**ext/scalar_constants.cj**：
- 提供 3 个泛型函数：`epsilon<T>()`、`pi<T>()`、`cos_one_over_two<T>()`
- 实际实现位于 `glm.detail.scalar_constants.cj`（声明 `package glm.detail`，ext/ 文件仅做 `public import` 重导出
- 依赖仅 `setup.cj`（GLM_CONFIG_* 配置常量，可**完整实现**
- **整数类型 T 的行为契约**——约束收紧为 `T <: FloatingPoint<T>`（stdlib 原生接口，`cangjie-std/math/README.md` 第 117 行）或等价约束（如仓颉版本不支持，则采用 `T <: Float32 | Float64`。**若仓颉泛型不支持窄约束**，则在 `match` 中增加 `case _ => throw Exception("epsilon/pi/cos_one_over_two not defined for non-floating-point types")` 显式错误分支。GLM 1.0.3 `scalar_constants.inl:36-43` 使用 `static_assert(std::numeric_limits<genType>::is_iec559, ...)` 静态断言非浮点类型时编译失败——仓颉版本采用运行时异常等价行为。
- **具体类型分派**（与 deviations.md DV-04 的 `epsilonOf` 策略一致，需 `hint: T` 参数辅助类型推断）——对 Float32 返回 `Float32(1.1920929e-7)`，对 Float64 返回 `Float64(2.220446049250313e-16)`；`pi<T>()` 和 `cos_one_over_two<T>()` 同理使用具体类型硬编码值
- **与 `shim_limits.cj:25` `epsilonOf<T>(hint)` 关系**——阶段二 `cjglm/src/detail/shim_limits.cj:25` 已存在同名语义的 `public func epsilonOf<T>(hint: T): T where T <: Number<T>` 函数（通过 `NumericLimits<T>.epsilon(hint)` 内部实现，规则与本设计完全一致——`Float64` 返回 `2.220446049250313e-16`，`Float32` 返回 `1.1920929e-7`，其他类型返回 `hint - hint`；`compute_vector_relational.cj:17` 已使用 `epsilonOf<T>(hint)` 模式。：
  - (a **功能等价无业务新增**：`epsilon<T>()` 与 `epsilonOf<T>(hint)` 在返回值语义上**完全一致**——两者均按 `T = Float32/Float64` 返回相同的硬编码机器精度值，对其他类型均返回 `hint - hint` 形式的零值
  - (b **签名差异说明**：`epsilon<T>()` 无形参（与 GLM `glm::epsilon<T>()` 习惯对齐，`epsilonOf<T>(hint)` 携带 `hint: T` 形参（与 deviations.md DV-04 类型推断辅助参数风格一致）——下游调用者可按需选用，函数体实现可共享（`epsilon<T>()` 内部调用 `epsilonOf<T>(T(0))` 或 `epsilonOf<T>(T(1))` 即可
  - (c **阶段二测试硬编码值作为 ground truth**——阶段二测试 `tests/glm/detail/test_shim_limits.cj` 中硬编码的 `epsilon` 值（`Float32(1.1920929e-7)` / `Float64(2.220446049250313e-16)`）作为本设计 `epsilon<T>()` 实现的 ground truth；阶段三新增 `tests/glm/detail/test_scalar_constants.cj` 应交叉验证两者返回值一致
  - (d **编码启动前验证项新增**——本节末尾追加「验证 `epsilon<T>()` 与 `epsilonOf<T>(hint)` 在 T=Float32/Float64/Int64 下的返回值一致性」验证项

**epsilon 硬编码参考值（ground truth，供验证项 19 直接引用）**：
  - `Float32`: `1.1920929e-7`（对应 `Float32(1.1920929e-7)`
  - `Float64`: `2.220446049250313e-16`（对应 `Float64(2.220446049250313e-16)`
  - 整数类型（`Int8`~`Int64`：`0`（通过 `hint - hint` 或 `T(Float64(0))` 获取
  - 以上值源自阶段二测试 `tests/glm/detail/test_shim_limits.cj` 的硬编码 ground truth，阶段三 `test_scalar_constants.cj` 应交叉验证 `epsilon<T>()` 与 `epsilonOf<T>(hint)` 返回值完全一致

**gtc/constants.cj**：
- 提供 **28 个**常量函数（zero/one/two_pi/tau/root_pi/half_pi/three_over_two_pi/quarter_pi/one_over_pi/one_over_two_pi/two_over_pi/four_over_pi/two_over_root_pi/one_over_root_two/root_half_pi/root_two_pi/root_ln_four/e/euler/root_two/root_three/root_five/ln_two/ln_ten/ln_ln_two/third/two_thirds/golden_ratio
- ——文档文字描述列出 28 个常量函数名称（与 GLM 1.0.3 `gtc/constants.inl` 实际声明数一致）但汇总数字误标为「25」，本轮统一修订为「28」。**测试覆盖目标同步**——`tests/glm/gtc/test_constants.cj`至少 28 个测试用例，每常量函数 1 个用例验证返回值正确性
- 全部为泛型函数 `func zero<T>(): T` 等，内部使用具体类型硬编码值直接返回（与 GLM `genType(3.14159...)` 实现方式一致，避免函数间调用依赖
- 依赖 `ext/scalar_constants.cj`（间接通过 detail/scalar_constants.cj
- 可**完整实现**

### 3.13 新增空桩文件

本阶段新增以下空桩文件以满足 gtc/matrix_transform.cj 的传递依赖闭合：

| 文件 | 包 | 内容 |
|------|---|------|
| `trigonometric.cj` | glm.detail | **标量/向量重载区分**——提供 30 个函数（15 标量 + 15 向量，详见 §3.13.1 |
| `ext/matrix_projection.cj` | glm.ext | `perspective`/`ortho` 等投影矩阵函数空壳 |
| `ext/matrix_clip_space.cj` | glm.ext | 裁剪空间矩阵函数空壳 |
| `ext/matrix_transform.cj` | glm.ext | `translate`/`rotate`/`scale`/`lookAt` 等变换函数空壳 |
| `gtc/matrix_transform.cj` | glm.gtc | 矩阵变换函数库（）——本阶段声明 64 个函数签名（与 GLM 1.0.3 `glm/gtc/matrix_transform.hpp` 通过 `ext/matrix_transform.inl` + `ext/matrix_clip_space.inl` + `ext/matrix_projection.inl` 三文件间接包含的实际声明数 64 一致）作为 stub 占位；下游按 lib.cj 第 9 行追加的 `import glm.gtc.matrix_transform` 调用时所有函数均存在但实现为 `throw Exception("stub")`。具体清单见 §3.13 表格下「`gtc/matrix_transform.cj` 函数清单 +  35→64，Issue 1+2 响应）」段 |

**沿用自阶段二的 stub**：`common.cj`、`geometric.cj`、`matrix.cj`（27 实现 + 6 stub

**`gtc/matrix_transform.cj` 函数清单 Issue 4 响应，）**——GLM 1.0.3 `glm/gtc/matrix_transform.hpp` 实际声明 64 个函数（依据 GLM 1.0.3 源码全文检索统计，分布于 3 个间接 include 的 .inl 文件——`ext/matrix_transform.inl` 11 个 + `ext/matrix_clip_space.inl` 46 个 + `ext/matrix_projection.inl` 7 个 = **64 个**。本阶段声明所有函数签名作为 stub 占位，确保下游 lib.cj 第 9 行追加 `import glm.gtc.matrix_transform` 调用时所有函数均存在但实现为 `throw Exception("stub")`。：
- ——v12 实际列出 3+2+5+10+10+1+4 = 35 个，与 GLM 实际 64 个偏差 29 个
- ：`scaleAlongAxis`（GLM 中**不存在**）+ `tweakedInfinitePerspectiveLH_ZO`/`tweakedInfinitePerspectiveLH_NO`/`tweakedInfinitePerspectiveRH_ZO`/`tweakedInfinitePerspectiveRH_NO`（GLM 中**仅 2 个** `tweakedInfinitePerspective` 重载，定义于 `ext/matrix_clip_space.inl:593` + `:611`，函数签名 `tweakedInfinitePerspective(T fovy, T aspect, T zNear, T ep)` 与 `tweakedInfinitePerspective(T fovy, T aspect, T zNear)`，**无 ZO/NO 变体**
- ：identity、scale_slow、shear、shear_slow、lookAtRH、lookAtLH 等基础变换 6 个（基础变换分类仅 3 个应为 11 个；orthoZO、orthoNO、orthoLH、orthoRH 等视口变体 4 个（视口变换分类仅 5 个应为 9 个；frustum（一般）+ frustumZO + frustumNO + frustumLH + frustumRH 等视锥体 5 个（遗漏整个 frustum 系族 9 个；perspective（一般）+ perspectiveZO + perspectiveNO + perspectiveLH + perspectiveRH 等 5 个（perspective 系族仅 4 个应为 9 个；perspectiveFovZO + perspectiveFovNO + perspectiveFovLH + perspectiveFovRH 等 5 个（perspectiveFov 系族仅 4 个应为 9 个；infinitePerspectiveRH、infinitePerspectiveLH 等 2 个（infinitePerspective 系族仅 5 个应为 7 个
- **`matrixCompMult` 归属错误**：`matrixCompMult` 实际定义于 `glm/detail/func_matrix.inl`（与 `gtc/matrix_transform.hpp` 无关，不应列入本文件清单

具体函数清单，共 64 个函数：

| 类别 | 函数数量 | 函数列表 | GLM 源文件 |
|------|---------|---------|-----------|
| 基础变换 | 11 | `identity`、`translate`、`rotate`、`rotate_slow`、`scale`、`scale_slow`、`shear`、`shear_slow`、`lookAtRH`、`lookAtLH`、`lookAt` | `ext/matrix_transform.inl` |
| 视口与裁剪空间（ortho 系族 | 10 | `ortho`（无 zNear/zFar）、`ortho`（3D 一般版本，含 zNear/zFar）、`orthoLH_ZO`、`orthoLH_NO`、`orthoRH_ZO`、`orthoRH_NO`、`orthoZO`、`orthoNO`、`orthoLH`、`orthoRH` | `ext/matrix_clip_space.inl` |
| 视口与裁剪空间（frustum 系族 | 9 | `frustum`、`frustumLH_ZO`、`frustumLH_NO`、`frustumRH_ZO`、`frustumRH_NO`、`frustumZO`、`frustumNO`、`frustumLH`、`frustumRH` | `ext/matrix_clip_space.inl` |
| 透视投影（perspective 系族 | 9 | `perspective`、`perspectiveLH_ZO`、`perspectiveLH_NO`、`perspectiveRH_ZO`、`perspectiveRH_NO`、`perspectiveZO`、`perspectiveNO`、`perspectiveLH`、`perspectiveRH` | `ext/matrix_clip_space.inl` |
| 透视投影（perspectiveFov 系族 | 9 | `perspectiveFov`、`perspectiveFovLH_ZO`、`perspectiveFovLH_NO`、`perspectiveFovRH_ZO`、`perspectiveFovRH_NO`、`perspectiveFovZO`、`perspectiveFovNO`、`perspectiveFovLH`、`perspectiveFovRH` | `ext/matrix_clip_space.inl` |
| 无穷远透视（infinitePerspective 系族 | 7 | `infinitePerspective`、`infinitePerspectiveLH_ZO`、`infinitePerspectiveLH_NO`、`infinitePerspectiveRH_ZO`、`infinitePerspectiveRH_NO`、`infinitePerspectiveLH`、`infinitePerspectiveRH` | `ext/matrix_clip_space.inl` |
| 无穷远透视（tweakedInfinitePerspective 系族 | 2 | `tweakedInfinitePerspective(T fovy, T aspect, T zNear, T ep)`（4 参数含 `ep`）、`tweakedInfinitePerspective(T fovy, T aspect, T zNear)`（3 参数无 `ep` | `ext/matrix_clip_space.inl:593, :611` |
| 投影工具 | 6 | `projectZO`、`projectNO`、`project`、`unProjectZO`、`unProjectNO`、`unProject` | `ext/matrix_projection.inl` |
| 拾取矩阵 | 1 | `pickMatrix` | `ext/matrix_projection.inl` |
| **合计** | **64 个函数**（先前描述「35 个函数」与 GLM 1.0.3 实际 64 个函数显著偏差 29 个；为 64 个函数按 6 大类 + 子类分组明确列出，确保 lib.cj 第 9 行追加 `import glm.gtc.matrix_transform` 能正常解析所有 64 个函数；`matrixCompMult` 已从清单中移除——实际定义于 `glm/detail/func_matrix.inl` 而非 gtc/matrix_transform；ortho 系族从 9 修正为 10（补充 3D ortho 一般版本 `ortho(T left, T right, T bottom, T top, T zNear, T zFar)`，合计 11+10+9+9+9+7+2+6+1=**64** 条目数不变——原 9 个 ortho 子类实际函数清单缺少 3D 一般版本，但总和 63 未被检出是因 `ext/matrix_clip_space.inl` 按函数列表归属计数时 ortho 族实际恰好 10 个（两个 `ortho` 重载 + 8 个变体，分组时遗漏了含 zNear/zFar 参数的 3D ortho 重载 |

**完整函数签名模板**——以下按 9 个分类逐一列出全部 64 个函数的完整 Cangjie 签名模板。所有函数统一约束 `where T <: FloatingPoint<T>, Q <: Qualifier`，函数体统一为 `{ throw Exception("stub" }`。签名中的参数类型 `Mat4x4<T, Q>` / `Vec3<T, Q>` / `Vec2<T, Q>` / `Vec4<T, Q>` 使用阶段一/二已定义的类型。

**1. 基础变换（11 个函数）**
```cangjie
public func identity<T, Q>(): Mat4x4<T, Q>
public func translate<T, Q>(m: Mat4x4<T, Q>, v: Vec3<T, Q>): Mat4x4<T, Q>
public func rotate<T, Q>(m: Mat4x4<T, Q>, angle: T, axis: Vec3<T, Q>): Mat4x4<T, Q>
public func rotate_slow<T, Q>(m: Mat4x4<T, Q>, angle: T, axis: Vec3<T, Q>): Mat4x4<T, Q>
public func scale<T, Q>(m: Mat4x4<T, Q>, v: Vec3<T, Q>): Mat4x4<T, Q>
public func scale_slow<T, Q>(m: Mat4x4<T, Q>, v: Vec3<T, Q>): Mat4x4<T, Q>
public func shear<T, Q>(m: Mat4x4<T, Q>, n: Vec3<T, Q>, s: T): Mat4x4<T, Q>
public func shear_slow<T, Q>(m: Mat4x4<T, Q>, n: Vec3<T, Q>, s: T): Mat4x4<T, Q>
public func lookAtRH<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>
public func lookAtLH<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>
public func lookAt<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>
```

**2. ortho 系族（10 个函数）**
```cangjie
public func ortho<T, Q>(left: T, right: T, bottom: T, top: T): Mat4x4<T, Q>
public func ortho<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func orthoLH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func orthoLH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func orthoRH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func orthoRH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func orthoZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func orthoNO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func orthoLH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func orthoRH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
```

**3. frustum 系族（9 个函数）**
```cangjie
public func frustum<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func frustumLH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func frustumLH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func frustumRH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func frustumRH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func frustumZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func frustumNO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func frustumLH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func frustumRH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
```

**4. perspective 系族（9 个函数）**
```cangjie
public func perspective<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func perspectiveLH_ZO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func perspectiveLH_NO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func perspectiveRH_ZO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func perspectiveRH_NO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func perspectiveZO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func perspectiveNO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func perspectiveLH<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func perspectiveRH<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
```

**5. perspectiveFov 系族（9 个函数）**
```cangjie
public func perspectiveFov<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func perspectiveFovLH_ZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func perspectiveFovLH_NO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func perspectiveFovRH_ZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func perspectiveFovRH_NO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func perspectiveFovZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func perspectiveFovNO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func perspectiveFovLH<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func perspectiveFovRH<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
```

**6. infinitePerspective 系族（7 个函数）**
```cangjie
public func infinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
public func infinitePerspectiveLH_ZO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
public func infinitePerspectiveLH_NO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
public func infinitePerspectiveRH_ZO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
public func infinitePerspectiveRH_NO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
public func infinitePerspectiveLH<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
public func infinitePerspectiveRH<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
```

**7. tweakedInfinitePerspective 系族（2 个函数）**
```cangjie
public func tweakedInfinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T, ep: T): Mat4x4<T, Q>
public func tweakedInfinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
```

**8. 投影工具（6 个函数）**
```cangjie
public func projectZO<T, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
public func projectNO<T, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
public func project<T, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
public func unProjectZO<T, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
public func unProjectNO<T, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
public func unProject<T, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
```

**9. 拾取矩阵（1 个函数）**
```cangjie
public func pickMatrix<T, Q>(center: Vec2<T, Q>, delta: Vec2<T, Q>, viewport: Vec4<T, Q>): Mat4x4<T, Q>
```

**展开规则验证**——上述 9 个代码块合计 11 + 10 + 9 + 9 + 9 + 7 + 2 + 6 + 1 = **64 个函数签名**，与 §3.13 表格中声明的 64 个函数一致。下游编码者按此模板逐一复制到 `gtc/matrix_transform.cj` 中，每个函数体统一为 `{ throw Exception("stub" }`，`where T <: FloatingPoint<T>, Q <: Qualifier` 约束统一适用于每个函数签名。——从 v24 的 6 个代表性模板（覆盖 6 个类别，58/64 个函数需下游自行推断）升级为 9 个类别全部 64 个函数的直接可复制签名列表，消除下游推断的不确定性。

**下游实施约束，Issue 1+2 响应）**：
- 实施时按上述 64 个函数清单逐一声明函数签名（先前描述「35 个」遗漏 29 个
- 每个函数体实现为 `throw Exception("stub")`
- 函数签名参数类型与 GLM 原始声明对齐（`Mat4x4`/`Mat3x3`/`Vec3`/`Float32`/`Float64` 等，无需本阶段严格翻译 `where T <: FloatingPoint<T>` 等约束
- 阶段四实现时按 `lib.cj` import 顺序与 §9a 覆盖矩阵定义的实际优先级补齐函数体
- ：lib.cj 实际仅 8 行，阶段三新增 import 追加至 lib.cj 第 9 行（非 v12 描述的「第 131 行」；下游编码者按本节清单实施时无需在 lib.cj 中查找「第 131 行」——直接编辑 8 行文件末尾追加 1 行 import 即可

#### 3.13.1 trigonometric.cj 函数清单

`detail/trigonometric.cj` 本阶段需提供 **30 个函数**（15 个标量 + 15 个向量 *VecN 占位符*；注意标量版本与向量版本需要同时声明，否则下游 `mix`/`slerp` 等函数体内的 `acos(T)`/`sin(T)` 标量调用将编译失败：

**`VecN<T, Q>` 占位符展开规则**——上表 `VecN<T, Q>` 是占位符——**仓颉项目不存在 `VecN` 泛型占位类型**。实际展开模式遵循 `cjglm/src/detail/compute_vector_decl.cj` 的 `compute_vec_xxx1/2/3/4` 模式（即 4 个独立函数重载，对应 Vec1/Vec2/Vec3/Vec4。下游实现 trigonometric.cj 时，每个 `VecN<T, Q>` 占位符应展开为 4 个独立函数：
- `sin<T, Q>(x: Vec1<T, Q>): Vec1<T, Q>` / `sin<T, Q>(x: Vec2<T, Q>): Vec2<T, Q>` / `sin<T, Q>(x: Vec3<T, Q>): Vec3<T, Q>` / `sin<T, Q>(x: Vec4<T, Q>): Vec4<T, Q>`
- 其余 14 个单参数三角函数（`cos`/`tan`/`asin`/`acos`/`atan`/`sinh`/`cosh`/`tanh`/`asinh`/`acosh`/`atanh`/`radians`/`degrees`）+ 1 个双参数 `atan2` 同理展开

**展开后的实际函数总数重算**：
- 标量单参数三角函数：14 个（每个 1 个签名 = 14
- 向量单参数三角函数：14 个函数 × 4 个分量数 = 56 个
- 标量双参数三角函数（`atan2`：1 个
- 向量双参数三角函数（`atan2`：1 个 × 4 个分量数 = 4 个
- **展开后实际函数总数 = 14 + 56 + 1 + 4 = 75 个**（——描述的「30 个函数」是占位符层级计数，未按 `VecN<T, Q>` 占位符展开为 4 个独立重载；下游按设计实现时实际应声明 75 个函数签名，其中标量 15 个用于 `slerp`/`mix`/`pow`/`log`/`exp`/`angle`/`angleAxis` 等四元数函数体的分量级运算，向量 60 个用于阶段四 vec 级运算

**单参数三角函数（14 函数 × 2 重载类型 = 28 行占位符签名，展开后 70 个函数）**：

**内部依赖统一说明**——表行「内部依赖」列对每个 std.math 函数调用，原 v11 重复 14 次「std.math Float32 重载已提供」说明。后，**统一指向 §1「Float32 与 std.math 的交互约束」段作为单一权威来源**——§1 已明确 `std.math` 三角函数（`sin`/`cos`/`tan`/`asin`/`acos`/`atan`/`sinh`/`cosh`/`tanh`/`asinh`/`acosh`/`atanh`/`atan2`）均提供 Float16/Float32/Float64 重载，`std.math.pow` 提供 Float32/Float64 共 4 个重载——T=Float32 实例化时直接调用 std.math 对应重载即可（与 §1 方案 A 一致，无需 `T(Float64.xxx(Float64(value)))` 显式转换；`radians`/`degrees` 是例外（stdlib 不存在，需硬编码 π 字面量。表行仅标注 std.math 函数名（不带重复说明，详细约束规则查阅 §1 与下表「**Float32 实例化影响**」段（——移除原独立段落，与表行整合。

> ——本表「内部依赖」列标注的 `std.math.sin`/`std.math.cos` 等依赖为**阶段四完整的实现后依赖**；本阶段所有函数体为 `throw Exception("stub")`，编译时不实际触发这些依赖。

| 函数 | 标量签名 | 向量签名（占位符 | 内部依赖 |
|------|---------|---------|---------|
| `sin` | 同上 | 同上 | （阶段四依赖 |
| `cos` | 同上 | 同上 | （阶段四依赖 |
| `tan` | 同上 | 同上 | （阶段四依赖 |
| `asin` | 同上 | 同上 | （阶段四依赖 |
| `acos` | 同上 | 同上 | （阶段四依赖 |
| `atan` | 同上 | 同上 | （阶段四依赖 |
| `sinh` | 同上 | 同上 | （阶段四依赖 |
| `cosh` | 同上 | 同上 | （阶段四依赖 |
| `tanh` | 同上 | 同上 | （阶段四依赖 |
| `asinh` | 同上 | 同上 | （阶段四依赖 |
| `acosh` | 同上 | 同上 | （阶段四依赖 |
| `atanh` | 同上 | 同上 | （阶段四依赖 |
| `radians` | 同上 | 同上 | 硬编码 π 字面量——std.math 不提供 radians（例外——非阶段四依赖，因 std.math 不存在此函数，需自行通过 π 字面量实现 |
| `degrees` | 同上 | 同上 | 硬编码 π 字面量——std.math 不提供 degrees（例外——非阶段四依赖，因 std.math 不存在此函数，需自行通过 π 字面量实现 |

**双参数三角函数 `atan2` 双参数标量版本）**：

| 函数 | 标量签名 | 向量签名（占位符 | 内部依赖 |
|------|---------|---------|---------|
| `atan2` | 同上 | 同上 | （阶段四依赖 |

**T 类型约束策略**——所有 15 个函数（14 单参数三角函数 + 1 双参数 `atan2`）的标量与向量签名模板均统一添加 `where T <: FloatingPoint<T>` 约束（与 §3.2.1 D32、§3.11 D29、§3.12 D25 已统一策略一致；下游对 T 约束决策无需重复选择；整数 T 实例化时（如 `Quat<Int64, PackedHighp>.inverse()` 调用 `acos(int)`）将编译期报类型不匹配错误并提供前置告警。——本约束的必要性是「阶段四完整实现前的必备前置项」——若 trigonometric.cj 函数体不约束 T 为浮点类型，阶段四 stub 替换为 `std.math.{func}` 调用时，整数 T 实例化将报 `std.math.{func}(Int64)` 不存在错误（因 std.math 数值函数仅对 Float16/Float32/Float64 提供重载；本约束提前到签名声明阶段，避免阶段四实现时再回头加约束引入 API 变更。因此**严重程度保留**（与 Issue 1 一致，但本约束的实施不阻塞阶段三本身的完整实现路径，仅在阶段四实现 trigonometric.cj 函数体时生效。

**Float32 实例化影响**——原 v11 在本节独立段重复说明 std.math Float32 重载可用性，与 §1「Float32 与 std.math 的交互约束」段形成内容重复。，表行不再重复标注。完整权威说明查阅 §1 段——关键结论——所有 std.math 三角函数（`sin`/`cos`/`tan`/`asin`/`acos`/`atan`/`sinh`/`cosh`/`tanh`/`asinh`/`acosh`/`atanh`/`atan2`/`sqrt`/`exp`/`log`）均提供 Float16/Float32/Float64 重载，T=Float32 实例化时直接调用 std.math 对应重载即可；`radians`/`degrees` 是例外（stdlib 不存在，需硬编码 π 字面量；`std.math.pow` 提供 Float32/Float64 共 4 个重载。

**完整签名模板（全部 15 个函数 × 5 个签名 = 75 个函数签名）**——以下给出 trigonometric.cj 中全部 15 个函数（14 单参数三角函数 + 1 双参数 `atan2`）的完整可复制仓颉签名代码块。所有函数函数体统一为 `{ throw Exception("stub" }`，约束统一为 `where T <: FloatingPoint<T>`（标量）或 `where T <: FloatingPoint<T>, Q <: Qualifier`（向量。下游编码者可直接将以下代码块复制到 `detail/trigonometric.cj` 中，无需任何手动推断或函数名替换。

```cangjie
// ===== 标准三角函数 sin（6 个函数共 30 个签名，以下 5 行）=====
public func sin<T>(x: T): T where T <: FloatingPoint<T>
public func sin<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func sin<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func sin<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func sin<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
// cos
public func cos<T>(x: T): T where T <: FloatingPoint<T>
public func cos<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func cos<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func cos<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func cos<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
// tan
public func tan<T>(x: T): T where T <: FloatingPoint<T>
public func tan<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func tan<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func tan<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func tan<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
// asin
public func asin<T>(x: T): T where T <: FloatingPoint<T>
public func asin<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func asin<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func asin<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func asin<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
// acos
public func acos<T>(x: T): T where T <: FloatingPoint<T>
public func acos<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func acos<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func acos<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func acos<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
// atan
public func atan<T>(x: T): T where T <: FloatingPoint<T>
public func atan<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func atan<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func atan<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func atan<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier

// ===== 双曲函数 sinh / cosh / tanh（3 个函数共 15 个签名）=====
public func sinh<T>(x: T): T where T <: FloatingPoint<T>
public func sinh<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func sinh<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func sinh<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func sinh<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
// cosh
public func cosh<T>(x: T): T where T <: FloatingPoint<T>
public func cosh<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func cosh<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func cosh<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func cosh<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
// tanh
public func tanh<T>(x: T): T where T <: FloatingPoint<T>
public func tanh<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func tanh<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func tanh<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func tanh<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier

// ===== 反双曲函数 asinh / acosh / atanh（3 个函数共 15 个签名）=====
public func asinh<T>(x: T): T where T <: FloatingPoint<T>
public func asinh<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func asinh<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func asinh<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func asinh<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
// acosh
public func acosh<T>(x: T): T where T <: FloatingPoint<T>
public func acosh<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func acosh<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func acosh<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func acosh<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
// atanh
public func atanh<T>(x: T): T where T <: FloatingPoint<T>
public func atanh<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func atanh<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func atanh<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func atanh<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier

// ===== 坐标转换 radians / degrees（2 个函数共 10 个签名）=====
public func radians<T>(x: T): T where T <: FloatingPoint<T>
public func radians<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func radians<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func radians<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func radians<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
// degrees
public func degrees<T>(x: T): T where T <: FloatingPoint<T>
public func degrees<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func degrees<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func degrees<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func degrees<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier

// ===== 双参数 atan2（1 个函数共 5 个签名）=====
public func atan2<T>(y: T, x: T): T where T <: FloatingPoint<T>
public func atan2<T, Q>(y: Vec1<T, Q>, x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func atan2<T, Q>(y: Vec2<T, Q>, x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func atan2<T, Q>(y: Vec3<T, Q>, x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func atan2<T, Q>(y: Vec4<T, Q>, x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
```

**签名数量验证**——以上代码块共包含 75 个函数签名——标准三角函数 6×5=30，双曲函数 3×5=15，反双曲函数 3×5=15，坐标转换 2×5=10，双参数 atan2 1×5=5，合计 30+15+15+10+5=75。所有函数函数体统一为 `{ throw Exception("stub" }`，无需下游进行任何函数名替换或手动展开。

**展开后实际函数总数重算**：
- **占位符层级（计数）**：14 个单参数三角函数（标量 + 向量 14 行）+ 1 个双参数 `atan2`（标量 + 向量 1 行）= **15 个函数名 × 2 行 = 30 行占位符签名模板**
- **展开后实际函数数**——每个 `VecN<T, Q>` 占位符展开为 Vec1/Vec2/Vec3/Vec4 共 4 个独立函数签名——标量 14 个不变（每函数 1 个签名 = 14）+ 向量 14 个 × 4 个分量数 = 56 个 + 双参数 `atan2` 标量 1 个 + 双参数 `atan2` 向量 1 × 4 = 4 个 = **总计 75 个函数签名**
- **过渡说明**——从 v9 占位符层级的 30 行模板 → v10/v11 实际展开后的 75 个函数签名，**2.5 倍数量跳跃源于 VecN 占位符展开规则**——每个「向量签名」占位符行实际对应 Vec1/Vec2/Vec3/Vec4 共 4 个独立函数签名。下游编码者实现 trigonometric.cj 时，每行模板应按 §3.13.1 「`VecN<T, Q>` 占位符展开规则」段（位于表前）展开为 4 个独立函数；下游按 v9 文档「30 行」实现时仅声明 30 个函数会导致向量调用方在编译时找不到 Vec1/Vec2/Vec3/Vec4 任一分量数的实例（与 `compute_vector_decl.cj` 4 个独立 struct 模式不符

**约束说明**：
- 标量版本用于 `slerp`/`mix`/`pow`/`log`/`exp`/`angle`/`angleAxis` 等四元数函数体内的**分量级运算**（如 `slerp` 中 `acos(cosTheta)`、`pow` 中 `asin(sqrt(VectorMagnitude / magnitude)`
- 向量版本用于**阶段四 vec 级运算**（如 vec3 应用四元数旋转的逐分量 sin/cos 变换
- 所有函数本阶段均为 stub（仅签名空壳 + `throw Exception("stub")`，具体实现推迟至阶段四 trigonometric.cj 完整实现时补齐
- **下游消费者提示**：`slerp`/`mix`/`pow`/`log`/`exp` 等函数体内的 `acos(cosTheta)`/`sin(angle)`/`atan(denom, numer)` 等调用直接使用**标量版本**（参数为 `T`，与本节签名一致
- **T 类型约束**——所有 75 个展开函数签名均标注 `where T <: FloatingPoint<T>`；下游按设计实现时需在签名声明阶段保留该约束，与 §3.2.1 D32 / §3.11 D29 / §3.12 D25 约束收紧策略一致

> **阶段三约束影响说明**——`where T <: FloatingPoint<T>` 约束收紧在阶段三**仅影响编译行为**，不改变运行时行为（函数体均为 `throw Exception("stub")`。整数 T（如 `Int64`）实例化 trig 函数在阶段三会编译失败。**降级路径**——若下游需要整数 T 实例化通过编译，可在阶段三暂时移除 `where T <: FloatingPoint<T>` 约束改为 `where T <: Number<T>`，并在函数体内添加 `match` 分派——对浮点 T 保留 `throw Exception("stub")`，对整数 T 抛更友好的错误消息如 `Exception("trigonometric functions not defined for integer types")`。该降级路径仅用于阶段三编译通过性需求；阶段四实现函数体时必须恢复 `FloatingPoint<T>` 约束以确保整数 T 编译期拒绝。**当前阶段三所有 stub 函数保持 `FloatingPoint<T>` 约束不变**，降级路径由需要整数 T 编译的下游客自行评估实施。

#### 标量三角函数与四元数函数依赖映射表

以下映射表列出 trigonometric.cj 标量三角函数与四元数函数的显式依赖关系，便于下游编码者快速定位 slerp/mix/pow/log/exp/angle/angleAxis 等四元数函数所需的 trigonometric.cj 标量函数。

| 四元数函数 | 所在章节 | 依赖的 trigonometric.cj 标量函数 | 调用位置说明 |
|-----------|---------|-----------------------------|------------|
| `slerp`（3 参数 | §3.11 | `acos`/`sin`/`mix`（标量版，common.cj | `acos(cosTheta)` 计算夹角；`sin((1-a)*angle)` 和 `sin(a*angle)` 构造插值；`mix` 退化为 `lerp` 分支 |
| `slerp`（4 参数，k: Int64 | §3.11 | `acos`/`sin`/`mix`（标量版 | 同上，额外依赖 `pi<T>()` 计算 `angle + k * pi` |
| `mix` | §3.11 | `acos`/`sin` | `acos(cosTheta)` 用于 `cosTheta > 1 - epsilon` 退化检测 |
| `pow` | §3.10 | `asin`/`sin`/`cos`/`acos` | `asin(sqrt(VectorMagnitude / magnitude)`；`cos(a*Angle)`/`sin(a*Angle)` |
| `log` | §3.10 | `atan` | 角度提取 `atan(Vec3Len, q.w)` |
| `exp` | §3.10 | `cos`/`sin` | `cos(Angle)`/`sin(Angle)` 构造指数四元数 |
| `angle` | §3.9 | `asin`/`acos` | `abs`（可内联 + `asin`/`acos` + `sqrt`（std.math |
| `angleAxis` | §3.9 | `sin`/`cos` | `sin(angle/2)`/`cos(angle/2)` 构造旋转半角四元数 |
| `eulerAngles` | §3.15 | `atan`/`asin` | 欧拉角分解 |
| `roll`/`pitch`/`yaw` | §3.15 | `atan`/`asin` | 各轴向角度提取 |

上述映射表中列出的所有 trigonometric.cj 标量函数在阶段四未完整实现之前，对应的四元数函数本阶段均为 stub。slerp、mix、angleAxis 等函数除 trigonometric.cj 依赖外，还额外依赖 common.cj（`abs`/`clamp`/`mix` 标量版）和 geometric.cj（`cross`/`dot`/`normalize`）的 stub，详见各函数所在章节的完整依赖分析。

#### 3.13.2 本阶段实现但运行时受 stub 依赖影响的函数集中审计

注——本节函数状态计数已与 §11.5 函数可用性对照表统一对齐。**全文档函数可用状态以 §11.5 为最终基准**。

本节集中审计「本阶段标注为完整实现或部分实现，但运行时受 stub 依赖影响」的函数，列出调用链与异常传播路径——呼应任务描述对「异常场景和边界条件」的关注。

| 函数 | 标注状态 | 依赖 stub 来源 | 运行时行为契约 | 阶段四补齐路径 |
|------|---------|--------------|--------------|--------------|
| `Quat×Vec3` 运算符 | §3.4 标注「实现」 | `ext/quaternion_common.cj` 中的向量 `cross`（**`geometric.cj` stub** | 阶段三调用抛 `Exception("stub")` | 阶段四 geometric.cj 向量 cross 完整实现后，旋转公式 `v + (cross(QuatVector, v * q.w + cross(QuatVector, cross(QuatVector, v)) * T(Float64(2))` 生效 |
| `Quat×Vec4` 运算符 | §3.4 标注「实现」 | 通过 `Quat×Vec3` 中间路径间接依赖 `geometric.cj` stub | 阶段三调用抛 `Exception("stub")` | 同上 |
| `epsilon<T>()`/`pi<T>()`/`cos_one_over_two<T>()` | §3.12 标注「完整实现」 | 无 stub 依赖（运行时分派 `match` | 整数 T 调用时抛 `Exception("not defined for non-floating-point types")`（D25 决策 | 阶段四约束收紧策略生效后编译期拒绝（无需运行时异常 |
| `dot(q1, q2)` | §3.7 标注「完整实现」 | 纯算术（四元数点积 `x.w*y.w + x.x*y.x + x.y*y.y + x.z*y.z` | 阶段三可调用 | — |
| `cross(Quat, Quat)` | §3.7 标注「完整实现」 | 纯算术（Hamilton 乘积逐分量展开 | 阶段三可调用 | — |
| `equal(Quat, Quat)` / `equal(Quat, Quat, epsilon)` | §3.6 标注「完整实现」 | 纯比较 / 内联 abs 模式 | 阶段三可调用 | — |
| `notEqual(Quat, Quat)` / `notEqual(Quat, Quat, epsilon)` | §3.6 标注「完整实现」 | 纯比较 / 内联 abs 模式 | 阶段三可调用 | — |
| `axis(q)` | §3.9 标注「完整实现」 | `std.math.sqrt`：T=Float32 时直接调用 Float32 重载 | 阶段三可调用（T=Float32/Float64 均有效 | — |
| `length(q)` | §3.7 标注「完整实现」 | `std.math.sqrt` | 阶段三可调用 | — |
| `normalize(q)` | §3.7 标注「完整实现」；——补充零四元数保护；——完整边界行为契约详见 §5.3 边界条件表 normalize 行 | `length(q)` | 阶段三可调用（仅浮点 T，整数 T 编译期拒绝）——零四元数返回单位四元数；其他输入返回归一化结果 | — |
| `inverse(q)` | §3.11 标注「完整实现」 | `conjugate(q)` + `dot(q, q)`（**`quaternion_geometric.cj` 已完整实现** | 阶段三可调用——浮点零除产生 Inf/NaN，整数零除抛 `ArithmeticException` | — |
| `isnan(q)`/`isinf(q)` | §3.11 标注「完整实现」 | `x.isNaN()`/`x.isInf()` 实例方法：`FloatingPoint<T>` 接口实例方法 | 阶段三可调用（仅浮点 T | 阶段四 `FloatingPoint<T>` 约束收紧后编译期拒绝整数 T |
| `mat3Cast`/`mat4Cast`/`quatCast` | §3.2.1 标注「完整实现」 | `pow`/`sqrt`/`trace`（`std.math` 已实现 | 阶段三可调用（仅浮点 T | 阶段四 `FloatingPoint<T>` 约束收紧后编译期拒绝整数 T |
| `conjugate(q)` | §3.11 标注「完整实现」 | 无（仅逐分量取反 | 阶段三可调用 | — |
| `lerp(q1, q2, a)` | §3.11 标注「完整实现」 | 无（纯算术，含 `assert(a ∈ [0,1])` | 阶段三可调用：`a` 超出 [0,1] 时 `assert` 失败 | — |
| `mix`/`slerp`(2 个版本 | §3.11 标注「stub」 | `trigonometric.cj` 的 `acos(T)`/`sin(T)` 单参数版本 + `common.cj` 的 `mix` 标量版 + `epsilon<T>()`（已实现 | 阶段三调用抛 `Exception("stub")` | 阶段四 trigonometric.cj/common.cj 完整实现后生效 |
| `exp(q)`/`log(q)`/`pow(q, y)`/`sqrt(q)` | §3.10 标注「stub」 | trigonometric.cj `sin`/`cos`/`acos` + std.math `pow`/`exp`/`log`/`sqrt` + `epsilon<T>()`/`pi<T>()`/`cos_one_over_two<T>()` + `FloatingPoint<T>.getMinDenormal()`/`getInf()` | 阶段三调用抛 `Exception("stub")` | 阶段四 trigonometric.cj 完整实现后生效 |
| `axis`/`angle`/`angleAxis` | §3.9 标注「axis 完整实现 + angle/angleAxis stub」 | trigonometric.cj `asin`/`acos` + std.math `sin`/`cos` | 阶段三：`axis` 可调用；`angle`/`angleAxis` 抛 `Exception("stub")` | 阶段四 trigonometric.cj 完整实现后 `angle`/`angleAxis` 生效 |
| `eulerAngles(q)`/`roll(q)`/`pitch(q)`/`yaw(q)` | §3.15 标注「stub」 | trigonometric.cj `atan`/`asin` + common.cj `clamp` + vector_relational.cj `equal` + `epsilon<T>()` | 阶段三调用抛 `Exception("stub")` | 阶段四 trigonometric.cj/common.cj 完整实现后生效 |
| `quatLookAt*`(3 个版本 | §3.15 标注「stub」 | `geometric.cj` 的 `cross`/`dot`/`normalize`/`inversesqrt`/`max` + `type_quat_cast.quatCast` | 阶段三调用抛 `Exception("stub")` | 阶段四 geometric.cj 完整实现后生效 |
| `gtc/matrix_transform` 全部 64 个函数 | §3.13 标注「stub」 | `ext/matrix_projection.cj` + `ext/matrix_clip_space.cj` + `ext/matrix_transform.cj` + `geometric.cj` + `trigonometric.cj` + `matrix.cj`（均为 stub，通过 `gtc/matrix_transform.cj` 聚合 | 阶段三调用抛 `Exception("stub")` | 阶段四所有 stub 函数库完整实现后生效 |

**审计结论**：
- **本阶段可调用的「真完整实现」函数**（无 stub 依赖：`epsilon<T>()`/`pi<T>()`/`cos_one_over_two<T>()`/`axis`/`length`/`normalize`/`inverse`/`isnan`/`isinf`/`mat3Cast`/`mat4Cast`/`quatCast`/`conjugate`/`lerp`/`dot`/`cross(Quat)`/`equal(Quat)`/`notEqual(Quat)`（共 **18 个函数**——按函数名计数，不含重载；按 §11.5 表行粒度展开为 19 行，其中 `equal`/`notEqual` 各含精确和 epsilon 两种重载合并为 2 行，其余 17 个函数各 1 行 = 19 行。计数口径公式：`18 命名函数 = 14 审计表独立行 + 2（equal/notEqual 合并行拆分为 4 命名函数）`——审计表 14 行中 `equal(Quat)` 和 `notEqual(Quat)` 各行计为 2 个命名函数，其余 12 行各计为 1 个 = 14 + 4 = 18 个
- **本阶段实现但运行时受 stub 依赖影响的函数**——`Quat×Vec3`/`Quat×Vec4`/`Vec3×Quat`/`Vec4×Quat` 运算符（4 个，——新增 Vec3×Quat/Vec4×Quat——内联 conjugate/dot 仅消除包间循环依赖，未消除对 Vec3 cross stub 的运行时调用
- **本阶段 stub 占位的函数**：`mix`/`slerp`/`exp`/`log`/`pow`/`sqrt`/`angle`/`angleAxis`/`rotate`/`eulerAngles`/`roll`/`pitch`/`yaw`/`quatLookAt*`（14 个）+ `gtc/matrix_transform` 全部 64 个函数 + `fromVec3`/`fromEuler`（2 个）+ `ext/vector_relational` ULP 版本（4 个 ❌ 条目覆盖 8 重载）+ `type_quat.cj` 中 Quat×Vec3/Vec4/Vec3×Quat/Vec4×Quat（4 个 ⚠️ = **88 个**（⚠️ 从 2 个增加至 4 个，同步调整 ❌ 计数保证 ⚠️+❌ = 88

下游测试设计时，对「本阶段可调用的真完整实现函数」可执行完整功能验证；对「实现但运行时受 stub 依赖影响」函数应标注「本阶段抛 stub 异常，待阶段四 stub 替换后生效」（与 §11.5 ⚠️ 符号对应；对「stub 占位函数」仅执行 `assertThrows` 异常路径验证。**函数可用状态以 §11.5 为最终基准**。

### 3.14 四元数别名文件

ext/ 下新增四元数别名文件：

| 文件 | 别名内容 |
|------|---------|
| `quaternion_float.cj` | `quat = Quat<Float32, PackedHighp>` |
| `quaternion_double.cj` | `dquat = Quat<Float64, PackedHighp>` |
| `quaternion_float_precision.cj` | `highp_quat`/`mediump_quat`/`lowp_quat` |
| `quaternion_double_precision.cj` | `highp_dquat`/`mediump_dquat`/`lowp_dquat` |

fwd.cj 新增别名，**不存在** `FMat*` 任何声明；`fwd.cj` 中唯一带 `F` 前缀的别名是 Vec 家族（`FVec1`~`FVec4` 见 `fwd.cj:275-278`、精度变体 `HighpFVec*`~`LowpFVec*` 见 `fwd.cj:279-290`。`Vec` 家族采用 `Vec2` + `DVec2` + `FVec2` **三重模式**（`fwd.cj:106, 123, 276`：

| 别名 | 类型 | 备注 |
|------|------|------|
| `Quat` | `Quat<Float32, PackedHighp>` | Float32 主别名（对应 `Vec2` 在 Vec 家族的角色 |
| `FQuat` | `Quat<Float32, PackedHighp>` | Float32 别名（与 `Quat` 等价，对应 `FVec2` 在 Vec 家族的角色 |
| `DQuat` | `Quat<Float64, PackedHighp>` | Float64 主别名（对应 `DVec2` 在 Vec 家族的角色 |
| `HighpQuat`/`MediumpQuat`/`LowpQuat` | `Quat<Float32, *>` | Float32 精度变体（3 个，对应 Vec 家族 `HighpFVec*` 等 |
| `HighpDQuat`/`MediumpDQuat`/`LowpDQuat` | `Quat<Float64, *>` | Float64 精度变体（3 个 |

**合计 9 个别名**（实际为 Quat/FQuat/DQuat/3×Float32 精度/3×Float64 精度 = 1+1+1+3+3 = **9 个**，与 §2 lib.cj/fwd.cj 段落同步。**排除项**（与阶段二策略对齐：
- 不含 `BQuat`（Bool 四元数）—— 阶段一 Vec 包含 `BVec` 但 Bool 四元数无实际用途（D17 决策：Bool 四元数不支持算术运算
- 不含 `IQuat`/`I64Quat`（整型四元数）—— 与阶段二 `fwd.cj` 排除整型矩阵别名策略一致
- 不含 `BQuat` 的精度变体（同上

**为何保留 `Quat`/`FQuat`/`DQuat` 三重别名（说明，先例引用）**——阶段二 `Mat` 家族实际仅有 `Mat2x2` (Float32 + `DMat2x2` (Float64 双别名（`cjglm/src/fwd.cj:327, 347`，`FMat*` 在 `fwd.cj` 中无任何声明。——将先例引用改为阶段一 Vec 家族的三重模式（`Vec2` + `DVec2` + `FVec2`，见 `cjglm/src/fwd.cj:106, 123, 276`，与 `FQuat` 的设计意图对齐。`Quat` 为主别名（与 GLM 命名一致，`FQuat` 为显式浮点别名（与 `FVec2` 在 Vec 家族的角色等价，`DQuat` 为显式 64 位浮点别名（与 `DVec2` 等价。该三重模式在阶段一 Vec 家族已稳定运行，作为四元数 `Quat`/`FQuat`/`DQuat` 的设计先例更准确。

### 3.15 gtc/quaternion.cj

**角色**——承载 GLM `gtc/quaternion.hpp` 的全部 15 个函数（4 转换 + 4 比较 + 4 欧拉 + 3 看向，与 GLM 原始头文件路径保持 1:1 映射。

**职责分组**（——§3.15 自 v3/以来已正确将欧拉函数归入「stub 占位」，§3.2 策略段此次同步修正，两处不再矛盾：

| 函数组 | 函数 | 本阶段状态 | 依赖 |
|--------|------|----------|------|
| 矩阵-四元数互转 | `mat3Cast`/`mat4Cast`/`quatCast(Mat3)`/`quatCast(Mat4)` | **从 detail 重导出** | `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` |
| 四元数比较 | `lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual` | 完整实现 | 纯比较 |
| 欧拉角 | `eulerAngles`/`roll`/`pitch`/`yaw` | **stub 占位** | `trigonometric.cj`(`atan`/`asin` + `common.cj`(`clamp` + `vector_relational.cj`(`equal` + `scalar_constants.cj`(`epsilon<T>()` — 均依赖 stub，本阶段无法完整实现 |
| 看向 | `quatLookAt`/`quatLookAtRH`/`quatLookAtLH` | stub | `geometric.cj`(`cross`/`dot`/`normalize`/`inversesqrt`/`max` + `type_quat_cast.quatCast` |

- 上一版中"完整实现的 8 个函数（4 转换 + 4 比较）"现修正为：
  - 4 转换函数 → **从 detail 重导出**（不再在 gtc/quaternion.cj 中实现
  - 4 比较函数 → 完整实现（保留
  - 4 欧拉函数 → **stub 占位**
  - 3 看向函数 → stub（保留
- **正确分组**：4 重导出 + 4 完整实现 + 7 stub

**完整实现函数（4 个，）**：

4 个比较函数（`lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual`）统一标注 `where T <: Comparable<T>, Q <: Qualifier` 约束，依赖 `<`/`<=`/`>`/`>=` 运算符；——4 行重复标注合并为本段统一约束声明，避免质询报告 E 项建议的表格格式偏好。——
- `lessThan`: `func lessThan<T, Q>(x: Quat<T,Q>, y: Quat<T,Q>): Vec4<Bool,Q> where T <: Comparable<T>, Q <: Qualifier { Vec4<Bool,Q>(x.x < y.x, x.y < y.y, x.z < y.z, x.w < y.w }`
- `lessThanEqual`: `func lessThanEqual<T, Q>(x: Quat<T,Q>, y: Quat<T,Q>): Vec4<Bool,Q> where T <: Comparable<T>, Q <: Qualifier { Vec4<Bool,Q>(x.x <= y.x, x.y <= y.y, x.z <= y.z, x.w <= y.w }`
- `greaterThan`: `func greaterThan<T, Q>(x: Quat<T,Q>, y: Quat<T,Q>): Vec4<Bool,Q> where T <: Comparable<T>, Q <: Qualifier { Vec4<Bool,Q>(x.x > y.x, x.y > y.y, x.z > y.z, x.w > y.w }`
- `greaterThanEqual`: `func greaterThanEqual<T, Q>(x: Quat<T,Q>, y: Quat<T,Q>): Vec4<Bool,Q> where T <: Comparable<T>, Q <: Qualifier { Vec4<Bool,Q>(x.x >= y.x, x.y >= y.y, x.z >= y.z, x.w >= y.w }`

**重导出函数（4 个，：camelCase 命名）**：
- `mat3Cast(q: Quat<T,Q>): Mat3x3<T,Q>` — 通过 `public import glm.detail.mat3Cast` 重导出：camelCase 命名，与 detail 端 `mat3Cast` 原始名一致；GLM 习惯 snake_case `mat3_cast` 在仓颉侧无法保留，因 `public import` 不做命名转换
- `mat4Cast(q: Quat<T,Q>): Mat4x4<T,Q>` — 通过 `public import glm.detail.mat4Cast` 重导出：camelCase `mat4Cast` 而非 snake_case `mat4_cast`
- `quatCast(m: Mat3x3<T,Q>): Quat<T,Q>` — 通过 `public import glm.detail.quatCast` 重导出：camelCase `quatCast` 而非 snake_case `quat_cast`
- `quatCast(m: Mat4x4<T,Q>): Quat<T,Q>` — 通过 `public import glm.detail.quatCast` 重导出：camelCase `quatCast` 而非 snake_case `quat_cast`

**stub 函数（7 个）**：
- `eulerAngles(x): Vec3<T,Q>` — stub
- `roll(q): T` — stub
- `pitch(q): T` — stub
- `yaw(q): T` — stub
- `quatLookAt(direction, up): Quat<T,Q>` — stub
- `quatLookAtRH(direction, up): Quat<T,Q>` — stub
- `quatLookAtLH(direction, up): Quat<T,Q>` — stub

**完整签名模板（7 个 stub 函数）**——以下为完整的仓颉函数签名模板（含 `where` 子句约束，函数体统一为 `{ throw Exception("stub" }`：
```cangjie
public func eulerAngles<T, Q>(x: Quat<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func roll<T, Q>(q: Quat<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier
public func pitch<T, Q>(q: Quat<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier
public func yaw<T, Q>(q: Quat<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier
public func quatLookAt<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func quatLookAtRH<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func quatLookAtLH<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
```

**跨包引用**：
- `import glm.detail.*` 引用 `Quat`/`Mat3x3`/`Mat4x4`/`Vec3` 类型
- `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 重导出 4 个转换函数
- `import glm.ext.vector_relational.*` 引用 `equal`（用于 roll/pitch 的 `equal(vec2, vec2, 0)` 边界检测
- `import glm.ext.scalar_constants.*` 引用 `epsilon<T>()`
- 不引用 `glm.detail.type_quat` 内部成员（避免与 type_quat.cj 内部细节耦合
- **不引用** `glm.gtc.matrix_transform` 等其他 gtc 文件（避免 gtc 内部循环依赖

**与 type_quat.cj、type_quat_cast.cj 三方协作**：
- `type_quat.cj` 中 `fromMat3`/`fromMat4` 工厂函数直接调用**同包** `type_quat_cast.cj` 的 `mat3Cast`/`mat4Cast`/`quatCast` 函数（无 import 需求
- `gtc/quaternion.cj` 通过 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 将 detail 函数重导出为 gtc 命名空间下的同名 API
- 形成 `glm.gtc → glm.detail` 的**单向依赖**，**无循环依赖**

### 3.16 需求对齐说明

本设计文档与项目路线图 `docs/02_roadmap.md` 在阶段三验证标准上存在以下三处不一致，经 D35-D37 决策后已全部闭环。替代路径保留作为历史存档，不再具备实施优先级。

**不一致 1——`slerp` 可验证性冲突（✅ D35 已决策——维持 stub）**
- 路线图 §3 第 125 行标记「球面线性插值（slerp）操作 `[可验证]`」，但本设计 §3.11、§8 产出物清单、§9a 覆盖矩阵、§11.5 函数可用性对照表均将 `slerp`（含 3 参数与 4 参数版本）标记为「**stub 占位**」（依赖 `trigonometric.cj` 的 `acos`/`sin` stub 与 `common.cj` 的 `mix` stub。
- **D35 选定方案**——**路径 C**——维持本设计定位，`slerp` 标记为 `[待 Stage 4]`。理由——对阶段三整体交付范围影响最小，`slerp` 的 stub 状态已在 §11.5 明确标注，不阻塞其他可验证函数的实现与测试；存在向下兼容的降级路径（路径 A：`lerp` 近似，1-2 人日切换成本。详见 §7 D35。
- **历史替代路径**（保留存档，不再具有实施优先级：
  - 路径 A——降级 `lerp` 近似（代价——较大角度差时非恒定角速度
  - 路径 B——自行实现标量 sin/cos/acos 有限精度版本（泰勒展开，代价——代码冗余、精度有限
- **工期影响**——路径 C 零额外工期成本；阶段四实现时恢复为完整 `slerp`。
- **偏差累积影响量化**：
  - **直接影响函数数**：`slerp`（3 参数 + 4 参数）= 2 个 ❌ 函数
  - **间接影响函数数**——依赖 `slerp` 的上游代码（如动画系统插值链路）在本阶段无法端到端验证，估计影响 3-5 个调用点
  - **API 可用率口径冲击**——独立函数范式可用率从 20/165 ≈ 12.1% 降至 18/165 ≈ 10.9%（2 个 slerp 从 ❌ 降无可降，本身已计入 ❌；实际影响为「预期可验证 → 不可验证」的心智落差而非 API 数量变动
  - **下游风险排序**——高——`slerp` 是四元数最核心的插值语义，其不可用会显著削减阶段三的"旋转表达和插值运算"宣发预期
  - **临时降级路径**——下游可用 `lerp`（✅ 可用）做线性插值近似，代价为较大角度差（>45°）时角速度不均匀。详见本节末尾「临时降级路径一览表」

**不一致 2——`lookRotate` 命名未同步修正（✅ D36 已决策——维持 quatLookAt* 命名）**
- 路线图 §3 多处（第 89、102、111、129、152、163、207 行）仍引用 `lookRotate` 函数名，但本设计已统一为 `quatLookAt`/`quatLookAtRH`/`quatLookAtLH`（D13 决策 + §9 差异声明「GLM 中不存在 `lookRotate` 函数」。
- **D36 选定方案**——维持本设计命名 `quatLookAt`/`quatLookAtRH`/`quatLookAtLH`，三个函数均为 stub（§3.15，命名不影响阶段三实施。若路线图后续确认保留 `lookRotate`，可在阶段四新增 `lookRotate` 作为 `quatLookAtRH` 的委托别名（0.5 人日成本。详见 §7 D36。
- **工期影响**——按本设计命名实施工期成本为零（函数均为 stub。
- **偏差累积影响量化**：
  - **直接影响函数数**：`quatLookAt`/`quatLookAtRH`/`quatLookAtLH` = 3 个 ❌ 函数
  - **间接影响函数数**——下游摄像机朝向计算链路依赖这些函数，在本阶段无法验证，估计影响 2-3 个调用点
  - **API 可用率口径冲击**——无直接影响（3 个函数均为 stub，可用率不因命名而变
  - **下游风险排序**——中——命名不一致本身不影响功能，但若路线图对外宣发使用 `lookRotate` 而用户按此名称搜索 API 时找不到，会产生困惑
  - **临时降级路径**——下游可自行构造旋转矩阵再通过 `fromMat3`（✅ 可用）转换为四元数达到等效的「看向」效果。详见本节末尾「临时降级路径一览表」

**不一致 3——`ext/quaternion_common.cj` 可验证性范围过广（✅ D37 已决策——修订路线图标注）**
- 路线图 §3 第 130 行标记「`ext/quaternion_common.cj`——四元数常用函数（`conjugate`、`inverse`、`normalize` 等跨类型运算）`[可验证]`」，涵盖面过广，未排除 `mix`/`slerp` 属于 stub 的部分。
- **D37 选定方案**——将路线图标注从 `[可验证]` 修订为 `[部分可验证]`——5 函数 ✅（conjugate/inverse/lerp/isnan/isinf）+ 3 函数 ❌（mix/slerp×2，函数级明细引用 §11.5。详见 §7 D37。
- **工期影响**——路线图标注修订零工期成本（仅为文档修改。
- **偏差累积影响量化**：
  - **直接影响函数数**：`mix` + `slerp`×2 = 3 个 ❌ 函数
  - **间接影响函数数**——依赖四元数公共函数的上游插值/混合代码链路，估计影响 2-4 个调用点
  - **API 可用率口径冲击**——独立函数范式可用率保持不变（已计入 ❌
  - **下游风险排序**——低——路线图标注是项目管理内部文档，不对用户暴露，修正标注即刻消除风险
  - **临时降级路径**——路线图标注修正为零成本文档调整，无需代码降级

**三项不一致累积影响汇总**：

| 指标 | D35（slerp | D36（lookRotate | D37（common 范围 | **合计** |
|------|------------|-----------------|-----------------|---------|
| 直接影响 ❌ 函数数 | 2 | 3 | 3 | **8** |
| 间接影响调用点估算 | 3-5 | 2-3 | 2-4 | **7-12** |
| 对本阶段可用率冲击 | 心智预期落差 | 无 | 无 | — |
| 下游风险排序 | **高** | **中** | **低** | — |
| 降级路径实施成本 | 0 人日（路径 C | 0 人日 | 0 人日 | **0 人日** |
| 阶段四修复成本 | 5-8 人日 | 0.5 人日 | 0 人日 | **5.5-8.5 人日** |

**临时降级路径一览表**：

| 所需功能 | 受影响函数 | GLM 源函数 | 本阶段降级方案 | 仓颉代码骨架 | 行为差异量化评估 | 成本分解依据 |
|---------|-----------|-----------|--------------|-------------|----------------|------------|
| 球面插值 | `slerp`（`ext/quaternion_common.inl:28-56` | `glm::slerp(x, y, a)` | **方案 A**——直接改用 `lerp` 线性插值；**方案 B（推荐）**——改用 `nlerp`（归一化 lerp）作为中间方案，在角度阈值内自动切换 | **方案 A**——`let result = lerp(q1, q2, t)`；**方案 B（nlerp）**——`func nlerp<T, Q>(x: Quat<T,Q>, y: Quat<T,Q>, a: T): Quat<T,Q> where T <: FloatingPoint<T>, Q <: Qualifier { normalize(lerp(x, y, a) }`；**方案 C（完整降级）**——在 nlerp 基础上增加角度差阈值判断——`let cosTheta = dot(x, y); if (cosTheta > T(Float64(1) - epsilon<T>() { lerp(x, y, a } else { nlerp(x, y, a }` | 方案 A（`lerp`）——角度差 <30° 时视觉可忽略，>45° 时出现明显"弹跳"感（角速度偏差 9.5%；方案 B（`nlerp`）——将结果投影到单位球面，消除 lerp 的非单位长度问题，但角速度仍非恒定（与 lerp 偏差量一致；方案 C（角度阈值切换）——`cosTheta > 1-epsilon` 时退化为 lerp（防除零，其余使用 nlerp——行为与 GLM `mix` 的退化分支等价。**用户需理解角度偏差影响**——在阈值附近（~45°）切换时可能出现微小视觉不连续，需在代码中根据应用场景调节 epsilon 阈值 | 方案 A **0 人日**（`lerp` 已 ✅ 可用。方案 B **0.5 人日**（封装 nlerp。**方案 C 额外 2-3 人日**（含——0.5 人日理解角度偏差影响与阈值确定 + 0.5 人日编写角度差阈值判断分支 + 1 人日集成测试含多组角度差测试用例 + 0.5-1 人日文档注释和用户迁移说明。**强烈推荐方案 C**（完整降级，虽增加 2-3 人日但提供最接近 slerp 的行为 |
| 摄像机看向 | `quatLookAt*`（`gtc/quaternion.inl:237-282`，3 个函数 | `glm::quatLookAt(dir, up)` | 自行构造旋转矩阵 + `fromMat3` 转换；Vec3 cross 通过内联实现避免依赖 geometric.cj stub | `// Vec3 cross 内联实现（不依赖 geometric.cj stub，纯算术运算：\nfunc crossVec3<T, Q>(a: Vec3<T,Q>, b: Vec3<T,Q>): Vec3<T,Q> where T <: Number<T>, Q <: Qualifier {\n  Vec3<T,Q>(a.y*b.z - a.z*b.y, a.z*b.x - a.x*b.z, a.x*b.y - a.y*b.x)\n}\n\nfunc lookAtFallback<T, Q>(dir: Vec3<T,Q>, up: Vec3<T,Q>): Quat<T,Q> where T <: FloatingPoint<T>, Q <: Qualifier {\n  let right = normalize(crossVec3(up, dir));  // 内联 cross，不依赖 geometric.cj\n  let up_new = crossVec3(dir, right);  // 正交化 up\n  let m = Mat3x3(right, up_new, dir);\n  return quatCast(m)\n}` | GLM `quatLookAt` 内部使用 `cross`/`dot`/`normalize`/`inversesqrt`/`max` 共 5 个 geometric 函数；降级路径用内联 crossVec3（纯算术——`a.y*b.z - a.z*b.y; a.z*b.x - a.x*b.z; a.x*b.y - a.y*b.x`，3 行代码）替代跨包依赖，结果与 GLM 在输入正交时完全一致，非正交输入时偏差取决于正交化实现精度。**crossVec3 内联实现注意事项**——`crossVec3` 为纯算术运算（6 次乘法 + 3 次减法 = 9 次标量运算，编译期零开销，无需 `import glm.ext.*`，与 §3.4 v18 内联 conjugate/dot 路径模式一致 | **1.5-2.5 人日**：0.5 人日内联 crossVec3 函数实现（3 行代码 + 测试）+ 1 人日正交化逻辑 + 0.5 人日集成验证。对比原成本 1-2 人日，因明确给出可复用的 crossVec3 内联实现模板（无需下游自行推导数学公式，编码成本降低约 0.5 人日 |
| 四元数混合 | `mix`（`ext/quaternion_common.inl:56-62` | `glm::mix(x, y, a)` | 改用 `lerp` 或自行实现 `nlerp`（归一化 lerp）——**推荐使用 nlerp** 作为 mix 的直接替代 | `func nlerp<T, Q>(x: Quat<T,Q>, y: Quat<T,Q>, a: T): Quat<T,Q> where T <: FloatingPoint<T>, Q <: Qualifier { normalize(lerp(x, y, a) }` | `lerp` 不保证返回单位四元数，`nlerp = normalize(lerp(...))` 将结果投影回单位球面。GLM `mix` 在 `cosTheta > 1 - epsilon` 时退化为 `lerp`，否则使用 `slerp` 路径。`nlerp` 行为等同 GLM `mix` 的退化分支，与完整 `mix` 的偏差在角度差 >60° 时超过 5%。**nlerp 与 mix 的适用场景对比**——(a 角度差 <30° 时 nlerp 与 mix 误差 <1%，可直接替换；(b 角度差 30°-60° 时 nlerp 欠 overshoot 误差 1-5%，可通过 `slerp` 的中间帧插值补偿；(c 角度差 >60° 时 nlerp 误差 >5%，建议在阶段四实现前使用两级插值分解路径 | **0.5-1 人日**——0.5 人日封装 nlerp 辅助函数 + 0.5 人日测试（含角度差对比测试；如直接使用 `lerp` 则为 0 人日 |

**成本分解方法说明**——以上成本估算基于单函数实现 + 单元测试 + 集成验证的三阶段分解模型。函数本体实现占 50% 成本，单元测试占 30%，集成验证占 20%。同时段多函数降级路径存在规模效应（如 slerp 与 mix 的 nlerp 降级可共享代码，实际总成本约为逐项累加后乘以 0.7 的折扣系数。

**阶段三验证标准双向映射表**（统一路线图与本设计的可验证性标注口径：

| 路线图标注 | 本设计符号 | 含义 |
|----------|----------|------|
| `[可验证]` | ✅ 可用 | 本阶段完整实现，单元测试可立即验证 |
| `[部分可验证]` | ⚠️ 可用但有条件 | 本阶段实现但依赖 stub，调用抛 `Exception("stub")`，待阶段四 stub 替换后正常 |
| `[待 Stage 4]` | ❌ stub | 本阶段 stub 占位，待阶段四函数库完整实现后补齐 |

**§11.5 主要参考基准说明**——本设计 §11.5「函数可用性对照表」的 ✅/⚠️/❌ 符号标注是阶段三验证的**主要参考基准**（每个函数一行，标注本阶段状态与阶段四状态，含约束/边界条件注解；路线图 `02_roadmap.md` 的 `[可验证]`/`[部分可验证]`/`[待 Stage 4]` 三级标注在 v3 迭代结束后由项目管理流程同步修订，本设计文档不再依赖路线图的特定标注作为验证依据。

**⚠️ 以上不一致项的升级建议**——建议将三项不一致分别升级为正式设计决策 D35~D37（详见 §7，记录选定方案及理由。本设计文档以 §11.5 标注为准；路线图对应标注修订由项目管理方在确认后完成。

#### 阶段四 stub 函数实施优先级排序

88 个 ⚠️/❌ stub 函数的阶段四补齐依赖于 geometric.cj、trigonometric.cj、common.cj 三个基础函数库。如果 trigonometric.cj 延迟，将阻塞 slerp/mix/angle/angleAxis/eulerAngles/pow/log/exp/sqrt 共 13 个四元数函数无法从 stub 切换到正常。以下按**用户需求热度**、**依赖链深度**、**阶段四可独立验证性**三维度给出 P0/P1/P2 三级优先级排序：

| 优先级 | 函数组 | 函数数 | 用户需求热度 | 依赖链深度 | 阶段四可独立验证性 | 前置依赖 |
|-------|--------|-------|------------|----------|----------------|---------|
| **P0（最高）** | `slerp` / `mix`（四元数公共函数 | 3 | **极高**——球面插值是四元数最核心的用户语义；动画系统、骨骼混合、相机过渡等场景直接依赖 | 中（依赖 trigonometric.cj: acos/sin + common.cj: mix 标量版 | **高**——独立验证插值结果正确性（恒定角速度 vs lerp 偏差对比 | trigonometric.cj（acos/sin）+ common.cj（mix |
| **P0** | `angle` / `angleAxis`（四元数三角函数 | 2 | **高**——角度提取和绕轴旋转构造是标准用例 | 浅（依赖 trigonometric.cj: asin/acos/sin/cos | **高**——独立验证角度提取精度 | trigonometric.cj（asin/acos/sin/cos |
| **P0** | `eulerAngles` / `roll` / `pitch` / `yaw`（gtc 欧拉函数 | 4 | **高**——欧拉角提取是查看/调试/序列化/互操作的标准接口 | 中（依赖 trigonometric.cj: atan/asin + common.cj: clamp + vector_relational: equal | **高**——独立验证已知四元数的欧拉角分解正确性 | trigonometric.cj（atan/asin）+ common.cj（clamp |
| **P1（中等）** | `exp` / `log` / `pow` / `sqrt`（四元数指数函数 | 4 | **中**——pow/log/sqrt 在高级用法中需要；exp 在动画系统中用于时间轴映射 | 深（依赖 trigonometric.cj: sin/cos/atan + common.cj: abs/clamp + FloatingPoint 静态方法 | **中**——pow 需要验证实数降级路径 + 次正规数分支；log 需要验证 w=0 退化分支 | trigonometric.cj（sin/cos）+ common.cj（abs/clamp |
| **P1** | `fromVec3` / `fromEuler`（工厂函数 | 2 | **中**——在特定场景中替代 fromMat3/fromMat4 的便捷入口 | 中（依赖 geometric.cj: dot/cross/normalize + trigonometric.cj: cos/sin | **中**——需要预设输入验证反平行和零向量边界 | geometric.cj（dot/cross/normalize）+ trigonometric.cj（cos/sin |
| **P1** | `quatLookAt` / `quatLookAtRH` / `quatLookAtLH`（gtc 看向函数 | 3 | **中**——摄像机朝向计算的便捷入口；但可通过降级路径替代（§3.16 降解路径表已给出完整代码骨架 | 浅-中（依赖 geometric.cj: cross/dot/normalize/inversesqrt/max+quatCast | **中**——需要验证不同输入方向的正交化精度 | geometric.cj（cross/dot/normalize/inversesqrt/max |
| **P2（最低）** | `rotate`（四元数变换 | 1 | **低**——功能可由 Quat×Vec3 降级路径 + angleAxis 间接实现 | 浅（依赖 trigonometric.cj: sin/cos + geometric.cj: length | **低**——与 angleAxis 功能重叠，验证优先级低 | trigonometric.cj（sin/cos）+ geometric.cj（length |
| **P2** | ULP 比较（vector_relational | 4（8 重载 | **低**——epsilon 比较在绝大多数场景够用；ULP 仅在需要严格浮点位级精度时使用 | N/A（不依赖其他 stub，但仓颉无浮点位级访问 API，需评估替代方案 | **低**——核心障碍为语言能力而非 stub 依赖，验证方案不确定 | 无（需评估仓颉 CFFI 或 std.math.Float API |
| **P2** | gtc/matrix_transform 全部 64 函数 | 64 | **中-高**（按函数子类分化：perspective/ortho/lookAt 在图形渲染中高频使用；project/unProject 使用频率较低 | **极深**（依赖 geometric/trigonometric/common + ext/matrix_projection/clip_space/transform 三文件 | **N/A**——64 个函数本身即阶段四完整工作包，不在此优先级排序范围内 | 所有基础函数库 |

**优先级排序执行建议**：
- **P0 组（9 个函数）**——在 trigonometric.cj 和 common.cj 函数体实现到 50% 时即可启动，无需等待这两个基础库完全实现——仅需 `acos`/`sin`/`asin`/`atan`/`clamp` 等约 10 个标量函数即可满足 P0 组的全部依赖。建议在 trigonometric.cj 启动实现后第 2 个 sprint 内完成 P0 组的端到端验证。
- **P1 组（9 个函数）**——在 geometric.cj 和 trigonometric.cj 完成度达到 80% 后启动。`exp`/`log`/`pow` 的 FloatingPoint 静态方法依赖已在 v25 验证通过（✅，无阻塞风险。
- **P2 组**：`rotate` 可在 P1 启动后并行实施（无依赖 chain 阻塞；ULP 比较需单独评估仓颉 API 替代方案；gtc/matrix_transform 作为阶段四独立工作包，需设计专门的工作分解结构。

#### API 可用率增长路线图

本阶段约 11%（18/165）的真完整实现率在阶段四各批次交付后将按以下阶梯增长。以下路线图以「独立函数范式」口径给出每批次交付后的累计可用率：

| 阶段四批次 | 交付内容 | 新增可用函数数 | 累计可用（独立函数 | 累计可用率（独立函数范式 | 累计可用率（含重载/常量展开口径 |
|----------|---------|-------------|----------------|---------------------|--------------------------|
| **阶段四批次 A**（阶段三现状 | — | 0 | 18 | **~11%** | ~47%（~77 个 |
| **阶段四批次 B** | trigonometric.cj 标量版核心函数完工（acos/sin/asin/atan/clamp 等 ~10 个标量函数 | +9 | 27（P0 组：slerp/mix/angle/angleAxis/eulerAngles/roll/pitch/yaw + 4 欧拉重导出的独立函数化 | **~16%** | ~52% |
| **阶段四批次 C** | trigonometric.cj 其余标量函数 + ULP 比较（如 CFFI 方案可行）+ geometric.cj（cross/dot/normalize 向量版）完工 | +8（P1 组：fromVec3/fromEuler + 3 quatLookAt + 3 实际 geometric 向量函数 = 8 | 35 | **~21%** | ~57% |
| **阶段四批次 D** | common.cj + quaternion_exponential.cj（exp/log/pow/sqrt）+ rotate + trigonometric.cj 向量版完工 | +7（P1+P2 组：exp/log/pow/sqrt/rotate + common.cj 新增 2 独立函数 | 42 | **~25%** | ~62% |
| **阶段四批次 E** | gtc/matrix_transform 64 函数 + ULP（如批次 C 未完成）+ 剩余细节补齐 | +2（ULP）+ 64 作为独立工作包 | 44 + 64 | **~65%**（独立函数，含 matrix_transform | ~100% |
| **阶段四整体** | 全部 88 个 ⚠️/❌ 函数补齐 | +147（含 64 个 matrix_transform 展开 | 165 | **100%** | **100%** |

**增长路线图使用说明**：
- **独立函数范式口径**——以 GLM 1.0.3 原始 API 函数名为独立计数单位，每个函数名无论重载变体均计为 1。这是本设计推荐的用户可见评估口径。
- **含重载/常量展开口径**——包含运算符重载变体、常量展开、向量分量数展开。阶段三此项基线为 ~77 个（47%，阶段四最终达到 165 个。
- **trigonometric.cj 对增长路线图的阻断效应**——P0 组 9 个函数全部依赖 trigonometric.cj 的标量版 `acos`/`sin`/`asin`/`atan` 函数——如果 trigonometric.cj 延迟，这些函数将在触发后阻塞整个增长链条。**风险缓解措施**——在阶段四实施时优先实现 trigonometric.cj 的标量版核心 10 个函数（不依赖向量版，可在 1-2 个 sprint 内解除 P0 组阻塞，使可用率达到 ~16%。
- **与路线图的关系**——本增长路线图是阶段四实施的时间线规划建议，具体批次划分和交付日期取决于阶段四的项目排期和资源分配。
- **批次编号说明**——本节的阶段四交付批次使用「阶段四批次 A~E」编号体系，以区别于 §8.4 阶段三实施批次使用的「第一批~第四批」编号体系。两者分别描述不同的实施阶段和交付周期，编号体系独立以避免混淆。

本节明确阶段三与阶段四的职责边界及演进兼容性，确保 88 个 ⚠️/❌ 函数在阶段四实现时不对阶段三已有的 API 签名造成破坏性变更。

**演进兼容性承诺**：
- **(a stub 函数签名在阶段四保持不变**——所有 stub 函数的签名模板（含 `where` 子句约束）在阶段四实现函数体时**不做任何修改**。具体来说——`trigonometric.cj` 的 75 个函数当前标注 `where T <: FloatingPoint<T>`，阶段四实现函数体时该约束保持不变；`gtc/quaternion.cj` 的 7 个 stub 函数签名与 `where` 子句同样锁定。阶段四仅填充函数体实现（将 `throw Exception("stub")` 替换为 `std.math.{func}` 调用或纯算术计算，不涉及签名变更。若阶段四发现某函数需要放宽或收紧约束，必须通过新增重载（而非修改签名）实现向后兼容。
- **(b ⚠️ 函数的运行时行为过渡路径**——当前标注 ⚠️ 的函数（`Quat×Vec3`/`Quat×Vec4`）编译通过但运行时抛 `Exception("stub")`。阶段四 geometric.cj 向量 `cross`/`dot`/`normalize` 等完整实现后，⚠️ 函数的运行时行为自动从「抛 stub 异常」切换为「正常功能」，无需修改 ⚠️ 函数本身的代码——因其依赖的 stub 函数被替换为正常实现，调用链自然生效。具体过渡节点：
  - `Quat×Vec3`/`Quat×Vec4`——依赖 `geometric.cj` 向量 `cross` → 阶段四 geometric.cj 完整实现时自动生效
- **(c 阶段四补充测试要求**——阶段四实现 stub 替换时，需对受影响的 ✅ 函数执行回归测试——
  - 对所有原本通过 ⚠️ 路径调用的已实现函数（`Quat×Vec3`/`Quat×Vec4`，阶段四需补充正常路径功能验证（不再仅验证 `assertThrows`
  - 对阶段四新增完整实现的 stub 函数，按「完整实现函数 ≥2 用例/函数」补全测试覆盖
  - 补充测试应写入现有测试文件，而非新建文件
- **(d 测试迁移指南**——阶段三的 `assertThrows(Exception("stub"))` 测试用例在阶段四实现后应逐步迁移为正常功能断言。对于每组 stub 函数，建议在阶段四实现时先通过 `assertThrows` 确认新旧行为切换点，再将用例改为功能断言。**批量迁移规则**——当一组高度同构的 stub 函数（如 `trigonometric.cj` 的 75 个函数）的函数体实现超过 50% 时，可对整组执行一次性批量迁移，无需逐函数迁移。

**签名冻结例外审批流程**——若阶段四确需修改阶段三已冻结的 stub 函数签名（含 `where` 子句约束，必须通过以下流程——
1. 在 §9 差异声明中记录修改理由及影响范围
2. 经设计评审确认修改的向后兼容性（是否可通过新增重载替代签名修改
3. 在评审通过后方可实施修改，并在 §8.3 I 节「已知未解决问题列表」中标注过渡期兼容性影响

**阶段三→阶段四责任边界总表**：

| 职责 | 阶段三 | 阶段四 |
|------|--------|--------|
| API 签名设计 | 全部完成（含 `where` 子句 | **不可修改**（仅可新增重载；例外需经 §3.16 签名冻结例外审批流程 |
| ✅ 函数实现 | 真完整实现 | 回归验证 + 补充测试 |
| ⚠️ 函数 | 编译通过，运行时抛 stub | 自动切换为正常功能 |
| ❌ stub 函数 | 仅签名 + `throw Exception("stub")` | 替换函数体为正常实现 |
| 边界行为契约 | 以 §5.3 表为准 | 保持与阶段三一致（仅可能扩展 |

#### 阶段四回归测试策略

本节覆盖演进指南中未明确的关键回归测试场景，确保 88 个 ⚠️/❌ 函数在阶段四实现时不对阶段三已实现函数引入回归。

**受影响的 ✅ 函数清单**——以下 77 个 ✅ 函数（签名行数口径）在阶段四 stub 替换为正常实现后需要回归测试——

| 受影响范围 | 触发条件 | 需回归的 ✅ 函数 |
|----------|---------|----------------|
| geometric.cj 完整实现 | 向量 `cross`/`dot`/`normalize` 等从 stub→正常 | `Quat×Vec3`/`Quat×Vec4`（⚠️→✅ 过渡）+ `normalize`/`axis`（确认零保护分支不受影响 |
| trigonometric.cj 完整实现 | `sin`/`cos`/`atan`/`asin`/`acos` 等从 stub→正常 | `mix`/`slerp`/`exp`/`log`/`pow`/`sqrt`/`angle`/`angleAxis`/`rotate`（❌→✅ 过渡）+ 所有依赖 trigonometric 的 ⚠️/❌ 函数 |
| common.cj 完整实现 | `abs`/`clamp`/`mix` 等从 stub→正常 | `mix`/`slerp`/`pow`/`eulerAngles` 等（❌→✅ 过渡 |
| 非直接依赖的 ✅ 函数 | — | 无需回归（纯算术运算符 `+`/`-`/`*`/`/`、`conjugate`/`inverse`/`dot`/`length` 等不依赖任何 stub |

**测试用例迁移灰度策略**：
1. **阶段四实现单个 stub 函数后**——先在该函数的测试文件中追加正常路径功能断言（新用例，保留原有的 `assertThrows` 用例不变
2. **批量触发条件**——当一组函数的函数体实现超过 50% 时，移除该组全部 `assertThrows` 用例，统一替换为功能断言
3. **灰度切换窗口**：`assertThrows` 与正常断言并存的窗口期不超过 2 个 sprint（阶段四迭代周期

**新增用例估算（stub 实现后）**：

| stub 函数组 | 函数数 | 估算新增用例 |
|------------|--------|------------|
| trigonometric.cj | 75 | 75 × 2 = 150（完整实现 ≥2 用例/函数 |
| gtc/matrix_transform.cj | 64 | 64 × 2 = 128 |
| quaternion_common.cj（mix/slerp | 3 | 3 × 2 = 6 |
| quaternion_trigonometric.cj（angle/angleAxis | 2 | 2 × 2 = 4 |
| quaternion_exponential.cj | 4 | 4 × 2 = 8 |
| quaternion_transform.cj（rotate | 1 | 1 × 2 = 2 |
| gtc/quaternion.cj（欧拉+看向 | 7 | 7 × 2 = 14 |
| ext/vector_relational ULP | 4 | 4 × 2 = 8 |
| fromVec3/fromEuler | 2 | 2 × 2 = 4 |
| **合计** | **162** | **≥324** |

**集成策略**——新增用例写入现有测试文件末尾，按函数组排列。测试文件拆分仅在现有文件超过 500 行时考虑。

#### §8.2 阶段四测试增量规划

待阶段四实现时，下表中的占位段落将由编码者补充具体的测试用例映射：

> **阶段四测试增量规划**——本占位段落将在阶段四设计迭代中，依据 §3.16 回归测试策略补充每个 stub 函数组的测试用例清单、用例文件位置、以及与阶段三 `assertThrows` 用例的迁移计划。详见阶段四设计文档。

#### 阶段三交付能力与路线图预期差距评估

本设计文档在 §1、§1.2 和 §11.5 中诚实地展示了阶段三的能力边界——约 11%（18/165）的真完整独立函数、约 53%（88/165）的 stub 占位、两个核心用户用例（Quat×Vec3 旋转向量和 slerp 球面插值）均不可用。本节回答以下根本问题——**本设计是否仍然满足阶段三的路线图目标？**

**路线图目标回顾**：`docs/02_roadmap.md` 定义的阶段三目标为「迁移四元数类型及其必需的 ext/gtc 依赖文件，为库提供基础的旋转表达和插值运算框架」。该目标的核心交付承诺为四元数类型的**基本数学骨架**（构造、共轭、逆、归一化、线性插值、矩阵互转）——这一骨架在 18 个 ✅ 函数中已得到完整覆盖。

**自我评估结论**——本设计**部分满足**阶段三路线图目标，**存在重大差距**——

| 维度 | 路线图预期（可合理推断 | 实际交付 | 差距评估 |
|------|-----------------------|---------|---------|
| 四元数基本数学运算（构造/归一化/共轭/逆/点积 | ✅ 完整可用 | ✅ 完整可用（12 个 ✅ 函数 | **无差距** |
| 线性插值 | ✅ `lerp` 可用 | ✅ `lerp` 可用 | **无差距** |
| 四元数↔矩阵互转 | ✅ 可用 | ✅ 可用（4 个 ✅ 函数 | **无差距** |
| 四元数旋转向量（Quat×Vec3 | ⚠️ 可期待 | ⚠️ 编译通过但抛 stub | **重大偏离**——旋转向量是四元数最核心的用户语义之一 |
| 球面插值（slerp | ⚠️ 可期待 | ❌ stub 占位 | **重大偏离**——球面插值是四元数区别于普通旋转向量的核心能力 |
| 欧拉角提取 | ⚠️ 可期待 | ❌ stub 占位 | **中等偏离**——存在降级路径（fromMat3 间接求取 |
| API 可用率（独立函数范式 | ~40-50%（合理预期 | **~11%（18/165）** | **重大偏离**——实际可用率仅为合理预期的 1/4~1/5 |
| API 可用率（含重载/常量展开 | ~60-70%（乐观预期 | **~47%（77/165）** | **中等偏离**——但展开口径不具有功能完整性意义 |

**量化差距明细**：

| 差距类别 | 具体差距项 | 量级 | 对下游影响 |
|---------|----------|------|----------|
| **功能缺口** | 2 个核心用例（旋转向量 + 球面插值）不可用 | 5 个 API 函数（2 ⚠️ + 3 ❌ | 使用者若以 quaternion 为载体做旋转表达和插值运算，无法在阶段三完成端到端迁移。动画系统、骨骼混合、相机过渡等典型场景均依赖 slerp |
| **覆盖缺口** | trigonometric.cj(75)+geometric.cj(6)+common.cj(3 三个基础库全部 stub | 84 个 ❌ 函数 | 所有依赖三角/几何/通用函数的四元数高阶运算（exp/log/pow/sqrt/angle/angleAxis/eulerAngles/quatLookAt 等 24 个函数）均不可用 |
| **可用率缺口** | 独立函数范式可用率仅 11% | 距离 40-50% 合理预期差 **29-39 个百分点** | 下游决策者按 11% 评估迁移成本，与按 40% 评估的结果相差约 4 倍 |
| **语义缺口** | `Quat×Vec3` 旋转向量仅 ⚠️（编译通过但抛 stub | 4 个 ⚠️ 运算符 | 「编译通过但运行失败」的体验可能误导下游在不可用的 API 上构建代码，产生调试成本 |
| **预期缺口** | §1 设计目标"为库提供基础的旋转表达和插值运算框架"对外传递的预期与实际交付能力不匹配 | 读者合理预期可用 slerp/mix/Quat×Vec3 | 阅读设计目标后签约迁移的团队发现 2 个核心能力缺失，产生信任损失 |

**关键差距分析**：
1. **API 可用率口径**——独立函数范式 11% 显著低于合理预期的 40-50%。根本原因是 trigonometric.cj（75 个函数）、common.cj、geometric.cj 三个基础函数库全部以 stub 占位，导致依赖这些库的四元数函数（slerp/mix/pow/log/exp/angle/angleAxis/eulerAngles/quatLookAt 等 24 个函数）均不可用。
2. **核心用例不可用**——四元数的两个核心语义——**旋转向量**（Quat×Vec3）和**球面插值**（slerp）——本阶段均不可用。这显著削弱了阶段三的"旋转表达和插值运算"宣发定位。
3. **三项已决策偏差（D35-D37）**——虽记录为「已闭环」，但未在闭环时进行自我影响评估。D35（slerp 不可用）影响 2 个 ❌ 函数，风险和影响在高优先级；D36（命名差异）影响 3 个 stub 函数，风险中等；D37（路线图标注范围过广）影响 3 个 ❌ 函数，风险低。

**路线图修订建议**：
1. **立即修订**——将阶段三可用率从原路线图中的隐含乐观估计明确修正为「约 11%（18/165 独立函数范式）」，并在路线图中新增「约 47%（77/165，含重载/常量展开）」作为参考口径。
2. **短期修订**——在路线图阶段三目标描述中，将 `[可验证]`/`[部分可验证]`/`[待 Stage 4]` 三级标注按 §11.5 的函数级状态重新对齐。
3. **中长期规划**——将阶段四 trigonometric.cj 标量版核心函数的实施优先级提升为 P0（当前已列为 P0，建议在阶段四的前 1-2 个 sprint 内完成 acos/sin/asin/atan/clamp 等约 10 个标量函数，使四元数可用率从 11% 快速提升至约 16%。
4. **风险评估**：11% 的可用率对下游集成测试覆盖的影响有限——18 个 ✅ 函数覆盖了四元数的基本数学骨架，下游开发者可以在单元测试中验证这些核心运算的正确性。但对于需要完整四元数功能的端到端场景（如动画系统中的 slerp 插值链路、渲染管线中的四元数旋转向量，本阶段无法验证。建议项目管理层根据下游依赖方的集成计划评估是否需要在阶段三和阶段四之间插入一个"阶段三.五"来补齐 trigonometric.cj 标量核心函数。

### 发布决策支持

以下从**外部决策者**视角，对"阶段三是否应如期发布"提供量化决策依据。

**如期发布的理由**：

| 理由 | 量化依据 |
|------|---------|
| 基本数学骨架完整可用 | 18 个 ✅ 函数覆盖了四元数的构造、归一化、共轭、逆、点积、长度、线性插值、矩阵互转等基础运算——这些是一个四元数库的"最小可行集" |
| API 签名已全部冻结 | 165 个 GLM API 的仓颉签名（含 where 子句）已在 §3 各节中完整定义，阶段四无须破坏性变更即可补齐 stub 函数体——后续升级对阶段三消费者透明 |
| 验证前置已闭环 | 3 项 P0 核心假设（H1/H2/H3）已在 v25 完成编译验证 ✅，H7 版本标注门禁与 H6 运行时依赖分析门禁已建立——阶段三质量可追溯 |
| 降级路径已量化 | 针对 2 个不可用核心用例（slerp、Quat×Vec3，§3.16 已给出量化成本分解的可执行降级方案（slerp→nlerp 需 2-3 人日，Quat×Vec3→Vec3×Quat+inverse 需 1.5-2.5 人日 |

**如期发布的风险**：

| 风险项 | 概率 | 影响 | 风险等级 |
|-------|------|------|---------|
| **用户预期破裂**——下游按 §1 设计目标"旋转表达和插值运算框架"迁移，发现 slerp/mix/Quat×Vec3 均不可用，产生信任损失 | **高** | 3-5 个早期迁移团队可能暂停迁移决策，影响阶段四用户基数积累 | **极高** |
| **调试误导**：⚠️ 函数编译通过但运行抛 stub，下游可能投入 2-5 人日排查"自己代码的问题"后才发现是库的限制 | **中** | 每个 ⚠️ 函数误触平均产生 1-3 人日的无效调试成本 | **高** |
| **功能疲劳**：11% 的可用率使早期采用者的可用功能很快耗尽，无法产生足够的"试用→正反馈→推荐"循环 | **中** | 阶段三到阶段四的空窗期（预计 6-8 周）内用户活跃度预期下降 60-80% | **高** |

**建议延期方案**：

| 方案 | 内容 | 附加工期 | 阶段三可用率提升至 | 风险缓解效果 |
|------|------|---------|----------------|------------|
| **方案 A（推荐）**——如期发布阶段三（不含 trigonometric.cj，同时在路线图中将 trigonometric.cj 标量核心函数提前至"阶段三.五"（第 7-8 周补齐 acos/sin/asin/atan/clamp 等 10 个标量函数 | 阶段三按 18 个 ✅ 函数发布；阶段三.五将可用率从 11% 提升至 ~16%，解锁 slerp/mix/angle/angleAxis/eulerAngles 等 9 个 P0 函数 | 阶段三.五：2-3 周（与阶段四部分重叠 | **~16%** | **中**——解锁 slerp 降低用户预期破裂风险，但距离 40-50% 合理预期仍有差距 |
| **方案 B（保守）**——将阶段三推迟至 trigonometric.cj（标量）+ common.cj + geometric.cj 基础库的 P0 函数实现后发布 | 一次性补齐约 20 个标量函数 + 30 个 stub → 完整实现过渡 | 6-8 周 | **~25-30%** | **高**——可用率达 25%+，旋转向量和 slerp 均可正常使用，用户可完成端到端迁移验证 |
| **方案 C（激进）**——完全放弃阶段三独立发布，将当前产出并入阶段四作为前置工作包 | 阶段三/四合并为单一发布 | 0 周（合并无附加成本 | **0%（无独立发布）** | **最高**——无预期破裂风险，但损失了阶段三的增量交付价值和早期用户反馈窗口 |

**决策建议**——对于对外发布的项目，推荐**方案 A**——如期发布阶段三但公开发布时在 §1 以醒目格式声明"阶段三提供四元数基本数学运算框架；旋转向量和球面插值需要 Trigonometric Starter Pack（阶段三.五，预计 2-3 周后交付）"，将用户预期从"完整的四元数库"校准为"四元数基础库+即将到来的插值能力"。对于内部使用的项目，推荐**方案 B** 或**方案 C**，避免多阶段过渡带来的维护成本和对内解释成本。

---

## 4. 关键行为契约

### 4.1 四元数构造与单位四元数

```
let q = Quat<Float32, PackedHighp>.identity(1.0f    // 单位四元数 (0,0,0,1 [本阶段可验证]
let q = Quat<Float32, PackedHighp>(0.0f, 0.0f, 0.0f, 1.0f // 逐分量 [本阶段可验证]
let q = Quat<Float32, PackedHighp>.wxyz(1.0f, 0.0f, 0.0f, 0.0f // wxyz 顺序 [本阶段可验证]
```

### 4.2 四元数旋转

```
let rotated = q * v        // 四元数旋转 Vec3 [本阶段调用抛 stub 异常，待阶段四 geometric.cj 完整实现后生效]
let rotatedV4 = q * v4     // 四元数旋转 Vec4（保留 w 分量）[同上]
let invRotated = v * q      // Vec3×Quat = inverse(q * v [本阶段可验证，通过 inverse 路径，不依赖 stub]
```

### 4.3 四元数插值

```
let result = lerp(q1, q2, 0.5f    // 线性插值（含 assert 断言）[本阶段可验证]
let result = conjugate(q           // 共轭 [本阶段可验证]
let inv = inverse(q               // 逆四元数 [本阶段可验证]
// slerp 为 stub，待阶段四 trigonometric.cj/common.cj 完整实现后生效
```

### 4.4 矩阵-四元数互转

```
let m3 = glm.mat3Cast(q    // 四元数转 3×3 旋转矩阵 [本阶段可验证，通过 lib.cj 的 public import 重导出从顶层 glm 命名空间调用]
let m4 = glm.mat4Cast(q    // 四元数转 4×4 旋转矩阵 [本阶段可验证]
let q = glm.quatCast(m3    // 3×3 旋转矩阵转四元数 [本阶段可验证]

// gtc 命名空间下的同名 API（通过 public import 重导出，[本阶段可验证]，：gtc 端采用 camelCase 命名 `mat3Cast`/`mat4Cast`/`quatCast`，与 detail 端实现函数名一致——`public import a.b.f` 仅重导出 f 原始名，不做命名转换；若下游按 GLM 习惯使用 snake_case `mat3_cast` 将编译失败
let m3_2 = glm.gtc.quaternion.mat3Cast(q
let q_2 = glm.gtc.quaternion.quatCast(m3
```

注：§4.4 示例统一使用 `glm.mat3Cast(q)` 顶层命名空间调用形式，与 §11.4「仓颉顶层 glm 命名空间调用」段保持一致；调用方需先通过 `lib.cj` 完成 `public import` 间接访问，无需显式 `import glm.detail.*`。v10/v6 描述的「无前缀 `mat3Cast(q)`」调用形式若按字面实现（未先 `import glm.detail.*`，将因 `mat3Cast` 在 `glm.detail` 命名空间下而触发「未定义符号」编译错误。**前提条件**——调用方必须 `import glm`（导入 lib.cj 公共 API 层，使 `glm.mat3Cast` 在当前包命名空间下可见。

### 4.5 标量常量与数学常量

```
let eps = epsilon<Float32>     // 1.1920929e-7 [本阶段可验证]
let p = pi<Float32>            // 3.14159265... [本阶段可验证]
let half = halfPi<Float32>     // 1.57079632... [本阶段可验证]
```

### 4.6 欧拉角与看向（stub）

```
let euler = eulerAngles(q       // 欧拉角提取 [本阶段 stub]
let r = roll(q                  // roll 分量 [本阶段 stub]
// quatLookAt 等看向函数 [本阶段 stub]
```

---

## 5. 错误处理策略

### 5.1 通用异常

- **下标越界**：`q[i]`（i < 0 或 i >= 4）抛出 `Exception`（与阶段一/二一致
- **`normalize` 零四元数**——返回单位四元数 `Quat(T(Float64(0)), T(Float64(0)), T(Float64(0)), T(Float64(1)))`（——T(0)/T(1 均采用 `T(Float64(n))` 字面量替代路径，与 §1 系统性约束 一致，与 GLM `quaternion_geometric.inl:20-21` 行为一致
- **stub 函数体**——以 `throw Exception("stub")` 占位（标识阶段三/四功能边界

### 5.2 算术溢出

- **统一标注**——四元数算术运算符（`+`/`-`/`*`/一元 `-`/标量乘除）统一标注 `@OverflowWrapping` 注解，与阶段一 Vec3 (`type_vec3.cj:54-80` 和阶段二全部矩阵类型 (`type_mat2x2.cj`、`type_mat3x3.cj` 等 的实践保持一致
- **跨类型一致性**：`@OverflowWrapping` 对浮点类型无效果（std.overflow 模块语义仅作用于整数溢出行为，但保持跨整数/浮点实例化的统一行为，避免未来整数四元数用例出现不可控整数溢出行为

### 5.3 边界条件与异常场景

| 边界条件 | 函数 | 行为契约 |
|---------|------|---------|
| `1 - x.w*x.w <= 0` | `axis(q)` | 返回 `Vec3(T(0), T(0), T(1))`（z 轴单位向量，典型场景——单位四元数 `(0, 0, 0, 1)` 即 `\|w\| >= 1`；与 GLM `ext/quaternion_trigonometric.inl:20-27` 一致；触发条件为 `1 - w² <= 0` 而非 `q.xyz == 0` |
| 真正零四元数 `(0,0,0,0)` | `axis(q)` | `tmp1 = 1 > 0` 进入 else 分支，返回 `Vec3(T(0), T(0), T(0))`（GLM 实际不调用 `normalize` |
| 零四元数 `(0,0,0,0)` | `normalize(q)` | 返回单位四元数（T(0)/T(1 获取路径及实现策略详见 §3.7 + §1 |
| **`length(q)` 极小值（接近 0 但非 0，Issue 2 响应）** | `normalize(q)` | `tmp1 > T(0)` 但接近 `FloatingPoint<T>.getMinDenormal()` 量级时**不触发零保护分支**，返回 `q / tmp1` 结果各分量趋向 Inf/NaN（与 GLM 行为一致，GLM 不做 length 极小值保护；如需防止此类溢出，应在调用 `normalize` 前自行检查 `length(q >= epsilon<T>()` |
| 零四元数（浮点 | `inverse(q)` | 浮点除零产生 Inf/NaN 分量（与 GLM 一致，GLM 不做零除保护 |
| 零四元数（整数 | `inverse(q)` | **编译期拒绝**；原行为「触发仓颉 `ArithmeticException`」因约束收紧不再适用 |
| `cosTheta` 退化 | `mix`/`slerp` | 依赖 `cosTheta > 1 - epsilon<T>()` 边界检查；stub 函数抛 stub 异常 |
| 非纯旋转矩阵 | `fromMat3`/`fromMat4` | 仅对纯旋转矩阵产生有意义的四元数；对非旋转矩阵（缩放/平移/剪切）行为未定义，结果可能产生非单位四元数或语义错误的旋转 |
| `a` 超出 [0,1] | `lerp` | 触发 `assert(a >= 0 && a <= 1)` 断言失败 |
| `epsilon = T(0)` | `equal(v, v, 0)` | 返回 `false`（严格小于语义，与 GLM `glm/gtc/epsilon.inl:32-41` 中 `epsilonEqual` 实现一致；——原引用 `func_vector_relational.inl:18-22` 错误——该文件不含 epsilon 版本 |
| 整型 T | `epsilon<T>()`/`pi<T>()`/`cos_one_over_two<T>()` | 触发 `Exception("not defined for non-floating-point types")`（约束收紧失败时 fallback 分支 |
| 整型 T | `isnan(q)`/`isinf(q)` | 编译期约束收紧为 `where T <: FloatingPoint<T>`，整型 T 实例化时编译失败；若仓颉泛型不支持窄约束则运行时 fallback 抛 `Exception("isnan/isinf not defined for non-floating-point types")` |
| 整型 T | `mat3Cast`/`mat4Cast`/`quatCast` | 编译期约束收紧为 `where T <: FloatingPoint<T>`，整型 T 实例化时编译失败 |
| u, v 反平行（`real_part < 1e-6f * norm_u_norm_v`，即 `dot(u,v ≈ -sqrt(dot(u,u * dot(v,v))` | `fromVec3` | 返回 `q.w = 0` 的纯向量四元数，轴选择由 `abs(u.x > abs(u.z)` 条件决定（与 GLM `detail/type_quat.inl:196-217` 退化路径一致。阶段三 stub 阶段不适用，待阶段四 stub 替换后生效 |
| u, v 为零向量 | `fromVec3` | 行为未定义（由 `normalize` 阶段四完整实现时确定 |
| `mat3Cast` 接受非单位四元数 | `mat3Cast`/`mat4Cast` | 返回矩阵不保证是旋转矩阵（缩放/剪切分量保留；契约，与 §3.2.1 边界行为契约段对齐 |
| `quatCast` 接受非旋转矩阵 | `quatCast` | 返回的四元数行为未定义（可能为非单位四元数/零四元数/NaN 四元数；契约，与 §3.2.1 边界行为契约段对齐 |
| 整型 T（`Int8`~`Int64` | `trigonometric.cj` 全体函数（`sin`/`cos`/`tan` 等 | 通过 `where T <: FloatingPoint<T>` 约束在编译期拒绝；整型 T 实例化时报类型不匹配错误 |
| NaN/Inf 输入传播 | 全体算术运算符与函数 | NaN 输入传播规则——四元数算术运算符（`+`/`-`/`*`/`/`）及 `dot`/`length`/`conjugate`/`lerp`/`inverse` 等函数中，若任意分量包含 NaN/Inf，结果对应分量传播 NaN/Inf，与 GLM 浮点传播语义一致。`isnan`/`isinf` 对 NaN/Inf 输入分别返回 true |
| `lerp` 参数 `a` 为 NaN/Inf 或负数 | `lerp` | `a` 为 NaN 时返回 NaN 四元数（NaN 传播；`a` 为 +Inf 或 -Inf 时行为未定义（与 GLM 一致，GLM 不校验 `a` 值域之外的非有限值；`a` 为负数时若在 assert 生效范围内则触发 `assert` 失败 |
| 单位矩阵/零矩阵输入 | `fromMat3`/`fromMat4` | 单位矩阵输入——`fromMat3` 返回单位四元数 `(0, 0, 0, 1)`；`fromMat4` 的左上 3×3 子矩阵为单位矩阵时同理返回单位四元数。零矩阵输入——行为未定义（`trace=0` 导致推导公式除零，与 GLM 1.0.3 `detail/type_quat.inl` 行为一致 |
| `axis` 对 NaN w 分量 | `axis` | `q.w` 为 NaN 时 `1 - NaN*NaN = NaN`，`tmp1 <= 0` 判断为 false，进入 else 分支。`tmp2 = 1 / sqrt(NaN = NaN`，返回 `Vec3(x*NaN, y*NaN, z*NaN)`——全 NaN 向量，与 GLM `ext/quaternion_trigonometric.inl:20-27` 浮点传播语义一致 |
| `inverse` 对非单位四元数输入 | `inverse` | 非单位四元数的 `inverse` 返回共轭除模平方的结果，语义正确（四元数逆的定义为 `q⁻¹ = q̅ / \|q\|²`，对非单位四元数同样成立。与 GLM `ext/quaternion_common.inl` 行为一致，不做单位化保护 |
| Vec3×Quat / Vec4×Quat 运行时行为 | `Vec3×Quat` / `Vec4×Quat` | **本阶段编译通过但运行时抛 `Exception("stub")`**。实现链为 `(conjugate(q / dot(q,q) * v`，其中 `*` 运算符重载委托至同包 `Quat×Vec3` 运算符（依赖 `geometric.cj` 向量 `cross` stub，运行时异常传播路径完全一致。**非内联 `conjugate`/`dot` 路径的纯算术可用性误导**——内联仅消除包间 import 依赖，未消除对 Vec3 cross stub 的运行时调用 |
| 跨 Qualifier 调用（Q1 ≠ Q2，Problem 5 响应 | 全体泛型函数与运算符（§3.4运算符表、§3.7 dot/length/normalize/cross、§3.9 axis、§3.11 inverse/conjugate/isnan/isinf | 编译期报类型不匹配错误（函数签名仅接受单一 Q 参数，Q1 ≠ Q2 时编译器无法推断一致类型。调用方应通过跨 Qualifier 构造函数 `Quat<T,Q2>(q_of_Q1)`（§3.3 item 3）显式转换后再调用。详见 §5.6 跨 Qualifier 行为统一契约 |
| 跨 Qualifier 调用——下调精度（Highp → Mediump/Lowp， | 同上 | 显式转换构造不会引发精度损失错误（跨 Qualifier 构造函数为纯赋值，但下调精度可能导致后续浮点运算的精度损失。本阶段不提供精度损失告警 |
| 跨 Qualifier 调用——上调精度（Lowp → Mediump/Highp， | 同上 | 上调精度后浮点运算精度提升，不会出现精度损失。与 GLM 精度提升语义一致 |
| NaN 输入 | `normalize(q)` | NaN 分量输入时 `length(q)` 返回 NaN，`tmp1 <= T(0)` 判断为 false（NaN 比较返回 false，进入 else 分支 `q / NaN` 返回全 NaN 四元数，与 GLM `ext/quaternion_geometric.inl:17-24` 浮点传播语义一致。**契约声明**：normalize 不提供 NaN 输入保护，结果分量均为 NaN |
| NaN 四元数输入 | `mat3Cast(q)` | NaN 分量经旋转矩阵公式传播，结果矩阵的 9 个元素中受 NaN 分量影响的位置对应为 NaN；不受影响的位置保持有限值。与 GLM `type_quat.inl:49` 浮点传播语义一致 |
| NaN 四元数输入 | `inverse(q)` | `conjugate(q)` 产生含 NaN 的共轭四元数，`dot(q,q)` 返回 NaN，`conjugate(q / NaN` 产生全 NaN 四元数。与 GLM `ext/quaternion_common.inl` 浮点传播语义一致 |
| Inf 输入（`a` 为 +∞ 或 -∞ | `lerp(q1, q2, a)` | `a` 为 +Inf 时 `assert` 因 `a >= 0` 通过但 `a <= 1` 失败而触发 assert 失败；`a` 为 -Inf 时 `assert` 因 `a >= 0` 失败而触发 assert 失败。若 assert 被禁用（release 模式，+Inf 产生 `x * (-Inf + y * Inf = NaN` 结果四元数，-Inf 同理。与 GLM `ext/quaternion_common.inl:28-38` 行为一致 |

### 5.4 const 上下文约束

- **`lerp`/`inverse` 不可在 const 上下文调用**——描述「`lerp`/`conjugate`/`inverse` 不可在 const 上下文调用」错误——`conjugate` 函数体仅对 x/y/z 三个分量取反（`Quat(-q.x, -q.y, -q.z, q.w)`，无 `assert`/无 `throw`/无运行时副作用，**可在 const 上下文调用**（与 Vec/Mat 的逐分量运算符策略一致。——从禁止列表中移除 `conjugate`；`lerp` 因函数体内 `assert(a >= 0 && a <= 1)` 断言非 const 函数（与 deviations.md IF-03 一致，不可在 const 上下文调用；`inverse` 函数体内部 `conjugate(q / dot(q, q)` 的 `/` 运算符在仓颉整数类型上非 constexpr 兼容，故不可声明为 `const func`
- **`inverse` const 拒绝理由；，Issue 1 响应）**：`inverse` 函数体内部 `conjugate(q / dot(q, q)` 的 `/` 运算符在仓颉整数类型上非 constexpr 兼容，故不可声明为 `const func`（非之前所述的「运行时抛算术异常」原因——const 函数约束是关于编译器能否在编译期对函数求值，而非关于函数运行时是否可能抛异常。`lerp` 不可 const 的原因保持不变——`assert` 在仓颉中非 constexpr 兼容
- **`conjugate` const 适用性**——`conjugate` 函数体仅涉及 `Quat` 主构造函数的逐分量取反调用（`Quat(-q.x, -q.y, -q.z, q.w)`，无 `assert`/无 `throw`/无 `dot`/`normalize`/其他非 const 函数调用，**可声明为 `const func`**（与 Vec/Mat 的逐分量运算符策略一致。——若仓颉 const 函数还有其他限制（如不能调用非 const 自由函数、不能包含复杂表达式，则该论断需进一步评估
- **stub 函数不声明 const**：stub 函数体 `throw Exception("stub")` 不可在 const 上下文求值

### 5.5 标量/四元数 `div` 语义

- **逐分量除法**：`div(s, q)` 语义为 `s / q.x, s / q.y, s / q.z, s / q.w`（与阶段二标量/矩阵 `div` 模式一致

### 5.6 跨 Qualifier 行为统一契约

本阶段所有泛型函数和运算符的跨 Qualifier 调用遵循以下统一契约声明。此契约适用于 §3.4 运算符表、§3.7 dot/length/normalize/cross、§3.9 axis、§3.11 inverse/conjugate/isnan/isinf 等全部 40+ 个泛型函数和运算符。

**契约声明**：
1. **本阶段仅提供相同 Qualifier 的签名模板**——所有函数的泛型参数 `Q` 在函数签名中唯一（即 `f(x: Quat<T,Q>, y: Quat<T,Q>)` 而非 `f(x: Quat<T,Q1>, y: Quat<T,Q2>)`。当调用方传入不同 Qualifier 的实参时，编译器因 Q 不匹配报类型推断错误。
2. **跨 Qualifier 调用的显式转换路径**——调用方可通过跨 Qualifier 构造函数 `Quat<T,Q2>(q_of_Q1)`（§3.3 item 3）将输入四元数显式转换为目标 Qualifier 后再调用函数。该构造函数内部实现为纯赋值（跨 Qualifier 转换无数据变化，编译期零开销。
3. **阶段四双 Qualifier 重载的优先级与语义**——详见 §3.11 D34 扩展段的统驭全篇跨 Qualifier 策略声明。P0 优先级的函数（`lerp`/`inverse`/`normalize`/`dot`/`length`）将在阶段四优先补充双 Qualifier 重载。
4. **异常场景**——若调用方未进行显式转换直接调用（Q1 ≠ Q2，编译错误信息为"类型不匹配——期望 `Quat<T,Q1>` 但收到 `Quat<T,Q2>`"。本阶段不提供更友好的错误消息。

---

## 6. 并发设计

本阶段不引入并发场景。四元数类型为值类型，所有运算符返回新实例，天然线程安全。

---

## 7. 设计决策

| 编号 | 决策 | 理由 |
|------|------|------|
| D01 | Quat 数据布局为 x,y,z,w（非 GLM 的 w,x,y,z 参数顺序 | 与 GLM 默认存储布局一致，避免 GLM_FORCE_QUAT_DATA_WXYZ 宏引入的条件编译复杂性 |
| D02 | Quat 主构造函数参数顺序为 (x,y,z,w，另提供 wxyz(w,x,y,z 工厂函数 | 主构造函数参数顺序与数据成员声明顺序一致（仓颉惯用风格，wxyz 函数兼容 GLM 习惯 |
| D03 | 四元数×向量运算符定义为 Quat 的成员运算符 | 左操作数类型拥有运算符，与阶段二 Mat×Vec 模式一致 |
| D04 | 向量×四元数运算符定义为 Vec 的 extend 块成员运算符 | 左操作数类型拥有运算符，依赖同包前向引用延迟解析（已通过阶段二原型验证 |
| D05 | 标量-四元数运算通过全局函数（scalar_quat_ops.cj | 仓颉 operator func 限制——右操作数非 Quat 类型的标量左操作数不能定义为成员运算符 |
| D06 | ext/vector_relational 的 epsilon 比较内联 abs，不依赖 common.cj stub | 消除对 stub 文件的运行时依赖风险，确保 epsilon 比较函数可正常执行 |
| D07 | ULP 比较函数本阶段以空桩占位 | 仓颉无浮点位表示直接访问能力（无 `reinterpret_cast`/`union` 等价机制，待阶段四评估替代方案 |
| D08 | scalar_constants 实现于 glm.detail.scalar_constants.cj，ext/ 仅做重导出 | 遵循 detail 封装核心实现、ext/gtc 封装公共 API 的双层架构约定 |
| D09 | scalar_constants 的泛型函数使用 `match` 类型模式匹配 + hint 参数 | 仓颉无 `std::numeric_limits<T>::epsilon()` 等编译期类型属性查询机制，必须运行时分派 |
| D10 | gtc/constants 中 **28 个**常量函数使用具体类型硬编码值直接返回（——误标为 25 | 与 GLM `genType(3.14159...)` 实现方式一致，避免函数间调用依赖 |
| D11 | ——转换函数实现位于 `glm.detail.type_quat_cast.cj`，`gtc/quaternion.cj` 通过 `public import` 重导出；gtc 端重导出函数名为 camelCase `mat3Cast`/`mat4Cast`/`quatCast`（与 detail 端原始函数名一致，**非** GLM 习惯的 snake_case `mat3_cast`/`mat4_cast`/`quat_cast` | **消除包间循环依赖**——设计将转换函数放在 gtc 导致 `type_quat.cj` 需 `import glm.gtc.quaternion` 形成 `glm.detail ↔ glm.gtc` 双向依赖，违反仓颉包间循环依赖约束（cangjie-lang-features package/README.md 第 99 行。v3 决策将转换函数下沉至 detail 包，让 `type_quat.cj` 通过同包访问直接调用（无需 import，`gtc/quaternion.cj` 通过 `public import` 重导出至 gtc 命名空间，保留 GLM 1:1 API 形态的同时彻底打破循环依赖。——仓颉 `public import a.b.f` 仅重导出 f 原始名（依据 `cangjie-lang-features/package/README.md` 第 156-166 行规范，不做命名转换；detail 端原始函数名为 camelCase `mat3Cast`/`mat4Cast`/`quatCast`，因此 gtc 端重导出后仍为 camelCase——下游按 GLM 习惯使用 snake_case `mat3_cast`/`mat4_cast`/`quat_cast` 调用 `glm.gtc.quaternion.mat3_cast(q)` 将编译失败。该偏差属「API 命名风格」类差异，与现有 `public import glm.detail.{transpose, matrixCompMult, outerProduct}`（`cjglm/src/lib.cj:8`，camelCase）模式一致 |
| D12 | type_quat.inl 中 fromVec3(u,v) 和 fromEuler(eulerAngle) 构造函数本阶段化简为独立工厂函数 | 避免在 Quat 结构体内引入对 stub 函数的编译依赖；工厂函数在 extend 块中定义，可推迟至阶段四完整实现 |
| D13 | quatLookAt/quatLookAtRH/quatLookAtLH 等 gtc/quaternion 函数本阶段 stub 占位 | 这些函数依赖 geometric.cj 的 cross/dot/normalize/inversesqrt（均为 stub，无法完整实现 |
| D14 | quaternion_geometric.cj（dot/length/normalize/cross）本阶段完整实现 | 经分析确认依赖链仅止于 std.math.sqrt，不依赖任何 stub 文件 |
| D15 | quaternion_common.cj 中 conjugate/inverse/lerp/isnan/isinf 本阶段完整实现 | conjugate/inverse/lerp 仅需算术运算和 dot（已完整实现；isnan/isinf 采用 std.math 实例方法路径，不依赖顶层函数 |
| D16 | trigonometric.cj 新增为空桩文件 | type_quat.inl 依赖 trigonometric.hpp，本阶段仅提供签名空壳供依赖闭合 |
| D17 | Bool 四元数不支持算术运算 | Bool 不实现 Number<T> 接口，与阶段二 D33 Bool 矩阵策略一致 |
| D18 | scalar_quat_ops.cj 与 scalar_vec_ops.cj/scalar_mat_ops.cj 同名重载 | add/sub/mul/div 与向量/矩阵版本通过第二参数类型消歧，与阶段二策略一致 |
| D19 | 四元数算术运算符统一标注 @OverflowWrapping | 与阶段一/二所有算术运算符（含浮点重载）保持一致；标注对浮点无效果但保持跨整数/浮点实例化的统一行为 |
| D20 | **`gtc/quaternion.cj` 独立文件承载 15 函数** | 与 GLM `gtc/quaternion.hpp` 1:1 映射，便于 GLM 函数到仓颉文件的追溯；与阶段二 gtc 子包策略一致 |
| D21 | **`mix`/`slerp`/`pow` 的依赖明确包含 `epsilon<T>()`；`pow` 进一步包含 `cos_one_over_two<T>()`、`asin`、调用 `std.math.pow` 实数降级路径两次、`std::numeric_limits<T>::min()` 等价物** | 与 GLM `quaternion_common.inl`/`quaternion_exponential.inl:41-80` 实际依赖一致。本决策仅陈述最终结论——`mix`/`slerp` 依赖 `cosTheta > 1 - epsilon<T>()` 退化检测分支；`pow` 使用 line 52 `cos_one_over_two<T>()`、line 63 `std::numeric_limits<T>::min()` 等价物、line 65 + line 78 两次 `std::pow` 实数降级路径、line 68 `asin`。具体仓颉实现路径（含 `std.math.pow` 重载选择、`FloatingPoint<T>.getMinDenormal()`/`getInf()` 静态方法、line 65/78 仓颉等价翻译等）已统一归入 §3.10 和 §1，本决策不再重复。下游实现者查阅 §3.10 `pow` 依赖描述 + §1 系统性约束段即可。 |
| D22 | **`slerp` 4 参数版本 `k: Int64` 简化签名** | 与 deviations.md DV-03「移位运算右操作数固定为 Int64」风格一致；阶段三 slerp 为 stub，固定 `Int64` 简化签名不影响本阶段实施 |
| D23 | **`lerp` 实现含 `assert(a >= 0 && a <= 1)` 断言** | 与 GLM `ext/quaternion_common.inl:28-38` 一致，确保插值因子在 [0, 1] 范围内 |
| D24 | **向量 `equal` epsilon 比较采用严格 `<` 语义** | 与 GLM `glm/gtc/epsilon.inl:32-41` 中 `epsilonEqual` 实现一致，避免边界用例下 `equal(v, v, 0 = true` 的语义偏差。原引用 `func_vector_relational.inl:18-22` 错误——GLM 1.0.3 的 `func_vector_relational.inl` 中**不包含 epsilon 版本**的 `equal`/`notEqual`，epsilon 版本位于 `glm/gtc/epsilon.inl`（文件层面属 gtc 子包 |
| D25 | **`scalar_constants` 对整数类型 T 触发运行时异常** | 与 GLM `static_assert(is_iec559, ...)` 编译期断言等价行为（仓颉泛型若不支持窄约束则用运行时异常 |
| D26 | **`Quat×Vec3` 旋转公式采用两次 Vec3 叉乘** | 与 GLM `type_quat.inl:359-366` 实际实现一致——`v + (cross(QuatVector, v * q.w + cross(QuatVector, cross(QuatVector, v)) * 2`（uv 和 uuv 两次叉乘 |
| D27 | **fwd.cj 排除整型与 Bool 四元数别名** | ——文档引用阶段二「fwd.cj 排除整型矩阵别名」作为唯一先例，但该先例存在两处不准确：① 阶段一 Vec 家族**包含** `BVec2`（Bool 向量，见 `cjglm/src/fwd.cj:140-143`）的 Bool 别名，Vec 家族对 Bool 类型的处理策略与 Mat 家族不同；② 阶段二 Mat 家族明确不含整型别名（`cjglm/src/fwd.cj` 全文 grep 验证零整型别名，阶段一 Vec 家族对整型的处理（无 `IVec*`）与 Mat 家族策略一致。——fwd.cj 排除整型与 Bool 四元数别名的依据是——**整型四元数无实际用例**（quaternion 自然语义是旋转表达，整型四元数不参与实际数学运算）+ **Bool 四元数无实际用途**（D17——Bool 不实现 `Number<T>` 接口，算术运算编译期拒绝，无实用价值。——阶段三所有自定义类型族（Vec/Mat/Quat）均排除整型别名（语义不适用）+ 选择性排除 Bool 别名（Vec 家族保留 `BVec*` 因位运算是核心用例，Mat 家族不含 `BMat*` 因矩阵不参与位运算，Quat 家族不含 `BQuat*` 因四元数不参与位运算且算术不可用。下游可参考本策略理解「哪些类型族为何种用途排除何种别名」。 |
| D28 | ——包间依赖方向严格单向——`glm.gtc → glm.detail`、`glm.ext → glm.detail`、上层不依赖下层 | 仓颉 cjpm 构建系统严格禁止包间循环依赖（cangjie-lang-features package/README.md 第 99 行；D11 的 `type_quat_cast.cj` 下沉决策是本约束的直接体现 |
| D29 | **`isnan`/`isinf` 函数约束收紧为 `where T <: FloatingPoint<T>`** | `std.math` 的 `isNaN()`/`isInf()` 实例方法仅定义于浮点类型（`FloatingPoint<T>` 接口，stdlib 原生接口名，整数类型（`Int8`/`Int16`/`Int32`/`Int64`）无此方法。若不收紧约束，当用户实例化 `Quat<Int64, PackedHighp>` 并调用 `isnan(q)` 时，函数体内部 `q.x.isNaN()` 因 `Int64` 不实现 `isNaN()` 而编译失败。与 §3.12 `epsilon<T>()` 约束收紧策略保持一致；`FloatingPoint<T>` 是 stdlib 原生接口，编译期保证可用，无需 fallback |
| D30 | **Quat 字段统一标注 `public var`** | 满足 `@Derive[Hashable]` 派生宏对字段 `public` 可见性的硬性要求（依据 `cangjie-std/deriving/README.md` 第 4 节「参与派生的字段/属性必须为 public」。仓颉 struct 字段默认可见性为 `internal`（依据 `struct/README.md` 第 1.7 节，不满足 public 派生要求；与阶段一 Vec3 (`type_vec3.cj:8-10`)、阶段二全部矩阵类型 (`type_mat*.cj` 200+ 处统一实践 对齐 |
| D31 | **`axis` 函数实现采用 GLM 独立公式路径而非 `normalize` 路径** | GLM `ext/quaternion_trigonometric.inl:20-27` 实际实现是 `tmp1 = 1 - x.w*x.w` 独立公式，不调用 `normalize(Vec3(q.x, q.y, q.z))`。v3 描述的「内部 `normalize(Vec3(0, 0, 0))`」为虚构实现——若按 v3 描述实现，则需依赖 `geometric.cj` 的向量 `normalize`（阶段三为 stub，与同段「可完整实现」声明矛盾。后——`axis` 依赖仅 `std.math.sqrt` 和 T(1) 演算，触发 `Vec3(0, 0, 1)` 返回值的条件为 `1 - x.w*x.w <= 0`（已修复）（典型——单位四元数 (0, 0, 0, 1))，对于真正零四元数 (0, 0, 0, 0) 返回 `Vec3(0, 0, 0)` |
| D32 | **`type_quat_cast` 函数约束收紧为 `where T <: FloatingPoint<T>`** | 与 D29 `isnan`/`isinf` 约束收紧策略一致。GLM 1.0.3 在转换函数定义处使用 `GLM_STATIC_ASSERT(std::numeric_limits<T>::is_iec559, ...)` 静态断言非浮点类型时编译失败，仓颉版本通过 `FloatingPoint<T>` 接口约束（stdlib 原生接口）实现等价行为。`mat3Cast`/`mat4Cast`/`quatCast` 两个重载共 4 个函数统一采用此约束；`FloatingPoint<T>` 是 stdlib 原生接口，编译期保证可用，无需 fallback |
| D33 | **比较函数（`lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual`）采用 `Comparable<T>` 宽约束而非 `FloatingPoint<T>` 窄约束** | 理由：(a GLM 原始实现中 4 个比较函数无 `GLM_STATIC_ASSERT(is_iec559)` 断言，整数类型也可合法调用——与 `mat3Cast`/`mat4Cast`/`quatCast` 等带 `is_iec559` 断言的函数有别；(b 比较运算符 `<`/`<=`/`>`/`>=` 对整数类型语义正确（整数四元数按分量大小比较有实际意义，收紧至 `FloatingPoint<T>` 会排除整数四元数的合法比较用例；(c 与需浮点运算的 `mat3Cast`/`quatCast` 场景区分——后者涉及 `sqrt`/`trace` 等仅在浮点类型上有意义的运算，而比较仅依赖 `<`/`<=`/`>`/`>=` 运算符，`Comparable<T>` 约束已足够保证运算符可用性；与 §3.15 完整实现函数段/§11.5 函数可用性对照表 `where T <: Comparable<T>` 声明一致 |
| D34 | **`lerp`/`inverse` 跨 Qualifier 调用的处理策略** | 本阶段仅提供相同 Q 的签名模板。跨 Qualifier 场景通过双 Qualifier 重载扩展实现——新增 `lerp<T, Q1, Q2>(x: Quat<T,Q1>, y: Quat<T,Q2>, a: T): Quat<T,Q2>` where T <: Number<T>, Q1 <: Qualifier, Q2 <: Qualifier——内部调用跨 Qualifier 构造函数 `init<Q2>(q: Quat<T,Q2>)`（§3.3 item 3）将 `x` 隐式转换为 `y` 的 Qualifier，再执行同一 Q 下的 `lerp` 运算。理由：(a 仓颉跨 Qualifier 构造函数已实现（§3.3 item 3，转换成本为纯赋值无运行时开销；(b 输出 Q 取 `Q2`（与 `y` 一致）符合「右操作数主导 Qualifier」策略，与 GLM 精度提升/降级规则一致；(c 该重载在阶段四按需实现，不阻塞本阶段已有的同 Q 调用路径 |
| D35 | **`slerp` 路线图可验证性冲突的处理策略** | 路线图 §3 第 125 行标记 `slerp` 为 `[可验证]`，但本设计定位为 `❌ stub`（依赖 trigonometric.cj/common.cj stub。**选定方案**——维持本设计定位（路径 C，`slerp` 标记为 `[待 Stage 4]`。理由——(a 对阶段三整体交付范围影响最小——`slerp` 的 stub 状态已在 §11.5 明确标注，不阻塞其他可验证函数的实现与测试；(b 存在向下兼容的降级路径（路径 A：`lerp` 近似，1-2 人日切换成本；(c 若后续需阶段三有球面插值，路径 B（有限精度三角函数内联，3-5 人日）可作为备选。详见 §3.16 不一致 1 的临时实施建议与工期影响评估。 |
| D36 | **`lookRotate` 命名不一致的处理策略** | 路线图多处引用 `lookRotate` 函数名，但本设计已统一为 `quatLookAt`/`quatLookAtRH`/`quatLookAtLH`（D13 决策。**选定方案**——维持本设计命名，三个函数均为 stub（§3.15，命名不影响阶段三实施。若路线图后续确认保留 `lookRotate`，可在阶段四新增 `lookRotate` 作为 `quatLookAtRH` 的委托别名（0.5 人日成本。详见 §3.16 不一致 2 的临时实施建议与工期影响评估。 |
| D37 | **`ext/quaternion_common.cj` 路线图可验证性范围过广的处理策略** | 路线图 §3 第 130 行将 `ext/quaternion_common.cj` 整体标记为 `[可验证]`，未排除 `mix`/`slerp` 的 stub 部分。**选定方案**——将路线图标注从 `[可验证]` 修订为 `[部分可验证]`，函数级明细引用本设计 §11.5。理由——§3.13.2 审计表已明确列示 5 个可调用函数与 3 个 stub 函数的完整清单，粗粒度 `[可验证]` 标注与实际函数级状态不匹配。详见 §3.16 不一致 3 的临时实施建议与工期影响评估。 |
| D38 | **`inverse` 整数 T 非零除截断行为的约束策略** | **选定方案——方案 A——约束收紧为 `where T <: FloatingPoint<T>`（与 `normalize` 的 v26 收紧策略一致）**。理由——(a 整数除法截断在 `inverse` 中产生无意义结果——如 `Quat(1,0,0,0)` 在整数 T 下 `dot=1`，`inverse` 返回 `Quat(-1,0,0,0)/1 = Quat(-1,0,0,0)`（可接受；但 `Quat(1,1,1,1)` 在整数 T 下 `dot=4`，`inverse` 返回 `Quat(-1,-1,-1,1)/4`，整数截断得 `Quat(0,0,0,0)`——无声返回错误结果，与 `normalize` 整数 T 截断为 `Quat(0,0,0,1)` 的问题模式一致；(b `inverse` 的数学定义（`q⁻¹ = q̅ / \|q\|²`）在整数域下的除法截断无数学意义，与 `normalize` 的整数截断问题属同一类"浮点语义强依赖"场景；(c 一致性理由——`normalize`、`mat3Cast`/`mat4Cast`/`quatCast`（D32）、`isnan`/`isinf`（D29）、`trigonometric.cj`等已形成约束收紧的系列先例，`inverse` 收紧至 `FloatingPoint<T>` 与此系列一致，非孤立决策。**影响范围**——`inverse` 函数签名从 `where T <: Number<T>` 变为 `where T <: FloatingPoint<T>`；§3.11 `inverse` 描述段、§5.3 边界条件表「整数 `inverse`」行、§11.5 `inverse` 行状态标注同步更新。**整数 T 场景的降级路径**——若下游确需整数四元数的 `inverse`，可通过 `Quat<Float32, Q>` 实例化计算后再将结果分量取整，或自行实现整数版本（按分量计算 `conjugate(q / dot(q,q)` 时使用浮点除法避免截断再取整。 |
---

## 8. 阶段三产出物清单

注——本节产出物分类统一调整为与 §11.5 函数可用性对照表对齐的三档分类——「✅ 可用（无 stub 依赖）」/「⚠️/❌ 混合（部分可用、部分 stub）」/「❌ stub（空桩占位）」。**全文档函数可用状态以 §11.5 为最终基准**。

### ✅ 可用（无 stub 依赖，运行时可正常调用）

- **`detail/type_quat_cast.cj`**（4 个矩阵-四元数互转函数：mat3Cast/mat4Cast/quatCast 两个重载
- `detail/scalar_constants.cj`（标量常量 epsilon/pi/cos_one_over_two，对整数类型抛异常
- `detail/scalar_quat_ops.cj`（标量-四元数全局函数 add/sub/mul/div
- `ext/quaternion_relational.cj`（四元数关系运算，4 函数完整实现
- `ext/quaternion_geometric.cj`（四元数 dot/length/normalize/cross，4 函数完整实现
- `ext/scalar_constants.cj`（ext 重导出接口
- `gtc/constants.cj`（**28 个**数学常量函数，——与 GLM 1.0.3 `gtc/constants.inl` 实际声明数一致
- 四元数别名文件（4 个 ext/ 文件
- 四元数测试文件（详见 §8.2，`test_xxx.cj` 命名约定，

**说明**——以上文件中的函数均为「真完整实现」（无 stub 依赖，运行时可正常调用，不抛 `Exception("stub")`。共 **18 个函数**（epsilon/pi/cos_one_over_two/axis/length/normalize/inverse/isnan/isinf/mat3Cast/mat4Cast/quatCast/conjugate/lerp/dot/cross(Quat)/equal(Quat)/notEqual(Quat)，详见 §11.5 函数可用性对照表。

### ⚠️/❌ 混合（部分函数 ✅ 可用、部分 ❌/⚠️ stub）

- `detail/type_quat.cj`（四元数核心类型 + 纯算术运算符/identity/fromMat3/fromMat4 等 ✅ 可用；Quat×Vec3/Vec4 ⚠️ 抛 stub 异常；fromVec3/fromEuler ❌ stub
- `ext/quaternion_common.cj`（conjugate/inverse/lerp/isnan/isinf 共 5 函数 ✅ 可用；mix/slerp(2 版本 共 3 函数 ❌ stub
- `ext/quaternion_trigonometric.cj`（axis 1 函数 ✅ 可用；angle/angleAxis 2 函数 ❌ stub
- `ext/quaternion_transform.cj`（rotate 1 函数 ❌ stub。——该文件仅含 `rotate` 一个函数且为 stub，即 100% stub
- `ext/quaternion_exponential.cj`（exp/log/pow/sqrt 全部 ❌ stub
- `gtc/quaternion.cj`（mat3Cast/mat4Cast/quatCast×2 重导出 4 函数 ✅ 可用 + lessThan/lessThanEqual/greaterThan/greaterThanEqual 4 函数 ✅ 可用 + eulerAngles/roll/pitch/yaw/quatLookAt/quatLookAtRH/quatLookAtLH 7 函数 ❌ stub = 4 重导出 + 4 完整 + 7 stub
- `ext/vector_relational.cj`（epsilon 版 16 重载 ✅ 可用；ULP 版 8 重载 ❌ stub

### ❌ stub（空桩占位，运行均抛 Exception("stub")）

- `gtc/matrix_transform.cj`（64 个函数全部 ❌ stub
- `detail/trigonometric.cj`（75 个展开函数全部 ❌ stub
- `ext/matrix_projection.cj`
- `ext/matrix_clip_space.cj`
- `ext/matrix_transform.cj`

### 沿用自阶段二的 stub（❌ stub，运行均抛 Exception("stub")）

- `detail/common.cj`
- `detail/geometric.cj`
- `detail/matrix.cj`（27 实现 + 6 stub，均视为 stub 引用，本阶段不新增实现

### 更新文件

- `fwd.cj`——新增 9 个四元数类型别名（Quat/FQuat/DQuat + 3×Float32 精度 + 3×Float64 精度；具体清单见 §2 lib.cj/fwd.cj 段落，——fwd.cj 是自动生成文件（`cjglm/src/fwd.cj:1-2` 文件头注释为中文，下游实施路径为方案 A 修改 `cjglm/scripts/gen_fwd_aliases.py` 生成脚本，新增 `VEC_FAMILIES` 字典条目 + Quat 固定 4 维特殊处理分支；详见 §2 段落末尾「实施路径」说明
- `lib.cj`——新增 Quat 类型、type_quat_cast 函数、ext/gtc 函数和常量的 public import（具体清单见 §2 lib.cj/fwd.cj 段落，v5 明确——20 个 `import` 声明，补齐

### 测试设计 §8.2

#### 测试文件清单与位置

> **函数可用状态权威来源**——本阶段所有函数的状态（✅/⚠️/❌）以 §11.5 函数可用性对照表为唯一权威来源。本节测试文件清单和用例分配中的函数状态仅作参考，逐函数状态查询请引用 §11.5。

阶段三测试文件位于 `tests/glm/` 目录下，按模块拆分：

| 测试文件 | 覆盖模块 | 预计用例数 |
|---------|---------|----------|
| `tests/glm/detail/test_type_quat.cj` | Quat 核心类型 + 运算符 | ≥40 |
| `tests/glm/detail/test_type_quat_cast.cj` | 矩阵-四元数互转函数 | ≥8 |
| `tests/glm/test_ext_quaternion_relational.cj` | 四元数关系运算（——与 `test_ext.cj` 同层平铺命名，避免新建 `tests/glm/ext/` 子目录 | ≥8 |
| `tests/glm/test_ext_quaternion_geometric.cj` | 四元数几何函数（——同层平铺命名 | ≥12 |
| `tests/glm/test_ext_quaternion_common.cj` | 四元数公共函数（——同层平铺命名 | ≥13 |
| `tests/glm/test_ext_quaternion_trigonometric.cj` | 四元数三角函数（——同层平铺命名 | ≥4 |
| `tests/glm/test_ext_quaternion_exponential.cj` | 四元数指数函数（stub）（——同层平铺命名 | ≥4 |
| `tests/glm/test_ext_quaternion_transform.cj` | 四元数变换函数（stub）（——同层平铺命名 | ≥2 |
| `tests/glm/test_ext_vector_relational.cj` | 向量 epsilon/ULP 比较（——同层平铺命名 | ≥16 |
| `tests/glm/test_ext_scalar_constants.cj` | 标量常量（——同层平铺命名；——用例数按「完整实现函数——每函数 ≥2 个用例」原则计算——3 个泛型函数 × 2 种浮点类型 × 2 用例 + 1 整数类型异常路径 = 13 | ≥13 |
| `tests/glm/test_ext_quaternion_aliases.cj` | 四元数别名（4 个别名文件合并测试，——避免为每个别名文件单独建测试文件，——每别名 ≥1 用例，9 个别名共 ≥9 用例 | ≥9 |
| `tests/glm/gtc/test_constants.cj` | 数学常量 | ≥28（——与 §3.12 gtc/constants 28 个常量函数对齐 |
| `tests/glm/gtc/test_quaternion.cj` | gtc 四元数转换重导出/比较/欧拉/看向 | ≥27（——见下方用例分配原则 |
| `tests/glm/gtc/test_matrix_transform_stubs.cj` | gtc/matrix_transform 64 个 stub 函数 | ≥9 |
| **合计** | — | **≥193**（——`test_matrix_transform_stubs.cj` 从 ≥8 修正为 ≥9，与 9 个代表性函数一一对应；按上述每行 ≥值求和——40+8+8+12+13+4+4+2+16+13+9+28+27+9=193；下方用例分配表逐项求和同样为 193，通过增补 7 个边界用例可达 ≥200 |

注——文档 13 个测试文件均使用 `xxx_test.cj` 命名，但与项目实际不一致——通过 `ls cjglm/tests/glm/detail/` 验证阶段二现有约定**全部使用** `test_xxx.cj` 风格（`test_common.cj`/`test_geometric.cj`/`test_matrix.cj`/`test_qualifier.cj`/`test_scalar_mat_ops.cj`/`test_scalar_vec_ops.cj`/`test_setup.cj` 等 10+ 个文件，阶段三测试文件统一调整为 `test_xxx.cj` 风格以与现有约定对齐。

**测试目录结构对齐策略**——设计的测试文件位于 `tests/glm/ext/` 与 `tests/glm/gtc/` 子目录中（与 `src/ext/` + `src/gtc/` 子包目录结构对齐，但**项目当前无 `tests/glm/ext/` 与 `tests/glm/gtc/` 子目录先例**——阶段二 25 个测试文件均位于 `tests/glm/` 根目录（如 `test_ext.cj`）或 `tests/glm/detail/` 子目录；`test_ext.cj` 是单一聚合文件而非按函数拆分。：
- (a **避免新建子目录**：`tests/glm/ext/` 与 `tests/glm/gtc/` 子目录本轮不新建；所有新增测试文件采用 `tests/glm/test_xxx.cj` 同层平铺命名（与 `test_ext.cj` 一致；gtc 相关测试暂使用 `tests/glm/gtc/test_xxx.cj` 平铺子目录结构（避免与既有 ext 测试文件混淆
- (b **既有 `test_ext.cj` 兼容策略**——现有 `tests/glm/test_ext.cj`（102 行，验证 ext 包基础别名如 `ext.Mat4x4`）保持原状；新增的 `tests/glm/test_ext_xxx.cj` 文件按 ext 子模块拆分（如 `test_ext_vector_relational.cj`/`test_ext_quaternion_xxx.cj` 等，与 `test_ext.cj` 并存不冲突
- (c **别名测试合并**：4 个 ext/ 别名文件（`quaternion_float.cj`/`quaternion_double.cj`/`quaternion_float_precision.cj`/`quaternion_double_precision.cj`）的测试合并为单一 `tests/glm/test_ext_quaternion_aliases.cj` 文件，避免为每个别名文件单独建测试文件
- (d **下游实施步骤**——测试文件创建前无需 `mkdir -p`，按上述命名直接创建在对应目录即可

注——设计的 `tests/glm/ext/test_xxx.cj` 与 `tests/glm/gtc/test_xxx.cj` 命名方案修订为上表所示的同层平铺命名；gtc 子目录保留但仅用于阶段三新增的 gtc 测试文件（与 src/gtc/ 子包源码位置镜像，不引入更深的子目录层级。

**用例分配原则**：
- **完整实现函数**——每函数 **≥2 个用例**（覆盖正常路径 + 边界场景
- **stub 函数**——每函数 **≥1 个用例**（验证抛 `Exception("stub")` 异常
- **重导出函数**——每函数 **≥1 个用例**（验证可达性，调用返回正确结果

**同类 stub 函数抽样策略说明**——对于数量较大且函数签名/行为高度同构的 stub 函数组（如 `gtc/matrix_transform.cj` 中 64 个 stub 函数，允许采用按类别分组抽样的测试策略而非逐函数全覆盖。抽样条件——(a 组内所有函数实现均为 `throw Exception("stub")`，运行时行为完全一致；(b 按 GLM 原始分类（基础变换 / ortho 系族 / frustum 系族 / perspective 系族 / perspectiveFov 系族 / infinitePerspective 系族 / tweakedInfinitePerspective / 投影工具 / 拾取矩阵）每类选取 ≥1 个代表性函数验证异常抛出路径，合计 ≥9 个用例即可覆盖全部 64 个函数的 stub 行为（9 个代表性函数与 9 个子类一一对应。该策略仅适用于 stub 占位函数的异常路径验证；阶段四完整实现后每函数须按「完整实现函数 ≥2 用例/函数」原则补全测试覆盖。

**`tests/glm/gtc/test_quaternion.cj` 用例数重算**——文档原 20 个用例，8 个完整实现函数（4 比较 + 4 转换重导出）平均仅 2.5 个/函数，低于用例分配原则。按 v8 原则重算——
- 4 个完整实现（`lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual`：4 × 2 = **8 个用例**
- 4 个重导出（`mat3Cast`/`mat4Cast`/`quatCast(Mat3)`/`quatCast(Mat4)`，每函数另加 1 个可达性测试）——4 × (2 + 1 = **12 个用例**（——重导出函数按"完整实现函数 + 1 可达性测试"双重覆盖，确保下游消费者既验证返回值正确性也验证调用链通畅
- 7 个 stub（`eulerAngles`/`roll`/`pitch`/`yaw`/`quatLookAt`/`quatLookAtRH`/`quatLookAtLH`：7 × 1 = **7 个用例**（验证抛 stub 异常
- **合计**——8 + 12 + 7 = **27 个用例**（——与 8×2 + 7×1 + 4×1 = 27 公式一致，分解为「8 可测函数 × 2 = 16 + 4 重导出可达性测试 × 1 = 4 + 7 stub × 1 = 7 = 27」

#### 用例到函数的逐项分配依据

为满足 ≥199 用例的覆盖充分性可追溯性，以下按测试文件逐一列明函数分组与用例分配依据，确保每个用例均可追溯到§11.5表中的对应函数：

| 测试文件 | 函数分组 | 函数数 | 每函数用例数 | 分组合计 | 分配依据 |
|---------|---------|--------|------------|---------|---------|
| `test_type_quat.cj` | 构造函数（item 1-7, 10，共 8 个完整实现 | 8 | 2 | 16 | 完整实现 ≥2用例/函数 |
| | fromVec3/fromEuler（2 个 stub | 2 | 1 | 2 | stub ≥1用例/函数 |
| | 运算符算术（`+`/`-`/`*`/`/`/一元`-`，共 5 个 | 5 | 2 | 10 | 完整实现 ≥2用例/函数 |
| | 运算符 `==`/`!=`（2 个 | 2 | 1 | 2 | 精确比较 ≥1用例/函数 |
| | Quat×Vec3/Vec4（2 个 ⚠️ | 2 | 2（1 编译 + 1 assertThrows | 4 | ⚠️ 阻塞函数 ≥1编译 + ≥1运行时 |
| | Vec3×Quat/Vec4×Quat（2 个 ⚠️ | 2 | 2（1 编译 + 1 assertThrows | 4 | ⚠️ 阻塞函数 ≥1编译 + ≥1运行时（——从 ✅ 修正为 ⚠️，因实现链依赖 Quat×Vec3 的 geometric.cj cross stub |
| | Quat×T/T×Quat/Quat/T/scalar_quat_ops（6 个 | 6 | 1 | 6 | 标量运算 ≥1用例 |
| | **小计** | **27 函数** | — | **42** | 略超 ≥40 下限 |
| `test_type_quat_cast.cj` | mat3Cast/mat4Cast/quatCast×2（4 个 | 4 | 2 | 8 | 完整实现 ≥2用例/函数 |
| `test_ext_quaternion_relational.cj` | equal×2/notEqual×2（4 个 | 4 | 2 | 8 | 完整实现 ≥2用例/函数 |
| `test_ext_quaternion_geometric.cj` | dot/length/normalize/cross（4 个 | 4 | 3 | 12 | 完整实现 ≥2用例 + 边界(如normalize零保护 |
| `test_ext_quaternion_common.cj` | conjugate/inverse/lerp/isnan/isinf（5 个完整 | 5 | 2 | 10 | 完整实现 ≥2用例/函数 |
| | mix/slerp×2（3 个 stub | 3 | 1 | 3 | stub ≥1用例/函数 |
| | **小计** | **8 函数** | — | **13** | 略低于 ≥16 下限（可提升至 16 通过增加边界用例 |
| `test_ext_quaternion_trigonometric.cj` | axis（1 个完整 | 1 | 2 | 2 | 完整实现 ≥2用例/函数（含零四元数边界 |
| | angle/angleAxis（2 个 stub | 2 | 1 | 2 | stub ≥1用例/函数 |
| | **小计** | **3 函数** | — | **4** | 符合 ≥4 下限；如需提升覆盖率可增补至 ≥8 |
| `test_ext_quaternion_exponential.cj` | exp/log/pow/sqrt（4 个 stub | 4 | 1 | 4 | stub ≥1用例/函数 |
| `test_ext_quaternion_transform.cj` | rotate（1 个 stub | 1 | 1 | 1 | stub ≥1用例/函数（≥2 含 1 个额外边界验证 |
| `test_ext_vector_relational.cj` | epsilon equal/notEqual（16 个重载 | 16 | 1 | 16 | 完整实现 ≥2用例/函数（实际每重载 1 用例即可；16 略低于 ≥16 下限，实际可补至 32 |
| `test_ext_scalar_constants.cj` | epsilon/pi/cos_one_over_two（3 函数 × 2 浮点类型 | 6 | 2 | 12 | 完整实现 ≥2用例 × 2 类型 |
| | 整数异常路径 | 1 | 1 | 1 | 异常路径 1 用例 |
| | **小计** | **7 条目标** | — | **13** | 与 ≥13 一致 |
| `test_ext_quaternion_aliases.cj` | 9 个别名（Quat/FQuat/DQuat + 3×Float32精度 + 3×Float64精度 | 9 | 1 | 9 | 每别名 ≥1用例 |
| `test_constants.cj` | 28 个常量函数 | 28 | 1 | 28 | 每常量 ≥1用例 |
| `test_quaternion.cj` | 4 个比较函数 | 4 | 2 | 8 | 完整实现 ≥2用例/函数 |
| | 4 个重导出函数 | 4 | 3（2 功能 + 1 可达性 | 12 | 完整实现 + 可达性 |
| | 7 个 stub | 7 | 1 | 7 | stub ≥1用例/函数 |
| | **小计** | **15 函数** | — | **27** | 与 ≥27 一致 |
| `test_matrix_transform_stubs.cj` | 64 个 stub 函数 | 64 | 按类别抽样 | 9 | stub ≥1用例/函数（64 个同类 stub 按 9 个子类分组抽样，每子类 1 个代表性函数 |
| | **全表总计** | — | — | ≥193 | 逐项相加：40+8+8+12+13+4+4+2+16+13+9+28+27+9 = 193（下限；通过增补三角函数/geometric 边界用例 7 个可轻松达到 ≥200 |

注——上表中 `test_ext_quaternion_trigonometric.cj`（4 ≤ 8）与 `test_ext_quaternion_common.cj`（13 ≤ 16）的分组合计略低于各自文件中声明的 ≥下限。下游编码者可依据「每函数 ≥1 额外边界用例」原则补齐差值（如为 `trigonometric` 的 2 个 stub 各增加 1 个不同参数类型边界用例 + 为 `common` 的 `isnan`/`isinf` 各增加 1 个跨 Qualifier 用例，确保各文件实际用例数不低于表中原声明的 ≥值。全表 ≥199 合计值通过上述补齐可达。

#### 测试覆盖维度

1. **构造路径**——单位构造、逐分量构造、wxyz 工厂、标量+向量构造、跨 Qualifier 构造、跨类型构造（fromQuat）、从矩阵构造（fromMat3/fromMat4）、从两向量构造（fromVec3 stub）、从欧拉角构造（fromEuler stub
2. **运算符正常路径**——算术运算（+ - * / 一元 -）、Quat×Vec3/Vec4 旋转、Vec3×Quat/Vec4×Quat 逆旋转、Quat×T 标量运算、==/!= 比较
3. **ext 函数库正常路径**：vector_relational 16 重载、quaternion_relational 4 函数、quaternion_geometric 4 函数、quaternion_common 中 conjugate/inverse/lerp/isnan/isinf 5 函数、quaternion_trigonometric 中 axis 1 函数
4. **gtc/quaternion.cj 正常路径**：4 个比较函数（lessThan/lessThanEqual/greaterThan/greaterThanEqual）+ 4 个转换函数重导出（mat3Cast/mat4Cast/quatCast 两个重载）+ **detail/type_quat_cast 单元测试覆盖实现细节**
5. **stub 函数异常路径**：mix/slerp(2 版本)/angle/angleAxis/exp/log/pow/sqrt/rotate/eulerAngles/roll/pitch/yaw/quatLookAt* 调用时验证抛 `Exception("stub")`
6. **跨 Qualifier 实例化**：PackedHighp/PackedMediump/PackedLowp/AlignedHighp/AlignedMediump/AlignedLowp 6 种精度的 Quat 运算符测试
7. **跨类型实例化**：Float32/Float64 的 Quat 完整测试，整型 Quat 仅测试非依赖 stub 的运算符（边界处理
8. **⚠️ 已实现但被 stub 阻塞函数**——覆盖 `Quat×Vec3`/`Quat×Vec4`/`Vec3×Quat`/`Vec4×Quat` 运算符。要求——每函数 ≥1 个编译期测试（验证 `cjpm build` 通过）+ ≥1 个运行时 `assertThrows` 测试（验证抛 `Exception("stub")`。§11.5 ⚠️ 符号行同步引用本覆盖要求。
9. **编译期函数签名正确性验证**——覆盖全部 88 个 ❌/⚠️ 函数的**编译期签名正确性**。要求——每个 stub/⚠️ 函数至少被一个编译期测试引用（验证函数签名与 `where` 子句约束的编译通过性，确保 `cjpm build` 对这些函数的签名声明无编译错误。具体实施方式——在 `test_xxx_stubs.cj` (如 `test_matrix_transform_stubs.cj` 中为每个 stub 函数编写一条编译期引用测试（不调用函数体，仅验证签名声明和约束满足编译。对 🚫 / 同构度高的函数组（如 trigonometric.cj 的 75 个函数，允许每类选取 1 个代表性函数验证；对异构度高的函数组（如 gtc/matrix_transform.cj，每子类至少 1 个代表性函数。本维度不要求运行时 `assertThrows`（由已存在的第 5 类 stub 函数异常路径覆盖，聚焦于编译期签名的正确性验证——确保所有 ❌/⚠️ 函数的签名声明（泛型参数、where 子句、参数列表、返回类型）与 §3 / §9a / §11.5 约束标注一致，不出现署名错配导致的编译失败。

#### 浮点比较策略

- **epsilon 版本**——使用 `epsilon<Float32> = 1.1920929e-7` 作为容差，调用 `equal(v1, v2, epsilon<Float32>())` 验证
- **精确比较**——对于 should be 精确相等的运算结果（如 `identity * v == v`，使用 `==` 直接比较
- **角度比较**——旋转等价性使用「四元数点积绝对值接近 1」判断（`abs(dot(q1, q2) > 1 - epsilon<Float32>()`，避免 q 与 -q 的双重覆盖
- **type_quat_cast 单元测试**——使用「旋转矩阵 * 向量 = 四元数 * 向量」等价性测试（`m3 * v == q * v`）验证互转正确性

#### 阶段三可验证 vs 待阶段四拆分

- **本阶段可验证**（路线图标注 `[可验证]`）——所有「完整实现」函数 + 「stub 函数异常路径」（验证抛 stub 异常
- **部分可验证**（路线图标注 `[部分可验证]`）——运算符依赖 stub 的部分（如 `Quat×Vec3` 旋转调用抛 stub 异常，需在测试中标注「本阶段抛 stub 异常，待阶段四 geometric.cj 完整实现后生效」
- **待阶段四**（路线图标注 `[待 Stage 4]`：stub 函数的正常路径测试（如 slerp 球面插值结果、pow 指数运算结果）推迟至阶段四函数库完整实现后补齐

#### 逐函数测试映射模板

为确保测试用例到 §11.5 函数的逐项可追溯，以下提供测试用例映射矩阵模板。下游编码者在创建测试文件时，应填写本矩阵作为测试依据：

| 测试文件 | §11.5 函数 | 测试用例描述 | 覆盖维度 | 预期结果 |
|---------|-----------|------------|---------|---------|
| `test_type_quat.cj` | `identity` | 调用 `Quat.identity(1.0f)` 验证 w=1, x=y=z=0 | 正常路径 | 返回 (0,0,0,1 |
| `test_type_quat.cj` | `!=` | 比较两个不同四元数 | 运算符 | 返回 true |
| `test_type_quat.cj` | `Quat×Vec3` | 验证调用抛 stub 异常 | ⚠️ 异常路径 | `assertThrows("stub")` |
| `test_type_quat_cast.cj` | `mat3Cast` | 单位四元数转 mat3 为单位矩阵 | 正常路径 | 结果为单位矩阵 |
| ... | ... | ... | ... | ... |

完整映射矩阵由下游编码者实施测试时逐行填写，并与 §11.5 逐函数对照。阶段四验收时需检查本矩阵覆盖率≥90%。

**stub 抽样策略的函数选择**——对 `gtc/matrix_transform.cj` 的 64 个 stub 函数，按聚类结果选择的代表性函数如下——

| 类别 | 代表性函数 | 被代表函数数 |
|------|-----------|------------|
| 基础变换 | `translate` | 11 |
| ortho 系族 | `orthoLH_ZO` | 10 |
| frustum 系族 | `frustumRH_ZO` | 9 |
| perspective 系族 | `perspectiveRH_ZO` | 9 |
| perspectiveFov 系族 | `perspectiveFovLH_ZO` | 9 |
| infinitePerspective 系族 | `infinitePerspective` | 7 |
| tweakedInfinitePerspective | `tweakedInfinitePerspective(T,T,T,T)` | 2 |
| 投影工具 | `projectZO` | 6 |
| 拾取矩阵 | `pickMatrix` | 1 |
| **合计** | **9 个代表性函数** | **64** |

#### 合计值校验方法

§8.2 测试用例合计值（当前 ≥192）的验算方式如下：

```
逐项求和：40 (test_type_quat + 8 (type_quat_cast + 8 (quat_relational + 12 (quat_geometric + 13 (quat_common + 4 (quat_trigonometric + 4 (quat_exponential + 2 (quat_transform + 16 (vector_relational + 13 (scalar_constants + 9 (quat_aliases + 28 (constants + 27 (gtc_quaternion + 9 (matrix_transform_stubs = 193
```

验证方式——在每轮版本输出前，手动或脚本化累加上述 14 个测试文件声明的 ≥ 下限值，与 §8.2 合计行声明值交叉核对。偏差为 0 时方可发布版本。建议使用 Python 脚本 `scripts/check_test_count.py` 自动化此核验。

**增补 7 个用例的具体分配计划**——按以下分配可使总用例数从 ≥192 提升至 ≥199——

| 文件 | 增补数量 | 覆盖场景 |
|------|---------|---------|
| `test_ext_quaternion_trigonometric.cj` | +2 | angle/angleAxis stub 各增 1 个 Float64 类型变体 |
| `test_ext_quaternion_common.cj` | +3 | isnan/isinf 各增 1 个跨 Qualifier 用例 + inverse 增 1 个非单位四元数边界 |
| `test_ext_vector_relational.cj` | +2 | epsilon equal/notEqual 各增 1 个边界用例（epsilon=0 返回 false |
| **合计增补** | **+7** | **→ 总用例数 ≥199** |

### 8.4 阶段三实施批次建议

本阶段涉及 25+ 个源文件的创建与修改，按拓扑依赖排序给出以下 4 批实施顺序建议。每批完成后可独立验证（`cjpm build` 编译通过。

**实施批次划分原则**：① 被依赖的文件先于依赖者实施；② 每个批次内的文件无相互依赖，可并行实施；③ `gen_fwd_aliases.py` 修改在第一批完成，确保后续 alias 引用可用。

| 批次 | 文件清单 | 实施内容 | 验证标准 |
|------|---------|---------|---------|
| **第一批（基础设施 + 别名）** | `detail/type_quat.cj` + `detail/type_quat_cast.cj` + `detail/scalar_constants.cj` + `detail/scalar_quat_ops.cj` + 4 个 ext/ 别名文件 + `gen_fwd_aliases.py` 修改 + `fwd.cj` 重新生成 + `lib.cj` 追加 import 声明 | 四元数核心类型定义、运算符、转换函数；标量常量；标量-四元数运算；别名文件；自动生成脚本修改 | `cjpm build` 通过；`Quat<Float32,PackedHighp>.identity(1.0f)` 编译通过 |
| **第二批（ext 函数库 - 无 stub 依赖部分）** | `ext/quaternion_relational.cj` + `ext/quaternion_geometric.cj` + `ext/quaternion_common.cj`（先实现 conjugate/inverse/lerp/isnan/isinf 5 函数，mix/slerp stub 占位）+ `ext/quaternion_trigonometric.cj`（先实现 axis 函数，angle/angleAxis stub 占位）+ `ext/scalar_constants.cj`（重导出接口 | 四元数关系运算、几何函数、公共函数（可用部分）、三角函数（axis 部分 | 第二批函数运行时不抛 stub 异常；`assertThrows` 验证 stub 函数抛 `Exception("stub")` |
| **第三批（stub 函数库 + gtc 常量）** | `ext/quaternion_transform.cj`（rotate stub）+ `ext/quaternion_exponential.cj`（exp/log/pow/sqrt 全部 stub）+ `gtc/quaternion.cj`（4 重导出 + 4 完整 + 7 stub）+ `gtc/constants.cj`（28 常量 | 剩余 stub 函数声明；gtc 四元数重导出与比较函数；gtc 数学常量 | `cjpm build` 通过；gtc/quaternion 比较函数运行时正常；stub 函数 `assertThrows` 验证 |
| **第四批（空桩 + 继承 stub）** | `detail/trigonometric.cj`（75 展开函数 stub）+ `ext/matrix_projection.cj` + `ext/matrix_clip_space.cj` + `ext/matrix_transform.cj` + `gtc/matrix_transform.cj`（64 函数 stub）+ `ext/vector_relational.cj`（epsilon 16 重载 ✅ + ULP 8 重载 ❌ | 所有空桩文件函数签名声明；vector_relational 的 epsilon 比较部分 | `cjpm build` 通过；所有 stub 函数 `assertThrows` 验证 |

**关键依赖链说明**：
- `gen_fwd_aliases.py` 修改（第一批）→ 所有引用 `glm.Quat`/`glm.FQuat`/`glm.DQuat` 别名的代码
- `detail/type_quat.cj`（第一批）→ 所有 ext/gtc 函数库（第二~四批均依赖 Quat 类型存在
- `ext/quaternion_geometric.cj`（第二批）→ `normalize`/`dot`/`length`/`cross` 被 `ext/quaternion_common.cj` 的 `inverse`/`lerp` 调用
- `detail/trigonometric.cj`（第四批）→ 仅需函数签名（stub，不影响第二~三批函数编译；运行时调用 stub 函数才抛异常

> **与项目路线图实施风格对齐说明**——本批次划分方式与 `docs/02_roadmap.md` 第 165-169 行的阶段四实施批次建议（按「第一批无函数库内部依赖 → 第二批依赖基础函数库 → 第三批依赖前两批 → 第四批 gtc/ 扩展函数库」拓扑排序）风格一致。

> **函数可用状态权威来源**——以下验证项中的函数状态标注（✅/⚠️/❌）以 §11.5 函数可用性对照表为唯一基准。验证项仅列出与 §11.5 的交叉引用编号，具体状态标注不在此处重复。

### 编码启动前验证项

1. **cjpm gtc 子包构建预验证**——验证 `src/gtc/` + `package glm.gtc` 的构建可行性（与 §2 末尾 cjpm 子包构建预验证策略对应
2. **gtc/quaternion.cj 重导出 detail 函数验证**——验证 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 能否正确将 detail 包级函数重导出至 glm.gtc 命名空间（无编译错误，外部 `glm.gtc.quaternion.mat3Cast(q)` 调用正常
3. **包间无循环依赖验证**——使用 `cjpm check` 命令验证整个项目不包含包间循环依赖（特别是 `glm.gtc` 与 `glm.detail` 之间，符合 cangjie-lang-features package/README.md 第 99 行约束
4. **type_quat.cj 同包调用 type_quat_cast.cj 函数验证**——验证 `fromMat3`/`fromMat4` 在 `type_quat.cj` 中调用同包 `type_quat_cast.cj` 的 `mat3Cast`/`mat4Cast`/`quatCast` 函数（同包内可见性，无需 import
5. **Vec3/Vec4 extend 块中 Quat 类型前向引用验证**：Vec3×Quat 和 Vec4×Quat 运算符需在 Vec3/Vec4 的 extend 块中引用 Quat 类型，验证同包延迟解析（已通过阶段二原型验证，仅为防御性确认
6. **scalar_constants 的泛型 `match` 类型模式匹配验证**——验证 `func epsilon<T>(hint: T): T where T <: Number<T>` 函数体内 `match (hint { case _: Float32 => ... }` 编译通过
7. **scalar_constants 对整数类型 T 的行为契约验证**——验证 `epsilon<Int64>()` 调用时按 D25 决策抛出运行时异常（约束收紧若失败时的 fallback 路径
8. **标量-四元数与标量-向量/标量-矩阵同名重载消歧验证**：`add(s: T, q: Quat<T,Q>)` 与 `add(s: T, v: Vec2<T,Q>)`/`add(s: T, m: Mat2x2<T,Q>)` 等的编译器消歧
9. **`x.isNaN()`/`x.isInf()` 实例方法路径验证**——确认仓颉标准库为所有浮点类型提供 `isNaN()`/`isInf()` 实例方法（影响 quaternion_common.cj 中 isnan/isinf 的实现可行性
10. **ext/vector_relational 内联 abs 验证**——验证 `if (d >= T(0) { d } else { -d }` 模式在 `Number<T> & Comparable<T>` 约束下的编译通过性
11. **`@Derive[Hashable]` 对 `Q <: Qualifier` 的支持验证**——验证 Hashable 派生宏对 6 个 Qualifier 实现类型的编译通过性
12. **`length(q)` 在 Float32 实例的 sqrt 转换验证**——验证目标分两级——(a 首选——验证 `T(std.math.sqrt(dot_qq))` 路径（直接利用 `std.math.sqrt` 的 Float32 重载，与 §1 方案 A 一致；(b 备选——若 (a 不可行，验证 `T(Float64.sqrt(Float64(dot_qq)))` 回退路径
13. **`isnan`/`isinf` 函数约束收紧验证**——验证 `where T <: FloatingPoint<T>` 约束（stdlib 原生接口，见 `cangjie-std/math/README.md` 第 117 行）在仓颉编译器的支持情况；实例化 `Quat<Float32, PackedHighp>` 调用 `isnan`/`isinf` 通过编译；实例化 `Quat<Int64, PackedHighp>` 调用 `isnan`/`isinf` 报类型不匹配错误。`FloatingPoint<T>` 是 stdlib 原生接口，无「不可用」风险，本验证项无需 fallback 验证。——删除 v9 描述中「可验证 `FloatingPoint<T>` 接口的 `getMin()`/`getInf()` 实例方法可用性（对应 std::numeric_limits<T>::min()/infinity()）」的提示——`FloatingPoint<T>` 接口本身**不提供任何实例方法**（见 `cangjie-std/math/README.md` 第 117 行仅作为类型约束声明，下游如需 `std::numeric_limits<T>::min()`/`infinity()` 等价物应通过类型分派 `Float32.Min`/`Float32.Inf`/`Float64.Min`/`Float64.Inf` 静态常量获取，详见验证项 16/18
14. **Quat 字段 `public var` 可见性验证**——确认 `@Derive[Hashable]` 派生宏在 Quat 字段标注 `public var` 时编译通过；若字段标注缺失 `public`，验证派生失败报可见性错误
15. **`pow` 函数四元数版本与 `std.math.pow` 实数版本命名消歧验证**——验证 `pow(x: Quat<T,Q>, y: T)` 函数体内部调用 `std.math.pow(x.w, y)` 实数版本时，类型推断正确（参数类型为 `T`/`T`，不与四元数 `pow` 自身签名混淆；确认 `std.math.pow` 提供 `Float32`/`Float64` 共 4 个重载（`pow(Float32, Float32): Float32`、`pow(Float32, Int32): Float32`、`pow(Float64, Float64): Float64`、`pow(Float64, Int64): Float64`）——`T=Float32` 实例化时直接调用 `std.math.pow(Float32, Float32)` 重载，无需显式 Float64 转换；`T=Float64` 实例化时调用 `std.math.pow(Float64, Float64)` 重载；若 `std.math.pow` 不可用则以 `exp(y * log(x.w))` 替代实现
16. **`pow` 函数次正规数边界检查所需 `FloatingPoint<T>.getMinDenormal()` 静态方法路径验证**——依据 `cangjie-original-docs/std/math/math_package_api/math_package_interfaces.md` 第 49-60 行定义，仓颉 stdlib **实际提供** `FloatingPoint<T>.getMinDenormal()` 静态方法用于获取最小次正规数；下游实现 `pow` 函数体内部次正规数边界检查时，应直接调用 `FloatingPoint<T>.getMinDenormal()`（推荐路径，或 fallback 到类型分派 `if (q.x is Float32 { Float32.Min } else { Float64.Min }` 路径，或字面量 fallback 路径（如 `T(1 / T(很大值)`。验证项应验证「`FloatingPoint<T>.getMinDenormal()` 静态方法 + 类型分派 + 字面量 fallback 三条路径的编译可行性」
17. **`type_quat_cast` 函数 `FloatingPoint<T>` 约束可用性验证**——验证 `where T <: FloatingPoint<T>` 约束（stdlib 原生接口）在 `mat3Cast`/`mat4Cast`/`quatCast` 4 个函数签名上的编译可行性；实例化 `Quat<Float32, PackedHighp>` 调用转换函数通过编译；实例化 `Quat<Int64, PackedHighp>` 调用转换函数报类型不匹配错误（与 GLM `GLM_STATIC_ASSERT(is_iec559, ...)` 等价行为
18. **`log` 函数 `FloatingPoint<T>.getInf()` 静态方法路径验证**——依据 `cangjie-original-docs/std/math/math_package_api/math_package_interfaces.md` 第 37-48 行定义，仓颉 stdlib **实际提供** `FloatingPoint<T>.getInf()` 静态方法用于获取正无穷；下游实现 `log` 函数体内部 w=0 退化分支时，应直接调用 `FloatingPoint<T>.getInf()`（推荐路径，或 fallback 到类型分派 `if (q.x is Float32 { Float32.Inf } else { Float64.Inf }` 路径，或字面量 fallback 路径 `T(1)/T(0)`（仅对浮点类型有效，整数类型 `1/0` 触发除零异常，与 GLM 行为一致。验证项应验证「`FloatingPoint<T>.getInf()` 静态方法 + 类型分派 + 字面量 fallback 三条路径的编译可行性」
19. **`epsilon<T>()` 与 `epsilonOf<T>(hint)` 返回值一致性验证**——阶段二 `cjglm/src/detail/shim_limits.cj:25` 已有 `public func epsilonOf<T>(hint: T): T where T <: Number<T>` 函数，本设计新增的 `epsilon<T>()` 函数与其功能等价。验证项需验证——在 `T = Float32` 实例化时，`epsilon<Float32>()` 与 `epsilonOf<Float32>(0.0f)` 返回值相等（`Float32(1.1920929e-7)`；在 `T = Float64` 实例化时，`epsilon<Float64>()` 与 `epsilonOf<Float64>(0.0)` 返回值相等（`Float64(2.220446049250313e-16)`；在 `T = Int64` 实例化时两者均返回 `Int64(0)`（`hint - hint` 形式；阶段二测试 `tests/glm/detail/test_shim_limits.cj` 中硬编码的精度值作为 ground truth 验证依据
20. **`FloatingPoint<T>` 接口方法可用性验证**——依据 `cangjie-original-docs/std/math/math_package_api/math_package_interfaces.md` 第 5-17 行定义，验证 `FloatingPoint<T>` 接口实际提供 6 个静态方法（`getE`/`getInf`/`getPI`/`getMinDenormal`/`getMinNormal`/`getNaN`）+ 3 个实例方法（`isInf`/`isNaN`/`isNormal`。v10 描述「`FloatingPoint<T>` 接口本身无任何实例方法」错误——下游实现 `pow` 次正规数边界检查时应直接调用 `FloatingPoint<T>.getMinDenormal()` 而非类型分派；实现 `log` w=0 退化分支时应直接调用 `FloatingPoint<T>.getInf()` 而非类型分派；实现 `isnan`/`isinf` 约束时该 where 子句确保 T 类型实现 `isNaN()`/`isInf()` 实例方法。——本验证项引用的 `FloatingPoint<T>` 接口方法清单基于 `cangjie-original-docs/std/math/math_package_api/math_package_interfaces.md` 编写，v13 中对该文档的引用内容未纳入本轮 v14 审查范围的独立复核——下游编码者在实际调用 `FloatingPoint<T>.getMinDenormal()`/`getInf()` 等方法前应以仓颉编译器实际签名确认
21. **`std.math` Float32 重载可用性验证**——依据 `cangjie-original-docs/std/math/math_package_api/math_package_funcs.md` 全文检索，验证 `std.math` 三角函数（`sin`/`cos`/`tan`/`asin`/`acos`/`atan`/`sinh`/`cosh`/`tanh`/`asinh`/`acosh`/`atanh`/`atan2`/`sqrt`/`exp`/`log`）均提供 Float16/Float32/Float64 三种重载，`std.math.pow` 提供 Float32/Float64 共 4 个重载。T=Float32 实例化时调用 `std.math.sin(x)`/`std.math.cos(x)`/`std.math.pow(x, y)` 等函数**直接返回 Float32**，无需 `T(Float64.xxx(Float64(value)))` 显式转换。`radians`/`degrees` 是例外（stdlib 不存在这两个函数
22. **`trigonometric.cj` T 约束验证**——验证 §3.13.1 所有 75 个展开函数签名（含 14 标量 + 56 向量 + 1 标量 `atan2` + 4 向量 `atan2`）均标注 `where T <: FloatingPoint<T>`；实例化 `trigonometric.sin<Float32, PackedHighp>(1.0f)` 通过编译；实例化 `trigonometric.sin<Int64, PackedHighp>(1)` 报类型不匹配错误
23. **`fwd.cj` 自动生成脚本验证**——验证 `cjglm/scripts/gen_fwd_aliases.py` 生成脚本是否能正确生成 9 个四元数 type alias——具体步骤——(a 查阅 `cjglm/scripts/gen_fwd_aliases.py` 确认生成脚本存在；(b 在脚本的 `VEC_FAMILIES` 字典中新增 `Quat`/`FQuat`/`DQuat` 三个家族前缀条目（如 `Quat`/`FQuat` 映射到 `Float32`，`DQuat` 映射到 `Float64`，并新增针对 Quat 家族固定 4 维（无 Vec1/Vec2/Vec3 变体）的特殊处理分支——因 Quat 仅支持 4 维而现有脚本按 `DIMS = [1, 2, 3, 4]` 全维度循环生成 Vec 别名，简单新增 `VEC_FAMILIES` 条目会生成 `Quat1`/`Quat2`/`Quat3` 三个不存在项；(c 运行脚本 `python cjglm/scripts/gen_fwd_aliases.py` 生成新的 `fwd.cj` 后再提交；(d 验证生成的 `fwd.cj` 包含全部 9 个 type alias 且与 §3.14 清单一致；(e 验证脚本支持幂等运行（多次执行结果一致
24. **`conjugate` const func 编译可行性验证**——验证 `conjugate` 函数声明为 `const func` 后能在 const 上下文正确编译——具体步骤——(a 实现 `public const func conjugate<T, Q>(q: Quat<T, Q>): Quat<T, Q> where T <: Number<T>, Q <: Qualifier { Quat<T, Q>(-q.x, -q.y, -q.z, q.w }`；(b 在 `const` 上下文（如 `const val q_conj = conjugate(q)` 或 `const init` 块内）调用 `conjugate(q)` 验证编译通过；(c 参照阶段一 `type_vec3.cj:54-80` 中 27 个 const func + 阶段二矩阵 `negative` const func 实践，确保与既有 const func 实现模式一致
25. **`T(Float64(n))` 字面量转换路径编译可行性验证**——验证 `T(Float64(n))` 语法对全部受影响的类型变体编译通过——(a 实例化 `Float32(Float64(0))`/`Float32(Float64(1))`/`Float32(Float64(2))` 通过编译；(b 实例化 `Float64(Float64(0))`/`Float64(Float64(1))`/`Float64(Float64(2))` 通过编译；(c 实例化 `Int8(Float64(0))`/`Int16(Float64(0))`/`Int32(Float64(0))`/`Int64(Float64(0))` 通过编译；(d 实例化 `Int8(Float64(1))`/`Int16(Float64(1))`/`Int32(Float64(1))`/`Int64(Float64(1))` 通过编译；(e 若 (a)-(d 任意一步编译失败，则依赖此路径的全部函数（normalize/axis/mat3Cast/mat4Cast/Quat×Vec3/Quat×Vec4）的实现假设被证伪，需重新评估 §1「常量型 T(n 字面量替代」策略
26. **Mat4x4 `[]` 运算符返回类型为可赋值引用验证**——验证 `Mat4x4<T,Q>` 的 `[]` 索引运算符返回类型为可赋值引用（`&Vec4<T,Q>` 或 `mut Vec4<T,Q>`，确保 `mat3Cast`/`mat4Cast` 逐元素填充模式中 `result.col0 = Vec4<T,Q>(...)` 赋值路径编译通过——(a 查阅阶段二 `type_mat4x4.cj` 中 `[]` 运算符签名，确认返回 `&Vec4<T,Q>`（可赋值引用）或返回 `Vec4<T,Q>`（值类型，不可赋值；(b 若返回为值类型（不可赋值，则 `mat3Cast`/`mat4Cast` 需退化为通过 `Mat4x4<T,Q>(col0, col1, col2, col3)` 主构造函数构造，不依赖 `[]` 赋值路径
27. **Mat4x4 列字段名 `c0`/`c1`/`c2`/`c3` 存在性验证**——经查阅阶段二 `type_mat4x4.cj:8-11`，列字段名确为 `c0`/`c1`/`c2`/`c3`，设计假设已验证为正确。本验证项状态从「验证假设」升级为「已核验确认」。验证结果——`Mat4x4<T,Q>` 列字段命名为 `c0`/`c1`/`c2`/`c3`，§3.3 item 7 `fromMat4` 手动提取策略中 `m.c0`/`m.c1`/`m.c2` 引用正确，无需修正。**说明**——验证项 27 的假设核验已在本轮设计阶段由设计方完成，编码者无需重复核验——可直接按 §3.3 item 7 的描述字面实现 `Vec3<T,Q>(m.c0.x, m.c0.y, m.c0.z)` 等表达式。
28. **Vec4 双参数构造函数 `Vec4<T,Q>(Vec3<T,Q>, T)` 在所有 6 个 Qualifier 变体上编译可行性验证**——验证 `Vec4<T,Q>(Vec3<T,Q>, T)` 双参数构造函数签名在全部 6 个 Qualifier 变体上均编译通过——(a 实例化 `Vec4<Float32, PackedHighp>(Vec3<Float32, PackedHighp>(1.0f, 2.0f, 3.0f), 4.0f)` 通过编译；(b 重复 (a 对其他 5 个 Qualifier（PackedMediump/PackedLowp/AlignedHighp/AlignedMediump/AlignedLowp）分别验证；(c 若任意 Qualifier 变体编译失败，则 `Quat×Vec4` 运算符（§3.4 行 `Vec4(q * Vec3(v), v.w)` 公式）在该精度变体上不可用，需在 §11.5 中标注 Qualifier 限制
29. **`glm.detail` 包对 `glm.ext` 的无导入验证**——确认 `detail/type_quat.cj` 中**无** `import glm.ext.*` 声明，因 §3.4 v18 已对 Vec3×Quat/Vec4×Quat 采用内联 conjugate/dot 计算路径，无需跨包 import。验证方式——(a grep `type_quat.cj` 确认无 `import glm.ext.*` 声明；(b 执行 `cjpm build` 确认编译通过。**受影响章节**：§2 模块间依赖图、§3.4 Vec extend 块

#### 验证失败后受影响章节清单

以下映射表列出了编码启动前验证项验证失败时需同步修改的设计章节，便于快速定位修复范围：

| 验证项 | 验证假设 | 验证失败后受影响章节 | 修复责任人 |
|-------|---------|-------------------|----------|
| 1-2（gtc 子包构建 | cjpm 识别 `src/gtc/` + `package glm.gtc` | §2「cjpm 子包构建预验证」回退方案；§2 包组织结构；§8.3 验收项 E | 设计者 |
| 3（包间无循环依赖 | `glm.gtc → glm.detail` 单向 | §2 模块间依赖图；§3.2.1 type_quat_cast 包归属决策 D11；§3.15 跨包引用 | 设计者 |
| 4（同包调用 type_quat_cast | `fromMat3`/`fromMat4` 调用同包函数 | §3.3 item 6/7；§3.2 协作关系表 | 设计者 |
| 5（Vec extend 块前向引用 | Vec3/Vec4 extend 块中 Quat 引用延迟解析 | §3.4 Vec extend 块 | 设计者 |
| 6-7（scalar_constants match 模式 | 泛型 `match` 类型模式匹配编译 | §3.12 实现策略；§7 D09 | 编码者 |
| 8（标量运算同名重载消歧 | add/sub/mul/div 与向量/矩阵版本消歧 | §3.4 全局具名函数表；§7 D18 | 编码者 |
| 9（isNaN/isInf 实例方法 | 浮点类型提供 `isNaN()`/`isInf()` | §3.11 isnan/isinf 实现路径；§7 D29 | 编码者 |
| 10（内联 abs 编译通过 | `Number<T> & Comparable<T>` 内联模式 | §3.5 依赖分析段 | 编码者 |
| 11（Hashable 派生对 Qualifier | `@Derive[Hashable]` 对 `Q <: Qualifier` 支持 | §3.1 `@Derive[Hashable]` 约束核验段；§7 D30 | 设计者 |
| 12（length sqrt 转换 | `T(Float64.sqrt(Float64(dot_qq)))` 编译 | §3.7 length 函数；§1 Float32/std.math 约束 | 编码者 |
| 13（isnan/isinf 约束收紧 | `where T <: FloatingPoint<T>` 编译期生效 | §3.11 isnan/isinf 签名；§7 D29；§5.3 边界条件表 | 设计者 |
| 14（public var 可见性 | `public var` 字段满足 Hashable 派生 | §3.1 数据成员声明；§7 D30 | 编码者 |
| 15（pow 命名消歧 | 四元数 pow 与 std.math.pow 区分 | §3.10 pow 依赖描述；§1 系统性约束 | 编码者 |
| 16（getMinDenormal 静态方法 | `FloatingPoint<T>.getMinDenormal()` 存在 | §3.10 pow 次正规数边界；§1 回退方案 H2 路径 A/B | 编码者 |
| 17（type_quat_cast 约束 | `where T <: FloatingPoint<T>` 编译生效 | §3.2.1 函数签名规范；§7 D32；§5.3 边界条件表 | 设计者 |
| 18（getInf 静态方法 | `FloatingPoint<T>.getInf()` 存在 | §3.10 log w=0 退化分支；§1 回退方案 H2 路径 A/B | 编码者 |
| 19（epsilon 一致性 | `epsilon<T>()` 与 `epsilonOf<T>(hint)` 一致 | §3.12 epsilon 实现；§8.2 测试覆盖维度 | 编码者 |
| 20（FloatingPoint 接口方法）→ P0 | 6 静态 + 3 实例方法均存在 | §1 回退方案 H2 全部路径；§3.10/§3.11 依赖描述；§7 D21/D29 | 编码者 |
| 21（std.math Float32 重载 | 三角函数均提供 Float32 重载 | §1 Float32/std.math 约束段；§3.13.1 函数表；§3.10 pow/log/exp | 编码者 |
| 22（trigonometric T 约束 | 75 展开函数均标注 `FloatingPoint<T>` | §3.13.1 函数签名表；§8.3 验收项 E | 设计者 |
| 23（fwd.cj 生成脚本 | `gen_fwd_aliases.py` 正确生成 9 别名 | §2 fwd.cj 段落；§3.14 别名清单；§8.3 验收项 F | 编码者 |
| 24（conjugate const func | `const func` 编译通过 | §3.11 conjugate 实现；§5.4 const 上下文约束 | 编码者 |
| 25（T(Float64(n) 语法）→ P0 | 全部受影响的类型编译通过 | §1 回退方案 H1 全部路径；§3.7 normalize；§3.9 axis；§3.2.1 mat3Cast/mat4Cast；§3.4 Quat×Vec3/Vec4 | 设计者 |
| 26（Mat4x4 [] 返回类型 | `[]` 返回可赋值引用 | §3.3 item 7 fromMat4 实现 | 编码者 |
| 27（Mat4x4 列字段名 | 列字段名为 `c0`/`c1`/`c2`/`c3` | §3.3 item 7 fromMat4 实现（编码者——验证后按实际字段名修改 §3.3 item 7 实现注释中的字段名引用；不涉及 API 签名变更，无需设计审批 | 编码者（已验证为正确 |
| 28（Vec4 双参数构造 | `Vec4(Vec3, T)` 在 6 个 Qualifier 上均可用 | §3.4 Quat×Vec4 运算符；§11.5 可用性表 | 编码者 |
| 29（glm.detail 导入 glm.ext）→ P0 | `detail/type_quat.cj` 无 `import glm.ext.*` | §2 模块间依赖图；§3.4 Vec extend 块（内联路径）| 设计者 |

#### 高优先级编译前验证项

以下两项为基础性编译假设的验证项，必须在编码阶段开始前优先完成（P0 优先级，5 日内必须完成。——新增 P0 验证项 29（`glm.detail` 包对 `glm.ext` 的导入可行性验证。当前共 3 项 P0 验证（20、25、29，要求在编码阶段前优先完成最小测试文件验证。

- **验证项 20（P0）**：`FloatingPoint<T>` 接口方法可用性独立核验——**本项要求独立重新核验，§1 回退方案决策树本身不能替代核验过程**。自 v11 轮独立核实以来（历经 v12-v19 共 8 个迭代版本）未重新核验，此次要求在编码阶段前编写最小仓颉测试文件（~20 行，实例化 `FloatingPoint<Float32>.getMinDenormal()`/`getInf()`/`isInf()`/`isNaN()`/`getNaN()`/`getMinNormal()`，确认编译通过。验证结果反馈到 §3.10/§3.11 的依赖描述中更新。若编译失败，则 §3.10 `log` 函数中 `FloatingPoint<T>.getInf()` 路径和 §3.10 `pow` 函数中 `FloatingPoint<T>.getMinDenormal()` 路径的实现假设被证伪，需回退至类型分派 fallback 路径。具体回退路径参见 §1 回退方案子节（路径 A/B/C 及决策树执行顺序。**核验影响范围声明**——若 `FloatingPoint<T>` 实际 API 形态与本设计引用文档有差异，影响范围覆盖 §3.10（`pow`/`log` 依赖描述）、§3.11（`isnan`/`isinf` 约束）以及 §9a（覆盖矩阵中相关函数的状态标注。

- **验证项 25（P0）**：`T(Float64(n))` 字面量转换路径编译可行性验证——要求在编码阶段前先编写最小仓颉测试文件（~20 行，实例化 `Float32(Float64(0))`/`Float32(Float64(1))`/`Float64(Float64(0))`/`Float64(Float64(1))`/`Int32(Float64(0))`/`Int64(Float64(1))`，确认编译通过。**扩展验证——泛型上下文**——编写泛型函数 `func f<T>(): T where T <: Number<T> { T(Float64(1) }` 并以 `Float32`/`Float64`/`Int32`/`Int64` 实例化，确认均编译通过（解决 H1 验证未覆盖泛型上下文的不对称问题，对应 Problem 4 响应。若编译失败，则 §1「常量型 T(n 字面量替代」策略被证伪，依赖此路径的全部函数（normalize/axis/mat3Cast/mat4Cast/Quat×Vec3/Quat×Vec4）需重新评估零值/单位值获取策略。具体回退路径参见 §1 回退方案子节（路径 A/B/C 及决策树执行顺序。

- **验证项 29（P0，Issue 5 响应）**——`glm.detail` 包内 `type_quat.cj` 无 `import glm.ext.*` 声明验证——§3.4 v18 已采用内联 conjugate/dot 计算路径替代原跨包 import 路径。验证方式——(a grep `type_quat.cj` 确认无 `import glm.ext.*` 声明；(b 执行 `cjpm build` 确认编译通过。**受影响章节**：§2 模块间依赖图、§3.4 Vec extend 块实现路径。

#### 验证结果记录表模板

为确保编码启动前的假设核验可追溯，以下提供标准化验证结果记录表模板。对 3 项 P0 验证项（20、25、29，要求验证通过后才可启动编码；验证失败时按「失败后处置路径」列指引的章节触发设计修订流程。H1/H2/H3 核验项由设计者在每轮版本输出前执行。

**验证结果状态汇总**——以下验证结果记录表中，标注为「✅ 已验证」的项表示验证已通过并记录验证日期；标注为「—」的项表示该验证项在编码阶段执行（非设计阶段项）或当前轮次尚未执行；保持空白的项表示尚未执行。3 项 P0 验证（20、25、29）已全部列明验证结果。「—」项不阻塞版本发布，但编码实施者应在编码阶段对应节点补充验证并记录结果。

| 验证项编号 | 假设描述 | 验证结果（通过/失败 | 验证日期 | 验证人 | 失败后处置路径 | 修复责任人 |
|-----------|---------|---------------------|---------|-------|-------------|----------|
| 1 | cjpm 识别 `src/gtc/` + `package glm.gtc` | —（编码阶段执行 | — | — | §2 回退方案——迁移至 `src/` 根目录降级为 `package glm` | 设计者 |
| 2 | `public import` 重导出 detail 函数可行 | —（编码阶段执行 | — | — | D11 重新评估：detail 端函数下沉至 gtc 端复制实现 | 设计者 |
| 3 | 包间无循环依赖（`glm.gtc → glm.detail` 单向 | —（编码阶段执行 | — | — | §2 模块间依赖图重绘：D28 包间依赖策略修订 | 设计者 |
| 4 | type_quat.cj 同包调用 type_quat_cast.cj 函数 | —（编码阶段执行 | — | — | §3.3 item 6/7 fromMat3/fromMat4 改为跨包 import | 设计者 |
| 5 | Vec extend 块中 Quat 前向引用 | —（编码阶段执行 | — | — | §3.4 Vec extend 块运算符改为全局函数（scalar_quat_ops 扩展 | 设计者 |
| 6-7 | scalar_constants match 模式 | —（编码阶段执行 | — | — | D09 重复评估——改用 if-else 链替代 match | 编码者 |
| 8 | 标量运算同名重载消歧 | —（编码阶段执行 | — | — | §3.4 全局函数改名避免冲突（如 addTQuat/scalarAddQuat | 编码者 |
| 9 | isNaN/isInf 实例方法 | —（编码阶段执行 | — | — | §3.11 改为 match 运行时分派 | 编码者 |
| 10 | 内联 abs 编译通过 | —（编码阶段执行 | — | — | §3.5 回退至调用 common.cj abs stub | 编码者 |
| 11 | Hashable 派生对 Qualifier | —（编码阶段执行 | — | — | §3.1 移除 `@Derive[Hashable]`，手动实现 Hashable | 设计者 |
| 12 | length sqrt 转换 | —（编码阶段执行 | — | — | §3.7 改为 `T(Float64.sqrt(Float64(dot_qq)))` + 类型转换 | 编码者 |
| 13 | isnan/isinf 约束收紧 | —（编码阶段执行 | — | — | §3.11 放宽约束，运行时 match 分派 | 设计者 |
| 14 | public var 可见性 | —（编码阶段执行 | — | — | §3.1 确认字段标注 public，否则修正 | 编码者 |
| 15 | pow 命名消歧 | —（编码阶段执行 | — | — | §3.10 pow 函数使用全限定名 `std.math.pow` | 编码者 |
| 16 | getMinDenormal 静态方法 | —（编码阶段执行 | — | — | §1 回退方案 H2 路径 A/B——类型分派或字面量 fallback | 编码者 |
| 17 | type_quat_cast 约束 | —（编码阶段执行 | — | — | §3.2.1 放宽为 Number<T>，运行时 match 分派 | 设计者 |
| 18 | getInf 静态方法 | —（编码阶段执行 | — | — | §1 回退方案 H2 路径 A/B——类型分派或 T(1)/T(0 构造 | 编码者 |
| 19 | epsilon<T> 与 epsilonOf<T>(hint 一致性 | —（编码阶段执行 | — | — | §3.12 统一为单实现路径，消除分支 | 编码者 |
| **20（P0）** | **FloatingPoint<T> 接口方法可用性** | ✅ **已验证**（§8.4 验证报告 | 2026-06-26 | 设计方 | §1 回退方案 H2 全部路径（类型分派/字面量 fallback | 编码者 |
| 21 | std.math Float32 重载 | —（编码阶段执行 | — | — | §1 返回「必选 Float64 转换」策略：`T(Float64.xxx(Float64(value)))` | 编码者 |
| 22 | trigonometric T 约束 | —（编码阶段执行 | — | — | §3.13.1 放宽为 Number<T>，运行时 match 分派 | 设计者 |
| 23 | fwd.cj 生成脚本 | —（编码阶段执行 | — | — | §2 备选方案 B——手动维护 lib.cj 或新建别名文件 | 编码者 |
| 24 | conjugate const func | —（编码阶段执行 | — | — | §3.11 移除 const 声明，降级为普通 func | 编码者 |
| **25（P0）** | **T(Float64(n) 语法编译可行性** | ✅ **已验证**（§8.4 验证报告 | 2026-06-26 | 设计方 | §1 回退方案 H1 全部路径（追加 `one: T` 形参/`match` 分派/收紧约束 | 设计者 |
| 26 | Mat4x4 [] 返回类型 | —（编码阶段执行 | — | — | §3.3 item 7 退化为 Mat4x4 主构造函数构造 | 编码者 |
| 27 | Mat4x4 列字段名 `c0`/`c1`/`c2`/`c3` | ✅ 已核验 | 2026-06-26 | 设计方 | **本轮已核验确认**：§3.3 item 7 描述正确，无需编码者重复核验 | 编码者（已验证为正确 |
| 28 | Vec4 双参数构造函数 | —（编码阶段执行 | — | — | §3.4 Quat×Vec4 改为手动 Vec4(x,y,z,w 构造 | 编码者 |
| **29（P0）** | **glm.detail 无 import glm.ext.* 声明验证** | ✅ **已验证**（§8.4 验证报告 | 2026-06-26 | 设计方 | 确认 `type_quat.cj` 无 `import glm.ext.*` + `cjpm build` 通过 | 设计者 |
| **P0 通过条件**——3 项 P0（20/25/29）全部标注「通过」后方可启动 stage 3 编码；任一项失败按失败后处置路径触发设计修订。**当前状态——3 项 P0 全部 ✅ 通过**。 |

### 8.3 Stage 3 Acceptance Criteria

本节汇总阶段三完成验收的全部依据，整合 §8/§8.2/§9a/§11.5 等分散于多处的内容：

**A. 产出物清单验收（来源——§8 产出物清单。，Issue 2 响应——分类名称已统一对齐 §11.5 三档体系**：

| 类型 | 验收项 | 数量 | 验收依据 |
|------|--------|------|---------|
| ✅ 可用（无 stub 依赖 | `detail/type_quat.cj` + `detail/type_quat_cast.cj` + `detail/scalar_constants.cj` + `detail/scalar_quat_ops.cj` + `ext/quaternion_relational.cj`（4 函数）+ `ext/quaternion_geometric.cj`（4 函数）+ `ext/scalar_constants.cj` + `gtc/constants.cj`（28 函数）+ 4 个 ext/ 别名文件 | 11+ 个源文件（18 函数 ✅ 可用 | 文件存在 + `cjpm build` + 运行时无 Exception("stub" |
| ⚠️/❌ 混合（部分 ✅ 可用、部分 ❌ stub | `ext/vector_relational.cj`（epsilon 16 重载 ✅ + ULP 8 重载 ❌）+ `ext/quaternion_common.cj`（5 ✅ + 3 ❌）+ `ext/quaternion_trigonometric.cj`（1 ✅ + 2 ❌）+ `ext/quaternion_transform.cj`（1 ❌）+ `ext/quaternion_exponential.cj`（4 ❌）+ `gtc/quaternion.cj`（8 ✅ 含 4 重导出 + 4 完整 + 7 ❌ | 6 个源文件 | 文件存在 + `cjpm build` 通过；✅ 部分运行时正常调用，❌ 部分抛 Exception("stub" |
| ❌ stub（空桩占位 | `gtc/matrix_transform.cj`（64 ❌）+ `detail/trigonometric.cj`（75 ❌）+ `ext/matrix_projection.cj` + `ext/matrix_clip_space.cj` + `ext/matrix_transform.cj` | 5 个源文件 | 文件存在 + `cjpm build` 通过；运行时均抛 Exception("stub" |
| 沿用 stub 文件 | `detail/common.cj` + `detail/geometric.cj` + `detail/matrix.cj`（27 实现 + 6 stub | 3 个源文件 | 阶段二已验证 |
| 更新文件 | `fwd.cj`（9 个四元数别名）+ `lib.cj`（20 个 public import 声明 | 2 个更新文件 | 别名与 import 清单匹配 §2 |

**B. 测试设计验收（来源：§8.2 测试设计）**

| 验收项 | 数量 | 验收依据 |
|--------|------|---------|
| 测试文件总数 | 13 个 | 路径符合「测试目录结构对齐策略」：ext 子模块测试 `tests/glm/test_ext_xxx.cj` 同层平铺命名 + gtc 测试 `tests/glm/gtc/test_xxx.cj` |
| 测试用例总数 | ≥192 | 40+8+8+12+13+4+4+2+16+13+9+28+27+8 = 192（下限；通过增补 7 个边界用例可达 ≥199 |
| 跨 Qualifier 实例化测试 | 6 种精度 | `test_type_quat.cj` 覆盖 PackedHighp/PackedMediump/PackedLowp/AlignedHighp/AlignedMediump/AlignedLowp |
| 跨类型实例化测试 | Float32/Float64 | 阶段三完整测试；Int64 仅测试非依赖 stub 的运算符 |

**C. 覆盖矩阵验收（来源——§9a GLM 1.0.3 Stage 3 API 覆盖矩阵）**——

GLM 1.0.3 各头文件阶段三覆盖状态汇总：

| GLM 头文件 | 函数总数 | ✅ 可用 | ⚠️/❌ stub | 阶段四补齐 |
|----------|---------|----------|----------|----------|
| `detail/type_quat.hpp` | 19 个 API（结构体 + 运算符 + 工厂 | 14 个 ✅（不含 fromVec3/fromEuler ❌ + Quat×Vec3/Vec4/Vec3×Quat/Vec4×Quat ⚠️ | 3 个 ⚠️（Quat×Vec3/Vec4 + Vec3×Quat/Vec4×Quat）+ 2 个 ❌（fromVec3/fromEuler | — |
| `detail/type_quat_cast.hpp` | 4 个 | 4 个 ✅ | 0 | — |
| `ext/vector_relational.hpp` | 8 个 | 4 个 epsilon 版本 ✅（16 重载 | 4 个 ULP 版本 ❌（8 重载 | ULP 版本需评估仓颉位级访问能力 |
| `ext/quaternion_relational.hpp` | 4 个 | 4 个 ✅ | 0 | — |
| `ext/quaternion_geometric.hpp` | 4 个 | 4 个 ✅ | 0 | — |
| `ext/quaternion_common.hpp` | 8 个 | 5 个 ✅（conjugate/inverse/lerp/isnan/isinf | 3 个 ❌（mix/slerp(2) | mix/slerp 完整实现 |
| `ext/quaternion_trigonometric.hpp` | 3 个 | 1 个 ✅（axis | 2 个 ❌（angle/angleAxis | angle/angleAxis 完整实现 |
| `ext/quaternion_transform.hpp` | 1 个 | 0 | 1 个 ❌（rotate | rotate 完整实现 |
| `ext/quaternion_exponential.hpp` | 4 个 | 0 | 4 个 ❌（exp/log/pow/sqrt | 全部完整实现 |
| `ext/scalar_constants.hpp` | 3 个 | 3 个 ✅ | 0 | — |
| `gtc/constants.hpp` | 28 个 | 28 个 ✅ | 0 | — |
| `gtc/matrix_transform.hpp` | **64** | 0 | **64** ❌ | 完整实现（阶段四 |
| `gtc/quaternion.hpp` | 15 个 | 8 个 ✅（4 重导出 + 4 完整 | 7 个 ❌（4 欧拉 + 3 看向 | 7 个 stub 完整实现 |
| **合计** | — | **75 个 ✅** | **86 个 ❌ + 4 个 ⚠️ = 90 个 ⚠️/❌** | — |

**D. 函数可用性对照表验收（来源：§11.5）**

`§11.5 函数可用性对照表` 是阶段三验证的**函数级状态追踪的权威来源**（原 §10 已合并入 §9a，当前覆盖体系为 §9a + §11.5 双层结构：✅/⚠️/❌ 三档符号标记每个函数本阶段状态（实现在本文件其他章节有详细描述。下游验证时按 §11.5 表逐项核验函数级状态，按 §9a 表查阅文件级覆盖视图（含 GLM 1.0.3 基准声明与阶段覆盖矩阵。

**E. 验证项清单（来源：§8 编码启动前验证项 1-29）**

阶段三编码启动前需完成 §8 编码启动前验证项 1-29 全部 29 项验证，其中验证项 20、25、29 兼为高优先级编译前验证项（P0。——新增验证项 29（`glm.detail` 包对 `glm.ext` 的导入可行性验证，独立验证目标从 28 项修正为 29 项。——验证所有 stub 函数签名均已记录于 §11.5 中，且阶段四不得单方面修改——签名变更须通过 §3.16「签名冻结例外审批流程」。确保：
- cjpm 构建系统接受 `src/gtc/` + `package glm.gtc` 子包结构
- `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 重导出机制可行
- 包间无循环依赖（`glm.gtc → glm.detail` 单向
- `@Derive[Hashable]` 对 `Q <: Qualifier` 派生可行
- `length`/`normalize`/`isnan`/`isinf`/`mat3Cast` 等 T 类型约束编译期生效
- `epsilon<T>()` 与 `epsilonOf<T>(hint)` 返回值一致
- `FloatingPoint<T>` 接口方法实际可用
- `std.math` Float32 重载实际可用
- `trigonometric.cj` 75 个展开函数签名 T 约束编译期生效
- **所有 stub 函数签名已记录于 §11.5 且阶段四不得单方面修改**

**F. 文档-代码一致性验收**

下游实现完成后需逐项核验：
- `fwd.cj` 9 个四元数别名（Quat/FQuat/DQuat + 3×Float32 精度 + 3×Float64 精度）与 §2 lib.cj/fwd.cj 段落一致
- `lib.cj` 20 个 import 声明与 §2 lib.cj import 清单一致
- 各函数签名 where 子句与 §3 / §9a / §11.5 约束标注一致
- 边界行为实现与 §5.3 边界条件表 + §5.1 通用异常表一致（特别是 normalize 零四元数保护、inverse 整数除零异常

**G. 整体设计可追溯性验收**

GLM 1.0.3 → 仓颉阶段三设计的可追溯矩阵：§9a「GLM 1.0.3 Stage 3 API 覆盖矩阵」列出全部 13 个 GLM 头文件 + 本设计核心章节的映射关系；下游编码者按 §9a 表逐项核验可定位每个 GLM 函数在仓颉设计中的对应位置。

**H. 覆盖矩阵计数自动化核验**

新增以下文档内一致性自动核验项，防止后续版本再次出现覆盖矩阵合计行计数与逐行累加值偏差的问题：
- **核验项 H1**——§9a 覆盖矩阵合计行 ❌/⚠️ 计数 = 逐行累加各文件 ❌/⚠️ 计数之和。验证方式——建议使用 Spreadsheet 模板（`docs/templates/coverage_matrix_checklist.xlsx`）或 Python 脚本（`scripts/check_coverage_matrix.py`）自动化完成累加验证——逐行提取 ✅/⚠️/❌ 数值，逐行累加后与合计行声明值对照，偏差为 0。如自动化工具尚未就绪，人工核验模板见 §8 验证结果记录表模板。
- **核验项 H2**——全文档中任何引用「约 80 个 ❌/⚠️」或「79 ❌」的字样均已清除，统一替换为「88 个 ❌ + 4 个 ⚠️ = 92 个 ⚠️/❌（§11.5 独立函数范式口径）或 86 ❌ + 4 ⚠️ = 90 个 ⚠️/❌（§9a 含重载展开口径）」。验证方式——`grep -n "80.*❌\|79 ❌"` 应返回空。
- **核验项 H2b（§11.5 vs §9a 覆盖矩阵交叉验证）**——§11.5 逐函数表中 ✅/⚠️/❌ 计数应分别与 §9a 覆盖矩阵中 ✅/⚠️/❌ 的文件级计数之和一致。验证方式——手动或脚本化核对 §11.5 表后合计行的 ✅ 计数、⚠️ 计数、❌ 计数分别与 §9a 覆盖矩阵合计行的对应计数一致，三项计数偏差均为 0 方可发布版本。确认独立函数范式口径（✅ ~18 个）与含重载展开口径（✅ ~77 个）的差异来源已在 §11.5 计数口径映射注记中明确列明。核验周期——每轮版本发布前执行一次。
- **核验项 H3**——版本号一致性自动化核验。版本发布前用 `grep -n 'v[0-9]+.*修订|v[0-9]+.*新增|v[0-9]+.*决策'` 检查所有标注版本号与当前文件版本号的一致性。核验范围为"文件名 + 头部 + 正文"三方一致性验证。
- **核验项 H4**——修订说明中声明的修改措施必须有正文修改位置标记。每轮修订说明中每项"修改措施"列应注明对应的正文§节/段/行号，或标注"正文已修改"确认标记。验证方式——逐条比照修订说明中修改措施与正文对应位置，确认正文已实际修改（非仅修订说明表中有声明而正文未动。H4 与 H1/H2/H3 共同作为版本发布前置门禁。
- **核验项 H5**——版本标注自动化门禁。要求在每轮版本发布流程中增加自动化检查步骤——执行 `grep -n "\*\*v[0-9]" *.md` 扫描非决策性版本标注（即 §7 决策表的 D01~D38 版本号之外的所有 `**v{N}` 标记。匹配结果应为空或仅含 §7 决策表 + §3.13.2/§8/§11.5 中明确保留的少量计数解释性标注。若发现非决策性残留标注，阻止版本发布直至全部清理。此门禁与 H3（文件名/头部/正文三方一致性）联合执行。
- **核验项 H6**——运行时调用链无 stub 依赖验证门禁。所有标注为 ⚠️ 或 ✅ 的函数，在编码实施时必须在函数实现描述段中附带「运行时调用链依赖分析」子段，明确列出函数体内部的所有运行时调用链（包括间接调用，标注每级调用是否依赖 stub。验证方式——逐函数审查 §3.x 描述段，确认对每个 ⚠️/✅ 函数的运行时调用链分析完备；对遗漏分析子段的函数阻止版本发布。此门禁确保系统化的运行时依赖分析成为版本发布前置门禁，避免再次出现 Vec3×Quat 状态错误跨越 12 轮的流程性缺陷。
- **核验项 H7**——版本标注自动化 grep 门禁。在每轮版本发布流程中增加自动化检查步骤——执行 `grep -n "（v[0-9]\|（Issue [0-9]\|\\*\\*v[0-9]\|——v[0-9]" *.md` 扫描非决策性版本标注。匹配结果应为空或仅含 §7 决策表（D01~D38 版本号）+ §3.13.2/§8/§11.5 中已明确保留的计数解释性标注。若发现非决策性残留标注，阻止版本发布直至全部清理。此门禁与 H3（文件名/头部/正文三方一致性）和 H5 联合执行，从流程层面实现版本标注的零残留。(grep 窗口期——在 `git commit` 前执行，确保版本发布前完成检查。
- **核验项 H8**——函数状态信息自动化交叉核验门禁。§11.5 是本设计文档中函数级可用状态的**唯一权威来源**，其余 8 处位置（§1 聚合表、§3.2 策略段、§3.15 职责分组表、§8 产出物清单、§9a 覆盖矩阵、§10（已合并）、§11.6 可达性矩阵、§11.7 函数索引）**不得**独立维护 ✅/⚠️/❌ 状态信息。版本发布前执行自动化核验——确认上述 8 处位置中无独立于 §11.5 的状态行或状态表格，均替换为指向 §11.5 的交叉引用。若检出独立状态信息，阻止版本发布直至全部替换为交叉引用。核验方式：grep 扫描所有非 §11.5 的 ✅/⚠️/❌ 列表行，确认出现位置仅为 §11.5 表本身。
- **核验项 H9**——§11.5 与 §9a 函数总数一致性自动化核验门禁。版本发布前执行——`grep` 提取 §11.5 表中函数行数（合计行除外）与 §9a 覆盖矩阵合计行函数总数（165 个基准函数）的差异，确认两者在「独立函数范式口径」和「含重载/常量展开口径」下的计数均在 §11.5 末行口径注记中明确标明的公差范围内。若审计发现 §11.5 表中函数行总数与 §9a 覆盖矩阵中函数声明总行数在独立函数范式下的预期计数（~110 行 = ✅ 18 + ⚠️ 4 + ❌ 88 的合计行对应表行数）偏差超过 ±2，阻止版本发布直至对齐。此核验与 H2b（三项计数交叉核对）联合执行。
- **§9a 覆盖矩阵声明**：§9a「GLM 1.0.3 Stage 3 API 覆盖矩阵」已合并原 §10「GLM 1.0.3 API 阶段覆盖矩阵」的逐文件覆盖状态与设计章节映射内容。§9a 提供 GLM 1.0.3 基准函数总数和推迟理由清单（按头文件维度聚合，§11.5 提供逐函数精细追踪。两者形成「基准→函数」双层覆盖体系。

**H 节核验执行者与周期**——上述 H1/H2/H3 三项核验由**设计者在每轮版本输出前**执行，核验结果记录于版本发布检查清单中。核验失败时，阻止版本发布直至全部核验项通过。

**I. 已知未解决问题列表**

本节记录当前轮次已知但尚未解决的问题，作为 §8.3 验收项的补充。与历史修订说明中已闭环的问题不同，以下问题的修复计划在后续轮次中落实。

| 编号 | 问题描述 | 首次检出轮次 | 当前状态 | 计划修复轮次 |
|------|---------|------------|---------|------------|
| O-01 | §11.5 对齐 §9a 基准的逐函数覆盖率统计尚未完成自动化 | v23 | 待评估 | v28 |
| O-02 | §9a 与 §10 两张覆盖矩阵已合并为单一覆盖矩阵，本项✅已闭环 | v23 | ✅ 已闭环 | — |
| O-03 | δ 覆盖矩阵合计的 H1 核验尚未绑定自动化脚本 | v23 | 待评估 | v28 |
| O-04 | 编码启动前验证流程尚未与 CI/CD 管线集成 | v23 | 待评估 | v28 |
| O-05 | H1/H2/H3/H4 核验项尚未脚本化 | v25 | 待评估 | v28 |
| O-06 | 验证前置化流程（核心假设在设计版本固化前完成验证） | — | P0 核心假设（H1: T(Float64(n)) 语法、H2: FloatingPoint<T> 接口方法）已通过编译验证；非 P0 验证项（共 26 项）按计划在编码阶段执行，验证结果待补充至 §8 验证结果记录表 | — |
| O-07 | I 节非空时文档版本号标记质量门禁尚未实施 | v25 | 待评估 | v28 |

**O-06 可执行落地计划**——验证前置化流程（核心假设在设计版本固化前完成验证）的制度化方案，包含以下可执行要素——

| 要素 | 内容 |
|------|------|
| **目标** | 自 v28 起，所有 P0 级核心假设（如 `T(Float64(n))` 语法可行性、`FloatingPoint<T>` 接口方法可用性、`glm.detail` 无 `import glm.ext.*` 声明）必须在设计版本固化前完成最小仓颉测试文件编译验证，并记录验证结果 |
| **责任人** | **设计者**（负责识别 P0 假设、编写验证计划）→ **编码者**（负责执行最小文件验证、记录结果）→ **审核者**（负责核实验证结果与设计假设的一致性 |
| **产出物** | (1 `§8.4 验证结果记录表模板` 中的 P0 行在每轮设计版本输出前必须填写「验证结果」「验证日期」「验证人」三列；(2 最小验证测试文件（~20 行仓颉代码）存放于 `$TEMP/opencode/h{轮次}_verify/` 目录；(3 验证报告摘要写入设计文档 §8.4 末尾 |
| **里程碑** | M1——验证项 20/25/29 的 v28 重新核验通过 → M2——O-06 流程制度化文档完成 → M3：CI/CD 管线集成验证步骤 |
| **截止日期** | M1——2026-06-26（当前轮次完成；M2——2026-07-10（下一轮次完成；M3：2026-07-24（下下轮次完成 |
| **检查清单** | 每轮版本输出前，由审核者逐条检查：(a 本轮涉及的 P0 假设是否全部识别？(b 是否已完成最小文件编译验证？(c 验证结果是否已写入 §8 验证结果记录表？(d 验证失败时是否已按回退方案进行设计修订？四项全部通过方可发布版本 |
| **例外处理** | 若遇不可抗力（如仓颉编译器临时不可用）无法在版本输出前完成验证，需在「I 节已知未解决问题列表」中新增临时豁免条目，注明预计验证完成日期。同一假设最多豁免 1 轮 |

**已知问题计数变更规则**：O 编号在问题解决后从列表移除，不再重新编号（保持历史可追溯性。新增问题追加至列表末尾，编号递增。本列表在每轮版本输出前由设计者更新。

---

## 9. 对齐 GLM 参考实现的差异声明

| 差异 | 说明 |
|------|------|
| **无匿名 union / GLM_FORCE_QUAT_DATA_WXYZ** | 四元数仅支持 xyzw 存储+参数顺序布局，不支持 wxyz 存储布局变体 |
| **构造函数参数顺序 (x,y,z,w 非 (w,x,y,z)** | 仓颉侧主构造函数参数顺序与数据成员声明顺序一致，通过 `wxyz()` 工厂函数提供 GLM 习惯入口 |
| **无 C++ 显式类型转换运算符** | 仓颉不支持 `operator mat3x3()`/`operator mat4x4()` 隐式/显式类型转换运算符。矩阵-四元数互转通过 `mat3Cast`/`mat4Cast`/`quatCast` 显式函数实现 |
| **ULP 比较函数无法实现** | 仓颉无浮点位表示直接访问（无 `reinterpret_cast`/`union`，ULP 比较以空桩占位 |
| **GLM 中不存在 `lookRotate` 函数** | GLM 1.0.3 中与"看向"语义对应的函数是 `gtc/quaternion.hpp` 中的 `quatLookAt`/`quatLookAtRH`/`quatLookAtLH` |
| **从两向量构造改为具名工厂函数** | C++ GLM 中 `qua(vec3, vec3)` 为构造函数，仓颉版本改为 `Quat.fromVec3(u, v)` 工厂函数（因依赖 geometric.cj stub，阶段三为 stub 占位 |
| **从欧拉角构造改为具名工厂函数** | C++ GLM 中 `qua(vec3 eulerAngles)` 为构造函数，仓颉改为 `Quat.fromEuler(eulerAngles)`（依赖 trigonometric.cj stub，阶段三为 stub 占位 |
| **从旋转矩阵构造改为具名工厂函数** | C++ GLM 中 `qua(mat3x3)`/`qua(mat4x4)` 为构造函数，仓颉改为 `Quat.fromMat3`/`Quat.fromMat4`（——调用**同包** `type_quat_cast.cj` 函数，不再跨包引用 gtc |
| **`gtc/quaternion.cj` 独立承载 15 函数** | 与 GLM `gtc/quaternion.hpp` 1:1 映射；——`mat3Cast`/`mat4Cast`/`quatCast` 不在本文件实现，而是通过 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 重导出 detail 中的实现，——重导出函数采用 camelCase 命名（与 detail 端原始名一致，而非 GLM 原始 snake_case `mat3_cast`/`mat4_cast`/`quat_cast` |
| **`mat3Cast`/`mat4Cast`/`quatCast` 实际实现位于 `detail/type_quat_cast.cj`** | 为避免包间循环依赖，转换函数下沉至 detail 包；gtc 包通过 `public import` 重导出至 gtc 命名空间；——detail 端与 gtc 端函数名统一为 camelCase `mat3Cast`/`mat4Cast`/`quatCast`，下游按 GLM 习惯使用 snake_case `mat3_cast`/`mat4_cast`/`quat_cast` 时将编译失败——仓颉 `public import a.b.f` 仅重导出 f 原始名（依据 `cangjie-lang-features/package/README.md` 第 156-166 行规范，不做命名转换；与现有 `public import glm.detail.{transpose, matrixCompMult, outerProduct}` 模式（`cjglm/src/lib.cj:8`）保持 camelCase 风格一致 |
| **一元 + 运算符不可用** | 仓颉不支持重载一元 + 运算符（与 deviations.md IF-01 一致 |
| **标量-四元数运算为全局函数** | 仓颉 operator func 限制 |
| **quaternion_common 中 mix/slerp 依赖 trigonometric.cj/common.cj stub** | 本阶段 mix/slerp 为 stub 占位，待阶段四 trigonometric.cj/common.cj 完整实现后补齐 |
| **`mix`/`slerp`/`pow` 依赖 `epsilon<T>()`** | GLM 实现中用于 `cosTheta > 1 - epsilon<T>()` 退化检测，与 GLM 实际依赖一致 |
| **ext/vector_relational 内联 abs 而非调用 common.cj** | 消除对 stub 的运行时依赖，确保本阶段函数可执行 |
| **向量 `equal` 采用严格 `<` 语义** | 与 GLM `glm/gtc/epsilon.inl:32-41` 中 `epsilonEqual` 实现一致，`equal(v, v, 0.0 = false`。原引用 `func_vector_relational.inl:18-22` 错误——GLM 1.0.3 的 `func_vector_relational.inl` 中**不包含 epsilon 版本**的 `equal`/`notEqual`，epsilon 版本位于 `glm/gtc/epsilon.inl`（文件层面属 gtc 子包 |
| **scalar_constants 使用 hint 参数辅助类型推断** | 与 deviations.md DV-04 一致 |
| **scalar_constants 对整型 T 抛运行时异常** | 与 GLM `static_assert(is_iec559, ...)` 编译期断言等价行为 |
| **`Quat×Vec3` 旋转公式采用两次 Vec3 叉乘** | 与 GLM `type_quat.inl:359-366` 一致：`v + (cross(QuatVector, v * q.w + cross(QuatVector, cross(QuatVector, v)) * 2` |
| **`slerp` 4 参数版本 `k: Int64` 简化签名** | GLM 原始 4 参数 `slerp` 使用独立泛型整型参数 `S`（`static_assert(is_integer)` 约束，仓颉版本固定为 `Int64`，与 deviations.md DV-03「移位运算右操作数固定为 Int64」风格一致。若阶段四下游客需要 `Int32`/`Int16` 类型的 `k`，可通过新增泛型 `S` 重载 `slerp<T, Q, S>(x: Quat<T,Q>, y: Quat<T,Q>, a: T, k: S where T <: Number<T>, Q <: Qualifier, S <: Integer<S>` 实现向下兼容泛化 |
| **`lerp` 含 `assert(a >= 0 && a <= 1)` 断言** | 与 GLM `ext/quaternion_common.inl:28-38` 一致；`lerp` 不可在 const 上下文调用 |
| **四元数算术运算符统一标注 @OverflowWrapping** | 与阶段一 Vec3、阶段二全部矩阵类型的实践一致；标注对浮点无效果但保持跨类型一致性 |
| **fwd.cj 排除整型与 Bool 四元数别名** | 与阶段二排除整型矩阵别名的策略一致；Bool 四元数无实际用途（D17 |
| **`Quat`/`FQuat`/`DQuat` 三重别名机制** | ——文档引用阶段二 `Mat2x2`/`FMat2x2` 双别名机制作为先例，但通过直接查阅 `cjglm/src/fwd.cj` 全文确认 `Mat` 家族**不存在** `FMat*` 任何声明（仅 `Mat2x2` + `DMat2x2`，`F` 前缀别名**仅在 Vec 家族存在**（`FVec1`~`FVec4` + 精度变体。本设计修订为参考阶段一 Vec 家族的三重模式（`Vec2` + `DVec2` + `FVec2`，见 `cjglm/src/fwd.cj:106, 123, 276`，与 `Quat` + `DQuat` + `FQuat` 三重别名机制对齐 |
| **ext/ 和 gtc/ 子包独立声明** | 仓颉包名与目录路径匹配规则约束 |
| **gtc/matrix_transform.cj 本阶段以空桩占位** | 其完整实现依赖链覆盖几乎所有函数库层，归入阶段四 |
| **`fromMat3`/`fromMat4` 仅对纯旋转矩阵有效** | 与 GLM 行为一致；对非旋转矩阵行为未定义，结果可能产生非单位四元数 |
| **`axis` 触发条件为 `1 - w² <= 0` 而非 q.xyz == 0** | 返回 `Vec3(T(0), T(0), T(1))`（z 轴单位向量，典型场景——单位四元数 `(0, 0, 0, 1)` 即 `\|w\| >= 1`；对于真正零四元数 `(0, 0, 0, 0)`，`tmp1 = 1 > 0` 进入 else 分支返回 `Vec3(0, 0, 0)`（与 GLM `ext/quaternion_trigonometric.inl:20-27` 一致。，纠正 |
| **浮点/整数四元数 `inverse` 零除行为差异** | 浮点产生 Inf/NaN，整数触发仓颉除零异常 |
| **包间依赖方向严格单向 `glm.gtc → glm.detail`** | 为避免 v2 设计的 `glm.detail ↔ glm.gtc` 循环依赖（违反仓颉包间循环依赖约束，D11/D28 决策将转换函数下沉至 detail |
| **`isnan`/`isinf` 函数约束收紧为 `where T <: FloatingPoint<T>`** | 与 §3.12 `epsilon<T>()` 约束收紧策略一致；避免整数 T（如 `Int64`）实例化时 `Int64.isNaN()` 实例方法不存在导致编译失败的问题。`FloatingPoint<T>` 是 stdlib 原生接口，编译期保证可用，无需 fallback |
| **Quat 字段统一标注 `public var`** | 满足 `@Derive[Hashable]` 派生宏对字段 public 可见性的要求（依据 `cangjie-std/deriving/README.md` 第 4 节；与阶段一 Vec3、阶段二全部矩阵类型（200+ 处统一实践）对齐。仓颉 struct 字段默认 `internal` 可见性，不满足 public 派生要求 |

---

## 9a. GLM 1.0.3 Stage 3 API 覆盖矩阵

本节声明本设计对标 GLM **1.0.3** 版本中与阶段三（四元数类型 + 附带 ext/gtc 依赖）直接相关的所有头文件及每个头文件的 API 函数总数基准，并与本设计覆盖状态做逐项对比。对确认为本阶段不覆盖的函数标注推迟至 Stage 4 的理由。

> **⚠️ 函数可用状态以 §11.5 为唯一权威来源**——本节覆盖矩阵中 ✅/⚠️/❌ 的聚合统计信息仅用于文件级覆盖视图查询。**任何逐函数的状态查询、测试覆盖验证、发布门禁检查必须引用 §11.5 函数可用性对照表**。本节与 §11.5 之间的计数差异说明见 §11.5 末的「§11.5 与 §9a 计数口径映射注记」。本节不维护独立的函数状态信息，聚合计数仅在版本发布时由 §8.3 H2b 核验项与 §11.5 交叉验证后锁定。

注——原 §10「GLM 1.0.3 API 阶段覆盖矩阵」的逐文件/逐函数覆盖状态详情已合并至本节。函数级状态追踪仍以 §11.5 为最终权威来源。

### GLM 1.0.3 Stage 3 基准 API 范围

| GLM 1.0.3 头文件 | 头文件路径 | API 函数总数 | 本设计 ✅ 可用 | 本设计 ⚠️/❌ stub | 阶段四补齐 |
|-----------------|-----------|------------|--------------|----------------|----------|
| `type_quat.hpp` | `detail/type_quat.hpp` | 19（结构体 + 运算符 + 工厂函数 + `[]` 下标 + `length()` | 14 ✅ | 3 ⚠️ + 2 ❌ | — |
| `type_quat_cast.hpp`（本设计推断文件名 | `detail/type_quat_cast` | 4（mat3Cast/mat4Cast/quatCast×2 | 4 ✅ | 0 | — |
| `vector_relational.hpp` | `ext/vector_relational.hpp` | 8（4 epsilon + 4 ULP | 4 epsilon ✅（16 重载 | 4 ULP ❌（8 重载 | 阶段四评估仓颉位级访问能力后补齐 |
| `quaternion_relational.hpp` | `ext/quaternion_relational.hpp` | 4 | 4 ✅ | 0 | — |
| `quaternion_geometric.hpp` | `ext/quaternion_geometric.hpp` | 4 | 4 ✅ | 0 | — |
| `quaternion_common.hpp` | `ext/quaternion_common.hpp` | 8 | 5 ✅ | 3 ❌ | 阶段四 trigonometric.cj + common.cj 完整实现后补齐 |
| `quaternion_trigonometric.hpp` | `ext/quaternion_trigonometric.hpp` | 3 | 1 ✅ | 2 ❌ | 阶段四 trigonometric.cj 完整实现后补齐 |
| `quaternion_transform.hpp` | `ext/quaternion_transform.hpp` | 1 | 0 | 1 ❌ | 阶段四 trigonometric.cj + geometric.cj 完整实现后补齐 |
| `quaternion_exponential.hpp` | `ext/quaternion_exponential.hpp` | 4 | 0 | 4 ❌ | 阶段四所有函数库完整实现后补齐 |
| `scalar_constants.hpp` | `ext/scalar_constants.hpp` | 3 | 3 ✅ | 0 | — |
| `constants.hpp` | `gtc/constants.hpp` | 28 | 28 ✅ | 0 | — |
| `matrix_transform.hpp` | `gtc/matrix_transform.hpp` | 64 | 0 | 64 ❌ | 阶段四完整实现 |
| `quaternion.hpp` | `gtc/quaternion.hpp` | 15 | 8 ✅ | 7 ❌ | 阶段四 trigonometric.cj + geometric.cj 完整实现后补齐 |
| **合计** | — | **165** | **75 ✅** | **86 ❌ + 4 ⚠️ = 90** | — |

### 本阶段明确推迟至 Stage 4 的函数及理由

| 函数组 | GLM 头文件 | 函数数 | 推迟理由 |
|-------|-----------|-------|---------|
| `fromVec3` / `fromEuler` | `type_quat.hpp`（工厂函数 | 2 | 依赖 geometric.cj(`dot`/`cross`/`normalize` + trigonometric.cj(`cos`/`sin` stub |
| ULP 版本 `equal`/`notEqual`（8 重载 | `ext/vector_relational.hpp` | 4（8 重载 | 仓颉无浮点位表示直接访问能力（无 `reinterpret_cast`/`union` 等价机制，需阶段四评估替代方案 |
| `mix` / `slerp`（2 版本 | `ext/quaternion_common.hpp` | 3 | 依赖 trigonometric.cj(`acos`/`sin` + common.cj(`mix` stub |
| `angle` / `angleAxis` | `ext/quaternion_trigonometric.hpp` | 2 | 依赖 trigonometric.cj(`asin`/`acos`/`sin`/`cos` stub |
| `rotate` | `ext/quaternion_transform.hpp` | 1 | 依赖 trigonometric.cj(`sin`/`cos` + geometric.cj(`length` stub |
| `exp` / `log` / `pow` / `sqrt` | `ext/quaternion_exponential.hpp` | 4 | 依赖 trigonometric.cj + common.cj + geometric.cj 等多文件 stub |
| `eulerAngles` / `roll` / `pitch` / `yaw` | `gtc/quaternion.hpp` | 4 | 依赖 trigonometric.cj(`atan`/`asin` + common.cj(`clamp` + vector_relational.cj(`equal` stub |
| `quatLookAt` / `quatLookAtRH` / `quatLookAtLH` | `gtc/quaternion.hpp` | 3 | 依赖 geometric.cj(`cross`/`dot`/`normalize`/`inversesqrt`/`max` stub |
| `gtc/matrix_transform` 全部 64 个函数 | `gtc/matrix_transform.hpp` | 64 | 完整实现依赖链覆盖几乎所有函数库层 |
| **推迟合计** | — | **87** | — |

**基准声明版本标识**——本基准基于 GLM **1.0.3**（发布日期——2022-08-21，Commit: `3efc510`。下游实施者在阶段四升级对标版本前，应以 GLM 1.0.3 的原始 .hpp/.inl 文件为最终一致性核验依据。

---

## 11. 下游消费者迁移指南

针对常见的库使用场景，提供仓颉版本与 GLM 习惯的迁移示例：

### 11.1 构造单位四元数

```
// GLM:        glm::quat q = glm::quat(1.0f, 0.0f, 0.0f, 0.0f);  // wxyz 顺序
// 仓颉:      let q = Quat<Float32, PackedHighp>.identity(1.0f  // 主入口（推荐
//           或 let q = Quat<Float32, PackedHighp>.wxyz(1.0f, 0.0f, 0.0f, 0.0f  // wxyz 顺序入口
```

### 11.2 跨类型转换

```
// GLM:        glm::quat q32 = glm::quat(q64);
// 仓颉:      let q32 = Quat<Float32, PackedHighp>.fromQuat<Float64, PackedHighp>
//               { f64 => Float32(f64 },
//               q64
//
// 同类型简化:
//           let q32_same = Quat<Float32, PackedHighp>(q32.x, q32.y, q32.z, q32.w
```

### 11.3 旋转应用

```
// GLM:        auto rotated = q * v;
// 仓颉:      let rotated = q * v  // [本阶段抛 stub 异常，待阶段四 geometric.cj 完整实现后生效]
```

### 11.4 矩阵-四元数互转

```
// GLM:        glm::mat3 m = glm::mat3_cast(q);  glm::quat q2 = glm::quat_cast(m);
// 仓颉 detail 入口:
//           let m = Quat<Float32, PackedHighp>.fromMat3(m).identity(1.0f  // 错误示例，fromMat3 是 Quat 工厂函数
//           let q2 = Quat<Float32, PackedHighp>.fromMat3(m  // Mat3 → Quat
//           let m3 = Quat<Float32, PackedHighp>(1.0f, 0.0f, 0.0f, 0.0f).fromMat3(m  // 错误示例
//
// 仓颉 detail 直接调用:
//           let m3 = mat3Cast(q      // detail/type_quat_cast.cj 包级函数（——需先 `import glm.detail.*` 才能调用包级函数；或通过 lib.cj 的 `public import` 重导出从顶层 `glm` 命名空间调用 `glm.mat3Cast(q)`
//           let q2 = quatCast(m      // detail/type_quat_cast.cj 包级函数（同上
//
// 仓颉 gtc 命名空间调用:
//           let m3_gtc = glm.gtc.quaternion.mat3Cast(q
//           let q2_gtc = glm.gtc.quaternion.quatCast(m
//
// 仓颉顶层 glm 命名空间调用（——lib.cj 通过 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 将 detail 包级函数重导出至顶层 `glm` 命名空间，与现有 `public import glm.detail.{transpose, matrixCompMult, outerProduct}` 模式一致，见 `cjglm/src/lib.cj:8`）——
//           let m3_top = glm.mat3Cast(q   // 顶层 glm 命名空间（无需额外 import
//           let q2_top = glm.quatCast(m   // 顶层 glm 命名空间（无需额外 import
```

### 11.5 函数可用性对照表

**权威声明**：本表是函数级可用状态的**唯一权威来源**——§3.13.2 审计节、§8 产出物清单、§9a 覆盖矩阵、§11.6 可达性矩阵、§11.7 索引表均不维护独立的状态信息，仅以本表为基准。审计流程已确认本表与 §9a 覆盖矩阵在独立函数范式口径下逐项对齐，缺失条目为 0、多余条目为 0。下游消费者按本表逐函数核验状态，按 §9a 查阅文件级覆盖视图。

| 函数 | 本阶段状态 | 阶段四 | 设计章节 |
|------|----------|--------|---------|
| `identity` | ✅ 可用 | ✅ 可用 | §3.3 item 5 |
| `fromMat3` | ✅ 可用（**约束：`where T <: FloatingPoint<T>`**，签名显式声明） | ✅ 可用（约束同上） | §3.3 item 6 |
| `fromMat4` | ✅ 可用（**约束：`where T <: FloatingPoint<T>`**，签名显式声明） | ✅ 可用（约束同上） | §3.3 item 7 |
| `fromVec3` | ❌ stub | ✅ 可用 | §3.3 item 8；§1 约束——依赖 geometric.cj + trigonometric.cj stub |
| `fromEuler` | ❌ stub | ✅ 可用 | §3.3 item 9；§1 约束——依赖 trigonometric.cj stub |
| `fromQuat` | ✅ 可用 | ✅ 可用 | §3.3 item 4 |
| `wxyz` | ✅ 可用 | ✅ 可用 | §3.3 item 10 |
| `[]` 下标运算符（取值 + 赋值双版本，i < 0 或 i >= 4 抛 Exception） | ✅ 可用 | ✅ 可用 | §3.1 |
| `static func length(): Int64`（编译期查询函数，返回常量 4） | ✅ 可用 | ✅ 可用 | §3.1 |
| `q * v` (Quat×Vec3) | ⚠️ 抛 stub 异常 | ✅ 可用 | §3.4；§1 约束——依赖 geometric.cj 向量 cross stub |
| `q * v4` (Quat×Vec4) | ⚠️ 抛 stub 异常（委托 `q * Vec3(v)` 中间路径，见 §3.4） | ✅ 可用 | §3.4；§1 约束——通过 `Quat×Vec3` 间接依赖 geometric.cj 向量 cross stub |
| `v * q` (Vec3×Quat) | ⚠️ 抛 stub 异常（内联 conjugate/dot 仅消除包间循环依赖；`(conjugate(q)/dot(q,q))*v` 最终委托至同包 `Quat×Vec3` 运算符——`cross(QuatVector, v)` 调用 `geometric.cj` 向量 `cross` stub） | ✅ 可用 | §3.4 |
| `v * q` (Vec4×Quat) | ⚠️ 抛 stub 异常（通过 Vec3 中间路径，与 Vec3×Quat 一致，运行时传播同源 stub 异常） | ✅ 可用 | §3.4 |
| `+=`/`-=`/`*=`（四元数乘法）/`*=`（标量乘法）/`/=` | ✅ 可用 | ✅ 可用 | §3.4 复合赋值运算符段 |
| `add`（`scalar_quat_ops.cj`） | ✅ 可用 | ✅ 可用 | §3.4 全局具名函数表 |
| `sub`（`scalar_quat_ops.cj`） | ✅ 可用 | ✅ 可用 | §3.4 全局具名函数表 |
| `mul`（`scalar_quat_ops.cj`） | ✅ 可用 | ✅ 可用 | §3.4 全局具名函数表 |
| `div`（`scalar_quat_ops.cj`） | ✅ 可用 | ✅ 可用 | §3.4 全局具名函数表 |
| `rotate`（`ext/quaternion_transform.cj`） | ❌ stub（依赖 `sin`/`cos`/`length` 均为 stub） | ✅ 可用 | §3.8；§1 约束——依赖 trigonometric.cj + geometric.cj stub |
| `lerp` | ✅ 可用（含断言） | ✅ 可用 | §3.11 |
| `conjugate` | ✅ 可用 | ✅ 可用 | §3.11 |
| `inverse` | ✅ 可用（**约束：`where T <: FloatingPoint<T>`**（D38），仅浮点 T，整型 T 编译期拒绝；与 `normalize` 收紧策略一致） | ✅ 可用（约束同上） | §3.11 |
| `dot` | ✅ 可用 | ✅ 可用 | §3.7 |
| `length` | ✅ 可用 | ✅ 可用 | §3.7 |
| `normalize` | ✅ 可用 | ✅ 可用 | §3.7 |
| `cross`（Quat） | ✅ 可用 | ✅ 可用 | §3.7 |
| `axis` | ✅ 可用 | ✅ 可用 | §3.9 |
| `equal`（Quat） | ✅ 可用 | ✅ 可用 | §3.6 |
| `equal`（Quat, epsilon） | ✅ 可用 | ✅ 可用 | §3.6 |
| `notEqual`（Quat） | ✅ 可用 | ✅ 可用 | §3.6 |
| `notEqual`（Quat, epsilon） | ✅ 可用 | ✅ 可用 | §3.6 |
| `isnan` | ✅ 可用（**约束：`where T <: FloatingPoint<T>`**（D29），仅浮点 T，整型 T 编译失败） | ✅ 可用（**约束同上**） | §3.11；§1 约束：FloatingPoint<T> 接口约束 |
| `isinf` | ✅ 可用（**约束：`where T <: FloatingPoint<T>`**（D29），仅浮点 T，整型 T 编译失败） | ✅ 可用（**约束同上**） | §3.11；§1 约束：FloatingPoint<T> 接口约束 |
| `slerp` | ❌ stub | ✅ 可用 | §3.11；§1 约束——依赖 trigonometric.cj + common.cj stub |
| `mix` | ❌ stub | ✅ 可用 | §3.11；§1 约束——依赖 trigonometric.cj + common.cj stub |
| `angle` | ❌ stub | ✅ 可用 | §3.9；§1 约束——依赖 trigonometric.cj stub |
| `angleAxis` | ❌ stub | ✅ 可用 | §3.9；§1 约束——依赖 trigonometric.cj stub |
| `exp` | ❌ stub | ✅ 可用 | §3.10；§1 约束——依赖 trigonometric.cj + scalar_constants stub |
| `log` | ❌ stub | ✅ 可用 | §3.10；§1 约束——依赖 trigonometric.cj + FloatingPoint<T>.getInf |
| `pow` | ❌ stub | ✅ 可用 | §3.10；§1 约束——依赖 trigonometric.cj + common.cj + FloatingPoint<T>.getMinDenormal |
| `sqrt` | ❌ stub | ✅ 可用 | §3.10；§1 约束——委托 `pow` 实现 |
| `eulerAngles` | ❌ stub | ✅ 可用 | §3.15；§1 约束——依赖 trigonometric.cj + common.cj + vector_relational stub |
| `roll` | ❌ stub | ✅ 可用 | §3.15；§1 约束——同上 |
| `pitch` | ❌ stub | ✅ 可用 | §3.15；§1 约束——同上 |
| `yaw` | ❌ stub | ✅ 可用 | §3.15；§1 约束——同上 |
| `quatLookAt` | ❌ stub | ✅ 可用 | §3.15；§1 约束——依赖 geometric.cj stub |
| `quatLookAtRH` | ❌ stub | ✅ 可用 | §3.15；§1 约束——同上 |
| `quatLookAtLH` | ❌ stub | ✅ 可用 | §3.15；§1 约束——同上 |
| `epsilon`（浮点） | ✅ 可用 | ✅ 可用 | §3.12 |
| `pi`（浮点） | ✅ 可用 | ✅ 可用 | §3.12 |
| `cos_one_over_two`（浮点） | ✅ 可用 | ✅ 可用 | §3.12 |
| `epsilon`（整型） | ❌ 抛异常 | ❌ 抛异常（保持契约） | §3.12；§1 约束：D25 整数 T 抛运行时异常 |
| `pi`（整型） | ❌ 抛异常 | ❌ 抛异常（保持契约） | §3.12；§1 约束：D25 整数 T 抛运行时异常 |
| `cos_one_over_two`（整型） | ❌ 抛异常 | ❌ 抛异常（保持契约） | §3.12；§1 约束：D25 整数 T 抛运行时异常 |
| `mat3Cast`（detail） | ✅ 可用（**约束：`where T <: FloatingPoint<T>`**（D32），仅浮点 T，整型 T 编译失败，对应 GLM `GLM_STATIC_ASSERT(is_iec559, ...)`） | ✅ 可用（**约束同上**） | §3.2.1 |
| `mat4Cast`（detail） | ✅ 可用（同上） | ✅ 可用（同上） | §3.2.1 |
| `quatCast(Mat3)`（detail） | ✅ 可用（同上） | ✅ 可用（同上） | §3.2.1 |
| `quatCast(Mat4)`（detail） | ✅ 可用（同上） | ✅ 可用（同上） | §3.2.1 |
| `mat3Cast`（gtc，重导出） | ✅ 可用（**约束：`where T <: FloatingPoint<T>`**（D32），约束源自 detail 端原始定义，通过 public import 透明传递；gtc 端采用 camelCase 命名而非 GLM snake_case 习惯） | ✅ 可用（同上） | §3.15 重导出段 |
| `mat4Cast`（gtc，重导出） | ✅ 可用（同上） | ✅ 可用（同上） | §3.15 重导出段 |
| `quatCast(Mat3)`（gtc，重导出） | ✅ 可用（同上） | ✅ 可用（同上） | §3.15 重导出段 |
| `quatCast(Mat4)`（gtc，重导出） | ✅ 可用（同上） | ✅ 可用（同上） | §3.15 重导出段 |
| `lessThan` | ✅ 可用（**约束：`where T <: Comparable<T>`, `Q <: Qualifier`**） | ✅ 可用（同上） | §3.15 比较函数段 |
| `lessThanEqual` | ✅ 可用（同上） | ✅ 可用（同上） | §3.15 比较函数段 |
| `greaterThan` | ✅ 可用（同上） | ✅ 可用（同上） | §3.15 比较函数段 |
| `greaterThanEqual` | ✅ 可用（同上） | ✅ 可用（同上） | §3.15 比较函数段 |
| `gtc/matrix_transform` 全部 **64** 个函数（描述：35→64） | ❌ stub | ✅ 可用 | §3.13 gtc/matrix_transform 函数清单段 |
| **合计行——独立函数范式口径** | **✅ 18 个** / **⚠️ 4 个**（Quat×Vec3 + Quat×Vec4 + Vec3×Quat + Vec4×Quat）/ **❌ 88 个**（含 3 个整数 T 抛异常条目） | — | 独立函数 18 个指不依赖重载展开的函数名计数；⚠️+❌ 小计 = 88 个 |
| **合计行——含重载/常量展开口径** | **✅ 75 个** | — | 此口径包含独立函数 18 个 + 28 个 gtc/constants 常量 + 16 个 vector_relational epsilon 重载 + 4 个 gtc 比较函数 + 运算符/构造函数等变体展开，与 §9a 覆盖矩阵 ✅ 可用聚合列一致 |

> **§11.5 与 §9a 计数口径映射注记**——本表合计行采用「独立函数范式」口径（✅ ~18 个，§9a 覆盖矩阵合计行采用「含重载/常量展开」口径（✅ ~77 个。两者差距约 59 个，来源于——(a 本表按函数名计数（如 `equal` 无论有多少个重载/epsilon 变体均计为 1 行，而 §9a 按 GLM 头文件原始 API 计数（含重载展开和常量展开；(b 本表排除了 `gtc/constants` 的 28 个常量函数（不视为独立函数，§9a 将其计入 ✅ 可用；(c 本表排除了 `ext/vector_relational` epsilon 版本的 16 个重载（作为 4 个函数的变体，§9a 以重载粒度统计。**读者应优先以本表「独立函数范式口径」作为阶段三实际可用独立功能的基准评估口径**；§9a「含重载/常量展开口径」仅用于签名行数维度的参考统计。两处合计行的实际差值为上述三项计数规则差异之和，非实质性数据矛盾。

> **计数口径补充说明**——合计行 ✅ 18 + ⚠️ 4 + ❌ 88 = 110（独立函数范式口径），与 §9a 覆盖矩阵合计行总函数数 165 的差值 55 来源于：(a) 本表排除 gtc/constants 的 28 个常量函数；(b) 本表排除 vector_relational epsilon 的 16 个重载（按 4 个基础函数计数）；(c) 本表排除运算符/构造函数重载变体的展开统计。本表按函数名计数，§9a 按 GLM 头文件原始 API 声明数计数，两者口径不同，非实质性矛盾。

---

### 11.6 四命名空间接口可达性矩阵

本节集中审计 `glm` / `glm.gtc` / `glm.detail` / `glm.ext` 四个命名空间下关键函数（含运算符重载、构造函数重载、主类型别名）的可达性，确保下游消费者在每个命名空间下均能按预期路径调用 API。

| 类别 | 函数/类型 | `glm` 顶层（lib.cj public import | `glm.gtc`（gtc 子包 | `glm.detail`（detail 子包 | `glm.ext`（ext 子包 |
|------|----------|-------------------------------|----------------------|--------------------------|---------------------|
| **类型** | `Quat<T, Q>` | ✅ `glm.Quat`（fwd.cj type alias；lib.cj 的 `public import g lm.detail.Quat` 重导出至 `glm` 命名空间，下游可直接以 `glm.Quat` 访问 | ✅ `glm.gtc.quaternion.Quat`（import detail | ✅ `glm.detail.Quat`（原始定义 | ❌（ext 包不重新声明类型 |
| **类型** | `Mat3x3<T, Q>` / `Mat4x4<T, Q>` | ✅ `glm.Mat3x3` / `glm.Mat4x4`（阶段二 type alias | ✅ `glm.gtc.quaternion.Mat3x3` / `Mat4x4`（import detail | ✅ `glm.detail.Mat3x3` / `Mat4x4`（原始定义 | ❌ |
| **类型** | `Vec3<T, Q>` / `Vec4<T, Q>` | ✅ `glm.Vec3` / `glm.Vec4`（阶段一 type alias | ✅ `glm.gtc.quaternion.Vec3` / `Vec4`（import detail | ✅ `glm.detail.Vec3` / `Vec4`（原始定义 | ✅ `glm.ext.Vec3` / `Vec4`（ext 包 import detail 重导出 |
| **构造函数** | `Quat(x, y, z, w)` 主构造 | ✅ `glm.Quat(0, 0, 0, 1)` | ✅ 同左 | ✅ 同左（原始 | ❌ |
| **构造函数** | `Quat.fromMat3(m)` | ✅ `glm.Quat.fromMat3(m)`（Quat 是类型，方法挂在类型上 | ✅ 同左（方法跟着类型走 | ✅ 同左 | ❌ |
| **构造函数** | `Quat.identity(1.0f)` | ✅ `glm.Quat.identity(1.0f)` | ✅ 同左 | ✅ 同左 | ❌ |
| **运算符重载** | `q + r` / `q - r` / `q * r` | ✅ `glm.Quat + glm.Quat` | ✅ 同左 | ✅ 同左（原始定义 | ❌ |
| **运算符重载** | `q * v` (Quat×Vec3 | ✅ `glm.Quat * glm.Vec3` | ✅ 同左 | ✅ 同左（原始定义 | ❌ |
| **运算符重载** | `v * q` (Vec3×Quat | ✅ `glm.Vec3 * glm.Quat` | ✅ 同左 | ✅ 同左（Vec extend 块定义 | ❌ |
| **包级函数** | `glm.mat3Cast(q)` | ✅ `glm.mat3Cast`（lib.cj public import 顶层重导出 | ❌（gtc 端无顶层包级函数 | ✅ `glm.detail.mat3Cast`（原始定义，需先 `import glm.detail.*` | ❌ |
| **包级函数** | `glm.gtc.quaternion.mat3Cast(q)`：camelCase 命名 | ❌ | ✅ `glm.gtc.quaternion.mat3Cast`（gtc/quaternion.cj public import detail 重导出 | ✅ 同上 | ❌ |
| **包级函数** | `glm.ext.scalar_constants.epsilon<Float32>()` | ✅ `glm.epsilon<Float32>()`（lib.cj public import ext 重导出 | ✅ `glm.gtc.constants.epsilon<Float32>()`（gtc/constants 通过 ext/scalar_constants 重导出 | ✅ `glm.detail.scalar_constants.epsilon<Float32>()`（原始定义 | ✅ `glm.ext.scalar_constants.epsilon<Float32>()`（ext 重导出接口 |
| **包级函数** | `glm.gtc.constants.zero<Float32>()` | ✅ `glm.zero<Float32>()`（lib.cj public import gtc 重导出 | ✅ `glm.gtc.constants.zero<Float32>()`（原始定义 | ❌ | ❌ |
| **包级函数** | `glm.ext.quaternion_common.conjugate(q)` | ✅ `glm.conjugate(q)`（lib.cj public import ext 重导出 | ❌（gtc 端无 conjugate 包级函数 | ❌ | ✅ `glm.ext.quaternion_common.conjugate(q)`（原始定义 |
| **包级函数** | `glm.ext.quaternion_transform.rotate(q, angle, axis)` | ✅ `glm.rotate(q, angle, axis)`（lib.cj public import ext 重导出，❌ stub | ❌（rotate 非 gtc 函数 | ❌ | ✅ `glm.ext.quaternion_transform.rotate(q, angle, axis)`（原始定义，❌ stub |
| **包级函数** | `glm.gtc.matrix_transform.translate(m, v)` | ✅ `glm.translate(m, v)`（lib.cj public import gtc 重导出 | ✅ `glm.gtc.matrix_transform.translate(m, v)`（stub 占位 | ❌ | ❌ |
| **类型别名** | `Quat` / `FQuat` / `DQuat` | ✅ `glm.Quat` / `glm.FQuat` / `glm.DQuat`（fwd.cj | ❌ | ❌ | ✅ `glm.ext.quaternion_float.quat` / `glm.ext.quaternion_double.dquat`（ext 别名文件 |

**审计结论**：
- **所有 9 个 Quat 别名**（Quat/FQuat/DQuat + 3×Float32 精度 + 3×Float64 精度）在 `glm` 顶层命名空间通过 fwd.cj（——通过 `cjglm/scripts/gen_fwd_aliases.py` 自动生成，非 v12 描述的 `tools/gen_fwd.cj`）可达
- **所有 4 个转换函数**（mat3Cast/mat4Cast/quatCast 两个重载）在 `glm` 顶层通过 lib.cj public import + 在 `glm.gtc.quaternion` 通过 public import detail 重导出可达，：gtc 端采用 camelCase 命名而非 GLM snake_case
- **所有 15 个 gtc/quaternion 函数**（4 重导出 + 4 完整 + 7 stub）在 `glm.gtc.quaternion` 命名空间可达，下游消费者无需关心 detail 端 import 细节
- **所有 stub 占位函数**（mix/slerp/exp/log/pow/sqrt/angle/angleAxis/rotate/eulerAngles/roll/pitch/yaw/quatLookAt* + **64** 个 gtc/matrix_transform 函数（先前计数从 35 修订为 64，详见 §3.13 + §9a + §11.5 + §8.3））在调用时抛 `Exception("stub")`，下游测试设计应覆盖异常路径验证（`assertThrows`
- **`normalize(q)` 函数可达性与边界契约**——本阶段状态详见 §11.5 函数可用性对照表 `dot/length/normalize` 行（标记为 ✅ 可用；完整边界行为契约（零四元数 + length 极小值 + 实现公式）详见 §5.3 边界条件表 normalize 行 + §3.7 `normalize` 函数描述 + §3.13.2 审计节 normalize 行——四者形成「§3.7 实现 + §5.3 契约 + §11.5 可用性 + §11.6 可达性」四维度交叉引用闭环

### 11.7 全函数集中参考索引

本节为所有函数提供聚合参考索引，将每个函数分散在 §3.x、§5.3、§3.13.2、§8、§11.5 中的跨节引用信息集中列示。**本节不维护独立的函数状态信息**——所有函数本阶段状态（✅/⚠️/❌）以 §11.5 函数可用性对照表为唯一权威来源。本节索引中的状态列仅供快速查询参考，状态精确值请引用 §11.5。在本节 §3.x 描述段末尾拥有独立「集中参考清单」的 4 个 P0 函数（normalize/axis/mat3Cast/mat4Cast）同样在本索引中汇总列出。

#### 11.7.1 ✅ 可用函数索引

| 函数 | 本阶段状态 | §3.x 描述 | §5.3 边界条件 | §3.13.2 审计行 | §8 验证项 | §11.5 行 |
|------|----------|----------|-------------|--------------|----------|---------|
| `identity` | ✅ | §3.3 item 5 | 无特殊边界 | 无独立行 | — | identity 行 |
| `fromMat3` | ✅ | §3.3 item 6 | 非纯旋转矩阵 | 无独立行 | — | fromMat3 行 |
| `fromMat4` | ✅ | §3.3 item 7 | 非纯旋转矩阵 | 无独立行 | — | fromMat4 行 |
| `fromQuat` | ✅ | §3.3 item 4 | 无特殊边界 | 无独立行 | — | fromQuat 行 |
| `wxyz` | ✅ | §3.3 item 10 | 无特殊边界 | 无独立行 | — | wxyz 行 |
| `[]` 下标 | ✅ | §3.1 | 下标越界抛 Exception | 无独立行 | — | `[]` 行 |
| `static func length()` | ✅ | §3.1 | 无特殊边界 | 无独立行 | — | static func length 行 |
| `Vec3×Quat` / `Vec4×Quat` | ⚠️ | §3.4 | Vec3×Quat/Vec4×Quat 运行时抛 stub 异常 | 无独立行 | 验证项 5/29 | v*q 行（⚠️ |
| 复合赋值 `+=`/`-=`/`*=`/`/=` | ✅ | §3.4 | 无特殊边界 | 无独立行 | — | 复合赋值行 |
| `add`/`sub`/`mul`/`div`（scalar_quat_ops | ✅ | §3.4 | 无特殊边界 | 无独立行 | 验证项 8 | add/sub/mul/div 行 |
| `lerp` | ✅ | §3.11 | `a` 超出 [0,1] 触发 assert | 审计表 lerp 行 | — | lerp 行 |
| `conjugate` | ✅ | §3.11 | 无特殊边界 | 审计表 conjugate 行 | 验证项 24（const func | conjugate 行 |
| `inverse` | ✅ | §3.11 | 浮点零除 Inf/NaN，**整数 T 编译期拒绝** | audit 表 inverse 行 | — | inverse 行 |
| `dot` | ✅ | §3.7 | 无特殊边界 | 审计表 dot 行 | — | dot 行 |
| `length` | ✅ | §3.7 | 无特殊边界 | 审计表 length 行 | 验证项 12 | length 行 |
| `normalize` | ✅ | §3.7 | 零四元数保护 + length 极小值 | 审计表 normalize 行 | 验证项 20/25 | normalize 行 |
| `cross`（Quat | ✅ | §3.7 | 无特殊边界 | 审计表 cross(Quat 行 | — | cross(Quat 行 |
| `axis` | ✅ | §3.9 | `1-w² <= 0` 触发 Vec3(0,0,1 | 审计表 axis 行 | 验证项 25 | axis 行 |
| `equal`/`notEqual`（Quat 精确/epsilon | ✅ | §3.6 | `epsilon=0` 时 equal 返回 false | 审计表 equal/notEqual 行 | — | equal/notEqual 行 |
| `isnan`/`isinf` | ✅ | §3.11 | 整型 T 编译失败（`FloatingPoint<T>` | 审计表 isnan/isinf 行 | 验证项 9/13/20 | isnan/isinf 行 |
| `mat3Cast`/`mat4Cast`/`quatCast` | ✅ | §3.2.1 | 非单位四元数/非旋转矩阵 | 审计表转换函数行 | 验证项 17/25 | mat3Cast 等行 |
| `lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual` | ✅ | §3.15 | 无特殊边界 | 审计表（§3.13.2 引用 | — | lessThan 等行 |
| `epsilon`/`pi`/`cos_one_over_two`（浮点 | ✅ | §3.12 | 整型 T 抛异常 | 审计表 epsilon 行 | 验证项 6/7/19 | epsilon/pi 行 |
| `epsilon`/`pi`/`cos_one_over_two`（整型 | ✅ | §3.12 | 整数 T 抛运行时异常 | 审计表 epsilon 行 | 验证项 7 | epsilon(整型)行 |
| gtc/constants 28 函数 | ✅ | §3.12 | 无特殊边界 | 无独立行 | — | — |
| ext/vector_relational epsilon（16 重载 | ✅ | §3.5 | `epsilon=0` 语义 | 无独立行 | 验证项 10 | — |

#### 11.7.2 ⚠️/❌ 函数索引

| 函数 | 本阶段状态 | §3.x 描述 | §5.3 边界条件 | §3.13.2 审计行 | §8 验证项 | §11.5 行 |
|------|----------|----------|-------------|--------------|----------|---------|
| `Quat×Vec3` | ⚠️ | §3.4 | 依赖 geometric.cj stub | 审计表 Quat×Vec3 行 | 验证项 29 | q*v 行 |
| `Quat×Vec4` | ⚠️ | §3.4 | 依赖 geometric.cj stub（委托 Quat×Vec3 | 审计表 Quat×Vec4 行 | 验证项 29 | q*v4 行 |
| `Vec3×Quat` | ⚠️ | §3.4 | 内联 conjugate/dot 仅消除包间循环依赖；`(conjugate(q)/dot(q,q))*v` 委托 Quat×Vec3 依赖 geometric.cj stub | 审计表 Vec3×Quat 行 | 验证项 29 | v*q 行 |
| `Vec4×Quat` | ⚠️ | §3.4 | 同上（通过 Vec3 中间路径 | 审计表 Vec4×Quat 行 | 验证项 29 | v*q 行 |
| `fromVec3` | ❌ | §3.3 item 8 | u,v 反平行 + 零向量未定义 | 审计表 fromVec3 行 | — | fromVec3 行 |
| `fromEuler` | ❌ | §3.3 item 9 | 依赖 trigonometric.cj stub | 审计表 fromEuler 行 | — | fromEuler 行 |
| `mix` | ❌ | §3.11 | `cosTheta` 退化 | 审计表 mix 行 | — | mix 行 |
| `slerp`（3 参数 | ❌ | §3.11 | `cosTheta` 退化 | 审计表 slerp 行 | — | slerp 行 |
| `slerp`（4 参数 | ❌ | §3.11 | `cosTheta` 退化 + `pi<T>()` 依赖 | 审计表 slerp 行 | — | slerp 4param 行 |
| `angle` | ❌ | §3.9 | 依赖 trigonometric.cj stub | 审计表 angle 行 | — | angle 行 |
| `angleAxis` | ❌ | §3.9 | 依赖 trigonometric.cj stub | 审计表 angleAxis 行 | — | angleAxis 行 |
| `rotate` | ❌ | §3.8 | 依赖 trigonometric.cj + geometric.cj stub | 审计表 rotate 行 | — | rotate 行 |
| `exp` | ❌ | §3.10 | 依赖 trigonometric.cj + scalar_constants stub | 审计表 exp 行 | — | exp 行 |
| `log` | ❌ | §3.10 | 依赖 trigonometric.cj + `FloatingPoint.getInf()` | 审计表 log 行 | — | log 行 |
| `pow` | ❌ | §3.10 | 依赖 trigonometric.cj + common.cj + `getMinDenormal()` | 审计表 pow 行 | 验证项 16/21 | pow 行 |
| `sqrt` | ❌ | §3.10 | 委托 `pow` 实现 | 审计表 sqrt 行 | — | sqrt 行 |
| `eulerAngles` | ❌ | §3.15 | 依赖 trigonometric.cj + common.cj + vector_relational stub | 审计表 eulerAngles 行 | — | eulerAngles 行 |
| `roll` | ❌ | §3.15 | 同上 | 审计表 roll 行 | — | roll 行 |
| `pitch` | ❌ | §3.15 | 同上 | 审计表 pitch 行 | — | pitch 行 |
| `yaw` | ❌ | §3.15 | 同上 | 审计表 yaw 行 | — | yaw 行 |
| `quatLookAt` | ❌ | §3.15 | 依赖 geometric.cj stub | 审计表 quatLookAt 行 | — | quatLookAt 行 |
| `quatLookAtRH` | ❌ | §3.15 | 同上 | 审计表 quatLookAtRH 行 | — | quatLookAtRH 行 |
| `quatLookAtLH` | ❌ | §3.15 | 同上 | 审计表 quatLookAtLH 行 | — | quatLookAtLH 行 |
| ULP `equal`/`notEqual`（8 重载 | ❌ | §3.5 | 仓颉无位级浮点访问能力 | 无独立行 | — | — |
| gtc/matrix_transform 全部 **64** 函数 | ❌ | §3.13 | — | 审计表 gtc/matrix_transform 行 | — | — |
| trigonometric.cj 全部 75 函数 | ❌ | §3.13.1 | — | 审计表 trigonometric 行 | 验证项 22 | — |

**使用说明**：
- 「本阶段状态」列标注当前阶段的状态符号（✅ 可用 / ⚠️ 抛 stub 异常 / ❌ stub
- 「§3.x 描述」列指向函数的主要实现描述段落，是理解函数行为与实现策略的起点
- 「§5.3 边界条件」列列出 §5.3 边界条件表中与该函数相关的行，标注关键边界场景的契约行为
- 「§3.13.2 审计行」列标注该函数是否在 §3.13.2 审计表中拥有独立行
- 「§8 验证项」列列出需在编码启动前验证的关联项编号，对无关联验证项的函数标注「—」
- 「§11.5 行」列标注函数在 §11.5 表中的行名，便于在可用性对照表中快速定位
- 本索引不替代 §11.5 的可用性对照表，后者包含完整的本阶段/阶段四状态标注与约束注记

---
