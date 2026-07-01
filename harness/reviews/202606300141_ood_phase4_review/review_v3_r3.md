# R3: GTC 层级测试文件审查 — 覆盖度、正确性与 OOD 一致性

审查时间：2026-06-30

### 审查范围

- `cjglm/tests/glm/gtc/matrix_transform_test.cj`（138 行）
- `cjglm/tests/glm/gtc/matrix_inverse_test.cj`（71 行）
- `cjglm/tests/glm/gtc/matrix_access_test.cj`（173 行）
- `cjglm/tests/glm/gtc/packing_test.cj`（86 行）
- `cjglm/tests/glm/gtc/noise_test.cj`（130 行）
- `cjglm/tests/glm/gtc/random_test.cj`（96 行）
- `cjglm/tests/glm/gtc/round_test.cj`（86 行）
- `cjglm/tests/glm/gtc/ulp_test.cj`（73 行）

参考：`docs/06_ood_phase4.md` §3.3、`cjglm/src/gtc/*.cj` 实现源码

### 发现

#### [严重] testShearSlowDiagonal 期望值错误

- **位置**：`cjglm/tests/glm/gtc/matrix_transform_test.cj:107-109`
- **描述**：`testShearSlowDiagonal` 对 `shear_slow` 的期望值计算有误。输入 `n = Vec3(0.5, 0.5, 0.0)`, `s = 2.0`，根据实现公式 `H = I + s * n * n^T`，`H.c0.y = s * n.y * n.x = 2.0 * 0.5 * 0.5 = 0.5`，`H.c1.x = s * n.x * n.y = 0.5`。但测试期望 `r.c0.y == 1.0` 和 `r.c1.x == 1.0`，正确值应为 `0.5`。
- **建议**：将 `@Expect(r.c0.y, 1.0)` 改为 `@Expect(r.c0.y, 0.5)`，`@Expect(r.c1.x, 1.0)` 改为 `@Expect(r.c1.x, 0.5)`。

#### [一般] matrix_transform 委托 ext 的函数覆盖不全

- **位置**：`cjglm/tests/glm/gtc/matrix_transform_test.cj`
- **描述**：gtc `matrix_transform` 通过 `public import glm.ext.*` 委托 ext 层约 50+ 个函数（`rotate`、`scale`、`lookAt`、`lookAtRH`、`lookAtLH`、perspective 系族 9 个、frustum 系族 9 个、perspectiveFov 系族 9 个、infinitePerspective 系族 7 个、tweakedInfinitePerspective 2 个、projectZO/NO、unProjectZO/NO、pickMatrix）。当前仅 `translate` 和 `ortho` 两个函数通过 gtc 入口测试，其余均未覆盖。
- **建议**：对每个委托函数至少添加一个正向调用测试，验证 gtc 入口到 ext 实现的传递路径正确。

#### [一般] matrix_inverse 缺少一致性验证

- **位置**：`cjglm/tests/glm/gtc/matrix_inverse_test.cj`
- **描述**：scope 要求验证 `affineInverse` 与 `inverse + transpose` 的一致性以及 `transpose(inverse(m)) == inverseTranspose(m)` round-trip。当前仅验证了 `m * affineInverse(m) == I` 的乘积恒等式，未验证 `inverseTranspose(m) == transpose(inverse(m))` 的等价性。
- **建议**：添加显式 round-trip 测试：构造一个非奇异 Mat4x4，计算 `invT = inverseTranspose(m)` 和 `manual = transpose(inverse(m))`，断言二者逐分量相等（epsilon 容差）。

#### [一般] matrix_access 部分矩阵类型缺少测试

- **位置**：`cjglm/tests/glm/gtc/matrix_access_test.cj`
- **描述**：9 种矩阵类型的 `row`/`column` 重载中，`Mat2x2`、`Mat3x2`、`Mat4x3` 三个类型缺少测试。当前覆盖了 Mat4x4、Mat2x3、Mat3x3、Mat4x2、Mat2x4、Mat3x4，共 6/9 种。
- **建议**：补充 `Mat2x2`、`Mat3x2`、`Mat4x3` 的 `row`/`column` 正向测试。

#### [一般] packing 测试覆盖度偏低

- **位置**：`cjglm/tests/glm/gtc/packing_test.cj`
- **描述**：`src/gtc/packing.cj` 共 18+ 个公共函数，测试仅覆盖 6 个核心函数（packUnorm4x8、packSnorm4x8、packHalf1x16、packDouble2x32 及其解包对应）。未覆盖的包括：packUnorm1x8/2x8/1x16/2x16/4x16、packSnorm1x8/2x8/1x16/2x16/4x16、packHalf2x16/4x16 及其对应解包函数。
- **建议**：至少为每种打包模式添加一个 round-trip 测试（如 packUnorm1x8→unpackUnorm1x8）。

#### [一般] noise 缺少 isFinite 验证和边界输入测试

- **位置**：`cjglm/tests/glm/gtc/noise_test.cj`
- **描述**：所有 perlin/simplex 测试仅通过范围 `[-1.1, 1.1]` 验证，未显式检查 `!isNaN()` 和 `isFinite()`。Scope 要求"结果一致性验证（非零、有限）"。此外缺少边界输入（零向量、极大值等）的测试。
- **建议**：为每个噪声函数添加 `@Expect(result.isFinite(), true)` 断言；添加边界输入测试如 `perlin2D(Vec2(0.0, 0.0))`、`simplex3D(Vec3(0.0, 0.0, 0.0))`。

#### [一般] ulp 的 float_distance 缺少 NaN/Inf/负值输入测试

- **位置**：`cjglm/tests/glm/gtc/ulp_test.cj`
- **描述**：scope 要求"float_distance 正/负/零/NaN/Inf 输入测试"。当前仅测试了正数相邻值的 `float_distance`（结果为 1 和 -1），未覆盖 `float_distance(NaN, x)`、`float_distance(x, Inf)`、负值输入等场景。
- **建议**：添加 `float_distance(Float32.nan, Float32(1.0))`、`float_distance(Float32(1.0), Float32.infinity())`、`float_distance(Float32(-1.0), Float32(1.0))` 等边界调用测试。

#### [一般] ulp 的 prev_float 缺少 Float64、零值、NaN/Inf 测试

- **位置**：`cjglm/tests/glm/gtc/ulp_test.cj:64-68`
- **描述**：`testPrevFloat` 仅测试了 `Float32(1.0)` 的 `prev_float`，缺少 Float64 版本、`prev_float(0.0)`、`prev_float(NaN)`、`prev_float(Inf)` 的测试。
- **建议**：添加 `prev_float` 的 Float64 版本测试，以及零值、NaN、Inf 边界测试。

#### [轻微] random 的 Vec 版本 linearRand 仅验证范围未验证均值

- **位置**：`cjglm/tests/glm/gtc/random_test.cj:20-58`
- **描述**：标量 `linearRand` 通过 1000 次抽样验证了均值在 [3, 7] 区间，但 Vec1~Vec4 的 `linearRand` 仅验证范围，未做统计分析。
- **建议**：为 Vec1 版本添加均值统计验证（与标量版本一致）。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 1 |
| 一般 | 7 |
| 轻微 | 1 |

### 总评

测试文件整体结构合理，基本调用路径覆盖了各模块的核心公共函数。**round_test.cj 覆盖最为完整**（所有函数 + NaN/Inf 边界），可作为其他模块的覆盖标杆。**发现一个严重错误**：`matrix_transform_test.cj` 的 `testShearSlowDiagonal` 有两处期望值计算错误（`r.c0.y` 应为 0.5 非 1.0，`r.c1.x` 应为 0.5 非 1.0）。**主要覆盖缺口**在于：matrix_transform 委托 ext 的 50+ 函数缺乏 gtc 入口测试，packing 仅覆盖 1/3 的函数，ulp 的 float_distance 和 prev_float 缺少 NaN/Inf/边界测试。建议优先修复严重错误后逐步填补覆盖缺口。
