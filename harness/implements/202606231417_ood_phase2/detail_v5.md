# 详细设计（v5）

## 概述

对 2 个方阵骨架文件（type_mat3x3.cj、type_mat4x4.cj）各追加 4 个 extend 块（算术+工厂、跨类型构造、fromMat 6a×8、fromMat 6b×8），同步追加配套测试。完全复用 Mat2x2（v3 已验证）和非方阵（v4 已验证）的模式，仅尺寸和列向量类型差异。Mat3x3（C=3,R=3）、Mat4x4（C=4,R=4）。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| src/detail/type_mat3x3.cj | 修改 | Mat3x3<T,Q> 追加 4 个 extend 块 |
| src/detail/type_mat4x4.cj | 修改 | Mat4x4<T,Q> 追加 4 个 extend 块 |
| tests/glm/detail/test_type_mat3x3.cj | 修改 | 追加算术/工厂/跨类型/fromMat 测试 |
| tests/glm/detail/test_type_mat4x4.cj | 修改 | 追加算术/工厂/跨类型/fromMat 测试 |

## 类型维度表

| 类型 | 列向量 | C | R | length() | 对角位置 | Vec×结果 |
|------|--------|---|---|----------|---------|---------|
| Mat3x3 | Vec3 | 3 | 3 | 3 | (0,0),(1,1),(2,2) | Vec3 |
| Mat4x4 | Vec4 | 4 | 4 | 4 | (0,0),(1,1),(2,2),(3,3) | Vec4 |

## Extend 1：算术运算符 + 工厂（`T <: Number<T>, Q <: Qualifier`）

### Mat3x3 公共接口模板

```cangjie
extend<T, Q> Mat3x3<T, Q> where T <: Number<T>, Q <: Qualifier {
    public operator func -(): Mat3x3<T, Q> { ... }
    @OverflowWrapping public operator func +(rhs: T): Mat3x3<T, Q> { ... }
    @OverflowWrapping public operator func -(rhs: T): Mat3x3<T, Q> { ... }
    @OverflowWrapping public operator func *(rhs: T): Mat3x3<T, Q> { ... }
    @OverflowWrapping public operator func /(rhs: T): Mat3x3<T, Q> { ... }
    @OverflowWrapping public operator func +(rhs: Mat3x3<T, Q>): Mat3x3<T, Q> { ... }
    @OverflowWrapping public operator func -(rhs: Mat3x3<T, Q>): Mat3x3<T, Q> { ... }
    @OverflowWrapping public operator func *(r: Mat2x3<T, Q>): Mat2x3<T, Q> { ... }
    @OverflowWrapping public operator func *(r: Mat3x3<T, Q>): Mat3x3<T, Q> { ... }
    @OverflowWrapping public operator func *(r: Mat4x3<T, Q>): Mat4x3<T, Q> { ... }
    @OverflowWrapping public operator func /(rhs: Mat3x3<T, Q>): Mat3x3<T, Q> { throw Exception("stub") }
    @OverflowWrapping public operator func *(v: Vec3<T, Q>): Vec3<T, Q> { ... }
    public static func diagonal(scalar: T): Mat3x3<T, Q> { ... }
    public static func identity(one: T): Mat3x3<T, Q> { diagonal(one) }
}
```

### Mat4x4 公共接口模板

```cangjie
extend<T, Q> Mat4x4<T, Q> where T <: Number<T>, Q <: Qualifier {
    public operator func -(): Mat4x4<T, Q> { ... }
    @OverflowWrapping public operator func +(rhs: T): Mat4x4<T, Q> { ... }
    @OverflowWrapping public operator func -(rhs: T): Mat4x4<T, Q> { ... }
    @OverflowWrapping public operator func *(rhs: T): Mat4x4<T, Q> { ... }
    @OverflowWrapping public operator func /(rhs: T): Mat4x4<T, Q> { ... }
    @OverflowWrapping public operator func +(rhs: Mat4x4<T, Q>): Mat4x4<T, Q> { ... }
    @OverflowWrapping public operator func -(rhs: Mat4x4<T, Q>): Mat4x4<T, Q> { ... }
    @OverflowWrapping public operator func *(r: Mat2x4<T, Q>): Mat2x4<T, Q> { ... }
    @OverflowWrapping public operator func *(r: Mat3x4<T, Q>): Mat3x4<T, Q> { ... }
    @OverflowWrapping public operator func *(r: Mat4x4<T, Q>): Mat4x4<T, Q> { ... }
    @OverflowWrapping public operator func /(rhs: Mat4x4<T, Q>): Mat4x4<T, Q> { throw Exception("stub") }
    @OverflowWrapping public operator func *(v: Vec4<T, Q>): Vec4<T, Q> { ... }
    public static func diagonal(scalar: T): Mat4x4<T, Q> { ... }
    public static func identity(one: T): Mat4x4<T, Q> { diagonal(one) }
}
```

### 跨尺寸乘法展开

统一公式：`result[j][i] = sum_{k=0}^{C_left-1} left.c_k[i] * right.c_j[k]`

**Mat3x3 乘法表（C_left=3, R_left=3）：**

| 右矩阵 | 结果 | 展开（每列 Vec3） |
|--------|------|-----------------|
| Mat2x3 (2列) | Mat2x3 | `c0[i]*r.c0.x + c1[i]*r.c0.y + c2[i]*r.c0.z` → 2列 |
| Mat3x3 (3列) | Mat3x3 | `c0[i]*r.cj.x + c1[i]*r.cj.y + c2[i]*r.cj.z` → 3列 |
| Mat4x3 (4列) | Mat4x3 | `c0[i]*r.cj.x + c1[i]*r.cj.y + c2[i]*r.cj.z` → 4列 |

Mat3x3×Mat3x3 标准方阵乘法展开示例：
```cangjie
let nc0 = Vec3<T, Q>(
    this.c0.x * r.c0.x + this.c1.x * r.c0.y + this.c2.x * r.c0.z,
    this.c0.y * r.c0.x + this.c1.y * r.c0.y + this.c2.y * r.c0.z,
    this.c0.z * r.c0.x + this.c1.z * r.c0.y + this.c2.z * r.c0.z)
let nc1 = Vec3<T, Q>(
    this.c0.x * r.c1.x + this.c1.x * r.c1.y + this.c2.x * r.c1.z,
    this.c0.y * r.c1.x + this.c1.y * r.c1.y + this.c2.y * r.c1.z,
    this.c0.z * r.c1.x + this.c1.z * r.c1.y + this.c2.z * r.c1.z)
let nc2 = Vec3<T, Q>(
    this.c0.x * r.c2.x + this.c1.x * r.c2.y + this.c2.x * r.c2.z,
    this.c0.y * r.c2.x + this.c1.y * r.c2.y + this.c2.y * r.c2.z,
    this.c0.z * r.c2.x + this.c1.z * r.c2.y + this.c2.z * r.c2.z)
```

**Mat4x4 乘法表（C_left=4, R_left=4）：**

| 右矩阵 | 结果 | 展开（每列 Vec4） |
|--------|------|-----------------|
| Mat2x4 (2列) | Mat2x4 | `c0[i]*r.c0.x + c1[i]*r.c0.y + c2[i]*r.c0.z + c3[i]*r.c0.w` → 2列 |
| Mat3x4 (3列) | Mat3x4 | `c0[i]*r.c0.x + c1[i]*r.c0.y + c2[i]*r.c0.z + c3[i]*r.c0.w` → 3列 |
| Mat4x4 (4列) | Mat4x4 | `c0[i]*r.c0.x + c1[i]*r.c0.y + c2[i]*r.c0.z + c3[i]*r.c0.w` → 4列 |

### Mat×Vec 乘法

- Mat3x3×Vec3：`Vec3<T,Q>(c0.x*v.x + c1.x*v.y + c2.x*v.z, c0.y*v.x + c1.y*v.y + c2.y*v.z, c0.z*v.x + c1.z*v.y + c2.z*v.z)`
- Mat4x4×Vec4：`Vec4<T,Q>(c0.x*v.x + c1.x*v.y + c2.x*v.z + c3.x*v.w, c0.y*v.x + c1.y*v.y + c2.y*v.z + c3.y*v.w, c0.z*v.x + c1.z*v.y + c2.z*v.z + c3.z*v.w, c0.w*v.x + c1.w*v.y + c2.w*v.z + c3.w*v.w)`

### 一元负号/标量±*/展开

以 Mat3x3 9 参数构造为例（Mat4x4 同模式，16 参数）：
- 一元负号：`Mat3x3(-c0.x, -c0.y, -c0.z, -c1.x, -c1.y, -c1.z, -c2.x, -c2.y, -c2.z)`
- 标量+：`Mat3x3(c0.x+rhs, c0.y+rhs, c0.z+rhs, c1.x+rhs, c1.y+rhs, c1.z+rhs, c2.x+rhs, c2.y+rhs, c2.z+rhs)`
- 矩阵+：`Mat3x3(c0.x+rhs.c0.x, ..., c2.z+rhs.c2.z)` — 列主序 9 参数

### diagonal/identity

方阵：所有 C 列均在对角位置填入 scalar/one，其余为 zero（scalar-scalar）。

**Mat3x3**：`Vec3<T,Q>(scalar, zero, zero)`, `Vec3<T,Q>(zero, scalar, zero)`, `Vec3<T,Q>(zero, zero, scalar)`

**Mat4x4**：`Vec4<T,Q>(scalar, zero, zero, zero)`, `Vec4<T,Q>(zero, scalar, zero, zero)`, `Vec4<T,Q>(zero, zero, scalar, zero)`, `Vec4<T,Q>(zero, zero, zero, scalar)`

## Extend 2：跨类型构造（`Q <: Qualifier`）

### Mat3x3 扩展

**fromParts**：`<U>(conv, a00:U, a01:U, a02:U, a10:U, a11:U, a12:U, a20:U, a21:U, a22:U): Mat3x3<T,Q>`
- 函数体：`Mat3x3(Vec3<T,Q>(conv(a00),conv(a01),conv(a02)), Vec3<T,Q>(conv(a10),conv(a11),conv(a12)), Vec3<T,Q>(conv(a20),conv(a21),conv(a22)))`

**fromColumns**：`<U,P>(conv, c0:Vec3<U,P>, c1:Vec3<U,P>, c2:Vec3<U,P>): Mat3x3<T,Q> where P <: Qualifier`
- 函数体：`Mat3x3(Vec3<T,Q>(conv(c0.x),conv(c0.y),conv(c0.z)), Vec3<T,Q>(conv(c1.x),conv(c1.y),conv(c1.z)), Vec3<T,Q>(conv(c2.x),conv(c2.y),conv(c2.z)))`

**fromMat 7**：`<U,P>(conv, m:Mat3x3<U,P>): Mat3x3<T,Q> where P <: Qualifier`
- 函数体：`Mat3x3(Vec3<T,Q>(conv(m.c0.x),conv(m.c0.y),conv(m.c0.z)), Vec3<T,Q>(conv(m.c1.x),conv(m.c1.y),conv(m.c1.z)), Vec3<T,Q>(conv(m.c2.x),conv(m.c2.y),conv(m.c2.z)))`

### Mat4x4 扩展

**fromParts**：`<U>(conv, a00~a03:U, a10~a13:U, a20~a23:U, a30~a33:U): Mat4x4<T,Q>`
- 函数体：构造 4 个 Vec4 列向量，每列逐分量 conv

**fromColumns**：`<U,P>(conv, c0~c3:Vec4<U,P>): Mat4x4<T,Q> where P <: Qualifier`

**fromMat 7**：`<U,P>(conv, m:Mat4x4<U,P>): Mat4x4<T,Q> where P <: Qualifier`

## Extend 3：fromMat 6a（`T <: Number<T>, Q <: Qualifier`）

### 公共约束

`T <: Number<T>, Q <: Qualifier`，源 qualifier 在方法级声明 `<SrcQ> where SrcQ <: Qualifier`。T(0) 演算 `let zero = m.c0.x - m.c0.x`。

### Mat3x3（C_dst=3, R_dst=3）

| 源类型 | 操作 | 实现 |
|--------|------|------|
| Mat2x2 (2×2) | colExt(3)→rowExt | `Vec3(m.c0.x,m.c0.y,zero)`, `Vec3(m.c1.x,m.c1.y,zero)`, `Vec3(zero,zero,one)` |
| Mat2x3 (2×3) | colExt(3) | `Vec3(m.c0.x,m.c0.y,m.c0.z)`, `Vec3(m.c1.x,m.c1.y,m.c1.z)`, `Vec3(zero,zero,one)` |
| Mat2x4 (2×4) | colExt(3)→rowSh | `Vec3(m.c0.x,m.c0.y,m.c0.z)`, `Vec3(m.c1.x,m.c1.y,m.c1.z)`, `Vec3(zero,zero,one)` |
| Mat3x2 (3×2) | B: rowExt(3) | `Vec3(m.c0.x,m.c0.y,zero)`, `Vec3(m.c1.x,m.c1.y,zero)`, `Vec3(m.c2.x,m.c2.y,one)` |
| Mat3x4 (3×4) | rowSh | `Vec3(m.c0.x,m.c0.y,m.c0.z)`, `Vec3(m.c1.x,m.c1.y,m.c1.z)`, `Vec3(m.c2.x,m.c2.y,m.c2.z)` |
| Mat4x2 (4×2) | colSh→rowExt | `Vec3(m.c0.x,m.c0.y,zero)`, `Vec3(m.c1.x,m.c1.y,zero)`, `Vec3(m.c2.x,m.c2.y,one)` |
| Mat4x3 (4×3) | colSh | `Vec3(m.c0.x,m.c0.y,m.c0.z)`, `Vec3(m.c1.x,m.c1.y,m.c1.z)`, `Vec3(m.c2.x,m.c2.y,m.c2.z)` |
| Mat4x4 (4×4) | colSh→rowSh | `Vec3(m.c0.x,m.c0.y,m.c0.z)`, `Vec3(m.c1.x,m.c1.y,m.c1.z)`, `Vec3(m.c2.x,m.c2.y,m.c2.z)` |

### Mat4x4（C_dst=4, R_dst=4）

| 源类型 | 操作 | 实现 |
|--------|------|------|
| Mat2x2 (2×2) | colExt(4)→rowExt | `Vec4(m.c0.x,m.c0.y,zero,zero)`, `Vec4(m.c1.x,m.c1.y,zero,zero)`, `Vec4(zero,zero,one,zero)`, `Vec4(zero,zero,zero,one)` |
| Mat2x3 (2×3) | colExt(4)→rowExt | `Vec4(m.c0.x,m.c0.y,m.c0.z,zero)`, `Vec4(m.c1.x,m.c1.y,m.c1.z,zero)`, `Vec4(zero,zero,one,zero)`, `Vec4(zero,zero,zero,one)` |
| Mat2x4 (2×4) | colExt(4) | `Vec4(m.c0.x..w)`, `Vec4(m.c1.x..w)`, `Vec4(zero,zero,one,zero)`, `Vec4(zero,zero,zero,one)` |
| Mat3x2 (3×2) | colExt(4)→rowExt | `Vec4(m.c0.x,m.c0.y,zero,zero)`, `Vec4(m.c1.x,m.c1.y,zero,zero)`, `Vec4(m.c2.x,m.c2.y,one,zero)`, `Vec4(zero,zero,zero,one)` |
| Mat3x3 (3×3) | colExt(4)→rowExt | `Vec4(m.c0.x,m.c0.y,m.c0.z,zero)`, `Vec4(m.c1.x,m.c1.y,m.c1.z,zero)`, `Vec4(m.c2.x,m.c2.y,m.c2.z,zero)`, `Vec4(zero,zero,zero,one)` |
| Mat3x4 (3×4) | colExt(4) | `Vec4(m.c0.x..w)`, `Vec4(m.c1.x..w)`, `Vec4(m.c2.x..w)`, `Vec4(zero,zero,zero,one)` |
| Mat4x2 (4×2) | 🚨 **DEVIATION** | `Vec4(m.c0.x,m.c0.y,zero,zero)`, `Vec4(m.c1.x,m.c1.y,zero,zero)`, `Vec4(zero,zero,one,zero)`, `Vec4(zero,zero,zero,one)` |
| Mat4x3 (4×3) | B: rowExt(4) | `Vec4(m.c0.x,m.c0.y,m.c0.z,zero)`, `Vec4(m.c1.x,m.c1.y,m.c1.z,zero)`, `Vec4(m.c2.x,m.c2.y,m.c2.z,zero)`, `Vec4(m.c3.x,m.c3.y,m.c3.z,one)` |

**🚨 偏差说明（Mat4x4←Mat4x2）**：遵循 GLM type_mat4x4.inl:246，colSh→rowExt 标准规则不适用。列 2、3 丢弃源矩阵前两行数据，直接构造单位矩阵列（位置 (2,2)=one、(3,3)=one）。

## Extend 4：fromMat 6b（`T <: Number<T>, Q <: Qualifier`，跨类型）

与 Extend 3（fromMat 6a）完全同构的方向映射，仅以下差异：
1. 额外参数 `conv: (U) -> T` + 类型参数 `U, P`
2. T(0) 演算使用 `let zero = one - one`（因 m.c0.x 类型为 U）
3. 签名 `<U, P>` 在方法级声明，`where P <: Qualifier`
4. 每列构造中对每个源元素应用 conv

以 Mat3x3 的 Mat2x2 源方向为例（6b 版本）：
```cangjie
public static func fromMat<U, P>(conv: (U) -> T, m: Mat2x2<U, P>, one: T): Mat3x3<T, Q>
  where P <: Qualifier {
    let zero = one - one
    Mat3x3<T, Q>(Vec3<T, Q>(conv(m.c0.x), conv(m.c0.y), zero),
                 Vec3<T, Q>(conv(m.c1.x), conv(m.c1.y), zero),
                 Vec3<T, Q>(zero, zero, one))
}
```

Mat4x4←Mat4x2 的 6b 偏差方向同 6a GLM 特殊处理，每分量应用 conv。

其余方向与 6a 表一一对应，仅替换上述差异。

## 错误处理

- `[]` 取值/赋值越界时 assert + throw Exception（skeleton 已有）
- 所有算术运算符标注 `@OverflowWrapping`
- 矩阵除法 `throw Exception("stub")`（依赖 inverse，尚未实现）

## 行为契约

- 所有运算符返回新实例，不修改 `this`
- `diagonal(scalar)`：对角线填 scalar，其余 T(0)=scalar-scalar
- `identity(one)`：委托 diagonal(one)
- `fromMat 6a/6b`：先列后行组合规则，Mat4x4←Mat4x2 使用 GLM 偏差处理
- 6a 使用 `m.c0.x - m.c0.x` 演算 T(0)，6b 使用 `one - one` 演算 T(0)
- 所有 Vec/Mat 构造显式标注 `<T, Q>` 类型参数

## 依赖关系

Mat3x3 和 Mat4x4 类型仅依赖同包已有类型：Vec3/Vec4<T,Q>、Qualifier、Number<T>、以及其他矩阵类型（跨尺寸乘法和 fromMat 的源类型）。无 common.cj/matrix.cj/geometric.cj 依赖（/ 运算符为 throw stub，无需 inverse）。

## 测试设计

### test_type_mat3x3.cj（追加，参照 test_type_mat2x2.cj 模式，约 50+ 用例）

| 类别 | 测试项 | 说明 |
|------|--------|------|
| 构造 | 标量填充 init | 已存在 |
| 构造 | 逐分量 const init | 已存在 |
| 构造 | 列向量 const init | 已存在 |
| length | length() | 已存在 |
| 下标 | 取值/赋值/越界/负索引 | 已存在 |
| col | col() 取值 | 已存在 |
| 一元负号 | `-m` | 逐分量取反 |
| 矩阵-标量 | + - * / | 逐分量 |
| 矩阵-矩阵 ± | 同尺寸加减 | 逐分量 Vec3 |
| 矩阵-矩阵 × | Mat3x3×Mat2x3→Mat2x3, Mat3x3×Mat3x3→Mat3x3, Mat3x3×Mat4x3→Mat4x3 | 3 个重载 |
| 矩阵-矩阵 / | 除法 stub | throw Exception |
| 矩阵×Vec | Mat3x3×Vec3 | Vec3 结果 |
| diagonal | 对角填充 | 对角=scalar |
| identity | 单位矩阵 | 对角=one |
| fromParts | 跨类型逐分量 | 9 参数 conv |
| fromColumns | 跨类型列向量 | 3 列 conv |
| fromMat 7 | 跨类型同尺寸 | 逐分量 conv |
| fromMat 6a | 8 方向各选 1 代表 | 收缩/扩展正确 |
| fromMat 6b | 8 方向各选 1 代表 | 收缩+conv 正确 |

### test_type_mat4x4.cj（追加，约 55+ 用例）

同上模式，额外：
- 跨尺寸乘法：Mat4x4×Mat2x4→Mat2x4, Mat4x4×Mat3x4→Mat3x4, Mat4x4×Mat4x4→Mat4x4
- fromMat 6a 中 Mat4x4←Mat4x2 偏差方向单独验证（确认列 2=Vec4(0,0,1,0), 列 3=Vec4(0,0,0,1)）
- fromMat 6b 中 Mat4x4←Mat4x2 偏差方向单独验证
