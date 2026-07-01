# 质量审查报告：a_v2_diag_v1.md

审查时间：第 2 轮迭代

审查范围：以需求响应充分度、完整性、可操作性为主，避免重复验证内部审议已确认的技术可行性维度。

---

## 发现的问题

### 问题 1：S1 副作用评估中存在事实错误——rotate_slow/shear_slow 并非委托 ext

- **问题描述**：S1 的副作用评估（第31行）声称"gtc 层 `rotate_slow`/`shear_slow` 委托 ext 的 rotate/shear，修复自动传递"。经查代码：`cjglm/src/gtc/matrix_transform.cj:43-62` 的 `rotate_slow` 构建独立旋转矩阵后调用 `mat4Mul(Rot, m)`；`:77-88` 的 `shear_slow` 构建独立剪切矩阵后调用 `mat4Mul(H, m)`。两者均为独立实现，完全不依赖 ext.rotate/ext.shear。因此**修复 ext.rotate/ext.shear 不会自动传递到 gtc.rotate_slow/gtc.shear_slow**。
  - gtc 层通过 `public import glm.ext.*` 暴露的 `gtc.rotate` 和 `gtc.shear` 确实会因 ext 修复而自动受益，但 `rotate_slow` 和 `shear_slow` 并非同函数。
- **所在位置**：a_v2_diag_v1.md 第 31 行
- **严重程度**：严重
- **改进建议**：将副作用评估中关于 gtc 转发的描述修正为：gtc 层通过 `public import glm.ext.*` 暴露的 `gtc.rotate` 和 `gtc.shear` 会因 ext 修复自动受益；但 `gtc.rotate_slow` 和 `gtc.shear_slow` 有独立实现，不受影响，其内联的乘法顺序也需单独审查是否需要修正。

---

### 问题 2：G14 修改方向与证据自相矛盾

- **问题描述**：第 277 行要求"补充 `inversesqrt(0)` 期望值为无穷的断言"，但第 276 行的证据已确认该测试存在（`cjglm/tests/glm/detail/exponential_test.cj:49-52` 的 `testInversesqrtZero` 中已有 `@Expect(isInf(r), true)`）。修改方向与证据不一致，执行者会困惑：到底该加还是不加？
- **所在位置**：a_v2_diag_v1.md 第 276-277 行
- **严重程度**：中等
- **改进建议**：删除修改方向中的 `inversesqrt(0)` 项，仅保留 log(0)/log(-1) 边界测试补充。

---

### 问题 3：G31 诊断信息严重不足，无法操作

- **问题描述**：G31 仅有一句话"补充 gtc 入口函数的委托路径测试"（第390行），无任何证据引用、无具体函数列表、无测试文件路径。经查 `cjglm/src/gtc/matrix_transform.cj`，该文件仅定义 5 个公共函数（identity/shear/rotate_slow/scale_slow/shear_slow），其余函数（translate/rotate/scale/lookAt/ortho/frustum/perspective 等）通过 `public import glm.ext.*` 直接重导出。当前 gtc 测试仅覆盖了 translate 和 ortho 两个 ext 重导出函数的入口测试（`testTranslateViaExt`、`testOrthoViaExt`）。
  - "50+ 函数" 的提法无依据——gtc/matrix_transform.cj 中重导出的 ext 函数约 10-15 个。
  - 未区分"gtc独立实现"（如 rotate_slow、shear）与"gtc重导出 ext"（如 rotate、translate）两种不同的测试需求。
- **所在位置**：a_v2_diag_v1.md 第 387-391 行
- **严重程度**：中等
- **改进建议**：补充以下证据和细节：(1) 列出 gtc 重导出 ext 的具体函数清单（可从 `public import glm.ext.*` 和 gtc 仅有的 5 个自定义函数反推）；(2) 区分两类测试：gtc 自有实现（identity/shear/rotate_slow/scale_slow/shear_slow）的独立路径测试，和 ext 重导出函数（translate/rotate/scale/lookAt/ortho/frustum/perspective 等）的 gtc 入口测试。

---

### 问题 4：S2 与 G7 优先级矛盾——应同优先级却跨级

- **问题描述**：S2（float_distance Int32 溢出，第一优先）和 G7（float_distance NaN/Inf 前置检查，第二优先）位于同一函数 `gtc/ulp.cj:51-57`。诊断本身在第 182 行明确要求"应与 S2 同时修复"、第 459 行再次强调"与 G7 应同时修复"，但优先级分组将 S2 放在"第一优先"、G7 放在"第二优先"。执行者会困惑：究竟是否应同时提交？
- **所在位置**：a_v2_diag_v1.md 第 459 行 vs 第 474 行
- **严重程度**：中等
- **改进建议**：将 G7 提升至第一优先，与 S2 合并为同一工作单元，在 commit 说明中注明两者同时修复。

---

### 问题 5：G10 分类为"待验证"过于保守，证据已充足

- **问题描述**：G10 分类为"待验证"，但已提供的证据（第225-229行）充分证明 Cangjie 代码 `sin((1-a)*ω/k)/sin(ω/k)` 与 GLM 1.0.3 的 `sin(angle - a*(angle + k*π))/sin(angle)` 在数学上不等价。GLM 源码已确认（`references/glm-1.0.3/glm/glm/ext/quaternion_common.inl:105-108`），两公式从代数结构上完全不同，不存在巧合等价的可能性。此外，Cangjie 的 4 参数 slerp 还缺少 GLM 中已有的 `cosTheta < 0` 取反分支——此问题诊断也未提及。
- **所在位置**：a_v2_diag_v1.md 第 222 行（分类）、第 229 行（建议修正公式）
- **严重程度**：轻微
- **改进建议**：将真实性改为"真实问题（公式错误 + 缺少 cosTheta<0 分支）"，直接归入第一优先。验证只需确认公式不等价即可，当前证据已满足。

---

### 问题 6：G3 中关于 `dot(v,v)` 生成 -0.0 的论证不成立

- **问题描述**：第 120 行称"两个极小负数的乘积"可产生 `-0.0`。IEEE 754 中负 × 负 = 正，且平方和各项均为非负，`dot(v,v)` 不可能产生 `-0.0`。该论据本身不成立。
- **所在位置**：a_v2_diag_v1.md 第 120 行
- **严重程度**：轻微
- **改进建议**：删除此论据，改用更严谨的理由：`<=` 对可能因类型转换或精度降级引入的极小负值提供额外保守保护；或直接采用简短论证"两者的行为差异在实际输入中无区别，推荐 OOD 文档对齐代码以消除设计文档与实现的偏差"。

---

## 总体评价

v2 修订版相比 v1 有显著改进：补齐了逐条诊断、引入了 deviations.md 对照、补充了副作用评估框架。整体对用户需求（真实性判断、根因分类、修改方向）的响应充分。

但存在一个严重事实错误（S1 副作用评估中 gtc 转发关系判断失误）和一个中等程度未决问题（G31 可操作性不足）。此外 S2/G7 优先级对立、G10 过度分类保守等也需修正。

**修正建议汇总**：修正 S1 副作用评估中 gtc 转发描述（事实错误）、删除 G14 修改方向中的矛盾项（自相矛盾）、补充 G31 的函数清单和文件路径（可操作性不足）、将 G7 提升至第一优先与 S2 合并（优先级矛盾）、G10 直接确认为真实问题（过度保守）。建议执行上述修正后交付。

---

## 修订说明（v2）

| 质询意见 | 回应 |
|---------|------|
| **Q1（严重）：覆盖完备性不足——未验证副作用评估质量** | 已补充。验证中发现 S1 的副作用评估中关于 gtc rotate_slow/shear_slow 委托 ext 的表述为**事实错误**（gtc 实现独立，不受 ext 修复影响），详见本报告问题 1。已将此前遗漏的此问题纳入审查报告。S2/G5/G8 的副作用评估经核实无明显问题。 |
| **Q1（续）：未评估优先级排序合理性** | 已补充。发现 S2（第一优先）与 G7（第二优先）的优先级对立——诊断自身要求"应同时修复"但将两者分入不同优先级组，详见本报告问题 4。第一优先组的内部二级分组合理，G13-G37 的分批方案合理。 |
| **Q1（续）：v1 历史问题未系统跟踪** | 已逐一验证：v1 第1条(G10分类矛盾)→v2已修正；第2条(G14-G37缺乏逐条诊断)→v2已修正；第3条(未引用deviations.md)→v2已修正；第4条(G3方向模糊)→v2已修正；第5条(G2责任区分)→v2已修正；第6条(S1/S2缺少测试影响)→v2已加入副作用分析框架；第7条(G12未完成)→v2已修正；第8条(缺少副作用评估)→v2已加入但 S1 评估中存在事实错误（本报告问题1）；第9条(优先级未论证)→v2已改进但 S2/G7 仍存在优先级矛盾（本报告问题4）。 |
| **Q2（轻微）：Q4 路径格式不统一属于不必要细节** | 已接受。Q4 已从本版审查报告中移除。 |