# 任务指令（v5）

## 动作
RETRY

## 任务描述
修复 `src/detail/trigonometric.cj` 的编译错误（2 处 `T(1)` → `(Float64(1) as T).getOrThrow()`），使测试通过。

## 选择理由
Task 5（trigonometric.cj 完整实现）在 v4 中已实现全部 75 函数并编写了 111 个 @Test，但因 2 处 `T(1)` 语法在泛型中不可用导致编译失败。只需简单修复即可通过。

## 任务上下文
- 文件：`src/detail/trigonometric.cj`
- 行 56：`if (x < -T(1) || x > T(1)) { return T.getNaN() }` — asin 越界保护
- 行 75：`if (x < -T(1) || x > T(1)) { return T.getNaN() }` — acos 越界保护
- 需改为：`(Float64(1) as T).getOrThrow()` 模式

## 已有代码上下文
`src/detail/exponential.cj:14` 已使用相同模式通过编译：
```cangjie
let o: T = (Float64(1) as T).getOrThrow()
o / sqrtT(x)
```
`src/detail/common.cj` 中也有 16 处使用 `(Float64(n) as T).getOrThrow()` 模式。

## RETRY 说明
**失败原因**：仓颉编译器不支持 `T(1)` 语法（`'()' is not a static member of exposed generic parameter 'T'`），因为泛型参数 `T <: FloatingPoint<T>` 不保证有 `()` 构造器。`trigonometric.cj` 在 asin/acos 的越界保护中使用 `T(1)` 构造字面量 1，导致编译错误。

**修正方向**：将第 56 行和第 75 行的：
- `-T(1)` → `-(Float64(1) as T).getOrThrow()`
- `T(1)` → `(Float64(1) as T).getOrThrow()`

已验证 `exponential.cj` 的 `inversesqrt`（第 14 行）使用 `(Float64(1) as T).getOrThrow()` 模式通过编译和测试。修复后应重新运行 `cjpm build && cjpm test` 确认三角函数测试全部通过。
