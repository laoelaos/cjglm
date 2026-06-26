# OOD 设计方案审查报告（v1）

## 审查结果

REJECTED

## 逐维度审查

### 1. 类型系统可行性

**[通过]** `Quat<T, Q>` 作为泛型结构体的选择正确，与阶段一/二的 Vec/Mat 策略一致，匹配仓颉 struct 值类型语义。`@Derive[Hashable]`、`const init` 构造函数、`Number<T>` / `Equatable<T>` / `Comparable<T>` 等约束类型均在仓颉类型系统能力范围内。

**[通过]** 泛型上下文中 T(0)/T(1) 获取策略与阶段二完全一致：`T(0)` 通过 `one - one` 或 `someValue - someValue` 演算获取、`T(1)` 通过 `one: T` 参数显式传入。`identity(one)` 工厂函数签名、跨 Qualifier 构造 `init<Q2>(q: Quat<T,Q2>)`、跨类型工厂函数 `fromQuat<U, P>(conv, q)` 均符合仓颉泛型语法。运算符重载签名（`+ - * / == != -()`）与阶段一 Vec3 文件 (`cjglm/src/detail/type_vec3.cj`) 的现有模式一致。

**[通过]** Vec3/Vec4 的 extend 块中定义 `Vec3×Quat`/`Vec4×Quat` 运算符依赖于"扩展与被扩展类型同包"（Vec 类型与 Quat 类型同属 `glm.detail`），符合仓颉 extend 规则（同包内可见性，且扩展不能遮蔽已有成员）。D04 中识别的前向引用风险已在阶段二原型验证中通过，本阶段为防御性确认。

**[通过]** `mat3Cast`/`mat4Cast`/`quatCast` 作为包级函数定义于 `glm.detail`（与阶段二 `transpose`/`identity` 等函数库的组织方式一致）。

### 2. 标准库与生态覆盖

**[通过]** 仓颉标准库能力核查：
- `std.math.sqrt` 用于 `length(q)` —— 已确认 `sqrt(x: Float64): Float64` 在 std.math 提供（仓颉标准库速查文档第 2 节）。
- `Number<T>` / `Comparable<T>` / `Equatable<T>` 约束类型在 std.core 提供。
- `@Derive[Hashable]` 自动派生在 std.deriving 提供。
- `@OverflowWrapping` 溢出注解在 std.overflow 提供。
- 浮点 NaN/Inf 检测 —— 标准库仅提供**实例方法**形式 `x.isNaN()`/`x.isInf()`，**不提供** `std.math.isNaN()`/`std.math.isInfinite()` 顶层函数（仓颉标准库速查文档第 5 节）。设计文档 §3.11 已正确标注 `isnan`/`isinf` 实现需原型验证。

**[通过]** ULP 比较函数不可行性的根因分析正确：仓颉无 `reinterpret_cast`/匿名 `union`，无法实现 `detail::float_t<T>::i`/`mantissa()`/`exponent()`/`negative()` 等 C++ GLM 的位表示访问技巧。D07 决策合理。

**[通过]** `quaternion_geometric.cj` 的 `dot`/`length`/`normalize`/`cross` 四个函数确认仅依赖 `std.math.sqrt` 和算术运算（不依赖 geometric.cj stub），本阶段可完整实现（D14 决策正确）。

**[通过]** `scalar_constants.cj` 的 `epsilon<T>()`/`pi<T>()`/`cos_one_over_two<T>()` 使用 match 类型模式匹配 + hint 参数辅助类型推断，与 deviations.md DV-04 已验证策略一致。

### 3. 语言特性可行性

**[通过]** 错误处理策略：下标越界 `throw Exception` 与阶段一/二一致；`normalize` 零四元数返回单位四元数（与 GLM `quaternion_geometric.inl:20-21` 的 `if(len <= 0) return qua<T,Q>::wxyz(1,0,0,0)` 行为一致，仓颉版本以 `identity(one)` 等价表达）；stub 函数体 `throw Exception("stub")`。

**[通过]** cjpm 子包构建：`glm.detail`/`glm`/`glm.ext` 三层结构沿用阶段二已验证的 ext/ 子包策略；gtc/ 子包为新增，需要阶段三原型验证（已在 §8 编码启动前验证项第 1 项列出）。

**[通过]** 同包前向引用延迟解析：`type_quat.cj` 中构造函数体调用 `quatCast`（同为 detail 包内的包级函数）、Vec3/Vec4 extend 块中引用 Quat 类型，均依赖同包延迟解析。已在 §8 验证项第 2/3 项列出。

**[通过]** 并发设计：Quat 为值类型，所有运算符返回新实例，天然线程安全。

**[一般]** D19 决策"四元数算术运算符不标注 `@OverflowWrapping`"的合理性论证存在两处问题：
1. **阶段不一致**：阶段一 Vec3 (`type_vec3.cj:64-80`) 与阶段二全部矩阵类型 (`type_mat2x2.cj`、`type_mat3x3.cj`、`type_mat4x2.cj` 等) 均对算术运算符（含浮点重载）统一标注 `@OverflowWrapping`。std.overflow 模块确认 `@OverflowWrapping` 注解对浮点类型确实无效果（其语义仅作用于整数溢出行为），但阶段一/二为保持跨整数/浮点实例化的统一行为仍选择标注。本设计对 Quat 单独豁免会破坏这一统一约定。
2. **引用不存在文档**：D19 注释"参见 deviations.md DEV-26 偏差分析"，但 deviations.md 当前条目最高编号约为 DEV-11/DEV-14/DEV-26 之间存在大量空号，且全文未检索到 `DEV-26` 内容。该引用缺乏可追溯性。

补充：设计文档 §5 溢出策略段落承认"仓颉 `Number<T>` 约束下理论上允许整数实例化"，若未来有整数四元数用例，缺少 `@OverflowWrapping` 将导致整数加法/乘法溢出行为不可控（默认可能为抛异常或饱和），与 Vec/Mat 一致性破坏。建议统一标注，或在设计文档中明确"Quat 类型仅限 Float32/Float64 实例化"的约束收紧策略（如在 `identity` 工厂函数中拒绝整数类型）。

### 4. 设计一致性

**[通过]** 模块间依赖方向合理且无循环依赖：
- `type_quat.cj` → Vec/Mat 类型、ext/ 函数库、gtc/constants
- `scalar_quat_ops.cj` → `type_quat`
- `ext/*` → `glm.detail` + 必要的 stub
- `gtc/constants.cj` → `ext/scalar_constants.cj`
- `lib.cj` → 汇总公开 API

**[通过]** 行为契约覆盖四元数构造、旋转、插值、矩阵互转、常量访问五大场景，示例代码完整。

**[通过]** §10 GLM 1.0.3 API 阶段覆盖矩阵按 GLM 头文件逐项标注，提供了完整的可追溯链。

**[一般]** `lookRotate` 函数引用与 GLM 1.0.3 实际 API 不一致：
- 在 references/glm-1.0.3 目录下全文件检索 `lookRotate`，**未找到任何匹配**。GLM 1.0.3 中没有 `lookRotate` 函数。
- 实际 GLM 1.0.3 中与"看向"语义对应的函数是 `quatLookAt`/`quatLookAtRH`/`quatLookAtLH`，定义于 `gtc/quaternion.hpp:149-167`（已在 §3.2 的协作关系表中正确列出）。
- 设计文档 §2 模块表、`§3.2` 协作关系表、"`ext/quaternion_transform.cj` 大部分实现（lookRotate 依赖 geometric.cj stub）"、以及 §10 覆盖矩阵中均将 `lookRotate` 作为待迁移函数引用，但实际 GLM 中不存在此函数。
- 实际影响：§3.8 的"修正"段落将 `ext/quaternion_transform.cj` 缩减为"仅包含 `rotate` 的 stub"，但 §2 表中仍按原始（错误）描述列为"大部分实现"。建议将所有 `lookRotate` 引用替换为 `quatLookAt`（已在 §3.2 列出，§10 覆盖矩阵也正确标注为 gtc/quaternion 函数），并修正 §2 模块表的描述。

**[一般]** §2 模块表与 §3.8 修正段落存在内部矛盾：
- §2 表格行 20 描述 `ext/quaternion_transform.cj` 为"大部分实现（lookRotate 依赖 geometric.cj stub）"
- §3.8 "修正"段落明确："GLM 中 `ext/quaternion_transform.hpp` 仅定义了 `rotate` 一个函数。而 `angleAxis` 定义在 `ext/quaternion_trigonometric.hpp` 中。`lookRotate`/`quatLookAt` 定义在 `gtc/quaternion.hpp` 中。因此 `ext/quaternion_transform.cj` 本阶段仅包含 `rotate` 的 stub"
- §2 表未采纳 §3.8 的修正结论，仍按原始（错误）的描述。建议 §2 表对齐到 §3.8 修正后的状态：明确 `ext/quaternion_transform.cj` 本阶段仅含 `rotate` stub。

**[一般]** §3.2 协作关系表与 §3.8/§3.9 之间存在不一致：
- §3.2 第 176 行："随 ext/quaternion_transform.cj 实现：`angleAxis`/`rotate`（不依赖 geometric.cj 的函数）"
- §3.8 修正段落：明确 `angleAxis` 定义于 `ext/quaternion_trigonometric.hpp`（非 `quaternion_transform.hpp`），因此归入 §3.9 的 `ext/quaternion_trigonometric.cj`
- §3.9：`angleAxis(angle: T, axis: Vec3<T,Q>): Quat<T,Q>` —— 依赖 `sin`/`cos`（trigonometric.cj stub），本阶段 **stub 占位**
- §3.2 第 176 行将 `angleAxis` 错误归类为"随 ext/quaternion_transform.cj 实现"，与 §3.8/§3.9 矛盾。建议修正 §3.2 的归类描述，与 §3.8/§3.9 保持一致。

### 5. 设计质量

**[通过]** 职责划分遵循单一职责原则：核心类型（type_quat.cj）、运算符扩展（extend 块）、公共函数库（quaternion_common.cj）、关系函数库（quaternion_relational.cj）、几何函数库（quaternion_geometric.cj）、变换函数库（quaternion_transform.cj）、三角函数库（quaternion_trigonometric.cj）、指数函数库（quaternion_exponential.cj）按功能域清晰分离。

**[通过]** 抽象层次恰当：设计停留在架构级抽象（类型形态、协作模式、约束策略、依赖链），不涉及具体字段实现细节，符合 OOD 文档定位。

**[通过]** stub 占位策略合理：完整实现（不依赖 stub 的函数）、大部分实现（部分依赖 stub 的函数）、空桩占位（gtc/matrix_transform.cj 及 4 个新增空桩）三类边界明确，依赖闭合通过 stub 占位文件保障。

**[通过]** 单元测试可测性已考虑：Quat 为值类型，运算符返回新实例，便于测试；stub 函数明确以 `throw Exception("stub")` 标识，便于测试识别阶段三/阶段四功能边界。

**[轻微]** §3.4 标量-四元数全局函数表中存在两条 `mul` 行：
- `mul<T, Q>(s: T, q: Quat<T, Q>)` —— 标量乘四元数
- `mul<T, Q>(s: T, q: Quat<T, Q>)` —— 标量×四元数（交换律别名）

两条签名完全相同（参数类型、返回类型、泛型约束一致），仅文字注释不同。仓颉语言不允许函数重载（仅在构成有效重载时允许，见 struct/README.md §1.4），因此重复声明将引发编译错误（"重复定义"）。若设计意图是"乘法的交换律别名"，则不需要单独的 mul 函数（乘法本身已具备交换律语义）；若意图是函数指针引用区分，则两条签名因完全一致而无法构成重载。建议删除其中一行，或调整其签名（例如 `mul(q: Quat<T,Q>, s: T)` 区分参数顺序）。

**[轻微]** §3.7 中 `cross(q1, q2)` 命名可能引起歧义：
- 设计明确"四元数叉积（即 Hamilton 乘积的逐分量展开）"，与 GLM `quaternion_geometric.inl:27-34` 实现一致
- 但仓颉侧 `geometric.cj` 的 `cross` 函数（来自阶段二 stub，阶段四补齐）面向 Vec3 叉积（向量叉乘）
- 同名 `cross` 在 Quat 和 Vec3 上下文分别表示 Hamilton 乘积和向量叉乘，可能给读者造成概念混淆
- 建议在设计文档或后续代码注释中明确"四元数 cross 即 Hamilton 乘积（与向量叉乘不同）"，或考虑重命名为 `crossProduct`/`hamiltonMul` 等区分性命名（与阶段四 geometric.cj 设计协调）。

## 修改要求（REJECTED 时存在）

### 问题 1：`lookRotate` 非 GLM 1.0.3 实际函数

- **问题**：设计文档 §2、§3.2、§10 等多处引用 `lookRotate` 作为待迁移函数，但 GLM 1.0.3 实际不存在该函数。对应的 GLM 函数是 `gtc/quaternion.hpp` 中的 `quatLookAt`/`quatLookAtRH`/`quatLookAtLH`。
- **原因**：factual 错误会导致编码阶段产生预期偏差（例如按 `lookRotate` 名义进行 stub 占位和测试覆盖时，对应的 GLM 函数是 `quatLookAt`）。
- **建议方向**：将所有 `lookRotate` 引用统一替换为 `quatLookAt`，并更新 §10 覆盖矩阵的对应行（§10 已正确列出 `quatLookAt/quatLookAtRH/quatLookAtLH` 为 gtc/quaternion 函数）。若 §2 表中的 "ext/quaternion_transform.cj 大部分实现" 是受 `lookRotate` 错误印象影响，应一并对齐到 §3.8 修正后的"仅含 rotate stub"。

### 问题 2：§2 模块表与 §3.8 修正段落矛盾

- **问题**：§2 表格行 20 描述 `ext/quaternion_transform.cj` 为"大部分实现（lookRotate 依赖 geometric.cj stub）"，但 §3.8 修正段落已明确本阶段仅含 `rotate` stub。
- **原因**：内部矛盾导致模块产出清单模糊，影响编码阶段对 `ext/quaternion_transform.cj` 范围的判断。
- **建议方向**：将 §2 表格行 20 的"实现状态"列更新为"仅 `rotate` 函数 stub"，与 §3.8 修正段落对齐。

### 问题 3：§3.2 协作关系表与 §3.8/§3.9 矛盾

- **问题**：§3.2 第 176 行将 `angleAxis` 归类为"随 ext/quaternion_transform.cj 实现"，但 §3.8/§3.9 已正确归入 `ext/quaternion_trigonometric.cj`。
- **原因**：内部矛盾，且 angleAxis 实现位置错误归类会导致编码阶段文件分工混乱。
- **建议方向**：删除 §3.2 第 176 行的 `angleAxis`，仅保留 `rotate` 在 `ext/quaternion_transform.cj` 的归类；或将该行整段移除（因 §3.8/§3.9 已提供正确归类）。

### 问题 4：D19 决策依据不充分

- **问题**：D19 决策"四元数算术运算符不标注 `@OverflowWrapping`"，其注释"参见 deviations.md DEV-26 偏差分析"指向不存在的文档条目；同时该决策与阶段一/二全量标注 `@OverflowWrapping` 的实践不一致。
- **原因**：引用不存在文档导致决策依据不可追溯；阶段不一致可能导致未来整数四元数用例出现不可预期的溢出行为。
- **建议方向**：
  - 选项 A：与阶段一/二对齐，对四元数算术运算符统一标注 `@OverflowWrapping`（标注对浮点无效果但保持跨类型一致性），并更新 D19 决策依据。
  - 选项 B：保留 D19 决策，但需补充说明："Quat 类型在 `Number<T>` 约束下不标注 `@OverflowWrapping`，与阶段一/二一致性差异，须在 §3.4 矩阵运算符表脚注或后续偏差记录（建议编号 DEV-XX）中正式登记为有意识设计偏差"。同时移除"参见 deviations.md DEV-26"引用，或新建 DEV-XX 条目记录此差异。

### 问题 5（轻微）：§3.4 中 mul 函数重复声明

- **问题**：§3.4 标量-四元数全局函数表中存在两条 `mul<T, Q>(s: T, q: Quat<T, Q>)` 完全相同签名的行。
- **原因**：仓颉函数重载规则禁止重复签名（仅在参数类型/数量/顺序不同时构成有效重载），重复声明将导致编译错误。
- **建议方向**：删除其中一行；若意图保留"交换律别名"语义，论证为何需要单独的别名函数（乘法本身已具备交换律），或调整签名为不同参数顺序以构成有效重载。