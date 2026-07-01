# 详细设计（v5）——修复轮次

## 概述

修复 `src/detail/trigonometric.cj` 中 2 处 `T(1)` 编译错误。v4 已实现全部 75 个三角函数重载并编写 111 个 `@Test`，但因 `T(1)` 语法在泛型上下文中不被仓颉支持（`'()' is not a static member of exposed generic parameter 'T'`），导致编译失败。

本轮仅修复此 2 处语法问题，不改变任何功能逻辑、测试文件或接口签名。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| src/detail/trigonometric.cj | 修改（2 行） | 将 asin/acos 越界保护中的 `T(1)` 替换为 `(Float64(1) as T).getOrThrow()` |

## 修改清单

### `src/detail/trigonometric.cj`

**第 56 行（asin）**：

```cangjie
// 原（编译错误）：
if (x < -T(1) || x > T(1)) { return T.getNaN() }

// 改后：
if (x < -(Float64(1) as T).getOrThrow() || x > (Float64(1) as T).getOrThrow()) { return T.getNaN() }
```

**第 75 行（acos）**：

```cangjie
// 原（编译错误）：
if (x < -T(1) || x > T(1)) { return T.getNaN() }

// 改后：
if (x < -(Float64(1) as T).getOrThrow() || x > (Float64(1) as T).getOrThrow()) { return T.getNaN() }
```

## 参考实现

此模式已在同项目的 `src/detail/exponential.cj:14` 和 `src/detail/common.cj` 中多次验证通过：

```cangjie
// exponential.cj:14
let o: T = (Float64(1) as T).getOrThrow()
o / sqrtT(x)
```

## 类型与依赖关系

无变化——与 v4 设计完全一致。`FloatingPoint<T>` 泛型约束下，`(Float64(1) as T).getOrThrow()` 模式是已知可行的构造 `T` 类型字面量的方法。

## 其他说明

- 无需修改测试文件：测试代码已在 v4 中编写完毕，不涉及 `T(1)` 语法
- 无需修改 `deviations.md`：`T(1)` 不可用是已有偏差（DV-01 所述 `T(n)` 构造限制），本次修复不引入新偏差
- 编译验证：修复后执行 `cjpm build && cjpm test` 应全部通过

## 修订说明（v5 R1）

| 审查意见 | 修改措施 |
|---------|---------|
| 首次设计（无审查反馈） | 直接基于 task_v5.md 和 verify_v4.md 的编译错误描述，定位到 2 处 `T(1)` 语法问题，参照已有代码模式（`exponential.cj`/`common.cj`）给出修复方案 |
