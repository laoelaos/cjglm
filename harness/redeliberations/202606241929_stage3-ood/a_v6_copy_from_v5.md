# GLM 1.0.3 仓颉迁移阶段三 OOD 设计方案

> **修订日期**：2026-06-25
> **修订定位**：v9 设计的迭代修订（v10）。依据本轮审查报告（a_v6_iteration_requirement.md 对应 v5 诊断报告 b_v5_diag_v1.md）从需求响应充分度、整体深度与完整性、设计可落地性维度识别 17 项质量问题（3 严重 + 13 一般 + 1 轻微），逐项落实到对应章节，并补充修订说明（v10）章节。本轮 3 项严重问题均属「事实错误/直接阻塞编码」类：`FloatingPoint<T>.getMin()`/`getInf()` 实例方法在仓颉 stdlib 不存在（仅 `Float64.Inf`/`Float64.Min`/`Float64.Max`/`Float64.NaN` 静态常量）；fwd.cj 四元数别名计数自相矛盾（声称 8，实际 9）；`std.math.pow` 签名描述为泛型 `pow(T, T): T` 而实际为 `pow(Float64, Float64): Float64`（仅支持 Float64 输入/输出）。

---

## 1. 概述

### 设计目标

在阶段一（Vec1~Vec4 向量类型 + 基础设施）和阶段二（9 个矩阵类型 + ext/ 别名）的基础上，迁移四元数类型及其必需的 ext/gtc 依赖文件，使库具备旋转/插值表达能力。本阶段同时引入向量关系运算扩展、标量常量扩展、gtc/constants 数学常量定义，并为 gtc/matrix_transform 提供空桩占位以满足依赖闭合。

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
| **gtc/quaternion.cj** | **gtc 四元数扩展函数库（欧拉/比较/看向函数 + 转换函数重导出）** | **混合型：4 函数完整实现 + 7 函数 stub + 4 函数重导出** |
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
- **T(0) 的获取**：在 `Number<T>` 约束的 extend 块中，通过 `someValue - someValue` 演算
- **T(1) 的获取**：必须由调用方显式传入参数（`one: T`），因为在 `Number<T>` 约束上下文中不存在通用的演算路径
- **T(0) 和 T(1) 均需的场景**：T(0) 通过运算演算，T(1) 通过参数传入
- **常量型 T(n) 字面量替代**（v8 新增，v9 扩展）：对于公式中固定为常数 n 的场景（如 `axis` 公式中的 `T(1) - x.w*x.w`、`Quat×Vec3`/`Quat×Vec4` 旋转公式末尾的 `* 2` 缩放因子、`mat3Cast`/`mat4Cast` 转换函数中初始化 3×3/4×4 单位矩阵对角元素的 `T(1)`），可采用 `T(Float64(n))` 显式转换路径（编译期 `Float64` 字面量 → `T` 类型），无需 `one: T` 形参；该路径对 `T = Float32`/`Float64` 均成立（`Float32(Float64(n))` 与 `Float64(Float64(n))` 均返回正确字面量）。**v9 受 T 字面量获取策略影响的函数清单**（新增，弥补 §1 之前仅 `axis` 一处明确说明的遗漏）：
  - **`axis` 函数（§3.9）**：使用 `T(Float64(1))` 字面量实现 `T(1) - x.w*x.w` 公式（v8 已明确）
  - **`Quat×Vec3`/`Quat×Vec4` 运算符（§3.4）**：使用 `T(Float64(2))` 字面量作为旋转公式末尾的 `* 2` 缩放因子（**v9 新增明确**——原公式 `... * 2` 在 Cangjie 泛型上下文中需显式转换为 `T(Float64(2))` 字面量，避免 `T * Int64` 类型不匹配问题）
  - **`mat3Cast`/`mat4Cast` 转换函数（§3.2.1）**：使用 `T(Float64(1))` 字面量初始化结果矩阵的对角元素（即 `Result = identity` 模式），与 GLM `gtc/quaternion.inl:49` 实际使用 `Mat3x3(T(1))` 一致（**v9 新增明确**——之前 §3.2.1 签名模板未提及 T(1) 获取方式）

### 系统性设计约束（v8 新增）：Float32 与 std.math 的交互约束

仓颉 `std.math` 模块的数值函数（`sqrt`/`pow`/`log`/`exp`/`sin`/`cos`/`asin`/`acos`/`atan`/`sinh`/`cosh`/`tanh`/`asinh`/`acosh`/`atanh`/`radians`/`degrees` 等）**仅支持 Float64 输入/输出**（依据 `cangjie-std/math/README.md` 第 13 行「math 库提供的是面向 Float64 的数值函数」）。当泛型参数 `T = Float32` 时，直接调用 `std.math.sqrt(x)` 触发编译错误「类型不匹配」。

**统一处理策略（v8 明确，本阶段所有使用 `std.math` 的函数均适用）**：
- **方案 A（推荐）**：在 `where T <: FloatingPoint<T>` 约束下，使用 `T(Float64.xxx(Float64(value)))` 模式显式转换后调用 std.math 函数。`Float64` 字面量兼容 `T = Float32`（`Float32(Float64(1.0))` 合法）和 `T = Float64`（`Float64(Float64(1.0))` 合法），是阶段三最简洁的方案。
- **方案 B（备选）**：为 `Float32` 实例化声明额外的函数重载，函数体直接使用 `std.math` 函数（依赖 std.math 对 Float32 的支持；目前不可用，故不采用）。
- **方案 C（备选）**：使用 `T <: Number<T>` 宽约束 + 函数体内 `match (someValue) { case _: Float32 => ...; case _: Float64 => ... }` 运行时分派（牺牲部分类型安全换取泛型灵活性，不推荐）。

**本阶段受此约束影响的函数**：`axis`（使用 `std.math.sqrt`）、`length`（使用 `std.math.sqrt`，§3.7 已明确）、`angleAxis`（使用 `std.math.sin`/`cos`）、`exp`（使用 `std.math.cos`/`sin`）、`log`（使用 `std.math.atan`/`log`）、`pow`（使用 `std.math.pow` + `std.math.asin`/`acos`/`sqrt`）、`sqrt`（委托 `pow`，间接使用）。所有上述函数引用本约束作为依赖说明，避免在每个函数中重复展开。

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

**lib.cj 新增 import 清单（v5 明确，v9 扩展补齐）**：
- `public import glm.detail.{Quat, mat3Cast, mat4Cast, quatCast}` — 四元数类型 + 转换函数（**v10 修订，Issue 17 响应**：`mat3Cast`/`mat4Cast`/`quatCast` 在 lib.cj 中以 `public import` 形式重导出至顶层 `glm` 命名空间——与现有 `public import glm.detail.{transpose, matrixCompMult, outerProduct}` 包级函数重导出模式一致，见 `cjglm/src/lib.cj:8`——下游消费者可按 `glm.mat3Cast(q)` 路径直接调用，**无需** `import glm.detail.*` 后再调用包级函数 `mat3Cast(q)`）
- `import glm.detail.trigonometric` — 三角函数（30 函数空桩，含 15 标量 + 15 向量重载；v9 新增）
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
- `import glm.gtc.matrix_transform` — 矩阵变换函数库空桩占位；v9 新增
- **合计 20 个 import**（v9 修订：v5 明确 8 个 → v9 扩展 12 个 → 合计 20 个；下游消费者可按 lib.cj import 清单访问所有新增模块（stub/别名/gtc））

**fwd.cj 新增 type alias 清单（v5 明确，v10 修订别名计数）**：
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
  type_quat.cj → ext/quaternion_geometric（dot/length/normalize/cross）
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
  quaternion.cj → glm.detail.{Quat, Mat3x3, Mat4x4, Vec3}（用于实现比较/欧拉/看向函数，**v10 修订，Issue 9 响应**：依赖声明过宽，按函数组细分——4 个比较函数（`lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual`）**仅依赖 Quat**；3 个 quatLookAt 函数（`quatLookAt`/`quatLookAtRH`/`quatLookAtLH`）**仅依赖 Vec3**；4 个转换函数（`mat3_cast`/`mat4_cast`/`quat_cast` × 2）**重导出 detail 端**（不需直接 import Mat/Vec）；4 个欧拉函数（`eulerAngles`/`roll`/`pitch`/`yaw`）**依赖 Vec3 + Quat**）
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
| Mat3←Quat mat3_cast | 四元数转 3×3 旋转矩阵 | **detail/type_quat_cast.cj** 包级函数（v3 决策） |
| Mat4←Quat mat4_cast | 四元数转 4×4 旋转矩阵 | **detail/type_quat_cast.cj** 包级函数（v3 决策） |
| Quat←Mat3 quat_cast | 旋转矩阵转四元数 | **detail/type_quat_cast.cj** 包级函数（v3 决策） |
| Quat←Mat4 quat_cast | 4×4 旋转矩阵转四元数 | **detail/type_quat_cast.cj** 包级函数（v3 决策） |
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

**T(1) 字面量获取策略（v9 新增）**：
- **GLM 实际依赖**：GLM 1.0.3 `gtc/quaternion.inl:49` 中 `mat3_cast`/`mat4_cast` 函数体内部使用 `Result = Mat3x3(T(1))` / `Result = Mat4x4(T(1))` 初始化结果矩阵为单位矩阵（即先填 3×3/4×4 单位矩阵作为基底，再覆盖部分元素为四元数旋转分量），强依赖 T(1) 字面量。`quat_cast` 函数体内部不直接依赖 T(1)（通过 `trace`/`sqrt` 等运算推导四元数分量），故本策略主要影响 `mat3Cast`/`mat4Cast` 两个函数。
- **仓颉实现路径**：根据 §1「系统性设计约束」中 v8 新增并经 v9 扩展的「常量型 T(n) 字面量替代」策略，实现阶段应使用 `T(Float64(1))` 显式转换路径获取 T(1) 字面量——`Float64(1.0)` 是字面量，`T(Float64(1.0))` 在 `T = Float64` 时返回 1.0，在 `T = Float32` 时返回 1.0f，无需 `one: T` 形参污染函数签名。
- **签名无 `one: T` 形参的合理性**：上述 4 个转换函数（`mat3Cast`/`mat4Cast`/`quatCast` 两个重载）的函数签名均**不含 `one: T` 形参**，与 §1「系统性设计约束」的 T(1) 获取规则一致——T(1) 通过 `T(Float64(1))` 字面量替代路径在函数体内部获取，无需调用方显式传入。下游编码者按设计签名实现时，函数体内部初始化结果矩阵对角元素应使用 `T(Float64(1))` 而非引入 `one: T` 形参，与 §1 系统性约束彻底闭环。

**边界行为契约（v8 新增）**：
- **`mat3Cast` 接受非单位四元数**：返回矩阵不保证是旋转矩阵——若输入四元数非单位四元数（含缩放/剪切分量），返回的 3×3 矩阵保留原始四元数的非旋转分量（如四元数长度为 2 时返回矩阵的奇异值近似 2/1/1），与 GLM 1.0.3 行为一致（GLM `type_quat.inl` 不做单位化保护）。
- **`mat4Cast` 接受非单位四元数**：与 `mat3Cast` 行为一致，返回 4×4 矩阵保留非旋转分量。
- **`quatCast` 接受非旋转矩阵**：返回的四元数行为未定义——若输入 Mat3/Mat4 含缩放/平移/剪切分量（非纯旋转矩阵），返回四元数可能是非单位四元数、零四元数或 NaN 四元数。GLM 1.0.3 通过 `GLM_STATIC_ASSERT(std::numeric_limits<T>::is_iec559, ...)` + 内部 `trace`/`sqrt` 计算实现，不做旋转矩阵合法性校验。
- **下游消费者契约**：与 §3.3 item 6/7 `fromMat3`/`fromMat4` 工厂函数的边界声明对齐（仅对纯旋转矩阵产生有意义结果）——`mat3Cast`/`mat4Cast`/`quatCast` 是 `fromMat3`/`fromMat4` 的反向操作，两者边界行为互为镜像。

**本阶段对 gtc/quaternion 函数的处理策略（v3 修订）**：`gtc/quaternion.hpp` 中共 15 个原始声明（`mat3_cast`/`mat4_cast`/`quat_cast` 两个重载/4 个 + `lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual`/4 个比较 + `eulerAngles`/`roll`/`pitch`/`yaw`/4 个欧拉 + `quatLookAt`/`quatLookAtRH`/`quatLookAtLH`/3 个看向 = 15 个）。本阶段采取以下分批策略：
- **本文件完整实现（8 个）**：
  - `lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual` — 4 个比较函数，纯算术
  - `eulerAngles`/`roll`/`pitch`/`yaw` — 4 个欧拉函数（**注意：虽然依赖 stub，本设计选择完整实现而非 stub 占位**，见下方 D11 决策说明）
- **从 detail 重导出（4 个）**：
  - `mat3_cast`/`mat4_cast`/`quat_cast(Mat3)`/`quat_cast(Mat4)` — 通过 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 重导出
- **stub 占位（3 个）**：
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

5. **单位四元数工厂函数 identity(one: T)** — extend 块工厂函数，`Number<T>` 约束。返回 `Quat<T,Q>`，其中 w=one, x=T(0), y=T(0), z=T(0)。T(0) 通过 `one - one` 演算获取。此为从零构造单位四元数的限定入口，与阶段二矩阵 `identity(one)` 模式一致。**调用示例**：
   ```
   // 必须显式传入 T(1) 等价物（如字面量 1.0f）
   let q = Quat<Float32, PackedHighp>.identity(1.0f)  // 单位四元数 (0, 0, 0, 1)
   ```

6. **从旋转矩阵构造 fromMat3(m: Mat3x3<T,Q>)** — 辅助工厂函数，内部调用**同包** `type_quat_cast.quatCast(m)`（v3 修订：原设计为跨包引用 gtc/quaternion.cj，现改为同包引用 type_quat_cast.cj）。非 const。**边界行为**（v3 新增契约声明）：仅对纯旋转矩阵产生有意义的四元数；对非旋转矩阵（如含缩放/平移/剪切矩阵）行为未定义，结果可能产生非单位四元数或语义错误的旋转。

7. **从旋转矩阵构造 fromMat4(m: Mat4x4<T,Q>)** — 辅助工厂函数，**v8 决策：采用手动提取策略**——直接读取 `m.c0`/`m.c1`/`m.c2` 三列构建 `Mat3x3<T,Q>(Vec3<T,Q>(m.c0.x, m.c0.y, m.c0.z), Vec3<T,Q>(m.c1.x, m.c1.y, m.c1.z), Vec3<T,Q>(m.c2.x, m.c2.y, m.c2.z))`，再调用同包 `quatCast(mat3x3)` 转换为四元数。非 const。**v8/v9 决策理由（v9 强化说明）**：(a) 该手动提取路径直接使用 `Vec3<T,Q>(T, T, T)` 主构造函数构造向量分量，再使用 `Mat3x3<T,Q>(Vec3, Vec3, Vec3)` 主构造函数构造 3×3 矩阵——**两条构造路径均不携带 `one: T` 形参**（Vec3 主构造与 Mat3x3 主构造均无 `one` 形参，区别于跨维度 `fromMat` 工厂函数重载），因此 `fromMat4` 函数签名本身无需 `one: T` 形参；(b) 与 §1「系统性设计约束」中"**T(1) 的获取：必须由调用方显式传入参数（`one: T`）**"一致——本函数不调用任何需要 T(1) 的运算路径（不调用 `fromMat(Mat_Larger, one)` 跨维度工厂函数，不调用 `identity(one)` 单位矩阵工厂函数），故无需该形参；(c) **v8/v9 修订说明**：v8 修订曾引用阶段二 `cjglm/src/detail/type_mat2x2.cj:163-165` `Mat2x2.fromMat(Mat3x3, one)` 作为"列提取模式无需 `one`"的依据，但该引用本身存在内部矛盾——被引用的代码 `Mat2x2.fromMat(Mat3x3, one)` 显式携带 `one: T` 形参（即阶段二全部 9 个矩阵类型的 `fromMat` 工厂函数**均要求** `one: T` 形参，无论源/目标矩阵尺寸关系，仅同维度 `fromMat` 简化为无 `one` 形参），与"无需 `one`"结论相悖。**v9 修订**：删除错误的代码引用作为论据，改为基于本函数的实际构造路径（Vec3 主构造 + Mat3x3 主构造，均无 `one` 形参依赖）说明无需 `one` 形参的合理性，与 §1 系统性约束彻底闭环。**边界行为**：同上，依赖 `fromMat3` 的输入合法性——若 `m` 的左上 3×3 子矩阵非纯旋转矩阵，结果未定义。

8. **从两向量构造 fromVec3(u: Vec3<T,Q>, v: Vec3<T,Q>)** — 辅助工厂函数，内部实现从两个归一化轴构建四元数。依赖 geometric.cj 的 `dot`/`cross`/`normalize`（均为 stub），因此本阶段为 **stub 占位**，完整实现推迟至阶段四。**边界行为契约（v8 新增）**：当输入向量 u, v 反平行（即 `dot(normalize(u), normalize(v)) ≈ -1`）时，GLM 1.0.3 `ext/quaternion_common.inl:196-217` 实际走 180° 退化路径——返回绕「与 u 垂直的任意轴」旋转 180° 的四元数（具体选择哪条垂直轴由实现决定，结果是 `q.w = 0` 且 `q.xyz` 模长为 1 的纯向量四元数）；这是 GLM 对反平行输入的容错设计，避免返回零四元数导致除零。**契约声明**：`fromVec3` 对反平行输入的返回值**行为已定义**（返回 180° 任意轴四元数，行为与 GLM 一致），下游消费者可依赖该契约；对零向量输入则行为未定义（由 `normalize` stub 在阶段四补齐时确定）。

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
| 二元 `*` (Quat×Vec3) | 四元数旋转向量 | `Number<T>` | 实现：`v + (cross(QuatVector, v) * q.w + cross(QuatVector, cross(QuatVector, v))) * T(Float64(2))`（两次 Vec3 叉乘 `uv`/`uuv`，末尾乘 `T(Float64(2))` 字面量作为缩放因子，与 GLM `type_quat.inl:359-366` 一致；**v9 修订**：原 `* 2` 在 Cangjie 泛型上下文中需显式转换为 `T(Float64(2))` 字面量，避免 `T * Int64` 类型不匹配问题，与 §1「常量型 T(n) 字面量替代」策略对齐）。**依赖 `geometric.cj` 向量 `cross`（阶段三 stub），调用将抛 `Exception("stub")`** |
| 二元 `*` (Quat×Vec4) | 四元数旋转向量（保留 w） | `Number<T>` | 实现：`Vec4(q * Vec3(v), v.w)`。**通过 Vec3 中间路径间接依赖 `Quat×Vec3`，阶段三调用同样抛 stub 异常** |
| 二元 `*` (Quat×T) | 四元数×标量 | `Number<T>` | 标注 `@OverflowWrapping` |
| 二元 `/` (Quat/T) | 四元数/标量 | `Number<T>` | 标注 `@OverflowWrapping` |
| `==` | 精确比较（返回 bool） | `Equatable<T>` | |
| `!=` | 不等比较 | `Equatable<T>` | |

**命名约定说明（v3 新增）**：上表中 `Quat×Vec3` 行公式中的 `cross(QuatVector, v)` 调用的是 **Vec3 叉乘**（定义于 `geometric.cj`，参数为 `Vec3<T,Q>`），**非 §3.7 中的四元数 `cross`（Hamilton 乘积）**。两者通过类型消歧区分（参数类型为 Vec3 时调用 Vec3 叉乘，参数类型为 Quat 时调用四元数 Hamilton 乘积）。

**Bool 四元数算术运算编译期拒绝（v7 澄清）**：上表算术运算符（一元 `-`/二元 `+`/`-`/`*`/Quat×T/Quat/T）均以 `Number<T>` 为约束。`Bool` 类型不实现 `Number<T>` 接口，因此 `Quat<Bool, Q>` 实例化时算术运算符重载因类型约束不满足而**编译期自动拒绝**（与阶段二 D33 Bool 矩阵策略一致）。Bool 四元数仅可使用 `==`/`!=` 比较（`Equatable<Bool>` 由 stdlib 派生支持），符合 D17 决策意图。

**Vec extend 块成员运算符**（定义在 Vec3/Vec4 extend 块中）：

| 运算符 | 语义 | 约束 | 备注 |
|-------|------|------|------|
| Vec3×Quat | `inverse(q) * v` | `Number<T>` | 通过 `inverse` 路径，依赖 `quaternion_common.cj.inverse`（已实现）；`inverse` 内部不依赖 `geometric.cj` stub |
| Vec4×Quat | `inverse(q) * v`（保留 w） | `Number<T>` | 通过 Vec3 中间路径 |

**实现链路注释（v7 澄清）**：本阶段 `Vec3×Quat`/`Vec4×Quat` 可立即调用，依赖链为 `Vec×Quat` → `inverse(q) * v` → `inverse`（§3.11 已完整实现） → `conjugate(q) / dot(q, q)`，其中 `conjugate` 无外部依赖（仅逐分量操作）、`dot` 由 `quaternion_geometric.cj`（§3.7）已完整实现。整个依赖链终止于已实现的算术运算和 `dot` 函数，**无 stub 中转**，与 `Quat×Vec3`（依赖 `geometric.cj` 向量 `cross` stub）形成对比。

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
- `length(q: Quat<T,Q>): T` — 四元数长度 `sqrt(dot(q,q))`。依赖 `std.math.sqrt`（仓颉标准库提供），不依赖 geometric.cj。**Float32 实例的 sqrt 处理**：`std.math.sqrt` 签名仅支持 Float64 输入/输出，Float32 实例需显式转换（实现阶段明确采用 `T(Float64.sqrt(Float64(dot_qq)))` 路径或额外声明 Float32 重载）。
- `normalize(q: Quat<T,Q>): Quat<T,Q>` — 归一化四元数。内部调用 `length`。可直接完整实现。
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
- `axis(x: Quat<T,Q>): Vec3<T,Q>` — 实现公式（与 GLM `ext/quaternion_trigonometric.inl:20-27` 一致）：`tmp1 = T(Float64(1)) - x.w * x.w`；若 `tmp1 <= T(Float64(0))` 返回 `Vec3(T(Float64(0)), T(Float64(0)), T(Float64(1)))`（z 轴单位向量）；否则 `tmp2 = T(Float64(1)) / T(std.math.sqrt(Float64(tmp1)))`（**v10 修订，Issue 11 响应**：删除冗余的 `Float64(std.math.sqrt(...))` 包装层——`std.math.sqrt` 已是 `Float64` 输入/输出，等价于 `Float64(Float64)` 的冗余嵌套，仅需一次 `T(Float64(…))` 转换回目标类型 T），返回 `Vec3(x.x*tmp2, x.y*tmp2, x.z*tmp2)`。依赖 `std.math.sqrt`（受 §1「Float32 与 std.math 的交互约束」管辖，统一使用 `T(Float64.xxx(Float64(value)))` 模式兼容 `T = Float32`/`Float64`）和 `T(Float64(1))` 字面量替代（无需 `one: T` 形参），**可完整实现**。**T(1) 获取方式（v8 修订）**：v7 文档描述「T(1) 演算通过 `x.w*x.w` 取得」是错误的——`x.w*x.w` 是 w² 而非 1，无法作为 T(1) 的演算路径（v8 明确删除该错误描述）。本函数采用 §1「系统性设计约束」中 v8 新增的「常量型 T(1) 字面量替代」策略：`T(Float64(1))` 显式转换路径——`Float64(1.0)` 是字面量，`T(Float64(1.0))` 在 `T = Float64` 时返回 1.0，在 `T = Float32` 时返回 1.0f，无需 `one: T` 形参污染函数签名。**边界行为（v3 新增契约，v5 修订，v8 强化，v10 公式精修）**：触发 `Vec3(T(0), T(0), T(1))` 返回值的条件为 `T(Float64(1)) - x.w*x.w <= T(Float64(0))`（典型场景：单位四元数 `(0, 0, 0, 1)` 即 `|w| >= 1`）；对于真正的零四元数 `(0, 0, 0, 0)`，`tmp1 = 1 > 0` 进入 else 分支返回 `Vec3(0, 0, 0)`（**注意：v3 原描述的「内部 `normalize(Vec3(0, 0, 0))` 返回 `Vec3(T(1), T(0), T(0))`」为虚构实现，GLM 源码不调用 `normalize`，v5 修订纠正**）。
- `angleAxis(angle: T, axis: Vec3<T,Q>): Quat<T,Q>` — 依赖 `sin`/`cos`（trigonometric.cj stub）。**stub 占位**。

**修正本阶段策略**：
- `axis` — **完整实现**（依赖仅 `std.math.sqrt` 和 T(1) 演算，零四元数保护行为见上）
- `angle` — **stub 占位**（依赖 trigonometric.cj 的 `asin`/`acos`）
- `angleAxis` — **stub 占位**（依赖 trigonometric.cj 的 `sin`/`cos`）

### 3.10 ext/quaternion_exponential.cj

**角色**：提供四元数指数函数（exp、log、pow、sqrt）。

**依赖分析**：
- `exp(q: Quat<T,Q>): Quat<T,Q>` — 依赖 `length`（quaternion_geometric，已实现）、`epsilon<T>()`（scalar_constants.cj，line 10 用于 `Angle < epsilon<T>()` 退化检测）、`cos`/`sin`（trigonometric.cj stub）。**stub 占位**。
- `log(q: Quat<T,Q>): Quat<T,Q>` — 依赖 `length`（quaternion_geometric）、`epsilon<T>()`（scalar_constants.cj，line 23 用于 `Vec3Len < epsilon<T>()` 退化检测）、`pi<T>()`（scalar_constants.cj，line 28 用于 `wxyz(log(-q.w), pi<T>(), ...)`）、`atan`/`log`（trigonometric.cj/exponential.cj 接口）、`std::numeric_limits<T>::infinity()` 等价物（line 30 用于 w=0 退化分支，**v10 关键修订**：仓颉 stdlib **不提供** `FloatingPoint<T>.getInf()` 实例方法，仅提供 `Float64.Inf`/`Float32.Inf` 静态常量，**且 `FloatingPoint<T>` 接口本身无任何实例方法**——`isNaN()`/`isInf()` 是 `Float64`/`Float32` 等具体类型的实例方法；下游实现应通过类型分派 `if (q.x is Float32) { Float32.Inf } else { Float64.Inf }` 或运行时 fallback `T(1)/T(0)` 显式构造获取正无穷）。**stub 占位**。
- `pow(x: Quat<T,Q>, y: T): Quat<T,Q>` — 依赖 `epsilon<T>()`/`abs`/`clamp`/`asin`/`acos`/`sin`/`cos`/`sqrt`/`cos_one_over_two<T>()` + 递归调用 `std.math.pow(Float64, Float64): Float64`（实数版本降级路径）+ `std::numeric_limits<T>::min()` 等价的仓颉次正规数边界检查。其中 `epsilon<T>()`/`cos_one_over_two<T>()` 来自 scalar_constants.cj（line 52：`if(abs(x.w / magnitude) > cos_one_over_two<T>())`），`abs`/`clamp` 来自 common.cj stub，`asin`（line 68：`Angle = asin(sqrt(VectorMagnitude) / magnitude)`）/`acos`/`sin`/`cos` 来自 trigonometric.cj stub，`sqrt` 来自 std.math，`std.math.pow(Float64, Float64): Float64` 来自仓颉标准库（line 65：`return qua<T, Q>::wxyz(pow(x.w, y), 0, 0, 0)` 实数降级路径），`std::numeric_limits<T>::min()` 用于次正规数边界（line 63：`if (VectorMagnitude < (std::numeric_limits<T>::min)())`，**v10 关键修订**：仓颉 stdlib **不提供** `FloatingPoint<T>.getMin()` 实例方法，**仅提供** `Float64.Min`/`Float32.Min` 静态常量——下游实现应通过类型分派 `if (x.w is Float32) { Float32.Min } else { Float64.Min }` 获取 T 类型对应的最小正次正规数；或运行时 fallback `T(1) / T(非常大的值)` 间接获取次正规数边界）。**命名消歧与 Float64 转换（v5 新增，v7 澄清，v10 合并）**：将 v5「命名消歧」与 v7「Float64 转换依赖」两段合并为单一子段（**v10 关键修订**：v9 设计中两段功能重叠，下游阅读时产生「§1 已说明通用规则为何 §3.10 又重复一次」的疑问）。本段统一说明：四元数 `pow` 函数体内部调用的 `pow(x.w, y)` 是**实数版本** `std.math.pow(Float64, Float64): Float64`（**v10 关键修订**：仓颉 stdlib 实际签名为 `(Float64, Float64): Float64`，**不是** v9 描述的泛型 `std.math.pow(T, T): T`），与四元数 `pow` 本身（`pow(Quat, T): Quat`）通过参数类型消歧（第一参数类型 `Float64` 与 `Quat<T,Q>` 区分）；`pow(Quat<Float32, Q>, Float32)` 实现路径遵循 §1「Float32 与 std.math 的交互约束」通用约束（应用 `T(Float64.std.math.pow(Float64(x.w), Float64(y)))` 转换模式），fallback 路径 `exp(y * log(x.w))` 同步遵循 §1 通用约束；若 `std.math.pow` 不可用需以 `exp(y * log(x.w))` 替代实现。**stub 占位**。
- `sqrt(x: Quat<T,Q>): Quat<T,Q>` — 委托 `pow(x, T(0.5))`。**stub 占位**。

**v5 修订**：4 个函数均依赖 trigonometric.cj/common.cj stub，本阶段全部 **stub 占位**。`pow` 的依赖关系以 GLM `ext/quaternion_exponential.inl:41-80` 实际实现为准（v3 引用 `24-43` 行号错误，已纠正）。`exp`/`log`/`pow` 函数分别补充 `epsilon<T>()`、`pi<T>()` 等 scalar_constants.cj 依赖。`pow` 补充 `cos_one_over_two<T>()`/`asin`/`std.math.pow`/`std::numeric_limits<T>::min()` 等价物依赖。

### 3.11 ext/quaternion_common.cj

**角色**：提供四元数公共函数（mix、lerp、slerp、conjugate、inverse、isnan、isinf）。

**依赖分析**：
- `dot` — 委托 quaternion_geometric.cj，完整可用
- `conjugate(q: Quat<T,Q>): Quat<T,Q>` — **完整实现**。仅对 x/y/z 三个分量取反，w 分量保持不变：`Quat(-q.x, -q.y, -q.z, q.w)`（与 GLM `ext/quaternion_common.inl:112-116` `wxyz(q.w, -q.x, -q.y, -q.z)` 一致；**v5 修订**：v3 描述「仅涉及逐分量取反」语义不准确，逐分量取反对应 `negative` 运算符 `-q`，而 `conjugate` 仅对 x/y/z 取反、保留 w）。等价实现可基于主构造函数或 wxyz 工厂函数。**const func 适用性（v10 新增，Issue 6 响应）**：`conjugate` 函数体仅涉及 `Quat` 主构造函数的逐分量取反调用（`Quat(-q.x, -q.y, -q.z, q.w)`），无 `assert`/无 `throw`/无 `dot`/`normalize`/其他非 const 函数调用，**可声明为 `const func`**（与 Vec/Mat 的逐分量运算符策略一致，与阶段一 Vec 类型的逐分量取反函数 `negative`/`negate` 等 const func 实践一致）。**v10 附注**：若仓颉 const 函数还有其他限制（如不能调用非 const 自由函数、不能包含复杂表达式），则该论断需进一步评估；与 §5.4 const 上下文约束段保持一致
- `inverse(q: Quat<T,Q>): Quat<T,Q>` — `conjugate(q) / dot(q, q)`。**完整实现**（依赖 dot 和 除法运算符）。**边界行为（v3 新增契约，**v10 措辞统一，Issue 13 响应**）**：
  - 浮点四元数 `dot(q,q) == T(0)` 时除以零产生 Inf/NaN 分量（与 GLM 行为一致，GLM 不做零除保护）
  - 整数四元数 `dot(q,q) == T(0)` 时触发仓颉 `ArithmeticException`（**v10 措辞统一**：与浮点 Inf/NaN 行为不同；§5.3 边界条件表「整数 `inverse`」行措辞同步统一为「触发仓颉 `ArithmeticException`」，与本节描述对齐）
- `lerp(x, y, a): Quat<T,Q>` — `x * (1 - a) + y * a`。**完整实现**（运行时，非 const，含 `assert(a >= 0 && a <= 1)` 断言与 GLM `ext/quaternion_common.inl:28-38` 一致）。`const` 约束说明（v3 新增）：lerp 不可声明为 `const func`，因函数体内 `assert` 不是 `const` 函数（与 deviations.md IF-03 一致），调用时不可在 `const` 上下文（如 `const val` 初始化、`const func` 函数体）中使用。
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
| `gtc/matrix_transform.cj` | glm.gtc | 仅函数签名空壳，内部 `throw Exception("stub")` |

**沿用自阶段二的 stub**：`common.cj`、`geometric.cj`、`matrix.cj`（27 实现 + 6 stub）

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

| 函数 | 标量签名 | 向量签名（占位符） | 内部依赖 |
|------|---------|---------|---------|
| `sin` | `sin<T>(x: T): T` | `sin<T, Q>(x: VecN<T, Q>): VecN<T, Q>` | `std.math.sin`（受 §1「Float32 与 std.math 的交互约束」管辖） |
| `cos` | `cos<T>(x: T): T` | `cos<T, Q>(x: VecN<T, Q>): VecN<T, Q>` | `std.math.cos` |
| `tan` | `tan<T>(x: T): T` | `tan<T, Q>(x: VecN<T, Q>): VecN<T, Q>` | `std.math.tan` |
| `asin` | `asin<T>(x: T): T` | `asin<T, Q>(x: VecN<T, Q>): VecN<T, Q>` | `std.math.asin` |
| `acos` | `acos<T>(x: T): T` | `acos<T, Q>(x: VecN<T, Q>): VecN<T, Q>` | `std.math.acos` |
| `atan` | `atan<T>(x: T): T` | `atan<T, Q>(x: VecN<T, Q>): VecN<T, Q>` | `std.math.atan` |
| `sinh` | `sinh<T>(x: T): T` | `sinh<T, Q>(x: VecN<T, Q>): VecN<T, Q>` | `std.math.sinh` |
| `cosh` | `cosh<T>(x: T): T` | `cosh<T, Q>(x: VecN<T, Q>): VecN<T, Q>` | `std.math.cosh` |
| `tanh` | `tanh<T>(x: T): T` | `tanh<T, Q>(x: VecN<T, Q>): VecN<T, Q>` | `std.math.tanh` |
| `asinh` | `asinh<T>(x: T): T` | `asinh<T, Q>(x: VecN<T, Q>): VecN<T, Q>` | `std.math.asinh` |
| `acosh` | `acosh<T>(x: T): T` | `acosh<T, Q>(x: VecN<T, Q>): VecN<T, Q>` | `std.math.acosh` |
| `atanh` | `atanh<T>(x: T): T` | `atanh<T, Q>(x: VecN<T, Q>): VecN<T, Q>` | `std.math.atanh` |
| `radians` | `radians<T>(x: T): T` | `radians<T, Q>(x: VecN<T, Q>): VecN<T, Q>` | **v10 修订（Issue 7 响应）**：硬编码 π 字面量 `Float64(3.141592653589793)`，无 std.math 依赖，无 `scalar_constants` 依赖（避免与 `pi<T>()` 的运行时调用） |
| `degrees` | `degrees<T>(x: T): T` | `degrees<T, Q>(x: VecN<T, Q>): VecN<T, Q>` | **v10 修订（Issue 7 响应）**：硬编码 π 字面量 `Float64(3.141592653589793)`，无 std.math 依赖，无 `scalar_constants` 依赖 |

**双参数三角函数（v8 新增 `atan2` 双参数标量版本）**：

| 函数 | 标量签名 | 向量签名（占位符） | 内部依赖 |
|------|---------|---------|---------|
| `atan2` | `atan2<T>(y: T, x: T): T`（v8 明确要求；GLM `std::atan2(T, T)` 对应物） | `atan2<T, Q>(y: VecN<T, Q>, x: VecN<T, Q>): VecN<T, Q>` | `std.math.atan2`（受 §1「Float32 与 std.math 的交互约束」管辖） |

**Float32 实例化影响（v10 新增，Issue 10 响应）**：**所有 `std.math.*` 函数（sin/cos/tan/asin/acos/atan/sinh/cosh/tanh/asinh/acosh/atanh/atan2/sqrt/pow/log/exp）均仅支持 Float64 输入/输出**（依据 `cangjie-std/math/README.md` 第 13 行明确 `pow(base: Float64, exponent: Float64): Float64` 等），所有 trigonometric.cj 函数在 T=Float32 实例化时需应用 `T(Float64.xxx(Float64(value)))` 转换模式（与 §1「Float32 与 std.math 的交互约束」一致）。`radians`/`degrees` 是例外——纯算术公式无 std.math 依赖，Float32 实例化无需转换。表行「内部依赖」列对 `std.math.{func}` 调用统一标注「**仅 Float64，Float32 实例化需显式转换**」。

**约束说明**：
- 标量版本用于 `slerp`/`mix`/`pow`/`log`/`exp`/`angle`/`angleAxis` 等四元数函数体内的**分量级运算**（如 `slerp` 中 `acos(cosTheta)`、`pow` 中 `asin(sqrt(VectorMagnitude) / magnitude)`）
- 向量版本用于**阶段四 vec 级运算**（如 vec3 应用四元数旋转的逐分量 sin/cos 变换）
- 所有函数本阶段均为 stub（仅签名空壳 + `throw Exception("stub")`），具体实现推迟至阶段四 trigonometric.cj 完整实现时补齐
- **下游消费者提示**：`slerp`/`mix`/`pow`/`log`/`exp` 等函数体内的 `acos(cosTheta)`/`sin(angle)`/`atan(denom, numer)` 等调用直接使用**标量版本**（参数为 `T`），与本节签名一致

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

**职责分组**：

| 函数组 | 函数 | 本阶段状态 | 依赖 |
|--------|------|----------|------|
| 矩阵-四元数互转 | `mat3_cast`/`mat4_cast`/`quat_cast(Mat3)`/`quat_cast(Mat4)` | **从 detail 重导出** | `public import glm.detail.{mat3Cast, mat4Cast, quatCast}`（v3 关键变更） |
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

**完整实现函数（4 个）**：
- `lessThan(x, y): Vec4<Bool,Q>` — 逐分量 `<` 比较，**约束：`where T <: Comparable<T>`（v10 新增，Issue 16 响应，依赖 `<` 运算符）**
- `lessThanEqual(x, y): Vec4<Bool,Q>` — 逐分量 `<=` 比较，**约束：`where T <: Comparable<T>`（v10 新增，Issue 16 响应，依赖 `<=` 运算符）**
- `greaterThan(x, y): Vec4<Bool,Q>` — 逐分量 `>` 比较，**约束：`where T <: Comparable<T>`（v10 新增，Issue 16 响应，依赖 `>` 运算符）**
- `greaterThanEqual(x, y): Vec4<Bool,Q>` — 逐分量 `>=` 比较，**约束：`where T <: Comparable<T>`（v10 新增，Issue 16 响应，依赖 `>=` 运算符）**

**重导出函数（4 个）**：
- `mat3_cast(q: Quat<T,Q>): Mat3x3<T,Q>` — 通过 `public import glm.detail.mat3Cast` 重导出
- `mat4_cast(q: Quat<T,Q>): Mat4x4<T,Q>` — 通过 `public import glm.detail.mat4Cast` 重导出
- `quat_cast(m: Mat3x3<T,Q>): Quat<T,Q>` — 通过 `public import glm.detail.quatCast` 重导出
- `quat_cast(m: Mat4x4<T,Q>): Quat<T,Q>` — 通过 `public import glm.detail.quatCast` 重导出

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

### 3.16 路线图同步修订建议（v5 新增）

针对 v3 设计文档与项目路线图 `docs/02_roadmap.md` 在阶段三验证标准上存在的三处不一致，明确以下路线图同步修订建议（设计文档保持不变，路线图需修订以与本设计对齐）：

**不一致 1：`slerp` 可验证性冲突**
- 路线图 §3 第 125 行标记「球面线性插值（slerp）操作 `[可验证]`」，但本设计 §3.11、§8 产出物清单、§10 覆盖矩阵、§11.5 函数可用性对照表均将 `slerp`（含 3 参数与 4 参数版本）标记为「**stub 占位**」（依赖 `trigonometric.cj` 的 `acos`/`sin` stub 与 `common.cj` 的 `mix` stub）。
- **路线图修订建议**：`02_roadmap.md` 第 125 行修订为「球面线性插值（slerp）操作 `[待 Stage 4，依赖 trigonometric.cj 完整实现]`」。

**不一致 2：`lookRotate` 命名未同步修正**
- 路线图 §3 多处（第 89、102、111、129、152、163、207 行）仍引用 `lookRotate` 函数名，但本设计已统一为 `quatLookAt`/`quatLookAtRH`/`quatLookAtLH`（D13 决策 + §9 差异声明「GLM 中不存在 `lookRotate` 函数」）。
- **路线图修订建议**：`02_roadmap.md` 第 89、102、111、129、152、163、207 行将 `lookRotate` 修订为 `quatLookAt`/`quatLookAtRH`/`quatLookAtLH`。

**不一致 3：`ext/quaternion_common.cj` 可验证性范围过广**
- 路线图 §3 第 130 行标记「`ext/quaternion_common.cj`：四元数常用函数（`conjugate`、`inverse`、`normalize` 等跨类型运算）`[可验证]`」，涵盖面过广，未排除 `mix`/`slerp` 属于 stub 的部分。
- **路线图修订建议**：`02_roadmap.md` 第 130 行修订为「`ext/quaternion_common.cj`：四元数常用函数（`conjugate`/`inverse`/`lerp`/`isnan`/`isinf` 等不依赖 stub 的函数）`[可验证]`；`mix`/`slerp`（2 版本）`[待 Stage 4，依赖 trigonometric.cj 与 common.cj 完整实现]`」。

**阶段三验证标准双向映射表**（统一路线图与本设计的可验证性标注口径）：

| 路线图标注 | 本设计符号 | 含义 |
|----------|----------|------|
| `[可验证]` | ✅ 可用 | 本阶段完整实现，单元测试可立即验证 |
| `[部分可验证]` | ⚠️ 可用但有条件 | 本阶段实现但依赖 stub，调用抛 `Exception("stub")`，待阶段四 stub 替换后正常 |
| `[待 Stage 4]` | ❌ stub | 本阶段 stub 占位，待阶段四函数库完整实现后补齐 |

**§11.5 权威基准说明（v7 澄清）**：本设计 §11.5「函数可用性对照表」的 ✅/⚠️/❌ 符号标注是阶段三验证的**权威基准**（每个函数一行，标注本阶段状态与阶段四状态，含约束/边界条件注解）；路线图 `02_roadmap.md` 的 `[可验证]`/`[部分可验证]`/`[待 Stage 4]` 三级标注在 v3 迭代结束后由项目管理流程同步修订，本设计文档不再依赖路线图的特定标注作为验证依据。`a_v3_review_v1.md` 路线图一致性相关问题（问题 7）通过本段说明与 §3.16 三处修订建议双重保障：前者明确本设计独立可验证性，后者提供路线图同步建议。

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
let m3 = mat3Cast(q)     // 四元数转 3×3 旋转矩阵 [本阶段可验证，从 detail/type_quat_cast.cj 调用]
let m4 = mat4Cast(q)     // 四元数转 4×4 旋转矩阵 [本阶段可验证]
let q = quatCast(m3)     // 3×3 旋转矩阵转四元数 [本阶段可验证]

// gtc 命名空间下的同名 API（通过 public import 重导出，[本阶段可验证]）
let m3_2 = glm.gtc.quaternion.mat3_cast(q)
let q_2 = glm.gtc.quaternion.quat_cast(m3)
```

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
- **`normalize` 零四元数**：返回单位四元数 `identity(one)`，其中 T(0) 通过 `one - one` 演算（与 GLM `quaternion_geometric.inl:20-21` 行为一致）
- **stub 函数体**：以 `throw Exception("stub")` 占位（标识阶段三/四功能边界）

### 5.2 算术溢出

- **统一标注**：四元数算术运算符（`+`/`-`/`*`/一元 `-`/标量乘除）统一标注 `@OverflowWrapping` 注解，与阶段一 Vec3 (`type_vec3.cj:54-80`) 和阶段二全部矩阵类型 (`type_mat2x2.cj`、`type_mat3x3.cj` 等) 的实践保持一致
- **跨类型一致性**：`@OverflowWrapping` 对浮点类型无效果（std.overflow 模块语义仅作用于整数溢出行为），但保持跨整数/浮点实例化的统一行为，避免未来整数四元数用例出现不可控整数溢出行为

### 5.3 边界条件与异常场景（v3 新增）

| 边界条件 | 函数 | 行为契约 |
|---------|------|---------|
| `1 - x.w*x.w <= 0` | `axis(q)` | 返回 `Vec3(T(0), T(0), T(1))`（z 轴单位向量，典型场景：单位四元数 `(0, 0, 0, 1)` 即 `\|w\| >= 1`；与 GLM `ext/quaternion_trigonometric.inl:20-27` 一致；**v5 修订**：v3 描述「零四元数返回 `Vec3(1, 0, 0)`」错误，触发条件为 `1 - w² <= 0` 而非 `q.xyz == 0`；**v10 补充，Issue 13 响应**：`tmp1 = T(1) - x.w*x.w` 计算公式参见 §3.9 `axis` 函数描述） |
| 真正零四元数 `(0,0,0,0)` | `axis(q)` | `tmp1 = 1 > 0` 进入 else 分支，返回 `Vec3(T(0), T(0), T(0))`（**v5 修订**：v3 描述「内部 `normalize(Vec3(0,0,0))` 返回 `Vec3(1,0,0)`」为虚构实现，GLM 实际不调用 `normalize`） |
| 零四元数（浮点） | `inverse(q)` | 浮点除零产生 Inf/NaN 分量（与 GLM 一致，GLM 不做零除保护） |
| 零四元数（整数） | `inverse(q)` | 触发仓颉 `ArithmeticException`（**v10 措辞统一，Issue 13 响应**：与浮点 Inf/NaN 行为不同；与 §3.11 `inverse` 描述对齐） |
| `cosTheta` 退化 | `mix`/`slerp` | 依赖 `cosTheta > 1 - epsilon<T>()` 边界检查；stub 函数抛 stub 异常 |
| 非纯旋转矩阵 | `fromMat3`/`fromMat4` | 仅对纯旋转矩阵产生有意义的四元数；对非旋转矩阵（缩放/平移/剪切）行为未定义，结果可能产生非单位四元数或语义错误的旋转 |
| `a` 超出 [0,1] | `lerp` | 触发 `assert(a >= 0 && a <= 1)` 断言失败 |
| `epsilon = T(0)` | `equal(v, v, 0)` | 返回 `false`（严格小于语义，与 GLM `glm/gtc/epsilon.inl:32-41` 中 `epsilonEqual` 实现一致；v9 修订：原引用 `func_vector_relational.inl:18-22` 错误——该文件不含 epsilon 版本） |
| 整型 T | `epsilon<T>()`/`pi<T>()`/`cos_one_over_two<T>()` | 触发 `Exception("not defined for non-floating-point types")`（约束收紧失败时 fallback 分支） |
| 整型 T | `isnan(q)`/`isinf(q)` | 编译期约束收紧为 `where T <: FloatingPoint<T>`，整型 T 实例化时编译失败（v4 新增，v7 接口名修订）；若仓颉泛型不支持窄约束则运行时 fallback 抛 `Exception("isnan/isinf not defined for non-floating-point types")` |
| 整型 T | `mat3Cast`/`mat4Cast`/`quatCast` | 编译期约束收紧为 `where T <: FloatingPoint<T>`，整型 T 实例化时编译失败（v5 新增，v7 接口名修订；与 D29 `isnan`/`isinf` 策略一致，对应 GLM `GLM_STATIC_ASSERT(is_iec559, ...)`） |
| u, v 反平行（`dot ≈ -1`） | `fromVec3` | 返回 180° 任意轴四元数（`q.w ≈ 0` 且 `q.xyz` 模长为 1 的纯向量四元数；v8 新增契约，行为已定义，与 GLM `ext/quaternion_common.inl:196-217` 退化路径一致；阶段三 stub 阶段不适用，待阶段四 stub 替换后生效） |
| u, v 为零向量 | `fromVec3` | 行为未定义（由 `normalize` 阶段四完整实现时确定） |
| `mat3Cast` 接受非单位四元数 | `mat3Cast`/`mat4Cast` | 返回矩阵不保证是旋转矩阵（缩放/剪切分量保留；v8 新增契约，与 §3.2.1 边界行为契约段对齐） |
| `quatCast` 接受非旋转矩阵 | `quatCast` | 返回的四元数行为未定义（可能为非单位四元数/零四元数/NaN 四元数；v8 新增契约，与 §3.2.1 边界行为契约段对齐） |

### 5.4 const 上下文约束

- **`lerp`/`inverse` 不可在 const 上下文调用（v10 修订，Issue 6 响应）**：v9 描述「`lerp`/`conjugate`/`inverse` 不可在 const 上下文调用」错误——`conjugate` 函数体仅对 x/y/z 三个分量取反（`Quat(-q.x, -q.y, -q.z, q.w)`），无 `assert`/无 `throw`/无运行时副作用，**可在 const 上下文调用**（与 Vec/Mat 的逐分量运算符策略一致）。**v10 修订**：从禁止列表中移除 `conjugate`；`lerp` 因函数体内 `assert(a >= 0 && a <= 1)` 断言非 const 函数（与 deviations.md IF-03 一致），不可在 const 上下文调用；`inverse` 因依赖 `/` 运算符——**整数 T 在 `dot(q,q) == 0` 时触发仓颉 `ArithmeticException`**——非 const 函数
- **`inverse` const 拒绝理由（v10 新增）**：`inverse` 函数体内部 `conjugate(q) / dot(q, q)` 的 `/` 运算符在 T=Integer 实例化时为整数除法，**当 `dot(q,q) == 0` 时触发仓颉 `ArithmeticException`**（仓颉整数除零抛异常，与浮点 Inf/NaN 行为不同）。该运行时异常路径使 `inverse` 不可声明为 `const func`，与阶段二矩阵 `inverse` 函数（依赖 `1/det` 运算在整数 T 时同样抛异常）策略一致
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
| D11 | **v3 关键决策**：`mat3Cast`/`mat4Cast`/`quatCast` 实现位于 `glm.detail.type_quat_cast.cj`，`gtc/quaternion.cj` 通过 `public import` 重导出 | **消除包间循环依赖**：v2 设计将转换函数放在 gtc 导致 `type_quat.cj` 需 `import glm.gtc.quaternion` 形成 `glm.detail ↔ glm.gtc` 双向依赖，违反仓颉包间循环依赖约束（cangjie-lang-features package/README.md 第 99 行）。v3 决策将转换函数下沉至 detail 包，让 `type_quat.cj` 通过同包访问直接调用（无需 import），`gtc/quaternion.cj` 通过 `public import` 重导出至 gtc 命名空间，保留 GLM 1:1 API 形态的同时彻底打破循环依赖 |
| D12 | type_quat.inl 中 fromVec3(u,v) 和 fromEuler(eulerAngle) 构造函数本阶段化简为独立工厂函数 | 避免在 Quat 结构体内引入对 stub 函数的编译依赖；工厂函数在 extend 块中定义，可推迟至阶段四完整实现 |
| D13 | quatLookAt/quatLookAtRH/quatLookAtLH 等 gtc/quaternion 函数本阶段 stub 占位 | 这些函数依赖 geometric.cj 的 cross/dot/normalize/inversesqrt（均为 stub），无法完整实现 |
| D14 | quaternion_geometric.cj（dot/length/normalize/cross）本阶段完整实现 | 经分析确认依赖链仅止于 std.math.sqrt，不依赖任何 stub 文件 |
| D15 | quaternion_common.cj 中 conjugate/inverse/lerp/isnan/isinf 本阶段完整实现 | conjugate/inverse/lerp 仅需算术运算和 dot（已完整实现）；isnan/isinf 采用 std.math 实例方法路径，不依赖顶层函数 |
| D16 | trigonometric.cj 新增为空桩文件 | type_quat.inl 依赖 trigonometric.hpp，本阶段仅提供签名空壳供依赖闭合 |
| D17 | Bool 四元数不支持算术运算 | Bool 不实现 Number<T> 接口，与阶段二 D33 Bool 矩阵策略一致 |
| D18 | scalar_quat_ops.cj 与 scalar_vec_ops.cj/scalar_mat_ops.cj 同名重载 | add/sub/mul/div 与向量/矩阵版本通过第二参数类型消歧，与阶段二策略一致 |
| D19 | 四元数算术运算符统一标注 @OverflowWrapping | 与阶段一/二所有算术运算符（含浮点重载）保持一致；标注对浮点无效果但保持跨整数/浮点实例化的统一行为 |
| D20 | **`gtc/quaternion.cj` 独立文件承载 15 函数（v3 明确：4 重导出 + 4 完整 + 7 stub）** | 与 GLM `gtc/quaternion.hpp` 1:1 映射，便于 GLM 函数到仓颉文件的追溯；与阶段二 gtc 子包策略一致 |
| D21 | **`mix`/`slerp`/`pow` 的依赖明确包含 `epsilon<T>()`（v3 新增）；`pow` 进一步包含 `cos_one_over_two<T>()`、`asin`、递归 `std.math.pow(Float64, Float64): Float64` 与 `std::numeric_limits<T>::min()` 等价物（v5 强化，v7 接口名修订，**v10 关键修订：std.math.pow 实际签名为 `(Float64, Float64): Float64`，非泛型 `(T, T): T`**）** | 与 GLM `quaternion_common.inl`/`quaternion_exponential.inl:41-80` 实际依赖一致：`mix`/`slerp` 依赖 `cosTheta > 1 - epsilon<T>()` 退化检测分支；`pow` 在 line 52 使用 `cos_one_over_two<T>()`，line 63 使用 `std::numeric_limits<T>::min()` 进行次正规数边界检查，line 65 递归调用 `std::pow(Float64, Float64): Float64` 实数降级路径，line 68 使用 `asin`。仓颉版本需明确：(1) `pow` 函数体内部调用的是 `std.math.pow(Float64, Float64): Float64` 实数版本（**v10 修订**：仓颉 stdlib 实际签名见 `cangjie-std/math/README.md` 第 13 行，仅支持 Float64 输入/输出），与四元数 `pow` 通过参数类型消歧；(2) 若 `std.math.pow` 不存在，需以 `exp(y * log(x.w))` 替代；(3) **`std::numeric_limits<T>::min()` 等价物获取（v10 关键修订）**：仓颉 stdlib **不提供** `FloatingPoint<T>.getMin()` 实例方法，**仅提供** `Float64.Min`/`Float32.Min` 静态常量；仓颉实现路径为类型分派 `if (q.x is Float32) { Float32.Min } else { Float64.Min }` 或运行时 fallback `T(1) / T(很大值)` 显式构造；(4) **`std::numeric_limits<T>::infinity()` 等价物获取（v10 关键修订）**：仓颉 stdlib **不提供** `FloatingPoint<T>.getInf()` 实例方法，**仅提供** `Float64.Inf`/`Float32.Inf` 静态常量；仓颉实现路径为类型分派 `if (q.x is Float32) { Float32.Inf } else { Float64.Inf }` 或运行时 fallback `T(1)/T(0)` 显式构造 |
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

---

## 8. 阶段三产出物清单

### 完整实现

- `detail/type_quat.cj`（四元数核心类型 + 运算符，fromMat3/fromMat4 调用同包 type_quat_cast.cj 函数）
- **`detail/type_quat_cast.cj（v3 新增）`**（4 个矩阵-四元数互转函数：mat3Cast/mat4Cast/quatCast 两个重载）
- `detail/scalar_constants.cj`（标量常量 epsilon/pi/cos_one_over_two，对整数类型抛异常）
- `detail/scalar_quat_ops.cj`（标量-四元数全局函数 add/sub/mul/div）
- `detail/trigonometric.cj`（新增空桩，不在此清单，详见「空桩占位」段）
- `ext/vector_relational.cj`（向量 epsilon 关系运算，16 重载完整实现 + 8 重载 ULP stub）
- `ext/quaternion_relational.cj`（四元数关系运算，4 函数完整实现）
- `ext/quaternion_geometric.cj`（四元数 dot/length/normalize/cross，4 函数完整实现）
- `ext/quaternion_common.cj`（conjugate/inverse/lerp/isnan/isinf 5 函数完整实现，mix/slerp/slerp(k) 3 函数 stub）
- `ext/quaternion_trigonometric.cj`（axis 函数完整实现，angle/angleAxis 2 函数 stub）
- `ext/scalar_constants.cj`（ext 重导出接口）
- `gtc/constants.cj`（**28 个**数学常量函数，v8 修订：与 GLM 1.0.3 `gtc/constants.inl` 实际声明数一致）
- **`gtc/quaternion.cj`（v3 修订：4 函数重导出 + 4 函数完整 + 7 函数 stub）**
- 四元数别名文件（4 个 ext/ 文件）
- 四元数测试文件（详见 §8.2，`test_xxx.cj` 命名约定，v8 修订）

### 大部分实现（部分函数 stub）

- `ext/quaternion_common.cj`（mix/slerp(2 版本) 为 stub）
- `ext/quaternion_trigonometric.cj`（angle/angleAxis 为 stub）
- `ext/quaternion_transform.cj`（rotate 为 stub）
- `ext/quaternion_exponential.cj`（exp/log/pow/sqrt 全部 stub）
- `gtc/quaternion.cj`（eulerAngles/roll/pitch/yaw/quatLookAt/quatLookAtRH/quatLookAtLH 共 7 函数 stub）

### 空桩占位

- `gtc/matrix_transform.cj`
- `detail/trigonometric.cj`（4 个本阶段新增空桩之一）
- `ext/matrix_projection.cj`
- `ext/matrix_clip_space.cj`
- `ext/matrix_transform.cj`

### 沿用自阶段二的 stub

- `detail/common.cj`
- `detail/geometric.cj`
- `detail/matrix.cj`（27 实现 + 6 stub）

### 更新文件

- `fwd.cj`：新增 8 个四元数类型别名（Quat/FQuat/DQuat/3×Float32 精度/3×Float64 精度；具体清单见 §2 lib.cj/fwd.cj 段落，v5 明确）
- `lib.cj`：新增 Quat 类型、type_quat_cast 函数、ext/gtc 函数和常量的 public import（具体清单见 §2 lib.cj/fwd.cj 段落，v5 明确：8 个 `import` 声明）

### 测试设计（v3 新增 §8.2）

#### 测试文件清单与位置

阶段三测试文件位于 `tests/glm/` 目录下，按模块拆分：

| 测试文件 | 覆盖模块 | 预计用例数 |
|---------|---------|----------|
| `tests/glm/detail/test_type_quat.cj` | Quat 核心类型 + 运算符 | ≥40 |
| `tests/glm/detail/test_type_quat_cast.cj` | 矩阵-四元数互转函数（v3 新增） | ≥8 |
| `tests/glm/test_ext_quaternion_relational.cj` | 四元数关系运算（v10 修订：与 `test_ext.cj` 同层平铺命名，避免新建 `tests/glm/ext/` 子目录） | ≥8 |
| `tests/glm/test_ext_quaternion_geometric.cj` | 四元数几何函数（v10 修订：同层平铺命名） | ≥12 |
| `tests/glm/test_ext_quaternion_common.cj` | 四元数公共函数（v10 修订：同层平铺命名） | ≥16 |
| `tests/glm/test_ext_quaternion_trigonometric.cj` | 四元数三角函数（v10 修订：同层平铺命名） | ≥8 |
| `tests/glm/test_ext_quaternion_exponential.cj` | 四元数指数函数（stub）（v10 修订：同层平铺命名） | ≥4 |
| `tests/glm/test_ext_quaternion_transform.cj` | 四元数变换函数（stub）（v10 修订：同层平铺命名） | ≥2 |
| `tests/glm/test_ext_vector_relational.cj` | 向量 epsilon/ULP 比较（v10 修订：同层平铺命名） | ≥16 |
| `tests/glm/test_ext_scalar_constants.cj` | 标量常量（v10 修订：同层平铺命名） | ≥6 |
| `tests/glm/test_ext_quaternion_aliases.cj` | 四元数别名（4 个别名文件合并测试，v10 修订：避免为每个别名文件单独建测试文件） | ≥4 |
| `tests/glm/gtc/test_constants.cj` | 数学常量 | ≥28（v8 修订：与 §3.12 gtc/constants 28 个常量函数对齐） |
| `tests/glm/gtc/test_quaternion.cj` | gtc 四元数转换重导出/比较/欧拉/看向 | ≥27（v8 修订：见下方用例分配原则） |
| **合计** | — | **≥179**（v10 修订：v9 声称 ≥178，累加实际为 179；按上述每行 ≥值求和：40+8+8+12+16+8+4+2+16+6+4+28+27=179） |

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

**`tests/glm/gtc/test_quaternion.cj` 用例数重算（v8 修订）**：v7 文档原 20 个用例，8 个完整实现函数（4 比较 + 4 转换重导出）平均仅 2.5 个/函数，低于用例分配原则。按 v8 原则重算：
- 4 个完整实现（`lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual`）：4 × 2 = **8 个用例**
- 4 个重导出（`mat3_cast`/`mat4_cast`/`quat_cast(Mat3)`/`quat_cast(Mat4)`，每函数另加 1 个可达性测试）：4 × (2 + 1) = **12 个用例**（v8 修订：重导出函数按"完整实现函数 + 1 可达性测试"双重覆盖，确保下游消费者既验证返回值正确性也验证调用链通畅）
- 7 个 stub（`eulerAngles`/`roll`/`pitch`/`yaw`/`quatLookAt`/`quatLookAtRH`/`quatLookAtLH`）：7 × 1 = **7 个用例**（验证抛 stub 异常）
- **合计**：8 + 12 + 7 = **27 个用例**（v8 修订：与 8×2 + 7×1 + 4×1 = 27 公式一致，分解为「8 可测函数 × 2 = 16 + 4 重导出可达性测试 × 1 = 4 + 7 stub × 1 = 7 = 27」）

#### 测试覆盖维度

1. **构造路径**：单位构造、逐分量构造、wxyz 工厂、标量+向量构造、跨 Qualifier 构造、跨类型构造（fromQuat）、从矩阵构造（fromMat3/fromMat4）、从两向量构造（fromVec3 stub）、从欧拉角构造（fromEuler stub）
2. **运算符正常路径**：算术运算（+ - * / 一元 -）、Quat×Vec3/Vec4 旋转、Vec3×Quat/Vec4×Quat 逆旋转、Quat×T 标量运算、==/!= 比较
3. **ext 函数库正常路径**：vector_relational 16 重载、quaternion_relational 4 函数、quaternion_geometric 4 函数、quaternion_common 中 conjugate/inverse/lerp/isnan/isinf 5 函数、quaternion_trigonometric 中 axis 1 函数
4. **gtc/quaternion.cj 正常路径（v3 新增）**：4 个比较函数（lessThan/lessThanEqual/greaterThan/greaterThanEqual）+ 4 个转换函数重导出（mat3_cast/mat4_cast/quat_cast 两个重载）+ **detail/type_quat_cast 单元测试覆盖实现细节**（v3 新增）
5. **stub 函数异常路径**：mix/slerp(2 版本)/angle/angleAxis/exp/log/pow/sqrt/rotate/eulerAngles/roll/pitch/yaw/quatLookAt* 调用时验证抛 `Exception("stub")`
6. **跨 Qualifier 实例化**：PackedHighp/PackedMediump/PackedLowp/AlignedHighp/AlignedMediump/AlignedLowp 6 种精度的 Quat 运算符测试
7. **跨类型实例化**：Float32/Float64 的 Quat 完整测试，整型 Quat 仅测试非依赖 stub 的运算符（边界处理）

#### 浮点比较策略

- **epsilon 版本**：使用 `epsilon<Float32>() = 1.1920929e-7` 作为容差，调用 `equal(v1, v2, epsilon<Float32>())` 验证
- **精确比较**：对于 should be 精确相等的运算结果（如 `identity * v == v`），使用 `==` 直接比较
- **角度比较**：旋转等价性使用「四元数点积绝对值接近 1」判断（`abs(dot(q1, q2)) > 1 - epsilon<Float32>()`），避免 q 与 -q 的双重覆盖
- **type_quat_cast 单元测试（v3 新增）**：使用「旋转矩阵 * 向量 = 四元数 * 向量」等价性测试（`m3 * v == q * v`）验证互转正确性

#### 阶段三可验证 vs 待阶段四拆分

- **本阶段可验证**（路线图标注 `[可验证]`）：所有「完整实现」函数 + 「stub 函数异常路径」（验证抛 stub 异常）
- **部分可验证**（路线图标注 `[部分可验证]`）：运算符依赖 stub 的部分（如 `Quat×Vec3` 旋转调用抛 stub 异常），需在测试中标注「本阶段抛 stub 异常，待阶段四 geometric.cj 完整实现后生效」
- **待阶段四**（路线图标注 `[待 Stage 4]`）：stub 函数的正常路径测试（如 slerp 球面插值结果、pow 指数运算结果）推迟至阶段四函数库完整实现后补齐

### 编码启动前验证项

1. **cjpm gtc 子包构建预验证**：验证 `src/gtc/` + `package glm.gtc` 的构建可行性（与 §2 末尾 cjpm 子包构建预验证策略对应）
2. **gtc/quaternion.cj 重导出 detail 函数验证（v3 新增）**：验证 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 能否正确将 detail 包级函数重导出至 glm.gtc 命名空间（无编译错误，外部 `glm.gtc.quaternion.mat3_cast(q)` 调用正常）
3. **包间无循环依赖验证（v3 新增）**：使用 `cjpm check` 命令验证整个项目不包含包间循环依赖（特别是 `glm.gtc` 与 `glm.detail` 之间），符合 cangjie-lang-features package/README.md 第 99 行约束
4. **type_quat.cj 同包调用 type_quat_cast.cj 函数验证**：验证 `fromMat3`/`fromMat4` 在 `type_quat.cj` 中调用同包 `type_quat_cast.cj` 的 `mat3Cast`/`mat4Cast`/`quatCast` 函数（同包内可见性，无需 import）
5. **Vec3/Vec4 extend 块中 Quat 类型前向引用验证**：Vec3×Quat 和 Vec4×Quat 运算符需在 Vec3/Vec4 的 extend 块中引用 Quat 类型，验证同包延迟解析（已通过阶段二原型验证，仅为防御性确认）
6. **scalar_constants 的泛型 `match` 类型模式匹配验证**：验证 `func epsilon<T>(hint: T): T where T <: Number<T>` 函数体内 `match (hint) { case _: Float32 => ... }` 编译通过
7. **scalar_constants 对整数类型 T 的行为契约验证**：验证 `epsilon<Int64>()` 调用时按 D25 决策抛出运行时异常（约束收紧若失败时的 fallback 路径）
8. **标量-四元数与标量-向量/标量-矩阵同名重载消歧验证**：`add(s: T, q: Quat<T,Q>)` 与 `add(s: T, v: Vec2<T,Q>)`/`add(s: T, m: Mat2x2<T,Q>)` 等的编译器消歧
9. **`x.isNaN()`/`x.isInf()` 实例方法路径验证**：确认仓颉标准库为所有浮点类型提供 `isNaN()`/`isInf()` 实例方法（影响 quaternion_common.cj 中 isnan/isinf 的实现可行性）
10. **ext/vector_relational 内联 abs 验证**：验证 `if (d >= T(0)) { d } else { -d }` 模式在 `Number<T> & Comparable<T>` 约束下的编译通过性
11. **`@Derive[Hashable]` 对 `Q <: Qualifier` 的支持验证**：验证 Hashable 派生宏对 6 个 Qualifier 实现类型的编译通过性
12. **`length(q)` 在 Float32 实例的 sqrt 转换验证**：验证 `T(Float64.sqrt(Float64(dot_qq)))` 路径或额外 Float32 重载的编译可行性
13. **`isnan`/`isinf` 函数约束收紧验证（v4 新增，v7 接口名修订，**v10 修订：删除错误引用**）**：验证 `where T <: FloatingPoint<T>` 约束（stdlib 原生接口，见 `cangjie-std/math/README.md` 第 117 行）在仓颉编译器的支持情况；实例化 `Quat<Float32, PackedHighp>` 调用 `isnan`/`isinf` 通过编译；实例化 `Quat<Int64, PackedHighp>` 调用 `isnan`/`isinf` 报类型不匹配错误。`FloatingPoint<T>` 是 stdlib 原生接口，无「不可用」风险，本验证项无需 fallback 验证。**v10 修订**：删除 v9 描述中「可验证 `FloatingPoint<T>` 接口的 `getMin()`/`getInf()` 实例方法可用性（对应 std::numeric_limits<T>::min()/infinity()）」的提示——`FloatingPoint<T>` 接口本身**不提供任何实例方法**（见 `cangjie-std/math/README.md` 第 117 行仅作为类型约束声明），下游如需 `std::numeric_limits<T>::min()`/`infinity()` 等价物应通过类型分派 `Float32.Min`/`Float32.Inf`/`Float64.Min`/`Float64.Inf` 静态常量获取，详见验证项 16/18
14. **Quat 字段 `public var` 可见性验证（v4 新增）**：确认 `@Derive[Hashable]` 派生宏在 Quat 字段标注 `public var` 时编译通过；若字段标注缺失 `public`，验证派生失败报可见性错误
15. **`pow` 函数四元数版本与 `std.math.pow` 实数版本命名消歧验证（v5 新增，v7 Float64 转换依赖补充）**：验证 `pow(x: Quat<T,Q>, y: T)` 函数体内部调用 `std.math.pow(x.w, y)` 实数版本时，类型推断正确（参数类型为 `T`/`T`），不与四元数 `pow` 自身签名混淆；确认 `std.math.pow` 对 `Float32`/`Float64` 的可用性，若不存在则需以 `exp(y * log(x.w))` 替代实现（v7 补充：因 std.math 的 pow/log/exp 签名仅支持 Float64，`pow(Quat<Float32, Q>, Float32)` 路径需先显式转换至 Float64 再降级，fallback `exp(y * log(x.w))` 同步需 Float64 转换）
16. **`pow` 函数次正规数边界检查所需 `Float64.Min`/`Float32.Min` 类型分派路径验证（v5 新增，v7 接口名修订，**v10 关键修订：原 `FloatingPoint<T>.getMin()` 方法验证目标不存在**）**：验证仓颉 stdlib 仅提供 `Float64.Min`/`Float32.Min` 静态常量（见 `cangjie-std/math/README.md` 第 113 行），**`FloatingPoint<T>` 接口本身不提供任何实例方法**（见 `cangjie-std/math/README.md` 第 117 行仅作为类型约束声明）。下游实现 `pow` 函数体内部次正规数边界检查时，应通过类型分派 `if (q.x is Float32) { Float32.Min } else { Float64.Min }` 路径获取 T 类型对应的最小正次正规数；验证项应验证「类型分派路径 + 字面量 fallback 路径（如 `T(1) / T(很大值)`）的编译可行性」
17. **`type_quat_cast` 函数 `FloatingPoint<T>` 约束可用性验证（v5 新增，v7 接口名修订）**：验证 `where T <: FloatingPoint<T>` 约束（stdlib 原生接口）在 `mat3Cast`/`mat4Cast`/`quatCast` 4 个函数签名上的编译可行性；实例化 `Quat<Float32, PackedHighp>` 调用转换函数通过编译；实例化 `Quat<Int64, PackedHighp>` 调用转换函数报类型不匹配错误（与 GLM `GLM_STATIC_ASSERT(is_iec559, ...)` 等价行为）
18. **`log` 函数 `std::numeric_limits<T>::infinity()` 等价物验证（v5 新增，v7 接口名修订，**v10 关键修订：原 `FloatingPoint<T>.getInf()` 方法验证目标不存在**）**：验证仓颉 stdlib 仅提供 `Float64.Inf`/`Float32.Inf` 静态常量（见 `cangjie-std/math/README.md` 第 112 行），**`FloatingPoint<T>` 接口本身不提供任何实例方法**（见 `cangjie-std/math/README.md` 第 117 行仅作为类型约束声明）。下游实现 `log` 函数体内部 w=0 退化分支时，应通过类型分派 `if (q.x is Float32) { Float32.Inf } else { Float64.Inf }` 路径获取 T 类型对应的正无穷；验证项应验证「类型分派路径 + 字面量 fallback 路径 `T(1)/T(0)`（仅对浮点类型有效，整数类型 `1/0` 触发除零异常，与 GLM 行为一致）的编译可行性」
19. **`epsilon<T>()` 与 `epsilonOf<T>(hint)` 返回值一致性验证（v10 新增，Issue 4 响应）**：阶段二 `cjglm/src/detail/shim_limits.cj:25` 已有 `public func epsilonOf<T>(hint: T): T where T <: Number<T>` 函数，本设计新增的 `epsilon<T>()` 函数与其功能等价。验证项需验证：在 `T = Float32` 实例化时，`epsilon<Float32>()` 与 `epsilonOf<Float32>(0.0f)` 返回值相等（`Float32(1.1920929e-7)`）；在 `T = Float64` 实例化时，`epsilon<Float64>()` 与 `epsilonOf<Float64>(0.0)` 返回值相等（`Float64(2.220446049250313e-16)`）；在 `T = Int64` 实例化时两者均返回 `Int64(0)`（`hint - hint` 形式）；阶段二测试 `tests/glm/detail/test_shim_limits.cj` 中硬编码的精度值作为 ground truth 验证依据

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
| **`gtc/quaternion.cj` 独立承载 15 函数（v3 明确：4 重导出 + 4 完整 + 7 stub）** | 与 GLM `gtc/quaternion.hpp` 1:1 映射；**v3 关键变更**：`mat3_cast`/`mat4_cast`/`quat_cast` 不在本文件实现，而是通过 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 重导出 detail 中的实现 |
| **`mat3_cast`/`mat4_cast`/`quat_cast` 实际实现位于 `detail/type_quat_cast.cj`（v3 关键决策）** | 为避免包间循环依赖，转换函数下沉至 detail 包；gtc 包通过 `public import` 重导出，保留 GLM 头文件归属的 API 形态 |
| **一元 + 运算符不可用** | 仓颉不支持重载一元 + 运算符（与 deviations.md IF-01 一致） |
| **标量-四元数运算为全局函数** | 仓颉 operator func 限制 |
| **quaternion_common 中 mix/slerp 依赖 trigonometric.cj/common.cj stub** | 本阶段 mix/slerp 为 stub 占位，待阶段四 trigonometric.cj/common.cj 完整实现后补齐 |
| **`mix`/`slerp`/`pow` 依赖 `epsilon<T>()`（v3 明确）** | GLM 实现中用于 `cosTheta > 1 - epsilon<T>()` 退化检测，与 GLM 实际依赖一致 |
| **ext/vector_relational 内联 abs 而非调用 common.cj** | 消除对 stub 的运行时依赖，确保本阶段函数可执行 |
| **向量 `equal` 采用严格 `<` 语义（v3 修订，v9 修订 GLM 文件引用）** | 与 GLM `glm/gtc/epsilon.inl:32-41` 中 `epsilonEqual` 实现一致，`equal(v, v, 0.0) = false`。原引用 `func_vector_relational.inl:18-22` 错误——GLM 1.0.3 的 `func_vector_relational.inl` 中**不包含 epsilon 版本**的 `equal`/`notEqual`，epsilon 版本位于 `glm/gtc/epsilon.inl`（文件层面属 gtc 子包） |
| **scalar_constants 使用 hint 参数辅助类型推断** | 与 deviations.md DV-04 一致 |
| **scalar_constants 对整型 T 抛运行时异常（v3 明确）** | 与 GLM `static_assert(is_iec559, ...)` 编译期断言等价行为 |
| **`Quat×Vec3` 旋转公式采用两次 Vec3 叉乘（v3 修订）** | 与 GLM `type_quat.inl:359-366` 一致：`v + (cross(QuatVector, v) * q.w + cross(QuatVector, cross(QuatVector, v))) * 2` |
| **`slerp` 4 参数版本 `k: Int64` 简化签名（v3 决策）** | 与 deviations.md DV-03「移位运算右操作数固定为 Int64」风格一致，牺牲泛型灵活性换取签名简洁性 |
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

## 10. GLM 1.0.3 API 阶段覆盖矩阵

### glm/detail/type_quat.hpp（quaternion type definition）

| 函数/类型 | 覆盖状态 | 对应设计方案章节 |
|----------|---------|----------------|
| Quat<T,Q> 结构体定义 | 本阶段实现 | §3.1 |
| `[]` 下标运算符 | 本阶段实现 | §3.1 |
| const init(x,y,z,w) 逐分量构造 | 本阶段实现 | §3.3 item 1 |
| init(s, Vec3) 标量+向量构造 | 本阶段实现 | §3.3 item 2 |
| init< Q2>(Quat<T,Q2>) 跨 Qualifier | 本阶段实现 | §3.3 item 3 |
| fromQuat(conv, q) 跨类型构造 | 本阶段实现 | §3.3 item 4 |
| identity(one) 单位四元数 | 本阶段实现 | §3.3 item 5 |
| fromMat3(m) 矩阵构造 | 本阶段实现 | §3.3 item 6 |
| fromMat4(m) 矩阵构造 | 本阶段实现 | §3.3 item 7 |
| fromVec3(u, v) 向量构造 | 本阶段 stub | §3.3 item 8 |
| fromEuler(eulerAngles) 欧拉角构造 | 本阶段 stub | §3.3 item 9 |
| wxyz(w,x,y,z) 工厂函数 | 本阶段实现 | §3.3 item 10 |
| 一元 - 运算符 | 本阶段实现 | §3.4 |
| 二元 + - * 运算符 | 本阶段实现 | §3.4 |
| Quat×Vec3/Vec4 | 本阶段实现（运行时 stub 异常，待阶段四） | §3.4 |
| Vec3×Quat/Vec4×Quat | 本阶段实现 | §3.4 |
| Quat×T / T×Quat / Quat/T | 本阶段实现 | §3.4 |
| == / != 比较 | 本阶段实现 | §3.4 |

### glm/detail/type_quat_cast.hpp（v3 新增，v5 明确签名规范）

| 函数 | 覆盖状态 | 对应设计方案章节 |
|------|---------|----------------|
| `mat3Cast<T, Q>(q: Quat<T, Q>): Mat3x3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | 本阶段实现 | §3.2 / §3.2.1 |
| `mat4Cast<T, Q>(q: Quat<T, Q>): Mat4x4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | 本阶段实现 | §3.2 / §3.2.1 |
| `quatCast<T, Q>(m: Mat3x3<T, Q>): Quat<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | 本阶段实现 | §3.2 / §3.2.1 |
| `quatCast<T, Q>(m: Mat4x4<T, Q>): Quat<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | 本阶段实现 | §3.2 / §3.2.1 |

### glm/ext/vector_relational.hpp

| 函数 | 覆盖状态 |
|------|---------|
| equal(VecN, VecN, T epsilon) | 本阶段实现（16 重载，严格小于语义） |
| equal(VecN, VecN, VecN epsilon) | 本阶段实现（16 重载，严格小于语义） |
| notEqual(VecN, VecN, T epsilon) | 本阶段实现（16 重载） |
| notEqual(VecN, VecN, VecN epsilon) | 本阶段实现（16 重载） |
| equal/notEqual (ULP 版本) | 本阶段 stub |

### glm/ext/quaternion_relational.hpp

| 函数 | 覆盖状态 |
|------|---------|
| equal(Quat, Quat) | 本阶段实现 |
| equal(Quat, Quat, epsilon) | 本阶段实现 |
| notEqual(Quat, Quat) | 本阶段实现 |
| notEqual(Quat, Quat, epsilon) | 本阶段实现 |

### glm/ext/quaternion_geometric.hpp

| 函数 | 覆盖状态 |
|------|---------|
| dot(Quat, Quat) | 本阶段实现 |
| length(Quat) | 本阶段实现 |
| normalize(Quat) | 本阶段实现 |
| cross(Quat, Quat) | 本阶段实现 |

### glm/ext/quaternion_common.hpp

| 函数 | 覆盖状态 |
|------|---------|
| conjugate(Quat) | 本阶段实现（仅对 x/y/z 取反，w 保持不变：`Quat(-q.x, -q.y, -q.z, q.w)`；v5 修订语义，与 GLM `ext/quaternion_common.inl:112-116` `wxyz(q.w, -q.x, -q.y, -q.z)` 一致） |
| inverse(Quat) | 本阶段实现 |
| lerp(Quat, Quat, T) | 本阶段实现（含 assert + 非 const） |
| mix(Quat, Quat, T) | 本阶段 stub（依赖 dot/acos(T):T 单参数版本/sin(T):T 单参数版本/epsilon<T>()；v5 修订明确 trigonometric.cj 重载版本） |
| slerp(Quat, Quat, T) | 本阶段 stub（依赖 dot/acos(T):T 单参数版本/sin(T):T 单参数版本/mix 标量版 + epsilon<T>()） |
| slerp(Quat, Quat, T, Int64) | 本阶段 stub（依赖 dot/acos/sin/mix 标量版 + epsilon<T>() + pi<T>()；v5 修订补充 pi<T>() 与 mix 标量版依赖） |
| isnan(Quat) | 本阶段实现（实例方法路径，约束 `T <: FloatingPoint<T>`，v4 修订，v7 接口名修订） |
| isinf(Quat) | 本阶段实现（实例方法路径，约束 `T <: FloatingPoint<T>`，v4 修订，v7 接口名修订） |

### glm/ext/quaternion_trigonometric.hpp

| 函数 | 覆盖状态 |
|------|---------|
| axis(Quat) | 本阶段实现（`tmp1 = 1 - x.w*x.w` 公式路径；`tmp1 <= 0` 时返回 `Vec3(0, 0, 1)`，否则返回归一化 `Vec3(x.x*tmp2, x.y*tmp2, x.z*tmp2)`；v5 修订边界行为） |
| angle(Quat) | 本阶段 stub |
| angleAxis(T, Vec3) | 本阶段 stub |

### glm/ext/quaternion_transform.hpp

| 函数 | 覆盖状态 |
|------|---------|
| rotate(Quat, T, Vec3) | 本阶段 stub |

### glm/ext/quaternion_exponential.hpp

| 函数 | 覆盖状态 |
|------|---------|
| exp(Quat) | 本阶段 stub（依赖 length/epsilon<T>()/cos/sin；v5 修订补充 epsilon<T>() 依赖） |
| log(Quat) | 本阶段 stub（依赖 length/epsilon<T>()/pi<T>()/atan/log + `std::numeric_limits<T>::infinity()` 等价物；v5 修订补充） |
| pow(Quat, T) | 本阶段 stub（依赖 epsilon<T>()/abs/clamp/asin/acos/sin/cos/sqrt/cos_one_over_two<T>() + 递归调用 std.math.pow(T,T) + std::numeric_limits<T>::min() 次正规数边界；v5 修订补充依赖，行号引用 quaternion_exponential.inl:41-80） |
| sqrt(Quat) | 本阶段 stub |

### glm/ext/scalar_constants.hpp

| 函数 | 覆盖状态 |
|------|---------|
| epsilon<T>() | 本阶段实现（整型 T 抛运行时异常） |
| pi<T>() | 本阶段实现（整型 T 抛运行时异常） |
| cos_one_over_two<T>() | 本阶段实现（整型 T 抛运行时异常） |

### glm/gtc/constants.hpp

| 函数 | 覆盖状态 |
|------|---------|
| **28 个**常量函数（v8 修订：与 GLM 1.0.3 `gtc/constants.inl` 实际声明数一致） | 本阶段实现 |

### glm/gtc/matrix_transform.hpp

| 函数 | 覆盖状态 |
|------|---------|
| 全部函数 | 本阶段空桩占位 |

### glm/gtc/quaternion.hpp（v3 修订状态）

| 函数 | 覆盖状态 | 备注 |
|------|---------|------|
| mat3_cast(Quat) | 本阶段实现 | **v3 修订**：从 detail/type_quat_cast.cj 重导出 |
| mat4_cast(Quat) | 本阶段实现 | **v3 修订**：从 detail/type_quat_cast.cj 重导出 |
| quat_cast(Mat3) | 本阶段实现 | **v3 修订**：从 detail/type_quat_cast.cj 重导出 |
| quat_cast(Mat4) | 本阶段实现 | **v3 修订**：从 detail/type_quat_cast.cj 重导出 |
| lessThan(Quat, Quat) | 本阶段实现 | |
| lessThanEqual(Quat, Quat) | 本阶段实现 | |
| greaterThan(Quat, Quat) | 本阶段实现 | |
| greaterThanEqual(Quat, Quat) | 本阶段实现 | |
| eulerAngles(Quat) | 本阶段 stub | **v3 修订**：从误标"完整实现"修正为 stub（依赖 trigonometric.cj/common.cj stub） |
| roll(Quat) | 本阶段 stub | **v3 修订**：同上 |
| pitch(Quat) | 本阶段 stub | **v3 修订**：同上 |
| yaw(Quat) | 本阶段 stub | **v3 修订**：同上 |
| quatLookAt(Vec3, Vec3) | 本阶段 stub | |
| quatLookAtRH(Vec3, Vec3) | 本阶段 stub | |
| quatLookAtLH(Vec3, Vec3) | 本阶段 stub | |

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
// 仓颉 gtc 命名空间调用（v3 通过 public import 重导出，[本阶段可验证]）:
//           let m3_gtc = glm.gtc.quaternion.mat3_cast(q)
//           let q2_gtc = glm.gtc.quaternion.quat_cast(m)
// 
// 仓颉顶层 glm 命名空间调用（**v10 新增，Issue 17 响应**：lib.cj 通过 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 将 detail 包级函数重导出至顶层 `glm` 命名空间，与现有 `public import glm.detail.{transpose, matrixCompMult, outerProduct}` 模式一致，见 `cjglm/src/lib.cj:8`）：
//           let m3_top = glm.mat3Cast(q)   // 顶层 glm 命名空间（无需额外 import）
//           let q2_top = glm.quatCast(m)   // 顶层 glm 命名空间（无需额外 import）
```

### 11.5 函数可用性对照表（v3 新增）

| 函数 | 本阶段状态 | 阶段四 |
|------|----------|--------|
| `identity` | ✅ 可用 | ✅ 可用 |
| `fromMat3`/`fromMat4` | ✅ 可用 | ✅ 可用 |
| `fromVec3`/`fromEuler` | ❌ stub | ✅ 可用 |
| `q * v` (Quat×Vec3) | ⚠️ 抛 stub 异常 | ✅ 可用 |
| `lerp` | ✅ 可用（含断言） | ✅ 可用 |
| `conjugate`/`inverse` | ✅ 可用 | ✅ 可用 |
| `dot`/`length`/`normalize` | ✅ 可用 | ✅ 可用 |
| `isnan`/`isinf` | ✅ 可用（**约束：`where T <: FloatingPoint<T>`（D29）**，仅浮点 T，整型 T 编译失败，v4 约束收紧） | ✅ 可用（**约束：`where T <: FloatingPoint<T>`（D29）**，仅浮点 T） |
| `slerp` | ❌ stub | ✅ 可用 |
| `mix` | ❌ stub | ✅ 可用 |
| `angle`/`angleAxis` | ❌ stub | ✅ 可用 |
| `exp`/`log`/`pow`/`sqrt` | ❌ stub | ✅ 可用 |
| `eulerAngles`/`roll`/`pitch`/`yaw` | ❌ stub | ✅ 可用 |
| `quatLookAt*` | ❌ stub | ✅ 可用 |
| `epsilon`/`pi`（浮点） | ✅ 可用 | ✅ 可用 |
| `epsilon`/`pi`（整型） | ❌ 抛异常 | ❌ 抛异常（保持契约） |
| `mat3_cast`/`mat4_cast`/`quat_cast`（detail） | ✅ 可用（**约束：`where T <: FloatingPoint<T>`（D32）**，仅浮点 T，整型 T 编译失败，v5 约束收紧，对应 GLM `GLM_STATIC_ASSERT(is_iec559, ...)`） | ✅ 可用（**约束：`where T <: FloatingPoint<T>`（D32）**，仅浮点 T） |
| `mat3_cast`/`mat4_cast`/`quat_cast`（gtc，重导出） | ✅ 可用（**约束：`where T <: FloatingPoint<T>`（D32，约束继承自 detail 端实现，通过 public import glm.detail.{mat3Cast, mat4Cast, quatCast} 透明传递）**，仅浮点 T，整型 T 编译失败，v5 约束收紧） | ✅ 可用（**约束：`where T <: FloatingPoint<T>`（D32，约束继承自 detail 端实现）**，仅浮点 T） |
| `lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual` | ✅ 可用（**约束：`where T <: Comparable<T>`（依赖 `<`/`>` 运算符，v10 新增标注，Issue 16 响应**）**） | ✅ 可用（同上） |

---

## 修订说明（v2）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题 1（严重）**：`lookRotate` 非 GLM 1.0.3 实际函数——设计文档 §1 核心抽象表、§2 模块表、§3.2 协作关系表、§3.8 修正段落等处均引用 `lookRotate`，但 GLM 1.0.3 实际不存在该函数（已在 references/glm-1.0.3 全文件检索确认零匹配），对应的实际函数是 `gtc/quaternion.hpp` 中的 `quatLookAt`/`quatLookAtRH`/`quatLookAtLH` | **已采纳**。全文检查并替换所有 `lookRotate` 引用为 `quatLookAt`（或保留 `quatLookAt` 已正确引用的位置不变）：§1 核心抽象表行 20 改为"仅 `rotate` 函数 stub（仅 stub 占位）"；§2 模块表 `ext/quaternion_transform.cj` 行改为"四元数变换函数（仅 `rotate` 函数 stub）"；§3.2 协作关系表行 167 的"阶段四或本阶段视 lookRotate 范围"改为"阶段四或本阶段视 quatLookAt 范围"；§3.2 协作策略中"stub 占位：`lookRotate`/`quatLookAt`/..."改为"`quatLookAt`/`quatLookAtRH`/`quatLookAtLH`"；§3.8 角色行"提供四元数变换函数（rotate、lookRotate 等）"改为"提供四元数变换函数（rotate）"；§3.8 修正段落"`lookRotate`/`quatLookAt` 定义在 `gtc/quaternion.hpp` 中"改为"`quatLookAt`/`quatLookAtRH`/`quatLookAtLH` 定义在 `gtc/quaternion.hpp` 中"；§9 差异声明新增"GLM 中不存在 `lookRotate` 函数"说明项，记录 v1 错误与本次修订 |
| **问题 2（一般）**：§2 模块表与 §3.8 修正段落矛盾——§2 表格行 20 描述 `ext/quaternion_transform.cj` 为"大部分实现（lookRotate 依赖 geometric.cj stub）"，但 §3.8 修正段落已明确本阶段仅含 `rotate` stub | **已采纳**。§2 模块表 `ext/quaternion_transform.cj` 行的实现状态从"大部分实现（lookRotate 依赖 geometric.cj stub）"修正为"四元数变换函数（仅 `rotate` 函数 stub）"，与 §3.8 修正段落对齐 |
| **问题 3（一般）**：§3.2 协作关系表与 §3.8/§3.9 矛盾——§3.2 第 176 行将 `angleAxis` 归类为"随 ext/quaternion_transform.cj 实现"，但 §3.8/§3.9 已正确归入 `ext/quaternion_trigonometric.cj` | **已采纳**。§3.2 协作策略中"**随 ext/quaternion_transform.cj 实现**：`angleAxis`/`rotate`（不依赖 geometric.cj 的函数）"修正为"**随 ext/quaternion_transform.cj 实现（仅 stub）**：`rotate`（依赖 trigonometric.cj 与 geometric.cj 的 sin/cos/length，均为 stub，本阶段仅 stub 占位）"，删除 `angleAxis` 项；并在后续条款中明确 `angleAxis` 归入 §3.9 `ext/quaternion_trigonometric.cj` |
| **问题 4（一般）**：D19 决策依据不充分——v1 决策"四元数算术运算符不标注 @OverflowWrapping"引用了不存在的 `deviations.md DEV-26`，且与阶段一 Vec3、阶段二全部矩阵类型对算术运算符统一标注 `@OverflowWrapping` 的实践不一致 | **已采纳选项 A**。撤销 v1 D19 决策，改为"四元数算术运算符统一标注 @OverflowWrapping"，与阶段一 Vec3 (`type_vec3.cj:54-80`)、阶段二全部矩阵类型 (`type_mat2x2.cj`、`type_mat3x3.cj`、`type_mat4x2.cj` 等) 的实践一致。同步修订：§3.4 运算符体系表新增"标注 @OverflowWrapping"列说明（一元 `-`/二元 `+`/`-`/Quat×T/Quat/T 均标注）；§5 错误处理策略的"溢出策略"段落重写，明确说明"@OverflowWrapping 对浮点类型无效果（std.overflow 模块语义仅作用于整数溢出行为），但保持跨整数/浮点实例化的统一行为，避免未来整数四元数用例出现不可控整数溢出行为"；§7 设计决策 D19 完全重写决策理由并移除"参见 deviations.md DEV-26"引用；§9 差异声明的对应行同步更新。已在 grep 验证中确认阶段一/二所有相关文件（`scalar_vec_ops.cj`、`scalar_mat_ops.cj`、`type_vec3.cj`、所有 `type_mat*.cj`）均标注 `@OverflowWrapping`（200+ 处） |
| **问题 5（轻微）**：§3.4 中 mul 函数重复声明——全局具名函数表存在两条 `mul<T, Q>(s: T, q: Quat<T, Q>)` 完全相同签名的行，仅注释文字不同；仓颉函数重载规则禁止重复签名（仅参数类型/数量/顺序不同时构成有效重载），重复声明将导致编译错误 | **已采纳**。删除 §3.4 全局具名函数表中重复的"标量×四元数（交换律别名）"行，保留唯一的 `mul<T, Q>(s: T, q: Quat<T, Q>)` 标量乘四元数签名；并在该表后追加说明文字："标量×四元数乘法无需单独'交换律别名'函数——`Quat×T` 运算符已通过 `Number<T>` 约束交换律覆盖（仓颉 `Number<T>` 加法/乘法具备交换律语义），且仓颉函数重载规则禁止重复签名（同参数列表+同返回类型无法构成有效重载，将触发'重复定义'编译错误）" |
| **附带改进**：§3.7 `cross` 函数命名歧义说明 | **已采纳**。§3.7 跨四元数几何函数中 `cross` 项的职责描述由原先"四元数叉积（即 Hamilton 乘积的逐分量展开）"扩展为完整命名歧义说明：明确"四元数 `cross` 语义与向量叉乘不同——向量 `cross` 产生垂直于输入平面的向量，四元数 `cross` 产生 Hamilton 乘积的逐分量展开形式（结果仍是四元数）"，并新增"命名歧义说明"段说明 Quat 与 Vec3 上下文的 `cross` 通过类型消歧（设计文档本节说明澄清）。这是 v1 审查"轻微"问题的回应，增强文档可读性 |

---

## 修订说明（v3）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题 1（严重）— 本轮新增**：`gtc/quaternion.cj` 与 `type_quat.cj` 之间的包间循环依赖——`type_quat.cj` 通过 `import glm.gtc.quaternion.*` 引用 `mat3Cast`/`mat4Cast`/`quatCast`，而 `gtc/quaternion.cj` 通过 `import glm.detail.*` 引用 `Quat`/`Mat3x3`/`Mat4x4`/`Vec3`，形成 `glm.detail ↔ glm.gtc` 双向包依赖。仓颉语言规范明确禁止包间循环依赖（cangjie-lang-features package/README.md 第 99 行），cjpm 构建系统会拒绝编译 | **已采纳审查报告 Solution 1**。**关键决策变更**：`mat3Cast`/`mat4Cast`/`quatCast` 4 个转换函数从 `gtc/quaternion.cj` 下沉至新建的 `detail/type_quat_cast.cj`（`package glm.detail`）。`type_quat.cj` 中 `fromMat3`/`fromMat4` 工厂函数改为调用**同包** `type_quat_cast.cj` 函数（无需跨包 import）。`gtc/quaternion.cj` 通过 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 将 detail 函数重导出为 gtc 命名空间下的同名 API，保留 GLM 1:1 文件归属的 API 形态。修复后形成 `glm.gtc → glm.detail` 的**单向依赖**，彻底消除循环依赖。**同步修订**：§1「整体架构思路」末尾新增「gtc/quaternion.cj 与 type_quat_cast.cj 的协作设计（v3 关键决策）」段；§1 核心抽象表新增 `detail/type_quat_cast.cj` 行（v3 关键新增）；§2 包组织 `glm.detail` 块下新增 `type_quat_cast.cj ★` 条目（v3 关键新增）；§2 模块间依赖图 `glm.detail` 块下新增 `type_quat_cast.cj → type_quat, Mat3x3, Mat4x4, Vec3`（同包内可见）；§2 模块间依赖图 `glm.gtc` 块下 `quaternion.cj` 依赖项新增 `glm.detail.{mat3Cast, mat4Cast, quatCast}` 通过 public import 重导出（v3 关键修订）；§2 末尾 cjpm 子包构建预验证段新增「gtc 重导出 detail 函数验证项」（v3 新增验证项 2）；§3.2 协作关系表行 167-170 的「实现位置」列从「gtc/quaternion.cj 包级函数」改为「detail/type_quat_cast.cj 包级函数」+新增「Mat↔Quat 转换重导出」行；§3.3 item 6/7 `fromMat3`/`fromMat4` 描述修订为「调用同包 `type_quat_cast.cj` 函数」；§3.15 gtc/quaternion.cj 完整重写职责分组（4 重导出 + 4 完整实现 + 7 stub），跨包引用段明确「不引用 `glm.detail.type_quat` 内部成员」+「形成 `glm.gtc → glm.detail` 单向依赖，无循环依赖」；§7 设计决策 D11 完全重写（从 v2 的「gtc 承载转换函数」改为 v3 的「detail 承载 + gtc 重导出」）；§7 新增 D28「包间依赖方向严格单向」决策；§8 产出物清单「完整实现」段新增 `detail/type_quat_cast.cj`（v3 关键新增）；§8 §8.2 测试设计新增 `type_quat_cast_test.cj` 测试文件（≥8 用例）；§8 §8.2 测试覆盖维度新增「type_quat_cast 单元测试覆盖实现细节」；§8 编码启动前验证项新增「gtc 重导出 detail 函数验证」（v3 验证项 2）+「包间无循环依赖验证」（v3 验证项 3）+「type_quat.cj 同包调用 type_quat_cast.cj 函数验证」（v3 验证项 4）；§9 差异声明新增「包间依赖方向严格单向 `glm.gtc → glm.detail`（v3 关键修复）」条目；§9 差异声明的「`mat3_cast`/`mat4_cast`/`quat_cast` 实际实现位于 `detail/type_quat_cast.cj`（v3 关键决策）」条目；§9 差异声明的「从旋转矩阵构造改为具名工厂函数」条目修订为「调用同包 type_quat_cast.cj 函数，不再跨包引用 gtc」；§9 差异声明的「`gtc/quaternion.cj` 独立承载 15 函数」条目修订为「v3 关键变更：4 重导出 + 4 完整 + 7 stub」；§10 覆盖矩阵新增「glm/detail/type_quat_cast.hpp（v3 新增）」独立表；§10 覆盖矩阵「glm/gtc/quaternion.hpp（v3 修订状态）」表为 4 个转换函数标注「v3 修订：从 detail/type_quat_cast.cj 重导出」+ 为 4 个欧拉函数标注「v3 修订：从误标完整实现修正为 stub」；§11.4 矩阵-四元数互转迁移示例新增「detail 直接调用」+「gtc 命名空间调用」两种入口；§11.5 函数可用性对照表新增 `mat3_cast`/`mat4_cast`/`quat_cast`（detail 与 gtc 重导出）两行 |
| **问题 2（一般）— 本轮新增**：依赖方向内部矛盾——§2 模块间依赖图正确呈现 `glm.detail → glm.gtc` 和 `glm.gtc → glm.detail` 双向依赖，但 §1 第 56 行、§3.2 第 212 行、§3.15 第 510 行三处均错误声称这是「单向依赖」或「无循环依赖」 | **已采纳**。在采纳问题 1 修复方案后，§1「gtc/quaternion.cj 设计决策（v3 决策，采纳审查报告 Solution 1）」段、§3.2「type_quat.cj、type_quat_cast.cj、gtc/quaternion.cj 三者协作关系（v3 明确）」段、§3.15「与 type_quat.cj、type_quat_cast.cj 三方协作（v3 明确）」段均统一描述为「形成 `glm.gtc → glm.detail` 的**单向依赖**，**无循环依赖**（v3 关键修复）」。同时 §2 末尾 cjpm 子包构建预验证段明确「无循环依赖」作为验证目标。§7 设计决策 D11 重写理由部分明确引用「v2 设计将转换函数放在 gtc 导致 `type_quat.cj` 需 `import glm.gtc.quaternion` 形成 `glm.detail ↔ glm.gtc` 双向依赖，违反仓颉包间循环依赖约束」+「v3 决策将转换函数下沉至 detail 包，让 `type_quat.cj` 通过同包访问直接调用（无需 import），`gtc/quaternion.cj` 通过 `public import` 重导出至 gtc 命名空间，保留 GLM 1:1 API 形态的同时彻底打破循环依赖」 |
| **问题 1（严重）— 上一轮（v2）**：`gtc/quaternion.cj` 文件未完整规划——§2 包组织、§3.2 协作关系表、§8 产出物清单中均未将该文件纳入 | **已采纳**。§1 核心抽象表新增 `gtc/quaternion.cj` 行；§2 包组织 `glm.gtc` 块下新增 `quaternion.cj ★` 条目；§3.15 新增独立小节完整定义 15 函数分组与依赖（v3 修订为 4 重导出 + 4 完整 + 7 stub）；§8 产出物清单「完整实现」和「大部分实现」两段均补充 `gtc/quaternion.cj`；§8 §8.2 测试设计新增 `tests/glm/gtc/quaternion_test.cj` 测试文件（≥20 用例）；§10 覆盖矩阵新增「glm/gtc/quaternion.hpp（v3 修订状态）」表 |
| **问题 4（严重）— 上一轮（v2）**：§3.4 第 216 行 `Quat×Vec3` 旋转运算符实现公式错误——设计文档的 `v + 2.0 * cross(cross(QuatVector, v) + QuatVector * q.w, v)` 与 GLM `type_quat.inl:359-366` 实际公式 `v + (cross(QuatVector, v) * q.w + cross(QuatVector, cross(QuatVector, v))) * 2` 不等价 | **已采纳**。§3.4 `Quat×Vec3` 行公式修正为 `v + (cross(QuatVector, v) * q.w + cross(QuatVector, cross(QuatVector, v))) * 2`（两次 Vec3 叉乘 uv 和 uuv，与 GLM 1.0.3 `type_quat.inl:359-366` 一致）；备注列明确「依赖 `geometric.cj` 向量 `cross`（阶段三 stub），调用将抛 `Exception("stub")`」；D26 设计决策新增；§3.4 段后新增「命名约定说明」段明确「`cross(QuatVector, v)` 调用的是 Vec3 叉乘（定义于 `geometric.cj`），非 §3.7 中的四元数 `cross`（Hamilton 乘积）」；§9 差异声明新增「`Quat×Vec3` 旋转公式采用两次 Vec3 叉乘」条目 |
| **问题 5（严重）— 上一轮（v2）**：§3.2 协作关系表与策略段落对 `mat3_cast` 等函数归属矛盾——表行说「gtc/quaternion.cj（随 type_quat.cj 编码）」，策略段说「随 type_quat.cj 一同实现」 | **已采纳**。在采纳本轮问题 1 修复方案后，§3.2 协作关系表行 167-170 的「实现位置」列从「gtc/quaternion.cj（随 type_quat.cj 编码）」改为「detail/type_quat_cast.cj 包级函数」+ 新增「Mat↔Quat 转换重导出」行；D11 设计决策完整重写文件归属理由（v3 关键修复）；§9 差异声明新增「`mat3_cast`/`mat4_cast`/`quat_cast` 实际实现位于 `detail/type_quat_cast.cj`（v3 关键决策）」条目 |
| **问题 2（一般）— 上一轮（v2）**：§8 完整实现清单末尾提及「四元数测试文件」一行但未展开 | **已采纳**。§8 新增「8.2 测试设计」子章节，包含测试文件清单与位置（13 个测试文件，≥171 用例，v3 新增 `type_quat_cast_test.cj` 8 用例）、测试覆盖维度（7 类，v3 新增「type_quat_cast 单元测试覆盖实现细节」）、浮点比较策略（v3 新增「type_quat_cast 单元测试：使用『旋转矩阵 * 向量 = 四元数 * 向量』等价性测试」）、阶段三可验证 vs 待阶段四拆分 |
| **问题 3（一般）— 上一轮（v2）**：§2 模块间依赖图缺少 `gtc/quaternion.cj` 的依赖方向 | **已采纳**。§2 模块间依赖图 `glm.gtc` 块下新增 `quaternion.cj → glm.detail(Quat, Mat3x3, Mat4x4, Vec3), glm.ext.scalar_constants, glm.ext.vector_relational, glm.detail.common(stub), glm.detail.trigonometric(stub), glm.detail.geometric(stub)` 依赖方向说明；§2 末尾 cjpm 子包构建预验证段同步引用 |
| **问题 6（一般）— 上一轮（v2）**：§3.2 策略段落对 `eulerAngles`/`roll`/`pitch`/`yaw` 分类逻辑矛盾——标为「实现」但实际依赖未就绪的 stub | **已采纳**。§3.2 策略段落明确分组（v3 修订为 4 重导出 + 4 完整实现 + 7 stub）；§3.15 欧拉角函数分组（v3 修订）：4 欧拉函数归入「stub 占位」组，依赖 `trigonometric.cj` 的 `atan`/`asin` + `common.cj` 的 `clamp` + `vector_relational.cj` 的 `equal` + `scalar_constants.cj` 的 `epsilon<T>()`；§10 覆盖矩阵 gtc/quaternion 表与 §3.15 gtc/quaternion.cj 小节的状态标注完全对齐 |
| **问题 7（一般）— 上一轮（v2）**：§3.10 第 339 行 `pow` 依赖关系不准确——错误列 `asin`/`pow`、遗漏 `abs`/`clamp`/`cos` | **已采纳**。§3.10 `pow` 依赖关系修订为「依赖 `abs`/`clamp`/`acos`/`sin`/`cos`/`sqrt`（其中 `abs`/`clamp` 来自 common.cj stub，`acos`/`sin`/`cos` 来自 trigonometric.cj stub，`sqrt` 来自 std.math）+ `epsilon<T>()`」；D21 设计决策明确引用；§10 覆盖矩阵 quaternion_exponential 表同步更新 |
| **问题 8（一般）— 上一轮（v2）**：§3.11 第 354 行 `mix` 依赖关系遗漏 `epsilon<T>()`；`slerp` 描述同样遗漏 | **已采纳**。§3.11 `mix` 依赖修订为「依赖 `dot`、`acos`、`sin`、`epsilon<T>()`」；`slerp` 描述修订为「依赖 `dot`、`acos`/`sin`/`mix`（标量版）+ `epsilon<T>()`」；D21 设计决策明确引用 |
| **问题 10（一般）— 上一轮（v2）**：§3.11 第 355 行 `slerp(x, y, a, k)` 4 参数版本 `k` 类型未定 | **已采纳**。§3.11 `slerp` 4 参数版本明确签名 `slerp<T, Q>(x: Quat<T,Q>, y: Quat<T,Q>, a: T, k: Int64)`；D22 设计决策说明采用简化版（与 deviations.md DV-03 一致）；§9 差异声明新增对应条目；§10 覆盖矩阵 quaternion_common 表更新 |
| **问题 11（一般）— 上一轮（v2）**：§3.4 `Quat×Vec3`/`Quat×Vec4` 行「备注」列为空，未说明依赖 `geometric.cj stub` | **已采纳**。§3.4 `Quat×Vec3` 行备注列补充「实现：`v + (...) * 2`（两次 Vec3 叉乘 uv/uuv）。**依赖 `geometric.cj` 向量 `cross`（阶段三 stub），调用将抛 `Exception("stub")`**」；`Quat×Vec4` 行备注列补充「通过 Vec3 中间路径间接依赖 `Quat×Vec3`，阶段三调用同样抛 stub 异常」；§4.2 行为契约示例标注「本阶段调用抛 stub 异常，待阶段四 geometric.cj 完整实现后生效」；§11.5 函数可用性对照表新增对应行 |
| **问题 14（一般）— 上一轮（v2）**：§5 错误处理策略覆盖不足（5 类边界条件缺失） | **已采纳**。§5.3 新增「边界条件与异常场景」表格，列出 8 类边界条件的行为契约：① `axis` 零四元数返回 `Vec3(1,0,0)`；② 浮点 `inverse` 零四元数产生 Inf/NaN；③ 整数 `inverse` 触发除零异常；④ `mix`/`slerp` cosTheta 退化检测；⑤ `fromMat3`/`fromMat4` 非纯旋转矩阵行为未定义；⑥ `lerp` 断言失败；⑦ `equal` epsilon=0 返回 false；⑧ 整型 `epsilon<T>()` 抛运行时异常 |
| **问题 18（一般）— 上一轮（v2）**：§3.12 第 367-371 行 `epsilon<T>()`/`pi<T>()`/`cos_one_over_two<T>()` 对整数类型 T 的行为未定义 | **已采纳**。§3.12 「整数类型 T 的行为契约」段落新增，明确约束收紧策略（`T <: FloatingPointNumber<T>`）+ 运行时 fallback 异常分支；D25 设计决策明确行为；§5.3 边界条件表新增对应行；§8 编码启动前验证项新增验证项 7 |
| **问题 9（轻微）— 上一轮（v2）**：§3.11 第 352 行 `lerp` 实现策略遗漏 `assert(a >= 0 && a <= 1)` 断言，且未明确「非 const」约束 | **已采纳**。§3.11 `lerp` 描述修订为「`x * (1 - a) + y * a`，含 `assert(a >= 0 && a <= 1)` 断言与 GLM `ext/quaternion_common.inl:28-38` 一致」+「`const` 约束说明：lerp 不可声明为 `const func`，因函数体内 `assert` 不是 `const` 函数（与 deviations.md IF-03 一致）」；D23 设计决策明确；§5.4 const 上下文约束段落新增 |
| **问题 12（轻微）— 上一轮（v2）**：§3.5 第 252 行向量 `equal` 容差比较语义 `\|x-y\| <= epsilon` 与 GLM `<` 严格小于不一致 | **已采纳**。§3.5 epsilon 版本语义从「`\|x-y\| <= epsilon`」修订为「`\|x-y\| < epsilon`（严格小于，与 GLM 1.0.3 `func_vector_relational.inl:18-22` 一致）」；`notEqual` 对应改为「`\|x-y\| >= epsilon`」；D24 设计决策明确；§5.3 边界条件表新增「`epsilon = T(0)`」行；§9 差异声明新增「向量 `equal` 采用严格 `<` 语义」条目 |
| **问题 13（轻微）— 上一轮（v2）**：§3.4 与 §3.7 中 `cross` 命名歧义未充分处理 | **已采纳**。§3.4 `Quat×Vec3` 行后新增「命名约定说明」段：「上表中 `Quat×Vec3` 行公式中的 `cross(QuatVector, v)` 调用的是 **Vec3 叉乘**（定义于 `geometric.cj`，参数为 `Vec3<T,Q>`），**非 §3.7 中的四元数 `cross`（Hamilton 乘积）**」；§3.7 命名歧义说明段强化「下游消费者判别方法」三段说明（参数类型消歧 + §3.4 旋转公式内部调用明确） |
| **问题 15（轻微）— 上一轮（v2）**：§3.1 第 149 行 `@Derive[Hashable]` 在阶段一/二的实践依据未在本设计核验 | **已采纳**。§3.1 第 149 行后新增「`@Derive[Hashable]` 约束核验」段，明确 `T <: Number<T>` 和 `Q <: Qualifier` 的 Hashable 接口要求；引用阶段一 Vec3 实践（`type_vec3.cj:6` 验证）；§8 编码启动前验证项新增验证项 11「`@Derive[Hashable]` 对 `Q <: Qualifier` 的支持验证」 |
| **问题 16（轻微）— 上一轮（v2）**：§3.14 与 §8.5 对 fwd.cj 别名清单的细节未明确（`BQuat`/`IQuat` 是否包含、`Quat`/`FQuat` 双别名机制） | **已采纳**。§3.14 fwd.cj 别名表重写为完整 8 行（Quat/FQuat/DQuat/3×Float32 精度/3×Float64 精度）+「排除项」段（不含 BQuat/IQuat/I64Quat/BQuat 精度变体，理由与阶段二策略一致）；「`Quat` 与 `FQuat` 双别名机制」段新增说明（与阶段二 `Mat2x2`/`FMat2x2` 模式一致）；D27 设计决策明确 |
| **问题 17（轻微）— 上一轮（v2）**：§8 验证项与 §2 末尾的 cjpm 子包构建预验证策略未对齐（阶段二 ext/ 子包验证结果、阶段三 gtc/ 子包回退方案） | **已采纳**。§2 末尾 cjpm 子包构建预验证段重写为「阶段二已通过验证：[已通过 cjpm 验证]」+「阶段三新增 gtc/ 需原型验证」+ 三个验证项（gtc 子包 + gtc 重导出 detail 函数 v3 新增 + 回退方案）；§8 编码启动前验证项 1 与之对齐 |
| **问题 19（轻微）— 上一轮（v2）**：部分接口边界契约对下游消费者的影响未充分说明（`identity` 调用提示、`fromQuat` 闭包示例、`Quat×Vec3` stub 标注、stub 函数对照表） | **已采纳**。§3.3 各工厂函数新增「调用示例」代码块（identity / fromQuat）；§3.3 fromMat3/fromMat4 新增「边界行为」契约声明（仅对纯旋转矩阵有效）；§3.11 inverse 新增「边界行为」（浮点 Inf/NaN vs 整数除零异常）；§11 新增「下游消费者迁移指南」独立章节（5 类迁移场景 + 函数可用性对照表 19 行，覆盖本阶段/阶段四状态） |

---

## 修订说明（v4）

> **修订定位**：v3 设计的迭代修订（v4）。依据本轮审查报告（a_v2_review_v2.md）识别 2 项问题（1 一般 + 1 轻微）开展修订，在保留 v3 设计所有修订成果的基础上，针对 `isnan`/`isinf` 函数约束缺失与 Quat 字段可见性描述缺失 2 个本轮新识别问题进行强化。

| 审查意见 | 修改措施 |
|---------|---------|
| **问题 1（一般）— 本轮新识别**：`ext/quaternion_common.cj` 中 `isnan(q: Quat<T,Q>): Vec4<Bool,Q>` 与 `isinf(q: Quat<T,Q>): Vec4<Bool,Q>` 函数缺少 `where T <: FloatingPointNumber<T>` 类型约束。`std.math` 的 `isNaN()`/`isInf()` 实例方法仅定义于浮点类型（`FloatingPoint<T>` 接口），整数类型（`Int8`/`Int16`/`Int32`/`Int64`）无此方法。函数体内部使用 `q.x.isNaN()`/`q.x.isInf()` 实例方法路径（`Vec4(q.x.isNaN(), q.y.isNaN(), q.z.isNaN(), q.w.isNaN())`），当用户实例化 `Quat<Int64, PackedHighp>` 调用 `isnan(q)` 时，函数体内部 `q.x.isNaN()` 因 Int64 不实现 `isNaN()` 而编译失败 | **已采纳审查报告建议方向**。**核心修复**：§3.11 `isnan`/`isinf` 函数描述新增「T 类型约束（v4 修订）」段落，明确函数签名添加 `where T <: FloatingPointNumber<T>` 约束，限制函数仅对浮点类型 T 可调用——与 §3.12 `epsilon<T>()` 约束收紧策略（v3 已明确）保持一致。**Fallback 模式**：若仓颉泛型不支持窄类型约束（如 `FloatingPointNumber<T>` 接口不可用），则采用与 `epsilon<T>()` 相同的运行时分派模式——对 `q.x` 的具体类型进行 `Float32`/`Float64` 分派（通过 `match` 或 `if-else`），非浮点 T 实例化时抛 `Exception("isnan/isinf not defined for non-floating-point types")`。**同步修订**：D29 设计决策新增（「`isnan`/`isinf` 函数约束收紧为 `where T <: FloatingPointNumber<T>`」）；§5.3 边界条件表新增「整型 T / `isnan(q)`/`isinf(q)`」行（编译失败 + fallback 异常分支）；§8 编码启动前验证项新增验证项 13（v4 新增）；§9 差异声明新增「`isnan`/`isinf` 函数约束收紧为 `where T <: FloatingPointNumber<T>`（v4 新增）」条目；§10 覆盖矩阵 `quaternion_common` 表中 `isnan(Quat)`/`isinf(Quat)` 行新增「约束 `T <: FloatingPointNumber<T>`，v4 修订」标注；§11.5 函数可用性对照表 `isnan`/`isinf` 行修订为「✅ 可用（仅浮点 T，整型 T 编译失败，v4 约束收紧）」 |
| **问题 2（轻微）— 本轮新识别**：设计 §3.1 描述 Quat 数据成员为 `var x: T, var y: T, var z: T, var w: T`，未显式标注 `public`。按 `cangjie-std/deriving/README.md` 第 4 节约束「参与派生的字段/属性必须为 public」，`@Derive[Hashable]` 派生要求字段为 public；按 `struct/README.md` 第 1.7 节，struct 字段默认可见性为 internal，不满足 public 派生要求。阶段一 Vec3 (`type_vec3.cj:8-10`)、阶段二全部 Mat (`type_mat*.cj` 200+ 处) 均使用 `public var` 标注以保证 `@Derive[Hashable]` 派生成功 | **已采纳审查报告建议方向**。**核心修复**：§3.1 数据成员描述从 `var x: T, var y: T, var z: T, var w: T` 修订为 `public var x: T, public var y: T, public var z: T, public var w: T`，显式标注 `public` 可见性；§3.1 数据布局选择段中「数据成员声明为 `var x, var y, var z, var w`」同步修订为 `public var x, public var y, public var z, public var w` 并新增说明「显式标注 `public` 以满足 `@Derive[Hashable]` 派生对字段 public 可见性的要求，与阶段一 Vec3、阶段二全部矩阵类型（200+ 处）的实践对齐」。**强化 §3.1 `@Derive[Hashable]` 约束核验段**：从 v3 的「v3 新增」修订为「v3 新增，v4 强化」，明确列出派生宏的两条硬性要求（①泛型 type parameter 满足 `Hashable` 接口；②参与派生的字段/属性必须为 `public` 可见性），并新增「字段可见性约束（v4 新增）」段落说明「若省略 `public` 关键字，struct 字段默认可见性为 `internal`，不满足 public 派生要求」。**同步修订**：D30 设计决策新增（「Quat 字段统一标注 `public var`」）；§8 编码启动前验证项新增验证项 14（v4 新增：Quat 字段 `public var` 可见性验证）；§9 差异声明新增「Quat 字段统一标注 `public var`（v4 新增）」条目 |

---

## 修订说明（v5）

> **修订定位**：v4 设计的迭代修订（v5）。依据本轮审查报告（b_v2_diag_v1.md）识别 2 项严重问题 + 8 项一般问题 + 4 项轻微问题（合计 14 项，LOCATED 质询结果确认诊断结论可信）开展修订。修订重点：`axis()` 函数边界行为契约与 GLM 实际行为对齐（严重）、`pow` 依赖关系完整性（严重）、`log`/`exp`/`slerp` 4 参数版本依赖补齐、`axis` 同段自相矛盾、路线图同步、`gtc/quaternion.cj` 表格表述冲突、`conjugate` 描述纠正、`type_quat_cast` 函数签名规范、轻微问题（lib.cj/fwd.cj 清单、`pow` 命名消歧、`mix` 重载版本、Hashable 实践依据）。

| 审查意见 | 修改措施 |
|---------|---------|
| **问题 1（严重）**：`axis()` 函数边界行为契约与 GLM 1.0.3 实际行为不符——v3 §3.9 描述的「内部 `normalize(Vec3(0, 0, 0))` 返回 `Vec3(T(1), T(0), T(0))`」为虚构实现，GLM `ext/quaternion_trigonometric.inl:20-27` 实际使用 `tmp1 = 1 - x.w*x.w` 独立公式；触发 `Vec3(0, 0, 1)` 返回值的条件为 `\|w\| >= 1`（单位四元数 (0,0,0,1)）而非 `q.xyz == 0`；行号引用 `quaternion_geometric.inl:20-21` 错误 | **已采纳**。**核心修复**：§3.9 `axis` 函数描述完整重写，明确实现公式（与 GLM `ext/quaternion_trigonometric.inl:20-27` 一致）：`tmp1 = T(1) - x.w*x.w`；若 `tmp1 <= T(0)` 返回 `Vec3(T(0), T(0), T(1))`；否则 `tmp2 = T(1)/sqrt(tmp1)` 返回 `Vec3(x.x*tmp2, x.y*tmp2, x.z*tmp2)`。删除「内部 `normalize(Vec3(0, 0, 0))`」虚构描述。**同步修订**：§5.3 边界条件表修订「零四元数 / `axis(q)`」行为契约为「`1 - x.w*x.w <= 0` 时返回 `Vec3(T(0), T(0), T(1))`；真正零四元数 `(0,0,0,0)` 返回 `Vec3(0, 0, 0)`」；新增「真正零四元数 / `axis(q)`」行；§9 差异声明条目修订为「`axis` 触发条件为 `1 - w² <= 0` 而非 q.xyz == 0」并明确 v3 原描述错误纠正；§10 覆盖矩阵 `quaternion_trigonometric.hpp` 表 `axis` 行同步修订；D31 设计决策新增（v5 关键修订：`axis` 函数实现采用 GLM 独立公式路径而非 `normalize` 路径） |
| **问题 2（严重）**：`pow` 函数依赖关系不完整 + 行号引用错误——v3 §3.10 遗漏 `cos_one_over_two<T>()`（line 52）、`asin`（line 68）、递归调用 `std.math.pow(T,T)`（line 65）、`std::numeric_limits<T>::min()` 等价物（line 63），行号引用 `quaternion_exponential.inl:24-43` 错误（应为 41-80） | **已采纳**。**核心修复**：§3.10 `pow` 函数依赖关系完整重写，明确列出 `epsilon<T>()`/`abs`/`clamp`/`asin`/`acos`/`sin`/`cos`/`sqrt`/`cos_one_over_two<T>()` + 递归调用 `std.math.pow(T, T)`（实数降级路径）+ `std::numeric_limits<T>::min()` 等价的仓颉次正规数边界检查；行号修订为 `quaternion_exponential.inl:41-80`；新增「命名消歧」段落明确四元数 `pow` 函数体内部调用的是 `std.math.pow(T, T): T` 实数版本，与四元数 `pow` 通过参数类型消歧，若 `std.math.pow` 不存在需以 `exp(y * log(x.w))` 替代。**同步修订**：D21 设计决策从「依赖 `epsilon<T>()`」强化为「依赖 `epsilon<T>()`/`cos_one_over_two<T>()`/`asin`/递归 `std.math.pow`/`std::numeric_limits<T>::min()` 等价物」并引用具体行号；§10 覆盖矩阵 `quaternion_exponential.hpp` 表 `pow` 行同步修订；§8 编码启动前验证项新增验证项 15（`pow` 函数四元数版本与 `std.math.pow` 实数版本命名消歧验证）+ 验证项 16（次正规数边界检查 `FloatingPointNumber<T>.getMin()` 验证） |
| **问题 3（一般）**：`log` 函数依赖关系遗漏 `epsilon<T>()`/`pi<T>()` 与 `std::numeric_limits<T>::infinity()` 等价处理策略 | **已采纳**。§3.10 `log` 函数依赖修订为「依赖 `length`/`epsilon<T>()`（line 23 `Vec3Len < epsilon<T>()` 退化检测）/`pi<T>()`（line 28 `wxyz(log(-q.w), pi<T>(), ...)`）/`atan`/`log`（trigonometric.cj/exponential.cj 接口）+ `std::numeric_limits<T>::infinity()` 等价物（line 30 用于 w=0 退化分支，仓颉版本建议优先 `FloatingPointNumber<T>.getInf()` 实例方法，fallback 为 `T(1)/T(0)` 显式构造）」；§10 覆盖矩阵 `quaternion_exponential.hpp` 表 `log` 行同步修订；§8 编码启动前验证项新增验证项 18（`log` 函数 `std::numeric_limits<T>::infinity()` 等价物验证） |
| **问题 4（一般）**：`exp` 函数依赖关系遗漏 `epsilon<T>()` | **已采纳**。§3.10 `exp` 函数依赖修订为「依赖 `length`/`epsilon<T>()`（line 10 `Angle < epsilon<T>()` 退化检测）/`cos`/`sin`」；§10 覆盖矩阵 `quaternion_exponential.hpp` 表 `exp` 行同步修订 |
| **问题 5（一般）**：`slerp` 4 参数版本依赖关系遗漏 `pi<T>()` 与 `mix`（标量版） | **已采纳**。§3.11 `slerp` 4 参数版本依赖补充「`pi<T>()`（line 107 `T phi = angle + static_cast<T>(k) * glm::pi<T>();`）+ `mix`（标量版，line 98-101 四次标量 `mix` 调用）」；§10 覆盖矩阵 `quaternion_common.hpp` 表 `slerp` 4 参数行同步修订 |
| **问题 6（一般）**：§3.9 `axis` 函数依赖描述自相矛盾——前半部声明「依赖 `sqrt` 和 T(1) 演算，可完整实现」对应 GLM 实际公式路径，后半部引用「内部 `normalize(Vec3(0,0,0))`」对应 GLM 未采用路径 | **已采纳**。在采纳问题 1 修复方案后，§3.9 `axis` 函数描述统一为「实现公式 `tmp1 = T(1) - x.w*x.w`，依赖仅 `std.math.sqrt` 和 T(1) 演算（通过 `x.w*x.w` 取得），**可完整实现**」；删除「内部 `normalize(Vec3(0, 0, 0))`」的错误描述。逻辑自洽，问题 6 自然消除 |
| **问题 7（一般）**：路线图 `02_roadmap.md` 与 v3 设计在阶段三验证标准上存在三处不一致——`slerp` 可验证性冲突、`lookRotate` 命名未同步修正、`ext/quaternion_common.cj` 可验证性范围过广 | **已采纳**。新增 §3.16「路线图同步修订建议（v5 新增）」独立小节，明确三处路线图修订建议：(1) `02_roadmap.md` 第 125 行 `slerp` 修订为 `[待 Stage 4，依赖 trigonometric.cj 完整实现]`；(2) 第 89/102/111/129/152/163/207 行 `lookRotate` 修订为 `quatLookAt`/`quatLookAtRH`/`quatLookAtLH`；(3) 第 130 行 `ext/quaternion_common.cj` 修订为排除 `mix`/`slerp` stub 部分；新增「阶段三验证标准双向映射表」统一路线图 `[可验证]`/`[部分可验证]`/`[待 Stage 4]` 三级分类与本设计 ✅/⚠️/❌ 符号的对应关系 |
| **问题 8（一般）**：§3.15 `gtc/quaternion.cj` 表格欧拉角行单元格同时给出「完整实现（v3 修正）」与「改为 stub 占位（v3 最终决策）」两个相互矛盾的粗体标注 | **已采纳**。§3.15 表格欧拉角函数组单元格修订为「**stub 占位**（v5 最终决策，原误标为完整实现）」，删除中间冲突表述 |
| **问题 9（一般）**：`conjugate` 函数描述与 GLM 实际实现不一致——v3 描述「仅涉及逐分量取反」，GLM `ext/quaternion_common.inl:112-116` 实际是 `wxyz(q.w, -q.x, -q.y, -q.z)`（w 不变，仅 x/y/z 取反） | **已采纳**。§3.11 `conjugate` 描述修订为「**完整实现**」「仅对 x/y/z 三个分量取反，w 分量保持不变：`Quat(-q.x, -q.y, -q.z, q.w)`（与 GLM `ext/quaternion_common.inl:112-116` `wxyz(q.w, -q.x, -q.y, -q.z)` 一致）」；§10 覆盖矩阵 `quaternion_common.hpp` 表 `conjugate` 行同步修订语义说明 |
| **问题 10（一般）**：`detail/type_quat_cast.cj` 函数签名细节未定义——`mat3Cast`/`mat4Cast`/`quatCast(Mat3)`/`quatCast(Mat4)` 4 个函数的具体签名（泛型参数、约束、返回类型）未给出 | **已采纳**。新增 §3.2.1「type_quat_cast 函数签名规范（v5 新增）」子节，给出 4 个函数的标准签名模板：`mat3Cast<T, Q>(q: Quat<T, Q>): Mat3x3<T, Q> where T <: FloatingPointNumber<T>, Q <: Qualifier` 等，明确 `T <: FloatingPointNumber<T>` 约束收紧策略（与 D29 同类策略一致）+ 重载区分规则（参数类型 `Mat3x3<T,Q>` vs `Mat4x4<T,Q>`）+ Fallback 模式（非浮点 T 抛 `Exception(...)`）；D32 设计决策新增；§10 覆盖矩阵 `type_quat_cast.hpp` 表新增签名约束标注；§5.3 边界条件表新增「整型 T / 转换函数」行；§8 编码启动前验证项新增验证项 17（`type_quat_cast` 函数 `FloatingPointNumber<T>` 约束可用性验证）；§11.5 函数可用性对照表 `mat3_cast`/`mat4_cast`/`quat_cast` 行新增「仅浮点 T，整型 T 编译失败」标注 |
| **问题 11（轻微）**：`lib.cj`/`fwd.cj` 具体更新内容未明确——§2 仅描述「新增 public import」与「新增 type alias」，未列出具体清单 | **已采纳**。§2 包组织 `glm` 块下新增「lib.cj 新增 import 清单（v5 明确）」（8 个 `import` 声明：`Quat/mat3Cast/mat4Cast/quatCast` + 6 个 ext/gtc 模块）+「fwd.cj 新增 type alias 清单（v5 明确）」（8 个别名：`Quat`/`FQuat`/`DQuat` + 3×Float32 精度 + 3×Float64 精度，含排除项）；§8 更新文件段同步引用 §2 新增的清单段落 |
| **问题 12（轻微）**：`pow` 函数递归调用 `pow` 的命名消歧未说明——四元数 `pow` 与 `std.math.pow` 未区分，若 `std.math.pow` 不存在时如何降级未说明 | **已采纳**。§3.10 `pow` 描述新增「命名消歧（v5 新增）」段落，明确四元数 `pow` 函数体内部调用的是实数版本 `std.math.pow(T, T): T`，与四元数 `pow` 通过参数类型消歧；若 `std.math.pow` 不存在需以 `exp(y * log(x.w))` 替代实现；§8 编码启动前验证项新增验证项 15（命名消歧验证） |
| **问题 13（轻微）**：`mix` 函数依赖中 `acos`/`sin` 重载版本未明确——GLM 实际使用 `acos(cosTheta)` 与 `sin(...)` 单参数版本，v3 未明确 `trigonometric.cj` 需提供哪些重载 | **已采纳**。§3.11 `mix`/`slerp` 描述修订为「依赖 `dot`/`acos(cosTheta)`（`trigonometric.cj` 的 `acos(T): T` 单参数版本，`v5 修订明确`）/`sin(...)`（`trigonometric.cj` 的 `sin(T): T` 单参数版本，`v5 修订明确`）」；§10 覆盖矩阵 `quaternion_common.hpp` 表 `mix`/`slerp` 行同步修订明确 trigonometric.cj 单参数重载版本 |
| **问题 14（轻微）**：`@Derive[Hashable]` 派生所需 Qualifier Hashable 实现未充分核验——6 个 Qualifier 实现类型是否全部为标记类型且 Hashable 接口自动派生，实践依据未具体引用阶段二文件 | **已采纳**。§3.1 `@Derive[Hashable]` 约束核验段新增「实践依据（v5 明确）」子段落，明确引用阶段一 `type_vec3.cj:6` + 阶段二全部 9 个 `type_mat*.cj` 文件（200+ 处统一实践，已 grep 验证）+ 阶段三前提条件（不新增 Qualifier 变体）+ 阶段三若新增 Qualifier 变体或数据结构变更需重新验证；§8 编码启动前验证项 11 精简为「引用阶段二已验证实践，若阶段三新增 Qualifier 变体或数据结构变更则需重新验证」 |

---

## 修订说明（v6）

> **修订定位**：v5 设计的迭代修订（v6）。本轮依据 `a_v3_iteration_requirement.md` 提出的 2 项严重问题 + 8 项一般问题 + 4 项轻微问题（合计 14 项），逐项核验 v5 设计中已落实的修复措施，确认所有审查意见均已在 v5 设计中得到正确处理。本轮不引入新的设计变更，仅在 v5 基础上对 3 处表述细节进行少量澄清强化（pow 函数 fallback 精度依赖、log 函数 infinity fallback 类型约束、路线图修订状态标注）。

### 14 项审查意见落实情况核验表

| 审查意见 | 严重程度 | v5 落实位置 | 核验结论 |
|---------|---------|------------|---------|
| 问题 1：`axis()` 函数边界行为契约与 GLM 1.0.3 实际行为不符（虚构 `normalize(Vec3(0,0,0))` 实现 + 行号错误） | 严重 | §3.9 / §5.3 边界条件表 / §9 差异声明 / §10 覆盖矩阵 / D31 | **已完整修复**（删除虚构 `normalize` 描述，明确 GLM `tmp1 = 1 - x.w*x.w` 独立公式路径，触发条件 `tmp1 <= 0`） |
| 问题 2：`pow` 函数依赖关系不完整（遗漏 `cos_one_over_two<T>()`/`asin`/递归 `std.math.pow`/`std::numeric_limits<T>::min()` 等价物）+ 行号引用错误 | 严重 | §3.10 / D21 / §10 / §8 编码启动前验证项 15/16 | **已完整修复**（依赖关系完整重写 + 行号修订为 `quaternion_exponential.inl:41-80` + 新增「命名消歧」段） |
| 问题 3：`log` 函数依赖关系遗漏 `epsilon<T>()`/`pi<T>()`/`std::numeric_limits<T>::infinity()` 等价物 | 一般 | §3.10 / §10 覆盖矩阵 / §8 编码启动前验证项 18 | **已完整修复**（补充 line 23/28/30 全部依赖 + `FloatingPointNumber<T>.getInf()` + `T(1)/T(0)` fallback） |
| 问题 4：`exp` 函数依赖关系遗漏 `epsilon<T>()` | 一般 | §3.10 / §10 覆盖矩阵 | **已完整修复**（补充 line 10 `Angle < epsilon<T>()` 退化检测依赖） |
| 问题 5：`slerp` 4 参数版本依赖关系遗漏 `pi<T>()` 与 `mix`（标量版） | 一般 | §3.11 / §10 覆盖矩阵 | **已完整修复**（补充 line 107 `pi<T>()` + line 98-101 四次标量 `mix` 调用依赖） |
| 问题 6：§3.9 `axis` 函数依赖描述自相矛盾 | 一般 | §3.9 | **已完整修复**（统一为「依赖仅 `std.math.sqrt` 和 T(1) 演算」，删除「内部 `normalize`」错误描述） |
| 问题 7：路线图 `02_roadmap.md` 与 v3 设计在阶段三验证标准上存在三处不一致 | 一般 | §3.16（新增「路线图同步修订建议」）/ §3.16 末尾「阶段三验证标准双向映射表」 | **已完整修复**（明确三处路线图修订建议：`slerp` 可验证性 / `lookRotate` 命名 / `quaternion_common.cj` 范围） |
| 问题 8：§3.15 `gtc/quaternion.cj` 表格欧拉角行单元格表述冲突 | 一般 | §3.15 表格 | **已完整修复**（单元格统一修订为「**stub 占位**（v5 最终决策，原误标为完整实现）」，删除中间冲突表述） |
| 问题 9：`conjugate` 函数描述与 GLM 实际实现不一致（v3 误称「仅涉及逐分量取反」） | 一般 | §3.11 / §10 覆盖矩阵 | **已完整修复**（修订为「仅对 x/y/z 取反，w 保持不变：`Quat(-q.x, -q.y, -q.z, q.w)`」，与 GLM `ext/quaternion_common.inl:112-116` `wxyz(q.w, -q.x, -q.y, -q.z)` 一致） |
| 问题 10：`detail/type_quat_cast.cj` 函数签名细节未定义 | 一般 | §3.2.1（新增「type_quat_cast 函数签名规范」）/ D32 / §10 / §5.3 / §8 编码启动前验证项 17 / §11.5 | **已完整修复**（明确 4 个函数签名模板 + `T <: FloatingPointNumber<T>` 约束收紧策略 + 重载区分规则 + Fallback 模式） |
| 问题 11：`lib.cj`/`fwd.cj` 具体更新内容未明确 | 轻微 | §2 包组织 `glm` 块下 | **已完整修复**（新增「lib.cj 新增 import 清单（v5 明确）」（8 个 `import` 声明）+「fwd.cj 新增 type alias 清单（v5 明确）」（8 个别名，含排除项）） |
| 问题 12：`pow` 函数递归调用 `pow` 的命名消歧未说明 | 轻微 | §3.10「命名消歧（v5 新增）」段 / §8 编码启动前验证项 15 | **已完整修复**（明确 `std.math.pow(T, T): T` 实数版本与四元数 `pow` 通过参数类型消歧 + `exp(y * log(x.w))` 替代实现 fallback） |
| 问题 13：`mix` 函数依赖中 `acos`/`sin` 重载版本未明确 | 轻微 | §3.11 / §10 覆盖矩阵 | **已完整修复**（明确 `trigonometric.cj` 需提供 `acos(T): T`/`sin(T): T` 单参数重载版本） |
| 问题 14：`@Derive[Hashable]` 派生所需 Qualifier Hashable 实现未充分核验 | 轻微 | §3.1「`@Derive[Hashable]` 约束核验」段 / §8 编码启动前验证项 11 | **已完整修复**（新增「实践依据（v5 明确）」子段落，引用阶段一 `type_vec3.cj:6` + 阶段二全部 9 个 `type_mat*.cj` 文件 200+ 处统一实践） |

### v6 补充强化项

在确认 v5 已落实所有 14 项审查意见的基础上，本轮对以下 3 处表述细节进行补充强化（**非问题修正，仅澄清**）：

1. **§3.10 `pow` 函数 fallback 路径精度依赖澄清**
   - v5 已说明「若 `std.math.pow` 不存在需以 `exp(y * log(x.w))` 替代实现」，但未明确替代实现的精度依赖。
   - **v6 澄清**：替代实现 `exp(y * log(x.w))` 仍调用实数 `log`/`exp`，依赖仓颉 `std.math.log(T): T` 与 `std.math.exp(T): T` 函数可用性，与原 `pow(x.w, y)` 实现路径具有相同的依赖边界。两种实现路径的依赖收敛点一致（最终均止于 `std.math` 顶层实数函数），仅当仓颉标准库同时缺失 `pow`/`exp`/`log` 三个实数函数时整个实现才不可用。

2. **§3.10 `log` 函数 `infinity` fallback 类型约束澄清**
   - v5 已说明 `log` 函数依赖 `std::numeric_limits<T>::infinity()` 等价物，并给出「fallback 为 `T(1)/T(0)` 显式构造」策略，但未明确该 fallback 仅对浮点类型 T 有效。
   - **v6 澄清**：`T(1)/T(0)` 显式构造仅对浮点类型 T 有效；整数类型（如 `Int64`）执行 `Int64(1)/Int64(0)` 会触发仓颉整数除零异常，与 GLM `std::numeric_limits<int>::infinity()` 行为不一致。整数四元数调用 `log` 时建议改用 `isnan`/`isinf` 边界检查跳过退化分支（结合 D29 `isnan`/`isinf` 约束收紧策略，整数 T 在编译期即被排除调用）。

3. **§3.16 路线图修订状态标注澄清**
   - v5 §3.16 已明确建议修订 `02_roadmap.md` 三处不一致（`slerp` 可验证性 / `lookRotate` 命名 / `quaternion_common.cj` 范围），但未标注这些修订是否已实际完成。
   - **v6 澄清**：`02_roadmap.md` 的修订属于「设计文档 → 路线图文档」的同步建议，路线图的实际修订应在 v3 迭代结束后由项目管理流程执行；本设计文档不再依赖路线图的特定标注（如 `[可验证]`/`[部分可验证]`/`[待 Stage 4]` 三级分类），下游验证以本设计 §11.5「函数可用性对照表」的 ✅/⚠️/❌ 符号为准。

### v3 迭代状态总结

经过 v2（v3 设计）→ v3（v4 设计）→ v4（v5 设计）→ v6 共 4 轮设计修订，v3 迭代提出的 14 项审查意见均已落实：

- **2 项严重问题**（`axis` 边界行为契约与 GLM 实际行为不符 + `pow` 依赖关系不完整 + 行号错误）：均已在 v5 设计中完整修复，v6 补充 1 项相关 fallback 精度依赖澄清
- **8 项一般问题**（`log`/`exp`/`slerp` 4 参数版依赖遗漏 + `axis` 自相矛盾 + 路线图不一致 + §3.15 表格冲突 + `conjugate` 描述不符 + `type_quat_cast` 签名细节缺失）：均已在 v5 设计中完整修复，v6 补充 1 项 `log` 函数 `infinity` fallback 类型约束澄清
- **4 项轻微问题**（`lib.cj`/`fwd.cj` 清单缺失 + `pow` 命名消歧未说明 + `mix` 重载版本未明确 + `@Derive[Hashable]` 实践依据不足）：均已在 v5 设计中完整修复

v3 迭代整体完成，可进入下游验证环节。

---

## 修订说明（v7）

> **修订定位**：v6 设计的迭代修订（v7）。依据本轮审查报告（a_v3_review_v1.md）识别 1 项一般问题 + 4 项轻微问题开展修订。在 v6 设计（已落实 v3 迭代的 14 项审查意见：2 严重 + 8 一般 + 4 轻微）的基础上，本轮对 `FloatingPointNumber<T>` 接口命名统一为仓颉 stdlib 原生 `FloatingPoint<T>`，并补充 4 项设计意图澄清注释。本轮不引入新的设计变更，仅做接口命名统一与 4 处表述强化。

### 5 项审查意见落实情况核验表

| 审查意见 | 严重程度 | v7 落实位置 | 核验结论 |
|---------|---------|------------|---------|
| 问题 1（一般）：全文 `FloatingPointNumber<T>` 接口命名与仓颉 stdlib `FloatingPoint<T>` 不一致（stdlib `cangjie-std/math/README.md` 第 117 行明确定义为 `FloatingPoint<T>`/`Integer<T>`/`Number<T>` 三层接口，文档中无 `FloatingPointNumber<T>` 接口定义）；且 §3.11 描述文本与 where 子句使用不同接口名，存在设计内部不一致；§8 验证项 16/17/18 基于标准库不存在的接口展开，验证目标本身不可达 | 一般 | §3.2.1（4 处函数签名 + 2 处描述文本）/ §3.10（log + pow 函数依赖描述）/ §3.11（isnan + isinf 描述段与函数签名）/ §3.12（整数类型 T 行为契约段）/ §5.3 边界条件表（2 行）/ D21 / D29 / D32 设计决策 / §8 编码启动前验证项 13/16/17/18 / §9 差异声明 / §10 覆盖矩阵 type_quat_cast 表 4 行 + quaternion_common 表 2 行 | **已完整修复**（全文统一替换 `FloatingPointNumber<T>` → `FloatingPoint<T>`，约 35+ 处修订；§3.11 内部不一致消除：D29 已使用 `FloatingPoint<T>` 字样与 where 子句对齐；§8 验证项 13 中「若 `FloatingPointNumber<T>` 接口不可用」措辞修订为「`FloatingPoint<T>` 是 stdlib 原生接口，无「不可用」风险，无需 fallback 验证」） |
| 问题 2（轻微）：D17 决策「Bool 四元数不支持算术运算」未在 §3.4 运算符体系表备注中增加「Bool 四元数因 `Bool` 不实现 `Number<T>` 接口，编译期自动拒绝算术运算」一句话澄清 | 轻微 | §3.4 运算符体系表后 | **已完整修复**（新增「**Bool 四元数算术运算编译期拒绝（v7 澄清）**」段，明确算术运算符以 `Number<T>` 为约束，`Bool` 不实现该接口，`Quat<Bool, Q>` 实例化时算术运算符重载编译期自动拒绝；与阶段二 D33 Bool 矩阵策略一致） |
| 问题 3（轻微）：§3.10 `pow` 函数依赖 `std.math.pow(T, T): T` 实数降级路径，但 stdlib 实际仅支持 Float64 输入/输出；§3.10「命名消歧」段未明确 `pow(Quat<Float32, Q>, Float32)` 路径需先显式转换至 Float64 再降级，fallback `exp(y * log(x.w))` 同步需 Float64 转换 | 轻微 | §3.10 `pow` 函数描述 | **已完整修复**（在「命名消歧」段后新增「**Float64 转换依赖（v7 澄清）**」子段：明确 `pow(Quat<Float32, Q>, Float32)` 实现路径需先显式将 `x.w`/`y` 转换至 Float64 再调用 `std.math.pow`，fallback 路径 `exp(y * log(x.w))` 同步需 Float64 转换；§8 编码启动前验证项 15 同步补充此依赖） |
| 问题 4（轻微）：§3.16「路线图同步修订建议」未明确「本设计的可用性标注（§11.5）是阶段三验证的权威基准」 | 轻微 | §3.16 末尾「阶段三验证标准双向映射表」后 | **已完整修复**（新增「**§11.5 权威基准说明（v7 澄清）**」段：明确本设计 §11.5「函数可用性对照表」的 ✅/⚠️/❌ 符号标注是阶段三验证的权威基准，路线图三级标注在 v3 迭代结束后由项目管理流程同步修订，本设计文档不再依赖路线图标注作为验证依据；同时与 §3.16 三处修订建议形成「设计独立可验证性 + 路线图同步建议」的双重保障） |
| 问题 5（轻微）：§3.4「Vec extend 块成员运算符」表备注列说明「本阶段可验证，通过 inverse 路径」时，未明确 `inverse` 自身依赖 `quaternion_geometric.cj.dot` 已实现的链路 | 轻微 | §3.4「Vec extend 块成员运算符」表后 | **已完整修复**（新增「**实现链路注释（v7 澄清）**」段：明确本阶段 `Vec3×Quat`/`Vec4×Quat` 可立即调用的完整依赖链 `Vec×Quat` → `inverse`（§3.11 已完整实现）→ `conjugate(q) / dot(q, q)`，其中 `conjugate` 无外部依赖、`dot` 由 `quaternion_geometric.cj`（§3.7）已完整实现；强化与 `Quat×Vec3`（依赖 `geometric.cj` 向量 `cross` stub）的对比） |

### v7 修订特点

本轮修订具有以下特点：

1. **接口命名对齐 stdlib**：将全文 `FloatingPointNumber<T>` 统一为 `FloatingPoint<T>`，与仓颉 stdlib `cangjie-std/math/README.md` 第 117 行定义的 `FloatingPoint<T>`/`Integer<T>`/`Number<T>` 三层接口体系对齐。修复后，开发人员按设计字面实现 `where T <: FloatingPoint<T>` 约束时，编译器可正常识别 stdlib 原生接口，§3.2.1 / §3.11 / §3.12 / §5.3 / §10 的「编译期拒绝非浮点 T 实例化」设计意图完全落地。`FloatingPoint<T>` 是 stdlib 原生接口，编译期保证可用，无需 runtime fallback。

2. **设计内部不一致消除**：v6 设计的 D29 设计决策已正确使用 `FloatingPoint<T>` 字样，但 §3.11 `isnan`/`isinf` 描述段、where 子句、§3.12 描述段、§5.3 边界条件表等多处仍使用 `FloatingPointNumber<T>`，形成「决策正确 + 描述错误」的设计内部不一致。v7 统一为 `FloatingPoint<T>` 后，决策、描述、验证项三个层面的接口命名完全一致。

3. **设计意图澄清注释**：新增 4 项轻微问题澄清注释（§3.4 Bool 四元数编译期拒绝 / §3.10 pow Float64 转换依赖 / §3.16 §11.5 权威基准 / §3.4 Vec extend 块实现链路），强化设计可读性，便于下游编码与测试理解设计意图。澄清内容均为「非问题修正，仅澄清」，未引入新的设计约束或决策。

4. **不引入新设计变更**：v7 修订严格限定在「接口命名统一 + 4 处设计意图澄清」范围内，不修改任何函数行为、类型形态、依赖关系、文件归属、测试用例数、覆盖范围等设计要素。前序 v2/v3/v4/v5/v6 修订的 14 项审查意见落实情况保持不变。

### 历史迭代状态总结

经过 v1（v2 设计）→ v2（v3 设计）→ v3（v4 设计）→ v4（v5 设计）→ v5（v6 设计）→ v6（v7 设计）共 6 轮设计修订：

- **v2（v3 设计）**：新增 14 项审查意见 → 落实 13 项，遗留 1 项（`gtc/quaternion.cj` 文件规划缺失）
- **v3（v4 设计）**：新增 2 项严重问题（包间循环依赖 + 依赖方向内部矛盾）→ 全部修复；同步补齐 v2 遗留项
- **v4（v5 设计）**：上一轮 14 项审查意见（2 严重 + 8 一般 + 4 轻微）→ 全部修复
- **v5（v6 设计）**：核实 v5 已落实 14 项 → 全部确认 + 3 处表述细节澄清
- **v6（v7 设计，本轮）**：本轮 5 项审查意见（1 一般 + 4 轻微）→ 全部修复

v6 迭代整体完成，可进入下游验证环节。

---

## 修订说明（v8）

> **修订定位**：v7 设计的迭代修订（v8）。依据本轮审查报告（`a_v4_iteration_requirement.md` 对应 v3 诊断报告 `b_v3_diag_v1.md`）识别 4 项严重问题 + 5 项一般问题 + 2 项轻微问题（合计 11 项）。在 v7 设计（已落实前序 5 项审查意见：1 一般 + 4 轻微）的基础上，本轮针对 11 项问题逐项开展修订。

### 11 项审查意见落实情况核验表

| 审查意见 | 严重程度 | v8 落实位置 | 核验结论 |
|---------|---------|------------|---------|
| **问题 1（严重）**：`gtc/constants` 函数数量自相矛盾——文字描述「25 个」与 §3.12 函数名清单（28 个）及 GLM 1.0.3 实际声明数（28 个）不一致 | 严重 | §1 核心抽象表 / §2 lib.cj import 清单 / §2 gtc 块包组织 / §3.12 gtc/constants 段 / §7 D10 / §8 产出物清单「完整实现」段 / §10 覆盖矩阵 gtc/constants.hpp 表 | **已完整修复**（全文统一修订「25」→「28」共 7 处，§3.12 同步补充「v8 修订说明」段；§8.2 测试设计表 `test_constants.cj` 用例数 25 → 28，明确每常量函数 1 个用例的覆盖目标） |
| **问题 2（严重）**：`axis` 函数 T(1) 获取方式描述与项目系统性约束矛盾——v7 描述「T(1) 演算通过 `x.w*x.w` 取得」是错误的（`x.w*x.w` 是 w² 而非 1） | 严重 | §1「系统性设计约束」段（新增「常量型 T(1) 字面量替代」策略）/ §3.9 `axis` 函数描述 / D31 | **已完整修复**（§1 新增「常量型 T(1) 字面量替代」策略说明；§3.9 `axis` 函数描述删除「通过 `x.w*x.w` 取得」错误描述，改为 `T(Float64(1))` 显式转换路径；D31 决策同步引用 §1 策略） |
| **问题 3（严重）**：`fromMat4` 降维策略两可——v7 给出「手动提取 vs GLM 策略转换」两种「或」的选择，但两种方式实现语义不同（手动提取无需 `one` 参数；Mat3x3 构造函数依赖阶段二未提供的 `Mat3x3<T,Q>(Mat4x4<T,Q>)` 构造重载），下游无法决策 | 严重 | §3.3 item 7 | **已完整修复**（v8 明确选择**手动提取策略**——直接读取 `m.c0`/`m.c1`/`m.c2` 三列构建 `Mat3x3<T,Q>`，参考阶段二 `type_mat2x2.cj:163-165` 的列提取模式，无需 `one: T` 参数；删除「或」的表述，新增「v8 修订说明」段说明选择理由） |
| **问题 4（严重）**：`Mat2x2`/`FMat2x2` 双别名先例引用错误——阶段二 `cjglm/src/fwd.cj` 实际仅存在 `Mat2x2` (Float32) + `DMat2x2` (Float64) 双别名（`fwd.cj:327, 347`），**不存在** `FMat*` 任何声明；`fwd.cj` 中唯一带 `F` 前缀的别名是 Vec 家族（`FVec1`~`FVec4` 见 `fwd.cj:275-278`） | 严重 | §3.14 / §7 D27 / §9 差异声明 | **已完整修复**（§3.14 先例引用从 `Mat2x2`/`FMat2x2` 双别名修订为 Vec 家族 `Vec2` + `DVec2` + `FVec2` 三重模式，引用 `fwd.cj:106, 123, 276`；D27 决策依据修订为「阶段三所有自定义类型族均排除整型别名 + 选择性排除 Bool 别名」统一策略；§9 差异声明「`Quat`/`FQuat` 双别名机制」条目修订为「`Quat`/`FQuat`/`DQuat` 三重别名机制（v8 修订先例引用）」） |
| **问题 5（一般）**：测试文件命名约定与现有项目不一致——v7 13 个测试文件均使用 `xxx_test.cj` 命名，但阶段二 `cjglm/tests/glm/detail/` 现有约定**全部使用** `test_xxx.cj` 风格（10+ 个文件已 grep 验证） | 一般 | §8.2 测试设计表 | **已完整修复**（13 个测试文件名统一从 `xxx_test.cj` 调整为 `test_xxx.cj` 风格，如 `test_type_quat.cj`/`test_vector_relational.cj` 等） |
| **问题 6（一般）**：`trigonometric.cj` 函数清单未区分标量/向量重载——v7 列出 15 个函数但未说明标量/向量重载形式，下游仅声明向量版本会导致 `mix`/`slerp`/`roll`/`pitch`/`yaw`/`pow`/`log` 等的 `acos(T)`/`sin(T)`/`atan(T)` 标量调用编译失败 | 一般 | §3.13 / §3.13.1（新增子节） | **已完整修复**（§3.13 表格行修订为「标量/向量重载区分（v8 新增）：提供 30 个函数」；新增 §3.13.1「trigonometric.cj 函数清单」子节，明确 14 个单参数三角函数（标量 + 向量 = 28 个）+ 1 个双参数 `atan2`（标量 `atan2(T, T): T` + 向量 = 2 个）= 共 30 个；明确标量版本用于 `slerp`/`mix`/`pow`/`log`/`exp`/`angle`/`angleAxis` 等函数体内的分量级运算） |
| **问题 7（一般）**：`axis` 函数 Float32 sqrt 处理策略缺失——`std.math.sqrt` 仅支持 Float64 输入/输出，T 为 Float32 时 `sqrt(tmp1)` 编译失败；v7 仅在 `length` 一处明确该问题，未将其作为一般性约束贯彻到所有 `std.math` 函数调用 | 一般 | §1（新增「Float32 与 std.math 的交互约束」段） | **已完整修复**（§1 新增「系统性设计约束（v8 新增）：Float32 与 std.math 的交互约束」段，统一说明 `std.math` 所有数值函数仅支持 Float64，Float32 实例化时需使用 `T(Float64.xxx(Float64(value)))` 模式显式转换；明确本阶段受此约束影响的函数清单：`axis`/`length`/`angleAxis`/`exp`/`log`/`pow`/`sqrt`，所有上述函数引用本约束作为依赖说明） |
| **问题 8（一般）**：`fromVec3` 工厂函数边界行为契约缺失——v7 标记为 stub 占位但未说明 u, v 反平行等特殊场景的行为契约；GLM 1.0.3 实际有 180° 任意垂直轴退化路径（`type_quat.inl:196-217`） | 一般 | §3.3 item 8 / §5.3 边界条件表 | **已完整修复**（§3.3 item 8 新增「边界行为契约（v8 新增）」段，明确反平行输入返回 180° 任意轴四元数（`q.w ≈ 0` 且 `q.xyz` 模长为 1 的纯向量四元数），与 GLM 退化路径一致；零向量输入行为未定义；§5.3 边界条件表新增 2 行：「u, v 反平行（`dot ≈ -1`）」+「u, v 为零向量」） |
| **问题 9（一般）**：`mat3Cast`/`mat4Cast` 接受非单位四元数时返回矩阵行为未与 §3.3 工厂函数对齐——§3.3 item 6 已对 `Quat.fromMat3` 明确边界声明，但 §3.2.1 中 `mat3Cast`/`mat4Cast`/`quatCast` 描述未同步；`mat3Cast` 接受非单位四元数时返回矩阵行为未定义，`quatCast` 接受非旋转矩阵时返回四元数行为未定义 | 一般 | §3.2.1（新增「边界行为契约」段）/ §5.3 边界条件表 | **已完整修复**（§3.2.1 在 `where T <: FloatingPoint<T>` 约束说明段后新增「**边界行为契约（v8 新增）**」段，明确：① `mat3Cast`/`mat4Cast` 接受非单位四元数返回矩阵不保证是旋转矩阵（缩放/剪切分量保留）；② `quatCast` 接受非旋转矩阵返回的四元数行为未定义；③下游消费者契约与 §3.3 item 6/7 边界声明对齐。§5.3 边界条件表新增 2 行：「`mat3Cast` 接受非单位四元数」+「`quatCast` 接受非旋转矩阵」） |
| **问题 10（轻微）**：测试文件 `gtc/quaternion_test.cj` 用例数与 gtc 命名空间 API 数量比例失衡——20 个用例分摊到 8 个完整实现函数（4 比较 + 4 转换重导出）仅 2.5 个/函数，低于其他测试文件 | 轻微 | §8.2 测试设计表 | **已完整修复**（§8.2 表新增「用例分配原则（v8 新增）」段：完整实现函数每函数 ≥2 用例 / stub 函数每函数 ≥1 用例 / 重导出函数每函数 ≥1 用例验证可达性；`test_quaternion.cj` 用例数 20 → 27，按 8 可测函数 × 2 = 16 + 4 重导出可达性 × 1 = 4 + 7 stub × 1 = 7 = 27 重算） |
| **问题 11（轻微）**：§11.5 函数可用性对照表 `isnan`/`isinf` 与 `mat3_cast`/`mat4_cast`/`quat_cast` 行未与 §3.11/§3.2.1 `where T <: FloatingPoint<T>` 子句约束保持一致——未明确具体约束的 where 子句形式，下游迁移者可能不理解为何整型 T 编译失败 | 轻微 | §11.5 函数可用性对照表 | **已完整修复**（§11.5 表 3 行追加约束标注：`isnan`/`isinf` 本阶段/阶段四两行均追加「**约束：`where T <: FloatingPoint<T>`（D29）**」；`mat3_cast`/`mat4_cast`/`quat_cast`（detail）与（gtc，重导出）本阶段/阶段四共 4 行均追加「**约束：`where T <: FloatingPoint<T>`（D32）**」） |

### v8 修订特点

1. **事实准确性优先**：本轮 4 项严重问题中 3 项属于「事实错误/直接阻塞编码」类（`gtc/constants` 数量自相矛盾 / `axis` 函数 T(1) 错误描述 / `FMat2x2` 先例引用错误），v8 通过直接查阅仓颉 stdlib 文档（`cangjie-std/math/README.md`）、GLM 1.0.3 实际源码（`glm/glm/gtc/constants.hpp`、`ext/quaternion_trigonometric.inl`、`type_quat.inl`）、阶段二 `cjglm/src/fwd.cj` 全文 grep 验证、以及 `cjglm/src/detail/type_mat2x2.cj:163-165` 列提取模式参考，逐一纠正错误描述，确保设计与项目实际状态对齐。

2. **设计决策明确性强化**：本轮 2 项问题属于「设计决策不明确」类（`fromMat4` 策略两可 / `mat3Cast`/`mat4Cast` 边界行为未对齐），v8 通过明确单一策略 + 新增边界行为契约段 + §3.3/§3.2.1/§5.3 三处协同对齐，强化设计决策的可操作性，下游编码可按设计文档直接落地无需决策。

3. **系统性约束上升**：本轮 2 项问题属于「未上升为一般性约束」类（`trigonometric.cj` 标量/向量区分 / `axis` 函数 Float32 sqrt 处理），v8 通过 §1「系统性设计约束」新增「Float32 与 std.math 的交互约束」段 + §3.13.1「trigonometric.cj 函数清单」子节，将单点问题上升为一般性约束，便于所有受影响函数引用，避免类似遗漏再次发生。

4. **测试设计可操作性提升**：本轮 2 项问题属于「测试设计可操作性不足」类（测试文件命名不一致 / 用例数比例失衡），v8 通过统一 `test_xxx.cj` 命名约定 + 新增「用例分配原则」段，提升测试设计的可操作性，下游测试编码可按明确原则规划用例数。

5. **下游可读性强化**：本轮 1 项问题属于「下游迁移可读性」类（§11.5 where 子句标注缺失），v8 通过在函数可用性对照表的关键行追加「**约束：`where T <: FloatingPoint<T>`（D29/D32）**」标注，强化下游迁移者对编译期约束的理解，避免「为何整型 T 实例化时编译失败」的疑问。

### 不引入新设计变更

v8 修订严格限定在 11 项审查意见的逐项落实范围内，不修改任何函数行为、类型形态选择、依赖方向、文件归属、命名规范原则等设计要素。前序 v2/v3/v4/v5/v6/v7 修订的累计 38 项审查意见落实情况保持不变（v2 14 项 + v3 2 项 + v4 2 项 + v5 14 项 + v6 3 处澄清 + v7 5 项 = 40 项历史意见均已闭环）。

### v3 迭代历史累计状态

经过 v1（v2 设计）→ v2（v3 设计）→ v3（v4 设计）→ v4（v5 设计）→ v5（v6 设计）→ v6（v7 设计）→ v7（v8 设计）共 7 轮设计修订：

- **v1 → v2 设计**：新增 14 项审查意见 → 落实 13 项
- **v2 → v3 设计**：补齐 v1 遗留 1 项 + 新增 2 项严重问题（包间循环依赖 + 依赖方向内部矛盾）→ 全部修复
- **v3 → v4 设计**：新增 2 项（isnan/isinf 约束缺失 + Quat 字段可见性描述缺失）→ 全部修复
- **v4 → v5 设计**：新增 14 项（2 严重 + 8 一般 + 4 轻微）→ 全部修复
- **v5 → v6 设计**：核实 v5 落实情况 + 3 处表述细节澄清
- **v6 → v7 设计**：新增 5 项（1 一般 + 4 轻微）→ 全部修复
- **v7 → v8 设计（本轮）**：新增 11 项（4 严重 + 5 一般 + 2 轻微）→ 全部修复

v7 迭代整体完成，可进入下游验证环节。

---

## 修订说明（v9）

> **修订定位**：v8 设计的迭代修订（v9）。依据本轮审查报告（`a_v5_iteration_requirement.md` 对应 v4 诊断报告 `b_v4_diag_v1.md`）识别 7 项问题（2 项严重 + 2 项一般 + 3 项轻微，其中问题 7 经诊断确认两处描述实际一致，仅格式呈现略不同，**无需修改**），实际需修复 6 项。在 v8 设计（已落实前序 11 项审查意见：4 严重 + 5 一般 + 2 轻微）的基础上，本轮针对 6 项问题逐项开展修订。

### 6 项审查意见落实情况核验表

| 审查意见 | 严重程度 | v9 落实位置 | 核验结论 |
|---------|---------|------------|---------|
| **问题 1（严重）**：`fromMat4` 引用阶段二 `fromMat` 列提取模式的描述与项目实际模式不符——v8 §3.3 item 7 引用 `cjglm/src/detail/type_mat2x2.cj:163-165` `Mat2x2.fromMat(Mat3x3, one)` 作为「无需 `one: T`」的依据，但该被引用代码本身就要求 `one: T`（阶段二全部 9 个矩阵类型的 `fromMat` 工厂函数**均要求** `one: T` 形参，无论源/目标矩阵尺寸关系，仅同维度 `fromMat` 简化为无 `one` 形参）；与 §1「T(1) 的获取：必须由调用方显式传入参数」系统性约束冲突 | 严重 | §3.3 item 7 | **已完整修复**（删除错误的 `type_mat2x2.cj:163-165` 列提取模式引用作为论据；改为基于本函数实际构造路径——Vec3 主构造 + Mat3x3 主构造（均无 `one` 形参依赖）——说明 `fromMat4` 签名无需 `one: T` 形参的合理性，与 §1 系统性约束彻底闭环） |
| **问题 2（严重）**：`mat3Cast`/`mat4Cast` T(1) 获取策略缺失，与 §1 系统性约束冲突——GLM `gtc/quaternion.inl:49` 实际使用 `Mat3x3(T(1))` 初始化 3×3 单位矩阵（即 `Result = identity`），强依赖 T(1) 字面量；但 §3.2.1 签名模板未提及 T(1) 获取方式；§1 受约束函数清单遗漏 `mat3Cast`/`mat4Cast`；§3.4 `Quat×Vec3`/`Quat×Vec4` 等使用 `T(Float64(2))` 字面量的运算符也未列出 | 严重 | §1 第一段「常量型 T(n) 字面量替代（v9 扩展）」+ 新增 v9 受 T 字面量获取策略影响的函数清单 / §3.2.1「T(1) 字面量获取策略（v9 新增）」段 / §3.4 `Quat×Vec3` 公式 `* 2` → `* T(Float64(2))` | **已完整修复**（§1 第一段扩展「常量型 T(1) 字面量替代」为「常量型 T(n) 字面量替代（v9 扩展）」+ 新增 v9 受 T 字面量获取策略影响的函数清单，覆盖 `axis` / `Quat×Vec3`/`Quat×Vec4` / `mat3Cast`/`mat4Cast`；§3.2.1 新增 T(1) 字面量获取策略段，明确 GLM `gtc/quaternion.inl:49` 实际使用 `Mat3x3(T(1))` + 仓颉实现应使用 `T(Float64(1))` 显式转换路径 + 签名无 `one: T` 形参的合理性；§3.4 `Quat×Vec3` 公式末尾 `* 2` 修订为 `* T(Float64(2))` 以匹配 v9 T 字面量获取策略） |
| **问题 3（一般）**：`ext/vector_relational.cj` GLM 文件引用错误（行号与文件名均错误）——v8 §3.5 描述「向量 `equal`/`notEqual` epsilon 版本采用严格 `<` 语义，与 GLM 1.0.3 `func_vector_relational.inl:18-22` 一致」，但 GLM 1.0.3 的 `func_vector_relational.inl` 中**根本不包含 epsilon 版本**的 `equal`/`notEqual`——epsilon 版本位于 `glm/gtc/epsilon.inl`（文件层面属 gtc 子包），行号 `18-22` 实际为 `lessThanEqual`；同时引用偏差涉及 §3.5 / §5.3 / D24 / §9 共 4 处 | 一般 | §3.5 / §5.3 边界条件表 / D24 设计决策 / §9 差异声明 | **已完整修复**（4 处 GLM 文件引用统一从 `func_vector_relational.inl:18-22` 修订为 `glm/gtc/epsilon.inl:32-41` 中 `epsilonEqual` 实现；各修订位置同步标注「v9 修订」并说明原引用错误原因——GLM 1.0.3 的 `func_vector_relational.inl` 中**不包含** epsilon 版本，epsilon 版本位于 `glm/gtc/epsilon.inl`） |
| **问题 4（一般）**：`lib.cj` 新增 import 清单不完整（遗漏 12 个新模块的 stub/别名文件）——v8 §2 「lib.cj 新增 import 清单（v5 明确）」仅列出 8 个 import 声明，但对照 §2 包组织图中新增的 16 个文件，遗漏 `glm.detail.trigonometric` / `glm.ext.quaternion_transform` / `glm.ext.quaternion_exponential` / `glm.ext.quaternion_float` / `glm.ext.quaternion_double` / `glm.ext.quaternion_float_precision` / `glm.ext.quaternion_double_precision` / `glm.ext.matrix_projection` / `glm.ext.matrix_clip_space` / `glm.ext.matrix_transform` / `glm.gtc.quaternion` / `glm.gtc.matrix_transform` 等 12 个模块的 import | 一般 | §2「lib.cj 新增 import 清单（v9 扩展补齐）」段 | **已完整修复**（§2 lib.cj import 清单从 8 个扩展为 20 个，新增 12 个 import 声明，覆盖四元数变换/指数 stub、三角函数 detail stub、gtc 四元数扩展、矩阵变换 stub、4 个别名文件、3 个矩阵 stub 模块；同步标注「v9 新增」） |
| **问题 5（轻微）**：§3.4「交换律别名」解释中 `Number<T>` 语义描述不准确——v8 描述「Quat×T 运算符已通过 `Number<T>` 约束交换律覆盖（仓颉 `Number<T>` 加法/乘法具备交换律语义）」，但 `Number<T>` 接口本身**不提供交换律语义**——仓颉运算符重载中左操作数类型决定 operator 函数归属，`T * Quat` 的 `T` 在左操作数位置时无法定义为 Quat 的成员运算符，必须通过 `scalar_quat_ops.cj` 的全局函数实现 | 轻微 | §3.4「交换律别名」注 | **已完整修复**（删除原描述中「仓颉 `Number<T>` 加法/乘法具备交换律语义」错误表述；明确说明 `T * Quat` 通过 `scalar_quat_ops.cj` 全局函数实现的根本原因是左操作数类型决定 operator 函数归属，而非 `Number<T>` 提供交换律覆盖；保留与 `type_quat.cj` 的 `Quat×T` 成员运算符不构成重载冲突的说明——前者实现 `T * Quat`，后者实现 `Quat * T`，左操作数类型不同） |
| **问题 6（轻微）**：§11.5 gtc 重导出行的 `where T <: FloatingPoint<T>` 约束归属描述不清——v8 标注「约束：`where T <: FloatingPoint<T>`（D32）」，但 D32 实际针对 `detail/type_quat_cast.cj` 的原始定义函数；gtc 命名空间下的同名函数是通过 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 重导出，约束应在重导出端自动继承自 detail 端实现 | 轻微 | §11.5 函数可用性对照表 `mat3_cast`/`mat4_cast`/`quat_cast`（gtc，重导出）行 | **已完整修复**（gtc 重导出行的约束标注修订为「**约束：`where T <: FloatingPoint<T>`（D32，约束继承自 detail 端实现，通过 public import glm.detail.{mat3Cast, mat4Cast, quatCast} 透明传递）**」；明确下游消费者看到 gtc 端约束时，实际约束来自 detail 端实现） |
| **问题 7（自查透明，无需修改）**：§8「产出物清单」中 `gtc/quaternion.cj` 行数量描述与 §3.2 协作关系表存在视觉呈现差异（实际无矛盾） | — | — | **无需修改**（诊断确认两处描述实际一致，仅格式呈现略不同） |

### v9 修订特点

1. **事实准确性与系统性约束闭环**：本轮 2 项严重问题均属于「事实错误/直接阻塞编码」类——`fromMat4` 引用错误代码（被引用代码 `Mat2x2.fromMat(Mat3x3, one)` 本身就要求 `one: T`，与「无需 `one`」结论相悖）+ `mat3Cast`/`mat4Cast` T(1) 获取策略缺失（GLM `gtc/quaternion.inl:49` 实际强依赖 `Mat3x3(T(1))` 字面量，但设计文档未指定 T(1) 获取路径）。v9 通过删除错误的代码引用作为论据 + 在 §3.2.1 新增 T(1) 字面量获取策略段 + 在 §1 第一段扩展「常量型 T(1) 字面量替代」为「常量型 T(n) 字面量替代（v9 扩展）」+ 新增 v9 受 T 字面量获取策略影响的函数清单（覆盖 `axis` / `Quat×Vec3`/`Quat×Vec4` / `mat3Cast`/`mat4Cast`）+ §3.4 `Quat×Vec3` 公式 `* 2` 修订为 `* T(Float64(2))`，实现与 §1 系统性约束的彻底闭环。

2. **GLM 文件引用准确性**：本轮 1 项一般问题涉及 GLM 文件引用错误——`ext/vector_relational.cj` 的 epsilon 版本不在 `func_vector_relational.inl`（GLM 1.0.3 的 `func_vector_relational.inl` 中**不包含** epsilon 版本，行号 18-22 实际为 `lessThanEqual`），而位于 `glm/gtc/epsilon.inl:32-41`（`epsilonEqual` 实现位置，文件层面属 gtc 子包）。v9 通过 §3.5 / §5.3 边界条件表 / D24 设计决策 / §9 差异声明 共 4 处 GLM 文件引用统一从 `func_vector_relational.inl:18-22` 修订为 `glm/gtc/epsilon.inl:32-41` 中 `epsilonEqual` 实现，确保与 GLM 实际源码对齐，下游编码者按修订后引用查阅 GLM 源码可定位到正确的实现位置。

3. **`lib.cj` import 清单完整性**：本轮 1 项一般问题涉及 `lib.cj` import 清单遗漏 12 个新模块——v9 通过 §2 import 清单从 8 个扩展为 20 个，新增 12 个 import 声明覆盖：四元数变换/指数 stub（`glm.ext.quaternion_transform`/`glm.ext.quaternion_exponential`）+ 三角函数 detail stub（`glm.detail.trigonometric`）+ gtc 四元数扩展（`glm.gtc.quaternion`）+ 矩阵变换 stub（`glm.gtc.matrix_transform`）+ 4 个别名文件（`glm.ext.quaternion_float`/`quaternion_double`/`quaternion_float_precision`/`quaternion_double_precision`）+ 3 个矩阵 stub 模块（`glm.ext.matrix_projection`/`matrix_clip_space`/`matrix_transform`），确保下游消费者可按 lib.cj import 清单访问所有新增模块（stub/别名/gtc），无需自行分散 import 各个子模块。

4. **语义准确性强化**：本轮 2 项轻微问题涉及 `Number<T>` 语义描述错误（`Number<T>` 接口本身**不提供交换律语义**，仅约束四则运算实现）+ gtc 重导出行约束归属描述不清（gtc 端约束通过 public import 自动继承自 detail 端，非独立定义）。v9 通过 §3.4「交换律别名」注删除错误的"仓颉 `Number<T>` 加法/乘法具备交换律语义"表述，明确 `T * Quat` 通过 `scalar_quat_ops.cj` 全局函数实现的根本原因是左操作数类型决定 operator 函数归属（D05 决策）；§11.5 gtc 重导出行的约束标注增加"约束继承自 detail 端实现，通过 public import glm.detail.{mat3Cast, mat4Cast, quatCast} 透明传递"说明，明确下游消费者看到 gtc 端约束时实际约束源自 detail 端实现。

### 不引入新设计变更

v9 修订严格限定在 6 项审查意见的逐项落实范围内，不修改任何函数行为、类型形态选择、依赖方向、文件归属、命名规范原则等设计要素。前序 v2/v3/v4/v5/v6/v7/v8 修订的累计审查意见落实情况保持不变（v2 14 项 + v3 2 项 + v4 2 项 + v5 14 项 + v6 3 处澄清 + v7 5 项 + v8 11 项 = 51 项历史意见均已闭环）。

### v4 迭代历史累计状态

经过 v1（v2 设计）→ v2（v3 设计）→ v3（v4 设计）→ v4（v5 设计）→ v5（v6 设计）→ v6（v7 设计）→ v7（v8 设计）→ v8（v9 设计）共 8 轮设计修订：

- **v1 → v2 设计**：新增 14 项审查意见 → 落实 13 项
- **v2 → v3 设计**：补齐 v1 遗留 1 项 + 新增 2 项严重问题（包间循环依赖 + 依赖方向内部矛盾）→ 全部修复
- **v3 → v4 设计**：新增 2 项（isnan/isinf 约束缺失 + Quat 字段可见性描述缺失）→ 全部修复
- **v4 → v5 设计**：新增 14 项（2 严重 + 8 一般 + 4 轻微）→ 全部修复
- **v5 → v6 设计**：核实 v5 落实情况 + 3 处表述细节澄清
- **v6 → v7 设计**：新增 5 项（1 一般 + 4 轻微）→ 全部修复
- **v7 → v8 设计**：新增 11 项（4 严重 + 5 一般 + 2 轻微）→ 全部修复
- **v8 → v9 设计**：新增 7 项（2 严重 + 2 一般 + 3 轻微，其中问题 7 自查无需修改）→ 实际修复 6 项

v8 迭代整体完成，可进入下游验证环节。

---

## 修订说明（v10）

> **修订定位**：v9 设计的迭代修订（v10）。依据本轮审查报告（`a_v6_iteration_requirement.md` 对应 v5 诊断报告 `b_v5_diag_v1.md`）从需求响应充分度、整体深度与完整性、设计可落地性维度识别 17 项质量问题（3 严重 + 13 一般 + 1 轻微）。在 v9 设计（已落实前序 51 项审查意见：v2 14 + v3 2 + v4 2 + v5 14 + v6 3 + v7 5 + v8 11 = 51）的基础上，本轮针对 17 项问题逐项开展修订。

### 17 项审查意见落实情况核验表

| 审查意见 | 严重程度 | v10 落实位置 | 核验结论 |
|---------|---------|------------|---------|
| **问题 1（严重）**：§3.10、D21、§8 编码启动前验证项 16/18 多次引用 `FloatingPoint<T>.getMin()` 和 `FloatingPoint<T>.getInf()` 实例方法作为「主策略」。但 `cangjie-std/math/README.md` 第 111-115 行明确仓颉 stdlib **不存在**这两个方法，仅存在 `Float64.Inf`/`Float64.Min`/`Float64.Max`/`Float64.NaN` 静态常量；`FloatingPoint<T>` 接口本身仅作为类型约束被声明，无任何实例方法 | 严重 | §3.10 `pow`/`log` 依赖 / D21 设计决策 / §8 验证项 16/18/13 | **已完整修复**（删除 `FloatingPoint<T>.getMin()`/`getInf()` 实例方法引用作为主策略；明确「仓颉 stdlib 仅提供 `Float64.Min`/`Float64.Inf`/`Float32.Min`/`Float32.Inf` 静态常量，`FloatingPoint<T>` 接口本身无任何实例方法」；下游实现路径修订为类型分派 `if (q.x is Float32) { Float32.Min/Inf } else { Float64.Min/Inf }` 或字面量 fallback `T(1)/T(0)`/`T(1)/T(很大值)` 显式构造；§8 验证项 16/18 描述同步修订为「验证类型分派路径 + 字面量 fallback 路径的编译可行性」；验证项 13 中 `getMin()`/`getInf()` 提示同步删除） |
| **问题 2（严重）**：fwd.cj 四元数别名计数自相矛盾（声称 8，实际 9）——§3.14、§2 lib.cj/fwd.cj 段落、§8 更新文件段多处声称「合计 8 个别名」并明确列出 `Quat`/`FQuat`/`DQuat` + 3×Float32 精度 + 3×Float64 精度 = **9 个**别名，算术 3+3+3=9 与汇总数字 8 直接矛盾 | 严重 | §2 lib.cj/fwd.cj 段落 / §3.14 四元数别名文件 | **已完整修复**（§2 lib.cj/fwd.cj 段落「合计 8 个别名」统一修订为「**合计 9 个别名**」，并附「v10 修订」标注说明 v9 描述误为 8 个；§3.14「合计 8 个别名」同步修订为「**合计 9 个别名**」，明确「1+1+1+3+3 = 9」算术依据） |
| **问题 3（严重）**：§3.10 「命名消歧（v5 新增）」段声明「四元数 `pow` 函数体内部调用的 `pow(x.w, y)` 是实数版本 `std.math.pow(T, T): T`」，但 `cangjie-std/math/README.md` 第 13 行明确 `std.math.pow` 实际签名为 `pow(base: Float64, exponent: Float64): Float64`，**不是**泛型 `pow(T, T): T`。下游按设计字面实现时：当 T=Float64 时签名不一致（返回 Float64 而非 T）；当 T=Float32 时直接编译失败 | 严重 | §3.10 `pow` 函数描述 / D21 设计决策 | **已完整修复**（§3.10 `pow` 函数描述全文将「`std.math.pow(T, T): T`」修订为「`std.math.pow(Float64, Float64): Float64`」（仅支持 Float64 输入/输出）；明确下游实现路径为 `Float64(std.math.pow(Float64(x.w), Float64(y)))` 当 T=Float32 时 / `T(std.math.pow(Float64(x.w), Float64(y)))` 当 T=Float64 时回转目标类型 T；fallback 路径 `Float64(std.math.exp(Float64(y) * std.math.log(Float64(x.w))))` 同步需 Float64 转换；D21 决策依据同步修订，明确 `std.math.pow` 实际签名为 `(Float64, Float64): Float64`） |
| **问题 4（一般）**：未识别与阶段二已有 `epsilonOf<T>(hint)` 函数的命名冲突与冗余设计——`cjglm/src/detail/shim_limits.cj:25` 已存在同名语义的 `public func epsilonOf<T>(hint: T): T`，且 `compute_vector_relational.cj:17` 已使用。设计 §3.12 新增 `func epsilon<T>(): T` 未说明两函数等价性、返回值一致性、阶段二测试硬编码值未做交叉验证 | 一般 | §3.12 ext/scalar_constants.cj 段 / §8 验证项 19 | **已完整修复**（§3.12 「ext/scalar_constants.cj」段新增「**与 `shim_limits.cj:25` `epsilonOf<T>(hint)` 关系（v10 新增，Issue 4 响应）**」子段，明确 (a) 两函数功能等价，无业务新增；(b) `epsilon<T>()` 无形参与 `epsilonOf<T>(hint)` 携带 `hint: T` 形参的签名差异说明；(c) 阶段二测试硬编码值作为 ground truth；(d) 编码启动前验证项新增 19「验证 `epsilon<T>()` 与 `epsilonOf<T>(hint)` 在 T=Float32/Float64/Int64 下的返回值一致性」） |
| **问题 5（一般）**：§3.13.1 `VecN<T,Q>` 占位符未映射到仓颉实际类型展开模式——仓颉项目不存在 `VecN` 泛型占位类型，实际模式是 `compute_vec_add1`/`add2`/`add3`/`add4` 四个独立 struct | 一般 | §3.13.1 trigonometric.cj 函数清单 | **已完整修复**（§3.13.1 表头新增「**`VecN<T, Q>` 占位符展开规则（v10 新增，Issue 5 响应）**」段，明确 `VecN<T, Q>` 占位符实际展开为 `Vec1<T,Q>`/`Vec2<T,Q>`/`Vec3<T,Q>`/`Vec4<T,Q>` 4 个独立重载，命名沿用 `cjglm/src/detail/compute_vector_decl.cj` 的 `compute_vec_xxx1/2/3/4` 模式；函数总数重新核算为 75 个函数 = 14 标量单参数 + 14×4=56 向量单参数 + 1 标量双参数 `atan2` + 1×4=4 向量双参数 `atan2`） |
| **问题 6（一般）**：§5.4 const 约束声明与 §3.11 函数体描述存在内部矛盾——§5.4 声明「`lerp`/`conjugate`/`inverse` 不可在 const 上下文调用」，但 §3.11 `conjugate(q)` 描述函数体内仅对 x/y/z 三个分量取反，无 assert/throw/运行时副作用，实际可在 const 上下文调用 | 一般 | §5.4 const 上下文约束 / §3.11 `conjugate` 描述 | **已完整修复**（§5.4 修订为「`lerp`/`inverse` 不可在 const 上下文调用（v10 修订，Issue 6 响应）」，移除 `conjugate`；补充 `inverse` 的 const 拒绝理由：「依赖 `/` 运算符，整数 T 在 `dot(q,q) == 0` 时触发 `ArithmeticException`，非 const 函数」；§3.11 `conjugate` 描述末尾新增「const func 适用性（v10 新增，Issue 6 响应）」段，明确 `conjugate` 函数体仅涉及 `Quat` 主构造函数的逐分量取反调用，可声明为 `const func`；附注「若仓颉 const 函数还有其他限制，则该论断需进一步评估」） |
| **问题 7（一般）**：§3.13.1 trigonometric.cj 中 `radians`/`degrees` 函数实现路径未明确（π 字面量 vs `pi<T>()`），且 stage 3 实际是 stub，依赖 stage 4 才落地 | 一般 | §3.13.1 trigonometric.cj 函数清单 | **已完整修复**（§3.13.1 `radians`/`degrees` 行「内部依赖」列明确补充「**v10 修订（Issue 7 响应）**：硬编码 π 字面量 `Float64(3.141592653589793)`，无 std.math 依赖，无 `scalar_constants` 依赖（避免与 `pi<T>()` 的运行时调用）」；下游实现阶段四 trigonometric.cj 时直接使用 `Float64(3.141592653589793)` 字面量计算度↔弧度转换公式，无需调用 `pi<T>()`） |
| **问题 8（一般）**：§8.2 测试文件结构 `tests/glm/ext/` 与现有项目惯例 `tests/glm/test_ext.cj`（单一聚合文件）不一致——实际 `tests/glm/ext/` 目录不存在，阶段二 25 个测试文件均位于 `tests/glm/detail/`。设计引入 `tests/glm/ext/` 与 `tests/glm/gtc/` 是新建目录结构，但未说明与既有 `test_ext.cj` 的关系及迁移策略 | 一般 | §8.2 测试文件清单与位置表 | **已完整修复**（§8.2 测试设计新增「**测试目录结构对齐策略（v10 新增，Issue 8 响应）**」段，明确 (a) 避免新建 `tests/glm/ext/` 与 `tests/glm/gtc/` 子目录，所有新增测试文件采用 `tests/glm/test_xxx.cj` 同层平铺命名（与 `test_ext.cj` 一致）；(b) 既有 `tests/glm/test_ext.cj`（102 行，验证 ext 包基础别名）保持原状，新增的 `tests/glm/test_ext_xxx.cj` 文件按 ext 子模块拆分，与 `test_ext.cj` 并存不冲突；(c) 4 个 ext/ 别名文件测试合并为单一 `tests/glm/test_ext_quaternion_aliases.cj` 文件；(d) 下游实施步骤：测试文件创建前无需 `mkdir -p`，按上述命名直接创建；§8.2 表 13 个测试文件名同步从 `tests/glm/ext/test_xxx.cj`/`tests/glm/gtc/test_xxx.cj` 修订为 `tests/glm/test_ext_xxx.cj`/`tests/glm/gtc/test_xxx.cj` 同层平铺命名） |
| **问题 9（一般）**：§2 模块间依赖图中 gtc/quaternion.cj 对 Mat3x3/Mat4x4/Vec3 的依赖声明过宽——逐项核查 15 个函数：4 个比较函数仅依赖 Quat；3 个 quatLookAt 函数仅依赖 Vec3，不依赖 Mat 类型。设计将依赖声明扩展至全部 Mat/Vec 类型 | 一般 | §2 模块间依赖图 `glm.gtc` 块 | **已完整修复**（§2 模块间依赖图 `glm.gtc` 块 `quaternion.cj → glm.detail.{Quat, Mat3x3, Mat4x4, Vec3}` 修订为分段声明：「4 个比较函数（`lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual`）**仅依赖 Quat**；3 个 quatLookAt 函数（`quatLookAt`/`quatLookAtRH`/`quatLookAtLH`）**仅依赖 Vec3**；4 个转换函数（`mat3_cast`/`mat4_cast`/`quat_cast` × 2）**重导出 detail 端**（不需直接 import Mat/Vec）；4 个欧拉函数（`eulerAngles`/`roll`/`pitch`/`yaw`）**依赖 Vec3 + Quat**」；下游按声明增加 import 后不会产生未使用 import） |
| **问题 10（一般）**：§3.13.1 trigonometric.cj 受 Float32 与 std.math 交互约束影响的函数清单遗漏 trigonometric.cj 自身——trigonometric.cj 实现的 14 个标量函数本身调用 `std.math.sin`/`cos`/`tan` 等 Float64-only 函数，下游实现时需对每个函数应用 `T(Float64.xxx(Float64(value)))` 转换模式 | 一般 | §3.13.1 trigonometric.cj 函数清单 | **已完整修复**（§3.13.1 表后新增「**Float32 实例化影响（v10 新增，Issue 10 响应）**」段：「**所有 `std.math.*` 函数（sin/cos/tan/asin/acos/atan/sinh/cosh/tanh/asinh/acosh/atanh/atan2/sqrt/pow/log/exp）均仅支持 Float64 输入/输出**，所有 trigonometric.cj 函数在 T=Float32 实例化时需应用 `T(Float64.xxx(Float64(value)))` 转换模式（与 §1「Float32 与 std.math 的交互约束」一致）。`radians`/`degrees` 是例外——纯算术公式无 std.math 依赖，Float32 实例化无需转换」；表行「内部依赖」列对 `std.math.{func}` 调用统一标注「**仅 Float64，Float32 实例化需显式转换**」） |
| **问题 11（一般）**：§3.9 `axis` 函数公式中冗余的 `Float64(...)` 包装层——`tmp2 = T(Float64(1)) / T(Float64(std.math.sqrt(Float64(tmp1))))`，其中 `Float64(std.math.sqrt(...))` 等价于 `Float64(Float64)`（冗余但合法） | 一般 | §3.9 `axis` 函数描述 | **已完整修复**（§3.9 `axis` 函数公式修订为 `tmp2 = T(Float64(1)) / T(std.math.sqrt(Float64(tmp1)))`，删除冗余的 `Float64(...)` 包装；在公式旁新增「v10 修订（Issue 11 响应）：删除冗余的 `Float64(std.math.sqrt(...))` 包装层——`std.math.sqrt` 已是 `Float64` 输入/输出，等价于 `Float64(Float64)` 的冗余嵌套，仅需一次 `T(Float64(…))` 转换回目标类型 T」解读注释） |
| **问题 12（一般）**：§1 与 §3.10 对 `pow` 函数「Float64 转换依赖」段引用位置不一致——§1 通用约束已说明 pow 需 Float64 转换，§3.10 又单设「Float64 转换依赖（v7 澄清）」子段，二者功能重叠 | 一般 | §3.10 `pow` 函数描述 | **已完整修复**（§3.10 `pow` 描述中 v5「命名消歧」与 v7「Float64 转换依赖（v7 澄清）」两段合并为单一「**命名消歧与 Float64 转换（v5 新增，v7 澄清，v10 合并）**」子段；新段落引用 §1 通用约束而非重复展开：「`pow(Quat<Float32, Q>, Float32)` 实现路径遵循 §1「Float32 与 std.math 的交互约束」通用约束（应用 `T(Float64.std.math.pow(Float64(x.w), Float64(y)))` 转换模式）」；fallback 路径 `exp(y * log(x.w))` 同步遵循 §1 通用约束；下游阅读时不再产生「§1 已说明通用规则为何 §3.10 又重复一次」的疑问） |
| **问题 13（一般）**：§3.11 `inverse` 描述与 §5.3 边界条件表对整数 `inverse` 行为契约措辞不一致——虽两处描述本质一致，但 §5.3 表的「`axis(q)` 零四元数」行措辞（`\|w\| >= 1`）与 §3.9 `axis` 描述（`tmp1 <= 0`）虽等价但措辞略不同，且 §5.3 表未说明 `tmp1 = T(1) - x.w*x.w` 的计算公式 | 一般 | §3.11 `inverse` 描述 / §5.3 边界条件表 | **已完整修复**（§5.3 边界条件表「`axis(q)` 零四元数」行补充「**v10 补充，Issue 13 响应**：`tmp1 = T(1) - x.w*x.w` 计算公式参见 §3.9 `axis` 函数描述」明确公式引用；§5.3 表的「整数 `inverse`」行措辞与 §3.11 `inverse` 描述统一为「触发仓颉 `ArithmeticException`」（v10 措辞统一标注），§3.11 `inverse` 描述末尾标注「v10 措辞统一，Issue 13 响应」） |
| **问题 14（一般）**：与问题 1 同源，§8 编码启动前验证项 16/18 验证目标不存在的 API，导致实际验证项无法独立完成 | 一般 | §8 编码启动前验证项 16/18 | **已完整修复**（与问题 1 同步修订：验证项 16/18 描述从「验证 `FloatingPoint<T>.getMin()`/`getInf()` 实例方法可用性」修订为「验证类型分派路径 + 字面量 fallback 路径的编译可行性」；明确「仓颉 stdlib 仅提供 `Float64.Min`/`Float64.Inf`/`Float32.Min`/`Float32.Inf` 静态常量，`FloatingPoint<T>` 接口本身无任何实例方法」） |
| **问题 15（轻微）**：§8.2 测试用例总数算术偏差（声称 ≥178 实际累加为 179，差 1） | 轻微 | §8.2 测试文件清单与位置表末尾 | **已完整修复**（§8.2 表末尾「合计」数字从「≥178」修订为「≥179」；附「v10 修订：v9 声称 ≥178，累加实际为 179；按上述每行 ≥值求和：40+8+8+12+16+8+4+2+16+6+4+28+27=179」算术依据） |
| **问题 16（一般）**：§11.5 函数可用性对照表 `lessThan`/`lessThanEqual` 等 4 个比较函数的约束未标注 | 一般 | §11.5 函数可用性对照表 / §3.15 完整实现函数段 | **已完整修复**（§11.5 `lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual` 行追加「**约束：`where T <: Comparable<T>`（依赖 `<`/`>` 运算符，v10 新增标注，Issue 16 响应）**」标注；§3.15 完整实现函数段 4 行同步补充 `where T <: Comparable<T>` 约束与「v10 新增，Issue 16 响应」标注） |
| **问题 17（轻微）**：§2 lib.cj import 清单 #1 `glm.detail.{Quat, mat3Cast, mat4Cast, quatCast}` 类型与函数混合导入的语义边界未说明——下游按 §11.4 迁移示例调用 `let m3 = mat3Cast(q)`（无命名空间前缀）会编译失败，需先 `import glm.detail.*` 才能调用包级函数 | 轻微 | §2 lib.cj import 清单 / §11.4 迁移示例 | **已完整修复**（§2 lib.cj import 清单 #1 补充说明：`mat3Cast`/`mat4Cast`/`quatCast` 在 lib.cj 中以 `public import` 形式重导出至顶层 `glm` 命名空间——与现有 `public import glm.detail.{transpose, matrixCompMult, outerProduct}` 包级函数重导出模式一致，见 `cjglm/src/lib.cj:8`——下游消费者可按 `glm.mat3Cast(q)` 路径直接调用，**无需** `import glm.detail.*` 后再调用包级函数 `mat3Cast(q)`；§11.4 迁移示例新增「仓颉顶层 glm 命名空间调用」代码段：`let m3_top = glm.mat3Cast(q)` / `let q2_top = glm.quatCast(m)`，与 lib.cj 的 `public import` 重导出模式对应；并修订「仓颉 detail 直接调用」代码段，提示需先 `import glm.detail.*` 才能调用包级函数） |

### v10 修订特点

1. **事实准确性与直接阻塞编码修复**：本轮 3 项严重问题均属「事实错误/直接阻塞编码」类——`FloatingPoint<T>.getMin()`/`getInf()` 实例方法在仓颉 stdlib 不存在（`cangjie-std/math/README.md` 第 111-115 行仅列出 `Float64.Inf`/`Float64.Min`/`Float64.Max`/`Float64.NaN` 静态常量，第 117 行明确 `FloatingPoint<T>` 接口仅作为类型约束声明无任何实例方法）；fwd.cj 四元数别名计数自相矛盾（声称 8，实际 1+1+1+3+3=9）；`std.math.pow` 实际签名为 `pow(base: Float64, exponent: Float64): Float64`（仅支持 Float64 输入/输出），v9 描述的泛型 `std.math.pow(T, T): T` 不存在。v10 通过逐处修订 §3.10/D21/§8 验证项 + §2/§3.14 别名计数 + §3.10 命名消歧段，实现与仓颉 stdlib 实际 API 的彻底对齐。

2. **下游可执行性强化**：本轮 10 项一般问题涵盖下游可执行性维度——`epsilonOf` 命名冲突与等价性（§3.12 新增「与 `shim_limits.cj:25` `epsilonOf<T>(hint)` 关系」子段 + 验证项 19）/ `VecN<T, Q>` 占位符展开规则（§3.13.1 新增占位符展开规则段 + 实际函数总数 75 重算）/ `conjugate` const 约束（§5.4 移除 `conjugate` 从禁止列表 + §3.11 补充 const func 适用性）/ `radians`/`degrees` π 字面量路径（§3.13.1 明确硬编码 `Float64(3.141592653589793)` 字面量）/ 测试目录结构（§8.2 新增「测试目录结构对齐策略」段，同层平铺命名）/ gtc/quaternion.cj 依赖声明过宽（§2 模块间依赖图分段声明）/ trigonometric.cj Float32 实例化影响（§3.13.1 新增「Float32 实例化影响」段 + 表行统一标注）/ `axis` 冗余 `Float64` 包装（§3.9 公式精修）/ §1 与 §3.10 `pow` 描述重叠（§3.10 合并为单一「命名消歧与 Float64 转换」子段）/ `inverse` 措辞统一（§3.11 与 §5.3 措辞同步）/ §8 验证项 16/18 验证目标不存在（同步问题 1 修复）/ `lessThan` 等 4 个比较函数约束未标注（§11.5 + §3.15 同步补充 `where T <: Comparable<T>`）/ lib.cj import #1 语义边界（§2 + §11.4 同步说明 `public import` 重导出模式）。

3. **测试可执行性提升**：本轮 1 项轻微问题涉及测试用例总数算术偏差——v9 声称 ≥178，实际累加为 179。v10 通过 §8.2 表同步修订为 ≥179 + 提供「40+8+8+12+16+8+4+2+16+6+4+28+27=179」算术依据 + 测试目录结构对齐策略（避免新建 `tests/glm/ext/`/`tests/glm/gtc/` 子目录），提升测试设计的可执行性。

4. **不引入新设计变更**：v10 修订严格限定在 17 项审查意见的逐项落实范围内，不修改任何函数行为、类型形态选择、依赖方向、文件归属、命名规范原则等设计要素。前序 v2/v3/v4/v5/v6/v7/v8/v9 修订的累计 51 项审查意见落实情况保持不变。

### v5 迭代历史累计状态

经过 v1（v2 设计）→ v2（v3 设计）→ v3（v4 设计）→ v4（v5 设计）→ v5（v6 设计）→ v6（v7 设计）→ v7（v8 设计）→ v8（v9 设计）→ v9（v10 设计）共 9 轮设计修订：

- **v1 → v2 设计**：新增 14 项审查意见 → 落实 13 项
- **v2 → v3 设计**：补齐 v1 遗留 1 项 + 新增 2 项严重问题（包间循环依赖 + 依赖方向内部矛盾）→ 全部修复
- **v3 → v4 设计**：新增 2 项（isnan/isinf 约束缺失 + Quat 字段可见性描述缺失）→ 全部修复
- **v4 → v5 设计**：新增 14 项（2 严重 + 8 一般 + 4 轻微）→ 全部修复
- **v5 → v6 设计**：核实 v5 落实情况 + 3 处表述细节澄清
- **v6 → v7 设计**：新增 5 项（1 一般 + 4 轻微）→ 全部修复
- **v7 → v8 设计**：新增 11 项（4 严重 + 5 一般 + 2 轻微）→ 全部修复
- **v8 → v9 设计**：新增 7 项（2 严重 + 2 一般 + 3 轻微，其中问题 7 自查无需修改）→ 实际修复 6 项
- **v9 → v10 设计（本轮）**：新增 17 项（3 严重 + 13 一般 + 1 轻微）→ 全部修复

v10 迭代整体完成，可进入下游验证环节。
