# GLM 1.0.3 仓颉迁移阶段二 OOD 设计方案（v5）

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

沿用阶段一的双层包结构：glm.detail 包含全部 9 个矩阵泛型结构体定义和运算符重载，glm 包通过类型别名暴露常用具现化。矩阵类型以列向量为数据成员（ar c0: VecN<T,Q>, var c1: VecN<T,Q>, ...），每个矩阵是一个独立的泛型结构体（而非 C×R 参数化的单一模板），与阶段一 Vec 类型的设计策略一致。

---

## 2. 模块划分

### 包组织

`
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
  └── matrix_double4x4.cj ★
`

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
- 跨尺寸矩阵乘法：Mat2x3<T,Q> * Mat3x2<T,Q> → Mat3x3<T,Q>（Mat{C1}x{R1} * Mat{C2}x{R2} → Mat{C2}x{R1}，C1=R2=3）

### 模块间依赖

`
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
  各别名文件 → glm.detail 矩阵类型
`

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
- 承载 C 个列向量数据成员（ar c0: VecR<T,Q>、ar c1: VecR<T,Q> 等，其中 R = 行数）
- 提供编译期查询函数 length(): Int64 返回列数 C
- 提供下标运算符 [](i: Int64) 访问列向量（取值 + 赋值双版本）
- 提供逐分量构造函数和向量列构造函数

**数据成员与列数关系**：

| 类型 | 数据成员 | 列数 |
|------|---------|------|
| Mat2x2 / Mat2x3 / Mat2x4 | ar c0: col_vec, var c1: col_vec | 2 |
| Mat3x2 / Mat3x3 / Mat3x4 | ar c0, var c1, var c2 | 3 |
| Mat4x2 / Mat4x3 / Mat4x4 | ar c0, var c1, var c2, var c3 | 4 |

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

1. **默认单位矩阵构造**（init()）
   - 初始化为主对角线为 T(1)、其余为 T(0) 的单位矩阵
   - 采用 const init 形式（如果仓颉允许 const init 中包含列向量构造表达式链）

2. **跨 Qualifier 复制**（init<Q2>(m: Mat4x4<T, Q2>)）
   - 从相同矩阵类型但不同 Qualifier 的实例复制

3. **标量填充构造**（init(scalar: T)）
   - 主对角线填 scalar，其余为 T(0)，产生对角矩阵

4. **逐分量构造**（init(x0, y0, z0, w0, x1, y1, z1, w1, ..., x3, y3, z3, w3)）
   - 按列主序接收全部标量分量：先第一列 4 个值，再第二列 4 个值，依此类推
   - 矩阵 Mat{C}x{R} 有 C×R 个标量参数

5. **列向量构造**（init(c0: Vec4<T,Q>, c1: Vec4<T,Q>, ...)）
   - 直接以 C 个列向量构建矩阵

6. **跨类型逐分量构造**（泛型，各分量可为不同类型）
   - 接收与逐分量构造相同数量的参数，但各参数可为不同类型，内部执行隐式类型转换

7. **跨类型列向量构造**（init(v1: Vec4<V1, Q>, v2: Vec4<V2, Q>, ...)）
   - 各列向量可为不同类型 V1, V2, ...，内部转为 Vec4<T,Q>

8. **跨矩阵类型转换构造**（explicit，从其他尺寸的矩阵构造）
   - 例如 Mat4x4<T,Q> 可以从 Mat2x2、Mat3x3、Mat2x3、Mat3x2、Mat2x4、Mat4x2、Mat3x4、Mat4x3 转换
   - 填充规则：源矩阵的元素复制到目标矩阵的对应位置；目标矩阵中源矩阵未覆盖的行列从单位矩阵的对应行/列取值（即缺失元素中，(i,i) 填 T(1)，其余填 T(0)）
   - 例如 Mat2x2 → Mat4x4：源矩阵的 4 个元素填在目标矩阵左上 2×2 位置，第 3、4 行/列中对角线（即 (2,2)、(3,3)）填 T(1)，其余位置填 T(0)

**风险说明**：跨类型构造函数（特别是跨矩阵类型转换）在仓颉重载解析中可能产生歧义，与阶段一 Vec 构造函数面临的风险类似。实现阶段需编写原型测试验证编译器行为，必要时将歧义分支改为具名工厂函数。

### 3.4 行列访问

- **下标运算符** [](i: Int64): VecR<T,Q> 和 [](i: Int64, value!: VecR<T,Q>): Unit：
  按列索引访问/修改第 i 列列向量
  - 取值版本返回 VecR<T,Q>（列向量的副本，值语义）
  - 赋值版本接收 alue!: VecR<T,Q>（mut 函数修改对应列成员）

- **具名函数** componentAt(i: Int64): VecR<T,Q>：
  等同于下标取值，提供带边界检查的安全访问

- **行访问函数**（可选）ow(i: Int64): VecC<T,Q>：
  从矩阵中提取第 i 行为一个行向量
  - 跨所有列收集第 i 个分量组成行向量
  - 非运算符形式，因 GLM 的 .inl 中行访问由 operator[] 处理列访问，行访问不提供运算符形式

### 3.5 算术运算符

所有算术运算符定义在带 Number<T> 约束的 extend 块中，与阶段一 Vec 类型模式一致。

**一元运算符**：
- operator func -(): Mat{C}x{R}<T,Q> — 逐元素取负

**二元运算符（矩阵-标量）**：
- +、-、*、/（右操作数为 T）：逐元素操作

**二元运算符（标量-矩阵）**：
- +、-、*、/（左操作数为 T，右操作数为矩阵）：通过 scalar_mat_ops.cj 中的全局具名函数处理（dd<T,Q>(s: T, m: Mat{C}x{R}<T,Q>)、sub<T,Q>(s: T, m)、mul<T,Q>(s: T, m)、div<T,Q>(s: T, m)），与阶段一 scalar_vec_ops.cj 的模式一致。每种运算为 9 个矩阵类型各提供 1 个重载，共 36 个全局函数（4 种运算 × 9 种矩阵）

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
- /（矩阵-矩阵除法）：等价于 mat *= inverse(rhs)（赋值语义），因 inverse 属于 matrix.cj 函数库（本阶段为 stub），矩阵-矩阵除法推迟至阶段四

**二元运算符（矩阵-向量）**：
- *（矩阵 × 列向量）：Mat{C}x{R}<T,Q> * Vec{C}<T,Q> → Vec{R}<T,Q>
  - 例如 Mat4x4<T,Q> * Vec4<T,Q> → Vec4<T,Q>
  - 例如 Mat2x3<T,Q> * Vec2<T,Q> → Vec3<T,Q>
- *（行向量 × 矩阵）：Vec{R}<T,Q> * Mat{C}x{R}<T,Q> → Vec{C}<T,Q>
  - 例如 Vec3<T,Q> * Mat2x3<T,Q> → Vec2<T,Q>（Vec{R}=Vec3, Mat2x3 的 C=2 → Vec{C}=Vec2）
  - 例如 Vec4<T,Q> * Mat4x4<T,Q> → Vec4<T,Q>（方阵特殊性：C=R=4）

**复合赋值运算符**：由仓颉编译器自动生成（当二元运算符返回类型与左操作数类型匹配时），标注 @OverflowWrapping 策略与阶段一 Vec 类型一致。

### 3.6 比较运算符

定义在 Equatable<T> 约束的 extend 块中：
- == 和 !=：逐列比较，所有列相等则矩阵相等
- equalExact(other)：具名精确比较

定义在 Number<T> & Equatable<T> & Comparable<T> 约束的 extend 块中：
- equalEpsilon(other)：浮点容差比较（委托 ComputeEqualNumeric<T>）

### 3.7 stub 函数库

为满足方阵 .inl 编排的依赖闭合性，本阶段创建 3 个 stub 文件：

**common.cj**（package glm.detail）：
- 提供 min、max、bs、sign、loor、ceil、ract、mod、clamp 等基础数学函数的空壳签名
- 函数体以 	hrow Exception("stub") 占位，或返回零值的默认结果
- 被 	ype_mat3x3 和 	ype_mat4x4 的 .inl 实现引用

**matrix.cj**（package glm.detail）：
- 提供 	ranspose、determinant、inverse、matrixCompMult、outerProduct 等矩阵运算函数的空壳签名
- 被 	ype_mat2x2、	ype_mat3x3、	ype_mat4x4 的 .inl 实现引用

**geometric.cj**（package glm.detail）：
- 提供 dot、cross、
ormalize、length、distance、eflect、efract 等几何函数的空壳签名
- 被 	ype_mat4x4 的 .inl 实现引用

### 3.8 ext/ 别名文件

src/ext/ 目录下存放矩阵和向量的具现化别名文件，声明 package glm.ext。每个文件包含一或两个 public type 别名定义：

- matrix_float4x4.cj：public type mat4x4 = detail.Mat4x4<Float32, detail.PackedHighp> 和 public type mat4 = detail.Mat4x4<Float32, detail.PackedHighp>
- matrix_double4x4.cj：public type dmat4x4 = detail.Mat4x4<Float64, detail.PackedHighp> 和 public type dmat4 = detail.Mat4x4<Float64, detail.PackedHighp>
- 其余 16 个矩阵别名文件同理（9 种尺寸 × 2 种精度，共 18 个文件，此处为前文已列出 2 个方阵文件之外的剩余文件）

每个文件通过 import glm.detail.{ Mat2x2, Mat2x3, ..., PackedHighp } 导入所需的矩阵类型和 Qualifier 类型，再定义 public type 别名。

---

## 4. 关键行为契约

### 4.1 矩阵构造与单位矩阵

`
let m = Mat4x4<Float32, PackedHighp>()           // 单位矩阵
let m = Mat4x4<Float32, PackedHighp>(1.0f)       // 对角矩阵 diag(1,1,1,1)
let m = Mat4x4<Float32, PackedHighp>(
    1.0f, 0.0f, 0.0f, 0.0f,                      // 列 0
    0.0f, 1.0f, 0.0f, 0.0f,                      // 列 1
    0.0f, 0.0f, 1.0f, 0.0f,                      // 列 2
    0.0f, 0.0f, 0.0f, 1.0f)                      // 列 3  单位矩阵等同
`

### 4.2 矩阵乘法

`
let a = Mat4x4<Float32, PackedHighp>(...)
let b = Mat4x4<Float32, PackedHighp>(...)
let c = a * b                    // 矩阵-矩阵乘，结果 Mat4x4

let v = Vec4<Float32, PackedHighp>(1.0f, 2.0f, 3.0f, 1.0f)
let transformed = a * v          // 矩阵-向量乘，结果 Vec4
`

### 4.3 跨尺寸转换

`
let m2 = Mat2x2<Float32, PackedHighp>(...)        // 2x2
let m4 = Mat4x4<Float32, PackedHighp>(m2)          // 2x2 -> 4x4，扩展填 0/1
`

### 4.4 ext/ 别名使用

`
import glm.ext.matrix_float4x4.{ mat4, mat4x4 }
import glm.ext.vector_float4.{ vec4 }

let m = mat4(1.0f)
let v = vec4(1.0f, 2.0f, 3.0f, 1.0f)
let r = m * v
`

---

## 5. 错误处理策略

与阶段一保持一致：
- **下标越界**：[](i: Int64) 中超出列范围的索引抛出 Exception（含 ssert + fallback throw）
- **数学异常**：零除、奇异矩阵运算等——在阶段四 matrix.cj/geometric.cj 完整实现中进一步明确。本阶段仅矩阵-矩阵除法（mat / mat）因依赖 inverse 函数（stub），运算符内部调用时抛出 stub 异常；矩阵-标量除法（mat / scalar）不依赖 inverse，可本阶段完整实现
- **溢出策略**：算术复合赋值运算符标注 @OverflowWrapping，与阶段一 Vec 类型一致

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
| D04 | 矩阵乘法运算符直接内联展开而非委托函数库 | C×R <= 4x4=16，内联展开代码量可控且避免函数调用开销；复合运算（如  * b * v）中可合并优化 |
| D05 | 矩阵-向量乘法定义为矩阵运算符 | 与 C++ GLM 的 operator*(mat, vec) 一致，是线性代数最核心的操作 |
| D06 | 标量在矩阵左侧的运算通过全局函数处理 | 仓颉 operator func +(rhs: T) 的 	his 固定为左操作数，仅能表达 Mat + T，无法表达 T + Mat。参考阶段一 scalar_vec_ops.cj 模式，创建 scalar_mat_ops.cj 提供全局具名函数（dd/sub/mul/div）处理标量在矩阵左侧的运算 |
| D07 | stub 函数提供空壳签名而非完整实现 | 阶段二的验证标准不包括函数库运算（仅矩阵创建、行列访问、基本算术），stub 保证方阵文件编译通过即可 |
| D08 | 排除 ++/-- 运算符的具名替代（increment/decrement） | 矩阵自增/自减在图形学中使用率极低，可通过 += identity 等价替代 |
| D09 | 排除 % 运算符（取模） | 矩阵取模无数学意义，GLM 也未为矩阵类型定义 % 运算符 |
| D10 | 排除位运算符（&/|/^/<</>>） | 矩阵类型不支持位运算，GLM 的矩阵类型也未定义位运算符 |
| D11 | **不在矩阵结构体内部定义类型别名** | 仓颉限制类型别名只能在源文件顶层定义，不能在结构体/类/函数体内定义。各矩阵的列向量/行向量类型直接引用具体 VecN<T,Q> 类型，与阶段一 Vec 类型风格一致 |

---

## 8. 阶段二产出物清单

### 9 个矩阵类型实现文件（src/detail/）
- 	ype_mat2x2.cj ~ 	ype_mat4x4.cj（9 文件）

### 4 个辅助文件（src/detail/）
- common.cj、matrix.cj、geometric.cj（3 个 stub）
- scalar_mat_ops.cj（标量-矩阵运算全局函数，36 个重载）

### ext/ 别名文件（src/ext/，声明 package glm.ext）
- 18 个矩阵别名文件（9 尺寸 x 2 精度：float + double）

### 修改文件
- src/fwd.cj：新增矩阵类型别名（Mat2x2f、Mat4x4 等）
- src/lib.cj：新增 9 个矩阵类型的 public import；建议同步导出 scalar_mat_ops.cj 中的全局函数（dd/sub/mul/div）
- cjpm.toml：确认 src-dir 配置覆盖 src/ext/ 目录

### 测试文件
- 矩阵类型测试：	ype_mat2x2_test.cj ~ 	ype_mat4x4_test.cj
- 矩阵别名测试
- 标量-矩阵运算测试：scalar_mat_ops_test.cj

---

## 9. 对齐 GLM 参考实现的差异声明

| 差异 | 说明 |
|------|------|
| **无 C 数组成员** | GLM 中 col_type value[C] 的 C 数组在仓颉中替换为具名成员 c0, c1, ... |
| **无 GLM_CONFIG_* 条件编译** | 全部采用最保守值，不引入条件编译路径 |
| **无 ++/-- 运算符** | 仓颉不支持重载自增/自减运算符，且矩阵场景使用率极低 |
| **ext/ 别名文件为 package glm.ext 而非 C++ 的 
amespace glm** | 仓颉包名与目录路径匹配规则约束 |
| **矩阵-矩阵除法推迟** | 矩阵-标量除法（mat / scalar）属逐元素操作，本阶段可完整实现。仅矩阵-矩阵除法（mat / mat）依赖 inverse（阶段四完整实现），本阶段运算符内部调用 stub 函数 |
| **标量左侧矩阵运算为全局函数而非运算符** | 仓颉 operator func 的 	his 固定为左操作数，T + Mat 无法以运算符表达。改用 scalar_mat_ops.cj 中的全局具名函数（dd/sub/mul/div）替代，调用方使用 dd(s, m) 而非 s + m |
| **无类型别名体系** | 仓颉类型别名只能定义在文件顶层，不能在结构体内部定义。各矩阵的列向量/行向量类型在使用处直接引用具体的 VecN<T,Q> 类型，不定义 col_type/ow_type 等内部类型别名 |

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
| 问题 1：标量左侧矩阵运算描述不准确——设计第 3.5 节和 D06 称通过矩阵 extend 块中接收 T 参数的运算符处理 T + Mat，但仓颉 operator func +(rhs: T) 的 	his 固定为左操作数，仅能表达 Mat + T，无法处理 T + Mat。阶段一实际通过 scalar_vec_ops.cj 中的全局具名函数实现标量左侧运算 | 已采纳。修正第 3.5 节：将"通过矩阵的 extend 块中接收 T 参数的运算符处理"改为"通过 scalar_mat_ops.cj 中的全局具名函数处理"，与阶段一 scalar_vec_ops.cj 模式一致。新增 scalar_mat_ops.cj 文件至第 2 节模块清单和依赖图。修正 D06 理由：阐明仓颉 operator func 无法表达标量左侧运算的原因，参考 scalar_vec_ops.cj 采用全局函数方案。更新第 8 节产出物清单和第 9 节差异声明 |

---

## 修订说明（v4）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题 1（严重）**：类型别名无法定义在结构体内部——设计第 3.2 节要求每个矩阵结构体内部定义 public type col_type、public type row_type 等类型别名。仓颉语言规定类型别名只能在源文件顶层定义，不能在结构体/类/函数体等嵌套作用域内定义。阶段一 Vec 类型的实现也全部未在结构体内部定义类型别名。此问题影响全部 9 个矩阵类型的设计可行性 | 已采纳。采用审查推荐的 **Option B**：完全移除全部类型别名，在使用处直接引用具体的 VecN<T,Q> 类型。具体修改：① 重写第 3.2 节为"类型映射关系（取代类型别名体系）"，说明设计约束并给出引用规则；② 第 1 节核心抽象表中移除 col_type/ow_type 条目；③ 第 3.1 节矩阵结构体职责中移除"提供类型别名"；④ 第 3.3~3.5 节中将所有 col_type/ow_type 替换为直接的具体 Vec 类型引用；⑤ 第 2 节矩阵类型概览表中保留列向量/行向量类型信息作为文档标注；⑥ 第 9 节对齐差异声明中增加"无类型别名体系"条目；⑦ 新增 D11 记录此决策 |
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
| **上轮审查问题 1（严重）**：跨尺寸矩阵乘法结果类型系统性错误——§3.5 跨尺寸乘法表中所有非方阵乘法结果类型均按错误公式计算；兼容性判定也存在遗漏，计数"3+18=21"应为"3+24=27" | 已采纳。采用正确规则 `Mat{C1}x{R1} * Mat{C2}x{R2} → Mat{C2}x{R1}`（当 C1=R2）重新生成完整跨尺寸乘法列表。修正兼容性计数为 3 方阵 + 24 跨尺寸 = 27 有效重载。同步修正 §2 核验示例中 Mat2x3 * Mat3x2 → Mat2x2 为正确结果 Mat3x3 |

