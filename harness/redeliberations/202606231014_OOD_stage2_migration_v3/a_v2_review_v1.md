# OOD 设计方案审查报告（v2）

## 审查结果

APPROVED

## 逐维度审查

### 1. 类型系统可行性

**[通过]** 矩阵类型选择 `struct`（值类型）与阶段一 Vec 类型一致，值语义确保运算符返回新实例、无副作用，与仓颉 struct 的值复制行为匹配。

**[通过]** 9 个独立泛型结构体 `Mat{C}x{R}<T,Q>` 的设计合理——仓颉不支持模板偏特化，无法实现统一泛型 `Mat<C,R,T,Q>` 后按 C/R 参数分别特化（§3.1 解释充分）。

**[通过]** 泛型约束体系设计正确：(1) 构造函数和基础访问仅需 `Q <: Qualifier`；(2) 算术运算符 extend 块使用 `T <: Number<T>, Q <: Qualifier`；(3) 比较运算 extend 块使用 `T <: Equatable<T>` 和 `T <: Number<T> & Equatable<T> & Comparable<T>` 分层——这与阶段一 Vec 类型实现（`type_vec4.cj:70`：`extend<T, Q> Vec4<T, Q> where T <: Number<T>, Q <: Qualifier`）模式一致。

**[通过]** `[]` 赋值版本签名 `public mut operator func [](i: Int64, value!: VecR<T,Q>): Unit` 符合仓颉函数文档 §8.3 规范要求（赋值形式须有唯一命名参数 `value!`，返回 `Unit`），与阶段一 Vec 实现一致（`type_vec4.cj:47`），`mut` 修饰符正确标注（struct 内修改数据成员需要 `mut`）。

**[通过]** 协作关系中描述的类型交互模式均可实现：(1) Mat→Vec 的列向量数据成员使用具体 `VecN<T,Q>` 类型；(2) Mat×Vec 成员运算符定义在矩阵类型内，Vec×Mat 成员运算符定义在 Vec extend 块中；(3) 标量-矩阵运算通过全局函数处理 `operator func` 的左操作数约束。

**[轻微]** `Comparable<T>` 接口继承 `Equatable<T>` 的关系在设计文档中未显式声明理由——例如 `abs`/`sign` 的约束从 `Equatable<T>` 修正为 `Comparable<T>` 后，`Comparable<T>` 已继承 `Equatable<T>`，两者同时出现时 `Equatable<T>` 冗余。当前设计中 `equalEpsilon` 的约束为 `Number<T> & Equatable<T> & Comparable<T>`，其中 `Equatable<T>` 冗余（`Comparable<T>` 已继承它）。但这仅为可读性改进，不影响编译行为或设计可行性。

### 2. 标准库与生态覆盖

**[通过]** 设计所需的标准库能力均在覆盖范围内：(1) `Number<T>`、`Integer<T>`、`Comparable<T>`、`Equatable<T>` 接口来自 `std.math`/`std.core`；(2) `@Derive[Hashable]` 自动派生来自 `std.deriving`；(3) `@OverflowWrapping` 注解来自语言内置；(4) `Exception` 异常体系来自 `std.core`。

**[通过]** stub 函数库中 `common.cj` 的 `mod` 函数约束标注为暂定（`Number<T>` 不直接提供 `%` 运算符，仅 `Integer<T>` 提供），设计文档已显式标注此暂定状态并说明编码阶段需拆分为整数版本和浮点重载——合理，不阻塞设计。

**[通过]** 标准库 `std.math` 提供 `abs`、`ceil`、`floor`、`clamp` 等标量函数，但设计中选择在 `common.cj` 中提供 stub 而非直接复用标准库——合理，因为 GLM 的函数签名模式（以 `T <: Number<T>` 约束的泛型函数）与标准库的具体类型重载模式不同，独立 stub 可保持 API 一致性。

**[轻微]** `@Derive[Hashable]` 需要字段类型已实现 `Hashable` 接口。矩阵类型的列向量成员 `VecR<T,Q>` 需自身实现 `Hashable` 才可自动派生。阶段一 Vec 类型已标注 `@Derive[Hashable]`（`type_vec4.cj:6`），但自动派生要求类型为 final class——Vec 是 struct，`@Derive` 文档说明 struct 也可使用 `@Derive`，但要求"参与派生的字段必须为 public 且其类型已实现对应接口"。这意味着需要 `VecN<T,Q>` 的所有元素类型 `T` 都实现 `Hashable`，此约束是否满足取决于 extend 块的条件——仅在 `T` 实现 `Hashable` 时才能派生。编码启动前验证项已包含此项（§8），合理。

### 3. 语言特性可行性

**[通过]** 错误处理策略与仓颉能力匹配：(1) 下标越界使用 `assert` + `throw Exception`（与阶段一 Vec 一致）；(2) stub 函数体 `throw Exception("stub")` 占位——合法；(3) NaN 比较行为遵循 IEEE 754 语义，委托 Vec 类型实现。

**[通过]** 并发设计：不引入并发场景，矩阵类型为值类型、运算符返回新实例，天然线程安全——合理。

**[通过]** 资源管理方案：矩阵类型为 struct，无需要手动管理的资源（无文件句柄、无网络连接等），依赖值语义自动复制——合理。

**[通过]** 模块/包结构设计符合 cjpm 项目组织方式：(1) `glm.detail` 包为核心实现层；(2) `glm` 包为公共 API + 别名层；(3) `glm.ext` 包为具现化别名层；(4) 包的组织符合仓颉"目录名须与包名匹配"规则；(5) cjpm 子包构建预验证方案（§2）提供了三个递进方案和原型验证计划——设计充分。

**[通过]** 复合赋值运算符自动生成：设计文档已明确声明为语言规范保证行为（函数文档 §8.5 原文："重载二元运算符（关系运算除外）时自动启用对应复合赋值版本，前提是返回类型与左操作数类型匹配或为其子类型"）。手动定义回退方案已移至附录 A 并标注为防御性措施，编码启动前验证项降级为可选非阻断性测试——正确，非方阵 `*=(Mat)` 不自动生成（因结果类型与左操作数不一致）的解释也合理。

**[通过]** `@OverflowWrapping` 标注策略：覆盖所有整数相关算术运算符（矩阵-标量、标量-矩阵、矩阵-矩阵 ±*、矩阵-向量 * 等），与阶段一 Vec 类型实现一致（`type_vec4.cj:71-72`），符合仓颉整数溢出注解规范。

**[通过]** `const init` 构造函数：逐分量同类型构造和列向量构造使用 `const init`——与仓颉 const 函数/构造函数特性匹配（const init 中仅允许纯赋值操作，无运算）。

**[通过]** 编译顺序问题：Vec extend 块中行向量×矩阵运算符引用矩阵类型，同包内前向类型引用的延迟解析需原型验证。设计文档已提供三个递进 fallback 方案，包括 API 降级路径（从 `v * m` 退化到 `mulRowVecMat(v, m)`）——充分，编码阶段可确认。

### 4. 设计一致性

**[通过]** 各抽象的职责描述清晰：矩阵结构体为值对象承载 C 个列向量数据成员；stub 函数库仅提供闭合依赖的签名空壳；scalar_mat_ops.cj 处理标量左侧运算——无歧义。

**[通过]** 协作关系形成闭环：Mat→Vec（列向量成员）→Mat（Vec extend 块中行向量乘矩阵返回 Vec）→scalar_mat_ops.cj（全局函数操作 Mat）→lib.cj（导出）→fwd.cj（别名），无缺失环节。

**[通过]** 行为契约描述充分：identity、diagonal 的编码路径已给出（T(0) 演算策略、one 参数传入方式），fromMat 四项基本操作（colExtend/colShrink/rowExtend/rowShrink）已给出数学定义和组合规则，编码模板示例提供了两个代表性方向的完整仓颉函数体。

**[通过]** 模块间依赖方向合理，无循环依赖：type_mat→type_vec（单向）、scalar_mat_ops→type_mat（单向）、fwd.cj/lib.cj→detail（单向）。

**[通过]** `[]` 和 `col()` 的设计一致性已澄清：`[]` 提供取值和赋值双版本，`col()` 仅提供取值版本（struct 值语义下 `mut func` 返回副本而非引用），赋值语义通过 `[]` 或直接字段赋值实现——逻辑自洽。

**[通过]** D34 决策记录了 `identity(one)` 与 `diagonal(one)` 在方阵上的等价关系和委托实现方式——消除了此前行为重叠未记录的问题。

**[通过]** D35 决策明确了 `type_float.cj`/`type_half.cj` 推迟至阶段四——消除了路线图可选项在设计文档中缺席的问题。

**[通过]** §8 lib.cj 导出清单中显式说明 `mod` 不在 `scalar_mat_ops.cj` 中提供，现有 `mod` 导出仅需覆盖向量版——消除了此前未说明的交互问题。

### 5. 设计质量

**[通过]** 职责划分遵循单一职责原则：矩阵结构体仅承载数据和基础运算符；stub 文件仅提供占位签名；scalar_mat_ops.cj 仅处理标量左侧运算；fwd.cj 仅定义别名；lib.cj 仅负责导出。

**[通过]** 抽象层次恰当：(1) 不为 9 个矩阵类型设置统一的泛型基类（仓颉不支持偏特化）；(2) 为需要 T(0)/T(1) 的功能统一采用 Number<T> 约束 + 显式 one 参数策略而非每个函数单独设计；(3) fromMat 拆分为 6a/6b/7 三类而非统一的"万能转换"——减少不必要的约束传播。

**[通过]** 设计便于后续详细设计和实现：(1) 27 个乘法重载的签名表已完整列出（左右矩阵类型→结果类型映射明确）；(2) 36 个 scalar_mat_ops 全局函数签名模板已提供 add 族的完整 9 重载清单；(3) fromMat 6a/6b 的编码策略已规则化为四项基本操作的组合；(4) 代码生成脚本建议可降低 144+9 个签名的手动编写负担。

**[通过]** 设计便于单元测试：(1) 矩阵类型为 struct，构造和比较可直接内联进行，无需 mock；(2) stub 函数以 `throw Exception("stub")` 占位，测试可验证异常抛出行为；(3) Mat4x4←Mat4x2 偏差方向有专用测试要求；(4) NaN 传播策略有具体测试场景覆盖。

**[通过]** 矩阵-矩阵除法运算符签名已补充（Mat2x2/Mat3x3/Mat4x4 各一版，内部实现为 `this * inverse(rhs)`，依赖 inverse stub），同步更新 §10 API 覆盖矩阵——消除了此前签名完全缺失的问题。

**[通过]** `abs` 和 `sign` 的泛型约束已从 `Equatable<T>` 修正为 `Comparable<T>`（§3.7 common.cj 签名清单第 573-574 行），满足 `<`/`>` 比较运算需求——消除了此前约束不匹配的问题。

**[轻微]** `outerProduct` 实现说明中公式已从 `c * r[j]` 改写为 `M[j][i] = c[i] * r[j]`（i 为行索引，j 为列索引），消除命名歧义。但公式中 `c` 和 `r` 的命名（c = 列向量模板、r = 行向量模板）仍可能与直觉产生"c 对应列数"的误解。不过维度关系已于同段注明 `len(c) = R`（行数）、`len(r) = C`（列数），足以消除歧义。此为可读性提示，不阻塞。
