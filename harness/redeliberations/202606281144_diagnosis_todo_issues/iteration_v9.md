# 再审议判定报告（v9）

## 判定结果

RETRY

## 判定理由

组件B诊断报告（v2 修订版）经质询驳回并修订后，仍识别出 7 项质量问题，且组件B质询报告（v2 修订版）以 **LOCATED** 确认了这些问题的有效性。

**问题等级映射分析：**

诊断报告使用"高/中/低"三级标注，结合上下文与判定标准映射如下：

| 编号 | 问题摘要 | 原标注 | 优先级 | 映射等级 | 是否触发 RETRY |
|------|---------|--------|--------|----------|--------------|
| 1 | G6.1 文本/表内部矛盾 | 高 | 必须修正 | 一般 | 是 |
| 2 | cjpm test 输出与 3 FAILED 归因无实证 | 高 | 必须修正 | 严重 | 是 |
| 3 | GLM quatCast `if` 行号范围偏差（90-104 vs 95-104） | 中 | 建议修正 | 一般 | 是 |
| 4 | fwd.cj.bak git 跟踪状态未验证 | 中 | 建议修正 | 一般 | 是 |
| 5 | 17 个 unused import 警告未经 cjpm build 实证 | 中 | 建议修正 | 一般 | 是 |
| 6 | §S1 "1.899" vs "2.0" 比值基线歧义 | 低 | 可选优化 | 轻微 | 否 |
| 7 | G6.1 "5 个 import 组"粒度不一致 | 低 | 可选优化 | 轻微 | 否 |

**循环状态：** 实际轮次 2 < 最大轮次 12，提前终止（非循环耗尽）。质询结果 LOCATED（非 CHALLENGED），表明组件B的审查结论经质询后被确认有效。

**判定依据：** 诊断报告包含 1 项"严重"等级问题（问题 2：cjpm test 输出未提供执行证据，多处下游推论依赖此事实基线）与 4 项"一般"等级问题（问题 1、3、4、5），满足 RETRY 触发条件"审查报告包含严重或一般等级的问题"。

## 需要解决的问题

- **问题描述**：§S2 证据段（`a_v9_diag_v1.md:54-69`）声称 "实测 `cjpm test` 输出：`Summary: TOTAL: 425, PASSED: 422, FAILED: 3`"，但未提供实际执行命令、时间戳、输出日志或文件路径引用。3 个 FAILED 用例归因到 `type_quat_cast_s1_test.cj` 的 3 个 `@Test` 函数也仅为逻辑推断，未明确标注假设前提。该事实是 §S1 修复验证后备方案第 4 项、§S3 捕获能力论证、§G5.6 测试覆盖结论等下游分析的共同基线。
- **所在位置**：`a_v9_diag_v1.md:54-69`（S2 证据段 + 归因分析）
- **严重程度**：严重
- **改进建议**：(1) 在 S2 证据段补注执行命令 `cjpm test 2>&1 | tee /tmp/cjpm_test_$(date +%Y%m%d_%H%M%S).log`，并附输出片段或日志路径；(2) 将"3 FAILED 用例归因"明确标注为"假设性归因（待 `cjpm test --verbose` 验证）"；(3) 补充反事实论证：若 3 FAILED 不全来自 `type_quat_cast_s1_test.cj`，S1 影响范围需扩展分析的可能性。

- **问题描述**：G6.1 分析段文字表述 "实际仅测试 18 个用例覆盖 5 个 import 组中的 3 个（Quat: 1 个、cast: 2 个、trigonometric: 15 个）"，但同一报告的可执行矩阵表显示 6 行（trig / detail.Quat / detail.mat3Cast / detail.quatCast / detail.mat4Cast / 合并的 ext+gtc 长串），其中 4 行标记为"是"——即实际覆盖 4 个独立 import 组而非 3 个。文本将 cast 视为 1 个 import 组（部分覆盖），表格将 mat3Cast/quatCast 视为 2 个独立组（都已覆盖），导致"已覆盖组数"统计不一致。
- **所在位置**：`a_v9_diag_v1.md:617`（文本）与 `a_v9_diag_v1.md:619-630`（可执行矩阵表）
- **严重程度**：一般
- **改进建议**：推荐选项 A——统一采用表格口径，将"3 个"改为"4 个"，并显式列出未覆盖组（仅 detail.mat4Cast）；补充说明"cast 在 lib.cj 是 1 个 public import 语句但 OOD §2 列出 3 个独立 cast 函数（mat3Cast/mat4Cast/quatCast），故按函数粒度计算为 3 个 import 组，其中 2 个被覆盖、1 个（mat4Cast）未被覆盖"。选项 A/B 均需说明表格第 6 行（合并 ext+gtc 长串）的归类处理。

- **问题描述**：§G1.3「修复方向推荐」论据 ② 引用 GLM `references/glm-1.0.3/glm/glm/gtc/quaternion.inl:95-104` 包含 3 个 `if` 串行比较，但经实际核查该范围仅覆盖后两个 `if`（行 95-99 Y 分支、行 100-104 Z 分支），遗漏首个 `if`（行 90-94 X 分支）。报告中"3 个 `if`"的陈述与"`:95-104`"的行号范围自相矛盾。
- **所在位置**：`a_v9_diag_v1.md:189`（G1.3 修复方向推荐 ② 段）
- **严重程度**：一般
- **改进建议**：将行号引用改为 `quaternion.inl:90-104`，覆盖全部 3 个 `if` 串行比较。

- **问题描述**：G3.5 修复建议段（行 415-419）推荐 `git rm cjglm/src/fwd.cj.bak`（不带 `--cached` 标志）以从索引与工作区同时删除。此命令的适用前提是文件已被 git 跟踪，但报告仅引用 todo.md 的"`git status` 显示 `new file:`"，未独立验证 fwd.cj.bak 的当前 git 跟踪状态。若文件处于未跟踪状态，`git rm` 将报 "fatal: pathspec ... did not match any files" 错误。
- **所在位置**：`a_v9_diag_v1.md:415-419`
- **严重程度**：一般
- **改进建议**：在修复建议前增加前置验证步骤：(1) `git ls-files --error-unmatch cjglm/src/fwd.cj.bak` 确认文件已被跟踪；若返回 0 则执行 `git rm cjglm/src/fwd.cj.bak`；(2) 若返回非 0 则执行 `rm cjglm/src/fwd.cj.bak`；(3) 或统一推荐 `rm cjglm/src/fwd.cj.bak` + `git add -A` 同步索引（不依赖文件当前状态）。

- **问题描述**：§G3.8 分析段（行 472-479）声称 "`cjpm build` 输出 17 条 `unused import` 警告"，该数字逻辑上自洽但报告未提供实际 `cjpm build` 输出作为证据。
- **所在位置**：`a_v9_diag_v1.md:472-479`
- **严重程度**：一般
- **改进建议**：补充 `cjpm build 2>&1 | grep -c 'unused import'` 的实际执行结果，或标注"逻辑推断（基于 lib.cj:12/14/16 import 在 lib.cj 文件内无引用事实），未经 `cjpm build` 实证"。