# R3: vector_relational.cj 向量关系运算函数库审查

审查时间：2026-06-27

### 审查范围

- `cjglm/src/ext/vector_relational.cj`（251 行，16 个 epsilon 重载 + 8 个 ULP stub）
- 对照规范：
  - `docs/05_ood_phase3.md` §3.5「ext/vector_relational.cj」（任务描述引用 §3.12.2 经核查为 §3.5，本文件无 §3.12.2 小节；以 §3.5 为权威依据）
  - `docs/deviations.md` DV-04（epsilonOf 需要 hint 参数）、DV-05（equalEpsilon 不可 const）
  - `cjglm/src/ext/quaternion_relational.cj`（复用参照）
  - `cjglm/src/detail/type_vec3.cj:152-154`（阶段一 equalEpsilon 风格基线）
  - `cjglm/tests/glm/ext/test_vector_relational.cj`（17 个测试用例）

### 维度覆盖摘要

| 维度 | 结论 |
|------|------|
| 与 OOD §3.5 设计意图一致性 | 一致（16 epsilon + 8 ULP 完整、abs 内联、严格 `<` 语义、`>=` 互补） |
| epsilon 重载完整性 | 完整（4 维 × 2 epsilon 形态 × 2 函数名 = 16） |
| ULP stub 合理性 | 合理（8 重载全部 `throw Exception("stub")`，与项目 stub 约定一致） |
| 算法正确性 | 正确（`|x-y| < epsilon` 与 GLM `epsilonEqual` 一致；`|x-y| >= epsilon` 与 `epsilonNotEqual` 互补） |
| T(Float64(0)) 字面量获取路径 | 与项目约定一致（使用 `(Float64(0) as T).getOrThrow()` 模式） |
| 约束选择 | 合理但可优化（epsilon 使用 `Number<T> & Comparable<T>`、ULP 使用 `FloatingPoint<T> & Comparable<T>`） |
| 与阶段一 equalEpsilon 模式一致性 | 风格不同（独立函数 vs extend 块），但与 OOD §3.5「避免 common.cj stub 递归」策略一致 |
| `glm.detail` 依赖正确性 | 正确（Vec1/Vec2/Vec3/Vec4/Qualifier 显式命名导入） |
| 重载冲突/编译器歧义 | 无歧义（epsilon 与 ULP 通过参数类型 `T` vs `Int64` 区分；ULP 的 `T <: FloatingPoint<T>` 排除 `T = Int64` 与 epsilon 重叠） |

### 发现

#### [一般] abs 内联模式重复 16 次，可抽取为包内私有辅助函数

- **位置**：`cjglm/src/ext/vector_relational.cj:9, 16, 23, 30, 39, 50, 61, 72, 85, 98, 111, 124, 139, 154, 169, 184`（共 16 处）
- **描述**：每个 epsilon 重载内部都重复 `let zero = (Float64(0) as T).getOrThrow(); let d = x.x - y.x; (if (d >= zero) { d } else { -d }) < epsilon` 模式。16 个重载对应 16 段相同字面代码，显著增加维护成本（若未来需调整为 std.math.abs 或更换语义需批量修改 16 处）。OOD §3.5 行 693 已明确说明此模式为「abs 内联展开」的刻意设计选择，但未限制代码组织形式。
- **建议**：在文件顶部抽取一个包内私有辅助函数 `func absDiff<T>(d: T): T where T <: Number<T> & Comparable<T>`（或类似命名），将 16 处调用收敛为单点实现；若担心与 `glm.detail.common.cj` 命名冲突，命名为 `relationalAbs` 或使用 `private` 可见性约束在包内使用。

#### [一般] ULP stub 测试覆盖不全，Vec2/Vec3/Vec4 的 stub 路径未验证

- **位置**：`cjglm/tests/glm/ext/test_vector_relational.cj:175-178`（仅 1 个 `testEqualULPStub` 覆盖 Vec1）
- **描述**：实现提供 8 个 ULP stub（Vec1~Vec4 × Int64/VecN-Int64 × equal/notEqual），但测试文件仅验证 1 个（Vec1 + Int64 + equal），Vec2/Vec3/Vec4 的 6 个 stub 重载、Vec1~Vec4 的 notEqual 4 个 stub、向量型 ULP（VecN-Int64）4 个 stub 均无测试覆盖。`gtc/quaternion.cj:24-48` 中 7 个 stub 函数在测试中均有 `assertThrows` 验证。stub 函数如果签名错误（参数类型、约束不匹配）导致编译期被用户无意中调用并触发未定义行为，是 stub 模式的最大风险。
- **建议**：至少为每种签名形态补充 1 个 stub 测试（Vec1~Vec4 + Int64 + equal 4 例 + Vec1~Vec4 + Int64 + notEqual 4 例 + Vec1~Vec4 + VecN-Int64 + equal 4 例 + Vec1~Vec4 + VecN-Int64 + notEqual 4 例 = 16 例），或简化为 4 个分组测试（每种参数形态 × 4 维共 16 例）。最低限度补充 Vec2/Vec3/Vec4 + Int64 + equal/notEqual 共 6 例。

#### [一般] 与 `ext/quaternion_relational.cj` 的 abs 内联模式未抽取共享，存在跨文件重复

- **位置**：
  - `cjglm/src/ext/vector_relational.cj:9-12` 等 16 处
  - `cjglm/src/ext/quaternion_relational.cj:15-28, 30-43`（共 2 处）
- **描述**：四元数关系运算的 epsilon 重载（`equal(Quat, Quat, epsilon: T)` / `notEqual(Quat, Quat, epsilon: T)`）使用与 vector_relational.cj 完全一致的 `(Float64(0) as T).getOrThrow()` + `if (d >= zero) { d } else { -d }` 内联 abs 模式。两文件均位于 `glm.ext` 包，未抽取共享的内部辅助函数。Quat 的 abs 内联代码字面量级与 Vec 完全相同，仅分量数量不同（4 vs 1/2/3/4）。
- **建议**：在 `glm.ext` 包内新建一个 `_relational_helpers.cj`（`package glm.ext`）或直接在 `vector_relational.cj` 顶部加 `private` 辅助函数，供两个文件共同引用。注：本建议与上条「abs 内联重复 16 次」属于同一根因的不同表现形式，修复时可一并处理。

#### [一般] 阶段一 `equalEpsilon` 与阶段三 `equal` epsilon 重载的约束风格不一致

- **位置**：
  - 阶段一：`cjglm/src/detail/type_vec3.cj:152-154` 使用 `T <: Number<T> & Equatable<T> & Comparable<T>`
  - 阶段三：`cjglm/src/ext/vector_relational.cj:7-8, 14-15, ...` 使用 `T <: Number<T> & Comparable<T>`（无 `Equatable<T>`）
- **描述**：阶段一 `equalEpsilon` 通过 `ComputeEqualNumeric<T>.callConst` 委托，内部需要 `==` 比较（要求 `Equatable<T>`）；阶段三 `equal` epsilon 重载使用原始 `<` 比较（不依赖 `Equatable<T>`），因此无需 `Equatable<T>` 约束。两者**逻辑上都正确**且与各自实现一致，但项目内部存在两种「epsilon 比较」约束模板——阶段一要求 `Equatable<T>`、阶段三不要求——可能给读者造成理解困惑。`deviations.md` DV-05 详细描述了阶段一 `equalEpsilon` 不可 const 的设计权衡，但阶段三的 `equal` epsilon 是自由函数，理论上可声明 `const`（详见下条）。
- **建议**：在 `docs/deviations.md` INT 章节（与 INT-01/INT-02/INT-04 一致）补充一条内部区别说明，记录阶段一与阶段三 epsilon 比较的约束差异（`Equatable<T>` 是否需要由实现细节决定）。约束本身无需修改——这是不同实现路径的自然差异。

#### [一般] epsilon 重载未声明 `const func`，与 OOD §3.5 内联设计不冲突但失去 const 化机会

- **位置**：`cjglm/src/ext/vector_relational.cj:7, 14, 21, 28, 37, 48, 59, 70, 83, 96, 109, 122, 137, 152, 167, 182`（16 个 epsilon 重载）
- **描述**：epsilon 重载是自由函数（不是 extend 块成员），与阶段一 `equalEpsilon`（DV-05 描述的 extend 块函数不可 const）不同，**理论上**可声明 `const func`。函数体仅包含 `let` 绑定、算术运算 `<` 比较、`Vec1<Bool, Q>(...)` 构造，均为 const 兼容操作（无 `assert`、无 `throw`、无运行时分派 `match`）。`ext/quaternion_relational.cj:15-43` 的 epsilon 重载同样未声明 `const func`，与本文件存在相同的「错失 const 化」机会。阶段一实践依据：阶段一 `cjglm/src/detail/type_vec3.cj:54-80` 已成功声明 27 个 const func（实现模式与本文件 epsilon 重载完全一致）。
- **建议**：为 16 个 epsilon 重载补充 `const func` 修饰符（最小改动：`public func` → `public const func`）。需在编码阶段先做最小原型验证——参考 OOD §3.5 行 779 中 `conjugate` 的 const 适用性分析路径。若验证通过，可显著提升 `const val eps = equal(v1, v2, 1e-5)` 等编译期使用场景的支持（阶段一 `equalEpsilon` 因 extend 块限制无法 const，阶段三 `equal` epsilon 作为自由函数无此限制）。若验证失败或评估认为 const 化无实际收益，至少在 `deviations.md` 中明确记录「阶段三 epsilon 比较自由函数刻意未声明 const」的设计决策。

#### [一般] 测试中 `testEqualVec1NegativeDiff` 与 `testEqualVec1ScalarEpsilon` 重复覆盖同一用例

- **位置**：`cjglm/tests/glm/ext/test_vector_relational.cj:7-12` 与 `167-172`
- **描述**：`testEqualVec1NegativeDiff`（行 167-172）测试场景为 `x=1.0, y=1.0000001, epsilon=1e-5`，与 `testEqualVec1ScalarEpsilon`（行 7-12）**完全相同**。用例注释 "NegativeDiff" 暗示意图是验证 `d = x - y` 为负数时的 abs 路径（`(d >= zero) { d } else { -d }` 的 else 分支），但实际数据未触发此分支——`x=1.0, y=1.0000001` 时 `d = -0.0000001 < 0`，进入 else 分支 `-d = 0.0000001`，**该测试实际**触发了 else 分支，与 `testEqualVec1ScalarEpsilon` 用例相同。注释暗示的设计意图（验证负数路径）与实际行为有偏差，或测试名称未能准确反映用例语义。
- **建议**：调整测试名称与用例内容使其与「负差验证」意图一致（如 `x=1.0000001, y=1.0, epsilon=1e-5`——`d > 0` 验证 then 分支；或保留 `x=1.0, y=1.0000001` 并改名为「Vec1 abs 下界测试」以与 `testEqualVec1ScalarEpsilon` 区分）。同时补充边界用例 `equal(v, v, 0)` 返回 `false` 的 OOD §3.5 行 1626 契约测试（D24 决策验证）。

#### [轻微] 16 个 epsilon 重载对 `let zero` 缺少显式类型注解，可读性可优化

- **位置**：`cjglm/src/ext/vector_relational.cj:9, 16, 23, 30, 39, 50, 61, 72, 85, 98, 111, 124, 139, 154, 169, 184`（共 16 处）
- **描述**：`let zero = (Float64(0) as T).getOrThrow()` 依赖编译器从右侧表达式推断 `T` 类型。虽然推断正确，但显式类型注解 `let zero: T = (Float64(0) as T).getOrThrow()` 更清晰地表达意图，并避免编译器推断时的歧义。`cjglm/src/detail/scalar_constants.cj:6, 11, 25` 与 `cjglm/src/detail/type_quat_cast.cj:7, 29, 53-55, 124` 均使用 `let hint: T = ...` / `let one: T = ...` 显式类型注解模式。
- **建议**：参考项目内其他文件惯例，将 16 处 `let zero = ...` 改为 `let zero: T = ...`。属于风格统一性调整，无功能影响。

#### [轻微] 约束 `Number<T> & Comparable<T>` 允许整数类型，对 epsilon 比较语义意义不大

- **位置**：`cjglm/src/ext/vector_relational.cj:8, 15, 22, 29, 38, 49, 60, 71, 84, 97, 110, 123, 138, 153, 168, 183`（共 16 个约束子句）
- **描述**：epsilon 比较的语义意义是「在容差范围内相等」——主要用于浮点数的舍入误差补偿。对整数类型（Int8~Int64/UInt8~UInt64），epsilon 比较退化为退化的精确比较（`equal(v1, v2, 0)` 是唯一有意义的调用），失去了 OOD §3.5 行 693「内联 abs 避免 common.cj stub」的核心设计价值。测试文件 `test_vector_relational.cj` 仅覆盖 `Float64` 类型，未对 `Int32`/`UInt32` 等类型做正确性验证。
- **建议**：（方案 A）保持当前 `Number<T> & Comparable<T>` 约束，并在 `deviations.md` 添加说明——整数类型使用 epsilon 比较退化为 `equal(v1, v2, 0)` 精确比较场景，与浮点语义不同但语法兼容。（方案 B）收紧为 `T <: FloatingPoint<T> & Comparable<T>`，强制 epsilon 比较仅对浮点可用——更贴近 OOD §3.5「`abs(x - y) <= epsilonOf(a)` 容差语义」的设计意图，但拒绝整数类型可能影响 stage 1/2 已有的 `equalEpsilon`（已支持 Int）的语义连续性。**倾向方案 A**：保持兼容性的同时通过文档说明语义差异。

#### [轻微] ULP stub 缺少文档注释说明 ULP 比较的仓颉实现障碍

- **位置**：`cjglm/src/ext/vector_relational.cj:199-251`（8 个 ULP stub）
- **描述**：ULP 比较在仓颉中无浮点位级访问 API（无 `reinterpret_cast`/`union`），OOD §3.5 行 678-680 已明确说明此限制。实现中 stub 函数体仅一行 `throw Exception("stub")`，缺乏对此设计决策的注释。后续维护者可能疑惑「为何这 8 个函数仅为 stub 而 epsilon 同名却完整实现」，需查阅 OOD 才可理解根因。
- **建议**：在 8 个 ULP stub 之上添加单行注释 `// ULP 比较 stub：仓颉无浮点位级访问 API，阶段四评估 std.math.Float 或 CFFI 方案后补齐`，或参考 OOD §3.5 的措辞简短说明。`cjglm/src/detail/geometric.cj` 的 stub 函数同样无注释，因此本建议属于项目级一致性优化——可选择仅本文件改进或扩展到全 stub 文件。

#### [轻微] epsilon 重载与 ULP stub 之间的过渡缺少分节注释

- **位置**：`cjglm/src/ext/vector_relational.cj:5, 35, 81, 135, 197, 211, 225, 239`
- **描述**：文件中已有 `// ---- Vec1 epsilon ----` 等分节注释，但 epsilon 段（行 5-195）与 ULP stub 段（行 197-251）之间未注明「以下为 stub 占位」的分节注释。OOD §3.5 行 678 明确区分「完整实现」与「stub 占位」两个状态，文件实现中也确实按此分段（行 195 与 197 之间的空白行）。建议在行 195 后添加类似 `// ---- ULP 浮点比较（stub 占位）----` 的注释段首。
- **建议**：在 ULP stub 段前添加 `// ---- ULP 浮点比较（stub 占位，待阶段四补齐）----` 注释，明确「以下 8 个函数为 stub」。属于可读性优化。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 0 |
| 一般 | 6 |
| 轻微 | 4 |

### 总评

`ext/vector_relational.cj` 的实现与 OOD §3.5 设计意图**完全一致**：16 个 epsilon 重载（4 维 × 2 epsilon 形态 × 2 函数名 = 16）和 8 个 ULP stub 的组合完整；`abs` 内联策略（避免 `common.cj` stub 递归依赖）正确实施；`equal` 使用严格 `<` 语义（与 GLM `epsilonEqual` 一致，D24 决策），`notEqual` 使用互补的 `>=` 语义；T(0) 字面量替代路径采用项目惯例的 `(Float64(0) as T).getOrThrow()` 模式（与 `scalar_constants.cj`、`type_quat_cast.cj`、`quaternion_*.cj` 一致），不依赖 `one: T` 形参污染函数签名；约束选择合理（epsilon 用 `Number<T> & Comparable<T>` 兼容 Int/Float、ULP 用 `FloatingPoint<T> & Comparable<T>` 限制为浮点），无重载歧义（epsilon 第三参数 `T` 与 ULP 第三参数 `Int64` 类型可区分，且 ULP 的 `FloatingPoint<T>` 约束排除了 `T = Int64` 与 epsilon 重叠）。

发现的 6 个一般问题主要集中在**可维护性与测试覆盖**层面：

- **代码重复**（3 条相关）——16 处 abs 内联与 2 处 Quat abs 内联可抽取共享辅助函数，但抽取范围与命名需要权衡（涉及包内 `private` 可见性）
- **测试覆盖**（1 条）——ULP stub 仅测试 Vec1，Vec2~Vec4 stub 风险未覆盖
- **const 化机会**（1 条）——自由函数性质赋予 16 个 epsilon 重载 const 化的可能性，但未充分利用
- **设计风格一致性**（1 条）——阶段一 `equalEpsilon` 与阶段三 `equal` epsilon 约束风格差异需在 `deviations.md` 留档

4 个轻微问题均为可读性优化（类型注解、注释、分节），无功能性影响。

**关键判定**：无严重问题，逻辑正确，依赖关系清晰，约束设计合理，与 OOD §3.5 / GLM 1.0.3 行为对齐。建议优先处理「abs 模式抽取共享辅助函数」与「ULP stub 测试覆盖」两条一般问题，其余可在后续阶段（阶段四补齐 ULP 或阶段五重构时）一并处理。
