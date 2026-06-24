# R9: 实现与 deviations.md 偏差交叉验证

审查时间：2026-06-23

### 审查范围

| 文件路径 | 角色 |
|---------|------|
| `docs/deviations.md` | 偏差基线（一~三正式偏差 + 四~五未验证偏差添加/删除 + 六第二轮新增） |
| `docs/04_ood_phase2.md` | 阶段二 OOD 设计基线 |
| `cjglm/src/detail/type_mat2x2.cj` ~ `type_mat4x4.cj` | 9 个矩阵类型实现 |
| `cjglm/src/detail/scalar_mat_ops.cj` | 标量-矩阵全局函数 |
| `cjglm/src/detail/type_vec2.cj`、`type_vec3.cj`、`type_vec4.cj` | 新增 Vec×Mat 行向量乘法 extend 块 |
| `harness/reviews/202606231847_ood_phase2_review/known_issues.md` | 已知问题对照 |

### 审查维度

按范围界定，本轮侧重三个层面：
1. 实现是否违反已有偏差（DV-01~DV-06、IF-01~IF-04、INT-01~INT-04）的修复方向
2. 实现是否引入未文档化的新偏差
3. 未验证偏差条目（DEV-04、DEV-06、DEV-07、DEV-11~DEV-14 添加；DEV-05 删除）是否已被实现

### 发现

#### [一般] DEV-15：`init(scalar: T)` 全填充构造函数未在 OOD §3.3 文档中列出

- **位置**：`type_mat2x2.cj:11`、`type_mat2x3.cj:21`、`type_mat2x4.cj:21`、`type_mat3x2.cj:24`、`type_mat3x3.cj:24`、`type_mat3x4.cj:24`、`type_mat4x2.cj:27`、`type_mat4x3.cj:27`、`type_mat4x4.cj:27`
- **描述**：9 个矩阵类型均提供非 const 的 `public init(scalar: T)` 构造函数，函数体将所有列向量填为 `VecN(scalar, scalar, ...)`（全填充）。该构造函数在 OOD §3.3 "构造函数体系" 清单（item 1-8）中未列出，且 OOD §9 "对齐 GLM 参考实现的差异声明" 也未提及。OOD §9 仅说明 "无 init() 默认构造 — 改为 identity(one) 工厂函数"，但这是指无参默认构造，与单参数 `init(scalar: T)` 不同。
- **影响**：实现与 OOD 文档存在不一致 — 测试（如 `cjglm/tests/glm/test_integration_matrix.cj`）和实现实际大量使用此构造（如 `Mat4x4(Float32(1.0))`、`Mat3x3(Float32(1.0))`），但 OOD 设计未将其列为正式构造函数。该构造的语义（**全填充**）与 §3.3 item 3 中的 `diagonal(scalar)` 工厂（**对角填充**）不同，构成两个独立 API。属"实现功能正确但 OOD 文档未跟进"的偏差。
- **建议**：在 deviations.md 新增 DEV-15 条目，明确 `init(scalar: T)` 为 9 个矩阵类型提供的全填充构造函数（语义对应 C++ GLM 的 `mat(T s)` 全填充构造），并解释 OOD §3.3 清单未列出的原因（属于"实现扩展未同步到设计文档"类偏差）。

#### [一般] DEV-16：`init(scalar: T)` 与 `diagonal(scalar)` 语义不同但 OOD §9 描述存在歧义

- **位置**：`docs/04_ood_phase2.md` §9 "diagonal 为工厂函数（曾用名 filled）" 一行
- **描述**：OOD §9 第 22 行声明 "diagonal 为工厂函数（曾用名 filled）...对所有 9 个矩阵类型均提供（与 GLM 1.0.3 对所有 9 个矩阵类型均提供 `mat(T s)` 构造函数一致）"。但 OOD §3.3 item 3 已明确 `diagonal(scalar)` 为**对角填充**（"对角线元素使用 scalar，非对角线元素使用 T(0)"），与 C++ GLM `mat(T s)` 的**全填充**语义不同。实现同时提供 `diagonal(scalar)`（对角填充）和 `init(scalar: T)`（全填充），后者才是真正等价于 GLM `mat(T s)` 的构造。
- **影响**：OOD §9 的描述具有误导性 — 读者可能误以为 `diagonal(scalar)` 就是 GLM 的全填充构造，但实际该函数仅做对角填充。全填充功能由未文档化的 `init(scalar: T)` 提供。
- **建议**：在 DEV-15 草案中一并说明此歧义（OOD §9 中关于 `diagonal` 等价于 GLM `mat(T s)` 的描述应改为 "GLM `mat(T s)` 在仓颉中由未文档化的 `init(scalar: T)` 提供；`diagonal(scalar)` 是独立的对角填充工厂函数，与 GLM 行为不同"）。

#### [轻微] K1 已知问题确认：`init(scalar: T)` 在 Mat2x2 中位置不一致

- **位置**：`type_mat2x2.cj:11`（与 8 个矩阵类型顺序相反）
- **描述**：在 Mat2x2 中 `init(scalar: T)` 位于两个 `const init(...)` 之前（line 11 vs line 16、21），其余 8 个矩阵类型均为 `const init(分量)` → `const init(列向量)` → `init(scalar)` 的顺序。已记录于 known_issues.md K1，状态未变更。
- **影响**：纯风格差异，不影响功能；本轮审查仅确认问题状态。
- **建议**：保持现状，本轮无新增动作。

#### [轻微] K2 已知问题确认：fromMat 6a/6b 纯收缩方向 `let zero = ...` 未使用

- **位置**：9 个矩阵类型 fromMat 6a/6b 重载中的纯收缩方向（如 `type_mat2x3.cj:149` 等）
- **描述**：纯收缩方向的 fromMat 6a/6b 重载函数体内声明了 `let zero = ...` 变量但未使用。已记录于 known_issues.md K2，状态未变更。
- **影响**：纯收缩方向产生未使用局部变量；保持 144 个重载使用同一函数体模板的代码生成可维护性收益 > 此风格损失。
- **建议**：保持现状，本轮无新增动作。

### 重点问题逐项核查

#### 1. `init(scalar: T)` 全填充构造函数是否需要新增偏差

**结论**：✅ 是 — 见 [一般] DEV-15 和 DEV-16。9 个矩阵类型均提供此构造，但 OOD §3.3 未列入。属实现未文档化偏差，建议新增 DEV-15/DEV-16。

#### 2. DV-01 `fromBoolVec` 模式扩展 — 阶段二 `identity(one)` / `diagonal(scalar)` 是否一致遵循

**结论**：✅ 一致 — 阶段二未引入 `fromBoolVec` 相关 API，但 `identity(one: T)` 和 `diagonal(scalar: T)` 的 `one` / `scalar` 参数模式与 DV-01 的"显式传零/壹值"精神一致 — 两者均要求调用方提供 `one: T` 或 `scalar: T` 标量值，避免在 `Number<T>` 泛型上下文中尝试 `T(1)` 构造（不可用）。DV-01 不需要扩展。

具体验证（位置：`type_mat2x2.cj:121-126`）：
- `diagonal(scalar: T)`：`let zero = scalar - scalar`（在 `Number<T>` 约束下演算 T(0)）
- `identity(one: T)`：`diagonal(one)` 内部委托

两者均遵循"接收标量参数 + Number<T> 演算 T(0)"的统一策略，与 OOD §3.3 item 3/8 设计一致。

#### 3. INT-01 "运算符全部在带约束的 extend 块中" — 阶段二实现是否一致遵循

**结论**：✅ 一致 — 9 个矩阵类型的所有算术运算符（一元 `-`、矩阵±标量、矩阵±矩阵、矩阵×矩阵、矩阵×向量、矩阵/矩阵）均定义在 `extend<T, Q> MatNxM<T, Q> where T <: Number<T>, Q <: Qualifier` 块中，比较运算符定义在 `where T <: Equatable<T>` 或 `where T <: Number<T> & Equatable<T> & Comparable<T>` 块中。验证位置：
- `type_mat2x2.cj:49` (算术 extend 块起点)
- `type_mat4x4.cj:61` (算术 extend 块起点)
- 9 个文件中均使用 `where T <: Number<T>, Q <: Qualifier` 统一约束

未发现违反 INT-01 的实现。stage one 的 INT-01 模式在阶段二矩阵类型上一致延续。

#### 4. `@Derive[Hashable]` 是否影响 INT-02/INT-03 模式

**结论**：✅ 不影响 — 9 个矩阵类型均添加 `@Derive[Hashable]` 标注（`type_mat2x2.cj:6` 等），此为派生宏，不涉及 INT-02（ComputeEqual 拆分）或 INT-03（fwd.cj 命名空间导入）模式。

验证：
- INT-02：阶段二矩阵类型的 `==` / `equalExact` 仍定义在 `where T <: Equatable<T>` 块中（`type_mat2x2.cj:249`），`equalEpsilon` 仍定义在 `where T <: Number<T> & Equatable<T> & Comparable<T>` 块中（`type_mat2x2.cj:265`），委托 `ComputeEqual<T>.call` 和 `ComputeEqualNumeric<T>.callConst` — 模式与阶段一 Vec 类型一致。
- INT-03：`fwd.cj` 使用 `import glm.detail` + `detail.MatNxM<...>` 限定访问（验证：`fwd.cj:327` `public type Mat2x2 = detail.Mat2x2<Float32, detail.PackedHighp>`），未引入 `import glm.detail.{ Mat2x2, ... }` 名称导入，模式与阶段一一致。

`@Derive[Hashable]` 自动派生是基于数据成员的逐字段哈希计算，与 ComputeEqual/ComputeEqualNumeric 结构体无冲突。

#### 5. DV-04 `isIec559Of` / `epsilonOf` 是否被阶段二引用

**结论**：✅ 未引用，符合预期 — 阶段二矩阵类型未使用 epsilon 容差比较。验证：grep `isIec559Of|epsilonOf` 在 `type_mat*.cj` 中无匹配。`equalEpsilon` 函数委托 `ComputeEqualNumeric<T>.callConst`，后者在阶段一已实现，不依赖 `isIec559Of` / `epsilonOf`。

DV-04 描述的 epsilon 容差函数不属于阶段二范围，矩阵类型的 `equalEpsilon` 实现未违反 DV-04 修复方向。

#### 6. DEV-11 `increment()` / `decrement()` 偏差与阶段二矩阵相关性

**结论**：✅ 无影响 — 阶段二矩阵类型未提供 `increment` / `decrement` 函数（grep `increment|decrement` 在 `type_mat*.cj` 中无匹配）。DEV-11 仅与阶段一 Vec 类型相关，不影响阶段二矩阵。无需在 deviations.md 中对 DEV-11 做额外操作。

#### 7. DEV-12 多分量组合构造函数缺失与阶段二矩阵相关性

**结论**：✅ 无影响 — DEV-12 仅涉及 Vec 类型多分量组合构造函数缺失，与阶段二矩阵无关。矩阵类型的多分量构造（OOD §3.3 item 1 逐分量同类型构造、`init(scalar: T)` 全填充）已完整覆盖。DEV-12 不需为矩阵新增条目。

#### 8. DEV-13 `increment`/`decrement` 仅整数可用与阶段二矩阵相关性

**结论**：✅ 无影响 — 与 DEV-11 同因，矩阵类型不提供 `increment` / `decrement`，DEV-13 仅约束 Vec 类型的 increment/decrement。无需矩阵相关条目。

#### 9. DEV-14 `castVecN` 填充策略与阶段二矩阵相关性

**结论**：✅ 无影响 — DEV-14 记录的是 `castVecN`（Vec 跨类型转换函数）低维→高维填充策略偏差。阶段二矩阵类型提供独立的 `fromMat` 系列函数（6a/6b/7），使用不同的填充规则（OOD §3.3 item 6: 列扩展 / 行扩展规则），与 `castVecN` 语义不同。两者属独立 API，不存在偏差迁移问题。

### 未验证偏差条目实现状态核查

| 偏差编号 | 状态 | 描述 | 阶段二是否实现 |
|---------|------|------|--------------|
| DEV-04 | 未验证的添加 | fromBoolVec 测试无法验证 T(1)/T(0) 原始转换语义 | 不适用 — 阶段二未涉及 fromBoolVec 测试 |
| DEV-06 | 未验证的添加 | 跨类型向量转换需 castVecN 函数 | 不适用 — castVecN 属阶段一范围，阶段二矩阵未引用 |
| DEV-07 | 未验证的添加 | increment/decrement 使用演算式 `-!0` 代替字面量 1 | 不适用 — 阶段二矩阵不提供 increment/decrement |
| DEV-11 | 未验证的添加 | increment()/decrement() 为 mut 函数返回 Unit 而非新向量 | 不适用 — 阶段二矩阵不提供此函数 |
| DEV-12 | 未验证的添加 | 多分量组合构造函数全部缺失 | 不适用 — 阶段二矩阵不涉及 |
| DEV-13 | 未验证的添加 | increment/decrement 仅整数可用 | 不适用 — 阶段二矩阵不提供 |
| DEV-14 | 未验证的添加 | castVecN 低维→高维填充策略与 C++ GLM 不同 | 不适用 — 阶段二矩阵使用 fromMat 而非 castVecN |
| DEV-05 | 未验证的删除 | DV-02 中 mod 函数可用性描述不再准确 | 不适用 — DEV-05 涉及 scalar_vec_ops.cj 浮点 mod 重载，与阶段二矩阵无关。阶段二未修改 scalar_vec_ops.cj |

**结论**：阶段二矩阵实现未引入任何未验证偏差条目（DEV-04、06、07、11~14）的实现。所有这些条目均属阶段一范围或其与矩阵无关，未在阶段二代码中触发。

### 一、仓颉限制导致功能无法实现（IF-01~IF-04）影响核查

| 偏差编号 | 影响核查 |
|---------|---------|
| IF-01 一元 + 运算符 | 阶段二矩阵类型不涉及（OOD §8 已说明无 ++/-- 运算符）。无影响。 |
| IF-02 标量-向量 const 限制 | 阶段二矩阵类型的 scalar_mat_ops.cj 函数（add/sub/mul/div 各 9 重载）均为运行时函数，不声明 const。与 IF-02 修复方向一致。无影响。 |
| IF-03 componentAt const 限制 | 阶段二矩阵类型不提供 componentAt（OOD §3.4 仅提供 `[]` 和 `col()`，均非 const）。无影响。 |
| IF-04 Bool 向量逻辑取反 | 阶段二矩阵类型不涉及 Bool 向量。无影响。 |

### 二、接口/行为有偏差（DV-01~DV-06）影响核查

| 偏差编号 | 阶段二是否引用 | 是否违反修复方向 |
|---------|--------------|----------------|
| DV-01 fromBoolVec 额外零值/壹值 | 否（阶段二矩阵不提供 fromBoolVec） | N/A |
| DV-02 % 取模仅整数 | 否（矩阵类型不定义 % 运算符） | N/A |
| DV-03 移位右操作数 Int64 | 否（矩阵类型不定义移位运算） | N/A |
| DV-04 isIec559Of/epsilonOf 需 hint | 否（阶段二矩阵未引用，详见上文） | N/A |
| DV-05 == 精确比较 / equalEpsilon 非 const | 否（但矩阵类型提供等价的 == 和 equalEpsilon，行为与 DV-05 描述一致） | 无违反 |
| DV-06 Bool 向量逻辑运算具名函数 | 否（矩阵类型不涉及） | N/A |

### 三、内部区别（INT-01~INT-04）影响核查

| 偏差编号 | 阶段二是否遵循 |
|---------|--------------|
| INT-01 运算符全部在带约束的 extend 块中 | ✅ 完全遵循（验证位置：`type_mat2x2.cj:49`、`type_mat4x4.cj:61` 等） |
| INT-02 ComputeEqual 拆分 | ✅ 矩阵类型 == 使用 `ComputeEqual<T>.call`、equalEpsilon 使用 `ComputeEqualNumeric<T>.callConst`（验证：`type_mat2x2.cj:251,267`） |
| INT-03 fwd.cj 使用命名空间导入 | ✅ `fwd.cj` 矩阵别名使用 `detail.MatNxM<...>` 限定访问（验证：`fwd.cj:327,331,335`） |
| INT-04 equalEpsilon 委托 ComputeEqualNumeric.callConst | ✅ 矩阵类型 equalEpsilon 同样委托（验证：`type_mat2x2.cj:267`、`type_mat4x4.cj:185`） |

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 0 |
| 一般 | 2 |
| 轻微 | 2 |

### 总评

阶段二实现与现有 deviations.md 偏差记录的一致性**良好**。DV-01~DV-06、IF-01~IF-04、INT-01~INT-04 在阶段二矩阵实现中均未被违反，未验证偏差条目（DEV-04、06、07、11~14 添加；DEV-05 删除）均不适用于阶段二矩阵范围。

唯一需要新增的偏差条目是 **`init(scalar: T)` 全填充构造函数**：9 个矩阵类型均实现此构造（语义对应 C++ GLM 的 `mat(T s)`），但 OOD §3.3 构造函数清单和 §9 偏差声明均未明确记录。OOD §3.3 item 3 的 `diagonal(scalar)` 是对角填充（与全填充不同），二者并存。建议在 deviations.md 新增 DEV-15 条目明确此实现扩展，避免后续文档漂移。

其余检查项（DV-04 `isIec559Of`/`epsilonOf` 未引用、`@Derive[Hashable]` 不影响 INT-02/INT-03、DEV-11~DEV-14 与矩阵无关等）均确认无偏差冲突，阶段二实现可安全合并。

## 偏差文档更新建议

### 建议添加的新偏差

#### DEV-15：9 个矩阵类型均提供 `init(scalar: T)` 全填充构造函数，OOD §3.3 未列入

**C++ GLM 行为**

```cpp
mat4x4 m(2.0f);  // 全填充：所有 16 个元素均为 2.0f
mat3x2 m(1.5);   // 全填充：所有 6 个元素均为 1.5
```

GLM 对所有 9 个 `mat(C,R,T,Q)` 类型均提供 `mat(T s)` 单参数构造函数，将所有分量填充为标量值 `s`。

**仓颉 GLM 行为**

每个矩阵结构体内提供非 const `public init(scalar: T)` 构造函数，将所有列向量的每个分量填充为 scalar 值（**全填充**）：

```cangjie
// type_mat2x2.cj:11
public init(scalar: T) {
    this.c0 = Vec2(scalar, scalar)
    this.c1 = Vec2(scalar, scalar)
}

// type_mat4x4.cj:27
public init(scalar: T) {
    this.c0 = Vec4(scalar, scalar, scalar, scalar)
    this.c1 = Vec4(scalar, scalar, scalar, scalar)
    this.c2 = Vec4(scalar, scalar, scalar, scalar)
    this.c3 = Vec4(scalar, scalar, scalar, scalar)
}
```

调用示例（被测试广泛使用，如 `cjglm/tests/glm/test_integration_matrix.cj:32`）：

```cangjie
let m = Mat4x4(Float32(1.0))  // 全 16 个元素为 1.0f
```

**OOD 设计文档未记录此构造函数**

OOD §3.3 "构造函数体系"（item 1-8）列举了 8 类构造函数（逐分量同类型、列向量、diagonal、fromParts、fromColumns、fromMat 6a/6b/7、identity），但未列出 `init(scalar: T)`。OOD §9 仅声明 "无 init() 默认构造 — 改为 identity(one) 工厂函数"，但这是指**无参默认构造**（与 GLM 的 `mat()` 不同），与单参数 `init(scalar: T)` 是两个不同的构造。

**与 `diagonal(scalar)` 的区别**

`init(scalar: T)` 与 OOD §3.3 item 3 的 `diagonal(scalar: T)` 工厂函数是**两个独立 API**：

| 函数 | 语义 | 对角线元素 | 非对角线元素 |
|------|------|----------|------------|
| `init(scalar: T)` | **全填充** | scalar | scalar |
| `diagonal(scalar: T)` | **对角填充** | scalar | T(0) |

两者在标量值相同时（如 `init(1.0)` vs `diagonal(1.0)`）产生完全不同的矩阵结果。`init(1.0)` 得到全 1 矩阵；`diagonal(1.0)` 得到单位矩阵。

**OOD §9 描述的歧义**

OOD §9 "diagonal 为工厂函数（曾用名 filled）...与 GLM 1.0.3 对所有 9 个矩阵类型均提供 `mat(T s)` 构造函数一致" 的描述具有误导性。`diagonal(scalar)` 仅做对角填充，与 GLM `mat(T s)` 的全填充语义不同。GLM `mat(T s)` 在仓颉中的等价物是**未在 OOD 中正式记录**的 `init(scalar: T)`，而非 `diagonal(scalar)`。

| 项目 | 内容 |
|------|------|
| **建议分类** | 二、接口/行为有偏差（OOD 文档与实现不一致） |
| **涉及文件** | `type_mat2x2.cj:11`、`type_mat2x3.cj:21`、`type_mat2x4.cj:21`、`type_mat3x2.cj:24`、`type_mat3x3.cj:24`、`type_mat3x4.cj:24`、`type_mat4x2.cj:27`、`type_mat4x3.cj:27`、`type_mat4x4.cj:27` |
| **关联偏差** | 无（新偏差） |
| **表现** | 9 个矩阵类型提供 `init(scalar: T)` 全填充构造函数（语义对应 C++ GLM `mat(T s)`），但 OOD §3.3 构造函数清单未列出。`diagonal(scalar)` 是独立的对角填充函数。两者并存，但文档未明确区分 |
| **影响** | 用户使用 `Mat4x4(1.0)` 得到的矩阵元素全为 1（**全填充**），而非对角矩阵（**对角填充**）。OOD §3.3 与实际实现的差异可能导致后续维护者误解 |
| **证据** | 9 个 type_mat*.cj 文件中均有 `init(scalar: T)` 实现；测试文件 `test_integration_matrix.cj` 等大量使用此构造（`Mat4x4(Float32(1.0))` 等）。OOD §3.3 item 1-8 未包含此构造 |
| **验证次数** | 3 |

**建议写入正文草案**

> 9 个矩阵类型（Mat2x2 ~ Mat4x4）均提供非 const 的 `init(scalar: T)` 构造函数，语义为将所有分量填充为 scalar 值（全填充），对应 C++ GLM 的 `mat(T s)` 构造函数。该构造函数在 OOD §3.3 "构造函数体系" 清单中未列出。需注意与 `diagonal(scalar: T)` 工厂函数的区别：前者全填充，后者仅对角线填 scalar、其余填 T(0)。OOD §9 中关于 `diagonal` 等价于 GLM `mat(T s)` 的描述有歧义 — 实际等价物是 `init(scalar: T)`。建议在 OOD §3.3 中新增 item 9 "全填充构造 init(scalar: T)"，明确区分两个 API。

### 建议删除的偏差

无。

阶段二实现未触发任何已有偏差条目的删除条件。DEV-05（DV-02 mod 函数可用性描述修订）涉及 scalar_vec_ops.cj 的浮点 mod 重载，阶段二未修改该文件，DEV-05 的删除条件未在本阶段触发（属阶段一范围遗留）。