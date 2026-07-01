# 任务指令（v6）

## 动作
NEW

## 任务描述
**ext/scalar_common.cj** — 新建 `src/ext/scalar_common.cj`，实现 17 个标量公共扩展函数。

对标 GLM 1.0.3 `ext/scalar_common.hpp`，按分组实现以下函数：

```
// 3/4 输入标量 min/max（4 个）
func min<T>(a: T, b: T, c: T): T where T <: Number<T> & Comparable<T>
func min<T>(a: T, b: T, c: T, d: T): T where T <: Number<T> & Comparable<T>
func max<T>(a: T, b: T, c: T): T where T <: Number<T> & Comparable<T>
func max<T>(a: T, b: T, c: T, d: T): T where T <: Number<T> & Comparable<T>

// NaN 安全 min 系列（3 个）
func fmin<T>(a: T, b: T): T where T <: FloatingPoint<T>
func fmin<T>(a: T, b: T, c: T): T where T <: FloatingPoint<T>
func fmin<T>(a: T, b: T, c: T, d: T): T where T <: FloatingPoint<T>

// NaN 安全 max 系列（3 个）
func fmax<T>(a: T, b: T): T where T <: FloatingPoint<T>
func fmax<T>(a: T, b: T, c: T): T where T <: FloatingPoint<T>
func fmax<T>(a: T, b: T, c: T, d: T): T where T <: FloatingPoint<T>

// NaN 安全 clamp（1 个）
func fclamp<T>(x: T, minVal: T, maxVal: T): T where T <: FloatingPoint<T>

// 纹理环绕模式模拟（4 个）
func clamp<T>(Texcoord: T): T where T <: FloatingPoint<T>       // clamp(Texcoord, 0, 1)
func repeat<T>(Texcoord: T): T where T <: FloatingPoint<T>      // fract(Texcoord)
func mirrorClamp<T>(Texcoord: T): T where T <: FloatingPoint<T> // fract(abs(Texcoord))
func mirrorRepeat<T>(Texcoord: T): T where T <: FloatingPoint<T> // 见设计公式

// 浮点→整数舍入（2 个）
func iround<T>(x: T): Int64 where T <: FloatingPoint<T>
func uround<T>(x: T): UInt64 where T <: FloatingPoint<T>
```

同时新建测试文件 `tests/glm/ext/scalar_common_test.cj`，每个函数至少 1~2 个测试用例；fmin/fmax 需包含 NaN 输入验证；iround/uround 含正/负/零边界。

## 选择理由
Task 4 是路线表中第一个未完成的任务，且无内部依赖——core common.cj 和 stdmath_shim.cj 均已就绪（已完成 Task 1~3），ext/scalar_common.cj 的所有实现路径依赖这些已完成的底层函数。

## 任务上下文

### 设计规格（来自 docs/06_ood_phase4.md §3.2 ext/scalar_common.cj）

- 实现路径：
  - 3/4 输入 min/max：委托 core common.cj 的 2 输入 `min`/`max` 层叠调用
  - fmin 系列：`if isnan(a) return b` 后委托 `min`
  - fmax 系列：`if isnan(a) return b` 后委托 `max`
  - fclamp：实现为 `fmin(fmax(x, minVal), maxVal)`
  - 纹理环绕函数：直接使用 core common.cj 的 `clamp`/`fract`/`abs`/`mod`/`floor`/`mix`
  - iround/uround：`Int64(stdmath_shim.roundT(x))` / `UInt64(stdmath_shim.roundT(x))`
- mirrorRepeat 实现公式：`Abs = abs(Texcoord) → Floor = floor(Abs) → Clamp = mod(Floor, T(2)) → Rest = Abs - Floor → Mirror = Clamp + Rest → mix(Rest, T(1) - Rest, Mirror >= T(1))`（GLM 1.0.3 ext/scalar_common.inl:78~86）
- uround 负数输入：仓颉默认 `@OverflowThrowing` 行为（抛出 `ArithmeticException`），与 GLM 模运算回绕不同，接受此差异

### 已有代码上下文

- `src/detail/common.cj`（package glm.detail）提供：`min`/`max`/`clamp`/`abs`/`floor`/`fract`/`mod`/`mix`/`isnan` 等标量函数，以及 `Float64(n)` 构造 `T` 类型字面量的模式 `(Float64(n) as T).getOrThrow()`
- `src/detail/stdmath_shim.cj`（package glm.detail）提供：`roundT`/`floorT`/`ceilT`/`absT`/`fmodT` 等 `FloatingPoint<T>` 包装函数，均使用 `import std.math as math` + `math.xxx()` 全限定调用
- `src/ext/scalar_constants.cj`（package glm.ext）提供 `epsilon`/`pi`/`cos_one_over_two` 常量
- 文件路径约定：`src/ext/scalar_common.cj` 使用 `package glm.ext`，依赖 `import glm.detail.{min, max, ...}` 和 `import glm.detail.stdmath_shim.{roundT, ...}`

### 新增文件
- `src/ext/scalar_common.cj` — 17 个标量函数完整实现
- `tests/glm/ext/scalar_common_test.cj` — 测试文件
