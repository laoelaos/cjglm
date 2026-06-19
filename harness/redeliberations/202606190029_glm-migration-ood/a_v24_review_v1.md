# OOD 设计方案审查报告（v24）

## 审查结果

REJECTED

## 逐维度审查

### 1. 类型系统可行性

**[通过]** `interface Qualifier` + 空结构体实现作为精度/对齐策略标记是仓颉泛型系统下正确的映射方案——接口作为泛型约束，空结构体作为零开销类型级区分。

**[通过]** Vec1~Vec4 分别定义为独立泛型结构体而非单模板，与仓颉不支持偏特化的约束一致。

**[通过]** `type` 别名统一使用 `public type` 修正了 v23 的可见性问题——仓颉中 `type` 别名默认 `internal`，`public type` 确保通过 `public import` 可达（package README §5.2）。

**[通过]** `extend<T, Q> VecN<T, Q> where Q <: Qualifier` 语法符合仓颉扩展语法（extend README §2.3 形式 B）。

**[通过]** `const init` 构造函数方案、`@Derive[Hashable]` 自动派生、`@OverflowWrapping` 注解等类型层面选择均与仓颉类型系统能力匹配。

### 2. 标准库与生态覆盖

**[通过]** 标准库依赖合理：`std.math.trunc`（浮点 mod 实现）、`std.math.abs`（绝对值）、`@Derive[Hashable]`（哈希派生）、`std.unittest.@Test`（测试框架）、`std.collection.HashSet`/`HashMap`（容器使用）均在对应标准库范围内。

**[通过]** `@OverflowWrapping` 溢出注解在 `std.reflect` 注解范围内可用。

**[通过]** 浮点 mod 的 `Float32`→`Float64` 提升策略已标注 `std.math.trunc` 仅提供 `Float64` 版本并设计了精度验证依赖（§10 依赖②）。

### 3. 语言特性可行性

**[通过]** 错误处理策略正确：`if + throw` 模式替代 C++ `assert`，`@OverflowWrapping` 控制整数溢出，除零委托运行时行为。

**[通过]** 并发设计合理：值类型 Vec 的复制语义保证线程安全，复合赋值非原子性已标注。

**[通过]** `const` 函数 + 编译期 `if` 的方案可行——const README §3.2 规则 9 确认 struct 定义了 `const init` 后才能定义 `const` 实例成员函数；const 表达式 §2.0 第 8 条确认 `is`、`if` 等均为合法的 const 表达式。依赖验证及回退路径（D29/D30）已清晰归档。

**[通过]** 模块包结构符合 cjpm 项目组织方式（`package glm.detail` 对应 `src/glm/detail/` 目录），无循环依赖。

### 4. 设计一致性

**[一般]** `lib.cj` 中的 `public import glm.fwd.*` 引用了不存在的包 `glm.fwd`。

- **问题描述**：§2 公共 API 面设计（第 71 行）列出 `public import glm.fwd.*`，但 `fwd.cj` 声明的是 `package glm`（§3.8 第 456 行），且文件位于 `src/glm/fwd.cj` 而非 `src/glm/fwd/` 子目录下。仓颉中包声明须与目录路径匹配（package README §2.1），从 `package glm` 中引用 `glm.fwd` 包会导致编译错误（包不存在）。
- **原因**：`public import glm.fwd.*` 的设计意图是重新导出别名使其通过 `lib.cj` 对外可见，但由于 `fwd.cj` 与 `lib.cj` 同属 `package glm`，其 `public` 声明已直接属于 `package glm`，`import glm.*` 即可访问，无需额外导入；若要保留 `public import` 语法，须将 `fwd.cj` 移至 `src/glm/fwd/` 子目录并声明 `package glm.fwd`。
- **建议方向**：二选一：① 移除 `lib.cj` 中的 `public import glm.fwd.*` 行（因为 `fwd.cj` 中的 `public` 声明已自动属于 `package glm`，`import glm.*` 即可访问全部别名）；② 将 `fwd.cj` 移至 `src/glm/fwd/fwd.cj` 并将包声明改为 `package glm.fwd`，保持 `public import glm.fwd.*` 不变。

**[通过]** 各抽象职责描述清晰，协作关系完整闭合（glm.detail 内部无外部包引用 → 依赖拓扑无循环 → Vec 结构体依赖 qualifier/compute/ops → glm 包单向依赖 detail）。

**[通过]** 行为契约覆盖充分（构造函数、分量访问、算术/位/比较运算、溢出策略、哈希契约等）。

### 5. 设计质量

**[通过]** 职责划分遵循单一职责原则：Qualifier 体系（精度标记）、Vec 结构体（向量数据+运算）、Functor（函数映射基础设施）、ComputeVec（运算策略）、Shim（C++ 标准库替代）各司其职。

**[通过]** 抽象层次恰当：Functor/ComputeVec 定义但不消费（为 SIMD/后续轮次预留），`scalar_vec_ops.cj` 独立为首轮消费。

**[通过]** 可测试性良好：§12 定义了完整的四层验证层次和具体测试方法，编码前验证检查清单（§2.1）覆盖了所有关键编译器行为假设的验证项。

**[通过]** 设计具有充分的回退路径：每个未验证的编译器行为假设（编译期 if 分支抑制、`@OverflowWrapping` 继承性、`const` 表达式链等）均有清晰的回退方案。

## 修改要求

### 问题：`public import glm.fwd.*` 引用了不存在的包 `glm.fwd`

- **问题**：§2 公共 API 面设计中 `lib.cj` 的 `public import glm.fwd.*` 语句试图从 `glm.fwd` 包导入并重新导出内容，但 `fwd.cj` 声明了 `package glm`（与 `lib.cj` 同包），且文件位于 `src/glm/fwd.cj`，并不存在 `glm.fwd` 这个子包。
- **原因**：设计意图是让 `lib.cj` 重新导出 `fwd.cj` 中的 256 个别名。但仓颉包声明须与目录路径匹配（package README §2.1），文件 `src/glm/fwd.cj` 声明 `package glm` 后就没有独立的 `package glm.fwd` 空间。`public import` 只能用于导入其他包（含子包），不能导入同包内的文件。若按当前写法编译，编译器将因 `glm.fwd` 包不存在而报错。该问题不影响 v24 其他章节的架构合理性描述，仅在 `lib.cj` 代码示例和对应注释中需要修正。
- **建议方向**：二选一：
  1. **推荐方案**：移除 `lib.cj` 中的 `public import glm.fwd.*` 行。`fwd.cj` 与 `lib.cj` 同属 `package glm`，其中所有 `public type` 别名已自动属于 `package glm`，下游 `import glm.*` 可直接访问 `BVec2`、`IVec3` 等全部 256 个别名，无需 `lib.cj` 重导出。此方案改动最小，仅需编辑文档中 `lib.cj` 代码示例。
  2. **备选方案**：将 `fwd.cj` 从 `src/glm/fwd.cj` 移至 `src/glm/fwd/fwd.cj`，声明 `package glm.fwd`，保持 `public import glm.fwd.*` 不变。需同步更新 §2 初始目录结构、§3.8 脚本输出路径、§8 迁移文件清单等所有提及 `fwd.cj` 路径的章节。
