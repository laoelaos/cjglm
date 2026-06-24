# 任务指令（v5）

## 动作
NEW

## 任务描述
对 2 个方阵骨架文件（type_mat3x3.cj + type_mat4x4.cj）各追加 4 个 extend 块，同步追加配套测试。具体：

### src/detail/type_mat3x3.cj（修改，追加以下 extend 块）

**Extend 1**（`T <: Number<T>, Q <: Qualifier`）：算术运算符 + 工厂
- 一元负号 `-(): Mat3x3<T,Q>`
- 标量 `+`, `-`, `*`, `/` 各一（`rhs: T`）
- 矩阵-矩阵 `+`, `-`（`rhs: Mat3x3<T,Q>`）
- 跨尺寸矩阵乘法 ×3：
  - `*(r: Mat2x3<T,Q>): Mat2x3<T,Q>`
  - `*(r: Mat3x3<T,Q>): Mat3x3<T,Q>`
  - `*(r: Mat4x3<T,Q>): Mat4x3<T,Q>`
- 矩阵-矩阵除法 `/`: `throw Exception("stub")`（直接 stub，不调用 inverse）
- 矩阵×向量 `*(v: Vec3<T,Q>): Vec3<T,Q>`
- `diagonal(scalar: T): Mat3x3<T,Q>` — 3 列 Vec3，对角填 scalar，其余 zero=scalar-scalar
- `identity(one: T): Mat3x3<T,Q>` — 委托 diagonal(one)

**Extend 2**（`Q <: Qualifier`）：跨类型构造
- `fromParts<U>(conv, a00~a22: U): Mat3x3<T,Q>` — 9 个参数按列主序
- `fromColumns<U,P>(conv, c0,c1,c2: Vec3<U,P>): Mat3x3<T,Q> where P <: Qualifier`
- `fromMat<U,P>(conv, m: Mat3x3<U,P>): Mat3x3<T,Q> where P <: Qualifier`

**Extend 3**（`T <: Number<T>, Q <: Qualifier`）：fromMat 6a 同类型不同尺寸
8 个源类型：Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x4, Mat4x2, Mat4x3, Mat4x4
每个签名 `<SrcQ>(m: Mat{C}x{R}<T,SrcQ>, one: T): Mat3x3<T,Q> where SrcQ <: Qualifier`
- zero = m.c0.x - m.c0.x
- 先列后行按组合规则展开

**Extend 4**（`T <: Number<T>, Q <: Qualifier`）：fromMat 6b 跨类型不同尺寸
8 个源类型同上。签名 `<U,P>(conv, m: ..., one: T): ... where P <: Qualifier`
- zero = one - one
- 每列每分量应用 conv

### src/detail/type_mat4x4.cj（修改，追加以下 extend 块）

**Extend 1**（`T <: Number<T>, Q <: Qualifier`）：算术运算符 + 工厂
- 一元负号 `-(): Mat4x4<T,Q>`
- 标量 `+`, `-`, `*`, `/` 各一
- 矩阵-矩阵 `+`, `-`（`rhs: Mat4x4<T,Q>`）
- 跨尺寸矩阵乘法 ×3：
  - `*(r: Mat2x4<T,Q>): Mat2x4<T,Q>`
  - `*(r: Mat3x4<T,Q>): Mat3x4<T,Q>`
  - `*(r: Mat4x4<T,Q>): Mat4x4<T,Q>`
- 矩阵-矩阵除法 `/`: `throw Exception("stub")`
- 矩阵×向量 `*(v: Vec4<T,Q>): Vec4<T,Q>`
- `diagonal(scalar: T): Mat4x4<T,Q>`
- `identity(one: T): Mat4x4<T,Q>` — 委托 diagonal(one)

**Extend 2**（`Q <: Qualifier`）：跨类型构造
- `fromParts<U>(conv, a00~a33: U): Mat4x4<T,Q>` — 16 个参数按列主序
- `fromColumns<U,P>(conv, c0,c1,c2,c3: Vec4<U,P>): Mat4x4<T,Q> where P <: Qualifier`
- `fromMat<U,P>(conv, m: Mat4x4<U,P>): Mat4x4<T,Q> where P <: Qualifier`

**Extend 3**（`T <: Number<T>, Q <: Qualifier`）：fromMat 6a
8 个源类型：Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3
- zero = m.c0.x - m.c0.x
- 先列后行组合规则展开
- **🚨 偏差：Mat4x4←Mat4x2 特殊处理**：colSh→rowExt 标准规则不适用，改为 GLM type_mat4x4.inl:246 行为：
  - nc0 = Vec4<T,Q>(m.c0.x, m.c0.y, zero, zero)
  - nc1 = Vec4<T,Q>(m.c1.x, m.c1.y, zero, zero)
  - nc2 = Vec4<T,Q>(zero, zero, one, zero)
  - nc3 = Vec4<T,Q>(zero, zero, zero, one)

**Extend 4**（`T <: Number<T>, Q <: Qualifier`）：fromMat 6b
8 个源类型同上。zero = one - one，每分量 conv。
- **🚨 偏差：Mat4x4←Mat4x2** 同上 GLM 特殊处理

### 测试文件（修改）

**tests/glm/detail/test_type_mat3x3.cj** — 追加以下测试类别（参照 test_type_mat2x2.cj 模式，约 43+ 用例）：
- 构造：标量填充 init（已存在）、逐分量 const init（已存在）、列向量 const init（已存在）
- length()（已存在）
- 下标取值/赋值/越界（已存在）
- col() 取值/越界/负索引
- 一元负号 `-m`
- 矩阵-标量 + - * /
- 矩阵-矩阵 ±（同尺寸）
- 跨尺寸乘法 ×3（Mat3x3×Mat2x3→Mat2x3、Mat3x3×Mat3x3→Mat3x3、Mat3x3×Mat4x3→Mat4x3）
- Mat3x3×Vec3
- diagonal / identity
- fromParts / fromColumns / fromMat 7
- fromMat 6a（8 方向各选 1 代表）
- fromMat 6b（8 方向各选 1 代表）

**tests/glm/detail/test_type_mat4x4.cj** — 同上模式追加（约 45+ 用例），额外：
- 跨尺寸乘法 ×3（Mat4x4×Mat2x4→Mat2x4、Mat4x4×Mat3x4→Mat3x4、Mat4x4×Mat4x4→Mat4x4）
- Mat4x4×Vec4
- fromMat 6a 中的 Mat4x4←Mat4x2 偏差方向单独验证

## 选择理由
剩余 2 个方阵是矩阵类型实现中最后的"完整功能"闭合任务。实现模式与 T3（Mat2x2）和 T4（6 个非方阵）的 4 个 extend 块模式完全一致，仅乘法和 fromMat 展开差异。方阵不依赖 matrix.cj/common.cj/geometric.cj——除法直接 throw stub，fromMat 独立展开。完成后所有 9 个矩阵类型将具备完整功能。

## 任务上下文
- 设计文档：`C:\Develop\Software\cjglm_wp\docs\04_ood_phase2.md`
  - §3.1：矩阵结构体定义
  - §3.3 item 1~5：构造函数
  - §3.3 item 6a/6b：fromMat 6a/6b 转换规则和 9×9 转换矩阵表（含 Mat4x4←Mat4x2 偏差）
  - §3.3 item 7：fromMat 7 跨类型同尺寸
  - §3.4：行列访问
  - §3.5：算术运算符 + 27 乘法重载表
  - §3.6：比较运算符
- Mat2x2 完整实现（type_mat2x2.cj）可作为 extend 块模式参考
- 非方阵 T4 的 detail_v4.md 可作为 fromMat 6a/6b 展开模式参考
- type_mat3x3.cj 现有骨架（53 行）和 type_mat4x4.cj 现有骨架（59 行）已包含结构体、构造、length、[]、col

## 已有的现有代码上下文

### type_mat3x3.cj 骨架（skeleton）
- 结构体 Mat3x3<T,Q> with c0/c1/c2: Vec3<T,Q>
- 3 个构造函数：逐分量 9 参数、列向量 3 参数、scalar 填充
- length() = 3, [] get/set (match), col()

### type_mat4x4.cj 骨架（skeleton）
- 结构体 Mat4x4<T,Q> with c0/c1/c2/c3: Vec4<T,Q>
- 3 个构造函数：逐分量 16 参数、列向量 4 参数、scalar 填充
- length() = 4, [] get/set (match), col()

### type_mat2x2.cj（已实现的完整参考）
247 行，4 个 extend 块：
1. Number<T>,Q: 一元负号,标量±*/,矩阵±,跨尺寸乘法×3(Mat2x2/3x2/4x2),Mat×Vec2,除法/(stub),diagonal,identity
2. Q: fromParts,fromColumns,fromMat7
3. Number<T>,Q: fromMat 6a×8（2x3/2x4/3x2/3x3/3x4/4x2/4x3/4x4）
4. Number<T>,Q: fromMat 6b×8

### 方阵乘法表（来自设计文档 §3.5）
- Mat3x3×Mat2x3 → Mat2x3
- Mat3x3×Mat3x3 → Mat3x3
- Mat3x3×Mat4x3 → Mat4x3
- Mat4x4×Mat2x4 → Mat2x4
- Mat4x4×Mat3x4 → Mat3x4
- Mat4x4×Mat4x4 → Mat4x4

### fromMat 9×9 转换矩阵表（来自设计文档）
| 源 | →Mat3x3 | →Mat4x4 |
|---|---------|---------|
| Mat2x2 (2×2) | colExt(3)→rowExt | colExt(4)→rowExt |
| Mat2x3 (2×3) | colExt(3) | colExt(4)→rowExt |
| Mat2x4 (2×4) | colExt(3)→rowSh | colExt(4) |
| Mat3x2 (3×2) | B: rowExt(3) | colExt(4)→rowExt |
| Mat3x3 (3×3) | EQL | colExt(4)→rowExt |
| Mat3x4 (3×4) | rowSh | colExt(4) |
| Mat4x2 (4×2) | colSh→rowExt | 🚨 DEVIATION |
| Mat4x3 (4×3) | colSh | B: rowExt(4) |
| Mat4x4 (4×4) | colSh→rowSh | EQL |
