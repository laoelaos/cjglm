# 详细设计（v8）

## 概述

将 11 个源文件中全部 stub（约 100 个）替换为完整实现，新建 3 个源文件（ext/vector_common.cj、gtc/matrix_inverse.cj、gtc/matrix_access.cj），并为所有变更相应编写/更新测试。合并原 plan.md Tasks 7~17 为一轮。

**重要偏差提示**（给 Coder）：
1. `std.math.sqrt(...)` 全限定语法不可用 → 使用 `import std.math as math` + `math.sqrt(...)`（IMPL-06）
2. `sqrtT` 已在 `stdmath_shim.cj` 中提供，`type_quat_cast.cj` 的私有 `sqrtT` 已删除（IMPL-01）
3. `FloatingPoint<T>` 约束下不能用 `==` 比较泛型 T → 转为 Float64 后比较（IMPL-03）
4. `Float32.toBits().toInt32()` 不存在 → 用 `(x.toBits() as Int32).getOrThrow()`（IMPL-04）
5. `Float64.toInt64()` 不存在 → 用 `(xF64 as Int64).getOrThrow()`（IMPL-05）
6. `epsilonOf`/`epsilon` 需要 hint 参数（DV-04），已在 `detail/scalar_constants.cj` 的 `epsilon<T>()` 中处理好
7. `Comparable` 自动导入，不需要显式 import（IMPL-02）
8. Float64→Float16 转型溢出时 `(result as T).getOrThrow()` 抛异常而非返回 ±Inf（D29）
9. `stdmath_shim.cj` 的 `sqrtT`/`sinT`/`cosT`/`tanT` 等函数当前为包级可见性（无 `public`），不可被 `glm.ext`/`glm.gtc` 导入。需将这些函数改为 `public func`（方案 A）。同时 `ext/quaternion_geometric.cj` 和 `ext/quaternion_trigonometric.cj` 中已存在的私有 `sqrtT` 副本需移除，改为 `import glm.detail.sqrtT`

## 文件规划

### A. 修改现有 stub → 完整实现

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `src/detail/geometric.cj` | 修改（21 stub → 完整实现） | dot/cross/normalize/length/distance/reflect/refract/faceforward |
| `src/ext/matrix_transform.cj` | 修改（1 stub → 6 函数完整） | translate/rotate/scale/shear/lookAt/lookAtRH/lookAtLH |
| `src/ext/matrix_clip_space.cj` | 修改（1 stub → 46 函数完整） | ortho/frustum/perspective/perspectiveFov/infinitePerspective/tweakedInfinitePerspective |
| `src/ext/matrix_projection.cj` | 修改（1 stub → 7 函数完整） | projectZO/NO/unProjectZO/NO/pickMatrix |
| `src/ext/quaternion_common.cj` | 修改（3 stub → 完整实现） | mix/slerp/slerp(k) |
| `src/ext/quaternion_trigonometric.cj` | 修改（2 stub → 完整实现） | angle/angleAxis |
| `src/ext/quaternion_transform.cj` | 修改（1 stub → 完整实现） | rotate |
| `src/gtc/matrix_transform.cj` | 修改（64 stub → 完整实现） | 全部基础/ortho/frustum/perspective/.../pickMatrix 函数 |

### B. 新建文件

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `src/ext/vector_common.cj` | 新建 | 20 个向量扩展函数（min/max/fmin/fmax/fclamp 3/4 输入 + 纹理环绕 + iround/uround） |
| `src/gtc/matrix_inverse.cj` | 新建 | affineInverse/inverseTranspose |
| `src/gtc/matrix_access.cj` | 新建 | row/column（9 种矩阵重载） |

### C. 修改现有测试文件

| 文件路径 | 操作 |
|---------|------|
| `tests/glm/detail/geometric_test.cj` | 21 stub → 真实测试 |
| `tests/glm/detail/geometric_refract_test.cj` | 3 stub → 真实测试 |
| `tests/glm/ext/quaternion_common_test.cj` | 3 stub → 真实（mix/slerp/slerp(k)） |
| `tests/glm/ext/quaternion_trigonometric_test.cj` | 2 stub → 真实（angle/angleAxis） |
| `tests/glm/ext/quaternion_transform_test.cj` | 若存在 stub 则替换 |
| `tests/glm/gtc/matrix_transform_test.cj` | 若存在 stub 则替换 |

### D. 新建测试文件

| 文件路径 | 说明 |
|---------|------|
| `tests/glm/ext/vector_common_test.cj` | 向量扩展函数测试 |
| `tests/glm/ext/matrix_transform_test.cj` | ext/matrix_transform 测试 |
| `tests/glm/ext/matrix_clip_space_test.cj` | ext/matrix_clip_space 测试 |
| `tests/glm/ext/matrix_projection_test.cj` | ext/matrix_projection 测试 |
| `tests/glm/gtc/matrix_inverse_test.cj` | affineInverse + inverseTranspose 测试 |
| `tests/glm/gtc/matrix_access_test.cj` | row/column 测试 |

---

## A.1 src/detail/geometric.cj

### dot

**形态**：包级泛型函数（共 4 重载）
**包路径**：`glm.detail`

```cangjie
public func dot<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>): T where T <: Number<T>, Q <: Qualifier
public func dot<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>): T where T <: Number<T>, Q <: Qualifier
public func dot<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>): T where T <: Number<T>, Q <: Qualifier
public func dot<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>): T where T <: Number<T>, Q <: Qualifier
```

**约束**：`T <: Number<T>`, `Q <: Qualifier`（不变）

**实现**：
- Vec1: `x.x * y.x`
- Vec2: `x.x * y.x + x.y * y.y`
- Vec3: `x.x * y.x + x.y * y.y + x.z * y.z`
- Vec4: `x.x * y.x + x.y * y.y + x.z * y.z + x.w * y.w`

### cross

**形态**：包级泛型函数（仅 Vec3）

```cangjie
public func cross<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T>, Q <: Qualifier
```

**约束**：`T <: Number<T>`, `Q <: Qualifier`（不变）

**实现**：`Vec3(x.y * y.z - y.y * x.z, x.z * y.x - y.z * x.x, x.x * y.y - y.x * x.y)`

### normalize

**形态**：包级泛型函数（Vec1~Vec4 共 4 重载）

```cangjie
public func normalize<T, Q>(v: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func normalize<T, Q>(v: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier
public func normalize<T, Q>(v: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier
public func normalize<T, Q>(v: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier
```

**约束**：`T <: FloatingPoint<T>`（Vec1 不用 Comparable，因为 NaN 自然传播；Vec2~Vec4 需 Comparable 做零向量保护比较）

**实现**：
- Vec1: `v * inversesqrt(dot(v, v))`（无零值保护，零→NaN 自然传播）
- Vec2~Vec4: 先 `let zero = (Float64(0) as T).getOrThrow()`，`let lenSq = dot(v, v)`，若 `lenSq <= zero` 返回零向量 VecN(zero, ...)，否则 `v / sqrtT(lenSq)`

### length

**形态**：包级泛型函数（Vec2~Vec4 共 3 重载）

```cangjie
public func length<T, Q>(v: Vec2<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier
public func length<T, Q>(v: Vec3<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier
public func length<T, Q>(v: Vec4<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier
```

**约束**：`T <: FloatingPoint<T>`（需要 sqrt）

**实现**：`sqrtT(dot(v, v))`

### distance

**形态**：包级泛型函数（Vec2~Vec4 共 3 重载）

```cangjie
public func distance<T, Q>(p0: Vec2<T, Q>, p1: Vec2<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier
public func distance<T, Q>(p0: Vec3<T, Q>, p1: Vec3<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier
public func distance<T, Q>(p0: Vec4<T, Q>, p1: Vec4<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier
```

**约束**：`T <: FloatingPoint<T>`

**实现**：`length(p0 - p1)`

### reflect

**形态**：包级泛型函数（Vec2~Vec4 共 3 重载）

```cangjie
public func reflect<T, Q>(I: Vec2<T, Q>, N: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func reflect<T, Q>(I: Vec3<T, Q>, N: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func reflect<T, Q>(I: Vec4<T, Q>, N: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
```

**约束**：`T <: FloatingPoint<T>`（需要 `T(2)` 字面量构造和乘除运算）

**实现**：`I - (Float64(2) as T).getOrThrow() * dot(N, I) * N`

### refract

**形态**：包级泛型函数（Vec2~Vec4 共 3 重载）

```cangjie
public func refract<T, Q>(I: Vec2<T, Q>, N: Vec2<T, Q>, eta: T): Vec2<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier
public func refract<T, Q>(I: Vec3<T, Q>, N: Vec3<T, Q>, eta: T): Vec3<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier
public func refract<T, Q>(I: Vec4<T, Q>, N: Vec4<T, Q>, eta: T): Vec4<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier
```

**约束**：`T <: FloatingPoint<T> & Comparable<T>`（需要 `k >= T(0)` 比较判断）

**实现**：
```
let one = (Float64(1) as T).getOrThrow()
let zero = (Float64(0) as T).getOrThrow()
let dNI = dot(N, I)
let k = one - eta * eta * (one - dNI * dNI)
if (k < zero) {
    VecN(zero, zero, ...)  // 零向量
} else {
    eta * I - (eta * dNI + sqrtT(k)) * N
}
```

### faceforward

**形态**：包级泛型函数（Vec2~Vec4 共 3 重载）

```cangjie
public func faceforward<T, Q>(N: Vec2<T, Q>, I: Vec2<T, Q>, Nref: Vec2<T, Q>): Vec2<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier
public func faceforward<T, Q>(N: Vec3<T, Q>, I: Vec3<T, Q>, Nref: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier
public func faceforward<T, Q>(N: Vec4<T, Q>, I: Vec4<T, Q>, Nref: Vec4<T, Q>): Vec4<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier
```

**约束**：`T <: Number<T> & Comparable<T>`（只需比较 `dot(Nref, I) < T(0)`，不需浮点）

**实现**：
```
let zero = (Float64(0) as T).getOrThrow()
if (dot(Nref, I) < zero) { N } else { -N }
```

### 导入声明

```cangjie
package glm.detail
import std.math.{ Number, FloatingPoint }
```

需要追加 `FloatingPoint`（当前仅导入 `Number`）。

---

## A.2 src/ext/matrix_transform.cj

**形态**：包级泛型函数（6 个函数）
**包路径**：`glm.ext`

现有文件只有 `translate` 的 stub（约束 `T <: FloatingPoint<T>`）。需要补充 `rotate`/`scale`/`shear`/`lookAt`/`lookAtRH`/`lookAtLH`。

### translate
```cangjie
public func translate<T, Q>(m: Mat4x4<T, Q>, v: Vec3<T, Q>): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier
```

**实现**：构造平移矩阵左乘 m。列主序：
```
Mat4x4(
    Vec4(m.c0.x, m.c0.y, m.c0.z, m.c0.w),
    Vec4(m.c1.x, m.c1.y, m.c1.z, m.c1.w),
    Vec4(m.c2.x, m.c2.y, m.c2.z, m.c2.w),
    Vec4(m.c0.x * v.x + m.c1.x * v.y + m.c2.x * v.z + m.c3.x,
         m.c0.y * v.x + m.c1.y * v.y + m.c2.y * v.z + m.c3.y,
         m.c0.z * v.x + m.c1.z * v.y + m.c2.z * v.z + m.c3.z,
         m.c0.w * v.x + m.c1.w * v.y + m.c2.w * v.z + m.c3.w)
)
```

### rotate
```cangjie
public func rotate<T, Q>(m: Mat4x4<T, Q>, angle: T, axis: Vec3<T, Q>): Mat4x4<T, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier
```

**实现**：
1. `let a = angle`，`let c = cosT(a)`, `let s = sinT(a)`
2. `let axisN = normalize(axis)`（依赖 detail.geometric.normalize，已在 v7 实现）
3. 若 `length(axis) <= zero` 直接返回 m（`let zero = (Float64(0) as T).getOrThrow()`）
4. 从归一化轴构造旋转矩阵 R 后 `R * m`
5. 列主序构造 R：
   ```
   let zero = (Float64(0) as T).getOrThrow()
   let one = (Float64(1) as T).getOrThrow()
   let temp = axisN * (one - c)
   let Rot = Mat4x4(
       Vec4(temp.x * axisN.x + c, temp.x * axisN.y + s * axisN.z, temp.x * axisN.z - s * axisN.y, zero),
       Vec4(temp.y * axisN.x - s * axisN.z, temp.y * axisN.y + c, temp.y * axisN.z + s * axisN.x, zero),
       Vec4(temp.z * axisN.x + s * axisN.y, temp.z * axisN.y - s * axisN.x, temp.z * axisN.z + c, zero),
       Vec4(zero, zero, zero, one)
   )
   ```
6. 返回 `Rot * m`（注意：GLM 约定是左乘，即 `rotate(m, angle, axis)` = `Rot * m`）

### scale
```cangjie
public func scale<T, Q>(m: Mat4x4<T, Q>, v: Vec3<T, Q>): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier
```

**实现**：构造缩放矩阵左乘 m。
```
let zero = (Float64(0) as T).getOrThrow()
let one = (Float64(1) as T).getOrThrow()
Mat4x4(
    Vec4(m.c0.x * v.x, m.c0.y * v.x, m.c0.z * v.x, m.c0.w * v.x),
    Vec4(m.c1.x * v.y, m.c1.y * v.y, m.c1.z * v.y, m.c1.w * v.y),
    Vec4(m.c2.x * v.z, m.c2.y * v.z, m.c2.z * v.z, m.c2.w * v.z),
    Vec4(m.c3.x, m.c3.y, m.c3.z, m.c3.w)
)
```

### shear
```cangjie
public func shear<T, Q>(m: Mat4x4<T, Q>, p: Vec3<T, Q>, l_x: Vec2<T, Q>, l_y: Vec2<T, Q>, l_z: Vec2<T, Q>): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier
```

**实现**：构造剪切矩阵 H 后返回 `H * m`。H 从 l_x/l_y/l_z 参数构造。

### lookAt / lookAtRH / lookAtLH
```cangjie
public func lookAt<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier
public func lookAtRH(eye, center, up): Mat4x4<T, Q>  // 同签名
public func lookAtLH(eye, center, up): Mat4x4<T, Q>  // 同签名
```

**实现**：
1. `let f = normalize(center - eye)`（注意 LH 时 `f = normalize(eye - center)`）
2. `let s = normalize(cross(f, up))`
3. `let u = cross(s, f)`
4. 列主序构造视图矩阵：
   ```
   let zero = (Float64(0) as T).getOrThrow()
   let one = (Float64(1) as T).getOrThrow()
   Mat4x4(
       Vec4(s.x, u.x, -f.x, zero),
       Vec4(s.y, u.y, -f.y, zero),
       Vec4(s.z, u.z, -f.z, zero),
       Vec4(-dot(s, eye), -dot(u, eye), dot(f, eye), one)
   )
   ```

### 导入声明

```cangjie
package glm.ext
import glm.detail.{ Mat4x4, Vec3, Vec2, Vec4, Qualifier, dot, cross, normalize, sinT, cosT, sqrtT }
import std.math.FloatingPoint
```

---

## A.3 src/ext/matrix_clip_space.cj

**形态**：包级泛型函数（46 个函数）
**包路径**：`glm.ext`

现有文件只有 `ortho(left, right, bottom, top)` 的 stub。需补充全部 46 个函数（ortho 系族 10 + frustum 系族 9 + perspective 系族 9 + perspectiveFov 系族 9 + infinitePerspective 系族 7 + tweakedInfinitePerspective 2）。

### ortho 系族

```cangjie
// 2D ortho（无 z 参数）
public func ortho<T, Q>(left: T, right: T, bottom: T, top: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier
```

**实现**：列主序正交投影矩阵（默认 NO：[-1,1] Z 范围）
```
let rml = right - left
let tmb = top - bottom
let zero = (Float64(0) as T).getOrThrow()
let one = (Float64(1) as T).getOrThrow()
let two = (Float64(2) as T).getOrThrow()
Mat4x4(
    Vec4(two / rml, zero, zero, zero),
    Vec4(zero, two / tmb, zero, zero),
    Vec4(zero, zero, -one, zero),
    Vec4(-(right + left) / rml, -(top + bottom) / tmb, zero, one)
)
```

```cangjie
// 6 参数 ortho 系族
public func ortho<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func orthoLH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func orthoLH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func orthoRH_ZO<T, Q>(...): Mat4x4<T, Q>
public func orthoRH_NO<T, Q>(...): Mat4x4<T, Q>
public func orthoZO<T, Q>(...): Mat4x4<T, Q>
public func orthoNO<T, Q>(...): Mat4x4<T, Q>
public func orthoLH<T, Q>(...): Mat4x4<T, Q>
public func orthoRH<T, Q>(...): Mat4x4<T, Q>
```

**实现模式**（正交投影通式）：
```
let rml = right - left
let tmb = top - bottom
let znf = zFar - zNear  // 或 zNear - zFar（取决于手系 LH/RH）
let zero = (Float64(0) as T).getOrThrow()
let one = (Float64(1) as T).getOrThrow()
let two = (Float64(2) as T).getOrThrow()
// 列主序
Vec4(two / rml, zero, zero, zero)
Vec4(zero, two / tmb, zero, zero)
Vec4(zero, zero, depthScale, zero)
Vec4(-(right+left)/rml, -(top+bottom)/tmb, depthOffset, one)
```
- 手系 LH：`depthScale = one / znf`，`depthOffset = -zNear / znf`
- 手系 RH：`depthScale = -one / znf`，`depthOffset = -zFar / znf`
- ZO (Z range [0,1])：`zNear→0, zFar→1`
- NO (Z range [-1,1])：`zNear→-1, zFar→1`

### frustum 系族（9 个）

```cangjie
public func frustum<T, Q>(left: T, right: T, bottom: T, top: T, near: T, far: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier
// + 8 个变体：LH_ZO, LH_NO, RH_ZO, RH_NO, ZO, NO, LH, RH
```

**实现**（透视平截头体投影，列主序）：
```
let rml = right - left
let tmb = top - bottom
let near2 = (Float64(2) as T).getOrThrow() * near
let zero = (Float64(0) as T).getOrThrow()
Vec4(near2 / rml, zero, zero, zero)
Vec4(zero, near2 / tmb, zero, zero)
Vec4((right+left)/rml, (top+bottom)/tmb, depthScale, one)
Vec4(zero, zero, depthOffset, zero)
```
- RH: `depthScale = -(far + near) / fnf`，`depthOffset = -near2 * far / fnf`
- LH: `depthScale = (far + near) / fnf`，`depthOffset = near2 * far / fnf`
- fnf = far - near（RH_Z0 中 ZO 时用 zNear→0, zFar→1 公式，NO 时用 [-1,1]）

### perspective 系族（9 个）

```cangjie
public func perspective<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier
// + 8 个变体
```

**实现**：
```
let halfFovy = fovy / (Float64(2) as T).getOrThrow()
let tanHalfFovy = tanT(halfFovy)
let zero = (Float64(0) as T).getOrThrow()
let one = (Float64(1) as T).getOrThrow()
Vec4(one / (aspect * tanHalfFovy), zero, zero, zero)
Vec4(zero, one / tanHalfFovy, zero, zero)
Vec4(zero, zero, depthScale, one)
Vec4(zero, zero, depthOffset, zero)
```
- RH: `depthScale = -(zFar + zNear) / (zFar - zNear)`，`depthOffset = -(Float64(2) as T).getOrThrow() * zFar * zNear / (zFar - zNear)`
- LH: `depthScale = (zFar + zNear) / (zFar - zNear)`，`depthOffset = (Float64(2) as T).getOrThrow() * zFar * zNear / (zFar - zNear)`

### perspectiveFov 系族（9 个）

```cangjie
public func perspectiveFov<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier
```

**实现**：用宽高比从 width/height 计算 aspect，其余与 perspective 一致。

### infinitePerspective 系族（7 个）

```cangjie
public func infinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier
```

**实现**：类似 perspective 但无 zFar，远平面在无穷远处。

### tweakedInfinitePerspective（2 个）

带 ep 参数的无限远投影微调版本。

### 导入声明

```cangjie
package glm.ext
import glm.detail.{ Mat4x4, Vec4, Qualifier, cosT, sinT, tanT }
import std.math.FloatingPoint
```

---

## A.4 src/ext/matrix_projection.cj

**形态**：包级泛型函数（7 个函数）
**包路径**：`glm.ext`

现有文件是 `perspective`（实际应改为 `project` 系族）。需实现：

### projectZO / projectNO / project

```cangjie
public func projectZO<T, U, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<U, Q>): Vec3<T, Q>
  where T <: FloatingPoint<T>, U <: Number<U>, Q <: Qualifier
public func projectNO<T, U, Q>(...): Vec3<T, Q>
public func project<T, U, Q>(...): Vec3<T, Q>
```

**实现**：
1. `let tmp = proj * model * Vec4(obj.x, obj.y, obj.z, T(1))`
2. 透视除法：`tmp / tmp.w`
3. ZO: `result.z = (tmp.z + T(1)) * T(0.5)`（映射到 [0,1]）
   NO: `result.z = tmp.z`（保持 [-1,1]）
4. 视口变换：
   ```
   let one = (Float64(1) as T).getOrThrow()
   let half = (Float64(0.5) as T).getOrThrow()
   let vpX = (viewport.x as T).getOrThrow()
   let vpY = (viewport.y as T).getOrThrow()
   let vpZ = (viewport.z as T).getOrThrow()
   let vpW = (viewport.w as T).getOrThrow()
   result.x = vpX + vpZ * (tmp.x * half + half)
   result.y = vpY + vpW * (tmp.y * half + half)
   Vec3(result.x, result.y, result.z)
   ```

### unProjectZO / unProjectNO / unProject

```cangjie
public func unProjectZO<T, U, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<U, Q>): Vec3<T, Q>
  where T <: FloatingPoint<T>, U <: Number<U>, Q <: Qualifier
```

**实现**：project 的逆过程。
1. 视口逆变换：NDC 坐标
2. ZO: 逆映射 `ndc.z = win.z * T(2) - T(1)`
   NO: `ndc.z = win.z`
3. `let invMVP = inverse(proj * model)`
4. `let tmp = invMVP * Vec4(ndc.x, ndc.y, ndc.z, T(1))`
5. `tmp / tmp.w`

### pickMatrix

```cangjie
public func pickMatrix<T, U, Q>(center: Vec2<T, Q>, delta: Vec2<T, Q>, viewport: Vec4<U, Q>): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, U <: Number<U>, Q <: Qualifier
```

**实现**：构造平移+缩放矩阵。
```
let zero = (Float64(0) as T).getOrThrow()
let one = (Float64(1) as T).getOrThrow()
let two = (Float64(2) as T).getOrThrow()
let vpZ = (viewport.z as T).getOrThrow()
let vpW = (viewport.w as T).getOrThrow()
let vpX = (viewport.x as T).getOrThrow()
let vpY = (viewport.y as T).getOrThrow()
let sx = vpZ / (two * delta.x)
let sy = vpW / (two * delta.y)
let tx = (vpZ + two * (vpX - center.x)) / (two * delta.x)
let ty = (vpW + two * (vpY - center.y)) / (two * delta.y)
Mat4x4(
    Vec4(sx, zero, zero, zero),
    Vec4(zero, sy, zero, zero),
    Vec4(zero, zero, one, zero),
    Vec4(tx, ty, zero, one)
)
```

### 导入声明

```cangjie
package glm.ext
import glm.detail.{ Mat4x4, Vec2, Vec3, Vec4, Qualifier, inverse, dot, sqrtT }
import std.math.{ FloatingPoint, Number }
```

---

## A.5 src/ext/quaternion_common.cj（补齐 mix/slerp/slerp(k)）

现有文件已有 `conjugate`/`inverse`/`lerp`/`isnan`/`isinf`。需补齐 3 个 stub。

### mix

```cangjie
public func mix<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T): Quat<T, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier
```

**实现**（与 lerp 区别：mix 用 clamp 静默处理越界，lerp 用 assert）：
```
let one = (Float64(1) as T).getOrThrow()
let zero = (Float64(0) as T).getOrThrow()
let t = clamp(a, zero, one)
x * (one - t) + y * t
```
依赖：`clamp` 来自 `glm.detail.common`（`Number<T> & Comparable<T>` 约束）

### slerp

```cangjie
public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T): Quat<T, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier
```

**实现**：
```
let one = (Float64(1) as T).getOrThrow()
let zero = (Float64(0) as T).getOrThrow()
// clamp dot to [-1, 1] for numerical stability
let cosOmega = clamp(dot(x, y), -one, one)
let omega = acos(cosOmega)       // 依赖 trigonometric.cj acos
let sinOmega = sinT(omega)        // 依赖 stdmath_shim.cj sinT

// 退化分支：sinOmega 接近零时退化为 lerp
if (sinOmega < epsilon<T>()) {
    x * (one - a) + y * a
} else {
    let scale0 = sinT((one - a) * omega) / sinOmega
    let scale1 = sinT(a * omega) / sinOmega
    scale0 * x + scale1 * y
}
```
依赖：`clamp`（detail.common）、`acos`（detail.trigonometric）、`sinT`（stdmath_shim）、`epsilon`（detail.scalar_constants）、`dot`（ext.quaternion_geometric）

### slerp(k)

```cangjie
public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T, k: T): Quat<T, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier
```

**实现**：参考 GLM 1.0.3 `ext/quaternion_common.inl` 的 k 参数扩展插值。k 控制插值曲线的扭曲程度。

### 导入声明（追加）

需补充导入：
```
import glm.detail.{ clamp, acos, epsilon, sinT, cosT }
```

---

## A.6 src/ext/quaternion_trigonometric.cj（补齐 angle/angleAxis）

现有文件已有 `axis`（完整）+ `sqrtT` 私有函数。

### angle

```cangjie
public func angle<T, Q>(x: Quat<T, Q>): T
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier
```

**实现**：`(Float64(2) as T).getOrThrow() * acos(clamp(x.w, -one, one))`

依赖：`acos`（detail.trigonometric）、`clamp`（detail.common）

### angleAxis

```cangjie
public func angleAxis<T, Q>(angle: T, axis: Vec3<T, Q>): Quat<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier
```

**实现**：
```
let halfAngle = angle / (Float64(2) as T).getOrThrow()
let s = sinT(halfAngle)
let c = cosT(halfAngle)
Quat(c, s * axis.x, s * axis.y, s * axis.z)
```

依赖：`sinT`/`cosT`（stdmath_shim）

### 导入声明（追加）

需补充：
```
import glm.detail.{ acos, clamp, sinT, cosT }
```
现有 `import std.math.sqrt` 可移除（若不再使用）。`sqrtT` 私有函数需移除，`axis` 改为通过 `import glm.detail.sqrtT` 使用公开版。

---

## A.7 src/ext/quaternion_transform.cj（补齐 rotate）

**形态**：包级泛型函数
**包路径**：`glm.ext`

```cangjie
public func rotate<T, Q>(q: Quat<T, Q>, angle: T, axis: Vec3<T, Q>): Quat<T, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier
```

**实现**：
```
let one = (Float64(1) as T).getOrThrow()
let zero = (Float64(0) as T).getOrThrow()
let halfAngle = angle / (Float64(2) as T).getOrThrow()

// normalize axis
let lenSq = dot(axis, axis)
if (lenSq <= zero) {
    return Quat(one, zero, zero, zero)  // 零轴保护：返回单位四元数
}
let invLen = one / sqrtT(lenSq)
let normAxis = axis * invLen

let s = sinT(halfAngle)
let c = cosT(halfAngle)

// 构造旋转四元数
let r = Quat(c, s * normAxis.x, s * normAxis.y, s * normAxis.z)
r * q
```

依赖：`dot`（ext.quaternion_geometric）、`sqrtT`/`sinT`/`cosT`（stdmath_shim）、`normalize` 实际上通过平方根倒数实现（不需要 detail.geometric.normalize）

### 导入声明

```cangjie
package glm.ext
import glm.detail.{ Quat, Vec3, Qualifier, dot, sqrtT, sinT, cosT }
import std.math.FloatingPoint
```

---

## A.8 src/gtc/matrix_transform.cj（64 stub → 完整实现）

**形态**：包级泛型函数（64 个函数）
**包路径**：`glm.gtc`

此文件为委托层。大多数函数委托给 `glm.ext` 的对应函数。`_slow` 变体在 gtc 层独立实现。

**委托规则**：
- `identity`/`translate`/`rotate`/`scale`/`shear`/`lookAt`/`lookAtRH`/`lookAtLH`
  → 委托 `glm.ext.matrix_transform`
- `ortho`/`frustum`/`perspective`/`perspectiveFov`/`infinitePerspective`/`tweakedInfinitePerspective`
  → 委托 `glm.ext.matrix_clip_space`
- `projectZO`/`projectNO`/`project`/`unProjectZO`/`unProjectNO`/`unProject`/`pickMatrix`
  → 委托 `glm.ext.matrix_projection`
- `rotate_slow`/`scale_slow`/`shear_slow` → 在 gtc 层直接实现（ext 层无对应）
- `project`/`unProject` → 委托 `projectZO`/`unProjectZO`（GLM 1.0.3 默认 ZO 约定）

**slow 变体实现**：

### rotate_slow
```
// 与 rotate 功能相同，但使用四元数→矩阵的数值稳定路径
let a = angle
let axisN = normalize(axis)
let s = sinT(a)
let c = cosT(a)
let one_c = (Float64(1) as T).getOrThrow() - c
let x = axisN.x, y = axisN.y, z = axisN.z
let zero = (Float64(0) as T).getOrThrow()
let one = (Float64(1) as T).getOrThrow()
let Rot = Mat4x4(
    Vec4(c + x*x*one_c, y*x*one_c + z*s, z*x*one_c - y*s, zero),
    Vec4(x*y*one_c - z*s, c + y*y*one_c, z*y*one_c + x*s, zero),
    Vec4(x*z*one_c + y*s, y*z*one_c - x*s, c + z*z*one_c, zero),
    Vec4(zero, zero, zero, one)
)
Rot * m
```

### scale_slow
```
// 逐分量构造对角缩放矩阵
let zero = (Float64(0) as T).getOrThrow()
let one = (Float64(1) as T).getOrThrow()
let S = Mat4x4(
    Vec4(v.x, zero, zero, zero),
    Vec4(zero, v.y, zero, zero),
    Vec4(zero, zero, v.z, zero),
    Vec4(zero, zero, zero, one)
)
S * m
```

### shear_slow

从 Vec2 参数提取分量构造剪切矩阵后左乘 m。

### 导入声明

```cangjie
package glm.gtc
import glm.detail.{ Mat4x4, Vec2, Vec3, Vec4, Qualifier, sinT, cosT, normalize, dot, cross, inverse }
import glm.ext.{ translate, rotate, scale, shear, lookAt, lookAtRH, lookAtLH }
import glm.ext.{ ortho, frustum, perspective, perspectiveFov, infinitePerspective, tweakedInfinitePerspective }
import glm.ext.{ projectZO, projectNO, project, unProjectZO, unProjectNO, unProject, pickMatrix }
import std.math.FloatingPoint
```

**注意**：`project`/`unProject` 在 gtc 层的签名中 viewport 参数为 `Vec4<T, Q>`（与 ext 层 `Vec4<U, Q>` 不同）。Coder 需注意处理 gtc 层与 ext 层的签名匹配问题。有两种方案：
1. gtc 层使用 `T` 约束（与现有 stub 一致），内部调用 ext 层时做类型转换
2. 或 gtc 层 `public import glm.ext.{...}` 重新导出 ext 函数

建议采用方案 1——在 gtc 层编写转发函数，保持现有 gtc API 签名（`Vec4<T, Q>`）不变，内部将 `viewport` 的 `T` 转为 `U = T` 后调用 ext 版本。

---

## B.1 src/ext/vector_common.cj（新建）

**形态**：包级泛型函数（20 个函数）
**包路径**：`glm.ext`

### 3/4 输入 min/max（Vec1~Vec4 各 4 个重载，共 16 个函数）

```cangjie
// Vec1~Vec4 各 2 个（min 和 max 的 3 输入/4 输入版本）
public func min<T, Q>(a: Vec1<T, Q>, b: Vec1<T, Q>, c: Vec1<T, Q>): Vec1<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier
public func min<T, Q>(a: Vec1<T, Q>, b: Vec1<T, Q>, c: Vec1<T, Q>, d: Vec1<T, Q>): Vec1<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier
// ... Vec2~Vec4 同理
public func max<...>(...): VecN<T, Q>  // 同理
```

**实现**：逐分量委托 `ext/scalar_common.cj` 的 3/4 输入标量 min/max。
- Vec2: `Vec2(min(a.x,b.x,c.x), min(a.y,b.y,c.y))`
- Vec3: `Vec3(min(a.x,b.x,c.x), min(a.y,b.y,c.y), min(a.z,b.z,c.z))`
- Vec4: 同理

### fmin/fmax/fclamp 系列（各 4 个重载 Vec1~Vec4，共 10 个函数）

```cangjie
// 标量-向量版
public func fmin<T, Q>(a: Vec2<T, Q>, b: T): Vec2<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier
// 向量-向量版
public func fmin<T, Q>(a: Vec2<T, Q>, b: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier
// 3/4 输入版
public func fmin<T, Q>(a: Vec2<T, Q>, b: Vec2<T, Q>, c: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier
public func fmin<T, Q>(a: Vec2<T, Q>, b: Vec2<T, Q>, c: Vec2<T, Q>, d: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier
// fmax 同理
```

**实现**：逐分量委托 `ext/scalar_common.cj` 的标量 fmin/fmax。

```cangjie
// fclamp
public func fclamp<T, Q>(x: Vec2<T, Q>, minVal: T, maxVal: T): Vec2<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier
public func fclamp<T, Q>(x: Vec2<T, Q>, minVal: Vec2<T, Q>, maxVal: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier
```

### 纹理环绕（Vec1~Vec4 各 4 个，共 16 个函数）

```cangjie
public func clamp<T, Q>(Texcoord: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier
public func repeat<T, Q>(Texcoord: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func mirrorClamp<T, Q>(Texcoord: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier
public func mirrorRepeat<T, Q>(Texcoord: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier
```

**实现**：逐分量委托 `ext/scalar_common.cj` 的标量纹理环绕函数。

### iround/uround（Vec1~Vec4 各 2 个，共 8 个函数）

```cangjie
public func iround<T, Q>(x: Vec2<T, Q>): Vec2<Int64, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func uround<T, Q>(x: Vec2<T, Q>): Vec2<UInt64, Q> where T <: FloatingPoint<T>, Q <: Qualifier
```

**实现**：逐分量委托 `ext/scalar_common.cj` 的 `iround`/`uround`。

### 导入声明

```cangjie
package glm.ext
import glm.detail.{ Vec1, Vec2, Vec3, Vec4, Qualifier, min, max, clamp }
import std.math.{ Number, FloatingPoint }
```

---

## B.2 src/gtc/matrix_inverse.cj（新建）

### affineInverse

```cangjie
public func affineInverse<T, Q>(m: Mat4x4<T, Q>): Mat4x4<T, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier
```

**实现**：
1. 取上三角 3x3 部分：`let m3 = Mat3x3(Vec3(m.c0.x, m.c0.y, m.c0.z), Vec3(m.c1.x, m.c1.y, m.c1.z), Vec3(m.c2.x, m.c2.y, m.c2.z))`
2. 计算 3x3 逆矩阵 `let invM3 = inverse(m3)`
3. 计算平移分量：`let invTrans = invM3 * Vec3(m.c3.x, m.c3.y, m.c3.z)`
4. 构造返回矩阵：
   ```
   let zero = (Float64(0) as T).getOrThrow()
   let one = (Float64(1) as T).getOrThrow()
   Mat4x4(
       Vec4(invM3.c0.x, invM3.c0.y, invM3.c0.z, zero),
       Vec4(invM3.c1.x, invM3.c1.y, invM3.c1.z, zero),
       Vec4(invM3.c2.x, invM3.c2.y, invM3.c2.z, zero),
       Vec4(-invTrans.x, -invTrans.y, -invTrans.z, one)
   )
   ```

依赖：`detail.matrix.inverse`（Mat3x3）、`detail.matrix.transpose`（Mat3x3 版本需注意是否存在）

### inverseTranspose

```cangjie
public func inverseTranspose<T, Q>(m: Mat3x3<T, Q>): Mat3x3<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier
public func inverseTranspose<T, Q>(m: Mat4x4<T, Q>): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier
```

**实现**：`transpose(inverse(m))`

依赖：`detail.matrix.inverse`（Mat3x3/Mat4x4）、`detail.matrix.transpose`（Mat3x3/Mat4x4）

**注意**：`transpose` 在 `detail/matrix.cj` 中是否已为 Mat3x3 提供？需确认。若不存在，需调用 `detail.matrix` 的 `transpose` 泛型函数（已在阶段二完整实现）。

### 导入声明

```cangjie
package glm.gtc
import glm.detail.{ Mat3x3, Mat4x4, Vec3, Vec4, Qualifier, inverse, transpose }
import std.math.FloatingPoint
```

---

## B.3 src/gtc/matrix_access.cj（新建）

### row

```cangjie
// 方阵（3 个）
public func row<T, Q>(m: Mat2x2<T, Q>, index: Int64): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func row<T, Q>(m: Mat3x3<T, Q>, index: Int64): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func row<T, Q>(m: Mat4x4<T, Q>, index: Int64): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier

// 非方阵（6 个）：Mat{C}x{R} → row 返回 Vec{C}（行有 C 个分量，跨越 C 列）
public func row<T, Q>(m: Mat2x3<T, Q>, index: Int64): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func row<T, Q>(m: Mat3x2<T, Q>, index: Int64): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func row<T, Q>(m: Mat2x4<T, Q>, index: Int64): Vec2<T, Q>
public func row<T, Q>(m: Mat4x2<T, Q>, index: Int64): Vec4<T, Q>
public func row<T, Q>(m: Mat3x4<T, Q>, index: Int64): Vec3<T, Q>
public func row<T, Q>(m: Mat4x3<T, Q>, index: Int64): Vec4<T, Q>
```

**实现**（以 Mat4x4 为例）：
```
match (index) {
    case 0 => Vec4(m.c0.x, m.c1.x, m.c2.x, m.c3.x)
    case 1 => Vec4(m.c0.y, m.c1.y, m.c2.y, m.c3.y)
    case 2 => Vec4(m.c0.z, m.c1.z, m.c2.z, m.c3.z)
    case 3 => Vec4(m.c0.w, m.c1.w, m.c2.w, m.c3.w)
    case _ => throw Exception("index out of range")
}
```

矩阵列主序存储验证（以 `Mat2x3<T,Q>` 为例）：
- `c0: Vec3<T,Q>`、`c1: Vec3<T,Q>` → 2 列，每列 3 行
- `row` 提取第 i 行各列的分量 → `Vec2<T,Q>`（2 列）
- `column` 提取第 i 列向量 → `Vec3<T,Q>`（3 行）

**通用规则**：`Mat{C}x{R}` → `row` 返回 `Vec{C}`（C 列，每行 C 个分量），`column` 返回 `Vec{R}`（R 行，每列 R 个分量）。

**row 实现**（以 Mat2x3 为例，其余同理）：
```
match (index) {
    case 0 => Vec2(m.c0.x, m.c1.x)       // 第 0 行各列分量
    case 1 => Vec2(m.c0.y, m.c1.y)       // 第 1 行各列分量
    case 2 => Vec2(m.c0.z, m.c1.z)       // 第 2 行各列分量（仅 Mat2x3/Mat2x4 有）
    case 3 => Vec2(m.c0.w, m.c1.w)       // 第 3 行各列分量（仅 Mat2x4 有）
    case _ => throw Exception("index out of range")
}
```
- `row(m: Mat3x2, i)` → `Vec3`：`case 0=>Vec3(m.c0.x,m.c1.x,m.c2.x); case 1=>Vec3(m.c0.y,m.c1.y,m.c2.y)`
- `row(m: Mat2x4, i)` → `Vec2`：`case 0=>Vec2(m.c0.x,m.c1.x); case 1=>Vec2(m.c0.y,m.c1.y); case 2=>Vec2(m.c0.z,m.c1.z); case 3=>Vec2(m.c0.w,m.c1.w)`
- `row(m: Mat4x2, i)` → `Vec4`：`case 0=>Vec4(m.c0.x,m.c1.x,m.c2.x,m.c3.x); case 1=>Vec4(m.c0.y,m.c1.y,m.c2.y,m.c3.y)`
- `row(m: Mat3x4, i)` → `Vec3`：`case 0=>Vec3(m.c0.x,m.c1.x,m.c2.x); case 1=>Vec3(m.c0.y,m.c1.y,m.c2.y); case 2=>Vec3(m.c0.z,m.c1.z,m.c2.z); case 3=>Vec3(m.c0.w,m.c1.w,m.c2.w)`
- `row(m: Mat4x3, i)` → `Vec4`：`case 0=>Vec4(m.c0.x,m.c1.x,m.c2.x,m.c3.x); case 1=>Vec4(m.c0.y,m.c1.y,m.c2.y,m.c3.y); case 2=>Vec4(m.c0.z,m.c1.z,m.c2.z,m.c3.z)`

### column

```cangjie
public func column<T, Q>(m: Mat2x2<T, Q>, index: Int64): Vec2<T, Q>
public func column<T, Q>(m: Mat3x3<T, Q>, index: Int64): Vec3<T, Q>
public func column<T, Q>(m: Mat4x4<T, Q>, index: Int64): Vec4<T, Q>
// 非方阵：Mat{C}x{R} → column 返回 Vec{R}（列有 R 个分量，R 行）
public func column<T, Q>(m: Mat2x3<T, Q>, index: Int64): Vec3<T, Q>
public func column<T, Q>(m: Mat3x2<T, Q>, index: Int64): Vec2<T, Q>
public func column<T, Q>(m: Mat2x4<T, Q>, index: Int64): Vec4<T, Q>
public func column<T, Q>(m: Mat4x2<T, Q>, index: Int64): Vec2<T, Q>
public func column<T, Q>(m: Mat3x4<T, Q>, index: Int64): Vec4<T, Q>
public func column<T, Q>(m: Mat4x3<T, Q>, index: Int64): Vec3<T, Q>
// ... 其他
```

**实现**（以 Mat4x4 为例）：`match (index) { case 0 => m.c0; case 1 => m.c1; case 2 => m.c2; case 3 => m.c3; case _ => throw ... }`

### 导入声明

```cangjie
package glm.gtc
import glm.detail.{ Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4, Vec2, Vec3, Vec4, Qualifier }
import std.math.FloatingPoint
```

---

## 错误处理

所有函数为纯函数（无副作用），不抛出异常（除矩阵 access 的 index 越界外）。遵循 OOD 设计 §5 的策略：
- 奇异矩阵求逆：IEEE 754 NaN/Inf 自然传播
- normalize Vec2~Vec4 零向量保护：返回零向量
- normalize Vec1 零向量：NaN 自然传播
- acos/asin 越界：已在 trigonometric.cj 中实现 NaN 返回

## 行为契约

| 函数 | 约束 | 特殊行为 |
|------|------|---------|
| `dot` | Number<T> | 纯乘加，无分支 |
| `cross` | Number<T> | 仅 Vec3 |
| `normalize Vec1` | FloatingPoint<T> | 无零保护，零→NaN |
| `normalize Vec2~4` | FloatingPoint<T>&Comparable<T> | 零→零向量 |
| `length` | FloatingPoint<T> | sqrt(dot) |
| `distance` | FloatingPoint<T> | length(p0-p1) |
| `reflect` | FloatingPoint<T> | I-2*dot(N,I)*N |
| `refract` | FloatingPoint<T>&Comparable<T> | k<0 零向量 |
| `faceforward` | Number<T>&Comparable<T> | dot(Nref,I)<0→N else -N |
| `mix(quat)` | FloatingPoint<T>&Comparable<T> | clamp(a,0,1) 静默处理 |
| `slerp` | FloatingPoint<T>&Comparable<T> | sinOmega<epsilon 退化→lerp |
| `angle` | FloatingPoint<T>&Comparable<T> | 2*acos(clamp(w,-1,1)) |
| `affineInverse` | FloatingPoint<T>&Comparable<T> | 假设最后行 [0,0,0,1] |

## 依赖关系

| 被依赖项 | 来源 | 用途 |
|---------|------|------|
| `sqrtT, sinT, cosT, tanT, ...` | `detail.stdmath_shim` | 所有浮点数学运算 |
| `FloatingPoint<T>` | `std.math` | 泛型约束 |
| `Number<T>` | `std.math` | 算术运算约束 |
| `Vec1~Vec4` | `detail` | 向量类型 |
| `Mat2x2~Mat4x4` | `detail` | 矩阵类型 |
| `Quat<T,Q>` | `detail` | 四元数类型 |
| `epsilon<T>()`, `pi<T>()` | `detail.scalar_constants` | 常数值 |
| `min, max, clamp, mix, abs, ...` | `detail.common` | 标量/向量通用函数 |
| `acos, acosT, ...` | `detail.trigonometric` | 三角函数 |
| `inverse` | `detail.matrix` | 矩阵求逆（已在 v7 实现） |
| `scalar_common min/max/fmin/fmax/...` | `ext.scalar_common` | 标量扩展函数（已在 R6 完成） |
| `quaternion_geometric dot/length` | `ext.quaternion_geometric` | 四元数几何运算（已在 R6 完成） |
| `ext.matrix_transform` | `ext` | 矩阵变换委托 |
| `ext.matrix_clip_space` | `ext` | 裁剪空间矩阵委托 |
| `ext.matrix_projection` | `ext` | 投影矩阵委托 |

---

## 修订说明（v8 r1）

| 审查意见 | 修改措施 |
|---------|---------|
| [严重] stdmath_shim 辅助函数跨包不可见：`sqrtT`/`sinT`/`cosT`/`tanT` 为包级可见性（无 public），不可被 `glm.ext`/`glm.gtc` 导入。所有 ext/gtc 文件的 import 声明尝试导入这些函数将编译失败。现有 `ext/quaternion_geometric.cj` 和 `ext/quaternion_trigonometric.cj` 已通过私有包装器模式规避，但 7 个待修改/新建文件的设计均假定可以直接导入。 | 采纳方案 A：将 `src/detail/stdmath_shim.cj` 中所有 25 个辅助函数改为 `public func`，使其可被其他包导入。现有 `ext/quaternion_geometric.cj` 和 `ext/quaternion_trigonometric.cj` 中的私有 `sqrtT` 副本需移除，改为从 `glm.detail` 导入。所有设计中的 import 声明（已正确声明导入 `glm.detail.sqrtT`/`sinT`/`cosT`/`tanT`）保持不变——编译时将正确解析到公开后的函数。在概述偏差提示中增加第 9 条。 |

## 修订说明（v8 r2）

| 审查意见 | 修改措施 |
|---------|------|
| [一般] A.1 geometric.cj normalize Vec2~Vec4 零值检查使用 `==` 但约束不含 `Equatable<T>`，应为 `lenSq <= zero`（`<=` 来自 `Comparable<T>`） | 将 `lenSq == T(0)` 改为 `lenSq <= zero`，零向量构造从 `VecN(T(0), ...)` 改为 `VecN(zero, ...)`，并补充 `let zero = (Float64(0) as T).getOrThrow()` 声明 |
| [一般] A.2 ext/matrix_transform.cj rotate 矩阵字面量使用 `T(0)`/`T(1)` 与项目规范不一致 | 移除矩阵字面量中所有 `T(0)`/`T(1)`，使用已声明的 `zero`/`one` 变量替代，并补充 `zero` 声明 |
| [一般] A.4 ext/matrix_projection.cj pickMatrix 缺少 `zero` 变量声明 | 在 `pickMatrix` 函数作用域内补充 `let zero = (Float64(0) as T).getOrThrow()` |

## 修订说明（v8 r3）

| 审查意见 | 修改措施 |
|---------|---------|
| [一般] A.6 节与偏差提示第 9 条矛盾：A.6 要求保留私有 `sqrtT`，偏差提示第 9 条要求移除私有 `sqrtT` 并改为从 `glm.detail` 导入 | 采纳偏差提示第 9 条方案：A.6 节中"`sqrtT` 私有函数仍保留供 `axis` 使用"改为"`sqrtT` 私有函数需移除，`axis` 改为通过 `import glm.detail.sqrtT` 使用公开版" |
| [轻微] B.1 节函数数量描述不精确："8 个函数"应为 16（Vec1~Vec4 各 4 重载的 3/4 输入 min/max） | 将标题从"8 个函数"修正为"16 个函数" |
| [轻微] A.5 节 import 列表含 `sqrtT` 但 mix/slerp/slerp(k) 未使用 | 从 A.5 节 import 声明中移除 `sqrtT` |

## 修订说明（v8 r4）

| 审查意见 | 修改措施 |
|---------|---------|
| [严重] B.3 matrix_access.cj 非方阵 row/column 签名全部系统性错误：`Mat{C}x{R}` 命名约定中 `row` 返回向量维度应为列数 C，`column` 返回向量维度应为行数 R。原有 6 个非方阵 row 重载和 2 个非方阵 column 重载的返回类型全部反置。实现描述访问不存在字段（如 Mat2x3 的 c2）导致编译失败。 | 修正全部 6 个非方阵 row 返回类型（Mat2x3→Vec2, Mat3x2→Vec3, Mat2x4→Vec2, Mat4x2→Vec4, Mat3x4→Vec3, Mat4x3→Vec4）和 2 个非方阵 column 返回类型（Mat2x3→Vec3, Mat3x2→Vec2），补充其余 4 个非方阵 column 签名。重写实现描述，删除含矛盾的推导过程，给出正确的逐类型 match 实现模式。 |
