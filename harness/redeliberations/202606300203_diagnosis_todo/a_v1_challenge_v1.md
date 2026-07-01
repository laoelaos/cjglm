# 诊断质询报告（v1）

## 质询结果

LOCATED

## 逐维度审查

### 1. 证据充分性

**[通过]** S1: 验证 `ext/matrix_transform.cj:39,63`，代码确认为 `Rot * m` 和 `H * m`（右乘），与诊断一致。

**[通过]** S2: 验证 `gtc/ulp.cj:51-52`，代码确认为 `(y.toBits() as Int32).getOrThrow()`，数值转型而非位重解释，与诊断一致。

**[通过]** G1: 验证 `detail/common.cj:176-179`，分支逻辑为偶数→`r-one`、奇数→`r`，与诊断一致。

**[通过]** G2: 验证 `detail/vector_relational.cj` 全文 71 行，确认仅有 4 个比较函数，无 `equal`/`notEqual`/`any`/`all`/`not`，与诊断一致。

**[通过]** G3: 验证 `detail/geometric.cj:26,35,44`，代码确认为 `lenSq <= zero`；OOD 文档 §5 错误表第 1104 行确认为 `lengthSq == T(0)`，与诊断一致。

**[通过]** G4: 验证 `detail/matrix.cj:167,171,177`，`determinant` 约束确为 `Number<T>`；OOD 文档 D05 明确记录此决策。

**[通过]** G5: 验证 `ext/vector_common.cj:59-107`，fmin/fmax 仅含 2 输入版本（标量扩展 + 同维向量），缺失所有 3/4 输入版本；OOD 文档 §3.2 第 476-479 行明确列出 4 组重载。

**[通过]** G6: 验证 `ext/scalar_common.cj:104-114`，`iround`/`uround` 直接调用 `math.round(xF64)`，未委托 `stdmath_shim.roundT`，与诊断一致。

**[通过]** G7: 验证 `gtc/ulp.cj:51-57`，`float_distance` 无 NaN/Inf 前置检查；同文件 `next_float`/`prev_float`/`ulp` 均有此类检查，与诊断一致。

**[通过]** G8: 验证 `gtc/type_precision.cj:86` 的 `dquat` 别名及其注释；验证 `ext/quaternion_double.cj:3` 的同名 `dquat` 别名，命名冲突存在且 OOD 已知。

**[通过]** G9: 验证 `gtc/round.cj:9-11,30-31,48-49`，三个函数的零值分支均返回 `(Float64(0) as T).getOrThrow()`（+0），丢失负零符号；OOD 文档边界行为表要求保留符号，与诊断一致。

**[通过]** G10: 验证 `ext/quaternion_common.cj:68-69`，代码确认为 `sinT((one - a) * omega / k) / sinT(omega / k)`，诊断标注为需交叉验证合理。

**[通过]** G11: 诊断关于 ext/gtc shear 签名差异的分析与代码一致。

**[通过]** G12-G37: 诊断归类为测试覆盖/期望值问题，整体方向合理。

### 2. 逻辑完整性

**[通过]** 从现象到根因的因果链完整，每个 issue 均覆盖"问题现象→代码行为→根因定位→修改方向"。

**[通过]** 根因分类合理，按 OOD 设计遗漏、设计决策、实现编码错误、实现不完整、测试错误等分类，无逻辑矛盾。

**[通过]** 修改方向与根因类型一致：OOD 设计遗漏→更新 OOD 文档，实现编码错误→修改代码，测试错误→修改测试。

### 3. 覆盖完备性

**[通过]** 任务描述中 todos.md 的全部 37 个 issue（S1-S4, G1-G37）均已覆盖分析。

**[通过]** 每个 issue 均回答了任务要求的三个核心问题：真实/误报、根因类型（OOD 设计/实现编码）、修改方向（OOD 文档/实现代码）。

**[通过]** 提供按根因分类的汇总表和分优先级的修改流程建议，便于后续执行。

## 质询要点

无。所有严重/一般问题均有充分证据支撑，根因定位准确，逻辑链完整，修复者可据此采取行动。
