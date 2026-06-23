# OOD 设计方案审查报告（v4）

## 审查结果

APPROVED

## 逐维度审查

### 1. 类型系统可行性

**[通过]** 9 个矩阵类型设计为独立泛型结构体 `Mat{C}x{R}<T, Q>`，与阶段一 Vec 类型策略一致。仓颉支持泛型结构体（`struct Mat2x2<T, Q> where Q <: Qualifier`）、多 `init` 构造函数重载、`const init`、静态成员函数 `length()`、下标运算符 `[]`（含命名参数 `value!` 的赋值版本）——所有类型形态选择在仓颉类型系统能力范围内。已验证阶段一 Vec 实现（`type_vec4.cj`）证实此模式可行。

**[通过]** 9 个矩阵类型独立定义（而非统一泛型 `Mat<C, R, T, Q>`）的决策合理：仓颉不支持模板偏特化，无法按 C/R 参数分别特化。独立结构体方案与 Vec 类型风格一致，已在阶段一验证可行。

**[通过]** 抽象之间的继承与实现关系清晰：`Qualifier` 接口及其实现（`PackedHighp`/`PackedMediump`/`PackedLowp`）已在阶段一实现且可复用；矩阵类型不涉及类继承，仅通过 `extend` 块为不同约束条件（`Number<T>`、`Equatable<T>`、`Comparable<T>` 等）添加运算符和函数——与阶段一 Vec 类型 `extend` 块模式完全一致。

**[通过]** 泛型使用方式在仓颉泛型系统能力范围内：所有泛型约束均为接口约束（`T <: Number<T>`、`Q <: Qualifier`），符合仓颉 `where` 子句语法（参见 `generic/README.md` §7.3）；fromMat 6b 的 `conv: (U) -> T` 闭包参数为函数类型，仓颉支持函数类型作为参数；多泛型参数交叉约束（如 `where T <: Number<T>, Q <: Qualifier, P <: Qualifier`）在仓颉中合法。

**[通过]** 协作关系中描述的类型交互模式可在仓颉中实现：Mat×Vec 运算符 `operator*(v: VecC<T,Q>): VecR<T,Q>` 作为矩阵成员运算符，无需跨类型依赖；Vec×Mat 运算符通过 `extend VecN` 块定义，依赖同包前向类型引用延迟解析（已列为阻断性验证项，并提供了 3 级 fallback 方案）；标量-矩阵全局函数 `add<T, Q>(s: T, m: Mat2x2<T, Q>)` 与已有 `scalar_vec_ops.cj` 同名函数通过第二参数类型区分重载——仓颉函数重载规则支持参数类型重载（参见 `function/README.md` §7.1），已列为阻断性验证项。

**[轻微]** 跨尺寸矩阵乘法的 27 个成员运算符全部定义在各左矩阵类型的 `extend` 块中，每个左矩阵类型需承载 3~6 个不同右矩阵类型的 `operator*` 重载。虽然仓颉支持基于参数类型的函数重载，但大量重载增加了重载解析的复杂度。建议编码阶段验证编译器对这些重载的解析无歧义。

### 2. 标准库与生态覆盖

**[通过]** 设计中需要的能力均在仓颉标准库覆盖范围内：
- `Number<T>`（`std.math.Number`）、`Integer<T>`（`std.math.Integer`）、`Equatable<T>`、`Comparable<T>`：均为仓颉核心接口，阶段一已使用
- `@Derive[Hashable]`（`std.deriving.*`）：阶段一 Vec 类型已验证可用
- `@OverflowWrapping`（仓颉内置注解）：阶段一已广泛使用
- `Exception`：仓颉内置异常类型，阶段一 `[]` 运算符已使用
- `assert`：仓颉内置断言函数，阶段一已使用

**[通过]** 设计中对标准库能力的假设合理：
- `length()` 静态函数返回 `Int64`：与阶段一 Vec `length()` 一致，仓颉支持 `public static func length(): Int64`
- 类型别名（`public type Mat2x2 = detail.Mat2x2<Float32, detail.PackedHighp>`）：仓颉 `type` 别名语法已在 `fwd.cj` 中使用
- `public import` 重新导出：已在 `lib.cj` 中使用

**[通过]** 无标准库能力可简化设计中自定义抽象——矩阵运算（transpose/matrixCompMult/outerProduct/determinant/inverse）在标准库中无对应实现，必须自行提供。

**[轻微]** `fmod` 函数在 `std.math` 中存在（阶段一 `scalar_vec_ops.cj` 已导入），但设计中 `common.cj` 的 `mod<T>` 签名使用 `Number<T>` 约束而非具体 `Float32`/`Float64` 类型，`Number<T>` 不提供 `%` 运算符。此问题已被识别为暂定签名并列为阻断性验证项，处理方式合理。

### 3. 语言特性可行性

**[通过]** 错误处理策略与仓颉错误处理能力匹配：
- 下标越界和 `col()` 越界抛出 `Exception`：与阶段一 Vec `[]` 策略一致
- stub 函数 `throw Exception("stub")`：仓颉 `throw` 语法合法
- `inverse` 对奇异矩阵推荐抛出异常：与仓颉异常体系兼容

**[通过]** 并发设计与仓颉并发模型兼容：本阶段不引入并发场景，矩阵为值类型天然线程安全。

**[通过]** 资源管理方案在仓颉资源管理模式内可行：矩阵为值类型（`struct`），无需 `Resource` 接口或 `try-with-resources`。所有运算符返回新实例，无共享可变状态。

**[通过]** 模块/包结构设计符合 cjpm 项目组织方式：
- `glm.detail` 包包含核心实现，与阶段一目录结构一致（`src/detail/`）
- `glm.ext` 子包（`src/ext/`）存放别名字文件，包名与目录路径匹配（`package` 技能文档 §2.1 要求目录名与包名一致），且已提供原型验证计划和 3 级 fallback 方案
- `cjpm.toml` 配置 `src-dir = "src"` 已在阶段一验证可行

**[通过]** `@Derive[Hashable]` 用于矩阵类型可行：仓颉 `@Derive` 支持 struct 类型（参见 `deriving/README.md`），但要求参与派生的字段必须为 `public` 且其类型已实现 `Hashable`。矩阵类型的列向量成员 `var c0: VecR<T,Q>` 等——阶段一已对 Vec 类型标注 `@Derive[Hashable]`，因此 VecN<T,Q> 已实现 `Hashable`（当 T 也实现 `Hashable` 时）。设计中已将 `@Derive[Hashable]` 跨元素类型编译验证列为阻断性验证项，合理。

**[通过]** 复合赋值运算符自动生成：仓颉函数文档 §8.5 明确声明"重载二元运算符（关系运算除外）时自动启用对应复合赋值版本，前提是返回类型与左操作数类型匹配或为其子类型"（参见 `function/README.md` §8.5）。设计中已正确引用此规范保证，并将手动定义回退方案移至附录 A 作为纯防御性方案。

**[通过]** `const init` 可用性：设计中逐分量构造函数和列向量构造函数标注为 `const init` 可用，仅涉及纯赋值。仓颉 `const init` 规则（参见 `const/README.md` §4）允许对实例成员变量赋值，此用法已在阶段一 Vec 构造函数中验证可行。`identity(one)` 和 `diagonal(scalar)` 标注为非 const（涉及运算），符合 `const func` 约束要求。

### 4. 设计一致性

**[通过]** 各抽象的职责描述清晰无歧义：
- 9 个矩阵类型：表示 C×R 数学矩阵的值对象
- `common.cj`：纯 stub 数学函数占位
- `matrix.cj`：混合型（27 个可直实现 + 6 个 stub 空壳），分类标注准确
- `geometric.cj`：纯 stub 几何函数占位
- `scalar_mat_ops.cj`：标量-矩阵全局函数
- 类型形态、职责、分类标注均已修正（v37 采纳了问题 6 的修正）

**[通过]** 协作关系形成闭环，无缺失环节：
- 矩阵类型的 `.inl` 编排依赖已明确列出（`type_mat3x3.cj` → `matrix.cj, common.cj`，`type_mat4x4.cj` → `matrix.cj, geometric.cj`）
- 编译顺序已规划（基础类型 → stub 文件 → 矩阵类型 → Vec extend 块 → 辅助文件）
- Vec×Mat 运算符的前向引用编译依赖已识别并列为阻断性验证项，3 级 fallback 方案完整

**[通过]** 行为契约描述完整到足以指导后续实现：
- fromMat 6a/6b 有完整编码模板（2 个代表性方向 + DEVIATION 方向）
- Mat×Mat 跨尺寸乘法有编码模板（2 个代表性方向 + 统一公式定义）
- 四项基本操作（colExtend/colShrink/rowExtend/rowShrink）有精确数学定义
- 9×9 转换矩阵表覆盖全部 72 个方向，标注填充模式和偏差

**[通过]** 模块间依赖方向合理，无循环依赖：依赖关系为单向 DAG——矩阵类型依赖 Vec 类型（阶段一已实现）；stub 文件无外部依赖；`lib.cj`/`fwd.cj` 依赖 detail 包；ext/ 依赖 detail 包。同包内类型引用顺序问题已通过编译顺序规划和前向引用验证覆盖。

**[轻微]** `fromMat` 的 144 个签名构造量较大（9×8×2），设计中建议开发代码生成脚本。虽然此建议合理，但代码生成脚本本身的设计和验证未在 OOD 中规划。建议编码阶段优先开发生成脚本并列为首批验证项。

### 5. 设计质量

**[通过]** 职责划分遵循单一职责原则：
- 每个矩阵类型文件只负责一个矩阵尺寸的全部定义
- `scalar_mat_ops.cj` 专门处理标量左侧运算
- stub 文件仅负责依赖闭合
- `matrix.cj` 混合型文件内部两类职责（可直实现 vs stub）已在 §3.7 清晰区分

**[通过]** 抽象层次恰当：设计为架构级 OOD，精确覆盖了类型形态选择、关键行为契约、编码模板、泛型约束策略、编译顺序规划、阻断性验证项。未过度设计（如未包含完整字段列表或方法签名等实现细节），也未设计不足（关键决策如 `one: T` 参数语义、T(0)/T(1) 演算策略、DEVIATION 处理等均有详尽说明）。

**[通过]** 设计便于后续详细设计和实现：
- 编码模板可直接映射为代码
- 9×9 转换矩阵表提供了每个方向的精确填充模式
- 统一的公式定义（`result[j][i] = sum_{k=0}^{C_left-1} left[k][i] * right[j][k]`）使 27 个乘法重载可机械展开
- 代码生成脚本建议降低了 144 个 fromMat 签名的手动编码风险

**[通过]** 设计便于单元测试：
- 矩阵类型为值对象，无共享状态，天然可隔离测试
- stub 函数以 `throw Exception("stub")` 占位，测试中可 catch 验证
- 阶段一测试模式（`tests/` 目录下按类型分文件）可直接沿用
- NaN 传播测试策略、fromMat 偏差验证、B 类方向单元测试验证要求均有明确覆盖

**[轻微]** `Bool` 矩阵的支持范围由 `Number<T>` 约束自然限定（不支持算术、diagonal、identity、equalEpsilon、fromMat 6a/6b），此策略整体清晰但 D33 决策说明较长且分散在多处（§3.3 item 3、§3.3 item 8、§3.5、§3.6、§3.7、§9），建议编码阶段集中整理 Bool 矩阵限制清单以便快速查询。
