# GLM 1.0.3 仓颉迁移阶段二 OOD 设计方案（v10）

> **修订日期**：2026-06-21

---

## 1. 概述

### 设计目标

在阶段一（Vec1~Vec4 向量类型 + 基础设施）的基础上，迁移全部 9 个矩阵类型及关联别名，使库具备二维/三维/四维矩阵的数学表达能力。矩阵类型以列向量为内部数据成员，与 GLM 的列主序（column-major）存储约定一致。

### 核心抽象

| 抽象 | 角色 | 类型形态 |
|------|------|---------|
| Mat2x2<T,Q> / Mat2x3<T,Q> / ... / Mat4x4<T,Q> | 表示 C×R 数学矩阵的值对象 | 泛型结构体 |
| common.cj（stub） | 基础数学函数库占位 | stub 文件 |
| matrix.cj（stub） | 矩阵运算函数库占位 | stub 文件 |
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

此统一策略适用于本设计中所有需要 T(0)/T(1) 的场景：`identity()` 工厂函数、`init(scalar: T)` 标量填充构造、跨矩阵类型转换构造。

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
  ├── matrix.cj ★           — stub（仅函数签名空壳，供 type_mat2x2/type_mat3x3/type_mat4x4 依赖闭合）
  ├── geometric.cj ★        — stub（仅函数签名空壳，供 type_mat4x4 依赖闭合）
  └── scalar_mat_ops.cj ★   — 标量-矩阵运算全局具名函数（add、sub、mul、div），处理 T + Mat 等标量左侧运算
                             （与 scalar_vec_ops.cj 同属 glm.detail，通过参数类型重载区分）

package glm                 — 公共 API 面 + 别名层（修改文件以 ★ 标记）
  ├── lib.cj ★              — 新增矩阵类型的 public import
  └── fwd.cj ★              — 新增矩阵类型别名

package glm.ext             — 具现化别名文件（新增目录和文件，以 ★ 标记）
  ├── matrix_float2x2.cj ★
  ├── matrix_float2x3.cj ★
  ├── matrix_float2x4.cj ★
  ├── matrix_float3x2.cj ★
  ├── matrix_float3x3.cj ★
  ├── matrix_float3x4.cj ★
  ├── matrix_float4x2.cj ★
  ├── matrix_float4x3.cj ★
  ├── matrix_float4x4.cj ★
  ├── matrix_double2x2.cj ★
  ├── matrix_double2x3.cj ★
  ├── matrix_double2x4.cj ★
  ├── matrix_double3x2.cj ★
  ├── matrix_double3x3.cj ★
  ├── matrix_double3x4.cj ★
  ├── matrix_double4x2.cj ★
  ├── matrix_double4x3.cj ★
  ├── matrix_double4x4.cj ★
  ├── vector_float1.cj ★
  ├── vector_float2.cj ★
  ├── vector_float3.cj ★
  ├── vector_float4.cj ★
  ├── vector_double1.cj ★
  ├── vector_double2.cj ★
  ├── vector_double3.cj ★
  └── vector_double4.cj ★
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

**列向量类型与行向量类型的确定规则**：
- 列向量类型 = Vec{R}<T,Q>，其中 R = 矩阵行数（因为列向量有 R 个分量）
- 行向量类型 = Vec{C}<T,Q>，其中 C = 矩阵列数（因为行向量有 C 个分量）
- 例如 Mat2x4<T,Q>（2 列 4 行）：列向量 = Vec4<T,Q>（4 分量），行向量 = Vec2<T,Q>（2 分量）

### 矩阵类型命名约定

仓颉语言中模板偏特化不可用，因此 9 个矩阵类型各自独立命名。命名规则为 Mat + 列数 + x + 行数，与 GLM 的 mat<C, R, T, Q> 一一对应：
- Mat2x2<T,Q>、Mat2x3<T,Q>、Mat2x4<T,Q>
- Mat3x2<T,Q>、Mat3x3<T,Q>、Mat3x4<T,Q>
- Mat4x2<T,Q>、Mat4x3<T,Q>、Mat4x4<T,Q>

**关键行为验证示例**（辅助编码阶段核验）：
- 行向量 × 矩阵乘法：Vec3<T,Q> * Mat2x3<T,Q> → Vec2<T,Q>（Vec{R} * Mat{C}x{R} → Vec{C}，R=3, C=2）
- 跨尺寸矩阵乘法：Mat2x3<T,Q> * Mat3x2<T,Q> → Mat3x3<T,Q>（Mat{C1}x{R1} * Mat{C2}x{R2} → Mat{C2}x{R1}，C1=R2=2）

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

glm.ext 单向依赖 glm.detail，glm 与 glm.ext 同级且均依赖 glm.detail，相互无依赖。

### ext/ 别名文件的包名策略

审查意见指出：src/ext/ 目录下的文件若声明 package glm，则与仓颉"目录名须与包名匹配"的规则矛盾。本设计选择 **Option 1**：src/ext/ 下文件声明 package glm.ext，通过 import glm.detail.* 访问 glm.detail 包中的核心类型。理由：

- 与现有 src/detail/ → package glm.detail 模式一致（detail/ 子目录对应 glm.detail 子包）
- glm.ext 作为 glm 的子包，自然属于 glm 包的公共 API 面
- 不需要重构现有 src/lib.cj 和 src/fwd.cj（它们声明 package glm 且位于 src/ 根目录下，路径与包名一致）
- 后续阶段三的四元数别名文件（ext/quaternion_float.cj 等）也将位于 src/ext/ 目录并声明 package glm.ext，形成统一的模式

---

## 3. 核心抽象

### 3.1 矩阵结构体

**角色**：表示 C×R 数学矩阵的值对象。每个矩阵类型是独立泛型结构体，以列向量为数据成员，采用列主序（column-major）存储。

**职责**：
- 承载 C 个列向量数据成员（var c0: VecR<T,Q>、var c1: VecR<T,Q> 等，其中 R = 行数）
- 提供编译期查询函数 length(): Int64 返回列数 C
- 提供下标运算符 [](i: Int64) 访问列向量（取值 + 赋值双版本）
- 提供逐分量构造函数和向量列构造函数
- 通过 @Derive[Hashable] 自动派生哈希支持（与阶段一 Vec 类型一致，所有成员类型 VecN<T,Q> 均已可哈希）

**数据成员与列数关系**：

| 类型 | 数据成员 | 列数 |
|------|---------|------|
| Mat2x2 / Mat2x3 / Mat2x4 | var c0: col_vec, var c1: col_vec | 2 |
| Mat3x2 / Mat3x3 / Mat3x4 | var c0, var c1, var c2 | 3 |
| Mat4x2 / Mat4x3 / Mat4x4 | var c0, var c1, var c2, var c3 | 4 |

其中 col_vec 根据具体类型在第 2 节映射表中确定（如 Mat4x4 的 col_vec = Vec4<T,Q>）。

**为何采用 struct（值类型）而非 class（引用类型）**：与阶段一 Vec 类型一致——矩阵是数学计算中的值对象，值语义确保运算符返回新实例、无副作用，便于测试和函数式组合。仓颉 struct 的栈分配对固定尺寸的矩阵（最大 4×4 = 16 个标量）性能友好。

**为何 9 个独立结构体而非统一泛型**：仓颉不支持模板偏特化，无法实现 Mat<C, R, T, Q> 泛型后在 .inl 中按 C/R 参数分别特化。9 个独立类型各自拥有其列向量类型和运算符签名，在仓颉类型系统中是最直接的映射。此策略与阶段一 Vec 类型的设计决策一致。

### 3.2 类型映射关系（取代类型别名体系）

矩阵类型与列向量/行向量的对应关系是固定的编译期映射，不定义为类型别名（仓颉限制类型别名只能在文件顶层定义，不能在结构体内部定义）。各矩阵类型的列向量类型和行向量类型在第 2 节映射表中已完整定义，使用处直接引用具体的 VecN<T,Q> 类型。

**设计约束说明**：仓颉类型别名只能在源文件顶层定义（详见仓颉类型系统文档 §5.2），不能在结构体/类/函数体等嵌套作用域内定义。阶段一中 Vec 类型的实现也不在结构体内部定义类型别名，而是在使用处直接引用完整类型名（如 Vec2<T,Q>）。本阶段遵循相同模式。

**在运算符和函数签名中引用列/行向量类型的规则**：
- 需要引用列向量类型处直接写 Vec{R}<T,Q>（R = 矩阵行数）
- 需要引用行向量类型处直接写 Vec{C}<T,Q>（C = 矩阵列数）
- 例如 Mat4x4<T,Q>：列向量用 Vec4<T,Q>，行向量用 Vec4<T,Q>
- 例如 Mat2x3<T,Q>：列向量用 Vec3<T,Q>，行向量用 Vec2<T,Q>

### 3.3 构造函数体系

每个矩阵类型提供以下构造函数和工厂函数（以 Mat4x4<T,Q> 为例，其他矩阵按列数/行数适配）：

1. **逐分量同类型构造**（init(x0, y0, z0, w0, x1, y1, z1, w1, ..., x3, y3, z3, w3)）
   - 按列主序接收全部标量分量：先第一列 R 个值，再第二列 R 个值，依此类推
   - 矩阵 Mat{C}x{R} 有 C×R 个标量参数
   - **const init 可用**：此构造函数仅涉及纯赋值操作，不依赖运算或类型转换，满足 const init 要求
   - 提供 const init 形式

2. **列向量构造**（init(c0: VecR<T,Q>, c1: VecR<T,Q>, ...)）
   - 直接以 C 个列向量构建矩阵
   - **const init 可用性取决于 VecR**：若 VecR 提供 const init，则此构造可为 const init（内部为纯赋值）；当前 Vec2~Vec4 均提供 const init，因此本构造函数也为 const init

3. **标量填充构造**（工厂函数，定义在带 `Number<T>` 约束的 extend 块中）
   - 接口形式：`public static func filled(scalar: T): Mat{C}x{R}<T,Q>`
   - 主对角线填 scalar，其余填零值，产生对角矩阵
   - 主对角线长度为 min(C, R)：对于方阵（如 Mat4x4），主对角线长度为 4；对于非方阵，主对角线长度为 min(C,R)，即沿 (0,0), (1,1), ... 对角线填 scalar 直到行或列先耗尽
   - 例如 `Mat2x3.filled(1.0f)` 产生 2×3 对角矩阵：`[[1,0,0],[0,1,0]]`（主对角线长度 min(2,3)=2，第 3 列全为 0）
   - **实现策略**：T(0) 通过 `scalar - scalar` 在 `Number<T>` 约束的 extend 块中演算获得；T(1) 在此构造中不需要
   - **为何不能用 init(scalar: T) 构造函数**：struct 体内的 init 构造函数中 T 是无约束泛型，无法执行 `scalar - scalar` 运算。构造函数必须在 struct 体内定义，不能在 extend 块中定义（仓颉语言限制）。故改为 extend 块中的静态工厂函数
   - **const init 不可用**：涉及 `Number<T>` 运算（`scalar - scalar`），const init 仅允许纯赋值，不允许运算表达式
   - **与阶段一 Vec2.init(scalar: T) 的语义差异**：Vec2 的 `init(scalar: T)` 是全分量赋同一标量值（直接赋值，无需 T(0)），矩阵的标量填充是对角矩阵（非对角线需填 T(0)），两者不可类比。矩阵 `filled(scalar)` 不可复用 Vec 的 `init(scalar: T)` 语义

4. **跨类型逐分量构造**（工厂函数，降级为 `fromParts` 模式）
   - 降级为带类型转换闭包的具名工厂函数：`public static func fromParts<U, Q2>(conv: (U) -> T, x0: U, y0: U, ..., x3: U, z3: U, w3: U): Mat4x4<T,Q>`
   - 接收与逐分量构造相同数量的参数，但各参数为类型 U，通过 conv 闭包转换为 T
   - **降级理由**：仓颉泛型上下文下隐式类型转换不可用——在 struct 体的无约束泛型 T 上下文中，不能将 U 类型参数自动转换为 T；在 extend 块中虽可添加 U <: Number<U> 等约束，但此时仍需显式转换闭包。此设计参考阶段一 `castVecN(v, conv)` 模式：castVecN 同样不依赖隐式转换，而是要求调用方显式提供 conv 闭包
   - **const init 不可用**：涉及类型转换闭包调用

5. **跨类型列向量构造**（工厂函数，降级为 `fromColumns` 模式）
   - 降级为带类型转换闭包的具名工厂函数：`public static func fromColumns<V1, V2, V3, V4, Q2>(conv: (V1) -> T, v1: Vec4<V1, Q2>, v2: Vec4<V1, Q2>, v3: Vec4<V1, Q2>, v4: Vec4<V1, Q2>): Mat4x4<T,Q>`（以 Mat4x4 为例，各列向量分量类型 V1 到 T 的转换通过 conv 闭包）
   - 实际编码时按矩阵列数调整参数：2 列矩阵仅需 v1, v2；3 列矩阵需 v1, v2, v3
   - **降级理由**：与第 4 条相同——跨类型转换在仓颉泛型上下文中不可隐式进行。统一采用 castVecN 的 conv 闭包模式
   - **const init 不可用**：涉及类型转换闭包调用

6. **跨矩阵类型转换**（工厂函数，定义在带 `Number<T>` 约束的 extend 块中）
   - 接口形式：`public static func fromMat<SrcT, SrcQ>(m: Mat{C_src}x{R_src}<SrcT, SrcQ>, one: T): Mat{C}x{R}<T,Q>` — 每种源矩阵尺寸各一个重载
   - 功能：将源矩阵转换到当前尺寸的矩阵，按填充规则扩展或截断
   - **精确填充规则**：源矩阵第 j 列第 i 行的元素 M_src[j][i] 复制到目标矩阵的相同坐标位置（即 dst[j][i] = src[j][i]），其中 0 ≤ j < min(C_src, C_dst)、0 ≤ i < min(R_src, R_dst)。当 C_dst > C_src 时，额外列（j ≥ C_src）从单位矩阵取值——即 (j,j) 填 T(1)，其余填 T(0)；当 R_dst > R_src 时，额外行（i ≥ R_src）从单位矩阵取值——即 (i,i) 填 T(1)，其余填 T(0)
   - 例如 Mat2x2 → Mat4x4：src[j][i] 填入 dst[j][i]（0 ≤ j < 2, 0 ≤ i < 2），dst[2][2]=T(1), dst[3][3]=T(1)，其余扩展位置填 T(0)
   - **参数 `one: T` 的必要性**：填充规则需要 T(1)（对角扩展位置），而 `Number<T>` 约束下无法演算出 T(1)（`!` 运算符属于 `Integer<T>` 而非 `Number<T>`，对 Float32/Float64 不可用）。T(0) 通过 `someValue - someValue` 在 `Number<T>` 上下文中演算。因此 `one` 必须由调用方传入
   - **为何降级为 extend 块中的工厂函数而非 struct 体中的构造函数**：72 个跨尺寸转换构造若定义为 init，必须在 struct 体内定义，而 struct 体内的 T 是无约束泛型，无法执行 T(0)/T(1) 构造或运算。在 `Number<T>` 约束的 extend 块中，T(0) 可通过 `someValue - someValue` 演算获得，T(1) 通过参数传入。这解决了问题 2 和问题 3 的共享根因——不可在 struct 体内获得 T(0)/T(1)
   - **为何 72 个构造可降级为具名工厂函数而不影响可用性**：跨矩阵类型转换是低频操作，工厂函数 `Mat4x4.fromMat(m2x2, one: 1.0f)` 虽比构造函数 `Mat4x4(m2x2)` 冗长，但语义更明确，且消除了 72 个 init 重载在 struct 体内的维护负担
   - **编码阶段注意事项**：上述填充规则作为主规则描述，但 GLM 的实际实现中某些转换构造函数的行为与主规则存在局部差异——特别是当 C_src > C_dst 且 R_src < R_dst 时，部分 .inl 文件的逐列构造行为可能偏离主规则（例如 Mat4x4 ← Mat4x2 场景中，GLM 丢弃源矩阵第 2、3 列数据并替换为单位矩阵列，而主规则会复制源矩阵第 2、3 列的部分数据后再补齐）。**编码阶段须逐一对照 GLM .inl 源码实现各转换工厂函数**，而非机械套用主规则。若 GLM 参考源码不可直接访问，将此作为编码阶段的风险项记录
   - **const init 不可用**：涉及运算（`someValue - someValue`）和参数化填充

7. **跨类型同尺寸转换构造**（init<U, P>(m: Mat4x4<U, P>)）
   - 从相同矩阵尺寸但不同元素类型和/或不同 Qualifier 的实例转换
   - 当 U=T 时自然涵盖跨 Qualifier 复制（即原第 2 条功能被本条完全覆盖）
   - **可行性分析**：此构造函数在 struct 体内定义，U 和 T 均为无约束泛型参数。构造函数体内部直接将 `m.c0` 等赋值给 `this.c0`，这要求 Vec4<U, P> 可隐式转换为 Vec4<T, Q>——在无约束泛型上下文中不可行。因此本构造函数也需降级为工厂函数：`public static func fromMat<U, P>(m: Mat4x4<U, P>, conv: (U) -> T): Mat4x4<T,Q>`，与第 4、5 条的 castVecN conv 闭包模式一致
   - **const init 不可用**：涉及类型转换闭包调用

8. **单位矩阵工厂函数**（public static func identity(one: T): Mat{C}x{R}<T,Q>）
   - 返回主对角线为 T(1)、其余为 T(0) 的单位矩阵
   - 定义在带 `Number<T>` 约束的 extend 块中
   - **参数 `one: T` 的必要性**：`Number<T>` 约束下无法演算出 T(1)（详见 §1 系统性设计约束），因此 T(1) 必须由调用方显式传入。T(0) 通过 `one - one` 在 `Number<T>` 上下文中演算获得
   - **const func 不可用**：`identity()` 涉及 `one - one` 运算来获得 T(0)，const func 中的表达式必须是 const 表达式，而减法运算在泛型约束上下文中不满足 const 表达式要求。因此 `const val m = Mat4x4<Float32, PackedHighp>.identity(1.0f)` 不可用——为此需在 §9 差异声明中记录
   - **调用方式变更**：C++ GLM 的 `mat4()` 无参默认构造改为 `Mat4x4<Float32, PackedHighp>.identity(1.0f)`。此为用户可见的 API 差异，在 §9 差异声明中记录
   - **为何不以 init() 形式提供**：仓颉无约束泛型参数不支持 `T(0)/T(1)` 构造调用（参见泛型约束 §7.1："无约束时只能传递/返回泛型类型的值，不能进行其他操作"）。即使添加 `Number<T>` 约束，`Number<T>` 接口也不提供 `T(n)` 构造声明（与 DV-01 的 `fromBoolVec` 面临的同一根因限制一致）。此外构造函数必须在 struct 定义中声明，不能在 extend 块中添加。单位矩阵构造只能在 `Number<T>` 约束的 extend 块中作为静态工厂函数实现

**构造函数/工厂函数 const init 可用性汇总**：

| 编号 | 构造方式 | const init/const func | 理由 |
|------|---------|----------------------|------|
| 1 | 逐分量同类型构造 | ✅ const init 可用 | 纯赋值，无运算无转换 |
| 2 | 列向量构造 | ✅ const init 可用 | VecR 已有 const init，内部为纯赋值 |
| 3 | 标量填充（filled） | ❌ 非 const | 涉及 `scalar - scalar` 运算 |
| 4 | 跨类型逐分量（fromParts） | ❌ 非 const | 涉及 conv 闭包调用 |
| 5 | 跨类型列向量（fromColumns） | ❌ 非 const | 涉及 conv 闭包调用 |
| 6 | 跨矩阵类型转换（fromMat） | ❌ 非 const | 涉及运算和参数化填充 |
| 7 | 跨类型同尺寸转换（fromMat + conv） | ❌ 非 const | 涉及 conv 闭包调用 |
| 8 | 单位矩阵（identity） | ❌ 非 const func | 涉及 `one - one` 运算 |

### 3.4 行列访问

- **下标运算符**：
  - 取值版本：`operator func [](i: Int64): VecR<T,Q>` — 按列索引访问第 i 列列向量
  - 赋值版本：`mut operator func [](i: Int64, value!: VecR<T,Q>): Unit` — 按列索引修改第 i 列列向量（**mut 修饰符不可省略**，与阶段一 Vec2 实际实现 `mut operator func [](i: Int64, value!: T): Unit` 一致）
  - 取值版本返回 VecR<T,Q>（列向量的副本，值语义）
  - 下标越界时抛出 Exception（与 §5 错误处理策略一致）

- **具名列访问函数** col(i: Int64): VecR<T,Q>：
  `col(i)` 是 `[](i)` 的具名等价形式，行为完全相同：按列索引访问列向量，越界时抛出 Exception。两者并存的设计意图：
  - `[](i)` 提供最简洁的向量级列访问语法
  - `col(i)` 作为显式具名函数，在需要强调"按列访问"语义的上下文中提升代码可读性
  - 与 C++ GLM 中 `.col()` 访问模式的 API 习惯对齐
  - **命名选择说明**：本版本将之前的 `componentAt` 更名为 `col`，以避免与阶段一 Vec 类型的 `componentAt` 返回标量分量的语义冲突。Vec 的 `componentAt(i)` 返回第 i 个标量分量，而矩阵列访问返回整个列向量——统一命名为 `col(i)` 清晰表达"按列索引访问列向量"的语义

- **`col()` 与 `[]` 的编码指导**：
  - 两者应在同一 extend 块中定义（或均在 struct 体内定义），确保约束上下文一致
  - 推荐编码规范：内部实现中优先使用 `[](i)`（语法简洁），对外 API 文档和用户级代码中推荐使用 `col(i)`（语义明确）
  - 两者的行为契约完全一致，选择使用哪个纯属风格偏好

- **行访问函数**（本阶段不提供成员函数形式）：
  行访问在 C++ GLM 中由自由函数 `glm::row()` 提供（属于 `matrix.cj` 函数库），阶段四随 `matrix.cj` 完整实现一起提供为自由函数版本。本阶段不提供行访问成员函数，原因：
  - 避免阶段二成员函数与阶段四自由函数之间的 API 不兼容问题
  - 阶段二中尚未实现矩阵转置、行列重组等依赖行访问的运算，行访问无充分的使用场景需求

### 3.5 算术运算符

所有算术运算符定义在带 Number<T> 约束的 extend 块中，与阶段一 Vec 类型模式一致。

**一元运算符**：
- operator func -(): Mat{C}x{R}<T,Q> — 逐元素取负

**二元运算符（矩阵-标量）**：
- +、-、*、/（右操作数为 T）：逐元素操作

**二元运算符（标量-矩阵）**：
- +、-、*、/（左操作数为 T，右操作数为矩阵）：通过 scalar_mat_ops.cj 中的全局具名函数处理（add<T,Q>(s: T, m: Mat{C}x{R}<T,Q>)、sub<T,Q>(s: T, m)、mul<T,Q>(s: T, m)、div<T,Q>(s: T, m)），与阶段一 scalar_vec_ops.cj 的模式一致。每种运算为 9 个矩阵类型各提供 1 个重载，共 36 个全局函数（4 种运算 × 9 种矩阵）。所有 36 个全局函数标注 @OverflowWrapping，与阶段一 scalar_vec_ops.cj 的做法一致
- **标量-矩阵除法语义**：div(s, m) 的语义为逐元素 s / each_element，即结果的每个分量 = s / m[j][i]。此运算不依赖 inverse，可本阶段完整实现
- **命名约定说明**：scalar_mat_ops.cj 与 scalar_vec_ops.cj 同属 glm.detail 包，均定义名为 add、sub、mul、div 的包级函数。两者通过参数类型（Vec 型 vs 矩阵型）在仓颉重载解析中自然区分，不会产生歧义。阶段一 OOD 中原有约定"仅 scalar_vec_ops.cj 定义 add/sub/mul/div 包级函数"在此更新为"scalar_vec_ops.cj 和 scalar_mat_ops.cj 共同定义 add/sub/mul/div，通过参数类型重载区分"

**二元运算符（矩阵-矩阵）**：
- +、-：逐元素加/减（仅同尺寸）
- *：矩阵乘法（需满足内维度匹配）
  - **兼容性规则**：Mat{C1}x{R1} * Mat{C2}x{R2} 当 C1 = R2 时兼容，结果类型为 Mat{C2}x{R1}
  - **同尺寸乘法**（方阵，3 种）：Mat2x2 * Mat2x2 → Mat2x2、Mat3x3 * Mat3x3 → Mat3x3、Mat4x4 * Mat4x4 → Mat4x4
  - **跨尺寸乘法兼容性表**（24 种跨尺寸 + 3 种同尺寸 = 共 27 个有效重载）：
    - Mat2x2 可与 Mat3x2 → Mat3x2、Mat4x2 → Mat4x2 相乘
    - Mat2x3 可与 Mat2x2 → Mat2x3、Mat3x2 → Mat3x3、Mat4x2 → Mat4x3 相乘
    - Mat2x4 可与 Mat2x2 → Mat2x4、Mat3x2 → Mat3x4、Mat4x2 → Mat4x4 相乘
    - Mat3x2 可与 Mat2x3 → Mat2x2、Mat3x3 → Mat3x2、Mat4x3 → Mat4x2 相乘
    - Mat3x3 可与 Mat2x3 → Mat2x3、Mat4x3 → Mat4x3 相乘
    - Mat3x4 可与 Mat2x3 → Mat2x4、Mat3x3 → Mat3x4、Mat4x3 → Mat4x4 相乘
    - Mat4x2 可与 Mat2x4 → Mat2x2、Mat3x4 → Mat3x2、Mat4x4 → Mat4x2 相乘
    - Mat4x3 可与 Mat2x4 → Mat2x3、Mat3x4 → Mat3x3、Mat4x4 → Mat4x3 相乘
    - Mat4x4 可与 Mat2x4 → Mat2x4、Mat3x4 → Mat3x4 相乘
  - 矩阵乘法是数学语义组合，非逐元素运算
  - **跨尺寸乘法运算符的文件归属策略**：跨尺寸矩阵乘法运算符定义在左操作数矩阵类型的 extend 块中（即在 type_mat{C}x{R}.cj 文件中的 extend 块中定义 `operator func *(rhs: Mat{C2}x{R2})` 等重载）。由于这 9 个矩阵类型均定义在 glm.detail 同包中，同包类型互相直接可见，**无需跨文件 import**——同包内的类型引用不需要 import 语句
- /（矩阵-矩阵除法）：**仅方阵类型（Mat2x2、Mat3x3、Mat4x4）** 提供此运算符。等价于 mat *= inverse(rhs)（赋值语义），因 inverse 属于 matrix.cj 函数库（本阶段为 stub），矩阵-矩阵除法推迟至阶段四。非方阵类型不提供矩阵-矩阵除法运算符（非方阵不可逆，无数学意义），与 GLM 参考实现一致
- /（矩阵-列向量除法 mat / col_vec、行向量-矩阵除法 row_vec / mat）：**仅方阵类型** 提供此运算符。依赖 inverse(m) * v 或 v * inverse(m) 实现，同样因 inverse 为 stub 而推迟至阶段四。非方阵类型不提供 mat/vec 和 vec/mat 除法运算符，与 GLM 参考实现一致

**二元运算符（矩阵-向量）**：
- *（矩阵 × 列向量）：Mat{C}x{R}<T,Q> * Vec{C}<T,Q> → Vec{R}<T,Q>
  - 例如 Mat4x4<T,Q> * Vec4<T,Q> → Vec4<T,Q>
  - 例如 Mat2x3<T,Q> * Vec2<T,Q> → Vec3<T,Q>
- *（行向量 × 矩阵）：Vec{R}<T,Q> * Mat{C}x{R}<T,Q> → Vec{C}<T,Q>
  - 例如 Vec3<T,Q> * Mat2x3<T,Q> → Vec2<T,Q>（Vec{R}=Vec3, Mat2x3 的 C=2 → Vec{C}=Vec2）
  - 例如 Vec4<T,Q> * Mat4x4<T,Q> → Vec4<T,Q>（方阵特殊性：C=R=4）

**复合赋值运算符**：由仓颉编译器自动生成（当二元运算符返回类型与左操作数类型匹配时），标注 @OverflowWrapping 策略与阶段一 Vec 类型一致。**注意**：仅方阵类型（Mat2x2/Mat3x3/Mat4x4）自动获得 `*=`（same_mat）复合赋值运算符——因方阵乘法结果类型与左操作数类型相同（Mat4x4 * Mat4x4 → Mat4x4），编译器可自动生成 `operator func *=`。非方阵类型的矩阵乘法结果类型不同于左操作数（如 Mat2x3 * Mat3x2 → Mat3x3 ≠ Mat2x3），编译器不会为非方阵自动生成矩阵乘复合赋值 `*=`。方阵 `*=`（mat）由编译器自动生成，语义与 C++ GLM 的显式定义一致（a *= b ≡ a = a * b）。所有矩阵类型的逐元素运算（+=、-=、+=scalar、-=scalar、*=scalar、/=scalar）均可自动生成复合赋值，因其结果类型始终与左操作数相同

### 3.6 比较运算符

定义在 Equatable<T> 约束的 extend 块中：
- == 和 !=：逐列比较，所有列相等则矩阵相等
- equalExact(other)：具名精确比较

定义在 Number<T> & Equatable<T> & Comparable<T> 约束的 extend 块中：
- equalEpsilon(other)：浮点容差比较。实现方式为逐列委托 VecR<T,Q>.equalEpsilon，与 == 逐列委托 VecR<T,Q>.== 的模式一致。约束传递关系：矩阵 equalEpsilon 要求列向量类型 T 满足 Number<T> & Equatable<T> & Comparable<T>，与阶段一 Vec 的约束条件一致

### 3.7 stub 函数库

为满足方阵 .inl 编排的依赖闭合性，本阶段创建 3 个 stub 文件：

**common.cj**（package glm.detail）：
- 提供 min、max、abs、sign、floor、ceil、fract、mod、clamp 等基础数学函数的空壳签名
- 函数体以 throw Exception("stub") 占位，或返回零值的默认结果
- 被 type_mat3x3 和 type_mat4x4 的 .inl 实现引用

**matrix.cj**（package glm.detail）：
- 提供 transpose、determinant、inverse、matrixCompMult、outerProduct 等矩阵运算函数的空壳签名
- 被 type_mat2x2、type_mat3x3、type_mat4x4 的 .inl 实现引用

**geometric.cj**（package glm.detail）：
- 提供 dot、cross、normalize、length、distance、reflect、refract 等几何函数的空壳签名
- 被 type_mat4x4 的 .inl 实现引用

### 3.8 ext/ 别名文件

src/ext/ 目录下存放矩阵和向量的具现化别名文件，声明 package glm.ext。每个文件包含一或两个 public type 别名定义：

**矩阵别名文件（18 个）**：
- matrix_float4x4.cj：public type mat4x4 = Mat4x4<Float32, PackedHighp> 和 public type mat4 = Mat4x4<Float32, PackedHighp>
- matrix_double4x4.cj：public type dmat4x4 = Mat4x4<Float64, PackedHighp> 和 public type dmat4 = Mat4x4<Float64, PackedHighp>
- 其余 16 个矩阵别名文件同理（9 种尺寸 × 2 种精度，共 18 个文件）

**向量别名文件（8 个）**：
- vector_float1.cj：public type vec1 = Vec1<Float32, PackedHighp>
- vector_float2.cj：public type vec2 = Vec2<Float32, PackedHighp>
- vector_float3.cj：public type vec3 = Vec3<Float32, PackedHighp>
- vector_float4.cj：public type vec4 = Vec4<Float32, PackedHighp>
- vector_double1.cj：public type dvec1 = Vec1<Float64, PackedHighp>
- vector_double2.cj：public type dvec2 = Vec2<Float64, PackedHighp>
- vector_double3.cj：public type dvec3 = Vec3<Float64, PackedHighp>
- vector_double4.cj：public type dvec4 = Vec4<Float64, PackedHighp>

**文件范围说明**：向量别名文件仅包含 float（Vec1~Vec4）和 double（DVec1~DVec4）两个精度族，与矩阵别名文件的范围（仅 float/double）一致。Bool、Int32、UInt32 等向量类型的别名已在 fwd.cj 中提供（如 bvec2、ivec3、uvec4 等），不在 ext/ 目录下重复创建。此范围与路线图中"ext/ 下的向量/矩阵别名文件……仅含 type alias 和精度变体"的描述一致。

**ext/ 向量别名与 fwd.cj 向量别名的定位差异说明**：

ext/ 下的 camelCase 向量别名（vec1~vec4 / dvec1~dvec4）与 fwd.cj 中的 PascalCase 向量别名（Vec1~Vec4 / DVec1~DVec4）引用的是同一具体类型。例如 `vector_float4.cj` 中的 `public type vec4 = Vec4<Float32, PackedHighp>` 与 `fwd.cj` 中的 `public type Vec4 = detail.Vec4<Float32, detail.PackedHighp>` 指向完全相同的泛型实例化——它们仅命名风格不同（camelCase vs PascalCase），运行时行为和类型大小完全一致。

两套并存的起源是 GLM C++ 源码中的二元体系：
- `fwd.hpp` 中定义 PascalCase 别名（Vec4 = tvec4<float, highp>），用于库的公共 API 声明
- `ext/vector_float4.hpp` 中定义 camelCase 别名（vec4 = tvec4<float, highp>），用于与 GLSL 着色器代码的命名习惯对齐

**推荐使用指引**：
- **推荐用户优先使用 fwd.cj 中的 PascalCase 别名**——import 路径更短（`import glm.{Vec4}` 即可），与库的主体 API 风格一致
- **ext/ 别名主要用于与 GLM C++ 代码做逐文件对应迁移的场景**——当用户从 C++ GLM 代码迁移且希望保留 camelCase 命名时，可使用 `import glm.ext.vector_float4.{ vec4 }`
- 两套别名的差异**仅**在于命名风格和包路径，不涉及类型或行为差异

**导入风格说明**：ext/ 别名文件使用命名导入 `import glm.detail.{ Mat2x2, Mat2x3, ..., Vec1, Vec2, ..., PackedHighp }` 获取所需的类型和 Qualifier 类型，而非 fwd.cj 的限定访问 `import glm.detail`。原因：ext/ 文件声明 package glm.ext，其中定义的别名（如 mat4）不会与 detail 包中的类型名（如 Mat4x4）冲突，因此命名导入安全可用，且比限定访问更简洁——每处引用无需 `detail.` 前缀。而 fwd.cj 中定义的别名名（如 Mat4x4）与 detail 包中的同名泛型类冲突，必须使用限定访问（`detail.Mat4x4<...>`）以区分别名与原始类型

每个文件通过 import glm.detail.{ Mat2x2, Mat2x3, ..., Vec1, Vec2, ..., PackedHighp } 导入所需的类型和 Qualifier 类型，再定义 public type 别名。

---

## 4. 关键行为契约

### 4.1 矩阵构造与单位矩阵

```
let m = Mat4x4<Float32, PackedHighp>.identity(1.0f)   // 单位矩阵（需传入 one: T）
let m = Mat4x4<Float32, PackedHighp>.filled(1.0f)      // 对角矩阵 diag(1,1,1,1)，等同于 identity
let m = Mat2x3<Float32, PackedHighp>.filled(1.0f)      // 2×3 对角矩阵: [[1,0,0],[0,1,0]]
let m = Mat4x4<Float32, PackedHighp>(                    // 逐分量构造（const init）
    1.0f, 0.0f, 0.0f, 0.0f,                     // 列 0
    0.0f, 1.0f, 0.0f, 0.0f,                     // 列 1
    0.0f, 0.0f, 1.0f, 0.0f,                     // 列 2
    0.0f, 0.0f, 0.0f, 1.0f)                     // 列 3  单位矩阵等同
```

### 4.2 矩阵乘法

```
let a = Mat4x4<Float32, PackedHighp>(...)
let b = Mat4x4<Float32, PackedHighp>(...)
let c = a * b                    // 矩阵-矩阵乘，结果 Mat4x4

let v = Vec4<Float32, PackedHighp>(1.0f, 2.0f, 3.0f, 1.0f)
let transformed = a * v          // 矩阵-向量乘，结果 Vec4
```

### 4.3 跨尺寸转换

```
let m2 = Mat2x2<Float32, PackedHighp>(...)        // 2x2
let m4 = Mat4x4<Float32, PackedHighp>.fromMat(m2, one: 1.0f)  // 2x2 -> 4x4，扩展填 0/1
```

### 4.4 跨类型同尺寸转换

```
let mInt = Mat4x4<Int32, PackedHighp>(...)
let mFloat = Mat4x4<Float32, PackedHighp>.fromMat(mInt, conv: { x => Float32(x) })
```

### 4.5 ext/ 别名使用

```
import glm.ext.matrix_float4x4.{ mat4, mat4x4 }
import glm.ext.vector_float4.{ vec4 }

let m = mat4(1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f)
let v = vec4(1.0f, 2.0f, 3.0f, 1.0f)
let r = m * v
```

---

## 5. 错误处理策略

与阶段一保持一致：
- **下标越界**：[](i: Int64) 和 col(i: Int64) 中超出列范围的索引抛出 Exception（含 assert + fallback throw）。此机制使 `[]` 和 `col()` 不可声明为 `const func`（与阶段一 Vec 的 `componentAt` 面临同类限制，参见 deviations.md IF-03），在 §9 差异声明中记录
- **数学异常**：
  - 矩阵-矩阵除法（mat / mat）：**仅方阵类型（Mat2x2、Mat3x3、Mat4x4）** 提供此运算符，因依赖 inverse 函数（stub），本阶段运算符内部调用时抛出 stub 异常。非方阵类型不提供 mat/mat 除法运算符
  - 矩阵-标量除法（mat / scalar）：逐元素操作，不依赖 inverse，可本阶段完整实现
  - 标量-矩阵除法（scalar / mat）：逐元素 s / each_element 操作，不依赖 inverse，可本阶段完整实现
  - 矩阵-列向量除法（mat / col_vec）和行向量-矩阵除法（row_vec / mat）：**仅方阵类型** 提供此运算符，同样因依赖 inverse 而推迟至阶段四
  - **整型矩阵除零风险**：矩阵-标量除法（mat / scalar）和标量-矩阵除法（scalar / mat）对整型矩阵的除零行为与阶段一 Vec 类型一致——仓颉整数除法由编译器/运行时处理，本设计不额外添加除零保护
- **溢出策略**：
  - 算术复合赋值运算符标注 @OverflowWrapping，与阶段一 Vec 类型一致
  - scalar_mat_ops.cj 中的全部 36 个全局函数（add/sub/mul/div，各 9 个矩阵类型重载）均标注 @OverflowWrapping，与阶段一 scalar_vec_ops.cj 的做法一致

---

## 6. 并发设计

本阶段不引入并发场景。矩阵类型为值类型（struct），所有运算符返回新实例，天然线程安全。无需额外同步机制。

---

## 7. 设计决策

| 编号 | 决策 | 理由 |
|------|------|------|
| D01 | 9 个矩阵类型各自独立定义，而非 C×R 参数化泛型 | 仓颉不支持模板偏特化，独立类型可直接声明列向量类型成员和具体运算符签名 |
| D02 | 列主序存储（成员为列向量） | 与 GLM 列主序约定一致，确保 m[i] 返回第 i 列的含义与 C++ GLM 一致 |
| D03 | glm.ext 子包存放别名文件，声明 package glm.ext | 目录路径与包名匹配规则要求，详见第 2 节 ext/ 包名策略 |
| D04 | 矩阵乘法运算符直接内联展开而非委托函数库 | C×R <= 4x4=16，内联展开代码量可控且避免函数调用开销；复合运算（如 a * b * v）中可合并优化 |
| D05 | 矩阵-向量乘法定义为矩阵运算符 | 与 C++ GLM 的 operator*(mat, vec) 一致，是线性代数最核心的操作 |
| D06 | 标量在矩阵左侧的运算通过全局函数处理 | 仓颉 operator func +(rhs: T) 的 this 固定为左操作数，仅能表达 Mat + T，无法表达 T + Mat。参考阶段一 scalar_vec_ops.cj 模式，创建 scalar_mat_ops.cj 提供全局具名函数（add/sub/mul/div）处理标量在矩阵左侧的运算。全部 36 个函数标注 @OverflowWrapping，与阶段一一致 |
| D07 | stub 函数提供空壳签名而非完整实现 | 阶段二的验证标准不包括函数库运算（仅矩阵创建、行列访问、基本算术），stub 保证方阵文件编译通过即可 |
| D08 | 排除 ++/-- 运算符的具名替代（increment/decrement） | 仓颉不支持重载自增/自减运算符。C++ GLM 中矩阵自增 `++m` 是逐元素加 1 操作，可通过 `m += T(1)`（逐元素加 1）等价替代。注意不能使用 `+= identity`（仅对角线加 1，语义不同） |
| D09 | 排除 % 运算符（取模） | 矩阵取模无数学意义，GLM 也未为矩阵类型定义 % 运算符 |
| D10 | 排除位运算符（&/|/^/<</>>） | 矩阵类型不支持位运算，GLM 的矩阵类型也未定义位运算符 |
| D11 | **不在矩阵结构体内部定义类型别名** | 仓颉限制类型别名只能在源文件顶层定义，不能在结构体/类/函数体内定义。各矩阵的列向量/行向量类型在使用处直接引用具体的 VecN<T,Q> 类型，与阶段一 Vec 类型风格一致 |
| D12 | `col(i: Int64)` 替代 `componentAt(i: Int64)` 作为列访问函数 | 阶段一 Vec 类型的 `componentAt(i)` 返回第 i 个标量分量。矩阵列访问返回整个列向量（VecR<T,Q>），若复用 `componentAt` 名称会造成同一 API 在不同类型间返回语义不一致。使用 `col(i)` 明确表达"按列索引访问列向量"的语义 |
| D13 | 行访问 `row()` 本阶段不提供成员函数形式 | C++ GLM 的 `glm::row()` 是自由函数，属于 `matrix.cj` 函数库（阶段四完整实现）。若本阶段定义为成员函数，阶段四替换为自由函数时产生 API 不兼容。本阶段无行访问的充分使用场景，决定推迟至阶段四随 `matrix.cj` 自由函数版本一起提供 |
| D14 | ext/ 向量别名文件仅限 float/double 两个精度族 | 与矩阵别名文件的范围一致（仅 float/double）。Bool/Int32/UInt32 等向量类型的别名已在 fwd.cj 中提供，不再在 ext/ 下重复创建 |
| D15 | **scalar_mat_ops.cj 与 scalar_vec_ops.cj 共同定义 add/sub/mul/div 包级函数，通过参数类型重载解析区分** | 阶段一 OOD 中约定"仅 scalar_vec_ops.cj 定义 add/sub/mul/div 包级函数"。本阶段新增 scalar_mat_ops.cj 在同一包中定义同名函数，两者参数类型（Vec 型 vs 矩阵型）完全不同，仓颉重载解析可自然区分。更新阶段一名称约定以覆盖本场景 |
| D16 | **fwd.cj 矩阵别名命名规则** | 与阶段一向量的命名规范保持一致：`Mat{C}x{R}` 为 Float32 highp 默认精度，`DMat{C}x{R}` 为 Float64 highp；精度变体 `HighpMat{C}x{R}`、`MediumpMat{C}x{R}`、`LowpMat{C}x{R}`；方阵短别名 `mat{C}`（Float32）和 `dmat{C}`（Float64）。详见 §8 fwd.cj 命名规则。**关于 fmat/f32mat/f64mat 系列及 i8mat~u64mat 系列的纳排决策详见 D19**。**精度变体同样覆盖方阵短别名**：`Highpmat4`、`MediumpMat4`、`Lowpmat4` 等（即 `Highp` + `mat4` 形式，对应 `Mat4x4<Float32, PackedHighp>` 等） |
| D17 | **矩阵类型支持 @Derive[Hashable]** | 与阶段一 Vec 类型保持一致。矩阵类型包含 Vec 列向量成员，而 Vec 已通过 @Derive[Hashable] 自动派生哈希实现。仓颉中 struct 的 @Derive[Hashable] 要求所有成员可哈希，矩阵全部满足此条件。此决策使矩阵类型可用于 HashSet/HashMap 等场景 |
| D18 | **type_float.cj 和 type_half.cj 延迟至后续阶段** | 路线图中列为"可选"，无阶段内文件依赖它们。这两个浮点类型标签文件仅在阶段四函数库中的某些数值边界场景需要，本阶段不纳入范围 |
| D19 | **fwd.cj 矩阵别名仅覆盖 Mat/DMat 族 + 精度变体 + 方阵短别名，不纳入 fmat/f32mat/f64mat 及 i8mat~u64mat 系列** | C++ GLM fwd.hpp 中 fmat/f32mat/f64mat 系列是 mat/DMat 的"显式前缀"冗余别名（fmat2 等效于 mat2，f32mat2 等效于 mat2，f64mat2 等效于 dmat2），在仓颉中 Defaultp = PackedHighp，这些冗余别名无额外类型差异，为避免 fwd.cj 别名爆炸而排除。i8mat~u64mat 等整型矩阵别名（imat/u8mat 等）因矩阵主用于浮点线性代数运算，整型矩阵为极低频边界场景，且 GLM 自身仅在 fwd.hpp 中声明但 .inl 中整型矩阵运算支持不完整，排除后大幅缩减别名量。若后续有用户需求可通过 ext/ 文件补充 |
| D20 | **单位矩阵构造改为 `identity(one: T)` 静态工厂函数，不提供 `init()` 无参默认构造** | C++ GLM 的 `mat4()` 默认构造为单位矩阵，但仓颉无约束泛型不支持 `T(0)/T(1)` 构造调用（deviations.md DV-01 记录的同类限制：无约束时只能传递/返回泛型类型的值，不能进行其他操作）。即使添加 `Number<T>` 约束，`Number<T>` 接口也不提供 `T(n)` 构造声明。因此 `init()` 在泛型 struct 定义或任何 extend 块中均不可行（构造函数必须在 struct 定义中声明，不能在 extend 块中添加）。将单位矩阵构造推迟到 `Number<T>` 约束的 extend 块中作为 `public static func identity(one: T): Mat{C}x{R}<T,Q>` 工厂函数。代价：`Mat4x4<Float32, PackedHighp>()` 不可用，改为 `Mat4x4<Float32, PackedHighp>.identity(1.0f)`。此设计决策与阶段一 Vec 类型回避此问题的策略一致——Vec 类型无 `init()` 默认构造函数，仅有 `init(scalar: T)`。**参数 `one` 的必要性**：`Number<T>` 约束下无法演算 T(1)——`!`（按位取反）运算符属于 `Integer<T>` 接口而非 `Number<T>` 接口，对 Float32/Float64 类型不可用。因此 T(1) 必须由调用方显式传入。T(0) 通过 `one - one` 在 `Number<T>` 上下文中演算获得。此前版本中设计的 T(1) 演算公式 `let one = -(!(zero))` 依赖 `!` 运算符，但 `Number<T>` 约束不提供此运算符，该演算公式不可行 |
| D21 | **删除原 §3.3 第 2 条跨 Qualifier 复制构造函数，功能由第 7 条跨类型同尺寸转换覆盖** | 原第 2 条 `init<Q2>(m: Mat4x4<T, Q2>)` 仅处理跨 Qualifier 复制（T 相同），原第 7 条（现为第 7 条，原第 9 条）`init<U, P>(m: Mat4x4<U, P>)` 处理跨类型同尺寸转换。当第 7 条实例化为 `U=T, P≠Q` 时，参数类型为 `Mat4x4<T, P>`，与第 2 条实例化为 `Q2=P` 时的参数类型 `Mat4x4<T, P>` 完全相同，产生重载歧义。删除第 2 条后，当 `U=T` 时第 7 条自然涵盖跨 Qualifier 复制，功能无损且消除歧义 |
| D22 | **标量填充构造降级为 extend 块中的 `filled(scalar: T)` 静态工厂函数** | `init(scalar: T)` 构造函数在 struct 体内 T 为无约束泛型，无法执行 `scalar - scalar` 获得 T(0)——矩阵的标量填充需要非对角线填 T(0)，与阶段一 Vec2.init(scalar: T) 的全分量赋同一值语义不同。将此构造降级为 `Number<T>` 约束的 extend 块中的 `filled(scalar: T)` 静态工厂函数，在此约束上下文中通过 `scalar - scalar` 获得 T(0) |
| D23 | **跨矩阵类型转换（72 个 init）降级为 extend 块中的 `fromMat(m, one: T)` 静态工厂函数** | 72 个跨尺寸转换构造若定义为 init，必须在 struct 体内定义，而 struct 体内的 T 是无约束泛型，无法执行 T(0)/T(1) 获取。降级到 `Number<T>` 约束的 extend 块后，T(0) 通过 `someValue - someValue` 演算，T(1) 通过参数 `one` 传入。此决策与 D22（标量填充降级）和 D20（identity 降级）形成统一的解决策略——所有需要 T(0)/T(1) 的构造统一改为 extend 块中的工厂函数 |
| D24 | **跨类型逐分量构造和跨类型列向量构造降级为带 conv 闭包的具名工厂函数** | 仓颉泛型上下文中隐式类型转换不可用。在 struct 体内（无约束泛型 T、U）无法将 U 自动转为 T；在 extend 块中虽有约束但仍无隐式 U→T 路径。统一采用阶段一 `castVecN(v, conv)` 模式，要求调用方显式提供 conv 闭包（如 `{ x => Float32(x) }`）。降级为 `fromParts(conv, ...)` 和 `fromColumns(conv, ...)` 静态工厂函数 |
| D25 | **跨类型同尺寸转换构造降级为带 conv 闭包的 `fromMat(m, conv)` 工厂函数** | 与 D24 同理——跨类型转换不可隐式进行。原设计 `init<U, P>(m: Mat4x4<U, P>)` 在 struct 体内无法将 Vec4<U,P> 赋值给 Vec4<T,Q>（无约束泛型上下文中隐式转换不可用）。降级为 `fromMat(m, conv: (U) -> T)` 工厂函数，与阶段一 castVecN 模式一致 |
| D26 | **`identity()` 不可为 const func，`filled()` 不可为 const init** | identity 涉及 `one - one` 运算获得 T(0)，filled 涉及 `scalar - scalar` 运算获得 T(0)，两者均涉及 const 表达式规则不允许的泛型约束运算。const init/const func 中只允许纯赋值和编译期可求值的表达式，运算不在其列 |

---

## 8. 阶段二产出物清单

### 9 个矩阵类型实现文件（src/detail/）
- type_mat2x2.cj ~ type_mat4x4.cj（9 文件）

### 4 个辅助文件（src/detail/）
- common.cj、matrix.cj、geometric.cj（3 个 stub）
- scalar_mat_ops.cj（标量-矩阵运算全局函数，36 个重载，均标注 @OverflowWrapping）

### ext/ 别名文件（src/ext/，声明 package glm.ext）
- 18 个矩阵别名文件（9 尺寸 × 2 精度：float + double）
- 8 个向量别名文件（vector_float1~4.cj + vector_double1~4.cj）

### 修改文件
- src/fwd.cj：新增矩阵类型别名，命名规则如下（与阶段一向量的命名规范保持一致）：
  - **默认精度（Float32, PackedHighp）**：`Mat2x2`、`Mat2x3`、`Mat2x4`、`Mat3x2`、`Mat3x3`、`Mat3x4`、`Mat4x2`、`Mat4x3`、`Mat4x4`
  - **double 精度（Float64, PackedHighp）**：`DMat2x2`、`DMat2x3`、`DMat2x4`、`DMat3x2`、`DMat3x3`、`DMat3x4`、`DMat4x2`、`DMat4x3`、`DMat4x4`
  - **精度变体（Highp / Mediump / Lowp）**：`HighpMat{C}x{R}`、`MediumpMat{C}x{R}`、`LowpMat{C}x{R}`（对 Float32 族），以及 `HighpDMat{C}x{R}`、`MediumpDMat{C}x{R}`、`LowpDMat{C}x{R}`（对 Float64 族）
  - **方阵短别名**：`mat2`、`mat3`、`mat4`（Float32 方阵）和 `dmat2`、`dmat3`、`dmat4`（Float64 方阵）
  - **精度变体覆盖方阵短别名**：`Highpmat{C}`、`Mediumpmat{C}`、`Lowpmat{C}`（对 Float32 族），以及 `Highpdmat{C}`、`Mediumpdmat{C}`、`Lowpdmat{C}`（对 Float64 族）。例如 `Highpmat4` 对应 `Mat4x4<Float32, PackedHighp>`，`Mediumpdmat4` 对应 `Mat4x4<Float64, PackedMediump>`
  - **非方阵默认精度别名**：`mat2x3`、`mat2x4`、`mat3x2`、`mat3x4`、`mat4x2`、`mat4x3`（Float32 族）和 `dmat2x3`、`dmat2x4`、`dmat3x2`、`dmat3x4`、`dmat4x2`、`dmat4x3`（Float64 族）
  - **引用方式**：`public type Mat4x4 = detail.Mat4x4<Float32, detail.PackedHighp>`，与阶段一 `public type Vec4 = detail.Vec4<Float32, detail.PackedHighp>` 模式一致
  - **关于 Defaultp 与 PackedHighp**：fwd.cj 中矩阵默认精度别名使用 PackedHighp 而非 Defaultp 作为 Qualifier 参数，原因：① qualifier.cj 中 `public type Defaultp = PackedHighp` 为类型别名，仓颉类型别名在泛型参数位置是否透明传递取决于编译器实现，使用 PackedHighp 可避免潜在的别名解析问题；② 阶段一 fwd.cj 全部向量别名均使用 PackedHighp，矩阵别名保持一致；③ Defaultp 与 PackedHighp 在语义上完全等效（Alias 后同一类型），运行时无差异
  - **关于不纳入的别名族**（排除决策）：
    - fmat 系列（fmat2~fmat4、fmat2x2~fmat4x4）：排除，理由见 D19
    - f32mat 系列（f32mat2~f32mat4、f32mat2x2~f32mat4x4）：排除，理由见 D19
    - f64mat 系列（f64mat2~f64mat4、f64mat2x2~f64mat4x4）：排除，理由见 D19
    - imat 系列（imat2x2~imat4x4 及 i8mat~i64mat 全系列）：排除，理由见 D19
    - umat 系列（umat2x2~umat4x4 及 u8mat~u64mat 全系列）：排除，理由见 D19

- src/lib.cj：新增 9 个矩阵类型的 public import；确认 scalar_mat_ops.cj 中的全局函数无需额外 import 语句（因为 lib.cj 已有 `public import glm.detail.{ add, sub, mul, div, mod }`，此语句自动覆盖 scalar_mat_ops.cj 中同名的 add/sub/mul/div 函数——两者同属 glm.detail 包，同名函数通过参数类型重载自然覆盖，无需额外 import）；新增 ext/ 向量别名文件的 public import；确认 mod 函数的矩阵版本不存在（矩阵取模无数学意义），lib.cj 的 mod 导出仅涉及向量版，不受影响；**关于 lib.cj 导出歧义评估**：当下游消费者同时 `import glm.*` 和 `import glm.detail.*` 时，add/sub/mul/div 函数的解析不产生歧义——两者导出的是同一个包（glm.detail）中的同一组重载函数，无论从哪条 import 路径引入，最终引用的目标函数完全相同（包级函数在包内唯一，不因 import 路径不同而产生多个候选），仓颉重载解析基于参数类型区分，add(s, v: Vec2) 与 add(s, m: Mat2x2) 参数类型完全不同，不会产生歧义
- cjpm.toml：确认 src-dir 配置覆盖 src/ext/ 目录

### 关于路线图中可选文件的处理
- `type_float.cj` 和 `type_half.cj`：**延迟至后续阶段**。这两个文件作为浮点类型标签（仅依赖 setup.cj），在阶段二无任何文件依赖它们，阶段四函数库实现时方有可能需要。不纳入本阶段产出物。

### 测试文件
- 矩阵类型测试：type_mat2x2_test.cj ~ type_mat4x4_test.cj
- 矩阵别名测试
- 向量别名测试（验证 ext/vector_float2.cj 等可正确引用 Vec2 等类型）
- 标量-矩阵运算测试：scalar_mat_ops_test.cj
- **别名类型构造函数和运算符可用性验证**：补充别名类型上的构造函数和运算符验证（如 `mat4(1.0f, 0.0f, ...)`、`mat4.identity(1.0f)`、`mat4 + mat4` 等），确保别名类型与原始泛型类型行为完全一致——别名是透明类型别名，所有构造函数和运算符应可直接在别名类型上调用

---

## 9. 对齐 GLM 参考实现的差异声明

| 差异 | 说明 |
|------|------|
| **无 C 数组成员** | GLM 中 col_type value[C] 的 C 数组在仓颉中替换为具名成员 c0, c1, ... |
| **无 GLM_CONFIG_* 条件编译** | 全部采用最保守值，不引入条件编译路径 |
| **无 ++/-- 运算符** | 仓颉不支持重载自增/自减运算符。可通过 `m += T(1)`（逐元素加 1）等价替代 C++ GLM 的 `++m` 语义 |
| **ext/ 别名文件为 package glm.ext 而非 C++ 的 namespace glm** | 仓颉包名与目录路径匹配规则约束 |
| **矩阵-矩阵除法推迟且仅限方阵** | 矩阵-标量除法（mat / scalar）和标量-矩阵除法（scalar / mat）属逐元素操作，本阶段可完整实现。仅矩阵-矩阵除法（mat / mat）依赖 inverse（阶段四完整实现），本阶段运算符内部调用 stub 函数。mat/mat、mat/col_vec、row_vec/mat 除法运算符**仅方阵类型（Mat2x2、Mat3x3、Mat4x4）** 提供，非方阵类型不提供这些除法运算符 |
| **标量左侧矩阵运算为全局函数而非运算符** | 仓颉 operator func 的 this 固定为左操作数，T + Mat 无法以运算符表达。改用 scalar_mat_ops.cj 中的全局具名函数（add/sub/mul/div）替代，调用方使用 add(s, m) 而非 s + m。所有函数标注 @OverflowWrapping |
| **无类型别名体系** | 仓颉类型别名只能定义在文件顶层，不能在结构体内部定义。各矩阵的列向量/行向量类型在使用处直接引用具体的 VecN<T,Q> 类型，不定义 col_type/row_type 等内部类型别名 |
| **无 `row()` 成员函数** | 行访问 `glm::row()` 在 C++ GLM 中为自由函数，阶段二不提供成员函数形式以免 API 不兼容，推迟至阶段四随 matrix.cj 自由函数版本提供 |
| **`col()` 代替 `componentAt()` 为列访问函数** | 为避免与 Vec 的 `componentAt`（返回标量）语义冲突，矩阵列访问统一命名为 `col(i)` |
| **`[]` 运算符取值版本返回列向量副本，不支持分量级链式修改** | C++ GLM 中 m[i] 返回引用，可直接修改 m[0].x = value；仓颉版本中 m[0] 返回列向量的副本（值语义），仅可整列赋值 m[0] = new_col，不能直接修改分量。如需修改单个分量，需先取列、修改、赋回（如 `var col = m[0]; col.x = value; m[0] = col`） |
| **fwd.cj 不包含 fmat/f32mat/f64mat 及整型矩阵别名** | C++ GLM fwd.hpp 中 fmat/f32mat/f64mat 是 mat/DMat 的冗余前缀别名，整型矩阵（imat/u8mat 等）为极低频场景。仓颉版本排除这些冗余别名以避免别名爆炸，详见 D19 |
| **非方阵不提供 *=（mat）复合赋值运算符** | 仓颉编译器仅在二元运算符返回类型与左操作数类型匹配时自动生成复合赋值。方阵乘法结果类型与左操作数相同，自动获得 *=；非方阵乘法结果类型不同（如 Mat2x3 * Mat3x2 → Mat3x3），编译器不生成 *= |
| **无 `init()` 默认构造函数，单位矩阵通过 `identity(one: T)` 工厂函数构造** | C++ GLM 中 `mat4()` 默认构造为单位矩阵。仓颉无约束泛型不支持 `T(0)/T(1)` 构造调用（与 deviations.md DV-01 的 `fromBoolVec` 需额外提供 zero/one 参数为同一根因限制），也无法在 struct 定义或 extend 块中声明 `init()` 无参构造函数并在其中使用 `T(0)/T(1)`。单位矩阵构造推迟到 `Number<T>` 约束的 extend 块，以 `public static func identity(one: T): Mat{C}x{R}<T,Q>` 工厂函数提供。调用方式从 `Mat4x4<Float32, PackedHighp>()` 变为 `Mat4x4<Float32, PackedHighp>.identity(1.0f)`——需额外传入 `one` 参数。此偏差与阶段一 Vec 类型无 `init()` 默认构造函数的策略一致（Vec1 的起始构造函数为 `init(scalar: T)`） |
| **标量填充构造为 `filled(scalar: T)` 工厂函数而非 `init(scalar: T)` 构造函数** | C++ GLM 中 `mat4(1.0f)` 构造对角矩阵。仓颉矩阵的 `init(scalar: T)` 在 struct 体内无法获得 T(0)（非对角线填充需要），故降级为 extend 块中的 `filled(scalar: T)` 工厂函数。调用方式：`Mat4x4<Float32, PackedHighp>.filled(1.0f)`。Vec2.init(scalar: T) 与此不构成类比——Vec2 的标量填充是全分量赋同一值，不涉及 T(0) |
| **跨矩阵类型转换为 `fromMat(m, one: T)` 工厂函数而非构造函数** | C++ GLM 的 `mat4(mat2)` 等转换构造函数在仓颉不可行——struct 体内的无约束泛型 T 无法获得 T(0)/T(1)（填充扩展位置需要）。降级为 `Number<T>` 约束 extend 块中的 `fromMat(m, one: T)` 静态工厂函数。调用方式：`Mat4x4<Float32, PackedHighp>.fromMat(m2x2, one: 1.0f)` |
| **跨类型逐分量构造为 `fromParts(conv, ...)` 工厂函数而非构造函数** | C++ GLM 的跨类型构造函数依赖隐式类型转换，仓颉泛型上下文中不可用。降级为带 conv 闭包的 `fromParts` 工厂函数，与阶段一 castVecN 模式一致。调用方式：`Mat4x4<Float32, PackedHighp>.fromParts({ x => Float32(x) }, ...)` |
| **跨类型列向量构造为 `fromColumns(conv, ...)` 工厂函数而非构造函数** | 与 fromParts 同理——跨类型转换要求 conv 闭包。调用方式：`Mat4x4<Float32, PackedHighp>.fromColumns({ x => Float32(x) }, v1, v2, v3, v4)` |
| **跨类型同尺寸转换为 `fromMat(m, conv)` 工厂函数而非构造函数** | 与 fromParts 同理——跨类型转换要求 conv 闭包。调用方式：`Mat4x4<Float32, PackedHighp>.fromMat(mInt, { x => Float32(x) })` |
| **`[]` 和 `col()` 不可在 `const` 上下文使用** | 与阶段一 Vec 的 `componentAt` 面临同类限制（deviations.md IF-03）：`[]` 和 `col()` 内部包含 `assert` + fallback `throw`，两者均非 `const` 函数，导致 `[]` 和 `col()` 不可声明为 `const func`。C++ GLM 中 `m[i]` 在 constexpr 上下文可用，仓颉版本受限于 assert/throw 机制无法在 const 上下文中使用矩阵下标访问 |
| **`identity(one)` 和 `filled(scalar)` 不可在 `const` 上下文使用** | `identity(one: T)` 涉及 `one - one` 运算获得 T(0)，`filled(scalar: T)` 涉及 `scalar - scalar` 运算获得 T(0)，两者均为非 const 表达式。C++ GLM 中 `constexpr mat4 m(1.0f)` 可在编译期求值，仓颉版本因泛型约束运算不满足 const 表达式规则而不可在 const 上下文使用。如果用户需要在 const 上下文构造单位矩阵，可使用逐分量 const init 构造：`const val m = Mat4x4<Float32, PackedHighp>(1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f)` |

---

## 修订说明（v2）

| 审查意见 | 修改措施 |
|---------|---------|
| 问题 1：ext/ 别名文件的包名称与目录结构不匹配 | 已采纳。将 ext/ 目录下所有别名文件的包声明改为 package glm.ext |
| 问题 2：D-08 中标量在矩阵左侧的运算符在仓颉中不可行 | 已采纳。将 D06 决策理由更新为使用全局具名函数 |

---

## 修订说明（v3）

| 审查意见 | 修改措施 |
|---------|---------|
| 标量左侧矩阵运算描述不准确 | 已采纳。修正为 scalar_mat_ops.cj 中的全局具名函数处理，与阶段一 scalar_vec_ops.cj 模式一致 |

---

## 修订说明（v4）

| 审查意见 | 修改措施 |
|---------|---------|
| 类型别名无法定义在结构体内部 | 已采纳。采用 Option B：完全移除全部类型别名，在使用处直接引用具体的 VecN<T,Q> 类型 |

---

## 修订说明（v5）

| 审查意见 | 修改措施 |
|---------|---------|
| 行向量×矩阵乘法签名错误 | 已采纳。修正签名为 Vec{R} * Mat{C}x{R} → Vec{C} |
| 跨尺寸矩阵乘法运算符未完整定义 | 已采纳。补充完整的跨尺寸乘法兼容性规则和列表 |
| 跨矩阵类型转换填充规则不精确 | 已采纳。补充精确填充规则描述 |
| ext/ 别名文件数量描述前后矛盾 | 已采纳。统一描述 |
| 矩阵除法 stub 依赖表述不准确 | 已采纳。区分 mat/scalar 和 mat/mat |
| 标量-矩阵除法的 stub 策略未说明 | 已采纳。明确仅 mat/mat 依赖 stub |

---

## 修订说明（v6）

| 审查意见 | 修改措施 |
|---------|---------|
| ext/ 向量别名文件未纳入 | 已采纳。新增 8 个向量别名文件 |
| D08 等效替代数学错误 | 已采纳。修正为 `m += T(1)` |
| 跨矩阵类型转换构造可行性 | 已采纳。补充可行性评估段落 |
| componentAt 语义与 Vec 冲突 | 已采纳。更名为 `col()` |
| row() 成员函数阶段问题 | 已采纳。推迟至阶段四 |
| 跨类型构造同 T 未明确 | 已采纳。新增跨类型同尺寸转换构造 |
| 标量-矩阵运算溢出策略 | 已采纳。标注 @OverflowWrapping |
| mat/vec 除法运算未讨论 | 已采纳。推迟至阶段四仅方阵 |
| 跨矩阵转换填充规则对非数值类型适用性 | 已采纳。约束标注 |

---

## 修订说明（v7）

| 审查意见 | 修改措施 |
|---------|---------|
| 关键行为验证示例 C1=R2 注解错误 | 已采纳。修正为 C1=R2=2 |
| 默认单位矩阵构造的 const init 降级方案 | 已采纳。补充降级方案 |
| col() 与 [] 行为差异描述不清 | 已采纳。重写为完全等价 |
| scalar_mat_ops.cj 命名约定冲突 | 已采纳。新增 D15 更新约定 |
| fwd.cj 矩阵别名命名规范未定义 | 已采纳。新增 D16 |
| @Derive[Hashable] 一致性 | 已采纳。新增 D17 |
| type_float.cj/type_half.cj 取舍 | 已采纳。新增 D18 |

---

## 修订说明（v8）

| 审查意见 | 修改措施 |
|---------|---------|
| PackedHighp vs Defaultp 理由未说明 | 已采纳。补充三点理由 |
| fwd.cj 缺少精度族矩阵别名 | 已采纳。补充非方阵默认精度别名和纳排决策，新增 D19 |
| 非方阵 *=（mat）误导 | 已采纳。明确仅方阵自动获得 *= |
| 跨矩阵转换"对应位置"语义不精确 | 已采纳。重写为精确定义 |
| 非方阵标量填充"主对角线"长度 | 已采纳。补充 min(C,R) 说明 |
| scalar/mat 除法实现策略 | 已采纳。明确逐元素实现 |
| 非方阵不提供 mat/mat 除法 | 已采纳。明确标注仅方阵 |
| ext/ 导入风格差异 | 已采纳。补充说明 |
| lib.cj 导出措辞模糊 | 已采纳。改为明确决策 |
| 跨尺寸乘法文件归属未定义 | 已采纳。定义策略 |
| 整型矩阵除零风险 | 已采纳。注明与阶段一一致 |
| [] 返回副本差异未在 §9 记录 | 已采纳。补充差异声明 |
| equalEpsilon 实现方式未明确 | 已采纳。明确逐列委托 |

---

## 修订说明（v9）

| 审查意见 | 修改措施 |
|---------|---------|
| P1（严重）：init() 默认单位矩阵构造在无约束泛型 T 下依赖 T(0)/T(1) 不可行 | 已采纳。删除 init() 默认构造，新增 identity() 静态工厂函数 + D20 |
| P2（一般）：第 2 条与第 9 条构造函数重载歧义 | 已采纳。删除原第 2 条 + D21 |
| P3（轻微）：type_mat4x3.cj 条目标注错误 | 已采纳。修正为 Mat4x3<T,Q> |
| P4（一般）：ext/ 向量别名与 fwd.cj 别名定位差异 | 已采纳。补充定位差异说明 |
| P5（一般）：跨矩阵转换填充规则与 GLM 不一致 | 已采纳。补充编码阶段注意事项 |
| P6（轻微）：[] 和 col() 的 const func 限制未记录 | 已采纳。补充 §9 差异声明 |

---

## 修订说明（v10）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题 1（严重）**：`identity()` 中 T(1) 演算公式 `let one = -(!(zero))` 依赖 `!` 运算符，但 `!` 属于 `Integer<T>` 而非 `Number<T>`，对 Float32/Float64 不可用；与阶段一 `increment()` 的类比前提错误——`increment()` 定义在 `Integer<T>` 约束的 extend 块中 | **已采纳**。① 将 `identity()` 签名改为 `identity(one: T): Mat{C}x{R}<T,Q>`，要求调用方显式传入 T(1) 参数；② T(0) 改用 `one - one` 在 `Number<T>` 约束上下文中演算；③ 更新 D20 决策：明确声明 `Number<T>` 约束下 `!` 运算符不可用，T(1) 演算公式 `-(!(zero))` 不可行，必须通过参数传入；④ 在 §1 新增"系统性设计约束"段落，统一阐述 T(0)/T(1) 获取问题的根因和统一策略 |
| **问题 2（一般）**：`init(scalar: T)` 标量填充构造中 T(0) 获取方式不可行——struct 体内 T 无约束，不能执行 `scalar - scalar`；且矩阵的 init(scalar) 语义是对角矩阵而非 Vec 的全分量赋同一值 | **已采纳**。① 将标量填充构造从 `init(scalar: T)` 降级为 extend 块中的 `filled(scalar: T): Mat{C}x{R}<T,Q>` 静态工厂函数；② 在 `Number<T>` 约束的 extend 块中通过 `scalar - scalar` 获得 T(0)；③ 新增 D22 记录此决策，明确说明矩阵标量填充与 Vec2.init(scalar) 语义不可类比；④ 更新 §9 差异声明新增"标量填充构造为 filled 工厂函数"条目 |
| **问题 3（一般）**：72 个跨矩阵类型转换构造函数需 T(0)/T(1) 但 struct 体内无约束泛型无法获得；与问题 2 根因相同但改进策略不一致 | **已采纳**。① 将 72 个跨尺寸转换构造统一降级为 `Number<T>` 约束 extend 块中的 `fromMat(m, one: T)` 静态工厂函数；② T(0) 通过 `someValue - someValue` 在 `Number<T>` 上下文中演算，T(1) 通过参数 `one` 传入；③ 新增 D23 记录此决策，明确说明与 D22（标量填充降级）和 D20（identity 降级）形成统一的解决策略——所有需要 T(0)/T(1) 的构造统一改为 extend 块中的工厂函数；④ 更新 §9 差异声明新增"跨矩阵类型转换为 fromMat 工厂函数"条目 |
| **问题 4（轻微）**：精度变体命名是否覆盖方阵短别名未明确 | **已采纳**。在 §8 fwd.cj 命名规则中补充"精度变体覆盖方阵短别名"行：`Highpmat{C}`、`Mediumpmat{C}`、`Lowpmat{C}`（Float32 族），`Highpdmat{C}`、`Mediumpdmat{C}`、`Lowpdmat{C}`（Float64 族）。更新 D16 |
| **问题 5（一般）**：`[]` 运算符赋值版本签名缺少 `mut` 修饰符 | **已采纳**。在 §3.4 中将赋值版本签名补全为 `mut operator func [](i: Int64, value!: VecR<T,Q>): Unit`，与阶段一 Vec2 实际实现一致 |
| **问题 6（一般）**：跨类型逐分量构造和跨类型列向量构造在 struct 体内的实现可行性未分析；未参考阶段一 castVecN 模式 | **已采纳**。① 分析可行性：struct 体内无约束泛型 T 上下文中隐式类型转换不可用，也不可在 extend 块中添加 U→T 的隐式转换能力；② 统一降级为带 conv 闭包的具名工厂函数——`fromParts(conv, ...)` 和 `fromColumns(conv, ...)`，与阶段一 `castVecN(v, conv)` 模式一致；③ 新增 D24 记录此决策；④ 更新 §9 差异声明 |
| **问题 7（轻微）**：`col()` 与 `[]` 并存但未说明编码级使用场景差异指导 | **已采纳**。在 §3.4 中补充编码指导：① 两者应在同一 extend 块中定义；② 推荐编码规范：内部实现用 `[]`、对外 API 用 `col()` |
| **问题 8（一般）**：lib.cj 导出 add/sub/mul/div 时下游 `import glm.*` 和 `import glm.detail.*` 是否产生歧义未评估 | **已采纳**。在 §8 lib.cj 条目中补充歧义评估：两者导出的是同一个包中的同一组重载函数，不产生歧义——无论从哪条 import 路径引入，最终引用的目标函数完全相同；参数类型重载赵然区分 |
| **问题 9（一般）**：`const init` 条件性描述未为各构造函数分类标注 | **已采纳**。在 §3.3 末尾新增"构造函数/工厂函数 const init 可用性汇总"表，逐条标注 8 种构造/工厂的 const 可用性和理由：①② 为 const init 可用（纯赋值）；③④⑤⑥⑦⑧ 均为非 const（涉及运算或闭包） |
| **问题 10（轻微）**：跨尺寸矩阵乘法运算符的 import 策略描述冗余/误导——同包内无需 import | **已采纳**。在 §3.5 跨尺寸乘法兼容性表后明确说明：9 个矩阵类型均在 glm.detail 同包中，同包类型互相直接可见，无需跨文件 import。移除"在对应文件顶部 import 所需右操作数矩阵类型"的误导性描述 |
| **问题 11（轻微）**：测试文件中缺少别名类型的构造函数可用性验证 | **已采纳**。在 §8 测试文件中补充"别名类型构造函数和运算符可用性验证"要求 |
| **问题 12（一般）**：`identity()` 未分析 const func 可行性，也未在 §9 差异声明中记录与 C++ GLM constexpr 行为差异 | **已采纳**。① 在 §3.3 第 8 条 identity 段落中补充 const func 不可用的分析：涉及 `one - one` 运算不满足 const 表达式要求；② 新增 D26 记录此决策；③ 在 §9 差异声明中新增"`identity(one)` 和 `filled(scalar)` 不可在 `const` 上下文使用"条目，注明 C++ GLM 中 `constexpr mat4 m(1.0f)` 可用而仓颉不可用，并提供使用逐分量 const init 构造作为替代的迁移建议 |
