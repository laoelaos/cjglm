# 设计审查报告（v11 r1）

## 审查结果
REJECTED

## 发现

- **[严重]** 组 3（sub/mul/div/mod 包级函数可达性）全部 4 个函数的"函数调用"列中，`v` 在 `Vec2<Int64, PackedHighp>(...)` 赋值之前就被引用，且赋值缺少 `let` 关键字。参照 `testLibAddScalarVec` 及仓颉语法规则，变量必须先声明再使用，且首次声明必须加 `let`（不可变）或 `var`（可变）。例如 `testLibSubScalarVec` 的设计片段：

  ```
  let r = sub(Int64(10), v); v = Vec2<Int64, PackedHighp>(Int64(1), Int64(2))
  ```

  应修正为：

  ```
  let v = Vec2<Int64, PackedHighp>(Int64(1), Int64(2))
  let r = sub(Int64(10), v)
  ```

  此项缺陷将直接导致编译失败，必须在编码前修正。

## 修改要求

1. **组 3 全部 4 个函数**：调整声明顺序，将 `let v = Vec2<Int64, PackedHighp>(...)` 移至 `let r = func(...)` 之前，并为 `v` 补上 `let` 关键字。
