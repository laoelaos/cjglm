# OOD 设计方案审查报告（v14/v16）

## 审查结果

APPROVED

## 逐维度审查

### 1. 类型系统可行性

**[通过]** 9 个矩阵类型各自独立定义为泛型结构体（struct），与仓颉不支持模板偏特化的限制一致，设计合理。每个矩阵以列向量（VecN<T,Q>）为数据成员，类型映射关系清晰。

**[通过]** `extend<T, Q> Mat{C}x{R}<T, Q> where T <: Number<T>, Q <: Qualifier` 的泛型扩展语法有效，符合仓颉 extend 文档中"扩展泛型类型—形式 B：带新类型参数的泛型扩展"要求（§2.3），且 `where` 约束语法匹配文档 §2.4 示例。

**[通过]** 静态工厂函数（`identity`、`filled`、`fromMat`、`fromParts`、`fromColumns`）在 extend 块中定义，使用 `public static func`，符合 extend 文档第 4.2 节允许的成员修饰符列表。

**[通过]** 运算符重载定义在 extend 块中（如 `operator func -()`、`operator func [](i: Int64)`、`operator func /(rhs: T)`），符合 function 文档 §8.1—"只能在 class、interface、struct、enum、extend 中定义"的要求。

**[通过]** `[]` 赋值运算符签名格式 `mut operator func [](i: Int64, value!: VecR<T,Q>): Unit` 符合 function 文档 §8.3 赋值形式要求（唯一命名参数 `value!`，返回 `Unit`）。`mut` 修饰符在 struct 扩展中有效（struct 文档 §3.2）。

**[通过]** `const func length(): Int64` 声明有效。struct 已定义 const init（逐分量构造和列向量构造），满足 const 文档 §3.2 规则 9"只有定义了 const init 才能定义 const 实例成员函数"的约束。

**[通过]** `fromMat` 6a/6b 函数级类型参数（SrcQ、SrcT）的使用方式有效——6a 返回类型 `Mat{C}x{R}<T,Q>` 使用 extend 块的 T/Q，参数 `m: Mat{C_src}x{R_src}<T, SrcQ>` 使用函数级 SrcQ。矩阵子包同包可见，无需额外 import。

**[通过]** `fromMat` 6a（2 位置参数）与 6b（3 位置参数，conv 在前）参数数量不同，构成有效重载无歧义。6b 的 `conv: (SrcT) -> T` 函数类型参数有效满足跨类型转换需求。

**[通过]** `@Derive[Hashable]` 使用有效。VecN 类型已在阶段一通过 @Derive[Hashable] 编译验证（含 Bool 类型），矩阵类型仅包含 VecN 列成员，满足 deriving 文档中"参与派生的字段类型必须已实现对应接口"的要求。

**[通过]** 类型别名仅在文件顶层定义，符合 type_system 文档 §5.2 规则 1"仅限顶层"。ext/ 别名文件的 `package glm.ext` 与 `src/ext/` 目录路径匹配（package 文档 §2.1）。

### 2. 标准库与生态覆盖

**[通过]** 设计中依赖的核心能力：`Number<T>` 接口（算术运算约束）可在 std.math 中获得；`@OverflowWrapping` 注解为标准注解；`@Derive[Hashable]` 可通过 std.deriving.* 获得。所有依赖均在标准库或内置注解范围内。

**[通过]** 错误处理使用 Exception（下标越界抛出运行时异常），与错误处理文档 §1.1 中 Exception 的定位一致。

**[通过]** 无外部库或第三方依赖假设。

### 3. 语言特性可行性

**[通过]** 错误处理策略与仓颉错误处理能力匹配：下标越界抛出 Exception（含 assert + fallback throw），与阶段一 Vec 类型一致。

**[通过]** 复合赋值运算符（+=、-=、*=、/=）由编译器自动生成，符合 function 文档 §8.5："重载二元运算符（关系运算除外）时自动启用对应复合赋值版本（+=、-= 等），前提是返回类型与左操作数类型匹配或为其子类型"。设计正确识别了分类自动生成条件（第①~④类表格），且列出了方阵与非方阵的差异。

**[通过]** `Number<T>` 扩展块中通过 `scalar - scalar` 演算 T(0) 的策略可行，基于 `Number<T>` 提供算术减法运算符的合理假设。`one: T` 参数传入 T(1) 的设计正确解决了 `Number<T>` 约束下无法演算 T(1) 的限制。

**[通过]** 模块/包结构设计符合 cjpm 项目组织方式：`src/detail/` 对应 `package glm.detail`，`src/ext/` 对应 `package glm.ext`，`src/` 根目录对应 `package glm`。设计文档中标注了 cjpm 子包构建预验证步骤，体现了对包机制可行性的审慎态度。

**[通过]** 标量-矩阵运算通过 `scalar_mat_ops.cj` 全局具名函数处理（而非运算符），是因为仓颉 `operator func` 的 this 固定为左操作数，无法表达 T + Mat。此方案与阶段一 `scalar_vec_ops.cj` 模式一致，语言约束下正确可行。

**[通过]** 设计正确标注了各构造函数的 const init/const func 可用性。第 1、2 项为 const init（纯赋值无运算满足 const 表达式规则）；第 3~8 项非 const（涉及运算或 conv 闭包）；`length()` 为 const func。

### 4. 设计一致性

**[通过]** 各抽象的职责描述清晰无歧义——9 个矩阵类型各司其职，3 个 stub 文件职责边界明确（common.cj 仅标量版本，matrix.cj 分两类，geometric.cj 按方阵 .inl 引用范围）。

**[通过]** 协作关系形成闭环：模块间依赖为 `type_mat{N}x{M} → Vec 类型` 和方阵文件的 `.inl 编排 → stub 函数`，无缺失环节。

**[通过]** 行为契约完整覆盖了核心使用场景：identity/filled、矩阵乘法（含跨尺寸）、fromMat 6a/6b、fromMat 第 7 条、分量级修改、ext/ 别名使用、标量-矩阵除法、行向量×矩阵、同尺寸直接赋值。

**[通过]** 模块间依赖方向合理：`glm → glm.detail`、`glm.ext → glm.detail`，无循环依赖。

**[通过]** 所有 4 个 v4 迭代要求指出的问题（§4.5 签名矛盾、fromMat 非方阵边缘情形、length() const 属性、fromMat 重载数量歧义）均已在 v16 修订中正确修复。

### 5. 设计质量

**[通过]** 职责划分遵循单一职责原则——每个矩阵类型仅负责其尺寸（C×R）的矩阵运算，不承担其他尺寸逻辑。

**[通过]** 抽象层次恰当：OOD 级别定义了类型形态、构造函数体系和行为契约，未过度深入到具体字段表达式级别的实现细节。对于无法确定的具体实现（如 GLM .inl 中某些跨尺寸转换的偏差行为），设计明确标注了"编码阶段须逐一对照 GLM .inl 源码实现"的注意事项。

**[通过]** 设计便于后续详细设计和实现：stub 函数的完整签名清单消除了编码阶段的签名推测工作；编码启动前验证项（cjpm 子包构建、复合赋值自动生成）降低了实现风险；const 可用性汇总表为编码阶段提供了明确的 const 标注指引。

**[通过]** 设计便于单元测试：矩阵为值类型（struct），构造函数和工厂函数返回新实例，无隐藏状态/副作用；`filled`、`identity`、逐分量 const init 等工厂函数可直接构造预期矩阵实例进行比较；`equalEpsilon` 比较函数提供了浮点容差比较能力；stub 函数保证了方阵 .inl 依赖闭合性，不影响独立单元测试的编写。

**[通过]** 设计文档完整记录了与 C++ GLM 的差异声明（§9），涵盖 25+ 项差异（无 C 数组成员、无 ++/-- 运算符、ext/ 包名策略、identity(one) 替代默认构造等），为后续维护者提供了清晰的偏离追溯。

## 修改要求

无严重或一般问题。
