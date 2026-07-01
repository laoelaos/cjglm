# 诊断质询报告（v5）

## 质询结果

LOCATED

## 逐维度审查

### 1. 证据充分性

**[通过]** S1 乘法顺序反转：已验证 Cangjie `ext/matrix_transform.cj:39` 使用 `Rot * m`，GLM `ext/matrix_transform.inl:40-44` 使用 `m[0]*Rot[0][0] + m[1]*Rot[0][1] + m[2]*Rot[0][2]`（等价于 `m * Rot`），证据确凿。

**[通过]** S2 Int32 溢出：已验证 `gtc/ulp.cj:51-52` 使用 `(y.toBits() as Int32).getOrThrow()` 数值转型，GLM `gtc/ulp.inl:85-91` 使用 union 位重解释 + `abs(a.i - b.i)`，证据确凿。

**[通过]** G1 roundEven 分支反转：已验证 `detail/common.cj:176-179`，分支逻辑 `if (rInt % 2 == 0) { r - one } else { r }` 确实与 round-half-to-even 语义相反。

**[通过]** G10 slerp(k) 公式差异：已验证 Cangjie `ext/quaternion_common.cj:68-69` 使用 `sin((1-a)*ω/k)/sin(ω/k)`，GLM `ext/quaternion_common.inl:106-108` 使用 `phi = angle + k*π; sin(angle - a*phi)/sin(angle)`，数学不等价；cosTheta<0 最短路径分支在 GLM `.inl:87-91` 存在而 Cangjie 代码缺失。

**[通过]** G2 vector_relational 缺失函数：已验证 `detail/vector_relational.cj` 仅含 `lessThan`/`greaterThan`/`lessThanEqual`/`greaterThanEqual` 四个函数，无 `equal`/`notEqual`/`any`/`all`/`not_`。

**[通过]** G5 fmin/fmax 缺失 3/4 输入版本：OOD 文档 `06_ood_phase4.md:476-485` 明确列出了 `fmin(a,b,c)` 和 `fmin(a,b,c,d)` 签名，而 `vector_common.cj:59-107` 仅实现了 2 输入版本。

**[通过]** G6 iround/uround 未委托 roundT：OOD 文档 `06_ood_phase4.md:445` 指定 `Int64(stdmath_shim.roundT(x))`，而代码 `scalar_common.cj:104-114` 直接调用 `math.round(xF64)`。

**[通过]** G9 ±0 丢失负零符号：已验证 `gtc/round.cj:9-11,30-32,48-50` 零值分支使用 `(Float64(0) as T).getOrThrow()` 返回 +0，无符号保留逻辑。

**[通过]** G34 打包函数覆盖不足：已验证 `packing_test.cj` 仅覆盖 `packUnorm4x8`/`packSnorm4x8`/`packHalf1x16`/`packDouble2x32` 四组，共 86 行测试代码。

**[通过]** 其他 G13-G37 逐条证据均与对应测试文件代码一致。

**[通过]** v5 迭代中 5 个审查问题的修正均已通过代码验证。

### 2. 逻辑完整性

**[通过]** 各 issue 从问题现象到根因的因果链完整：代码差异描述 → OOD 设计对照（含设计文档引用） → 根因分类 → 修改方向，逻辑链条清晰。

**[通过]** 优先级分组合理：将 S2 与 G7 合并（同一函数 `float_distance`），G1 从"测试正确性组"移入"库行为正确性组"（修改对象为生产代码），G10 归入第一优先（slerp 公式错误影响功能正确性）。

**[通过]** 缺失函数的数量统计和列举（G5 的 16 个、G34 的 12/16 未覆盖）均有精确计数和函数清单。

**[通过]** 副作用评估合理：S1 正确区分了 ext 实现与 gtc 自有实现（`rotate_slow`/`shear_slow` 使用本地 `mat4Mul`），S2 标注了与 G7 的修复顺序依赖。

**[通过]** 修订说明（v1-v5）完整回应对应轮次的质询意见，无遗留未解决的问题。

### 3. 覆盖完备性

**[通过]** 37 个 issue（S1-S4, G1-G37）均已逐条诊断，每一条均包含真实性判断、根因分析、修改方向三要素，符合原始用户需求。

**[通过]** 按根因分类的汇总表覆盖了所有 37 个 issue，无遗漏。

**[通过]** 修改流程建议按优先级分组并包含文档标记，覆盖了全部修改类别。

**[通过]** 引用了 `docs/deviations.md`（G11/G12/G15/G16/G24）、`docs/06_ood_phase4.md`（各处）、`references/glm-1.0.3`（S1/S2/G10 等）等多源参考。

**[通过]** v5 迭代的 5 个审查问题（G1 分类、G24 定性、G7 分类一致性、G16/G34 可操作性细节、S3 副作用评估）均已闭环。

## 质询要点（CHALLENGED 时存在）

（无）
