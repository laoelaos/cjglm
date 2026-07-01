# 代码审查报告（v6 r2）

## 审查结果
REJECTED

## 发现

- **[一般]** `src/ext/scalar_common.cj:42` — `fmin` 4-input 的 `isnan(b)` 分支使用 `min(a, fmin(c, d))`，当 `c` 和 `d` 均为 NaN 时，`fmin(c,d)` 返回 NaN，然后 `min(a, NaN)` 因 `glm.detail.min` 基于 `a < b` 比较（IEEE 754 下 NaN 比较恒 false）而返回 NaN，而非正确的 `a`。违反了 fmin 的 NaN 安全契约。

- **[一般]** `src/ext/scalar_common.cj:65` — `fmax` 4-input 的 `isnan(b)` 分支同理，`max(a, fmax(c, d))` 在 `c`、`d` 均为 NaN 时错误返回 NaN。

- **[轻微]** `src/ext/scalar_common.cj:33-46,56-69` — `fmin`/`fmax` 3/4-input 实现采用显式 NaN 分支逻辑，而非详细设计指定的「层叠调用 2-input fmin/fmax」。虽然行为等价且更高效，但属于未经记录的设计偏离。

- **[轻微]** 实现报告称 30 个测试用例，实际文件含 42 个测试用例（含修订阶段新增的 8 个 NaN 边界用例），计数不一致。不影响代码正确性。

## 修改要求（仅 REJECTED 时）

### 问题 1：`fmin` 4-input `isnan(b)` 分支 NaN 安全缺陷

**位置**：`src/ext/scalar_common.cj:42`

**当前代码**：
```cangjie
else if (isnan(b)) { min(a, fmin(c, d)) }
```

**问题**：当 `a` 为非 NaN、`c` 和 `d` 均为 NaN 时，`fmin(c, d)` → `NaN`，`min(a, NaN)` → `NaN`。预期结果应为 `a`。

**期望修正**：将 `min` 替换为 `fmin`：
```cangjie
else if (isnan(b)) { fmin(a, fmin(c, d)) }
```

### 问题 2：`fmax` 4-input `isnan(b)` 分支 NaN 安全缺陷

**位置**：`src/ext/scalar_common.cj:65`

**当前代码**：
```cangjie
else if (isnan(b)) { max(a, fmax(c, d)) }
```

**问题**：同上，当 `a` 为非 NaN、`c` 和 `d` 均为 NaN 时，`fmax(a, NaN)` 因 `glm.detail.max` 的 `a > b` 比较恒 false 而返回 NaN。

**期望修正**：将 `max` 替换为 `fmax`：
```cangjie
else if (isnan(b)) { fmax(a, fmax(c, d)) }
```

### 补充测试要求

修正后应补充覆盖以下边界场景的测试用例：
- `fmin(a_normal, NaN, NaN, NaN)` — 仅第一个值为非 NaN，预期返回 `a_normal`
- `fmax(a_normal, NaN, NaN, NaN)` — 同上
