# 设计审查报告（v3 r1）

## 审查结果
REJECTED

## 发现

- **[一般]** 设计使用 `common.cj` 中的 `abs` 函数，但该函数是未实现的桩代码（`common.cj:7` — `throw Exception("stub")`），调用时会抛出异常，导致全部 7 个测试运行时失败。该函数在整个代码库中未被任何其他代码使用，确认为未完成实现。

## 修改要求

**问题**：`mat3EqualEpsilonRelaxed` 中调用了 `abs(a.c0.x - b.c0.x)` 等表达式，解析到 `glm.detail.common` 包中的 `abs` 函数，其实现为 `throw Exception("stub")`，无法正常计算绝对值。

**期望修正方向**：采用 task_v3.md 预期代码中的手动绝对值计算方式（`if (d < z) { -d } else { d }`），避免依赖 `common.cj` 的桩代码；或显式导入 `std.math.*` 并使用标准库 `abs` 实现。
