# 质量审查报告 — OOD 设计方案 v3

## 审查概述

- **审查对象**：阶段四 OOD 设计方案 v3（`a_v3_design_v1.md`）
- **审查轮次**：第 3 次（继两轮内部审议后的独立质量审查）
- **审查视角**：需求响应充分度、事实正确性、逻辑一致性、落地可实施性
- **已读参考**：阶段四需求文档、迭代历史、现有代码实现（src/ 全目录）、GLM 1.0.3 参考实现目录结构、路线图文档

---

## 1. 需求响应评估

产出具象化了路线图阶段四的范围定义，覆盖了 core/ext/gtc 三层的全部函数族，并在 §1.5/§1.6 中明确了边界（quaternion_exponential 排除、angle/angleAxis 纳入）。模块划分与已有阶段的包结构保持连续，集成方案（§9）明确了对阶段一二三的反向兼容策略。整体需求覆盖充分。

以下聚焦剩余质量问题。

---

## 2. 问题清单

### P1 — Vec1 normalize 零输入行为自相矛盾

- **所在位置**：§3.1 `geometric.cj`（第 275 行 vs. 第 278 行）、§5 错误处理策略表（第 601–603 行）
- **问题描述**：
  - 第 275 行专门描述 Vec1 normalize：零值输入时 `0 * Inf = NaN`，"与 GLM 1.0.3 行为一致"
  - 第 278 行 general 描述：normalize 有"零向量保护返回零向量"
  - §5 错误表：确认 normalize 返回零向量，且有保护分支 `if lengthSq == T(0) return zero-vec`
  - 三者矛盾：Vec1 到底返回 NaN 还是零向量？
  - 此矛盾在 v3 修订中被引入——第 275 行是响应第 2 轮 P2 审查意见后修改的，但第 278 行和 §5 未同步修正
- **严重程度**：严重
- **改进建议**：选择其一并全局统一：
  - 方案 A：Vec1 normalize 与其他维度一致，增加零向量保护返回零向量，第 275 行修改为"零值时返回零向量"
  - 方案 B：保持 Vec1 返回 NaN 的特殊行为，则在第 278 行的 general 描述中注明 Vec1 例外，并在 §5 错误表第 2 行增加"Vec1 除外：0×Inf=NaN"的脚注

### P2 — `inversesqrt(0)` 返回 +Inf 依赖 CangJie 浮点除零行为，未经验证

- **所在位置**：§3.1 `exponential.cj`（第 248 行）、D20
- **问题描述**：
  - 设计声称 `inversesqrt(0) = T(1) / sqrt(0) = T(1) / 0 = +Inf`，描述为"IEEE 754 自然浮点运算结果"
  - 但此断言依赖于 CangJie 运行时在浮点除以零时返回 `+Inf`（而非抛出 ArithmeticException 或类似异常）
  - 现有代码库中存在反向证据：`quaternion_geometric.cj:25-27` 的 `normalize` 实现在 `len <= zero` 时显式保护跳过 `q / len` 除法，说明代码库已意识到 CangJie 浮点除零可能有风险
  - `ext/quaternion_trigonometric.cj:15-16` 中 `axis` 函数也有 `if (tmp1 <= zero)` 的保护分支
  - 如果 CangJie 行为不满足 IEEE 754 除零返回 Inf，则 `inversesqrt(0)` 将抛出异常，导致整个函数的行为与 GLM 不符
  - 该假设未被列入 H1/H2/H3 的确定性声明，属于隐式 P0 级假设
- **严重程度**：严重
- **改进建议**：
  - 新增验证项：确认 `Float64(1) / Float64(0)` 是否返回 `+Inf`
  - 若返回 +Inf，则在 §1.7 中补充为 H4 确定性声明；若不返回，则需增加零值保护分支（如 `if x == T(0) then T(Inf) else ...`）

### P3 — `lib.cj` 中 `mix` 和 `exp/log/pow/sqrt` 的跨包同符号导入存在编译风险

- **所在位置**：§8 `lib.cj` 更新代码块，§8 "关于 `mix` 命名冲突的处理"段落
- **问题描述**：
  - Phase 4 将新增 `public import glm.detail.{mix, ...}`，而现有 `lib.cj:14` 已导入 `mix` 来自 `glm.ext`
  - 类似地，Phase 4 将新增 `public import glm.detail.{pow, exp, log, sqrt, ...}`，而现有 `lib.cj:16` 已导入 `exp, log, pow, sqrt` 来自 `glm.ext`
  - 设计分析了 `mix` 的冲突，声称"仓颉支持函数重载，编译器可基于参数类型自动区分"
  - 但此断言未经验证——CangJie 是否允许同一包（`glm`）的两个 `public import` 导入同名函数？如果 CangJie 的导入解析以名字为单位（而非以完整签名为单位），这两个导入将直接报"ambiguous import"编译错误
  - `exp/log/pow/sqrt` 的冲突在设计中被完全忽视——§8 仅分析了 `mix`，未提及 `exp/log/pow/sqrt` 的同类问题
  - 若此假设不成立，则整份 lib.cj 更新方案需要重新设计（例如：在 detail 和 ext 间加一层 wrapper，或使用命名空间限定导入）
- **严重程度**：严重
- **改进建议**：
  1. 新增验证项：编写最小测试用例，确认 CangJie 能否在同一包中通过两个 `public import` 导入同名但不同类型签名的函数并正确重载解析
  2. 将 `exp/log/pow/sqrt` 也纳入命名冲突分析
  3. 如果验证失败，在 §7 中新增设计决策记录替代方案（如 wrapper 函数、重命名等）

### P4 — `gtc/packing.cj` 设计粒度不足，无法指导编码

- **所在位置**：§3.3 `gtc/packing.cj`（第 419–427 行）
- **问题描述**：仅列出函数名称（"packUnorm4x8/packSnorm4x8/packUnorm2x16/..."），未给出任何一个函数的完整签名（参数类型、返回类型、泛型约束），也未说明实现路径。相比同节中其他模块（如 `ulp.cj`、`round.cj`）都有明确的函数签名描述，`packing.cj` 缺少足够的信息供编码者直接使用。
  - 举例：`packUnorm4x8` 输入是 `Vec4<T, Q>` 还是四个独立参数？T 的约束是 `FloatingPoint<T>` 还是具体类型？返回 `UInt32` 还是 `Vec4<UInt8, Q>`？
  - 这些是 GLM 1.0.3 源码中明确可查的信息，设计文档应将其记录以降低编码阶段的查询成本
- **严重程度**：一般
- **改进建议**：
  - 为每个 packing 函数补充完整签名（参考 `glm/gtc/packing.inl`），至少包含 2–3 个典例函数的完整签名作为格式示范
  - 说明使用 CangJie 原生位操作 API（`Float32.toBits(): UInt32` 等）还是其他路径

### P5 — `gtc/random.cj` 线程本地存储方案缺少可行性验证

- **所在位置**：§3.3 `gtc/random.cj`（第 445–447 行）、D19、§6
- **问题描述**：
  - 设计选择 `ThreadLocal<Random>` 作为随机数引擎管理方案，但未说明 CangJie 中 `ThreadLocal` 是否可用、是否支持非 `Send` 类型的实例、`Random` 是否为 `Send`/`Sync`
  - 如果 `ThreadLocal<T>` 要求 `T <: Send` 而 `std.random.Random` 不满足，此方案不可行
  - 未指定种子初始化时机和全局种子管理策略——"首次使用时以当前系统时间"是懒初始化，在多线程场景下可能有多次调用的竞态问题
  - 此方案是阶段四唯一引入可变状态的函数库，其正确性对整体并发安全声明（§6）至关重要
- **严重程度**：一般
- **改进建议**：
  - 新增验证项：确认 CangJie `ThreadLocal<Random>` 可编译运行
  - 在 D19 中补充 `ThreadLocal` 的初始化和竞态保护策略
  - 提供备选方案（如 `Mutex<Random>` 或全局初始化）

### P6 — `ext/matrix_transform.cj` 与 `ext/matrix_clip_space.cj` 实际函数范围未明确

- **所在位置**：§1 核心抽象表、§3.2 `ext/matrix_transform.cj`（第 317–326 行）、§3.2 `ext/matrix_clip_space.cj`（第 337–344 行）
- **问题描述**：
  - 当前 `ext/matrix_transform.cj` 的 stub 仅有 1 个函数（`translate`），设计表示"替换 stub 为完整实现"但仅列出 `translate/rotate/scale` 三个函数。GLM 1.0.3 的 `ext/matrix_transform.hpp` 是否还有更多函数？设计未明确
  - 当前 `ext/matrix_clip_space.cj` 的 stub 仅有 1 个函数（`ortho`），设计同样未明确补充的完整函数列表
  - 对比之下，`gtc/matrix_transform.cj` 在第 388–396 行给出了详细的系族分类和函数计数（如"基础变换 9 个"、"ortho 系族 10 个"），而 `ext/` 的对应文件缺乏类似粒度
- **严重程度**：一般
- **改进建议**：为每个 `ext/` 矩阵文件列出完整的函数签名清单（可参考 GLM 1.0.3 的 `ext/matrix_transform.hpp` 等头文件定位具体函数），或明确标注"函数范围与 GLM 1.0.3 `ext/matrix_transform.hpp` 一致"并给出参考行号

---

## 3. 总体评价

设计方案整体结构完整、模块划分清晰、与已有阶段的集成方案持有理据。核心风险集中在三个方面：

1. **未验证的运行期行为假设**（P2：CangJie IEEE 754 除零语义）——直接影响 `inversesqrt` 和 `normalize` 等核心函数的正确性。
2. **未验证的编译器/语言机制假设**（P3：跨包同名函数重载解析）——直接影响 `lib.cj` 更新方案是否可编译。
3. **内部逻辑矛盾**（P1：Vec1 normalize 行为）——v3 版本中新引入的矛盾，需全局统一。

P4–P6 为设计粒度不足问题，不影响决策方向但增加编码阶段的查询成本。

建议修复者优先处理 P1（矛盾）和 P2/P3（验证），再补充 P4–P6 的细节。
