# 质量审查诊断报告 — v17 OOD 设计文档（修订版）

**审查轮次**：第 2 轮（修订审查，处理质询反馈）
**待审查文件**：`a_v17_copy_from_v16.md`
**审查视角**：需求响应充分度、事实/逻辑一致性、深度与完整性、实际落地指导性

---

## 发现 1（严重）—— 已删除（质询不成立）

v1 报告中的发现 1 和发现 2 基于"参考实现目录 `references/glm-1.0.3/` 不存在"的错误前提。经查证：
- 该目录实际存在，包含 1672 个完整 GLM 1.0.3 源码文件
- `setup.hpp` 位于 `references/glm-1.0.3/glm/glm/detail/setup.hpp`
- `type_vec1~4.inl` 等关键文件均存在

因前提事实错误，发现 1（含 3 项具体影响分析及改进建议）全部删除。

---

## 发现 2（严重）—— 已删除（质询不成立）

v1 报告声称"与 roadmap 的 `GLM_CONFIG_CLIP_CONTROL` 默认值差异未闭合"。经查证：
- `setup.hpp` 第 583 行显示默认路径下（无 `GLM_FORCE_DEPTH_ZERO_TO_ONE`、无 `GLM_FORCE_LEFT_HANDED`）的值为 `GLM_CLIP_CONTROL_RH_NO = RH_BIT(8) | NO_BIT(2) = 0x0A`，**与 OOD 文档一致**
- v1 报告中"暂时采用 roadmap 原始值 `0x02`"的建议将引入错误值（`0x02` 仅为 `NO_BIT` 单独位，不是合法的完整 `GLM_CONFIG_CLIP_CONTROL` 值）
- OOD 文档的 `0x0A` 是正确的，roadmap 的 `0x02` 需要修正

因前提事实错误且建议方向错误，发现 2 全部删除。

---

## 发现 3（中等）—— `equalEpsilon` 与 `epsilonOf<T>()` 回退路径的隐式依赖链未归档

**问题描述**：§3.5 定义了 `epsilonOf<T>()` 的约束兼容性回退方案（移除 `Number<T>` 约束、在 `ComputeEqual.callConst` 中内联固定容差 `T(1e-6)`）。但 §4.5 的 `equalEpsilon` 函数体（非 `const` 扩展成员函数）继续引用 `epsilonOf<T>()`。当 `epsilonOf<T>()` 的回退被触发后，`equalEpsilon` 的可行性变化如下：

| epsilonOf 状态 | equalEpsilon 的预期行为 |
|--------------|----------------------|
| **保留 `Number<T>` 约束**（主方案） | Float 和整数 T 编译通过，Bool T 编译失败（`-` 不可用，文档已标注） |
| **移除 `Number<T>` 约束 + 内联固定容差**（回退方案） | `epsilonOf<T>()` 不再存在或签名变更，`equalEpsilon` 体内的 `epsilonOf<T>()` 引用失效 |

当前文档在 §4.5 和 §10 `equalEpsilon` 验证子节中均未提及此依赖链。实施者在编码阶段若先触发了 epsilonOf 的回退，再编译 `equalEpsilon` 时会遇到难以诊断的编译错误。

**所在位置**：§3.5 `epsilonOf<T>()` 兼容性策略、§4.5 `equalEpsilon` 函数体、§10 `equalEpsilon` 设计阶段验证子节

**严重程度**：中等

**改进建议**：
- 在 §12.1 层次三 `equalEpsilon` 验证项中新增"当 `epsilonOf<T>()` 回退路径被触发后，`equalEpsilon` 的实现需同步调整"的交叉引用注解。
- 在 §10 `equalEpsilon` 设计阶段验证子节中新增依赖项："`epsilonOf<T>()` 的验证状态（若回退方案的 `T(1e-6)` 内联替代 `epsilonOf<T>()`，则 `equalEpsilon` 体内须同步替换）"。

---

## 发现 4（中等）—— `fromBoolVec` 工厂函数的 API 暴露路径未覆盖 Vec1 的不对称性

**问题描述**：§9.4 推荐路径 A（`fromBoolVec` 工厂函数）定义为各 VecN 类型 `extend` 块中的扩展成员函数。Vec1 存在已知的构造函数不对称性（§4.1：仅 `const init(x: T)`，无 `public init(scalar: T)`，因参数列表冲突）。`fromBoolVec` 的典型实现模式为 `VecN(if (v.x) { T(1) } else { T(0) }, ...)`，Vec1 需使用 `Vec1(if (v.x) { T(1) } else { T(0) })`——调用 `const init(x: T)`。此模式虽可编译通过，但 **Vec1 的 `fromBoolVec` 在调用语法上与 Vec2~Vec4 存在差异的可能性未评估**：

- `Vec1.fromBoolVec(src)` 与 `Vec2.fromBoolVec(src)` 的签名均通过 `extend` 块定义，调用语法相同。
- 但实施者按照文档描述实现 Vec1 扩展函数时，可能尝试先定义 `public init(scalar: T)` 再定义 `fromBoolVec`，遭遇 Vec1 特有的重载冲突后才能发现问题。此开发体验障碍未在文档中预判。

**所在位置**：§9.4 Bool→数值转换路径 A、§4.1 Vec1 构造函数不对称性说明

**严重程度**：中等

**改进建议**：
- 在 §9.4 路径 A 的 `fromBoolVec` 描述中新增："Vec1 的 `fromBoolVec` 实现与 Vec2~Vec4 模式一致（均为 extend 块中的扩展成员函数，接收 `Vec1<Bool, Q2>` 参数，构造 `Vec1<T, Q>` 实例）。除调用 `const init(x: T)` 而非 `public init(scalar: T)` 外，实现模式无差异"。
- 在 §4.1 Vec1 不对称性说明中添加交叉引用："此不对称性影响 `fromBoolVec` 等工厂函数的实现——Vec1 仅能通过 `const init(x: T)` 构造（详见 §9.4）"。

---

## 发现 5（一般）—— 文档未说明 Vec 结构体是否实现 `Display`/`ToString`/`Format` 接口

**问题描述**：§3.2 字符串表示策略声明"Vec 类型不实现自定义 `toString()` 或 `Format`/`Display`"，但 §12 的测试策略中未覆盖此决定的验证。实施者在编写测试代码（如 `println(v)` 用于调试）时，若 Vec 未实现任何格式化接口，将产生编译错误或默认格式输出。此策略的合理性和对调试效率的影响未评估。

**所在位置**：§3.2 "字符串表示策略"段落、§12 验证层次

**严重程度**：一般

**改进建议**：
- 在 §3.2 字符串表示策略中补充选择理由："首轮依赖编译器为 struct 生成的默认字符串表示；若调试发现默认格式不满足需求，可在后续轮次提供 `to_string` 具名函数"。
- 在 §12.1 层次一（编译验证）或层次二（构造与访问验证）中补充一项："确认 Vec 类型在 `println` 或字符串上下文中至少可编译通过（即使格式由编译器确定）"。

---

## 观察结论

该文档经过 17 轮迭代，在技术可行性、接口定义粒度、异常场景覆盖、迁移成本评估等维度已达到较高成熟度。设计决策（D1~D35）完整记录了每个关键选择的理由和备选方案。验证计划（§10、§12）和回退路径分析是文档最突出的优势——几乎每个编译器行为假设都有对应的验证要求和失败回退方案。

v1 报告中的发现 1 和发现 2 基于"参考实现目录不存在"的错误前提，经质询确认后已删除。OOD 文档中对 `GLM_CONFIG_CLIP_CONTROL` 默认值 `0x0A` 的声明是正确的，且已获得参考实现 `setup.hpp`（第 583 行）的验证支持。

剩余 3 项发现（发现 3~5）均为非阻断性改进建议，可酌情采纳。

---

## 修订说明（v2）

| 质询意见 | 回应 |
|---------|------|
| **质询 1（严重）：** 发现 1 的"参考目录不存在"断言与事实严重不符——`references/glm-1.0.3/` 实际存在且包含 1672 个文件。3 项具体影响分析和改进方案全部建立在此错误前提之上。 | **接受。** 已删除发现 1 全部内容。事实证明参考实现目录完整存在，OOD 文档中关于配置默认值和构造函数验证的参考实现依赖前提成立。 |
| **质询 2（严重）：** 发现 2 的改进建议（采用 roadmap 值 `0x02`）将引入错误值。`setup.hpp` 第 583 行显示默认值为 `GLM_CLIP_CONTROL_RH_NO = 0x0A`，OOD 文档正确，roadmap 需要修正。采纳此建议将导致编码阶段使用错误的裁剪空间配置。 | **接受。** 已删除发现 2 全部内容。经查证 `setup.hpp` 第 568-583 行：`GLM_CLIP_CONTROL_RH_NO = RH_BIT(8) | NO_BIT(2) = 0x0A`，OOD 文档的 `0x0A` 正确无误。v1 报告的"暂时采用 roadmap 值 `0x02`"建议确为错误方向。 |
| **质询 3：** 发现 3（`equalEpsilon` 依赖链）、发现 4（`fromBoolVec` Vec1 不对称性）、发现 5（Display/ToString）证据充分、逻辑自洽，建议保留。 | **接受。** 三项发现原样保留，未作修改。 |
