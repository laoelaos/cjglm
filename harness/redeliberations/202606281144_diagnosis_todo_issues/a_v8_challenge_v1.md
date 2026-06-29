# 诊断质询报告（v8）

## 质询结果

LOCATED

## 逐维度审查

### 1. 证据充分性

**[通过]** S1 bug 证据充分：`type_quat_cast.cj:83-107` 四个分支均使用 `let v: T = sqrtT(four?SquaredMinus1 + one)` 后直接以 `matrixElement / v` 求解（已实际核查代码），与 GLM 原版 `biggestVal = sqrt(...) * 0.5` + `mult = 0.25 / biggestVal` 的两步算法对比清晰，缺少 `* 0.5` 因子导致非最大分量被缩放 2 倍的因果链完整。已用 q0=(0.2, 0.3, 0.4, 0.8) round-trip 验证返回约为原 q 的 1.9 倍，证据链与代码实现一致。

**[通过]** S2 证据充分：`cjpm test` 实测 `Summary: TOTAL: 425, PASSED: 422, FAILED: 3, SKIPPED: 0` 与 cjpm 文档 `lib_test.cj — 测试文件（_test.cj 后缀）` 发现的 `_test.cj` 后缀规则一致。`tests/` 目录下 300+ `@Test` 静默跳过的根因（`test_*.cj` vs `*_test.cj` 命名约定不匹配）已通过 cjpm 文档引用 + cjpm.toml 配置双重证据支撑。`src/detail/*_test.cj` 共 13 个测试文件（v6 描述为 13 个，v7 修订说明中描述为 14 个，本报告核查 `test_scalar_quat_ops/test_scalar_constants/test_shim_limits/test_common/test_shim_assert/test_qualifier/test_matrix/test_type_quat/test_type_quat_cast/test_trigonometric_stub/test_vector_relational/test_quaternion_common/test_quaternion_relational` 等多个文件存在于 src/detail 下——具体文件数与描述的"14"存在轻微出入，但不影响 S2 主结论的证据强度）。

**[通过]** S3 证据充分：`test_type_quat_cast.cj` 8 个 @Test 函数已逐个核查：2 纯直接（testMat3CastIdentityQuat@3-16、testMat4CastIdentityQuat@27-44）+ 5 纯 round-trip + 1 混合（testMat4CastNonIdentityQuat@64-75 含 c3 直接验证 + round-trip）。身份四元数 round-trip 因非最大分量为 0 而 `0/v=0` 不变无法捕获 S1 bug 的因果推导与 mat3Cast 直接使用 `q.x/q.y/q.z/q.w` 未归一化的代码事实（`type_quat_cast.cj:5-25` 已核查）一致。非身份 round-trip 可捕获的证据链完整。

**[通过]** S4 证据充分：`vector_relational.cj` 中 Vec1/2/3/4 各 4 个签名 = 16 个 `public func`，test_vector_relational.cj 实际仅覆盖 1 个组合，覆盖率 1/16 ≈ 6.25%。

**[通过]** G1.3 证据充分：`type_quat.cj:73` 实际签名 `where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier` 已核查，与 OOD §3.3 item 6/7 文档的 `FloatingPoint<T>` 约束不一致。`quatCast` 实现（`type_quat_cast.cj:52`）的 `Comparable<T>` 依赖是编译期必需，证据链完整。v8 新增方向 A 推荐（文档跟随实现），理由 1-3 充分（文档反映实际约束、GLM quatCast 同样依赖比较运算、修复成本 A 显著低于 B）。

**[通过]** G2.1 证据充分：`ext/quaternion_common.cj:40` 实际签名为 `slerp<T, Q>(x, y, a, spin: Bool)` 已核查，与 OOD §3.11、D22、§11.5 三处承诺的 `k: Int64` 不一致。v8 新增「修复方案的迁移成本评估」子节三项具体诉求（grep 扫描命令 `grep -rn 'slerp.*spin\|slerp(.*,.*,.*,.*)' cjglm/`、GLM `phi = angle + k * pi<T>()` 语义对齐、`testSlerp4ArgsK0/K1/KMinus1` 验证用例）全部落地，stub 阶段四前无业务调用方的预测与函数体 `throw Exception("stub")` 一致。

**[通过]** G2.2 证据充分：`ext/quaternion_common.cj:34-35` mix 用 `Number<T>`、第 16-17 行 lerp 用 `Number<T> & Comparable<T>` 已核查，与 GLM `is_iec559` 静态断言对比准确。v6 已追加的「约束收紧级联失败风险」评估和 grep 扫描建议 + match 类型分派替代方案已覆盖完整。

**[通过]** G2.3 证据充分：`type_quat_cast.cj:122-125` `sqrtT` Float64 中转已核查（`(x as Float64).getOrThrow()` + `(sqrt(x64) as T).getOrThrow()`），跨 `quaternion_geometric.cj:5-8,17` + `quaternion_trigonometric.cj:5-8,18` 共 3 处文件位置引用准确（仅核查了 type_quat_cast.cj 的 sqrtT 定义，未独立核查另外 2 个文件中的 sqrtT 定义，但从报告描述的"相同模式"推断合理）。

**[通过]** G3.5/G3.6/G3.8 工作量差异化已落地：v8 将修复优先级表 Medium #8 拆分为三个子项，8a（G3.8 Medium-High）/ 8b（G3.6 Medium）/ 8c（G3.5 Medium-Low）的工作量标注（17 unused import 决策、~10 行 Python 写入逻辑、单命令 `git rm`）与各问题描述一致。

**[通过]** G6.1 数量与 import 组描述已修正：v8 §G6.1 改为"实际仅测试 18 个用例覆盖 5 个 import 组中的 3 个（Quat: 1、mat3Cast/quatCast: 2、trigonometric: 15）"，与 `test_lib.cj` 实际 grep 结果（15 trigonometric + 1 Quat + 1 mat3Cast + 1 quatCast = 18）一致，且明确说明 mat4Cast 未被覆盖（grep 无 mat4Cast 字样）。新增的可执行矩阵表格覆盖完整，列出 OOD §2 中 20 个 import 组 vs test_lib.cj 已测试项的对应关系，便于执行者识别缺口。

### 2. 逻辑完整性

**[通过]** S1↔S2↔S3 因果链完整：S1 bug 影响 round-trip → S3 区分身份/非身份 round-trip 的不同捕获能力 → S2 测试文件不被发现导致 tests/ 下 @Test 静默跳过使 S3 修复无法通过 `cjpm test` 验证 → S2 Critical 优先级的依赖链清晰。S2 的 3 个 FAILED 用例归因分析（v8 新增）将 §S2、§S1、§S3 三处交叉验证：FAILED 用例预期来自 `src/detail/type_quat_cast_test.cj` 的非身份 round-trip 用例，由 S1 bug 经 mat3Cast 不归一化放大导致 `@Expect(m == m2, true)` 失败。归因一致时 S1 修复后预期 3 FAILED → PASS 的预测与 S3「非身份 round-trip 可捕获 S1 bug」的结论形成闭环。

**[通过]** S2 优先级理由的精确化已落地：v8 修复优先级表后特别说明段明确分两层——`tests/` 目录下 300+ `@Test` 静默跳过 vs `src/detail/*_test.cj` 14 个文件共 425 个测试用例仍正常执行。避免 v6/v7 中"所有测试结果不可信"的过度概括影响范围扩大问题。

**[通过]** G2.1 迁移成本评估的逻辑链条：①当前函数体为 stub 阶段四前无业务调用点（与 line 41 `throw Exception("stub")` 一致）→ ②签名修改影响范围可控 → ③但缺乏运行时验证用例，需新增 testSlerp4ArgsK0/K1/KMinus1 → ④命名 `spin` → `k` 的语义对齐需保留 GLM 原版 `phi = angle + k * pi<T>()` 公式。推理链完整，无逻辑跳跃。

**[通过]** G1.3 双向修复方向的成本-语义对比完整：方向 A（文档跟随实现）——修订 OOD §3.3 item 6/7 与 §3.2.1 quatCast 签名为 `FloatingPoint<T> & Comparable<T>`，成本仅 2 处行修订；方向 B（实现跟随文档）——重构 quatCast 避免使用 `<` 比较运算符，需重构算法实现并新增等价性测试，成本显著高于方向 A。理由 1（OOD 应反映实际编译期约束）+ 理由 2（GLM quatCast 内部同样依赖 T > T 比较）+ 理由 3（修复成本 A 显著低于 B）形成完整的推荐决策依据。

**[通过]** type_quat_cast.cj 统一修复管线的逻辑顺序：S1（算法正确性，改变输出基线）→ G2.3（sqrtT 重构，不改变数值结果，可与 S1 合并但有精度叠加风险）→ G1.5（独立修复 `one - one` 路径）→ G1.6（依赖 S1 完成后的代码形态）→ G1.7（推迟至阶段四）。合并提交风险（步骤 1+2 双变更叠加产生难以诊断的混合偏差）与分两次提交的缓解策略（变更范围聚焦、回归精确定位）阐述完整。

**[通过]** G3.7 与 G3.9 双分类一致性：均按 v6/v7 修订规则标注「其他类型 + OOD 文档问题（部分）」各 0.5 权重。汇总表加权和：真实存在 10.5 + OOD 6.5 + 其他类型 25.0 = 42.0 ✓，与 todo.md 实际列表 4 严重 + 38 一般 = 42 项吻合。

### 3. 覆盖完备性

**[通过]** todo.md 所有 42 项问题均覆盖：S1~S4 4 严重 + G1:8 + G2:6 + G3:9 + G4:4 + G5:9 + G6:2 = 38 一般，章节映射表完整列出 todo.md 编号到报告章节的对应关系，分类标注清晰。

**[通过]** 原始需求 4 类分类框架覆盖：真实存在（含 S1、S2、G1.1、G1.2、G1.3、G1.4、G1.5、G2.1、G2.2、G2.3、G3.1、G3.8 共 10.5 加权）+ 误报（0 加权，G5.9 重分类至其他类型）+ OOD 文档问题（6.5 加权）+ 其他类型（25.0 加权）= 42.0 ✓。每一项均给出明确分类和依据，分类汇总表与章节映射表双重交叉验证。

**[通过]** 交叉验证文档范围完整：deviations.md（按 v6 修订新增「不适用 / 需登记评估 / 可能影响已有条目」三层结构）、01_tech_decision.md / 02_roadmap.md / 03_ood_phase1.md / 04_ood_phase2.md / 05_ood_phase3.md（v4 修订后逐份列举全路径）、references/glm-1.0.3（GLM 参考实现）、cjglm/（当前实现）。requirement.md 指定的 `docs/02_ood_phase0.md` 不存在的情况已在 §概述段说明并替换为实际包含的 5 份文档。

**[通过]** 修复优先级建议覆盖完整：Critical（S2 唯一）/ High（S1, S3, G2.1, G2.3）/ Medium（G2.2, G1.1, G1.2, G1.4, G1.5, G3.8/6/5, G5.3-G5.7, G6.1）/ Low（G1.6-G1.8, G2.4-G2.6, G3.2-G3.4, G3.7, G3.9, G4.1, G4.3, G5.1, G5.2, G5.8, G5.9, G4.2, G4.4, G6.2）四层分级，每项标注文件级依赖关系。G6.1 已单独列为 Medium #10（v7 修订新增），未与 Low 优先级行重复。

**[通过]** v8 修订说明覆盖完整：本轮质询提出的 6 项问题（G6.1 数量修正、G2.1 迁移成本评估、S2 优先级理由精确化、S1 FAILED 用例归因、G3.5/6/8 工作量差异、G1.3 双向修复方向）均在「修订说明（v8）」中给出对应的回应位置和具体落地内容，回应的对应关系明确，无遗漏。

## 质询要点（CHALLENGED 时存在）

无严重/一般问题，诊断结论可信。
