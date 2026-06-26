根据以下审查结果，迭代上一轮的产出，形成新版的文件，从而更好地满足用户需求。

## 当前审查结果

本轮诊断共识别 7 项问题（2 项严重 + 4 项一般 + 1 项轻微需自查透明）。其中问题 7 经诊断确认两处描述实际一致，仅格式呈现略不同，**无需修改**，故实际需修复 6 项。

### 严重问题（必须修复，直接影响编码可操作性）

**问题 1（事实错误）**：`fromMat4` 引用阶段二 `fromMat` 列提取模式的描述与项目实际模式不符。§3.3 item 7 声明「**无需 `one: T` 参数**——因为我们构造的是 `Mat3x3` 实例，不是从更小矩阵向上转换」，并以「参考阶段二 `cjglm/src/detail/type_mat2x2.cj:163-165` 中 `Mat2x2.fromMat(Mat3x3, one)` 的列提取模式」作为论据。但实际阶段二所有 9 个矩阵类型的 `fromMat` 重载**全部携带 `one: T` 参数**——无论构造目标矩阵的尺寸与源矩阵的大小关系。**实际项目模式**：只有「同维度构造」才省略 `one: T`，「跨维度构造」一律要求 `one: T`。该描述存在两个内部矛盾：(a)「参考阶段二 type_mat2x2.cj:163-165 列提取模式」与「无需 one: T 参数」语义不一致——被引用的代码本身就要求 `one: T`；(b) 与 §1「系统性设计约束」中「**T(1) 的获取**：必须由调用方显式传入参数（`one: T`）」的系统性约束不一致。

**问题 2（事实错误）**：`mat3Cast`/`mat4Cast` T(1) 获取策略缺失，与 §1 系统性约束冲突。GLM `gtc/quaternion.inl:49` 实际使用 `Mat3x3(T(1))` 初始化 3×3 单位矩阵（即 `Result = identity`），强依赖 T(1) 字面量。但 §3.2.1 中 `mat3Cast<T, Q>(q: Quat<T, Q>): Mat3x3<T, Q>` 签名模板未提及 T(1) 获取方式；§1 受约束函数清单遗漏 `mat3Cast`/`mat4Cast`；§3.4 `Quat×Vec3`/`Quat×Vec4` 等使用 `T(Float64(2))` 字面量的运算符也未列出。下游编码者按设计签名实现时需自行决策引入 `one: T` 参数或使用 `T(Float64(1))` 字面量，可能产生实现分歧。

### 一般问题（关键遗漏，影响完整性和可操作性）

**问题 3**：`ext/vector_relational.cj` GLM 文件引用错误（行号与文件名均错误）。§3.5 描述「向量 `equal`/`notEqual` epsilon 版本采用严格 `<` 语义，与 GLM 1.0.3 `func_vector_relational.inl:18-22` 一致」，但 GLM 1.0.3 的 `func_vector_relational.inl` 中**根本不包含 epsilon 版本**的 `equal`/`notEqual`——epsilon 版本位于 `glm/gtc/epsilon.inl`（文件层面属 gtc 子包）。同时引用偏差涉及 §3.5（§3.5 表格）、D24 设计决策、§9 差异声明、§10 覆盖矩阵 4 处。

**问题 4**：`lib.cj` 新增 import 清单不完整（遗漏 5+ 个新模块的 stub/别名文件）。§2「**lib.cj 新增 import 清单（v5 明确）**」列出 8 个 import 声明，但对照 §2 包组织图中新增的 16 个文件，遗漏：`ext/quaternion_transform.cj`、`ext/quaternion_exponential.cj`、`ext/quaternion_trigonometric.cj`、`detail/trigonometric.cj`、`gtc/quaternion.cj`、`gtc/matrix_transform.cj`、`ext/quaternion_float.cj`、`ext/quaternion_double.cj`、`ext/quaternion_float_precision.cj`、`ext/quaternion_double_precision.cj`、`ext/matrix_projection.cj`、`ext/matrix_clip_space.cj`、`ext/matrix_transform.cj` 等模块的 import。

### 轻微问题（表述不严谨或需补充说明）

**问题 5**：§3.4 「交换律别名」解释中 `Number<T>` 语义描述不准确。原文称「`Quat×T` 运算符已通过 `Number<T>` 约束交换律覆盖（仓颉 `Number<T>` 加法/乘法具备交换律语义）」，但 `Number<T>` 接口本身**不提供交换律语义**——仓颉运算符重载中左操作数类型决定 operator 函数归属，`T * Quat` 的 `T` 在左操作数位置时无法定义为 Quat 的成员运算符，必须通过 `scalar_quat_ops.cj` 的全局函数实现。

**问题 6**：§11.5 gtc 重导出行的 `where T <: FloatingPoint<T>` 约束归属描述不清。§11.5 `mat3_cast`/`mat4_cast`/`quat_cast`（gtc，重导出）行标注「**约束：`where T <: FloatingPoint<T>`（D32）**」，但 D32 实际针对 `detail/type_quat_cast.cj` 的原始定义函数。gtc 命名空间下的同名函数是通过 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 重导出，约束应在重导出端自动继承——下游消费者看到 gtc 端约束时可能误以为 D32 在 gtc 端独立定义。

**问题 7**（自查透明，无需修改）：§8「产出物清单」中 `gtc/quaternion.cj` 行数量描述与 §3.2 协作关系表存在视觉呈现差异（实际无矛盾）。

## 历史迭代回顾

### 已解决的问题（出现在历史反馈但当前反馈中不再提及）

以下问题在第 1-3 轮反馈中出现，经多轮迭代已修复，本轮不再涉及：

- **文件归属与依赖方向**：第 1 轮问题 1（`gtc/quaternion.cj` 包组织图缺失）、问题 3（协作关系表与策略段落矛盾）、问题 5（依赖图缺失）、问题 6（slerp stub 矛盾）—— 已通过 v3 决策下沉 `type_quat_cast.cj` 至 detail 包并明确单向依赖方向解决
- **公式与依赖准确性**：第 1 轮问题 2（`Quat×Vec3` 公式错误）、问题 7（pow 依赖错误）、问题 8（mix/slerp 依赖遗漏）、问题 9（slerp 4 参数 k 类型）、问题 10（Quat×Vec3 备注缺失）、问题 11（cross 命名歧义）—— 已通过 v3-v8 迭代逐步修正
- **边界行为契约**：第 1 轮问题 12（边界条件未覆盖）、第 2 轮问题 1/6（axis 描述矛盾）、第 3 轮问题 8（fromVec3 边界行为）、第 3 轮问题 9（mat3Cast/mat4Cast 边界行为）—— 已通过 v8 边界行为契约段落补齐
- **函数签名与依赖**：第 2 轮问题 2（pow 依赖不完整）、问题 3/4/5（log/exp/slerp 依赖）、问题 9（conjugate 描述错误）、问题 10（type_quat_cast 签名未定义）、问题 12/13（pow 命名消歧、mix acos/sin 重载）—— 已通过 v3-v7 修订完善
- **gtc/constants 函数数量**：第 3 轮问题 1（25 vs 28 数量矛盾）—— 已修订为 28
- **FMat2x2 先例引用**：第 3 轮问题 4（Vec 家族先例模式）—— 已修订为先例为 Vec 家族 `FVec*` 模式
- **测试设计**：第 1 轮问题 4（测试设计缺失）、第 3 轮问题 5（test_xxx 命名）、第 3 轮问题 10（用例数比例）、第 3 轮问题 11（isnan/isinf where 子句）—— 已通过 §8.2 测试设计补齐
- **系统性约束**：第 2 轮问题 7（路线图差异）、第 2 轮问题 8（gtc/quaternion.cj 表格矛盾）、第 2 轮问题 14（@Derive[Hashable] 验证）、第 3 轮问题 6（trigonometric.cj 标量/向量）、第 3 轮问题 7（Float32 sqrt 策略）—— 已通过 v8 系统性约束段落补齐
- **lib.cj/fwd.cj 清单**：第 2 轮问题 11（清单未明确）—— 已通过 v5 明确 8 个 import 与 8 个 type alias

### 持续存在的问题（在多轮反馈中反复出现，需重点解决）

本轮诊断中**问题 1（`fromMat4` 模式引用）** 与**问题 2（`mat3Cast` T(1) 策略）** 与第 3 轮诊断存在延续关系：

- **问题 1 延续**：第 3 轮问题 3 已识别「`fromMat4` 降维策略两可（手动提取 vs GLM 策略转换）」，v8 已选择手动提取策略但论据引用错误——被引用的 `type_mat2x2.cj:163-165` 代码本身就要求 `one: T`，与「无需 `one` 参数」自相矛盾。本轮深入到「引用代码本身的准确性」，需重新审视策略选择并修正描述。
- **问题 2 延续**：第 3 轮问题 9 已识别「`mat3Cast`/`mat4Cast` 接受非单位四元数时返回矩阵行为未定义」，v8 已补充边界行为契约但 T(1) 字面量获取方式仍缺失。本轮深入到「具体 T(1) 获取路径与 §1 系统性约束闭环」，需明确实现策略。

此外**问题 4（lib.cj import 清单）**与第 2 轮问题 11「具体清单未明确」存在延续：本轮深入到「对照包组织图新增 16 个文件，列举遗漏的 7+ 个 import」。

### 新发现的问题（本轮新识别）

- **问题 3**：`ext/vector_relational.cj` GLM 文件引用错误——`func_vector_relational.inl:18-22` 实际为 `lessThanEqual`，epsilon 版本位于 `glm/gtc/epsilon.inl:32-41`（`epsilonEqual`）与 `55-59`（`epsilonNotEqual`）。涉及 §3.5、D24、§9、§10 共 4 处引用偏差。
- **问题 5**：§3.4 `Number<T>` 语义描述不准确——`Number<T>` 接口本身不提供交换律语义，`T * Quat` 的 `T` 在左操作数位置时必须通过 `scalar_quat_ops.cj` 全局函数实现。
- **问题 6**：§11.5 gtc 重导出行约束归属不清——`where T <: FloatingPoint<T>` 应在重导出端自动继承自 detail 端实现，需追加「（约束继承自 detail 端实现，通过 public import 透明传递）」。

## 上一轮产出路径

C:/Develop/Software/cjglm_wp/harness/redeliberations/202606241929_stage3-ood/a_v4_copy_from_v3.md

## 用户需求

C:/Develop/Software/cjglm_wp/harness/redeliberations/202606241929_stage3-ood/requirement.md

---

**编辑模式**：COPY_AND_EDIT（上一轮产出 1421 行，超过 1000 行阈值，组件 A 内部先复制 `a_v4_copy_from_v3.md` 为 `a_v5.md`，再按本指令定向修改）。