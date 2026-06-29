# 设计审查报告（v3 r1）

## 审查结果
REJECTED

## 发现

- **[严重]** `normalize` 约束缺失 `Comparable<T>`：约束仅为 `where T <: FloatingPoint<T>`，但函数体内 `length(q) <= T(Float64(0))` 使用了 `<=` 运算符。仓颉中 `FloatingPoint<T>` 并不隐含 `Comparable<T>`，需改为 `where T <: FloatingPoint<T> & Comparable<T>`，否则无法通过编译。

- **[严重]** `lerp` 约束缺失 `Comparable<T>`：约束为 `where T <: Number<T>`，但 `assert(a >= T(0) && a <= T(1))` 使用了 `>=`/`<=`。需补充 `Comparable<T>` 约束。

- **[严重]** `conjugate` 声称"无约束"但必有约束：`const func conjugate<T, Q>(q: Quat<T, Q>): Quat<T, Q>` 的函数体包含 `-q.x`/`-q.y`/`-q.z` 一元负号运算，这要求 `T <: Number<T>`。需补充至少 `where T <: Number<T>`（且 `const` 下 `Number<T>` 的负号运算符需为 `const` 兼容）。

- **[一般]** `testAxisZeroQuat` 测试预期自相矛盾：标题标注期望 `(0,0,1)`，但备注分析指出零四元数时 `tmp1 = 1 - 0 = 1 > 0` 进入 else 分支，结果为 `Vec3(0,0,0)`。测试预期与设计实现逻辑不一致，需确定正确的期望值。

- **[轻微]** `lerp` 缺少 assert 边界测试：测试覆盖了 `a=0/1/0.5` 正例，但未覆盖 `a` 超出 `[0,1]` 范围时 assert 触发的负例路径。

- **[轻微]** 矩阵 stub 文件依赖不完整：`matrix_projection`/`matrix_clip_space`/`matrix_transform` 的依赖段未列出 `Mat4x4<T,Q>`（glm.detail），而函数返回类型使用了该类型。

## 修改要求（仅 REJECTED 时）

1. **[严重] normalize**: 将约束 `where T <: FloatingPoint<T>, Q <: Qualifier` 改为 `where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier`。

2. **[严重] lerp**: 将约束 `where T <: Number<T>, Q <: Qualifier` 改为 `where T <: Number<T> & Comparable<T>, Q <: Qualifier`。

3. **[严重] conjugate**: 补充约束 `where T <: Number<T>, Q <: Qualifier`；同时验证 `const func` 声明与 `Number<T>` 一元负号的 const 兼容性，若不可行则移除 `const`。

4. **[一般] testAxisZeroQuat**: 明确期望结果：按照 axis 实现逻辑，零四元数时 `tmp1=1>0` 进入 else，计算结果为 `(0,0,0)`。测试应修正期望值为 `Vec3(T(Float64(0)), T(Float64(0)), T(Float64(0)))`。
