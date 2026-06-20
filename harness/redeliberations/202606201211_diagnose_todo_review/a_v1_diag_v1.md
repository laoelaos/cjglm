# 诊断报告：TODO Review 问题定位

> 诊断范围：`harness/reviews/202606201155_ood_phase0_code_review/todo.md` 全部 30 项
>
> 参考依据：OOD 设计文档 `docs/02_ood_phase0.md`、实现偏差记录 `docs/deviations.md`、项目代码 `cjglm/`、参考项目 `references/glm-1.0.3`

---

## 诊断结论总览

| 判定类别 | 数量 | 项编号 |
|---------|------|--------|
| **真实存在** | 17 | #3, #8, #9, #10, #11, #12, #14, #15, #16, #17, #19, #21, #22, #24, #25, #26, #28, #29, #30 |
| **误报** | 2 | #2, #27 |
| **OOD文档矛盾/偏差/不完善/错误** | 8 | #1, #4, #5, #6, #7, #13, #18, #20 |
| **其他类型问题** | 1 | #23 |

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
- **修复提示**：需为 `mod` 增加新的浮点重载（或修改现有约束），使用 `std.math.trunc` 实现浮点取模恒等式

#### #8 — 测试覆盖不够完整

- **位置**：`scalar_vec_ops_test.cj:7-174`
- **判定**：**真实存在**
- **理由**：代码验证确认：
  - 测试仅覆盖 `Int64` 类型的 add/sub/mul/div/mod 五个操作（仅 add 有部分 Float32 测试——`testScalarAddVec2Float32` 和 `testScalarMulVec3Float32`）。todo 原文"仅覆盖 Int64"不准确（已有两处 Float32 测试），但总体上浮点类型的 sub/div/mod 完全未覆盖，其他整数类型（`Int32`、`UInt8` 等）均未覆盖。
  - 溢出 `@OverflowWrapping` 行为未验证
  - 边界值场景缺失（零除由 `testScalarDivVec1Float32ByZero` 和 `testScalarModVec1ByZero` 覆盖部分，但负操作数浮点 mod、Inf/NaN 未覆盖）
- **根因坐标**：`cjglm/src/detail/scalar_vec_ops_test.cj`（未在 todo 中列出正确路径——todo 提及的 `scalar_vec_ops_test.cj:7-174` 不在测试目录下，实际应指 `tests/glm/detail/test_scalar_vec_ops.cj` 或 `src/detail/` 下的测试文件）

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
- **根因坐标**：`test_lib.cj:7-17` 的测试函数应增加对 Vec1/Vec3/Vec4 的测试

#### #22 — test_lib.cj 未覆盖 sub/mul/div/mod 包级函数

- **位置**：`cjglm/tests/glm/test_lib.cj:13-17`
- **判定**：**真实存在**
- **理由**：`lib.cj` 的 `public import glm.detail.{ add, sub, mul, div, mod }` 重导出了全部五个 scalar_vec_ops 包级函数，但 `test_lib.cj` 仅测试了 `add(s, v)`。sub/mul/div/mod 四个函数在 `package glm` 命名空间下的可用性未被验证。
- **根因坐标**：`test_lib.cj:13-17`

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

#### #29 — test_shim_limits 缺少整数类型 epsilon 降级路径测试

- **位置**：`tests/glm/detail/test_shim_limits.cj`
- **判定**：**真实存在**
- **理由**：`NumericLimits<T>.epsilon` 在 T 为非浮点类型时会走 `hint - hint` 降级路径返回零值（`shim_limits.cj:13`）。当前测试仅覆盖 `Float32` 和 `Float64` 路径，未覆盖 `Int64`、`Int32` 等整数类型的降级行为。该降级路径实现（`hint - hint`）在非浮点类型上的行为需验证——对整数类型返回 0，对 Bool 类型同样返回 0（`false - false`）。
- **根因坐标**：`test_shim_limits.cj` 应在现有测试末尾追加整数类型的 epsilon 测试用例

#### #30 — test_scalar_vec_ops 对不同 Qualifier 覆盖不完整

- **位置**：`tests/glm/detail/test_scalar_vec_ops.cj:219-249`
- **判定**：**真实存在**
- **理由**：测试仅对 `add` 操作覆盖了 `PackedMediump`（第 219 行）和 `PackedLowp`（第 226 行）。`sub`、`mul`、`div`、`mod` 四个操作在所有 Vec1~Vec4 维度上均仅使用 `Defaultp` 测试。虽然 Qualifier 在首轮行为等价（均为空结构体），但未测试非 `Defaultp` Qualifier 上的泛型兼容性。
- **根因坐标**：`test_scalar_vec_ops.cj:219-249` 仅覆盖 `add` 的跨 Qualifier 场景

---

## 根因分类统计

| 根因类别 | 涉及项数 | 说明 |
|---------|---------|------|
| **仓颉语言限制**（CL-*） | 8 | #1, #4, #5, #6, #13, #18, #20 — deviations.md 已全量记录 |
| **编码未完成** | 8 | #9, #10, #11, #14, #15, #16, #19, #24 |
| **编码疏忽** | 2 | #3, #28 |
| **测试不完整** | 6 | #8, #21, #22, #29, #30 + #12（componentAt const 需先修复 assert） |
| **文档/风格** | 2 | #25, #26 |
| **误报** | 2 | #2, #27 |
| **测试结构限制** | 1 | #23 |

---

## 影响范围分析

- **功能性缺陷**（编译通过但行为偏离设计预期）：#7（浮点 mod 不可用）、#12/#17（componentAt 不可在 const 中使用）、#9/#10/#14/#15/#19（构造函数缺失导致跨类型转换不可用）、#11/#16（increment/decrement 不可用）、#24（脚本不同步可能导致回归）
- **设计偏差（已记录）**：#1, #4, #5, #6, #13, #18, #20 — 均为 deviations.md 中已认可的仓颉语言限制偏差
- **测试改进**：#8, #21, #22, #28, #29, #30
- **文档/风格**：#3, #25, #26
- **无需处理**：#2（误报），#23（测试结构限制），#27（误报）

---

## 诊断结论

1. **OOD 设计文档偏差（8 项）**：CL-01/CL-02/CL-04/CL-07/CL-08/CL-09 等仓颉语言限制导致的偏差已在 deviations.md 中完整记录。这些不是代码编码错误，而是 OOD 设计在仓颉约束下不可实现或需调整的设计假设。

2. **真实代码缺陷（17 项）**：主要包括：(a) Vec1~Vec4 构造函数体系不完整（跨类型转换构造函数缺失、多元组合构造函数缺失），共影响 #9/#10/#14/#15/#19；(b) increment/decrement 具名函数缺失（#11/#16）；(c) gen_fwd_aliases.py 未同步 CL-11（#24）；(d) 测试覆盖不完整和测试命名不一致；(e) setup.cj 应使用 const 而非 let（#3）。

3. **误报（2 项）**：#2（cjpm test 自动注入测试宏 import）、#27（仓颉自动解析子包路径段）。

4. **其他类型（1 项）**：#23 为测试结构的内在限制，需在测试策略层面处理而不是修复代码。

修复者应当优先处理 #24（脚本同步，防止回归）和构造函数缺失类（#9/#10/#14/#15/#19，这些影响类型系统的完备性），其次处理 #7（浮点 mod）、#11/#16（increment/decrement）等功能性缺失。
