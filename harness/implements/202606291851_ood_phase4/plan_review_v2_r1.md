# 计划审查报告（v2 r1）

## 审查结果
REJECTED

## 发现

- **[严重]** plan.md 第 44~57 行 "R2 NEW Task 2+3" 节的描述内容与任务不符。标题写的是 `detail/common.cj + detail/exponential.cj`，但正文描述的是已在 R1 完成的 `stdmath_shim.cj`（Task 1）。具体来说：
  - "在 `glm.detail` 包中新建 `stdmath_shim.cj`" — stdmath_shim.cj 已在 R1 完成
  - "需要实现的包装函数（共 25 个，每个有 `T <: FloatingPoint<T>` 泛型约束）" — 这列的是 stdmath_shim.cj 的 25 个包装函数（sqrtT/expT/logT 等），而非 common.cj/exponential.cj 的函数
  - "选择理由：Stdmath_shim.cj 是所有...基石" — 这也是 R1 的理由，不是 R2 的理由
  - 该节 "上下文" 部分同样指向 stdmath_shim.cj 的细节

  此错误属于明显的复制粘贴遗漏。若后续环节（Designer/Coder）仅阅读 plan.md 而非 task_v2.md，可能被完全误导去重新实现已完成的 stdmath_shim.cj。

## 修改要求

1. **将 R2 NEW 节的内容替换为 R2 实际任务描述**：即实现 `detail/common.cj`（替换 12 个 stub + 新增 13 个标量函数 + Vec1~Vec4 重载）和 `detail/exponential.cj`（新建 7 个标量+Vec1~Vec4 函数），两者均通过 `stdmath_shim.cj` 的包装函数实现。具体的函数清单、约束策略、实现细节可引用 task_v2.md 的内容。
2. 如果 plan.md 的 R2 节仅作为进度摘要而非完整计划，也至少应确保描述内容与当前轮次任务一致，避免误导。
