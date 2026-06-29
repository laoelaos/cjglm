# 阶段四 OOD 设计方案 v2 质量审查报告

> 审查日期：2026-06-29
> 审查轮次：第 2 轮（质量审查）
> 审查视角：需求响应充分度 + 整体深度与完整性 + 落地可行性

---

## 1. 整体评价

本版本已从上一轮内部审议的 7 个问题中全部修复，矛盾声明、自相矛盾的错误策略、引用未定义约束等问题已消除。修订说明中对修复措施做了清晰对应。在需求覆盖面上，§1~§9 完整对应了 requirement.md 的 4 项核心要求（架构视图、模块划分、核心类型与接口设计、关键数据流与控制流、与已有阶段的集成方式）。

**但是，本轮审查发现了以下 9 个未在内部审议中覆盖的质量问题**，涉及事实错误、设计未决议、边界条件遗漏、命名冲突风险等方面。以下按严重程度排列。

---

## 2. 问题清单

### P1（严重）— `inversesqrt` 零值输入边界条件未处理

- **所在位置**：§3.1 `exponential.cj` 职责（第 244 行）
- **问题描述**：设计描述 `inversesqrt` 实现为 `T(1) / sqrt(x)`。当 `x == 0` 时，`sqrt(0) = 0`，紧接着 `T(1) / 0` 产生除零异常或 Inf。GLM 1.0.3 的 `inversesqrt` 在零输入时返回 Inf（由硬件自然传播），但仓颉中除零行为需要明确确认——是产生 Inf 还是运行时异常？设计未定义此边界行为。
- **改进建议**：在 §3.1 exponential.cj 职责或 §5 错误处理策略中明确 `inversesqrt` 零值输入的行为契约（与 GLM 一致返回 Inf，或增加 `sqrt(x) == 0` 保护分支）。

### P2（严重）— `geometric.cj` `Vec1 normalize` 语义未定

- **所在位置**：§3.1 `geometric.cj` 职责（第 271 行）
- **问题描述**："Vec1 的 normalize 退化为 T(1) 或 sign 语义"——"或"表示设计未决议。`Vec1` 的 normalize 是一个具体实现决策，不是自由选择。T(1) 和 sign 产生不同的数学结果：
  - T(1) 语义：`normalize(Vec1(x))` = `Vec1(T(1))`（始终返回 1）
  - sign 语义：`normalize(Vec1(x))` = `Vec1(sign(x))`（保留正负号）
- **改进建议**：明确选定一种语义。参照 GLM 1.0.3 行为：`glm::normalize(glm::vec1(x))` 实际上不存在——GLM 的 vec1 类型是自定义扩展，GLSL 没有 dvec1/vec1 的 normalize。建议参考 GLM 1.0.3 源码确认其 behavior（或直接定义为 `Vec1(T(1))` 恒定结果）。

### P3（严重）— `geometric.cj` 协作关系事实错误：`sqrt` 不属于 `trigonometric.cj`

- **所在位置**：§3.1 `trigonometric.cj` 协作关系（第 260 行）
- **问题描述**：协作关系描述为"被 geometric.cj（normalize 的 sqrt）调用"。但 `sqrt` 是 `exponential.cj` 的函数，不属于 `trigonometric.cj`。此处将 `sqrt` 错误地归入三角函数库。这可能导致编码阶段在 `trigonometric.cj` 中错误地寻找 `sqrt` 函数，或使依赖分析产生误导。
- **改进建议**：修正为"被 geometric.cj（normalize → `exponential.cj` 的 `sqrt`）调用"，或说明 `geometric.cj` 直接依赖 `std.math.sqrt`。

### P4（严重）— `lib.cj` 更新方案存在命名冲突：`perspective/ortho/frustum` 从 `ext` 和 `gtc` 同时导入

- **所在位置**：§8 `lib.cj` 更新（第 676 行） vs. 现有 `lib.cj`（第 24-26 行）
- **问题描述**：第 676 行建议新增 `public import glm.ext.{perspective, ortho, frustum, perspFov}`，但现有 lib.cj 第 24-26 行已经 `public import` 了 `glm.gtc.{perspective, ortho, frustum}`。在仓颉中，同一包名从两个不同子包 public import 同名函数将导致编译错误（命名歧义）。尽管 `ext` 和 `gtc` 版本的 signature 不同（ext 是简化版本），但 import 阶段无法通过 signature 消歧。现有 lib.cj 第 19 行的注释也明确说"`(perspective, ortho, translate` 由 gtc 模块提供，避免与 ext 冲突)"，说明原设计已知此冲突并刻意回避。第 676 行的新导入与既有策略矛盾。
- **改进建议**：删除第 676 行中的 `perspective`, `ortho`, `frustum` 从 ext 的导入（gtc 版本已覆盖所有变体），或通过在各自模块中重命名/添加前缀来消歧。仅保留从 ext 导入 ext 特有且 gtc 不覆盖的函数。

### P5（严重）— `common.cj` 函数族未从 `lib.cj` 导出，且 `mix` 存在命名冲突隐患

- **所在位置**：§8 `lib.cj` 更新（第 671-685 行） + 现有 `lib.cj`
- **问题描述**：§8 的 lib.cj 更新计划只添加 ext 和 gtc 的新导入，并在第 673 行注释"已有 import 自动生效，无需新增"。但 `common.cj` 的函数族（`min`, `max`, `abs`, `floor`, `mix`, `clamp` 等）目前并未从 lib.cj 导出——现有 lib.cj 只导出了 `detail` 的 `add/sub/mul/div/mod` 和三角函数。这意味着 phase 4 完成后，`glm::min(a, b)` 对于下游消费者不可用（必须从 `glm.detail` 手动 import），降低了 API 易用性。如果要添加详细函数的导出，`mix` 这个名字与第 14 行已从 `glm.ext` 导入的 `mix`（四元数 mix）存在命名冲突隐患——仓颉是否允许同名函数从不同子包导入有赖于语言规则验证。
- **改进建议**：在 §8 lib.cj 更新中明确指定 common.cj 函数族的导出策略：① 说明是否需要从 `glm.detail` re-export 这些函数；② 分析 `mix` 在 detail 和 ext 中的命名冲突（在 C++ GLM 中依赖名称隐藏和 using 声明，但仓颉的 import 机制不同）；③ 给出消歧方案（如对 ext 的 `mix` 添加 `quat` 前缀重命名为 `quatMix`，或评估仓颉的 import overload resolution 能力）。

### P6（一般）— `gtc/random.cj` 随机数状态管理与 §6 "纯函数" 声明矛盾

- **所在位置**：§3.3 `random.cj` 职责（第 427-429 行）、§6 并发设计（第 595 行）
- **问题描述**：§6 声明"core/ext/gtc 函数库均为纯函数（无副作用、不修改输入参数），天然线程安全"。但 `gtc/random.cj` 的 `linearRand`/`gaussRand` 需要底层随机数引擎状态——`std.random.Random` 是可变状态对象。设计未指定随机数引擎的管理策略：是每个调用创建新引擎（则性能差）？是全局单例（则非线程安全）？是 thread-local（则与"天然线程安全"声明不符）？此外，引擎的种子来源也未指定（默认种子？系统熵？），影响可重复性。
- **改进建议**：① 在 §3.3 random.cj 中补充随机数引擎管理策略（建议线程本地或显式传入引擎）；② 在 §6 并发设计中为 random.cj 增加例外说明；③ 指定种子初始化策略（默认种子 + 可选自定义种子）。

### P7（一般）— `gtc/noise.cj` 排列表与梯度向量的存储/初始化方式未涉及

- **所在位置**：§3.3 `noise.cj` 职责（第 413-420 行）
- **问题描述**："实现参考 GLM 1.0.3 `detail/_noise.hpp`"——但 GLM 的 Perlin/Simplex 噪声实现依赖大量静态数据：排列表（permutation table，如 `_detail::perm` 数组）、梯度向量表（如 `_detail::grad` 数组）。这些在 C++ 中通过静态常量数组实现，在仓颉中需要不同的存储机制（包级私有变量/静态成员）。设计未明确：① 这些表在仓颉中如何组织存储；② 何时初始化（编译期常量 vs. 运行时初始化）；③ 是否存在线程安全风险（只读表，无风险但需确认）。这些是实现噪声函数的前提条件，跳过导致编码阶段需要返工做设计决策。
- **改进建议**：在 §3.3 noise.cj 中补充：① 排列表和梯度向量的存储方案（建议包级 `let` 常量数组）；② 标注 GLM 1.0.3 的具体行号范围（如 `detail/_noise.hpp:10-150`）；③ 评估噪声算法迁移到仓颉的工作量（比常规函数库大，建议标注复杂度等级）。

### P8（一般）— `matrix.cj inverse` 的 Mat4x4 实现策略未决

- **所在位置**：§3.1 `matrix.cj` 职责（第 295 行）
- **问题描述**："Mat4x4：高斯消元或余子式展开"——"或"表示设计未提供具体的实现路径选择。高斯消元和余子式展开在数值稳定性和计算复杂度上有显著差异：余子式展开是 O(n!) 但 4×4 是可接受范围，高斯消元 O(n³) 但引入除法累加误差。GLM 1.0.3 使用余子式（cofactor）展开。未定策略将导致编码阶段需要重新做设计决策。
- **改进建议**：明确选型——建议选择与 GLM 1.0.3 一致的余子式展开（cofactor expansion），并在 D05 或新增决策条目中记录选择理由。

### P9（一般）— `ext/quaternion_trigonometric.cj` 的 `angle`/`angleAxis` stub 未纳入阶段四范围

- **所在位置**：§2 包组织 `quaternion_trigonometric.cj`（第 113 行）、§3.2 未出现
- **问题描述**：设计将 `ext/quaternion_trigonometric.cj` 标记为"沿用阶段三"。但实际检查现有代码（`quaternion_trigonometric.cj:24-27`），`angle` 和 `angleAxis` 两个函数仍为 `throw Exception("stub")`，未在阶段三完整实现。这两个函数的实现依赖 `trigonometric.cj` 的 `atan2`/`cos`/`sin`，属于阶段四的解除阻塞范围。设计未将它们纳入阶段四的"补齐"范围，遗漏了这些 stub 的替换工作。
- **改进建议**：将 `ext/quaternion_trigonometric.cj` 的 `angle` 和 `angleAxis` 列入阶段四的补齐范围（可归入第三批，与 ext/quaternion_common 和 ext/quaternion_transform 并列），或在 §2 中注明"阶段三 stub 需在本阶段补齐"。

---

## 3. 深度与完整性补充评估

### 总体判断

设计文档在宏观架构层面（包结构、依赖方向、批次规划）完整且合理，核心函数库的接口策略统一（标量 + Vec1~Vec4 模式）。但从落地编码视角，以下维度的深度可进一步补充：

| 维度 | 当前状态 | 建议补充 |
|------|---------|---------|
| 边界条件契约 | 仅§5 简表 + §4 场景流程，缺少完整的 edge case 清单 | 建议为每个 core/ext 函数库增加"边界条件"子节，明确 NaN/Inf/零/越界输入的行为 |
| 仓颉特有实现障碍 | 仅提及 `T(Float64(n))` 构造约定 | 建议补充各函数库在仓颉中的特有实现模式（如无指针时的 `modf` 返回值设计） |
| 命名冲突消歧方案 | 未涉及 | ext vs detail/gcc 同名函数（`mix`, `ortho`, `perspective` 等）在仓颉 import 层面的冲突分析 |
| 测试策略映射 | 完全缺失 | 建议增加与实施批次对应的测试策略指导 |
| 精度量化指标 | 未涉及 | `epsilon<T>() * T(10)` 等阈值仅仅是经验值，需要决定是否在测试中验证与 GLM 参考实现的一致性 |

---

## 修订说明（v1）

| 质询意见 | 回应 |
|---------|------|
| 本轮为首次质量审查，无前序质询 | — |
