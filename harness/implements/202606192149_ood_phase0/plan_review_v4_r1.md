# 计划审查报告（v4 r1）

## 审查结果
REJECTED

## 发现

- **[严重]** 计划提出的修复方案（为 `fromBoolVec`/`fromBoolVecQ2` 的 8 个函数添加 `where T <: Number<T>` 约束）不能解决编译错误。代码库已有明确先例证明 `T(1)` 在 `Number<T>` 约束下仍然不可编译。

  证据链：
  1. `code_review_v3_r2.md:8` — `increment()`/`decrement()` 的审查指出"因仓颉语言限制 `T(1)` 无法在泛型上下文中编译"，要求移除而非约束修复。
  2. `code_review_v3_r2.md:17` — 明确说明"仓颉语言当前不支持泛型类型 T 从字面量构造（`T(1)` 不合法）"。
  3. `code_v3.md:27` — `increment()`/`decrement()` 最终被整体移除，原因是"语言限制，`T(1)` 不可编译"。
  4. 当前代码库中 `Number<T>` extend 块（如 `type_vec1.cj:41`）仅使用 `this.x + rhs.x` 等算术运算，不存在任何使用 `T(1)` 成功编译的先例。

  根本原因：`Number<T>` 接口提供算术运算符但不提供 `()` 构造调用。仓颉编译器禁止对暴露的泛型参数 T 调用 `T(n)` 构造表达式，无论约束是否为 `Number<T>`。

- **[严重]** 任务 v4 提出的修正方向与同一代码库 v3 轮次已验证的结论矛盾，形成自相矛盾的修复策略。

## 修改要求（仅 REJECTED 时）

**必须更换修复方案**，`T(1)`/`T(0)` 在泛型上下文中不可用是仓颉编译器的已知语言限制，不应重复尝试用 `Number<T>` 约束解决。以下替代方案供选择：

1. **方案 A（推荐）**：变更 `fromBoolVec` API，将 `zero` 和 `one` 值作为额外参数传入，完全避免泛型字面量构造。例如：
   ```cangjie
   public func fromBoolVec<T, Q>(v: Vec1<Bool, Q>, zero: T, one: T): Vec1<T, Q> where Q <: Qualifier {
       return Vec1(if (v.x) { one } else { zero })
   }
   ```
   此方案无任何约束要求，且与 D5 延迟检查策略兼容。

2. **方案 B**：若方案 A 不可接受（API 变更过大），则与 `increment()`/`decrement()` 一致处理——从本轮交付中移除 `fromBoolVec`/`fromBoolVecQ2`，记录为已知语言限制，待编译器支持泛型字面量构造后恢复。

3. **方案 C**：创建项目级 `FromIntLiteral<T>` 接口（提供 `fromInt(Int64): T` 静态方法），为各数值类型实现后以 `T::fromInt(1)` 替代 `T(1)`。此方案需评估实现工作量。
