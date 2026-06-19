# 需求：将 glm-1.0.3 用仓颉重新实现 — 首轮迁移 OOD

## 背景
- 源项目：`references/glm-1.0.3` — 一个用 C++ 实现的 GLM（OpenGL Mathematics）库
- 目标语言：仓颉编程语言
- 迁移计划：`docs/01_roadmap.md` 中的首轮
- 上轮 OOD 再审议历史：
  - `harness/redeliberations/202606170050_glm-migration-ood/iteration_history.md`
  - `harness/redeliberations/202606190029_glm-migration-ood/iteration_history.md`

## 任务
执行本次迁移的 OOD（面向对象设计）：
1. 充分响应 `docs/01_roadmap.md` 中首轮的需求
2. 基于 `references/glm-1.0.3` 的架构，设计仓颉版本的架构
3. 注意避免上几轮迭代中出现的循环重复等问题
4. 产出应包含完整的架构设计，满足后续编码实现的需要
