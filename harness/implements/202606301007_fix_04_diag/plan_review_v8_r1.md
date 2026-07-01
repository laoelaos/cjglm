# 计划审查报告（v8 r1）

## 审查结果
APPROVED

## 发现

无严重、无一般问题。计划正确可行。

### 关键验证点确认

1. **代码变更正确性** — `(x.toBits() as Int32)` → `(x.toBits() as Int32).getOrThrow()` 模式与 `detail/common.cj:342` 的 `floatBitsToInt` 完全一致。`common_test.cj:700` 已验证该模式对负浮点数（`-2.0f32`）位模式也可以安全展开 `Option`，证明 Cangjie 同宽度整型的 `as` 转换做的是位级重解释而非值域检查。

2. **G9 修复状态** — `round.cj:10,31,49` 三处 `return x` 已就位，`round_test.cj:88-101` 三个 `-0.0` 位模式对比测试已就位，`04_diag.md:483` G9 已标记 `✅ 已修复`。

3. **编译错误根治** — `ulp.cj:57` 的 `abs(a - b)` 在 `a,b` 展开为 `Int32` 后（而非之前的 `Option<Int32>`）可正常编译，且 `@OverflowWrapping` 属性已覆盖两个 `float_distance` 函数，减法溢出安全。

4. **验证策略** — 全量 `cjpm test` 编译通过即可确认 P2-5 完成，plan.md 路线表 v8 列更新 P2-5 ✅。
