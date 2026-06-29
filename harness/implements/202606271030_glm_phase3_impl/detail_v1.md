# 详细设计（v1）

## 概述

实现 GLM Phase 3 的 detail 基础层：scalar_constants（3 个标量常量函数）和 trigonometric（75 个 stub 函数签名）。两者均仅依赖已有 `setup.cj`/`shim_limits.cj`，无交叉依赖，可合为一轮实现。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `src/detail/scalar_constants.cj` | 新建 | 定义 `epsilon<T>()`/`pi<T>()`/`cos_one_over_two<T>()` 完整实现 |
| `src/ext/scalar_constants.cj` | 新建 | 通过 `public import` 重导出 detail 中的 3 个函数 |
| `src/detail/trigonometric.cj` | 新建 | 声明 75 个三角函数 stub 签名（函数体 `throw Exception("stub")`） |
| `tests/glm/detail/test_scalar_constants.cj` | 新建 | scalar_constants 测试（交叉验证 epsilon、精度值验证、整数类型编译拒绝验证） |
| `tests/glm/detail/test_trigonometric_stub.cj` | 新建 | 验证 75 个 stub 签名存在且调用均抛 `Exception("stub")` |

## 类型定义

### epsilon<T> / pi<T> / cos_one_over_two<T>

**形态**：包级泛型函数
**包路径**：`glm.detail`（在 `src/detail/scalar_constants.cj` 中定义）
**职责**：提供标量数学常量的泛型浮点实现

```cangjie
package glm.detail

import std.math.FloatingPoint

public func epsilon<T>(): T where T <: FloatingPoint<T>
public func pi<T>(): T where T <: FloatingPoint<T>
public func cos_one_over_two<T>(): T where T <: FloatingPoint<T>
```

**公开接口**：
- `epsilon<T>(): T` — 委托 `epsilonOf<T>(T(Float64(0)))`（来自 `shim_limits.cj:25`）。注意引入 `epsilonOf` 已在同包 `shim_limits.cj` 中声明，无需额外 import
- `pi<T>(): T` — 使用 `FloatingPoint<T>.getPI()` 静态方法
- `cos_one_over_two<T>(): T` — 硬编码值：Float32 `0.877582561890372716`，Float64 `0.877582561890372716`

**构造方式**：函数调用直接获取值，无需构造
**类型关系**：无

**内部实现说明**：函数体内通过 `match (T(Float64(0)))` 运行时分派。`Float32`/`Float64` 类型由 `std.core` 自动导入，在作用域内可用。

### ext/scalar_constants.cj 重导出

**形态**：包级 public import
**包路径**：`glm.ext`
**职责**：将 detail 中的标量常数函数重导出至 glm.ext 命名空间

```cangjie
package glm.ext
public import glm.detail.{epsilon, pi, cos_one_over_two}
```

### trigonometric.cj — 75 个 stub 函数

**形态**：包级泛型函数（75 个独立签名）
**包路径**：`glm.detail`
**职责**：声明 14 组单参数三角函数 + 1 组双参数 atan2 的标量和向量签名，所有函数体统一 `throw Exception("stub")`

标准约束模板：
- 标量版本：`where T <: FloatingPoint<T>`
- 向量版本：`where T <: FloatingPoint<T>, Q <: Qualifier`

**函数分组**（每组 5 个签名：标量 + Vec1~Vec4）：

| 组 | 函数名 | 签名数 |
|----|--------|--------|
| 标准三角函数（6 组） | sin, cos, tan, asin, acos, atan | 30 |
| 双曲函数（3 组） | sinh, cosh, tanh | 15 |
| 反双曲函数（3 组） | asinh, acosh, atanh | 15 |
| 坐标转换（2 组） | radians, degrees | 10 |
| 双参数（1 组） | atan2 | 5 |
| **合计** | **15 组** | **75** |

**公共签名模板**（以 sin 为例）：
```cangjie
public func sin<T>(x: T): T where T <: FloatingPoint<T>
public func sin<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func sin<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func sin<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func sin<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
// 函数体: { throw Exception("stub") }
```

**atan2 双参数签名**：
```cangjie
public func atan2<T>(y: T, x: T): T where T <: FloatingPoint<T>
public func atan2<T, Q>(y: Vec1<T, Q>, x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func atan2<T, Q>(y: Vec2<T, Q>, x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func atan2<T, Q>(y: Vec3<T, Q>, x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func atan2<T, Q>(y: Vec4<T, Q>, x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
```

## 错误处理

- `epsilon<T>()`/`pi<T>()`/`cos_one_over_two<T>()` — `FloatingPoint<T>` 约束使整数类型编译期拒绝（类型系统保证，非运行时错误）
- trigonometric 75 个 stub — 所有函数体 `throw Exception("stub")`，运行时报错
- 整数类型实例化 trigonometric 函数同样由 `FloatingPoint<T>` 约束保证编译期拒绝

## 行为契约

### scalar_constants

| 函数 | Float32 返回值 | Float64 返回值 | 整数 T 行为 |
|------|---------------|---------------|------------|
| `epsilon<T>()` | `Float32(1.1920929e-7)` | `Float64(2.220446049250313e-16)` | 编译拒绝（`FloatingPoint<T>` 约束） |
| `pi<T>()` | `Float32(3.14159265358979323846)` | `Float64(3.14159265358979323846)` | 编译拒绝 |
| `cos_one_over_two<T>()` | `Float32(0.877582561890372716)` | `Float64(0.877582561890372716)` | 编译拒绝 |

### trigonometric stubs

- 所有 75 个函数存在且可被编译期解析
- 所有函数调用时抛出 `Exception("stub")`
- 标量版本可供 slerp/mix/pow/log/exp/angle/angleAxis 等四元数函数体的分量级运算引用
- 整数 T 实例化 trigonometric 函数编译拒绝（`FloatingPoint<T>` 约束）

## 依赖关系

### 依赖的已有类型/函数

| 新文件 | 依赖 | 来源 |
|-------|------|------|
| `detail/scalar_constants.cj` | `epsilonOf<T>(hint)` | `detail/shim_limits.cj:25`（同包，无需 import） |
| | `FloatingPoint<T>` | 标准库 `std.math`（需 `import std.math.FloatingPoint`） |
| | `FloatingPoint<T>.getPI()` | 标准库 `std.math` |
| | `Float32`/`Float64` | `std.core` 自动导入，作用域内可用 |
| `detail/trigonometric.cj` | `FloatingPoint<T>` | 标准库 `std.math` |
| | `Qualifier` | `detail/qualifier.cj` |
| | `Vec1~Vec4` | `detail/type_vec*.cj` |
| `tests/*` | `@Test`/`@Expect`/`@ExpectThrows` | 标准库 `std.unittest` |

### 暴露给后续任务的接口

- `glm.detail.epsilon<T>()` / `glm.detail.pi<T>()` / `glm.detail.cos_one_over_two<T>()` — 被 `gtc/constants.cj`、`ext/quaternion_trigonometric.cj` 使用
- `glm.ext.epsilon` / `glm.ext.pi` / `glm.ext.cos_one_over_two` — 重导出至 ext 命名空间
- `glm.detail.{sin, cos, tan, ...}(标量)` — 被 `slerp`/`mix`/`pow`/`log`/`exp`/`angle`/`angleAxis` 等函数引用（本阶段为 stub）
- `glm.detail.{sin, cos, tan, ...}(VecN)` — 被阶段四 vec 级运算使用（本阶段为 stub）

## 测试方案

### test_scalar_constants.cj

**包声明**：`package glm.detail`

1. **epsilon 交叉验证**：对 Float32/Float64，验证 `epsilon<T>() == epsilonOf<T>(T(0.0))`
2. **Epsilon 精度值验证**：`@Expect(epsilon<Float32>(), Float32(1.1920929e-7))` / `@Expect(epsilon<Float64>(), Float64(2.220446049250313e-16))`
3. **Pi 精度值验证**：`@Expect(pi<Float32>(), Float32(3.14159265358979323846))` / `@Expect(pi<Float64>(), Float64(3.14159265358979323846))`
4. **cos_one_over_two 精度值验证**：Float32/Float64 各一个测试
5. **整数类型编译拒绝验证**：`FloatingPoint<T>` 类型约束本身即为编译期保证——任何用整数类型（如 `Int64`）实例化 `epsilon<T>()`/`pi<T>()`/`cos_one_over_two<T>()` 的代码均无法通过编译。此处无需独立的运行时测试文件；若需显式验证，可创建 `tools/verify_compile_reject/compile_reject_scalar_constants.cj` 由外部 CI 脚本调用 `cjc` 验证编译失败（该文件不纳入 `cjpm test` 的主测试编译路径）。

### test_trigonometric_stub.cj

**包声明**：`package glm.detail`

1. **每个函数组标量版本**：使用 `@ExpectThrows[Exception](sin<Float32>(0.0f32))` 验证标量版本抛异常，覆盖 15 个标量函数
2. **每个函数组向量版本**：使用 `@ExpectThrows[Exception](sin<Float32, Defaultp>(Vec1(0.0f32)))` 验证 Vec1 版本抛异常（同一 body 模板，Vec1 可代表所有 VecN）
3. **总量验证**：最低 15 个测试用例（每组 1 个）+ 可选覆盖全部 75 个

## 修订说明（v1 r1）
| 审查意见 | 修改措施 |
|---------|---------|
| [一般] §测试方案中使用不存在的 `assertThrows` 函数 | 将 `assertThrows(() => ..., Exception("stub"))` 替换为 `@ExpectThrows[Exception](...)` 宏（与现有 `test_scalar_vec_ops.cj:241` 等处的用法一致），并移除 Lambda 包装层 |
| [一般] Int64 编译拒绝测试方案未确认 | 明确策略：`FloatingPoint<T>` 类型约束本身即为编译期保证，无需额外运行时测试；如需显式验证可创建外部 CI 脚本。已在 §测试方案第 5 项中完整阐述 |
| [轻微] Float32 字面量 `0.0f` 语法无效 | 测试代码片段中所有 Float32 字面量修正为 `0.0f32`（与项目现有风格一致，见 `test_scalar_vec_ops.cj:314` 等） |
| [轻微] 测试文件 package 声明未明确 | §测试方案中两个测试文件均明确标注 `package glm.detail`（与 `test_shim_limits.cj:1` 等现有测试文件惯例一致） |
| [轻微] scalar_constants.cj import 不完整 | §类型定义中补充说明：`epsilonOf` 属同包无需 import；`Float32`/`Float64` 由 `std.core` 自动导入；`import std.math.FloatingPoint` 已在代码片段中标注 |
