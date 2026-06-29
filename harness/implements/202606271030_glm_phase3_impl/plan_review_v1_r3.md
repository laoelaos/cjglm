# 计划审查报告（v1 r3）

## 审查结果
REJECTED

## 发现

- **[严重]** `cos_one_over_two<T>()` 计算公式数学错误——plan.md:33 和 task_v1.md 修订说明中描述 `cos_one_over_two<T>()` 通过 `cos(pi<T>() / T(Float64(4)))` 计算，即 `cos(π/4) ≈ 0.70710678`。但 ground truth 值为 `0.877582561890372716`，对应的是 `cos(0.5)` = `cos(1/2)`。公式 `cos(π/4) ≠ cos(0.5)`，计算值偏差约 24%，将导致 R1 编码实现数学上不正确。同时该方法与 OOD §3.12 line 806 "使用具体类型硬编码值" 的明确要求相矛盾。

## 修改要求（仅 REJECTED 时）

- **[严重] `cos_one_over_two<T>()` 公式修正**：删除 `cos(pi<T>() / T(Float64(4)))` 公式。应改为硬编码值策略（与 OOD §3.12 line 806 一致）：通过 `match (T(Float64(0)))` 运行时分派，对 `Float32` 返回 `Float32(0.877582561890372716)`，对 `Float64` 返回 `Float64(0.877582561890372716)`；或将公式修正为 `cos(T(Float64(0.5)))`（当确认 `std.math.cos` 对泛型 `T <: FloatingPoint<T>` 的重载解析在运行时能正确分派时）。plan.md 和 task_v1.md 中所有相关描述（实施路线 R1 上下文、详细任务段落、修订说明）须同步修正。
