# GLM 1.0.3 仓颉迁移阶段三 OOD 设计方案

> **修订日期**：2026-06-24
> **修订定位**：v6 设计的迭代修订（v7）。依据本轮审查报告（a_v3_review_v1.md）识别 1 项一般问题（`FloatingPointNumber<T>` 接口命名与仓颉 stdlib `FloatingPoint<T>` 不一致）+ 4 项轻微问题（§3.4 Bool 四元数算术运算编译期拒绝说明 / §3.10 pow 实数版本 Float64 转换依赖 / §3.16 §11.5 权威基准说明 / §3.4 Vec extend 块实现链路注释）开展修订。在 v6 设计（已落实上一轮 14 项审查意见）的基础上，对所有 `FloatingPointNumber<T>` 接口引用统一为 `FloatingPoint<T>`（仓颉 std.math 第 117 行原生接口），并补充 4 项设计意图澄清注释。本轮不引入新的设计变更，仅做接口命名统一与 4 处表述强化。

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
| gtc/constants.cj | 数学常量定义（zero/one/pi/half_pi 等 25 个常量） | 完整实现 |
| **gtc/quaternion.cj** | **gtc 四元数扩展函数库（欧拉/比较/看向函数 + 转换函数重导出）** | **混合型：8 函数完整实现 + 7 函数 stub + 4 函数重导出** |
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

**lib.cj 新增 import 清单（v5 明确）**：
- `import glm.detail.{Quat, mat3Cast, mat4Cast, quatCast}` — 四元数类型 + 转换函数
- `import glm.ext.vector_relational` — 向量关系运算（含 16 重载 epsilon + 8 重载 ULP stub）
- `import glm.ext.quaternion_common` — 四元数公共函数（5 实现 + 3 stub）
- `import glm.ext.quaternion_geometric` — 四元数几何函数（4 实现）
- `import glm.ext.quaternion_trigonometric` — 四元数三角函数（1 实现 + 2 stub）
- `import glm.ext.quaternion_relational` — 四元数关系运算（4 实现）
- `import glm.ext.scalar_constants` — 标量常量（3 函数重导出）
- `import glm.gtc.constants` — 数学常量（25 函数）

**fwd.cj 新增 type alias 清单（v5 明确，与 §3.14 对应，共 8 个别名）**：
- `type Quat = Quat<Float32, PackedHighp>` — Float32 主别名
- `type FQuat = Quat<Float32, PackedHighp>` — Float32 别名（与 `Quat` 等价，遵循阶段二双别名模式）
- `type DQuat = Quat<Float64, PackedHighp>` — Float64 主别名
- `type HighpQuat = Quat<Float32, Highp>` — Float32 高精度别名
- `type MediumpQuat = Quat<Float32, Mediump>` — Float32 中精度别名
- `type LowpQuat = Quat<Float32, Lowp>` — Float32 低精度别名
- `type HighpDQuat = Quat<Float64, Highp>` — Float64 高精度别名
- `type MediumpDQuat = Quat<Float64, Mediump>` — Float64 中精度别名
- `type LowpDQuat = Quat<Float64, Lowp>` — Float64 低精度别名
- 合计 8 个别名（v5 修正：原描述遗漏 1 个，完整应为 Quat/FQuat/DQuat + 3×Float32 精度 + 3×Float64 精度 = 8 个），与阶段二 `Mat2x2`/`FMat2x2` 双别名机制一致
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
  ├── constants.cj ★        — 数学常量定义（25 个常量函数完整实现）
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
  quaternion.cj → glm.detail.{Quat, Mat3x3, Mat4x4, Vec3}（用于实现比较/欧拉/看向函数）
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

7. **从旋转矩阵构造 fromMat4(m: Mat4x4<T,Q>)** — 辅助工厂函数，内部先降维至 3×3 矩阵（提取左上 3×3 子矩阵或按 GLM 策略转换为 Mat3x3）再调用同包 `quatCast`。非 const。**边界行为**：同上，依赖 `fromMat3` 的输入合法性。

8. **从两向量构造 fromVec3(u: Vec3<T,Q>, v: Vec3<T,Q>)** — 辅助工厂函数，内部实现从两个归一化轴构建四元数。依赖 geometric.cj 的 `dot`/`cross`/`normalize`（均为 stub），因此本阶段为 **stub 占位**，完整实现推迟至阶段四。

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
| 二元 `*` (Quat×Vec3) | 四元数旋转向量 | `Number<T>` | 实现：`v + (cross(QuatVector, v) * q.w + cross(QuatVector, cross(QuatVector, v))) * 2`（两次 Vec3 叉乘 `uv`/`uuv`，与 GLM `type_quat.inl:359-366` 一致）。**依赖 `geometric.cj` 向量 `cross`（阶段三 stub），调用将抛 `Exception("stub")`** |
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

注：标量×四元数乘法无需单独"交换律别名"函数——`Quat×T` 运算符已通过 `Number<T>` 约束交换律覆盖（仓颉 `Number<T>` 加法/乘法具备交换律语义），且仓颉函数重载规则禁止重复签名（同参数列表+同返回类型无法构成有效重载，将触发"重复定义"编译错误）。

**一元 + 运算符**：仓颉不支持重载一元 `+` 运算符（与 deviations.md IF-01 一致），`+q` 不可编译，直接使用 `q` 即可。

**复合赋值运算符**：`+=`/`-=`/`*=`（四元数乘法）/`*=`（标量乘法）/`/=` 由编译器自动生成（仓颉语言规范保证，与阶段二一致）。

### 3.5 ext/vector_relational.cj

**角色**：提供向量 epsilon 容差比较和 ULP 比较扩展函数。

**职责**：定义 8 个函数（4 个 epsilon 版本 + 4 个 ULP 版本），每个函数按 Vec1~Vec4 分量数提供泛型重载。

**epsilon 版本**（完整实现）：
- `equal(x: VecN<T,Q>, y: VecN<T,Q>, epsilon: T): VecN<Bool,Q>` — 逐分量 `|x-y| < epsilon`（严格小于，与 GLM 1.0.3 `func_vector_relational.inl:18-22` 一致）
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
- `axis(x: Quat<T,Q>): Vec3<T,Q>` — 实现公式（与 GLM `ext/quaternion_trigonometric.inl:20-27` 一致）：`tmp1 = T(1) - x.w * x.w`；若 `tmp1 <= T(0)` 返回 `Vec3(T(0), T(0), T(1))`（z 轴单位向量）；否则 `tmp2 = T(1) / sqrt(tmp1)`，返回 `Vec3(x.x*tmp2, x.y*tmp2, x.z*tmp2)`。依赖仅 `std.math.sqrt` 和 T(1) 演算（通过 `x.w*x.w` 取得），**可完整实现**。**边界行为（v3 新增契约，v5 修订）**：触发 `Vec3(T(0), T(0), T(1))` 返回值的条件为 `T(1) - x.w*x.w <= T(0)`（典型场景：单位四元数 `(0, 0, 0, 1)` 即 `|w| >= 1`）；对于真正的零四元数 `(0, 0, 0, 0)`，`tmp1 = 1 > 0` 进入 else 分支返回 `Vec3(0, 0, 0)`（**注意：v3 原描述的「内部 `normalize(Vec3(0, 0, 0))` 返回 `Vec3(T(1), T(0), T(0))`」为虚构实现，GLM 源码不调用 `normalize`，v5 修订纠正**）。
- `angleAxis(angle: T, axis: Vec3<T,Q>): Quat<T,Q>` — 依赖 `sin`/`cos`（trigonometric.cj stub）。**stub 占位**。

**修正本阶段策略**：
- `axis` — **完整实现**（依赖仅 `std.math.sqrt` 和 T(1) 演算，零四元数保护行为见上）
- `angle` — **stub 占位**（依赖 trigonometric.cj 的 `asin`/`acos`）
- `angleAxis` — **stub 占位**（依赖 trigonometric.cj 的 `sin`/`cos`）

### 3.10 ext/quaternion_exponential.cj

**角色**：提供四元数指数函数（exp、log、pow、sqrt）。

**依赖分析**：
- `exp(q: Quat<T,Q>): Quat<T,Q>` — 依赖 `length`（quaternion_geometric，已实现）、`epsilon<T>()`（scalar_constants.cj，line 10 用于 `Angle < epsilon<T>()` 退化检测）、`cos`/`sin`（trigonometric.cj stub）。**stub 占位**。
- `log(q: Quat<T,Q>): Quat<T,Q>` — 依赖 `length`（quaternion_geometric）、`epsilon<T>()`（scalar_constants.cj，line 23 用于 `Vec3Len < epsilon<T>()` 退化检测）、`pi<T>()`（scalar_constants.cj，line 28 用于 `wxyz(log(-q.w), pi<T>(), ...)`）、`atan`/`log`（trigonometric.cj/exponential.cj 接口）、`std::numeric_limits<T>::infinity()` 等价物（line 30 用于 w=0 退化分支，仓颉版本建议优先 `FloatingPoint<T>.getInf()` 实例方法，fallback 为 `T(1)/T(0)` 显式构造）。**stub 占位**。
- `pow(x: Quat<T,Q>, y: T): Quat<T,Q>` — 依赖 `epsilon<T>()`/`abs`/`clamp`/`asin`/`acos`/`sin`/`cos`/`sqrt`/`cos_one_over_two<T>()` + 递归调用 `std.math.pow(T, T)`（实数版本降级路径）+ `std::numeric_limits<T>::min()` 等价的仓颉次正规数边界检查。其中 `epsilon<T>()`/`cos_one_over_two<T>()` 来自 scalar_constants.cj（line 52：`if(abs(x.w / magnitude) > cos_one_over_two<T>())`），`abs`/`clamp` 来自 common.cj stub，`asin`（line 68：`Angle = asin(sqrt(VectorMagnitude) / magnitude)`）/`acos`/`sin`/`cos` 来自 trigonometric.cj stub，`sqrt` 来自 std.math，`std.math.pow(T, T)` 来自仓颉标准库（line 65：`return qua<T, Q>::wxyz(pow(x.w, y), 0, 0, 0)` 实数降级路径），`std::numeric_limits<T>::min()` 用于次正规数边界（line 63：`if (VectorMagnitude < (std::numeric_limits<T>::min)())`，仓颉版本通过 `T <: FloatingPoint<T>` 约束 + `FloatingPoint<T>.getMin()` 实例方法或 fallback 路径实现）。**命名消歧（v5 新增）**：四元数 `pow` 函数体内部调用的 `pow(x.w, y)` 是**实数版本** `std.math.pow(T, T): T`，与四元数 `pow` 本身（`pow(Quat, T): Quat`）通过参数类型消歧（第一参数类型 `T` 与 `Quat<T,Q>` 区分）；若 `std.math.pow` 在某类型 T 上不可用，需以 `exp(y * log(x.w))` 替代实现（仍调用实数 `log`/`exp`）。**Float64 转换依赖（v7 澄清）**：由于仓颉 std.math 的 `pow`/`log`/`exp` 函数签名仅支持 Float64 输入/输出（`cangjie-std/math/README.md` 第 13 行），`pow(Quat<Float32, Q>, Float32)` 实现路径需先显式将 `x.w`/`y` 转换至 Float64 再调用 `std.math.pow`，fallback 路径 `exp(y * log(x.w))` 同步需 Float64 转换。**stub 占位**。
- `sqrt(x: Quat<T,Q>): Quat<T,Q>` — 委托 `pow(x, T(0.5))`。**stub 占位**。

**v5 修订**：4 个函数均依赖 trigonometric.cj/common.cj stub，本阶段全部 **stub 占位**。`pow` 的依赖关系以 GLM `ext/quaternion_exponential.inl:41-80` 实际实现为准（v3 引用 `24-43` 行号错误，已纠正）。`exp`/`log`/`pow` 函数分别补充 `epsilon<T>()`、`pi<T>()` 等 scalar_constants.cj 依赖。`pow` 补充 `cos_one_over_two<T>()`/`asin`/`std.math.pow`/`std::numeric_limits<T>::min()` 等价物依赖。

### 3.11 ext/quaternion_common.cj

**角色**：提供四元数公共函数（mix、lerp、slerp、conjugate、inverse、isnan、isinf）。

**依赖分析**：
- `dot` — 委托 quaternion_geometric.cj，完整可用
- `conjugate(q: Quat<T,Q>): Quat<T,Q>` — **完整实现**。仅对 x/y/z 三个分量取反，w 分量保持不变：`Quat(-q.x, -q.y, -q.z, q.w)`（与 GLM `ext/quaternion_common.inl:112-116` `wxyz(q.w, -q.x, -q.y, -q.z)` 一致；**v5 修订**：v3 描述「仅涉及逐分量取反」语义不准确，逐分量取反对应 `negative` 运算符 `-q`，而 `conjugate` 仅对 x/y/z 取反、保留 w）。等价实现可基于主构造函数或 wxyz 工厂函数。
- `inverse(q: Quat<T,Q>): Quat<T,Q>` — `conjugate(q) / dot(q, q)`。**完整实现**（依赖 dot 和 除法运算符）。**边界行为（v3 新增契约）**：
  - 浮点四元数 `dot(q,q) == T(0)` 时除以零产生 Inf/NaN 分量（与 GLM 行为一致，GLM 不做零除保护）
  - 整数四元数 `dot(q,q) == T(0)` 时触发仓颉整数除零异常（与浮点 Inf/NaN 行为不同）
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

**gtc/constants.cj**：
- 提供 25 个常量函数（zero/one/two_pi/tau/root_pi/half_pi/three_over_two_pi/quarter_pi/one_over_pi/one_over_two_pi/two_over_pi/four_over_pi/two_over_root_pi/one_over_root_two/root_half_pi/root_two_pi/root_ln_four/e/euler/root_two/root_three/root_five/ln_two/ln_ten/ln_ln_two/third/two_thirds/golden_ratio）
- 全部为泛型函数 `func zero<T>(): T` 等，内部使用具体类型硬编码值直接返回（与 GLM `genType(3.14159...)` 实现方式一致，避免函数间调用依赖）
- 依赖 `ext/scalar_constants.cj`（间接通过 detail/scalar_constants.cj）
- 可**完整实现**

### 3.13 新增空桩文件

本阶段新增以下空桩文件以满足 gtc/matrix_transform.cj 的传递依赖闭合：

| 文件 | 包 | 内容 |
|------|---|------|
| `trigonometric.cj` | glm.detail | `sin`/`cos`/`tan`/`asin`/`acos`/`atan`/`atan2`/`sinh`/`cosh`/`tanh`/`asinh`/`acosh`/`atanh`/`radians`/`degrees` 的签名空壳 |
| `ext/matrix_projection.cj` | glm.ext | `perspective`/`ortho` 等投影矩阵函数空壳 |
| `ext/matrix_clip_space.cj` | glm.ext | 裁剪空间矩阵函数空壳 |
| `ext/matrix_transform.cj` | glm.ext | `translate`/`rotate`/`scale`/`lookAt` 等变换函数空壳 |
| `gtc/matrix_transform.cj` | glm.gtc | 仅函数签名空壳，内部 `throw Exception("stub")` |

**沿用自阶段二的 stub**：`common.cj`、`geometric.cj`、`matrix.cj`（27 实现 + 6 stub）

### 3.14 四元数别名文件

ext/ 下新增四元数别名文件：

| 文件 | 别名内容 |
|------|---------|
| `quaternion_float.cj` | `quat = Quat<Float32, PackedHighp>` |
| `quaternion_double.cj` | `dquat = Quat<Float64, PackedHighp>` |
| `quaternion_float_precision.cj` | `highp_quat`/`mediump_quat`/`lowp_quat` |
| `quaternion_double_precision.cj` | `highp_dquat`/`mediump_dquat`/`lowp_dquat` |

fwd.cj 新增别名（v3 明确，参考阶段二矩阵的 `Mat2x2`/`FMat2x2` 双别名机制）：

| 别名 | 类型 | 备注 |
|------|------|------|
| `Quat` | `Quat<Float32, PackedHighp>` | Float32 主别名 |
| `FQuat` | `Quat<Float32, PackedHighp>` | Float32 别名（与 `Quat` 等价，遵循阶段二 `Mat2x2`/`FMat2x2` 双别名模式） |
| `DQuat` | `Quat<Float64, PackedHighp>` | Float64 主别名 |
| `HighpQuat`/`MediumpQuat`/`LowpQuat` | `Quat<Float32, *>` | Float32 精度变体（3 个） |
| `HighpDQuat`/`MediumpDQuat`/`LowpDQuat` | `Quat<Float64, *>` | Float64 精度变体（3 个） |

**合计 8 个别名**（Quat/FQuat/DQuat/3×Float32 精度/3×Float64 精度，与 v2 一致）。**排除项**（与阶段二策略对齐）：
- 不含 `BQuat`（Bool 四元数）—— 阶段一 Vec 包含 `BVec` 但 Bool 四元数无实际用途（D17 决策：Bool 四元数不支持算术运算）
- 不含 `IQuat`/`I64Quat`（整型四元数）—— 与阶段二 `fwd.cj` 排除整型矩阵别名策略一致
- 不含 `BQuat` 的精度变体（同上）

**为何保留 `Quat` 与 `FQuat` 双别名（v3 新增说明）**：阶段二矩阵采用了 `Mat2x2 = Mat2x2<Float32, PackedHighp>` 和 `FMat2x2 = Mat2x2<Float32, PackedHighp>` 双别名机制。`Mat2x2` 是沿用 GLM 的主别名，`FMat2x2` 是显式标注浮点类型的辅助别名。阶段三沿用此模式：`Quat` 为主别名（与 GLM 命名一致），`FQuat` 为显式浮点别名（与阶段二 `FMat2x2` 等价机制对齐）。

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
- `lessThan(x, y): Vec4<Bool,Q>` — 逐分量 `<` 比较
- `lessThanEqual(x, y): Vec4<Bool,Q>` — 逐分量 `<=` 比较
- `greaterThan(x, y): Vec4<Bool,Q>` — 逐分量 `>` 比较
- `greaterThanEqual(x, y): Vec4<Bool,Q>` — 逐分量 `>=` 比较

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
| `1 - x.w*x.w <= 0` | `axis(q)` | 返回 `Vec3(T(0), T(0), T(1))`（z 轴单位向量，典型场景：单位四元数 `(0, 0, 0, 1)` 即 `\|w\| >= 1`；与 GLM `ext/quaternion_trigonometric.inl:20-27` 一致；**v5 修订**：v3 描述「零四元数返回 `Vec3(1, 0, 0)`」错误，触发条件为 `1 - w² <= 0` 而非 `q.xyz == 0`） |
| 真正零四元数 `(0,0,0,0)` | `axis(q)` | `tmp1 = 1 > 0` 进入 else 分支，返回 `Vec3(T(0), T(0), T(0))`（**v5 修订**：v3 描述「内部 `normalize(Vec3(0,0,0))` 返回 `Vec3(1,0,0)`」为虚构实现，GLM 实际不调用 `normalize`） |
| 零四元数（浮点） | `inverse(q)` | 浮点除零产生 Inf/NaN 分量（与 GLM 一致，GLM 不做零除保护） |
| 零四元数（整数） | `inverse(q)` | 触发仓颉整数除零异常（与浮点 Inf/NaN 行为不同） |
| `cosTheta` 退化 | `mix`/`slerp` | 依赖 `cosTheta > 1 - epsilon<T>()` 边界检查；stub 函数抛 stub 异常 |
| 非纯旋转矩阵 | `fromMat3`/`fromMat4` | 仅对纯旋转矩阵产生有意义的四元数；对非旋转矩阵（缩放/平移/剪切）行为未定义，结果可能产生非单位四元数或语义错误的旋转 |
| `a` 超出 [0,1] | `lerp` | 触发 `assert(a >= 0 && a <= 1)` 断言失败 |
| `epsilon = T(0)` | `equal(v, v, 0)` | 返回 `false`（严格小于语义，与 GLM `func_vector_relational.inl:18-22` 一致） |
| 整型 T | `epsilon<T>()`/`pi<T>()`/`cos_one_over_two<T>()` | 触发 `Exception("not defined for non-floating-point types")`（约束收紧失败时 fallback 分支） |
| 整型 T | `isnan(q)`/`isinf(q)` | 编译期约束收紧为 `where T <: FloatingPoint<T>`，整型 T 实例化时编译失败（v4 新增，v7 接口名修订）；若仓颉泛型不支持窄约束则运行时 fallback 抛 `Exception("isnan/isinf not defined for non-floating-point types")` |
| 整型 T | `mat3Cast`/`mat4Cast`/`quatCast` | 编译期约束收紧为 `where T <: FloatingPoint<T>`，整型 T 实例化时编译失败（v5 新增，v7 接口名修订；与 D29 `isnan`/`isinf` 策略一致，对应 GLM `GLM_STATIC_ASSERT(is_iec559, ...)`） |

### 5.4 const 上下文约束

- **`lerp`/`conjugate`/`inverse` 不可在 const 上下文调用**：函数体内 `assert` 或 `throw` 不是 const 函数（与 deviations.md IF-03 一致），与 `componentAt` 等运行时函数行为一致
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
| D10 | gtc/constants 中 25 个常量函数使用具体类型硬编码值直接返回 | 与 GLM `genType(3.14159...)` 实现方式一致，避免函数间调用依赖 |
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
| D21 | **`mix`/`slerp`/`pow` 的依赖明确包含 `epsilon<T>()`（v3 新增）；`pow` 进一步包含 `cos_one_over_two<T>()`、`asin`、递归 `std.math.pow(T,T)` 与 `std::numeric_limits<T>::min()` 等价物（v5 强化，v7 接口名修订）** | 与 GLM `quaternion_common.inl`/`quaternion_exponential.inl:41-80` 实际依赖一致：`mix`/`slerp` 依赖 `cosTheta > 1 - epsilon<T>()` 退化检测分支；`pow` 在 line 52 使用 `cos_one_over_two<T>()`，line 63 使用 `std::numeric_limits<T>::min()` 进行次正规数边界检查，line 65 递归调用 `std::pow(T, T)` 实数降级路径，line 68 使用 `asin`。仓颉版本需明确：(1) `pow` 函数体内部调用的是 `std.math.pow(T, T): T` 实数版本，与四元数 `pow` 通过参数类型消歧；(2) 若 `std.math.pow` 不存在，需以 `exp(y * log(x.w))` 替代；(3) `std::numeric_limits<T>::min()` 通过 `FloatingPoint<T>` 约束 + `getMin()` 实例方法或 fallback 实现 |
| D22 | **`slerp` 4 参数版本 `k: Int64` 简化签名（v3 新增）** | 与 deviations.md DV-03「移位运算右操作数固定为 Int64」风格一致；阶段三 slerp 为 stub，固定 `Int64` 简化签名不影响本阶段实施 |
| D23 | **`lerp` 实现含 `assert(a >= 0 && a <= 1)` 断言（v3 新增）** | 与 GLM `ext/quaternion_common.inl:28-38` 一致，确保插值因子在 [0, 1] 范围内 |
| D24 | **向量 `equal` epsilon 比较采用严格 `<` 语义（v3 新增）** | 与 GLM `func_vector_relational.inl:18-22` 一致，避免边界用例下 `equal(v, v, 0) = true` 的语义偏差 |
| D25 | **`scalar_constants` 对整数类型 T 触发运行时异常（v3 新增）** | 与 GLM `static_assert(is_iec559, ...)` 编译期断言等价行为（仓颉泛型若不支持窄约束则用运行时异常） |
| D26 | **`Quat×Vec3` 旋转公式采用两次 Vec3 叉乘（v3 新增）** | 与 GLM `type_quat.inl:359-366` 实际实现一致：`v + (cross(QuatVector, v) * q.w + cross(QuatVector, cross(QuatVector, v))) * 2`（uv 和 uuv 两次叉乘） |
| D27 | **fwd.cj 排除整型与 Bool 四元数别名（v3 明确）** | 与阶段二 fwd.cj 排除整型矩阵别名策略一致；Bool 四元数无实际用途（D17） |
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
- `gtc/constants.cj`（25 个数学常量函数）
- **`gtc/quaternion.cj`（v3 修订：4 函数重导出 + 4 函数完整 + 7 函数 stub）**
- 四元数别名文件（4 个 ext/ 文件）
- 四元数测试文件（详见 §8.2）

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
| `tests/glm/detail/type_quat_test.cj` | Quat 核心类型 + 运算符 | ≥40 |
| `tests/glm/detail/type_quat_cast_test.cj` | 矩阵-四元数互转函数（v3 新增） | ≥8 |
| `tests/glm/ext/vector_relational_test.cj` | 向量 epsilon/ULP 比较 | ≥16 |
| `tests/glm/ext/quaternion_relational_test.cj` | 四元数关系运算 | ≥8 |
| `tests/glm/ext/quaternion_geometric_test.cj` | 四元数几何函数 | ≥12 |
| `tests/glm/ext/quaternion_common_test.cj` | 四元数公共函数 | ≥16 |
| `tests/glm/ext/quaternion_trigonometric_test.cj` | 四元数三角函数 | ≥8 |
| `tests/glm/ext/quaternion_exponential_test.cj` | 四元数指数函数（stub） | ≥4 |
| `tests/glm/ext/quaternion_transform_test.cj` | 四元数变换函数（stub） | ≥2 |
| `tests/glm/ext/scalar_constants_test.cj` | 标量常量 | ≥6 |
| `tests/glm/ext/quaternion_float_test.cj` | 四元数别名 | ≥4 |
| `tests/glm/gtc/constants_test.cj` | 数学常量 | ≥25 |
| `tests/glm/gtc/quaternion_test.cj` | gtc 四元数转换重导出/比较/欧拉/看向 | ≥20 |
| **合计** | — | **≥171** |

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
13. **`isnan`/`isinf` 函数约束收紧验证（v4 新增，v7 接口名修订）**：验证 `where T <: FloatingPoint<T>` 约束（stdlib 原生接口）在仓颉编译器的支持情况；实例化 `Quat<Float32, PackedHighp>` 调用 `isnan`/`isinf` 通过编译；实例化 `Quat<Int64, PackedHighp>` 调用 `isnan`/`isinf` 报类型不匹配错误。`FloatingPoint<T>` 是 stdlib 原生接口，无「不可用」风险，本验证项无需 fallback 验证；如需进一步确认，可验证 `FloatingPoint<T>` 接口的 `getMin()`/`getInf()` 实例方法可用性（对应 std::numeric_limits<T>::min()/infinity()），若不存在则使用硬编码值或 `T(1)/T(0)` 显式构造作为 fallback
14. **Quat 字段 `public var` 可见性验证（v4 新增）**：确认 `@Derive[Hashable]` 派生宏在 Quat 字段标注 `public var` 时编译通过；若字段标注缺失 `public`，验证派生失败报可见性错误
15. **`pow` 函数四元数版本与 `std.math.pow` 实数版本命名消歧验证（v5 新增，v7 Float64 转换依赖补充）**：验证 `pow(x: Quat<T,Q>, y: T)` 函数体内部调用 `std.math.pow(x.w, y)` 实数版本时，类型推断正确（参数类型为 `T`/`T`），不与四元数 `pow` 自身签名混淆；确认 `std.math.pow` 对 `Float32`/`Float64` 的可用性，若不存在则需以 `exp(y * log(x.w))` 替代实现（v7 补充：因 std.math 的 pow/log/exp 签名仅支持 Float64，`pow(Quat<Float32, Q>, Float32)` 路径需先显式转换至 Float64 再降级，fallback `exp(y * log(x.w))` 同步需 Float64 转换）
16. **`pow` 函数次正规数边界检查所需 `FloatingPoint<T>.getMin()` 方法验证（v5 新增，v7 接口名修订）**：验证仓颉 `FloatingPoint<T>` 接口是否提供 `getMin()` 实例方法（对应 `std::numeric_limits<T>::min()`）；若不提供，需采用 fallback 路径（如硬编码类型最小正值或调用 `epsilon<T>()` 的倒数）
17. **`type_quat_cast` 函数 `FloatingPoint<T>` 约束可用性验证（v5 新增，v7 接口名修订）**：验证 `where T <: FloatingPoint<T>` 约束（stdlib 原生接口）在 `mat3Cast`/`mat4Cast`/`quatCast` 4 个函数签名上的编译可行性；实例化 `Quat<Float32, PackedHighp>` 调用转换函数通过编译；实例化 `Quat<Int64, PackedHighp>` 调用转换函数报类型不匹配错误（与 GLM `GLM_STATIC_ASSERT(is_iec559, ...)` 等价行为）
18. **`log` 函数 `std::numeric_limits<T>::infinity()` 等价物验证（v5 新增，v7 接口名修订）**：验证仓颉 `FloatingPoint<T>` 接口是否提供 `getInf()` 实例方法（对应 `std::numeric_limits<T>::infinity()`）；若不提供，则采用 `T(1)/T(0)` 显式构造作为 fallback（仅对浮点类型有效，整数类型 `1/0` 触发除零异常，与 GLM 行为一致）

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
| **向量 `equal` 采用严格 `<` 语义（v3 修订）** | 与 GLM `func_vector_relational.inl:18-22` 一致，`equal(v, v, 0.0) = false` |
| **scalar_constants 使用 hint 参数辅助类型推断** | 与 deviations.md DV-04 一致 |
| **scalar_constants 对整型 T 抛运行时异常（v3 明确）** | 与 GLM `static_assert(is_iec559, ...)` 编译期断言等价行为 |
| **`Quat×Vec3` 旋转公式采用两次 Vec3 叉乘（v3 修订）** | 与 GLM `type_quat.inl:359-366` 一致：`v + (cross(QuatVector, v) * q.w + cross(QuatVector, cross(QuatVector, v))) * 2` |
| **`slerp` 4 参数版本 `k: Int64` 简化签名（v3 决策）** | 与 deviations.md DV-03「移位运算右操作数固定为 Int64」风格一致，牺牲泛型灵活性换取签名简洁性 |
| **`lerp` 含 `assert(a >= 0 && a <= 1)` 断言（v3 明确）** | 与 GLM `ext/quaternion_common.inl:28-38` 一致；`lerp` 不可在 const 上下文调用 |
| **四元数算术运算符统一标注 @OverflowWrapping** | 与阶段一 Vec3、阶段二全部矩阵类型的实践一致；标注对浮点无效果但保持跨类型一致性 |
| **fwd.cj 排除整型与 Bool 四元数别名（v3 明确）** | 与阶段二排除整型矩阵别名的策略一致；Bool 四元数无实际用途（D17） |
| **`Quat`/`FQuat` 双别名机制（v3 新增）** | 与阶段二 `Mat2x2`/`FMat2x2` 双别名机制一致 |
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
| 25 个常量函数 | 本阶段实现 |

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
// 仓颉 detail 直接调用（v3 推荐入口）:
//           let m3 = mat3Cast(q)      // detail/type_quat_cast.cj 包级函数
//           let q2 = quatCast(m)      // detail/type_quat_cast.cj 包级函数
// 
// 仓颉 gtc 命名空间调用（v3 通过 public import 重导出，[本阶段可验证]）:
//           let m3_gtc = glm.gtc.quaternion.mat3_cast(q)
//           let q2_gtc = glm.gtc.quaternion.quat_cast(m)
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
| `isnan`/`isinf` | ✅ 可用（仅浮点 T，整型 T 编译失败，v4 约束收紧） | ✅ 可用（仅浮点 T） |
| `slerp` | ❌ stub | ✅ 可用 |
| `mix` | ❌ stub | ✅ 可用 |
| `angle`/`angleAxis` | ❌ stub | ✅ 可用 |
| `exp`/`log`/`pow`/`sqrt` | ❌ stub | ✅ 可用 |
| `eulerAngles`/`roll`/`pitch`/`yaw` | ❌ stub | ✅ 可用 |
| `quatLookAt*` | ❌ stub | ✅ 可用 |
| `epsilon`/`pi`（浮点） | ✅ 可用 | ✅ 可用 |
| `epsilon`/`pi`（整型） | ❌ 抛异常 | ❌ 抛异常（保持契约） |
| `mat3_cast`/`mat4_cast`/`quat_cast`（detail） | ✅ 可用（仅浮点 T，整型 T 编译失败，v5 约束收紧，对应 GLM `GLM_STATIC_ASSERT(is_iec559, ...)`） | ✅ 可用（仅浮点 T） |
| `mat3_cast`/`mat4_cast`/`quat_cast`（gtc，重导出） | ✅ 可用（仅浮点 T，整型 T 编译失败，v5 约束收紧） | ✅ 可用（仅浮点 T） |
| `lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual` | ✅ 可用 | ✅ 可用 |

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
