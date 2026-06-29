根据以下审查结果，迭代上一轮的产出，形成新版的文件，从而更好地满足用户需求。

## 当前审查结果

### P1（严重）— gtc/noise.cj 周期性 Perlin 噪声仅覆盖 4D，遗漏 1D/2D/3D

**所在位置**：§3.3 gtc/noise.cj，第 657–672 行

**问题描述**：GLM 1.0.3 `gtc/noise.hpp`（第 47–50 行）通过模板维度参数 `L` 为所有维度提供周期性 Perlin 噪声重载 `perlin(vec<L,T,Q>, vec<L,T,Q> rep)`，即 1D/2D/3D/4D 的周期版本一一对应。当前文档仅添加了 `perlin4D(v, period)` 一个维度，缺少 `perlin1D(x, period)`、`perlin2D(v, period)`、`perlin3D(v, period)` 三个周期重载。

**严重程度**：严重 — 功能遗漏，与 GLM 1.0.3 的 API 覆盖范围不符。

**改进建议**：为 `perlin1D`/`perlin2D`/`perlin3D` 各补充一个周期参数重载，签名模式为 `func perlinND<T, Q>(v: VecN<T, Q>, period: VecN<T, Q>): T`（N=1/2/3），约束及实现路径参照 4D 版本。

### P2（严重）— gtc/random.cj 种子策略依赖未经验证的 Thread API

**所在位置**：§3.3 gtc/random.cj，第 687 行

**问题描述**：种子生成策略使用 `Thread.currentThread().id` 与时间戳异或。H5 确定性声明仅验证了 `ThreadLocal<T>` 的可用性，但未验证 `Thread` 类型是否提供 `.id` 属性或等价的方法。

**严重程度**：严重 — 未经确认的 API 假设，若编译不通过则整个种子策略需要重设计。

**改进建议**：新增验证项确认 `Thread.currentThread().id` 的编译可行性。可替换方案包括：使用 `std.env.getProcessId()` 替代线程 ID；使用线程局部位移量（如 `ThreadLocal<AtomicInt64>` 计数器）生成唯一递增种子；删除线程 ID 混合，仅使用时间戳并接受低碰撞风险。

### P3（中等）— gtc/ulp.cj float_distance 描述与签名语义不一致

**所在位置**：§3.3 gtc/ulp.cj，第 728–729 行

**问题描述**：描述文字使用"个数"暗示非负计数，但签名为 Int32/Int64 有符号类型。GLM 1.0.3 的 `float_distance` 返回有符号差值（可正可负）。

**严重程度**：中等 — 编码阶段会导致 confusion。

**改进建议**：方案 A（推荐）：修正描述为"返回 x 和 y 之间可表示浮点数的有符号差值（以 ULP 为单位）"；方案 B：将返回类型改为 UInt32/UInt64 并使用绝对值。

### P4（中等）— gtc/ulp.cj 未讨论 Float16 覆盖策略

**所在位置**：§3.3 gtc/ulp.cj，第 726–732 行

**问题描述**：文档声明 ulp.cj 使用"具体类型重载（Float32 + Float64）"，完全不提及 Float16。仓颉支持 Float16 且提供了 toBits()/fromBits() 方法。

**严重程度**：中等 — 编码阶段若 Float16 ULP 需求出现，需重新设计。

**改进建议**：在 §3.3 ulp.cj 末尾补充 Float16 策略声明。选项 A：新增 Float16 重载；选项 B：明确声明 Float16 不提供 ULP 函数并标注为已知缺失。

### P5（中等）— ext/quaternion_common.cj mix 描述存在不确定性措辞

**所在位置**：§3.2 ext/quaternion_common.cj，第 503 行

**问题描述**：描述中写道"此函数可能需要 common.cj 的 clamp 来确保 a 在 [0,1] 内"，其中的"可能"引入不确定性。D10 设计决策已明确"mix 使用 clamp"。

**严重程度**：中等 — 编码人员无法从"可能需要"判断是否应实现 clamp 保护。

**改进建议**：删除"可能"二字，改为"此函数使用 common.cj 的 clamp 将 a 截断至 [0,1] 后执行插值（见 D10）"。

### P6（一般）— gtc/noise.cj 命名约定变更未记录为设计决策

**所在位置**：§3.3 gtc/noise.cj，第 655–672 行 vs. §7 设计决策

**问题描述**：GLM 1.0.3 使用单一函数名 `perlin`/`simplex` 通过 C++ 模板维度参数 `L` 区分维度，本文档改用 `perlin1D~/perlin4D`、`simplex1D~/simplex4D` 的拆分命名，未在 §7 设计决策章节中记录。

**严重程度**：一般 — 不影响编码可行性，但决策追溯性不足。

**改进建议**：在 §7 中新增一条设计决策，记录噪声函数命名拆分的原因。

### P7（一般）— fwd.cj 与 gtc/type_precision.cj 的别名关系未澄清

**所在位置**：§3.3 gtc/type_precision.cj，第 692–719 行；§2 包组织，第 166 行

**问题描述**：文档未说明 `fwd.cj` 与 `type_precision.cj` 的别名关系及潜在的命名冲突。

**严重程度**：一般 — 实际编译时可能暴露，但设计文档未覆盖此集成细节。

**改进建议**：补充说明 type_precision.cj 的别名与 fwd.cj 的关系，确认命名空间兼容性。

## 历史迭代回顾

### 已解决的问题（出现于历史反馈但当前不再提及）

以下问题在前 14 轮迭代中被识别和修复，在最近的第 15 轮审查（组件 B）中未再出现，表明已成功解决：

- **第 1 轮**：矛盾声明（全部 stub vs. quaternion_exponential 保留）、acos clamp 自相矛盾、type_precision 别名范围缺失、Common<T> 约束引用错误、T(0)/T(1) 简写约定、mod 约束选择理由、geometric 约束向后兼容
- **第 2 轮**：inversesqrt 零值边界条件、Vec1 normalize 语义、trigonometric 协作关系事实错误、lib.cj perspective/ortho/frustum 命名冲突、common.cj 导出与 mix 冲突、random.cj 状态管理与纯函数矛盾、noise.cj 排列表存储、matrix inverse 实现策略、quaternion_trigonometric 纳入范围
- **第 3 轮**：Vec1 normalize 零输入行为自相矛盾、inversesqrt(0) IEEE 754 假设、跨包同名函数重载解析、packing.cj 签名缺失、ThreadLocal<Random> 验证、ext 矩阵函数范围
- **第 4 轮**：modf/frexp/ldexp 签名设计、奇异矩阵求逆行为不一致、mod 约束事实错误、trigonometric 依赖图遗漏 scalar_constants、random.cj 种子竞态、ulp.cj 泛型签名不可编码
- **第 5 轮**：ext/scalar_common 职责与 GLM 不符、ext/vector_common 函数清单缺失、ext/matrix_clip_space ortho 计数、gtc/matrix_transform 函数总数
- **第 6 轮**：geometric 导出遗漏、matrix determinant/inverse 导出遗漏、ext/matrix_projection 函数计数、Vec1 normalize 职责缺失、ext 公共函数导出遗漏、slerp 退化阈值、mod 浮点重载策略
- **第 7 轮**：lib.cj gtc/ext translate 等命名冲突、frexp 实现策略、ext/quaternion_common 依赖遗漏 common、noise.cj 签名缺失、iround/uround 负数行为、stdmath_shim Float16 溢出
- **第 8 轮**：lib.cj 重复导入、frexp 边缘场景、依赖遗漏 common、noise 签名、iround 方案、Float16 溢出、mod 标量浮点重载
- **第 9 轮**：ldexp Float16 回退描述矛盾、rotate 依赖与 normalize 遗漏、mirrorRepeat 实现公式
- **第 10 轮**：noise.cj lib.cj 导出函数名不匹配、packing.cj 仅导出 6/32 函数、round.cj 遗漏 ceilMultiple/floorMultiple、type_precision 别名遗漏、gtc/matrix_transform 委托声明不实、geometric sqrt 依赖描述
- **第 11 轮**：frexp 指数公式矛盾、ulp 实现公式错误
- **第 12 轮**：gtc/matrix_transform 依赖表遗漏 glm.ext
- **第 13 轮**：mirrorRepeat 公式不符、simplex 返回类型错误、projection 类型参数解耦、projection/clip_space 签名缺失、slow 变体签名缺失、hvec1 遗漏、ldexp 精度分析
- **第 14 轮**：lib.cj 修改策略自相矛盾、hvec1 导出遗漏、stdmath_shim 批次规划缺失、matrix_access/inverse 接口粒度

### 持续存在的问题（多轮反复出现）

本次审查 7 个问题均为第 15 轮首次发现，无反复出现的顽固问题。

### 新发现的问题（本轮新识别）

P1–P7 全部 7 个问题均为第 15 轮审查中新识别的问题，涵盖功能遗漏（P1）、未验证 API 假设（P2）、语义不一致（P3）、覆盖策略缺失（P4）、不确定性措辞（P5）、决策记录完整性（P6）、集成关系澄清（P7）。

## 上一轮产出路径

C:\Develop\Software\cjglm_wp\harness\redeliberations\202606291301_phase4_ood\a_v15_copy_from_v14.md

## 用户需求

C:\Develop\Software\cjglm_wp\harness\redeliberations\202606291301_phase4_ood\requirement.md
