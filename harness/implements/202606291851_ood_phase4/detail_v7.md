# 详细设计（v7）

## 概述

将 `src/detail/matrix.cj` 中第 167~173 行的 6 个 stub（`determinant` Mat2x2/Mat3x3/Mat4x4 + `inverse` Mat2x2/Mat3x3/Mat4x4）替换为完整实现。同时修改 `tests/glm/detail/matrix_test.cj` 中对应的 6 个 stub 测试为真实测试，补充 Float32/Float64 浮点覆盖和奇异矩阵 NaN 传播验证。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `src/detail/matrix.cj` | 修改（替换 6 个 stub） | 实现 determinant 和 inverse |
| `tests/glm/detail/matrix_test.cj` | 修改（替换 6 个 stub 测试） | 真实测试用例 |

## 类型定义

### determinant Mat2x2

**形态**：包级泛型函数
**包路径**：`glm.detail`

```cangjie
public func determinant<T, Q>(m: Mat2x2<T, Q>): T where T <: Number<T>, Q <: Qualifier
```

**约束**：`T <: Number<T>`（纯算术运算——乘法和减法）

**实现公式**：`m.c0.x * m.c1.y - m.c1.x * m.c0.y`

### determinant Mat3x3

**形态**：包级泛型函数
**包路径**：`glm.detail`

```cangjie
public func determinant<T, Q>(m: Mat3x3<T, Q>): T where T <: Number<T>, Q <: Qualifier
```

**约束**：`T <: Number<T>`

**实现公式**：标量三重积展开

```
m.c0.x * (m.c1.y * m.c2.z - m.c2.y * m.c1.z)
- m.c1.x * (m.c0.y * m.c2.z - m.c2.y * m.c0.z)
+ m.c2.x * (m.c0.y * m.c1.z - m.c1.y * m.c0.z)
```

### determinant Mat4x4

**形态**：包级泛型函数
**包路径**：`glm.detail`

```cangjie
public func determinant<T, Q>(m: Mat4x4<T, Q>): T where T <: Number<T>, Q <: Qualifier
```

**约束**：`T <: Number<T>`

**实现公式**：拉普拉斯展开（沿第一列展开），预计算 6 个 2×2 子式（SubFactor00~05）后组合。计算公式：

```
SubFactor00 = m.c2.z * m.c3.w - m.c3.z * m.c2.w
SubFactor01 = m.c2.y * m.c3.w - m.c3.y * m.c2.w
SubFactor02 = m.c2.y * m.c3.z - m.c3.y * m.c2.z
SubFactor03 = m.c2.x * m.c3.w - m.c3.x * m.c2.w
SubFactor04 = m.c2.x * m.c3.z - m.c3.x * m.c2.z
SubFactor05 = m.c2.x * m.c3.y - m.c3.x * m.c2.y

result = m.c0.x * (m.c1.y * SubFactor00 - m.c1.z * SubFactor01 + m.c1.w * SubFactor02)
       - m.c0.y * (m.c1.x * SubFactor00 - m.c1.z * SubFactor03 + m.c1.w * SubFactor04)
       + m.c0.z * (m.c1.x * SubFactor01 - m.c1.y * SubFactor03 + m.c1.w * SubFactor05)
       - m.c0.w * (m.c1.x * SubFactor02 - m.c1.y * SubFactor04 + m.c1.z * SubFactor05)
```

### inverse Mat2x2

**形态**：包级泛型函数
**包路径**：`glm.detail`

```cangjie
public func inverse<T, Q>(m: Mat2x2<T, Q>): Mat2x2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
```

**约束**：`T <: FloatingPoint<T>`（需要除法 `1/det`）

**实现公式**：标准 2×2 逆矩阵公式 `1/det * [[d, -c], [-b, a]]`

```
let det = determinant(m)
let invDet = T(Float64(1)) / det
Mat2x2(Vec2(m.c1.y * invDet, -m.c0.y * invDet),
       Vec2(-m.c1.x * invDet, m.c0.x * invDet))
```

### inverse Mat3x3

**形态**：包级泛型函数
**包路径**：`glm.detail`

```cangjie
public func inverse<T, Q>(m: Mat3x3<T, Q>): Mat3x3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
```

**约束**：`T <: FloatingPoint<T>`

**实现公式**：余子式矩阵 ÷ 行列式。共 9 个余子式，每个为 2×2 子式，按转置关系填充到结果矩阵的列向量中。

```
let det = determinant(m)
let invDet = T(Float64(1)) / det
Mat3x3(
    Vec3((m.c1.y * m.c2.z - m.c2.y * m.c1.z) * invDet,
         -(m.c1.x * m.c2.z - m.c2.x * m.c1.z) * invDet,
         (m.c1.x * m.c2.y - m.c2.x * m.c1.y) * invDet),
    Vec3(-(m.c0.y * m.c2.z - m.c2.y * m.c0.z) * invDet,
         (m.c0.x * m.c2.z - m.c2.x * m.c0.z) * invDet,
         -(m.c0.x * m.c2.y - m.c2.x * m.c0.y) * invDet),
    Vec3((m.c0.y * m.c1.z - m.c1.y * m.c0.z) * invDet,
         -(m.c0.x * m.c1.z - m.c1.x * m.c0.z) * invDet,
         (m.c0.x * m.c1.y - m.c1.x * m.c0.y) * invDet)
)
```

### inverse Mat4x4

**形态**：包级泛型函数
**包路径**：`glm.detail`

```cangjie
public func inverse<T, Q>(m: Mat4x4<T, Q>): Mat4x4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
```

**约束**：`T <: FloatingPoint<T>`

**实现公式**：余子式展开（cofactor expansion），与 GLM 1.0.3 `func_matrix.inl` 第 388~446 行 `compute_inverse<4,4,T,Q,Aligned>` 一致。预先计算 18 个 2×2 子式（SubFactor00~17），然后组合为 16 个余子式，除以行列式后填入结果矩阵的 4 个列向量。

预计算子式：
```
let SubFactor00 = m.c2.z * m.c3.w - m.c3.z * m.c2.w
let SubFactor01 = m.c2.y * m.c3.w - m.c3.y * m.c2.w
let SubFactor02 = m.c2.y * m.c3.z - m.c3.y * m.c2.z
let SubFactor03 = m.c2.x * m.c3.w - m.c3.x * m.c2.w
let SubFactor04 = m.c2.x * m.c3.z - m.c3.x * m.c2.z
let SubFactor05 = m.c2.x * m.c3.y - m.c3.x * m.c2.y
let SubFactor06 = m.c1.z * m.c3.w - m.c3.z * m.c1.w
let SubFactor07 = m.c1.y * m.c3.w - m.c3.y * m.c1.w
let SubFactor08 = m.c1.y * m.c3.z - m.c3.y * m.c1.z
let SubFactor09 = m.c1.x * m.c3.w - m.c3.x * m.c1.w
let SubFactor10 = m.c1.x * m.c3.z - m.c3.x * m.c1.z
let SubFactor11 = m.c1.x * m.c3.y - m.c3.x * m.c1.y
let SubFactor12 = m.c1.z * m.c2.w - m.c2.z * m.c1.w
let SubFactor13 = m.c1.y * m.c2.w - m.c2.y * m.c1.w
let SubFactor14 = m.c1.y * m.c2.z - m.c2.y * m.c1.z
let SubFactor15 = m.c1.x * m.c2.w - m.c2.x * m.c1.w
let SubFactor16 = m.c1.x * m.c2.z - m.c2.x * m.c1.z
let SubFactor17 = m.c1.x * m.c2.y - m.c2.x * m.c1.y
```

结果矩阵（adjugate / det）列向量：
```
let det = determinant(m)
let invDet = T(Float64(1)) / det
Mat4x4(
    // c0: cofactors of row 0 (transposed)
    Vec4(
        ( m.c1.y * SubFactor00 - m.c1.z * SubFactor01 + m.c1.w * SubFactor02) * invDet,
        (-m.c1.x * SubFactor00 + m.c1.z * SubFactor03 - m.c1.w * SubFactor04) * invDet,
        ( m.c1.x * SubFactor01 - m.c1.y * SubFactor03 + m.c1.w * SubFactor05) * invDet,
        (-m.c1.x * SubFactor02 + m.c1.y * SubFactor04 - m.c1.z * SubFactor05) * invDet
    ),
    // c1: cofactors of row 1 (transposed)
    Vec4(
        (-m.c0.y * SubFactor00 + m.c0.z * SubFactor01 - m.c0.w * SubFactor02) * invDet,
        ( m.c0.x * SubFactor00 - m.c0.z * SubFactor03 + m.c0.w * SubFactor04) * invDet,
        (-m.c0.x * SubFactor01 + m.c0.y * SubFactor03 - m.c0.w * SubFactor05) * invDet,
        ( m.c0.x * SubFactor02 - m.c0.y * SubFactor04 + m.c0.z * SubFactor05) * invDet
    ),
    // c2: cofactors of row 2 (transposed)
    Vec4(
        ( m.c0.y * SubFactor06 - m.c0.z * SubFactor07 + m.c0.w * SubFactor08) * invDet,
        (-m.c0.x * SubFactor06 + m.c0.z * SubFactor09 - m.c0.w * SubFactor10) * invDet,
        ( m.c0.x * SubFactor07 - m.c0.y * SubFactor09 + m.c0.w * SubFactor11) * invDet,
        (-m.c0.x * SubFactor08 + m.c0.y * SubFactor10 - m.c0.z * SubFactor11) * invDet
    ),
    // c3: cofactors of row 3 (transposed)
    Vec4(
        (-m.c0.y * SubFactor12 + m.c0.z * SubFactor13 - m.c0.w * SubFactor14) * invDet,
        ( m.c0.x * SubFactor12 - m.c0.z * SubFactor15 + m.c0.w * SubFactor16) * invDet,
        (-m.c0.x * SubFactor13 + m.c0.y * SubFactor15 - m.c0.w * SubFactor17) * invDet,
        ( m.c0.x * SubFactor14 - m.c0.y * SubFactor16 + m.c0.z * SubFactor17) * invDet
    )
)
```

## 导入声明

```cangjie
package glm.detail

import std.math.{ Number, FloatingPoint }
```

当前文件（matrix.cj）已有 `import std.math.{ Number }`，需追加 `FloatingPoint`。

## 错误处理

| 场景 | 策略 |
|------|------|
| 奇异矩阵求逆（det ≈ 0） | 无显式检查。IEEE 754 自然传播：det=0 → 1/det=Inf → Inf×0=NaN → NaN 填充整个结果矩阵 |
| 非奇异矩阵正常求逆 | 返回正确逆矩阵 |
| determinant 在整数类型上的行为 | mat2x2/mat3x3/mat4x4 的 determinant 仅在 `Number<T>` 约束下工作，整数类型可用（乘减运算） |

## 行为契约

- `determinant`：纯函数，无副作用。约束 `T <: Number<T>`，整数和浮点类型均可使用
- `inverse`：纯函数，无副作用。约束 `T <: FloatingPoint<T>`（需要除法）。整数矩阵不可求逆
- **奇异矩阵**：inverse 不抛出异常，由 IEEE 754 浮点运算自然产生 NaN 填充矩阵
- **inverse 与 determinant 的一致性**：`determinant(inverse(m))` 理论上等于 `1/determinant(m)`（数值误差范围内）

## 依赖关系

| 被依赖项 | 来源 | 用途 |
|---------|------|------|
| `Mat2x2<T, Q>` | `glm.detail`（type_mat2x2.cj） | determinant/inverse 输入和输出类型 |
| `Mat3x3<T, Q>` | `glm.detail`（type_mat3x3.cj） | determinant/inverse 输入和输出类型 |
| `Mat4x4<T, Q>` | `glm.detail`（type_mat4x4.cj） | determinant/inverse 输入和输出类型 |
| `Vec2<T, Q>` | `glm.detail`（type_vec2.cj） | 构造 Mat2x2 列向量 |
| `Vec3<T, Q>` | `glm.detail`（type_vec3.cj） | 构造 Mat3x3 列向量 |
| `Vec4<T, Q>` | `glm.detail`（type_vec4.cj） | 构造 Mat4x4 列向量 |
| `Number<T>` | `std.math` | determinant 泛型约束（算术运算） |
| `FloatingPoint<T>` | `std.math` | inverse 泛型约束（浮点除法） |

## 测试设计

### 测试文件修改计划

替换 `tests/glm/detail/matrix_test.cj:257-321` 的 6 个 stub 测试为真实测试。

### 测试用例矩阵

| 测试函数 | 类型 | 覆盖场景 |
|---------|------|---------|
| `testDeterminantMat2x2` | `Int64` | 已知 2×2 矩阵的行列式计算 |
| `testDeterminantMat3x3` | `Int64` | 已知 3×3 矩阵的行列式计算 |
| `testDeterminantMat4x4` | `Int64` | 已知 4×4 矩阵的行列式计算（含零值） |
| `testDeterminantMat2x2Float32` | `Float32` | 浮点行列式 Float32 覆盖 |
| `testDeterminantMat2x2Float64` | `Float64` | 浮点行列式 Float64 覆盖 |
| `testInverseMat2x2` | `Float32` | 2×2 逆矩阵，验证 `m * inverse(m) ≈ identity` |
| `testInverseMat3x3` | `Float32` | 3×3 逆矩阵，验证 `m * inverse(m) ≈ identity` |
| `testInverseMat4x4` | `Float32` | 4×4 逆矩阵（单位矩阵逆），验证 `inverse(identity) = identity` |
| `testInverseMat4x4Full` | `Float32` | 4×4 满秩矩阵逆，验证 `m * inverse(m) ≈ identity`（矩阵乘法分两路径） |
| `testInverseMat2x2Float32` | `Float32` | 2×2 逆 Float32 覆盖 |
| `testInverseMat2x2Float64` | `Float64` | 2×2 逆 Float64 覆盖 |
| `testInverseMat3x3Float32` | `Float32` | 3×3 逆 Float32 覆盖 |
| `testInverseMat3x3Float64` | `Float64` | 3×3 逆 Float64 覆盖 |
| `testInverseMat4x4Float32` | `Float32` | 4×4 逆 Float32 覆盖（恒等/满秩） |
| `testInverseMat4x4Float64` | `Float64` | 4×4 逆 Float64 覆盖 |
| `testInverseSingularMat2x2NaN` | `Float32` | 奇异 2×2 逆 → NaN 传播验证 |
| `testInverseSingularMat3x3NaN` | `Float32` | 奇异 3×3 逆 → NaN 传播验证 |
| `testInverseSingularMat4x4NaN` | `Float64` | 奇异 4×4 逆 → NaN 传播验证 |

### NaN 验证策略

奇异矩阵（行列式为零）求逆的结果包含 NaN。验证方式：对结果的每个分量检查 `r != r` —— 在 IEEE 754 中 NaN 是唯一不等于自身的值。

### 恒等式验证

对于可逆矩阵 `m`，验证 `(inverse(m) * m)` 的每个分量与单位矩阵的对应分量近似相等（使用 epsilon 容差）。

对于 2×2/3×3/4×4，不直接使用 `*` 运算符（可能存在泛型约束问题），改为手动逐分量计算积矩阵后比较对角线为 `T(1)`、非对角线为 `T(0)`。

## 仓颉限制导致的偏差说明

1. **`inverse` 约束从 `Number<T>` 变为 `FloatingPoint<T>`**：当前 6 个 stub 均使用 `T <: Number<T>`。`determinant` 可以保持 `Number<T>`（仅有乘减），但 `inverse` 需要除法（`T(Float64(1)) / det`），`Number<T>` 不保证除法可用。本设计将 inverse 的约束改为 `FloatingPoint<T>`。

2. **`T(Float64(1))` 字面量构造**：遵循项目约定，使用 `T(Float64(1))` 替代 `T(1)` 构造泛型字面量 1。

3. **奇异矩阵 NaN 传播**：依赖 IEEE 754 的自然传播，无显式零行列式检查。此行为与 OOD 设计一致，不需要特殊处理。
