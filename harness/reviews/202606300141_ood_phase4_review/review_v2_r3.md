# R3: GTC 扩展函数库其余 6 个文件审查（packing/noise/random/type_precision/ulp/round）

审查时间：2026-06-30

### 审查范围

- `cjglm/src/gtc/packing.cj` — 数据打包/解包函数（251 行）
- `cjglm/src/gtc/noise.cj` — Perlin/Simplex 噪声函数（580 行）
- `cjglm/src/gtc/random.cj` — 随机数生成函数（47 行）
- `cjglm/src/gtc/type_precision.cj` — 高精度类型别名定义（87 行）
- `cjglm/src/gtc/ulp.cj` — 浮点 ULP 比较函数（73 行）
- `cjglm/src/gtc/round.cj` — 2 的幂舍入函数（68 行）

### 发现

#### [严重] `ulp.cj:float_distance` Int32/Int64 减法溢出导致异常抛出

- **位置**：`cjglm/src/gtc/ulp.cj:51-57`
- **描述**：`float_distance(x, y)` 实现为 `(y.toBits() as Int32).getOrThrow() - (x.toBits() as Int32).getOrThrow()`。IEEE 754 sign-magnitude 编码下，当 x 为负、y 为正时，位模式从 `0x80000000` 附近跨越到 `0x7FFFFFFF` 附近，两 reinterpret-cast 后的 Int32 值之差可能超过 `Int32.MAX`（2147483647），导致 `@OverflowThrowing` 默认策略下抛出 `ArithmeticException`。例如 `float_distance(-1.0f, 1.0f)`：`(0x3F800000 as Int32) - (0xBF800000 as Int32) = 1065353216 - (-1082130432) = 2147483648`，溢出抛出异常。Int64 版本同理，对跨越 ±0 边界的大距离也存在溢出风险（尽管 Int64 范围足够覆盖全部 Float64 位模式，但对极值对 `float_distance(-MAX, +MAX)` 仍可能溢出）。
- **建议**：将 `Int32` 差值运算提升到 `Int64` 后再压缩回 `Int32`（对 Float32 版本），或直接使用无符号减法后 reinterpret：`let diff = (y.toBits() as Int64).getOrThrow() - (x.toBits() as Int64).getOrThrow()` 再用饱和/截断返回 Int32。Float64 版本可直接用 UInt64 减法后 reinterpret 为 Int64（`UInt64` 减法不会溢出，但 reinterpret 需正确处理符号）。

#### [一般] `ulp.cj:float_distance` 未做 NaN/Inf 前置检查

- **位置**：`cjglm/src/gtc/ulp.cj:51-57`
- **描述**：`float_distance`（Float32 和 Float64 版本）缺少对 NaN/Inf 输入的前置检查。当 x 或 y 为 NaN/Inf 时，`toBits()` 返回对应的位模式（NaN：指数全 1 尾数非零；Inf：指数全 1 尾数为 0），直接做位模式减法会产生无意义的 ULP 距离值。GLM 1.0.3 的 `floatDistance` 函数未定义 NaN/Inf 行为（结果由实现定义），但按照本项目的 NaN/Inf 传播惯例，对此类输入应返回合理值或保持 NaN 传播。`next_float`/`prev_float`/`ulp` 均有 NaN/Inf 前置检查，`float_distance` 的一致缺失是功能遗漏。
- **建议**：添加 NaN/Inf 前置检查：若 `x.isNaN() || y.isNaN()` 返回 `0`（或 NaN 传播），若 `x.isInf() || y.isInf()` 返回 `0` 或 `Int32.MAX`。

#### [一般] `type_precision.cj:dquat` 与 `ext/quaternion_double.cj:dquat` 命名冲突

- **位置**：`cjglm/src/gtc/type_precision.cj:86`
- **描述**：`gtc/type_precision.cj` 定义了 `public type dquat = Quat<Float64, Defaultp>`，而 `ext/quaternion_double.cj:3` 已有 `public type dquat = Quat<Float64, PackedHighp>`。因 `Defaultp == PackedHighp`，两个别名类型实质相同，但由于分属 `glm.gtc` 和 `glm.ext` 不同包，编译器不会报错。注释已自我记录此冲突（第 83-85 行），并计划在 R10 更新 `lib.cj` 时统一。当前状态下，通过 `lib.cj` 的 `public import` 同时导入两个 `dquat` 将导致编译错误。
- **建议**：按注释计划，在更新 `lib.cj` 时删除 `ext/quaternion_double.cj:3` 的 `dquat` 定义，统一由 `type_precision.cj` 提供。在此之前应确认 `lib.cj` 的 `public import` 不重复导入 `dquat`。

#### [一般] `round.cj:roundPowerOfTwo` 对 ±0 输入丢失负零符号

- **位置**：`cjglm/src/gtc/round.cj:9-11`
- **描述**：`roundPowerOfTwo(-0.0)` 经过 `xF64 == 0.0` 分支返回 `(Float64(0) as T).getOrThrow()`，即 +0.0。OOD 设计表格（§3.3 round.cj 边界行为表）注明零值输入应返回 "±0"（保留原始符号）。虽然 -0.0 和 +0.0 在大多数数值比较中相等，但对 `1/(-0.0) → -Inf` 和 `1/(+0.0) → +Inf` 的传播路径有影响。`ceilPowerOfTwo` 和 `floorPowerOfTwo` 存在相同模式。
- **建议**：使用 `T.fromBits(x.toBits() & signBitMask)` 保留零值的符号，或使用条件表达式确保 -0.0 输入返回 -0.0。

#### [轻微] `packing.cj:packHalf1x16` 去规范化路径的移位操作溢出隐患

- **位置**：`cjglm/src/gtc/packing.cj:166-173`
- **描述**：去规范化路径中 `let shift = UInt32(113) - exp32`，当 `exp32 ≤ 94` 时 `shift ≥ 19`，`UInt32(1) << (UInt32(13) + shift)` 的左移量 ≥ 32，在 UInt32（32 位）上左移 ≥ 32 位的语义在仓颉中未明确定义（可能模 32 回绕或返回 0）。若编译器对超出位宽的左移返回 0，则溢出检测 `(m & ...) != 0` 始终不触发，导致极小值的舍入逻辑失效。但由于 `exp32 ≤ 94` 对应的 Float32 值极小（< 2^(-33)），在 Float16 中必然下溢为 0，此 bug 在典型图形计算中不会产生可见错误。
- **建议**：在 `exp32 ≤ 94` 时直接返回 `sign`（即 ±0），跳过中间计算，使代码清晰且避免潜在的移位未定义行为。

#### [轻微] `noise.cj:perlin1D` 缺少泛型中缀操作 `pow` 保护

- **位置**：`cjglm/src/gtc/noise.cj:120`
- **描述**：第 120 行 `u = fx * fx * fx * (fx * (fx * (Float64(6.0) as T).getOrThrow() - (Float64(15.0) as T).getOrThrow()) + (Float64(10.0) as T).getOrThrow())` 在 `T = Float16` 且 `fx` 接近 1.0 时可能因中间值超出 Float16 范围（±65504）导致 `getOrThrow()` 抛出异常。虽然此概率极低（fx 的分量值不会超过 1.0，乘积累积在 Float16 范围内），但该模式在全文件大量重复（约 10+ 处），构成 `T = Float16` 时的系统性风险。
- **建议**：无需立即修复（概率极低且 Float16 场景几乎不用噪声函数），但应记录至已知差异中。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 1 |
| 一般 | 3 |
| 轻微 | 2 |

### 总评

6 个 GTC 文件总体上与 OOD 设计文档 `docs/06_ood_phase4.md` §3.3 保持一致，函数签名、约束策略、实现路径基本正确。

**亮点**：
- `packing.cj`：packUnorm/packSnorm 的归一化公式正确（snorm: `round(clamp(v, -1, 1) * 127.0)`；unorm: `round(clamp(v, 0, 1) * 255.0)`），packHalf 的 Float32→Float16 手工位操作算法完整实现了 round-to-nearest-even 语义，packDouble2x32/unpackDouble2x32 使用 `Float64.fromBits` 正确实现位级打包
- `noise.cj`：580 行的 Perlin/Simplex 噪声实现结构清晰，辅助函数（mod289/permute/taylorInvSqrt/fade/grad4）完整对齐 GLM 1.0.3 算法，simplex 各维度的贡献函数梯度选择逻辑正确
- `random.cj`：linearRand 使用 `min + (max-min)*nextFloat64()` 均匀分布公式正确，gaussRand 使用 `nextGaussianFloat64` 委托标准库正态分布生成器正确，ThreadLocal<Random> 惰性初始化和种子生成策略与 OOD D19/D28 一致
- `type_precision.cj`：约 80 个别名与设计清单一致，使用 `Defaultp`（=PackedHighp）对齐 GLM 1.0.3 的高精度默认语义，与 `fwd.cj` 的泛型类型体系互补无冲突
- `ulp.cj`：next_float/prev_float 的 IEEE 754 sign-magnitude 位操作正确（正数 bits+1，负数 bits-1），ulp 函数的 NaN/Inf/zero/denormal 边界处理完整
- `round.cj`：round/ceil/floorPowerOfTwo 使用 frexp+ldexp 算法正确实现 2 的幂舍入，roundMultiple/ceilMultiple/floorMultiple 公式简洁正确

**需要关注的问题**：
1. `float_distance` 的 Int32 减法溢出是严重的正确性问题——对跨零值正负号的浮点对会抛出异常而非返回 ULP 距离，建议提升到 Int64 计算
2. `dquat` 命名冲突需在 lib.cj 更新时统一清理
3. 负零符号丢失和 packHalf 去规范化路径移位溢出为轻微问题，不影响典型图形计算场景
