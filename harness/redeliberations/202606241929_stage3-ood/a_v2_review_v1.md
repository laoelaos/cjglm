# OOD 设计方案审查报告（v1）

## 审查结果

REJECTED

## 逐维度审查

### 1. 类型系统可行性

**[通过]** Quat<T, Q> 泛型结构体定义与仓颉类型系统匹配——`T <: Number<T>` 与 `Q <: Qualifier` 约束均为标准形式，与阶段一 Vec3 (`type_vec3.cj:6-7`) 和阶段二矩阵类型实践一致。`@Derive[Hashable]` 派生约束条件已通过现有 Vec3 实践验证（`type_vec3.cj:6` 已使用 `@Derive[Hashable]`，模式一致）。

**[通过]** 构造函数体系完整覆盖 GLM 习惯——`const init(x, y, z, w)` 主构造函数、`wxyz(w, x, y, z)` 工厂函数、`identity(one)` 工厂函数、`fromQuat<U, P>(conv, q)` 跨类型构造工厂函数均与仓颉语法匹配。`identity` 必须显式传入 `one: T` 参数的策略与 deviations.md DV-01/DV-04 中已记录的「无约束泛型不支持 T(n) 构造调用」一致。

**[通过]** 运算符体系设计合理——所有算术运算符定义在 `Number<T>` 约束的 extend 块中（与阶段一/二一致）；Quat×Vec3/Vec4 公式修订为 `v + (cross(QuatVector, v) * q.w + cross(QuatVector, cross(QuatVector, v))) * 2`（两次 Vec3 叉乘，与 GLM 1.0.3 `type_quat.inl:359-366` 一致）；Vec3×Quat/Vec4×Quat 通过 Vec extend 块成员运算符实现，与阶段二 Mat×Vec 模式对齐；命名歧义通过类型消歧清晰区分（Vec3 cross vs Quat Hamilton）。

**[通过]** `Quat`/`FQuat` 双别名机制（与阶段二 `Mat2x2`/`FMat2x2` 一致）符合类型别名定义语法。

### 2. 标准库与生态覆盖

**[通过]** `std.math.sqrt` 仅支持 Float64 输入/输出的限制已被识别——§3.7 明确「Float32 实例需显式转换（实现阶段明确采用 `T(Float64.sqrt(Float64(dot_qq)))` 路径或额外声明 Float32 重载）」，§8 编码启动前验证项 11 同步列入。

**[通过]** `isNaN()`/`isInf()` 实例方法路径（§3.11）——`std.math` 标准库确实仅提供 `x.isNaN()`/`x.isInf()` 实例方法而非顶层函数（已通过 `.opencode/skills/cangjie-std/math/README.md` 第 114-115 行核实），设计采用 `q.x.isNaN()` 实例方法路径正确。

**[通过]** `@Derive[Hashable]` 与 `@OverflowWrapping` 注解均为标准库机制，前者来自 `std.deriving.*`、后者来自 `std.overflow`，两者均已在阶段一/二实践中验证。

**[通过]** `match (hint) { case _: Float32 => ... case _: Float64 => ... case _ => ... }` 类型模式匹配为标准 Cangjie 模式，与 deviations.md DV-04 `isIec559Of` 实现模式一致。

**[通过]** `ext/vector_relational.cj` 内联 `abs` 策略正确——使用 `let d = x - y; VecN(if (d.x >= T(0)) { d.x } else { -d.x }, ...)` 模式替代依赖 `common.cj` stub，消除运行时依赖风险。

### 3. 语言特性可行性

**[通过]** `const init(x, y, z, w)` 主构造函数——四参数赋值是 const 兼容的简单赋值表达式，编译期可求值。

**[通过]** `lerp` 非 const 设计——§3.11 明确说明 `lerp` 不可声明为 `const func`，因函数体内 `assert(a >= 0 && a <= 1)` 不是 `const` 函数，与 deviations.md IF-03（`componentAt` 不可在 const 上下文使用，理由为 assert 不是 const）一致。§5.4 const 上下文约束段同步说明。

**[通过]** 浮点/整数四元数 `inverse` 零除行为差异——§5.3 边界条件表明确区分浮点（产生 Inf/NaN）与整数（触发仓颉除零异常）行为，与仓颉语言数值语义一致。

**[严重]** **包间循环依赖问题**：设计在 §1「gtc/quaternion.cj 设计决策」段、§2 模块间依赖图、§3.2 协作关系表三处描述了相同的依赖结构——`type_quat.cj` (package `glm.detail`) 通过 `import glm.gtc.quaternion.*` 引用 `mat3Cast`/`mat4Cast`/`quatCast`；同时 `gtc/quaternion.cj` (package `glm.gtc`) 通过 `import glm.detail.*` 引用 `Quat`/`Mat3x3`/`Mat4x4`/`Vec3`。这是 **`glm.detail` 与 `glm.gtc` 之间的双向包依赖（circular package dependency）**。

依据 cangjie-lang-features package/README.md 第 99 行明确规定「不允许循环依赖」，且 cjpm check 命令（第 86 行）会报告循环路径并终止构建。此设计无法在仓颉中实现。

设计在多处错误声称这是「`glm.detail → glm.gtc` 的单向依赖」（§1 第 56 行、§3.2 第 212 行、§3.15 第 510 行），这一表述与实际的依赖图矛盾——`gtc/quaternion.cj` 自身需要 `import glm.detail.*` 引用 `Quat` 类型（§2 第 135 行），构成反向依赖。

设计 §8 编码启动前验证项 2 提及「避免仓颉包间循环依赖检测误报」，但仓颉的循环依赖检测并非「误报」而是硬性语言约束——不会存在误报场景，只会拒绝编译。

**[通过]** stub 函数体采用 `throw Exception("stub")` 占位——与阶段二 geometric.cj、common.cj 等现有 stub 文件的实现模式一致（`geometric.cj:5-15` 等行均为 `throw Exception("stub")`）。

**[通过]** `fwd.cj` 8 个别名定义策略——采用 `public type Quat = Quat<Float32, PackedHighp>` 形式，与 `fwd.cj` 中现有的阶段二 `Mat2x2`/`FMat2x2` 双别名机制模式一致。

### 4. 设计一致性

**[通过]** 整体抽象职责清晰——`Quat<T,Q>` 作为值类型、`ext/*` 提供四元数各类操作扩展、`gtc/*` 提供数学常量和转换函数，三层结构职责分明。

**[一般]** **依赖方向内部矛盾**：§2 模块间依赖图正确呈现了双向依赖关系（`glm.detail.type_quat.cj → glm.gtc.quaternion` 与 `glm.gtc.quaternion.cj → glm.detail`），但 §1「gtc/quaternion.cj 设计决策」段第 56 行、§3.2 协作关系表第 212 行、§3.15 第 510 行三处均错误声称这是「单向依赖」或「无循环依赖」。这一内部矛盾反映出设计者对包依赖结构存在认知偏差——正是这种偏差导致了严重问题 3 的产生。

**[通过]** 协作关系表（§3.2）覆盖完整——包含 Quat×Vec3/Vec4、Vec3/Vec4×Quat、Mat↔Quat 双向转换、`fromMat3`/`fromMat4` 工厂函数路径，闭环完整无缺失环节。

**[通过]** 测试规划（§8.2）覆盖完整——13 个测试文件、≥163 测试用例，按模块拆分，包含构造路径、运算符正常路径、stub 函数异常路径、跨 Qualifier 实例化、跨类型实例化五个维度，浮点比较策略明确，阶段三/四验证边界划分清晰。

**[通过]** 边界条件契约（§5.3）覆盖 8 类边界场景——`axis` 零四元数、`inverse` 浮点/整数零除差异、`mix`/`slerp` cosTheta 退化、`fromMat3`/`fromMat4` 非纯旋转矩阵、`lerp` 断言失败、`equal` epsilon=0、整型 `epsilon<T>()` 抛异常——覆盖全面且与 GLM 行为对齐声明清晰。

**[通过]** GLM 1.0.3 API 阶段覆盖矩阵（§10）——逐一列举各 GLM 头文件下的函数与本阶段覆盖状态，可作为实现完成度的核查清单。

### 5. 设计质量

**[通过]** 单一职责原则——`type_quat.cj` 仅承载 Quat 类型定义与核心运算符；`quaternion_common.cj`/`quaternion_geometric.cj`/`quaternion_trigonometric.cj`/`quaternion_exponential.cj`/`quaternion_transform.cj`/`quaternion_relational.cj` 按功能类别清晰拆分；`gtc/quaternion.cj` 承载 GLM gtc 层特有的转换/比较/欧拉/看向函数。

**[通过]** 抽象层次恰当——三包结构（detail/ext/gtc）层次分明，避免过度设计的同时也未设计不足。

**[通过]** 便于单元测试——§8.2 测试设计明确按模块拆分，13 个测试文件对应 13 个实现文件，stub 函数异常路径可独立验证。

**[通过]** 便于下游消费——§11 下游消费者迁移指南覆盖 4 类常见场景，提供 GLM 与仓颉版本对照示例；§11.4 函数可用性对照表清晰列出 16 个函数的本阶段/阶段四状态。

**[通过]** 模块间依赖图（§2）——除严重问题 3 外，其他跨包依赖方向合理，无隐藏循环（如 `ext` 子包之间的依赖、`gtc` 子包对 `ext`/`detail` 的依赖方向均符合「上层依赖下层」的层级关系）。

## 修改要求（REJECTED 时存在）

### 问题 1（严重）：包间循环依赖——`glm.detail` 与 `glm.gtc` 双向依赖

**问题**：`type_quat.cj` (package `glm.detail`) 通过 `import glm.gtc.quaternion.*` 引用 `mat3Cast`/`mat4Cast`/`quatCast`；同时 `gtc/quaternion.cj` (package `glm.gtc`) 通过 `import glm.detail.*` 引用 `Quat`/`Mat3x3`/`Mat4x4`/`Vec3`。两个包互相导入，形成循环依赖。仓颉语言规范明确禁止包间循环导入（`package/README.md` 第 99 行：「不允许循环依赖」），cjpm 构建系统会拒绝编译。

设计在 §1 第 56 行、§3.2 第 212 行、§3.15 第 510 行三处错误声称这是「单向依赖」或「无循环依赖」。

**原因**：仓颉将包作为最小编译单元，包间循环导入会导致编译顺序无法确定，是语言级别的硬约束，不是「误报」。`type_quat.cj` 中的 `fromMat3`/`fromMat4` 工厂函数需调用 `gtc/quaternion.cj` 中的转换函数，而转换函数本身需要 `Quat`/`Mat3x3`/`Mat4x4` 类型——这种「类型定义」与「类型上的转换函数」分置不同包的结构在 C++ 中可行（头文件包含可双向），但在仓颉包模型下不可行。

**建议方向**（三种可行解法，需选其一）：

1. **将 `mat3Cast`/`mat4Cast`/`quatCast` 下沉到 `glm.detail`**：在 `glm.detail` 中新建 `type_quat_cast.cj`（或合并到 `type_quat.cj`）承载这 4 个转换函数，让 `glm.gtc.quaternion` 通过 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 重导出。此方案保留 GLM 1:1 文件归属的设计意图（gtc 包仍提供 gtc 函数名），同时打破循环依赖。`fromMat3`/`fromMat4` 工厂函数留在 `type_quat.cj` 中直接调用同包函数。

2. **将 `fromMat3`/`fromMat4` 工厂函数从 `type_quat.cj` 中剥离**：将这两个工厂函数移到 `glm.gtc.quaternion` 中作为包级函数（`quaternion.mat3ToQuat(m)` / `quaternion.mat4ToQuat(m)`），让 `type_quat.cj` 不再需要引用 gtc 包。用户使用矩阵-四元数互转时改用 `glm.mat3ToQuat(m)` / `glm.quatToMat3(q)` 形式而非 `Quat.fromMat3(m)` / `mat3Cast(q)`。

3. **重新组织包层级**：将所有 gtc 相关代码（含 `gtc/quaternion.cj`）移至 `glm.detail.gtc` 子包，让 `glm.gtc` 仅作 `public import` 转发层。这样所有「类型」与「类型上的转换函数」均在同一层级包内，不存在跨包循环风险。但此方案改变了阶段三的整体包结构，需相应修订 §2。

推荐方向 1：对 GLM 文件归属的破坏最小（仅实现位置调整，API 命名保持 gtc 风格），同时彻底解决循环依赖问题。需相应更新 §1「gtc/quaternion.cj 设计决策」段落（将 `mat3Cast`/`mat4Cast`/`quatCast` 的实际实现位置标注为 `glm.detail.type_quat_cast.cj`，gtc 包仅做重导出）、§2 依赖方向图、§3.2 协作关系表（明确实现位置在 detail 而非 gtc）。

### 问题 2（一般）：依赖方向内部矛盾

**问题**：§2 模块间依赖图正确呈现 `glm.detail → glm.gtc` 和 `glm.gtc → glm.detail` 双向依赖，但 §1 第 56 行、§3.2 第 212 行、§3.15 第 510 行三处声称这是「单向依赖」或「无循环依赖」，与 §2 矛盾。

**原因**：设计者对包依赖方向的判断与实际依赖图存在偏差，导致后续策略决策（保持当前结构）依据错误前提。

**建议方向**：在采纳问题 1 的修改方案后，重写 §1「gtc/quaternion.cj 设计决策」段、§3.2 第 212 行、§3.15 第 510 行，统一描述新的依赖方向，确保全文表述与最终采用的设计结构一致。设计决策表 D11 也需要根据新方案重写。