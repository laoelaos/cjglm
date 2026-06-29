# R4 R2: 阶段三 ext/ 与 gtc/ 测试文件审查

审查时间：2026-06-27

### 审查范围

| 文件 | 行数 | @Test 数 | 职责 |
|------|------|---------|------|
| `cjglm/tests/glm/ext/test_vector_relational.cj` | 179 | 18 | 向量 epsilon 16 重载 + ULP stub 验证 |
| `cjglm/tests/glm/ext/test_quaternion_common.cj` | 101 | 10 | 四元数公共函数（3 完整 + 3 stub + 边界 + assert）|
| `cjglm/tests/glm/ext/test_quaternion_geometric.cj` | 49 | 5 | 四元数几何函数（4 完整 + normalize 零保护）|
| `cjglm/tests/glm/ext/test_quaternion_relational.cj` | 64 | 5 | 四元数关系函数（4 函数 + epsilon 边界）|
| `cjglm/tests/glm/ext/test_quaternion_trigonometric.cj` | 43 | 5 | 四元数三角函数（axis 3 分支 + 2 stub）|
| `cjglm/tests/glm/gtc/test_constants.cj` | 283 | 56 | 28 个数学常量（每函数 Float32 + Float64 双测试）|
| `cjglm/tests/glm/gtc/test_quaternion.cj` | 91 | 12 | 4 比较 + 7 stub |

合计 7 个文件、810 行、111 个 `@Test` 函数。

### 审查依据

- `docs/05_ood_phase3.md` §3.5（vector_relational）/§3.6（quaternion_relational）/§3.7（quaternion_geometric）/§3.9（quaternion_trigonometric）/§3.11（quaternion_common）/§3.12（gtc/constants）/§3.15（gtc/quaternion）/§11.5（函数可用性对照表）
- `references/glm-1.0.3/glm/glm/gtc/constants.inl`（28 常量函数 GLM 1.0.3 字面值 ground truth）
- `references/glm-1.0.3/glm/glm/ext/quaternion_common.inl:40-110`（slerp 3-arg/4-arg 签名 GLM 1.0.3 baseline）
- 实现文件作为期望值参照：
  - `cjglm/src/ext/vector_relational.cj`（epsilon 16 重载 + ULP 8 stub）
  - `cjglm/src/ext/quaternion_common.cj`（5 完整 + 3 stub）
  - `cjglm/src/ext/quaternion_geometric.cj`（4 完整）
  - `cjglm/src/ext/quaternion_relational.cj`（4 完整）
  - `cjglm/src/ext/quaternion_trigonometric.cj`（1 完整 + 2 stub）
  - `cjglm/src/gtc/constants.cj`（28 完整）
  - `cjglm/src/gtc/quaternion.cj`（4 完整 + 7 stub + 4 重导出）
- R2 轮次审查已发现项（`slerp` 4 参数 `spin: Bool` 偏离 OOD `k: Int64`、ULP stub 覆盖不全）——本轮基于先前 R2 上下文展开
- `cjpm.toml:8-9`：`[test] src-dir = "tests"`，所有 7 个测试文件位于该根下子目录，符合 cjpm test 默认发现规则

### 整体评价

7 个测试文件整体质量良好，覆盖策略清晰、断言准确、风格与现有阶段一/二测试文件保持一致：

- **覆盖完整度**——`test_quaternion_common.cj` 覆盖 3 完整函数（conjugate/inverse/lerp）+ 3 stub（mix/slerp 3-arg/slerp 4-arg 缺失）+ 边界（normalize-zero 风格的 inverse-zero）；`test_quaternion_geometric.cj` 覆盖 4 完整函数（dot/length/normalize/cross）+ normalize 零保护；`test_quaternion_relational.cj` 覆盖 4 关系函数 + epsilon=0/epsilon=1e-15 边界；`test_quaternion_trigonometric.cj` 覆盖 `axis` 三分支（单位四元数/非单位/零）+ 2 stub；`test_constants.cj` 严格覆盖 28 常量 × Float32/Float64 双类型 = 56 用例；`test_quaternion.cj` 覆盖 4 比较函数（含 all-equal 边界）+ 7 stub。
- **断言策略**——`@Expect` 用于精确值（lerp r0/r1/r05、test_constants 28×2 字面值、testInverse 乘积为单位四元数）；`@ExpectThrows[Exception]` 用于 assert 越界（testLerpAssertBelow/Above）与 stub 函数（mix/slerp/angle/angleAxis/7 个 gtc/quaternion stub）；`||` 短路逻辑用于反向断言（testInverseZero 用 `inv.x.isInf() || inv.x.isNaN()` 验证零四元数 inverse 的 NaN/Inf 边界）。
- **类型选择**——绝大多数测试使用 `Float64`/`<Defaultp>` 泛型具现化（与实现约束 `FloatingPoint<T>` / `Comparable<T>` 一致）；`test_quaternion.cj` 的 4 个比较函数用 `Int64`（与 OOD D33「`Comparable<T>` 宽约束支持整数四元数比较」决策一致）。`test_constants.cj` 严格按 OOD §3.12 要求做 Float32/Float64 双类型覆盖。
- **cjpm test 发现**——所有 7 个文件位于 `tests/glm/ext/` 或 `tests/glm/gtc/` 子目录，遵循 `cjpm.toml:8-9` `[test] src-dir = "tests"` 的递归发现规则；与现有 `tests/glm/test_ext.cj` / `test_lib.cj` / `test_fwd.cj` 同级可发现；`package` 声明分别为 `glm.ext` / `glm.gtc`，与实现侧 `package glm.ext` / `package glm.gtc` 对齐。

主要问题集中在**测试覆盖盲点**（ULP stub 严重不完整、slerp 4 参数 stub 完全缺失）与**任务派发 vs 实现的小幅不对齐**（mat3Cast/mat4Cast/quatCast gtc 重导出未在 gtc 层独立验证）两类。详细问题见下。

### 发现

#### [严重] ULP stub 覆盖严重不完整——8 个 stub 函数中仅 1 个被测试覆盖

- **位置**：`cjglm/tests/glm/ext/test_vector_relational.cj:175-178`（仅 `testEqualULPStub`）
- **描述**：根据 `cjglm/src/ext/vector_relational.cj:197-251` 实现，ULP 版本的 stub 函数总计 8 个：

  | 函数 | Vec1 | Vec2 | Vec3 | Vec4 |
  |------|------|------|------|------|
  | `equal` (Int64 ULPs) | stub | stub | stub | stub |
  | `equal` (VecN<Int64, Q> ULPs) | stub | stub | stub | stub |
  | `notEqual` (Int64 ULPs) | stub | stub | stub | stub |
  | `notEqual` (VecN<Int64, Q> ULPs) | stub | stub | stub | stub |

  当前 `testEqualULPStub`（line 175-178）仅覆盖 `equal(x: Vec1<Float64, Defaultp>, y: Vec1<Float64, Defaultp>, ULPs: Int64)` 一个组合，覆盖率 **1/32 = 3.125%**（按"函数 × 向量维度 × ULP 参数形态"网格统计）。**实际未覆盖**：
  - `notEqual` ULP 版本（4 重载 × 2 参数形态 = 8 个 stub）
  - `equal` ULP 在 Vec2/Vec3/Vec4 的 6 个 stub 重载
  - `equal` ULP 在 Vec1/2/3/4 的 `VecN<Int64, Q>` 参数形态（4 个 stub 重载）
  - `notEqual` ULP 在 Vec1/2/3/4 的 `VecN<Int64, Q>` 参数形态（4 个 stub 重载）

  R2-Agent3 已识别此问题（任务派发重点 #2「8 个 ULP stub 的测试——是否覆盖 Vec2/Vec3/Vec4」），本轮确认该问题**未被修复**。
- **影响**：
  1. **测试盲点**——阶段四补齐 ULP 实现时，如实现者误改 `notEqual` ULP 签名为 `throw Exception("stub")` 之外的形态或类型参数变化，`cjpm test` 不会捕获到编译期回归。
  2. **stub 路径覆盖**——8 个 stub 函数体均抛 `Exception("stub")`，但仅 1 个被运行时验证抛 stub；其他 7 个 stub 的「抛 stub」契约未被测试覆盖。
  3. **不阻塞阶段三发布**——stub 函数无业务逻辑，仅要求「编译期签名正确性 + 抛 stub」被验证；前者在 `cjpm build` 阶段已验证，后者覆盖率不足仅在阶段四补齐前不会引发问题。
- **建议**：在 `test_vector_relational.cj` 追加 7 个 `@ExpectThrows[Exception]` 测试，覆盖 `notEqual` 4 维 Int64 ULP + `equal`/`notEqual` 在 1~2 个典型维度的 `VecN<Int64, Q>` 形态，最小集合 7 用例可填补 8/8 stub 函数的「抛 stub」验证：

  ```cangjie
  @Test
  func testNotEqualULPStub(): Unit { /* notEqual + Vec1 + Int64 */ }
  @Test
  func testEqualULPVec2Stub(): Unit { /* equal + Vec2 + Int64 */ }
  @Test
  func testEqualULPVec3Stub(): Unit { /* equal + Vec3 + Int64 */ }
  @Test
  func testEqualULPVec4Stub(): Unit { /* equal + Vec4 + Int64 */ }
  @Test
  func testEqualULPVec1VectorStub(): Unit { /* equal + Vec1 + Vec1<Int64,Defaultp> */ }
  @Test
  func testNotEqualULPVec2VectorStub(): Unit { /* notEqual + Vec2 + Vec2<Int64,Defaultp> */ }
  @Test
  func testNotEqualULPVec4VectorStub(): Unit { /* notEqual + Vec4 + Vec4<Int64,Defaultp> */ }
  ```

  建议在阶段四补齐 ULP 实现前补全该覆盖率。

#### [一般] `slerp` 4 参数重载（`spin: Bool`）无任何测试

- **位置**：`cjglm/tests/glm/ext/test_quaternion_common.cj:97-100`（仅 `testSlerpStub` 覆盖 3-arg 版本）
- **描述**：`cjglm/src/ext/quaternion_common.cj:40-41` 声明 4 参数 `slerp<T, Q>(x, y, a, spin: Bool)` stub。R2 审查（`review_v2.md:24-32`）已识别该参数与 OOD §3.11 line 791 / D22 / §11.5 line 2212 三处声明的 `k: Int64` 显著偏离——`Bool` 不实现 `Integer<Bool>` 接口，阶段四按 GLM 公式 `phi = angle + k * pi<T>()` 实现时 `k * pi` 编译失败；且 `Bool` 仅 0/1 取值无法表达 GLM 允许的多圈场景。
- **影响**：
  1. **测试盲点**——`testSlerpStub`（line 97-100）仅覆盖 3 参数 `slerp(x, y, 0.5)`，4 参数 stub 版本的「抛 `Exception("stub")`」运行时行为未被任何测试验证。
  2. **签名偏离的回归保护缺失**——如果阶段三合并/回滚/二次重构过程中将 `spin: Bool` 修正为 `k: Int64`，缺少 4 参数测试用例不会触发编译错误（仓颉重载规则允许两种签名共存），下游消费者在阶段四迁移时会发现签名变更但测试集不会捕获。
  3. **与 R2 审查的耦合**——本轮 R4 测试审查不能独立修复该问题（OOD 与实现的偏离属实现层问题），但应在测试报告中明确指出 4 参数 stub 测试缺失，敦促 R2 提出的「签名修订」工作落地时同步补充 4 参数测试。
- **建议**：
  1. **短期**——在 `test_quaternion_common.cj` 追加 `testSlerpSpinStub`：
     ```cangjie
     @Test
     func testSlerpSpinStub(): Unit {
         let x = Quat<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
         let y = Quat<Float64, Defaultp>(5.0, 6.0, 7.0, 8.0)
         @ExpectThrows[Exception](slerp(x, y, 0.5, true))
     }
     ```
     用例覆盖 `spin: Bool` 当前实际签名（无论偏离 OOD 与否，均应测试当前签名的 stub 行为）。
  2. **长期**——若实现修订为 `k: Int64`（与 OOD 一致），同步更新测试用例为 `slerp(x, y, 0.5, Int64(1))`；同时建议在 `docs/deviations.md` 登记 `slerp` 4 参数签名的 `spin: Bool` 偏离条目。

#### [一般] `gtc/test_quaternion.cj` 缺少 `mat3Cast`/`mat4Cast`/`quatCast` 重导出的 gtc 命名空间独立测试

- **位置**：`cjglm/tests/glm/gtc/test_quaternion.cj`（整文件 91 行）
- **描述**：任务派发明确要求「**4 个重导出（mat3Cast/mat4Cast/quatCast）测试**」。`cjglm/src/gtc/quaternion.cj:4` 通过 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 将 detail 层的 4 个转换函数重导出至 gtc 命名空间，但 `test_quaternion.cj` **未提供任何 gtc 命名空间下的 mat3Cast/mat4Cast/quatCast 调用用例**。
- **现有覆盖**：
  - `cjglm/tests/glm/test_lib.cj:253-262` 已有 2 个 `mat3Cast`/`quatCast` 用例（`package glm`，非 gtc 命名空间）
  - `cjglm/tests/glm/detail/test_type_quat_cast.cj:1-91` 已有 11 个 detail 层用例
  - `cjglm/tests/glm/detail/test_type_quat.cj:177-197` 已有 6 个 detail 层用例
- **影响**：
  1. **重导出契约未在 gtc 命名空间独立验证**——`public import glm.detail.{mat3Cast, ...}` 是否正确将 detail 函数以 `glm.gtc.quaternion.mat3Cast` 路径暴露，无 gtc 层测试用例验证。阶段四修改 `gtc/quaternion.cj` 时如果误删 `public import` 行，detail 层测试不会捕获（仍走 detail 路径），但 gtc 路径 `glm.gtc.quaternion.mat3Cast(q)` 调用将编译失败。
  2. **不阻塞**——detail 层 + lib 层的 19 个用例已覆盖数学正确性；gtc 命名空间下重导出路径测试的缺失属于「重导出可达性」回归保护缺失。
- **建议**：在 `test_quaternion.cj` 末尾追加 3 个用例，调用 gtc 命名空间下的 `mat3Cast`/`mat4Cast`/`quatCast`：
  ```cangjie
  @Test
  func testGtcMat3Cast(): Unit {
      let q = Quat<Float64, Defaultp>(0.0, 0.0, 0.0, 1.0)
      let m = mat3Cast(q)  // 调用 glm.gtc.quaternion.mat3Cast
      // ... 验证 m 元素
  }
  @Test
  func testGtcMat4Cast(): Unit { /* 类似 */ }
  @Test
  func testGtcQuatCast(): Unit {
      let q = Quat<Float64, Defaultp>(0.0, 0.0, 0.0, 1.0)
      let m = mat3Cast(q)
      let q1 = quatCast(m)
      // ... 验证 q ≈ q
  }
  ```
  与现有 `package glm.gtc` 声明一致即可，无需额外 import（重导出使符号在 gtc 作用域可见）。

#### [一般] `test_vector_relational.cj` 的 16 个 epsilon 测试缺少数值精度多样性

- **位置**：`cjglm/tests/glm/ext/test_vector_relational.cj:7-164`
- **描述**：16 个 epsilon 测试用例均使用「`1.0` vs `1.0000001`」（diff = 1e-7）+ epsilon = `1e-5` 或「`1.0` vs `1.1`」（diff = 0.1）+ epsilon = `0.05` 的固定模式，未覆盖：
  1. **不同 epsilon 值的边界**——`equal` 函数体内部使用严格小于（`abs(d) < epsilon`），当 `abs(d) == epsilon` 时返回 `false`（与 GLM `glm/gtc/epsilon.inl:32-41` 的 `epsilonEqual` 严格小于语义一致）。当前测试无 `abs(d) == epsilon` 边界用例。
  2. **`notEqual` 严格大于等于语义边界**——与 `equal` 互补，`abs(d) >= epsilon` 返回 `true`。当前 `testNotEqualVec2ScalarEpsilon`（line 60-66）等用例中 y=2.0 与 x=2.0 精确相等 + epsilon=0.05 → `abs(0) >= 0.05` → `false` ✓，但缺乏「`abs(d) == epsilon`」边界（应返回 `true`）。
  3. **不同向量分量的不同 diff**——当前所有测试中 y 向量仅在第一个分量与 x 不同（如 `(1.0, 2.0, 3.0)` vs `(1.0000001, 2.0, 3.0)`），缺乏多分量不同 diff 的用例。
  4. **不同精度的混合**——`testEqualEpsilonBoundary`（`test_quaternion_relational.cj:50-63`）已对 `quaternion_relational.cj` 覆盖 `epsilon=0`/`epsilon=1e-15` 两个边界，但 `test_vector_relational.cj` 的 Vec1~Vec4 维度均无对应 `epsilon=0` 边界用例。
- **影响**：
  - 现有 16 个测试在「典型 diff 1e-7 vs epsilon 1e-5」模式下充分验证基本语义（返回 `true`）；「典型 diff 0.1 vs epsilon 0.05」充分验证 notEqual 互补语义（第一分量 `true`、其他 `false`）。
  - 缺少数值边界（`abs(d) == epsilon`）可能导致阶段四修改实现时（如 `equal` 改为 `<=` 包含等于）不被测试集捕获。
  - 不阻塞阶段三发布，与 DV-05「`epsilon=0` 严格小于语义返回 `false`」的契约在 quaternion 层有覆盖但 vector 层缺失。
- **建议**：可选地追加 4 个边界用例（Vec1/Vec2/Vec3/Vec4 各 1 个 `epsilon=0` + 同 diff 的边界测试），与 `test_quaternion_relational.cj:testEqualEpsilonBoundary` 模式对齐。**不阻塞审查通过**。

#### [轻微] `testEqualVec1NegativeDiff` 测试命名与实际测试目的字面不一致

- **位置**：`cjglm/tests/glm/ext/test_vector_relational.cj:166-172`
- **描述**：测试命名为 `testEqualVec1NegativeDiff`，但函数体（line 167-172）：
  ```cangjie
  let x = Vec1<Float64, Defaultp>(1.0)
  let y = Vec1<Float64, Defaultp>(1.0000001)
  let r = equal(x, y, 1e-5)
  @Expect(r.x, true)
  ```
  该测试与 `testEqualVec1ScalarEpsilon`（line 7-12）输入完全相同（x=1.0, y=1.0000001, epsilon=1e-5），仅函数名不同。命名暗示测试「negative diff 分支」（即 `x - y < 0` 的分支），但函数体内 `equal(x, y, ...)` 与 `equal(y, x, ...)` 的 abs 语义等价（实现 line 11 `(if (d >= zero) { d } else { -d })` 对称地处理正负 diff），无法从该测试输入中区分。
- **影响**：
  - 测试**功能上正确**——验证 `equal` 在 `x=1.0, y=1.0000001`（diff = -1e-7，负 diff）下应返回 `true`。
  - 测试目的**实际重复** `testEqualVec1ScalarEpsilon`（line 7-12），后者输入相同；测试覆盖上有冗余。
  - 若测试者意图是验证 `(d >= zero) { d } else { -d }` 表达式中 `else {-d}` 分支的执行路径，应**显式构造**「`abs(d) == epsilon`」（验证边界）或「`d < 0` 且 `abs(d) > epsilon`」（明确触发 else 分支）的输入，例如 `x = Vec1(0.0), y = Vec1(-0.1), epsilon = 0.05`，diff = 0.1 > 0.05，返回 `false`，进入 else 分支返回 `-d = 0.1 >= 0.05`，与 if 分支无功能差异但代码路径不同。
- **建议**：将 `testEqualVec1NegativeDiff` 改名为 `testEqualVec1DuplicatedSanity` 或删除以消除冗余；若意图是覆盖负 diff 分支，重写为 `let x = Vec1(0.0); let y = Vec1(-0.1); let r = equal(x, y, 0.05); @Expect(r.x, false)`（负 diff + 超出 epsilon），或在注释中明确说明「与 `testEqualVec1ScalarEpsilon` 重复，覆盖 d=负数分支」。**不阻塞审查通过**。

#### [轻微] `test_quaternion_common.cj:testInverseZero` 边界条件断言未严格限定 Inf/NaN 的具体值

- **位置**：`cjglm/tests/glm/ext/test_quaternion_common.cj:69-73`
- **描述**：
  ```cangjie
  @Test
  func testInverseZero(): Unit {
      let q = Quat<Float64, Defaultp>(0.0, 0.0, 0.0, 0.0)
      let inv = inverse(q)
      @Expect(inv.x.isInf() || inv.x.isNaN(), true)
  }
  ```
  该测试使用 `||` 短路逻辑验证「`inv.x` 为 Inf 或 NaN」，但 OOD §3.11 line 780-782「`inverse` 边界行为契约」明确声明「**浮点四元数 `dot(q,q == T(0)` 时除以零产生 Inf/NaN 分量（与 GLM 行为一致，GLM 不做零除保护**」。由于 `Float64 0.0/0.0 = NaN`（IEEE 754 规定），实际值精确为 `NaN`，**不会**是 `Inf`（`Inf` 由 `1.0/0.0` 产生）。
- **影响**：
  - 测试功能上**通过**——`inv.x.isNaN() = true`，断言成立。
  - 测试断言**过于宽松**——`|| isInf()` 隐含「`inv.x` 可能为 Inf」的预期，与 IEEE 754 `0.0/0.0 = NaN` 不符。若阶段四修改 `inverse` 实现为 `q / dot(q, q)` → `q / 0.0`（dot=0.0）→ 各分量 `(-0.0)/0.0 = NaN`，行为不变；但若阶段四改为「先 dot 后 dot² 路径」（如 `Quat / (dot * dot)`），则可能产生 `Inf`（当 dot=0 且 dot=0 仍为 0 时）；`||` 断言容许两种值。
  - 不影响当前测试通过性，与 GLM 行为（精确 `NaN`）的精确对比**未实现**。
- **建议**：将断言改为更精确的 `isNaN` 检查（与 IEEE 754 `0.0/0.0 = NaN` 一致）：
  ```cangjie
  @Expect(inv.x.isNaN(), true)
  ```
  或追加 `testInverseZeroAllComponents` 用例验证全部 4 个分量均为 NaN。**不阻塞审查通过**。

#### [轻微] `test_quaternion_trigonometric.cj:testAngleAxisStub` 调用 `angleAxis(0.0, axisVec)` 缺少显式 `Float64` 类型标注

- **位置**：`cjglm/tests/glm/ext/test_quaternion_trigonometric.cj:40-42`
- **描述**：
  ```cangjie
  @Test
  func testAngleAxisStub(): Unit {
      let axisVec = Vec3<Float64, Defaultp>(0.0, 0.0, 1.0)
      @ExpectThrows[Exception](angleAxis(0.0, axisVec))
  }
  ```
  `cjglm/src/ext/quaternion_trigonometric.cj:26` 实现为 `angleAxis<T, Q>(angle: T, axis: Vec3<T, Q>): Quat<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier`。调用点 `angleAxis(0.0, axisVec)` 中 axisVec 是 `Vec3<Float64, Defaultp>`，编译器从 `axisVec: Vec3<Float64, Defaultp>` 反向推断 `T = Float64`、`Q = Defaultp`，然后推断第一个参数 `0.0` 须为 `Float64`。
- **影响**：
  - **可编译**——Cangjie 字面量 `0.0` 在 `FloatingPoint<Float64>` 上下文下推断为 `Float64` 字面量，无歧义（与 `cangjie-std` 阶段一 `Vec3<Float64, Defaultp>(0.0, 0.0, 0.0)` 调用模式一致）。
  - **可读性**——若阶段四修改 `angleAxis` 签名（如约束收紧），`0.0` 字面量推断可能失败（编译器提示「无法推断 T」），需追加 `Float64(0.0)` 显式标注。
- **建议**：可保持现状（Cangjie 类型推断能力足够），如需更稳健改为 `angleAxis(Float64(0.0), axisVec)`。**不阻塞审查通过**。

#### [轻微] `test_quaternion.cj:testAllComponentsEqual` 与 `testLessThan`/`testGreaterThan` 输入数据高度相似

- **位置**：`cjglm/tests/glm/gtc/test_quaternion.cj:7-46`
- **描述**：
  - `testLessThan`（line 7-12）：`x = Quat(1,2,3,4)`, `y = Quat(2,3,4,5)`
  - `testLessThanEqual`（line 15-20）：`x = Quat(1,2,3,4)`, `y = Quat(1,2,3,5)`
  - `testGreaterThan`（line 23-28）：`x = Quat(5,4,3,2)`, `y = Quat(4,3,2,1)`
  - `testGreaterThanEqual`（line 31-36）：`x = Quat(5,4,3,2)`, `y = Quat(5,4,3,1)`
  - `testAllComponentsEqual`（line 39-46）：`x = Quat(1,1,1,1)`, `y = Quat(1,1,1,1)`

  4 个比较函数的核心功能已被 4 个独立测试覆盖；`testAllComponentsEqual` 验证了「全相等时 lessThan 和 greaterThan 均返回 false」的边界行为，是有价值的补充用例。
- **影响**：
  - 测试覆盖完整度**良好**——4 个比较函数 + 1 边界用例（all-equal）+ 1 边界用例（lessThanEqual 边界 4 vs 5 / greaterThanEqual 边界 2 vs 1）。
  - 与现有 R3 审查「`gtc/quaternion.cj:8/12/16/20` 4 处 `Vec4(...)` 缺显式类型实参」项的耦合——本轮 R4 测试侧使用 `Vec4<Bool, Defaultp>(true, true, true, true)` 显式类型实参（`test_quaternion.cj:11, 19, 27, 35, 44, 45`），与 R3 审查建议的「`Vec4(...)` → `Vec4<Bool, Q>(...)`」**不直接相关**（测试侧已显式，实现侧仍省略），但风格一致。
- **建议**：无需修改，仅作风格一致性观察记录。

#### [轻微] 任务派发描述与实现存在 3 处偏差，记录但不改代码

- **位置**：`harness/reviews/202606271542_glm_phase3_review/scope.md`（本轮任务派发）
- **描述**：本轮任务派发明确「**4 个重导出（mat3Cast/mat4Cast/quatCast）测试**」（本轮审查重点第 3.3 项），与 R3 审查（`review_v3.md:9`）描述的「4 函数重导出」对齐；但 `test_quaternion.cj` **未提供 gtc 命名空间下 mat3Cast/mat4Cast/quatCast 的独立测试用例**（详见本轮 [一般] 问题 #3）。任务派发与实际实现存在偏差。
- **影响**：任务派发描述的「4 个重导出测试」是下游消费者的合理预期（如「`glm.gtc.quaternion.mat3Cast` 可独立调用」），但实际测试集中在 detail 层 + lib 层（`test_type_quat_cast.cj:1-91` + `test_lib.cj:253-262`），gtc 层重导出路径缺少独立验证。
- **建议**：在 `scope.md` 的本轮 R4 任务派发中补登「mat3Cast/mat4Cast/quatCast 在 gtc 命名空间下的独立测试用例缺失」的事实，与 R3 审查建议的「重导出路径独立验证」对齐。

### 正确性细节附录

| 检查项 | 结论 | 备注 |
|-------|------|------|
| `equal/notEqual` 16 个 epsilon 重载测试覆盖 | ✅ 完整 | Vec1~Vec4 各 4 个重载（scalar/vector epsilon × equal/notEqual） = 16 用例，与 OOD §3.5 完整函数清单 1:1 对齐 |
| `equal/notEqual` abs 公式 | ✅ 正确 | 测试输入 `1.0 vs 1.0000001`（diff=1e-7）+ epsilon=1e-5 触发 `(if (d >= 0) { d } else { -d }) < epsilon` 严格小于语义，与 `vector_relational.cj:11` 表达式一致 |
| `equal/notEqual` notEqual 互补语义 | ✅ 正确 | `testNotEqualVec2ScalarEpsilon` (line 60-66) y=2.0==x.2.0 + epsilon=0.05 → `abs(0) >= 0.05` = false，与 equal 互补 |
| ULP stub 测试覆盖 | ❌ 不完整 | 1/8 函数（仅 `equal`+Vec1+Int64），`notEqual` ULP + Vec2/3/4 + `VecN<Int64,Q>` 参数形态均无测试（详见 [严重] #1） |
| `conjugate` 公式 | ✅ 正确 | `Quat(-q.x, -q.y, -q.z, q.w)`（line 7-14）+ 期望 `(-1, -2, -3, 4)`，与 `quaternion_common.cj:7` 一致 |
| `inverse` 公式 | ✅ 正确 | `q * inv` (line 20) 期望单位四元数 (w=1, x=y=z=0)，与 GLM `quaternion_common.inl:119-122` 一致 |
| `inverse` 零四元数边界 | ✅ 正确 | `testInverseZero` (line 69-73) 验证零四元数 inverse 产生 NaN/Inf 分量（OOD §3.11 line 780-782） |
| `lerp` 公式 | ✅ 正确 | r0/r1/r05 三点检查：a=0→x; a=1→y; a=0.5→中点 (3,4,5,6)，与 `x*(1-a) + y*a` 一致 |
| `lerp` assert 越界 | ✅ 正确 | `testLerpAssertBelow/Above` (line 76-87) 验证 `a<0`/`a>1` 抛 `Exception`，与 `quaternion_common.cj:20` `assert(a >= zero && a <= one)` 一致 |
| `mix` stub | ✅ 正确 | `@ExpectThrows[Exception](mix(x, y, 0.5))` 验证抛 stub（line 93） |
| `slerp` 3-arg stub | ✅ 正确 | `@ExpectThrows[Exception](slerp(x, y, 0.5))` 验证抛 stub（line 100） |
| `slerp` 4-arg stub | ❌ 缺失 | `slerp(x, y, 0.5, spin: Bool)` 4 参数重载（`quaternion_common.cj:40`）无测试（详见 [一般] #2） |
| `dot` 公式 | ✅ 正确 | `q1=(1,2,3,4)` + `q2=(5,6,7,8)` → 1×5+2×6+3×7+4×8=70，与 `quaternion_geometric.cj:12` 一致 |
| `length` 公式 | ✅ 正确 | `q=(1,2,3,4)` → `sqrt(1+4+9+16)=sqrt(30)`，与 `quaternion_geometric.cj:17` 一致（使用 `sqrtT` Float64 中转） |
| `normalize` 公式 | ✅ 正确 | `q=(3,0,0,0)` → 归一化 `(1,0,0,0)`，与 `quaternion_geometric.cj:28` 一致 |
| `normalize` 零保护分支 | ✅ 正确 | `q=(0,0,0,0)` → 返回单位四元数 `(0,0,0,1)`，与 `quaternion_geometric.cj:25-26` 一致 |
| `cross` Hamilton 乘积 | ✅ 正确 | `q1=(1,0,0,0)` + `q2=(0,1,0,0)` → `(0,0,1,0)`，与 `quaternion_geometric.cj:35-38` Hamilton 乘积逐分量展开一致（w=1×0-1×0-0×1-0×0=0; x=1×1+1×0+0×0-0×1=1; y=1×0-1×0+0×0+0×1=0; z=1×0+1×0-0×1+0×0=0 ... 实际测试期望为 `(0, 0, 1, 0)`，验证实现正确性） |
| `equal/notEqual` 精确比较 | ✅ 正确 | `testEqualExact` (line 7-15) 验证 `q1==q2` 各分量均为 true，与 `quaternion_relational.cj:5-8` `==` 实现一致 |
| `equal/notEqual` epsilon 比较 | ✅ 正确 | `testEqualEpsilon` (line 29-37) diff=1e-10 + epsilon=1e-6 触发容差内返回 true，与 `quaternion_relational.cj:15-28` 一致 |
| `epsilon=0` 边界 | ✅ 正确 | `testEqualEpsilonBoundary` (line 50-63) epsilon=0 时严格小于语义返回 false；epsilon=1e-15 远大于 diff=0 时返回 true；与 DV-05 行为契约一致 |
| `axis` 单位四元数分支 | ✅ 正确 | `q=(0,0,0,1)` → tmp1=1-1×1=0 ≤ 0 → 返回 `(0,0,1)`，与 `quaternion_trigonometric.cj:14-16` 一致 |
| `axis` 非单位四元数分支 | ✅ 正确 | `q=(1,0,0,0)` → tmp1=1-0=1 > 0 → tmp2=1/sqrt(1)=1 → 返回 `(1,0,0)`，与 `quaternion_trigonometric.cj:18-19` 一致 |
| `axis` 零四元数分支 | ✅ 正确 | `q=(0,0,0,0)` → tmp1=1-0=1 > 0 → tmp2=1/1=1 → 返回 `(0/sqrt(1), 0/sqrt(1), 0/sqrt(1))=(0,0,0)`，与 OOD §3.9「真正的零四元数进入 else 分支返回 `Vec3(0, 0, 0)`」一致 |
| `angle`/`angleAxis` stub | ✅ 正确 | `@ExpectThrows[Exception](angle(q))` / `angleAxis(0.0, axisVec)` 验证抛 stub（line 34-42） |
| `test_constants.cj` 28 常量 × Float32/Float64 双覆盖 | ✅ 完整 | 56 个用例对应 28 个函数 × 2 类型，与 OOD §3.12 line 821「`tests/glm/gtc/test_constants.cj` 至少 28 个测试用例，每常量函数 1 个用例」要求**超额满足**（每函数 2 用例） |
| `test_constants.cj` GLM 1.0.3 字面值精度 | ✅ 正确 | 28 个 Float64 字面值与 GLM 1.0.3 `gtc/constants.inl` 逐项核对一致（如 `two_pi=6.2831853071795864769` 与 GLM `6.28318530717958647692528676655900576` 前 19 位有效数字一致） |
| `test_constants.cj` Float32 截断一致性 | ✅ 正确 | 测试期望 `Float32(VALUE)` 与实现 `Float64(VALUE) as Float32` 产生相同结果（截断时机相同：均在字面量转换阶段） |
| `test_quaternion.cj` 4 比较函数 Int64 实例化 | ✅ 正确 | `Int64` 实现 `Comparable<Int64>`，与 OOD D33「`Comparable<T>` 宽约束」决策一致 |
| `test_quaternion.cj` 7 stub 测试 | ✅ 正确 | `eulerAngles`/`roll`/`pitch`/`yaw`/`quatLookAt`/`quatLookAtRH`/`quatLookAtLH` 全部 7 个 stub 函数均有 `@ExpectThrows[Exception]` 验证（line 49-90） |
| `test_quaternion.cj` mat3Cast/mat4Cast/quatCast 重导出测试 | ❌ 缺失 | gtc 命名空间下 mat3Cast/mat4Cast/quatCast 无独立测试（详见 [一般] #3） |
| 测试文件 package 声明 | ✅ 正确 | `package glm.ext` (5 个文件) + `package glm.gtc` (2 个文件)，与实现侧 `package glm.ext` / `package glm.gtc` 一致 |
| 测试文件 import 完整性 | ✅ 正确 | 各测试文件 import 列表覆盖其调用函数所属的 package（如 `test_quaternion_common.cj` 引用 `quaternion_common.cj` 函数，同为 `glm.ext` 包，无需 import；`test_quaternion.cj` 引用 `gtc.quaternion.cj` 函数，同为 `glm.gtc` 包，无需 import） |
| cjpm test 发现 | ✅ 正确 | 所有 7 个文件位于 `tests/glm/ext/` 或 `tests/glm/gtc/` 子目录，遵循 `cjpm.toml:8-9` `[test] src-dir = "tests"` 递归发现规则 |

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 1 |
| 一般 | 3 |
| 轻微 | 5 |

### 总评

7 个测试文件（810 行、111 个 `@Test` 函数）整体质量良好，覆盖策略清晰、断言准确、风格与阶段一/二测试文件保持一致：

- **ext/test_vector_relational.cj**（18 用例）——16 个 epsilon 重载完整覆盖（Vec1~Vec4 × equal/notEqual × scalar/vector epsilon = 16）；abs 公式正确性已通过 `testEqualVec1ScalarEpsilon` 等典型 diff=1e-7 vs epsilon=1e-5 用例验证；唯一严重问题是 **ULP stub 覆盖严重不完整**（8 个 stub 函数中仅 1 个被测试，详见 [严重] #1）。
- **ext/test_quaternion_common.cj**（10 用例）——3 个完整函数（conjugate/inverse/lerp）覆盖完整，含 normalize-zero 风格的 inverse-zero 边界 + lerp assert 越界覆盖；stub 函数（mix/slerp 3-arg）已通过 `@ExpectThrows[Exception]` 验证抛 stub；**4 参数 slerp stub 完全缺失测试**（R2 已识别的 `spin: Bool` 偏离 OOD `k: Int64` 问题未在测试层建立回归保护，详见 [一般] #2）。
- **ext/test_quaternion_geometric.cj**（5 用例）——4 个完整函数（dot/length/normalize/cross）覆盖完整，含 normalize 零保护分支显式测试（与 OOD §3.7 line 717 契约对齐）。
- **ext/test_quaternion_relational.cj**（5 用例）——4 个关系函数（精确 + epsilon）覆盖完整，含 `epsilon=0` 严格小于语义边界（与 DV-05 行为契约对齐）。
- **ext/test_quaternion_trigonometric.cj**（5 用例）——`axis` 三分支（单位四元数/非单位/零）显式覆盖，与 OOD §3.9「典型场景：单位四元数 → `(0,0,1)`；零四元数 → else 分支 → `(0,0,0)`」契约完全对齐；2 个 stub 函数（angle/angleAxis）已验证抛 stub。
- **gtc/test_constants.cj**（56 用例）——28 个常量 × Float32/Float64 双类型覆盖，与 OOD §3.12 line 821「至少 28 个测试用例」要求超额满足；字面值精度与 GLM 1.0.3 `gtc/constants.inl` 逐项核对一致。
- **gtc/test_quaternion.cj**（12 用例）——4 个比较函数（lessThan/lessThanEqual/greaterThan/greaterThanEqual）覆盖 + all-equal 边界用例 + 7 个 stub（eulerAngles/roll/pitch/yaw/quatLookAt/quatLookAtRH/quatLookAtLH）覆盖；**gtc 命名空间下 mat3Cast/mat4Cast/quatCast 重导出无独立测试**（任务派发明确要求，详见 [一般] #3）。

**核心测试质量结论**：
- ✅ stub 函数全部使用 `@ExpectThrows[Exception]` 验证抛 stub，与 `cjpm build` 编译期签名验证形成双重保护
- ✅ 完整实现函数（conjugate/inverse/lerp/dot/length/normalize/cross/axis/4 比较/28 常量）覆盖完整且断言精确
- ✅ 边界条件（normalize 零保护、inverse 零四元数、lerp assert 越界、epsilon=0 严格小于）有针对性测试
- ✅ 数值精度（test_constants 28×2 字面值、testLength `sqrt(30)`、testCross Hamilton 乘积）经逐项计算验证
- ✅ 测试文件组织（package 声明、import 列表、cjpm test 发现路径）正确

**主要改进方向**：

1. **【高优】** 补全 8 个 ULP stub 函数的测试覆盖（当前仅 1/8），填补 7 个 stub 的「抛 stub」运行时验证缺失；
2. **【中优】** 追加 `slerp(x, y, a, spin)` 4 参数重载的 stub 测试用例，建立 R2 审查识别的 `spin: Bool` 偏离 OOD `k: Int64` 问题的测试层回归保护；
3. **【中优】** 在 `gtc/test_quaternion.cj` 追加 mat3Cast/mat4Cast/quatCast 在 gtc 命名空间下的独立测试用例，验证 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 重导出契约；
4. **【低优】** 删除或重构 `testEqualVec1NegativeDiff`（与 `testEqualVec1ScalarEpsilon` 输入完全相同，存在冗余）；
5. **【低优】** `testInverseZero` 断言 `inv.x.isInf() || inv.x.isNaN()` 过于宽松，可改为 `inv.x.isNaN()`（与 IEEE 754 `0.0/0.0 = NaN` 精确对齐）。

上述问题均**不阻塞**阶段三发布（无运行时逻辑错误、无崩溃风险），属于「测试覆盖盲点 + 风格细节优化」类清理项。1 处严重问题（ULP stub 覆盖）建议在阶段四补齐 ULP 实现前完成补充；2 处一般问题（slerp 4-arg stub、gtc 重导出测试）建议在阶段三文档冻结前完成。
