# R4-Agent1: 审查 `cjglm/tests/glm/detail/` 阶段三新增测试文件

审查时间：2026-06-27

## 审查范围

| 文件 | 行数 | @Test 数 | OOD §8.2 计划位置 |
|------|-----|---------|----------------|
| `cjglm/tests/glm/detail/test_type_quat.cj` | 272 | 30 | `tests/glm/detail/test_type_quat.cj` ≥40 |
| `cjglm/tests/glm/detail/test_type_quat_cast.cj` | 93 | 8 | `tests/glm/detail/test_type_quat_cast.cj` ≥8 |
| `cjglm/tests/glm/detail/test_scalar_constants.cj` | 41 | 8 | 未在 OOD §8.2 计划表列出（仅计划 ext 版） |
| `cjglm/tests/glm/detail/test_scalar_quat_ops.cj` | 89 | 9 | 未在 OOD §8.2 计划表列出（并入 test_type_quat.cj） |
| `cjglm/tests/glm/detail/test_trigonometric_stub.cj` | 81 | 16 | 未在 OOD §8.2 计划表列出（OOD §8.2 §9 抽样策略允许） |

参考依据：
- `docs/05_ood_phase3.md` §8.2 测试文件清单与用例分配 / §8 编码启动前验证项 17/25 / §11.5 函数可用性对照表
- `cjpm.toml:8-9`：`[test] src-dir = "tests"`，cjpm test 实际发现路径实测
- 阶段二既有约定：`*_test.cj` 文件位于 `src/<pkg>/` 同包目录（如 `src/detail/type_vec2_test.cj`）
- R1-Agent2 已识别的「`test_type_quat_cast.cj` 未被 cjpm test 发现」严重问题

## 发现

### [严重] 全部 5 个测试文件均未被 cjpm test 发现/执行——71 个 @Test 函数被静默跳过

- **位置**：
  - `cjglm/tests/glm/detail/test_type_quat.cj:1-272`（30 @Test）
  - `cjglm/tests/glm/detail/test_type_quat_cast.cj:1-93`（8 @Test）
  - `cjglm/tests/glm/detail/test_scalar_constants.cj:1-41`（8 @Test）
  - `cjglm/tests/glm/detail/test_scalar_quat_ops.cj:1-89`（9 @Test）
  - `cjglm/tests/glm/detail/test_trigonometric_stub.cj:1-81`（16 @Test）
- **描述**：本轮审查通过 `cjpm test --dry-run` 实测验证：
  1. 实测执行 `cjpm test --dry-run`，cjpm 仅发现 422 个测试用例（`TestCase_test*`），使用 `sed 's/\x1b\[[0-9;]*m//g'` 去除 ANSI 颜色码后用 `grep -iE "quat"` 过滤——**返回 0 行**。
  2. 单独 grep `TestCase_testQuat|TestCase_testEpsilonFloat|TestCase_testPi|TestCase_testScalarAddQuat|TestCase_testSinScalar|TestCase_testCosScalar|TestCase_testTanScalar|TestCase_testAsinScalar|TestCase_testAcosScalar|TestCase_testAtanScalar|TestCase_testAtan2Scalar|TestCase_testRadiansScalar|TestCase_testDegreesScalar|TestCase_testSinhScalar|TestCase_testCoshScalar|TestCase_testTanhScalar|TestCase_testAsinhScalar|TestCase_testAcoshScalar|TestCase_testAtanhScalar` 等关键字——同样**返回 0 行**。
  3. 进一步 `find cjglm -name "*_test.cj"` 实测确认——cjpm test 实际仅识别 `src/` 目录下 `*_test.cj` 后缀文件（阶段二 13 个 `_test.cj` 文件均在 `src/detail/` 等子包目录下），完全不识别 `tests/` 子目录下的 `test_*.cj` 前缀文件。
  4. `cjpm.toml:8-9` 虽配置 `[test] src-dir = "tests"`，但 cjpm 1.1.0 实际不读取该字段或仅用于 `cjpm bench`，不影响 `cjpm test` 的发现逻辑（阶段二同样配置但实际未依赖该字段）。

  **直接影响**：
  - R1-Agent2 报告的「`test_type_quat_cast.cj` 未被 cjpm test 发现」**严重问题未修复**——该 8 个测试用例在 CI 中**仍然不运行**；
  - `test_type_quat.cj` 的 30 个测试用例全部静默跳过，导致 OOD §8.2 §11.5 中承诺的「≥40 用例」覆盖实际为 0；
  - `test_trigonometric_stub.cj` 的 16 个 stub 异常路径测试不运行，无法保证 `detail/trigonometric.cj` 的 75 个 stub 函数签名在 cjpm build 中被验证（OOD §8.2 第 9 项「编译期函数签名正确性验证」要求）；
  - 跨 5 个文件共计 71 个 `@Test` 函数被静默跳过，**阶段三测试覆盖度实质为零**，所有测试用例仅作为源码存档存在。
- **建议**：
  1. **核心修复**——将 5 个测试文件整体迁移到 `src/detail/` 目录下并按阶段二既有约定改名为 `*_test.cj`：
     - `tests/glm/detail/test_type_quat.cj` → `src/detail/type_quat_test.cj`
     - `tests/glm/detail/test_type_quat_cast.cj` → `src/detail/type_quat_cast_test.cj`
     - `tests/glm/detail/test_scalar_constants.cj` → `src/detail/scalar_constants_test.cj`
     - `tests/glm/detail/test_scalar_quat_ops.cj` → `src/detail/scalar_quat_ops_test.cj`
     - `tests/glm/detail/test_trigonometric_stub.cj` → `src/detail/trigonometric_stub_test.cj`（与 `src/detail/matrix.cj:171-173` 等既有 stub 命名风格对齐）
  2. 迁移后保留 `package glm.detail`（已具备）和必要 import，遵循阶段二 `src/detail/type_vec3_test.cj` 等模板。
  3. **优先级 P0**——本问题必须在阶段四启动前彻底修复，否则所有测试覆盖率指标（OOD §11.5「≥2 用例/函数」）均为虚假报告。

---

### [严重] `test_type_quat_cast.cj` 仅依赖 round-trip 测试——无法捕获 R1-Agent2 报告的 quatCast 因子 2 缩放算法 bug

- **位置**：`cjglm/tests/glm/detail/test_type_quat_cast.cj:18-25`、`tests/glm/detail/test_type_quat_cast.cj:46-53`、`tests/glm/detail/test_type_quat_cast.cj:77-84`、`tests/glm/detail/test_type_quat_cast.cj:86-93`
- **描述**：8 个测试用例中 7 个采用 round-trip 形式 `mat3Cast(quatCast(M)) == M` 或 `mat4Cast(quatCast(M)) == M`，仅 `testMat3CastIdentityQuat`（行 4-16）和 `testMat4CastIdentityQuat`（行 27-44）使用了**逐元素**直接验证。但这 7 个 round-trip 测试**无法捕获** R1-Agent2 在 `review_v1_r2.md` 报告中识别的 quatCast 因子 2 缩放 bug（`cjglm/src/detail/type_quat_cast.cj:51-110`）——该 bug 的特征是 quatCast 返回的 4 个分量整体被错误放大 ~2 倍，但 round-trip 中 `mat3Cast(quatCast(M))` 仍可能内部一致地返回 `M`（取决于具体数值），导致 bug 在 CI 中长期不被捕获。
  
  具体反例：取 `q0 = (0.2, 0.3, 0.4, 0.8)`，`m = mat3Cast(q0)`，`q1 = quatCast(m)`，如果 quatCast 返回 `(0.38, 0.57, 0.76, 0.84)`（约为 q0 的 1.9 倍，符合 R1-Agent2 报告的因子 2 缩放 bug），则 `mat3Cast(q1)` 由于 `length²=1` 不再保持（与 q0 不等长），结果矩阵 `m2` 与 `m` 存在 ~10% 偏差。OOD §8.2「§11.5 浮点比较策略」段明确推荐「**type_quat_cast 单元测试**——使用「旋转矩阵 * 向量 = 四元数 * 向量」等价性测试（`m3 * v == q * v`）验证互转正确性」，但 8 个用例中**无一条**采用该等价性测试。

  当前测试文件存在的 7 个 round-trip 用例中：
  - `testQuatCastMat3RoundTrip`（行 18-25）—— 单位四元数 round-trip
  - `testQuatCastMat4RoundTrip`（行 46-53）—— 单位四元数 round-trip
  - `testMat3CastNonIdentityQuat`（行 56-62）—— 非单位四元数 round-trip
  - `testMat4CastNonIdentityQuat`（行 64-75）—— 非单位四元数 round-trip（仅直接验证 mat4Cast 元素）
  - `testQuatCastNonIdentityMat3RoundTrip`（行 77-84）—— 非单位四元数 round-trip
  - `testQuatCastNonIdentityMat4RoundTrip`（行 86-93）—— 非单位四元数 round-trip

  这些测试与 OOD §8.2「**用例分配原则**——完整实现函数——每函数 ≥2 个用例（覆盖正常路径 + 边界场景）」存在偏差——本应是「正常路径 + 边界场景」两点用例，实际全部退化为「round-trip」单点用例。
- **建议**：
  1. **补充数值精确度测试用例**——参照 R1-Agent2 `review_v1_r2.md` 第 58-61 行建议：
     - 已知旋转的四元数（如 90° X 轴：`q = (sqrt(2)/2, 0, 0, sqrt(2)/2)`）→ 矩阵 → 四元数 → 矩阵，逐元素比较；
     - 30°/45°/90°/180° 各轴的旋转四元数；
     - 浮点零矩阵输入（`m = Mat3x3(zeros)`）应返回 `(0, 0, 0, 1)` 单位四元数（验证 trace = 0 退化路径下的行为）；
     - 等价性测试：`m3 * v == q * v`（如 R1-Agent2 建议的 OOD §8.2「浮点比较策略」段方法）；
     - 直接对比：`quatCast(mat3Cast(q))` 的 4 个分量应与 `q` 的 4 个分量在 `epsilon<Float64>()` 容差内相等。
  2. **优先级 P0**——结合上一条 cjpm 发现路径问题，本文件的 8 个测试用例若能被 cjpm 发现但仅靠 round-trip，仍然无法捕获 R1-Agent2 已识别的严重算法 bug。建议两条问题同步修复。

---

### [一般] `test_type_quat.cj` 用例数 30 显著低于 OOD §8.2 计划 ≥40 下限——缺失 10+ 个用例

- **位置**：`cjglm/tests/glm/detail/test_type_quat.cj:1-272`
- **描述**：OOD §8.2「测试文件清单与位置」段明确列出 `tests/glm/detail/test_type_quat.cj | Quat 核心类型 + 运算符 | ≥40`，并在「用例分配原则」段给出「完整实现函数——每函数 ≥2 个用例」「stub 函数——每函数 ≥1 个用例」原则。当前文件仅含 30 个 `@Test` 函数，距 ≥40 下限**短缺 10+ 用例**。逐项缺口对照：

  | OOD §8.2 函数分组 | 函数数 | 每函数用例 | OOD 要求 | 文件实际 | 缺口 |
  |------------------|-------|----------|---------|---------|------|
  | 构造函数（8 个完整实现：主构造、s+v 构造、wxyz、fromQual、fromQuat、identity、fromMat3、fromMat4） | 8 | 2 | 16 | 9（testQuatConstruct / testQuatScalarVecConstruct / testQuatFromQual / testQuatWxyz / testQuatFromQuat / testQuatIdentity / testQuatFromMat3RoundTrip / testQuatFromMat4RoundTrip / testQuatFromMat3NonIdentityRoundTrip） | -7 |
  | 运算符算术（`+`/`-`/`*`/`/`/一元 `-`，5 个） | 5 | 2 | 10 | 5（testQuatAdd / testQuatSub / testQuatMul / testQuatDiv / testQuatNeg） | -5 |
  | 运算符 `==`/`!=`（2 个） | 2 | 1 | 2 | 4（含 testQuatBoolEq / testQuatBoolNeq） | +2 ✓ |
  | Quat×Vec3/Vec4（2 个 ⚠️） | 2 | 2（1 编译 + 1 assertThrows） | 4 | 2（testQuatVec3Stub / testQuatVec4Stub） | -2 |
  | Vec3×Quat/Vec4×Quat（2 个 ⚠️） | 2 | 2（1 编译 + 1 assertThrows） | 4 | 2（testVec3QuatStub / testVec4QuatStub） | -2 |
  | Quat×T / T×Quat / Quat / T / scalar_quat_ops（6 个） | 6 | 1 | 6 | 2（testQuatMulScalar / testQuatDivScalar） | -4 |
  | **小计** | **27 函数** | — | **42** | **30** | **-12** |

  主要缺口：
  1. **缺少 fromVec3/fromEuler stub 测试**——OOD §8.2 函数分组表中明确列出「fromVec3/fromEuler（2 个 stub | 2 | 1 | 2」，但 `test_type_quat.cj` 中**完全没有**对应 `testQuatFromVec3Stub` / `testQuatFromEulerStub` 用例。然而需注意——`type_quat.cj` 实际**未声明** `fromVec3`/`fromEuler` 公共函数（`grep "fromVec3\|fromEuler" cjglm/src/detail/type_quat.cj` 仅返回 §11.5 引用），OOD §8.2 计划基于阶段三原设计意图列出但与实际实现存在偏差——此条目应转写为「**与实际实现对齐**——确认 `type_quat.cj` 无 fromVec3/fromEuler 公共函数，更新 OOD §11.5 stub 列表」。
  2. **缺少每个完整实现函数的第 2 个用例**——例如 testQuatAdd 仅测试 `(1,2,3,4)+(5,6,7,8)`，未测试加零四元数、加单位四元数边界、Float64 类型变体、跨 Qualifier 实例化等场景，与 OOD §8.2「完整实现 ≥2 用例/函数」要求不符。
  3. **Quat×Vec3/Vec4/Vec3×Quat/Vec4×Quat 仅有运行时 assertThrows 验证，缺编译期引用测试**——OOD §8.2 第 8 项要求「每函数 ≥1 个编译期测试（验证 cjpm build 通过）+ ≥1 个运行时 assertThrows 测试」，4 个测试用例（testQuatVec3Stub / testQuatVec4Stub / testVec3QuatStub / testVec4QuatStub）均合并为单条 `@ExpectThrows[Exception](q * v)` 形式，未拆分为「先做编译期类型检查 + 再做 assertThrows」两步。
  4. **Quat×T 与 T×Quat 缺 add/sub 测试**——文件仅测试了 `q * scalar`（testQuatMulScalar）和 `q / scalar`（testQuatDivScalar），缺失 `q + scalar` / `q - scalar` 运算符（虽然 OOD §1 决策 D8 标记标量-四元数运算因运算符重载规则采用全局函数而非成员运算符，但 `type_quat.cj:130-137` 实际仍声明了 `*(rhs: T)` 和 `/(rhs: T)` 成员运算符），也缺失 T×Quat 反向（`*= scalar`、`+= scalar` 等复合赋值）测试。
- **建议**：
  1. **优先补齐缺失的 stub 测试**——按 OOD §8.2 分配表新增 `testQuatFromVec3Stub` / `testQuatFromEulerStub` 用例（前提是 `type_quat.cj` 先补齐这两个 stub 函数；如确认阶段三不实现，则同步修订 OOD §8.2 函数分组表）。
  2. **完整实现函数补齐第 2 个用例**——为 testQuatAdd / testQuatSub / testQuatMul / testQuatDiv / testQuatNeg / testQuatConstruct / testQuatWxyz 等各增 1 个边界或 Float64 类型变体用例。
  3. **拆分编译期引用 + 运行时 assertThrows**——为 testQuatVec3Stub / testQuatVec4Stub / testVec3QuatStub / testVec4QuatStub 各增 1 个编译期引用测试（如「`let _ = q * v` 类型推导验证」），与 assertThrows 分离。

---

### [一般] `test_trigonometric_stub.cj` 仅覆盖 75 个函数签名中的 16 个——Vec2/Vec3/Vec4 重载缺编译期验证

- **位置**：`cjglm/tests/glm/detail/test_trigonometric_stub.cj:1-81`
- **描述**：OOD §8.2 第 9 项「编译期函数签名正确性验证」明确要求「覆盖全部 88 个 ❌/⚠️ 函数的编译期签名正确性...对 🚫 / 同构度高的函数组（如 trigonometric.cj 的 75 个函数，**允许每类选取 1 个代表性函数验证**」。「每类」按函数名分组为：sin/cos/tan/asin/acos/atan/sinh/cosh/tanh/asinh/acosh/atanh/radians/degrees/atan2 = 15 类。

  当前文件 16 个测试用例覆盖：
  - sin 标量（行 4-6）+ sin Vec1（行 8-11）
  - cos 标量（行 13-16）
  - tan 标量（行 18-21）
  - asin/acos/atan 标量（行 23-36）
  - sinh/cosh/tanh 标量（行 38-51）
  - asinh/acosh/atanh 标量（行 53-66）
  - radians/degrees 标量（行 68-76）
  - atan2 标量（行 78-81）

  也就是说，**15 个函数名分组中 14 个仅覆盖标量重载，1 个（sin）覆盖了标量 + Vec1 共 2 个重载**。剩余 Vec2/Vec3/Vec4 重载（每个函数名 3 个）共 15 × 3 = 45 个函数签名**未被任何测试用例引用**。

  实际风险示例（按 `cjglm/src/detail/trigonometric.cj:7-9` 验证）：
  - `sin<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier`
  - `sin<T, Q>(x: Vec3<T, Q>): Vec3<T, Q>`
  - `sin<T, Q>(x: Vec4<T, Q>): Vec4<T, Q>`

  若实现者误将 Vec3 版本的签名写为 `Vec4<T, Q>`（笔误）或遗漏 `Q <: Qualifier` 约束，**当前测试集无法捕获**——因为 Vec1 重载通过并不代表 Vec2/3/4 重载通过。

  OOD §8.2 第 9 项抽样策略「每类选取 1 个代表性函数验证」**字面意义**上允许只测 15 个代表性函数，但 §3.13.1「trigonometric.cj 函数清单段」明确列出 15 × 5 = 75 个独立签名，§11.5 函数可用性对照表中「detail/trigonometric.cj」一档列为「❌ stub（空桩占位，运行均抛 Exception("stub")」，其编译期签名验证**应至少覆盖每个签名的类型约束**，仅测标量重载无法验证 `Q <: Qualifier` 约束的实参化可行性。
- **建议**：
  1. **最低限度**——为 sin/cos/tan/atan2 4 个常用函数各增 1 个 Vec3 重载测试（共 4 个用例），覆盖「泛型 + Qualifier 约束」的双参数实参化路径；
  2. **推荐**——为 15 个函数名分组各增 1 个 Vec3 重载测试（共 15 个用例），确保 15 × 2 = 30 个代表性签名（标量 + Vec3）覆盖；
  3. **完整方案**——将测试用例增加到 75 个，每签名 1 个，但与 §8.2 第 9 项「每类 1 个代表性函数」策略存在偏差，需 OOD 修订配合。

---

### [一般] `test_scalar_constants.cj` 缺失整数 T 异常路径测试（D25 决策）

- **位置**：`cjglm/tests/glm/detail/test_scalar_constants.cj:1-41`
- **描述**：OOD §11.5 函数可用性对照表明确标注：
  - `epsilon（整型） | ❌ 抛异常 | ❌ 抛异常（保持契约） | §3.12；§1 约束：D25 整数 T 抛运行时异常`
  - `pi（整型） | ❌ 抛异常 | 同上`
  - `cos_one_over_two（整型） | ❌ 抛异常 | 同上`

  OOD §3.12 段落也明确描述「`epsilon<T>`/`pi<T>`/`cos_one_over_two<T>` 对整数类型抛运行时异常（D25 决策）」。但 `test_scalar_constants.cj` 8 个测试用例（行 3-40）**全部仅覆盖 Float32/Float64 浮点路径**，无任何 `epsilon<Int64>()` / `pi<Int64>()` / `cos_one_over_two<Int64>()` 异常路径测试用例。

  对比 `cjglm/tests/glm/ext/test_ext_scalar_constants.cj`（OOD §8.2 计划 ≥13 用例）应包含整数异常路径用例——本 detail 层文件与之存在职责重叠（均测试 detail/scalar_constants.cj 的同一组函数），但分工未明确：如果 detail 层和 ext 层均覆盖，则 ext 层该测试可省略；如果 detail 层只覆盖浮点，则 ext 层必须覆盖整数异常路径。建议明确职责分工。
- **建议**：
  1. **明确职责分工**——`tests/glm/detail/test_scalar_constants.cj` 作为 detail 层基础测试，应覆盖浮点正常路径 + **整数异常路径**（最小完备集：epsilon/pi/cos_one_over_two × Int64 异常 = 3 用例）；`tests/glm/ext/test_ext_scalar_constants.cj`（如已存在）可仅覆盖 ext 重导出可达性测试，避免重复。
  2. **同步 OOD §8.2 函数分组表**——若选择 detail 层覆盖整数异常路径，需更新 OOD §8.2 中 `test_ext_scalar_constants.cj` 的用例分配，移除其整数异常路径项；若选择 ext 层覆盖，需在 detail 层测试文件中添加注释说明「整数异常路径由 ext 层测试覆盖」。

---

### [一般] `test_scalar_quat_ops.cj` 缺失 T×Quat 反向运算符与边界用例

- **位置**：`cjglm/tests/glm/detail/test_scalar_quat_ops.cj:1-89`
- **描述**：文件覆盖 9 个测试用例（行 3-88）——其中 4 个核心用例（testScalarAddQuat / testScalarSubQuat / testScalarMulQuat / testScalarDivQuat）+ 5 个边界用例（testScalarAddQuatFloat64 / testScalarSubQuatNegative / testScalarMulQuatZero / testScalarDivQuatByOne / testScalarDivQuatFloatByZero）。

  缺失项：
  1. **T×Quat 反向运算符**——`type_quat.cj:130-137` 实际声明了 `q * T`（行 130）和 `q / T`（行 135）成员运算符（Quat×T 反向），但本 detail 测试文件未覆盖这 2 个运算符（仅在 `test_type_quat.cj` 中通过 testQuatMulScalar / testQuatDivScalar 覆盖）。scalar_quat_ops.cj 仅声明 `s × Quat`（标量在前），无反向 `Quat × s` 重载（与 C++ GLM 一致）。**此处 OOD §8.2 计划**为「`Quat×T/T×Quat/Quat/T/scalar_quat_ops`（6 个 | 6 | 1 | 6」，要求 6 个用例。当前 detail 文件仅覆盖 4 个全局函数（add/sub/mul/div）+ 边界；test_type_quat.cj 覆盖 2 个 Quat×T 运算符（mul/div）。两者合计 6 个用例满足 OOD 下限，但缺少 **add/sub 的 Quat×T 运算符**（虽然 type_quat.cj 未声明 `q + T` 和 `q - T` 运算符——若阶段三设计意图中无此运算符，则该缺口由设计约束决定）。
  2. **类型覆盖**——8 个 Int64 + 1 个 Float64 + 1 个 Float64（isInf），Int64 占主导。Float32 路径未单独测试（仅通过 Float64 间接覆盖）。OOD §8.2 第 7 项「跨类型实例化」要求 Float32/Float64 均应覆盖。
  3. **负数除数边界**——testScalarDivQuatFloatByZero（行 84-88）仅测试 r.x.isInfinite() 和 r.y.isFinite()，但 `Float64(1.0) / Float64(0.0)` 应返回 `+Inf`（非 `-Inf`），且 r.z = 1/0 也应为 `+Inf`，r.w = 1/2 应为 `0.5`。当前断言仅 2 项，未覆盖 z 分量和 w 分量。
- **建议**：
  1. **补充 Float32 覆盖**——为 add/sub/mul/div 各增 1 个 Float32 类型变体用例；
  2. **补全 div by zero 边界用例**——testScalarDivQuatFloatByZero 增补 r.z 与 r.w 的精确断言（`r.z.isInfinite()` 和 `r.w == 0.5`）；
  3. **明确 Quat×T add/sub 是否需要**——若设计意图中无 `q + T` 和 `q - T` 运算符（与 C++ GLM 不一致，C++ GLM 有），建议在 `deviations.md` 中明确登记；若设计意图中有但 type_quat.cj 未实现，需补齐。

---

### [一般] `test_type_quat.cj` 浮点 round-trip 测试未使用容差——可能掩盖浮点精度问题

- **位置**：`cjglm/tests/glm/detail/test_type_quat.cj:174-199`
- **描述**：`testQuatFromMat3RoundTrip`（行 175-181）、`testQuatFromMat4RoundTrip`（行 184-190）、`testQuatFromMat3NonIdentityRoundTrip`（行 193-199）均使用 `Float64` 类型进行 round-trip 测试，但断言形式为 `@Expect(m == m2, true)`——**直接使用 `==` 精确比较**而非 epsilon 容差比较。

  与 OOD §8.2「浮点比较策略」段对照：
  - 「**epsilon 版本**——使用 `epsilon<Float32> = 1.1920929e-7` 作为容差，调用 `equal(v1, v2, epsilon<Float32>())` 验证」
  - 「**精确比较**——对于 should be 精确相等的运算结果（如 `identity * v == v`），使用 `==` 直接比较」

  unit quaternion round-trip 在理想情况下是精确的（mat3Cast + quatCast 数学上互逆），但**浮点实现**会引入 ULP 级误差：
  - `m == m2` 在 Float64 下对 `(0,0,0,1)` 单位四元数应精确为 true（trace 路径选 W 分支时 m.c0.x = m.c1.y = m.c2.z = 1，无浮点累积误差）；
  - 但对 `(0.2, 0.3, 0.4, 0.8)` 非单位四元数 round-trip（testQuatFromMat3NonIdentityRoundTrip，行 193-199），quatCast 算法涉及 sqrt + 多次除法 + 多分支判断，浮点累积误差可能达到 1e-15 ~ 1e-16 量级。

  若 R1-Agent2 报告的因子 2 缩放 bug 修复后，仍可能因浮点精度产生 ~1e-15 量级的 round-trip 偏差，`m == m2` 精确比较**可能失败**——尽管实际算法是 1:1 正确的。这是潜在的「修复后测试报错」风险。
- **建议**：
  1. **epsilon 容差替换**——`testQuatFromMat3NonIdentityRoundTrip` 和 `testQuatFromMat4NonIdentityQuat` 类用例（待补）改用 `equal(m, m2, epsilon<Float64>())` 容差比较，避免浮点精度导致的脆弱断言；
  2. **保留 unit quaternion 精确比较**——`testQuatFromMat3RoundTrip` 和 `testQuatFromMat4RoundTrip` 用例（单位四元数）保留 `m == m2` 精确比较，因数学上无浮点累积误差。

---

### [轻微] `test_type_quat.cj` 部分测试用例的语义严谨性可优化

- **位置**：`cjglm/tests/glm/detail/test_type_quat.cj:118-126`、`cjglm/tests/glm/detail/test_type_quat.cj:154-172`
- **描述**：
  1. `testQuatDiv`（行 118-126）—— 使用 `Int64` 整数除法测试四元数除法（`(10,20,30,40) / (1,0,0,2)`）。但 OOD §3.7 + D38 决策明确「inverse 函数约束收紧至 `FloatingPoint<T>`，与 `normalize` 收紧策略一致」——虽然 `/` 运算符（行 109-117）的 where 子句是 `T <: Number<T>`（未收紧），实际 GLM C++ 浮点四元数除法 `Quat<Float64>` 不应用于 Int64 测试。整数除法在四元数除法语境下语义不明确（截断 vs 浮点），建议改用 Float64 测试更符合 GLM 行为契约。
  2. `testQuatMulScalar`（行 155-162）和 `testQuatDivScalar`（行 165-172）—— 使用 Int64 测试标量乘除，结果与 GLM 一致但 OOD §8.2 第 7 项「跨类型实例化」要求 Float32/Float64 也应覆盖，Int64 单一覆盖不满足跨类型要求。
  3. `testQuatFromMat3NonIdentityRoundTrip`（行 193-199）—— 使用 `q = (0.2, 0.3, 0.4, 0.8)` 但未对结果四元数进行 `unit check`（即 `length(q1) ≈ 1.0`）。若 quatCast 算法有 bug 导致返回非单位四元数，round-trip 失败可能掩盖根因。
- **建议**：
  1. testQuatDiv 改用 `Float64` 替代 `Int64` 测试（同时测试 `@Expect(r.x, -4.0)` 等精确浮点期望值）；
  2. testQuatMulScalar / testQuatDivScalar 各增 1 个 Float32/Float64 类型变体用例；
  3. testQuatFromMat3NonIdentityRoundTrip 增补 `length(q1)` 断言或 `dot(q1, q1) ≈ 1.0` 容差比较。

---

### [轻微] `test_type_quat.cj` 中 `valueSemantics` 测试位置与职责划分可优化

- **位置**：`cjglm/tests/glm/detail/test_type_quat.cj:260-272`
- **描述**：`testQuatValueSemantics`（行 260-272）测试「`a + b` 不修改 `a` 或 `b`」——但此用例属于「值语义」通用测试，不特定于任何函数（既适用于 + 也适用于 -、*、/）。在 OOD §8.2 用例分配中**未明确**列出此用例（用例分配表中「27 函数 | 42」小计已包含 42 个函数级用例）。`testQuatValueSemantics` 应归类为「跨函数通用语义验证」而非某个特定函数的测试。
- **建议**：
  1. **保留现有用例**——值语义测试是有价值的健壮性测试，建议保留；
  2. **建议在 OOD §8.2 测试覆盖维度 1-9 之外单列「跨函数通用语义验证」维度**，明确此类用例的归类；
  3. **可考虑将 valueSemantics 测试迁移到 `test_setup.cj` 或新增 `test_type_quat_common.cj`**——避免单一测试文件中混杂函数级和语义级用例。

---

## 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 2 |
| 一般 | 5 |
| 轻微 | 2 |

## 总评

本轮审查覆盖 `cjglm/tests/glm/detail/` 阶段三新增的 5 个测试文件（约 576 行、71 个 `@Test` 函数）。**核心结论**：5 个测试文件**全部未被 `cjpm test` 发现/执行**——经 `cjpm test --dry-run` 实测验证，422 个被发现的测试用例中 0 个来自这 5 个文件。该问题在 R1-Agent2 中已针对 `test_type_quat_cast.cj` 提出但本轮审查证实该问题**未被修复**且**扩展至全部 5 个文件**（共 71 个测试用例静默跳过）。这意味着 OOD §8.2 / §11.5 中承诺的所有阶段三 detail 层测试覆盖（≥40 + ≥8 + 边界用例 = ≥48）**实质为零**，阶段四 stub 替换后的回归测试基础完全缺失。

**逐文件评价**：

1. **`test_type_quat.cj`（272 行，30 测试）**——用例数显著低于 OOD §8.2 计划 ≥40 下限（短缺 10+），主要缺口在「完整实现 ≥2 用例/函数」原则（5 个算术运算符各仅 1 个用例）和 fromVec3/fromEuler stub 测试。stub 函数（Quat×Vec3/Vec4/Vec3×Quat/Vec4×Quat）的 4 个 `@ExpectThrows[Exception]` 测试**正确抛出 stub 异常**，符合 OOD §11.5 ⚠️ 符号要求；但每个 stub 缺独立的编译期引用测试，违反 OOD §8.2 第 8 项要求。

2. **`test_type_quat_cast.cj`（93 行，8 测试）**——8 个用例数量满足 OOD §8.2 ≥8 下限，但**测试策略有严重偏差**：8 个用例中 7 个采用 round-trip 形式 `mat3Cast(quatCast(M)) == M`，无法捕获 R1-Agent2 已识别的 quatCast 因子 2 缩放算法 bug。建议按 R1-Agent2 第 58-61 行建议补充数值精确度测试用例和 OOD §8.2「浮点比较策略」段的 `m3 * v == q * v` 等价性测试。

3. **`test_scalar_constants.cj`（41 行，8 测试）**——8 个用例覆盖 epsilon/pi/cos_one_over_two × Float32/Float64，浮点路径完整。**唯一缺口是 D25 决策要求覆盖的整数 T 异常路径**（epsilon<Int64>() / pi<Int64>() / cos_one_over_two<Int64>() 应抛运行时异常），与 OOD §11.5「❌ 抛异常（保持契约）」行不符。建议明确 detail 层与 ext 层职责分工。

4. **`test_scalar_quat_ops.cj`（89 行，9 测试）**——9 个用例完整覆盖 4 个全局函数（add/sub/mul/div）+ 5 个边界用例（Float64/negative/zero/byOne/byZero），用例数超出 OOD §8.2 计划 6 个的下限（OOD §8.2 中 Quat×T/T×Quat/Quat/T/scalar_quat_ops 共 6 个用例已由 test_type_quat.cj 覆盖 2 个 Quat×T mul/div + 本文件 4 个全局函数）。**轻微缺口**是 div by zero 边界断言不完整（仅检 x 和 y，未检 z 和 w）和缺 Float32 类型变体。

5. **`test_trigonometric_stub.cj`（81 行，16 测试）**——16 个用例覆盖 75 个 stub 签名的 16 个（sin 标量 + sin Vec1 = 2 个 + 14 个其他函数标量）。OOD §8.2 第 9 项允许「每类选取 1 个代表性函数验证」，15 类函数中 14 类仅覆盖标量重载。**主要缺口**是 Vec2/Vec3/Vec4 重载（共 45 个签名）未编译期引用验证，若实现者笔误修改 Vec3 重载签名为 Vec4，当前测试无法捕获。建议按 OOD §3.13.1 75 个签名清单补全代表性测试。

**与 OOD 设计意图的整体一致性**：

| 维度 | 评价 |
|------|------|
| 测试覆盖广度 | ⚠️ 表面满足 OOD §8.2 计划 ≥40 + ≥8（仅 test_type_quat.cj 短缺 10+），但实际 0 个用例被 cjpm 运行 |
| 测试覆盖深度 | ❌ 主要为 round-trip 和正常路径，缺边界用例、容差比较、数值精确度验证 |
| Stub 异常路径 | ✅ 4 个 ⚠️ 函数（Quat×Vec3/Vec4/Vec3×Quat/Vec4×Quat）的 `@ExpectThrows[Exception]` 测试正确 |
| stub 函数异常路径（detail/trigonometric） | ⚠️ 16/75 签名覆盖（OOD §8.2 §9 抽样策略允许，但 Vec2/3/4 重载未覆盖） |
| 类型覆盖 | ⚠️ Int64 占主导，Float32/Float64 覆盖不足 |
| 跨 Qualifier 覆盖 | ⚠️ 仅 fromQual 跨 PackedHighp → Defaultp 测试，缺其他 5 个 Qualifier 变体 |
| 编译期签名验证 | ❌ stub 函数缺独立的编译期引用测试（与运行时 assertThrows 合并） |
| cjpm test 发现 | ❌ 全部 5 文件 71 用例未被 cjpm 发现执行（R1-Agent2 已识别问题未修复） |

**总结**——5 个测试文件在「测试用例设计」层面**部分**符合 OOD §8.2 计划（test_type_quat_cast.cj 和 test_scalar_quat_ops.cj 满足下限，test_type_quat.cj 短缺 10+ 用例，test_scalar_constants.cj 缺整数异常路径，test_trigonometric_stub.cj 仅 16/75 签名覆盖）。但更关键的「**测试可执行性**」维度上，5 个文件**全部失败**——cjpm test 不识别 `tests/` 目录下的 `test_*.cj` 前缀文件，仅识别 `src/` 目录下 `*_test.cj` 后缀文件。在修复 cjpm 发现路径问题（迁移文件至 `src/detail/*_test.cj`）之前，所有 71 个 `@Test` 函数均为**装饰性代码**——CI 不会运行，测试覆盖率统计为虚假报告。同时建议按 R1-Agent2 已识别问题补齐 `test_type_quat_cast.cj` 的数值精确度测试用例，确保 quatCast 算法 bug 在修复后能被测试捕获。这两个问题（P0 阻断性问题）必须在阶段四 stub 替换前彻底修复。