# 待办事项

> 编号 T{N} 递增。状态：`[ ]` 待处理、`[~]` 处理中、`[x]` 已完成、`[-]` 已取消。
>
> 来源标注规则：`v{N}-A{M}[严重|一般]` 表示第 N 轮第 M 个 agent 报告中的指定严重度问题。

---

## 阻塞合并（合并前必须修复）

- [ ] T5: 修复 `testIntegrationFromMatDeviation` 预期值与 OOD/实现相反
  - **来源**：v2-A3 [严重]、v3-A1 [严重]、v3-A2 [严重]
  - **位置**：`cjglm/tests/glm/test_integration_matrix.cj:330-344`
  - **描述**：测试断言 `Mat4x4.fromMat(Mat4x2(...), Float32(1.0))` 应保留源矩阵列 2/3 的前两行数据（`@Expect(m44.c2.x, Float32(5.0))`、`@Expect(m44.c2.y, Float32(6.0))`、`@Expect(m44.c3.x, Float32(7.0))`、`@Expect(m44.c3.y, Float32(8.0))`），但 OOD §3.3 第 347 行明确规定 Mat4x4←Mat4x2 为已知 GLM 偏差——GLM 丢弃源列 2/3 的前两行并填入单位矩阵对角线 `(0,0,1,0)` 和 `(0,0,0,1)`。`type_mat4x4.cj:235-239`（6a）与 `:287-291`（6b）实际实现正确；`test_type_mat4x4.cj:633-653`（6a）与 `:837-857`（6b）的单元测试亦正确。**集成测试与单元测试、OOD、实现四者自相矛盾**，运行时会失败 4 个 `@Expect`，导致 CI 阻塞。

- [ ] T6: 补充 `test_scalar_mat_ops.cj` 6 个非方阵矩阵类型的标量-矩阵 ±*/ 测试
  - **来源**：v1-A2 [一般]、v3-A2 [严重]
  - **位置**：`cjglm/tests/glm/detail/test_scalar_mat_ops.cj:6-192`
  - **描述**：OOD §3.5 第 623-644 行规定 `scalar_mat_ops.cj` 须提供 4 运算 × 9 矩阵类型 = 36 个全局函数。当前测试文件仅覆盖 Mat2x2、Mat3x3、Mat4x4 三种方阵的 4 个运算（共 12 个测试），缺失 Mat2x3、Mat2x4、Mat3x2、Mat3x4、Mat4x2、Mat4x3 这 6 个非方阵类型的 24 个全局函数测试（24/36 = 66.7% 覆盖率缺口）。如某个非方阵类型的 add/sub/mul/div 实现存在 bug（例如列向量访问错误），现有测试套件无法发现。

- [ ] T7: 补充 `test_matrix.cj` 中 matrixCompMult/outerProduct 的 6+6 个未覆盖测试
  - **来源**：v2-A1 [一般]、v3-A2 [严重]
  - **位置**：`cjglm/tests/glm/detail/test_matrix.cj:163-255`
  - **描述**：OOD §3.7 第 687-727 行规定 `matrix.cj` 须提供 matrixCompMult（9 重载）和 outerProduct（9 重载）。当前测试文件：matrixCompMult 仅测试 Mat2x2（:164-172）、Mat2x3（:174-185）、Mat4x4（:187-208）共 3/9 = 33.3%；outerProduct 仅测试 Vec2×Vec2（:210-219）、Vec3×Vec2（:221-232）、Vec4×Vec4（:234-255）共 3/9 = 33.3%。matrixCompMult 与 outerProduct 共 18 个重载中仅 6 个有独立测试（6/18 = 33.3%），存在严重覆盖缺口。

---

## 偏差文档登记（deviations.md）

- [ ] T1: 在 `deviations.md` 新增 DEV-15：`init(scalar: T)` 全填充构造函数未在 OOD §3.3 清单中列出
  - **来源**：v1-A1 [一般]、v3-A3 [一般]
  - **位置**：`cjglm/src/detail/type_mat2x2.cj:11-14`、`type_mat2x3.cj:21-24`、`type_mat2x4.cj:21-24`、`type_mat3x2.cj:24-28`、`type_mat3x3.cj:24-28`、`type_mat3x4.cj:24-28`、`type_mat4x2.cj:27-32`、`type_mat4x3.cj:27-32`、`type_mat4x4.cj:27-32`
  - **描述**：OOD §3.3 明确列出 9 个矩阵类型的构造函数体系（共 8 类），其中不包含 `init(scalar: T)` 全填充构造函数。OOD §3.3 item 3 显式说明 GLM 中 `mat(T s)` 构造函数（全填充）已映射为仓颉的 `diagonal(scalar)` Number<T> 工厂函数（仅对角线填充）。OOD §9 偏差表再次确认此接口形态偏差。但实现中 9 个矩阵类型全部额外提供 `public init(scalar: T)` 非 const 构造函数（**填满所有 C×R 个位置**，非对角填充），并被测试用例大量使用。属于"实现扩展未同步到设计文档"类偏差。

- [ ] T19: 修正 OOD §9 关于 `diagonal` 等价于 GLM `mat(T s)` 的描述歧义（DEV-16）
  - **来源**：v3-A3 [一般]
  - **位置**：`docs/04_ood_phase2.md` §9 第 22 行
  - **描述**：OOD §9 声明 "diagonal 为工厂函数（曾用名 filled）...对所有 9 个矩阵类型均提供（与 GLM 1.0.3 对所有 9 个矩阵类型均提供 `mat(T s)` 构造函数一致）"，但 OOD §3.3 item 3 已明确 `diagonal(scalar)` 为**对角填充**，与 C++ GLM `mat(T s)` 的**全填充**语义不同。实现同时提供 `diagonal(scalar)`（对角填充）和 `init(scalar: T)`（全填充），后者才是真正等价于 GLM `mat(T s)` 的构造。该描述具有误导性——读者可能误以为 `diagonal(scalar)` 就是 GLM 的全填充构造。

---

## 代码风格与命名

- [ ] T3: 统一 9 个矩阵类型中矩阵-矩阵乘法运算符参数命名 `r` → `rhs`
  - **来源**：v1-A2 [一般]
  - **位置**：`cjglm/src/detail/type_mat3x3.cj:91, 99, 108`、`type_mat4x4.cj:97, 105, 114`
  - **描述**：在 9 个矩阵文件中，矩阵-矩阵乘法运算符（`operator func *(...)`）的右操作数参数命名不一致：Mat2x2、Mat2x3、Mat2x4、Mat3x2、Mat3x4、Mat4x2、Mat4x3 这 7 个文件统一使用 `rhs` 作为参数名（与 OOD §3.5 模板示例一致）；而 Mat3x3 和 Mat4x4 文件中的 3 个矩阵乘法重载使用参数名 `r`。同样地，Mat3x3.cj:118 和 Mat4x4.cj:124 的 `operator func /(rhs: ...)` 都用了 `rhs`，进一步凸显 Mat3x3 和 Mat4x4 的矩阵乘 `r` 是偶然的不一致。

- [ ] T7-cs: Mat2x2 构造函数声明顺序与其他 8 个矩阵类型不一致
  - **来源**：v1-A1 [一般]
  - **位置**：`cjglm/src/detail/type_mat2x2.cj:11-24`（`init(scalar)` 在最前）、其余 8 个文件（`init(scalar)` 在最后）
  - **描述**：Mat2x2 的声明顺序为 `init(scalar: T)` → `const init(逐分量)` → `const init(列向量)`，而其余 8 个矩阵类型的顺序均为 `const init(逐分量)` → `const init(列向量)` → `init(scalar: T)`。仓颉函数重载解析与声明顺序无关（不引发编译错误），但 9 个文件的代码组织风格应保持一致以降低维护成本。

- [ ] T8: 评估是否在 `fromMat` 纯收缩方向重载中省略 `let zero = ...` 声明
  - **来源**：v1-A3 [一般]
  - **位置**：`cjglm/src/detail/type_mat2x2.cj:148-194`、`type_mat2x3.cj:143-189`、`type_mat2x4.cj:143-189`、`type_mat3x2.cj:149-195`、`type_mat3x3.cj:152-198`、`type_mat3x4.cj:149-195`、`type_mat4x2.cj:155-201`、`type_mat4x3.cj:155-201`、`type_mat4x4.cj:199-245`（全部 144 个 6a/6b 重载）
  - **描述**：所有 fromMat 6a 函数体统一以 `let zero = m.c0.x - m.c0.x` 开头以计算 T(0)（6b 使用 `let zero = one - one`）。但在纯收缩方向（C_dst ≤ C_src 且 R_dst ≤ R_src）的实现中，函数体仅做截断、不使用 `zero` 变量。编译时可能产生"unused variable"警告（取决于 cjc 版本），且运行时存在 1 次无效减法/读取操作。

---

## 测试补充

- [ ] T2: 补充 9 个矩阵类型 Hashable 测试用例
  - **来源**：v1-A1 [轻微]（注：原 todo.md 保留为轻微项；OOD §3.1 第 186 行要求通过 @Derive[Hashable] 自动派生哈希支持）
  - **位置**：`cjglm/src/detail/type_mat2x2.cj:6` 等 9 处 `@Derive[Hashable]`
  - **描述**：9 个矩阵结构体均标注 `@Derive[Hashable]` 自动派生哈希，但 `tests/glm/detail/test_type_mat*.cj`（9 个文件）及 `test_type_mat_compare.cj` 中均未出现哈希相关测试用例。@Derive[Hashable] 是编译期元编程产物，无法通过简单的字段存在性检查保证正确性，应有运行时验证用例。

- [ ] T9: 补充 `test_common.cj` / `test_geometric.cj` / `test_geometric_refract.cj` 的显式 import
  - **来源**：v2-A1 [一般]
  - **位置**：`cjglm/tests/glm/detail/test_common.cj:1`、`test_geometric.cj:1`、`test_geometric_refract.cj:1`
  - **描述**：三个文件均无 `import std.unittest.* / import std.unittest.testmacro.*`，依赖测试模式的自动导入机制。项目内其他测试文件（如 `test_matrix.cj:3-4`、`test_scalar_mat_ops.cj:3-4`、`test_type_mat2x2.cj:3-4`）均显式导入单元测试框架包。依据 `cangjie-std/unittest/README.md` §1.2 "测试模式下 unittest 和 unittest.testmacro 自动导入，无需显式 import"——三种 stub 测试文件依赖测试模式的自动导入机制能正常工作，但与其他测试文件风格不一致。

- [ ] T10: 补充 stub 函数异常信息内容的验证
  - **来源**：v2-A1 [一般]
  - **位置**：`cjglm/tests/glm/detail/test_common.cj:5-60`、`test_matrix.cj:258-290`、`test_geometric.cj:7-113`、`test_geometric_refract.cj:7-21`
  - **描述**：所有 stub 函数测试均使用 `@ExpectThrows[Exception](...)` 模式断言抛出 Exception，但未验证异常信息是否包含 "stub" 标识字符串。例如 `throw Exception("stub")` 与 `throw Exception("not implemented")` 均会被 `@ExpectThrows[Exception]` 接受。这意味着即使有人将 stub 占位修改为其他异常信息，测试也无法检测出该变化。

- [ ] T14: 补充 Mat3x3 和 Mat4x4 单元测试的 `ColOutOfBounds` 与 `ColNegative` 异常测试
  - **来源**：v3-A2 [一般]
  - **位置**：`cjglm/tests/glm/detail/test_type_mat3x3.cj:75-107`（仅有 `IndexOutOfBounds` 与 `NegativeIndex`，缺失 Col 系列）、`test_type_mat4x4.cj:98-139`（同上）
  - **描述**：其余 7 个矩阵测试文件（Mat2x2、Mat2x3、Mat2x4、Mat3x2、Mat3x4、Mat4x2、Mat4x3）均同时提供 `ColOutOfBounds`（如 `testMat2x2ColOutOfBounds`）与 `ColNegative`（如 `testMat2x2ColNegative`）异常测试。Mat3x3 与 Mat4x4 缺失这两个测试，形成跨 9 文件的覆盖不对称。`col(i)` 函数的越界行为（OOD §3.4 第 512 行规定"下标越界时抛出 Exception，与 `[]` 行为一致"）在方阵上无独立测试。

- [ ] T15: 补充矩阵 NaN 传播行为测试
  - **来源**：v3-A2 [一般]
  - **位置**：`cjglm/tests/glm/detail/*.cj`（全文搜索 `NaN` 仅在 test_scalar_vec_ops.cj 中找到，未在矩阵测试中找到）
  - **描述**：OOD §5 第 825-829 行明确要求单元测试层应覆盖 Mat×Vec/Vec×Mat 的 NaN 传播行为：矩阵含 NaN 列时与不含 NaN 向量的乘法结果验证；向量含 NaN 分量时与不含 NaN 矩阵的乘法结果验证；全 NaN 矩阵与正常向量的乘法验证（预期全部结果为 NaN）；与 GLM 1.0.3 对应实现的结果逐分量等值对照（选取 2~3 个代表性矩阵尺寸，覆盖浮点精度 Float32/Float64）。现有 9 个矩阵单元测试文件、test_vec_mat_mul.cj、test_scalar_mat_ops.cj 均未对 NaN 输入进行任何测试。

- [ ] T16: 均衡矩阵测试的 T 类型参数化覆盖（增加 Float32/Float64 行为断言）
  - **来源**：v3-A2 [一般]
  - **位置**：9 个 `test_type_mat*.cj` 文件全文
  - **描述**：在 9 个矩阵单元测试文件中，除 `test_type_mat2x2.cj:282-290`（`testMat2x2FromMat7` 跨类型使用 Float64 转换 Int64）与若干 6b 测试中以 Float64 作为目标类型外，所有构造、访问、算术、跨类型转换的"行为断言"均以 `Int64` 为底层类型实例化矩阵。9 个文件中几乎找不到以 `Float32` 或 `Float64` 作为 T 的"行为断言"测试。OOD §3.3 第 276 行明确规定 `one: T` 参数"若调用方传入 NaN，则对角填充结果将按底层数值运算自然传播 NaN"；§5 第 830-836 行要求溢出策略对所有算术运算符以 `@OverflowWrapping` 标注；§4.1 阶段 2 验证标准要求"矩阵创建、行列访问、基本算术运算"完整验证——但验证均集中于 Int64。

- [ ] T17: 补充 `test_integration_matrix.cj` 中 `rowSh`（仅行收缩）模式的集成测试
  - **来源**：v3-A2 [一般]
  - **位置**：`cjglm/tests/glm/test_integration_matrix.cj:268-328`
  - **描述**：集成测试提供了以下 fromMat 转换场景：`testIntegrationFromMatBClass`、`testIntegrationFromMatColExtRowExt`、`testIntegrationFromMatColShrink`、`testIntegrationFromMatColExtRowShrink`、`testIntegrationFromMatColShrinkRowExt`，共覆盖 5 种 fromMat 模式。OOD §3.3 第 385-393 行 9×9 转换矩阵表中标注了 7 种不同模式（EQL/B/colExt/colSh/组合/🚨DEVIATION）。但集成测试未覆盖 `rowSh`（仅行收缩）模式。

- [ ] T18: 评估 `test_vec_mat_mul.cj` 基础测试与 ZeroVec 测试的冗余度
  - **来源**：v3-A2 [一般]
  - **位置**：`cjglm/tests/glm/detail/test_vec_mat_mul.cj:4-91`（基础测试）、`:96-183`（ZeroVec 测试）
  - **描述**：9 个 `testVec{M}MulMat{N}x{M}` 基础测试与对应的 `testVec{M}MulMat{N}x{M}ZeroVec` 测试使用相同的矩阵数据（仅向量值不同）。这种模板化重复虽然便于维护，但 9 + 9 = 18 个测试中，零向量场景下的乘法公式验证的代码覆盖率与基础场景完全重叠（仅期望值变化为 0）。

---

## API 与构建配置

- [ ] T13: 提供 `cjpm` 子包构建的显式验证产物
  - **来源**：v2-A3 [一般]
  - **位置**：`cjglm/cjpm.toml`、`cjglm/src/ext/*.cj`
  - **描述**：OOD §2 第 147-171 行明确要求 cjpm 子包构建预验证的原型验证计划：1. 创建最小测试文件（已完成，`test_ext.cj` 存在）；2. 运行 `cjpm build` 确认编译通过（**未在提交中验证**）；3. 验证外部项目 `import glm.ext.test_ext.{ test_alias }` 可解析（**未在提交中验证**）；4-5. 失败时的回退方案（**未在提交中验证**）。`cjpm.toml` 中仅设置 `src-dir = "src"`，无显式 `package-configuration` 或 `sub-package` 配置。若 cjpm 不支持自动发现 `src/ext/` 子目录作为 `glm.ext` 子包，则 24 个 ext/ 文件全部无法被外部项目正确导入。
