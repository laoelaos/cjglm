# 诊断质询报告（v1）

## 质询结果

LOCATED

## 逐维度审查

### 1. 证据充分性

**[通过]** S1（quatCast 因子2缩放bug）已验证：GLM `quaternion.inl:106` 使用 `sqrt(...)*0.5` 和 `mult=0.25/biggestVal`，Cangjie `type_quat_cast.cj:84-106` 使用 `sqrtT(...)` 后直接 `matrixElement/v`，缺少 `*0.5` 和 `0.25/biggestVal` 分步，非最大分量被缩放2倍，证据链完整。

**[通过]** S2（测试文件不被发现）已验证：cjpm文档明确要求测试文件以 `_test.cj` 结尾，项目所有测试文件均使用 `test_*.cj` 前缀命名，与工具链要求不匹配。

**[通过]** G2.1（slerp spin:Bool）已验证：`quaternion_common.cj:40` 签名 `slerp(..., spin: Bool)` vs OOD §3.11/D22 要求的 `k: Int64`。

**[通过]** G2.3（sqrtT Float64中转）已验证：`quaternion_geometric.cj:5-8`、`quaternion_trigonometric.cj:5-8`、`type_quat_cast.cj:122-125` 三处均通过 Float64 中转实现 sqrt。

**[通过]** G3.1（gtc/quaternion.cj import缺失）已验证：`gtc/quaternion.cj:1-4` import 列表缺失 OOD §3.15 要求的 `glm.ext.vector_relational.*` 和 `glm.ext.scalar_constants.*`。

**[通过]** G3.6（gen_fwd_aliases.py LF/CRLF幂等性）已验证：`scripts/gen_fwd_aliases.py:71` 显式 `newline='\n'`，Windows CRLF 仓库中执行会触发全量行尾变更。

**[通过]** 其余各条目（G1.1-G1.8, G2.2, G2.4-G2.6, G3.2-G3.5, G3.7-G3.9, G4.1-G4.4, G5.1-G5.9, G6.1-G6.2）均有代码或文档引用支撑，证据充分。

**[问题-轻微]** S4（ULP stub 覆盖统计）：诊断声称"8个stub函数"和"32个签名组合"。实际 `vector_relational.cj:199-251` 定义 16 个 stub 声明（equal/notEqual × Int64/VecN × Vec1~Vec4 = 2×2×4=16），覆盖率为 1/16≈6.25%，而非声称的 1/32≈3.125%。统计计数有误，但不影响"测试覆盖严重不完整"的结论方向。

**[问题-轻微]** S3（round-trip 计数）：诊断称"8个测试用例中7个采用round-trip"。实际 `test_type_quat_cast.cj` 中 6 个测试包含 round-trip 断言（第2/4/5/6/7/8个测试），而非 7 个。计数略有偏差，但不影响"round-trip 测试无法捕获因子2 bug"的结论。

**[问题-轻微]** G3.5（fwd.cj.bak行号）：诊断称 `fwd.cj.bak:330-332` 包含 `HighpFQuat`/`MediumpFQuat`/`LowpFQuat`。实际 `HighpFQuat` 在 331 行，`MediumpFQuat` 在 334 行，`LowpFQuat` 在 337 行，`HighpDQuat` 在 332 行（未被禁止）。行号范围描述不精确，但不影响"错误别名存在于bak文件"的判断。

### 2. 逻辑完整性

**[通过]** S1 从"矩阵→四元数互转"的数值现象到"缺少 `*0.5` 因子"的根因，形成完整因果链，数值验证示例（Quat(0.2,0.3,0.4,0.8) round-trip ≈ 1.9x）佐证了因子2的异常缩放。

**[通过]** S2 从"300+ @Test静默跳过"到"文件命名与工具链规则不匹配"，逻辑连贯，未发现矛盾线索。sub-classification 合理区分了真实存在/OOD文档问题/其他类型三个子面。

**[通过]** G2.1 从"spin: Bool 签名"到"阶段四 `phi = angle + k * pi<T>()` 公式无法编译"，因果链完整——`Bool` 不实现 `Integer<Bool>` → `*` 运算符不可用 → 阶段四阻塞。

**[通过]** 所有条目的分类（真实存在/误报/OOD文档问题/其他类型）与证据一致，分类判断的逻辑框架一致。

### 3. 覆盖完备性

**[通过]** 任务要求分析 todo.md 中 48 项问题（6 严重 + 42 一般），报告逐一处理了全部 48 项，无遗漏。

**[通过]** 任务要求的四个分类维度（真实存在/误报/OOD文档问题/其他类型）均已在分析中覆盖。

**[通过]** 任务要求的交叉验证文档（deviations.md、OOD设计文档、参考项目、实现项目）均在分析中被引用作为证据来源。

**[通过]** 关键发现汇总（S1最严重功能缺陷、S2测试不可信、G2.1阶段四阻塞、G2.3一致性违反）完整概括了诊断的核心结论。

## 质询要点

无严重/一般问题。
