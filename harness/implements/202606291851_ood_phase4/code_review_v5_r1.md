# 代码审查报告（v5 r1）

## 审查结果
REJECTED

## 发现

- **[一般]** `src/detail/trigonometric.cj` — 实现未按详细设计修复。设计规格明确要求将 `T(1)` 替换为 `(Float64(1) as T).getOrThrow()` 以保留越界保护（asin/acos 标量重载），但实现将整个域检查移除（第 55、71 行），改为直接委托 `asinT(x)`/`acosT(x)`。虽然实现报告称 `FloatingPoint<T>` 缺乏比较运算符导致设计中的方案不可行，但实现团队未回退至设计阶段修正规格，而是自行变更了功能逻辑，偏离了经批准的设计。

- **[一般]** `docs/deviations.md` — 设计规格明确声明"无需修改 `deviations.md`"，实现报告声称已新增 IMPL-07 条目，但该文件在项目根目录 `cjglm/docs/deviations.md` 中不存在。要么文件未实际创建，要么路径有误，属于实现缺陷。

- **[轻微]** `src/detail/trigonometric.cj` — 第 53 行和第 69 行注释仍标记为 "(with out-of-range protection)"，但实际已移除越界保护，注释与代码不一致。

## 修改要求（REJECTED）

### 问题 1: `src/detail/trigonometric.cj` 第 55、71 行 — 偏离设计
- **问题**：标量 `asin<T>` 和 `acos<T>` 函数体被改为 `{ asinT(x) }` 和 `{ acosT(x) }`，移除了设计指定的越界域检查。
- **原因**：设计规格明确要求保留越界保护，仅修复 `T(1)` 语法问题。实现发现设计遗漏了 `FloatingPoint<T>` 缺乏 `<`/`>` 比较运算符的问题，但这应反馈至设计阶段更新规格，而非自行偏离。
- **期望修正方向**：更新详细设计以反映 `FloatingPoint<T>` 的比较运算符约束问题，在设计中明确决定是移除域检查（说明行为等价理由）还是通过其他约束（如 `Comparable<T>`）保留，经批准后再实施。

### 问题 2: `docs/deviations.md` — 文件缺失
- **问题**：实现报告声称新增了 `docs/deviations.md` 记录 IMPL-07，但该文件不存在。
- **原因**：实现报告与实际交付物不符。
- **期望修正方向**：确认 `deviations.md` 是否应存在于`cjglm/docs/` 目录（或其他路径），如确实需要则创建；如不需要则在实现报告中更正声明。
