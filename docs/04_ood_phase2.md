# GLM 1.0.3 仓颉迁移阶段二 OOD 设计方案

> **修订日期**：2026-06-23

---

## 1. 概述

### 设计目标

在阶段一（Vec1~Vec4 向量类型 + 基础设施）的基础上，迁移全部 9 个矩阵类型及关联别名，使库具备二维/三维/四维矩阵的数学表达能力。矩阵类型以列向量为内部数据成员，与 GLM 的列主序（column-major）存储约定一致。

### 核心抽象

| 抽象 | 角色 | 类型形态 |
|------|------|---------|
| Mat2x2<T,Q> / Mat2x3<T,Q> / ... / Mat4x4<T,Q> | 表示 C×R 数学矩阵的值对象 | 泛型结构体 |
| common.cj（stub） | 基础数学函数库占位 | stub 文件 |
| matrix.cj（混合型：27 个可直接实现 + 6 个 stub） | 矩阵运算函数库——27 个可直接实现的重载（transpose/matrixCompMult/outerProduct 各 9 个）和 6 个 stub 空壳重载（determinant/inverse 各 3 个）。区别于纯 stub 文件（common.cj/geometric.cj），可在第一阶段编码 | 混合型文件 |
| geometric.cj（stub） | 几何函数库占位 | stub 文件 |

**类型关系说明**：每个矩阵类型以 VecN<T,Q> 为列向量成员——例如 Mat2x2<T,Q> 的列向量为 Vec2<T,Q>、行向量为 Vec2<T,Q>。各矩阵的列向量类型和行向量类型由矩阵尺寸唯一确定（详见第 2 节映射表），在设计中直接使用具体的 VecN<T,Q> 类型而非类型别名，与阶段一 Vec 类型"使用处直接引用具体 Vec 类型"的风格一致。

### 整体架构思路

沿用阶段一的双层包结构：glm.detail 包含全部 9 个矩阵泛型结构体定义和运算符重载，glm 包通过类型别名暴露常用具现化。矩阵类型以列向量为数据成员（var c0: VecN<T,Q>, var c1: VecN<T,Q>, ...），每个矩阵是一个独立的泛型结构体（而非 C×R 参数化的单一模板），与阶段一 Vec 类型的设计策略一致。

### 系统性设计约束：泛型上下文中 T(0)/T(1) 的获取问题

本设计的多个构造函数和工厂函数面临同一个根因限制：**仓颉无约束泛型参数不支持 `T(0)/T(1)` 构造调用，且 `Number<T>` 接口也不提供 `T(n)` 构造声明**（与 deviations.md DV-01 记录的限制完全一致）。即使添加 `Number<T>` 约束，也仅能通过运算获得 T(0)（`someValue - someValue`），但 **`Number<T>` 约束下无法演算出 T(1)**——`!`（按位取反）运算符属于 `Integer<T>` 接口而非 `Number<T>` 接口，对 Float32/Float64 类型不可用；而阶段一 `increment()` 的 `!` 演算模式仅能工作在 `Integer<T>` 约束上下文中。

因此，本设计对需要 T(0)/T(1) 的功能统一采用以下策略：
- **T(0) 的获取**：在 `Number<T>` 约束的 extend 块中，通过 `someValue - someValue` 演算（`someValue` 可来自构造参数或已有实例的分量）
- **T(1) 的获取**：必须由调用方显式传入参数（`one: T`），因为在 `Number<T>` 约束上下文中不存在通用的演算路径
- **T(0) 和 T(1) 均需的 extend 块**：T(0) 通过运算演算，T(1) 通过参数传入

此统一策略适用于本设计中所有需要 T(0)/T(1) 的场景：`identity()` 工厂函数、`diagonal(scalar: T)` 工厂函数、跨矩阵类型转换工厂函数。

---

## 2. 模块划分

### 包组织

```
package glm.detail          — 核心实现层（新增/修改文件以 ★ 标记）
  ├── type_mat2x2.cj ★     — Mat2x2<T,Q> 结构体定义 + extend 块中的运算符（含 Mat×Vec 成员运算符）
  ├── type_mat2x3.cj ★     — Mat2x3<T,Q>（含 Mat×Vec 成员运算符）
  ├── type_mat2x4.cj ★     — Mat2x4<T,Q>（含 Mat×Vec 成员运算符）
  ├── type_mat3x2.cj ★     — Mat3x2<T,Q>（含 Mat×Vec 成员运算符）
  ├── type_mat3x3.cj ★     — Mat3x3<T,Q>（含 Mat×Vec 成员运算符）
  ├── type_mat3x4.cj ★     — Mat3x4<T,Q>（含 Mat×Vec 成员运算符）
  ├── type_mat4x2.cj ★     — Mat4x2<T,Q>（含 Mat×Vec 成员运算符）
  ├── type_mat4x3.cj ★     — Mat4x3<T,Q>（含 Mat×Vec 成员运算符）
  ├── type_mat4x4.cj ★     — Mat4x4<T,Q>（含 Mat×Vec 成员运算符）
  │
  │  每个矩阵类型在其 extend 块中定义一个标准列向量乘法成员运算符 `operator*(v: VecC<T,Q>): VecR<T,Q>`，
  │  其中 C 为矩阵列数（输入列向量维数），R 为矩阵行数（输出列向量维数）。完整签名如下：
  │
  │  | 矩阵类型 | 运算符签名 | 结果向量类型 |
  │  |---------|-----------|------------|
  │  | Mat2x2<T,Q> | `operator func *(v: Vec2<T,Q>): Vec2<T,Q>` | Vec2<T,Q> |
  │  | Mat2x3<T,Q> | `operator func *(v: Vec2<T,Q>): Vec3<T,Q>` | Vec3<T,Q> |
  │  | Mat2x4<T,Q> | `operator func *(v: Vec2<T,Q>): Vec4<T,Q>` | Vec4<T,Q> |
  │  | Mat3x2<T,Q> | `operator func *(v: Vec3<T,Q>): Vec2<T,Q>` | Vec2<T,Q> |
  │  | Mat3x3<T,Q> | `operator func *(v: Vec3<T,Q>): Vec3<T,Q>` | Vec3<T,Q> |
  │  | Mat3x4<T,Q> | `operator func *(v: Vec3<T,Q>): Vec4<T,Q>` | Vec4<T,Q> |
  │  | Mat4x2<T,Q> | `operator func *(v: Vec4<T,Q>): Vec2<T,Q>` | Vec2<T,Q> |
  │  | Mat4x3<T,Q> | `operator func *(v: Vec4<T,Q>): Vec3<T,Q>` | Vec3<T,Q> |
  │  | Mat4x4<T,Q> | `operator func *(v: Vec4<T,Q>): Vec4<T,Q>` | Vec4<T,Q> |
  ├── common.cj ★           — stub（仅函数签名空壳，供 type_mat3x3/type_mat4x4 依赖闭合）
   ├── matrix.cj ★           — 混合型文件：27 个可直接实现的重载（transpose/matrixCompMult/outerProduct 各 9 个）+ 6 个 stub 空壳重载（determinant/inverse 各 3 个，函数体 throw Exception("stub")）。区别于纯 stub 文件（common.cj/geometric.cj），其 27 个可编译实现不依赖其他 stub 文件。供 type_mat2x2/type_mat3x3/type_mat4x4 依赖闭合
  ├── geometric.cj ★        — stub（仅函数签名空壳，供 type_mat4x4 依赖闭合）
  ├── scalar_mat_ops.cj ★   — 标量-矩阵运算全局具名函数（add、sub、mul、div），处理 T + Mat 等标量左侧运算
  │                          （与 scalar_vec_ops.cj 同属 glm.detail，通过参数类型重载区分）
  │                          注意：此文件不包含 mod 函数（矩阵取模无数学意义，GLM 也未为矩阵类型定义 % 运算符）
   └── type_vecN.cj（修改）★  — Vec1~Vec4 各新增行向量×矩阵成员运算符 `Vec{R} * Mat{C}x{R}` extend 块，具体签名如下：
      - **Vec4 extend 块**（R=4，可乘行数=4 的矩阵：Mat2x4/Mat3x4/Mat4x4）：
        - `operator func *(m: Mat2x4<T,Q>): Vec2<T,Q>`（结果列数 C=2）
        - `operator func *(m: Mat3x4<T,Q>): Vec3<T,Q>`（结果列数 C=3）
        - `operator func *(m: Mat4x4<T,Q>): Vec4<T,Q>`（结果列数 C=4）
      - **Vec3 extend 块**（R=3，可乘行数=3 的矩阵：Mat2x3/Mat3x3/Mat4x3）：
        - `operator func *(m: Mat2x3<T,Q>): Vec2<T,Q>`
        - `operator func *(m: Mat3x3<T,Q>): Vec3<T,Q>`
        - `operator func *(m: Mat4x3<T,Q>): Vec4<T,Q>`
      - **Vec2 extend 块**（R=2，可乘行数=2 的矩阵：Mat2x2/Mat3x2/Mat4x2）：
        - `operator func *(m: Mat2x2<T,Q>): Vec2<T,Q>`
        - `operator func *(m: Mat3x2<T,Q>): Vec3<T,Q>`
        - `operator func *(m: Mat4x2<T,Q>): Vec4<T,Q>`
      - **Vec1 extend 块**（R=1）：无有效矩阵乘法目标（本阶段未定义行数=1 的矩阵类型），不新增运算符

package glm                 — 公共 API 面 + 别名层（修改文件以 ★ 标记）
  ├── lib.cj ★              — 新增矩阵类型的 public import
  └── fwd.cj ★              — 新增矩阵类型别名

package glm.ext             — 具现化别名文件（新增目录和文件，以 ★ 标记）
  ├── matrix_float2x2.cj ★
  ├── matrix_float2x3.cj ★
  ├── ...
  ├── matrix_float4x4.cj ★
  ├── matrix_double2x2.cj ★
  ├── ...
  ├── matrix_double4x4.cj ★
  ├── vector_float1.cj ~ vector_float4.cj ★
  └── vector_double1.cj ~ vector_double4.cj ★
```

### 矩阵类型概览（9 个）

各矩阵类型的列向量类型和行向量类型由矩阵尺寸唯一确定。使用处直接引用具体的 VecN<T,Q> 类型：

| 类型 | 列向量类型 | 列数 | 行向量类型 | 转置目标 |
|------|-----------|------|-----------|---------|
| Mat2x2<T,Q> | Vec2<T,Q> | 2 | Vec2<T,Q> | Mat2x2<T,Q> |
| Mat2x3<T,Q> | Vec3<T,Q> | 2 | Vec2<T,Q> | Mat3x2<T,Q> |
| Mat2x4<T,Q> | Vec4<T,Q> | 2 | Vec2<T,Q> | Mat4x2<T,Q> |
| Mat3x2<T,Q> | Vec2<T,Q> | 3 | Vec3<T,Q> | Mat2x3<T,Q> |
| Mat3x3<T,Q> | Vec3<T,Q> | 3 | Vec3<T,Q> | Mat3x3<T,Q> |
| Mat3x4<T,Q> | Vec4<T,Q> | 3 | Vec3<T,Q> | Mat4x3<T,Q> |
| Mat4x2<T,Q> | Vec2<T,Q> | 4 | Vec4<T,Q> | Mat2x4<T,Q> |
| Mat4x3<T,Q> | Vec3<T,Q> | 4 | Vec4<T,Q> | Mat3x4<T,Q> |
| Mat4x4<T,Q> | Vec4<T,Q> | 4 | Vec4<T,Q> | Mat4x4<T,Q> |

### 模块间依赖

```
glm.detail（同包直接可见）
  type_mat{N}x{M} → type_vec{N}, type_vec{M}（列/行向量类型）
  type_mat2x2.cj 中 .inl 编排 → matrix.cj（stub）
  type_mat3x3.cj 中 .inl 编排 → matrix.cj, common.cj（stub）
  type_mat4x4.cj 中 .inl 编排 → matrix.cj, geometric.cj（stub）
  scalar_mat_ops.cj → type_mat{N}x{M}（为 9 个矩阵类型各提供标量左侧全局运算函数）
  其余 6 个非方阵文件 → 无函数库依赖

glm
  fwd.cj → glm.detail 矩阵类型 + Vec 类型
  lib.cj → glm.detail 矩阵类型

glm.ext
  各别名文件 → glm.detail 矩阵类型/向量类型
```

### ext/ 别名文件的包名策略

本设计选择 **Option 1**：src/ext/ 下文件声明 package glm.ext，通过 import glm.detail.* 访问 glm.detail 包中的核心类型。

### cjpm 子包构建预验证 — 增强方案

**背景**：src/ext/ + package glm.ext 的构建可行性取决于 cjpm 对子包的发现机制。仓颉包声明规则要求"目录名须与包名匹配"（参见 package/README.md §2.1），src/ext/ 对应 package glm.ext 的路由机制依赖于 cjpm 的包发现策略——是否自动扫描 src/ 下所有子目录并按目录层级映射为子包，需通过原型验证确认。

**方案一（首选）：src/ext/ → package glm.ext**。最规范，需通过原型验证确认 cjpm 支持。

**方案二（备选冲突风险评估）**：将 ext/ 文件移至 src/ 根目录并声明 package glm。冲突风险分析如下：

| 冲突场景 | 风险等级 | 分析 |
|---------|---------|------|
| `Mat4x4`（PascalCase fwd.cj 别名）vs `mat4x4`（camelCase 别名） | ✅ 无冲突 | 仓颉类型名区分大小写，同一包内可共存 |
| `mat4`（方阵短别名）vs 同名声明 | ✅ 无冲突 | 仅需确保一处定义（fwd.cj 或 scp 文件），不重复 |
| `detail.Mat4x4<...>`（detail 包中的泛型结构体）vs package glm 中的 type 别名 | ✅ 无冲突 | 不同包（glm vs glm.detail），名称空间隔离 |
| 同一包内同名 type 别名重复定义 | ⚠️ 需避免 | 须确保 ext/ 别名不从 fwd.cj 已定义的别名重复。推荐：fwd.cj 集中定义全部别名，ext/ 文件仅做 import + re-export |

**方案三（第三备选）：独立 cjpm 子模块**。若方案一不可行且方案二的冲突管理不可接受，可将 ext/ 放到独立子模块中通过 workspace 或 dependency 引用。

**原型验证计划（编码启动首日）**：
1. 在 src/ext/ 下创建最小测试文件 `test_ext.cj`，声明 `package glm.ext`，引用 glm.detail 中的类型
2. 运行 `cjpm build`，确认编译通过
3. 若通过，进一步验证外部项目 `import glm.ext.test_ext.{ test_alias }` 可解析
4. 若失败，将测试文件移至 src/ 根目录改为 `package glm`，验证别名与 fwd.cj 不冲突
5. 若方案二也失败，采用方案三

**cjpm.toml 配置**：当前配置 `src-dir = "src"`。若子目录未被自动扫描，需通过 `package-configuration` 或手动配置子包发现。

---

## 3. 核心抽象

### 3.1 矩阵结构体

**角色**：表示 C×R 数学矩阵的值对象。每个矩阵类型是独立泛型结构体，以列向量为数据成员，采用列主序（column-major）存储。

**职责**：
- 承载 C 个列向量数据成员（var c0: VecR<T,Q>、var c1: VecR<T,Q> 等，其中 R = 行数）
- 提供编译期查询函数 public static func length(): Int64 返回列数 C
- 提供下标运算符 [](i: Int64) 访问列向量（取值 + 赋值双版本）
- 提供逐分量构造函数和向量列构造函数
- 通过 @Derive[Hashable] 自动派生哈希支持

**为何采用 struct（值类型）而非 class（引用类型）**：与阶段一 Vec 类型一致——矩阵是数学计算中的值对象，值语义确保运算符返回新实例、无副作用，便于测试和函数式组合。

**为何 9 个独立结构体而非统一泛型**：仓颉不支持模板偏特化，无法实现 Mat<C, R, T, Q> 泛型后在 .inl 中按 C/R 参数分别特化。

### 3.2 类型映射关系

矩阵类型与列向量/行向量的对应关系是固定的编译期映射，不定义为类型别名。使用处直接引用具体的 VecN<T,Q> 类型，与阶段一 Vec 类型风格一致。

### 3.3 构造函数体系

每个矩阵类型提供以下构造函数和工厂函数：

1. **逐分量同类型构造** — const init 可用，纯赋值，参数为 C×R 个 T 类型标量，按列主序排列。各矩阵类型完整签名如下：

   | 矩阵类型 | 参数序列（列主序） |
   |---------|-----------------|
   | Mat2x2<T,Q> | `(a00: T, a01: T, a10: T, a11: T)` — 4 参数，2 列 × 2 行 |
   | Mat2x3<T,Q> | `(a00: T, a01: T, a02: T, a10: T, a11: T, a12: T)` — 6 参数，2 列 × 3 行 |
   | Mat2x4<T,Q> | `(a00: T, a01: T, a02: T, a03: T, a10: T, a11: T, a12: T, a13: T)` — 8 参数，2 列 × 4 行 |
   | Mat3x2<T,Q> | `(a00: T, a01: T, a10: T, a11: T, a20: T, a21: T)` — 6 参数，3 列 × 2 行 |
   | Mat3x3<T,Q> | `(a00: T, a01: T, a02: T, a10: T, a11: T, a12: T, a20: T, a21: T, a22: T)` — 9 参数，3 列 × 3 行 |
   | Mat3x4<T,Q> | `(a00: T, a01: T, a02: T, a03: T, a10: T, a11: T, a12: T, a13: T, a20: T, a21: T, a22: T, a23: T)` — 12 参数，3 列 × 4 行 |
   | Mat4x2<T,Q> | `(a00: T, a01: T, a10: T, a11: T, a20: T, a21: T, a30: T, a31: T)` — 8 参数，4 列 × 2 行 |
   | Mat4x3<T,Q> | `(a00: T, a01: T, a02: T, a10: T, a11: T, a12: T, a20: T, a21: T, a22: T, a30: T, a31: T, a32: T)` — 12 参数，4 列 × 3 行 |
   | Mat4x4<T,Q> | `(a00: T, a01: T, a02: T, a03: T, a10: T, a11: T, a12: T, a13: T, a20: T, a21: T, a22: T, a23: T, a30: T, a31: T, a32: T, a33: T)` — 16 参数，4 列 × 4 行 |

   参数命名约定 `a{列}{行}` 与 §3.3 item 4 fromParts 的命名风格一致（列主序排列），且与 fromParts 共享相同的参数排列逻辑——区别仅在于 fromParts 支持跨类型（conv 闭包），而本构造为同类型（参数类型即为 T）。

2. **列向量构造** — const init 可用，纯赋值，参数为 C 个列向量，每个列向量类型为 VecR<T,Q>。各矩阵类型完整签名如下：

   | 矩阵类型 | 参数序列 |
   |---------|---------|
   | Mat2x2<T,Q> | `(c0: Vec2<T,Q>, c1: Vec2<T,Q>)` |
   | Mat2x3<T,Q> | `(c0: Vec3<T,Q>, c1: Vec3<T,Q>)` |
   | Mat2x4<T,Q> | `(c0: Vec4<T,Q>, c1: Vec4<T,Q>)` |
   | Mat3x2<T,Q> | `(c0: Vec2<T,Q>, c1: Vec2<T,Q>, c2: Vec2<T,Q>)` |
   | Mat3x3<T,Q> | `(c0: Vec3<T,Q>, c1: Vec3<T,Q>, c2: Vec3<T,Q>)` |
   | Mat3x4<T,Q> | `(c0: Vec4<T,Q>, c1: Vec4<T,Q>, c2: Vec4<T,Q>)` |
   | Mat4x2<T,Q> | `(c0: Vec2<T,Q>, c1: Vec2<T,Q>, c2: Vec2<T,Q>, c3: Vec2<T,Q>)` |
   | Mat4x3<T,Q> | `(c0: Vec3<T,Q>, c1: Vec3<T,Q>, c2: Vec3<T,Q>, c3: Vec3<T,Q>)` |
   | Mat4x4<T,Q> | `(c0: Vec4<T,Q>, c1: Vec4<T,Q>, c2: Vec4<T,Q>, c3: Vec4<T,Q>)` |

   参数 c0~c{C-1} 按列顺序排列，与底层列向量数据成员 `var c0: VecR<T,Q>` 至 `var c_{C-1}: VecR<T,Q>` 一一对应。与 item 5 fromColumns 的区别在于本构造为同类型（列向量类型即为 VecR<T,Q>），而 fromColumns 支持跨类型（conv 闭包将 VecR<U,P> 转换为 VecR<T,Q>）。
3. **对角矩阵构造 diagonal(scalar: T)** — extend 块工厂函数，Number<T> 约束，非 const。对**所有 9 个矩阵类型**均提供（包括方阵和非方阵），与 GLM 1.0.3 对所有 9 个 `mat(C,R,T,Q)` 类型均提供 `mat(T s)` 构造函数一致。对角填充：对角线元素使用 scalar，非对角线元素使用 T(0) = scalar - scalar。例如 `diagonal(1.0f)` 在 Mat3x2<Float32,PackedHighp> 上产生：
    ```
    [1.0  0.0  0.0]
    [0.0  1.0  0.0]
    ```
    即列向量表示为 `c0=Vec2(1.0,0.0), c1=Vec2(0.0,1.0), c2=Vec2(0.0,0.0)`，满足列主序（C=3 列 × R=2 行）。命名 `diagonal` 明确表明该函数产生对角矩阵而非全填充矩阵，避免名称误导。（Bool 矩阵不提供此操作，见 D33）
4. **跨类型逐分量构造 fromParts(conv, ...)** — extend 块工厂函数，仅 Qualifier 约束，非 const。参数按列主序排列，共 C×R 个分量（C=列数，R=行数）。各矩阵类型完整签名如下（类型参数 `P` 在 fromParts 中无需使用，与 fromColumns 不同——fromColumns 中 `P` 用于列向量的 Qualifier 参数）：

   | 矩阵类型 | 签名示例 |
   |---------|---------|
   | Mat2x2<T,Q> | `public static func fromParts<U>(conv: (U) -> T, a00: U, a01: U, a10: U, a11: U): Mat2x2<T,Q> where Q <: Qualifier` |
   | Mat2x3<T,Q> | `public static func fromParts<U>(conv: (U) -> T, a00: U, a01: U, a02: U, a10: U, a11: U, a12: U): Mat2x3<T,Q> where Q <: Qualifier` |
   | Mat2x4<T,Q> | `public static func fromParts<U>(conv: (U) -> T, a00: U, a01: U, a02: U, a03: U, a10: U, a11: U, a12: U, a13: U): Mat2x4<T,Q> where Q <: Qualifier` |
   | Mat3x2<T,Q> | `public static func fromParts<U>(conv: (U) -> T, a00: U, a01: U, a10: U, a11: U, a20: U, a21: U): Mat3x2<T,Q> where Q <: Qualifier` |
   | Mat3x3<T,Q> | `public static func fromParts<U>(conv: (U) -> T, a00: U, a01: U, a02: U, a10: U, a11: U, a12: U, a20: U, a21: U, a22: U): Mat3x3<T,Q> where Q <: Qualifier` |
   | Mat3x4<T,Q> | `public static func fromParts<U>(conv: (U) -> T, a00: U, a01: U, a02: U, a03: U, a10: U, a11: U, a12: U, a13: U, a20: U, a21: U, a22: U, a23: U): Mat3x4<T,Q> where Q <: Qualifier` |
   | Mat4x2<T,Q> | `public static func fromParts<U>(conv: (U) -> T, a00: U, a01: U, a10: U, a11: U, a20: U, a21: U, a30: U, a31: U): Mat4x2<T,Q> where Q <: Qualifier` |
   | Mat4x3<T,Q> | `public static func fromParts<U>(conv: (U) -> T, a00: U, a01: U, a02: U, a10: U, a11: U, a12: U, a20: U, a21: U, a22: U, a30: U, a31: U, a32: U): Mat4x3<T,Q> where Q <: Qualifier` |
   | Mat4x4<T,Q> | `public static func fromParts<U>(conv: (U) -> T, a00: U, a01: U, a02: U, a03: U, a10: U, a11: U, a12: U, a13: U, a20: U, a21: U, a22: U, a23: U, a30: U, a31: U, a32: U, a33: U): Mat4x4<T,Q> where Q <: Qualifier` |

   参数命名约定 `a{列}{行}`：例如 Mat2x3 的参数序列为 `a00,a01,a02`（列 0 三行）、`a10,a11,a12`（列 1 三行），与 GLM 1.0.3 type_mat2x3.inl L45-52 的列主序构造函数签名一致。此命名约定与 GLM 源码中 `{x,y,z,w}{列}` 的参数名风格不同（GLM 使用 `x0,y0,z0,w0,x1,y1,...` 模式），但二者映射关系直接：`a{col}{row}` 等价于 GLM 的 `{x,y,z,w}{col}`（其中 `x=a{col}0, y=a{col}1, z=a{col}2, w=a{col}3`）。例如 fromParts 参数 `(a00: U, a01: U, a10: U, a11: U)` 对应 GLM 构造函数 `(x0, y0, x1, y1)`。

5. **跨类型列向量构造 fromColumns(conv, ...)** — extend 块工厂函数，仅 Qualifier 约束，非 const。参数为 C 个列向量，每个列向量类型为 VecR<U,P>。各矩阵类型的完整签名示例如下（仅 Mat2x2 写出完整 where 子句，其余 8 个约束同前）：

| 矩阵类型 | 签名示例 |
|---------|---------|
| Mat2x2<T,Q> | `public static func fromColumns<U, P>(conv: (U) -> T, c0: Vec2<U,P>, c1: Vec2<U,P>): Mat2x2<T,Q> where Q <: Qualifier, P <: Qualifier` |
| Mat2x3<T,Q> | `public static func fromColumns<U, P>(conv: (U) -> T, c0: Vec3<U,P>, c1: Vec3<U,P>): Mat2x3<T,Q>`（约束同前） |
| Mat2x4<T,Q> | `public static func fromColumns<U, P>(conv: (U) -> T, c0: Vec4<U,P>, c1: Vec4<U,P>): Mat2x4<T,Q>`（约束同前） |
| Mat3x2<T,Q> | `public static func fromColumns<U, P>(conv: (U) -> T, c0: Vec2<U,P>, c1: Vec2<U,P>, c2: Vec2<U,P>): Mat3x2<T,Q>`（约束同前） |
| Mat3x3<T,Q> | `public static func fromColumns<U, P>(conv: (U) -> T, c0: Vec3<U,P>, c1: Vec3<U,P>, c2: Vec3<U,P>): Mat3x3<T,Q>`（约束同前） |
| Mat3x4<T,Q> | `public static func fromColumns<U, P>(conv: (U) -> T, c0: Vec4<U,P>, c1: Vec4<U,P>, c2: Vec4<U,P>): Mat3x4<T,Q>`（约束同前） |
| Mat4x2<T,Q> | `public static func fromColumns<U, P>(conv: (U) -> T, c0: Vec2<U,P>, c1: Vec2<U,P>, c2: Vec2<U,P>, c3: Vec2<U,P>): Mat4x2<T,Q>`（约束同前） |
| Mat4x3<T,Q> | `public static func fromColumns<U, P>(conv: (U) -> T, c0: Vec3<U,P>, c1: Vec3<U,P>, c2: Vec3<U,P>, c3: Vec3<U,P>): Mat4x3<T,Q>`（约束同前） |
| Mat4x4<T,Q> | `public static func fromColumns<U, P>(conv: (U) -> T, c0: Vec4<U,P>, c1: Vec4<U,P>, c2: Vec4<U,P>, c3: Vec4<U,P>): Mat4x4<T,Q>`（约束同前） |

6. **跨矩阵类型转换** — 拆分为以下子类，各有完整泛型约束签名。填充规则分为列扩展和行扩展两个子规则：
   - **列扩展规则**：当目标矩阵列数 C 大于源矩阵列数时，新增列 `c_{新列索引}` 在 `(新列索引, 新列索引)` 位置填入 `one`，其余元素填入 `T(0)`。若 `新列索引 ≥ R（目标行数）`，则整列全部为 `T(0)`（因单位矩阵对角线位置超出矩阵范围）。
   - **行扩展规则**：当目标矩阵行数 R 大于源矩阵行数时，新增行中对角线 `(i,i)` 位置（`i` 从 `R_src` 到 `R_dst-1`，且 `i < C`）填入 `one`，其余新增行元素填入 `T(0)`。若 `i ≥ C`（新增行索引超出列数范围），则该行全部为 `T(0)`。
   - **列收缩/行收缩规则**：直接截断（丢弃超出部分）。

   - **6a（同类型不同尺寸）**：源矩阵和目标矩阵元素类型 T 相同，但尺寸和 Qualifier 可不同。需要 T(1) 通过 `one: T` 参数传入，T(0) 通过 `Number<T>` 约束下的 `scalar - scalar` 演算获得。
      - 签名示例（以 Mat2x2<T,SrcQ>→Mat2x3<T,Q> 为例）：`public static func fromMat<SrcQ>(m: Mat2x2<T,SrcQ>, one: T): Mat2x3<T,Q> where T <: Number<T>, Q <: Qualifier, SrcQ <: Qualifier`
      - 适用于尺寸扩展方向（R_src<R_dst 或 C_src<C_dst）、收缩方向（R_src>R_dst 或 C_src>C_dst）以及同尺寸退化情况
      - 支持跨 Qualifier 转换（如 Mat2x2<Float32,PackedLowp>→Mat4x4<Float32,PackedHighp>）
      - **`one: T` 参数语义**：`one` 的类型 `T` 是目标矩阵的元素类型（而非源元素类型）。其值由调用方根据目标矩阵的数值精度选取（如目标为 Float32 时传入 `1.0f`，目标为 Float64 时传入 `1.0`）。若调用方传入 NaN，则对角填充结果将按底层数值运算自然传播 NaN；本设计不额外定义特殊分支处理。此语义与 identity(one: T) 的 `one` 参数一致，均为目标元素类型语境下的单位值。
      - B 类方向（C_src=C_dst, R_src<R_dst）的 GLM .inl 逐项对照分析见下方映射表

   - **6b（跨类型不同尺寸）**：源矩阵元素类型 U 和目标元素类型 T 不同，尺寸和 Qualifier 也可不同。需要 conv 闭包将 U 转换为 T、`one: T` 参数和 `Number<T>` 约束。
      - 签名示例（以 Mat2x2<U,P>→Mat2x3<T,Q> 为例）：`public static func fromMat<U, P>(conv: (U) -> T, m: Mat2x2<U,P>, one: T): Mat2x3<T,Q> where T <: Number<T>, Q <: Qualifier, P <: Qualifier`
      - 填充规则同 6a，额外对每个源元素应用 conv 转换
      - **`one: T` 参数语义**同 6a：`one` 为目标元素类型 T 的值，由调用方根据目标矩阵的数值精度选取。若调用方传入 NaN，则对角填充结果将按底层数值运算自然传播 NaN；本设计不额外定义特殊分支处理

   6a 和 6b 合计产生大量重载签名：9 个目标矩阵类型 × 8 个源矩阵类型（排除同尺寸）× 2 个变体（6a + 6b）= **144 个签名构造量**。编码阶段建议编写代码生成脚本自动产生这 144 个 fromMat 6a/6b 签名模板，减少手动编写带来的抄写错误和维护负担。代码生成脚本应输出**完整的函数体实现**（含 T(0) 演算、列操作/行操作展开逻辑、Mat4x4←Mat4x2 偏差分支），而不仅限于函数签名。6a 与 6b 使用不同的 T(0) 演算路径（6a 使用 `m.c0.x - m.c0.x`，6b 使用 `one - one`），脚本应按变体类型（6a/6b）分别处理。

> **纯收缩方向的 `one` 参数行为**：在纯收缩方向（C_dst ≤ C_src 且 R_dst ≤ R_src，且至少一个严格小于）中，转换仅涉及截断，不需要 T(1) 值，`one` 参数在函数体中被忽略。但签名中保留该参数以保持 API 统一性，避免为 72 个方向设置两套签名体系。在签名注释中标注"纯收缩方向下 `one` 参数被忽略"供调用方参考。使用示例：`let m_shrunk = Mat2x2<Float32, PackedHighp>.fromMat(m4x4, one: 1.0f)` 中 `one: 1.0f` 在纯收缩方向下不会被实际使用，可传递任意 T 类型 dummy 值，调用方无需关注其具体取值。

7. **跨类型同尺寸转换（fromMat(conv, m)）** — 源和目标尺寸相同（C 和 R 分别相等），仅元素类型不同（如 Float64←Float32）。无需 T(0)/T(1) 演算，只需逐元素应用 conv 转换。共 **9 个重载**（每个矩阵类型一版），签名模式为：
   - 以 Mat4x4<U,P>→Mat4x4<T,Q> 为例：`public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x4<U,P>): Mat4x4<T,Q> where Q <: Qualifier, P <: Qualifier`
   - 其余 8 个重载仅替换矩阵类型（如 Mat2x2<U,P>→Mat2x2<T,Q>、Mat2x3<U,P>→Mat2x3<T,Q> 等），约束与参数模式相同
   - 无需 `T <: Number<T>` 约束，因此 **Bool 矩阵支持此操作**。当目标类型 T=Bool 时，conv 闭包通常需使用比较表达式（如 `{ x => x != 0 }`）而非构造函数调用，因为 Bool 类型可能没有从数值类型直接构造的函数

8. **单位矩阵工厂函数 identity(one: T)** — 对所有 9 种尺寸的矩阵类型均提供（Bool 元素类型除外，见 D33）。若调用方传入 NaN，则对角填充结果将按底层数值运算自然传播 NaN；本设计不额外定义特殊分支处理。行为定义：
   - **方阵（C = R）**：主对角线元素全部为 `one`，非对角线元素为 `T(0)`（与标准数学单位矩阵一致）。
   - **非方阵（C ≠ R）**：主对角线（即 `(i,i)` 位置，其中 `i = 0..min(C,R)-1`）元素为 `one`，其余所有元素为 `T(0)`。
   - **编码路径**：在 Number<T> 约束的 extend 块中实现。对每列 i ∈ [0, C-1]：构造列向量 VecR，其第 i 个分量为 `one`（若 i < R），其余分量为 T(0)（通过 `scalar - scalar` 演算）。对超出对角线范围的列（i ≥ R），整列全为 T(0)。例如 `identity(1.0f)` 在 Mat2x4<Float32,PackedHighp> 上产生：
     ```
     c0 = Vec4(1.0, 0.0, 0.0, 0.0)   c1 = Vec4(0.0, 1.0, 0.0, 0.0)
     ```
     即 4×2 矩阵形式（注意：以下按传统行×列格式展示矩阵形状，与类型命名 Mat{C}x{R} 的列×行格式方向不同——Mat2x4 中 C=2, R=4）：
     ```
     [1.0  0.0]
     [0.0  1.0]
     [0.0  0.0]
     [0.0  0.0]
     ```
             此行为与 GLM 1.0.3 中 `identity` 的实现方式一致（GLM 内部也使用主对角线 `T(1)` 填充策略）。（Bool 矩阵不提供此操作，见 D33）

       **C > R 非方阵编码模板示例**：`identity(1.0f)` 在 Mat3x2<Float32,PackedHighp> 上产生（C=3 > R=2，列索引 i=2 时 i ≥ R，整列全 T(0)）：
       ```
       c0 = Vec2(1.0, 0.0)   c1 = Vec2(0.0, 1.0)   c2 = Vec2(0.0, 0.0)
       ```
       即 2×3 矩阵形式：
       ```
       [1.0  0.0  0.0]
       [0.0  1.0  0.0]
       ```
       确认编码路径正确处理了 `i ≥ R` 时整列全 `T(0)` 的边界条件。

**非方阵 identity() 与 GLM .inl 逐项对照分析**：以下对照 GLM 1.0.3 源码验证非方阵 identity() 的实现方式与主规则（主对角线 `one`、其余 `T(0)`）的一致性：

| 非方阵类型 | GLM 源码 | GLM 实现 | 与主规则一致性 |
|-----------|---------|---------|--------------|
| Mat2x3 | type_mat2x3.inl:40-43 | `value_type const (::glm::_null) = value_type(0); this[0] = col_type(1, 0, 0); this[1] = col_type(0, 1, 0)` | ✅ 一致 — 主对角线 (0,0)=one、(1,1)=one、其余 T(0) |
| Mat2x4 | type_mat2x4.inl:40-44 | `this[0] = col_type(1, 0, 0, 0); this[1] = col_type(0, 1, 0, 0)` | ✅ 一致 — 2×4 主对角线 (0,0)=one、(1,1)=one |
| Mat3x2 | type_mat3x2.inl:40-44 | `this[0] = col_type(1, 0); this[1] = col_type(0, 1); this[2] = col_type(0, 0)` | ✅ 一致 — 3×2 列 2 超出对角线索引范围 (min=2)，整列 T(0) |
| Mat4x3 | type_mat4x3.inl:40-45 | `this[0] = col_type(1, 0, 0); this[1] = col_type(0, 1, 0); this[2] = col_type(0, 0, 1); this[3] = col_type(0, 0, 0)` | ✅ 一致 — 4×3 对角线扩展至第 3 行，列 3 整列 T(0) |

以上 4 个代表性非方阵类型的 GLM 实现均与主规则一致，其他非方阵类型（Mat3x4、Mat4x2）同理可验证。

**B 类方向与 GLM .inl 逐项对照分析**：

| 方向 | GLM 源码 | GLM 实现 | 与主规则一致性 |
|------|---------|---------|--------------|
| Mat2x3←Mat2x2 | type_mat2x3.inl:122 | `col_type(m[0],0), col_type(m[1],0)` | ✅ 一致 |
| Mat2x4←Mat2x2 | type_mat2x4.inl:124 | `col_type(m[0],0,0), col_type(m[1],0,0)` | ✅ 一致 |
| Mat2x4←Mat2x3 | type_mat2x4.inl:160 | `col_type(m[0],0), col_type(m[1],0)` | ✅ 一致 |
| Mat3x3←Mat3x2 | type_mat3x3.inl:175 | `col_type(m[0],0), col_type(m[1],0), col_type(m[2],1)` | ✅ 一致 |
| Mat3x4←Mat3x2 | type_mat3x4.inl:191 | `col_type(m[0],0,0), col_type(m[1],0,0), col_type(m[2],1,0)` | ✅ 一致 |
| Mat3x4←Mat3x3 | type_mat3x4.inl:152 | `col_type(m[0],0), col_type(m[1],0), col_type(m[2],0)` | ✅ 一致 |
| Mat4x3←Mat4x2 | type_mat4x3.inl:228 | `col_type(m[0],0), col_type(m[1],0), col_type(m[2],1), col_type(m[3],0)` | ✅ 一致 |
| Mat4x4←Mat4x2 | type_mat4x4.inl:246 | `col_type(m[0],0,0), col_type(m[1],0,0), col_type(0,0,1,0), col_type(0,0,0,1)` | ❌ **有偏差** |
| Mat4x4←Mat4x3 | type_mat4x4.inl:274 | `col_type(m[0],0), col_type(m[1],0), col_type(m[2],0), col_type(m[3],1)` | ✅ 一致 |

**行扩展规则修正说明**：初始主规则规定"新增行的所有元素全部填入 T(0)"，但 GLM 实现在新增行的对角线 `(i,i)` 位置填入 one=1。经逐项对照确认，9 个 B 类方向中除 Mat4x4←Mat4x2 外，其余 8 个均遵循"对角线填入 one、其余 T(0)"模式。因此 v23 行扩展规则已修正为上述精确表述（见 item 6 行扩展规则）。Mat3x3←Mat3x2 和 Mat3x4←Mat3x2 根据修正后的规则重新评估为 ✅ 一致（先前按旧规则评估虽标记为 ✅，但原规则描述不精确）。

**偏差详情（Mat4x4←Mat4x2）**：GLM 对列 2 和列 3 使用 `col_type(0,0,1,0)` 和 `col_type(0,0,0,1)`，完全丢弃了源矩阵列 2、3 的前两行数据。按主规则（含修正后的对角线 one 规则），应保留源矩阵列 2、3 的前两行（`src[2][0..1]` 和 `src[3][0..1]`），再在新行 (2,2) 和 (3,3) 分别填入 one——与 GLM 行为不同。编码阶段须针对 Mat4x4←Mat4x2 实现特殊处理。

**列扩展/行扩展规则的拆分确认**：上述 B 类方向分析表覆盖了 9 个列数不变（C_src=C_dst）而仅行扩展的场景。这些场景遵循修正后的行扩展规则（对角线 one、其余 T(0)）。列扩展规则（C_src<C_dst，R 任意）在 B 类方向中不出现（B 类定义为 C_src=C_dst，仅 R 增加）。同时涉及列和行变化的非 B 类方向（共 63 个混合方向）未逐一进行 GLM 源码对照分析，其填充行为基于上述四项基本操作组合规则（先列后行）的理论推导，编码阶段须验证各组合类型的正确性。

**fromMat 四项基本操作的数学定义**：fromMat 6a/6b 的全部 72 个转换方向（9 源 × 8 非自身目标 = 72）可通过以下四个基本操作的组合实现。每个操作的定义如下：

| 基本操作 | 符号 | 定义 |
|---------|------|------|
| **列扩展** | `colExtend(M, C_dst)` | 设源矩阵 M 的列数 C_src，目标列数 C_dst > C_src。结果矩阵 N：对所有 i ∈ [0, C_src-1]，N[i] = M[i]（列向量复制，行维度不变，保持源行数 R_src）。对新增列 j ∈ [C_src, C_dst-1]，若 j < R_dst（目标行数），则 N[j] 为目标行数对应的列向量类型 `VecR_dst`，其中第 j 个分量为 one，其余分量为 T(0)；若 j ≥ R_dst，则 N[j] 为同类型的全 T(0) 列向量 |
| **列收缩** | `colShrink(M, C_dst)` | 设源矩阵 M 的列数 C_src，目标列数 C_dst < C_src。结果矩阵 N：对 i ∈ [0, C_dst-1]，N[i] = M[i]（保留前 C_dst 列）；丢弃 M[C_dst] 至 M[C_src-1] |
| **行扩展** | `rowExtend(M, R_dst)` | 设源矩阵 M 的行数 R_src，目标行数 R_dst > R_src。对每列 i ∈ [0, C_dst-1]，若 i < R_dst（即对角线位置有效），则 M[i] 的列向量扩展为 VecR_dst，其中前 R_src 个分量为 M[i] 的原始分量，新分量中位置 (i, i) 填入 one（若 i ≥ R_src 且 i < R_dst），其余新增分量为 T(0)；若 i ≥ R_dst，则整列扩展后全部新增分量为 T(0) |
| **行收缩** | `rowShrink(M, R_dst)` | 设源矩阵 M 的行数 R_src，目标行数 R_dst < R_src。结果矩阵 N：对每列 i ∈ [0, C_dst-1]，N[i] 为 M[i] 的前 R_dst 个分量构成的 VecR_dst（截断超出部分） |

**四项操作的组合规则**：对任何 (C_src, R_src) → (C_dst, R_dst) 方向，执行顺序为：
1. 先对 M 在列维度应用 `colExtend` 或 `colShrink`（取决于 C_src 与 C_dst 的关系），得到中间矩阵 M'（列数 = C_dst，行数 = R_src）
2. 再对 M' 在行维度应用 `rowExtend` 或 `rowShrink`（取决于 R_src 与 R_dst 的关系），得到最终结果 N
此组合规则对全部 72 个方向机械适用，编码阶段可按此顺序统一实现。所有方向标签均遵循此"先列后行"顺序标注。

特殊偏差方向：**Mat4x4←Mat4x2** 不遵循上述组合规则（GLM 丢弃了源矩阵列 2、3 的前两行数据），必须在实现中单独处理（详情见上节偏差分析）。

**fromMat 6a 完整 9×9 转换矩阵表**：以下按源矩阵行对所有 72 个方向标注填充模式、偏差标注和"先列后行"的执行顺序。图例统一使用标准符号，不再使用易混淆的"→"方向标注：

**图例**：
| 标注 | 含义 |
|------|------|
| EQL | 同尺寸（无转换操作） |
| B: rowExt(N) | B 类方向：C 不变、仅 R 扩展至 N 行 |
| rowSh | 仅行收缩（C 不变，R 减少） |
| colExt(N) | 仅列扩展至 N 列（R 不变） |
| colSh | 仅列收缩（R 不变，C 减少） |
| colExt(N)→rowExt | 列扩展 N 列后行扩展 |
| colExt(N)→rowSh | 列扩展 N 列后行收缩 |
| colSh→rowExt | 列收缩后行扩展 |
| colSh→rowSh | 列收缩后行收缩 |
| 🚨 **DEVIATION** | Mat4x4←Mat4x2 已知偏差 |

| 源矩阵 | →Mat2x2 | →Mat2x3 | →Mat2x4 | →Mat3x2 | →Mat3x3 | →Mat3x4 | →Mat4x2 | →Mat4x3 | →Mat4x4 |
|--------|---------|---------|---------|---------|---------|---------|---------|---------|---------|
| **Mat2x2** (2×2) | EQL | B: rowExt(3) | B: rowExt(4) | colExt(3) | colExt(3)→rowExt | colExt(3)→rowExt | colExt(4) | colExt(4)→rowExt | colExt(4)→rowExt |
| **Mat2x3** (2×3) | rowSh | EQL | B: rowExt(4) | colExt(3)→rowSh | colExt(3) | colExt(3)→rowExt | colExt(4)→rowSh | colExt(4) | colExt(4)→rowExt |
| **Mat2x4** (2×4) | rowSh | rowSh | EQL | colExt(3)→rowSh | colExt(3)→rowSh | colExt(3) | colExt(4)→rowSh | colExt(4)→rowSh | colExt(4) |
| **Mat3x2** (3×2) | colSh | colSh→rowExt | colSh→rowExt | EQL | B: rowExt(3) | B: rowExt(4) | colExt(4) | colExt(4)→rowExt | colExt(4)→rowExt |
| **Mat3x3** (3×3) | colSh→rowSh | colSh | colSh→rowExt | rowSh | EQL | B: rowExt(4) | colExt(4)→rowSh | colExt(4) | colExt(4)→rowExt |
| **Mat3x4** (3×4) | colSh→rowSh | colSh→rowSh | colSh | rowSh | rowSh | EQL | colExt(4)→rowSh | colExt(4)→rowSh | colExt(4) |
| **Mat4x2** (4×2) | colSh | colSh→rowExt | colSh→rowExt | colSh | colSh→rowExt | colSh→rowExt | EQL | B: rowExt(3) | 🚨 **DEVIATION** |
| **Mat4x3** (4×3) | colSh→rowSh | colSh | colSh→rowExt | colSh→rowSh | colSh | colSh→rowExt | rowSh | EQL | B: rowExt(4) |
| **Mat4x4** (4×4) | colSh→rowSh | colSh→rowSh | colSh | colSh→rowSh | colSh→rowSh | colSh | rowSh | rowSh | EQL |

**行扩展/行收缩的方向性区分**：上述标注中 `rowExt` 表示行数增加（扩展），`rowSh` 表示行数减少（收缩）。图例与标注使用不同的符号明确区分扩展和收缩，消除此前 "R→→" 同时指代两种相反方向导致的歧义。

**规则化的编码策略**（覆盖全部 72 个方向）：
以上四项基本操作可映射为统一的 match + length() 实现模式。编码阶段在 fromMat 6a/6b 的函数体中，通过 `src.length()`（返回源列数）和目标类型的 `length()` 获取列数信息后，结合硬编码的 R_src、R_dst 字面量，使用固定逻辑实现四项操作的组合，无需为 72 个方向分别编写分支：

维度信息的获取方式：
- **C_src**：通过 `typeof(src).length()` 获取（编译期可推导的常量）
- **C_dst**：通过目标矩阵类型的 `length()` 获取（如 `Mat2x3<T,Q>.length()`；对 6a/6b 均为目标矩阵的列数）
- **R_src** 和 **R_dst**：无法通过仓颉静态查询函数获取——`length()` 仅返回列数 C，仓颉无行数静态查询函数。R_src 和 R_dst 在每个 fromMat 重载实现的函数体中**硬编码为字面量**（如 `let R_dst = 3` 表示目标为 3 行矩阵，Mat2x3 目标中 `let R_dst = 3`），可由代码生成脚本按矩阵类型自动填入。

实现步骤（对每个 fromMat 重载独立适配）：
1. 在函数体内先获取 C_src、C_dst，并硬编码 R_src、R_dst 字面量
2. 对每列 i ∈ [0, C_dst-1]：若 i < C_src 则从源矩阵复制列向量（并应用 conv 闭包），否则按 colExtend 规则构造新列
3. 对每列 i ∈ [0, C_dst-1]：若 R_dst > R_src 则按 rowExtend 规则扩展列向量，若 R_dst < R_src 则按 rowShrink 规则截断
4. Mat4x4←Mat4x2 方向单独分支处理

**编码模板示例**：

以下给出两个代表性方向的完整仓颉函数体示例，展示四项基本操作组合规则到实际代码的映射：

**示例 1：Mat2x3<T,Q>←Mat2x2<T,SrcQ>（B 类简洁方向）**

```cangjie
public static func fromMat<SrcQ>(m: Mat2x2<T,SrcQ>, one: T): Mat2x3<T,Q>
  where T <: Number<T>, Q <: Qualifier, SrcQ <: Qualifier
{
  let C_src = Mat2x2<T,SrcQ>.length()  // =2
  let C_dst = Mat2x3<T,Q>.length()      // =2
  let R_src = 2  // 硬编码字面量
  let R_dst = 3  // 硬编码字面量
  let zero = m.c0.x - m.c0.x           // T(0) 演算

  // B 类方向：C_src == C_dst，仅行扩展 R 2→3
  // 每列：复制源列向量 + 按行扩展规则填充新增分量
  // 对角线位置 (i,i) 在 i<R_src 时已有值，新增行无对角线 one
  let nc0 = Vec3<T,Q>(m.c0.x, m.c0.y, zero)
  let nc1 = Vec3<T,Q>(m.c1.x, m.c1.y, zero)

  return Mat2x3<T,Q>(nc0, nc1)
}
```

此模板直接对应 GLM type_mat2x3.inl:122 的 `col_type(m[0],0), col_type(m[1],0)`。调用方使用示例：

```cangjie
var m22 = Mat2x2<Float32, PackedHighp>(1.0f, 0.0f, 0.0f, 1.0f)
let m23 = Mat2x3<Float32, PackedHighp>.fromMat(m22, one: 1.0f)
```

**示例 2：Mat4x4<T,Q>←Mat4x2<T,SrcQ>（DEVIATION 偏差方向）**

```cangjie
public static func fromMat<SrcQ>(m: Mat4x2<T,SrcQ>, one: T): Mat4x4<T,Q>
  where T <: Number<T>, Q <: Qualifier, SrcQ <: Qualifier
{
  let C_src = Mat4x2<T,SrcQ>.length()  // =4
  let C_dst = Mat4x4<T,Q>.length()      // =4
  let R_src = 2  // 硬编码字面量
  let R_dst = 4  // 硬编码字面量
  let zero = m.c0.x - m.c0.x           // T(0) 演算

  // 列 0、1：行扩展（2→4 行），新增行无对角线 one（i=0,1 < R_src=2）
  let nc0 = Vec4<T,Q>(m.c0.x, m.c0.y, zero, zero)
  let nc1 = Vec4<T,Q>(m.c1.x, m.c1.y, zero, zero)
  // 列 2、3：DEVIATION — GLM 丢弃源数据，构造单位矩阵列
  // 按 GLM type_mat4x4.inl:246 行为 hardcode
  let nc2 = Vec4<T,Q>(zero, zero, one, zero)  // 位置 (2,2) = one
  let nc3 = Vec4<T,Q>(zero, zero, zero, one)  // 位置 (3,3) = one

  return Mat4x4<T,Q>(nc0, nc1, nc2, nc3)
}
```

**模板说明**：
- 6a 和 6b 的 T(0) 演算路径不同：6a 中 `m.c0.x` 类型为 T，可通过 `let zero = m.c0.x - m.c0.x` 计算 T(0)；6b 中 `m.c0.x` 类型为 U（源元素类型），**必须使用 `let zero = one - one` 计算 T(0)**，因为 `one` 类型为 T 且 `T <: Number<T>` 由约束保证。6b 签名新增 `conv: (U) -> T` 参数，每列构造中对每个源元素应用 conv 转换。6a 与 6b 的完整函数体结构基本相同，仅 T(0) 演算路径存在上述差异
- 对 colShrink/rowShrink 方向，仅截断列或行分量，无需 zero/one 演算
- Mat4x4←Mat4x2 偏差方向使用独立编码路径，不遵循通用列先行后组合规则
- 编码阶段建议编写代码生成脚本，以矩阵类型名、C_src/C_dst/R_src/R_dst 为输入自动输出模板代码
- **优先使用属性访问而非下标访问**：模板示例中使用 `m.c0.x` / `m.c0.y` 属性访问而非 `m.c0[0]` / `m.c0[1]` 下标访问，因为下标访问 `[]` 内部含 assert + throw 边界检查，带来不必要的运行时开销；属性访问（`.x`/`.y`/`.z`/`.w`）为编译期直接字段读取，无额外开销

**示例 3（6b 跨类型不同尺寸——Mat2x2<U,P>→Mat2x3<T,Q>）**：展示 6b 与 6a 在 T(0) 演算路径上的差异，conv 闭包与 `one - one` 组合使用：

```cangjie
public static func fromMat<U, P>(conv: (U) -> T, m: Mat2x2<U,P>, one: T): Mat2x3<T,Q>
  where T <: Number<T>, Q <: Qualifier, P <: Qualifier
{
  let C_src = Mat2x2<U,P>.length()   // =2
  let C_dst = Mat2x3<T,Q>.length()   // =2
  let R_src = 2
  let R_dst = 3
  let zero = one - one               // ★ 6b T(0) 演算：必须使用 one - one（one 类型为 T，m.c0.x 类型为 U）

  let nc0 = Vec3<T,Q>(conv(m.c0.x), conv(m.c0.y), zero)
  let nc1 = Vec3<T,Q>(conv(m.c1.x), conv(m.c1.y), zero)

  return Mat2x3<T,Q>(nc0, nc1)
}
```

调用方使用示例：
```cangjie
var m22 = Mat2x2<Int32, PackedHighp>(1, 0, 0, 1)
let m23 = Mat2x3<Float32, PackedHighp>.fromMat({ x => Float32(x) }, m22, one: 1.0f)
```

**编码阶段验证要求**：
- 对 9 个 B 类方向（含 Mat4x4←Mat4x2 偏差），逐方向验证主规则预期与 GLM 行为的一致性
- 对 3 个代表性非 B 类方向（双扩展、C 缩 R 扩、C 扩 R 缩），构造非平凡源矩阵逐元素验证
- 其余方向按四项基本操作组合规则验证，优先验证高风险组合（双扩展、混合模式 ~20 个），低风险方向（单一维度小幅变化 ~20 个）可在单元测试阶段覆盖

**B 类方向单元测试验证要求**：
- 为 Mat4x4←Mat4x2 编写专用测试：构造源矩阵（列 2、3 前两行填入非零值），转换后验证列 2=Vec4(0,0,1,0)、列 3=Vec4(0,0,0,1)，确认源数据被丢弃
- 为其余 8 个 B 类方向编写验证：构造非零源矩阵，确认扩展行符合主规则预期

### 3.4 行列访问

- **下标运算符** `[]`：取值版本 `operator func [](i: Int64): VecR<T,Q>` 返回列向量（struct 值语义下为副本，无额外拷贝开销）；赋值版本 `public mut operator func [](i: Int64, value!: VecR<T,Q>): Unit` 直接替换指定位置的列向量（通过命名参数传值，避免值语义下的副本修改问题）。下标越界时抛出 Exception。赋值版本须声明 `mut`（因修改 struct 内部数据成员）且最后一个参数须为命名参数 `value!`（仓颉函数文档 §8.3 规范要求），与阶段一 Vec 类型的 `[]` 赋值版本签名风格一致（如 `type_vec4.cj:47`：`public mut operator func [](i: Int64, value!: T): Unit`）。
- **列访问函数** `col(i: Int64)`：取值版本返回列向量副本，与 `[]` 取值版本等价。`col()` **仅提供取值版本**，不提供赋值语义。列向量替换应使用 `[]` 下标运算符赋值版本或直接对具名列向量成员赋值（如 `m.c0 = newVec0`）。原因：struct 值语义下 `mut func` 返回的是副本而非引用，`m.col(i) = newVec` 实际修改的是临时副本而非矩阵内部状态，故 `col()` 不设计赋值版本。下标越界时抛出 Exception，与 `[]` 行为一致。
- `col()` 替代 `componentAt()` 以避免与 Vec 的语义冲突
- 行访问 `row()` 推迟至阶段四

### 3.5 算术运算符

- 一元负号、矩阵-标量 ±*/（成员运算符）、标量-矩阵 ±*/（scalar_mat_ops.cj 全局函数）
- 矩阵-矩阵 ±（同尺寸）、*（含 27 个乘法重载：3 同尺寸 + 24 跨尺寸）、/（仅方阵，3 个除法重载，依赖 inverse stub）。矩阵乘法结果类型推导规则：`Mat(C1×R1) * Mat(C2×R2)` 合法当且仅当 `C1 = R2`（左矩阵列数等于右矩阵行数），结果类型为 `Mat(C2×R1)`。所有乘法重载的泛型约束统一为 `where T <: Number<T>, Q <: Qualifier`（与 scalar_mat_ops.cj 签名模板一致），并标注 `@OverflowWrapping`。完整签名表如下：

  | 左矩阵类型 | 右矩阵类型 | 结果类型 |
  |-----------|-----------|---------|
  | Mat2x2 | Mat2x2 | Mat2x2 |
  | Mat2x2 | Mat3x2 | Mat3x2 |
  | Mat2x2 | Mat4x2 | Mat4x2 |
  | Mat2x3 | Mat2x2 | Mat2x3 |
  | Mat2x3 | Mat3x2 | Mat3x3 |
  | Mat2x3 | Mat4x2 | Mat4x3 |
  | Mat2x4 | Mat2x2 | Mat2x4 |
  | Mat2x4 | Mat3x2 | Mat3x4 |
  | Mat2x4 | Mat4x2 | Mat4x4 |
  | Mat3x2 | Mat2x3 | Mat2x2 |
  | Mat3x2 | Mat3x3 | Mat3x2 |
  | Mat3x2 | Mat4x3 | Mat4x2 |
  | Mat3x3 | Mat2x3 | Mat2x3 |
  | Mat3x3 | Mat3x3 | Mat3x3 |
  | Mat3x3 | Mat4x3 | Mat4x3 |
  | Mat3x4 | Mat2x3 | Mat2x4 |
  | Mat3x4 | Mat3x3 | Mat3x4 |
  | Mat3x4 | Mat4x3 | Mat4x4 |
  | Mat4x2 | Mat2x4 | Mat2x2 |
  | Mat4x2 | Mat3x4 | Mat3x2 |
  | Mat4x2 | Mat4x4 | Mat4x2 |
  | Mat4x3 | Mat2x4 | Mat2x3 |
  | Mat4x3 | Mat3x4 | Mat3x3 |
  | Mat4x3 | Mat4x4 | Mat4x3 |
  | Mat4x4 | Mat2x4 | Mat2x4 |
  | Mat4x4 | Mat3x4 | Mat3x4 |
  | Mat4x4 | Mat4x4 | Mat4x4 |

  以上 27 个重载中前 3 个为同尺寸乘法（Mat2x2×Mat2x2、Mat3x3×Mat3x3、Mat4x4×Mat4x4），后 24 个为跨尺寸乘法。每个重载均定义为左矩阵类型的成员运算符 `operator func *(r: RHS): ResultType`，其中 RHS 和 ResultType 按上表对应。

  **跨尺寸矩阵乘法定义**：所有 27 个重载的展开逻辑遵循统一定义：`result[j][i] = sum_{k=0}^{C_left-1} left[k][i] * right[j][k]`，其中 `i` 为行索引（0~R_left-1），`j` 为列索引（0~C_right-1），`k` 为内积索引（0~C_left-1，即 left 的列数 = right 的行数）。编码者可按此公式对每个方向硬编码展开。

  **跨尺寸矩阵乘法编码模板**：

  示例 1：Mat2x3<T,Q> × Mat3x2<T,Q> → Mat3x3<T,Q>（C_left=2, R_left=3, C_right=3, R_right=2）

  ```cangjie
  @OverflowWrapping
  public operator func *(r: Mat3x2<T,Q>): Mat3x3<T,Q> where T <: Number<T>, Q <: Qualifier {
    // C_left=2, R_left=3, C_right=3, R_right=2, Result: Mat3x3 (C=3, R=3)
    // result[j][i] = sum_{k=0}^{1} left[k][i] * right[j][k]
    let nc0 = Vec3<T,Q>(
      this.c0.x * r.c0.x + this.c1.x * r.c0.y,  // result[0][0]
      this.c0.y * r.c0.x + this.c1.y * r.c0.y,  // result[0][1]
      this.c0.z * r.c0.x + this.c1.z * r.c0.y   // result[0][2]
    )
    let nc1 = Vec3<T,Q>(
      this.c0.x * r.c1.x + this.c1.x * r.c1.y,  // result[1][0]
      this.c0.y * r.c1.x + this.c1.y * r.c1.y,  // result[1][1]
      this.c0.z * r.c1.x + this.c1.z * r.c1.y   // result[1][2]
    )
    let nc2 = Vec3<T,Q>(
      this.c0.x * r.c2.x + this.c1.x * r.c2.y,  // result[2][0]
      this.c0.y * r.c2.x + this.c1.y * r.c2.y,  // result[2][1]
      this.c0.z * r.c2.x + this.c1.z * r.c2.y   // result[2][2]
    )
    return Mat3x3<T,Q>(nc0, nc1, nc2)
  }
  ```

  示例 2：Mat4x4<T,Q> × Mat2x4<T,Q> → Mat2x4<T,Q>（C_left=4, R_left=4, C_right=2, R_right=4）

  ```cangjie
  @OverflowWrapping
  public operator func *(r: Mat2x4<T,Q>): Mat2x4<T,Q> where T <: Number<T>, Q <: Qualifier {
    // C_left=4, R_left=4, C_right=2, R_right=4, Result: Mat2x4 (C=2, R=4)
    // result[j][i] = sum_{k=0}^{3} left[k][i] * right[j][k]
    let nc0 = Vec4<T,Q>(
      this.c0.x * r.c0.x + this.c1.x * r.c0.y + this.c2.x * r.c0.z + this.c3.x * r.c0.w,
      this.c0.y * r.c0.x + this.c1.y * r.c0.y + this.c2.y * r.c0.z + this.c3.y * r.c0.w,
      this.c0.z * r.c0.x + this.c1.z * r.c0.y + this.c2.z * r.c0.z + this.c3.z * r.c0.w,
      this.c0.w * r.c0.x + this.c1.w * r.c0.y + this.c2.w * r.c0.z + this.c3.w * r.c0.w
    )
    let nc1 = Vec4<T,Q>(
      this.c0.x * r.c1.x + this.c1.x * r.c1.y + this.c2.x * r.c1.z + this.c3.x * r.c1.w,
      this.c0.y * r.c1.x + this.c1.y * r.c1.y + this.c2.y * r.c1.z + this.c3.y * r.c1.w,
      this.c0.z * r.c1.x + this.c1.z * r.c1.y + this.c2.z * r.c1.z + this.c3.z * r.c1.w,
      this.c0.w * r.c1.x + this.c1.w * r.c1.y + this.c2.w * r.c1.z + this.c3.w * r.c1.w
    )
    return Mat2x4<T,Q>(nc0, nc1)
  }
  ```

  **模板说明**：
  - 同尺寸乘法（Mat2x2×Mat2x2、Mat3x3×Mat3x3、Mat4x4×Mat4x4）遵循同一公式，仅 C_left = C_right = R，展开方式为标准方阵乘法
  - 编码阶段建议编写代码生成脚本，以矩阵尺寸参数（C_left, R_left, C_right, R_right）为输入自动输出模板代码，24 个跨尺寸方向的展开模式完全机械
  - 优先使用属性访问（`.x`/`.y`/`.z`/`.w`）而非下标访问 `[]`，避免 assert 边界检查开销
- **矩阵-矩阵除法 /（仅方阵，3 个重载）**：仅对方阵 Mat2x2/Mat3x3/Mat4x4 提供，定义为成员运算符 `operator func /(rhs: Mat{N}x{N}<T,Q>): Mat{N}x{N}<T,Q>`，内部实现为 `this * inverse(rhs)`（依赖 inverse stub，本阶段执行时抛出 stub 异常）。泛型约束与乘法运算符一致（`where T <: Number<T>, Q <: Qualifier`），标注 `@OverflowWrapping`。完整签名如下：

  | 方阵类型 | 运算符签名 | 备注 |
  |---------|-----------|------|
  | Mat2x2<T,Q> | `@OverflowWrapping public operator func /(rhs: Mat2x2<T,Q>): Mat2x2<T,Q> where T <: Number<T>, Q <: Qualifier` | 内部实现 `this * inverse(rhs)`，stub 阶段抛异常 |
  | Mat3x3<T,Q> | `@OverflowWrapping public operator func /(rhs: Mat3x3<T,Q>): Mat3x3<T,Q> where T <: Number<T>, Q <: Qualifier` | 同上 |
  | Mat4x4<T,Q> | `@OverflowWrapping public operator func /(rhs: Mat4x4<T,Q>): Mat4x4<T,Q> where T <: Number<T>, Q <: Qualifier` | 同上 |

- 矩阵-向量 *（矩阵成员运算符）、行向量-矩阵 *（Vec extend 块成员运算符）
- 复合赋值运算符由编译器自动生成（仓颉语言规范保证行为，见函数文档 §8.5："重载二元运算符（关系运算除外）时自动启用对应复合赋值版本，前提是返回类型与左操作数类型匹配或为其子类型"）

**复合赋值运算符手动定义回退方案**（仅用于防御编译器版本回归 bug，非正常编码路径）：完整回退方案表见附录 A。

**scalar_mat_ops.cj 全局函数签名模板**：该文件提供标量-矩阵四则运算全局具名函数，处理标量在左、矩阵在右的运算场景。泛型约束需要 `T <: Number<T>`（因涉及 `*` 和 `/` 算术运算），标注 `@OverflowWrapping`。参数约定为标量在前（`s: T`）、矩阵在后（`m: Mat{C}x{R}<T, Q>`）。4 个运算 × 9 个矩阵类型 = **36 个全局函数**，完整签名清单如下（sub、mul、div 同理，仅函数名和运算符替换）：

**add 函数族（9 个重载）：**
| 函数签名 |
|---------|
| `@OverflowWrapping public func add<T, Q>(s: T, m: Mat2x2<T, Q>): Mat2x2<T, Q> where T <: Number<T>, Q <: Qualifier` |
| `@OverflowWrapping public func add<T, Q>(s: T, m: Mat2x3<T, Q>): Mat2x3<T, Q> where T <: Number<T>, Q <: Qualifier` |
| `@OverflowWrapping public func add<T, Q>(s: T, m: Mat2x4<T, Q>): Mat2x4<T, Q> where T <: Number<T>, Q <: Qualifier` |
| `@OverflowWrapping public func add<T, Q>(s: T, m: Mat3x2<T, Q>): Mat3x2<T, Q> where T <: Number<T>, Q <: Qualifier` |
| `@OverflowWrapping public func add<T, Q>(s: T, m: Mat3x3<T, Q>): Mat3x3<T, Q> where T <: Number<T>, Q <: Qualifier` |
| `@OverflowWrapping public func add<T, Q>(s: T, m: Mat3x4<T, Q>): Mat3x4<T, Q> where T <: Number<T>, Q <: Qualifier` |
| `@OverflowWrapping public func add<T, Q>(s: T, m: Mat4x2<T, Q>): Mat4x2<T, Q> where T <: Number<T>, Q <: Qualifier` |
| `@OverflowWrapping public func add<T, Q>(s: T, m: Mat4x3<T, Q>): Mat4x3<T, Q> where T <: Number<T>, Q <: Qualifier` |
| `@OverflowWrapping public func add<T, Q>(s: T, m: Mat4x4<T, Q>): Mat4x4<T, Q> where T <: Number<T>, Q <: Qualifier` |

**sub 函数族（9 个重载）**：签名模式同 add，仅函数名替换为 `sub`，运算符替换为 `-`。

**mul 函数族（9 个重载）**：签名模式同 add，仅函数名替换为 `mul`，运算符替换为 `*`。

**div 函数族（9 个重载）**：签名模式同 add，仅函数名替换为 `div`，运算符替换为 `/`。

注意此文件只包含加、减、乘、除四种运算，不提供 mod（矩阵取模无数学意义）。

**单元测试策略指引（`div(s, m)` 语义锁定）**：为确保 `div(s, m)` 语义（`s / m[i][j]`）的正确性和一致性，建议在测试阶段覆盖以下场景：
- **浮点类型正向验证**：选取 2~3 个代表性矩阵尺寸（如 Mat2x2、Mat3x3、Mat4x4），使用 Float32/Float64 元素类型，构造非平凡标量和矩阵验证逐元素除法的结果与预期一致
- **整数类型截断行为验证**：对 Int32/Int64 元素类型构造相同数值的标量和矩阵，确认 `s / m[i][j]` 的整数截断行为。与 Float32 版本的对照测试：相同数值输入下整数除法截断结果与浮点除法结果的差异，明确记录此差异为类型系统固有行为
- **与 scalar_vec_ops.cj 的互操作兼容性**：构造测试用例确认 `div(s, m)`（标量-矩阵）和 `div(s, v)`（标量-向量）在相同标量和分量值输入下产生一致的行为模式——二者均为"标量逐元素除以各分量"，验证 `div(6.0f, m)[0][0]` 与 `div(6.0f, v)[0]` 在 `m[0][0] == v[0]` 时输出一致

### 3.6 比较运算符

定义在 Equatable<T> 约束的 extend 块中（与阶段一 Vec 类型一致）：
- == 和 !=：逐列比较，所有列相等则矩阵相等
- equalExact(other)：具名精确比较，与 == 行为语义等价但为显式具名版本，可供需要强调"精确相等"语义的场景使用

定义在 Number<T> & Comparable<T> 约束的 extend 块中：
- equalEpsilon(other)：浮点容差比较，实现方式为逐列委托 VecR<T,Q>.equalEpsilon，与 == 逐列委托 VecR<T,Q>.== 的模式一致

**NaN 比较行为**：对浮点元素类型（Float32/Float64），含 NaN 分量的矩阵在 == 和 equalExact 下遵循 IEEE 754 语义——NaN 与任何值（包括自身）的比较结果为 false。!= 运算符的行为则与之相反：由于 != 的实现为 !(this == rhs)，当 == 返回 false 时 != 返回 true，因此 NaN != NaN 的结果为 true。equalEpsilon 内部涉及容差比较逻辑，其 NaN 行为与 == 一致：当任意对应分量存在 NaN 时返回 false。此行为由逐层委托的 Vec equalEpsilon 具体实现保证（阶段一 Vec 的 equalEpsilon 同样对 NaN 返回 false），无需额外差异声明。

### 3.7 stub 函数库

为满足方阵 .inl 依赖闭合，本阶段创建 3 个 stub 文件。其中 common.cj 和 geometric.cj 为纯 stub（全部函数空壳），matrix.cj 为部分实现 + 部分 stub。

**common.cj**（package glm.detail）：
- 提供 min、max、abs、sign、floor、ceil、fract、mod、clamp、mix、step、smoothstep 等基础数学函数的空壳签名
- 被 type_mat3x3 和 type_mat4x4 的 .inl 实现引用
- 本阶段仅包含标量版本函数签名（参数和返回值均为 T），向量版本推迟至阶段四
- 完整函数签名清单：
  - `func min<T>(a: T, b: T): T where T <: Number<T> & Comparable<T>`
  - `func max<T>(a: T, b: T): T where T <: Number<T> & Comparable<T>`
  - `func abs<T>(a: T): T where T <: Number<T> & Comparable<T>`
  - `func sign<T>(a: T): T where T <: Number<T> & Comparable<T>`
  - `func floor<T>(a: T): T where T <: Number<T>`
  - `func ceil<T>(a: T): T where T <: Number<T>`
  - `func fract<T>(a: T): T where T <: Number<T>`
  - `func mod<T>(a: T, b: T): T where T <: Number<T>`
    - **注**：此签名为暂定。Number<T> 不直接提供 % 运算符（仅 Integer<T> 提供），也不提供 fmod/trunc。最终实现需拆分为整数版本（Integer<T> 约束）和浮点具体类型重载。
  - `func clamp<T>(a: T, minVal: T, maxVal: T): T where T <: Number<T> & Comparable<T>`
  - `func mix<T>(a: T, b: T, t: T): T where T <: Number<T>`
  - `func step<T>(edge: T, x: T): T where T <: Number<T> & Comparable<T>`
  - `func smoothstep<T>(edge0: T, edge1: T, x: T): T where T <: Number<T> & Comparable<T>`

**matrix.cj**（package glm.detail，混合型文件）：
- 包含两类函数（区别于纯 stub 文件 common.cj/geometric.cj）：
  - A. **可直接实现的函数**（27 个重载）：transpose、matrixCompMult、outerProduct——可通过索引映射简单实现，无需 stub 占位，不依赖其他 stub 文件
  - B. **stub 空壳函数**（6 个重载）：determinant、inverse——仅签名空壳，函数体以 `throw Exception("stub")` 占位，完整实现推迟至阶段三
- 完整函数签名清单：
  - **transpose**（9 个重载，每个矩阵尺寸各一版）：
    - `func transpose<T, Q>(m: Mat2x2<T, Q>): Mat2x2<T, Q> where Q <: Qualifier`
    - `func transpose<T, Q>(m: Mat2x3<T, Q>): Mat3x2<T, Q> where Q <: Qualifier`
    - `func transpose<T, Q>(m: Mat2x4<T, Q>): Mat4x2<T, Q> where Q <: Qualifier`
    - `func transpose<T, Q>(m: Mat3x2<T, Q>): Mat2x3<T, Q> where Q <: Qualifier`
    - `func transpose<T, Q>(m: Mat3x3<T, Q>): Mat3x3<T, Q> where Q <: Qualifier`
    - `func transpose<T, Q>(m: Mat3x4<T, Q>): Mat4x3<T, Q> where Q <: Qualifier`
    - `func transpose<T, Q>(m: Mat4x2<T, Q>): Mat2x4<T, Q> where Q <: Qualifier`
    - `func transpose<T, Q>(m: Mat4x3<T, Q>): Mat3x4<T, Q> where Q <: Qualifier`
    - `func transpose<T, Q>(m: Mat4x4<T, Q>): Mat4x4<T, Q> where Q <: Qualifier`
  - **determinant**（3 个重载，仅方阵，stub）：
    - `func determinant<T, Q>(m: Mat2x2<T, Q>): T where T <: Number<T>, Q <: Qualifier`
    - `func determinant<T, Q>(m: Mat3x3<T, Q>): T where T <: Number<T>, Q <: Qualifier`
    - `func determinant<T, Q>(m: Mat4x4<T, Q>): T where T <: Number<T>, Q <: Qualifier`
  - **inverse**（3 个重载，仅方阵，stub）：
    - `func inverse<T, Q>(m: Mat2x2<T, Q>): Mat2x2<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func inverse<T, Q>(m: Mat3x3<T, Q>): Mat3x3<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func inverse<T, Q>(m: Mat4x4<T, Q>): Mat4x4<T, Q> where T <: Number<T>, Q <: Qualifier`
  - **matrixCompMult**（9 个重载，每个矩阵尺寸各一版）：
    - `func matrixCompMult<T, Q>(x: Mat2x2<T, Q>, y: Mat2x2<T, Q>): Mat2x2<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func matrixCompMult<T, Q>(x: Mat2x3<T, Q>, y: Mat2x3<T, Q>): Mat2x3<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func matrixCompMult<T, Q>(x: Mat2x4<T, Q>, y: Mat2x4<T, Q>): Mat2x4<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func matrixCompMult<T, Q>(x: Mat3x2<T, Q>, y: Mat3x2<T, Q>): Mat3x2<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func matrixCompMult<T, Q>(x: Mat3x3<T, Q>, y: Mat3x3<T, Q>): Mat3x3<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func matrixCompMult<T, Q>(x: Mat3x4<T, Q>, y: Mat3x4<T, Q>): Mat3x4<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func matrixCompMult<T, Q>(x: Mat4x2<T, Q>, y: Mat4x2<T, Q>): Mat4x2<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func matrixCompMult<T, Q>(x: Mat4x3<T, Q>, y: Mat4x3<T, Q>): Mat4x3<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func matrixCompMult<T, Q>(x: Mat4x4<T, Q>, y: Mat4x4<T, Q>): Mat4x4<T, Q> where T <: Number<T>, Q <: Qualifier`
  - **outerProduct**（9 个重载，按列向量×行向量维度组合）：
    - `func outerProduct<T, Q>(c: Vec2<T, Q>, r: Vec2<T, Q>): Mat2x2<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func outerProduct<T, Q>(c: Vec2<T, Q>, r: Vec3<T, Q>): Mat3x2<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func outerProduct<T, Q>(c: Vec2<T, Q>, r: Vec4<T, Q>): Mat4x2<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func outerProduct<T, Q>(c: Vec3<T, Q>, r: Vec2<T, Q>): Mat2x3<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func outerProduct<T, Q>(c: Vec3<T, Q>, r: Vec3<T, Q>): Mat3x3<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func outerProduct<T, Q>(c: Vec3<T, Q>, r: Vec4<T, Q>): Mat4x3<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func outerProduct<T, Q>(c: Vec4<T, Q>, r: Vec2<T, Q>): Mat2x4<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func outerProduct<T, Q>(c: Vec4<T, Q>, r: Vec3<T, Q>): Mat3x4<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func outerProduct<T, Q>(c: Vec4<T, Q>, r: Vec4<T, Q>): Mat4x4<T, Q> where T <: Number<T>, Q <: Qualifier`

**约束放松说明**：以上 27 个重载的泛型约束策略已从 v26 的统一 `where T <: Number<T>, Q <: Qualifier` 按运算性质分化为两类：
- **transpose**（9 个重载）：约束已放松为 `where Q <: Qualifier`。transpose 仅涉及元素索引重排，不涉及算术运算，因此无需 `Number<T>` 约束。此变更使得 transpose 兼容 Bool 元素类型的矩阵。
- **matrixCompMult 和 outerProduct**（各 9 个重载，共 18 个）：约束保留 `where T <: Number<T>, Q <: Qualifier`。matrixCompMult 的逐元素乘法（`*`）和 outerProduct 的列向量每个分量乘以标量（`*`）均为算术运算，需要 `Number<T>` 接口提供 `*` 运算符。

> **GLM 类型约束差异说明**：GLM 中以上 27 个函数均通过 `is_iec559` 静态断言限制仅允许浮点类型实例化。当前 `Number<T>` 约束为仓颉泛型机制限制下的最紧约束，理论上允许整数实例化（如 `outerProduct<Int32, PackedHighp>`）但行为与 GLM 不一致——整数类型的外积运算在 GLM 中为编译期错误。此差异属于仓颉泛型约束表达能力不足导致，编码阶段暂无法消除，须在实现中添加运行时断言或阶段四仓颉提供浮点专用接口时收紧约束。transpose 在 GLM 中同样有 `is_iec559` 断言但可通过 `GLM_UNRESTRICTED_GENTYPE` 宏绕过，当前完全放松约束（`where Q <: Qualifier`）的设计决策应在 D01-D35 决策表中显式记录。

**直接实现说明**（transpose、matrixCompMult、outerProduct 共 27 个重载）：
- **transpose**：对每个矩阵尺寸版本，按固定行列索引映射重组元素。以 Mat3x2→Mat2x3 为例：目标列 `dst.c0 = Vec3(src[0][0], src[1][0], src[2][0])`（将 src 三列的第 0 行收集为 dst 列 0），`dst.c1 = Vec3(src[0][1], src[1][1], src[2][1])`（将 src 三列的第 1 行收集为 dst 列 1），即 `src[i][j]`（第 i 列第 j 行）→ `dst[j][i]`（第 j 列第 i 行）。由于每个矩阵尺寸的列数/行数固定且已知（C,R≤4），转置索引映射可在代码中硬编码展开，无需循环。
- **matrixCompMult**：逐分量相乘。`dst.cj[i] = x.cj[i] * y.cj[i]`，对 9 个矩阵尺寸版本分别按列向量的逐元素运算展开。
- **outerProduct**：外积矩阵元素公式 `M[j][i] = c[i] * r[j]`（i 为行索引 ∈ [0, R-1]，j 为列索引 ∈ [0, C-1]；c[i] 为列向量模板 c 的第 i 个分量，r[j] 为行向量 r 的第 j 个分量）。对 9 个维度组合各版本分别展开，结果矩阵尺寸为 len(c)×len(r)（其中 len(c) = R 为行数，len(r) = C 为列数）。

**stub 函数说明**（determinant、inverse 共 6 个重载）：本阶段仅提供函数签名空壳，函数体以 `throw Exception("stub")` 占位。完整实现推迟至阶段三。

**geometric.cj**（package glm.detail）：
- 提供 dot、cross、normalize、length、distance、reflect、refract 等几何函数的空壳签名
- 被 type_mat4x4 的 .inl 实现引用
- 本阶段仅覆盖方阵 .inl 实际引用的函数签名，全面实现推迟至阶段四
- 完整函数签名清单：
  - `func dot<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>): T where T <: Number<T>, Q <: Qualifier`
  - `func dot<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>): T where T <: Number<T>, Q <: Qualifier`
  - `func dot<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>): T where T <: Number<T>, Q <: Qualifier`
  - `func dot<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>): T where T <: Number<T>, Q <: Qualifier`
  - `func cross<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T>, Q <: Qualifier`
    - **注**：Vec2 的 `cross`（2D 叉积，返回标量）属于 GLM `gtx/exterior_product` 扩展（`glm/gtx/exterior_product.hpp`），不在核心 `geometric.hpp` 中。本阶段 `geometric.cj` stub 仅覆盖核心 `geometric.hpp` 的 Vec3 版本，Vec2 `cross` 推迟至阶段六 gtx 扩展覆盖时实现
  - `func normalize<T, Q>(v: Vec2<T, Q>): Vec2<T, Q> where T <: Number<T>, Q <: Qualifier`
  - `func normalize<T, Q>(v: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T>, Q <: Qualifier`
  - `func normalize<T, Q>(v: Vec4<T, Q>): Vec4<T, Q> where T <: Number<T>, Q <: Qualifier`
  - `func length<T, Q>(v: Vec2<T, Q>): T where T <: Number<T>, Q <: Qualifier`
  - `func length<T, Q>(v: Vec3<T, Q>): T where T <: Number<T>, Q <: Qualifier`
  - `func length<T, Q>(v: Vec4<T, Q>): T where T <: Number<T>, Q <: Qualifier`
  - `func distance<T, Q>(p0: Vec2<T, Q>, p1: Vec2<T, Q>): T where T <: Number<T>, Q <: Qualifier`
  - `func distance<T, Q>(p0: Vec3<T, Q>, p1: Vec3<T, Q>): T where T <: Number<T>, Q <: Qualifier`
  - `func distance<T, Q>(p0: Vec4<T, Q>, p1: Vec4<T, Q>): T where T <: Number<T>, Q <: Qualifier`
  - `func reflect<T, Q>(I: Vec2<T, Q>, N: Vec2<T, Q>): Vec2<T, Q> where T <: Number<T>, Q <: Qualifier`
  - `func reflect<T, Q>(I: Vec3<T, Q>, N: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T>, Q <: Qualifier`
  - `func reflect<T, Q>(I: Vec4<T, Q>, N: Vec4<T, Q>): Vec4<T, Q> where T <: Number<T>, Q <: Qualifier`
  - `func refract<T, Q>(I: Vec2<T, Q>, N: Vec2<T, Q>, eta: T): Vec2<T, Q> where T <: Number<T>, Q <: Qualifier`
  - `func refract<T, Q>(I: Vec3<T, Q>, N: Vec3<T, Q>, eta: T): Vec3<T, Q> where T <: Number<T>, Q <: Qualifier`
  - `func refract<T, Q>(I: Vec4<T, Q>, N: Vec4<T, Q>, eta: T): Vec4<T, Q> where T <: Number<T>, Q <: Qualifier`

  > **GLM 类型约束差异说明**：以上 geometric 函数在 GLM 中均通过 `is_iec559` 静态断言限制仅允许浮点类型。当前 `Number<T>` 约束为仓颉泛型机制限制下的最紧约束，允许整数实例化但行为与 GLM 不一致。阶段四实现时若仓颉提供浮点专用接口则收紧约束，否则须在实现中添加运行时断言。

  **Vec1 版本潜在覆盖差异说明**：GLM `geometric.hpp` 中 `length`/`normalize`/`distance`/`reflect`/`refract` 均使用 `template<length_t L, ...>` 声明（L ∈ [1,4]），理论上涵盖 Vec1 版本。但 `func_geometric.inl` 中 `length`/`distance`/`normalize`/`reflect`/`refract` 的具体实现结构体使用 `template<length_t L, ...>` 泛型参数化，Vec1 版本通过泛型实例化自动获得。因此 GLM **隐式提供** Vec1 版本的 `length`/`normalize`/`distance`/`reflect`/`refract`。本阶段 `geometric.cj` stub 未包含 Vec1 版本——这与 GLM 存在**潜在覆盖差异**。由于 `geometric.cj` 为 stub 文件（完整实现推迟至阶段四），且 Vec1 几何函数的实用价值较低（1D 几何运算场景罕见），本阶段暂不补齐 Vec1 stub 签名，在阶段四实现时再根据实际需求确认是否纳入。

### 3.8 ext/ 别名文件

src/ext/ 下存放矩阵（18 个）和向量（8 个）的具现化别名文件，声明 package glm.ext。

---

## 4. 关键行为契约

### 4.1 矩阵构造与单位矩阵

```
let m = Mat4x4<Float32, PackedHighp>.identity(1.0f)     // 单位矩阵（方阵 identity(1.0f) 等价于 diagonal(1.0f)，见 D34）
let m = Mat4x4<Float32, PackedHighp>.diagonal(1.0f)       // 对角矩阵
let m = Mat4x4<Float32, PackedHighp>(1.0f, 0.0f, ...)    // 逐分量 const init
```

### 4.2 矩阵乘法

```
let c = a * b                    // 矩阵-矩阵乘
let transformed = a * v          // 矩阵-向量乘
let r = v * m                    // 行向量-矩阵乘
```

### 4.3 跨尺寸转换

```
let m4 = Mat4x4<Float32, PackedHighp>.fromMat(m2x2, one: 1.0f)
```

### 4.4 跨类型跨尺寸转换

```
let m4f = Mat4x4<Float32, PackedHighp>.fromMat({ x => Float32(x) }, m2x2_int, one: 1.0f)
```

### 4.5 跨类型同尺寸转换

```
let mFloat = Mat4x4<Float32, PackedHighp>.fromMat({ x => Float32(x) }, mInt)
```

---

## 5. 错误处理策略

- 下标越界抛出 Exception
- mat/mat 除法依赖 inverse stub，本阶段 stub 异常
- **矩阵-矩阵除法奇异矩阵行为**：`inverse` 函数对奇异矩阵（不可逆矩阵）的行为选择——本阶段 `inverse` 为 stub（`throw Exception("stub")`），完整实现推迟至阶段三。阶段三实现时须在 `inverse` 函数文档中明确奇异矩阵行为：推荐策略为抛出异常（`throw Exception("singular matrix")`），因为返回未定义值无法向调用方传递错误状态。矩阵-矩阵除法 `A / B` 内部实现为 `A * inverse(B)`，当 `B` 为奇异矩阵时 `inverse(B)` 抛出异常，除法运算的调用方需在业务层处理此异常。此策略也适用于 `*=(Mat)` 和 `/=(Mat)` 复合赋值运算符（仅方阵提供）
- mat/scalar 和 scalar/mat 逐元素操作，不依赖 inverse，本阶段完整实现
- **equalExact NaN 行为**：equalExact 在含 NaN 分量时返回 false（与 == 行为语义等价），与 equalEpsilon 的 NaN 声明保持对称
- **equalEpsilon NaN 行为**：equalEpsilon 在含 NaN 分量时返回 false，与 == 的 NaN 语义一致（详见 §3.6）
- **Mat×Vec / Vec×Mat NaN 传播策略**：矩阵乘法（Mat×Mat、Mat×Vec、Vec×Mat）在浮点元素类型下遵循 IEEE 754 NaN 传播规则——任一输入分量含 NaN 则结果对应分量亦为 NaN。此行为与 GLM 的 NaN 传播行为一致，无需额外差异声明。单元测试层应覆盖：
  - 矩阵含 NaN 列时与不含 NaN 向量的乘法结果验证
  - 向量含 NaN 分量时与不含 NaN 矩阵的乘法结果验证
  - 全 NaN 矩阵与正常向量的乘法验证（预期全部结果为 NaN）
  - 与 GLM 1.0.3 对应实现的结果逐分量等值对照（选取 2~3 个代表性矩阵尺寸，覆盖浮点精度 Float32/Float64）
- **溢出策略全局规则**：以下所有算术运算符均标注 `@OverflowWrapping`，确保整数类型矩阵运算在溢出时静默截断而非抛出异常，与 GLM 的静默截断行为一致：
  - 矩阵-标量 `+-*/` 成员运算符（定义在 9 个 type_mat{N}x{M}.cj 文件的 extend 块中）
  - 标量-矩阵 `+-*/` 全局函数（scalar_mat_ops.cj，add、sub、mul、div 各 9 个重载，共 36 个函数）
  - 矩阵-矩阵同尺寸 `+-*` 成员运算符
  - 矩阵-矩阵跨尺寸 `*` 成员运算符（§3.5 签名表中每行均标注 @OverflowWrapping）
  - 矩阵-向量 `*` 成员运算符（Mat×Vec）
  - 算术复合赋值运算符

---

## 6. 并发设计

本阶段不引入并发场景。矩阵类型为值类型，所有运算符返回新实例，天然线程安全。

---

## 7. 设计决策

| 编号 | 决策 | 理由 |
|------|------|------|
| D01 | 9 个矩阵类型各自独立定义 | 仓颉不支持模板偏特化 |
| D02 | 列主序存储 | 与 GLM 约定一致 |
| D03 | glm.ext 子包存放别名文件 | 目录路径与包名匹配规则要求 |
| D04 | 矩阵乘法直接内联展开 | 最大 4×4 代码量可控 |
| D05 | 矩阵-向量乘法定义为矩阵运算符 | 与 C++ GLM 一致 |
| D06 | 标量左侧运算通过全局函数 | 仓颉 operator func 限制 |
| D07 | stub 函数提供空壳签名 | 仅依赖闭合需求 |
| D08 | 排除 ++/-- 运算符 | 仓颉不支持重载自增/减 |
| D09-D31 | 同 v5 设计 | 延续前序已验证的决策 |
| D32 | 行向量×矩阵为 Vec 类型成员运算符 | 左操作数类型拥有运算符 |
| D33 | Bool 矩阵不提供算术运算符、标量填充和 equalEpsilon | Bool 不实现 Number<T> 接口，无法参与算术运算、标量填充；同时因 equalEpsilon 需要 Number<T> 约束，Bool 矩阵也不提供 equalEpsilon 函数。仍支持构造（逐分量/列向量/fromParts/fromColumns）、下标访问、length()、比较（==/!=/equalExact）和 @Derive[Hashable]。Bool 矩阵支持 fromMat 7（跨类型同尺寸转换），因为该操作仅需 conv 闭包和 Qualifier 约束，无需 Number<T>；同样地，fromParts（仅 <Q <: Qualifier> 约束）和 fromColumns（仅 <Q <: Qualifier, P <: Qualifier> 约束）也兼容 Bool 矩阵——conv 闭包通常使用比较表达式（如 { x => x != 0 }）将非 Bool 源类型转为 Bool。但 fromMat 6a/6b（跨类型跨尺寸转换）需 T(0)/T(1) 演算和算术运算，依赖 Number<T> 约束，Bool 矩阵不支持。因此 fromMat 6a/6b 的四项基本操作（colExtend/colShrink/rowExtend/rowShrink）对 Bool 矩阵均不可用——即使 colShrink/rowShrink 属于纯截断操作，也因整条 fromMat 6a/6b 编码路径均要求 Number<T> 约束而不可单独分离使用。Bool 矩阵仅支持 fromMat 7（跨类型同尺寸转换，不涉及扩展/收缩操作）。**Bool 矩阵不提供的完整操作清单**：算术运算符（+、-、*、/、一元负号）、标量运算符（+=、-=、*=、/=）、对角矩阵工厂函数 diagonal()、单位矩阵工厂函数 identity()、equalEpsilon 比较函数 |
| D34 | 方阵 `identity(one)` 内部委托 `diagonal(one)` 实现；非方阵同时提供 `identity(one)` 和 `diagonal(scalar)` | 当 `scalar = one` 时方阵上 `identity(one)` 与 `diagonal(one)` 产生相同结果——均为单位矩阵。方阵 `identity(one)` 内部委托 `diagonal(one)` 实现可避免代码重复。非方阵也提供 `diagonal(scalar)`（与 GLM 1.0.3 对所有 9 个矩阵类型均提供 `mat(T s)` 构造函数一致，例如 Mat2x3 的 `mat(T scalar)` 产生对角填充矩阵）。推荐：需单位矩阵时优先使用 `identity`，需一般对角矩阵时使用 `diagonal` |
| D35 | `type_float.cj` / `type_half.cj` 推迟至阶段四，阶段二不纳入 | 路线图阶段 2 范围中标记为"可选"，但 `type_float.cj`（浮点类型标签）和 `type_half.cj`（半精度浮点类型）当前无被其他阶段二文件依赖的函数库引用。阶段二矩阵类型和 stub 函数库均不使用这两个文件中的类型。推迟可减少阶段二产出物范围，待阶段四浮点扩展功能需求明确时再纳入 |
| D36 | transpose 泛型约束完全放松为 `where Q <: Qualifier`（兼容 Bool 矩阵） | GLM transpose 默认通过 `is_iec559` 断言限制仅浮点类型，但可通过 `GLM_UNRESTRICTED_GENTYPE` 宏绕过。仓颉版本采用完全放松约束策略：transpose 仅涉及索引重排、不含算术运算，`Number<T>` 约束为冗余；兼容 Bool 元素类型的矩阵转置具有实际用途（如视图变换中 Bool 标记矩阵的转置）。若未来需要收缩约束（如严格对齐 GLM 默认行为），可通过 `where T <: SomeFloatInterface` 在阶段四收紧 |

`length()` 设计说明：C++ GLM 中 `mat<C,R,T,Q>::length()` 为静态成员函数（`length()` 返回列数 C），调用方式 `mat4::length()`。仓颉版本中 `length()` 设计为 `public static func length(): Int64`，与阶段一 Vec 类型的 `static length()` 风格一致，也与 C++ GLM 的静态 `length()` 一致。调用方式为 `Mat4x4.length()`。

---

## 8. 阶段二产出物清单

- 9 个矩阵类型实现文件（type_mat2x2.cj ~ type_mat4x4.cj）
- 4 个辅助文件（common.cj, matrix.cj, geometric.cj, scalar_mat_ops.cj）
- 26 个 ext/ 别名文件（18 矩阵 + 8 向量）
- 矩阵测试文件（沿用阶段一测试文件组织和命名约定：`tests/` 目录下按类型分文件，如 `test_mat2x2.cj`、`test_mat3x3.cj` 等，覆盖路线图 §2.2 验证标准——矩阵创建、行列访问、基本算术运算、矩阵-向量乘法语义正确性验证、`mat2x2`~`mat4x4` 各基本类型实例化、别名文件引用验证、`lib.cj` 导出矩阵类型可被外部包正确 import）
- 修改文件：src/fwd.cj（新增 108 个矩阵类型别名，见上方清单）、src/lib.cj（新增以下 public import）
  - lib.cj 新增 public import 清单：
    1. 导出全部 9 个 detail 矩阵类型及其 extend 块：`import glm.detail.{ Mat2x2, Mat2x3, ..., Mat4x4 }`
    2. 导出 detail 包中的 stub 函数库中可直接实现的函数：`import glm.detail.{ transpose, matrixCompMult, outerProduct }`
    3. 导出 scalar_mat_ops.cj 的全局函数：`import glm.detail.{ add, sub, mul, div }`（按需，若 lib.cj 采用通配重导出则无需逐项列出）。注意：`mod` 不在 `scalar_mat_ops.cj` 中提供（矩阵取模无数学意义，GLM 也未为矩阵类型定义 % 运算符），`lib.cj` 现有 `mod` 导出仅需覆盖向量版，阶段二无新增修改
    4. 不直接导出 ext/ 别名文件（ext/ 为 package glm.ext，由用户按需 `import glm.ext.*`）
- **编码启动前验证项**：cjpm 子包构建预验证、**同包前向类型引用延迟解析原型验证**、Mat4x4←Mat4x2 fromMat 偏差验证、@Derive[Hashable] 跨元素类型编译验证（覆盖 Float32、Float64、Int32、Int64、Bool 等所有目标元素类型）。复合赋值运算符自动生成为语言规范保证行为（函数文档 §8.5），无需阻断性验证；编码启动日可执行可选的非阻断性防御测试（在最小测试文件中验证 `m += scalar` 等复合赋值编译通过），确认编译器行为符合规范，若不符合则启用附录 A 中的手动定义回退方案。**阻断性验证项**——同包前向类型引用延迟解析：Vec 类型 extend 块中行向量×矩阵运算符依赖"仓颉编译器同包内前向类型引用延迟解析"。若原型验证失败且 §8 的方案二（独立文件 `type_row_vec_mul.cj`）和方案三（矩阵文件末尾 extend 块）均不可行，则 Vec×Mat 运算符的 API 形态需重新决策（从 `v * m` 退化为全局函数 `mulRowVecMat(v, m)`），须在编码启动前在设计层面确认。**阻断性验证项**——`common.cj` 的 `mod<T>` 函数签名（当前为 `where T <: Number<T>` 暂定）：验证 `mod<T>` 对 Float32/Float64 具象化是否可编译通过（`Number<T>` 不提供 `%` 运算符，仅 `Integer<T>` 提供），若不能则需将签名拆分为整数版本（`Integer<T>` 约束）和浮点具体类型重载（如 `mod(a: Float32, b: Float32): Float32` 等），引用 deviations.md DV-02 作为已验证证据（DV-02 明确 `%` 运算符和 `mod` 具名函数仅在 `Integer<T>` 约束的 extend 块中提供，Float32/Float64 实例化会触发编译错误）。**阻断性验证项**——scalar_mat_ops.cj 与 scalar_vec_ops.cj 同名函数重载解析验证：验证 add/sub/mul/div 四组同名全局函数的参数类型重载无歧义（4 组运算中每组 `add/sub/mul/div` 均有 9 个标量-矩阵重载 + 4 个标量-向量重载，共 13 个同名重载共享同一作用域，需确认编译器按第二参数类型正确消歧）。关键风险场景：`div(s: T, m: Mat2x2<T,Q>)` 的语义已锁定为 **`s / m[i][j]`**（标量逐元素除以矩阵分量），展开公式为 `result[j][i] = s / m.c_j[i]`。此语义与 `add(s, m)`、`sub(s, m)`、`mul(s, m)` 保持一致的"标量运算符作用于各分量"模式（参数顺序均为标量在前、矩阵在后）。GLM 未提供标量除以矩阵的等价运算，但参数顺序 `(s, m)` 与 add/sub/mul 的语义一致（均为标量 op 各分量），故不产生语义错位。编码阶段注意：当 T 为整数类型时，`s / m[i][j]` 的整数除法截断行为与 GLM 的浮点除法行为不同（此差异属类型系统固有，无需在设计层面处理）

### compile order 说明：Vec 类型 extend 块中的行向量×矩阵运算符

行向量×矩阵乘法 `Vec{R} * Mat{C}x{R} → Vec{C}` 定义在 Vec{R} 类型的 extend 块中（type_vecN.cj 文件）。这些 extend 块引用了矩阵类型（Mat2x2, Mat2x3, ..., Mat4x4），而矩阵类型定义在同包（glm.detail）的不同文件中。

**编译顺序说明**（S8 阻断性验证项）：关于"仓颉编译器在同包内支持对前向类型引用的延迟解析"的声明，当前未经官方文档引用或实验验证。此验证项为编码启动前阻断性验证——若原型验证失败且方案二、方案三均不可行，则 Vec×Mat 运算符的 API 形态需重新决策（可能退化为全局函数），须在设计层面提前确认。

若验证失败（编译器不支持同包内前向类型引用的延迟解析），采用以下递进 fallback 方案：

- **方案一（第三备选）**：将行向量×矩阵乘法定义为同包全局自由函数（放入 `type_vecN.cj` 末尾），利用仓颉的函数重载按 (VecR, Mat{C}x{R}) 参数类型对区分。函数签名如 `func mulRowVecMat(v: Vec2<T,Q>, m: Mat2x2<T,Q>): Vec2<T,Q>`、`func mulRowVecMat(v: Vec4<T,Q>, m: Mat4x4<T,Q>): Vec4<T,Q>` 等（共 9 个重载，覆盖 Vec2~Vec4 与对应行数矩阵的乘法组合（Vec1 无有效矩阵乘法目标，排除在外）），不涉及类型上的 extend，无编译顺序依赖。
  - **API 破坏性及迁移影响**：此方案将 `v * m` 运算符调用改为全局具名函数调用 `mulRowVecMat(v, m)`，完全改变了调用语法，不再是运算符重载。下游代码中所有行向量×矩阵的乘法表达式均需修改——用户迁移需将 `v * m` 改写为 `mulRowVecMat(v, m)`。此变化不可自动迁移，需通知所有使用者。API 破坏性最大，因此作为第三备选。
  - **升降级判定标准**：优先尝试方案二或方案三（保持运算符重载形态）。仅在方案二和方案三均因编译顺序限制无法实施时，降级到方案一。降级的触发条件为：在独立文件 `type_row_vec_mul.cj` 中定义 `extend Vec2/3/4 { operator func *(m: Mat... }` 后编译报类型未定义错误（无论文件组织顺序如何调整），且该错误无法通过文件重排或拆分解决。此时通知所有下游用户迁移路径：`v * m` → `mulRowVecMat(v, m)`。
- **方案二（首选）**：将 Vec extend 块拆入独立文件 `type_row_vec_mul.cj`，在文件组织上确保此文件出现在所有矩阵类型文件之后。
  - **维护性评估**：此方案将全部 9 个 Vec extend 块集中在单一文件中，代码量约 12 行，无重复，维护简单。不破坏 API，因此为首选。
- **方案三（备选）**：在矩阵类型文件的末尾，以额外 extend 块方式定义 Vec 扩展。此方式利用仓颉"同包内任意文件均可扩展类型"的特性，确保 extend 块出现在矩阵类型定义之后。例如在 `type_mat4x4.cj` 末尾追加 `extend Vec4 { operator func *(m: Mat4x4<T,Q>): Vec4<T,Q> }`。
  - **代码重复评估**：此方案需要在 9 个矩阵类型文件中各追加 1 个 Vec extend 块（每个矩阵类型行数 R 唯一，仅对应一个 Vec{R} 类型）（每个 extend 块平均 3~5 行），总计约 9×4=36 行代码。重复度中等，但 spread across 9 files 增加了维护负担——若未来修改 Vec extend 块签名，需逐一更新 9 个文件。
  - **适用场景**：若原型验证表明方案二因文件独立引入额外编译依赖，则退而采用本方案。

**编码阶段建议**（无论验证结果，均推荐此文件组织顺序）：
1. 基础类型文件：setup.cj, qualifier.cj, type_vec1~4.cj（不含行向量×矩阵扩展）
2. **stub 文件（需在其他引用者之前编译）**：common.cj, geometric.cj（纯 stub）；matrix.cj（混合型——27 个可直接实现的重载无 stub 依赖，6 个 stub 空壳与纯 stub 依赖链相同，整体归入此批次以简化编译顺序）。type_mat3x3.cj 的 .inl 编排依赖 common.cj(stub) 和 matrix.cj，type_mat4x4.cj 的 .inl 编排依赖 matrix.cj 和 geometric.cj(stub)。将 stub 文件置于矩阵类型文件之前，确保前向引用闭合。
3. 矩阵类型文件：type_mat2x2~type_mat4x4.cj
4. Vec extend 块文件（含行向量×矩阵扩展，或 fallback 方案中的自由函数）
5. 其余辅助文件：scalar_mat_ops.cj
这种顺序使代码阅读者能在理解矩阵类型后看到 Vec 扩展，逻辑自洽。

### fwd.cj 矩阵类型别名新增清单

**阶段一到阶段二迁移连续性确认**：阶段一 `fwd.cj` 已包含 `import glm.detail` 声明（用于 `detail.VecN<...>` 限定访问），矩阵别名可直接通过 `detail.MatNxN<...>` 限定访问，无需新增 import 声明。矩阵别名命名（`Mat2x2`/`mat2`/`DMat2x2`/`dmat2`/`HighpMat2x2` 等前缀变体）与现有向量别名（`Vec2`/`vec2`/`DVec2`/`dvec2`/`HighpVec2` 等）无冲突——矩阵别名使用 `Mat`/`mat`/`DMat`/`dmat` 前缀，向量别名使用 `Vec`/`vec`/`DVec`/`dvec` 前缀，两者命名空间正交。

fwd.cj 需新增以下矩阵类型别名，按元素类型家族和精度变体分组（参考现有向量别名的分组模式）。每组中每个别名格式为 `public type {别名} = detail.{泛型类型}<{元素类型}, detail.{Qualifier}>`：

**Mat 家族（Float32 默认精度，PackedHighp）** — 9 个 PascalCase 全尺寸 + 3 个方阵短别名 + 6 个非方阵 camelCase：
- `Mat2x2`, `Mat2x3`, `Mat2x4`, `Mat3x2`, `Mat3x3`, `Mat3x4`, `Mat4x2`, `Mat4x3`, `Mat4x4` → `detail.Mat{C}x{R}<Float32, detail.PackedHighp>`
- `mat2`, `mat3`, `mat4` → 方阵短别名，指向对应 `Mat{C}x{C}`
- `mat2x3`, `mat2x4`, `mat3x2`, `mat3x4`, `mat4x2`, `mat4x3` → 非方阵 camelCase

**DMat 家族（Float64 默认精度，PackedHighp）** — 9 个 PascalCase + 3 个方阵短别名 + 6 个非方阵 camelCase：
- `DMat2x2`~`DMat4x4` → `detail.Mat{C}x{R}<Float64, detail.PackedHighp>`
- `dmat2`, `dmat3`, `dmat4`, `dmat2x3`~`dmat4x3`

**HighpMat 家族（Float32, PackedHighp）** — 9 个 PascalCase + 3 个方阵短别名：
- `HighpMat2x2`~`HighpMat4x4` → `detail.Mat{C}x{R}<Float32, detail.PackedHighp>`
- `Highpmat2`, `Highpmat3`, `Highpmat4`

> **方阵短别名命名规则说明**：精度前缀方阵短别名格式为 `{精度前缀}mat{方阵尺寸}`（如 `Highpmat2` = `Highp` + `mat` + `2`），其中 `p` 属精度前缀尾部（High**p**/Mediump/Low**p**），`mat` 为矩阵标识，末位数字为方阵尺寸。拼接处 `p` 与 `mat` 虽可能产生可读性歧义（如 `Highpmat2` 中 `p` 与 `mat` 的边界），但此命名与 GLM 源码 fwd.hpp 中的命名一致。精度前缀与矩阵标识之间采用无分隔符的驼峰拼接（PascalCase），以保持与本项目向量别名（如 `HighpVec2`、`MediumpVec3` 等）的命名风格一致——向量别名已使用 `HighpVec` 驼峰模式，矩阵短别名对齐此风格。

**MediumpMat 家族（Float32, PackedMediump）** — 9 个 PascalCase + 3 个方阵短别名（`Mediumpmat2`/`Mediumpmat3`/`Mediumpmat4`，与 HighpMat 家族命名模式一致）。

**LowpMat 家族（Float32, PackedLowp）** — 9 个 PascalCase + 3 个方阵短别名（`Lowpmat2`/`Lowpmat3`/`Lowpmat4`，与 HighpMat 家族命名模式一致）。

**HighpDMat 家族（Float64, PackedHighp）** — 9 个 PascalCase + 3 个方阵短别名（`HighpDMat2`/`HighpDMat3`/`HighpDMat4`）。LowpDMat 和 MediumpDMat 方阵短别名同理，命名模式为 `{Lowp|Mediump|Highp}DMat{C}`。

**MediumpDMat 家族（Float64, PackedMediump）** — 9 个 PascalCase + 3 个方阵短别名。

**LowpDMat 家族（Float64, PackedLowp）** — 9 个 PascalCase + 3 个方阵短别名。

**别名总量统计**：按"本阶段实现"口径计算：PascalCase 2×9=18 个（2 默认精度族）+ 方阵短别名 8×3=24 个 + 非方阵 camelCase 2×6=12 个 = **54 个新增别名**（与 §10 对照汇总表一致）。GLM 全量约 108 个（含未实现的 6 个精度族），原 108 数字为 GLM 全量口径。

**不纳入的别名族**：fmat/f32mat/f64mat 系列（排除，属冗余精度别名族，精度数与 Mat/DMat 家族重合）及 i8mat~u64mat 整型系列（排除，属后续阶段整型类型族），排除理由见 D19。

**GLM 1.0.3 fwd.hpp 矩阵别名对照汇总**：

| GLM 别名族 | GLM 总量 | 本阶段实现 | 排除 | 后续阶段 | 说明 |
|-----------|---------|-----------|------|---------|------|
| Mat2x2~Mat4x4 / DMat2x2~DMat4x4（PascalCase，4 精度家族选 1） | 8×9=72 | 2×9=18 | 6×9=54 | — | 取 Float32/Float64 默认精度各 1 族，其余 6 精度族排除（冗余精度） |
| 方阵短别名（mat2/mat3/mat4、dmat2/dmat3/dmat4、各精度前缀家族） | 8×3=24 | 8×3=24 | 0 | — | 全部本阶段实现 |
| 非方阵 camelCase（mat2x3~mat4x3、dmat2x3~dmat4x3 等） | 8×6=48 | 2×6=12 | 6×6=36 | — | 取 Float32/Float64 默认精度各 1 族 |
| fmat/f32mat/f64mat 冗余精度系列 | ≈12 | 0 | ≈12 | — | D19：冗余精度别名族 |
| i8/i16/i32/i64 整型矩阵系列 | 4×9=36 | 0 | — | 36 | 后续阶段整型类型族 |
| u8/u16/u32/u64 无符号整型系列 | 4×9=36 | 0 | — | 36 | 后续阶段整型类型族 |
| **合计** | **≈228** | **54** | **≈102** | **72** | |

> **编码阶段注意**：fwd.cj 编码时须逐项对照 GLM 1.0.3 `references/fwd.hpp` 确认别名覆盖完整性，以上数字供设计阶段参考，准确别名数以 GLM 源码为准。

---

## 9. 对齐 GLM 参考实现的差异声明

| 差异 | 说明 |
|------|------|
| **无 C 数组成员** | GLM 中 col_type value[C] 替换为具名成员 c0, c1, ... |
| **无 GLM_CONFIG_* 条件编译** | 全部采用最保守值 |
| **无 ++/-- 运算符** | 仓颉不支持重载自增/减，可通过 `m += one` 等价替代 |
| **无模板赋值运算符** | 仓颉不允许重载 operator= |
| **ext/ 别名文件为 package glm.ext** | 仓颉包名与目录路径匹配规则约束 |
| **矩阵-矩阵除法推迟且仅限方阵** | 依赖 inverse stub |
| **标量左侧矩阵运算为全局函数** | 仓颉 operator func 限制 |
| **mat / scalar 为成员运算符函数** | 仓颉 operator func 规则 |
| **无类型别名体系** | 类型别名只能在文件顶层定义 |
| **无 row() 成员函数** | 推迟至阶段四自由函数版本 |
| **col() 仅提供取值版本，不提供赋值语义** | struct 值语义下 `mut func` 返回副本而非引用，`m.col(i) = newVec` 修改的是临时副本而非矩阵内部状态。列向量替换应使用 `[]` 下标赋值版本或直接字段赋值 |
| **[] 返回副本而非引用** | 值类型语义导致链式修改不可用 |
| **fwd.cj 排除冗余别名** | 约 171 个冗余别名被排除 |
| **非方阵 *=(Mat) 不可用** | 仅限矩阵乘法复合赋值（左操作数类型与结果类型不一致）；标量复合赋值 *=(T) 仍可用，由编译器自动生成或手动定义 |
| **复合赋值不支持跨类型** | extend 块运算符右操作数类型固定 |
| **无 init() 默认构造** | 改为 identity(one) 工厂函数 |
| **identity 对非方阵也提供** | API 统一性设计。方阵主对角线填入 one、非对角线 T(0)；非方阵主对角线（i = 0..min(C,R)-1）填入 one、其余 T(0)。Bool 矩阵不提供此操作（见 D33）。方阵 `identity(one)` 内部委托 `diagonal(one)` 实现（见 D34），当 `scalar = one` 时方阵上两者产生相同结果 |
| **diagonal 为工厂函数（曾用名 filled）** | 需要 Number<T> 约束获取 T(0)，v26 从 filled 更名为 diagonal 消除语义歧义。对所有 9 个矩阵类型均提供（与 GLM 1.0.3 对所有 9 个矩阵类型均提供 `mat(T s)` 构造函数一致）。推荐：需单位矩阵时优先使用 `identity`，需一般对角矩阵时使用 `diagonal`。**接口形态偏差**：GLM 中 `mat(T s)` 为构造函数语法（如 `mat2x3(1.0f)`），仓颉中为 Number<T> 约束的 extend 块静态工厂函数（如 `Mat2x3.diagonal(1.0f)`），不可通过构造函数语法调用。此为仓颉值类型限制导致的接口形态偏差 |
| **fromMat 拆分为 6a/6b/7** | 6a（同类型不同尺寸）和 6b（跨类型不同尺寸）需 Number<T> 约束 + one 参数；7（跨类型同尺寸）仅需 conv 闭包 + Qualifier 约束，Bool 矩阵也可使用。6a 通过 SrcQ 泛型参数支持跨 Qualifier 转换（如 Mat2x2<Float32,PackedLowp>→Mat4x4<Float32,PackedHighp>）。6b 额外支持跨元素类型 |
| **fromParts/fromColumns 仅支持单一源类型** | 仓颉泛型签名限制 |
| **`[]` 和 `col()` 不可在 const 上下文** | 含 assert + throw |
| **`identity(one)` 和 `diagonal(scalar)` 不可在 const 上下文** | 涉及运算 |
| **`length()` 为静态成员函数，与 Vec 类型一致** | 与 C++ GLM `mat4::length()` 一致，也同本库 Vec 类型的 `public static func length()` 风格一致。调用方式为 `Mat4x4.length()`（注意 `Mat4x4` 是泛型结构体的具体实例化形式，泛型参数可省略的上下文下也可写作 `Mat4x4<Float32,PackedHighp>.length()`，与本库 Vec 的 `Vec4.length()` 调用风格一致） |
| **行向量×矩阵运算符在 Vec extend 块中** | 因左操作数类型拥有运算符，编译顺序依赖同包延迟解析（待原型验证）。若失败，首选 §8 fallback 方案二（独立文件），其次方案三（矩阵文件末尾 extend 块），最末方案一：API 形态从 `v * m` 退化为 `mulRowVecMat(v, m)` |
| **Mat4x4←Mat4x2 转换行为偏离主规则** | 源矩阵列 2、3 的前两行数据被丢弃，替换为单位矩阵值 |
| **Bool 矩阵不提供算术运算符、标量填充工厂函数和 equalEpsilon** | Bool 不实现 Number<T> 接口，无法参与 ±*/ 等算术运算，不提供 diagonal()/identity()（依赖 Number<T> 约束）；同时因 equalEpsilon 需要 Number<T> 约束，Bool 矩阵也不提供 equalEpsilon 函数。Bool 矩阵仍支持构造（逐分量/列向量/fromParts/fromColumns）、下标访问、length()、比较（==/!=/equalExact）和 @Derive[Hashable]。Bool 矩阵支持 fromMat 7（跨类型同尺寸转换，仅需 conv 闭包 + Qualifier 约束，无需 Number<T>），但不支持 fromMat 6a/6b（需 T(0)/T(1) 演算，依赖 Number<T> 约束） |
| **矩阵类型提供 equalExact 比较函数** | 与阶段一 Vec 类型一致，矩阵类型在 Equatable<T> 约束的 extend 块中提供 equalExact(other) 具名精确比较函数，行为与 == 语义等价 |
| **fromMat 纯收缩方向 one 参数被忽略** | 仓颉泛型限制导致 API 设计偏差：纯收缩方向（C_dst ≤ C_src 且 R_dst ≤ R_src）下不需要 T(1) 值，`one` 参数在函数体中被忽略。但签名中保留该参数以保持 6a/6b 全部 144 个签名的 API 统一性，避免为 72 个收缩方向设置额外的无 `one` 参数签名体系 |

---

## 10. GLM 1.0.3 API 阶段覆盖矩阵

以下矩阵按 GLM 1.0.3 头文件路径组织，标注阶段二对各 API 的覆盖状态。术语说明：
- **本阶段实现**：阶段二内完整实现，非 stub
- **本阶段 stub**：阶段二提供函数签名空壳（`throw Exception("stub")`），完整实现在后续阶段
- **后续阶段**：不在阶段二范围内，推迟至阶段三/四

### glm/matrix.hpp（core matrix functions）

| 函数 | 覆盖状态 | 对应设计方案章节 |
|------|---------|----------------|
| `matrixCompMult`（9 重载，每矩阵尺寸各一版） | 本阶段实现 | §3.7 matrix.cj |
| `outerProduct`（9 重载，C×R 组合） | 本阶段实现 | §3.7 matrix.cj |
| `transpose`（9 重载，每矩阵尺寸各一版） | 本阶段实现 | §3.7 matrix.cj |
| `determinant`（Mat2x2/Mat3x3/Mat4x4 方阵） | 本阶段 stub | §3.7 matrix.cj |
| `inverse`（Mat2x2/Mat3x3/Mat4x4 方阵） | 本阶段 stub | §3.7 matrix.cj |

### glm/common.hpp（core common functions — 标量版本）

| 函数 | 覆盖状态 | 对应设计方案章节 |
|------|---------|----------------|
| `min` / `max` / `abs` / `sign` | 本阶段 stub（标量） | §3.7 common.cj |
| `floor` / `ceil` / `fract` | 本阶段 stub（标量） | §3.7 common.cj |
| `trunc` / `round` / `roundEven` | 后续阶段 | — |
| `mod` / `clamp` / `mix` | 本阶段 stub（标量），`mod` 签名暂定，编码阶段需拆分为整数（Integer\<T\> 约束）和浮点重载 | §3.7 common.cj |
| `step` / `smoothstep` | 本阶段 stub（标量） | §3.7 common.cj |
| `isnan` / `isinf` / `floatBitsToInt` / `floatBitsToUint` / `intBitsToFloat` / `uintBitsToFloat` / `fma` / `frexp` / `ldexp` / `modf` | 后续阶段 | — |

### glm/geometric.hpp（core geometric functions）

| 函数 | 覆盖状态 | 对应设计方案章节 |
|------|---------|----------------|
| `dot` | 本阶段 stub（Vec1~Vec4） | §3.7 geometric.cj |
| `cross` | 本阶段 stub（Vec3） | §3.7 geometric.cj |
| `cross`（Vec2，2D 叉积） | 后续阶段（阶段六 gtx 扩展） | — |
| `normalize` | 本阶段 stub（Vec2~Vec4） | §3.7 geometric.cj |
| `normalize`（Vec1） | 潜在覆盖差异，阶段四确认 | — |
| `length` | 本阶段 stub（Vec2~Vec4） | §3.7 geometric.cj |
| `length`（Vec1） | 潜在覆盖差异，阶段四确认 | — |
| `distance` | 本阶段 stub（Vec2~Vec4） | §3.7 geometric.cj |
| `distance`（Vec1） | 潜在覆盖差异，阶段四确认 | — |
| `reflect` | 本阶段 stub（Vec2~Vec4） | §3.7 geometric.cj |
| `reflect`（Vec1） | 潜在覆盖差异，阶段四确认 | — |
| `refract` | 本阶段 stub（Vec2~Vec4） | §3.7 geometric.cj |
| `refract`（Vec1） | 潜在覆盖差异，阶段四确认 | — |
| `faceforward` | 后续阶段 | — |

### glm/mat2x2.hpp ~ glm/mat4x4.hpp（matrix type definitions）

| 函数/类型 | 覆盖状态 | 对应设计方案章节 |
|----------|---------|----------------|
| 9 个矩阵结构体定义（Mat2x2~Mat4x4） | 本阶段实现 | §3.1, §3.2, §3.3 |
| 逐分量构造函数（同类型） | 本阶段实现 | §3.3 item 1 |
| 列向量构造函数（同类型） | 本阶段实现 | §3.3 item 2 |
| `fromParts(conv, ...)` 跨类型逐分量构造（9 重载，每矩阵类型一版） | 本阶段实现 | §3.3 item 4 |
| `fromColumns(conv, ...)` 跨类型列向量构造（9 重载，每矩阵类型一版） | 本阶段实现 | §3.3 item 5 |
| `fromMat(one)` 6a 同类型跨尺寸转换（72 方向，覆盖 9×8 源-目标组合） | 本阶段实现 | §3.3 item 6a |
| `fromMat(conv, one)` 6b 跨类型跨尺寸转换（72 方向，与 6a 同规模） | 本阶段实现 | §3.3 item 6b |
| `fromMat(conv)` 7 跨类型同尺寸转换（9 重载，每矩阵类型一版，兼容 Bool） | 本阶段实现 | §3.3 item 7 |
| `[](i)` 下标运算符 | 本阶段实现 | §3.4 |
| 成员运算符 — 一元负号（9 重载，每矩阵类型各一版） | 本阶段实现 | §3.5 |
| 成员运算符 — 标量 ±*/（36 重载，4 运算 × 9 矩阵类型） | 本阶段实现 | §3.5 |
| 成员运算符 — 矩阵 ± 同尺寸（9 重载，仅同尺寸） | 本阶段实现 | §3.5 |
| 成员运算符 — 矩阵 * 跨尺寸（27 重载，3 同尺寸 + 24 跨尺寸） | 本阶段实现 | §3.5 |
| 成员运算符 — 矩阵 / 同尺寸方阵（3 重载，Mat2x2/Mat3x3/Mat4x4 各一版） | 本阶段 stub（依赖 inverse） | §3.5 |
| 成员运算符 — Mat×Vec 列向量乘法（9 重载，每矩阵类型各一版） | 本阶段实现 | §3.5 |
| Vec extend 块 — Vec×Mat 行向量乘法（9 重载，Vec2~Vec4 × 对应行数矩阵） | 本阶段实现 | §2（type_vecN.cj extend 块） |
| 复合赋值运算符 | 本阶段实现（编译器自动生成或手动定义回退） | §3.5 |
| `col(i)` 列访问 | 本阶段实现 | §3.4 |
| `length()` 静态查询 | 本阶段实现 | §3.1 |
| `==` / `!=` 比较 | 本阶段实现 | §3.6 |
| `diagonal(scalar)` 对角矩阵工厂函数（9 重载，所有矩阵类型，Bool 除外） | 本阶段实现 | §3.3 item 3 |
| `identity(one)` 单位矩阵工厂函数（9 重载，所有矩阵类型，Bool 除外） | 本阶段实现 | §3.3 item 8 |
| `row()` 行访问 | 后续阶段（阶段四） | — |

### glm/fwd.hpp（forward declarations & type aliases — 矩阵别名部分）

| 别名族 | 覆盖状态 | 对应设计方案章节 |
|-------|---------|----------------|
| f32 PascalCase（Mat2x2~Mat4x4）4 精度 × 9 尺寸 = 36 | 本阶段实现（选 1 精度族 = 9 别名） | §8 fwd.cj 清单 |
| f64 PascalCase 4 精度 × 9 尺寸 = 36 | 本阶段实现（选 1 精度族 = 9 别名） | §8 fwd.cj 清单 |
| 方阵短别名（mat2/mat3/mat4, dmat2/dmat3/dmat4 等） | 本阶段实现 | §8 fwd.cj 清单 |
| 非方阵 camelCase（mat2x3~mat4x3, dmat2x3~dmat4x3） | 本阶段实现 | §8 fwd.cj 清单 |
| int/uint 矩阵别名（i8mat2x2~u64mat4x4） | 后续阶段（排除，见 D19） | — |
| fmat/f32mat/f64mat 冗余别名 | 后续阶段（排除，见 D19） | — |

> **f32/f64 PascalCase 精度族统计说明**：GLM 含 `defaultp`、`lowp`、`mediump`、`highp` 共 4 个精度级别，因此 f32 PascalCase 为 4 精度 × 9 尺寸 = 36 个别名。仓颉版 `defaultp = PackedHighp`（与 highp 等价），实际仅 3 个独立精度族（Lowp/Mediump/Highp），highp 和 defaultp 合并为同一精度族。本阶段仅实现默认精度族（Highp），其余 2 个精度族（Lowp/Mediump）的别名虽不实现但非排除——其实现形态与默认精度族完全同构，可在需要时按相同模式补齐。

### glm/ext/（extension headers — 矩阵相关）

| 头文件 | 覆盖状态 | 对应设计方案章节 |
|-------|---------|----------------|
| ext/matrix_float2x2.hpp ~ matrix_float4x4.hpp（float32 precision 别名） | 本阶段实现 | §3.8 ext/ 别名文件 |
| ext/matrix_double2x2.hpp ~ matrix_double4x4.hpp（float64 precision 别名） | 本阶段实现 | §3.8 ext/ 别名文件 |
| ext/matrix_int2x2.hpp ~ matrix_int4x4.hpp（int 别名） | 后续阶段 | — |
| ext/matrix_uint2x2.hpp ~ matrix_uint4x4.hpp（uint 别名） | 后续阶段 | — |
| ext/matrix_integer.hpp（整数矩阵运算） | 后续阶段 | — |
| ext/matrix_clip_space.hpp（投影矩阵） | 后续阶段 | — |
| ext/matrix_common.hpp（通用矩阵运算） | 后续阶段 | — |
| ext/matrix_projection.hpp（投影函数） | 后续阶段 | — |
| ext/matrix_relational.hpp（矩阵关系运算） | 后续阶段（部分逻辑已在 §3.6 覆盖） | — |
| ext/matrix_transform.hpp（变换矩阵） | 后续阶段 | — |

### glm/gtc/ 和 glm/gtx/（extension headers — 仅供追踪）

| 头文件 | 覆盖状态 |
|-------|---------|
| gtc/matrix_access.hpp | 后续阶段 |
| gtc/matrix_inverse.hpp | 后续阶段 |
| gtc/matrix_transform.hpp | 后续阶段 |
| gtc/type_precision.hpp（精度类型） | 后续阶段（由 ext/ 替代提供） |
| gtx/matrix_cross_product.hpp ~ matrix_transform_2d.hpp（14 个头文件） | 后续阶段 |

---

## 附录 A：复合赋值运算符手动定义回退方案（仅用于防御编译器版本回归 bug，非正常编码路径）

> **方阵 `*=(Mat)` 和 `/=(Mat)` 的自动生成说明**：方阵 `*=(Mat 同尺寸)` 和 `/=(Mat 同尺寸)` 已由编译器自动生成（返回类型与左操作数类型匹配——方阵乘法结果为同尺寸方阵）。其自动生成的函数体等效于 `this = this * rhs`（对于 `*=`）和 `this = this * inverse(rhs)`（对于 `/=`）。由于 `/=` 依赖 inverse stub，自动生成版在 stub 阶段执行时抛出 inverse 的 stub 异常——**无需手动定义**。附录 A 表中方阵行的 `*=(Mat)` 和 `/=(Mat)` 标注仅表示"若编译器版本回归导致自动生成失效的防御路径"，正常编码路径中不编写此两行代码。

| 文件 | 需定义的运算符 | 数量 | 可用数 |
|------|--------------|------|-------|
| type_mat2x2.cj | +=/=-=/*=/=(T), +=/=-=(Mat2x2 同尺寸) † | 8 | 6 |
| type_mat2x3.cj | +=/=-=/*=/=(T), +=/=-=(Mat2x3 同尺寸) | 6 | 6 |
| type_mat2x4.cj | +=/=-=/*=/=(T), +=/=-=(Mat2x4 同尺寸) | 6 | 6 |
| type_mat3x2.cj | +=/=-=/*=/=(T), +=/=-=(Mat3x2 同尺寸) | 6 | 6 |
| type_mat3x3.cj | +=/=-=/*=/=(T), +=/=-=(Mat3x3 同尺寸) † | 8 | 6 |
| type_mat3x4.cj | +=/=-=/*=/=(T), +=/=-=(Mat3x4 同尺寸) | 6 | 6 |
| type_mat4x2.cj | +=/=-=/*=/=(T), +=/=-=(Mat4x2 同尺寸) | 6 | 6 |
| type_mat4x3.cj | +=/=-=/*=/=(T), +=/=-=(Mat4x3 同尺寸) | 6 | 6 |
| type_mat4x4.cj | +=/=-=/*=/=(T), +=/=-=(Mat4x4 同尺寸) † | 8 | 6 |

† `*=(Mat)` 和 `/=(Mat)` 依赖 inverse stub，本阶段执行时抛出 stub 异常，实际不可用。

手动定义总计：**54 个可用 + 6 个 stub**（含 4 标量运算运算符（+=, -=, *=, /=）覆盖 9 种矩阵 = 36，同尺寸矩阵 +=/-= 覆盖 9 种矩阵 = 18，仅 3 个方阵各多 *=(M 同尺寸) 和 /=(M 同尺寸) = 6 个 stub，合计 60 个运算符，其中 54 个可用、6 个 stub）。注意：表中 `+=(Mat)` / `-=(Mat)` 参数均为同尺寸矩阵类型（跨尺寸矩阵不支持 +=/-=，因结果类型与左操作数类型不一致）。

> **方阵 `*=(Mat)` 和 `/=(Mat)` 的运行时行为**：上表中方阵（Mat2x2/Mat3x3/Mat4x4）列为"手动定义"的 `*=(Mat)` 和 `/=(Mat)` 运算符，其底层运算依赖 inverse stub。在本阶段执行这些运算符时会抛出 stub 异常（`throw Exception("stub")`），实际可用性取决于阶段三的完整实现。非方阵因乘法结果类型与左操作数类型不一致而不定义 `*=(Mat)`/`/=(Mat)`，故不受此影响。

标量运算 `*=(T)` 和 `/=(T)` 对所有 9 种矩阵类型均需定义。非方阵仅不定义 `*=(Mat)`（矩阵乘法）和 `/=(Mat)`（矩阵除法）复合赋值，因乘法结果类型与左操作数类型不一致。
