# OOD 设计方案审查报告（v1）

## 审查结果

APPROVED

## 逐维度审查

### 1. 类型系统可行性

**[通过]** 9 个矩阵类型采用独立泛型结构体 `struct Mat{C}x{R}<T, Q> where Q <: Qualifier`，与阶段一 Vec 类型（如 `Vec4<T, Q> where Q <: Qualifier`）设计风格一致。仓颉 struct 支持泛型约束（已验证 skill:cangjie-generic §5），泛型结构体定义合法。

**[通过]** 矩阵类型以列向量 `VecN<T,Q>` 为数据成员，VecN 已在阶段一定义并通过 `@Derive[Hashable]` 验证。同包内类型直接引用，无跨包问题。

**[通过]** 抽象之间的继承/实现关系：矩阵类型不继承任何 class（仅实现接口）。`Number<T>`、`Integer<T>`、`Equatable<T>`、`Comparable<T>`、`Qualifier` 均为接口，仓颉支持多接口实现的 extend 块语法（已验证 skill:cangjie-extend §3、skill:cangjie-interface §2），设计中的 `extend<T, Q> MatNxN<T, Q> where T <: Number<T>, Q <: Qualifier` 模式与阶段一一致。

**[通过]** 泛型使用方式：所有泛型约束为接口约束（`T <: Number<T>`、`Q <: Qualifier` 等），符合仓颉 `where` 子句要求（skill:cangjie-generic §7）。`fromMat` 中的多类型参数 `<U, P>` 和约束 `P <: Qualifier` 合法。

**[通过]** 运算符重载：`operator func` 仅用于 struct/extend 块中（skill:cangjie-function §8），不能为 static（设计正确——所有运算符为实例成员或 extend 块实例成员）。`@OverflowWrapping` 标注在函数声明上合法（skill:cangjie-reflect_and_annotation §1.1）。

**[通过]** `[]` 赋值版本签名 `public mut operator func [](i: Int64, value!: VecR<T,Q>): Unit` 符合仓颉规范——索引赋值须有唯一命名参数 `value!`（skill:cangjie-function §8.3），与阶段一 `type_vec4.cj:47` 实现已验证一致。

**[通过]** 复合赋值运算符自动生成：仓颉函数文档 §8.5 明确声明"重载二元运算符（关系运算除外）时自动启用对应复合赋值版本，前提是返回类型与左操作数类型匹配或为其子类型"。设计正确识别了非方阵 `*=(Mat)` 不可用的原因（返回类型 != 左操作数类型），设计了手动回退方案作为防御。

**[通过]** `public static func length(): Int64` 在 struct 中合法（skill:cangjie-struct §1.5），与阶段一 `Vec4.length()` 一致。

**[通过]** `@Derive[Hashable]` 在 struct 上合法（skill:cangjie-deriving §1）。矩阵字段 `var c0: VecR<T,Q>` 等为 public，VecR<T,Q> 类型在阶段一已通过 `@Derive[Hashable]` 获得 Hashable 实现。不过，`@Derive[Hashable]` 要求"参与派生的字段类型必须已实现对应接口"（skill:cangjie-deriving §4），这意味着 `T`（矩阵元素类型）和 `Q`（Qualifier）也须实现 `Hashable`。`Q` 为 `PackedHighp`/`PackedMediump`/`PackedLowp`（struct 且已 `@Derive[Hashable]`），`T` 为 `Float32`/`Float64`/`Int32`/`Int64`/`Bool`（内置类型均实现 Hashable）。设计文档 §8 已包含跨元素类型编译验证项，覆盖了此风险。

**[通过]** 类型别名 `public type Mat2x2 = detail.Mat2x2<Float32, detail.PackedHighp>` 在文件顶层定义合法（skill:cangjie-type_system §5），阶段一 fwd.cj 已大量使用此模式。

**[轻微]** `fromMat` 6a/6b 共 144 个重载签名的构造量较大，设计建议代码生成脚本但未指定生成工具的具体输入格式。编码阶段可自行确定，不阻塞设计。

### 2. 标准库与生态覆盖

**[通过]** 设计中需要的能力均在仓颉标准库覆盖范围内：
- `Number<T>`/`Integer<T>`/`Equatable<T>`/`Comparable<T>`（来自 `std.math.*`，阶段一已导入使用）
- `Exception`（用于 stub 异常和越界抛出）
- `@Derive[Hashable]`（来自 `std.deriving.*`，阶段一已使用）
- `@OverflowWrapping`（内置注解，阶段一已使用）
- `assert`（阶段一 shim_assert.cj 已有使用模式）

**[通过]** `Qualifier` 接口和 `PackedHighp`/`PackedMediump`/`PackedLowp` 为项目自定义类型，阶段一已实现。

**[通过]** `common.cj` 中的 `floor`/`ceil`/`fract`/`min`/`max`/`abs`/`sign`/`clamp`/`mix`/`step`/`smoothstep` 等 stub 不涉及标准库函数的假设——它们是项目自有的数学函数 stub，后续阶段按 GLM 逻辑实现。`mod` 签名暂定性已正确标注并在 §8 列为阻断性验证项。

**[通过]** 子包 `glm.ext` 的构建可行性设计了三重备选方案（§2 cjpm 子包构建预验证），并在 §8 列为编码启动前验证项。

**[轻微]** `geometric.cj` stub 中的 `length`/`normalize`/`distance` 等函数最终实现需调用 `std.math.sqrt`，但当前为 stub 不涉及此依赖。设计正确推迟至后续阶段。

### 3. 语言特性可行性

**[通过]** 错误处理策略：`[]`/`col()` 越界时 `throw Exception(msg)`，stub 函数 `throw Exception("stub")`，`inverse` 对奇异矩阵推荐 `throw Exception("singular matrix")`。仓颉异常层次 `Exception`（非 `Error`）使用正确（skill:cangjie-error_handle、skill:cangjie-regulations §5.1）。

**[通过]** 并发设计：矩阵类型为值类型（struct），所有运算符返回新实例，天然线程安全。设计明确声明"本阶段不引入并发场景"，合理。

**[通过]** 资源管理方案：矩阵类型为值类型，无 `Resource` 接口需求，无 Manual 内存管理需求。`const init` 用于逐分量/列向量构造（纯赋值），`identity`/`diagonal`/`fromMat` 等涉及运算的为非 const extend 块工厂函数——与阶段一设计风格一致。

**[通过]** 模块/包结构设计：
- `glm.detail` 包：9 个矩阵类型 + 3 个 stub + scalar_mat_ops，同包内直接可见
- `glm` 包：fwd.cj 别名 + lib.cj 重新导出
- `glm.ext` 包：具现化别名
- 符合 cjpm 项目组织方式（skill:cangjie-package）：目录名与包名匹配，包声明位于文件首行

**[通过]** 同包内前向类型引用（Vec extend 块引用矩阵类型）：设计已识别此风险并列为"待验证"项（§8 compile order），提供了递进 fallback 方案（方案二首选→方案三→方案一最末降级），风险可控。

**[通过]** `mod` 签名暂定性：`Number<T>` 不提供 `%` 运算符（仅 `Integer<T>` 提供），设计已标注此为暂定并在 §8 列为阻断性验证项。deviations.md DV-02 明确 `%` 和 `mod` 仅在 `Integer<T>` 约束上下文中可用，DV-02 及 DEV-05 已记录浮点 mod 的具名函数重载路径。

**[通过]** `scalar_mat_ops.cj` 与 `scalar_vec_ops.cj` 同名函数重载解析：36 个标量-矩阵函数与 36 个标量-向量函数同名但第二参数类型不同（`Mat2x2<T,Q>` vs `Vec2<T,Q>`），按仓颉函数重载解析"最具体匹配"规则（skill:cangjie-function §7.3），编译器可按参数类型正确消歧。§8 已列为阻断性验证项，编码启动日验证确认。

**[通过]** `const init` 可用性：渐进式构造函数（item 1 逐分量、item 2 列向量）声明为 `const init`，与阶段一 `Vec4` 的 `const init` 模式一致。`diagonal`/`identity`/`fromMat` 等涉及 `Number<T>` 运算的为非 const extend 块函数，无法声明 const，设计正确。

**[通过]** NaN 比较行为设计：`==` 对 NaN 返回 false，`!=` 对 NaN 返回 true（因实现为 `!(this == rhs)`），`equalEpsilon` 对 NaN 返回 false。这与 IEEE 754 语义一致，仓颉 `Float64.NaN` 的比较行为与设计描述匹配（skill:cangjie-std-math §6："NaN 与任何值比较均为 false，包括自身"）。

### 4. 设计一致性

**[通过]** 各抽象职责描述清晰：9 个矩阵类型（值对象）、common.cj（基础数学 stub）、matrix.cj（部分实现+部分 stub）、geometric.cj（几何 stub）、scalar_mat_ops.cj（标量左侧全局函数），无歧义。

**[通过]** 协作关系形成闭环：type_mat3x3 → common.cj + matrix.cj（stub），type_mat4x4 → matrix.cj + geometric.cj（stub），非方阵无 stub 依赖。所有依赖均闭合。

**[通过]** 行为契约描述完整：§4 关键行为契约覆盖矩阵构造、乘法、跨尺寸转换、跨类型转换等核心场景，§3.3 编码模板示例提供了两个代表性方向的完整函数体，足以指导后续实现。

**[通过]** 模块间依赖方向合理，无循环依赖。依赖链为：`glm.ext → glm.detail`、`glm → glm.detail`，`glm.detail` 内部无跨包依赖。同包内 stub 文件排在矩阵类型文件之前的编译顺序已设计（§8 compile order）。

**[通过]** `fromMat` 6a/6b 纯收缩方向 `one` 参数被忽略的行为已在 §3.3 明确说明，§9 差异声明中已显式声明此为 API 设计偏差。

**[通过]** `diagonal(scalar)` 对所有 9 个矩阵类型均提供的决策已与 GLM 源码逐项对照验证，§3.3 item 3 和 §9 差异声明一致。

**[通过]** 矩阵-矩阵除法奇异矩阵行为已在 §5 明确声明（inverse 推荐抛异常，异常通过 `A * inverse(B)` 传播），并覆盖 `*=(Mat)` 和 `/=(Mat)` 复合赋值运算符。

**[通过]** Vec2 `cross` 属 gtx 扩展的标注已在 §3.7 geometric.cj 签名清单和 §10 覆盖矩阵中追踪。

**[通过]** `mod` 签名暂定性已升级为 §8 阻断性验证项，引用 deviations.md DV-02 作为证据。

**[通过]** 编码模板示例使用 `.x`/`.y` 属性访问替代 `[0]`/`[1]` 下标访问，并注明理由（避免 assert 开销）。

**[通过]** `scalar_mat_ops.cj` 与 `scalar_vec_ops.cj` 同名函数重载歧义验证已纳入 §8 阻断性验证项。

**[通过]** `geometric.cj` Vec1 版本潜在覆盖差异已在 §3.7 和 §10 标注为"潜在覆盖差异，阶段四确认"。

**[通过]** fwd.cj 别名族精度统计说明已补充"GLM 含 defaultp 共 4 精度级别，仓颉版实际 3 独立精度族"的注释（§10 fwd.hpp 别名覆盖矩阵）。

**[通过]** 矩阵测试文件规划已纳入 §8 产出物清单（沿用阶段一组织和命名约定）。

**[通过]** fwd.cj 别名导入连续性确认已在 §8 说明（`import glm.detail` 已存在，矩阵别名命名与向量别名命名正交无冲突）。

**[轻微]** `fromMat` 四项基本操作的组合规则（先列后行）虽数学等价，但对"跨列扩展同时行扩展再列收缩"等复合方向，编码阶段可能需要验证 `colExtend + rowExtend + rowShrink` 等三步组合的正确性。设计仅覆盖两步组合，但 72 个方向均可由两步覆盖（C 和 R 各最多一次操作），因此逻辑上自洽。此为编码阶段验证细节，不阻塞设计。

### 5. 设计质量

**[通过]** 职责划分遵循单一职责：每个矩阵类型文件仅负责该尺寸的结构体定义和运算符重载；stub 文件仅提供依赖闭合；scalar_mat_ops.cj 仅处理标量左侧全局函数。

**[通过]** 抽象层次恰当：设计为架构级 OOD，提供了构造函数体系签名、运算符签名、stub 函数签名、泛型约束策略、编码模板示例等——足以指导后续实现但不过度细化（如未指定具体字段布局偏移、未列出 144 个 fromMat 签名的完整清单）。

**[通过]** 设计便于后续详细设计和实现：编码模板示例（§3.3 示例 1/2）展示了两个代表性方向的完整函数体，四项基本操作的组合规则提供了统一的实现框架，代码生成脚本建议降低了 144 个签名的手动编写负担。

**[通过]** 设计便于单元测试：矩阵类型为值类型，运算符无副作用，可独立测试。§3.3 编码阶段验证要求覆盖了 B 类方向和非 B 类方向的测试策略。阶段一测试模式（`type_vec4_test.cj`）可直接沿用到矩阵测试。

**[通过]** Bool 矩阵的完整操作清单和不提供操作清单已在 D33 中显式列出，避免了实施者遗漏。

**[通过]** 11 个审查问题均已在 v36 迭代中采纳修改，8 个持续性问题已得到系统性解决。

## 修改要求（REJECTED 时存在）

无严重或一般问题。
