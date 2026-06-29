根据以下审查结果，迭代上一轮的产出，形成新版的文件，从而更好地满足用户需求。

## 当前审查结果

### P1（严重）— lib.cj 最终编译验证未纳入实施批次规划

**所在位置**：§8 实施批次规划（第 998~1043 行）、§8 lib.cj 更新（第 1043~1116 行）

**问题描述**：
lib.cj 更新是本阶段最复杂的单文件变更——涉及修改现有第 23 行（删除 7 个符号的 gtc import）、追加约 50 行 public import（覆盖 core/ext/gtc 三层），包含跨包同名函数导入（`mix` 同时从 detail 和 ext 导入、`exp/log/pow/sqrt` 同时从 detail 和 ext 导入、`translate/rotate/scale/shear/lookAt/lookAtRH/lookAtLH` 从 ext 导入并与 gtc 原有导入冲突）。然而 **§8 实施批次规划的 lib.cj 条目仅描述了修改内容，未包含任何编译验证步骤**。所有批次的"测试"列均针对单个模块的功能正确性，缺少对 lib.cj 最终的集成编译验证。此遗漏意味着编码团队完成全部 4 批次编码后，可能因 lib.cj 导入配置错误（重载决议歧义、符号重复、函数名拼写错误等）导致编译失败，而此时所有模块的单元测试已通过，排查成本极高。

**严重程度**：严重

**改进建议**：在 §8「lib.cj 更新」末尾新增验证步骤：
1. **编译验证**：`cjpm build` 确认 lib.cj 全部 public import 可编译通过，无符号重复或歧义错误
2. **重载决议验证**：为关键跨包同名函数编写最小调用用例——`mix(vec, vec, float)` 确认匹配 detail 版本、`mix(quat, quat, float)` 确认匹配 ext 版本；`exp(vec)` 确认匹配 detail 版本而非 ext 的 stub 版本；`translate(mat, vec)` / `perspective(args)` 确认 gtc 与 ext 统一入口处无歧义
3. **归入「所有批次完成后」条目**，与 lib.cj 修改同级

---

### P2（一般）— ext/matrix_projection.cj unProject 系族隐式矩阵求逆的奇异场景未覆盖

**所在位置**：§3.2 ext/matrix_projection.cj（第 528~544 行）、§5 错误处理策略表（第 937~948 行）

**问题描述**：
unProject 系族的实现路径描述为"视口逆变换 → 逆投影"（第 544 行），内部需计算 `inverse(proj * model)`。当 proj×model 为奇异矩阵时，此隐式求逆将产生 NaN/Inf 填充结果。但 §5 错误处理策略表的「奇异矩阵求逆」条目仅覆盖了 `matrix.cj` 的显式 `inverse()` 函数，未提及 unProject 内部隐式求逆的场景。此遗漏的影响：编码团队可能仅在 `matrix.cj.inverse()` 中处理奇异行为，而忽略 unProject 内部的求逆路径。

**严重程度**：一般

**改进建议**：
- 方案 A：在 §5 错误处理策略表中新增一行，说明 unProject 系族在 proj×model 为奇异矩阵时的行为与 matrix.cj inverse 一致（IEEE 754 自然传播 NaN/Inf，不抛异常），并注明此场景不重复设计决策
- 方案 B：在 §3.2 ext/matrix_projection.cj 实现路径末尾补充脚注，引用 §5 的奇异矩阵行为描述

---

### P3（一般）— §4 关键数据流与控制流章节深度不足

**所在位置**：§4 关键行为契约（第 842~931 行）

**问题描述**：
需求要求输出包含"关键数据流与控制流"的 OOD 文档。当前 §4 的 6 个核心场景以伪代码格式简要描述了输入→处理→输出流程，但存在以下不足：
1. **缺乏跨模块调用链追踪**：调用链涉及多个模块，但 §4 仅描述了公式，未展示数据在模块间的变换路径和每步的类型/约束转换
2. **缺乏控制流分支分析**：normalize 在 Vec1 与 Vec2~Vec4 的分支路径差异、refract 的 k<0 全反射分支、slerp 的 sinOmega 退化分支等，§4 未在同一视图中集中呈现关键决策点
3. **缺乏异常传播路径**：当奇异矩阵进入 inverse 或 acos 越界输入时，NaN/Inf 如何沿调用链传播至最终结果——此信息分散在 §3 和 §5，§4 未建立从"异常发生点"到"最终结果"的追踪路径

相比之下，§3 各模块设计描述非常详尽（签名级别），§4 更像是 §3 的摘要重复而非独立的数据流/控制流分析。

**严重程度**：一般

**改进建议**：增强 §4 的深度——至少为以下 3 个关键函数补充完整数据流与控制流分析：
1. **slerp**：调用链 `quaternion_common.slerp → detail.common.clamp → detail.trigonometric.acos/sin → detail.common(T(1))`，展示每步的类型约束和异常传播路径
2. **lookAt**：`ext.matrix_transform.lookAt → detail.geometric.normalize/cross → detail.trigonometric(无)`，展示从 eye/center/up Vec3 到 Mat4x4 的完整变换路径
3. **inverse (Mat4x4)**：展示 cofactor 展开的 4 次递归 + 3x3 子式分解 + 1/det 路径，以及 det=0 时 NaN/Inf 在结果矩阵中的填充传播路径

---

## 历史迭代回顾

根据 `iteration_history.md` 综合分析历史反馈与当前反馈的关系：

### 已解决的问题（出现在历史反馈但当前反馈中不再提及的问题）
- **shear 签名错误**（外部第 1 轮）：`shear` 参数类型与 GLM 不符，`p`/`l_x`/`l_y`/`l_z` 类型错误；已在当前设计中修正为 `shear<T, Q>(m: Mat4x4<T, Q>, p: Vec3<T, Q>, l_x: Vec2<T, Q>, l_y: Vec2<T, Q>, l_z: Vec2<T, Q>)`
- **slerp 第四参数 k 类型未指定**（外部第 1 轮）：已在当前设计中补充完整签名为 `slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T, k: T): Quat<T, Q>`
- **stdmath_shim.cj 完整包装函数清单缺失**（外部第 1 轮）：当前文档已列出 25 个完整包装函数清单
- **shear_slow 实现路径错误**（外部第 1 轮）：当前设计已修正为从 Vec2 参数提取分量构造矩阵的描述
- **范围与路线图交叉验证缺失**（外部第 2 轮）：当前 §1.6 已包含完整的映射表
- **common.cj 依赖遗漏 stdmath_shim.cj**（外部第 3 轮）：当前 §2 依赖表已补充 `stdmath_shim.cj`
- **stdmath_shim.cj 函数数量声明不符**（外部第 3 轮）：当前已修正为"25 个"
- **mirrorRepeat 公式错误**（内部第 13 轮）：已修正为与 GLM 1.0.3 一致的公式
- **Simplex 返回类型错误**（内部第 13 轮）：已从 Vec 类型修正为标量 `T`
- **frexp 指数公式错误**（内部第 11 轮）：已从 `floor(log2(abs(x)))` 修正为 `floor(log2(abs(x))) + 1`

### 持续存在的问题（在多轮反馈中反复出现的问题，需重点解决）
- **P1：lib.cj 编译验证缺失** — 首次出现在历史外部第 4 轮（作为严重问题），当前审查再次以 P1 指出。说明此前多轮修复中未曾触及 §8 实施规划中 lib.cj 的验证步骤，需要在本轮彻底修复
- **P2：unProject 隐式求逆奇异场景遗漏** — 首次出现在历史外部第 4 轮（作为一般问题），当前审查再次以 P2 指出。此前修复可能仅关注了显式 inverse 的奇异行为描述，未覆盖 unProject 内部隐式求逆路径
- **P3：§4 数据流/控制流深度不足** — 首次出现在历史外部第 4 轮（作为一般问题），当前审查再次以 P3 指出。此前修复可能只做了浅层增补，未达到跨模块调用链追踪、分支分析、异常传播路径三个维度的深度要求

### 新发现的问题
本轮无新发现的问题。3 个问题均来源于历史外部第 4 轮，说明第 4 轮迭代的修复尚未完全解决这些遗留问题。本轮需重点攻克这 3 个持续存在的问题，确保在 v5 版中彻底解决。

---

## 上一轮产出路径
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606291739_phase4_ood_continuation\a_v4_copy_from_v3.md

## 用户需求
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606291739_phase4_ood_continuation\requirement.md
