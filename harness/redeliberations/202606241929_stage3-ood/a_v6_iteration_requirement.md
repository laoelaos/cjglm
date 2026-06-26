根据以下审查结果，迭代上一轮的产出，形成新版的文件，从而更好地满足用户需求。

## 当前审查结果

组件B诊断报告（`b_v5_diag_v1.md`）针对 v9 设计（`a_v5_copy_from_v4.md`，1489 行）从需求响应充分度、整体深度与完整性、设计可落地性维度识别出 17 项质量问题（3 严重 + 13 一般 + 1 轻微），质询报告（`b_v5_challenge_v1.md`）已 LOCATED 通过。

### 一、事实错误类（严重，3 项必须修复）

**问题 1（严重）**：§3.10、D21、§8 编码启动前验证项 16/18 多次引用 `FloatingPoint<T>.getMin()` 和 `FloatingPoint<T>.getInf()` 实例方法作为「主策略」。但 `cangjie-std/math/README.md` 第 111-115 行明确仓颉 stdlib 不存在这两个方法，仅存在 `Float64.Inf`/`Float64.Min`/`Float64.Max`/`Float64.NaN` 等静态常量。`FloatingPoint<T>` 接口本身仅作为类型约束被声明，无任何实例方法。验证项 16/18 的「主验证目标」100% 不存在。
- 所在位置：§3.10（约第 496-497 行）、D21 设计决策（约第 830 行）、§8 编码启动前验证项 16（第 968 行）、§8 编码启动前验证项 18（第 970 行）
- 改进建议：§3.10 `pow`/`log` 依赖修订为「通过类型分派 `if (q.x is Float32) { Float32.Min } else { Float64.Min }` 或运行时 fallback `T(1)/T(0)` 显式构造」，并明确「仓颉 stdlib 不提供 `getMin()`/`getInf()` 实例方法，仅提供 `Float64.Inf`/`Float64.Min`/`Float64.Max` 等静态常量」；D21 决策依据同步修订；§8 验证项 16/18 修订为「验证类型分派路径 + 字面量 fallback 路径的编译可行性」。

**问题 2（严重）**：fwd.cj 四元数别名计数自相矛盾（声称 8，实际 9）。§3.14、§2 lib.cj/fwd.cj 段落、§8 更新文件段多处声称新增「8 个别名」并明确列出 `Quat`/`FQuat`/`DQuat` + 3×Float32 精度 + 3×Float64 精度 = **9 个**别名，算术 3+3+3=9 与汇总数字 8 直接矛盾。
- 所在位置：§3.14（约第 609 行、第 614 行）、§2 lib.cj/fwd.cj 段落（约第 138 行）
- 改进建议：§3.14 / §2 三处「合计 8 个别名」统一修订为「合计 9 个别名」；§2 lib.cj/fwd.cj 段「v5 修正」附注修订为「完整应为 Quat/FQuat/DQuat + 3×Float32 精度 + 3×Float64 精度 = 9 个」。

**问题 3（严重）**：§3.10 「命名消歧（v5 新增）」段声明「四元数 `pow` 函数体内部调用的 `pow(x.w, y)` 是实数版本 `std.math.pow(T, T): T`」。但 `cangjie-std/math/README.md` 第 13 行明确 `std.math.pow` 实际签名为 `pow(base: Float64, exponent: Float64): Float64`，不是泛型 `pow(T, T): T`。下游按设计字面实现时：当 T=Float64 时签名不一致（返回 Float64 而非 T）；当 T=Float32 时直接编译失败。「命名消歧」段与「Float64 转换依赖」段描述不一致。
- 所在位置：§3.10 「命名消歧（v5 新增）」段与「Float64 转换依赖（v7 澄清）」段（约第 497 行附近）
- 改进建议：§3.10 「命名消歧」段将「`std.math.pow(T, T): T`」修订为「`std.math.pow(Float64, Float64): Float64`（仅支持 Float64 输入）」；与「Float64 转换依赖」段统一，明确下游实现路径为 `Float64(std.math.pow(Float64(x.w), Float64(y)))` 或 fallback `Float64(std.math.exp(Float64(y) * std.math.log(Float64(x.w))))`，最终结果通过 `T(...)` 转换回目标类型；§8 验证项 15 同步修订。

### 二、关键遗漏类（一般，10 项）

**问题 4（一般）**：未识别与阶段二已有 `epsilonOf<T>(hint)` 函数的命名冲突与冗余设计。`cjglm/src/detail/shim_limits.cj:25` 已存在同名语义的 `public func epsilonOf<T>(hint: T): T`，且 `compute_vector_relational.cj:17` 已使用。设计 §3.12 新增 `func epsilon<T>(): T` 未说明两函数等价性、返回值一致性、阶段二测试硬编码值未做交叉验证。
- 所在位置：§3.12 ext/scalar_constants.cj（约第 523-530 行）
- 改进建议：§3.12 段落新增「与 `shim_limits.cj:25` `epsilonOf<T>(hint)` 关系」子节，明确 (a) 两函数功能等价，无业务新增；(b) 两者返回值需严格一致；(c) 阶段二测试硬编码值作为 ground truth；编码启动前验证项新增「验证 `epsilon<T>()` 与 `epsilonOf<T>(hint)` 在 T=Float32/Float64/Int64 下的返回值一致性」。

**问题 5（一般）**：§3.13.1 `VecN<T,Q>` 占位符未映射到仓颉实际类型展开模式。仓颉项目不存在 `VecN` 泛型占位类型——实际模式是 `compute_vec_add1`/`add2`/`add3`/`add4` 四个独立 struct。下游按设计实现 trigonometric.cj 时，「30 个函数」实际需展开为 14 单参数 × (1 标量 + 4 Vec 重载) + 1 双参数 × (1 标量 + 4 Vec 重载) = 75 个签名，设计未说明此展开规则。
- 所在位置：§3.13.1（约第 553-580 行）
- 改进建议：§3.13.1 表头新增说明「`VecN<T, Q>` 是占位符，实际展开为 `Vec1<T, Q>`/`Vec2<T, Q>`/`Vec3<T, Q>`/`Vec4<T, Q>` 4 个独立重载，命名沿用 `cjglm/src/detail/compute_vector_decl.cj` 的 `compute_vec_xxx1/2/3/4` 模式」；函数总数重新核算实际函数数量。

**问题 6（一般）**：§5.4 const 约束声明与 §3.11 函数体描述存在内部矛盾。§5.4 声明「`lerp`/`conjugate`/`inverse` 不可在 const 上下文调用」，但 §3.11 `conjugate(q)` 描述函数体内仅对 x/y/z 三个分量取反，无 assert/throw/运行时副作用，实际可在 const 上下文调用。`inverse` 因依赖 `/` 运算符在 T=Integer 时可抛 ArithmeticException，确实不能在 const 上下文调用。
- 所在位置：§5.4 const 上下文约束（约第 789-792 行）、§3.11 `conjugate` 描述（约第 508 行）
- 改进建议：§5.4 修订为「`lerp`/`inverse` 不可在 const 上下文调用」，移除 `conjugate`；§5.4 补充 `inverse` 的 const 拒绝理由：「依赖 `/` 运算符，整数 T 在 `dot(q,q) == 0` 时触发 `ArithmeticException`，非 const 函数」；§3.11 `conjugate` 描述末尾新增「可声明为 `const func`（与 Vec/Mat 的逐分量运算符策略一致）」，并加注「若仓颉 const 函数还有其他限制（如不能调用非 const 自由函数），则该论断需进一步评估」。

**问题 7（一般）**：§3.13.1 trigonometric.cj 中 `radians`/`degrees` 函数实现路径未明确（π 字面量 vs `pi<T>()`），且 stage 3 实际是 stub，依赖 stage 4 才落地。质询建议该问题可降为轻微。
- 所在位置：§3.13.1 表（约第 573-574 行）
- 改进建议：§3.13.1 `radians`/`degrees` 行「内部依赖」列补充明确：「硬编码 π 字面量 `Float64(3.141592653589793)`，无 std.math 依赖，无 `scalar_constants` 依赖」；或补充依赖关系并同步 §2 模块间依赖图。

**问题 8（一般）**：§8.2 测试文件结构 `tests/glm/ext/` 与现有项目惯例 `tests/glm/test_ext.cj`（单一聚合文件）不一致。实际 `tests/glm/ext/` 目录不存在，阶段二 25 个测试文件均位于 `tests/glm/detail/`。设计引入 `tests/glm/ext/` 与 `tests/glm/gtc/` 是新建目录结构，但未说明与既有 `test_ext.cj` 的关系及迁移策略。
- 所在位置：§8.2 测试文件清单与位置表（约第 894-913 行）
- 改进建议：§8.2 测试设计新增「测试目录结构对齐策略」段，明确 (a) `tests/glm/ext/` 为新增目录（项目当前无此目录先例），下游需先 `mkdir -p`；(b) 既有 `tests/glm/test_ext.cj` 保留为 ext 别名兼容测试，新增的 `tests/glm/ext/test_xxx.cj` 为逐函数单元测试，二者并存；(c) `tests/glm/gtc/` 同样为新增目录，与 `src/gtc/` 子目录结构对齐；或修订为 `tests/glm/test_ext_xxx.cj` 命名以避免新建子目录。

**问题 9（一般）**：§2 模块间依赖图中 gtc/quaternion.cj 对 Mat3x3/Mat4x4/Vec3 的依赖声明过宽。逐项核查 15 个函数：4 个比较函数仅依赖 Quat；3 个 quatLookAt 函数仅依赖 Vec3，不依赖 Mat 类型。设计将依赖声明扩展至全部 Mat/Vec 类型。
- 所在位置：§2 模块间依赖图（约第 198 行）、§3.2.1 与 §3.15
- 改进建议：§2 模块间依赖图 `glm.gtc` 块修订为分段声明：`比较函数仅依赖 Quat；转换函数重导出 detail 的 Mat3x3/Mat4x4；欧拉/看向 stub 依赖 Vec3`。

**问题 10（一般）**：§3.13.1 trigonometric.cj 受 Float32 与 std.math 交互约束影响的函数清单遗漏 trigonometric.cj 自身。trigonometric.cj 实现的 14 个标量函数本身调用 `std.math.sin`/`cos`/`tan` 等 Float64-only 函数，下游实现时需对每个函数应用 `T(Float64.xxx(Float64(value)))` 转换模式。表行内容未充分映射此约束对每个函数的影响。
- 所在位置：§3.13.1 三角函数表（约第 559-580 行）
- 改进建议：§3.13.1 表头说明强化：「**所有 `std.math.*` 函数仅支持 Float64 输入/输出（依据 `cangjie-std/math/README.md` 第 13 行），所有 trigonometric.cj 函数在 T=Float32 实例化时需应用 `T(Float64.xxx(Float64(value)))` 转换模式**」；表行「内部依赖」列统一标注「`std.math.{func}`（仅 Float64，Float32 实例化需显式转换）」。

**问题 11（一般）**：§3.9 `axis` 函数公式中冗余的 `Float64(...)` 包装层。`tmp2 = T(Float64(1)) / T(Float64(std.math.sqrt(Float64(tmp1))))`，其中 `Float64(std.math.sqrt(...))` 等价于 `Float64(Float64)`（冗余但合法）。质询建议可降为轻微，属纯风格问题。
- 所在位置：§3.9 `axis` 函数描述（约第 482 行）
- 改进建议：§3.9 公式修订为 `tmp2 = T(Float64(1)) / T(std.math.sqrt(Float64(tmp1)))`，删除冗余的 `Float64(...)` 包装；在公式旁新增「`std.math.sqrt` 已是 Float64 输入/输出，仅需一次 `T(Float64(…))` 转换回目标类型 T」解读注释。

**问题 12（一般）**：§1 与 §3.10 对 `pow` 函数「Float64 转换依赖」段引用位置不一致。§1 通用约束已说明 pow 需 Float64 转换，§3.10 又单设「Float64 转换依赖（v7 澄清）」子段，二者功能重叠。
- 所在位置：§1 通用约束段（约第 54-63 行）、§3.10 `pow` 描述（约第 497 行）
- 改进建议：§3.10 `pow` 「Float64 转换依赖」段精简为「`pow(Quat<Float32, Q>, Float32)` 实现路径遵循 §1 通用约束，应用 `T(Float64.std.math.pow(...))` 转换模式」，删除与 §1 重复的展开说明；或将两段并入「命名消歧与 Float64 转换」单一小节。

**问题 13（一般）**：§3.11 inverse 描述与 §5.3 边界条件表对整数 inverse 行为契约措辞不一致。虽两处描述本质一致，但 §5.3 表的「`axis(q)` 零四元数」行措辞（`\|w\| >= 1`）与 §3.9 `axis` 描述（`tmp1 <= 0`）虽等价但措辞略不同，且 §5.3 表未说明 `tmp1 = T(1) - w*w` 的计算公式。
- 所在位置：§3.11 inverse 描述（约第 509 行）、§5.3 边界条件表（约第 773-776 行）
- 改进建议：§5.3 边界条件表「`axis(q)` 零四元数」行补充「`tmp1 = T(1) - x.w*x.w`（参见 §3.9 公式）」明确公式引用；§5.3 表的「整数 `inverse`」行措辞与 §3.11 inverse 描述统一为「触发仓颉 `ArithmeticException`」。

### 三、内部矛盾类

（与问题 12、13 合并归类，已在关键遗漏类中详述）

### 四、深度完整性类

**问题 14（一般）**：与问题 1 同源，§8 编码启动前验证项 16/18 验证目标不存在的 API，导致实际验证项无法独立完成。
- 所在位置：§8 编码启动前验证项 16（约第 968 行）、验证项 18（约第 970 行）
- 改进建议：同问题 1，修订后同步验证项 16/18 描述为「验证类型分派路径 + 字面量 fallback 路径的编译可行性」。

**问题 15（轻微）**：§8.2 测试用例总数算术偏差（声称 ≥178 实际累加为 179，差 1）。
- 所在位置：§8.2 测试文件清单与位置表末尾（约第 913 行）
- 改进建议：§8.2 表末尾「合计」数字修订为「≥179」；同步检查 §3.16「阶段三验证标准双向映射表」等引用总数的位置，确保一致。

**问题 16（一般）**：§11.5 函数可用性对照表 `lessThan`/`lessThanEqual` 等 4 个比较函数的约束未标注。`isnan`/`isinf` 与 `mat3_cast`/`mat4_cast`/`quat_cast` 共 6 行均追加了「约束：`where T <: FloatingPoint<T>`（D29/D32）」标注，但 4 个比较函数行未追加任何约束标注。
- 所在位置：§11.5 函数可用性对照表最后一行（约第 1224 行）
- 改进建议：§11.5 `lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual` 行追加「**约束：`where T <: Comparable<T>`（依赖 `<`/`>` 运算符）**」标注；§3.15 完整实现函数段（行 638-641）补充 `lessThan` 等 4 个函数的 where 子句约束。

**问题 17（轻微）**：§2 lib.cj import 清单 #1 `glm.detail.{Quat, mat3Cast, mat4Cast, quatCast}` 类型与函数混合导入的语义边界未说明。下游按 §11.4 迁移示例调用 `let m3 = mat3Cast(q)`（无命名空间前缀）会编译失败，需先 `import glm.detail.*` 才能调用包级函数。
- 所在位置：§2 lib.cj import 清单 #1（约第 106 行）、§11.4 迁移示例（约第 1188-1195 行）
- 改进建议：§2 lib.cj 段补充说明：「`glm.detail.{mat3Cast, mat4Cast, quatCast}` 在 lib.cj 中以 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 形式重导出至顶层 `glm` 命名空间（与现有 `public import glm.detail.{transpose, matrixCompMult, outerProduct}` 模式一致，见 `cjglm/src/lib.cj:8`）」；或 §11.4 迁移示例修订为 `let m3 = glm.detail.mat3Cast(q)`，明确调用路径。

## 历史迭代回顾

迭代历史共 5 轮，迭代第 1-4 轮提出的问题（合计 51 项）已在 v9 设计中逐项落实（依据 b_v5_diag_v1.md 开头说明「v9 设计已完成 51 项历史审查意见的逐项落实（v2 14 + v3 2 + v4 2 + v5 14 + v6 3 + v7 5 + v8 11 = 51），本报告不重复历史已闭环问题」），本轮诊断报告亦明确不重复历史已闭环问题。

迭代第 5 轮问题（即 `iteration_history.md` 第 5 轮所列 17 项）= 当前组件B诊断报告（`b_v5_diag_v1.md`）所列 17 项质量问题（3 严重 + 13 一般 + 1 轻微），二者完全对应，均为本轮新识别的问题。

- **已解决的问题**：迭代第 1-4 轮的全部 51 项问题（已在 v9 设计中闭环），本轮诊断报告明确不再重复。
- **持续存在的问题**：无（本轮诊断未发现前 4 轮已闭环问题的反弹）。
- **新发现的问题**：本轮新识别 17 项质量问题（详见当前审查结果），均为本轮新发现。
  - **3 项严重问题**必须修复，否则下游编码将因 stdlib API 引用错误（`getMin`/`getInf` 不存在）、别名计数算术错误（8 vs 9）、`std.math.pow` 签名描述错误而编译失败或文件结构偏差。
  - **13 项一般问题**涵盖下游可执行性维度（依赖声明宽度、调用约定、约束标注、内部一致性等），均应采纳。
  - **1 项轻微问题**（问题 17）属细节提示，必要程度略低。

## 上一轮产出路径

C:/Develop/Software/cjglm_wp/harness/redeliberations/202606241929_stage3-ood/a_v5_copy_from_v4.md

（v9 设计，1489 行，超过 1000 行，本轮采用 COPY_AND_EDIT 模式：先复制上轮产出再定向修改）

## 用户需求

C:/Develop/Software/cjglm_wp/harness/redeliberations/202606241929_stage3-ood/requirement.md
