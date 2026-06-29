根据以下审查结果，迭代上一轮的产出，形成新版的文件，从而更好地满足用户需求。

## 当前审查结果

### P1（严重）— `inversesqrt` 零值输入边界条件未处理
- **所在位置**：§3.1 `exponential.cj` 职责（第 244 行）
- **问题描述**：`inversesqrt` 实现为 `T(1) / sqrt(x)`，当 `x == 0` 时，`sqrt(0) = 0` 导致除零。设计未定义此边界行为。
- **改进建议**：在 §3.1 或 §5 中明确 `inversesqrt` 零值输入的行为契约（与 GLM 一致返回 Inf，或增加保护分支）。

### P2（严重）— `geometric.cj` `Vec1 normalize` 语义未定
- **所在位置**：§3.1 `geometric.cj` 职责（第 271 行）
- **问题描述**："Vec1 的 normalize 退化为 T(1) 或 sign 语义"——"或"表示设计未决议。T(1) 和 sign 产生不同数学结果。
- **改进建议**：明确选定一种语义，建议参照 GLM 1.0.3 源码确认行为。

### P3（严重）— `trigonometric.cj` 协作关系事实错误：`sqrt` 不属于 `trigonometric.cj`
- **所在位置**：§3.1 `trigonometric.cj` 协作关系（第 260 行）
- **问题描述**：协作关系描述为"被 geometric.cj（normalize 的 sqrt）调用"，但 `sqrt` 是 `exponential.cj` 的函数。
- **改进建议**：修正为"被 geometric.cj（normalize → `exponential.cj` 的 `sqrt`）调用"，或说明 `geometric.cj` 直接依赖 `std.math.sqrt`。

### P4（严重）— `lib.cj` 更新方案存在命名冲突：`perspective/ortho/frustum` 从 `ext` 和 `gtc` 同时导入
- **所在位置**：§8 `lib.cj` 更新（第 676 行）vs. 现有 `lib.cj`（第 24-26 行）
- **问题描述**：第 676 行建议从 `glm.ext` 新增导入 `perspective/ortho/frustum/perspFov`，但现有 lib.cj 已从 `glm.gtc` 导入了同名函数，导致命名歧义。
- **改进建议**：删除第 676 行中的 `perspective`、`ortho`、`frustum` 从 ext 的导入（gtc 版本已覆盖），或通过重命名消歧。

### P5（严重）— `common.cj` 函数族未从 `lib.cj` 导出，且 `mix` 存在命名冲突隐患
- **所在位置**：§8 `lib.cj` 更新（第 671-685 行）+ 现有 `lib.cj`
- **问题描述**：`common.cj` 函数族（`min/max/abs/floor/mix/clamp` 等）未从 lib.cj 导出，下游消费者须手动 import。`mix` 在 detail 和 ext 中同名，存在命名冲突隐患。
- **改进建议**：在 §8 中明确 common.cj 函数族的导出策略；分析 `mix` 在 detail 和 ext 中的命名冲突；给出消歧方案。

### P6（一般）— `gtc/random.cj` 随机数状态管理与 §6 "纯函数" 声明矛盾
- **所在位置**：§3.3 `random.cj` 职责（第 427-429 行）、§6 并发设计（第 595 行）
- **问题描述**：§6 声明函数库均为纯函数、天然线程安全，但 `gtc/random.cj` 的 `linearRand`/`gaussRand` 需要可变状态的随机数引擎。设计未指定引擎管理策略和种子来源。
- **改进建议**：补充随机数引擎管理策略（建议线程本地或显式传入引擎）；在 §6 中为 random.cj 增加例外说明；指定种子初始化策略。

### P7（一般）— `gtc/noise.cj` 排列表与梯度向量的存储/初始化方式未涉及
- **所在位置**：§3.3 `noise.cj` 职责（第 413-420 行）
- **问题描述**：设计仅说"实现参考 GLM 1.0.3 `detail/_noise.hpp`"，但未明确排列表和梯度向量在仓颉中的存储机制和初始化方式。
- **改进建议**：补充排列表和梯度向量的存储方案（建议包级 `let` 常量数组）；标注 GLM 具体行号范围；评估噪声算法迁移到仓颉的工作量。

### P8（一般）— `matrix.cj inverse` 的 Mat4x4 实现策略未决
- **所在位置**：§3.1 `matrix.cj` 职责（第 295 行）
- **问题描述**："Mat4x4：高斯消元或余子式展开"——"或"表示设计未提供具体的实现路径选择。
- **改进建议**：明确选型——建议选择与 GLM 1.0.3 一致的余子式展开（cofactor expansion），并在设计决策中记录选择理由。

### P9（一般）— `ext/quaternion_trigonometric.cj` 的 `angle`/`angleAxis` stub 未纳入阶段四范围
- **所在位置**：§2 包组织 `quaternion_trigonometric.cj`（第 113 行）、§3.2 未出现
- **问题描述**：`angle` 和 `angleAxis` 两个函数仍为 stub，依赖 `trigonometric.cj`（属于阶段四范围），但设计未将其纳入阶段四补齐范围。
- **改进建议**：将 `angle` 和 `angleAxis` 列入阶段四的补齐范围，或在 §2 中注明"阶段三 stub 需在本阶段补齐"。

## 历史迭代回顾

### 已解决的问题
第 1 轮迭代的 7 个问题（矛盾声明、acos clamp 矛盾、type_precision 别名范围、Common<T> 未定义引用、T(0)/T(1) 字面量写法、mod 约束策略、geometric.cj 约束收紧向后兼容）均已在上轮修订中修复（详见修订说明 v1→v2），当前反馈中不再提及。

### 持续存在的问题
无。本轮 9 个问题（P1-P9）均为第 2 轮诊断新识别的问题，在第 1 轮反馈中未出现。

### 新发现的问题
第 2 轮诊断发现的 9 个问题均为新问题：
- P1-P3：边界条件遗漏与事实错误（inversesqrt 零值、Vec1 normalize 语义、sqrt 归属）
- P4-P5：lib.cj 导出与命名冲突（ext vs gtc 同名导入、common.cj 导出缺失）
- P6-P8：实现深度不足（random 状态管理、noise 排列表存储、inverse 策略）
- P9：范围遗漏（quaternion_trigonometric stub 补齐）

以上 9 个问题均被质询报告确认为 LOCATED，可信度充分。

## 上一轮产出路径
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606291301_phase4_ood\a_v2_design_v1.md

## 用户需求
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606291301_phase4_ood\requirement.md
