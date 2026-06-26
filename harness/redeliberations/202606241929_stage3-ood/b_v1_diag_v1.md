# 质量审查报告：a_v1_design_v2.md

> 审查日期：2026-06-24
> 审查轮次：第 1 次
> 审查范围：需求响应充分度、事实准确性与逻辑一致性、深度与完整性（侧重落地可实施性）
> 审查定位：内部审议已覆盖技术可行性等维度，本次审查侧重需求响应充分度与整体深度完整性

---

## 1. 需求响应充分度

### 问题 1：未对 `gtc/quaternion.cj` 文件进行完整规划

- **位置**：§2 包组织、§3.2 协作关系表与策略段落、§8 产出物清单
- **严重度**：严重
- **问题描述**：设计文档在多个关键位置（§3.2 第 167-170 行的协作关系表、§3.2 策略段「随 gtc/quaternion.cj 实现」条款、§3.2 策略段「stub 占位（归入 gtc/quaternion.cj）」条款、§10 gtc/quaternion.hpp 覆盖矩阵）反复引用 `gtc/quaternion.cj` 作为承载 `mat3_cast`/`mat4_cast`/`quat_cast`/`eulerAngles`/`roll`/`pitch`/`yaw`/`lessThan*`/`greaterThan*`/`quatLookAt*` 等 17 个函数的具体文件。然而，§2 的 `glm.gtc` 包组织图（行 82-85）只列出 `constants.cj` 和 `matrix_transform.cj` 两个文件，`gtc/quaternion.cj` 未纳入；§8 产出物清单也未将 `gtc/quaternion.cj` 列入「完整实现」「大部分实现」「空桩占位」任何一类。这意味着该文件是承载 17 个函数（其中至少 5 个本阶段实现、3 个本阶段 stub、9 个本阶段实现）的核心载体，但缺少：
  - 文件归属包名（`glm.gtc`）的显式声明
  - 模块组织树中的位置标注
  - §8 产出物清单中的状态分类（完整/大部分/空桩）
  - `fwd.cj`/`lib.cj` 的对应 `public import` 设计
  - 该文件与 `type_quat.cj` 的函数归属边界（`mat3_cast` 等放在哪个文件的具体决策）

  修复者拿到设计后无法直接确定 `gtc/quaternion.cj` 应创建在哪个目录、声明哪个包、包含哪些函数、与 `type_quat.cj` 的代码归属如何划分。设计文档需要决策：是单独创建 `src/gtc/quaternion.cj`（需 cjpm 子包支持），还是将 17 个函数分散到 `type_quat.cj` + `gtc/matrix_transform.cj` 等已有文件，还是与阶段二「混合型文件」模式一致创建一个混合型 `gtc/quaternion.cj`。

- **改进建议**：
  1. 在 §2 `glm.gtc` 包组织下补充 `quaternion.cj ★` 条目，明确其状态（如「混合型：5 完整实现 + 9 比较函数 + 3 stub」）
  2. 在 §3.2 策略段落明确 `gtc/quaternion.cj` 的归属（独立文件 vs 合并到 `type_quat.cj`），消除当前的「gtc/quaternion.cj（随 type_quat.cj 编码）」注释与「随 type_quat.cj 一同实现」表述之间的矛盾
  3. 在 §8 产出物清单中按「完整实现」「大部分实现」「空桩占位」三类补充 `gtc/quaternion.cj` 的明确分类

### 问题 2：测试文件未在设计层面规划

- **位置**：§8 完整实现清单第 510 行
- **严重度**：一般
- **问题描述**：§8 完整实现清单末尾提及「四元数测试文件」一行但未展开。设计文档未对测试文件做以下规划：
  - 测试文件数量与位置（`tests/glm/detail/type_quat_test.cj` + 各 ext/ 函数库独立测试文件？还是单一综合测试文件？）
  - 至少需覆盖的测试维度（构造/运算符/各 ext 函数库正常路径、stub 函数异常路径、跨 Qualifier 实例化覆盖）
  - 测试用例数与覆盖目标（与阶段一/二 OOD 的「476/422 个测试」等量化基线对齐方式）
  - 阶段三可验证 vs 待阶段四验证的测试拆分策略
  - 浮点比较策略（是否使用 `equalEpsilon` 或硬编码精度容差）
  - 跨类型/跨 Qualifier 测试的覆盖深度

  路线图 02_roadmap.md §3 第 123-133 行明确列出本阶段验证标准（如「四元数构造（单位构造、旋转轴-角构造、矩阵-四元数互转）」需 `[可验证]`），但 OOD 文档未给出对应的测试设计与覆盖策略，编码阶段可能因缺乏明确测试规划导致测试覆盖不均或返工。

- **改进建议**：在 §8 末尾或新增 §8.2「测试设计」章节补充测试文件清单、覆盖维度、可验证/待阶段四拆分策略、跨类型覆盖范围、至少用例数目标。确保测试文件结构与路线图验证标准一一对应。

### 问题 3：依赖图与模块边界未明确 `gtc/quaternion.cj` 的依赖方向

- **位置**：§2 模块间依赖图（行 116-119）
- **严重度**：一般
- **问题描述**：§2 的模块间依赖图中，`glm.gtc` 块只列出 `constants.cj` 和 `matrix_transform.cj` 的依赖关系，缺少 `gtc/quaternion.cj` 的依赖方向说明。从 §3.2 的描述推断，`gtc/quaternion.cj` 应依赖 `glm.detail`（`Quat`/`Mat3x3`/`Mat4x4`）、`glm.ext.scalar_constants`（`epsilon<T>()`）、`glm.ext.vector_relational`（`equal`）、`glm.detail.common(stub)`/`trigonometric(stub)`（`atan`/`asin`），但这些依赖关系在 §2 依赖图中未呈现。修复者无法从依赖图直接评估 `gtc/quaternion.cj` 引入对整个依赖图的影响。

- **改进建议**：在 §2 依赖图的 `glm.gtc` 块下补充 `quaternion.cj → glm.detail(Quat, Mat3x3, Mat4x4), glm.ext.scalar_constants, glm.ext.vector_relational, glm.detail.common(stub), glm.detail.trigonometric(stub)` 等依赖关系。

---

## 2. 事实错误与逻辑矛盾

### 问题 4：§3.4 Quat×Vec3 运算符实现公式错误

- **位置**：§3.4 运算符体系表第 216 行
- **严重度**：严重
- **问题描述**：设计文档将 `Quat×Vec3` 旋转运算符的实现公式标注为：
  ```
  v + 2.0 * cross(cross(QuatVector, v) + QuatVector * q.w, v)
  ```
  但 GLM 1.0.3 `glm/glm/detail/type_quat.inl:359-366` 的实际实现公式为：
  ```cpp
  vec<3, T, Q> const QuatVector(q.x, q.y, q.z);
  vec<3, T, Q> const uv(glm::cross(QuatVector, v));
  vec<3, T, Q> const uuv(glm::cross(QuatVector, uv));
  return v + ((uv * q.w) + uuv) * static_cast<T>(2);
  ```
  即 `v + (cross(QuatVector, v) * q.w + cross(QuatVector, cross(QuatVector, v))) * 2`，由两次向量叉乘 `uv`、`uuv` 组成。设计文档的公式只包含一次叉乘（最外层），且第二次叉乘的左操作数错误地写成 `(uv + QuatVector * q.w)` 而非 `QuatVector`。两个公式数学上不等价。直接照搬设计公式实现会产生错误的旋转结果。

  此外，公式中的 `cross` 是 `Vec3` 的叉乘（参数均为 Vec3），但设计文档在 §3.7 中将 `cross` 描述为四元数 Hamilton 乘积函数，§3.4 与 §3.7 中的 `cross` 概念混用，容易在编码阶段产生歧义。

- **改进建议**：
  1. 将 §3.4 第 216 行公式修正为 `v + (cross(QuatVector, v) * q.w + cross(QuatVector, cross(QuatVector, v))) * 2`（两次 Vec3 叉乘，调用 `geometric.cj stub` 的向量 `cross`）
  2. 在公式旁明确 `cross` 调用的是 `Vec3` 叉乘（参数为 `Vec3<T,Q>`）而非四元数 `cross`，避免与 §3.7 的四元数 `cross` 概念混淆
  3. 注意 `cross(QuatVector, v)` 依赖 `geometric.cj` 的向量 `cross`（当前为 stub），因此 `Quat×Vec3` 旋转运算符在阶段三可能也需 stub 占位或采用替代实现策略——需在 §3.4 表格备注列明确此依赖

### 问题 5：§3.2 协作关系表与策略段落对 `mat3_cast` 等函数文件归属矛盾

- **位置**：§3.2 协作关系表行 167-170 与 §3.2 策略段落
- **严重度**：严重
- **问题描述**：
  - 协作关系表行 167-170 标注 `mat3_cast`/`mat4_cast`/`quat_cast` 归入「gtc/quaternion.cj（随 type_quat.cj 编码）」
  - 策略段落标注「**随 type_quat.cj 一同实现**：`mat3_cast`/`mat4_cast`/`quat_cast`（type_quat.inl 构造函数依赖）」
  
  两处表述在文件归属上不一致：表行说「gtc/quaternion.cj」，策略段说「type_quat.cj」。加上 §2 包组织未包含 `gtc/quaternion.cj`（见问题 1），三处描述自相矛盾。修复者无法确定这 3 个函数应定义在哪个文件的哪个包名下。
  
  进一步分析：若 `mat3_cast`/`mat4_cast`/`quat_cast` 放在 `type_quat.cj`（`package glm.detail`），则与 GLM 原始归属（`gtc/quaternion.hpp`）不一致，但可避免 gtc 子包依赖 ext/ 函数库的跨子包依赖问题；若放在 `gtc/quaternion.cj`（`package glm.gtc`），则需在 `type_quat.cj` 中通过 `package glm.gtc.mat3Cast(...)` 之类的全限定名调用，会引入跨包依赖。设计文档应明确决策并说明理由。

- **改进建议**：
  1. 明确决策：`mat3_cast`/`mat4_cast`/`quat_cast` 三个函数是定义在 `glm.detail.type_quat`（包级函数）还是 `glm.gtc.quaternion`（包级函数）
  2. 同步修订 §3.2 表行 167-170 与策略段落、§2 包组织图、§8 产出物清单的相应位置
  3. 在 D11 设计决策中补充文件归属决策的完整理由（含跨包依赖权衡）

### 问题 6：§3.2 策略段落对 `eulerAngles`/`roll`/`pitch`/`yaw` 分类逻辑矛盾

- **位置**：§3.2 策略段落最后一项
- **严重度**：一般
- **问题描述**：策略段落标注：
  > **随 gtc/quaternion.cj 实现**：`eulerAngles`/`roll`/`pitch`/`yaw`/`lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual`（不依赖 geometric.cj——roll/pitch/yaw 依赖 common.cj 和 trigonometric.cj 均为 stub，需从 ext/vector_relational 引用 equal 函数）
  
  该标注存在两层逻辑矛盾：
  1. 分类标签「**随 gtc/quaternion.cj 实现**」表明这 8 个函数可在本阶段实现，但紧接其后的「roll/pitch/yaw 依赖 common.cj 和 trigonometric.cj 均为 stub」又表明这些函数依赖未就绪的 stub——若依赖未就绪，本阶段无法完整实现
  2. 实际 GLM `roll()`/`pitch()`/`yaw()` 实现（`gtc/quaternion.inl:15-44`）依赖 `atan`/`asin`/`clamp`/`equal`/`epsilon<T>()`，其中 `atan`/`asin` 来自 `trigonometric.cj`（阶段三 stub），`clamp` 来自 `common.cj`（阶段二 stub）。这些函数在本阶段确实无法完整实现，但设计文档将其归入「实现」类而非「stub 占位」类

  对比 §10 覆盖矩阵（行 688-689），设计文档将 `eulerAngles`/`roll`/`pitch`/`yaw` 标注为「本阶段 stub（依赖 common.cj/trigonometric.cj stub）」，与 §3.2 策略段落的「实现」分类直接矛盾。两处需统一。

- **改进建议**：
  1. 将 §3.2 策略段落的「**随 gtc/quaternion.cj 实现**」改为「**stub 占位（归入 gtc/quaternion.cj）**：`eulerAngles`/`roll`/`pitch`/`yaw`（依赖 trigonometric.cj 的 atan/asin 和 common.cj 的 clamp），随 gtc/quaternion.cj 完整实现的：`lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual`（不依赖 stub）」
  2. 同步修订 §3.2 协作关系表行 168-170 的实现状态标注，与策略段落和 §10 覆盖矩阵对齐

### 问题 7：§3.10 `pow` 函数依赖关系描述不准确

- **位置**：§3.10 第 339 行
- **严重度**：一般
- **问题描述**：设计文档将 `pow(x: Quat<T,Q>, y: T)` 的依赖标注为「`sqrt`/`acos`/`asin`/`sin`/`pow` 和 `epsilon<T>()`」。
  
  实际 GLM `pow` 实现（`ext/quaternion_exponential.inl:24-43`）依赖：
  - `abs`（来自 `common.cj`）
  - `clamp`（来自 `common.cj`）
  - `acos`（来自 `trigonometric.cj`）
  - `sin`/`cos`（来自 `trigonometric.cj`）
  - `sqrt`（来自 `std.math`，仓颉标准库）
  - `epsilon<T>()`（来自 `scalar_constants.cj`）
  
  设计文档错误地列出了 `asin`（实际 GLM pow 不用 `asin`）和 `pow`（递归引用自身，意义不明），同时遗漏了 `abs`/`clamp`/`cos` 三个关键依赖。虽策略层面「本阶段 stub 占位」结论正确，但依赖关系不准确会让编码阶段做依赖分析时困惑。

- **改进建议**：将 §3.10 第 339 行修正为「依赖 `abs`/`clamp`/`acos`/`sin`/`cos`/`sqrt` 和 `epsilon<T>()`」，与 GLM 实际依赖对齐。

### 问题 8：§3.11 `mix` 函数依赖关系遗漏 `epsilon<T>()`

- **位置**：§3.11 第 354 行
- **严重度**：一般
- **问题描述**：设计文档将 `mix(x, y, a): Quat<T,Q>` 的依赖标注为「依赖 `dot`、`acos`、`sin`. **stub 占位**」。
  
  实际 GLM `mix` 实现（`ext/quaternion_common.inl:4-26`）的关键依赖是 `epsilon<T>()`，用于 `cosTheta > 1 - epsilon<T>()` 的退化检测分支。`acos` 和 `sin` 位于非退化分支，依赖上比 `epsilon<T>()` 更次要。设计文档遗漏 `epsilon<T>()` 依赖，导致编码阶段可能误判：`mix` 不仅依赖 `trigonometric.cj stub`（sin/acos），还依赖 `scalar_constants.cj`（已实现）。后者虽是已实现依赖，但应明确列出。

- **改进建议**：将 §3.11 第 354 行修订为「依赖 `dot`、`acos`、`sin`、`epsilon<T>()`。**stub 占位**」。同时 §3.11 `slerp` 描述（第 353 行）的依赖中虽已提到 `acos`/`sin`/`mix`，但同样遗漏了 `epsilon<T>()`，建议同步修订为「依赖 `dot`、`acos`/`sin`/`mix`（标量版）和 `epsilon<T>()`」。

### 问题 9：§3.11 `lerp` 实现策略遗漏断言

- **位置**：§3.11 第 352 行
- **严重度**：轻微
- **问题描述**：设计文档将 `lerp` 列为「**完整实现**（纯算术）」，但实际 GLM `lerp`（`ext/quaternion_common.inl:28-38`）包含两条 `assert` 断言：`assert(a >= 0)` 和 `assert(a <= 1)`，用于确保插值因子在 [0, 1] 范围内。
  
  设计文档在 §3.11 中将 `lerp` 归入「完整实现」类别，意味着不依赖任何 stub。但实现策略完全忽略断言行为——编码阶段若按设计文档「纯算术」实现而不添加断言，会与 GLM 行为产生偏差：超出 [0, 1] 范围的输入会静默产生未定义结果而非触发断言。
  
  此外，根据 deviations.md IF-02（标量-向量运算函数不可在 const 上下文调用），`lerp` 函数本身在 `Number<T>` 约束下不能声明为 `const`，而 GLM 的 `lerp` 标注为 `GLM_CONSTEXPR`——设计文档的「完整实现」标签虽未明确说 `const`，但「纯算术」表述容易让编码者误以为可以声明 `const func`。

- **改进建议**：
  1. 将 §3.11 第 352 行修订为「`lerp(x, y, a): Quat<T,Q>` — `x * (1 - a) + y * a`，含 `assert(a >= 0 && a <= 1)` 断言。**完整实现**（运行时，函数体不可声明为 const，与 deviations.md IF-02 一致）」
  2. 在 §3.11 `lerp`/`conjugate`/`inverse` 三个「完整实现」函数中统一说明「非 const」约束，避免编码阶段误用 const 上下文

### 问题 10：§3.11 `slerp(x, y, a, k)` 4 参数版本签名未指定 `k` 类型

- **位置**：§3.11 第 355 行
- **严重度**：一般
- **问题描述**：设计文档将 `slerp(x, y, a, k)` 标注为「多旋转 slerp。**stub 占位**」，但未指定 `k` 参数的类型。
  
  GLM 1.0.3 4-arg `slerp` 签名为 `template<typename T, typename S, qualifier Q> qua<T, Q> slerp(qua<T, Q> const& x, qua<T, Q> const& y, T a, S k)`，其中 `S` 是独立于 `T` 的整型类型（GLM 通过 `GLM_STATIC_ASSERT(std::numeric_limits<S>::is_integer, ...)` 约束）。设计文档对 `k` 类型未做决策：
  - 选项 A：`k: Int64`（与 deviations.md DV-03「移位运算右操作数固定为 Int64」一致）
  - 选项 B：`k: T`（要求 T 是整型）
  - 选项 C：泛型 `K` + 约束 `K <: Integer<K>`
  
  编码阶段需根据决策编写签名模板。设计文档应明确选择并说明理由。

- **改进建议**：在 §3.11 第 355 行明确 `slerp(x, y, a, k)` 签名为 `slerp<T, K, Q>(x, y, a, k: K) where K <: Integer<K>`（与 GLM 风格一致）或 `slerp<T, Q>(x, y, a, k: Int64)`（简化版），并说明 `k` 类型的选定理由。

### 问题 11：§3.4 `Quat×Vec3`/`Quat×Vec4` 运算符依赖关系未在表中标注

- **位置**：§3.4 运算符体系表第 216-217 行
- **严重度**：一般
- **问题描述**：§3.4 运算符体系表中 `Quat×Vec3` 和 `Quat×Vec4` 行的「备注」列为空，但这两个运算符的实际实现依赖几何函数库：
  - `Quat×Vec3` 依赖向量 `cross`（见问题 4 公式：`cross(QuatVector, v)` 和 `cross(QuatVector, uv)`），该函数在阶段二/三的 `geometric.cj` 中为 **stub**
  - `Quat×Vec4` 通过 `Vec3×Quat` 的中间路径实现（设计公式 `Vec4(q * Vec3(v), v.w)`），间接依赖 `Quat×Vec3`
  
  设计文档将 `Quat×Vec3`/`Quat×Vec4` 运算符与同表的「二元 +」「二元 -」等纯算术运算符并列展示，并要求标注 `@OverflowWrapping`，但未说明这些运算符依赖 `geometric.cj stub`。
  
  关键问题：`geometric.cj` 的向量 `cross` 是 stub，调用 stub 函数会 `throw Exception("stub")`——意味着 `Quat×Vec3`/`Quat×Vec4` 运算符在阶段三不可调用，但设计文档在 §3.4 中将其与基本算术运算符同等对待，编码阶段可能误判为可立即使用的核心功能。
  
  实际上，C++ GLM 的 `Quat×Vec3` 运算符（`type_quat.inl:359-366`）通过 `compute_quat_mul_vec3` 等模板机制调用了 `glm::cross`（即 `func_geometric` 函数库的 `cross`），仓颉版本无法避免此依赖。

- **改进建议**：
  1. 在 §3.4 运算符体系表的 `Quat×Vec3`/`Quat×Vec4` 行「备注」列添加「依赖 `geometric.cj` 向量 `cross`（阶段三 stub），本阶段实现后调用将抛 `Exception("stub")`」说明
  2. 在 §8 产出物清单的「完整实现」中明确「`Quat×Vec3`/`Quat×Vec4` 运算符本阶段实现，但运行时因 `geometric.cj stub` 不可用而抛异常，待阶段四 `geometric.cj` 完整实现后生效」
  3. §4.2 行为契约示例（第 420-422 行）也应标注「本阶段调用将抛异常，待阶段四」

### 问题 12：§3.5 向量 `equal` 函数的容差比较语义与 GLM 不一致

- **位置**：§3.5 第 252-256 行及表格第 264-268 行
- **严重度**：轻微
- **问题描述**：设计文档将向量 `equal` 的容差语义定义为「逐分量 `|x-y| <= epsilon`」。但 GLM 1.0.3 `func_vector_relational.inl:18-22` 的实际定义为「`|x - y| < epsilon`」（严格小于）。
  
  虽然 `<` 和 `<=` 在容差边界值上的差异通常可以忽略（取决于 epsilon 选取），但语义差异会导致边界用例下结果不同：
  - GLM `equal(v, v, 0.0)` = `false`（|0| < 0 不成立）
  - 设计 `equal(v, v, 0.0)` = `true`（|0| <= 0 成立）
  
  若用户期望与 GLM 完全一致的语义（如移植测试用例），需明确选定。

- **改进建议**：在 §3.5 第 252 行明确语义选择：「逐分量 `|x-y| < epsilon`（与 GLM 1.0.3 一致，详见 `references/glm-1.0.3/glm/glm/detail/func_vector_relational.inl:18-22`）」。同时第 254 行 `notEqual` 对应改为「逐分量 `|x-y| >= epsilon`」。

---

## 3. 深度与完整性

### 问题 13：`cross` 函数在 `Quat×Vec3` 公式与四元数 `cross` 函数之间的歧义未充分处理

- **位置**：§3.4 第 216 行（Quat×Vec3 公式）、§3.7 第 299-301 行（cross 命名歧义说明）
- **严重度**：一般
- **问题描述**：设计文档 §3.7 已注意到四元数 `cross`（Hamilton 乘积）与 `Vec3` `cross`（向量叉乘）的命名歧义，并增加了「命名歧义说明」段落。但 §3.4 第 216 行的 `Quat×Vec3` 旋转公式中使用了 `cross(...)` 函数，未明确该 `cross` 调用的是 `Vec3` 叉乘而非四元数 `cross`。
  
  在仓颉代码中（一旦 `geometric.cj` 完整实现），`Vec3` 的 `cross` 函数与 `Quat` 的 `cross` 函数都存在于不同文件，下游消费者看到 `cross(QuatVector, v)` 这样的调用时，必须查阅上下文才能判断是哪种 `cross`。设计文档应统一约定：
  - 是否统一使用 `cross` 名称（依赖类型消歧）
  - 或为 `Vec3` 叉乘使用其他名称（如 `vec3Cross`）避免歧义
  - 或在 `Quat×Vec3` 公式中显式标注 `Vec3.cross(QuatVector, v)` 的调用路径

- **改进建议**：在 §3.4 第 216 行公式旁添加命名约定说明，例如：「注：此处的 `cross` 为 `Vec3` 叉乘（定义于 `geometric.cj`），非 §3.7 中的四元数 `cross`（Hamilton 乘积）。」同时在 §3.7 命名歧义说明段落中补充「`Quat×Vec3` 旋转公式内部调用 `Vec3` 叉乘，与四元数 `cross` 不冲突」的反向说明。

### 问题 14：异常场景与边界条件覆盖不足

- **位置**：§5 错误处理策略
- **严重度**：一般
- **问题描述**：§5 错误处理策略列出 5 条异常/边界行为（下标越界、normalize 零四元数、stub 抛异常、inverse 零四元数除零、标量/四元数 `div` 语义），但未覆盖以下边界条件：
  
  1. **`axis(q)` 在 q 接近零四元数时的行为**：§3.9 标注 `axis(x): Vec3<T,Q>` 为「完整实现」，但实际 GLM 实现是 `return normalize(Vec3(q.x, q.y, q.z))`——`normalize` 在零向量时返回单位向量，文档 §3.7 描述 `normalize(q)` 零四元数行为为「返回单位四元数」；但 `axis` 调用 `normalize` 时返回的是单位 `Vec3` 而非 `Vec3(1,0,0)`——设计文档未明确该边界行为
  2. **`conjugate(q)` 与 `inverse(q)` 对整数四元数的支持**：`conjugate` 仅涉及取反运算，对所有 `Number<T>` 类型可用，但 `inverse = conjugate / dot(q, q)` 中 `dot` 是浮点四元数（`T <: Number<T> & Comparable<T>`），对整数四元数 `dot` 存在但 `div` 在 `Integer<T>` 上不返回浮点结果——设计文档未明确整数四元数 `inverse` 的行为
  3. **`inverse(q)` 零四元数行为**：§5 第 4 条仅说「除以零产生 Inf/NaN 分量」，但仓颉整数除以零的默认行为是抛 `ArithmeticException`（仓颉语义），与浮点除以零行为不同。设计文档未区分整数 vs 浮点零四元数 `inverse` 的行为差异
  4. **`mix`/`slerp` 在 `cosTheta == 0` 时的退化行为**：实际 GLM `mix`/`slerp` 在 `sin(angle)` 接近 0 时存在除零风险，依赖 `cosTheta > 1 - epsilon` 的边界检查。设计文档未提及此边界条件
  5. **`fromMat3`/`fromMat4` 对非纯旋转矩阵的输入行为**：GLM `quat_cast` 对非旋转矩阵产生无意义的四元数（设计文档继承此行为），但设计文档未在 `fromMat3` 工厂函数处声明该限制——下游消费者可能误用
  
  这些边界条件在 §10 覆盖矩阵中也未单列，影响阶段四补齐 stub 时的测试设计。

- **改进建议**：
  1. 在 §5 新增「边界条件与异常场景」小节，逐项列出上述 5 类边界条件的行为契约
  2. 在 §3.9 `axis` 函数描述中补充「零四元数输入时返回 `Vec3(1, 0, 0)`（沿用 `normalize` 零向量行为）」说明
  3. 在 §3.11 `inverse` 描述中补充「整数四元数 `inverse` 在 `dot(q, q) == 0` 时触发仓颉整数除零异常（与浮点 Inf/NaN 行为不同）」说明
  4. 在 §3.3 `fromMat3`/`fromMat4` 工厂函数描述中补充「仅对纯旋转矩阵产生有意义的四元数；对非旋转矩阵（如含缩放/平移/剪切）行为未定义」契约声明

### 问题 15：`@Derive[Hashable]` 在阶段一/二的实践依据未在本设计核验

- **位置**：§3.1 第 149 行
- **严重度**：轻微
- **问题描述**：设计文档将 `Quat<T,Q>` 的 `@Derive[Hashable]` 自动派生列为「职责」之一（行 149），但未说明：
  - 阶段一/二 Vec/Mat 类型是否已使用 `@Derive[Hashable]`
  - Hash 值的相等性约定（`q1 == q2` ⇒ `q1.hash == q2.hash`）
  - `Hashable` 派生对 T 的约束要求（是否要求 `T <: Hashable`）
  - 不同 `Q` Qualifier 的 Quat 是否产生相同 Hash（涉及跨 Qualifier Hash 一致性）
  
  编码阶段按设计文档添加 `@Derive[Hashable]`，但未确认仓颉 `@Derive[Hashable]` 对 `Q <: Qualifier` 的支持情况（仓颉泛型 type parameter 需满足 `Hashable` 才能自动派生）。

- **改进建议**：
  1. 在 §3.1 第 149 行补充 `@Derive[Hashable]` 的约束要求（`T <: Hashable` 和 `Q <: Hashable`，需仓颉泛型 type parameter 派生能力）
  2. 引用阶段一/二实际使用情况（grep `type_vec3.cj` / `type_mat2x2.cj` 等是否有 `@Derive[Hashable]` 标注），确认模式一致性
  3. 在 §8 编码启动前验证项中补充「`@Derive[Hashable]` 对 `Q <: Qualifier` 的支持验证」

### 问题 16：阶段三的 fwd.cj 别名清单需对齐与 §3.14 描述

- **位置**：§3.14 第 401-403 行与 §8.5 第 535 行
- **严重度**：轻微
- **问题描述**：§3.14 描述 fwd.cj 新增别名：
  > `Quat` = `Quat<Float32, PackedHighp>`，`DQuat` = `Quat<Float64, PackedHighp>`，以及精度前缀变体（`HighpQuat`/`MediumpQuat`/`LowpQuat`/`HighpDQuat`/`MediumpDQuat`/`LowpDQuat` 共 6 个）
  
  合计 8 个别名。§8.5 第 535 行说「新增约 8 个四元数类型别名」——数字一致。
  
  但存在以下细节未明确：
  - 阶段一 Vec 别名包含 `BVec`（Bool 类型的 4 种精度的 Vec 别名，4 个精度 × 4 分量数 = 16 个），阶段三是否需要 `BQuat`？
  - 阶段二 Mat 别名包含 Int/UInt 类型（如 `IVec2`），阶段三是否需要 `IQuat`/`I64Quat` 等整型四元数别名？
  - `DQuat` 的命名与阶段二 `DMat2x2` 等一致，命名规范合理；但 `Quat` 与 `Float` 类型的关联不如 `FQuat` 显式——阶段二 Mat 有 `Mat2x2 = Mat2x2<Float32, PackedHighp>` 和 `FMat2x2 = Mat2x2<Float32, PackedHighp>` 的双别名机制，阶段三是否需要 `Quat` 和 `FQuat` 双别名？
  
  阶段一/二 OOD 的处理方式（deviations.md 第 568 行提到「fwd.cj 排除整型四元数别名」与阶段二策略一致）需在设计文档中明确引用。

- **改进建议**：
  1. 在 §3.14 中明确说明 fwd.cj 别名是否包含 Bool 四元数（`BQuat`）和整型四元数（`IQuat`），与阶段一/二决策对齐
  2. 在 §3.14 中说明 `Quat` 与 `FQuat` 双别名机制是否采用（参考阶段二 `Mat2x2`/`FMat2x2` 双别名）
  3. 在差异声明（§9）中确认引用「fwd.cj 排除整型四元数别名，与阶段二排除整型矩阵别名的策略一致」

### 问题 17：ext/ 包策略与 gtc/ 子包构建策略的验证项需对齐 §8 验证项

- **位置**：§8 编码启动前验证项第 1 项与 §2 末尾 cjpm 子包构建预验证段
- **严重度**：轻微
- **问题描述**：§2 末尾（行 132-134）说明 cjpm 子包构建预验证策略与阶段二相同；§8 第 1 项验证项要求验证 `src/gtc/` + `package glm.gtc` 的构建可行性。但若阶段二 ext/ 子包验证结果（v2 设计 §1 沿用阶段二策略）已通过，本阶段 `src/gtc/` 验证是新增需求。设计文档未说明：
  - 阶段二 ext/ 子包验证的最终结果（是否已通过？通过的版本号？）
  - 阶段三 gtc/ 子包验证的预期结果与回退方案（同阶段二：若不支持则降级为 `package glm`）
  
  阶段三还需新增 `src/gtc/` 目录（阶段二无 gtc/），这是 cjpm 构建系统的额外不确定性。

- **改进建议**：
  1. 在 §8 验证项第 1 项明确阶段二 ext/ 子包验证的实际结果（已通过/已通过 cjc 版本号）
  2. 在 §2 末尾补充阶段三 gtc/ 子包与阶段二 ext/ 子包的差异（gtc/ 是新目录、子包发现机制的兼容性需独立验证）
  3. 阶段三若需降级（cjc 不支持 gtc/ 子包），需说明函数迁移到 `src/` 根目录的具体回退方案

### 问题 18：`scalar_constants` 的 `epsilon<T>()` 在 `T = Int*` 类型时的行为未定义

- **位置**：§3.12 第 367-371 行
- **严重度**：一般
- **问题描述**：设计文档将 `epsilon<T>()` 描述为「`func epsilon<T>(): T where T <: Number<T>`」，并通过 `match` 模式匹配对 `Float32`/`Float64` 返回具体 epsilon 值。
  
  但 `Number<T>` 约束下 T 还可以是 `Int8`~`Int64`/`UInt8`~`UInt64` 等整数类型。设计文档对整数类型 T 的 `epsilon<T>()` 返回值未定义：
  - 选项 A：`match` 落到 `case _ => throw Exception("epsilon not defined for integer types")` 或返回 0
  - 选项 B：约束改为 `T <: FloatingPointNumber<T>` 等更窄的约束
  - 选项 C：返回 0（与 GLM `epsilon<int>()` 在某些编译器上的行为一致）
  
  GLM 1.0.3 `scalar_constants.inl:36-43` 的 `epsilon()` 使用 `static_assert(std::numeric_limits<genType>::is_iec559, ...)` 静态断言非浮点类型时编译失败。仓颉版本若不收敛约束，整数类型 T 的 `epsilon<T>()` 行为不一致会影响下游消费者（如 `mix`/`slerp`/`pow` 的 `cosTheta > 1 - epsilon<T>()` 调用）。
  
  类似地，`pi<T>()`/`cos_one_over_two<T>()` 对整数类型的返回值也未定义。

- **改进建议**：
  1. 在 §3.12 第 367-371 行将 `epsilon<T>()`/`pi<T>()`/`cos_one_over_two<T>()` 的约束从 `T <: Number<T>` 收紧为 `T <: Float32 | Float64` 或 `T <: FloatingPointNumber<T>`（若仓颉支持）
  2. 若保持 `T <: Number<T>` 宽约束，在 `match` 中增加 `case _ => throw Exception("epsilon/pi/cos_one_over_two not defined for non-floating-point types")` 显式错误分支
  3. 在 §3.12 段落末尾或 §5 错误处理策略中明确这些函数对非浮点类型的契约

### 问题 19：部分接口边界契约对下游消费者的影响未充分说明

- **位置**：§3.3 构造函数体系、§3.4 运算符体系、§3.7-§3.12 各函数库
- **严重度**：轻微
- **问题描述**：设计文档对接口契约的描述偏向实现视角，对下游消费者（库使用者）的影响说明不足。例如：
  
  1. **`identity(one: T)` 调用必须传 `one: 1.0f` 等字面量**（因为仓颉无 `T(1)` 构造），但文档未提供「调用方必须传字面量 T(1) 的等价物」迁移提示
  2. **跨类型构造 `fromQuat<U, P>(conv, q)`** 要求调用方提供 `(U) -> T` 闭包，文档未提供示例代码展示常见转换模式（如 Float64 ← Float32 的 `conv = { f => Float64(f) }`）
  3. **`Quat×Vec3` 旋转运算符** 在阶段三会抛 `Exception("stub")`（依赖 `geometric.cj` 向量 `cross`），文档未在 §4.2 行为契约示例中标注此限制
  4. **`mix`/`slerp`/`pow`/`eulerAngles` 等 stub 函数** 调用会抛异常，文档未提供「本阶段可用函数 vs 待阶段四函数」对照表，下游消费者可能误用 stub 函数
  5. **`fromQuat` 跨类型构造** 在 `T == U` 同类型场景下也需提供 `conv: (T) -> T` 闭包（如 `conv = { x => x }`），不如 GLM 的 `qua<T,P>(qua<U,P>)` 显式转换构造函数自然——文档未提供此场景的简化建议（如「同类型转换请直接使用 `Quat<T,Q>(q.x, q.y, q.z, q.w)` 构造函数」）

- **改进建议**：
  1. 在 §3.3 构造函数体系的每个工厂函数后追加「调用示例」代码块（特别是 `identity`/`fromQuat`/`fromMat3`/`fromMat4`）
  2. 在 §4 行为契约的所有示例代码块旁标注「本阶段可用 / 本阶段 stub（待阶段四）」
  3. 在 §9 差异声明或新增 §11「下游消费者迁移指南」中提供 `fromQuat`/`identity` 等函数的仓颉调用范式

---

## 4. 整体评价

`a_v1_design_v2.md` 在内部审议循环（v1→v2 修订）后已系统性解决 5 处 v1 审查问题（`lookRotate` 引用、`ext/quaternion_transform.cj` 描述矛盾、`angleAxis` 归类矛盾、D19 决策依据、§3.4 重复声明），设计整体质量较高：模块边界清晰、依赖链分析详尽、stub 占位策略合理、§10 覆盖矩阵可追溯到 GLM 源文件、设计决策表（D01-D19）逐项记录理由。

但本次质量审查发现 v2 设计在以下方面仍存在可改进空间：

1. **结构层面**：`gtc/quaternion.cj` 文件未纳入 §2 包组织与 §8 产出物清单（问题 1），是该文件承载 17 个函数但缺少完整规划的关键遗漏
2. **逻辑一致性**：§3.2 协作关系表与策略段落对 `mat3_cast` 等函数归属矛盾（问题 5）、`eulerAngles`/`roll`/`pitch`/`yaw` 分类矛盾（问题 6）——两处需统一
3. **实现细节**：`Quat×Vec3` 公式错误（问题 4，严重）、`pow`/`mix` 依赖关系遗漏（问题 7/8）、`Quat×Vec3` 运算符依赖 stub 未标注（问题 11）
4. **API 契约完整性**：`slerp` 4 参数版 `k` 类型未定（问题 10）、`lerp` 断言遗漏（问题 9）、`equal` 严格小于 vs 小于等于语义未对齐 GLM（问题 12）、`epsilon<T>()` 对整数类型行为未定义（问题 18）
5. **边界条件覆盖**：§5 错误处理策略对 `axis` 零向量、`inverse` 整数除零、`fromMat3` 非纯旋转矩阵等边界条件覆盖不足（问题 14）
6. **测试规划**：§8 缺少测试文件的完整规划（问题 2）
7. **下游消费者视角**：设计偏向实现视角，对调用方的迁移提示和契约说明不足（问题 19）

修复者需优先解决严重级问题（问题 1、4、5），其他一般级和轻微级问题可在实施阶段逐步落实。整体而言，v2 设计具备可实施基础，但需补充上述遗漏项以确保编码阶段无歧义、无遗漏。
