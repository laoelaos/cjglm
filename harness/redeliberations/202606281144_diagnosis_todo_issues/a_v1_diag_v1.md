# 诊断报告：todo.md 问题分类分析（v2 修订版）

## 概述

本报告对 `harness/reviews/202606271542_glm_phase3_review/todo.md` 中的 42 项问题（4 项严重 + 38 项一般）逐一分析，按以下 4 类分类：
1. **真实存在** — 实现与设计/参考实现对比存在偏差
2. **误报** — 实际实现正确
3. **OOD 文档问题** — 设计文档存在矛盾、偏差、不完善或错误
4. **其他类型的问题** — 如测试覆盖不足、代码可优化等

> **计数说明：** todo.md 标题标称「6 项严重 + 42 项一般 = 48 项」，与实际列表不符。实际列表包含 S1~S4 共 4 项严重问题、G1~G6 共 38 项一般问题（G1:8 + G2:6 + G3:9 + G4:4 + G5:9 + G6:2 = 38），合计 42 项。本报告按实际列表计数，并在下文逐项分析中标注 todo.md 原始标称数据误差。

交叉验证依据：`docs/deviations.md`、`docs/05_ood_phase3.md`（阶段三 OOD——注：requirement.md 指定的 `docs/02_ood_phase0.md` 不存在，经确认仓库中仅包含 03/04/05 阶段文档，05_ood_phase3.md 为阶段三设计文档，涵盖本报告涉及的全部 OOD 引用）、`references/glm-1.0.3`（GLM 参考实现）、`cjglm/`（当前实现）。

---

## 严重问题（4 项）

### S1. quatCast 算法因子 2 缩放 bug

**分类：真实存在（实现与参考实现存在算法偏差）**

**分析：** 对比 GLM 1.0.3 `quaternion.inl:106-122` 与 Cangjie `type_quat_cast.cj:83-107`，确认真 bug。

GLM 算法：
```
biggestVal = sqrt(fourBiggestSquaredMinus1 + 1) * 0.5;   // = |biggest_component|
mult = 0.25 / biggestVal;                                 // = 0.25/|biggest|
// 非最大分量 = matrix_element * mult = 4*biggest*comp * 0.25/|biggest| = comp
```

Cangjie 算法：
```
v = sqrtT(fourBiggestSquaredMinus1 + one);                // = 2*|biggest|（缺少 *0.5）
// 非最大分量 = matrix_element / v = 4*biggest*comp / (2*|biggest|) = 2*comp
```

四个分支（X/Y/Z/W）中非最大分量的求解均缺少 `* 0.5` 因子，导致返回的四元数非 w 分量被缩放 2 倍。以 `Quat(0.2, 0.3, 0.4, 0.8)` round-trip 验证：`quatCast(mat3Cast(q))` 返回约 `(0.38, 0.57, 0.76, 0.84)`，约为原 q 的 1.9 倍。

**证据：** `type_quat_cast.cj:84-106` 各分支使用 `v = sqrtT(four?SquaredMinus1 + one)` 后直接以 `matrixElement / v` 求解，缺少 GLM 的 `* 0.5` 和 `0.25 / biggestVal` 分步。`mat3Cast`/`mat4Cast` 行为正确（与 GLM 对比已验证）。

**影响范围：** 所有调用 `quatCast`（含 `fromMat3`/`fromMat4` 工厂函数）的 round-trip 场景均返回错误四元数。OOD §1 表中所列 4 个函数之一的「真完整实现」行为与 GLM 不一致。

**deviations.md 对照：** 本问题属算法级功能 bug（quatCast 实现错误），非有意的设计偏差，不应登记至 deviations.md（该文档记录 C++ GLM 与仓颉 GLM 之间的使用差异，不记录未修复的 bug）。

---

### S2. tests/ 目录下测试文件不被 cjpm test 发现执行

**分类：真实存在 + OOD 文档问题**

**分析：** 已验证 `cjpm.toml:8-9` 配置 `[test] src-dir = "tests"`。cjpm 1.1.0 工具链仅识别 `src/**/*_test.cj`（以 `_test.cj` 为后缀）的测试文件。`tests/` 目录下的 `test_*.cj` 前缀命名是项目自定义约定，不被 cjpm 工具链识别。`docs/03_ood_phase1.md:148` 声称的「此完整配置确保 `cjpm test` 可正确发现位于 `tests/glm/detail/` 和 `tests/glm/` 目录下的 `@Test` 标注测试用例」与 cjpm 1.1.0 实际行为不符。

**子问题：**
- **真实存在（工具链兼容性）：** cjpm 1.1.0 的测试发现规则与项目测试文件命名约定不匹配，300+ `@Test` 全部静默跳过。
- **OOD 文档问题：** `docs/03_ood_phase1.md` 对 cjpm 测试发现行为的描述不准确。
- **其他类型（未修复已知问题）：** R1-Agent2 已报告此问题但未修复。

**证据：** `cjpm.toml:8` 配置确认。测试文件命名 `test_*.cj` vs cjpm 要求的 `*_test.cj`。估算 `tests/` 下文件数量：detail/ 5 文件 + test_fwd.cj + test_lib.cj + ext/* + gtc/* = 300+ @Test。

**deviations.md 对照：** 本问题属工具链兼容性问题，非 C++ GLM 与仓颉 GLM 之间的语义偏差，不涉及 deviations.md。

---

### S3. `test_type_quat_cast.cj` 仅依赖 round-trip 测试，无法捕获 quatCast 因子 2 缩放算法 bug

**分类：真实存在（测试覆盖不足）**

**分析：** 8 个测试用例中 7 个采用 round-trip 形式 `mat3Cast(quatCast(M)) == M` 或 `mat4Cast(quatCast(M)) == M`。由于 quatCast 因子 2 bug 是整体缩放，在某些数值条件下 round-trip 可能内部一致地返回近似原矩阵（取决于具体数值），导致 bug 被掩盖。

**证据：** `test_type_quat_cast.cj:18-93` 确认 7 个 round-trip 用例。OOD §8.2 明确推荐「旋转矩阵 * 向量 = 四元数 * 向量」等价性测试，但未采用。

**deviations.md 对照：** 本问题属测试设计缺陷，非 C++ GLM 接口/行为偏差，不涉及 deviations.md。

---

### S4. ULP stub 测试覆盖严重不完整

**分类：真实存在（测试覆盖不足）**

**分析：** `vector_relational.cj:197-251` 定义了 8 个 stub 函数（`equal`/`notEqual` × Vec1~Vec4 × `Int64`/`VecN<Int64,Q>` 参数形态 = 32 个签名组合）。`test_vector_relational.cj:175-178` 仅测试 `equal(Vec1<Float64>, Vec1<Float64>, Int64)` 一个组合，覆盖率 1/32 = 3.125%。

**证据：** `vector_relational.cj:199-250` 确认 8 个 stub 定义（每个含 4 个 Vec 重载 = 32 签名）。`test_vector_relational.cj:174-179` 确认仅 1 个测试。

**deviations.md 对照：** 本问题属测试覆盖不足，非 C++ GLM 接口/行为偏差，不涉及 deviations.md。

---

## 一般问题

### G1. Quat 类型层设计偏差（合并 8 项）

#### G1.1 跨 Qualifier 构造函数 `init<Q2>` 缺失

**分类：真实存在（实现与 OOD 设计偏差）**

**分析：** OOD §3.3 item 3 要求提供 `init<Q2>(q: Quat<T,Q2> where Q2 <: Qualifier)` 构造函数。实现未提供该 `init`，而是以静态工厂 `fromQual<Q2>`（`type_quat.cj:61-63`）替代。调用方无法使用 `Quat<Float32, Highp>(q_of_PackedHighp)` 构造语法，必须改写为 `Quat<Float32, Highp>.fromQual(q_of_PackedHighp)`。静态工厂无法在 `const` 上下文使用。

**证据：** OOD §3.3 item 3 要求 vs `type_quat.cj:56-64` 仅提供 `fromQual` 静态工厂。

**deviations.md 对照：** 此项偏差未在 deviations.md 中登记。该偏差属于「实现未遵循 OOD 设计」——实现者选择静态工厂模式替代构造函数，此为内部实现差异，建议按「三、内部区别」类型评估是否需要登记。

---

#### G1.2 `Vec3×Quat` / `Vec4×Quat` 实现路径与 OOD §3.4 不一致

**分类：真实存在（实现与 OOD 设计偏差）**

**分析：** OOD §3.4 明确要求 `Vec3×Quat`/`Vec4×Quat` 实现为 `(conjugate(q) / dot(q, q) * v` 内联逆四元数路径。实现中两处函数体均为 `throw Exception("stub")`（`type_quat.cj:142-144, 149-151`），直接抛出 stub 而未实现 OOD 承诺的调用链。

**证据：** OOD §3.4「Vec extend 块成员运算符」段描述 vs `type_quat.cj:140-152` 仅 `throw Exception("stub")`。

**deviations.md 对照：** 此项偏差未在 deviations.md 中登记。当前在 stub 阶段运行时行为一致（均抛异常），但实现路径偏离 OOD 设计意图。建议在阶段四补齐前评估是否需要登记至 deviations.md。

---

#### G1.3 `fromMat3` / `fromMat4` 约束签名与 OOD §3.3 item 6/7 偏差

**分类：OOD 文档问题（文档与实现未同步）** + **真实存在（两处均需更新）**

**分析：** OOD §3.3 item 6/7 规定 `fromMat3`/`fromMat4` 签名为 `where T <: FloatingPoint<T>, Q <: Qualifier`，但实现使用 `where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier`（`type_quat.cj:73`）。该偏差是编译期必需的——`quatCast` 实现需 `Comparable<T>` 进行比较运算。OOD §3.2.1 `quatCast` 签名也仅写 `FloatingPoint<T>`，实际 `quatCast` 实现需要 `Comparable<T>`。

**证据：** `type_quat.cj:73` vs OOD §3.3 item 6/7。`type_quat_cast.cj:52` 也需 `Comparable<T>` 约束。

**deviations.md 对照：** 此项属 OOD 文档与实现的同步问题（双方均需更新），非用户视角的接口偏差，不涉及 deviations.md。

---

#### G1.4 `init(s: T, v: Vec3<T, Q>)` 未声明为 `const`

**分类：真实存在（实现与 OOD 设计偏差）**

**分析：** OOD §3.3 item 2 明确要求「标量+向量构造 `const init(s: T, v: Vec3<T,Q>)`」。但实现为 `public init`（`type_quat.cj:20`，无 `const`）。与主构造函数 `const init(x: T, y: T, z: T, w: T)`（第 13 行）不对称，导致 `const val q = Quat<Float32, PackedHighp>(0.0f, v)` 在阶段三编译期失败。函数体仅访问 `v.x`/`v.y`/`v.z` 公开字段与赋值，完全 const 可调用。

**证据：** `type_quat.cj:20-25` vs OOD §3.3 item 2。

**deviations.md 对照：** 此项偏差未在 deviations.md 中登记。属实现遗漏 const 修饰符，建议按「三、内部区别」评估是否需要登记。

---

#### G1.5 `mat4Cast` 中 `one - one` 零获取路径与 OOD §1 字面量替代策略偏差

**分类：真实存在（实现与 OOD 设计偏差）**

**分析：** OOD §1 明确要求 `mat3Cast`/`mat4Cast` 中的零值应使用 `T(Float64(0))` 字面量替代路径，且特别将 `mat3Cast`/`mat4Cast` 列为「系统性覆盖」目标函数。实现中 `mat4Cast` 函数体使用 `let zero: T = one - one`（`type_quat_cast.cj:30`）仍采用 `one - one` 演算路径获取 0 值，违反 OOD §1 显式约束。

**证据：** `type_quat_cast.cj:30` vs OOD §1 字面量替代策略。

**deviations.md 对照：** 此项偏差未在 deviations.md 中登记。该偏差属实现违反 OOD 策略约束，不涉及用户视角的 GLM 行为差异，不建议登记。

---

#### G1.6 `sqrtT` 与 `zeroOrOne` 私有工具函数的设计可优化

**分类：其他类型（代码质量/可读性建议）**

**分析：** ① `sqrtT`（`type_quat_cast.cj:122-125`）通过 `Float64` 中转实现 sqrt，与 OOD §1 方案 A 推荐的直接调用策略不一致（详见 G2.3）。② `zeroOrOne`（`type_quat_cast.cj:127-129`）命名反直觉——`one` 形参减去自身得 `zero`，函数名暗示歧义。③ `quatCast` 函数体内 `var x: T = zeroOrOne(one)` 等 4 行是为规避「`var` 必须初始化」约束。

**纠正（todo.md 描述偏差）：** todo.md 称「sqrtT 未在任何地方被调用」。经代码核查：`sqrtT` 在 `quatCast` 函数体第 84, 90, 96, 102 行被调用，todo.md 描述不准确。该子项属 todo.md 原始描述错误，不影响本报告对代码质量本身的判断。

---

#### G1.7 quatCast 内部 `var` + 多次 `if` 重新赋值的控制流可优化

**分类：其他类型（代码可优化建议，非功能缺陷）**

**分析：** `type_quat_cast.cj:62-76` 使用 `var fourBiggest` + 3 个串行 `if` 比较。GLM 原版使用相同模式，可读性尚可。todo.md 本身承认这是 GLM 直译版本，符合 OOD 设计意图。此问题为优化建议而非缺陷。

---

#### G1.8 `quatCast(Mat4x4)` 依赖列布局假设 `c0/c1/c2` 与 `c3` 行为预期的一致性需文档说明

**分类：其他类型（文档/注释建议）**

**分析：** `type_quat_cast.cj:112-120` 手动构造 `Mat3x3` 子矩阵，假设 Mat4x4 的 `c0/c1/c2` 三列对应左上 3×3 旋转块。OOD §3.2.1 已明确该模式。此建议为可选的注释添加，非功能缺陷。

---

### G2. ext/ 函数库层实现偏差（合并 6 项）

#### G2.1 `slerp` 4 参数版本 `spin: Bool` 与 OOD §3.11 / D22 决策 `k: Int64` 显著偏离

**分类：真实存在（实现与 OOD + GLM 参考实现双重偏差）**

**分析：** OOD §3.11 line 791、D22 决策、§11.5 函数可用性对照表三处明确声明 `slerp` 4 参数版本采用 `k: Int64` 签名。GLM 1.0.3 原始 `slerp(x, y, a, k)` 使用独立泛型 `S` 约束为整数类型。实现采用 `spin: Bool`（`quaternion_common.cj:40`），与上述三处承诺及 GLM 原始设计均不一致。

具体问题：① 语义错误——`Bool` 类型不实现 `Integer<Bool>` 接口，阶段四按 GLM `phi = angle + k * pi<T>()` 公式实现时 `*` 运算符需要 `Number<T>` 接口，Bool 不实现。② 取值域错位——`Bool` 仅能取 `true`/`false`，无法表达「3 整圈旋转」等多圈场景。③ 命名歧义——`spin` 与 GLM 命名风格不一致，应改为 `k`。

**证据：** `quaternion_common.cj:40` 签名 vs OOD §3.11 line 791、D22、§11.5 line 2212。

**deviations.md 对照：** 此项偏差未在 deviations.md 中登记。该偏差属 API 签名级别的实现错误（`Bool` 替代 `Int64`），非有意的设计偏差，应在修复前评估是否需要临时登记。

---

#### G2.2 `mix` / `lerp` 约束较 GLM `is_iec559` 静态断言过宽

**分类：真实存在（约束过宽，未来风险）** + **OOD 文档问题（OOD §1 已预见此风险）**

**分析：** GLM 1.0.3 对 `lerp`/`mix` 使用 `GLM_STATIC_ASSERT(std::numeric_limits<T>::is_iec559, ...)` 限定为浮点类型。实现 `mix` 用 `where T <: Number<T>`（`quaternion_common.cj:34-35`），`lerp` 用 `where T <: Number<T> & Comparable<T>`（第 17 行）。`Number<T>` 允许整数类型实例化。`mix`（球面插值）需要 `acos`/`sin` 等三角函数，整数 T 实例化将无法在阶段四编译通过。OOD §1 已对此类约束放宽风险做出告诫。

**证据：** `quaternion_common.cj:16-17, 34-35` vs GLM `GLM_STATIC_ASSERT(is_iec559, ...)`。

**deviations.md 对照：** 此项偏差未在 deviations.md 中登记。当前属「未来风险」——阶段四补齐前不影响功能，但届时需收紧约束。建议登记至 deviations.md 作为已知的接口约束偏差记录。

---

#### G2.3 `length` / `sqrtT` Float64 中转包装偏离 OOD §1 方案 A「直接调用」策略

**分类：真实存在（实现与 OOD 策略偏差，项目级一致性问题）**

**分析：** OOD §1 明确说明 `std.math.sqrt` 提供 Float16/Float32/Float64 三种重载，T=Float32 实例化时应直接调用 `std.math.sqrt(dot_qq)` 利用 Float32 重载（方案 A 推荐）。实现定义私有 `sqrtT` 工具函数通过 `Float64` 中转——所有 T 实例化路径均强制走 Float64 中转，违反 OOD §1 方案 A 策略。跨 `quaternion_geometric.cj:5-8, 17` + `quaternion_trigonometric.cj:5-8, 18` + `type_quat_cast.cj:122-125` 共 3 处。

**证据：** `quaternion_geometric.cj:5-8`、`quaternion_trigonometric.cj:5-8`、`type_quat_cast.cj:122-125` 的 `sqrtT` 实现模式 vs OOD §1「方案 A」。

**deviations.md 对照：** 此项偏差未在 deviations.md 中登记。该偏差属实现策略与 OOD 设计不一致，不涉及用户视角的 GLM 行为差异，不建议登记（属于修复方向的内部决策问题）。

---

#### G2.4 abs 内联模式重复 16 次，未抽取为包内私有辅助函数

**分类：其他类型（代码质量/维护性建议）**

**分析：** `vector_relational.cj` 中每个 epsilon 重载内部都重复相同的内联 abs 模式（`let zero = (Float64(0) as T).getOrThrow(); let d = x.x - y.x; (if (d >= zero) { d } else { -d }) < epsilon`），共 16 处重复。`quaternion_relational.cj` 也使用相同模式（2 处）。均为同一包（`glm.ext`），未抽取共享辅助函数。

---

#### G2.5 阶段一 `equalEpsilon` 与阶段三 `equal` epsilon 重载的约束风格不一致

**分类：其他类型（风格不一致，非功能缺陷）**

**分析：** 阶段一 `equalEpsilon` 使用 `T <: Number<T> & Equatable<T> & Comparable<T>`，阶段三 `equal` epsilon 重载使用 `T <: Number<T> & Comparable<T>`（无 `Equatable<T>`）。两者逻辑上都正确且与各自实现一致，但存在两种「epsilon 比较」约束模板。注意 `equalEpsilon` 需要 `Equatable<T>` 是因为它内部需要 `==` 比较；而阶段三 epsilon 重载使用原始 `<` 比较，不依赖 `Equatable<T>`。

---

#### G2.6 epsilon 重载未声明 `const func`

**分类：其他类型（可优化建议，非功能缺陷）**

**分析：** `vector_relational.cj` 的 16 个 epsilon 重载和 `quaternion_relational.cj:15-43` 的 2 个 epsilon 重载均可声明为 `const func`（函数体仅包含 `let` 绑定、算术运算、`<` 比较、`VecN<Bool, Q>(...)` 构造，均为 const 兼容操作）。`cjglm/src/detail/type_vec3.cj:54-80` 已成功声明 27 个 const func 为先例。

---

### G3. gtc/ 层 + 顶层 API 偏差（合并 9 项）

#### G3.1 `gtc/quaternion.cj` 依赖声明与 OOD §3.15 不一致

**分类：真实存在（实现与 OOD 设计偏差）**

**分析：** OOD §3.15 line 1274-1279 明确声明 `gtc/quaternion.cj` 的依赖包括 `import glm.ext.vector_relational.*` 和 `import glm.ext.scalar_constants.*`。当前实现（`gtc/quaternion.cj:1-4`）仅含 `package glm.gtc` + `import glm.detail.*` + `import std.math.FloatingPoint` + `public import glm.detail.{mat3Cast, mat4Cast, quatCast}`，缺失上述两项。当前编译通过是因为 7 个 stub 函数体均为 `throw Exception("stub")`，未实际引用 `equal`/`epsilon<T>()`。

**证据：** `gtc/quaternion.cj:1-4` vs OOD §3.15 line 1274-1279。

**deviations.md 对照：** 此项偏差未在 deviations.md 中登记。属实现阶段省略前瞻性 import（因 stub 反射不需要），不涉及用户视角偏差，不建议登记。

---

#### G3.2 `gtc/quaternion.cj` 的 4 个比较函数 Vec4 构造调用缺少显式类型参数

**分类：其他类型（风格不一致，非功能缺陷）**

**分析：** 4 个比较函数实现使用 `Vec4(x.x < y.x, x.y < y.y, ...)` 形式（无显式 `<Bool, Q>` 类型参数），依赖编译器从返回类型 `Vec4<Bool, Q>` 反向推断。OOD §3.15 line 1242-1245 给出的签名模板均使用 `Vec4<Bool, Q>(...)` 显式类型实参。当前实现与 OOD 模板不完全一致，但功能等价。

---

#### G3.3 `gtc/matrix_transform.cj` import 列表未显式声明 OOD §3.13/路线图中的传递依赖

**分类：其他类型（意图表达缺失，非功能缺陷）**

**分析：** 当前文件仅 `import glm.detail.{ Mat4x4, Vec2, Vec3, Vec4, Qualifier }` + `import std.math.FloatingPoint`，未包含 OOD 列举的 6 个传递依赖。在 stub 形态下编译通过（函数体均为 `throw Exception("stub")`）。缺失依赖不影响功能，但下游维护者从 import 列表无法直接看出本文件的依赖链设计意图。

---

#### G3.4 `trigonometric.cj` 头部缺少与 OOD §3.13.1「T 类型约束策略」一致的引用说明

**分类：其他类型（注释缺失，非功能缺陷）**

**分析：** 当前文件头注释为空白，无任何关于约束策略的依据引用。OOD §3.13.1 明确指出 `where T <: FloatingPoint<T>` 约束是「阶段四完整实现前的必备前置项」。所有 75 个签名均已正确应用该约束，但缺少注释说明约束来源。

---

#### G3.5 `fwd.cj.bak` 备份文件包含 OOD 明确禁止的错误变体

**分类：真实存在（版本控制问题）**

**分析：** `fwd.cj.bak:330-332` 包含 OOD §2 明确禁止的 `HighpFQuat`/`MediumpFQuat`/`LowpFQuat` 三个错误别名。该 `.bak` 是修复前的快照，被误纳入 git 暂存区。当前 `fwd.cj`（335 行）已正确不含上述三个错误变体。

**证据：** `fwd.cj.bak:330-332` vs OOD §2 验证命令段。`git status` 确认 `new file: cjglm/src/fwd.cj.bak`。

**deviations.md 对照：** 本问题属版本控制问题（备份文件误纳入仓库），非 C++ GLM 与仓颉 GLM 之间的语义偏差，不涉及 deviations.md。

---

#### G3.6 `gen_fwd_aliases.py` 在 Windows 上破坏幂等性

**分类：真实存在（脚本兼容性问题）**

**分析：** `gen_fwd_aliases.py:71` 写入文件时显式指定 `newline='\n'`（LF）。当前已提交的 `fwd.cj` 使用 CRLF 行尾（Windows 仓库默认）。首次在已提交版本上执行脚本时会将全部行尾从 CRLF 改为 LF，触发 `git diff` 大量变更。脚本对 LF 文件可幂等，但对 CRLF 文件不幂等。

**deviations.md 对照：** 本问题属构建工具兼容性问题，非 C++ GLM 与仓颉 GLM 之间的语义偏差，不涉及 deviations.md。

---

#### G3.7 `lib.cj` 行数偏离 OOD 预期（16 行 vs 28 行）

**分类：其他类型（实现偏离文档描述，功能等价）** + **OOD 文档问题（部分）**

**分析：** OOD §2 明确声明 `lib.cj` 应有 20 个显式 import。实际 `lib.cj` 仅 16 行，原因是实现采用了 `import glm.ext.*` 和 `import glm.gtc.*` 两个通配符导入来合并原本 14 个 ext + 3 个 gtc 的显式 import 清单。功能等价，但偏离 OOD 文本「20 个 import」的逐项描述。

**证据：** `lib.cj:1-16` vs OOD §2 逐项 import 清单。

---

#### G3.8 `lib.cj` 触发 17 个 unused import 编译警告

**分类：真实存在（编译警告）**

**分析：** `cjpm build` 输出 17 条 `unused import` 警告。`lib.cj:12, 14, 16` 的 import（非 `public`）仅服务于将 ext/gtc 符号引入 `glm` 包作用域以便内部引用，但 `lib.cj` 自身并不调用这些符号，因此编译器判定为未使用。

**deviations.md 对照：** 本问题属编译警告问题，非 C++ GLM 与仓颉 GLM 之间的语义偏差，不涉及 deviations.md。

---

#### G3.9 `lib.cj` 缺少 OOD §2 指定的 `Quat` 的 public import

**分类：其他类型（实现偏离文档描述，功能等价）** + **OOD 文档问题（部分）**

**分析：** OOD §2 line 304 要求 `public import glm.detail.{Quat, mat3Cast, mat4Cast, quatCast}`。实际 `lib.cj:10` 仅 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}`，未导入 `Quat`。能编译通过是因为 `fwd.cj:327` 的 type alias `public type Quat = detail.Quat<Float32, PackedHighp>` 在 generic-style 实例化时被 Cangjie 编译器按「透明再参数化」语义解析。严格按 OOD 设计，`Quat` 应当通过 `public import` 在 `glm` 命名空间下公开。

---

### G4. scalar_constants / scalar_quat_ops 设计偏差（合并 4 项）

#### G4.1 `pi<T>()` 与 `cos_one_over_two<T>()` 未利用 `FloatingPoint<T>` 接口的静态方法

**分类：其他类型（实现可简化，非功能缺陷）**

**分析：** 标准库 `FloatingPoint<T>` 接口声明 6 个静态方法，包括 `getPI()`。当前 `pi<T>()` 实现（`scalar_constants.cj:10-22`）通过 3 次 `hint is FloatXX` 运行时类型分派，可简化为一行业务逻辑：`FloatingPoint<T>.getPI()`。

---

#### G4.2 `scalar_constants.cj` 缺少 OOD §3.12 line 805 约定的非浮点类型运行时异常 fallback

**分类：OOD 文档问题（设计契约与约束策略不一致）**

**分析：** OOD §3.12 line 805 约定对非浮点类型应抛 `Exception`。当前三个函数均缺少该 fallback——pi 和 cos_one_over_two 的 fall-through 分支静默返回 Float64 值。但当前 `FloatingPoint<T>` 约束已限制 T 仅可为 Float16/Float32/Float64（标准库确认），fallback 实际不可触发。因此存在两种可能性：① OOD §3.12 的运行时异常约定在 `FloatingPoint<T>` 约束下不可达，应标记为 OOD 文档陈旧（需删除该约定或调整表述）；② 若意图保留该契约，则实现应补充 fallback 分支。本报告按「OOD 文档问题」分类，即设计文档描述的契约与实际约束策略存在不一致，需由设计者决策清理方向。

**纠正（todo.md 描述偏差）：** todo.md 称 `pi<T>()`「三个 `if` 分支均不匹配时默认 fall-through 至 `Float64.getPI()`」——实际上 `FloatingPoint<T>` 约束使此路径不可达。该描述虽在代码字面上成立，但在当前约束体系下无实际影响。

---

#### G4.3 `cos_one_over_two<T>()` 取值与 OOD §3.12「具体类型硬编码」策略不一致

**分类：OOD 文档问题（实现优于设计文档）**

**分析：** OOD §3.12 line 806 规定 `pi<T>()` 与 `cos_one_over_two<T>()`「同理使用具体类型硬编码值」。当前 `pi<T>()` 实现实际采用 `Float64.getPI()`/`Float32.getPI()`/`Float16.getPI()` 静态方法而非硬编码字面量。`pi<T>()` 实际调用 `FloatingPoint<T>.getPI()` 接口是更优实现（标准库对每个类型已精度调优）。`cos_one_over_two<T>()` 使用的字面量 `0.877582561890372716` 符合 OOD 描述。偏差性质：实现优于 OOD 设计文档，但与文档字面承诺不一致。

---

#### G4.4 `scalar_quat_ops.cj` 与 GLM 习惯的「交换律覆盖」偏差未在 deviations.md 登记

**分类：OOD 文档问题（deviations.md 未登记已知偏差）** + **其他类型（偏差已在 OOD 正文说明）**

**分析：** `scalar_quat_ops.cj` 实现 `T + Quat`/`T - Quat`/`T * Quat`/`T / Quat` 四个全局具名函数。OOD §3.11 line 660 已明确说明此偏差及其根因（仓颉运算符重载规则）。偏差已在 OOD 正文中记录，但 `docs/deviations.md` 未独立登记。按 deviations.md 开头说明（「四、未验证的偏差添加」）的流程，应走偏差添加流程。

---

### G5. 测试覆盖盲点（合并 9 项）

#### G5.1 `test_type_quat.cj` 用例数 30 显著低于 OOD §8.2 计划 ≥40 下限

**分类：其他类型（测试覆盖不足）** + **OOD 文档问题（计划与实现偏差）**

**分析：** OOD §8.2 要求 `test_type_quat.cj` 用例数 ≥40，当前仅 30 个。主要缺口：缺少 fromVec3/fromEuler stub 测试、缺少每个完整实现函数的第二个用例、Quat×Vec3/Vec4/Vec3×Quat/Vec4×Quat 仅有运行时 assertThrows 验证等。

**证据：** `test_type_quat.cj:1-272` 确认 30 个 @Test vs OOD §8.2 要求 ≥40。

---

#### G5.2 `test_trigonometric_stub.cj` 仅覆盖 75 个函数签名中的 16 个

**分类：其他类型（测试覆盖不足）** + **OOD 文档问题（OOD §8.2 允许按类选取代表性函数，但实现未达 OOD 自己也允许的范围）**

**分析：** OOD §8.2 第 9 项允许「每类选取 1 个代表性函数验证」。当前 16 个测试用例覆盖 15 个函数名分组中 14 个仅覆盖标量重载，1 个（sin）覆盖标量 + Vec1。剩余 Vec2/Vec3/Vec4 重载（每个函数名 3 个）共 45 个函数签名未被引用。

---

#### G5.3 `test_scalar_constants.cj` 缺失整数 T 异常路径测试

**分类：其他类型（测试覆盖不足）**

**分析：** OOD §11.5 函数可用性对照表、§3.12 均明确描述 epsilon/pi/cos_one_over_two 对整数类型抛运行时异常（D25 决策）。但 8 个测试用例全部仅覆盖 Float32/Float64 浮点路径，无 `epsilon<Int64>()`/`pi<Int64>()`/`cos_one_over_two<Int64>()` 异常路径测试。

---

#### G5.4 `test_scalar_quat_ops.cj` 缺失 T×Quat 反向运算符与边界用例

**分类：其他类型（测试覆盖不足）**

**分析：** 9 个测试用例的缺失项：T×Quat 反向运算符未独立覆盖、Float32 路径未单独测试、负数除数边界断言不完整（仅测试 x 和 y 分量，未覆盖 z 和 w 分量）。

---

#### G5.5 `test_type_quat.cj` 浮点 round-trip 测试未使用容差

**分类：其他类型（测试鲁棒性风险，非当前功能缺陷）**

**分析：** 3 个 round-trip 测试使用 `@Expect(m == m2, true)` 精确比较。若 S1 因子 2 bug 修复后，浮点累积误差可能达到 1e-15 ~ 1e-16 量级，`==` 精确比较可能失败——尽管实际算法是 1:1 正确的。

---

#### G5.6 `slerp` 4 参数重载（`spin: Bool`）无任何测试

**分类：真实存在（无测试覆盖）** + **其他类型（测试覆盖不足）**

**分析：** `quaternion_common.cj:40` 声明 4 参数 `slerp`。`testSlerpStub` 仅覆盖 3 参数版本，4 参数 stub 版本的运行时行为未被任何测试验证。

---

#### G5.7 `gtc/test_quaternion.cj` 缺少 `mat3Cast`/`mat4Cast`/`quatCast` 重导出的 gtc 命名空间独立测试

**分类：其他类型（测试覆盖不足）**

**分析：** `gtc/quaternion.cj:4` 通过 `public import` 将 detail 的 4 个转换函数重导出至 gtc 命名空间，但 `test_quaternion.cj` 未提供任何 gtc 命名空间下的调用用例。若阶段四误删 `public import` 行，detail 层测试不会捕获，但 gtc 路径调用将编译失败。

---

#### G5.8 `test_vector_relational.cj` 的 16 个 epsilon 测试缺少数值精度多样性

**分类：其他类型（测试覆盖不足）**

**分析：** 16 个 epsilon 测试均使用固定模式，未覆盖：`abs(d) == epsilon` 边界（`equal` 严格小于语义）、`notEqual` 严格大于等于语义边界、不同向量分量的不同 diff 混合情况。

---

#### G5.9 `testInverseZero` 边界条件断言未严格限定 + `testEqualVec1NegativeDiff` 命名与实际不一致

**分类：其他类型（测试质量问题）** + **误报（testInverseZero 描述不完全准确）**

**分析：**
- `testInverseZero`（`test_quaternion_common.cj:69-73`）：使用 `||` 验证「inv.x 为 Inf 或 NaN」。OOD §3.11 line 780-782 声明浮点四元数 `dot(q,q) == T(0)` 时除以零产生 Inf/NaN 分量。`Float64 0.0/0.0 = NaN`，实际值精确为 `NaN`，不会同时是 `Inf`。测试断言过于宽松——这不是缺陷，只是断言不够精确。
- `testEqualVec1NegativeDiff`（`test_vector_relational.cj:166-172`）：测试输入与 `testEqualVec1ScalarEpsilon` 完全相同，命名暗示测试「negative diff 分支」但函数体无法区分。

**证据：** `test_vector_relational.cj:7-12` vs `166-172` 确认输入完全相同。

---

### G6. `lib.cj` 与 `fwd.cj` 测试覆盖盲点（合并 2 项）

#### G6.1 `test_lib.cj` 未对 OOD §2 列出的全部 20 个 import 逐项验证

**分类：其他类型（测试覆盖不足）**

**分析：** 实际仅测试 17 个用例覆盖 5 个 import 组（Quat、3 个 cast、trigonometric）。遗漏 import 组包括 vector_relational、quaternion_common、quaternion_geometric、quaternion_trigonometric、quaternion_relational、quaternion_transform、quaternion_exponential、scalar_constants、4 个别名文件、matrix_projection/clip_space/transform、gtc.constants、gtc.quaternion。

---

#### G6.2 `lib.cj` 的 import 与 OOD §2「20 个新增 import 清单」存在结构偏差

**分类：OOD 文档问题（文档描述与实现不一致）** + **其他类型（功能等价）**

**分析：** 与 OOD §2 逐项对照存在 4 处偏离：① 省略 `Quat` 的 public import（有注释说明原因）。② trigonometric 按符号名导入而非按包名导入（因 `trigonometric.cj` 声明 `package glm.detail` 同包，`glm.detail.trigonometric` 无法解析）。③ 14 个 `import glm.ext.*` 用单条通配符导入。④ 3 个 `import glm.gtc.*` 用单条通配符导入。合计 20 条 OOD 显式条目被压缩为 5 条 import 语句。功能等价，但偏离 OOD 文本描述。

---

## 汇总

### 分类统计

| 分类 | 计数 | 涉及项 |
|------|------|--------|
| **真实存在（实现偏差）** | 12 项（含部分） | S1(1), S2(0.5), G1.1(1), G1.2(1), G1.3(0.5), G1.4(1), G1.5(1), G2.1(1), G2.2(0.5), G2.3(1), G3.1(1), G3.5(1), G3.6(1), G3.8(1), G5.6(0.5) |
| **误报（实际实现正确）** | 1 项（部分）| G1.6 中「sqrtT 未在任何地方被调用」描述不准确；G5.9 中 testInverseZero 断言过于宽松 |
| **OOD 文档问题** | 9 项（含部分） | S2(0.5), G1.3(0.5), G2.2(0.5), G3.7(0.5), G3.9(0.5), G4.2(1), G4.3(1), G4.4(1), G5.1(0.5), G5.2(0.5), G6.2(1) |
| **其他类型** | 24 项 | G1.6(代码质量), G1.7(可优化), G1.8(注释), G2.4(重复), G2.5(风格), G2.6(const), G3.2(风格), G3.3(意图表达), G3.4(注释), G3.7(0.5 行数), G3.9(0.5 public import), G4.1(简化), G5.1(0.5 测试覆盖), G5.2(0.5 测试覆盖), G5.3(测试覆盖), G5.4(测试覆盖), G5.5(测试鲁棒性), G5.6(0.5 测试覆盖), G5.7(测试覆盖), G5.8(测试覆盖), G5.9(测试质量), G6.1(测试覆盖) |

> **计数说明：** 因多项跨分类（如 S2 同时包含真实存在 + OOD 文档问题），采用「部分计数」方式（每项的完整分类权重为 1，拆分为 0.5 + 0.5 等）。总计 4 严重 + 38 一般 = 42 项。

### todo.md 条目编号到报告章节映射

| todo.md 编号 | 报告章节 | 主要分类 |
|-------------|---------|---------|
| S1 | §S1 | 真实存在 |
| S2 | §S2 | 真实存在 + OOD 文档问题 |
| S3 | §S3 | 真实存在（测试覆盖不足） |
| S4 | §S4 | 真实存在（测试覆盖不足） |
| G1.1 | §G1.1 | 真实存在 |
| G1.2 | §G1.2 | 真实存在 |
| G1.3 | §G1.3 | OOD 文档问题 + 真实存在 |
| G1.4 | §G1.4 | 真实存在 |
| G1.5 | §G1.5 | 真实存在 |
| G1.6 | §G1.6 | 其他类型 |
| G1.7 | §G1.7 | 其他类型 |
| G1.8 | §G1.8 | 其他类型 |
| G2.1 | §G2.1 | 真实存在 |
| G2.2 | §G2.2 | 真实存在 + OOD 文档问题 |
| G2.3 | §G2.3 | 真实存在 |
| G2.4 | §G2.4 | 其他类型 |
| G2.5 | §G2.5 | 其他类型 |
| G2.6 | §G2.6 | 其他类型 |
| G3.1 | §G3.1 | 真实存在 |
| G3.2 | §G3.2 | 其他类型 |
| G3.3 | §G3.3 | 其他类型 |
| G3.4 | §G3.4 | 其他类型 |
| G3.5 | §G3.5 | 真实存在 |
| G3.6 | §G3.6 | 真实存在 |
| G3.7 | §G3.7 | 其他类型 + OOD 文档问题(部分) |
| G3.8 | §G3.8 | 真实存在 |
| G3.9 | §G3.9 | 其他类型 + OOD 文档问题(部分) |
| G4.1 | §G4.1 | 其他类型 |
| G4.2 | §G4.2 | OOD 文档问题 |
| G4.3 | §G4.3 | OOD 文档问题 |
| G4.4 | §G4.4 | OOD 文档问题 |
| G5.1 | §G5.1 | 其他类型 + OOD 文档问题 |
| G5.2 | §G5.2 | 其他类型 + OOD 文档问题 |
| G5.3 | §G5.3 | 其他类型 |
| G5.4 | §G5.4 | 其他类型 |
| G5.5 | §G5.5 | 其他类型 |
| G5.6 | §G5.6 | 真实存在 + 其他类型 |
| G5.7 | §G5.7 | 其他类型 |
| G5.8 | §G5.8 | 其他类型 |
| G5.9 | §G5.9 | 其他类型 + 误报(部分) |
| G6.1 | §G6.1 | 其他类型 |
| G6.2 | §G6.2 | OOD 文档问题 + 其他类型 |

### 修复优先级建议

| 优先级 | 问题编号 | 理由 | 文件级依赖关系 |
|--------|---------|------|--------------|
| **Blocker** | S2 | 300+ @Test 全部静默跳过，所有测试结果不可信，影响后续所有修复验证 | `cjpm.toml` → 测试文件命名重构 |
| **Blocker** | S1 | 最严重功能缺陷，quatCast 返回值错误，影响所有 round-trip 场景 | `type_quat_cast.cj`（与 G1.5、G1.6、G1.7、G2.3 同文件） |
| **High** | G2.1 | API 签名层面错误（`spin: Bool` vs `k: Int64`），将阻塞阶段四完整实现 | `quaternion_common.cj` |
| **High** | S3 | 测试设计缺陷导致 S1 无法被捕获，需先修复测试才能验证 S1 修复 | `test_type_quat_cast.cj`（测试依赖 S1 修复结果） |
| **High** | G2.3 | 项目级一致性问题，跨 3 个文件违反 OOD §1 方案 A | `type_quat_cast.cj`, `quaternion_geometric.cj`, `quaternion_trigonometric.cj` |
| **Medium** | G2.2 | 约束过宽，但阶段四才触发编译失败 | `quaternion_common.cj` |
| **Medium** | G1.1, G1.2, G1.4, G1.5 | OOD 实现偏差，当前仅影响 const 可用性和代码风格 | `type_quat.cj`, `type_quat_cast.cj` |
| **Medium** | G3.5, G3.6, G3.8 | 版本控制/构建脚本/编译警告问题 | 独立 |
| **Medium** | G5.3, G5.4, G5.5, G5.6, G5.7 | 测试覆盖缺口，降低回归检测能力 | 独立（各测试文件） |
| **Low** | G1.6, G1.7, G1.8, G2.4, G2.5, G2.6 | 代码质量/风格/注释优化建议 | 独立 |
| **Low** | G3.2, G3.3, G3.4, G3.7, G3.9 | 风格/注释/文档与实现细微偏差 | 独立 |
| **Low** | G4.1, G4.3 | 实现简化/文档更新 | `scalar_constants.cj` |
| **Low** | G5.1, G5.2, G5.8, G5.9, G6.1 | 测试增强建议 | 各测试文件 |
| **Low** | G4.2, G4.4, G6.2 | OOD 文档/偏差登记维护 | `docs/deviations.md`, `docs/05_ood_phase3.md` |

> **特别说明：** S2 列为 Blocker 的理由是：在当前状态下，所有测试结果均不可信（300+ @Test 静默跳过），导致任何修复（包括 S1）的正确性无法通过 `cjpm test` 验证。S1 虽为最严重功能缺陷，但在 S2 未修复前，S1 修复无法被测试验证。**S2 应为最高优先级**。S1 与 G2.3 均涉及 `type_quat_cast.cj` 的 `sqrtT` 函数（S1 需修改算法逻辑，G2.3 需重构 sqrt 调用策略），修复时需注意冲突——建议先处理 S1 算法修复，再在后续独立重构 sqrtT。

**关键发现汇总：**
1. **S1（quatCast 因子 2 bug）** 是最严重的功能缺陷，影响所有四元数-矩阵互转的 round-trip 行为。
2. **S2（测试文件不被发现）** 导致 300+ @Test 静默跳过，所有测试结果不可信，列为最高优先级 blocker。
3. **G2.1（slerp spin: Bool vs k: Int64）** 是 API 签名层面的严重设计偏差，将阻塞阶段四的完整实现。
4. **G2.3（sqrtT Float64 中转）** 是违反 OOD §1 方案 A 的项目级一致性问题，跨 3 个文件。
5. 大多数一般问题属于**测试覆盖不足**或**代码可优化**类别，不构成功能缺陷。
