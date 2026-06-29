# 待办事项

---

## 严重问题（6 项）

### S1. quatCast 算法因子 2 缩放 bug

- **位置**：`cjglm/src/detail/type_quat_cast.cj:51-110`
- **描述**：与 GLM 1.0.3 `references/glm-1.0.3/glm/glm/gtc/quaternion.inl:106-122` 对照分析，仓颉版 `quatCast` 在四个分支（X/Y/Z/W 分量最大）中**对非最大分量的求解都漏除了一个 2 倍因子**，导致返回的四元数（除 w 分量外）整体被错误地缩放 2 倍左右。GLM 源使用 `biggestVal = sqrt(fourBiggestSquaredMinus1 + T(1)) * T(0.5)` + `mult = T(0.25) / biggestVal`，而仓颉版在 W 分支（`type_quat_cast.cj:101-107`）使用 `let v = sqrtT(fourWSquaredMinus1 + one)`（v = 2w）后直接 `x = (m.c1.z - m.c2.y) / v`，由于 `m.c1.z - m.c2.y = M21 - M12 = 4wx`，代入得 `x = 4wx / (2w) = 2x`（应为 x）。X/Y/Z 三个分支（`type_quat_cast.cj:83-100`）使用同样的 `/v` 模式（`v = 2*最大分量`），均差 2 倍因子。以 q = (0, 0, 0, 1) + 90° X 旋转验证：quatCast 返回的 w = 0.707 ✓，但 x ≈ 1.414（应为 0.707）。以 q = (0.2, 0.3, 0.4, 0.8) 非单位四元数 round-trip 验证：`mat3Cast(q)` 得到的矩阵 trace ≈ 1.84，`quatCast` 返回 ≈ (0.38, 0.57, 0.76, 0.84)，约为原 q 的 1.9 倍；进一步 `mat3Cast(quatCast(mat3Cast(q)))` 得到的 M00 ≈ -0.81（原 m.M00 = 0.5），与 m 不等。`fromMat3`/`fromMat4` 工厂函数（`type_quat.cj:74-80`）均直接调用同函数，GLM 1:1 行为契约被破坏——任何调用方在 round-trip 中都会得到错误的四元数。本应作为「真完整实现」的 4 个函数之一（OOD §1 表 18 个函数之列），但实际行为与 GLM 不一致。

### S2. tests/ 目录下测试文件不被 cjpm test 发现执行（合并 detail + fwd/lib 两处发现）

- **位置**：
  - `cjglm/tests/glm/detail/test_type_quat.cj`（30 @Test）
  - `cjglm/tests/glm/detail/test_type_quat_cast.cj`（8 @Test）
  - `cjglm/tests/glm/detail/test_scalar_constants.cj`（8 @Test）
  - `cjglm/tests/glm/detail/test_scalar_quat_ops.cj`（9 @Test）
  - `cjglm/tests/glm/detail/test_trigonometric_stub.cj`（16 @Test）
  - `cjglm/tests/glm/test_fwd.cj`（70 @Test）
  - `cjglm/tests/glm/test_lib.cj`（38 @Test）
  - `cjglm/tests/glm/ext/*.cj`（5 文件 53 @Test）
  - `cjglm/tests/glm/gtc/*.cj`（2 文件 68 @Test）
- **描述**：`cjpm.toml:8-9` 虽配置 `[test] src-dir = "tests"`，但 cjpm 1.1.0 工具链仅识别 `src/**/*_test.cj`（以下划线 `_test.cj` 为后缀）的测试文件。`tests/` 目录下的 `test_*.cj` 前缀命名是项目自定义约定，不被 cjpm 工具链识别。`docs/03_ood_phase1.md:148` 声称「此完整配置确保 `cjpm test` 可正确发现位于 `tests/glm/detail/` 和 `tests/glm/` 目录下的 `@Test` 标注测试用例」与 cjpm 1.1.0 实际行为不符。实测 `cjpm test` 输出 `Summary: TOTAL: 422`，全部来自 `src/detail/*_test.cj`（13 个文件，sum=422）；`tests/` 目录下 300+ `@Test` 一个都不执行。本轮审查的 5 个 detail 测试文件 + test_fwd.cj + test_lib.cj + ext/gtc 子目录测试**全部静默跳过**，相当于「编译通过但运行空跑」状态。R1-Agent2 报告的「`test_type_quat_cast.cj` 未被 cjpm test 发现」严重问题未修复。

### S3. `test_type_quat_cast.cj` 仅依赖 round-trip 测试，无法捕获 quatCast 因子 2 缩放算法 bug

- **位置**：`cjglm/tests/glm/detail/test_type_quat_cast.cj:18-25`、`46-53`、`56-62`、`64-75`、`77-84`、`86-93`
- **描述**：8 个测试用例中 7 个采用 round-trip 形式 `mat3Cast(quatCast(M)) == M` 或 `mat4Cast(quatCast(M)) == M`，仅 `testMat3CastIdentityQuat`（行 4-16）和 `testMat4CastIdentityQuat`（行 27-44）使用了**逐元素**直接验证。但这 7 个 round-trip 测试**无法捕获** quatCast 因子 2 缩放 bug（`cjglm/src/detail/type_quat_cast.cj:51-110`）——该 bug 的特征是 quatCast 返回的 4 个分量整体被错误放大 ~2 倍，但 round-trip 中 `mat3Cast(quatCast(M))` 仍可能内部一致地返回 `M`（取决于具体数值），导致 bug 在 CI 中长期不被捕获。具体反例：取 `q0 = (0.2, 0.3, 0.4, 0.8)`，`m = mat3Cast(q0)`，`q1 = quatCast(m)`，如果 quatCast 返回 `(0.38, 0.57, 0.76, 0.84)`（约为 q0 的 1.9 倍，符合因子 2 缩放 bug），则 `mat3Cast(q1)` 由于 `length²=1` 不再保持（与 q0 不等长），结果矩阵 `m2` 与 `m` 存在 ~10% 偏差。OOD §8.2「§11.5 浮点比较策略」段明确推荐「**type_quat_cast 单元测试**——使用「旋转矩阵 * 向量 = 四元数 * 向量」等价性测试（`m3 * v == q * v`）验证互转正确性」，但 8 个用例中**无一条**采用该等价性测试。

### S4. ULP stub 测试覆盖严重不完整——8 个 stub 函数中仅 1 个被测试覆盖

- **位置**：`cjglm/tests/glm/ext/test_vector_relational.cj:175-178`（仅 `testEqualULPStub`）
- **描述**：根据 `cjglm/src/ext/vector_relational.cj:197-251` 实现，ULP 版本的 stub 函数总计 8 个（equal/notEqual × Vec1/Vec2/Vec3/Vec4 × Int64/VecN-Int64 参数形态 = 32 个组合，stub 函数 8 个）。当前 `testEqualULPStub`（line 175-178）仅覆盖 `equal(x: Vec1<Float64, Defaultp>, y: Vec1<Float64, Defaultp>, ULPs: Int64)` 一个组合，覆盖率 **1/32 = 3.125%**。**实际未覆盖**：`notEqual` ULP 版本（4 重载 × 2 参数形态 = 8 个 stub）、`equal` ULP 在 Vec2/Vec3/Vec4 的 6 个 stub 重载、`equal` ULP 在 Vec1/2/3/4 的 `VecN<Int64, Q>` 参数形态（4 个 stub 重载）、`notEqual` ULP 在 Vec1/2/3/4 的 `VecN<Int64, Q>` 参数形态（4 个 stub 重载）。阶段四补齐 ULP 实现时，如实现者误改 `notEqual` ULP 签名为 `throw Exception("stub")` 之外的形态或类型参数变化，`cjpm test` 不会捕获到编译期回归。

---

## 一般问题（按主题分组，42 项）

### G1. Quat 类型层设计偏差（合并 8 项）

#### G1.1 跨 Qualifier 构造函数 `init<Q2>` 缺失
- **位置**：`cjglm/src/detail/type_quat.cj:56-64`
- **描述**：OOD §3.3 item 3 明确要求「**跨 Qualifier 构造 `init<Q2>(q: Quat<T,Q2> where Q2 <: Qualifier)`**——跨 Qualifier 同类型构造，纯赋值」。但实现中**未提供该 `init` 构造函数**，而是在 extend 块中提供静态工厂 `fromQual<Q2>(q: Quat<T, Q2>): Quat<T, Q> where Q2 <: Qualifier`（第 61-63 行）。调用方无法使用 OOD 承诺的 `Quat<Float32, Highp>(q_of_PackedHighp)` 构造语法，必须改写为 `Quat<Float32, Highp>.fromQual(q_of_PackedHighp)`。静态工厂无法在 `const` 上下文使用。

#### G1.2 `Vec3×Quat` / `Vec4×Quat` 实现路径与 OOD §3.4 不一致
- **位置**：`cjglm/src/detail/type_quat.cj:140-152`
- **描述**：OOD §3.4「Vec extend 块成员运算符」段明确要求 `Vec3×Quat` / `Vec4×Quat` 的实现为「`(conjugate(q) / dot(q, q) * v`」（**v18 内联逆四元数计算路径消除包间循环依赖**），最终通过同包 `Quat×Vec3` 运算符完成旋转从而**传播 stub 异常**。实现中两处函数体均为「`throw Exception("stub")`」（第 143、150 行），直接抛出 stub 而**未实现** OOD 承诺的 `conjugate(q) / dot(q, q) * v` 调用链。端到端运行时行为相同（均抛 stub），但实现路径偏离 OOD 设计意图。阶段四补齐时需重新编写函数体（从「直接 throw」改为「计算 + 委托 `Quat×Vec3`」）。

#### G1.3 `fromMat3` / `fromMat4` 约束签名与 OOD §3.3 item 6/7 偏差
- **位置**：`cjglm/src/detail/type_quat.cj:73-81`
- **描述**：OOD §3.3 item 6 / item 7 明确规定 `fromMat3` / `fromMat4` 的签名为「`where T <: FloatingPoint<T>, Q <: Qualifier`」，但实现使用「`where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier`」（第 73 行）。该偏差**编译期必需**——`type_quat_cast.cj:65, 69, 73` 中 `quatCast` 实现需通过比较 `fourXSquaredMinus1 > fourBiggest` 等 `>` 运算找出最大元素，要求 `T` 实现 `Comparable<T>` 接口；当前 `fromMat3` / `fromMat4` 透传调用 `quatCast`（`type_quat.cj:75, 79`）因此必须满足被调方的约束。OOD 文档与 `type_quat_cast.cj` 实现未同步，OOD §3.3 item 6/7 与 OOD §3.2.1 `quatCast` 签名也仅写 `FloatingPoint<T>`，实际 `quatCast` 实现需要 `Comparable<T>`，实现与 OOD 文档两侧均需更新。

#### G1.4 `init(s: T, v: Vec3<T, Q>)` 未声明为 `const`
- **位置**：`cjglm/src/detail/type_quat.cj:20-25`
- **描述**：OOD §3.3 item 2 明确要求「**标量+向量构造 `const init(s: T, v: Vec3<T,Q>)`**」。但实现为 `public init`（第 20 行，无 `const` 修饰符）。与主构造函数 `const init(x: T, y: T, z: T, w: T)`（第 13 行）的不对称性导致 `const val q = Quat<Float32, PackedHighp>(0.0f, v)` 在阶段三编译期失败。函数体仅访问 `v.x`/`v.y`/`v.z` 公开字段与赋值，**完全 const 可调用**。

#### G1.5 `mat4Cast` 中 `one - one` 零获取路径与 OOD §1 字面量替代策略偏差
- **位置**：`cjglm/src/detail/type_quat_cast.cj:30`
- **描述**：OOD §1「常量型 T(n 字面量替代」段明确指出 `mat3Cast`/`mat4Cast` 转换函数中初始化 3×3/4×4 矩阵非对角线元素应使用 `T(Float64(0))` 字面量替代路径。本实现 `mat4Cast` 函数体中 `let zero: T = one - one`（line 30）仍采用 `one - one` 演算路径获取 0 值，**违反** OOD §1 显式约束。OOD §1 明确将该模式限制为「**仅在 `identity(one)` 等显式携带 `one: T` 形参的函数中保留**」并特别说明 `mat3Cast`/`mat4Cast` 是 T(0) 字面量替代的「**系统性覆盖**」目标函数。

#### G1.6 `sqrtT` 与 `zeroOrOne` 私有工具函数的设计可优化（合并 3 项）
- **位置**：`cjglm/src/detail/type_quat_cast.cj:122-130`
- **描述**：① `sqrtT<T>(x: T): T where T <: FloatingPoint<T>`（line 122-125）通过 `Float64` 中转实现 `T` 类型 sqrt，**未在任何地方被调用**——`grep -n "sqrtT" cjglm/src/detail/type_quat_cast.cj` 仅显示该函数定义行，无调用方，是死代码。② `zeroOrOne<T>(one: T): T where T <: Number<T>`（line 127-129）命名反直觉——`one` 形参减去自身得 `zero`，但函数名暗示「zero or one」结果歧义；其实际唯一作用是返回 `0`。③ `quatCast` 函数体内 `var x: T = zeroOrOne(one)` 等 4 行（line 78-81）显式初始化为 `zeroOrOne(one)` 是为了规避仓颉「`var` 必须初始化」约束，但与「每个分支均覆盖」的代码语义有冗余。

#### G1.7 quatCast 内部 `var` + 多次 `if` 重新赋值的控制流可优化
- **位置**：`cjglm/src/detail/type_quat_cast.cj:62-76`
- **描述**：通过 `var fourBiggest` 配合 3 个 `if (... > fourBiggest)` 串行比较求解最大分量及对应索引，控制流使用 `var` + 多次条件赋值。GLM 原版使用相同模式，可读性尚可，但仓颉侧可考虑使用 `match` 表达式或 `let (biggestVal, biggestIndex) = maxOf4(...)` 元组解构模式。当前实现是 GLM 直译版本，符合 OOD §1 决策 D11/D32 的「消除包间循环依赖」设计意图。

#### G1.8 `quatCast(Mat4x4)` 依赖列布局假设 `c0/c1/c2` 与 `c3` 行为预期的一致性需文档说明
- **位置**：`cjglm/src/detail/type_quat_cast.cj:112-120`
- **描述**：`quatCast(Mat4x4)` 手动构造 `Mat3x3` 子矩阵，假设 Mat4x4 的 `c0/c1/c2` 三列对应左上 3×3 旋转块（与 GLM `type_quat.inl` 的隐式 Mat3x3(Mat4x4) 转换一致）。OOD §3.2.1「`fromMat4` 工厂函数」段已明确该列提取模式，但建议在函数体内添加一行注释说明该列提取依据，有助于后续维护。

### G2. ext/ 函数库层实现偏差（合并 6 项）

#### G2.1 `slerp` 4 参数版本 `spin: Bool` 与 OOD §3.11 / D22 决策 `k: Int64` 显著偏离
- **位置**：`cjglm/src/ext/quaternion_common.cj:40`
- **描述**：OOD §3.11 line 791、D22 决策（line 1703）、§11.5 函数可用性对照表（line 2212）三处明确声明 `slerp` 4 参数版本采用「**`slerp<T, Q>(x: Quat<T,Q>, y: Quat<T,Q>, a: T, k: Int64)` 简化版签名**」。GLM 1.0.3 原始 `slerp(x, y, a, k)` 使用独立泛型 `S` 配合 `GLM_STATIC_ASSERT(std::numeric_limits<S>::is_integer, ...)` 约束接受任意整数类型。**实现采用 `spin: Bool`（第 40 行），与上述 OOD 三处承诺及 GLM 原始设计均不一致**：① 语义错误——`Bool` 类型在仓颉 stdlib 中**不实现** `Integer<Bool>` 接口，阶段四按 GLM `phi = angle + k * pi<T>()` 公式实现时，`k * pi<T>()` 的 `*` 运算符需要 `Number<T>` 接口，Bool 不实现 `Number<Bool>` 将编译失败。② 取值域错位——`Bool` 仅能取 `true`/`false`（0/1），无法表达 GLM 允许的「3 整圈旋转」（`k = 3`）等多圈场景。③ 命名歧义——`spin` 在 GLM 习惯中为「自旋标志」，GLM `slerp` 第 4 形参为「整圈数 k」，命名为 `k` 体现「整圈数」语义；命名为 `spin` 与 GLM 命名风格不一致。

#### G2.2 `mix` / `lerp` 约束较 GLM `is_iec559` 静态断言过宽（合并 2 项）
- **位置**：`cjglm/src/ext/quaternion_common.cj:16-17`（lerp）、`34-35`（mix）
- **描述**：GLM 1.0.3 对 `lerp`/`mix` 函数使用 `GLM_STATIC_ASSERT(std::numeric_limits<T>::is_iec559, ...)`——明确限定为浮点类型。实现 `mix` 采用 `where T <: Number<T>, Q <: Qualifier`（第 34-35 行）；`lerp` 采用 `where T <: Number<T> & Comparable<T>`（第 17 行）。`Number<T>` 在仓颉 stdlib 中由 `Integer<T>` 与 `FloatingPoint<T>` 共同实现，**允许**整数类型实例化。语义上 `mix`（球面插值 / 角度内插退化）需要 `acos`/`sin` 等三角函数（均为 `FloatingPoint<T>` 约束），整数 T 实例化将无法在阶段四补齐时编译通过，需届时回退收紧约束——与 OOD §1 对「类型约束一旦放宽收紧易触发 API 形态偏差扩大」的告诫一致。

#### G2.3 `length` / `sqrtT` Float64 中转包装偏离 OOD §1 方案 A「直接调用」策略（合并 3 处文件）
- **位置**：`cjglm/src/ext/quaternion_geometric.cj:5-8, 17` + `cjglm/src/ext/quaternion_trigonometric.cj:5-8, 18` + `cjglm/src/detail/type_quat_cast.cj:122-125`
- **描述**：OOD §1「Float32 与 std.math 的交互约束」段 + §3.7 line 716 明确说明 `std.math.sqrt` 提供 Float16/Float32/Float64 三种重载，T=Float32 实例化时**应直接调用** `std.math.sqrt(dot_qq)` 利用 Float32 重载（**方案 A 推荐**）。实现却定义私有 `sqrtT<T>(x: T): T where T <: FloatingPoint<T>` 工具函数，通过 `Float64` 中转——`(x as Float64).getOrThrow()` → `sqrt(x64)` → `(sqrt(x64) as T).getOrThrow()`——所有 T 实例化路径均**强制**走 Float64 中转，违反 OOD §1 方案 A 策略。该模式是**项目级一致性偏差**而非单文件遗漏，跨 `quaternion_geometric.cj` + `quaternion_trigonometric.cj` + `type_quat_cast.cj` 共 3 处。

#### G2.4 abs 内联模式重复 16 次，未抽取为包内私有辅助函数（合并 2 项）
- **位置**：
  - `cjglm/src/ext/vector_relational.cj:9, 16, 23, 30, 39, 50, 61, 72, 85, 98, 111, 124, 139, 154, 169, 184`（共 16 处）
  - `cjglm/src/ext/quaternion_relational.cj:15-28, 30-43`（共 2 处）
- **描述**：每个 epsilon 重载内部都重复 `let zero = (Float64(0) as T).getOrThrow(); let d = x.x - y.x; (if (d >= zero) { d } else { -d }) < epsilon` 模式。16 个重载对应 16 段相同字面代码，显著增加维护成本。`quaternion_relational.cj` 也使用与 `vector_relational.cj` 完全相同的内联 abs 模式，两文件均位于 `glm.ext` 包，未抽取共享的内部辅助函数。

#### G2.5 阶段一 `equalEpsilon` 与阶段三 `equal` epsilon 重载的约束风格不一致
- **位置**：
  - 阶段一：`cjglm/src/detail/type_vec3.cj:152-154` 使用 `T <: Number<T> & Equatable<T> & Comparable<T>`
  - 阶段三：`cjglm/src/ext/vector_relational.cj:7-8, 14-15, ...` 使用 `T <: Number<T> & Comparable<T>`（无 `Equatable<T>`）
- **描述**：阶段一 `equalEpsilon` 通过 `ComputeEqualNumeric<T>.callConst` 委托，内部需要 `==` 比较（要求 `Equatable<T>`）；阶段三 `equal` epsilon 重载使用原始 `<` 比较（不依赖 `Equatable<T>`），因此无需 `Equatable<T>` 约束。两者**逻辑上都正确**且与各自实现一致，但项目内部存在两种「epsilon 比较」约束模板——阶段一要求 `Equatable<T>`、阶段三不要求——可能给读者造成理解困惑。

#### G2.6 epsilon 重载未声明 `const func`
- **位置**：`cjglm/src/ext/vector_relational.cj:7, 14, 21, 28, 37, 48, 59, 70, 83, 96, 109, 122, 137, 152, 167, 182`（16 个 epsilon 重载）
- **描述**：epsilon 重载是自由函数（不是 extend 块成员），与阶段一 `equalEpsilon`（DV-05 描述的 extend 块函数不可 const）不同，**理论上**可声明 `const func`。函数体仅包含 `let` 绑定、算术运算 `<` 比较、`Vec1<Bool, Q>(...)` 构造，均为 const 兼容操作（无 `assert`、无 `throw`、无运行时分派 `match`）。`ext/quaternion_relational.cj:15-43` 的 epsilon 重载同样未声明 `const func`，与本文件存在相同的「错失 const 化」机会。阶段一实践依据：阶段一 `cjglm/src/detail/type_vec3.cj:54-80` 已成功声明 27 个 const func（实现模式与本文件 epsilon 重载完全一致）。

### G3. gtc/ 层 + 顶层 API 偏差（合并 9 项）

#### G3.1 `gtc/quaternion.cj` 依赖声明与 OOD §3.15 不一致（合并 2 项）
- **位置**：`cjglm/src/gtc/quaternion.cj:1-4`
- **描述**：OOD §3.15 line 1274-1279 明确声明 `gtc/quaternion.cj` 的依赖包括 `import glm.ext.vector_relational.*`（引用 `equal`，用于 roll/pitch 的 equal(vec2, vec2, 0) 边界检测）和 `import glm.ext.scalar_constants.*`（引用 epsilon<T>()）。当前实现（line 1-4）仅含 `package glm.gtc` + `import glm.detail.*` + `import std.math.FloatingPoint` + `public import glm.detail.{mat3Cast, mat4Cast, quatCast}`。**缺失** `import glm.ext.vector_relational.*` 和 `import glm.ext.scalar_constants.*` 两项。当前实现可编译通过，因 7 个 stub 函数体均为 `throw Exception("stub")`，未实际引用 `equal` / `epsilon<T>()`，但 OOD 明文规定这两项为预期依赖，阶段四实现 `roll`/`pitch` 函数体时需再次修改本文件。

#### G3.2 `gtc/quaternion.cj` 的 4 个比较函数 Vec4 构造调用缺少显式类型参数
- **位置**：`cjglm/src/gtc/quaternion.cj:8, 12, 16, 20`
- **描述**：4 个比较函数实现统一采用 `Vec4(x.x < y.x, x.y < y.y, x.z < y.z, x.w < y.w)` 形式（无显式 `<Bool, Q>` 类型参数），依赖编译器从返回类型 `Vec4<Bool, Q>` 反向推断 Vec4 构造的类型实参。OOD §3.15 line 1242-1245 给出的 4 个比较函数签名模板均使用 `Vec4<Bool, Q>(...)` 显式类型实参。**当前实现与 OOD 模板不完全一致**。

#### G3.3 `gtc/matrix_transform.cj` import 列表未显式声明 OOD §3.13/路线图中的传递依赖
- **位置**：`cjglm/src/gtc/matrix_transform.cj:2-3`
- **描述**：当前文件仅 `import glm.detail.{ Mat4x4, Vec2, Vec3, Vec4, Qualifier }` + `import std.math.FloatingPoint`，未包含 `docs/02_roadmap.md:98` 与 `docs/05_ood_phase3.md:467` 中列出的 6 个传递依赖：`glm.ext.matrix_projection`、`glm.ext.matrix_clip_space`、`glm.ext.matrix_transform`、`glm.detail.trigonometric`、`glm.detail.geometric`、`glm.detail.matrix`。在 stub 形态下，函数体均为 `throw Exception("stub")`，编译不需要这些依赖（已通过 `cjpm build` 隐式验证），但**意图表达**缺失——下游维护者从 import 列表无法直接看出本文件是阶段三中"传递依赖链最广的依赖项"。

#### G3.4 `trigonometric.cj` 头部缺少与 OOD §3.13.1「T 类型约束策略」一致的引用说明
- **位置**：`cjglm/src/detail/trigonometric.cj:1-4`
- **描述**：当前文件头注释为空白，无任何关于约束策略的依据引用。OOD §3.13.1 第 1016 行明确指出 `where T <: FloatingPoint<T>` 约束是"阶段四完整实现前的必备前置项"——若不在 stub 阶段约束 T 为浮点类型，阶段四 stub 替换为 `std.math.{func}` 调用时，整数 T 实例化将报 `std.math.{func}(Int64)` 不存在错误。当前文件中所有 75 个签名均已正确应用该约束（标量用 `where T <: FloatingPoint<T>`，向量用 `where T <: FloatingPoint<T>, Q <: Qualifier`），但缺少注释说明该约束是 OOD 设计决策而非偶然选择。

#### G3.5 `fwd.cj.bak` 备份文件包含 OOD 明确禁止的错误变体
- **位置**：`cjglm/src/fwd.cj.bak:330-332`
- **描述**：备份文件残留 OOD §2 明确禁止的 `HighpFQuat`/`MediumpFQuat`/`LowpFQuat` 三个错误别名。OOD §2 验证命令段已明确禁止：`FQuat 家族不应有 HighpFQuat/MediumpFQuat/LowpFQuat 精度变体——与 Vec 家族 FVec* 精度变体命名约定不一致，Quat 家族统一为 HighpQuat/MediumpQuat/LowpQuat`。该 `.bak` 是修复前的快照，被误纳入 git 暂存区（`git status` 显示 `new file: cjglm/src/fwd.cj.bak`）。当前 `fwd.cj`（335 行）已正确不含上述三个错误变体，备份文件不应继续存在于版本控制中。

#### G3.6 `gen_fwd_aliases.py` 在 Windows 上破坏幂等性
- **位置**：`cjglm/scripts/gen_fwd_aliases.py:71`
- **描述**：脚本写入文件时显式指定 `newline='\n'`（LF 行尾）。当前已提交的 `fwd.cj` 使用 CRLF 行尾（Windows 仓库默认）。首次在已提交版本上执行脚本时，会将全部 335 行的行尾从 CRLF 改为 LF，触发 `git diff` 输出 670+ 行变更（实测 `diff` 返回 `1,335c1,335`）。OOD §2 幂等性验证段明确要求再次执行后 `git diff --stat` 应无输出（幂等）。实际测试：脚本对 LF 文件可幂等（`diff -q` 无输出），但对 CRLF 文件不幂等。

#### G3.7 `lib.cj` 行数偏离 OOD 预期（16 行 vs 28 行）
- **位置**：`cjglm/src/lib.cj:1-16`
- **描述**：OOD §2 明确声明「`cjglm/src/lib.cj` 当前**仅 8 行**」「**阶段三新增的 20 个 import 全部追加至 lib.cj 第 9 行起**」，并给出 20 个显式 import 清单。实际 `lib.cj` 仅 16 行（含 1 行 `package glm` + 8 行原有 `public import` + 4 行新增 import + 4 行 Phase 3 注释），原因是实现采用了 `import glm.ext.*` 和 `import glm.gtc.*` 两个通配符导入来合并原本 14 个 ext + 3 个 gtc 的显式 import 清单。功能等价——通配符导入与显式导入覆盖同一组符号；但偏离 OOD 文本「20 个 import」的逐项描述。

#### G3.8 `lib.cj` 触发 17 个 unused import 编译警告
- **位置**：`cjglm/src/lib.cj:12, 14, 16`
- **描述**：`cjpm build` 实际输出 17 条 `unused import` 警告：`glm.detail.sin` / `cos` / `tan` / `asin` / `acos` / `atan` / `atan2` / `sinh` / `cosh` / `tanh` / `asinh` / `acosh` / `atanh` / `radians` / `degrees`（15 个）+ `glm.ext.*`（1 个）+ `glm.gtc.*`（1 个）。这些 `import`（非 `public`）仅服务于将 ext/gtc 符号引入 `glm` 包作用域以便 lib.cj 内部引用，但 lib.cj 自身并不调用这些符号，因此编译器判定为未使用。

#### G3.9 `lib.cj` 缺少 OOD §2 指定的 `Quat` 的 public import（合并 2 项）
- **位置**：`cjglm/src/lib.cj:10`
- **描述**：OOD §2 line 304 明确写「`public import glm.detail.{Quat, mat3Cast, mat4Cast, quatCast}` — 四元数类型 + 转换函数」，实际 `lib.cj:10` 仅 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}`，**未导入 `Quat`**。当前能编译通过是因为 `tests/glm/test_lib.cj:252,259` 使用 `Quat<Float64, Defaultp>(...)` 语法时，Cangjie 编译器将 `Quat` 解析为 `fwd.cj:327` 的 type alias（`public type Quat = detail.Quat<Float32, PackedHighp>`），再对该 alias 进行 generic-style 实例化——这是 Cangjie 类型别名对泛型目标的「透明再参数化」语义。但严格按 OOD 设计，`Quat` 应当通过 `public import glm.detail.{Quat, ...}` 在 `glm` 命名空间下作为类型公开，而非仅依赖 type alias 的副作用。

### G4. scalar_constants / scalar_quat_ops 设计偏差（合并 4 项）

#### G4.1 `pi<T>()` 与 `cos_one_over_two<T>()` 未利用 `FloatingPoint<T>` 接口的静态方法
- **位置**：`cjglm/src/detail/scalar_constants.cj:10-22`（`pi<T>()`）
- **描述**：标准库 `FloatingPoint<T>` 接口声明 6 个静态方法：`getE()` / `getInf()` / `getPI()` / `getMinDenormal()` / `getMinNormal()` / `getNaN()`。当前 `pi<T>()` 实现（line 10-22）通过 3 次 `hint is FloatXX` 运行时类型分派分别调用 `Float64.getPI()`/`Float32.getPI()`/`Float16.getPI()`，可简化为一行业务逻辑：`public func pi<T>(): T where T <: FloatingPoint<T> { FloatingPoint<T>.getPI() }`。当前实现仅显式处理 3 种类型，运行时分派有额外开销。

#### G4.2 `scalar_constants.cj` 缺少 OOD §3.12 line 805 约定的非浮点类型运行时异常 fallback
- **位置**：`cjglm/src/detail/scalar_constants.cj:5-35`
- **描述**：OOD §3.12 line 805 约定「若仓颉泛型不支持窄约束，则在 `match` 中增加 `case _ => throw Exception("epsilon/pi/cos_one_over_two not defined for non-floating-point types")` 显式错误分支」。当前三个函数均**缺少**该 fallback：`pi<T>()` 三个 `if` 分支均不匹配时**默认 fall-through 至 `Float64.getPI()` 返回**，不抛异常；`cos_one_over_two<T>()` 同样默认 fall-through 至 `Float64(0.877582561890372716)` 返回，不抛异常。当前 `FloatingPoint<T>` 约束已限制 T 仅可为 Float16/Float32/Float64（标准库文档确认 `FloatingPoint<T>` 仅由这三个类型实现），fallback 实际不可触发。**但**：`pi<T>()` 与 `cos_one_over_two<T>()` 对所有 `if` 分支均不匹配的情形（如自定义实现 `FloatingPoint<T>` 的类型）静默返回 Float64 值，与 OOD 契约「非浮点类型抛运行时异常」存在偏差。

#### G4.3 `cos_one_over_two<T>()` 取值与 OOD §3.12「具体类型硬编码」策略不一致
- **位置**：`cjglm/src/detail/scalar_constants.cj:24-35`
- **描述**：OOD §3.12 line 806 明确规定 `pi<T>()` 与 `cos_one_over_two<T>()`「同理使用具体类型硬编码值」——即 `Float32`/`Float64` 应直接返回各自类型的字面量。当前 `pi<T>()` 实现（line 12-21）实际采用 `Float64.getPI()`/`Float32.getPI()`/`Float16.getPI()` 静态方法而非硬编码字面量，与 OOD 描述偏差。**判断**：`pi<T>()` 实际调用 `FloatingPoint<T>.getPI()` 接口是**更优实现**（标准库对每个类型已精度调优）。`cos_one_over_two<T>()` line 27/30/33 的字面量 `0.877582561890372716` 是 GLM `cos(0.5 rad)` 的精确值，符合 OOD 描述。偏差性质：实现优于 OOD 设计文档，但与文档字面承诺不一致。

#### G4.4 `scalar_quat_ops.cj` 与 GLM 习惯的「交换律覆盖」偏差未在 deviations.md 登记
- **位置**：`cjglm/src/detail/scalar_quat_ops.cj:1-27`（整文件）
- **描述**：本文件实现 `T + Quat` / `T - Quat` / `T * Quat` / `T / Quat` 四个全局具名函数，对应 GLM 的四元数运算符覆盖。OOD §3.11 line 660 已明确说明此偏差——「标量×四元数乘法无需单独『交换律别名』函数，`T * Quat`（左操作数为 T）由于仓颉运算符重载规则必须通过全局函数 `mul<T, Q>(s: T, q: Quat<T, Q>)` 实现」。实现严格符合 OOD §3.11 line 651-660 表格规范，且 OOD 文档已将偏差根因记入正文，但偏差未在 `docs/deviations.md` 中独立登记。

### G5. 测试覆盖盲点（合并 9 项）

#### G5.1 `test_type_quat.cj` 用例数 30 显著低于 OOD §8.2 计划 ≥40 下限——缺失 10+ 个用例
- **位置**：`cjglm/tests/glm/detail/test_type_quat.cj:1-272`
- **描述**：OOD §8.2「测试文件清单与位置」段明确列出 `tests/glm/detail/test_type_quat.cj | Quat 核心类型 + 运算符 | ≥40`，并在「用例分配原则」段给出「完整实现函数——每函数 ≥2 个用例」「stub 函数——每函数 ≥1 个用例」原则。当前文件仅含 30 个 `@Test` 函数，距 ≥40 下限**短缺 10+ 用例**。逐项缺口对照（合计 27 函数 / OOD 要求 42 / 文件实际 30 / 缺口 -12）。主要缺口：① 缺少 fromVec3/fromEuler stub 测试；② 缺少每个完整实现函数的第 2 个用例；③ Quat×Vec3/Vec4/Vec3×Quat/Vec4×Quat 仅有运行时 assertThrows 验证，缺编译期引用测试；④ Quat×T 与 T×Quat 缺 add/sub 测试。

#### G5.2 `test_trigonometric_stub.cj` 仅覆盖 75 个函数签名中的 16 个——Vec2/Vec3/Vec4 重载缺编译期验证
- **位置**：`cjglm/tests/glm/detail/test_trigonometric_stub.cj:1-81`
- **描述**：OOD §8.2 第 9 项「编译期函数签名正确性验证」明确要求「覆盖全部 88 个 ❌/⚠️ 函数的编译期签名正确性...对 🚫 / 同构度高的函数组（如 trigonometric.cj 的 75 个函数，**允许每类选取 1 个代表性函数验证**」。「每类」按函数名分组为 15 类（sin/cos/tan/asin/acos/atan/sinh/cosh/tanh/asinh/acosh/atanh/radians/degrees/atan2）。当前文件 16 个测试用例覆盖：**15 个函数名分组中 14 个仅覆盖标量重载，1 个（sin）覆盖了标量 + Vec1 共 2 个重载**。剩余 Vec2/Vec3/Vec4 重载（每个函数名 3 个）共 15 × 3 = 45 个函数签名**未被任何测试用例引用**。若实现者误将 Vec3 版本的签名写为 `Vec4<T, Q>`（笔误）或遗漏 `Q <: Qualifier` 约束，**当前测试集无法捕获**——因为 Vec1 重载通过并不代表 Vec2/3/4 重载通过。

#### G5.3 `test_scalar_constants.cj` 缺失整数 T 异常路径测试（D25 决策）
- **位置**：`cjglm/tests/glm/detail/test_scalar_constants.cj:1-41`
- **描述**：OOD §11.5 函数可用性对照表明确标注：`epsilon（整型） | ❌ 抛异常 | ❌ 抛异常（保持契约） | §3.12；§1 约束：D25 整数 T 抛运行时异常`、`pi（整型） | ❌ 抛异常 | 同上`、`cos_one_over_two（整型） | ❌ 抛异常 | 同上`。OOD §3.12 段落也明确描述「`epsilon<T>`/`pi<T>`/`cos_one_over_two<T>` 对整数类型抛运行时异常（D25 决策）」。但 `test_scalar_constants.cj` 8 个测试用例（行 3-40）**全部仅覆盖 Float32/Float64 浮点路径**，无任何 `epsilon<Int64>()` / `pi<Int64>()` / `cos_one_over_two<Int64>()` 异常路径测试用例。

#### G5.4 `test_scalar_quat_ops.cj` 缺失 T×Quat 反向运算符与边界用例
- **位置**：`cjglm/tests/glm/detail/test_scalar_quat_ops.cj:1-89`
- **描述**：文件覆盖 9 个测试用例（行 3-88）。缺失项：① T×Quat 反向运算符——`type_quat.cj:130-137` 实际声明了 `q * T`（行 130）和 `q / T`（行 135）成员运算符（Quat×T 反向），但本 detail 测试文件未覆盖这 2 个运算符（仅在 `test_type_quat.cj` 中通过 testQuatMulScalar / testQuatDivScalar 覆盖）。② 类型覆盖——8 个 Int64 + 1 个 Float64 + 1 个 Float64（isInf），Int64 占主导。Float32 路径未单独测试。③ 负数除数边界——testScalarDivQuatFloatByZero（行 84-88）仅测试 r.x.isInfinite() 和 r.y.isFinite()，但 `Float64(1.0) / Float64(0.0)` 应返回 `+Inf`（非 `-Inf`），且 r.z = 1/0 也应为 `+Inf`，r.w = 1/2 应为 `0.5`。当前断言仅 2 项，未覆盖 z 分量和 w 分量。

#### G5.5 `test_type_quat.cj` 浮点 round-trip 测试未使用容差——可能掩盖浮点精度问题
- **位置**：`cjglm/tests/glm/detail/test_type_quat.cj:174-199`
- **描述**：`testQuatFromMat3RoundTrip`（行 175-181）、`testQuatFromMat4RoundTrip`（行 184-190）、`testQuatFromMat3NonIdentityRoundTrip`（行 193-199）均使用 `Float64` 类型进行 round-trip 测试，但断言形式为 `@Expect(m == m2, true)`——**直接使用 `==` 精确比较**而非 epsilon 容差比较。unit quaternion round-trip 在理想情况下是精确的，但对 `(0.2, 0.3, 0.4, 0.8)` 非单位四元数 round-trip，quatCast 算法涉及 sqrt + 多次除法 + 多分支判断，浮点累积误差可能达到 1e-15 ~ 1e-16 量级。若 R1-Agent2 报告的因子 2 缩放 bug 修复后，仍可能因浮点精度产生 ~1e-15 量级的 round-trip 偏差，`m == m2` 精确比较**可能失败**——尽管实际算法是 1:1 正确的。这是潜在的「修复后测试报错」风险。

#### G5.6 `slerp` 4 参数重载（`spin: Bool`）无任何测试
- **位置**：`cjglm/tests/glm/ext/test_quaternion_common.cj:97-100`（仅 `testSlerpStub` 覆盖 3-arg 版本）
- **描述**：`cjglm/src/ext/quaternion_common.cj:40-41` 声明 4 参数 `slerp<T, Q>(x, y, a, spin: Bool)` stub。R2 审查（`review_v2.md:24-32`）已识别该参数与 OOD §3.11 line 791 / D22 / §11.5 line 2212 三处声明的 `k: Int64` 显著偏离。`testSlerpStub`（line 97-100）仅覆盖 3 参数 `slerp(x, y, 0.5)`，4 参数 stub 版本的「抛 `Exception("stub")`」运行时行为未被任何测试验证。如果阶段三合并/回滚/二次重构过程中将 `spin: Bool` 修正为 `k: Int64`，缺少 4 参数测试用例不会触发编译错误（仓颉重载规则允许两种签名共存），下游消费者在阶段四迁移时会发现签名变更但测试集不会捕获。

#### G5.7 `gtc/test_quaternion.cj` 缺少 `mat3Cast`/`mat4Cast`/`quatCast` 重导出的 gtc 命名空间独立测试
- **位置**：`cjglm/tests/glm/gtc/test_quaternion.cj`（整文件 91 行）
- **描述**：任务派发明确要求「**4 个重导出（mat3Cast/mat4Cast/quatCast）测试**」。`cjglm/src/gtc/quaternion.cj:4` 通过 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 将 detail 层的 4 个转换函数重导出至 gtc 命名空间，但 `test_quaternion.cj` **未提供任何 gtc 命名空间下的 mat3Cast/mat4Cast/quatCast 调用用例**。`public import` 是否正确将 detail 函数以 `glm.gtc.quaternion.mat3Cast` 路径暴露，无 gtc 层测试用例验证。阶段四修改 `gtc/quaternion.cj` 时如果误删 `public import` 行，detail 层测试不会捕获（仍走 detail 路径），但 gtc 路径 `glm.gtc.quaternion.mat3Cast(q)` 调用将编译失败。

#### G5.8 `test_vector_relational.cj` 的 16 个 epsilon 测试缺少数值精度多样性
- **位置**：`cjglm/tests/glm/ext/test_vector_relational.cj:7-164`
- **描述**：16 个 epsilon 测试用例均使用「`1.0` vs `1.0000001`」（diff = 1e-7）+ epsilon = `1e-5` 或「`1.0` vs `1.1`」（diff = 0.1）+ epsilon = `0.05` 的固定模式，未覆盖：① 不同 epsilon 值的边界——`equal` 函数体内部使用严格小于（`abs(d) < epsilon`），当 `abs(d) == epsilon` 时返回 `false`（与 GLM `glm/gtc/epsilon.inl:32-41` 的 `epsilonEqual` 严格小于语义一致）。当前测试无 `abs(d) == epsilon` 边界用例。② `notEqual` 严格大于等于语义边界——与 `equal` 互补，`abs(d) >= epsilon` 返回 `true`。当前缺乏「`abs(d) == epsilon`」边界（应返回 `true`）。③ 不同向量分量的不同 diff、不同精度的混合。

#### G5.9 `testInverseZero` 边界条件断言未严格限定 Inf/NaN 的具体值 + `testEqualVec1NegativeDiff` 测试命名与实际测试目的字面不一致（合并 2 项）
- **位置**：
  - `cjglm/tests/glm/ext/test_quaternion_common.cj:69-73`
  - `cjglm/tests/glm/ext/test_vector_relational.cj:166-172`
- **描述**：
  - `testInverseZero`（`test_quaternion_common.cj:69-73`）使用 `||` 短路逻辑验证「`inv.x` 为 Inf 或 NaN」，但 OOD §3.11 line 780-782「`inverse` 边界行为契约」明确声明「**浮点四元数 `dot(q,q == T(0)` 时除以零产生 Inf/NaN 分量（与 GLM 行为一致，GLM 不做零除保护**」。由于 `Float64 0.0/0.0 = NaN`（IEEE 754 规定），实际值精确为 `NaN`，**不会**是 `Inf`（`Inf` 由 `1.0/0.0` 产生）。测试断言**过于宽松**。
  - `testEqualVec1NegativeDiff`（`test_vector_relational.cj:166-172`）测试场景为 `x=1.0, y=1.0000001, epsilon=1e-5`，与 `testEqualVec1ScalarEpsilon`（line 7-12）**完全相同**，仅函数名不同。命名暗示测试「negative diff 分支」但函数体无法从该测试输入中区分。注释暗示的设计意图（验证负数路径）与实际行为有偏差，或测试名称未能准确反映用例语义。

### G6. `lib.cj` 与 `fwd.cj` 测试覆盖盲点（合并 2 项）

#### G6.1 `test_lib.cj` 未对 OOD §2 列出的全部 20 个 import 逐项验证
- **位置**：`cjglm/tests/glm/test_lib.cj`
- **描述**：OOD §2 列出 20 个新增 import。test_lib.cj 实际仅直接测试：Quat (1 个 test) + mat3Cast (1 个 test) + quatCast (1 个 test) + 三角函数 15 个（testLibSin/Cos/Tan/Asin/Acos/Atan/Atan2/Sinh/Cosh/Tanh/Asinh/Acosh/Atanh/Radians/Degrees，共 15 个 test）= **17 个测试覆盖 5 个 import 组**（Quat、3 个 cast、trig）。**遗漏 import 组**：glm.ext.vector_relational、glm.ext.quaternion_common、glm.ext.quaternion_geometric、glm.ext.quaternion_trigonometric、glm.ext.quaternion_relational、glm.ext.quaternion_transform、glm.ext.quaternion_exponential、glm.ext.scalar_constants、glm.ext.quaternion_float/double/float_precision/double_precision（4 个别名文件）、glm.ext.matrix_projection/clip_space/transform、glm.gtc.constants、glm.gtc.quaternion。

#### G6.2 `lib.cj` 的 import 与 OOD §2「20 个新增 import 清单」存在结构偏差（合并 4 处偏离）
- **位置**：`cjglm/src/lib.cj:9-16`
- **描述**：与 OOD §2「lib.cj 新增 import 清单」逐项对照，存在 4 处偏离：① OOD §2 line 304 写「`public import glm.detail.{Quat, mat3Cast, mat4Cast, quatCast}`」，实际 `lib.cj:9` 写「`public import glm.detail.{mat3Cast, mat4Cast, quatCast}`」（省略 `Quat`）——lib.cj:9 注释已说明原因——「Quat 类型别名由 fwd.cj 提供，避免名称冲突」（设计取舍正确）。② OOD §2 写「`import glm.detail.trigonometric`」，实际 `lib.cj` 改为按符号名导入 `glm.detail.{sin, cos, tan, ...}`——`trigonometric.cj` 本身声明 `package glm.detail`（同包），并非子包；`glm.detail.trigonometric` 无法解析。③ OOD §2 写 14 个 `import glm.ext.*` 显式条目，实际用单条 `import glm.ext.*` 通配符导入（语义等价）。④ OOD §2 写 3 个 `import glm.gtc.*` 显式条目，实际用单条 `import glm.gtc.*` 通配符导入。合计 20 条 OOD 显式条目被压缩为 5 条 import 语句。
