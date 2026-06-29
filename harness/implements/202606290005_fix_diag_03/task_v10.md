# 任务指令（v10）

## 动作
NEW

## 任务描述
收紧 `quaternion_common.cj` 中 `lerp` 和 `mix` 的泛型约束，从 `Number<T>` 提升至 `FloatingPoint<T>`，与 GLM `is_iec559` 静态断言对齐。

修改文件：`cjglm/src/ext/quaternion_common.cj`

具体变更：
1. `lerp`（line 16-17）：`where T <: Number<T> & Comparable<T>` → `where T <: FloatingPoint<T> & Comparable<T>`（保留 `Comparable<T>`，因 `FloatingPoint<T>` 仅扩展自 `Number<T>`，不包含 `Comparable<T>`）
2. `mix`（line 34-35）：`where T <: Number<T>` → `where T <: FloatingPoint<T>`

## 选择理由
G2.2 优先级 Medium，为当前剩余 Medium 任务中最简单的（单文件 2 行修改，无下游影响）。`mix` 为 stub 可直接收紧；`lerp` 函数体使用 `>=` / `<=` 需保留 `Comparable<T>`。grep 确认无整数 T 调用点。

## 任务上下文
- `lerp` 函数体使用 `>=`, `<=`, `as T`, `*`, `+`, `-`，均在 `FloatingPoint<T>` 约束下可用
- `mix` 函数体仅为 `throw Exception("stub")`，收紧无编译风险
- 诊断报告 §G2.2：`docs/diag/impl/03_diag.md:326-346`
- 无需更新 deviations.md（修复后与 OOD 对齐）

## 已有代码上下文
```cangjie
// quaternion_common.cj:16-17 (lerp)
@OverflowWrapping
public func lerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T): Quat<T, Q>
  where T <: Number<T> & Comparable<T>, Q <: Qualifier { ... }

// quaternion_common.cj:34-35 (mix)
public func mix<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T): Quat<T, Q>
  where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
```

---

## 修订说明（v10 r1）
| 审查意见 | 修改措施 |
|---------|---------|
| lerp 约束收紧为 `FloatingPoint<T>` 后丢失 `Comparable<T>`，需保留以满足 `>=`/`<=` | lerp 约束改为 `FloatingPoint<T> & Comparable<T>` |
| 选择理由中错误声称 `FloatingPoint<T>` 扩展自 `Comparable<T>` | 删除错误描述，说明 `FloatingPoint<T>` 仅扩展 `Number<T>`，`lerp` 需显式保留 `Comparable<T>` |
