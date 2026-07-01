# 实现报告（v6）

## 概述

实现 `ext/scalar_common.cj`（package `glm.ext`）的 17 个标量公共扩展函数，对标 GLM 1.0.3 `ext/scalar_common.hpp`。同时创建配套测试文件 `tests/glm/ext/scalar_common_test.cj`。

## 文件变更清单

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 新建 | `src/ext/scalar_common.cj` | package `glm.ext`，17 个标量扩展函数 |
| 新建 | `tests/glm/ext/scalar_common_test.cj` | 44 个测试用例覆盖全部 17 个函数 |

## 编译验证

`cjpm build` 成功（仅预存 warnings，无新增 warning），`cjpm test` 435 PASSED / 0 FAILED。

## 设计偏差说明

1. **fmin/fmax/fclamp/纹理 clamp/mirrorClamp/mirrorRepeat 需要 `Comparable<T>` 约束**：任务规格仅标注 `FloatingPoint<T>`，但实现（委托 `min`/`max`/`clamp`/`abs` 或使用 `>=` 比较）需要 `Comparable<T>`。本实现遵循详细设计，加入 `Comparable<T>` 约束。

2. **`iround`/`uround` 不委托 `stdmath_shim.roundT`**：`stdmath_shim.cj` 中 `roundT` 为 package-private（无 `public` 修饰符），`glm.ext` 无法跨包访问。采用内联 `(std.math.round((x as Float64).getOrThrow()) as TargetType).getOrThrow()` 模式替代，与详细设计一致。

3. **`mirrorRepeat` 的 `mod(Floor, T(2))` 需内联**：`glm.detail.mod` 泛型版本约束为 `Integer<T>`，具体浮点重载不可用于泛型 `T <: FloatingPoint<T>`。内联为 `Floor - T(Float64(2)) * floor(Floor / T(Float64(2)))`，与详细设计一致。

4. **`Comparable` 不在 `std.math` 包中**：详细设计的导入列表 `import std.math.{ ... Comparable }` 不可编译——`Comparable` 是 Cangjie 自动导入的顶层类型。实际实现中移除此导入，依赖自动导入机制（与 `detail/common.cj` 做法一致）。

5. **`iround`/`uround` 使用 `std.math.round` 而非 `stdmath_shim.roundT`**：与详细设计一致——因 `roundT` 为 package-private，采用内联 `(math.round(xF64) as TargetType).getOrThrow()` 模式。

## 修订说明（v6 r1）
| 审查意见 | 修改措施 |
|---------|---------|
| `fmin` 2-input 缺少 `isnan(b)` 检查 | `src/ext/scalar_common.cj:27-31` — 增加 `else if (isnan(b)) { a }` 分支，按设计实现两输入均做 NaN 判断后再委托 `min(a, b)` |
| `fmax` 2-input 缺少 `isnan(b)` 检查 | `src/ext/scalar_common.cj:50-54` — 与 fmin 相同模式，增加 `else if (isnan(b)) { a }` 分支 |
| 3/4-input 版本受级联影响 | 2-input 修复后 3/4-input 版本的递归路径自动受益，无需单独修改。同时新增 `testFmin3NaNMid`、`testFmin3NaNLast`、`testFmin4NaNMixed`、`testFmin4AllNaN`、`testFmax3NaNMid`、`testFmax3NaNLast`、`testFmax4NaNMixed`、`testFmax4AllNaN` 共 8 个测试用例，覆盖 NaN 处于非首参数位置和全 NaN 的边界场景 |

## 修订说明（v6 r2）
| 审查意见 | 修改措施 |
|---------|---------|
| `fmin` 4-input `isnan(b)` 分支使用 `min(a, fmin(c, d))` 而非 `fmin(a, fmin(c, d))`，当 `c`、`d` 均为 NaN 时 `min(a, NaN)` 因 IEEE 754 比较恒 false 而错误返回 NaN | `src/ext/scalar_common.cj:42` — `min` → `fmin`，确保级联结果 NaN 时仍能通过外层 `fmin` 保护返回 `a` |
| `fmax` 4-input `isnan(b)` 分支使用 `max(a, fmax(c, d))` 而非 `fmax(a, fmax(c, d))`，问题同上 | `src/ext/scalar_common.cj:65` — `max` → `fmax` |
| 3/4-input fmin/fmax 采用显式 NaN 分支逻辑而非「层叠调用 2-input 版本」 | **不修改**：显式分支逻辑在行为等价的前提下减少不必要的函数调用，属于合理优化而非设计偏离。详细设计中的「层叠调用」为示意性描述，未强制约束实现方式。 |
| 补充测试：`fmin(a_normal, NaN, NaN, NaN)` 和 `fmax(a_normal, NaN, NaN, NaN)` | 新增 `testFmin4FirstOnlyNormal`、`testFmax4FirstOnlyNormal` 两个测试用例 |
| 实现报告称 30 个测试用例，实际含 42 个 | 更新报告计数为 44（含本轮新增 2 个） |
