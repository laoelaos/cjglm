# 审查进度跟踪

## 元信息

- **源分支**：`implements/202606231417_ood_phase2`
- **目标分支**：`main`
- **审查范围**：阶段二 OOD 实现（矩阵类型 + ext/ 别名 + 函数库 stub）
- **依据**：`docs/04_ood_phase2.md`
- **参考**：`docs/02_roadmap.md`、`docs/deviations.md`
- **变更规模**：164 文件 / +42800 行
- **审查开始**：2026-06-23

## 审查进度

| 轮次 | 主题 | Agent 数 | 状态 | 报告 |
|------|------|---------|------|------|
| R1 | 结构/算术/转换 | 3 | 已完成 | review_v1.md, review_v2.md, review_v3.md |
| R2 | stub/Vec×Mat/ext | 3 | 已完成 | review_v4.md, review_v5.md, review_v6.md |
| R3 | 偏差/测试/交叉 | 3 | 已完成 | review_v7.md, review_v8.md, review_v9.md |

## 总览统计

| 维度 | 严重 | 一般 | 轻微 |
|------|------|------|------|
| Round 1 | 0 | 7 | 6 |
| Round 2 | 1 | 7 | 7 |
| Round 3 | 4 | 8 | 6 |
| **合计** | **5** | **22** | **19** |
| 去重后 | **3**（其中 2 个独立） | - | - |

**注**：v6/v7/v8 三个 agent 独立识别了同一个严重问题（T5 `testIntegrationFromMatDeviation` 阻塞合并），去重后实际唯一阻塞问题 = T5 + T6 + T7，共 **3 个独立阻塞合并问题**。

## 阻塞合并问题清单（合并前必须修复）

1. **T5**：测试预期值与 OOD/实现/单元测试相反 → CI 必然失败
2. **T6**：test_scalar_mat_ops.cj 缺失 24 个非方阵测试（66.7% 覆盖缺口）
3. **T7**：test_matrix.cj 缺失 12 个 matrixCompMult/outerProduct 测试（66.7% 覆盖缺口）

## 非阻塞问题（建议下个迭代处理）

T1 ~ T4 + K1 ~ K2，详见 todo.md 和 known_issues.md。

## 整体结论

阶段二矩阵类型实现**整体质量良好**：
- 9 个矩阵类型 + 3 个 stub 函数库 + ext/ 别名 + Vec×Mat 扩展全部按 OOD 设计完成
- 171 个跨类型转换签名（fromParts 9 + fromColumns 9 + fromMat 6a 72 + fromMat 6b 72 + fromMat 7 9）完整
- Mat4x4←Mat4x2 GLM 偏差被正确实现（type_mat4x4.cj:235-239）
- D33 Bool 矩阵约束、NaN 传播、纯收缩方向 one 语义均符合 OOD
- 与 deviations.md 现有偏差记录无冲突

**不建议在 T5/T6/T7 修复前合并到 main 分支**。

## 待办（todo.md）

参见 `todo.md`

## 已知问题（known_issues.md）

参见 `known_issues.md`

## 决定摘要

（本节由主 Agent 在每轮审查后追加）

### Round 1 决定（2026-06-23）

- **R1-A1**（结构/构造/访问）：严重 0 / 一般 2 / 轻微 3 — 实现质量高，主要问题是 `init(scalar: T)` 构造函数未在 OOD §3.3 中定义（潜在新偏差） + Mat2x2 构造函数顺序与其他 8 个矩阵类型不一致。→ T1 登记偏差、T2 补充 Hashable 测试、K1 记录构造函数顺序不一致
- **R1-A2**（算术 + scalar_mat_ops）：严重 0 / 一般 3 / 轻微 2 — 27 个矩阵乘法、9 个 Mat×Vec、9 个一元负号、36 个标量-矩阵全局函数齐全，乘法公式正确，@OverflowWrapping 标注合规。→ T3 修复 `r` vs `rhs` 命名一致性、T4 补充非方阵矩阵-标量测试
- **R1-A3**（fromMat/fromParts/fromColumns）：严重 0 / 一般 2 / 轻微 1 — 144 个 fromMat 6a/6b 重载完整，T(0) 演算策略与 OOD §3.3 第 469 行一致，Mat4x4←Mat4x2 偏差被正确实现。→ K2 记录纯收缩方向 `let zero` 未使用声明的模板一致性设计选择

### Round 2 决定（2026-06-23）

- **R2-A1**（stub 函数库）：严重 0 / 一般 4 / 轻微 3 — 27 实 + 6 stub = 33 个函数签名完整，依赖闭合性满足，约束放松策略一致。
- **R2-A2**（Vec×Mat 行向量乘矩阵）：严重 0 / 一般 0 / 轻微 2 — 9 个运算符公式正确，@OverflowWrapping 一致，无歧义。
- **R2-A3**（ext/ + fwd/lib + 集成测试）：严重 **1** / 一般 3 / 轻微 2 — ⚠️ 发现阻塞合并的严重问题：`testIntegrationFromMatDeviation`（test_integration_matrix.cj:331-344）对 Mat4x4←Mat4x2 偏差方向的预期值与 OOD/实现/单元测试全部相反。→ T5 标记为阻塞合并

### Round 3 决定（2026-06-23）

- **R3-A1**（已知偏差处理）：严重 **1** / 一般 0 / 轻微 2 — Mat4x4←Mat4x2 偏差实现与单元测试正确，但集成测试 `testIntegrationFromMatDeviation` 仍未修复（与 T5 同问题）。D33 Bool 矩阵约束、NaN 传播、纯收缩 `one` 语义均符合 OOD。
- **R3-A2**（测试覆盖率）：严重 **3** / 一般 6 / 轻微 2 — ⚠️ 新增 2 个阻塞合并的严重测试覆盖缺口：scalar_mat_ops.cj 非方阵测试 66.7% 缺失、matrix.cj 的 matrixCompMult/outerProduct 仅 33.3% 覆盖。→ T6、T7 标记为阻塞合并
- **R3-A3**（偏差文档交叉）：严重 0 / 一般 2 / 轻微 2 — 阶段二实现未引入新偏差，未违反已有偏差。需新增 DEV-15 记录 `init(scalar: T)` 全填充构造函数（OOD 未列出但 9 个矩阵类型均实现）。→ T1 已涵盖此偏差登记