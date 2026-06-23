# GLM 1.0.3 仓颉迁移阶段二 OOD 设计方案（v29）

> **修订日期**：2026-06-22（v29 迭代）

---

## 1. 概述

### 设计目标

在阶段一（Vec1~Vec4 向量类型 + 基础设施）的基础上，迁移全部 9 个矩阵类型及关联别名，使库具备二维/三维/四维矩阵的数学表达能力。矩阵类型以列向量为内部数据成员，与 GLM 的列主序（column-major）存储约定一致。

### 核心抽象

| 抽象 | 角色 | 类型形态 |
|------|------|---------|
| Mat2x2<T,Q> / Mat2x3<T,Q> / ... / Mat4x4<T,Q> | 表示 C×R 数学矩阵的值对象 | 泛型结构体 |
| common.cj（stub） | 基础数学函数库占位 | stub 文件 |
| matrix.cj（部分实现 + 部分 stub） | 矩阵运算函数库，含可直接实现的函数和 stub 空壳 | 部分实现文件 |
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
  │  每个矩阵类型在其 extend 块中定义一个 Mat×Vec 成员运算符 `operator*(v: VecR<T,Q>): VecC<T,Q>`，
  │  其中 R 为矩阵行数（列向量维数），C 为矩阵列数（结果向量维数）。完整签名如下：
  │
  │  | 矩阵类型 | 运算符签名 | 结果向量类型 |
  │  |---------|-----------|------------|
  │  | Mat2x2<T,Q> | `operator func *(v: Vec2<T,Q>): Vec2<T,Q>` | Vec2<T,Q> |
  │  | Mat2x3<T,Q> | `operator func *(v: Vec3<T,Q>): Vec2<T,Q>` | Vec2<T,Q> |
  │  | Mat2x4<T,Q> | `operator func *(v: Vec4<T,Q>): Vec2<T,Q>` | Vec2<T,Q> |
  │  | Mat3x2<T,Q> | `operator func *(v: Vec2<T,Q>): Vec3<T,Q>` | Vec3<T,Q> |
  │  | Mat3x3<T,Q> | `operator func *(v: Vec3<T,Q>): Vec3<T,Q>` | Vec3<T,Q> |
  │  | Mat3x4<T,Q> | `operator func *(v: Vec4<T,Q>): Vec3<T,Q>` | Vec3<T,Q> |
  │  | Mat4x2<T,Q> | `operator func *(v: Vec2<T,Q>): Vec4<T,Q>` | Vec4<T,Q> |
  │  | Mat4x3<T,Q> | `operator func *(v: Vec3<T,Q>): Vec4<T,Q>` | Vec4<T,Q> |
  │  | Mat4x4<T,Q> | `operator func *(v: Vec4<T,Q>): Vec4<T,Q>` | Vec4<T,Q> |
  ├── common.cj ★           — stub（仅函数签名空壳，供 type_mat3x3/type_mat4x4 依赖闭合）
  ├── matrix.cj ★           — 部分实现 + 部分 stub。直接实现的函数（27 个重载，可通过索引映射简单实现）：transpose（9 个重载）、matrixCompMult（9 个重载）、outerProduct（9 个重载）；stub 空壳函数（6 个重载，仅签名空壳，函数体 throw Exception("stub")）：determinant（3 个重载）、inverse（3 个重载）。供 type_mat2x2/type_mat3x3/type_mat4x4 依赖闭合
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
3. **对角矩阵构造 diagonal(scalar: T)** — extend 块工厂函数，Number<T> 约束，非 const。对角填充：对角线元素使用 scalar，非对角线元素使用 T(0) = scalar - scalar。例如 `diagonal(1.0f)` 在 Mat3x2<Float32,PackedHighp> 上产生：
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

5. **跨类型列向量构造 fromColumns(conv, ...)** — extend 块工厂函数，仅 Qualifier 约束，非 const。参数为 C 个列向量，每个列向量类型为 VecR<U,P>。各矩阵类型的完整签名示例如下（通用 where 子句 `Q <: Qualifier, P <: Qualifier` 略）：

   | 矩阵类型 | 签名示例 |
   |---------|---------|
   | Mat2x2<T,Q> | `public static func fromColumns<U, P>(conv: (U) -> T, c0: Vec2<U,P>, c1: Vec2<U,P>): Mat2x2<T,Q>` |
   | Mat2x3<T,Q> | `public static func fromColumns<U, P>(conv: (U) -> T, c0: Vec3<U,P>, c1: Vec3<U,P>): Mat2x3<T,Q>` |
   | Mat2x4<T,Q> | `public static func fromColumns<U, P>(conv: (U) -> T, c0: Vec4<U,P>, c1: Vec4<U,P>): Mat2x4<T,Q>` |
   | Mat3x2<T,Q> | `public static func fromColumns<U, P>(conv: (U) -> T, c0: Vec2<U,P>, c1: Vec2<U,P>, c2: Vec2<U,P>): Mat3x2<T,Q>` |
   | Mat3x3<T,Q> | `public static func fromColumns<U, P>(conv: (U) -> T, c0: Vec3<U,P>, c1: Vec3<U,P>, c2: Vec3<U,P>): Mat3x3<T,Q>` |
   | Mat3x4<T,Q> | `public static func fromColumns<U, P>(conv: (U) -> T, c0: Vec4<U,P>, c1: Vec4<U,P>, c2: Vec4<U,P>): Mat3x4<T,Q>` |
   | Mat4x2<T,Q> | `public static func fromColumns<U, P>(conv: (U) -> T, c0: Vec2<U,P>, c1: Vec2<U,P>, c2: Vec2<U,P>, c3: Vec2<U,P>): Mat4x2<T,Q>` |
   | Mat4x3<T,Q> | `public static func fromColumns<U, P>(conv: (U) -> T, c0: Vec3<U,P>, c1: Vec3<U,P>, c2: Vec3<U,P>, c3: Vec3<U,P>): Mat4x3<T,Q>` |
   | Mat4x4<T,Q> | `public static func fromColumns<U, P>(conv: (U) -> T, c0: Vec4<U,P>, c1: Vec4<U,P>, c2: Vec4<U,P>, c3: Vec4<U,P>): Mat4x4<T,Q>` |

6. **跨矩阵类型转换** — 拆分为以下子类，各有完整泛型约束签名。填充规则分为列扩展和行扩展两个子规则：
   - **列扩展规则**：当目标矩阵列数 C 大于源矩阵列数时，新增列 `c_{新列索引}` 在 `(新列索引, 新列索引)` 位置填入 `one`，其余元素填入 `T(0)`。若 `新列索引 ≥ R（目标行数）`，则整列全部为 `T(0)`（因单位矩阵对角线位置超出矩阵范围）。
   - **行扩展规则**：当目标矩阵行数 R 大于源矩阵行数时，新增行中对角线 `(i,i)` 位置（`i` 从 `R_src` 到 `R_dst-1`，且 `i < C`）填入 `one`，其余新增行元素填入 `T(0)`。若 `i ≥ C`（新增行索引超出列数范围），则该行全部为 `T(0)`。
   - **列收缩/行收缩规则**：直接截断（丢弃超出部分）。

   - **6a（同类型不同尺寸）**：源矩阵和目标矩阵元素类型 T 相同，但尺寸和 Qualifier 可不同。需要 T(1) 通过 `one: T` 参数传入，T(0) 通过 `Number<T>` 约束下的 `scalar - scalar` 演算获得。
      - 签名示例（以 Mat2x2<T,SrcQ>→Mat2x3<T,Q> 为例）：`public static func fromMat<SrcQ>(m: Mat2x2<T,SrcQ>, one: T): Mat2x3<T,Q> where T <: Number<T>, Q <: Qualifier, SrcQ <: Qualifier`
      - 适用于尺寸扩展方向（R_src<R_dst 或 C_src<C_dst）、收缩方向（R_src>R_dst 或 C_src>C_dst）以及同尺寸退化情况
      - 支持跨 Qualifier 转换（如 Mat2x2<Float32,PackedLowp>→Mat4x4<Float32,PackedHighp>）
      - **`one: T` 参数语义**：`one` 的类型 `T` 是目标矩阵的元素类型（而非源元素类型）。其值由调用方根据目标矩阵的数值精度选取（如目标为 Float32 时传入 `1.0f`，目标为 Float64 时传入 `1.0`）。此语义与 identity(one: T) 的 `one` 参数一致，均为目标元素类型语境下的单位值。
      - B 类方向（C_src=C_dst, R_src<R_dst）的 GLM .inl 逐项对照分析见下方映射表

   - **6b（跨类型不同尺寸）**：源矩阵元素类型 U 和目标元素类型 T 不同，尺寸和 Qualifier 也可不同。需要 conv 闭包将 U 转换为 T、`one: T` 参数和 `Number<T>` 约束。
      - 签名示例（以 Mat2x2<U,P>→Mat2x3<T,Q> 为例）：`public static func fromMat<U, P>(conv: (U) -> T, m: Mat2x2<U,P>, one: T): Mat2x3<T,Q> where T <: Number<T>, Q <: Qualifier, P <: Qualifier`
      - 填充规则同 6a，额外对每个源元素应用 conv 转换
      - **`one: T` 参数语义**同 6a：`one` 为目标元素类型 T 的值，由调用方根据目标矩阵的数值精度选取

   6a 和 6b 合计产生大量重载签名：9 个目标矩阵类型 × 8 个源矩阵类型（排除同尺寸）× 2 个变体（6a + 6b）= **144 个签名构造量**。编码阶段建议编写代码生成脚本自动产生这 144 个 fromMat 6a/6b 签名模板，减少手动编写带来的抄写错误和维护负担。

7. **跨类型同尺寸转换（fromMat(conv, m)）** — 源和目标尺寸相同（C 和 R 分别相等），仅元素类型不同（如 Float64←Float32）。无需 T(0)/T(1) 演算，只需逐元素应用 conv 转换。
   - 签名示例（以 Mat4x4<U,P>→Mat4x4<T,Q> 为例）：`public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x4<U,P>): Mat4x4<T,Q> where Q <: Qualifier, P <: Qualifier`
   - 无需 `T <: Number<T>` 约束，因此 **Bool 矩阵支持此操作**。当目标类型 T=Bool 时，conv 闭包通常需使用比较表达式（如 `{ x => x != 0 }`）而非构造函数调用，因为 Bool 类型可能没有从数值类型直接构造的函数

8. **单位矩阵工厂函数 identity(one: T)** — 对所有 9 种尺寸的矩阵类型均提供（Bool 元素类型除外，见 D33）。行为定义：
   - **方阵（C = R）**：主对角线元素全部为 `one`，非对角线元素为 `T(0)`（与标准数学单位矩阵一致）。
   - **非方阵（C ≠ R）**：主对角线（即 `(i,i)` 位置，其中 `i = 0..min(C,R)-1`）元素为 `one`，其余所有元素为 `T(0)`。例如 `identity(1.0f)` 在 Mat2x4<Float32,PackedHighp> 上产生：
     ```
     c0 = Vec4(1.0, 0.0, 0.0, 0.0)   c1 = Vec4(0.0, 1.0, 0.0, 0.0)
     ```
     即 4×2 矩阵形式：
     ```
     [1.0  0.0]
     [0.0  1.0]
     [0.0  0.0]
     [0.0  0.0]
     ```
      此行为与 GLM 1.0.3 中 `identity` 的实现方式一致（GLM 内部也使用主对角线 `T(1)` 填充策略）。（Bool 矩阵不提供此操作，见 D33）

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

**行扩展规则修正说明**：初始主规则规定"新增行的所有元素全部填入 T(0)"，但 GLM 实现在新增行的对角线 `(i,i)` 位置填入 one=1。经逐项对照确认，8 个 B 类方向中除 Mat4x4←Mat4x2 外，其余 7 个均遵循"对角线填入 one、其余 T(0)"模式。因此 v23 行扩展规则已修正为上述精确表述（见 item 6 行扩展规则）。Mat3x3←Mat3x2 和 Mat3x4←Mat3x2 根据修正后的规则重新评估为 ✅ 一致（先前按旧规则评估虽标记为 ✅，但原规则描述不精确）。

**偏差详情（Mat4x4←Mat4x2）**：GLM 对列 2 和列 3 使用 `col_type(0,0,1,0)` 和 `col_type(0,0,0,1)`，完全丢弃了源矩阵列 2、3 的前两行数据。按主规则（含修正后的对角线 one 规则），应保留源矩阵列 2、3 的前两行（`src[2][0..1]` 和 `src[3][0..1]`），再在新行 (2,2) 和 (3,3) 分别填入 one——与 GLM 行为不同。编码阶段须针对 Mat4x4←Mat4x2 实现特殊处理。

**列扩展/行扩展规则的拆分确认**：上述 B 类方向分析表覆盖了 9 个列数不变（C_src=C_dst）而仅行扩展的场景。这些场景遵循修正后的行扩展规则（对角线 one、其余 T(0)）。列扩展规则（C_src<C_dst，R 任意）在 B 类方向中不出现（B 类定义为 C_src=C_dst，仅 R 增加）。同时涉及列和行变化的非 B 类方向在下方 **非 B 类方向对照分析** 中验证。

**fromMat 四项基本操作的数学定义**：fromMat 6a/6b 的全部 72 个转换方向（9 源 × 8 目标 − 9 同尺寸 = 72）可通过以下四个基本操作的组合实现。每个操作的定义如下：

| 基本操作 | 符号 | 定义 |
|---------|------|------|
| **列扩展** | `colExtend(M, C_dst)` | 设源矩阵 M 的列数 C_src，目标列数 C_dst > C_src。结果矩阵 N：对所有 i ∈ [0, C_src-1]，N[i] = M[i]（列向量复制，已包含行扩展/收缩）。对新增列 j ∈ [C_src, C_dst-1]，若 j < R（目标行数），则 N[j] = VecR(..., one 在位置 j, ...)（即第 j 个分量为 one，其余 T(0)）；若 j ≥ R，N[j] = VecR(all T(0)) |
| **列收缩** | `colShrink(M, C_dst)` | 设源矩阵 M 的列数 C_src，目标列数 C_dst < C_src。结果矩阵 N：对 i ∈ [0, C_dst-1]，N[i] = M[i]（保留前 C_dst 列）；丢弃 M[C_dst] 至 M[C_src-1] |
| **行扩展** | `rowExtend(M, R_dst)` | 设源矩阵 M 的行数 R_src，目标行数 R_dst > R_src。对每列 i ∈ [0, C_dst-1]，若 i < R_dst（即对角线位置有效），则 M[i] 的列向量扩展为 VecR_dst，其中前 R_src 个分量为 M[i] 的原始分量，新分量中位置 (i, i) 填入 one（若 i ≥ R_src 且 i < R_dst），其余新增分量为 T(0)；若 i ≥ R_dst，则整列扩展后全部新增分量为 T(0) |
| **行收缩** | `rowShrink(M, R_dst)` | 设源矩阵 M 的行数 R_src，目标行数 R_dst < R_src。结果矩阵 N：对每列 i ∈ [0, C_dst-1]，N[i] 为 M[i] 的前 R_dst 个分量构成的 VecR_dst（截断超出部分） |

**四项操作的组合规则**：对任何 (C_src, R_src) → (C_dst, R_dst) 方向，执行顺序为：
1. 先对 M 在列维度应用 `colExtend` 或 `colShrink`（取决于 C_src 与 C_dst 的关系），得到中间矩阵 M'（列数 = C_dst，行数 = R_src）
2. 再对 M' 在行维度应用 `rowExtend` 或 `rowShrink`（取决于 R_src 与 R_dst 的关系），得到最终结果 N
此组合规则对全部 72 个方向机械适用，编码阶段可按此顺序统一实现。所有方向标签均遵循此"先列后行"顺序标注。

特殊偏差方向：**Mat4x4←Mat4x2** 不遵循上述组合规则（GLM 丢弃了源矩阵列 2、3 的前两行数据），必须在实现中单独处理（详情见上节偏差分析）。

**fromMat 6a 完整 9×8 转换矩阵表**：以下按源矩阵行对所有 72 个方向标注填充模式、偏差标注和"先列后行"的执行顺序。图例统一使用标准符号，不再使用易混淆的"→"方向标注：

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

| 源矩阵 | →Mat2x2 | →Mat2x3 | →Mat2x4 | →Mat3x2 | →Mat3x3 | →Mat3x4 | →Mat4x2 | →Mat4x4 |
|--------|---------|---------|---------|---------|---------|---------|---------|---------|
| **Mat2x2** (2×2) | EQL | B: rowExt(3) | B: rowExt(4) | colExt(3) | colExt(3)→rowExt | colExt(3)→rowExt | colExt(4) | colExt(4)→rowExt |
| **Mat2x3** (2×3) | rowSh | EQL | B: rowExt(4) | colExt(3)→rowSh | colExt(3) | colExt(3)→rowExt | colExt(4)→rowSh | colExt(4)→rowExt |
| **Mat2x4** (2×4) | rowSh | rowSh | EQL | colExt(3)→rowSh | colExt(3)→rowSh | colExt(3) | colExt(4)→rowSh | colExt(4) |
| **Mat3x2** (3×2) | colSh | colSh→rowExt | colSh→rowExt | EQL | B: rowExt(3) | B: rowExt(4) | colExt(4) | colExt(4)→rowExt |
| **Mat3x3** (3×3) | colSh→rowSh | colSh | colSh→rowExt | rowSh | EQL | B: rowExt(4) | colExt(4)→rowSh | colExt(4)→rowExt |
| **Mat3x4** (3×4) | colSh→rowSh | colSh→rowSh | colSh | rowSh | rowSh | EQL | colExt(4)→rowSh | colExt(4) |
| **Mat4x2** (4×2) | colSh | colSh→rowExt | colSh→rowExt | colSh | colSh→rowExt | colSh→rowExt | EQL | 🚨 **DEVIATION** |
| **Mat4x3** (4×3) | colSh→rowSh | colSh | colSh→rowExt | colSh→rowSh | colSh | colSh→rowExt | rowSh | B: rowExt(4) |
| **Mat4x4** (4×4) | colSh→rowSh | colSh→rowSh | colSh | colSh→rowSh | colSh→rowSh | colSh | rowSh | EQL |

**行扩展/行收缩的方向性区分**：上述标注中 `rowExt` 表示行数增加（扩展），`rowSh` 表示行数减少（收缩）。图例与标注使用不同的符号明确区分扩展和收缩，消除此前 "R→→" 同时指代两种相反方向导致的歧义。

**规则化的编码策略**（覆盖全部 72 个方向）：
以上四项基本操作可映射为统一的 match + length() 实现模式。编码阶段在 fromMat 6a/6b 的函数体中，通过 `src.length()`（返回源列数）和 R_dst（目标行数，由目标矩阵类型的 `length()` 返回的列数对应的行数决定）获取维度信息后，使用固定逻辑实现四项操作的组合，无需为 72 个方向分别编写分支：
1. 在函数体内先获取 C_src = typeof(src).length()（编译期可推导的常量）和 C_dst、R_dst
2. 对每列 i ∈ [0, C_dst-1]：若 i < C_src 则从源矩阵复制列向量（并应用 conv 闭包），否则按 colExtend 规则构造新列
3. 对每列 i ∈ [0, C_dst-1]：若 R_dst > R_src 则按 rowExtend 规则扩展列向量，若 R_dst < R_src 则按 rowShrink 规则截断
4. Mat4x4←Mat4x2 方向单独分支处理

**编码阶段验证要求**：
- 对 9 个 B 类方向（含 Mat4x4←Mat4x2 偏差），逐方向验证主规则预期与 GLM 行为的一致性
- 对 3 个代表性非 B 类方向（双扩展、C 缩 R 扩、C 扩 R 缩），构造非平凡源矩阵逐元素验证
- 其余方向按四项基本操作组合规则验证，优先验证高风险组合（双扩展、混合模式 ~20 个），低风险方向（单一维度小幅变化 ~20 个）可在单元测试阶段覆盖

**B 类方向单元测试验证要求**：
- 为 Mat4x4←Mat4x2 编写专用测试：构造源矩阵（列 2、3 前两行填入非零值），转换后验证列 2=Vec4(0,0,1,0)、列 3=Vec4(0,0,0,1)，确认源数据被丢弃
- 为其余 8 个 B 类方向编写验证：构造非零源矩阵，确认扩展行符合主规则预期

### 3.4 行列访问

- **下标运算符** `[](i: Int64)`：取值版本返回列向量副本，赋值版本需 mut 修饰符
- **具名列访问函数** `col(i: Int64)`：与 `[]` 完全等价。下标越界时抛出 Exception，与 `[]` 行为一致
- `col()` 替代 `componentAt()` 以避免与 Vec 的语义冲突
- 行访问 `row()` 推迟至阶段四

### 3.5 算术运算符

- 一元负号、矩阵-标量 ±*/（成员运算符）、标量-矩阵 ±*/（scalar_mat_ops.cj 全局函数）
- 矩阵-矩阵 ±（同尺寸）、*（含 27 个乘法重载：3 同尺寸 + 24 跨尺寸）。矩阵乘法结果类型推导规则：`Mat(C1×R1) * Mat(C2×R2)` 合法当且仅当 `R1 = C2`，结果类型为 `Mat(C1×R2)`。完整签名表如下（**所有乘法运算符标注 @OverflowWrapping**，与 §5 溢出策略全局声明一致）：

  | 左矩阵类型 | 右矩阵类型 | 结果类型 |
  |-----------|-----------|---------|
  | Mat2x2 | Mat2x2 | Mat2x2 |
  | Mat2x2 | Mat2x3 | Mat2x3 |
  | Mat2x2 | Mat2x4 | Mat2x4 |
  | Mat2x3 | Mat3x2 | Mat2x2 |
  | Mat2x3 | Mat3x3 | Mat2x3 |
  | Mat2x3 | Mat3x4 | Mat2x4 |
  | Mat2x4 | Mat4x2 | Mat2x2 |
  | Mat2x4 | Mat4x3 | Mat2x3 |
  | Mat2x4 | Mat4x4 | Mat2x4 |
  | Mat3x2 | Mat2x2 | Mat3x2 |
  | Mat3x2 | Mat2x3 | Mat3x3 |
  | Mat3x2 | Mat2x4 | Mat3x4 |
  | Mat3x3 | Mat3x2 | Mat3x2 |
  | Mat3x3 | Mat3x3 | Mat3x3 |
  | Mat3x3 | Mat3x4 | Mat3x4 |
  | Mat3x4 | Mat4x2 | Mat3x2 |
  | Mat3x4 | Mat4x3 | Mat3x3 |
  | Mat3x4 | Mat4x4 | Mat3x4 |
  | Mat4x2 | Mat2x2 | Mat4x2 |
  | Mat4x2 | Mat2x3 | Mat4x3 |
  | Mat4x2 | Mat2x4 | Mat4x4 |
  | Mat4x3 | Mat3x2 | Mat4x2 |
  | Mat4x3 | Mat3x3 | Mat4x3 |
  | Mat4x3 | Mat3x4 | Mat4x4 |
  | Mat4x4 | Mat4x2 | Mat4x2 |
  | Mat4x4 | Mat4x3 | Mat4x3 |
  | Mat4x4 | Mat4x4 | Mat4x4 |

  以上 27 个重载中前 3 个为同尺寸乘法（Mat2x2×Mat2x2、Mat3x3×Mat3x3、Mat4x4×Mat4x4），后 24 个为跨尺寸乘法。每个重载均定义为左矩阵类型的成员运算符 `operator func *(r: RHS): ResultType`，其中 RHS 和 ResultType 按上表对应。
- 矩阵-向量 *（矩阵成员运算符）、行向量-矩阵 *（Vec extend 块成员运算符）
- 复合赋值运算符由编译器自动生成

**复合赋值运算符手动定义回退方案文件分布表**（若自动生成验证失败）：

| 文件 | 需定义的运算符 | 数量 |
|------|--------------|------|
| type_mat2x2.cj | +=/=-=/*=/=(T), +=/=-=/*=/=(Mat2x2) | 8 |
| type_mat2x3.cj | +=/=-=/*=/=(T), +=/=-=(Mat2x3) | 6 |
| type_mat2x4.cj | +=/=-=/*=/=(T), +=/=-=(Mat2x4) | 6 |
| type_mat3x2.cj | +=/=-=/*=/=(T), +=/=-=(Mat3x2) | 6 |
| type_mat3x3.cj | +=/=-=/*=/=(T), +=/=-=/*=/=(Mat3x3) | 8 |
| type_mat3x4.cj | +=/=-=/*=/=(T), +=/=-=(Mat3x4) | 6 |
| type_mat4x2.cj | +=/=-=/*=/=(T), +=/=-=(Mat4x2) | 6 |
| type_mat4x3.cj | +=/=-=/*=/=(T), +=/=-=(Mat4x3) | 6 |
| type_mat4x4.cj | +=/=-=/*=/=(T), +=/=-=/*=/=(Mat4x4) | 8 |

手动定义总计：**60 个**（含 4 标量运算运算符（+=, -=, *=, /=）覆盖 9 种矩阵 = 36，同尺寸矩阵 +=/-= 覆盖 9 种矩阵 = 18，仅 3 个方阵各多 *=(M) 和 /=(M) = 6，合计 60）

> **方阵 `*=(Mat)` 和 `/=(Mat)` 的运行时行为**：上表中方阵（Mat2x2/Mat3x3/Mat4x4）列为"手动定义"的 `*=(Mat)` 和 `/=(Mat)` 运算符，其底层运算依赖 inverse stub。在本阶段执行这些运算符时会抛出 stub 异常（`throw Exception("stub")`），实际可用性取决于阶段三的完整实现。非方阵因乘法结果类型与左操作数类型不一致而不定义 `*=(Mat)`/`/=(Mat)`，故不受此影响。

标量运算 `*=(T)` 和 `/=(T)` 对所有 9 种矩阵类型均需定义。非方阵仅不定义 `*=(Mat)`（矩阵乘法）和 `/=(Mat)`（矩阵除法）复合赋值，因乘法结果类型与左操作数类型不一致。

**scalar_mat_ops.cj 全局函数签名模板**：该文件提供标量-矩阵四则运算全局具名函数，处理标量在左、矩阵在右的运算场景。泛型约束需要 `T <: Number<T>`（因涉及 `*` 和 `/` 算术运算），标注 `@OverflowWrapping`。所有 9 个矩阵尺寸各一版重载，以 add 为例的签名模式如下（sub、mul、div 同理，仅运算符替换）：
```
@OverflowWrapping
public func add<T, Q>(s: T, m: Mat2x2<T, Q>): Mat2x2<T, Q> where T <: Number<T>, Q <: Qualifier
@OverflowWrapping
public func add<T, Q>(s: T, m: Mat2x3<T, Q>): Mat2x3<T, Q> where T <: Number<T>, Q <: Qualifier
...（Mat2x4 ~ Mat4x4 共 7 个变体，仅矩阵类型替换）
@OverflowWrapping
public func add<T, Q>(s: T, m: Mat4x4<T, Q>): Mat4x4<T, Q> where T <: Number<T>, Q <: Qualifier
```
参数约定为标量在前（`s: T`）、矩阵在后（`m: Mat{C}x{R}<T, Q>`）。4 个运算 × 9 个矩阵类型 = **36 个全局函数**。注意此文件只包含加、减、乘、除四种运算，不提供 mod（矩阵取模无数学意义）。

### 3.6 比较运算符

定义在 Equatable<T> 约束的 extend 块中（与阶段一 Vec 类型一致）：
- == 和 !=：逐列比较，所有列相等则矩阵相等
- equalExact(other)：具名精确比较，与 == 行为语义等价但为显式具名版本，可供需要强调"精确相等"语义的场景使用

定义在 Number<T> & Equatable<T> & Comparable<T> 约束的 extend 块中：
- equalEpsilon(other)：浮点容差比较，实现方式为逐列委托 VecR<T,Q>.equalEpsilon，与 == 逐列委托 VecR<T,Q>.== 的模式一致

**NaN 比较行为**：对浮点元素类型（Float32/Float64），含 NaN 分量的矩阵在 == 和 equalExact 下遵循 IEEE 754 语义——NaN 与任何值（包括自身）的比较结果为 false。!= 运算符的行为则与之相反：由于 != 的实现为 !(this == rhs)，当 == 返回 false 时 != 返回 true，因此 NaN != NaN 的结果为 true。equalEpsilon 内部涉及容差比较逻辑，其 NaN 行为由逐层委托的 Vec equalEpsilon 具体实现决定。此行为与阶段一 Vec 类型一致，也符合 GLM 浮点类型的实践，无需额外差异声明。

### 3.7 stub 函数库

为满足方阵 .inl 依赖闭合，本阶段创建 3 个 stub 文件。其中 common.cj 和 geometric.cj 为纯 stub（全部函数空壳），matrix.cj 为部分实现 + 部分 stub。

**common.cj**（package glm.detail）：
- 提供 min、max、abs、sign、floor、ceil、fract、mod、clamp、mix、step、smoothstep 等基础数学函数的空壳签名
- 被 type_mat3x3 和 type_mat4x4 的 .inl 实现引用
- 本阶段仅包含标量版本函数签名（参数和返回值均为 T），向量版本推迟至阶段四
- 完整函数签名清单：
  - `func min<T>(a: T, b: T): T where T <: Number<T> & Comparable<T>`
  - `func max<T>(a: T, b: T): T where T <: Number<T> & Comparable<T>`
  - `func abs<T>(a: T): T where T <: Number<T> & Equatable<T>`
  - `func sign<T>(a: T): T where T <: Number<T> & Equatable<T>`
  - `func floor<T>(a: T): T where T <: Number<T>`
  - `func ceil<T>(a: T): T where T <: Number<T>`
  - `func fract<T>(a: T): T where T <: Number<T>`
  - `func mod<T>(a: T, b: T): T where T <: Number<T>`
    - **注**：此签名为暂定。Number<T> 不直接提供 % 运算符（仅 Integer<T> 提供），也不提供 fmod/trunc。最终实现需拆分为整数版本（Integer<T> 约束）和浮点具体类型重载。
  - `func clamp<T>(a: T, minVal: T, maxVal: T): T where T <: Number<T> & Comparable<T>`
  - `func mix<T>(a: T, b: T, t: T): T where T <: Number<T>`
  - `func step<T>(edge: T, x: T): T where T <: Number<T> & Comparable<T>`
  - `func smoothstep<T>(edge0: T, edge1: T, x: T): T where T <: Number<T> & Comparable<T>`

**matrix.cj**（package glm.detail）：
- 包含两类函数：
  - A. **可直接实现的函数**（27 个重载）：transpose、matrixCompMult、outerProduct——可通过索引映射简单实现，无需 stub 占位
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

**直接实现说明**（transpose、matrixCompMult、outerProduct 共 27 个重载）：
- **transpose**：对每个矩阵尺寸版本，按固定行列索引映射重组元素。以 Mat3x2→Mat2x3 为例：`dst.c0 = Vec3(src[0][0], src[1][0], src[2][0])`、`dst.c1 = Vec3(src[0][1], src[1][1], src[2][1])`。由于每个矩阵尺寸的列数/行数固定且已知（C,R≤4），转置索引映射可在代码中硬编码展开，无需循环。
- **matrixCompMult**：逐分量相乘。`dst.cj[i] = x.cj[i] * y.cj[i]`，对 9 个矩阵尺寸版本分别按列向量的逐元素运算展开。
- **outerProduct**：外积矩阵的第 j 列 = `c * r[j]`（列向量 c 的每个分量乘以标量 r[j]）。对 9 个维度组合各版本分别展开，结果矩阵尺寸为 len(c)×len(r)。

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

### 3.8 ext/ 别名文件

src/ext/ 下存放矩阵（18 个）和向量（8 个）的具现化别名文件，声明 package glm.ext。

---

## 4. 关键行为契约

### 4.1 矩阵构造与单位矩阵

```
let m = Mat4x4<Float32, PackedHighp>.identity(1.0f)     // 单位矩阵
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
- mat/scalar 和 scalar/mat 逐元素操作，不依赖 inverse，本阶段完整实现
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
| D33 | Bool 矩阵不提供算术运算符、标量填充和 equalEpsilon | Bool 不实现 Number<T> 接口，无法参与算术运算、标量填充；同时因 equalEpsilon 需要 Number<T> 约束，Bool 矩阵也不提供 equalEpsilon 函数。仍支持构造（逐分量/列向量/fromParts/fromColumns）、下标访问、length()、比较（==/!=/equalExact）和 @Derive[Hashable]。Bool 矩阵支持 fromMat 7（跨类型同尺寸转换），因为该操作仅需 conv 闭包和 Qualifier 约束，无需 Number<T>；同样地，fromParts（仅 <Q <: Qualifier> 约束）和 fromColumns（仅 <Q <: Qualifier, P <: Qualifier> 约束）也兼容 Bool 矩阵——conv 闭包通常使用比较表达式（如 { x => x != 0 }）将非 Bool 源类型转为 Bool。但 fromMat 6a/6b（跨类型跨尺寸转换）需 T(0)/T(1) 演算，依赖 Number<T> 约束，Bool 矩阵不支持。**Bool 矩阵不提供的完整操作清单**：算术运算符（+、-、*、/、一元负号）、标量运算符（+=、-=、*=、/=）、对角矩阵工厂函数 diagonal()、单位矩阵工厂函数 identity()、equalEpsilon 比较函数 |

`length()` 设计说明：C++ GLM 中 `mat<C,R,T,Q>::length()` 为静态成员函数（`length()` 返回列数 C），调用方式 `mat4::length()`。仓颉版本中 `length()` 设计为 `public static func length(): Int64`，与阶段一 Vec 类型的 `static length()` 风格一致，也与 C++ GLM 的静态 `length()` 一致。调用方式为 `Mat4x4.length()`。

---

## 8. 阶段二产出物清单

- 9 个矩阵类型实现文件（type_mat2x2.cj ~ type_mat4x4.cj）
- 4 个辅助文件（common.cj, matrix.cj, geometric.cj, scalar_mat_ops.cj）
- 26 个 ext/ 别名文件（18 矩阵 + 8 向量）
- 修改文件：src/fwd.cj（新增 108 个矩阵类型别名，见上方清单）、src/lib.cj（新增以下 public import）
  - lib.cj 新增 public import 清单：
    1. 导出全部 9 个 detail 矩阵类型及其 extend 块：`import glm.detail.{ Mat2x2, Mat2x3, ..., Mat4x4 }`
    2. 导出 detail 包中的 stub 函数库中可直接实现的函数：`import glm.detail.{ transpose, matrixCompMult, outerProduct }`
    3. 导出 scalar_mat_ops.cj 的全局函数：`import glm.detail.{ add, sub, mul, div }`（按需，若 lib.cj 采用通配重导出则无需逐项列出）
    4. 不直接导出 ext/ 别名文件（ext/ 为 package glm.ext，由用户按需 `import glm.ext.*`）
- **编码启动前验证项**：cjpm 子包构建预验证、复合赋值运算符自动生成验证（验证标准：在 type_mat2x2.cj 中声明结构体后编译器是否自动生成复合赋值运算符；验证时机：编码启动首日先创建最小测试文件；验证方法：在测试文件中尝试使用 `m += scalar` 等复合赋值，观察编译是否通过。若不通过，启用 §3.5 中的手动定义回退方案）、Mat4x4←Mat4x2 fromMat 偏差验证、@Derive[Hashable] T=Bool 编译验证

### compile order 说明：Vec 类型 extend 块中的行向量×矩阵运算符

行向量×矩阵乘法 `Vec{R} * Mat{C}x{R} → Vec{C}` 定义在 Vec{R} 类型的 extend 块中（type_vecN.cj 文件）。这些 extend 块引用了矩阵类型（Mat2x2, Mat2x3, ..., Mat4x4），而矩阵类型定义在同包（glm.detail）的不同文件中。

**编译顺序说明**【待验证】：关于"仓颉编译器在同包内支持对前向类型引用的延迟解析"的声明，当前未经官方文档引用或实验验证。编码启动首日须进行最小原型验证：创建包含 Vec extend 块引用矩阵类型的同包文件并编译，确认编译器是否支持此行为。

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
2. 矩阵类型文件：type_mat2x2~type_mat4x4.cj
3. Vec extend 块文件（含行向量×矩阵扩展，或 fallback 方案中的自由函数）
4. 辅助文件：scalar_mat_ops.cj, stub 文件
这种顺序使代码阅读者能在理解矩阵类型后看到 Vec 扩展，逻辑自洽。

### fwd.cj 矩阵类型别名新增清单

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

**MediumpMat 家族（Float32, PackedMediump）** — 9 个 PascalCase + 3 个方阵短别名（`Mediumpmat2`/`Mediumpmat3`/`Mediumpmat4`，与 HighpMat 家族命名模式一致）。

**LowpMat 家族（Float32, PackedLowp）** — 9 个 PascalCase + 3 个方阵短别名（`Lowpmat2`/`Lowpmat3`/`Lowpmat4`，与 HighpMat 家族命名模式一致）。

**HighpDMat 家族（Float64, PackedHighp）** — 9 个 PascalCase + 3 个方阵短别名（`HighpDMat2`/`HighpDMat3`/`HighpDMat4`）。LowpDMat 和 MediumpDMat 方阵短别名同理，命名模式为 `{Lowp|Mediump|Highp}DMat{C}`。

**MediumpDMat 家族（Float64, PackedMediump）** — 9 个 PascalCase + 3 个方阵短别名。

**LowpDMat 家族（Float64, PackedLowp）** — 9 个 PascalCase + 3 个方阵短别名。

**别名总量统计**：PascalCase 9×8=72 个 + 方阵短别名 24 个 + 非方阵 camelCase 12 个 = **108 个新增别名**。

**不纳入的别名族**：fmat/f32mat/f64mat 系列（约 81 个）及 i8mat~u64mat 整型系列（约 108 个），排除理由见 D19。

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
| **col() 代替 componentAt()** | 语义一致性 |
| **[] 返回副本而非引用** | 值类型语义导致链式修改不可用 |
| **fwd.cj 排除冗余别名** | 约 171 个冗余别名被排除 |
| **非方阵 *= 不可用** | 乘法结果类型不同，编译器不自动生成 |
| **复合赋值不支持跨类型** | extend 块运算符右操作数类型固定 |
| **无 init() 默认构造** | 改为 identity(one) 工厂函数 |
| **identity 对非方阵也提供** | API 统一性设计。方阵主对角线填入 one、非对角线 T(0)；非方阵主对角线（i = 0..min(C,R)-1）填入 one、其余 T(0) |
| **diagonal 为工厂函数（曾用名 filled）** | 需要 Number<T> 约束获取 T(0)，v26 从 filled 更名为 diagonal 消除语义歧义 |
| **fromMat 拆分为 6a/6b/7** | 6a（同类型不同尺寸）和 6b（跨类型不同尺寸）需 Number<T> 约束 + one 参数；7（跨类型同尺寸）仅需 conv 闭包 + Qualifier 约束，Bool 矩阵也可使用。6a 通过 SrcQ 泛型参数支持跨 Qualifier 转换（如 Mat2x2<Float32,PackedLowp>→Mat4x4<Float32,PackedHighp>）。6b 额外支持跨元素类型 |
| **fromParts/fromColumns 仅支持单一源类型** | 仓颉泛型签名限制 |
| **`[]` 和 `col()` 不可在 const 上下文** | 含 assert + throw |
| **`identity(one)` 和 `diagonal(scalar)` 不可在 const 上下文** | 涉及运算 |
| **`length()` 为静态成员函数，与 Vec 类型一致** | 与 C++ GLM `mat4::length()` 一致，也同本库 Vec 类型的 `public static func length()` 风格一致。调用方式为 `Mat4x4.length()`（注意 `Mat4x4` 是泛型结构体的具体实例化形式，泛型参数可省略的上下文下也可写作 `Mat4x4<Float32,PackedHighp>.length()`，与本库 Vec 的 `Vec4.length()` 调用风格一致） |
| **行向量×矩阵运算符在 Vec extend 块中** | 因左操作数类型拥有运算符，编译顺序依赖同包延迟解析（待原型验证）。若失败，首选 §8 fallback 方案二（独立文件），其次方案三（矩阵文件末尾 extend 块），最末方案一：API 形态从 `v * m` 退化为 `mulRowVecMat(v, m)` |
| **Mat4x4←Mat4x2 转换行为偏离主规则** | 源矩阵列 2、3 的前两行数据被丢弃，替换为单位矩阵值 |
| **Bool 矩阵不提供算术运算符、标量填充工厂函数和 equalEpsilon** | Bool 不实现 Number<T> 接口，无法参与 ±*/ 等算术运算，不提供 diagonal()/identity()（依赖 Number<T> 约束）；同时因 equalEpsilon 需要 Number<T> 约束，Bool 矩阵也不提供 equalEpsilon 函数。Bool 矩阵仍支持构造（逐分量/列向量/fromParts/fromColumns）、下标访问、length()、比较（==/!=/equalExact）和 @Derive[Hashable]。Bool 矩阵支持 fromMat 7（跨类型同尺寸转换，仅需 conv 闭包 + Qualifier 约束，无需 Number<T>），但不支持 fromMat 6a/6b（需 T(0)/T(1) 演算，依赖 Number<T> 约束） |
| **矩阵类型提供 equalExact 比较函数** | 与阶段一 Vec 类型一致，矩阵类型在 Equatable<T> 约束的 extend 块中提供 equalExact(other) 具名精确比较函数，行为与 == 语义等价 |

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
| `floor` / `ceil` / `fract` / `trunc` / `round` / `roundEven` | 本阶段 stub（标量部分：floor/ceil/fract） | §3.7 common.cj |
| `mod` / `clamp` / `mix` | 本阶段 stub（标量） | §3.7 common.cj |
| `step` / `smoothstep` | 本阶段 stub（标量） | §3.7 common.cj |
| `isnan` / `isinf` / `floatBitsToInt` / `floatBitsToUint` / `intBitsToFloat` / `uintBitsToFloat` / `fma` / `frexp` / `ldexp` / `modf` | 后续阶段 | — |

### glm/geometric.hpp（core geometric functions）

| 函数 | 覆盖状态 | 对应设计方案章节 |
|------|---------|----------------|
| `dot`（Vec1~Vec4） | 本阶段 stub | §3.7 geometric.cj |
| `cross` | 本阶段 stub | §3.7 geometric.cj |
| `normalize`（Vec2~Vec4） | 本阶段 stub | §3.7 geometric.cj |
| `length`（Vec2~Vec4） | 本阶段 stub | §3.7 geometric.cj |
| `distance`（Vec2~Vec4） | 本阶段 stub | §3.7 geometric.cj |
| `reflect`（Vec2~Vec4） | 本阶段 stub | §3.7 geometric.cj |
| `refract`（Vec2~Vec4） | 本阶段 stub | §3.7 geometric.cj |
| `faceforward` | 后续阶段 | — |

### glm/mat2x2.hpp ~ glm/mat4x4.hpp（matrix type definitions）

| 函数/类型 | 覆盖状态 | 对应设计方案章节 |
|----------|---------|----------------|
| 9 个矩阵结构体定义（Mat2x2~Mat4x4） | 本阶段实现 | §3.1, §3.2, §3.3 |
| 逐分量构造函数 | 本阶段实现 | §3.3 item 1 |
| 列向量构造函数 | 本阶段实现 | §3.3 item 2 |
| `[](i)` 下标运算符 | 本阶段实现 | §3.4 |
| 成员运算符（一元负号、标量 ±*/、矩阵 ±、矩阵 *) | 本阶段实现 | §3.5 |
| 复合赋值运算符 | 本阶段实现（编译器自动生成或手动定义回退） | §3.5 |
| `col(i)` 列访问 | 本阶段实现 | §3.4 |
| `length()` 静态查询 | 本阶段实现 | §3.1 |
| `==` / `!=` 比较 | 本阶段实现 | §3.6 |
| `row()` 行访问 | 后续阶段（阶段四） | — |

### glm/fwd.hpp（forward declarations & type aliases — 矩阵别名部分）

| 别名族 | 覆盖状态 | 对应设计方案章节 |
|-------|---------|----------------|
| f32 PascalCase（Mat2x2~Mat4x4）3 精度 × 9 尺寸 = 27 | 本阶段实现（选 1 精度族 = 9 别名） | §8 fwd.cj 清单 |
| f64 PascalCase 3 精度 × 9 尺寸 = 27 | 本阶段实现（选 1 精度族 = 9 别名） | §8 fwd.cj 清单 |
| 方阵短别名（mat2/mat3/mat4, dmat2/dmat3/dmat4 等） | 本阶段实现 | §8 fwd.cj 清单 |
| 非方阵 camelCase（mat2x3~mat4x3, dmat2x3~dmat4x3） | 本阶段实现 | §8 fwd.cj 清单 |
| int/uint 矩阵别名（i8mat2x2~u64mat4x4） | 后续阶段（排除，见 D19） | — |
| fmat/f32mat/f64mat 冗余别名 | 后续阶段（排除，见 D19） | — |

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

## 修订说明（v27）

| 审查意见 | 修改措施 |
|---------|---------|
| **F1（严重）**：fromMat 9×8 转换矩阵表存在 11 处标签错误 | **已采纳**。重写整个 9×8 转换矩阵表，逐一核验 72 个方向的维度变化。修正内容包括：① 移除 Mat2x2→Mat3x2/Mat4x2 等 R 未变化方向上的误标 rowSh；② 移除 Mat2x3→Mat2x2、Mat2x4→Mat2x2、Mat3x3→Mat3x2、Mat3x4→Mat3x2/Mat3x3 等 C 未变化方向上的误标 "C:" 前缀和 colSh；③ 移除 Mat2x2→Mat4x4 等非偏差方向上的 ⛔ 标注（⛔ 仅适用于 Mat4x4←Mat4x2） |
| **F2（中等）**：fromMat 执行顺序规定（先列后行）与标注不一致 | **已采纳**。重写的转换矩阵表中所有方向标注遵循"先列后行"顺序：先标注列操作（colExt/colSh），后标注行操作（rowExt/rowSh）。图例和组合规则声明均同步强调此顺序 |
| **F3（中等）**：transpose 函数使用了不必要的 Number<T> 约束 | **已采纳**。§3.7 matrix.cj 中全部 9 个 transpose 重载、9 个 matrixCompMult 重载和 9 个 outerProduct 重载的泛型约束从 `where T <: Number<T>, Q <: Qualifier` 统一放松为 `where Q <: Qualifier`。增加约束放松说明段落，标注此变更使 transpose 等运算兼容 Bool 矩阵 |
| **F4（一般）**：common.cj mod 函数签名约束不匹配 | **已采纳**。§3.7 common.cj mod 签名下方补充注释：标注"此签名为暂定，最终实现需拆分为整数版本（Integer<T> 约束）和浮点具体类型重载" |
| **F5（一般）**：fromMat 6a one: T 参数在跨 Qualifier 方向上的语义未明确 | **已采纳**。§3.3 item 6a 中新增 one: T 参数语义说明段落：明确 one 的类型是目标元素类型 T（非源元素类型 U），其值由调用方根据目标矩阵的数值精度选取（如目标为 Float32 时传入 1.0f，目标为 Float64 时传入 1.0）。6b 相同语义 |
| **F6（一般）**：矩阵乘法 operator * 未声明 @OverflowWrapping | **已采纳**。§3.5 乘法签名表上方增加标注："**所有乘法运算符标注 @OverflowWrapping**，与 §5 溢出策略全局声明一致" |
| **F7（中等）**：C→R→→ 标注对行收缩方向有误导性 | **已采纳**。重写图例和标注规范：废弃原统一的 "R→→" 符号（同时指代扩展和收缩），改用明确的 `rowExt`（行扩展）、`rowSh`（行收缩）区分。表中全部方向均使用精确符号 |
| **F8（一般）**：144 个 fromMat 6a/6b 签名构造量未标注风险 | **已采纳**。§3.3 item 6 末尾补充签名数量统计：6a 和 6b 合计 144 个签名（9 目标 × 8 源 × 2 变体）。建议编码阶段使用代码生成脚本自动产生签名模板以降低维护负担 |
| **F9（一般）**：diagonal() 工厂函数缺少 Bool 矩阵不支持的标注 | **已采纳**。D33 决策说明末尾将 Bool 矩阵不支持列表从"算术运算符"扩展为完整清单：算术运算符（+、-、*、/、一元负号）、标量运算符（+=、-=、*=、/=）、**对角矩阵工厂函数 diagonal()、单位矩阵工厂函数 identity()**、equalEpsilon 比较函数 |
| **F10（一般）**：从 v * m 退化为 mulRowVecMat(v, m) 的迁移影响未评估 | **已采纳**。§8 fallback 方案一的 API 破坏性说明中补充迁移影响评估：用户需将 `v * m` 改写为 `mulRowVecMat(v, m)`，此变化不可自动迁移。增加升降级判定标准：仅当方案二和方案三均因编译顺序限制无法实施时降级到方案一，此时通知所有下游用户迁移路径 |

---

## 修订说明（v28）

| 审查意见 | 修改措施 |
|---------|---------|
| **P1（严重）**：matrixCompMult 和 outerProduct 的泛型约束错误放松为 `where Q <: Qualifier`，但两者均涉及 `*` 算术运算，需要 `Number<T>` 约束 | **已采纳**。恢复 matrixCompMult（9 个重载）和 outerProduct（9 个重载）的泛型约束为 `where T <: Number<T>, Q <: Qualifier`。transpose 保留 `where Q <: Qualifier`（仅涉及索引重排）。§3.7 约束放松说明段同步修正：明确仅 transpose 的约束已放松，matrixCompMult 和 outerProduct 因涉及乘法运算仍需 Number<T> |
| **P2（严重）**：fromMat 9×8 转换矩阵表中 Mat4x3→Mat4x4 被标注为 "EQL"，但两者行数不同（R=3 → R=4），正确标签应为 "B: rowExt(4)" | **已采纳**。将 §3.3 fromMat 9×8 表中 Mat4x3 行、→Mat4x4 列的标签从 "EQL" 修正为 "B: rowExt(4)" |
| **P3（中等）**：缺少对 GLM 1.0.3 头文件的系统性 API 覆盖清单，无法判断阶段二覆盖完整性 | **已采纳**。新增 §10 "GLM 1.0.3 API 阶段覆盖矩阵"，按头文件路径组织，逐项标注函数名、阶段覆盖状态（本阶段实现/本阶段 stub/后续阶段）、对应设计方案章节。覆盖 glm/matrix.hpp、glm/common.hpp（标量部分）、glm/geometric.hpp、glm/mat2x2~4x4.hpp、glm/fwd.hpp（矩阵别名）、glm/ext/ 矩阵相关、glm/gtc/ 和 glm/gtx/ 追踪 |
| **P4（中等）**：scalar_mat_ops.cj 全局函数签名完全缺失，实现者缺少泛型约束、参数顺序、@OverflowWrapping 标注等签名信息 | **已采纳**。在 §3.5 末尾新增 "scalar_mat_ops.cj 全局函数签名模板"段落，提供 add 的代表性签名模板（含 @OverflowWrapping、`T <: Number<T>` 约束、标量在前矩阵在后的参数约定），并注明其余 8 个矩阵类型的变体模式和 sub/mul/div 的签名模式 |
| **P5（一般）**：col() 越界错误处理未明确声明，虽然等价性暗示了相同行为，但设计文档中应显式声明 | **已采纳**。§3.4 col() 描述后补充"下标越界时抛出 Exception，与 [] 行为一致" |

---

## 修订说明（v29）

| 审查意见 | 修改措施 |
|---------|---------|
| **F1（严重）**：§3.6 L483 NaN 比较语义描述存在事实错误——声称"任何涉及 NaN 的比较结果为 false"，但 `NaN != NaN` 在 IEEE 754 下为 true | **已采纳**。将 L483 NaN 比较行为描述修正为精确表述：区分 ==/equalExact（对 NaN 返回 false）与 !=（因实现为 !(this == rhs)，NaN != NaN 返回 true）。同时补充 equalEpsilon 的 NaN 行为取决于底层 Vec 实现的说明 |
| **F2（一般）**：§3.3 item 8 L290 声称 identity() "对所有 9 种矩阵类型均提供"，但 L303 注释指出 Bool 矩阵不提供此操作，自相矛盾 | **已采纳**。L290 正文修正为"对所有 9 种尺寸的矩阵类型均提供（Bool 元素类型除外，见 D33）"，消除与 L303 注释的显式矛盾 |
| **F3（一般）**：§3.5 复合赋值回退方案表中方阵 /=(Mat) 和 *=(Mat) 被列为"手动定义"运算符，但未说明本阶段执行时抛出 stub 异常 | **已采纳**。在复合赋值回退方案表下方新增注释段落，明确方阵的 `*=(Mat)` 和 `/=(Mat)` 依赖 inverse stub，本阶段执行时抛出 stub 异常，实际可用性取决于阶段三完整实现 |
