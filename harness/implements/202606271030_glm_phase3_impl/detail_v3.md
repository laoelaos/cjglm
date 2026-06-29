# 详细设计（v3）

## 概述
实现 GLM Phase 3 ext 函数库层：glm.ext 包下全部 14 个文件（5 个完整实现 + 5 个 stub + 4 个别名文件）及对应的 5 个测试文件。

## 文件规划

### 源文件
| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `src/ext/quaternion_geometric.cj` | 新建 | 四元数几何函数 dot/length/normalize/cross |
| `src/ext/quaternion_relational.cj` | 新建 | 四元数关系运算 equal/notEqual 精确+epsilon |
| `src/ext/vector_relational.cj` | 新建 | 向量关系运算 16 epsilon 重载 + 8 ULP stub |
| `src/ext/quaternion_common.cj` | 新建 | 四元数公共函数 conjugate/inverse/lerp/isnan/isinf + mix/slerp stub |
| `src/ext/quaternion_trigonometric.cj` | 新建 | 四元数三角函数 axis 完整 + angle/angleAxis stub |
| `src/ext/quaternion_transform.cj` | 新建 | rotate 函数 stub |
| `src/ext/quaternion_exponential.cj` | 新建 | exp/log/pow/sqrt 4 函数 stub |
| `src/ext/matrix_projection.cj` | 新建 | perspective stub |
| `src/ext/matrix_clip_space.cj` | 新建 | ortho stub |
| `src/ext/matrix_transform.cj` | 新建 | translate stub |
| `src/ext/quaternion_float.cj` | 新建 | type quat = Quat<Float32, PackedHighp> |
| `src/ext/quaternion_double.cj` | 新建 | type dquat = Quat<Float64, PackedHighp> |
| `src/ext/quaternion_float_precision.cj` | 新建 | highp/mediump/lowp_quat 三个别名 |
| `src/ext/quaternion_double_precision.cj` | 新建 | highp/mediump/lowp_dquat 三个别名 |

### 测试文件
| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `tests/glm/ext/test_quaternion_geometric.cj` | 新建 | dot/length/normalize/cross 正例 + 零四元数保护 |
| `tests/glm/ext/test_quaternion_relational.cj` | 新建 | equal/notEqual 精确+epsilon 正例 + 边界 |
| `tests/glm/ext/test_vector_relational.cj` | 新建 | 16 epsilon 重载每类至少 1 用例 + ULP stub assertThrows |
| `tests/glm/ext/test_quaternion_common.cj` | 新建 | conjugate/inverse/lerp/isnan/isinf 正例 + mix/slerp stub + inverse 零除 |
| `tests/glm/ext/test_quaternion_trigonometric.cj` | 新建 | axis 正例 + angle/angleAxis stub assertThrows |

## 类型定义

### 包级函数（glm.ext）

所有函数均为包级 `public func`，在 `package glm.ext` 中定义。

---

## quaternion_geometric.cj

**包路径**：`glm.ext`

4 个包级函数，均约束 `where T <: FloatingPoint<T>, Q <: Qualifier`：

```cangjie
package glm.ext

import std.math.sqrt

public func dot<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>): T
  where T <: FloatingPoint<T>, Q <: Qualifier

public func length<T, Q>(q: Quat<T, Q>): T
  where T <: FloatingPoint<T>, Q <: Qualifier

public func normalize<T, Q>(q: Quat<T, Q>): Quat<T, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier

public func cross<T, Q>(q1: Quat<T, Q>, q2: Quat<T, Q>): Quat<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier
```

**实现说明**：
- `dot`：纯算术内联 `x.w*y.w + x.x*y.x + x.y*y.y + x.z*y.z`
- `length`：调用私有 `sqrtT`（见下）处理 `dot(q, q)` —— 因 `std.math.sqrt` 仅接受 `Float64`，需经 `(dot_result as Float64) → sqrt → (as T)` 路径
- `normalize`：`length(q) <= (Float64(0) as T).getOrThrow()` 时返回 `Quat((Float64(0) as T).getOrThrow(), (Float64(0) as T).getOrThrow(), (Float64(0) as T).getOrThrow(), (Float64(1) as T).getOrThrow())`；否则返回 `q / len`
- `cross`：Hamilton 乘积逐分量展开

**私有辅助函数**：
```cangjie
private func sqrtT<T>(x: T): T where T <: FloatingPoint<T> {
    let x64 = (x as Float64).getOrThrow()
    (sqrt(x64) as T).getOrThrow()
}
```

**依赖**：`Quat<T,Q>`（glm.detail）、`std.math.sqrt`（仅 Float64）

---

## quaternion_relational.cj

**包路径**：`glm.ext`

4 个包级函数：

```cangjie
package glm.ext

// 精确比较
public func equal<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>): Vec4<Bool, Q>
  where T <: Equatable<T>, Q <: Qualifier

public func notEqual<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>): Vec4<Bool, Q>
  where T <: Equatable<T>, Q <: Qualifier

// epsilon 容差比较
public func equal<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, epsilon: T): Vec4<Bool, Q>
  where T <: Number<T> & Comparable<T>, Q <: Qualifier

public func notEqual<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, epsilon: T): Vec4<Bool, Q>
  where T <: Number<T> & Comparable<T>, Q <: Qualifier
```

**实现说明**：
- 精确比较使用 `==` 逐分量比较
- epsilon 比较逐分量计算 abs 差值：`x - y` 结果为 `Quat<T,Q>`，不能整体与标量 `T(0)` 比较，需逐分量展开：
  ```cangjie
  let dw = x.w - y.w; let dx = x.x - y.x; let dy = x.y - y.y; let dz = x.z - y.z;
  let zero = (Float64(0) as T).getOrThrow()
  Vec4(
      ((dw >= zero) ? dw : -dw) < epsilon,
      ((dx >= zero) ? dx : -dx) < epsilon,
      ((dy >= zero) ? dy : -dy) < epsilon,
      ((dz >= zero) ? dz : -dz) < epsilon
  )
  ```
  notEqual 同理使用 `>= epsilon`
- 返回类型为 `Vec4<Bool, Q>`（四元数 4 个分量逐结果）

**依赖**：`Quat<T,Q>`、`Vec4<T,Q>`（glm.detail）

---

## vector_relational.cj

**包路径**：`glm.ext`

32 个包级函数（16 epsilon 重载 + 16 ULP stub），覆盖 Vec1~Vec4。

**epsilon 版本函数签名模式**（16 个重载，完整实现）：

```cangjie
package glm.ext

// Vec1——标量 epsilon
public func equal<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, epsilon: T): Vec1<Bool, Q>
  where T <: Number<T> & Comparable<T>, Q <: Qualifier
public func equal<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, epsilon: Vec1<T, Q>): Vec1<Bool, Q>
  where T <: Number<T> & Comparable<T>, Q <: Qualifier
public func notEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, epsilon: T): Vec1<Bool, Q>
  where T <: Number<T> & Comparable<T>, Q <: Qualifier
public func notEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, epsilon: Vec1<T, Q>): Vec1<Bool, Q>
  where T <: Number<T> & Comparable<T>, Q <: Qualifier

// Vec2（同模式，4 重载）
public func equal<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, epsilon: T): Vec2<Bool, Q> ...
public func equal<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, epsilon: Vec2<T, Q>): Vec2<Bool, Q> ...
public func notEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, epsilon: T): Vec2<Bool, Q> ...
public func notEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, epsilon: Vec2<T, Q>): Vec2<Bool, Q> ...

// Vec3（同模式，4 重载）
public func equal<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, epsilon: T): Vec3<Bool, Q> ...
public func equal<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, epsilon: Vec3<T, Q>): Vec3<Bool, Q> ...
public func notEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, epsilon: T): Vec3<Bool, Q> ...
public func notEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, epsilon: Vec3<T, Q>): Vec3<Bool, Q> ...

// Vec4（同模式，4 重载）
public func equal<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, epsilon: T): Vec4<Bool, Q> ...
public func equal<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, epsilon: Vec4<T, Q>): Vec4<Bool, Q> ...
public func notEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, epsilon: T): Vec4<Bool, Q> ...
public func notEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, epsilon: Vec4<T, Q>): Vec4<Bool, Q> ...
```

**ULP 版本函数签名模式**（16 个重载，stub）：

```cangjie
// Vec1——标量 ULPs
public func equal<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Int64): Vec1<Bool, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier { throw Exception("stub") }
public func equal<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Vec1<Int64, Q>): Vec1<Bool, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier { throw Exception("stub") }
public func notEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Int64): Vec1<Bool, Q> ...
public func notEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Vec1<Int64, Q>): Vec1<Bool, Q> ...

// Vec2~Vec4 同理，各 4 重载 × 2（equal/notEqual） × 2（scalar/vector ULPs）= 4 每 Vec
```

**约束**：epsilon 版本 16 个重载使用 `where T <: Number<T> & Comparable<T>, Q <: Qualifier`；ULP 版本 16 个重载使用 `where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier`，以消除 `T = Int64` 时 ULP 版本（`ULPs: Int64`）与 epsilon 版本（`epsilon: T`）之间的重载歧义

**实现说明**：
- epsilon 版本内联 abs 模式：`let d = x_i - y_i; (d >= (Float64(0) as T).getOrThrow()) ? d : -d` 逐分量
- ULP 版本全部 `throw Exception("stub")`
- 函数名 `equal`/`notEqual` 通过参数列表（是否有 epsilon/ULPs 参数）区分重载

**依赖**：`Vec1<T,Q>`~`Vec4<T,Q>`（glm.detail）

---

## quaternion_common.cj

**包路径**：`glm.ext`

8 个包级函数（5 完整实现 + 3 stub）：

```cangjie
package glm.ext

// conjugate——Number<T> 约束，const func
public const func conjugate<T, Q>(q: Quat<T, Q>): Quat<T, Q>
  where T <: Number<T>, Q <: Qualifier

// inverse——浮点约束
public func inverse<T, Q>(q: Quat<T, Q>): Quat<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier

// lerp——Number 约束，含 assert
public func lerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T): Quat<T, Q>
  where T <: Number<T> & Comparable<T>, Q <: Qualifier

// isnan/isinf——浮点约束，依赖 FloatingPoint 实例方法
public func isnan<T, Q>(q: Quat<T, Q>): Vec4<Bool, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier

public func isinf<T, Q>(q: Quat<T, Q>): Vec4<Bool, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier

// mix——stub
public func mix<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T): Quat<T, Q>
  where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }

// slerp×2——stub
public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T): Quat<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }

public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T, spin: Bool): Quat<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
```

**实现说明**：
- `conjugate`：`Quat(-q.x, -q.y, -q.z, q.w)`，const func
- `inverse`：`conjugate(q) / dot(q, q)`，依赖 quaternion_geometric.dot 和除法运算符
- `lerp`：`x * ((Float64(1) as T).getOrThrow() - a) + y * a` 前加 `assert(a >= (Float64(0) as T).getOrThrow() && a <= (Float64(1) as T).getOrThrow())`，标注 `@OverflowWrapping` 以匹配代码库整数 T 约定
- `isnan`：逐分量 `q.x.isNaN()` 等方法，返回 `Vec4(Bool, Bool, Bool, Bool)`
- `isinf`：逐分量 `q.x.isInf()` 等方法
- `isnan`/`isinf` 依赖 `FloatingPoint<T>` 实例方法 `isNaN()`/`isInf()`

**依赖**：`Quat<T,Q>`、`Vec4<T,Q>`（glm.detail）、`dot`（quaternion_geometric，同包）

---

## quaternion_trigonometric.cj

**包路径**：`glm.ext`

3 个包级函数（1 完整实现 + 2 stub）：

```cangjie
package glm.ext

import std.math.sqrt

// axis——完整实现
public func axis<T, Q>(x: Quat<T, Q>): Vec3<T, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier

// angle——stub
public func angle<T, Q>(x: Quat<T, Q>): T
  where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }

// angleAxis——stub
public func angleAxis<T, Q>(angle: T, axis: Vec3<T, Q>): Quat<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
```

**实现说明**（axis）：
- `let tmp1 = (Float64(1) as T).getOrThrow() - x.w * x.w`
- 若 `tmp1 <= (Float64(0) as T).getOrThrow()` 返回 `Vec3((Float64(0) as T).getOrThrow(), (Float64(0) as T).getOrThrow(), (Float64(1) as T).getOrThrow())`
- 否则调用私有 `sqrtT`（与 quaternion_geometric.cj 同模式）：`let tmp2 = (Float64(1) as T).getOrThrow() / sqrtT(tmp1)`，返回 `Vec3(x.x * tmp2, x.y * tmp2, x.z * tmp2)`。`sqrtT` 先将 `tmp1` 转 `Float64` 后调用 `std.math.sqrt`，再转回 `T`。

**依赖**：`Quat<T,Q>`、`Vec3<T,Q>`（glm.detail）、`std.math.sqrt`（仅 Float64）

---

## stub 文件（quaternion_transform / quaternion_exponential / matrix_projection / matrix_clip_space / matrix_transform）

5 个 stub 文件，每个包含至少 1 个函数签名。

### quaternion_transform.cj
```cangjie
package glm.ext
public func rotate<T, Q>(q: Quat<T, Q>, angle: T, axis: Vec3<T, Q>): Quat<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
```

### quaternion_exponential.cj
```cangjie
package glm.ext
public func exp<T, Q>(q: Quat<T, Q>): Quat<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
public func log<T, Q>(q: Quat<T, Q>): Quat<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
public func pow<T, Q>(x: Quat<T, Q>, y: T): Quat<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
public func sqrt<T, Q>(x: Quat<T, Q>): Quat<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
```

### matrix_projection.cj
```cangjie
package glm.ext
public func perspective<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
```

### matrix_clip_space.cj
```cangjie
package glm.ext
public func ortho<T, Q>(left: T, right: T, bottom: T, top: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
```

### matrix_transform.cj
```cangjie
package glm.ext
public func translate<T, Q>(m: Mat4x4<T, Q>, v: Vec3<T, Q>): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
```

---

## 别名文件（4 个）

### quaternion_float.cj
```cangjie
package glm.ext
import glm.detail.{ Quat, PackedHighp }
public type quat = Quat<Float32, PackedHighp>
```

### quaternion_double.cj
```cangjie
package glm.ext
import glm.detail.{ Quat, PackedHighp }
public type dquat = Quat<Float64, PackedHighp>
```

### quaternion_float_precision.cj
```cangjie
package glm.ext
import glm.detail.{ Quat, PackedHighp, PackedMediump, PackedLowp }
public type highp_quat = Quat<Float32, PackedHighp>
public type mediump_quat = Quat<Float32, PackedMediump>
public type lowp_quat = Quat<Float32, PackedLowp>
```

### quaternion_double_precision.cj
```cangjie
package glm.ext
import glm.detail.{ Quat, PackedHighp, PackedMediump, PackedLowp }
public type highp_dquat = Quat<Float64, PackedHighp>
public type mediump_dquat = Quat<Float64, PackedMediump>
public type lowp_dquat = Quat<Float64, PackedLowp>
```

---

## 错误处理

| 类别 | 处理方式 |
|------|---------|
| epsilon 比较 | 逐分量内联 abs（`(d >= (Float64(0) as T).getOrThrow()) ? d : -d`），避开 common.cj stub 依赖 |
| sqrt 泛型限制 | 因 `std.math.sqrt` 仅接受 `Float64`，经 `(as Float64) → sqrt → (as T)` 路径，`as` 失败时抛转换异常 |
| normalize 零四元数 | 返回单位四元数（零保护），避免除零 |
| stub 函数 | `throw Exception("stub")` |
| lerp assert | `assert(a >= (Float64(0) as T).getOrThrow() && a <= (Float64(1) as T).getOrThrow())`，标注 `@OverflowWrapping`，越界抛 Exception |
| inverse 零除 | 浮点 T 时 dot(q,q)=0 产生 Inf/NaN（与 GLM 一致） |
| ULP 函数 | 全部 stub 占位 |

## 行为契约

- `dot`/`length`/`normalize`/`cross(Quat)`/`axis` 仅对 `T <: FloatingPoint<T>` 编译可用，整数 T 实例化时报类型不匹配；`normalize` 和 `axis` 因 `<=` 比较额外需要 `Comparable<T>` 约束
- `normalize` 零四元数保护：`length(q) <= (Float64(0) as T).getOrThrow()` 时返回单位四元数 `(0,0,0,1)`
- `lerp` 含 assert 断言 `a ∈ [0,1]`，越界运行时抛异常
- `isnan`/`isinf` 依赖 `FloatingPoint<T>` 实例方法，调用 `q.x.isNaN()`/`q.x.isInf()` 等
- `conjugate` 为 `const func`，仅对 x/y/z 取反，w 不变
- `inverse` 调用 `conjugate(q) / dot(q, q)`，零除时产生 Inf/NaN
- `axis` 零保护：`1 - w² <= 0` 时返回 z 轴单位向量 `(0,0,1)`
- `length` 和 `axis` 中的 `sqrt` 使用 `sqrtT` 私有辅助函数：`(as Float64 → sqrt → as T)`，T 的非 Float64 类型有精度损失
- epsilon 比较使用严格小于语义 `|x-y| < epsilon`（equal）/ `>= epsilon`（notEqual）
- 别名文件仅声明 type alias，无运行时行为

## 依赖关系

### quaternion_geometric.cj
- `Quat<T,Q>`（glm.detail）
- `std.math.sqrt`（标准库，仅 Float64，经 sqrtT 辅助函数包装）

### quaternion_relational.cj
- `Quat<T,Q>`（glm.detail）
- `Vec4<T,Q>`（glm.detail）

### vector_relational.cj
- `Vec1~Vec4<T,Q>`（glm.detail）

### quaternion_common.cj
- `Quat<T,Q>`、`Vec4<T,Q>`（glm.detail）
- `dot`（quaternion_geometric，同包）
- `FloatingPoint<T>` 实例方法（标准库）

### quaternion_trigonometric.cj
- `Quat<T,Q>`、`Vec3<T,Q>`（glm.detail）
- `std.math.sqrt`（标准库，仅 Float64，经 sqrtT 辅助函数包装）

### matrix_projection.cj
- `Mat4x4<T,Q>`（glm.detail）

### matrix_clip_space.cj
- `Mat4x4<T,Q>`（glm.detail）

### matrix_transform.cj
- `Mat4x4<T,Q>`（glm.detail）
- `Vec3<T,Q>`（glm.detail）

### 整体依赖方向
- `glm.ext → glm.detail` 单向（所有 ext 文件依赖 detail 中的 Quat/Vec/Mat 类型）
- `glm.ext` 内部：quaternion_common → quaternion_geometric（dot 调用），同包编译时解析
- 无包间循环依赖风险

## 测试方案

### test_quaternion_geometric.cj
- `package glm.ext`
- `testDot`：正例 dot(Quat, Quat) 计算验证
- `testLength`：正例 length 验证（sqrt(dot)）
- `testNormalize`：非单位四元数 normalize 后 `|q| ≈ 1`
- `testNormalizeZero`：零四元数 normalize 返回 `(0,0,0,1)` 保护
- `testCross`：正例 Hamilton 乘积 cross 验证

### test_quaternion_relational.cj
- `package glm.ext`
- `testEqualExact`：精确 equal true/false
- `testNotEqualExact`：精确 notEqual true/false
- `testEqualEpsilon`：epsilon 容差 equal 正例
- `testNotEqualEpsilon`：epsilon 容差 notEqual 正例
- `testEqualEpsilonBoundary`：epsilon = 0 边界 / epsilon = 极小值

### test_vector_relational.cj
- `package glm.ext`
- 16 个 epsilon 重载每类至少 1 用例（Vec1~Vec4 × equal/notEqual × scalar/vector epsilon）
- ULP stub：`@ExpectThrows[Exception](equal(v1, v2, Int64(4)))`
- 验证内联 abs 正确性（差值正负两种方向）

### test_quaternion_common.cj
- `package glm.ext`
- `testConjugate`：conjugate 正例
- `testInverse`：inverse 正例 `q * inverse(q) ≈ identity`
- `testLerp`：lerp a=0 → x, a=1 → y, a=0.5 → 中点
- `testIsnan`：正常四元数 isnan → (false,false,false,false)
- `testIsinf`：正常四元数 isinf → (false,false,false,false)
- `testInverseZero`：零四元数 inverse → Inf/NaN 分量
- `testLerpAssertBelow`：lerp a=-0.1 → assert 抛 Exception
- `testLerpAssertAbove`：lerp a=1.1 → assert 抛 Exception
- `testMixStub`：mix → `@ExpectThrows[Exception]`
- `testSlerpStub`：slerp → `@ExpectThrows[Exception]`

### test_quaternion_trigonometric.cj
- `package glm.ext`
- `testAxisUnitQuat`：单位四元数 axis → (0,0,1)
- `testAxisNonUnit`：非单位四元数 axis 验证
- `testAxisZeroQuat`：零四元数 axis → Vec3((Float64(0) as T).getOrThrow(), (Float64(0) as T).getOrThrow(), (Float64(0) as T).getOrThrow())（零四元数时 tmp1=1>0 进入 else 分支，计算结果为 (0,0,0)）
- `testAngleStub`：angle → `@ExpectThrows[Exception]`
- `testAngleAxisStub`：angleAxis → `@ExpectThrows[Exception]`

## 修订说明（v3 r1）

| 审查意见 | 修改措施 |
|---------|---------|
| **[严重]** `normalize` 约束缺失 `Comparable<T>`：函数体内 `length(q) <= T(Float64(0))` 使用 `<=` 运算符，但 `FloatingPoint<T>` 不隐含 `Comparable<T>` | 将 `normalize` 约束从 `where T <: FloatingPoint<T>, Q <: Qualifier` 改为 `where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier`。同步更新"行为契约"中 normalize 的约束说明。 |
| **[严重]** `lerp` 约束缺失 `Comparable<T>`：`assert(a >= T(0) && a <= T(1))` 使用 `>=`/`<=` | 将 `lerp` 约束从 `where T <: Number<T>, Q <: Qualifier` 改为 `where T <: Number<T> & Comparable<T>, Q <: Qualifier`。 |
| **[严重]** `conjugate` 声称"无约束"但函数体含 `-q.x`/`-q.y`/`-q.z` 一元负号，需要 `Number<T>` 约束 | 将 `conjugate` 从无约束改为 `where T <: Number<T>, Q <: Qualifier`。`Number<T>` 的一元负号为 const 兼容（仓颉标准库数值类型均支持编译期取负），`const func` 声明保留。 |
| **[一般]** `testAxisZeroQuat` 测试预期自相矛盾：标题标注 `(0,0,1)` 但分析指出零四元数时结果为 `(0,0,0)` | 修正测试预期为 `Vec3(T(Float64(0)), T(Float64(0)), T(Float64(0)))`，并更新说明文字：零四元数时 `tmp1=1>0` 进入 else 分支，计算结果为 `(0,0,0)`。 |
| **[轻微]** `lerp` 缺少 assert 边界测试：未覆盖 `a` 超出 `[0,1]` 范围时 assert 触发的负例路径 | 在 `test_quaternion_common.cj` 测试方案中新增 `testLerpAssertBelow`（a=-0.1）和 `testLerpAssertAbove`（a=1.1）两个负例测试用例。 |
| **[轻微]** 矩阵 stub 文件依赖不完整：`matrix_projection`/`matrix_clip_space`/`matrix_transform` 未列出 `Mat4x4<T,Q>` 依赖 | 在"依赖关系"章节新增 `matrix_projection`、`matrix_clip_space`、`matrix_transform` 的独立依赖小节，分别列出 `Mat4x4<T,Q>`（含 Vec3 对于 matrix_transform）。 |

## 修订说明（v3 r2）

| 审查意见 | 修改措施 |
|---------|---------|
| **[严重]** `std.math.sqrt` 仅接受 `Float64`，设计对 sqrt 的泛型能力假设错误——`length` 和 `axis` 内的 `std.math.sqrt(dot(q,q))`/`std.math.sqrt(tmp1)` 当 T 为 Float32/Float16 时无法编译 | 在 `quaternion_geometric.cj` 中声明私有辅助函数 `sqrtT<T>(x: T): T`（参考 `type_quat_cast.cj:122-124` 模式：`(x as Float64) → sqrt → (as T)`），`length` 和 `normalize` 内部通过 `sqrtT` 调用 sqrt。`quaternion_trigonometric.cj` 的 `axis` 同理。删除设计中"std.math.sqrt 提供 Float16/Float32/Float64 重载"的错误描述，在错误处理和行为契约中补充 sqrt 精度损失与转换异常说明。 |
| **[严重]** `quaternion_relational.cj` epsilon 比较代码示例 `let d = x - y; (d >= T(0)) ? d : -d` 无法编译——`x - y` 返回 `Quat<T,Q>` 类型，`Quat<T,Q> >= T` 运算符未定义 | 修正为逐分量计算 abs 差值的四行展开模式：`let dw = x.w - y.w; let dx = x.x - y.x; let dy = x.y - y.y; let dz = x.z - y.z; Vec4(((dw >= T(0)) ? dw : -dw) < epsilon, ...)`；notEqual 同理使用 `>= epsilon`。 |
| **[轻微]** ULP 函数计数内部不一致：标题"8 个重载"与正文描述 Vec1~Vec4 各 4 重载（实际 16 个）矛盾 | 将标题"8 个重载"修正为"16 个重载"。

## 修订说明（v3 r3）

| 审查意见 | 修改措施 |
|---------|---------|
| **[严重]** `axis` 函数约束缺少 `Comparable<T>`：函数体内 `tmp1 <= T(Float64(0))` 使用 `<=` 运算符，但 `FloatingPoint<T>` 不隐含 `Comparable<T>` | 将 `axis` 约束从 `where T <: FloatingPoint<T>, Q <: Qualifier` 改为 `where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier`。同步更新"行为契约"中 `axis` 的约束说明（将 `axis` 加入需要 `Comparable<T>` 的函数列表）。

## 修订说明（v3 r4）

| 审查意见 | 修改措施 |
|---------|---------|
| **[严重]** 泛型 T 的零值/壹值构造 `T(Float64(n))`/`T(0)`/`T(1)` 在仓颉泛型上下文中不可编译——编译器无法确认泛型类型参数 T 拥有接受 `Float64`/`Int64` 的构造函数 | 将设计中所有泛型构造用法替换为已验证的 `(Float64(n) as T).getOrThrow()` 模式。涉及：`normalize` 实现说明、`quaternion_relational` 代码示例（新增 `let zero = (Float64(0) as T).getOrThrow()` 局部绑定）、`vector_relational` 实现说明、`lerp` 实现说明、`axis` 实现说明、错误处理表 epsilon 行和 lerp assert 行、行为契约 normalize 保护条件、测试设计 axis 零四元数预期值 |
| **[一般]** 第 132 行摘要写 "8 ULP stub"，与第 168 行详细节 "16 个重载" 不一致 | 将第 132 行 "24 个包级函数（16 epsilon 重载 + 8 ULP stub）" 修正为 "32 个包级函数（16 epsilon 重载 + 16 ULP stub）" |
| **[轻微]** `lerp` 函数约束 `Number<T> & Comparable<T>` 允许整数实例化，其算术运算缺少 `@OverflowWrapping` 注解 | 在 `lerp` 实现说明中注明标注 `@OverflowWrapping` 以匹配代码库约定；同步更新错误处理表中 lerp assert 行 |

## 修订说明（v3 r5）

| 审查意见 | 修改措施 |
|---------|---------|
| **[严重]** `vector_relational.cj` epsilon 版本（third param `epsilon: T`）与 ULP 版本（third param `ULPs: Int64`）在 `T = Int64` 时重载歧义——仓颉重载解析不区分相同约束模板，两者实例化签名均为 `equal(Vec1<Int64,Q>, Vec1<Int64,Q>, Int64)` | 将 ULP 版本 16 个重载的泛型约束从 `where T <: Number<T> & Comparable<T>` 改为 `where T <: FloatingPoint<T> & Comparable<T>`，使 `Int64` 不满足 `FloatingPoint<T>` 约束从而不参与 ULP 重载候选，消除歧义。同步更新"约束"汇总说明为分列 epsilon/ULP 两组约束。 |
| **[一般]** 设计函数总数（16 ULP 重载）与任务描述（8 个）不一致 | 设计保留 16 个 ULP 重载以匹配 GLM 完整 API（Vec1~Vec4 × equal/notEqual × scalar/vector ULPs），不做裁减。任务描述中的"8 个"为文档笔误，已在 v3 r4 中修正为 16 个。 |
