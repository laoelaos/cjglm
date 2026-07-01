# 任务指令（v10）

## 动作
NEW

## 任务描述
实现 Batch B-2（阶段四最终批）：新建 gtc/noise.cj、gtc/random.cj、更新 lib.cj、新建对应测试、编译验证。

## 文件清单

### A. 新建源文件（2 个文件）

| 文件 | 实现要点 |
|------|---------|
| `src/gtc/noise.cj` | Perlin/Simplex 噪声函数（8 个公共泛型函数 + 5 个私有辅助函数）。包名：`glm.gtc`。详见 OOD 设计 §3.3 gtc/noise.cj。 |
| `src/gtc/random.cj` | 随机数生成函数（linearRand/gaussRand 标量 + Vec1~Vec4 版本）。包名：`glm.gtc`。使用 `ThreadLocal<Random>` 管理引擎。详见 OOD 设计 §3.3 gtc/random.cj。 |

### B. 修改文件（1 个文件）

| 文件 | 修改内容 |
|------|---------|
| `src/lib.cj` | ① 修改第 23 行：从 `public import glm.gtc.{identity, translate, rotate, rotate_slow, scale, scale_slow, shear, shear_slow, lookAt, lookAtRH, lookAtLH}` 改为 `public import glm.gtc.{identity, rotate_slow, scale_slow, shear_slow}`。② 在文件末尾追加 Phase 4 全部 public import：common.cj 函数族、exponential.cj、geometric.cj、matrix.cj、ext/scalar_common+vector_common、ext 扩展函数库、gtc packing/noise/random/ulp/round/type_precision 的全部符号（详见 §8 lib.cj 更新节）。 |

### C. 新建测试文件（2 个文件）

| 测试文件 | 说明 |
|---------|------|
| `tests/glm/gtc/noise_test.cj` | perlin/simplex 各维度输出范围检查（噪声值应在 [-1,1] 或 [0,1] 内）+ 周期性噪声的首尾连续验证。 |
| `tests/glm/gtc/random_test.cj` | linearRand 统计分布均匀性（大样本均值/方差验证）+ gaussRand 均值/标准差验证。 |

### D. 编译验证

- 运行 `cjpm build` 确认编译通过，无符号重复或歧义错误
- 运行 `cjpm test`（或对应测试命令）确认 435+ 测试全部通过

## 选择理由
阶段四最后一轮。本批完成后：
- `src/gtc/noise.cj` 和 `src/gtc/random.cj` 是剩余唯一未实现的 gtc 模块
- `lib.cj` 更新必须等所有模块完成后统一做（含第 23 行修改和全部新符号导出）
- 编译验证确认全部 4 批编码成果集成正确

## 任务上下文

### gtc/noise.cj 函数签名（来自 OOD 设计 §3.3）

```
// 私有辅助函数（包级 private，非公共 API）
func mod289<T, Q>(x: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
func permute<T, Q>(x: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
func taylorInvSqrt<T, Q>(r: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
func fade<T, Q>(t: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
func grad4<T, Q>(j: T, ip: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier

// 公共 API：Perlin 噪声（标量 1D + Vec 2/3/4D）
func perlin1D<T, Q>(x: T): T where T <: FloatingPoint<T>, Q <: Qualifier
func perlin2D<T, Q>(v: Vec2<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier
func perlin3D<T, Q>(v: Vec3<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier
func perlin4D<T, Q>(v: Vec4<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier

// 公共 API：Simplex 噪声
func simplex1D<T, Q>(x: T): T where T <: FloatingPoint<T>, Q <: Qualifier
func simplex2D<T, Q>(v: Vec2<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier
func simplex3D<T, Q>(v: Vec3<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier
func simplex4D<T, Q>(v: Vec4<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier

// Perlin 周期噪声重载（1D/2D/3D/4D 各一周期版）
func perlin1D<T, Q>(x: T, period: T): T where T <: FloatingPoint<T>, Q <: Qualifier
func perlin2D<T, Q>(v: Vec2<T, Q>, period: Vec2<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier
func perlin3D<T, Q>(v: Vec3<T, Q>, period: Vec3<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier
func perlin4D<T, Q>(v: Vec4<T, Q>, period: Vec4<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier
```

- 算法参考 GLM 1.0.3 `detail/_noise.hpp` 和 `gtc/noise.inl`
- 纯算法实现，无需静态排列表或梯度数组
- 噪声值范围：Perlin 约 [-1,1]，Simplex 约 [-1,1]

### gtc/random.cj 函数签名

```
func linearRand<T, Q>(min: T, max: T): T where T <: FloatingPoint<T>, Q <: Qualifier
func linearRand<T, Q>(min: Vec2<T, Q>, max: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
// Vec1/Vec3/Vec4 同理
func gaussRand<T, Q>(mean: T, stddev: T): T where T <: FloatingPoint<T>, Q <: Qualifier
```

- 使用仓颉 `std.random.Random` 作为底层随机数源
- 引擎管理：`ThreadLocal<Random>` 线程本地存储，惰性初始化
- 种子策略：`DateTime.now().toUnixMillisecond() ^ std.env.getProcessId()`
- `linearRand` 内部调用 `r.nextFloat64()` 映射到 [min, max]
- `gaussRand` 内部调用 `r.nextGaussianFloat64()` 映射到均值/标准差

### lib.cj 修改详情

**第 1 步 — 修改第 23 行**（从 gtc 导入中删除由 ext 统一导出的符号）：
```
// 修改前：
public import glm.gtc.{identity, translate, rotate, rotate_slow, scale, scale_slow, shear, shear_slow, lookAt, lookAtRH, lookAtLH}
// 修改后：
public import glm.gtc.{identity, rotate_slow, scale_slow, shear_slow}
```

**第 2 步 — 在文件末尾追加以下 public import（增量追加）**：
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

### 已有代码上下文
**已就绪的全部依赖**：
- `glm.detail` 包：Vec1~Vec4、Mat2x2~Mat4x4、Quat、common.cj（133 函数）、exponential.cj（35 函数）、trigonometric.cj（75 函数）、matrix.cj（determinant/inverse）、geometric.cj
- `glm.ext` 包：scalar_common.cj、vector_common.cj、quaternion 系列、matrix 系列全部完整
- `glm.gtc` 包：constants.cj、quaternion.cj、matrix_transform.cj、matrix_inverse.cj、matrix_access.cj、packing.cj、ulp.cj、round.cj、type_precision.cj 全部完整
- `glm` 包：lib.cj（当前层导入基础函数和部分 gtc 函数）

**当前测试状态**：435 tests 全部通过。

### 关键实现约束
1. **noise.cj**：纯算法迁移（GLM 1.0.3 `detail/_noise.hpp` + `gtc/noise.inl`）。所有辅助函数作为私有包级函数。使用 `glm.detail` 的 Vec 类型和 common 函数（mod/fract/floor/abs/min/max/dot/mix/step/lessThan/clamp/roundEven 等）。注意浮点字面量使用 `T(Float64(n))` 模式（或 `(n as T).getOrThrow()`）。
2. **random.cj**：唯一包含可变状态的模块。`ThreadLocal<Random>` 惰性初始化 + `nextFloat64()` 调用。`linearRand` 标量版：`min + (max - min) * r.nextFloat64()`。`gaussRand`：`mean + stddev * r.nextGaussianFloat64()`。向量版逐分量调用标量版。
3. **lib.cj 第 23 行修改**：必须精确按 §8 所述修改，删除 `translate/rotate/scale/shear/lookAt/lookAtRH/lookAtLH` 从 gtc 导入，保留 `identity/rotate_slow/scale_slow/shear_slow`。
4. **编译验证**：`cjpm build` 无错误 + `cjpm test` 全部通过（原 435 + noise/random 新增测试用例）。

### 参考实现来源
GLM 1.0.3 对应文件：
- `detail/_noise.hpp` + `gtc/noise.hpp` + `gtc/noise.inl` → gtc/noise.cj
- `gtc/random.hpp` + `gtc/random.inl` → gtc/random.cj
