# 质量审查报告：诊断报告 a_v8_diag_v1.md

**审查轮次：** 第 8 轮
**审查日期：** 2026-06-28
**审查对象：** `harness/redeliberations/202606281144_diagnosis_todo_issues/a_v8_diag_v1.md`
**审查范围：** 产出是否充分响应用户需求；是否存在事实错误或逻辑矛盾；深度与完整性是否满足后续使用需要（侧重可操作性、副作用、优先级合理性）

---

## 一、整体评价

本报告整体质量较高，已系统回应 v7 challenge 的 6 个修订问题：G6.1 测试数量与 import 组描述、G2.1 迁移成本评估、S2 Critical 优先级理由表述、S1 bug 的 3 个 FAILED 用例归因、G3.5/G3.6/G3.8 工作量差异标注、G1.3 双向修复方向推荐均已落地。G2.1「修复方案的迁移成本评估」三项具体诉求（grep 扫描命令、GLM `phi = angle + k * pi<T>()` 语义对齐、`testSlerp4ArgsK0/K1/KMinus1` 验证用例）全部覆盖完整；G1.3「修复方向推荐（方向 A：文档跟随实现）」三理由（文档反映实际编译期约束、GLM quatCast 同样依赖 `<` 比较、修复成本 A 显著低于 B）逻辑自洽；G3.5/6/8 已按工作量拆分为 #8a/#8b/#8c 三档；G6.1 已修正为 18 个用例覆盖 3 个 import 组并补充可执行矩阵。修复优先级建议的可操作性显著提升。

但报告在 §S2 新增内容中存在关键事实错误——3 个 FAILED 用例的归因分析引用了不存在的文件，且与 §S2 自身证据段（"`src/detail/*_test.cj` 14 个文件"）存在内部矛盾。具体问题如下。

---

## 二、具体质量问题

### 问题 1（关键）：§S2 归因分析引用不存在的文件且测试名指向未执行文件

- **问题描述：** §S2 归因分析段（第 69 行）声称"3 个 FAILED 用例预期均来自 `src/detail/type_quat_cast_test.cj` 的非身份四元数 round-trip 用例（`testQuatCastNonIdentityMat3RoundTrip`、`testQuatCastNonIdentityMat4RoundTrip`、`testMat3CastNonIdentityQuat`/`testMat4CastNonIdentityQuat` 等）"。经核查：
  1. **`src/detail/type_quat_cast_test.cj` 不存在**：仓库内 `find` 搜索无该文件，唯一存在的 quat_cast 相关测试文件是 `cjglm/src/detail/type_quat_cast_s1_test.cj`（S1 独立修复验证文件，含 3 个 `@Test`：`testS1QuatCastScalingXBranch`、`testS1QuatCastScalingWBranch`、`testS1QuatCastNonUnitRoundTrip`）。
  2. **测试名指向 `tests/glm/detail/test_type_quat_cast.cj`**：`testQuatCastNonIdentityMat3RoundTrip` 等测试名存在于 `tests/glm/detail/test_type_quat_cast.cj`，但该文件位于 `tests/` 目录下，根据 §S2 主结论本身，**`tests/` 目录的 300+ `@Test` 全部静默跳过、不被 `cjpm test` 执行**。因此这些测试名对应的用例不可能是当前 `cjpm test` 输出的 3 个 FAILED 来源。
  3. **实际 FAILED 来源唯一候选是 `type_quat_cast_s1_test.cj`**：根据 §S2 证据段（"全部 425 个测试用例均来自 `src/detail/*_test.cj`"），唯一在 `src/detail/` 中测试 `quatCast` 行为且会因 S1 bug 而 FAIL 的文件是 `type_quat_cast_s1_test.cj`。该文件 3 个 `@Test` 函数体内 `@Expect(q1.x, 0.1)` 等精确断言在 S1 bug 影响下均不成立，与 `cjpm test` 输出的 `FAILED: 3` 完全对应。
- **所在位置：** a_v8_diag_v1.md §S2「3 个 FAILED 用例的归因分析」段（行 69）
- **严重程度：** **高（关键事实错误）**——该归因结论是 §S2 与 §S1/S3 交叉验证的核心证据链，直接影响：
  1. S1 bug 在当前测试基础设施下的实际暴露面（执行者无法据此准确定位受影响测试）
  2. S1 修复后「3 FAILED → PASS」的预测可信度（基于错误测试名可能误导执行者核对 `test_type_quat_cast.cj` 而非 `type_quat_cast_s1_test.cj`）
  3. §S1 修复验证后备方案第 4 项（"在 `cjglm/src/detail/type_quat_cast_s1_test.cj` 中..."）与本段归因的内部一致性
- **改进建议：** 将 §S2 归因分析段改为："`cjpm test` 输出的 3 个 FAILED 用例预期均来自 `cjglm/src/detail/type_quat_cast_s1_test.cj`（S1 独立修复验证文件）——该文件含 3 个 `@Test`：`testS1QuatCastScalingXBranch`（q=(0.8,0.1,0.1,0.1)，X 分支）、`testS1QuatCastScalingWBranch`（q=(0.1,0.1,0.1,0.8)，W 分支）、`testS1QuatCastNonUnitRoundTrip`（q=(0.2,0.3,0.4,0.8)，非身份 round-trip），每个 `@Test` 函数体内多个 `@Expect` 断言在 S1 bug 影响下均不成立（如 `testS1QuatCastScalingXBranch` 中 `@Expect(q1.y, 0.1)` 在 bug 下实际值约为 0.2）。归因核实手段：① 运行 `cjpm test --verbose` 确认 FAILED 用例名集中在 `testS1Quat*` 前缀；② 归因一致时 S1 修复后预期 3 FAILED → PASS（`type_quat_cast_s1_test.cj` 的非单位四元数测试用例在 S1 修复后 quatCast 返回的个分量等于 q0 的对应分量，断言通过；mat3Cast 不归一化路径下 round-trip 矩阵相等）。"

### 问题 2（中等）：§S2 测试文件计数与同报告证据段自相矛盾

- **问题描述：** §S2 证据段（第 60 行）描述"全部 425 个测试用例均来自 `src/detail/*_test.cj`（阶段一/二残留的 **13 个测试文件**）"，但同报告修复优先级建议表后的特别说明（第 726 行）描述"`src/detail/*_test.cj` **14 个文件**共 425 个测试用例仍正常执行"。两处"13 个"与"14 个"不一致，且未明确两个数字的语义区分。
- **所在位置：** a_v8_diag_v1.md §S2 行 60 vs 行 726
- **严重程度：** 中（数字自相矛盾，虽不影响主结论，但影响报告内部一致性，且可能误导执行者对 cjpm 测试基础设施的统计认知）
- **改进建议：** 明确"13 个"与"14 个"的语义：13 个指阶段一/二遗留测试文件（`compute_vector_decl_test.cj`/`compute_vector_relational_test.cj`/`qualifier_test.cj`/`scalar_vec_ops_test.cj`/`setup_test.cj`/`shim_assert_test.cj`/`shim_limits_test.cj`/`type_cast_test.cj`/`type_fromBoolVec_test.cj`/`type_vec2_test.cj`/`type_vec3_test.cj`/`type_vec4_test.cj`/`vectorize_test.cj`，合计 422 个 `@Test`），14 个指上述 13 个 + 阶段三 S1 独立修复验证文件 `type_quat_cast_s1_test.cj`（含 3 个 `@Test`），合计 425 个。建议在 §S2 证据段明确表述"src/detail/ 下 14 个测试文件（含 13 个阶段一/二残留 + 1 个阶段三 S1 独立修复验证文件 `type_quat_cast_s1_test.cj`），共 425 个 `@Test`"。

### 问题 3（低）：§S2 归因结论中"待执行者核实手段"②项的描述与归因方向不匹配

- **问题描述：** §S2 归因段（第 69 行）"待执行者核实手段"②指出"单文件 `cjc` 编译 `test_type_quat_cast.cj`"——但 `test_type_quat_cast.cj` 位于 `tests/` 目录下（不在 `src/detail/`），且其包声明为 `glm.detail`，需与 `cjglm/src/detail/type_quat_cast.cj` 同包编译环境；此外此文件名引用与归因分析的 `src/detail/type_quat_cast_test.cj`（即同问题 1 中不存在的文件）不一致，执行者按此命令执行时会找不到文件。
- **所在位置：** a_v8_diag_v1.md §S2 行 69「待执行者核实手段」②
- **严重程度：** 低（核实手段的可行性问题，不影响归因主结论本身；与问题 1 强相关）
- **改进建议：** 将核实手段②改为"单文件 `cjc` 编译 `cjglm/src/detail/type_quat_cast_s1_test.cj`（含必要的 `import glm.unittest.*` 与 `glm.unittest.testmacro.*`）后独立运行，确认 3 个 `@Test` 函数因 S1 bug 全部 FAIL"。

### 问题 4（低）：S1 bug 验证样本的具体数值（0.38, 0.57, 0.76, 0.84）与 q=(0.2,0.3,0.4,0.8) 的精确计算结果存在轻微偏差未说明

- **问题描述：** §S1 分析段（第 38 行）描述"以 `Quat(0.2, 0.3, 0.4, 0.8)` round-trip 验证：`quatCast(mat3Cast(q))` 返回约 `(0.38, 0.57, 0.76, 0.84)`，约为原 q 的 1.9 倍"。经实际推导（按 Cangjie `type_quat_cast.cj:83-107` 算法逐步计算）：v = sqrt(1.84+1) = sqrt(2.84) ≈ 1.6852；x = (m.c1.z - m.c2.y)/v = 0.64/1.6852 ≈ 0.3798；y = 0.96/1.6852 ≈ 0.5697；z = 1.28/1.6852 ≈ 0.7596；w = 1.6852*0.5 ≈ 0.8426。即 quatCast 返回 ≈ (0.38, 0.57, 0.76, 0.84)，非 w 分量约为原 q 的 1.899 倍（接近但不完全等于 1.9）。报告未明确标注"约"的精确度（如"实测非 w 分量 ≈ 1.899 倍"），且未说明 1.9 倍系 w 分量约 1.05 倍而其他分量精确 1.9 倍的不对称性（v8 §S1 末段推断"非最大分量被缩放 2 倍"是精确的，但 round-trip 实测比例 1.899 是浮点累积误差所致）。
- **所在位置：** a_v8_diag_v1.md §S1 行 38
- **严重程度：** 低（数值精度细节问题，不影响 S1 主结论"quatCast 因子 2 bug 真实存在"的可信度；执行者按 Cangjie 算法逐步计算即可复现）
- **改进建议：** 在 §S1 行 38 末尾追加："具体数值校核：`v = sqrt(2.84) ≈ 1.6852`（缺 *0.5 因子）；x/y/z 各分量约为 0.3798/0.5697/0.7596（实测比例 1.899）；w = 0.8426（实测比例 1.053）。浮点累积误差致非 w 分量实测比例非精确 2.0，但数学上确为 2.0 倍——`0.64/(sqrt(2.84)) = 0.64/sqrt(2.84)` 与正确路径 `0.64*0.25/(0.5*sqrt(2.84)) = 0.64*0.5/sqrt(2.84)` 的比值精确为 2.0。"

### 问题 5（低）：§G1.3 修复方向推荐的论据 ② 中 GLM `quatCast` 算法的引用范围未限定

- **问题描述：** §G1.3 修复方向推荐段（第 190 行）论据 ② 描述"GLM `quatCast` 内部同样依赖 `T > T` 比较（`fourBiggestSquaredMinus1` 的大小分支判定），重构避免比较的实现路径偏离 GLM 算法语义"。该论据正确但未限定 GLM `quatCast` 的具体行号范围（GLM `references/glm-1.0.3/glm/glm/gtc/quaternion.inl` 的 `>` 比较位于第 95-104 行的 `if (fourXSquared... > fourBiggest...)` 等 3 个分支），执行者查阅 GLM 源码时需自行定位。
- **所在位置：** a_v8_diag_v1.md §G1.3 行 190 论据 ②
- **严重程度：** 低（论据可验证性细节问题，不影响 G1.3 主结论"推荐方向 A 文档跟随实现"）
- **改进建议：** 在论据 ② 追加具体行号引用："GLM `references/glm-1.0.3/glm/glm/gtc/quaternion.inl:95-104` 使用 3 个 `if (fourX/Y/ZSSquaredMinus1 > fourBiggest...)` 串行比较"。

---

## 三、未发现显著质量问题的维度

以下维度经审查未发现显著质量问题：

- **S1 算法分析核心结论：** 四元数因子 2 缩放 bug 的数学推导正确——GLM `quaternion.inl:106-107` 的 `biggestVal = sqrt(...) * 0.5` + `mult = 0.25 / biggestVal` 与 Cangjie `type_quat_cast.cj:84-106` 的 `v = sqrtT(... + one)` 后直接 `matrixElement / v` 形成清晰的「Cangjie 缺 *0.5 因子」偏差证据链。
- **S2 工具链行为分析：** cjpm 1.1.0 测试发现规则引用正确（`tests/` 命名 `test_*.cj` 前缀不在 cjpm 默认 `*_test.cj` 后缀规则内），与 cjpm 文档 §2.1 一致；S2 修复方案风险评估表覆盖 git 历史、依赖、CI 配置、IDE 缓存四个维度，3 种替代方案对比完整。
- **S3 身份 vs 非身份 round-trip 捕获能力区分：** 区分逻辑自洽，mat3Cast 不归一化的代码位置 `type_quat_cast.cj:5-25` 已显式引用，证据链完整；8 个 `@Test` 中 6 个含 round-trip 断言的具体行号（`:18-25,46-53,55-62,64-75,77-84,86-93`）与 `tests/glm/detail/test_type_quat_cast.cj` 实际行号一致（注：该文件未执行，但报告描述准确）。
- **S4 ULP stub 计数：** 16 个 `public func` 声明已通过 `vector_relational.cj:199-251` 实际代码核查确认（Vec1:199-209 / Vec2:213-223 / Vec3:227-237 / Vec4:241-251 各 4 个），覆盖率 1/16 ≈ 6.25% 计算正确。
- **G1.1-G1.5、G2.1、G2.3、G3.1、G3.5、G3.7-G3.9、G4.1-G4.3 等子项的代码引用：** 均经核查与报告描述一致（`type_quat.cj:20, 61-63, 73, 142-144, 149-151`；`quaternion_common.cj:16-17, 34-35, 40`；`gtc/quaternion.cj:1-4`；`fwd.cj.bak:331/334/337`；`lib.cj:10-16`；`scalar_constants.cj:5-35`）。
- **G2.3 sqrtT 跨文件引用：** 已验证 `type_quat_cast.cj:122-125`（4 处调用）+ `quaternion_geometric.cj:5-8, 17` + `quaternion_trigonometric.cj:5-8, 18` 共 3 个文件的 Float64 中转实现，与报告 G2.3 描述一致。
- **G6.1 测试数量与 import 组修正：** 已从 v7 的「17 个用例 5 个 import 组」修正为 v8 的「18 个用例覆盖 5 个 import 组中的 3 个（Quat: 1、mat3Cast/quatCast: 2、trigonometric: 15）」，与 `test_lib.cj` 实际 grep 结果一致；可执行矩阵表格覆盖完整。
- **G2.1 迁移成本评估三项诉求：** ①grep 扫描命令 `grep -rn 'slerp.*spin\|slerp(.*,.*,.*,.*)' cjglm/`；②语义对齐 GLM 原版 `phi = angle + k * pi<T>()`（`k=0/1/-1` 分别对应 lerp 等价/旋转一周/反向旋转）；③验证用例 `testSlerp4ArgsK0/K1/KMinus1` —— 三项均已落地。
- **G1.3 修复方向推荐论据：** ①OOD 文档应反映实际编译期约束；②GLM quatCast 内部同样依赖 `T > T` 比较；③修复成本 A 显著低于 B —— 三项论据逻辑自洽，方向 A 推荐合理。
- **G3.5/G3.6/G3.8 工作量差异拆分：** 已拆分为 Medium-High #8a（G3.8 通配符改显式 import 决策，工作量较大）/ Medium #8b（G3.6 约 10 行 Python 写入逻辑）/ Medium-Low #8c（G3.5 单命令 `git rm`，约 1 分钟），工作量标注与各问题描述一致。
- **S2 优先级理由表述：** 已从 v7 的"所有测试结果均不可信"修正为"`tests/` 目录下 300+ `@Test` 静默跳过——`src/detail/*_test.cj` 14 个文件共 425 个测试用例仍正常执行"，精确区分受影响范围。
- **修复优先级排序：** S2 > S1 > S3 > G2.1 > G2.3 > ... > Low 的排序基于"前置依赖 → 功能正确性 → API 设计正确性 → 项目一致性 → 测试覆盖 → 代码质量"的层次，逻辑合理；S2 修复不依赖 S1 可独立先行的判断正确。
- **deviations.md 交叉验证：** 三层结构（不适用 → 需登记评估 → 可能影响已有条目）覆盖完整，未发现逻辑矛盾。
- **汇总加权和：** 真实存在 10.5 + 误报 0 + OOD 6.5 + 其他类型 25.0 = 42.0 ✓，与 todo.md 实际列表 4 严重 + 38 一般 = 42 项吻合；章节映射表完整列出 todo.md 编号到报告章节的对应关系。
- **修订说明（v3-v8）：** 历轮修订记录完整，v7 challenge 的 6 项质询响应有理有据；v8 challenge（a_v8_challenge_v1.md）已通过 LOCATED 验证。

---

## 四、修复优先级建议

针对上述 5 个质量问题，建议修复者按以下顺序处理：

1. **关键修复（影响事实正确性与可操作性）：** 问题 1（§S2 归因引用不存在的文件 `type_quat_cast_test.cj` 与未执行的 `test_type_quat_cast.cj` 测试名）—— 必须修正为正确的 `type_quat_cast_s1_test.cj` 与 `testS1Quat*` 测试名；问题 3（核实手段②文件名引用）—— 同步修正为 `type_quat_cast_s1_test.cj`。
2. **次优修复（改善内部一致性与精度）：** 问题 2（§S2 行 60「13 个测试文件」与行 726「14 个文件」区分语义）—— 明确"13 个阶段一/二 + 1 个阶段三 S1 验证"的两档划分；问题 4（§S1 浮点实测比例 1.899 vs 精确 2.0 的说明）。
3. **可选修复（改善论据可验证性）：** 问题 5（§G1.3 论据 ② GLM `quatCast` 行号引用）。

问题 1 是本轮必须解决的关键问题——若不修正，§S2 的归因结论与 §S1 修复验证后备方案第 4 项（已正确引用 `type_quat_cast_s1_test.cj`）形成内部矛盾，且误导执行者按错误的测试名核对 3 个 FAILED 来源。问题 2-5 均为辅助性精度问题，不影响诊断主结论可信度。

报告整体可读性高、覆盖完整，无需返工重写；上述问题可通过增量编辑修复。核心修复策略（S2 优先 → S1 算法修复 → 类型修复管线分两次提交 → 测试覆盖补齐）保持有效。