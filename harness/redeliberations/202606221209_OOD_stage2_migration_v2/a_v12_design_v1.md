# GLM 1.0.3 仓颉迁移阶段二 OOD 设计方案（v23）

> **修订日期**：2026-06-22（v23 迭代）

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

此统一策略适用于本设计中所有需要 T(0)/T(1) 的场景：`identity()` 工厂函数、`filled(scalar: T)` 工厂函数、跨矩阵类型转换工厂函数。

---

## 2. 模块划分

### 包组织

```
package glm.detail          — 核心实现层（新增/修改文件以 ★ 标记）
  ├── type_mat2x2.cj ★     — Mat2x2<T,Q> 结构体定义 + extend 块中的运算符
  ├── type_mat2x3.cj ★     — Mat2x3<T,Q>
  ├── type_mat2x4.cj ★     — Mat2x4<T,Q>
  ├── type_mat3x2.cj ★     — Mat3x2<T,Q>
  ├── type_mat3x3.cj ★     — Mat3x3<T,Q>
  ├── type_mat3x4.cj ★     — Mat3x4<T,Q>
  ├── type_mat4x2.cj ★     — Mat4x2<T,Q>
  ├── type_mat4x3.cj ★     — Mat4x3<T,Q>
  ├── type_mat4x4.cj ★     — Mat4x4<T,Q>
  ├── common.cj ★           — stub（仅函数签名空壳，供 type_mat3x3/type_mat4x4 依赖闭合）
  ├── matrix.cj ★           — 部分实现 + 部分 stub。直接实现的函数（27 个重载，可通过索引映射简单实现）：transpose（9 个重载）、matrixCompMult（9 个重载）、outerProduct（9 个重载）；stub 空壳函数（6 个重载，仅签名空壳，函数体 throw Exception("stub")）：determinant（3 个重载）、inverse（3 个重载）。供 type_mat2x2/type_mat3x3/type_mat4x4 依赖闭合
  ├── geometric.cj ★        — stub（仅函数签名空壳，供 type_mat4x4 依赖闭合）
   ├── scalar_mat_ops.cj ★   — 标量-矩阵运算全局具名函数（add、sub、mul、div），处理 T + Mat 等标量左侧运算
   │                          （与 scalar_vec_ops.cj 同属 glm.detail，通过参数类型重载区分）
   │                          全部 36 个函数标注 @OverflowWrapping
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
   - **矩阵-列向量乘法 Mat×Vec（矩阵成员运算符）**：每个矩阵类型在其 extend 块中定义一个 `operator*(v: VecR<T,Q>): VecC<T,Q>` 成员运算符，其中 R 为矩阵行数（列向量维数），C 为矩阵列数（结果向量维数）。完整签名如下：

     | 矩阵类型 | 运算符签名 | 结果向量类型 |
     |---------|-----------|------------|
     | Mat2x2<T,Q> | `operator func *(v: Vec2<T,Q>): Vec2<T,Q>` | Vec2<T,Q> |
     | Mat2x3<T,Q> | `operator func *(v: Vec3<T,Q>): Vec2<T,Q>` | Vec2<T,Q> |
     | Mat2x4<T,Q> | `operator func *(v: Vec4<T,Q>): Vec2<T,Q>` | Vec2<T,Q> |
     | Mat3x2<T,Q> | `operator func *(v: Vec2<T,Q>): Vec3<T,Q>` | Vec3<T,Q> |
     | Mat3x3<T,Q> | `operator func *(v: Vec3<T,Q>): Vec3<T,Q>` | Vec3<T,Q> |
     | Mat3x4<T,Q> | `operator func *(v: Vec4<T,Q>): Vec3<T,Q>` | Vec3<T,Q> |
     | Mat4x2<T,Q> | `operator func *(v: Vec2<T,Q>): Vec4<T,Q>` | Vec4<T,Q> |
     | Mat4x3<T,Q> | `operator func *(v: Vec3<T,Q>): Vec4<T,Q>` | Vec4<T,Q> |
     | Mat4x4<T,Q> | `operator func *(v: Vec4<T,Q>): Vec4<T,Q>` | Vec4<T,Q> |

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

1. **逐分量同类型构造** — const init 可用，纯赋值
2. **列向量构造** — const init 可用，纯赋值
3. **标量填充构造 filled(scalar: T)** — extend 块工厂函数，Number<T> 约束，非 const。对角填充：位置 `(i,i)`（`i = 0..min(C,R)-1`）的元素使用 scalar，其余所有位置使用 `T(0) = scalar - scalar`。非方阵 filled 示例：Mat2x4<Float32,PackedHighp>.filled(1.0f) 形成数学表示
   ```
   [1.0  0.0]
   [0.0  1.0]
   [0.0  0.0]
   [0.0  0.0]
   ```
   即主对角线 `(0,0)` 和 `(1,1)` 为 1.0，其余为 0.0 的 4×2 矩阵。（Bool 矩阵不提供此操作，见 D33）
4. **跨类型逐分量构造 fromParts(conv, ...)** — extend 块工厂函数，仅 Qualifier 约束，非 const。参数按列主序排列，共 C×R 个分量（C=列数，R=行数）。各矩阵族完整签名示例如下（通用 where 子句 `Q <: Qualifier, P <: Qualifier` 略）：

   | 矩阵类型 | 签名示例 |
   |---------|---------|
   | Mat2x2<T,Q> | `public static func fromParts<U, P>(conv: (U) -> T, a00: U, a01: U, a10: U, a11: U): Mat2x2<T,Q> where Q <: Qualifier, P <: Qualifier` |
   | Mat2x3<T,Q> | `public static func fromParts<U, P>(conv: (U) -> T, a00: U, a01: U, a02: U, a10: U, a11: U, a12: U): Mat2x3<T,Q> where Q <: Qualifier, P <: Qualifier` |
   | Mat2x4<T,Q> | `public static func fromParts<U, P>(conv: (U) -> T, a00: U, a01: U, a02: U, a03: U, a10: U, a11: U, a12: U, a13: U): Mat2x4<T,Q> where Q <: Qualifier, P <: Qualifier` |
   | Mat3x2<T,Q> | `public static func fromParts<U, P>(conv: (U) -> T, a00: U, a01: U, a10: U, a11: U, a20: U, a21: U): Mat3x2<T,Q> where Q <: Qualifier, P <: Qualifier` |
   | Mat3x3<T,Q> | `public static func fromParts<U, P>(conv: (U) -> T, a00: U, a01: U, a02: U, a10: U, a11: U, a12: U, a20: U, a21: U, a22: U): Mat3x3<T,Q> where Q <: Qualifier, P <: Qualifier` |
   | Mat3x4<T,Q> | `public static func fromParts<U, P>(conv: (U) -> T, a00: U, a01: U, a02: U, a03: U, a10: U, a11: U, a12: U, a13: U, a20: U, a21: U, a22: U, a23: U): Mat3x4<T,Q> where Q <: Qualifier, P <: Qualifier` |
   | Mat4x2<T,Q> | `public static func fromParts<U, P>(conv: (U) -> T, a00: U, a01: U, a10: U, a11: U, a20: U, a21: U, a30: U, a31: U): Mat4x2<T,Q> where Q <: Qualifier, P <: Qualifier` |
   | Mat4x3<T,Q> | `public static func fromParts<U, P>(conv: (U) -> T, a00: U, a01: U, a02: U, a10: U, a11: U, a12: U, a20: U, a21: U, a22: U, a30: U, a31: U, a32: U): Mat4x3<T,Q> where Q <: Qualifier, P <: Qualifier` |
   | Mat4x4<T,Q> | `public static func fromParts<U, P>(conv: (U) -> T, a00: U, a01: U, a02: U, a03: U, a10: U, a11: U, a12: U, a13: U, a20: U, a21: U, a22: U, a23: U, a30: U, a31: U, a32: U, a33: U): Mat4x4<T,Q> where Q <: Qualifier, P <: Qualifier` |

   参数命名约定 `a{列}{行}`：例如 Mat2x3 的参数序列为 `a00,a01,a02`（列 0 三行）、`a10,a11,a12`（列 1 三行），与 GLM 1.0.3 的列主序构造函数签名在参数排列顺序上一致。参数命名约定差异：本设计使用 `a{列}{行}`（如 `a00` 表示列 0 行 0 的元素），而 GLM 源码使用 `{x,y,z,w}{列}`（如 `x0` 表示列 0 的第一个分量、`y0` 表示列 0 的第二个分量）。转换示例：本设计的 `fromParts(conv, a00, a01, a10, a11)` 在 GLM 中的等价构造函数为 `mat(col0, col1)`，列向量分量的对应关系为 `a{列}0 ↔ x{列}`、`a{列}1 ↔ y{列}`、`a{列}2 ↔ z{列}`、`a{列}3 ↔ w{列}`。

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
    - **行扩展规则**：当目标矩阵行数 R 大于源矩阵行数时，新增行中位于对角线 `(i,i)` 位置（`i ≥ R_src` 且 `i < min(C_dst, R_dst)`）的元素填入 `one`，其余新增行元素填入 `T(0)`。
   - **列收缩/行收缩规则**：直接截断（丢弃超出部分）。

    - **6a（同类型不同尺寸）**：源矩阵和目标矩阵元素类型 T 相同，Qualifier 可相同也可不同，仅尺寸不同。需要 T(1) 通过 `one: T` 参数传入，T(0) 通过 `Number<T>` 约束下的 `scalar - scalar` 演算获得。
      - 签名示例（以 Mat2x2→Mat2x3 为例）：`public static func fromMat<P>(m: Mat2x2<T,P>, one: T): Mat2x3<T,Q> where T <: Number<T>, Q <: Qualifier, P <: Qualifier`
     - 适用于尺寸扩展方向（R_src<R_dst 或 C_src<C_dst）、收缩方向（R_src>R_dst 或 C_src>C_dst）以及同尺寸退化情况
     - B 类方向（C_src=C_dst, R_src<R_dst）的 GLM .inl 逐项对照分析见下方映射表

   - **6b（跨类型不同尺寸）**：源矩阵元素类型 U 和目标元素类型 T 不同，尺寸也不同。需要 conv 闭包将 U 转换为 T、`one: T` 参数和 `Number<T>` 约束。
     - 签名示例（以 Mat2x2<U,P>→Mat2x3<T,Q> 为例）：`public static func fromMat<U, P>(conv: (U) -> T, m: Mat2x2<U,P>, one: T): Mat2x3<T,Q> where T <: Number<T>, Q <: Qualifier, P <: Qualifier`
     - 填充规则同 6a，额外对每个源元素应用 conv 转换

7. **跨类型同尺寸转换（fromMat(conv, m)）** — 源和目标尺寸相同（C 和 R 分别相等），仅元素类型不同（如 Float64←Float32）。无需 T(0)/T(1) 演算，只需逐元素应用 conv 转换。
   - 签名示例（以 Mat4x4<U,P>→Mat4x4<T,Q> 为例）：`public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x4<U,P>): Mat4x4<T,Q> where Q <: Qualifier, P <: Qualifier`
   - 无需 `T <: Number<T>` 约束，因此 **Bool 矩阵支持此操作**。当目标类型 T=Bool 时，conv 闭包通常需使用比较表达式（如 `{ x => x != 0 }`）而非构造函数调用，因为 Bool 类型可能没有从数值类型直接构造的函数

8. **单位矩阵工厂函数 identity(one: T)** — 对所有 9 种矩阵类型均提供。行为定义：
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

**B 类方向与 GLM .inl 逐项对照分析**：

| 方向 | GLM 源码 | GLM 实现 | 与主规则一致性 |
|------|---------|---------|--------------|
| Mat2x3←Mat2x2 | type_mat2x3.inl:122 | `col_type(m[0],0), col_type(m[1],0)` | ✅ 一致 |
| Mat2x4←Mat2x2 | type_mat2x4.inl:124 | `col_type(m[0],0,0), col_type(m[1],0,0)` | ✅ 一致 |
| Mat2x4←Mat2x3 | type_mat2x4.inl:160 | `col_type(m[0],0), col_type(m[1],0)` | ✅ 一致 |
| Mat3x3←Mat3x2 | type_mat3x3.inl:175 | `col_type(m[0],0), col_type(m[1],0), col_type(m[2],1)` | ⚠️ 对角线偏差 |
| Mat3x4←Mat3x2 | type_mat3x4.inl:191 | `col_type(m[0],0,0), col_type(m[1],0,0), col_type(m[2],1,0)` | ⚠️ 对角线偏差 |
| Mat3x4←Mat3x3 | type_mat3x4.inl:152 | `col_type(m[0],0), col_type(m[1],0), col_type(m[2],0)` | ✅ 一致 |
| Mat4x3←Mat4x2 | type_mat4x3.inl:228 | `col_type(m[0],0), col_type(m[1],0), col_type(m[2],1), col_type(m[3],0)` | ✅ 一致 |
| Mat4x4←Mat4x2 | type_mat4x4.inl:246 | `col_type(m[0],0,0), col_type(m[1],0,0), col_type(0,0,1,0), col_type(0,0,0,1)` | ❌ **有偏差** |
| Mat4x4←Mat4x3 | type_mat4x4.inl:274 | `col_type(m[0],0), col_type(m[1],0), col_type(m[2],0), col_type(m[3],1)` | ✅ 一致 |

**偏差详情**：
- **Mat4x4←Mat4x2**：GLM 对列 2 和列 3 使用 `col_type(0,0,1,0)` 和 `col_type(0,0,0,1)`，完全丢弃了源矩阵列 2、3 的前两行数据。主规则会先复制源矩阵列 2、3 的前两行（`src[2][0..1]` 和 `src[3][0..1]`），再填充扩展行——与 GLM 行为不同。编码阶段须针对 Mat4x4←Mat4x2 实现特殊处理。
- **Mat3x3←Mat3x2 和 Mat3x4←Mat3x2**：GLM 在新增行的对角线位置 `(2,2)` 填入 `one`，而非 T(0)。此偏差源于 GLM 在行扩展生成的新行中将对角线元素设为单位矩阵值 `one`，与修正后的主规则（对角线 `(i,i)` 在行扩展区域填入 `one`）一致，故编码阶段按修正后主规则实现即可，无需特殊处理。

**列扩展/行扩展规则的拆分确认**：上述 B 类方向分析表覆盖了 9 个列数不变（C_src=C_dst）而仅行扩展的场景。这些场景完全遵循行扩展规则（新增行元素全部为 T(0)）。列扩展规则（C_src<C_dst，R 任意）在 B 类方向中不出现（B 类定义为 C_src=C_dst，仅 R 增加）。同时涉及列和行变化的非 B 类方向在下方 **非 B 类方向对照分析** 中验证。

**非 B 类方向对照分析**：fromMat 6a 共覆盖 72 个转换方向（9 源 × 8 目标 − 9 同尺寸 = 72），除前述 9 个 B 类方向外，其余 63 个涉及 C 和/或 R 的变化。以下选取 3 组代表性方向进行 GLM 行为分析：

| 方向 | C/R 变化模式 | 主规则预期 | GLM 验证状态 |
|------|-------------|-----------|-------------|
| Mat4x4←Mat2x2 | C:2→4 扩展, R:2→4 扩展（双扩展） | 复制 2×2 重叠块；列扩展：列 2 填入 Vec4(T(0),T(0),one,T(0))、列 3 填入 Vec4(T(0),T(0),T(0),one)；行扩展：列 0/1 行 2/3 为 T(0) | **待编码阶段验证** |
| Mat2x4←Mat3x2 | C:3→2 收缩, R:2→4 扩展（C 缩 R 扩） | 复制 2×2 重叠块；列收缩：丢弃源列 2；行扩展：列 0/1 行 2/3 为 T(0) | **待编码阶段验证** |
| Mat4x2←Mat2x3 | C:2→4 扩展, R:3→2 收缩（C 扩 R 缩） | 复制 2×2 重叠块；列扩展：列 2 和列 3 因新列索引 ≥ R=2，整列全部为 Vec2(T(0),T(0))；行收缩：列 0/1 丢弃源行 2 | **待编码阶段验证** |

**编码阶段验证要求**：
- 对以上 3 个代表方向，分别构造非平凡源矩阵（各元素填入可识别的非零/非 one 值），转换后逐元素验证主规则预期
- 若 GLM 行为与主规则预期不符，记录具体偏差并参照 Mat4x4←Mat4x2 处理模式（在对应方向实现中采用特殊处理）
- 其余 63 个非 B 类方向按偏差风险分组编码验证：

  | 风险等级 | 方向特征 | 大致数量 | 说明 |
  |---------|---------|---------|------|
  | **高风险** | 同时涉及 C 收缩和 R 扩展（C 缩 R 扩），与 Mat2x4←Mat3x2 同模式 | ~24 | 偏差概率最高，优先验证 |
  | **中风险** | 同时涉及 C 扩展和 R 收缩（C 扩 R 缩），与 Mat4x2←Mat2x3 同模式 | ~12 | 次优先验证 |
  | **低风险** | C 和 R 同时扩展或同时收缩（C/R 同向），仅涉及单一规则组合 | ~27 | 偏差概率最低，批量验证 |

  编码阶段按高→中→低优先级依次验证。高风险组应在实现后立即验证，低风险组可在全面测试阶段统一覆盖。

**B 类方向单元测试验证要求**：
- 为 Mat4x4←Mat4x2 编写专用测试：构造源矩阵（列 2、3 前两行填入非零值），转换后验证列 2=Vec4(0,0,1,0)、列 3=Vec4(0,0,0,1)，确认源数据被丢弃
- 为其余 8 个 B 类方向编写验证：构造非零源矩阵，确认扩展行符合主规则预期

### 3.4 行列访问

- **下标运算符** `[](i: Int64)`：取值版本返回列向量副本，赋值版本需 mut 修饰符
- **具名列访问函数** `col(i: Int64)`：与 `[]` 完全等价
- `col()` 替代 `componentAt()` 以避免与 Vec 的语义冲突
- 行访问 `row()` 推迟至阶段四

### 3.5 算术运算符

- 一元负号、矩阵-标量 ±*/（成员运算符）、标量-矩阵 ±*/（scalar_mat_ops.cj 全局函数）
- 矩阵-矩阵 ±（同尺寸）、*（含 27 个乘法重载：3 同尺寸 + 24 跨尺寸）
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

非方阵仅不定义 *=(Mat)（矩阵乘法）和 /=(Mat)（矩阵除法）复合赋值，因乘法结果类型与左操作数类型不一致。标量运算 *=(T) 和 /=(T) 对所有 9 种矩阵类型均需定义。

### 3.6 比较运算符

定义在 Equatable<T> 约束的 extend 块中（与阶段一 Vec 类型一致）：
- == 和 !=：逐列比较，所有列相等则矩阵相等
- equalExact(other)：具名精确比较，与 == 行为语义等价但为显式具名版本，可供需要强调"精确相等"语义的场景使用

定义在 Number<T> & Equatable<T> & Comparable<T> 约束的 extend 块中：
- equalEpsilon(other)：浮点容差比较，实现方式为逐列委托 VecR<T,Q>.equalEpsilon，与 == 逐列委托 VecR<T,Q>.== 的模式一致

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
    - `func transpose<T, Q>(m: Mat2x2<T, Q>): Mat2x2<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func transpose<T, Q>(m: Mat2x3<T, Q>): Mat3x2<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func transpose<T, Q>(m: Mat2x4<T, Q>): Mat4x2<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func transpose<T, Q>(m: Mat3x2<T, Q>): Mat2x3<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func transpose<T, Q>(m: Mat3x3<T, Q>): Mat3x3<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func transpose<T, Q>(m: Mat3x4<T, Q>): Mat4x3<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func transpose<T, Q>(m: Mat4x2<T, Q>): Mat2x4<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func transpose<T, Q>(m: Mat4x3<T, Q>): Mat3x4<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func transpose<T, Q>(m: Mat4x4<T, Q>): Mat4x4<T, Q> where T <: Number<T>, Q <: Qualifier`
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

**直接实现说明**（transpose、matrixCompMult、outerProduct 共 27 个重载）：
- **transpose**：对每个矩阵尺寸版本，按固定行列索引映射重组元素。以 Mat2x3→Mat3x2 为例：`dst.c0 = Vec3(src[0][0], src[1][0], src[2][0])`、`dst.c1 = Vec3(src[0][1], src[1][1], src[2][1])`。由于每个矩阵尺寸的列数/行数固定且已知（C,R≤4），转置索引映射可在代码中硬编码展开，无需循环。
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
let m = Mat4x4<Float32, PackedHighp>.filled(1.0f)       // 对角矩阵
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
- 算术复合赋值运算符标注 @OverflowWrapping
- scalar_mat_ops.cj 全部 36 个函数标注 @OverflowWrapping

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
| D33 | Bool 矩阵不提供算术运算符、标量填充和 equalEpsilon | Bool 不实现 Number<T> 接口，无法参与算术运算、标量填充；同时因 equalEpsilon 需要 Number<T> 约束，Bool 矩阵也不提供 equalEpsilon 函数。仍支持构造、下标访问、比较（==/!=/equalExact）和 @Derive[Hashable]。Bool 矩阵支持 fromMat 7（跨类型同尺寸转换），因为该操作仅需 conv 闭包和 Qualifier 约束，无需 Number<T>；但 fromMat 6a/6b（跨类型跨尺寸转换）需 T(0)/T(1) 演算，依赖 Number<T> 约束，Bool 矩阵不支持 |

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
- **编码启动前验证项**：cjpm 子包构建预验证、复合赋值运算符自动生成验证、Mat4x4←Mat4x2 fromMat 偏差验证、@Derive[Hashable] T=Bool 编译验证

### compile order 说明：Vec 类型 extend 块中的行向量×矩阵运算符

行向量×矩阵乘法 `Vec{R} * Mat{C}x{R} → Vec{C}` 定义在 Vec{R} 类型的 extend 块中（type_vecN.cj 文件）。这些 extend 块引用了矩阵类型（Mat2x2, Mat2x3, ..., Mat4x4），而矩阵类型定义在同包（glm.detail）的不同文件中。

**编译顺序说明**【待验证】：关于"仓颉编译器在同包内支持对前向类型引用的延迟解析"的声明，当前未经官方文档引用或实验验证。编码启动首日须进行最小原型验证：创建包含 Vec extend 块引用矩阵类型的同包文件并编译，确认编译器是否支持此行为。

若验证失败（编译器不支持同包内前向类型引用的延迟解析），采用以下递进 fallback 方案：

- **方案一（首选）**：将行向量×矩阵乘法定义为同包全局自由函数（放入 `type_vecN.cj` 末尾），利用仓颉的函数重载按 (VecR, Mat{C}x{R}) 参数类型对区分。函数签名如 `func mul_row_vec_mat(v: Vec2<T,Q>, m: Mat2x2<T,Q>): Vec2<T,Q>`、`func mul_row_vec_mat(v: Vec4<T,Q>, m: Mat4x4<T,Q>): Vec4<T,Q>` 等（共 12 个重载，覆盖 Vec1~Vec4 与对应行数矩阵的乘法组合），不涉及类型上的 extend，无编译顺序依赖。
  - **API 变化影响**：此方案将 `v * m` 运算符调用改为全局具名函数调用 `mul_row_vec_mat(v, m)`，完全改变了调用语法，不再是运算符重载。下游代码中所有行向量×矩阵的乘法表达式均需修改——用户迁移需将 `v * m` 改写为 `mul_row_vec_mat(v, m)`。此变化不可自动迁移，需通知所有使用者。
- **方案二（备选）**：在矩阵类型文件的末尾，以额外 extend 块方式定义 Vec 扩展。此方式利用仓颉"同包内任意文件均可扩展类型"的特性，确保 extend 块出现在矩阵类型定义之后。例如在 `type_mat4x4.cj` 末尾追加 `extend Vec4 { operator func *(m: Mat4x4<T,Q>): Vec4<T,Q> }`。
  - **与方案三的实际区别**：方案二将 Vec 扩展分散到 9 个矩阵类型文件中，每个矩阵文件末尾追加 R 对应 Vec 的 extend 块——9 个文件各追加 1 个 extend 块（共 9 块，每块含 1 个运算符），代码重复度较低（每个 extend 块仅 3 行）。方案三将全部 12 个运算符集中到 1 个独立文件中，总代码量与方案二相当，但避免了修改矩阵类型文件。方案二和方案三的本质区别是"分散在已有文件末尾" vs "集中到独立文件"，二者无本质优劣，编码阶段可根据原型验证结果和包组织原则任选其一。
- **方案三（第三备选）**：若方案一、二均不可行，将 Vec extend 块拆入独立文件 `type_row_vec_mul.cj`，在文件组织上确保此文件出现在所有矩阵类型文件之后。

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

**MediumpMat 家族（Float32, PackedMediump）** — 9 个 PascalCase + 3 个方阵短别名。

**LowpMat 家族（Float32, PackedLowp）** — 9 个 PascalCase + 3 个方阵短别名。

**HighpDMat 家族（Float64, PackedHighp）** — 9 个 PascalCase + 3 个方阵短别名（`HighpDMat2`/`HighpDMat3`/`HighpDMat4`）。

**MediumpDMat 家族（Float64, PackedMediump）** — 9 个 PascalCase + 3 个方阵短别名。

**LowpDMat 家族（Float64, PackedLowp）** — 9 个 PascalCase + 3 个方阵短别名。LowpDMat 和 MediumpDMat 方阵短别名命名模式同 HighpDMat，即 `{Lowp|Mediump}DMat{C}`，如 LowpDMat2/LowpDMat3/LowpDMat4、MediumpDMat2/MediumpDMat3/MediumpDMat4。

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
| **filled 为工厂函数** | 需要 Number<T> 约束获取 T(0) |
| **fromMat 拆分为 6a/6b/7** | 6a（同类型不同尺寸）和 6b（跨类型跨尺寸）需 Number<T> 约束 + one 参数；7（跨类型同尺寸）仅需 conv 闭包 + Qualifier 约束，Bool 矩阵也可使用。**6a 范围**：源和目标矩阵元素类型 T 相同，Qualifier 可相同也可不同（通过额外泛型参数 P 指定源 Qualifier）。当用户需要跨 Qualifier 且尺寸不同时，6a 即可满足（无需降级到 6b）；6b reserved for 元素类型也不同（额外 conv 闭包）的场景。 |
| **fromParts/fromColumns 仅支持单一源类型** | 仓颉泛型签名限制 |
| **`[]` 和 `col()` 不可在 const 上下文** | 含 assert + throw |
| **`identity(one)` 和 `filled(scalar)` 不可在 const 上下文** | 涉及运算 |
| **`length()` 为静态成员函数，与 Vec 类型一致** | 与 C++ GLM `mat4::length()` 一致，也同本库 Vec 类型的 `public static func length()` 风格一致。调用方式统一为 `Mat4x4.length()`（类型别名 `Mat4x4` 调用）或 `Mat2x2<T,Q>.length()`（泛型结构体直接调用），仓颉编译器自动解析类型别名的静态成员。 |
| **行向量×矩阵运算符在 Vec extend 块中** | 因左操作数类型拥有运算符，编译顺序依赖同包延迟解析（待原型验证）。若失败，见 §8 fallback 方案一：API 形态从 `v * m` 退化为 `mul_row_vec_mat(v, m)` |
| **Mat4x4←Mat4x2 转换行为偏离主规则** | 源矩阵列 2、3 的前两行数据被丢弃，替换为单位矩阵值 |
| **Bool 矩阵不提供算术运算符、标量填充工厂函数和 equalEpsilon** | Bool 不实现 Number<T> 接口，无法参与 ±*/ 等算术运算，不提供 filled()/identity()（依赖 Number<T> 约束）；同时因 equalEpsilon 需要 Number<T> 约束，Bool 矩阵也不提供 equalEpsilon 函数。Bool 矩阵仍支持构造（逐分量/列向量）、下标访问、length()、比较（==/!=/equalExact）和 @Derive[Hashable]。Bool 矩阵支持 fromMat 7（跨类型同尺寸转换，仅需 conv 闭包 + Qualifier 约束，无需 Number<T>），但不支持 fromMat 6a/6b（需 T(0)/T(1) 演算，依赖 Number<T> 约束） |
| **矩阵类型提供 equalExact 比较函数** | 与阶段一 Vec 类型一致，矩阵类型在 Equatable<T> 约束的 extend 块中提供 equalExact(other) 具名精确比较函数，行为与 == 语义等价 |

---

## 修订说明（v22）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题1（中等）**：fromParts 家族签名模板的参数数量存在结构矛盾，Mat4xR 固定 16 分量模板与 R=2/R=3 需求矛盾 | **已采纳**。§3.3 item 4 将 3 族家族模板替换为 9 个矩阵类型的独立签名表，逐一列出列主序排列的完整参数序列，参数数量为对应 C×R，与 fromColumns（item 5）的表格式一致 |
| **问题2（轻微）**：filled(scalar) 与 identity(one) 的 Bool 矩阵排除边界未在声明位置标注 | **已采纳**。§3.3 item 3（filled）末尾和 item 8（identity）末尾各添加 "(Bool 矩阵不提供此操作，见 D33)" 交叉引用 |
| **问题3（轻微）**：HighpDMat 方阵短别名 `Highpdmat2`/`Highpdmat3`/`Highpdmat4` 与 PascalCase 模式不一致 | **已采纳**。§8 fwd.cj 清单中 HighpDMat 家族的方阵短别名统一为 `HighpDMat2`/`HighpDMat3`/`HighpDMat4` |
| **问题4（轻微）**：fromMat item 7（同尺寸跨类型）的 Bool 支持未说明 conv 闭包的使用模式 | **已采纳**。§3.3 item 7 末尾补充说明：当目标 T=Bool 时，conv 闭包通常需使用比较表达式（如 `{ x => x != 0 }`）而非构造函数调用 |
| **问题5（轻微）**：§8 compile order fallback 方案一（全局自由函数）对 API 调用语法的破坏性变更影响范围未在 §9 记录 | **已采纳**。§9 行向量×矩阵运算符差异条目末尾补充交叉引用："若失败，见 §8 fallback 方案一：API 形态从 `v * m` 退化为 `mul_row_vec_mat(v, m)`" |
| **问题6（轻微）**：§8 lib.cj 的导出粒度未定义 | **已采纳**。§8 产出物清单中 lib.cj 条目扩展为三级导出清单：(1) 导出全部 9 个 detail 矩阵类型；(2) 导出 transpose/matrixCompMult/outerProduct 可直接实现函数；(3) 导出 scalar_mat_ops.cj 全局函数；(4) 声明不直接导出 ext/ 别名文件 |
| **问题7（轻微）**：非方阵 *= 不可用的实现指导不够明确 | **已采纳**。§3.5 复合赋值回退方案表后添加说明："非方阵不定义 *=(Mat) 和 /=(Mat) 运算符，因乘法结果类型与左操作数类型不一致。" |

## 修订说明（v17）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题1（中等）**：cjpm 子包构建风险缺乏充分应对方案 | **已采纳**。① 将预验证段落扩展为"增强方案"，包含方案一（package glm.ext，首选）、方案二（移至 src/ 根目录，含完整的冲突风险分析表）和方案三（独立子模块）三个递进方案；② 补充详细原型验证步骤；③ 说明 cjpm.toml 可能需要的额外子包配置 |
| **问题2（轻微）**：复合赋值运算符自动生成假设的 fallback 工作量被低估 | **已采纳**。① 补充完整的手动定义回退方案文件分布表，按 9 个矩阵类型文件逐一列出需定义的运算符和数量；② 修正手动定义总数为 60 个（含 6 个标量运算 × 9 种矩阵 + 6 个同尺寸矩阵运算 ± + 仅方阵的 6 个 */=）；③ 注释 *= 仅出现在 3 个方阵文件的原因 |
| **问题3（中等）**：B 类 fromMat 转换方向的行为契约不完整 | **已采纳**。① 逐一查阅 GLM 1.0.3 全部 9 个 .inl 文件中对应的转换构造函数源码，形成逐项对照分析表；② 结论：9 个 B 类方向中 8 个与主规则一致，仅 Mat4x4←Mat4x2（type_mat4x4.inl:246-257）存在实际偏差——GLM 丢弃列 2、3 的源数据；③ 补充偏差详情和编码阶段特殊处理要求；④ 补充 B 类方向单元测试验证要求 |
| **问题4（轻微）**：Vec 类型 extend 块中矩阵乘法运算符编译顺序未明确 | **已采纳**。① §8 新增"compile order 说明"子节，分析仓颉编译器的同包延迟解析机制；② 确认同包内类型引用不依赖文件编译顺序；③ 补充编码阶段建议的文件组织顺序（非编译强制） |
| **问题5（轻微）**：@Derive[Hashable] 对 Bool 的推导结论缺少全面验证 | **已采纳**。① 在 §3.1 矩阵结构体职责中保留已有 T=Bool 可行性论证；② 列入编码启动前验证项；③ 若编译时验证失败，备选方案为移除矩阵的 @Derive[Hashable] 并手动实现（与阶段一 Vec<Bool,Q> 的 Hashable 策略一致） |
| **问题6（轻微）**：§9 差异声明未记录 const func length() 与 C++ GLM 的行为差异 | **已采纳**。① §9 差异声明新增"length() 为实例成员函数而非静态函数"条目；② §7 设计决策末尾补充 length() 差异说明；③ 明确 C++ GLM 调用方式 `mat4::length()` vs 仓颉 `m.length()` |

---

## 修订说明（v18）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题1（中等）**：fwd.cj 矩阵别名新增的具体内容未定义 | **已采纳**。在 §8 新增"fwd.cj 矩阵类型别名新增清单"子节，按 Mat/DMat/HighpMat/MediumpMat/LowpMat/HighpDMat/MediumpDMat/LowpDMat 共 8 个元素类型家族分组枚举全部 108 个新增别名，包括 PascalCase 全尺寸别名、方阵短别名和非方阵 camelCase 别名；并列明不纳入的 fmat/f32mat/f64mat 和整型系列及其排除理由 |
| **问题2（中等）**：stub 文件缺少函数签名清单 | **已采纳**。§3.7 扩展为完整的函数签名清单：common.cj 包含 12 个标量函数签名（min/max/abs/sign/floor/ceil/fract/mod/clamp/mix/step/smoothstep）；matrix.cj 包含 33 个签名（transpose×9 + determinant×3 + inverse×3 + matrixCompMult×9 + outerProduct×9）；geometric.cj 包含 20 个签名（dot×4 + cross×1 + normalize×3 + length×3 + distance×3 + reflect×3 + refract×3） |
| **问题3（中等）**：Vec 类型 extend 块中行向量×矩阵乘法运算符的具体签名未定义 | **已采纳**。§2 包组织中 type_vecN.cj 条目扩展为按 Vec1~Vec4 逐一列出每个类型的 operator * 签名：Vec4 extend 块含 3 个（Mat2x4/Mat3x4/Mat4x4），Vec3 extend 块含 3 个（Mat2x3/Mat3x3/Mat4x3），Vec2 extend 块含 3 个（Mat2x2/Mat3x2/Mat4x2），Vec1 无有效目标（未定义行数=1 的矩阵类型） |
| **问题4（轻微）**：Bool 矩阵类型的支持策略未明确 | **已采纳**。① §7 新增 D33 记录 Bool 矩阵支持范围决策；② §9 差异声明新增"Bool 矩阵不提供算术运算符和标量填充工厂函数"条目，明确 Bool 矩阵支持的操作范围（构造/下标/length/比较/Hashable）和排除的操作（算术/identity/filled/equalEpsilon）；③ 编码启动前验证项保留 @Derive[Hashable] T=Bool 验证 |
| **问题5（轻微）**：equalExact 函数是否对矩阵类型提供未明确 | **已采纳**。① §3.6 比较运算符扩展为三层结构：Equatable<T> 约束下的 ==/!=/equalExact，Number<T>&Equatable<T>&Comparable<T> 约束下的 equalEpsilon；② §9 差异声明新增"矩阵类型提供 equalExact 比较函数"条目 |

---

## 修订说明（v19）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题1（严重）**：矩阵-列向量乘法 Mat*Vec 运算符签名完全缺失 | **已采纳**。§2 包组织中，在 Vec extend 块下方新增"矩阵-列向量乘法 Mat×Vec（矩阵成员运算符）"子节，以表格形式列出全部 9 个矩阵类型的 `operator*(v: VecR<T,Q>): VecC<T,Q>` 成员运算符签名 |
| **问题2（中等）**：矩阵-矩阵乘法重载数量 29（3+26）与实际数学排列 27（3+24）不符 | **已采纳**。§3.5 算术运算符修正为"含 27 个乘法重载：3 同尺寸 + 24 跨尺寸" |
| **问题3（中等）**：手动定义数量推导中出现算术描述错误（6 标量运算 × 9 = 54） | **已采纳**。§3.5 手动定义总计说明修正为"含 4 标量运算运算符（+=, -=, *=, /=）覆盖 9 种矩阵 = 36，同尺寸矩阵 +=/-= 覆盖 9 种矩阵 = 18，仅 3 个方阵各多 *=(M) 和 /=(M) = 6，合计 60" |
| **问题4（轻微）**：filled(scalar) 的 T(0) 演算机制在具体语境中未明确 | **已采纳**。§3.3 第 3 条补充"对角填充：对角线元素使用 scalar，非对角线元素使用 T(0) = scalar - scalar" |
| **问题5（轻微）**：Bool 矩阵的 equalEpsilon 排除未在操作范围中明确说明 | **已采纳**。① D33 补充"因 equalEpsilon 需要 Number<T> 约束，Bool 矩阵也不提供 equalEpsilon 函数"；② §9 Bool 矩阵差异条目补充 equalEpsilon 排除说明 |
| **问题6（轻微）**："方案A"引用内部未解释的备选方案 | **已采纳**。① §2 移除"（方案A）"标签，仅保留 D32 的理由（左操作数类型拥有运算符）；② §3.5 算术运算符中同步移除"（方案A）" |

---

## 修订说明（v20）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题1（中等）**：§8 编译顺序分析依赖未经验证的编译器行为假设 | **已采纳**。① 将"按需解析/延迟解析"声明改为"【待验证】"标注；② 补充三档递进 fallback 方案：方案一（全局自由函数方案，无编译顺序依赖）、方案二（矩阵文件末尾追加 Vec extend 块）、方案三（独立文件 + 编译顺序保证）；③ §9 对应行向量×矩阵运算符差异条目同步更新为"编译顺序依赖同包延迟解析（待原型验证）"；④ 编码阶段建议由"编译强制"改为"推荐"|
| **问题2（中等）**：fromParts/fromColumns 工厂函数签名完全缺失 | **已采纳**。① §3.3 第 4 条（fromParts）扩展为按矩阵列数分族的签名示例表（Mat2xR/Mat3xR/Mat4xR 三族），明确参数数量为 C×R、列主序排列、命名约定为 `a{列}{行}`；② 第 5 条（fromColumns）扩展为全部 9 种矩阵类型的完整签名表，每种给出 conv 参数和列向量参数的具体类型 |
| **问题3（中等）**：fromMat 6a/6b/7 缺少完整泛型约束声明 | **已采纳**。① §3.3 第 6 条拆分为 6a/6b 两个子条，各提供完整泛型签名示例（含 `where` 子句：6a 需 `T <: Number<T>, Q <: Qualifier`，6b 需 `T <: Number<T>, Q <: Qualifier, P <: Qualifier`）；② 第 7 条提供完整签名示例（仅需 `Q <: Qualifier, P <: Qualifier`，无需 Number<T> 约束）；③ §9 差异条目 fromMat 同步更新为"6a/6b/7"三分法 |
| **问题4（轻微）**：length() API 与阶段一 Vec 风格不一致 | **已采纳**。① §3.1 将 `const func length(): Int64` 改为 `public static func length(): Int64`，与阶段一 Vec 类型的 `public static func length(): Int64` 风格一致；② §9 对应差异条目更新为"length() 为静态成员函数，与 Vec 类型一致"，调用方式相应改为 `Mat4x4.length()` |
| **问题5（轻微）**：Bool 矩阵 fromMat 跨类型转换支持未明确 | **已采纳**。① §3.3 第 7 条（fromMat 7）末尾明确注明"Bool 矩阵支持此操作"及其理由（无需 Number<T> 约束）；② §7 D33 补充 Bool 矩阵 fromMat 支持范围：fromMat 7 可用，fromMat 6a/6b 不可用；③ §9 Bool 矩阵差异条目同步补充 fromMat 支持范围说明 |

---

## 修订说明（v21）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题1（中等）**：填充规则描述"扩展列/行按单位矩阵填充"存在歧义，未区分列扩展与行扩展的差异 | **已采纳**。① §3.3 item 6 填充规则拆分为"列扩展规则""行扩展规则""列收缩/行收缩规则"三个明确子规则，各自给出 `one`/`T(0)` 的精确填充位置；② B 类方向对照表后补充"列扩展/行扩展规则的拆分确认"说明，澄清 B 类方向仅涉及行扩展，列扩展在非 B 类方向中验证 |
| **问题2（中等）**：非方阵 identity(one) 语义未明确定义 | **已采纳**。① §3.3 item 8 扩充为方阵/非方阵两段行为定义，明确非方阵主对角线（i = 0..min(C,R)-1）填入 one、其余 T(0)；② 附 Mat2x4 示例具体展示；③ §9 差异声明中 identity 条目同步体现非方阵的确定性语义 |
| **问题3（中等）**：fromMat 非 B 类方向（C 和 R 同时变化）行为未与 GLM 对照验证 | **已采纳**。① 在 B 类方向对照表后新增"非 B 类方向对照分析"表格，选取 3 组代表性方向：C/R 双扩展（Mat4x4←Mat2x2）、C 缩 R 扩（Mat2x4←Mat3x2）、C 扩 R 缩（Mat4x2←Mat2x3）；② 每组给出主规则预期和 GLM 验证状态（标注为待编码阶段验证）；③ 补充编码阶段验证要求和偏差处理模式 |
| **问题4（轻微）**：§8 fallback 方案一未讨论 API 契约变化对下游的影响 | **已采纳**。① §8 fallback 方案一补充"API 变化影响"子段落，说明全局自由函数将使用 `mul_row_vec_mat(v, m)` 而非 `v * m` 语法；② 明确此变化不可自动迁移，用户需修改所有调用点 |
| **问题5（中等）**：§2 matrix.cj "stub"标签与§3.7"附带提供"承诺自相矛盾 | **已采纳**。① §2 matrix.cj 条目修改为"部分实现 + 部分 stub"，区分可直接实现的 27 个重载（transpose、matrixCompMult、outerProduct）与 6 个 stub 空壳（determinant、inverse）；② §3.7 matrix.cj 函数清单后补充"直接实现说明"段落，对三类可直接实现函数各给出一句话实现描述；③ §3.7 matrix.cj 条目排序将直接实现函数置于 stub 函数之前，并在 matrix.cj 概要中明确区分两类 |
| **问题6（轻微）**：fromMat 6a 同 T 不同 Q 的跨尺寸转换缺口未文档化 | **已采纳**。① §9 差异声明中 fromMat 条目补充"6a 额外限制"子说明，明确 6a 不支持跨 Qualifier 的同类型不同尺寸转换，用户需跨 Qualifier 且尺寸不同时只能使用 6b |

---

## 修订说明（v23）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题1（严重）**：fromParts 签名表中 Mat2xR 和 Mat3xR 家族参数缺失 | **已采纳**。§3.3 item 4 修正 Mat2x2/Mat2x3/Mat2x4/Mat3x2/Mat3x3/Mat3x4 的 fromParts 签名参数数量为对应 C×R，与 Mat4xR 族格式一致 |
| **问题2（严重）**：B 类方向一致性分析存在误判 — Mat3x3←Mat3x2 和 Mat3x4←Mat3x2 实际与主规则不符 | **已采纳**。① 修正行扩展主规则：新增行中位于对角线 `(i,i)`（`i ≥ R_src` 且 `i < min(C_dst, R_dst)`）填入 `one`，其余新增行元素填入 `T(0)`；② B 类方向表中 Mat3x3←Mat3x2 和 Mat3x4←Mat3x2 标记为"⚠️ 对角线偏差"并补充偏差详情；③ 说明编码阶段按修正后主规则实现即可，无需特殊处理 |
| **问题3（中等）**：fromParts 命名约定 `a{列}{行}` 与 GLM 源码中 `{x,y,z,w}{列}` 的差异未说明 | **已采纳**。§3.3 item 4 命名约定段落补充 GLM 的 `{x,y,z,w}{列}` 命名差异说明及转换示例 |
| **问题4（中等）**：fromMat 6a 签名缺失 SrcQ 参数，跨 Qualifier 转换被强制降级到 6b | **已采纳**。① §3.3 item 6a 签名新增源 Qualifier 泛型参数 P，使 6a 支持跨 Qualifier 转换；② §9 fromMat 差异条目同步更新，移除"6a 额外限制"说明，改为 6a 支持跨 Qualifier |
| **问题5（中等）**：复合赋值运算符手动定义表中 *=(T) 对非方阵的适用性表述不够清晰 | **已采纳**。§3.5 手动定义表后注释明确为"非方阵仅不定义 *=(Mat) 和 /=(Mat)，标量运算 *=(T) 和 /=(T) 对所有 9 种矩阵类型均需定义" |
| **问题6（一般）**：非 B 类方向编码阶段验证任务范围过宽无优先级 | **已采纳**。§3.3 非 B 类方向编码验证要求替换为三档风险优先级分组表（高/中/低），编码阶段按高风险→中风险→低风险依次验证 |
| **问题7（一般）**：§8 compile order fallback 方案二与方案三的实际区别不清晰 | **已采纳**。§8 方案二条目补充与方案三的区别说明：方案二（分散到 9 个矩阵文件末尾，低重复度）vs 方案三（集中到独立文件），两者无本质优劣 |
| **问题8（一般）**：§2 包组织图中 scalar_mat_ops.cj 的 36 个函数未标注 @OverflowWrapping | **已采纳**。§2 scalar_mat_ops.cj 条目补充"全部 36 个函数标注 @OverflowWrapping" |
| **问题9（轻微）**：filled() 对角矩阵在非方阵上的行为示例与命名约定不一致 | **已采纳**。§3.3 item 3 filled 描述补充非方阵的数学矩阵表示（Mat2x4 示例），明确位置 `(i,i)` 的对角填充语义 |
| **问题10（轻微）**：§9 差异声明中 length() 条目与 §3.1/§7 存在调用形式不一致 | **已采纳**。§9 length() 差异条目统一为 `Mat4x4.length()` 调用形式，并补充说明类型别名 `Mat4x4` 与泛型结构体 `Mat2x2<T,Q>` 均可调用 |
| **问题11（轻微）**：fwd.cj 别名清单中精度变体方阵短别名命名风格未覆盖 Lowp 家族 | **已采纳**。§8 LowpDMat 家族别名条目补充"LowpDMat 和 MediumpDMat 方阵短别名命名模式同 HighpDMat，即 `{Lowp|Mediump}DMat{C}`" |
