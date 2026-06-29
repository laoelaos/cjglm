# 再审议判定报告（v8）

## 判定结果

RETRY

## 判定理由

组件B诊断报告（b_v8_diag_v1.md）共识别出 5 个质量问题，其中问题 1 标注为「高（关键事实错误）」，问题 2 为「中」，问题 3、4、5 为「低」。组件B质询报告（b_v8_challenge_v1.md）经独立审查后给出 **LOCATED** 结论，确认问题 1 的多线索证据链（文件名不存在 + 测试名指向未执行文件 + 唯一候选文件分析）具备较强鲁棒性，并将问题 1-5 的严重程度分级与改进建议接受为有效。

组件B内部循环实际轮次为 1（最大 12），属正常提前终止，非循环耗尽；LOCATED 状态表明审查结论经质询确认，问题等级稳定。

依据判定标准：审查报告包含 1 项严重（关键事实错误）及 1 项一般（数字自相矛盾）等级的问题，且该严重问题直接影响 §S2 归因结论与 §S1 修复验证后备方案的内部一致性、误导执行者按错误测试名核对 3 个 FAILED 来源，故判定为 **RETRY**，需重新运行组件A 以修正关键事实错误及次优问题。

## 需要解决的问题（仅 RETRY 时存在）

- **问题描述**：§S2 归因分析段引用了不存在的文件 `src/detail/type_quat_cast_test.cj`，并将其测试名指向位于 `tests/` 目录下、不被 `cjpm test` 执行的 `tests/glm/detail/test_type_quat_cast.cj` 中的 `testQuatCastNonIdentityMat3RoundTrip` 等用例。但根据 §S2 自身证据段（全部 425 个用例均来自 `src/detail/*_test.cj`），当前 `cjpm test` 输出的 3 个 FAILED 用例唯一来源应是 `src/detail/type_quat_cast_s1_test.cj` 的 3 个 `@Test`（`testS1QuatCastScalingXBranch`、`testS1QuatCastScalingWBranch`、`testS1QuatCastNonUnitRoundTrip`），而非所引用的不存在文件与未执行文件。该错误归因直接影响 S1 bug 实际暴露面的定位、修复后「3 FAILED → PASS」预测的可信度，并导致与 §S1 修复验证后备方案第 4 项已正确引用 `type_quat_cast_s1_test.cj` 形成内部矛盾。
- **所在位置**：a_v8_diag_v1.md §S2「3 个 FAILED 用例的归因分析」段（约第 69 行）
- **严重程度**：严重
- **改进建议**：将 §S2 归因分析改为"`cjpm test` 输出的 3 个 FAILED 用例预期均来自 `cjglm/src/detail/type_quat_cast_s1_test.cj`（S1 独立修复验证文件）——该文件含 3 个 `@Test`：`testS1QuatCastScalingXBranch`（q=(0.8,0.1,0.1,0.1)，X 分支）、`testS1QuatCastScalingWBranch`（q=(0.1,0.1,0.1,0.8)，W 分支）、`testS1QuatCastNonUnitRoundTrip`（q=(0.2,0.3,0.4,0.8)，非身份 round-trip），每个 `@Test` 函数体内多个 `@Expect` 断言在 S1 bug 影响下均不成立（如 `testS1QuatCastScalingXBranch` 中 `@Expect(q1.y, 0.1)` 在 bug 下实际值约为 0.2）。归因核实手段：① 运行 `cjpm test --verbose` 确认 FAILED 用例名集中在 `testS1Quat*` 前缀；② 归因一致时 S1 修复后预期 3 FAILED → PASS。"

- **问题描述**：§S2 证据段（行 60）描述"全部 425 个测试用例均来自 `src/detail/*_test.cj`（阶段一/二残留的 13 个测试文件）"，而修复优先级建议表后的特别说明（行 726）描述"`src/detail/*_test.cj` 14 个文件共 425 个测试用例仍正常执行"。两处"13 个"与"14 个"不一致，且未明确两个数字的语义区分，可能误导执行者对 cjpm 测试基础设施的统计认知。
- **所在位置**：a_v8_diag_v1.md §S2 行 60 vs 行 726
- **严重程度**：一般
- **改进建议**：明确"13 个"与"14 个"的语义：13 个指阶段一/二遗留测试文件（13 个 `_test.cj`，合计 422 个 `@Test`），14 个指上述 13 个 + 阶段三 S1 独立修复验证文件 `type_quat_cast_s1_test.cj`（含 3 个 `@Test`），合计 425 个。建议在 §S2 证据段明确表述"src/detail/ 下 14 个测试文件（含 13 个阶段一/二残留 + 1 个阶段三 S1 独立修复验证文件 `type_quat_cast_s1_test.cj`），共 425 个 `@Test`"。

- **问题描述**：§S2 归因段"待执行者核实手段"②指出"单文件 `cjc` 编译 `test_type_quat_cast.cj`"——但该文件位于 `tests/` 目录下、不在 `src/detail/`，且其包声明为 `glm.detail`；此外此文件名与归因分析的 `src/detail/type_quat_cast_test.cj`（即问题 1 中不存在的文件）不一致，执行者按此命令执行时会找不到文件。
- **所在位置**：a_v8_diag_v1.md §S2 行 69「待执行者核实手段」②
- **严重程度**：轻微
- **改进建议**：将核实手段②改为"单文件 `cjc` 编译 `cjglm/src/detail/type_quat_cast_s1_test.cj`（含必要的 `import glm.unittest.*` 与 `glm.unittest.testmacro.*`）后独立运行，确认 3 个 `@Test` 函数因 S1 bug 全部 FAIL"。

- **问题描述**：§S1 分析段描述"以 `Quat(0.2, 0.3, 0.4, 0.8)` round-trip 验证：返回约 (0.38, 0.57, 0.76, 0.84)，约为原 q 的 1.9 倍"。实际推导：v ≈ 1.6852；x ≈ 0.3798；y ≈ 0.5697；z ≈ 0.7596；w ≈ 0.8426。非 w 分量实测比例约 1.899（非精确 2.0），w 分量实测比例约 1.053，呈现浮点累积误差所致的不对称性，报告未明确标注"约"的精确度。
- **所在位置**：a_v8_diag_v1.md §S1 行 38
- **严重程度**：轻微
- **改进建议**：在 §S1 行 38 末尾追加："具体数值校核：`v = sqrt(2.84) ≈ 1.6852`（缺 *0.5 因子）；x/y/z 各分量约为 0.3798/0.5697/0.7596（实测比例 1.899）；w = 0.8426（实测比例 1.053）。浮点累积误差致非 w 分量实测比例非精确 2.0，但数学上确为 2.0 倍——`0.64/(sqrt(2.84))` 与正确路径 `0.64*0.5/sqrt(2.84)` 的比值精确为 2.0。"

- **问题描述**：§G1.3 修复方向推荐段论据 ② 描述"GLM `quatCast` 内部同样依赖 `T > T` 比较"，但未限定 GLM `quatCast` 的具体行号范围（GLM `references/glm-1.0.3/glm/glm/gtc/quaternion.inl` 的 `>` 比较位于第 95-104 行），执行者查阅 GLM 源码时需自行定位。
- **所在位置**：a_v8_diag_v1.md §G1.3 行 190 论据 ②
- **严重程度**：轻微
- **改进建议**：在论据 ② 追加具体行号引用："GLM `references/glm-1.0.3/glm/glm/gtc/quaternion.inl:95-104` 使用 3 个 `if (fourX/Y/ZSSquaredMinus1 > fourBiggest...)` 串行比较"。