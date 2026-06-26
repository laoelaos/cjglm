# OOD 设计质量审查报告（v9，迭代第 5 轮）

> **审查对象**：`a_v5_copy_from_v4.md`（v9 设计，1489 行）
> **审查定位**：本轮审查侧重内部审议未充分覆盖的维度——需求响应充分度、整体深度与完整性、设计可落地性。技术可行性等已在内部 8 轮迭代（v1→v9）中充分验证，本报告不重复验证。
> **审查视角**：从下游编码者实际"读设计→写代码"视角评估设计是否可直接指导实现、接口定义是否足以支持下游消费者、异常场景和边界条件是否已考虑。
> **重要前提**：v9 设计已完成 51 项历史审查意见的逐项落实（v2 14 + v3 2 + v4 2 + v5 14 + v6 3 + v7 5 + v8 11 = 51），本轮不再重复历史已闭环问题。

---

## 一、事实错误类（严重）

### 问题 1（严重）：设计引用了不存在的仓颉 stdlib API（`getMin`/`getInf` 实例方法）

**问题描述**：设计 §3.10、D21、§8 编码启动前验证项 16/18 多次引用 `FloatingPoint<T>.getMin()` 和 `FloatingPoint<T>.getInf()` 实例方法作为「主策略」，仅以 fallback 描述作为备选。但经查 `cangjie-std/math/README.md` 第 111-115 行，仓颉 stdlib **不存在**这两个方法，仅存在常量形式 `Float64.NaN`、`Float64.Inf`、`Float64.Max`、`Float64.Min`（`Float32` 对应物在 cangjie-std/math/README.md 中未列出）。`FloatingPoint<T>` 接口本身在 `cangjie-std/math/README.md` 第 117 行仅作为类型约束被声明，未列出任何实例方法。具体错误引用：

- §3.10 `pow` 依赖描述：「`std::numeric_limits<T>::min()` 等价的仓颉次正规数边界检查（仓颉版本通过 `T <: FloatingPoint<T>` 约束 + `FloatingPoint<T>.getMin()` 实例方法或 fallback 路径实现）」
- §3.10 `log` 依赖描述：「`std::numeric_limits<T>::infinity()` 等价物（line 30 用于 w=0 退化分支，仓颉版本建议优先 `FloatingPoint<T>.getInf()` 实例方法，fallback 为 `T(1)/T(0)` 显式构造）」
- D21 设计决策：「`std::numeric_limits<T>::min()` 通过 `FloatingPoint<T>` 约束 + `getMin()` 实例方法或 fallback 实现」
- §8 验证项 16：「验证仓颉 `FloatingPoint<T>` 接口是否提供 `getMin()` 实例方法（对应 `std::numeric_limits<T>::min()`）」
- §8 验证项 18：「验证仓颉 `FloatingPoint<T>` 接口是否提供 `getInf()` 实例方法（对应 `std::numeric_limits<T>::infinity()`）」

按当前 cangjie-std 文档，验证项 16/18 的「主验证目标」（即 getMin/getInf 实例方法）100% 不存在，下游即使启动验证也只能命中 fallback 路径。

**所在位置**：§3.10（约第 496-497 行）、D21 设计决策（约第 830 行）、§8 编码启动前验证项 16（第 968 行）、§8 编码启动前验证项 18（第 970 行）

**严重程度**：严重

**改进建议**：

- §3.10 `pow`/`log` 依赖描述修订为「通过类型分派 `if (q.x is Float32) { Float32.Min } else { Float64.Min }` 或运行时 fallback `T(1)/T(0)` 显式构造」，并明确「仓颉 stdlib 不提供 `getMin()`/`getInf()` 实例方法，仅提供 `Float64.Inf`/`Float64.Min`/`Float64.Max` 等静态常量」
- D21 决策依据修订为「stdlib 仅提供类型级常量（`Float64.Inf`/`Float64.Min` 等），无实例方法；仓颉实现路径为类型分派 + 字面量构造」
- §8 验证项 16 修订为「验证仓颉浮点类型最小正值获取路径」并补充 fallback（类型分派）
- §8 验证项 18 修订为「验证仓颉浮点类型 Infinity 获取路径」并补充 fallback（类型分派）

---

### 问题 2（严重）：fwd.cj 四元数别名计数自相矛盾（声称 8，实际 9）

**问题描述**：§3.14、§2 lib.cj/fwd.cj 段落、§8 更新文件段多处声称 fwd.cj 新增「**8 个**别名」并明确列出 `Quat` / `FQuat` / `DQuat` + 3×Float32 精度（`HighpQuat`/`MediumpQuat`/`LowpQuat`）+ 3×Float64 精度（`HighpDQuat`/`MediumpDQuat`/`LowpDQuat`）= **9 个**别名。算术与文字直接矛盾：

- §3.14（约第 609 行）：「**合计 8 个别名**（Quat/FQuat/DQuat/3×Float32 精度/3×Float64 精度 = 8 个）」
- §3.14（约第 614 行）：「合计 8 个别名（Quat/FQuat/DQuat/3×Float32 精度/3×Float64 精度，与 v2 一致）」
- §2 lib.cj/fwd.cj 段落（约第 138 行）：「合计 8 个别名（v5 修正：原描述遗漏 1 个，完整应为 Quat/FQuat/DQuat + 3×Float32 精度 + 3×Float64 精度 = 8 个）」

按设计自身的分解公式 3+3+3=9，但所有汇总数字均为 8。下游按设计实现 fwd.cj 时会产生 9 个 type alias（与文档声称的 8 不一致），§8 测试文件清单、§11.5 函数可用性对照表的引用统计也将偏差 1。

**所在位置**：§3.14（约第 609 行、第 614 行）、§2 lib.cj/fwd.cj 段落（约第 138 行）

**严重程度**：严重（事实错误，影响下游编码可执行性）

**改进建议**：

- §3.14 / §2 三处「合计 8 个别名」统一修订为「合计 9 个别名」
- §2 lib.cj/fwd.cj 段「v5 修正」附注修订为「v5 修正：原描述遗漏 1 个，完整应为 Quat/FQuat/DQuat + 3×Float32 精度 + 3×Float64 精度 = 9 个」

---

### 问题 3（严重）：§3.10 `pow` 与 `std.math.pow` 命名消歧方案本身存在类型推导歧义

**问题描述**：§3.10 「命名消歧（v5 新增）」段声明「四元数 `pow` 函数体内部调用的 `pow(x.w, y)` 是**实数版本** `std.math.pow(T, T): T`」。但按 `cangjie-std/math/README.md` 第 13 行，`std.math.pow` 实际签名为 `pow(base: Float64, exponent: Float64): Float64`，**不是泛型 `pow(T, T): T`**。下游编码者按设计字面实现「`pow(x.w, y)`」时：

- 当 `T = Float64` 时，`std.math.pow(Float64, Float64): Float64` 可调用，但与设计声称的「`pow(T, T): T`」签名不一致（返回类型不是 T 而是 Float64）
- 当 `T = Float32` 时，`std.math.pow(Float32, Float32)` 直接编译失败（不存在该重载），必须先 `Float64(x.w)`/`Float64(y)` 转换

§3.10 的「命名消歧」段仅在「第一参数类型 `T` 与 `Quat<T,Q>` 区分」层面做了粗粒度消歧，未深入到「std.math.pow 实际不支持 T 泛型」的更细颗粒度问题。v7 修订虽在「Float64 转换依赖」段补充了显式转换说明，但「命名消歧」段未同步修订「`std.math.pow(T, T): T`」的错误签名描述，导致两段描述不一致：

- 「命名消歧」段（错误）：「实数版本 `std.math.pow(T, T): T`」
- 「Float64 转换依赖」段（正确）：「需先显式将 `x.w`/`y` 转换至 Float64 再调用 `std.math.pow`」

下游实现 pow 时按哪段描述为准存在歧义。

**所在位置**：§3.10 「命名消歧（v5 新增）」段与「Float64 转换依赖（v7 澄清）」段（约第 497 行附近）

**严重程度**：严重（事实错误 + 内部描述不一致）

**改进建议**：

- §3.10 「命名消歧」段将「`std.math.pow(T, T): T`」修订为「`std.math.pow(Float64, Float64): Float64`（仅支持 Float64 输入）」
- 与「Float64 转换依赖」段统一，明确下游实现路径为：`Float64(std.math.pow(Float64(x.w), Float64(y)))` 或 fallback `Float64(std.math.exp(Float64(y) * std.math.log(Float64(x.w))))`，最终结果通过 `T(...)` 转换回目标类型
- §8 验证项 15 同步修订为「验证 std.math.pow 的 Float64-only 签名 + T(…) 转换路径的编译可行性」

---

## 二、关键遗漏类（一般）

### 问题 4（一般）：未识别与阶段二已有 `epsilonOf<T>(hint)` 函数的命名冲突与冗余设计

**问题描述**：设计 §3.12 提出在 `detail/scalar_constants.cj` 新增 `func epsilon<T>(): T where T <: FloatingPoint<T>` 函数。但 `cjglm/src/detail/shim_limits.cj` 第 25 行已存在同名语义的 `public func epsilonOf<T>(hint: T): T where T <: Number<T>`，且 `cjglm/src/detail/compute_vector_relational.cj` 第 17 行已使用 `epsilonOf(a)` 进行浮点容差比较。设计在 §3.12 仅以「具体类型分派（与 deviations.md DV-04 的 `epsilonOf` 策略一致，需 `hint: T` 参数辅助类型推断）」一句话承认 `epsilonOf` 为参考，但**未说明**：

1. `epsilon<T>()`（无参）与 `epsilonOf<T>(hint)`（带 hint）的功能等价性，阶段三是否新增「无参版本」仅是为 API 形态对齐 GLM 而付出冗余代价
2. 若阶段三同时存在 `epsilon<T>()` 与 `epsilonOf<T>(hint)`，两者返回值是否始终一致？若不一致将导致下游比较语义偏差
3. 阶段二测试 `shim_limits_test.cj` 已验证 `epsilonOf(Float32(0.0)) == Float32(1.1920929e-7)`、`epsilonOf(Float64(0.0)) == Float64(2.220446049250313e-16)`，设计 §3.12 的「具体类型硬编码值」数值是否与之一致未做交叉验证

**所在位置**：§3.12 ext/scalar_constants.cj（约第 523-530 行）

**严重程度**：一般

**改进建议**：

- §3.12 段落新增「与 `shim_limits.cj:25` `epsilonOf<T>(hint)` 关系」子节，明确：(a) 两函数功能等价，阶段三新增 `epsilon<T>()` 是为了对齐 GLM API 形态（无参调用），无业务新增；(b) 两者返回值需严格一致（建议 `epsilon<T>()` 函数体内部直接调用 `epsilonOf<T>(epsilonOf<T> placeholder hint)` 或复刻相同 match 分派逻辑）；(c) 阶段二测试 `shim_limits_test.cj` 的硬编码值已作为数值正确性的 ground truth
- 编码启动前验证项新增「验证 `epsilon<T>()` 与 `epsilonOf<T>(hint)` 在 `T = Float32`/`Float64`/`Int64` 下的返回值一致性」

---

### 问题 5（一般）：§3.13 `VecN<T,Q>` 占位符未映射到仓颉实际类型展开模式，下游需自行扩展 4 倍

**问题描述**：§3.13.1 表头中向量版本签名统一使用 `VecN<T, Q>: VecN<T, Q>` 形式（如 `sin<T, Q>(x: VecN<T, Q>): VecN<T, Q>`），设计汇总「**30 个函数**」。但经查 `cjglm/src/detail/compute_vector_decl.cj`，仓颉项目**不存在** `VecN` 这种泛型占位类型——实际模式是 `compute_vec_add1`/`add2`/`add3`/`add4` 四个独立 struct（每个针对特定分量数）。同理：

- `cjglm/src/detail/type_vec1.cj:159` 的 `equalExact` 接受 `Vec1<T, Q>` 参数
- `cjglm/src/detail/type_vec2.cj:140` 的 `equalExact` 接受 `Vec2<T, Q>` 参数
- `cjglm/src/detail/type_vec3.cj:149` 的 `equalExact` 接受 `Vec3<T, Q>` 参数
- `cjglm/src/detail/type_vec4.cj:158` 的 `equalExact` 接受 `Vec4<T, Q>` 参数

下游按设计实现 trigonometric.cj 时，「30 个函数」实际需展开为：14 单参数 × (1 标量 + 4 Vec 重载) + 1 双参数 × (1 标量 + 4 Vec 重载) = **75 个签名**（即每个「`VecN` 行」需拆分为 `Vec1`/`Vec2`/`Vec3`/`Vec4` 共 4 个独立重载）。设计未说明此展开规则，下游编码者需自行推断展开策略，可能与 `compute_vector_decl.cj` 的既有命名/结构惯例不一致。

**所在位置**：§3.13.1（约第 553-580 行）

**严重程度**：一般（影响下游编码可执行性，但非事实错误）

**改进建议**：

- §3.13.1 表头新增说明「`VecN<T, Q>` 是占位符，实际展开为 `Vec1<T, Q>`/`Vec2<T, Q>`/`Vec3<T, Q>`/`Vec4<T, Q>` 4 个独立重载，命名沿用 `cjglm/src/detail/compute_vector_decl.cj` 的 `compute_vec_xxx1/2/3/4` 模式」
- 函数总数由「30 个」修订为「30 个签名模板 × 实际实现 30 个（标量）+ 90 个（向量，14 × 4 + 1 × 2 = 58？）」，需重新核算实际函数数量
- 或将 14 个单参数三角函数的向量版本改用 `compute_vec_sin1`/`sin2`/`sin3`/`sin4` 命名惯例（与 compute_vector_decl.cj 对齐）

---

### 问题 6（一般）：§5.4 const 约束声明与 §3.11 函数体描述存在内部矛盾

**问题描述**：§5.4 声明「`lerp`/`conjugate`/`inverse` 不可在 const 上下文调用」，理由为「函数体内 `assert` 或 `throw` 不是 const 函数（与 deviations.md IF-03 一致）」。但 §3.11 描述：

- `conjugate(q)`：「完整实现。仅对 x/y/z 三个分量取反，w 分量保持不变：`Quat(-q.x, -q.y, -q.z, q.w)`」—— 函数体内**无 assert、无 throw、无运行时副作用**
- `inverse(q)`：「`conjugate(q) / dot(q, q)`」—— 仅调用 `conjugate`（无 assert/throw）和 `dot`（无 assert/throw）和 `/` 运算符；但 §5.3 边界条件表说明「整数四元数 `dot(q,q) == T(0)` 时触发仓颉整数除零异常」，因此 `inverse` 在整数 T 上**可抛 ArithmeticException**

因此：

- `conjugate` 实际**可在 const 上下文调用**（与 §5.4 声明矛盾）
- `inverse` 因依赖 `/` 运算符在 `T = Integer` 时可抛异常，**确实不能在 const 上下文调用**（与 §5.4 一致）

§5.4 将 `conjugate` 与 `inverse`/`lerp` 列为同类，但 `conjugate` 缺少使其无法 const 的理由。内部描述不一致，下游编码者按 §5.4 实现 conjugate 时会因「函数体无 assert/throw 仍标 non-const」产生困惑。

**所在位置**：§5.4 const 上下文约束（约第 789-792 行）、§3.11 `conjugate` 描述（约第 508 行）

**严重程度**：一般（内部不一致）

**改进建议**：

- §5.4 修订为「`lerp`/`inverse` 不可在 const 上下文调用」，**移除 `conjugate`**
- §5.4 补充 `inverse` 的 const 拒绝理由：「依赖 `/` 运算符，整数 T 在 `dot(q,q) == 0` 时触发 `ArithmeticException`，非 const 函数」
- §3.11 `conjugate` 描述末尾新增「可声明为 `const func`（与 `Vec`/`Mat` 的逐分量运算符策略一致）」

---

### 问题 7（一般）：§3.13.1 trigonometric.cj 中 `radians`/`degrees` 函数实现路径未明确

**问题描述**：§3.13.1 表中 `radians`/`degrees` 行「内部依赖」列标注「纯算术（度→弧度，无 std.math 依赖）」，意味着 `radians(x) = x * π/180` 类公式中 `π` 的来源未明确。可选实现路径：

1. 硬编码字面量 `π = Float64(3.141592653589793)`
2. 调用 `scalar_constants.cj` 的 `pi<T>()`

若选路径 1，`trigonometric.cj` 无外部依赖，但 π 字面量的精度依赖（`Float64(3.141592653589793)` 是 16 位有效数字）需明确；若选路径 2，`trigonometric.cj` 与 `scalar_constants.cj` 存在依赖关系，但 §2 模块间依赖图（行 167-211）未列出该依赖。

设计两处描述自相矛盾：表头说「无 std.math 依赖」，但又说「标量版本用于 `slerp`/`mix`/`pow`/`log`/`exp`/`angle`/`angleAxis` 等函数体内的分量级运算」——而这些函数本身在 stage 3 都是 stub，标量版本在 stage 3 不会被调用。`radians`/`degrees` 在 stage 3 也是 stub，所以实际依赖在 stage 4 才落地。

**所在位置**：§3.13.1 表（约第 573-574 行）

**严重程度**：一般

**改进建议**：

- §3.13.1 `radians`/`degrees` 行「内部依赖」列补充明确：「硬编码 π 字面量 `Float64(3.141592653589793)`，无 std.math 依赖，无 `scalar_constants` 依赖」
- 或补充：「调用 `scalar_constants.cj` 的 `pi<T>()`，新增 `trigonometric.cj → scalar_constants.cj` 依赖」，并在 §2 模块间依赖图 `glm.detail` 块下新增此依赖

---

### 问题 8（一般）：§8.2 测试文件结构 `tests/glm/ext/` 与现有项目惯例 `tests/glm/test_ext.cj` 不一致

**问题描述**：§8.2 测试文件清单（行 894-913）建议阶段三测试文件采用 `tests/glm/ext/test_xxx.cj` 结构（如 `tests/glm/ext/test_vector_relational.cj`、`tests/glm/ext/test_quaternion_common.cj` 等共 10 个文件）。但项目现有测试结构为：

- `cjglm/tests/glm/test_ext.cj`（第 1 行 `package glm`，单一文件涵盖所有 `ext.*` 别名测试）
- `cjglm/tests/glm/test_fwd.cj` / `test_integration_matrix.cj` / `test_lib.cj`（均在 `tests/glm/` 顶层，无子目录）

实际 `cjglm/tests/glm/ext/` 目录**不存在**（已通过 `ls cjglm/tests/glm/` 验证）。阶段二 25 个测试文件均位于 `tests/glm/detail/` 下，符合「按 src 子目录映射」原则，但阶段二并无 `ext/` 子目录的测试文件先例。

设计引入 `tests/glm/ext/` 是新建目录结构，但未说明：

1. 与 `tests/glm/test_ext.cj`（已有的 ext 别名测试聚合文件）的关系——阶段三是否合并/拆分？
2. 是否同步新增 `tests/glm/gtc/` 子目录——设计清单中有 `tests/glm/gtc/test_constants.cj` 和 `test_quaternion.cj`，但 `tests/glm/gtc/` 当前不存在

下游按设计创建 `tests/glm/ext/` 与 `tests/glm/gtc/` 目录时，需先决定「是否保留/迁移/合并」既有 `test_ext.cj`，设计未给指引。

**所在位置**：§8.2 测试文件清单与位置表（约第 894-913 行）

**严重程度**：一般（结构性遗漏）

**改进建议**：

- §8.2 测试设计新增「测试目录结构对齐策略」段，明确：(a) `tests/glm/ext/` 为新增目录（项目当前无此目录先例），下游需先 `mkdir -p`；(b) 既有的 `tests/glm/test_ext.cj`（聚合测试）保留为 ext 别名兼容测试，新增的 `tests/glm/ext/test_xxx.cj` 为逐函数单元测试，二者并存；(c) `tests/glm/gtc/` 同样为新增目录，与 `src/gtc/` 子目录结构对齐
- 或修订测试文件结构为 `tests/glm/test_ext_xxx.cj` 命名（与现有 `test_ext.cj` 风格对齐），避免新建子目录

---

### 问题 9（一般）：§3.2.1 / §2 模块间依赖图中 gtc/quaternion.cj 对 Mat3x3/Mat4x4/Vec3 的依赖声明过宽

**问题描述**：§2 模块间依赖图 `glm.gtc` 块（行 198）声明 `quaternion.cj → glm.detail.{Quat, Mat3x3, Mat4x4, Vec3}`，§3.2.1 与 §3.15 描述同样引用。但逐项核查 §3.15 的 15 个 gtc/quaternion.cj 函数：

| 函数 | 实际需要的 detail 类型 | 设计声明的 detail 依赖 |
|------|---------------------|----------------|
| `mat3_cast` / `mat4_cast` / `quat_cast` (Mat3) / `quat_cast` (Mat4) | Mat3x3, Mat4x4 (重导出) | ✓ 必要 |
| `lessThan` / `lessThanEqual` / `greaterThan` / `greaterThanEqual` | 仅 Quat | 仅 Quat（设计声明 Mat3x3/Mat4x4/Vec3 是多余的） |
| `eulerAngles` / `roll` / `pitch` / `yaw` (stub) | Vec3（依赖 `Vec3` `xyz` 分量） | Vec3 ✓ |
| `quatLookAt` / `quatLookAtRH` / `quatLookAtLH` (stub) | Vec3（依赖 `Vec3` 看向方向） | Vec3 ✓；但不需要 Mat3x3/Mat4x4 |

**4 个比较函数**仅依赖 `Quat`，完全不依赖 `Mat3x3`/`Mat4x4`/`Vec3`；**3 个 quatLookAt 函数**仅依赖 `Vec3`，不依赖任何 Mat 类型。设计将依赖声明扩展至全部 Mat/Vec 类型，下游按声明增加 `import glm.detail.{Mat3x3, Mat4x4, Vec3}` 后，实际仅 4 个比较函数不需要这些类型，导入后会产生未使用 import（cangjie 编译器可能不报错但造成代码冗余）。

**所在位置**：§2 模块间依赖图（约第 198 行）、§3.2.1 与 §3.15

**严重程度**：一般（依赖声明过宽，不影响功能但影响下游 import 准确性）

**改进建议**：

- §2 模块间依赖图 `glm.gtc` 块修订为：`quaternion.cj → glm.detail.Quat, glm.detail.{Mat3x3, Mat4x4} (仅 mat3_cast/mat4_cast/quat_cast 重导出需要), glm.detail.Vec3 (仅 eulerAngles/roll/pitch/yaw/quatLookAt* stub 需要)`
- 或修订为分段声明：`比较函数仅依赖 Quat；转换函数重导出 detail 的 Mat3x3/Mat4x4；欧拉/看向 stub 依赖 Vec3`

---

### 问题 10（一般）：§3.13.1 trigonometric.cj 受 Float32 与 std.math 交互约束影响的函数清单遗漏 `length`

**问题描述**：§1 「本阶段受此约束影响的函数」清单列出 `axis`、`length`、`angleAxis`、`exp`、`log`、`pow`、`sqrt` 共 7 个函数。但逐项核查 stage 3 已完整实现（非 stub）的函数：

- `length`（§3.7：「依赖 `std.math.sqrt`」+「Float32 实例的 sqrt 处理：实现阶段明确采用 `T(Float64.sqrt(Float64(dot_qq)))` 路径或额外声明 Float32 重载」）

§3.7 已明确声明 `length` 受此约束影响并在 §1 清单中列出。✓

但 §3.13.1 三角函数表中列出 trigonometric.cj 函数时，未将 `trigonometric.cj` 自身标注「受 §1 Float32 与 std.math 交互约束管辖」——而 trigonometric.cj 实现的 14 个标量函数（如 `sin`/`cos`/`tan`/`asin`/`acos`/`atan` 等）本身就调用 `std.math.sin`/`cos`/`tan`/`asin`/`acos`/`atan`（Float64-only）。下游实现 trigonometric.cj 时需对每个函数应用 `T(Float64.xxx(Float64(value)))` 转换模式。设计 §3.13.1 表头虽写「受 §1「Float32 与 std.math 的交互约束」管辖」，但表行内容未充分映射此约束对每个函数的影响。

**所在位置**：§3.13.1 三角函数表（约第 559-580 行）

**严重程度**：一般（系统性约束覆盖不完整）

**改进建议**：

- §3.13.1 表头说明强化：「**所有 `std.math.*` 函数仅支持 Float64 输入/输出（依据 `cangjie-std/math/README.md` 第 13 行），所有 trigonometric.cj 函数在 `T = Float32` 实例化时需应用 `T(Float64.xxx(Float64(value)))` 转换模式**」
- 表行「内部依赖」列统一标注「`std.math.{func}`（仅 Float64，Float32 实例化需显式转换）」

---

### 问题 11（一般）：§3.9 `axis` 函数公式中冗余的 `Float64(...)` 包装层

**问题描述**：§3.9 `axis` 函数公式（约第 482 行）：
```
tmp2 = T(Float64(1)) / T(Float64(std.math.sqrt(Float64(tmp1))))
```

`std.math.sqrt` 本身签名为 `sqrt(x: Float64): Float64`，返回值已是 `Float64`。公式中 `Float64(std.math.sqrt(Float64(tmp1)))` 等价于 `Float64(Float64)`（冗余但合法），下游可正常工作但语义不清晰。冗余嵌套增加了维护负担（若 stdlib 后续支持类型推断的 sqrt 重载，公式需调整）。

**所在位置**：§3.9 `axis` 函数描述（约第 482 行）

**严重程度**：一般（风格问题，不影响功能）

**改进建议**：

- §3.9 公式修订为 `tmp2 = T(Float64(1)) / T(std.math.sqrt(Float64(tmp1)))`，删除冗余的 `Float64(...)` 包装
- 在公式旁新增公式解读注释：「`std.math.sqrt` 已是 Float64 输入/输出，仅需一次 `T(Float64(…))` 转换回目标类型 T」

---

## 三、内部矛盾类（一般）

### 问题 12（一般）：§1 与 §3.10 对 `pow` 函数「Float64 转换依赖」段引用位置不一致

**问题描述**：§1 「系统性设计约束」段（行 49-63）说明 `Float32 与 std.math 的交互约束`「**统一处理策略（v8 明确，本阶段所有使用 `std.math` 的函数均适用）**」——所有引用 std.math 的函数应统一引用此约束。但 §3.10 `pow` 描述在「命名消歧（v5 新增）」段后又单设「**Float64 转换依赖（v7 澄清）**」子段（行 497 附近），二者功能重叠：

- §1 通用约束已说明 `pow(Quat<Float32, Q>, Float32)` 需 Float64 转换
- §3.10 又单独说明 `pow` 的 Float64 转换细节

下游阅读时会产生「§1 已说明的通用规则为何 §3.10 又重复一次」的疑问，且 §3.10 的「命名消歧」段与「Float64 转换依赖」段描述同一约束但行文分散。

**所在位置**：§1 通用约束段（约第 54-63 行）、§3.10 `pow` 描述（约第 497 行）

**严重程度**：一般（行文冗余/不一致）

**改进建议**：

- §3.10 `pow` 「Float64 转换依赖」段精简为「`pow(Quat<Float32, Q>, Float32)` 实现路径遵循 §1 通用约束，应用 `T(Float64.std.math.pow(...))` 转换模式」，删除与 §1 重复的展开说明
- 或将 §3.10 的「Float64 转换依赖」段并入「命名消歧」段，统一为「命名消歧与 Float64 转换」单一小节

---

### 问题 13（一般）：§3.11 inverse 描述与 §5.3 边界条件表对整数 inverse 行为契约措辞不一致

**问题描述**：§3.11 `inverse` 描述（行 509）声明「整数四元数 `dot(q,q) == T(0)` 时触发仓颉整数除零异常（与浮点 Inf/NaN 行为不同）」。§5.3 边界条件表（约第 776 行）声明「整数四元数 `inverse(q)` 触发仓颉整数除零异常」。两处描述一致。

但 §5.3 表的「`axis(q)` 零四元数」行（约第 773 行）描述「触发 `Vec3(T(0), T(0), T(1))` 返回值的条件为 `T(Float64(1)) - x.w*x.w <= T(Float64(0))`（典型场景：单位四元数 `(0, 0, 0, 1)` 即 `\|w\| >= 1`）」，而 §3.9 `axis` 描述（行 482）说明「`tmp1 <= T(Float64(0))` 返回 `Vec3(T(Float64(0)), T(Float64(0)), T(Float64(1)))`」。两处公式描述等价但措辞略不同（`\|w\| >= 1` vs `tmp1 <= 0`），且 §5.3 表未说明 `tmp1 = T(1) - w*w` 的计算公式，下游需对照 §3.9 才能完全理解边界条件。

**所在位置**：§3.11 inverse 描述（约第 509 行）、§5.3 边界条件表（约第 773-776 行）

**严重程度**：一般（内部措辞略不一致）

**改进建议**：

- §5.3 边界条件表「`axis(q)` 零四元数」行补充「`tmp1 = T(1) - x.w*x.w`（参见 §3.9 公式）」明确公式引用
- §5.3 表的「整数 `inverse`」行措辞与 §3.11 inverse 描述统一为「触发仓颉 `ArithmeticException`」

---

## 四、深度完整性类（一般/轻微）

### 问题 14（一般）：§3.10 `pow` 函数依赖关系虽已补齐，但 §8 验证项 16/18 验证目标不存在的 API，导致实际验证项无法独立完成

**问题描述**：§8 编码启动前验证项 16 原文：「验证仓颉 `FloatingPoint<T>` 接口是否提供 `getMin()` 实例方法（对应 `std::numeric_limits<T>::min()`）」。结合问题 1，按当前 cangjie-std 文档，`FloatingPoint<T>` 接口未声明任何实例方法（仅作为类型约束），该验证项 100% 不可独立完成——下游启动验证时只能得到「方法不存在」结论，然后依赖 fallback 路径实现，与设计声称的「主策略」不符。同理验证项 18。

此问题与问题 1 同源（API 引用错误），但单独标记是因该问题还影响「验证流程可执行性」维度——内部审议可能因「验证项已列出」即视为流程完备，未深入核验验证目标的可达性。

**所在位置**：§8 编码启动前验证项 16（约第 968 行）、验证项 18（约第 970 行）

**严重程度**：一般（流程完整性问题）

**改进建议**：同问题 1。修订后同步验证项 16/18 描述为「验证类型分派路径 + 字面量 fallback 路径的编译可行性」。

---

### 问题 15（一般）：§8.2 测试用例总数算术偏差（声称 ≥178 实际累加为 179）

**问题描述**：§8.2 测试文件清单末尾声称合计 **≥178** 个用例，但累加各测试文件预计用例数：

| 测试文件 | 预计用例数 |
|---------|----------|
| test_type_quat.cj | 40 |
| test_type_quat_cast.cj | 8 |
| test_vector_relational.cj | 16 |
| test_quaternion_relational.cj | 8 |
| test_quaternion_geometric.cj | 12 |
| test_quaternion_common.cj | 16 |
| test_quaternion_trigonometric.cj | 8 |
| test_quaternion_exponential.cj | 4 |
| test_quaternion_transform.cj | 2 |
| test_scalar_constants.cj | 6 |
| test_quaternion_float.cj | 4 |
| test_constants.cj | 28 |
| test_quaternion.cj | 27 |
| **累加** | **179** |

设计声称 ≥178，累加为 179，差 1。下游按设计规划测试用例数时会与文档声称值偏差 1。

**所在位置**：§8.2 测试文件清单与位置表末尾（约第 913 行）

**严重程度**：轻微（数值偏差）

**改进建议**：

- §8.2 表末尾「合计」数字修订为「≥179」
- 同步检查 §3.16 「阶段三验证标准双向映射表」等引用总数的位置，确保一致

---

### 问题 16（一般）：§11.5 函数可用性对照表 `lessThan`/`lessThanEqual` 等 4 个比较函数的约束未标注

**问题描述**：§11.5 函数可用性对照表对 `isnan`/`isinf` 与 `mat3_cast`/`mat4_cast`/`quat_cast`（detail/gtc）共 6 行均追加了「**约束：`where T <: FloatingPoint<T>`（D29/D32）**」标注，但对同表的 `lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual` 4 个比较函数行（最后一行）未追加任何约束标注。

下游阅读对照表时会产生「比较函数无约束 → 任何 T 均可调用」的误解。实际 `lessThan` 等函数依赖 `<`/`>` 运算符，约束为 `T <: Comparable<T>`（Vec3 等已有实践）。设计未明示该约束。

**所在位置**：§11.5 函数可用性对照表最后一行（约第 1224 行）

**严重程度**：一般（一致性遗漏）

**改进建议**：

- §11.5 `lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual` 行追加「**约束：`where T <: Comparable<T>`（依赖 `<`/`>` 运算符）**」标注
- §3.15 完整实现函数段（行 638-641）补充 `lessThan` 等 4 个函数的 where 子句约束（`where T <: Comparable<T>, Q <: Qualifier`）

---

### 问题 17（轻微）：§2 lib.cj import 清单 #1 `glm.detail.{Quat, mat3Cast, mat4Cast, quatCast}` 类型与函数混合导入的语义边界未说明

**问题描述**：§2 lib.cj import 清单 #1 合并导入类型 `Quat` 与函数 `mat3Cast`/`mat4Cast`/`quatCast`：`import glm.detail.{Quat, mat3Cast, mat4Cast, quatCast}`。仓颉 import 语法支持类型与函数混合导入，但 §2 未说明下游是否需要在 `lib.cj` 内部对 `mat3Cast` 等做进一步 `public import` 以暴露到顶层 `glm` 命名空间。

按 §1 整体架构思路段（行 41）「glm 包通过类型别名暴露常用具现化」，但「类型别名」仅覆盖 `Quat<T,Q>` 类型，不覆盖函数。`mat3Cast`/`mat4Cast`/`quatCast` 作为 detail 包的包级函数，外部消费者调用路径应为 `glm.detail.mat3Cast(q)` 而非 `glm.mat3Cast(q)`——设计未明确这一调用约定。

下游消费者按 §11.4 迁移示例（行 1194-1196）调用 `let m3 = mat3Cast(q)`（无命名空间前缀）会编译失败，需先 `import glm.detail.*` 才能调用包级函数。

**所在位置**：§2 lib.cj import 清单 #1（约第 106 行）、§11.4 迁移示例（约第 1188-1195 行）

**严重程度**：轻微（调用约定未明示）

**改进建议**：

- §2 lib.cj 段补充说明：「`glm.detail.{mat3Cast, mat4Cast, quatCast}` 在 lib.cj 中以 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 形式重导出至顶层 `glm` 命名空间（与现有 `public import glm.detail.{transpose, matrixCompMult, outerProduct}` 模式一致，见 `cjglm/src/lib.cj:8`）」
- 或 §11.4 迁移示例修订为 `let m3 = glm.detail.mat3Cast(q)`，明确调用路径

---

## 五、整体质量评价

### 已达成目标（需求响应充分度）

设计已充分响应用户需求「迁移 GLM 1.0.3 阶段三（四元数）至仓颉」：

1. **完整覆盖 GLM 1.0.3 阶段三 API**：§10 覆盖矩阵逐项对应 GLM 头文件（`type_quat.hpp`/`type_quat_cast.hpp`/`ext/quaternion_*.hpp`/`gtc/quaternion.hpp`），明确每个函数的本阶段状态（完整实现/stub/重导出），下游可按矩阵逐项落地
2. **包间依赖关系彻底理顺**：`glm.gtc → glm.detail` 单向依赖（v3 关键决策）已通过 8 轮迭代反复验证（§2 末尾 cjpm 子包构建预验证 + §8 验证项 1/2/3）
3. **系统性约束闭环**：T(1)/T(2) 字面量获取、Float32 与 std.math 交互、`FloatingPoint<T>` 接口收紧等约束均已上升为 §1 系统性约束，受影响函数清单列出（虽清单有遗漏，见问题 10）
4. **下游消费者迁移指南完整**：§11 覆盖 5 类迁移场景（构造/跨类型/旋转/矩阵互转/插值）+ 函数可用性对照表 19 行（虽约束标注遗漏，见问题 16）

### 仍需修复的核心问题

**严重问题 3 项（必须修复）**：
- 问题 1（`getMin`/`getInf` API 引用错误）
- 问题 2（别名计数 8 vs 9 算术错误）
- 问题 3（`pow` 命名消歧签名描述错误）

**一般问题 12 项（建议修复）**：
- 问题 4-13、14-16

**轻微问题 1 项（可选修复）**：
- 问题 17

### 审查结论

设计 v9 已完成 51 项历史审查意见的逐项落实，本轮新识别 17 项质量问题（3 严重 + 13 一般 + 1 轻微），其中 2 项严重问题（API 引用错误、算术错误）是历史审议未触及的事实层面遗漏。**强烈建议修复 3 项严重问题后再进入下游编码阶段**，否则下游编码者按设计字面实现时会因错误的 stdlib API 引用（`getMin`/`getInf`）和错误的别名计数（8 vs 9）产生编译失败或文件结构偏差。