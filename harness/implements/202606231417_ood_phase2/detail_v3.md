# 详细设计（v3）

## 概述

实现 `src/detail/type_mat2x2.cj` 完整文件——Mat2x2<T,Q> 结构体定义（2 列 × 2 行，列向量 Vec2<T,Q>）及全部 extend 块接口：算术运算符（含 3 个乘法重载 + Mat×Vec2）、工厂函数（diagonal/identity）、跨类型构造（fromParts/fromColumns/fromMat 6a/6b/7）。Mat2x2 是 OOD Phase 2 的核心方阵类型，其 fromMat 6a/6b 共 16 个重载引用全部 8 个 skeleton 矩阵类型（v2 产出），是验证骨架闭合的最小完备集。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| src/detail/type_mat2x2.cj | 新建 | Mat2x2<T,Q> 完整定义（结构体 + 4 个 extend 块） |
| tests/glm/detail/test_type_mat2x2.cj | 新建 | 覆盖全部构造/运算符/工厂/fromMat 系列/越界 |

## 类型定义

### Mat2x2<T,Q>

**形态**：`struct`
**包路径**：`glm.detail`
**职责**：2×2 方阵值对象，列主序存储，列向量 Vec2<T,Q>

```cangjie
package glm.detail

import std.math.{ Number, Integer }
import std.deriving.*

@Derive[Hashable]
public struct Mat2x2<T, Q> where Q <: Qualifier {
    public var c0: Vec2<T, Q>
    public var c1: Vec2<T, Q>

    public init(scalar: T) {
        this.c0 = Vec2(scalar, scalar)
        this.c1 = Vec2(scalar, scalar)
    }

    public const init(a00: T, a01: T, a10: T, a11: T) {
        this.c0 = Vec2(a00, a01)
        this.c1 = Vec2(a10, a11)
    }

    public const init(c0: Vec2<T, Q>, c1: Vec2<T, Q>) {
        this.c0 = c0
        this.c1 = c1
    }

    public static func length(): Int64 { 2 }

    public operator func [](i: Int64): Vec2<T, Q> {
        assert(i >= Int64(0) && i < length(), message: "Mat2x2 index out of bounds")
        return match (i) {
            case 0 => this.c0
            case 1 => this.c1
            case _ => throw Exception("Mat2x2 index out of bounds")
        }
    }

    public mut operator func [](i: Int64, value!: Vec2<T, Q>): Unit {
        assert(i >= Int64(0) && i < length(), message: "Mat2x2 index out of bounds")
        match (i) {
            case 0 => this.c0 = value
            case 1 => this.c1 = value
            case _ => throw Exception("Mat2x2 index out of bounds")
        }
    }

    public func col(i: Int64): Vec2<T, Q> { this[i] }
}
```

**公开接口**：

| 方法 | 签名 |
|------|------|
| init（标量填充） | `(scalar: T)` |
| const init（逐分量） | `(a00: T, a01: T, a10: T, a11: T)` |
| const init（列向量） | `(c0: Vec2<T,Q>, c1: Vec2<T,Q>)` |
| length | `public static func length(): Int64 { 2 }` |
| `[]` 取值 | `public operator func [](i: Int64): Vec2<T,Q>` |
| `[]` 赋值 | `public mut operator func [](i: Int64, value!: Vec2<T,Q>): Unit` |
| col | `public func col(i: Int64): Vec2<T,Q> { this[i] }` |

**构造方式**：
- 标量填充：scalar 复制到 c0、c1 各分量
- 逐分量：列主序（a00,a01）为列 0 → c0，（a10,a11）为列 1 → c1
- 列向量：c0、c1 直接赋值

**类型关系**：无继承/实现。依赖 `Vec2<T,Q>` 和 `Qualifier`。

### Extend 1：`where T <: Number<T>, Q <: Qualifier`

```cangjie
extend<T, Q> Mat2x2<T, Q> where T <: Number<T>, Q <: Qualifier {
    public operator func -(): Mat2x2<T, Q> {
        Mat2x2(-this.c0.x, -this.c0.y, -this.c1.x, -this.c1.y)
    }

    @OverflowWrapping
    public operator func +(rhs: T): Mat2x2<T, Q> {
        Mat2x2(this.c0.x + rhs, this.c0.y + rhs, this.c1.x + rhs, this.c1.y + rhs)
    }

    @OverflowWrapping
    public operator func -(rhs: T): Mat2x2<T, Q> {
        Mat2x2(this.c0.x - rhs, this.c0.y - rhs, this.c1.x - rhs, this.c1.y - rhs)
    }

    @OverflowWrapping
    public operator func *(rhs: T): Mat2x2<T, Q> {
        Mat2x2(this.c0.x * rhs, this.c0.y * rhs, this.c1.x * rhs, this.c1.y * rhs)
    }

    @OverflowWrapping
    public operator func /(rhs: T): Mat2x2<T, Q> {
        Mat2x2(this.c0.x / rhs, this.c0.y / rhs, this.c1.x / rhs, this.c1.y / rhs)
    }

    @OverflowWrapping
    public operator func +(rhs: Mat2x2<T, Q>): Mat2x2<T, Q> {
        Mat2x2(this.c0.x + rhs.c0.x, this.c0.y + rhs.c0.y, this.c1.x + rhs.c1.x, this.c1.y + rhs.c1.y)
    }

    @OverflowWrapping
    public operator func -(rhs: Mat2x2<T, Q>): Mat2x2<T, Q> {
        Mat2x2(this.c0.x - rhs.c0.x, this.c0.y - rhs.c0.y, this.c1.x - rhs.c1.x, this.c1.y - rhs.c1.y)
    }

    @OverflowWrapping
    public operator func *(rhs: Mat2x2<T, Q>): Mat2x2<T, Q> {
        Mat2x2(
            this.c0.x * rhs.c0.x + this.c1.x * rhs.c0.y,
            this.c0.y * rhs.c0.x + this.c1.y * rhs.c0.y,
            this.c0.x * rhs.c1.x + this.c1.x * rhs.c1.y,
            this.c0.y * rhs.c1.x + this.c1.y * rhs.c1.y
        )
    }

    @OverflowWrapping
    public operator func *(rhs: Mat3x2<T, Q>): Mat3x2<T, Q> {
        Mat3x2(
            Vec2(this.c0.x * rhs.c0.x + this.c1.x * rhs.c0.y, this.c0.y * rhs.c0.x + this.c1.y * rhs.c0.y),
            Vec2(this.c0.x * rhs.c1.x + this.c1.x * rhs.c1.y, this.c0.y * rhs.c1.x + this.c1.y * rhs.c1.y),
            Vec2(this.c0.x * rhs.c2.x + this.c1.x * rhs.c2.y, this.c0.y * rhs.c2.x + this.c1.y * rhs.c2.y)
        )
    }

    @OverflowWrapping
    public operator func *(rhs: Mat4x2<T, Q>): Mat4x2<T, Q> {
        Mat4x2(
            Vec2(this.c0.x * rhs.c0.x + this.c1.x * rhs.c0.y, this.c0.y * rhs.c0.x + this.c1.y * rhs.c0.y),
            Vec2(this.c0.x * rhs.c1.x + this.c1.x * rhs.c1.y, this.c0.y * rhs.c1.x + this.c1.y * rhs.c1.y),
            Vec2(this.c0.x * rhs.c2.x + this.c1.x * rhs.c2.y, this.c0.y * rhs.c2.x + this.c1.y * rhs.c2.y),
            Vec2(this.c0.x * rhs.c3.x + this.c1.x * rhs.c3.y, this.c0.y * rhs.c3.x + this.c1.y * rhs.c3.y)
        )
    }

    @OverflowWrapping
    public operator func /(rhs: Mat2x2<T, Q>): Mat2x2<T, Q> { this * inverse(rhs) }

    @OverflowWrapping
    public operator func *(v: Vec2<T, Q>): Vec2<T, Q> {
        Vec2(this.c0.x * v.x + this.c1.x * v.y, this.c0.y * v.x + this.c1.y * v.y)
    }

    public static func diagonal(scalar: T): Mat2x2<T, Q> {
        let zero = scalar - scalar
        Mat2x2(Vec2(scalar, zero), Vec2(zero, scalar))
    }

    public static func identity(one: T): Mat2x2<T, Q> { diagonal(one) }
}
```

**公开接口**：

| 方法 | 签名 |
|------|------|
| 一元负号 | `public operator func -(): Mat2x2<T,Q>` |
| 矩阵-标量 + | `@OverflowWrapping public operator func +(rhs: T): Mat2x2<T,Q>` |
| 矩阵-标量 - | `@OverflowWrapping public operator func -(rhs: T): Mat2x2<T,Q>` |
| 矩阵-标量 * | `@OverflowWrapping public operator func *(rhs: T): Mat2x2<T,Q>` |
| 矩阵-标量 / | `@OverflowWrapping public operator func /(rhs: T): Mat2x2<T,Q>` |
| 矩阵-矩阵 + | `@OverflowWrapping public operator func +(rhs: Mat2x2): Mat2x2` |
| 矩阵-矩阵 - | `@OverflowWrapping public operator func -(rhs: Mat2x2): Mat2x2` |
| 矩阵-矩阵 * (同尺寸) | `@OverflowWrapping public operator func *(rhs: Mat2x2): Mat2x2` |
| 矩阵-矩阵 * (跨尺寸→Mat3x2) | `@OverflowWrapping public operator func *(rhs: Mat3x2): Mat3x2` |
| 矩阵-矩阵 * (跨尺寸→Mat4x2) | `@OverflowWrapping public operator func *(rhs: Mat4x2): Mat4x2` |
| 矩阵-矩阵 / | `@OverflowWrapping public operator func /(rhs: Mat2x2): Mat2x2`（内部 `this * inverse(rhs)`，stub 抛异常） |
| 矩阵×Vec2 | `@OverflowWrapping public operator func *(v: Vec2<T,Q>): Vec2<T,Q>` |
| diagonal | `public static func diagonal(scalar: T): Mat2x2<T,Q>` |
| identity | `public static func identity(one: T): Mat2x2<T,Q>`（方阵委托 diagonal） |

**乘法展开公式**：
- Mat2x2 × Mat2x2（C_left=2,R_left=2,C_right=2,R_right=2）：`result[j][i] = sum_{k=0}^{1} this.c_k[i] * r.c_j[k]`
  - 列 0：`Vec2(c0.x*r.c0.x + c1.x*r.c0.y, c0.y*r.c0.x + c1.y*r.c0.y)`
  - 列 1：`Vec2(c0.x*r.c1.x + c1.x*r.c1.y, c0.y*r.c1.x + c1.y*r.c1.y)`
- Mat2x2 × Mat3x2（C_left=2,R_left=2,C_right=3,R_right=2）：同理 j=0..2
- Mat2x2 × Mat4x2（C_left=2,R_left=2,C_right=4,R_right=2）：同理 j=0..3
- Mat2x2 × Vec2：`Vec2(c0.x*v.x + c1.x*v.y, c0.y*v.x + c1.y*v.y)`

## 错误处理

- `[]` 取值/赋值和 `col()` 越界时 assert + throw Exception
- `inverse(rhs)` 为 stub，运行时抛出 `Exception("stub")`
- 所有算术运算符标注 `@OverflowWrapping`，整数溢出静默截断

## 行为契约

- `length()` 返回编译期常量 2
- `diagonal(scalar)`：对角线为 scalar，非对角线为 T(0)=scalar-scalar
- `identity(one)`：方阵委托 `diagonal(one)`
- `a / rhs`（矩阵除法）：实现为 `a * inverse(rhs)`，stub 阶段抛异常
- 所有运算符返回新实例，不修改 this

## 依赖关系

| 类型/函数 | 包 | 说明 |
|----------|---|------|
| Vec2<T,Q> | glm.detail | 列向量类型，同包可见 |
| Qualifier | glm.detail | 泛型约束，同包可见 |
| Mat3x2<T,Q> | glm.detail | 跨尺寸乘法右操作数和结果类型 |
| Mat4x2<T,Q> | glm.detail | 跨尺寸乘法右操作数和结果类型 |
| inverse | glm.detail | matrix.cj 中的 stub 函数，同包可见 |
| Number<T> | std.math | 算术约束 |

**对后续任务的暴露**：本文件定义 Mat2x2 完整接口，供后续 T4~T9 矩阵文件引用（跨尺寸乘法左操作数、fromMat 6a/6b 源类型）。

---

## Extend 2：`where Q <: Qualifier`（无 Number 约束）

```cangjie
extend<T, Q> Mat2x2<T, Q> where Q <: Qualifier {
    public static func fromParts<U>(conv: (U) -> T, a00: U, a01: U, a10: U, a11: U): Mat2x2<T, Q> {
        Mat2x2(conv(a00), conv(a01), conv(a10), conv(a11))
    }

    public static func fromColumns<U, P>(conv: (U) -> T, c0: Vec2<U, P>, c1: Vec2<U, P>): Mat2x2<T, Q>
      where P <: Qualifier {
        Mat2x2(Vec2(conv(c0.x), conv(c0.y)), Vec2(conv(c1.x), conv(c1.y)))
    }

    public static func fromMat<U, P>(conv: (U) -> T, m: Mat2x2<U, P>): Mat2x2<T, Q>
      where P <: Qualifier {
        Mat2x2(conv(m.c0.x), conv(m.c0.y), conv(m.c1.x), conv(m.c1.y))
    }
}
```

**公开接口**：

| 方法 | 签名 |
|------|------|
| fromParts | `public static func fromParts<U>(conv: (U) -> T, a00: U, a01: U, a10: U, a11: U): Mat2x2<T,Q> where Q <: Qualifier` |
| fromColumns | `public static func fromColumns<U, P>(conv: (U) -> T, c0: Vec2<U,P>, c1: Vec2<U,P>): Mat2x2<T,Q> where Q <: Qualifier, P <: Qualifier` |
| fromMat 7 | `public static func fromMat<U, P>(conv: (U) -> T, m: Mat2x2<U,P>): Mat2x2<T,Q> where Q <: Qualifier, P <: Qualifier` |

---

## Extend 3：fromMat 6a（同类型不同尺寸，8 个重载）

约束：`where T <: Number<T>, Q <: Qualifier, SrcQ <: Qualifier`

所有方向均为收缩方向（Mat2x2 的 C=2,R=2 小于等于所有源矩阵的 C/R），`one` 参数在函数体中未被使用但保留以保持 API 统一。

```cangjie
extend<T, Q, SrcQ> Mat2x2<T, Q>
  where T <: Number<T>, Q <: Qualifier, SrcQ <: Qualifier {

    // Mat2x2 <- Mat2x3: colShrink? C=2=2, rowShrink R 3->2
    public static func fromMat(m: Mat2x3<T, SrcQ>, one: T): Mat2x2<T, Q> {
        let zero = m.c0.x - m.c0.x
        Mat2x2(Vec2(m.c0.x, m.c0.y), Vec2(m.c1.x, m.c1.y))
    }

    // Mat2x2 <- Mat2x4: colShrink? C=2=2, rowShrink R 4->2
    public static func fromMat(m: Mat2x4<T, SrcQ>, one: T): Mat2x2<T, Q> {
        let zero = m.c0.x - m.c0.x
        Mat2x2(Vec2(m.c0.x, m.c0.y), Vec2(m.c1.x, m.c1.y))
    }

    // Mat2x2 <- Mat3x2: colShrink C 3->2, R 2=2
    public static func fromMat(m: Mat3x2<T, SrcQ>, one: T): Mat2x2<T, Q> {
        let zero = m.c0.x - m.c0.x
        Mat2x2(m.c0, m.c1)
    }

    // Mat2x2 <- Mat3x3: colShrink C 3->2, rowShrink R 3->2
    public static func fromMat(m: Mat3x3<T, SrcQ>, one: T): Mat2x2<T, Q> {
        let zero = m.c0.x - m.c0.x
        Mat2x2(Vec2(m.c0.x, m.c0.y), Vec2(m.c1.x, m.c1.y))
    }

    // Mat2x2 <- Mat3x4: colShrink C 3->2, rowShrink R 4->2
    public static func fromMat(m: Mat3x4<T, SrcQ>, one: T): Mat2x2<T, Q> {
        let zero = m.c0.x - m.c0.x
        Mat2x2(Vec2(m.c0.x, m.c0.y), Vec2(m.c1.x, m.c1.y))
    }

    // Mat2x2 <- Mat4x2: colShrink C 4->2, R 2=2
    public static func fromMat(m: Mat4x2<T, SrcQ>, one: T): Mat2x2<T, Q> {
        let zero = m.c0.x - m.c0.x
        Mat2x2(m.c0, m.c1)
    }

    // Mat2x2 <- Mat4x3: colShrink C 4->2, rowShrink R 3->2
    public static func fromMat(m: Mat4x3<T, SrcQ>, one: T): Mat2x2<T, Q> {
        let zero = m.c0.x - m.c0.x
        Mat2x2(Vec2(m.c0.x, m.c0.y), Vec2(m.c1.x, m.c1.y))
    }

    // Mat2x2 <- Mat4x4: colShrink C 4->2, rowShrink R 4->2
    public static func fromMat(m: Mat4x4<T, SrcQ>, one: T): Mat2x2<T, Q> {
        let zero = m.c0.x - m.c0.x
        Mat2x2(Vec2(m.c0.x, m.c0.y), Vec2(m.c1.x, m.c1.y))
    }
}
```

## Extend 4：fromMat 6b（跨类型不同尺寸，8 个重载）

约束：`where T <: Number<T>, Q <: Qualifier, P <: Qualifier`

与 6a 的区别：（1）额外参数 `conv: (U) -> T`；（2）zero 通过 `one - one` 演算（因 `m.c0.x` 类型为 U）。

```cangjie
extend<T, Q, P> Mat2x2<T, Q>
  where T <: Number<T>, Q <: Qualifier, P <: Qualifier {

    // Mat2x2<U,P> <- Mat2x3<U,P>: rowShrink R 3->2
    public static func fromMat<U>(conv: (U) -> T, m: Mat2x3<U, P>, one: T): Mat2x2<T, Q> {
        let zero = one - one
        Mat2x2(Vec2(conv(m.c0.x), conv(m.c0.y)), Vec2(conv(m.c1.x), conv(m.c1.y)))
    }

    // Mat2x2<U,P> <- Mat2x4<U,P>: rowShrink R 4->2
    public static func fromMat<U>(conv: (U) -> T, m: Mat2x4<U, P>, one: T): Mat2x2<T, Q> {
        let zero = one - one
        Mat2x2(Vec2(conv(m.c0.x), conv(m.c0.y)), Vec2(conv(m.c1.x), conv(m.c1.y)))
    }

    // Mat2x2<U,P> <- Mat3x2<U,P>: colShrink C 3->2
    public static func fromMat<U>(conv: (U) -> T, m: Mat3x2<U, P>, one: T): Mat2x2<T, Q> {
        let zero = one - one
        Mat2x2(Vec2(conv(m.c0.x), conv(m.c0.y)), Vec2(conv(m.c1.x), conv(m.c1.y)))
    }

    // Mat2x2<U,P> <- Mat3x3<U,P>: colShrink→rowShrink
    public static func fromMat<U>(conv: (U) -> T, m: Mat3x3<U, P>, one: T): Mat2x2<T, Q> {
        let zero = one - one
        Mat2x2(Vec2(conv(m.c0.x), conv(m.c0.y)), Vec2(conv(m.c1.x), conv(m.c1.y)))
    }

    // Mat2x2<U,P> <- Mat3x4<U,P>: colShrink→rowShrink
    public static func fromMat<U>(conv: (U) -> T, m: Mat3x4<U, P>, one: T): Mat2x2<T, Q> {
        let zero = one - one
        Mat2x2(Vec2(conv(m.c0.x), conv(m.c0.y)), Vec2(conv(m.c1.x), conv(m.c1.y)))
    }

    // Mat2x2<U,P> <- Mat4x2<U,P>: colShrink C 4->2
    public static func fromMat<U>(conv: (U) -> T, m: Mat4x2<U, P>, one: T): Mat2x2<T, Q> {
        let zero = one - one
        Mat2x2(Vec2(conv(m.c0.x), conv(m.c0.y)), Vec2(conv(m.c1.x), conv(m.c1.y)))
    }

    // Mat2x2<U,P> <- Mat4x3<U,P>: colShrink→rowShrink
    public static func fromMat<U>(conv: (U) -> T, m: Mat4x3<U, P>, one: T): Mat2x2<T, Q> {
        let zero = one - one
        Mat2x2(Vec2(conv(m.c0.x), conv(m.c0.y)), Vec2(conv(m.c1.x), conv(m.c1.y)))
    }

    // Mat2x2<U,P> <- Mat4x4<U,P>: colShrink→rowShrink
    public static func fromMat<U>(conv: (U) -> T, m: Mat4x4<U, P>, one: T): Mat2x2<T, Q> {
        let zero = one - one
        Mat2x2(Vec2(conv(m.c0.x), conv(m.c0.y)), Vec2(conv(m.c1.x), conv(m.c1.y)))
    }
}
```

## fromMat 6a/6b 方向汇总表

| 源矩阵 | C_src | R_src | 操作 | 取值逻辑 |
|--------|-------|-------|------|---------|
| Mat2x3<T,SrcQ> | 2 | 3 | rowShrink | `Vec2(src.c0.x, src.c0.y)` |
| Mat2x4<T,SrcQ> | 2 | 4 | rowShrink | `Vec2(src.c0.x, src.c0.y)` |
| Mat3x2<T,SrcQ> | 3 | 2 | colShrink | `src.c0, src.c1` |
| Mat3x3<T,SrcQ> | 3 | 3 | colShrink→rowShrink | `Vec2(src.c0.x, src.c0.y)` |
| Mat3x4<T,SrcQ> | 3 | 4 | colShrink→rowShrink | `Vec2(src.c0.x, src.c0.y)` |
| Mat4x2<T,SrcQ> | 4 | 2 | colShrink | `src.c0, src.c1` |
| Mat4x3<T,SrcQ> | 4 | 3 | colShrink→rowShrink | `Vec2(src.c0.x, src.c0.y)` |
| Mat4x4<T,SrcQ> | 4 | 4 | colShrink→rowShrink | `Vec2(src.c0.x, src.c0.y)` |

## 测试文件设计

文件：`tests/glm/detail/test_type_mat2x2.cj`

### 覆盖清单

| 类别 | 测试项 | 预期 |
|------|--------|------|
| 构造 | 标量填充 init | 全部分量等于 scalar |
| 构造 | 逐分量 const init | 各分量按列主序匹配 |
| 构造 | 列向量 const init | c0、c1 与传入一致 |
| length | length() | 返回 2 |
| 下标访问 | `[0]`, `[1]` 取值 | 返回对应列向量 |
| 下标赋值 | `[0] = v`, `[1] = v` | c0/c1 被修改 |
| col | col(0), col(1) | 返回对应列向量 |
| 越界 | `[2]`, `col(2)`, `[-1]` | 抛出 Exception |
| 一元负号 | `-m` | 各分量取反 |
| 矩阵-标量 | `m + t`, `m - t`, `m * t`, `m / t` | 逐分量运算 |
| 矩阵-矩阵 +- | `m1 + m2`, `m1 - m2` | 同尺寸逐分量 |
| 矩阵-矩阵 × (同尺寸) | `m1 * m2` | 标准 2×2 乘法 |
| 矩阵-矩阵 × (跨尺寸→Mat3x2) | `m * m3x2` | 按公式展开 |
| 矩阵-矩阵 × (跨尺寸→Mat4x2) | `m * m4x2` | 按公式展开 |
| 矩阵-矩阵 / | `m1 / m2` | 抛出 stub 异常 |
| 矩阵×Vec2 | `m * v` | 标准矩阵-向量乘 |
| diagonal | `Mat2x2.diagonal(s)` | 对角=s, 非对角=0 |
| identity | `Mat2x2.identity(one)` | 单位矩阵 |
| fromParts | 跨类型构造 | 各分量经 conv 转换 |
| fromColumns | 跨类型列向量构造 | 各列经 conv 转换 |
| fromMat 7 | 跨类型同尺寸 | 逐元素 conv 转换 |
| fromMat 6a | 8 个方向各选 1 代表方向 | 收缩/截断正确 |
| fromMat 6b | 8 个方向各选 1 代表方向 | 收缩 + conv 正确 |
