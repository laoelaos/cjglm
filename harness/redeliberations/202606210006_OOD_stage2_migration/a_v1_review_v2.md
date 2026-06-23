# OOD 设计方案审查报告（v2）

## 审查结果

REJECTED

## 逐维度审查

### 1. 类型系统可行性

**[通过]** 9 个矩阵类型以独立泛型 struct 定义、列向量成员存储、列主序约定——均在仓颉泛型 struct 能力范围内，与阶段一 Vec 类型策略一致。

**[通过]** 类型别名体系（`col_type`、`row_type`、`type`、`transpose_type`、`value_type`）——仓颉 struct 支持 `type` 别名定义，feature matrix 确认。

**[通过]** 下标运算符 `[](i: Int64): col_type` 和 `[](i: Int64, value!: col_type): Unit`——仓颉支持 `operator func []` 的取值和赋值双版本，与 Vec4 实现一致。

**[通过]** 算术/比较运算符定义在带 `Number<T>`/`Equatable<T>` 约束的 `extend` 块中——泛型 extend 带额外 `where` 约束在仓颉中受支持（参见 extend 文档 Sec 2.4）。

**[通过]** `const init` 构造——Vec4 已有 `const init` 实现验证可行。设计已标注风险，合理。

**[一般]** 标量在矩阵左侧的二元运算（`T + Mat`、`T - Mat`、`T * Mat`、`T / Mat`）在现有设计中描述的处理方式不准确。设计第 3.5 节和 D06 称通过矩阵 `extend` 块中"接收 `T` 参数的运算符"处理，但仓颉 `operator func +(rhs: T)` 的语义是 `this + rhs`（即 `Mat + T`），无法处理 `T + Mat`。阶段一实际通过 `scalar_vec_ops.cj` 中的**全局具名函数**（`add<T,Q>(s: T, v: Vec4<T,Q>)` 等）实现标量左侧运算，而非 extend 块运算符。设计需澄清：要么为矩阵建立等价的全局函数（如 `scalar_mat_ops.cj`），要么明确排除标量左侧矩阵运算符作为 GLM 差异。D06 修订注中的理由描述"与阶段一标量-向量运算的约束一致"与阶段一实际实现方式不符。

### 2. 标准库与生态覆盖

**[通过]** `Number<T>`、`Integer<T>`——来自 `std.math`，阶段一已验证可用。

**[通过]** `Equatable<T>`、`Comparable<T>`——来自 `std.core`（自动导入），阶段一已验证。

**[通过]** `@OverflowWrapping`——来自 `std.overflow`，阶段一已验证。

**[通过]** `@Derive[Hashable]`——来自 `std.deriving`，阶段一已验证。

**[通过]** `ComputeEqual<T>` / `ComputeEqualNumeric<T>`——阶段一已在 `compute_vector_decl.cj` 中定义，可直接复用。

**[通过]** stub 函数库（`common.cj`、`matrix.cj`、`geometric.cj`）——仅函数签名空壳，阶段二不依赖这些函数的实际实现，合理。

### 3. 语言特性可行性

**[通过]** 错误处理策略（下标越界 `Exception`、算术溢出 `@OverflowWrapping`）——与阶段一 Vec 类型一致。

**[通过]** 并发设计——矩阵为值类型 struct，运算符返回新实例，天然线程安全，无需同步。

**[通过]** 包组织结构（`glm.detail`、`glm`、`glm.ext`）——`src/detail/` → `package glm.detail` 匹配目录名规则；`src/ext/` → `package glm.ext` 同样匹配，与阶段一模式一致。

**[通过]** `glm.ext` 下别名文件通过 `import glm.detail.*` 访问 detail 类型——包间 `import` 规则支持。

**[通过]** `cjpm.toml` 确认 `src-dir` 覆盖 `src/ext/`——合理，须在实现时验证。

**[轻微]** 跨 Qualifier 构造函数 `init<Q2>(m: Mat4x4<T, Q2>)`——struct 支持泛型成员函数，但编译器是否允许 `init` 携带额外类型参数需原型验证。设计已自标注为风险，建议在阶段二编码前编写原型测试。

### 4. 设计一致性

**[通过]** 9 个矩阵类型职责清晰、各有其列向量类型和运算符签名，无职责重叠或缺失。

**[通过]** 模块依赖关系为有向无环图：`glm.detail`（核心层）→ `glm`（公共 API 别名层）和 `glm.ext`（子包别名层），`glm` 与 `glm.ext` 间无相互依赖。

**[通过]** 9 个非方阵文件无函数库依赖，3 个方阵文件依赖 stub——依赖链合理、闭合。

**[通过]** 构造函数体系完整覆盖 GLM 的 8 种构造模式，行为契约描述清晰。

**[通过]** 矩阵乘法维度匹配关系正确（`Mat2x3 * Mat2x2 → Mat2x3` 等），与列主序存储约定一致。

### 5. 设计质量

**[通过]** 职责划分遵循 SRP——每个矩阵类型对应一种 C×R 组合，无额外职责。

**[通过]** 抽象层次恰当——不引入不必要的泛型参数化（如 `Mat<C,R,T,Q>` 的偏特化），因为仓颉不支持该模式。

**[通过]** 9 个独立类型而非统一泛型的决策理由充分（仓颉无模板偏特化），与阶段一 Vec 设计策略一致。

**[通过]** 值类型设计便于测试——运算符返回新实例、无副作用，可轻松断言结果。

**[通过]** 排除 `++`/`--`、`%`、位运算的决策理由充分——矩阵语义不相关或使用率极低。

## 修改要求（REJECTED 时存在）

### 问题 1：标量左侧矩阵运算处理方式与实际能力不匹配

- **问题**：设计第 3.5 节和 D06 描述标量在矩阵左侧的二元运算（`T + Mat` 等）由矩阵 `extend` 块中定义运算符处理。仓颉中 `operator func +(rhs: T)` 的 `this` 为左操作数，仅能表达 `Mat + T`，无法表达 `T + Mat`。
- **原因**：该设计描述在仓颉类型系统中不可实现，将导致标量左侧运算缺失或实现的编码阶段发现设计缺陷。
- **建议方向**：参考阶段一 `scalar_vec_ops.cj` 模式，为矩阵类型建立对应的**全局具名函数**（如创建 `scalar_mat_ops.cj` 提供 `add<T,Q>(s: T, m: Mat4x4<T,Q>)`、`sub`、`mul`、`div`）处理标量左侧运算；或明确将标量左侧矩阵运算列为与 GLM 的差异并在文档中说明。无论选择哪种方案，均需修正第 3.5 节和 D06 的对应描述以准确反映实现方法。
