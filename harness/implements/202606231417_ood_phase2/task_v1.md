# 任务指令（v1）

## 动作
NEW

## 任务描述
创建两个 pure stub 文件，为阶段二的矩阵类型提供函数库依赖闭合。

### 文件 1：`src/detail/common.cj`
package glm.detail。包含以下 13 个纯 stub 函数（函数体均 `throw Exception("stub")`）：

| 函数 | 约束 | 重载数 |
|------|------|--------|
| `func min<T>(a: T, b: T): T` | `T <: Number<T> & Comparable<T>` | 1 |
| `func max<T>(a: T, b: T): T` | `T <: Number<T> & Comparable<T>` | 1 |
| `func abs<T>(a: T): T` | `T <: Number<T> & Comparable<T>` | 1 |
| `func sign<T>(a: T): T` | `T <: Number<T> & Comparable<T>` | 1 |
| `func floor<T>(a: T): T` | `T <: Number<T>` | 1 |
| `func ceil<T>(a: T): T` | `T <: Number<T>` | 1 |
| `func fract<T>(a: T): T` | `T <: Number<T>` | 1 |
| `func mod<T>(a: T, b: T): T` | `T <: Integer<T>`（因 Number<T> 无 `%` 运算符，参 DV-02） | 1 |
| `func clamp<T>(a: T, minVal: T, maxVal: T): T` | `T <: Number<T> & Comparable<T>` | 1 |
| `func mix<T>(a: T, b: T, t: T): T` | `T <: Number<T>` | 1 |
| `func step<T>(edge: T, x: T): T` | `T <: Number<T> & Comparable<T>` | 1 |
| `func smoothstep<T>(edge0: T, edge1: T, x: T): T` | `T <: Number<T> & Comparable<T>` | 1 |

### 文件 2：`src/detail/geometric.cj`
package glm.detail。包含以下 17 个纯 stub 函数（函数体均 `throw Exception("stub")`）：

| 函数 | 签名 | 重载数 |
|------|------|--------|
| `dot` | `(x: Vec1/2/3/4<T,Q>, y: Vec1/2/3/4<T,Q>): T` where `T <: Number<T>, Q <: Qualifier` | 4 |
| `cross` | `(x: Vec3<T,Q>, y: Vec3<T,Q>): Vec3<T,Q>` where `T <: Number<T>, Q <: Qualifier` | 1 |
| `normalize` | `(v: Vec2/3/4<T,Q>): Vec2/3/4<T,Q>` where `T <: Number<T>, Q <: Qualifier` | 3 |
| `length` | `(v: Vec2/3/4<T,Q>): T` where `T <: Number<T>, Q <: Qualifier` | 3 |
| `distance` | `(p0: Vec2/3/4<T,Q>, p1: Vec2/3/4<T,Q>): T` where `T <: Number<T>, Q <: Qualifier` | 3 |
| `reflect` | `(I: Vec2/3/4<T,Q>, N: Vec2/3/4<T,Q>): Vec2/3/4<T,Q>` where `T <: Number<T>, Q <: Qualifier` | 3 |

## 选择理由
底层依赖优先——common.cj 和 geometric.cj 是阶段二所有文件的依赖基座，无任何其他包内依赖。type_mat3x3.cj 依赖 common.cj，type_mat4x4.cj 依赖 geometric.cj，必须先创建这两个 stub 文件方可编译方阵类型。

## 任务上下文
- 设计文档 §3.7 详细说明了 stub 文件的所有函数签名
- common.cj 的 `mod<T>` 签名约束为 `Integer<T>` 而非 `Number<T>`，因为 `Number<T>` 不提供 `%` 运算符（参 deviations.md DV-02）
- geometric.cj 不包含 Vec1 版本的 normalize/length/distance/reflect（设计文档 §3.7 标注为阶段四潜在覆盖差异）
- 所有 stub 函数体统一为 `{ throw Exception("stub") }`

## 已有代码上下文
- `src/detail/` 目录已有 setup.cj、qualifier.cj、type_vec1~4.cj 等基础设施
- Vec1~Vec4 类型已定义完毕（`package glm.detail`），函数签名可直接使用 Vec1/2/3/4<T,Q> 作为参数和返回类型
- 同一包内所有文件自动可见，无需 import（都是 `package glm.detail`）

## 注意事项
- 两个文件均为 `package glm.detail`，与已有 Vec 类型文件同包
- 函数体统一为 `throw Exception("stub")`
- common.cj 只包含标量版本（向量版本推迟至阶段四）
- geometric.cj 不包含 Vec1 版本 normalize/length/distance/reflect，不包含 Vec2 cross（2D 叉积推迟至阶段六）
