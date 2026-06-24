# 诊断报告：OOD Phase2 Review 问题定位（修订版 v8）

> 报告日期：2026-06-24
> 诊断范围：requirement.md 中列出的全部 T1~T19 问题
> 修订：基于第 8 轮审查质询修正（v7 诊断报告的审查反馈）

---

## 1. 阻塞合并问题

### T5: `testIntegrationFromMatDeviation` 预期值与 OOD/实现相反

**严重度**：严重（CI 阻塞）

**根因定位**：

`testIntegrationFromMatDeviation`（`test_integration_matrix.cj:330-344`）构造 `Mat4x2(Float32(1..8))` 后调用 `Mat4x4.fromMat(src, Float32(1.0))`，在 `:338-341` 行断言 `m44.c2.x=5.0`、`m44.c2.y=6.0`、`m44.c3.x=7.0`、`m44.c3.y=8.0`，即期望**保留源矩阵列 2/3 的前两行数据**。

**因果链**：
1. OOD §3.3 第 347 行明确标注 `Mat4x4←Mat4x2` 为 🚨**DEVIATION**——GLM 1.0.3 `type_mat4x4.inl:246` 对列 2/3 使用 `col_type(0,0,1,0)` 和 `col_type(0,0,0,1)`，丢弃源矩阵列 2/3 的前两行数据
2. OOD §3.3 偏差详情（第 347-348 行）再次确认：编码阶段须针对 Mat4x4←Mat4x2 实现特殊处理（丢弃源数据、填入单位矩阵对角线值）
3. `type_mat4x4.cj:235-239`（6a）的实际实现正确遵循 DEVIATION——列 2 为 `Vec4(zero, zero, one, zero)`、列 3 为 `Vec4(zero, zero, zero, one)`
4. `type_mat4x4.cj:287-291`（6b）同样正确遵循 DEVIATION
5. `test_type_mat4x4.cj:633-653`（6a 单元测试）和 `:837-857`（6b 单元测试）均正确验证 DEVIATION 行为

**证据**：
- 实现（6a `:238`）：`Mat4x4(Vec4<T, Q>(m.c0.x, m.c0.y, zero, zero), Vec4<T, Q>(m.c1.x, m.c1.y, zero, zero), Vec4<T, Q>(zero, zero, one, zero), Vec4<T, Q>(zero, zero, zero, one))`
- 单元测试 6a（`:637-652`）：预期 `c2.x=0, c2.y=0, c2.z=1, c2.w=0, c3.x=0, c3.y=0, c3.z=0, c3.w=1`
- 单元测试 6b（`:850-857`）：预期同上（Float64 跨类型版本）

**结论**：集成测试的预期值是错误的。它不应断言 `c2.x=5.0, c2.y=6.0, c3.x=7.0, c3.y=8.0`，而应断言 `c2.x=0, c2.y=0, c2.z=1, c2.w=0, c3.x=0, c3.y=0, c3.z=0, c3.w=1`（与单元测试一致）。集成测试编写时未考虑 OOD 声明的 DEVIATION，直接按"主规则"（保留源数据）构造了预期值。

**修复前验证要求**：在修改预期值之前，必须独立确认 OOD DEVIATION 描述与 GLM 1.0.3 真实行为一致。GLM 1.0.3 `type_mat4x4.inl:246-257` 中 `mat<4,4,T,Q>::mat(mat<4,2,T,Q> const& m)` 的初始化列表为：
- `col_type(m[0], 0, 0)` — 前 2 行保留源列 0 数据
- `col_type(m[1], 0, 0)` — 前 2 行保留源列 1 数据
- `col_type(0, 0, 1, 0)` — 完全丢弃源列 2 数据
- `col_type(0, 0, 0, 1)` — 完全丢弃源列 3 数据

确认此行为后，将 `testIntegrationFromMatDeviation` 第 338-341 行的预期值修改为与 `test_type_mat4x4.cj:645-652`（单元测试）一致。

**影响范围**：
- `testIntegrationFromMatDeviation` 当前在 CI 中必然失败 4 个 `@Expect`（`:338-341`）
- 阻塞所有合并

---

### T6: 补充非方阵标量-矩阵测试

**严重度**：严重（覆盖率缺口 > 66%，与 T5 同为阻塞合并项）

**根因定位**：

`test_scalar_mat_ops.cj` 覆盖 OOD §3.5 规定的 36 个全局函数（4 运算 × 9 矩阵类型）中的仅 12 个（3 方阵 × 4 运算）。

**具体缺口**：

| 运算 | 缺失的非方阵类型 | 缺口数 |
|------|-----------------|--------|
| add | Mat2x3/2x4/3x2/3x4/4x2/4x3 | 6 |
| sub | Mat2x3/2x4/3x2/3x4/4x2/4x3 | 6 |
| mul | Mat2x3/2x4/3x2/3x4/4x2/4x3 | 6 |
| div | Mat2x3/2x4/3x2/3x4/4x2/4x3 | 6 |

总计：**24/36 = 66.7% 覆盖率缺口**。

**风险**：非方阵的标量运算展开公式与方阵结构相同（逐元素操作），但行/列参数错误（如 `div(s, m)` 中 `s / m.c_j[i]` 的列/行索引写反）在当前测试套件中无法被检出。**注**：OOD §3.5 定义的 36 个全局函数不仅在 `test_scalar_mat_ops.cj` 中缺失单元测试，在 `test_integration_matrix.cj` 中也没有非方阵标量运算的集成测试覆盖。此处为知会性提示，不要求 T6 执行者采取行动——该轮检查由项目维护者在收到本诊断报告后统一审视。具体检查标准与处置方式：确认 `test_integration_matrix.cj` 中是否存在非方阵标量运算的集成测试；若不存在，评估是否需另行提交 Issue 或在后续修复中一并补充，由维护者根据阶段验收标准判断。

**证据**：
- OOD §3.5 第 623-644 行：4 运算 × 9 类型 = 36 函数
- `test_scalar_mat_ops.cj:6-192`：仅 Mat2x2/Mat3x3/Mat4x4 各 4 运算 = 12 测试
- 该文件后部的 `testScalarDivMat2x2Float32`（`:194-202`）、`testScalarDivMat2x2Float64`（`:204-212`）等属于对已有覆盖类型的浮点变体增补，不属于非方阵覆盖

**前向依赖标注**：T6 当前仅在 Int64 类型上做测试。T16（Phase 4 的 Float 类型覆盖）实施时需回头为 T6 新增的测试追加 Float 变体。

**可选优化建议**：若在 Phase 2 直接按 T16 的覆盖标准同时完成 Float 变体，可消除 T6→T16 前向依赖。**此为可选建议，非强制要求**。若选择不实施，保留 T6→T16 的前向依赖标注。

**范围膨胀量化**：若采用此方案，T6 从 24 个测试膨胀至最多 72 个（24×3 类型）。请执行者评估"一次性完成 vs 分阶段完成"的成本权衡（详见 §6 依赖图）。

> **注**：此处按 T16 最小覆盖标准（Int64/Float32/Float64）计算。若需对齐现有测试文件中的 Int32 等额外类型（如 `test_scalar_mat_ops.cj` 中部分测试已使用 Int32），实际测试数将进一步膨胀。建议与 T16 的执行者协商明确覆盖边界。

---

### T7: 补充 matrixCompMult/outerProduct 测试

**严重度**：严重（覆盖率缺口 > 66%，与 T5 同为阻塞合并项）

**根因定位**：

OOD §3.7 第 687-727 行规定 `matrix.cj` 提供 matrixCompMult（9 重载）和 outerProduct（9 重载），共 18 个可直接实现的函数。当前 `test_matrix.cj` 仅覆盖 6/18（33.3%）。

**具体缺口**：

**matrixCompMult 缺失重载（6 个）**：
- `Mat2x4`, `Mat3x2`, `Mat3x3`, `Mat3x4`, `Mat4x2`, `Mat4x3`

**outerProduct 缺失重载（6 个）**：
- `outerProduct(Vec{rows}=2, Vec{cols}=3)→Mat3x2`, `outerProduct(Vec{rows}=2, Vec{cols}=4)→Mat4x2`, `outerProduct(Vec{rows}=3, Vec{cols}=3)→Mat3x3`, `outerProduct(Vec{rows}=3, Vec{cols}=4)→Mat4x3`, `outerProduct(Vec{rows}=4, Vec{cols}=2)→Mat2x4`, `outerProduct(Vec{rows}=4, Vec{cols}=3)→Mat3x4`

**证据**：
- `test_matrix.cj:164-172`：matrixCompMult Mat2x2（已覆盖）
- `test_matrix.cj:174-185`：matrixCompMult Mat2x3（已覆盖）
- `test_matrix.cj:188-208`：matrixCompMult Mat4x4（已覆盖）
- `test_matrix.cj:211-219`：outerProduct Vec2×Vec2（已覆盖）
- `test_matrix.cj:221-232`：outerProduct Vec3×Vec2（已覆盖）
- `test_matrix.cj:234-255`：outerProduct Vec4×Vec4（已覆盖）
- `matrix.cj` 中 18 个函数实现全部存在，但对应的测试仅覆盖上述 6 个

**测试数据构造建议**：为避免执行者从零设计测试数据，以下为每个缺失重载组各提供一个代表性示例：

**matrixCompMult 代表示例**（以 Mat4x2 为例）：
- 源数据：`Mat4x2(Int64(1), Int64(2), Int64(3), Int64(4), Int64(5), Int64(6), Int64(7), Int64(8))`
- 预期值计算模式：`matrixCompMult(m1, m2)[i][j] = m1[i][j] * m2[i][j]`（逐元素乘法）
- 参考现有测试 `test_matrix.cj:164-172`（Mat2x2）的结构——使用 `@TestCase` 函数，源数据可复用与已有测试中相同元素值排列方式的构造。其余 5 个缺失重载（Mat2x4/Mat3x2/Mat3x3/Mat3x4/Mat4x3）可参照此模式，仅调整矩阵维度和对应索引范围。

**outerProduct 代表示例**（以 `Vec3→Vec4` 即 `outerProduct(Vec{rows}=3, Vec{cols}=4)→Mat4x3` 为例）：
- 源数据：`Vec3(Int64(2), Int64(4), Int64(6))`（列向量 c）和 `Vec4(Int64(1), Int64(3), Int64(5), Int64(7))`（行向量 r）
- 预期值：`Mat4x3(2,4,6, 6,12,18, 10,20,30, 14,28,42)`（列主序，`result[j][i] = c[i] * r[j]`）
- 参考现有测试 `test_matrix.cj:211-219`（Vec2×Vec2）的结构。其余 5 个缺失重载均可通过调整向量维度从本模式派生。

执行者应据此扩展至全部 12 个缺失重载，每个重载至少构造 1 个断言测试，覆盖典型 Int64 值场景。

**前向依赖标注**：T7 当前仅在 Int64 类型上做测试。T16（Phase 4 的 Float 类型覆盖）实施时需回头为 T7 新增的测试追加 Float 变体。

**可选优化建议**：若在 Phase 2 直接按 T16 的覆盖标准同时完成 Float 变体，可消除 T7→T16 前向依赖。**此为可选建议，非强制要求**。若选择不实施，保留 T7→T16 的前向依赖标注。

**范围膨胀量化**：若采用此方案，T7 从 12 个测试膨胀至最多 36 个（12×3 类型）。请执行者评估"一次性完成 vs 分阶段完成"的成本权衡（详见 §6 依赖图）。

> **注**：此处按 T16 最小覆盖标准（Int64/Float32/Float64）计算。若需对齐现有测试文件中的 Int32 等额外类型（如 `test_matrix.cj` 中部分测试已使用 Int32），实际测试数将进一步膨胀。建议与 T16 的执行者协商明确覆盖边界。

---

## 2. 偏差文档登记

### T1: DEV-15 — `init(scalar: T)` 全填充构造函数未在 OOD 登记

**严重度**：一般

**根因定位**：

OOD §3.3 明确列出 9 个矩阵类型的构造函数体系共 8 类（逐分量同类型、列向量、`diagonal(scalar)`、`fromParts`、`fromColumns`、`fromMat` 6a/6b/7、`identity`）。其中**不包含** `init(scalar: T)` 全填充构造函数。

OOD §3.3 item 3 及 §9 声明 `diagonal(scalar)`（对角填充）为 GLM `mat(T s)`（全填充）的仓颉等价物。

但实现中 9 个矩阵类型**全部额外提供** `public init(scalar: T)`（填满所有 C×R 个位置，非对角填充），并被测试用例大量使用（如 `test_type_mat4x4.cj:8` 的 `Mat4x4<Int64, Defaultp>(5)`）。

**因果链**：
1. OOD 设计时认为 `diagonal(scalar)` 已覆盖 GLM `mat(T s)` 的全部需求
2. 编码阶段发现 `diagonal(scalar)` 的对角填充语义无法满足测试"全填充初始化为同一值"的便利需求
3. 实现者添加了 `init(scalar: T)` 作为便捷构造，但未同步到设计文档 `04_ood_phase2.md`
4. 此偏差属于"实现扩展未同步到设计文档"类

**各文件中的位置**：
- `type_mat2x2.cj:11-14`（`init(scalar)` 在最前，与其他文件顺序不同——见 T7-cs）
- `type_mat2x3.cj:21-24`
- `type_mat2x4.cj:21-24`
- `type_mat3x2.cj:24-28`
- `type_mat3x3.cj:24-28`
- `type_mat3x4.cj:24-28`
- `type_mat4x2.cj:27-32`
- `type_mat4x3.cj:27-32`
- `type_mat4x4.cj:27-32`

**影响范围**：OOD 文档与实现之间存在"选择性偏差"——`deviations.md` 中 DEV-04/DEV-06/DEV-11~DEV-14 等均已记录各类偏差，但此全填充构造函数缺失。

---

### T19: OOD §9 `diagonal` 等价描述歧义

**严重度**：一般

**根因定位**：

OOD §9 声明的 "diagonal 为工厂函数...对所有 9 个矩阵类型均提供（与 GLM 1.0.3 对所有 9 个矩阵类型均提供 `mat(T s)` 构造函数一致）" 存在语义歧义：

1. `diagonal(scalar)` 的填充语义是**对角线填充**（非对角线为 T(0)）
2. GLM `mat(T s)` 的填充语义是**全填充**（所有 C×R 个位置均为 s）
3. 实现同时提供 `diagonal(scalar)`（对角填充）和 `init(scalar: T)`（全填充）
4. 只有 `init(scalar: T)` 才是真正等价于 GLM `mat(T s)` 的全填充构造

**证据**：
- `type_mat4x4.cj:131-134`：`diagonal` 实现为 `Vec4(scalar, zero, zero, zero)`、`Vec4(zero, scalar, zero, zero)` 等——明确对角填充
- `type_mat4x4.cj:27-32`：`init(scalar: T)` 实现为 `Vec4(scalar, scalar, scalar, scalar)` 等——全填充
- OOD §3.3 item 3：`diagonal(scalar)` 描述为"对角线元素使用 scalar，非对角线元素使用 T(0)"——明确对角填充

---

## 3. 代码风格与命名

### T3: Mat3x3/Mat4x4 矩阵乘法参数命名 `r` → `rhs`

**严重度**：一般

**根因定位**：

OOD §3.5 模板示例使用 `rhs` 作为矩阵-矩阵乘法右操作数参数名。9 个矩阵文件中：
- 7 个文件（Mat2x2、Mat2x3、Mat2x4、Mat3x2、Mat3x4、Mat4x2、Mat4x3）统一使用 `rhs`
- **Mat3x3**（`:91, 99, 108`）使用 `r`——3 处不一致
- **Mat4x4**（`:97, 105, 114`）使用 `r`——3 处不一致

值得注意的是，同文件内的 `/` 运算符（Mat3x3 `:118`、Mat4x4 `:124`）已使用 `rhs`，进一步说明 `r` 是偶然的不一致。

**证据**：
- `type_mat3x3.cj:91`：`public operator func *(r: Mat2x3<T, Q>)`
- `type_mat3x3.cj:99`：`public operator func *(r: Mat3x3<T, Q>)`
- `type_mat3x3.cj:108`：`public operator func *(r: Mat4x3<T, Q>)`
- `type_mat3x3.cj:118`：`public operator func /(rhs: Mat3x3<T, Q>)`（已用 `rhs`）
- `type_mat4x4.cj:97`：`public operator func *(r: Mat2x4<T, Q>)`
- `type_mat4x4.cj:105`：`public operator func *(r: Mat3x4<T, Q>)`
- `type_mat4x4.cj:114`：`public operator func *(r: Mat4x4<T, Q>)`
- `type_mat4x4.cj:124`：`public operator func /(rhs: Mat4x4<T, Q>)`（已用 `rhs`）

---

### T7-cs: Mat2x2 构造函数声明顺序不一致

**严重度**：一般

**根因定位**：

`type_mat2x2.cj` 的构造函数声明顺序为：
1. `init(scalar: T)`（`:11-14`）
2. `const init(逐分量)`（`:16-19`）
3. `const init(列向量)`（`:21-24`）

其余 8 个矩阵类型的顺序均为：
1. `const init(逐分量)`
2. `const init(列向量)`
3. `init(scalar: T)`

仓颉函数重载解析与声明顺序无关，不引发编译错误。但 9 个文件风格不一致增加维护成本。

> **推测**：Mat2x2 是最先编写的文件（2×2 结构最简单），编写时未先写 `const init`；后续文件参考了 OOD §3.3 的 item 顺序（item 1 逐分量、item 2 列向量、item 3 diagonal），但 `init(scalar)` 不属于 OOD §3.3 的任何 item（为额外添加），放在最后以最小化对已有顺序的破坏。

---

### T8: 纯收缩方向 `let zero` 无用声明

**严重度**：一般

**根因定位**：

所有 fromMat 6a 函数体以 `let zero = m.c0.x - m.c0.x` 开头（6b 使用 `let zero = one - one`）。在纯收缩方向（C_dst ≤ C_src 且 R_dst ≤ R_src）中，函数体仅做截断，**不使用** `zero` 变量。

**纯收缩方向共 27 个 6a + 27 个 6b = 54 个重载**涉及此问题。计数依据 OOD §3.3 第 385-393 行 9×9 转换矩阵表：从各源矩阵出发满足 `C_dst ≤ C_src 且 R_dst ≤ R_src`（非 EQL）的方向共 27 个（Mat2x2:0, Mat2x3:1, Mat2x4:2, Mat3x2:1, Mat3x3:3, Mat3x4:5, Mat4x2:2, Mat4x3:5, Mat4x4:8）。例如 `Mat2x2.fromMat(Mat2x3, one)`（`type_mat2x2.cj:148-152`）声明了 `let zero` 但函数体仅做 `Vec2(m.c0.x, m.c0.y)` 和 `Vec2(m.c1.x, m.c1.y)`——zero 未使用。

**编译器警告验证**：项目 `cjpm.toml` 指定 `cjc-version = "1.1.0"`。未在实际构建环境中验证 cjc 1.1.0 是否对此类未使用变量产生警告。仓颉编译器对未使用局部变量的警告行为因版本而异，且源文件中未发现 `@Suppress` 或 `@Allow` 等抑制注解。**结论标注为"未验证"**。

**决策路径指引**：从"未验证"到具体动作的决策路径如下：
1. **编译验证**：在 cjc 1.1.0 下编译项目，观察是否有 `unused variable` 警告
   - **2a) 无警告** → 无需操作，保留当前代码
   - **2b) 有警告** → 移除纯收缩方向中的 `let zero` 声明，或在对应重载中改用 `_` 前缀命名变量（如 `_zero`）以抑制警告
   - **2c) 编译错误** → 在诊断报告中标注具体错误信息及触发版本号

**其他风险**：
- 运行时存在 1 次无效减法/读取操作（性能影响极微小）
- **非阻断性**：OOD §3.3 第 286 行明确说明"纯收缩方向下 `one` 参数被忽略"，`let zero` 的情形同理。签名中保留 zero 是为了直接从 6a/6b 统一代码模板生成。

**证据**：全部 144 个重载（9 目标 × 8 源 × 2 变体）均包含 `let zero` 声明。纯收缩方向的识别可通过 OOD §3.3 的 9×9 转换矩阵表（`:383-393`）中标注为 `rowSh`、`colSh`、`colSh→rowSh` 的方向确认。

---

## 4. 测试补充

### T2: 补充 9 个矩阵类型 Hashable 测试

**严重度**：一般

**根因定位**：

9 个矩阵结构体均标注 `@Derive[Hashable]`，但 `tests/glm/detail/test_type_mat*.cj`（9 个文件）及 `test_type_mat_compare.cj` 中均未出现哈希相关测试用例。

`@Derive[Hashable]` 是编译期元编程产物，在仓颉中由编译器自动生成 `hash()` 方法。OOD §3.1 第 186 行明确要求 9 个矩阵类型通过 `@Derive[Hashable]` 自动派生哈希支持——这是必须满足的设计要求。`@Derive` 宏展开正确但生成错误的哈希逻辑（如所有矩阵哈希到相同值）在编译期无法检测，必须由运行时测试暴露。

当前无运行时验证用例无法保证：
1. `@Derive` 宏在矩阵类型的具现化（含 4 个列向量成员）上正确展开
2. `hash()` 返回值在不同元素类型（Int64/Float32/Float64/Bool）下行为一致
3. 值相等的两个矩阵产生相同的哈希值

**证据**：
- `type_mat2x2.cj:6`：`@Derive[Hashable]`
- 其余 8 个矩阵类型同样在第 1 行 struct 定义前标注 `@Derive[Hashable]`
- 所有测试文件未含 `hash` 关键字

**最小覆盖标准**：Hashable 测试应至少验证以下三类场景（每类在 1~2 个代表性矩阵类型上验证即可，无需全部 9 个类型全覆盖）：
1. **相同性一致性**：同一矩阵的两个副本（如 `let a = Mat4x4(Int64(1))` 和 `let b = Mat4x4(Int64(1))`）的 `hash()` 返回值相同——验证 `@Derive[Hashable]` 在矩阵类型上正确展开且哈希逻辑基于字段值
2. **不同值差异性**：不同值的矩阵的 `hash()` 返回值不同——验证哈希函数具备基本区分能力（如 `Mat4x4(Int64(1)).hash() != Mat4x4(Int64(2)).hash()`）
3. **跨类型编译通过**：至少以 Int64 和 Float32 两种元素类型实例化同一矩阵类型的 Hashable 测试，确认 `@Derive[Hashable]` 在不同具现化类型上均正确展开

**注意**：不要求验证哈希冲突概率或分布质量（`@Derive[Hashable]` 由编译器保证哈希分布），也不要求 Bool 矩阵的 Hashable 测试（Bool 已实现 `Hashable`，派生无风险）。**核心目标**是确认 `@Derive` 宏在矩阵结构体（含多个列向量成员）上正确展开，且不同值的矩阵产生不同哈希值。

**严重度调整说明**：v3 报告中本项评定为"轻微"。但 OOD §3.1 明确要求 9 个矩阵类型通过 `@Derive[Hashable]` 自动派生哈希支持——这是必须满足的设计要求。`@Derive` 宏展开正确但生成错误的哈希逻辑（如所有矩阵哈希到相同值）在编译期无法检测，必须由运行时测试暴露。因此从"轻微"调整为"一般"。

---

### T9: 补充 stub 测试文件的显式 import

**严重度**：一般

**根因定位**：

三个文件缺少显式 import `std.unittest.*` / `std.unittest.testmacro.*`：
- `test_common.cj:1`
- `test_geometric.cj:1`
- `test_geometric_refract.cj:1`

项目内其他测试文件（如 `test_matrix.cj:3-4`、`test_scalar_mat_ops.cj:3-4`、`test_type_mat2x2.cj:3-4`）均显式导入。

依据 `std.unittest` 文档 §1.2，测试模式下 unittest 和 unittest.testmacro 自动导入，无需显式 import。

**结论**：此问题属于代码风格一致性，不是功能性缺陷。三个 stub 测试文件可正常工作。

**修复者可行动**：添加 `import std.unittest.*` 和 `import std.unittest.testmacro.*` 以与其他测试文件风格一致。

---

### T10: 补充 stub 异常信息内容验证

**严重度**：一般

**根因定位**：

所有 stub 函数测试均使用 `@ExpectThrows[Exception](...)` 模式，但未验证异常信息是否包含"stub"标识字符串。

**仓颉测试框架适配分析**：`std.unittest` 提供的 `@ExpectThrows[ExType](expr)` 宏（及对应的 `@AssertThrows`）仅验证抛出的异常类型（`ExType`），**不提供对异常消息内容进行断言的机制**。因此无法通过单纯使用内置断言宏来验证异常消息内容。

**实现异常消息验证的具体方法**：需在测试函数中使用手动 `try-catch` 结构捕获异常后，对异常的 `.message` 属性（`Exception` 类型提供 `message: String` 只读属性，定义于标准库异常体系）进行断言。示例模式：
```
@TestCase
func testStubMessage() {
    try {
        stubFunc()
        @Fail("Expected Exception")
    } catch (e: Exception) {
        @Expect(e.message.contains("stub"), true)
    }
}
```

> **⚠ `@Fail` 与 `catch(e: Exception)` 互斥风险**：`@Fail("msg")` 内部可能抛出继承自 `Exception` 的断言失败异常（如 `AssertFailException`），该异常会被 `catch(e: Exception)` 捕获。若 `stubFunc()` 未抛出异常（即仅 `@Fail` 触发），则 `e.message` 的值为 `"Expected Exception"` 而非 `"stub"`，导致 `@Expect(e.message.contains("stub"), true)` 失败且产生误导性错误消息——测试者会看到"stub 消息未找到"而非"stubFunc() 应当抛出异常"。**规避方案**：在 `catch` 块顶部检查异常类型，区分 `AssertFailException` 与业务异常；或保持当前模式但认知此风险，在调试时优先检查 `stubFunc()` 是否实际抛出了异常。

**涉及文件与规模**：
- `test_common.cj:5-61`（12 个测试函数）
- `test_matrix.cj:258-290`（6 个测试函数）
- `test_geometric.cj:7-114`（17 个测试函数）
- `test_geometric_refract.cj:7-21`（3 个测试函数）
- **合计**：约 38 个 stub 测试函数需逐一替换为 try-catch 模式

**可复用性优化建议**：鉴于 4 个文件、约 38 个 stub 测试函数均需应用相同的 try-catch 断言模式，建议将 try-catch 模式抽取为辅助函数以避免代码重复。示例函数签名（已应用规避方案——在 catch 块首行检查异常类型）：
```
func expectStubMessage(funcBody: () => Unit): Unit {
    try {
        funcBody()
        @Fail("Expected Exception")
    } catch (e: Exception) {
        if (Type(e) == AssertFailException) {
            throw e
        }
        @Expect(e.message.contains("stub"), true)
    }
}
```
各测试函数中可简化为 `expectStubMessage({ => stubFunc() })`。此辅助函数可定义在测试工具文件（如 `test_utils.cj`）中供所有测试文件共享。

> **⚠ `@Fail`/`catch` 互斥风险同样适用于此辅助函数**：与内联模式相同，`expectStubMessage` 在 `try` 块中也使用 `@Fail`，`catch` 块首行的 `Type(e) == AssertFailException` 检查正是为了区分 `@Fail` 内部抛出的断言失败异常与业务异常，避免 `@Fail` 引发的 `AssertFailException` 被误认为 stub 异常。**此辅助函数已内置此规避方案，执行者可直接使用，无需额外处理。**

**实现文件**：`common.cj:5-16`、`geometric.cj:5-24`、`matrix.cj:167-173`，所有 stub 函数体统一为 `throw Exception("stub")`。

---

### T14: 补充 Mat3x3/Mat4x4 的 ColOutOfBounds/ColNegative 测试

**严重度**：一般

**根因定位**：

grep 确认在 9 个矩阵测试文件中，7 个文件同时提供 `ColOutOfBounds` 和 `ColNegative` 测试（Mat2x2、Mat2x3、Mat2x4、Mat3x2、Mat3x4、Mat4x2、Mat4x3），**仅 Mat3x3 和 Mat4x4 缺失**。

**证据**：
- `test_type_mat2x2.cj:88-107`：`testMat2x2ColOutOfBounds` + `testMat2x2ColNegative`
- `test_type_mat3x3.cj:75-107`：仅有 `testMat3x3IndexOutOfBounds`（`:89-97`）+ `testMat3x3NegativeIndex`（`:100-108`），**无 Col 系列**
- `test_type_mat4x4.cj:98-139`：仅有 `testMat4x4IndexOutOfBounds`（`:120-128`）+ `testMat4x4NegativeIndex`（`:131-139`），**无 Col 系列**

`col(i)` 函数委托 `this[i]` 实现（如 `type_mat4x4.cj:58`：`public func col(i: Int64): Vec4<T, Q> { this[i] }`），因此 `col()` 的越界行为与 `[]` 一致。

**预期行为说明**：从 `col()` 委托 `[]` 的实现可知，越界时 `col(i)` 的行为与 `this[i]` 完全相同——`mat.col(3)`（对 Mat3x3，索引 3 ≥ length=3）应抛出 `Exception`，与 `mat[3]` 的行为一致；`mat.col(-1)`（负索引）同样应抛出 `Exception`。

> **推测**：编写测试时认为 `col()` 已委托 `[]`，而 `[]` 已有越界测试，故省略了独立的 `col()` 越界测试。但跨 9 文件的覆盖不对称仍然存在。

---

### T15: 补充矩阵 NaN 传播行为测试

**严重度**：一般

**根因定位**：

OOD §5 第 825-829 行明确要求单元测试层覆盖 Mat×Vec/Vec×Mat 的 NaN 传播行为，包括：
1. 矩阵含 NaN 列时与不含 NaN 向量的乘法结果验证
2. 向量含 NaN 分量时与不含 NaN 矩阵的乘法结果验证
3. 全 NaN 矩阵与正常向量的乘法验证（预期全部结果为 NaN）
4. 与 GLM 1.0.3 对应实现的结果逐分量等值对照

现有 9 个矩阵单元测试文件、`test_vec_mat_mul.cj`、`test_scalar_mat_ops.cj` 均未对 NaN 输入进行任何测试。

**GLM 参考代码位置**：

Mat×Vec 乘法（Mat4x4 × Vec4）：`references/glm-1.0.3/glm/glm/detail/type_mat4x4.inl:537-582`，模板函数 `operator*(mat<4,4,T,Q> const& m, typename mat<4,4,T,Q>::row_type const& v)`。其他矩阵类型的 Mat×Vec 乘法采用类似的向量逐分量展开模式，位于各 `type_mat{N}x{M}.inl` 文件中。

Vec×Mat 乘法（Vec4 × Mat4x4）：`references/glm-1.0.3/glm/glm/detail/type_mat4x4.inl:584-596`，模板函数 `operator*(typename mat<4,4,T,Q>::col_type const& v, mat<4,4,T,Q> const& m)`，通过 `glm::dot(m[i], v)` 逐列点积实现。

矩阵-矩阵乘法（Mat4x4 × Mat4x4）：`references/glm-1.0.3/glm/glm/detail/type_mat4x4.inl:704`，模板函数 `operator*(mat<4,4,T,Q> const& m1, mat<4,4,T,Q> const& m2)`。

各类矩阵乘的 C++ 模板展开公式（通过 `operator[](i)[j]` 元素访问进行浮点算术运算）可直接与仓颉实现逐行对照，以确认 NaN 传播行为的一致性。NaN 在 IEEE 754 中通过原生 `+`、`*` 等算术运算符自然传播（任意含 NaN 的操作数产生 NaN 结果），GLM 和仓颉实现均委托底层算术运算符，因此 NaN 行为在语义上应一致。

**类型约束说明**：NaN 传播行为测试**仅适用于 Float32/Float64 浮点类型矩阵**。Int64 等整数类型不存在 NaN 概念。应在 T16（浮点类型基础覆盖）完成后执行本项，确保已建立 Float32/Float64 的矩阵实例化测试基础设施后再进行 NaN 特定验证。

**推荐矩阵类型**：根据用户需求"选取 2~3 个代表性矩阵尺寸"，推荐以下 3 个矩阵类型：
1. **Mat4x4**（全尺寸方阵，4×4）——覆盖全尺寸场景，与已有集成测试使用的源矩阵一致，便于复用测试数据
2. **Mat2x3**（最小非方阵，2 行 3 列）——覆盖行数 < 列数的最小非方阵场景，验证非方阵乘法展开公式中行列索引的正确性
3. **Mat3x2**（转置非方阵，3 行 2 列）——覆盖行数 > 列数的非方阵场景，与 Mat2x3 形成行列维度互换的对照验证

**证据**：在 `cjglm/tests/glm/detail/*.cj` 中搜索 `NaN`，仅在 `test_scalar_vec_ops.cj` 中找到，矩阵测试中无 NaN 涉及。

**实现确认**：矩阵乘法（`type_mat4x4.cj:127-129` 等）和标量运算均使用原生 `+`、`*` 等算术运算符，NaN 传播行为由硬件/运行时保证遵循 IEEE 754。当前无测试仅意味着"无人验证过"，不意味着实现有 bug。

---

### T16: 均衡矩阵测试的 T 类型参数化覆盖

**严重度**：一般

**根因定位**：

在 9 个 `test_type_mat*.cj` 文件中，绝大多数"行为断言"测试以 `Int64` 为底层类型实例化矩阵。存在 Float64 测试用例的区域仅限于跨类型转换场景（`fromParts`/`fromColumns`/`fromMat` 的 6a/6b/7 变体中的 `conv: (Int64) -> Float64` 模式），这些测试的目的在于验证类型转换函数而非 Float64 数值行为本身。

**具体表现**：
- 9 个文件中几乎找不到以 `Float32` 或 `Float64` 作为 T 的纯"行为断言"测试（构造、行列访问、算术运算）
- OOD §3.3 第 276 行：`one: T` 参数"若调用方传入 NaN，则对角填充结果将按底层数值运算自然传播 NaN"
- OOD §5 第 830-836 行：`@OverflowWrapping` 对整数类型行为可验证，但对浮点类型无意义
- OOD §4.1 阶段 2 验证标准要求"矩阵创建、行列访问、基本算术运算"完整验证——但验证均集中于 Int64

**风险**：Int64 是整数类型，与 Float32/Float64 浮点类型的行为在 NaN、Infinity、除法截断等方面存在本质差异。以 Int64 为唯一验证类型，无法保证：
1. NaN 传播在浮点类型上的正确性
2. Float32/Float64 除法精度行为
3. `-0.0`、`Infinity` 等特殊浮点值的处理

**覆盖标准与优化**：建议为每个矩阵类型（9 个）至少选择以下场景以 Float32 和 Float64 分别实例化：
- 1 个构造测试（选择代表性构造器，如 `diagonal(scalar)` 或 `init(scalar: T)`）
- 1 个列访问测试（`col(i)` 返回值与预期对照）
- 1 个算术运算测试（矩阵-矩阵乘或标量-矩阵运算，选择其中一个）

此标准与 OOD §4.1 阶段 2"矩阵创建、行列访问、基本算术运算"验证要求对齐。

**测试模式共享优化**：可利用仓颉的泛型化测试模式减少代码重复。例如将测试按矩阵**族系**（按列数分 3 组：C=2/3/4，每组内行数不同。族系 C=2 包含 Mat2x2/Mat2x3/Mat2x4，族系 C=3 包含 Mat3x2/Mat3x3/Mat3x4，族系 C=4 包含 Mat4x2/Mat4x3/Mat4x4）分组，每组内对不同矩阵类型共享相同的测试逻辑模板，仅实例化不同的类型参数。若采用此优化，覆盖标准可简化为：每族系（3 组）× 3 场景 × 2 精度 = 18 个新增测试。

**族系内共享模板可行性说明**：族系内各矩阵类型（如 C=2 组的 Mat2x2/Mat2x3/Mat2x4）共享"列数相同、行数不同"的结构特征，其测试逻辑（构造、访问、算术运算）可通过参数化列向量维度实现模板化。**此处仅给出 18 个测试的估算，族系内共享模板的具体实现复杂度需进一步评估**。

**框架约束分析**：仓颉 `std.unittest` 支持两种模板化测试模式：
  - `@Types[T in <Int64, Float64, ...>]`（§5.4）——仅参数化元素类型 T，**不能用于参数化矩阵类型本身**（如 Mat2x2 vs Mat2x3）
  - `@TestTemplate` 抽象基类（§8）——子类继承后注册为 `@Test`，父类的 `@TestCase` 方法自动继承。此模式可将通用测试逻辑（如构造、访问、算术运算）定义在基类中，每个矩阵类型创建一个子类，但不会减少测试函数数量（仍需要每个矩阵类型一个子类）
  
  综上，**18 个测试为"将族系共享模板的测试逻辑集中到基类"后的理论最小值，实际仍需每个矩阵类型一个子类（9 类）**。若改用逐类型独立方案（54 个测试 = 9 类型 × 3 场景 × 2 精度），每个测试函数独立编写，无共享逻辑但实现更直接。修复者应根据实际维护成本权衡选择。

---

### T17: 补充 `rowSh` 模式的集成测试

**严重度**：一般

**根因定位**：

集成测试覆盖了以下 fromMat 转换场景：
- `testIntegrationFromMatBClass`（`:268-279`）
- `testIntegrationFromMatColExtRowExt`（`:281-293`）
- `testIntegrationFromMatColShrink`（`:295-304`）
- `testIntegrationFromMatColExtRowShrink`（`:306-315`）
- `testIntegrationFromMatColShrinkRowExt`（`:318-328`）

OOD §3.3 9×9 转换矩阵表标注了 7 种不同模式（EQL/B/colExt/colSh/行扩展/行收缩/DEVIATION），但集成测试未覆盖仅行收缩（`rowSh`）模式。

**具体的 `rowSh` 方向**：
- `Mat2x3→Mat2x2`（`:385` 标注 `rowSh`）
- `Mat2x4→Mat2x2`（`:387` 标注 `rowSh`）
- `Mat2x4→Mat2x3`（`:387` 标注 `rowSh`）
- `Mat3x4→Mat3x3`（`:390` 标注 `rowSh`）
- `Mat4x4→Mat4x3`（`:393` 标注 `rowSh`）
- `Mat3x3→Mat3x2`（`:389` 标注 `rowSh`）
- `Mat3x4→Mat3x2`（`:390` 标注 `rowSh`）
- `Mat4x3→Mat4x2`（`:392` 标注 `rowSh`）
- `Mat4x4→Mat4x2`（`:393` 标注 `rowSh`）

**推荐方向**：`Mat4x4→Mat4x3`（OOD §3.3 9×9 转换矩阵表 `:393` 标注 `rowSh`）。

**选择理由**：
1. **最具代表性**：从全尺寸方阵（4×4）到非方阵（4×3）的行收缩路径，覆盖了"行数减 1"的基本收缩场景，且目标矩阵 `Mat4x3` 是所有 `rowSh` 方向中唯一的 4 列目标类型之一
2. **便于与已有测试对比**：已有 `testIntegrationFromMatColShrink`（`Mat4x4→Mat3x4`）和 `testIntegrationFromMatBClass`（`Mat4x4→Mat2x4`）以 `Mat4x4` 为源矩阵——新增 `Mat4x4→Mat4x3` 可用相同的 `Mat4x4(1..16)` 源数据，仅改变预期值的构造方式（截断每列末行）
3. **单一维度收缩**：`Mat4x4→Mat4x3` 仅行数变化（C=4 不变，R=4→3），是纯行收缩的最清晰示例，不混杂列变化

**建议测试数据**：使用 `Mat4x4(Float32(1.0), Float32(2.0), ..., Float32(16.0))` 作为源数据（与已有 `testIntegrationFromMatColShrink` 一致）。

**列主序布局说明**：Mat4x4 采用列主序布局（`type_mat4x4.cj:7-11`），4 列分别对应：
- `c0 = Vec4(1, 2, 3, 4)`
- `c1 = Vec4(5, 6, 7, 8)`
- `c2 = Vec4(9, 10, 11, 12)`
- `c3 = Vec4(13, 14, 15, 16)`

行收缩（R=4→3）截断每列末行，预期结果 `Mat4x3` 的 4 列构造为：
- `Vec3(1, 2, 3)`、`Vec3(5, 6, 7)`、`Vec3(9, 10, 11)`、`Vec3(13, 14, 15)`

此预期值与 `type_mat4x3.cj:197-201` 的 `Mat4x4→Mat4x3` fromMat 实现一致——该实现取每列的 `x/y/z` 分量构成 `Vec3`。

**插入位置建议**：新增测试函数应追加到 `test_integration_matrix.cj` 文件末尾（当前第 562 行之后的空行位置），紧接 `testIntegrationFromMatDeviation`（`:330-344`）之后或文件末尾均可。推荐追加到文件末尾以避免行号冲突。注意：由于 T5 和 T17 均操作 `test_integration_matrix.cj`，建议先完成 T5 修正确保文件基线一致后再实施 T17，详见 §6 推荐执行顺序中 T5→T17 的串行要求。

---

### T18: 评估 `test_vec_mat_mul.cj` 基础测试与 ZeroVec 测试的冗余度

**严重度**：一般

**根因定位**：

`test_vec_mat_mul.cj:4-91` 的 9 个基础测试与 `:96-183` 的 9 个 ZeroVec 测试使用**完全相同的矩阵数据**，仅向量值不同（非零 vs 全零）。

**覆盖重叠分析**：ZeroVec 场景的代码足迹与基础测试完全重叠——`v * m` 的展开公式在两种场景下执行相同的 `v.x * m.c0.x + v.y * m.c1.y` 等计算路径，仅因 v 的全零特性使计算结果为 0。代码覆盖无差异。

**实际价值**：ZeroVec 边界情况验证提供了额外的"语义正确性"信号——确认零向量的计算结果为零矩阵。**代码覆盖率上与基础测试无差异**。

**结论与建议**：建议**保留全部 9 个 ZeroVec 测试**。理由：
1. 维护成本极低——测试逻辑是模板化代码，新增或修改时通过参数化一次性改变全部 9 个
2. 每个矩阵类型均有独立的验证价值——零向量×任意矩阵=零矩阵是数学恒等式，不同矩阵类型（非方阵/方阵各尺寸）的计算路径中各列索引不同，9 个测试覆盖了全部 9 种列/行组合
3. 保留全部 9 个不会增加实质性的维护负担

---

## 5. API 与构建配置

### T13: 提供 cjpm 子包构建的显式验证产物

**严重度**：一般

**根因定位**：

OOD §2 第 147-171 行明确要求 cjpm 子包构建预验证的原型验证计划，共 5 个步骤：
1. 在 `src/ext/` 下创建最小测试文件 `test_ext.cj`（**未在 OOD 要求的 `src/ext/` 位置创建**）
2. 运行 `cjpm build` 确认编译通过（**未在提交中验证**）
3. 验证外部项目 `import glm.ext.test_ext.{ test_alias }` 可解析（**未在提交中验证**）
4. 若失败的回退方案——移至 `src/` 根目录改为 `package glm`（**未在提交中验证**）
5. 若方案二也失败，采用方案三（独立子模块）（**未在提交中验证**）

**已有文件**：`tests/glm/test_ext.cj`（位置：`tests/glm/` 而非 OOD 要求的 `src/ext/`）存在，包含 **16 个**使用 `ext.*` 别名的 `@Test` 测试用例（`testExtMat4x4Alias` ~ `testExtConstructAndRead`）。该文件验证了同一项目测试域内的 ext.* 包别名解析，但**不验证外部项目导入场景（T13 核心风险）**。其存在不改变步骤 1 指定的 `src/ext/test_ext.cj` 未创建及外部导入验证未执行的事实。

**当前配置**：
- `cjpm.toml`：仅有 `src-dir = "src"`，无 `package-configuration` 或 `sub-package` 配置
- `src/ext/` 下 26 个文件（18 个 `matrix_*.cj` + 8 个 `vector_*.cj`）统一声明 `package glm.ext`，依赖 `import glm.detail.*`

**风险分析**：仓颉包声明规则要求"目录名须与包名匹配"（`package/README.md §2.1`）。`src/ext/` 目录对应 `glm.ext` 子包的路由机制依赖于 cjpm 是否自动扫描 `src/` 下所有子目录。如果 cjpm 不支持此发现机制，`package glm.ext` 声明将导致编译错误——`ext/` 下的 26 个别名文件无法被外部项目正确导入。

**当前状态**：原型验证计划步骤 1~5 均未执行，无任何提交产物证明此项验证已完成。

**验证步骤指南**：

1. **创建验证文件**：在 `src/ext/` 目录下创建最小测试文件 `test_ext.cj`，内容仅为 `package glm.ext` 声明 + 一个简单导出函数（如 `public func test_alias(): Int64 { 1 }`），用于验证编译和外部导入。

2. **cjpm 子包配置模式（按优先级排列）**：

   **模式 A（优先尝试——零侵入）**：保持 `cjpm.toml` 当前配置（仅 `src-dir = "src"`），运行 `cjpm build`。若 cjpm 自动扫描 `src/` 下所有子目录并将 `src/ext/` 识别为 `glm.ext` 子包，则无需额外配置。
   - **量化成本**：约 5 分钟（创建验证文件 + 运行 `cjpm build`）
   - **预期验证耗时**：`cjpm build` 约 10-30 秒
   - **验证判定标准**：`cjpm build` 退出码为 0，无编译错误
   - **切换到模式 B 的触发条件**：cjpm build 报错，错误信息涉及 `package glm.ext` 未识别或子包路由失败
   - **验证确认步骤**：收到报错后，先在 cjpm 文档中搜索对应报错信息，确认确属子包路由问题（而非语法错误或导入路径问题），再切换到模式 B

   **模式 B（次选——显式 package-configuration）**：若模式 A 失败，需在 `cjpm.toml` 中添加 sub-package 声明：
     ```toml
     [package]
     src-dir = "src"
     
     [package.package-configuration]
     sub-package = ["ext"]
     ```
   - **量化成本**：约 10 分钟（修改 `cjpm.toml` + 重新构建 + 外部项目验证）
   - **预期验证耗时**：`cjpm build` 约 10-30 秒（含配置解析时间）
   - **验证判定标准**：`cjpm build` 退出码为 0，且外部项目可成功 `import glm.ext.test_ext.{ test_alias }`
   - **切换到模式 C 的触发条件**：模式 B 下 cjpm build 仍失败，或 `package-configuration` 语法不被 cjpm 当前版本支持
   - **验证确认步骤**：收到报错后，先在 cjpm 文档中搜索对应报错信息，确认确属 `package-configuration` 语法兼容问题（而非 `sub-package` 选项名称拼写错误或 TOML 解析错误），再切换到模式 C

   **模式 C（回退方案——移至 src/ 根目录）**：若以上均失败，将 `src/ext/` 下的 26 个文件移至 `src/`，将 `package glm.ext` 改为 `package glm`，调整内部导入路径。此方案使别名函数失去 `glm.ext` 命名空间隔离，但可确保编译通过。
   - **量化成本**：约 30 分钟（移动 26 个文件 + 修改 package 声明 + 更新内部导入 + 重新构建 + 外部项目验证）
   - **预期验证耗时**：同上，但额外包含文件操作时间
   - **验证判定标准**：构建通过，外部项目可正确导入别名
   - **⚠ 副作用——test_ext.cj 编译中断**：此方案将 `ext.*` 命名空间合并到 `glm` 下，导致 `tests/glm/test_ext.cj` 中 16 个使用 `ext.Mat4x4`、`ext.Vec4` 等别名（通过 `glm.ext` 子包）的 `@Test` 用例无法编译（`ext.*` 命名空间消失）。应对措施包括：① 若模式 C 仅作用于生产代码（`src/ext/`），独立保留 `tests/glm/test_ext.cj` 中的 `ext.*` 引用——不可行，因为 `ext.*` 命名空间的根源是 `src/ext/` 中各文件的 `package glm.ext` 声明，移动并改包后命名空间自然消失；② 将 `test_ext.cj` 同步改为引用 `glm.*` 别名（不再使用 `ext.` 前缀）；③ 或统一将 `test_ext.cj` 中的 `ext.*` 引用替换为直接导入目标别名（如 `import glm.{ Mat4x4, Vec4 }`），并删除 `ext.` 前缀。**此副作用仅影响模式 C，模式 A 和模式 B 不受影响**（模式 A/B 保留 `src/ext/` 下 `package glm.ext`，`ext.*` 命名空间保持有效）。

3. **外部项目验证**：在 `cjglm/` 同级目录创建一个临时外部项目，`cjpm.toml` 中通过 `[dependencies]` 引入本地 `glm` 路径，编写测试代码 `import glm.ext.test_ext.{ test_alias }` 并运行 `cjpm build`。

4. **验证命令**：
   ```bash
   # 步骤 2（构建验证）
   cjpm build
   
   # 步骤 3（外部导入验证）——在外部测试项目中
   cjpm build
   ```

5. **请先查阅 cjpm 文档**确认当前版本的子包路由机制，因为不同 cjpm 版本对子包的自动发现规则可能不同。

---

## 6. 跨问题依赖分析与执行顺序

以下列出各问题之间的依赖关系、共享文件及执行顺序建议，供修复者规划实施次序。

### 依赖图

```
T5 ────┐
        ├── test_integration_matrix.cj ──── T17
        │
T6 ── (前向依赖 T16：当前仅 Int64，T16 需追加 Float 变体) ──── T16
        │
T7 ── (前向依赖 T16：当前仅 Int64，T16 需追加 Float 变体) ──── T16
        │
T1 ────┐
        ├── deviations.md ──── T19
        │
T3 ── (独立，type_mat3x3/4x4.cj)
        │
T7-cs ── (独立，type_mat2x2.cj)
        │
T8 ── (独立，各 type_mat*.cj)
        │
T2 ── (独立，各 test_type_mat*.cj)
        │
T9 ── (须与 T10 串行：共享 test_common/geometric/geometric_refract.cj)
        │
T10 ── (须与 T9 串行：共享 test_common/geometric/geometric_refract.cj；
         且须与 T7 串行：共享 test_matrix.cj:258-290 与 T7 的 :163-255 为邻接范围)
        │
T14 ── (独立，test_type_mat3x3/4x4.cj)
        │
T15 ──┐
        ├── (范围重叠：均涉及浮点矩阵行为)
T16 ──┘
        │
T18 ── (独立，test_vec_mat_mul.cj)
        │
T13 ── (独立，cjpm.toml + src/ext/ 构建流程)
```

### 依赖关系说明

| 依赖 | 原因 |
|------|------|
| T6 → T16 | T6 仅在 Int64 类型上测试标量-矩阵运算。T16（Float 类型覆盖）在 Phase 4 实施时需回头为 T6 新增的非方阵测试追加 Float32/Float64 变体。**建议 Phase 2 直接按 T16 的覆盖标准同时完成 Float 变体**（即在新增非方阵测试时直接以 Int64、Float32、Float64 三种类型各测试一次），以消除返工。若采用此方案，T6 无需在依赖图中另标 →T16。 |
| T7 → T16 | T7 仅在 Int64 类型上测试 matrixCompMult/outerProduct。与 T6 同理，T16 需回头为 T7 新增的重载测试追加 Float 变体。**建议 Phase 2 直接按 T16 标准覆盖 Float 变体**，消除此前向依赖。 |
| T15 ↔ T16 | 两个问题覆盖范围有重叠——T15（NaN 传播测试）和 T16（Float 类型覆盖）均涉及使用浮点类型实例化矩阵进行测试。T16 中建议的构造/访问/算术三个基础场景中，算术运算测试可考虑复用 T15 中定义的 NaN 矩阵数据，但二者目的不同（T15 测试 NaN 传播语义，T16 测试浮点常规行为）。建议先完成 T16 建立浮点基础覆盖，再在 T15 中增加 NaN 特定验证。 |
| T5 → T17 | 两个问题均操作 `test_integration_matrix.cj`。T5 修改第 330-344 行（修复 DEVIATION 预期值），T17 在邻近位置新增 `rowSh` 测试用例。存在合并冲突风险。建议先完成 T5 修正确保 CI 不阻塞，再将 T17 内容追加至文件末尾以避免行号冲突。 |
| T1 → T19 | 两个问题均操作 `deviations.md`。T1 新增 DEV-15 条目，T19 修改 DEV-16（原 OOD §9 描述）。建议在 `deviations.md` 末尾统一追加两个偏差条目，或合并为一次提交。 |
| T9 ↔ T10 | **共享文件冲突**：T9 操作 `test_common.cj`、`test_geometric.cj`、`test_geometric_refract.cj` 添加显式 import；T10 同样操作此三个文件（共 38 个 stub 测试函数替换为 try-catch 模式）。并行执行时将产生合并冲突。**必须串行执行**，或合并为同一次提交。 |
| T7 ↔ T10 | **共享文件冲突**：T7 在 `test_matrix.cj:163-255` 新增 12 个 matrixCompMult/outerProduct 测试重载；T10 操作 `test_matrix.cj:258-290` 修改 6 个 stub 测试。T7 新增测试若超出第 255 行边界将导致 T10 所依赖的行号偏移，产生合并冲突。**建议串行执行**，或合并为同一次提交。 |

### 推荐执行顺序

按阶段划分，标注各阶段是否可以并行：

| 阶段 | 任务 | 并行？ | 原因 |
|------|------|--------|------|
| **Phase 1：解除 CI 运行时失败** | T5（修复集成测试预期值） | 该阶段仅 T5 | T5 导致 CI 必然失败（`@Expect` 运行时 4 个断言不通过），阻塞所有合并，必须优先解决。**注意**：T6/T7（覆盖率缺口 > 66%）同为阻塞合并项，但阻塞类型不同——T5 是"CI 运行时失败"（二进制构建后运行必挂），T6/T7 是"覆盖率评审阻塞"（代码覆盖率不足导致 code review 不通过）。T6/T7 归入 Phase 2 而非 Phase 1，是因为它们不影响 CI 构建/运行状态，仅在评审阶段被拒绝。两类阻塞均为合并前必须解决的问题，仅紧急程度和执行顺序不同（运行时失败优先于覆盖率缺口）。**实践指引**：若执行者希望一次性通过评审，建议在 Phase 1 后立即执行 Phase 2；否则即使 T5 修复通过 CI，Phase 2 未完成前仍无法合并。 |
| **Phase 2：严重覆盖缺口** | T6（非方阵标量测试）、T7（matrixCompMult/outerProduct 测试） | **可并行，建议直接覆盖 Float 变体** | 操作不同文件，无冲突。T6 操作 `test_scalar_mat_ops.cj`，T7 操作 `test_matrix.cj`。**建议直接在 Phase 2 中按 T16 标准覆盖 Int64 + Float32 + Float64 三种类型**，以消除 →T16 的前向依赖，避免 Phase 4 返工。**⚠ 风险评估**：此方案的前提假设是 Phase 2 执行者的 T16 覆盖标准与后续 Phase 4 执行者的 T16 标准一致。若不一致（如 Phase 2 采用最小覆盖而 Phase 4 要求更严格），Phase 2 中提前完成的 Float 变体可能需按新标准重写，反而增加返工。**约束条件**：仅当 (a) Phase 2 与 Phase 4 由同一执行者完成，或 (b) T16 覆盖标准在 Phase 2 开始前已冻结并文档化——此方案才安全。若无法满足任一条件，建议在 Phase 2 保持仅 Int64 覆盖，将 Float 变体推迟至 Phase 4。 |
| **Phase 3：偏差文档** | T1（DEV-15 登记）、T19（§9 歧义修正） | **必须串行** | 两者均操作 `deviations.md`，建议合并为一次提交。可先 T1 再 T19，或在文件末尾一次性追加两处修订 |
| **Phase 4：一般/轻微项** | 以下所有 | 大部分可并行 | 见分组说明 |

**Phase 4 分组建议**：

**组 A（可并行，独立文件）**：
- T3（Mat3x3/4x4 参数命名，操作 `type_mat3x3.cj` 和 `type_mat4x4.cj`）
- T7-cs（Mat2x2 构造函数顺序，操作 `type_mat2x2.cj`）
- T8（纯收缩 zero 声明，操作全部 9 个 `type_mat*.cj`）
- T14（Col 越界测试，操作 `test_type_mat3x3.cj` 和 `test_type_mat4x4.cj`）
- T18（保留 ZeroVec，操作 `test_vec_mat_mul.cj`，仅追加注释说明即可）
- T13（cjpm 子包验证，操作 `cjpm.toml` + 外部验证项目）

**组 C（必须串行，共享文件）**：
- **必须串行**：T9 → T10（T9 和 T10 共享 `test_common.cj`、`test_geometric.cj`、`test_geometric_refract.cj` 三个文件，并行执行会产生合并冲突。建议先 T9（添加显式 import），再 T10（替换 stub 测试为 try-catch 模式），或合并为同一次提交）
- **必须串行**：T7 → T10（T7 和 T10 共享 `test_matrix.cj`，T7 在 `:163-255` 新增 12 个测试重载，T10 在 `:258-290` 修改 6 个 stub 测试。T7 新增内容若超出第 255 行边界将导致 T10 的行号偏移。建议先 T7 再 T10，或合并为同一次提交）
- **T7 和 T9 无跨文件依赖，可按任意顺序执行，但两者均须在 T10 之前完成**

**组 B（有依赖关系，须串行）**：
- **须串行：T16 先于 T15**：T16 建立浮点类型基础覆盖（Float32/Float64 矩阵实例化基础设施），T15 在此基础上增加 NaN 特定验证。若不串行（T15 先于 T16），则 T15 的 NaN 测试无从执行（浮点矩阵类型尚未实例化）
- **须串行：T5 先于 T17**：T5 修正确保 CI 不阻塞，T17 在 `test_integration_matrix.cj` 中新增 `rowSh` 测试。为避免行号冲突，建议将 T17 测试追加到文件末尾而非插入中间

**Phase 2 补充策略说明**：若 Phase 2 实施时未能直接覆盖 Float 变体（即仍仅 Int64），则依赖图中 T6→T16、T7→T16 的前向依赖仍然有效，需在依赖图中保留标注。实施者须自行评估一次性完成与分两阶段完成的成本权衡。

### 完全可并行的问题

以下问题操作完全不同的文件，无任何合并冲突风险，可在 Phase 2/4 中并行实施：
- T6（Phase 2，操作 `test_scalar_mat_ops.cj`）
- T7（Phase 2，操作 `test_matrix.cj`，注意与 T10 共享文件须串行）
- T3、T7-cs、T8、T14、T18、T13（Phase 4，操作文件均无重叠）

---

## 修订说明（v3，保留）

| 质询意见 | 回应 |
|---------|------|
| §2.1：§6 缺乏全局修复执行优先级排序 | 已修正：在 §6 开头追加分阶段执行顺序（Phase 1~4），明确各阶段任务、并行性及原因，并在组 B 中标注 T16→T15、T5→T17 的依赖方向。 |
| §2.2：T15 未限定 NaN 仅适用于浮点类型 | 已修正：在 T15 段落末尾追加显式约束说明——"NaN 传播行为测试仅适用于 Float32/Float64 浮点类型矩阵；Int64 等整数类型不存在 NaN 概念。应在 T16 完成后执行本项。" |
| §2.3：T13 缺乏具体可操作的验证方法指南 | 已修正：在 T13 末尾补充「验证步骤指南」子章节，包含 3 种 cjpm 子包配置模式（自动发现 / 显式 package-configuration / 回退迁移）、外部项目验证方法、验证命令，并提示"先查阅 cjpm 文档确认子包路由机制"。 |
| §2.4：T5 未建议先验证 OOD DEVIATION 本身的正确性 | 已修正：在 T5 的"结论"与"影响范围"之间追加「修复前验证要求」段落，引用 GLM 1.0.3 `type_mat4x4.inl:246-257` 的具体代码，要求修复者确认 OOD DEVIATION 与 GLM 真实行为一致后再修改预期值。 |
| §2.5：T18 给出多个平行选项降低可操作性 | 已修正：从三个选项中选定唯一推荐方案——"保留全部 9 个 ZeroVec 测试"，给出 3 条具体理由（维护成本低、每类型独立验证价值、零向量×任意矩阵的恒等式验证）。 |
| §2.6：T16 覆盖标准估算未讨论测试模式共享优化 | 已修正：在 T16 中增加「测试模式共享优化」段落，提出按矩阵族系（3 组）共享测试模板的优化思路，给出 18 个新增测试的简化方案作为 54 个的替代选项。 |

## 修订说明（v4）

| 质询意见 | 回应 |
|---------|------|
| T17：推荐的 `rowSh` 方向缺失，可操作性不足 | 已修正：在 T17 段落末尾追加「推荐方向」子章节，明确推荐 `Mat4x4→Mat4x3`（OOD §3.3 `:393` 标注 `rowSh`），给出 3 条选择理由（最具代表性、便于与已有测试对比、单一维度收缩的最清晰示例），并给出建议的测试数据和预期值构造方式。 |
| T6/T7 与 T16 的前向依赖未标注 | 已修正：在 T6 和 T7 段落末尾分别追加「前向依赖标注」说明，在 §6 依赖图中增加 T6→T16、T7→T16 的前向依赖边，在依赖关系说明表中详述依赖原因和消除方案（建议 Phase 2 直接覆盖 Float 变体），并在 Phase 2 执行顺序表中追加"建议直接覆盖 Float 变体以消除返工"的补充策略说明。 |
| T2：严重度评定与 OOD 要求存在偏差 | 已修正：T2 严重度从"轻微"改为"一般"，在 T2 段落末尾追加「严重度调整说明」子章节，说明调整理由——OOD §3.1 明确要求 9 个矩阵类型通过 `@Derive[Hashable]` 自动派生哈希支持，这是必须满足的设计要求，`@Derive` 宏展开正确但生成错误的哈希逻辑在编译期无法检测，必须由运行时测试暴露。 |
| T15：未指明 NaN 测试应参考的具体 GLM 乘法函数位置 | 已修正：将 T15 中"GLM 参考代码位置"部分的描述从笼统的"`func_matrix.inl` 及 `type_mat4x4.inl`"替换为具体的模板函数名、所在文件和行号范围：Mat×Vec 乘法 `operator*(mat<4,4,T,Q> const& m, typename mat<4,4,T,Q>::row_type const& v)` 位于 `type_mat4x4.inl:537-582`，Vec×Mat 乘法 `operator*(typename mat<4,4,T,Q>::col_type const& v, mat<4,4,T,Q> const& m)` 位于 `type_mat4x4.inl:584-596`，矩阵-矩阵乘法 `operator*(mat<4,4,T,Q> const& m1, mat<4,4,T,Q> const& m2)` 位于 `type_mat4x4.inl:704`。并说明其他矩阵类型的乘法采用类似的展开模式。 |

## 修订说明（v5）

| 质询意见 | 回应 |
|---------|------|
| T16 族系分组策略表述矛盾（"行数" vs "C=2/3/4"） | 已修正：将"按行数分 3 组"改为"按列数分 3 组：C=2/3/4"，并补充具体族系内容示例（C=2 组包含 Mat2x2/Mat2x3/Mat2x4 等）；在「测试模式共享优化」段落末尾追加可行性说明，标注"族系内共享模板的具体实现复杂度需进一步评估"，提示修复者权衡 18 个（共享模板）与 54 个（逐类型独立）的选项。 |
| outerProduct 缺失重载方向描述不精确（行/列来源歧义） | 已修正：将 §1 T7 outerProduct 缺失清单的标注格式从 `Vec2×Vec3→Mat3x2` 统一改为 `outerProduct(Vec{rows}=2, Vec{cols}=3)→Mat3x2`，明确注明行数来源（c 参数长度）和列数来源（r 参数长度）。 |
| T9/T10 共享文件冲突未识别 | 已修正：在 §6 依赖图中将 T9 和 T10 从"独立"改为"须串行：共享 test_common/geometric/geometric_refract.cj"；在依赖关系表中新增 T9↔T10 行，详述共享文件清单和冲突原因；在 Phase 4 分组中将 T9 和 T10 移出组 A（可并行），新增组 C（必须串行），建议先 T9 再 T10 或合并为同一次提交；更新"完全可并行的问题"清单移除 T9/T10。 |
| T7/T10 在 test_matrix.cj 共享文件冲突未识别 | 已修正：在 §6 依赖图中将 T10 的标注补充为"且须与 T7 串行：共享 test_matrix.cj:258-290 与 T7 的 :163-255 为邻接范围"；在依赖关系表中新增 T7↔T10 行，详述行号偏移风险；在 Phase 4 组 C 中补充 T7→T10 的串行建议。 |
| T10 可复用性考虑缺失 | 已修正：在 T10 段落的「涉及文件」部分增加合计统计（约 38 个 stub 测试函数）；追加「可复用性优化建议」子章节，给出 `expectStubMessage(func)` 辅助函数签名及调用简化示例，建议定义在 `test_utils.cj` 中供所有测试文件共享。 |
| T8 缺乏决策路径指引 | 已修正：在 T8 的"编译器警告验证"段落末尾追加「决策路径指引」子章节，给出完整的三步决策树：1) 编译验证 → 2a) 无警告→无需操作；2b) 有警告→移除 `let zero` 或用 `_` 前缀命名；2c) 编译错误→标注版本号。 |
| T6/T7 严重度与实际阻塞性质不匹配 | 已修正：在 T6 和 T7 的严重度标注后追加注释"（覆盖率缺口 > 66%，与 T5 同为阻塞合并项）"，明确其阻塞合并性质，与 T5 的"严重（CI 阻塞）"标注风格一致。 |
| T6/T7 Float 变体建议属性不明确（可选 vs 强制；范围膨胀未量化） | 已修正：将 T6/T7 的「前向依赖标注」段落拆分为"前向依赖标注 + 可选优化建议 + 范围膨胀量化"三部分。新增的「可选优化建议」明确标注"**此为可选建议，非强制要求**；若选择不实施，保留 T6→T16/T7→T16 前向依赖标注"。「范围膨胀量化」给出具体数字：T6 从 24 个测试膨胀至最多 72 个（24×3 类型），T7 从 12 个测试膨胀至最多 36 个（12×3 类型）。 |
| T7-cs/T14 推测性内容 | 已修正：T7-cs 的"可能原因"段落改为引述格式（`> **推测**：...`），明确标注为推测性内容；T14 的"缺失的原因可能是..."中的推测部分同样改为引述标注。 |

## 修订说明（v6）

| 质询意见 | 回应 |
|---------|------|
| T17 预期值列主序布局错误（行主序理解导致预期值偏差） | 已修正：将 T17「建议测试数据」段落中的预期值从 `Vec3(1,2,3), Vec3(4,5,6), Vec3(7,8,9), Vec3(10,11,12)` 修正为 `Vec3(1,2,3), Vec3(5,6,7), Vec3(9,10,11), Vec3(13,14,15)`，并补充「列主序布局说明」子章节，引用 `type_mat4x4.cj:7-11` 的列定义和 `type_mat4x3.cj:197-201` 的 fromMat 实现作为证据。 |
| T10 common.cj 实现文件行数范围 5-15→5-16 | 已修正：经查阅 `common.cj`，`min` 位于第 5 行，`smoothstep` 位于第 16 行，已将范围修正为 `5-16`。 |
| T10 test_common.cj 测试函数计数 11→12 | 已修正：经验证 `test_common.cj` 包含 12 个 `@Test` 标注（testMinStub~testSmoothstepStub），已将计数从 `11` 修正为 `12`。 |
| T10 test_geometric.cj 测试函数计数 18→17 | 已修正：经验证 `test_geometric.cj` 包含 17 个 `@Test` 标注（dot×4 + cross + normalize×3 + length×3 + distance×3 + reflect×3 = 17），已将计数从 `18` 修正为 `17`。 |
| T13 test_ext.cj 测试函数计数 14→16 | 已修正：经验证 `test_ext.cj` 包含 16 个 `@Test` 标注的测试函数（testExtMat4x4Alias~testExtConstructAndRead），已将计数从 `14` 修正为 `16`。 |
| T13 三种配置模式缺乏优先级排序 | 已修正：在 T13「验证步骤指南」中将三种 cjpm 配置模式标记为"按优先级排列"，标注模式 A 为"优先尝试——零侵入"、模式 B 为"次选"、模式 C 为"回退方案"，明确降级路径。 |
| T13 缺乏量化成本与切换条件 | 已修正：为每种配置模式补充了「量化成本」（时间估计）、「预期验证耗时」、「验证判定标准」和「切换到下一模式的触发条件」。 |
| T17 缺乏影响范围行号定位 | 已修正：在 T17 末尾追加「插入位置建议」子章节，推荐将新增测试追加到 `test_integration_matrix.cj` 文件末尾（当前第 562 行之后），说明理由（避免行号冲突、便于与 T5 并行）。 |

## 修订说明（v7）

| 质询意见 | 回应 |
|---------|------|
| T8 纯收缩方向计数 60→54 偏差（§3 第 226 行声称"30 个 6a+30 个 6b=60 个重载"，实际枚举仅 27 个方向×2 变体=54 个重载） | **已修正**：将计数从 60 修正为 54（27 个 6a + 27 个 6b），并附上计数来源说明——基于 OOD §3.3 第 385-393 行 9×9 转换矩阵表逐源矩阵枚举（Mat2x2:0, Mat2x3:1, Mat2x4:2, Mat3x2:1, Mat3x3:3, Mat3x4:5, Mat4x2:2, Mat4x3:5, Mat4x4:8，合计 27）。 |
| T6/T7 Phase 归属不清晰——Phase 1 命名"解除 CI 阻塞"隐含将 T6/T7 排除，未说明"CI 阻塞"与"评审阻塞"的区分逻辑 | **已修正**：将 Phase 1 命名从"解除 CI 阻塞"改为"解除 CI 运行时失败"；在原因列中追加阻塞类型区分说明——T5 属于"CI 运行时失败"（二进制构建后运行必挂），T6/T7 属于"覆盖率评审阻塞"（代码覆盖率不满足评审要求，不影响 CI 构建/运行状态）。两类均为合并前必须解决的问题，仅紧急程度和执行顺序不同。 |
| T10 try-catch 示例代码中 `@Fail` 与 `catch(e: Exception)` 存在互斥风险——`@Fail` 宏可能抛出继承自 `Exception` 的断言失败异常，被 `catch(e: Exception)` 捕获后产生误导性失败消息 | **已修正**：在 T10 示例代码下方追加风险警告段落（`⚠ 警告` 格式），说明 `@Fail` 内部异常类型继承关系、被误捕获后的错误表现（`e.message` 为 `"Expected Exception"` 而非 `"stub"`），并给出规避方案（在 catch 块顶部检查异常类型区分 `AssertFailException` 与业务异常）。 |
| T13 模式 C 建议将 `src/ext/` 下文件移至 `src/` 并改 `package glm`，但未分析此操作对 `tests/glm/test_ext.cj` 中 16 个 `@Test` 用例（使用 `ext.*` 命名空间）的编译中断影响 | **已修正**：在模式 C 的量化成本行后追加副作用分析段落（`⚠ 副作用` 格式），详细说明 `ext.*` 命名空间消失对 `test_ext.cj` 中 16 个测试用例的影响，给出 3 种应对措施（同步改为 `glm.*` 引用、替换为直接导入后删除 `ext.` 前缀、保留模式 A/B 不受影响），并标注此副作用仅影响模式 C。 |
| T16 族系内共享模板可行性论证不足——提出按族系压缩至 18 个测试，但未验证 CangJie 测试框架是否支持跨不同向量维度的参数化测试夹具 | **已修正**：在 T16「族系内共享模板可行性说明」段落末尾追加「框架约束分析」子段落，检查 `std.unittest` 文档后得出结论：`@Types[T in ...]` 仅参数化元素类型 T、不能参数化矩阵类型本身；`@TestTemplate` 抽象基类可共享测试逻辑但不会减少测试函数数量（每类型仍需一个子类）。明确标注"18 个测试为理论最小值、实际仍需每矩阵类型一个子类（9 类）"的约束，保留 54 个逐类型独立方案作为替代选项。 |
| §6 Phase 2 建议"直接覆盖 Float 变体"以消除 T6/T7→T16 前向依赖，但未评估执行者标准不一致导致返工的风险 | **已修正**：在 Phase 2 执行顺序表的原因列中追加 `⚠ 风险评估` 段落，说明此方案的前提假设和返工风险，并给出两项**约束条件**——仅当 (a) Phase 2 与 Phase 4 由同一执行者完成，或 (b) T16 覆盖标准在 Phase 2 开始前已冻结并文档化——此方案才安全。若无法满足任一条件，建议在 Phase 2 保持仅 Int64 覆盖。 |
| T2 Hashable 测试缺乏测试用例模板——指出了 9 个矩阵类型的 Hashable 测试缺失，但未给出测试用例的编写指南（应测试 hash 一致性、冲突概率、还是仅验证编译通过？） | **已修正**：在 T2 段落中追加「最小覆盖标准」子段落，明确说明三类必须验证的场景：1) 相同矩阵副本的 hash 一致性；2) 不同值矩阵的 hash 差异性；3) Int64/Float32 跨类型编译通过。并标注不要求验证哈希冲突概率或分布质量。 |
| T14 指出 Mat3x3/Mat4x4 缺失 ColOutOfBounds/ColNegative 测试，但未说明越界时的预期行为（应验证抛出 Exception 还是返回默认值） | **已修正**：在 T14 段落中追加「预期行为说明」内容，明确 `col(i)` 越界行为与 `this[i]` 一致——`col(3)`（越界）和 `col(-1)`（负索引）均应抛出 `Exception`。 |
| T15/T16 依赖方向标注与 Phase 4 分组间的串行要求不易直观识别——组 B 标注"先 T16→后 T15"但无显式串行标记 | **已修正**：将组 B 的标题从"有依赖关系"改为"有依赖关系，须串行"，并将 T16→T15 和 T5→T17 两条依赖的标注格式从"先 X→后 Y"统一改为"**须串行：X 先于 Y**"，同时为 T16→T15 补充不串行的后果说明（T15 的 NaN 测试无从执行）。 |
| T17 插入位置"可并行"建议与 §6 串行要求自相矛盾 | **已修正**:将 §4 T17「插入位置建议」末句从"便于与 T5 并行实施"改为"建议先完成 T5 修正确保文件基线一致后再实施 T17"，与 §6 的串行建议保持一致。 |
| §6 组 C 缺少 T7 与 T9 的相对顺序指引 | **已修正**：在组 C 中新增标注"T7 和 T9 无跨文件依赖，可按任意顺序执行，但两者均须在 T10 之前完成"。 |
| T15 未按用户需求选取 2~3 个代表性矩阵类型 | **已修正**：在 T15 中追加「推荐矩阵类型」子段落，明确推荐 Mat4x4（全尺寸方阵）、Mat2x3（最小非方阵）、Mat3x2（转置非方阵），并给出各选择理由。 |
| T6/T7 Float 变体膨胀量化未考虑整数类型的额外覆盖成本 | **已修正**：在 T6 和 T7 的「范围膨胀量化」段落末尾各追加注释，说明"此处按 T16 最小覆盖标准（Int64/Float32/Float64）计算。若需对齐现有测试文件中的 Int32 等额外类型，实际测试数将进一步膨胀。建议与 T16 的执行者协商明确覆盖边界。" |
| T6 缺失集成测试层面的影响分析 | **已修正**：在 T6「风险」段落中追加一句，提示"集成测试层面是否存在同类缺口需另案审视，建议 T6 完成后检查 test_integration_matrix.cj 是否包含非方阵标量运算场景"。 |
| Phase 2 阻塞性质说明可进一步加强 | **已修正**：在 Phase 1 原因列中追加实践指引"若执行者希望一次性通过评审，建议在 Phase 1 后立即执行 Phase 2；否则即使 T5 修复通过 CI，Phase 2 未完成前仍无法合并"。 |
| T13 三种模式的切换条件可操作性仍有改善空间 | **已修正**：为模式 A→B 和模式 B→C 的触发条件各补充「验证确认步骤」，指导执行者先确认报错类型确属子包路由问题/配置语法兼容问题，而非其他类型错误，再执行切换。 |

## 修订说明（v8）

| 质询意见 | 回应 |
|---------|------|
| T7 缺失测试数据构造建议，可操作性不足 | **已修正**：在 T7「具体缺口」与「前向依赖标注」之间追加「测试数据构造建议」段落，为 matrixCompMult（以 Mat4x2 为例）和 outerProduct（以 Vec3→Vec4 为例）各提供一个代表性测试重载的数据示例和预期值构造模式，包括具体源数据、预期值计算方式和参考现有测试函数的位置，执行者可据此复制扩展到其余 10 个缺失重载。 |
| T10 expectStubMessage 辅助函数未应用 @Fail/catch 互斥风险的规避方案 | **已修正**：在「可复用性优化建议」的辅助函数示例中添加了类型区分逻辑——`catch` 块首行 `if (Type(e) == AssertFailException) { throw e }`，并在示例后追加风险警告说明此辅助函数已内置规避方案，执行者可直接使用。 |
| T6 集成测试缺口检查指令可操作性不足 | **已修正**：将 T6「风险」段落中模糊的"建议 T6 完成后检查 `test_integration_matrix.cj` 是否包含非方阵标量运算场景"改为明确的知会性提示，补充具体检查标准和后续处置方式："确认是否存在...若不存在，评估是否需要另行提交 Issue...由维护者根据阶段验收标准判断"，使执行者清楚此提示为知会性而非行动项。 |
