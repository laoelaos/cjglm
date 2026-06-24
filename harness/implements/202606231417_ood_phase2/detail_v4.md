# 详细设计（v4）

## 概述

对 6 个非方阵矩阵 skeleton 文件追加 4 个 extend 块（算术+工厂、跨类型构造、fromMat 6a×8、fromMat 6b×8），同步创建配套测试。完全复用 Mat2x2（v3 已验证 476 用例）的模式，仅尺寸和列向量类型差异。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| src/detail/type_mat2x3.cj | 修改 | Mat2x3<T,Q> 追加 4 个 extend 块 |
| src/detail/type_mat2x4.cj | 修改 | Mat2x4<T,Q> 追加 4 个 extend 块 |
| src/detail/type_mat3x2.cj | 修改 | Mat3x2<T,Q> 追加 4 个 extend 块 |
| src/detail/type_mat3x4.cj | 修改 | Mat3x4<T,Q> 追加 4 个 extend 块 |
| src/detail/type_mat4x2.cj | 修改 | Mat4x2<T,Q> 追加 4 个 extend 块 |
| src/detail/type_mat4x3.cj | 修改 | Mat4x3<T,Q> 追加 4 个 extend 块 |
| tests/glm/detail/test_type_mat2x3.cj | 新建 | 配套测试 |
| tests/glm/detail/test_type_mat2x4.cj | 新建 | 配套测试 |
| tests/glm/detail/test_type_mat3x2.cj | 新建 | 配套测试 |
| tests/glm/detail/test_type_mat3x4.cj | 新建 | 配套测试 |
| tests/glm/detail/test_type_mat4x2.cj | 新建 | 配套测试 |
| tests/glm/detail/test_type_mat4x3.cj | 新建 | 配套测试 |

## 类型维度表

| 类型 | 列向量 | C | R | length() | 对角位置 i ∈ [0,min(C,R)-1] | Vec×结果 |
|------|--------|---|---|----------|----------------------------|---------|
| Mat2x3 | Vec3 | 2 | 3 | 2 | (0,0),(1,1) | Vec3 |
| Mat2x4 | Vec4 | 2 | 4 | 2 | (0,0),(1,1) | Vec4 |
| Mat3x2 | Vec2 | 3 | 2 | 3 | (0,0),(1,1)，i=2≥R→全零列 | Vec2 |
| Mat3x4 | Vec4 | 3 | 4 | 3 | (0,0),(1,1),(2,2) | Vec4 |
| Mat4x2 | Vec2 | 4 | 2 | 4 | (0,0),(1,1)，i=2,3≥R→全零列 | Vec2 |
| Mat4x3 | Vec3 | 4 | 3 | 4 | (0,0),(1,1),(2,2)，i=3≥R→全零列 | Vec3 |

## Extend 1：算术运算符 + 工厂（`T <: Number<T>, Q <: Qualifier`）

### 全部 6 类型公共接口模板

```cangjie
extend<T, Q> Mat{C}x{R}<T, Q> where T <: Number<T>, Q <: Qualifier {
    public operator func -(): Mat{C}x{R}<T, Q> { ... }
    @OverflowWrapping public operator func +(rhs: T): Mat{C}x{R}<T, Q> { ... }
    @OverflowWrapping public operator func -(rhs: T): Mat{C}x{R}<T, Q> { ... }
    @OverflowWrapping public operator func *(rhs: T): Mat{C}x{R}<T, Q> { ... }
    @OverflowWrapping public operator func /(rhs: T): Mat{C}x{R}<T, Q> { ... }
    @OverflowWrapping public operator func +(rhs: Mat{C}x{R}<T, Q>): Mat{C}x{R}<T, Q> { ... }
    @OverflowWrapping public operator func -(rhs: Mat{C}x{R}<T, Q>): Mat{C}x{R}<T, Q> { ... }
    // 3 个跨尺寸乘法重载（见乘法表）
    @OverflowWrapping public operator func *(v: Vec{C}<T, Q>): Vec{R}<T, Q> { ... }
    public static func diagonal(scalar: T): Mat{C}x{R}<T, Q> { ... }
    public static func identity(one: T): Mat{C}x{R}<T, Q> { ... }
}
```

### 跨尺寸乘法表（每类型 3 个重载）

统一公式：`result[j][i] = sum_{k=0}^{C_left-1} left.c_k[i] * right.c_j[k]`，i=行(0..R_left-1), j=列(0..C_right-1)

| 左矩阵 | 右矩阵 | 结果 | C_left×R_left×C_right | Vec 构造 |
|--------|--------|------|----------------------|---------|
| Mat2x3 | Mat2x2 | Mat2x3 | 2×3×2 | 每结果列 Vec3: `c0.x * r.c0.x + c1.x * r.c0.y` 等 3 行×2 列 |
| Mat2x3 | Mat3x2 | Mat3x3 | 2×3×3 | 每结果列 Vec3: j=0..2 各 3 行并形成 Mat3x3 |
| Mat2x3 | Mat4x2 | Mat4x3 | 2×3×4 | 每结果列 Vec3: j=0..3，形成 Mat4x3 |
| Mat2x4 | Mat2x2 | Mat2x4 | 2×4×2 | 每结果列 Vec4: 4 行×2 列 |
| Mat2x4 | Mat3x2 | Mat3x4 | 2×4×3 | 每结果列 Vec4: 4 行×3 列→Mat3x4 |
| Mat2x4 | Mat4x2 | Mat4x4 | 2×4×4 | 每结果列 Vec4: 4 行×4 列→Mat4x4 |
| Mat3x2 | Mat2x3 | Mat2x2 | 3×2×2 | 每结果列 Vec2: `c0.x*r.c0.x + c1.x*r.c0.y + c2.x*r.c0.z` 等 |
| Mat3x2 | Mat3x3 | Mat3x2 | 3×2×3 | 每结果列 Vec2: j=0..2 |
| Mat3x2 | Mat4x3 | Mat4x2 | 3×2×4 | 每结果列 Vec2: j=0..3→Mat4x2 |
| Mat3x4 | Mat2x3 | Mat2x4 | 3×4×2 | 每结果列 Vec4: `c0.x*r.c0.x + c1.x*r.c0.y + c2.x*r.c0.z` 等 |
| Mat3x4 | Mat3x3 | Mat3x4 | 3×4×3 | 每结果列 Vec4: j=0..2 |
| Mat3x4 | Mat4x3 | Mat4x4 | 3×4×4 | 每结果列 Vec4: j=0..3→Mat4x4 |
| Mat4x2 | Mat2x4 | Mat2x2 | 4×2×2 | 每结果列 Vec2: 4 项内积 |
| Mat4x2 | Mat3x4 | Mat3x2 | 4×2×3 | 每结果列 Vec2: j=0..2 |
| Mat4x2 | Mat4x4 | Mat4x2 | 4×2×4 | 每结果列 Vec2: j=0..3 |
| Mat4x3 | Mat2x4 | Mat2x3 | 4×3×2 | 每结果列 Vec3: 4 项内积 |
| Mat4x3 | Mat3x4 | Mat3x3 | 4×3×3 | 每结果列 Vec3: j=0..2→Mat3x3 |
| Mat4x3 | Mat4x4 | Mat4x3 | 4×3×4 | 每结果列 Vec3: j=0..3 |

### Mat×Vec 乘法展开

| 类型 | 展开（result[i] = sum_{k=0}^{C-1} this.c_k[i] * v[k]） |
|------|-----------------------------------------------------|
| Mat2x3×Vec2 | Vec3(c0.x*v.x + c1.x*v.y, c0.y*v.x + c1.y*v.y, c0.z*v.x + c1.z*v.y) |
| Mat2x4×Vec2 | Vec4(c0.x*v.x + c1.x*v.y, c0.y*v.x + c1.y*v.y, c0.z*v.x + c1.z*v.y, c0.w*v.x + c1.w*v.y) |
| Mat3x2×Vec3 | Vec2(c0.x*v.x + c1.x*v.y + c2.x*v.z, c0.y*v.x + c1.y*v.y + c2.y*v.z) |
| Mat3x4×Vec3 | Vec4(c0.x*v.x + c1.x*v.y + c2.x*v.z, c0.y*v.x + c1.y*v.y + c2.y*v.z, c0.z*v.x + c1.z*v.y + c2.z*v.z, c0.w*v.x + c1.w*v.y + c2.w*v.z) |
| Mat4x2×Vec4 | Vec2(c0.x*v.x + c1.x*v.y + c2.x*v.z + c3.x*v.w, c0.y*v.x + c1.y*v.y + c2.y*v.z + c3.y*v.w) |
| Mat4x3×Vec4 | Vec3(c0.x*v.x + c1.x*v.y + c2.x*v.z + c3.x*v.w, c0.y*v.x + c1.y*v.y + c2.y*v.z + c3.y*v.w, c0.z*v.x + c1.z*v.y + c2.z*v.z + c3.z*v.w) |

### diagonal/identity 构造（对角线 one，其余 T(0)=scalar-scalar 或 one-one）

| 类型 | 列向量构造 |
|------|----------|
| Mat2x3 | `Vec3<T,Q>(scalar, zero, zero)`, `Vec3<T,Q>(zero, scalar, zero)` |
| Mat2x4 | `Vec4<T,Q>(scalar, zero, zero, zero)`, `Vec4<T,Q>(zero, scalar, zero, zero)` |
| Mat3x2 | `Vec2<T,Q>(scalar, zero)`, `Vec2<T,Q>(zero, scalar)`, `Vec2<T,Q>(zero, zero)` |
| Mat3x4 | `Vec4<T,Q>(scalar, zero, zero, zero)`, `Vec4<T,Q>(zero, scalar, zero, zero)`, `Vec4<T,Q>(zero, zero, scalar, zero)` |
| Mat4x2 | `Vec2<T,Q>(scalar, zero)`, `Vec2<T,Q>(zero, scalar)`, `Vec2<T,Q>(zero, zero)`, `Vec2<T,Q>(zero, zero)` |
| Mat4x3 | `Vec3<T,Q>(scalar, zero, zero)`, `Vec3<T,Q>(zero, scalar, zero)`, `Vec3<T,Q>(zero, zero, scalar)`, `Vec3<T,Q>(zero, zero, zero)` |

identity 与 diagonal 同结构，参数名改为 `one`。

### 一元负号/标量±*/展开

以 Mat2x3 为例（其他类型仅增大 Vec 维度）：
- 一元负号：`Mat2x3<T,Q>(-this.c0.x, -this.c0.y, -this.c0.z, -this.c1.x, -this.c1.y, -this.c1.z)`
- 标量+：`Mat2x3<T,Q>(this.c0.x+rhs, this.c0.y+rhs, this.c0.z+rhs, this.c1.x+rhs, this.c1.y+rhs, this.c1.z+rhs)`
- 矩阵+：`Mat2x3<T,Q>(this.c0.x+rhs.c0.x, ..., this.c1.z+rhs.c1.z)` — 列主序 6 参数

### 跨尺寸乘法实现示例（Mat2x3 × Mat3x2 → Mat3x3）

```cangjie
@OverflowWrapping
public operator func *(r: Mat3x2<T, Q>): Mat3x3<T, Q> {
    Mat3x3<T, Q>(
        Vec3<T, Q>(this.c0.x*r.c0.x + this.c1.x*r.c0.y, this.c0.y*r.c0.x + this.c1.y*r.c0.y, this.c0.z*r.c0.x + this.c1.z*r.c0.y),
        Vec3<T, Q>(this.c0.x*r.c1.x + this.c1.x*r.c1.y, this.c0.y*r.c1.x + this.c1.y*r.c1.y, this.c0.z*r.c1.x + this.c1.z*r.c1.y),
        Vec3<T, Q>(this.c0.x*r.c2.x + this.c1.x*r.c2.y, this.c0.y*r.c2.x + this.c1.y*r.c2.y, this.c0.z*r.c2.x + this.c1.z*r.c2.y)
    )
}
```

## Extend 2：跨类型构造（`Q <: Qualifier`）

### fromParts 签名

| 类型 | 参数 | 函数体构造 |
|------|------|-----------|
| Mat2x3 | `(conv:(U)->T, a00:U,a01:U,a02:U, a10:U,a11:U,a12:U)` | `Mat2x3(Vec3<T,Q>(conv(a00),conv(a01),conv(a02)), Vec3<T,Q>(conv(a10),conv(a11),conv(a12)))` |
| Mat2x4 | `(conv:(U)->T, a00~a03:U, a10~a13:U)` | `Mat2x4(Vec4<T,Q>(...c0...), Vec4<T,Q>(...c1...))` |
| Mat3x2 | `(conv:(U)->T, a00,a01, a10,a11, a20,a21)` | `Mat3x2(Vec2<T,Q>(...), Vec2<T,Q>(...), Vec2<T,Q>(...))` |
| Mat3x4 | `(conv:(U)->T, a00~a03, a10~a13, a20~a23)` | `Mat3x4(Vec4<T,Q>(..), Vec4<T,Q>(..), Vec4<T,Q>(..))` |
| Mat4x2 | `(conv:(U)->T, a00,a01, a10,a11, a20,a21, a30,a31)` | `Mat4x2(Vec2<T,Q>(..), ..., Vec2<T,Q>(..))` |
| Mat4x3 | `(conv:(U)->T, a00~a02, a10~a12, a20~a22, a30~a32)` | `Mat4x3(Vec3<T,Q>(..), ..., Vec3<T,Q>(..))` |

### fromColumns 签名

| 类型 | 参数（`<U,P>` + `conv:(U)->T` + 列向量） | 函数体 |
|------|----------------------------------------|--------|
| Mat2x3 | `c0:Vec3<U,P>, c1:Vec3<U,P>` | `Mat2x3(Vec3<T,Q>(conv(c0.x),conv(c0.y),conv(c0.z)), Vec3<T,Q>(conv(c1.x),conv(c1.y),conv(c1.z)))` |
| Mat2x4 | `c0:Vec4<U,P>, c1:Vec4<U,P>` | `Mat2x4(Vec4<T,Q>(conv(c0.x..w)), Vec4<T,Q>(conv(c1.x..w)))` |
| Mat3x2 | `c0:Vec2<U,P>, c1:Vec2<U,P>, c2:Vec2<U,P>` | `Mat3x2(Vec2<T,Q>(conv(c0.x),conv(c0.y)), ..., Vec2<T,Q>(conv(c2.x),conv(c2.y)))` |
| Mat3x4 | `c0:Vec4<U,P>, c1:Vec4<U,P>, c2:Vec4<U,P>` | `Mat3x4(Vec4<T,Q>(conv(c0.x..w)), ..., Vec4<T,Q>(conv(c2.x..w)))` |
| Mat4x2 | `c0~c3:Vec2<U,P>` | `Mat4x2(Vec2<T,Q>(conv(c0.x),conv(c0.y)), ..., Vec2<T,Q>(conv(c3.x),conv(c3.y)))` |
| Mat4x3 | `c0~c3:Vec3<U,P>` | `Mat4x3(Vec3<T,Q>(conv(c0.x..z)), ..., Vec3<T,Q>(conv(c3.x..z)))` |

所有 fromColumns 标注 `where P <: Qualifier`（与 Mat2x2 一致）。

### fromMat 7（跨类型同尺寸转换）

| 类型 | 签名 | 函数体 |
|------|------|--------|
| Mat2x3 | `<U,P>(conv, m:Mat2x3<U,P>)` | `Mat2x3(Vec3<T,Q>(conv(m.c0.x),conv(m.c0.y),conv(m.c0.z)), Vec3<T,Q>(conv(m.c1.x),conv(m.c1.y),conv(m.c1.z)))` |
| 其余 5 类型 | 同模式替换 Vec 类型和列数 | 逐列逐分量 conv |

所有 fromMat 7 标注 `where P <: Qualifier`。

## Extend 3：fromMat 6a（`T <: Number<T>, Q <: Qualifier`）

### 公共约束

约束 `where T <: Number<T>, Q <: Qualifier`。每个类型 8 个重载，`SrcQ` 在方法级声明：`<SrcQ> where SrcQ <: Qualifier`。T(0) 演算 `let zero = m.c0.x - m.c0.x`。

每条方向按"先列后行"组合规则推导：
1. C_src > C_dst → colShrink（保留前 C_dst 列）；C_src < C_dst → colExtend（新增列：对角线位置 j 填 one，其余 T(0)；若 j ≥ R_src 则全 T(0)）
2. R_src > R_dst → rowShrink（保留前 R_dst 分量）；R_src < R_dst → rowExtend（新增分量：对角线 i 位置 i ≥ R_src 填 one，其余 T(0)）

### Mat2x3（C_dst=2, R_dst=3）

| 源 | C_src,R_src | 操作 | 实现 |
|----|------------|------|------|
| Mat2x2 | 2,2 | B: rowExt | `Vec3(m.c0.x,m.c0.y,zero)`, `Vec3(m.c1.x,m.c1.y,zero)` |
| Mat2x4 | 2,4 | rowSh | `Vec3(m.c0.x,m.c0.y,m.c0.z)`, `Vec3(m.c1.x,m.c1.y,m.c1.z)` |
| Mat3x2 | 3,2 | colSh→rowExt | `Vec3(m.c0.x,m.c0.y,zero)`, `Vec3(m.c1.x,m.c1.y,zero)` |
| Mat3x3 | 3,3 | colSh | `Vec3(m.c0.x,m.c0.y,m.c0.z)`, `Vec3(m.c1.x,m.c1.y,m.c1.z)` |
| Mat3x4 | 3,4 | colSh→rowSh | `Vec3(m.c0.x,m.c0.y,m.c0.z)`, `Vec3(m.c1.x,m.c1.y,m.c1.z)` |
| Mat4x2 | 4,2 | colSh→rowExt | `Vec3(m.c0.x,m.c0.y,zero)`, `Vec3(m.c1.x,m.c1.y,zero)` |
| Mat4x3 | 4,3 | colSh | `Vec3(m.c0.x,m.c0.y,m.c0.z)`, `Vec3(m.c1.x,m.c1.y,m.c1.z)` |
| Mat4x4 | 4,4 | colSh→rowSh | `Vec3(m.c0.x,m.c0.y,m.c0.z)`, `Vec3(m.c1.x,m.c1.y,m.c1.z)` |

### Mat2x4（C_dst=2, R_dst=4）

| 源 | C_src,R_src | 操作 | 实现 |
|----|------------|------|------|
| Mat2x2 | 2,2 | B: rowExt | `Vec4(m.c0.x,m.c0.y,zero,zero)`, `Vec4(m.c1.x,m.c1.y,zero,zero)` |
| Mat2x3 | 2,3 | B: rowExt | `Vec4(m.c0.x,m.c0.y,m.c0.z,zero)`, `Vec4(m.c1.x,m.c1.y,m.c1.z,zero)` |
| Mat3x2 | 3,2 | colSh→rowExt | `Vec4(m.c0.x,m.c0.y,zero,zero)`, `Vec4(m.c1.x,m.c1.y,zero,zero)` |
| Mat3x3 | 3,3 | colSh→rowExt | `Vec4(m.c0.x,m.c0.y,m.c0.z,zero)`, `Vec4(m.c1.x,m.c1.y,m.c1.z,zero)` |
| Mat3x4 | 3,4 | colSh | `Vec4(m.c0.x,m.c0.y,m.c0.z,m.c0.w)`, `Vec4(m.c1.x,m.c1.y,m.c1.z,m.c1.w)` |
| Mat4x2 | 4,2 | colSh→rowExt | `Vec4(m.c0.x,m.c0.y,zero,zero)`, `Vec4(m.c1.x,m.c1.y,zero,zero)` |
| Mat4x3 | 4,3 | colSh→rowExt | `Vec4(m.c0.x,m.c0.y,m.c0.z,zero)`, `Vec4(m.c1.x,m.c1.y,m.c1.z,zero)` |
| Mat4x4 | 4,4 | colSh | `Vec4(m.c0.x,m.c0.y,m.c0.z,m.c0.w)`, `Vec4(m.c1.x,m.c1.y,m.c1.z,m.c1.w)` |

### Mat3x2（C_dst=3, R_dst=2）

| 源 | C_src,R_src | 操作 | 实现 |
|----|------------|------|------|
| Mat2x2 | 2,2 | colExt | `m.c0`, `m.c1`, `Vec2(zero,zero)` |
| Mat2x3 | 2,3 | colExt→rowSh | `Vec2(m.c0.x,m.c0.y)`, `Vec2(m.c1.x,m.c1.y)`, `Vec2(zero,zero)` |
| Mat2x4 | 2,4 | colExt→rowSh | `Vec2(m.c0.x,m.c0.y)`, `Vec2(m.c1.x,m.c1.y)`, `Vec2(zero,zero)` |
| Mat3x3 | 3,3 | rowSh | `Vec2(m.c0.x,m.c0.y)`, `Vec2(m.c1.x,m.c1.y)`, `Vec2(m.c2.x,m.c2.y)` |
| Mat3x4 | 3,4 | rowSh | `Vec2(m.c0.x,m.c0.y)`, `Vec2(m.c1.x,m.c1.y)`, `Vec2(m.c2.x,m.c2.y)` |
| Mat4x2 | 4,2 | colSh | `m.c0`, `m.c1`, `m.c2` |
| Mat4x3 | 4,3 | colSh→rowSh | `Vec2(m.c0.x,m.c0.y)`, `Vec2(m.c1.x,m.c1.y)`, `Vec2(m.c2.x,m.c2.y)` |
| Mat4x4 | 4,4 | colSh→rowSh | `Vec2(m.c0.x,m.c0.y)`, `Vec2(m.c1.x,m.c1.y)`, `Vec2(m.c2.x,m.c2.y)` |

### Mat3x4（C_dst=3, R_dst=4）

| 源 | C_src,R_src | 操作 | 实现（3 列 Vec4） |
|----|------------|------|-------------------|
| Mat2x2 | 2,2 | colExt→rowExt | `Vec4(m.c0.x,m.c0.y,zero,zero)`, `Vec4(m.c1.x,m.c1.y,zero,zero)`, `Vec4(zero,zero,one,zero)` |
| Mat2x3 | 2,3 | colExt→rowExt | `Vec4(m.c0.x,m.c0.y,m.c0.z,zero)`, `Vec4(m.c1.x,m.c1.y,m.c1.z,zero)`, `Vec4(zero,zero,one,zero)` |
| Mat2x4 | 2,4 | colExt | `m.c0`, `m.c1`, `Vec4(zero,zero,one,zero)` |
| Mat3x2 | 3,2 | B: rowExt | `Vec4(m.c0.x,m.c0.y,zero,zero)`, `Vec4(m.c1.x,m.c1.y,zero,zero)`, `Vec4(m.c2.x,m.c2.y,one,zero)` |
| Mat3x3 | 3,3 | B: rowExt | `Vec4(m.c0.x,m.c0.y,m.c0.z,zero)`, `Vec4(m.c1.x,m.c1.y,m.c1.z,zero)`, `Vec4(m.c2.x,m.c2.y,m.c2.z,zero)` |
| Mat4x2 | 4,2 | colSh→rowExt | `Vec4(m.c0.x,m.c0.y,zero,zero)`, `Vec4(m.c1.x,m.c1.y,zero,zero)`, `Vec4(m.c2.x,m.c2.y,one,zero)` |
| Mat4x3 | 4,3 | colSh→rowExt | `Vec4(m.c0.x,m.c0.y,m.c0.z,zero)`, `Vec4(m.c1.x,m.c1.y,m.c1.z,zero)`, `Vec4(m.c2.x,m.c2.y,m.c2.z,zero)` |
| Mat4x4 | 4,4 | colSh | `m.c0`, `m.c1`, `m.c2` |

### Mat4x2（C_dst=4, R_dst=2）

| 源 | C_src,R_src | 操作 | 实现（4 列 Vec2） |
|----|------------|------|-------------------|
| Mat2x2 | 2,2 | colExt | `m.c0`, `m.c1`, `Vec2(zero,zero)`, `Vec2(zero,zero)` |
| Mat2x3 | 2,3 | colExt→rowSh | `Vec2(m.c0.x,m.c0.y)`, `Vec2(m.c1.x,m.c1.y)`, `Vec2(zero,zero)`, `Vec2(zero,zero)` |
| Mat2x4 | 2,4 | colExt→rowSh | `Vec2(m.c0.x,m.c0.y)`, `Vec2(m.c1.x,m.c1.y)`, `Vec2(zero,zero)`, `Vec2(zero,zero)` |
| Mat3x2 | 3,2 | colExt | `m.c0`, `m.c1`, `m.c2`, `Vec2(zero,zero)` |
| Mat3x3 | 3,3 | colExt→rowSh | `Vec2(m.c0.x,m.c0.y)`, `Vec2(m.c1.x,m.c1.y)`, `Vec2(m.c2.x,m.c2.y)`, `Vec2(zero,zero)` |
| Mat3x4 | 3,4 | colExt→rowSh | `Vec2(m.c0.x,m.c0.y)`, `Vec2(m.c1.x,m.c1.y)`, `Vec2(m.c2.x,m.c2.y)`, `Vec2(zero,zero)` |
| Mat4x3 | 4,3 | rowSh | `Vec2(m.c0.x,m.c0.y)`, `Vec2(m.c1.x,m.c1.y)`, `Vec2(m.c2.x,m.c2.y)`, `Vec2(m.c3.x,m.c3.y)` |
| Mat4x4 | 4,4 | rowSh | `Vec2(m.c0.x,m.c0.y)`, `Vec2(m.c1.x,m.c1.y)`, `Vec2(m.c2.x,m.c2.y)`, `Vec2(m.c3.x,m.c3.y)` |

### Mat4x3（C_dst=4, R_dst=3）

| 源 | C_src,R_src | 操作 | 实现（4 列 Vec3） |
|----|------------|------|-------------------|
| Mat2x2 | 2,2 | colExt→rowExt | `Vec3(m.c0.x,m.c0.y,zero)`, `Vec3(m.c1.x,m.c1.y,zero)`, `Vec3(zero,zero,one)`, `Vec3(zero,zero,zero)` |
| Mat2x3 | 2,3 | colExt | `m.c0`, `m.c1`, `Vec3(zero,zero,one)`, `Vec3(zero,zero,zero)` |
| Mat2x4 | 2,4 | colExt→rowSh | `Vec3(m.c0.x,m.c0.y,m.c0.z)`, `Vec3(m.c1.x,m.c1.y,m.c1.z)`, `Vec3(zero,zero,one)`, `Vec3(zero,zero,zero)` |
| Mat3x2 | 3,2 | colExt→rowExt | `Vec3(m.c0.x,m.c0.y,zero)`, `Vec3(m.c1.x,m.c1.y,zero)`, `Vec3(m.c2.x,m.c2.y,one)`, `Vec3(zero,zero,zero)` |
| Mat3x3 | 3,3 | colExt | `m.c0`, `m.c1`, `m.c2`, `Vec3(zero,zero,zero)` |
| Mat3x4 | 3,4 | colExt→rowSh | `Vec3(m.c0.x,m.c0.y,m.c0.z)`, `Vec3(m.c1.x,m.c1.y,m.c1.z)`, `Vec3(m.c2.x,m.c2.y,m.c2.z)`, `Vec3(zero,zero,zero)` |
| Mat4x2 | 4,2 | B: rowExt | `Vec3(m.c0.x,m.c0.y,zero)`, `Vec3(m.c1.x,m.c1.y,zero)`, `Vec3(m.c2.x,m.c2.y,one)`, `Vec3(m.c3.x,m.c3.y,zero)` |
| Mat4x4 | 4,4 | rowSh | `Vec3(m.c0.x,m.c0.y,m.c0.z)`, `Vec3(m.c1.x,m.c1.y,m.c1.z)`, `Vec3(m.c2.x,m.c2.y,m.c2.z)`, `Vec3(m.c3.x,m.c3.y,m.c3.z)` |

## Extend 4：fromMat 6b（`T <: Number<T>, Q <: Qualifier`，跨类型）

与 Extend 3（fromMat 6a）完全同构的方向映射，仅以下差异：
1. 额外参数 `conv: (U) -> T` + 类型参数 `U, P`
2. T(0) 演算使用 `let zero = one - one`（因 m.c0.x 类型为 U）
3. 签名 `<U, P>` 在方法级声明，`where P <: Qualifier`
4. 每列构造中对每个源元素应用 conv（如 `conv(m.c0.x)`）

以 Mat2x3 的 Mat2x2 源方向为例（6b 版本）：
```cangjie
public static func fromMat<U, P>(conv: (U) -> T, m: Mat2x2<U, P>, one: T): Mat2x3<T, Q>
  where P <: Qualifier {
    let zero = one - one
    Mat2x3<T, Q>(Vec3<T, Q>(conv(m.c0.x), conv(m.c0.y), zero), Vec3<T, Q>(conv(m.c1.x), conv(m.c1.y), zero))
}
```

其余方向与 6a 表一一对应，仅替换上述差异。

**偏差声明**：Mat4x4←Mat4x2 的 fromMat 不在本任务范围内（该偏差属 Mat4x4 方阵的 fromMat，由 T5 实现）。本任务中只有 Mat4x2 被其他类型引用（作为 fromMat 源），不实现 Mat4x2→Mat4x4 的 fromMat 6a/6b——这个方向在 Mat4x4 的 extend 中实现。

## 错误处理

- `[]` 取值/赋值越界时 assert + throw Exception（skeleton 已有）
- 所有算术运算符标注 `@OverflowWrapping`，整数溢出静默截断
- 未使用参数（`zero` 变量，`one` 参数）保留以保持 API 统一，编译产生预期 warning
- 无矩阵除法（非方阵不提供 `/` 运算符）

## 行为契约

- 所有运算符返回新实例，不修改 `this`
- `diagonal(scalar)`：对角线 `i∈[0,min(C,R)-1]` 填 scalar，其余 T(0)=scalar-scalar
- `identity(one)`：同 diagonal，参数名为 `one`
- `fromMat 6a/6b`：先列后行组合规则，colExt 新增列对角线 j 填 one（若 j<R_src），rowExt 新增分量对角线 i 填 one（若 i≥R_src 且 i<R_dst）
- 6a 使用 `m.c0.x - m.c0.x` 演算 T(0)，6b 使用 `one - one` 演算 T(0)
- 所有 VecN/Mat 构造显式标注 `<T, Q>` 或 `<T,Q>` 类型参数

## 依赖关系

所有 6 个非方阵类型仅依赖同包已有类型：Vec2/3/4<T,Q>、Qualifier、Number<T>、以及同包的其他矩阵类型（跨尺寸乘法和 fromMat 的源类型）。无 common.cj/matrix.cj/geometric.cj 依赖——与 OOD 设计文档一致。

## 测试文件设计

每个测试文件（`tests/glm/detail/test_type_mat{N}x{M}.cj`）覆盖以下类别（参照 test_type_mat2x2.cj 模式，含 43+ 用例）：

| 类别 | 测试项 | 说明 |
|------|--------|------|
| 构造 | 标量填充 init | 全部分量等于 scalar |
| 构造 | 逐分量 const init | 按列主序匹配 |
| 构造 | 列向量 const init | 各列与传入一致 |
| length | length() | 返回 C |
| 下标 | 取值/赋值/越界 | 参照 Mat2x2 测试 |
| col | col() 取值/越界 | 参照 Mat2x2 测试 |
| 一元负号 | `-m` | 逐分量取反 |
| 矩阵-标量 | + - * / | 逐分量运算 |
| 矩阵-矩阵 ± | 同尺寸加减 | 逐分量 |
| 矩阵-矩阵 × | 3 个跨尺寸乘法重载 | 按乘法公式展开 |
| 矩阵×Vec | Mat×VecC | 结果 VecR |
| diagonal | 对角线填充 | 对角=scalar，非对角=0 |
| identity | 单位矩阵 | 对角=one，非对角=0 |
| fromParts | 跨类型逐分量 | 经 conv 转换 |
| fromColumns | 跨类型列向量 | 经 conv 转换 |
| fromMat 7 | 跨类型同尺寸 | 各分量 conv |
| fromMat 6a | 8 方向各选 1 代表 | 收缩/扩展正确 |
| fromMat 6b | 8 方向各选 1 代表 | 收缩+conv 正确 |

每个测试文件具体用例可参照 test_type_mat2x2.cj 按尺寸适配（Vec2→Vec3/Vec4，列数 2→3/4）。

## 修订说明（v4 r1）
| 审查意见 | 修改措施 |
|---------|---------|
| Extend 3 Mat3x4 表中 Mat2x3 源方向 `Vec4(zero,zero,zero,one)` 错误 — colExt 新列 j=2 对角线应在 Vec4 索引 2 | 修正为 `Vec4(zero,zero,one,zero)` |
| Extend 3 Mat3x4 表中 Mat3x2 源方向 `Vec4(m.c2.x,m.c2.y,zero,zero)` 错误 — rowExt 对角线 (2,2) 应为 `one` | 修正为 `Vec4(m.c2.x,m.c2.y,one,zero)` |
| Extend 3 Mat3x4 表中 Mat4x2 源方向 `Vec4(m.c2.x,m.c2.y,zero,zero)` 错误 — rowExt 对角线 (2,2) 应为 `one` | 修正为 `Vec4(m.c2.x,m.c2.y,one,zero)` |
| Extend 3 Mat4x3 表中 Mat3x2 源方向列 2 `Vec3(m.c2.x,m.c2.y,zero)` 错误 — rowExt 对角线 (2,2) | 修正为 `Vec3(m.c2.x,m.c2.y,one)`；同时列 3 中的 `Vec3(zero,zero,one)` 修正为 `Vec3(zero,zero,zero)`（colExt 新列 j=3≥R_src=2 全 T(0)） |
| Extend 3 Mat4x3 表中 Mat4x2 源方向 `Vec3(m.c2.x,m.c2.y,zero)` 错误 — rowExt 对角线 (2,2) | 修正为 `Vec3(m.c2.x,m.c2.y,one)` |
| Extend 3 Mat4x3 表中 Mat3x3 源方向 `Vec3(zero,zero,one)` 错误 — colExt 新列 j=3≥R_src=3 应全 T(0) | 修正为 `Vec3(zero,zero,zero)` |
| Extend 3 Mat4x3 表中 Mat3x4 源方向 `Vec3(zero,zero,one)` 错误 — colExt 新列的 `one` 在 Vec4 位置 3，被 rowSh 截断 | 修正为 `Vec3(zero,zero,zero)` |
