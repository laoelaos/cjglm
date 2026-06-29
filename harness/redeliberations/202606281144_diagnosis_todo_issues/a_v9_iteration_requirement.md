根据以下审查结果，迭代上一轮的产出，形成新版的文件，从而更好地满足用户需求。

## 当前审查结果

本轮（v8）质量审查共发现 5 个质量问题，质询报告（b_v8_challenge_v1.md）已通过 LOCATED 验证，确认问题成立。具体问题如下：

### 问题 1（高，严重事实错误）：§S2 归因分析引用不存在的文件且测试名指向未执行文件
- **位置：** a_v8_diag_v1.md §S2「3 个 FAILED 用例的归因分析」段（行 69）
- **现状：** §S2 归因分析段声称"3 个 FAILED 用例预期均来自 `src/detail/type_quat_cast_test.cj` 的非身份四元数 round-trip 用例（`testQuatCastNonIdentityMat3RoundTrip` 等）"。但经核查：① `src/detail/type_quat_cast_test.cj` 不存在，唯一 quat_cast 相关测试文件是 `cjglm/src/detail/type_quat_cast_s1_test.cj`（S1 独立修复验证文件，含 3 个 `@Test`：`testS1QuatCastScalingXBranch`、`testS1QuatCastScalingWBranch`、`testS1QuatCastNonUnitRoundTrip`）；② 测试名指向 `tests/glm/detail/test_type_quat_cast.cj`，但该文件位于 `tests/` 目录下，其 300+ `@Test` 全部静默跳过、不被 `cjpm test` 执行；③ 实际 FAILED 来源唯一候选是 `type_quat_cast_s1_test.cj`。
- **影响：** ① S1 bug 在当前测试基础设施下的实际暴露面定位失准；② S1 修复后「3 FAILED → PASS」预测可信度受损；③ 与 §S1 修复验证后备方案第 4 项（已正确引用 `type_quat_cast_s1_test.cj`）形成内部矛盾。
- **修复建议：** 将 §S2 归因分析段改为"`cjpm test` 输出的 3 个 FAILED 用例预期均来自 `cjglm/src/detail/type_quat_cast_s1_test.cj`（S1 独立修复验证文件）——该文件含 3 个 `@Test`：`testS1QuatCastScalingXBranch`（q=(0.8,0.1,0.1,0.1)，X 分支）、`testS1QuatCastScalingWBranch`（q=(0.1,0.1,0.1,0.8)，W 分支）、`testS1QuatCastNonUnitRoundTrip`（q=(0.2,0.3,0.4,0.8)，非身份 round-trip），每个 `@Test` 函数体内多个 `@Expect` 断言在 S1 bug 影响下均不成立（如 `testS1QuatCastScalingXBranch` 中 `@Expect(q1.y, 0.1)` 在 bug 下实际值约为 0.2）。归因核实手段：① 运行 `cjpm test --verbose` 确认 FAILED 用例名集中在 `testS1Quat*` 前缀；② 归因一致时 S1 修复后预期 3 FAILED → PASS（`type_quat_cast_s1_test.cj` 的非单位四元数测试用例在 S1 修复后 quatCast 返回的个分量等于 q0 的对应分量，断言通过；mat3Cast 不归一化路径下 round-trip 矩阵相等）。"

### 问题 2（中等）：§S2 测试文件计数与同报告证据段自相矛盾
- **位置：** a_v8_diag_v1.md §S2 行 60 vs 行 726
- **现状：** 行 60 描述"全部 425 个测试用例均来自 `src/detail/*_test.cj`（阶段一/二残留的 **13 个测试文件**）"，行 726 描述"`src/detail/*_test.cj` **14 个文件**共 425 个测试用例仍正常执行"。两处数字不一致且未明确两个数字的语义区分。
- **修复建议：** 明确"13 个"与"14 个"的语义：13 个指阶段一/二遗留测试文件（`compute_vector_decl_test.cj`/`compute_vector_relational_test.cj`/`qualifier_test.cj`/`scalar_vec_ops_test.cj`/`setup_test.cj`/`shim_assert_test.cj`/`shim_limits_test.cj`/`type_cast_test.cj`/`type_fromBoolVec_test.cj`/`type_vec2_test.cj`/`type_vec3_test.cj`/`type_vec4_test.cj`/`vectorize_test.cj`，合计 422 个 `@Test`），14 个指上述 13 个 + 阶段三 S1 独立修复验证文件 `type_quat_cast_s1_test.cj`（含 3 个 `@Test`），合计 425 个。建议在 §S2 证据段明确表述"src/detail/ 下 14 个测试文件（含 13 个阶段一/二残留 + 1 个阶段三 S1 独立修复验证文件 `type_quat_cast_s1_test.cj`），共 425 个 `@Test`"。

### 问题 3（低，与问题 1 强相关）：§S2 归因结论中"待执行者核实手段"②项的描述与归因方向不匹配
- **位置：** a_v8_diag_v1.md §S2 行 69「待执行者核实手段」②
- **现状：** 核实手段②指出"单文件 `cjc` 编译 `test_type_quat_cast.cj`"——但该文件位于 `tests/` 目录下，且其包声明为 `glm.detail`，需与 `cjglm/src/detail/type_quat_cast.cj` 同包编译环境；此外此文件名引用与归因分析的 `src/detail/type_quat_cast_test.cj`（即问题 1 中不存在的文件）不一致。
- **修复建议：** 将核实手段②改为"单文件 `cjc` 编译 `cjglm/src/detail/type_quat_cast_s1_test.cj`（含必要的 `import glm.unittest.*` 与 `glm.unittest.testmacro.*`）后独立运行，确认 3 个 `@Test` 函数因 S1 bug 全部 FAIL"。

### 问题 4（低）：S1 bug 验证样本的具体数值与 q=(0.2,0.3,0.4,0.8) 的精确计算结果存在轻微偏差未说明
- **位置：** a_v8_diag_v1.md §S1 行 38
- **现状：** §S1 分析段描述"以 `Quat(0.2, 0.3, 0.4, 0.8)` round-trip 验证：`quatCast(mat3Cast(q))` 返回约 `(0.38, 0.57, 0.76, 0.84)`，约为原 q 的 1.9 倍"。实际推导：v = sqrt(2.84) ≈ 1.6852；x ≈ 0.3798；y ≈ 0.5697；z ≈ 0.7596；w ≈ 0.8426。即 quatCast 返回 ≈ (0.38, 0.57, 0.76, 0.84)，非 w 分量实测比例 1.899（非精确 2.0），w 分量实测比例 1.053。报告未明确标注"约"的精确度。
- **修复建议：** 在 §S1 行 38 末尾追加："具体数值校核：`v = sqrt(2.84) ≈ 1.6852`（缺 *0.5 因子）；x/y/z 各分量约为 0.3798/0.5697/0.7596（实测比例 1.899）；w = 0.8426（实测比例 1.053）。浮点累积误差致非 w 分量实测比例非精确 2.0，但数学上确为 2.0 倍——`0.64/(sqrt(2.84)) = 0.64/sqrt(2.84)` 与正确路径 `0.64*0.25/(0.5*sqrt(2.84)) = 0.64*0.5/sqrt(2.84)` 的比值精确为 2.0。"

### 问题 5（低）：§G1.3 修复方向推荐的论据 ② 中 GLM `quatCast` 算法的引用范围未限定
- **位置：** a_v8_diag_v1.md §G1.3 行 190 论据 ②
- **现状：** §G1.3 修复方向推荐段论据 ② 描述"GLM `quatCast` 内部同样依赖 `T > T` 比较（`fourBiggestSquaredMinus1` 的大小分支判定）"，但未限定 GLM `quatCast` 的具体行号范围。
- **修复建议：** 在论据 ② 追加具体行号引用："GLM `references/glm-1.0.3/glm/glm/gtc/quaternion.inl:95-104` 使用 3 个 `if (fourX/Y/ZSSquaredMinus1 > fourBiggest...)` 串行比较"。

### 修复优先级
1. **关键修复（必做）：** 问题 1（§S2 归因引用错误文件）—— 必须修正以避免误导执行者按错误的测试名核对 3 个 FAILED 来源。
2. **次优修复：** 问题 3（与问题 1 强相关，核实手段②文件名引用同步修正）；问题 2（13 vs 14 计数矛盾）。
3. **可选修复：** 问题 4（S1 数值精度补充）；问题 5（GLM 行号引用补充）。

## 历史迭代回顾

历史迭代共 8 轮，本轮（v8）为第 9 轮迭代的输入。本轮 5 个问题均为 v8 新发现的问题，与历史迭代中已记录的问题无重复：

- **已解决的问题（历史反馈中已修复，本轮不再提及）：**
  - 迭代第 1 轮的 5 个问题（计数偏差、G1.6 自相矛盾、deviations.md 使用不足、汇总表计数偏差、缺乏优先级排序）— v8 报告中均已妥善解决
  - 迭代第 2 轮的 4 个问题（S3 优先级理由矛盾、G3.5/G3.6 分类、Blocker 优先级矛盾、S1 修复后 S3 降级）— v8 报告中均已妥善解决
  - 迭代第 3 轮的 3 个问题（S3 round-trip 计数、S4 stub 计数、S3/S4 分类）— v8 报告中均已妥善解决
  - 迭代第 4 轮的 4 个问题（S3 区分身份/非身份、deviations.md 方向、S2 副作用评估、type_quat_cast.cj 联合修复）— v8 报告中均已妥善解决
  - 迭代第 5 轮的 3 个问题（S2 实证支撑、deviations.md 交叉验证深度、S2 依赖关系显式阐明）— v8 报告中均已妥善解决
  - 迭代第 6 轮的 3 个问题（G5.6 分类、S3 证据链完整、G2.2 下游影响）— v8 报告中均已妥善解决
  - 迭代第 7 轮的 1 个问题（G2.1 迁移成本三项诉求）— v8 报告中均已妥善解决

- **持续存在的问题：** 无。本轮 5 个问题均为本轮新识别的问题，不在历史反馈记录中。

- **新发现的问题（本轮 v8 新识别）：**
  - 问题 1（§S2 归因引用不存在文件 `src/detail/type_quat_cast_test.cj` 与未执行的 `test_type_quat_cast.cj` 测试名）— 严重，需重点修复
  - 问题 2（§S2 行 60「13 个测试文件」与行 726「14 个文件」语义区分缺失）— 中等
  - 问题 3（§S2 归因段核实手段②文件名引用错误）— 低，与问题 1 强相关
  - 问题 4（§S1 浮点实测比例 1.899 vs 精确 2.0 精度说明缺失）— 低
  - 问题 5（§G1.3 论据② GLM `quatCast` 行号引用范围缺失）— 低

## 上一轮产出路径
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606281144_diagnosis_todo_issues\a_v8_diag_v1.md（827 行，少于 1000 行，无需 COPY_AND_EDIT 模式）

## 用户需求
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606281144_diagnosis_todo_issues\requirement.md