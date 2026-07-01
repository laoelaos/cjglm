# 任务指令（v1）

## 动作
NEW

## 任务描述
在 `glm.detail` 包中新建私有工具模块 `stdmath_shim.cj`（路径：`src/detail/stdmath_shim.cj`），为 25 个 `std.math` 函数提供统一的泛型包装函数。该模块不是公共 API（不标记 ★），仅作为库内部通过 `import` 使用的底层工具。

包含的 25 个包装函数（均具有 `T <: FloatingPoint<T>` 泛型约束）：

### 指数/对数/幂
- `func sqrtT<T>(x: T): T` — 委托 `std.math.sqrt(Float64)`
- `func expT<T>(x: T): T` — 委托 `std.math.exp`
- `func logT<T>(x: T): T` — 委托 `std.math.log`
- `func exp2T<T>(x: T): T` — 委托 `std.math.exp2`
- `func log2T<T>(x: T): T` — 委托 `std.math.log2`
- `func powT<T>(base: T, exp: T): T` — 委托 `std.math.pow`

### 三角函数
- `func sinT<T>(x: T): T` — 委托 `std.math.sin`
- `func cosT<T>(x: T): T` — 委托 `std.math.cos`
- `func tanT<T>(x: T): T` — 委托 `std.math.tan`
- `func asinT<T>(x: T): T` — 委托 `std.math.asin`
- `func acosT<T>(x: T): T` — 委托 `std.math.acos`
- `func atanT<T>(x: T): T` — 委托 `std.math.atan`
- `func atan2T<T>(y: T, x: T): T` — 委托 `std.math.atan2`

### 双曲函数
- `func sinhT<T>(x: T): T` — 委托 `std.math.sinh`
- `func coshT<T>(x: T): T` — 委托 `std.math.cosh`
- `func tanhT<T>(x: T): T` — 委托 `std.math.tanh`
- `func asinhT<T>(x: T): T` — 委托 `std.math.asinh`
- `func acoshT<T>(x: T): T` — 委托 `std.math.acosh`
- `func atanhT<T>(x: T): T` — 委托 `std.math.atanh`

### 舍入/绝对值
- `func floorT<T>(x: T): T` — 委托 `std.math.floor`
- `func ceilT<T>(x: T): T` — 委托 `std.math.ceil`
- `func roundT<T>(x: T): T` — 委托 `std.math.round`
- `func truncT<T>(x: T): T` — 委托 `std.math.trunc`
- `func absT<T>(x: T): T` — 委托 `std.math.abs`
- `func fmodT<T>(x: T, y: T): T` — 委托 `std.math.fmod`

**注意**：`inversesqrtT` 不属于此模块——它使用 `T(1)/sqrtT(x)` 公式实现，属于 `exponential.cj` 内部。

## 选择理由
这是阶段四的基石任务。所有 core/ext 函数库（common.cj、exponential.cj、trigonometric.cj、geometric.cj 等）都通过此包装层间接调用 `std.math`，遵循"唯一直接依赖 std.math"的架构模式。没有 stdmath_shim.cj，后续的数学函数无法编译。此模块无任何 glm 内部依赖，可以独立编码和验证。

## 任务上下文
### 设计依据（摘自 OOD Phase4 文档）
- 全部 25 个包装函数清单见 §1.4（完整清单第 54~88 行）
- 统一模式：`(std.math.<func>(Float64(x)) as T).getOrThrow()`
- `std.math` 的数学函数（sqrt/exp/log/sin/cos/tan 等）仅提供 `(Float64): Float64` 签名，不支持 Float16/Float32 泛型参数。本包装层为此提供统一的泛型包装
- 此模式已在现有代码（`ext/quaternion_geometric.cj` 的 `sqrtT`、`ext/quaternion_trigonometric.cj` 的 `sqrtT`、`detail/type_quat_cast.cj` 的 `sqrtT`）中得到编译验证
- 注意：`(result as T).getOrThrow()` 在 `T = Float16` 且中间值超过 ±65504 时抛出 `ArithmeticException`（因 Float64→Float16 转型溢出），而 GLM 1.0.3 返回 ±Inf。此差异在 Float16 低精度图形场景中触发概率极低，本设计接受此差异

### 已有代码上下文
- 已有 `detail/` 包中存在 `scalar_constants.cj`、`setup.cj`、`qualifier.cj`、`vectorize.cj` 等私有模块
- 已有 `ext/quaternion_trigonometric.cj` 中包含 `sqrtT` 的类似实现可作为参考
- 文件路径：`src/detail/stdmath_shim.cj`
- 包声明：`package glm.detail`
- 模块可见性：所有函数为 `private` 或包级可见（无 `public` 修饰，因不属于公共 API）。根据设计文档 "stdmath_shim.cj — 新增私有工具模块（无 ★，非公共 API 文件）" 的要求，所有函数可省略 `public` 关键字（包级可见）

### 实现提示
1. import 需求：`import std.math.{FloatingPoint}` 和对应各 `std.math` 函数
2. 统一实现模板：
   ```cangjie
   func sqrtT<T>(x: T): T where T <: FloatingPoint<T> {
       (std.math.sqrt((x as Float64).getOrThrow()) as T).getOrThrow()
   }
   ```
3. `Float64(x)` 转型写法使用 `(x as Float64).getOrThrow()`，已在现有代码中得到编译验证
4. `(result as T).getOrThrow()` 是仓颉中泛型类型转换的标准模式
