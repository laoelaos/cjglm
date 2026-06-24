# 详细设计（v1）

## 概述

为阶段二的矩阵类型提供函数库依赖闭合。创建两个纯 stub 文件 `common.cj` 和 `geometric.cj`（`package glm.detail`），共计 12 + 17 = 29 个 stub 函数签名。所有函数体统一为 `{ throw Exception("stub") }`，供 type_mat3x3/type_mat4x4 等方阵类型的 .inl 实现编译链接。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| src/detail/common.cj | 新建 | 基础数学函数 stub（12 个标量函数，各 1 重载） |
| src/detail/geometric.cj | 新建 | 几何函数 stub（6 组函数，共 17 重载） |

## 函数定义

### common.cj 函数表

所有函数为 `package glm.detail` 包级 `public func`，函数体 `{ throw Exception("stub") }`。

| # | 签名 | 约束 |
|---|------|------|
| 1 | `public func min<T>(a: T, b: T): T` | `T <: Number<T> & Comparable<T>` |
| 2 | `public func max<T>(a: T, b: T): T` | `T <: Number<T> & Comparable<T>` |
| 3 | `public func abs<T>(a: T): T` | `T <: Number<T> & Comparable<T>` |
| 4 | `public func sign<T>(a: T): T` | `T <: Number<T> & Comparable<T>` |
| 5 | `public func floor<T>(a: T): T` | `T <: Number<T>` |
| 6 | `public func ceil<T>(a: T): T` | `T <: Number<T>` |
| 7 | `public func fract<T>(a: T): T` | `T <: Number<T>` |
| 8 | `public func mod<T>(a: T, b: T): T` | `T <: Integer<T>`（因 Number<T> 无 `%` 运算符，参见 DV-02） |
| 9 | `public func clamp<T>(a: T, minVal: T, maxVal: T): T` | `T <: Number<T> & Comparable<T>` |
| 10 | `public func mix<T>(a: T, b: T, t: T): T` | `T <: Number<T>` |
| 11 | `public func step<T>(edge: T, x: T): T` | `T <: Number<T> & Comparable<T>` |
| 12 | `public func smoothstep<T>(edge0: T, edge1: T, x: T): T` | `T <: Number<T> & Comparable<T>` |

### geometric.cj 函数表

所有函数为 `package glm.detail` 包级 `public func`，泛型约束统一为 `T <: Number<T>, Q <: Qualifier`，函数体 `{ throw Exception("stub") }`。

**dot**（4 重载）：
| # | 签名 |
|---|------|
| 1 | `public func dot<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>): T` |
| 2 | `public func dot<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>): T` |
| 3 | `public func dot<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>): T` |
| 4 | `public func dot<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>): T` |

**cross**（1 重载）：
| # | 签名 |
|---|------|
| 5 | `public func cross<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>): Vec3<T, Q>` |

**normalize**（3 重载，不含 Vec1）：
| # | 签名 |
|---|------|
| 6 | `public func normalize<T, Q>(v: Vec2<T, Q>): Vec2<T, Q>` |
| 7 | `public func normalize<T, Q>(v: Vec3<T, Q>): Vec3<T, Q>` |
| 8 | `public func normalize<T, Q>(v: Vec4<T, Q>): Vec4<T, Q>` |

**length**（3 重载，不含 Vec1）：
| # | 签名 |
|---|------|
| 9 | `public func length<T, Q>(v: Vec2<T, Q>): T` |
| 10 | `public func length<T, Q>(v: Vec3<T, Q>): T` |
| 11 | `public func length<T, Q>(v: Vec4<T, Q>): T` |

**distance**（3 重载，不含 Vec1）：
| # | 签名 |
|---|------|
| 12 | `public func distance<T, Q>(p0: Vec2<T, Q>, p1: Vec2<T, Q>): T` |
| 13 | `public func distance<T, Q>(p0: Vec3<T, Q>, p1: Vec3<T, Q>): T` |
| 14 | `public func distance<T, Q>(p0: Vec4<T, Q>, p1: Vec4<T, Q>): T` |

**reflect**（3 重载，不含 Vec1）：
| # | 签名 |
|---|------|
| 15 | `public func reflect<T, Q>(I: Vec2<T, Q>, N: Vec2<T, Q>): Vec2<T, Q>` |
| 16 | `public func reflect<T, Q>(I: Vec3<T, Q>, N: Vec3<T, Q>): Vec3<T, Q>` |
| 17 | `public func reflect<T, Q>(I: Vec4<T, Q>, N: Vec4<T, Q>): Vec4<T, Q>` |

## 错误处理

所有 stub 函数统一抛出 `Exception("stub")`。调用方需在阶段四实现替换后处理实际异常情况（如除零、无效参数等）。本阶段不做任何输入验证，stub 仅用于依赖闭合。

## 行为契约

- 所有函数为纯占位符，无实际计算行为
- 函数体仅包含单行 `throw Exception("stub")`
- 调用任意 stub 函数将在运行时抛出异常
- 包内同可见性：与 Vec1~Vec4 类型同属 `package glm.detail`，自动可见，无需 import
- `mod<T>` 的约束为 `Integer<T>` 而非 OOD 文档中的 `Number<T>`，因 `Number<T>` 不提供 `%` 运算符（参见 deviations.md DV-02）
- geometric.cj 不包含 Vec1 版本 normalize/length/distance/reflect，不包含 Vec2 cross（2D 叉积推迟至阶段六）
- common.cj 仅包含标量版本（T），向量版本推迟至阶段四

## 依赖关系

| 方向 | 说明 |
|------|------|
| common.cj → 无 | 无包内依赖 |
| geometric.cj → Vec1~Vec4 | 引用 `glm.detail` 包内 VecN 类型（同包自动可见） |
| type_mat3x3 → common.cj | .inl 实现依赖 common.cj 的 min/max/clamp/mix/smoothstep 等标量函数 |
| type_mat4x4 → geometric.cj | .inl 实现依赖 geometric.cj 的 dot/length/distance/normalize/reflect 等几何函数 |
