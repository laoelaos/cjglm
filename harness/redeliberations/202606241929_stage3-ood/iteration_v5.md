# 再审议判定报告（v5）

## 判定结果

RETRY

## 判定理由

组件B诊断报告（v5_diag_v1）识别出 17 项质量问题（3 项严重 + 13 项一般 + 1 项轻微），质询报告（v5_challenge_v1）经 LOCATED 审查结论确认报告整体质量较高、3 项严重问题证据链完整（已对照 cangjie-std/math/README.md 与项目实际文件验证），并将严重问题判定为下游编码将立即遇到的真实阻塞性问题。

组件B内部循环实际轮次=1 < 最大轮次=12，循环未耗尽，质询以 LOCATED 提前终止。质询报告仅对个别一般问题的严重程度提出降级建议（问题7可从一般降为轻微、问题6需加注兜底说明），但未对3项严重问题与多数一般问题提出 CHALLENGED 质疑。

依据判定标准，审查报告包含严重与一般等级问题，判定为 RETRY，需重新运行组件A以修复以下问题。

## 需要解决的问题

### 问题 1（严重）
- **问题描述**：设计 §3.10、D21、§8 编码启动前验证项 16/18 多次引用 `FloatingPoint<T>.getMin()` 和 `FloatingPoint<T>.getInf()` 实例方法作为「主策略」。但经查 `cangjie-std/math/README.md` 第 111-115 行，仓颉 stdlib 不存在这两个方法，仅存在 `Float64.Inf`/`Float64.Min`/`Float64.Max`/`Float64.NaN` 等静态常量。`FloatingPoint<T>` 接口本身仅作为类型约束被声明，未列出任何实例方法。验证项 16/18 的「主验证目标」100% 不存在，下游即使启动验证也只能命中 fallback 路径。
- **所在位置**：§3.10（约第 496-497 行）、D21 设计决策（约第 830 行）、§8 编码启动前验证项 16（第 968 行）、§8 编码启动前验证项 18（第 970 行）
- **严重程度**：严重
- **改进建议**：
  - §3.10 `pow`/`log` 依赖描述修订为「通过类型分派 `if (q.x is Float32) { Float32.Min } else { Float64.Min }` 或运行时 fallback `T(1)/T(0)` 显式构造」，并明确「仓颉 stdlib 不提供 `getMin()`/`getInf()` 实例方法，仅提供 `Float64.Inf`/`Float64.Min`/`Float64.Max` 等静态常量」
  - D21 决策依据修订为「stdlib 仅提供类型级常量（`Float64.Inf`/`Float64.Min` 等），无实例方法；仓颉实现路径为类型分派 + 字面量构造」
  - §8 验证项 16 修订为「验证仓颉浮点类型最小正值获取路径」并补充 fallback（类型分派）
  - §8 验证项 18 修订为「验证仓颉浮点类型 Infinity 获取路径」并补充 fallback（类型分派）

### 问题 2（严重）
- **问题描述**：§3.14、§2 lib.cj/fwd.cj 段落、§8 更新文件段多处声称 fwd.cj 新增「8 个别名」并明确列出 `Quat` / `FQuat` / `DQuat` + 3×Float32 精度（`HighpQuat`/`MediumpQuat`/`LowpQuat`）+ 3×Float64 精度（`HighpDQuat`/`MediumpDQuat`/`LowpDQuat`）= 9 个别名。算术与文字直接矛盾（3+3+3=9 vs 汇总数字 8）。下游按设计实现 fwd.cj 时会产生 9 个 type alias（与文档声称的 8 不一致），§8 测试文件清单、§11.5 函数可用性对照表的引用统计也将偏差 1。
- **所在位置**：§3.14（约第 609 行、第 614 行）、§2 lib.cj/fwd.cj 段落（约第 138 行）
- **严重程度**：严重
- **改进建议**：
  - §3.14 / §2 三处「合计 8 个别名」统一修订为「合计 9 个别名」
  - §2 lib.cj/fwd.cj 段「v5 修正」附注修订为「v5 修正：原描述遗漏 1 个，完整应为 Quat/FQuat/DQuat + 3×Float32 精度 + 3×Float64 精度 = 9 个」

### 问题 3（严重）
- **问题描述**：§3.10 「命名消歧（v5 新增）」段声明「四元数 `pow` 函数体内部调用的 `pow(x.w, y)` 是实数版本 `std.math.pow(T, T): T`」。但按 `cangjie-std/math/README.md` 第 13 行，`std.math.pow` 实际签名为 `pow(base: Float64, exponent: Float64): Float64`，不是泛型 `pow(T, T): T`。下游编码者按设计字面实现「`pow(x.w, y)`」时：当 `T = Float64` 时签名不一致（返回类型不是 T 而是 Float64）；当 `T = Float32` 时直接编译失败（不存在该重载）。§3.10 「命名消歧」段与「Float64 转换依赖」段描述不一致，下游实现 pow 时按哪段描述为准存在歧义。
- **所在位置**：§3.10 「命名消歧（v5 新增）」段与「Float64 转换依赖（v7 澄清）」段（约第 497 行附近）
- **严重程度**：严重
- **改进建议**：
  - §3.10 「命名消歧」段将「`std.math.pow(T, T): T`」修订为「`std.math.pow(Float64, Float64): Float64`（仅支持 Float64 输入）」
  - 与「Float64 转换依赖」段统一，明确下游实现路径为：`Float64(std.math.pow(Float64(x.w), Float64(y)))` 或 fallback `Float64(std.math.exp(Float64(y) * std.math.log(Float64(x.w))))`，最终结果通过 `T(...)` 转换回目标类型
  - §8 验证项 15 同步修订为「验证 std.math.pow 的 Float64-only 签名 + T(…) 转换路径的编译可行性」

### 问题 4（一般）
- **问题描述**：设计 §3.12 提出在 `detail/scalar_constants.cj` 新增 `func epsilon<T>(): T where T <: FloatingPoint<T>` 函数，但 `cjglm/src/detail/shim_limits.cj` 第 25 行已存在同名语义的 `public func epsilonOf<T>(hint: T): T where T <: Number<T>`，且 `cjglm/src/detail/compute_vector_relational.cj` 第 17 行已使用 `epsilonOf(a)` 进行浮点容差比较。设计 §3.12 未说明：(a) `epsilon<T>()`（无参）与 `epsilonOf<T>(hint)`（带 hint）的功能等价性与新增「无参版本」是否为 API 形态对齐 GLM 的冗余代价；(b) 若阶段三同时存在两者，返回值是否始终一致；(c) 阶段二测试 `shim_limits_test.cj` 的硬编码值与设计 §3.12 的「具体类型硬编码值」是否一致未做交叉验证。
- **所在位置**：§3.12 ext/scalar_constants.cj（约第 523-530 行）
- **严重程度**：一般
- **改进建议**：
  - §3.12 段落新增「与 `shim_limits.cj:25` `epsilonOf<T>(hint)` 关系」子节，明确：(a) 两函数功能等价，阶段三新增 `epsilon<T>()` 是为了对齐 GLM API 形态（无参调用），无业务新增；(b) 两者返回值需严格一致（建议 `epsilon<T>()` 函数体内部直接调用 `epsilonOf<T>(epsilonOf<T> placeholder hint)` 或复刻相同 match 分派逻辑）；(c) 阶段二测试 `shim_limits_test.cj` 的硬编码值已作为数值正确性的 ground truth
  - 编码启动前验证项新增「验证 `epsilon<T>()` 与 `epsilonOf<T>(hint)` 在 `T = Float32`/`Float64`/`Int64` 下的返回值一致性」

### 问题 5（一般）
- **问题描述**：§3.13.1 表头中向量版本签名统一使用 `VecN<T, Q>: VecN<T, Q>` 形式（如 `sin<T, Q>(x: VecN<T, Q>): VecN<T, Q>`），设计汇总「30 个函数」。但仓颉项目不存在 `VecN` 这种泛型占位类型——实际模式是 `compute_vec_add1`/`add2`/`add3`/`add4` 四个独立 struct。下游按设计实现 trigonometric.cj 时，「30 个函数」实际需展开为大量重载签名，设计未说明此展开规则，下游编码者需自行推断展开策略，可能与既有命名/结构惯例不一致。
- **所在位置**：§3.13.1（约第 553-580 行）
- **严重程度**：一般
- **改进建议**：
  - §3.13.1 表头新增说明「`VecN<T, Q>` 是占位符，实际展开为 `Vec1<T, Q>`/`Vec2<T, Q>`/`Vec3<T, Q>`/`Vec4<T, Q>` 4 个独立重载，命名沿用 `cjglm/src/detail/compute_vector_decl.cj` 的 `compute_vec_xxx1/2/3/4` 模式」
  - 函数总数重新核算实际函数数量；或将 14 个单参数三角函数的向量版本改用 `compute_vec_sin1`/`sin2`/`sin3`/`sin4` 命名惯例（与 compute_vector_decl.cj 对齐）

### 问题 6（一般）
- **问题描述**：§5.4 声明「`lerp`/`conjugate`/`inverse` 不可在 const 上下文调用」，理由为「函数体内 `assert` 或 `throw` 不是 const 函数」。但 §3.11 描述 `conjugate(q)` 仅对 x/y/z 三个分量取反，函数体内无 assert/throw/运行时副作用，因此 `conjugate` 实际可在 const 上下文调用（与 §5.4 声明矛盾）。§5.4 将 `conjugate` 与 `inverse`/`lerp` 列为同类，但 `conjugate` 缺少使其无法 const 的理由。内部描述不一致，下游编码者按 §5.4 实现 conjugate 时会因「函数体无 assert/throw 仍标 non-const」产生困惑。
- **所在位置**：§5.4 const 上下文约束（约第 789-792 行）、§3.11 `conjugate` 描述（约第 508 行）
- **严重程度**：一般
- **改进建议**：
  - §5.4 修订为「`lerp`/`inverse` 不可在 const 上下文调用」，移除 `conjugate`
  - §5.4 补充 `inverse` 的 const 拒绝理由：「依赖 `/` 运算符，整数 T 在 `dot(q,q) == 0` 时触发 `ArithmeticException`，非 const 函数」
  - §3.11 `conjugate` 描述末尾新增「可声明为 `const func`（与 `Vec`/`Mat` 的逐分量运算符策略一致）」；若仓颉 const 函数还有其他限制（如不能调用非 const 自由函数），则该论断需进一步评估

### 问题 7（一般，质询建议可降为轻微）
- **问题描述**：§3.13.1 表中 `radians`/`degrees` 行「内部依赖」列标注「纯算术（度→弧度，无 std.math 依赖）」，意味着 `radians(x) = x * π/180` 类公式中 `π` 的来源未明确（硬编码字面量 vs 调用 `scalar_constants.cj` 的 `pi<T>()`）。§2 模块间依赖图未列出该依赖。设计两处描述自相矛盾：表头说「无 std.math 依赖」，但又说「标量版本用于 `slerp`/`mix`/`pow`/`log`/`exp`/`angle`/`angleAxis` 等函数体内的分量级运算」——而这些函数在 stage 3 都是 stub，radians/degrees 在 stage 3 也是 stub，所以实际依赖在 stage 4 才落地。
- **所在位置**：§3.13.1 表（约第 573-574 行）
- **严重程度**：一般（质询报告建议可降为轻微，因仅影响阶段四实现）
- **改进建议**：
  - §3.13.1 `radians`/`degrees` 行「内部依赖」列补充明确：「硬编码 π 字面量 `Float64(3.141592653589793)`，无 std.math 依赖，无 `scalar_constants` 依赖」
  - 或补充：「调用 `scalar_constants.cj` 的 `pi<T>()`，新增 `trigonometric.cj → scalar_constants.cj` 依赖」，并在 §2 模块间依赖图 `glm.detail` 块下新增此依赖

### 问题 8（一般）
- **问题描述**：§8.2 测试文件清单建议阶段三测试文件采用 `tests/glm/ext/` 结构（如 `tests/glm/ext/test_vector_relational.cj` 等共 10 个文件）。但项目现有测试结构为 `cjglm/tests/glm/test_ext.cj`（单一文件涵盖所有 `ext.*` 别名测试），且实际 `cjglm/tests/glm/ext/` 目录不存在。阶段二 25 个测试文件均位于 `tests/glm/detail/` 下，但阶段二并无 `ext/` 子目录的测试文件先例。设计引入 `tests/glm/ext/` 是新建目录结构，但未说明：(1) 与既有的 `tests/glm/test_ext.cj` 的关系——阶段三是否合并/拆分？(2) 是否同步新增 `tests/glm/gtc/` 子目录——设计清单中有 `tests/glm/gtc/` 下的测试文件，但 `tests/glm/gtc/` 当前不存在。
- **所在位置**：§8.2 测试文件清单与位置表（约第 894-913 行）
- **严重程度**：一般
- **改进建议**：
  - §8.2 测试设计新增「测试目录结构对齐策略」段，明确：(a) `tests/glm/ext/` 为新增目录（项目当前无此目录先例），下游需先 `mkdir -p`；(b) 既有的 `tests/glm/test_ext.cj`（聚合测试）保留为 ext 别名兼容测试，新增的 `tests/glm/ext/test_xxx.cj` 为逐函数单元测试，二者并存；(c) `tests/glm/gtc/` 同样为新增目录，与 `src/gtc/` 子目录结构对齐
  - 或修订测试文件结构为 `tests/glm/test_ext_xxx.cj` 命名（与现有 `test_ext.cj` 风格对齐），避免新建子目录

### 问题 9（一般）
- **问题描述**：§2 模块间依赖图 `glm.gtc` 块声明 `quaternion.cj → glm.detail.{Quat, Mat3x3, Mat4x4, Vec3}`。但逐项核查 §3.15 的 15 个 gtc/quaternion.cj 函数：4 个比较函数（`lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual`）仅依赖 `Quat`，完全不依赖 `Mat3x3`/`Mat4x4`/`Vec3`；3 个 quatLookAt 函数仅依赖 `Vec3`，不依赖任何 Mat 类型。设计将依赖声明扩展至全部 Mat/Vec 类型，下游按声明增加 import 后会产生未使用 import（造成代码冗余）。
- **所在位置**：§2 模块间依赖图（约第 198 行）、§3.2.1 与 §3.15
- **严重程度**：一般
- **改进建议**：
  - §2 模块间依赖图 `glm.gtc` 块修订为：`quaternion.cj → glm.detail.Quat, glm.detail.{Mat3x3, Mat4x4} (仅 mat3_cast/mat4_cast/quat_cast 重导出需要), glm.detail.Vec3 (仅 eulerAngles/roll/pitch/yaw/quatLookAt* stub 需要)`
  - 或修订为分段声明：`比较函数仅依赖 Quat；转换函数重导出 detail 的 Mat3x3/Mat4x4；欧拉/看向 stub 依赖 Vec3`

### 问题 10（一般）
- **问题描述**：§1 「本阶段受此约束影响的函数」清单列出 7 个函数，但 §3.13.1 三角函数表中列出 trigonometric.cj 函数时，未将 `trigonometric.cj` 自身标注「受 §1 Float32 与 std.math 交互约束管辖」——而 trigonometric.cj 实现的 14 个标量函数本身就调用 `std.math.sin`/`cos`/`tan` 等 Float64-only 函数，下游实现 trigonometric.cj 时需对每个函数应用 `T(Float64.xxx(Float64(value)))` 转换模式。设计 §3.13.1 表头虽写「受 §1 管辖」，但表行内容未充分映射此约束对每个函数的影响。
- **所在位置**：§3.13.1 三角函数表（约第 559-580 行）
- **严重程度**：一般
- **改进建议**：
  - §3.13.1 表头说明强化：「**所有 `std.math.*` 函数仅支持 Float64 输入/输出（依据 `cangjie-std/math/README.md` 第 13 行），所有 trigonometric.cj 函数在 `T = Float32` 实例化时需应用 `T(Float64.xxx(Float64(value)))` 转换模式**」
  - 表行「内部依赖」列统一标注「`std.math.{func}`（仅 Float64，Float32 实例化需显式转换）」

### 问题 11（一般，质询建议可降为轻微）
- **问题描述**：§3.9 `axis` 函数公式（约第 482 行）：`tmp2 = T(Float64(1)) / T(Float64(std.math.sqrt(Float64(tmp1))))`。`std.math.sqrt` 本身签名为 `sqrt(x: Float64): Float64`，返回值已是 `Float64`，公式中 `Float64(std.math.sqrt(Float64(tmp1)))` 等价于 `Float64(Float64)`（冗余但合法），下游可正常工作但语义不清晰。冗余嵌套增加了维护负担。
- **所在位置**：§3.9 `axis` 函数描述（约第 482 行）
- **严重程度**：一般（质询报告建议可降为轻微，属纯风格问题，不影响功能）
- **改进建议**：
  - §3.9 公式修订为 `tmp2 = T(Float64(1)) / T(std.math.sqrt(Float64(tmp1)))`，删除冗余的 `Float64(...)` 包装
  - 在公式旁新增公式解读注释：「`std.math.sqrt` 已是 Float64 输入/输出，仅需一次 `T(Float64(…))` 转换回目标类型 T」

### 问题 12（一般）
- **问题描述**：§1 「系统性设计约束」段说明 `Float32 与 std.math 的交互约束`「统一处理策略」——所有引用 std.math 的函数应统一引用此约束。但 §3.10 `pow` 描述在「命名消歧（v5 新增）」段后又单设「Float64 转换依赖（v7 澄清）」子段，二者功能重叠：§1 通用约束已说明 `pow(Quat<Float32, Q>, Float32)` 需 Float64 转换，§3.10 又单独说明 `pow` 的 Float64 转换细节。下游阅读时会产生「§1 已说明的通用规则为何 §3.10 又重复一次」的疑问，且「命名消歧」段与「Float64 转换依赖」段描述同一约束但行文分散。
- **所在位置**：§1 通用约束段（约第 54-63 行）、§3.10 `pow` 描述（约第 497 行）
- **严重程度**：一般
- **改进建议**：
  - §3.10 `pow` 「Float64 转换依赖」段精简为「`pow(Quat<Float32, Q>, Float32)` 实现路径遵循 §1 通用约束，应用 `T(Float64.std.math.pow(...))` 转换模式」，删除与 §1 重复的展开说明
  - 或将 §3.10 的「Float64 转换依赖」段并入「命名消歧」段，统一为「命名消歧与 Float64 转换」单一小节

### 问题 13（一般）
- **问题描述**：§3.11 `inverse` 描述与 §5.3 边界条件表对整数 inverse 行为契约措辞不一致——虽两处描述本质一致，但 §5.3 表的「`axis(q)` 零四元数」行措辞（`\|w\| >= 1`）与 §3.9 `axis` 描述（`tmp1 <= 0`）虽等价但措辞略不同，且 §5.3 表未说明 `tmp1 = T(1) - w*w` 的计算公式，下游需对照 §3.9 才能完全理解边界条件。
- **所在位置**：§3.11 inverse 描述（约第 509 行）、§5.3 边界条件表（约第 773-776 行）
- **严重程度**：一般
- **改进建议**：
  - §5.3 边界条件表「`axis(q)` 零四元数」行补充「`tmp1 = T(1) - x.w*x.w`（参见 §3.9 公式）」明确公式引用
  - §5.3 表的「整数 `inverse`」行措辞与 §3.11 inverse 描述统一为「触发仓颉 `ArithmeticException`」

### 问题 14（一般）
- **问题描述**：§8 编码启动前验证项 16/18 验证目标不存在的 API（`getMin`/`getInf`），导致实际验证项无法独立完成。此问题与问题 1 同源，但单独标记是因该问题还影响「验证流程可执行性」维度——内部审议可能因「验证项已列出」即视为流程完备，未深入核验验证目标的可达性。
- **所在位置**：§8 编码启动前验证项 16（约第 968 行）、验证项 18（约第 970 行）
- **严重程度**：一般
- **改进建议**：同问题 1。修订后同步验证项 16/18 描述为「验证类型分派路径 + 字面量 fallback 路径的编译可行性」

### 问题 15（轻微）
- **问题描述**：§8.2 测试文件清单末尾声称合计 ≥178 个用例，但累加各测试文件预计用例数为 179，差 1。下游按设计规划测试用例数时会与文档声称值偏差 1。
- **所在位置**：§8.2 测试文件清单与位置表末尾（约第 913 行）
- **严重程度**：轻微
- **改进建议**：
  - §8.2 表末尾「合计」数字修订为「≥179」
  - 同步检查 §3.16 「阶段三验证标准双向映射表」等引用总数的位置，确保一致

### 问题 16（一般）
- **问题描述**：§11.5 函数可用性对照表对 `isnan`/`isinf` 与 `mat3_cast`/`mat4_cast`/`quat_cast` 共 6 行均追加了「约束：`where T <: FloatingPoint<T>`（D29/D32）」标注，但对同表的 `lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual` 4 个比较函数行未追加任何约束标注。下游阅读对照表时会产生「比较函数无约束 → 任何 T 均可调用」的误解。实际 `lessThan` 等函数依赖 `<`/`>` 运算符，约束为 `T <: Comparable<T>`。
- **所在位置**：§11.5 函数可用性对照表最后一行（约第 1224 行）
- **严重程度**：一般
- **改进建议**：
  - §11.5 `lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual` 行追加「**约束：`where T <: Comparable<T>`（依赖 `<`/`>` 运算符）**」标注
  - §3.15 完整实现函数段（行 638-641）补充 `lessThan` 等 4 个函数的 where 子句约束（`where T <: Comparable<T>, Q <: Qualifier`）

### 问题 17（轻微）
- **问题描述**：§2 lib.cj import 清单 #1 合并导入类型 `Quat` 与函数 `mat3Cast`/`mat4Cast`/`quatCast`，但 §2 未说明下游是否需要在 `lib.cj` 内部对 `mat3Cast` 等做进一步 `public import` 以暴露到顶层 `glm` 命名空间。下游消费者按 §11.4 迁移示例调用 `let m3 = mat3Cast(q)`（无命名空间前缀）会编译失败，需先 `import glm.detail.*` 才能调用包级函数。
- **所在位置**：§2 lib.cj import 清单 #1（约第 106 行）、§11.4 迁移示例（约第 1188-1195 行）
- **严重程度**：轻微
- **改进建议**：
  - §2 lib.cj 段补充说明：「`glm.detail.{mat3Cast, mat4Cast, quatCast}` 在 lib.cj 中以 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 形式重导出至顶层 `glm` 命名空间（与现有 `public import glm.detail.{transpose, matrixCompMult, outerProduct}` 模式一致，见 `cjglm/src/lib.cj:8`）」
  - 或 §11.4 迁移示例修订为 `let m3 = glm.detail.mat3Cast(q)`，明确调用路径