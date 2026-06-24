# R6: `ext/` 别名文件 + `fwd.cj` + `lib.cj` + 集成测试

审查时间：2026-06-23

### 审查范围

**核心实现文件**：
- `cjglm/src/ext/matrix_float{2x2,2x3,2x4,3x2,3x3,3x4,4x2,4x3,4x4}.cj`（9 个 float 矩阵别名）
- `cjglm/src/ext/matrix_double{2x2,2x3,2x4,3x2,3x3,3x4,4x2,4x3,4x4}.cj`（9 个 double 矩阵别名）
- `cjglm/src/ext/vector_float{1,2,3,4}.cj`（4 个 float 向量别名）
- `cjglm/src/ext/vector_double{1,2,3,4}.cj`（4 个 double 向量别名）
- `cjglm/src/fwd.cj`（公共 API 类型别名层）
- `cjglm/src/lib.cj`（公共导出入口）

**测试文件**：
- `cjglm/tests/glm/test_ext.cj`
- `cjglm/tests/glm/test_fwd.cj`
- `cjglm/tests/glm/test_lib.cj`
- `cjglm/tests/glm/test_integration_matrix.cj`

**OOD 参考**：`docs/04_ood_phase2.md` §2「模块划分」、§3.2「类型映射关系」、§2「cjpm 子包构建预验证 — 增强方案」
**实现交叉验证**：`cjglm/src/detail/type_mat4x4.cj:235-239`（Mat4x4←Mat4x2 偏差实现）、`cjglm/src/detail/type_mat2x2.cj:11-14`（`init(scalar)` 构造函数）
**单元测试交叉验证**：`cjglm/tests/glm/detail/test_type_mat4x4.cj:633-653`（`testMat4x4FromMat6aMat4x2Deviation`）

### 发现

#### [严重] `testIntegrationFromMatDeviation` 对 Mat4x4←Mat4x2 偏差方向的预期值与 OOD §3.3 第 347 行规定及实际实现相反

- **位置**：`cjglm/tests/glm/test_integration_matrix.cj:338-341`
- **描述**：该测试断言 `Mat4x4.fromMat(Mat4x2(...), Float32(1.0))` 应保留源矩阵列 2/3 的前两行数据：
  ```cangjie
  @Expect(m44.c2.x, Float32(5.0))   // 实际：0.0
  @Expect(m44.c2.y, Float32(6.0))   // 实际：0.0
  @Expect(m44.c3.x, Float32(7.0))   // 实际：0.0
  @Expect(m44.c3.y, Float32(8.0))   // 实际：0.0
  ```
  然而 OOD §3.3 第 347 行明确说明 Mat4x4←Mat4x2 是已知 GLM 偏差：GLM 丢弃源列 2/3 的前两行数据并填入单位矩阵对角线（`(0,0,1,0)` 和 `(0,0,0,1)`）。OOD 第 391 行表格中此方向标注为 🚨 **DEVIATION**。`type_mat4x4.cj:238` 实际实现为：
  ```cangjie
  Mat4x4(
    Vec4<T, Q>(m.c0.x, m.c0.y, zero, zero),       // c0 = (src.c0.x, src.c0.y, 0, 0)
    Vec4<T, Q>(m.c1.x, m.c1.y, zero, zero),       // c1 = (src.c1.x, src.c1.y, 0, 0)
    Vec4<T, Q>(zero, zero, one, zero),            // c2 = (0, 0, 1, 0) ← DEVIATION
    Vec4<T, Q>(zero, zero, zero, one)             // c3 = (0, 0, 0, 1) ← DEVIATION
  )
  ```
  对应的单元测试 `test_type_mat4x4.cj:633-653`（`testMat4x4FromMat6aMat4x2Deviation`）正确断言了偏差行为（`m.c2.x == 0`、`m.c2.z == 1` 等）。**集成测试与单元测试自相矛盾**，且与 OOD 设计文档及实际实现均不符。
- **影响**：测试运行时将失败 4 个 `@Expect`（m44.c2.x/y、m44.c3.x/y）。这是一个会让 CI 失败的硬错误，必须修复后才能合并。该问题不在 R3-A1（已知偏差处理）的范围内，因此未在之前轮次中暴露。
- **建议**：修正 `test_integration_matrix.cj:338-341` 的预期值为 OOD/实现对应的偏差行为：
  ```cangjie
  @Expect(m44.c2.x, Float32(0.0))
  @Expect(m44.c2.y, Float32(0.0))
  @Expect(m44.c2.z, Float32(1.0))
  @Expect(m44.c2.w, Float32(0.0))
  @Expect(m44.c3.x, Float32(0.0))
  @Expect(m44.c3.y, Float32(0.0))
  @Expect(m44.c3.z, Float32(0.0))
  // 末尾的 @Expect(m44.c3.w, Float32(1.0)) 已正确，无需改动
  ```

#### [一般] fwd.cj 矩阵 qualifier 别名命名风格偏离 GLM 实际约定

- **位置**：`cjglm/src/fwd.cj:367-394`
- **描述**：当前 qualifier 别名使用 `Highpmat2`、`Mediumpmat2`、`Lowpmat2`、`Highpdmat2` 等 PascalCase + 小写类型的命名（`Highp` + `mat` + `2`）。GLM 实际约定为全小写：`highp_mat2`、`mediump_mat2`、`lowp_mat2`、`highp_dmat2` 等（参见 GLM 1.0.3 `glm/ext.hpp` 中的 qualifier 别名宏定义）。当前命名虽然与仓颉已有的 `HighpIVec2`、`HighpDVec2` 等向量别名风格一致（统一为 `Highp*` 前缀），但与 GLM 的全小写风格不一致。
- **影响**：C++ GLM 用户迁移到仓颉时需适配大小写（如 `highp_mat2` → `Highpmat2`）。命名风格与 C++ 生态习惯不符。
- **建议**：评估是否在保持与现有 `HighpIVec2` 等命名一致的前提下，**额外**补全 GLM 全小写别名作为 `Highpmat2` 的别名（类似 `Mat2x2` 与 `mat2` 同时存在的双别名模式）。如果评估后判定维持 PascalCase 风格是有意决定，则在 `deviations.md` 中记录此命名偏差（DEV-15 候选）。

#### [一般] fwd.cj 别名存在冗余定义（同一底层类型被多个别名指向）

- **位置**：`cjglm/src/fwd.cj:327, 367`（`Mat2x2` 与 `Highpmat2` 同义）、`cjglm/src/fwd.cj:347, 382`（`DMat2x2` 与 `Highpdmat2` 同义）；类似还有 `Mat3x3`/`Highpmat3`、`Mat4x4`/`Highpmat4`、`DMat3x3`/`Highpdmat3`、`DMat4x4`/`Highpdmat4`（共 6 对）
- **描述**：每个 qualifier 别名展开后都指向相同的底层类型：
  - `Mat2x2 = detail.Mat2x2<Float32, PackedHighp>`（line 327）
  - `Highpmat2 = detail.Mat2x2<Float32, PackedHighp>`（line 367）—— **与 `Mat2x2` 完全等价**
  - `Mediumpmat2 = detail.Mat2x2<Float32, PackedMediump>`（line 372）
  - `Lowpmat2 = detail.Mat2x2<Float32, PackedLowp>`（line 377）
  - `DMat2x2 = detail.Mat2x2<Float64, PackedHighp>`（line 347）
  - `Highpdmat2 = detail.Mat2x2<Float64, PackedHighp>`（line 382）—— **与 `DMat2x2` 完全等价**
  - 重复模式适用于 `Mat3x3/Highpmat3/DMat3x3/Highpdmat3` 和 `Mat4x4/Highpmat4/DMat4x4/Highpdmat4`
- **影响**：6 对冗余别名增加文件大小（约 6 行）和维护成本（修改底层类型时需同步两处）。不影响功能正确性，但与精简代码原则不符。
- **建议**：移除 `Highpmat2`/`Highpmat3`/`Highpmat4`/`Highpdmat2`/`Highpdmat3`/`Highpdmat4` 这 6 个与默认 qualifier 同义的别名，保留 `Mat2x2`/`Mat3x3`/`Mat4x4`/`DMat2x2`/`DMat3x3`/`DMat4x4` 作为默认 highp 别名即可。如需 GLM 全量兼容性，在 deviations.md 中记录此精简决定（DEV-16 候选）。

#### [一般] cjpm 子包构建未提供显式验证产物（OOD §2 第 164-171 行原型验证计划不完整）

- **位置**：`cjglm/cjpm.toml`、`cjglm/src/ext/*.cj`
- **描述**：OOD §2 第 147-171 行明确要求 cjpm 子包构建预验证的原型验证计划：
  1. 创建最小测试文件（已完成，`test_ext.cj` 存在）
  2. 运行 `cjpm build` 确认编译通过（**未在提交中验证**）
  3. 验证外部项目 `import glm.ext.test_ext.{ test_alias }` 可解析（**未在提交中验证**）
  4-5. 失败时的回退方案（**未在提交中验证**）
  
  cjpm.toml 中仅设置 `src-dir = "src"`，无显式 `package-configuration` 或 `sub-package` 配置。若 cjpm 不支持自动发现 `src/ext/` 子目录作为 `glm.ext` 子包，则 24 个 ext/ 文件全部无法被外部项目正确导入，所有 `ext.*` 类型解析将失败。范围界定文件未提及此风险的验证记录。
- **影响**：高风险。如果 cjpm 不支持 `src/ext/ → package glm.ext` 的自动映射，整个 ext/ 子包机制将失效，需要回退到 OOD §2 方案二（将 ext/ 文件移至 src/ 根目录）或方案三（独立子模块）。
- **建议**：在合并前必须在 CI 或本地执行一次完整的 `cjpm build` 和 `cjpm test`，记录 cjpm 版本和构建结果。若 cjpm 不支持自动发现，需在 cjpm.toml 中添加显式 `package-configuration` 映射，或回退到方案二。在 `verify_*` 文档中显式记录验证结果。

#### [轻微] `test_ext.cj` 的 DMat 和 Vec 别名测试覆盖率不足

- **位置**：`cjglm/tests/glm/test_ext.cj:61-87`
- **描述**：9 个 DMat 别名中仅测试 2 个（`DMat2x2`、`DMat4x4`，line 61-69），缺失 `DMat2x3`/`DMat2x4`/`DMat3x2`/`DMat3x3`/`DMat3x4`/`DMat4x2`/`DMat4x3` 共 7 个；8 个 Vec 别名中仅测试 3 个（`Vec2`、`Vec4`、`DVec4`，line 73-87），缺失 `Vec1`、`Vec3`、`DVec1`、`DVec2`、`DVec3` 共 5 个。
- **影响**：测试作为 smoke test 不足以验证 24 个 ext/ 别名全部可解析。若某个别名文件存在拼写错误或类型解析问题，无法被现有测试发现。
- **建议**：为 24 个 ext/ 别名各添加一个最小化 smoke test（可参考 `testExtMat4x4Alias` 的 2 行模板），确保所有 24 个 ext/ 文件都经过编译验证。

#### [轻微] `test_fwd.cj` 短别名测试缺失 `dmat3`

- **位置**：`cjglm/tests/glm/test_fwd.cj:310-315`（`testFwdDMatShortAliases`）
- **描述**：`testFwdDMatShortAliases` 测试 `dmat2` 和 `dmat4`，但遗漏 `dmat3`（对应 `DMat3x3`/`dmat3`，已在 fwd.cj:349/357 定义）。同类 float 测试 `testFwdMatShortAliases`（line 287-294）包含 `mat2`/`mat3`/`mat4` 全部 3 个方阵短别名。
- **影响**：单个别名的测试覆盖遗漏，不影响功能正确性。
- **建议**：在 `testFwdDMatShortAliases` 中补充 `dmat3` 的断言。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 1 |
| 一般 | 3 |
| 轻微 | 2 |

### 总评

`ext/` 别名文件 24 个、fwd.cj 矩阵别名、lib.cj 公共导入三者在**结构与职责划分**上严格遵循 OOD §2 第 160 行的推荐模式（fwd.cj 集中定义全部别名，ext/ 文件仅做 `public import` re-export），代码风格一致、文件结构清晰。

**主要问题**：`test_integration_matrix.cj` 的 `testIntegrationFromMatDeviation`（line 331-344）对 Mat4x4←Mat4x2 偏差方向的预期值与 OOD §3.3 第 347 行规定、`type_mat4x4.cj:235-239` 实现、以及 `test_type_mat4x4.cj:633-653` 单元测试**全部相反**，是本轮最严重的阻塞问题——若不修复将导致 CI 失败，必须在合并前修正。

**次要问题**：fwd.cj 存在命名风格偏离 GLM 习惯（`Highpmat2` vs GLM 的 `highp_mat2`）和 6 对冗余别名定义，需要在 OOD 或 deviations.md 中显式确认设计意图。cjpm 子包构建的原型验证未在提交中留下验证产物，是 OOD §2 第 164-171 行原型验证计划的执行缺失，建议合并前补做一次 `cjpm build` 验证。

**总评结论**：本轮审查**不通过**，需先修复严重级别的偏差测试预期值错误（同时建议补做 cjpm 子包验证），再考虑合并。
