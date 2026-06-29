根据以下审查结果，迭代上一轮的产出，形成新版的文件，从而更好地满足用户需求。

## 当前审查结果

### P1（严重）— geometric.cj 的 Vec 几何函数未纳入 lib.cj 导出

**所在位置**：§8 lib.cj 更新（第 883-906 行）

**问题描述**：`detail/geometric.cj` 的 `dot/cross/normalize/length/distance/reflect/refract/faceforward` 是阶段四替换 stub 为完整实现的 Vec 类型几何函数。但 §8 的 lib.cj 增量导出方案中完全未包含这些函数的 `public import`。当前 `lib.cj` 仅导入了 `glm.ext.{dot, length, normalize, cross}`（Quat 版本），Vec 版本的几何函数从未被导出。

**改进建议**：在 §8 lib.cj 更新代码块中增加 `public import glm.detail.{dot, cross, normalize, length, distance, reflect, refract, faceforward}`。确认这些符号与 `lib.cj:15` 的 `glm.ext.{dot, length, normalize, cross}`（Quat 版本）在仓颉重载解析下不会歧义——Vec 参数与 Quat 参数类型不同，应可自动区分。

### P2（严重）— matrix.cj 的 determinant/inverse 未纳入 lib.cj 导出

**所在位置**：§8 lib.cj 更新（第 883-906 行）

**问题描述**：`detail/matrix.cj` 的 `determinant`（Mat2x2/Mat3x3/Mat4x4）和 `inverse`（Mat2x2/Mat3x3/Mat4x4）是阶段四替换 stub 为完整实现的核心能力。§8 lib.cj 更新未包含任何 matrix.cj 相关导出。当前 `lib.cj:14` 已导入 `glm.ext.{inverse}`（Quat 版本），Mat 版本的 `determinent` 和 `inverse` 均无法通过 `glm` 包访问。

**改进建议**：在 §8 lib.cj 更新中增加 `public import glm.detail.{determinant, inverse}`。确认 `detail.inverse`（Mat 参数）与 `ext.inverse`（Quat 参数）的重载解析无歧义。

### P3（严重）— ext/matrix_projection.cj 函数计数与清单不一致

**所在位置**：§3.2 ext/matrix_projection.cj 职责（第 444 行）

**问题描述**：设计声称呼应 GLM 1.0.3 `ext/matrix_projection.hpp` 的"全部 8 个函数"，但紧接其后的函数签名清单仅列出 7 个函数。计数（8）与清单（7）自相矛盾。

**改进建议**：核对 GLM 1.0.3 `ext/matrix_projection.hpp` 的实际函数数量，修正为正确值，并确保清单与计数一致。

### P4（一般）— Vec1 normalize 在职责清单中缺失，形成内部矛盾

**所在位置**：§3.1 geometric.cj 职责（第 291-294 行）vs. §5 错误表（第 781 行）

**问题描述**：§3.1 geometric.cj 的 `normalize` 职责明确限定为"Vec2~Vec4 版本"，排除 Vec1。但紧接着描述了"Vec1 normalize 的零值行为"。§5 错误表也包含了"Vec1 零向量 normalize 返回 NaN"的条目。设计自相矛盾。

**改进建议**：在 §3.1 geometric.cj 的 `normalize` 职责中补充 Vec1 版本，使职责清单、行为描述和错误表三方一致。

### P5（一般）— ext/scalar_common.cj 和 ext/vector_common.cj 的公共函数未纳入 lib.cj 导出

**所在位置**：§8 lib.cj 更新（第 883-906 行）

**问题描述**：`ext/scalar_common.cj`（17 个函数）和 `ext/vector_common.cj`（20 个函数）的公共 API 函数完全未出现在 §8 lib.cj 导出清单中。下游消费者无法通过 `glm.fmin(a,b)`、`glm.fclamp(x,min,max)` 等调用这些函数。

**改进建议**：在 §8 lib.cj 更新中补充 ext/scalar_common.cj 和 ext/vector_common.cj 的公共函数导出。

### P6（一般）— slerp 退化条件阈值未定义，编码阶段不可直接实现

**所在位置**：§3.2 ext/quaternion_common.cj（第 475 行）、§7 D09（第 811 行）

**问题描述**：设计声明 slerp 在 sinOmega 接近零时退化为 lerp，但仅给出模糊建议，未定义具体阈值。编码阶段需要明确的数值判断条件。

**改进建议**：在 §3.2 slerp 实现路径或 D09 中明确定义退化阈值表达式，例如直接指定 `if sinOmega < epsilon<T>()` 或引用 GLM 1.0.3 源码中的精确条件。

### P7（一般）— mod 浮点重载的处理策略未明确

**所在位置**：§3.1 common.cj（第 239 行）、§7 D15（第 817 行）

**问题描述**：D15 声明 `mod` 当前约束为 `Integer<T>`，"未来可考虑补充浮点重载"。但实际已有代码中存在 12 个具体浮点类型向量重载。设计未阐明这些既有浮点重载在阶段四的处理策略。

**改进建议**：在 D15 中补充 `scalar_vec_ops.cj` 中既有浮点重载的处理策略说明，对齐描述与实际代码状态。

## 历史迭代回顾

### 已解决的问题（出现在历史反馈但当前反馈中不再提及的问题）

以下来自第 5 轮及之前的问题已在 v6 版本中修复，经 v6 审查确认不再出现：
- `ext/scalar_common.cj` 职责描述与 GLM 1.0.3 事实不符（迭代 5 P1）
- `ext/vector_common.cj` 缺乏完整函数清单（迭代 5 P2）
- `ext/matrix_clip_space.cj ortho` 系族函数计数错误（迭代 5 P3）
- `gtc/matrix_transform.cj` 函数总数与分项求和自相矛盾（迭代 5 P4）
- `modf/frexp/ldexp` 签名设计完全缺失（迭代 4 P1）
- 奇异矩阵求逆行为三处自相矛盾（迭代 4 P2）
- `mod` 约束描述与代码事实不符（迭代 4 P3）
- `gtc/ulp.cj` 泛型函数缺少实现路径（迭代 4 P6）
- Vec1 normalize 零输入行为自相矛盾（迭代 3 P1）
- `inversesqrt(0)` 返回 +Inf 依赖未经验证（迭代 3 P2）
- lib.cj 跨包同名函数导入编译风险（迭代 3 P3）
- `gtc/packing.cj` 设计粒度不足（迭代 2 P4 等）
- `ext/matrix_transform.cj` 与 `ext/matrix_clip_space.cj` 函数范围未明确（迭代 2 P6 等）
- `gtc/random.cj` 种子竞态风险（迭代 3 P5 / 迭代 4 P5）
- `trigonometric.cj` 依赖遗漏 scalar_constants（迭代 4 P4）
- 矛盾声明: stub 替换范围（迭代 1 P1）
- acos 输入 clamp 矛盾（迭代 1 P2）
- `gtc/type_precision.cj` 未定义具体别名（迭代 1 P3）
- `T(0)/T(1)` 字面量写法不一致（迭代 1 P5）

### 持续存在的问题（在多轮反馈中反复出现的问题，需重点解决）

以下 7 个问题在第 6 轮首次被发现，第 6 轮迭代要求中已要求修复，但在 a_v6_design_v2.md 中仍未得到修复，延续至本第 7 轮：

- **P1 — geometric.cj 几何函数未纳入 lib.cj 导出**：第 6 轮 #1，持续 2 轮未修复
- **P2 — matrix.cj determinant/inverse 未纳入 lib.cj 导出**：第 6 轮 #2，持续 2 轮未修复
- **P3 — matrix_projection.cj 函数计数与清单不一致**：第 6 轮 #3，持续 2 轮未修复
- **P4 — Vec1 normalize 职责清单缺失**：第 6 轮 #4，持续 2 轮未修复
- **P5 — ext/scalar_common/vector_common 未纳入 lib.cj 导出**：第 6 轮 #5，持续 2 轮未修复
- **P6 — slerp 退化阈值未定义**：第 6 轮 #6，持续 2 轮未修复
- **P7 — mod 浮点重载策略未明确**：第 6 轮 #7，持续 2 轮未修复

**需重点关注**：P1/P2/P5 属于 lib.cj 公共 API 导出策略的系统性遗漏，直接影响下游消费者可通过 `glm` 包访问的函数范围，三个问题的修复模式相同（在 §8 补充 `public import`）。建议一并审查并修复。

### 新发现的问题（本轮新识别的问题）

无。全部 7 个问题均继承自第 6 轮，无新识别的问题。

## 上一轮产出路径
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606291301_phase4_ood\a_v6_design_v2.md

## 用户需求
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606291301_phase4_ood\requirement.md
