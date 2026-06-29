# 设计审查报告（v2 r4）

## 审查结果
REJECTED

## 发现

- **[一般]** 设计偏差章节不完整，未全面覆盖与 `task_v2.md` 规范的偏离。
  `detail_v2.md` §"设计偏差"章节只记录了 `init<Q2>` → `fromQual<Q2>` 一项偏离，但以下与 `task_v2.md` 的差异同样存在且未在该章节声明：

  | 差异项 | task_v2.md 要求 | detail_v2.md 实际 |
  |-------|----------------|-------------------|
  | `fromQuat` | `public func`（实例方法） | `public static func` |
  | `fromMat3` | `public func`（实例方法） | `public static func` |
  | `fromMat4` | `public func`（实例方法） | `public static func` |
  | `init(s: T, v: Vec3)` | `const init` | `init`（非 const） |

  这些变更分别在"修订说明（v2 r2）"和"修订说明（v2 r3）"中有记载，但设计偏差章节作为正式、集中的偏差声明位置，应涵盖所有与任务规范的差异。仅记载一项而遗漏其余四项，会导致读者无法从独立偏差章节全面了解设计对任务规范的偏离情况。

  **修正方向**：在"设计偏差"章节中补全上述四项偏差，每项说明偏差原因（如静态工厂语义更清晰、与 Vec 类型 `init` 风格一致等），与现有 `init<Q2>` 偏差条目并列。

- **[轻微]** `operator ==` 的实现策略未明确。
  现有 Vec3/Mat3x3 类型的 `==` 运算符通过 `ComputeEqual<T>.call()` 实现以确保浮点 NaN 语义正确处理。`detail_v2.md` §比较运算符仅声明了 `operator func ==(rhs: Quat<T, Q>): Bool` 的签名，未指定实现策略。若实现时直接使用分量级 `==` 而非 `ComputeEqual<T>.call()`，可能导致与 Vec/Mat 类型比较语义不一致。

  **修正方向**：明确指定 `==` 实现使用 `ComputeEqual<T>.call()` 逐分量比较，与现有 Vec/Mat 类型保持一致。

## 修改要求

1. 在设计偏差章节补全所有与 `task_v2.md` 的偏离（`fromQuat`/`fromMat3`/`fromMat4` 实例→静态、`const init`→非 `const init`），对每项说明偏差原因。
2. 明确 `operator ==` 的实现策略为使用 `ComputeEqual<T>.call()`（或注明由实现者参照 Vec3 风格自行确定）。
