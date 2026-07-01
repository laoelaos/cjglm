# 详细设计（v2）

## 概述

实现 `glm.detail` 包中两个核心函数库的完整实现：
- **common.cj**：对标 GLSL 8.3 节通用数学函数，替换现有 12 个标量 stub、新增 13 个标量函数，并为全部 25 个函数补充 Vec1~Vec4 重载
- **exponential.cj**：对标 GLSL 8.2 节指数函数，新建文件包含 7 个函数 × 标量+Vec1~Vec4 重载

两者均通过 `stdmath_shim.cj` 的包装函数间接调用 `std.math`，遵循"唯一直接依赖 std.math"的架构模式。两个文件之间无交叉依赖。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| src/detail/common.cj | 修改 | 25 个通用数学函数（标量 + Vec1~Vec4 重载）+ 3 个浮点 mod 具体类型重载 + Bool 选择器 mix 重载 |
| src/detail/exponential.cj | 新建 | 7 个指数函数（标量 + Vec1~Vec4 重载） |

## 全局类型/导入约定

**字面量构造模式**：所有泛型上下文中的数字字面量使用 `(Float64(n) as T).getOrThrow()` 替代 `T(n)`。文档中简写为 `T(n)`，编码时替换为完整模式。

**Vec 重载模式**：每个标量函数的 Vec1~Vec4 重载遵循以下统一签名模式（以 `min` 为例）：

```cangjie
public func min<T>(a: T, b: T): T where T <: Number<T> & Comparable<T>
public func min<T, Q>(a: Vec1<T, Q>, b: Vec1<T, Q>): Vec1<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier
public func min<T, Q>(a: Vec2<T, Q>, b: Vec2<T, Q>): Vec2<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier
public func min<T, Q>(a: Vec3<T, Q>, b: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier
public func min<T, Q>(a: Vec4<T, Q>, b: Vec4<T, Q>): Vec4<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier
```

Vec 重载的实现均为逐分量应用对应标量函数。下文对 Vec 重载只列出函数名和约束，不再重复展开 4 个重载签名，编码时按此模式展开。

## 文件 1：common.cj

### 导入

```cangjie
package glm.detail
import std.math.{ Number, Integer, FloatingPoint, Comparable }
```

`stdmath_shim.cj` 的 `floorT`/`ceilT`/`roundT`/`truncT`/`absT`/`fmodT`/`log2T`/`powT` 等函数为同包包级函数，直接可见，无需导入。

### 函数组 A：`Number<T> & Comparable<T>` 约束（7 个标量 + Vec1~Vec4）

| 函数 | 标量签名 | 实现 |
|------|---------|------|
| `abs` | `public func abs<T>(a: T): T where T <: Number<T> & Comparable<T>` | `if (a < T(0)) -a else a` |
| `sign` | `public func sign<T>(a: T): T where T <: Number<T> & Comparable<T>` | `if (a > T(0)) T(1) else if (a < T(0)) -T(1) else T(0)` |
| `min` | `public func min<T>(a: T, b: T): T where T <: Number<T> & Comparable<T>` | `if (a < b) a else b` |
| `max` | `public func max<T>(a: T, b: T): T where T <: Number<T> & Comparable<T>` | `if (a > b) a else b` |
| `clamp` | `public func clamp<T>(a: T, minVal: T, maxVal: T): T where T <: Number<T> & Comparable<T>` | `min(max(a, minVal), maxVal)` |
| `step` | `public func step<T>(edge: T, x: T): T where T <: Number<T> & Comparable<T>` | `if (x < edge) T(0) else T(1)` |
| `smoothstep` | `public func smoothstep<T>(edge0: T, edge1: T, x: T): T where T <: Number<T> & Comparable<T>` | `let t = clamp((x - edge0) / (edge1 - edge0), T(0), T(1)); t * t * (T(3) - T(2) * t)` |

**Vec 重载**：每组 4 个（Vec1~Vec4），约束 `T <: Number<T> & Comparable<T>, Q <: Qualifier`。逐分量应用标量逻辑。

### 函数组 B：`FloatingPoint<T>` 约束（11 个标量 + Vec1~Vec4）

| 函数 | 标量签名 | 实现 |
|------|---------|------|
| `floor` | `public func floor<T>(a: T): T where T <: FloatingPoint<T>` | `floorT(a)`（委托 stdmath_shim，原 `Number<T>` 约束收紧为 `FloatingPoint<T>`） |
| `ceil` | `public func ceil<T>(a: T): T where T <: FloatingPoint<T>` | `ceilT(a)`（原 `Number<T>` 约束收紧为 `FloatingPoint<T>`） |
| `fract` | `public func fract<T>(a: T): T where T <: FloatingPoint<T>` | `a - floorT(a)`（原 `Number<T>` 约束收紧为 `FloatingPoint<T>`） |
| `trunc` | `public func trunc<T>(a: T): T where T <: FloatingPoint<T>` | `truncT(a)` |
| `round` | `public func round<T>(a: T): T where T <: FloatingPoint<T>` | `roundT(a)` |
| `roundEven` | `public func roundEven<T>(a: T): T where T <: FloatingPoint<T>` | `let r = roundT(a); let diff = absT(r - a); if (diff == T(0.5) && (Int64(round(a)) % 2 == 0)) r - T(1) else r` |
| `fma` | `public func fma<T>(a: T, b: T, c: T): T where T <: FloatingPoint<T>` | `a * b + c` |
| `frexp` | `public func frexp<T>(x: T): (T, Int64) where T <: FloatingPoint<T>` | 边缘场景：`x.isNaN()` → `(T.getNaN(), 0)`；`x.isInf()` → `(x, 0)`；`x == T(0)` → `(T(0), 0)`；合法值：`exp = Int64(floorT(log2T(absT(x)))) + 1`，`mant = x / powT(T(2), T(exp))` |
| `ldexp` | `public func ldexp<T>(x: T, exp: Int64): T where T <: FloatingPoint<T>` | `x * powT(T(2), T(exp))`（exp 为 Int64） |
| `modf` | `public func modf<T>(x: T): (T, T) where T <: FloatingPoint<T>` | `let i = truncT(x); (x - i, i)` |
| `isnan` | `public func isnan<T>(x: T): Bool where T <: FloatingPoint<T>` | `x.isNaN()` |
| `isinf` | `public func isinf<T>(x: T): Bool where T <: FloatingPoint<T>` | `x.isInf()` |

**Vec 重载**：每组 4 个（Vec1~Vec4），约束 `T <: FloatingPoint<T>, Q <: Qualifier`。逐分量应用标量逻辑。

**frexp Vec 重载返回类型设计**：
```cangjie
public func frexp<T, Q>(x: Vec1<T, Q>): (Vec1<T, Q>, Vec1<Int64, Q>) where T <: FloatingPoint<T>, Q <: Qualifier
public func frexp<T, Q>(x: Vec2<T, Q>): (Vec2<T, Q>, Vec2<Int64, Q>) where T <: FloatingPoint<T>, Q <: Qualifier
public func frexp<T, Q>(x: Vec3<T, Q>): (Vec3<T, Q>, Vec3<Int64, Q>) where T <: FloatingPoint<T>, Q <: Qualifier
public func frexp<T, Q>(x: Vec4<T, Q>): (Vec4<T, Q>, Vec4<Int64, Q>) where T <: FloatingPoint<T>, Q <: Qualifier
```

### 函数组 C：`mix` 系列

#### 3 参数线性插值（`T <: Number<T>`）

```cangjie
public func mix<T>(a: T, b: T, t: T): T where T <: Number<T> { a * (T(1) - t) + b * t }
```

Vec1~Vec4：约束 `T <: Number<T>, Q <: Qualifier`，逐分量。

#### Bool 选择器版本

```cangjie
public func mix<T>(x: T, y: T, a: Bool): T { if (a) y else x }
public func mix<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, a: Bool): Vec1<T, Q> where Q <: Qualifier { if (a) y else x }
// Vec2, Vec3, Vec4 similarly
```

### 函数组 D：整数 `mod`（保持现有 `Integer<T>` 泛型）

```cangjie
public func mod<T>(a: T, b: T): T where T <: Integer<T> { a % b }
```

**Vec 重载**：约束 `T <: Integer<T>, Q <: Qualifier`，逐分量使用 `%`。

### 函数组 E：标量浮点 `mod` 具体类型重载（新增 3 个）

对标 GLM `mod(float, float)` 语义，使用 `x - y * floor(x / y)` 公式，通过 `floorT` 实现：

```cangjie
public func mod(x: Float32, y: Float32): Float32 { x - y * floorT(x / y) }
public func mod(x: Float64, y: Float64): Float64 { x - y * floorT(x / y) }
public func mod(x: Float16, y: Float16): Float16 { x - y * floorT(x / y) }
```

### 函数组 F：位转换函数（具体类型重载，仅 Float32/Int32/UInt32）

```cangjie
public func floatBitsToInt(x: Float32): Int32 { x.toBits().toInt32() }
public func floatBitsToUint(x: Float32): UInt32 { x.toBits() }
public func intBitsToFloat(bits: Int32): Float32 { Float32.fromBits(bits.toUInt32()) }
public func uintBitsToFloat(bits: UInt32): Float32 { Float32.fromBits(bits) }
```

**Vec 重载**（以 `floatBitsToInt` 为例，其余同理）：

```cangjie
public func floatBitsToInt<Q>(x: Vec1<Float32, Q>): Vec1<Int32, Q> where Q <: Qualifier
public func floatBitsToInt<Q>(x: Vec2<Float32, Q>): Vec2<Int32, Q> where Q <: Qualifier
public func floatBitsToInt<Q>(x: Vec3<Float32, Q>): Vec3<Int32, Q> where Q <: Qualifier
public func floatBitsToInt<Q>(x: Vec4<Float32, Q>): Vec4<Int32, Q> where Q <: Qualifier
```

`floatBitsToUint` 返回 `VecN<UInt32, Q>`、`intBitsToFloat` 接收 `VecN<Int32, Q>` 并返回 `VecN<Float32, Q>`、`uintBitsToFloat` 接收 `VecN<UInt32, Q>` 并返回 `VecN<Float32, Q>`。

### 函数总数汇总

| 组 | 标量 | Vec1~Vec4 | 总计 |
|---|------|-----------|------|
| A: Number+Comparable (abs/sign/min/max/clamp/step/smoothstep) | 7 | 7×4=28 | 35 |
| B: FloatingPoint (floor/ceil/fract/trunc/round/roundEven/fma/frexp/ldexp/modf/isnan/isinf) | 12 | 12×4=48 | 60 |
| C: mix (3-param+T<:Number + Bool selector) | 2 | 2×4=8 | 10 |
| D: mod (Integer<T> generic) | 1 | 1×4=4 | 5 |
| E: mod (Float32/Float64/Float16 scalar) | 3 | 0 | 3 |
| F: floatBits (4 concrete × 1 scalar + 4 concrete × 4 vec) | 4 | 4×4=16 | 20 |
| **总计** | **29** | **104** | **133** |

## 文件 2：exponential.cj

### 导入

```cangjie
package glm.detail
import std.math.FloatingPoint
```

### 函数签名（全部 `T <: FloatingPoint<T>`）

所有 7 个函数遵循相同的标量+Vec1~Vec4 重载模式：

| 函数 | 标量签名 | 实现 |
|------|---------|------|
| `pow` | `public func pow<T>(base: T, exp: T): T where T <: FloatingPoint<T>` | `powT(base, exp)` 委托 stdmath_shim |
| `exp` | `public func exp<T>(x: T): T where T <: FloatingPoint<T>` | `expT(x)` 委托 stdmath_shim |
| `log` | `public func log<T>(x: T): T where T <: FloatingPoint<T>` | `logT(x)` 委托 stdmath_shim |
| `exp2` | `public func exp2<T>(x: T): T where T <: FloatingPoint<T>` | `exp2T(x)` 委托 stdmath_shim |
| `log2` | `public func log2<T>(x: T): T where T <: FloatingPoint<T>` | `log2T(x)` 委托 stdmath_shim |
| `sqrt` | `public func sqrt<T>(x: T): T where T <: FloatingPoint<T>` | `sqrtT(x)` 委托 stdmath_shim |
| `inversesqrt` | `public func inversesqrt<T>(x: T): T where T <: FloatingPoint<T>` | `T(1) / sqrt(x)`（非委托，直接算术运算。零值时 `sqrt(0)=0` → `T(1)/0` → +Inf，IEEE 754 自然结果） |

**Vec 重载**：每组 4 个（Vec1~Vec4），约束 `T <: FloatingPoint<T>, Q <: Qualifier`。逐分量应用标量函数。

**Vec `pow` 签名示例**：
```cangjie
public func pow<T, Q>(base: Vec1<T, Q>, exp: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func pow<T, Q>(base: Vec2<T, Q>, exp: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func pow<T, Q>(base: Vec3<T, Q>, exp: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func pow<T, Q>(base: Vec4<T, Q>, exp: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
```

**Vec `inversesqrt` 签名示例**：
```cangjie
public func inversesqrt<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func inversesqrt<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func inversesqrt<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func inversesqrt<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
```

### 函数总数

| 函数 | 标量 | Vec1~Vec4 | 小计 |
|------|------|-----------|------|
| pow/exp/log/exp2/log2/sqrt/inversesqrt | 7 | 7×4=28 | 35 |

## 约束变更说明（common.cj）

现有 stub 的约束需要更新以匹配本设计：

| 函数 | 旧约束（stub） | 新约束 |
|------|---------------|--------|
| `floor` | `Number<T>` | `FloatingPoint<T>` |
| `ceil` | `Number<T>` | `FloatingPoint<T>` |
| `fract` | `Number<T>` | `FloatingPoint<T>` |
| `mix` | `Number<T> & Comparable<T>` | `Number<T>`（无需 Comparable） |

其余 stubs 约束不变。

## 错误处理

| 场景 | 策略 |
|------|------|
| `isnan`/`isinf` 输入 | 委托 `x.isNaN()`/`x.isInf()` 实例方法，由底层 IEEE 754 行为决定 |
| `frexp` NaN/Inf/零输入 | 前置检查返回特殊值（NaN→NaN, Inf→Inf, 零→零），不抛出异常 |
| `modf`/`fma` 特殊值 | 由 IEEE 754 浮点运算自然传播 |
| `inversesqrt` 零值输入 | 返回 +Inf（IEEE 754 标准行为，已验证） |
| `ldexp` 指数溢出 | 由 `powT`（经 stdmath_shim）的 Float64→T 转型行为自然决定；`T`=Float16 时若 `powT` 中间值超过 ±65504 抛出 `ArithmeticException`（已知偏差 DV-IMPL） |
| 位转换函数无效位模式 | 由仓颉原生 `toBits`/`fromBits` 实现，Float32 总是 32 位有效，不存在无效位模式 |

## 行为契约

1. 所有函数为纯函数（无副作用，不修改输入参数），天然线程安全
2. `common.cj` 各函数约束分组见上文；`exponential.cj` 全部使用 `FloatingPoint<T>`
3. Vec1~Vec4 重载均为逐分量应用对应标量函数
4. `mix(Bool)` 选择器版本不要求 `T` 约束
5. 字面量 `T(0)`/`T(1)`/`T(2)`/`T(3)`/`T(0.5)` 等在代码中全部替换为 `(Float64(n) as T).getOrThrow()` 模式
6. `frexp`/`ldexp`/`modf` 使用 Int64 作为指数/整数类型（非泛型 T），因指数语义为整数
7. `isnan`/`isinf` 返回 `Bool`，这是标量版本；Vec 版本返回 `VecN<Bool, Q>`（逐分量布尔结果）

## 依赖关系

| 依赖 | 方向 | 说明 |
|------|------|------|
| `std.math.{Number, Integer, FloatingPoint, Comparable}` | common.cj → std.math | 提供泛型约束 |
| `std.math.{FloatingPoint}` | exponential.cj → std.math | 提供泛型约束 |
| `stdmath_shim.cj`（floorT/ceilT/roundT/truncT/absT/fmodT/log2T/powT/sqrtT/expT/logT/exp2T） | common.cj/exponential.cj → stdmath_shim.cj | 同包包级函数，直接可见 |
| `Vec1~Vec4` 类型 | → detail/type_vecN.cj | 同包包级类型，直接可见 |
| `Qualifier` | → detail/qualifier.cj | 同包包级类型，直接可见 |

两个目标文件之间无交叉依赖。common.cj 的函数（如 `clamp`）被 trigonometric/geometric/ext 等后续阶段的文件依赖。exponential.cj 的函数主要被 gtc 层引用。
