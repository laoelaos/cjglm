# OOD 设计方案审查报告（v8）

## 审查结果

REJECTED

## 逐维度审查

### 1. 类型系统可行性

**[严重] `const` 扩展成员函数语法可行性未经官方文档确认** — 设计方案在多个 `extend` 块中使用了 `const` 修饰的实例成员函数（§4.4 `bitwiseNot()`、§4.5 `equalExact()`、§4.5 `logicalAnd`/`logicalOr`、§4.3 vec-op-scalar 方向 `add`/`sub`/`mul`/`div`/`mod` 扩展成员函数），依赖此能力实现 `const if` 编译期分支和 const 上下文调用。但仓颉官方文档（`access_rules.md`）明确列出扩展成员可使用的修饰符为 `static`、`public`、`protected`、`internal`、`private`、`mut`，**不包含 `const`**。同时 `const` 文档 §3.2 规则 8 指出"数值类型、`Bool`、`Unit`、`Rune`、`String` 类型和 `enum` 支持定义 `const` 实例成员函数"，亦未将 struct 的扩展成员纳入支持范围。设计方案 §3.2 声称"extend 块中也可定义 `const` 实例成员函数（规则与类型体内一致）"属于未经验证的假设，影响面覆盖所有 const 扩展成员函数（约 29 处）。此问题在 v7 审查中已作为 P1（严重）提出，v8 未修复。

**[严重] §3.2 中 `const init` 构造函数声明中的 `const` 语法与 struct 构造函数语法的兼容性** — 设计方案中多个 Vec 结构体的 `const init` 构造函数签名使用了 `const init(x: T)` 形式，但仓颉 struct 的构造函数语法要求 `init` 关键字，`const` 修饰符是否允许出现在 `init` 构造函数前需确认。`const` 文档中 `const init` 的示例为 `const Point(let x: Float64, let y: Float64) {}`，即 `const` 修饰 `init`。但设计方案 Vec1 所示的 `const init(x: T)`（无成员变量参数）与 Vec2 的 `const init(x: T, y: T)` 在语法上与文档示例一致。但需注意 `const init` 要求所有实例成员变量无初始值或初始值为 const 表达式——Vec 的 `var x: T` 形式无初始值，满足条件。此问题需编码前原型验证确认。

**[一般] 构造函数重载解析风险** — Vec4 §4.1 中定义了多个接收 `Vec1<T2, Q2>` 参数的构造函数，如 `init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>, c: T, d: T)` 与 `init<T2, Q2>(a: Vec1<T2, Q2>, b: T, c: Vec1<T2, Q2>, d: T)` 等组合。当调用方以 `Vec4(v1: Vec1<Int32, PackedHighp>, v2: Vec1<Int32, PackedHighp>, ...)` 形式构造时，多个重载的参数列表均为 `(Vec1, Vec1, T, T)` 等模式，仓颉重载解析规则在泛型参数 `T2`/`Q2` 被实例化后可能产生歧义。此问题在 v7 审查已作为 P5 提出，v8 构造函数列表未进行重载消歧分析。

**[一般] §9.4 `const if (T2 is Bool)` 语法可行性存疑** — 设计方案方案 A 使用 `const if (T2 is Bool && T is not Bool)` 作为编译期约束。`is` 是值级运算符，其左操作数须为值表达式而非类型参数。`T2` 和 `T` 是类型参数，`T2 is Bool` 语法在仓颉中不合法。设计方案在 §3.5 `isIec559Of<T>()` 中使用了 `T(0) is Float64` 的正确模式（创建值后再检测类型），与 §9.4 的模式不一致。需统一为值级检测模式或改用其他编译期约束机制。

**[通过]** 其余类型形态选择（interface/struct/enum/type alias）与仓颉类型系统能力匹配；`Qualifier` 接口+空结构体模式在仓颉泛型系统中可行；`where Q <: Qualifier` 泛型约束语法正确；四个独立 Vec 结构体而非单模板特化的选择合理（仓颉不支持偏特化）；跨类型构造函数通过无约束泛型参数 + `T(v.x)` 显式转换的策略正确。

### 2. 标准库与生态覆盖

**[通过]** 设计中使用的标准库设施均可在仓颉标准库中找到对应：`NumericLimits<T>`（`std.core` 或类似）、`std.math.trunc`（`std.math`）、`@Derive[Hashable]`（`std.deriving`）、`@Test`/`@TestCase`（`std.unittest`）、`ArithmeticException`（内置运行时异常）。对 `std.math.trunc` 仅提供 `Float64` 版本的限制已正确识别并给出 `Float32`→`Float64` 提升回退策略。对 `HashSet`/`HashMap` 等集合类型的假设合理。

**[轻微]** §4.3 中 `mod` 浮点实现依赖 `std.math.trunc` 的 `Float64` 版本，但 `trunc` 在 `Float32` 分量上通过提升到 `Float64` 再降级的方式可能引入极细微的精度差异。虽已标注风险并设计了原型验证计划，但未评估此精度差异对 GLM 标准测试套件的通过性影响。

### 3. 语言特性可行性

**[一般] `@OverflowWrapping` 标注继承性依赖编译器未文档化行为** — 设计方案 §4.6 声明"编译器自动生成的复合赋值版本继承二元运算符上的 `@OverflowWrapping` 标注"，并已在 §7 D30 中标注此行为依赖编译器的未文档化行为。此风险虽已识别并设计了备选方案，但备选方案（通过 extend 块中的具名函数实现 Vec 算术运算）与 P1 的 `const` 扩展成员函数问题交互——若 `const` 在 extend 块中不可用，则备选方案中算术具名函数的 `const` 声明同样不可用，需要组合回退方案。设计方案的 D30 组合回退场景分析（§7 D30 组合回退场景分析表）未覆盖此交互。

**[一般] `<<` 默认溢出策略描述准确性依赖编译器行为验证** — §4.4 声明"仓颉中 `<<` 默认使用 `@OverflowThrowing` 策略，在移位超出位宽时抛出 `ArithmeticException`"。此描述属于编译器实现定义行为——`<<` 的默认溢出策略可能在 [std.overflow](./overflow/README.md) 中有定义，但需确认其默认策略是否为 `@OverflowThrowing`。此问题在 v7 审查已作为 P4 提出，v8 将标注从"事实陈述"改写为"待验证假设"后仍需编码前验证。

**[通过]** 其余语言特性评估：错误处理策略（`if + throw` 模式）可行；并发设计（值类型语义）合理；包结构（`package glm` + `package glm.detail`）符合 cjpm 项目组织方式；`const` 变量声明于 `setup.cj` 中在语言语法约束内（const 变量不可声明于包级扩展中，但 `setup.cj` 顶层 const 声明合法）；`const if` 语法本身在仓颉中受支持（需函数为 `const` 函数）。

### 4. 设计一致性

**[一般] §8.1 迁移文件清单未覆盖测试文件** — 迁移清单仅列出 14 个源文件，未包含对应的测试文件。§12.3 虽然描述了测试包组织策略（`tests/glm.detail/`、`tests/glm/`、`test_type_vecN.cj` 等），但未在 §8.1 清单中为每个源文件列出对应的测试文件。编码启动指引存在缺口——维护者无法从清单推知需要创建哪些测试文件。此问题在 v7 审查已作为 P3 提出，v8 未修复。

**[一般] §4.1 Vec4 构造函数列表的完备性与重载消歧未论证** — Vec4 的构造函数清单包含约 40 个 `init` 泛型重载，其中多个组合模式的参数结构相似（如 `(Vec1, Vec2, T)` vs `(Vec2, Vec1, T)` 等）。设计虽声明"覆盖 GLSL 5.4.1 规范定义的构造语义"，但未对泛型实例化后的重载解析冲突做系统性分析。对于 `T2`/`Q2` 被实例化为不同类型组合的场景，仓颉重载解析规则的行为需要原型验证。

**[轻微] 参考实现使用策略未说明** — 用户需求中提及"已有参考实现位于 `references/glm-1.0.3/`"，但设计方案未定义编码阶段如何利用此参考实现验证设计正确性。未说明是作为编译对比、行为参照还是测试数据源使用。此问题在 v7 审查已作为 P7 提出，v8 未修复。

**[通过]** 其余设计一致性：各抽象的职责描述清晰无歧义（Qualifier 体系、Vec 结构体、Functor 体系、ComputeVec* 策略体系、Shim 层等）；协作关系形成闭环；模块间依赖方向合理（`glm` 单向依赖 `glm.detail`，无循环依赖）；行为契约的描述（构造、分量访问、算术运算、位运算、比较运算等）完整到足以指导后续实现。

### 5. 设计质量

**[通过]** 职责划分遵循单一职责原则（每个文件一个核心抽象类型）；抽象层次恰当（不过度设计——首轮直接实现逐分量运算而非通过 ComputeVec* 委托，Functor/ComputeVec 为后续预留）；设计便于后续详细设计和实现（迁移顺序分阶段、每阶段有增量验证节点）；设计便于单元测试（`const` 纯函数可独立测试、Qualifier 空结构体可 mock、值类型无隐式共享状态）。

**[轻微]** 256 个别名集中在单文件 `fwd.cj` 中的策略虽在可管理范围内（预期 300-350 行），但后续轮次新增别名家族时代码增长后可能需要拆分为多文件管理。当前设计未规划多文件拆分策略。

## 修改要求（REJECTED 时存在）

### 严重问题

- **问题**：`const` 扩展成员函数的语法可行性未经官方文档确认。仓颉 `access_rules.md` 列出扩展成员可使用的修饰符（`static`、`public`、`protected`、`internal`、`private`、`mut`），不包含 `const`。设计方案在 `extend` 块中多处使用 `const` 扩展成员函数（`bitwiseNot`、`equalExact`、`logicalAnd`/`logicalOr`、vec-op-scalar 方向的 `add`/`sub`/`mul`/`div`/`mod`），且 §3.2 声称"extend 块中也可定义 `const` 实例成员函数（规则与类型体内一致——struct 定义了 `const init` 即可）"属于未经验证的假设。
  - **原因**：若 `const` 在扩展块中不可用，涉及 const 扩展成员函数的设计全盘受影响：① all extend 块中的 const 函数须降级为非 const；② `const if` 在 const 函数中才能使用，降级后移除 `const` 导致 `const if` 也不可用；③ `mod` 函数的整数/浮点双路径（依赖 `const if`）需重新设计；④ `==` 的容差比较路径（依赖 `const` 函数链）需回退；⑤ 与 D30 的备选方案（extend 块中具名函数标注 `@OverflowWrapping`）产生交互——备选方案中算术具名函数同样被 `const` 约束。影响面从 §3.2 到 §4.5、§7 D32/D33。
  - **建议方向**：① 在编码阶段启动前编写原型测试，在 `extend` 块中尝试定义 `const` 实例成员函数，验证编译器是否支持；② 若验证不通过，所有 extend 块中的 `const` 声明降级为非 `const`；③ `mod` 的浮点/整数双路径拆分为独立具名函数 `modInt`/`modFloat`（避免 `const if` 依赖）；④ `==` 的浮点容差比较路径整体回退到精确比较（`a == b`），浮点容差比较通过非 `const` 的 `equalEpsilon` 具名函数（定义在 struct 体内而非 extend 块中）提供；⑤ 重新评估 D32/D33 的 const 化决策，将仅依赖 `const` 的功能移至 Vec 结构体定义体内而非 extend 块中。

### 一般问题

- **问题**：§9.4 方案 A 使用 `const if (T2 is Bool && T is not Bool)` 语法，但 `is` 是值级运算符，`T2`/`T` 是类型参数而非值表达式，语法不合法。
  - **原因**：设计方案 §3.5 `isIec559Of<T>()` 中已正确使用 `T(0) is Float64` 模式（创建值后检测类型），但在 §9.4 中使用了不一致的 `T2 is Bool` 模式。此不一致导致 Bool→数值转换的编译期约束方案不可行。
  - **建议方向**：统一改为值级检测模式：`const if (T2(0) is Bool && not (T(0) is Bool))`，与 `isIec559Of<T>()` 的模式保持一致。若 `T2(0)` const 构造不可行（如 `Bool` 类型的 `Bool(0)` const 构造是否合法需验证），则回退至方案 B（运行时 `if` 分支显式处理）。

- **问题**：§8.1 迁移文件清单未覆盖测试文件，编码启动指引存在缺口。
  - **原因**：维护者无法从清单推知需要创建哪些测试文件，可能遗漏测试覆盖或编码阶段才发现需要补充测试文件结构。§12.3 虽有测试组织结构描述但未映射到具体文件名。
  - **建议方向**：在 §8.1 清单中为每个源文件列出对应的测试文件名。例如：`type_vec1.cj` → `tests/glm.detail/test_type_vec1.cj`，`shim_limits.cj` → `tests/glm.detail/test_shim_limits.cj` 等。

- **问题**：`<<` 默认溢出策略的描述"仓颉中 `<<` 默认使用 `@OverflowThrowing` 策略"属于编译器实现定义行为。
  - **原因**：`<<` 的默认溢出行为在仓颉标准库的 `std.overflow` 文档中有明确定义，但设计方案将此描述为"事实"而非"待验证假设"。若编译器的默认行为与设计假设不一致，`<<` 的 `@OverflowWrapping` 标注可能冗余或不完整。
  - **建议方向**：改写为"仓颉中 `<<` 的默认溢出策略待验证（假设为 `@OverflowThrowing`）"，在 §10 原型验证计划中增加对 `<<` 默认溢出行为的验证项。

- **问题**：构造函数体系对 `Q` 参数的约束充分性存疑，Vec4 跨类型构造的重载解析风险未分析。
  - **原因**：Vec4 的约 40 个 `init` 泛型构造函数中，多个接收 `Vec1<T2, Q2>` 参数的组合模式在 `T2`/`Q2` 被实例化为不同类型后，重载解析可能产生歧义（如 `init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>, c: T, d: T)` 和 `init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>, c: Vec1<T2, Q2>, d: T)` 在参数列表结构上不同，但在特定类型实例化后可能出现歧义）。D31 已识别 fill-from-Vec1 构造器的重载冲突并做了约束，但未对 Vec4 完整构造函数列表做系统性重载消歧分析。
  - **建议方向**：为 Vec4 的构造函数列表补充重载消歧分析表，识别可能的歧义组合并说明仓颉重载解析规则下的选择策略。在 §10 原型验证计划中增加重载消歧验证项。

- **问题**：`@OverflowWrapping` 标注继承性验证的回退方案与 `const` 扩展成员函数问题的交互未被分析。
  - **原因**：§7 D30 组合回退场景分析表覆盖了 D29 与 D30 的交互，但未覆盖"`const` 在 extend 块中不可用"与"`@OverflowWrapping` 继承性不成立"的组合场景。两者同时失败时，算术运算符既无法通过 `@OverflowWrapping` 继承性自动获得 wrapping 语义，也无法通过 extend 块中的 const 具名函数实现（因 `const` 不可用）。
  - **建议方向**：在 D30 组合回退分析中增加第三维度——"`const` 在 extend 块中的可用性"。分析三者的组合回退路径：若 `const` 不可用且继承性不成立，算术运算通过 extend 块中的非 `const` 具名函数实现，标注 `@OverflowWrapping`，二元运算符委托给这些具名函数。
