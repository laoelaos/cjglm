# GLM 1.0.3 仓颉迁移阶段二 OOD 设计方案（v14）

> **修订日期**：2026-06-22

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
  ├── matrix.cj ★           — stub（仅函数签名空壳，供 type_mat2x2/type_mat3x3/type_mat4x4 依赖闭合；以及附带提供的额外矩阵运算函数）
  ├── geometric.cj ★        — stub（仅函数签名空壳，供 type_mat4x4 依赖闭合）
  ├── scalar_mat_ops.cj ★   — 标量-矩阵运算全局具名函数（add、sub、mul、div），处理 T + Mat 等标量左侧运算
  │                          （与 scalar_vec_ops.cj 同属 glm.detail，通过参数类型重载区分）
  │                          注意：此文件不包含 mod 函数（矩阵取模无数学意义，GLM 也未为矩阵类型定义 % 运算符）
  └── type_vecN.cj（修改）★  — Vec1~Vec4 各新增行向量×矩阵成员运算符 `Vec{R} * Mat{C}x{R}` extend 块（方案A）

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

### cjpm 子包构建预验证

**编码启动前须验证**：在正式编写 ext/ 别名文件之前，须先验证 cjpm 对 `src/ext/` + `package glm.ext` 子包的发现和构建机制是否可正常工作。具体验证步骤：
1. 在 src/ext/ 下创建一个最小化测试文件（如 matrix_float4x4.cj），声明 `package glm.ext`，import glm.detail 中的类型
2. 运行 `cjpm build` 确认构建通过
3. 确认 cjpm.toml 的 src-dir 配置覆盖 src/ext/ 目录
4. 确认从外部包 `import glm.ext.matrix_float4x4.{ mat4 }` 可正常解析

此验证宜在编码启动首日完成。若 cjpm 不支持此子包结构，则需调整为将 ext/ 文件置于 src/ 根目录并声明 package glm（需在项目级评估别名冲突风险）。

---

## 3. 核心抽象

### 3.1 矩阵结构体

**角色**：表示 C×R 数学矩阵的值对象。每个矩阵类型是独立泛型结构体，以列向量为数据成员，采用列主序（column-major）存储。

**职责**：
- 承载 C 个列向量数据成员（var c0: VecR<T,Q>、var c1: VecR<T,Q> 等，其中 R = 行数）
- 提供编译期查询函数 const func length(): Int64 返回列数 C（const func 声明，可在 const 上下文中调用）
- 提供下标运算符 [](i: Int64) 访问列向量（取值 + 赋值双版本）
- 提供逐分量构造函数和向量列构造函数
- 通过 @Derive[Hashable] 自动派生哈希支持（与阶段一 Vec 类型一致，所有成员类型 VecN<T,Q> 均已可哈希）
  - **T=Bool 可行性验证**：Bool 已实现 Hashable 接口（证据：阶段一中 Vec{1..4}<Bool, Q> 已通过 @Derive[Hashable] 正确编译且可用于 HashSet/HashMap，若 Bool 未实现 Hashable 则 Vec<Bool,...> 的 @Derive[Hashable] 会因"字段类型需实现 Hashable"的约束而编译失败）。矩阵类型仅包含 VecN<T,Q> 成员，当 T=Bool 时 VecN<Bool,Q> 的 Hashable 通过编译器验证，因此矩阵的 @Derive[Hashable] 安全可用，无需额外条件派生约束

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
   - 完整泛型参数展开（以 Mat4x4 为例）：`extend<T, Q> Mat4x4<T, Q> where T <: Number<T>, Q <: Qualifier` 中的 `public static func filled(scalar: T): Mat4x4<T,Q>`——Q 从实例上下文推断或显式指定，无需额外传入
   - 主对角线填 scalar，其余填零值，产生对角矩阵
   - 主对角线长度为 min(C, R)：对于方阵（如 Mat4x4），主对角线长度为 4；对于非方阵，主对角线长度为 min(C,R)，即沿 (0,0), (1,1), ... 对角线填 scalar 直到行或列先耗尽
   - 例如 `Mat2x3.filled(1.0f)` 产生 2×3 对角矩阵（列主序展示）：第 0 列 `[1.0f, 0.0f, 0.0f]`，第 1 列 `[0.0f, 1.0f, 0.0f]`（主对角线长度 min(2,3)=2，第 1 列第 2 行填 1.0f，其余填零）。**注意**：此处展示采用列主序格式，与矩阵内部数据组织方式一致
   - **实现策略**：T(0) 通过 `scalar - scalar` 在 `Number<T>` 约束的 extend 块中演算获得；T(1) 在此构造中不需要
   - **为何不能用 init(scalar: T) 构造函数**：struct 体内的 init 构造函数中 T 是无约束泛型，无法执行 `scalar - scalar` 运算。构造函数必须在 struct 体内定义，不能在 extend 块中定义（仓颉语言限制）。故改为 extend 块中的静态工厂函数
   - **const init 不可用**：涉及 `Number<T>` 运算（`scalar - scalar`），const init 仅允许纯赋值，不允许运算表达式
   - **与阶段一 Vec2.init(scalar: T) 的语义差异**：Vec2 的 `init(scalar: T)` 是全分量赋同一标量值（直接赋值，无需 T(0)），矩阵的标量填充是对角矩阵（非对角线需填 T(0)），两者不可类比。矩阵 `filled(scalar)` 不可复用 Vec 的 `init(scalar: T)` 语义
   - **边界行为确认**：即使 scalar=T(0)，`scalar - scalar` 仍正确产生 T(0)，filled(0.0f) 产生零矩阵（全部元素为 0），语义上与 C++ GLM 的 `mat(0.0f)` 一致——构造一个全部分量为零的矩阵

4. **跨类型逐分量构造**（工厂函数，降级为 `fromParts` 模式）
   - 降级为带类型转换闭包的具名工厂函数：`public static func fromParts<U>(conv: (U) -> T, x0: U, y0: U, ..., x3: U, z3: U, w3: U): Mat4x4<T,Q>`
   - 接收与逐分量构造相同数量的参数，但各参数为类型 U，通过 conv 闭包转换为 T
   - **fromParts 仅支持单一源类型 U**：所有标量参数共享同一类型 U 和同一 conv 闭包——与 C++ GLM 不同，C++ GLM 的构造函数允许每个参数独立隐式转换。此限制是仓颉泛型系统的必然结果：构造函数的每个类型参数须在签名中声明，且 `extend` 中的 `fromParts` 须确保 U 与 T 之间有可定义的转换关系。多源类型构造将导致类型参数爆炸，不可行
   - **降级理由**：仓颉泛型上下文下隐式类型转换不可用——在 struct 体的无约束泛型 T 上下文中，不能将 U 类型参数自动转换为 T；在 extend 块中虽可添加 U <: Number<U> 等约束，但此时仍需显式转换闭包。此设计参考阶段一 `castVecN(v, conv)` 模式：castVecN 同样不依赖隐式转换，而是要求调用方显式提供 conv 闭包
   - **定义位置**：fromParts 定义在仅带 `Q <: Qualifier` 约束的 extend 块中（而非 `Number<T>` 约束的 extend 块），因为其实现仅涉及 conv 闭包调用和赋值操作，不依赖 `Number<T>` 提供的任何运算。此决策与 P3 审查意见一致
   - **const init 不可用**：涉及类型转换闭包调用

5. **跨类型列向量构造**（工厂函数，降级为 `fromColumns` 模式）
   - 降级为带类型转换闭包的具名工厂函数：`public static func fromColumns<V1, Q2>(conv: (V1) -> T, v1: Vec4<V1, Q2>, v2: Vec4<V1, Q2>, v3: Vec4<V1, Q2>, v4: Vec4<V1, Q2>): Mat4x4<T,Q> where Q2 <: Qualifier`（以 Mat4x4 为例，各列向量分量类型 V1 到 T 的转换通过 conv 闭包）
   - 实际编码时按矩阵列数调整参数：2 列矩阵仅需 v1, v2；3 列矩阵需 v1, v2, v3
   - **fromColumns 单一 V1 类型参数限制**：所有列向量共享同一分量类型 V1，与 C++ GLM 的 4 列独立类型参数（如 `mat4(vec4_a, vec4_b, ivec4_c, ivec4_d)` 中各列可独立指定类型）不同。仓颉版本中各列分量类型必须相同——这是泛型工厂函数签名的必然约束：每个类型参数须在签名中声明，而声明 4 个独立列分量类型参数将使签名膨胀且调用时类型推断困难。此差异属于仓颉与 C++ GLM 的容量差异，记录在 §9 差异声明中
   - **降级理由**：与第 4 条相同——跨类型转换在仓颉泛型上下文中不可隐式进行。统一采用 castVecN 的 conv 闭包模式
   - **定义位置**：fromColumns 定义在仅带 `Q <: Qualifier` 和 `Q2 <: Qualifier` 约束的 extend 块中（而非 `Number<T>` 约束的 extend 块），因为其实现仅涉及 conv 闭包调用和赋值操作，不依赖 `Number<T>` 提供的任何运算。此决策与 P3 审查意见一致
   - **const init 不可用**：涉及类型转换闭包调用

6. **跨矩阵类型转换**（工厂函数，定义在带 `Number<T>` 约束的 extend 块中）
   
   **拆分为两个独立工厂函数**，以解决 `SrcT ≠ T` 时类型转换不可行的问题：
   
   **6a. 同类型跨尺寸转换**：`public static func fromMat<SrcQ>(m: Mat{C_src}x{R_src}<T, SrcQ>, one: T): Mat{C}x{R}<T,Q> where SrcQ <: Qualifier`
   - 源矩阵的元素类型与目标矩阵相同（均为 T），仅尺寸和/或 Qualifier 不同
   - 因 SrcT = T，直接赋值可行，无需 conv 闭包
   - **移除 SrcT 类型参数**：因源矩阵元素类型固定为 T，仅保留 SrcQ 以允许跨 Qualifier 转换
   - **SrcQ 的作用**：当源矩阵与目标矩阵有不同的 Qualifier 时（如 `PackedHighp` → `AlignedHighp`），SrcQ 允许接受不同 Qualifier 的源矩阵。但 SrcQ 在实现中不参与运算逻辑——它仅出现在源矩阵类型参数 `Mat{C_src}x{R_src}<T, SrcQ>` 中，使 fromMat 可以接受不同 Qualifier 的同类型矩阵。**SrcQ 的影响**：SrcQ 使 fromMat 对每个 Qualifier 组合形成重载（如 SrcQ=PackedHighp 和 SrcQ=AlignedHighp 各一个重载），但由于仓颉泛型实例化是按需进行的，且编译器会将 Qualifier 相同的实例合并，SrcQ 并不显著膨胀运行时代码量
    - **参数 `one: T` 的必要性**：填充规则需要 T(1)（对角扩展位置），而 `Number<T>` 约束下无法演算出 T(1)。T(0) 通过 `someValue - someValue` 在 `Number<T>` 上下文中演算。因此 `one` 必须由调用方传入
    - **`one: T` 参数在尺寸缩减方向的冗余性分析**：当 C_dst ≤ C_src 且 R_dst ≤ R_src 时（尺寸全面缩减），fromMat 的填充规则仅涉及源矩阵元素复制（`dst[j][i] = src[j][i]`，0 ≤ j < C_dst，0 ≤ i < R_dst），无扩展列/行需填充单位矩阵值——因此 `one` 参数虽存在于签名中但在执行流程中不参与运算，属于冗余参数。设计选择：**仍保留 `one` 参数统一签名形式**，原因：① 若为缩减方向额外提供 `fromMatTruncate` 无 `one` 参数的重载，将使 fromMat 的重载集膨胀（72→144 个逻辑签名），大量重载仅为省略一个参数，成本与收益不匹配；② 保留 `one` 统一签名使调用方无需根据尺寸方向选择不同的工厂函数，降低心智负担；③ 编码文档中标注此冗余场景，作为简化路径留待后续版本评估。当 R_dst > R_src 但 C_dst ≤ C_src 时 `one` 部分参与运算（额外行需单位矩阵填充），仅 C_dst ≤ C_src 且 R_dst ≤ R_src 同时满足时 `one` 完全冗余
   - 调用示例：`let m4 = Mat4x4<Float32, PackedHighp>.fromMat(m2x2, one: 1.0f)` — 2×2 同类型矩阵扩展为 4×4
    - 完整泛型参数展开（以 Mat4x4 ← Mat2x2 为例）：`extend<T, Q> Mat4x4<T, Q> where T <: Number<T>, Q <: Qualifier` 中的 `public static func fromMat<SrcQ>(m: Mat2x2<T, SrcQ>, one: T): Mat4x4<T,Q> where SrcQ <: Qualifier`——Q/SrcQ 从实例上下文推断或显式指定，T 从 `one` 参数推断
   - **调用指导**：当源矩阵与目标矩阵元素类型相同（SrcT=T）时，应使用 6a 版本（无需 conv）。6a 版本有 2 个位置参数（m, one），6b 版本有 3 个位置参数（conv, m, one），两者参数数量和第一个参数类型均不同，不存在匹配歧义——调用方根据是否需要 conv 闭包自然选择。当 SrcT=T 时优先使用 6a（更简洁，无需提供 conv 闭包）
   
   **6b. 跨类型跨尺寸转换**：`public static func fromMat<SrcT, SrcQ>(conv: (SrcT) -> T, m: Mat{C_src}x{R_src}<SrcT, SrcQ>, one: T): Mat{C}x{R}<T,Q> where SrcQ <: Qualifier`
   - 源矩阵的元素类型（SrcT）与目标矩阵的元素类型（T）不同，需要 conv 闭包将 SrcT 转换为 T
   - **conv 闭包的必要性**：当 SrcT ≠ T 时，`dst[j][i] = src[j][i]` 赋值不可行（类型不匹配）。必须通过 conv 闭包逐一转换元素：`dst[j][i] = conv(src[j][i])`
   - **填充规则（跨类型版本）**：源矩阵第 j 列第 i 行的元素 `src[j][i]`，当 0 ≤ j < min(C_src, C_dst) 且 0 ≤ i < min(R_src, R_dst) 时，经 conv 转换写入目标矩阵：`dst[j][i] = conv(src[j][i])`；当 C_dst > C_src 时，额外列从单位矩阵取值——即 (j,j) 填 `one`（= T(1)），其余填 T(0)；当 R_dst > R_src 时，对于每个额外行 i ≥ R_src，若 i < C_dst 则 (i,i) 填 `one`、其余填 T(0)；若 i ≥ C_dst 则整行填 T(0)。T(0) 通过 `one - one` 在 `Number<T>` 上下文中演算获得
   - 调用示例：`let m4f = Mat4x4<Float32, PackedHighp>.fromMat({ x => Float32(x) }, m2x2_int, one: 1.0f)` — Int32 的 2×2 矩阵转换为 Float32 的 4×4 矩阵
   - **参数 `one: T` 的必要性**：与 6a 相同——扩展位置需要 T(1)，由 one 传入
   - 完整泛型参数展开（以 Mat4x4 ← Mat2x2 跨类型为例）：`extend<T, Q> Mat4x4<T, Q> where T <: Number<T>, Q <: Qualifier` 中的 `public static func fromMat<SrcT, SrcQ>(conv: (SrcT) -> T, m: Mat2x2<SrcT, SrcQ>, one: T): Mat4x4<T,Q>`
   
   **6a 和 6b 共享的设计属性**：
   - **精确填充规则（同类型 6a 版本）**：源矩阵第 j 列第 i 行的元素 M_src[j][i] 复制到目标矩阵的相同坐标位置（即 dst[j][i] = src[j][i]），其中 0 ≤ j < min(C_src, C_dst)、0 ≤ i < min(R_src, R_dst)。当 C_dst > C_src 时，额外列（j ≥ C_src）从单位矩阵取值——即 (j,j) 填 `one`，其余填 T(0)；当 R_dst > R_src 时，对于每个额外行 i ≥ R_src，若 i < C_dst 则 (i,i) 填 `one`、其余填 T(0)；若 i ≥ C_dst 则整行填 T(0)
   - 例如 Mat2x2 → Mat4x4：src[j][i] 填入 dst[j][i]（0 ≤ j < 2, 0 ≤ i < 2），dst[2][2]=one, dst[3][3]=one，其余扩展位置填 T(0)
   - **为何降级为 extend 块中的工厂函数而非 struct 体中的构造函数**：跨尺寸转换需要 T(0)/T(1)，而 struct 体内的 T 是无约束泛型，无法执行运算。在 `Number<T>` 约束的 extend 块中，T(0) 可通过 `someValue - someValue` 演算获得，T(1) 通过参数传入
    - **编码阶段注意事项**：上述填充规则作为主规则描述，但 GLM 的实际实现中某些转换构造函数的行为与主规则存在局部差异——特别是当 C_src > C_dst 且 R_src < R_dst 时，部分 .inl 文件的逐列构造行为可能偏离主规则（例如 Mat4x4 ← Mat4x2 场景中，GLM 丢弃源矩阵第 2、3 列数据并替换为单位矩阵列，而主规则会复制源矩阵第 2、3 列的部分数据后再补齐）。**编码阶段须逐一对照 GLM .inl 源码实现各转换工厂函数**，而非机械套用主规则
    - **已知偏离示例（Mat4x4 ← Mat4x2）**：主规则描述如下——源矩阵 Mat4x2（4 列 2 行）和目标 Mat4x4（4 列 4 行）：C_src=4, C_dst=4, R_src=2, R_dst=4。根据主规则，0 ≤ j < min(4,4)=4 且 0 ≤ i < min(2,4)=2 的范围内复制 src[j][i] → dst[j][i]（即复制前 2 行的全部 4 列数据）。额外行（i ≥ 2）从单位矩阵取值：dst[2][2]=one，dst[3][3]=one，其余扩展行位置填 T(0)。但对照 GLM type_mat4x4.inl 第 35-44 行的实际实现：GLM 对每一列 j 逐列构造列向量——第 j 列列向量首先初始化为零向量，然后将列向量第 j 行设为 one——这意味着 GLM 的 Mat4x4(Mat4x2) 实际上忽略了源矩阵中被 C_src=4 列覆盖但第 i 行 ≥ R_src=2 的扩展行数据，而是直接填入单位矩阵的（j,j）位置。具体差别：GLM 将 dst[2][2](j=2,i=2) 填 one，dst[3][3](j=3,i=3) 填 one；而主规则会先将 src[2][0..1] 的两行两列数据复制到 dst[2][0..1] 后，再在 dst[2][2] 填 one。此偏离影响 2 行 → 3/4 行的跨尺寸转换场景（Mat4x2→Mat4x3/Mat4x4，Mat3x2→Mat3x3/Mat3x4，Mat2x2→Mat2x3/Mat2x4），编码阶段须逐场景对照 GLM .inl 源文件确认
   - **const init 不可用**：涉及运算和参数化填充
   
   **跨矩阵类型转换工厂函数的数量推导**：
   - 9 种目标矩阵类型，每种可从 8 种非自身源矩阵尺寸转换而来
   - 跨尺寸转换总数：9 × 8 = 72 个
   - 其中每个 fromMat 针对**同类型**（6a）或**跨类型**（6b）各一版
   - 注意：6a 版本中 SrcQ 是类型参数（每次调用时由编译器推断具体 Q），不影响编译产出的静态函数数量——仓颉泛型实例化按需进行
   - 当考虑 SrcQ 时，6a 版本的"逻辑重载数"不变（每个目标-源对仅一个 fromMat 6a 签名），SrcQ 仅影响运行时的泛型实例化
   - **144 个 fromMat 重载（72 个转换对 × 2 变体）的编译可行性评估**：每个 fromMat 工厂函数是在 `extend<T, Q> Mat{C}x{R}<T, Q> where T <: Number<T>, Q <: Qualifier` 块中定义的静态泛型函数。每个目标矩阵类型的 extend 块中将包含 8 个 fromMat（6a）和 8 个 fromMat（6b）共 16 个静态函数签名。由于这些函数均为泛型函数（T 和 Q 在 extend 块级别声明），仓颉编译器按需实例化——仅当用户代码实际调用某个 fromMat 时才会触发对应泛型实例的代码生成。16 个静态函数签名分布在单个 extend 块中，语法上可行（仓颉对单个 extend 块中的静态函数数量无上限限制）。**编码阶段建议**：若 16 个 fromMat 签名过长导致可读性问题，可拆分为多个 extend 块（仓颉允许同一类型有多个 extend 块），按源矩阵分组

7. **跨类型同尺寸转换构造**（init<U, P>(m: Mat4x4<U, P>)）
    - 从相同矩阵尺寸但不同元素类型和/或不同 Qualifier 的实例转换
    - 当 U=T 时自然涵盖跨 Qualifier 复制（即原第 2 条功能被本条完全覆盖）
    - **可行性分析**：此构造函数在 struct 体内定义，U 和 T 均为无约束泛型参数。构造函数体内部直接将 `m.c0` 等赋值给 `this.c0`，这要求 Vec4<U, P> 可隐式转换为 Vec4<T, Q>——在无约束泛型上下文中不可行。因此本构造函数也需降级为工厂函数：`public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x4<U, P>): Mat4x4<T,Q>`，与第 4、5 条的 castVecN conv 闭包模式一致
    - **const init 不可用**：涉及类型转换闭包调用

    **第 7 条与第 6a 条的功能重叠说明及简化路径**：当源矩阵与目标矩阵元素类型相同（U=T）且尺寸相同时，第 7 条 `fromMat<U, P>(conv: (U) -> T, m: Mat4x4<U, P>)` 与第 6a 条 `fromMat<SrcQ>(m, one: T)` 功能完全重叠——此时第 7 条要求调用方提供不必要的 conv 闭包（如 `{x: T => x}`），而第 6a 条无需 conv 闭包即可完成同类型同尺寸复制（仅跨 Qualifier）。**推荐规则**：当源矩阵与目标矩阵元素类型相同、尺寸相同且 Qualifier 也相同时（即类型完全一致），更优的选择是直接值类型赋值——`let m_dst = m_src`，完全不需要调用 fromMat 工厂函数。当仅跨 Qualifier 时（`m_src: Mat{C}x{R}<T, SrcQ>` → `m_dst: Mat{C}x{R}<T, Q>`），需使用 fromMat 6a 版本。第 7 条仅应在 U≠T 的跨类型转换场景中使用

8. **单位矩阵工厂函数**（public static func identity(one: T): Mat{C}x{R}<T,Q>）
   - 返回主对角线为 T(1)、其余为 T(0) 的单位矩阵
   - 定义在带 `Number<T>` 约束的 extend 块中
   - 完整泛型参数展开（以 Mat4x4 为例）：`extend<T, Q> Mat4x4<T, Q> where T <: Number<T>, Q <: Qualifier` 中的 `public static func identity(one: T): Mat4x4<T,Q>`——Q 从实例上下文推断或显式指定，T 从 `one` 参数推断
   - **参数 `one: T` 的必要性**：`Number<T>` 约束下无法演算出 T(1)（详见 §1 系统性设计约束），因此 T(1) 必须由调用方显式传入。T(0) 通过 `one - one` 在 `Number<T>` 上下文中演算获得
   - **const func 不可用**：`identity()` 涉及 `one - one` 运算来获得 T(0)，const func 中的表达式必须是 const 表达式，而减法运算在泛型约束上下文中不满足 const 表达式要求。因此 `const val m = Mat4x4<Float32, PackedHighp>.identity(1.0f)` 不可用——为此需在 §9 差异声明中记录
   - **调用方式变更**：C++ GLM 的 `mat4()` 无参默认构造改为 `Mat4x4<Float32, PackedHighp>.identity(1.0f)`。此为用户可见的 API 差异，在 §9 差异声明中记录
   - **为何不以 init() 形式提供**：仓颉无约束泛型参数不支持 `T(0)/T(1)` 构造调用。即使添加 `Number<T>` 约束，`Number<T>` 接口也不提供 `T(n)` 构造声明。构造函数必须在 struct 定义中声明，不能在 extend 块中添加。单位矩阵构造只能在 `Number<T>` 约束的 extend 块中作为静态工厂函数实现
    - **非方阵语义说明**：`identity(one: T)` 对所有 9 种矩阵类型均提供。对于方阵类型（Mat2x2/Mat3x3/Mat4x4），`identity(one)` 返回数学意义上的单位矩阵。对于非方阵类型（Mat2x3/Mat2x4/Mat3x2/Mat3x4/Mat4x2/Mat4x3），`identity(one)` 返回主对角线填 one、其余填 T(0) 的对角矩阵——这与 `filled(one)` 产生的结果完全相同。非方阵上 `identity(one)` 等价于 `filled(one)` 是有意设计：保持 API 统一性（所有 9 种矩阵类型均可调用 identity），使编码者不必为方阵和非方阵写条件分支
    - **非方阵 identity 实现策略**：非方阵的 `identity(one)` 应内部委托 `filled(one)`，而非独立实现。原因：非方阵上当 identity 和 filled 产生相同结果（主对角线填 one、其余填 T(0)），为 identity 编写独立的实现代码将产生完全相同的逻辑，导致 6 种非方阵类型产生 12 个（6 identity + 6 filled）内部逻辑完全相同的函数。委托策略仅需在非方阵 identity 函数体内调用 `return filled(one)`，避免代码重复。方阵的 identity 仍保持独立实现（方阵 identity 语义为"单位矩阵"，filled 语义为"对角矩阵"，两者在方阵上结果相同但概念不同，独立实现保持语义清晰）
    - 此设计与 C++ GLM 的区别在于：C++ GLM 中非方阵的默认构造 `mat2x3()` 也执行相同的对角初始化行为（主对角线填 1、其余填 0），但 C++ GLM 在非方阵上不将此操作称为"单位矩阵"。此语义差异在 §9 差异声明中记录

**构造函数/工厂函数 const init 可用性汇总**：

| 编号 | 构造方式 | const init/const func | 理由 |
|------|---------|----------------------|------|
| 1 | 逐分量同类型构造 | ✅ const init 可用 | 纯赋值，无运算无转换 |
| 2 | 列向量构造 | ✅ const init 可用 | VecR 已有 const init，内部为纯赋值 |
| 3 | 标量填充（filled） | ❌ 非 const | 涉及 `scalar - scalar` 运算 |
| 4 | 跨类型逐分量（fromParts） | ❌ 非 const | 涉及 conv 闭包调用 |
| 5 | 跨类型列向量（fromColumns） | ❌ 非 const | 涉及 conv 闭包调用 |
| 6a | 同类型跨矩阵转换（fromMat） | ❌ 非 const | 涉及运算和参数化填充 |
| 6b | 跨类型跨矩阵转换（fromMat + conv） | ❌ 非 const | 涉及 conv 闭包调用和运算 |
| 7 | 跨类型同尺寸转换（fromMat + conv） | ❌ 非 const | 涉及 conv 闭包调用 |
| 8 | 单位矩阵（identity） | ❌ 非 const func | 涉及 `one - one` 运算 |
| — | const func length() | ✅ const func 可用 | 返回编译期常量（列数 C），无运算无分配 |

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

- **分量级修改操作流程**：

  C++ GLM 中可通过 `m[i][j] = value` 直接修改矩阵第 i 列第 j 行的分量，仓颉版本中因 `[]` 取值版本返回列向量副本，不支持链式分量修改。分量级修改需要三步操作：

  ```cangjie
  // 分量级修改示例（修改 Mat4x4 第 0 列第 2 行分量）
  var c = m[0]              // 步骤 1：取出第 0 列列向量（副本）
  c[2] = newValue            // 步骤 2：修改列向量的第 2 个分量
  m[0] = c                   // 步骤 3：将修改后的列向量赋回矩阵
  ```

  **未提供 `componentAt(row, col)` 赋值版本的设计决策**：虽然 `componentAt(row, col): T` 可用于读取指定位置的分量值，但不提供其赋值版本 `mut componentAt(row, col, value: T)`。理由：① 分量级修改需要先取整列、修改单分量、赋回整列——这不增加额外开销（列向量赋值本身是 O(R) 操作，比单分量赋值仅多 R-1 次无条件赋值）；② 提供 componentAt(row, col) 赋值版本将使 API 表面膨胀，且语义上与 `[]` 赋值版本（整列赋值）有割裂感；③ C++ GLM 中 `m[i][j] = value` 依赖引用语义（`m[i]` 返回引用），仓颉值类型模型下无法复现此语法。此差异在 §9 差异声明中记录

### 3.5 算术运算符

所有算术运算符定义在带 Number<T> 约束的 extend 块中，与阶段一 Vec 类型模式一致。

**一元运算符**：
- operator func -(): Mat{C}x{R}<T,Q> — 逐元素取负

**二元运算符（矩阵-标量）**：
- +、-、*、/（右操作数为 T）：逐元素操作。**mat / scalar 以成员运算符函数形式定义在矩阵的 extend 块中**（`operator func /(rhs: T): Mat{C}x{R}<T,Q>`），与 C++ GLM 中 `operator/(mat, scalar)` 为全局自由函数的形态不同——仓颉 operator func 的 this 固定为左操作数，因此 mat / scalar 自然成为成员运算符，而 scalar / mat 则必须通过全局函数处理。两者运算语义等价，但 API 形态差异导致 mat / scalar 无法作为高阶函数参数传递（仓颉不支持取成员运算符的函数引用）。此差异在 §9 差异声明中记录

**二元运算符（标量-矩阵）**：
- +、-、*、/（左操作数为 T，右操作数为矩阵）：通过 scalar_mat_ops.cj 中的全局具名函数处理，与阶段一 scalar_vec_ops.cj 的模式一致。**scalar_mat_ops.cj 包含 36 个全局函数**，覆盖全部 9 种矩阵类型（含 6 种非方阵）：
  - `add<T,Q>(s: T, m: Mat{C}x{R}<T,Q>)`×9（Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4 各一版重载）
  - `sub<T,Q>(s: T, m: Mat{C}x{R}<T,Q>)`×9
  - `mul<T,Q>(s: T, m: Mat{C}x{R}<T,Q>)`×9
  - `div<T,Q>(s: T, m: Mat{C}x{R}<T,Q>)`×9
  - 共计 4 种运算 × 9 种矩阵 = 36 个全局函数。其中 `div(s, m)` 逐元素执行 s / each_element，不依赖 inverse，对所有 9 种矩阵类型（含全部 6 种非方阵）均可本阶段完整实现——这与 C++ GLM 参考实现一致（如 type_mat2x3.hpp:146 定义了 `operator/(T, mat<2,3>)`，type_mat2x3.inl:474-479 实现了逐元素除法）
  - 所有 36 个全局函数标注 @OverflowWrapping，与阶段一 scalar_vec_ops.cj 的做法一致
- **命名约定说明**：scalar_mat_ops.cj 与 scalar_vec_ops.cj 同属 glm.detail 包，均定义名为 add、sub、mul、div 的包级函数。两者通过参数类型（Vec 型 vs 矩阵型）在仓颉重载解析中自然区分，不会产生歧义。**scalar_mat_ops.cj 不包含 mod 函数**——矩阵取模无数学意义，GLM 也未为矩阵类型定义 % 运算符，因此此文件仅包含 add、sub、mul、div 四种运算各 9 个重载（共 36 个函数），不提供 mod 函数

**二元运算符（矩阵-矩阵）**：
- +、-：逐元素加/减（仅同尺寸）
- *：矩阵乘法（需满足内维度匹配）
  - **兼容性规则**：Mat{C1}x{R1} * Mat{C2}x{R2} 当 C1 = R2 时兼容，结果类型为 Mat{C2}x{R1}
  - **同尺寸乘法**（方阵，3 种）：Mat2x2 * Mat2x2 → Mat2x2、Mat3x3 * Mat3x3 → Mat3x3、Mat4x4 * Mat4x4 → Mat4x4
  - **跨尺寸乘法兼容性表**（26 种跨尺寸 + 3 种同尺寸 = 共 29 个有效重载，穷举验证见下表注）：
    - Mat2x2 可与 Mat3x2 → Mat3x2、Mat4x2 → Mat4x2 相乘
    - Mat2x3 可与 Mat2x2 → Mat2x3、Mat3x2 → Mat3x3、Mat4x2 → Mat4x3 相乘
    - Mat2x4 可与 Mat2x2 → Mat2x4、Mat3x2 → Mat3x4、Mat4x2 → Mat4x4 相乘
    - Mat3x2 可与 Mat2x3 → Mat2x2、Mat3x3 → Mat3x2、Mat4x3 → Mat4x2 相乘
    - Mat3x3 可与 Mat2x3 → Mat2x3、Mat3x3 → Mat3x3（同尺寸）、Mat4x3 → Mat4x3 相乘
    - Mat3x4 可与 Mat2x3 → Mat2x4、Mat3x3 → Mat3x4、Mat4x3 → Mat4x4 相乘
    - Mat4x2 可与 Mat2x4 → Mat2x2、Mat3x4 → Mat3x2、Mat4x4 → Mat4x2 相乘
    - Mat4x3 可与 Mat2x4 → Mat2x3、Mat3x4 → Mat3x3、Mat4x4 → Mat4x3 相乘
    - Mat4x4 可与 Mat2x4 → Mat2x4、Mat3x4 → Mat3x4、Mat4x4 → Mat4x4（同尺寸） 相乘

    **穷举验证**：9 种矩阵类型共 81 种配对（9×9），其中 C1=R2 的合法组合为 29 个（含同尺寸 3 个：Mat2x2*Mat2x2、Mat3x3*Mat3x3、Mat4x4*Mat4x4），跨尺寸 26 个。跨尺寸 26 项完整列举：按左操作数 Mat2x2~Mat4x4 依次展开，每个左操作数遍历所有右操作数中 C2=任意、R2=C1 的矩阵——Mat2x2(C1=2) 可乘 R2=2 的 3 个右操作数（Mat2x2已列为同尺寸、Mat3x2、Mat4x2），得跨尺寸 2 个；Mat2x3(C1=2) 可乘 R2=2 的 3 个右操作数（Mat2x2、Mat3x2、Mat4x2），得跨尺寸 3 个；Mat2x4(C1=2) 同理得 3 个；Mat3x2(C1=3) 可乘 R2=3 的 3 个右操作数，得跨尺寸 3 个；Mat3x3(C1=3) 可乘 R2=3 的 3 个右操作数，得跨尺寸 2 个（1 个同尺寸）；Mat3x4(C1=3) 得跨尺寸 3 个；Mat4x2(C1=4) 得跨尺寸 3 个；Mat4x3(C1=4) 得跨尺寸 3 个；Mat4x4(C1=4) 得跨尺寸 2 个（1 个同尺寸）。总计跨尺寸 2+3+3+3+2+3+3+3+2=26，加同尺寸 3=29
  - 矩阵乘法是数学语义组合，非逐元素运算
  - **跨尺寸乘法运算符的文件归属策略**：跨尺寸矩阵乘法运算符定义在左操作数矩阵类型的 extend 块中（即在 type_mat{C}x{R}.cj 文件中的 extend 块中定义 `operator func *(rhs: Mat{C2}x{R2})` 等重载）。由于这 9 个矩阵类型均定义在 glm.detail 同包中，同包类型互相直接可见，**无需跨文件 import**——同包内的类型引用不需要 import 语句
  - **矩阵乘法展开规则**（编码参照）：对 Mat{C1}x{R1} * Mat{C2}x{R2}（C1=R2），结果 Mat{C2}x{R1} 的第 j 列第 i 行元素为左操作数第 i 行向量与右操作数第 j 列向量的点积：
    - `result[j][i] = Σ(k=0..C1-1) lhs[k][i] * rhs[j][k]`
    - 即：结果的第 j 列 = 左操作数的各列按右操作数第 j 列的分量加权后求和
    - **示例 1：Mat2x3 * Mat3x2 → Mat3x3** — Mat2x3（2 列 3 行）× Mat3x2（3 列 2 行），C1=2=R2(2)，结果 Mat3x3（3 列 3 行）
      - `result[0][0] = lhs[0][0]*rhs[0][0] + lhs[1][0]*rhs[0][1]`
      - `result[0][1] = lhs[0][1]*rhs[0][0] + lhs[1][1]*rhs[0][1]`
      - `result[0][2] = lhs[0][2]*rhs[0][0] + lhs[1][2]*rhs[0][1]`
      - 即 `result.col(0) = lhs[0] * rhs[0][0] + lhs[1] * rhs[0][1]`（列向量线性组合）
    - **示例 2：Mat2x3 * Vec2 → Vec3** — Mat2x3（2 列 3 行）× Vec2（2 分量），C1=2
      - `result[0] = lhs[0][0]*v[0] + lhs[1][0]*v[1]`
      - `result[1] = lhs[0][1]*v[0] + lhs[1][1]*v[1]`
      - `result[2] = lhs[0][2]*v[0] + lhs[1][2]*v[1]`
      - 即 `result = lhs[0] * v[0] + lhs[1] * v[1]`（列向量线性组合）
- /（矩阵-矩阵除法）：**仅方阵类型（Mat2x2、Mat3x3、Mat4x4）** 提供此运算符。等价于 mat *= inverse(rhs)（赋值语义），因 inverse 属于 matrix.cj 函数库（本阶段为 stub），矩阵-矩阵除法推迟至阶段四。非方阵类型不提供矩阵-矩阵除法运算符（非方阵不可逆，无数学意义），与 GLM 参考实现一致
- /（矩阵-列向量除法 mat / col_vec、行向量-矩阵除法 row_vec / mat）：**仅方阵类型** 提供此运算符。依赖 inverse(m) * v 或 v * inverse(m) 实现，同样因 inverse 为 stub 而推迟至阶段四。非方阵类型不提供 mat/vec 和 vec/mat 除法运算符，与 GLM 参考实现一致

**二元运算符（矩阵-向量）**：
- *（矩阵 × 列向量）：Mat{C}x{R}<T,Q> * Vec{C}<T,Q> → Vec{R}<T,Q>
  - 例如 Mat4x4<T,Q> * Vec4<T,Q> → Vec4<T,Q>
  - 例如 Mat2x3<T,Q> * Vec2<T,Q> → Vec3<T,Q>
- *（行向量 × 矩阵）：Vec{R}<T,Q> * Mat{C}x{R}<T,Q> → Vec{C}<T,Q>
  - 例如 Vec3<T,Q> * Mat2x3<T,Q> → Vec2<T,Q>（Vec{R}=Vec3, Mat2x3 的 C=2 → Vec{C}=Vec2）
  - 例如 Vec4<T,Q> * Mat4x4<T,Q> → Vec4<T,Q>（方阵特殊性：C=R=4）
  - **定义归属**：采用**方案A（Vec 类型 extend 块成员运算符）**。即在 Vec{R} 类型的 extend 块中定义 `operator func *(rhs: Mat{C}x{R}<T,Q>): Vec{C}<T,Q>`，其中 C 遍历 2,3,4。每个 Vec{R} 需定义 3 个运算符重载。理由见 §7 D32

**复合赋值运算符**：由仓颉编译器自动生成（依据仓颉语言函数文档 §8.5："重载二元运算符（关系运算除外）时自动启用对应复合赋值版本（+=、-= 等），前提是返回类型与左操作数类型匹配或为其子类型"），标注 @OverflowWrapping 策略与阶段一 Vec 类型一致。按类别拆分说明如下：

**编码启动前验证项**：P1 审查意见要求验证此自动生成假设。虽然仓颉语言文档（function/README.md §8.5）中已明确声明复合赋值自动生效规则，仍建议在编码启动首日通过最小化测试验证：在一个测试文件中定义矩阵类型的 + 和 - 二元运算符，尝试调用 += 和 -=，确认编译器自动生成并通过编译。若验证不成立，需在本设计中显式列出全部 36 个复合赋值运算符定义（每矩阵类型 4 个：+=、-=、*=、/=，方阵额外包含 mat/mat 的 /=）。

| 复合赋值类别 | 适用矩阵类型 | 自动生成条件 | 备注 |
|-------------|-------------|-------------|------|
| ① 同尺寸矩阵 ± 的复合赋值 +=/-=(same_mat) | 所有 9 种类型 | 矩阵 ± 矩阵返回同类型，编译器自动生成 | 仅覆盖同 T 同尺寸类型，不支持跨类型矩阵复合赋值（C++ GLM 的 `operator+=(mat<C,R,U,Q>)` 中 U≠T 版本在仓颉中不可行） |
| ② 标量运算的复合赋值 +=scalar/-=scalar/*=scalar//=/scalar | 所有 9 种类型（含 6 种非方阵） | 矩阵 ±*/ 标量返回同类型，编译器自动生成 | **//=scalar 逐元素操作，不依赖 inverse，本阶段完整实现（非 stub）**。其中 /=(scalar) 对所有 9 种矩阵类型均可用（含非方阵），因 mat/scalar 为逐元素除法无需逆矩阵。方阵类型同时存在两版 /= 重载：/=(scalar) 本阶段可用，/=(mat/mat) 为 stub——编译器按右操作数类型自动选择重载（右操作数为 T 标量时走 /=(scalar)，右操作数为矩阵时走 /=(mat/mat) stub），两者不冲突 |
| ③ 方阵乘法的复合赋值 *=(same_mat) | 仅 3 种方阵 | 方阵乘法结果类型与左操作数相同，编译器自动生成 | 非方阵乘法结果类型不同，不生成 *= |
| ④ 方阵除法的复合赋值 /=(same_mat) | 仅 3 种方阵 | 基于 operator/(mat/mat) 自动生成 | **operator/=(mat/mat) 由编译器基于 operator/(mat/mat) 自动生成，因此自动继承 stub 行为**：当 operator/(mat/mat) 为 stub（内部调用 inverse 后 throw Exception）时，/= 也为 stub；无需单独声明 /= 的 stub 状态。当阶段四 inverse 完整实现后，/ 也会自动成为可用运算符 |

**复合赋值运算符与 C++ GLM 的跨类型差异**：C++ GLM 中方阵的 `operator+=(mat<C,R,U,Q>)` 和 `operator*=(mat<C,C,U,Q>)` 接受泛型参数 U（U 可与 T 不同），即允许跨类型矩阵复合赋值（如 `mat4(Float32) += mat4(Int32)`）。仓颉版本中 extend 块的运算符签名右操作数类型固定为 `Mat{C}x{R}<T, Q>`（U=T），不支持 U≠T 的跨类型矩阵复合赋值。此差异在 §9 差异声明中记录。

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
- **阶段二 stub 范围说明**：下述签名清单仅包含标量版本函数（参数和返回值均为标量类型 T）。C++ GLM 中 mix/step/smoothstep/clamp 等函数同时提供向量版本（参数为 VecN<T,Q>），本阶段 common.cj stub 不包含向量版本签名——向量版本推迟至阶段四随函数库完整实现一起提供。当前方阵 .inl 编排中仅引用标量版本（如 `mix(scalar, scalar, scalar)` 用于对角矩阵构造中的插值），因此标量版本签名已满足依赖闭合需求
- **完整函数签名清单**（仅标量版本）：
  - `func min<T>(a: T, b: T): T where T <: Number<T> & Comparable<T>`
  - `func max<T>(a: T, b: T): T where T <: Number<T> & Comparable<T>`
  - `func abs<T>(a: T): T where T <: Number<T> & Equatable<T>`（对整型返回绝对值，对浮点返回绝对值）
  - `func sign<T>(a: T): T where T <: Number<T> & Equatable<T>`（返回 -1/0/1 符号）
  - `func floor<T>(a: T): T where T <: Number<T>`（浮点下取整）
  - `func ceil<T>(a: T): T where T <: Number<T>`（浮点上取整）
  - `func fract<T>(a: T): T where T <: Number<T>`（返回小数部分）
  - `func mod<T>(a: T, b: T): T where T <: Number<T>`（浮点取模）
  - `func clamp<T>(a: T, minVal: T, maxVal: T): T where T <: Number<T> & Comparable<T>`（值夹逼）
  - `func mix<T>(a: T, b: T, t: T): T where T <: Number<T>`（线性插值）
  - `func step<T>(edge: T, x: T): T where T <: Number<T> & Comparable<T>`（阶跃函数）
  - `func smoothstep<T>(edge0: T, edge1: T, x: T): T where T <: Number<T> & Comparable<T>`（平滑阶跃）

**matrix.cj**（package glm.detail）：
- 本文件中的函数分为两类：
  - **A. 方阵 .inl 依赖闭合所需的函数**：transpose、determinant、inverse——这些是方阵类型（type_mat2x2/type_mat3x3/type_mat4x4）的运算符重载和成员函数内部直接调用的函数，必须在本阶段以 stub 形式存在以确保方阵文件编译通过
  - **B. 随 matrix.cj 附带提供的额外函数**：matrixCompMult、outerProduct——这些在 C++ GLM 中定义于 matrix.hpp/matrix.inl 中，但不被方阵 .inl 直接调用，属于独立的全局函数。它们纳入 matrix.cj 的原因是函数库文件的组织约定：C++ GLM 将所有矩阵运算辅助函数统一放置在 matrix.hpp/matrix.inl 中，仓颉版本遵循相同的文件组织映射
- **完整函数签名清单**：
  - **transpose**（9 个独立重载，每个矩阵尺寸各一版）：
    - `func transpose<T, Q>(m: Mat2x2<T, Q>): Mat2x2<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func transpose<T, Q>(m: Mat2x3<T, Q>): Mat3x2<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func transpose<T, Q>(m: Mat2x4<T, Q>): Mat4x2<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func transpose<T, Q>(m: Mat3x2<T, Q>): Mat2x3<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func transpose<T, Q>(m: Mat3x3<T, Q>): Mat3x3<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func transpose<T, Q>(m: Mat3x4<T, Q>): Mat4x3<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func transpose<T, Q>(m: Mat4x2<T, Q>): Mat2x4<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func transpose<T, Q>(m: Mat4x3<T, Q>): Mat3x4<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func transpose<T, Q>(m: Mat4x4<T, Q>): Mat4x4<T, Q> where T <: Number<T>, Q <: Qualifier`
  - **determinant**（3 个重载，仅方阵）：
    - `func determinant<T, Q>(m: Mat2x2<T, Q>): T where T <: Number<T>, Q <: Qualifier`
    - `func determinant<T, Q>(m: Mat3x3<T, Q>): T where T <: Number<T>, Q <: Qualifier`
    - `func determinant<T, Q>(m: Mat4x4<T, Q>): T where T <: Number<T>, Q <: Qualifier`
  - **inverse**（3 个重载，仅方阵）：
    - `func inverse<T, Q>(m: Mat2x2<T, Q>): Mat2x2<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func inverse<T, Q>(m: Mat3x3<T, Q>): Mat3x3<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func inverse<T, Q>(m: Mat4x4<T, Q>): Mat4x4<T, Q> where T <: Number<T>, Q <: Qualifier`
  - **matrixCompMult**（9 个独立重载，每个矩阵尺寸各一版）：
    - `func matrixCompMult<T, Q>(x: Mat2x2<T, Q>, y: Mat2x2<T, Q>): Mat2x2<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func matrixCompMult<T, Q>(x: Mat2x3<T, Q>, y: Mat2x3<T, Q>): Mat2x3<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func matrixCompMult<T, Q>(x: Mat2x4<T, Q>, y: Mat2x4<T, Q>): Mat2x4<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func matrixCompMult<T, Q>(x: Mat3x2<T, Q>, y: Mat3x2<T, Q>): Mat3x2<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func matrixCompMult<T, Q>(x: Mat3x3<T, Q>, y: Mat3x3<T, Q>): Mat3x3<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func matrixCompMult<T, Q>(x: Mat3x4<T, Q>, y: Mat3x4<T, Q>): Mat3x4<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func matrixCompMult<T, Q>(x: Mat4x2<T, Q>, y: Mat4x2<T, Q>): Mat4x2<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func matrixCompMult<T, Q>(x: Mat4x3<T, Q>, y: Mat4x3<T, Q>): Mat4x3<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func matrixCompMult<T, Q>(x: Mat4x4<T, Q>, y: Mat4x4<T, Q>): Mat4x4<T, Q> where T <: Number<T>, Q <: Qualifier`
   - **outerProduct**（9 个重载，按列向量×行向量向量维度组合）：
     - 结果矩阵 M[j][i] = c[i] * r[j]，其中 c 的分量数 = 结果矩阵行数 R，r 的分量数 = 结果矩阵列数 C
     - 第一个参数 c（column-like）意为"用于构建列"的向量，c[i] 提供第 i 行的逐行系数，分量数等于结果矩阵的行数（R）；第二个参数 r 是行向量，r[j] 提供第 j 列的逐列系数，分量数等于结果矩阵的列数（C）
     - 参数命名 c 来源于 C++ GLM 的 outerProduct(col, row) 命名——这里的 c（column-like）指的是"用于构建列"的向量，而非"列向量"——c 的每个分量在结果矩阵中沿行方向展开（c[i] 出现在同一行的不同列），r 的每个分量沿列方向展开（r[j] 出现在同一列的不同行）。若将 c 误解为"列向量"（分量数=列数），会导致结果矩阵尺寸推理错误
    - `func outerProduct<T, Q>(c: Vec2<T, Q>, r: Vec2<T, Q>): Mat2x2<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func outerProduct<T, Q>(c: Vec2<T, Q>, r: Vec3<T, Q>): Mat3x2<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func outerProduct<T, Q>(c: Vec2<T, Q>, r: Vec4<T, Q>): Mat4x2<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func outerProduct<T, Q>(c: Vec3<T, Q>, r: Vec2<T, Q>): Mat2x3<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func outerProduct<T, Q>(c: Vec3<T, Q>, r: Vec3<T, Q>): Mat3x3<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func outerProduct<T, Q>(c: Vec3<T, Q>, r: Vec4<T, Q>): Mat4x3<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func outerProduct<T, Q>(c: Vec4<T, Q>, r: Vec2<T, Q>): Mat2x4<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func outerProduct<T, Q>(c: Vec4<T, Q>, r: Vec3<T, Q>): Mat3x4<T, Q> where T <: Number<T>, Q <: Qualifier`
    - `func outerProduct<T, Q>(c: Vec4<T, Q>, r: Vec4<T, Q>): Mat4x4<T, Q> where T <: Number<T>, Q <: Qualifier`

**geometric.cj**（package glm.detail）：
- 提供 dot、cross、normalize、length、distance、reflect、refract 等几何函数的空壳签名
- 被 type_mat4x4 的 .inl 实现引用
- **阶段二 stub 范围说明**：下述签名清单仅覆盖方阵 .inl 实际引用的函数签名。Vec1 版本的 dot 未被当前方阵 .inl 直接调用（Vec1 在方阵运算中不作为列/行向量类型出现），因此 Vec1 版本 dot 推迟至阶段四随函数库完整实现一起提供。cross/normalize/length/distance/reflect/refract 同理仅覆盖 Vec2~Vec4 版本
- **完整函数签名清单**：
   - `func dot<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>): T where T <: Number<T>, Q <: Qualifier`（Vec1 版本 dot，虽当前方阵 .inl 未直接引用，但为保持签名字母序完整性一并提供）
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

**vec1/dvec1 别名的必要性说明**：虽然 GLSL 规范不定义 vec1 类型（GLSL 最小分量数为 2），但 GLM 通过 `ext/vector_float1.hpp` 和 `ext/vector_double1.hpp` 扩展了 vec1/dvec1 别名——这服务于以下场景：① 矩阵运算中有时需要标量-向量混合操作，vec1 提供了与 Vec1 一致的 camelCase 命名入口；② 从 C++ GLM 完整迁移时，源码中可能引用 vec1 类型。本设计保留与 GLM 的完整对应关系，提供这两个别名文件。Vec1 类型本身在阶段一已完整实现，ext/ 下的 vec1/dvec1 仅是别名层

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
// identity — 单位矩阵（需传入 one: T）
// 完整泛型参数：extend<T, Q> Mat4x4<T, Q> where T <: Number<T>, Q <: Qualifier
// Q 从 "Mat4x4<Float32, PackedHighp>" 的第二个类型实参推断，T 从 one 参数推断
let m = Mat4x4<Float32, PackedHighp>.identity(1.0f)

// filled — 对角矩阵（主对角线填 scalar，其余填零）
// 完整泛型参数：extend<T, Q> Mat4x4<T, Q> where T <: Number<T>, Q <: Qualifier
let m = Mat4x4<Float32, PackedHighp>.filled(1.0f)  // diag(1,1,1,1)，等同于 identity
let m = Mat2x3<Float32, PackedHighp>.filled(1.0f)  // 2×3 对角矩阵
   // 列主序展示：第 0 列 [1.0f, 0.0f, 0.0f]，第 1 列 [0.0f, 1.0f, 0.0f]
   // 主对角线长度 min(2,3)=2，第 1 列第 2 行填 1.0f

// filled(0.0f) 边界行为：scalar=T(0) 时 scalar-scalar=T(0)，产生零矩阵
let zero = Mat4x4<Float32, PackedHighp>.filled(0.0f)  // 全零矩阵，等价 C++ GLM 的 mat(0.0f)

// 逐分量构造（const init）
let m = Mat4x4<Float32, PackedHighp>(
    1.0f, 0.0f, 0.0f, 0.0f,    // 列 0
    0.0f, 1.0f, 0.0f, 0.0f,    // 列 1
    0.0f, 0.0f, 1.0f, 0.0f,    // 列 2
    0.0f, 0.0f, 0.0f, 1.0f)    // 列 3  单位矩阵等同

// 非方阵 identity 行为
let m = Mat2x3<Float32, PackedHighp>.identity(1.0f)  // 等价于 filled(1.0f)
   // 对角矩阵：主对角线填 1.0f，其余填 0.0f
```

### 4.2 矩阵乘法

```
let a = Mat4x4<Float32, PackedHighp>(...)
let b = Mat4x4<Float32, PackedHighp>(...)
let c = a * b                    // 矩阵-矩阵乘，结果 Mat4x4

let v = Vec4<Float32, PackedHighp>(1.0f, 2.0f, 3.0f, 1.0f)
let transformed = a * v          // 矩阵-向量乘，结果 Vec4

// 跨尺寸乘法展开示例：Mat2x3 * Vec2 → Vec3
// lhs 为 2 列 3 行矩阵，v 为 2 分量向量
// result = lhs[0] * v[0] + lhs[1] * v[1]  （列向量线性组合）
// result[0] = lhs[0][0]*v[0] + lhs[1][0]*v[1]
// result[1] = lhs[0][1]*v[0] + lhs[1][1]*v[1]
// result[2] = lhs[0][2]*v[0] + lhs[1][2]*v[1]
```

### 4.3 跨尺寸转换（同类型）

```
let m2 = Mat2x2<Float32, PackedHighp>(...)        // 2x2
let m4 = Mat4x4<Float32, PackedHighp>.fromMat(m2, one: 1.0f)  // 2x2 -> 4x4，扩展填 0/1
// 当 SrcT=T 时，优先使用 6a 版本（无需 conv 闭包）
```

### 4.4 跨类型跨尺寸转换

```
let m2Int = Mat2x2<Int32, PackedHighp>(...)
let m4Float = Mat4x4<Float32, PackedHighp>.fromMat({ x => Float32(x) }, m2Int, one: 1.0f)
// Int32 的 2×2 矩阵转换为 Float32 的 4×4 矩阵，conv 闭包逐元素转换
// 仅在 SrcT≠T 时使用 6b 版本（需 conv 闭包）
```

### 4.5 跨类型同尺寸转换

```
let mInt = Mat4x4<Int32, PackedHighp>(...)
let mFloat = Mat4x4<Float32, PackedHighp>.fromMat({ x => Float32(x) }, mInt)
```

### 4.6 分量级修改操作

```
var m = Mat4x4<Float32, PackedHighp>(...)
var col = m[0]              // 取出第 0 列列向量（副本）
col[2] = 5.0f                // 修改列向量的第 2 个分量
m[0] = col                   // 将修改后的列向量赋回矩阵

// 等价地使用 col() 函数：
var c = m.col(0)
c[2] = 5.0f
m[0] = c
```

### 4.7 ext/ 别名使用

```
import glm.ext.matrix_float4x4.{ mat4, mat4x4 }
import glm.ext.vector_float4.{ vec4 }

let m = mat4(1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f)
let v = vec4(1.0f, 2.0f, 3.0f, 1.0f)
let r = m * v
```

### 4.8 标量-矩阵除法（对所有 9 种矩阵类型）

```
// scalar / mat 对所有矩阵类型可用（含非方阵），逐元素计算 s / each_element
import glm.detail.div

let m = Mat2x3<Float32, PackedHighp>(...)
let result = div(2.0f, m)  // Mat2x3<Float32, PackedHighp>，每个分量为 2.0f / m[j][i]
```

### 4.9 行向量 × 矩阵运算符

```
// Vec{R} * Mat{C}x{R} 定义为 Vec 类型的成员运算符（方案A）
let v = Vec3<Float32, PackedHighp>(1.0f, 2.0f, 3.0f)
let m = Mat2x3<Float32, PackedHighp>(...)
let r = v * m  // 结果 Vec2<Float32, PackedHighp>，C=2
```

### 4.10 同尺寸同类型直接赋值

```
// 当源矩阵和目标矩阵元素类型、尺寸、Qualifier 均相同时，直接赋值是最简途径
let m_src = Mat4x4<Float32, PackedHighp>(...)
let m_dst = m_src  // 直接赋值，无需 fromMat

// 仅跨 Qualifier 时使用 fromMat
let m_aligned: Mat4x4<Float32, AlignedHighp> = Mat4x4<Float32, AlignedHighp>.fromMat(m_packed, one: 1.0f)
```

---

## 5. 错误处理策略

与阶段一保持一致：
- **下标越界**：[](i: Int64) 和 col(i: Int64) 中超出列范围的索引抛出 Exception（含 assert + fallback throw）。此机制使 `[]` 和 `col()` 不可声明为 `const func`（与阶段一 Vec 的 `componentAt` 面临同类限制，参见 deviations.md IF-03），在 §9 差异声明中记录
- **数学异常**：
  - 矩阵-矩阵除法（mat / mat）：**仅方阵类型（Mat2x2、Mat3x3、Mat4x4）** 提供此运算符，因依赖 inverse 函数（stub），本阶段运算符内部调用时抛出 stub 异常。非方阵类型不提供 mat/mat 除法运算符
  - 矩阵-标量除法（mat / scalar）：逐元素操作，不依赖 inverse，可本阶段完整实现——**对所有 9 种矩阵类型均可用（含全部 6 种非方阵）**。mat / scalar 不受 stub 影响，与 mat/mat 除法（依赖 inverse stub）形成显式区分
  - 标量-矩阵除法（scalar / mat）：逐元素 s / each_element 操作，不依赖 inverse，可本阶段完整实现——**对所有 9 种矩阵类型（含全部 6 种非方阵）均可用**，与 C++ GLM 参考实现一致（各 .hpp/.inl 文件均定义了全部 9 种矩阵类型的 T/mat 除法）。scalar / mat 不受 stub 影响
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
| D04 | 矩阵乘法运算符直接内联展开而非委托函数库 | C×R <= 4x4=16，内联展开代码量可控且避免函数调用开销；29 个有效乘法重载（26 跨尺寸 + 3 同尺寸）各自内联展开后代码量仍在可控范围；复合运算（如 a * b * v）中可合并优化 |
| D05 | 矩阵-向量乘法定义为矩阵运算符 | 与 C++ GLM 的 operator*(mat, vec) 一致，是线性代数最核心的操作 |
| D06 | 标量在矩阵左侧的运算通过全局函数处理 | 仓颉 operator func +(rhs: T) 的 this 固定为左操作数，仅能表达 Mat + T，无法表达 T + Mat。参考阶段一 scalar_vec_ops.cj 模式，创建 scalar_mat_ops.cj 提供全局具名函数（add/sub/mul/div）处理标量在矩阵左侧的运算。全部 36 个函数标注 @OverflowWrapping，与阶段一一致 |
| D07 | stub 函数提供空壳签名而非完整实现 | 阶段二的验证标准不包括函数库运算（仅矩阵创建、行列访问、基本算术），stub 保证方阵文件编译通过即可 |
| D08 | 排除 ++/-- 运算符的具名替代（increment/decrement）；仓颉复合赋值运算符不支持跨类型矩阵参数 | 仓颉不支持重载自增/自减运算符。C++ GLM 中全部 9 种矩阵类型（含 6 种非方阵）均提供 ++/-- 运算符，语义为逐元素加/减 1（非仅方阵）。仓颉版本中全部 9 种矩阵类型（含 6 种非方阵）的 ++/-- 均不可用，可通过 `m += T(1)`（逐元素加 1）等价替代——此替代对所有 9 种类型均适用（因所有类型均支持 +=scalar 复合赋值，见第②类）。注意不能使用 `+= identity`（仅对角线加 1，语义不同）。C++ GLM 的 `operator+=(mat<C,R,U,Q>)` 中 U≠T 版本在仓颉中不可行——仓颉 extend 块中运算符右操作数类型固定为 `Mat{C}x{R}<T, Q>`，不支持跨类型矩阵复合赋值 |
| D09 | 排除 % 运算符（取模） | 矩阵取模无数学意义，GLM 也未为矩阵类型定义 % 运算符 |
| D10 | 排除位运算符（&/|/^/<</>>） | 矩阵类型不支持位运算，GLM 的矩阵类型也未定义位运算符 |
| D11 | **不在矩阵结构体内部定义类型别名** | 仓颉限制类型别名只能在源文件顶层定义，不能在结构体/类/函数体内定义。各矩阵的列向量/行向量类型在使用处直接引用具体的 VecN<T,Q> 类型，与阶段一 Vec 类型风格一致 |
| D12 | `col(i: Int64)` 替代 `componentAt(i: Int64)` 作为列访问函数 | 阶段一 Vec 类型的 `componentAt(i)` 返回第 i 个标量分量。矩阵列访问返回整个列向量（VecR<T,Q>），若复用 `componentAt` 名称会造成同一 API 在不同类型间返回语义不一致。使用 `col(i)` 明确表达"按列索引访问列向量"的语义 |
| D13 | 行访问 `row()` 本阶段不提供成员函数形式 | C++ GLM 的 `glm::row()` 是自由函数，属于 `matrix.cj` 函数库（阶段四完整实现）。若本阶段定义为成员函数，阶段四替换为自由函数时产生 API 不兼容。本阶段无行访问的充分使用场景，决定推迟至阶段四随 `matrix.cj` 自由函数版本提供 |
| D14 | ext/ 向量别名文件仅限 float/double 两个精度族 | 与矩阵别名文件的范围一致（仅 float/double）。Bool/Int32/UInt32 等向量类型的别名已在 fwd.cj 中提供，不再在 ext/ 下重复创建 |
| D15 | **scalar_mat_ops.cj 与 scalar_vec_ops.cj 共同定义 add/sub/mul/div 包级函数，通过参数类型重载解析区分；scalar_mat_ops.cj 不包含 mod 函数** | 阶段一 OOD 中约定"仅 scalar_vec_ops.cj 定义 add/sub/mul/div 包级函数"。本阶段新增 scalar_mat_ops.cj 在同一包中定义同名函数，两者参数类型（Vec 型 vs 矩阵型）完全不同，仓颉重载解析可自然区分。矩阵无取模运算，因此 scalar_mat_ops.cj 不提供 mod 函数，与 scalar_vec_ops.cj 提供 mod 形成不对称——此不对称由数学语义决定（向量逐分量取模有意义而矩阵无意义）。**编码阶段验证建议**：须在编码首日验证现有 `add<T,Q>(s: T, v: Vec2<T,Q>)` 与新增 `add<T,Q>(s: T, m: Mat2x2<T,Q>)` 等重载在仓颉重载解析中无歧义——两者的第二个参数类型分别为 Vec2<T,Q> 和 Mat2x2<T,Q>，属于不同类型，编译器应选择唯一最佳匹配。建议通过最小化测试文件同时 import 两个文件并调用 add 验证编译通过。若发现歧义，需将 scalar_mat_ops.cj 的函数重命名为 matAdd/matSub/matMul/matDiv 以避免重载冲突 |
| D16 | **fwd.cj 矩阵别名命名规则** | 与阶段一向量的命名规范保持一致：`Mat{C}x{R}` 为 Float32 highp 默认精度，`DMat{C}x{R}` 为 Float64 highp；精度变体 `HighpMat{C}x{R}`、`MediumpMat{C}x{R}`、`LowpMat{C}x{R}`；方阵短别名 `mat{C}`（Float32）和 `dmat{C}`（Float64）。详见 §8 fwd.cj 命名规则。**关于 fmat/f32mat/f64mat 系列及 i8mat~u64mat 系列的纳排决策详见 D19**。**精度变体同样覆盖方阵短别名**：`Highpmat4`、`MediumpMat4`、`Lowpmat4` 等（即 `Highp` + `mat4` 形式，对应 `Mat4x4<Float32, PackedHighp>` 等）。**精度变体方阵短别名命名风格说明**：方阵短别名的精度前缀采用 camelCase 首段（如 `Highpmat4` 而非 `HighpMat4`），这与向量精度别名（如 `HighpVec4`）的 PascalCase 约定存在表面不一致。原因：方阵短别名本身是 camelCase（`mat4`），精度前缀仅在其前拼接，命名结构为 `{精度前缀}{短别名}` 而非 `{精度前缀}{类型名}`。由于向量无对应的 camelCase 短别名，两者不可直接类比——此差异属于命名惯例的历史传承（来自 GLM C++ 源码），不影响语义一致性 |
| D17 | **矩阵类型支持 @Derive[Hashable]** | 与阶段一 Vec 类型保持一致。矩阵类型包含 Vec 列向量成员，而 Vec 已通过 @Derive[Hashable] 自动派生哈希实现。仓颉中 struct 的 @Derive[Hashable] 要求所有成员可哈希，矩阵全部满足此条件。T=Bool 时已验证 Bool <: Hashable（阶段一 Vec{1..4}<Bool,Q> 的 @Derive[Hashable] 已通过编译验证），无需额外条件派生约束。此决策使矩阵类型可用于 HashSet/HashMap 等场景 |
| D18 | **type_float.cj 和 type_half.cj 延迟至后续阶段** | 路线图中列为"可选"，无阶段内文件依赖它们。这两个浮点类型标签文件仅在阶段四函数库中的某些数值边界场景需要，本阶段不纳入范围 |
| D19 | **fwd.cj 矩阵别名仅覆盖 Mat/DMat 族 + 精度变体 + 方阵短别名，不纳入 fmat/f32mat/f64mat 及 i8mat~u64mat 系列** | C++ GLM fwd.hpp 中 fmat/f32mat/f64mat 系列是 mat/DMat 的"显式前缀"冗余别名（fmat2 等效于 mat2，f32mat2 等效于 mat2，f64mat2 等效于 dmat2），在仓颉中 Defaultp = PackedHighp，这些冗余别名无额外类型差异。**排除的数值佐证**：fmat 族（fmat2~fmat4 及非方阵 fmat2x3~fmat4x4）每族 9 个精度变体（float/highp_float/mediump_float/lowp_float/f32/f64/i32/u32/i8~i64/u8~u64 的子集）——每族 9 个矩阵尺寸 × 3 种精度前缀（fmat/f32mat/f64mat），即每族 27 个别名，3 族共 81 个冗余别名。加上 i8mat~u64mat 等整型矩阵别名（10 种整型前缀 × 9 种矩阵尺寸 = 90 个），fmat/f32mat/f64mat 及整型系列合计约 171 个冗余别名。相比之下，纳入的 Mat/DMat 族 + 精度变体 + 方阵短别名仅约 60 个，排除后大幅缩减 fwd.cj 别名量。i8mat~u64mat 等整型矩阵别名因矩阵主用于浮点线性代数运算，整型矩阵为极低频边界场景，且 GLM 自身仅在 fwd.hpp 中声明但 .inl 中整型矩阵运算支持不完整，排除后进一步缩减。若后续有用户需求可通过 ext/ 文件补充 |
| D20 | **单位矩阵构造改为 `identity(one: T)` 静态工厂函数，不提供 `init()` 无参默认构造；identity 对所有 9 种矩阵类型均提供** | C++ GLM 的 `mat4()` 默认构造为单位矩阵，但仓颉无约束泛型不支持 `T(0)/T(1)` 构造调用（deviations.md DV-01 记录的同类限制：无约束时只能传递/返回泛型类型的值，不能进行其他操作）。即使添加 `Number<T>` 约束，`Number<T>` 接口也不提供 `T(n)` 构造声明。此外构造函数必须在 struct 定义中声明，不能在 extend 块中添加。单位矩阵构造只能在 `Number<T>` 约束的 extend 块中作为静态工厂函数实现。代价：`Mat4x4<Float32, PackedHighp>()` 不可用，改为 `Mat4x4<Float32, PackedHighp>.identity(1.0f)`。参数 `one` 的必要性：`Number<T>` 约束下无法演算 T(1)——`!` 运算符属于 `Integer<T>` 接口而非 `Number<T>` 接口，对 Float32/Float64 不可用。因此 T(1) 必须由调用方显式传入。T(0) 通过 `one - one` 在 `Number<T>` 上下文中演算获得。**identity 对非方阵也提供**，语义上等价于 `filled(one)` ——保持 API 统一性，编码者无需为方阵/非方阵写条件分支 |
| D21 | **删除原 §3.3 第 2 条跨 Qualifier 复制构造函数，功能由第 7 条跨类型同尺寸转换覆盖** | 原第 2 条 `init<Q2>(m: Mat4x4<T, Q2>)` 仅处理跨 Qualifier 复制（T 相同），原第 7 条 `init<U, P>(m: Mat4x4<U, P>)` 处理跨类型同尺寸转换。当第 7 条实例化为 `U=T, P≠Q` 时，与第 2 条实例化为 `Q2=P` 时的参数类型完全相同，产生重载歧义。删除第 2 条后，当 `U=T` 时第 7 条自然涵盖跨 Qualifier 复制，功能无损且消除歧义 |
| D22 | **标量填充构造降级为 extend 块中的 `filled(scalar: T)` 静态工厂函数** | `init(scalar: T)` 构造函数在 struct 体内 T 为无约束泛型，无法执行 `scalar - scalar` 获得 T(0)——矩阵的标量填充需要非对角线填 T(0)，与阶段一 Vec2.init(scalar: T) 的全分量赋同一值语义不同。将此构造降级为 `Number<T>` 约束的 extend 块中的 `filled(scalar: T)` 静态工厂函数 |
| D23 | **跨矩阵类型转换（72 个 init）降级为 extend 块中的 `fromMat` 静态工厂函数** | 72 个跨尺寸转换构造若定义为 init，必须在 struct 体内定义，而 struct 体内的 T 是无约束泛型，无法执行 T(0)/T(1) 获取。降级到 `Number<T>` 约束的 extend 块后，T(0) 通过 `someValue - someValue` 演算，T(1) 通过参数 `one` 传入。此决策与 D22（标量填充降级）和 D20（identity 降级）形成统一的解决策略——所有需要 T(0)/T(1) 的构造统一改为 extend 块中的工厂函数 |
| D24 | **跨类型逐分量构造和跨类型列向量构造降级为带 conv 闭包的具名工厂函数** | 仓颉泛型上下文中隐式类型转换不可用。在 struct 体内（无约束泛型 T、U）无法将 U 自动转为 T；在 extend 块中虽有约束但仍无隐式 U→T 路径。统一采用阶段一 `castVecN(v, conv)` 模式，要求调用方显式提供 conv 闭包。降级为 `fromParts(conv, ...)` 和 `fromColumns(conv, ...)` 静态工厂函数 |
| D25 | **跨类型同尺寸转换构造降级为带 conv 闭包的 `fromMat(m, conv)` 工厂函数** | 与 D24 同理——跨类型转换不可隐式进行。原设计 `init<U, P>(m: Mat4x4<U, P>)` 在 struct 体内无法将 Vec4<U,P> 赋值给 Vec4<T,Q>。降级为 `fromMat(m, conv: (U) -> T)` 工厂函数，与阶段一 castVecN 模式一致 |
| D26 | **`identity()` 不可为 const func，`filled()` 不可为 const init** | identity 涉及 `one - one` 运算获得 T(0)，filled 涉及 `scalar - scalar` 运算获得 T(0)，两者均涉及 const 表达式规则不允许的泛型约束运算 |
| D27 | **跨矩阵类型转换拆分为同类型（6a）和跨类型（6b）两个独立工厂函数** | 当 SrcT ≠ T 时，fromMat 中 `dst[j][i] = src[j][i]` 赋值不可行（类型不匹配），必须通过 conv 闭包逐元素转换。将同类型跨尺寸转换（fromMat(m, one: T)，无需 conv）和跨类型跨尺寸转换（fromMat(conv, m, one: T)，需 conv）拆分为两个独立签名，消除类型不匹配的编译阻断问题。同类型版本保留 SrcQ 参数以允许跨 Qualifier 转换 |
| D28 | **fromColumns 使用单一 V1 类型参数，不提供多列独立类型参数** | C++ GLM 允许 4 列使用不同类型参数（如 `mat4(vec4_a, vec4_b, ivec4_c, ivec4_d)`），但仓颉泛型工厂函数中每个类型参数须在签名中声明。声明 4 个独立列分量类型参数将使签名膨胀且类型推断困难。使用单一 V1 参数使所有列向量共享同一分量类型，此为与 C++ GLM 的容量差异，§9 差异声明中记录 |
| D29 | **fromParts 使用单一 U 类型参数** | 与 fromColumns 同理——所有标量参数共享同一类型 U 和同一 conv 闭包。C++ GLM 中构造函数每个参数独立隐式转换的能力不可用。此为与 C++ GLM 的容量差异，§9 差异声明中记录 |
| D30 | **mat / scalar 为成员运算符函数，与 C++ GLM 全局自由函数形态不同** | 仓颉 operator func 的 this 固定为左操作数，`operator func /(rhs: T)` 天然将 mat 表达为左操作数（`this`），成为成员运算符。C++ GLM 中 `operator/(mat, scalar)` 为全局自由函数。两者运算语义等价，但 API 形态差异导致 mat / scalar 无法作为高阶函数参数传递（仓颉不支持取成员运算符的函数引用）。此差异在 §9 差异声明中记录 |
| D31 | **identity(one: T) 对非方阵类型也提供，语义等价于 filled(one)** | C++ GLM 中方阵的默认构造 `mat4()` 产生单位矩阵，非方阵的默认构造 `mat2x3()` 也产生主对角线填 1、其余填 0 的对角矩阵（行为一致但不称为"单位矩阵"）。仓颉版本保留 identity 对所有 9 种矩阵类型可用，使编码者无需区分方阵/非方阵条件分支。非方阵上 `identity(one)` 与 `filled(one)` 结果完全相同。此决策与 C++ GLM 行为一致，但在命名语义上 C++ GLM 不对非方阵使用"单位矩阵"称呼。此命名差异在 §9 差异声明中记录 |
| D32 | **行向量×矩阵运算符 `Vec{R} * Mat{C}x{R}` 采用方案A：定义在 Vec 类型 extend 块中作为成员运算符** | 仓颉 `operator func` 的 this 固定为左操作数，因此 `Vec{R} * Mat{C}x{R}` 中 Vec 在左侧，自然定义为 Vec 类型的成员运算符。每个 Vec{R} 需在 extend 块中定义 3 个重载（C=2,3,4），与 Mat * Vec 归为矩阵成员运算符对称（左侧类型拥有运算符）。此方案无需新增文件——Vec 类型文件（type_vec1~4.cj）本阶段已有修改标记。与方案B（包级自由函数）相比，成员运算符使调用语法最自然（`v * m` 直接可用）；与方案C（降级为具名函数）相比，保持与 C++ GLM 一致的运算符 API。Vec 与 Mat 同属 glm.detail 包，同包类型直接可见，无需额外 import 声明 |

---

## 8. 阶段二产出物清单

### 9 个矩阵类型实现文件（src/detail/）
- type_mat2x2.cj ~ type_mat4x4.cj（9 文件）

### 4 个辅助文件（src/detail/）
- common.cj（stub，完整函数清单见 §3.7；仅含标量版本函数签名，向量版本推迟至阶段四）
- matrix.cj（stub，完整函数清单见 §3.7；含方阵 .inl 依赖闭合函数和附带额外函数两类）
- geometric.cj（stub，完整函数清单见 §3.7；含 Vec1 版本 dot 签名）
- scalar_mat_ops.cj（标量-矩阵运算全局函数，36 个重载 [add/sub/mul/div × 9 矩阵类型]，均标注 @OverflowWrapping；不含 mod 函数；矩阵乘法运算符总数为 29 [26 跨尺寸 + 3 同尺寸]）

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
    - f32mat 系列（f32mat2~fmat4、f32mat2x2~f32mat4x4）：排除，理由见 D19
    - f64mat 系列（f64mat2~f64mat4、f64mat2x2~f64mat4x4）：排除，理由见 D19
    - imat 系列（imat2x2~imat4x4 及 i8mat~i64mat 全系列）：排除，理由见 D19
    - umat 系列（umat2x2~umat4x4 及 u8mat~u64mat 全系列）：排除，理由见 D19

- src/lib.cj：新增 9 个矩阵类型的 public import；确认 scalar_mat_ops.cj 中的全局函数无需额外 import 语句（因为 lib.cj 已有 `public import glm.detail.{ add, sub, mul, div, mod }`，此语句自动覆盖 scalar_mat_ops.cj 中同名的 add/sub/mul/div 函数——两者同属 glm.detail 包，同名函数通过参数类型重载自然覆盖，无需额外 import）。**注意：mod 仅覆盖 scalar_vec_ops.cj 提供的标量-向量取模函数，scalar_mat_ops.cj 不提供 mod（矩阵取模无数学意义）**；新增 ext/ 向量别名文件的 public import；**关于 lib.cj 导出歧义评估**：当下游消费者同时 `import glm.*` 和 `import glm.detail.*` 时，add/sub/mul/div 函数的解析不产生歧义——两者导出的是同一个包（glm.detail）中的同一组重载函数，无论从哪条 import 路径引入，最终引用的目标函数完全相同
- cjpm.toml：确认 src-dir 配置覆盖 src/ext/ 目录

### 关于路线图中可选文件的处理
- `type_float.cj` 和 `type_half.cj`：**延迟至后续阶段**。这两个文件作为浮点类型标签（仅依赖 setup.cj），在阶段二无任何文件依赖它们，阶段四函数库实现时方有可能需要。不纳入本阶段产出物。

### 编码启动前验证项
- **cjpm 子包构建预验证**：须在编码首日验证 src/ext/ + package glm.ext 子包可被 cjpm 正确发现和构建。详见 §2 cjpm 子包构建预验证

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
| **无 ++/-- 运算符** | 仓颉不支持重载自增/自减运算符。C++ GLM 中全部 9 种矩阵类型（含 6 种非方阵）均提供 ++/-- 运算符，语义为逐元素加/减 1。仓颉版本中全部 9 种矩阵类型（含 6 种非方阵）均不可用 ++/--。可通过 `m += T(1)`（逐元素加 1）等价替代 C++ GLM 的 `++m` 语义——此替代对所有 9 种类型均适用 |
| **ext/ 别名文件为 package glm.ext 而非 C++ 的 namespace glm** | 仓颉包名与目录路径匹配规则约束 |
| **矩阵-矩阵除法推迟且仅限方阵** | 矩阵-标量除法（mat / scalar）和标量-矩阵除法（scalar / mat）属逐元素操作，不依赖 inverse，本阶段可完整实现——**对全部 9 种矩阵类型（含 6 种非方阵）均可用**，与 C++ GLM 参考实现一致。仅矩阵-矩阵除法（mat / mat）依赖 inverse（阶段四完整实现），本阶段运算符内部调用 stub 函数。mat/mat、mat/col_vec、row_vec/mat 除法运算符**仅方阵类型（Mat2x2、Mat3x3、Mat4x4）** 提供，非方阵类型不提供这些除法运算符 |
| **标量左侧矩阵运算为全局函数而非运算符** | 仓颉 operator func 的 this 固定为左操作数，T + Mat 无法以运算符表达。改用 scalar_mat_ops.cj 中的全局具名函数（add/sub/mul/div）替代，调用方使用 add(s, m) 而非 s + m。所有函数标注 @OverflowWrapping。scalar_mat_ops.cj 不含 mod 函数（矩阵取模无数学意义） |
| **mat / scalar 为成员运算符函数，C++ GLM 为全局自由函数** | 仓颉 operator func 的 this 固定为左操作数，`operator func /(rhs: T)` 天然将 mat 表达为 this（左操作数）。C++ GLM 中 `operator/(mat, scalar)` 为全局自由函数。两者运算语义等价，但 API 形态差异导致 mat / scalar 无法作为高阶函数参数传递（仓颉不支持取成员运算符的函数引用） |
| **无类型别名体系** | 仓颉类型别名只能定义在文件顶层，不能在结构体内部定义。各矩阵的列向量/行向量类型在使用处直接引用具体的 VecN<T,Q> 类型，不定义 col_type/row_type 等内部类型别名 |
| **无 `row()` 成员函数** | 行访问 `glm::row()` 在 C++ GLM 中为自由函数，阶段二不提供成员函数形式以免 API 不兼容，推迟至阶段四随 matrix.cj 自由函数版本提供 |
| **`col()` 代替 `componentAt()` 为列访问函数** | 为避免与 Vec 的 `componentAt`（返回标量）语义冲突，矩阵列访问统一命名为 `col(i)` |
| **`[]` 运算符取值版本返回列向量副本，不支持分量级链式修改；不提供 componentAt(row, col) 赋值版本** | C++ GLM 中 m[i] 返回引用，可直接修改 m[0].x = value；仓颉版本中 m[0] 返回列向量的副本（值语义），仅可整列赋值 m[0] = new_col。分量级修改需三步操作（取列→修改分量→赋回）。不提供 `componentAt(row, col)` 赋值版本——此 API 将使表面膨胀且与 `[]` 整列赋值语义割裂；三步操作不增加额外开销（列向量赋值本身是 O(R) 操作）。C++ GLM 依赖引用语义实现 `m[i][j] = value`，仓颉值类型模型下无法复现此语法 |
| **fwd.cj 不包含 fmat/f32mat/f64mat 及整型矩阵别名** | C++ GLM fwd.hpp 中 fmat/f32mat/f64mat 是 mat/DMat 的冗余前缀别名，整型矩阵（imat/u8mat 等）为极低频场景。仓颉版本排除这些冗余别名以避免别名爆炸，详见 D19 |
| **非方阵不提供 *=（mat）复合赋值运算符** | 仓颉编译器仅在二元运算符返回类型与左操作数类型匹配时自动生成复合赋值。方阵乘法结果类型与左操作数相同，自动获得 *=；非方阵乘法结果类型不同（如 Mat2x3 * Mat3x2 → Mat3x3），编译器不生成 *= |
| **仓颉复合赋值运算符不支持跨类型矩阵参数** | C++ GLM 的 `operator+=(mat<C,R,U,Q>)` 和 `operator*=(mat<C,C,U,Q>)` 接受泛型参数 U（U可与 T 不同），仓颉 extend 块中运算符右操作数类型固定为 `Mat{C}x{R}<T, Q>`（U=T），不支持 U≠T 的跨类型矩阵复合赋值。若用户需跨类型矩阵复合赋值，须先显式转换再赋值 |
| **方阵 operator/=(mat/mat) 由编译器基于 operator/(mat/mat) 自动生成，自动继承 stub 行为** | 仓颉编译器自动生成的 /= 复合赋值运算符内部调用 operator/(mat/mat)。当 operator/(mat/mat) 为 stub（内部调用 inverse 后 throw Exception）时，/= 也为 stub，无需单独声明 /= 的 stub 状态。当阶段四 inverse 完整实现后，/= 也会自动成为可用运算符。**注意**：方阵同时存在 /=scalar（可用，逐元素操作，本阶段完整实现）和 /=(mat/mat)（stub）两版重载，编译器按右操作数类型自动选择——标量右侧走 /=scalar 可用路径，矩阵右侧走 /=(mat/mat) stub 路径 |
| **无 `init()` 默认构造函数，单位矩阵通过 `identity(one: T)` 工厂函数构造** | C++ GLM 中 `mat4()` 默认构造为单位矩阵。仓颉无约束泛型不支持 `T(0)/T(1)` 构造调用。单位矩阵构造推迟到 `Number<T>` 约束的 extend 块，以 `identity(one: T)` 工厂函数提供。调用方式从 `Mat4x4<Float32, PackedHighp>()` 变为 `Mat4x4<Float32, PackedHighp>.identity(1.0f)`——需额外传入 `one` 参数 |
| **identity(one: T) 对非方阵类型的语义与 C++ GLM 命名不同** | C++ GLM 中方阵默认构造产生"单位矩阵"，非方阵默认构造产生对角矩阵但不算"单位矩阵"。仓颉版本中 identity 对所有 9 种矩阵类型均可用——非方阵上 `identity(one)` 等价于 `filled(one)`，产生主对角线填 1 其余填 0 的对角矩阵。此行为与 C++ GLM 非方阵默认构造的实际结果一致，但命名语义上将非方阵的对角矩阵也称为 "identity" 与 C++ GLM 习惯不同 |
| **标量填充构造为 `filled(scalar: T)` 工厂函数而非 `init(scalar: T)` 构造函数** | C++ GLM 中 `mat4(1.0f)` 构造对角矩阵。仓颉矩阵的 `init(scalar: T)` 在 struct 体内无法获得 T(0)（非对角线填充需要），故降级为 extend 块中的 `filled(scalar: T)` 工厂函数。调用方式：`Mat4x4<Float32, PackedHighp>.filled(1.0f)`。Vec2.init(scalar: T) 与此不构成类比——Vec2 的标量填充是全分量赋同一值，不涉及 T(0) |
| **跨矩阵类型转换拆分为同类型 fromMat(m, one) 和跨类型 fromMat(conv, m, one)** | C++ GLM 的 `mat4(mat2)` 等转换构造函数在仓颉不可行——struct 体内的无约束泛型 T 无法获得 T(0)/T(1)。降级为 extend 块中的工厂函数。同类型版本 `fromMat<SrcQ>(m, one: T)` 处理 SrcT=T 的跨尺寸/跨 Qualifier 转换；跨类型版本 `fromMat<SrcT, SrcQ>(conv, m, one: T)` 处理 SrcT≠T 的跨类型转换，conv 闭包逐元素转换。**当 SrcT=T 时应优先使用 6a 版本（无需 conv）**。调用方式：`Mat4x4<Float32, PackedHighp>.fromMat(m2x2, one: 1.0f)` 或 `Mat4x4<Float32, PackedHighp>.fromMat({ x => Float32(x) }, m2x2_int, one: 1.0f)` |
| **跨类型逐分量构造为 `fromParts(conv, ...)` 工厂函数而非构造函数，仅支持单一源类型 U** | C++ GLM 的跨类型构造函数依赖隐式类型转换，仓颉泛型上下文中不可用。降级为带 conv 闭包的 `fromParts` 工厂函数，与阶段一 castVecN 模式一致。fromParts 的所有标量参数共享同一类型 U——C++ GLM 允许每个参数独立隐式转换，仓颉版本不支持此能力。调用方式：`Mat4x4<Float32, PackedHighp>.fromParts({ x => Float32(x) }, ...)` |
| **跨类型列向量构造为 `fromColumns(conv, ...)` 工厂函数而非构造函数，仅支持单一分量类型 V1** | 与 fromParts 同理——跨类型转换要求 conv 闭包。fromColumns 的所有列向量共享同一分量类型 V1——C++ GLM 允许每列使用不同类型（如 `mat4(vec4_a, vec4_b, ivec4_c, ivec4_d)`），仓颉版本不支持此能力。调用方式：`Mat4x4<Float32, PackedHighp>.fromColumns({ x => Float32(x) }, v1, v2, v3, v4)` |
| **跨类型同尺寸转换为 `fromMat(conv, m)` 工厂函数而非构造函数** | 与 fromParts 同理——跨类型转换要求 conv 闭包。调用方式：`Mat4x4<Float32, PackedHighp>.fromMat({ x => Float32(x) }, mInt)` |
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
| P1（严重）：init() 默认单位矩阵构造在无约束泛型 T 下依赖 T(0)/T(1) 不可行 | 已采纳。删除 init() 默认构造，新增 identity() 静态工厂函数 + D20 |
| P2（一般）：第 2 条与第 9 条构造函数重载歧义 | 已采纳。删除原第 2 条 + D21 |
| P3（轻微）：type_mat4x3.cj 条目标注错误 | 已采纳。修正为 Mat4x3<T,Q> |
| P4（一般）：ext/ 向量别名与 fwd.cj 别名定位差异 | 已采纳。补充定位差异说明 |
| P5（一般）：跨矩阵转换填充规则与 GLM 不一致 | 已采纳。补充编码阶段注意事项 |
| P6（轻微）：[] 和 col() 的 const func 限制未记录 | 已采纳。补充 §9 差异声明 |

---

## 修订说明（v9）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题 1（严重）**：`identity()` 中 T(1) 演算公式 `let one = -(!(zero))` 依赖 `!` 运算符，但 `!` 属于 `Integer<T>` 而非 `Number<T>`，对 Float32/Float64 不可用 | **已采纳**。① 将 `identity()` 签名改为 `identity(one: T): Mat{C}x{R}<T,Q>`，要求调用方显式传入 T(1) 参数；② T(0) 改用 `one - one` 在 `Number<T>` 约束上下文中演算；③ 更新 D20 决策 |
| **问题 2（一般）**：`init(scalar: T)` 标量填充构造中 T(0) 获取方式不可行 | **已采纳**。① 将标量填充构造从 `init(scalar: T)` 降级为 extend 块中的 `filled(scalar: T)` 静态工厂函数；② 在 `Number<T>` 约束的 extend 块中通过 `scalar - scalar` 获得 T(0)；③ 新增 D22 |
| **问题 3（一般）**：72 个跨矩阵类型转换构造函数需 T(0)/T(1) 但 struct 体内无约束泛型无法获得 | **已采纳**。① 将 72 个跨尺寸转换构造统一降级为 `Number<T>` 约束 extend 块中的 `fromMat(m, one: T)` 静态工厂函数；② 新增 D23 |
| **问题 4（严重）**：`fromMat` 签名在 `SrcT ≠ T` 时缺少 `conv: (SrcT) -> T` 闭包参数 | **已采纳**。拆分为 6a 同类型和 6b 跨类型两个独立工厂函数。新增 D27 |
| **问题 5（一般）**：fromColumns 签名仅使用单一 V1 类型参数 | **已采纳**。① 补充单一 V1 类型限制说明；② 新增 D28；③ §9 差异声明新增条目 |
| **问题 6（轻微）**：精度变体命名是否覆盖方阵短别名未明确 | **已采纳**。补充精度变体覆盖方阵短别名 |
| **问题 7（轻微）**：精度变体方阵短别名命名风格不一致 | **已采纳**。在 D16 中补充命名风格说明 |
| **问题 8（轻微）**：extend 块中 identity/filled 的 Q 类型参数来源未分析 | **已采纳**。补充完整泛型参数展开示例 |
| **问题 9（轻微）**：scalar_mat_ops.cj 不包含 mod 函数未明确说明 | **已采纳**。补充说明 |
| **问题 10（一般）**：分量级修改三步操作未在行为契约中示例 | **已采纳**。① 新增 §4.6；② 补充 componentAt(row,col) 赋值版本设计决策 |
| **问题 11（一般）**：三个 stub 文件的函数签名清单使用"等"字省略 | **已采纳**。提供完整函数签名清单 |
| **问题 12（轻微）**：vec1/dvec1 必要性未说明 | **已采纳**。补充必要性说明 |
| **问题 13（一般）**：cjpm 子包发现机制未验证 | **已采纳**。① 新增 cjpm 子包构建预验证段落；② 新增编码启动前验证项 |
| **问题 14（一般）**：`fromMat` 中 SrcQ 声明但未使用 | **已采纳**。补充 SrcQ 作用和影响说明 |

---

## 修订说明（v10）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题 1（严重）**：scalar / mat 运算符对非方阵类型的遗漏与事实错误 | **已采纳**。① 在 §3.5 明确列出 scalar_mat_ops.cj 的 36 个函数涵盖范围：add/sub/mul/div 各为全部 9 种矩阵类型（含 6 种非方阵）提供重载；② 在 §5 补充确认 scalar / mat 对所有 9 种矩阵类型（含非方阵）均可本阶段完整实现，与 C++ GLM 参考实现一致（如 type_mat2x3.hpp:146 定义了 `operator/(T, mat<2,3>)`）；③ 修正 §3.5 标量-矩阵段落，列出全部 9 种矩阵类型名称 |
| **问题 2（一般）**：+=mat/-=mat 复合赋值运算符的自动生成条件描述不精确 | **已采纳**。① §3.5 复合赋值运算符按类别拆分为 4 类表格；② 每类标注适用矩阵范围；③ 第①类明确说明仅覆盖同 T 同尺寸类型，不覆盖跨类型矩阵复合赋值；④ §9 差异声明补充"仓颉复合赋值运算符不支持跨类型矩阵参数"条目；⑤ 更新 D08 补充此差异说明 |
| **问题 3（一般）**：geometric.cj stub 函数签名中 Q <| Qualifier 输入错误 | **已采纳**。修正为 `Q <: Qualifier`（twice checked: Vec3 distance 签名已修正） |
| **问题 4（一般）**：matrix.cj stub 中 transpose 函数签名使用了伪签名 | **已采纳**。将 transpose 伪签名替换为 9 个具体重载签名的完整列举，与 determinant/intern 签名风格一致 |
| **问题 5（一般）**：mat / scalar 作为成员运算符定义但与 C++ GLM 全局自由函数形态不同 | **已采纳**。① §3.5 二元运算符（矩阵-标量）段落补充说明 mat / scalar 为成员运算符函数的形态及与 C++ GLM 的差异；② §9 差异声明补充"mat / scalar 为成员运算符函数"条目；③ 新增 D30 记录此设计决策 |
| **问题 6（一般）**：方阵 operator/=(mat/mat) 的 stub 策略与 operator/(mat/mat) 不一致 | **已采纳**。① §3.5 复合赋值运算符表第④类明确说明：operator/=(mat/mat) 由编译器基于 operator/(mat/mat) 自动生成，因此自动继承 stub 行为，无需单独声明 /= 的 stub 状态；② §9 差异声明补充"方阵 operator/=(mat/mat) 自动继承 stub 行为"条目 |
| **问题 7（轻微）**：filled(scalar=T(0)) 边界行为未确认 | **已采纳**。① §3.3 第 3 条末尾补充边界行为确认：即使 scalar=T(0)，scalar-scalar 仍正确产生 T(0)，filled(0.0f) 产生零矩阵，与 C++ GLM 的 mat(0.0f) 一致；② §4.1 行为契约补充 filled(0.0f) 示例 |
| **问题 8（轻微）**：vec1/dvec1 别名定义未显式列出 | **已采纳**。§3.8 向量别名文件列表中 vec1/dvec1 已以完整别名定义行格式列出（`public type vec1 = Vec1<Float32, PackedHighp>` 等），与 mat4x4 的示例格式保持一致 |
| **问题 9（一般）**：identity(one: T) 在非方阵类型上的语义未明确 | **已采纳**。① §3.3 第 8 条补充非方阵语义说明：identity 对所有 9 种矩阵类型均提供，非方阵上等价于 filled(one)，为有意设计；② 新增 D31 记录此决策；③ §9 差异声明补充"identity 对非方阵的命名语义与 C++ GLM 不同"条目 |
| **问题 10（轻微）**：matrixCompMult/outerProduct 与方阵 .inl 依赖闭合的关系区分不清 | **已采纳**。§3.7 matrix.cj 条目重写为两部分分类：A. 方阵 .inl 依赖闭合所需的函数（transpose/determinant/inverse）；B. 随 matrix.cj 附带提供的额外函数（matrixCompMult/outerProduct），后者纳入因同一函数库文件的组织约定而非 .inl 编排依赖 |
| **问题 11（轻微）**：跨矩阵类型转换工厂函数 6a/6b 调用指导缺失 | **已采纳**。§3.3 第 6a 条末尾补充调用指导：当 SrcT=T 时应优先使用 6a 版本（无需 conv），仅在 SrcT≠T 时使用 6b 版本 |
| **问题 12（轻微）**：复合赋值运算符文档措辞未区分方阵和非方阵的不同自动生成行为 | **已采纳**。§3.5 复合赋值运算符改为分类表格，按 4 类分别说明适用矩阵范围和自动生成条件 |
| **问题 13（一般）**：矩阵乘法具体展开规则未提供 | **已采纳**。§3.5 矩阵乘法部分新增"矩阵乘法展开规则"段落，提供通用公式 `result[j][i] = Σ(k=0..C1-1) lhs[k][i] * rhs[j][k]`，并附 2 个具体展开示例（Mat2x3*Mat3x2→Mat3x3 和 Mat2x3*Vec2→Vec3） |
| **问题 14（轻微）**：lib.cj 中 mod 函数覆盖范围说明不清 | **已采纳**。§8 lib.cj 条目补充说明：mod 仅覆盖 scalar_vec_ops.cj 提供的标量-向量取模函数，scalar_mat_ops.cj 不提供 mod（矩阵取模无数学意义） |
| **质询确认项 1**：72 个 fromMat 重载的编译可行性未评估 | **已采纳**。§3.3 第 6 条末尾补充编译可行性评估：每个目标矩阵 extend 块包含 16 个静态函数签名，仓颉对单个 extend 块静态函数数量无上限限制，泛型按需实例化不导致编译膨胀；建议可拆分为多个 extend 块提升可读性 |
| **质询确认项 2**：cjpm 子包 glm.ext 的构建可行性验证未跟进确认 | 已有预验证段落和编码首日验证步骤，无需额外修改 |

---

## 修订说明（v11）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题 1（严重）**：跨尺寸乘法兼容性表遗漏 Mat3x3*Mat2x3→Mat2x3 和 Mat4x3*Mat2x4→Mat2x3 两个合法组合 | **已采纳**。① §3.5 跨尺寸乘法兼容性表中 Mat3x3 条目补充 Mat2x3 右操作数（Mat3x3*Mat2x3→Mat2x3），同步标注同尺寸 Mat3x3*Mat3x3→Mat3x3；② Mat4x4 条目同步标注同尺寸；③ 将跨尺寸计数从 24 修正为 26（加同尺寸 3 = 总计 29），并补充穷举验证段落（按左操作数 C1 遍历 R2=C1 的右操作数，逐项列举跨尺寸数：2+3+3+3+2+3+3+3+2=26）；④ D04 补充乘法重载总数 29；⑤ §8 产出物清单补充乘法运算符总数 |
| **问题 2（一般）**：/=(scalar) 对非方阵的适用性未明确，方阵两版 /= 重载未说明 | **已采纳**。① §3.5 复合赋值运算符表第②类明确 //=(scalar) 对所有 9 种矩阵类型均可用（含非方阵）；② 补充方阵同时存在 /=(scalar)（可用）和 /=(mat/mat)（stub）两版重载的说明，编译器按右操作数类型自动选择重载 |
| **问题 3（轻微）**：/=(scalar) 与 /=(mat/mat) 的 stub 区分模糊 | **已采纳**。① §3.5 第②类备注中明确"//=scalar 逐元素操作，不依赖 inverse，本阶段完整实现（非 stub）"；② §5 错误处理策略中补充"mat/scalar 不受 stub 影响"的显式说明；③ §9 差异声明中 /= 自动继承 stub 条目补充 /=scalar 与 /=(mat/mat) 两版重载的区分说明 |
| **问题 4（一般）**：fromMat 6a/6b 中 one: T 参数在目标尺寸全面缩减时冗余未分析 | **已采纳**。① §3.3 第 6a 条补充 `one: T` 参数在 C_dst ≤ C_src 且 R_dst ≤ R_src 时的冗余性分析；② 评估了额外提供 fromMatTruncate 无 one 参数重载的方案，结论为不采纳（72→144 签名膨胀，成本与收益不匹配）；③ 保留统一签名并在文档中标注此冗余的简化路径 |
| **问题 5（一般）**：第 7 条与第 6a 条功能重叠未显式区分 | **已采纳**。① §3.3 第 7 条后补充功能重叠说明：当 U=T 且尺寸相同时，第 7 条与第 6a 条功能完全重叠；② 明确推荐规则——同类型同尺寸时优先使用第 6a 条（更简洁，无需 conv 闭包），第 7 条仅用于 U≠T 的跨类型场景 |
| **问题 6（一般）**：outerProduct 参数名 c 的语义歧义 | **已采纳**。① §3.7 outerProduct 段落补充参数语义说明：第一个参数 c 分量数=结果矩阵行数 R，第二个参数 r 分量数=结果矩阵列数 C；② 补充结果公式 M[j][i]=c[i]*r[j]；③ 补充 c 来自 GLM outerProduct(col, row) 命名中 col-like 指"用于构建列"而非"列向量"的解释，避免分量数=列数的误解 |
| **问题 7（轻微）**：++/-- 运算符差异声明未显式说明覆盖全部 9 种类型（含非方阵） | **已采纳**。① §9 差异声明中 ++/-- 条目更新为"全部 9 种矩阵类型（含 6 种非方阵）均提供 ++/-- 运算符，仓颉中全部 9 种均不可用"；② D08 决策理由补充"全部 9 种矩阵类型（含 6 种非方阵）均提供 ++/--"的显式说明 |
| **问题 8（一般）**：common.cj stub 仅支持标量版本，但 C++ GLM 同时提供向量版本 | **已采纳**。① §3.7 common.cj 条目补充阶段二 stub 范围说明：仅包含标量版本函数签名，向量版本推迟至阶段四；② 补充当前方阵 .inl 仅引用标量版本的依赖闭合分析 |
| **问题 9（轻微）**：geometric.cj stub 缺少 Vec1 版本 dot | **已采纳**。① §3.7 geometric.cj 签名清单补充 Vec1 版本 dot 签名（为保持签名字母序完整性一并提供）；② 补充阶段二 stub 范围说明：当前方阵 .inl 未直接引用 Vec1 dot，但一并提供以保持完整性；③ §8 产出物清单更新 geometric.cj 说明 |
| **问题 10（轻微）**：D19 排除 fmat/f32mat/f64mat 系列的数量佐证不足 | **已采纳**。① D19 补充具体数值：每族 9 个矩阵尺寸 × 3 种精度前缀 = 27 个别名/族，3 族共 81 个；加上 i8mat~u64mat 等 10 种整型前缀 × 9 种矩阵尺寸 = 90 个；合计约 171 个冗余别名，与纳入的约 60 个形成显著缩减对比 |

---

## 修订说明（v14）

| 审查意见 | 修改措施 |
|---------|---------|
| **P1（严重）**：fromMat 6a/6b 中 SrcQ 缺少 `<: Qualifier` 约束 | **已采纳**。① §3.3 6a 签名增加 `where SrcQ <: Qualifier`；② 6b 签名增加 `where SrcQ <: Qualifier`；③ 完整泛型参数展开示例同步更新 |
| **P2（严重）**：行向量×矩阵运算符 `Vec{R} * Mat{C}x{R}` 的定义归属未指定 | **已采纳**。选择**方案A（Vec 类型 extend 块成员运算符）**。① §3.5 二元运算符（矩阵-向量）中补充定义归属说明；② 模块划分中新增 type_vecN.cj（修改）标记；③ 新增 D32 设计决策记录理由 |
| **P3（严重）**：fromColumns 中 Q2 缺少 `<: Qualifier` 约束 | **已采纳**。§3.3 第 5 条 fromColumns 签名增加 `where Q2 <: Qualifier` 约束，并补充说明 |
| **P4（中等）**：fromParts 包含未使用的类型参数 Q2 | **已采纳**。§3.3 第 4 条 fromParts 签名删除 `Q2` 类型参数，仅保留 `U`。补充 Q2 删除的理由说明 |
| **P5（中等）**：`@Derive[Hashable]` 对 T=Bool 的可行性未评估 | **已采纳**。① §3.1 矩阵结构体职责中补充 T=Bool 可行性验证段落，说明 Bool <: Hashable（证据：Vec{1..4}<Bool,Q> 的 @Derive[Hashable] 已在阶段一通过编译验证）；② D17 补充 Bool 可行性验证结论；③ 结论：无需额外条件派生约束 |
| **P6（轻微）**：6a/6b "均可匹配"描述与实际情况不符 | **已采纳**。§3.3 第 6a 条末尾重写调用指导，删除"均可匹配"的不准确表述，改为：6a 有 2 个位置参数，6b 有 3 个位置参数，参数数量和第一个参数类型均不同，不存在匹配歧义 |
| **P7（轻微）**：fromMat 6a/6b 的同尺寸同类型场景未尽完备分析 | **已采纳**。① §3.3 第 7 条功能重叠说明中补充：同尺寸同类型且同 Qualifier 时推荐直接赋值（`let m_dst = m_src`），而非 fromMat；② §3.3 第 6a 条补充 `one` 在尺寸全面缩减时的冗余性分析；③ 新增 §4.10 行为契约展示直接赋值简化路径 |
| **P8（轻微）**：D19 中整型矩阵前缀数量统计不准确 | **已采纳**。D19 中"12 种整型前缀"修正为"10 种整型前缀"，对应计数从 108 修正为 90，合计从 189 修正为 171 |

---

## 修订说明（v15）

| 审查意见 | 修改措施 |
|---------|---------|
| **P1（严重）**：复合赋值运算符自动生成假设未经验证 | **已采纳**。① §3.5 复合赋值运算符段落补充仓颉语言文档（function/README.md §8.5）中关于复合赋值自动生成的原文引用；② 新增编码启动前验证项：建议通过最小化测试验证即可。若验证不成立，则须在设计中显式列出全部复合赋值运算符 |
| **P2（一般）**：fromMat 第7条与第6条参数顺序不一致 | **已采纳**。§3.3 第7条签名统一为 `fromMat<U, P>(conv: (U) -> T, m: Mat4x4<U, P>)` (conv 在前，源矩阵在后)，与第6b条 `fromMat(conv, m, one)` 的参数顺序一致；第7条的功能重叠说明同步更新 |
| **P3（一般）**：fromParts 和 fromColumns 被 Number\<T\> 约束不必要地限制 | **已采纳**。§3.3 第4条 fromParts 和第5条 fromColumns 各补充"定义位置"子项，说明它们应定义在仅带 Qualifier 约束的 extend 块中，而非 Number\<T\> 约束的 extend 块 |
| **P4（一般）**：非方阵 identity(one) 与 filled(one) 的设计冗余待明确 | **已采纳**。§3.3 第8条 identity 中补充"非方阵 identity 实现策略"子项：非方阵 identity(one) 应内部委托 filled(one)，避免 6 种非方阵类型产生 12 个逻辑完全相同的函数；方阵保持独立实现 |
| **P5（轻微）**：fromMat 6a 完整泛型展开示例遗漏 SrcQ 约束 | **已采纳**。§3.3 第6a条完整泛型参数展开示例补充 `where SrcQ <: Qualifier` |
| **P6（轻微）**：scalar_mat_ops.cj 的设计决策未与阶段一 OOD 的约定对齐 | **已采纳**。D15 设计决策补充编码阶段验证建议：通过最小化测试验证 `add<T,Q>(s: T, v: Vec2<T,Q>)` 与 `add<T,Q>(s: T, m: Mat2x2<T,Q>)` 的重载无歧义。若发现歧义，则须将 scalar_mat_ops.cj 函数重命名为 matAdd/matSub/matMul/matDiv |
| **P7（轻微）**：从Mat2x3实际填充行为与GLM参考实现可能存在局部差异的注意事项不够具体 | **已采纳**。§3.3 第6条"编码阶段注意事项"后新增"已知偏离示例（Mat4x4 ← Mat4x2）"子项，具体描述主规则与 GLM .inl 实际实现之间的偏差细节，并列举受影响的跨尺寸转换场景清单 |

---

## 修订说明（v16）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题1（中等）**：§4.5 行为契约示例与 §3.3 第7条签名矛盾——`fromMat` 签名定义 `conv` 为第一个位置参数，但示例以 `mInt` 为第一位置实参、`conv` 为命名参数 | **已采纳**。§4.5 调用示例修正为 `fromMat({ x => Float32(x) }, mInt)`（conv 在前，mInt 在后），与 §3.3 第7条签名 `fromMat<U, P>(conv: (U) -> T, m: Mat4x4<U, P>)` 一致；经全文检查无其他第7条调用示例存在同类问题 |
| **问题2（低）**：fromMat 填充规则对非方阵边缘情形描述不完整——当 `R_dst > R_src` 且 `i ≥ C_dst` 时，(i,i) 对角位置在目标矩阵中不存在 | **已采纳**。§3.3 第6a/6b条填充规则修改为：当 `R_dst > R_src` 时，对于每个额外行 i ≥ R_src，若 i < C_dst 则 (i,i) 填 `one`、其余填 T(0)；若 i ≥ C_dst 则整行填 T(0)。对称地处理额外列情形 |
| **问题3（低）**：`length(): Int64` 的 const 属性未明确，未纳入 const 可用性汇总表 | **已采纳**。§3.1 将 `length()` 标注为 `const func length(): Int64`；§3.3 末尾 const 可用性汇总表新增 `const func length()` 行，标注为 ✅ const func 可用 |
| **问题4（低）**：fromMat 重载数量表述存在歧义——"72 个 fromMat 重载"与后续"144 个函数签名"对应关系不清晰 | **已采纳**。§3.3 "跨矩阵类型转换工厂函数的数量推导"段落引导句改为"**144 个 fromMat 重载（72 个转换对 × 2 变体）的编译可行性评估**"，明确 72 = 转换方向数（9×8），144 = 总函数签名数（72×2 变体） |
