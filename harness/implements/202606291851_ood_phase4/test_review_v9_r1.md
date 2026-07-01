# 测试审查报告（v9 r1）

## 审查结果
REJECTED

## 发现

- **[一般]** `tests/glm/gtc/ulp_test.cj` — `testUlpBoundary` 未包含 `ulp(Float32.nan)` / `ulp(Float64.nan)` 测试用例。设计规格第327行明确要求覆盖 `ulp(Inf)/ulp(NaN)/ulp(0)` 边界。
- **[一般]** `tests/glm/gtc/round_test.cj` — `testRoundMultiple` 命名对应的设计规格（第336行）要求覆盖「倍数边界、NaN/Inf/零值/负数」，但实际测试：
  * `roundMultiple`：仅覆盖零值和正数，缺少 NaN/Inf/负数
  * `ceilMultiple`：仅覆盖零值和正数，缺少负数
  * `floorMultiple`：仅覆盖零值和正数，缺少负数

## 修改要求

1. **`tests/glm/gtc/ulp_test.cj`** — 在 `testUlpBoundary` 中增加：`@Expect(ulp(Float32.nan).isNaN(), true)` 和 `@Expect(ulp(Float64.nan).isNaN(), true)`（或类似断言），与设计规格中的 NaN 边界要求对齐。

2. **`tests/glm/gtc/round_test.cj`** — 在 `testRoundMultiple` 或新增测试函数中增加：
   - `roundMultiple(Float64.nan, Float64(2))` → NaN 断言
   - `roundMultiple(Float64.infinity(), Float64(2))` → Inf 断言
   - `roundMultiple(Float64(-3.0), Float64(2.0))` 等负数用例
   - `ceilMultiple(Float64(-3.0), Float64(2.0))` 等负数用例
   - `floorMultiple(Float64(-3.0), Float64(2.0))` 等负数用例
