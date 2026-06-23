# OOD 设计方案审查报告（v1）

## 审查结果

REJECTED

## 逐维度审查

### 1. 类型系统可行性

**[通过]**
- 泛型结构体（`struct Mat2x2<T,Q> where Q <: Qualifier`）是仓颉类型系统原生支持的类型形态，与阶段一 Vec 类型一致
- 命名列成员（`var c0: VecN<T,Q>`）可行——仓颉 struct 支持 `var` 成员变量且可无初始值
- `const init` 对含有 `var` 成员的 struct 合法（规则仅对 class 限制 `var`）
- 下标运算符 `operator func [](i: Int64): col_type` 和赋值版本 `operator func [](i: Int64, value!: T): Unit` 均属仓颉可重载运算符范围
- `public type col_type = VecN<T, Q>` 类型别名、`extend` 块中的运算符定义、`const public static func` 均在仓颉语言能力范围内

### 2. 标准库与生态覆盖

**[通过]**
- 使用 `Number<T>` 类型约束来自 `std.math`，可用
- `@OverflowWrapping` 注解由 `std.overflow` 提供，可用
- `assert` 为标准库内置能力
- 无外部库依赖，所有数学运算均为基本类型原生操作

### 3. 语言特性可行性

**[通过]**
- 错误处理、并发模型、资源管理方案均与阶段一保持一致，可行
- 复合赋值运算符由编译器从二元运算符自动生成（返回类型匹配时），与设计描述一致
- `++`/`--` 替代为具名函数 `increment()`/`decrement()`，正确——仓颉可重载运算符清单不含自增/自减

**[轻微]** D-08 中 "标量在矩阵左侧的运算符通过非成员运算符函数实现（`operator func +(s: T, m: MatCxR<T,Q>)`）" 在仓颉中不可行——`operator func` 只能在 `class`、`interface`、`struct`、`enum`、`extend` 中定义，不支持顶层非成员运算符函数。但阶段一的已有方案（`scalar_vec_ops.cj` 中的具名函数 `add`/`sub`/`mul`/`div`）完全可复用于矩阵，设计意图清晰，仅语法示例不准确。

### 4. 设计一致性

**[通过]**
- 各抽象的职责描述清晰，9 个矩阵类型的角色、列/行类型关系完整
- 协作关系形成闭环（依赖均为 `detail/` → `detail/` 同包可见，无缺失环节）
- 行为契约（构造、运算符、比较）描述充分，足以指导后续实现
- 模块间依赖方向合理，无循环依赖

**[一般]** `ext/` 别名文件的包结构描述不准确。设计文档说明 `ext/` 目录下文件声明 `package glm`，但仓颉要求目录结构与包名匹配（"目录名须与包名匹配"）。文件位于 `src/ext/` 时，应声明为 `package glm.ext`（作为 `glm` 的子包），而非 `package glm`。此问题影响文件的实际导入路径和可见性范围。

### 5. 设计质量

**[通过]**
- 职责划分遵循单一职责原则（每个矩阵类型独立文件）
- 抽象层次恰当——与阶段一 Vec 类型设计策略一致，9 个类型各自独立而非单模板参数化
- 设计便于后续详细实现（模式统一，列向量内部表示为 Vec 类型的直接组合）
- 设计便于单元测试（struct 值语义，所有运算符返回新实例，无副作用）

## 修改要求（REJECTED 时存在）

### 问题 1：`ext/` 别名文件的包名称与目录结构不匹配

- **问题**：设计将 `ext/` 目录下别名文件的包声明写为 `package glm`，但文件位于 `src/ext/` 子目录中，仓颉要求包名与相对于 `src-dir` 的目录路径匹配。
- **原因**：编译器/工具链会将 `src/ext/` 按目录结构解释为 `glm.ext` 子包，`package glm` 声明与其矛盾。这可能导致编译失败或意外的可见性行为。
- **建议方向**：以下方案三选一：
  1. 将 `ext/` 文件的包声明改为 `package glm.ext`，通过 `import glm.detail.*` 访问 detail 中的类型
  2. 将 `ext/` 别名文件直接放在 `src/` 目录下（与 `lib.cj`/`fwd.cj` 同层），保持 `package glm`
  3. 重构目录结构，将完整的 `glm` 源码放入 `src/glm/` 子目录，`src/ext/` 作为 `glm.ext` 子包
