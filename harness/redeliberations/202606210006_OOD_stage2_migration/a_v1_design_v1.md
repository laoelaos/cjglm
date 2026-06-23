# GLM 1.0.3 仓颉迁移阶段二 OOD 设计方案

> **版本**：v1（首轮设计）
> **对应路线图**：`docs/02_roadmap.md` 阶段 2（矩阵类型 + `ext/` 别名文件）
> **前置依赖**：阶段 1 完成（`Vec1<T,Q>` ~ `Vec4<T,Q>` 类型定义、`Qualifier` 接口体系、类型别名体系就绪）

---

## 1. 概述

### 设计目标

在阶段一向量核心类型基础上，迁移 GLM 全部 9 个矩阵类型及其关联的运算符、跨矩阵转换构造函数和 `ext/` 别名层，使库具备二维/三维/四维矩阵的数学表达能力。本阶段不实现 `common.cj`/`matrix.cj`/`geometric.cj` 函数库——方阵类型（`Mat2x2`/`Mat3x3`/`Mat4x4`）的 `.inl` 实现所引用的函数库以空桩占位，非方阵类型无此依赖。

### 核心抽象

| 抽象 | 角色 | 类型形态 |
|------|------|---------|
| `Mat2x2<T,Q>` ~ `Mat4x4<T,Q>`（9 个类型） | 表示数学矩阵的值对象 | 泛型结构体 |
| `common.cj` / `matrix.cj` / `geometric.cj` | 函数库桩文件（为方阵编译提供依赖闭合） | 包级函数桩（空函数体） |
| `ext/` 别名文件 | 具现化矩阵/向量类型的便捷命名 | `type` 别名 |

### 整体架构思路

延续阶段一的双层包结构：`glm.detail` 包封装 9 个矩阵泛型结构体定义及全部运算符实现，`glm` 包中的 `fwd.cj` 提供矩阵类型别名，新增 `ext/` 子包存放向量/矩阵别名具现化文件。矩阵以向量列为内部数据成员，采用列主序（column-major）存储约定，与 GLM/C++ 一致。方阵（`Mat2x2`/`Mat3x3`/`Mat4x4`）的 `.inl` 实现中引用的 `common.cj`/`matrix.cj`/`geometric.cj` 在本阶段以空桩占位（仅提供函数签名空壳），待阶段四完整实现。

---

## 2. 模块划分

### 包组织

```
package glm.detail               — 核心实现层
  ├── setup.cj                   — 配置常量（阶段一已有）
  ├── qualifier.cj               — Qualifier 接口及实现（阶段一已有）
  ├── shim_*.cj                  — shim 层（阶段一已有）
  ├── compute_vector_relational.cj  — 向量比较（阶段一已有）
  ├── compute_vector_decl.cj     — 运算策略（阶段一已有）
  ├── vectorize.cj               — functor 工具（阶段一已有）
  ├── scalar_vec_ops.cj          — 标量-向量运算（阶段一已有）
  ├── type_vec1.cj ~ type_vec4.cj — 向量类型（阶段一已有）
  ├── type_fromBoolVec.cj        — fromBoolVec（阶段一已有）
  ├── type_cast.cj               — 跨类型转换（阶段一已有）
  │
  ├── type_mat2x2.cj             ─ Mat2x2<T,Q> 结构体定义 + 运算符
  ├── type_mat2x3.cj             ─ Mat2x3<T,Q> 结构体定义 + 运算符
  ├── type_mat2x4.cj             ─ Mat2x4<T,Q> 结构体定义 + 运算符
  ├── type_mat3x2.cj             ─ Mat3x2<T,Q> 结构体定义 + 运算符
  ├── type_mat3x3.cj             ─ Mat3x3<T,Q> 结构体定义 + 运算符
  ├── type_mat3x4.cj             ─ Mat3x4<T,Q> 结构体定义 + 运算符
  ├── type_mat4x2.cj             ─ Mat4x2<T,Q> 结构体定义 + 运算符
  ├── type_mat4x3.cj             ─ Mat4x3<T,Q> 结构体定义 + 运算符
  └── type_mat4x4.cj             ─ Mat4x4<T,Q> 结构体定义 + 运算符

package glm                       — 公共 API 面 + 别名层
  ├── lib.cj                      — 公共 API 重导出（阶段一已有，本阶段追加矩阵类型导出）
  ├── fwd.cj                      — 标量/向量/矩阵类型别名（阶段一已有，本阶段追加矩阵别名）
  └── ext/                        — 别名具现化文件（新增）
      ├── vector_float2.cj        ─ type Vec2 = Mat... // 但这里应该是 Vec2 别名
      ├── vector_float3.cj
      ├── vector_float4.cj
      ├── vector_bool2.cj
      ├── ...                     — 向量别名的 ext/ 具现化（沿用阶段一，本阶段新增矩阵别名）
      ├── matrix_float2x2.cj      ─ type Mat2x2 等别名
      ├── matrix_float2x3.cj
      ├── matrix_float2x4.cj
      ├── matrix_float3x2.cj
      ├── matrix_float3x3.cj
      ├── matrix_float3x4.cj
      ├── matrix_float4x2.cj
      ├── matrix_float4x3.cj
      ├── matrix_float4x4.cj
      ├── matrix_double2x2.cj
      ├── ...                     — 双精度矩阵别名
      └── matrix_int*.cj          — 整数矩阵别名
```

**说明**：`ext/` 目录中的文件均为独立的 `package glm` 包声明，每个文件包含对应类型的 `public type` 别名定义。这些别名在 GLM 中用于实现对具体精度变体的具现化。在仓颉中它们直接引用 `glm.detail` 中的泛型类型并绑定具体类型参数。

### 公共 API 面设计

`lib.cj`（`package glm`）在阶段一基础上追加矩阵类型导出：

```cangjie
package glm
// 阶段一已有：
public import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }
public import glm.detail.{ Qualifier, PackedHighp, PackedMediump, PackedLowp }
public import glm.detail.{ Defaultp }
public import glm.detail.{ add, sub, mul, div, mod }
public import glm.detail.{ fromBoolVec, fromBoolVecQ2 }
// 阶段二新增：
public import glm.detail.{ Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4 }
```

### 模块间依赖

```
glm.detail（同包直接可见）
  setup, qualifier, shim_*             — 阶段一，无新增依赖
  type_vec1.cj ~ type_vec4.cj          — 阶段一，每种矩阵类型依赖对应分量数的 Vec 类型
  type_mat2x2.cj → type_vec2.cj       — Mat2x2 列类型为 Vec2<T,Q>
  type_mat2x3.cj → type_vec2.cj + type_vec3.cj  — Mat2x3 列类型 Vec3, 行类型 Vec2
  type_mat2x4.cj → type_vec2.cj + type_vec4.cj
  type_mat3x2.cj → type_vec2.cj + type_vec3.cj
  type_mat3x3.cj → type_vec3.cj       — Mat3x3 列/行类型均为 Vec3
  type_mat3x4.cj → type_vec3.cj + type_vec4.cj
  type_mat4x2.cj → type_vec2.cj + type_vec4.cj
  type_mat4x3.cj → type_vec3.cj + type_vec4.cj
  type_mat4x4.cj → type_vec4.cj       — Mat4x4 列/行类型均为 Vec4

glm
  lib.cj → glm.detail.*               — 公共导出
  fwd.cj → glm.detail.*               — 类型别名
  ext/*.cj → glm.detail.*             — 别名具现化
```

**特殊依赖说明**（方阵 `.inl` 的函数库引用）：
- `type_mat2x2.cj` 中引用的 `matrix.cj`（`inverse` 函数）→ 本阶段以 `package glm.detail` 中的 `matrix.cj` 桩文件占位
- `type_mat3x3.cj` 中引用的 `matrix.cj` 和 `common.cj` → 本阶段以对应桩文件占位
- `type_mat4x4.cj` 中引用的 `matrix.cj` 和 `geometric.cj` → 本阶段以对应桩文件占位
- 其余 6 个非方阵矩阵类型无此依赖

### 新增文件清单

| 文件 | 说明 | 依赖 |
|------|------|------|
| `detail/type_mat2x2.cj` | Mat2x2 结构体 + 运算符 | `type_vec2.cj` |
| `detail/type_mat2x3.cj` | Mat2x3 结构体 + 运算符 | `type_vec2.cj`, `type_vec3.cj` |
| `detail/type_mat2x4.cj` | Mat2x4 结构体 + 运算符 | `type_vec2.cj`, `type_vec4.cj` |
| `detail/type_mat3x2.cj` | Mat3x2 结构体 + 运算符 | `type_vec2.cj`, `type_vec3.cj` |
| `detail/type_mat3x3.cj` | Mat3x3 结构体 + 运算符 | `type_vec3.cj` |
| `detail/type_mat3x4.cj` | Mat3x4 结构体 + 运算符 | `type_vec3.cj`, `type_vec4.cj` |
| `detail/type_mat4x2.cj` | Mat4x2 结构体 + 运算符 | `type_vec2.cj`, `type_vec4.cj` |
| `detail/type_mat4x3.cj` | Mat4x3 结构体 + 运算符 | `type_vec3.cj`, `type_vec4.cj` |
| `detail/type_mat4x4.cj` | Mat4x4 结构体 + 运算符 | `type_vec4.cj` |
| `detail/common.cj` | 函数库桩（`package glm.detail`） | 无（仅提供空桩函数签名） |
| `detail/matrix.cj` | 函数库桩（`package glm.detail`） | 无（仅提供空桩函数签名） |
| `detail/geometric.cj` | 函数库桩（`package glm.detail`） | 无（仅提供空桩函数签名） |
| `ext/` 目录下别名文件 | 按需创建，每类型一个文件 | `glm.detail` 中的对应类型 |

### 函数库桩文件设计

三个桩文件（`common.cj`、`matrix.cj`、`geometric.cj`）均声明 `package glm.detail`，作用是为方阵类型（`Mat2x2`/`Mat3x3`/`Mat4x4`）中被 `.inl` 实现引用的函数提供编译通过所需的签名空壳。

**`common.cj` 桩**（被 `type_mat3x3.cj` 引用）：
提供以下函数的空桩实现（函数体抛出 `UnsupportedOperationException` 或在后续阶段替换前返回零值）：
- `splatX(v: Vec3<T,Q>): Vec3<T,Q>` — 将 v.x 广播到 Vec3 全部分量
- `splatY(v: Vec3<T,Q>): Vec3<T,Q>`
- `splatZ(v: Vec3<T,Q>): Vec3<T,Q>`
- `splatW(v: Vec4<T,Q>): Vec4<T,Q>`
- `xyzz(v: Vec3<T,Q>): Vec4<T,Q>` — 将 Vec3 扩展为 Vec4（z 重复到 w）

**`matrix.cj` 桩**（被 `type_mat2x2.cj`/`type_mat3x3.cj`/`type_mat4x4.cj` 引用）：
提供以下函数的空桩实现：
- `inverse(m: Mat2x2<T,Q>): Mat2x2<T,Q>`
- `inverse(m: Mat3x3<T,Q>): Mat3x3<T,Q>`
- `inverse(m: Mat4x4<T,Q>): Mat4x4<T,Q>`
- `dot(a: VecN<T,Q>, b: VecN<T,Q>): T`

**`geometric.cj` 桩**（被 `type_mat4x4.cj` 引用）：
提供以下函数的空桩实现：
- `dot(a: Vec4<T,Q>, b: Vec4<T,Q>): T`

**说明**：桩文件中每个函数必须提供完整签名，但函数体可退化为 `throw Exception("stub")` 或返回 `T(0)` 等占位值。由于本阶段矩阵运算符实现仅在矩阵-标量算术运算和矩阵-矩阵乘法中使用内联分量运算而非桩函数，桩函数仅在以下场景被调用：
- `Mat2x2` 的 `operator/(m, v)` → `inverse(m) * v`（矩阵除以向量）
- `Mat2x2` 的 `operator/(v, m)` → `v * inverse(m)`（向量除以矩阵）
- `Mat3x3` 的 `operator*(v, m)` → `dot(m[0], v), dot(m[1], v), dot(m[2], v)`（向量乘矩阵）
- `Mat4x4` 的 `operator*(v, m)` → `dot(m[0], v), dot(m[1], v), dot(m[2], v), dot(m[3], v)`（向量乘矩阵）
- `Mat2x2`/`Mat3x3`/`Mat4x4` 的 `operator/=(m)` → `*this *= inverse(m)`
- `Mat3x3` 的 `operator*(m, v)` → 使用 `splatX`/`splatY`/`splatZ`

因此这些桩函数在阶段二仅被极少数运算符路径调用。编码阶段可验证所有矩阵构造函数和基本运算符在不调用桩函数的情况下独立编译通过，桩函数仅用于支持上述除法/向量乘法路径的编译闭合性。

---

## 3. 核心抽象

### 3.1 矩阵类型体系

**角色**：表示数学矩阵，是 GLM 中核心的线性代数类型。每个矩阵是值类型（struct），以向量列（column-major）为内部数据成员，支持构造、列访问、算术运算、矩阵-矩阵乘法、矩阵-向量乘法。

**类型定义模式**：9 个矩阵类型遵循统一的结构模式，差异仅在于列数（C）、行数（R）和对应的列类型/行类型。以下以 `Mat3x3<T,Q>` 为例展示类型结构：

```cangjie
struct Mat3x3<T, Q> where Q <: Qualifier {
    // 列数据成员（列主序）
    var c0: Vec3<T, Q>
    var c1: Vec3<T, Q>
    var c2: Vec3<T, Q>
}
```

各矩阵类型的列/行类型关系：

| 类型 | 列类型 | 行类型 | 列数 | 行数 |
|------|--------|--------|------|------|
| `Mat2x2<T,Q>` | `Vec2<T,Q>` | `Vec2<T,Q>` | 2 | 2 |
| `Mat2x3<T,Q>` | `Vec3<T,Q>` | `Vec2<T,Q>` | 2 | 3 |
| `Mat2x4<T,Q>` | `Vec4<T,Q>` | `Vec2<T,Q>` | 2 | 4 |
| `Mat3x2<T,Q>` | `Vec2<T,Q>` | `Vec3<T,Q>` | 3 | 2 |
| `Mat3x3<T,Q>` | `Vec3<T,Q>` | `Vec3<T,Q>` | 3 | 3 |
| `Mat3x4<T,Q>` | `Vec4<T,Q>` | `Vec3<T,Q>` | 3 | 4 |
| `Mat4x2<T,Q>` | `Vec2<T,Q>` | `Vec4<T,Q>` | 4 | 2 |
| `Mat4x3<T,Q>` | `Vec3<T,Q>` | `Vec4<T,Q>` | 4 | 3 |
| `Mat4x4<T,Q>` | `Vec4<T,Q>` | `Vec4<T,Q>` | 4 | 4 |

**列主序约定**：矩阵内部以列向量 `c0`、`c1`、... 存储。`m[i]` 返回第 i 列向量，`m[i][j]` 访问第 i 列第 j 行的元素。此约定与 GLM/C++ 列主序一致。

**数据成员**：声明为 `var`（可变，无初始值），与阶段一 Vec 类型的成员声明策略一致。默认矩阵构造（identity）通过标量填充构造实现，而非依赖编译器默认构造函数。

**`const public static func length(): Int64`**：返回列数（编译期常量）。`Mat2x2`/`Mat2x3`/`Mat2x4` 返回 2；`Mat3x2`/`Mat3x3`/`Mat3x4` 返回 3；`Mat4x2`/`Mat4x3`/`Mat4x4` 返回 4。

**`const public static func colSize(): Int64`**：返回行数（编译期常量）。`Mat2x2`/`Mat3x2`/`Mat4x2` 返回 2；`Mat2x3`/`Mat3x3`/`Mat4x3` 返回 3；`Mat2x4`/`Mat3x4`/`Mat4x4` 返回 4。

**类型形态选择理由**：
- 使用 **struct** 而非 class：矩阵是纯值语义类型，按值传递应复制而非共享引用。与阶段一 Vec 类型保持一致。
- 使用 **命名列成员**（`c0`, `c1`, ...）而非数组：仓颉泛型结构体不支持编译期大小固定的原生数组，且命名成员在编译期类型安全性和访问性能上优于 `VArray` 或 `ArrayList`。
- 列成员数量由类型自身编码：`Mat2x2` 有 2 个列成员，`Mat4x4` 有 4 个列成员，无需运行时长度检查。
- **列成员命名为 `c0`, `c1`, ...**：简短且便于索引式访问（`operator []` 内部分发），与 GLM 的 `value[i]` 数组索引语义等价。对外部用户透明——用户通过 `m[0]`, `m[1]`（下标运算符）访问列，不直接操作成员名。

**`const init` 策略**：与阶段一 Vec 类型一致——为每个矩阵类型定义 `const init(...)` 以支持编译期构造和 `const` 实例成员函数（如 `const` 版本的相等比较）。`const init` 的参数列表为逐分量初始化（按列主序排列所有元素）。额外提供非 `const` 构造函数用于标量填充、列向量构造、跨类型/跨矩阵转换。

### 3.2 下标运算符

**角色**：提供对矩阵列的按索引访问，`m[i]` 返回第 i 列向量。

```
// 取值
public operator func [](i: Int64): col_type
// 赋值（mut 函数）
public operator func [](i: Int64, value!: col_type): Unit
```

`i` 的范围为 `0` 到 `length() - 1`。取值版本返回列向量副本（值类型语义）。赋值版本原地替换列向量。

内部实现根据 `i` 的值分发到对应列成员（`match (i) { case 0 => this.c0; case 1 => this.c1; ... }`），不涉及循环或数组索引——成员数量固定且已知。

### 3.3 构造函数体系

所有矩阵类型遵循统一的构造函数模式，差异仅在于参数的数量和类型（由列数/行数决定）。以下按功能分类描述：

**默认构造（identity）**：
- **不可用**（数据成员无初始值）。需要单位矩阵的场景应使用标量填充构造（传入 `T(1)` 产生对角为 1 的矩阵）或列向量构造。

**标量填充构造**（`public init(scalar: T)`）：
- 接收单一标量，构造对角矩阵：对角线元素为 `scalar`，非对角线元素为 `T(0)`。
- `Mat2x2(T(1))` 产生 2×2 单位矩阵。
- 对所有 9 个矩阵类型均有效。

**逐元素构造**（`const init(...)`）：
- 按列主序接收所有矩阵元素——列数 × 行数 个参数。
- `Mat2x2` 接收 4 个参数：`(c0x, c0y, c1x, c1y)`。
- `Mat3x3` 接收 9 个参数：`(c0x, c0y, c0z, c1x, c1y, c1z, c2x, c2y, c2z)`。
- `Mat4x4` 接收 16 个参数。
- 声明为 `const init`，可用于编译期上下文。

**列向量构造**（`public init(v0: col_type, v1: col_type, ...)`）：
- 接收与列数相同数量的列向量，按列主序赋值。
- `Mat2x2` 接收 `(v0: Vec2<T,Q>, v1: Vec2<T,Q>)`。
- `Mat3x3` 接收 `(v0: Vec3<T,Q>, v1: Vec3<T,Q>, v2: Vec3<T,Q>)`。
- 非 `const` 构造函数。

**跨矩阵转换构造**（`public init<T2, Q2>(m: MatCxR<T2, Q2>) where Q2 <: Qualifier`）：
- 从同维度的不同 `T`/`Q` 的矩阵构造，分量值通过 `T(v)` 显式类型转换。
- 来源矩阵的每个列向量元素通过 `T(src[i][j])` 转换后构造目标矩阵。

**异构矩阵转换构造**：
- 从不同维度组合的矩阵转换（如从 `Mat2x2` 构造 `Mat3x3`、`Mat4x4` 等）。
- 规则：较小矩阵的元素映射到较大矩阵的左上角子块，剩余元素填充单位矩阵的对应位置（对角线为 `T(1)`，非对角线为 `T(0)`）。
- `Mat3x3` 从 `Mat2x2` 构造时：左上 2×2 子块保留，右下角填 `T(1)`，其余填 `T(0)`。
- 各矩阵类型的异构转换构造函数覆盖：所有其他 8 个矩阵类型（与 GLM 一致，每个矩阵类型有 8 个异构转换构造）。

**跨 Q 转换构造**：
- `public init<P>(m: MatCxR<T, P>) where P <: Qualifier` — 从同类型但不同 Qualifier 的矩阵构造。
- 列向量逐列复制，Q 参数改变。

**从 Vec1 填充构造**（仅对列数为 1 的场景有语义意义，矩阵类型均不涉及）：
- 矩阵类型不从 `Vec1` 填充构造。

### 3.4 算术运算符

**一元运算符**：

| 运算符 | 语义 | 标注 |
|--------|------|------|
| `+m` | 返回 m 自身（恒等） | 非 `mut` |
| `-m` | 所有元素取负 | 非 `mut`，`@OverflowWrapping`（整数） |

**二元算术运算符（矩阵-标量）**：

| 运算符 | 语义 |
|--------|------|
| `m + s` / `s + m` | 逐元素加标量 |
| `m - s` / `s - m` | 逐元素减标量 |
| `m * s` / `s * m` | 逐元素乘标量 |
| `m / s` / `s / m` | 逐元素除标量 |

**二元算术运算符（矩阵-矩阵，同维度）**：

| 运算符 | 语义 |
|--------|------|
| `m1 + m2` | 逐元素加（对应列向量相加） |
| `m1 - m2` | 逐元素减（对应列向量相减） |
| `m1 * m2` | 矩阵乘法（内积，非逐元素乘） |
| `m1 / m2` | `m1 * inverse(m2)`（调用桩函数 `inverse`） |

**矩阵-向量乘法**：

| 运算符 | 语义 | 返回类型 |
|--------|------|---------|
| `m * v` | 矩阵乘列向量：`m × col_vec` | `col_type`（与 m 的列类型相同） |
| `v * m` | 行向量乘矩阵：`row_vec × m` | `row_type`（与 m 的行类型相同） |

矩阵-向量乘法的实现规则：
- `m * v`：`result[i] = sum over j of m[j][i] * v[j]`（列主序下，取每个列向量的第 i 分量乘以 v 的对应分量）
- `v * m`：`result[j] = dot(v, m[j])`（v 与第 j 列的点积）

**跨维度矩阵乘法**：

| 左矩阵列数 | 右矩阵行数 | 结果矩阵 |
|-----------|-----------|---------|
| `Mat<C,R1>` × `Mat<C2,R>` | 要求 `R1 == C2` | `Mat<C2,R>` |
| 具体覆盖与 GLM 一致 | | |

GLM 中每个矩阵类型的乘法重载覆盖所有兼容维度组合。以 `Mat2x2` 为例（乘法右操作数取自 `type_mat2x2.hpp`）：
- `Mat2x2 * Mat2x2` → `Mat2x2`（同尺寸标准乘法）
- `Mat2x2 * Mat3x2` → `Mat3x3`（注意：右操作数行数=2 匹配左操作数列数=2）
- ...实际上根据该文件，重载为 `Mat2x2 * Mat3x2` → `Mat3x2`（右矩阵列数保持，行数=左矩阵行数）

准确的跨维度乘法规则（以 `Mat<C,R>` 表示 C 列 R 行的矩阵，对应 GLM 的 `mat<C,R,T,Q>`）：
- `Mat<C1,R1> * Mat<C2,R2>` 要求 `R1 == C2`（左矩阵的列维度 = 右矩阵的行维度，因为矩阵乘法维度规则：`(R1×C1)*(R2×C2)` 要求 `C1==R2`，结果 `R1×C2`）
- 等等，让我重新理解。GLM 的 `mat<C,R,T,Q>` 约定：C = 列数，R = 行数。所以 `Mat<2,3>` 是 2 列 3 行。
- 矩阵乘法 `A * B` 要求 A 的列数 == B 的行数。`Mat<C1,R1> * Mat<C2,R2>` 要求 `C1 == R2`。
- 结果矩阵为 `Mat<C2,R1>`（结果列数 = B 的列数，结果行数 = A 的行数）。
- GLM 中乘法运算符的重载覆盖所有满足此约束的组合。

各矩阵类型的跨维度乘法覆盖在 GLM 中按每个类型文件独立定义。本设计沿用此模式，每个矩阵类型文件定义：
- 与自身同尺寸的乘法
- 所有满足 `C(左) == R(右)` 约束的右操作数矩阵类型的乘法

**复合赋值运算符**：
仓颉不支持显式定义复合赋值运算符（`+=`、`-=` 等），编译器在检测到返回类型匹配的二元运算符后自动生成复合赋值版本。`@OverflowWrapping` 标注在二元运算符上，复合赋值继承其 wrapping 语义。此机制与阶段一 Vec 类型一致。

**`++`/`--` 替代**：
仓颉可重载运算符列表不包含 `++`/`--`。改为提供具名函数 `increment()`（逐列调用列向量的 `increment()`）和 `decrement()`。定义在 `where T <: Integer<T>` 约束的 `extend` 块中，仅对整数分量类型可用。

**`@OverflowWrapping` 标注策略**：
与阶段一 Vec 类型一致——仅在矩阵的算术运算符（`+`、`-`、`*`、`/` 的二元运算符）上标注 `@OverflowWrapping`。复合赋值运算符由编译器自动生成并继承标注。一元负号 `-m` 也标注 `@OverflowWrapping`。由于矩阵运算中整数溢出仅发生于分量级算术运算，标注策略与 Vec 一致。

### 3.5 比较运算符

**`==` / `!=`**：
- `m1 == m2`：所有对应列向量逐列相等，返回 `Bool`。
- `m1 != m2`：`!(m1 == m2)`。
- 定义在 `extend` 块中，使用阶段一的 `ComputeEqual<T>` 策略进行分量级精确比较。
- 对所有分量类型（含浮点）统一执行精确比较，与 C++ GLM 行为一致。

### 3.6 `ext/` 别名文件

**角色**：在 `package glm` 中为矩阵/向量的常用具现化提供便捷命名，与 GLM 的 `ext/` 目录结构对应。

**文件组织**：参考 GLM 的 `glm/ext/` 目录结构（如 `matrix_float2x2.hpp`、`matrix_double3x3.hpp`、`matrix_int4x4_sized.hpp` 等），在 `package glm` 下创建 `ext/` 子目录，按精度/分量类型分组：

- `vector_float{1,2,3,4}.cj` — 单精度浮点向量别名（阶段一已提供 `fwd.cj` 中的别名，此处提供按 GLM ext/ 惯例的额外入口）
- `vector_double{1,2,3,4}.cj` — 双精度浮点向量别名
- `vector_bool{1,2,3,4}.cj` — 布尔向量别名
- `vector_int{1,2,3,4}.cj` — 32 位有符号整数向量别名
- 类似地，精度变体文件（如 `vector_float2_precision.cj`）
- `matrix_float2x2.cj` ~ `matrix_float4x4.cj` — 单精度浮点矩阵别名
- `matrix_double2x2.cj` ~ `matrix_double4x4.cj` — 双精度矩阵别名
- `matrix_int2x2.cj` ~ `matrix_int4x4.cj` — 整数矩阵别名及其 sized 变体
- 精度变体文件（如 `matrix_float2x2_precision.cj`）

**典型别名定义**（示例 `ext/matrix_float4x4.cj`）：
```cangjie
package glm
import glm.detail.{ Mat4x4, PackedHighp }
public type Mat4 = Mat4x4<Float32, PackedHighp>
public type Mat4x4 = Mat4x4<Float32, PackedHighp>
```

**选择理由**：此结构对应 GLM 的 `ext/` 目录，下游代码可按需 `import glm.ext.matrix_float4x4.Mat4x4`，与 GLM 的使用模式兼容。文件数量较大（约 80 个文件），但每个文件仅 3-5 行，模式固定，可由脚本生成。

**脚本生成策略**：与阶段一 `fwd.cj` 的生成脚本类似，建议使用 Python 脚本按 GLM ext/ 目录结构生成所有别名文件。脚本输入为类型映射表（分量类型 → 仓颉类型、精度变体 → Qualifier 类型），输出为 `ext/` 目录下的所有 `.cj` 文件。

**与原 GLM `ext/` 的覆盖范围对应**：
- 向量别名文件：对应 `glm/ext/vector_float*.hpp`、`vector_double*.hpp`、`vector_bool*.hpp`、`vector_int*.hpp`、`vector_uint*.hpp` 等
- 矩阵别名文件：对应 `glm/ext/matrix_float*.hpp`、`matrix_double*.hpp`、`matrix_int*.hpp`、`matrix_uint*.hpp` 等
- 精度变体文件：对应 `*_precision.hpp` 文件
- sized 整数变体：对应 `matrix_int*_sized.hpp`、`matrix_uint*_sized.hpp` 等

### 3.7 矩阵类型别名（`fwd.cj`）

在阶段一的 `fwd.cj` 中追加矩阵类型别名。命名约定与阶段一向量别名一致（PascalCase、精度前缀驼峰拼接）：

| GLM 原生名 | 仓颉别名（默认 highp） |
|-----------|---------------------|
| `mat2x2` | `Mat2x2` / `HighpMat2x2` / `MediumpMat2x2` / `LowpMat2x2` |
| `mat2` | `Mat2`（`Mat2x2` 的同义别名） |
| `mat3x3` | `Mat3x3` |
| `mat3` | `Mat3`（`Mat3x3` 的同义别名） |
| `mat4x4` | `Mat4x4` |
| `mat4` | `Mat4`（`Mat4x4` 的同义别名） |
| `mat2x3` | `Mat2x3` |
| `mat2x4` | `Mat2x4` |
| `mat3x2` | `Mat3x2` |
| `mat3x4` | `Mat3x4` |
| `mat4x2` | `Mat4x2` |
| `mat4x3` | `Mat4x3` |
| `dmat2x2` | `DMat2x2` |
| `dmat4x4` | `DMat4x4` |
| 类似地低精度/中精度变体 | `LowpMat2x2` / `MediumpMat2x2` |

**别名数量估算**：9 个矩阵类型 × 4 个精度变体（无精度/`Highp`/`Mediump`/`Lowp`）+ 同义缩写（如 `mat2` 作为 `mat2x2` 别名）= 约 40-48 个矩阵别名。此数量远小于向量别名的 256 个，可直接在 `fwd.cj` 中手动定义或由脚本生成。

### 3.8 与阶段一的整合注意事项

1. **`lib.cj` 更新**：追加 `public import glm.detail.{ Mat2x2, ..., Mat4x4 }`。
2. **`fwd.cj` 更新**：追加矩阵类型别名定义，更新 `import` 语句（如需要）。
3. **编译顺序**：9 个矩阵类型之间无相互依赖（矩阵类型之间仅通过运算符参数类型引用，在 `package glm.detail` 内互相可见），可并行编译。但 `type_mat2x2.cj`/`type_mat3x3.cj`/`type_mat4x4.cj` 依赖桩文件 `common.cj`/`matrix.cj`/`geometric.cj` 提供编译闭合性，桩文件应在矩阵文件之前编译。
4. **桩文件生命周期**：三个桩文件在阶段二创建，在阶段四被完整实现替换。阶段二编码阶段可先在桩文件中提供最小化实现（仅签名），供方阵类型的编译验证通过。

---

## 4. 关键行为契约

### 4.1 矩阵构造场景

以下以 `Mat4x4<T,Q>` 为例说明核心构造场景。其他矩阵类型按维度类推。

**场景 A：创建单位矩阵**
```
let identity = Mat4x4<Float32, PackedHighp>(Float32(1.0))
```
标量 `1.0` 填充对角线，其余为 0。

**场景 B：逐元素构造**
```
let m = Mat4x4<Float32, PackedHighp>(
    Float32(1.0), Float32(0.0), Float32(0.0), Float32(0.0),  // 第 0 列
    Float32(0.0), Float32(1.0), Float32(0.0), Float32(0.0),  // 第 1 列
    Float32(0.0), Float32(0.0), Float32(1.0), Float32(0.0),  // 第 2 列
    Float32(0.0), Float32(0.0), Float32(0.0), Float32(1.0)   // 第 3 列
)
```

**场景 C：从列向量构造**
```
let c0 = Vec4<Float32, PackedHighp>(1.0, 0.0, 0.0, 0.0)
let c1 = Vec4<Float32, PackedHighp>(0.0, 1.0, 0.0, 0.0)
let c2 = Vec4<Float32, PackedHighp>(0.0, 0.0, 1.0, 0.0)
let c3 = Vec4<Float32, PackedHighp>(0.0, 0.0, 0.0, 1.0)
let m = Mat4x4<Float32, PackedHighp>(c0, c1, c2, c3)
```

**场景 D：列访问和元素访问**
```
let col0 = m[Int64(0)]             // 返回第 0 列（Vec4<T,Q>）
let elem02 = m[Int64(0)][Int64(2)] // 返回第 0 列第 2 行元素（T）
```

### 4.2 矩阵-向量乘法场景

**场景：矩阵乘列向量**
```
let m = Mat4x4<Float32, PackedHighp>(Float32(1.0))  // 单位矩阵
let v = Vec4<Float32, PackedHighp>(1.0, 2.0, 3.0, 4.0)
let result = m * v  // result = (1.0, 2.0, 3.0, 4.0)
```
`Mat4x4 * Vec4` 返回 `Vec4`。
`Mat3x3 * Vec3` 返回 `Vec3`。
非方阵矩阵与向量的乘法：`Mat2x4 * Vec2` 返回 `Vec4`（2 列 × 1 列 = 4 行 × 1 列）。

**场景：行向量乘矩阵**
```
let v = Vec4<Float32, PackedHighp>(1.0, 2.0, 3.0, 4.0)
let m = Mat4x4<Float32, PackedHighp>(Float32(1.0))
let result = v * m  // 返回 Vec4，结果 = dot(v, m[0]), dot(v, m[1]), dot(v, m[2]), dot(v, m[3])
```
`Vec4 * Mat4x4` 返回 `Vec4`（1×4 行向量 × 4×4 矩阵 = 1×4 行向量）。

### 4.3 矩阵-矩阵乘法场景

**场景：方阵乘法**
```
let a = Mat4x4<Float32, PackedHighp>(Float32(2.0))
let b = Mat4x4<Float32, PackedHighp>(Float32(3.0))
let c = a * b  // 标准 4x4 矩阵乘法
```
方阵乘法在非 SIMD 路径下采用逐列展开的分量内积实现（直接分量运算，不依赖桩函数）。

**场景：跨维度矩阵乘法**
```
let a = Mat2x4<Float32, PackedHighp>(...)  // 2 列 4 行
let b = Mat4x2<Float32, PackedHighp>(...)  // 4 列 2 行
let c = a * b  // Mat2x4 × Mat4x2 = Mat2x2? 不，Mat<2,4> × Mat<4,2>:
                // 左矩阵列数=2，右矩阵行数=4，要求 2==4? 不匹配!
                // 正确：Mat<C1,R1> × Mat<C2,R2> 要求 C1 == R2
                // Mat<2,4> 列数=2，Mat<4,2> 行数=4，2≠4，不能乘!
// 正确示例：
let a2 = Mat4x4<Float32, PackedHighp>(...)
let b2 = Mat4x2<Float32, PackedHighp>(...)  
let c2 = a2 * b2  // Mat<4,4> × Mat<4,2> 要求 4==4(左列数==右行数), 结果 = Mat<4,2>
                  // 返回类型 = Mat4x2
```
跨维度乘法重载覆盖所有满足 `C(左) == R(右)` 的维度组合。每个矩阵类型定义与其兼容的所有右操作数矩阵类型的 `operator*` 重载。

### 4.4 跨类型构造场景

**场景：从 `Float32` 矩阵构造 `Float64` 矩阵**
```
let m32 = Mat4x4<Float32, PackedHighp>(Float32(1.0))
let m64 = Mat4x4<Float64, PackedHighp>(m32)  // 每元素 Float32→Float64 转换
```

**场景：从 `Mat2x2` 构造 `Mat4x4`（上三角扩展）**
```
let m22 = Mat2x2<Float32, PackedHighp>(...)  // 2×2 矩阵
let m44 = Mat4x4<Float32, PackedHighp>(m22) // 左上 2×2 保留，右下填充 T(1)
```

### 4.5 比较场景

**场景：精确相等比较**
```
let m1 = Mat4x4<Float32, PackedHighp>(Float32(1.0))
let m2 = Mat4x4<Float32, PackedHighp>(Float32(1.0))
let eq = (m1 == m2)  // true
```

**场景：不等比较**
```
let m1 = Mat4x4<Float32, PackedHighp>(Float32(1.0))
let m2 = Mat4x4<Float32, PackedHighp>(Float32(2.0))
let neq = (m1 != m2)  // true
```

---

## 5. 错误处理策略

与阶段一保持一致：

- **构造错误**：不通过运行时错误处理。无默认构造函数意味着所有构造必须显式提供有效值。标量填充构造和列向量构造不涉及运行时错误。
- **下标越界**：`operator []` 在 `Debug` 模式下通过 `assert(i >= 0 && i < length())` 检查边界。`Release` 模式下不做检查（由调用方保证索引有效性）。
- **数学错误**：除零发生在浮点类型时产生 `Infinity`，整数类型时抛 `ArithmeticException`。矩阵除法（`/`）对不可逆矩阵的行为由 `inverse()` 桩函数决定（本阶段为 stub，返回未定义值）。
- **溢出**：整数矩阵算术运算符标注 `@OverflowWrapping`，溢出执行 wrapping 语义而非抛异常。浮点运算溢出产生 `Infinity`。

---

## 6. 并发设计

本阶段延续阶段一的设计——所有矩阵类型均为不可变值类型（struct 值语义），无共享可变状态。所有运算操作返回新矩阵副本而非修改原矩阵。因此不存在数据竞争问题，无需额外的并发保护机制。

`increment()`/`decrement()` 为 `mut` 函数，但应在单线程上下文中使用，或在调用方保证的互斥上下文中使用。

---

## 7. 设计决策

### D-01：列主序命名成员 vs 数组存储

**决策**：使用 `var c0: VecN<T,Q>`、`var c1: VecN<T,Q>` 等命名成员，而非 `VArray<VecN<T,Q>, $N>` 数组。

**理由**：
- 仓颉泛型结构体不支持编译期大小固定的原生数组。
- `VArray<T, $N>` 要求 `$N` 为固定数值字面量，无法参数化——9 个矩阵类型需要不同的 N 值，只能各自硬编码。
- 命名成员方式类型安全：`m.c0` 在编译期即确定类型，无运行时类型检查开销。
- 数组方式需要通过 `VArray` 的 `size` 属性和运行时索引访问，增加开销。
- C++ GLM 使用 `col_type value[C]` C 数组成员，在仓颉中最直接的等价就是命名成员。

### D-02：列向量数量编码在类型中而非运行时

**决策**：`Mat2x2`、`Mat3x3`、`Mat4x4` 等为独立的泛型结构体，而非使用列数/行数参数化的单一模板。

**理由**：
- 仓颉不支持偏特化，无法通过 `Mat<C, R, T, Q>` 单模板实现各维度组合的差异化行为。
- 9 个类型虽然代码重复，但模式高度统一，各类型之间的差异仅为成员数量、参数个数和分量运算的次数。
- 与阶段一 Vec 类型的设计策略一致（`Vec1`~`Vec4` 各自独立）。
- 可通过宏生成或代码生成工具（Python 脚本）消除手工重复。

### D-03：列类型使用 `col_type` 作为内部类型别名

**决策**：每个矩阵类型定义 `public type col_type = VecN<T, Q>` 和 `public type row_type = VecM<T, Q>` 类型别名，与 GLM 一致。

**理由**：
- 提高运算符重载的可读性。`operator*` 的返回类型声明为 `col_type` 而非 `VecN<T,Q>`，语义更清晰。
- 与 GLM 的 `typedef vec<C, T, Q> col_type` 模式对齐，降低迁移时的认知成本。
- 在泛型代码中可通过 `col_type` 统一引用列类型，无需硬编码 Vec 名称。

### D-04：桩文件使用 `package glm.detail` 包名

**决策**：三个桩文件（`common.cj`、`matrix.cj`、`geometric.cj`）位于 `detail/` 目录下，声明 `package glm.detail`。

**理由**：
- 与阶段一所有实现文件使用相同的包名。
- 方阵类型的 `.inl` 实现中对桩函数的引用是同包间调用，无需 `import` 语句。
- 在阶段四完整实现替换桩文件时，只需替换文件内容（保持包名和目录路径不变），无需修改任何 `import` 语句。

### D-05：`const init` 仅在逐元素构造上使用

**决策**：仅逐元素构造函数声明为 `const init`。标量填充构造、列向量构造和跨矩阵转换构造为普通 `init`。

**理由**：
- 逐元素构造的参数全部为同一类型 `T` 的字面值，在编译期上下文中可合法求值。
- 标量填充构造内部需要构造列向量（`VecN(scalar, 0, 0, ...)`），其中零值在泛型 `T` 中的表示方式（`T(0)`）在 `const` 泛型上下文中可能不可用。
- 跨类型转换构造涉及 `T(v2)` 类型转换，不能在 `const` 上下文中保证求值。
- 此策略与阶段一 Vec 类型的 `const init` 使用范围一致。

### D-06：跨维度矩阵构造的填充语义

**决策**：从小矩阵扩展到大矩阵时，左侧上角子块保留，剩余元素按单位矩阵模式填充（对角线 `T(1)`，非对角线 `T(0)`）。此行为与 C++ GLM 一致。

**理由**：
- GLM 的 `mat4x4(mat2x2)` 构造采用同一填充语义。
- 从 `Mat2x2` 到 `Mat3x3` 的扩展将右下填充为 `T(1)`（新的第 2 行第 2 列元素为 1），保持了"将小矩阵嵌入大矩阵的单位矩阵视图"的直观语义。
- 此填充规则与阶段一的 `castVecN` 的"重复最后一个分量"策略不同——矩阵有明确的线性代数填充约定，向量则有 GLSL 规范的填充约定。

### D-07：矩阵未实现 `%` 运算符和位运算符

**决策**：矩阵类型不提供 `%`（取模）运算符和位运算符（`&`、`|`、`^`、`<<`、`>>`）。

**理由**：
- C++ GLM 矩阵类型同样不提供这些运算符。
- 矩阵是浮点密集型运算的首要目标类型（线性代数、坐标变换），取模和位运算在矩阵上的使用场景极少。
- 减少运算符重载数量可降低编译时间和代码复杂度。

### D-08：标量-矩阵 `scalar op matrix` 通过非成员运算符实现

**决策**：`s + m`、`s * m` 等标量在矩阵左侧的运算符通过非成员运算符函数实现（`operator func +(s: T, m: MatCxR<T,Q>)`）。

**理由**：
- 与阶段一 Vec 类型的实现策略一致——标量在左的运算符无法作为被操作矩阵类型的成员函数定义。
- 非成员运算符定义在 `package glm.detail` 中的各矩阵类型文件末尾，与同维度的矩阵-矩阵运算符并列。
- 由于仓颉不支持类型上添加非成员运算符的实现，这些函数与矩阵类型定义在同一文件中。

### D-09：`glm` 包的 `ext/` 目录使用独立文件

**决策**：`ext/` 下的每个别名文件独立存在（如 `matrix_float4x4.cj`），不合并为单文件。

**理由**：
- 与 GLM 的 `ext/` 目录结构保持一致，方便对标。
- 下游使用者可按需 `import` 特定文件，避免导入全部别名导致的编译时间增加。
- 每个文件仅 3-5 行，维护成本低，可由脚本生成。

### D-10：非方阵矩阵的 `operator*=(m)` 不做实现

**决策**：非方阵矩阵（`Mat2x3`/`Mat2x4`/`Mat3x2`/`Mat3x4`/`Mat4x2`/`Mat4x3`）的复合赋值乘法 `*=(m)` 不实现。

**理由**：
- C++ GLM 中非方阵矩阵的 `operator*=` 仅在 `*=scalar` 和 `*=/=` 标量版本上定义，无 `*=(matrix)` 版本——因为矩阵乘法结果维度改变，非方阵无法原地赋值。
- 在 GLM 源码中，`type_mat2x4.hpp:89-91` 仅定义了 `*=(U s)` 和 `/=(U s)`（标量版本），无 `*=(mat<...>)`。`type_mat2x2.hpp:86-88` 和 `type_mat3x3.hpp:93-95` 等方阵类型才定义了 `*=(mat<...>)` 版本。
- 仓颉自动从二元 `operator*` 生成复合赋值版本仅在返回类型与左操作数类型匹配时成立。当 `operator*` 返回的矩阵类型不同于 `this` 的类型时（非方阵乘法场景），编译器不会自动生成复合赋值版本——也不需要。
- `Mat2x2`/`Mat3x3`/`Mat4x4` 的 `*=(matrix)` 由编译器从二元 `operator*`（返回同类型）自动生成。

---

## 8. 设计决策总结

| 编号 | 决策 | 类型 | 影响范围 |
|------|------|------|---------|
| D-01 | 命名列成员而非数组存储 | 存储布局 | 所有 9 个矩阵类型 |
| D-02 | 独立泛型结构体而非维度参数化模板 | 类型形态 | 所有 9 个矩阵类型 |
| D-03 | 内部 `col_type`/`row_type` 类型别名 | 代码组织 | 所有 9 个矩阵类型 |
| D-04 | 桩文件使用 `package glm.detail` | 包结构 | 3 个桩文件 |
| D-05 | `const init` 仅逐元素构造 | 构造策略 | 所有 9 个矩阵类型 |
| D-06 | 小→大矩阵扩展填充单位矩阵 | 构造语义 | 异构矩阵转换 |
| D-07 | 矩阵不提供 `%` 和位运算 | 运算符范围 | 所有 9 个矩阵类型 |
| D-08 | 标量-矩阵左乘为非成员运算符 | 运算符实现模式 | 所有 9 个矩阵类型 |
| D-09 | `ext/` 使用独立别名文件 | 代码组织 | `ext/` 目录 |
| D-10 | 非方阵矩阵无 `*=(matrix)` | 运算符范围 | 6 个非方阵类型 |
