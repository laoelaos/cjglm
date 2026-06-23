# OOD 设计方案审查报告（v22）

## 审查结果

APPROVED

## 逐维度审查

### 1. 类型系统可行性

**[通过]** 9 个矩阵类型各自定义为独立泛型结构体（struct），使用 `<T, Q>` 类型参数，与仓颉泛型结构体能力完全匹配。

**[通过]** extend 块中的运算符重载（`operator func *`, `operator func +` 等）在 extend 块中定义，符合仓颉"extend 可添加运算符重载"的规则。

**[通过]** 泛型 extend 块中 `where T <: Number<T>, Q <: Qualifier` 的条件约束语法正确，仓颉支持在 extend 块上附加 `where` 子句以实现条件扩展。

**[通过]** 静态工厂函数（`identity`、`filled`、`fromParts`、`fromColumns`、`fromMat`）定义为 `public static func`，仓颉 extend 块支持 `static` 成员函数。

**[通过]** `@Derive[Hashable]` 用于 struct 自动派生，仓颉 std.deriving 明确支持（仅要求参与字段类型已实现对应接口，编码阶段需验证 Bool 兼容性——设计已将其列为验证项）。

**[通过]** 复合赋值自动生成规则（返回类型与左操作数匹配时自动生成）已在设计中正确处理——非方阵 `*=` 和 `/=` 因结果类型不匹配不会自动生成，设计已明确此行为（§3.5 末尾声明）。

**[通过]** 27 个矩阵×矩阵乘法重载（3 同尺寸 + 24 跨尺寸）计数正确，各 `operator func *(right: Mat{C2}x{R2}<T,Q>): Mat{C1}x{R2}<T,Q>` 签名在仓颉类型系统中可全部独立编码。

**[通过]** 矩阵-列向量乘法 `operator func *(v: VecR<T,Q>): VecC<T,Q>` 返回类型与 self 不同，符合仓颉运算符重载规则（返回值类型可任意，仅复合赋值需要类型匹配）。

**[轻微]** `fromParts` 家族签名（§3.3 item 4 签名表）中声明了未使用的类型参数 `P`。例如 `fromParts<U, P>(conv: (U) -> T, a00: U, a01: U): Mat2x2<T,Q> where Q <: Qualifier, P <: Qualifier` 中，`P` 未出现在任何参数类型或返回类型中。标量值本身不携带 Qualifier 类型信息，`P` 无实际用途。建议全部移除 `P` 参数以保持签名整洁，避免潜在的编译警告或错误。

### 2. 标准库与生态覆盖

**[通过]** 设计依赖的标准库能力均在仓颉标准库覆盖范围内：
- `Number<T>`、`Equatable<T>`、`Comparable<T>`、`Qualifier` — std.core
- `Exception` — std.core
- `@OverflowWrapping` — std.core 整数溢出注解
- `@Derive[Hashable]` — std.deriving

**[通过]** 未对外部非标准库做任何假设，所有依赖均为仓颉内置标准库接口。

### 3. 语言特性可行性

**[通过]** 错误处理方案（下标越界 throw Exception、stub 函数体 throw Exception）为仓颉标准异常处理模式。

**[通过]** 并发设计（本阶段不引入并发，值类型天然线程安全）合理且务实。

**[通过]** 标量左运算通过全局函数实现（`scalar_mat_ops.cj`），该方案正确绕过了仓颉 `operator func` 左操作数须为 self 类型的限制。

**[通过]** Boot 矩阵排除算术运算符、`filled()`、`identity()`、`equalEpsilon()` 的原因明确（Bool 不实现 `Number<T>` 接口），设计决策 D33 记录完善。

**[通过]** cjpm 子包构建（`glm.ext` 子包）风险已充分认知，设计了三个递进退守方案和原型验证步骤。

**[通过]** Vec extend 块引用矩阵类型的编译顺序风险已充分认知，提供了三个递进退守方案（含全局自由函数 `mul_row_vec_mat` 和 API 形态变化的影响说明）。

**[通过]** `++/--` 被正确排除（仓颉不支持重载自增/减），提供了等价替代建议（`m += one`）。

**[通过]** 模板赋值运算符被正确排除（仓颉不允许重载 `operator=`）。

### 4. 设计一致性

**[通过]** 核心抽象职责清晰：9 个矩阵结构体分别对应 C×R 矩阵，以列向量为数据成员，列主序存储。

**[通过]** 构造函数分层合理：逐分量同类型构造（const init）、逐分量跨类型（fromParts）、列向量构造（fromColumns）、跨矩阵类型转换（fromMat 6a/6b/7）。签名模板已从家族模板替换为 9 个独立签名表，参数数量与 C×R 一致，不再存在结构矛盾。

**[通过]** 协作关系形成闭环：方阵依赖 matrix.cj/common.cj/geometric.cj 的 stub 函数；非方阵无函数库依赖；标量-矩阵运算通过 scalar_mat_ops.cj 全局函数覆盖；Vec extend 块的行向量×矩阵运算符覆盖所有 R={2,3,4} 组合。

**[通过]** 模块间依赖方向清晰，无循环依赖。详见 §2 依赖图。

**[通过]** §9 差异声明完整记录了所有与 GLM 参考实现的偏差，包括 length() 的静态成员函数设计、identity 对非方阵的支持、fromMat 6a 的跨 Qualifier 限制、Mat4x4←Mat4x2 偏差等。

**[通过]** Bool 矩阵排除边界在声明位置标注了 D33 交叉引用（§3.3 item 3 末尾和 item 8 末尾），fromMat 7 的 Bool 使用示例已补充。

**[通过]** HighpDMat 方阵短别名已修正为 `HighpDMat2`/`HighpDMat3`/`HighpDMat4`。

**[通过]** §8 产出物清单中 lib.cj 导出粒度已明确定义为 4 项清单。

**[通过]** 非方阵 `*=` 不可用的实现指导已明确陈述（§3.5 末尾）。

### 5. 设计质量

**[通过]** 单一职责原则：每个矩阵类型负责一种 C×R 矩阵，工厂函数和运算符通过 extend 块组织，结构与行为分离恰当。

**[通过]** 抽象层次恰当：设计停留在架构级抽象（类型形态、协作关系、行为契约），不包含具体字段遍历的算法细节或方法体的具体实现——这正是 OOD 设计阶段应有的粒度。

**[通过]** 可测试性良好：值类型（struct）确保运算符返回新实例、无副作用。B 类方向和 Mat4x4←Mat4x2 偏差都列出了明确的单元测试验证要求。

**[通过]** 可扩展性明确预留：determinant/inverse 以 stub 形式占位（阶段三实现）、row() 推迟至阶段四、common.cj/geometric.cj 的向量版本推迟至阶段四。

**[通过]** 风险识别充分：cjpm 子包构建、复合赋值自动生成、编译顺序、@Derive[Hashable] T=Bool 四项风险均在"编码启动前验证项"中明确列出。

## 修改要求（APPROVED — 无阻塞问题）

无严重或一般问题。仅存在 1 个轻微级改进建议：

- **问题**：`fromParts` 家族签名（§3.3 item 4）中声明了未使用的类型参数 `P`
- **原因**：`P` 仅出现在 `where P <: Qualifier` 约束中，未出现在任何参数类型或返回类型中。标量值不携带 Qualifier 类型信息，`P` 无实际用途
- **建议方向**：移除 `fromParts` 全部 9 个签名中的 `<U, P>` 中的 `P`，仅保留 `<U>`，同时移除 `where` 子句中的 `P <: Qualifier`
