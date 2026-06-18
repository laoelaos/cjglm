根据以下审查结果，迭代上一轮的产出，形成新版的文件，从而更好地满足用户需求。

## 当前审查结果

**P1（严重）：256 个别名的命名约定未明确定义**

§3.8 列举了 16 个别名家族，使用全小写 + 无分隔符的 GLM 原生风格，但同一节中的示例格式使用 `Vec2Float32`、`LowpVec2Float32`、`IVec2` 等大写驼峰风格。两套命名风格存在冲突，文档未明确约定 256 个别名的实际命名规则。编码人员将面临以下未回答的问题：最终别名是 `bvec2` 还是 `BVec2`？`i8vec2` 的精度变体是 `lowp_i8vec2` 还是 `LowpI8Vec2`？精度前缀的约定是下划线连接还是驼峰连接？§3.8 列出的"别名家族"描述与编码阶段需要编写的 `type` 语句之间缺乏明确的映射规则。
- 改进建议：在 §3.8 中增加一个明确的命名约定子节，约定以下规则：①统一采用 GLM 原生小写风格或统一采用大写驼峰风格，必须选择其一；②精度变体前缀明确约定使用下划线或前缀拼接；③可选：提供一份 `type` 别名实际格式的示例表，覆盖所有 4 个精度变体。

**P2（高）：`scalar op vec` 具名函数的定义位置和形态未指定**

§4.3 为 `scalar + vec`、`scalar - vec`、`scalar / vec` 等左标量右向量运算提供了具名函数替代方案，但未说明这些函数：①定义在哪个包/文件中；②以什么形态定义（扩展成员函数、包级独立函数、extension 块）；③调用方需要如何导入才能使用；④是否为每个 Vec 类型分别定义，还是通过某种模式统一提供。
- 改进建议：在 §4.3 或 §2 中补充：①选择文件归属；②明确是扩展成员函数还是独立函数；③单向扩展成员函数+双向独立函数的组合方案需在文档中明确分层。

**P3（高）：Aligned* Qualifier 类型的可见性策略未明确**

§3.1 定义了 AlignedHighp/Mediump/Lowp 三种对齐类型，§2 中 `lib.cj` 的 `public import` 列表仅导出 Packed 系列和 Defaultp。文档未说明在 `qualifier.cj` 中 Aligned 结构体是声明为 `public` 还是包级可见（internal）。两种选择的后果差异显著——若为 `public`，下游可间接访问但无行为约定；若为 `internal`，未来切换 `GLM_CONFIG_ALIGNED_GENTYPES = true` 时需要修改可见性。
- 改进建议：在 §3.1 或 §7 中新增一条设计决策，明确 Aligned 系列在首轮的可见性（建议设为 `internal`），后续轮次切换配置时需将相关类型改为 `public` 并补充到 `lib.cj` 的导出列表。

**P4（中）：`compute_vector_relational.cj` 的依赖声明包含不必要的 `shim_cstddef.cj`**

§2 模块依赖图和 §8.1 迁移文件清单均声明 `compute_vector_relational.cj` 依赖 `shim_cstddef.cj` + `shim_limits.cj`。但简化后的 `ComputeEqual<T>` 在首轮设计中仅使用 `isIec559Of<T>()`（来自 `shim_limits.cj`）和 `epsilonOf<T>()`（也在 `shim_limits.cj`），未引用 `SizeT` 或 `LengthT`。
- 改进建议：将 `compute_vector_relational.cj` 的依赖修正为仅 `shim_limits.cj`，移除 `shim_cstddef.cj`。

**P5（中）：`LengthT` 类型别名在 Vec 类型中未被使用**

§3.6 在 `shim_cstddef.cj` 中定义了 `type LengthT = Int64`，但 Vec 类型的 `length()` 静态方法返回 `Int64`，`operator[]` 索引参数类型也直接使用 `Int64`，均未使用 `LengthT` 别名。
- 改进建议：两种解决方案择一：①将 Vec 的 `length()` 返回类型和 `operator[]` 索引类型改为 `LengthT`；②在 §3.6 中说明 `LengthT` 是通用长度类型别名，供下游消费者使用，Vec 内部保持 `Int64`。

**P6（中）：浮点 Vec 的 IEEE 754 精确相等比较无可用入口**

`==` 运算符对浮点分量使用 Epsilon 容差比较，在 `Infinity == Infinity` 场景下错误返回 `false`。设计未提供让调用方选择"容差比较"还是"精确比较"的机制，文档提到 `equalEpsilon` 但"不属于首轮范围"。
- 改进建议：在 §4.5 或 §4 中增加一个非 `const` 的 `equalExact`（或 `equalIEEE`）具名函数，使用精确比较（`a == b`）而非容差比较，作为 `==` 运算符的补充。

**P7（低）：默认字符串表示的行为约定过于模糊**

§3.2 约定 Vec 类型"不实现自定义 `toString()`"，但后续描述使用了"可能""预期"等推测性措辞。
- 改进建议：将模糊措辞替换为精确声明："首轮依赖仓颉编译器为 struct 生成的默认字符串表示——格式和内容由编译器确定，调用方不应依赖特定格式"，或选择实现自定义 `toString()`。

## 历史迭代回顾

- **已解决的问题**（出现在历史反馈中但本轮不再提及）：
  - 第 1-10 轮中所有问题已在迭代中得到修复，包括但不限于：`let`/`var` 成员声明、`@OverflowWrapping` 标注策略、`length()` 成员函数、构造函数完整签名清单、`const if` 编译期分支、`Vec<Bool,Q>` 抽象类型引用、`Hashable` 实现、Vec3/Vec4 缺失构造函数等。
  - 第 11 轮除 P1-P7 之外的其他审查反馈已在跨轮次修复中覆盖。

- **持续存在的问题**（本轮与第 11 轮反馈高度重合，需重点解决）：
  - P1（别名命名约定）：§3.8 命名风格冲突问题从第 11 轮延续至今，仍未得到明确约定，是阻塞编码的首要问题。
  - P2（`scalar op vec` 函数位置）：具名函数的定义位置和形态在第 11 轮已提出，当前文档仍缺少明确说明。
  - P3（Aligned* 可见性）：Qualifier 对齐类型的 API 边界问题在第 11 轮已提出，需本轮决策。
  - P4（`compute_vector_relational.cj` 依赖）：历史残留的依赖声明在第 11 轮已指出，需修正。
  - P5（`LengthT` 未使用）：抽象一致性问题在第 11 轮已指出，需做一致性选择。
  - P6（浮点精确相等比较）：Infinity 比较无替代入口的问题在第 11 轮已指出，需补充 API。
  - P7（字符串表示模糊）：措辞精确性问题在第 11 轮已指出，需替换为精确声明。

- **本轮需解决的总体优先级**：
  1. 优先解决 P1（严重级别，直接阻塞编码）
  2. 其次解决 P2-P3（高级别，影响编码就绪度）
  3. 其余 P4-P7（中低级别，可在编码阶段作为技术债处理，但建议本轮一并修复以提升文档完整性）

## 上一轮产出路径
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606170050_glm-migration-ood\a_v11_design_v2.md

## 用户需求
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606170050_glm-migration-ood\requirement.md
