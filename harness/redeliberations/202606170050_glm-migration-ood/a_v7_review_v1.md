# OOD 设计方案审查报告（v7）

## 审查结果

REJECTED

## 逐维度审查

### 1. 类型系统可行性

**[严重]** 类型参数默认值语法不支持 — 设计全书多处使用 `where Q <: Qualifier = PackedHighp` 语法为 Vec 结构体的 Q 类型参数提供默认值（§3.2、§4.1 所有构造函数签名、§7 D2），并据此声明 `Vec2<Float32>` 是省略 Q 的合法简写。经检索仓颉语言特性文档和原始语言规范文档（`kernel/source_zh_cn/generic/` 下泛型概述、泛型约束、泛型结构体、泛型类、类型别名等全部章节），仓颉的泛型系统**不支持** 为类型参数声明默认值。类型参数的 `where` 约束仅支持 `T <: Constraint` 形式，不存在 `= DefaultType` 的默认值语法。这意味着 `Vec2<Float32>` 不能省略 Q 参数，所有以 `Vec<T>` 形式使用的代码均不合法。

**[一般]** `countof` 函数签名中的 `$N` 值泛型参数 — 设计在 §3.6 声明 `func countof<T, $N>(arr: VArray<T, $N>): Int64`，将 `$N` 当作泛型值参数使用。但原始文档（`basic_data_type/array.md`）明确说明 `VArray<T, $N>` 中的 `$N` 是"固定的语法"，通过 `$` 加上一个 `Int64` 类型的**数值字面量**表示数组长度，而非可声明的泛型值参数。所有示例均使用 `$3`、`$2`、`$0` 等字面量。不能将 `$N` 作为类型参数声明在函数签名中。

**[通过]** 其他类型形态选择（interface + 空结构体实现 Qualifier、四个独立泛型 struct、extend 扩展块等）均与仓颉类型系统能力匹配。空结构体实现接口、struct 值语义、泛型约束 `where Q <: Qualifier`、运算符重载非泛型限制、多个独立 Vec 结构体替代偏特化等设计决策均在仓颉能力范围内。

### 2. 标准库与生态覆盖

**[通过]** 设计中涉及的 `@OverflowWrapping` 注解（`reflect_and_annotation` 文档确认可标记于自定义函数声明）、`is` 运算符的 const 表达式可用性（`const_func_and_eval.md` 确认 `is` 是合法的 const 表达式运算符）、NumericLimits 拆分为 `Number<T>` 约束版本 + 无约束 `isIec559Of` 的架构、`std.math` 中的浮点特殊值检测函数等，均与仓颉标准库能力匹配。无超出标准库或生态覆盖范围的假设。

### 3. 语言特性可行性

**[通过]** 关键语言特性均已验证可行：
- `const init` 在 struct 中使用 `=` 赋值初始化 `var` 成员（`const_func_and_eval.md` §109-175 明确 `var` 不能用于 `class` 的 `const init`，但此限制不适用于 struct）
- `const` 实例成员函数 + `const if` + `is` 运算符的编译期分支
- 运算符重载的非泛型限制（`function.md` §8.1 确认 `operator func` 不能为泛型）
- 复合赋值由编译器自动生成（`function.md` §8.5）
- `extend` 块为 Vec 添加位运算符和具名函数成员
- `mut` 函数规则（`struct.md` §3）
- `@OverflowWrapping` 对运算符函数的标注可行
- 并发和资源管理设计（值类型无共享状态）合理

### 4. 设计一致性

**[通过]** 各抽象职责描述清晰，依赖方向合理（`glm.detail` <-- `glm` 单向依赖、无循环依赖），协作关系完整。构造函数签名清单自包含，不再依赖外部 C++ 源码。迭代审查的 14 条反馈均得到响应。

### 5. 设计质量

**[通过]** 职责划分符合单一职责原则，抽象层次恰当，便于后续编码实现和单元测试（可独立实例化、值类型可隔离测试）。对 `Vec<Bool, Q>` 行为约定集中化（§3.2 + D20）、NaN/Infinity 比较的容差路径局限性说明、`@OverflowWrapping` 策略差异的明确声明等改进均提升了设计质量。

## 修改要求（REJECTED 时存在）

### 问题 1（严重）：类型参数默认值语法不支持

- **问题**：设计使用 `where Q <: Qualifier = PackedHighp` 语法为 Vec 结构体的 Q 类型参数声明默认值，并基于此声称 `Vec2<Float32>` 是合法的省略 Q 参数简写形式。仓颉泛型系统不支持为类型参数设置默认值。
- **原因**：此问题影响整个 Vec 类型参数体系——§3.2 的 Q 默认值声明、§4.1 的所有构造函数签名（如 `Vec1<T, Q where Q <: Qualifier = PackedHighp>`）、§7 D2 的 Qualifier 设计决策中关于"可提供默认类型参数 `= PackedHighp`"的结论均基于一个不存在的语言特性。编码阶段尝试使用 `Vec2<Float32>` 将导致编译错误。
- **建议方向**：移除 Q 参数的默认值声明。对于需要简写的场景，可以采用以下替代方案之一：
  - **方案 A（推荐）**：保持 `VecN<T, Q>` 要求显式指定 Q 参数。在 `fwd.cj` 中通过 `type` 别名提供常用具现化（如 `type Vec2f = Vec2<Float32, PackedHighp>`），用户在 `package glm` 中通过这些别名访问。如需在泛型代码中编写 `Vec2<T>` 形式，可将 Q 参数移动到单独的包装类型中。
  - **方案 B**：在 `glm` 包中定义简写泛型结构体，如 `struct Vec2<T> { ... }` 内部使用 `Vec2<T, PackedHighp>` 委托，将 Q 参数固定为默认精度，用户如需自定义精度则直接使用 `glm.detail` 包中的 `Vec2<T, Q>`。
  - **方案 C**：接受 `Vec2<Float32, PackedHighp>` 为完整写法，在文档和示例中使用 `using`/`type` 别名的形式展示默认精度用法，并要求编码人员始终显式指定 Q。

### 问题 2（一般）：`countof` 函数签名中的值泛型参数语法不合法

- **问题**：`func countof<T, $N>(arr: VArray<T, $N>): Int64` 将 `$N` 作为泛型值参数使用，但仓颉中 `VArray<T, $N>` 的 `$N` 必须是固定数值字面量，非可声明值参数。
- **原因**：编码阶段尝试定义此函数将产生编译错误，影响 `shim_cstddef.cj` 文件的编译。
- **建议方向**：移除 `countof` 函数定义（或重写为不使用 VArray 签名的方式）。若确实需要该能力，可改为接受 `Array<T>` 调用 `size` 属性，或推迟到确认 CangJie 是否支持值泛型参数后再行实现。当前首轮代码中若不存在对 `countof` 的消费，可标注为预留待定。
