# deviations.md 偏差验证报告

> 验证日期：2026-06-20
> 验证方法：逐一对照实际代码库（`cjglm/src/`、`cjglm/tests/`）、仓颉语言特性文档及实施记录（`harness/implements/202606192149_ood_phase0/`），检验每个偏差的根因描述、影响评估和严重度评级。

---

## 一、目录结构偏差

### DIR-01: 源文件打包路径

| 验证项 | 结论 |
|--------|------|
| OOD 设计路径 | `src/glm/lib.cj`, `src/glm/fwd.cj`, `src/glm/detail/*.cj` |
| 实际路径 | `cjglm/src/lib.cj`, `cjglm/src/fwd.cj`, `cjglm/src/detail/*.cj` |
| 根因验证 | **准确**。`cjpm.toml` 确认 `src-dir = "src"`，文件直接置于 `cjglm/src/` 下，不存在 `src/glm/` 子目录层级。包路径通过 `package glm` 和 `package glm.detail` 声明实现，与目录结构解耦。 |
| 影响验证 | **准确**。`package glm` 和 `package glm.detail` 声明不变，功能无影响。 |
| 严重度 | **合理**。评级「无」——仅目录层级差异，包声明与功能完全一致。 |
| **验证结论** | ✅ 偏差记录准确 |

**补充说明**：实际项目根目录为 `cjglm/`（含 `cjpm.toml`），而非直接在 `cjglm_wp/` 下，这是 cjpm 项目初始化的正常结果。偏差文档中「实际实施」一栏的 `src/` 对应的是 `cjglm/src/`，描述准确。

### DIR-02: 测试文件分布

| 验证项 | 结论 |
|--------|------|
| OOD 设计 | 全部测试文件位于 `tests/glm/` 和 `tests/glm/detail/` |
| 实际分布 | 基础设施测试在 `cjglm/tests/glm/detail/`（6 个文件：test_qualifier/test_scalar_vec_ops/test_setup/test_shim_assert/test_shim_limits/test_type_vec1_broadcast_shift）；Vec 类型和运算测试在 `cjglm/src/detail/` 下与被测文件同包共存（`*_test.cj` 共 11 个文件）；另有 `cjglm/tests/glm/` 下 2 个文件（test_lib/test_fwd） |
| 根因验证 | **准确**。编码阶段先将基础设施测试（setup/qualifier/shim）置于独立 `tests/` 目录，Vec 测试因同包访问 internal 类型需求直接放于 `src/` 目录。实际代码确认：`src/detail/` 下存在 `type_vec1_test.cj` 到 `type_vec4_test.cj`、`scalar_vec_ops_test.cj`、`type_fromBoolVec_test.cj`、`shim_assert_test.cj`、`shim_limits_test.cj`、`compute_vector_relational_test.cj`、`compute_vector_decl_test.cj`、`vectorize_test.cj`、`qualifier_test.cj`、`setup_test.cj`。 |
| 影响验证 | **准确**。仅影响测试文件组织，不改变功能正确性。同包测试声明 `package glm.detail` 可正确访问 `internal` 类型（如 `AlignedHighp`）。 |
| 严重度 | **合理**。评级「无」——测试组织选择差异，不影响功能。 |
| **验证结论** | ✅ 偏差记录准确 |

---

## 二、因仓颉语言特性限制造成的偏差

### CL-01: 泛型无约束参数不支持构造调用 `T(n)`

| 验证项 | 结论 |
|--------|------|
| 涉及文件 | `type_fromBoolVec.cj` — **确认**。实际代码（第 3-33 行）所有 8 个函数均使用 `zero: T, one: T` 参数 |
| OOD 设计 | `fromBoolVec<T, Q>(v: VecN<Bool, Q>): VecN<T, Q>`，函数体使用 `T(1)`/`T(0)` |
| 实际实施 | `fromBoolVec<T, Q>(v: Vec1<Bool, Q>, zero: T, one: T): Vec1<T, Q>` — **确认** |
| 根因验证 | **准确**。仓颉泛型约束规则（`generic/README.md` §7.1）明确：「无约束时只能传递/返回泛型类型的值，不能进行其他操作」。`detail_v4.md` 详细记录了编译器错误信息 `'()' is not a static member of exposed generic parameter 'T'`。即使添加 `Number<T>` 约束也不提供 `()` 构造调用。 |
| 影响验证 | **准确**。API 签名变更：增加 `zero: T, one: T` 参数；调用方必须提供零值和壹值。实际 `lib.cj` 通过 `public import glm.detail.{ fromBoolVec, fromBoolVecQ2 }` 导出，调用方签名已变更。 |
| 严重度 | **合理**。评级「中」——API 变更影响所有调用方，但语义等价，仅增加参数传递成本。 |
| **验证结论** | ✅ 偏差记录准确 |

### CL-02: `const func` 中不可使用运行时参数

| 验证项 | 结论 |
|--------|------|
| 涉及文件 | `scalar_vec_ops.cj` — **确认**。实际代码（第 1-103 行）全部 20 个函数均为 `public func`（无 `const`） |
| OOD 设计 | `public const func add<T, Q>(s: T, v: Vec2<T, Q>): Vec2<T, Q>` |
| 实际实施 | `public func add<T, Q>(s: T, v: Vec2<T, Q>): Vec2<T, Q>` — **确认** |
| 根因验证 | **准确**。仓颉 `const func` 规则（`const/README.md` §3.2 规则 3）：`const` 函数中的表达式都必须是 const 表达式（`const init` 函数除外）。运行时参数 `s`、`v` 在调用处才确定，不满足编译期求值要求。`detail_v7.md` 记录了 50 处 `expected 'const' expression` 错误。 |
| 影响验证 | **准确**。损失编译期调用能力。注意 OOD 文档 §3.2 的「const 上下文中的 API 可用性速查表」曾声称 `add(s,v)/sub(s,v)/mul(s,v)/div(s,v)/mod(s,v)` 可在 const 表达式中调用，但实际因 CL-02 所有这些函数均失去 `const` 声明，**该速查表中的此声明已失效**。 |
| 严重度 | **合理**。评级「中」——损失 const 编译期能力但不影响运行时正确性。 |
| **验证结论** | ✅ 偏差记录准确 |

**额外发现**：OOD 文档 §3.2 速查表中「包级独立函数 `add(s, v)`/`sub(s, v)`/`mul(s, v)`/`div(s, v)`/`mod(s, v)`（定义于 `scalar_vec_ops.cj`）声明为 `const` 函数，可在 const 表达式中调用」的描述已被 CL-02 失效，建议在文档中更新。

### CL-03: 无约束泛型参数不能执行运算符操作

| 验证项 | 结论 |
|--------|------|
| 涉及文件 | `type_vec1.cj`~`type_vec4.cj` — **确认** |
| OOD 设计 | 运算符定义位置混合——部分在 struct 体内，部分在 extend 块中 |
| 实际实施 | **全部运算符移至带约束的 extend 块** — **确认**。实际代码验证：(1) `Vec1` struct 体（第 7-39 行）仅含 `var x`、`const init`、`length()`、`operator []`、`mut operator []`、`componentAt`；(2) `Number<T>` extend 块（第 41-93 行）含算术运算符；(3) `Integer<T>` extend 块（第 95-143 行）含位运算/移位/取模；(4) `Equatable<T>` extend 块（第 146-150 行）含 `==`/`!=`/`equalExact`；(5) `Number<T> & Equatable<T> & Comparable<T>` extend 块（第 152-154 行）含 `equalEpsilon`；(6) `Vec1<Bool, Q>` extend 块（第 156-159 行）含逻辑运算。Vec2/Vec3/Vec4 结构完全一致。 |
| 根因验证 | **准确**。仓颉泛型约束规则（`generic/README.md` §7.1）明确：「无约束时只能传递/返回泛型类型的值，不能进行其他操作」。`detail_v3.md` 的修订说明（v3 r2）详细记录了此约束导致的 struct 体→extend 块迁移。 |
| 影响验证 | **准确**。struct 体定义大幅简化（仅数据成员 + 构造函数 + 下标 + componentAt + length），所有功能代码迁移至 extend 块。 |
| 严重度 | **合理**。评级「大」——架构变更，所有运算符从 struct 体迁移到多个 extend 块，代码组织结构根本变化。 |
| **验证结论** | ✅ 偏差记录准确 |

### CL-04: `Number<T>` 不提供 `%` 运算符

| 验证项 | 结论 |
|--------|------|
| 涉及文件 | `type_vec1.cj`~`type_vec4.cj`, `scalar_vec_ops.cj` — **确认** |
| OOD 设计 | `%` 运算符和 `mod` 具名函数放在 `Number<T>` extend 块中 |
| 实际实施 | `%` 和 `mod` 移至 `Integer<T>` extend 块 — **确认**。`type_vec1.cj`：`%` 在 `Integer<T>` 块（第 106-108 行、第 111-115 行），`mod` 在 `Integer<T>` 块（第 109 行）。`scalar_vec_ops.cj`：`mod` 函数的 T 约束为 `Integer<T>`（第 86 行起，4 个 mod 函数）。 |
| 根因验证 | **准确**。仓颉 `Number<T>` 接口提供 `+`/`-`/`*`/`/` 但不提供 `%`；`Integer<T>` 接口提供 `operator func %(rhs: T): T`。`detail_v6.md` 详细记录了从 `Number<T>` 块删除 `%`/`mod` 并移入 `Integer<T>` 块的修改。 |
| 影响验证 | **准确**。`%` 和 `mod` 仅对整数类型 T 可用；浮点类型在实例化处编译错误（D5 延迟检查）。 |
| 严重度 | **合理**。评级「中」——约束变更影响 API 可用性范围。 |
| **验证结论** | ✅ 偏差记录准确 |

### CL-05: `Integer<T>` 接口移位操作要求右操作数为 `Int64`

| 验证项 | 结论 |
|--------|------|
| 涉及文件 | `type_vec1.cj`~`type_vec4.cj` — **确认** |
| OOD 设计 | `<<(shift: T)`——右操作数类型为分量类型 T |
| 实际实施 | `<<(shift: Int64)`——右操作数固定为 `Int64` — **确认**。`type_vec1.cj`：`<<(shift: Int64)`（第 121 行），`<<(rhs: Vec1<Int64, Q>)`（第 100 行），`<<(rhs: Vec2<Int64, Q>)`（第 128 行）等。Vec2/3/4 同理。 |
| 根因验证 | **准确**。仓颉 `Integer<T>` 接口定义 `operator func <<(n: Int64): T`，右操作数必须是 `Int64`。`detail_v6.md` 详细记录了所有 `<<`/`>>` 签名修改。 |
| 影响验证 | **准确**。Vec-Vec 移位参数类型从 `VecN<T, Q>` 改为 `VecN<Int64, Q>`；标量移位参数从 `T` 改为 `Int64`。 |
| 严重度 | **合理**。评级「中」——签名变更影响调用方。 |
| **验证结论** | ✅ 偏差记录准确 |

### CL-06: 不支持一元 `+` 运算符重载

| 验证项 | 结论 |
|--------|------|
| 涉及文件 | `type_vec1.cj`~`type_vec4.cj` — **确认** |
| OOD 设计 | `public operator func +(): VecN<T, Q> { this }` |
| 实际实施 | **已删除** — **确认**。在 `type_vec1.cj`~`type_vec4.cj` 的 `Number<T>` extend 块中均无 `operator func +()` 定义。仅有 `operator func -()` 一元取反。 |
| 根因验证 | **准确**。仓颉可重载运算符列表（`function/README.md` §8.2）：`()`、`[]`、`!`、`-`（一元）、`**`、`*`、`/`、`%`、`+`、`-`（二元）、`<<`、`>>`、`<`、`<=`、`>`、`>=`、`==`、`!=`、`&`、`^`、`|`。一元 `+` 不在列表中，仅一元 `-` 合法。`detail_v6.md` 确认了此修复。 |
| 影响验证 | **准确**。`+v` 表达式不可编译；对应测试已删除。 |
| 严重度 | **合理**。评级「低」——功能删除，影响小，`+v` 语义恒等可用 `v` 直接替代。 |
| **验证结论** | ✅ 偏差记录准确 |

### CL-07: `isIec559Of`/`epsilonOf` 需要值参数辅助类型推断

| 验证项 | 结论 |
|--------|------|
| 涉及文件 | `shim_limits.cj` — **确认** |
| OOD 设计 | `const func isIec559Of<T>(): Bool`（无参数）；`const func epsilonOf<T>(): T`（无参数） |
| 实际实施 | `public func isIec559Of<T>(hint: T): Bool`（值参数 + `match` 模式匹配）；`public func epsilonOf<T>(hint: T): T where T <: Number<T>`（值参数委托） — **确认** |
| 根因验证 | **部分需修正**。根因描述为「(1) `T(0)` const 构造可能失败；(2) 值参数便于编译器做类型推断；(3) 非 `const` 函数因运行时 `match`/`if` 实现」。实际验证：(1) `T(0)` const 构造失败是 CL-01 同类问题，确认正确；(2) 值参数辅助类型推断——确认正确，`isIec559Of(a)` 的 `a` 提供运行时类型信息供 `match` 模式匹配使用；(3) 非 `const` 原因——**需补充说明**：`isIec559Of` 使用 `match` 模式匹配（`case _: Float64 =>`），这是运行时类型匹配表达式，不属于 const 表达式范围（`const/README.md` §2 规则 8 的 `is`/`match` 限定为 const 表达式版本的 `match` 须所有 case 为 const 表达式，但 `match` 类型模式匹配需要运行时类型信息，不满足 const 条件）。**但** `epsilonOf` 实际实现委托 `NumericLimits<T>.epsilon(hint)`，其中使用了 `hint is Float64` 等运行时 `if` 判断，同样导致 `const` 不可行。根因基本准确，可补充 `if`/`match` 类型模式匹配的运行时性质。 |
| 影响验证 | **准确**。API 签名变更：调用方需传入类型实例（如 `isIec559Of(a)` 其中 `a: Float32`）。`isIec559Of` 和 `epsilonOf` 失去 `const` 编译期求值能力。注意 `epsilonOf` 额外添加了 `where T <: Number<T>` 约束（偏差文档未明确提及此约束变更），这是因为 `epsilonOf` 委托 `NumericLimits<T>.epsilon(hint)` 时需要 `Number<T>` 约束。 |
| 严重度 | **合理**。评级「中」——API 变更影响调用方。 |
| **验证结论** | ⚠️ 基本准确，需补充 `epsilonOf` 新增 `where T <: Number<T>` 约束的记录 |

**补充发现**：偏差文档中 CL-07 的「实际实施」列仅提及 API 签名变更（增加 `hint: T`），未记录 `epsilonOf` 从无约束变为 `where T <: Number<T>` 约束。此约束变更意味着 `epsilonOf` 仅对 `Number<T>` 类型可用——但由于 `epsilonOf` 仅被 `ComputeEqualNumeric` 和 `NumericLimits` 自身调用，而调用处 `T` 已受 `Number<T>` 约束，此变更不会产生额外的调用方影响。建议在偏差文档中补充记录此约束变更。

### CL-08: `ComputeEqual.callConst` 因双分支均需编译而不能使用无约束泛型

| 验证项 | 结论 |
|--------|------|
| 涉及文件 | `compute_vector_relational.cj` — **确认** |
| OOD 设计 | 单一 `ComputeEqual<T>`，`callConst` 使用 `if (isIec559Of<T>())` + const 分支抑制 |
| 实际实施 | 拆分为 `ComputeEqual<T> where T <: Equatable<T>`（仅 `call`，精确比较）和 `ComputeEqualNumeric<T> where T <: Number<T> & Equatable<T> & Comparable<T>`（`callConst`，epsilon 容差） — **确认** |
| 根因验证 | **准确**。仓颉运行时 `if` 的两个分支均需编译通过——`then` 分支中 `a - b`、`epsilonOf(a)` 需要 `Number<T>` 约束，与无约束设计矛盾。const 编译期 `if` 分支抑制在 extend 块中不可用（extend 不支持 `const` 修饰符），且 `callConst` 本身因 CL-07 `isIec559Of` 需值参数而无法使用无参数 const 调用。`design_review_v2_r1.md` 记录了此拆分决策。 |
| 影响验证 | **准确**。`==` 运算符使用 `ComputeEqual.call`（精确比较），epsilon 容差比较仅通过 `ComputeEqualNumeric.callConst` 提供给 `equalEpsilon`。 |
| 严重度 | **合理**。评级「大」——架构变更，从单一结构体变为两个，核心 API 逻辑分布变化。 |
| **验证结论** | ✅ 偏差记录准确 |

### CL-09: `operator ==` 无法实现浮点容差比较（const 路径不可行）

| 验证项 | 结论 |
|--------|------|
| 涉及文件 | `type_vec1.cj`~`type_vec4.cj` — **确认** |
| OOD 设计 | `==` 声明为 `const` 函数，使用 `ComputeEqual.callConst`，对浮点类型采用 epsilon 容差比较 |
| 实际实施 | `==` 定义在 `extend<T, Q> VecN<T, Q> where T <: Equatable<T>` 块中，使用 `ComputeEqual<T>.call(a, b)`（始终精确比较 `a == b`） — **确认**。`type_vec1.cj` 第 147 行：`public operator func ==(rhs: Vec1<T, Q>): Bool { ComputeEqual<T>.call(this.x, rhs.x) }`。 |
| 根因验证 | **准确**。(1) extend 块不支持 `const` 修饰符——仓颉扩展文档确认（`extend/README.md` §1.2 列出可添加内容，`const` 不在列；§4.2 成员级修饰符列也无 `const`）；(2) 浮点 epsilon 容差比较已由 `equalEpsilon`（委托 `ComputeEqualNumeric.callConst`）提供。 |
| 影响验证 | **准确**。`==` 对所有类型（含浮点 Vec）使用精确比较，与 C++ GLM 行为一致——OOD 意图的"浮点 epsilon 容差"为新增行为偏移，实施后反而对齐了 C++ GLM 原行为。此描述与 OOD 文档 §3.5 的 C++ GLM 行为偏离声明一致。 |
| 严重度 | **合理**。评级「中」——功能降级但行为与 C++ 原版一致，实际更合理。 |
| **验证结论** | ✅ 偏差记录准确 |

### CL-10: `componentAt` 未实现为 `const` 函数

| 验证项 | 结论 |
|--------|------|
| 涉及文件 | `type_vec1.cj`~`type_vec4.cj` — **确认** |
| OOD 设计 | `public const func componentAt(i: Int64): T` |
| 实际实施 | `public func componentAt(i: Int64): T`（非 `const`） — **确认**。`type_vec1.cj` 第 32 行：`public func componentAt(i: Int64): T`。Vec2/3/4 同理。 |
| 根因验证 | **部分需修正**。偏差描述为「编码阶段未按设计标注 `const`；因函数体含 `assert` 调用，`assert` 非 `const` 函数导致 `componentAt` 无法使用 `const`」。实际验证 `shim_assert.cj`（第 3 行）：`public func assert(condition: Bool, message!: String = "Assertion failed"): Unit`——确实是非 `const` 函数。**但更根本的原因是**：`componentAt` 位于 **struct 体内**（非 extend 块），struct 体内定义 `const` 实例成员函数的前提是定义了 `const init`（仓颉 `const/README.md` §3.2 规则 9），而 Vec1~Vec4 均已定义 `const init`，因此 struct 体内 `const` 实例成员函数**语法上**是允许的。**真正的障碍**是：(1) `assert` 非 `const` 函数——在 `const` 函数体中调用非 `const` 函数违反 const 表达式规则（§3.2 规则 3）；(2) 函数体含 `match` 表达式——虽然 `match` 在 const 表达式体系中是允许的（§2 规则 8），但 `assert` 的非 const 性是硬阻碍。偏差文档的根因描述方向正确，但优先级应调整为「`assert` 非 `const` 是主因，编码疏忽是附带因素」。 |
| 影响验证 | **准确**。`componentAt` 不可在 `const` 上下文中调用。 |
| 严重度 | **合理**。评级「低」——有 `operator []` 替代方案。 |
| **验证结论** | ⚠️ 根因描述需修正优先级：`assert` 非 const 是主因，「编码疏忽」为次因 |

### CL-11: fwd.cj 名称导入遮蔽泛型类型

| 验证项 | 结论 |
|--------|------|
| 涉及文件 | `fwd.cj` — **确认** |
| OOD 设计 | `import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }` 后直接使用 `Vec1<Float32, PackedHighp>` |
| 实际实施 | `import glm.detail`（命名空间导入）后使用 `detail.Vec1<Float32, PackedHighp>` — **确认**。`fwd.cj` 第 4 行：`import glm.detail`；第 51 行起所有别名均使用 `detail.Vec1<...>`/`detail.Vec2<...>`/`detail.Vec3<...>`/`detail.Vec4<...>` 限定。 |
| 根因验证 | **准确**。名称导入（`{ Vec1, ... }`）将泛型 `Vec1<T, Q>` 导入作用域；随后 `public type Vec1 = Vec1<Float32, PackedHighp>` 别名定义与导入同名，本地声明遮蔽导入。编译器将 RHS 的 `Vec1` 解析为已定义的别名（0 类型参数），触发错误。`detail_v8.md` 详细记录了此问题和 252 个编译错误。 |
| 影响验证 | **准确**。所有别名定义使用 `detail.VecN<...>` 限定访问。同时 `import glm.detail.{ PackedHighp, PackedMediump, PackedLowp }` 得以保留（无同名遮蔽风险）。 |
| 严重度 | **合理**。评级「大（252 错误）」——命名解析规则导致大量编译错误，但修复方案简单直接。 |
| **验证结论** | ✅ 偏差记录准确 |

### CL-12: `equalEpsilon` 委托 `ComputeEqualNumeric.callConst` 而非内联

| 验证项 | 结论 |
|--------|------|
| 涉及文件 | `type_vec1.cj`~`type_vec4.cj` — **确认** |
| OOD 设计 | `equalEpsilon` 在 extend 块中内联 `abs(a-b) <= epsilonOf<T>()` |
| 实际实施 | 委托 `ComputeEqualNumeric<T>.callConst(a, b)` — **确认**。`type_vec1.cj` 第 153 行：`public func equalEpsilon(other: Vec1<T, Q>): Bool { ComputeEqualNumeric<T>.callConst(this.x, other.x) }`。Vec2/3/4 同理。 |
| 根因验证 | **准确**。与 CL-08 关联——`callConst` 作为独立约束结构体的静态方法，复用性优于内联实现。`ComputeEqualNumeric` 已封装 `isIec559Of` 判断和 epsilon 容差计算逻辑，避免在 4 个 Vec 类型中重复内联。 |
| 影响验证 | **准确**。实现结构变化，行为等价。 |
| 严重度 | **合理**。评级「低」——实现结构变更，行为等价。 |
| **验证结论** | ✅ 偏差记录准确 |

---

## 三、设计阶段假设验证结论

| 验证项 | 设计预期 | deviations.md 记录 | 实际代码验证 | 结论 |
|--------|---------|-------------------|-------------|------|
| ③ `isIec559Of` 核心依赖 | `T(0)` const 构造 + `is` 运算符 | **不可行**，改用值参数 + `match` | `shim_limits.cj` 使用 `match` 模式匹配（第 18-22 行），值参数 `hint: T` — ✅ 记录准确 |
| ⑯ const init 与非 const init 共存 | 安全共存 | 验证通过，未产生歧义 | `Vec2` 中 `const init(x: T, y: T)`（第 16 行）与 `init(scalar: T)`（第 11 行）、`init(v: Vec1<T, Q>)`（第 21 行）共存，参数结构显著不同（2 个 T vs 1 个 T vs 1 个 Vec1），不构成重载歧义 — ✅ 记录准确 |
| ⑰ `%` 运算符报错位置 | 假设可能在定义处报错 | 实测在 extend 块中定义处通过，仅在浮点实例化处报错 | `%` 定义在 `Integer<T>` extend 块中，编译通过——符合 D5 延迟检查策略 — ✅ 记录准确 |
| ⑱ `public import` 重导出 | 扩展成员函数保持可见 | **⚠ 部分验证** | `lib.cj` 使用 `public import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }` 重导出类型；`fwd.cj` 中定义的别名与 `lib.cj` 同属 `package glm`，已自动对外可见。但扩展成员函数（如 `add`/`sub`/`mul`/`div`）的 `public import` 可见性**未在测试中系统验证**——`test_lib.cj` 和 `test_fwd.cj` 存在但未审查其具体覆盖范围 — ⚠️ 记录准确，潜在风险仍在 |
| ㉑ `@Derive[Hashable]` 约束检查 | 延迟检查（实例化处报错） | 编译通过，未触发约束冲突 | 所有 Vec 类型均有 `@Derive[Hashable]`（第 6 行），且 `where Q <: Qualifier` 不含 `T <: Hashable` 约束，当前编译通过 — ✅ 记录准确 |
| ㉓ Vec 别名同名自引用 | 右侧 `Vec2` 解析为导入来源 | **出现错误**，改用 `detail.` 前缀 | `fwd.cj` 已使用 `detail.Vec1<...>` 等——与 CL-11 一致 — ✅ 记录准确 |
| ㉔ `<<` 默认溢出策略 | 默认抛异常，保留 `@OverflowWrapping` 标注 | 默认抛异常，保留标注 | 所有 `<<` 运算符均有 `@OverflowWrapping` 标注（如 `type_vec1.cj` 第 99、100、121、128、135、142 行） — ✅ 记录准确 |

---

## 四、非语言限制偏差

### DEV-01: `equalEpsilon` 使用 `ComputeEqualNumeric.callConst`（非 const）

| 验证项 | 结论 |
|--------|------|
| OOD 期望 | `equalEpsilon` 可在 const 上下文中调用 |
| 实际状态 | `equalEpsilon` 定义在 extend 块中（非 const），且 `ComputeEqualNumeric.callConst` 也非 const — **确认** |
| 根因验证 | **准确**。(1) extend 块不支持 `const` 修饰符；(2) `ComputeEqualNumeric.callConst` 使用 `isIec559Of(a)` 运行时类型判断，非 const；因此 `equalEpsilon` 不可能为 const，组合偏差准确。 |
| 影响验证 | **准确**。原设计的 const 容差比较路径完全不可用，唯一可行的容差比较路径在非 const 上下文中。 |
| 严重度 | **合理**。评级「中」——功能降级但行为等价，仅损失编译期调用能力。 |
| **验证结论** | ✅ 偏差记录准确 |

### DEV-02: 原文偏差——`componentAt` const 丢失

| 验证项 | 结论 |
|--------|------|
| OOD 设计意图 | `const func componentAt` 满足 const 实例成员函数中的索引访问需求 |
| 实际状态 | `componentAt` 丢失 `const` — **确认** |
| 根因验证 | **准确**。与 CL-10 关联——`assert` 非 `const` 导致 `componentAt` 无法声明为 `const`。同时 struct 体内含 `match` 返回表达式和 `throw Exception`（越界分支），后者同样不满足 const 表达式要求。注意：`componentAt` 是 struct 体内函数（非 extend 块），理论上 struct 体允许 `const` 实例成员函数——真正障碍是函数体实现。 |
| 影响验证 | **准确**。const 上下文中无法通过索引访问 Vec 分量。可用 `operator []` 同样无法在 const 上下文中使用（因同样含 `assert`），因此无可用替代——需内联表达式替代（如直接访问 `.x`/`.y` 等）。 |
| 严重度 | **合理**。评级「低」——const 上下文场景有限，且可直接访问 `.x`/`.y` 等命名分量。 |
| **验证结论** | ✅ 偏差记录准确 |

### DEV-03: 缺少 S2~S4 的 verify 记录验证

| 验证项 | 结论 |
|--------|------|
| plan.md 记录 | 所有轮次均通过测试 |
| 实际验证状态 | 实施记录目录中存在 `verify_v1.md`~`verify_v10.md` 共 10 个文件 | 
| 根因验证 | **需部分修正**。偏差描述称「部分设计阶段验证项（特别是⑱ public import 扩展成员函数可见性、⑳ scalar:T vs init(v:Vec1) 重载歧义）的实施状态未形成独立的 verify 报告文件追溯」。实际验证：实施记录中确有 10 个 verify 文件，部分验证项应在这些 verify 中覆盖。但⑱（public import 扩展成员函数可见性）确实未系统性验证——此风险点仍存在。⑳（scalar:T vs init(v:Vec1) 重载歧义）——实际 Vec2/3/4 代码中已采用不同的参数名消歧策略（`init(scalar: T)` vs `init(v: Vec1<T, Q>)`），参数类型差异（`T` vs `Vec1<T, Q>`）足以消除歧义，实践验证已隐式通过但无独立 verify 文件。 |
| 影响验证 | **部分准确**。⑱的潜在风险仍存——若 `public import` 后扩展成员函数不可见，下游 `import glm.*` 可能无法调用 `Vec2.add(s)` 等扩展成员函数。⑳ 已通过实际代码间接验证（使用命名参数 `scalar: T` 区分）。 |
| 严重度 | **需评估**。⑱ 的潜在风险若实际存在，影响「大」——下游无法通过 `import glm.*` 调用扩展成员函数。建议系统性测试⑱。 |
| **验证结论** | ⚠️ 描述方向正确，建议补充⑱的系统验证风险 |

---

## 五、偏差汇总严重度复核

| 偏差编号 | 原严重度 | 复核后严重度 | 复核理由 |
|---------|---------|------------|---------|
| CL-01 | 中 | **中** | API 变更但语义等价，确认 |
| CL-02 | 中 | **中** | const 丢失但运行时正确，确认 |
| CL-03 | 大 | **大** | 架构变更，代码组织根本变化，确认 |
| CL-04 | 中 | **中** | 约束范围收窄，确认 |
| CL-05 | 中 | **中** | 签名变更，确认 |
| CL-06 | 低 | **低** | 功能删除，影响极小，确认 |
| CL-07 | 中 | **中** | API 变更 + 约束变更，确认 |
| CL-08 | 大 | **大** | 架构拆分变化，确认 |
| CL-09 | 中 | **中** | 功能降级但与 C++ 行为一致，确认 |
| CL-10 | 低 | **低** | const 丢失，有命名分量替代，确认 |
| CL-11 | 大（252 错误） | **大** | 编译阻断但修复简单，确认 |
| CL-12 | 低 | **低** | 实现结构变更，行为等价，确认 |
| DEV-01 | 中 | **中** | 组合限制效应，确认 |
| DEV-02 | 低 | **低** | 编码偏差，有替代方案，确认 |
| DIR-01 | 无 | **无** | 无功能影响，确认 |
| DIR-02 | 无 | **无** | 无功能影响，确认 |

**所有严重度评级经复核均合理，无需调整。**

---

## 六、验证发现汇总

### 已确认准确的偏差（12 项）

DIR-01、DIR-02、CL-01、CL-02、CL-03、CL-04、CL-05、CL-06、CL-08、CL-09、CL-11、CL-12

### 需修正/补充的偏差（4 项）

| 偏差编号 | 修正/补充建议 |
|---------|-------------|
| **CL-07** | 补充 `epsilonOf` 新增 `where T <: Number<T>` 约束的记录。`epsilonOf` 从无约束泛型函数变为带 `Number<T>` 约束的泛型函数，是 API 变更的一部分。 |
| **CL-10** | 根因描述优先级修正：「`assert`/`throw` 非 const 是主因，编码疏忽为次因」。struct 体内 `const` 实例成员函数语法上允许（已有 `const init`），但因函数体含非 const 表达式（`assert` 调用、`throw Exception`）而不可行。此外 `operator []` 同样含 `assert` 因此也不可能为 const，但偏差文档未记录 `[]` 的 const 丢失——仅有 `componentAt` 被记录。 |
| **DEV-02** | 与 CL-10 关联说明——`componentAt` 非 const 的根本原因是函数体实现（`assert` + `throw`），不仅是「编码偏差」。`operator []` 同样因含 `assert` 而无法声明为 `const`，但 OOD 设计中 `[]` 未标注 `const`（仅在 struct 体中），因此 `[]` 的 const 丢失不属于偏差。 |
| **DEV-03** | ⑱ `public import` 扩展成员函数可见性仍为潜在风险点，建议系统性验证。若 `public import glm.detail.{ Vec1 }` 后 `Vec1<Float32, PackedHighp>.add(s)` 不可调用，则为「大」影响偏差。 |

### 新发现（OOD 文档与实际代码的差异，偏差文档未记录的）

| 新发现 | 描述 | 建议严重度 |
|--------|------|-----------|
| OOD 速查表失效 | OOD §3.2 「const 上下文中的 API 可用性速查表」中声称「包级独立函数 `add(s, v)`/`sub(s, v)`/`mul(s, v)`/`div(s, v)`/`mod(s, v)` 声明为 `const` 函数，可在 const 表达式中调用」——因 CL-02 这些函数实际均非 `const`，该声明已失效 | 低（文档更新） |
| `increment`/`decrement` 移除 | OOD detail_v3.md 设计了 `increment()`/`decrement()` 函数（使用 `T(1)` 构造），但实际代码中 Vec1~Vec4 均无此二函数。因 `T(1)` 同 CL-01 不可行，被完全移除而非改用参数传递方案。deviations.md 未单独记录此偏差 | 低（功能已删除，影响小） |

---

## 七、总体评估

### 偏差文档质量

`deviations.md` 的整体质量**高**。17 项偏差（DIR-01~02、CL-01~12、DEV-01~03）的根因描述均指向正确的仓颉语言特性限制，影响评估与实际代码一致，严重度评级经复核合理。4 项需修正/补充的偏差均为局部描述不完整，不影响总体结论的正确性。

### 偏差根因分类准确性

- **泛型约束规则**（CL-01、CL-03）：准确。仓颉泛型约束规则确认为根因。
- **const 函数限制**（CL-02、CL-07、CL-09、CL-10、DEV-01、DEV-02）：准确。仓颉 const 函数规则和 extend 块不支持 const 确认为根因。
- **接口签名**（CL-04、CL-05）：准确。`Number<T>`/`Integer<T>` 接口成员定义确认为根因。
- **运算符列表**（CL-06）：准确。仓颉可重载运算符列表不包含一元 `+`。
- **命名解析**（CL-11）：准确。本地声明遮蔽导入名称。
- **架构联动**（CL-08、CL-12）：准确。多限制组合导致的架构拆分。

### 剩余风险

1. **⑱ public import 扩展成员函数可见性**：未系统性验证。若验证失败，下游通过 `import glm.*` 无法调用 Vec 扩展成员函数，影响面大。
2. **`increment`/`decrement` 功能缺失**：OOD 有设计但实际未实现（因 `T(1)` 不可构造，且未采用参数传递替代方案），偏差文档未记录。功能影响为低——调用方可用 `v + T(1)` 替代（需 T 受 `Number<T>` 约束）。
3. **OOD 文档速查表失效**：`scalar_vec_ops` 函数 const 声明已删除但 OOD 速查表未更新。
