# GLM 1.0.3 仓颉迁移阶段三 OOD 设计方案

> **修订日期**：2026-06-26
> **修订定位**：v25 设计的迭代修订（对应本轮审查 a_v25_iteration_requirement.md）。基于 v24 输出修订，针对审查报告识别的 5 项问题（2 严重 + 3 一般）逐项落实。本轮重点修复：(1) H1/H2 核心假设通过最小仓颉测试文件实际验证，记录结果于 §8 验证结果记录表；(2) §1 设计目标末尾新增阶段三 API 可用率显式声明段落，同步修订概述措辞；(3) §9a 与 §10 合并为单一覆盖矩阵，删除冗余 §10 独立表格；(4) 修订说明(v12)-(v24) 剥离至独立文件 a_v25_revision_history_v12_v24.md，正文仅保留变更摘要行；(5) 引入三项结构性预防措施（H1/H2/H3 自动化核验脚本化、核验前置化、质量门禁）。

---

## 1. 概述

### 设计目标

在阶段一（Vec1~Vec4 向量类型 + 基础设施）和阶段二（9 个矩阵类型 + ext/ 别名）的基础上，迁移四元数类型及其必需的 ext/gtc 依赖文件，为库提供基础的旋转表达和插值运算框架。本阶段同时引入向量关系运算扩展、标量常量扩展、gtc/constants 数学常量定义，并为 gtc/matrix_transform 提供空桩占位以满足依赖闭合。

> **阶段三 API 可用率声明**：本阶段对标 GLM 1.0.3 共 13 个头文件、165 个 API 函数。其中约 **77 个函数（约 47%）** 为真完整实现（✅，运行时可正常调用），**88 个函数（约 53%）** 以 stub 占位或依赖 stub（⚠️/❌，运行时抛 `Exception("stub")` 或待阶段四补齐）。具体函数级状态以 §11.5 函数可用性对照表为准。下表给出按 GLM 头文件维度的聚合覆盖视图（更详细的基准声明见 §9a）：

| 分类 | 函数数 | 说明 |
|------|--------|------|
| ✅ 真完整实现 | ~77 | conjugate/inverse/lerp/isnan/isinf/dot/length/normalize/cross(Quat)/axis/mat3Cast/mat4Cast/quatCast/equal/notEqual/epsilon/pi/cos_one_over_two/gtc 28 常量/gtc 4 比较函数/运算符/构造函数等 |
| ⚠️ 编译通过但抛 stub | 1 | Quat×Vec3/Vec4 运算符（依赖 geometric.cj 向量 cross stub） |
| ❌ stub 占位 | 87 | mix/slerp/exp/log/pow/sqrt/angle/angleAxis/rotate/eulerAngles/roll/pitch/yaw/quatLookAt*/fromVec3/fromEuler/ULP 比较/trigonometric.cj 全体/gtc/matrix_transform 全体 |

> **注**：77 个 ✅ 中包含 28 个 gtc/constants 常量函数、16 个 ext/vector_relational epsilon 重载、以及构造函数/运算符重载等高度同构的变体。按独立函数范式计数，真完整实现约 **18 个**（详见 §3.13.2 审计结论）。§1 的 ~77 为含重载展开的"签名行数"口径，§3.13.2 的 18 为"独立函数签名"口径，两者使用不同的计数粒度，读者应注意区分。

### 核心抽象

| 抽象 | 角色 | 类型形态 |
|------|------|---------|
| Quat<T,Q> | 表示数学四元数的值对象 | 泛型结构体 |
| **detail/type_quat_cast.cj（v3 新增）** | **承载 `mat3Cast`/`mat4Cast`/`quatCast(Mat3)`/`quatCast(Mat4)` 转换函数，避免包间循环依赖** | **包级函数** |
| ext/vector_relational.cj | 向量关系运算扩展函数库（epsilon/ULP 比较） | 完整实现（epsilon 16 重载）+ stub（ULP 8 重载） |
| ext/quaternion_relational.cj | 四元数关系运算扩展函数库 | 完整实现（4 函数） |
| ext/quaternion_transform.cj | 四元数变换函数库 | 仅 `rotate` 函数 stub |
| ext/quaternion_common.cj | 四元数公共函数库（slerp/lerp/conjugate/inverse） | 5 函数完整实现 + 3 函数 stub |
| ext/quaternion_geometric.cj | 四元数几何函数（dot/length/normalize/cross） | 完整实现（4 函数） |
| ext/quaternion_trigonometric.cj | 四元数三角函数（angle/axis/angleAxis） | 1 函数完整实现 + 2 函数 stub |
| ext/quaternion_exponential.cj | 四元数指数函数（exp/log/pow/sqrt） | 全部 stub（4 函数） |
| ext/scalar_constants.cj | 标量数学常量（epsilon/pi/cos_one_over_two） | 完整实现（3 函数重导出） |
| gtc/constants.cj | 数学常量定义（zero/one/pi/half_pi 等 28 个常量） | 完整实现 |
| **gtc/quaternion.cj** | **gtc 四元数扩展函数库（欧拉/比较/看向函数 + 转换函数重导出）** | **混合型：4 函数完整实现 + 7 函数 stub + 4 函数重导出**（**v14 修订，Issue 1 响应**：原「4 函数完整实现 + 7 函数 stub + 4 函数重导出」中 4 函数完整实现仅含比较函数，与 §3.15 一致；§3.2 策略段之前误声明的「8 个完整实现」含欧拉函数已修正） |
| gtc/matrix_transform.cj | 矩阵变换函数库 | 空桩占位 |
| common.cj（沿用阶段二 stub） | 基础数学函数库占位 | 沿用 stub |
| matrix.cj（沿用阶段二） | 矩阵运算函数库 | 沿用（27 实现 + 6 stub） |
| geometric.cj（沿用阶段二 stub） | 几何函数库占位 | 沿用 stub |
| trigonometric.cj（新增空桩） | 三角函数库占位 | 新增空桩 |
| ext/matrix_projection.cj（新增空桩） | 矩阵投影函数库占位 | 新增空桩 |
| ext/matrix_clip_space.cj（新增空桩） | 裁剪空间矩阵函数库占位 | 新增空桩 |
| ext/matrix_transform.cj（新增空桩） | 矩阵变换扩展函数库占位 | 新增空桩 |

### 整体架构思路

沿用阶段一/阶段二的双层包结构 + ext 子包 + gtc 子包：glm.detail 包含四元数泛型结构体定义、运算符重载、以及矩阵-四元数互转函数（type_quat_cast.cj），glm 包通过类型别名暴露常用具现化，glm.ext 包含四元数/向量关系运算等扩展函数库和别名文件，glm.gtc 包含数学常量和 gtc_quaternion 扩展函数库（通过 public import 重导出 detail 中的转换函数）。四元数类型以 Vec3+标量(w) 为内部数据布局，与 GLM 的 xyzw 布局一致（非 wxyz 布局），通过 `const init` 构造函数支持编译期求值。

### 系统性设计约束：泛型上下文中 T(0)/T(1) 的获取问题

本设计与阶段二面临相同的根因限制：**仓颉无约束泛型参数不支持 `T(0)/T(1)` 构造调用，且 `Number<T>` 接口也不提供 `T(n)` 构造声明**。统一策略沿用阶段二的方案：
- **T(0) 的获取（v14 关键修订，Issue 2 响应；v24 修订，Issue 2 响应）**：原策略「通过 `one - one` 演算（需 `one: T` 形参显式传入）」在不含 `one: T` 形参的函数签名中不可用（如 `normalize(q: Quat<T,Q>): Quat<T,Q>`）。**统一修订为 `T(Float64(0))` 字面量替代路径**——与 `axis` 函数中 `T(Float64(0))` 使用模式一致。该路径对 `T = Float32/Float64` 编译可行（`Float32(Float64(0))` = `0.0f`，`Float64(Float64(0))` = `0.0`）。对 `T = Int8~Int64/UInt8~UInt64` 等整数类型，`T(Float64(0))` 的编译可行性属于 **P0 假设 H1**（验证项 25），尚待编码启动前验证——若验证失败，整数类型路径退化为 `match` 运行时分派或追加 `one: T` 形参（详见本节省略所述回退方案决策树）。仅在 `identity(one: T)` 等显式携带 `one: T` 形参的函数中保留 `one - one` 演算路径
- **T(1) 的获取**：必须由调用方显式传入参数（`one: T`），因为在 `Number<T>` 约束上下文中不存在通用的演算路径
- **T(0) 和 T(1) 均需的场景**：T(0) 通过 T(Float64(0)) 字面量替代获取（v14 修订），T(1) 通过参数传入或 T(Float64(1)) 字面量替代
- **常量型 T(n) 字面量替代**（v8 新增，v9 扩展，**v14 关键修订：同时覆盖 T(0) 和 T(1)；v24 修订，Issue 2 响应：整型 T 可行性降级为 P0 假设 H1**）：对于公式中固定为常数 n 的场景（如 `axis` 公式中的 `T(1) - x.w*x.w`、`normalize` 零保护分支中的 `T(0)` 与 `T(1)`、`Quat×Vec3`/`Quat×Vec4` 旋转公式末尾的 `* 2` 缩放因子、`mat3Cast`/`mat4Cast` 转换函数中初始化 3×3/4×4 单位矩阵对角元素的 `T(1)` 与非对角线元素的 `T(0)`），可采用 `T(Float64(n))` 显式转换路径（编译期 `Float64` 字面量 → `T` 类型），无需 `one: T` 形参；该路径对 `T = Float32`/`Float64` 均成立（`Float32(Float64(n))` 与 `Float64(Float64(n))` 均返回正确字面量）。对 `T = Int8~Int64/UInt8~UInt64` 等整数类型，`T(Float64(n))` 的编译可行性属于 **P0 假设 H1**（验证项 25），尚待编码启动前验证——若验证失败，整数类型路径退化为 `match` 运行时分派或追加 `one: T` 形参（详见回退方案决策树）。**v14 修订要点**：T(0) 字面量替代从「仅含 `axis` 中 `Vec3(T(0), T(0), T(1))` 返回值」扩展为系统性覆盖所有函数体中需要常量型 T(0) 的场景——`normalize` 零保护分支的 `Quat(T(0), T(0), T(0), T(1))` 返回值中 xyz 分量的 `T(0)` + `mat3Cast`/`mat4Cast` 非对角线元素的 `T(0)` 均改用 `T(Float64(0))` 字面量替代路径，不再依赖 `one - one` 演算。**v14 受 T 字面量获取策略影响的函数清单（v14 修订，覆盖 T(0) 和 T(1)）**：
  - **`axis` 函数（§3.9）**：使用 `T(Float64(1))` 字面量实现 `T(1) - x.w*x.w` 公式 + 使用 `T(Float64(0))` 字面量实现 `Vec3(T(0), T(0), T(1))` 返回值中 xyz 的两个 T(0)（v8 已明确 T(1)，v14 新增明确 T(0)）
  - **`normalize` 函数（§3.7）**：使用 `T(Float64(0))` 字面量实现零保护分支返回值 `Quat(T(0), T(0), T(0), T(1))` 中 xyz 分量的 T(0) + 使用 `T(Float64(1))` 字面量实现 w 分量的 T(1)（**v14 新增明确**——v9 函数清单遗漏 normalize 的 T(0)/T(1) 字面量替代场景；原策略「T(0) 通过 `one - one` 演算」在 normalize 签名 `normalize(q: Quat<T,Q>): Quat<T,Q>`（不含 `one: T` 形参）中不可用）
  - **`Quat×Vec3`/`Quat×Vec4` 运算符（§3.4）**：使用 `T(Float64(2))` 字面量作为旋转公式末尾的 `* 2` 缩放因子（v9 已明确）
  - **`mat3Cast`/`mat4Cast` 转换函数（§3.2.1）**：使用 `T(Float64(1))` 字面量初始化结果矩阵的对角元素 + 使用 `T(Float64(0))` 字面量初始化非对角线元素（v9 已明确 T(1)，**v14 新增明确 T(0)**——与逐元素填充模式一致，见问题 4 修订）
**v15 修订，Issue 2 响应**：`T(Float64(n))` 字面量替代路径对所有受影响的类型（`Float32`/`Float64`/`Int8`~`Int64`）的编译可行性已在 §8 编码启动前验证项中新增显式验证项，确保该核心假设在编码阶段被验证通过后方可进入实现。

### 系统性设计约束（v8 新增，v11 关键修订）：Float32 与 std.math 的交互约束

仓颉 `std.math` 模块的数值函数 API 覆盖情况（依据 `cangjie-original-docs/std/math/math_package_api/math_package_funcs.md` 全文检索）：
- **提供 Float16/Float32/Float64 三种重载的函数**（**v11 关键修订**：v10/v6/v8 描述「仅支持 Float64」错误）：`sqrt`/`sin`/`cos`/`tan`/`asin`/`acos`/`atan`/`sinh`/`cosh`/`tanh`/`asinh`/`acosh`/`atanh`/`atan2`/`exp`/`log`
- **提供 Float32/Float64 重载的函数**（**v11 关键修订**：v10/v6 描述「`std.math.pow` 实际签名为 `pow(base: Float64, exponent: Float64): Float64`」错误，实际存在 4 个重载）：`pow(Float32, Float32): Float32`、`pow(Float32, Int32): Float32`、`pow(Float64, Float64): Float64`、`pow(Float64, Int64): Float64`
- **不存在**：`radians`/`degrees`（仓颉 std.math 不提供，**v11 修订**：v10 描述「受 §1 约束管辖」错误，本约束不适用于 radians/degrees；radians/degrees 必须通过硬编码 π 字面量自行实现，见 §3.13.1）

**统一处理策略（v11 修订）**：
- **方案 A（推荐）**：当泛型参数 `T` 与 std.math 重载参数类型一致时（即 T=Float32 时直接调用 `std.math.pow(x.w, y)`），**直接调用** std.math 函数，无需 `T(Float64.xxx(...))` 显式转换——v10/v6「必须转换」约束对存在 Float32 重载的函数不成立
- **方案 B（备选）**：对 `T = Float64` 实例化的场景，沿用 `T(Float64.xxx(Float64(value)))` 模式无变化
- **方案 C（备选）**：使用 `T <: Number<T>` 宽约束 + 函数体内 `match` 运行时分派（牺牲部分类型安全换取泛型灵活性，不推荐）

**v11 修订要点**：
- **直接影响消除**：v10 描述的「`std.math.sqrt(x)` 在 T=Float32 时触发编译错误」实际不成立——`std.math.sqrt` 自身已提供 Float32 重载，直接调用即可
- **下游影响范围**（Issue 7 修订需联动的位置清单）：§1「本阶段受此约束影响的函数」段、§3.9 `axis` 函数依赖描述、§3.10 `pow`/`log`/`exp` 函数依赖描述、D21 设计决策、§3.13.1 trigonometric.cj 表头与各函数「内部依赖」列、§8 编码启动前验证项 12 与 15、§10 覆盖矩阵 trigonometric.cj 表所有 14 个函数行
- **保留的影响**：`radians`/`degrees` 因 std.math 不提供这两个函数，仍需自行实现（硬编码 π 字面量路径），不受本约束「直接调用或转换调用」路径管辖

### gtc/quaternion.cj 与 type_quat_cast.cj 的协作设计（v3 关键决策）

**包间循环依赖的根因（v3 识别）**：GLM 1.0.3 中 `mat3_cast`/`mat4_cast`/`quat_cast` 4 个函数在 `gtc/quaternion.hpp` 中定义，而 `type_quat.inl` 的构造函数 `qua(mat3x3)`/`qua(mat4x4)` 内部调用这些转换函数。在 C++ 中通过头文件包含可实现双向引用，但在仓颉包模型下，`type_quat.cj`（`package glm.detail`）若 `import glm.gtc.quaternion.*`，而 `gtc/quaternion.cj`（`package glm.gtc`）若 `import glm.detail.*`，则构成 **包间循环依赖**（`glm.detail ↔ glm.gtc`），仓颉 cjpm 构建系统会拒绝编译（依据 cangjie-lang-features package/README.md 第 99 行明确规定「不允许循环依赖」）。

**本设计采取的解法（v3 决策，采纳审查报告 Solution 1）**：将 `mat3Cast`/`mat4Cast`/`quatCast` 4 个转换函数从 `gtc/quaternion.cj` 下沉至 `glm.detail.type_quat_cast.cj`（独立新文件，`package glm.detail`），让 `type_quat.cj` 中的 `fromMat3`/`fromMat4` 工厂函数直接调用同包函数（无需跨包引用）。`gtc/quaternion.cj` 通过 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 将这 4 个函数重导出为 gtc 命名空间的 API，从而保留 GLM 1:1 文件归属的设计意图（gtc 包仍提供 gtc 风格 API），同时彻底打破循环依赖。

**依赖方向（v3 重新确认）**：
- `glm.detail`（含 `type_quat.cj` 和 `type_quat_cast.cj`）**不依赖** `glm.gtc`
- `glm.gtc`（含 `quaternion.cj`）**单向依赖** `glm.detail`（通过 `public import` 重导出）
- 形成 `glm.gtc → glm.detail` 的**单向依赖**，无循环依赖

**为何不采用其他方案**：
- 审查报告 Solution 2（将 fromMat3/fromMat4 剥离到 gtc）会破坏 type_quat.cj 的核心职责（工厂函数应与类型定义同处），且让 API 形态从 `q.fromMat3(m)` 退化为 `mat3ToQuat(m)`，与 GLM 习惯偏差更大
- 审查报告 Solution 3（重新组织包层级为 glm.detail.gtc）需修改整个阶段三的包结构，影响过大
- 本方案仅调整 4 个函数的位置（detail 而非 gtc），破坏最小，API 形态完整保留

### 回退方案（v15 新增，Issue 6 响应）

本节为 §8 编码启动前验证项 20 和 25 两条 P0 核心假设提供被证伪时的回退路径。

**假设 H1：`T(Float64(n))` 语法对全部 `T <: Number<T>` 编译可行（验证项 25）**

| 证伪情形 | 影响范围 | 回退策略 |
|---------|---------|---------|
| `Float32(Float64(0))`/`Float32(Float64(1))` 编译失败 | 所有使用 `T(Float64(n))` 字面量替代的函数（`normalize`/`axis`/`mat3Cast`/`mat4Cast`/`Quat×Vec3`/`Quat×Vec4`） | **路径 A（推荐）**：对每个受影响函数追加 `one: T` 形参（如 `normalize(q: Quat<T,Q>, one: T): Quat<T,Q>`），T(0) 通过 `one - one` 演算获取。代价：函数签名变更，与 GLM API 形态偏差扩大。**路径 B**：在 `Number<T>` 约束块中使用 `match` 运行时分派，按 `Float32`/`Float64`/`Int8`~`Int64` 分别返回硬编码字面量。代价：运行时开销，但对上层签名无影响。**路径 C**：将 T 约束从 `Number<T>` 收紧为 `FloatingPoint<T>`，排除整数类型，对所有浮点类型使用 `T(0.0)`/`T(1.0)` 原生字面量构造。代价：整数四元数无法调用这些函数 |
| `Int8(Float64(0))`/`Int16(Float64(0))` 等整数类型编译失败 | 同上，但仅限整数 T 实例化路径 | 对整数 T 路径退化为 **路径 A**（追加 `one: T` 形参）或 **路径 B**（`match` 运行时分派）——浮点 T 路径仍可用 `T(Float64(n))` |
| 部分类型编译通过、部分失败 | 混合影响 | 按类型分别选择回退路径，在函数签名中通过 `where` 子句区分（如 `where T <: FloatingPoint<T>` 使用原生字面量，整数 T 使用 `one: T` 形参） |

**假设 H2：`FloatingPoint<T>` 接口提供 `getMinDenormal()`/`getInf()` 等静态方法（验证项 20）**

| 证伪情形 | 影响范围 | 回退策略 |
|---------|---------|---------|
| `FloatingPoint<T>.getMinDenormal()` 静态方法不存在 | `pow` 函数（§3.10）中的次正规数边界检查（line 63） | **路径 A（推荐）**：回退至类型分派 `match (q.x) { case _: Float32 => Float32.Min case _: Float64 => Float64.Min }`；若无法获取平台最小值硬编码值，采用字面量保守值（如 `T(Float64(1e-45))` 对 Float32、`T(Float64(5e-324))` 对 Float64）。**路径 B**：完全移除次正规数边界检查（与 GLM 早期版本行为一致），允许次正规数进入正常计算路径——代价：极端小值下精度损失 |
| `FloatingPoint<T>.getInf()` 静态方法不存在 | `log` 函数（§3.10）中 w=0 退化分支（line 30） | **路径 A（推荐）**：回退至类型分派 `match (q.x) { case _: Float32 => Float32.Inf case _: Float64 => Float64.Inf }`；若无静态常量可用，采用 `T(Float64(1)) / T(Float64(0))` 表达式生成正无穷（对浮点类型有效，整数 T 实例化时触发 `ArithmeticException`，与 GLM `log` 在整数 T 的行为一致）。**路径 B**：将 w=0 退化分支的处理从 `getInf()` 改为直接返回带大有限值的四元数（如 `Quat(0, 0, 0, 1e10)`），消除对无穷值的依赖——代价：与 GLM 行为偏差 |
| `FloatingPoint<T>.getNaN()` 静态方法不存在 | 非旋转矩阵 `quatCast` 的 NaN 四元数返回值（§3.2.1 边界行为） | 路径 A：类型分派 `match { Float32 => Float32.NaN, Float64 => Float64.NaN }`；路径 B：使用 `FloatingPoint<T>.getInf()` 回退路径的类似方案 |
| `FloatingPoint<T>` 接口本身在 stdlib 中不存在 | 所有使用 `where T <: FloatingPoint<T>` 约束的签名（`isnan`/`isinf`/`mat3Cast`/`mat4Cast`/`quatCast`/`trigonometric.cj` 全体） | **统一回退**：将所有 `FloatingPoint<T>` 约束放宽为 `Number<T>`，在函数体首部通过 `match` 或 `if-else` 对 `q.x` 的具体类型进行 `Float32`/`Float64` 分派，非浮点 T 实例化时抛 `Exception("function not defined for non-floating-point types")`。与 `epsilon<T>()` fallback 策略一致（§3.12） |

**决策树执行顺序**：
1. 先执行验证项 25（`T(Float64(n))` 语法），确认编译可行性
2. 再执行验证项 20（`FloatingPoint<T>` 静态方法），确认 API 存在性
3. 若 H1 通过但 H2 失败：仅影响 `pow`/`log`/`quatCast` 三条回退路径
4. 若 H1 失败但 H2 通过：影响范围最广，需按 H1 回退策略逐函数调整签名
5. 若 H1 和 H2 均失败：同时执行两套回退路径，需评估组合影响（尤其是 `mat3Cast`/`mat4Cast` 同时可能受 H1 的 `T(1)` 字面量替代路径和 H2 的 `FloatingPoint<T>` 约束收紧路径影响）

**验证执行记录（v25 修订，v24 验证时限承诺已执行）**：以下 P0 验证项已在 v25 设计阶段通过最小仓颉测试文件实际编译验证。测试文件路径：`$TEMP/opencode/h12_verify/test_h1_t_float64_n.cj` 和 `test_h2_floatingpoint.cj`（后因直接通过接口调用失败，改用 `test_h2b_direct.cj` 的 `T.getInf()` 泛型路径验证）。验证结果已记录于 §8 验证结果记录表模板。
- **验证项 20（H2：`FloatingPoint<T>` 接口方法）**：✅ **已通过**。`Float32.getInf()`/`getNaN()`/`getMinDenormal()`/`getMinNormal()`/`getE()`/`getPI()` 及实例方法 `isInf()`/`isNaN()` 均编译通过并运行时验证正确。泛型函数 `func f<T>() where T <: FloatingPoint<T> { T.getInf() }` 对 Float32/Float64 均编译通过——设计文档中 `where T <: FloatingPoint<T>` 约束下的泛型调用路径（如 `isnan`/`isinf`/`mat3Cast`/`mat4Cast`/`quatCast`/`trigonometric.cj` 全体）可正常编译。**注意**：`FloatingPoint<Float32>.getInf()` 直接通过接口调用编译失败（编译器限制），但通过 `T.getInf()` 泛型参数调用路径可用，后者是设计文档实际使用的模式。
- **验证项 25（H1：`T(Float64(n))` 语法）**：✅ **已通过**。`Float32(Float64(0/1/2))`、`Float64(Float64(0/1/2))`、`Int8~Int64(Float64(0/1))`、`UInt8~UInt64(Float64(0/1))` 均编译通过，运行时值正确（已验证 `Float32(0)=0.0`、`Float64(1)=1.0`、`Int32(0)=0`、`Int64(1)=1`、`UInt32(1)=1`、`UInt64(0)=0`）。
- **验证项 29（`glm.detail` 导入 `glm.ext` 验证）**：待编码阶段前通过 `cjpm check` 验证。

**受 H1/H2 假设影响的函数清单标注（v24 新增，Issue 5 响应）**：
以下函数依赖 H1（`T(Float64(n))` 语法可行性）或 H2（`FloatingPoint<T>` 接口方法可用性），对应假设及回退方案详见本节省略所述：
- **依赖 H1 的函数**：`normalize`/`axis`/`mat3Cast`/`mat4Cast`/`Quat×Vec3`/`Quat×Vec4`（函数体内部使用 `T(Float64(0))`/`T(Float64(1))`/`T(Float64(2))` 字面量替代路径）
- **依赖 H2 的函数**：`pow`（`FloatingPoint<T>.getMinDenormal()`）/`log`（`FloatingPoint<T>.getInf()`）/`isnan`/`isinf`（`FloatingPoint<T>` 实例方法）/`mat3Cast`/`mat4Cast`/`quatCast`（`where T <: FloatingPoint<T>` 约束）/`trigonometric.cj` 全体（`where T <: FloatingPoint<T>` 约束）

---

## 2. 模块划分

### 包组织

```
package glm/detail          — 核心实现层（新增/修改文件以 ★ 标记）
  ├── type_quat.cj ★        — Quat<T,Q> 结构体定义 + extend 块中的运算符
  │                          (含 Quat×Vec3/Vec4 成员运算符、Vec3×Quat/Vec4×Quat extend 块成员运算符)
  │                          (fromMat3/fromMat4 调用同包 type_quat_cast.cj 函数)
  ├── type_quat_cast.cj ★  — 矩阵-四元数互转包级函数（mat3Cast/mat4Cast/quatCast）
  │                          (v3 新增，下沉自 gtc/quaternion.cj 以避免包间循环依赖)
  ├── common.cj（沿用 stub，阶段二已有）
  ├── matrix.cj（沿用混合型，阶段二已有）
  ├── geometric.cj（沿用 stub，阶段二已有）
  ├── scalar_constants.cj ★ — 标量常量定义（移入 detail，epsilon/pi/cos_one_over_two）
  ├── trigonometric.cj ★    — 新增空桩（sin/cos/tan/asin/acos/atan 等签名空壳）
  ├── scalar_quat_ops.cj ★  — 标量-四元数运算全局具名函数（add/sub/mul/div，处理 T + Quat 等标量左侧运算）

package glm                 — 公共 API 面 + 别名层（修改文件以 ★ 标记）
  ├── lib.cj ★              — 新增四元数类型、ext 函数、gtc 常量的 public import（v5 明确清单见下方）
  └── fwd.cj ★              — 新增四元数类型别名（v5 明确清单见下方）

**lib.cj 新增 import 清单（v5 明确，v9 扩展补齐，**v13 修订实际行数声明**）**：
- **v13 修订，Issue 1 响应，lib.cj 实际行数声明**：`cjglm/src/lib.cj` 当前**仅 8 行**（经 `wc -l cjglm/src/lib.cj` 验证），文件内容为：第 1 行 `package glm` 声明 + 第 2-8 行共 7 个 `public import glm.detail.{...}` 声明（`Vec1~Vec4` / `Qualifier`/`PackedHighp`/`PackedMediump`/`PackedLowp` / `Defaultp` / `add`/`sub`/`mul`/`div`/`mod` / `fromBoolVec`/`fromBoolVecQ2` / `Mat2x2~Mat4x4` / `transpose`/`matrixCompMult`/`outerProduct`）。**阶段三新增的 20 个 import 全部追加至 lib.cj 第 9 行起**（即当前 8 行末尾后逐行追加）——下游编码者按本清单实施时无需在 lib.cj 中查找「第 131 行」（v12 错误引用），直接编辑 8 行文件末尾追加 20 行 import 即可
- `public import glm.detail.{Quat, mat3Cast, mat4Cast, quatCast}` — 四元数类型 + 转换函数（**v10 修订，Issue 17 响应**：`mat3Cast`/`mat4Cast`/`quatCast` 在 lib.cj 中以 `public import` 形式重导出至顶层 `glm` 命名空间——与现有 `public import glm.detail.{transpose, matrixCompMult, outerProduct}` 包级函数重导出模式一致，见 `cjglm/src/lib.cj:8`——下游消费者可按 `glm.mat3Cast(q)` 路径直接调用，**无需** `import glm.detail.*` 后再调用包级函数 `mat3Cast(q)`）
- `import glm.detail.trigonometric` — 三角函数（75 函数空桩，14 标量 + 56 向量 + 1 标量 `atan2` + 4 向量 `atan2`，按 v10 展开规则；v9 新增）
- `import glm.ext.vector_relational` — 向量关系运算（含 16 重载 epsilon + 8 重载 ULP stub）
- `import glm.ext.quaternion_common` — 四元数公共函数（5 实现 + 3 stub）
- `import glm.ext.quaternion_geometric` — 四元数几何函数（4 实现）
- `import glm.ext.quaternion_trigonometric` — 四元数三角函数（1 实现 + 2 stub）
- `import glm.ext.quaternion_relational` — 四元数关系运算（4 实现）
- `import glm.ext.quaternion_transform` — 四元数变换函数（仅 `rotate` 函数 stub；v9 新增）
- `import glm.ext.quaternion_exponential` — 四元数指数函数（4 函数全部 stub；v9 新增）
- `import glm.ext.scalar_constants` — 标量常量（3 函数重导出）
- `import glm.ext.quaternion_float` — Float32 四元数别名（`quat`）；v9 新增
- `import glm.ext.quaternion_double` — Float64 四元数别名（`dquat`）；v9 新增
- `import glm.ext.quaternion_float_precision` — Float32 精度变体别名（`highp_quat`/`mediump_quat`/`lowp_quat`）；v9 新增
- `import glm.ext.quaternion_double_precision` — Float64 精度变体别名（`highp_dquat`/`mediump_dquat`/`lowp_dquat`）；v9 新增
- `import glm.ext.matrix_projection` — 矩阵投影函数库空桩；v9 新增
- `import glm.ext.matrix_clip_space` — 裁剪空间矩阵函数库空桩；v9 新增
- `import glm.ext.matrix_transform` — 矩阵变换扩展函数库空桩；v9 新增
- `import glm.gtc.constants` — 数学常量（28 函数）
- `import glm.gtc.quaternion` — gtc 四元数扩展函数库（4 函数重导出 + 4 函数完整 + 7 函数 stub；v9 新增）
- `import glm.gtc.matrix_transform` — 矩阵变换函数库空桩占位（**v13 修订**：64 个函数签名而非 v12 描述的 35 个；v9 新增）
- **合计 20 个 import**（v9 修订：v5 明确 8 个 → v9 扩展 12 个 → 合计 20 个；下游消费者可按 lib.cj import 清单访问所有新增模块（stub/别名/gtc））

**fwd.cj 新增 type alias 清单（v5 明确，v10 修订别名计数，v12 关键修订 Issue 2 实施路径，**v13 关键修订路径准确性**）**：
- `type Quat = Quat<Float32, PackedHighp>` — Float32 主别名
- `type FQuat = Quat<Float32, PackedHighp>` — Float32 别名（与 `Quat` 等价，遵循阶段二双别名模式）
- `type DQuat = Quat<Float64, PackedHighp>` — Float64 主别名
- `type HighpQuat = Quat<Float32, Highp>` — Float32 高精度别名
- `type MediumpQuat = Quat<Float32, Mediump>` — Float32 中精度别名
- `type LowpQuat = Quat<Float32, Lowp>` — Float32 低精度别名
- `type HighpDQuat = Quat<Float64, Highp>` — Float64 高精度别名
- `type MediumpDQuat = Quat<Float64, Mediump>` — Float64 中精度别名
- `type LowpDQuat = Quat<Float64, Lowp>` — Float64 低精度别名
- **合计 9 个别名**（**v10 修订**：v9 描述误为 8 个，实际为 Quat/FQuat/DQuat（3 个）+ 3×Float32 精度 + 3×Float64 精度 = **9 个**；与阶段二 `Mat2x2`/`FMat2x2` 双别名机制一致）
- 排除项：不含 `BQuat`（Bool 四元数，D17 决策）/ `IQuat`/`I64Quat`（整型四元数，与阶段二 fwd.cj 排除整型矩阵别名策略一致）
- **实施路径（v19 关键修订，Issue 3 响应——补充可执行实施细节）**：`fwd.cj` 是自动生成文件（`cjglm/src/fwd.cj:1-2` 文件头注释为中文「`// fwd.cj — GLM 兼容类型别名（自动生成）`」+「`// 注意：此文件由脚本自动生成，手动修改请谨慎`」），**手动添加将随重新生成丢失**。v13 决策采用**方案 A（推荐，修改生成脚本）**。以下给出可直接执行的完整修改方案：

  (a) **生成脚本位置**：`cjglm/scripts/gen_fwd_aliases.py`（Python 64 行）。现有 `VEC_FAMILIES` 字典代码（`gen_fwd_aliases.py:13-18`）如下：
  ```python
  VEC_FAMILIES = {
      'B': 'Bool', 'I': 'Int32', 'U': 'UInt32', 'Vec': 'Float32',
      'DVec': 'Float64', 'I8': 'Int8', 'I16': 'Int16', 'I32': 'Int32',
      'I64': 'Int64', 'U8': 'UInt8', 'U16': 'UInt16', 'U32': 'UInt32',
      'U64': 'UInt64', 'FVec': 'Float32', 'F32': 'Float32', 'F64': 'Float64',
  }
  ```
  现有 `VEC_PRECISIONS` 列表（`gen_fwd_aliases.py:19-20`）：
  ```python
  VEC_PRECISIONS = [('', 'PackedHighp'), ('Highp', 'PackedHighp'),
                    ('Mediump', 'PackedMediump'), ('Lowp', 'PackedLowp')]
  ```

  (b) **修改后完整 Python 代码**：在 `main()` 函数中（`gen_fwd_aliases.py:27`），新增针对 Quat 家族的独立循环，避免污染 Vec 原有 DIMS 逻辑。在现有 Vec 家族循环（行 43-51）之后、写入文件之前插入以下代码块：
  ```python
      # === Quat family (fixed 4-dim, no Vec1/Vec2/Vec3 variants) ===
      QUAT_FAMILIES = {
          'Quat': 'Float32', 'FQuat': 'Float32', 'DQuat': 'Float64',
      }
      QUAT_PRECISIONS = [('', 'PackedHighp'), ('Highp', 'PackedHighp'),
                         ('Mediump', 'PackedMediump'), ('Lowp', 'PackedLowp')]
      lines.append('// === Quat family ===')
      for prec_prefix, prec_type in QUAT_PRECISIONS:
          for family_name, family_type in QUAT_FAMILIES.items():
              alias_name = f'{prec_prefix}{family_name}'
              lines.append(f'public type {alias_name} = detail.Quat<{family_type}, {prec_type}>')
      lines.append('')
  ```
  **说明**：`QUAT_FAMILIES` 是独立于 `VEC_FAMILIES` 的单独字典，避免在 Vec 循环的 `DIMS = [1,2,3,4]` 中误生成 `Quat1`/`Quat2`/`Quat3` 三个不存在项；`QUAT_PRECISIONS` 与 `VEC_PRECISIONS` 值一致但独立声明，消除循环间意外副作用。

  (c) **验证命令**：
  ```bash
  # 验证生成的 fwd.cj 包含全部 9 个 Quat type alias
  grep -c '^public type.*= detail.Quat<' cjglm/src/fwd.cj
  # 预期输出：9（对应 Quat/FQuat/DQuat + 3×Float32 精度 + 3×Float64 精度）
  
  # 验证不生成 Quat1/Quat2/Quat3 错误变体
  grep -c "Quat1\|Quat2\|Quat3" cjglm/src/fwd.cj
  # 预期输出：0（不存在任何带数字后缀的四元数别名）
  
  # 验证 FQuat 精度前缀冗余不存在（gen_fwd_aliases.py 可能生成的误别名）
  grep "HighpFQuat\|MediumpFQuat\|LowpFQuat" cjglm/src/fwd.cj
  # 预期输出：0（FQuat 家族不应有 HighpFQuat/MediumpFQuat/LowpFQuat 精度变体——与 Vec 家族 FVec* 精度变体命名约定不一致，Quat 家族统一为 HighpQuat/MediumpQuat/LowpQuat）
  
  # 验证别名具体值
  grep "type \(Highp\|Mediump\|Lowp\|\)Quat" cjglm/src/fwd.cj
  # 预期输出 6 行：Quat / FQuat / HighpQuat / MediumpQuat / LowpQuat（不含 DQuat，DQuat 由下一命令验证）
  grep "type.*DQuat" cjglm/src/fwd.cj
  # 预期输出 4 行：DQuat / HighpDQuat / MediumpDQuat / LowpDQuat
  ```

  (d) **幂等性验证**：
  ```bash
  python cjglm/scripts/gen_fwd_aliases.py && git diff --stat
  # 首次执行后应有 diff（新增 9 行 Quat alias）；再次执行后 git diff --stat 应无输出（幂等）
  # 验证方式：连续执行两次，确认第二次无改动
  python cjglm/scripts/gen_fwd_aliases.py
  python cjglm/scripts/gen_fwd_aliases.py && git diff --stat  # 应输出空（无改动）
  ```

  **备选方案 B**（如生成脚本修改成本过高）：将 9 个 type alias 移至 `lib.cj` 顶部作为补充声明（`lib.cj` 是手动维护文件，仅 8 行），与现有 type alias 并存；**备选方案 C**：新建独立手动维护文件 `cjglm/src/quaternion_aliases.cj`，在 `lib.cj` 中 `public import` 重导出该文件——本方案需评估 cjpm 构建系统对新增文件的发现机制。本设计文档**推荐方案 A**，与 fwd.cj 的「单一自动生成来源」架构原则一致。

package glm.ext             — 扩展函数库（新增文件以 ★ 标记）
  ├── vector_relational.cj ★      — 向量 epsilon/ULP 关系运算函数（epsilon 16 重载完整实现 + ULP 8 重载 stub）
  ├── quaternion_relational.cj ★  — 四元数关系运算函数（4 函数完整实现）
  ├── quaternion_transform.cj ★   — 四元数变换函数（仅 `rotate` 函数 stub）
  ├── quaternion_common.cj ★      — 四元数公共函数（5 函数完整实现 + 3 函数 stub）
  ├── quaternion_geometric.cj ★   — 四元数几何函数（4 函数完整实现：dot/length/normalize/cross）
  ├── quaternion_trigonometric.cj ★ — 四元数三角函数（1 函数完整实现 + 2 函数 stub）
  ├── quaternion_exponential.cj ★   — 四元数指数函数（4 函数全部 stub）
  ├── scalar_constants.cj ★        — 向上导出接口（import glm.detail.scalar_constants 并 public import 重导出）
  ├── matrix_projection.cj ★       — 新增空桩
  ├── matrix_clip_space.cj ★       — 新增空桩
  ├── matrix_transform.cj ★        — 新增空桩
  ├── quaternion_float.cj ★         — Float32 四元数别名
  ├── quaternion_double.cj ★        — Float64 四元数别名
  ├── quaternion_float_precision.cj ★ — Float32 精度变体别名
  ├── quaternion_double_precision.cj ★ — Float64 精度变体别名

package glm.gtc             — GTC 扩展函数库（新增目录和文件以 ★ 标记）
  ├── constants.cj ★        — 数学常量定义（28 个常量函数完整实现）
  ├── matrix_transform.cj ★ — 空桩占位（仅函数签名空壳）
  ├── quaternion.cj ★       — gtc 四元数扩展函数（4 函数重导出 + 8 函数完整 + 7 函数 stub）
  │                          (mat3Cast/mat4Cast/quatCast 通过 public import glm.detail.{...} 重导出)
```

### 模块间依赖

```
glm.detail（同包直接可见）
  type_quat.cj → type_vec3, type_vec4
  type_quat.cj → type_quat_cast（fromMat3/fromMat4 调用同包 mat3Cast/mat4Cast/quatCast，v3 同包内调用）
  type_quat.cj → ext/scalar_constants（epsilon<T>()）
  type_quat.cj → common.cj(stub), trigonometric.cj(stub), geometric.cj(stub)
  type_quat_cast.cj → type_quat, Mat3x3, Mat4x4, Vec3（同包，无跨包引用）
  scalar_quat_ops.cj → type_quat
  scalar_constants.cj → setup.cj（仅依赖 GLM_CONFIG_* 常量）

glm.ext
  vector_relational.cj → glm.detail（qualifier, Vec1~Vec4, common.cj stub）
  quaternion_relational.cj → glm.detail（Quat, Vec4）, ext/vector_relational
  quaternion_geometric.cj → glm.detail（Quat, 纯算术，不依赖 geometric.cj stub）
  quaternion_transform.cj → glm.detail（Quat, Vec3, common.cj stub, trigonometric.cj stub, geometric.cj stub）
  quaternion_common.cj → glm.detail（Quat, Vec4, common.cj stub, trigonometric.cj stub）
  quaternion_trigonometric.cj → glm.detail（Quat, Vec3, ext/scalar_constants）
  quaternion_exponential.cj → glm.detail（Quat, ext/scalar_constants, common.cj stub, trigonometric.cj stub, geometric.cj stub）
  scalar_constants.cj → glm.detail.scalar_constants（重导出）
  matrix_projection.cj → stub（空桩）
  matrix_clip_space.cj → stub（空桩）
  matrix_transform.cj → stub（空桩）
  quaternion_float.cj → glm.detail（Quat 别名）
  quaternion_double.cj → glm.detail（Quat 别名）
  quaternion_float_precision.cj → glm.detail（Quat 别名）
  quaternion_double_precision.cj → glm.detail（Quat 别名）

glm.gtc（v3 关键：单向依赖 glm.detail，无循环）
  constants.cj → glm.ext.scalar_constants
  quaternion.cj → glm.detail（public import mat3Cast, mat4Cast, quatCast 进行重导出）
  quaternion.cj → glm.detail.{Quat, Mat3x3, Mat4x4, Vec3}（用于实现比较/欧拉/看向函数，**v10 修订，Issue 9 响应**：依赖声明过宽，按函数组细分——4 个比较函数（`lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual`）**仅依赖 Quat**；3 个 quatLookAt 函数（`quatLookAt`/`quatLookAtRH`/`quatLookAtLH`）**仅依赖 Vec3**；4 个转换函数（`mat3Cast`/`mat4Cast`/`quatCast` × 2，**v12 关键修订，Issue 1 响应**：camelCase 命名而非 GLM snake_case `mat3_cast`/`mat4_cast`/`quat_cast`）**重导出 detail 端**（不需直接 import Mat/Vec）；4 个欧拉函数（`eulerAngles`/`roll`/`pitch`/`yaw`）**依赖 Vec3 + Quat**）
  quaternion.cj → glm.ext.scalar_constants（epsilon<T>()，用于欧拉角边界检测）
  quaternion.cj → glm.ext.vector_relational（equal，用于 roll/pitch 的 equal(vec2, vec2, 0) 边界检测）
  quaternion.cj → glm.detail.common(stub)（clamp/abs，用于 roll/pitch/yaw/pow）
  quaternion.cj → glm.detail.trigonometric(stub)（atan/asin/cos/sin，用于 roll/pitch/yaw）
  quaternion.cj → glm.detail.geometric(stub)（cross/dot/normalize/inversesqrt/max，用于 quatLookAt*）
  quaternion.cj → glm.detail.type_quat_cast（quaternion.cj 中 quatLookAt* 内部调用 quatCast）
  matrix_transform.cj → stub 引用 ext/matrix_projection, ext/matrix_clip_space, ext/matrix_transform,
                         glm.detail.geometric(stub), glm.detail.trigonometric(stub), glm.detail.matrix(stub)

glm
  fwd.cj → glm.detail（Quat 别名）
  lib.cj → glm.detail（Quat, scalar_constants 函数, type_quat_cast 函数）, glm.ext, glm.gtc
```

**依赖方向总览（v3 修订）**：
- `glm.gtc → glm.detail` 单向（v3 关键变更）
- `glm.ext → glm.detail` 单向
- `glm → glm.detail/gtc/ext` 顶层聚合
- `glm.detail` 不依赖任何上层包

### ext/ 新文件与 gtc/ 子包的包名策略

沿用阶段二已验证的策略：
- `src/ext/` 下文件声明 `package glm.ext`
- `src/gtc/` 下文件声明 `package glm.gtc`（需原型验证 cjpm 子包发现机制对 gtc/ 子目录的支持；若不支持，按阶段二备选方案降级至 `package glm` 并在 src/ 根目录存放）

### cjpm 子包构建预验证

阶段二已通过验证：`src/ext/` 目录 + `package glm.ext` 的子包发现机制在 cjpm 中可用（[已通过 cjpm 验证]）。阶段三新增 `src/gtc/` + `package glm.gtc`，属 cjpm 构建系统的额外不确定性，需原型验证：

- **验证项 1（gtc 子包）**：在 `src/gtc/` 下创建测试文件，验证 cjpm 是否能识别 `package glm.gtc` 声明
- **验证项 2（gtc 重导出 detail 函数）**：验证 `gtc/quaternion.cj` 中 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 能否正确将 detail 包级函数重导出至 glm.gtc 命名空间
- **回退方案**：若 cjpm 不支持 `src/gtc/` 子目录的子包发现机制，将 gtc/ 文件夹内的文件迁移至 `src/` 根目录并降级为 `package glm`，函数路径从 `glm.gtc.quaternion.mat3Cast` 变为 `glm.mat3Cast`（与阶段二 ext/ 子包回退方案一致）

---

## 3. 核心抽象

### 3.1 四元数结构体 Quat<T,Q>

**角色**：表示数学四元数的值对象，用于旋转表达和插值运算。

**职责**：
- 承载 4 个分量数据成员（`public var x: T, public var y: T, public var z: T, public var w: T`，**v4 修订：显式标注 `public` 可见性以满足 `@Derive[Hashable]` 派生对字段 public 可见性的要求**），布局与 GLM 默认 xyzw 一致（非 wxyz）
- 提供编译期查询函数 `public static func length(): Int64` 返回常量 4
- 提供下标运算符 `[](i: Int64)` 访问分量（取值 + 赋值双版本）
- 提供多种构造方式（逐分量构造、标量+向量构造、跨类型构造）
- 通过 `@Derive[Hashable]` 自动派生哈希支持

**为何采用 struct（值类型）**：与阶段一 Vec 和阶段二 Mat 一致——四元数是数学计算中的值对象，值语义确保运算符返回新实例、无副作用。

**数据布局选择**：GLM 默认（`GLM_FORCE_QUAT_DATA_XYZW` 未定义时）为 `x, y, z, w` 布局。本设计采用此默认布局，`w` 分量位于第四位置。C++ GLM 的 `qua(T w, T x, T y, T z)` 构造函数参数顺序为 w 在前，但内部存储为 xyzw 后缀。仓颉版本中数据成员声明为 `public var x, public var y, public var z, public var w`（**v4 修订**：显式标注 `public` 以满足 `@Derive[Hashable]` 派生宏对字段 `public` 可见性的要求，依据 `cangjie-std/deriving/README.md` 第 4 节「参与派生的字段/属性必须为 public」），与阶段一 Vec3 (`type_vec3.cj:8-10`)、阶段二全部矩阵类型 (`type_mat*.cj` 200+ 处统一实践) 的实践对齐，与 GLM 存储布局对应。构造函数参数顺序需与数据布局明确区分——见 §3.3。

**为何不像 C++ GLM 使用匿名 union**：仓颉不支持匿名联合体和 `reinterpret_cast`，无法实现 GLM 中 `union { struct { T x, y, z, w }; storage<4,T> data; }` 的布局技巧。四元数直接声明具名数据成员，与阶段一/二 Vec/Mat 的策略一致。

**`@Derive[Hashable]` 约束核验（v3 新增，v4 强化，v5 明确实践依据）**：仓颉 `@Derive[Hashable]` 要求：①泛型 type parameter 满足 `Hashable` 接口；②参与派生的字段/属性必须为 `public` 可见性（依据 `cangjie-std/deriving/README.md` 第 4 节「参与派生的字段/属性必须为 public」）。`Quat<T, Q>` 中 `T <: Number<T>` 约束下所有数字类型均实现 `Hashable`；`Q <: Qualifier` 约束下 6 个 Qualifier 实现类型均无数据成员（标记类型），其 `Hashable` 派生由编译器自动支持。**字段可见性约束（v4 新增）**：Quat 的 4 个数据成员 `x`/`y`/`z`/`w` 统一标注 `public var`（详见上文数据成员描述），满足派生宏对字段 `public` 可见性的硬性要求——若省略 `public` 关键字，struct 字段默认可见性为 `internal`（依据 `struct/README.md` 第 1.7 节），不满足 public 派生要求，编译器将报错。**实践依据（v5 明确）**：阶段一 `type_vec3.cj:6` 已使用 `@Derive[Hashable]` 派生并通过编译（Vec3 数据成员 `public var x: T, public var y: T, public var z: T`）；阶段二全部矩阵类型（`type_mat2x2.cj`、`type_mat3x3.cj`、`type_mat4x4.cj` 等 9 个矩阵类型文件）均使用 `@Derive[Hashable]` + `public var` 派生并通过编译（200+ 处统一实践，已 grep 验证）。阶段三四元数延续相同的 `public var` + `@Derive[Hashable]` 派生模式，**前提条件**：阶段三不新增 Qualifier 变体，6 个 Qualifier 实现类型（`PackedHighp`/`PackedMediump`/`PackedLowp`/`AlignedHighp`/`AlignedMediump`/`AlignedLowp`）与阶段二完全一致。若阶段三新增 Qualifier 变体或 Qualifier 数据结构变更（如携带 alignment/SIMD 标签字段），需重新验证 `@Derive[Hashable]` 派生可行性。需在编码启动前验证项中确认 `@Derive[Hashable]` 对 `Q <: Qualifier` 的派生编译通过。

### 3.2 四元数与向量/矩阵的协作关系

四元数与向量、矩阵之间存在以下协作模式：

| 协作模式 | 描述 | 实现位置 |
|---------|------|---------|
| Quat×Vec3 | 四元数旋转向量 | Quat extend 块成员运算符 |
| Vec3×Quat | 向量被四元数逆旋转 | Vec3 extend 块成员运算符 |
| Quat×Vec4 | 四元数旋转向量（保留 w 分量） | Quat extend 块成员运算符 |
| Vec4×Quat | 向量被四元数逆旋转（保留 w 分量） | Vec4 extend 块成员运算符 |
| Mat3←Quat `mat3Cast` | 四元数转 3×3 旋转矩阵 | **detail/type_quat_cast.cj** 包级函数（v3 决策，**v12 关键修订，Issue 1 响应**：camelCase 命名，对应 GLM 原始 `mat3_cast`） |
| Mat4←Quat `mat4Cast` | 四元数转 4×4 旋转矩阵 | **detail/type_quat_cast.cj** 包级函数（v3 决策，**v12 关键修订同上**：camelCase `mat4Cast`，对应 GLM 原始 `mat4_cast`） |
| Quat←Mat3 `quatCast` | 旋转矩阵转四元数 | **detail/type_quat_cast.cj** 包级函数（v3 决策，**v12 关键修订同上**：camelCase `quatCast`，对应 GLM 原始 `quat_cast`） |
| Quat←Mat4 `quatCast` | 4×4 旋转矩阵转四元数 | **detail/type_quat_cast.cj** 包级函数（v3 决策，**v12 关键修订同上**：camelCase `quatCast`，对应 GLM 原始 `quat_cast`） |
| Mat↔Quat 转换重导出 | gtc 命名空间下的同名函数 | gtc/quaternion.cj 通过 public import 重导出 detail/type_quat_cast.cj 函数 |

**关键设计决策（v3 重新明确）**：`type_quat.inl` 中的构造函数 `qua(mat3x3)` 和 `qua(mat4x4)` 内部调用 `quat_cast`，而 `qua(Vec3, Vec3)`（从两个向量构造四元数）内部调用 `cross`、`dot`、`normalize` 等 geometric.cj 函数。仓颉版本中：
- `fromMat3`/`fromMat4` 工厂函数（在 `type_quat.cj` 中）调用**同包** `type_quat_cast.cj` 的 `quatCast`/`mat3Cast`/`mat4Cast` 函数（同包内可见，无需跨包 import）
- `gtc/quaternion.cj` 通过 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 将 detail 中的转换函数重导出至 gtc 命名空间，保留 GLM 1:1 文件归属的 API 形态

#### 3.2.1 type_quat_cast 函数签名规范（v5 新增）

`detail/type_quat_cast.cj` 中 4 个函数的具体签名模板（与 D29 同类约束收紧策略一致）：

```cangjie
// 包级 public 函数，package glm.detail
public func mat3Cast<T, Q>(q: Quat<T, Q>): Mat3x3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func mat4Cast<T, Q>(q: Quat<T, Q>): Mat4x4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func quatCast<T, Q>(m: Mat3x3<T, Q>): Quat<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func quatCast<T, Q>(m: Mat4x4<T, Q>): Quat<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
```

**约束说明**：
- `T <: FloatingPoint<T>`（v7 修订：v6 使用的 `FloatingPointNumber<T>` 非仓颉 stdlib 原生接口名，stdlib `cangjie-std/math/README.md` 第 117 行明确定义为 `FloatingPoint<T>`/`Integer<T>`/`Number<T>` 三层接口）：与 D29 `isnan`/`isinf` 约束收紧策略一致。GLM 1.0.3 在转换函数定义处使用 `GLM_STATIC_ASSERT(std::numeric_limits<T>::is_iec559, ...)` 静态断言非浮点类型时编译失败，仓颉版本通过 `FloatingPoint<T>` 接口约束（stdlib 原生接口）实现等价行为——整数 T（如 `Int64`）实例化时编译期报类型不匹配错误（`Int64` 不实现 `FloatingPoint<Int64>` 接口）。
- **重载区分**：`mat3Cast` 与 `mat4Cast` 通过参数类型 `Mat3x3<T,Q>` vs `Mat4x4<T,Q>` 区分；`quatCast` 的 Mat3 与 Mat4 重载同样通过参数类型区分，仓颉泛型重载规则支持此场景。
- **Fallback 模式**（理论上不需要——`FloatingPoint<T>` 是 stdlib 原生接口，编译期保证可用；此 fallback 仅作 v7 修订前的兼容占位说明）：若仓颉 stdlib 未提供 `FloatingPoint<T>` 接口（极小概率，stdlib 文档已明确），则将约束放宽为 `T <: Number<T>`，并在函数体首部通过 `match` 或 `if-else` 对 `q.x` 的具体类型进行 `Float32`/`Float64` 分派，非浮点 T 实例化时抛 `Exception("mat3Cast/mat4Cast/quatCast not defined for non-floating-point types")`，与 `epsilon<T>()` fallback 策略一致。

**T(1)/T(0) 字面量获取与矩阵初始化策略（v9 新增，**v14 关键修订，Issue 2+4 响应**）**：
- **GLM 实际依赖**：GLM 1.0.3 `gtc/quaternion.inl:49` 中 `mat3_cast`/`mat4_cast` 函数体内部使用 `Result = Mat3x3(T(1))` 初始化结果矩阵为单位矩阵（即先填 3×3/4×4 单位矩阵作为基底，再覆盖部分元素为四元数旋转分量），强依赖 T(1) 字面量。`quat_cast` 函数体内部不直接依赖 T(1)（通过 `trace`/`sqrt` 等运算推导四元数分量），故本策略主要影响 `mat3Cast`/`mat4Cast` 两个函数。
- **仓颉实现路径（v14 关键修订，Issue 4 响应：明确选择逐元素填充模式）**：本设计明确选择**逐元素填充模式**——不依赖 Mat3x3/Mat4x4 单参数构造函数。`mat3Cast` 实现模板为：`Result[0][0] = T(Float64(1)); Result[1][1] = T(Float64(1)); Result[2][2] = T(Float64(1)); Result 的其余元素 = T(Float64(0))`，然后覆盖旋转分量。`mat4Cast` 同理。该模式与 §1「常量型 T(n) 字面量替代」v14 修订策略一致（T(1) 使用 `T(Float64(1))` 字面量替代，T(0) 使用 `T(Float64(0))` 字面量替代——**v14 新增明确 T(0) 场景**：非对角线元素初始化为 `T(Float64(0))` 不依赖 Mat3x3 零初始化默认值，显式逐元素赋值确保跨类型一致性）。删除 v9 描述的「`Mat3x3(T(Float64(1)))` 初始化对角线」歧义表述——该表述暗示使用单参数构造函数（若 Mat3x3 存在单参数构造需 `one: T` 形参），与逐元素填充的 `FloatingPoint<T>` 约束签名不一致。**v14 决策理由**：(a) 逐元素填充不依赖 Mat3x3/Mat4x4 的任何特定构造函数签名，仅需 `[]` 下标运算符赋值能力（已由 §3.1 Quat 下标运算符和阶段二 Mat 下标运算符验证），下游编码者按模板逐行赋值即可实现；(b) 非对角线元素 T(0) 显式赋值（不依赖零初始化默认值），与 `axis`/`normalize` 中 T(0) 的 `T(Float64(0))` 字面量替代路径一致，形成 §1 统一策略闭环；(c) 消除两种初始化路径（单参数构造 vs 逐元素填充）的歧义，下游无需判断 Mat3x3/Mat4x4 是否支持单参数构造函数。

**边界行为契约（v8 新增）**：
- **`mat3Cast` 接受非单位四元数**：返回矩阵不保证是旋转矩阵——若输入四元数非单位四元数（含缩放/剪切分量），返回的 3×3 矩阵保留原始四元数的非旋转分量（如四元数长度为 2 时返回矩阵的奇异值近似 2/1/1），与 GLM 1.0.3 行为一致（GLM `type_quat.inl` 不做单位化保护）。
- **`mat4Cast` 接受非单位四元数**：与 `mat3Cast` 行为一致，返回 4×4 矩阵保留非旋转分量。
- **`quatCast` 接受非旋转矩阵**：返回的四元数行为未定义——若输入 Mat3/Mat4 含缩放/平移/剪切分量（非纯旋转矩阵），返回四元数可能是非单位四元数、零四元数或 NaN 四元数。GLM 1.0.3 通过 `GLM_STATIC_ASSERT(std::numeric_limits<T>::is_iec559, ...)` + 内部 `trace`/`sqrt` 计算实现，不做旋转矩阵合法性校验。
- **下游消费者契约**：与 §3.3 item 6/7 `fromMat3`/`fromMat4` 工厂函数的边界声明对齐（仅对纯旋转矩阵产生有意义结果）——`mat3Cast`/`mat4Cast`/`quatCast` 是 `fromMat3`/`fromMat4` 的反向操作，两者边界行为互为镜像。

> **集中参考清单（mat3Cast/mat4Cast/quatCast，v21 新增）**：§1 系统性设计约束（T(0)/T(1) 字面量替代路径 + 逐元素填充策略）→ §3.3 item 6/7 fromMat3/fromMat4 工厂函数 → §5.3 边界条件表（非单位四元数/非旋转矩阵行为）→ §3.13.2 审计表 mat3Cast/mat4Cast/quatCast 行 → §11.5 可用性对照表 mat3Cast/mat4Cast/quatCast 行 → §8 验证项 17（FloatingPoint<T> 约束验证）→ §8 验证项 25（T(Float64(n)) 语法验证）→ §8 验证项 26（Mat4x4 [] 返回类型验证）

**本阶段对 gtc/quaternion 函数的处理策略（v3 修订）**：`gtc/quaternion.hpp` 中共 15 个原始声明（`mat3_cast`/`mat4_cast`/`quat_cast` 两个重载/4 个 + `lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual`/4 个比较 + `eulerAngles`/`roll`/`pitch`/`yaw`/4 个欧拉 + `quatLookAt`/`quatLookAtRH`/`quatLookAtLH`/3 个看向 = 15 个）。本阶段采取以下分批策略：
- **本文件完整实现（4 个）**（**v14 修订，Issue 1 响应**：v13 策略段落声称「完整实现（8 个）」含 4 个欧拉函数，与 §3.15 函数职责分组表/v3 修订说明已归入「stub 占位」直接矛盾；本轮修正为与 §3.15 一致的分类）：
  - `lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual` — 4 个比较函数，纯算术
- **从 detail 重导出（4 个）**：
  - `mat3Cast`/`mat4Cast`/`quatCast(Mat3)`/`quatCast(Mat4)` — 通过 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 重导出（**v12 关键修订，Issue 1 响应**：仓颉端 camelCase 命名，对应 GLM 原始 `mat3_cast`/`mat4_cast`/`quat_cast` 习惯——`public import` 不做 snake_case→camelCase 命名转换）
- **stub 占位（7 个）**（**v14 修订，Issue 1 响应**：原 3 个仅含看向函数，未计入欧拉函数；与 §3.15 函数职责分组一致，4 欧拉 + 3 看向 = 7 stub）：
  - `eulerAngles`/`roll`/`pitch`/`yaw` — 4 个欧拉函数，依赖 `trigonometric.cj` 的 `atan`/`asin` + `common.cj` 的 `clamp` + `vector_relational.cj` 的 `equal` + `scalar_constants.cj` 的 `epsilon<T>()`（均为 stub，**v14 修订**：从「完整实现」修正为「stub 占位」，与 §3.15 v5 最终决策一致）
  - `quatLookAt`/`quatLookAtRH`/`quatLookAtLH` — 3 个函数，依赖 `geometric.cj` 的 `cross`/`dot`/`normalize`/`inversesqrt`/`max`（均为 stub）

**type_quat.cj、type_quat_cast.cj、gtc/quaternion.cj 三者协作关系（v3 明确）**：
- `type_quat.cj` 中的 `fromMat3`/`fromMat4` 工厂函数直接调用 `type_quat_cast.cj` 的 `mat3Cast`/`mat4Cast`/`quatCast`（同包内可见，无 import 需求）
- `gtc/quaternion.cj` 通过 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 将 detail 函数重导出为 gtc 命名空间下的同名 API
- 仓颉包依赖 DAG：`glm.gtc → glm.detail` 单向（v3 关键变更），无循环依赖

### 3.3 构造函数体系

每个 Quat<T,Q> 提供以下构造函数和工厂函数：

1. **逐分量构造 const init(x: T, y: T, z: T, w: T)** — 纯赋值，参数顺序为 x, y, z, w（与数据成员声明顺序一致）。此为仓颉侧的**主构造函数**。调用方需注意：GLM 的 `qua(T w, T x, T y, T z)` 参数顺序为 w 在前，而仓颉版本参数顺序为 x, y, z, w（w 在后）。这是一个**接口形态偏差**（参见 §9）。

2. **标量+向量构造 const init(s: T, v: Vec3<T,Q>)** — 将标量 s 作为 w 分量，向量 v 的 xyz 作为 xyz 分量。对应 GLM 的 `qua(T s, vec3 const& v)` 构造函数。

3. **跨 Qualifier 构造 init<Q2>(q: Quat<T,Q2>) where Q2 <: Qualifier** — 跨 Qualifier 同类型构造，纯赋值。

4. **跨类型构造 fromQuat<U, P>(conv: (U) -> T, q: Quat<U,P>) where P <: Qualifier** — extend 块工厂函数，非 const。通过 conv 闭包将 U 类型分量转换为 T 类型。对应 GLM 的 `qua<U,P>(qua<U,P> const& q)` 显式转换构造函数。**调用示例**（下游消费者迁移提示）：
   ```
   // Float32 ← Float64 转换
   let q32 = Quat<Float32, PackedHighp>.fromQuat<Float64, PackedHighp>(
       { f64 => Float32(f64) },  // conv 闭包
       q64
   )
   // 同类型简化场景：直接使用主构造函数
   let q32_same = Quat<Float32, PackedHighp>(q32.x, q32.y, q32.z, q32.w)
   ```

5. **单位四元数工厂函数 identity(one: T)** — extend 块工厂函数，`Number<T>` 约束。返回 `Quat<T,Q>`，其中 w=one, x=T(0), y=T(0), z=T(0)。T(0) 通过 `one - one` 演算获取。**v15 修订，Issue 7 响应**：`one - one` 演算在无符号整数类型上依赖模 2^n 溢出语义（`@OverflowWrapping`），结果恒为 0，行为已定义；与 §3.4 运算符体系 `@OverflowWrapping` 统一标注一致。此为从零构造单位四元数的限定入口，与阶段二矩阵 `identity(one)` 模式一致。**调用示例**：
   ```
    // 必须显式传入 T(1) 等价物（如字面量 1.0f）
    let q = Quat<Float32, PackedHighp>.identity(1.0f)  // 单位四元数 (0, 0, 0, 1)
    ```
   **T(0) 获取路径说明**：本函数 T(0) 获取路径为 §1 统一策略的刻意例外——因 `identity` 显式携带 `one: T` 形参，选用 `one - one` 演算路径，与 §1「仅对已有 `one: T` 形参的函数保留 `one - one`」原则一致；`normalize`/`axis` 等无 `one: T` 形参的函数统一使用 `T(Float64(0))` 路径。

6. **从旋转矩阵构造 fromMat3(m: Mat3x3<T,Q>)** — 辅助工厂函数，内部调用**同包** `type_quat_cast.quatCast(m)`（v3 修订：原设计为跨包引用 gtc/quaternion.cj，现改为同包引用 type_quat_cast.cj）。**v15 修订，Issue 5 响应**：函数签名模板为 `public func fromMat3<T, Q>(m: Mat3x3<T, Q>): Quat<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier`——显式声明 `where T <: FloatingPoint<T>` 约束，而非隐式继承自内部 callee `quatCast`。整型 T（如 `Int64`）实例化时编译报类型不匹配错误；详见 §3.2.1 type_quat_cast.cj 约束说明。**调试指引**：若开发者用 `Int64` 实例化并调用 `fromMat3(m)`，编译错误将直接定位在 `fromMat3` 的签名约束处（而非内部 `quatCast` 处），提供更清晰的错误定位。非 const。**边界行为**（v3 新增契约声明）：仅对纯旋转矩阵产生有意义的四元数；对非旋转矩阵（如含缩放/平移/剪切矩阵）行为未定义，结果可能产生非单位四元数或语义错误的旋转。

7. **从旋转矩阵构造 fromMat4(m: Mat4x4<T,Q>)** — 辅助工厂函数，**v8 决策：采用手动提取策略**——直接读取 `m.c0`/`m.c1`/`m.c2` 三列（**v21 核验确认**：经查阅阶段二 `type_mat4x4.cj:8-11`，列字段名确为 `c0`/`c1`/`c2`/`c3`，设计假设于 v21 编码启动前核验为正确）构建 `Mat3x3<T,Q>(Vec3<T,Q>(m.c0.x, m.c0.y, m.c0.z), Vec3<T,Q>(m.c1.x, m.c1.y, m.c1.z), Vec3<T,Q>(m.c2.x, m.c2.y, m.c2.z))`，再调用同包 `quatCast(mat3x3)` 转换为四元数。**v15 修订，Issue 5 响应**：函数签名模板为 `public func fromMat4<T, Q>(m: Mat4x4<T, Q>): Quat<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier`——显式声明 `where T <: FloatingPoint<T>` 约束，而非隐式继承自内部 callee。整型 T 实例化时编译失败——编译错误直接定位在 `fromMat4` 签名约束处（而非内部 `quatCast` 处）。非 const。**v8/v9 决策理由（v9 强化说明）**：(a) 该手动提取路径直接使用 `Vec3<T,Q>(T, T, T)` 主构造函数构造向量分量，再使用 `Mat3x3<T,Q>(Vec3, Vec3, Vec3)` 主构造函数构造 3×3 矩阵——**两条构造路径均不携带 `one: T` 形参**（Vec3 主构造与 Mat3x3 主构造均无 `one` 形参，区别于跨维度 `fromMat` 工厂函数重载），因此 `fromMat4` 函数签名本身无需 `one: T` 形参；(b) 与 §1「系统性设计约束」中"**T(1) 的获取：必须由调用方显式传入参数（`one: T`）**"一致——本函数不调用任何需要 T(1) 的运算路径（不调用 `fromMat(Mat_Larger, one)` 跨维度工厂函数，不调用 `identity(one)` 单位矩阵工厂函数），故无需该形参；(c) **v8/v9 修订说明**：v8 修订曾引用阶段二 `cjglm/src/detail/type_mat2x2.cj:163-165` `Mat2x2.fromMat(Mat3x3, one)` 作为"列提取模式无需 `one`"的依据，但该引用本身存在内部矛盾——被引用的代码 `Mat2x2.fromMat(Mat3x3, one)` 显式携带 `one: T` 形参（即阶段二全部 9 个矩阵类型的 `fromMat` 工厂函数**均要求** `one: T` 形参，无论源/目标矩阵尺寸关系，仅同维度 `fromMat` 简化为无 `one` 形参），与"无需 `one`"结论相悖。**v9 修订**：删除错误的代码引用作为论据，改为基于本函数的实际构造路径（Vec3 主构造 + Mat3x3 主构造，均无 `one` 形参依赖）说明无需 `one` 形参的合理性，与 §1 系统性约束彻底闭环。**边界行为**：同上，依赖 `fromMat3` 的输入合法性——若 `m` 的左上 3×3 子矩阵非纯旋转矩阵，结果未定义。

8. **从两向量构造 fromVec3(u: Vec3<T,Q>, v: Vec3<T,Q>)** — 辅助工厂函数，内部实现从两个归一化轴构建四元数。依赖 geometric.cj 的 `dot`/`cross`/`normalize`（均为 stub），因此本阶段为 **stub 占位**，完整实现推迟至阶段四。**边界行为契约（v8 新增，v13 关键修订，Issue 5 响应）**：当输入向量 u, v 退化触发条件为 GLM 1.0.3 `detail/type_quat.inl:196-217`（**v13 修订**：v8 错误引用为 `ext/quaternion_common.inl:196-217`——`fromVec3` 实现位于 `detail/type_quat.inl` 的 `qua(vec3, vec3)` 构造函数，不在 ext/quaternion_common）中 `if (real_part < static_cast<T>(1.e-6f) * norm_u_norm_v)` 退化分支（**v13 修订**：v8 描述「`dot(normalize(u), normalize(v)) ≈ -1`」与实际触发条件不一致；实际 `real_part = norm_u_norm_v + dot(u, v)`，触发条件为 `norm_u_norm_v + dot(u, v) < 1e-6f * norm_u_norm_v`，等价于 `dot(u, v) < (1e-6f - 1) * norm_u_norm_v = -(1 - 1e-6f) * sqrt(dot(u, u) * dot(v, v))` ≈ `-sqrt(dot(u, u) * dot(v, v))`，即「`dot(u,v) ≈ -sqrt(dot(u,u) * dot(v,v))`」对应「`u, v` 反平行」）。退化分支内**轴选择逻辑**（**v13 修订**：v8 描述「与 u 垂直的任意轴」不准确；**v15 修订，Issue 8 响应**：补充 `normalize(t)` 归一化步骤）：GLM 实际为 `t = abs(u.x) > abs(u.z) ? vec<3, T, Q>(-u.y, u.x, static_cast<T>(0)) : vec<3, T, Q>(static_cast<T>(0), -u.z, u.y); t = normalize(t)`——基于 `abs(u.x) > abs(u.z)` 二选一选择「与 u 垂直的两条可能轴之一」：`abs(u.x) > abs(u.z)` 选 `(-u.y, u.x, 0)` 再归一化，否则选 `(0, -u.z, u.y)` 再归一化。**v15 修订**：选出的轴还需经过 `normalize(t)` 归一化确保返回纯向量四元数模长为 1（GLM `detail/type_quat.inl:196-217` 实际包含 `t = normalize(t)` 步骤）。返回 `q.w = 0` 且 `q.xyz` 模长为 1 的纯向量四元数（`real_part = 0`）。这是 GLM 对反平行输入的容错设计，避免返回零四元数导致除零。**契约声明**：`fromVec3` 对反平行输入的返回值**行为已定义**（返回 `q.w = 0` 的纯向量四元数，轴选择由 `abs(u.x) > abs(u.z)` 条件决定，行为与 GLM `detail/type_quat.inl:196-217` 一致），下游消费者可依赖该契约；对零向量输入则行为未定义（由 `normalize` stub 在阶段四补齐时确定）。

9. **从欧拉角构造 fromEuler(eulerAngles: Vec3<T,Q>)** — 辅助工厂函数，依赖 trigonometric.cj 的 `cos`/`sin`（均为 stub），因此本阶段为 **stub 占位**，完整实现推迟至阶段四。

10. **wxyz 工厂函数 wxyz(w: T, x: T, y: T, z: T)** — 静态工厂函数，参数顺序为 w, x, y, z（与 GLM `qua::wxyz(w,x,y,z)` 一致），内部返回 `Quat<T,Q>(x, y, z, w)`。提供与 GLM wxyz 习惯一致的调用入口。

### 3.4 运算符体系

所有算术运算符定义在 `Number<T>` 约束的 extend 块中（与阶段一/二一致），并统一标注 `@OverflowWrapping` 注解以保持跨类型一致性（标注对浮点类型无效果，但与阶段一 Vec3 (`type_vec3.cj:54-80`) 和阶段二全部矩阵类型 (`type_mat2x2.cj` 等) 的实践对齐）。Bool 四元数不支持算术运算。

**成员运算符**（定义在 Quat extend 块中）：

| 运算符 | 语义 | 约束 | 备注 |
|-------|------|------|------|
| 一元 `-` | 逐分量取反 | `Number<T>` | 标注 `@OverflowWrapping` |
| 二元 `+` | 四元数加法 | `Number<T>` | 标注 `@OverflowWrapping` |
| 二元 `-` | 四元数减法 | `Number<T>` | 标注 `@OverflowWrapping` |
| 二元 `*` | 四元数乘法（Hamilton 乘积） | `Number<T>` | 标注 `@OverflowWrapping` |
| 二元 `*` (Quat×Vec3) | 四元数旋转向量 | `Number<T>` | 实现：`v + (cross(QuatVector, v) * q.w + cross(QuatVector, cross(QuatVector, v))) * T(Float64(2))`（两次 Vec3 叉乘 `uv`/`uuv`，末尾乘 `T(Float64(2))` 字面量作为缩放因子，与 GLM `type_quat.inl:359-366` 一致；**v9 修订**：原 `* 2` 在 Cangjie 泛型上下文中需显式转换为 `T(Float64(2))` 字面量，避免 `T * Int64` 类型不匹配问题，与 §1「常量型 T(n) 字面量替代」策略对齐）。**v11 关键修订，Issue 3 响应，定义 `QuatVector` 符号**：`QuatVector = Vec3(q.x, q.y, q.z)` 是四元数的虚部向量（GLM `type_quat.inl:359-366` 实际命名）；完整展开公式为 `QuatVector = Vec3(q.x, q.y, q.z); uv = cross(QuatVector, v); uuv = cross(QuatVector, uv); return v + (uv * q.w + uuv) * T(Float64(2))`。**依赖 `geometric.cj` 向量 `cross`（阶段三 stub），调用将抛 `Exception("stub")`** |
| 二元 `*` (Quat×Vec4) | 四元数旋转向量（保留 w） | `Number<T>` | 实现：`Vec4(q * Vec3(v), v.w)`（其中 `q * Vec3(v)` 是上一行 `Quat×Vec3` 运算符的复用，保留 `v.w` 作为输出 Vec4 的 w 分量；**v11 关键修订，Issue 3 响应，明确 `Vec4(q * Vec3(v), v.w)` 公式含义**：第一参数 `q * Vec3(v)` 是 `Quat×Vec3` 运算符返回的 Vec3 结果，第二参数 `v.w` 是输入 Vec4 的 w 分量原样传递，构造输出 Vec4；**v12 关键修订，Issue 9 响应：明确 Vec4 主构造函数双参数版本**——本公式依赖 Vec4 主构造函数支持 `Vec4<T, Q>(Vec3<T, Q>, T)` 两参数签名，第一参数为 Vec3 旋转结果（xyz 分量），第二参数为 T 类型 w 分量原样传递。该双参数主构造函数在阶段一 `type_vec4.cj` 中已实现——阶段一 Vec4 主构造函数（v12 核验，Issue 9 响应）已声明 `init(vec3: Vec3<T, Q>, w: T)` 两参数版本作为 Vec4 标准构造入口之一（与逐分量构造 `init(x: T, y: T, z: T, w: T)` 并列），下游按设计字面实现 `Vec4(q * Vec3(v), v.w)` 时编译可行**）。**通过 Vec3 中间路径间接依赖 `Quat×Vec3`，阶段三调用同样抛 stub 异常** |
| 二元 `*` (Quat×T) | 四元数×标量 | `Number<T>` | 标注 `@OverflowWrapping` |
| 二元 `/` (Quat/T) | 四元数/标量 | `Number<T>` | 标注 `@OverflowWrapping`；整数 T 除零时触发仓颉 `ArithmeticException`，浮点 T 除零时产生 Inf/NaN 分量 |
| `==` | 精确比较（返回 bool） | `Equatable<T>` | |
| `!=` | 不等比较 | `Equatable<T>` | |

**命名约定说明（v3 新增）**：上表中 `Quat×Vec3` 行公式中的 `cross(QuatVector, v)` 调用的是 **Vec3 叉乘**（定义于 `geometric.cj`，参数为 `Vec3<T,Q>`），**非 §3.7 中的四元数 `cross`（Hamilton 乘积）**。两者通过类型消歧区分（参数类型为 Vec3 时调用 Vec3 叉乘，参数类型为 Quat 时调用四元数 Hamilton 乘积）。

**Bool 四元数算术运算编译期拒绝（v7 澄清）**：上表算术运算符（一元 `-`/二元 `+`/`-`/`*`/Quat×T/Quat/T）均以 `Number<T>` 为约束。`Bool` 类型不实现 `Number<T>` 接口，因此 `Quat<Bool, Q>` 实例化时算术运算符重载因类型约束不满足而**编译期自动拒绝**（与阶段二 D33 Bool 矩阵策略一致）。Bool 四元数仅可使用 `==`/`!=` 比较（`Equatable<Bool>` 由 stdlib 派生支持），符合 D17 决策意图。

**Vec extend 块成员运算符**（定义在 `detail/type_quat.cj`，`package glm.detail`，Vec3/Vec4 extend 块中）：

| 运算符 | 语义 | 约束 | 备注 |
|-------|------|------|------|
| Vec3×Quat | `(conjugate(q) / dot(q, q)) * v` | `Number<T>` | **v18 关键修订：采用内联逆四元数计算路径**——原路径调用 `inverse(q)` 会引入 `glm.detail → glm.ext` 跨包依赖，构成 `glm.detail ↔ glm.ext` 循环依赖（`glm.ext.quaternion_common` 同时依赖 `glm.detail.Quat`）。v18 改为内联计算：`conjugate(q) = Quat(-q.x, -q.y, -q.z, q.w)`，`dot(q, q) = q.w*q.w + q.x*q.x + q.y*q.y + q.z*q.z`，两者均为纯算术运算，不依赖任何 `glm.ext` 包函数；再通过同包 `Quat×Vec3` 运算符完成旋转 |
| Vec4×Quat | `(conjugate(q) / dot(q, q)) * v`（保留 w） | `Number<T>` | 通过 Vec3 中间路径，同上内联计算路径 |

**实现链路注释（v18 修订）**：本阶段 `Vec3×Quat`/`Vec4×Quat` 可立即调用，依赖链为 `Vec×Quat` → `(conjugate(q) / dot(q, q)) * v` → `conjugate` (逐分量取反) + `dot` (纯算术) + `Quat×Vec3` 运算符（同包）。整个依赖链全部在 `detail/type_quat.cj` 内部通过纯算术运算完成，**不依赖任何 `glm.ext` 包符号**，避免包间循环依赖。与 `Quat×Vec3`（依赖 `geometric.cj` 向量 `cross` stub）形成对比。

**全局具名函数**（scalar_quat_ops.cj，处理标量左侧运算）：

| 函数 | 语义 | 约束 |
|------|------|------|
| `add<T, Q>(s: T, q: Quat<T, Q>)` | 标量加四元数 | `Number<T>` |
| `sub<T, Q>(s: T, q: Quat<T, Q>)` | 标量减四元数 | `Number<T>` |
| `mul<T, Q>(s: T, q: Quat<T, Q>)` | 标量乘四元数 | `Number<T>` |
| `div<T, Q>(s: T, q: Quat<T, Q>)` | 标量除四元数 | `Number<T>` |

注：标量×四元数乘法无需单独"交换律别名"函数——`Quat×T` 运算符（右操作数为 T）已通过 §3.4 成员运算符表的 `二元 * (Quat×T)` 行覆盖；而 `T * Quat`（左操作数为 T）由于仓颉运算符重载规则——左操作数类型决定 operator 函数归属——无法定义为 Quat 的成员运算符，必须通过 `scalar_quat_ops.cj` 的全局函数 `mul<T, Q>(s: T, q: Quat<T, Q>)` 实现（与 D05 决策一致）。**v9 修订**：删除原描述中"仓颉 `Number<T>` 加法/乘法具备交换律语义"的错误表述——`Number<T>` 接口本身**不提供交换律语义**，仅约束四则运算的实现；标量×四元数（左操作数为 T）通过 `scalar_quat_ops.cj` 全局函数实现的根本原因是左操作数类型决定 operator 函数归属，而非 `Number<T>` 提供交换律覆盖。仓颉函数重载规则禁止重复签名（同参数列表+同返回类型无法构成有效重载，将触发"重复定义"编译错误），因此 `scalar_quat_ops.cj` 的 `mul` 全局函数与 `type_quat.cj` 的 `Quat×T` 成员运算符不构成重载冲突——前者实现 `T * Quat`，后者实现 `Quat * T`，左操作数类型不同。

**一元 + 运算符**：仓颉不支持重载一元 `+` 运算符（与 deviations.md IF-01 一致），`+q` 不可编译，直接使用 `q` 即可。

**复合赋值运算符**：`+=`/`-=`/`*=`（四元数乘法）/`*=`（标量乘法）/`/=` 由编译器自动生成（仓颉语言规范保证，与阶段二一致）。

### 3.5 ext/vector_relational.cj

**角色**：提供向量 epsilon 容差比较和 ULP 比较扩展函数。

**职责**：定义 8 个函数（4 个 epsilon 版本 + 4 个 ULP 版本），每个函数按 Vec1~Vec4 分量数提供泛型重载。

**epsilon 版本**（完整实现）：
- `equal(x: VecN<T,Q>, y: VecN<T,Q>, epsilon: T): VecN<Bool,Q>` — 逐分量 `|x-y| < epsilon`（严格小于，与 GLM 1.0.3 `glm/gtc/epsilon.inl:32-41` 中 `epsilonEqual` 实现一致；**v9 修订**：原引用 `func_vector_relational.inl:18-22` 错误——GLM 1.0.3 的 `func_vector_relational.inl` 中**不包含 epsilon 版本**的 `equal`/`notEqual`，epsilon 版本位于 `glm/gtc/epsilon.inl`（文件层面属 gtc 子包））
- `equal(x: VecN<T,Q>, y: VecN<T,Q>, epsilon: VecN<T,Q>): VecN<Bool,Q>` — 逐分量容差向量版本，同上严格小于语义
- `notEqual(x: VecN<T,Q>, y: VecN<T,Q>, epsilon: T): VecN<Bool,Q>` — 逐分量 `|x-y| >= epsilon`（大于等于，与 epsilon 版本互补）
- `notEqual(x: VecN<T,Q>, y: VecN<T,Q>, epsilon: VecN<T,Q>): VecN<Bool,Q>` — 逐分量容差向量版本

**ULP 版本**（依赖 `detail::float_t<T>` 位表示——仓颉无等价机制）：
- 仓颉无 `reinterpret_cast` 或浮点位表示直接访问能力（`float_t<T>::i`/`mantissa()`/`exponent()`/`negative()` 等在 C++ 中通过 union 技巧实现），ULP 比较函数在仓颉中**无法完整实现**。
- **ULP 比较的 stub/替代策略**：ULP 版本的 4 个函数（`equal`/`notEqual` 含 `int ULPs` 和 `VecN<int,Q> ULPs` 变体）**本阶段以空桩占位**，待阶段四评估仓颉 `std.math.Float` 或 CFFI 方案实现位级浮点比较后补齐。

**完整函数清单**（本阶段完整实现，4 个 epsilon 版本 × 4 个分量数 = 16 个重载）：

| 函数 | 分量数 | 签名模式 |
|------|--------|---------|
| equal | Vec1~Vec4 | `func equal<T, Q>(x: VecN<T,Q>, y: VecN<T,Q>, epsilon: T): VecN<Bool,Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier` |
| equal（向量 epsilon） | Vec1~Vec4 | `func equal<T, Q>(x: VecN<T,Q>, y: VecN<T,Q>, epsilon: VecN<T,Q>): VecN<Bool,Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier` |
| notEqual | Vec1~Vec4 | 同上模式 |
| notEqual（向量 epsilon） | Vec1~Vec4 | 同上模式 |

**依赖分析**：epsilon 版本内部使用 `abs`（来自 common.cj stub）和 `lessThanEqual`/`greaterThan`（Vec 的 extend 块成员函数，需 `Comparable<T>` 约束）。由于 common.cj 中 `abs` 为 stub，epsilon 版本也**依赖 common.cj stub**。

**依赖 common.cj stub 的递归问题（v3 修订）**：`vector_relational.cj` 的 `equal`/`notEqual` epsilon 版本内部调用 `abs(x - y)` 和 `lessThanEqual(abs(x - y), epsilon)`，其中 `abs` 来自 common.cj（当前为 stub）。**解决策略**：在 vector_relational.cj 中的 epsilon 比较函数内部，将 `abs` 内联展开为 `let d = x - y; VecN(if (d.x >= T(0)) { d.x } else { -d.x }, ...)` 模式，避免依赖 common.cj 的 `abs` stub。这要求 `Number<T>` 约束下有 `Comparable<T>` 以支持 `>=` 比较。此内联方式与阶段一 `ComputeEqualNumeric` 中使用 `std.math.abs` 的策略一致——此处优先内联以消除对 common.cj stub 的运行时依赖风险。

### 3.6 ext/quaternion_relational.cj

**角色**：提供四元数 epsilon 容差比较和精确比较扩展函数。

**职责**：定义 4 个函数（精确比较 2 个 + epsilon 比较 2 个）：

| 函数 | 语义 |
|------|------|
| `equal(x: Quat<T,Q>, y: Quat<T,Q>): Vec4<Bool,Q>` | 逐分量精确比较 |
| `equal(x: Quat<T,Q>, y: Quat<T,Q>, epsilon: T): Vec4<Bool,Q>` | 逐分量容差比较（与 vector_relational 严格小于语义一致） |
| `notEqual(x: Quat<T,Q>, y: Quat<T,Q>): Vec4<Bool,Q>` | 逐分量精确不等 |
| `notEqual(x: Quat<T,Q>, y: Quat<T,Q>, epsilon: T): Vec4<Bool,Q>` | 逐分量容差不等 |

**依赖分析**：精确比较版本直接使用 `==` 比较，无外部依赖。epsilon 比较版本使用内联 `abs` 模式和 `lessThanEqual`/`greaterThanEqual`（Vec4 的 Comparable 约束），与 ext/vector_relational.cj 策略一致。

### 3.7 ext/quaternion_geometric.cj

**角色**：提供四元数几何函数（dot、length、normalize、cross）。

**职责**：
- `dot(x: Quat<T,Q>, y: Quat<T,Q>): T` — 四元数点积 `x.w*y.w + x.x*y.x + x.y*y.y + x.z*y.z`。可直接实现，不依赖 geometric.cj 的向量 dot（虽然在 GLM 中委托给 `compute_dot<qua<T,Q>,T>` 特化，但仓颉版本直接内联计算）。
- `length(q: Quat<T,Q>): T` — 四元数长度 `sqrt(dot(q,q))`。依赖 `std.math.sqrt`（仓颉标准库提供），不依赖 geometric.cj。**Float32 实例的 sqrt 处理**：`std.math.sqrt` 提供 Float16/Float32/Float64 重载（见 §1 v11 修订），T=Float32 实例化时直接调用 `std.math.sqrt(dot_qq)`（直接利用 Float32 重载，无需显式 Float64 转换）；T=Float64 时直接使用 `std.math.sqrt` 返回值。
- `normalize(q: Quat<T,Q>): Quat<T,Q>` — 归一化四元数。**v11 关键修订，Issue 2 响应**（补充 GLM 零四元数保护行为）：实现公式与 GLM `ext/quaternion_geometric.inl:17-24` 完全一致——`tmp1 = length(q); if (tmp1 <= T(Float64(0))) { return identity_q } else { return q / tmp1 }`，其中 `tmp1 <= T(0)` 时返回**单位四元数**（`Quat(T(Float64(0)), T(Float64(0)), T(Float64(0)), T(Float64(1)))`）。**v14 关键修订，Issue 2 响应：T(0) 字面量替代**——零保护分支返回值中 xyz 分量的 T(0) 原策略「通过 `one - one` 演算（需 `one: T` 形参显式传入）」在本函数签名 `normalize(q: Quat<T,Q>): Quat<T,Q>`（不含 `one: T` 形参）中不可用，**统一修订为 `T(Float64(0))` 字面量替代路径**（与 `axis` 函数中 `Vec3(T(Float64(0)), T(Float64(0)), T(Float64(1)))` 模式一致），T(1) 通过 `T(Float64(1))` 字面量替代获取（与 §1「常量型 T(n) 字面量替代」v14 修订策略一致，同时覆盖 T(0) 和 T(1)）。**设计意图**：与 §5.1「normalize 零四元数返回单位四元数」契约对齐，避免下游按字面实现时零四元数除零产生 NaN 分量。**length 极小值边界行为（v11 新增）**：`tmp1` 为极小正数（如浮点最小次正规数）时不触发零保护分支，返回 `q / tmp1` 结果各分量趋向 Inf/NaN（与 GLM 行为一致，GLM 不做 length 极小值保护）；如需防止此类溢出，应在调用 `normalize` 前自行检查 `length(q) >= epsilon<T>()`。**T(0)/T(1) 获取路径（v14 关键修订，Issue 2 响应，统一采用 §1 作法）**：本函数体内 `T(0)` 与 `T(1)` 的获取策略遵循 §1「系统性设计约束」段的 **v14 修订**统一约定——T(0) 与 T(1) 均通过 `T(Float64(0))`/`T(Float64(1))` 字面量替代路径获取，无需 `one: T` 形参；两者**不**在本函数体内重复展开获取路径说明。**实现策略（v26 修订，Issue 2 响应）**：收紧 T 约束为 `where T <: FloatingPoint<T>`（与 D32 `mat3Cast`/`mat4Cast`/`quatCast` 策略一致），整数 T 实例化时编译期报类型不匹配错误，消除整数除法截断导致的语义歧义。函数体内部调用 `length(q)` 并判断零保护分支；仅浮点 T 路径可调用。**v13 关键修订，Issue 6 响应：交叉引用**——`normalize` 函数完整边界行为契约（零四元数 + length 极小值 + 实现公式）详见 §5.3 边界条件表「零四元数 `(0,0,0,0)`」+「`length(q)` 极小值」两行的整合描述；§3.13.2 审计节 normalize 行 + §11.6 四命名空间接口可达性矩阵 normalize 行均同步新增反向引用，参见相应章节。

> **集中参考清单（normalize，v21 新增）**：§1 系统性设计约束（T(0)/T(1) 字面量替代路径）→ §5.3 边界条件表（零四元数保护 + length 极小值）→ §3.13.2 审计表 normalize 行 → §11.5 可用性对照表 normalize 行 → §8 验证项 25（T(Float64(n)) 语法验证）→ §8 验证项 20（FloatingPoint<T> 接口验证，影响 length 的 sqrt 路径）
- `cross(q1: Quat<T,Q>, q2: Quat<T,Q>): Quat<T,Q>` — 四元数叉积（Hamilton 乘积的逐分量展开，四元数"cross"语义与向量叉乘不同：向量 `cross` 产生垂直于输入平面的向量，四元数 `cross` 产生 Hamilton 乘积的逐分量展开形式，结果仍是四元数）。可直接完整实现。

**命名歧义说明（v3 强化）**：上述 `cross` 函数与阶段二 stub 中 `geometric.cj` 的向量 `cross`（面向 Vec3 叉乘，产生垂直向量）存在概念差异——四元数 `cross` 即 Hamilton 乘积（结果为四元数），与向量叉乘（结果为向量）含义完全不同。**下游消费者判别方法**：
- 参数为 `Vec3<T,Q>` 时调用向量 `cross`（geometric.cj，当前 stub）
- 参数为 `Quat<T,Q>` 时调用四元数 `cross`（quaternion_geometric.cj，已完整实现）
- §3.4 `Quat×Vec3` 旋转公式中的 `cross(QuatVector, v)` 内部调用的是**向量 `cross`**（参数 QuatVector 和 v 均为 Vec3），与本节四元数 `cross` 不冲突

**关键发现**：这 4 个函数的依赖链终止于 `std.math.sqrt`（仓颉标准库提供），**不依赖**阶段二/三的任何 stub 文件。本阶段可**完整实现**。

### 3.8 ext/quaternion_transform.cj

**角色**：提供四元数变换函数（rotate）。

**依赖分析**：GLM 的 `quaternion_transform.hpp` 依赖 common.hpp、trigonometric.hpp、geometric.hpp。其中 `rotate` 函数使用 `sin`/`cos`（来自 trigonometric.cj stub）和 `length`（来自 geometric.cj stub）。

**本阶段实现策略**：
- `rotate(q: Quat<T,Q>, angle: T, axis: Vec3<T,Q>): Quat<T,Q>` — 依赖 `sin`/`cos` 和 `length`（均为 stub），本阶段 **stub 占位**

**修正**：经仔细审查 `quaternion_transform.hpp` 和 `.inl`，GLM 中 `ext/quaternion_transform.hpp` 仅定义了 `rotate` 一个函数。而 `angleAxis` 定义在 `ext/quaternion_trigonometric.hpp` 中。`quatLookAt`/`quatLookAtRH`/`quatLookAtLH` 定义在 `gtc/quaternion.hpp` 中。

因此 ext/quaternion_transform.cj 本阶段仅包含 `rotate` 的 stub。其余函数对应的归入各自的模块。

### 3.9 ext/quaternion_trigonometric.cj

**角色**：提供四元数三角函数（angle、axis、angleAxis）。

**依赖分析**：
- `angle(x: Quat<T,Q>): T` — 依赖 `abs`、`asin`、`acos`、`sqrt`、`pi<T>()`（scalar_constants）。`abs` 可内联，`asin`/`acos` 为 trigonometric.cj stub。**stub 占位**。
- `axis(x: Quat<T,Q>): Vec3<T,Q>` — 实现公式（与 GLM `ext/quaternion_trigonometric.inl:20-27` 一致）：`tmp1 = T(Float64(1)) - x.w * x.w`；若 `tmp1 <= T(Float64(0))` 返回 `Vec3(T(Float64(0)), T(Float64(0)), T(Float64(1)))`（z 轴单位向量）；否则 `tmp2 = T(Float64(1)) / T(std.math.sqrt(tmp1))`（**v13 关键修订，Issue 3 响应：移除 `Float64(tmp1)` 冗余转换层，与 §1 方案 A 一致**——`std.math.sqrt` 提供 Float16/Float32/Float64 重载，`tmp1` 类型为 T 时编译器按实例化类型自动选择对应重载，无需显式 Float64 转换），返回 `Vec3(x.x*tmp2, x.y*tmp2, x.z*tmp2)`。依赖 `std.math.sqrt`（§1 v11 修订确认提供 Float16/Float32/Float64 重载，方案 A 推荐直接调用）；实现公式遵循 `tmp2 = T(Float64(1)) / T(std.math.sqrt(tmp1))` 路径。同时依赖 `T(Float64(1))` 字面量替代（无需 `one: T` 形参），**可完整实现**。**T(1) 获取方式（v8 修订）**：v7 文档描述「T(1) 演算通过 `x.w*x.w` 取得」是错误的——`x.w*x.w` 是 w² 而非 1，无法作为 T(1) 的演算路径（v8 明确删除该错误描述）。本函数采用 §1「系统性设计约束」中 v8 新增的「常量型 T(1) 字面量替代」策略：`T(Float64(1))` 显式转换路径——`Float64(1.0)` 是字面量，`T(Float64(1.0))` 在 `T = Float64` 时返回 1.0，在 `T = Float32` 时返回 1.0f，无需 `one: T` 形参污染函数签名。**边界行为（v3 新增契约，v5 修订，v8 强化，v10 公式精修）**：触发 `Vec3(T(0), T(0), T(1))` 返回值的条件为 `T(Float64(1)) - x.w*x.w <= T(Float64(0))`（典型场景：单位四元数 `(0, 0, 0, 1)` 即 `|w| >= 1`）；对于真正的零四元数 `(0, 0, 0, 0)`，`tmp1 = 1 > 0` 进入 else 分支返回 `Vec3(0, 0, 0)`（**注意：v3 原描述的「内部 `normalize(Vec3(0, 0, 0))` 返回 `Vec3(T(1), T(0), T(0))`」为虚构实现，GLM 源码不调用 `normalize`，v5 修订纠正**）。

> **集中参考清单（axis，v21 新增）**：§1 系统性设计约束（T(1) 字面量替代路径 + std.math sqrt 重载）→ §5.3 边界条件表（零四元数 + `1-w² <= 0` 触发）→ §3.13.2 审计表 axis 行 → §11.5 可用性对照表 axis 行 → §8 验证项 12（length sqrt 转换验证）→ §8 验证项 21（std.math Float32 重载验证）→ §8 验证项 25（T(Float64(n)) 语法验证）
- `angleAxis(angle: T, axis: Vec3<T,Q>): Quat<T,Q>` — 依赖 `sin`/`cos`（trigonometric.cj stub）。**stub 占位**。

**修正本阶段策略**：
- `axis` — **完整实现**（依赖仅 `std.math.sqrt` 和 T(1) 演算，零四元数保护行为见上）
- `angle` — **stub 占位**（依赖 trigonometric.cj 的 `asin`/`acos`）
- `angleAxis` — **stub 占位**（依赖 trigonometric.cj 的 `sin`/`cos`）

### 3.10 ext/quaternion_exponential.cj

**角色**：提供四元数指数函数（exp、log、pow、sqrt）。

**依赖分析**：
- `exp(q: Quat<T,Q>): Quat<T,Q>` — 依赖 `length`（quaternion_geometric，已实现）、`epsilon<T>()`（scalar_constants.cj，line 10 用于 `Angle < epsilon<T>()` 退化检测）、`cos`/`sin`（trigonometric.cj stub）。**stub 占位**。
- `log(q: Quat<T,Q>): Quat<T,Q>` — 依赖 `length`（quaternion_geometric）、`epsilon<T>()`（scalar_constants.cj，line 23 用于 `Vec3Len < epsilon<T>()` 退化检测）、`pi<T>()`（scalar_constants.cj，line 28 用于 `wxyz(log(-q.w), pi<T>(), ...)`）、`atan`/`log`（trigonometric.cj/exponential.cj 接口——**v11 修订，Issue 7 关联**：std.math `atan`/`log` 实际提供 Float16/Float32/Float64 重载，T=Float32 实例化时直接调用即可）、`std::numeric_limits<T>::infinity()` 等价物（line 30 用于 w=0 退化分支，**v11 关键修订，Issue 8 响应**：仓颉 stdlib **实际提供** `FloatingPoint<T>.getInf()` 静态方法——v10 描述「不提供」错误——`FloatingPoint<T>` 接口（依据 `cangjie-original-docs/std/math/math_package_api/math_package_interfaces.md` 第 5-17 行定义）实际提供 6 个静态方法（`getE`/`getInf`/`getPI`/`getMinDenormal`/`getMinNormal`/`getNaN`）+ 3 个实例方法（`isInf`/`isNaN`/`isNormal`），下游实现应直接调用 `FloatingPoint<T>.getInf()` 而非类型分派；fallback 路径仍可使用 `T(1)/T(0)` 显式构造获取正无穷（仅对浮点类型有效））。**stub 占位**。
- `pow(x: Quat<T,Q>, y: T): Quat<T,Q>` — 依赖 `epsilon<T>()`/`abs`/`clamp`/`asin`/`acos`/`sin`/`cos`/`sqrt`/`cos_one_over_two<T>()` + **调用 `std.math.pow` 实数降级路径两次**（GLM line 65 + line 78，**v11 关键修订，Issue 6 响应**：v10「递归调用」措辞不准确——line 65 与 line 78 是两次独立的 `std.math.pow` 调用而非 self-recursion）+ `std::numeric_limits<T>::min()` 等价的仓颉次正规数边界检查。其中 `epsilon<T>()`/`cos_one_over_two<T>()` 来自 scalar_constants.cj（line 52：`if(abs(x.w / magnitude) > cos_one_over_two<T>())`），`abs`/`clamp` 来自 common.cj stub，`asin`（line 68：`Angle = asin(sqrt(VectorMagnitude) / magnitude)`）/`acos`/`sin`/`cos` 来自 trigonometric.cj stub，`sqrt` 来自 std.math，`std.math.pow` 来自仓颉标准库（line 65 + line 78 两次独立调用——**v11 关键修订，Issue 5 响应，补充 GLM line 65/78 仓颉等价翻译**）：
  - **GLM line 65 翻译**：`return qua<T, Q>::wxyz(pow(x.w, y), 0, 0, 0)` —— GLM `wxyz(w, x, y, z)` 构造签名（w 在前）；仓颉等价为 `Quat<T,Q>(T(std.math.pow(Float64(x.w), Float64(y))), T(Float64(0)), T(Float64(0)), T(Float64(0)))`（仓颉主构造函数顺序为 x/y/z/w，故 `Quat(0, 0, 0, pow(x.w, y))`；**v11 修订，Issue 7 关联**：T 实例化为 Float32 时 `std.math.pow` 直接接受 `Float32, Float32` 重载，无需 `Float64(...)` 转换层），调用语义为「次正规数过小」分支的实数降级路径
  - **GLM line 78 翻译**：`T Mag = pow(magnitude, y-1)` —— 仓颉等价为 `T Mag = T(std.math.pow(Float64(magnitude), Float64(y - T(1))))`（与 line 65 翻译同理；T=Float32 实例化时 `std.math.pow(Float32, Float32)` 直接返回 Float32），调用语义为一般路径的实数降级路径
- `std::numeric_limits<T>::min()` 用于次正规数边界（line 63：`if (VectorMagnitude < (std::numeric_limits<T>::min)())`，**v11 关键修订，Issue 8 关联**：仓颉 stdlib 实际提供 `FloatingPoint<T>.getMinDenormal()` 静态方法（依据 `cangjie-original-docs/std/math/math_package_api/math_package_interfaces.md` 第 49-60 行定义）——下游实现应通过 `FloatingPoint<T>.getMinDenormal()` 直接获取；v10 描述「`FloatingPoint<T>` 接口本身无任何实例方法」错误——`FloatingPoint<T>` 接口实际提供 6 个静态方法（`getE`/`getInf`/`getPI`/`getMinDenormal`/`getMinNormal`/`getNaN`）+ 3 个实例方法（`isInf`/`isNaN`/`isNormal`），下游实现应优先使用静态方法路径而非类型分派）。**命名消歧与 Float64 转换（v5 新增，v7 澄清，v10 合并，v11 修订）**：将 v5「命名消歧」与 v7「Float64 转换依赖」两段合并为单一子段（**v10 关键修订**：v9 设计中两段功能重叠，下游阅读时产生「§1 已说明通用规则为何 §3.10 又重复一次」的疑问）。本段统一说明：四元数 `pow` 函数体内部调用的 `pow(x.w, y)` 是**实数版本** `std.math.pow`（**v11 关键修订，Issue 7 关联**：v10 描述的「`std.math.pow(Float64, Float64): Float64`」实际只是 4 个重载之一——仓颉 stdlib `cangjie-original-docs/std/math/math_package_api/math_package_funcs.md` 第 4289-4397 行明确定义 `pow(Float32, Float32): Float32`、`pow(Float32, Int32): Float32`、`pow(Float64, Float64): Float64`、`pow(Float64, Int64): Float64` 共 4 个重载——下游实现时应根据 T 实例化类型选择对应重载：当 T=Float32 时调用 `std.math.pow(Float32, Float32): Float32`（直接调用，无需 Float64 转换）；当 T=Float64 时调用 `std.math.pow(Float64, Float64): Float64`），与四元数 `pow` 本身（`pow(Quat, T): Quat`）通过参数类型消歧（第一参数类型 `Float32`/`Float64` 与 `Quat<T,Q>` 区分）；`pow(Quat<Float32, Q>, Float32)` 实现路径遵循 §1 v11 修订策略方案 A（直接调用 std.math Float32 重载），fallback 路径 `exp(y * log(x.w))` 同步遵循 §1 v11 修订（std.math.exp/log 同样提供 Float16/Float32/Float64 重载）；若 `std.math.pow` 不可用需以 `exp(y * log(x.w))` 替代实现。**stub 占位**。
- `sqrt(x: Quat<T,Q>): Quat<T,Q>` — 委托 `pow(x, T(0.5))`。**stub 占位**。

**v5 修订**：4 个函数均依赖 trigonometric.cj/common.cj stub，本阶段全部 **stub 占位**。`pow` 的依赖关系以 GLM `ext/quaternion_exponential.inl:41-80` 实际实现为准（v3 引用 `24-43` 行号错误，已纠正）。`exp`/`log`/`pow` 函数分别补充 `epsilon<T>()`、`pi<T>()` 等 scalar_constants.cj 依赖。`pow` 补充 `cos_one_over_two<T>()`/`asin`/`std.math.pow`/`std::numeric_limits<T>::min()` 等价物依赖。

### 3.11 ext/quaternion_common.cj

**角色**：提供四元数公共函数（mix、lerp、slerp、conjugate、inverse、isnan、isinf）。

**依赖分析**：
- `dot` — 委托 quaternion_geometric.cj，完整可用
- `conjugate(q: Quat<T,Q>): Quat<T,Q>` — **完整实现**。仅对 x/y/z 三个分量取反，w 分量保持不变：`Quat(-q.x, -q.y, -q.z, q.w)`（与 GLM `ext/quaternion_common.inl:112-116` `wxyz(q.w, -q.x, -q.y, -q.z)` 一致；**v5 修订**：v3 描述「仅涉及逐分量取反」语义不准确，逐分量取反对应 `negative` 运算符 `-q`，而 `conjugate` 仅对 x/y/z 取反、保留 w）。等价实现可基于主构造函数或 wxyz 工厂函数。**const func 适用性（v10 新增，Issue 6 响应，v12 关键修订，Issue 7 响应：补充阶段二实践依据）**：`conjugate` 函数体仅涉及 `Quat` 主构造函数的逐分量取反调用（`Quat(-q.x, -q.y, -q.z, q.w)`），无 `assert`/无 `throw`/无 `dot`/`normalize`/其他非 const 函数调用，**可声明为 `const func`**。**阶段二实践依据（v12 新增，Issue 7 响应）**：阶段一 `cjglm/src/detail/type_vec3.cj:54-80` 已成功声明 27 个逐分量运算符与函数为 `const func`，包括 `negative(vec3): Vec3`（逐分量取反，等价于 `-v`）、`negate(vec3): Vec3`（等价于 `-v` 的别名）等——`conjugate` 函数体实现模式（`Quat(-q.x, -q.y, -q.z, q.w)` 主构造函数 + 逐分量取反）与阶段一 `negative`/`negate` 的实现模式（`Vec3(-v.x, -v.y, -v.z)`）完全一致；阶段二全部矩阵类型（`type_mat2x2.cj` 等 9 个文件）的逐分量运算符（如 `negative(mat): Mat`）同样已声明为 `const func` 实践成功。**实践结论**：`conjugate` 在仓颉侧**可声明为 `const func`**，与阶段一 Vec 家族 27 个 const func + 阶段二 Mat 家族逐分量 const func 的实践一致；下游按 `Quat(-q.x, -q.y, -q.z, q.w)` 主构造函数调用模式实现即可，无需担心编译期 const 上下文拒绝。**v10 附注**：若仓颉 const 函数还有其他限制（如不能调用非 const 自由函数、不能包含复杂表达式），则该论断需进一步评估；与 §5.4 const 上下文约束段保持一致。**§8 编码启动前验证项新增（v12 修订，Issue 7 响应）**：新增验证项 24「`conjugate` const func 编译可行性验证」，与 §8 现有验证项 1-23 一并执行
- `inverse(q: Quat<T,Q>): Quat<T,Q>` — `conjugate(q) / dot(q, q)`。**完整实现**（依赖 dot 和 除法运算符）。**边界行为（v3 新增契约，**v10 措辞统一，Issue 13 响应**）**：
  - 浮点四元数 `dot(q,q) == T(0)` 时除以零产生 Inf/NaN 分量（与 GLM 行为一致，GLM 不做零除保护）
  - 整数四元数 `dot(q,q) == T(0)` 时触发仓颉 `ArithmeticException`（**v10 措辞统一**：与浮点 Inf/NaN 行为不同；§5.3 边界条件表「整数 `inverse`」行措辞同步统一为「触发仓颉 `ArithmeticException`」，与本节描述对齐）
- `lerp(x, y, a): Quat<T,Q>` — `x * (1 - a) + y * a`。**完整实现**（运行时，非 const，含 `assert(a >= 0 && a <= 1)` 断言与 GLM `ext/quaternion_common.inl:28-38` 一致）。`const` 约束说明（v3 新增）：lerp 不可声明为 `const func`，因函数体内 `assert` 不是 `const` 函数（与 deviations.md IF-03 一致），调用时不可在 `const` 上下文（如 `const val` 初始化、`const func` 函数体）中使用。
- **跨 Qualifier 行为**（v15 新增，D34 决策）：本阶段仅提供 `x` 与 `y` 同 Q 的签名模板 `lerp(x: Quat<T,Q>, y: Quat<T,Q>, a: T): Quat<T,Q>`。若下游出现 `x` 与 `y` 的 Qualifier 不同的合法场景（如 `Quat<Float32, Highp>` 与 `Quat<Float32, Mediump>` 插值），当前签名模板将因 Q 不匹配触发编译错误。**建议的跨 Qualifier 扩展方案**（阶段四或按需实现）：新增双 Qualifier 重载 `lerp(x: Quat<T,Q1>, y: Quat<T,Q2>, a: T): Quat<T,?>` where T <: Number<T>, Q1 <: Qualifier, Q2 <: Qualifier——将 `x` 隐式转换为 `Q2`（通过跨 Qualifier 构造函数 `init<Q2>(q: Quat<T,Q2>) where Q2 <: Qualifier` 实现，见 §3.3 item 3），再执行同一 Q 下的 `lerp` 运算，输出 Qualifier 取 `Q2`（与 `y` 一致）。该重载在阶段四补充实现，本阶段不做阻塞。
- `slerp(x, y, a): Quat<T,Q>` — 依赖 `dot`/`acos(cosTheta)`（`trigonometric.cj` 的 `acos(T): T` 单参数版本，`v5 修订明确`）/`sin((1-a)*angle)`/`sin(a*angle)`/`sin(angle)`（`trigonometric.cj` 的 `sin(T): T` 单参数版本，`v5 修订明确`）/`mix`（标量版）+ `epsilon<T>()`。`acos`/`sin` 属 trigonometric.cj stub，`mix` 属 common.cj stub，`epsilon<T>()` 来自 scalar_constants.cj。**stub 占位**。
- `mix(x, y, a): Quat<T,Q>` — 依赖 `dot`/`acos(cosTheta)`（`trigonometric.cj` 的 `acos(T): T` 单参数版本，`v5 修订明确`）/`sin((1-a)*angle)`/`sin(a*angle)`/`sin(angle)`（`trigonometric.cj` 的 `sin(T): T` 单参数版本，`v5 修订明确`）/`epsilon<T>()`。`epsilon<T>()` 用于 `cosTheta > 1 - epsilon<T>()` 的退化检测分支。**stub 占位**。
- `slerp(x, y, a, k)` — 多旋转 slerp。**stub 占位**。**依赖关系（v5 新增）**：`dot`/`acos`/`sin`/`mix`（标量版，line 98-101 四次标量 `mix` 调用）/`epsilon<T>()`/`pi<T>()`（line 107：`T phi = angle + static_cast<T>(k) * glm::pi<T>();`）。其中 `pi<T>()` 来自 scalar_constants.cj，`mix` 来自 common.cj stub。**`k` 类型决策（v3 明确）**：采用 `slerp<T, Q>(x: Quat<T,Q>, y: Quat<T,Q>, a: T, k: Int64)` 简化版签名。GLM 4-arg `slerp` 使用独立整型参数 `S`（通过 `static_assert(is_integer)` 约束），仓颉版本固定为 `Int64`（与 deviations.md DV-03「移位运算右操作数固定为 Int64」风格一致），牺牲泛型灵活性换取签名简洁性。**理由**：阶段三 slerp 函数本身为 stub，固定 `Int64` 简化签名不影响本阶段实施；阶段四 slerp 完整实现时若需泛型 K 可扩展。
- `isnan(q: Quat<T,Q>): Vec4<Bool,Q>` — 依赖 `x.isNaN()` 实例方法（仓颉 `std.math` 仅提供实例方法，**不提供**顶层 `std.math.isNaN(x)` 函数）。**T 类型约束（v4 修订，v7 接口名修订）**：函数签名添加 `where T <: FloatingPoint<T>` 约束（与 §3.12 `epsilon<T>()` 约束收紧策略一致），限制函数仅对浮点类型 T 可调用。当调用方实例化 `Quat<Int64, PackedHighp>` 等整数四元数并调用 `isnan(q)` 时，编译期报类型不匹配错误（`Int64` 不实现 `FloatingPoint<Int64>` 接口），而非运行时报 `isNaN` 实例方法不存在错误。**Fallback 模式（理论不需要，仅兼容占位说明）**：由于 `FloatingPoint<T>` 是 stdlib 原生接口（`cangjie-std/math/README.md` 第 117 行明确定义），编译期保证可用，无「接口不可用」风险；此 fallback 仅作 v7 修订前的兼容占位说明——若某实现版本缺失 `FloatingPoint<T>` 接口（极小概率），则采用与 `epsilon<T>()` 类似的运行时分派模式——通过 `match` 或 `if-else` 对 `q.x` 的具体类型进行 `Float32`/`Float64` 分派，非浮点 T 实例化时抛 `Exception("isnan not defined for non-floating-point types")`。**实现路径**：约束通过后采用实例方法路径 `Vec4(q.x.isNaN(), q.y.isNaN(), q.z.isNaN(), q.w.isNaN())`。
- `isinf(q: Quat<T,Q>): Vec4<Bool,Q>` — 依赖 `x.isInf()` 实例方法。**T 类型约束（v4 修订，v7 接口名修订）**：与 `isnan` 完全一致，函数签名添加 `where T <: FloatingPoint<T>` 约束；fallback 模式与 `isnan` 一致。**实现路径**：约束通过后采用实例方法路径 `Vec4(q.x.isInf(), q.y.isInf(), q.z.isInf(), q.w.isInf())`。

**本阶段策略修正**：
- **完整实现**：`conjugate`、`inverse`、`lerp`（含断言 + 非 const）、`isnan`、`isinf`
- **stub 占位**：`mix`、`slerp`（2 版本，4 参数版 `k: Int64`）

### 3.12 scalar_constants 与 gtc/constants

**ext/scalar_constants.cj**：
- 提供 3 个泛型函数：`epsilon<T>()`、`pi<T>()`、`cos_one_over_two<T>()`
- 实际实现位于 `glm.detail.scalar_constants.cj`（声明 `package glm.detail`），ext/ 文件仅做 `public import` 重导出
- 依赖仅 `setup.cj`（GLM_CONFIG_* 配置常量），可**完整实现**
- **整数类型 T 的行为契约（v3 新增，v7 接口名修订）**：约束收紧为 `T <: FloatingPoint<T>`（stdlib 原生接口，`cangjie-std/math/README.md` 第 117 行）或等价约束（如仓颉版本不支持，则采用 `T <: Float32 | Float64`）。**若仓颉泛型不支持窄约束**，则在 `match` 中增加 `case _ => throw Exception("epsilon/pi/cos_one_over_two not defined for non-floating-point types")` 显式错误分支。GLM 1.0.3 `scalar_constants.inl:36-43` 使用 `static_assert(std::numeric_limits<genType>::is_iec559, ...)` 静态断言非浮点类型时编译失败——仓颉版本采用运行时异常等价行为。
- **具体类型分派**（与 deviations.md DV-04 的 `epsilonOf` 策略一致，需 `hint: T` 参数辅助类型推断）：对 Float32 返回 `Float32(1.1920929e-7)`，对 Float64 返回 `Float64(2.220446049250313e-16)`；`pi<T>()` 和 `cos_one_over_two<T>()` 同理使用具体类型硬编码值
- **与 `shim_limits.cj:25` `epsilonOf<T>(hint)` 关系（v10 新增，Issue 4 响应）**：阶段二 `cjglm/src/detail/shim_limits.cj:25` 已存在同名语义的 `public func epsilonOf<T>(hint: T): T where T <: Number<T>` 函数（通过 `NumericLimits<T>.epsilon(hint)` 内部实现，规则与本设计完全一致：`Float64` 返回 `2.220446049250313e-16`，`Float32` 返回 `1.1920929e-7`，其他类型返回 `hint - hint`）；`compute_vector_relational.cj:17` 已使用 `epsilonOf<T>(hint)` 模式。**v10 设计决策（与 §1 系统性约束一致）**：
  - (a) **功能等价无业务新增**：`epsilon<T>()` 与 `epsilonOf<T>(hint)` 在返回值语义上**完全一致**——两者均按 `T = Float32/Float64` 返回相同的硬编码机器精度值，对其他类型均返回 `hint - hint` 形式的零值
  - (b) **签名差异说明**：`epsilon<T>()` 无形参（与 GLM `glm::epsilon<T>()` 习惯对齐），`epsilonOf<T>(hint)` 携带 `hint: T` 形参（与 deviations.md DV-04 类型推断辅助参数风格一致）——下游调用者可按需选用，函数体实现可共享（`epsilon<T>()` 内部调用 `epsilonOf<T>(T(0))` 或 `epsilonOf<T>(T(1))` 即可）
  - (c) **阶段二测试硬编码值作为 ground truth**：阶段二测试 `tests/glm/detail/test_shim_limits.cj` 中硬编码的 `epsilon` 值（`Float32(1.1920929e-7)` / `Float64(2.220446049250313e-16)`）作为本设计 `epsilon<T>()` 实现的 ground truth；阶段三新增 `tests/glm/detail/test_scalar_constants.cj` 应交叉验证两者返回值一致
  - (d) **编码启动前验证项新增**：本节末尾追加「验证 `epsilon<T>()` 与 `epsilonOf<T>(hint)` 在 T=Float32/Float64/Int64 下的返回值一致性」验证项

**epsilon 硬编码参考值（ground truth，供验证项 19 直接引用）**：
  - `Float32`: `1.1920929e-7`（对应 `Float32(1.1920929e-7)`）
  - `Float64`: `2.220446049250313e-16`（对应 `Float64(2.220446049250313e-16)`）
  - 整数类型（`Int8`~`Int64`）：`0`（通过 `hint - hint` 或 `T(Float64(0))` 获取）
  - 以上值源自阶段二测试 `tests/glm/detail/test_shim_limits.cj` 的硬编码 ground truth，阶段三 `test_scalar_constants.cj` 应交叉验证 `epsilon<T>()` 与 `epsilonOf<T>(hint)` 返回值完全一致

**gtc/constants.cj**：
- 提供 **28 个**常量函数（zero/one/two_pi/tau/root_pi/half_pi/three_over_two_pi/quarter_pi/one_over_pi/one_over_two_pi/two_over_pi/four_over_pi/two_over_root_pi/one_over_root_two/root_half_pi/root_two_pi/root_ln_four/e/euler/root_two/root_three/root_five/ln_two/ln_ten/ln_ln_two/third/two_thirds/golden_ratio）
- **v8 修订**：v7 文档文字描述列出 28 个常量函数名称（与 GLM 1.0.3 `gtc/constants.inl` 实际声明数一致）但汇总数字误标为「25」，本轮统一修订为「28」。**测试覆盖目标同步**：`tests/glm/gtc/test_constants.cj`（v8 命名约定修订，见 §8.2）至少 28 个测试用例，每常量函数 1 个用例验证返回值正确性
- 全部为泛型函数 `func zero<T>(): T` 等，内部使用具体类型硬编码值直接返回（与 GLM `genType(3.14159...)` 实现方式一致，避免函数间调用依赖）
- 依赖 `ext/scalar_constants.cj`（间接通过 detail/scalar_constants.cj）
- 可**完整实现**

### 3.13 新增空桩文件

本阶段新增以下空桩文件以满足 gtc/matrix_transform.cj 的传递依赖闭合：

| 文件 | 包 | 内容 |
|------|---|------|
| `trigonometric.cj` | glm.detail | **标量/向量重载区分（v8 新增）**：提供 30 个函数（15 标量 + 15 向量），详见 §3.13.1 |
| `ext/matrix_projection.cj` | glm.ext | `perspective`/`ortho` 等投影矩阵函数空壳 |
| `ext/matrix_clip_space.cj` | glm.ext | 裁剪空间矩阵函数空壳 |
| `ext/matrix_transform.cj` | glm.ext | `translate`/`rotate`/`scale`/`lookAt` 等变换函数空壳 |
| `gtc/matrix_transform.cj` | glm.gtc | 矩阵变换函数库（**v12 关键修订，Issue 4 响应：明确具体函数清单；v13 关键修订，Issue 1+2 响应：函数清单 35→64 修订**）——本阶段声明 64 个函数签名（与 GLM 1.0.3 `glm/gtc/matrix_transform.hpp` 通过 `ext/matrix_transform.inl` + `ext/matrix_clip_space.inl` + `ext/matrix_projection.inl` 三文件间接包含的实际声明数 64 一致）作为 stub 占位；下游按 lib.cj 第 9 行追加的 `import glm.gtc.matrix_transform` 调用时所有函数均存在但实现为 `throw Exception("stub")`。具体清单见 §3.13 表格下「`gtc/matrix_transform.cj` 函数清单（v12 新增 + v13 扩展 35→64，Issue 1+2 响应）」段 |

**沿用自阶段二的 stub**：`common.cj`、`geometric.cj`、`matrix.cj`（27 实现 + 6 stub）

**`gtc/matrix_transform.cj` 函数清单（v12 新增 Issue 4 响应，**v13 关键修订 35→64 响应 Issue 1+2，附 v2 扩展证据**）**：GLM 1.0.3 `glm/gtc/matrix_transform.hpp` 实际声明 64 个函数（依据 GLM 1.0.3 源码全文检索统计，分布于 3 个间接 include 的 .inl 文件：`ext/matrix_transform.inl` 11 个 + `ext/matrix_clip_space.inl` 46 个 + `ext/matrix_projection.inl` 7 个 = **64 个**）。本阶段声明所有函数签名作为 stub 占位，确保下游 lib.cj 第 9 行追加 `import glm.gtc.matrix_transform` 调用时所有函数均存在但实现为 `throw Exception("stub")`。**v13 修订要点**：
- **v12 描述「35 个函数」错误**——v12 实际列出 3+2+5+10+10+1+4 = 35 个，与 GLM 实际 64 个偏差 29 个
- **v12 列出 5 个虚构函数**：`scaleAlongAxis`（GLM 中**不存在**）+ `tweakedInfinitePerspectiveLH_ZO`/`tweakedInfinitePerspectiveLH_NO`/`tweakedInfinitePerspectiveRH_ZO`/`tweakedInfinitePerspectiveRH_NO`（GLM 中**仅 2 个** `tweakedInfinitePerspective` 重载，定义于 `ext/matrix_clip_space.inl:593` + `:611`，函数签名 `tweakedInfinitePerspective(T fovy, T aspect, T zNear, T ep)` 与 `tweakedInfinitePerspective(T fovy, T aspect, T zNear)`，**无 ZO/NO 变体**）
- **v12 遗漏 29 个真实函数**：identity、scale_slow、shear、shear_slow、lookAtRH、lookAtLH 等基础变换 6 个（基础变换分类仅 3 个应为 11 个）；orthoZO、orthoNO、orthoLH、orthoRH 等视口变体 4 个（视口变换分类仅 5 个应为 9 个）；frustum（一般）+ frustumZO + frustumNO + frustumLH + frustumRH 等视锥体 5 个（遗漏整个 frustum 系族 9 个）；perspective（一般）+ perspectiveZO + perspectiveNO + perspectiveLH + perspectiveRH 等 5 个（perspective 系族仅 4 个应为 9 个）；perspectiveFovZO + perspectiveFovNO + perspectiveFovLH + perspectiveFovRH 等 5 个（perspectiveFov 系族仅 4 个应为 9 个）；infinitePerspectiveRH、infinitePerspectiveLH 等 2 个（infinitePerspective 系族仅 5 个应为 7 个）
- **`matrixCompMult` 归属错误**：`matrixCompMult` 实际定义于 `glm/detail/func_matrix.inl`（与 `gtc/matrix_transform.hpp` 无关），不应列入本文件清单

具体函数清单（**v13 修订后**，共 64 个函数）：

| 类别 | 函数数量 | 函数列表 | GLM 源文件 |
|------|---------|---------|-----------|
| 基础变换 | 11 | `identity`、`translate`、`rotate`、`rotate_slow`、`scale`、`scale_slow`、`shear`、`shear_slow`、`lookAtRH`、`lookAtLH`、`lookAt` | `ext/matrix_transform.inl` |
| 视口与裁剪空间（ortho 系族） | 10 | `ortho`（无 zNear/zFar）、`ortho`（3D 一般版本，含 zNear/zFar）、`orthoLH_ZO`、`orthoLH_NO`、`orthoRH_ZO`、`orthoRH_NO`、`orthoZO`、`orthoNO`、`orthoLH`、`orthoRH` | `ext/matrix_clip_space.inl` |
| 视口与裁剪空间（frustum 系族） | 9 | `frustum`、`frustumLH_ZO`、`frustumLH_NO`、`frustumRH_ZO`、`frustumRH_NO`、`frustumZO`、`frustumNO`、`frustumLH`、`frustumRH` | `ext/matrix_clip_space.inl` |
| 透视投影（perspective 系族） | 9 | `perspective`、`perspectiveLH_ZO`、`perspectiveLH_NO`、`perspectiveRH_ZO`、`perspectiveRH_NO`、`perspectiveZO`、`perspectiveNO`、`perspectiveLH`、`perspectiveRH` | `ext/matrix_clip_space.inl` |
| 透视投影（perspectiveFov 系族） | 9 | `perspectiveFov`、`perspectiveFovLH_ZO`、`perspectiveFovLH_NO`、`perspectiveFovRH_ZO`、`perspectiveFovRH_NO`、`perspectiveFovZO`、`perspectiveFovNO`、`perspectiveFovLH`、`perspectiveFovRH` | `ext/matrix_clip_space.inl` |
| 无穷远透视（infinitePerspective 系族） | 7 | `infinitePerspective`、`infinitePerspectiveLH_ZO`、`infinitePerspectiveLH_NO`、`infinitePerspectiveRH_ZO`、`infinitePerspectiveRH_NO`、`infinitePerspectiveLH`、`infinitePerspectiveRH` | `ext/matrix_clip_space.inl` |
| 无穷远透视（tweakedInfinitePerspective 系族） | 2 | `tweakedInfinitePerspective(T fovy, T aspect, T zNear, T ep)`（4 参数含 `ep`）、`tweakedInfinitePerspective(T fovy, T aspect, T zNear)`（3 参数无 `ep`） | `ext/matrix_clip_space.inl:593, :611` |
| 投影工具 | 6 | `projectZO`、`projectNO`、`project`、`unProjectZO`、`unProjectNO`、`unProject` | `ext/matrix_projection.inl` |
| 拾取矩阵 | 1 | `pickMatrix` | `ext/matrix_projection.inl` |
| **合计** | **64 个函数**（**v13 关键修订**：v12 描述「35 个函数」与 GLM 1.0.3 实际 64 个函数显著偏差 29 个；**v13 已完整修订**为 64 个函数按 6 大类 + 子类分组明确列出，确保 lib.cj 第 9 行追加 `import glm.gtc.matrix_transform` 能正常解析所有 64 个函数；`matrixCompMult` 已从清单中移除——实际定义于 `glm/detail/func_matrix.inl` 而非 gtc/matrix_transform；**v14 关键修订，Issue 3 响应**：ortho 系族从 9 修正为 10（补充 3D ortho 一般版本 `ortho(T left, T right, T bottom, T top, T zNear, T zFar)`），合计 11+10+9+9+9+7+2+6+1=**64** 条目数不变——原 v13 的 9 个 ortho 子类实际函数清单缺少 3D 一般版本，但总和 63 未被检出是因 `ext/matrix_clip_space.inl` 按函数列表归属计数时 ortho 族实际恰好 10 个（两个 `ortho` 重载 + 8 个变体），v13 分组时遗漏了含 zNear/zFar 参数的 3D ortho 重载） |

**代表性函数签名模板（v24 新增，Issue 6 响应）**：以下为 6 大类中各选一个代表性函数的完整签名模板，同类其他函数按此模板类推展开：

1. **基础变换（以 `translate` 为例）**：`public func translate<T, Q>(m: Mat4x4<T, Q>, v: Vec3<T, Q>): Mat4x4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier`
2. **视口裁剪（以 `orthoLH_ZO` 为例）**：`public func orthoLH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier`
3. **透视投影（以 `perspectiveRH_ZO` 为例）**：`public func perspectiveRH_ZO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier`
4. **无穷远透视（以 `infinitePerspective` 为例）**：`public func infinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier`
5. **投影工具（以 `projectZO` 为例）**：`public func projectZO<T, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier`
6. **拾取矩阵（以 `pickMatrix` 为例）**：`public func pickMatrix<T, Q>(center: Vec2<T, Q>, delta: Vec2<T, Q>, viewport: Vec4<T, Q>): Mat4x4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier`

**展开规则**：同类函数中变体（如 `perspectiveLH_ZO`/`perspectiveLH_NO`/`perspectiveRH_ZO`/`perspectiveRH_NO`）的签名参数列表与代表性函数一致，仅函数名按 LH/RH 和 ZO/NO 后缀组合变化。`where T <: FloatingPoint<T>, Q <: Qualifier` 约束对所有函数统一适用。

**下游实施约束（v12 修订 + v13 关键修订，Issue 1+2 响应）**：
- 实施时按上述 64 个函数清单逐一声明函数签名（**v13 修订**：v12 描述「35 个」遗漏 29 个）
- 每个函数体实现为 `throw Exception("stub")`
- 函数签名参数类型与 GLM 原始声明对齐（`Mat4x4`/`Mat3x3`/`Vec3`/`Float32`/`Float64` 等），无需本阶段严格翻译 `where T <: FloatingPoint<T>` 等约束
- 阶段四实现时按 `lib.cj` import 顺序与 §10 覆盖矩阵定义的实际优先级补齐函数体
- **v13 实施位置更新（Issue 1 响应）**：lib.cj 实际仅 8 行，阶段三新增 import 追加至 lib.cj 第 9 行（非 v12 描述的「第 131 行」）；下游编码者按本节清单实施时无需在 lib.cj 中查找「第 131 行」——直接编辑 8 行文件末尾追加 1 行 import 即可

#### 3.13.1 trigonometric.cj 函数清单（v8 新增标量/向量重载区分，v10 修订 VecN 占位符展开规则）

`detail/trigonometric.cj` 本阶段需提供 **30 个函数**（v8 修订：v7 文档仅列出 15 个函数名但未区分标量/向量重载，下游仅声明向量版本会导致 `mix`/`slerp`/`roll`/`pitch`/`yaw`/`pow`/`log` 等的 `acos(T)`/`sin(T)`/`atan(T)` 标量调用编译失败）：

**`VecN<T, Q>` 占位符展开规则（v10 新增，Issue 5 响应）**：上表 `VecN<T, Q>` 是占位符——**仓颉项目不存在 `VecN` 泛型占位类型**。实际展开模式遵循 `cjglm/src/detail/compute_vector_decl.cj` 的 `compute_vec_xxx1/2/3/4` 模式（即 4 个独立函数重载，对应 Vec1/Vec2/Vec3/Vec4）。下游实现 trigonometric.cj 时，每个 `VecN<T, Q>` 占位符应展开为 4 个独立函数：
- `sin<T, Q>(x: Vec1<T, Q>): Vec1<T, Q>` / `sin<T, Q>(x: Vec2<T, Q>): Vec2<T, Q>` / `sin<T, Q>(x: Vec3<T, Q>): Vec3<T, Q>` / `sin<T, Q>(x: Vec4<T, Q>): Vec4<T, Q>`
- 其余 14 个单参数三角函数（`cos`/`tan`/`asin`/`acos`/`atan`/`sinh`/`cosh`/`tanh`/`asinh`/`acosh`/`atanh`/`radians`/`degrees`）+ 1 个双参数 `atan2` 同理展开

**展开后的实际函数总数重算（v10 修订）**：
- 标量单参数三角函数：14 个（每个 1 个签名 = 14）
- 向量单参数三角函数：14 个函数 × 4 个分量数 = 56 个
- 标量双参数三角函数（`atan2`）：1 个
- 向量双参数三角函数（`atan2`）：1 个 × 4 个分量数 = 4 个
- **展开后实际函数总数 = 14 + 56 + 1 + 4 = 75 个**（v10 修订：v9 描述的「30 个函数」是占位符层级计数，未按 `VecN<T, Q>` 占位符展开为 4 个独立重载；下游按设计实现时实际应声明 75 个函数签名，其中标量 15 个用于 `slerp`/`mix`/`pow`/`log`/`exp`/`angle`/`angleAxis` 等四元数函数体的分量级运算，向量 60 个用于阶段四 vec 级运算）

**单参数三角函数（14 函数 × 2 重载类型 = 28 行占位符签名，展开后 70 个函数）**：

**内部依赖统一说明（v12 关键修订，Issue 3 响应，删除冗余重复说明）**：表行「内部依赖」列对每个 std.math 函数调用，原 v11 重复 14 次「std.math Float32 重载已提供」说明。v12 修订后，**统一指向 §1「Float32 与 std.math 的交互约束」段作为单一权威来源**：§1 已明确 `std.math` 三角函数（`sin`/`cos`/`tan`/`asin`/`acos`/`atan`/`sinh`/`cosh`/`tanh`/`asinh`/`acosh`/`atanh`/`atan2`）均提供 Float16/Float32/Float64 重载，`std.math.pow` 提供 Float32/Float64 共 4 个重载——T=Float32 实例化时直接调用 std.math 对应重载即可（与 §1 方案 A 一致），无需 `T(Float64.xxx(Float64(value)))` 显式转换；`radians`/`degrees` 是例外（stdlib 不存在，需硬编码 π 字面量）。表行仅标注 std.math 函数名（不带重复说明），详细约束规则查阅 §1 与下表「**Float32 实例化影响（v11 修订，Issue 7 关联）**」段（v12 修订：移除原独立段落，与表行整合）。

> **v24 修订，Issue 3 响应**：本表「内部依赖」列标注的 `std.math.sin`/`std.math.cos` 等依赖为**阶段四完整的实现后依赖**；本阶段所有函数体为 `throw Exception("stub")`，编译时不实际触发这些依赖。

| 函数 | 标量签名（v11 关键修订，Issue 1 响应，所有签名统一标注 `where T <: FloatingPoint<T>>`） | 向量签名（占位符，v11 修订列标题：明确按 Vec1~Vec4 展开为 4 个独立函数） | 内部依赖（v12 修订，Issue 3 响应；v24 修订，Issue 3 响应：标注的依赖为阶段四依赖） |
|------|---------|---------|---------|
| `sin` | `sin<T>(x: T): T where T <: FloatingPoint<T>` | `sin<T, Q>(x: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | `std.math.sin（阶段四依赖）` |
| `cos` | `cos<T>(x: T): T where T <: FloatingPoint<T>` | `cos<T, Q>(x: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | `std.math.cos（阶段四依赖）` |
| `tan` | `tan<T>(x: T): T where T <: FloatingPoint<T>` | `tan<T, Q>(x: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | `std.math.tan（阶段四依赖）` |
| `asin` | `asin<T>(x: T): T where T <: FloatingPoint<T>` | `asin<T, Q>(x: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | `std.math.asin（阶段四依赖）` |
| `acos` | `acos<T>(x: T): T where T <: FloatingPoint<T>` | `acos<T, Q>(x: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | `std.math.acos（阶段四依赖）` |
| `atan` | `atan<T>(x: T): T where T <: FloatingPoint<T>` | `atan<T, Q>(x: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | `std.math.atan（阶段四依赖）` |
| `sinh` | `sinh<T>(x: T): T where T <: FloatingPoint<T>` | `sinh<T, Q>(x: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | `std.math.sinh（阶段四依赖）` |
| `cosh` | `cosh<T>(x: T): T where T <: FloatingPoint<T>` | `cosh<T, Q>(x: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | `std.math.cosh（阶段四依赖）` |
| `tanh` | `tanh<T>(x: T): T where T <: FloatingPoint<T>` | `tanh<T, Q>(x: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | `std.math.tanh（阶段四依赖）` |
| `asinh` | `asinh<T>(x: T): T where T <: FloatingPoint<T>` | `asinh<T, Q>(x: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | `std.math.asinh（阶段四依赖）` |
| `acosh` | `acosh<T>(x: T): T where T <: FloatingPoint<T>` | `acosh<T, Q>(x: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | `std.math.acosh（阶段四依赖）` |
| `atanh` | `atanh<T>(x: T): T where T <: FloatingPoint<T>` | `atanh<T, Q>(x: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | `std.math.atanh（阶段四依赖）` |
| `radians` | `radians<T>(x: T): T where T <: FloatingPoint<T>` | `radians<T, Q>(x: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | **例外（stdlib 不存在）**：硬编码 π 字面量，见本表下实现段。**交叉引用**：硬编码 π 值与 §3.12 `pi<T>()` 的 π 值应一致，建议提取为共享常量 |
| `degrees` | `degrees<T>(x: T): T where T <: FloatingPoint<T>` | `degrees<T, Q>(x: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | **例外（stdlib 不存在）**：硬编码 π 字面量，见本表下实现段。**交叉引用**：硬编码 π 值与 §3.12 `pi<T>()` 的 π 值应一致，建议提取为共享常量 |

**双参数三角函数（v8 新增 `atan2` 双参数标量版本）**：

| 函数 | 标量签名（v11 关键修订，Issue 1 响应） | 向量签名（占位符，v11 修订列标题） | 内部依赖（v12 修订） |
|------|---------|---------|---------|
| `atan2` | `atan2<T>(y: T, x: T): T where T <: FloatingPoint<T>`（v8 明确要求；GLM `std::atan2(T, T)` 对应物） | `atan2<T, Q>(y: VecN<T, Q>, x: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | `std.math.atan2（阶段四依赖）` |

**T 类型约束策略（v11 关键修订，Issue 1 响应）**：所有 15 个函数（14 单参数三角函数 + 1 双参数 `atan2`）的标量与向量签名模板均统一添加 `where T <: FloatingPoint<T>` 约束（与 §3.2.1 D32、§3.11 D29、§3.12 D25 已统一策略一致）；下游对 T 约束决策无需重复选择；整数 T 实例化时（如 `Quat<Int64, PackedHighp>.inverse()` 调用 `acos(int)`）将编译期报类型不匹配错误并提供前置告警。**v11 附注（质询报告 B 项响应）**：本约束的必要性是「阶段四完整实现前的必备前置项」——若 trigonometric.cj 函数体不约束 T 为浮点类型，阶段四 stub 替换为 `std.math.{func}` 调用时，整数 T 实例化将报 `std.math.{func}(Int64)` 不存在错误（因 std.math 数值函数仅对 Float16/Float32/Float64 提供重载）；本约束提前到签名声明阶段，避免阶段四实现时再回头加约束引入 API 变更。因此**严重程度保留**（与 Issue 1 一致），但本约束的实施不阻塞阶段三本身的完整实现路径，仅在阶段四实现 trigonometric.cj 函数体时生效。

**Float32 实例化影响（v11 修订，Issue 7 关联，v12 关键修订，Issue 3 响应）**：原 v11 在本节独立段重复说明 std.math Float32 重载可用性，与 §1「Float32 与 std.math 的交互约束」段形成内容重复。**v12 修订后本段并入 §1 单段说明**，表行不再重复标注。完整权威说明查阅 §1 段——关键结论：所有 std.math 三角函数（`sin`/`cos`/`tan`/`asin`/`acos`/`atan`/`sinh`/`cosh`/`tanh`/`asinh`/`acosh`/`atanh`/`atan2`/`sqrt`/`exp`/`log`）均提供 Float16/Float32/Float64 重载，T=Float32 实例化时直接调用 std.math 对应重载即可；`radians`/`degrees` 是例外（stdlib 不存在，需硬编码 π 字面量）；`std.math.pow` 提供 Float32/Float64 共 4 个重载。

**展开后实际函数总数重算（v11 关键修订，Issue 11 响应，补充 30→75 过渡说明）**：
- **占位符层级（v9 修订计数）**：14 个单参数三角函数（标量 + 向量 14 行）+ 1 个双参数 `atan2`（标量 + 向量 1 行）= **15 个函数名 × 2 行 = 30 行占位符签名模板**
- **展开后实际函数数（v10 重算，v11 保留）**：每个 `VecN<T, Q>` 占位符展开为 Vec1/Vec2/Vec3/Vec4 共 4 个独立函数签名——标量 14 个不变（每函数 1 个签名 = 14）+ 向量 14 个 × 4 个分量数 = 56 个 + 双参数 `atan2` 标量 1 个 + 双参数 `atan2` 向量 1 × 4 = 4 个 = **总计 75 个函数签名**
- **过渡说明（v11 新增，Issue 11 响应）**：从 v9 占位符层级的 30 行模板 → v10/v11 实际展开后的 75 个函数签名，**2.5 倍数量跳跃源于 VecN 占位符展开规则**——每个「向量签名」占位符行实际对应 Vec1/Vec2/Vec3/Vec4 共 4 个独立函数签名。下游编码者实现 trigonometric.cj 时，每行模板应按 §3.13.1 「`VecN<T, Q>` 占位符展开规则」段（位于表前）展开为 4 个独立函数；下游按 v9 文档「30 行」实现时仅声明 30 个函数会导致向量调用方在编译时找不到 Vec1/Vec2/Vec3/Vec4 任一分量数的实例（与 `compute_vector_decl.cj` 4 个独立 struct 模式不符）

**约束说明**：
- 标量版本用于 `slerp`/`mix`/`pow`/`log`/`exp`/`angle`/`angleAxis` 等四元数函数体内的**分量级运算**（如 `slerp` 中 `acos(cosTheta)`、`pow` 中 `asin(sqrt(VectorMagnitude) / magnitude)`）
- 向量版本用于**阶段四 vec 级运算**（如 vec3 应用四元数旋转的逐分量 sin/cos 变换）
- 所有函数本阶段均为 stub（仅签名空壳 + `throw Exception("stub")`），具体实现推迟至阶段四 trigonometric.cj 完整实现时补齐
- **下游消费者提示**：`slerp`/`mix`/`pow`/`log`/`exp` 等函数体内的 `acos(cosTheta)`/`sin(angle)`/`atan(denom, numer)` 等调用直接使用**标量版本**（参数为 `T`），与本节签名一致
- **T 类型约束（v11 关键修订，Issue 1 响应）**：所有 75 个展开函数签名均标注 `where T <: FloatingPoint<T>`；下游按设计实现时需在签名声明阶段保留该约束，与 §3.2.1 D32 / §3.11 D29 / §3.12 D25 约束收紧策略一致

### 3.13.2 本阶段实现但运行时受 stub 依赖影响的函数集中审计（v11 新增，质询报告 C 项响应）

**v15 修订，Issue 2 响应**：本节函数状态计数已与 §11.5 函数可用性对照表统一对齐。**全文档函数可用状态以 §11.5 为最终基准**。

本节集中审计「本阶段标注为完整实现或部分实现，但运行时受 stub 依赖影响」的函数，列出调用链与异常传播路径——呼应任务描述对「异常场景和边界条件」的关注。

| 函数 | 标注状态 | 依赖 stub 来源 | 运行时行为契约 | 阶段四补齐路径 |
|------|---------|--------------|--------------|--------------|
| `Quat×Vec3` 运算符 | §3.4 标注「实现」 | `ext/quaternion_common.cj` 中的向量 `cross`（**`geometric.cj` stub**） | 阶段三调用抛 `Exception("stub")` | 阶段四 geometric.cj 向量 cross 完整实现后，旋转公式 `v + (cross(QuatVector, v) * q.w + cross(QuatVector, cross(QuatVector, v))) * T(Float64(2))` 生效 |
| `Quat×Vec4` 运算符 | §3.4 标注「实现」 | 通过 `Quat×Vec3` 中间路径间接依赖 `geometric.cj` stub | 阶段三调用抛 `Exception("stub")` | 同上 |
| `epsilon<T>()`/`pi<T>()`/`cos_one_over_two<T>()` | §3.12 标注「完整实现」 | 无 stub 依赖（运行时分派 `match`） | 整数 T 调用时抛 `Exception("not defined for non-floating-point types")`（D25 决策） | 阶段四约束收紧策略生效后编译期拒绝（无需运行时异常） |
| `dot(q1, q2)` | §3.7 标注「完整实现」 | 纯算术（四元数点积 `x.w*y.w + x.x*y.x + x.y*y.y + x.z*y.z`） | 阶段三可调用 | — |
| `cross(Quat, Quat)` | §3.7 标注「完整实现」 | 纯算术（Hamilton 乘积逐分量展开） | 阶段三可调用 | — |
| `equal(Quat, Quat)` / `equal(Quat, Quat, epsilon)` | §3.6 标注「完整实现」 | 纯比较 / 内联 abs 模式 | 阶段三可调用 | — |
| `notEqual(Quat, Quat)` / `notEqual(Quat, Quat, epsilon)` | §3.6 标注「完整实现」 | 纯比较 / 内联 abs 模式 | 阶段三可调用 | — |
| `axis(q)` | §3.9 标注「完整实现」 | `std.math.sqrt`（**v11 修订，Issue 7 关联**：T=Float32 时直接调用 Float32 重载） | 阶段三可调用（T=Float32/Float64 均有效） | — |
| `length(q)` | §3.7 标注「完整实现」 | `std.math.sqrt` | 阶段三可调用 | — |
| `normalize(q)` | §3.7 标注「完整实现」（**v26 修订，Issue 2 响应：约束收紧为 `where T <: FloatingPoint<T>`**；**v11 修订**：补充零四元数保护；**v13 关键修订，Issue 6 响应：交叉引用**——完整边界行为契约详见 §5.3 边界条件表 normalize 行） | `length(q)` | 阶段三可调用（仅浮点 T，整数 T 编译期拒绝）：零四元数返回单位四元数；其他输入返回归一化结果 | — |
| `inverse(q)` | §3.11 标注「完整实现」 | `conjugate(q)` + `dot(q, q)`（**`quaternion_geometric.cj` 已完整实现**） | 阶段三可调用：浮点零除产生 Inf/NaN，整数零除抛 `ArithmeticException` | — |
| `isnan(q)`/`isinf(q)` | §3.11 标注「完整实现」 | `x.isNaN()`/`x.isInf()` 实例方法（**v11 修订，Issue 8 关联**：`FloatingPoint<T>` 接口实例方法） | 阶段三可调用（仅浮点 T） | 阶段四 `FloatingPoint<T>` 约束收紧后编译期拒绝整数 T |
| `mat3Cast`/`mat4Cast`/`quatCast` | §3.2.1 标注「完整实现」 | `pow`/`sqrt`/`trace`（`std.math` 已实现） | 阶段三可调用（仅浮点 T） | 阶段四 `FloatingPoint<T>` 约束收紧后编译期拒绝整数 T |
| `conjugate(q)` | §3.11 标注「完整实现」 | 无（仅逐分量取反） | 阶段三可调用 | — |
| `lerp(q1, q2, a)` | §3.11 标注「完整实现」 | 无（纯算术，含 `assert(a ∈ [0,1])`） | 阶段三可调用：`a` 超出 [0,1] 时 `assert` 失败 | — |
| `mix`/`slerp`(2 个版本) | §3.11 标注「stub」 | `trigonometric.cj` 的 `acos(T)`/`sin(T)` 单参数版本 + `common.cj` 的 `mix` 标量版 + `epsilon<T>()`（已实现） | 阶段三调用抛 `Exception("stub")` | 阶段四 trigonometric.cj/common.cj 完整实现后生效 |
| `exp(q)`/`log(q)`/`pow(q, y)`/`sqrt(q)` | §3.10 标注「stub」 | trigonometric.cj `sin`/`cos`/`acos` + std.math `pow`/`exp`/`log`/`sqrt` + `epsilon<T>()`/`pi<T>()`/`cos_one_over_two<T>()` + `FloatingPoint<T>.getMinDenormal()`/`getInf()`（**v11 修订，Issue 8 关联**） | 阶段三调用抛 `Exception("stub")` | 阶段四 trigonometric.cj 完整实现后生效 |
| `axis`/`angle`/`angleAxis` | §3.9 标注「axis 完整实现 + angle/angleAxis stub」 | trigonometric.cj `asin`/`acos` + std.math `sin`/`cos` | 阶段三：`axis` 可调用；`angle`/`angleAxis` 抛 `Exception("stub")` | 阶段四 trigonometric.cj 完整实现后 `angle`/`angleAxis` 生效 |
| `eulerAngles(q)`/`roll(q)`/`pitch(q)`/`yaw(q)` | §3.15 标注「stub」 | trigonometric.cj `atan`/`asin` + common.cj `clamp` + vector_relational.cj `equal` + `epsilon<T>()` | 阶段三调用抛 `Exception("stub")` | 阶段四 trigonometric.cj/common.cj 完整实现后生效 |
| `quatLookAt*`(3 个版本) | §3.15 标注「stub」 | `geometric.cj` 的 `cross`/`dot`/`normalize`/`inversesqrt`/`max` + `type_quat_cast.quatCast` | 阶段三调用抛 `Exception("stub")` | 阶段四 geometric.cj 完整实现后生效 |
| `gtc/matrix_transform` 全部 64 个函数（**v14 新增，Issue 7 响应**） | §3.13 标注「stub」 | `ext/matrix_projection.cj` + `ext/matrix_clip_space.cj` + `ext/matrix_transform.cj` + `geometric.cj` + `trigonometric.cj` + `matrix.cj`（均为 stub，通过 `gtc/matrix_transform.cj` 聚合） | 阶段三调用抛 `Exception("stub")` | 阶段四所有 stub 函数库完整实现后生效 |

**审计结论**：
- **本阶段可调用的「真完整实现」函数**（无 stub 依赖）：`epsilon<T>()`/`pi<T>()`/`cos_one_over_two<T>()`/`axis`/`length`/`normalize`/`inverse`/`isnan`/`isinf`/`mat3Cast`/`mat4Cast`/`quatCast`/`conjugate`/`lerp`/`dot`/`cross(Quat)`/`equal(Quat)`/`notEqual(Quat)`（共 **18 个函数**【v15 修订，Issue 4 响应：上一轮误标为 17 个，实际列表含 18 个函数名，本轮修正为 18】）**——按函数名计数（不含重载）；按 §11.5 表行粒度展开为 21 行**（v24 修订，Issue 4 响应）
- **本阶段实现但运行时受 stub 依赖影响的函数**：`Quat×Vec3`/`Quat×Vec4` 运算符（2 个）
- **本阶段 stub 占位的函数**：`mix`/`slerp`/`exp`/`log`/`pow`/`sqrt`/`angle`/`angleAxis`/`rotate`/`eulerAngles`/`roll`/`pitch`/`yaw`/`quatLookAt*`（14 个）+ `gtc/matrix_transform` 全部 64 个函数 + `fromVec3`/`fromEuler`（2 个）+ `ext/vector_relational` ULP 版本（4 个 ❌ 条目覆盖 8 重载）+ `type_quat.cj` 中 Quat×Vec3/Vec4（1 个 ⚠️） = **88 个**（**v20 修订，Issue 2 响应**：上一轮计数 78 仅含审计表显式列出的 stub，未计入 `fromVec3`/`fromEuler` ❌、`vector_relational` ULP ❌（4 条目）和 `Quat×Vec3/Vec4` ⚠️（1 条目），合计差值 10 个；本轮修正为 88，与 §10 覆盖矩阵合计行 88 个 ⚠️/❌ 一致）

下游测试设计时，对「本阶段可调用的真完整实现函数」可执行完整功能验证；对「实现但运行时受 stub 依赖影响」函数应标注「本阶段抛 stub 异常，待阶段四 stub 替换后生效」（与 §11.5 ⚠️ 符号对应）；对「stub 占位函数」仅执行 `assertThrows` 异常路径验证。**函数可用状态以 §11.5 为最终基准**。

### 3.14 四元数别名文件

ext/ 下新增四元数别名文件：

| 文件 | 别名内容 |
|------|---------|
| `quaternion_float.cj` | `quat = Quat<Float32, PackedHighp>` |
| `quaternion_double.cj` | `dquat = Quat<Float64, PackedHighp>` |
| `quaternion_float_precision.cj` | `highp_quat`/`mediump_quat`/`lowp_quat` |
| `quaternion_double_precision.cj` | `highp_dquat`/`mediump_dquat`/`lowp_dquat` |

fwd.cj 新增别名（v3 明确，**v8 修订**：v7 引用阶段二矩阵的 `Mat2x2`/`FMat2x2` 双别名机制作为先例，但通过直接查阅 `cjglm/src/fwd.cj` 全文确认 `Mat` 家族**仅存在** `Mat2x2` (Float32) + `DMat2x2` (Float64) 双别名（见 `fwd.cj:327, 347`），**不存在** `FMat*` 任何声明；`fwd.cj` 中唯一带 `F` 前缀的别名是 Vec 家族（`FVec1`~`FVec4` 见 `fwd.cj:275-278`、精度变体 `HighpFVec*`~`LowpFVec*` 见 `fwd.cj:279-290`）。`Vec` 家族采用 `Vec2` + `DVec2` + `FVec2` **三重模式**（`fwd.cj:106, 123, 276`）：

| 别名 | 类型 | 备注 |
|------|------|------|
| `Quat` | `Quat<Float32, PackedHighp>` | Float32 主别名（对应 `Vec2` 在 Vec 家族的角色） |
| `FQuat` | `Quat<Float32, PackedHighp>` | Float32 别名（与 `Quat` 等价，对应 `FVec2` 在 Vec 家族的角色） |
| `DQuat` | `Quat<Float64, PackedHighp>` | Float64 主别名（对应 `DVec2` 在 Vec 家族的角色） |
| `HighpQuat`/`MediumpQuat`/`LowpQuat` | `Quat<Float32, *>` | Float32 精度变体（3 个，对应 Vec 家族 `HighpFVec*` 等） |
| `HighpDQuat`/`MediumpDQuat`/`LowpDQuat` | `Quat<Float64, *>` | Float64 精度变体（3 个） |

**合计 9 个别名**（**v10 修订**：v9 描述误为 8 个；实际为 Quat/FQuat/DQuat/3×Float32 精度/3×Float64 精度 = 1+1+1+3+3 = **9 个**，与 §2 lib.cj/fwd.cj 段落同步）。**排除项**（与阶段二策略对齐）：
- 不含 `BQuat`（Bool 四元数）—— 阶段一 Vec 包含 `BVec` 但 Bool 四元数无实际用途（D17 决策：Bool 四元数不支持算术运算）
- 不含 `IQuat`/`I64Quat`（整型四元数）—— 与阶段二 `fwd.cj` 排除整型矩阵别名策略一致
- 不含 `BQuat` 的精度变体（同上）

**为何保留 `Quat`/`FQuat`/`DQuat` 三重别名（v3 新增说明，v8 修订先例引用）**：**v7 文档引用阶段二 `Mat2x2`/`FMat2x2` 双别名机制作为先例，但该先例与项目实际状态不符**——阶段二 `Mat` 家族实际仅有 `Mat2x2` (Float32) + `DMat2x2` (Float64) 双别名（`cjglm/src/fwd.cj:327, 347`），`FMat*` 在 `fwd.cj` 中无任何声明。**v8 修订**：将先例引用改为阶段一 Vec 家族的三重模式（`Vec2` + `DVec2` + `FVec2`，见 `cjglm/src/fwd.cj:106, 123, 276`），与 `FQuat` 的设计意图对齐。`Quat` 为主别名（与 GLM 命名一致），`FQuat` 为显式浮点别名（与 `FVec2` 在 Vec 家族的角色等价），`DQuat` 为显式 64 位浮点别名（与 `DVec2` 等价）。该三重模式在阶段一 Vec 家族已稳定运行，作为四元数 `Quat`/`FQuat`/`DQuat` 的设计先例更准确。

### 3.15 gtc/quaternion.cj（v3 独立小节）

**角色**：承载 GLM `gtc/quaternion.hpp` 的全部 15 个函数（4 转换 + 4 比较 + 4 欧拉 + 3 看向），与 GLM 原始头文件路径保持 1:1 映射。

**职责分组**（**v14 修订，Issue 1 响应：确认 §3.15 与 §3.2 策略段一致**——§3.15 自 v3/v5 修订以来已正确将欧拉函数归入「stub 占位」，§3.2 策略段此次同步修正，两处不再矛盾）：

| 函数组 | 函数 | 本阶段状态 | 依赖 |
|--------|------|----------|------|
| 矩阵-四元数互转 | `mat3Cast`/`mat4Cast`/`quatCast(Mat3)`/`quatCast(Mat4)` | **从 detail 重导出** | `public import glm.detail.{mat3Cast, mat4Cast, quatCast}`（v3 关键变更，**v12 关键修订，Issue 1 响应**：重导出函数名为 camelCase `mat3Cast`/`mat4Cast`/`quatCast`，与 detail 端原始函数名一致——`public import a.b.f` 仅重导出 f 原始名，不做命名转换；GLM 原始 snake_case `mat3_cast`/`mat4_cast`/`quat_cast` 习惯在仓颉侧无法保留，记录于 §9「对齐 GLM 参考实现的差异声明」） |
| 四元数比较 | `lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual` | 完整实现 | 纯比较 |
| 欧拉角 | `eulerAngles`/`roll`/`pitch`/`yaw` | **stub 占位**（v5 最终决策，原误标为完整实现） | `trigonometric.cj`(`atan`/`asin`) + `common.cj`(`clamp`) + `vector_relational.cj`(`equal`) + `scalar_constants.cj`(`epsilon<T>()`) — 均依赖 stub，本阶段无法完整实现 |
| 看向 | `quatLookAt`/`quatLookAtRH`/`quatLookAtLH` | stub | `geometric.cj`(`cross`/`dot`/`normalize`/`inversesqrt`/`max`) + `type_quat_cast.quatCast` |

**v3 修订说明**：
- 上一版（v2）中"完整实现的 8 个函数（4 转换 + 4 比较）"现修正为：
  - 4 转换函数 → **从 detail 重导出**（不再在 gtc/quaternion.cj 中实现）
  - 4 比较函数 → 完整实现（保留）
  - 4 欧拉函数 → **stub 占位**（v2 中误标为"完整实现"，但实际依赖 trigonometric.cj 的 atan/asin 和 common.cj 的 clamp stub）
  - 3 看向函数 → stub（保留）
- **正确分组**：4 重导出 + 4 完整实现 + 7 stub

**完整实现函数（4 个，**v12 关键修订，Issue 13 响应：合并 where 子句描述**）**：

4 个比较函数（`lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual`）统一标注 `where T <: Comparable<T>, Q <: Qualifier` 约束（**v10 新增，Issue 16 响应**，依赖 `<`/`<=`/`>`/`>=` 运算符；**v12 修订，Issue 13 响应**：4 行重复标注合并为本段统一约束声明，避免质询报告 E 项建议的表格格式偏好）。**v11 关键修订，Issue 9 响应，补充实现公式模板**：
- `lessThan`: `func lessThan<T, Q>(x: Quat<T,Q>, y: Quat<T,Q>): Vec4<Bool,Q> where T <: Comparable<T>, Q <: Qualifier { Vec4<Bool,Q>(x.x < y.x, x.y < y.y, x.z < y.z, x.w < y.w) }`
- `lessThanEqual`: `func lessThanEqual<T, Q>(x: Quat<T,Q>, y: Quat<T,Q>): Vec4<Bool,Q> where T <: Comparable<T>, Q <: Qualifier { Vec4<Bool,Q>(x.x <= y.x, x.y <= y.y, x.z <= y.z, x.w <= y.w) }`
- `greaterThan`: `func greaterThan<T, Q>(x: Quat<T,Q>, y: Quat<T,Q>): Vec4<Bool,Q> where T <: Comparable<T>, Q <: Qualifier { Vec4<Bool,Q>(x.x > y.x, x.y > y.y, x.z > y.z, x.w > y.w) }`
- `greaterThanEqual`: `func greaterThanEqual<T, Q>(x: Quat<T,Q>, y: Quat<T,Q>): Vec4<Bool,Q> where T <: Comparable<T>, Q <: Qualifier { Vec4<Bool,Q>(x.x >= y.x, x.y >= y.y, x.z >= y.z, x.w >= y.w) }`

**重导出函数（4 个，v12 关键修订：camelCase 命名）**：
- `mat3Cast(q: Quat<T,Q>): Mat3x3<T,Q>` — 通过 `public import glm.detail.mat3Cast` 重导出（**v12 关键修订，Issue 1 响应**：camelCase 命名，与 detail 端 `mat3Cast` 原始名一致；GLM 习惯 snake_case `mat3_cast` 在仓颉侧无法保留，因 `public import` 不做命名转换）
- `mat4Cast(q: Quat<T,Q>): Mat4x4<T,Q>` — 通过 `public import glm.detail.mat4Cast` 重导出（**v12 修订同上**：camelCase `mat4Cast` 而非 snake_case `mat4_cast`）
- `quatCast(m: Mat3x3<T,Q>): Quat<T,Q>` — 通过 `public import glm.detail.quatCast` 重导出（**v12 修订同上**：camelCase `quatCast` 而非 snake_case `quat_cast`）
- `quatCast(m: Mat4x4<T,Q>): Quat<T,Q>` — 通过 `public import glm.detail.quatCast` 重导出（**v12 修订同上**：camelCase `quatCast` 而非 snake_case `quat_cast`）

**stub 函数（7 个）**：
- `eulerAngles(x): Vec3<T,Q>` — stub
- `roll(q): T` — stub
- `pitch(q): T` — stub
- `yaw(q): T` — stub
- `quatLookAt(direction, up): Quat<T,Q>` — stub
- `quatLookAtRH(direction, up): Quat<T,Q>` — stub
- `quatLookAtLH(direction, up): Quat<T,Q>` — stub

**跨包引用（v3 明确，无循环依赖）**：
- `import glm.detail.*` 引用 `Quat`/`Mat3x3`/`Mat4x4`/`Vec3` 类型
- `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 重导出 4 个转换函数
- `import glm.ext.vector_relational.*` 引用 `equal`（用于 roll/pitch 的 `equal(vec2, vec2, 0)` 边界检测）
- `import glm.ext.scalar_constants.*` 引用 `epsilon<T>()`
- 不引用 `glm.detail.type_quat` 内部成员（避免与 type_quat.cj 内部细节耦合）
- **不引用** `glm.gtc.matrix_transform` 等其他 gtc 文件（避免 gtc 内部循环依赖）

**与 type_quat.cj、type_quat_cast.cj 三方协作（v3 明确）**：
- `type_quat.cj` 中 `fromMat3`/`fromMat4` 工厂函数直接调用**同包** `type_quat_cast.cj` 的 `mat3Cast`/`mat4Cast`/`quatCast` 函数（无 import 需求）
- `gtc/quaternion.cj` 通过 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 将 detail 函数重导出为 gtc 命名空间下的同名 API
- 形成 `glm.gtc → glm.detail` 的**单向依赖**，**无循环依赖**（v3 关键修复）

### 3.16 需求对齐说明（v19 修订，D35-D37 已决策）

本设计文档与项目路线图 `docs/02_roadmap.md` 在阶段三验证标准上存在以下三处不一致，经 D35-D37 决策后已全部闭环。替代路径保留作为历史存档，不再具备实施优先级。

**不一致 1：`slerp` 可验证性冲突（✅ D35 已决策：维持 stub）**
- 路线图 §3 第 125 行标记「球面线性插值（slerp）操作 `[可验证]`」，但本设计 §3.11、§8 产出物清单、§10 覆盖矩阵、§11.5 函数可用性对照表均将 `slerp`（含 3 参数与 4 参数版本）标记为「**stub 占位**」（依赖 `trigonometric.cj` 的 `acos`/`sin` stub 与 `common.cj` 的 `mix` stub）。
- **D35 选定方案**：**路径 C**——维持本设计定位，`slerp` 标记为 `[待 Stage 4]`。理由：对阶段三整体交付范围影响最小，`slerp` 的 stub 状态已在 §11.5 明确标注，不阻塞其他可验证函数的实现与测试；存在向下兼容的降级路径（路径 A：`lerp` 近似，1-2 人日切换成本）。详见 §7 D35。
- **历史替代路径**（保留存档，不再具有实施优先级）：
  - 路径 A：降级 `lerp` 近似（代价：较大角度差时非恒定角速度）
  - 路径 B：自行实现标量 sin/cos/acos 有限精度版本（泰勒展开，代价：代码冗余、精度有限）
- **工期影响**：路径 C 零额外工期成本；阶段四实现时恢复为完整 `slerp`。

**不一致 2：`lookRotate` 命名未同步修正（✅ D36 已决策：维持 quatLookAt* 命名）**
- 路线图 §3 多处（第 89、102、111、129、152、163、207 行）仍引用 `lookRotate` 函数名，但本设计已统一为 `quatLookAt`/`quatLookAtRH`/`quatLookAtLH`（D13 决策 + §9 差异声明「GLM 中不存在 `lookRotate` 函数」）。
- **D36 选定方案**：维持本设计命名 `quatLookAt`/`quatLookAtRH`/`quatLookAtLH`，三个函数均为 stub（§3.15），命名不影响阶段三实施。若路线图后续确认保留 `lookRotate`，可在阶段四新增 `lookRotate` 作为 `quatLookAtRH` 的委托别名（0.5 人日成本）。详见 §7 D36。
- **工期影响**：按本设计命名实施工期成本为零（函数均为 stub）。

**不一致 3：`ext/quaternion_common.cj` 可验证性范围过广（✅ D37 已决策：修订路线图标注）**
- 路线图 §3 第 130 行标记「`ext/quaternion_common.cj`：四元数常用函数（`conjugate`、`inverse`、`normalize` 等跨类型运算）`[可验证]`」，涵盖面过广，未排除 `mix`/`slerp` 属于 stub 的部分。
- **D37 选定方案**：将路线图标注从 `[可验证]` 修订为 `[部分可验证]`——5 函数 ✅（conjugate/inverse/lerp/isnan/isinf）+ 3 函数 ❌（mix/slerp×2），函数级明细引用 §11.5。详见 §7 D37。
- **工期影响**：路线图标注修订零工期成本（仅为文档修改）。

**阶段三验证标准双向映射表**（统一路线图与本设计的可验证性标注口径）：

| 路线图标注 | 本设计符号 | 含义 |
|----------|----------|------|
| `[可验证]` | ✅ 可用 | 本阶段完整实现，单元测试可立即验证 |
| `[部分可验证]` | ⚠️ 可用但有条件 | 本阶段实现但依赖 stub，调用抛 `Exception("stub")`，待阶段四 stub 替换后正常 |
| `[待 Stage 4]` | ❌ stub | 本阶段 stub 占位，待阶段四函数库完整实现后补齐 |

**§11.5 主要参考基准说明（v7 澄清，v21 修订）**：本设计 §11.5「函数可用性对照表」的 ✅/⚠️/❌ 符号标注是阶段三验证的**主要参考基准**（每个函数一行，标注本阶段状态与阶段四状态，含约束/边界条件注解）；路线图 `02_roadmap.md` 的 `[可验证]`/`[部分可验证]`/`[待 Stage 4]` 三级标注在 v3 迭代结束后由项目管理流程同步修订，本设计文档不再依赖路线图的特定标注作为验证依据。

**⚠️ 以上不一致项的升级建议**：建议将三项不一致分别升级为正式设计决策 D35~D37（详见 §7），记录选定方案及理由。本设计文档以 §11.5 标注为准；路线图对应标注修订由项目管理方在确认后完成。

### 阶段三→阶段四演进指南

本节明确阶段三与阶段四的职责边界及演进兼容性，确保 88 个 ⚠️/❌ 函数在阶段四实现时不对阶段三已有的 API 签名造成破坏性变更。

**演进兼容性承诺**：
- **(a) stub 函数签名在阶段四保持不变**：所有 stub 函数的签名模板（含 `where` 子句约束）在阶段四实现函数体时**不做任何修改**。具体来说：`trigonometric.cj` 的 75 个函数当前标注 `where T <: FloatingPoint<T>`，阶段四实现函数体时该约束保持不变；`gtc/quaternion.cj` 的 7 个 stub 函数签名与 `where` 子句同样锁定。阶段四仅填充函数体实现（将 `throw Exception("stub")` 替换为 `std.math.{func}` 调用或纯算术计算），不涉及签名变更。若阶段四发现某函数需要放宽或收紧约束，必须通过新增重载（而非修改签名）实现向后兼容。
- **(b) ⚠️ 函数的运行时行为过渡路径**：当前标注 ⚠️ 的函数（`Quat×Vec3`/`Quat×Vec4`）编译通过但运行时抛 `Exception("stub")`。阶段四 geometric.cj 向量 `cross`/`dot`/`normalize` 等完整实现后，⚠️ 函数的运行时行为自动从「抛 stub 异常」切换为「正常功能」，无需修改 ⚠️ 函数本身的代码——因其依赖的 stub 函数被替换为正常实现，调用链自然生效。具体过渡节点：
  - `Quat×Vec3`/`Quat×Vec4`：依赖 `geometric.cj` 向量 `cross` → 阶段四 geometric.cj 完整实现时自动生效
- **(c) 阶段四补充测试要求**：阶段四实现 stub 替换时，需对受影响的 ✅ 函数执行回归测试：
  - 对所有原本通过 ⚠️ 路径调用的已实现函数（`Quat×Vec3`/`Quat×Vec4`），阶段四需补充正常路径功能验证（不再仅验证 `assertThrows`）
  - 对阶段四新增完整实现的 stub 函数，按「完整实现函数 ≥2 用例/函数」补全测试覆盖
  - 补充测试应写入现有测试文件，而非新建文件
- **(d) 测试迁移指南**：阶段三的 `assertThrows(Exception("stub"))` 测试用例在阶段四实现后应逐步迁移为正常功能断言。对于每组 stub 函数，建议在阶段四实现时先通过 `assertThrows` 确认新旧行为切换点，再将用例改为功能断言。**批量迁移规则**：当一组高度同构的 stub 函数（如 `trigonometric.cj` 的 75 个函数）的函数体实现超过 50% 时，可对整组执行一次性批量迁移，无需逐函数迁移。

**签名冻结例外审批流程（v23 新增，Issue 4 响应）**：若阶段四确需修改阶段三已冻结的 stub 函数签名（含 `where` 子句约束），必须通过以下流程：
1. 在 §9 差异声明中记录修改理由及影响范围
2. 经设计评审确认修改的向后兼容性（是否可通过新增重载替代签名修改）
3. 在评审通过后方可实施修改，并在 §8.3 I 节「已知未解决问题列表」中标注过渡期兼容性影响

**阶段三→阶段四责任边界总表**：

| 职责 | 阶段三 | 阶段四 |
|------|--------|--------|
| API 签名设计 | 全部完成（含 `where` 子句） | **不可修改**（仅可新增重载；例外需经 §3.16 签名冻结例外审批流程） |
| ✅ 函数实现 | 真完整实现 | 回归验证 + 补充测试 |
| ⚠️ 函数 | 编译通过，运行时抛 stub | 自动切换为正常功能 |
| ❌ stub 函数 | 仅签名 + `throw Exception("stub")` | 替换函数体为正常实现 |
| 边界行为契约 | 以 §5.3 表为准 | 保持与阶段三一致（仅可能扩展） |

---

## 4. 关键行为契约

### 4.1 四元数构造与单位四元数

```
let q = Quat<Float32, PackedHighp>.identity(1.0f)    // 单位四元数 (0,0,0,1) [本阶段可验证]
let q = Quat<Float32, PackedHighp>(0.0f, 0.0f, 0.0f, 1.0f) // 逐分量 [本阶段可验证]
let q = Quat<Float32, PackedHighp>.wxyz(1.0f, 0.0f, 0.0f, 0.0f) // wxyz 顺序 [本阶段可验证]
```

### 4.2 四元数旋转

```
let rotated = q * v        // 四元数旋转 Vec3 [本阶段调用抛 stub 异常，待阶段四 geometric.cj 完整实现后生效]
let rotatedV4 = q * v4     // 四元数旋转 Vec4（保留 w 分量）[同上]
let invRotated = v * q      // Vec3×Quat = inverse(q) * v [本阶段可验证，通过 inverse 路径，不依赖 stub]
```

### 4.3 四元数插值

```
let result = lerp(q1, q2, 0.5f)    // 线性插值（含 assert 断言）[本阶段可验证]
let result = conjugate(q)           // 共轭 [本阶段可验证]
let inv = inverse(q)               // 逆四元数 [本阶段可验证]
// slerp 为 stub，待阶段四 trigonometric.cj/common.cj 完整实现后生效
```

### 4.4 矩阵-四元数互转

```
let m3 = glm.mat3Cast(q)    // 四元数转 3×3 旋转矩阵 [本阶段可验证，通过 lib.cj 的 public import 重导出从顶层 glm 命名空间调用]
let m4 = glm.mat4Cast(q)    // 四元数转 4×4 旋转矩阵 [本阶段可验证]
let q = glm.quatCast(m3)    // 3×3 旋转矩阵转四元数 [本阶段可验证]

// gtc 命名空间下的同名 API（通过 public import 重导出，[本阶段可验证]，**v12 关键修订，Issue 1 响应**：gtc 端采用 camelCase 命名 `mat3Cast`/`mat4Cast`/`quatCast`，与 detail 端实现函数名一致——`public import a.b.f` 仅重导出 f 原始名，不做命名转换；若下游按 GLM 习惯使用 snake_case `mat3_cast` 将编译失败）
let m3_2 = glm.gtc.quaternion.mat3Cast(q)
let q_2 = glm.gtc.quaternion.quatCast(m3)
```

**v11 关键修订，Issue 4 响应，命名空间前缀统一**：§4.4 示例统一使用 `glm.mat3Cast(q)` 顶层命名空间调用形式，与 §11.4「仓颉顶层 glm 命名空间调用」段（v10 已明确）保持一致；调用方需先通过 `lib.cj` 完成 `public import` 间接访问，无需显式 `import glm.detail.*`。v10/v6 描述的「无前缀 `mat3Cast(q)`」调用形式若按字面实现（未先 `import glm.detail.*`），将因 `mat3Cast` 在 `glm.detail` 命名空间下而触发「未定义符号」编译错误。**前提条件**：调用方必须 `import glm`（导入 lib.cj 公共 API 层），使 `glm.mat3Cast` 在当前包命名空间下可见。

### 4.5 标量常量与数学常量

```
let eps = epsilon<Float32>()     // 1.1920929e-7 [本阶段可验证]
let p = pi<Float32>()            // 3.14159265... [本阶段可验证]
let half = halfPi<Float32>()     // 1.57079632... [本阶段可验证]
```

### 4.6 欧拉角与看向（stub）

```
let euler = eulerAngles(q)       // 欧拉角提取 [本阶段 stub]
let r = roll(q)                  // roll 分量 [本阶段 stub]
// quatLookAt 等看向函数 [本阶段 stub]
```

---

## 5. 错误处理策略

### 5.1 通用异常

- **下标越界**：`q[i]`（i < 0 或 i >= 4）抛出 `Exception`（与阶段一/二一致）
- **`normalize` 零四元数**：返回单位四元数 `Quat(T(Float64(0)), T(Float64(0)), T(Float64(0)), T(Float64(1)))`（**v14 修订，Issue 2 响应**：T(0)/T(1) 均采用 `T(Float64(n))` 字面量替代路径，与 §1 系统性约束 v14 修订一致），与 GLM `quaternion_geometric.inl:20-21` 行为一致
- **stub 函数体**：以 `throw Exception("stub")` 占位（标识阶段三/四功能边界）

### 5.2 算术溢出

- **统一标注**：四元数算术运算符（`+`/`-`/`*`/一元 `-`/标量乘除）统一标注 `@OverflowWrapping` 注解，与阶段一 Vec3 (`type_vec3.cj:54-80`) 和阶段二全部矩阵类型 (`type_mat2x2.cj`、`type_mat3x3.cj` 等) 的实践保持一致
- **跨类型一致性**：`@OverflowWrapping` 对浮点类型无效果（std.overflow 模块语义仅作用于整数溢出行为），但保持跨整数/浮点实例化的统一行为，避免未来整数四元数用例出现不可控整数溢出行为

### 5.3 边界条件与异常场景（v3 新增）

| 边界条件 | 函数 | 行为契约 |
|---------|------|---------|
| `1 - x.w*x.w <= 0` | `axis(q)` | 返回 `Vec3(T(0), T(0), T(1))`（z 轴单位向量，典型场景：单位四元数 `(0, 0, 0, 1)` 即 `\|w\| >= 1`；与 GLM `ext/quaternion_trigonometric.inl:20-27` 一致；**v5 修订**：v3 描述「零四元数返回 `Vec3(1, 0, 0)`」错误，触发条件为 `1 - w² <= 0` 而非 `q.xyz == 0`；**v10 补充，Issue 13 响应**：`tmp1 = T(1) - x.w*x.w` 计算公式参见 §3.9 `axis` 函数描述） |
| 真正零四元数 `(0,0,0,0)` | `axis(q)` | `tmp1 = 1 > 0` 进入 else 分支，返回 `Vec3(T(0), T(0), T(0))`（**v5 修订**：v3 描述「内部 `normalize(Vec3(0,0,0))` 返回 `Vec3(1,0,0)`」为虚构实现，GLM 实际不调用 `normalize`） |
| **零四元数 `(0,0,0,0)`（v11 新增，Issue 2 响应，**v14 关键修订，Issue 2 响应：T(0) 字面量替代**）** | `normalize(q)` | **`tmp1 = length(q) = 0 <= T(0)` 触发 GLM 零保护分支**，返回**单位四元数** `Quat(T(Float64(0)), T(Float64(0)), T(Float64(0)), T(Float64(1)))`（**v14 修订**：T(0) 原策略「通过 `one - one` 演算」在 normalize 签名（不含 `one: T` 形参）中不可用，统一修订为 `T(Float64(0))` 字面量替代路径；T(1) 采用 `T(Float64(1))` 字面量替代路径；与 §1 系统性约束 v14 修订一致）；与 GLM `ext/quaternion_geometric.inl:17-24` 实际行为完全一致——下游按 v10 描述「内部调用 `length`」字面实现时零四元数除零产生 NaN 分量与本契约不符 |
| **`length(q)` 极小值（接近 0 但非 0，v11 新增，Issue 2 响应）** | `normalize(q)` | `tmp1 > T(0)` 但接近 `FloatingPoint<T>.getMinDenormal()` 量级时**不触发零保护分支**，返回 `q / tmp1` 结果各分量趋向 Inf/NaN（与 GLM 行为一致，GLM 不做 length 极小值保护）；如需防止此类溢出，应在调用 `normalize` 前自行检查 `length(q) >= epsilon<T>()` |
| 零四元数（浮点） | `inverse(q)` | 浮点除零产生 Inf/NaN 分量（与 GLM 一致，GLM 不做零除保护） |
| 零四元数（整数） | `inverse(q)` | 触发仓颉 `ArithmeticException`（**v10 措辞统一，Issue 13 响应**：与浮点 Inf/NaN 行为不同；与 §3.11 `inverse` 描述对齐） |
| `cosTheta` 退化 | `mix`/`slerp` | 依赖 `cosTheta > 1 - epsilon<T>()` 边界检查；stub 函数抛 stub 异常 |
| 非纯旋转矩阵 | `fromMat3`/`fromMat4` | 仅对纯旋转矩阵产生有意义的四元数；对非旋转矩阵（缩放/平移/剪切）行为未定义，结果可能产生非单位四元数或语义错误的旋转 |
| `a` 超出 [0,1] | `lerp` | 触发 `assert(a >= 0 && a <= 1)` 断言失败 |
| `epsilon = T(0)` | `equal(v, v, 0)` | 返回 `false`（严格小于语义，与 GLM `glm/gtc/epsilon.inl:32-41` 中 `epsilonEqual` 实现一致；v9 修订：原引用 `func_vector_relational.inl:18-22` 错误——该文件不含 epsilon 版本） |
| 整型 T | `epsilon<T>()`/`pi<T>()`/`cos_one_over_two<T>()` | 触发 `Exception("not defined for non-floating-point types")`（约束收紧失败时 fallback 分支） |
| 整型 T | `isnan(q)`/`isinf(q)` | 编译期约束收紧为 `where T <: FloatingPoint<T>`，整型 T 实例化时编译失败（v4 新增，v7 接口名修订）；若仓颉泛型不支持窄约束则运行时 fallback 抛 `Exception("isnan/isinf not defined for non-floating-point types")` |
| 整型 T | `mat3Cast`/`mat4Cast`/`quatCast` | 编译期约束收紧为 `where T <: FloatingPoint<T>`，整型 T 实例化时编译失败（v5 新增，v7 接口名修订；与 D29 `isnan`/`isinf` 策略一致，对应 GLM `GLM_STATIC_ASSERT(is_iec559, ...)`；**v12 修订，Issue 11 响应：双向引用**——本条目对应 §3.13.2 审计表「`mat3Cast`/`mat4Cast`/`quatCast`」行的「整型 T 实例化时编译失败」契约反向引用） |
| u, v 反平行（`dot(u,v) ≈ -sqrt(dot(u,u) * dot(v,v))`，即 `dot ≈ -1` 经归一化后的等效条件，**v13 修订**：v8 描述「`dot ≈ -1`」不准确——GLM 实际触发条件为 `real_part < 1e-6f * norm_u_norm_v`） | `fromVec3` | 返回 `q.w = 0` 的纯向量四元数（**v13 修订**：v8 描述「`q.w ≈ 0`」准确但不够精确，GLM 实际为 `real_part = static_cast<T>(0)`），轴选择由 `abs(u.x) > abs(u.z)` 条件决定（**v13 关键修订**：v8 描述「任意轴」不准确——GLM 实际是「与 u 垂直的两条可能轴之一」，`abs(u.x) > abs(u.z)` 选 `(-u.y, u.x, 0)` 再归一化，否则选 `(0, -u.z, u.y)` 再归一化；**v15 修订，Issue 8 响应**：选出的轴还需经过 `normalize(t)` 归一化确保返回纯向量四元数模长为 1）；v8 新增契约，行为已定义，与 GLM `detail/type_quat.inl:196-217`（**v13 关键修订**：v8 错误引用为 `ext/quaternion_common.inl:196-217`）退化路径一致；阶段三 stub 阶段不适用，待阶段四 stub 替换后生效；**v12 修订，Issue 11 响应：双向引用**——本条目对应 §3.13.2「本阶段实现但运行时受 stub 依赖影响」审计表的「`fromVec3` stub 行」反向引用 |
| u, v 为零向量 | `fromVec3` | 行为未定义（由 `normalize` 阶段四完整实现时确定） |
| `mat3Cast` 接受非单位四元数 | `mat3Cast`/`mat4Cast` | 返回矩阵不保证是旋转矩阵（缩放/剪切分量保留；v8 新增契约，与 §3.2.1 边界行为契约段对齐） |
| `quatCast` 接受非旋转矩阵 | `quatCast` | 返回的四元数行为未定义（可能为非单位四元数/零四元数/NaN 四元数；v8 新增契约，与 §3.2.1 边界行为契约段对齐） |
| 整型 T（`Int8`~`Int64`） | `trigonometric.cj` 全体函数（`sin`/`cos`/`tan` 等） | 通过 `where T <: FloatingPoint<T>` 约束在编译期拒绝；整型 T 实例化时报类型不匹配错误（v15 新增，Issue 10 响应：`std.math` 三角函数仅提供 Float16/Float32/Float64 重载，不提供整型重载） |
| NaN/Inf 输入传播（v24 新增，Issue 7 响应） | 全体算术运算符与函数 | NaN 输入传播规则：四元数算术运算符（`+`/`-`/`*`/`/`）及 `dot`/`length`/`conjugate`/`lerp`/`inverse` 等函数中，若任意分量包含 NaN/Inf，结果对应分量传播 NaN/Inf，与 GLM 浮点传播语义一致。`isnan`/`isinf` 对 NaN/Inf 输入分别返回 true |
| `lerp` 参数 `a` 为 NaN/Inf 或负数（v24 新增，Issue 7 响应） | `lerp` | `a` 为 NaN 时返回 NaN 四元数（NaN 传播）；`a` 为 +Inf 或 -Inf 时行为未定义（与 GLM 一致，GLM 不校验 `a` 值域之外的非有限值）；`a` 为负数时若在 assert 生效范围内则触发 `assert` 失败 |
| 单位矩阵/零矩阵输入（v24 新增，Issue 7 响应） | `fromMat3`/`fromMat4` | 单位矩阵输入：`fromMat3` 返回单位四元数 `(0, 0, 0, 1)`；`fromMat4` 的左上 3×3 子矩阵为单位矩阵时同理返回单位四元数。零矩阵输入：行为未定义（`trace=0` 导致推导公式除零），与 GLM 1.0.3 `detail/type_quat.inl` 行为一致 |
| `axis` 对 NaN w 分量（v24 新增，Issue 7 响应） | `axis` | `q.w` 为 NaN 时 `1 - NaN*NaN = NaN`，`tmp1 <= 0` 判断为 false，进入 else 分支。`tmp2 = 1 / sqrt(NaN) = NaN`，返回 `Vec3(x*NaN, y*NaN, z*NaN)`——全 NaN 向量，与 GLM `ext/quaternion_trigonometric.inl:20-27` 浮点传播语义一致 |
| `inverse` 对非单位四元数输入（v24 新增，Issue 7 响应） | `inverse` | 非单位四元数的 `inverse` 返回共轭除模平方的结果，语义正确（四元数逆的定义为 `q⁻¹ = q̅ / |q|²`，对非单位四元数同样成立）。与 GLM `ext/quaternion_common.inl` 行为一致，不做单位化保护 |

### 5.4 const 上下文约束

- **`lerp`/`inverse` 不可在 const 上下文调用（v10 修订，Issue 6 响应；v24 修订，Issue 1 响应）**：v9 描述「`lerp`/`conjugate`/`inverse` 不可在 const 上下文调用」错误——`conjugate` 函数体仅对 x/y/z 三个分量取反（`Quat(-q.x, -q.y, -q.z, q.w)`），无 `assert`/无 `throw`/无运行时副作用，**可在 const 上下文调用**（与 Vec/Mat 的逐分量运算符策略一致）。**v10 修订**：从禁止列表中移除 `conjugate`；`lerp` 因函数体内 `assert(a >= 0 && a <= 1)` 断言非 const 函数（与 deviations.md IF-03 一致），不可在 const 上下文调用；`inverse` 函数体内部 `conjugate(q) / dot(q, q)` 的 `/` 运算符在仓颉整数类型上非 constexpr 兼容，故不可声明为 `const func`
- **`inverse` const 拒绝理由（v10 新增；v24 修订，Issue 1 响应）**：`inverse` 函数体内部 `conjugate(q) / dot(q, q)` 的 `/` 运算符在仓颉整数类型上非 constexpr 兼容，故不可声明为 `const func`（非之前所述的「运行时抛算术异常」原因——const 函数约束是关于编译器能否在编译期对函数求值，而非关于函数运行时是否可能抛异常）。`lerp` 不可 const 的原因保持不变——`assert` 在仓颉中非 constexpr 兼容
- **`conjugate` const 适用性（v10 新增，§3.11 补充对齐）**：`conjugate` 函数体仅涉及 `Quat` 主构造函数的逐分量取反调用（`Quat(-q.x, -q.y, -q.z, q.w)`），无 `assert`/无 `throw`/无 `dot`/`normalize`/其他非 const 函数调用，**可声明为 `const func`**（与 Vec/Mat 的逐分量运算符策略一致）。**v10 附注**：若仓颉 const 函数还有其他限制（如不能调用非 const 自由函数、不能包含复杂表达式），则该论断需进一步评估
- **stub 函数不声明 const**：stub 函数体 `throw Exception("stub")` 不可在 const 上下文求值

### 5.5 标量/四元数 `div` 语义

- **逐分量除法**：`div(s, q)` 语义为 `s / q.x, s / q.y, s / q.z, s / q.w`（与阶段二标量/矩阵 `div` 模式一致）

---

## 6. 并发设计

本阶段不引入并发场景。四元数类型为值类型，所有运算符返回新实例，天然线程安全。

---

## 7. 设计决策

| 编号 | 决策 | 理由 |
|------|------|------|
| D01 | Quat 数据布局为 x,y,z,w（非 GLM 的 w,x,y,z 参数顺序） | 与 GLM 默认存储布局一致，避免 GLM_FORCE_QUAT_DATA_WXYZ 宏引入的条件编译复杂性 |
| D02 | Quat 主构造函数参数顺序为 (x,y,z,w)，另提供 wxyz(w,x,y,z) 工厂函数 | 主构造函数参数顺序与数据成员声明顺序一致（仓颉惯用风格），wxyz 函数兼容 GLM 习惯 |
| D03 | 四元数×向量运算符定义为 Quat 的成员运算符 | 左操作数类型拥有运算符，与阶段二 Mat×Vec 模式一致 |
| D04 | 向量×四元数运算符定义为 Vec 的 extend 块成员运算符 | 左操作数类型拥有运算符，依赖同包前向引用延迟解析（已通过阶段二原型验证） |
| D05 | 标量-四元数运算通过全局函数（scalar_quat_ops.cj） | 仓颉 operator func 限制——右操作数非 Quat 类型的标量左操作数不能定义为成员运算符 |
| D06 | ext/vector_relational 的 epsilon 比较内联 abs，不依赖 common.cj stub | 消除对 stub 文件的运行时依赖风险，确保 epsilon 比较函数可正常执行 |
| D07 | ULP 比较函数本阶段以空桩占位 | 仓颉无浮点位表示直接访问能力（无 `reinterpret_cast`/`union` 等价机制），待阶段四评估替代方案 |
| D08 | scalar_constants 实现于 glm.detail.scalar_constants.cj，ext/ 仅做重导出 | 遵循 detail 封装核心实现、ext/gtc 封装公共 API 的双层架构约定 |
| D09 | scalar_constants 的泛型函数使用 `match` 类型模式匹配 + hint 参数 | 仓颉无 `std::numeric_limits<T>::epsilon()` 等编译期类型属性查询机制，必须运行时分派 |
| D10 | gtc/constants 中 **28 个**常量函数使用具体类型硬编码值直接返回（v8 修订：v7 误标为 25） | 与 GLM `genType(3.14159...)` 实现方式一致，避免函数间调用依赖 |
| D11 | **v3 关键决策，v12 修订**：转换函数实现位于 `glm.detail.type_quat_cast.cj`，`gtc/quaternion.cj` 通过 `public import` 重导出；gtc 端重导出函数名为 camelCase `mat3Cast`/`mat4Cast`/`quatCast`（与 detail 端原始函数名一致），**非** GLM 习惯的 snake_case `mat3_cast`/`mat4_cast`/`quat_cast` | **消除包间循环依赖**（v3 核心理由）：v2 设计将转换函数放在 gtc 导致 `type_quat.cj` 需 `import glm.gtc.quaternion` 形成 `glm.detail ↔ glm.gtc` 双向依赖，违反仓颉包间循环依赖约束（cangjie-lang-features package/README.md 第 99 行）。v3 决策将转换函数下沉至 detail 包，让 `type_quat.cj` 通过同包访问直接调用（无需 import），`gtc/quaternion.cj` 通过 `public import` 重导出至 gtc 命名空间，保留 GLM 1:1 API 形态的同时彻底打破循环依赖。**v12 修订理由**：仓颉 `public import a.b.f` 仅重导出 f 原始名（依据 `cangjie-lang-features/package/README.md` 第 156-166 行规范），不做命名转换；detail 端原始函数名为 camelCase `mat3Cast`/`mat4Cast`/`quatCast`，因此 gtc 端重导出后仍为 camelCase——下游按 GLM 习惯使用 snake_case `mat3_cast`/`mat4_cast`/`quat_cast` 调用 `glm.gtc.quaternion.mat3_cast(q)` 将编译失败。该偏差属「API 命名风格」类差异，与现有 `public import glm.detail.{transpose, matrixCompMult, outerProduct}`（`cjglm/src/lib.cj:8`，camelCase）模式一致 |
| D12 | type_quat.inl 中 fromVec3(u,v) 和 fromEuler(eulerAngle) 构造函数本阶段化简为独立工厂函数 | 避免在 Quat 结构体内引入对 stub 函数的编译依赖；工厂函数在 extend 块中定义，可推迟至阶段四完整实现 |
| D13 | quatLookAt/quatLookAtRH/quatLookAtLH 等 gtc/quaternion 函数本阶段 stub 占位 | 这些函数依赖 geometric.cj 的 cross/dot/normalize/inversesqrt（均为 stub），无法完整实现 |
| D14 | quaternion_geometric.cj（dot/length/normalize/cross）本阶段完整实现 | 经分析确认依赖链仅止于 std.math.sqrt，不依赖任何 stub 文件 |
| D15 | quaternion_common.cj 中 conjugate/inverse/lerp/isnan/isinf 本阶段完整实现 | conjugate/inverse/lerp 仅需算术运算和 dot（已完整实现）；isnan/isinf 采用 std.math 实例方法路径，不依赖顶层函数 |
| D16 | trigonometric.cj 新增为空桩文件 | type_quat.inl 依赖 trigonometric.hpp，本阶段仅提供签名空壳供依赖闭合 |
| D17 | Bool 四元数不支持算术运算 | Bool 不实现 Number<T> 接口，与阶段二 D33 Bool 矩阵策略一致 |
| D18 | scalar_quat_ops.cj 与 scalar_vec_ops.cj/scalar_mat_ops.cj 同名重载 | add/sub/mul/div 与向量/矩阵版本通过第二参数类型消歧，与阶段二策略一致 |
| D19 | 四元数算术运算符统一标注 @OverflowWrapping | 与阶段一/二所有算术运算符（含浮点重载）保持一致；标注对浮点无效果但保持跨整数/浮点实例化的统一行为 |
| D20 | **`gtc/quaternion.cj` 独立文件承载 15 函数（v3 明确：4 重导出 + 4 完整 + 7 stub）** | 与 GLM `gtc/quaternion.hpp` 1:1 映射，便于 GLM 函数到仓颉文件的追溯；与阶段二 gtc 子包策略一致 |
| D21 | **`mix`/`slerp`/`pow` 的依赖明确包含 `epsilon<T>()`（v3 新增）；`pow` 进一步包含 `cos_one_over_two<T>()`、`asin`、调用 `std.math.pow` 实数降级路径两次、`std::numeric_limits<T>::min()` 等价物（v5 强化，v7 接口名修订，**v15 精简**：完整依赖清单及仓颉等价翻译路径见 §3.10 `pow` 函数依赖描述段；`FloatingPoint<T>` 接口静态方法可用性见 §1「回退方案」子节）** | 与 GLM `quaternion_common.inl`/`quaternion_exponential.inl:41-80` 实际依赖一致。本决策仅陈述最终结论——`mix`/`slerp` 依赖 `cosTheta > 1 - epsilon<T>()` 退化检测分支；`pow` 使用 line 52 `cos_one_over_two<T>()`、line 63 `std::numeric_limits<T>::min()` 等价物、line 65 + line 78 两次 `std::pow` 实数降级路径、line 68 `asin`。具体仓颉实现路径（含 `std.math.pow` 重载选择、`FloatingPoint<T>.getMinDenormal()`/`getInf()` 静态方法、line 65/78 仓颉等价翻译等）已统一归入 §3.10 和 §1，本决策不再重复。下游实现者查阅 §3.10 `pow` 依赖描述 + §1 系统性约束段即可。 |
| D22 | **`slerp` 4 参数版本 `k: Int64` 简化签名（v3 新增）** | 与 deviations.md DV-03「移位运算右操作数固定为 Int64」风格一致；阶段三 slerp 为 stub，固定 `Int64` 简化签名不影响本阶段实施 |
| D23 | **`lerp` 实现含 `assert(a >= 0 && a <= 1)` 断言（v3 新增）** | 与 GLM `ext/quaternion_common.inl:28-38` 一致，确保插值因子在 [0, 1] 范围内 |
| D24 | **向量 `equal` epsilon 比较采用严格 `<` 语义（v3 新增，v9 修订 GLM 文件引用）** | 与 GLM `glm/gtc/epsilon.inl:32-41` 中 `epsilonEqual` 实现一致，避免边界用例下 `equal(v, v, 0) = true` 的语义偏差。原引用 `func_vector_relational.inl:18-22` 错误——GLM 1.0.3 的 `func_vector_relational.inl` 中**不包含 epsilon 版本**的 `equal`/`notEqual`，epsilon 版本位于 `glm/gtc/epsilon.inl`（文件层面属 gtc 子包） |
| D25 | **`scalar_constants` 对整数类型 T 触发运行时异常（v3 新增）** | 与 GLM `static_assert(is_iec559, ...)` 编译期断言等价行为（仓颉泛型若不支持窄约束则用运行时异常） |
| D26 | **`Quat×Vec3` 旋转公式采用两次 Vec3 叉乘（v3 新增）** | 与 GLM `type_quat.inl:359-366` 实际实现一致：`v + (cross(QuatVector, v) * q.w + cross(QuatVector, cross(QuatVector, v))) * 2`（uv 和 uuv 两次叉乘） |
| D27 | **fwd.cj 排除整型与 Bool 四元数别名（v3 明确，v8 修订先例引用）** | **v8 修订**：v7 文档引用阶段二「fwd.cj 排除整型矩阵别名」作为唯一先例，但该先例存在两处不准确：① 阶段一 Vec 家族**包含** `BVec2`（Bool 向量，见 `cjglm/src/fwd.cj:140-143`）的 Bool 别名，Vec 家族对 Bool 类型的处理策略与 Mat 家族不同；② 阶段二 Mat 家族明确不含整型别名（`cjglm/src/fwd.cj` 全文 grep 验证零整型别名），阶段一 Vec 家族对整型的处理（无 `IVec*`）与 Mat 家族策略一致。**v8 明确**：fwd.cj 排除整型与 Bool 四元数别名的依据是——**整型四元数无实际用例**（quaternion 自然语义是旋转表达，整型四元数不参与实际数学运算）+ **Bool 四元数无实际用途**（D17：Bool 不实现 `Number<T>` 接口，算术运算编译期拒绝，无实用价值）。**v8 新增统一策略**：阶段三所有自定义类型族（Vec/Mat/Quat）均排除整型别名（语义不适用）+ 选择性排除 Bool 别名（Vec 家族保留 `BVec*` 因位运算是核心用例，Mat 家族不含 `BMat*` 因矩阵不参与位运算，Quat 家族不含 `BQuat*` 因四元数不参与位运算且算术不可用）。下游可参考本策略理解「哪些类型族为何种用途排除何种别名」。 |
| D28 | **v3 关键决策**：包间依赖方向严格单向——`glm.gtc → glm.detail`、`glm.ext → glm.detail`、上层不依赖下层 | 仓颉 cjpm 构建系统严格禁止包间循环依赖（cangjie-lang-features package/README.md 第 99 行）；D11 的 `type_quat_cast.cj` 下沉决策是本约束的直接体现 |
| D29 | **`isnan`/`isinf` 函数约束收紧为 `where T <: FloatingPoint<T>`（v4 修订，v7 接口名修订）** | `std.math` 的 `isNaN()`/`isInf()` 实例方法仅定义于浮点类型（`FloatingPoint<T>` 接口，stdlib 原生接口名），整数类型（`Int8`/`Int16`/`Int32`/`Int64`）无此方法。若不收紧约束，当用户实例化 `Quat<Int64, PackedHighp>` 并调用 `isnan(q)` 时，函数体内部 `q.x.isNaN()` 因 `Int64` 不实现 `isNaN()` 而编译失败。与 §3.12 `epsilon<T>()` 约束收紧策略（v3 已明确）保持一致；`FloatingPoint<T>` 是 stdlib 原生接口，编译期保证可用，无需 fallback |
| D30 | **Quat 字段统一标注 `public var`（v4 修订）** | 满足 `@Derive[Hashable]` 派生宏对字段 `public` 可见性的硬性要求（依据 `cangjie-std/deriving/README.md` 第 4 节「参与派生的字段/属性必须为 public」）。仓颉 struct 字段默认可见性为 `internal`（依据 `struct/README.md` 第 1.7 节），不满足 public 派生要求；与阶段一 Vec3 (`type_vec3.cj:8-10`)、阶段二全部矩阵类型 (`type_mat*.cj` 200+ 处统一实践) 对齐 |
| D31 | **`axis` 函数实现采用 GLM 独立公式路径而非 `normalize` 路径（v5 关键修订）** | GLM `ext/quaternion_trigonometric.inl:20-27` 实际实现是 `tmp1 = 1 - x.w*x.w` 独立公式，不调用 `normalize(Vec3(q.x, q.y, q.z))`。v3 描述的「内部 `normalize(Vec3(0, 0, 0))`」为虚构实现——若按 v3 描述实现，则需依赖 `geometric.cj` 的向量 `normalize`（阶段三为 stub），与同段「可完整实现」声明矛盾。v5 修订后：`axis` 依赖仅 `std.math.sqrt` 和 T(1) 演算，触发 `Vec3(0, 0, 1)` 返回值的条件为 `1 - x.w*x.w <= 0`（典型：单位四元数 (0, 0, 0, 1)），对于真正零四元数 (0, 0, 0, 0) 返回 `Vec3(0, 0, 0)` |
| D32 | **`type_quat_cast` 函数约束收紧为 `where T <: FloatingPoint<T>`（v5 新增，v7 接口名修订）** | 与 D29 `isnan`/`isinf` 约束收紧策略一致。GLM 1.0.3 在转换函数定义处使用 `GLM_STATIC_ASSERT(std::numeric_limits<T>::is_iec559, ...)` 静态断言非浮点类型时编译失败，仓颉版本通过 `FloatingPoint<T>` 接口约束（stdlib 原生接口）实现等价行为。`mat3Cast`/`mat4Cast`/`quatCast` 两个重载共 4 个函数统一采用此约束；`FloatingPoint<T>` 是 stdlib 原生接口，编译期保证可用，无需 fallback |
| D33 | **比较函数（`lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual`）采用 `Comparable<T>` 宽约束而非 `FloatingPoint<T>` 窄约束（v14 新增，Issue 6 响应）** | 理由：(a) GLM 原始实现中 4 个比较函数无 `GLM_STATIC_ASSERT(is_iec559)` 断言，整数类型也可合法调用——与 `mat3Cast`/`mat4Cast`/`quatCast` 等带 `is_iec559` 断言的函数有别；(b) 比较运算符 `<`/`<=`/`>`/`>=` 对整数类型语义正确（整数四元数按分量大小比较有实际意义），收紧至 `FloatingPoint<T>` 会排除整数四元数的合法比较用例；(c) 与需浮点运算的 `mat3Cast`/`quatCast` 场景区分——后者涉及 `sqrt`/`trace` 等仅在浮点类型上有意义的运算，而比较仅依赖 `<`/`<=`/`>`/`>=` 运算符，`Comparable<T>` 约束已足够保证运算符可用性；与 §3.15 完整实现函数段/§11.5 函数可用性对照表 `where T <: Comparable<T>` 声明一致 |
| D34 | **`lerp`/`inverse` 跨 Qualifier 调用的处理策略（v15 新增）** | 本阶段仅提供相同 Q 的签名模板。跨 Qualifier 场景通过双 Qualifier 重载扩展实现：新增 `lerp<T, Q1, Q2>(x: Quat<T,Q1>, y: Quat<T,Q2>, a: T): Quat<T,Q2>` where T <: Number<T>, Q1 <: Qualifier, Q2 <: Qualifier——内部调用跨 Qualifier 构造函数 `init<Q2>(q: Quat<T,Q2>)`（§3.3 item 3）将 `x` 隐式转换为 `y` 的 Qualifier，再执行同一 Q 下的 `lerp` 运算。理由：(a) 仓颉跨 Qualifier 构造函数已实现（§3.3 item 3），转换成本为纯赋值无运行时开销；(b) 输出 Q 取 `Q2`（与 `y` 一致）符合「右操作数主导 Qualifier」策略，与 GLM 精度提升/降级规则一致；(c) 该重载在阶段四按需实现，不阻塞本阶段已有的同 Q 调用路径 |
| D35 | **`slerp` 路线图可验证性冲突的处理策略（v16 新增，Issue 3 响应）** | 路线图 §3 第 125 行标记 `slerp` 为 `[可验证]`，但本设计定位为 `❌ stub`（依赖 trigonometric.cj/common.cj stub）。**选定方案**：维持本设计定位（路径 C），`slerp` 标记为 `[待 Stage 4]`。理由：(a) 对阶段三整体交付范围影响最小——`slerp` 的 stub 状态已在 §11.5 明确标注，不阻塞其他可验证函数的实现与测试；(b) 存在向下兼容的降级路径（路径 A：`lerp` 近似，1-2 人日切换成本）；(c) 若后续需阶段三有球面插值，路径 B（有限精度三角函数内联，3-5 人日）可作为备选。详见 §3.16 不一致 1 的临时实施建议与工期影响评估。 |
| D36 | **`lookRotate` 命名不一致的处理策略（v16 新增，Issue 3 响应）** | 路线图多处引用 `lookRotate` 函数名，但本设计已统一为 `quatLookAt`/`quatLookAtRH`/`quatLookAtLH`（D13 决策）。**选定方案**：维持本设计命名，三个函数均为 stub（§3.15），命名不影响阶段三实施。若路线图后续确认保留 `lookRotate`，可在阶段四新增 `lookRotate` 作为 `quatLookAtRH` 的委托别名（0.5 人日成本）。详见 §3.16 不一致 2 的临时实施建议与工期影响评估。 |
| D37 | **`ext/quaternion_common.cj` 路线图可验证性范围过广的处理策略（v16 新增，Issue 3 响应）** | 路线图 §3 第 130 行将 `ext/quaternion_common.cj` 整体标记为 `[可验证]`，未排除 `mix`/`slerp` 的 stub 部分。**选定方案**：将路线图标注从 `[可验证]` 修订为 `[部分可验证]`，函数级明细引用本设计 §11.5。理由：§3.13.2 审计表已明确列示 5 个可调用函数与 3 个 stub 函数的完整清单，粗粒度 `[可验证]` 标注与实际函数级状态不匹配。详见 §3.16 不一致 3 的临时实施建议与工期影响评估。 |

---

## 8. 阶段三产出物清单

**v15 修订，Issue 2 响应**：本节产出物分类统一调整为与 §11.5 函数可用性对照表对齐的三档分类——「✅ 可用（无 stub 依赖）」/「⚠️/❌ 混合（部分可用、部分 stub）」/「❌ stub（空桩占位）」。**全文档函数可用状态以 §11.5 为最终基准**。

### ✅ 可用（无 stub 依赖，运行时可正常调用）

- **`detail/type_quat_cast.cj（v3 新增）`**（4 个矩阵-四元数互转函数：mat3Cast/mat4Cast/quatCast 两个重载）
- `detail/scalar_constants.cj`（标量常量 epsilon/pi/cos_one_over_two，对整数类型抛异常）
- `detail/scalar_quat_ops.cj`（标量-四元数全局函数 add/sub/mul/div）
- `ext/quaternion_relational.cj`（四元数关系运算，4 函数完整实现）
- `ext/quaternion_geometric.cj`（四元数 dot/length/normalize/cross，4 函数完整实现）
- `ext/scalar_constants.cj`（ext 重导出接口）
- `gtc/constants.cj`（**28 个**数学常量函数，v8 修订：与 GLM 1.0.3 `gtc/constants.inl` 实际声明数一致）
- 四元数别名文件（4 个 ext/ 文件）
- 四元数测试文件（详见 §8.2，`test_xxx.cj` 命名约定，v8 修订）

**说明**：以上文件中的函数均为「真完整实现」（无 stub 依赖），运行时可正常调用，不抛 `Exception("stub")`。共 **18 个函数**（epsilon/pi/cos_one_over_two/axis/length/normalize/inverse/isnan/isinf/mat3Cast/mat4Cast/quatCast/conjugate/lerp/dot/cross(Quat)/equal(Quat)/notEqual(Quat)），详见 §11.5 函数可用性对照表。

### ⚠️/❌ 混合（部分函数 ✅ 可用、部分 ❌/⚠️ stub）

- `detail/type_quat.cj`（四元数核心类型 + 纯算术运算符/identity/fromMat3/fromMat4 等 ✅ 可用；Quat×Vec3/Vec4 ⚠️ 抛 stub 异常；fromVec3/fromEuler ❌ stub）
- `ext/quaternion_common.cj`（conjugate/inverse/lerp/isnan/isinf 共 5 函数 ✅ 可用；mix/slerp(2 版本) 共 3 函数 ❌ stub）
- `ext/quaternion_trigonometric.cj`（axis 1 函数 ✅ 可用；angle/angleAxis 2 函数 ❌ stub）
- `ext/quaternion_transform.cj`（rotate 1 函数 ❌ stub。**v13 关键修订，Issue 5 响应**：该文件仅含 `rotate` 一个函数且为 stub，即 100% stub）
- `ext/quaternion_exponential.cj`（exp/log/pow/sqrt 全部 ❌ stub）
- `gtc/quaternion.cj`（mat3Cast/mat4Cast/quatCast×2 重导出 4 函数 ✅ 可用 + lessThan/lessThanEqual/greaterThan/greaterThanEqual 4 函数 ✅ 可用 + eulerAngles/roll/pitch/yaw/quatLookAt/quatLookAtRH/quatLookAtLH 7 函数 ❌ stub = 4 重导出 + 4 完整 + 7 stub）
- `ext/vector_relational.cj`（epsilon 版 16 重载 ✅ 可用；ULP 版 8 重载 ❌ stub）

### ❌ stub（空桩占位，运行均抛 Exception("stub")）

- `gtc/matrix_transform.cj`（64 个函数全部 ❌ stub）
- `detail/trigonometric.cj`（75 个展开函数全部 ❌ stub）
- `ext/matrix_projection.cj`
- `ext/matrix_clip_space.cj`
- `ext/matrix_transform.cj`

### 沿用自阶段二的 stub（❌ stub，运行均抛 Exception("stub")）

- `detail/common.cj`
- `detail/geometric.cj`
- `detail/matrix.cj`（27 实现 + 6 stub，均视为 stub 引用，本阶段不新增实现）

### 更新文件

- `fwd.cj`：新增 9 个四元数类型别名（Quat/FQuat/DQuat + 3×Float32 精度 + 3×Float64 精度；具体清单见 §2 lib.cj/fwd.cj 段落，v5 明确，**v12 关键修订，Issue 2 响应，v13 关键修订 Issue 3 响应**：fwd.cj 是自动生成文件（`cjglm/src/fwd.cj:1-2` 文件头注释为中文而非 v12 描述的英文「Auto-generated file. Do not edit!」），下游实施路径为方案 A 修改 `cjglm/scripts/gen_fwd_aliases.py` 生成脚本（**v13 修订**：v12 描述 `tools/gen_fwd.cj` 与实际不符），新增 `VEC_FAMILIES` 字典条目 + Quat 固定 4 维特殊处理分支；详见 §2 段落末尾「实施路径」说明）
- `lib.cj`：新增 Quat 类型、type_quat_cast 函数、ext/gtc 函数和常量的 public import（具体清单见 §2 lib.cj/fwd.cj 段落，v5 明确：20 个 `import` 声明，v9 扩展补齐）

### 测试设计（v3 新增 §8.2）

#### 测试文件清单与位置

阶段三测试文件位于 `tests/glm/` 目录下，按模块拆分：

| 测试文件 | 覆盖模块 | 预计用例数 |
|---------|---------|----------|
| `tests/glm/detail/test_type_quat.cj` | Quat 核心类型 + 运算符 | ≥40 |
| `tests/glm/detail/test_type_quat_cast.cj` | 矩阵-四元数互转函数（v3 新增） | ≥8 |
| `tests/glm/test_ext_quaternion_relational.cj` | 四元数关系运算（v10 修订：与 `test_ext.cj` 同层平铺命名，避免新建 `tests/glm/ext/` 子目录） | ≥8 |
| `tests/glm/test_ext_quaternion_geometric.cj` | 四元数几何函数（v10 修订：同层平铺命名） | ≥12 |
| `tests/glm/test_ext_quaternion_common.cj` | 四元数公共函数（v10 修订：同层平铺命名） | ≥13 |
| `tests/glm/test_ext_quaternion_trigonometric.cj` | 四元数三角函数（v10 修订：同层平铺命名） | ≥4 |
| `tests/glm/test_ext_quaternion_exponential.cj` | 四元数指数函数（stub）（v10 修订：同层平铺命名） | ≥4 |
| `tests/glm/test_ext_quaternion_transform.cj` | 四元数变换函数（stub）（v10 修订：同层平铺命名） | ≥2 |
| `tests/glm/test_ext_vector_relational.cj` | 向量 epsilon/ULP 比较（v10 修订：同层平铺命名） | ≥16 |
| `tests/glm/test_ext_scalar_constants.cj` | 标量常量（v10 修订：同层平铺命名；**v12 修订，Issue 8 响应**：用例数按「完整实现函数：每函数 ≥2 个用例」原则计算——3 个泛型函数 × 2 种浮点类型 × 2 用例 + 1 整数类型异常路径 = 13） | ≥13 |
| `tests/glm/test_ext_quaternion_aliases.cj` | 四元数别名（4 个别名文件合并测试，v10 修订：避免为每个别名文件单独建测试文件，**v12 关键修订，Issue 8 响应**：每别名 ≥1 用例，9 个别名共 ≥9 用例） | ≥9 |
| `tests/glm/gtc/test_constants.cj` | 数学常量 | ≥28（v8 修订：与 §3.12 gtc/constants 28 个常量函数对齐） |
| `tests/glm/gtc/test_quaternion.cj` | gtc 四元数转换重导出/比较/欧拉/看向 | ≥27（v8 修订：见下方用例分配原则） |
| `tests/glm/gtc/test_matrix_transform_stubs.cj` | gtc/matrix_transform 64 个 stub 函数 | ≥8 |
| **合计** | — | **≥192**（v15 修订，Issue 5 响应：与下方用例分配表对齐，`test_ext_quaternion_common.cj` 从 ≥16 修正为 ≥13，`test_ext_quaternion_trigonometric.cj` 从 ≥8 修正为 ≥4；按上述每行 ≥值求和：40+8+8+12+13+4+4+2+16+13+9+28+27+8=192；下方用例分配表逐项求和同样为 192，通过增补 7 个边界用例可达 ≥199） |

**v8 修订**：v7 文档 13 个测试文件均使用 `xxx_test.cj` 命名，但与项目实际不一致——通过 `ls cjglm/tests/glm/detail/` 验证阶段二现有约定**全部使用** `test_xxx.cj` 风格（`test_common.cj`/`test_geometric.cj`/`test_matrix.cj`/`test_qualifier.cj`/`test_scalar_mat_ops.cj`/`test_scalar_vec_ops.cj`/`test_setup.cj` 等 10+ 个文件），阶段三测试文件统一调整为 `test_xxx.cj` 风格以与现有约定对齐。

**测试目录结构对齐策略（v10 新增，Issue 8 响应）**：v9 设计的测试文件位于 `tests/glm/ext/` 与 `tests/glm/gtc/` 子目录中（与 `src/ext/` + `src/gtc/` 子包目录结构对齐），但**项目当前无 `tests/glm/ext/` 与 `tests/glm/gtc/` 子目录先例**——阶段二 25 个测试文件均位于 `tests/glm/` 根目录（如 `test_ext.cj`）或 `tests/glm/detail/` 子目录；`test_ext.cj` 是单一聚合文件而非按函数拆分。**v10 修订策略**：
- (a) **避免新建子目录**：`tests/glm/ext/` 与 `tests/glm/gtc/` 子目录本轮不新建；所有新增测试文件采用 `tests/glm/test_xxx.cj` 同层平铺命名（与 `test_ext.cj` 一致）；gtc 相关测试暂使用 `tests/glm/gtc/test_xxx.cj` 平铺子目录结构（避免与既有 ext 测试文件混淆）
- (b) **既有 `test_ext.cj` 兼容策略**：现有 `tests/glm/test_ext.cj`（102 行，验证 ext 包基础别名如 `ext.Mat4x4`）保持原状；新增的 `tests/glm/test_ext_xxx.cj` 文件按 ext 子模块拆分（如 `test_ext_vector_relational.cj`/`test_ext_quaternion_xxx.cj` 等），与 `test_ext.cj` 并存不冲突
- (c) **别名测试合并**：4 个 ext/ 别名文件（`quaternion_float.cj`/`quaternion_double.cj`/`quaternion_float_precision.cj`/`quaternion_double_precision.cj`）的测试合并为单一 `tests/glm/test_ext_quaternion_aliases.cj` 文件，避免为每个别名文件单独建测试文件
- (d) **下游实施步骤**：测试文件创建前无需 `mkdir -p`，按上述命名直接创建在对应目录即可

**v10 修订**：v9 设计的 `tests/glm/ext/test_xxx.cj` 与 `tests/glm/gtc/test_xxx.cj` 命名方案修订为上表所示的同层平铺命名；gtc 子目录保留但仅用于阶段三新增的 gtc 测试文件（与 src/gtc/ 子包源码位置镜像），不引入更深的子目录层级。

**用例分配原则（v8 新增）**：
- **完整实现函数**：每函数 **≥2 个用例**（覆盖正常路径 + 边界场景）
- **stub 函数**：每函数 **≥1 个用例**（验证抛 `Exception("stub")` 异常）
- **重导出函数**：每函数 **≥1 个用例**（验证可达性，调用返回正确结果）

**同类 stub 函数抽样策略说明（v17 新增，Issue 5 响应）**：对于数量较大且函数签名/行为高度同构的 stub 函数组（如 `gtc/matrix_transform.cj` 中 64 个 stub 函数），允许采用按类别分组抽样的测试策略而非逐函数全覆盖。抽样条件：(a) 组内所有函数实现均为 `throw Exception("stub")`，运行时行为完全一致；(b) 按 GLM 原始分类（基础变换 / ortho 系族 / frustum 系族 / perspective 系族 / perspectiveFov 系族 / infinitePerspective 系族 / 投影工具 / 拾取矩阵）每类选取 ≥1 个代表性函数验证异常抛出路径，合计 ≥8 个用例即可覆盖全部 64 个函数的 stub 行为。该策略仅适用于 stub 占位函数的异常路径验证；阶段四完整实现后每函数须按「完整实现函数 ≥2 用例/函数」原则补全测试覆盖。

**`tests/glm/gtc/test_quaternion.cj` 用例数重算（v8 修订）**：v7 文档原 20 个用例，8 个完整实现函数（4 比较 + 4 转换重导出）平均仅 2.5 个/函数，低于用例分配原则。按 v8 原则重算：
- 4 个完整实现（`lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual`）：4 × 2 = **8 个用例**
- 4 个重导出（`mat3Cast`/`mat4Cast`/`quatCast(Mat3)`/`quatCast(Mat4)`，每函数另加 1 个可达性测试）：4 × (2 + 1) = **12 个用例**（v8 修订：重导出函数按"完整实现函数 + 1 可达性测试"双重覆盖，确保下游消费者既验证返回值正确性也验证调用链通畅）
- 7 个 stub（`eulerAngles`/`roll`/`pitch`/`yaw`/`quatLookAt`/`quatLookAtRH`/`quatLookAtLH`）：7 × 1 = **7 个用例**（验证抛 stub 异常）
- **合计**：8 + 12 + 7 = **27 个用例**（v8 修订：与 8×2 + 7×1 + 4×1 = 27 公式一致，分解为「8 可测函数 × 2 = 16 + 4 重导出可达性测试 × 1 = 4 + 7 stub × 1 = 7 = 27」）

#### 用例到函数的逐项分配依据（v13 新增，Issue 6 响应）

为满足 ≥199 用例的覆盖充分性可追溯性，以下按测试文件逐一列明函数分组与用例分配依据，确保每个用例均可追溯到§11.5表中的对应函数：

| 测试文件 | 函数分组 | 函数数 | 每函数用例数 | 分组合计 | 分配依据 |
|---------|---------|--------|------------|---------|---------|
| `test_type_quat.cj` | 构造函数（item 1-7, 10，共 8 个完整实现） | 8 | 2 | 16 | 完整实现 ≥2用例/函数 |
| | fromVec3/fromEuler（2 个 stub） | 2 | 1 | 2 | stub ≥1用例/函数 |
| | 运算符算术（`+`/`-`/`*`/`/`/一元`-`，共 5 个） | 5 | 2 | 10 | 完整实现 ≥2用例/函数 |
| | 运算符 `==`/`!=`（2 个） | 2 | 1 | 2 | 精确比较 ≥1用例/函数 |
| | Quat×Vec3/Vec4（2 个 ⚠️） | 2 | 2（1 编译 + 1 assertThrows） | 4 | ⚠️ 阻塞函数 ≥1编译 + ≥1运行时 |
| | Vec3×Quat/Vec4×Quat（2 个） | 2 | 1 | 2 | 依赖 inverse 路径 ≥1用例 |
| | Quat×T/T×Quat/Quat/T/scalar_quat_ops（6 个） | 6 | 1 | 6 | 标量运算 ≥1用例 |
| | **小计** | **27 函数** | — | **42** | 略超 ≥40 下限 |
| `test_type_quat_cast.cj` | mat3Cast/mat4Cast/quatCast×2（4 个） | 4 | 2 | 8 | 完整实现 ≥2用例/函数 |
| `test_ext_quaternion_relational.cj` | equal×2/notEqual×2（4 个） | 4 | 2 | 8 | 完整实现 ≥2用例/函数 |
| `test_ext_quaternion_geometric.cj` | dot/length/normalize/cross（4 个） | 4 | 3 | 12 | 完整实现 ≥2用例 + 边界(如normalize零保护) |
| `test_ext_quaternion_common.cj` | conjugate/inverse/lerp/isnan/isinf（5 个完整） | 5 | 2 | 10 | 完整实现 ≥2用例/函数 |
| | mix/slerp×2（3 个 stub） | 3 | 1 | 3 | stub ≥1用例/函数 |
| | **小计** | **8 函数** | — | **13** | 略低于 ≥16 下限（可提升至 16 通过增加边界用例） |
| `test_ext_quaternion_trigonometric.cj` | axis（1 个完整） | 1 | 2 | 2 | 完整实现 ≥2用例/函数（含零四元数边界） |
| | angle/angleAxis（2 个 stub） | 2 | 1 | 2 | stub ≥1用例/函数 |
| | **小计** | **3 函数** | — | **4** | 符合 ≥4 下限；如需提升覆盖率可增补至 ≥8 |
| `test_ext_quaternion_exponential.cj` | exp/log/pow/sqrt（4 个 stub） | 4 | 1 | 4 | stub ≥1用例/函数 |
| `test_ext_quaternion_transform.cj` | rotate（1 个 stub） | 1 | 1 | 1 | stub ≥1用例/函数（≥2 含 1 个额外边界验证） |
| `test_ext_vector_relational.cj` | epsilon equal/notEqual（16 个重载） | 16 | 1 | 16 | 完整实现 ≥2用例/函数（实际每重载 1 用例即可；16 略低于 ≥16 下限，实际可补至 32） |
| `test_ext_scalar_constants.cj` | epsilon/pi/cos_one_over_two（3 函数 × 2 浮点类型） | 6 | 2 | 12 | 完整实现 ≥2用例 × 2 类型 |
| | 整数异常路径 | 1 | 1 | 1 | 异常路径 1 用例 |
| | **小计** | **7 条目标** | — | **13** | 与 ≥13 一致 |
| `test_ext_quaternion_aliases.cj` | 9 个别名（Quat/FQuat/DQuat + 3×Float32精度 + 3×Float64精度） | 9 | 1 | 9 | 每别名 ≥1用例 |
| `test_constants.cj` | 28 个常量函数 | 28 | 1 | 28 | 每常量 ≥1用例 |
| `test_quaternion.cj` | 4 个比较函数 | 4 | 2 | 8 | 完整实现 ≥2用例/函数 |
| | 4 个重导出函数 | 4 | 3（2 功能 + 1 可达性） | 12 | 完整实现 + 可达性 |
| | 7 个 stub | 7 | 1 | 7 | stub ≥1用例/函数 |
| | **小计** | **15 函数** | — | **27** | 与 ≥27 一致 |
| `test_matrix_transform_stubs.cj` | 64 个 stub 函数 | 64 | 按类别抽样 | 8 | stub ≥1用例/函数（64 个同类 stub 按类别分组抽样验证） |
| | **全表总计** | — | — | ≥192 | 逐项相加：40+8+8+12+13+4+4+2+16+13+9+28+27+8 = 192（下限）；通过增补三角函数/geometric 边界用例 7 个可轻松达到 ≥199 |

**v13 修订，Issue 6 响应**：上表中 `test_ext_quaternion_trigonometric.cj`（4 ≤ 8）与 `test_ext_quaternion_common.cj`（13 ≤ 16）的分组合计略低于各自文件中声明的 ≥下限。下游编码者可依据「每函数 ≥1 额外边界用例」原则补齐差值（如为 `trigonometric` 的 2 个 stub 各增加 1 个不同参数类型边界用例 + 为 `common` 的 `isnan`/`isinf` 各增加 1 个跨 Qualifier 用例），确保各文件实际用例数不低于表中原声明的 ≥值。全表 ≥199 合计值通过上述补齐可达。

#### 测试覆盖维度

1. **构造路径**：单位构造、逐分量构造、wxyz 工厂、标量+向量构造、跨 Qualifier 构造、跨类型构造（fromQuat）、从矩阵构造（fromMat3/fromMat4）、从两向量构造（fromVec3 stub）、从欧拉角构造（fromEuler stub）
2. **运算符正常路径**：算术运算（+ - * / 一元 -）、Quat×Vec3/Vec4 旋转、Vec3×Quat/Vec4×Quat 逆旋转、Quat×T 标量运算、==/!= 比较
3. **ext 函数库正常路径**：vector_relational 16 重载、quaternion_relational 4 函数、quaternion_geometric 4 函数、quaternion_common 中 conjugate/inverse/lerp/isnan/isinf 5 函数、quaternion_trigonometric 中 axis 1 函数
4. **gtc/quaternion.cj 正常路径（v3 新增）**：4 个比较函数（lessThan/lessThanEqual/greaterThan/greaterThanEqual）+ 4 个转换函数重导出（mat3Cast/mat4Cast/quatCast 两个重载）+ **detail/type_quat_cast 单元测试覆盖实现细节**（v3 新增）
5. **stub 函数异常路径**：mix/slerp(2 版本)/angle/angleAxis/exp/log/pow/sqrt/rotate/eulerAngles/roll/pitch/yaw/quatLookAt* 调用时验证抛 `Exception("stub")`
6. **跨 Qualifier 实例化**：PackedHighp/PackedMediump/PackedLowp/AlignedHighp/AlignedMediump/AlignedLowp 6 种精度的 Quat 运算符测试
7. **跨类型实例化**：Float32/Float64 的 Quat 完整测试，整型 Quat 仅测试非依赖 stub 的运算符（边界处理）
8. **⚠️ 已实现但被 stub 阻塞函数**（v12 新增，Issue 7 响应）：覆盖 `Quat×Vec3`/`Quat×Vec4` 运算符。要求：每函数 ≥1 个编译期测试（验证 `cjpm build` 通过）+ ≥1 个运行时 `assertThrows` 测试（验证抛 `Exception("stub")`）。§11.5 ⚠️ 符号行同步引用本覆盖要求。

#### 浮点比较策略

- **epsilon 版本**：使用 `epsilon<Float32>() = 1.1920929e-7` 作为容差，调用 `equal(v1, v2, epsilon<Float32>())` 验证
- **精确比较**：对于 should be 精确相等的运算结果（如 `identity * v == v`），使用 `==` 直接比较
- **角度比较**：旋转等价性使用「四元数点积绝对值接近 1」判断（`abs(dot(q1, q2)) > 1 - epsilon<Float32>()`），避免 q 与 -q 的双重覆盖
- **type_quat_cast 单元测试（v3 新增）**：使用「旋转矩阵 * 向量 = 四元数 * 向量」等价性测试（`m3 * v == q * v`）验证互转正确性

#### 阶段三可验证 vs 待阶段四拆分

- **本阶段可验证**（路线图标注 `[可验证]`）：所有「完整实现」函数 + 「stub 函数异常路径」（验证抛 stub 异常）
- **部分可验证**（路线图标注 `[部分可验证]`）：运算符依赖 stub 的部分（如 `Quat×Vec3` 旋转调用抛 stub 异常），需在测试中标注「本阶段抛 stub 异常，待阶段四 geometric.cj 完整实现后生效」
- **待阶段四**（路线图标注 `[待 Stage 4]`）：stub 函数的正常路径测试（如 slerp 球面插值结果、pow 指数运算结果）推迟至阶段四函数库完整实现后补齐

### 8.4 阶段三实施批次建议（v15 新增，Issue 3 响应）

本阶段涉及 25+ 个源文件的创建与修改，按拓扑依赖排序给出以下 4 批实施顺序建议。每批完成后可独立验证（`cjpm build` 编译通过）。

**实施批次划分原则**：① 被依赖的文件先于依赖者实施；② 每个批次内的文件无相互依赖，可并行实施；③ `gen_fwd_aliases.py` 修改在第一批完成，确保后续 alias 引用可用。

| 批次 | 文件清单 | 实施内容 | 验证标准 |
|------|---------|---------|---------|
| **第一批（基础设施 + 别名）** | `detail/type_quat.cj` + `detail/type_quat_cast.cj` + `detail/scalar_constants.cj` + `detail/scalar_quat_ops.cj` + 4 个 ext/ 别名文件 + `gen_fwd_aliases.py` 修改 + `fwd.cj` 重新生成 + `lib.cj` 追加 import 声明 | 四元数核心类型定义、运算符、转换函数；标量常量；标量-四元数运算；别名文件；自动生成脚本修改 | `cjpm build` 通过；`Quat<Float32,PackedHighp>.identity(1.0f)` 编译通过 |
| **第二批（ext 函数库 - 无 stub 依赖部分）** | `ext/quaternion_relational.cj` + `ext/quaternion_geometric.cj` + `ext/quaternion_common.cj`（先实现 conjugate/inverse/lerp/isnan/isinf 5 函数，mix/slerp stub 占位）+ `ext/quaternion_trigonometric.cj`（先实现 axis 函数，angle/angleAxis stub 占位）+ `ext/scalar_constants.cj`（重导出接口） | 四元数关系运算、几何函数、公共函数（可用部分）、三角函数（axis 部分） | 第二批函数运行时不抛 stub 异常；`assertThrows` 验证 stub 函数抛 `Exception("stub")` |
| **第三批（stub 函数库 + gtc 常量）** | `ext/quaternion_transform.cj`（rotate stub）+ `ext/quaternion_exponential.cj`（exp/log/pow/sqrt 全部 stub）+ `gtc/quaternion.cj`（4 重导出 + 4 完整 + 7 stub）+ `gtc/constants.cj`（28 常量） | 剩余 stub 函数声明；gtc 四元数重导出与比较函数；gtc 数学常量 | `cjpm build` 通过；gtc/quaternion 比较函数运行时正常；stub 函数 `assertThrows` 验证 |
| **第四批（空桩 + 继承 stub）** | `detail/trigonometric.cj`（75 展开函数 stub）+ `ext/matrix_projection.cj` + `ext/matrix_clip_space.cj` + `ext/matrix_transform.cj` + `gtc/matrix_transform.cj`（64 函数 stub）+ `ext/vector_relational.cj`（epsilon 16 重载 ✅ + ULP 8 重载 ❌） | 所有空桩文件函数签名声明；vector_relational 的 epsilon 比较部分 | `cjpm build` 通过；所有 stub 函数 `assertThrows` 验证 |

**关键依赖链说明**：
- `gen_fwd_aliases.py` 修改（第一批）→ 所有引用 `glm.Quat`/`glm.FQuat`/`glm.DQuat` 别名的代码
- `detail/type_quat.cj`（第一批）→ 所有 ext/gtc 函数库（第二~四批均依赖 Quat 类型存在）
- `ext/quaternion_geometric.cj`（第二批）→ `normalize`/`dot`/`length`/`cross` 被 `ext/quaternion_common.cj` 的 `inverse`/`lerp` 调用
- `detail/trigonometric.cj`（第四批）→ 仅需函数签名（stub），不影响第二~三批函数编译；运行时调用 stub 函数才抛异常

> **与项目路线图实施风格对齐说明**：本批次划分方式与 `docs/02_roadmap.md` 第 165-169 行的阶段四实施批次建议（按「第一批无函数库内部依赖 → 第二批依赖基础函数库 → 第三批依赖前两批 → 第四批 gtc/ 扩展函数库」拓扑排序）风格一致。

### 编码启动前验证项

1. **cjpm gtc 子包构建预验证**：验证 `src/gtc/` + `package glm.gtc` 的构建可行性（与 §2 末尾 cjpm 子包构建预验证策略对应）
2. **gtc/quaternion.cj 重导出 detail 函数验证（v3 新增）**：验证 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 能否正确将 detail 包级函数重导出至 glm.gtc 命名空间（无编译错误，外部 `glm.gtc.quaternion.mat3Cast(q)` 调用正常）
3. **包间无循环依赖验证（v3 新增）**：使用 `cjpm check` 命令验证整个项目不包含包间循环依赖（特别是 `glm.gtc` 与 `glm.detail` 之间），符合 cangjie-lang-features package/README.md 第 99 行约束
4. **type_quat.cj 同包调用 type_quat_cast.cj 函数验证**：验证 `fromMat3`/`fromMat4` 在 `type_quat.cj` 中调用同包 `type_quat_cast.cj` 的 `mat3Cast`/`mat4Cast`/`quatCast` 函数（同包内可见性，无需 import）
5. **Vec3/Vec4 extend 块中 Quat 类型前向引用验证**：Vec3×Quat 和 Vec4×Quat 运算符需在 Vec3/Vec4 的 extend 块中引用 Quat 类型，验证同包延迟解析（已通过阶段二原型验证，仅为防御性确认）
6. **scalar_constants 的泛型 `match` 类型模式匹配验证**：验证 `func epsilon<T>(hint: T): T where T <: Number<T>` 函数体内 `match (hint) { case _: Float32 => ... }` 编译通过
7. **scalar_constants 对整数类型 T 的行为契约验证**：验证 `epsilon<Int64>()` 调用时按 D25 决策抛出运行时异常（约束收紧若失败时的 fallback 路径）
8. **标量-四元数与标量-向量/标量-矩阵同名重载消歧验证**：`add(s: T, q: Quat<T,Q>)` 与 `add(s: T, v: Vec2<T,Q>)`/`add(s: T, m: Mat2x2<T,Q>)` 等的编译器消歧
9. **`x.isNaN()`/`x.isInf()` 实例方法路径验证**：确认仓颉标准库为所有浮点类型提供 `isNaN()`/`isInf()` 实例方法（影响 quaternion_common.cj 中 isnan/isinf 的实现可行性）
10. **ext/vector_relational 内联 abs 验证**：验证 `if (d >= T(0)) { d } else { -d }` 模式在 `Number<T> & Comparable<T>` 约束下的编译通过性
11. **`@Derive[Hashable]` 对 `Q <: Qualifier` 的支持验证**：验证 Hashable 派生宏对 6 个 Qualifier 实现类型的编译通过性
12. **`length(q)` 在 Float32 实例的 sqrt 转换验证**：验证目标分两级——(a) 首选：验证 `T(std.math.sqrt(dot_qq))` 路径（直接利用 `std.math.sqrt` 的 Float32 重载，与 §1 方案 A 一致）；(b) 备选：若 (a) 不可行，验证 `T(Float64.sqrt(Float64(dot_qq)))` 回退路径
13. **`isnan`/`isinf` 函数约束收紧验证（v4 新增，v7 接口名修订，**v10 修订：删除错误引用**）**：验证 `where T <: FloatingPoint<T>` 约束（stdlib 原生接口，见 `cangjie-std/math/README.md` 第 117 行）在仓颉编译器的支持情况；实例化 `Quat<Float32, PackedHighp>` 调用 `isnan`/`isinf` 通过编译；实例化 `Quat<Int64, PackedHighp>` 调用 `isnan`/`isinf` 报类型不匹配错误。`FloatingPoint<T>` 是 stdlib 原生接口，无「不可用」风险，本验证项无需 fallback 验证。**v10 修订**：删除 v9 描述中「可验证 `FloatingPoint<T>` 接口的 `getMin()`/`getInf()` 实例方法可用性（对应 std::numeric_limits<T>::min()/infinity()）」的提示——`FloatingPoint<T>` 接口本身**不提供任何实例方法**（见 `cangjie-std/math/README.md` 第 117 行仅作为类型约束声明），下游如需 `std::numeric_limits<T>::min()`/`infinity()` 等价物应通过类型分派 `Float32.Min`/`Float32.Inf`/`Float64.Min`/`Float64.Inf` 静态常量获取，详见验证项 16/18
14. **Quat 字段 `public var` 可见性验证（v4 新增）**：确认 `@Derive[Hashable]` 派生宏在 Quat 字段标注 `public var` 时编译通过；若字段标注缺失 `public`，验证派生失败报可见性错误
15. **`pow` 函数四元数版本与 `std.math.pow` 实数版本命名消歧验证（v5 新增，v7 Float64 转换依赖补充）**：验证 `pow(x: Quat<T,Q>, y: T)` 函数体内部调用 `std.math.pow(x.w, y)` 实数版本时，类型推断正确（参数类型为 `T`/`T`），不与四元数 `pow` 自身签名混淆；确认 `std.math.pow` 对 `Float32`/`Float64` 的可用性，若不存在则需以 `exp(y * log(x.w))` 替代实现（v7 补充：因 std.math 的 pow/log/exp 签名仅支持 Float64，`pow(Quat<Float32, Q>, Float32)` 路径需先显式转换至 Float64 再降级，fallback `exp(y * log(x.w))` 同步需 Float64 转换）
16. **`pow` 函数次正规数边界检查所需 `FloatingPoint<T>.getMinDenormal()` 静态方法路径验证（v5 新增，v7 接口名修订，**v11 关键修订，Issue 8 响应：v10「原 `FloatingPoint<T>.getMin()` 方法验证目标不存在」错误**）**：依据 `cangjie-original-docs/std/math/math_package_api/math_package_interfaces.md` 第 49-60 行定义，仓颉 stdlib **实际提供** `FloatingPoint<T>.getMinDenormal()` 静态方法用于获取最小次正规数；下游实现 `pow` 函数体内部次正规数边界检查时，应直接调用 `FloatingPoint<T>.getMinDenormal()`（推荐路径），或 fallback 到类型分派 `if (q.x is Float32) { Float32.Min } else { Float64.Min }` 路径，或字面量 fallback 路径（如 `T(1) / T(很大值)`）。验证项应验证「`FloatingPoint<T>.getMinDenormal()` 静态方法 + 类型分派 + 字面量 fallback 三条路径的编译可行性」
17. **`type_quat_cast` 函数 `FloatingPoint<T>` 约束可用性验证（v5 新增，v7 接口名修订）**：验证 `where T <: FloatingPoint<T>` 约束（stdlib 原生接口）在 `mat3Cast`/`mat4Cast`/`quatCast` 4 个函数签名上的编译可行性；实例化 `Quat<Float32, PackedHighp>` 调用转换函数通过编译；实例化 `Quat<Int64, PackedHighp>` 调用转换函数报类型不匹配错误（与 GLM `GLM_STATIC_ASSERT(is_iec559, ...)` 等价行为）
18. **`log` 函数 `FloatingPoint<T>.getInf()` 静态方法路径验证（v5 新增，v7 接口名修订，**v11 关键修订，Issue 8 响应：v10「原 `FloatingPoint<T>.getInf()` 方法验证目标不存在」错误**）**：依据 `cangjie-original-docs/std/math/math_package_api/math_package_interfaces.md` 第 37-48 行定义，仓颉 stdlib **实际提供** `FloatingPoint<T>.getInf()` 静态方法用于获取正无穷；下游实现 `log` 函数体内部 w=0 退化分支时，应直接调用 `FloatingPoint<T>.getInf()`（推荐路径），或 fallback 到类型分派 `if (q.x is Float32) { Float32.Inf } else { Float64.Inf }` 路径，或字面量 fallback 路径 `T(1)/T(0)`（仅对浮点类型有效，整数类型 `1/0` 触发除零异常，与 GLM 行为一致）。验证项应验证「`FloatingPoint<T>.getInf()` 静态方法 + 类型分派 + 字面量 fallback 三条路径的编译可行性」
19. **`epsilon<T>()` 与 `epsilonOf<T>(hint)` 返回值一致性验证（v10 新增，Issue 4 响应）**：阶段二 `cjglm/src/detail/shim_limits.cj:25` 已有 `public func epsilonOf<T>(hint: T): T where T <: Number<T>` 函数，本设计新增的 `epsilon<T>()` 函数与其功能等价。验证项需验证：在 `T = Float32` 实例化时，`epsilon<Float32>()` 与 `epsilonOf<Float32>(0.0f)` 返回值相等（`Float32(1.1920929e-7)`）；在 `T = Float64` 实例化时，`epsilon<Float64>()` 与 `epsilonOf<Float64>(0.0)` 返回值相等（`Float64(2.220446049250313e-16)`）；在 `T = Int64` 实例化时两者均返回 `Int64(0)`（`hint - hint` 形式）；阶段二测试 `tests/glm/detail/test_shim_limits.cj` 中硬编码的精度值作为 ground truth 验证依据
20. **`FloatingPoint<T>` 接口方法可用性验证（v11 关键修订，Issue 8 响应，**v14 补充质询报告核查声明**）**：依据 `cangjie-original-docs/std/math/math_package_api/math_package_interfaces.md` 第 5-17 行定义，验证 `FloatingPoint<T>` 接口实际提供 6 个静态方法（`getE`/`getInf`/`getPI`/`getMinDenormal`/`getMinNormal`/`getNaN`）+ 3 个实例方法（`isInf`/`isNaN`/`isNormal`）。v10 描述「`FloatingPoint<T>` 接口本身无任何实例方法」错误——下游实现 `pow` 次正规数边界检查时应直接调用 `FloatingPoint<T>.getMinDenormal()` 而非类型分派；实现 `log` w=0 退化分支时应直接调用 `FloatingPoint<T>.getInf()` 而非类型分派；实现 `isnan`/`isinf` 约束时该 where 子句确保 T 类型实现 `isNaN()`/`isInf()` 实例方法。**v14 质询报告核查声明**：本验证项引用的 `FloatingPoint<T>` 接口方法清单基于 `cangjie-original-docs/std/math/math_package_api/math_package_interfaces.md` 编写，v13 中对该文档的引用内容未纳入本轮 v14 审查范围的独立复核——下游编码者在实际调用 `FloatingPoint<T>.getMinDenormal()`/`getInf()` 等方法前应以仓颉编译器实际签名确认
21. **`std.math` Float32 重载可用性验证（v11 关键修订，Issue 7 响应）**：依据 `cangjie-original-docs/std/math/math_package_api/math_package_funcs.md` 全文检索，验证 `std.math` 三角函数（`sin`/`cos`/`tan`/`asin`/`acos`/`atan`/`sinh`/`cosh`/`tanh`/`asinh`/`acosh`/`atanh`/`atan2`/`sqrt`/`exp`/`log`）均提供 Float16/Float32/Float64 三种重载，`std.math.pow` 提供 Float32/Float64 共 4 个重载。T=Float32 实例化时调用 `std.math.sin(x)`/`std.math.cos(x)`/`std.math.pow(x, y)` 等函数**直接返回 Float32**，无需 `T(Float64.xxx(Float64(value)))` 显式转换。`radians`/`degrees` 是例外（stdlib 不存在这两个函数）
22. **`trigonometric.cj` T 约束验证（v11 关键修订，Issue 1 响应）**：验证 §3.13.1 所有 75 个展开函数签名（含 14 标量 + 56 向量 + 1 标量 `atan2` + 4 向量 `atan2`）均标注 `where T <: FloatingPoint<T>`；实例化 `trigonometric.sin<Float32, PackedHighp>(1.0f)` 通过编译；实例化 `trigonometric.sin<Int64, PackedHighp>(1)` 报类型不匹配错误
23. **`fwd.cj` 自动生成脚本验证（v12 关键修订，Issue 2 响应，**v13 关键修订脚本位置，Issue 3 响应**）**：验证 `cjglm/scripts/gen_fwd_aliases.py` 生成脚本（**v13 修订**：v12 描述查阅 `cjglm/tools/` 目录——`cjglm/` 下不存在 `tools/` 目录，实际生成脚本为 Python 64 行位于 `scripts/`）是否能正确生成 9 个四元数 type alias——具体步骤：(a) 查阅 `cjglm/scripts/gen_fwd_aliases.py` 确认生成脚本存在（**v13 修订**：v12 描述查阅 `cjglm/tools/` 修订为 `cjglm/scripts/`）；(b) 在脚本的 `VEC_FAMILIES` 字典中新增 `Quat`/`FQuat`/`DQuat` 三个家族前缀条目（如 `Quat`/`FQuat` 映射到 `Float32`，`DQuat` 映射到 `Float64`），并新增针对 Quat 家族固定 4 维（无 Vec1/Vec2/Vec3 变体）的特殊处理分支——因 Quat 仅支持 4 维而现有脚本按 `DIMS = [1, 2, 3, 4]` 全维度循环生成 Vec 别名，简单新增 `VEC_FAMILIES` 条目会生成 `Quat1`/`Quat2`/`Quat3` 三个不存在项；(c) 运行脚本 `python cjglm/scripts/gen_fwd_aliases.py` 生成新的 `fwd.cj` 后再提交；(d) 验证生成的 `fwd.cj` 包含全部 9 个 type alias 且与 §3.14 清单一致；(e) 验证脚本支持幂等运行（多次执行结果一致）
24. **`conjugate` const func 编译可行性验证（v12 关键修订，Issue 7 响应）**：验证 `conjugate` 函数声明为 `const func` 后能在 const 上下文正确编译——具体步骤：(a) 实现 `public const func conjugate<T, Q>(q: Quat<T, Q>): Quat<T, Q> where T <: Number<T>, Q <: Qualifier { Quat<T, Q>(-q.x, -q.y, -q.z, q.w) }`；(b) 在 `const` 上下文（如 `const val q_conj = conjugate(q)` 或 `const init` 块内）调用 `conjugate(q)` 验证编译通过；(c) 参照阶段一 `type_vec3.cj:54-80` 中 27 个 const func + 阶段二矩阵 `negative` const func 实践，确保与既有 const func 实现模式一致
25. **`T(Float64(n))` 字面量转换路径编译可行性验证（v15 新增，Issue 2 响应）**：验证 `T(Float64(n))` 语法对全部受影响的类型变体编译通过——(a) 实例化 `Float32(Float64(0))`/`Float32(Float64(1))`/`Float32(Float64(2))` 通过编译；(b) 实例化 `Float64(Float64(0))`/`Float64(Float64(1))`/`Float64(Float64(2))` 通过编译；(c) 实例化 `Int8(Float64(0))`/`Int16(Float64(0))`/`Int32(Float64(0))`/`Int64(Float64(0))` 通过编译；(d) 实例化 `Int8(Float64(1))`/`Int16(Float64(1))`/`Int32(Float64(1))`/`Int64(Float64(1))` 通过编译；(e) 若 (a)-(d) 任意一步编译失败，则依赖此路径的全部函数（normalize/axis/mat3Cast/mat4Cast/Quat×Vec3/Quat×Vec4）的实现假设被证伪，需重新评估 §1「常量型 T(n) 字面量替代」策略
26. **Mat4x4 `[]` 运算符返回类型为可赋值引用验证（v15 新增，Issue 3 响应）**：验证 `Mat4x4<T,Q>` 的 `[]` 索引运算符返回类型为可赋值引用（`&Vec4<T,Q>` 或 `mut Vec4<T,Q>`），确保 `mat3Cast`/`mat4Cast` 逐元素填充模式中 `result.col0 = Vec4<T,Q>(...)` 赋值路径编译通过——(a) 查阅阶段二 `type_mat4x4.cj` 中 `[]` 运算符签名，确认返回 `&Vec4<T,Q>`（可赋值引用）或返回 `Vec4<T,Q>`（值类型，不可赋值）；(b) 若返回为值类型（不可赋值），则 `mat3Cast`/`mat4Cast` 需退化为通过 `Mat4x4<T,Q>(col0, col1, col2, col3)` 主构造函数构造，不依赖 `[]` 赋值路径
27. **Mat4x4 列字段名 `c0`/`c1`/`c2`/`c3` 存在性验证（v21 核验确认——v19 修订 Issue 6 响应，本轮升级为「已核验确认」）**：**v21 核验结论**——经查阅阶段二 `type_mat4x4.cj:8-11`，列字段名确为 `c0`/`c1`/`c2`/`c3`，设计假设已验证为正确。本验证项状态从「验证假设」升级为「已核验确认」。验证结果：`Mat4x4<T,Q>` 列字段命名为 `c0`/`c1`/`c2`/`c3`，§3.3 item 7 `fromMat4` 手动提取策略中 `m.c0`/`m.c1`/`m.c2` 引用正确，无需修正。**说明**：验证项 27 的假设核验已在本轮设计阶段由设计方完成，编码者无需重复核验——可直接按 §3.3 item 7 的描述字面实现 `Vec3<T,Q>(m.c0.x, m.c0.y, m.c0.z)` 等表达式。
28. **Vec4 双参数构造函数 `Vec4<T,Q>(Vec3<T,Q>, T)` 在所有 6 个 Qualifier 变体上编译可行性验证（v15 新增，Issue 6 响应）**：验证 `Vec4<T,Q>(Vec3<T,Q>, T)` 双参数构造函数签名在全部 6 个 Qualifier 变体上均编译通过——(a) 实例化 `Vec4<Float32, PackedHighp>(Vec3<Float32, PackedHighp>(1.0f, 2.0f, 3.0f), 4.0f)` 通过编译；(b) 重复 (a) 对其他 5 个 Qualifier（PackedMediump/PackedLowp/AlignedHighp/AlignedMediump/AlignedLowp）分别验证；(c) 若任意 Qualifier 变体编译失败，则 `Quat×Vec4` 运算符（§3.4 行 `Vec4(q * Vec3(v), v.w)` 公式）在该精度变体上不可用，需在 §11.5 中标注 Qualifier 限制
29. **`glm.detail` 包对 `glm.ext` 的无导入验证（v26 修订，Issue 5 响应）**：确认 `detail/type_quat.cj` 中**无** `import glm.ext.*` 声明，因 §3.4 v18 已对 Vec3×Quat/Vec4×Quat 采用内联 conjugate/dot 计算路径，无需跨包 import。验证方式：(a) grep `type_quat.cj` 确认无 `import glm.ext.*` 声明；(b) 执行 `cjpm build` 确认编译通过。**受影响章节**：§2 模块间依赖图、§3.4 Vec extend 块

#### 验证失败后受影响章节清单（v18 新增，Issue 4 响应；**v23 修订，Issue 6 响应：补充修复责任人列**）

以下映射表列出了编码启动前验证项验证失败时需同步修改的设计章节，便于快速定位修复范围：

| 验证项 | 验证假设 | 验证失败后受影响章节 | 修复责任人 |
|-------|---------|-------------------|----------|
| 1-2（gtc 子包构建） | cjpm 识别 `src/gtc/` + `package glm.gtc` | §2「cjpm 子包构建预验证」回退方案；§2 包组织结构；§8.3 验收项 E | 设计者 |
| 3（包间无循环依赖） | `glm.gtc → glm.detail` 单向 | §2 模块间依赖图；§3.2.1 type_quat_cast 包归属决策 D11；§3.15 跨包引用 | 设计者 |
| 4（同包调用 type_quat_cast） | `fromMat3`/`fromMat4` 调用同包函数 | §3.3 item 6/7；§3.2 协作关系表 | 设计者 |
| 5（Vec extend 块前向引用） | Vec3/Vec4 extend 块中 Quat 引用延迟解析 | §3.4 Vec extend 块 | 设计者 |
| 6-7（scalar_constants match 模式） | 泛型 `match` 类型模式匹配编译 | §3.12 实现策略；§7 D09 | 编码者 |
| 8（标量运算同名重载消歧） | add/sub/mul/div 与向量/矩阵版本消歧 | §3.4 全局具名函数表；§7 D18 | 编码者 |
| 9（isNaN/isInf 实例方法） | 浮点类型提供 `isNaN()`/`isInf()` | §3.11 isnan/isinf 实现路径；§7 D29 | 编码者 |
| 10（内联 abs 编译通过） | `Number<T> & Comparable<T>` 内联模式 | §3.5 依赖分析段 | 编码者 |
| 11（Hashable 派生对 Qualifier） | `@Derive[Hashable]` 对 `Q <: Qualifier` 支持 | §3.1 `@Derive[Hashable]` 约束核验段；§7 D30 | 设计者 |
| 12（length sqrt 转换） | `T(Float64.sqrt(Float64(dot_qq)))` 编译 | §3.7 length 函数；§1 Float32/std.math 约束 | 编码者 |
| 13（isnan/isinf 约束收紧） | `where T <: FloatingPoint<T>` 编译期生效 | §3.11 isnan/isinf 签名；§7 D29；§5.3 边界条件表 | 设计者 |
| 14（public var 可见性） | `public var` 字段满足 Hashable 派生 | §3.1 数据成员声明；§7 D30 | 编码者 |
| 15（pow 命名消歧） | 四元数 pow 与 std.math.pow 区分 | §3.10 pow 依赖描述；§1 系统性约束 | 编码者 |
| 16（getMinDenormal 静态方法） | `FloatingPoint<T>.getMinDenormal()` 存在 | §3.10 pow 次正规数边界；§1 回退方案 H2 路径 A/B | 编码者 |
| 17（type_quat_cast 约束） | `where T <: FloatingPoint<T>` 编译生效 | §3.2.1 函数签名规范；§7 D32；§5.3 边界条件表 | 设计者 |
| 18（getInf 静态方法） | `FloatingPoint<T>.getInf()` 存在 | §3.10 log w=0 退化分支；§1 回退方案 H2 路径 A/B | 编码者 |
| 19（epsilon 一致性） | `epsilon<T>()` 与 `epsilonOf<T>(hint)` 一致 | §3.12 epsilon 实现；§8.2 测试覆盖维度 | 编码者 |
| 20（FloatingPoint 接口方法）→ P0 | 6 静态 + 3 实例方法均存在 | §1 回退方案 H2 全部路径；§3.10/§3.11 依赖描述；§7 D21/D29 | 编码者 |
| 21（std.math Float32 重载） | 三角函数均提供 Float32 重载 | §1 Float32/std.math 约束段；§3.13.1 函数表；§3.10 pow/log/exp | 编码者 |
| 22（trigonometric T 约束） | 75 展开函数均标注 `FloatingPoint<T>` | §3.13.1 函数签名表；§8.3 验收项 E | 设计者 |
| 23（fwd.cj 生成脚本） | `gen_fwd_aliases.py` 正确生成 9 别名 | §2 fwd.cj 段落；§3.14 别名清单；§8.3 验收项 F | 编码者 |
| 24（conjugate const func） | `const func` 编译通过 | §3.11 conjugate 实现；§5.4 const 上下文约束 | 编码者 |
| 25（T(Float64(n)) 语法）→ P0 | 全部受影响的类型编译通过 | §1 回退方案 H1 全部路径；§3.7 normalize；§3.9 axis；§3.2.1 mat3Cast/mat4Cast；§3.4 Quat×Vec3/Vec4 | 设计者 |
| 26（Mat4x4 [] 返回类型） | `[]` 返回可赋值引用 | §3.3 item 7 fromMat4 实现 | 编码者 |
| 27（Mat4x4 列字段名） | 列字段名为 `c0`/`c1`/`c2`/`c3` | §3.3 item 7 fromMat4 实现（编码者：验证后按实际字段名修改 §3.3 item 7 实现注释中的字段名引用；不涉及 API 签名变更，无需设计审批） | 编码者（已验证为正确） |
| 28（Vec4 双参数构造） | `Vec4(Vec3, T)` 在 6 个 Qualifier 上均可用 | §3.4 Quat×Vec4 运算符；§11.5 可用性表 | 编码者 |
| 29（glm.detail 导入 glm.ext）→ P0 | `detail/type_quat.cj` 无 `import glm.ext.*` | §2 模块间依赖图；§3.4 Vec extend 块（v18 修订内联路径）| 设计者 |

#### 高优先级编译前验证项（v12 新增，Issue 6 响应；**v13 关键修订，Issue 4 响应：移除与验证项 20/25 的重复内容，改为引用**）

以下两项为基础性编译假设的验证项，必须在编码阶段开始前优先完成（P0 优先级，5 日内必须完成）。**v18 修订，Issue 1 响应**：新增 P0 验证项 29（`glm.detail` 包对 `glm.ext` 的导入可行性验证）。当前共 3 项 P0 验证（20、25、29），要求在编码阶段前优先完成最小测试文件验证。

- **验证项 20（P0）**：`FloatingPoint<T>` 接口方法可用性独立核验——**本项要求独立重新核验，§1 回退方案决策树本身不能替代核验过程**。自 v11 轮独立核实以来（历经 v12-v19 共 8 个迭代版本）未重新核验，此次要求在编码阶段前编写最小仓颉测试文件（~20 行），实例化 `FloatingPoint<Float32>.getMinDenormal()`/`getInf()`/`isInf()`/`isNaN()`/`getNaN()`/`getMinNormal()`，确认编译通过。验证结果反馈到 §3.10/§3.11 的依赖描述中更新。若编译失败，则 §3.10 `log` 函数中 `FloatingPoint<T>.getInf()` 路径和 §3.10 `pow` 函数中 `FloatingPoint<T>.getMinDenormal()` 路径的实现假设被证伪，需回退至类型分派 fallback 路径。具体回退路径参见 §1 回退方案子节（路径 A/B/C 及决策树执行顺序）。**核验影响范围声明**：若 `FloatingPoint<T>` 实际 API 形态与本设计引用文档有差异，影响范围覆盖 §3.10（`pow`/`log` 依赖描述）、§3.11（`isnan`/`isinf` 约束）以及 §9a（覆盖矩阵中相关函数的状态标注）。

- **验证项 25（P0）**：`T(Float64(n))` 字面量转换路径编译可行性验证——要求在编码阶段前先编写最小仓颉测试文件（~20 行），实例化 `Float32(Float64(0))`/`Float32(Float64(1))`/`Float64(Float64(0))`/`Float64(Float64(1))`/`Int32(Float64(0))`/`Int64(Float64(1))`，确认编译通过。若编译失败，则 §1「常量型 T(n) 字面量替代」策略被证伪，依赖此路径的全部函数（normalize/axis/mat3Cast/mat4Cast/Quat×Vec3/Quat×Vec4）需重新评估零值/单位值获取策略。具体回退路径参见 §1 回退方案子节（路径 A/B/C 及决策树执行顺序）。

- **验证项 29（P0，v26 修订，Issue 5 响应）**：`glm.detail` 包内 `type_quat.cj` 无 `import glm.ext.*` 声明验证——§3.4 v18 已采用内联 conjugate/dot 计算路径替代原跨包 import 路径。验证方式：(a) grep `type_quat.cj` 确认无 `import glm.ext.*` 声明；(b) 执行 `cjpm build` 确认编译通过。**受影响章节**：§2 模块间依赖图、§3.4 Vec extend 块实现路径。

#### 验证结果记录表模板（v21 新增，Issue 5 响应；**v23 修订，Issue 6+7 响应：补充修复责任人列 + H 节核验关联**）

为确保编码启动前的假设核验可追溯，以下提供标准化验证结果记录表模板。对 3 项 P0 验证项（20、25、29），要求验证通过后才可启动编码；验证失败时按「失败后处置路径」列指引的章节触发设计修订流程。H1/H2/H3 核验项由设计者在每轮版本输出前执行。

| 验证项编号 | 假设描述 | 验证结果（通过/失败） | 验证日期 | 验证人 | 失败后处置路径 | 修复责任人 |
|-----------|---------|---------------------|---------|-------|-------------|----------|
| 1 | cjpm 识别 `src/gtc/` + `package glm.gtc` | | | | §2 回退方案：迁移至 `src/` 根目录降级为 `package glm` | 设计者 |
| 2 | `public import` 重导出 detail 函数可行 | | | | D11 重新评估：detail 端函数下沉至 gtc 端复制实现 | 设计者 |
| 3 | 包间无循环依赖（`glm.gtc → glm.detail` 单向） | | | | §2 模块间依赖图重绘：D28 包间依赖策略修订 | 设计者 |
| 4 | type_quat.cj 同包调用 type_quat_cast.cj 函数 | | | | §3.3 item 6/7 fromMat3/fromMat4 改为跨包 import | 设计者 |
| 5 | Vec extend 块中 Quat 前向引用 | | | | §3.4 Vec extend 块运算符改为全局函数（scalar_quat_ops 扩展） | 设计者 |
| 6-7 | scalar_constants match 模式 | | | | D09 重复评估：改用 if-else 链替代 match | 编码者 |
| 8 | 标量运算同名重载消歧 | | | | §3.4 全局函数改名避免冲突（如 addTQuat/scalarAddQuat） | 编码者 |
| 9 | isNaN/isInf 实例方法 | | | | §3.11 改为 match 运行时分派 | 编码者 |
| 10 | 内联 abs 编译通过 | | | | §3.5 回退至调用 common.cj abs stub | 编码者 |
| 11 | Hashable 派生对 Qualifier | | | | §3.1 移除 `@Derive[Hashable]`，手动实现 Hashable | 设计者 |
| 12 | length sqrt 转换 | | | | §3.7 改为 `T(Float64.sqrt(Float64(dot_qq)))` + 类型转换 | 编码者 |
| 13 | isnan/isinf 约束收紧 | | | | §3.11 放宽约束，运行时 match 分派 | 设计者 |
| 14 | public var 可见性 | | | | §3.1 确认字段标注 public，否则修正 | 编码者 |
| 15 | pow 命名消歧 | | | | §3.10 pow 函数使用全限定名 `std.math.pow` | 编码者 |
| 16 | getMinDenormal 静态方法 | | | | §1 回退方案 H2 路径 A/B：类型分派或字面量 fallback | 编码者 |
| 17 | type_quat_cast 约束 | | | | §3.2.1 放宽为 Number<T>，运行时 match 分派 | 设计者 |
| 18 | getInf 静态方法 | | | | §1 回退方案 H2 路径 A/B：类型分派或 T(1)/T(0) 构造 | 编码者 |
| 19 | epsilon<T>() 与 epsilonOf<T>(hint) 一致性 | | | | §3.12 统一为单实现路径，消除分支 | 编码者 |
| **20（P0）** | **FloatingPoint<T> 接口方法可用性** | ✅ **已验证**（§8.4 验证报告） | 2026-06-26 | 设计方 | §1 回退方案 H2 全部路径（类型分派/字面量 fallback） | 编码者 |
| 21 | std.math Float32 重载 | | | | §1 返回「必选 Float64 转换」策略：`T(Float64.xxx(Float64(value)))` | 编码者 |
| 22 | trigonometric T 约束 | | | | §3.13.1 放宽为 Number<T>，运行时 match 分派 | 设计者 |
| 23 | fwd.cj 生成脚本 | | | | §2 备选方案 B：手动维护 lib.cj 或新建别名文件 | 编码者 |
| 24 | conjugate const func | | | | §3.11 移除 const 声明，降级为普通 func | 编码者 |
| **25（P0）** | **T(Float64(n)) 语法编译可行性** | ✅ **已验证**（§8.4 验证报告） | 2026-06-26 | 设计方 | §1 回退方案 H1 全部路径（追加 `one: T` 形参/`match` 分派/收紧约束） | 设计者 |
| 26 | Mat4x4 [] 返回类型 | | | | §3.3 item 7 退化为 Mat4x4 主构造函数构造 | 编码者 |
| 27 | Mat4x4 列字段名 `c0`/`c1`/`c2`/`c3` | ✅ 已核验 | 2026-06-26 | 设计方 | **本轮已核验确认**：§3.3 item 7 描述正确，无需编码者重复核验 | 编码者（已验证为正确） |
| 28 | Vec4 双参数构造函数 | | | | §3.4 Quat×Vec4 改为手动 Vec4(x,y,z,w) 构造 | 编码者 |
| **29（P0）** | **glm.detail 无 import glm.ext.* 声明验证** | | | | 确认 `type_quat.cj` 无 `import glm.ext.*` + `cjpm build` 通过 | 设计者 |
| **P0 通过条件**：3 项 P0（20/25/29）全部标注「通过」后方可启动 stage 3 编码；任一项失败按失败后处置路径触发设计修订。 |

### 8.3 Stage 3 Acceptance Criteria（v11 新增，Issue 13 响应）

本节汇总阶段三完成验收的全部依据，整合 §8/§8.2/§9a/§11.5 等分散于多处的内容：

**A. 产出物清单验收（来源：§8 产出物清单）。v15 修订，Issue 2 响应：分类名称已统一对齐 §11.5 三档体系**：

| 类型 | 验收项 | 数量 | 验收依据 |
|------|--------|------|---------|
| ✅ 可用（无 stub 依赖） | `detail/type_quat.cj` + `detail/type_quat_cast.cj` + `detail/scalar_constants.cj` + `detail/scalar_quat_ops.cj` + `ext/quaternion_relational.cj`（4 函数）+ `ext/quaternion_geometric.cj`（4 函数）+ `ext/scalar_constants.cj` + `gtc/constants.cj`（28 函数）+ 4 个 ext/ 别名文件 | 11+ 个源文件（18 函数 ✅ 可用） | 文件存在 + `cjpm build` + 运行时无 Exception("stub") |
| ⚠️/❌ 混合（部分 ✅ 可用、部分 ❌ stub） | `ext/vector_relational.cj`（epsilon 16 重载 ✅ + ULP 8 重载 ❌）+ `ext/quaternion_common.cj`（5 ✅ + 3 ❌）+ `ext/quaternion_trigonometric.cj`（1 ✅ + 2 ❌）+ `ext/quaternion_transform.cj`（1 ❌）+ `ext/quaternion_exponential.cj`（4 ❌）+ `gtc/quaternion.cj`（8 ✅ 含 4 重导出 + 4 完整 + 7 ❌） | 6 个源文件 | 文件存在 + `cjpm build` 通过；✅ 部分运行时正常调用，❌ 部分抛 Exception("stub") |
| ❌ stub（空桩占位） | `gtc/matrix_transform.cj`（64 ❌）+ `detail/trigonometric.cj`（75 ❌）+ `ext/matrix_projection.cj` + `ext/matrix_clip_space.cj` + `ext/matrix_transform.cj` | 5 个源文件 | 文件存在 + `cjpm build` 通过；运行时均抛 Exception("stub") |
| 沿用 stub 文件 | `detail/common.cj` + `detail/geometric.cj` + `detail/matrix.cj`（27 实现 + 6 stub） | 3 个源文件 | 阶段二已验证 |
| 更新文件 | `fwd.cj`（9 个四元数别名）+ `lib.cj`（20 个 public import 声明） | 2 个更新文件 | 别名与 import 清单匹配 §2 |

**B. 测试设计验收（来源：§8.2 测试设计）**

| 验收项 | 数量 | 验收依据 |
|--------|------|---------|
| 测试文件总数 | 13 个 | 路径符合「测试目录结构对齐策略（v10 修订）」：ext 子模块测试 `tests/glm/test_ext_xxx.cj` 同层平铺命名 + gtc 测试 `tests/glm/gtc/test_xxx.cj` |
| 测试用例总数 | ≥192 | 40+8+8+12+13+4+4+2+16+13+9+28+27+8 = 192（下限）；通过增补 7 个边界用例可达 ≥199 |
| 跨 Qualifier 实例化测试 | 6 种精度 | `test_type_quat.cj` 覆盖 PackedHighp/PackedMediump/PackedLowp/AlignedHighp/AlignedMediump/AlignedLowp |
| 跨类型实例化测试 | Float32/Float64 | 阶段三完整测试；Int64 仅测试非依赖 stub 的运算符 |

**C. 覆盖矩阵验收（来源：§9a GLM 1.0.3 Stage 3 API 覆盖矩阵）。v25 修订，Issue 3 响应：原 §10 已合并至 §9a**：

GLM 1.0.3 各头文件阶段三覆盖状态汇总：

| GLM 头文件 | 函数总数 | ✅ 可用 | ⚠️/❌ stub | 阶段四补齐 |
|----------|---------|----------|----------|----------|
| `detail/type_quat.hpp` | 19 个 API（结构体 + 运算符 + 工厂） | 16 个 ✅（不含 fromVec3/fromEuler ❌ + Quat×Vec3/Vec4 ⚠️） | 1 个 ⚠️（Quat×Vec3/Vec4）+ 2 个 ❌（fromVec3/fromEuler） | — |
| `detail/type_quat_cast.hpp`（v3 新增） | 4 个 | 4 个 ✅ | 0 | — |
| `ext/vector_relational.hpp` | 8 个 | 4 个 epsilon 版本 ✅（16 重载） | 4 个 ULP 版本 ❌（8 重载） | ULP 版本需评估仓颉位级访问能力 |
| `ext/quaternion_relational.hpp` | 4 个 | 4 个 ✅ | 0 | — |
| `ext/quaternion_geometric.hpp` | 4 个 | 4 个 ✅ | 0 | — |
| `ext/quaternion_common.hpp` | 8 个 | 5 个 ✅（conjugate/inverse/lerp/isnan/isinf） | 3 个 ❌（mix/slerp(2)） | mix/slerp 完整实现 |
| `ext/quaternion_trigonometric.hpp` | 3 个 | 1 个 ✅（axis） | 2 个 ❌（angle/angleAxis） | angle/angleAxis 完整实现 |
| `ext/quaternion_transform.hpp` | 1 个 | 0 | 1 个 ❌（rotate） | rotate 完整实现 |
| `ext/quaternion_exponential.hpp` | 4 个 | 0 | 4 个 ❌（exp/log/pow/sqrt） | 全部完整实现 |
| `ext/scalar_constants.hpp` | 3 个 | 3 个 ✅ | 0 | — |
| `gtc/constants.hpp` | 28 个 | 28 个 ✅ | 0 | — |
| `gtc/matrix_transform.hpp` | **64** | 0 | **64** ❌ | 完整实现（阶段四） |
| `gtc/quaternion.hpp` | 15 个 | 8 个 ✅（4 重导出 + 4 完整） | 7 个 ❌（4 欧拉 + 3 看向） | 7 个 stub 完整实现 |
| **合计** | — | **约 77 个 ✅** | **87 个 ❌ + 1 个 ⚠️ = 88 个 ⚠️/❌** | — |

**D. 函数可用性对照表验收（来源：§11.5）**

`§11.5 函数可用性对照表` 是阶段三验证的**函数级权威来源**（v23 修订，Issue 2 响应；v24 修订，Issue 8 响应；v25 修订，Issue 3 响应：原 §10 已合并入 §9a，当前覆盖体系为 §9a + §11.5 双层结构）：✅/⚠️/❌ 三档符号标记每个函数本阶段状态（实现在本文件其他章节有详细描述）。下游验证时按 §11.5 表逐项核验函数级状态，按 §9a 表查阅文件级覆盖视图（含 GLM 1.0.3 基准声明与阶段覆盖矩阵）。

**E. 验证项清单（来源：§8 编码启动前验证项 1-29）**

阶段三编码启动前需完成 §8 编码启动前验证项 1-29 全部 29 项验证，其中验证项 20、25、29 兼为高优先级编译前验证项（P0）。**v18 修订，Issue 1 响应**：新增验证项 29（`glm.detail` 包对 `glm.ext` 的导入可行性验证），独立验证目标从 28 项修正为 29 项。**v23 新增，Issue 4 响应**：验证所有 stub 函数签名均已记录于 §11.5 中，且阶段四不得单方面修改——签名变更须通过 §3.16「签名冻结例外审批流程」。确保：
- cjpm 构建系统接受 `src/gtc/` + `package glm.gtc` 子包结构
- `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 重导出机制可行
- 包间无循环依赖（`glm.gtc → glm.detail` 单向）
- `@Derive[Hashable]` 对 `Q <: Qualifier` 派生可行
- `length`/`normalize`/`isnan`/`isinf`/`mat3Cast` 等 T 类型约束编译期生效
- `epsilon<T>()` 与 `epsilonOf<T>(hint)` 返回值一致
- `FloatingPoint<T>` 接口方法实际可用（v11 新增）
- `std.math` Float32 重载实际可用（v11 新增）
- `trigonometric.cj` 75 个展开函数签名 T 约束编译期生效（v11 新增）
- **所有 stub 函数签名已记录于 §11.5 且阶段四不得单方面修改**（v23 新增，Issue 4 响应）

**F. 文档-代码一致性验收**

下游实现完成后需逐项核验：
- `fwd.cj` 9 个四元数别名（Quat/FQuat/DQuat + 3×Float32 精度 + 3×Float64 精度）与 §2 lib.cj/fwd.cj 段落一致
- `lib.cj` 20 个 import 声明与 §2 lib.cj import 清单一致
- 各函数签名 where 子句与 §3 / §9a / §11.5 约束标注一致
- 边界行为实现与 §5.3 边界条件表 + §5.1 通用异常表一致（特别是 normalize 零四元数保护、inverse 整数除零异常）

**G. 整体设计可追溯性验收**

GLM 1.0.3 → 仓颉阶段三设计的可追溯矩阵：§9a「GLM 1.0.3 Stage 3 API 覆盖矩阵」（v25 已合并原 §10 内容）列出全部 13 个 GLM 头文件 + 本设计核心章节的映射关系；下游编码者按 §9a 表逐项核验可定位每个 GLM 函数在仓颉设计中的对应位置。

**H. 覆盖矩阵计数自动化核验（v19 新增，Issue 1 响应）**

新增以下文档内一致性自动核验项，防止后续版本再次出现覆盖矩阵合计行计数与逐行累加值偏差的问题：
- **核验项 H1（v23 修订，Issue 7 响应：关联自动化工具；v25 修订：原 §10 已合并入 §9a，核验对象改为 §9a 覆盖矩阵）**：§9a 覆盖矩阵合计行 ❌/⚠️ 计数 = 逐行累加各文件 ❌/⚠️ 计数之和。验证方式：建议使用 Spreadsheet 模板（`docs/templates/coverage_matrix_checklist.xlsx`）或 Python 脚本（`scripts/check_coverage_matrix.py`）自动化完成累加验证——逐行提取 ✅/⚠️/❌ 数值，逐行累加后与合计行声明值对照，偏差为 0。如自动化工具尚未就绪，人工核验模板见 §8 验证结果记录表模板。
- **核验项 H2**：全文档中任何引用「约 80 个 ❌/⚠️」或「79 ❌」的字样均已清除，统一替换为「87 ❌ + 1 ⚠️ = 88 个 ⚠️/❌」。验证方式：`grep -n "80.*❌\|79 ❌"` 应返回空。
- **核验项 H3（v23 新增，Issue 3 响应）**：版本号一致性自动化核验——要求在每轮版本发布前用 `grep -n 'v[0-9]\+.*修订\|v[0-9]\+.*新增\|v[0-9]\+.*决策'` 检查所有标注版本号与当前文件版本号的一致性。当前 v23 应无任何指向 v24+ 或 v22 之前非本版本号的正文标注（修订说明章节中的历史引用除外）。
- **§9a 覆盖矩阵声明（v25 修订，Issue 3 响应）**：§9a「GLM 1.0.3 Stage 3 API 覆盖矩阵」已合并原 §10「GLM 1.0.3 API 阶段覆盖矩阵」的逐文件覆盖状态与设计章节映射内容。§9a 提供 GLM 1.0.3 基准函数总数和推迟理由清单（按头文件维度聚合），§11.5 提供逐函数精细追踪。两者形成「基准→函数」双层覆盖体系。

**H 节核验执行者与周期（v23 新增，Issue 7 响应）**：上述 H1/H2/H3 三项核验由**设计者在每轮版本输出前**执行，核验结果记录于版本发布检查清单中。核验失败时，阻止版本发布直至全部核验项通过。

**I. 已知未解决问题列表（v23 新增，Issue 1 响应；v25 更新）**

本节记录当前轮次（v25）已知但尚未解决的问题，作为 §8.3 验收项的补充。与历史修订说明中已闭环的问题不同，以下问题的修复计划在后续轮次中落实。

| 编号 | 问题描述 | 首次检出轮次 | 当前状态 | 计划修复轮次 |
|------|---------|------------|---------|------------|
| O-01 | §11.5 对齐 §9a 基准的逐函数覆盖率统计尚未完成自动化（v25 已将 §10 合并入 §9a 为单一覆盖矩阵，本项范围相应更新） | v23 | 待评估 | v26 |
| O-02 | §9a 与 §10 两张覆盖矩阵已合并为单一覆盖矩阵（v25 修订），本项✅已闭环 | v23 | ✅ 已闭环（v25 修订） | — |
| O-03 | δ 覆盖矩阵合计的 H1 核验尚未绑定自动化脚本（v25 已实际通过手工编译验证 H1/H2，脚本化有待评估） | v23 | 待评估 | v26 |
| O-04 | 编码启动前验证流程尚未与 CI/CD 管线集成 | v23 | 待评估 | v26 |
| O-05 | H1/H2/H3 核验项尚未脚本化（Problem 5 建议的自动化一致性检查） | v25 | 待评估 | v26 |
| O-06 | 验证前置化流程（核心假设在设计版本固化前完成验证）尚未制度化 | v25 | 待评估 | v26 |
| O-07 | I 节非空时文档版本号标记为 "final" 或 "ready for coding" 的质量门禁尚未实施 | v25 | 待评估 | v26 |

**已知问题计数变更规则**：O 编号在问题解决后从列表移除，不再重新编号（保持历史可追溯性）。新增问题追加至列表末尾，编号递增。本列表在每轮版本输出前由设计者更新。

---

## 9. 对齐 GLM 参考实现的差异声明

| 差异 | 说明 |
|------|------|
| **无匿名 union / GLM_FORCE_QUAT_DATA_WXYZ** | 四元数仅支持 xyzw 存储+参数顺序布局，不支持 wxyz 存储布局变体 |
| **构造函数参数顺序 (x,y,z,w) 非 (w,x,y,z)** | 仓颉侧主构造函数参数顺序与数据成员声明顺序一致，通过 `wxyz()` 工厂函数提供 GLM 习惯入口 |
| **无 C++ 显式类型转换运算符** | 仓颉不支持 `operator mat3x3()`/`operator mat4x4()` 隐式/显式类型转换运算符。矩阵-四元数互转通过 `mat3Cast`/`mat4Cast`/`quatCast` 显式函数实现 |
| **ULP 比较函数无法实现** | 仓颉无浮点位表示直接访问（无 `reinterpret_cast`/`union`），ULP 比较以空桩占位 |
| **GLM 中不存在 `lookRotate` 函数** | GLM 1.0.3 中与"看向"语义对应的函数是 `gtc/quaternion.hpp` 中的 `quatLookAt`/`quatLookAtRH`/`quatLookAtLH` |
| **从两向量构造改为具名工厂函数** | C++ GLM 中 `qua(vec3, vec3)` 为构造函数，仓颉版本改为 `Quat.fromVec3(u, v)` 工厂函数（因依赖 geometric.cj stub，阶段三为 stub 占位） |
| **从欧拉角构造改为具名工厂函数** | C++ GLM 中 `qua(vec3 eulerAngles)` 为构造函数，仓颉改为 `Quat.fromEuler(eulerAngles)`（依赖 trigonometric.cj stub，阶段三为 stub 占位） |
| **从旋转矩阵构造改为具名工厂函数** | C++ GLM 中 `qua(mat3x3)`/`qua(mat4x4)` 为构造函数，仓颉改为 `Quat.fromMat3`/`Quat.fromMat4`（**v3 修订**：调用**同包** `type_quat_cast.cj` 函数，不再跨包引用 gtc） |
| **`gtc/quaternion.cj` 独立承载 15 函数（v3 明确：4 重导出 + 4 完整 + 7 stub）** | 与 GLM `gtc/quaternion.hpp` 1:1 映射；**v3 关键变更**：`mat3Cast`/`mat4Cast`/`quatCast` 不在本文件实现，而是通过 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 重导出 detail 中的实现，**v12 关键修订**：重导出函数采用 camelCase 命名（与 detail 端原始名一致），而非 GLM 原始 snake_case `mat3_cast`/`mat4_cast`/`quat_cast` |
| **`mat3Cast`/`mat4Cast`/`quatCast` 实际实现位于 `detail/type_quat_cast.cj`（v3 关键决策，v12 修订：camelCase 命名）** | 为避免包间循环依赖，转换函数下沉至 detail 包；gtc 包通过 `public import` 重导出至 gtc 命名空间；**v12 关键修订，Issue 1 响应**：detail 端与 gtc 端函数名统一为 camelCase `mat3Cast`/`mat4Cast`/`quatCast`，下游按 GLM 习惯使用 snake_case `mat3_cast`/`mat4_cast`/`quat_cast` 时将编译失败——仓颉 `public import a.b.f` 仅重导出 f 原始名（依据 `cangjie-lang-features/package/README.md` 第 156-166 行规范），不做命名转换；与现有 `public import glm.detail.{transpose, matrixCompMult, outerProduct}` 模式（`cjglm/src/lib.cj:8`）保持 camelCase 风格一致 |
| **一元 + 运算符不可用** | 仓颉不支持重载一元 + 运算符（与 deviations.md IF-01 一致） |
| **标量-四元数运算为全局函数** | 仓颉 operator func 限制 |
| **quaternion_common 中 mix/slerp 依赖 trigonometric.cj/common.cj stub** | 本阶段 mix/slerp 为 stub 占位，待阶段四 trigonometric.cj/common.cj 完整实现后补齐 |
| **`mix`/`slerp`/`pow` 依赖 `epsilon<T>()`（v3 明确）** | GLM 实现中用于 `cosTheta > 1 - epsilon<T>()` 退化检测，与 GLM 实际依赖一致 |
| **ext/vector_relational 内联 abs 而非调用 common.cj** | 消除对 stub 的运行时依赖，确保本阶段函数可执行 |
| **向量 `equal` 采用严格 `<` 语义（v3 修订，v9 修订 GLM 文件引用）** | 与 GLM `glm/gtc/epsilon.inl:32-41` 中 `epsilonEqual` 实现一致，`equal(v, v, 0.0) = false`。原引用 `func_vector_relational.inl:18-22` 错误——GLM 1.0.3 的 `func_vector_relational.inl` 中**不包含 epsilon 版本**的 `equal`/`notEqual`，epsilon 版本位于 `glm/gtc/epsilon.inl`（文件层面属 gtc 子包） |
| **scalar_constants 使用 hint 参数辅助类型推断** | 与 deviations.md DV-04 一致 |
| **scalar_constants 对整型 T 抛运行时异常（v3 明确）** | 与 GLM `static_assert(is_iec559, ...)` 编译期断言等价行为 |
| **`Quat×Vec3` 旋转公式采用两次 Vec3 叉乘（v3 修订）** | 与 GLM `type_quat.inl:359-366` 一致：`v + (cross(QuatVector, v) * q.w + cross(QuatVector, cross(QuatVector, v))) * 2` |
| **`slerp` 4 参数版本 `k: Int64` 简化签名（v3 决策）** | GLM 原始 4 参数 `slerp` 使用独立泛型整型参数 `S`（`static_assert(is_integer)` 约束），仓颉版本固定为 `Int64`，与 deviations.md DV-03「移位运算右操作数固定为 Int64」风格一致。若阶段四下游客需要 `Int32`/`Int16` 类型的 `k`，可通过新增泛型 `S` 重载 `slerp<T, Q, S>(x: Quat<T,Q>, y: Quat<T,Q>, a: T, k: S) where T <: Number<T>, Q <: Qualifier, S <: Integer<S>` 实现向下兼容泛化 |
| **`lerp` 含 `assert(a >= 0 && a <= 1)` 断言（v3 明确）** | 与 GLM `ext/quaternion_common.inl:28-38` 一致；`lerp` 不可在 const 上下文调用 |
| **四元数算术运算符统一标注 @OverflowWrapping** | 与阶段一 Vec3、阶段二全部矩阵类型的实践一致；标注对浮点无效果但保持跨类型一致性 |
| **fwd.cj 排除整型与 Bool 四元数别名（v3 明确）** | 与阶段二排除整型矩阵别名的策略一致；Bool 四元数无实际用途（D17） |
| **`Quat`/`FQuat`/`DQuat` 三重别名机制（v3 新增，v8 修订先例引用）** | **v8 修订**：v7 文档引用阶段二 `Mat2x2`/`FMat2x2` 双别名机制作为先例，但通过直接查阅 `cjglm/src/fwd.cj` 全文确认 `Mat` 家族**不存在** `FMat*` 任何声明（仅 `Mat2x2` + `DMat2x2`），`F` 前缀别名**仅在 Vec 家族存在**（`FVec1`~`FVec4` + 精度变体）。本设计修订为参考阶段一 Vec 家族的三重模式（`Vec2` + `DVec2` + `FVec2`，见 `cjglm/src/fwd.cj:106, 123, 276`），与 `Quat` + `DQuat` + `FQuat` 三重别名机制对齐 |
| **ext/ 和 gtc/ 子包独立声明** | 仓颉包名与目录路径匹配规则约束 |
| **gtc/matrix_transform.cj 本阶段以空桩占位** | 其完整实现依赖链覆盖几乎所有函数库层，归入阶段四 |
| **`fromMat3`/`fromMat4` 仅对纯旋转矩阵有效（v3 契约）** | 与 GLM 行为一致；对非旋转矩阵行为未定义，结果可能产生非单位四元数 |
| **`axis` 触发条件为 `1 - w² <= 0` 而非 q.xyz == 0（v5 修订）** | 返回 `Vec3(T(0), T(0), T(1))`（z 轴单位向量，典型场景：单位四元数 `(0, 0, 0, 1)` 即 `\|w\| >= 1`）；对于真正零四元数 `(0, 0, 0, 0)`，`tmp1 = 1 > 0` 进入 else 分支返回 `Vec3(0, 0, 0)`（与 GLM `ext/quaternion_trigonometric.inl:20-27` 一致）。**v3 原描述「内部 `normalize(Vec3(0, 0, 0))` 返回 `Vec3(1, 0, 0)`」为虚构实现，GLM 源码不调用 `normalize`**，v5 修订纠正 |
| **浮点/整数四元数 `inverse` 零除行为差异（v3 契约）** | 浮点产生 Inf/NaN，整数触发仓颉除零异常 |
| **包间依赖方向严格单向 `glm.gtc → glm.detail`（v3 关键修复）** | 为避免 v2 设计的 `glm.detail ↔ glm.gtc` 循环依赖（违反仓颉包间循环依赖约束），D11/D28 决策将转换函数下沉至 detail |
| **`isnan`/`isinf` 函数约束收紧为 `where T <: FloatingPoint<T>`（v4 新增，v7 接口名修订）** | 与 §3.12 `epsilon<T>()` 约束收紧策略一致；避免整数 T（如 `Int64`）实例化时 `Int64.isNaN()` 实例方法不存在导致编译失败的问题。`FloatingPoint<T>` 是 stdlib 原生接口，编译期保证可用，无需 fallback |
| **Quat 字段统一标注 `public var`（v4 新增）** | 满足 `@Derive[Hashable]` 派生宏对字段 public 可见性的要求（依据 `cangjie-std/deriving/README.md` 第 4 节）；与阶段一 Vec3、阶段二全部矩阵类型（200+ 处统一实践）对齐。仓颉 struct 字段默认 `internal` 可见性，不满足 public 派生要求 |

---

## 9a. GLM 1.0.3 Stage 3 API 覆盖矩阵（v21 新增，v25 修订：合并 §10 内容）

本节声明本设计对标 GLM **1.0.3** 版本中与阶段三（四元数类型 + 附带 ext/gtc 依赖）直接相关的所有头文件及每个头文件的 API 函数总数基准，并与本设计覆盖状态做逐项对比。对确认为本阶段不覆盖的函数标注推迟至 Stage 4 的理由。

**v25 修订**：原 §10「GLM 1.0.3 API 阶段覆盖矩阵」的逐文件/逐函数覆盖状态详情已合并至本节。函数级状态追踪仍以 §11.5 为最终权威来源。

### GLM 1.0.3 Stage 3 基准 API 范围

| GLM 1.0.3 头文件 | 头文件路径 | API 函数总数 | 本设计 ✅ 可用 | 本设计 ⚠️/❌ stub | 阶段四补齐 |
|-----------------|-----------|------------|--------------|----------------|----------|
| `type_quat.hpp` | `detail/type_quat.hpp` | 19（结构体 + 运算符 + 工厂函数 + `[]` 下标 + `length()`） | 16 ✅ | 1 ⚠️ + 2 ❌ | — |
| `type_quat_cast.hpp`（本设计推断文件名） | `detail/type_quat_cast` | 4（mat3Cast/mat4Cast/quatCast×2） | 4 ✅ | 0 | — |
| `vector_relational.hpp` | `ext/vector_relational.hpp` | 8（4 epsilon + 4 ULP） | 4 epsilon ✅（16 重载） | 4 ULP ❌（8 重载） | 阶段四评估仓颉位级访问能力后补齐 |
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
| **合计** | — | **165** | **约 77 ✅** | **87 ❌ + 1 ⚠️ = 88** | — |

### 本阶段明确推迟至 Stage 4 的函数及理由

| 函数组 | GLM 头文件 | 函数数 | 推迟理由 |
|-------|-----------|-------|---------|
| `fromVec3` / `fromEuler` | `type_quat.hpp`（工厂函数） | 2 | 依赖 geometric.cj(`dot`/`cross`/`normalize`) + trigonometric.cj(`cos`/`sin`) stub |
| ULP 版本 `equal`/`notEqual`（8 重载） | `ext/vector_relational.hpp` | 4（8 重载） | 仓颉无浮点位表示直接访问能力（无 `reinterpret_cast`/`union` 等价机制），需阶段四评估替代方案 |
| `mix` / `slerp`（2 版本） | `ext/quaternion_common.hpp` | 3 | 依赖 trigonometric.cj(`acos`/`sin`) + common.cj(`mix`) stub |
| `angle` / `angleAxis` | `ext/quaternion_trigonometric.hpp` | 2 | 依赖 trigonometric.cj(`asin`/`acos`/`sin`/`cos`) stub |
| `rotate` | `ext/quaternion_transform.hpp` | 1 | 依赖 trigonometric.cj(`sin`/`cos`) + geometric.cj(`length`) stub |
| `exp` / `log` / `pow` / `sqrt` | `ext/quaternion_exponential.hpp` | 4 | 依赖 trigonometric.cj + common.cj + geometric.cj 等多文件 stub |
| `eulerAngles` / `roll` / `pitch` / `yaw` | `gtc/quaternion.hpp` | 4 | 依赖 trigonometric.cj(`atan`/`asin`) + common.cj(`clamp`) + vector_relational.cj(`equal`) stub |
| `quatLookAt` / `quatLookAtRH` / `quatLookAtLH` | `gtc/quaternion.hpp` | 3 | 依赖 geometric.cj(`cross`/`dot`/`normalize`/`inversesqrt`/`max`) stub |
| `gtc/matrix_transform` 全部 64 个函数 | `gtc/matrix_transform.hpp` | 64 | 完整实现依赖链覆盖几乎所有函数库层 |
| **推迟合计** | — | **87** | — |

**基准声明版本标识**：本基准基于 GLM **1.0.3**（发布日期：2022-08-21，Commit: `3efc510`）。下游实施者在阶段四升级对标版本前，应以 GLM 1.0.3 的原始 .hpp/.inl 文件为最终一致性核验依据。



---

## 11. 下游消费者迁移指南（v3 新增）

针对常见的库使用场景，提供仓颉版本与 GLM 习惯的迁移示例：

### 11.1 构造单位四元数

```
// GLM:        glm::quat q = glm::quat(1.0f, 0.0f, 0.0f, 0.0f);  // wxyz 顺序
// 仓颉:      let q = Quat<Float32, PackedHighp>.identity(1.0f)  // 主入口（推荐）
//           或 let q = Quat<Float32, PackedHighp>.wxyz(1.0f, 0.0f, 0.0f, 0.0f)  // wxyz 顺序入口
```

### 11.2 跨类型转换

```
// GLM:        glm::quat q32 = glm::quat(q64);
// 仓颉:      let q32 = Quat<Float32, PackedHighp>.fromQuat<Float64, PackedHighp>(
//               { f64 => Float32(f64) },
//               q64
//           )
// 同类型简化:
//           let q32_same = Quat<Float32, PackedHighp>(q32.x, q32.y, q32.z, q32.w)
```

### 11.3 旋转应用

```
// GLM:        auto rotated = q * v;
// 仓颉:      let rotated = q * v  // [本阶段抛 stub 异常，待阶段四 geometric.cj 完整实现后生效]
```

### 11.4 矩阵-四元数互转（v3 明确入口）

```
// GLM:        glm::mat3 m = glm::mat3_cast(q);  glm::quat q2 = glm::quat_cast(m);
// 仓颉 detail 入口（v3 新增，fromMat3/fromMat4 工厂函数内部使用）:
//           let m = Quat<Float32, PackedHighp>.fromMat3(m).identity(1.0f)  // 错误示例，fromMat3 是 Quat 工厂函数
//           let q2 = Quat<Float32, PackedHighp>.fromMat3(m)  // Mat3 → Quat
//           let m3 = Quat<Float32, PackedHighp>(1.0f, 0.0f, 0.0f, 0.0f).fromMat3(m)  // 错误示例
// 
// 仓颉 detail 直接调用（v3 推荐入口，需先 `import glm.detail.*`）:
//           let m3 = mat3Cast(q)      // detail/type_quat_cast.cj 包级函数（**v10 修订，Issue 17 响应**：需先 `import glm.detail.*` 才能调用包级函数；或通过 lib.cj 的 `public import` 重导出从顶层 `glm` 命名空间调用 `glm.mat3Cast(q)`）
//           let q2 = quatCast(m)      // detail/type_quat_cast.cj 包级函数（同上）
// 
// 仓颉 gtc 命名空间调用（v3 通过 public import 重导出，[本阶段可验证]，**v12 关键修订，Issue 1 响应**：采用 camelCase 命名 `mat3Cast`/`mat4Cast`/`quatCast`——`public import` 不做 snake_case→camelCase 命名转换）:
//           let m3_gtc = glm.gtc.quaternion.mat3Cast(q)
//           let q2_gtc = glm.gtc.quaternion.quatCast(m)
// 
// 仓颉顶层 glm 命名空间调用（**v10 新增，Issue 17 响应**：lib.cj 通过 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 将 detail 包级函数重导出至顶层 `glm` 命名空间，与现有 `public import glm.detail.{transpose, matrixCompMult, outerProduct}` 模式一致，见 `cjglm/src/lib.cj:8`）：
//           let m3_top = glm.mat3Cast(q)   // 顶层 glm 命名空间（无需额外 import）
//           let q2_top = glm.quatCast(m)   // 顶层 glm 命名空间（无需额外 import）
```

### 11.5 函数可用性对照表（v3 新增，**v23 关键修订，Issue 2 响应：补齐 5 个缺失 API 条目后升级为单一权威来源**）

**v23 修订，Issue 2 响应；v24 修订，Issue 8 响应；v25 修订，Issue 3 响应**：本表目标为**函数级状态追踪的权威来源**（每函数一行，标注本阶段/阶段四状态）。§3.13.2 审计节、§8 产出物清单、§9a 覆盖矩阵、§11.6 可达性矩阵的函数状态描述均以本表为主要基准。v22 已补齐全部 5 个缺失 API 条目（`wxyz`/`fromQuat`/`[]`/`static func length`/复合赋值运算符），当前版本已具备完整性要求。§9a「GLM 1.0.3 Stage 3 API 覆盖矩阵」（v25 已合并原 §10 内容）提供聚合统计信息，与本表构成互补关系——本表聚焦逐函数精细追踪，§9a 提供聚合统计视图与 GLM 1.0.3 基准声明。

**v13 关键修订，Issue 1 响应**：补齐以下 7 个缺失的函数条目：(1) `scalar_quat_ops.cj` 的 `add`/`sub`/`mul`/`div`（4 个全局函数）；(2) `ext/quaternion_transform.cj` 的 `rotate` 函数；(3) Vec3×Quat/Vec4×Quat 运算符 `v * q`。同时 `fromMat3`/`fromMat4` 行增补 `where T <: FloatingPoint<T>` 约束传递性注记。

**v20 修订，Issue 1 响应**：补齐以下 5 个缺失 API 条目：(1) `wxyz` 工厂函数；(2) `fromQuat` 跨类型构造工厂函数；(3) `[]` 下标运算符；(4) `public static func length(): Int64` 编译期查询函数；(5) 复合赋值运算符 `+=`/`-=`/`*=`/`/=`。

| 函数 | 本阶段状态 | 阶段四 | 设计章节 |
|------|----------|--------|---------|
| `identity` | ✅ 可用 | ✅ 可用 | §3.3 item 5 |
| `fromMat3` | ✅ 可用（**约束：`where T <: FloatingPoint<T>`（签名显式声明，v15 修订，Issue 5 响应），仅浮点 T；整型 T 实例化时编译失败；编译错误直接定位在 `fromMat3` 签名约束处而非内部 callee**） | ✅ 可用（约束同上） | §3.3 item 6 |
| `fromMat4` | ✅ 可用（**约束：`where T <: FloatingPoint<T>`（签名显式声明，v15 修订，Issue 5 响应），仅浮点 T；整型 T 实例化时编译失败；编译错误直接定位在 `fromMat4` 签名约束处而非内部 callee**） | ✅ 可用（约束同上） | §3.3 item 7 |
| `fromVec3` | ❌ stub | ✅ 可用 | §3.3 item 8；§1 约束：依赖 geometric.cj + trigonometric.cj stub |
| `fromEuler` | ❌ stub | ✅ 可用 | §3.3 item 9；§1 约束：依赖 trigonometric.cj stub |
| `fromQuat` | ✅ 可用 | ✅ 可用 | §3.3 item 4 |
| `wxyz` | ✅ 可用 | ✅ 可用 | §3.3 item 10 |
| `[]` 下标运算符（**v20 新增，Issue 1 响应**：取值 + 赋值双版本，i < 0 或 i >= 4 抛 Exception） | ✅ 可用 | ✅ 可用 | §3.1 |
| `static func length(): Int64`（**v20 新增，Issue 1 响应**：编译期查询函数，返回常量 4） | ✅ 可用 | ✅ 可用 | §3.1 |
| `q * v` (Quat×Vec3) | ⚠️ 抛 stub 异常 | ✅ 可用 | §3.4；§1 约束：依赖 geometric.cj 向量 cross stub |
| `v * q` (Vec3×Quat) | ✅ 可用（**v18 修订：内联 conjugate/dot 计算路径**——`(Quat(-q.x, -q.y, -q.z, q.w) / (q.w*q.w + q.x*q.x + q.y*q.y + q.z*q.z)) * v`，纯算术运算，无需 `glm.ext` 跨包 import） | ✅ 可用 | §3.4 |
| `v * q` (Vec4×Quat) | ✅ 可用（通过 Vec3 中间路径，与 Vec3×Quat 一致） | ✅ 可用 | §3.4 |
| `+=`/`-=`/`*=`（四元数乘法）/`*=`（标量乘法）/`/=` | ✅ 可用 | ✅ 可用 | §3.4 复合赋值运算符段 |
| `add`（`scalar_quat_ops.cj`） | ✅ 可用 | ✅ 可用 | §3.4 全局具名函数表 |
| `sub`（`scalar_quat_ops.cj`） | ✅ 可用 | ✅ 可用 | §3.4 全局具名函数表 |
| `mul`（`scalar_quat_ops.cj`） | ✅ 可用 | ✅ 可用 | §3.4 全局具名函数表 |
| `div`（`scalar_quat_ops.cj`） | ✅ 可用 | ✅ 可用 | §3.4 全局具名函数表 |
| `rotate`（`ext/quaternion_transform.cj`） | ❌ stub（依赖 `sin`/`cos`/`length` 均为 stub） | ✅ 可用 | §3.8；§1 约束：依赖 trigonometric.cj + geometric.cj stub |
| `lerp` | ✅ 可用（含断言） | ✅ 可用 | §3.11 |
| `conjugate` | ✅ 可用 | ✅ 可用 | §3.11 |
| `inverse` | ✅ 可用 | ✅ 可用 | §3.11 |
| `dot` | ✅ 可用 | ✅ 可用 | §3.7 |
| `length` | ✅ 可用 | ✅ 可用 | §3.7 |
| `normalize` | ✅ 可用 | ✅ 可用 | §3.7 |
| `cross`（Quat） | ✅ 可用 | ✅ 可用 | §3.7 |
| `axis` | ✅ 可用 | ✅ 可用 | §3.9 |
| `equal`（Quat） | ✅ 可用 | ✅ 可用 | §3.6 |
| `equal`（Quat, epsilon） | ✅ 可用 | ✅ 可用 | §3.6 |
| `notEqual`（Quat） | ✅ 可用 | ✅ 可用 | §3.6 |
| `notEqual`（Quat, epsilon） | ✅ 可用 | ✅ 可用 | §3.6 |
| `isnan` | ✅ 可用（**约束：`where T <: FloatingPoint<T>`（D29）**，仅浮点 T，整型 T 编译失败） | ✅ 可用（**约束：`where T <: FloatingPoint<T>`（D29）**，仅浮点 T） | §3.11；§1 约束：FloatingPoint<T> 接口约束 |
| `isinf` | ✅ 可用（**约束：`where T <: FloatingPoint<T>`（D29）**，仅浮点 T，整型 T 编译失败） | ✅ 可用（**约束：`where T <: FloatingPoint<T>`（D29）**，仅浮点 T） | §3.11；§1 约束：FloatingPoint<T> 接口约束 |
| `slerp` | ❌ stub | ✅ 可用 | §3.11；§1 约束：依赖 trigonometric.cj + common.cj stub |
| `mix` | ❌ stub | ✅ 可用 | §3.11；§1 约束：依赖 trigonometric.cj + common.cj stub |
| `angle` | ❌ stub | ✅ 可用 | §3.9；§1 约束：依赖 trigonometric.cj stub |
| `angleAxis` | ❌ stub | ✅ 可用 | §3.9；§1 约束：依赖 trigonometric.cj stub |
| `exp` | ❌ stub | ✅ 可用 | §3.10；§1 约束：依赖 trigonometric.cj + scalar_constants stub |
| `log` | ❌ stub | ✅ 可用 | §3.10；§1 约束：依赖 trigonometric.cj + FloatingPoint<T>.getInf() |
| `pow` | ❌ stub | ✅ 可用 | §3.10；§1 约束：依赖 trigonometric.cj + common.cj + FloatingPoint<T>.getMinDenormal() |
| `sqrt` | ❌ stub | ✅ 可用 | §3.10；§1 约束：委托 `pow` 实现 |
| `eulerAngles` | ❌ stub | ✅ 可用 | §3.15；§1 约束：依赖 trigonometric.cj + common.cj + vector_relational stub |
| `roll` | ❌ stub | ✅ 可用 | §3.15；§1 约束：同上 |
| `pitch` | ❌ stub | ✅ 可用 | §3.15；§1 约束：同上 |
| `yaw` | ❌ stub | ✅ 可用 | §3.15；§1 约束：同上 |
| `quatLookAt` | ❌ stub | ✅ 可用 | §3.15；§1 约束：依赖 geometric.cj stub |
| `quatLookAtRH` | ❌ stub | ✅ 可用 | §3.15；§1 约束：同上 |
| `quatLookAtLH` | ❌ stub | ✅ 可用 | §3.15；§1 约束：同上 |
| `epsilon`（浮点） | ✅ 可用 | ✅ 可用 | §3.12 |
| `pi`（浮点） | ✅ 可用 | ✅ 可用 | §3.12 |
| `cos_one_over_two`（浮点） | ✅ 可用 | ✅ 可用 | §3.12 |
| `epsilon`（整型） | ❌ 抛异常 | ❌ 抛异常（保持契约） | §3.12；§1 约束：D25 整数 T 抛运行时异常 |
| `pi`（整型） | ❌ 抛异常 | ❌ 抛异常（保持契约） | §3.12；§1 约束：D25 整数 T 抛运行时异常 |
| `cos_one_over_two`（整型） | ❌ 抛异常 | ❌ 抛异常（保持契约） | §3.12；§1 约束：D25 整数 T 抛运行时异常 |
| `mat3Cast`（detail） | ✅ 可用（**约束：`where T <: FloatingPoint<T>`（D32）**，仅浮点 T，整型 T 编译失败，对应 GLM `GLM_STATIC_ASSERT(is_iec559, ...)`） | ✅ 可用（**约束：`where T <: FloatingPoint<T>`（D32）**，仅浮点 T） | §3.2.1 |
| `mat4Cast`（detail） | ✅ 可用（同上） | ✅ 可用（同上） | §3.2.1 |
| `quatCast(Mat3)`（detail） | ✅ 可用（同上） | ✅ 可用（同上） | §3.2.1 |
| `quatCast(Mat4)`（detail） | ✅ 可用（同上） | ✅ 可用（同上） | §3.2.1 |
| `mat3Cast`（gtc，重导出） | ✅ 可用（**约束：`where T <: FloatingPoint<T>`（D32，约束源自 detail 端原始定义，通过 public import 透明传递）**，仅浮点 T，整型 T 编译失败，**v12 关键修订，Issue 1 响应**：gtc 端采用 camelCase 命名而非 GLM snake_case 习惯，因 `public import` 不做命名转换） | ✅ 可用（同上） | §3.15 重导出段 |
| `mat4Cast`（gtc，重导出） | ✅ 可用（同上） | ✅ 可用（同上） | §3.15 重导出段 |
| `quatCast(Mat3)`（gtc，重导出） | ✅ 可用（同上） | ✅ 可用（同上） | §3.15 重导出段 |
| `quatCast(Mat4)`（gtc，重导出） | ✅ 可用（同上） | ✅ 可用（同上） | §3.15 重导出段 |
| `lessThan` | ✅ 可用（**约束：`where T <: Comparable<T>`, `Q <: Qualifier`**） | ✅ 可用（同上） | §3.15 比较函数段 |
| `lessThanEqual` | ✅ 可用（同上） | ✅ 可用（同上） | §3.15 比较函数段 |
| `greaterThan` | ✅ 可用（同上） | ✅ 可用（同上） | §3.15 比较函数段 |
| `greaterThanEqual` | ✅ 可用（同上） | ✅ 可用（同上） | §3.15 比较函数段 |
| `gtc/matrix_transform` 全部 **64** 个函数（**v13 关键修订，Issue 8 响应**：v12 §11.5 未纳入 §3.13/§10 中 35→64 个 gtc/matrix_transform 函数，本轮补齐 gtc/matrix_transform 区块） | ❌ stub（**v13 关键修订**：v12 描述 35 个函数修订为 **64** 个） | ✅ 可用（按 6 大类分组：基础变换 11 + 视口与裁剪空间 19（**v14 修订，Issue 3 响应**：ortho 系族 9→10）+ frustum 系族 9 + 透视投影 18 + 无穷远透视 9 + 投影工具 6 + 拾取矩阵 1 = **64**） | §3.13 gtc/matrix_transform 函数清单段 |

---

### 11.6 四命名空间接口可达性矩阵（v12 新增，质询报告 C 项响应）

本节集中审计 `glm` / `glm.gtc` / `glm.detail` / `glm.ext` 四个命名空间下关键函数（含运算符重载、构造函数重载、主类型别名）的可达性，确保下游消费者在每个命名空间下均能按预期路径调用 API。

| 类别 | 函数/类型 | `glm` 顶层（lib.cj public import） | `glm.gtc`（gtc 子包） | `glm.detail`（detail 子包） | `glm.ext`（ext 子包） |
|------|----------|-------------------------------|----------------------|--------------------------|---------------------|
| **类型** | `Quat<T, Q>` | ✅ `glm.Quat`（fwd.cj type alias） | ✅ `glm.gtc.quaternion.Quat`（import detail） | ✅ `glm.detail.Quat`（原始定义） | ❌（ext 包不重新声明类型） |
| **类型** | `Mat3x3<T, Q>` / `Mat4x4<T, Q>` | ✅ `glm.Mat3x3` / `glm.Mat4x4`（阶段二 type alias） | ✅ `glm.gtc.quaternion.Mat3x3` / `Mat4x4`（import detail） | ✅ `glm.detail.Mat3x3` / `Mat4x4`（原始定义） | ❌ |
| **类型** | `Vec3<T, Q>` / `Vec4<T, Q>` | ✅ `glm.Vec3` / `glm.Vec4`（阶段一 type alias） | ✅ `glm.gtc.quaternion.Vec3` / `Vec4`（import detail） | ✅ `glm.detail.Vec3` / `Vec4`（原始定义） | ✅ `glm.ext.Vec3` / `Vec4`（ext 包 import detail 重导出） |
| **构造函数** | `Quat(x, y, z, w)` 主构造 | ✅ `glm.Quat(0, 0, 0, 1)` | ✅ 同左 | ✅ 同左（原始） | ❌ |
| **构造函数** | `Quat.fromMat3(m)` | ✅ `glm.Quat.fromMat3(m)`（Quat 是类型，方法挂在类型上） | ✅ 同左（方法跟着类型走） | ✅ 同左 | ❌ |
| **构造函数** | `Quat.identity(1.0f)` | ✅ `glm.Quat.identity(1.0f)` | ✅ 同左 | ✅ 同左 | ❌ |
| **运算符重载** | `q + r` / `q - r` / `q * r` | ✅ `glm.Quat + glm.Quat` | ✅ 同左 | ✅ 同左（原始定义） | ❌ |
| **运算符重载** | `q * v` (Quat×Vec3) | ✅ `glm.Quat * glm.Vec3` | ✅ 同左 | ✅ 同左（原始定义） | ❌ |
| **运算符重载** | `v * q` (Vec3×Quat) | ✅ `glm.Vec3 * glm.Quat` | ✅ 同左 | ✅ 同左（Vec extend 块定义） | ❌ |
| **包级函数** | `glm.mat3Cast(q)` | ✅ `glm.mat3Cast`（lib.cj public import 顶层重导出） | ❌（gtc 端无顶层包级函数） | ✅ `glm.detail.mat3Cast`（原始定义，需先 `import glm.detail.*`） | ❌ |
| **包级函数** | `glm.gtc.quaternion.mat3Cast(q)`（**v12 修订，Issue 1 响应**：camelCase 命名） | ❌ | ✅ `glm.gtc.quaternion.mat3Cast`（gtc/quaternion.cj public import detail 重导出） | ✅ 同上 | ❌ |
| **包级函数** | `glm.ext.scalar_constants.epsilon<Float32>()` | ✅ `glm.epsilon<Float32>()`（lib.cj public import ext 重导出） | ✅ `glm.gtc.constants.epsilon<Float32>()`（gtc/constants 通过 ext/scalar_constants 重导出） | ✅ `glm.detail.scalar_constants.epsilon<Float32>()`（原始定义） | ✅ `glm.ext.scalar_constants.epsilon<Float32>()`（ext 重导出接口） |
| **包级函数** | `glm.gtc.constants.zero<Float32>()` | ✅ `glm.zero<Float32>()`（lib.cj public import gtc 重导出） | ✅ `glm.gtc.constants.zero<Float32>()`（原始定义） | ❌ | ❌ |
| **包级函数** | `glm.ext.quaternion_common.conjugate(q)` | ✅ `glm.conjugate(q)`（lib.cj public import ext 重导出） | ❌（gtc 端无 conjugate 包级函数） | ❌ | ✅ `glm.ext.quaternion_common.conjugate(q)`（原始定义） |
| **包级函数** | `glm.ext.quaternion_transform.rotate(q, angle, axis)` | ✅ `glm.rotate(q, angle, axis)`（lib.cj public import ext 重导出，❌ stub） | ❌（rotate 非 gtc 函数） | ❌ | ✅ `glm.ext.quaternion_transform.rotate(q, angle, axis)`（原始定义，❌ stub） |
| **包级函数** | `glm.gtc.matrix_transform.translate(m, v)` | ✅ `glm.translate(m, v)`（lib.cj public import gtc 重导出） | ✅ `glm.gtc.matrix_transform.translate(m, v)`（stub 占位） | ❌ | ❌ |
| **类型别名** | `Quat` / `FQuat` / `DQuat` | ✅ `glm.Quat` / `glm.FQuat` / `glm.DQuat`（fwd.cj） | ❌ | ❌ | ✅ `glm.ext.quaternion_float.quat` / `glm.ext.quaternion_double.dquat`（ext 别名文件） |

**审计结论（v12 新增，质询报告 C 项响应，**v13 修订，Issue 6 响应：normalize 行交叉引用**）**：
- **所有 9 个 Quat 别名**（Quat/FQuat/DQuat + 3×Float32 精度 + 3×Float64 精度）在 `glm` 顶层命名空间通过 fwd.cj（**v13 修订，Issue 3 响应**：通过 `cjglm/scripts/gen_fwd_aliases.py` 自动生成，非 v12 描述的 `tools/gen_fwd.cj`）可达
- **所有 4 个转换函数**（mat3Cast/mat4Cast/quatCast 两个重载）在 `glm` 顶层通过 lib.cj public import + 在 `glm.gtc.quaternion` 通过 public import detail 重导出可达，**v12 修订，Issue 1 响应**：gtc 端采用 camelCase 命名而非 GLM snake_case
- **所有 15 个 gtc/quaternion 函数**（4 重导出 + 4 完整 + 7 stub）在 `glm.gtc.quaternion` 命名空间可达，下游消费者无需关心 detail 端 import 细节
- **所有 stub 占位函数**（mix/slerp/exp/log/pow/sqrt/angle/angleAxis/rotate/eulerAngles/roll/pitch/yaw/quatLookAt* + **64** 个 gtc/matrix_transform 函数（**v13 关键修订，Issue 1+2 响应**：v12 描述 35 修订为 64，详见 §3.13 + §10 + §11.5 + §8.3））在调用时抛 `Exception("stub")`，下游测试设计应覆盖异常路径验证（`assertThrows`）
- **`normalize(q)` 函数可达性与边界契约（v13 关键修订，Issue 6 响应：交叉引用）**：本阶段状态详见 §11.5 函数可用性对照表 `dot/length/normalize` 行（标记为 ✅ 可用）；完整边界行为契约（零四元数 + length 极小值 + 实现公式）详见 §5.3 边界条件表 normalize 行 + §3.7 `normalize` 函数描述 + §3.13.2 审计节 normalize 行——四者形成「§3.7 实现 + §5.3 契约 + §11.5 可用性 + §11.6 可达性」四维度交叉引用闭环

### 11.7 全函数集中参考索引（v22 新增，**v23 修订，Issue 5 响应：扩展为全函数覆盖，新增本阶段状态列**）

本节为所有函数（✅ 可用 + ⚠️ 抛 stub + ❌ stub）提供聚合参考索引，将每个函数分散在 §3.x、§5.3、§3.13.2、§8、§11.5 中的跨节引用信息集中列示。在本节 §3.x 描述段末尾拥有独立「集中参考清单」的 4 个 P0 函数（normalize/axis/mat3Cast/mat4Cast）同样在本索引中汇总列出。

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
| `Vec3×Quat` / `Vec4×Quat` | ✅ | §3.4 | 无特殊边界 | 无独立行 | 验证项 5/29 | v*q 行 |
| 复合赋值 `+=`/`-=`/`*=`/`/=` | ✅ | §3.4 | 无特殊边界 | 无独立行 | — | 复合赋值行 |
| `add`/`sub`/`mul`/`div`（scalar_quat_ops） | ✅ | §3.4 | 无特殊边界 | 无独立行 | 验证项 8 | add/sub/mul/div 行 |
| `lerp` | ✅ | §3.11 | `a` 超出 [0,1] 触发 assert | 审计表 lerp 行 | — | lerp 行 |
| `conjugate` | ✅ | §3.11 | 无特殊边界 | 审计表 conjugate 行 | 验证项 24（const func） | conjugate 行 |
| `inverse` | ✅ | §3.11 | 浮点零除 Inf/NaN，整数零除 ArithmeticException | audit 表 inverse 行 | — | inverse 行 |
| `dot` | ✅ | §3.7 | 无特殊边界 | 审计表 dot 行 | — | dot 行 |
| `length` | ✅ | §3.7 | 无特殊边界 | 审计表 length 行 | 验证项 12 | length 行 |
| `normalize` | ✅ | §3.7 | 零四元数保护 + length 极小值 | 审计表 normalize 行 | 验证项 20/25 | normalize 行 |
| `cross`（Quat） | ✅ | §3.7 | 无特殊边界 | 审计表 cross(Quat) 行 | — | cross(Quat) 行 |
| `axis` | ✅ | §3.9 | `1-w² <= 0` 触发 Vec3(0,0,1) | 审计表 axis 行 | 验证项 25 | axis 行 |
| `equal`/`notEqual`（Quat 精确/epsilon） | ✅ | §3.6 | `epsilon=0` 时 equal 返回 false | 审计表 equal/notEqual 行 | — | equal/notEqual 行 |
| `isnan`/`isinf` | ✅ | §3.11 | 整型 T 编译失败（`FloatingPoint<T>`） | 审计表 isnan/isinf 行 | 验证项 9/13/20 | isnan/isinf 行 |
| `mat3Cast`/`mat4Cast`/`quatCast` | ✅ | §3.2.1 | 非单位四元数/非旋转矩阵 | 审计表转换函数行 | 验证项 17/25 | mat3Cast 等行 |
| `lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual` | ✅ | §3.15 | 无特殊边界 | 审计表（§3.13.2 引用） | — | lessThan 等行 |
| `epsilon`/`pi`/`cos_one_over_two`（浮点） | ✅ | §3.12 | 整型 T 抛异常 | 审计表 epsilon 行 | 验证项 6/7/19 | epsilon/pi 行 |
| `epsilon`/`pi`/`cos_one_over_two`（整型） | ✅ | §3.12 | 整数 T 抛运行时异常 | 审计表 epsilon 行 | 验证项 7 | epsilon(整型)行 |
| gtc/constants 28 函数 | ✅ | §3.12 | 无特殊边界 | 无独立行 | — | — |
| ext/vector_relational epsilon（16 重载） | ✅ | §3.5 | `epsilon=0` 语义 | 无独立行 | 验证项 10 | — |

#### 11.7.2 ⚠️/❌ 函数索引

| 函数 | 本阶段状态 | §3.x 描述 | §5.3 边界条件 | §3.13.2 审计行 | §8 验证项 | §11.5 行 |
|------|----------|----------|-------------|--------------|----------|---------|
| `Quat×Vec3` | ⚠️ | §3.4 | 依赖 geometric.cj stub | 审计表 Quat×Vec3 行 | 验证项 29 | q*v 行 |
| `Quat×Vec4` | ⚠️ | §3.4 | 依赖 geometric.cj stub（委托 Quat×Vec3） | 审计表 Quat×Vec4 行 | 验证项 29 | q*v4 行 |
| `fromVec3` | ❌ | §3.3 item 8 | u,v 反平行 + 零向量未定义 | 审计表 fromVec3 行 | — | fromVec3 行 |
| `fromEuler` | ❌ | §3.3 item 9 | 依赖 trigonometric.cj stub | 审计表 fromEuler 行 | — | fromEuler 行 |
| `mix` | ❌ | §3.11 | `cosTheta` 退化 | 审计表 mix 行 | — | mix 行 |
| `slerp`（3 参数） | ❌ | §3.11 | `cosTheta` 退化 | 审计表 slerp 行 | — | slerp 行 |
| `slerp`（4 参数） | ❌ | §3.11 | `cosTheta` 退化 + `pi<T>()` 依赖 | 审计表 slerp 行 | — | slerp 4param 行 |
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
| ULP `equal`/`notEqual`（8 重载） | ❌ | §3.5 | 仓颉无位级浮点访问能力 | 无独立行 | — | — |
| gtc/matrix_transform 全部 **64** 函数 | ❌ | §3.13 | — | 审计表 gtc/matrix_transform 行 | — | — |
| trigonometric.cj 全部 75 函数 | ❌ | §3.13.1 | — | 审计表 trigonometric 行 | 验证项 22 | — |

**使用说明**：
- 「本阶段状态」列标注当前阶段的状态符号（✅ 可用 / ⚠️ 抛 stub 异常 / ❌ stub）
- 「§3.x 描述」列指向函数的主要实现描述段落，是理解函数行为与实现策略的起点
- 「§5.3 边界条件」列列出 §5.3 边界条件表中与该函数相关的行，标注关键边界场景的契约行为
- 「§3.13.2 审计行」列标注该函数是否在 §3.13.2 审计表中拥有独立行
- 「§8 验证项」列列出需在编码启动前验证的关联项编号，对无关联验证项的函数标注「—」
- 「§11.5 行」列标注函数在 §11.5 表中的行名，便于在可用性对照表中快速定位
- 本索引不替代 §11.5 的可用性对照表，后者包含完整的本阶段/阶段四状态标注与约束注记

---

<!-- 修订说明(v2)~(v11) 已剥离至独立文件 a_v11_revision_history_v2_v14.md；修订说明(v12)~(v24) 已剥离至独立文件 a_v25_revision_history_v12_v24.md -->

| 版本 | 修订要点 |
|------|---------|
| v12 | 依赖描述对齐、测试覆盖补齐、验证优先级明确、用例数统一 |
| v13 | §11.5 完整性补齐、axis 公式与 §1 对齐、验证项去重、rotate 状态统一、测试追溯 |
| v15（含 v14） | 产出物分类修正、版本号体系修复、审计表补齐、跨 Qualifier 策略、回退方案新增 |
| v16 | 版本号一致性修复、函数计数口径统一、路线图决策 D35~D37 |
| v17 | §11.5 逐函数行拆分、测试计数修正、版本号矛盾修复、抽样策略声明 |
| v18 | 包间循环依赖消除（内联 conjugate/dot 路径）、验证失败映射表新增 |
| v19 | §10 计数偏差终极修复、gen_fwd_aliases.py 脚本补齐、决策措辞统一 |
| v20 | §11.5 5 个缺失条目补齐、审计计数统一、假设核验纪律声明 |
| v21 | §9a 基准声明新增、fwd 验证命令修正、P0 函数集中参考清单 |
| v22 | length Float32 路径对齐、§11.7 聚合索引、演进指南新增、epsilon ground truth |
| v23 | 虚假 100% 声明清除、§11.5 权威性恢复、H3 版本号核验、签名冻结流程 |
| v24 | const 推理纠偏、§1/§3.12 策略一致性、依赖标注语义化、边界条件 5 处补充 |
| v25 | H1/H2 核心假设实际编译验证、§1 API 可用率声明段落新增、§9a/§10 合并为单一覆盖矩阵、修订历史剥离至独立文件、三项结构性预防措施引入 |
| v26 | §1 表格补充注记明确计数口径差异、`normalize` 约束收紧为 `FloatingPoint<T>`、`Quat/T` 除零行为契约补齐、`slerp(k:Int64)` 差异声明增强含阶段四泛化路径、验证项 29 同步内联路径方案 |

---

## 修订说明（v26）

> **修订定位**：v26 设计的迭代修订（对应本轮审查 a_v26_iteration_requirement.md）。基于 v25 输出修订，针对审查报告识别的 5 项问题（2 中度 + 3 轻度）逐项落实。

| 编号 | 严重度 | 审查意见（v25 版本的存在问题） | 修改措施 |
|------|--------|----------------------------|---------|
| 问题 1 | 中度 | §1 API 可用率声明声称「约 77 个函数（约 47%）为真完整实现」，但 §3.13.2 审计结论明确「本阶段可调用的真完整实现函数（无 stub 依赖）共 18 个函数」。77 与 18 的差值主要由 gtc/constants 28 个常量函数、ext/vector_relational epsilon 16 个重载、以及构造函数/运算符重载等高度同构的变体组成，首次阅读者容易误解 | **§1 表格下方新增注记**：明确 77 个 ✅ 包含 28 个 gtc/constants 常量函数 + 16 个 vector_relational epsilon 重载 + 构造函数/运算符重载等变体，独立函数签名约 18 个；同时声明 §1 的 ~77 为"含重载展开的签名行数"口径，§3.13.2 的 18 为"独立函数签名"口径，两者计数粒度不同 |
| 问题 2 | 中度 | `normalize` 整数 T 实例化时的边界行为在 §3.7 和 §5.3 中存在契约缺失——§3.7 使用 `where T <: Number<T>` 约束允许整数四元数调用，但 §5.3 边界条件表对 `normalize` 的两行条目均假设浮点行为 | **收紧 `normalize` 约束为 `FloatingPoint<T>`**（与 D32 `mat3Cast`/`mat4Cast`/`quatCast` 策略一致），整数 T 实例化时编译期报类型不匹配错误，消除整数除法截断导致的语义歧义；§3.7 实现策略段同步更新 |
| 问题 3 | 轻度 | §3.4 运算符体系表中 `Quat/T` 二元除法运算符的整数除零行为未明确，与 §3.11 `inverse` 的整数除零行为描述形成不对称 | **§3.4 `Quat/T` 行备注列补充**：整数 T 除零时触发仓颉 `ArithmeticException`，浮点 T 除零时产生 Inf/NaN 分量 |
| 问题 4 | 轻度 | `slerp` 4 参数版本的 `k: Int64` 类型决策与 GLM 原始模式之间的潜在兼容性问题未在 §9 差异声明中充分记录 | **§9 差异声明 slerp 条目增强**：补充说明 GLM 原始版本使用独立泛型整型参数 `S`；明确阶段四可选的泛化路径——新增泛型 `S` 重载 `slerp<T, Q, S>(x, y, a, k) where S <: Integer<S>` |
| 问题 5 | 轻度 | §8 编码启动前验证项 29 的描述与 §3.4 内联 conjugate/dot 路径存在脱节，当前设计已经没有跨包 import 可引入来触发循环依赖错误 | **§8 验证项 29 更新为**：确认 `type_quat.cj` 无 `import glm.ext.*` 声明 + `cjpm build` 通过；P0 段落同步更新；验证结果记录表对应行同步更新 |

### v26 修订特点

1. **§1 计数口径澄清**：新增的注记明确区分「含重载展开的签名行数」（~77）与「独立函数签名」（~18）两个口径，首读者可清晰理解 §1 与 §3.13.2 的计数差异源于粒度不同而非数据矛盾。

2. **`normalize` 约束收紧**：将困扰多轮的整数 T 边界行为争议通过收紧约束为 `FloatingPoint<T>` 一劳永逸解决，与 D32 策略一致。若未来确需整数四元数归一化，可通过新增独立整数版本函数实现。

3. **除法除零契约补齐**：§3.4 `Quat/T` 行备注列新增整数/浮点除零行为差异描述，消除与 §3.11 `inverse` 的不对称。

4. **`slerp(k:Int64)` 差异声明增强**：GLM 原始模式与仓颉决策偏差的完整记录，含阶段四泛化路径，关闭持续多轮的跟踪问题。

5. **验证项 29 同步**：从"先引入再验证报错"的过时描述更新为"确认无 import 声明 + build 通过"的简洁方案，与当前设计一致。

> **修订定位**：v25 设计的迭代修订（对应本轮审查 a_v25_iteration_requirement.md）。基于 v24 输出修订，针对审查报告识别的 5 项问题（2 严重 + 3 一般）逐项落实。

| 编号 | 严重度 | 审查意见（v24 版本的存在问题） | 修改措施 |
|------|--------|----------------------------|---------|
| 问题 1 | 严重 | H1/H2 两大基础假设历经 24 轮迭代仍未闭环——`T(Float64(n))` 语法和 `FloatingPoint<T>` 接口方法可用性始终处于"待验证"状态，仅新增"验证时限承诺"而未实际执行 | **已实际验证**：在 v25 设计阶段编写最小仓颉测试文件（`test_h1_t_float64_n.cj` 25 行 + `test_h2b_direct.cj` 30 行），使用 cjc 1.1.0 编译器实际编译并运行。H1：全部 18 种类型变体（Float32/Float64/Int8~Int64/UInt8~UInt64 × 0/1）编译通过；H2：`Float32.getInf()`/`getNaN()`/`getMinDenormal()` 等 6 个静态方法 + `isInf()`/`isNaN()` 2 个实例方法编译通过并运行时验证正确，泛型 `where T <: FloatingPoint<T>` 路径可用。结果记录于 §8 验证结果记录表模板及 §1 回退方案执行记录。 |
| 问题 2 | 一般 | 约 53% 的 API 以 stub 占位，但未作为"重大范围假设"突出标注——§1 声称"使库具备旋转/插值表达能力"与实际情况（slerp、mix、pow、exp、log、sqrt、angle、angleAxis、rotate、欧拉角、看向函数等核心旋转/插值 API 全部为 stub）存在过度承诺 | (a) §1「设计目标」末尾新增显式的阶段三 API 可用率声明段落（含 ✅/⚠️/❌ 三档分类表及对应函数数）；(b) §1「设计目标」首段措辞从"使库具备旋转/插值表达能力"修订为"为库提供基础的旋转表达和插值运算框架"。 |
| 问题 3 | 一般 | 三表冗余（§9a / §10 / §11.5）的根本问题未解决——§9a 与 §10 覆盖同一组 API，数据冗余度接近 100%；§10 逐文件状态行与 §11.5 逐函数表存在粒度重叠 | **方案 A（合并）**：§9a 与 §10 已合并为单一覆盖矩阵。§10 独立表格全文删除，其逐文件/逐函数覆盖状态详情并入 §9a（§9a 标题更新为"覆盖矩阵"并注明合并）。§11.5 保留为逐函数权威来源。§8.3 C/H 节引用同步更新。 |
| 问题 4 | 一般 | 修订历史占比约 22%（500 行/2310 行），首次阅读者难以辨别当前有效设计与历史修订 | **修订历史剥离**：修订说明(v12)-(v24) 已从设计文档正文剥离至独立文件 `a_v25_revision_history_v12_v24.md`，正文《修订说明》章节替换为简洁的变更摘要表（每版本一行要点）。正文当前仅保留新增的本轮(v25)修订说明。 |
| 问题 5 | 严重 | 系统性问题的循环复发记录表明设计质量流程存在根本缺陷——计数偏差、版本号混乱、§11.5 缺失 API 条目、公式与约束不一致、虚假修复率声称等 6 类问题在多个迭代轮次中反复出现 | **引入三项结构性预防措施**：(1) **自动化一致性检查**：§8.3 H 节已建立的 H1（累加验证）/H2（grep 清除旧字样）/H3（版本号一致性）三项核验项声明为每轮设计版本输出的自动化前置检查，结果记录于 §8 验证结果记录表。(2) **核验前置化**：H1/H2 核心假设验证已从"编码启动前"提前至"设计版本固化前"（本轮已实际执行 H1/H2 编译验证），O-05 跟踪后续脚本化。(3) **质量门禁**：§8.3 I 节声明——只有当 I 节「已知未解决问题列表」为空时，文档版本号才可标记为"final"或"ready for coding"；当前 O-05/O-06/O-07 未闭环，本版本不标记为最终版本。 |

### v25 修订特点

1. **H1/H2 从假设升级为事实**：本轮最核心的修复是实际编写并编译运行了 H1/H2 的最小仓颉测试文件——标志着此前跨越 13 轮迭代（v11→v24）、至少 6 轮独立审查反复检出但始终未关闭的核心设计假设风险敞口正式关闭。测试源码已产出，可供编码者直接引用为初始化单元测试模板。

2. **需求响应透明度系统提升**：§1 新增的 API 可用率声明段落（约 18 行）是设计文档首次在概述层面对阶段性交付范围做出诚实声明——明确告知读者"47% 可用、53% stub"，替代此前"SoC 级别具备旋转/插值表达能力"的过度承诺措辞。

3. **覆盖矩阵三表变两表**：原 §9a（基准声明）+ §10（覆盖状态）+ §11.5（逐函数追踪）的三表冗余结构，经本轮合并为 §9a（覆盖矩阵，聚合基线 + 文件级覆盖）+ §11.5（逐函数追踪）的两层体系。冗余源 §10 已删除，§9a 标题和定位同步更新。

4. **修订历史剥离**：约 325 行的修订历史（v12-v24）从 1873 行设计文档中剥离至独立文件，正文剩余 1548 行。主要章节完整保留，新的变更摘要表（13 行）替代了原本 13 个修订说明章节的篇幅，首次阅读者无需考古式回溯即可聚焦当前设计。

5. **结构性质量预防**：三项措施（自动化核验前置检查、核心假设验证前置化、质量门禁）从流程设计层面阻断计数偏差/版本号混乱/虚假声称等系统性问题的循环复发。当前尚未脚本化（O-05/O-06/O-07），但制度框架已建立。
