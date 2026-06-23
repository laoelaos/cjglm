# OOD 设计方案审查报告（v9）

## 审查结果

APPROVED

## 逐维度审查

### 1. 类型系统可行性

**[通过]** 9 个矩阵类型各自以独立泛型 struct 定义，与仓颉类型系统能力匹配（仓颉不支持模板偏特化，独立定义是正确选择）。

**[通过]** 泛型参数设计 `T <: Number<T>, Q <: Qualifier` 使用标准仓颉 `where` 约束模式，已在阶段一 Vec 类型中得到验证。

**[通过]** `extend` 块按不同约束（仅 Qualifier、Number<T>+Qualifier、Equatable<T> 等）分拆多个，符合仓颉扩展机制（同类型允许多个扩展块，各可有独立约束）。

**[通过]** `@Derive[Hashable]` 在 struct 上自动派生受支持（std.deriving），要求参与字段类型实现 Hashable——Vec 类型和基本数值类型均已满足。

**[通过]** `const init` 对逐分量同类型构造可用。结构体支持 const 构造函数，body 使用赋值表达式 `=` 对实例成员变量赋值合法。

**[通过]** 行向量×矩阵的编译顺序依赖已标注"待验证"，并提供了三个递进 fallback 方案，设计层面对不确定性有充分应对。

**[轻微]** §3.3 第 4 条 fromParts 签名示例 `<U, P>` 中类型参数 `P` 未在函数参数或返回类型中使用（仅出现在 where 子句中描述 `P <: Qualifier`），在仓颉中可能导致编译错误。建议改为 `<U>` 并移除 `P <: Qualifier` 约束（fromParts 使用的是标量分量而非 Vec 类型，不存在源 Qualifier 的概念）。

### 2. 标准库与生态覆盖

**[通过]** 设计依赖的核心接口 `Number<T>`、`Equatable<T>`、`Comparable<T>`、`Hashable` 均为 std.core 自动导入内容。

**[通过]** `@Derive[Hashable]` 源自 std.deriving，为仓颉标准库提供的能力。

**[通过]** `@OverflowWrapping` 注解为仓颉内置注解（reflect_and_annotation §1.1），用于控制在整数溢出时的截断行为。

**[通过]** 子包机制（`src/ext/` → `package glm.ext`）符合仓颉包声明规范（package/README.md §2.1："目录名须与包名匹配"、"须与相对于 src/ 的目录路径匹配"）。设计文档同时提供了方案二/方案三作为验证失败时的 fallback，风险应对充分。

### 3. 语言特性可行性

**[通过]** 错误处理（下标越界抛 Exception、stub 函数抛 Exception）为仓颉标准异常模式。

**[通过]** 矩阵类型为值类型（struct），运算符返回新实例，天然线程安全，无需额外并发措施。

**[通过]** 模块结构（glm.detail / glm / glm.ext）遵循 cjpm 包组织规范，依赖方向为有向无环。

**[通过]** `operator func` 重载在 extend 块中定义，符合仓颉运算符重载规则（extend/README.md §2.2-2.4）。

### 4. 设计一致性

**[通过]** 各矩阵类型的职责清晰：值对象、列向量存储、构造/下标/运算符。

**[通过]** 协作关系形成闭环：Mat×Vec（矩阵成员运算符）和 Vec×Mat（Vec extend 块成员运算符）均已定义完整签名表。跨矩阵转换（fromMat 6a/6b/7）给出完整泛型约束签名。

**[通过]** 行为契约完整：filled 的对角填充 T(0) 演算机制、fromMat 的填充规则和 B 类方向偏差均有明确说明。Bool 矩阵的操作支持范围全面界定（D33 + §9）。

**[通过]** 模块间依赖方向清晰：glm.detail 内部矩阵→向量，glm 依赖 detail，glm.ext 依赖 detail。无循环依赖。

### 5. 设计质量

**[通过]** 每个矩阵类型独立文件，stub 函数库职责分离，符合单一职责原则。

**[通过]** 抽象层次适当：架构级设计不包含实现细节（如具体 .inl 编排），同时提供了足够的签名示例指导编码。缺少实现细节是正常的设计级抽象。

**[通过]** 设计了充分的验证项（子包构建预验证、复合赋值自动生成验证、Mat4x4←Mat4x2 偏差验证、@Derive[Hashable] T=Bool 编译验证）和 fallback 机制，表明设计者对潜在风险有清醒认识。

**[通过]** 值类型 struct 天然支持独立测试，无需 mock 框架。stub 文件提供清晰的依赖边界。

## 修改要求（APPROVED）

轻微问题不阻塞通过，但在实现阶段建议处理：

- **§3.3 fromParts 签名**：`<U, P>` 中的 `P` 未使用，应改为 `<U>`。fromParts 接受的是标量分量而非 Vec，不存在源 Qualifier，移除 `P` 及相关约束即可。
