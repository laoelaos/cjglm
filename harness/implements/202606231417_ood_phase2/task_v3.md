# 任务指令（v3）

## 动作
NEW

## 任务描述
实现 `src/detail/type_mat2x2.cj` 完整文件——Mat2x2<T,Q> 结构体定义（参照 skeleton 模式，2 列 × 2 行，列向量 Vec2<T,Q>）及以下 extend 块中的全部接口：

### 结构体内（非 extend）
- 3 个基础构造函数：标量填充 init、逐分量 const init(a00, a01, a10, a11)、列向量 const init(c0, c1)
- `public static func length(): Int64 { 2 }`
- `[]` 取值/赋值运算符
- `col()` 访问器

### 第一个 extend 块：`where T <: Number<T>, Q <: Qualifier`
- 一元负号 `operator func -()`
- 矩阵-标量：`+(rhs: T)`, `-(rhs: T)`, `*(rhs: T)`, `/(rhs: T)` ——标注 @OverflowWrapping
- 矩阵-矩阵：`+(rhs: Mat2x2)`, `-(rhs: Mat2x2)`（同尺寸加减）——标注 @OverflowWrapping
- 矩阵-矩阵乘：`*(rhs: Mat2x2) -> Mat2x2`, `*(rhs: Mat3x2) -> Mat3x2`, `*(rhs: Mat4x2) -> Mat4x2`（3 个重载，跨尺寸乘法按 OOD 公式展开）——标注 @OverflowWrapping
- 矩阵除法：`/(rhs: Mat2x2)` 实现为 `this * inverse(rhs)`（inverse 为 stub，运行时 throw）
- 矩阵×Vec2：`operator func *(v: Vec2<T,Q>): Vec2<T,Q>`——标注 @OverflowWrapping
- `diagonal(scalar: T)` — 对角矩阵工厂（对角线=scalar，非对角线=T(0)=scalar-scalar）
- `identity(one: T)` — 单位矩阵工厂

### 第二个 extend 块：`where Q <: Qualifier`（无需 Number 约束）
- `fromParts<U>(conv: (U) -> T, a00: U, a01: U, a10: U, a11: U)` — 跨类型逐分量构造
- `fromColumns<U, P>(conv: (U) -> T, c0: Vec2<U,P>, c1: Vec2<U,P>)` — 跨类型列向量构造
- `fromMat<U, P>(conv: (U) -> T, m: Mat2x2<U,P>)` — 跨类型同尺寸转换（fromMat 7）

### 第三个 extend 块：`where T <: Number<T>, Q <: Qualifier, SrcQ <: Qualifier`
- fromMat 6a —— 同类型不同尺寸（共 8 个重载，源矩阵 = Mat2x3/2x4/3x2/3x3/3x4/4x2/4x3/4x4，各参数 `m: Mat{C}x{R}<T,SrcQ>, one: T`）

### 第四个 extend 块：`where T <: Number<T>, Q <: Qualifier, P <: Qualifier`
- fromMat 6b —— 跨类型不同尺寸（共 8 个重载，源矩阵 = Mat2x3/2x4/3x2/3x3/3x4/4x2/4x3/4x4，各参数 `conv: (U) -> T, m: Mat{C}x{R}<U,P>, one: T`）

### 测试文件
- 创建 `tests/glm/detail/test_type_mat2x2.cj`
- 覆盖：构造（3 种方式）、length、下标访问/赋值、col、一元负号、矩阵-标量 ±*/、矩阵-矩阵 ±*/（含跨尺寸乘）、矩阵×Vec2、diagonal、identity、fromParts、fromColumns、fromMat 6a/6b/7（各 1 个代表性方向）、越界异常

## 选择理由
Mat2x2 是矩阵运算的核心入口（2D 仿射变换基础），其 fromMat 6a/6b 共 16 个重载引用 T2 完成的 8 个 skeleton 类型，是验证 T2 骨架闭合的最小完备测试。实现 Mat2x2 后，非方阵（T4）和方阵（T5）的实现可参照其模式。

## 任务上下文
- 设计文档 §3.1（结构体定义）、§3.3（构造/工厂/fromMat 完整体系）、§3.4（行列访问）、§3.5（算术运算符，含 27 个乘法重载表）
- Mat2x2 结构体：2 列，列向量 Vec2<T,Q>，列主序存储
- 泛型约束 Q <: Qualifier 确保类型限定符参数有效
- fromMat 6a T(0) 演算：`m.c0.x - m.c0.x`（因 `m.c0.x` 类型为 T）
- fromMat 6b T(0) 演算：`one - one`（因 `m.c0.x` 类型为 U，须用目标类型 T 的 `one` 参数）
- 属性访问优先于下标访问：使用 `.x`/`.y` 而非 `[0]`/`[1]`，避免 assert 开销
- `@OverflowWrapping` 标注所有算术运算符

## 已有代码上下文
- `src/detail/type_vec2.cj` — Vec2<T,Q> 已完整定义（含 extend 运算符块），可直接使用
- `src/detail/type_mat2x3~4x4.cj` — 8 个 skeleton 文件（仅结构体 + 基础构造 + 下标 + col），无 extend 块
- 同包可见（glm.detail），无需 import 即可引用
- 类型约束模式参照 Vec 类型：`where T <: Number<T>, Q <: Qualifier`
