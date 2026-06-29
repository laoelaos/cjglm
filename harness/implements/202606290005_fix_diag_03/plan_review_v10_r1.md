# 计划审查报告（v10 r1）

## 审查结果
REJECTED

## 发现

- **[严重]** G2.2 lerp 约束收紧方案不可编译：计划声称 `FloatingPoint<T>` 已扩展自 `Number<T>` 和 `Comparable<T>`，但官方 std 文档显示 `FloatingPoint<T>` **仅**扩展 `Number<T>`，不扩展 `Comparable<T>`。`lerp` 函数体第 20 行使用 `a >= zero && a <= one` 比较运算符，需要 `Comparable<T>` 约束。若按计划将 `where T <: Number<T> & Comparable<T>` 改为 `where T <: FloatingPoint<T>`，则编译失败（`Comparable<T>` 约束丢失）。`Float64` 等具体类型是通过独立的 `extend Float64 <: Comparable<Float64>` 实现 `Comparable`，而非通过 `FloatingPoint` 接口继承。

- **[一般]** `mix` 约束收紧 (`Number<T>` → `FloatingPoint<T>`) 无问题，因 `mix` 函数体为 `throw Exception("stub")`，不依赖 `Comparable`，且 `FloatingPoint<T> <: Number<T>` 成立。

## 修改要求

1. **lerp 约束**：改为 `where T <: FloatingPoint<T> & Comparable<T>`，保留 `Comparable<T>` 以满足 `>=` / `<=` 运算符需求。或验证目标编译器中 `FloatingPoint<T>` 是否确实扩展了 `Comparable<T>`（与官方文档不符时需记录偏差）。
2. **计划文档修正**：修正关于 `FloatingPoint<T>` 继承关系的错误描述，当前声称"已扩展自 Number\<T> 和 Comparable\<T>"与官方 std 文档不符。`Float16/Float32/Float64` 各自独立实现 `FloatingPoint` 和 `Comparable` 两个接口，`FloatingPoint` 本身不继承 `Comparable`。
