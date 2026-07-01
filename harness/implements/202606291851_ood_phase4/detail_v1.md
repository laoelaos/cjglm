# 详细设计（v1）

## 概述

为 `glm.detail` 包新增私有工具模块 `stdmath_shim.cj`，为 25 个 `std.math` 函数提供统一的泛型包装函数。该模块不是公共 API，仅作为库内部通过 `import` 使用的底层工具。所有 core/ext 函数库通过此包装层间接调用 `std.math`，遵循"唯一直接依赖 std.math"的架构模式。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| src/detail/stdmath_shim.cj | 新建 | 为 25 个 std.math 函数提供 `T <: FloatingPoint<T>` 泛型包装，统一使用 `(std.math.<func>((x as Float64).getOrThrow()) as T).getOrThrow()` 模式 |

## 类型定义

本模块不定义新的类型。全部为包级泛型自由函数。

### 函数组 1：指数/对数/幂（6 个）

```cangjie
func sqrtT<T>(x: T): T where T <: FloatingPoint<T>
func expT<T>(x: T): T where T <: FloatingPoint<T>
func logT<T>(x: T): T where T <: FloatingPoint<T>
func exp2T<T>(x: T): T where T <: FloatingPoint<T>
func log2T<T>(x: T): T where T <: FloatingPoint<T>
func powT<T>(base: T, exp: T): T where T <: FloatingPoint<T>
```

### 函数组 2：三角函数（7 个）

```cangjie
func sinT<T>(x: T): T where T <: FloatingPoint<T>
func cosT<T>(x: T): T where T <: FloatingPoint<T>
func tanT<T>(x: T): T where T <: FloatingPoint<T>
func asinT<T>(x: T): T where T <: FloatingPoint<T>
func acosT<T>(x: T): T where T <: FloatingPoint<T>
func atanT<T>(x: T): T where T <: FloatingPoint<T>
func atan2T<T>(y: T, x: T): T where T <: FloatingPoint<T>
```

### 函数组 3：双曲函数（6 个）

```cangjie
func sinhT<T>(x: T): T where T <: FloatingPoint<T>
func coshT<T>(x: T): T where T <: FloatingPoint<T>
func tanhT<T>(x: T): T where T <: FloatingPoint<T>
func asinhT<T>(x: T): T where T <: FloatingPoint<T>
func acoshT<T>(x: T): T where T <: FloatingPoint<T>
func atanhT<T>(x: T): T where T <: FloatingPoint<T>
```

### 函数组 4：舍入/绝对值（6 个）

```cangjie
func floorT<T>(x: T): T where T <: FloatingPoint<T>
func ceilT<T>(x: T): T where T <: FloatingPoint<T>
func roundT<T>(x: T): T where T <: FloatingPoint<T>
func truncT<T>(x: T): T where T <: FloatingPoint<T>
func absT<T>(x: T): T where T <: FloatingPoint<T>
func fmodT<T>(x: T, y: T): T where T <: FloatingPoint<T>
```

## 实现模式

所有 25 个函数遵循统一的实现模式（以 `sqrtT` 为例）：

```cangjie
func sqrtT<T>(x: T): T where T <: FloatingPoint<T> {
    (std.math.sqrt((x as Float64).getOrThrow()) as T).getOrThrow()
}
```

**三步转换**：
1. `(x as Float64).getOrThrow()` — 将泛型浮点值 `T` 转型为 `Float64`
2. `std.math.<func>(float64Val)` — 调用 `std.math` 的对应函数（仅接受 `Float64`）
3. `(result as T).getOrThrow()` — 将 `Float64` 结果转回泛型类型 `T`

**双参数函数**（`powT`、`atan2T`、`fmodT`）模式：

```cangjie
func powT<T>(base: T, exp: T): T where T <: FloatingPoint<T> {
    (std.math.pow((base as Float64).getOrThrow(), (exp as Float64).getOrThrow()) as T).getOrThrow()
}
```

## 可见性

所有 25 个函数均省略 `public` 关键字，保持包级可见（package-private）。模块 `stdmath_shim.cj` 整体为非公共 API，仅供 `glm.detail` 内部使用。

## 错误处理

| 场景 | 行为 | 说明 |
|------|------|------|
| Float64→T 转型溢出（T=Float16） | `getOrThrow()` 抛出 `ArithmeticException` | 当中间值超过 ±65504 时触发。GLM 1.0.3 返回 ±Inf。此差异在 Float16 低精度图形场景中触发概率极低，本设计接受此差异 |
| 输入 NaN/Inf | 由 `std.math` 底层函数的 IEEE 754 行为自然传播 | `std.math.sqrt(-1)` → NaN，`std.math.log(0)` → -Inf 等，经 Float64 包覆层后转回 T 时正常传播 |
| `asinT`/`acosT` 越界输入 | 直接委托 `std.math.asin`/`std.math.acos`，仓颉版本在越界时抛出 `IllegalArgumentException` | 越界保护不在本 shim 层处理，由 `detail/trigonometric.cj` 的 `asin`/`acos` 包装函数在上层做前置检查 |

**注意**：本 shim 层不做输入有效性验证和特殊值保护。越界保护、NaN/Inf 前置处理等策略在调用方（`detail/trigonometric.cj`、`detail/common.cj` 等）中实现。

## 行为契约

1. 所有函数为纯函数（无副作用，不修改输入参数），天然线程安全
2. 每个函数接受 `Float16 | Float32 | Float64` 三种浮点类型中的任意一种作为 `T`
3. 返回类型始终与输入类型 `T` 一致
4. `absT` 的实现：`(std.math.abs((x as Float64).getOrThrow()) as T).getOrThrow()` — 与 GLM 1.0.3 行为一致（返回值的绝对值）
5. `fmodT` 的实现：委托 `std.math.fmod` — 遵循 IEEE 754 余数运算，结果符号与被除数一致

## 依赖关系

| 依赖 | 方向 | 说明 |
|------|------|------|
| `std.math.FloatingPoint` | 本模块 → std.math | 提供泛型约束 `T <: FloatingPoint<T>` |
| `std.math.*` 各函数（sqrt, exp, log 等） | 本模块 → std.math | 25 个 std.math 函数的直接委托调用 |
| 其他 `glm.detail` 模块（common.cj, exponential.cj, trigonometric.cj 等） | 其他模块 → 本模块 | 本模块无任何 glm 内部依赖，是独立的最底层模块。其他 core/ext 函数库通过此 shim 层间接调用 std.math |

## 已知偏差

本模块的实现引入以下已知偏差（需按 `docs/deviations.md` 记录规则记录）：

- **Float16 转型溢出**：`(result as T).getOrThrow()` 在 `T = Float16` 且中间值超过 ±65504 时抛出 `ArithmeticException`，而 GLM 1.0.3 返回 ±Inf。此偏差属于"二、接口/行为有偏差"类别（DV 编号），优先级低（Float16 低精度图形场景触发概率极低）。
