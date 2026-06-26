# 再审议判定报告（v4）

## 判定结果

RETRY

## 判定理由

组件B的诊断报告共识别出 7 项问题，其中：
- **严重问题 2 项**：问题 1（`fromMat4` 引用阶段二 `fromMat` 列提取模式的描述与项目实际模式不符，属于事实错误）、问题 2（`mat3Cast`/`mat4Cast` T(1) 获取策略缺失，与 §1 系统性约束冲突）；
- **一般问题 2 项**：问题 3（`ext/vector_relational.cj` GLM 文件引用错误，行号与文件名均错误）、问题 4（`lib.cj` 新增 import 清单不完整，遗漏 5+ 个新模块）；
- **轻微问题 3 项**：问题 5-7。

组件B的质询报告结论为 **LOCATED**，即审查报告被确认成立。质询从证据充分性、逻辑完整性、覆盖完备性三个维度对诊断报告进行复核：
- 所有 7 项问题的证据链均通过验证（具体文件路径、行号、代码片段可追溯）；
- 问题间无矛盾，改进建议与诊断结论对齐，严重程度与证据强度匹配；
- 任务要求的各审查维度（需求响应充分度、整体深度和完整性、可直接指导编码实现、接口定义是否足以支持下游消费者、异常场景和边界条件）已充分覆盖。

根据判定标准，审查报告包含严重或一般等级的问题即应判定为 RETRY。本次审查存在 2 项严重问题和 2 项一般问题，严重问题直接影响编码可操作性（不修正会直接阻塞编码或导致错误实现），一般问题影响产出完整度，因此判定为 **RETRY**，需要重新运行组件A以修复上述问题。

此外，内部循环实际轮次 1 < 最大轮次 12，循环提前终止，质询结论为 LOCATED，表明审查意见已经过确认，无须继续内部循环。

## 需要解决的问题

- **问题描述**：`fromMat4` 引用阶段二 `fromMat` 列提取模式的描述与项目实际模式不符。§3.3 item 7 声明「无需 `one: T` 参数」并以 `type_mat2x2.cj:163-165` 中「Mat2x2.fromMat(Mat3x3, one)」为论据，但该被引用代码本身要求 `one: T`；实际项目模式为「同维度构造才省略 `one: T`，跨维度构造一律要求 `one: T`」。同时与 §1「T(1) 必须由调用方显式传入」的系统性约束存在内部矛盾。
- **所在位置**：§3.3 item 7（约第 326 行）
- **严重程度**：严重
- **改进建议**：重新审视 `fromMat4` 的实现路径。建议路径 A（与 GLM `gtc/quaternion.inl:128` 一致）：签名改为 `fromMat4(m: Mat4x4<T, Q>, one: T): Quat<T, Q>`，内部直接提取 9 分量（不构造中间 Mat3x3），与阶段二 `fromMat` 系列签名风格一致。同时同步在 §3.3 item 6（`fromMat3`）明确相同的 `one: T` 处理策略，保持描述对齐。

- **问题描述**：`mat3Cast`/`mat4Cast` T(1) 获取策略缺失，与 §1 系统性约束冲突。GLM `gtc/quaternion.inl:49` 实际使用 `Mat3x3(T(1))` 初始化单位矩阵，但设计 §3.2.1 中 `mat3Cast`/`mat4Cast`/`quatCast` 签名模板未提及 T(1) 获取方式，且 §1 受约束函数清单未包含这三个函数，下游编码者需自行决策引入 `one: T` 参数或使用 `T(Float64(1))` 字面量，可能产生实现分歧。
- **所在位置**：§3.2.1（type_quat_cast 函数签名规范）、§1（系统性设计约束）
- **严重程度**：严重
- **改进建议**：在 §3.2.1 `mat3Cast`/`mat4Cast` 签名后追加「**实现策略（v8 补强）**：内部 `Mat3x3(T(Float64(1)))` 初始化对角线，按 GLM `gtc/quaternion.inl:49-71` 公式逐项修改。T(1) 通过 §1「Float64(1) 字面量替代策略」获取，无需 `one: T` 形参污染函数签名」。同时 §1 受约束函数清单补充 `mat3Cast`/`mat4Cast`/`Quat×Vec3`/`Quat×Vec4` 等所有使用 T(1) 或 T(2) 字面量的函数，确保约束引用闭环。

- **问题描述**：`ext/vector_relational.cj` GLM 文件引用错误，行号与文件名均错误。§3.5 描述「向量 `equal`/`notEqual` epsilon 版本采用严格 `<` 语义，与 GLM 1.0.3 `func_vector_relational.inl:18-22` 一致」，但 GLM 1.0.3 的 `func_vector_relational.inl` 中根本不包含 epsilon 版本，epsilon 版本实际位于 `glm/gtc/epsilon.inl:32-41`（`epsilonEqual`）与 `55-59`（`epsilonNotEqual`）。
- **所在位置**：§3.5（第 388 行）、D24 设计决策（第 812 行）、§9 差异声明（第 972 行）、§10 覆盖矩阵（第 1030-1033 行）
- **严重程度**：一般
- **改进建议**：将 4 处文件/行号引用统一修正为 `gtc/epsilon.inl:32-41`（`epsilonEqual` 严格 `<` 语义）。§9 差异声明新增「向量 `equal`/`notEqual` epsilon 版本放置于 ext/ 层而非 gtc 层，与 GLM `glm/gtc/epsilon.hpp` 文件归属不一致」并说明本阶段架构选择理由。§3.5 表格补充 `notEqual`（epsilon 版本）的 `>=` 互补语义说明（与 `gtc/epsilon.inl:55-59` 一致）。

- **问题描述**：`lib.cj` 新增 import 清单不完整。§2「lib.cj 新增 import 清单」列出 8 个 import 声明，对照 §2 包组织图中新增的 16 个文件，遗漏 `ext/quaternion_transform.cj`、`ext/quaternion_exponential.cj`、`ext/quaternion_trigonometric.cj`、`detail/trigonometric.cj`、`gtc/quaternion.cj`、`gtc/matrix_transform.cj`、4 个四元数别名文件（`quaternion_float.cj`/`quaternion_double.cj`/`quaternion_float_precision.cj`/`quaternion_double_precision.cj`）、3 个矩阵新增空桩（`matrix_projection.cj`/`matrix_clip_space.cj`/`matrix_transform.cj`）等模块的 import。
- **所在位置**：§2 lib.cj import 清单段（第 102-110 行）
- **严重程度**：一般
- **改进建议**：§2 lib.cj 新增 import 清单扩充至完整 15-16 个 import 声明，覆盖所有 ext/、detail/、gtc/ 新增文件。对 stub 文件的 import 策略明确说明（建议采用 `public import` 让 stub 函数也可通过命名空间调用，便于测试 stub 异常路径），并同步修订 §8 更新文件段 lib.cj 描述。

- **问题描述**：§3.4「交换律别名」解释中 `Number<T>` 语义描述不准确。原文称「`Quat×T` 运算符已通过 `Number<T>` 约束交换律覆盖」，但 `Number<T>` 接口本身不提供交换律语义，仓颉运算符重载中左操作数类型决定 operator 函数归属，`T * Quat` 的 `T` 在左操作数位置时无法定义为 Quat 的成员运算符，必须通过 `scalar_quat_ops.cj` 的全局函数实现。
- **所在位置**：§3.4 全局具名函数表后说明（第 375 行）
- **严重程度**：轻微
- **改进建议**：将「`Number<T>` 约束交换律覆盖」修订为「通过 `scalar_quat_ops.cj` 全局具名函数提供 `T * Quat` 等标量左侧运算（与阶段二 `scalar_mat_ops.cj` 模式一致）；仓颉 operator func 限制——左操作数类型非 Quat 时不能定义为 Quat 成员运算符，必须通过全局函数实现（依据 D05 决策）」。保持原有「无需单独交换律别名函数」的结论不变。

- **问题描述**：§11.5 gtc 重导出行的 `where T <: FloatingPoint<T>` 约束归属描述不清。§11.5 标注「**约束：`where T <: FloatingPoint<T>`（D32）**」，但 D32 实际针对 `detail/type_quat_cast.cj` 的原始定义函数，gtc 端通过 public import 重导出后约束应自动继承，下游消费者可能误以为 D32 在 gtc 端独立定义。
- **所在位置**：§11.5（第 1202 行）
- **严重程度**：轻微
- **改进建议**：在 gtc 重导出行的约束标注后追加「（约束继承自 detail 端实现，通过 public import 透明传递）」，避免下游误读为 gtc 端独立约束定义。

- **问题描述**：§8「产出物清单」中 `gtc/quaternion.cj` 行数量描述与 §3.2 协作关系表存在视觉呈现差异（实际无矛盾）。
- **所在位置**：§8 第 840 行、§3.2 第 250-253 行
- **严重程度**：轻微
- **改进建议**：无需修改——两处描述实际一致，仅格式呈现略不同。
