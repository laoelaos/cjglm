# 诊断质询报告（v1）

## 质询结果

LOCATED

## 逐维度审查

### 1. 证据充分性

**[通过]** S1（quatCast 因子 2 bug）：代码比对确认真 bug，GLM 参考实现 `quaternion.inl:106` 使用 `sqrt(...) * 0.5` 而 Cangjie `type_quat_cast.cj:84-106` 仅用 `sqrtT(...)` 缺少 `*0.5` 因子，数学推导无误。

**[通过]** S2（测试文件不被发现）：`cjpm.toml:8-9` 配置确认，cjpm 文档（`_test.cj` 后缀规则）确认，项目测试文件全部使用 `test_*.cj` 前缀命名（已验证 40 个测试文件），证据链完整。

**[通过]** S3（round-trip 无法捕获 S1 bug）：`test_type_quat_cast.cj` 共 8 个 @Test，其中 6 个为 round-trip 形式（`m == m2` 比较），剩余 2 个为恒等矩阵验证。round-trip 测试无法区分数值缩放 bug 的原因分析合理。

**[问题-轻微]** S3 中"8 个测试用例中 7 个采用 round-trip 形式"表述不精确。实际为 6 个 round-trip（testQuatCastMat3RoundTrip, testQuatCastMat4RoundTrip, testMat3CastNonIdentityQuat, testMat4CastNonIdentityQuat, testQuatCastNonIdentityMat3RoundTrip, testQuatCastNonIdentityMat4RoundTrip）和 2 个非 round-trip（testMat3CastIdentityQuat, testMat4CastIdentityQuat）。"7/8"应为"6/8"。不影响核心结论（round-trip 占主导且无法捕获因子 2 缩放 bug）。

**[通过]** S4（ULP stub 覆盖严重不完整）：`vector_relational.cj:199-251` 确认 16 个 stub 声明，`test_vector_relational.cj:174-179` 确认仅 1 个测试覆盖。覆盖率 1/16 = 6.25%，诊断结论成立。

**[问题-轻微]** S4 中"8 个 stub 函数（每个含 4 个 Vec 重载 = 32 签名组合）"计数有误。实际 `vector_relational.cj:199-251` 包含 16 个 `public func` 声明（`equal`/`notEqual` × Vec1~Vec4 × `Int64`/`VecN<Int64,Q>` = 2 × 4 × 2 = 16 个签名组合），而非 8 个 stub / 32 个签名。覆盖率应为 1/16 ≈ 6.25%（报告写 1/32 = 3.125%）。不影响"严重不完整"的核心结论。

**[通过]** 各 G 项证据充分，均附有精确的代码行号引用和 OOD 文档对照。

### 2. 逻辑完整性

**[通过]** 从问题现象到根因的因果链完整。S1 推导了从代码差异到因子 2 缩放再到 round-trip 失效的链条。S2 从 cjpm 配置 → 命名约定 → 测试发现失败的链条完整。

**[通过]** S1↔S3 的依赖关系分析正确（S1 修复后 S3 核心诉求消失），优先级表中的条件性降级标注恰当。

**[通过]** 影响范围判定合理。

### 3. 覆盖完备性

**[通过]** 覆盖了 todo.md 全部 42 项（4 严重 + 38 一般），无遗漏。

**[通过]** 迭代需求（Q1-Q6）均已反映在本版中：Q1/Q5 已增加 S3 与 S1 的依赖分析和条件性降级；Q2 行号引用已修正；Q3 分类已修正；Q4 优先级表已重构为 Critical/High 单列；Q6 文档列列举已恢复为全路径名。

**[通过]** 分类框架与需求定义一致。o

## 质询要点（无——全部问题为轻微）

诊断报告的根因定位准确、证据充分、逻辑完整、覆盖全面。仅存在两处细微计数偏差（S3 的 round-trip 比例 6/8 非 7/8，S4 的 stub 签名数 16 非 32），均不影响诊断结论方向。修复者可据此采取行动。
