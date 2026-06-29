# 诊断质询报告（v1）

## 质询结果

LOCATED

## 逐维度审查

### 1. 证据充分性

**[通过]** S1 quatCast 因子 2 bug：核心证据充分。经核查 `type_quat_cast.cj:83-107` 各分支 `v = sqrtT(four?SquaredMinus1 + one)` 直接使用，缺少 GLM 参考实现 `references/glm-1.0.3/glm/glm/gtc/quaternion.inl:106-107` 的 `* static_cast<T>(0.5)` 步骤。GLM 算法 `biggestVal = sqrt(...)*0.5; mult = 0.25/biggestVal` 与 Cangjie `v = sqrtT(...); matrix_element/v` 的对比清晰呈现因子 2 差异。

**[通过]** S2 cjpm test 发现规则：`cjpm.toml:8` 配置 `[test] src-dir = "tests"` 已确认。`src/detail/*_test.cj` 命名符合 cjpm 默认发现规则（glob 结果 14 个文件），`tests/glm/**/test_*.cj` 使用 `test_*.cj` 前缀命名不在 cjpm 默认规则内，与 cjpm 1.1.0 文档示例（`lib_test.cj — 测试文件（_test.cj 后缀）`）一致。S2 修复方案风险评估表覆盖 git 历史、依赖、CI 配置、IDE 缓存四个维度。

**[通过]** S3 round-trip 测试分析：`test_type_quat_cast.cj` 代码确认 8 个 @Test 的分布（2 纯直接 + 5 纯 round-trip + 1 混合型），与报告分析一致。mat3Cast 不归一化的代码位置 `type_quat_cast.cj:5-25` 已显式引用。

**[通过]** S4 ULP stub 覆盖率：`vector_relational.cj:199-251` 确认 16 个 `public func` 声明（equal/notEqual × Vec1-4 × Int64/VecN<Int64,Q>），`test_vector_relational.cj:174-178` 仅 1 个 ULP stub 测试（testEqualULPStub）覆盖 1/16。

**[通过]** G1.1~G1.5、G2.1、G2.3、G3.1、G3.5、G3.7~G3.9、G4.1~G4.3 等子项的代码引用均经核查与报告描述一致（type_quat.cj:20, 61-63, 73, 142-144, 149-151；quaternion_common.cj:16-17, 34-35, 40；gtc/quaternion.cj:1-4；fwd.cj.bak:331/334/337；lib.cj:10-16；scalar_constants.cj:5-35）。

**[问题-轻微]** §S1 数学描述"v = sqrtT(fourBiggestSquaredMinus1 + one); // = 2*|biggest|（缺少 *0.5）"在单位四元数假设下成立，但对于 `test_type_quat_cast.cj` 实际使用的非单位四元数 `Quat(0.2, 0.3, 0.4, 0.8)`（norm² = 0.93），v = sqrt(4 - 4*(x²+y²+z²)) ≈ 1.685 ≠ 2*|w| = 1.6，实际缩放因子为 ~1.9（报告数值"约为原 q 的 1.9 倍"正确）。表述不精确但不影响 bug 定性结论。

**[问题-轻微]** §S2 仍称"src/detail/*_test.cj（阶段一/二残留的 13 个测试文件）"，glob 实际匹配 14 个 `_test.cj` 后缀文件（含 `type_quat_cast_s1_test.cj`）。该数值小误差 v6 challenge 已指出，v7 未修正，但不影响 S2 主结论（测试发现规则与命名约定不匹配导致 tests/ 下全部 @Test 静默跳过）。

**[问题-轻微]** §S3 round-trip 用例枚举"5 个纯 round-trip（testQuatCastMat3RoundTrip、testQuatCastMat4RoundTrip、testQuatCastNonIdentityMat3RoundTrip、testQuatCastNonIdentityMat4RoundTrip）"括号内仅列 4 个测试名，遗漏 `testMat3CastNonIdentityQuat`。总数 5 正确，列举不完整。

### 2. 逻辑完整性

**[通过]** S2 → S1 修复验证 → 测试类问题修复 的依赖链完整：S2（测试文件未发现）阻塞所有 `cjpm test` 验证 → 替代验证方案（手动 cjc 编译、临时单文件命名、GLM 参考对比、type_quat_cast_s1_test.cj 独立验证）逻辑自洽。

**[通过]** S3 身份 vs 非身份 round-trip 捕获能力区分逻辑完整：身份四元数非最大分量为 0，0/v = 0 自抵消；非身份四元数分量经 mat3Cast 重建后矩阵元素偏离原矩阵，round-trip 断言 FAIL。推导结论"非身份 round-trip 可捕获、身份 round-trip 存在捕获盲区"逻辑自洽。

**[通过]** G2.2 修复方向的下游影响评估逻辑完整：约束收紧至 `FloatingPoint<T>` 将触发整数 T 实例化的级联编译失败 → 需先扫描整数调用点或通过编译期错误自动识别。替代方案（match 类型分派 / 重载优先级机制）逻辑上可避免手动扫描。

**[通过]** G5.6 分类调整逻辑完整：slerp 4 参数 stub 的实现行为符合 stub 状态设计意图（`throw Exception("stub")`），签名偏差已由 G2.1 计入「真实存在」，G5.6 仅描述测试覆盖缺失事实 → 应仅归类为「其他类型（测试覆盖不足）」。

**[通过]** G5.9 误报分类判定逻辑完整：report 内已说明 `testInverseZero` 的 `||` 宽松断言属测试方法论精度问题（实际实现确实返回 NaN），按 requirement.md 第 2 类「误报」的严格定义（实际实现正确）不应归入误报类，应归入「其他类型（测试断言精度不足）」。

**[通过]** 汇总表分类计数：真实存在 10.5 + 误报 0 + OOD 6.5 + 其他类型 25.0 = 42.0，加权计算正确。G5.6 单计 1.0 在其他类型行，符合本次修订意图。

**[通过]** type_quat_cast.cj 统一修复管线的风险评估逻辑完整：S1 + G2.3 合并提交的双重变更叠加风险（sqrt 路径变化 + 浮点精度差异）已识别，建议分两次提交（先 S1 单独修复验证、再 G2.3 重构）逻辑合理。

### 3. 覆盖完备性

**[通过]** todo.md 全部 42 项问题（S1~S4 + G1.1~G6.2）均被逐项分析，未遗漏。

**[通过]** 4 类分类框架（真实存在 / 误报 / OOD 文档问题 / 其他类型）严格对应 requirement.md 定义。

**[通过]** deviations.md 交叉验证覆盖完整：对所有涉及 deviations.md 对照的段落，均明确标注「不适用」或「需登记评估」，核实实现行为与 deviations.md 记载方向的一致性。S1（算法 bug）、S2（工具链兼容性）、S4（测试覆盖不足）、G3.5/G3.6（版本控制）等明确标注「不涉及 deviations.md」。

**[通过]** 任务描述中提出的 10 个修订问题全部已在 v7 中回应：
- P1（G5.6 分类）：✓ 汇总表仅在「其他类型」行列出 G5.6
- P2（S3 证据链）：✓ 证据段引用 `type_quat_cast.cj:5-25` mat3Cast 不归一化；优先级表 S3 理由改为「身份 round-trip 仍存在捕获盲区」
- P3（G2.2 下游影响）：✓ 修复方向段追加扫描命令与替代方案
- P4（S2 数字差异）：✓ 证据段明确说明 422 与 425 差异原因
- P5（G3.5 行号差异）：✓ 证据段追加行号漂移校正说明
- P6（G5.9 误报判定）：✓ 章节正文内显式解释「不归入误报类的判定依据」
- P7（合并提交风险）：✓ 修复管线段末尾追加「合并提交风险提示」与「分两次提交」建议
- P8（git rm 方式）：✓ G3.5 修复建议段对比三种方案并明确推荐
- P9（G6.1 优先级）：✓ 修复优先级表 G6.1 单独列为 Medium #10，从 Low 行移除
- P10（G5.1/G5.2 数字差异）：✓ G5.1 分析段追加 27/42/30/-12 口径差异说明

**[问题-轻微]** §G6.1 描述"实际仅测试 17 个用例覆盖 5 个 import 组（Quat、3 个 cast、trigonometric）"存在两处小误差：① 实际 test_lib.cj 包含 38 个 @Test，"17"具体口径未明确（若指 5 个 import 组覆盖的测试为 Quat 1 + 2 cast + 15 trigonometric = 18，与 17 接近）；② "3 个 cast"中 mat4Cast 在 test_lib.cj 中无独立测试（实际仅 mat3Cast + quatCast = 2 cast）。不影响 G6.1 主结论（lib.cj 未对 OOD §2 全部 import 逐项验证）。

## 质询要点

无。所有问题均为轻微级别，不影响诊断结论的可信度。

本轮 v7 已有效回应 v6 challenge 中的所有 10 个修订问题：G5.6 分类已严格归入「其他类型」，S3 证据链补全 mat3Cast 不归一化的代码位置与「身份捕获盲区」结论，G2.2 修复方向明确下游扫描命令与替代方案，S2/G3.5 数字与行号差异已追加校正说明，G5.9 误报判定依据显式化，type_quat_cast.cj 合并提交风险与分两次提交策略已明示，G3.5 git rm 方式对比三种方案并明确推荐，G6.1 优先级在修复表中单列为 Medium，G5.1 数字差异口径已说明。

S1~S4、G1~G6 各项的根因定位准确，证据链完整，逻辑自洽，修复者可据此采取行动。