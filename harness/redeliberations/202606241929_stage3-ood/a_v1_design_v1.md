# GLM 1.0.3 仓颉迁移阶段三 OOD 设计方案

> **修订日期**：2026-06-24

---

## 1. 概述

### 设计目标

在阶段一（Vec1~Vec4 向量类型 + 基础设施）和阶段二（9 个矩阵类型 + ext/ 别名）的基础上，迁移四元数类型及其必需的 ext/gtc 依赖文件，使库具备旋转/插值表达能力。本阶段同时引入向量关系运算扩展、标量常量扩展、gtc/constants 数学常量定义，并为 gtc/matrix_transform 提供空桩占位以满足依赖闭合。

### 核心抽象

| 抽象 | 角色 | 类型形态 |
|------|------|---------|
| Quat<T,Q> | 表示数学四元数的值对象 | 泛型结构体 |
| ext/vector_relational.cj | 向量关系运算扩展函数库（epsilon/ULP 比较） | 完整实现 |
| ext/quaternion_relational.cj | 四元数关系运算扩展函数库 | 完整实现 |
| ext/quaternion_transform.cj | 四元数变换函数库 | 大部分实现（lookRotate 依赖 geometric.cj stub） |
| ext/quaternion_common.cj | 四元数公共函数库（slerp/lerp/conjugate/inverse） | 大部分实现（mix/slerp 依赖 common.cj stub） |
| ext/scalar_constants.cj | 标量数学常量（epsilon/pi/cos_one_over_two） | 完整实现 |
| gtc/constants.cj | 数学常量定义（zero/one/pi/half_pi 等 25 个常量） | 完整实现 |
| gtc/matrix_transform.cj | 矩阵变换函数库 | 空桩占位 |
| common.cj（沿用阶段二 stub） | 基础数学函数库占位 | 沿用 stub |
| matrix.cj（沿用阶段二） | 矩阵运算函数库 | 沿用（27 实现 + 6 stub） |
| geometric.cj（沿用阶段二 stub） | 几何函数库占位 | 沿用 stub |
| trigonometric.cj（新增空桩） | 三角函数库占位 | 新增空桩 |
| ext/matrix_projection.cj（新增空桩） | 矩阵投影函数库占位 | 新增空桩 |
| ext/matrix_clip_space.cj（新增空桩） | 裁剪空间矩阵函数库占位 | 新增空桩 |
| ext/matrix_transform.cj（新增空桩） | 矩阵变换扩展函数库占位 | 新增空桩 |

### 整体架构思路

沿用阶段一/阶段二的双层包结构 + ext 子包 + gtc 子包：glm.detail 包含四元数泛型结构体定义和运算符重载，glm 包通过类型别名暴露常用具现化，glm.ext 包含四元数/向量关系运算等扩展函数库和别名文件，glm.gtc 包含数学常量和矩阵变换占位。四元数类型以 Vec3+标量(w) 为内部数据布局，与 GLM 的 xyzw 布局一致（非 wxyz 布局），通过 `const init` 构造函数支持编译期求值。

### 系统性设计约束：泛型上下文中 T(0)/T(1) 的获取问题

本设计与阶段二面临相同的根因限制：**仓颉无约束泛型参数不支持 `T(0)/T(1)` 构造调用，且 `Number<T>` 接口也不提供 `T(n)` 构造声明**。统一策略沿用阶段二的方案：
- **T(0) 的获取**：在 `Number<T>` 约束的 extend 块中，通过 `someValue - someValue` 演算
- **T(1) 的获取**：必须由调用方显式传入参数（`one: T`），因为在 `Number<T>` 约束上下文中不存在通用的演算路径
- **T(0) 和 T(1) 均需的场景**：T(0) 通过运算演算，T(1) 通过参数传入

---

## 2. 模块划分

### 包组织

```
package glm.detail          — 核心实现层（新增/修改文件以 ★ 标记）
  ├── type_quat.cj ★        — Quat<T,Q> 结构体定义 + extend 块中的运算符
  │                          (含 Quat×Vec3/Vec4 成员运算符、Vec3×Quat/Vec4×Quat extend 块成员运算符)
  ├── common.cj（沿用 stub，阶段二已有）
  ├── matrix.cj（沿用混合型，阶段二已有）
  ├── geometric.cj（沿用 stub，阶段二已有）
  ├── scalar_constants.cj ★ — 标量常量定义（移入 detail，epsilon/pi/cos_one_over_two）
  ├── trigonometric.cj ★    — 新增空桩（sin/cos/tan/asin/acos/atan 等签名空壳）
  ├── scalar_quat_ops.cj ★  — 标量-四元数运算全局具名函数（add/sub/mul/div，处理 T + Quat 等标量左侧运算）

package glm                 — 公共 API 面 + 别名层（修改文件以 ★ 标记）
  ├── lib.cj ★              — 新增四元数类型、ext 函数、gtc 常量的 public import
  └── fwd.cj ★              — 新增四元数类型别名

package glm.ext             — 扩展函数库（新增文件以 ★ 标记）
  ├── vector_relational.cj ★      — 向量 epsilon/ULP 关系运算函数（完整实现）
  ├── quaternion_relational.cj ★  — 四元数关系运算函数（完整实现）
  ├── quaternion_transform.cj ★   — 四元数变换函数（大部分实现，lookRotate 等 stub）
  ├── quaternion_common.cj ★      — 四元数公共函数（大部分实现，mix 依赖 common.cj stub）
  ├── quaternion_geometric.cj ★   — 四元数几何函数（完整实现：dot/length/normalize/cross）
  ├── quaternion_trigonometric.cj ★ — 四元数三角函数（完整实现：angle/axis/angleAxis）
  ├── quaternion_exponential.cj ★   — 四元数指数函数（大部分实现，exp/log/pow/sqrt 依赖 geometric.cj stub）
  ├── scalar_constants.cj ★        — 向上导出接口（import glm.detail.scalar_constants 并 public import 重导出）
  ├── matrix_projection.cj ★       — 新增空桩
  ├── matrix_clip_space.cj ★       — 新增空桩
  ├── matrix_transform.cj ★        — 新增空桩
  ├── quaternion_float.cj ★         — Float32 四元数别名
  ├── quaternion_double.cj ★        — Float64 四元数别名
  ├── quaternion_float_precision.cj ★ — Float32 精度变体别名
  ├── quaternion_double_precision.cj ★ — Float64 精度变体别名

package glm.gtc             — GTC 扩展函数库（新增目录和文件以 ★ 标记）
  ├── constants.cj ★        — 数学常量定义（完整实现，25 个常量函数）
  ├── matrix_transform.cj ★ — 空桩占位（仅函数签名空壳）
```

### 模块间依赖

```
glm.detail（同包直接可见）
  type_quat.cj → type_vec3, type_vec4, type_mat3x3, type_mat4x4
  type_quat.cj .inl 编排 → ext/quaternion_common, ext/quaternion_geometric
  type_quat.cj .inl 编排 → gtc/constants（transitively via scalar_constants）
  type_quat.cj .inl 编排 → ext/vector_relational
  type_quat.cj .inl 编排 → common.cj(stub), trigonometric.cj(stub), geometric.cj(stub)
  scalar_quat_ops.cj → type_quat
  scalar_constants.cj → setup.cj（仅依赖 GLM_CONFIG_* 常量）

glm.ext
  vector_relational.cj → glm.detail（qualifier, Vec1~Vec4, common.cj stub）
  quaternion_relational.cj → glm.detail（Quat, Vec4）, ext/vector_relational
  quaternion_geometric.cj → glm.detail（Quat, geometric.cj stub, exponential.cj[不存在，需 stub 引用处理]）
  quaternion_transform.cj → glm.detail（Quat, Vec3, common.cj stub, trigonometric.cj stub, geometric.cj stub）
  quaternion_common.cj → glm.detail（Quat, Vec4, common.cj stub, trigonometric.cj stub, exponential.cj[不存在]）
  quaternion_trigonometric.cj → glm.detail（Quat, Vec3, ext/scalar_constants）
  quaternion_exponential.cj → glm.detail（Quat, ext/scalar_constants, geometric.cj stub）
  scalar_constants.cj → glm.detail.scalar_constants（重导出）
  matrix_projection.cj → stub（空桩）
  matrix_clip_space.cj → stub（空桩）
  matrix_transform.cj → stub（空桩）
  quaternion_float.cj → glm.detail（Quat 别名）
  quaternion_double.cj → glm.detail（Quat 别名）
  quaternion_float_precision.cj → glm.detail（Quat 别名）
  quaternion_double_precision.cj → glm.detail（Quat 别名）

glm.gtc
  constants.cj → glm.ext.scalar_constants
  matrix_transform.cj → stub 引用 ext/matrix_projection, ext/matrix_clip_space, ext/matrix_transform,
                         glm.detail.geometric(stub), glm.detail.trigonometric(stub), glm.detail.matrix(stub)

glm
  fwd.cj → glm.detail（Quat 别名）
  lib.cj → glm.detail（Quat, scalar_constants 函数）, glm.ext, glm.gtc
```

### ext/ 新文件与 gtc/ 子包的包名策略

沿用阶段二已验证的策略：
- `src/ext/` 下文件声明 `package glm.ext`
- `src/gtc/` 下文件声明 `package glm.gtc`（需原型验证 cjpm 子包发现机制对 gtc/ 子目录的支持；若不支持，按阶段二备选方案降级至 `package glm` 并在 src/ 根目录存放）

### cjpm 子包构建预验证（gtc 新增）

需验证 `src/gtc/` + `package glm.gtc` 的构建可行性。原型验证计划同阶段二 ext/ 子包验证步骤。

---

## 3. 核心抽象

### 3.1 四元数结构体 Quat<T,Q>

**角色**：表示数学四元数的值对象，用于旋转表达和插值运算。

**职责**：
- 承载 4 个分量数据成员（`var x: T, var y: T, var z: T, var w: T`），布局与 GLM 默认 xyzw 一致（非 wxyz）
- 提供编译期查询函数 `public static func length(): Int64` 返回常量 4
- 提供下标运算符 `[](i: Int64)` 访问分量（取值 + 赋值双版本）
- 提供多种构造方式（逐分量构造、标量+向量构造、跨类型构造）
- 通过 `@Derive[Hashable]` 自动派生哈希支持

**为何采用 struct（值类型）**：与阶段一 Vec 和阶段二 Mat 一致——四元数是数学计算中的值对象，值语义确保运算符返回新实例、无副作用。

**数据布局选择**：GLM 默认（`GLM_FORCE_QUAT_DATA_XYZW` 未定义时）为 `x, y, z, w` 布局。本设计采用此默认布局，`w` 分量位于第四位置。C++ GLM 的 `qua(T w, T x, T y, T z)` 构造函数参数顺序为 w 在前，但内部存储为 xyzw 后缀。仓颉版本中数据成员声明为 `var x, var y, var z, var w`，与 GLM 存储布局对应。构造函数参数顺序需与数据布局明确区分——见 §3.3。

**为何不像 C++ GLM 使用匿名 union**：仓颉不支持匿名联合体和 `reinterpret_cast`，无法实现 GLM 中 `union { struct { T x, y, z, w }; storage<4,T> data; }` 的布局技巧。四元数直接声明具名数据成员，与阶段一/二 Vec/Mat 的策略一致。

### 3.2 四元数与向量/矩阵的协作关系

四元数与向量、矩阵之间存在以下协作模式：

| 协作模式 | 描述 | 实现位置 |
|---------|------|---------|
| Quat×Vec3 | 四元数旋转向量 | Quat extend 块成员运算符 |
| Vec3×Quat | 向量被四元数逆旋转 | Vec3 extend 块成员运算符 |
| Quat×Vec4 | 四元数旋转向量（保留 w 分量） | Quat extend 块成员运算符 |
| Vec4×Quat | 向量被四元数逆旋转（保留 w 分量） | Vec4 extend 块成员运算符 |
| Mat3←Quat mat3_cast | 四元数转 3×3 旋转矩阵 | gtc/quaternion.cj（阶段四或本阶段视 lookRotate 范围） |
| Mat4←Quat mat4_cast | 四元数转 4×4 旋转矩阵 | gtc/quaternion.cj |
| Quat←Mat3 quat_cast | 旋转矩阵转四元数 | gtc/quaternion.cj |
| Quat←Mat4 quat_cast | 4×4 旋转矩阵转四元数 | gtc/quaternion.cj |

**关键设计决策**：`mat3_cast`、`mat4_cast`、`quat_cast` 和 `eulerAngles`/`roll`/`pitch`/`yaw`/`lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual`/`quatLookAt`/`quatLookAtRH`/`quatLookAtLH` 这些函数在 GLM 中定义于 `gtc/quaternion.hpp`（非 `ext/quaternion_*.hpp`）。但 `type_quat.inl` 中的构造函数 `qua(mat3x3)` 和 `qua(mat4x4)` 内部调用 `quat_cast`，而 `qua(Vec3, Vec3)`（从两个向量构造四元数）内部调用 `cross`、`dot`、`normalize` 等 geometric.cj 函数。这构成了 type_quat.inl 的完整依赖链。

**本阶段对 gtc/quaternion 函数的处理策略**：`gtc/quaternion.hpp` 中包含约 17 个函数。其中 `mat3_cast`/`mat4_cast`/`quat_cast` 被 type_quat.inl 构造函数直接依赖，`lookRotate`/`quatLookAt*` 被 `ext/quaternion_transform.cj` 函数依赖。本阶段采取以下分批策略：
- **随 type_quat.cj 一同实现**：`mat3_cast`/`mat4_cast`/`quat_cast`（type_quat.inl 构造函数依赖）
- **随 ext/quaternion_transform.cj 实现**：`angleAxis`/`rotate`（不依赖 geometric.cj 的函数）
- **stub 占位**：`lookRotate`/`quatLookAt`/`quatLookAtRH`/`quatLookAtLH`（依赖 geometric.cj 的 cross/dot/normalize）
- **随 gtc/quaternion.cj 实现**：`eulerAngles`/`roll`/`pitch`/`yaw`/`lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual`（不依赖 geometric.cj——roll/pitch/yaw 依赖 common.cj 和 trigonometric.cj 均为 stub，需从 ext/vector_relational 引用 equal 函数）

### 3.3 构造函数体系

每个 Quat<T,Q> 提供以下构造函数和工厂函数：

1. **逐分量构造 const init(x: T, y: T, z: T, w: T)** — 纯赋值，参数顺序为 x, y, z, w（与数据成员声明顺序一致）。此为仓颉侧的**主构造函数**。调用方需注意：GLM 的 `qua(T w, T x, T y, T z)` 参数顺序为 w 在前，而仓颉版本参数顺序为 x, y, z, w（w 在后）。这是一个**接口形态偏差**（参见 §9）。

2. **标量+向量构造 const init(s: T, v: Vec3<T,Q>)** — 将标量 s 作为 w 分量，向量 v 的 xyz 作为 xyz 分量。对应 GLM 的 `qua(T s, vec3 const& v)` 构造函数。

3. **跨 Qualifier 构造 init<Q2>(q: Quat<T,Q2>) where Q2 <: Qualifier** — 跨 Qualifier 同类型构造，纯赋值。

4. **跨类型构造 fromQuat<U, P>(conv: (U) -> T, q: Quat<U,P>) where P <: Qualifier** — extend 块工厂函数，非 const。通过 conv 闭包将 U 类型分量转换为 T 类型。对应 GLM 的 `qua<U,P>(qua<U,P> const& q)` 显式转换构造函数。

5. **单位四元数工厂函数 identity(one: T)** — extend 块工厂函数，`Number<T>` 约束。返回 `Quat<T,Q>`，其中 w=one, x=T(0), y=T(0), z=T(0)。T(0) 通过 `one - one` 演算获取。此为从零构造单位四元数的限定入口，与阶段二矩阵 `identity(one)` 模式一致。

6. **从旋转矩阵构造 fromMat3(m: Mat3x3<T,Q>)** — 辅助工厂函数，内部调用 `quatCast(m)`（即 GLM 的 `quat_cast`）。非 const。

7. **从旋转矩阵构造 fromMat4(m: Mat4x4<T,Q>)** — 辅助工厂函数，内部调用 `quatCast(Mat3x3<T,Q>.fromMat(m, one: one))`。非 const。

8. **从两向量构造 fromVec3(u: Vec3<T,Q>, v: Vec3<T,Q>)** — 辅助工厂函数，内部实现从两个归一化轴构建四元数。依赖 geometric.cj 的 `dot`/`cross`/`normalize`（均为 stub），因此本阶段为 **stub 占位**，完整实现推迟至阶段四。

9. **从欧拉角构造 fromEuler(eulerAngles: Vec3<T,Q>)** — 辅助工厂函数，依赖 trigonometric.cj 的 `cos`/`sin`（均为 stub），因此本阶段为 **stub 占位**，完整实现推迟至阶段四。

10. **wxyz 工厂函数 wxyz(w: T, x: T, y: T, z: T)** — 静态工厂函数，参数顺序为 w, x, y, z（与 GLM `qua::wxyz(w,x,y,z)` 一致），内部返回 `Quat<T,Q>(x, y, z, w)`。提供与 GLM wxyz 习惯一致的调用入口。

### 3.4 运算符体系

所有算术运算符定义在 `Number<T>` 约束的 extend 块中（与阶段一/二一致）。Bool 四元数不支持算术运算。

**成员运算符**（定义在 Quat extend 块中）：

| 运算符 | 语义 | 约束 | 备注 |
|-------|------|------|------|
| 一元 `-` | 逐分量取反 | `Number<T>` | |
| 二元 `+` | 四元数加法 | `Number<T>` | |
| 二元 `-` | 四元数减法 | `Number<T>` | |
| 二元 `*` | 四元数乘法（Hamilton 乘积） | `Number<T>` | |
| 二元 `*` (Quat×Vec3) | 四元数旋转向量 | `Number<T>` | 实现：`v + 2.0 * cross(cross(QuatVector, v) + QuatVector * q.w, v)` |
| 二元 `*` (Quat×Vec4) | 四元数旋转向量（保留 w） | `Number<T>` | 实现：`Vec4(q * Vec3(v), v.w)` |
| 二元 `*` (Quat×T) | 四元数×标量 | `Number<T>` | |
| 二元 `/` (Quat/T) | 四元数/标量 | `Number<T>` | |
| `==` | 精确比较（返回 bool） | `Equatable<T>` | |
| `!=` | 不等比较 | `Equatable<T>` | |

**Vec extend 块成员运算符**（定义在 Vec3/Vec4 extend 块中）：

| 运算符 | 语义 | 约束 |
|-------|------|------|
| Vec3×Quat | `inverse(q) * v` | `Number<T>` |
| Vec4×Quat | `inverse(q) * v`（保留 w） | `Number<T>` |

**全局具名函数**（scalar_quat_ops.cj，处理标量左侧运算）：

| 函数 | 语义 | 约束 |
|------|------|------|
| `add<T, Q>(s: T, q: Quat<T, Q>)` | 标量加四元数 | `Number<T>` |
| `sub<T, Q>(s: T, q: Quat<T, Q>)` | 标量减四元数 | `Number<T>` |
| `mul<T, Q>(s: T, q: Quat<T, Q>)` | 标量乘四元数 | `Number<T>` |
| `div<T, Q>(s: T, q: Quat<T, Q>)` | 标量除四元数 | `Number<T>` |
| `mul<T, Q>(s: T, q: Quat<T, Q>)` | 标量×四元数（交换律别名） | `Number<T>` |

**一元 + 运算符**：仓颉不支持重载一元 `+` 运算符（与 deviations.md IF-01 一致），`+q` 不可编译，直接使用 `q` 即可。

**复合赋值运算符**：`+=`/`-=`/`*=`（四元数乘法）/`*=`（标量乘法）/`/=` 由编译器自动生成（仓颉语言规范保证，与阶段二一致）。

### 3.5 ext/vector_relational.cj

**角色**：提供向量 epsilon 容差比较和 ULP 比较扩展函数。

**职责**：定义 8 个函数（4 个 epsilon 版本 + 4 个 ULP 版本），每个函数按 Vec1~Vec4 分量数提供泛型重载：

**epsilon 版本**：
- `equal(x: VecN<T,Q>, y: VecN<T,Q>, epsilon: T): VecN<Bool,Q>` — 逐分量 |x-y| <= epsilon
- `equal(x: VecN<T,Q>, y: VecN<T,Q>, epsilon: VecN<T,Q>): VecN<Bool,Q>` — 逐分量容差向量版本
- `notEqual(x: VecN<T,Q>, y: VecN<T,Q>, epsilon: T): VecN<Bool,Q>` — 逐分量 |x-y| >= epsilon
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

**依赖 common.cj stub 的递归问题**：`vector_relational.cj` 的 `equal`/`notEqual` epsilon 版本内部调用 `abs(x - y)` 和 `lessThanEqual(abs(x - y), epsilon)`，其中 `abs` 来自 common.cj（当前为 stub）。这意味着 vector_relational 本身在阶段三中也需要部分 stub 或采用内联实现。

**解决策略**：在 vector_relational.cj 中的 epsilon 比较函数内部，将 `abs` 内联展开为 `let d = x - y; VecN(if (d.x >= T(0)) { d.x } else { -d.x }, ...)` 模式，避免依赖 common.cj 的 `abs` stub。这要求 `Number<T>` 约束下有 `Comparable<T>` 以支持 `>=` 比较。此内联方式与阶段一 `ComputeEqualNumeric` 中使用 `std.math.abs` 的策略一致——此处优先内联以消除对 common.cj stub 的运行时依赖风险。

### 3.6 ext/quaternion_relational.cj

**角色**：提供四元数 epsilon 容差比较和精确比较扩展函数。

**职责**：定义 4 个函数（精确比较 2 个 + epsilon 比较 2 个）：

| 函数 | 语义 |
|------|------|
| `equal(x: Quat<T,Q>, y: Quat<T,Q>): Vec4<Bool,Q>` | 逐分量精确比较 |
| `equal(x: Quat<T,Q>, y: Quat<T,Q>, epsilon: T): Vec4<Bool,Q>` | 逐分量容差比较 |
| `notEqual(x: Quat<T,Q>, y: Quat<T,Q>): Vec4<Bool,Q>` | 逐分量精确不等 |
| `notEqual(x: Quat<T,Q>, y: Quat<T,Q>, epsilon: T): Vec4<Bool,Q>` | 逐分量容差不等 |

**依赖分析**：精确比较版本直接使用 `==` 比较，无外部依赖。epsilon 比较版本使用内联 `abs` 模式和 `lessThanEqual`/`greaterThanEqual`（Vec4 的 Comparable 约束），与 ext/vector_relational.cj 策略一致。

### 3.7 ext/quaternion_geometric.cj

**角色**：提供四元数几何函数（dot、length、normalize、cross）。

**职责**：
- `dot(x: Quat<T,Q>, y: Quat<T,Q>): T` — 四元数点积 `x.w*y.w + x.x*y.x + x.y*y.y + x.z*y.z`。可直接实现，不依赖 geometric.cj 的向量 dot（虽然在 GLM 中委托给 `compute_dot<qua<T,Q>,T>` 特化，但仓颉版本直接内联计算）。
- `length(q: Quat<T,Q>): T` — 四元数长度 `sqrt(dot(q,q))`。依赖 `std.math.sqrt`（仓颉标准库提供），不依赖 geometric.cj。
- `normalize(q: Quat<T,Q>): Quat<T,Q>` — 归一化四元数。内部调用 `length`。可直接完整实现。
- `cross(q1: Quat<T,Q>, q2: Quat<T,Q>): Quat<T,Q>` — 四元数叉积（即 Hamilton 乘积的逐分量展开）。可直接完整实现。

**关键发现**：这 4 个函数的依赖链终止于 `std.math.sqrt`（仓颉标准库提供），**不依赖**阶段二/三的任何 stub 文件。本阶段可**完整实现**。

### 3.8 ext/quaternion_transform.cj

**角色**：提供四元数变换函数（rotate、lookRotate 等）。

**依赖分析**：GLM 的 `quaternion_transform.hpp` 依赖 common.hpp、trigonometric.hpp、geometric.hpp。其中 `rotate` 函数使用 `sin`/`cos`（来自 trigonometric.cj stub）和 `length`（来自 geometric.cj stub）。

**本阶段实现策略**：
- `angleAxis(angle: T, axis: Vec3<T,Q>): Quat<T,Q>` — 依赖 `sin`/`cos`（trigonometric.cj stub），本阶段 **stub 占位**
- `rotate(q: Quat<T,Q>, angle: T, axis: Vec3<T,Q>): Quat<T,Q>` — 依赖 `sin`/`cos` 和 `length`（均为 stub），本阶段 **stub 占位**

**修正**：经仔细审查 `quaternion_transform.hpp` 和 `.inl`，GLM 中 `ext/quaternion_transform.hpp` 仅定义了 `rotate` 一个函数。而 `angleAxis` 定义在 `ext/quaternion_trigonometric.hpp` 中。`lookRotate`/`quatLookAt` 定义在 `gtc/quaternion.hpp` 中。

因此 ext/quaternion_transform.cj 本阶段仅包含 `rotate` 的 stub。其余函数对应的归入各自的模块。

### 3.9 ext/quaternion_trigonometric.cj

**角色**：提供四元数三角函数（angle、axis、angleAxis）。

**依赖分析**：
- `angle(x: Quat<T,Q>): T` — 依赖 `abs`、`asin`、`acos`、`sqrt`、`pi<T>()`（scalar_constants）。`abs` 可内联，`asin`/`acos` 为 trigonometric.cj stub。**stub 占位**。
- `axis(x: Quat<T,Q>): Vec3<T,Q>` — 依赖 `sqrt`（std.math 提供）和 T(1) 演算。可完整实现。
- `angleAxis(angle: T, axis: Vec3<T,Q>): Quat<T,Q>` — 依赖 `sin`/`cos`（trigonometric.cj stub）。**stub 占位**。

**修正本阶段策略**：
- `axis` — **完整实现**（仅依赖 `std.math.sqrt`）
- `angle` — **stub 占位**（依赖 trigonometric.cj 的 `asin`/`acos`）
- `angleAxis` — **stub 占位**（依赖 trigonometric.cj 的 `sin`/`cos`）

### 3.10 ext/quaternion_exponential.cj

**角色**：提供四元数指数函数（exp、log、pow、sqrt）。

**依赖分析**：
- `exp(q: Quat<T,Q>): Quat<T,Q>` — 依赖 `length`（quaternion_geometric）、`cos`/`sin`（trigonometric.cj stub）。**stub 占位**（依赖 trigonometric.cj）。
- `log(q: Quat<T,Q>): Quat<T,Q>` — 依赖 `length`、`atan`、`log`（trigonometric.cj/exponential.cj 接口）。**stub 占位**。
- `pow(x: Quat<T,Q>, y: T): Quat<T,Q>` — 依赖 `sqrt`/`acos`/`asin`/`sin`/`pow` 和 `epsilon<T>()`。**stub 占位**。
- `sqrt(x: Quat<T,Q>): Quat<T,Q>` — 委托 `pow(x, 0.5)`。**stub 占位**。

**修正**：4 个函数均依赖 trigonometric.cj stub，本阶段全部 **stub 占位**。

### 3.11 ext/quaternion_common.cj

**角色**：提供四元数公共函数（mix、lerp、slerp、conjugate、inverse、isnan、isinf）。

**依赖分析**：
- `dot` — 委托 quaternion_geometric.cj，完整可用
- `conjugate(q: Quat<T,Q>): Quat<T,Q>` — 仅涉及逐分量取反。**完整实现**。
- `inverse(q: Quat<T,Q>): Quat<T,Q>` — `conjugate(q) / dot(q, q)`。**完整实现**（依赖 dot 和 除法运算符）。
- `lerp(x, y, a): Quat<T,Q>` — `x * (1 - a) + y * a`。**完整实现**（纯算术）。
- `slerp(x, y, a): Quat<T,Q>` — 依赖 `dot`、`acos`/`sin`/`mix`（标量版）。`acos`/`sin` 属 trigonometric.cj stub，`mix` 属 common.cj stub。**stub 占位**（因 sin/acos 依赖）。
- `mix(x, y, a): Quat<T,Q>` — 依赖 `dot`、`acos`、`sin`。**stub 占位**。
- `slerp(x, y, a, k)` — 多旋转 slerp。**stub 占位**。
- `isnan(q: Quat<T,Q>): Vec4<Bool,Q>` — 依赖 `std.math.isNaN`（仓颉标准库可能提供）。**需原型验证**：若仓颉 `std.math.isNaN` 可用则完整实现，否则 stub。
- `isinf(q: Quat<T,Q>): Vec4<Bool,Q>` — 依赖 `std.math.isInfinite`。同上。

**本阶段策略修正**：
- **完整实现**：`conjugate`、`inverse`、`lerp`
- **stub 占位**：`mix`、`slerp`（2 版本）、`isnan`（待验证）、`isinf`（待验证）

### 3.12 scalar_constants 与 gtc/constants

**ext/scalar_constants.cj**：
- 提供 3 个泛型函数：`epsilon<T>()`、`pi<T>()`、`cos_one_over_two<T>()`
- 实际实现位于 `glm.detail.scalar_constants.cj`（声明 `package glm.detail`），ext/ 文件仅做 `public import` 重导出
- 依赖仅 `setup.cj`（GLM_CONFIG_* 配置常量），可**完整实现**
- **仓颉 T(0) 限制的适配**：GLM 中 `epsilon<T>()` 使用 `std::numeric_limits<T>::epsilon()`，仓颉无此机制。实现方式为具体类型分派：对 Float32 返回 `Float32(1.1920929e-7)`，对 Float64 返回 `Float64(2.220446049250313e-16)`，通过 `match` 类型模式匹配实现（同 deviations.md DV-04 的 `epsilonOf` 策略，需 `hint: T` 参数辅助类型推断）
- `pi<T>()` 和 `cos_one_over_two<T>()` 同理，使用具体类型硬编码值

**gtc/constants.cj**：
- 提供 25 个常量函数（zero/one/two_pi/tau/root_pi/half_pi/three_over_two_pi/quarter_pi/one_over_pi/one_over_two_pi/two_over_pi/four_over_pi/two_over_root_pi/one_over_root_two/root_half_pi/root_two_pi/root_ln_four/e/euler/root_two/root_three/root_five/ln_two/ln_ten/ln_ln_two/third/two_thirds/golden_ratio）
- 全部为泛型函数 `func zero<T>(): T` 等，内部使用具体类型硬编码值
- 依赖 `ext/scalar_constants.cj`（`two_pi` 委托 `pi<T>() * 2.0` 等，但 GLM 实现中全部使用 `genType(3.14159...)` 形式直接硬编码，无函数间调用）
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

fwd.cj 新增别名：`Quat` = `Quat<Float32, PackedHighp>`，`DQuat` = `Quat<Float64, PackedHighp>`，以及精度前缀变体（`HighpQuat`/`MediumpQuat`/`LowpQuat`/`HighpDQuat`/`MediumpDQuat`/`LowpDQuat` 共 6 个）。

---

## 4. 关键行为契约

### 4.1 四元数构造与单位四元数

```
let q = Quat<Float32, PackedHighp>.identity(1.0f)    // 单位四元数 (0,0,0,1)
let q = Quat<Float32, PackedHighp>(0.0f, 0.0f, 0.0f, 1.0f) // 逐分量
let q = Quat<Float32, PackedHighp>.wxyz(1.0f, 0.0f, 0.0f, 0.0f) // wxyz 顺序
```

### 4.2 四元数旋转

```
let rotated = q * v        // 四元数旋转 Vec3
let rotatedV4 = q * v4     // 四元数旋转 Vec4（保留 w 分量）
let invRotated = v * q      // Vec3×Quat = inverse(q) * v
```

### 4.3 四元数插值

```
let result = lerp(q1, q2, 0.5f)    // 线性插值（本阶段完整实现）
let result = conjugate(q)           // 共轭（本阶段完整实现）
let inv = inverse(q)               // 逆四元数（本阶段完整实现）
// slerp 为 stub，待阶段四
```

### 4.4 矩阵-四元数互转

```
let m3 = mat3Cast(q)     // 四元数转 3×3 旋转矩阵
let m4 = mat4Cast(q)     // 四元数转 4×4 旋转矩阵
let q = quatCast(m3)     // 3×3 旋转矩阵转四元数
```

### 4.5 标量常量与数学常量

```
let eps = epsilon<Float32>()     // 1.1920929e-7
let p = pi<Float32>()            // 3.14159265...
let half = halfPi<Float32>()     // 1.57079632...
```

---

## 5. 错误处理策略

- 下标越界抛出 Exception（与阶段一/二一致）
- `normalize` 零四元数行为：返回单位四元数 `identity(one)` 其中 T(0) 通过 `one - one` 演算（与 GLM `normalize` 对零长度向量返回 `(1,0,0,0)` 一致）
- stub 函数体以 `throw Exception("stub")` 占位
- `inverse(q)` 当 `dot(q,q) == T(0)` 时除以零产生 Inf/NaN 分量——行为与 C++ GLM 一致（GLM 不做零除保护）
- 标量/四元数 `div(s, q)` 语义为 `s / q.x, s / q.y, s / q.z, s / q.w`（逐分量标量除），与标量/矩阵 `div` 模式一致
- **溢出策略**：四元数算术运算符不标注 `@OverflowWrapping`——四元数运算本质上是浮点运算（GLM 通过 `is_iec559` 断言限制仅浮点类型），整数四元数在 GLM 中不可构造。仓颉 `Number<T>` 约束下理论上允许整数实例化，但本设计不鼓励该用法。若未来需要整数四元数支持，需重新评估标注策略。

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
| D11 | quatCast/mat3Cast/mat4Cast 作为包级函数定义于 glm.detail | 与阶段二 transpose/identity 等函数库的组织方式一致，非 Quat 类型的成员函数 |
| D12 | type_quat.inl 中 fromVec3(u,v) 和 fromEuler(eulerAngle) 构造函数本阶段化简为独立工厂函数 | 避免在 Quat 结构体内引入对 stub 函数的编译依赖；工厂函数在 extend 块中定义，可推迟至阶段四完整实现 |
| D13 | lookRotate/quatLookAt 等 gtc/quaternion 函数本阶段 stub 占位 | 这些函数依赖 geometric.cj 的 cross/dot/normalize/inversesqrt（均为 stub），无法完整实现 |
| D14 | quaternion_geometric.cj（dot/length/normalize/cross）本阶段完整实现 | 经分析确认依赖链仅止于 std.math.sqrt，不依赖任何 stub 文件 |
| D15 | quaternion_common.cj 中 conjugate/inverse/lerp 本阶段完整实现 | 这些函数仅需算术运算和 dot（quaternion_geometric.cj 已完整实现），不依赖 trigonometric/common stub |
| D16 | trigonometric.cj 新增为空桩文件 | type_quat.inl 依赖 trigonometric.hpp，本阶段仅提供签名空壳供依赖闭合 |
| D17 | Bool 四元数不支持算术运算 | Bool 不实现 Number<T> 接口，与阶段二 D33 Bool 矩阵策略一致 |
| D18 | scalar_quat_ops.cj 与 scalar_vec_ops.cj/scalar_mat_ops.cj 同名重载 | add/sub/mul/div 与向量/矩阵版本通过第二参数类型消歧，与阶段二策略一致 |
| D19 | 四元数算术运算符不标注 @OverflowWrapping | 四元数运算本质为浮点运算，标注对浮点无效果且可能影响 NaN/Inf 传播语义（参见 deviations.md DEV-26 偏差分析） |

---

## 8. 阶段三产出物清单

### 完整实现

- `detail/type_quat.cj`（四元数核心类型 + 运算符 + quatCast/mat3Cast/mat4Cast）
- `detail/scalar_constants.cj`（标量常量 epsilon/pi/cos_one_over_two）
- `detail/scalar_quat_ops.cj`（标量-四元数全局函数 add/sub/mul/div）
- `ext/vector_relational.cj`（向量 epsilon 关系运算，16 个重载）
- `ext/quaternion_relational.cj`（四元数关系运算，4 个函数）
- `ext/quaternion_geometric.cj`（四元数 dot/length/normalize/cross，4 个函数）
- `ext/quaternion_common.cj`（四元数 conjugate/inverse/lerp，3 个函数完整实现）
- `ext/quaternion_trigonometric.cj`（四元数 axis 函数完整实现）
- `ext/scalar_constants.cj`（ext 重导出接口）
- `gtc/constants.cj`（25 个数学常量函数）
- 四元数别名文件（4 个 ext/ 文件）
- 四元数测试文件

### 大部分实现（部分函数 stub）

- `ext/quaternion_trigonometric.cj`（angle/angleAxis 为 stub）
- `ext/quaternion_common.cj`（mix/slerp/slerp(k)/isnan/isinf 为 stub）
- `ext/quaternion_transform.cj`（rotate 为 stub）
- `ext/quaternion_exponential.cj`（exp/log/pow/sqrt 全部 stub）

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

- `fwd.cj`：新增约 8 个四元数类型别名
- `lib.cj`：新增 Quat 类型、ext/gtc 函数和常量的 public import

### 编码启动前验证项

1. **cjpm gtc 子包构建预验证**：验证 `src/gtc/` + `package glm.gtc` 的构建可行性
2. **Quat 构造 fromMat3/fromMat4 依赖 quatCast 前向引用验证**：type_quat.cj 中构造函数体调用 quatCast（同为 detail 包内的包级函数），验证编译器同包前向引用延迟解析支持
3. **Vec3/Vec4 extend 块中 Quat 类型前向引用验证**：Vec3×Quat 和 Vec4×Quat 运算符需在 Vec3/Vec4 的 extend 块中引用 Quat 类型，验证同包延迟解析（已通过阶段二原型验证，仅为防御性确认）
4. **scalar_constants 的泛型 `match` 类型模式匹配验证**：验证 `func epsilon<T>(hint: T): T where T <: Number<T>` 函数体内 `match (hint) { case _: Float32 => ... }` 编译通过
5. **标量-四元数与标量-向量/标量-矩阵同名重载消歧验证**：`add(s: T, q: Quat<T,Q>)` 与 `add(s: T, v: Vec2<T,Q>)`/`add(s: T, m: Mat2x2<T,Q>)` 等的编译器消歧
6. **`std.math.isNaN`/`std.math.isInfinite` 可用性验证**：确认仓颉标准库提供浮点 NaN/Inf 检测函数（影响 quaternion_common.cj 中 isnan/isinf 的实现可行性）
7. **ext/vector_relational 内联 abs 验证**：验证 `if (d >= T(0)) { d } else { -d }` 模式在 `Number<T> & Comparable<T>` 约束下的编译通过性

---

## 9. 对齐 GLM 参考实现的差异声明

| 差异 | 说明 |
|------|------|
| **无匿名 union / GLM_FORCE_QUAT_DATA_WXYZ** | 四元数仅支持 xyzw 存储+参数顺序布局，不支持 wxyz 存储布局变体 |
| **构造函数参数顺序 (x,y,z,w) 非 (w,x,y,z)** | 仓颉侧主构造函数参数顺序与数据成员声明顺序一致，通过 `wxyz()` 工厂函数提供 GLM 习惯入口 |
| **无 C++ 显式类型转换运算符** | 仓颉不支持 `operator mat3x3()`/`operator mat4x4()` 隐式/显式类型转换运算符。矩阵-四元数互转通过 `mat3Cast`/`mat4Cast`/`quatCast` 显式函数实现 |
| **ULP 比较函数无法实现** | 仓颉无浮点位表示直接访问（无 `reinterpret_cast`/`union`），ULP 比较以空桩占位 |
| **lookRotate 从构造函数改为具名工厂函数** | C++ GLM 中 `qua(vec3, vec3)` 为构造函数，仓颉版本改为 `Quat.fromVec3(u, v)` 工厂函数（因依赖 geometric.cj stub，阶段三为 stub 占位） |
| **从欧拉角构造改为具名工厂函数** | C++ GLM 中 `qua(vec3 eulerAngles)` 为构造函数，仓颉改为 `Quat.fromEuler(eulerAngles)`（依赖 trigonometric.cj stub，阶段三为 stub 占位） |
| **从旋转矩阵构造改为具名工厂函数** | C++ GLM 中 `qua(mat3x3)`/`qua(mat4x4)` 为构造函数，仓颉改为 `Quat.fromMat3`/`Quat.fromMat4` |
| **一元 + 运算符不可用** | 仓颉不支持重载一元 + 运算符（与 deviations.md IF-01 一致） |
| **标量-四元数运算为全局函数** | 仓颉 operator func 限制 |
| **quaternion_common 中 mix/slerp 依赖 trigonometric.cj stub** | 本阶段 slerp 为 stub 占位，待阶段四 trigonometric.cj 完整实现后补齐 |
| **ext/vector_relational 内联 abs 而非调用 common.cj** | 消除对 stub 的运行时依赖，确保本阶段函数可执行 |
| **scalar_constants 使用 hint 参数辅助类型推断** | 与 deviations.md DV-04 一致 |
| **四元数算术运算符不标注 @OverflowWrapping** | 四元数运算本质为浮点，标注对浮点无效果 |
| **fwd.cj 排除整型四元数别名** | 与阶段二排除整型矩阵别名的策略一致，需后续阶段按需补充 |
| **ext/ 和 gtc/ 子包独立声明** | 仓颉包名与目录路径匹配规则约束 |
| **gtc/matrix_transform.cj 本阶段以空桩占位** | 其完整实现依赖链覆盖几乎所有函数库层，归入阶段四 |

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
| Quat×Vec3/Vec4 | 本阶段实现 | §3.4 |
| Vec3×Quat/Vec4×Quat | 本阶段实现 | §3.4 |
| Quat×T / T×Quat / Quat/T | 本阶段实现 | §3.4 |
| == / != 比较 | 本阶段实现 | §3.4 |
| quatCast(Mat3) / quatCast(Mat4) | 本阶段实现 | §3.3 item 6/7 |
| mat3Cast / mat4Cast | 本阶段实现 | §3.2 |

### glm/ext/vector_relational.hpp

| 函数 | 覆盖状态 |
|------|---------|
| equal(VecN, VecN, T epsilon) | 本阶段实现（16 重载） |
| equal(VecN, VecN, VecN epsilon) | 本阶段实现（16 重载） |
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
| conjugate(Quat) | 本阶段实现 |
| inverse(Quat) | 本阶段实现 |
| lerp(Quat, Quat, T) | 本阶段实现 |
| mix(Quat, Quat, T) | 本阶段 stub |
| slerp(Quat, Quat, T) | 本阶段 stub |
| slerp(Quat, Quat, T, S) | 本阶段 stub |
| isnan(Quat) | 待验证 |
| isinf(Quat) | 待验证 |

### glm/ext/quaternion_trigonometric.hpp

| 函数 | 覆盖状态 |
|------|---------|
| axis(Quat) | 本阶段实现 |
| angle(Quat) | 本阶段 stub |
| angleAxis(T, Vec3) | 本阶段 stub |

### glm/ext/quaternion_transform.hpp

| 函数 | 覆盖状态 |
|------|---------|
| rotate(Quat, T, Vec3) | 本阶段 stub |

### glm/ext/quaternion_exponential.hpp

| 函数 | 覆盖状态 |
|------|---------|
| exp(Quat) | 本阶段 stub |
| log(Quat) | 本阶段 stub |
| pow(Quat, T) | 本阶段 stub |
| sqrt(Quat) | 本阶段 stub |

### glm/ext/scalar_constants.hpp

| 函数 | 覆盖状态 |
|------|---------|
| epsilon<T>() | 本阶段实现 |
| pi<T>() | 本阶段实现 |
| cos_one_over_two<T>() | 本阶段实现 |

### glm/gtc/constants.hpp

| 函数 | 覆盖状态 |
|------|---------|
| 25 个常量函数 | 本阶段实现 |

### glm/gtc/matrix_transform.hpp

| 函数 | 覆盖状态 |
|------|---------|
| 全部函数 | 本阶段空桩占位 |

### glm/gtc/quaternion.hpp

| 函数 | 覆盖状态 |
|------|---------|
| eulerAngles/roll/pitch/yaw | 本阶段 stub（依赖 common.cj/trigonometric.cj stub） |
| mat3_cast/mat4_cast | 本阶段实现（随 type_quat.cj 编码） |
| quat_cast(Mat3)/quat_cast(Mat4) | 本阶段实现（随 type_quat.cj 编码） |
| lessThan/lessThanEqual/greaterThan/greaterThanEqual | 本阶段实现（比较运算，不依赖 stub） |
| quatLookAt/quatLookAtRH/quatLookAtLH | 本阶段 stub（依赖 geometric.cj stub） |
