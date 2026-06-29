# 详细设计（v4）

## 概述
实现 GLM Phase 3 gtc 子包层：`glm.gtc` 包下 5 个源文件（2 个构建原型验证文件 + 3 个正式文件）及对应的 2 个测试文件。构建原型验证通过后删除 proto 文件，保留 constants/quaternion/matrix_transform 三个正式文件。

## 文件规划

### 源文件
| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `src/gtc/proto_gtc.cj` | 新建（验证后删除） | 构建原型验证：声明 `package glm.gtc` + 1 个公共函数 |
| `src/gtc/proto_export.cj` | 新建（验证后删除） | 构建原型验证：`public import` 重导出 detail 函数 |
| `src/gtc/constants.cj` | 新建 | 28 个数学常量函数完整实现 |
| `src/gtc/quaternion.cj` | 新建 | 15 个 gtc 四元数函数（4 重导出 + 4 完整实现 + 7 stub） |
| `src/gtc/matrix_transform.cj` | 新建 | 64 个矩阵变换 stub 签名 |

### 测试文件
| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `tests/glm/gtc/test_constants.cj` | 新建 | 28 个常量函数 Float32/Float64 验证 |
| `tests/glm/gtc/test_quaternion.cj` | 新建 | 比较函数正例 + stub assertThrows |

## 类型定义

所有函数均为包级 `public func`，在 `package glm.gtc` 中定义，无新类型定义。

---

## proto_gtc.cj（构建原型验证）

**包路径**：`glm.gtc`

```cangjie
package glm.gtc

public func protoGtcTest(): Int64 { Int64(42) }
```

**职责**：验证 cjpm 能识别 `package glm.gtc` 声明并正确编译。

---

## proto_export.cj（构建原型验证）

**包路径**：`glm.gtc`

```cangjie
package glm.gtc
public import glm.detail.{mat3Cast, mat4Cast, quatCast}
```

**职责**：验证 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 能正确将 detail 包级函数重导出至 glm.gtc 命名空间。

---

## gtc/constants.cj

**包路径**：`glm.gtc`

28 个泛型常量函数，全部约束 `where T <: FloatingPoint<T>`。每函数体模式：
```cangjie
public func <name><T>(): T where T <: FloatingPoint<T> {
    (Float64(<硬编码值>) as T).getOrThrow()
}
```

下表列出全部 28 个函数签名和硬编码值：

| # | 函数 | 返回类型 | Float64 值 |
|---|------|---------|-----------|
| 1 | `zero<T>()` | T | `0.0` |
| 2 | `one<T>()` | T | `1.0` |
| 3 | `two_pi<T>()` | T | `6.2831853071795864769` |
| 4 | `tau<T>()` | T | `6.2831853071795864769` |
| 5 | `root_pi<T>()` | T | `1.7724538509055160273` |
| 6 | `half_pi<T>()` | T | `1.5707963267948966192` |
| 7 | `three_over_two_pi<T>()` | T | `4.7123889803846898577` |
| 8 | `quarter_pi<T>()` | T | `0.7853981633974483096` |
| 9 | `one_over_pi<T>()` | T | `0.3183098861837906715` |
| 10 | `one_over_two_pi<T>()` | T | `0.1591549430918953358` |
| 11 | `two_over_pi<T>()` | T | `0.6366197723675813431` |
| 12 | `four_over_pi<T>()` | T | `1.2732395447351626861` |
| 13 | `two_over_root_pi<T>()` | T | `1.1283791670955125739` |
| 14 | `one_over_root_two<T>()` | T | `0.7071067811865475244` |
| 15 | `root_half_pi<T>()` | T | `1.2533141373155002512` |
| 16 | `root_two_pi<T>()` | T | `2.5066282746310005024` |
| 17 | `root_ln_four<T>()` | T | `1.1774100225154746910` |
| 18 | `e<T>()` | T | `2.71828182845904523536` |
| 19 | `euler<T>()` | T | `0.5772156649015328606` |
| 20 | `root_two<T>()` | T | `1.4142135623730950488` |
| 21 | `root_three<T>()` | T | `1.7320508075688772935` |
| 22 | `root_five<T>()` | T | `2.2360679774997896964` |
| 23 | `ln_two<T>()` | T | `0.6931471805599453094` |
| 24 | `ln_ten<T>()` | T | `2.3025850929940456840` |
| 25 | `ln_ln_two<T>()` | T | `-0.3665129205816643270` |
| 26 | `third<T>()` | T | `0.3333333333333333333` |
| 27 | `two_thirds<T>()` | T | `0.6666666666666666667` |
| 28 | `golden_ratio<T>()` | T | `1.6180339887498948482` |

**依赖**：仅依赖标准库 `FloatingPoint<T>`，无包内依赖。

---

## gtc/quaternion.cj

**包路径**：`glm.gtc`

### import 清单

```cangjie
package glm.gtc
import glm.detail.*
public import glm.detail.{mat3Cast, mat4Cast, quatCast}
import glm.ext.vector_relational.*
import glm.ext.scalar_constants.*
```

### 重导出函数（4 个）

通过 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 将 detail 包级函数重导出至 `glm.gtc` 命名空间。无需在文件中额外声明同名函数。

### 比较函数完整实现（4 个）

所有比较函数约束 `where T <: Comparable<T>, Q <: Qualifier`（不要求 `FloatingPoint`，允许整数 T）：

```cangjie
public func lessThan<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>): Vec4<Bool, Q>
  where T <: Comparable<T>, Q <: Qualifier
  { Vec4(x.x < y.x, x.y < y.y, x.z < y.z, x.w < y.w) }

public func lessThanEqual<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>): Vec4<Bool, Q>
  where T <: Comparable<T>, Q <: Qualifier
  { Vec4(x.x <= y.x, x.y <= y.y, x.z <= y.z, x.w <= y.w) }

public func greaterThan<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>): Vec4<Bool, Q>
  where T <: Comparable<T>, Q <: Qualifier
  { Vec4(x.x > y.x, x.y > y.y, x.z > y.z, x.w > y.w) }

public func greaterThanEqual<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>): Vec4<Bool, Q>
  where T <: Comparable<T>, Q <: Qualifier
  { Vec4(x.x >= y.x, x.y >= y.y, x.z >= y.z, x.w >= y.w) }
```

### Stub 函数（7 个）

全部约束 `where T <: FloatingPoint<T>, Q <: Qualifier`，函数体 `throw Exception("stub")`：

```cangjie
public func eulerAngles<T, Q>(x: Quat<T, Q>): Vec3<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier
public func roll<T, Q>(q: Quat<T, Q>): T
  where T <: FloatingPoint<T>, Q <: Qualifier
public func pitch<T, Q>(q: Quat<T, Q>): T
  where T <: FloatingPoint<T>, Q <: Qualifier
public func yaw<T, Q>(q: Quat<T, Q>): T
  where T <: FloatingPoint<T>, Q <: Qualifier
public func quatLookAt<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier
public func quatLookAtRH<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier
public func quatLookAtLH<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier
```

**依赖**：
- `glm.detail.*`（Quat, Vec3, Vec4, Mat3x3, Mat4x4, Qualifier）
- `glm.detail.{mat3Cast, mat4Cast, quatCast}`（public import 重导出）
- `glm.ext.vector_relational.*`（equal）
- `glm.ext.scalar_constants.*`（epsilon）

---

## gtc/matrix_transform.cj

**包路径**：`glm.gtc`

64 个函数，全部约束 `where T <: FloatingPoint<T>, Q <: Qualifier`，函数体统一 `throw Exception("stub")`。

### 1. 基础变换（11 个函数）

```cangjie
public func identity<T, Q>(): Mat4x4<T, Q>
public func translate<T, Q>(m: Mat4x4<T, Q>, v: Vec3<T, Q>): Mat4x4<T, Q>
public func rotate<T, Q>(m: Mat4x4<T, Q>, angle: T, axis: Vec3<T, Q>): Mat4x4<T, Q>
public func rotate_slow<T, Q>(m: Mat4x4<T, Q>, angle: T, axis: Vec3<T, Q>): Mat4x4<T, Q>
public func scale<T, Q>(m: Mat4x4<T, Q>, v: Vec3<T, Q>): Mat4x4<T, Q>
public func scale_slow<T, Q>(m: Mat4x4<T, Q>, v: Vec3<T, Q>): Mat4x4<T, Q>
public func shear<T, Q>(m: Mat4x4<T, Q>, n: Vec3<T, Q>, s: T): Mat4x4<T, Q>
public func shear_slow<T, Q>(m: Mat4x4<T, Q>, n: Vec3<T, Q>, s: T): Mat4x4<T, Q>
public func lookAtRH<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>
public func lookAtLH<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>
public func lookAt<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>
```

### 2. ortho 系族（10 个函数）

```cangjie
public func ortho<T, Q>(left: T, right: T, bottom: T, top: T): Mat4x4<T, Q>
public func ortho<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func orthoLH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func orthoLH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func orthoRH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func orthoRH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func orthoZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func orthoNO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func orthoLH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func orthoRH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
```

### 3. frustum 系族（9 个函数）

```cangjie
public func frustum<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func frustumLH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func frustumLH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func frustumRH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func frustumRH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func frustumZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func frustumNO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func frustumLH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func frustumRH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
```

### 4. perspective 系族（9 个函数）

```cangjie
public func perspective<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func perspectiveLH_ZO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func perspectiveLH_NO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func perspectiveRH_ZO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func perspectiveRH_NO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func perspectiveZO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func perspectiveNO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func perspectiveLH<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func perspectiveRH<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
```

### 5. perspectiveFov 系族（9 个函数）

```cangjie
public func perspectiveFov<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func perspectiveFovLH_ZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func perspectiveFovLH_NO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func perspectiveFovRH_ZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func perspectiveFovRH_NO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func perspectiveFovZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func perspectiveFovNO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func perspectiveFovLH<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
public func perspectiveFovRH<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
```

### 6. infinitePerspective 系族（7 个函数）

```cangjie
public func infinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
public func infinitePerspectiveLH_ZO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
public func infinitePerspectiveLH_NO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
public func infinitePerspectiveRH_ZO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
public func infinitePerspectiveRH_NO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
public func infinitePerspectiveLH<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
public func infinitePerspectiveRH<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
```

### 7. tweakedInfinitePerspective 系族（2 个函数）

```cangjie
public func tweakedInfinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T, ep: T): Mat4x4<T, Q>
public func tweakedInfinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
```

### 8. 投影工具（6 个函数）

```cangjie
public func projectZO<T, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
public func projectNO<T, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
public func project<T, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
public func unProjectZO<T, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
public func unProjectNO<T, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
public func unProject<T, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
```

### 9. 拾取矩阵（1 个函数）

```cangjie
public func pickMatrix<T, Q>(center: Vec2<T, Q>, delta: Vec2<T, Q>, viewport: Vec4<T, Q>): Mat4x4<T, Q>
```

**函数计数**：11 + 10 + 9 + 9 + 9 + 7 + 2 + 6 + 1 = **64 个函数**

**依赖**：
- `glm.detail`（Mat4x4, Vec2, Vec3, Vec4, Qualifier, FloatingPoint）
- 函数体均为 stub `throw Exception("stub")`，无运行时依赖

## 错误处理

| 类别 | 处理方式 |
|------|---------|
| constants 返回值 | 硬编码 Float64 字面量 `(Float64(n) as T).getOrThrow()`，转换失败抛异常 |
| 比较函数 | 纯算术比较，无错误产生 |
| stub 函数 | `throw Exception("stub")` |
| 构建原型验证失败 | 降级方案：gtc/ 文件迁移至 src/ 根目录，包声明降级为 `package glm` |

## 行为契约

- 28 个常量函数均为 `FloatingPoint<T>` 约束，仅对浮点 T 可用；整数 T 实例化时报类型不匹配
- 4 个比较函数 `Comparable<T>` 约束，对任何可比较 T（含整数、浮点）均可实例化
- 7 个 gtc quaternion stub（eulerAngles/roll/pitch/yaw/quatLookAt/quatLookAtRH/quatLookAtLH）和全部 64 个 matrix_transform stub 运行时抛 `Exception("stub")`
- 4 个重导出函数（mat3Cast/mat4Cast/quatCast）通过 `public import` 转发表层引用，行为与 detail 端一致
- 构建原型验证：proto_gtc.cj 和 proto_export.cj 编译通过后删除

## 依赖关系

### constants.cj
- `std.math.FloatingPoint`（标准库）

### quaternion.cj
- `glm.detail.*`（Quat, Vec3, Vec4, Mat3x3, Mat4x4, Qualifier 等）
- `glm.detail.{mat3Cast, mat4Cast, quatCast}`（public import 重导出）
- `glm.ext.vector_relational.*`（equal/notEqual epsilon 版本）
- `glm.ext.scalar_constants.*`（epsilon）

### matrix_transform.cj
- `glm.detail.*`（Mat4x4, Vec2, Vec3, Vec4, Qualifier 等）

### 测试文件
- test_constants.cj → `glm.gtc`（同包 constants 函数）
- test_quaternion.cj → `glm.gtc`（同包 quaternion 函数）+ `glm.detail.*`（Quat/Defaultp）

### 包间依赖方向
- `glm.gtc → glm.detail` 单向
- `glm.gtc → glm.ext` 单向
- `glm.gtc` 不依赖 `glm` 顶层包
- 无循环依赖

## 测试方案

### test_constants.cj
- `package glm.gtc`
- 每常量至少 1 用例，覆盖 Float32 和 Float64 返回值验证
- 原则：28 个函数 × 2 种浮点类型 = 至少 56 条断言
- 验证模式和预期值：
  - `zero<Float32>()` → `Float32(0.0)`
  - `zero<Float64>()` → `Float64(0.0)`
  - `one<Float32>()` → `Float32(1.0)`
  - `one<Float64>()` → `Float64(1.0)`
  - 其余常量类似，验证硬编码值与预期字面量一致
- 示例：
  ```cangjie
  @Test func testZeroFloat32(): Unit {
      @Expect(zero<Float32>(), Float32(0.0))
  }
  ```

### test_quaternion.cj
- `package glm.gtc`
- **比较函数正例**（4 个测试，每函数至少 1 用例）：
  - `testLessThan`：x < y 逐分量比较
  - `testLessThanEqual`：x <= y 逐分量比较
  - `testGreaterThan`：x > y 逐分量比较
  - `testGreaterThanEqual`：x >= y 逐分量比较
- **边界测试**（1 个测试）：
  - `testAllComponentsEqual`：所有分量相等时 `lessThan`/`greaterThan` 返回全部 false
- **Stub 测试**（7 个，每 stub 函数 1 个 `@ExpectThrows[Exception]` 用例）：
  - `testEulerAnglesStub`：`@ExpectThrows[Exception](eulerAngles(q))`
  - `testRollStub`：`@ExpectThrows[Exception](roll(q))`
  - `testPitchStub`：`@ExpectThrows[Exception](pitch(q))`
  - `testYawStub`：`@ExpectThrows[Exception](yaw(q))`
  - `testQuatLookAtStub`：`@ExpectThrows[Exception](quatLookAt(dir, up))`
  - `testQuatLookAtRHStub`：`@ExpectThrows[Exception](quatLookAtRH(dir, up))`
  - `testQuatLookAtLHStub`：`@ExpectThrows[Exception](quatLookAtLH(dir, up))`
- 验证时使用 `Quat<Float64, Defaultp>` 实例
