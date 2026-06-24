# R1: 9 个矩阵类型 — 结构体定义、构造函数体系、行列访问

审查时间：2026-06-23

### 审查范围

**核心实现文件**：
- `cjglm/src/detail/type_mat2x2.cj`
- `cjglm/src/detail/type_mat2x3.cj`
- `cjglm/src/detail/type_mat2x4.cj`
- `cjglm/src/detail/type_mat3x2.cj`
- `cjglm/src/detail/type_mat3x3.cj`
- `cjglm/src/detail/type_mat3x4.cj`
- `cjglm/src/detail/type_mat4x2.cj`
- `cjglm/src/detail/type_mat4x3.cj`
- `cjglm/src/detail/type_mat4x4.cj`

**测试文件**：
- `cjglm/tests/glm/detail/test_type_mat2x2.cj` ~ `test_type_mat4x4.cj`

**参照文档**：
- `docs/04_ood_phase2.md` §3.1（矩阵结构体）、§3.3（构造函数体系）、§3.4（行列访问）
- `docs/deviations.md`（已知偏差）

### 维度总览

| 维度 | 结论 |
|------|------|
| 结构体定义（数据成员 / @Derive[Hashable] / 约束） | 一致正确 |
| 构造函数体系（逐分量 const init / 列向量 const init / diagonal / fromParts / fromColumns / identity） | 正确；存在 1 处与 OOD 偏差（额外 `init(scalar)`） |
| 行列访问（`[]` / `col()`） | 正确，符合 OOD §3.4 |
| 9 个矩阵类型签名一致性 | 高度一致；1 处排序不一致（Mat2x2 init(scalar) 顺序） |
| 测试覆盖率 | 主要场景覆盖完整；Hashable 行为未测试 |

### 发现

#### [一般] init(scalar: T) 构造函数未在 OOD §3.3 构造函数清单中定义（OOD 偏差）

- **位置**：
  - `cjglm/src/detail/type_mat2x2.cj:11-14`
  - `cjglm/src/detail/type_mat2x3.cj:21-24`
  - `cjglm/src/detail/type_mat2x4.cj:21-24`
  - `cjglm/src/detail/type_mat3x2.cj:24-28`
  - `cjglm/src/detail/type_mat3x3.cj:24-28`
  - `cjglm/src/detail/type_mat3x4.cj:24-28`
  - `cjglm/src/detail/type_mat4x2.cj:27-32`
  - `cjglm/src/detail/type_mat4x3.cj:27-32`
  - `cjglm/src/detail/type_mat4x4.cj:27-32`
- **描述**：OOD §3.3 明确列出 9 个矩阵类型的构造函数体系（共 8 类），其中 **不包含** `init(scalar: T)` 全填充构造函数。OOD §3.3 item 3 显式说明：GLM 中 `mat(T s)` 构造函数（全填充）**已映射为** 仓颉的 `diagonal(scalar)` Number<T> 工厂函数（仅对角线填充）。OOD §9 偏差表再次确认此接口形态偏差（"GLM 中 `mat(T s)` 为构造函数语法，仓颉中为 `Mat2x3.diagonal(1.0f)` 工厂函数，不可通过构造函数语法调用"）。但实现中 9 个矩阵类型全部额外提供 `public init(scalar: T)` 非 const 构造函数（**填满所有 C×R 个位置**，非对角填充），并被测试用例（如 `testMat*ScalarInit` 共 9 个）大量使用。例如 `Mat2x3<Int64, Defaultp>(5)` 实际产出全 6 分量均为 5 的矩阵，而非对角矩阵。
- **影响**：该偏差为**接口扩展**而非缺陷——既保留了 OOD 规范的 `diagonal(scalar)`（对角填充），又新增了 `init(scalar)`（全填充）以兼容 GLM 的 `mat(T s)` 调用语法。这对最终用户更友好，但偏离了 OOD §3.3 与 §9 的明确设计意图。
- **建议**：
  1. 若保留 `init(scalar)`，应在 `deviations.md` 中显式记录此偏差（与 §9 "无 init() 默认构造"偏差相关但更宽泛）。
  2. 或将测试中所有 `Mat?x?(..., Defaultp>(scalar)` 改写为 `Mat?x?..., Defaultp>.diagonal(scalar)` + `Mat?x?..., Defaultp>` 全填充 helper（如 `Mat?x?...fill(scalar)`）以符合 OOD。
  3. 注意 D33 决策要求 Bool 矩阵不提供 `diagonal(scalar)`，但 `init(scalar: T)` 由于无 `Number<T>` 约束仍可用于 Bool 测试（实际 Bool 矩阵测试未使用 `init(scalar)`，但若引入需明确 Bool 兼容性）。

#### [一般] Mat2x2 的构造函数声明顺序与其他 8 个矩阵类型不一致

- **位置**：
  - `cjglm/src/detail/type_mat2x2.cj:11-24`（`init(scalar)` 在最前）
  - `cjglm/src/detail/type_mat2x3.cj:11-24`、`type_mat2x4.cj:11-24` 等其余 8 个文件（`init(scalar)` 在最后）
- **描述**：Mat2x2 的声明顺序为 `init(scalar: T)` → `const init(逐分量)` → `const init(列向量)`，而其余 8 个矩阵类型的顺序均为 `const init(逐分量)` → `const init(列向量)` → `init(scalar: T)`。仓颉函数重载解析与声明顺序无关（不引发编译错误），但 9 个文件的代码组织风格应保持一致以降低维护成本。
- **建议**：将 Mat2x2 的 `init(scalar: T)` 移到两个 `const init` 之后，与其他 8 个矩阵类型保持一致。

#### [轻微] 9 个矩阵文件中均存在未使用的 `Integer` import

- **位置**：`cjglm/src/detail/type_mat*.cj:3`（全部 9 个文件）
- **描述**：所有 9 个矩阵文件均 `import std.math.{ Number, Integer }`，但文件内仅使用 `Number<T>` 约束，`Integer` 接口从未被引用。属于冗余导入。
- **建议**：将 `import std.math.{ Number, Integer }` 改为 `import std.math.Number`。或保留以应对未来扩展，但建议保持代码整洁。

#### [轻微] @Derive[Hashable] 自动派生行为未在测试中验证

- **位置**：`cjglm/src/detail/type_mat2x2.cj:6` 等 9 处 `@Derive[Hashable]`
- **描述**：9 个矩阵结构体均标注 `@Derive[Hashable]` 自动派生哈希，但 `tests/glm/detail/test_type_mat*.cj`（9 个文件）及 `test_type_mat_compare.cj` 中均未出现哈希相关测试用例（如 `hash(a) == hash(b)` 当 `a == b`、`HashSet<Mat4x4<...>>` 插入与查询等）。@Derive[Hashable] 是编译期元编程产物，无法通过简单的字段存在性检查保证正确性，应有运行时验证用例。OOD §8 阻断性验证项中明确要求"@Derive[Hashable] 跨元素类型编译验证"，但范围仅限编译验证，不含功能正确性测试。
- **建议**：在 `test_type_mat_compare.cj` 或每个 `test_type_mat*.cj` 末尾追加 Hashable 测试，至少覆盖：
  1. 相等矩阵哈希值相等
  2. 不等矩阵（某个分量不同）哈希值不等（弱验证，因哈希碰撞可能）
  3. 跨元素类型实例化（Float32/Float64/Int32/Int64/Bool）可成功调用 `hash()` 函数

#### [轻微] 测试中未覆盖 `init(scalar)` 与 `const init(逐分量)` 重载消歧场景

- **位置**：`cjglm/tests/glm/detail/test_type_mat*.cj`
- **描述**：每个 `test_type_mat*.cj` 都有 `testMat*ScalarInit`（使用 `Mat?x?(scalar)` 形式）和 `testMat*ConstInitElementwise`（使用 `Mat?x?(a00, a01, ...)` 形式）测试，但两者参数形式差异显著（单参数 vs 4~16 个参数），不会出现重载歧义。然而测试集中于使用形式，未验证调用方代码中**两种构造方式的等价性测试**——例如 `Mat3x3<Int64, Defaultp>(7)` 与 `Mat3x3<Int64, Defaultp>(7, 7, 7, 7, 7, 7, 7, 7, 7)` 是否结果相同。
- **建议**：为每个矩阵类型追加一个测试用例，验证 `init(scalar)` 与 `const init` 全相同值时结果矩阵一致（这隐含验证了全填充语义与逐分量构造的一致性）。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 0 |
| 一般 | 2 |
| 轻微 | 3 |

### 总评

9 个矩阵类型的**结构体定义、构造函数体系、行列访问**整体实现质量高，与 OOD §3.1、§3.3、§3.4 的设计规范高度一致：

- 结构体定义方面：所有 9 个矩阵类型均采用 `public struct Mat{C}x{R}<T, Q> where Q <: Qualifier` 形态，公开 `c0~c{C-1}` 列主序数据成员，类型与列向量维度严格匹配 OOD §3.2 映射表（Mat2x2~Mat4x4 9 种），统一标注 `@Derive[Hashable]`。
- 构造函数体系方面：OOD 要求的 8 类构造函数/工厂函数全部正确实现——逐分量 const init 与列向量 const init 均按列主序参数排列且为 const（与 OOD 表一致）；`fromParts` / `fromColumns` / `fromMat 6a/6b/7` 的泛型约束与参数语义正确；`diagonal(scalar)` 与 `identity(one)` 在 Number<T> 约束 extend 块中实现，T(0) 通过 `scalar - scalar` 演算路径正确（非方阵的 i ≥ R 整列全 0 处理在 Mat3x2/Mat4x2/Mat4x3 等已验证）。**唯一发现的偏差**是全部 9 个矩阵类型均额外提供了未列入 OOD §3.3 清单的 `public init(scalar: T)` 构造函数（全填充），虽偏离 OOD 设计但提供了更好的 GLM 兼容性与 API 易用性，需在 deviations.md 显式登记。
- 行列访问方面：`operator func [](i: Int64)` 取值版本与 `public mut operator func [](i: Int64, value!: VecR<T,Q>)` 赋值版本（含 `mut` 修饰与 `value!` 命名参数）严格符合 OOD §3.4；`col(i: Int64)` 仅提供取值版本（与 OOD 一致）；下标越界通过 assert + match 默认分支双重保护。
- 测试覆盖方面：每个 `test_type_mat*.cj` 均覆盖 length、const init（逐分量/列向量）、scalar init、index access/mutate、out-of-bounds、col access、diagonal、identity、fromParts、fromColumns 及 fromMat 6a/6b/7 主路径，测试组织完整规范。

总体评价：**实现质量良好**，主要问题是 1 处 OOD 偏差（`init(scalar)` 未在 ODD 中定义）和 1 处代码组织不一致（Mat2x2 构造函数顺序），均不影响功能正确性。其余轻微问题（未使用 import、Hashable 未测试、构造重载等价性未测试）属可改进项，建议在下个迭代中处理。