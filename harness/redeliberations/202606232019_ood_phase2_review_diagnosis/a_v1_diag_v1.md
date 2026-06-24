# 诊断报告：OOD Phase2 Review 问题定位

> 报告日期：2026-06-23
> 诊断范围：requirement.md 中列出的全部 T1~T19 问题

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

**影响范围**：
- `testIntegrationFromMatDeviation` 当前在 CI 中必然失败 4 个 `@Expect`（`:338-341`）
- 阻塞所有合并

---

### T6: 补充非方阵标量-矩阵测试

**严重度**：严重

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

**风险**：非方阵的标量运算展开公式与方阵结构相同（逐元素操作），但行/列参数错误（如 `div(s, m)` 中 `s / m.c_j[i]` 的列/行索引写反）在当前测试套件中无法被检出。

**证据**：
- OOD §3.5 第 623-644 行：4 运算 × 9 类型 = 36 函数
- `test_scalar_mat_ops.cj:6-192`：仅 Mat2x2/Mat3x3/Mat4x4 各 4 运算 = 12 测试
- 该文件后部的 `testScalarDivMat2x2Float32`（`:194-202`）、`testScalarDivMat2x2Float64`（`:204-212`）等属于对已有覆盖类型的浮点变体增补，不属于非方阵覆盖

---

### T7: 补充 matrixCompMult/outerProduct 测试

**严重度**：严重

**根因定位**：

OOD §3.7 第 687-727 行规定 `matrix.cj` 提供 matrixCompMult（9 重载）和 outerProduct（9 重载），共 18 个可直接实现的函数。当前 `test_matrix.cj` 仅覆盖 6/18（33.3%）。

**具体缺口**：

**matrixCompMult 缺失重载（6 个）**：
- `Mat2x4`, `Mat3x2`, `Mat3x3`, `Mat3x4`, `Mat4x2`, `Mat4x3`

**outerProduct 缺失重载（6 个）**：
- `Vec2×Vec3→Mat3x2`, `Vec2×Vec4→Mat4x2`, `Vec3×Vec3→Mat3x3`, `Vec3×Vec4→Mat4x3`, `Vec4×Vec2→Mat2x4`, `Vec4×Vec3→Mat3x4`

**证据**：
- `test_matrix.cj:164-172`：matrixCompMult Mat2x2（已覆盖）
- `test_matrix.cj:174-185`：matrixCompMult Mat2x3（已覆盖）
- `test_matrix.cj:188-208`：matrixCompMult Mat4x4（已覆盖）
- `test_matrix.cj:211-219`：outerProduct Vec2×Vec2（已覆盖）
- `test_matrix.cj:221-232`：outerProduct Vec3×Vec2（已覆盖）
- `test_matrix.cj:234-255`：outerProduct Vec4×Vec4（已覆盖）
- `matrix.cj` 中 18 个函数实现全部存在，但对应的测试仅覆盖上述 6 个

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

**可能原因**：Mat2x2 是最先编写的文件（2×2 结构最简单），编写时未先写 `const init`；后续文件参考了 OOD §3.3 的 item 顺序（item 1 逐分量、item 2 列向量、item 3 diagonal），但 `init(scalar)` 不属于 OOD §3.3 的任何 item（为额外添加），放在最后以最小化对已有顺序的破坏。

---

### T8: 纯收缩方向 `let zero` 无用声明

**严重度**：一般

**根因定位**：

所有 fromMat 6a 函数体以 `let zero = m.c0.x - m.c0.x` 开头（6b 使用 `let zero = one - one`）。在纯收缩方向（C_dst ≤ C_src 且 R_dst ≤ R_src）中，函数体仅做截断，**不使用** `zero` 变量。

**纯收缩方向共 30 个 6a + 30 个 6b = 60 个重载**涉及此问题。例如 `Mat2x2.fromMat(Mat2x3, one)`（`type_mat2x2.cj:148-152`）声明了 `let zero` 但函数体仅做 `Vec2(m.c0.x, m.c0.y)` 和 `Vec2(m.c1.x, m.c1.y)`——zero 未使用。

**风险**：
- 编译时可能产生"unused variable"警告（取决于 cjc 版本）
- 运行时存在 1 次无效减法/读取操作（性能影响极微小）
- **非阻断性**：OOD §3.3 第 286 行明确说明"纯收缩方向下 `one` 参数被忽略"，`let zero` 的情形同理。签名中保留 zero 是为了直接从 6a/6b 统一代码模板生成。

**证据**：全部 144 个重载（9 目标 × 8 源 × 2 变体）均包含 `let zero` 声明。纯收缩方向的识别可通过 OOD §3.3 的 9×9 转换矩阵表（`:383-393`）中标注为 `rowSh`、`colSh`、`colSh→rowSh` 的方向确认。

---

## 4. 测试补充

### T2: 补充 9 个矩阵类型 Hashable 测试

**严重度**：轻微

**根因定位**：

9 个矩阵结构体均标注 `@Derive[Hashable]`，但 `tests/glm/detail/test_type_mat*.cj`（9 个文件）及 `test_type_mat_compare.cj` 中均未出现哈希相关测试用例。

`@Derive[Hashable]` 是编译期元编程产物，在仓颉中由编译器自动生成 `hash()` 方法。自动派生结果为编译期固定表达式，理论上正确性依赖编译器实现。当前无运行时验证用例无法保证：
1. `@Derive` 宏在矩阵类型的具现化（含 4 个列向量成员）上正确展开
2. `hash()` 返回值在不同元素类型（Int64/Float32/Float64/Bool）下行为一致
3. 值相等的两个矩阵产生相同的哈希值

**证据**：
- `type_mat2x2.cj:6`：`@Derive[Hashable]`
- 其余 8 个矩阵类型同样在第 1 行 struct 定义前标注 `@Derive[Hashable]`
- 所有测试文件未含 `hash` 关键字

---

### T9: 补充 stub 测试文件的显式 import

**严重度**：一般

**根因定位**：

三个文件缺少显式 import `std.unittest.*` / `std.unittest.testmacro.*`：
- `test_common.cj:1`
- `test_geometric.cj:1`
- `test_geometric_refract.cj:1`

项目内其他测试文件（如 `test_matrix.cj:3-4`、`test_scalar_mat_ops.cj:3-4`、`test_type_mat2x2.cj:3-4`）均显式导入。

依据 `cangjie-std/unittest/README.md` §1.2，测试模式下 unittest 和 unittest.testmacro 自动导入，无需显式 import。

**结论**：此问题属于代码风格一致性，不是功能性缺陷。三个 stub 测试文件可正常工作。

**修复者可行动**：添加 `import std.unittest.*` 和 `import std.unittest.testmacro.*` 以与其他测试文件风格一致。

---

### T10: 补充 stub 异常信息内容验证

**严重度**：一般

**根因定位**：

所有 stub 函数测试均使用 `@ExpectThrows[Exception](...)` 模式，但未验证异常信息是否包含"stub"标识字符串。

**存在风险**：`throw Exception("stub")` 与 `throw Exception("not implemented")` 均会被 `@ExpectThrows[Exception]` 接受。若有人将 stub 占位修改为其他异常信息（如笔误 `"stub"` 变为 `"stub "`），测试无法检测。

**涉及文件**：
- `test_common.cj:5-60`（11 个测试）
- `test_matrix.cj:258-290`（6 个测试）
- `test_geometric.cj:7-113`（18 个测试）
- `test_geometric_refract.cj:7-21`（少量测试）

**实现文件**：`common.cj:5-15`、`geometric.cj:5-24`、`matrix.cj:167-173`，所有 stub 函数体统一为 `throw Exception("stub")`。

---

### T14: 补充 Mat3x3/Mat4x4 的 ColOutOfBounds/ColNegative 测试

**严重度**：一般

**根因定位**：

grep 确认在 9 个矩阵测试文件中，7 个文件同时提供 `ColOutOfBounds` 和 `ColNegative` 测试（Mat2x2、Mat2x3、Mat2x4、Mat3x2、Mat3x4、Mat4x2、Mat4x3），**仅 Mat3x3 和 Mat4x4 缺失**。

**证据**：
- `test_type_mat2x2.cj:88-107`：`testMat2x2ColOutOfBounds` + `testMat2x2ColNegative`
- `test_type_mat3x3.cj:75-107`：仅有 `testMat3x3IndexOutOfBounds`（`:89-97`）+ `testMat3x3NegativeIndex`（`:100-108`），**无 Col 系列**
- `test_type_mat4x4.cj:98-139`：仅有 `testMat4x4IndexOutOfBounds`（`:120-128`）+ `testMat4x4NegativeIndex`（`:131-139`），**无 Col 系列**

`col(i)` 函数委托 `this[i]` 实现（如 `type_mat4x4.cj:58`：`public func col(i: Int64): Vec4<T, Q> { this[i] }`），因此 `col()` 的越界行为与 `[]` 一致。缺失的原因可能是编写测试时认为 `col()` 已委托 `[]`，而 `[]` 已有越界测试，故省略了独立的 `col()` 越界测试。但跨 9 文件的覆盖不对称仍然存在。

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

**证据**：在 `cjglm/tests/glm/detail/*.cj` 中搜索 `NaN`，仅在 `test_scalar_vec_ops.cj` 中找到，矩阵测试中无 NaN 涉及。

**实现确认**：矩阵乘法（`type_mat4x4.cj:127-129` 等）和标量运算均使用原生 `+`、`*` 等算术运算符，NaN 传播行为由硬件/运行时保证遵循 IEEE 754。当前无测试仅意味着"无人验证过"，不意味着实现有 bug。

---

### T16: 均衡矩阵测试的 T 类型参数化覆盖

**严重度**：一般

**根因定位**：

在 9 个 `test_type_mat*.cj` 文件中，绝大多数"行为断言"测试以 `Int64` 为底层类型实例化矩阵。例外情况极少：
- `test_type_mat2x2.cj:282-290`：`testMat2x2FromMat7` 跨类型使用 Float64 转换 Int64
- 若干 6b 测试以 Float64 作为目标类型

**具体表现**：
- 9 个文件中几乎找不到以 `Float32` 或 `Float64` 作为 T 的纯"行为断言"测试
- OOD §3.3 第 276 行：`one: T` 参数"若调用方传入 NaN，则对角填充结果将按底层数值运算自然传播 NaN"
- OOD §5 第 830-836 行：`@OverflowWrapping` 对整数类型行为可验证，但对浮点类型无意义
- OOD §4.1 阶段 2 验证标准要求"矩阵创建、行列访问、基本算术运算"完整验证——但验证均集中于 Int64

**风险**：Int64 是整数类型，与 Float32/Float64 浮点类型的行为在 NaN、Infinity、除法截断等方面存在本质差异。以 Int64 为唯一验证类型，无法保证：
1. NaN 传播在浮点类型上的正确性
2. Float32/Float64 除法精度行为
3. `-0.0`、`Infinity` 等特殊浮点值的处理

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

---

### T18: 评估 `test_vec_mat_mul.cj` 基础测试与 ZeroVec 测试的冗余度

**严重度**：一般

**根因定位**：

`test_vec_mat_mul.cj:4-91` 的 9 个基础测试与 `:96-183` 的 9 个 ZeroVec 测试使用**完全相同的矩阵数据**，仅向量值不同（非零 vs 全零）。

**覆盖重叠分析**：ZeroVec 场景的代码足迹与基础测试完全重叠——`v * m` 的展开公式在两种场景下执行相同的 `v.x * m.c0.x + v.y * m.c1.y` 等计算路径，仅因 v 的全零特性使计算结果为 0。

**实际价值**：ZeroVec 边界情况验证提供了额外的"语义正确性"信号——确认零向量的计算结果为零矩阵。但**代码覆盖率上与基础测试无差异**。

---

## 5. API 与构建配置

### T13: 提供 cjpm 子包构建的显式验证产物

**严重度**：一般

**根因定位**：

OOD §2 第 147-171 行明确要求 cjpm 子包构建预验证的原型验证计划，共 5 个步骤：
1. 在 `src/ext/` 下创建最小测试文件 `test_ext.cj`（**未在提交中验证**，grep 确认无 `test_ext` 文件）
2. 运行 `cjpm build` 确认编译通过（**未在提交中验证**）
3. 验证外部项目 `import glm.ext.test_ext.{ test_alias }` 可解析（**未在提交中验证**）
4. 若失败的回退方案——移至 `src/` 根目录改为 `package glm`（**未在提交中验证**）
5. 若方案二也失败，采用方案三（独立子模块）（**未在提交中验证**）

**当前配置**：
- `cjpm.toml`：仅有 `src-dir = "src"`，无 `package-configuration` 或 `sub-package` 配置
- `src/ext/` 下 26 个文件统一声明 `package glm.ext`，依赖 `import glm.detail.*`

**风险分析**：仓颉包声明规则要求"目录名须与包名匹配"（`package/README.md §2.1`）。`src/ext/` 目录对应 `glm.ext` 子包的路由机制依赖于 cjpm 是否自动扫描 `src/` 下所有子目录。如果 cjpm 不支持此发现机制，`package glm.ext` 声明将导致编译错误——`ext/` 下的 24 个 `matrix_*.cj` 和 8 个 `vector_*.cj` 别名文件无法被外部项目正确导入。

**当前状态**：原型验证计划步骤 1~5 均未执行，无任何提交产物证明此项验证已完成。
