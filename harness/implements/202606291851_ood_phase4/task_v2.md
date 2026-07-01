# 任务指令（v2）

## 动作
NEW

## 任务描述
实现两个 `glm.detail` 包的核心函数库文件，它们共同依赖于已完成的 `stdmath_shim.cj`：

### 文件 1: `src/detail/common.cj` — 替换 stub 为完整实现
对标 GLSL 8.3 节通用数学函数，替换现有 12 个标量 stub，新增 13 个标量函数，并为全部 25 个函数补充 Vec1~Vec4 重载。

**现有 stub（12 个标量，需完成实现 + 补齐 Vec1~Vec4）**：
`abs`, `sign`, `floor`, `ceil`, `fract`, `mod`, `min`, `max`, `clamp`, `mix`, `step`, `smoothstep`

**新增标量函数 + Vec1~Vec4（13 个）**：
`trunc`, `round`, `roundEven`, `isnan`, `isinf`, `floatBitsToInt`, `floatBitsToUint`, `intBitsToFloat`, `uintBitsToFloat`, `fma`, `frexp`, `ldexp`, `modf`

**约束策略**：
- `abs/sign/min/max/clamp/step/smoothstep`：`T <: Number<T> & Comparable<T>`
- `floor/ceil/trunc/round/roundEven/fract/modf/fma/frexp/ldexp`：`T <: FloatingPoint<T>`
- `mix`（3 参数）：`T <: Number<T>`；Bool 选择器版本独立重载
- `isnan/isinf`：`T <: FloatingPoint<T>`
- `mod`：保持 `T <: Integer<T>`（浮点 `mod` 以具体类型重载补充：`func mod(x: Float32, y: Float32): Float32` 等 3 个）
- `floatBitsToInt/floatBitsToUint/intBitsToFloat/uintBitsToFloat`：具体类型重载（仅 Float32/Int32/UInt32）
- `frexp`：返回 `(T, Int64)` 元组
- `ldexp`：接受 `Int64` 指数参数

**关键实现细节**：
- 使用 `stdmath_shim.cj` 的 `floorT/ceilT/roundT/truncT/absT/fmodT` 包装函数（`import` 后直接使用包级函数名）
- `roundEven`：使用 `x + 0.5` floor 判断奇偶的舍入策略
- `mix`（Bool 选择器）：`func mix<T>(x: T, y: T, a: Bool): T`，当 a 为 true 时返回 y，否则返回 x
- Vec1~Vec4 重载：逐分量应用对应标量函数

### 文件 2: `src/detail/exponential.cj` — 新建完整实现
对标 GLSL 8.2 节指数函数，新建文件包含 7 个函数 × 标量+Vec1~Vec4 重载。

**函数清单**：`pow`, `exp`, `log`, `exp2`, `log2`, `sqrt`, `inversesqrt`

**约束策略**：全部使用 `T <: FloatingPoint<T>`

**关键实现细节**：
- 通过 `stdmath_shim.cj` 的 `powT/expT/logT/exp2T/log2T/sqrtT` 包装函数委托 `std.math`
- `inversesqrt` 实现为 `T(1) / sqrt(x)`，非直接委托。零值时 `T(1)/T(0)` → +Inf（IEEE 754，与 GLM 一致）
- Vec1~Vec4 重载：逐分量应用对应标量函数

### 共同注意事项
- 所有函数使用 `(Float64(n) as T).getOrThrow()` 模式构造字面量（`T(1)` → `(Float64(1) as T).getOrThrow()`）
- 整数 `mod`（`Integer<T>` 约束）保持现有泛型版本不变，浮点 `mod` 以具体类型重载添加
- 不修改 `src/detail/scalar_vec_ops.cj` 中已有的 12 个具体浮点类型向量 mod 重载

## 选择理由
Task 1（stdmath_shim.cj）已完成，common.cj 和 exponential.cj 是下一个依赖层——两者均直接使用 stdmath_shim 的包装函数，彼此独立无交叉依赖。将它们合并到同一轮实现可大幅减少轮次数：两个文件的实现模式高度相似（标量+Vec1~Vec4 重载 × 调用 shim 包装函数），编码节奏一致。完成此轮后，后续的 trigonometric/geometric/matrix 等 detail 文件（依赖 common 函数）即可解锁。

## 任务上下文
- 目标文件：`src/detail/common.cj`（修改现有文件）和 `src/detail/exponential.cj`（新建文件），均属于 `glm.detail` 包
- 已完成的 stdmath_shim.cj 提供 25 个包装函数（`sqrtT/expT/logT/exp2T/log2T/powT/sinT/cosT/tanT/asinT/acosT/atanT/atan2T/sinhT/coshT/tanhT/asinhT/acoshT/atanhT/floorT/ceilT/roundT/truncT/absT/fmodT`），可通过同包 `import` 直接使用
- Vec 类型定义：`src/detail/type_vec1.cj`~`type_vec4.cj`（已在阶段一~三完成）

## 已有代码上下文

### detail/common.cj（现有 stub）
```cangjie
package glm.detail
import std.math.{ Number, Integer }
// 12 个标量 stub：min, max, abs, sign, floor, ceil, fract, mod(Integer), clamp, mix, step, smoothstep
```

### Vec 类型示例（Vec2）
```cangjie
public struct Vec2<T, Q> where Q <: Qualifier {
    public var x: T; public var y: T
    // ... 运算符重载已在阶段一完整实现
}
```

### 使用模式示例（trigonometric.cj 的 stub 展示 Vec 重载模式）
```cangjie
public func sin<T>(x: T): T where T <: FloatingPoint<T> { ... }
public func sin<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { ... }
public func sin<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { ... }
// Vec3, Vec4 similarly
```

## 设计参考（docs/06_ood_phase4.md）

### common.cj 详细设计（§3.1）
- `abs` 标量：使用 `(std.math.abs((x as Float64).getOrThrow()) as T).getOrThrow()` 或 `(x < T(0)) ? -x : x`
- `sign`：`(x > T(0)) ? T(1) : ((x < T(0)) ? -T(1) : T(0))`
- `floor/ceil/trunc/round`：委托 `stdmath_shim.floorT/ceilT/truncT/roundT`
- `roundEven`：实现为 `round(x) - (abs(round(x) - x) == T(0.5) && (Int64(round(x)) % 2 == 0) ? T(1) : T(0))` 或相同语义
- `fract`：`x - floor(x)`
- `mod`（整数）：`a % b` 运算符
- `mod`（浮点标量具体重载）：`x - y * floor(x / y)`
- `min/max/clamp`：直接比较运算
- `mix`：`a * (T(1) - t) + b * t`
- `step`：`(x < edge) ? T(0) : T(1)`
- `smoothstep`：`t = clamp((x - edge0) / (edge1 - edge0), T(0), T(1)); return t * t * (T(3) - T(2) * t)`
- `isnan`：`x.isNaN()`
- `isinf`：`x.isInf()`
- `floatBitsToInt`：`Float32.toBits(x).toInt32()`（具体类型重载）
- `intBitsToFloat`：`Float32.fromBits(bits.toUInt32())`
- `fma(a,b,c)`：`a * b + c`
- `frexp(x)`：`(mantissa, exponent)` 元组；使用 `log2(abs(x))` 通过 stdmath_shim.log2T 计算指数
- `ldexp(x, exp)`：`x * powT(T(2), T(exp))` 通过 stdmath_shim.powT
- `modf(x)`：`(fractional, integer)` 元组；`integer = trunc(x)`, `fractional = x - integer`

### exponential.cj 详细设计（§3.1）
- `pow(base, exp)` → `stdmath_shim.powT(base, exp)`
- `exp(x)` → `stdmath_shim.expT(x)`
- `log(x)` → `stdmath_shim.logT(x)`
- `exp2(x)` → `stdmath_shim.exp2T(x)`
- `log2(x)` → `stdmath_shim.log2T(x)`
- `sqrt(x)` → `stdmath_shim.sqrtT(x)`
- `inversesqrt(x)` → `T(1) / sqrt(x)`

## 修订说明（v2 r1）
| 审查意见 | 修改措施 |
|---------|---------|
| plan.md R2 NEW 节描述内容仍是 R1 的 stdmath_shim.cj（复制粘贴遗漏），未反映实际 R2 任务 common.cj + exponential.cj | 重写 plan.md R2 NEW 节全部内容，替换为与 task_v2.md 一致的 common.cj + exponential.cj 正确描述（函数清单、约束策略、实现关键、选择理由、上下文） |
