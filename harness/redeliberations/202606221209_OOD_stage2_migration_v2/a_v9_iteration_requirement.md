根据以下审查结果，迭代上一轮的产出，形成新版的文件，从而更好地满足用户需求。

## 当前审查结果

### 问题 1（中等）
**§8 编译顺序分析依赖未经验证的编译器行为假设**。§8 "compile order 说明"声称仓颉编译器支持对同包内前向类型引用的"延迟解析"——"编译器会延迟到类型可用时再完成扩展成员的注册"。此声明未提供任何文档引用或实验验证。经查阅仓颉语言包机制和扩展机制的官方文档，未找到"延迟解析"或"按需解析"的相关描述。若编译器不支持此行为，Vec 类型 extend 块中对矩阵类型的前向引用将直接导致编译失败，整个设计方案中行向量×矩阵乘法的实现路径将不可行。
- **所在位置**：§8 "compile order 说明"（约 L448-459）
- **改进建议**：① 将此声明改为"待验证"标注，在编码启动首日进行最小原型验证（创建包含 Vec extend 块引用矩阵类型的同包文件并编译）；② 若验证失败，提供 fallback 方案（例如将行向量×矩阵乘法挪到矩阵类型所在的文件中定义为自由函数+全局函数，或推迟至矩阵类型定义完成后以额外 extend 块方式组织）。

### 问题 2（中等）
**§3.3 fromParts/fromColumns 工厂函数签名完全缺失**。§3.3 第 4 条（fromParts）和第 5 条（fromColumns）仅提及函数存在，未提供任何具体签名——包括参数个数、参数类型、conv 闭包的作用范围、返回值等。编码者无法据此实现。例如对于 Mat2x3（2 列 3 行），fromParts 需要 6 个分量参数还是 2 个列向量参数还是其他形式？fromColumns 接受 Vec3 还是 Vec2 类型的列向量列表达？这些关键信息完全缺失。
- **所在位置**：§3.3 items 4, 5
- **改进建议**：为每个矩阵类型（或至少按列数分类）提供 fromParts 和 fromColumns 的完整函数签名示例。建议参照 GLM 1.0.3 对应的 .inl 文件中的构造函数签名，给出仓颉版本的具体签名。

### 问题 3（中等）
**fromMat 6a/6b/7 工厂函数缺少完整泛型约束声明**。§3.3 第 6a、6b、7 条描述了 fromMat 工厂函数的类别和行为规则，但未给出任何一条的完整泛型约束签名。编码者无法确定：
- 6a（同类型不同尺寸）是否需要 `T <: Number<T>` 约束（用于 T(0) 演算）
- 6b（跨类型不同尺寸）对源类型 U 是否需要 `U <: Number<U>` 约束
- 7（跨类型同尺寸）是否只需要 `Q <: Qualifier` 约束，还是也需要 `T <: Number<T>`
- **所在位置**：§3.3 items 6a, 6b, 7；§4.3-4.5 仅给出使用示例
- **改进建议**：为 fromMat 6a、6b、7 各提供一个完整的泛型函数签名示例，包含 `where` 约束子句。例如：
  - 6a: `static func fromMat(m: Mat2x2<T,Q>, one: T): Mat2x3<T,Q> where T <: Number<T>, Q <: Qualifier`
  - 6b: `static func fromMat<U, P>(conv: (U) -> T, m: Mat2x2<U,P>, one: T): Mat2x3<T,Q> where T <: Number<T>, Q <: Qualifier, P <: Qualifier`
  - 7: `static func fromMat<U, P>(conv: (U) -> T, m: Mat4x4<U,P>): Mat4x4<T,Q> where Q <: Qualifier, P <: Qualifier`

### 问题 4（轻微）
**length() 设计（实例方法）与阶段一 Vec 类型（静态方法）存在 API 风格不一致**。阶段一 Vec 类型（type_vec1~4.cj）的 `length()` 定义为 `public static func length(): Int64`（静态方法，调用方式 `Vec4.length()`）。本设计将矩阵 `length()` 定义为 `const func length(): Int64`（实例方法，调用方式 `m.length()`）。§9 差异声明记录了此设计不同于 C++ GLM（`mat4::length()` 静态），但未提及与同一库中 Vec 类型的静态风格不一致。同一库中 Vec 和 Mat 使用不同调用惯例，可能引起下游使用者的困惑。
- **所在位置**：§3.1（`length()` 声明）、§9（仅提及与 C++ GLM 的差异）
- **改进建议**：在 §9 差异声明中补充"与阶段一 Vec 类型的静态 `length()` 不一致，Mat 采用实例方法以支持运行时多态"或类似说明。如非必要，可考虑与阶段一风格保持一致的 `static func length(): Int64`。

### 问题 5（轻微）
**Bool 矩阵的 fromMat 跨类型转换支持未明确**。§7 D33 和 §9 差异声明列出了 Bool 矩阵支持/不支持的操作（不支持算术运算符、identity、filled、equalEpsilon；支持构造、下标、比较、Hashable）。但未明确表示 Bool 矩阵是否支持 `fromMat` 跨类型同尺寸转换（例如 `Mat4x4<Bool, Q>.fromMat({ x => x > 0 }, mFloat)`）。矩阵运算中 Bool 矩阵常用于掩码/选择操作，跨类型转换是其典型应用场景。当前文档的排除清单未涵盖此场景，产生歧义。
- **所在位置**：§7 D33、§9 "Bool 矩阵"差异条目
- **改进建议**：明确声明 Bool 矩阵是否支持 fromMat 跨类型转换。若支持，说明其约束（fromMat 7 需要 `T=Bool` 满足什么条件？不需要 `Number<T>` 约束的 fromMat 7 应当可用）。若不支持，在排除清单中补充说明。

## 历史迭代回顾

- **已解决的问题**：以下问题在前序轮次（3-7）中被识别并已在 v8 设计中修复：
  - 第 3 轮：fromMat 参数顺序不一致 → 已修复
  - 第 4 轮：++/-- 运算符排除（D08）、fromMat 模型赋值运算符、签名使用伪类型 → 已修复
  - 第 5 轮：cjpm 子包构建风险、B 类 fromMat 行为契约 → 已修复
  - 第 6 轮：fwd.cj 类型别名清单、stub 函数签名清单、Vec extend operator* 签名 → 已修复
  - 第 7 轮：Mat×Vec 运算符签名缺失、乘法重载数量、手动定义数量推导 → 已修复
  - 第 8 轮：cjpm 子包方案、复合赋值 fallback、B 方向 GLM 对照、编译顺序说明、@Derive[Hashable] 验证、length() 差异声明、fwd.cj 别名清单、stub 签名清单、Vec operator* 签名、Bool 矩阵策略、equalExact 说明 → 已在 v8 中修复

- **持续存在的问题**：无 — 本轮 5 个问题均为新发现，前序轮次中未出现。

- **新发现的问题**：
  - §8 编译顺序分析依赖未验证的编译器行为假设（问题 1）
  - fromParts/fromColumns 工厂函数签名缺失（问题 2）
  - fromMat 6a/6b/7 泛型约束声明缺失（问题 3）
  - length() API 与阶段一 Vec 风格不一致（问题 4）
  - Bool 矩阵 fromMat 跨类型转换支持未明确（问题 5）

## 上一轮产出路径
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606221209_OOD_stage2_migration_v2\a_v8_design_v1.md

## 用户需求
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606221209_OOD_stage2_migration_v2\requirement.md
