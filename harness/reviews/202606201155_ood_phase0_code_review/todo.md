# 待办事项

## 严重级别

### fromBoolVec 函数签名与 OOD 设计 §4.8 不一致
- **位置**：`cjglm/src/detail/type_fromBoolVec.cj:3`
- **描述**：实现为所有 8 个函数额外添加了 `zero: T, one: T` 参数，设计明确规定仅接收 `v: VecN<Bool, Q>` 单一参数，函数体内硬编码 `T(1)`/`T(0)`。设计签名（§4.8）与实现签名对比：
  ```
  // 设计（§4.8）：
  public func fromBoolVec<T, Q>(v: Vec1<Bool, Q>): Vec1<T, Q> where Q <: Qualifier
  // 实现：
  public func fromBoolVec<T, Q>(v: Vec1<Bool, Q>, zero: T, one: T): Vec1<T, Q> where Q <: Qualifier
  ```
  此偏离导致：① API 契约被改变——调用方需额外传入 `zero`/`one` 而不再使用约定的 `T(0)`/`T(1)`；② 调用方可传入任意值（如 `Int64(42)` 作为 `one`），破坏了设计的转换语义（`true→T(1)`, `false→T(0)`）。
- **来源**：R2C

### tests/glm/detail/ 下测试文件缺少必要 import
- **位置**：`tests/glm/detail/test_qualifier.cj:1`, `test_setup.cj:1`, `test_shim_assert.cj:1`, `test_shim_limits.cj:1`, `test_scalar_vec_ops.cj:1`, `test_type_vec1_broadcast_shift.cj:1`
- **描述**：`tests/glm/detail/` 下的 6 个测试文件均使用 `@Test` 和 `@Expect` 宏，但未导入 `std.unittest.*` 及 `std.unittest.testmacro.*`；而 `tests/glm/test_fwd.cj` 和 `test_lib.cj` 显式导入了这些模块。行为不一致，且若 cjpm 未隐式注入这些导入，将导致编译失败。
- **来源**：R3C

## 一般级别

### setup.cj: 配置常量使用 `public let` 而非 `public const`
- **位置**：`cjglm/src/detail/setup.cj:3-9`
- **描述**：设计文档（`02_ood_phase0.md` §2）明确标明 `setup.cj` 为"配置常量"，并在 §2.1 中注明"`setup.cj` 仅包含 `const` 配置常量"。当前实现全部使用 `public let` 而非 `public const`。所有初始化表达式均为字面量（`Int64(1)`、`false`、`Int64(103)` 等），属于合法的 const 表达式（仓颉 `const` 函数调用和数值字面量均可作为 const 表达式），语法上完全可替换为 `public const`。
- **来源**：R1A

### shim_limits.cj: 函数签名与设计文档不一致（非 `const`、带 hint 参数）
- **位置**：`cjglm/src/detail/shim_limits.cj:5-27`
- **描述**：设计文档（§3.6）明确规定以下签名：
  - `const func isIec559Of<T>(): Bool`（无参数，`const`，内部使用 `T(0) is Float64` 检测类型）
  - `const func epsilonOf<T>(): T where T <: Number<T>`（无参数，`const`）
  - `NumericLimits<T>` 的 `static func epsilon(): T`（无参数）
  当前实现使用了带 `hint` 参数的运行时版：
  - `public func isIec559Of<T>(hint: T): Bool` — 非 const，带 hint
  - `public func epsilonOf<T>(hint: T): T where T <: Number<T>` — 非 const，带 hint
  - `NumericLimits<T>.epsilon(hint: T): T` — 带 hint 参数
  此偏离影响设计文档中 `ComputeEqual.callConst` 的 const 依赖链——若 `isIec559Of` 和 `epsilonOf` 非 const，它们无法在 `const` 函数体（`ComputeEqual.callConst`）中被调用。
- **来源**：R1A

### `ComputeEqual` 结构体设计偏离：`callConst` 被拆分到独立结构体 `ComputeEqualNumeric`
- **位置**：`cjglm/src/detail/compute_vector_relational.cj:5`
- **描述**：OOD 设计文档 §3.5 明确指出 `ComputeEqual<T>` 应同时包含 `call` 和 `const callConst` 两个静态方法，通过编译期 `if (isIec559Of<T>())` 统一分支。实际代码将 `callConst` 拆分为独立的 `ComputeEqualNumeric<T>` 结构体（第 11 行），并追加了 `Number<T> & Equatable<T> & Comparable<T>` 三重约束。这一拆分导致：(1) `ComputeEqualNumeric` 的 `Comparable<T>` 约束并非源自设计——而是因为手动实现了 `abs` 替代 `std.math.abs`，被迫使用 `<` 比较符做绝对值判断；(2) `callConst` 无法被 `==` 运算符使用（`==` 在 extend 块中直接调用 `ComputeEqual<T>.call`，走精确比较路径），浮点容差比较仅通过 `equalEpsilon` 具名函数暴露，与设计的"`==` 自动使用容差比较"意图不符。
- **来源**：R1B

### 所有 20 个包级函数缺少 `const` 修饰符
- **位置**：`scalar_vec_ops.cj:6-103`（add/sub/mul/div/mod 全部重载）
- **描述**：OOD 设计 §4.3 及 §7 D32 明确要求 scalar-op-vec 方向包级独立函数声明为 `const` 函数。理由包括：① 与 `mod`（需编译期 `if` 分支选择）的 API 签名一致；② 允许在 const 表达式中调用；③ 为后续轮次预留。当前代码所有函数均使用 `public func`，缺少 `const` 修饰符。
- **来源**：R1C

### `mod` 函数仅实现整数路径，缺少浮点双路径
- **位置**：`scalar_vec_ops.cj:85-103`
- **描述**：OOD 设计 §4.3 要求 `mod` 包级独立函数通过 `if (isIec559Of<T>())` 编译期分支实现整数/浮点双路径：整数 T 使用 `%` 运算符，浮点 T 使用算术恒等式 `x - y * trunc(x / y)`。当前 4 个 `mod` 函数均使用 `where T <: Integer<T>` 约束，仅支持整数类型，未实现浮点路径。`Float32`/`Float64` Vec 上无法调用 `mod(s, v)`。
- **来源**：R1C

### 测试覆盖不够完整
- **位置**：`scalar_vec_ops_test.cj:7-174`
- **描述**：20 个测试用例覆盖了 `Int64` 类型的 add/sub/mul/div/mod 针对 Vec1~Vec4 的基本正确性，但存在以下缺失：
  - 仅覆盖 `Int64` 单一类型，未覆盖 `Float32`/`Float64` 浮点类型的 add/sub/mul/div 测试
  - 未覆盖其他整数类型（`Int32`、`UInt8` 等）的运算
  - 未覆盖溢出 `@OverflowWrapping` 行为验证（如 `MAX + 1` 是否 wrapping 而非抛异常）
  - 未覆盖边界值：除零、负操作数浮点 mod 边界值（Inf/NaN）
- **来源**：R1C

### Vec1 缺少跨类型转换构造函数
- **位置**：`cjglm/src/detail/type_vec1.cj:7-12`
- **描述**：设计 §4.1 规定的 Vec1 跨类型转换构造函数均未实现。Vec1 应当提供以下四个构造函数：(a) `public init<T2, Q2>(v: Vec1<T2, Q2>) where Q2 <: Qualifier`，(b) `public init<T2, Q2>(v: Vec2<T2, Q2>) where Q2 <: Qualifier`，(c) `public init<T2, Q2>(v: Vec3<T2, Q2>) where Q2 <: Qualifier`，(d) `public init<T2, Q2>(v: Vec4<T2, Q2>) where Q2 <: Qualifier`。当前仅定义了 `const init(x: T)`。
- **来源**：R2A

### Vec2 缺少跨类型转换构造函数
- **位置**：`cjglm/src/detail/type_vec2.cj:7-54`
- **描述**：设计 §4.1 规定的 Vec2 构造函数体系未完整实现。缺少以下构造函数：(a) `public init<T2, Q2>(v: Vec2<T2, Q2>) where Q2 <: Qualifier`，(b) `public init<T2, Q2>(a: Vec1<T2, Q2>, b: T) where Q2 <: Qualifier`，(c) `public init<T2, Q2>(a: T, b: Vec1<T2, Q2>) where Q2 <: Qualifier`，(d) `public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>) where Q2 <: Qualifier`，(e) `public init<T2, Q2>(v: Vec3<T2, Q2>) where Q2 <: Qualifier`（从 Vec3 截断取 x,y），(f) `public init<T2, Q2>(v: Vec4<T2, Q2>) where Q2 <: Qualifier`（从 Vec4 截断取 x,y）。
- **来源**：R2A

### 缺少 increment()/decrement() 具名函数
- **位置**：`cjglm/src/detail/type_vec1.cj:95-144`，`cjglm/src/detail/type_vec2.cj:92-123`
- **描述**：设计 §3.2 和 §4.6 要求提供 `increment(): VecN<T,Q>` 和 `decrement(): VecN<T,Q>` 具名函数作为 `++`/`--` 的替代，并标注 `@OverflowWrapping`。两个文件均未实现。设计明确标注这两函数应在 `extend<T, Q> VecN<T, Q> where T <: Integer<T>, Q <: Qualifier` 块中定义（与位运算符和 `%` 同块）。
- **来源**：R2A

### componentAt 缺少 const 标注
- **位置**：`cjglm/src/detail/type_vec1.cj:32`，`cjglm/src/detail/type_vec2.cj:46`
- **描述**：设计 §4.2 明确规定 `componentAt` 应声明为 `public const func componentAt(i: Int64): T`，以便在 const 实例成员函数体内通过索引访问分量。当前代码中两个 Vec 的 `componentAt` 均无 `const` 修饰符，丧失了在 const 上下文中被调用的能力。
- **来源**：R2A

### `==` 运算符定义在 extend 块中而非 struct 体内，丢失 const 能力
- **位置**：`cjglm/src/detail/type_vec1.cj:146-148`，`cjglm/src/detail/type_vec2.cj:125-128`
- **描述**：设计 §3.2 和 §4.5 要求 `==` 声明为 `const` 函数（利用 Vec 的 `const init` 支持），定义在 struct 体外或体内均可但必须可 const。当前实现将 `==` 定义在 `extend<T, Q> where T <: Equatable<T>` 块中，而仓颉 extend 块不支持 `const` 修饰符（仓颉扩展 §4.2），导致 `==` 为非 const 函数，无法在 const 表达式中使用。
- **来源**：R2A

### Vec3/Vec4 缺失跨类型转换构造函数 `init<T2,Q2>`
- **位置**：`type_vec3.cj:12-28`、`type_vec4.cj:13-32`
- **描述**：OOD §4.1 构造函数清单明确要求 Vec3 和 Vec4 提供 `public init<T2, Q2>(v: Vec3<T2, Q2> / Vec4<T2, Q2>) where Q2 <: Qualifier` 跨类型转换构造函数。当前实现仅包含 `init(scalar: T)`、`const init(x, y, ...)` 和 `init(v: Vec1<T, Q>)`，缺少跨类型版本。这导致 `Vec3<Float32, Defaultp>(Vec3<Int32, Defaultp>(1,2,3))` 等跨类型转换无法编译。
- **来源**：R2B

### Vec3/Vec4 缺失多元组合构造函数
- **位置**：`type_vec3.cj:12-28`、`type_vec4.cj:13-32`
- **描述**：OOD §4.1 为 Vec3 定义了 12 个多元组合构造函数（Vec2+标量、Vec1x3、Vec2+Vec1 等），为 Vec4 定义了约 30 个多元组合构造函数（Vec3+T、Vec3+Vec1、T+Vec3、Vec1+Vec3、Vec2+Vec2、Vec2+2标量、Vec1x4 等）。当前实现全部缺失。这限制了 GLM 代码迁移中常见的 `glm::vec4(glm::vec3(a,b,c), d)` 等构造模式的使用。
- **来源**：R2B

### Vec3/Vec4 缺失 `increment()`/`decrement()` 具名函数
- **位置**：`type_vec3.cj` 和 `type_vec4.cj`（缺失）
- **描述**：OOD §3.2 和 §4.3 明确要求提供 `increment()`/`decrement()` 具名函数（标注 `@OverflowWrapping`）作为 `++`/`--` 运算符的替代。当前 Vec3/Vec4 未定义这两个函数。
- **来源**：R2B

### `componentAt()` 未声明为 `const`
- **位置**：`type_vec3.cj:52`、`type_vec4.cj:58`
- **描述**：OOD §4.2 明确规定 `componentAt` 应声明为 `public const func componentAt(i: Int64): T`，以便在 const 实例成员函数体中通过索引访问分量。当前代码为 `public func componentAt(i: Int64): T`，缺失 `const` 修饰符。
- **来源**：R2B

### `==` 运算符使用 `ComputeEqual<T>.call`（精确比较）而非 `callConst`
- **位置**：`type_vec3.cj:133`、`type_vec4.cj:140`、`compute_vector_relational.cj:5-9`
- **描述**：OOD §3.5/§4.5 要求 `==` 逐分量调用 `ComputeEqual<T>.callConst`——对浮点类型使用 Epsilon 容差比较（`abs(a-b) <= epsilonOf<T>()`），对整数/Bool 使用精确 `==`。当前实现调用 `ComputeEqual<T>.call`（仅精确 `a == b`）。此外 `ComputeEqual<T>` 结构体本身也未提供 `callConst` 方法——Epsilon 容差比较被放置在独立结构体 `ComputeEqualNumeric<T>` 中，需 `Number<T> & Equatable<T> & Comparable<T>` 约束。这导致浮点 Vec 的 `==` 使用 IEEE 754 精确相等语义而非设计要求的 Epsilon 容差语义。
- **来源**：R2B

### Vec3 缺少 Vec4 截断构造函数
- **位置**：`type_vec3.cj:12-28`
- **描述**：OOD §4.1 Vec3 构造函数清单包含 `public init<T2, Q2>(v: Vec4<T2, Q2>) where Q2 <: Qualifier`，截取 Vec4 的 x/y/z 分量构造 Vec3。当前缺失。
- **来源**：R2B

### 测试未验证核心 T(1)/T(0) 转换语义
- **位置**：`cjglm/src/detail/type_fromBoolVec_test.cj:9`
- **描述**：测试用例均传入 `Int64(0)`/`Int64(1)` 作为 `zero`/`one` 参数。由于当前实现将此职责委派给调用方，测试仅验证"传入的值被正确映射"，而非验证设计的核心语义——`true` 应被转换为 `T(1)`、`false` 应被转换为 `T(0)`。
- **来源**：R2C

### test_lib.cj 仅覆盖 Vec2，未覆盖 Vec1/Vec3/Vec4 的重导出验证
- **位置**：`cjglm/tests/glm/test_lib.cj:7-17`
- **描述**：lib.cj 通过 `public import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }` 重导出了全部四个 Vec 类型，但 test_lib.cj 仅测试了 Vec2 的构造和分量访问。虽然 test_fwd.cj 通过别名（如 `Vec1 = detail.Vec1<Float32, PackedHighp>`）间接测试了 Vec1/Vec2/Vec3/Vec4 的可访问性，但 test_lib.cj 作为 lib.cj 公共 API 的专用测试文件，应直接验证所有四个泛型 Vec 类型通过 `package glm` 命名空间可直接构造和访问。
- **来源**：R3A

### test_lib.cj 未覆盖 sub/mul/div/mod 包级函数
- **位置**：`cjglm/tests/glm/test_lib.cj:13-17`
- **描述**：lib.cj 通过 `public import glm.detail.{ add, sub, mul, div, mod }` 重导出了全部五个 scalar_vec_ops 包级函数，但测试仅覆盖了 `add(s, v)`。sub、mul、div、mod 四个函数未被测试，无法确认它们在 `package glm` 命名空间下的可用性。
- **来源**：R3A

### test_lib.cj 在 package glm 内无法验证下游 `import glm.*` 可达性
- **位置**：`cjglm/tests/glm/test_lib.cj:1`
- **描述**：test_lib.cj 声明 `package glm`，与 lib.cj 同属一个包，因此测试代码可直接访问所有同包声明，但这并不能验证下游消费者通过 `import glm.*` 是否能正确访问这些 `public import` 重导出的类型和函数。后者需要在独立包（如 `test.glm.import_test`）的测试文件中通过 `import glm.*` 导入后方可验证。
- **来源**：R3A

### 生成脚本 gen_fwd_aliases.py 未同步 CL-11 修复
- **位置**：`cjglm/scripts/gen_fwd_aliases.py:42-43（生成 import 行和别名行）`
- **描述**：验证项 ㉓ 确认编译器将同名别名 `Vec2 = Vec2<Float32, PackedHighp>` 右侧的 `Vec2` 解析为正在定义的别名自身，导致歧义错误。实际 `fwd.cj` 已应用 CL-11 修复：(1) 使用 `import glm.detail`（命名空间导入）替代 `import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }`（名称导入）；(2) 别名定义中使用 `detail.Vec1<T, Q>` 前缀而非裸 `Vec1<T, Q>`。但 `gen_fwd_aliases.py` 仍生成旧格式：`import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }` 和 `Vec1<T, Q>`（无 `detail.` 前缀）。若重新运行脚本将覆盖 CL-11 修复，导致编译失败。
- **来源**：R3B

### fwd.cj 缺少 OOD 设计规定的文件头部注释
- **位置**：`cjglm/src/fwd.cj:1`
- **描述**：OOD 设计 §3.8 明确要求 fwd.cj 包含头部注释：`// fwd.cj — GLM 兼容类型别名（自动生成）` 和 `// 注意：此文件由脚本自动生成，手动修改请谨慎`。当前 fwd.cj 以 `package glm` 开头，无任何注释。缺乏头部注释降低了文件的可识别性，且未标注"自动生成"警示会增加手动误修改风险。
- **来源**：R3B

### fwd.cj 缺少 OOD 设计规定的家族分组注释
- **位置**：`cjglm/src/fwd.cj:51`
- **描述**：OOD 设计 §3.8 规范要求按家族分组并以 `// === {FamilyName} family ===` 注释头分隔。当前 fwd.cj 的 256 向量别名按家族顺序排列但无任何分组注释，导致文件可读性降低。例如第 51 行从 `BVec1` 直接开始，无 `// === B family ===` 提示；第 67 行 `IVec1` 前也无分隔。
- **来源**：R3B

### 测试文件 test_fwd.cj 使用了 detail.VecN 但未导入 glm.detail 子包
- **位置**：`cjglm/tests/glm/test_fwd.cj:201,207,213,219`
- **描述**：测试文件在 `testFwdGenericVec1Accessible` 等 4 个测试函数中使用 `detail.Vec1<Float32, PackedHighp>`, `detail.Vec2<Int32, PackedHighp>`, `detail.Vec3<Bool, PackedHighp>`, `detail.Vec4<Float64, PackedLowp>` 引用泛型 Vec 类型。但该文件仅有 `package glm` 声明而缺少 `import glm.detail` 语句。根据仓颉包机制（§4.5），使用子包命名空间限定须显式导入子包。缺少该导入可能导致编译期 `detail` 未解析错误。
- **来源**：R3B

### testPackedHighpCrossAssign 测试名不符实
- **位置**：`tests/glm/detail/test_qualifier.cj:29-34`
- **描述**：函数名暗示测试跨 Qualifier 类型的赋值兼容性，但实际代码仅创建三个独立的变量（high/med/low），未进行任何跨类型赋值操作，测试体实质为空（`@Expect(true, true)`）。
- **来源**：R3C

### test_shim_limits 缺少整数类型 epsilon 降级路径测试
- **位置**：`tests/glm/detail/test_shim_limits.cj`
- **描述**：`NumericLimits<T>.epsilon` 在 `T` 非浮点类型时会走 `hint - hint` 降级路径返回零值。现有测试仅覆盖 `Float32` 和 `Float64` 路径，未覆盖 `Int64`、`Int32` 等整数类型的降级行为。
- **来源**：R3C

### test_scalar_vec_ops 对不同 Qualifier 覆盖不完整
- **位置**：`tests/glm/detail/test_scalar_vec_ops.cj:219-249`
- **描述**：现有测试仅对 `add` 操作覆盖了 `PackedMediump`（行 219）和 `PackedLowp`（行 226）。`sub`、`mul`、`div`、`mod` 四个操作在所有 Vec1-Vec4 维度上均仅使用 `Defaultp` 测试，缺乏对其他 Qualifier 类型的泛型兼容性验证。
- **来源**：R3C
