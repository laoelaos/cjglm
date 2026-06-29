# 质量审查报告：v9 诊断报告 a_v9_diag_v1.md

## 整体评价

v9 诊断报告整体质量较高，结构完整、覆盖了 requirement.md 定义的全部 4 类分类、对关键事实（如 OOD 文档路径、`docs/02_ood_phase0.md` 不存在、sqrtT 调用位置、fwd.cj.bak 行号、`type_quat_cast_s1_test.cj` 的存在与内容）均做了准确核实。但存在若干事实错误、内部矛盾和验证证据缺失问题，需在 v10 中修正。

---

## 问题列表

### 问题 1（S1 数值验证 z 分量符号错误）

- **问题描述**：§S1 第 38 行声称 "x/y/z 各分量约为 0.3798/0.5697/0.7596"，但实际推导 z = (m.c0.y - m.c1.x) / v = (-0.52 - 0.76) / 1.6852 = **-0.7596**（带负号）。q=(0.2, 0.3, 0.4, 0.8) 经 mat3Cast 计算后 m.c0.y = txy - twz = 0.2×0.6 - 0.8×0.8 = -0.52、m.c1.x = txy + twz = 0.76，相减得 -1.28，再除以 v=1.6852 得 z ≈ -0.7596。
- **所在位置**：`a_v9_diag_v1.md:38`
- **严重程度**：中（数值偏差但不影响 round-trip 现象描述与 S1 bug 核心结论）
- **改进建议**：将 "x/y/z 各分量约为 0.3798/0.5697/0.7596" 改为 "x/y/z 各分量约为 0.3798/0.5697/**-0.7596**"。同时补充 "z 分量为负值，符号方向与原 q.z（+0.4）相反" 的说明，便于执行者精确验证。

### 问题 2（G6.1 文本与可执行矩阵表内部矛盾）

- **问题描述**：G6.1 分析段文字表述 "实际仅测试 18 个用例覆盖 5 个 import 组中的 3 个（Quat: 1 个、cast: 2 个、trigonometric: 15 个）"，但同一报告稍后提供的"可执行矩阵"表显示 5 行（trig / detail.Quat / detail.mat3Cast / detail.quatCast / detail.mat4Cast），其中 4 行标记为"是"（trig 15、Quat 1、mat3Cast 1、quatCast 1），仅 detail.mat4Cast 标记为"否"——即实际覆盖 **4 个 import 组**而非 3 个。文本的"cast: 2 个"将 mat3Cast 与 quatCast 合并为 1 个 "cast 组"导致 3 个组的算式（Quat + cast 合并 + trig = 3），而表格按 4 个独立 import 组（trig + Quat + mat3Cast + quatCast）计算为 4 个已覆盖。两处对"5 个 import 组"中"已覆盖组数"的统计不一致。
- **所在位置**：`a_v9_diag_v1.md:617` 与 `a_v9_diag_v1.md:623-628`（可执行矩阵表）
- **严重程度**：高（影响执行者识别 test_lib.cj 测试覆盖率缺口数量与未覆盖 import 组的具体清单）
- **改进建议**：
  - 选项 A：统一采用表格口径，将"3 个"改为"4 个"，并显式列出未覆盖组（仅 detail.mat4Cast）；补充说明"cast 在 lib.cj 是 1 个 public import 语句但 OOD §2 列出 3 个独立 cast 函数，故按函数粒度计算为 3 个 import 组"。
  - 选项 B：统一采用文本口径，将"3 个"扩展为"3 类"（Quat + cast 集合 + trig），但表格需添加一列"分组"列将 mat3Cast/quatCast 合并显示。

### 问题 3（cjpm test 输出数字与 3 FAILED 归因未提供实际执行证据）

- **问题描述**：§S2 证据段（行 54-69）声称 "实测 `cjpm test` 输出：`Summary: TOTAL: 425, PASSED: 422, FAILED: 3`"，但未提供实际执行命令、时间戳、输出日志或文件路径引用。同样，§S2「3 个 FAILED 用例的归因分析」段将 3 个 FAILED 归因到 `type_quat_cast_s1_test.cj` 的 3 个 `@Test` 函数（`testS1QuatCastScalingXBranch`/`testS1QuatCastScalingWBranch`/`testS1QuatCastNonUnitRoundTrip`），使用"预期"一词承认这是逻辑推断，但行文整体以事实口吻呈现，未明确标注假设前提。修复优先级表、S1 修复验证后备方案、S3 证据链等下游多处依赖此事实。若实际 cjpm 输出并非 TOTAL=425/FAILED=3，或 3 FAILED 来自其他文件，则 S2 分析链、S3 捕获能力论证、type_quat_cast.cj 修复管线均需调整。
- **所在位置**：`a_v9_diag_v1.md:54-69`（S2 证据段 + 归因分析）
- **严重程度**：高（多章节推论依赖此事实；todo.md 描述的 TOTAL 是 422，与 v9 报告的 425 存在差异说明数字易变）
- **改进建议**：
  1. 在 S2 证据段补注执行命令：`cjpm test 2>&1 | tee /tmp/cjpm_test_$(date +%Y%m%d_%H%M%S).log`，并在报告中附上输出片段或日志路径。
  2. 将"3 FAILED 用例归因"明确标注为"假设性归因（待 `cjpm test --verbose` 验证）"，避免误读为已验证结论。
  3. 补充反事实论证：若 3 FAILED 不全来自 `type_quat_cast_s1_test.cj`，S1 影响范围需要扩展分析的可能性。

### 问题 4（G1.3 GLM quatCast `if` 比较行号范围偏差）

- **问题描述**：§G1.3「修复方向推荐」论据 ② 引用 "GLM `references/glm-1.0.3/glm/glm/gtc/quaternion.inl:95-104` 使用 3 个 `if (fourX/Y/ZSSquaredMinus1 > fourBiggest...)` 串行比较"，但经实际核查 GLM 源文件：3 个 `if` 串行比较实际分布在 **行 90-104**（行 90-94 处理 X、行 95-99 处理 Y、行 100-104 处理 Z）。引用范围 `:95-104` 仅覆盖后两个 `if`，遗漏首个 `if`（行 90-94）。报告中"3 个 `if`"的陈述与"`:95-104`"的行号范围自相矛盾。
- **所在位置**：`a_v9_diag_v1.md:189`（G1.3 修复方向推荐 ② 段）
- **严重程度**：中（行号偏差可能误导执行者定位 GLM 参考实现；不影响 G1.3 主结论）
- **改进建议**：将行号引用改为 `quaternion.inl:90-104`，覆盖全部 3 个 `if` 串行比较。如需保留 `:95-104` 可改述为"3 个 `if` 中后两个（X 分支对应行 90-94，Y 分支对应 95-99，Z 分支对应 100-104）"。

### 问题 5（G3.5 fwd.cj.bak 的 git 跟踪状态未验证）

- **问题描述**：G3.5 修复建议段（行 415-419）推荐 `git rm cjglm/src/fwd.cj.bak`（不带 `--cached` 标志）以"从索引与工作区同时删除"。此命令的适用前提是文件已被 git 跟踪（在索引中存在）。报告仅引用 todo.md 的"`git status` 显示 `new file:`"，但未独立验证 fwd.cj.bak 的当前 git 跟踪状态。若文件当前处于未跟踪（untracked）状态，`git rm` 会报 "fatal: pathspec ... did not match any files" 错误，需先 `git add` 或改用普通 `rm`。
- **所在位置**：`a_v9_diag_v1.md:415-419`
- **严重程度**：中（修复命令可能直接执行失败）
- **改进建议**：在修复建议前增加前置验证步骤：
  1. `git ls-files --error-unmatch cjglm/src/fwd.cj.bak` 确认文件已被跟踪；若返回 0（已跟踪），执行 `git rm cjglm/src/fwd.cj.bak`。
  2. 若返回非 0（未跟踪），执行 `rm cjglm/src/fwd.cj.bak`。
  3. 或统一推荐 `rm cjglm/src/fwd.cj.bak` + `git add -A` 同步索引（不依赖文件当前状态）。

### 问题 6（G3.8 "17 个 unused import 编译警告" 未经实际构建验证）

- **问题描述**：§G3.8 分析段（行 472-479）声称 "`cjpm build` 输出 17 条 `unused import` 警告：15 个 trigonometric + 1 个 glm.ext.* + 1 个 glm.gtc.* = 17"。该数字在逻辑上自洽（lib.cj 第 12/14/16 行的 import 在 lib.cj 内部均未被引用），但报告未提供实际 `cjpm build` 输出作为证据。v9 修订说明未涉及此项核验。
- **所在位置**：`a_v9_diag_v1.md:472-479`
- **严重程度**：中（推论合理但未经实证；不同 cjpm 版本对 unused import 的检测粒度可能不同）
- **改进建议**：补充 `cjpm build 2>&1 | grep -c 'unused import'` 的实际执行结果，或标注"逻辑推断（基于 lib.cj:12/14/16 import 在 lib.cj 文件内无引用事实），未经 `cjpm build` 实证"。

### 问题 7（§S1 "1.899 比例" vs "2.0 倍" 比值基线易混淆）

- **问题描述**：§S1 行 38 末尾 v9 修订说明补充 "实测比例 1.899" 与 "数学上确为 2.0 倍" 两个比值，但两个比值的分母不同：1.899 = bug 结果（0.3798）/ 原始 q.x（0.2），2.0 = bug 结果（0.3798）/ 正确恢复值（0.1899）。当前修订已通过数学等式说明 2.0 比值，但未明确标注 "实测 1.899 = bug/qx_original" 的对比基线，读者可能混淆两个比值指代。
- **所在位置**：`a_v9_diag_v1.md:38`
- **严重程度**：低（v9 修订已补充数学等式，但对比基线可更明确）
- **改进建议**：将 "实测比例 1.899" 改为 "实测 bug 结果 / 原 q.x = 0.3798/0.2 ≈ 1.899（基线为原 q.x）"，并明确 "数学比值 2.0 = bug 结果 / 正确恢复值（基线为正确恢复值 0.1899）"。两个比值的分母差异是浮点累积误差的来源，标注清楚有助于执行者理解。

### 问题 8（G6.1 "5 个 import 组"指代粒度不一致）

- **问题描述**：G6.1 同时存在两种"5 个 import 组"的口径：
  - 文本口径：5 = trig + cast 合并 + ext + gtc + Quat（共 5 个组，3 个覆盖：Quat/cast合并/trig）。
  - 表格口径：5 = trig + detail.Quat + detail.mat3Cast + detail.quatCast + detail.mat4Cast（共 5 个组，4 个覆盖：trig/Quat/mat3Cast/quatCast）。
  两种口径将 cast 视为 1 个 vs 3 个 import 组，且 Quat 的归属也不同（文本未明确 Quat 是来自 lib.cj 还是 fwd.cj）。两种口径对应的"5"含义不同，但报告未明确说明采用哪种分组粒度。
- **所在位置**：`a_v9_diag_v1.md:617`（文本）与 `a_v9_diag_v1.md:619-630`（表格）
- **严重程度**：低（影响解读清晰度，不影响主结论）
- **改进建议**：在 G6.1 段首明确分组粒度，例如："本节按 OOD §2 中的 import 项计 5 个 OOD 阶段三引入的 import 组（trig、cast 整体、Quat 别名），其中 cast 在 OOD §2 中虽为单条 import 语句但实质包含 mat3Cast/mat4Cast/quatCast 3 个独立转换函数"。

---

## 总体结论

v9 报告在结构完整性、分类准确性、修复建议可操作性上达到较高水平。修复优先级表（S2 → S1 → S3 → G2.1 → G2.3 等）、type_quat_cast.cj 联合修复管线、S1 修复验证后备方案、S2 修复方案风险评估等创新性内容显著增强了报告的可执行性。

主要待修正项：
- **必须修正**：问题 1（S1 z 分量符号）、问题 2（G6.1 文本/表矛盾）、问题 3（cjpm test 输出验证证据）
- **建议修正**：问题 4（GLM 行号范围）、问题 5（fwd.cj.bak git 状态前置检查）、问题 6（cjpm build 输出实证）
- **可选优化**：问题 7（1.899 vs 2.0 比值基线）、问题 8（5 个 import 组指代粒度）

修复上述问题后，v9 报告将达到可直接驱动执行的诊断报告质量基线。
