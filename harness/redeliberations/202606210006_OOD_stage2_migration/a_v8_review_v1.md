# OOD 设计方案审查报告（v1）

## 审查结果

APPROVED

## 逐维度审查

### 1. 类型系统可行性

**[通过]** 9 个矩阵类型各自为独立泛型结构体（`struct Mat{C}x{R}<T, Q>`），与阶段一 Vec 类型策略一致，仓颉结构体支持多类型参数泛型和 `where` 约束，类型形态选择正确。

**[通过]** 列向量成员类型由矩阵尺寸确定（如 Mat4x4 的 c0~c3 均为 Vec4<T,Q>），使用处直接引用具体 VecN<T,Q> 类型而非内部类型别名——仓颉类型别名只能在文件顶层定义（类型系统文档 §5.2），此设计符合语言约束。

**[通过]** 矩阵类型的继承/实现关系：struct 无继承，通过 extend 块实现接口（如 `@Derive[Hashable]`、`Number<T>` 约束的扩展块中的运算符）。仓颉允许同一类型的多个扩展块，且泛型扩展支持 `where` 约束（extend 文档 §2.3-§2.4），此模式已在阶段一 Vec 类型中验证通过。

**[通过]** fromMat 拆分为 6a（同类型）和 6b（跨类型）两个独立工厂函数。6a 的 `public static func fromMat<SrcQ>(m: Mat{C_src}x{R_src}<T, SrcQ>, one: T)` 中 SrcQ 作为额外类型参数出现在源矩阵类型中，在 `extend<T, Q> Mat{C}x{R}<T, Q> where T <: Number<T>` 块中定义。仓颉扩展中的静态泛型函数可声明额外类型参数（泛型文档 §2(e)），此签名可行。

**[通过]** 6b 的 `public static func fromMat<SrcT, SrcQ>(conv: (SrcT) -> T, m: Mat{C_src}x{R_src}<SrcT, SrcQ>, one: T)` 通过 conv 闭包解决 SrcT≠T 时的类型转换问题。仓颉函数类型 `(SrcT) -> T` 可在泛型上下文中使用，类型系统支持此模式（castVecN 已在阶段一实现中验证）。

**[通过]** 跨类型同尺寸转换（第 7 条）`fromMat<U, P>(m: Mat4x4<U, P>, conv: (U) -> T)` 与 fromColumns/fromParts 统一采用 conv 闭包模式，与阶段一 castVecN 模式一致。

**[通过]** fromColumns 单一 V1 类型参数、fromParts 单一 U 类型参数的限制：仓颉泛型函数中每个类型参数须在签名中声明，多列独立类型参数将导致签名膨胀。此为仓颉泛型系统的容量限制，设计已正确识别并在 §9 差异声明中记录。

**[通过]** 用户自定义泛型类型在所有类型参数处不变（类型系统文档 §3），Mat4x4<Float32, PackedHighp> 与 Mat4x4<Float32, AlignedHighp> 为不同类型，SrcQ 参数的设置合理。

**[通过]** 运算符重载在 `Number<T>` 约束的 extend 块中定义：仓颉扩展可为类型添加运算符重载函数（extend 文档 §2.2），且约束条件 `where T <: Number<T>` 正确过滤了可用运算（+、-、*、/）。

### 2. 标准库与生态覆盖

**[通过]** 矩阵运算所需的核心能力（算术运算符、比较运算符、下标运算符）均在仓颉语言核心特性范围内，不需要额外的第三方库。

**[通过]** `Number<T>` 接口来自 `std.math`，阶段一已使用 `import std.math.{ Number, Integer }`，此依赖已验证。

**[通过]** `@Derive[Hashable]` 来自 `std.deriving.*`，阶段一 Vec 类型已使用。矩阵类型包含 Vec 列向量成员，Vec 已可哈希，因此矩阵的 @Derive[Hashable] 满足前提条件（所有成员可哈希）。

**[通过]** `@OverflowWrapping` 注解来自仓颉内置，阶段一 scalar_vec_ops.cj 中已使用全部 20 个函数标注此注解，阶段二 scalar_mat_ops.cj 的 36 个函数同法标注可行。

**[通过]** stub 函数库（common.cj、matrix.cj、geometric.cj）仅需空壳签名和 throw Exception 占位，Exception 为仓颉标准异常体系的一部分，无需额外库支持。

**[轻微]** geometric.cj 中 distance 函数签名存在一处排版错误：第 463 行 `Q <| Qualifier` 中 `<|` 应为 `<:`。此为文档排版错误，不影响设计可行性，编码时可直接修正。

### 3. 语言特性可行性

**[通过]** 错误处理策略：下标越界时抛出 Exception（含 assert + fallback throw），与阶段一 Vec 的 componentAt 策略一致。仓颉 Exception 为标准异常基类（错误处理文档 §1.2），可继承也可直接抛出。

**[通过]** identity(one: T) 不可为 const func 的分析正确：const 函数中表达式须为 const 表达式，`one - one` 涉及泛型约束运算，不满足 const 表达式规则（const 文档 §2.7 仅覆盖"数值类型的算术表达式"，此处 T 为泛型参数非具体数值类型）。

**[通过]** filled(scalar: T) 不可为 const init 的分析正确：const init 体内仅允许纯赋值表达式（const 文档 §4.2），`scalar - scalar` 涉及运算不可用。

**[通过]** 逐分量同类型构造（§3.3 第 1 条）声明为 const init：该构造函数仅涉及纯赋值操作（将标量参数赋给列向量分量），满足 const init 要求。

**[通过]** 列向量构造（§3.3 第 2 条）声明为 const init：Vec2~Vec4 阶段一已提供 const init，此构造函数内部为纯赋值，可行。

**[通过]** 资源管理方案：矩阵为值类型 struct，运算符返回新实例，无需显式资源管理。仓颉 struct 赋值/传参时自动复制（struct 文档 §2.3），与阶段一 Vec 行为一致。

**[通过]** 模块/包结构：`src/detail/` → `package glm.detail`、`src/ext/` → `package glm.ext`、`src/` → `package glm`，目录路径与包名匹配。cjpm 的 src-dir 配置覆盖 src/ext/ 目录，子包发现机制已在 §2 中标注为编码启动前须验证项。

**[通过]** `mut operator func [](i: Int64, value!: VecR<T,Q>): Unit` 赋值版本使用 mut 修饰符——仓颉 struct 的 mut 函数规则（struct 文档 §3）允许 mut 修饰运算符函数（§3.5），阶段一 Vec2 已有 `mut operator func [](i: Int64, value!: T): Unit` 先例。

**[通过]** 复合赋值运算符由编译器自动生成（当二元运算符返回类型与左操作数类型匹配时），此为仓颉语言特性，阶段一已验证。

**[通过]** scalar_mat_ops.cj 与 scalar_vec_ops.cj 同属 glm.detail 包，同名包级函数通过参数类型重载自然区分——仓颉函数重载解析规则（function 文档 + package 文档 §4.3）已明确覆盖此场景。

### 4. 设计一致性

**[通过]** 各抽象职责描述清晰：9 个矩阵类型各自为独立泛型结构体，职责为"表示 C×R 数学矩阵的值对象"；3 个 stub 文件为依赖闭合的空壳签名；scalar_mat_ops.cj 处理标量左侧矩阵运算。职责划分无歧义。

**[通过]** 协作关系形成闭环：矩阵类型以 Vec 列向量成员为数据载体，运算符在 extend 块中定义，类型别名在 fwd.cj 和 ext/ 文件中提供，lib.cj 统一导出。矩阵→向量依赖已明确，矩阵间乘法通过同包直接可见引用。

**[通过]** 行为契约描述完整：§4 提供了 identity、filled、矩阵乘法、跨尺寸转换（同类型 6a + 跨类型 6b）、跨类型同尺寸转换、分量级修改操作、ext/ 别名使用共 7 个行为契约示例，覆盖了所有关键构造和操作路径。

**[通过]** 模块间依赖方向合理，无循环依赖：glm.detail → glm.detail 内部类型引用（同包直接可见）；glm + glm.ext → glm.detail（单向依赖）；glm 与 glm.ext 同级无相互依赖。

**[通过]** §9 差异声明完整：涵盖了无 C 数组成员、无条件编译、无 ++/--、ext/ 包名差异、矩阵-矩阵除法推迟、标量左侧全局函数、无类型别名体系、无 row() 成员函数、col() 代替 componentAt()、[] 返回副本/不提供 componentAt 赋值版本、fwd.cj 别名排除、非方阵无 *=（mat）、无 init() 默认构造、filled 工厂降级、fromMat 拆分、fromParts/fromColumns 单类型限制、fromMat(m, conv) 同尺寸转换、[]/col() 不可 const、identity/filled 不可 const 等全部差异。

**[通过]** fromColumns 单一 V1 限制、fromParts 单一 U 限制已标注为与 C++ GLM 的容量差异，并在 §9 差异声明中记录（D28、D29）。

### 5. 设计质量

**[通过]** 职责划分遵循单一职责原则：每个矩阵类型仅负责自身的矩阵表示和运算；标量左侧运算抽取为独立的 scalar_mat_ops.cj；跨类型转换统一采用 conv 闭包模式（与 castVecN 一致）；stub 函数库仅提供空壳签名。

**[通过]** 抽象层次恰当：9 个独立矩阵类型（不过度设计为 C×R 参数化泛型——仓颉不支持模板偏特化；也不过细地将每个运算分拆为独立类）；extend 块中按约束条件分组运算符（Number<T> 约束放算术，Equatable<T> 约束放比较，Number<T> & Equatable<T> & Comparable<T> 约束放浮点容差比较），与阶段一 Vec 模式完全一致。

**[通过]** 设计便于后续详细设计和实现：结构体成员变量（c0~c3 列向量）已明确定义；构造函数/工厂函数签名和填充规则已逐一说明；运算符签名和语义已完整列出；stub 函数清单已完整提供；编码阶段注意事项（如 GLM .inl 填充规则局部差异）已标注。

**[通过]** 设计便于单元测试：矩阵类型为值类型 struct，运算符返回新实例，天然可隔离测试。别名类型构造函数和运算符可用性验证已在 §8 测试文件中列出。castVecN 风格的 conv 闭包使跨类型测试可直接构造测试用例（如 `{ x => Float32(x) }`）。

**[通过]** fromMat 6a/6b 拆分解决了此前连续两轮未解决的严重问题：同类型版本无需 conv 闭包（签名简洁），跨类型版本通过 conv 闭包完成元素转换（类型安全），两个版本各司其职无歧义。

**[轻微]** stub 函数签名中 `matrix.cj` 的 `transpose` 和 `matrixCompMult` 使用 `Mat{C}x{R}` 占位符——编码阶段需逐一替换为 9 个具体矩阵类型的独立重载签名。此为架构设计级别的正常抽象，不阻塞通过。
