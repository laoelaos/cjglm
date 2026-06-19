# OOD 设计方案审查报告（v7）

## 审查结果

APPROVED

## 逐维度审查

### 1. 类型系统可行性

**[通过]** Qualifier 采用 `interface` + 空 `struct` 模式，将 C++ enum 值映射为类型参数，符合仓颉泛型系统仅接受类型作为泛型实参的约束。

**[通过]** Vec1~Vec4 作为独立泛型结构体而非单一参数化模板。设计明确承认仓颉不支持偏特化，四个独立结构体的选择正确。

**[通过]** `where Q <: Qualifier` 泛型约束语法有效，与仓颉 `where` 子句规范一致。

**[通过]** `const init` 构造函数的使用符合仓颉约束：struct 定义了 `const init` 后即可定义 `const` 实例成员函数；`const init` 内可用 `=` 对 `var` 成员赋值（const README §3.2 规则 9 + §4.2）。

**[通过]** `extend<T, Q> Vec2<T, Q> where Q <: Qualifier { ... }` 语法在仓颉扩展机制中有效（extend 文档 §2.3 形式 B + §2.4 额外约束）。

**[通过]** `operator func` 重载、`[]` 赋值形式的 `value!` 命名参数、复合赋值的自动生成机制均与仓颉语言规范一致。

**[通过]** `@Derive[Hashable]` 对 struct 有效，参与派生的字段类型须实现 `Hashable`（数值类型和 `Bool` 均已实现）。

**[通过]** `type` 别名体系和 `public import` 重导出机制符合仓颉包机制。

**[轻微]** §9.4 方案 A 中 `const if (T2 is Bool && T is not Bool)` 直接使用类型参数 `T2` 与 `is` 运算符。仓颉 `is` 运算符要求左操作数为运行时值表达式（如 `T2(0) is Bool`），`T2 is Bool` 可能不是合法语法。但方案 B（运行时 `if (v.x is Bool)` 分支）作为兜底方案完全可行，不阻塞设计通过。

### 2. 标准库与生态覆盖

**[通过]** `std.math.trunc(x: Float64): Float64` 经确认存在于标准库（std.math §3），可用于浮点 `mod` 实现。

**[通过]** `std.math.abs` 支持 `Float16/32/64` 及整数类型（std.math §1），`ComputeEqual` 浮点容差路径依赖成立。

**[通过]** `std.deriving.@Derive[Hashable]` 确认可用（deriving §1），struct 使用 `@Derive[Hashable]` 自动派生 `hashCode()`。

**[通过]** `NumericLimits<T>` 并非标准库类型，但设计将其定位于 `shim_limits.cj`（自定义 shim 层）。此定位正确——项目需自行实现带 `where T <: Number<T>` 约束的 `NumericLimits<T>` 结构体。

**[通过]** `std.unittest.@Test`、`std.sync.Mutex`、`std.collection.concurrent.ConcurrentHashMap`、`std.collection.HashMap/HashSet` 等标准库类型均可用。

**[通过]** 设计不依赖任何 `stdx` 扩展库，首轮依赖闭合在 `std.core` + `std.math` + `std.deriving` + `std.unittest` + `std.collection` + `std.sync` 范围内。

### 3. 语言特性可行性

**[通过]** 错误处理策略（`if + throw` 替代 C++ 宏断言、`@OverflowWrapping` 控制整数溢出）在仓颉能力范围内。设计已识别 Release 模式下断言不可编译消除的差异。

**[通过]** `const` 函数机制：`is` 运算符在 const 表达式中可用（const README §2 规则 8），`T(0)` const 构造依赖已列为高优先级原型验证项（§10），回退方案完备。

**[通过]** `const if` 条件编译期分支选择语义已明确：`const if` 在 const 函数体内有效，非选择分支的编译抑制行为已列为 P16 关键验证项，回退方案（拆分为 `modInt`/`modFloat`）可行。

**[通过]** 并发模型正确：Vec 为值类型，值语义天然线程安全。§6 覆盖了复合赋值非原子性、并发容器行为等典型场景。

**[通过]** `@OverflowWrapping` 与 `const` 函数共存经验证可行（注解与修饰符分属不同语法维度）。标注继承性（D30）未在语言规范中显式确认，但设计已定义备选方案（具名函数标注）。

**[通过]** 包结构符合 cjpm 项目规范：双包结构（`glm.detail` + `glm`），`internal` 可见性（Aligned* 类型）正确使用。

**[轻微]** `const` 实例成员函数在 `extend` 块中的修饰符兼容性未经仓颉文档显式确认（extend §4.2 列出了允许的修饰符 `static/public/protected/internal/private/mut`，未明确包含 `const`）。但 const README §3.2 规则 9 将约束放在 struct 层面（"只有定义了 `const init` 才能定义 `const` 实例成员函数"），不区分定义位置（类型体内或 extend 块）。设计已为此准备了降级方案——`equalExact` 等可降级为非 `const` 函数，功能正确性不受影响。

### 4. 设计一致性

**[通过]** 模块依赖图清晰无环：`glm.detail` 内部依赖为 DAG，`glm` → `glm.detail` 单向依赖。

**[通过]** `VecN<Bool, Q>` 行为在 §3.2 集中约定，各运算符章节交叉引用，消除分散描述的不一致性。

**[通过]** 迁移顺序表（§8.3）已补充增量验证列，每阶段定义明确验证标准，可作为编码质量门禁。

**[通过]** 公共 API 面（`lib.cj`）的 `public import` 列表完整一致，覆盖 `Vec` 核心类型、`Qualifier` 实现类型、`scalar_vec_ops` 函数和 `fwd.cj` 别名。

**[通过]** `scalar_vec_ops.cj` 已从 `compute_vector_decl.cj` 中拆分，消除了双重角色架构层次模糊问题（P4）。

### 5. 设计质量

**[通过]** 职责划分遵循 SRP：setup（配置）、qualifier（精度标记）、shim_*（标准库桥接）、compute_*（运算策略）、type_vecN（向量类型）、scalar_vec_ops（方向辅助函数）各自聚焦。

**[通过]** 抽象层次恰当：Functor/ComputeVec 首轮仅定义不消费，为后续 SIMD 轮次预留扩展点，不过度设计。

**[通过]** 可测试性良好：§12 定义了四层验证体系和测试包组织结构，`@Derive[Hashable]` + 自动化别名脚本降低编码错误。

**[通过]** 风险管控到位：D29（const 表达式链）、D30（标注继承性）、P16（const if 编译抑制）三项关键假设均定义了验证计划与独立回退方案，且分析了三者组合回退的正交性（§7 D30 组合回退场景分析）。

**[轻微]** 256 个别名集中在 `fwd.cj`（~300-350 行）可管理，但脚本生成策略中未明确脚本语言的选择依据和 CI 集成方式。可通过模板引擎（如 Jinja2）生成，建议后续补充 CI 中脚本自动执行的配置说明。

## 修改要求

本审查无严重或一般问题，不产生修改要求。
