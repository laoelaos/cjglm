# 详细设计（v2）

## 概述

创建 8 个矩阵类型 skeleton 结构体定义文件（`type_mat2x3.cj` ~ `type_mat4x4.cj`），每个文件包含 minimum viable 定义：列向量数据成员、三个基础构造函数（逐分量 const init / 列向量 const init / 标量填充 init）、`length()`、下标运算符 `[]`（get/set）、`col()` 访问器。不包含任何算术运算符 extend 块、工厂函数、fromMat 或比较运算符。

此阶段仅建立编译期可解析的类型定义骨架，闭合跨类型编译依赖，为 T3 实现完整 Mat2x2（含 fromMat 引用其他 8 个矩阵类型）提供前置条件。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| src/detail/type_mat2x3.cj | 新建 | Mat2x3<T,Q> skeleton（2 列 × 3 行，列向量 Vec3<T,Q>） |
| src/detail/type_mat2x4.cj | 新建 | Mat2x4<T,Q> skeleton（2 列 × 4 行，列向量 Vec4<T,Q>） |
| src/detail/type_mat3x2.cj | 新建 | Mat3x2<T,Q> skeleton（3 列 × 2 行，列向量 Vec2<T,Q>） |
| src/detail/type_mat3x3.cj | 新建 | Mat3x3<T,Q> skeleton（3 列 × 3 行，列向量 Vec3<T,Q>） |
| src/detail/type_mat3x4.cj | 新建 | Mat3x4<T,Q> skeleton（3 列 × 4 行，列向量 Vec4<T,Q>） |
| src/detail/type_mat4x2.cj | 新建 | Mat4x2<T,Q> skeleton（4 列 × 2 行，列向量 Vec2<T,Q>） |
| src/detail/type_mat4x3.cj | 新建 | Mat4x3<T,Q> skeleton（4 列 × 3 行，列向量 Vec3<T,Q>） |
| src/detail/type_mat4x4.cj | 新建 | Mat4x4<T,Q> skeleton（4 列 × 4 行，列向量 Vec4<T,Q>） |

**不创建** `type_mat2x2.cj`——该文件由原 T2 规划，将在 T3 阶段实现完整版（含 fromMat 引用此阶段的 8 个 skeleton 类型）。

## 类型定义

所有 8 个类型共享相同的结构形态，仅在列数 C、行数 R、列向量类型 VecR 和参数个数上存在系统差异。

### 共有结构模板

**形态**：`struct`
**包路径**：`glm.detail`
**职责**：表示 C×R 数学矩阵的值对象，列主序存储，提供基础构造和行列访问

```cangjie
package glm.detail

import std.math.{ Number, Integer }
import std.deriving.*

@Derive[Hashable]
public struct Mat{C}x{R}<T, Q> where Q <: Qualifier {
    public var c0: Vec{R}<T,Q>
    public var c1: Vec{R}<T,Q>
    // ... 根据需要增加 c2, c3
```

### Mat2x3<T,Q>

**形态**：`struct`
**包路径**：`glm.detail`
**数据成员**：
- `public var c0: Vec3<T,Q>`
- `public var c1: Vec3<T,Q>`
**列数 C**：2，**行数 R**：3

**公开接口**：

| 方法 | 签名 |
|------|------|
| const init（逐分量） | `(a00: T, a01: T, a02: T, a10: T, a11: T, a12: T)` |
| const init（列向量） | `(c0: Vec3<T,Q>, c1: Vec3<T,Q>)` |
| init（标量填充） | `(scalar: T)` |
| length | `public static func length(): Int64 { 2 }` |
| `[]` 取值 | `public operator func [](i: Int64): Vec3<T,Q>` |
| `[]` 赋值 | `public mut operator func [](i: Int64, value!: Vec3<T,Q>): Unit` |
| col | `public func col(i: Int64): Vec3<T,Q>` |

**构造方式**：
- 逐分量：6 个 T 参数，按列主序排列 —— `(a00,a01,a02)` 为列 0 的三行，`(a10,a11,a12)` 为列 1 的三行
- 列向量：2 个 Vec3<T,Q> 参数，直接赋值给 c0、c1
- 标量填充：构造 c0=Vec3(scalar,scalar,scalar), c1=Vec3(scalar,scalar,scalar)

**类型关系**：无继承/实现。依赖 `Vec3<T,Q>` 和 `Qualifier`。

### Mat2x4<T,Q>

**数据成员**：
- `public var c0: Vec4<T,Q>`
- `public var c1: Vec4<T,Q>`
**列数 C**：2，**行数 R**：4

**公开接口**：

| 方法 | 签名 |
|------|------|
| const init（逐分量） | `(a00: T, a01: T, a02: T, a03: T, a10: T, a11: T, a12: T, a13: T)` |
| const init（列向量） | `(c0: Vec4<T,Q>, c1: Vec4<T,Q>)` |
| init（标量填充） | `(scalar: T)` |
| length | `public static func length(): Int64 { 2 }` |
| `[]` 取值 | `public operator func [](i: Int64): Vec4<T,Q>` |
| `[]` 赋值 | `public mut operator func [](i: Int64, value!: Vec4<T,Q>): Unit` |
| col | `public func col(i: Int64): Vec4<T,Q>` |

### Mat3x2<T,Q>

**数据成员**：
- `public var c0: Vec2<T,Q>`
- `public var c1: Vec2<T,Q>`
- `public var c2: Vec2<T,Q>`
**列数 C**：3，**行数 R**：2

**公开接口**：

| 方法 | 签名 |
|------|------|
| const init（逐分量） | `(a00: T, a01: T, a10: T, a11: T, a20: T, a21: T)` |
| const init（列向量） | `(c0: Vec2<T,Q>, c1: Vec2<T,Q>, c2: Vec2<T,Q>)` |
| init（标量填充） | `(scalar: T)` |
| length | `public static func length(): Int64 { 3 }` |
| `[]` 取值 | `public operator func [](i: Int64): Vec2<T,Q>` |
| `[]` 赋值 | `public mut operator func [](i: Int64, value!: Vec2<T,Q>): Unit` |
| col | `public func col(i: Int64): Vec2<T,Q>` |

### Mat3x3<T,Q>

**数据成员**：
- `public var c0: Vec3<T,Q>`
- `public var c1: Vec3<T,Q>`
- `public var c2: Vec3<T,Q>`
**列数 C**：3，**行数 R**：3

**公开接口**：

| 方法 | 签名 |
|------|------|
| const init（逐分量） | `(a00: T, a01: T, a02: T, a10: T, a11: T, a12: T, a20: T, a21: T, a22: T)` |
| const init（列向量） | `(c0: Vec3<T,Q>, c1: Vec3<T,Q>, c2: Vec3<T,Q>)` |
| init（标量填充） | `(scalar: T)` |
| length | `public static func length(): Int64 { 3 }` |
| `[]` 取值 | `public operator func [](i: Int64): Vec3<T,Q>` |
| `[]` 赋值 | `public mut operator func [](i: Int64, value!: Vec3<T,Q>): Unit` |
| col | `public func col(i: Int64): Vec3<T,Q>` |

### Mat3x4<T,Q>

**数据成员**：
- `public var c0: Vec4<T,Q>`
- `public var c1: Vec4<T,Q>`
- `public var c2: Vec4<T,Q>`
**列数 C**：3，**行数 R**：4

**公开接口**：

| 方法 | 签名 |
|------|------|
| const init（逐分量） | `(a00: T, a01: T, a02: T, a03: T, a10: T, a11: T, a12: T, a13: T, a20: T, a21: T, a22: T, a23: T)` |
| const init（列向量） | `(c0: Vec4<T,Q>, c1: Vec4<T,Q>, c2: Vec4<T,Q>)` |
| init（标量填充） | `(scalar: T)` |
| length | `public static func length(): Int64 { 3 }` |
| `[]` 取值 | `public operator func [](i: Int64): Vec4<T,Q>` |
| `[]` 赋值 | `public mut operator func [](i: Int64, value!: Vec4<T,Q>): Unit` |
| col | `public func col(i: Int64): Vec4<T,Q>` |

### Mat4x2<T,Q>

**数据成员**：
- `public var c0: Vec2<T,Q>`
- `public var c1: Vec2<T,Q>`
- `public var c2: Vec2<T,Q>`
- `public var c3: Vec2<T,Q>`
**列数 C**：4，**行数 R**：2

**公开接口**：

| 方法 | 签名 |
|------|------|
| const init（逐分量） | `(a00: T, a01: T, a10: T, a11: T, a20: T, a21: T, a30: T, a31: T)` |
| const init（列向量） | `(c0: Vec2<T,Q>, c1: Vec2<T,Q>, c2: Vec2<T,Q>, c3: Vec2<T,Q>)` |
| init（标量填充） | `(scalar: T)` |
| length | `public static func length(): Int64 { 4 }` |
| `[]` 取值 | `public operator func [](i: Int64): Vec2<T,Q>` |
| `[]` 赋值 | `public mut operator func [](i: Int64, value!: Vec2<T,Q>): Unit` |
| col | `public func col(i: Int64): Vec2<T,Q>` |

### Mat4x3<T,Q>

**数据成员**：
- `public var c0: Vec3<T,Q>`
- `public var c1: Vec3<T,Q>`
- `public var c2: Vec3<T,Q>`
- `public var c3: Vec3<T,Q>`
**列数 C**：4，**行数 R**：3

**公开接口**：

| 方法 | 签名 |
|------|------|
| const init（逐分量） | `(a00: T, a01: T, a02: T, a10: T, a11: T, a12: T, a20: T, a21: T, a22: T, a30: T, a31: T, a32: T)` |
| const init（列向量） | `(c0: Vec3<T,Q>, c1: Vec3<T,Q>, c2: Vec3<T,Q>, c3: Vec3<T,Q>)` |
| init（标量填充） | `(scalar: T)` |
| length | `public static func length(): Int64 { 4 }` |
| `[]` 取值 | `public operator func [](i: Int64): Vec3<T,Q>` |
| `[]` 赋值 | `public mut operator func [](i: Int64, value!: Vec3<T,Q>): Unit` |
| col | `public func col(i: Int64): Vec3<T,Q>` |

### Mat4x4<T,Q>

**数据成员**：
- `public var c0: Vec4<T,Q>`
- `public var c1: Vec4<T,Q>`
- `public var c2: Vec4<T,Q>`
- `public var c3: Vec4<T,Q>`
**列数 C**：4，**行数 R**：4

**公开接口**：

| 方法 | 签名 |
|------|------|
| const init（逐分量） | `(a00: T, a01: T, a02: T, a03: T, a10: T, a11: T, a12: T, a13: T, a20: T, a21: T, a22: T, a23: T, a30: T, a31: T, a32: T, a33: T)` |
| const init（列向量） | `(c0: Vec4<T,Q>, c1: Vec4<T,Q>, c2: Vec4<T,Q>, c3: Vec4<T,Q>)` |
| init（标量填充） | `(scalar: T)` |
| length | `public static func length(): Int64 { 4 }` |
| `[]` 取值 | `public operator func [](i: Int64): Vec4<T,Q>` |
| `[]` 赋值 | `public mut operator func [](i: Int64, value!: Vec4<T,Q>): Unit` |
| col | `public func col(i: Int64): Vec4<T,Q>` |

## `[]` 和 `col()` 实现约定

所有 8 个类型的 `[]` 取值版本和 `col()` 实现模式相同：

```cangjie
public operator func [](i: Int64): VecR<T,Q> {
    assert(i >= Int64(0) && i < length(), message: "Mat{C}x{R} index out of bounds")
    return match (i) {
        case 0 => this.c0
        case 1 => this.c1
        // ... 根据需要增加 case
        case _ => throw Exception("Mat{C}x{R} index out of bounds")
    }
}
```

`[]` 赋值版本：
```cangjie
public mut operator func [](i: Int64, value!: VecR<T,Q>): Unit {
    assert(i >= Int64(0) && i < length(), message: "Mat{C}x{R} index out of bounds")
    match (i) {
        case 0 => this.c0 = value
        case 1 => this.c1 = value
        // ... 根据需要增加 case
        case _ => throw Exception("Mat{C}x{R} index out of bounds")
    }
}
```

`col()` 取值版本与 `[]` 取值版本等价：
```cangjie
public func col(i: Int64): VecR<T,Q> { this[i] }
```

## 错误处理

- 所有下标访问（`[]` 取值/赋值、`col()`）先通过 `assert` 进行边界检查，再通过 `match` 分发
- `match` 的默认分支 `case _` 在 assert 通过后本应不可达，但保留 `throw Exception` 以保证 exhaustive matching 和安全兜底
- 构造函数的参数不进行验证（合法的逐分量和列向量组合由调用方保证）
- 不使用自定义错误类型，统一使用 `Exception`

## 行为契约

- `length()` 返回列数 C 的 `Int64` 字面量，编译期常量，不依赖运行时状态
- `[]` 取值/赋值版本和 `col()` 在 `i < 0 || i >= C` 时抛出 `Exception`
- 逐分量 const init 的参数顺序为列主序：参数分组 `a{col}{row}`，每列连续 R 个参数（列 0 的 R 行、列 1 的 R 行，依次类推），与列向量数据成员的排列方式一致
- 列向量 const init 的参数顺序与 c0、c1、c2、c3 一一对应
- 标量填充 init 将 scalar 复制到每个列向量的每个分量
- 所有构造函数均为纯赋值，无算术逻辑
- 所有骨架文件不包含 `extend` 块、不包含 `fromMat`、不包含比较运算符、不包含工厂函数

## 依赖关系

| 文件 | 依赖 | 说明 |
|------|------|------|
| type_mat2x3.cj | Vec3<T,Q>, Qualifier | 列向量为 Vec3，约束 Q <: Qualifier |
| type_mat2x4.cj | Vec4<T,Q>, Qualifier | 列向量为 Vec4 |
| type_mat3x2.cj | Vec2<T,Q>, Qualifier | 列向量为 Vec2 |
| type_mat3x3.cj | Vec3<T,Q>, Qualifier | 列向量为 Vec3 |
| type_mat3x4.cj | Vec4<T,Q>, Qualifier | 列向量为 Vec4 |
| type_mat4x2.cj | Vec2<T,Q>, Qualifier | 列向量为 Vec2 |
| type_mat4x3.cj | Vec3<T,Q>, Qualifier | 列向量为 Vec3 |
| type_mat4x4.cj | Vec4<T,Q>, Qualifier | 列向量为 Vec4 |

所有依赖均为 `glm.detail` 同包类型，无需 import 语句即可直接引用。`import std.math.{ Number, Integer }` 和 `import std.deriving.*` 作为标准导入包含在每个文件中（虽然 `@Derive[Hashable]` 仅需 `import std.deriving.*`，`Number`/`Integer` 为本阶段预留）。

**对后续任务的暴露**：本阶段产出的 8 个 Mat 类型定义供 T3 的 type_mat2x2.cj（完整实现，含 fromMat 引用）在编译时解析类型引用，以及后续 T4 ~ T9 的完整矩阵实现文件直接编译。

## 修订说明（v2 r1）

| 审查意见 | 修改措施 |
|---------|---------|
| [严重] 原 T2（完整 Mat2x2 实现）的 fromMat 6a/6b/7 引用全部 8 个其他矩阵类型，跨尺寸乘法引用 Mat3x2/Mat4x2——仓颉以包为最小编译单元，这些类型必须在编译时存在 | 将原 T2 拆分为两步：本任务（v2 RETRY）先创建 8 个依赖类型的 skeleton 文件，后续 T3 实现完整 Mat2x2。此设计定义 8 个 minimum viable 类型定义以闭合所有跨类型编译依赖 |
