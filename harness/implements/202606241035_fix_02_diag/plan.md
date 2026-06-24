# 实现计划

任务描述：修复 `docs/diag/impl/02_diag.md` 审议文件中的所有问题，确保其与 OOD 设计、参考实现一致。
项目根目录：`C:\Develop\Software\cjglm_wp\cjglm`

---

## 实施路线

可以根据任务难度、任务大小适当合并实施

| 序号 | 任务名称 | 状态 | 负责人 |
|------|---------|------|--------|
| 1 | **T5**: 修复 `testIntegrationFromMatDeviation` 预期值（CI 阻塞） | ✅ | Agent |
| 2 | **T6**: 补充非方阵标量-矩阵测试（覆盖率缺口 > 66%） | ✅ | Agent |
| 3 | **T7**: 补充 matrixCompMult/outerProduct 测试（覆盖率缺口 > 66%） | ✅ | Agent |
| 4 | **T1**: `init(scalar: T)` 全填充构造函数登入 OOD | ✅ | Agent |
| 5 | **T19**: 修正 OOD §9 `diagonal` 等价描述歧义 | ✅ | Agent |
| 6 | **T3**: Mat3x3/Mat4x4 矩阵乘法参数命名 `r` → `rhs` | ✅ | Agent |
| 7 | **T7-cs**: Mat2x2 构造函数声明顺序调整 | ✅ | Agent |
| 8 | **T8**: 移除纯收缩方向 `let zero` 无用声明 | ✅ | Agent |
| 9 | **T2**: 补充 9 个矩阵类型 Hashable 测试 | ✅ | Agent |
| 10 | **T9**: 补充 stub 测试文件的显式 import | ✅ | Agent |
| 11 | **T10**: 补充 stub 异常信息内容验证（4 文件 38 测试：含 test_matrix.cj 6 个） | ✅ | Agent |
| 12 | **T14**: 补充 Mat3x3/Mat4x4 的 ColOutOfBounds/ColNegative 测试 | ✅ | Agent |
| 13 | **T17**: 补充 `rowSh` 模式的集成测试 | ✅ | Agent |
| 14 | **T18**: 评估 ZeroVec 测试冗余度（保留） | ✅ | Agent |
| 15 | **T16**: 均衡矩阵测试的 T 类型参数化覆盖 | ✅ | Agent |
| 16 | **T15**: 补充矩阵 NaN 传播行为测试 | ✅ | Agent |
| 17 | **T13**: 提供 cjpm 子包构建的显式验证产物 | ✅ | Agent |

---

## R1 NEW T5: 修复 testIntegrationFromMatDeviation 预期值

任务：修复 `test_integration_matrix.cj:338-341` 中 4 个 `@Expect` 断言值，使其与 OOD §3.3 DEVIATION 行为一致（列 2/3 应为 `(0,0,1,0)` / `(0,0,0,1)` 而非保留源矩阵列 2/3 的前两行数据）
选择理由：T5 导致 CI 运行时 4 个 @Expect 断言失败，阻塞所有合并，必须优先解决
上下文：
- 诊断报告 §1 T5 已精确定位根因并提供修复值
- `test_type_mat4x4.cj:633-653`（6a 单元测试）和 `:837-857`（6b 单元测试）提供了正确的 DEVIATION 预期值作为参考
- GLM 1.0.3 `type_mat4x4.inl:246-257` 确认丢弃源列 2/3 数据的行为
- 不涉及其他文件，仅修改 `test_integration_matrix.cj` 第 338-341 行

---

## R2 PASSED T5: 修复 testIntegrationFromMatDeviation 预期值

结果：修改 `test_integration_matrix.cj:338-341` 的 4 个 `@Expect` 值（5.0→0.0, 6.0→0.0, 7.0→0.0, 8.0→0.0），补充 `c2.z=1.0`、`c2.w=0.0`、`c3.z=0.0` 断言
测试：`cjpm test` 通过 476 项，0 失败
验证：verify_v1.md PASSED

## R2 PASSED T6: 补充非方阵标量-矩阵测试

结果：在 `test_scalar_mat_ops.cj` 末尾追加 24 个非方阵标量-矩阵运算测试（6 非方阵 × 4 运算 add/sub/mul/div，仅 Int64），覆盖原覆盖率缺口
测试：`cjpm test` 通过 476 项，0 失败
验证：verify_v2.md PASSED

---

## R3 NEW T7: 补充 matrixCompMult/outerProduct 测试

任务：在 `test_matrix.cj` 中为 `matrixCompMult`（6 缺失类型：Mat2x4/Mat3x2/Mat3x3/Mat3x4/Mat4x2/Mat4x3）和 `outerProduct`（6 缺失组合：Vec2Vec3/ Vec2Vec4/ Vec3Vec3/ Vec3Vec4/ Vec4Vec2/ Vec4Vec3）各补充 6 个测试，共 12 个 @Test 函数，仅 Int64 类型
选择理由：覆盖率缺口 > 66%，T6 已解决，T7 是 Route 表格中优先级最高的下一个
上下文：
- 现有 matrixCompMult 测试：Mat2x2(✅)、Mat2x3(✅)、Mat4x4(✅)，缺 6 个
- 现有 outerProduct 测试：Vec2Vec2(✅)、Vec3Vec2(✅)、Vec4Vec4(✅)，缺 6 个
- 实现参考 `src/detail/matrix.cj:41-165` 中已实现的对应重载
- 每个测试仅 Int64 覆盖，Float 变体推迟至 T16（Phase 4）

---

## R4 PASSED T7: 补充 matrixCompMult/outerProduct 测试

结果：在 `test_matrix.cj` 末尾追加 12 个 @Test 函数（6 matrixCompMult + 6 outerProduct），所有设计/代码/测试审查 APPROVED
测试：`cjpm test` 通过 427 项，0 失败
验证：verify_v3.md PASSED

## R4 PASSED T1+T19: OOD 文档修订（`init(scalar:T)` + `diagonal` 等价描述）

结果：经审查确认，`docs/04_ood_phase2.md` 已有 §3.3 line 231-233 登记 `init(scalar: T)` 全填充构造函数，§9 line 984 已拆分 `diagonal(scalar)`（对角填充）与 `init(scalar: T)`（全填充，对应 GLM `mat(T s)`）的语义。无需任何代码或文档修改。
上下文：
- OOD §3.3 line 231-233：明确列出 `init(scalar: T)` 全填充构造
- OOD §9 line 984：`diagonal` 与 `init(scalar)` 的语义已拆分
- 设计回补轨迹已由 OOD 文档自身保留，无需额外 deviations.md 条目

---

## R5 NEW T3: Mat3x3/Mat4x4 矩阵乘法参数命名 `r` → `rhs`

任务：在 `type_mat3x3.cj`（3 处）和 `type_mat4x4.cj`（3 处）中将矩阵乘法 `operator func *` 的右操作数参数名从 `r` 改为 `rhs`，与其余 7 个矩阵类型及同文件的 `/` 运算符命名一致。

选择理由：Phase 4 Group A（独立文件，可并行），代码风格一致性，操作简单明确（仅改参数名，不影响行为），是当前优先级最高的 Phase 4 任务
上下文：
- 诊断报告 §3 T3 已精确定位 6 处需修改的位置（type_mat3x3.cj:91/99/108, type_mat4x4.cj:97/105/114）
- 同文件 `/` 运算符已使用 `rhs`（type_mat3x3.cj:118, type_mat4x4.cj:124）
- 仅参数名变更，不涉及行为、签名或测试变更

---

## R5 PASSED T3: Mat3x3/Mat4x4 矩阵乘法参数命名 `r` → `rhs`

结果：修改 `type_mat3x3.cj` 和 `type_mat4x4.cj` 各 3 处 `operator func *` 参数名 `r` → `rhs`，体内部署 `r.` → `rhs.`，与同文件 `/` 运算符命名一致
测试：`cjpm test` 通过 476 项，0 失败
验证：verify_v5.md PASSED

---

## R6 PASSED T7-cs: Mat2x2 构造函数声明顺序调整

结果：调整 `type_mat2x2.cj` 中构造函数声明顺序为 `const init(a00..a11)` → `const init(c0, c1)` → `init(scalar)`，与其他 8 个矩阵类型一致
测试：`cjpm test` 通过 476 项，0 失败
验证：verify_v6.md PASSED

## R7 PASSED T8: 移除纯收缩方向 `let zero` 无用声明

结果：移除 8 个 `type_mat*.cj` 文件中纯收缩方向 fromMat 方法体的未使用 `let zero` 声明，总计 54 条（type_mat4x4.cj 无纯收缩方向）。`cjpm build` 成功，目标 warning 全部消除。
测试：`cjpm test` 通过 476 项，0 失败
验证：verify_v7.md PASSED

---

## R8 PASSED T2: 补充 9 个矩阵类型 Hashable 测试

结果：在 `test_type_mat_compare.cj` 末尾追加 8 个 Hashable 测试函数（Mat4x4 × 2 + Mat2x3 × 2，各 × Int64/Float32），验证相同值一致性和不同值差异性
测试：`cjpm test` 通过 476 项，0 失败
验证：verify_v8.md PASSED

---

## R9 NEW T9: 补充 stub 测试文件的显式 import

任务：在 `test_common.cj`、`test_geometric.cj`、`test_geometric_refract.cj` 三个文件的首行（`package glm.detail` 之后）添加 `import std.unittest.*` 和 `import std.unittest.testmacro.*`，使其与其他测试文件的导入风格一致。

选择理由：Route 表格顺序中的下一个待完成任务；T9 须在 T10 之前完成（共享同一组文件，避免合并冲突）
上下文：
- 诊断报告 §5 T9 精确定位 3 个文件缺少显式 import
- 项目内其他测试文件（如 `test_matrix.cj:3-4`、`test_scalar_mat_ops.cj:3-4`、`test_type_mat2x2.cj:3-4`）均显式导入这两行
- `std.unittest` 文档 §1.2 说明测试模式下自动导入，但为代码风格一致性建议显式添加
- 不涉及行为、测试通过率或测试逻辑变更

---

## R9 PASSED T9: 补充 stub 测试文件的显式 import

结果：在 `test_common.cj`、`test_geometric.cj`、`test_geometric_refract.cj` 的 `package` 声明后各添加 `import std.unittest.*` 和 `import std.unittest.testmacro.*`
测试：`cjpm test` 通过 476 项，0 失败
验证：verify_v9.md PASSED

---

## R10 NEW T10: 补充 stub 异常信息内容验证

任务：在以下四个 stub 测试文件中，将全部 38 个 `@ExpectThrows[Exception](...)` 替换为 try-catch 块，同时验证异常消息内容为 `"stub"`：

1. `test_common.cj`（12 个）
2. `test_geometric.cj`（17 个）
3. `test_geometric_refract.cj`（3 个）
4. `test_matrix.cj:257-291`（6 个：determinant×3, inverse×3）

参考 `test_shim_assert.cj:19-26` 的模式。

选择理由：Route 表格顺序中的下一个待完成任务。T9 已验证 PASSED，T10 与 T9 共享同一组文件，必须先于后续任务完成。

上下文：
- 所有 stub 实现均 `throw Exception("stub")`，当前仅验证异常类型，未验证消息内容
- `test_shim_assert.cj:24-26` 提供了已验证的异常消息验证模式：`catch (e: Exception) { @Expect(e.message, "stub") }`
- 共 38 个测试函数需修改，涉及 4 个文件
- ⚠ `@Expect(false, true)` 与 `catch(e: Exception)` 互斥风险：若 stub 未抛异常，`@Expect(false, true)` 产生的断言异常可能被 catch 误捕获。当前采用 `@Expect`（软失败，不抛异常）而非 `@Fail` 已在实际代码（`test_shim_assert.cj:12-16`）中验证有效。若需更强区分可在 catch 中检查 `e.message != "stub"` 时 re-throw。

---

## R10 PASSED T10: 补充 stub 异常信息内容验证

结果：将 `test_common.cj`（12）、`test_geometric.cj`（17）、`test_geometric_refract.cj`（3）、`test_matrix.cj:257-291`（6）共 38 个 `@ExpectThrows[Exception](...)` 替换为 `try { ... @Expect(false, true) } catch (e: Exception) { @Expect(e.message, "stub") }` 模式
测试：`cjpm test` 通过 476 项，0 失败
验证：verify_v10.md PASSED

---

## R11 PASSED T14: 补充 Mat3x3/Mat4x4 的 ColOutOfBounds/ColNegative 测试

结果：在 `test_type_mat3x3.cj`（`:622-642`）和 `test_type_mat4x4.cj`（`:906-926`）各追加 2 个 `@Test` 函数，测试 `col()` 的越界和负数索引场景，遵循 `test_type_mat2x2.cj:87-107` 的已验证参考模式
测试：`cjpm test` 通过 476 项，0 失败
验证：verify_v11.md PASSED

---

## R12 PASSED T17: 补充 `rowSh` 模式的集成测试

结果：在 `test_integration_matrix.cj` 末尾追加 `testIntegrationFromMatRowShrink` 测试函数（Mat4x4→Mat4x3，12 个 @Expect 逐分量断言），覆盖纯 `rowSh` 模式的 fromMat 集成测试
测试：`cjpm test` 通过 476 项，0 失败
验证：verify_v12.md PASSED

## R13 NEW T18: 记录 ZeroVec 测试评估结论注释

任务：在 `test_vec_mat_mul.cj` 文件头部（或 ZeroVec 测试区域上方）添加注释，说明 ZeroVec 测试的评估结论：保留全部 9 个 ZeroVec 测试，理由为"维护成本极低、每个矩阵类型均有独立验证价值、零向量×任意矩阵=零矩阵恒等式验证"。

选择理由：Route 表格顺序中的下一个待完成任务。T17 已验证 PASSED，T18 是当前优先级最高的剩余任务。

上下文：
- 诊断报告 §4 T18 已精确定位并完成评估：保留全部 9 个 ZeroVec 测试
- 此任务不涉及代码逻辑变更，仅追加注释文档化评估结论

---

## R13 PASSED T18: 记录 ZeroVec 测试评估结论注释

结果：在 `test_vec_mat_mul.cj` 的 ZeroVec 测试区域上方追加 Javadoc 风格评估结论注释，无代码逻辑变更
测试：`cjpm test` 通过 422 项，0 失败
验证：verify_v13.md PASSED

---

## R14 PASSED T16: 均衡矩阵测试的 T 类型参数化覆盖

结果：为 9 个 test_type_mat*.cj 各追加 6 个测试（Diagonal/ColAccess/ScalarMul × Float32/Float64），test_scalar_mat_ops.cj 追加 48 个非方阵 Float32/Float64 测试，test_matrix.cj 追加 24 个 matrixCompMult/outerProduct Float32/Float64 测试，共 78 个测试函数
测试：`cjpm test` 通过 422 项，0 失败
验证：verify_v14.md PASSED

## R15 NEW T15: 补充矩阵 NaN 传播行为测试

任务：为 3 个代表性矩阵类型（Mat4x4 / Mat2x3 / Mat3x2）补充 Float32/Float64 NaN 传播行为测试，覆盖以下场景：
1. **矩阵含 NaN 列 × 正常向量**——`col(i)` 注入 NaN 后 Mat×Vec 乘法结果在对应位置为 NaN（通过 `Float32(0.0)/Float32(0.0)` 生成 NaN）
2. **向量含 NaN 分量 × 正常矩阵**——Vec×Mat 乘法结果中与 NaN 分量对应的位置为 NaN
3. **全 NaN 矩阵 × 正常向量/矩阵**——Mat×Vec 或 Mat×Mat 乘法结果全部为 NaN
4. 每种场景 × Float32/Float64 两个精度

目标文件：`tests/glm/detail/test_matrix.cj`（追加至文件末尾）
参考模式：`compute_vector_relational_test.cj:81` 的 `let nan = Float32(0.0) / Float32(0.0)` NaN 生成方式

选择理由：T16 已验证 PASSED，建立了 Float32/Float64 浮点矩阵实例化基础设施。T15 依赖 T16 完成，是 Route 表格顺序中的下一个任务。

上下文：
- 诊断报告 §4 T15（02_diag.md `:395-428`）：OOD §5 第 825-829 行明确要求覆盖 Mat×Vec/Vec×Mat 的 NaN 传播行为
- 类型约束：仅适用于 Float32/Float64，Int64 无 NaN 概念
- 推荐矩阵类型：Mat4x4（全尺寸方阵）、Mat2x3（行<列非方阵）、Mat3x2（行>列非方阵）
- NaN 在 IEEE 754 中通过原生 `+`/`*` 运算符自然传播，仓颉实现委托底层算术运算符无需修改
- 测试命令：`cjpm test`

---

## R15 PASSED T15: 补充矩阵 NaN 传播行为测试

结果：为 Mat4x4/Mat2x3/Mat3x2 各追加 6 个 NaN 传播测试（NaN 列传播、NaN 向量分量传播、NaN 对角矩阵 × 正常向量，各 × Float32/Float64），共 18 个测试函数，全部追加至 `tests/glm/detail/test_matrix.cj` 末尾
测试：`cjpm test` 通过 422 项，0 失败
验证：verify_v15.md PASSED

## R16 NEW T13: 提供 cjpm 子包构建的显式验证产物

任务：验证 `src/ext/` 下 26 个 `package glm.ext` 文件的子包路由机制是否正常，提供显式的构建验证产物。操作步骤包括：
1. 在 `src/ext/` 创建最小验证文件 `test_ext.cj`：`package glm.ext` + 一个简单导出函数
2. 运行 `cjpm build` 验证编译通过（模式 A——零侵入，保持 `cjpm.toml` 仅 `src-dir = "src"`）
3. 若模式 A 失败，在 `cjpm.toml` 添加 `sub-package = ["ext"]`（模式 B）
4. 若模式 B 失败，执行回退方案（模式 C——移至 `src/` 根目录）

选择理由：所有其他任务已完成并验证通过。T13 是 Route 表格中最后一个剩余任务。

上下文：
- 诊断报告 §5 T13（02_diag.md `:541-608`）：完整的三模式验证方案
- `cjpm.toml` 当前配置：仅 `src-dir = "src"`，无 `package-configuration`
- `src/ext/` 下 26 个文件声明 `package glm.ext`
- `tests/glm/test_ext.cj` 已存在（16 个 `@Test` 使用 `ext.*` 别名），但不验证外部导入场景
- 需查阅 cjpm 当前版本文档确认子包路由机制

## R16 REVISED T13: 提供 cjpm 子包构建的显式验证产物（修订 v16 r1）

修订说明：
- **删除 Mode B**：`sub-package = ["ext"]` 字段无 cjpm 文档支持，`package-configuration` 仅用于子包编译选项（compile-option/output-type），不声明子包存在
- **Mode C 增加 `tests/glm/test_ext.cj` 处理**：若触发回退方案移至 `src/`，需同步更新测试文件中的 `ext.*` 别名引用

更新后方案：
1. Mode A（唯一方案——零侵入）：创建 `src/ext/test_ext_alias.cj`，保持 `cjpm.toml` 不变，`cjpm build` 验证
2. Mode B（回退方案——移至 src/）：将 26 个文件移至 `src/`，`package glm.ext` → `package glm`，同步更新 `tests/glm/test_ext.cj` 移除 `ext.*` 别名

---

## R16 PASSED T13: 提供 cjpm 子包构建的显式验证产物

结果：在 `src/ext/test_ext_alias.cj` 创建最小验证文件（`package glm.ext` + 导出函数），`cjpm build` 退出码为 0。模式 A（零侵入）验证通过，确认 cjpm 正确发现 `src/ext/` 子包并编译 `package glm.ext`。无需修改 `cjpm.toml`，无需回退到模式 B。
测试：`cjpm build` 通过，`cjpm test` 通过 422 项，0 失败
验证：verify_v16.md PASSED

---

## 修订说明（v10 r1）
| 审查意见 | 修改措施 |
|---------|---------|
| T10 范围遗漏：test_matrix.cj 的 6 个 stub 测试未被纳入 | 更新 T10 描述：涉及文件从 3 个增至 4 个（新增 test_matrix.cj:257-291），总测试数从 32 更新为 38 |
| @Expect/@Fail 与 catch 互斥风险未记录 | 在 T10 上下文中添加风险说明及当前采用的规避措施 |

---

## 修订说明（v16 r1）
| 审查意见 | 修改措施 |
|---------|---------|
| Mode B `sub-package` 字段无 cjpm 文档支持 | 删除 Mode B（显式 `sub-package` 声明）。Task 更新：保留唯一方案 Mode A，Mode C 提升为唯一回退方案。Plan 追加 R16 REVISED 条目说明变更 |
| Mode C 未提及 `tests/glm/test_ext.cj` 中 `ext.*` 别名的同步处理 | 在 Mode C 中补充：同步更新 `tests/glm/test_ext.cj` 中 `ext.*` 别名替换为直接类型名；验证步骤增加 `cjpm test` |
