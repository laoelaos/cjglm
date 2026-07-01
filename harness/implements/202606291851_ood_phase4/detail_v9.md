# 详细设计（v9）

## 概述

实现 Batch B-1：新建 4 个 gtc 模块源文件（packing/ulp/round/type_precision）及 3 个对应测试文件。这些模块相互独立、简短直接，可并行编码。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `src/gtc/packing.cj` | 新建 | 浮点数据打包/解包函数，使用具体类型重载和位操作 |
| `src/gtc/ulp.cj` | 新建 | ULP 浮点比较函数，具体类型重载（Float32 + Float64） |
| `src/gtc/round.cj` | 新建 | 浮点数舍入函数（2 的幂相关），泛型 `T <: FloatingPoint<T>` |
| `src/gtc/type_precision.cj` | 新建 | 高精度类型别名定义（69 个 type 别名） |
| `tests/glm/gtc/packing_test.cj` | 新建 | pack→unpack 互逆验证 |
| `tests/glm/gtc/ulp_test.cj` | 新建 | next_float/float_distance/ulp 验证 |
| `tests/glm/gtc/round_test.cj` | 新建 | PowerOfTwo/Multiple 舍入验证 |

## 类型定义

### packing.cj

**包路径**：`glm.gtc`
**形态**：包级具体类型重载函数

函数清单（共 32 个）：

```
// packUnorm 系族
func packUnorm1x8(v: Float32): UInt8
func packUnorm2x8<Q>(v: Vec2<Float32, Q>): UInt16                     where Q <: Qualifier
func packUnorm4x8<Q>(v: Vec4<Float32, Q>): UInt32                     where Q <: Qualifier
func packUnorm1x16(v: Float32): UInt16
func packUnorm2x16<Q>(v: Vec2<Float32, Q>): UInt32                    where Q <: Qualifier
func packUnorm4x16<Q>(v: Vec4<Float32, Q>): UInt64                    where Q <: Qualifier

// unpackUnorm 系族
func unpackUnorm1x8(p: UInt8): Float32
func unpackUnorm2x8<Q>(p: UInt16): Vec2<Float32, Q>                   where Q <: Qualifier
func unpackUnorm4x8<Q>(p: UInt32): Vec4<Float32, Q>                   where Q <: Qualifier
func unpackUnorm1x16(p: UInt16): Float32
func unpackUnorm2x16<Q>(p: UInt32): Vec2<Float32, Q>                  where Q <: Qualifier
func unpackUnorm4x16<Q>(p: UInt64): Vec4<Float32, Q>                  where Q <: Qualifier

// packSnorm 系族
func packSnorm1x8(v: Float32): UInt8
func packSnorm2x8<Q>(v: Vec2<Float32, Q>): UInt16                     where Q <: Qualifier
func packSnorm4x8<Q>(v: Vec4<Float32, Q>): UInt32                     where Q <: Qualifier
func packSnorm1x16(v: Float32): UInt16
func packSnorm2x16<Q>(v: Vec2<Float32, Q>): UInt32                    where Q <: Qualifier
func packSnorm4x16<Q>(v: Vec4<Float32, Q>): UInt64                    where Q <: Qualifier

// unpackSnorm 系族
func unpackSnorm1x8(p: UInt8): Float32
func unpackSnorm2x8<Q>(p: UInt16): Vec2<Float32, Q>                   where Q <: Qualifier
func unpackSnorm4x8<Q>(p: UInt32): Vec4<Float32, Q>                   where Q <: Qualifier
func unpackSnorm1x16(p: UInt16): Float32
func unpackSnorm2x16<Q>(p: UInt32): Vec2<Float32, Q>                  where Q <: Qualifier
func unpackSnorm4x16<Q>(p: UInt64): Vec4<Float32, Q>                  where Q <: Qualifier

// packHalf 系族
func packHalf1x16(v: Float32): UInt16
func packHalf2x16<Q>(v: Vec2<Float32, Q>): UInt32                     where Q <: Qualifier
func packHalf4x16<Q>(v: Vec4<Float32, Q>): UInt64                     where Q <: Qualifier

// unpackHalf 系族
func unpackHalf1x16(p: UInt16): Float32
func unpackHalf2x16<Q>(p: UInt32): Vec2<Float32, Q>                   where Q <: Qualifier
func unpackHalf4x16<Q>(p: UInt64): Vec4<Float32, Q>                   where Q <: Qualifier

// packDouble2x32 系族
func packDouble2x32<Q>(v: Vec2<UInt32, Q>): Float64                  where Q <: Qualifier
func unpackDouble2x32<Q>(p: Float64): Vec2<UInt32, Q>                 where Q <: Qualifier
```

**实现公式**：
- `packUnorm1x8(v)`: `round(clamp(v, Float32(0.0), Float32(1.0)) * Float32(255.0)) as UInt8`
- `packUnorm1x16(v)`: `round(clamp(v, Float32(0.0), Float32(1.0)) * Float32(65535.0)) as UInt16`
- `packSnorm1x8(v)`: `(Int8(round(clamp(v, Float32(-1.0), Float32(1.0)) * Float32(127.0))) as UInt8).getOrThrow()`（先转 Int8 再位重解释为 UInt8）
- `packSnorm1x16(v)`: `(Int16(round(clamp(v, Float32(-1.0), Float32(1.0)) * Float32(32767.0))) as UInt16).getOrThrow()`
- `unpackUnorm1x8(p)`: `Float32(p) / Float32(255.0)`
- `unpackSnorm1x8(p)`: `clamp(Float32((p as Int8).getOrThrow()) / Float32(127.0), Float32(-1.0), Float32(1.0))`（先 UInt8→Int8 位重解释再转 Float32）
- `packHalf1x16(v)`: 使用 `Float32.toBits(): UInt32` 提取位模式，做 Float32↔Float16 位转换
- `packDouble2x32(v)`: `Float64.fromBits(UInt64(v.x) | (UInt64(v.y) << 32))`
- `unpackDouble2x32(p)`: `Vec2(UInt32(p.toBits()), UInt32(p.toBits() >> 32))`

**标量类型转换**：使用 `(value as TargetType).getOrThrow()` 模式（如 `(round(...) as UInt8).getOrThrow()`），见偏差 IMPL-04。

**packHalf 位转换**（IEEE 754 Float32↔Float16 半精度转换）：
- Float32 位布局：1-bit sign (bit31), 8-bit exponent (bits30-23, bias 127), 23-bit mantissa (bits22-0)
- Float16 位布局：1-bit sign (bit15), 5-bit exponent (bits14-10, bias 15), 10-bit mantissa (bits9-0)
- **Float32→Float16**（含向最近偶数舍入）：
  ```
  sign = (bits32 >> 16) & 0x8000
  exp32 = (bits32 >> 23) & 0xFF
  mant32 = bits32 & 0x7FFFFF

  if exp32 == 255:                    // Inf/NaN
      result = sign | 0x7C00 | (mant32 >> 13)
  else if exp32 <= 112:               // 零或下溢（含舍入）
      mant32 = mant32 | 0x800000      // 恢复隐藏位
      shift = 113 - exp32
      mant32 = mant32 + (1 << (shift - 1))  // 舍入
      if (mant32 & (1 << (13 + shift))) != 0: mant32 = 0  // 进位溢出
      result = sign | (mant32 >> shift)
  else:                               // 规格化数（含舍入）
      exp16 = exp32 - 127 + 15
      mant32 = mant32 + 0x1000 + ((mant32 >> 13) & 1)    // 向最近偶数舍入
      if (mant32 & 0x800000) != 0:    // 舍入导致进位
          mant32 = 0
          exp16 += 1
      result = sign | (exp16 << 10) | (mant32 >> 13)
  ```
- **Float16→Float32**（含次规格数标准化）：
  ```
  sign32 = (bits16 & 0x8000) << 16
  exp16 = (bits16 >> 10) & 0x1F
  mant16 = bits16 & 0x3FF

  if exp16 == 31:                     // Inf/NaN
      result = sign32 | 0x7F800000 | (mant16 << 13)
  elif exp16 == 0:
      if mant16 == 0:
          result = sign32             // 保留符号零
      else:
          // 次规格数：通过循环左移标准化到规格化数格式
          e = -1
          m = mant16
          while (m & 0x400) == 0:     // 直到隐藏位出现
              m <<= 1
              e -= 1
          m = (m & 0x3FF) << 13       // 移除隐藏位，左移对齐 float32 尾数位置
          exp32 = e + 127
          result = sign32 | (exp32 << 23) | m
  else:
      exp32 = exp16 - 15 + 127
      result = sign32 | (exp32 << 23) | (mant16 << 13)
  ```

### ulp.cj

**包路径**：`glm.gtc`
**形态**：包级具体类型重载函数（Float32 + Float64）

函数清单（共 8 个）：

```
func next_float(x: Float32): Float32
func next_float(x: Float64): Float64
func prev_float(x: Float32): Float32
func prev_float(x: Float64): Float64
func float_distance(x: Float32, y: Float32): Int32
func float_distance(x: Float64, y: Float64): Int64
func ulp(x: Float32): Float32
func ulp(x: Float64): Float64
```

**实现公式**：
- `next_float(x)`：正数：`Float32.fromBits(x.toBits() + 1u)`，负数：`Float32.fromBits(x.toBits() - 1u)`。零值：返回最小正数。
- `prev_float(x)`：正数：`Float32.fromBits(x.toBits() - 1u)`，负数：`Float32.fromBits(x.toBits() + 1u)`。零值：返回最小负数。
- `float_distance(x, y)`：`Int32(Float32Bits(y) - Float32Bits(x))`（Float64 对应返回 Int64）
- `ulp(x)`：`next_float(x) - x`。当 x 为非规格化数或零时，返回最小正数。

**注意**：`x.toBits()` 对于 Float32 返回 `UInt32`，对于 Float64 返回 `UInt64`。加法使用 `+ 1u` 字面量需与对应位宽匹配（`UInt32(1)` 或 `UInt64(1)`）。

**零值和边界处理**：
- `x == Float32(0.0)` → `next_float(x)` 返回最小正 Float32（`Float32.fromBits(1u)`）
- `x == Float64(0.0)` → `next_float(x)` 返回最小正 Float64（`Float64.fromBits(1u)`）
- `x == Float32(0.0)` → `prev_float(x)` 返回最小负 Float32（`Float32.fromBits(0x80000001u)`）
- `x == Float64(0.0)` → `prev_float(x)` 返回最小负 Float64

### round.cj

**包路径**：`glm.gtc`
**形态**：包级泛型函数 `T <: FloatingPoint<T>`

函数清单（共 6 个）：

```
func roundPowerOfTwo<T>(x: T): T where T <: FloatingPoint<T>
func ceilPowerOfTwo<T>(x: T): T where T <: FloatingPoint<T>
func floorPowerOfTwo<T>(x: T): T where T <: FloatingPoint<T>
func roundMultiple<T>(x: T, multiple: T): T where T <: FloatingPoint<T>
func ceilMultiple<T>(x: T, multiple: T): T where T <: FloatingPoint<T>
func floorMultiple<T>(x: T, multiple: T): T where T <: FloatingPoint<T>
```

**实现公式**：
- `floorPowerOfTwo(x)`: 通过 frexp/ldexp 模式实现。`frexp(x)` → (mantissa, exponent)，返回 `ldexp(T(1), exponent - 1)`。或者使用位操作提取指数。
- `ceilPowerOfTwo(x)`: `if x == floorPowerOfTwo(x) { x } else { ldexp(T(1), exponent) }` 其中 exponent 为 floorPowerOfTwo 的指数 + 1
- `roundPowerOfTwo(x)`: 与 2 的幂比较选择最近者
- `roundMultiple(x, multiple)`: `multiple * round(x / multiple)`
- `ceilMultiple(x, multiple)`: `multiple * ceil(x / multiple)`
- `floorMultiple(x, multiple)`: `multiple * floor(x / multiple)`

**边界行为**（NaN/Inf/零值/负数按 IEEE 754 自然传播）：

| 函数 | NaN | +Inf | -Inf | 零值 | 负数 |
|------|-----|------|------|------|------|
| `roundPowerOfTwo` | NaN | +Inf | -Inf | ±0 | 绝对值舍入后恢复符号 |
| `ceilPowerOfTwo` | NaN | +Inf | -Inf | ±0 | 返回 ±0 |
| `floorPowerOfTwo` | NaN | +Inf | -Inf | ±0 | 绝对值取幂后恢复符号 |
| `roundMultiple` | NaN | +Inf | -Inf | ±0 | 按公式自然计算 |
| `ceilMultiple` | NaN | +Inf | -Inf | ±0 | 按公式自然计算 |
| `floorMultiple` | NaN | +Inf | -Inf | ±0 | 按公式自然计算 |

**注**：`frexp`/`ldexp` 来自 `glm.detail`（common.cj），可直接使用。

### type_precision.cj

**包路径**：`glm.gtc`
**形态**：包级 type 别名定义（69 个）

定义模板：
```cangjie
// Float32 向量系族（统一使用 Defaultp，与项目惯例一致）
public type fvec1 = Vec1<Float32, Defaultp>
public type fvec2 = Vec2<Float32, Defaultp>
public type fvec3 = Vec3<Float32, Defaultp>
public type fvec4 = Vec4<Float32, Defaultp>

// Float64 向量系族
public type dvec1 = Vec1<Float64, Defaultp>
public type dvec2 = Vec2<Float64, Defaultp>
public type dvec3 = Vec3<Float64, Defaultp>
public type dvec4 = Vec4<Float64, Defaultp>

// 整数向量系族
public type ivec2 = Vec2<Int32, Defaultp>
public type ivec3 = Vec3<Int32, Defaultp>
public type ivec4 = Vec4<Int32, Defaultp>
public type uvec2 = Vec2<UInt32, Defaultp>
public type uvec3 = Vec3<UInt32, Defaultp>
public type uvec4 = Vec4<UInt32, Defaultp>

// Int8 向量
public type i8vec2 = Vec2<Int8, Defaultp>
public type i8vec3 = Vec3<Int8, Defaultp>
public type i8vec4 = Vec4<Int8, Defaultp>
public type u8vec2 = Vec2<UInt8, Defaultp>
public type u8vec3 = Vec3<UInt8, Defaultp>
public type u8vec4 = Vec4<UInt8, Defaultp>

// Int16 向量
public type i16vec2 = Vec2<Int16, Defaultp>
public type i16vec3 = Vec3<Int16, Defaultp>
public type i16vec4 = Vec4<Int16, Defaultp>
public type u16vec2 = Vec2<UInt16, Defaultp>
public type u16vec3 = Vec3<UInt16, Defaultp>
public type u16vec4 = Vec4<UInt16, Defaultp>

// Int32 向量（精确宽度）
public type i32vec2 = Vec2<Int32, Defaultp>
public type i32vec3 = Vec3<Int32, Defaultp>
public type i32vec4 = Vec4<Int32, Defaultp>
public type u32vec2 = Vec2<UInt32, Defaultp>
public type u32vec3 = Vec3<UInt32, Defaultp>
public type u32vec4 = Vec4<UInt32, Defaultp>

// Int64 向量
public type i64vec2 = Vec2<Int64, Defaultp>
public type i64vec3 = Vec3<Int64, Defaultp>
public type i64vec4 = Vec4<Int64, Defaultp>
public type u64vec2 = Vec2<UInt64, Defaultp>
public type u64vec3 = Vec3<UInt64, Defaultp>
public type u64vec4 = Vec4<UInt64, Defaultp>

// Float16 向量
public type hvec1 = Vec1<Float16, Defaultp>
public type hvec2 = Vec2<Float16, Defaultp>
public type hvec3 = Vec3<Float16, Defaultp>
public type hvec4 = Vec4<Float16, Defaultp>

// Float32 矩阵
public type fmat2x2 = Mat2x2<Float32, Defaultp>
public type fmat2x3 = Mat2x3<Float32, Defaultp>
public type fmat2x4 = Mat2x4<Float32, Defaultp>
public type fmat3x2 = Mat3x2<Float32, Defaultp>
public type fmat3x3 = Mat3x3<Float32, Defaultp>
public type fmat3x4 = Mat3x4<Float32, Defaultp>
public type fmat4x2 = Mat4x2<Float32, Defaultp>
public type fmat4x3 = Mat4x3<Float32, Defaultp>
public type fmat4x4 = Mat4x4<Float32, Defaultp>
public type fmat2 = fmat2x2; public type fmat3 = fmat3x3; public type fmat4 = fmat4x4

// Float64 矩阵
public type dmat2x2 = Mat2x2<Float64, Defaultp>
public type dmat2x3 = Mat2x3<Float64, Defaultp>
public type dmat2x4 = Mat2x4<Float64, Defaultp>
public type dmat3x2 = Mat3x2<Float64, Defaultp>
public type dmat3x3 = Mat3x3<Float64, Defaultp>
public type dmat3x4 = Mat3x4<Float64, Defaultp>
public type dmat4x2 = Mat4x2<Float64, Defaultp>
public type dmat4x3 = Mat4x3<Float64, Defaultp>
public type dmat4x4 = Mat4x4<Float64, Defaultp>
public type dmat2 = dmat2x2; public type dmat3 = dmat3x3; public type dmat4 = dmat4x4

// 四元数
public type fquat = Quat<Float32, Defaultp>
// dquat 与 glm.ext.quaternion_double.cj 已定义的 dquat 名称冲突（Defaultp == PackedHighp，类型实质相同）。
// 当前两文件分属不同包（glm.gtc vs glm.ext），不会触发编译错误。
// R10 更新 lib.cj 时，删除 ext/quaternion_double.cj 的 dquat 定义，统一由此处提供。
public type dquat = Quat<Float64, Defaultp>
public type hquat = Quat<Float16, Defaultp>
```

## 测试设计

### packing_test.cj

| @Test 函数 | 验证内容 |
|-----------|---------|
| `testPackUnorm4x8Roundtrip` | packUnorm4x8 → unpackUnorm4x8 还原；边界值 0/1 |
| `testPackSnorm4x8Roundtrip` | packSnorm4x8 → unpackSnorm4x8 还原；边界值 -1/1 |
| `testPackHalf1x16Roundtrip` | packHalf1x16 → unpackHalf1x16 还原（Float32↔Float16） |
| `testPackDouble2x32Roundtrip` | packDouble2x32 → unpackDouble2x32 互逆 |

使用 `@Expect(val, expected)` 或 `@Expect(abs(val - expected) < epsilon, true)` 验证。

### ulp_test.cj

| @Test 函数 | 验证内容 |
|-----------|---------|
| `testNextFloatUlpDelta` | Float32: `next_float(1.0f) - 1.0f == 2^-23` |
| `testFloatDistanceAdjacent` | `float_distance(x, next_float(x)) == ±1` |
| `testUlpNormal` | `ulp(1.0f) == 2^-23` |
| `testUlpBoundary` | ulp(Inf)/ulp(NaN)/ulp(0) 边界 |

### round_test.cj

| @Test 函数 | 验证内容 |
|-----------|---------|
| `testRoundPowerOfTwo` | 零值、2 的幂（4→4）、非 2 的幂（3→4, 5→4）、负数 |
| `testCeilPowerOfTwo` | 零值、2 的幂、非 2 的幂、负数 |
| `testFloorPowerOfTwo` | 零值、2 的幂、非 2 的幂、负数 |
| `testRoundMultiple` | 倍数边界、NaN/Inf/零值/负数 |

## 错误处理

- packing.cj：无显式异常。packUnorm/packSnorm 对越界输入使用 `clamp` 静默处理；packHalf 位操作由语言保证正确。
- ulp.cj：无显式异常。NaN/Inf/零值输入由分支逻辑处理。
- round.cj：无显式异常。NaN/Inf 经 IEEE 754 自然传播。
- type_precision.cj：纯类型别名，无运行时行为。

## 行为契约

### packing.cj 位操作须知

**偏差传递（来自 docs/deviations.md）**：
- **IMPL-04**：`Float32.toBits().toInt32()` 不存在。使用 `(x.toBits() as Int32).getOrThrow()` 替代 `floatBitsToInt` 中的类型转换；使用 `Float32.fromBits((bits as UInt32).getOrThrow())` 替代 `intBitsToFloat` 中的类型转换。
- **标量类型转换**：`(round(val) as UInt8).getOrThrow()` 模式。
- **`toBits()` 返回类型**：`Float32.toBits(): UInt32`，`Float64.toBits(): UInt64`，`Float16.toBits(): UInt16`。

### round.cj 泛型须知

- `floorPowerOfTwo` 可通过 `frexp`/`ldexp` 实现（来自 `glm.detail.common.cj`）
- 注意 `FloatingPoint<T>` 约束下 `==` 不可用（偏差 IMPL-03），需要比较时转换为 `Float64` 后比较

## 依赖关系

| 文件 | 依赖 |
|------|------|
| `packing.cj` | `glm.detail.{ Vec2, Vec3, Vec4, Qualifier }` + `std.math.FloatingPoint` |
| `ulp.cj` | `std.math.FloatingPoint` |
| `round.cj` | `glm.detail.{ round, floor, ceil, frexp, ldexp }` + `std.math.FloatingPoint` |
| `type_precision.cj` | `glm.detail.{ Vec1~Vec4, Mat2x2~Mat4x4, Quat, Defaultp, PackedHighp }` |
| `packing_test.cj` | `glm.gtc.{ packUnorm4x8, unpackUnorm4x8, ... }` + `std.unittest.*` |
| `ulp_test.cj` | `glm.gtc.{ next_float, prev_float, float_distance, ulp }` + `std.unittest.*` |
| `round_test.cj` | `glm.gtc.{ roundPowerOfTwo, ceilPowerOfTwo, floorPowerOfTwo, roundMultiple, ceilMultiple, floorMultiple }` + `std.unittest.*` |

## 偏差提示（传递给 Coder）

1. **IMPL-04**（类型转换）：`Float32.toBits().toInt32()` 不存在。统一使用 `(value as TargetType).getOrThrow()` 模式。
2. **IMPL-05**（Int64 转换）：`Float64.toInt64()` 不存在。使用 `(float64Val as Int64).getOrThrow()`。
3. **IMPL-03**（FloatingPoint 约束下 `==` 不可用）：比较泛型 T 的值时，先转为 Float64 再比较。
4. 构造函数使用 `T(Float64(n))` 模式，如 `(Float64(1) as T).getOrThrow()`。
5. `Float32.toBits()` 返回 `UInt32`，`Float64.toBits()` 返回 `UInt64`，`Float16.toBits()` 返回 `UInt16`。
6. **本批次不修改 lib.cj**——留待 R10 统一处理。

## 修订说明（v9 r1）

| 审查意见 | 修改措施 |
|---------|---------|
| `dquat` 与 `glm.ext.quaternion_double.cj:3` 已定义的 `dquat` 冲突，R10 更新 lib.cj 时将导致名称冲突编译失败 | 在 `type_precision.cj` 的 `dquat` 定义处添加显式冲突说明和 R10 解冲突方案（删除 ext 的 `dquat` 定义，统一由 type_precision.cj 提供）。当前批次不受影响（不同包），R10 按计划处理 |
| 函数数量标注 "27 个" 与实际清单 32 个不一致 | 修正为 "函数清单（共 32 个）" |
| `fvec1` 使用 `PackedHighp` 而其他家族使用 `Defaultp`，风格不统一 | 将 `fvec1~fvec4` 的精度限定符统一改为 `Defaultp`，与项目惯例一致（`Defaultp == PackedHighp` 无行为差异） |
| `packHalf` 位转换描述不够具体，仅提及位布局未给出转换步骤 | 替换为完整的 IEEE 754 Float32↔Float16 转换步骤伪代码，含 sign/exp/mantissa 提取、偏移调整、下溢/Inf/NaN 分支处理 |

## 修订说明（v9 r2）

| 审查意见 | 修改措施 |
|---------|---------|
| [严重] packSnorm 函数族缺少 signed→unsigned 位重解释步骤，负值转换直接 `as UInt8` 会失败 | packSnorm1x8/1x16 公式改为先 `Int8(...)` 数值转换，再 `as UInt8` 位重解释。向量系族同理 |
| [严重] unpackSnorm 函数族缺少 unsigned→signed 位重解释步骤，pack→unpack 互逆性被破坏 | unpackSnorm1x8 公式改为先 `(p as Int8).getOrThrow()` 位重解释为有符号，再转 Float32 |
| [严重] Float16→Float32 (unpackHalf) 次规格数/零值公式错误，零值不返回 0，次规格数指数错误 | 重写 `exp16 == 0` 分支：零值返回 `sign`（保留符号零）；次规格数通过 while 循环左移标准化，再走规格化数路径 |
| [一般] Float32→Float16 (packHalf) 缺少舍入步骤，右移直接截断导致精度损失 | 在规格化数和下溢路径中添加向最近偶数舍入逻辑：`mant32 + 0x1000 + ((mant32 >> 13) & 1)`，处理进位溢出 |
| [一般] packDouble2x32 / unpackDouble2x32 类型不一致，使用 Vec2\<Float64\> 但实际应为 Vec2\<UInt32\> | 签名改为 `Vec2<UInt32, Q> → Float64` / `Float64 → Vec2<UInt32, Q>`，公式相应调整 |
| [轻微] type_precision.cj 别名数量"~100 个"与实际 69 个不符 | "~100 个"修正为"69 个" |
