# 代码审查报告（v6 r1）

## 审查结果
REJECTED

## 发现

- **[严重]** `src/ext/scalar_common.cj:27-28` — `fmin` 2-input 缺少 `isnan(b)` 检查。设计指定实现路径为 `if (isnan(a)) return b; if (isnan(b)) return a; min(a, b)`，即两个输入均需做 NaN 判断。当前代码仅检查 `isnan(a)`，当 `a` 为正常值而 `b` 为 NaN 时，将落入 `min(a, b)` 分支。`glm.detail.min` 实现为 `a < b ? a : b`（`common.cj:28-32`），对 NaN 的比较结果不确定，可能返回 NaN 而非 `a`，违反 `fmin` 的核心契约（"只要有一个非 NaN 输入，则返回非 NaN 值"）。

- **[严重]** `src/ext/scalar_common.cj:48-49` — `fmax` 2-input 存在相同问题：仅检查 `isnan(a)`，缺少 `isnan(b)` 检查，与设计不符。当 `a` 正常且 `b` 为 NaN 时，`max(a, b)` 可能返回 NaN 而非 `a`。

- **[一般]** `src/ext/scalar_common.cj:31-44,52-65` — `fmin`/`fmax` 3-input 和 4-input 版本的部分递归路径（如 `fmin(b,c)`、`fmax(a,c)` 等）级联调用有缺陷的 2-input 版本，继承相同的 NaN 安全问题。例如 `fmin(1, NaN, NaN)` → `isnan(1)` 为 false → `isnan(NaN)` 为 true → `fmin(1, NaN)` → `min(1, NaN)` → 可能返回 NaN 而非 1。

## 修改要求（仅 REJECTED 时）

### 问题 1：`fmin` 2-input 缺少 `isnan(b)` 检查

**位置**：`src/ext/scalar_common.cj:27-29`

**问题**：
```cangjie
public func fmin<T>(a: T, b: T): T where T <: FloatingPoint<T> & Comparable<T> {
    if (isnan(a)) { b } else { min(a, b) }
}
```
当 `a` 正常、`b` 为 NaN 时，`min(a, b)` 的 `Comparable<T>` 比较（实现为 `a < b ? a : b`）对 NaN 行为未定义（IEEE 754 中 NaN 比较永假），可能返回 NaN，违背设计契约。

**期望修正方向**：按设计实现，增加 `isnan(b)` 检查：
```cangjie
public func fmin<T>(a: T, b: T): T where T <: FloatingPoint<T> & Comparable<T> {
    if (isnan(a)) { b }
    else if (isnan(b)) { a }
    else { min(a, b) }
}
```
或等效内联 `isnan(a) ? b : (isnan(b) ? a : (a < b ? a : b))`。

### 问题 2：`fmax` 2-input 缺少 `isnan(b)` 检查

**位置**：`src/ext/scalar_common.cj:48-50`

**问题**：与问题 1 相同模式，在 `fmax` 中仅检查 `isnan(a)`。

**期望修正方向**：
```cangjie
public func fmax<T>(a: T, b: T): T where T <: FloatingPoint<T> & Comparable<T> {
    if (isnan(a)) { b }
    else if (isnan(b)) { a }
    else { max(a, b) }
}
```

### 问题 3：级联影响

**位置**：`src/ext/scalar_common.cj:31-44,52-65`

**问题**：3-input 和 4-input 版本使用了有缺陷的 2-input 版本作为子调用。

**期望修正方向**：修复 2-input 版本后，3/4-input 版本会自动受益。无需单独修改，但建议同步审查测试用例是否覆盖了「多个输入中包含 NaN」的边界场景（当前测试仅覆盖单个 NaN 位于首参数的情况）。
