# 计划审查报告（v10 r1）

## 审查结果
REJECTED

## 发现

- **[一般]** Vec1 `refract` 函数不存在，G22 的 `testRefractVec1` 不可实现
  `src/detail/geometric.cj` 中 `refract` 仅有 Vec2/Vec3/Vec4 三个重载（:77, :88, :99），没有 Vec1 版本。如果直接调用 `refract(Vec1<T,Q>, Vec1<T,Q>, T)` 将导致编译失败。计划第 132 行要求实施 "Vec1 维折射测试" 但未识别此前置依赖。
  
  修正方向：方案 A——G22 的 Vec1 测试不可行，应改为 Vec2/Vec3/Vec4 补充多维度全内反射测试即可；方案 B——若确实需要 Vec1 折射测试，必须先在 `geometric.cj` 中新增 `refract` 的 Vec1 重载（纳入同一批次任务范围）。

- **[轻微]** 计划未提及更新 plan.md 路线表
  task_v10.md:37 明确要求 "plan.md 路线表需更新 v10 列 P4-2 标记"，但计划第 132 行仅提到更新 `04_diag.md`，未包含此步骤。应在计划中补充路线表更新步骤。

## 修改要求（仅 REJECTED 时）

1. **[一般]** Vec1 refract 不存在：请选择方案 A（仅测 Vec2/Vec3/Vec4 全内反射补充）或方案 B（同时新增 Vec1 refract 生产代码），并在计划中明确声明所选方案。
2. **[轻微]** 补充 plan.md 路线表更新步骤。
