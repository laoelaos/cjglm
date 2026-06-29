# 任务指令（v4）

## 动作
NEW

## 任务描述
实现 gtc/ 子包（`package glm.gtc`）：构建原型验证 + 28 个数学常量 + 15 个 gtc 四元数函数（4 重导出 + 4 完整实现 + 7 stub）+ 64 个矩阵变换 stub 签名。

**源文件**（新建至 `src/gtc/`）：
- `src/gtc/proto_gtc.cj` — 构建原型验证文件（验证后删除）
- `src/gtc/proto_export.cj` — 构建原型验证重导出文件（验证后删除）
- `src/gtc/constants.cj` — 28 个数学常量函数完整实现
- `src/gtc/quaternion.cj` — 15 个 gtc 四元数函数（4 重导出 + 4 完整 + 7 stub）
- `src/gtc/matrix_transform.cj` — 64 个矩阵变换 stub 签名

**测试文件**（新建至 `tests/glm/gtc/`）：
- `tests/glm/gtc/test_constants.cj` — 28 个常量函数验证
- `tests/glm/gtc/test_quaternion.cj` — 比较函数正例 + stub assertThrows

## 选择理由
本轮实现 gtc/ 子包，是计划中 R4 任务（按实施路线表）。gtc/ 子包是 GLM Phase 3 的倒数第二层——依赖 R1 的 detail 基础层（scalar_constants）、R2 的四元数类型体系（Quat 结构体 + type_quat_cast 转换函数）、R3 的 ext 函数库（vector_relational + scalar_constants 重导出），而 gtc/ 的产出（constants、quaternion、matrix_transform）将在 R5 lib.cj 更新 + fwd.cj 生成脚本 + 全库构建验证中汇总。前置构建原型验证确保 cjpm 能识别 `package glm.gtc` 子包；若不通过，所有 gtc/ 文件降级至 `package glm` 并在 `src/` 根目录存放。

## 任务上下文

### (a) 构建原型验证
- 在 `src/gtc/` 下创建 `proto_gtc.cj`（`package glm.gtc`，声明 1 个公共函数）和 `proto_export.cj`（`package glm.gtc`，public import 重导出 detail 函数）
- 执行 `cjpm build` 验证编译通过
- 验证项 1（gtc 子包）：cjpm 是否能识别 `package glm.gtc` 声明
- 验证项 2（gtc 重导出）：`public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 是否能正确将 detail 包级函数重导出至 glm.gtc 命名空间
- **回退方案**：若 cjpm 不支持 `src/gtc/` 子目录的子包发现机制，将 gtc/ 文件迁移至 `src/` 根目录并降级为 `package glm`
- 验证通过后删除 `proto_gtc.cj` 和 `proto_export.cj`

### (b) gtc/constants.cj
**包路径**：`glm.gtc`

28 个常量泛型函数，全部约束 `where T <: FloatingPoint<T>`，硬编码值直接返回：

| 函数 | 返回类型 | Float32 值 | Float64 值 |
|------|---------|-----------|-----------|
| `zero<T>()` | T | `Float32(0.0)` | `Float64(0.0)` |
| `one<T>()` | T | `Float32(1.0)` | `Float64(1.0)` |
| `two_pi<T>()` | T | `Float32(6.2831853071795864769)` | `Float64(6.2831853071795864769)` |
| `tau<T>()` | T | `Float32(6.2831853071795864769)` | 同上 |
| `root_pi<T>()` | T | `Float32(1.7724538509055160273)` | `Float64(1.7724538509055160273)` |
| `half_pi<T>()` | T | `Float32(1.5707963267948966192)` | `Float64(1.5707963267948966192)` |
| `three_over_two_pi<T>()` | T | `Float32(4.7123889803846898577)` | `Float64(4.7123889803846898577)` |
| `quarter_pi<T>()` | T | `Float32(0.7853981633974483096)` | `Float64(0.7853981633974483096)` |
| `one_over_pi<T>()` | T | `Float32(0.3183098861837906715)` | `Float64(0.3183098861837906715)` |
| `one_over_two_pi<T>()` | T | `Float32(0.1591549430918953358)` | `Float64(0.1591549430918953358)` |
| `two_over_pi<T>()` | T | `Float32(0.6366197723675813431)` | `Float64(0.6366197723675813431)` |
| `four_over_pi<T>()` | T | `Float32(1.2732395447351626861)` | `Float64(1.2732395447351626861)` |
| `two_over_root_pi<T>()` | T | `Float32(1.1283791670955125739)` | `Float64(1.1283791670955125739)` |
| `one_over_root_two<T>()` | T | `Float32(0.7071067811865475244)` | `Float64(0.7071067811865475244)` |
| `root_half_pi<T>()` | T | `Float32(1.2533141373155002512)` | `Float64(1.2533141373155002512)` |
| `root_two_pi<T>()` | T | `Float32(2.5066282746310005024)` | `Float64(2.5066282746310005024)` |
| `root_ln_four<T>()` | T | `Float32(1.1774100225154746910)` | `Float64(1.1774100225154746910)` |
| `e<T>()` | T | `Float32(2.71828182845904523536)` | `Float64(2.71828182845904523536)` |
| `euler<T>()` | T | `Float32(0.5772156649015328606)` | `Float64(0.5772156649015328606)` |
| `root_two<T>()` | T | `Float32(1.4142135623730950488)` | `Float64(1.4142135623730950488)` |
| `root_three<T>()` | T | `Float32(1.7320508075688772935)` | `Float64(1.7320508075688772935)` |
| `root_five<T>()` | T | `Float32(2.2360679774997896964)` | `Float64(2.2360679774997896964)` |
| `ln_two<T>()` | T | `Float32(0.6931471805599453094)` | `Float64(0.6931471805599453094)` |
| `ln_ten<T>()` | T | `Float32(2.3025850929940456840)` | `Float64(2.3025850929940456840)` |
| `ln_ln_two<T>()` | T | `Float32(-0.3665129205816643270)` | `Float64(-0.3665129205816643270)` |
| `third<T>()` | T | `Float32(0.3333333333333333333)` | `Float64(0.3333333333333333333)` |
| `two_thirds<T>()` | T | `Float32(0.6666666666666666667)` | `Float64(0.6666666666666666667)` |
| `golden_ratio<T>()` | T | `Float32(1.6180339887498948482)` | `Float64(1.6180339887498948482)` |

每函数体：`T(Float64(硬编码值))` 模式，例如 `func zero<T>(): T where T <: FloatingPoint<T> { (Float64(0.0) as T).getOrThrow() }`

依赖：无外部依赖，仅依赖标准库 `FloatingPoint<T>`

### (c) gtc/quaternion.cj
**包路径**：`glm.gtc`

#### import 清单
```cangjie
import glm.detail.*
public import glm.detail.{mat3Cast, mat4Cast, quatCast}
import glm.ext.vector_relational.*
import glm.ext.scalar_constants.*
```

#### 重导出函数（4 个）
```cangjie
// 通过 public import 重导出，无需在文件中重复声明
// public import glm.detail.{mat3Cast, mat4Cast, quatCast} 已完成
```

#### 比较函数完整实现（4 个）
约束 `where T <: Comparable<T>, Q <: Qualifier`：

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

#### Stub 函数（7 个）
约束 `where T <: FloatingPoint<T>, Q <: Qualifier`，函数体 `throw Exception("stub")`：

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

### (d) gtc/matrix_transform.cj
**包路径**：`glm.gtc`

64 个函数，全部约束 `where T <: FloatingPoint<T>, Q <: Qualifier`，函数体统一 `throw Exception("stub")`。

按 9 个分类列出：

**1. 基础变换（11 个函数）**
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

**2. ortho 系族（10 个函数）**
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

**3. frustum 系族（9 个函数）**
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

**4. perspective 系族（9 个函数）**
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

**5. perspectiveFov 系族（9 个函数）**
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

**6. infinitePerspective 系族（7 个函数）**
```cangjie
public func infinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
public func infinitePerspectiveLH_ZO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
public func infinitePerspectiveLH_NO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
public func infinitePerspectiveRH_ZO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
public func infinitePerspectiveRH_NO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
public func infinitePerspectiveLH<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
public func infinitePerspectiveRH<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
```

**7. tweakedInfinitePerspective 系族（2 个函数）**
```cangjie
public func tweakedInfinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T, ep: T): Mat4x4<T, Q>
public func tweakedInfinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
```

**8. 投影工具（6 个函数）**
```cangjie
public func projectZO<T, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
public func projectNO<T, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
public func project<T, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
public func unProjectZO<T, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
public func unProjectNO<T, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
public func unProject<T, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
```

**9. 拾取矩阵（1 个函数）**
```cangjie
public func pickMatrix<T, Q>(center: Vec2<T, Q>, delta: Vec2<T, Q>, viewport: Vec4<T, Q>): Mat4x4<T, Q>
```

合计：11 + 10 + 9 + 9 + 9 + 7 + 2 + 6 + 1 = **64 个函数**

## 测试方案

### test_constants.cj
- `package glm.gtc`
- 每常量函数至少 1 用例，验证 Float32 和 Float64 返回值
- 验证硬编码值与预期一致

### test_quaternion.cj
- `package glm.gtc`
- 比较函数：`lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual` 正例（每函数 1-2 用例）
- 边界：所有分量相等时的 `lessThan`/`greaterThan` 返回全 false
- stub 测试：7 个 stub 函数各 1 个 `@ExpectThrows[Exception]` 用例

## 依赖关系
- `constants.cj` → `glm.ext.scalar_constants`（间接依赖 `glm.detail.scalar_constants`）
- `quaternion.cj` → `glm.detail.*`（Quat/Vec3/Mat3x3/Mat4x4）
- `quaternion.cj` → `glm.detail.{mat3Cast, mat4Cast, quatCast}`（public import 重导出）
- `quaternion.cj` → `glm.ext.vector_relational.*`（equal）
- `quaternion.cj` → `glm.ext.scalar_constants.*`（epsilon<T>）
- `matrix_transform.cj` → stub（64 函数仅签名）
