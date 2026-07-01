# 设计审查报告（v9 r2）

## 审查结果
REJECTED

## 发现

- **[严重]** G20 — asinh 断言使用非法类型比较：`@Expect(abs(r.y - Float64(0.881373587019543)), true)` 中，`abs()` 返回 `Float64`，而 `true` 是 `Bool`。仓颉 `@Expect(a, b)` 要求 `a` 实现 `Equatable<B>`，但 `Float64` 未实现 `Equatable<Bool>`，将导致编译错误。同样的错误出现在 line 225 `@Expect(abs(r.z - Float64(-0.881373587019543)), true)`。应改为 `@Expect(abs(r.y - Float64(0.881373587019543)) < Float64(1e-12), true)` 或使用 delta 近似断言。

- **[严重]** G20 — acosh/atanh 断言不完整：`testAcoshVec3NonZero` 和 `testAtanhVec3NonZero` 仅有 `r.x` 断言和注释中的近似值，缺少对非零分量的实际 `@Expect` 断言。设计必须以可编码的精确形式给出断言（含类型和容差），而非仅标注计算方式。

## 修改要求

1. **G20 asinh 断言**：将 `@Expect(abs(r.y - ...), true)` 改为带有容差的布尔断言，例如 `@Expect(abs(r.y - Float64(0.881373587019543)) < Float64(1e-12), true)`，或在 asinh/acosh/atanh 中统一定义容差 epsilon 并一致使用。

2. **G20 acosh/atanh 断言补全**：为所有非零分量补充具体断言，至少与 asinh 保持相同设计粒度（值 + 容差检查），确保编码阶段可直接实现、无需回头补充设计。
