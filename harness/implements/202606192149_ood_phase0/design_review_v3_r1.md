# 设计审查报告（v3 r1）

## 审查结果
REJECTED

## 发现

- **[严重]** Vec2/Vec3/Vec4 的 extend 块中 `<<(shift: T)` 和 `>>(shift: T)` 被重复定义——在主位运算段（lines 198-199）和标量右操作数段（lines 227-228）各出现一次，签名完全相同。在 Cangjie 中，同一类型的相同运算符签名不可重复定义，这将导致编译错误。该问题通过 "同 Vec2 模式" 描述延伸至 Vec3 和 Vec4 的 extend 块。

- **[轻微]** `scalar_vec_ops.cj` 的函数签名未声明 `const`，与 task_v3.md §4.3 明确要求"声明为 `const` 函数以支持编译期调用"不符。虽不影响运行时正确性，但属于任务规格的遗漏。

## 修改要求（仅 REJECTED 时）

### 严重问题 1：`<<(shift: T)` / `>>(shift: T)` 重复定义
- **问题**：Vec2 extend 块中 `<<(shift: T): Vec2<T, Q>` 和 `>>(shift: T): Vec2<T, Q>` 在主位运算段和标量右操作数段各出现一次，为完全相同的签名，编译期会报重复定义错误。Vec3/Vec4 同理。
- **修正方向**：任选一种方案：**方案A**（推荐，对齐 task 模板）：将主位运算段的 `<<(shift: T)` 改为 `<<(rhs: Vec2<T, Q>)` 以实现 Vec-Vec 版本的分量间移位，保留标量段的 `<<(shift: T)`；**方案B**：保留主位运算段的 `<<(shift: T)`，删除标量段的重复定义。任选一方案后，需确保 Vec3/Vec4 一致修改。

### 轻微问题 2：scalar_vec_ops 缺少 `const`
- **问题**：`scalar_vec_ops.cj` 的 20 个函数签名均未标注 `const`，与 task 要求不符。
- **修正方向**：为每个函数签名添加 `const` 关键字，如 `public func add<T, Q>(s: T, v: Vec1<T, Q>): Vec1<T, Q> where Q <: Qualifier`。
