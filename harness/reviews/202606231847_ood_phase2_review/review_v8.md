# R8: 测试质量与覆盖率审查

审查时间：2026-06-23

### 审查范围

**矩阵单元测试 9 个**：
- `cjglm/tests/glm/detail/test_type_mat2x2.cj`（458 行，44 测试）
- `cjglm/tests/glm/detail/test_type_mat2x3.cj`（531 行，44 测试）
- `cjglm/tests/glm/detail/test_type_mat2x4.cj`（607 行，44 测试）
- `cjglm/tests/glm/detail/test_type_mat3x2.cj`（522 行，44 测试）
- `cjglm/tests/glm/detail/test_type_mat3x3.cj`（620 行，43 测试）
- `cjglm/tests/glm/detail/test_type_mat3x4.cj`（738 行，44 测试）
- `cjglm/tests/glm/detail/test_type_mat4x2.cj`（589 行，44 测试）
- `cjglm/tests/glm/detail/test_type_mat4x3.cj`（729 行，44 测试）
- `cjglm/tests/glm/detail/test_type_mat4x4.cj`（904 行，45 测试）

**矩阵相关测试**：
- `cjglm/tests/glm/detail/test_type_mat_compare.cj`（634 行，9 类型 × 9 = 81 比较测试）
- `cjglm/tests/glm/detail/test_scalar_mat_ops.cj`（231 行，15 测试）
- `cjglm/tests/glm/detail/test_matrix.cj`（291 行，21 测试）
- `cjglm/tests/glm/detail/test_vec_mat_mul.cj`（340 行，30 测试）
- `cjglm/tests/glm/detail/test_common.cj`（61 行，12 stub 测试）
- `cjglm/tests/glm/detail/test_geometric.cj`（114 行，16 stub 测试）
- `cjglm/tests/glm/detail/test_geometric_refract.cj`（22 行，3 stub 测试）

**集成与 API 测试**：
- `cjglm/tests/glm/test_integration_matrix.cj`（562 行，34 测试）
- `cjglm/tests/glm/test_fwd.cj`（384 行，含 8 矩阵别名家族注释 + 22 矩阵别名）
- `cjglm/tests/glm/test_lib.cj`（162 行，含 6 矩阵导入测试）
- `cjglm/tests/glm/test_ext.cj`（102 行，17 别名 smoke test）

**参考文档**：
- `docs/04_ood_phase2.md` §3.3（构造函数）、§3.4（行列访问）、§3.5（运算符）、§3.7（stub 函数库）、§5（错误处理）
- `harness/reviews/202606231847_ood_phase2_review/review_v6.md`（已暴露的 `testIntegrationFromMatDeviation` 偏差测试错误）

### 测试结构与覆盖率总览

| 测试文件 | 测试数 | 主要覆盖维度 |
|---------|--------|------------|
| 9 × test_type_mat*.cj | 396 | 各矩阵类型的全部 API（构造、访问、算术、跨类型转换、偏差） |
| test_type_mat_compare.cj | 81 | 9 矩阵类型的 ==/!=/equalExact/equalEpsilon + Bool 矩阵 |
| test_vec_mat_mul.cj | 30 | 9 个 Vec×Mat 运算符 × 多种场景 |
| test_scalar_mat_ops.cj | 15 | 36 个全局函数中的 12 个 + 3 个类型变体 |
| test_matrix.cj | 21 | 9 transpose + 3 matrixCompMult + 3 outerProduct + 6 stub |
| test_common.cj | 12 | 12 个 common 函数 stub 测试 |
| test_geometric.cj | 16 | 16 个 geometric 函数 stub 测试 |
| test_geometric_refract.cj | 3 | 3 个 refract 函数 stub 测试 |
| test_integration_matrix.cj | 34 | 公共 API 端到端集成 |
| test_fwd.cj | 约 50 | 向量 + 矩阵别名解析验证 |
| test_lib.cj | 约 17 | glm 公共导出解析验证 |
| test_ext.cj | 17 | glm.ext 24 个别名 smoke test |
| **合计** | **约 692** | |

### 发现

#### [严重] `testIntegrationFromMatDeviation` 对 Mat4x4←Mat4x2 偏差方向的预期值与 OOD 及实际实现相反

- **位置**：`cjglm/tests/glm/test_integration_matrix.cj:330-344`
- **描述**：该测试断言 `Mat4x4.fromMat(Mat4x2(...), Float32(1.0))` 应保留源矩阵列 2/3 的前两行数据（`@Expect(m44.c2.x, Float32(5.0))`、`@Expect(m44.c2.y, Float32(6.0))`、`@Expect(m44.c3.x, Float32(7.0))`、`@Expect(m44.c3.y, Float32(8.0))`）。但 OOD §3.3 第 347 行明确说明 Mat4x4←Mat4x2 为已知 GLM 偏差——GLM 丢弃源列 2、3 的前两行并填入单位矩阵对角线 `(0,0,1,0)` 和 `(0,0,0,1)`。单元测试 `test_type_mat4x4.cj:633-653`（`testMat4x4FromMat6aMat4x2Deviation`）和 `:837-857`（`testMat4x4FromMat6bMat4x2Deviation`）正确断言了偏差行为（`m.c2.x==0, m.c2.z==1, m.c3.x==0, m.c3.z==0, m.c3.w==1`）。**集成测试与单元测试、OOD、实现均不一致**，运行时会失败 4 个 `@Expect`（m44.c2.x/y、m44.c3.x/y），造成 CI 失败。此问题在 R6 审查（review_v6.md）已被标记，但本轮复审确认尚未修复。
- **影响**：阻塞 CI，必须在合并前修复。
- **建议**：按 OOD §3.3 第 347 行与单元测试期望值修正预期：
  ```cangjie
  @Expect(m44.c2.x, Float32(0.0))
  @Expect(m44.c2.y, Float32(0.0))
  @Expect(m44.c2.z, Float32(1.0))
  @Expect(m44.c2.w, Float32(0.0))
  @Expect(m44.c3.x, Float32(0.0))
  @Expect(m44.c3.y, Float32(0.0))
  @Expect(m44.c3.z, Float32(0.0))
  @Expect(m44.c3.w, Float32(1.0))   // 末尾这一项已是正确预期
  ```

#### [严重] test_scalar_mat_ops.cj 仅覆盖 9 种矩阵类型中的 3 种方阵，36 个全局函数仅直接验证 12 个

- **位置**：`cjglm/tests/glm/detail/test_scalar_mat_ops.cj:6-192`
- **描述**：OOD §3.5 第 623-644 行规定 `scalar_mat_ops.cj` 须提供 **4 个运算 × 9 种矩阵类型 = 36 个全局函数**（add/sub/mul/div × Mat2x2/Mat2x3/Mat2x4/Mat3x2/Mat3x3/Mat3x4/Mat4x2/Mat4x3/Mat4x4）。当前测试文件仅覆盖 Mat2x2、Mat3x3、Mat4x4 三种方阵的 4 个运算（共 12 个测试），缺失 Mat2x3、Mat2x4、Mat3x2、Mat3x4、Mat4x2、Mat4x3 这 **6 个非方阵类型的 24 个全局函数测试**（24/36 = 66.7% 覆盖率缺口）。
- **影响**：36 个全局函数中只有 12 个有独立测试断言。如果某个非方阵类型的 add/sub/mul/div 实现存在 bug（例如某个非方阵类型的列向量访问错误），现有测试套件无法发现——集成测试虽偶有覆盖（如 `test_integration_matrix.cj:174-181` 测试 `mul(s, m)` 对 Mat2x2），但属于间接覆盖。路线图 §2 阶段 2 验证标准要求"矩阵创建、行列访问、基本算术运算（+、-、*）"完整验证，非方阵标量运算是基本算术的核心组成部分。
- **建议**：为 6 个非方阵矩阵类型（Mat2x3/Mat2x4/Mat3x2/Mat3x4/Mat4x2/Mat4x3）各添加 4 个 add/sub/mul/div 测试，共 24 个。建议复用现有方阵测试模板（如 `testScalarAddMat2x3Int64`），仅替换矩阵类型即可。最低限度应覆盖每个非方阵类型的 `add` 与 `mul` 至少一个测试（12 个新增测试），其余运算可在阶段四批量补齐。

#### [严重] test_matrix.cj 的 matrixCompMult 与 outerProduct 仅各覆盖 9 个重载中的 3 个

- **位置**：`cjglm/tests/glm/detail/test_matrix.cj:163-255`
- **描述**：OOD §3.7 第 687-727 行规定 `matrix.cj` 须提供 matrixCompMult（9 个重载，每矩阵尺寸各一版）和 outerProduct（9 个重载，按列向量×行向量维度组合）。当前测试文件：
  - matrixCompMult 仅测试 Mat2x2（:164-172）、Mat2x3（:174-185）、Mat4x4（:187-208）共 3/9 = 33.3%；
  - outerProduct 仅测试 Vec2×Vec2（:210-219）、Vec3×Vec2（:221-232）、Vec4×Vec4（:234-255）共 3/9 = 33.3%。
- **影响**：matrixCompMult 与 outerProduct 共 18 个重载中仅 6 个有独立测试（6/18 = 33.3%），存在严重覆盖缺口。如果某个矩阵尺寸的逐分量乘法或外积实现存在 bug，CI 不会发现。
- **建议**：为 9 种矩阵类型各添加一个 `testMatrixCompMultMat...` 测试（共 6 个新增），覆盖 Mat2x4/Mat3x2/Mat3x3/Mat3x4/Mat4x2/Mat4x3。同样为 6 种未覆盖的列向量×行向量组合（Vec2×Vec3、Vec2×Vec4、Vec3×Vec3、Vec3×Vec4、Vec4×Vec2、Vec4×Vec3）各添加一个 `testOuterProduct...` 测试（共 6 个新增）。

#### [一般] Mat3x3 和 Mat4x4 单元测试缺失 `ColOutOfBounds` 与 `ColNegative` 异常测试

- **位置**：
  - `cjglm/tests/glm/detail/test_type_mat3x3.cj:75-107`（仅有 `IndexOutOfBounds` 与 `NegativeIndex`，缺失 Col 系列）
  - `cjglm/tests/glm/detail/test_type_mat4x4.cj:98-139`（仅有 `IndexOutOfBounds` 与 `NegativeIndex`，缺失 Col 系列）
- **描述**：其余 7 个矩阵测试文件（Mat2x2、Mat2x3、Mat2x4、Mat3x2、Mat3x4、Mat4x2、Mat4x3）均同时提供 `ColOutOfBounds`（如 `testMat2x2ColOutOfBounds`）与 `ColNegative`（如 `testMat2x2ColNegative`）异常测试。Mat3x3 与 Mat4x4 缺失这两个测试，形成跨 9 文件的覆盖不对称。
- **影响**：`col(i)` 函数的越界行为（OOD §3.4 第 512 行规定"下标越界时抛出 Exception，与 `[]` 行为一致"）在方阵上无独立测试，仅靠 `[]` 间接覆盖。由于 `[]` 与 `col()` 是两个独立成员函数（虽然逻辑等价），如果 `col()` 实现有 bug，方阵测试无法发现。
- **建议**：在 `test_type_mat3x3.cj` 添加 `testMat3x3ColOutOfBounds` 与 `testMat3x3ColNegative` 两个测试，在 `test_type_mat4x4.cj` 添加 `testMat4x4ColOutOfBounds` 与 `testMat4x4ColNegative` 两个测试。模板可参考 `testMat2x2ColOutOfBounds`（`test_type_mat2x2.cj:88-96`）与 `testMat2x2ColNegative`（`test_type_mat2x2.cj:98-107`），将 `Int64(2)`（2 越界 2×2 矩阵）替换为 `Int64(3)`（越界 3×3 与 4×4 矩阵）。

#### [一般] 矩阵 NaN 传播行为测试完全缺失，与 OOD §5 第 825-829 行测试覆盖要求不符

- **位置**：`cjglm/tests/glm/detail/*.cj`（全文搜索 `NaN` 仅在 test_scalar_vec_ops.cj 中找到，未在矩阵测试中找到）
- **描述**：OOD §5 第 825-829 行明确要求单元测试层应覆盖 Mat×Vec/Vec×Mat 的 NaN 传播行为：
  > 单元测试层应覆盖：
  > - 矩阵含 NaN 列时与不含 NaN 向量的乘法结果验证
  > - 向量含 NaN 分量时与不含 NaN 矩阵的乘法结果验证
  > - 全 NaN 矩阵与正常向量的乘法验证（预期全部结果为 NaN）
  > - 与 GLM 1.0.3 对应实现的结果逐分量等值对照（选取 2~3 个代表性矩阵尺寸，覆盖浮点精度 Float32/Float64）

  现有 9 个矩阵单元测试文件、test_vec_mat_mul.cj、test_scalar_mat_ops.cj 均未对 NaN 输入进行任何测试。NaN 行为虽然属于 IEEE 754 浮点自然结果（无需额外分支），但显式测试可防止编译优化意外触发 NaN 折叠或短路。
- **影响**：与 OOD 阶段 2 验证标准的"矩阵-向量乘法语义正确性验证"存在偏差。如阶段二交付需符合 §5 显式测试覆盖要求，本项必须补齐。
- **建议**：在 `test_vec_mat_mul.cj` 添加 1 个 NaN 输入测试（如 `testVec2MulMat2x2NaN`），构造 `Vec2(Float32.NaN, Float32(0.0))` 与 `Mat2x2(Float32(1.0), ...)`，断言 `r.x.isNaN()` 为真。在 `test_type_mat2x2.cj` 添加 1 个 Mat×Vec 的 NaN 测试（如 `testMat2x2MulVec2NaN`）。最低限度应覆盖 OOD §5 第 825-829 行的 3 个场景中至少 1 个代表性矩阵尺寸（如 Mat2x2）。

#### [一般] 矩阵测试的 T 类型参数化覆盖极不均衡，9 种矩阵类型几乎全部以 Int64 测试

- **位置**：9 个 `test_type_mat*.cj` 文件全文
- **描述**：在 9 个矩阵单元测试文件中，除 `test_type_mat2x2.cj:282-290`（`testMat2x2FromMat7` 跨类型使用 Float64 转换 Int64）与若干 6b 测试中以 Float64 作为目标类型外，所有构造、访问、算术、跨类型转换的"行为断言"均以 `Int64` 为底层类型实例化矩阵。例如：
  - `testMat2x2ScalarInit` 使用 `Mat2x2<Int64, Defaultp>(5)`
  - `testMat2x2MatrixMul` 使用 `Mat2x2<Int64, Defaultp>(...)`
  - `testMat2x2Diagonal` 使用 `Mat2x2<Int64, Defaultp>.diagonal(Int64(7))`
  
  9 个文件中几乎找不到以 `Float32` 或 `Float64` 作为 T 的"行为断言"测试。仅 `test_scalar_mat_ops.cj:195-222` 中 `testScalarDivMat2x2Float32/Float64/Int32Truncation`（3 个）、`test_vec_mat_mul.cj:281-308`（3 个 Float64 方阵）涉及浮点行为断言。
  
  OOD §3.3 第 276 行明确规定 `one: T` 参数"若调用方传入 NaN，则对角填充结果将按底层数值运算自然传播 NaN"；§5 第 830-836 行要求溢出策略对所有算术运算符以 `@OverflowWrapping` 标注；§4.1 阶段 2 验证标准要求"矩阵创建、行列访问、基本算术运算"完整验证——但验证均集中于 Int64，Float32/Float64 类型下的精度、舍入、@OverflowWrapping 行为无独立测试。
- **影响**：Int64 下的 `@OverflowWrapping` 行为可验证整数溢出截断；但 Float32/Float64 下的浮点精度、IEEE 754 行为、@OverflowWrapping 在浮点上无意义的事实未通过测试确立。路线图 §2 阶段 2 验证标准"矩阵-向量乘法语义正确性验证"要求覆盖 Float32/Float64。
- **建议**：在代表性矩阵类型（如 Mat2x2、Mat3x3、Mat4x4）的测试文件中，为关键 API（构造、identity、diagonal、矩阵乘法、Mat×Vec）各添加 1 个 Float32 或 Float64 行为断言测试。最低限度应覆盖：
  - `test_type_mat2x2.cj`：1 个 Float32 行为测试（如 `testMat2x2MatrixMulFloat32`），1 个 Float64 identity 测试
  - `test_type_mat3x3.cj`：1 个 Float32 行为测试
  - `test_type_mat4x4.cj`：1 个 Float32 identity 测试

#### [一般] test_integration_matrix.cj 的 deviation 测试与其他测试预期值交叉一致性需独立验证

- **位置**：`cjglm/tests/glm/test_integration_matrix.cj:330-344`（testIntegrationFromMatDeviation，已在严重项 1 标记）
- **描述**：OOD 阶段 2 §3.3 第 347 行将 Mat4x4←Mat4x2 标注为 🚨 DEVIATION。偏差测试在三个位置独立存在：
  - `test_type_mat4x4.cj:633-653`（`testMat4x4FromMat6aMat4x2Deviation`，Int64）
  - `test_type_mat4x4.cj:837-857`（`testMat4x4FromMat6bMat4x2Deviation`，Float64 + conv）
  - `test_integration_matrix.cj:330-344`（`testIntegrationFromMatDeviation`，Float32 经 fwd 别名）
  
  前两个单元测试预期值正确（断言列 2/3 为单位矩阵对角）。集成测试的预期值与单元测试相反。本轮独立复审确认：
  - 单元测试（6a）`@Expect(m.c2.x, 0)`、`@Expect(m.c2.z, 1)`、`@Expect(m.c3.x, 0)`、`@Expect(m.c3.w, 1)`——与 OOD §3.3 第 347 行、`type_mat4x4.cj:235-239` 实现一致 ✓
  - 单元测试（6b）使用 Float64 转换，预期值与 6a 一致 ✓
  - 集成测试预期 `m44.c2.x==5.0`、`m44.c3.x==7.0` 等——与 OOD/实现相反 ✗
  
  已知偏差方向测试中，单元测试正确，集成测试错误。这是测试套件内部自相矛盾的典型案例。
- **影响**：同严重项 1。
- **建议**：在修复 `test_integration_matrix.cj:330-344` 预期值后，建议在测试套件中新增一个交叉一致性验证（可选）：在 `test_type_mat4x4.cj` 添加 `testMat4x4FromMat6aMat4x2DeviationFloat32`（使用 Float32 而非 Int64），验证偏差行为在浮点类型下一致，避免未来重构时引入非对称偏差。

#### [一般] test_integration_matrix.cj 的 `testIntegrationFromMatBClass` 与 `testIntegrationFromMatColExtRowExt` 等未显式标注对应 OOD 标注的偏差方向

- **位置**：`cjglm/tests/glm/test_integration_matrix.cj:268-328`
- **描述**：集成测试提供了以下 fromMat 转换场景：
  - `testIntegrationFromMatBClass` (Mat2x2→Mat2x3、Mat2x3→Mat2x4)：B 类方向 rowExt
  - `testIntegrationFromMatColExtRowExt` (Mat2x2→Mat3x3)：colExt+rowExt 组合
  - `testIntegrationFromMatColShrink` (Mat4x4→Mat3x3、Mat3x3→Mat2x2)：纯 colShrink
  - `testIntegrationFromMatColExtRowShrink` (Mat2x4→Mat3x2)：colExt+rowShrink
  - `testIntegrationFromMatColShrinkRowExt` (Mat3x2→Mat2x3)：colShrink+rowExt
  
  共覆盖 5 种 fromMat 模式。OOD §3.3 第 385-393 行 9×9 转换矩阵表中标注了 7 种不同模式（EQL/B/colExt/colSh/组合/🚨DEVIATION）。但集成测试未覆盖 `rowSh`（仅行收缩）模式（如 Mat4x4→Mat4x2→Mat4x3 链中的 Mat4x2←Mat4x3 实际是 `rowSh`）。
- **影响**：集成层 `rowSh` 模式无独立验证，仅依赖单元测试覆盖。如果某次重构导致 `rowSh` 模式回归，集成测试无法发现。
- **建议**：在 `test_integration_matrix.cj` 添加 `testIntegrationFromMatRowShrink`（如 Mat4x4→Mat4x3 收缩行），显式覆盖 `rowSh` 模式。或在每个 `fromMat 6a` 测试文件中确认覆盖全部 4 种纯模式（B 类 rowExt、colExt、rowSh、colSh）的至少 1 个示例。

#### [一般] test_vec_mat_mul.cj 的 9 个 Vec×Mat 基础测试与 9 个 ZeroVec 测试使用完全相同的矩阵与向量数据

- **位置**：`cjglm/tests/glm/detail/test_vec_mat_mul.cj:4-91`（基础测试）、`:96-183`（ZeroVec 测试）
- **描述**：9 个 `testVec{M}MulMat{N}x{M}` 基础测试与对应的 `testVec{M}MulMat{N}x{M}ZeroVec` 测试使用相同的矩阵数据（仅向量值不同）。这种模板化重复虽然便于维护，但 9 + 9 = 18 个测试中，零向量场景下的乘法公式验证的代码覆盖率与基础场景完全重叠（仅期望值变化为 0）。如果某个矩阵乘法实现对"零向量"做了未预期特化（例如短路返回），零向量测试可发现；但零向量场景的测试无法覆盖非零向量场景下可能存在的 bug。
- **影响**：零向量场景的测试冗余度较高，但仍是显式覆盖 OOD §5 NaN 传播之外的"零元素传播"测试。从测试设计角度可接受，但不如类型变体测试（Float64、PackedHighp）的边际收益。
- **建议**：保留现状。如时间允许，可将零向量测试替换为 1 个"乘法恒等性"测试（即对恒等矩阵 `identity(one)` 与任意向量相乘应返回原向量），该测试同时验证 identity() 与乘法语义。

#### [轻微] 测试函数命名风格不完全统一（camelCase vs PascalCase 局部不一致）

- **位置**：所有 `test_*.cj` 文件
- **描述**：测试函数命名遵循 `test{Type}{Operation}{Variant}` 的模板化模式（如 `testMat2x2ScalarInit`、`testMat2x2MatrixMul`），整体一致。但存在以下轻微不一致：
  - test_vec_mat_mul.cj 使用 `testVec2MulMat2x2` 模式（Vec 在前 Mat 在后），test_type_mat*.cj 使用 `testMat2x2MulVec2` 模式（Mat 在前 Vec 在后）。两个文件对"被乘对象"的表述方式相反——vec_mat_mul 文件强调 Vec（因为是左操作数），type_mat 文件强调 Mat（因为是测试该 Mat 类型的运算符）。
  - test_type_mat_compare.cj 使用 `test2x2EqualTrue/False`（无 `Mat` 前缀，如 `test2x2EqualTrue`），而其他文件均使用 `testMat2x2...` 前缀。形成 `test2x2...` 与 `testMat2x2...` 两种风格。
  - test_integration_matrix.cj 使用 `testIntegration{Operation}`（如 `testIntegrationAll9FloatMatAliasConstruct`），命名方式与其他文件的 `testXxx` 风格兼容但长度明显更长。
- **影响**：命名风格轻微不一致不影响测试功能，但在阅读测试列表时可能造成一定认知开销。
- **建议**：可选的命名风格统一化。最低优先级修改：
  - 将 `test_type_mat_compare.cj` 中的 `test2x2...` 改为 `testMat2x2...` 以与 OOD 类型命名一致。
  - 保留 vec_mat_mul 与 type_mat 的差异（前者强调被测试对象的左操作数），这是合理的设计选择。

#### [轻微] test_common.cj 与 test_geometric.cj 等 stub 测试使用单次 throw 检查，未验证函数签名本身的语义

- **位置**：
  - `cjglm/tests/glm/detail/test_common.cj:4-60`（12 个 stub 测试）
  - `cjglm/tests/glm/detail/test_geometric.cj:3-114`（16 个 stub 测试）
  - `cjglm/tests/glm/detail/test_geometric_refract.cj:3-22`（3 个 stub 测试）
- **描述**：所有 stub 测试均使用 `@ExpectThrows[Exception](func(args))` 验证函数会抛出异常。这确保了函数存在并被编译链接，但未验证：
  - 函数参数数量与类型（编译时已验证）
  - 函数返回类型（编译时已验证）
  - 函数体是否真的是 stub 而非某种误实现
- **影响**：如果某次重构将 stub 误改为某种局部实现，stub 测试不会失败（因为新实现可能仍然因其他原因抛异常）。这是一个低概率但真实的回归风险。
- **建议**：可选的改进——为 stub 函数添加返回类型验证（如 `@ExpectThrows[Exception]({ let r: T = func(args); @Expect(r, default) })`），确保异常是来自 stub 而非类型错误。最低优先级修改，因为当前实现是 stub，重构风险低。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 3 |
| 一般 | 6 |
| 轻微 | 2 |

### 总评

阶段二的测试体系整体结构良好，覆盖了 9 个矩阵类型 + 矩阵函数库 + 集成层 + 别名层共计约 692 个测试用例。**单元测试模板化程度极高**（9 个矩阵类型文件结构对称，每个文件覆盖构造、访问、算术、跨类型转换 4 大类 API），符合 OOD §8 阶段二产出物清单中"配套测试文件"的预期。

**主要成就**：
- 9 个 `test_type_mat*.cj` 文件结构高度一致，每个文件覆盖 OOD §3.3 第 200-318 行规定的全部 4 大类构造函数（逐分量/列向量/fromParts/fromColumns）+ fromMat 6a/6b/7 全部跨类型转换（每个目标矩阵 8 个 6a + 8 个 6b + 1 个 6b 偏差 + 1 个 6b 普通 = 17 个 cross-type 测试）。偏差方向（Mat4x4←Mat4x2）有独立的 `testMat4x4FromMat6aMat4x2Deviation` 与 `testMat4x4FromMat6bMat4x2Deviation` 测试，且预期值正确。
- 边界条件测试覆盖完整：identity 对角线溢出（Mat3x2 的 c2 全零、Mat4x2 的 c2/c3 全零）、Vec×Mat 零向量（9 个）、Vec×Mat 负值（3 个）、索引越界（IndexOutOfBounds、NegativeIndex 全部 9 类型）、列越界（ColOutOfBounds、ColNegative 7/9 类型）。
- 比较运算符测试覆盖完整（test_type_mat_compare.cj 81 个测试覆盖 9 类型 × 9 操作）。
- 测试断言风格统一使用 `@Expect`（OOD 阶段 2 测试规范）。

**主要问题**：
1. **R6 已暴露的偏差测试错误尚未修复**：`test_integration_matrix.cj:330-344` 的 Mat4x4←Mat4x2 预期值与 OOD/实现/单元测试相反，**阻塞 CI**。
2. **test_scalar_mat_ops.cj 覆盖严重不足**：36 个全局函数仅 12 个有独立测试（33.3%），非方阵 6 类型 × 4 运算 = 24 个函数无任何直接断言。
3. **test_matrix.cj 覆盖严重不足**：matrixCompMult 与 outerProduct 各 18 个重载仅 6 个有测试（33.3%）。
4. **测试类型参数化极不均衡**：9 类型矩阵几乎全部以 Int64 实例化，Float32/Float64 行为断言仅集中在集成测试与少量方阵测试中，与 OOD §5 验证标准"覆盖浮点精度 Float32/Float64"要求存在差距。
5. **NaN 传播测试完全缺失**：与 OOD §5 第 825-829 行的"单元测试层应覆盖 NaN 传播行为"明确要求不符。
6. **Mat3x3/Mat4x4 异常测试不对称**：缺失 ColOutOfBounds 与 ColNegative 两个测试，与其他 7 个矩阵测试文件不对称。

**总评结论**：本轮审查**不通过**。需先修复 3 项严重问题（集成测试偏差预期值、scalar_mat_ops 覆盖、matrix.cj 函数库覆盖），建议至少补齐 6 项一般问题中的前 3 项（异常测试对称性、NaN 测试、Float32/Float64 类型参数化测试）后再考虑合并。2 项轻微问题可后续优化。