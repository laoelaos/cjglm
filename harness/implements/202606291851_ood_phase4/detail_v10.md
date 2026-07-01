# 详细设计（v10 r1）

## 概述

实现 Batch B-2（阶段四最终批）：新建 `detail/vector_relational.cj`、`gtc/noise.cj`、`gtc/random.cj`、更新 `lib.cj`、新建对应测试、编译验证。这是阶段四最后一批。

## 偏差提示（传递自 deviations.md）

以下偏差对 Batch B-2 编码有直接影响，Coder 必须注意：

- **IMPL-01**: `stdmath_shim.cj` 与 `type_quat_cast.cj` 的 `sqrtT` 命名冲突已解决（移除 `type_quat_cast.cj` 的私有 `sqrtT`），`stdmath_shim.cj` 的包级 `sqrtT` 对所有 detail 包文件可见。
- **IMPL-02**: `Comparable` 是自动导入的顶层类型，无需从 `std.math` 导入。
- **IMPL-03**: `FloatingPoint<T>` 约束下 `==` 不可用，需转 `Float64` 后比较。
- **IMPL-04**: `Float32.toBits().toInt32()` 不存在，使用 `(val as TargetType).getOrThrow()`。
- **IMPL-05**: `Float64.toInt64()` 不存在，使用 `(xF64 as Int64).getOrThrow()`。
- **IMPL-06**: `std.math.sqrt(...)` 全限定名不可用，使用 `import std.math as math` + `math.sqrt(...)`。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `src/detail/vector_relational.cj` | **新建** | Vec1~Vec4 的分量比较函数：`lessThan`/`greaterThan`/`lessThanEqual`/`greaterThanEqual`，包名 `glm.detail` |
| `src/gtc/noise.cj` | 新建 | Perlin/Simplex 噪声函数（8 个公共泛型函数 + 5 个私有辅助函数），包名 `glm.gtc` |
| `src/gtc/random.cj` | 新建 | 随机数生成函数（linearRand/gaussRand 标量 + Vec1~Vec4 版本），包名 `glm.gtc`，使用 `ThreadLocal<Random>` |
| `src/lib.cj` | 修改 | ① 修改第 23 行：删除从 gtc 导入的 translate/rotate/scale/shear/lookAt/lookAtRH/lookAtLH，保留 identity/rotate_slow/scale_slow/shear_slow。② 文件末尾追加 Phase 4 全部 public import |
| `tests/glm/gtc/noise_test.cj` | 新建 | perlin/simplex 各维度输出范围检查 + 周期性噪声首尾连续验证 |
| `tests/glm/gtc/random_test.cj` | 新建 | linearRand 统计分布均匀性 + gaussRand 均值/标准差验证 |

## 类型定义

本批不新建类/接口/枚举类型。所有功能通过包级自由函数提供。

### 新增：detail/vector_relational.cj 函数签名

**包路径**: `glm.detail`

**原因**: Simplex 噪声算法需对 Vec4 类型做分量比较（`lessThan(vec4(pXYZ, pW), vec4(0.0))`），而 `lessThan` 族函数当前仅在 `glm.gtc.quaternion` 中为 `Quat` 类型实现。新增一套 Vec1~Vec4 的泛型分量比较函数，使用与 `detail/common.cj` 一致的 `Number<T> & Comparable<T>` 约束。

```cangjie
package glm.detail

public func lessThan<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>): Vec1<Bool, Q>
    where T <: Number<T> & Comparable<T>, Q <: Qualifier
public func lessThan<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>): Vec2<Bool, Q>
    where T <: Number<T> & Comparable<T>, Q <: Qualifier
public func lessThan<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>): Vec3<Bool, Q>
    where T <: Number<T> & Comparable<T>, Q <: Qualifier
public func lessThan<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>): Vec4<Bool, Q>
    where T <: Number<T> & Comparable<T>, Q <: Qualifier

public func greaterThan<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>): Vec1<Bool, Q>
    where T <: Number<T> & Comparable<T>, Q <: Qualifier
public func greaterThan<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>): Vec2<Bool, Q>
    where T <: Number<T> & Comparable<T>, Q <: Qualifier
public func greaterThan<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>): Vec3<Bool, Q>
    where T <: Number<T> & Comparable<T>, Q <: Qualifier
public func greaterThan<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>): Vec4<Bool, Q>
    where T <: Number<T> & Comparable<T>, Q <: Qualifier

public func lessThanEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>): Vec1<Bool, Q>
    where T <: Number<T> & Comparable<T>, Q <: Qualifier
public func lessThanEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>): Vec2<Bool, Q>
    where T <: Number<T> & Comparable<T>, Q <: Qualifier
public func lessThanEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>): Vec3<Bool, Q>
    where T <: Number<T> & Comparable<T>, Q <: Qualifier
public func lessThanEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>): Vec4<Bool, Q>
    where T <: Number<T> & Comparable<T>, Q <: Qualifier

public func greaterThanEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>): Vec1<Bool, Q>
    where T <: Number<T> & Comparable<T>, Q <: Qualifier
public func greaterThanEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>): Vec2<Bool, Q>
    where T <: Number<T> & Comparable<T>, Q <: Qualifier
public func greaterThanEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>): Vec3<Bool, Q>
    where T <: Number<T> & Comparable<T>, Q <: Qualifier
public func greaterThanEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>): Vec4<Bool, Q>
    where T <: Number<T> & Comparable<T>, Q <: Qualifier
```

实现方式：逐分量调用标量 `<`/`>`/`<=`/`>=` 构造 `VecN<Bool, Q>`，与 `detail/common.cj` 中 `min`/`max`/`step` 的 Vec 版本模式一致。

### gtc/noise.cj 函数签名

**包路径**: `glm.gtc`

**导入声明**：
```cangjie
package glm.gtc
import glm.detail.{Vec1, Vec2, Vec3, Vec4, Qualifier, floor, fract, abs, min, max, dot, mix, step, clamp, roundEven, mod, trunc, lessThan}
```

**私有辅助函数**（包级 private，非公共 API，纯算法）：

```cangjie
// 标量版（用于 simplex4D 中对单个 T 值调用）
private func mod289<T>(x: T): T where T <: FloatingPoint<T>
private func permute<T>(x: T): T where T <: FloatingPoint<T>
// Vec 版
private func mod289<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
private func mod289<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
private func mod289<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
private func permute<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
private func permute<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
private func permute<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
private func taylorInvSqrt<T, Q>(r: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
private func taylorInvSqrt<T, Q>(r: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
private func taylorInvSqrt<T, Q>(r: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
private func fade<T, Q>(t: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
private func fade<T, Q>(t: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
private func fade<T, Q>(t: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
private func grad4<T, Q>(j: T, ip: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
```

实现公式（与 GLM 1.0.3 `detail/_noise.hpp` 一致）：
- `mod289(x)` = `x - floor(x * (T(1) / T(289))) * T(289)`
- `permute(x)` = `mod289(((x * T(34) + T(1)) * x))`
- `taylorInvSqrt(r)` = `T(1.79284291400159) - T(0.85373472095314) * r`
- `fade(t)` = `t * t * t * (t * (t * T(6) - T(15)) + T(10))`
- `grad4(j, ip)` = 从 `_noise.hpp` 迁移的位操作选梯度方向

**公共 API：Perlin 噪声**（返回标量 T，噪声值范围约 [-1, 1]）：

```cangjie
// 标量 1D（无 Q 参数，与 gtc/round.cj 模式一致）
public func perlin1D<T>(x: T): T where T <: FloatingPoint<T>
// Vec 2/3/4D
public func perlin2D<T, Q>(v: Vec2<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier
public func perlin3D<T, Q>(v: Vec3<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier
public func perlin4D<T, Q>(v: Vec4<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier
```

实现参考 GLM 1.0.3 `gtc/noise.inl`。输入坐标 → 整数网格 + 小数偏移 → 辅助函数计算 → 差值混合。

**公共 API：Simplex 噪声**（返回标量 T，噪声值范围约 [-1, 1]）：

```cangjie
// 标量 1D（无 Q 参数）
public func simplex1D<T>(x: T): T where T <: FloatingPoint<T>
// Vec 2/3/4D
public func simplex2D<T, Q>(v: Vec2<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier
public func simplex3D<T, Q>(v: Vec3<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier
public func simplex4D<T, Q>(v: Vec4<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier
```

实现参考 GLM 1.0.3 `gtc/noise.inl`。Simplex 算法：坐标变换 → 单纯形分类 → 贡献求和。

**公共 API：Perlin 周期噪声**（附加 period 参数，噪声值在周期边界连续）：

```cangjie
// 标量 1D（无 Q 参数）
public func perlin1D<T>(x: T, period: T): T where T <: FloatingPoint<T>
// Vec 2/3/4D
public func perlin2D<T, Q>(v: Vec2<T, Q>, period: Vec2<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier
public func perlin3D<T, Q>(v: Vec3<T, Q>, period: Vec3<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier
public func perlin4D<T, Q>(v: Vec4<T, Q>, period: Vec4<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier
```

实现：在坐标进入 `mod289`/`permute` 前先对网格顶点坐标取模 `period`（`coord % period`），使噪声在周期边界自然衔接。

### gtc/random.cj 函数签名

**包路径**: `glm.gtc`

**导入**（所有 import 置于文件顶部，package 声明之后）：

```cangjie
package glm.gtc
import glm.detail.{ Vec1, Vec2, Vec3, Vec4, Qualifier }
import std.random.Random
import std.time.{DateTime}
import std.env
```

**随机数引擎管理**：包级 `ThreadLocal<Random>` 惰性初始化。

```cangjie
// 包级私有变量
let _randomEngine = ThreadLocal<Random>.new()

// 私有辅助函数：获取或初始化随机引擎
private func getEngine(): Random {
    match (_randomEngine.get()) {
        case Some(engine) => engine
        case None => {
            let seed = (DateTime.now().toUnixMillisecond() as UInt64).getOrThrow() ^ (env.getProcessId() as UInt64).getOrThrow()
            let engine = Random.new(seed)
            _randomEngine.set(Some(engine))
            engine
        }
    }
}
```

**公共 API**（标量版无 Q 参数，与 `gtc/round.cj` 模式一致）：

```cangjie
// 标量版（无 Q 参数）
public func linearRand<T>(min: T, max: T): T where T <: FloatingPoint<T>
// Vec 版
public func linearRand<T, Q>(min: Vec1<T, Q>, max: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func linearRand<T, Q>(min: Vec2<T, Q>, max: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func linearRand<T, Q>(min: Vec3<T, Q>, max: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func linearRand<T, Q>(min: Vec4<T, Q>, max: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier

// 标量版（无 Q 参数）
public func gaussRand<T>(mean: T, stddev: T): T where T <: FloatingPoint<T>
```

标量 `linearRand` 实现：`min + (max - min) * r.nextFloat64()`（其中 r 为 `getEngine()` 返回的 `Random` 实例）。向量版本逐分量调用标量 `linearRand`。

`gaussRand` 实现：`mean + stddev * r.nextGaussianFloat64()`。

### lib.cj 修改

**第 1 步 — 修改第 23 行**（以内容匹配而非行号为准）：

```
// 修改前：
public import glm.gtc.{identity, translate, rotate, rotate_slow, scale, scale_slow, shear, shear_slow, lookAt, lookAtRH, lookAtLH}
// 修改后：
public import glm.gtc.{identity, rotate_slow, scale_slow, shear_slow}
```

**第 2 步 — 在文件末尾追加**（增量追加至原 28 行之后）：

```cangjie
// Phase 4 — common.cj 函数族导出
public import glm.detail.{abs, sign, floor, ceil, trunc, round, roundEven, fract, mod, modf,
    min, max, clamp, mix, step, smoothstep, isnan, isinf,
    floatBitsToInt, floatBitsToUint, intBitsToFloat, uintBitsToFloat,
    fma, frexp, ldexp}
// Phase 4 — exponential.cj 导出
public import glm.detail.{pow, exp, log, exp2, log2, sqrt, inversesqrt}
// Phase 4 — geometric.cj 导出
public import glm.detail.{dot, cross, normalize, length, distance, reflect, refract, faceforward}
// Phase 4 — matrix.cj 导出
public import glm.detail.{determinant, inverse}
// Phase 4 — ext/scalar_common.cj 与 ext/vector_common.cj 导出
public import glm.ext.{min, max, fmin, fmax, fclamp, clamp, repeat, mirrorClamp, mirrorRepeat, iround, uround}
// Phase 4 — ext 扩展函数库（仅导入 gtc 未覆盖的符号，避免命名冲突）
public import glm.ext.{translate, rotate, scale, shear, lookAt, lookAtRH, lookAtLH}
// Phase 4 — detail/vector_relational.cj 导出（供 gtc noise 使用）
public import glm.detail.{lessThan, greaterThan, lessThanEqual, greaterThanEqual}
// Phase 4 — gtc 新模块
public import glm.gtc.{affineInverse, inverseTranspose}
public import glm.gtc.{row, column}
public import glm.gtc.{packUnorm1x8, packUnorm2x8, packUnorm4x8, packUnorm1x16, packUnorm2x16, packUnorm4x16,
    unpackUnorm1x8, unpackUnorm2x8, unpackUnorm4x8, unpackUnorm1x16, unpackUnorm2x16, unpackUnorm4x16,
    packSnorm1x8, packSnorm2x8, packSnorm4x8, packSnorm1x16, packSnorm2x16, packSnorm4x16,
    unpackSnorm1x8, unpackSnorm2x8, unpackSnorm4x8, unpackSnorm1x16, unpackSnorm2x16, unpackSnorm4x16,
    packHalf1x16, packHalf2x16, packHalf4x16,
    unpackHalf1x16, unpackHalf2x16, unpackHalf4x16,
    packDouble2x32, unpackDouble2x32}
public import glm.gtc.{perlin1D, perlin2D, perlin3D, perlin4D, simplex1D, simplex2D, simplex3D, simplex4D}
public import glm.gtc.{linearRand, gaussRand}
public import glm.gtc.{next_float, prev_float, float_distance, ulp}
public import glm.gtc.{roundPowerOfTwo, ceilPowerOfTwo, floorPowerOfTwo, roundMultiple, ceilMultiple, floorMultiple}
// Phase 4 — gtc/type_precision.cj 高精度类型别名导出
public import glm.gtc.{fvec1, fvec2, fvec3, fvec4, dvec1, dvec2, dvec3, dvec4,
    ivec2, ivec3, ivec4, uvec2, uvec3, uvec4,
    i8vec2, i8vec3, i8vec4, u8vec2, u8vec3, u8vec4,
    i16vec2, i16vec3, i16vec4, u16vec2, u16vec3, u16vec4,
    i32vec2, i32vec3, i32vec4, u32vec2, u32vec3, u32vec4,
    i64vec2, i64vec3, i64vec4, u64vec2, u64vec3, u64vec4,
    hvec1, hvec2, hvec3, hvec4,
    fmat2, fmat3, fmat4, fmat2x2, fmat2x3, fmat2x4, fmat3x2, fmat3x3, fmat3x4, fmat4x2, fmat4x3, fmat4x4,
    dmat2, dmat3, dmat4, dmat2x2, dmat2x3, dmat2x4, dmat3x2, dmat3x3, dmat3x4, dmat4x2, dmat4x3, dmat4x4,
    fquat, dquat, hquat}
```

## 错误处理

| 场景 | 策略 | 说明 |
|------|------|------|
| **vector_relational.cj** | 无异常抛出 | 纯分量比较，`<`/`>`/`<=`/`>=` 运算符在 `Comparable<T>` 约束下可用。NaN 比较返回 false（IEEE 754 语义） |
| **noise.cj 纯算法** | 无异常抛出 | 纯数学运算，NaN/Inf 经 IEEE 754 自然传播。无保护分支，与 GLM 1.0.3 一致 |
| **random.cj 引擎未初始化** | 惰性初始化 | `ThreadLocal<Random>` 首次 `get()` 返回 `None` 时创建新引擎。后续调用直接获取。不抛出异常 |
| **`(as T).getOrThrow()` 在 random.cj 中** | 不适用 | random.cj 不使用 `(as T).getOrThrow()` 转型模式（直接操作 T 类型值），无此异常风险 |
| **lib.cj 导入** | 编译时错误 | 导入符号不存在或重名冲突在 `cjpm build` 阶段即可发现，无需运行时错误处理 |

## 行为契约

### noise.cj

- **输入范围**：所有噪声函数接受任意浮点坐标值。超出典型范围（如极大坐标值）时浮点精度下降导致可见的格点量化伪影，这是 Perlin/Simplex 算法的固有特性。
- **输出范围**：Perlin 噪声约 [-1, 1]，Simplex 噪声约 [-1, 1]。理论精确边界在 Perlin 中为 `±√(3/4) ≈ ±0.866`，实际输出约 95% 在 `[-0.7, 0.7]` 内。编码阶段不必做输出 clamp。
- **周期性保证**：`perlinND(x, period)` 函数当 `x` 与 `x + period` 在整数网格对齐时输出完全一致，边界连续。
- **确定性**：纯函数，相同输入总是返回相同输出。random.cj 与 noise.cj 无关。
- **调用顺序**：无状态，任意顺序调用结果相同。

### random.cj

- **状态性**：`linearRand`/`gaussRand` 每次调用修改内部 `ThreadLocal<Random>` 引擎状态，非纯函数。
- **线程安全**：每个线程持有独立引擎实例，线程间无竞态。
- **分布性质**：`linearRand` 均匀分布在 [min, max] 区间。`gaussRand` 以 mean 为中心、stddev 为标准差的正态分布。
- **种子确定性**：不提供种子设置 API。种子为 `DateTime.now().toUnixMillisecond() ^ std.env.getProcessId()`。若需可重复序列，扩展为支持外部种子注入（当前阶段不纳入）。
- **异常传播**：无显式异常抛出。

### lib.cj 导入

- **第 23 行修改**：删除 `translate/rotate/scale/shear/lookAt/lookAtRH/lookAtLH` 从 gtc 导入，保留 `identity/rotate_slow/scale_slow/shear_slow`。被删除符号由 `public import glm.ext.{...}` 提供（gtc 通过转发至 ext 确保 `glm.gtc` 路径可访问）。
- **Phase 4 增量追加**：所有符号必须唯一，不得与已有 import 重复。同名跨包符号（如 `min`/`max`/`clamp`/`mix`）通过参数个数或参数类型隐式区分重载。新增 `detail/vector_relational.cj` 的 `lessThan`/`greaterThan`/`lessThanEqual`/`greaterThanEqual` 导出要注意与 `glm.gtc.quaternion` 中为 `Quat` 定义的同名函数通过参数类型区分，不会冲突。

## 依赖关系

### detail/vector_relational.cj 依赖

- `glm.detail.Vec1`/`Vec2`/`Vec3`/`Vec4`（向量类型）
- `glm.detail.Qualifier`（限定符类型）

### gtc/noise.cj 依赖

- `glm.detail.Vec1`/`Vec2`/`Vec3`/`Vec4`（向量类型）
- `glm.detail.Qualifier`（限定符类型）
- `glm.detail` 的 common 函数：`floor`、`fract`、`abs`、`min`、`max`、`dot`、`mix`、`step`、`clamp`、`roundEven`、`mod`、`trunc`
- `glm.detail` 的 vector_relational 函数：**`lessThan`**（新增依赖，用于 Simplex 算法中的分量比较）

### gtc/random.cj 依赖

- `glm.detail.Vec1`/`Vec2`/`Vec3`/`Vec4`（向量类型）
- `glm.detail.Qualifier`（限定符类型）
- `std.random.Random`（标准库随机数引擎）
- `std.time.DateTime`（种子生成用时间戳）
- `std.env.getProcessId()`（种子生成用进程 ID）
- `core.ThreadLocal`（自动导入的 ThreadLocal 类型）

### lib.cj 修改依赖

- 全部已有 import 保持不变
- 新增 Phase 4 公共导入，依赖 `glm.detail`（common/exponential/geometric/matrix/vector_relational）、`glm.ext`（scalar/vector_common + ext 功能函数）、`glm.gtc`（gtc 模块全部新符号）

## 修订说明（v10 r1）

| 审查意见 | 修改措施 |
|---------|---------|
| **[严重] `lessThan` 不存在**：`lessThan` 函数在 `glm.detail` 中不存在，Simplex 噪声算法需使用 `lessThan` 对 Vec 类型做分量比较 | **新增 `detail/vector_relational.cj`**：在 `glm.detail` 包中新增 Vec1~Vec4 的 `lessThan`/`greaterThan`/`lessThanEqual`/`greaterThanEqual` 函数族，返回 `VecN<Bool, Q>`。使用 `Number<T> & Comparable<T>` 约束，与 `detail/common.cj` 中 `min`/`max`/`step` 的 Vec 版本模式一致。在 lib.cj 的 Phase 4 追加导入中新增 `glm.detail.{lessThan, greaterThan, lessThanEqual, greaterThanEqual}` 导出。 |
| **[严重] 函数体内 `import`**：`getEngine()` 函数体内出现 `import std.time.{DateTime}` 和 `import std.env`，违反仓颉规范 | 将 `import std.time.{DateTime}` 和 `import std.env` 移至 `random.cj` 文件顶部，放在 `package glm.gtc` 之后、其他声明之前。 |
| **[一般] 标量函数多余 `Q`**：`perlin1D`、`simplex1D`、`linearRand` 标量重载、`gaussRand` 声明了无法推导的 `Q <: Qualifier` 参数 | 对标量输入函数移除 `Q` 类型参数：`perlin1D<T>`（含 period 重载）、`simplex1D<T>`、`linearRand<T>` 标量重载、`gaussRand<T>`。移除后签名与 `gtc/round.cj` 中标量函数模式一致（只有 `T <: FloatingPoint<T>` 约束）。 |
| **[轻微] lib.cj 修改依赖行号引用**：若前面批次修改过文件则行号可能失效 | 已接受此意见。设计中以内容化的 before/after 为主，行号仅作参考。 |

## 修订说明（v10 r2）
| 审查意见 | 修改措施 |
|---------|---------|
| **[严重] `detail/vector_relational.cj` 导入当前包**：`import glm.detail.{Vec1, Vec2, Vec3, Vec4, Qualifier}` 违反"不能导入当前包"规则 | **删除该 import 语句**。同包类型自动可见，无需导入。与 `common.cj`/`geometric.cj` 等同包文件模式一致。 |
| **[一般] `gtc/noise.cj` 缺少 import 声明**：未明确列出从 `glm.detail` 导入的类型和函数符号 | **补充完整 import 声明段**：在 `包路径` 之后、函数签名之前新增 `import glm.detail.{Vec1, Vec2, Vec3, Vec4, Qualifier, floor, fract, abs, min, max, dot, mix, step, clamp, roundEven, mod, trunc, lessThan}`。 |
| **[轻微] `random.cj` 种子表达式类型转换**：`Int64` XOR 结果与 `Random(seed: UInt64)` 参数类型不匹配 | **补充类型转换**：将两个操作数分别 `as UInt64` 后再 XOR，使用 `(expr as UInt64).getOrThrow()` 模式。修改为 `let seed = (DateTime.now().toUnixMillisecond() as UInt64).getOrThrow() ^ (env.getProcessId() as UInt64).getOrThrow()`。 |
