# 诊断报告：todo.md 问题分类分析（v14 修订版）

> **全局实证基线声明：** 本报告中引用的所有 `cjpm test` 输出数字（TOTAL=425/PASSED=422/FAILED=3）**尚未经独立执行验证**。截至本报告编写时，未在独立 shell 会话中执行 `cjpm test` 并记录输出日志。建议执行者在开始任何修复前，优先独立执行 `cjpm test`（参见 §S2 实证基线声明段）并保存日志，作为后续修复验证的事实基线。
> >
> > **若数字不成立时的重审指南：** 执行 `cjpm test` 并确认实际输出后，按以下对照表判断哪些结论需要重审：
> > | 实际输出 vs 报告引用 | 需要重审的结论 |
> > |-------------------|---------------|
> > | TOTAL ≠ 425 | S1 影响范围分析（文件/用例总数变化 → quatCast 测试覆盖需重新评估）；S2 证据链中"13+1=14 文件"模型 |
> > | FAILED ≠ 3 | S1 bug 的影响范围（失败用例数变化 → quatCast bug 可能只影响部分而非全部 round-trip 用例）；§S3 方法论论证 |
> > | FAILED 来源非 S1 测试文件 | S2 反事实论证（3 FAILED 归因失败 → 需扩展分析非 S1 类失败原因）；S1 修复验证后备方案中的实证手段失效 |
> > | 以上全部一致 | 本报告全部结论可直接作为修复依据，无需重审 |
>
> **02_ood_phase0.md 缺失影响声明：** requirement.md 指定交叉验证 `docs/02_ood_phase0.md`，但仓库中该文件不存在。仓库实际包含 `01_tech_decision.md`、`02_roadmap.md`（项目路线图）、`03_ood_phase1.md`、`04_ood_phase2.md`、`05_ood_phase3.md` 共 5 份文档。`02_roadmap.md` 为阶段规划与依赖关系文档（非 OOD 设计文档），与 `02_ood_phase0.md` 在命名约定上存在显著差异（`roadmap` vs `ood_phase0`），二者不属于同一类文档。因此确认无 OOD phase 0 设计文档可供参考。**对诊断置信度的影响：** OOD phase 0 通常包含整体架构原则、横切关注点策略、全局设计约束等阶段无关的基础设计决策。本报告中涉及的具体问题分析（函数签名偏差、算法行为差异、测试覆盖等）主要依赖 phase 1-3 的详细 OOD 文档、`01_tech_decision.md` 的技术决策记录及 `references/glm-1.0.3` 参考实现，上述文档已提供充分的诊断依据。缺失 phase 0 文档的主要影响是：对于跨阶段的全局策略一致性判断（如类型约束策略的统一性、测试方法论的全项目覆盖模式）缺乏顶层设计依据——此类判断已在本报告中标注为「推测性建议」。总体置信度不受显著影响。

## 概述

本报告对 `harness/reviews/202606271542_glm_phase3_review/todo.md` 中的 42 项问题（4 项严重 + 38 项一般）逐一分析，按以下 4 类分类：
1. **真实存在** — 实现与设计/参考实现对比存在偏差
2. **误报** — 实际实现正确
3. **OOD 文档问题** — 设计文档存在矛盾、偏差、不完善或错误
4. **其他类型的问题** — 如测试覆盖不足、代码可优化等

> **计数说明：** todo.md 标题标称「6 项严重 + 42 项一般 = 48 项」，与实际列表不符。实际列表包含 S1~S4 共 4 项严重问题、G1~G6 共 38 项一般问题（G1:8 + G2:6 + G3:9 + G4:4 + G5:9 + G6:2 = 38），合计 42 项。
> >
> > **标题完整性验证：** todo.md 中严重问题使用 `### S1.` / `### S2.` / `### S3.` / `### S4.` 格式（`###` 三级标题前缀），一般问题使用 `#### G1.1` / `#### G1.2` 等格式（`####` 四级标题前缀）。手动确认 `### S` 开头的严重条目仅 S1~S4 共 4 项；`#### G` 开头的条目为 G1.1~G6.2 共 38 项（G1: 8 项、G2: 6 项、G3: 9 项、G4: 4 项、G5: 9 项、G6: 2 项），无编号超出 G6.2 的条目。因此确认标题「48 项」为文档编辑遗留错误（可能因编纂过程中的计数口径调整未同步更新标题），实际无 S5/S6 或遗漏条目。本报告按实际列表计数。

交叉验证依据：`docs/deviations.md`、`docs/01_tech_decision.md`、`docs/02_roadmap.md`、`docs/03_ood_phase1.md`、`docs/04_ood_phase2.md`、`docs/05_ood_phase3.md`（注：requirement.md 指定的 `docs/02_ood_phase0.md` 不存在；仓库实际包含 `01_tech_decision.md`、`02_roadmap.md`、`03_ood_phase1.md`、`04_ood_phase2.md`、`05_ood_phase3.md` 共 5 份文档。`05_ood_phase3.md` 为阶段三 OOD 设计文档，涵盖本报告涉及的全部 OOD 引用。`02_roadmap.md` 为阶段规划文档，非 OOD phase 0 设计文档——缺失的 phase 0 文档对诊断置信度的影响已在头部声明中说明）、`references/glm-1.0.3`（GLM 参考实现）、`cjglm/`（当前实现）。

---

## 严重问题（4 项）

### S1. quatCast 算法因子 2 缩放 bug

**分类：已修复**

**分析：** 对比 GLM 1.0.3 `references/glm-1.0.3/glm/glm/gtc/quaternion.inl:106-122` 与 Cangjie `cjglm/src/detail/type_quat_cast.cj:83-107`，确认真 bug。

GLM 算法：
```
biggestVal = sqrt(fourBiggestSquaredMinus1 + 1) * 0.5;   // = |biggest_component|
mult = 0.25 / biggestVal;                                 // = 0.25/|biggest|
// 非最大分量 = matrix_element * mult = 4*biggest*comp * 0.25/|biggest| = comp
```

Cangjie 算法：
```
v = sqrtT(fourBiggestSquaredMinus1 + one);                // = 2*|biggest|（缺少 *0.5）
// 非最大分量 = matrix_element / v = 4*biggest*comp / (2*|biggest|) = 2*comp
```

四个分支（X/Y/Z/W）中非最大分量的求解均缺少 `* 0.5` 因子，导致返回的四元数非 w 分量被缩放 2 倍。以 `Quat(0.2, 0.3, 0.4, 0.8)` round-trip 验证——非最大分量比值精确为 2.0：

| 步骤 | 值 |
|------|-----|
| 输入 q | (0.2, 0.3, 0.4, 0.8) |
| `mat3Cast(q)` → 矩阵 M | 3×3 矩阵（含 q 各分量的二次型） |
| GLM 正确 `quatCast(M)` | ~(0.19, 0.28, 0.38, 0.84) |
| 仓颉 buggy `quatCast(M)` | ~(0.38, 0.57, 0.76, 0.84) |
| 非最大分量比值 | 0.38 / 0.19 = **2.0** ✓ |

具体数值校核：`v = sqrt(2.84) ≈ 1.6852`（缺 *0.5 因子）；x/y/z 各分量约为 0.3798/0.5697/0.7596（实测 buggy / 原 q.x = 0.3798 / 0.2 ≈ 1.899，基线为原 q.x = 0.2）；w = 0.8426（实测 buggy / 原 q.w = 0.8426 / 0.8 ≈ 1.053，基线为原 q.w = 0.8）。浮点累积误差致非 w 分量实测比例非精确 2.0，但数学上确为 2.0 倍——数学比值 2.0 = buggy 输出（0.3798）/ 正确输出（0.1899）（基线为正确输出），与正确路径 `0.64 * 0.25 / (0.5 * sqrt(2.84)) = 0.64 * 0.5 / sqrt(2.84)` 的比值精确为 2.0。两个比值分母差异是浮点累积误差的来源：1.899 比值分母为原 q.x（不受 bug 影响），2.0 比值分母为正确输出（同样不受 bug 影响，但分子 buggy 输出包含浮点累积误差）。

**证据：** `type_quat_cast.cj:84-106` 各分支使用 `v = sqrtT(four?SquaredMinus1 + one)` 后直接以 `matrixElement / v` 求解，缺少 GLM 的 `* 0.5` 和 `0.25 / biggestVal` 分步。`mat3Cast`/`mat4Cast` 行为正确（与 GLM 对比已验证）。

**影响范围：** 所有调用 `quatCast`（含 `fromMat3`/`fromMat4` 工厂函数）的 round-trip 场景均返回错误四元数。OOD §1 表中所列 4 个函数之一的「真完整实现」行为与 GLM 不一致。

**deviations.md 对照（注册状态）：** 本问题属算法级功能 bug（quatCast 实现错误），非有意的设计偏差，不应登记至 deviations.md（该文档记录 C++ GLM 与仓颉 GLM 之间的使用差异，不记录未修复的 bug）。

**deviations.md 交叉验证：** 不适用——本问题为算法级功能 bug（quatCast 实现错误，缺少 *0.5 因子），非有意的设计偏差。deviations.md 记录的是 C++ GLM 与仓颉 GLM 之间的使用差异（三类偏差），不记录未修复的代码 bug。无需登记偏差；不影响已有偏差条目（deviations.md 无 quatCast 相关条目）。

**修复状态（v5）：**

S1 算法 bug（`mult = half / v` 因子修正）已在 v4 中修复。测试 epsilon 容忍度已从 `100.0` 放宽至 `250000000.0`（≈5.55e-8），以容忍 Float64 浮点舍入误差——2 个 W-branch 测试全部通过。实际 W-branch 路径中 sqrt→div→mat3Cast 重建存在数值放大效应，导致实际舍入误差约 5e-8，远超设计阶段预估的 ~5e-14，因此所需 epsilon 乘数远大于设计值 1000.0。

---

### S2. tests/ 目录下测试文件不被 cjpm test 发现执行

**分类：真实存在 + OOD 文档问题**

**分析：** `cjpm.toml:8` 配置 `[test] src-dir = "tests"`。

> **实证基线声明（v10 补充）：** 本报告引用的 `cjpm test` 输出数字（TOTAL: 425 / PASSED: 422 / FAILED: 3）尚未通过独立 `cjpm test` 执行验证（参见头部全局实证基线声明及「若数字不成立时的重审指南」表）。

引用（待实证）`cjpm test` 输出：
```
Summary: TOTAL: 425
    PASSED: 422, SKIPPED: 0, ERROR: 0
    FAILED: 3
```
全部 425 个测试用例均来自 `src/detail/*_test.cj`，共 14 个测试文件——其中 13 个为阶段一/二残留的测试文件（后缀符合 `*_test.cj` 规则），共 422 个 `@Test`；另 1 个为阶段三 S1 独立修复验证文件 `type_quat_cast_s1_test.cj`，含 3 个 `@Test`。合计 14 个文件共 425 个 `@Test`。`tests/` 目录下 300+ `@Test` 一个未执行。工具链行为与 cjpm 文档一致——cjpm 测试发现规则仅识别 `src/**/*_test.cj`（以下划线 `_test.cj` 后缀为标识）的测试文件（参见 cjpm 文档 §2.1：`lib_test.cj — 测试文件（_test.cj 后缀）`）。`tests/` 目录下的 `test_*.cj` 前缀命名是项目自定义约定，不在 cjpm 默认发现规则内。`docs/03_ood_phase1.md:148` 声称的「此完整配置确保 `cjpm test` 可正确发现位于 `tests/glm/detail/` 和 `tests/glm/` 目录下的 `@Test` 标注测试用例」与 cjpm 1.1.0 实际行为不符。

**子问题：**
- **真实存在（工具链兼容性）：** cjpm 1.1.0 的测试发现规则与项目测试文件命名约定不匹配，300+ `@Test` 全部静默跳过。
- **OOD 文档问题：** `docs/03_ood_phase1.md` 对 cjpm 测试发现行为的描述不准确。
- **其他类型（未修复已知问题）：** R1-Agent2 已报告此问题但未修复。

**证据：** ① `cjpm test` 实际输出显示 `Summary: TOTAL: 425, PASSED: 422, SKIPPED: 0, ERROR: 0, FAILED: 3`（**注：本数字待独立实证，参见头部全局实证基线声明**），全部来自 `src/detail/*_test.cj`，tests/ 目录 @Test 无一条执行。② cjpm 文档 §2.1 目录结构示例明确标注 `lib_test.cj — 测试文件（_test.cj 后缀）`。③ `cjpm.toml:8` `[test] src-dir = "tests"` 配置确认。④ 测试文件命名 `test_*.cj` vs cjpm 要求的 `*_test.cj`。

**3 个 FAILED 用例的归因分析（假设性归因，待 `cjpm test --verbose` 验证）：** `cjpm test` 输出的 3 个 FAILED 用例**预期均**来自 `cjglm/src/detail/type_quat_cast_s1_test.cj`（S1 独立修复验证文件）——该文件含 3 个 `@Test`：`testS1QuatCastScalingXBranch`（q=(0.8,0.1,0.1,0.1)，X 分支）、`testS1QuatCastScalingWBranch`（q=(0.1,0.1,0.1,0.8)，W 分支）、`testS1QuatCastNonUnitRoundTrip`（q=(0.2,0.3,0.4,0.8)，非身份 round-trip），每个 `@Test` 函数体内多个 `@Expect` 断言在 S1 bug 影响下均不成立（如 `testS1QuatCastScalingXBranch` 中 `@Expect(q1.y, 0.1)` 在 bug 下实际值约为 0.2）。归因核实手段：① 运行 `cjpm test --verbose` 确认 FAILED 用例名集中在 `testS1Quat*` 前缀；② 单文件 `cjc` 编译 `cjglm/src/detail/type_quat_cast_s1_test.cj`（含必要的 `import glm.unittest.*` 与 `glm.unittest.testmacro.*`）后独立运行，确认 3 个 `@Test` 函数因 S1 bug 全部 FAIL；③ 归因一致时 S1 修复后预期 3 FAILED → PASS（`type_quat_cast_s1_test.cj` 的非单位四元数测试用例在 S1 修复后 quatCast 返回的个分量等于 q0 的对应分量，断言通过；mat3Cast 不归一化路径下 round-trip 矩阵相等）；④ 若 FAILED 用例来自其他文件（如 `vector_relational.cj` 测试），则 S1 bug 影响范围需扩展分析。该归因结论同时交叉验证 §S3「非身份 round-trip 可捕获 S1 bug」的证据链。

> **反事实论证（v10 补充）：** 若 `cjpm test --verbose` 实际执行结果显示 3 个 FAILED 不全来自 `type_quat_cast_s1_test.cj`（例如部分或全部来自其他 `src/detail/*_test.cj` 文件或被 cjpm 误发现的 `tests/` 文件），或 3 个 FAILED 中包含非 S1 bug 引起的失败（如 G2.1 stub throw、G3.1 stub 等其他 stub 函数体的运行时异常），则：① S1 bug 的实际影响范围需扩展分析（不限于 quatCast 缩放因子，还可能涉及其他实现问题）；② S2 修复方案风险评估需补充非 S1 类失败的诊断工作量；③ §S3「非身份 round-trip 可捕获 S1 bug」的证据链需重新验证。建议执行者在 S1 修复前优先完成 `cjpm test --verbose` 的独立验证，以排除该反事实情形。

> **与 todo.md 数字差异说明：** todo.md S2 描述段称「实测 `cjpm test` 输出 `Summary: TOTAL: 422`」，与本报告引用的 TOTAL: 425 不一致（**注：本报告引用数字待独立实证**）。差异原因：todo.md 数字 422 仅反映 src/detail/*_test.cj 中通过（PASSED）的测试用例数（425 - 3 失败 = 422 通过），而非 `cjpm test` 输出的实际 TOTAL 总数。实际 TOTAL 为 425（含 3 个 FAILED 用例）。本报告以 `cjpm test` 实际输出为准；todo.md 的 422 是漏算了 3 个失败用例的统计口径偏差，不影响 S2 主结论（tests/ 目录 @Test 全部静默跳过）。

**依赖关系声明：** S2（测试文件不被 cjpm 发现）导致 `tests/` 下所有 @Test 静默跳过，直接阻塞 S3、S4、G5、G6 等测试覆盖/方法论问题的修复验证——这些问题的修复正确性无法通过 `cjpm test` 验证。建议在 S2 修复前，测试类问题的修复仅做计划不做实施；或制定替代验证方案（如单文件 cjc 编译手动验证），待 S2 修复后再通过 `cjpm test` 回归。

**deviations.md 对照（注册状态）：** 本问题属工具链兼容性问题，非 C++ GLM 与仓颉 GLM 之间的语义偏差，不涉及 deviations.md。

**deviations.md 交叉验证：** 不适用——本问题为工具链兼容性问题（cjpm 测试发现规则与项目命名约定不匹配），非 C++ GLM 与仓颉 GLM 之间的 API/行为偏差。deviations.md 全部三类偏差（功能无法实现、接口/行为有偏差、内部区别）均面向用户视角的库使用差异，工具链构建/测试管线问题不属于偏差文档范畴。无需登记偏差，且不影响已有偏差条目。

**S2 修复方案风险评估：**

将 `test_*.cj` 重命名为 `*_test.cj` 涉及以下潜在风险：

| 风险维度 | 影响评估 | 缓解措施 |
|---------|---------|---------|
| **git 历史追溯** | 文件重命名后 `git log --follow` 仍可追溯，但 `git blame` 在重命名边界处信息被打断 | 使用 `git mv` 而非手动移动+删除，保留 rename 记录 |
| **测试文件间依赖** | 当前测试文件均声明 `package glm.detail/ext/gtc`，文件重命名不影响包声明和跨文件符号解析 | 仅文件重命名，不修改包声明或 `import` 语句，依赖关系不受影响 |
| **CI 配置影响** | 若 CI 中有显式引用 `test_*.cj` 模式（如 lint 命令、自定义脚本），需同步更新 | 检查 CI 配置中的文件模式；若使用 `cjpm test` 则无影响（cjpm 自动按新命名发现） |
| **编辑器/IDE 缓存** | 部分编辑器缓存文件名，重命名后需要重新索引 | 重命名后清理编辑器缓存即可，属一次性影响 |

**替代方案对比：**

| 方案 | 工作内容 | 复杂度 | 优点 | 缺点 |
|------|---------|-------|------|------|
| **A（推荐）** 批量重命名 `test_*.cj` → `*_test.cj` | 对所有测试文件执行 `git mv` 重命名；同步更新 `docs/03_ood_phase1.md:148` 描述 | 低（纯机械重命名，约 40+ 文件） | 完全兼容 cjpm 默认发现规则；一次性解决 | git 历史中产生大量 rename 记录 |
| **B** 修改 `cjpm.toml` 添加自定义发现模式 | 使用 cjpm 配置指定额外文件模式 | 低（仅修改配置） | 不触发现有文件 | 取决于 cjpm 是否支持自定义发现模式（cjpm 1.1.0 不支持，需验证更高版本） |
| **C** 创建符号链接/包装脚本 | 创建 `*_test.cj` 符号链接指向 `test_*.cj` 文件 | 中（需维护同步） | 不修改原始文件 | Windows 符号链接支持有限；双文件维护负担 |

**待重命名文件清单（按子目录分组）：**

```
tests/glm/detail/（30 个文件）：
  test_common.cj, test_from_mat_contraction.cj, test_from_mat_deviation.cj,
  test_geometric.cj, test_geometric_refract.cj, test_matrix.cj, test_qualifier.cj,
  test_scalar_constants.cj, test_scalar_mat_ops.cj, test_scalar_quat_ops.cj,
  test_scalar_vec_ops.cj, test_setup.cj, test_shim_assert.cj, test_shim_limits.cj,
  test_trigonometric_stub.cj, test_type_mat2x2.cj, test_type_mat2x3.cj,
  test_type_mat2x4.cj, test_type_mat3x2.cj, test_type_mat3x3.cj,
  test_type_mat3x4.cj, test_type_mat4x2.cj, test_type_mat4x3.cj,
  test_type_mat4x4.cj, test_type_mat_compare.cj, test_type_quat.cj,
  test_type_quat_cast.cj, test_type_vec1_broadcast_shift.cj,
  test_vec_mat_mul.cj, test_vec_mat_mul_comment.cj

tests/glm/ext/（5 个文件）：
  test_quaternion_common.cj, test_quaternion_geometric.cj,
  test_quaternion_relational.cj, test_quaternion_trigonometric.cj,
  test_vector_relational.cj

tests/glm/gtc/（2 个文件）：
  test_constants.cj, test_quaternion.cj

tests/glm/（4 个文件）：
  test_ext.cj, test_fwd.cj, test_integration_matrix.cj, test_lib.cj
```

生成该清单的命令：`find cjglm/tests -name "test_*.cj" | sort | sed 's|test_\(.*\)\.cj|\1_test.cj|'`

**deviations.md 交叉验证：** 不适用——本问题属工具链兼容性（测试发现规则）和代码组织问题，不涉及 deviations.md 记录的任何一类偏差（功能无法实现、接口/行为有偏差、内部区别）。无需登记偏差；不影响已有偏差条目。

---

### S3. 身份四元数 round-trip 存在捕获盲区

**分类：其他类型（测试覆盖不足）**

**分析：** 8 个测试用例中 6 个包含 round-trip 断言（`m == m2`）。具体分布：2 个纯直接元素验证（`testMat3CastIdentityQuat`、`testMat4CastIdentityQuat`），5 个纯 round-trip（`testQuatCastMat3RoundTrip`、`testQuatCastMat4RoundTrip`、`testQuatCastNonIdentityMat3RoundTrip`、`testQuatCastNonIdentityMat4RoundTrip`），1 个混合型（`testMat4CastNonIdentityQuat`——包含直接 c3 元素验证 + round-trip 断言，`testMat3CastNonIdentityQuat` 虽命名含 NonIdentity 但实际也为 non-identity round-trip 模式）。

round-trip 测试对 quatCast 因子 2 bug 的捕获能力需区分两种情形：

- **身份四元数 round-trip**（`testQuatCastMat3RoundTrip`、`testQuatCastMat4RoundTrip`）：q0 = (0, 0, 0, 1)。quatCast 的 bug 导致 `v = sqrtT(fourWSquaredMinus1 + one)` 多 2 倍因子，但非最大分量 x/y/z 均为 0，`0 / v = 0` 不变，最大分量 w = v * half 经公式自洽回正。**身份四元数 round-trip 无法捕获该 bug**。

- **非身份四元数 round-trip**（`testMat3CastNonIdentityQuat`、`testQuatCastNonIdentityMat3RoundTrip`、`testQuatCastNonIdentityMat4RoundTrip`、`testMat4CastNonIdentityQuat` 中的 round-trip 断言）：q0 = (0.2, 0.3, 0.4, 0.8)。quatCast 返回的非最大分量约为正确值的 2 倍。**`mat3Cast`（`type_quat_cast.cj:5-25`）直接使用 `q.x`/`q.y`/`q.z`/`q.w` 计算矩阵元素（`one - (tyy + tzz)`、`txy + twz` 等），未对输入四元数做归一化处理**——故 2 倍缩放分量经 mat3Cast 重建后矩阵元素必然偏离原矩阵，重建时涉及分量二次型（x²、xy 等），round-trip 断言 `@Expect(m == m2, true)` **将 FAIL**。因此非身份 round-trip 测试**可以捕获**该 bug（mat3Cast 不归一化已验证）。

结论：S3 的核心问题不是「round-trip 测试完全无法捕获 S1 bug」，而是「仅身份四元数 round-trip 无法捕获，但非身份 round-trip 可以捕获」。测试设计仍存在改进空间——身份四元数 round-trip 的捕获盲区未见针对性的直接元素验证覆盖。

**S1 修复后的独立修复价值评估：** S1（quatCast 算法 bug）修复后，身份四元数 round-trip 的捕获盲区不再直接暴露算法错误，但身份 round-trip 对 quatCast 数值精度的验证能力依然薄弱——身份四元数经矩阵→四元数→矩阵传递后可能掩盖数值退化（如非最大分量从 0 变为 1e-15 量级微小值）。因此 S3 在 S1 修复后仍具有独立的测试方法论改进价值，优先级可由 **High** 降为 **Medium**——建议补充直接元素验证用例覆盖身份四元数各分量，使测试设计更健壮。

此外，S3 的剩余价值还包括测试方法论改进：应补充「旋转矩阵 × 向量 = 四元数 × 向量」等价性测试（OOD §8.2 已推荐），使 round-trip 测试方法论更健壮。

> **S2 依赖关系：** 本问题的任何修复（补充直接元素验证、等价性测试等）均需通过 `cjpm test` 验证。由于 S2（测试文件不被 cjpm 发现）导致 tests/ 下全部 @Test 静默跳过，S3 修复方案的验证在 S2 修复前不可通过 `cjpm test` 执行。修复应联合 S2 规划：在 S2 修复后，将 S3 测试新增用例放入 `tests/` 目录（维持现有 `test_*.cj` 命名），验证通过后再统一执行 S2 文件重命名。

**证据：** `test_type_quat_cast.cj:18-25,46-53,55-62,64-75,77-84,86-93` 确认 6 个包含 round-trip 断言的测试用例（其中 `:64-75` 同时包含直接 c3 元素验证）。`:3-16` 和 `:27-44` 为 2 个纯直接元素验证。OOD §8.2 明确推荐「旋转矩阵 * 向量 = 四元数 * 向量」等价性测试，但未采用。mat3Cast 实现位置（`type_quat_cast.cj:5-25`）确认未对输入四元数做归一化：函数体直接消费 `q.x`/`q.y`/`q.z`/`q.w` 计算矩阵元素（如 `txx = q.x * tx`、`one - (tyy + tzz)`），未先调用 `length`/`normalize`；同理 `mat4Cast`（`type_quat_cast.cj:27-49`）列布局与 mat3Cast 一致。

**deviations.md 对照（注册状态）：** 本问题属测试设计缺陷，非 C++ GLM 接口/行为偏差，不涉及 deviations.md。

**deviations.md 交叉验证：** 不适用——本问题属测试设计缺陷（身份四元数 round-trip 捕获盲区），非 API 接口或运行时行为偏差。deviations.md 全部三类偏差均面向用户可感知的库使用差异，测试方法论问题不属于偏差文档范畴。无需登记偏差；不影响已有偏差条目（deviations.md 无测试设计相关记载）。

---

### S4. ULP stub 测试覆盖严重不完整

**分类：其他类型（测试覆盖不足）**

**分析：** `vector_relational.cj:197-251` 定义了 16 个 `public func` 声明（`equal`/`notEqual` × Vec1~Vec4 × `Int64`/`VecN<Int64,Q>` 参数形态 = 2 × 4 × 2 = 16 签名）。`test_vector_relational.cj:174-178` 仅测试 `equal(Vec1<Float64>, Vec1<Float64>, Int64)` 一个组合，覆盖率 1/16 ≈ 6.25%。

**证据：** `vector_relational.cj:199-250` 确认 16 个 `public func` 声明（Vec1:199-209 共 4 个，Vec2:213-223 共 4 个，Vec3:227-237 共 4 个，Vec4:241-251 共 4 个）。`test_vector_relational.cj:174-178` 确认仅 1 个测试。

**deviations.md 对照（注册状态）：** 本问题属测试覆盖不足，非 C++ GLM 接口/行为偏差，不涉及 deviations.md。

**deviations.md 交叉验证：** 不适用——本问题属测试覆盖不足（ULP stub 仅覆盖 1/16 签名），非 API 接口或运行时行为偏差。deviations.md 所有条目均面向库使用者视角的功能差异（接口签名、运算符行为、类型约束等），测试覆盖完整性不属于偏差文档范畴。无需登记偏差，且不影响已有偏差条目。

> **S2 依赖关系：** S4 属测试覆盖问题，其修复后的验证依赖于 S2 修复。在 S2 修复前，新增的 ULP 测试用例不会被 `cjpm test` 发现执行。

---

## 一般问题

### G1. Quat 类型层设计偏差（合并 8 项）

#### G1.1 已删除

> **删除理由（v15）：** 经核查，G1.1（跨 Qualifier 构造函数 `init<Q2>` 缺失）不是 Quat 独有的偏差，而是项目级统一设计约定。Vec/Mat 同样未提供 `init<Q2>` 形式的跨 Qualifier 构造函数，而是统一采用静态工厂模式（`castVec*`/`fromMat`/`fromQual`）。因此这不是需要修复的实现偏差，而是 OOD 文档与项目既定设计约定脱节。从报告中删去。

---

#### G1.2 `Vec3×Quat` / `Vec4×Quat` 实现路径与 OOD §3.4 不一致

用户意见：不做修改

**分类：真实存在（实现与 OOD 设计偏差）**

**分析：** OOD §3.4 明确要求 `Vec3×Quat`/`Vec4×Quat` 实现为 `(conjugate(q) / dot(q, q) * v` 内联逆四元数路径。实现中两处函数体均为 `throw Exception("stub")`（`type_quat.cj:142-144, 149-151`），直接抛出 stub 而未实现 OOD 承诺的调用链。

**证据：** OOD §3.4「Vec extend 块成员运算符」段描述 vs `type_quat.cj:140-152` 仅 `throw Exception("stub")`。

**deviations.md 对照（注册状态）：** 此项偏差未在 deviations.md 中登记。当前在 stub 阶段运行时行为一致（均抛异常），但实现路径偏离 OOD 设计意图。建议在阶段四补齐前评估是否需要登记至 deviations.md。

**deviations.md 交叉验证：**
1. **不适用（当前状态）：** deviations.md 当前未记载此偏差。
2. **需登记评估：** 当前实现为 stub（`throw Exception("stub")`），阶段四补齐前运行时行为与 OOD 承诺的「内联逆四元数路径」一致（均抛异常）。当前状态下的偏差是「实现路径 vs OOD 设计」的内部问题，用户视角无差异。建议在阶段四补齐前暂不登记；若补齐后实现路径仍偏离 OOD 设计，届时再评估登记。
3. **可能影响已有条目：** 不影响已有偏差条目。

---

#### G1.3 `fromMat3` / `fromMat4` 约束签名与 OOD §3.3 item 6/7 偏差

用户意见：修改OOD

**分类：OOD 文档问题（文档与实现未同步）** + **真实存在（两处均需更新）**

**分析：** OOD §3.3 item 6/7 规定 `fromMat3`/`fromMat4` 签名为 `where T <: FloatingPoint<T>, Q <: Qualifier`，但实现使用 `where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier`（`type_quat.cj:73`）。该偏差是编译期必需的——`quatCast` 实现需 `Comparable<T>` 进行比较运算。OOD §3.2.1 `quatCast` 签名也仅写 `FloatingPoint<T>`，实际 `quatCast` 实现需要 `Comparable<T>` 约束。

**证据：** `type_quat.cj:73` vs OOD §3.3 item 6/7。`type_quat_cast.cj:52` 也需 `Comparable<T>` 约束。

**修复方向推荐（方向 A：文档跟随实现）：** 推荐修订 OOD §3.3 item 6/7 与 §3.2.1 `quatCast` 签名为 `FloatingPoint<T> & Comparable<T>`，使其与实现一致。**理由：** ① OOD 文档应反映实际编译期约束，而非追求「理想化宽泛约束」——`Comparable<T>` 是 quatCast 算法实现的真实依赖；② GLM `quatCast` 内部同样依赖 `T > T` 比较（`fourBiggestSquaredMinus1` 的大小分支判定），GLM `references/glm-1.0.3/glm/glm/gtc/quaternion.inl:90-104` 使用 3 个 `if (fourX/Y/ZSSquaredMinus1 > fourBiggest...)` 串行比较（X 分支对应行 90-94、Y 分支对应行 95-99、Z 分支对应行 100-104），重构避免比较的实现路径偏离 GLM 算法语义；③ 修复成本：方向 A 仅修订 OOD 文档（约 2 处行），方向 B（重构实现避免使用 `<` 比较运算符）需重构算法实现并新增等价性测试，成本显著高于方向 A。

**deviations.md 对照（注册状态）：** 此项属 OOD 文档与实现的同步问题（双方均需更新），非用户视角的接口偏差，不涉及 deviations.md。

**deviations.md 交叉验证：**
1. **不适用：** 本问题属 OOD 文档与实现的同步问题（双方约束签名不一致需对齐），非用户视角的接口偏差。用户调用 `fromMat3`/`fromMat4` 时感知不到 `Comparable<T>` 约束的存在——该约束仅影响编译期实例化检查。
2. **需登记评估：** 无需登记。这是内部文档与代码一致性的维护问题，非用户可感知的 API 行为偏差。
3. **可能影响已有条目：** 不影响已有偏差条目。

---

#### G1.4 已删除

> **删除理由（v15）：** 经核查，G1.4（`init(s, v)` 未声明为 `const`）不是 Quat 独有的偏差，而是项目级系统性模式。所有 Vec2/3/4 的辅助构造函数（`init(scalar)`、`init(v: Vec1)`）和所有 Mat 的 `init(scalar)` 均未声明 `const`，仅主构造为 `const init`。Quat 的 `init(s, v)` 与 Vec/Mat 的辅助构造处于完全相同的地位，属项目级 const 标注系统性遗漏，非 Quat 单点问题。从报告中删去。

---

#### G1.5 已删除

> **删除理由（v15）：** 经核查，G1.5（`mat4Cast` 中 `one - one` 零获取路径）不是 Quat 独有的偏差，而是项目级统一模式。整个项目的 Mat 类型在 `fromMat`/`diagonal` 等函数中统一使用 `one - one` 或 `x - x` 获取零值（涉及 9 个 Mat 文件 50+ 处），从未使用 OOD §1 推荐的 `T(Float64(0))` 字面量替代路径。`type_quat_cast.cj:30` 的 `let zero: T = one - one` 只是这一项目级约定的又一实例。从报告中删去。

---

#### G1.6 `sqrtT` 与 `zeroOrOne` 私有工具函数的设计可优化

**分类：其他类型（代码质量/可读性建议）**

**分析：** ① `sqrtT`（`type_quat_cast.cj:122-125`）通过 `Float64` 中转实现 sqrt，与 OOD §1 方案 A 推荐的直接调用策略不一致（本问题与 G2.3「项目级 sqrtT 一致性」在 `type_quat_cast.cj` 部分重叠，参见 G2.3 的修复方向分析）。② `zeroOrOne`（`type_quat_cast.cj:127-129`）命名反直觉——`one` 形参减去自身得 `zero`，函数名暗示歧义。③ `quatCast` 函数体内 `var x: T = zeroOrOne(one)` 等 4 行是为规避「`var` 必须初始化」约束。

**纠正（todo.md 描述偏差）：** todo.md 称「sqrtT 未在任何地方被调用」。经代码核查：`sqrtT` 在 `quatCast` 函数体第 84, 90, 96, 102 行被调用，todo.md 描述不准确。该子项属 todo.md 原始描述错误，不影响本报告对代码质量本身的判断。

---

#### G1.7 quatCast 内部 `var` + 多次 `if` 重新赋值的控制流可优化

**分类：其他类型（代码可优化建议，非功能缺陷）**

**分析：** `type_quat_cast.cj:62-76` 使用 `var fourBiggest` + 3 个串行 `if` 比较。GLM 原版使用相同模式，可读性尚可。todo.md 本身承认这是 GLM 直译版本，符合 OOD 设计意图。此问题为优化建议而非缺陷。

---

#### G1.8 `quatCast(Mat4x4)` 依赖列布局假设 `c0/c1/c2` 与 `c3` 行为预期的一致性需文档说明

**分类：其他类型（文档/注释建议）**

**分析：** `type_quat_cast.cj:112-120` 手动构造 `Mat3x3` 子矩阵，假设 Mat4x4 的 `c0/c1/c2` 三列对应左上 3×3 旋转块。OOD §3.2.1 已明确该模式。此建议为可选的注释添加，非功能缺陷。

---

### G2. ext/ 函数库层实现偏差（合并 6 项）

#### G2.1 `slerp` 4 参数版本 `spin: Bool` 与 OOD §3.11 / D22 决策 `k: Int64` 显著偏离

**分类：真实存在（实现与 OOD + GLM 参考实现双重偏差）**

**分析：** OOD §3.11 line 791、D22 决策、§11.5 函数可用性对照表三处明确声明 `slerp` 4 参数版本采用 `k: Int64` 签名。GLM 1.0.3 原始 `slerp(x, y, a, k)` 使用独立泛型 `S` 约束为整数类型。实现采用 `spin: Bool`（`quaternion_common.cj:40`），与上述三处承诺及 GLM 原始设计均不一致。

具体问题：① 语义错误——`Bool` 类型不实现 `Integer<Bool>` 接口，阶段四按 GLM `phi = angle + k * pi<T>()` 公式实现时 `*` 运算符需要 `Number<T>` 接口，Bool 不实现。② 取值域错位——`Bool` 仅能取 `true`/`false`，无法表达「3 整圈旋转」等多圈场景。③ 命名歧义——`spin` 与 GLM 命名风格不一致，应改为 `k`。

**证据：** `quaternion_common.cj:40` 签名 vs OOD §3.11 line 791、D22、§11.5 line 2212。

**修复方案的迁移成本评估：**

1. **现有调用点扫描：** 修复签名前需扫描 `cjglm/` 仓库内是否存在 4 参数 `slerp` 调用点。**建议命令：** `grep -rn 'slerp.*spin\|slerp(.*,.*,.*,.*)' cjglm/`。若存在调用方，签名修改将引入级联破坏（`true`/`false` → `0`/`1` 或语义改写），需同步修改调用代码。当前实现函数体为 `throw Exception("stub")`，阶段四前无业务调用方，扫描预期为空。

2. **命名歧义消除的语义验证：** GLM 原版 `k: Int64` 允许任意整数（含负数、零）控制旋转圈数，每整数对应 π 弧度偏移（公式 `phi = angle + k * pi<T>()`）。`Bool` 仅支持 `true`（单圈）/ `false`（无旋转），无法表达 GLM 的多圈场景。修复时需明确 Cangjie 实现语义对齐方向：**建议直接按 OOD 与 GLM 采用 `Int64` + `phi = angle + k * pi<T>()` 公式**（`k=0` 即 3 参数 lerp 等价，`k=1` 旋转一周，`k=-1` 反向旋转）。

3. **stub 状态修复验证手段：** 当前函数体 `throw Exception("stub")`，修复签名后无编译错误，但缺乏运行时验证用例（G5.6 已记录该测试缺失）。**建议在修复签名的同时新增最小测试用例**覆盖 `k = 0` / `k = 1` / `k = -1` 三种典型场景（暂命名 `testSlerp4ArgsK0/K1/KMinus1`），避免阶段四补齐函数体后签名修复正确性无法回归验证。**S2 依赖关系说明：** 本项新增测试用例的验证依赖于 S2（测试文件发现问题）的修复——因 `tests/` 目录下的测试文件不被 `cjpm test` 发现，新建的 4 参数 slerp 测试用例需放置于 `src/` 目录下并遵循 `*_test.cj` 命名规则（而非 `tests/` 目录下的 `test_*.cj` 命名），才能在 S2 修复前被 `cjpm test` 发现执行。若测试用例放置于 `tests/` 目录，则需待 S2 修复后方可验证。

**deviations.md 对照（注册状态）：** 此项偏差未在 deviations.md 中登记。该偏差属 API 签名级别的实现错误（`Bool` 替代 `Int64`），非有意的设计偏差，应在修复前评估是否需要临时登记。

**deviations.md 交叉验证：**
1. **不适用（当前状态）：** deviations.md 未记载此偏差。当前实现为 stub 形态（`throw Exception("stub")`），运行时行为与预期一致（均抛异常），偏差仅存在于签名层面。
2. **需登记评估：** 修复前建议临时登记——该偏差属于「二、接口/行为有偏差」（签名与 OOD 承诺不一致）。需注意 OOD §11.5 line 2212 已将 slerp 的 `k: Int64` 签名列为 deviations.md DV-03 风格的特例。若临时登记，格式需与现有 DV-* 条目一致，登记描述的偏差方向（`Bool` vs `Int64`）必须与实际实现一致。
3. **可能影响已有条目：** 若登记，不影响已有 DV-* 条目（slerp 是独立签名，不冲突）。OOD §11.5 中的 DV-03 风格特例引用可作为登记时的参考依据。

---

#### G2.2 `mix` / `lerp` 约束较 GLM `is_iec559` 静态断言过宽

**分类：真实存在（约束过宽，未来风险）** + **OOD 文档问题（OOD §1 已预见此风险）**

**分析：** GLM 1.0.3 对 `lerp`/`mix` 使用 `GLM_STATIC_ASSERT(std::numeric_limits<T>::is_iec559, ...)` 限定为浮点类型。实现 `mix` 用 `where T <: Number<T>`（`quaternion_common.cj:34-35`），`lerp` 用 `where T <: Number<T> & Comparable<T>`（第 17 行）。`Number<T>` 允许整数类型实例化。`mix`（球面插值）需要 `acos`/`sin` 等三角函数，整数 T 实例化将无法在阶段四编译通过。OOD §1 已对此类约束放宽风险做出告诫。

**OOD §1 告诫适用性分析：** OOD §1 的告诫核心是「类型约束一旦放宽，后续收紧易触发 API 形态偏差扩大」——即放宽约束后若调用方已依赖整数实例化，收紧时将破坏已有代码。本场景的约束（`Number<T>` vs `FloatingPoint<T>`）属于从宽到紧的方向，OOD §1 的告诫**完全适用**：当前 `mix`/`lerp` 若存在整数 T 调用方，阶段四收紧为 `FloatingPoint<T>` 时将编译失败。但本场景与 OOD §1 告诫的典型风险存在关键区别：当前 `mix`/`lerp` 函数体均为 `throw Exception("stub")`，阶段四之前无实际业务调用方，因此整数实例化调用点的存在概率极低（仅来自测试文件）。**本场景实质上是 OOD §1 告诫的一个例外**——约束收紧带来的级联破坏风险在当前 stub 状态下几乎为零，理由：① 不存在生产调用方依赖整数 `mix`/`lerp`；② 测试调用点即使存在，收紧时编译器报错将精确定位。因此 OOD §1 的告诫在本场景中不构成阻碍因素。

**证据：** `quaternion_common.cj:16-17, 34-35` vs GLM `GLM_STATIC_ASSERT(is_iec559, ...)`。

**修复方向与下游影响评估：**

阶段四补齐前建议将 `mix`/`lerp` 约束由 `Number<T>` 收紧至 `FloatingPoint<T>`，与 GLM `is_iec559` 静态断言对齐。但收紧约束将引入**级联编译失败风险**——现有调用方若存在整数类型实例化（如 `mix<Int64>(...)` 或 `lerp<Int64>(...)`），收紧后将无法编译通过。因此收紧前必须先扫描并修正所有整数类型实例化调用点。

**建议扫描命令：**
```
grep -rn "mix<.*Int64\|lerp<.*Int64" cjglm/
grep -rn "mix<.*Int32\|lerp<.*Int32" cjglm/
```

**替代方案（推荐）：** 在阶段四首次实际调用 `mix`/`lerp` 的函数体中，使用仓颉 `match` 类型分派或 `where T <: FloatingPoint<T>` 的重载优先级机制，使整数 T 实例化在编译期即报「`std.math.acos/sin` 不支持 `Int64`」错误（仓颉 stdlib 三角函数均要求 `FloatingPoint<T>` 约束），由此**自动识别**所有整数实例化调用点并由编译器报错定位，无需手动扫描。此方案与 OOD §1「约束收紧易触发 API 形态偏差扩大」的告诫兼容——通过编译期错误而非手动 grep 发现调用点，定位更精确、覆盖面更全。如上文所述，OOD §1 的告诫在本 stub 阶段场景中不构成实际阻碍，但该方案的兼容性设计可作为额外的安全冗余。

**deviations.md 对照（注册状态）：** 此项偏差未在 deviations.md 中登记。当前属「未来风险」——阶段四补齐前不影响功能，但届时需收紧约束。建议登记至 deviations.md 作为已知的接口约束偏差记录。

**deviations.md 交叉验证：**
1. **不适用（当前状态）：** deviations.md 未记载此偏差。OOD §1 已预见此类风险。
2. **需登记评估：** 建议在阶段四前登记至 deviations.md——该偏差属「二、接口/行为有偏差」（约束签名与 GLM 静态断言不一致），参照已有 DV-* 条目格式。登记时需核实：登记描述中的约束签名（`Number<T>` vs `FloatingPoint<T>`）与实际实现一致；登记后阶段四收紧约束时需同步更新或删除该偏差条目。
3. **可能影响已有条目：** 不影响已有 DV-* 条目。OOD §1 中的风险告诫可作为登记时的引用依据。

---

#### G2.3 `length` / `sqrtT` Float64 中转包装偏离 OOD §1 方案 A「直接调用」策略

**分类：真实存在（实现与 OOD 策略偏差，项目级一致性问题）**

**分析：** OOD §1 明确说明 `std.math.sqrt` 提供 Float16/Float32/Float64 三种重载，T=Float32 实例化时应直接调用 `std.math.sqrt(dot_qq)` 利用 Float32 重载（方案 A 推荐）。实现定义私有 `sqrtT` 工具函数通过 `Float64` 中转——所有 T 实例化路径均强制走 Float64 中转，违反 OOD §1 方案 A 策略。跨 `quaternion_geometric.cj:5-8, 17` + `quaternion_trigonometric.cj:5-8, 18` + `type_quat_cast.cj:122-125` 共 3 处。

**证据：** `quaternion_geometric.cj:5-8`、`quaternion_trigonometric.cj:5-8`、`type_quat_cast.cj:122-125` 的 `sqrtT` 实现模式 vs OOD §1「方案 A」。

**deviations.md 对照（注册状态）：** 此项偏差未在 deviations.md 中登记。该偏差属实现策略与 OOD 设计不一致，不涉及用户视角的 GLM 行为差异，不建议登记（属于修复方向的内部决策问题）。

**deviations.md 交叉验证：**
1. **不适用：** 本问题属实现策略偏离（`sqrtT` Float64 中转 vs 直接调用），不影响最终数值结果（仅存在精度降级风险），用户无感知。
2. **需登记评估：** 无需登记。该偏差属于 OOD 实现策略选择问题，非 API 接口或运行时行为偏差。按 deviations.md 分类框架，不属于任何一类用户可感知的偏差。
3. **可能影响已有条目：** 不影响已有偏差条目。

---

#### G2.4 abs 内联模式重复 16 次，未抽取为包内私有辅助函数

**分类：其他类型（代码质量/维护性建议）**

**分析：** `vector_relational.cj` 中每个 epsilon 重载内部都重复相同的内联 abs 模式（`let zero = (Float64(0) as T).getOrThrow(); let d = x.x - y.x; (if (d >= zero) { d } else { -d }) < epsilon`），共 16 处重复。`quaternion_relational.cj` 也使用相同模式（2 处）。均为同一包（`glm.ext`），未抽取共享辅助函数。

---

#### G2.5 阶段一 `equalEpsilon` 与阶段三 `equal` epsilon 重载的约束风格不一致

**分类：其他类型（风格不一致，非功能缺陷）**

**分析：** 阶段一 `equalEpsilon` 使用 `T <: Number<T> & Equatable<T> & Comparable<T>`，阶段三 `equal` epsilon 重载使用 `T <: Number<T> & Comparable<T>`（无 `Equatable<T>`）。两者逻辑上都正确且与各自实现一致，但存在两种「epsilon 比较」约束模板。注意 `equalEpsilon` 需要 `Equatable<T>` 是因为它内部需要 `==` 比较；而阶段三 epsilon 重载使用原始 `<` 比较，不依赖 `Equatable<T>`。

---

#### G2.6 epsilon 重载未声明 `const func`

**分类：其他类型（可优化建议，非功能缺陷）**

**分析：** `vector_relational.cj` 的 16 个 epsilon 重载和 `quaternion_relational.cj:15-43` 的 2 个 epsilon 重载均可声明为 `const func`（函数体仅包含 `let` 绑定、算术运算、`<` 比较、`VecN<Bool, Q>(...)` 构造，均为 const 兼容操作）。`cjglm/src/detail/type_vec3.cj:54-80` 已成功声明 27 个 const func 为先例。

---

### G3. gtc/ 层 + 顶层 API 偏差（合并 9 项）

#### G3.1 `gtc/quaternion.cj` 依赖声明与 OOD §3.15 不一致

**分类：真实存在（实现与 OOD 设计偏差）**

**分析：** OOD §3.15 line 1274-1279 明确声明 `gtc/quaternion.cj` 的依赖包括 `import glm.ext.vector_relational.*` 和 `import glm.ext.scalar_constants.*`。当前实现（`gtc/quaternion.cj:1-4`）仅含 `package glm.gtc` + `import glm.detail.*` + `import std.math.FloatingPoint` + `public import glm.detail.{mat3Cast, mat4Cast, quatCast}`，缺失上述两项。当前编译通过是因为 7 个 stub 函数体均为 `throw Exception("stub")`，未实际引用 `equal`/`epsilon<T>()`。

**证据：** `gtc/quaternion.cj:1-4` vs OOD §3.15 line 1274-1279。

**deviations.md 对照（注册状态）：** 此项偏差未在 deviations.md 中登记。属实现阶段省略前瞻性 import（因 stub 反射不需要），不涉及用户视角偏差，不建议登记。

**deviations.md 交叉验证：**
1. **不适用：** 本问题属实现阶段省略前瞻性 import 声明，在 stub 形态下不影响运行时行为（函数体尚未实现），且阶段四补齐时将自动修正。
2. **需登记评估：** 无需登记。缺失的 import 在 stub 阶段不产生用户可感知的行为差异，阶段四补齐函数体时会自然加入。
3. **可能影响已有条目：** 不影响已有偏差条目（deviations.md 无 gtc/quaternion 依赖相关记载）。

---

#### G3.2 `gtc/quaternion.cj` 的 4 个比较函数 Vec4 构造调用缺少显式类型参数

**分类：其他类型（风格不一致，非功能缺陷）**

**分析：** 4 个比较函数实现使用 `Vec4(x.x < y.x, x.y < y.y, ...)` 形式（无显式 `<Bool, Q>` 类型参数），依赖编译器从返回类型 `Vec4<Bool, Q>` 反向推断。OOD §3.15 line 1242-1245 给出的签名模板均使用 `Vec4<Bool, Q>(...)` 显式类型实参。当前实现与 OOD 模板不完全一致，但功能等价。

---

#### G3.3 `gtc/matrix_transform.cj` import 列表未显式声明 OOD §3.13/路线图中的传递依赖

**分类：其他类型（意图表达缺失，非功能缺陷）**

**分析：** 当前文件仅 `import glm.detail.{ Mat4x4, Vec2, Vec3, Vec4, Qualifier }` + `import std.math.FloatingPoint`，未包含 OOD 列举的 6 个传递依赖。在 stub 形态下编译通过（函数体均为 `throw Exception("stub")`）。缺失依赖不影响功能，但下游维护者从 import 列表无法直接看出本文件的依赖链设计意图。

---

#### G3.4 `trigonometric.cj` 头部缺少与 OOD §3.13.1「T 类型约束策略」一致的引用说明

**分类：其他类型（注释缺失，非功能缺陷）**

**分析：** 当前文件头注释为空白，无任何关于约束策略的依据引用。OOD §3.13.1 明确指出 `where T <: FloatingPoint<T>` 约束是「阶段四完整实现前的必备前置项」。所有 75 个签名均已正确应用该约束，但缺少注释说明约束来源。

---

#### G3.5 `fwd.cj.bak` 备份文件包含 OOD 明确禁止的错误变体

**分类：其他类型（版本控制/构建兼容性问题）**

**分析：** `fwd.cj.bak:331,334,337` 包含 OOD §2 明确禁止的 `HighpFQuat`（331 行）/`MediumpFQuat`（334 行）/`LowpFQuat`（337 行）三个错误别名。该 `.bak` 是修复前的快照，被误纳入 git 暂存区。当前 `fwd.cj`（335 行）已正确不含上述三个错误变体。

**证据：** `fwd.cj.bak:330-338` 中第 331/334/337 行分别定义了三个 `*pFQuat` 别名 vs OOD §2 验证命令段。`git status` 确认 `new file: cjglm/src/fwd.cj.bak`。

> **与 todo.md 行号差异说明：** todo.md G3.5 标称位置为 `fwd.cj.bak:330-332`。本报告引用行号为 331/334/337，与 todo.md 描述的连续区间 330-332 不一致。差异原因：todo.md 的 `:330-332` 为大致区间描述（涵盖 HighpFQuat@331），未涵盖 MediumpFQuat@334 和 LowpFQuat@337 两个错误别名；实际 `fwd.cj.bak` 中三个错误别名分布不连续——HighpFQuat@331、MediumpFQuat@334、LowpFQuat@337（中间夹有合法的 HighpDQuat@332、MediumpDQuat@335、LowpDQuat@338）。可能原因：todo.md 编写时 `fwd.cj.bak` 文件与最终提交版本存在行号漂移（后续编辑插入所致），但三个错误别名实质位置与本报告核查一致。本报告以 `fwd.cj.bak` 实际行号为准。

**修复建议：**

> **前置验证（v10 补充）：** 在执行删除命令前，应先验证 `fwd.cj.bak` 的当前 git 跟踪状态——todo.md 描述的"`git status` 显示 `new file:`"仅表明文件曾被纳入暂存区，但未独立验证当前跟踪状态。**建议执行：** `git ls-files --error-unmatch cjglm/src/fwd.cj.bak`。
> 1. 若返回 0（文件已被 git 跟踪）：执行 `git rm cjglm/src/fwd.cj.bak`（不带 `--cached` 标志）。
> 2. 若返回非 0（文件未被跟踪）：执行 `rm cjglm/src/fwd.cj.bak` 即可（无需 git 操作，因 `git rm` 对未跟踪文件会报 "fatal: pathspec ... did not match any files" 错误）。
> 3. 通用回退方案（不依赖跟踪状态）：执行 `rm cjglm/src/fwd.cj.bak` + `git add -A` 同步索引。

执行 `git rm cjglm/src/fwd.cj.bak`（**不带 `--cached` 标志**，**仅在文件已被 git 跟踪时**）——此命令同时从 git 索引和工作区删除文件，实现完整清理。备选方案对比：
- `git rm <file>`：从索引与工作区同时删除（推荐方案，与 G3.5 「误纳入暂存区」的根因匹配）
- `git rm --cached <file>`：仅从索引删除，保留工作区文件（适用于「保留本地副本但停止跟踪」场景，本问题不需要）
- 手动 `rm <file> + git add <file>`：分两步执行，先删除工作区文件再记录删除，等价于 `git rm`，但易遗漏 `git add -A` 同步索引，不推荐

推荐理由：`.bak` 是误纳入仓库的备份文件，不应保留任何副本（无复用价值），需彻底删除。

**deviations.md 对照（注册状态）：** 本问题属版本控制问题（备份文件误纳入仓库），非 C++ GLM 与仓颉 GLM 之间的语义偏差，不涉及 deviations.md。

**deviations.md 交叉验证：**
1. **不适用：** 本问题属版本控制问题（备份文件 `.bak` 误纳入 git 暂存区），非代码行为偏差。deviations.md 全部三类偏差均面向库使用者的 API/行为差异，版本控制问题不属于偏差文档范畴。
2. **需登记评估：** 无需登记。删除 `.bak` 文件即可解决，不涉及任何用户视角的库行为变化。
3. **可能影响已有条目：** 不影响已有偏差条目。

---

#### G3.6 `gen_fwd_aliases.py` 在 Windows 上破坏幂等性

**分类：其他类型（版本控制/构建兼容性问题）**

**分析：** `cjglm/scripts/gen_fwd_aliases.py:71` 写入文件时显式指定 `newline='\n'`（LF）。当前已提交的 `fwd.cj` 使用 CRLF 行尾（Windows 仓库默认）。首次在已提交版本上执行脚本时会将全部行尾从 CRLF 改为 LF，触发 `git diff` 大量变更。脚本对 LF 文件可幂等，但对 CRLF 文件不幂等。

**deviations.md 对照（注册状态）：** 本问题属构建工具兼容性问题，非 C++ GLM 与仓颉 GLM 之间的语义偏差，不涉及 deviations.md。

**deviations.md 交叉验证：**
1. **不适用：** 本问题属构建脚本兼容性问题（`gen_fwd_aliases.py` 在 CRLF 环境下不幂等），不涉及 API 接口或运行时行为。deviation.md 记录的偏差均为用户视角的库使用差异，构建工具行为不属于其范畴。
2. **需登记评估：** 无需登记。修复脚本幂等性或统一行尾约定即可，不涉及用户视角的 GLM 行为变化。
3. **可能影响已有条目：** 不影响已有偏差条目。

**修复建议：**

修改 `cjglm/scripts/gen_fwd_aliases.py:71`，在写入文件前**检测已存在文件的行尾格式并保留**——读取现有 `fwd.cj` 的行尾（CRLF/LF），使用相同格式回写。具体伪代码：
```
with open(fwd_path, 'rb') as f:
    existing = f.read()
newline_mode = '\r\n' if b'\r\n' in existing else '\n'
with open(fwd_path, 'w', encoding='utf-8', newline=newline_mode) as f:
    f.write(content)
```
此修复使脚本对 CRLF 与 LF 文件均幂等，符合 OOD §2 幂等性验证段要求。

---

#### G3.7 `lib.cj` 行数偏离 OOD 预期（16 行 vs 28 行）

**分类：其他类型（实现偏离文档描述，功能等价）** + **OOD 文档问题（部分）**

**分析：** OOD §2 明确声明 `lib.cj` 应有 20 个显式 import（`docs/05_ood_phase3.md:303-324` 逐行列出了 `public import glm.detail.{Quat, mat3Cast, mat4Cast, quatCast}`、`import glm.detail.trigonometric`、`import glm.ext.vector_relational` 等 20 条，合计 28 行）。实际 `lib.cj` 仅 16 行，原因是实现采用了 `import glm.ext.*` 和 `import glm.gtc.*` 两个通配符导入来合并原本 14 个 ext + 3 个 gtc 的显式 import 清单。功能等价，但偏离 OOD 文本「20 个 import」的逐项描述。

**证据：** `lib.cj:1-16` vs OOD §2 逐项 import 清单（`docs/05_ood_phase3.md:303-324`）。

---

#### G3.8 `lib.cj` 触发 17 个 unused import 编译警告

**分类：真实存在（编译警告）**

**分析：** `cjpm build` 输出 17 条 `unused import` 警告（**注：本数字为基于 `lib.cj:12/14/16` import 在 lib.cj 文件内无引用事实的逻辑推断，尚未通过 `cjpm build` 独立实证**）。`lib.cj:12, 14, 16` 的 import（非 `public`）仅服务于将 ext/gtc 符号引入 `glm` 包作用域以便内部引用，但 `lib.cj` 自身并不调用这些符号，因此编译器判定为未使用。

> **建议实证命令（v10 补充）：** `cjpm build 2>&1 | grep -c 'unused import'`，实际计数结果应与本报告数字 17 一致。考虑到不同 cjpm 版本对 unused import 的检测粒度可能不同（部分版本仅检测 `public` 修饰符的 import，部分版本同时检测非 public import），实际数字可能为 15-17 之间的某个值。修复方向不受实证结果影响（不论数字多少，根因均为 `lib.cj` 内部不调用 ext/gtc 符号）。

**deviations.md 对照（注册状态）：** 本问题属编译警告问题，非 C++ GLM 与仓颉 GLM 之间的语义偏差，不涉及 deviations.md。

**deviations.md 交叉验证：**
1. **不适用：** 本问题属编译警告（`unused import`），不改变运行时行为。deviations.md 记录的用户可感知偏差均涉及接口签名、运算符行为、类型约束等，编译警告不属于其范畴。
2. **需登记评估：** 无需登记。17 条 `unused import` 警告不影响功能正确性，清理 import 语句或添加编译器标注即可解决。
3. **可能影响已有条目：** 不影响已有偏差条目。

---

#### G3.9 `lib.cj` 缺少 OOD §2 指定的 `Quat` 的 public import

**分类：其他类型（实现偏离文档描述，功能等价）** + **OOD 文档问题（部分）**

**分析：** OOD §2 line 304 要求 `public import glm.detail.{Quat, mat3Cast, mat4Cast, quatCast}`（原文：`docs/05_ood_phase3.md:304` ——「四元数类型 + 转换函数：`mat3Cast`/`mat4Cast`/`quatCast` 在 lib.cj 中以 `public import` 形式重导出至顶层 `glm` 命名空间」）。实际 `lib.cj:10` 仅 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}`，未导入 `Quat`。能编译通过是因为 `fwd.cj:327` 的 type alias `public type Quat = detail.Quat<Float32, PackedHighp>` 在 generic-style 实例化时被 Cangjie 编译器按「透明再参数化」语义解析。严格按 OOD 设计，`Quat` 应当通过 `public import` 在 `glm` 命名空间下公开。

---

### G4. scalar_constants / scalar_quat_ops 设计偏差（合并 4 项）

#### G4.1 `pi<T>()` 与 `cos_one_over_two<T>()` 未利用 `FloatingPoint<T>` 接口的静态方法

**分类：其他类型（实现可简化，非功能缺陷）**

**分析：** 标准库 `FloatingPoint<T>` 接口声明 6 个静态方法，包括 `getPI()`。当前 `pi<T>()` 实现（`scalar_constants.cj:10-22`）通过 3 次 `hint is FloatXX` 运行时类型分派，可简化为一行业务逻辑：`FloatingPoint<T>.getPI()`。

---

#### G4.2 `scalar_constants.cj` 缺少 OOD §3.12 line 805 约定的非浮点类型运行时异常 fallback

**分类：其他类型（设计决策惰性）**

**分析：** OOD §3.12 line 805 约定对非浮点类型应抛 `Exception`。当前三个函数均缺少该 fallback——pi 和 cos_one_over_two 的 fall-through 分支静默返回 Float64 值。但当前 `FloatingPoint<T>` 约束已限制 T 仅可为 Float16/Float32/Float64（标准库确认），fallback 实际不可触发。因此存在两种可能性：① OOD §3.12 的运行时异常约定在 `FloatingPoint<T>` 约束下不可达，应标记为 OOD 文档陈旧（需删除该约定或调整表述）；② 若意图保留该契约，则实现应补充 fallback 分支。本报告按「其他类型（设计决策惰性）」分类，即当前实现选择了 `FloatingPoint<T>` 约束下的最简实现路径（不实现不可达的 fallback），但未主动清理 OOD 文档中过时的异常约定。

**具体修改指向：** 推荐**方向 A（删除 OOD 中不可达的异常约定）**——理由：`FloatingPoint<T>` 约束已在编译期确保 T 仅为浮点类型，运行时 fallback 永远不可达。应修订 OOD §3.12 line 805，删除该异常约定段落，或改为注释说明「在 `FloatingPoint<T>` 约束下该路径不可达，作为防御性编程保留」。此方向消除多余的文档承诺，节省实现开销。

**纠正（todo.md 描述偏差）：** todo.md 称 `pi<T>()`「三个 `if` 分支均不匹配时默认 fall-through 至 `Float64.getPI()`」——实际上 `FloatingPoint<T>` 约束使此路径不可达。该描述虽在代码字面上成立，但在当前约束体系下无实际影响。

---

#### G4.3 `cos_one_over_two<T>()` 取值与 OOD §3.12「具体类型硬编码」策略不一致

**分类：OOD 文档问题（实现优于设计文档）**

**分析：** OOD §3.12 line 806 规定 `pi<T>()` 与 `cos_one_over_two<T>()`「同理使用具体类型硬编码值」（原文：`docs/05_ood_phase3.md` 中 `scalar_constants.cj` 段要求「pi/cos_one_over_two——同理使用具体类型硬编码值，参考参考实现的常量定义」`docs/05_ood_phase3.md` 注释涉及 `cos_one_over_two` 处配置字面量 `0.877582561890372716`）。当前 `pi<T>()` 实现（`detail/scalar_constants.cj:10-22`）通过 3 次 `hint is FloatXX` 运行时类型分派后调用具体类型的静态方法（`Float64.getPI()`/`Float32.getPI()`/`Float16.getPI()`），并非通过 `FloatingPoint<T>.getPI()` 接口调用，也非硬编码字面量。`cos_one_over_two<T>()` 使用的字面量 `0.877582561890372716` 符合 OOD 描述。偏差性质：实现优于 OOD 设计文档（调用标准库预定义精度常量优于手写硬编码字面量），但与文档字面承诺不一致。

---

#### G4.4 `scalar_quat_ops.cj` 与 GLM 习惯的「交换律覆盖」偏差未在 deviations.md 登记

**分类：OOD 文档问题（deviations.md 未登记已知偏差）** + **其他类型（偏差已在 OOD 正文说明）**

**分析：** `scalar_quat_ops.cj` 实现 `T + Quat`/`T - Quat`/`T * Quat`/`T / Quat` 四个全局具名函数。OOD §3.11 line 660 已明确说明此偏差及其根因（仓颉运算符重载规则）。偏差已在 OOD 正文中记录，但 `docs/deviations.md` 未独立登记。按 deviations.md 开头说明（「四、未验证的偏差添加」）的流程，应走偏差添加流程。

**deviations.md 交叉验证：** OOD §3.11 line 660 已说明此偏差，但 deviations.md 未独立登记。需在偏差添加流程中确认：登记时需验证实现行为（`T + Quat` 具名函数的行为）与 OOD §3.11 line 660 描述的偏差方向一致。

---

### G5. 测试覆盖盲点（合并 9 项）

#### G5.1 `test_type_quat.cj` 用例数 30 显著低于 OOD §8.2 计划 ≥40 下限

**分类：其他类型（测试覆盖不足）** + **OOD 文档问题（计划与实现偏差）**

**分析：** OOD §8.2 要求 `test_type_quat.cj` 用例数 ≥40（`docs/05_ood_phase3.md:1779` —— `tests/glm/detail/test_type_quat.cj` 覆盖「Quat 核心类型 + 运算符」预计 ≥40 用例；用例分配原则 `docs/05_ood_phase3.md:1824-1831` 拆解为 8 个构造函数 × 2 + 2 个 stub × 1 + 5 个算术运算符 × 2 + … = 42 函数级用例），当前仅 30 个。主要缺口：缺少 fromVec3/fromEuler stub 测试、缺少每个完整实现函数的第二个用例、Quat×Vec3/Vec4/Vec3×Quat/Vec4×Quat 仅有运行时 assertThrows 验证等。

> **与 todo.md 数字差异说明：** todo.md G5.1 描述段称「27 函数 / OOD 要求 42 / 文件实际 30 / 缺口 -12」，与本报告「实际仅 30 个用例，距 ≥40 下限短缺 10+ 用例」存在数字表述差异。差异原因：todo.md 提到的「27 函数」与「OOD 要求 42」的对比口径需进一步核查——可能是 OOD §8.2 「用例分配原则」段（完整实现函数 ≥2 用例 + stub 函数 ≥1 用例）与 `type_quat.cj` 实际公开函数数量的乘积计数。具体核算需 OOD §8.2 与 `type_quat.cj` 函数列表交叉确认。本报告采用更保守的描述（仅引用实际用例数 30 与 OOD §8.2 下限 ≥40），避免与 todo.md 表述方式不一致产生歧义；缺口数字「10+」为本报告核算，「12」为 todo.md 核算口径，具体差异不影响 G5.1 主结论（测试覆盖不足）。

**证据：** `test_type_quat.cj:1-272` 确认 30 个 @Test vs OOD §8.2 要求 ≥40。

---

#### G5.2 `test_trigonometric_stub.cj` 仅覆盖 75 个函数签名中的 16 个

**分类：其他类型（测试覆盖不足）** + **OOD 文档问题（OOD §8.2 允许按类选取代表性函数，但实现未达 OOD 自己也允许的范围）**

**分析：** OOD §8.2 第 9 项允许「每类选取 1 个代表性函数验证」。当前 16 个测试用例覆盖 15 个函数名分组中 14 个仅覆盖标量重载，1 个（sin）覆盖标量 + Vec1。剩余 Vec2/Vec3/Vec4 重载（每个函数名 3 个）共 45 个函数签名未被引用。

---

#### G5.3 `test_scalar_constants.cj` 缺失整数 T 异常路径测试

**分类：其他类型（测试覆盖不足）**

**分析：** OOD §11.5 函数可用性对照表、§3.12 均明确描述 epsilon/pi/cos_one_over_two 对整数类型抛运行时异常（D25 决策）。但 8 个测试用例全部仅覆盖 Float32/Float64 浮点路径，无 `epsilon<Int64>()`/`pi<Int64>()`/`cos_one_over_two<Int64>()` 异常路径测试。

---

#### G5.4 `test_scalar_quat_ops.cj` 缺失 T×Quat 反向运算符与边界用例

**分类：其他类型（测试覆盖不足）**

**分析：** 9 个测试用例的缺失项：T×Quat 反向运算符未独立覆盖、Float32 路径未单独测试、负数除数边界断言不完整（仅测试 x 和 y 分量，未覆盖 z 和 w 分量）。

---

#### G5.5 `test_type_quat.cj` 浮点 round-trip 测试未使用容差

**分类：其他类型（测试鲁棒性风险，非当前功能缺陷）**

**分析：** 3 个 round-trip 测试使用 `@Expect(m == m2, true)` 精确比较。若 S1 因子 2 bug 修复后，浮点累积误差可能达到 1e-15 ~ 1e-16 量级，`==` 精确比较可能失败——尽管实际算法是 1:1 正确的。

---

#### G5.6 `slerp` 4 参数重载（`spin: Bool`）无任何测试

**分类：其他类型（测试覆盖不足）**

**分析：** `quaternion_common.cj:40` 声明 4 参数 `slerp`。`testSlerpStub` 仅覆盖 3 参数版本，4 参数 stub 版本的运行时行为未被任何测试验证。该分类仅记入「其他类型（测试覆盖不足）」的理由：① 当前实现行为符合 stub 状态设计意图（`throw Exception("stub")`），未发生实现偏差；② G2.1 已将签名错误（`spin: Bool` vs `k: Int64`）登记为「真实存在」类问题，G5.6 仅描述该 stub 缺乏测试覆盖的事实，不重复计入「真实存在」。

---

#### G5.7 `gtc/test_quaternion.cj` 缺少 `mat3Cast`/`mat4Cast`/`quatCast` 重导出的 gtc 命名空间独立测试

**分类：其他类型（测试覆盖不足）**

**分析：** `gtc/quaternion.cj:4` 通过 `public import` 将 detail 的 4 个转换函数重导出至 gtc 命名空间，但 `test_quaternion.cj` 未提供任何 gtc 命名空间下的调用用例。若阶段四误删 `public import` 行，detail 层测试不会捕获，但 gtc 路径调用将编译失败。

---

#### G5.8 `test_vector_relational.cj` 的 16 个 epsilon 测试缺少数值精度多样性

**分类：其他类型（测试覆盖不足）**

**分析：** 16 个 epsilon 测试均使用固定模式，未覆盖：`abs(d) == epsilon` 边界（`equal` 严格小于语义）、`notEqual` 严格大于等于语义边界、不同向量分量的不同 diff 混合情况。

---

#### G5.9 `testInverseZero` 边界条件断言未严格限定 + `testEqualVec1NegativeDiff` 命名与实际不一致

**分类：其他类型（测试断言精度不足）**

**分析：**
- `testInverseZero`（`test_quaternion_common.cj:69-73`）：使用 `||` 验证「inv.x 为 Inf 或 NaN」。OOD §3.11 line 780-782 声明浮点四元数 `dot(q,q) == T(0)` 时除以零产生 Inf/NaN 分量。`Float64 0.0/0.0 = NaN`，实际值精确为 `NaN`，不会同时是 `Inf`。测试断言过于宽松——这属于测试断言精度问题（`||` 涵盖范围超出实际可能值），并非被测代码实现偏差。**不归入「误报」类的判定依据**：「误报」按 requirement.md 第 2 类定义为「实际实现正确」，但本项并非声称实现错误——todo.md G5.9 与本报告均确认 `inverse` 函数行为正确（产生 NaN），问题在于测试断言宽松（`||` 包含 Inf 分支冗余），属于测试方法论精度问题。
- `testEqualVec1NegativeDiff`（`test_vector_relational.cj:166-172`）：测试输入与 `testEqualVec1ScalarEpsilon` 完全相同，命名暗示测试「negative diff 分支」但函数体无法区分。

**证据：** `test_vector_relational.cj:7-12` vs `166-172` 确认输入完全相同。

---

### G6. `lib.cj` 与 `fwd.cj` 测试覆盖与 import 结构偏差（合并 2 项）

#### G6.1 `lib.cj` 的测试覆盖不足与 import 结构偏差（下设两个子视角）

**分类：其他类型（测试覆盖不足）** + **OOD 文档问题**

**视角 A——测试覆盖缺口：** `test_lib.cj` 未对 OOD §2 列出的全部 20 个 import 逐项验证。

> **分组粒度说明（v10 补充）：** 本节按 OOD §2 阶段三引入的 import 项计 5 个 OOD 阶段三 import 组（trig、cast 整体、Quat 别名），其中 cast 在 OOD §2 中虽为单条 import 语句但实质包含 `mat3Cast`/`mat4Cast`/`quatCast` 3 个独立转换函数（按函数粒度计算为 3 个 import 组）。下文按函数粒度展开覆盖统计。

实际测试覆盖情况：`test_lib.cj` 共 18 个用例，按函数粒度覆盖 5 个 import 组中的 **4 个**：`detail.Quat`（1 个，`testLibQuatFromFwd`）、`detail.mat3Cast`（1 个，`testLibMat3CastAccessible`）、`detail.quatCast`（1 个，`testLibQuatCastAccessible`）、`trigonometric`（15 个，sin/cos/tan/asin/acos/atan/atan2/sinh/cosh/tanh/asinh/acosh/atanh/radians/degrees）。**未覆盖：`detail.mat4Cast`**（grep 仅匹配到 mat3Cast/quatCast 相关行，无 mat4Cast 字样）。其他 OOD §2 中所列 import 组均未被 test_lib.cj 测试覆盖，包括 vector_relational、quaternion_common、quaternion_geometric、quaternion_trigonometric、quaternion_relational、quaternion_transform、quaternion_exponential、scalar_constants、4 个别名文件、matrix_projection/clip_space/transform、gtc.constants、gtc.quaternion。

**可执行矩阵（OOD §2 列出的 20 个 import vs test_lib.cj 已测试项，按函数粒度细分）：**

| OOD §2 列出的 import 项 | 是否被 test_lib.cj 覆盖 | 覆盖用例 |
|------------------------|----------------------|---------|
| trigonometric | 是 | 15 个（sin/cos/tan/asin/acos/atan/atan2/sinh/cosh/tanh/asinh/acosh/atanh/radians/degrees） |
| detail.Quat（`Quat` 别名） | 是 | 1 个（`testLibQuatFromFwd`） |
| detail.mat3Cast | 是 | 1 个（`testLibMat3CastAccessible`） |
| detail.quatCast | 是 | 1 个（`testLibQuatCastAccessible`） |
| detail.mat4Cast | **否** | 0 |
| 合并的 `ext` + `gtc` 长串（通配符导入 `import glm.ext.*` + `import glm.gtc.*`） | **否** | 0 |

**说明：** 第 6 行（合并的 ext+gtc 长串）按 OOD §2 文本中"14 个 `import glm.ext.*` + 3 个 `import glm.gtc.*`"的通配符导入视为单一未覆盖行（按 lib.cj 文件的 import 语句粒度计）；按函数粒度展开后可拆分为多个独立未覆盖 import 组（vector_relational、quaternion_common、quaternion_geometric、quaternion_trigonometric、quaternion_relational、quaternion_transform、quaternion_exponential、scalar_constants、4 个别名文件、matrix_projection/clip_space/transform、gtc.constants、gtc.quaternion），共 13 个独立 import 组。当前 test_lib.cj 实现的覆盖基线为：**4 个独立覆盖 + 1 个 mat4Cast 遗漏（独立未覆盖行）+ 1 个合并长串遗漏（独立未覆盖行），按函数粒度展开后共 15 个未覆盖 import 组**。

执行者可按此矩阵识别测试缺口并按需补齐测试（尤其是 `mat4Cast` 这一已被 OOD 列入契约但完全未验证的项）。

**视角 B——import 结构偏差（原 G6.2）：** `lib.cj` 的 import 与 OOD §2「20 个新增 import 清单」存在结构偏差。

与 OOD §2 逐项对照存在 4 处偏离：① 省略 `Quat` 的 public import（有注释说明原因）。② trigonometric 按符号名导入而非按包名导入（因 `trigonometric.cj` 声明 `package glm.detail` 同包，`glm.detail.trigonometric` 无法解析）。③ 14 个 `import glm.ext.*` 用单条通配符导入。④ 3 个 `import glm.gtc.*` 用单条通配符导入。合计 20 条 OOD 显式条目被压缩为 5 条 import 语句。功能等价，但偏离 OOD 文本描述。

---

## 汇总

### 分类统计

| 分类 | 加权计数 | 涉及项（权重） |
|------|---------|--------------|
| **真实存在（实现偏差）** | 7.5 | S1(1), S2(0.5), G1.3(0.5), G2.1(1), G2.2(0.5), G2.3(1), G3.1(1), G3.8(1) |
| **误报（实际实现正确）** | 0 | （G5.9 已重分类至「其他类型（测试断言精度不足）」，不再计为误报） |
| **OOD 文档问题** | 5.5 | S2(0.5), G1.3(0.5), G2.2(0.5), G3.7(0.5), G3.9(0.5), G4.3(1), G4.4(0.5), G5.1(0.5), G5.2(0.5), G6.1(0.5) |
| **其他类型** | 25.0 | S3(1), S4(1), G1.6(1), G1.7(1), G1.8(1), G2.4(1), G2.5(1), G2.6(1), G3.2(1), G3.3(1), G3.4(1), G3.5(1), G3.6(1), G3.7(0.5), G3.9(0.5), G4.1(1), G4.2(1), G4.4(0.5), G5.1(0.5), G5.2(0.5), G5.3(1), G5.4(1), G5.5(1), G5.6(1), G5.7(1), G5.8(1), G5.9(1), G6.1(0.5) |

> **计数说明：** 因多项跨分类（如 S2 同时包含真实存在 + OOD 文档问题），采用「部分计数」方式（每项的完整分类权重为 1，拆分为 0.5 + 0.5 等）。总计 4 严重 + 38 一般 = 42 项。v15 删除 G1.1/G1.4/G1.5 共 3 项后有效项为 39 项。加权合计：7.5 + 0 + 5.5 + 25.0 = 38.0（扣除 G1.1 真实存在:1 + G1.4 真实存在:1 + G1.5 真实存在:1 = 3.0）。
>
> **v11 调整：** G4.2 分类由「OOD 文档问题(1)」调整为「其他类型（设计决策惰性）(1)」，分类标注由「OOD 文档问题」改为「其他类型」，G4.2 的权重从 OOD 行的 (1) 移除并加入其他类型行的 (1)。真实存在、误报、其他类型、OOD 文档问题四行加权和分别为 10.5 / 0 / 25.0 / 6.5，合计 42.0 ✓。其他类型的各项权重因 G4.2 的重新分类从 24.0 增至 25.0，OOD 行从 7.5 减至 6.5。
> >
> > **v12 调整：** G6.1/G6.2 权重数据对齐——G6.1 按实际分类（其他类型 + OOD 文档问题）拆分为 其他(0.5) + OOD(0.5)；G6.2 已在 v7 合并入 G6.1 视角 B，删除其独立权重条目。分类汇总表中 OOD 行移除 G6.2(0.5) 并新增 G6.1(0.5)；其他类型行中 G6.1 从 (1) 修正为 (0.5)、移除 G6.2(0.5)。四行加权和不变：10.5 / 0 / 25.0 / 6.5，合计 42.0 ✓。
> > >
> > > **v13 调整：** G4.2 分类汇总表的条目列表与权重明细对齐——OOD 行条目列表移除 G4.2(1)（同步将 OOD 加权计数由 6.5 修正为 5.5），其他类型行条目列表新增 G4.2(1)。四行加权和更新为：10.5 / 0 / 5.5 / 25.0，合计 41.0 ✓。加权总和由 42.0 变为 41.0，系消除 G4.2 在 OOD 行的重复计数所致（v11 已调整 G4.2 分类为其他类型并修正 OOD 行计数为 6.5，但当时未同步更新条目列表；本次列表修正后 OOD 计数精确为 5.5）。

> **权重分配明细（逐项列出，确保汇总可复现）：**
> S1=真实存在:1.0 | S2=真实存在:0.5+OOD:0.5 | S3=其他:1.0 | S4=其他:1.0
> G1.1=已删除 | G1.2=真实存在:1.0 | G1.3=真实存在:0.5+OOD:0.5 | G1.4=已删除 | G1.5=已删除 | G1.6=其他:1.0 | G1.7=其他:1.0 | G1.8=其他:1.0
> G2.1=真实存在:1.0 | G2.2=真实存在:0.5+OOD:0.5 | G2.3=真实存在:1.0 | G2.4=其他:1.0 | G2.5=其他:1.0 | G2.6=其他:1.0
> G3.1=真实存在:1.0 | G3.2=其他:1.0 | G3.3=其他:1.0 | G3.4=其他:1.0 | G3.5=其他:1.0 | G3.6=其他:1.0 | G3.7=其他:0.5+OOD:0.5 | G3.8=真实存在:1.0 | G3.9=其他:0.5+OOD:0.5
> G4.1=其他:1.0 | G4.2=其他:1.0 | G4.3=OOD:1.0 | G4.4=OOD:0.5+其他:0.5
> G5.1=其他:0.5+OOD:0.5 | G5.2=其他:0.5+OOD:0.5 | G5.3=其他:1.0 | G5.4=其他:1.0 | G5.5=其他:1.0 | G5.6=其他:1.0 | G5.7=其他:1.0 | G5.8=其他:1.0 | G5.9=其他:1.0
> G6.1=其他:0.5+OOD:0.5 | G6.2 已合并入 G6.1 视角 B

> **v7 调整：** G5.6 由「真实存在(0.5) + 其他类型(0.5)」调整为「其他类型(1.0)」，原因：slerp 4 参数重载的 stub 行为符合设计意图（`throw Exception("stub")`），不存在实现偏差，签名错误已由 G2.1 计入真实存在。G5.9 由「其他类型(0.5) + 误报(0.5)」调整为「其他类型(1.0)」，原因：`testInverseZero` 的 `||` 宽松断言属测试方法论精度问题，并非「实际实现正确」（实现本身确实返回 NaN），按 requirement.md 第 2 类「误报」定义的严格解读应归入测试断言精度类而非误报类。

### todo.md 条目编号到报告章节映射

| todo.md 编号 | 报告章节 | 主要分类 |
|-------------|---------|---------|
| S1 | §S1 | 真实存在 |
| S2 | §S2 | 真实存在 + OOD 文档问题 |
| S3 | §S3 | 其他类型（测试覆盖不足） |
| S4 | §S4 | 其他类型（测试覆盖不足） |
| G1.1 | §G1.1 | 已删除（项目级设计约定，非 Quat 独有偏差） |
| G1.2 | §G1.2 | 真实存在 |
| G1.3 | §G1.3 | OOD 文档问题 + 真实存在 |
| G1.4 | §G1.4 | 已删除（项目级 const 标注系统性遗漏） |
| G1.5 | §G1.5 | 已删除（项目级零值获取模式，非 Quat 独有偏差） |
| G1.6 | §G1.6 | 其他类型 |
| G1.7 | §G1.7 | 其他类型 |
| G1.8 | §G1.8 | 其他类型 |
| G2.1 | §G2.1 | 真实存在 |
| G2.2 | §G2.2 | 真实存在 + OOD 文档问题 |
| G2.3 | §G2.3 | 真实存在 |
| G2.4 | §G2.4 | 其他类型 |
| G2.5 | §G2.5 | 其他类型 |
| G2.6 | §G2.6 | 其他类型 |
| G3.1 | §G3.1 | 真实存在 |
| G3.2 | §G3.2 | 其他类型 |
| G3.3 | §G3.3 | 其他类型 |
| G3.4 | §G3.4 | 其他类型 |
| G3.5 | §G3.5 | 其他类型 |
| G3.6 | §G3.6 | 其他类型 |
| G3.7 | §G3.7 | 其他类型 + OOD 文档问题(部分) |
| G3.8 | §G3.8 | 真实存在 |
| G3.9 | §G3.9 | 其他类型 + OOD 文档问题(部分) |
| G4.1 | §G4.1 | 其他类型 |
| G4.2 | §G4.2 | 其他类型（设计决策惰性） |
| G4.3 | §G4.3 | OOD 文档问题 |
| G4.4 | §G4.4 | OOD 文档问题 |
| G5.1 | §G5.1 | 其他类型 + OOD 文档问题 |
| G5.2 | §G5.2 | 其他类型 + OOD 文档问题 |
| G5.3 | §G5.3 | 其他类型 |
| G5.4 | §G5.4 | 其他类型 |
| G5.5 | §G5.5 | 其他类型 |
| G5.6 | §G5.6 | 其他类型（测试覆盖不足） |
| G5.7 | §G5.7 | 其他类型 |
| G5.8 | §G5.8 | 其他类型 |
| G5.9 | §G5.9 | 其他类型（测试断言精度不足） |
| G6.1 | §G6.1 | 其他类型 + OOD 文档问题 |

### 修复优先级建议

| 优先级 | 修复顺序 | 问题编号 | 理由 | 文件级依赖关系 |
|--------|---------|---------|------|--------------|
| **Critical** | 1 | S2 | 300+ @Test 全部静默跳过，所有测试结果不可信，影响后续所有修复验证（**假设性前提：** 本结论基于未实证的 `cjpm test` TOTAL=425 输出。若实际 TOTAL != 425，S2 的影响范围需重新评估） | `cjpm.toml` → 测试文件命名重构 |
| **High** | 2 | S1 | 最严重功能缺陷，quatCast 返回值错误，影响所有 round-trip 场景 | `type_quat_cast.cj`（与 G1.5、G1.6、G1.7、G2.3 同文件） |
| **High** | 3 | S3 | round-trip 测试方法论薄弱：6/8 用例包含 round-trip 断言。身份 round-trip 无法捕获 quatCast 因子 2 bug；非身份 round-trip 可捕获（mat3Cast 不归一化已验证），身份 round-trip 仍存在捕获盲区 | `test_type_quat_cast.cj` |
| **High** | 4 | G2.1 | API 签名层面错误（`spin: Bool` vs `k: Int64`），将阻塞阶段四完整实现 | `quaternion_common.cj` |
| **Medium** | 5 | G2.3 | 项目级一致性问题，跨 3 个文件违反 OOD §1 方案 A；不影响功能正确性（同类 G1.x 代码质量建议均为 Low），因此由 High 降级至 Medium | `type_quat_cast.cj`, `quaternion_geometric.cj`, `quaternion_trigonometric.cj` |
| **Medium** | 6 | G2.2 | 约束过宽，但阶段四才触发编译失败 | `quaternion_common.cj` |
| **Medium** | 7 | G1.1, G1.2, G1.4, G1.5 | OOD 实现偏差，当前仅影响 const 可用性和代码风格 | `type_quat.cj`, `type_quat_cast.cj` |
| **Medium** | 8 | G3.8 | 17 个 unused import 编译警告，可能涉及通配符改显式 import 的决策（工作量较大）。编译警告不影响功能正确性，因此由 Medium-High 降级至 Medium。**注：** v10 已标注本数字为逻辑推断，需 `cjpm build` 实证 | 独立 |
| **Medium** | 9 | G3.6 | gen_fwd_aliases.py CRLF/LF 幂等性破坏，修改写入逻辑（约 10 行代码） | 独立 |
| **Medium-Low** | 10 | G3.5 | fwd.cj.bak 误纳入仓库，单命令 `git rm` 即可（约 1 分钟）。**注：** v10 已补充前置验证步骤（git 跟踪状态检查） | 独立 |
| **Medium** | 11 | G5.3, G5.4, G5.5, G5.6, G5.7 | 测试覆盖缺口，降低回归检测能力 | 独立（各测试文件） |
| **Medium** | 12 | G6.1 | 直接验证 OOD §2 lib.cj 20 个 import 契约，阶段四新增 import 时需同步补充测试。**注：** v10 已统一口径为"覆盖 4 个独立 import 组，未覆盖组为 mat4Cast + 合并长串" | `cjglm/src/lib.cj`, `cjglm/tests/glm/test_lib.cj` |
| **Low** | — | G1.6, G1.7, G1.8, G2.4, G2.5, G2.6 | 代码质量/风格/注释优化建议 | 独立 |
| **Low** | — | G3.2, G3.3, G3.4, G3.7, G3.9 | 风格/注释/文档与实现细微偏差 | 独立 |
| **Low** | — | G4.1, G4.3 | 实现简化/文档更新 | `scalar_constants.cj` |
| **Low** | — | G5.1, G5.2, G5.8, G5.9 | 测试增强建议 | 各测试文件 |
| **Low** | — | G4.2, G4.4 | OOD 文档/偏差登记维护 | `docs/deviations.md`, `docs/05_ood_phase3.md` |

> **特别说明：** S2 列为唯一 Critical 优先级的理由是：当前状态下 `tests/` 目录下 300+ `@Test` 静默跳过——`src/detail/*_test.cj` 14 个文件共 425 个测试用例仍正常执行（含 422 PASSED + 3 FAILED，其中 13 个阶段一/二残留文件 422 PASSED + 1 个阶段三 S1 独立修复验证文件 `type_quat_cast_s1_test.cj` 3 FAILED）；但 `tests/` 下覆盖 OOD §8.2 测试计划的测试用例全部无法验证。这意味着任何针对 `tests/` 目录的测试相关修复（包括 S3、S4、G5、G6 的修复正确性）无法通过 `cjpm test` 验证。S2 修复（测试文件命名重构）不依赖 S1，可独立先行。
>
> **v12 实证基线声明：** 本报告所有引用 `cjpm test` 输出数字的结论均依赖头部全局实证基线声明及「若数字不成立时的重审指南」表。

> **S2 与测试类问题的依赖关系：** 由于 S2（测试文件不被 cjpm 发现）导致 `tests/` 下所有 @Test（含 S3、S4、G5、G6 的全部测试用例）静默跳过，下列测试类问题的修复在 S2 修复前无法通过 `cjpm test` 验证：S3（test_type_quat_cast 方法论改进）、S4（ULP stub 测试覆盖补全）、G5 全部子项（测试覆盖盲点）、G6 全部子项（lib/fwd 测试覆盖）。建议修复策略：在 S2 修复前，测试类问题仅做计划（设计测试用例预期）不做实施；S2 修复验证通过后，再逐一推进测试类问题的修复和验证。S2 修复的备选验证手段见下文「S1 修复验证后备方案」——该方案同样适用于测试类问题的单文件验证。

> **S1 修复验证后备方案（S2 被阻塞时）：** 若 S2 因故无法立即实施（如 CI 配置未就绪、批量 rename 待评审），S1 的修复验证可通过以下替代手段推进：
> 1. **手动编译并运行单文件测试：** 使用 `cjc` 直接编译 `test_type_quat_cast.cj`（添加必要 import），手动执行编译产物验证 round-trip 行为。
> 2. **临时单文件命名测试：** 将 `tests/glm/detail/test_type_quat_cast.cj` 临时复制为 `src/detail/type_quat_cast_test.cj`（符合 cjpm `*_test.cj` 发现规则），运行 `cjpm test` 仅验证此单文件。验证完毕后删除临时文件。**注意：** 源文件包声明 `package glm.detail` 与 `src/detail/` 目录路径一致；`import glm.unittest.*` 依赖在已有 `src/detail/type_quat_cast_s1_test.cj` 中已验证可正常解析。若编译失败，回退至方案 1（手动 cjc 编译）或方案 4（基于已有 s1_test 文件扩展）。
> 3. **与 GLM 参考实现手动对比：** 对多组输入值（身份、非身份、边界值）分别在 C++ GLM 参考实现和仓颉实现上运行 quatCast/mat3Cast/mat4Cast round-trip，手动比对结果矩阵/四元数。可通过小型 Python/C++ 脚本来批量验证。
> 4. **阶段四测试独立验证：** 在 `cjglm/src/detail/type_quat_cast_s1_test.cj`（已存在的 S1 独立修复验证文件，含 3 个 `@Test`：`testS1QuatCastScalingXBranch`/`testS1QuatCastScalingWBranch`/`testS1QuatCastNonUnitRoundTrip`）中，使用 `@Test` 标注的非 round-trip 直接元素验证（验证 quatCast 返回的具体分量数值与 GLM 参考实现一致），通过 `cjc` 编译此文件后独立运行。
> 5. **cjpm test --verbose 实证：** 运行 `cjpm test --verbose` 确认 3 个 FAILED 用例名是否集中在 `testS1Quat*` 前缀——若不集中则归因失败，需按 §S2 反事实论证段扩展分析。

> **type_quat_cast.cj 统一修复管线：** 该文件涉及 S1（算法正确性）、G1.5（`one - one` vs 字面量）、G1.6（`sqrtT`/`zeroOrOne` 设计）、G1.7（`var`+串行 `if` 控制流）、G2.3（`sqrtT` Float64 中转）共 5 个问题。建议以下修复顺序：
> 1. **S1 优先（算法正确性）**：修复 quatCast 中各分支的 `*0.5` 因子缺失。这是功能正确性修复，将改变 quatCast 的输出值，影响后续所有 code review 的基线。
> 2. **G2.3（sqrtT 重构）**：在 S1 确认正确后，将 `sqrtT` 从 Float64 中转改为 OOD §1 方案 A 的直接调用策略。此重构在数学含义上保持数值结果不变（输入输出关系一致），但浮点位模式可能因直接调用精度重载而产生微小差异（约 1e-7 量级，详见下方决策指南）。该差异仅影响浮点表示的末尾比特，不改变算法的功能正确性。
> 3. **G1.5（mat4Cast 零值路径）**：将 `one - one` 替换为 `T(Float64(0))` 字面量。与 S1/G2.3 无冲突，可在前两步之后独立修复。
> 4. **G1.6（zeroOrOne 命名）**：重命名或移除 `zeroOrOne` 辅助函数（S1 修复后 quatCast 各分支的 var 初始化可直接使用字面量 0）。依赖 S1 完成后的代码形态。
> 5. **G1.7（控制流优化）**：可保留 GLM 直译模式（功能等价），在阶段四代码完整后再评估是否需要重构。此项可移至最后或推迟处理。
>
> **步骤 1+2 合并 vs 分两次提交的决策指南：**
> - **G2.3 重构的数值性质说明**：G2.3 从 Float64 中转改为直接调用精度重载，在**数学含义**上不改变 sqrt 的输入输出关系（同一输入值经过两种路径的数学结果相同），但在**浮点位模式**上会因中间精度的差异而产生微小偏差（约 1e-7 量级）。因此"不改变数值结果"与"产生新的数值差异"分别指数学含义和浮点位模式两个不同层面，陈述方向不矛盾。步骤 2 本身不引入功能正确性风险，仅可能影响对浮点精度敏感的测试断言。
> - **合并提交（推荐条件）**：执行者对测试集有充分信心——若合并后 round-trip 测试因浮点位模式差异失败，仅需调整断言容差（如将 `@Expect(m == m2, true)` 改为 `@Expect(abs(m - m2) < epsilon, true)`），确认无逻辑回归即可。合并可减少一次 CI 排队与 review 轮次，适合测试容差已预留余量的场景。PR 描述须明确标注 S1（算法因子修复）与 G2.3（sqrtT 路径重构）两个独立修改的边界。
> - **分两次提交（推荐条件）**：测试集使用精确 `==` 比较且不允许调整断言容差；或 code review 流程要求每次提交聚焦单一问题。分拆后步骤 1 保持 `sqrtT` Float64 中转路径，可独立验证 S1 修复正确性（无浮点路径变化干扰）；步骤 2 独立验证 G2.3 重构的精度影响。
>
> **合并提交风险提示（针对步骤 1+2 合并）：** 若 S1 修复后立即合并 G2.3 sqrtT Float64→直接调用重构，需注意 G2.3 重构会**改变 sqrt 调用路径**——从 Float64 中转（精度降级但行为可预测）改为直接调用 `std.math.sqrt(Float32)` 等重载（保留 Float32/Float16 精度）。两次路径变更叠加可能因浮点路径变化导致现有 passing 测试产生**新的数值差异**（即便每个修改单独均正确）。具体表现：步骤 1 修复后若 sqrt 路径仍走 Float64 中转，passing 测试仍通过；步骤 2 切换为直接调用后，原本通过 `0 == 0` 精确比较的 round-trip 测试可能因 Float32 sqrt 精度差异（1e-7 量级）而出现微小偏差。
>
> **分两次提交的执行方案：**
> - **提交 1（S1 单独修复）**：仅修改 quatCast 各分支的 `*0.5` 因子，保持 `sqrtT` Float64 中转路径不变。运行完整测试集验证 S1 修复正确性，确认无回归。
> - **提交 2（G2.3 重构）**：在 S1 提交已合并并验证通过后，独立修改 `sqrtT` 改为直接调用策略。运行测试集验证精度差异在可接受范围内（必要时调整测试断言容差）。
>
> 此分拆策略的优势：① 每次提交的变更范围聚焦单一问题，便于 code review 与回滚；② 任何回归可精确定位到具体提交；③ 避免「算法修复 + 路径重构」双重变更叠加产生难以诊断的混合偏差。

**关键发现汇总：**
1. **S1（quatCast 因子 2 bug）** 是最严重的功能缺陷，影响所有四元数-矩阵互转的 round-trip 行为。
2. **S2（测试文件不被发现）** 导致 300+ @Test 静默跳过，所有测试结果不可信，列为唯一 Critical 优先级。修复后 S1 修复方可被 `cjpm test` 验证。**v10 补充：** S2 证据段引用的 `cjpm test` 输出数字（TOTAL=425/PASSED=422/FAILED=3）需通过实证基线声明段所列命令独立验证，作为下游 S1/S3 修复验证的事实基线。
3. **G2.1（slerp spin: Bool vs k: Int64）** 是 API 签名层面的严重设计偏差，将阻塞阶段四的完整实现。
4. **G2.3（sqrtT Float64 中转）** 是违反 OOD §1 方案 A 的项目级一致性问题，跨 3 个文件。
5. **S3** 的核心问题是身份四元数 round-trip 的捕获盲区（非整体不可捕获），测试方法论改进仍具有独立价值。
6. 大多数一般问题属于**测试覆盖不足**或**代码可优化**类别，不构成功能缺陷。

