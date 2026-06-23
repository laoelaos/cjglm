# GLM 1.0.3 仓颉迁移阶段二 OOD 设计方案（v9）

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

每个矩阵类型提供以下构造函数（以 Mat4x4<T,Q> 为例，其他矩阵按列数/行数适配）：

1. **标量填充构造**（init(scalar: T)）
   - 主对角线填 scalar，其余填零值，产生对角矩阵
   - 主对角线长度为 min(C, R)：对于方阵（如 Mat4x4），主对角线长度为 4；对于非方阵，主对角线长度为 min(C,R)，即沿 (0,0), (1,1), ... 对角线填 scalar 直到行或列先耗尽
   - 例如 `Mat2x3(1.0f)` 产生 2×3 对角矩阵：`[[1,0,0],[0,1,0]]`（主对角线长度 min(2,3)=2，第 3 列全为 0）
   - **约束**：此构造函数需要 T 支持零值构造。在 Number<T> 约束的 extend 块中实现，利用 `Number<T>` 提供的运算能力演算出零值（例如 `scalar - scalar` 得到 T(0)）。在无约束泛型 struct 定义中不可行——编码时须确保此构造函数仅在带约束的 extend 块中可用，或提供零值参数（参见 DV-01 同类限制）

2. **逐分量构造**（init(x0, y0, z0, w0, x1, y1, z1, w1, ..., x3, y3, z3, w3)）
   - 按列主序接收全部标量分量：先第一列 R 个值，再第二列 R 个值，依此类推
   - 矩阵 Mat{C}x{R} 有 C×R 个标量参数
   - 优先采用 const init 形式

3. **列向量构造**（init(c0: VecR<T,Q>, c1: VecR<T,Q>, ...)）
   - 直接以 C 个列向量构建矩阵

4. **跨类型逐分量构造**（泛型，各分量可为不同类型）
   - 接收与逐分量构造相同数量的参数，但各参数可为不同类型，内部执行隐式类型转换

5. **跨类型列向量构造**（init(v1: VecR<V1, Q>, v2: VecR<V2, Q>, ...)）
   - 各列向量可为不同类型 V1, V2, ...，内部转为 VecR<T,Q>

6. **跨矩阵类型转换构造**（explicit，从其他尺寸的矩阵构造）
   - 每种目标矩阵类型需要为除自身外的其他 8 种矩阵尺寸各定义一个显式构造函数，共计 9 个目标类型 × 8 个源类型 = 72 个独立构造函数重载
   - **精确填充规则**：源矩阵第 j 列第 i 行的元素 M_src[j][i] 复制到目标矩阵的相同坐标位置（即 dst[j][i] = src[j][i]），其中 0 ≤ j < min(C_src, C_dst)、0 ≤ i < min(R_src, R_dst)。当 C_dst > C_src 时，额外列（j ≥ C_src）从单位矩阵取值——即 (j,j) 填 T(1)，其余填 T(0)；当 R_dst > R_src 时，额外行（i ≥ R_src）从单位矩阵取值——即 (i,i) 填 T(1)，其余填 T(0)
   - 例如 Mat2x2 → Mat4x4：src[j][i] 填入 dst[j][i]（0 ≤ j < 2, 0 ≤ i < 2），dst[2][2]=T(1), dst[3][3]=T(1)，其余扩展位置填 T(0)
   - **约束**：此转换构造函数要求 T 支持 T(0)/T(1) 构造。对于不支持的数值类型（某些自定义数值类型）在实例化时报编译错误，与阶段一 Vec 构造函数面临的设计约束（参见 docs/deviations.md DV-01）一致
   - **编码阶段注意事项**：上述填充规则作为主规则描述，但 GLM 的实际实现中某些转换构造函数的行为与主规则存在局部差异——特别是当 C_src > C_dst 且 R_src < R_dst 时，部分 .inl 文件的逐列构造行为可能偏离主规则（例如 Mat4x4 ← Mat4x2 场景中，GLM 丢弃源矩阵第 2、3 列数据并替换为单位矩阵列，而主规则会复制源矩阵第 2、3 列的部分数据后再补齐）。**编码阶段须逐一对照 GLM .inl 源码实现各转换构造函数**，而非机械套用主规则。若 GLM 参考源码不可直接访问，将此作为编码阶段的风险项记录

7. **跨类型同尺寸转换构造**（init<U, P>(m: Mat4x4<U, P>)）
   - 从相同矩阵尺寸但不同元素类型和/或不同 Qualifier 的实例转换
   - 当 U=T 时自然涵盖跨 Qualifier 复制（即原第 2 条功能被本条完全覆盖）

8. **单位矩阵工厂函数**（public static func identity(): Mat{C}x{R}<T,Q>）
   - 返回主对角线为 T(1)、其余为 T(0) 的单位矩阵
   - 定义在带 `Number<T>` 约束的 extend 块中，利用 `Number<T>` 提供的运算能力演算出 T(0) 和 T(1)
   - **为何不以 init() 形式提供**：仓颉无约束泛型参数不支持 `T(0)/T(1)` 构造调用（参见泛型约束 §7.1："无约束时只能传递/返回泛型类型的值，不能进行其他操作"）。即使添加 `Number<T>` 约束，`Number<T>` 接口也不提供 `T(n)` 构造声明（与 DV-01 的 `fromBoolVec` 面临的同一根因限制一致）。因此 init() 无参构造函数无法在泛型 struct 定义或任何 extend 块中实现。将单位矩阵构造推迟到 `Number<T>` 约束的 extend 块中作为静态工厂函数 `identity()`，在此约束上下文中可通过运算演算获得 T(0) 和 T(1)：
     - T(0) 的演算：`let zero = this.c0[0] - this.c0[0]`（利用已有矩阵实例的分量自身相减）——但静态函数无 `this`，需以参数形式传入 hint 或在 init 后的实例上运算。实际编码方式为：构造一个全零矩阵（列向量构造 + 标量运算），再设置对角线元素
     - T(1) 的演算：与阶段一 `Integer<T>` 约束下 `increment()` 使用 `-(!(this.x - this.x))` 的演算模式一致。在 `Number<T>` 约束下，可用 `let one = -(!(zero))` 演算出 T(1)，其中 `zero = scalar - scalar`（任意已有 T 值自身相减），`!zero` 为 T(-1)（按位取反），`-(-1)` 为 T(1)。此演算的具体编码技巧需在编码阶段验证 `Number<T>` 约束下运算符的可用性
   - **调用方式变更**：C++ GLM 的 `mat4()` 无参默认构造改为 `Mat4x4<Float32, PackedHighp>.identity()`。此为用户可见的 API 差异，在 §9 差异声明中记录

**关于 72 个跨矩阵类型转换构造函数的可行性评估**：
- 72 个重载在仓颉重载解析规则下可编译：每个重载的参数类型是不同的矩阵结构体类型（Mat2x2、Mat2x3 等），类型分集度足够高，不会产生歧义。与阶段一 64 个向量跨类型构造函数（4 种目标 Vec 类型 × 4 种源 Vec 类型 × 多个精度族）的可行性前提一致
- 若编码阶段发现编译器重载解析存在歧义（如某些参数类型交集过近），可将歧义分支降级为具名工厂函数（如 fromMat2x3、fromMat4x2 等），与阶段一 castVec1~castVec4 模式的策略一致
- 缩减方案：若实现负担过大，可移除低频分支（如 Mat4x1 等仅用于内部转置用途的路径），通过 cast-like 具名函数补充

### 3.4 行列访问

- **下标运算符** [](i: Int64): VecR<T,Q> 和 [](i: Int64, value!: VecR<T,Q>): Unit：
  按列索引访问/修改第 i 列列向量
  - 取值版本返回 VecR<T,Q>（列向量的副本，值语义）
  - 赋值版本接收 value!: VecR<T,Q>（mut 函数修改对应列成员）
  - 下标越界时抛出 Exception（与 §5 错误处理策略一致）

- **具名列访问函数** col(i: Int64): VecR<T,Q>：
  `col(i)` 是 `[](i)` 的具名等价形式，行为完全相同：按列索引访问列向量，越界时抛出 Exception。两者并存的设计意图：
  - `[](i)` 提供最简洁的向量级列访问语法
  - `col(i)` 作为显式具名函数，在需要强调"按列访问"语义的上下文中提升代码可读性
  - 与 C++ GLM 中 `.col()` 访问模式的 API 习惯对齐
  - **命名选择说明**：本版本将之前的 `componentAt` 更名为 `col`，以避免与阶段一 Vec 类型的 `componentAt` 返回标量分量的语义冲突。Vec 的 `componentAt(i)` 返回第 i 个标量分量，而矩阵列访问返回整个列向量——统一命名为 `col(i)` 清晰表达"按列索引访问列向量"的语义

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
  - **跨尺寸乘法运算符的文件归属策略**：跨尺寸矩阵乘法运算符定义在左操作数矩阵类型的 extend 块中（即在 type_mat{C}x{R}.cj 文件中的 extend 块中定义 `operator func *(rhs: Mat{C2}x{R2})` 等重载），在对应 type_mat{C}x{R}.cj 文件顶部 import 所需右操作数矩阵类型。此设计选择与"在左操作数上定义运算符"的模式一致，编码时右操作数类型通过 import 引入即可
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
let m = Mat4x4<Float32, PackedHighp>.identity()   // 单位矩阵（工厂函数）
let m = Mat4x4<Float32, PackedHighp>(1.0f)         // 对角矩阵 diag(1,1,1,1)
let m = Mat2x3<Float32, PackedHighp>(1.0f)         // 2×3 对角矩阵: [[1,0,0],[0,1,0]]
let m = Mat4x4<Float32, PackedHighp>(
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
let m4 = Mat4x4<Float32, PackedHighp>(m2)          // 2x2 -> 4x4，扩展填 0/1
```

### 4.4 跨类型同尺寸转换

```
let mInt = Mat4x4<Int32, PackedHighp>(...)
let mFloat = Mat4x4<Float32, PackedHighp>(mInt)    // 4x4 Int32 -> 4x4 Float32
```

### 4.5 ext/ 别名使用

```
import glm.ext.matrix_float4x4.{ mat4, mat4x4 }
import glm.ext.vector_float4.{ vec4 }

let m = mat4(1.0f)
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
| D16 | **fwd.cj 矩阵别名命名规则** | 与阶段一向量的命名规范保持一致：`Mat{C}x{R}` 为 Float32 highp 默认精度，`DMat{C}x{R}` 为 Float64 highp；精度变体 `HighpMat{C}x{R}`、`MediumpMat{C}x{R}`、`LowpMat{C}x{R}`；方阵短别名 `mat{C}`（Float32）和 `dmat{C}`（Float64）。详见 §8 fwd.cj 命名规则。**关于 fmat/f32mat/f64mat 系列及 i8mat~u64mat 系列的纳排决策详见 D19** |
| D17 | **矩阵类型支持 @Derive[Hashable]** | 与阶段一 Vec 类型保持一致。矩阵类型包含 Vec 列向量成员，而 Vec 已通过 @Derive[Hashable] 自动派生哈希实现。仓颉中 struct 的 @Derive[Hashable] 要求所有成员可哈希，矩阵全部满足此条件。此决策使矩阵类型可用于 HashSet/HashMap 等场景 |
| D18 | **type_float.cj 和 type_half.cj 延迟至后续阶段** | 路线图中列为"可选"，无阶段内文件依赖它们。这两个浮点类型标签文件仅在阶段四函数库中的某些数值边界场景需要，本阶段不纳入范围 |
| D19 | **fwd.cj 矩阵别名仅覆盖 Mat/DMat 族 + 精度变体 + 方阵短别名，不纳入 fmat/f32mat/f64mat 及 i8mat~u64mat 系列** | C++ GLM fwd.hpp 中 fmat/f32mat/f64mat 系列是 mat/DMat 的"显式前缀"冗余别名（fmat2 等效于 mat2，f32mat2 等效于 mat2，f64mat2 等效于 dmat2），在仓颉中 Defaultp = PackedHighp，这些冗余别名无额外类型差异，为避免 fwd.cj 别名爆炸而排除。i8mat~u64mat 等整型矩阵别名（imat/u8mat 等）因矩阵主用于浮点线性代数运算，整型矩阵为极低频边界场景，且 GLM 自身仅在 fwd.hpp 中声明但 .inl 中整型矩阵运算支持不完整，排除后大幅缩减别名量。若后续有用户需求可通过 ext/ 文件补充 |
| D20 | **单位矩阵构造改为 `identity()` 静态工厂函数，不提供 `init()` 无参默认构造** | C++ GLM 的 `mat4()` 默认构造为单位矩阵，但仓颉无约束泛型不支持 `T(0)/T(1)` 构造调用（deviations.md DV-01 记录的同类限制：无约束时只能传递/返回泛型类型的值，不能进行其他操作）。即使添加 `Number<T>` 约束，`Number<T>` 接口也不提供 `T(n)` 构造声明。因此 `init()` 在泛型 struct 定义或任何 extend 块中均不可行（构造函数必须在 struct 定义中声明，不能在 extend 块中添加）。将单位矩阵构造推迟到 `Number<T>` 约束的 extend 块中作为 `public static func identity(): Mat{C}x{R}<T,Q>` 工厂函数，在此约束上下文中利用数学恒等式演算 T(0) 和 T(1)。代价：`Mat4x4<Float32, PackedHighp>()` 不可用，改为 `Mat4x4<Float32, PackedHighp>.identity()`。此设计决策与阶段一 Vec 类型回避此问题的策略一致——Vec 类型无 `init()` 默认构造函数，仅有 `init(scalar: T)` |
| D21 | **删除原 §3.3 第 2 条跨 Qualifier 复制构造函数，功能由第 7 条跨类型同尺寸转换构造函数覆盖** | 原第 2 条 `init<Q2>(m: Mat4x4<T, Q2>)` 仅处理跨 Qualifier 复制（T 相同），原第 7 条（现为第 7 条，原第 9 条）`init<U, P>(m: Mat4x4<U, P>)` 处理跨类型同尺寸转换。当第 7 条实例化为 `U=T, P≠Q` 时，参数类型为 `Mat4x4<T, P>`，与第 2 条实例化为 `Q2=P` 时的参数类型 `Mat4x4<T, P>` 完全相同，产生重载歧义。删除第 2 条后，当 `U=T` 时第 7 条自然涵盖跨 Qualifier 复制，功能无损且消除歧义 |

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
  - **非方阵默认精度别名**：`mat2x3`、`mat2x4`、`mat3x2`、`mat3x4`、`mat4x2`、`mat4x3`（Float32 族）和 `dmat2x3`、`dmat2x4`、`dmat3x2`、`dmat3x4`、`dmat4x2`、`dmat4x3`（Float64 族）
  - **引用方式**：`public type Mat4x4 = detail.Mat4x4<Float32, detail.PackedHighp>`，与阶段一 `public type Vec4 = detail.Vec4<Float32, detail.PackedHighp>` 模式一致
  - **关于 Defaultp 与 PackedHighp**：fwd.cj 中矩阵默认精度别名使用 PackedHighp 而非 Defaultp 作为 Qualifier 参数，原因：① qualifier.cj 中 `public type Defaultp = PackedHighp` 为类型别名，仓颉类型别名在泛型参数位置是否透明传递取决于编译器实现，使用 PackedHighp 可避免潜在的别名解析问题；② 阶段一 fwd.cj 全部向量别名均使用 PackedHighp，矩阵别名保持一致；③ Defaultp 与 PackedHighp 在语义上完全等效（Alias 后同一类型），运行时无差异
  - **关于不纳入的别名族**（排除决策）：
    - fmat 系列（fmat2~fmat4、fmat2x2~fmat4x4）：排除，理由见 D19
    - f32mat 系列（f32mat2~f32mat4、f32mat2x2~f32mat4x4）：排除，理由见 D19
    - f64mat 系列（f64mat2~f64mat4、f64mat2x2~f64mat4x4）：排除，理由见 D19
    - imat 系列（imat2x2~imat4x4 及 i8mat~i64mat 全系列）：排除，理由见 D19
    - umat 系列（umat2x2~umat4x4 及 u8mat~u64mat 全系列）：排除，理由见 D19

- src/lib.cj：新增 9 个矩阵类型的 public import；确认 scalar_mat_ops.cj 中的全局函数无需额外 import 语句（因为 lib.cj 已有 `public import glm.detail.{ add, sub, mul, div, mod }`，此语句自动覆盖 scalar_mat_ops.cj 中同名的 add/sub/mul/div 函数——两者同属 glm.detail 包，同名函数通过参数类型重载自然覆盖，无需额外 import）；新增 ext/ 向量别名文件的 public import；确认 mod 函数的矩阵版本不存在（矩阵取模无数学意义），lib.cj 的 mod 导出仅涉及向量版，不受影响
- cjpm.toml：确认 src-dir 配置覆盖 src/ext/ 目录

### 关于路线图中可选文件的处理
- `type_float.cj` 和 `type_half.cj`：**延迟至后续阶段**。这两个文件作为浮点类型标签（仅依赖 setup.cj），在阶段二无任何文件依赖它们，阶段四函数库实现时方有可能需要。不纳入本阶段产出物。

### 测试文件
- 矩阵类型测试：type_mat2x2_test.cj ~ type_mat4x4_test.cj
- 矩阵别名测试
- 向量别名测试（验证 ext/vector_float2.cj 等可正确引用 Vec2 等类型）
- 标量-矩阵运算测试：scalar_mat_ops_test.cj

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
| **无 `init()` 默认构造函数，单位矩阵通过 `identity()` 工厂函数构造** | C++ GLM 中 `mat4()` 默认构造为单位矩阵。仓颉无约束泛型不支持 `T(0)/T(1)` 构造调用（与 deviations.md DV-01 的 `fromBoolVec` 需额外提供 zero/one 参数为同一根因限制），也无法在 struct 定义或 extend 块中声明 `init()` 无参构造函数并在其中使用 `T(0)/T(1)`。单位矩阵构造推迟到 `Number<T>` 约束的 extend 块，以 `public static func identity(): Mat{C}x{R}<T,Q>` 工厂函数提供。调用方式从 `Mat4x4<Float32, PackedHighp>()` 变为 `Mat4x4<Float32, PackedHighp>.identity()`。此偏差与阶段一 Vec 类型无 `init()` 默认构造函数的策略一致（Vec1 的起始构造函数为 `init(scalar: T)`） |
| **`[]` 和 `col()` 不可在 `const` 上下文使用** | 与阶段一 Vec 的 `componentAt` 面临同类限制（deviations.md IF-03）：`[]` 和 `col()` 内部包含 `assert` + fallback `throw`，两者均非 `const` 函数，导致 `[]` 和 `col()` 不可声明为 `const func`。C++ GLM 中 `m[i]` 在 constexpr 上下文可用，仓颉版本受限于 assert/throw 机制无法在 const 上下文中使用矩阵下标访问 |

---

## 修订说明（v2）

| 审查意见 | 修改措施 |
|---------|---------|
| 问题 1：ext/ 别名文件的包名称与目录结构不匹配——设计将 ext/ 文件包声明写为 package glm，但文件位于 src/ext/ 子目录，仓颉要求包名与目录路径匹配 | 已采纳。将 ext/ 目录下所有别名文件的包声明改为 package glm.ext，各文件通过 import glm.detail.{ Mat2x2, ... } 访问 detail 核心类型。选择 Option 1（声明为 glm.ext 子包）的理由详见第 2 节"ext/ 别名文件的包名策略"段落 |
| 审查指出 D-08 中"标量在矩阵左侧的运算符通过非成员运算符函数实现"在仓颉中不可行——operator func 只能在 class/interface/struct/enum/extend 中定义 | 已采纳。将 D06 决策理由更新为：在矩阵的 extend 块中定义接收左侧标量参数的运算符 |

---

## 修订说明（v3）

| 审查意见 | 修改措施 |
|---------|---------|
| 问题 1：标量左侧矩阵运算描述不准确——设计第 3.5 节和 D06 称通过矩阵 extend 块中接收 T 参数的运算符处理 T + Mat，但仓颉 operator func +(rhs: T) 的 this 固定为左操作数，仅能表达 Mat + T，无法处理 T + Mat。阶段一实际通过 scalar_vec_ops.cj 中的全局具名函数实现标量左侧运算 | 已采纳。修正第 3.5 节：将"通过矩阵的 extend 块中接收 T 参数的运算符处理"改为"通过 scalar_mat_ops.cj 中的全局具名函数处理"，与阶段一 scalar_vec_ops.cj 模式一致。新增 scalar_mat_ops.cj 文件至第 2 节模块清单和依赖图。修正 D06 理由：阐明仓颉 operator func 无法表达标量左侧运算的原因，参考 scalar_vec_ops.cj 采用全局函数方案。更新第 8 节产出物清单和第 9 节差异声明 |

---

## 修订说明（v4）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题 1（严重）**：类型别名无法定义在结构体内部——设计第 3.2 节要求每个矩阵结构体内部定义 public type col_type、public type row_type 等类型别名。仓颉语言规定类型别名只能在源文件顶层定义，不能在结构体/类/函数体等嵌套作用域内定义。阶段一 Vec 类型的实现也全部未在结构体内部定义类型别名。此问题影响全部 9 个矩阵类型的设计可行性 | 已采纳。采用审查推荐的 **Option B**：完全移除全部类型别名，在使用处直接引用具体的 VecN<T,Q> 类型。具体修改：① 重写第 3.2 节为"类型映射关系（取代类型别名体系）"，说明设计约束并给出引用规则；② 第 1 节核心抽象表中移除 col_type/row_type 条目；③ 第 3.1 节矩阵结构体职责中移除"提供类型别名"；④ 第 3.3~3.5 节中将所有 col_type/row_type 替换为直接的具体 Vec 类型引用；⑤ 第 2 节矩阵类型概览表中保留列向量/行向量类型信息作为文档标注；⑥ 第 9 节对齐差异声明中增加"无类型别名体系"条目；⑦ 新增 D11 记录此决策 |
| **轻微**：若将类型别名移至文件顶层（Option A），泛型别名不能使用 where 约束 | 已采纳 Option B（完全移除别名），此问题不适用——无论 Option A 有何额外限制，Option B 从根源上消除了所有别名相关问题 |

---

## 修订说明（v5）

| 审查意见 | 修改措施 |
|---------|---------|
| **P1（严重）**：行向量×矩阵乘法签名错误——签名写为 `Vec{C} * Mat{C}x{R} → Vec{R}`，与 GLM 参考实现不符。正确签名应为 `Vec{R} * Mat{C}x{R} → Vec{C}` | 已采纳。修正 §3.5 中行向量×矩阵乘法签名为 `Vec{R}<T,Q> * Mat{C}x{R}<T,Q> → Vec{C}<T,Q>`。更新 §2 矩阵类型概览表后新增关键行为验证示例，含 Vec3 * Mat2x3 → Vec2 核验 |
| **P2（中等）**：跨尺寸矩阵乘法运算符未完整定义——仅列举 `Mat2x3 * Mat2x2` 一个跨类型示例，未给出完整的跨尺寸组合清单 | 已采纳。在 §3.5 中补充完整的跨尺寸乘法兼容性规则和列表，按 `Mat{C1}x{R1} * Mat{C2}x{R2} → Mat{C2}x{R1}`（当 C1=R2）规则列出全部 24 种跨尺寸组合 + 3 种同尺寸 = 共 27 个有效重载 |
| **P3（中等）**：跨矩阵类型转换填充规则不精确——"额外值填默认值（如 0 或 1）"过于模糊 | 已采纳。在 §3.3 第 8 条中补充精确填充规则描述：源矩阵元素复制到目标矩阵对应位置，未覆盖的行列从单位矩阵对应行/列取值（`(i,i)` 填 `T(1)`，其余填 `T(0)`），并附 Mat2x2→Mat4x4 具体示例 |
| **P4（中等）**：ext/ 别名文件数量描述前后矛盾——§3.8 称"精度不重复的若干组合"，与 §2 清单列出的 18 个文件矛盾 | 已采纳。统一描述为"共 18 个文件（9 种尺寸 × 2 种精度）"，删除"精度不重复的若干组合"的模糊措辞 |
| **P5（中等）**：矩阵除法 `/` 的 stub 依赖表述不准确——① `mat / scalar` 不依赖 inverse，不应与 `mat / mat` 一并推迟；② `this * inverse(rhs)` 应为赋值语义 `mat *= inverse(rhs)` | 已采纳。明确区分 `mat / scalar`（本阶段完整实现）和 `mat / mat`（依赖 inverse，推迟至阶段四），并将描述改为 `mat *= inverse(rhs)`。同步更新 §9 差异声明 |
| **P6（轻微）**：标量-矩阵除法的 stub 策略未说明——§5 仅笼统称"矩阵除法因依赖 inverse 为 stub"，未区分 `mat / mat` 和 `mat / scalar` | 已采纳。在 §5 中明确注明仅 `mat / mat` 受 stub 影响，`mat / scalar` 可本阶段完整实现 |

---

## 修订说明（v6）

| 审查意见 | 修改措施 |
|---------|---------|
| **Q01（严重）**：ext/ 向量别名文件未纳入设计范围——路线图将 ext/ 下的向量/矩阵别名文件一并列为阶段二范围，当前设计只规划了 18 个矩阵别名文件 | 已采纳。在 §2 包组织清单中新增 8 个向量别名文件（vector_float1~4.cj + vector_double1~4.cj），在 §3.8 中补充向量别名文件的具体定义和文件范围说明（仅 float/double 精度族，与矩阵别名范围一致），更新 §8 产出物清单和模块依赖图。新增 D14 记录此决策。详见 §3.8「文件范围说明」段落 |
| **Q02（严重）**：D08 等效替代数学错误——`+= identity` ≠ `++m`，矩阵 `++m` 是逐元素加 1，`+= identity` 仅对角线加 1 | 已采纳。修正 D08 决策理由：将"可通过 += identity 等价替代"改为"可通过 `m += T(1)`（逐元素加 1）等价替代"，并补充说明 `+= identity` 仅对角线加 1、语义不同的警告。同步更新 §9 差异声明中 ++/-- 条目 |
| **Q03（严重）**：跨矩阵类型转换构造——72 个独立重载未分析可行性 | 已采纳。在 §3.3 第 8 条中新增「关于 72 个跨矩阵类型转换构造函数的可行性评估」段落：① 论证仓颉重载解析可区分（各重载参数类型为不同矩阵结构体，类型分集度高）；② 提出歧义降级方案（具名工厂函数，与阶段一 castVec 模式一致）；③ 提出缩减方案（移除低频分支，通过 cast-like 函数补充） |
| **Q04（中等）**：`componentAt` 返回类型与 Vec 模式不一致——Vec 的 `componentAt` 返回标量，矩阵的 `componentAt` 返回列向量 | 已采纳。将矩阵列访问函数更名为 `col(i: Int64): VecR<T,Q>`，在 §3.4 中补充命名选择说明，阐明与 Vec 的 `componentAt` 语义区分。新增 D12 记录此决策。更新 §9 差异声明 |
| **Q05（中等）**：`row()` 成员函数在本阶段无实际作用且与 C++ GLM 不一致 | 已采纳。决定本阶段不提供 `row()` 成员函数。§3.4 中行访问段落改写为：行访问是自由函数 `glm::row()`（属于 matrix.cj，阶段四完整实现），本阶段不提供成员函数形式，避免阶段二成员函数与阶段四自由函数之间的 API 不兼容。新增 D13 记录此决策。更新 §9 差异声明 |
| **Q06（中等）**：跨类型构造函数（不同 T）未明确覆盖跨类型同尺寸矩阵转换 | 已采纳。在 §3.3 中新增第 9 条构造函数：`init<U, P>(m: Mat4x4<U, P>)` 跨类型同尺寸转换构造，附使用示例。在 §4 中新增 4.4「跨类型同尺寸转换」行为契约节 |
| **Q07（中等）**：标量-矩阵运算全局函数的溢出策略未说明 | 已采纳。在 §5 错误处理策略中补充：scalar_mat_ops.cj 中全部 36 个全局函数均标注 @OverflowWrapping，与阶段一 scalar_vec_ops.cj 的做法一致。在 §3.5 标量-矩阵运算描述中也明确标注溢出策略 |
| **Q08（中等）**：矩阵除法 `/` 的 mat/vec 运算未讨论 | 已采纳。在 §3.5 二元运算符（矩阵-矩阵）除法子节中补充：mat/col_vec 和 row_vec/mat 除法依赖 `inverse(m) * v` 或 `v * inverse(m)` 实现，因 inverse 为 stub 而推迟至阶段四。同步更新 §5 错误处理策略 |
| **Q09（轻微）**：跨矩阵转换填充规则对非数值类型适用性未讨论 | 已采纳。在 §3.3 第 8 条末尾补充约束标注：跨矩阵转换构造函数要求 T 支持 `T(0)`/`T(1)` 构造，对于不支持的类型的实例化时报编译错误，与阶段一 Vec 构造函数面临的同一类限制（见 docs/deviations.md DV-01）一致 |

---

## 修订说明（v7）

| 审查意见 | 修改措施 |
|---------|---------|
| **P1（一般）**：§2 关键行为验证示例中 Mat2x3*Mat3x2 注解 `C1=R2=3` 为事实错误，Mat2x3 列数 C1=2，Mat3x2 行数 R2=2，正确值应为 `C1=R2=2` | 已采纳。将 §2 关键行为验证示例第二行中 `C1=R2=3` 修正为 `C1=R2=2` |
| **P2（一般）**：§3.3 默认单位矩阵构造的 const init 条件性未配套降级方案——仅在条件满足时描述 const init 形式，未给出条件不满足时的备选路径 | 已采纳。在 §3.3 第 1 条末尾补充降级方案：若 const init 不可用，退化为普通 init 构造函数，单位矩阵构造不可用于 const 上下文仅限运行时，与阶段一 OOD 中 const init 条件性策略处理方式一致 |
| **P3（一般）**：§3.4 `col()` 与 `[]` 行为差异化描述不清晰——§3.4 称 `col()` 为"提供带边界检查的安全访问"，但 §5 明确 `[]` 下标越界同样抛出 Exception，两者行为完全一致 | 已采纳。重写 §3.4 `col()` 段落：明确 `col(i)` 与 `[](i)` 行为完全相同（均含边界检查，越界时抛出 Exception），两者并存的设计意图在于 `col(i)` 作为具名函数提升可读性并与 GLM API 习惯对齐。移除"提供带边界检查的安全访问"的差异化措辞 |
| **P4（一般）**：scalar_mat_ops.cj 与阶段一命名约定冲突——阶段一 OOD 约定仅 scalar_vec_ops.cj 定义 add/sub/mul/div 包级函数，本设计新增 scalar_mat_ops.cj 定义同名函数直接违反该约定 | 已采纳。在 §3.5 标量-矩阵运算段落补充命名约定说明，阐明两文件通过参数类型（Vec 型 vs 矩阵型）在重载解析中自然区分。在 §7 设计决策中新增 D15 记录此决策并将阶段一约定更新为"scalar_vec_ops.cj 和 scalar_mat_ops.cj 共同定义 add/sub/mul/div，通过参数类型重载区分"。在 §2 包组织清单的 scalar_mat_ops.cj 条目中添加注解说明此约定 |
| **P5（一般）**：§8 fwd.cj 矩阵别名命名规范未定义——仅写"新增矩阵类型别名（Mat2x2f、Mat4x4 等）"，未定义具体命名模式和精度变体规则 | 已采纳。在 §8 修改文件 — fwd.cj 条目中详细定义矩阵别名命名规则：`Mat{C}x{R}`（Float32 默认）、`DMat{C}x{R}`（Float64）、精度变体 `Highp/Mediump/LowpMat{C}x{R}`、方阵短别名 `mat{C}`/`dmat{C}`，与阶段一向量别名模式一致。在 §7 设计决策中新增 D16 记录此规则 |
| **P6（轻微）**：§3.1/§3.6 未讨论 @Derive[Hashable] 在矩阵类型上的一致性——阶段一 Vec 使用 @Derive[Hashable] 自动派生，矩阵类型是否支持 Hashable 以及设计理由未说明 | 已采纳。在 §3.1 矩阵结构体职责中补充"通过 @Derive[Hashable] 自动派生哈希支持"，在 §7 设计决策中新增 D17 说明矩阵类型可哈希的设计理由（成员 Vec 均已可哈希，仓颉 struct 派生条件满足）。矩阵与阶段一 Vec 在 Hashable 支持上保持一致 |
| **P7（轻微）**：路线图中可选的 type_float.cj/type_half.cj 未做取舍说明——路线图列出这两个可选文件，设计文档未说明其纳入或排除状态 | 已采纳。在 §7 设计决策中新增 D18 记录：type_float.cj 和 type_half.cj 延迟至后续阶段（阶段四函数库实现时方可能需要），不纳入本阶段范围。在 §8 产出物清单末尾新增「关于路线图中可选文件的处理」段落，明确说明排除理由 |

---

## 修订说明（v8）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题 1（轻微）**：fwd.cj 矩阵默认精度别名使用 PackedHighp，与 GLM 参考实现的 defaultp 语义不一致——设计文档未说明选择 PackedHighp 而非 Defaultp 别名的理由 | 已采纳。在 §8 fwd.cj 命名规则中补充"关于 Defaultp 与 PackedHighp"说明段落，阐明三点理由：① qualifier.cj 中 Defaultp = PackedHighp 为类型别名，仓颉类型别名在泛型参数位置的透明传递取决于编译器实现，使用 PackedHighp 规避潜在别名解析问题；② 阶段一 fwd.cj 全部向量别名均使用 PackedHighp，矩阵别名保持一致；③ Defaultp 与 PackedHighp 在语义上完全等效，运行时无差异 |
| **问题 2（一般）**：fwd.cj 缺少 Float32/Float64 以外精度族的矩阵别名（如 fmat/f32mat/f64mat 系列及 dmat 全尺寸系列），且非方阵默认精度别名未显式列出，纳排决策缺失 | 已采纳。① 在 §8 fwd.cj 条目中新增"非方阵默认精度别名"行（mat2x3~mat4x3 共 6 个 Float32 别名 + dmat2x3~dmat4x3 共 6 个 Float64 别名），显式列出全部 9×2=18 种尺寸的默认精度别名；② 在 §8 fwd.cj 条目中新增"关于不纳入的别名族"段落，逐一列出 fmat/f32mat/f64mat 系列及 imat/u8mat~u64mat 全系列，标注均为"排除"；③ 新增 D19 设计决策记录这些排除的理由（冗余前缀别名无额外类型差异，整型矩阵极低频且 GLM 自身支持不完整） |
| **问题 3（一般）**：非方阵类型缺少复合赋值矩阵乘法运算符（*= mat），设计方案未讨论其影响——"由仓颉编译器自动生成"措辞可能误导编码者 | 已采纳。在 §3.5 复合赋值运算符段落补充：明确标注仅方阵类型（Mat2x2/Mat3x3/Mat4x4）自动获得 *=（same_mat）复合赋值运算符；说明非方阵类型因矩阵乘法结果类型不同而无法自动生成矩阵复合赋值；注明方阵 *=（mat）由编译器自动生成，语义与 C++ GLM 的显式定义一致（a *= b ≡ a = a * b）。在 §9 差异声明中新增"非方阵不提供 *=（mat）复合赋值运算符"条目 |
| **问题 4（一般）**：跨矩阵类型转换构造函数中"对应位置"语义描述不够精确 | 已采纳。在 §3.3 第 8 条中将填充规则重写为精确定义：源矩阵第 j 列第 i 行的元素 M_src[j][i] 复制到目标矩阵的相同坐标位置（dst[j][i] = src[j][i]），其中 0 ≤ j < min(C_src, C_dst)、0 ≤ i < min(R_src, R_dst)。当 C_dst > C_src 时额外列从单位矩阵取值，当 R_dst > R_src 时额外行从单位矩阵取值 |
| **问题 5（轻微）**：Mat4x4 的 `init(scalar: T)` 语义描述仅提供方阵示例，未讨论非方阵标量填充的"主对角线"长度 | 已采纳。在 §3.3 第 3 条末尾补充：非方阵的主对角线长度为 min(C,R)，并附 Mat2x3(1.0f) 示例——产生 2×3 对角矩阵 `[[1,0,0],[0,1,0]]`（主对角线长度 min(2,3)=2，第 3 列全为 0）。在 §4.1 行为契约中同步补充非方阵示例 |
| **问题 6（一般）**：scalar / mat 运算在本阶段的 stub 策略未明确——其行为是逐元素 scalar / each_element，不依赖 inverse，应可本阶段完整实现 | 已采纳。① 在 §3.5 标量-矩阵运算段落中明确 div(s, m) 的语义为逐元素 s / each_element；② 在 §5 错误处理策略中补充"标量-矩阵除法（scalar / mat）为逐元素操作，不依赖 inverse，可本阶段完整实现" |
| **问题 7（一般）**：非方阵类型不提供 mat / mat 和 mat / vec 除法运算符，但设计文档"mat / mat"措辞可能误导编码者 | 已采纳。在 §3.5 二元运算符（矩阵-矩阵）除法子节中明确指出 mat/mat 和 mat/vec 除法运算符**仅方阵类型（Mat2x2、Mat3x3、Mat4x4）** 提供，非方阵类型不提供这两种除法运算符，与 GLM 参考实现一致。同步更新 §5 和 §9 差异声明 |
| **问题 8（轻微）**：ext/ 别名文件使用命名导入与 fwd.cj 的限定访问风格不同，设计文档未说明此差异及原因 | 已采纳。在 §3.8 中补充导入风格说明段落：ext/ 使用命名导入 `import glm.detail.{ Mat2x2, ... }` 而非 fwd.cj 的限定访问 `import glm.detail`，原因：ext/ 文件中定义的别名名（如 mat4）不会与 detail 包中的类型名（如 Mat4x4）冲突，因此命名导入安全可用且更简洁；而 fwd.cj 中定义的别名名（如 Mat4x4）与 detail 包中的同名泛型类冲突，必须使用限定访问以区分别名与原始类型 |
| **问题 9（一般）**：lib.cj 对 scalar_mat_ops.cj 全局函数的导出使用"建议"措辞，编码者无法确定是否应导出 | 已采纳。① 在 §8 修改文件 — lib.cj 条目中将"建议同步导出"改为明确决策（导出），并说明理由：scalar_mat_ops.cj 中的 add/sub/mul/div 是公共 API；② 确认 lib.cj 中现有 `public import glm.detail.{ add, sub, mul, div, mod }` 已自动覆盖 scalar_mat_ops.cj 中的同名函数（因两者同属 glm.detail 包，同名函数通过参数类型重载自然覆盖），无需额外 import 语句；③ 确认 mod 函数的矩阵版本不存在（矩阵取模无数学意义），lib.cj 的 mod 导出仅涉及向量版，不受影响 |
| **问题 10（一般）**：跨尺寸矩阵乘法运算符（27 个重载）的文件归属策略未定义 | 已采纳。在 §3.5 跨尺寸乘法兼容性表后新增文件归属策略段落：跨尺寸矩阵乘法运算符定义在左操作数矩阵类型的 extend 块中（即在 type_mat{C}x{R}.cj 文件中定义 operator func *(rhs: Mat{C2}x{R2}) 等重载），在对应文件顶部 import 所需右操作数矩阵类型。此设计选择与"在左操作数上定义运算符"的模式一致 |
| **问题 11（轻微）**：矩阵-标量除法和标量-矩阵除法对整型矩阵的除零风险未讨论 | 已采纳。在 §5 错误处理策略中注明"矩阵-标量除法（mat / scalar）和标量-矩阵除法（scalar / mat）对整型矩阵的除零行为与阶段一 Vec 类型一致——仓颉整数除法由编译器/运行时处理，本设计不额外添加除零保护" |
| **问题 12（一般）**：`[]` 下标运算符取值版本返回列向量副本而非引用，不支持分量级链式修改，但 §9 差异声明中未记录此用户可见差异 | 已采纳。在 §9 差异声明中新增条目：`[]` 运算符取值版本返回列向量副本，不支持分量级链式修改——C++ GLM 中 m[i] 返回引用，可直接修改 m[0].x = value；仓颉版本中 m[0] 返回副本，仅可整列赋值 m[0] = new_col，不能直接修改分量。如需修改单个分量，需先取列、修改、赋回 |
| **问题 13（轻微）**：equalEpsilon 的实现方式未明确是逐列委托 Vec 的 equalEpsilon 还是逐标量比较 | 已采纳。在 §3.6 比较运算符中明确 equalEpsilon 的实现方式为逐列委托 VecR<T,Q>.equalEpsilon，与 == 逐列委托 VecR<T,Q>.== 的模式一致。补充约束传递关系：矩阵 equalEpsilon 要求列向量类型 T 满足 Number<T> & Equatable<T> & Comparable<T>，与阶段一 Vec 的约束条件一致 |

---

## 修订说明（v9）

| 审查意见 | 修改措施 |
|---------|---------|
| **P1（严重）**：`init()` 默认单位矩阵构造函数在无约束泛型 `T` 下依赖 `T(0)/T(1)` 不可行 | 已采纳。① 删除原 §3.3 第 1 条默认单位矩阵 `init()` 构造函数及误导性的"const init 降级为普通 init"描述；② 新增 §3.3 第 8 条 `identity()` 静态工厂函数，定义在 `Number<T>` 约束的 extend 块中，利用运算演算获得 T(0) 和 T(1)（与阶段一 `increment()` 使用 `-(!(this.x - this.x))` 演算 T(1) 的模式一致）；③ 原第 1 条的标量填充构造 `init(scalar: T)` 保留为现第 1 条，标注 T(0) 构造约束；④ 新增 D20 记录此设计决策，明确声明无约束泛型不支持 T(0)/T(1) 及与 DV-01 同根因；⑤ 在 §9 差异声明中新增"无 `init()` 默认构造函数，单位矩阵通过 `identity()` 工厂函数构造"条目；⑥ 更新 §4.1 行为契约示例 |
| **P2（一般）**：§3.3 第 2 条与第 9 条构造函数在 `U=T` 时存在重载歧义 | 已采纳。删除原第 2 条"跨 Qualifier 复制"构造函数 `init<Q2>(m: Mat4x4<T, Q2>)`，其功能完全由原第 9 条（现为第 7 条）跨类型同尺寸转换构造 `init<U, P>(m: Mat4x4<U, P>)` 覆盖——当 `U=T` 时自然包含跨 Qualifier 复制。新增 D21 记录此决策。构造函数编号重新排列为 1~8 |
| **P3（轻微）**：§2 模块清单中 `type_mat4x3.cj` 条目标注为 `Mat4x4<T,Q>`，应为 `Mat4x3<T,Q>` | 已采纳。将 §2 包组织清单第 43 行 `type_mat4x3.cj ★ — Mat4x4<T,Q>` 修正为 `type_mat4x3.cj ★ — Mat4x3<T,Q>` |
| **P4（一般）**：ext/ 向量别名与 fwd.cj 向量别名的定位差异和使用指引历经 3 轮未获回应 | 已采纳。在 §3.8 中新增「ext/ 向量别名与 fwd.cj 向量别名的定位差异说明」段落：① 明确 ext/ 下的 camelCase 别名（vec1~vec4/dvec1~dvec4）与 fwd.cj 中的 PascalCase 别名（Vec1~Vec4/DVec1~DVec4）指向同一具体类型，差异仅在于命名风格和包路径；② 说明两套别名并存的起源（GLM C++ 源码中 fwd.hpp vs ext/vector_float*.hpp 的二元体系）；③ 给出推荐使用指引——推荐用户优先使用 fwd.cj 中的 PascalCase 别名（import 路径更短），ext/ 别名主要用于与 GLM C++ 代码做逐文件对应迁移的场景 |
| **P5（一般）**：跨矩阵类型转换填充规则与 GLM Mat4x4 ← Mat4x2 行为不一致 | 已采纳。在 §3.3 第 6 条（原第 8 条）填充规则段落末尾新增"编码阶段注意事项"：上述填充规则作为主规则描述，但 GLM 的实际实现中某些转换构造函数的行为与主规则存在局部差异——特别是 Mat4x4 ← Mat4x2 场景中 GLM 丢弃源矩阵第 2、3 列数据并替换为单位矩阵列，而主规则会复制源矩阵第 2、3 列的部分数据后再补齐。编码阶段须逐一对照 GLM .inl 源码实现各转换构造函数，而非机械套用主规则。若 GLM 参考源码不可直接访问，将此作为编码阶段风险项记录 |
| **P6（轻微）**：`[]` 和 `col()` 的越界保护机制不支持 `const func`，但未在设计文档和差异声明中记录 | 已采纳。① 在 §5 错误处理策略的下标越界条目中补充：此机制使 `[]` 和 `col()` 不可声明为 `const func`，与阶段一 Vec 的 `componentAt` 面临同类限制（deviations.md IF-03）；② 在 §9 差异声明中新增" `[]` 和 `col()` 不可在 `const` 上下文使用"条目，注明 C++ GLM 中 `m[i]` 在 constexpr 上下文可用，仓颉版本因 assert/throw 机制无法声明为 `const func` |

---

DESIGN_WRITTEN:C:\Develop\Software\cjglm_wp\harness\redeliberations\202606210006_OOD_stage2_migration\a_v6_design_v1.md
主Agent请勿阅读产出文件内容，直接将路径转发给相关方。