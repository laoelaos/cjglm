# 详细设计（v6）

## 概述

将 `type_mat2x2.cj` 中 3 个构造函数的声明顺序调整为与其他 8 个矩阵类型一致，仅涉及代码块重排，不改变任何行为。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `cjglm/src/detail/type_mat2x2.cj` | 修改 | 调整 struct 内 3 个构造函数声明顺序 |

## 操作说明

将 `Mat2x2` struct 体内的构造函数块从当前顺序：

```
1. public init(scalar: T)
2. public const init(a00: T, a01: T, a10: T, a11: T)
3. public const init(c0: Vec2<T, Q>, c1: Vec2<T, Q>)
```

调整为目标顺序（与其他矩阵类型一致）：

```
1. public const init(a00: T, a01: T, a10: T, a11: T)   // 逐分量 const init
2. public const init(c0: Vec2<T, Q>, c1: Vec2<T, Q>)   // 列向量 const init
3. public init(scalar: T)                                // 标量非 const init
```

## 行为契约

- 无行为变更：仓颉函数重载解析与声明顺序无关
- 仅风格一致性调整

## 依赖关系

- 无新增/修改依赖
- 无外部依赖变更
