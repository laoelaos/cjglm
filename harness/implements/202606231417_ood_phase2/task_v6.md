# 任务指令（v6）

## 动作
NEW

## 任务描述
创建 `src/detail/matrix.cj`（package glm.detail），实现 33 个函数的混合型文件——27 个可直接实现的重载（transpose×9、matrixCompMult×9、outerProduct×9）和 6 个 stub 重载（determinant×3、inverse×3，函数体 `throw Exception("stub")`）。

本文件区别于纯 stub 文件（common.cj/geometric.cj）：transpose/matrixCompMult/outerProduct 可通过索引映射或逐元素运算直接实现，不依赖其他 stub 文件。

同步创建测试文件 `tests/glm/detail/test_matrix.cj`，覆盖全部 27 个非 stub 函数的编译和执行验证。

## 选择理由
T5 已完成所有 9 个矩阵类型的完整功能闭合。matrix.cj 是方阵 .inl 编排的关键依赖——type_mat3x3.cj 和 type_mat4x4.cj 的 inl 中引用了 matrix.cj 的函数（stub），本阶段先完成可直接实现的 27 个重载，6 个 stub 为阶段三 inverse/determinant 做签名占位。按设计文档 §8 编译顺序建议，matrix.cj 应位于矩阵类型文件之前编译。

## 任务上下文

### 文件预期位置
- `src/detail/matrix.cj` — 实现文件（packge glm.detail）
- `tests/glm/detail/test_matrix.cj` — 测试文件

### 函数签名清单

**transpose（9 重载，`where Q <: Qualifier`）**：
```
func transpose<T, Q>(m: Mat2x2<T, Q>): Mat2x2<T, Q> where Q <: Qualifier
func transpose<T, Q>(m: Mat2x3<T, Q>): Mat3x2<T, Q> where Q <: Qualifier
func transpose<T, Q>(m: Mat2x4<T, Q>): Mat4x2<T, Q> where Q <: Qualifier
func transpose<T, Q>(m: Mat3x2<T, Q>): Mat2x3<T, Q> where Q <: Qualifier
func transpose<T, Q>(m: Mat3x3<T, Q>): Mat3x3<T, Q> where Q <: Qualifier
func transpose<T, Q>(m: Mat3x4<T, Q>): Mat4x3<T, Q> where Q <: Qualifier
func transpose<T, Q>(m: Mat4x2<T, Q>): Mat2x4<T, Q> where Q <: Qualifier
func transpose<T, Q>(m: Mat4x3<T, Q>): Mat3x4<T, Q> where Q <: Qualifier
func transpose<T, Q>(m: Mat4x4<T, Q>): Mat4x4<T, Q> where Q <: Qualifier
```

**determinant（3 重载，stub）**：
```
func determinant<T, Q>(m: Mat2x2<T, Q>): T where T <: Number<T>, Q <: Qualifier  // throw Exception("stub")
func determinant<T, Q>(m: Mat3x3<T, Q>): T where T <: Number<T>, Q <: Qualifier  // throw Exception("stub")
func determinant<T, Q>(m: Mat4x4<T, Q>): T where T <: Number<T>, Q <: Qualifier  // throw Exception("stub")
```

**inverse（3 重载，stub）**：
```
func inverse<T, Q>(m: Mat2x2<T, Q>): Mat2x2<T, Q> where T <: Number<T>, Q <: Qualifier  // throw Exception("stub")
func inverse<T, Q>(m: Mat3x3<T, Q>): Mat3x3<T, Q> where T <: Number<T>, Q <: Qualifier  // throw Exception("stub")
func inverse<T, Q>(m: Mat4x4<T, Q>): Mat4x4<T, Q> where T <: Number<T>, Q <: Qualifier  // throw Exception("stub")
```

**matrixCompMult（9 重载，`where T <: Number<T>, Q <: Qualifier`）**：
```
func matrixCompMult<T, Q>(x: Mat2x2<T, Q>, y: Mat2x2<T, Q>): Mat2x2<T, Q> where T <: Number<T>, Q <: Qualifier
func matrixCompMult<T, Q>(x: Mat2x3<T, Q>, y: Mat2x3<T, Q>): Mat2x3<T, Q> where T <: Number<T>, Q <: Qualifier
func matrixCompMult<T, Q>(x: Mat2x4<T, Q>, y: Mat2x4<T, Q>): Mat2x4<T, Q> where T <: Number<T>, Q <: Qualifier
func matrixCompMult<T, Q>(x: Mat3x2<T, Q>, y: Mat3x2<T, Q>): Mat3x2<T, Q> where T <: Number<T>, Q <: Qualifier
func matrixCompMult<T, Q>(x: Mat3x3<T, Q>, y: Mat3x3<T, Q>): Mat3x3<T, Q> where T <: Number<T>, Q <: Qualifier
func matrixCompMult<T, Q>(x: Mat3x4<T, Q>, y: Mat3x4<T, Q>): Mat3x4<T, Q> where T <: Number<T>, Q <: Qualifier
func matrixCompMult<T, Q>(x: Mat4x2<T, Q>, y: Mat4x2<T, Q>): Mat4x2<T, Q> where T <: Number<T>, Q <: Qualifier
func matrixCompMult<T, Q>(x: Mat4x3<T, Q>, y: Mat4x3<T, Q>): Mat4x3<T, Q> where T <: Number<T>, Q <: Qualifier
func matrixCompMult<T, Q>(x: Mat4x4<T, Q>, y: Mat4x4<T, Q>): Mat4x4<T, Q> where T <: Number<T>, Q <: Qualifier
```

**outerProduct（9 重载，`where T <: Number<T>, Q <: Qualifier`）**：
```
func outerProduct<T, Q>(c: Vec2<T, Q>, r: Vec2<T, Q>): Mat2x2<T, Q> where T <: Number<T>, Q <: Qualifier
func outerProduct<T, Q>(c: Vec2<T, Q>, r: Vec3<T, Q>): Mat3x2<T, Q> where T <: Number<T>, Q <: Qualifier
func outerProduct<T, Q>(c: Vec2<T, Q>, r: Vec4<T, Q>): Mat4x2<T, Q> where T <: Number<T>, Q <: Qualifier
func outerProduct<T, Q>(c: Vec3<T, Q>, r: Vec2<T, Q>): Mat2x3<T, Q> where T <: Number<T>, Q <: Qualifier
func outerProduct<T, Q>(c: Vec3<T, Q>, r: Vec3<T, Q>): Mat3x3<T, Q> where T <: Number<T>, Q <: Qualifier
func outerProduct<T, Q>(c: Vec3<T, Q>, r: Vec4<T, Q>): Mat4x3<T, Q> where T <: Number<T>, Q <: Qualifier
func outerProduct<T, Q>(c: Vec4<T, Q>, r: Vec2<T, Q>): Mat2x4<T, Q> where T <: Number<T>, Q <: Qualifier
func outerProduct<T, Q>(c: Vec4<T, Q>, r: Vec3<T, Q>): Mat3x4<T, Q> where T <: Number<T>, Q <: Qualifier
func outerProduct<T, Q>(c: Vec4<T, Q>, r: Vec4<T, Q>): Mat4x4<T, Q> where T <: Number<T>, Q <: Qualifier
```

### 实现说明

**transpose**：
- 约束仅为 `where Q <: Qualifier`（无需 `Number<T>`，兼容 Bool 矩阵）
- 仅涉及元素索引重排，不涉及算术运算
- 以 Mat3x2→Mat2x3 为例：`dst.c0 = Vec3(src[0][0], src[1][0], src[2][0])`, `dst.c1 = Vec3(src[0][1], src[1][1], src[2][1])`
- 通用规则：`src[i][j]`（第 i 列第 j 行）→ `dst[j][i]`（第 j 列第 i 行）
- 9 个矩阵尺寸版本分别硬编码展开，C,R ≤ 4 无需循环
- 优先使用属性访问（`.x`/`.y`/`.z`/`.w`）而非下标访问 `[]`

**matrixCompMult**：
- 约束 `where T <: Number<T>, Q <: Qualifier`
- 逐分量相乘：`dst.c_j[i] = x.c_j[i] * y.c_j[i]`
- 9 个版本分别按列展开

**outerProduct**：
- 约束 `where T <: Number<T>, Q <: Qualifier`
- 公式 `M[j][i] = c[i] * r[j]`（i 行索引 ∈ [0, R-1]，j 列索引 ∈ [0, C-1]）
- 结果矩阵尺寸 = len(c)（行数）× len(r)（列数）
- 9 个维度组合分别展开

**stub 函数**（determinant、inverse）：
- 所有 6 个重载函数体为 `throw Exception("stub")`
- 约束 `where T <: Number<T>, Q <: Qualifier`

### 测试要求
- 创建 `tests/glm/detail/test_matrix.cj`
- transpose：对 9 个尺寸各构造非平凡矩阵验证转置正确性（如 2×3→3×2 转置后恢复验证）
- matrixCompMult：2~3 个代表性尺寸验证逐分量乘法结果
- outerProduct：2~3 个维度组合验证外积结果公式正确
- determinant/inverse：仅验证函数存在且抛出 Exception（覆盖 3 个方阵）
- 优先使用属性访问验证

### 已有代码上下文
- 9 个矩阵类型文件已就绪（type_mat2x2~type_mat4x4.cj），全部 extend 块已实现
- Vec1~Vec4 类型已就绪
- common.cj / geometric.cj 为 stub 文件（函数体 throw stub），本文件不依赖它们
- 同包内所有类型直接可见（package glm.detail）
