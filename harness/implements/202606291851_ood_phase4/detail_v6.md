# 详细设计（v6）

## 概述

实现 `ext/scalar_common.cj`（package `glm.ext`）的 17 个标量公共扩展函数，对标 GLM 1.0.3 `ext/scalar_common.hpp`。同时创建配套测试文件 `tests/glm/ext/scalar_common_test.cj`。

本任务属于阶段四实施路线第一批（无函数库内部依赖），依赖 `glm.detail.common`（已就绪）和 `glm.detail.stdmath_shim`（已就绪）。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `src/ext/scalar_common.cj` | 新建 | package `glm.ext`，17 个标量扩展函数 |
| `tests/glm/ext/scalar_common_test.cj` | 新建 | 每个函数至少 1~2 个测试用例 |

## 类型定义

### 分组 1：3/4 输入标量 min/max（4 个函数）

**形态**：包级泛型函数
**包路径**：`glm.ext`

```cangjie
public func min<T>(a: T, b: T, c: T): T where T <: Number<T> & Comparable<T>
public func min<T>(a: T, b: T, c: T, d: T): T where T <: Number<T> & Comparable<T>
public func max<T>(a: T, b: T, c: T): T where T <: Number<T> & Comparable<T>
public func max<T>(a: T, b: T, c: T, d: T): T where T <: Number<T> & Comparable<T>
```

**实现路径**：层叠委托 `glm.detail.min(a, b)` / `glm.detail.max(a, b)`。例如 `min(a,b,c) = min(min(a,b), c)`。

### 分组 2：NaN 安全 min 系列（3 个函数）

**形态**：包级泛型函数
**包路径**：`glm.ext`

```cangjie
public func fmin<T>(a: T, b: T): T where T <: FloatingPoint<T> & Comparable<T>
public func fmin<T>(a: T, b: T, c: T): T where T <: FloatingPoint<T> & Comparable<T>
public func fmin<T>(a: T, b: T, c: T, d: T): T where T <: FloatingPoint<T> & Comparable<T>
```

**约束说明**：任务规格仅标记 `FloatingPoint<T>`，但实际实现需要 `Comparable<T>`（用于 `a < b` 比较或委托 `min`）。本设计采用 `FloatingPoint<T> & Comparable<T>`。

**实现路径**：
- 2 输入：`if (isnan(a)) return b; if (isnan(b)) return a; min(a, b)`（或内联 `a < b ? a : b`）
- 3/4 输入：层叠调用 2 输入 `fmin`

### 分组 3：NaN 安全 max 系列（3 个函数）

**形态**：包级泛型函数
**包路径**：`glm.ext`

```cangjie
public func fmax<T>(a: T, b: T): T where T <: FloatingPoint<T> & Comparable<T>
public func fmax<T>(a: T, b: T, c: T): T where T <: FloatingPoint<T> & Comparable<T>
public func fmax<T>(a: T, b: T, c: T, d: T): T where T <: FloatingPoint<T> & Comparable<T>
```

**实现路径**：同 fmin 模式，`if (isnan(a)) return b; if (isnan(b)) return a; max(a, b)`。

### 分组 4：fclamp（1 个函数）

```cangjie
public func fclamp<T>(x: T, minVal: T, maxVal: T): T where T <: FloatingPoint<T> & Comparable<T>
```

**实现路径**：`fmin(fmax(x, minVal), maxVal)`

### 分组 5：纹理环绕模式模拟（4 个函数）

```cangjie
public func clamp<T>(Texcoord: T): T where T <: FloatingPoint<T> & Comparable<T>
public func repeat<T>(Texcoord: T): T where T <: FloatingPoint<T>
public func mirrorClamp<T>(Texcoord: T): T where T <: FloatingPoint<T> & Comparable<T>
public func mirrorRepeat<T>(Texcoord: T): T where T <: FloatingPoint<T> & Comparable<T>
```

**约束说明**：
- `clamp(Texcoord)` → 内部调用 `glm.detail.clamp(Texcoord, 0, 1)` 需要 `Comparable<T>`
- `repeat` → 仅 `fract(Texcoord)`，仅需 `FloatingPoint<T>`
- `mirrorClamp` → `fract(abs(Texcoord))`，`abs` 需要 `Comparable<T>`
- `mirrorRepeat` → 公式包含 `abs`, `>=` 比较和 `mix(Rest, ..., Mirror >= T(1))`，需要 `Comparable<T>`

**实现路径**：
- `clamp`：`glm.detail.clamp(Texcoord, T(Float64(0)), T(Float64(1)))`
- `repeat`：`glm.detail.fract(Texcoord)`
- `mirrorClamp`：`glm.detail.fract(glm.detail.abs(Texcoord))`
- `mirrorRepeat`：
  ```
  Abs = glm.detail.abs(Texcoord)
  Floor = glm.detail.floor(Abs)
  Clamp = Floor - T(Float64(2)) * glm.detail.floor(Floor / T(Float64(2)))  // mod(Floor, 2) 内联
  Rest = Abs - Floor
  Mirror = Clamp + Rest
  glm.detail.mix(Rest, T(Float64(1)) - Rest, Mirror >= T(Float64(1)))
  ```
  **注意**：`mod(Floor, T(2))` 需要内联，因为 `glm.detail.mod` 泛型版本约束为 `Integer<T>`，具体浮点重载不可用于泛型 `T`。

### 分组 6：浮点→整数舍入（2 个函数）

```cangjie
public func iround<T>(x: T): Int64 where T <: FloatingPoint<T>
public func uround<T>(x: T): UInt64 where T <: FloatingPoint<T>
```

**实现路径**：
- `iround`：`let xF64 = (x as Float64).getOrThrow(); let r = math.round(xF64); (r as Int64).getOrThrow()`
- `uround`：`let xF64 = (x as Float64).getOrThrow(); let r = math.round(xF64); (r as UInt64).getOrThrow()`

**不委托 `stdmath_shim.roundT` 的原因**：`stdmath_shim.cj` 中 `roundT` 为 package-private（默认可见性），`glm.ext` 无法导入。采用内联 `std.math.round` + 类型转换模式替代，与 `stdmath_shim.cj` 内部实现路径一致。

**uround 负数输入行为**：当 `x < 0` 时，`(r as UInt64).getOrThrow()` 抛出 `ArithmeticException`（仓颉 `@OverflowThrowing` 默认溢出策略），与 GLM 1.0.3 的模运算回绕不同。接受此差异。

## 导入声明

```cangjie
package glm.ext

import std.math.{ FloatingPoint, Number, Comparable }
import std.math as math
import glm.detail.{ min, max, abs, clamp, floor, fract, isnan, mix }
// 注意：stdmath_shim.roundT 为 package-private，不可从 glm.ext 导入
```

## 错误处理

| 场景 | 策略 |
|------|------|
| fmin/fmax NaN 输入 | 返回非 NaN 输入；若两输入均为 NaN，返回 NaN（自然传播） |
| fclamp NaN 输入 | 经 fmin/fmax 链自然传播 NaN |
| 纹理环绕函数 NaN/Inf 输入 | 经内部浮点运算自然传播（IEEE 754） |
| iround/uround 浮点溢出（值超出整数范围） | `getOrThrow()` 抛出 `ArithmeticException` |
| uround 负数输入 | 抛出 `ArithmeticException`（仓颉默认溢出策略） |

## 行为契约

- 所有函数为纯函数（无副作用、不修改输入参数）
- 3/4 输入 `min`/`max`：当多个输入值相等时，返回第一个最小/最大值（与委托 `min`/`max` 的行为一致）
- `fmin`/`fmax`：NaN 安全——只要有一个非 NaN 输入，则返回非 NaN 值
- 纹理环绕函数：遵循 GLM 1.0.3 的语义，不做输入有效验证
- `iround`/`uround`：使用 `round` 而非 `trunc`（与 GLM 的 `int(round(x))` 一致），正负零边界均正确

## 依赖关系

| 被依赖项 | 来源包 | 具体函数 | 用途 |
|---------|--------|---------|------|
| `min` | `glm.detail` | `min<T>(a,b)` | 3/4 输入 min、fmin 委托 |
| `max` | `glm.detail` | `max<T>(a,b)` | 3/4 输入 max、fmax 委托 |
| `clamp` | `glm.detail` | `clamp<T>(a,min,max)` | 纹理 clamp |
| `fract` | `glm.detail` | `fract<T>(a)` | repeat、mirrorClamp |
| `abs` | `glm.detail` | `abs<T>(a)` | mirrorClamp、mirrorRepeat |
| `floor` | `glm.detail` | `floor<T>(a)` | mirrorRepeat |
| `mix` | `glm.detail` | `mix<T>(x,y,a)` | mirrorRepeat 的 Bool 选择版 |
| `isnan` | `glm.detail` | `isnan<T>(x)` | fmin/fmax NaN 判断 |
| `math.round` | `std.math` | `round(Float64)` | iround/uround |

## 仓颉限制导致的偏差说明

1. **fmin/fmax/fclamp/纹理 clamp/mirrorClamp/mirrorRepeat 需要 `Comparable<T>` 约束**：任务规格仅标注 `FloatingPoint<T>`，但实现（委托 `min`/`max`/`clamp`/`abs` 或使用 `<`/`>=` 比较）需要 `Comparable<T>`。`FloatingPoint<T>` 接口不包含比较运算符。本设计加入 `Comparable<T>` 约束。

2. **`mirrorRepeat` 的 `mod(Floor, T(2))` 需内联**：`glm.detail.mod` 泛型版本约束为 `Integer<T>`，具体浮点重载（`Float32`/`Float64`/`Float16`）不可用于泛型 `T <: FloatingPoint<T>`。需内联为 `Floor - T(Float64(2)) * floor(Floor / T(Float64(2)))`。

3. **`iround`/`uround` 不委托 `stdmath_shim.roundT`**：`stdmath_shim.cj` 中 `roundT` 为 package-private（无 `public` 修饰符），`glm.ext` 无法跨包访问。替代方案：内联 `(std.math.round((x as Float64).getOrThrow()) as TargetType).getOrThrow()` 模式。

4. **`uround` 负数输入抛异常**：仓颉默认 `@OverflowThrowing` 溢出策略，负数转 `UInt64` 抛出 `ArithmeticException`，与 GLM 1.0.3 的模运算回绕不同。接受此行为差异。
