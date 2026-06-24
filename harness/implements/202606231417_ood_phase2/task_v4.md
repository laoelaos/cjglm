# 任务指令（v4）

## 动作
NEW

## 任务描述
对 6 个非方阵矩阵类型 skeleton 文件实现完整功能——每个文件追加 4 个 extend 块（算术运算符+工厂+fromMat 6a+fromMat 6b），同步创建配套测试文件：

| 文件路径 | 操作 | 矩阵 | 列向量 | 列数 | 行数 |
|---------|------|------|--------|------|------|
| src/detail/type_mat2x3.cj | 修改 | Mat2x3<T,Q> | Vec3<T,Q> | 2 | 3 |
| src/detail/type_mat2x4.cj | 修改 | Mat2x4<T,Q> | Vec4<T,Q> | 2 | 4 |
| src/detail/type_mat3x2.cj | 修改 | Mat3x2<T,Q> | Vec2<T,Q> | 3 | 2 |
| src/detail/type_mat3x4.cj | 修改 | Mat3x4<T,Q> | Vec4<T,Q> | 3 | 4 |
| src/detail/type_mat4x2.cj | 修改 | Mat4x2<T,Q> | Vec2<T,Q> | 4 | 2 |
| src/detail/type_mat4x3.cj | 修改 | Mat4x3<T,Q> | Vec3<T,Q> | 4 | 3 |
| tests/glm/detail/test_type_mat2x3.cj | 新建 | 配套测试 | | | |
| tests/glm/detail/test_type_mat2x4.cj | 新建 | 配套测试 | | | |
| tests/glm/detail/test_type_mat3x2.cj | 新建 | 配套测试 | | | |
| tests/glm/detail/test_type_mat3x4.cj | 新建 | 配套测试 | | | |
| tests/glm/detail/test_type_mat4x2.cj | 新建 | 配套测试 | | | |
| tests/glm/detail/test_type_mat4x3.cj | 新建 | 配套测试 | | | |

## 选择理由
6 个非方阵矩阵无函数库依赖（设计文档明确：matrix.cj/common.cj/geometric.cj 的依赖仅方阵类型需要），可独立于 T5/T6/T7 实现。与 Mat2x2 完全同构的模式——均为结构体 + extend 块模式，仅尺寸和列向量类型差异。Mat2x2（v3 已验证通过 476 用例）的模式可直接复用。在同一轮次中实现全部 6 个文件可最大化模式一致性，减少上下文切换。

## 任务上下文

### 每个文件需要追加 4 个 extend 块

**Extend ①（Number<T> 约束）**：
- `public operator func -(): Mat{C}x{R}<T,Q>` — 一元负号，逐分量取反
- `public operator func +(rhs: T): Mat{C}x{R}<T,Q>` — 矩阵-标量加
- `public operator func -(rhs: T): Mat{C}x{R}<T,Q>` — 矩阵-标量减
- `public operator func *(rhs: T): Mat{C}x{R}<T,Q>` — 矩阵-标量乘
- `public operator func /(rhs: T): Mat{C}x{R}<T,Q>` — 矩阵-标量除
- `public operator func +(rhs: Mat{C}x{R}<T,Q>): Mat{C}x{R}<T,Q>` — 矩阵-矩阵加（同尺寸）
- `public operator func -(rhs: Mat{C}x{R}<T,Q>): Mat{C}x{R}<T,Q>` — 矩阵-矩阵减（同尺寸）
- 跨尺寸乘法 ×3（见下方乘法表）
- `public operator func *(v: VecC<T,Q>): VecR<T,Q>` — Mat×Vec（C=列数=输入向量维数，R=行数=输出向量维数）
- `public static func diagonal(scalar: T): Mat{C}x{R}<T,Q>` — 对角矩阵工厂
- `public static func identity(one: T): Mat{C}x{R}<T,Q>` — 单位矩阵工厂
- 注意：**不包含矩阵-矩阵除法**（仅方阵提供）

所有算术运算符标注 `@OverflowWrapping`

**Extend ②（仅 Qualifier 约束）**：
- `public static func fromParts<U>(conv: (U) -> T, a00..a{C-1}{R-1}: U): Mat{C}x{R}<T,Q>` — 跨类型逐分量构造，C×R 个参数
- `public static func fromColumns<U, P>(conv: (U) -> T, c0..c{C-1}: VecR<U,P>): Mat{C}x{R}<T,Q>` — 跨类型列向量构造
- `public static func fromMat<U, P>(conv: (U) -> T, m: Mat{C}x{R}<U,P>): Mat{C}x{R}<T,Q>` — 跨类型同尺寸转换

**Extend ③（fromMat 6a：同类型不同尺寸）**：
约束 `where T <: Number<T>, Q <: Qualifier`，8 个 `fromMat<SrcQ>` 重载，分别从 8 个其他矩阵尺寸转换而来。每个重载接收 `(m: 源类型<T,SrcQ>, one: T)`，返回本类型。T(0)=`m.c0.x - m.c0.x`。

**Extend ④（fromMat 6b：跨类型不同尺寸）**：
约束 `where T <: Number<T>, Q <: Qualifier`，8 个 `fromMat<U, P>` 重载。每个重载接收 `(conv: (U) -> T, m: 源类型<U,P>, one: T)`，返回本类型。T(0)=`one - one`。

### 跨尺寸乘法表（每个非方阵类型需要 ×3 个重载）

| 左矩阵 | 右矩阵 | 结果 |
|--------|--------|------|
| Mat2x3 | Mat2x2 | Mat2x3 |
| Mat2x3 | Mat3x2 | Mat3x3 |
| Mat2x3 | Mat4x2 | Mat4x3 |
| Mat2x4 | Mat2x2 | Mat2x4 |
| Mat2x4 | Mat3x2 | Mat3x4 |
| Mat2x4 | Mat4x2 | Mat4x4 |
| Mat3x2 | Mat2x3 | Mat2x2 |
| Mat3x2 | Mat3x3 | Mat3x2 |
| Mat3x2 | Mat4x3 | Mat4x2 |
| Mat3x4 | Mat2x3 | Mat2x4 |
| Mat3x4 | Mat3x3 | Mat3x4 |
| Mat3x4 | Mat4x3 | Mat4x4 |
| Mat4x2 | Mat2x4 | Mat2x2 |
| Mat4x2 | Mat3x4 | Mat3x2 |
| Mat4x2 | Mat4x4 | Mat4x2 |
| Mat4x3 | Mat2x4 | Mat2x3 |
| Mat4x3 | Mat3x4 | Mat3x3 |
| Mat4x3 | Mat4x4 | Mat4x3 |

乘法结果的计算公式统一：`result[j][i] = sum_{k=0}^{C_left-1} left[k][i] * right[j][k]`，其中 i=行索引(0..R_left-1)，j=列索引(0..C_right-1)，k=内积索引(0..C_left-1)。

### 非方阵 identity/diagonal 特殊规则
- **diagonal(scalar)**：对角线元素用 scalar，非对角线用 T(0)=`scalar - scalar`
- **identity(one)**：主对角线（i ∈ [0, min(C,R)-1] 位置）填 one，其余填 T(0)。即对每列 i：
  - 若 i < R：第 i 个分量为 one，其余分量为 T(0)
  - 若 i ≥ R：整列全 T(0)

### fromMat 6a/6b 四项基本操作
对所有 6a/6b 方向使用统一的"先列后行"组合规则：
1. 若 C_src > C_dst → colShrink（截断保留前 C_dst 列）
2. 若 C_src < C_dst → colExtend（新增列填对角线 one + 其余 T(0)）
3. 若 R_src > R_dst → rowShrink（每列截断保留前 R_dst 个分量）
4. 若 R_src < R_dst → rowExtend（每列新增分量中，对角线位置 one，其余 T(0)）

C_src 通过 `typeof(src).length()` 获取，R_src/R_dst 在每个重载中硬编码字面量。

**特殊偏差方向**：Mat4x4←Mat4x2 的 fromMat 不在此任务范围内（该偏差是方阵 Mat4x4 的 fromMat）。

### fromMat 6a/6b 的 T(0) 演算差异
- **6a**：`let zero = m.c0.x - m.c0.x`（m.c0.x 类型为 T，与目标元素类型一致）
- **6b**：`let zero = one - one`（m.c0.x 类型为 U，不能用于 T 类型；one 类型为 T）

### 跳过的功能（本任务不实现）
- 矩阵-矩阵除法 `/`（仅方阵 Mat2x2/Mat3x3/Mat4x4 提供，T5 实现）
- `*=(Mat)` 和 `/=(Mat)` 复合赋值（仅方阵，且 stub）
- `scalar_mat_ops.cj` 中的标量-矩阵全局函数（T7 实现）
- Vec extend 块中的行向量×矩阵运算符（T8 实现）
- 比较运算符 `==`/`!=`（各矩阵类型通过 `@Derive[Hashable]` 自动派生）

## 已有代码上下文

### skeleton 文件的当前结构
每个 skeleton 文件（T2 产出）已包含：
- 结构体定义 `struct Mat{C}x{R}<T, Q> where Q <: Qualifier`
- 列向量数据成员 `var c0..c{C-1}: VecR<T,Q>`
- 3 个构造函数：`init(scalar: T)`、`const init(逐分量列主序)`、`const init(列向量...)`
- `public static func length(): Int64 { C }`
- `operator func [](i: Int64): VecR<T,Q>`（取值 + 赋值双版本）
- `func col(i: Int64): VecR<T,Q> { this[i] }`

每个文件的 import 语句已有 `std.math.{ Number, Integer }` 和 `std.deriving.*`。

### 可复用的 Mat2x2 模式（已验证通过 476 用例）
参考 `src/detail/type_mat2x2.cj` 的完整实现模式：
- Extend 块的结构组织（4 个独立 extend 块，按约束和职责分离）
- 所有 VecN 构造显式标注 `<T, Q>` 类型参数（如 `Vec3<T,Q>(...)`）— 仓颉编译器不能自动推断 qualifier
- 跨尺寸乘法结果类型构造也显式标注（如 `Mat3x3<T,Q>(...)`）
- 所有算术运算符标注 `@OverflowWrapping`
- `diagonal(one)` 内部委托 `identity(one)` 的等价模式的变体—非方阵两者独立实现

### 偏差记录（已有的可用模式）
- `SrcQ`/`P` 类型参数从 extend 级别移到方法级别（仓颉要求 extend 块的所有类型参数必须出现在被扩展类型中）
- fromMat 6a colShrink 方向即使 C_src=C_dst 也使用逐分量提取而非直接列传递（跨 Qualifier 转换时类型不匹配）
