# 任务指令（v2）

## 动作
RETRY

## 任务描述
创建 8 个矩阵类型 skeleton 结构体定义文件（`src/detail/type_mat2x3.cj` ~ `type_mat4x4.cj`），每文件包含 minimum viable 定义：结构体、列向量数据成员、基础构造函数（逐分量 const init / 列向量 init / 标量填充 init）、length()、下标运算符 [](get/set)、col() 访问器。**不包含**任何 arithmetic 运算符 extend 块、工厂函数、fromMat 或比较运算符。

## 选择理由
审查发现原 T2（完整 Mat2x2 实现）的 fromMat 6a/6b/7 引用全部 8 个其他矩阵类型，跨尺寸乘法引用 Mat3x2/Mat4x2——仓颉以包为最小编译单元，这些类型必须在编译时存在。必须先建立所有矩阵类型的 skeleton 定义方可编译任何单个矩阵的完整实现。8 个 skeleton 模式完全机械（仅差异为列向量类型和列数），适合批量创建。

## 任务上下文

### 类型映射表
| 类型 | 文件 | C | R | 列向量类型 | const init 参数数 |
|------|------|---|---|-----------|-----------------|
| Mat2x3<T,Q> | type_mat2x3.cj | 2 | 3 | Vec3<T,Q> | 6 |
| Mat2x4<T,Q> | type_mat2x4.cj | 2 | 4 | Vec4<T,Q> | 8 |
| Mat3x2<T,Q> | type_mat3x2.cj | 3 | 2 | Vec2<T,Q> | 6 |
| Mat3x3<T,Q> | type_mat3x3.cj | 3 | 3 | Vec3<T,Q> | 9 |
| Mat3x4<T,Q> | type_mat3x4.cj | 3 | 4 | Vec4<T,Q> | 12 |
| Mat4x2<T,Q> | type_mat4x2.cj | 4 | 2 | Vec2<T,Q> | 8 |
| Mat4x3<T,Q> | type_mat4x3.cj | 4 | 3 | Vec3<T,Q> | 12 |
| Mat4x4<T,Q> | type_mat4x4.cj | 4 | 4 | Vec4<T,Q> | 16 |

### 每个文件的 skeleton 模板
`package glm.detail`
导入：`import std.math.{ Number, Integer }`, `import std.deriving.*`

**结构体定义：**
```cangjie
@Derive[Hashable]
public struct Mat{C}x{R}<T, Q> where Q <: Qualifier {
    public var c0: Vec{R}<T,Q>
    public var c1: Vec{R}<T,Q>
    // ... 根据需要增加 c2, c3
```

**逐分量 const init**（列主序）：参数命名 `a{列}{行}`，例如 Mat2x3：`(a00, a01, a02, a10, a11, a12)`——前 R 个参数为列 0 的各行，后 R 个参数为列 1 的各行。Mat3x2：`(a00, a01, a10, a11, a20, a21)`。

**列向量 init**：C 个列向量参数，类型为 Vec{R}<T,Q>。例如 Mat3x2：`(c0: Vec2<T,Q>, c1: Vec2<T,Q>, c2: Vec2<T,Q>)`。

**标量填充 init**：所有列向量的所有分量填充为 scalar。

**length()**：返回列数 C 的 Int64 字面量。

**下标运算符 []**：返回 Vec{R}<T,Q>，assert + match 分发到 c0~c{C-1}，越界 throw Exception。

**col()**：等价于 [] 取值版本。

## 已有代码上下文
- `src/detail/type_vec2.cj` — Vec2<T,Q> 结构体，可参考其 struct 定义、下标、componentAt 模式
- `src/detail/type_vec3.cj`, `type_vec4.cj` — Vec3/4 定义，Mat3x2/Mat4x2/Mat2x4 等 skeleton 的列向量类型依赖
- `src/detail/qualifier.cj` — Qualifier 接口
- 所有文件同属 `package glm.detail`，Vec 类型同包直接可见
- **不创建 type_mat2x2.cj**（该文件已由本轮 T2 原本规划，将在 T3 实现完整版）
- `common.cj` 和 `geometric.cj` stub 已就绪（T1 阶段产物），Mat3x3/Mat4x4 虽然 stub-signature 引用 common/geometric，但 skeleton 阶段不引用任何 stub 函数

## 各文件关键差异点

### type_mat2x3.cj
- `var c0: Vec3<T,Q>, var c1: Vec3<T,Q>`
- `length() { 2 }`
- const init: `(a00: T, a01: T, a02: T, a10: T, a11: T, a12: T)`
- 返回 Vec3<T,Q>

### type_mat2x4.cj
- `var c0: Vec4<T,Q>, var c1: Vec4<T,Q>`
- `length() { 2 }`
- const init: `(a00: T, a01: T, a02: T, a03: T, a10: T, a11: T, a12: T, a13: T)`
- 返回 Vec4<T,Q>

### type_mat3x2.cj
- `var c0: Vec2<T,Q>, var c1: Vec2<T,Q>, var c2: Vec2<T,Q>`
- `length() { 3 }`
- const init: `(a00: T, a01: T, a10: T, a11: T, a20: T, a21: T)`
- 返回 Vec2<T,Q>

### type_mat3x3.cj
- `var c0: Vec3<T,Q>, var c1: Vec3<T,Q>, var c2: Vec3<T,Q>`
- `length() { 3 }`
- const init: `(a00: T, a01: T, a02: T, a10: T, a11: T, a12: T, a20: T, a21: T, a22: T)`
- 返回 Vec3<T,Q>

### type_mat3x4.cj
- `var c0: Vec4<T,Q>, var c1: Vec4<T,Q>, var c2: Vec4<T,Q>`
- `length() { 3 }`
- const init: `(a00: T, a01: T, a02: T, a03: T, a10: T, a11: T, a12: T, a13: T, a20: T, a21: T, a22: T, a23: T)`
- 返回 Vec4<T,Q>

### type_mat4x2.cj
- `var c0: Vec2<T,Q>, var c1: Vec2<T,Q>, var c2: Vec2<T,Q>, var c3: Vec2<T,Q>`
- `length() { 4 }`
- const init: `(a00: T, a01: T, a10: T, a11: T, a20: T, a21: T, a30: T, a31: T)`
- 返回 Vec2<T,Q>

### type_mat4x3.cj
- `var c0: Vec3<T,Q>, var c1: Vec3<T,Q>, var c2: Vec3<T,Q>, var c3: Vec3<T,Q>`
- `length() { 4 }`
- const init: `(a00: T, a01: T, a02: T, a10: T, a11: T, a12: T, a20: T, a21: T, a22: T, a30: T, a31: T, a32: T)`
- 返回 Vec3<T,Q>

### type_mat4x4.cj
- `var c0: Vec4<T,Q>, var c1: Vec4<T,Q>, var c2: Vec4<T,Q>, var c3: Vec4<T,Q>`
- `length() { 4 }`
- const init: `(a00: T, a01: T, a02: T, a03: T, a10: T, a11: T, a12: T, a13: T, a20: T, a21: T, a22: T, a23: T, a30: T, a31: T, a32: T, a33: T)`
- 返回 Vec4<T,Q>

## 修订说明（v2 r1）
| 审查意见 | 修改措施 |
|---------|---------|
| [严重] T2（type_mat2x2.cj）引用了 Mat3x2/Mat4x2/Mat3x3/Mat4x4 等尚未存在的类型（fromMat 6a/6b 共 17 个重载 + 跨尺寸乘法），仓颉以包为最小编译单元，按原有顺序实施将导致编译失败 | 将原 T2 拆分为两步：本任务（R2 RETRY）先创建 8 个依赖类型的 skeleton 文件（Mat2x3~Mat4x4），提供 minimum viable 类型定义以闭合所有跨类型编译依赖；后续 T3 实现完整 Mat2x2。plan.md 已同步更新：新增 R2 RETRY T2 记录，调整路线表中 T2~T5 的任务划分 |
