# 诊断质询报告（v4）

## 质询结果

LOCATED

## 逐维度审查

### 1. 证据充分性

**[通过]** S1 乘法顺序反转——已验证 `ext/matrix_transform.cj:39` 为 `Rot * m`，`ext/matrix_transform.cj:63` 为 `H * m`，与 GLM 1.0.3 左乘语义不符，证据与代码一致。

**[通过]** S2 float_distance Int32 溢出——已验证 `gtc/ulp.cj:51-52` 使用 `(y.toBits() as Int32).getOrThrow()` 数值转型，当 UInt32 值 ≥ 2³¹ 时抛异常，与诊断描述一致。

**[通过]** G3 normalize `<=` vs `==`——已验证 `detail/geometric.cj:26,35,44` 使用 `lenSq <= zero`，而 OOD 文档 `06_ood_phase4.md:1104` 使用 `==` 描述，证据一致；IEEE 754 `-0.0 == +0.0` 行为判断正确。

**[通过]** G10 slerp(k) 公式差异——已验证 `ext/quaternion_common.cj:68-69` 使用 `sin((1-a)*ω/k)/sin(ω/k)`，GLM 1.0.3 `ext/quaternion_common.inl:106-108` 使用 `sin(angle - a*phi)/sin(angle)` 其中 `phi = angle + k*π`，数学不等价；GLM 两参数及四参数 slerp 均含 cosTheta<0 最短路径分支（`:51-55`、`:87-91`），Cangjie 代码均缺失。证据充分。

**[问题-轻微]** G2 诊断中引用"GLM 1.0.3 `vector_relational.hpp`"描述 `equal/notEqual/any/all/not_` 函数的来源。准确来源应为 `detail/func_vector_relational.inl`（`vector_relational.hpp` 为 ext 扩展层，包含的是 epsilon/ULP 版本的 `equal/notEqual`）。不改变诊断结论方向。

### 2. 逻辑完整性

**[通过]** G3 汇总表矛盾已修复——汇总表第 447 行新增"OOD 文档修正"类别，G3 修改方向为"修改 OOD 文档对齐代码"，与正文第 122 行（推荐修改 OOD 文档）和优先级第 489 行（修改 OOD 文档）一致。三次迭代未闭合的修复循环最终闭合。

**[通过]** S1 副作用评估修正正确——原 v3 错误声称 `rotate_slow`/`shear_slow` 委托 ext 层，v4 已修正为独立实现（使用本地 `mat4Mul`），不受 S1 修复影响。代码验证确认为独立实现。

**[通过]** G14 修改方向与证据自相矛盾已修复——修正中注明 `inversesqrt(0)` 测试已存在于 `exponential_test.cj:49-52`，修改方向仅保留 log(0)/log(-1)。

**[通过]** S2 与 G7 优先级矛盾已修复——G7 从第二优先提升至第一优先，与 S2 合并为同一修复条目。

**[问题-轻微]** 汇总表第 445 行和第 449 行两处出现重复的"实现编码错误"类别标签，第 449 行增加了"第一优先"标注。虽不影响分类正确性，但冗余的行标签在格式上有待统一。

### 3. 覆盖完备性

**[通过]** 全部 37 个 issue（S1-S4、G1-G37）均有逐条诊断，无遗漏。

**[通过]** 原始需求的三项问题均被覆盖：(1) 每个 issue 的真实性（是真实问题/有争议/非问题），(2) 根因类型（设计问题/编码错误/测试错误），(3) 修改方向（修改 OOD/修改实现代码/修改测试代码）。

**[通过]** deviations.md 在 G11、G15、G16、G24 等涉及 API 行为差异的条目中被引用于评估，符合原始需求要求。

## 质询要点

无。仅有 2 个轻微问题，不影响诊断结论可信度。
