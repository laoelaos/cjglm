# 诊断报告：TODO Review 问题定位

> 诊断范围：`harness/reviews/202606201155_ood_phase0_code_review/todo.md` 全部 30 项
>
> 参考依据：OOD 设计文档 `docs/02_ood_phase0.md`、实现偏差记录 `docs/deviations.md`、项目代码 `cjglm/`、参考项目 `references/glm-1.0.3`

---

## 诊断结论总览

| 判定类别 | 数量 | 项编号 |
|---------|------|--------|
| **真实存在** | 19 | #3, #8, #9, #10, #11, #12, #14, #15, #16, #17, #19, #21, #22, #24, #25, #26, #28, #29, #30 |
| **误报** | 2 | #2, #27 |
| **OOD文档矛盾/偏差/不完善/错误** | 7 | #1, #4, #5, #6, #13, #18, #20 |
| **双重分类（OOD文档矛盾 + 真实存在）** | 1 | #7 |
| **其他类型问题** | 1 | #23 |

> 注：#7 在 OOD 文档层面因 CL-04（仓颉语言限制）导致设计不可行，同时在编码层面浮点 mod 路径可独立实现但缺失，故双重分类。合计覆盖全部 30 项。

---

## 逐项分析

### 严重级别

#### #1 — fromBoolVec 函数签名与 OOD 设计 §4.8 不一致

- **位置**：`cjglm/src/detail/type_fromBoolVec.cj:3`
- **判定**：**OOD文档矛盾/偏差/不完善/错误**
- **理由**：此偏差已在 `deviations.md` CL-01 中完整记录。根因为仓颉语言限制：无约束泛型参数 T 上不能调用 `T(n)` 构造表达式（`'()' is not a static member of exposed generic parameter 'T'`），添加 `where T <: Number<T>` 也不提供 `()` 构造调用。OOD 设计的 `T(1)/T(0)` 方案在仓颉中不可实现，因此实施阶段被迫将 API 签名变更为增加 `zero: T, one: T` 参数。此偏差非编码错误，而是 OOD 设计假设在仓颉语言约束下不成立的典型案例。
- **关键证据**：`deviations.md:38-40` 记录了 CL-01 的根因和影响

#### #2 — tests/glm/detail/ 下测试文件缺少必要 import

- **位置**：`tests/glm/detail/test_qualifier.cj:1`, `test_setup.cj:1`, 等 6 文件
- **判定**：**误报**
- **理由**：6 个测试文件均声明 `package glm.detail` 并使用 `@Test`/`@Expect`。根据仓颉测试框架行为，`cjpm test` 运行时会自动注入 `std.unittest.*` 及 `std.unittest.testmacro.*` 到测试作用域，因此这些文件在 `cjpm test` 下可正常编译执行。这 6 文件已在项目构建和测试中通过验证（`deviations.md:179-181` 记录 S2~S4 验证全部通过）。缺失显式 import 是代码风格问题（与 `test_fwd.cj`/`test_lib.cj` 不一致的非功能性差异），不导致编译失败，无需修改。

---

### 一般级别

#### #3 — setup.cj: 配置常量使用 `public let` 而非 `public const`

- **位置**：`cjglm/src/detail/setup.cj:3-9`
- **判定**：**真实存在**
- **理由**：OOD 设计 §2 明确指定 `setup.cj`"仅包含 `const` 配置常量"，§2.1 依赖拓扑澄清也重申"`setup.cj` 仅包含 `const` 配置常量"。当前 7 个配置项全部使用 `public let`，但初始化表达式均为字面量（`Int64(1)`、`false`、`Int64(103)` 等），语法上完全可替换为 `public const`。此偏差未在 `deviations.md` 中记录——既非仓颉语言限制，也非设计阶段已知偏差。属编码阶段的疏忽。
- **根因坐标**：`setup.cj:3-9` 中的 `let` 关键字应替换为 `const`
- **修复提示**：将 7 个 `public let` 逐一替换为 `public const`，所有初始值均为合法的 const 表达式
- **副作用**：无。`const` 与 `let` 在初始化表达式完全相同时，运行时行为一致，仅在编译期语义上 `const` 允许更多优化

#### #4 — shim_limits.cj: 函数签名与设计文档不一致

- **位置**：`cjglm/src/detail/shim_limits.cj:5-27`
- **判定**：**OOD文档矛盾/偏差/不完善/错误**
- **理由**：已在 `deviations.md` CL-07 中完整记录。OOD 设计的 `const func isIec559Of<T>(): Bool`（无参数）和 `const func epsilonOf<T>(): T`（无参数）在仓颉中不可实现，因为：(1) `T(0)` const 构造对无约束泛型 T 不可行；(2) 值参数便于编译器做类型推断；(3) `match`/`if` 模式匹配实现需要运行时。`NumericLimits<T>.epsilon(hint: T)` 带 hint 参数的设计也是由于相同的类型推断需求。此偏差是 CL-07 的必然后果。
- **关键证据**：`deviations.md:91-99` 记录 CL-07 的根因和影响

#### #5 — ComputeEqual 结构体设计偏离：`callConst` 被拆分到独立结构体 `ComputeEqualNumeric`

- **位置**：`cjglm/src/detail/compute_vector_relational.cj:5`
- **判定**：**OOD文档矛盾/偏差/不完善/错误**
- **理由**：已在 `deviations.md` CL-08 中完整记录。OOD 设计假设单一 `ComputeEqual<T>` 结构体可通过编译期 `if` 分支抑制实现双路径（浮点容差 vs 精确比较），但仓颉运行时 `if` 的两个分支均需编译通过——浮点路径中的 `a - b`、`epsilonOf(a)` 需要 `Number<T>` 约束，与整数/Bool 类型的无约束需求冲突。因此被迫拆分为 `ComputeEqual<T> where T <: Equatable<T>`（精确比较，`==` 使用）和 `ComputeEqualNumeric<T> where T <: Number<T> & Equatable<T> & Comparable<T>`（浮点 epsilon 容差，`equalEpsilon` 使用）。
- **关键证据**：`deviations.md:101-109` 记录 CL-08 的根因和影响

#### #6 — 所有 20 个包级函数缺少 `const` 修饰符

- **位置**：`scalar_vec_ops.cj:6-103`
- **判定**：**OOD文档矛盾/偏差/不完善/错误**
- **理由**：已在 `deviations.md` CL-02 中完整记录。OOD 设计将所有 scalar-op-vec 方向包级独立函数声明为 `public const func`，但仓颉 `const func` 要求函数体中的所有表达式均为 const 表达式。函数参数 `s`、`v` 在调用处才确定，不满足编译期求值要求，触发 `expected 'const' expression` 错误（编码阶段确认 50 处）。因此所有 20 个函数的 `const` 被移除。
- **关键证据**：`deviations.md:41-49` 记录 CL-02 的根因和影响

#### #7 — `mod` 函数仅实现整数路径，缺少浮点双路径

- **位置**：`scalar_vec_ops.cj:85-103`
- **判定**：**OOD文档矛盾/偏差/不完善/错误** 且部分 **真实存在**
- **理由**：OOD 设计 §4.3 要求 `mod` 通过编译期 `if (isIec559Of<T>())` 分支实现整数/浮点双路径。编码阶段因 CL-04（`Number<T>` 不提供 `%` 运算符，仅 `Integer<T>` 提供）导致 `mod` 函数被约束到 `where T <: Integer<T>`（`deviations.md:61-69`）。此为 OOD 设计假设的偏差。但 OOD 设计的浮点 mod 路径使用 `x - y * trunc(x / y)` 算术恒等式，不依赖 `%` 运算符——此路径理论上可通过 `import std.math.{ trunc }` 独立实现，不受 CL-04 限制。该浮点路径未实施的根因是编码阶段的未完成项（编码阶段未实现浮点 mod 路径）。因此分类为"OOD文档偏差"（CL-04 相关）+ "真实存在"（可行路径的缺失）。
- **根因坐标**：`scalar_vec_ops.cj:85-103` 的 `where T <: Integer<T>` 约束阻止浮点实例化
- **修复前提**：需先确认 `scalar_vec_ops.cj` 中当前 `mod` 的 4 个重载的约束条件，确认无法简单扩展为双路径（因 `Integer<T>` 与 `Number<T>` 约束不能并存于同一 extend 块）。可行的方案是新增 4 个浮点重载（`where T <: Number<T> & Equatable<T> & Comparable<T>`），函数体使用 `import std.math.trunc` 实现 `x - y * trunc(x / y)` 恒等式，并在 `Vec1<T,Q>~Vec4<T,Q>` 上分别实现。需注意 `Float32` 和 `Float64` 的 `trunc` 函数签名，确保精度一致。
- **副作用分析**：新增浮点 `mod` 重载后，(1) 浮点 Vec 可调用 `mod(s, v)`；与整数 `mod` 共存不产生歧义（编译器根据 T 的约束自动选择）；(2) `Float32` 和 `Float64` 的 trunc 精度受 `std.math.trunc` 实现影响，需验证负操作数边界行为；(3) 若 trunc 返回值在极端值（Inf/NaN）下行为特殊，需额外保护

#### #8 — 测试覆盖不够完整

- **位置**：`scalar_vec_ops_test.cj:7-174`
- **判定**：**真实存在**
- **理由**：代码验证确认：
  - 测试仅覆盖 `Int64` 类型的 add/sub/mul/div/mod 五个操作（仅 add 有部分 Float32 测试——`testScalarAddVec2Float32` 和 `testScalarMulVec3Float32`）。todo 原文"仅覆盖 Int64"不准确（已有两处 Float32 测试），但总体上浮点类型的 sub/div/mod 完全未覆盖，其他整数类型（`Int32`、`UInt8` 等）均未覆盖。
  - 溢出 `@OverflowWrapping` 行为未验证
  - 边界值场景缺失（零除由 `testScalarDivVec1Float32ByZero` 和 `testScalarModVec1ByZero` 覆盖部分，但负操作数浮点 mod、Inf/NaN 未覆盖）
- **根因坐标**：`cjglm/src/detail/scalar_vec_ops_test.cj`（该文件实际存在于 `cjglm/src/detail/` 下，todo.md 路径有效，包含第 7~174 行的测试用例定义）
- **修复提示**：需在现有测试文件中追加以下测试用例：
  - 对 `Float32` 和 `Float64` 各追加 `sub`/`div`/`mod` 四个维度的测试用例（约 32 个新测试函数）
  - 对 `Int32`、`UInt8` 各追加 add/sub/mul/div/mod 基础正确性测试（约 40 个新测试函数）
  - 对 `Int64` 追加溢出边界测试：`MAX + 1`、`MIN - 1`、`MAX * 2` 等（标注 `@OverflowWrapping` 验证 wrapping 而非抛异常）
  - 对浮点 mod 追加负操作数边界：`mod(-1.0, 1.0)`、`mod(Inf, 1.0)`、`mod(NaN, 1.0)`

#### #9 — Vec1 缺少跨类型转换构造函数

- **位置**：`cjglm/src/detail/type_vec1.cj:7-12`
- **判定**：**真实存在**
- **理由**：OOD §4.1 要求 Vec1 提供 4 个跨类型转换构造函数：`public init<T2, Q2>(v: Vec1<T2, Q2>)`、`public init<T2, Q2>(v: Vec2<T2, Q2>)`、`public init<T2, Q2>(v: Vec3<T2, Q2>)`、`public init<T2, Q2>(v: Vec4<T2, Q2>)`（均为 `where Q2 <: Qualifier`）。当前代码仅定义了 `public const init(x: T)`，上述 4 个构造函数全部缺失。
- **根因坐标**：`type_vec1.cj:7-12` struct 体内构造函数定义区域

#### #10 — Vec2 缺少跨类型转换构造函数

- **位置**：`cjglm/src/detail/type_vec2.cj:7-54`
- **判定**：**真实存在**
- **理由**：OOD §4.1 要求 Vec2 提供 6 个跨类型/多元组合构造函数。当前仅实现了 `init(scalar: T)`、`const init(x: T, y: T)`、`init(v: Vec1<T, Q>)`（同类型）。缺失清单：
  - `public init<T2, Q2>(v: Vec2<T2, Q2>) where Q2 <: Qualifier`
  - `public init<T2, Q2>(a: Vec1<T2, Q2>, b: T) where Q2 <: Qualifier`
  - `public init<T2, Q2>(a: T, b: Vec1<T2, Q2>) where Q2 <: Qualifier`
  - `public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>) where Q2 <: Qualifier`
  - `public init<T2, Q2>(v: Vec3<T2, Q2>) where Q2 <: Qualifier`
  - `public init<T2, Q2>(v: Vec4<T2, Q2>) where Q2 <: Qualifier`
- **根因坐标**：`type_vec2.cj:7-54` struct 体内构造函数定义区域

#### #11 — 缺少 increment()/decrement() 具名函数

- **位置**：`cjglm/src/detail/type_vec1.cj:95-144`, `type_vec2.cj:92-123`
- **判定**：**真实存在**
- **理由**：OOD §3.2 和 §4.6 要求 `increment()` 和 `decrement()` 具名函数（标注 `@OverflowWrapping`）定义在 `extend<T, Q> VecN<T, Q> where T <: Integer<T>, Q <: Qualifier` 块中。检查 `type_vec1.cj:95-144`（Integer<T> 扩展块）和 `type_vec2.cj:92-123`（Integer<T> 扩展块），二者均未定义这两个函数。
- **根因坐标**：`type_vec1.cj` Integer<T> extend 块末尾（约第 144 行前）、`type_vec2.cj` Integer<T> extend 块末尾（约第 123 行前）

#### #12 — componentAt 缺少 const 标注

- **位置**：`type_vec1.cj:32`, `type_vec2.cj:46`
- **判定**：**真实存在**（但已在 deviations.md CL-10 中记录）
- **理由**：当前签名为 `public func componentAt(i: Int64): T`，OOD §4.2 要求 `public const func componentAt(i: Int64): T`。`deviations.md` CL-10 记录：编码阶段未按设计标注 `const`；因函数体含 `assert` 调用（`assert` 非 `const` 函数），导致 `componentAt` 无法使用 `const`。此偏差使 `componentAt` 无法在 const 上下文中被调用。
- **关键证据**：`deviations.md:121-129` 记录 CL-10
- **修复前提**：需先将 `assert` 调用替换为 const 兼容的等价实现（或内联检查），方可将 `componentAt` 标注为 `const`

#### #13 — `==` 运算符定义在 extend 块中而非 struct 体内

- **位置**：`type_vec1.cj:146-148`, `type_vec2.cj:125-128`
- **判定**：**OOD文档矛盾/偏差/不完善/错误**
- **理由**：已在 `deviations.md` CL-09 中完整记录。OOD §3.2 和 §4.5 要求 `==` 声明为 `const` 函数，但仓颉 `extend` 块不支持 `const` 修饰符。`==` 必须定义在 extend 块中（因为无约束泛型参数不能执行运算符操作——CL-03），因此 `const` 不可用。OOD 的"在 struct 体内定义 `const` `==`"设计假设与 CL-03 冲突——所有运算符已全量迁移至带约束的 extend 块。CL-09 同时影响 `equalExact`——也定义在 extend 块中，非 `const`。
- **关键证据**：`deviations.md:111-119` 记录 CL-09

#### #14 — Vec3/Vec4 缺失跨类型转换构造函数 `init<T2,Q2>`

- **位置**：`type_vec3.cj:12-28`, `type_vec4.cj:13-32`
- **判定**：**真实存在**
- **理由**：OOD §4.1 要求 Vec3 和 Vec4 提供 `public init<T2, Q2>(v: Vec3<T2, Q2>/Vec4<T2, Q2>) where Q2 <: Qualifier`。当前代码仅包含 `init(scalar: T)`、`const init(x, y, ...)`、`init(v: Vec1<T, Q>)`。Vec3 缺少 `init<T2, Q2>(v: Vec3<T2, Q2>)`；Vec4 缺少 `init<T2, Q2>(v: Vec4<T2, Q2>)`。
- **根因坐标**：`type_vec3.cj:12-28`、`type_vec4.cj:13-32` struct 体内构造函数定义区域

#### #15 — Vec3/Vec4 缺失多元组合构造函数

- **位置**：`type_vec3.cj:12-28`, `type_vec4.cj:13-32`
- **判定**：**真实存在**
- **理由**：OOD §4.1 为 Vec3 定义了 12 个多元组合构造函数（如 Vec2+标量、Vec1x3、Vec2+Vec1 等），为 Vec4 定义了约 30 个多元组合构造函数（如 Vec3+T、Vec3+Vec1、T+Vec3、Vec1+Vec3、Vec2+Vec2、Vec1x4 等）。当前实现全部缺失。这会导致 `Vec4(Vec3(a,b,c), d)` 等 GLM 代码迁移中的常见构造模式无法直接使用。
- **根因坐标**：`type_vec3.cj` 和 `type_vec4.cj` 的构造函数定义区域

#### #16 — Vec3/Vec4 缺失 increment()/decrement() 具名函数

- **位置**：`type_vec3.cj`, `type_vec4.cj`（缺失）
- **判定**：**真实存在**
- **理由**：同 #11。Vec3 和 Vec4 的 `Integer<T>` extend 块中均未定义 `increment()`/`decrement()`。
- **根因坐标**：`type_vec3.cj:99-130`（Integer<T> extend 块）、`type_vec4.cj:106-137`（Integer<T> extend 块）

#### #17 — Vec3/Vec4 componentAt() 未声明为 `const`

- **位置**：`type_vec3.cj:52`, `type_vec4.cj:58`
- **判定**：**真实存在**（同 #12，CL-10）
- **理由**：同 #12 分析。Vec3 和 Vec4 的 `componentAt` 均缺少 `const` 修饰符，原因相同（`assert` 非 `const` 导致）。
- **根因坐标**：`type_vec3.cj:52`、`type_vec4.cj:58`

#### #18 — Vec3/Vec4 `==` 使用 `ComputeEqual<T>.call`（精确比较）

- **位置**：`type_vec3.cj:133`, `type_vec4.cj:140`, `compute_vector_relational.cj:5-9`
- **判定**：**OOD文档矛盾/偏差/不完善/错误**
- **理由**：同 #13 分析（CL-09）。`==` 使用 `ComputeEqual<T>.call`（精确比较）是 CL-08/CL-09 的必然后果——`ComputeEqual.callConst`（浮点容差版本）必须放置在 `ComputeEqualNumeric<T> where T <: Number<T> & Equatable<T> & Comparable<T>` 中，只能在 `equalEpsilon` 函数中通过具名方式调用。OOD 设计的"`==` 自动使用浮点容差比较"在仓颉中不可实现。
- **关键证据**：`deviations.md:111-119` 记录 CL-09

#### #19 — Vec3 缺少 Vec4 截断构造函数

- **位置**：`type_vec3.cj:12-28`
- **判定**：**真实存在**
- **理由**：OOD §4.1 要求 Vec3 提供 `public init<T2, Q2>(v: Vec4<T2, Q2>) where Q2 <: Qualifier`，截取 Vec4 的 x/y/z 分量构造 Vec3。当前代码中该构造函数缺失。
- **根因坐标**：`type_vec3.cj:12-28`

#### #20 — 测试未验证核心 T(1)/T(0) 转换语义

- **位置**：`cjglm/src/detail/type_fromBoolVec_test.cj:9`
- **判定**：**OOD文档矛盾/偏差/不完善/错误**
- **理由**：测试当前传入 `Int64(0)`/`Int64(1)` 作为 `zero`/`one` 参数验证函数返回值的正确性。这是 CL-01 的必然后果——因 `T(0)`/`T(1)` 构造在仓颉不可行，API 已变更为接收调用方传入的 `zero`/`one` 参数。测试只能验证从输入到输出的正确映射，无法验证"`true`→`T(1)`、`false`→`T(0)`"的原始语义——因为该语义在 API 层面已被委派给调用方。这不是测试代码的错误，而是 CL-01 API 变更后的自然结果。OOD 设计的原始语义在 CL-01 下已不再适用。

#### #21 — test_lib.cj 仅覆盖 Vec2，未覆盖 Vec1/Vec3/Vec4 的重导出验证

- **位置**：`cjglm/tests/glm/test_lib.cj:7-17`
- **判定**：**真实存在**
- **理由**：`lib.cj` 通过 `public import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }` 导出了全部四个 Vec 类型，但 `test_lib.cj` 仅对 Vec2 做了构造和分量访问测试。Vec1/Vec3/Vec4 的重导出未验证。虽然这些 Vec 类型在 `test_fwd.cj` 中通过别名（如 `Vec1 = detail.Vec1<Float32, PackedHighp>`）间接验证了可达性，但 `test_lib.cj` 作为 `lib.cj` 公共 API 的专用测试文件应直接验证所有 4 个 Vec 类型。
- **根因坐标**：`test_lib.cj:7-17`
- **修复提示**：在 `test_lib.cj` 中参照 `testVec2Construction` 和 `testVec2ComponentAccess` 的模式，为 Vec1/Vec3/Vec4 各追加两个测试函数（构造测试 + 分量访问测试，分别使用 `Int64` 和 `Float32` 分量类型），共需新增约 8 个测试函数

#### #22 — test_lib.cj 未覆盖 sub/mul/div/mod 包级函数

- **位置**：`cjglm/tests/glm/test_lib.cj:13-17`
- **判定**：**真实存在**
- **理由**：`lib.cj` 的 `public import glm.detail.{ add, sub, mul, div, mod }` 重导出了全部五个 scalar_vec_ops 包级函数，但 `test_lib.cj` 仅测试了 `add(s, v)`。sub/mul/div/mod 四个函数在 `package glm` 命名空间下的可用性未被验证。
- **根因坐标**：`test_lib.cj:13-17`
- **修复提示**：在 `test_lib.cj` 中参照 `testScalarAdd` 的模式，为 sub/mul/div/mod 各追加一个测试函数，使用 `Int64` 和 Vec2，验证 `package glm` 命名空间下这些函数的可达性和基本正确性，共需新增 4 个测试函数

#### #23 — test_lib.cj 在 package glm 内无法验证下游 import 可达性

- **位置**：`cjglm/tests/glm/test_lib.cj:1`
- **判定**：**其他类型问题**
- **理由**：此问题的描述准确但性质特殊。`test_lib.cj` 声明 `package glm`（与 `lib.cj` 同包），测试可直接访问所有同包声明，无法验证下游消费者通过 `import glm.*` 是否能正确访问 `public import` 重导出的内容。这不是代码缺陷，也不是测试不完整——这是测试结构的内在限制。完整验证需要在独立包（如 `test.glm.import_test`）中创建测试文件并执行 `import glm.*`。此项应视为"测试结构限制"，而非"需要修复的缺陷"。
- **建议**：作为已知限制记录到测试策略文档中，无需修改代码

#### #24 — gen_fwd_aliases.py 未同步 CL-11 修复

- **位置**：`cjglm/scripts/gen_fwd_aliases.py:29,42-44`
- **判定**：**真实存在**
- **理由**：CL-11 修复将 `fwd.cj` 从名称导入（`import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }`）改为命名空间导入（`import glm.detail`），并将别名 RHS 从裸 `Vec1<T, Q>` 改为 `detail.Vec1<T, Q>`（`deviations.md:131-139`）。但生成脚本 `gen_fwd_aliases.py` 仍生成旧格式：
  - 第 29 行：`lines.append('import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }')`（应为 `import glm.detail`）
  - 第 44 行：`lines.append(f'public type {alias_name} = {vec_type}<{family_type}, {prec_type}>')`（应为 `detail.Vec1<...>` 形式）
  若重新运行脚本将覆盖 CL-11 修复，导致 252 个编译错误。
- **根因坐标**：`gen_fwd_aliases.py:29,44`

#### #25 — fwd.cj 缺少 OOD 设计规定的文件头部注释

- **位置**：`cjglm/src/fwd.cj:1`
- **判定**：**真实存在**
- **理由**：OOD §3.8 明确要求 fwd.cj 包含头部注释 `// fwd.cj — GLM 兼容类型别名（自动生成）` 和 `// 注意：此文件由脚本自动生成，手动修改请谨慎`。当前 `fwd.cj` 以 `package glm` 直接开头，无任何注释。这降低了文件的可识别性，缺少"自动生成"警示增加了手动误修改风险。
- **根因坐标**：`fwd.cj:1`（第 1 行前应插入头部注释块）

#### #26 — fwd.cj 缺少 OOD 设计规定的家族分组注释

- **位置**：`cjglm/src/fwd.cj:51`
- **判定**：**真实存在**
- **理由**：OOD §3.8 要求按家族分组排列并以 `// === {FamilyName} family ===` 注释头分隔。当前 `fwd.cj` 的 256 个别名按家族顺序排列（B→I→U→Vec→DVec→I8→I16→I32→I64→U8→U16→U32→U64→FVec→F32→F64）但无任何分组注释。例如第 51 行从 `BVec1` 直接开始，无 `// === B family ===` 提示。
- **根因坐标**：`fwd.cj` 在全家族别名定义之间缺少分组注释行

#### #27 — test_fwd.cj 使用 detail.VecN 但未导入 glm.detail 子包

- **位置**：`cjglm/tests/glm/test_fwd.cj:201,207,213,219`
- **判定**：**误报**
- **理由**：`test_fwd.cj` 在 `testFwdGenericVec1Accessible` 等 4 个测试函数中使用 `detail.Vec1<Float32, PackedHighp>` 等前缀表达式引用 `glm.detail` 中的类型。该文件仅有 `package glm` 声明和 `import std.unittest.*`/`import std.unittest.testmacro.*`，无 `import glm.detail`。但根据仓颉包解析规则，`package glm` 内的文件可通过子包路径段 `detail` 直接访问子包 `glm.detail` 的公有声明（无需显式 `import`）。当前项目编译和测试均通过，证明此用法在仓颉中是合法的。
- **修正说明**：Todo 原文基于"使用子包命名空间限定须显式导入子包"的假设。若后续编译器版本对此要求变更，可补齐 `import glm.detail` 作为防御性编程措施。当前状态下此项不构成需要修复的问题。

#### #28 — testPackedHighpCrossAssign 测试名不符实

- **位置**：`tests/glm/detail/test_qualifier.cj:29-34`
- **判定**：**真实存在**
- **理由**：函数名 `testPackedHighpCrossAssign` 暗示测试跨 Qualifier 类型的赋值兼容性（如 `let med: PackedMediump = PackedHighp()`），但实际代码仅创建三个独立变量 `high`、`med`、`low`，未进行任何跨类型赋值操作。测试体实质为空（仅 `@Expect(true, true)`）。命名与行为不一致。
- **根因坐标**：`test_qualifier.cj:29-34`
- **修复提示**：有两种修复路径：(a) 修改函数名为 `testPackedQualifierConstruction` 并保留现有代码（仅验证三个 Qualifier 的独立构造）；(b) 保持函数名并追加跨类型赋值的实质性测试体，例如 `let med: PackedMediump = PackedHighp()`、`let low: PackedLowp = PackedHighp()` 等赋值语句。推荐路径 (a) 因为跨 Qualifier 赋值的语义在当前设计中尚未明确定义

#### #29 — test_shim_limits 缺少整数类型 epsilon 降级路径测试

- **位置**：`tests/glm/detail/test_shim_limits.cj`
- **判定**：**真实存在**
- **理由**：`NumericLimits<T>.epsilon` 在 T 为非浮点类型时会走 `hint - hint` 降级路径返回零值（`shim_limits.cj:13`）。当前测试仅覆盖 `Float32` 和 `Float64` 路径，未覆盖 `Int64`、`Int32` 等整数类型的降级行为。该降级路径实现（`hint - hint`）在非浮点类型上的行为需验证——对整数类型返回 0，对 Bool 类型同样返回 0（`false - false`）。
- **根因坐标**：`test_shim_limits.cj`
- **修复提示**：在 `test_shim_limits.cj` 中追加以下测试用例：
  - `testEpsilonInt64`：传入 `Int64(42)` 调用 `epsilon(Int64(42))`，验证返回 `Int64(0)`
  - `testEpsilonInt32`：传入 `Int32(42)` 调用 `epsilon(Int32(42))`，验证返回 `Int32(0)`
  - `testEpsilonBool`：传入 `Bool(true)` 调用 `epsilon(true)`，验证返回 `false`（Bool 的零值）

#### #30 — test_scalar_vec_ops 对不同 Qualifier 覆盖不完整

- **位置**：`tests/glm/detail/test_scalar_vec_ops.cj:219-249`
- **判定**：**真实存在**
- **理由**：测试仅对 `add` 操作覆盖了 `PackedMediump`（第 219 行）和 `PackedLowp`（第 226 行）。`sub`、`mul`、`div`、`mod` 四个操作在所有 Vec1~Vec4 维度上均仅使用 `Defaultp` 测试。虽然 Qualifier 在首轮行为等价（均为空结构体），但未测试非 `Defaultp` Qualifier 上的泛型兼容性。
- **根因坐标**：`test_scalar_vec_ops.cj:219-249` 仅覆盖 `add` 的跨 Qualifier 场景
- **修复提示**：参照现有 `add` 跨 Qualifier 测试模式（`testScalarAddVec2PackedMediump` 和 `testScalarAddVec2PackedLowp`），为 `sub`/`mul`/`div`/`mod` 各追加 2 个跨 Qualifier 测试函数（分别测试 `PackedMediump` 和 `PackedLowp`），使用 Vec2 `Int64`，共需新增约 8 个测试函数

---

## 根因分类统计

| 根因类别 | 涉及项数 | 说明 |
|---------|---------|------|
| **仓颉语言限制**（CL-*） | 8 | #1, #4, #5, #6, #7, #13, #18, #20 — deviations.md 已全量记录 |
| **编码未完成** | 8 | #9, #10, #11, #14, #15, #16, #19, #24 |
| **编码疏忽** | 2 | #3, #28 |
| **测试不完整** | 7 | #8, #12, #17, #21, #22, #29, #30 |
| **文档/风格** | 2 | #25, #26 |
| **误报** | 2 | #2, #27 |
| **测试结构限制** | 1 | #23 |

> 累加合计：8 + 8 + 2 + 7 + 2 + 2 + 1 = 30，覆盖全部 30 项。
>
> - #7 的根因归入「仓颉语言限制」（CL-04），其浮点 mod 路径未实施的编码未完成属性已在逐项分析中说明，但不单独占用根因类别以避免双重计数
> - #17 与 #12 同为 componentAt const 缺失（依赖 assert const 修复前置），归入「测试不完整」

---

## 影响范围分析

### 功能性缺陷

| 项 | 缺陷描述 | 影响范围 | 副作用评估 |
|----|---------|---------|-----------|
| #7 | 浮点 mod 不可用 | `Float32`/`Float64` Vec 无法调用 `mod(s, v)` | 新增浮点重载后需确认函数重载解析无歧义；trunc 在 Inf/NaN 下的行为需专项验证 |
| #12/#17 | componentAt 不可在 const 中使用 | 所有 Vec 类型的 const 实例成员函数无法通过索引访问分量 | 将 assert 替换为 const 兼容实现可能改变错误报告行为（从运行时断言改为编译期或静默截断） |
| #9/#10/#14/#15/#19 | 构造函数缺失导致跨类型转换不可用 | `Vec3<Float32>(Vec3<Int32>(...))` 等跨类型构造失败；`Vec4(Vec3(a,b,c), d)` 等多元组合构造不可用 | 追加构造函数时需注意与现有 `init(v: Vec1<T, Q>)` 的重载解析优先级，避免歧义 |
| #11/#16 | increment/decrement 不可用 | 整数 Vec 类型无法使用 `++`/`--` 的具名替代 | 仅影响编码风格选择，不影响 `++`/`--` 运算符本身 |
| #24 | 脚本不同步可能导致回归 | 重新运行 `gen_fwd_aliases.py` 将覆盖 CL-11 修复，导致 252 个编译错误 | 修复后需锁定 `fwd.cj` 的生成流程，防止脚本与手动修复再次不同步 |

### 设计偏差（已记录）

#1, #4, #5, #6, #13, #18, #20 — 均为 deviations.md 中已认可的仓颉语言限制偏差，不构成代码缺陷，无需修复。

### 测试改进

| 项 | 改进类型 | 工作量估算 |
|----|---------|-----------|
| #8 | 追加浮点/整数类型覆盖、溢出边界、浮点边界 | ~80 个新测试函数 |
| #21 | 追加 Vec1/Vec3/Vec4 重导出验证 | ~8 个新测试函数 |
| #22 | 追加 sub/mul/div/mod 可达性验证 | ~4 个新测试函数 |
| #28 | 重命名测试函数或追加实质性测试体 | 1 个测试函数改动 |
| #29 | 追加整数类型 epsilon 降级测试 | ~3 个新测试函数 |
| #30 | 追加跨 Qualifier 覆盖 | ~8 个新测试函数 |

### 文档/风格

| 项 | 改进类型 | 影响 |
|----|---------|------|
| #3 | 替换 `let` 为 `const` | 无运行时行为差异 |
| #25 | 追加文件头部注释 | 纯文档改进 |
| #26 | 追加家族分组注释 | 纯文档改进，若使用生成脚本需同时修改脚本 |

### 无需处理

#2（误报），#23（测试结构限制），#27（误报）

---

## 优先级建议

**第一优先级 — 构造函数体系缺失**（#9, #10, #14, #15, #19）：这些直接影响类型系统的完备性，是多数组件依赖的基础设施。缺少跨类型转换和多元组合构造函数将阻塞下游代码的 GLM 兼容性迁移路径。建议按 Vec2 → Vec1 → Vec3 → Vec4 的顺序实施，每个 Vec 先补齐跨类型转换构造函数，再补齐多元组合构造函数。

**第二优先级 — 脚本同步**（#24）：`gen_fwd_aliases.py` 不同步是潜在回归风险——若有人重新运行脚本将触发 252 个编译错误。修复工作量小（修改 2 行代码生成逻辑），但一旦触发回归修复成本极高。建议紧随构造函数修复之后实施。

**第三优先级 — 功能性缺失**（#7 浮点 mod、#11/#16 increment/decrement、#12/#17 componentAt const）：这些影响特定场景下的功能可用性。其中 #7 的浮点 mod 涉及新增重载和数学库使用，需额外的验证；#11/#16 的 increment/decrement 实现相对简单；#12/#17 的 componentAt const 依赖 assert 替换前置。

**第四优先级 — 测试改进**（#8, #21, #22, #28, #29, #30）：测试覆盖完善不阻塞功能使用，但长期应在功能性缺陷修复完成后安排。

**第五优先级 — 文档/风格**（#3, #25, #26）和误报/已知限制（#2, #23, #27）：低风险、不影响功能，可在其他任务间隙处理。

---

## 修复副作用矩阵

| 修复项 | 潜在副作用 | 风险等级 | 缓解措施 |
|-------|-----------|---------|---------|
| #7 浮点 mod 重载 | 新增重载与现有整数重载形成函数重载组，编译器解析规则可能导致歧义 | 低 | 验证 `Float32`/`Float64` 实例化可正确匹配浮重重载而非整数重载 |
| #9/#10/#14/#15/#19 新增构造函数 | 新增构造函数可能与现有构造函数产生重载歧义，导致类型推导失败 | 中 | 使用 `T2` 独立泛型参数避免与 `T` 的类型推导冲突；逐项验证 `VecN<T, Q>(VecN<T2, Q2>)` 可正确推导 |
| #24 脚本同步 | 修改脚本生成逻辑后，若手动修复的 `fwd.cj` 中有后续手动修改，重新生成会丢失 | 中 | 修改后应使脚本生成的输出与当前 `fwd.cj` 一致；后续手动修改应通过修改脚本而非直接编辑 `fwd.cj` |
| #12/#17 const assert 替换 | 运行时 `assert` 替换为 const 兼容检查后，错误报告方式改变 | 低 | 使用 `if (!predicate) { throw Exception("...") }` 保持运行时语义 |
| #25/#26 添加注释 | 若使用自动生成脚本，注释可能被覆盖 | 低 | 注释应同步到生成脚本中 |
| #28 修改函数名 | 修改测试函数名不影响其他测试依赖（无交叉引用） | 低 | 仅需修改函数名声明和对应的测试入口引用 |

---

## 诊断结论

1. **OOD 设计文档偏差（7 项）**：CL-01/CL-02/CL-04/CL-07/CL-08/CL-09 等仓颉语言限制导致的偏差已在 deviations.md 中完整记录。这些不是代码编码错误，而是 OOD 设计在仓颉约束下不可实现或需调整的设计假设。

2. **真实代码缺陷（19 项）**：主要包括：(a) Vec1~Vec4 构造函数体系不完整（跨类型转换构造函数缺失、多元组合构造函数缺失），共影响 #9/#10/#14/#15/#19；(b) increment/decrement 具名函数缺失（#11/#16）；(c) gen_fwd_aliases.py 未同步 CL-11（#24）；(d) 测试覆盖不完整和测试命名不一致；(e) setup.cj 应使用 const 而非 let（#3）。

3. **双重分类（1 项）**：#7 同时具有 OOD 设计偏差（CL-04）和编码未完成（浮点 mod 路径缺失）两个维度。

4. **误报（2 项）**：#2（cjpm test 自动注入测试宏 import）、#27（仓颉自动解析子包路径段）。

5. **其他类型（1 项）**：#23 为测试结构的内在限制，需在测试策略层面处理而不是修复代码。

## 修订说明（v2）

| 质询意见 | 回应 |
|---------|------|
| Q1：「真实存在」分类计数标注为 17，但列出的项编号实际共 19 项（#3, #8, #9, #10, #11, #12, #14, #15, #16, #17, #19, #21, #22, #24, #25, #26, #28, #29, #30），数差为 2 | 已修正。将「真实存在」计数改为 19，并在总览表中新增「双重分类（OOD文档矛盾 + 真实存在）」行容纳 #7，使总计覆盖全部 30 项。同时修正了对应说明文字。 |
| Q2：#8 诊断文本称 `scalar_vec_ops_test.cj:7-174` 不在测试目录下，但该文件实际存在于 `cjglm/src/detail/scalar_vec_ops_test.cj`，todo.md 路径有效，报告作了错误的否定判断 | 已修正。#8 的根因坐标文本更新为确认 `cjglm/src/detail/scalar_vec_ops_test.cj` 实际存在且 todo.md 路径有效，删除了错误的否定判断。 |
| Q3：根因分类「仓颉语言限制」标注 8 项，但仅列出 7 个编号（缺 #7），而 #7 正文已明确与 CL-04 关联 | 已修正。在「仓颉语言限制」根因类别编号列表中添加了 #7，使列表与计数 8 一致。 |
| Q4：根因分类「测试不完整」遗漏 #17（#17 与 #12 同属 componentAt const 缺失，应归入此类） | 已修正。在「测试不完整」类别中增加了 #17，计数从 6 调整为 7。 |
| Q5：根因统计各项累加仅 28-29 项，未覆盖全部 30 项（#7 和 #17 未被任何根因类别覆盖） | 已修正。#7 归入「仓颉语言限制」、#17 归入「测试不完整」，累加合计数为 30，覆盖全部项。在统计表下方追加注释说明 #7 和 #17 的分类归入逻辑。 |
| Q6：#7 为双重分类（OOD 文档矛盾且部分真实存在），但总览表中仅在「OOD文档矛盾」行标注，未在「真实存在」行体现 | 已修正。新增「双重分类（OOD文档矛盾 + 真实存在）」行，独占 #7；「真实存在」行保持 19 项（不含 #7），「OOD文档矛盾」行保持 7 项（不含 #7）。合计 19 + 2 + 7 + 1 + 1 = 30。 |
| Q7：全篇缺乏修复方案的副作用分析 | 已修正。新增「修复副作用矩阵」章节，列出 #7/#9/#10/#14/#15/#19/#24/#12/#17/#25/#26/#28 共 6 组修复的潜在副作用、风险等级和缓解措施。同时在逐项分析中对 #3/#7/#8/#28/#29 补充了副作用说明。 |
| Q8：#8/#21/#22/#28/#29 的修复建议过于笼统，缺乏可操作性 | 已修正。#8 补充了具体的测试项清单和数量估算（浮点 32 个、整数 40 个、溢出边界、浮点边界）；#21 补充了具体模式参照和数量估算（参照 `testVec2Construction`/`testVec2ComponentAccess`，约 8 个函数）；#22 补充了参照模式和数量估算（参照 `testScalarAdd`，4 个函数）；#28 给出了两种具体修复路径（重命名或追加实质性测试体）并推荐路径 (a) 及理由；#29 给出了 3 个具体测试用例的签名和验证目标。 |
| Q9：优先级排序将 #24（脚本同步）置于构造函数缺失类之前，缺乏客观依据 | 已修正。优先级调整为构造函数体系缺失（#9/#10/#14/#15/#19）作为第一优先级；#24 脚本同步降为第二优先级，理由为修复工作量小但回归影响大。新增「影响范围分析」中的副作用评估表和「修复副作用矩阵」为优先级排序提供客观依据。 |
