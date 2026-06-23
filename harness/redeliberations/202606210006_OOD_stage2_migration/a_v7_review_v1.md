# OOD 设计方案审查报告（v1）

## 审查结果

APPROVED

## 逐维度审查

### 1. 类型系统可行性

**[通过]** 矩阵类型选择 `struct`（值类型）作为类型形态，与阶段一 Vec 类型一致，符合仓颉 struct 的值语义和栈分配特性，对固定尺寸矩阵（最大 4×4=16 标量）性能友好。

**[通过]** 9 个独立泛型结构体（Mat2x2 ~ Mat4x4）的设计决策合理。仓颉不支持模板偏特化，无法实现 `Mat<C, R, T, Q>` 后按 C/R 参数分别特化，独立类型是唯一可行方案。

**[通过]** 泛型约束策略正确：struct 体内 `T` 无约束（仅 `Q <: Qualifier`），算术运算符在 `extend<T, Q> where T <: Number<T>` 块中定义，比较运算符在 `Equatable<T>` / `Number<T> & Equatable<T> & Comparable<T>` 块中定义。此模式与阶段一 Vec 实际实现完全一致（已验证 `type_vec2.cj` 的 extend 块约束方式）。

**[通过]** T(0)/T(1) 获取问题的统一处理策略正确：T(0) 通过 `someValue - someValue` 在 `Number<T>` 约束上下文中演算，T(1) 通过参数传入。此策略与 deviations.md DV-01 记录的 `fromBoolVec` 处理方式（要求调用方显式传入 `zero: T, one: T`）属同一根因的同类解决方案，设计一致性良好。`!`（按位取反）属于 `Integer<T>` 而非 `Number<T>`（与 deviations.md DV-02 `%` 运算符仅 `Integer<T>` 提供为同类限制），Float32/Float64 不实现 `Integer<T>`，因此 `identity(one: T)` 参数方案是唯一可行选择。

**[通过]** 构造函数与工厂函数的降级策略在仓颉类型系统中可行：`init` 必须在 struct 体内定义（不能在 extend 块中定义），而 struct 体内 `T` 无约束——需 `Number<T>` 运算的功能（`filled`、`identity`、`fromMat` 跨尺寸转换）统一降级为 `Number<T>` 约束 extend 块中的静态工厂函数。跨类型构造（`fromParts`、`fromColumns`、`fromMat(m, conv)`）降级为带 conv 闭包的工厂函数，与阶段一 `castVecN(v, conv)` 模式一致。

**[通过]** 单继承、多接口实现的约束下，矩阵类型不涉及继承层次，仅通过 extend 块实现接口约束的功能扩展，在仓颉类型系统内完全可行。

**[轻微]** `filled(scalar: T)` 的 `Number<T>` 约束上下文中，`scalar - scalar` 获得 T(0) 的演算方式在语义上正确（`a - a = 0` 对所有满足 `Number<T>` 的类型成立），但 `filled` 的 T(1) 不需要（非方阵对角线长度 min(C,R)，标量填充的对角线值就是传入的 `scalar`），设计已正确区分了 `filled` 和 `identity` 对 T(1) 的需求差异，无需修改。

### 2. 标准库与生态覆盖

**[通过]** 核心依赖 `std.math.Number`、`std.math.Integer`、`std.deriving` 均在阶段一实际使用中验证可行（`type_vec2.cj` 已 `import std.math.{ Number, Integer }` 和 `import std.deriving.*`）。

**[通过]** `@Derive[Hashable]` 的使用合理：阶段一 Vec 类型已实际使用此注解并编译通过，矩阵类型以 Vec 列向量为成员，全部成员可哈希的条件满足。仓颉 `@Derive[Hashable]` 对泛型 struct 的编译器检查策略（延迟检查 vs 定义处检查）在阶段一编码中已实际验证。

**[通过]** `@OverflowWrapping` 注解在阶段一 `scalar_vec_ops.cj` 中已使用，矩阵版本 `scalar_mat_ops.cj` 复用同一模式可行。

**[通过]** stub 函数库（common.cj、matrix.cj、geometric.cj）依赖的 `std.math` 数学函数（min、max、abs 等）和几何函数（dot、cross、normalize 等）均在仓颉标准库覆盖范围内。stub 仅提供空壳签名，不依赖实际功能。

### 3. 语言特性可行性

**[通过]** 错误处理策略与阶段一一致：下标越界使用 `assert` + fallback `throw Exception`，已在 Vec2 实际实现中验证可行（`type_vec2.cj:29-34`）。`[]` 和 `col()` 受 `assert`/`throw` 限制不可为 `const func`，此行为与 `componentAt` 的限制一致（deviations.md IF-03）。

**[通过]** 并发设计：矩阵为 struct 值类型，运算符返回新实例，天然线程安全，无需额外同步机制，符合仓颉并发模型。

**[通过]** 资源管理：矩阵为纯值对象，不持有需释放的资源，无需 `Resource` 接口管理。

**[通过]** 模块/包结构符合 cjpm 项目组织方式：glm.detail（核心实现）、glm（公共 API + 别名）、glm.ext（具现化别名）的三层结构与仓颉包路径匹配规则一致（§2 ext/ 包名策略为 Option 1：src/ext/ 下文件声明 package glm.ext，路径与包名匹配）。

**[通过]** `mut operator func [](i: Int64, value!: VecR<T,Q>): Unit` 签名正确：仓颉 struct 的 `mut` 函数可原地修改成员变量，阶段一 Vec2 的 `mut operator func [](i: Int64, value!: T): Unit` 已验证此模式可行（`type_vec2.cj:37-44`）。

**[通过]** const init / const func 可用性分析准确：逐分量同类型构造和列向量构造为 `const init` 可用（纯赋值），其余工厂函数涉及运算或闭包调用不可为 const。`identity` 和 `filled` 涉及 `one - one` / `scalar - scalar` 运算，仓颉 const 表达式规则不允许泛型约束运算，分析正确。

**[通过]** 复合赋值运算符的自动生成条件分析正确：仅方阵 `*=`（mat）因返回类型与左操作数类型相同而自动生成，非方阵矩阵乘法结果类型不同故不会自动生成。

### 4. 设计一致性

**[通过]** 各抽象的职责描述清晰：9 个矩阵类型各自的结构体定义、extend 块功能划分、stub 文件定位、别名文件组织均有明确职责描述。

**[通过]** 协作关系形成闭环：矩阵-向量乘法（Mat * Vec → Vec、Vec * Mat → Vec）、跨尺寸矩阵乘法（27 个有效重载）、标量-矩阵全局函数（36 个重载）的协作关系完整。矩阵类型以 Vec 列向量为数据成员，运算符在 Number<T> 约束的 extend 块中定义，与阶段一 Vec 的模式一致。

**[通过]** 行为契约完整：构造函数体系（8 类构造/工厂）、const init 可用性汇总表、跨尺寸乘法兼容性表、填充规则精确描述均足以指导后续实现。

**[通过]** 模块间依赖方向合理：glm.detail 为核心层，glm 和 glm.ext 均单向依赖 glm.detail，glm 与 glm.ext 同级互不依赖，无循环依赖。同包内类型互相直接可见，无需跨文件 import。

**[通过]** lib.cj 导出歧义评估合理：`add`/`sub`/`mul`/`div` 在 scalar_vec_ops.cj 和 scalar_mat_ops.cj 中同名但参数类型不同（Vec 型 vs 矩阵型），同属 glm.detail 包，为同一组重载函数。无论从 `import glm.*` 还是 `import glm.detail.*` 引入，最终引用目标函数完全相同，不产生歧义。

**[通过]** D20 ~ D26 设计决策为 v10 新增的 7 个决策，系统性地解决了上一轮审查发现的 T(0)/T(1) 获取、构造函数降级、const 可用性、库导出歧义等全部 12 个问题。

### 5. 设计质量

**[通过]** 职责划分遵循单一职责原则：struct 体内仅含数据成员、构造函数、下标运算符和 length 函数；算术运算符在 Number<T> extend 块中；比较运算符在 Equatable<T>/Comparable<T> extend 块中；标量左侧运算在独立文件 scalar_mat_ops.cj 中。与阶段一 Vec 的组织方式一致。

**[通过]** 抽象层次恰当：设计覆盖了类型定义、构造函数体系、运算符体系、别名体系、包组织、stub 策略、差异声明等必要维度，未过度设计（如排除了低频的 fmat/整型矩阵别名、行访问推迟至阶段四），也未设计不足（提供了完整的跨尺寸乘法兼容性表、详细的填充规则、const 可用性汇总）。

**[通过]** 设计便于后续详细设计和实现：构造函数/工厂函数的签名、约束条件、降级理由、const 可用性均已明确，编码阶段可直接按设计方案实现。与阶段一的 castVecN conv 闭包模式提供了直接的实现参考。

**[通过]** 设计便于单元测试：矩阵类型为值对象（struct），运算符返回新实例，可独立测试。别名类型测试已明确要求验证构造函数和运算符可用性。scalar_mat_ops.cj 的全局函数可独立调用测试。stub 函数的测试策略（调用时抛出 stub 异常）也已明确。

**[轻微]** `fromMat` 跨矩阵类型转换工厂函数在实际编码时，对于有 8 种源矩阵尺寸的每个目标矩阵类型需实现 8 个重载。9 个矩阵类型合计 72 个工厂函数，编码工作量较大。但设计中已明确这是低频操作且语义更明确，此为工程量提示而非设计缺陷。
