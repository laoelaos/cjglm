# 详细设计（v3）

## 概述

本设计对应 OOD Phase0 的 R3 03 向量类型层。目标是将 `type_vec_stubs.cj` 中的 Vec1~Vec4 最小桩替换为完整定义，新建 `scalar_vec_ops.cj`（scalar-op-vec 方向辅助函数）和 `type_fromBoolVec.cj`（Bool→Numeric 转换工厂函数），并删除桩文件。共新建 6 个源文件 + 6 个测试文件，删除 1 个桩文件。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `src/detail/type_vec1.cj` | 新建 | Vec1<T,Q> 完整结构体（成员、构造函数、operator[]、componentAt + 各约束 extend 块） |
| `src/detail/type_vec2.cj` | 新建 | Vec2<T,Q> 完整结构体 |
| `src/detail/type_vec3.cj` | 新建 | Vec3<T,Q> 完整结构体 |
| `src/detail/type_vec4.cj` | 新建 | Vec4<T,Q> 完整结构体 |
| `src/detail/scalar_vec_ops.cj` | 新建 | scalar-op-vec 方向包级独立函数（add/sub/mul/div/mod，各 4 个 Vec 版本） |
| `src/detail/type_fromBoolVec.cj` | 新建 | fromBoolVec/fromBoolVecQ2 工厂函数（Vec1~Vec4 各 2 个版本 = 8 个函数） |
| `src/detail/type_vec1_test.cj` | 新建 | Vec1 单元测试 |
| `src/detail/type_vec2_test.cj` | 新建 | Vec2 单元测试 |
| `src/detail/type_vec3_test.cj` | 新建 | Vec3 单元测试 |
| `src/detail/type_vec4_test.cj` | 新建 | Vec4 单元测试 |
| `src/detail/scalar_vec_ops_test.cj` | 新建 | scalar_vec_ops 单元测试 |
| `src/detail/type_fromBoolVec_test.cj` | 新建 | fromBoolVec 单元测试 |
| `src/detail/type_vec_stubs.cj` | 删除 | 被各 type_vecN.cj 替代 |

## 类型定义

### Vec 结构体设计总则

Vec 结构体的泛型参数 T **无紧约束**（仅 `Q <: Qualifier`），因此所有依赖 T 的运算符操作的成员函数**不能**定义在 struct 体内或无约束的 extend 块中。仓颉语言要求：无约束的泛型参数只能传递/返回，不能进行运算符操作（参见泛型文档 §7.1）。

解决方案：将运算符按所需约束拆分到多个 extend 块中，struct 体内仅保留不依赖 T 运算符操作的定义。

### Vec1<T, Q>

**形态**：struct
**包路径**：`glm.detail`
**职责**：单分量数学向量
**类型参数**：`T` — 分量类型（无紧约束，延迟检查）；`Q <: Qualifier` — 精度策略

#### struct 体定义（无 T 约束，仅数据 + 构造 + 下标 + length）
```
@Derive[Hashable]
public struct Vec1<T, Q> where Q <: Qualifier {
    public var x: T

    public const init(x: T)

    public init<T2, Q2>(v: Vec1<T2, Q2>) where Q2 <: Qualifier
    public init<T2, Q2>(v: Vec2<T2, Q2>) where Q2 <: Qualifier
    public init<T2, Q2>(v: Vec3<T2, Q2>) where Q2 <: Qualifier
    public init<T2, Q2>(v: Vec4<T2, Q2>) where Q2 <: Qualifier

    public static func length(): Int64 { 1 }

    public operator func [](i: Int64): T
    public mut operator func [](i: Int64, value!: T): Unit
    public const func componentAt(i: Int64): T
}
```

#### extend 块 1：算术运算（`T <: Number<T>`）
```
extend<T, Q> Vec1<T, Q> where T <: Number<T>, Q <: Qualifier {
    @OverflowWrapping
    public operator func +(rhs: Vec1<T, Q>): Vec1<T, Q>
    @OverflowWrapping
    public operator func -(rhs: Vec1<T, Q>): Vec1<T, Q>
    @OverflowWrapping
    public operator func *(rhs: Vec1<T, Q>): Vec1<T, Q>
    @OverflowWrapping
    public operator func /(rhs: Vec1<T, Q>): Vec1<T, Q>
    @OverflowWrapping
    public operator func %(rhs: Vec1<T, Q>): Vec1<T, Q>
    @OverflowWrapping
    public operator func +(rhs: T): Vec1<T, Q>
    @OverflowWrapping
    public operator func -(rhs: T): Vec1<T, Q>
    @OverflowWrapping
    public operator func *(rhs: T): Vec1<T, Q>
    @OverflowWrapping
    public operator func /(rhs: T): Vec1<T, Q>
    @OverflowWrapping
    public operator func %(rhs: T): Vec1<T, Q>

    public operator func +(): Vec1<T, Q> { this }
    public operator func -(): Vec1<T, Q>

    @OverflowWrapping
    public func increment(): Vec1<T, Q> { this + T(1) }
    @OverflowWrapping
    public func decrement(): Vec1<T, Q> { this - T(1) }

    public func add(s: T): Vec1<T, Q> { this + s }
    public func sub(s: T): Vec1<T, Q> { this - s }
    public func mul(s: T): Vec1<T, Q> { this * s }
    public func div(s: T): Vec1<T, Q> { this / s }
    public func mod(s: T): Vec1<T, Q> { this % s }
}
```

#### extend 块 2：位运算（`T <: Integer<T>`）
```
extend<T, Q> Vec1<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public operator func &(rhs: Vec1<T, Q>): Vec1<T, Q>
    public operator func |(rhs: Vec1<T, Q>): Vec1<T, Q>
    public operator func ^(rhs: Vec1<T, Q>): Vec1<T, Q>
    @OverflowWrapping
    public operator func <<(rhs: Vec1<T, Q>): Vec1<T, Q>
    public operator func >>(rhs: Vec1<T, Q>): Vec1<T, Q>
    public func bitwiseNot(): Vec1<T, Q>
}
```

#### extend 块 3：标量右操作数位运算（`T <: Integer<T>`）
```
extend<T, Q> Vec1<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public operator func &(rhs: T): Vec1<T, Q>
    public operator func |(rhs: T): Vec1<T, Q>
    public operator func ^(rhs: T): Vec1<T, Q>
    @OverflowWrapping
    public operator func <<(shift: T): Vec1<T, Q>
    public operator func >>(shift: T): Vec1<T, Q>
}
```

#### extend 块 4：比较运算（`T <: Equatable<T>`）
```
extend<T, Q> Vec1<T, Q> where T <: Equatable<T>, Q <: Qualifier {
    public operator func ==(rhs: Vec1<T, Q>): Bool
    public operator func !=(rhs: Vec1<T, Q>): Bool { !(this == rhs) }
    public func equalExact(other: Vec1<T, Q>): Bool
}
```

#### extend 块 5：Epsilon 比较（`T <: Number<T> & Equatable<T> & Comparable<T>`）
```
extend<T, Q> Vec1<T, Q> where T <: Number<T> & Equatable<T> & Comparable<T>, Q <: Qualifier {
    public func equalEpsilon(other: Vec1<T, Q>): Bool
}
```

#### extend 块 6：Bool 逻辑运算（特化 `Vec1<Bool, Q>`）
```
extend<Q> Vec1<Bool, Q> where Q <: Qualifier {
    public func logicalAnd(other: Vec1<Bool, Q>): Vec1<Bool, Q>
    public func logicalOr(other: Vec1<Bool, Q>): Vec1<Bool, Q>
}
```

#### extend 块 7：Vec1 左操作数广播（`T <: Number<T>`）
```
extend<T, Q> Vec1<T, Q> where T <: Number<T>, Q <: Qualifier {
    @OverflowWrapping
    public operator func +(rhs: Vec2<T, Q>): Vec2<T, Q>
    @OverflowWrapping
    public operator func -(rhs: Vec2<T, Q>): Vec2<T, Q>
    @OverflowWrapping
    public operator func *(rhs: Vec2<T, Q>): Vec2<T, Q>
    @OverflowWrapping
    public operator func /(rhs: Vec2<T, Q>): Vec2<T, Q>
    @OverflowWrapping
    public operator func %(rhs: Vec2<T, Q>): Vec2<T, Q>
    // 同理 Vec3, Vec4
}
```

#### extend 块 8：Vec1 左操作数位广播（`T <: Integer<T>`）
```
extend<T, Q> Vec1<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public operator func &(rhs: Vec2<T, Q>): Vec2<T, Q>
    public operator func |(rhs: Vec2<T, Q>): Vec2<T, Q>
    public operator func ^(rhs: Vec2<T, Q>): Vec2<T, Q>
    @OverflowWrapping
    public operator func <<(rhs: Vec2<T, Q>): Vec2<T, Q>
    public operator func >>(rhs: Vec2<T, Q>): Vec2<T, Q>
    // 同理 Vec3, Vec4
}
```

### Vec2<T, Q>

**形态**：struct
**包路径**：`glm.detail`
**职责**：二维向量
**类型参数**：`T` — 分量类型（无紧约束）；`Q <: Qualifier`

#### struct 体定义
```
@Derive[Hashable]
public struct Vec2<T, Q> where Q <: Qualifier {
    public var x: T
    public var y: T

    public init(scalar: T)
    public const init(x: T, y: T)

    public init<T2, Q2>(v: Vec2<T2, Q2>) where Q2 <: Qualifier
    public init<T2, Q2>(a: Vec1<T2, Q2>, b: T) where Q2 <: Qualifier
    public init<T2, Q2>(a: T, b: Vec1<T2, Q2>) where Q2 <: Qualifier
    public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>) where Q2 <: Qualifier
    public init(v: Vec1<T, Q>)
    public init<T2, Q2>(v: Vec3<T2, Q2>) where Q2 <: Qualifier
    public init<T2, Q2>(v: Vec4<T2, Q2>) where Q2 <: Qualifier

    public static func length(): Int64 { 2 }

    public operator func [](i: Int64): T
    public mut operator func [](i: Int64, value!: T): Unit
    public const func componentAt(i: Int64): T
}
```

#### extend 块 1：算术运算（`T <: Number<T>`）
```
extend<T, Q> Vec2<T, Q> where T <: Number<T>, Q <: Qualifier {
    @OverflowWrapping
    public operator func +(rhs: Vec2<T, Q>): Vec2<T, Q>
    @OverflowWrapping
    public operator func -(rhs: Vec2<T, Q>): Vec2<T, Q>
    @OverflowWrapping
    public operator func *(rhs: Vec2<T, Q>): Vec2<T, Q>
    @OverflowWrapping
    public operator func /(rhs: Vec2<T, Q>): Vec2<T, Q>
    @OverflowWrapping
    public operator func %(rhs: Vec2<T, Q>): Vec2<T, Q>
    @OverflowWrapping
    public operator func +(rhs: T): Vec2<T, Q>
    @OverflowWrapping
    public operator func -(rhs: T): Vec2<T, Q>
    @OverflowWrapping
    public operator func *(rhs: T): Vec2<T, Q>
    @OverflowWrapping
    public operator func /(rhs: T): Vec2<T, Q>
    @OverflowWrapping
    public operator func %(rhs: T): Vec2<T, Q>

    public operator func +(): Vec2<T, Q> { this }
    public operator func -(): Vec2<T, Q>

    @OverflowWrapping
    public func increment(): Vec2<T, Q> { this + T(1) }
    @OverflowWrapping
    public func decrement(): Vec2<T, Q> { this - T(1) }

    public func add(s: T): Vec2<T, Q> { this + s }
    public func sub(s: T): Vec2<T, Q> { this - s }
    public func mul(s: T): Vec2<T, Q> { this * s }
    public func div(s: T): Vec2<T, Q> { this / s }
    public func mod(s: T): Vec2<T, Q> { this % s }
}
```

#### extend 块 2：Vec-Vec 位运算（`T <: Integer<T>`）
```
extend<T, Q> Vec2<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public operator func &(rhs: Vec2<T, Q>): Vec2<T, Q>
    public operator func |(rhs: Vec2<T, Q>): Vec2<T, Q>
    public operator func ^(rhs: Vec2<T, Q>): Vec2<T, Q>
    @OverflowWrapping
    public operator func <<(rhs: Vec2<T, Q>): Vec2<T, Q>
    public operator func >>(rhs: Vec2<T, Q>): Vec2<T, Q>
    public func bitwiseNot(): Vec2<T, Q>
}
```

#### extend 块 3：标量右操作数位运算（`T <: Integer<T>`）
```
extend<T, Q> Vec2<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public operator func &(rhs: T): Vec2<T, Q>
    public operator func |(rhs: T): Vec2<T, Q>
    public operator func ^(rhs: T): Vec2<T, Q>
    @OverflowWrapping
    public operator func <<(shift: T): Vec2<T, Q>
    public operator func >>(shift: T): Vec2<T, Q>
}
```

#### extend 块 4：Vec1 算术广播（`T <: Number<T>`）
```
extend<T, Q> Vec2<T, Q> where T <: Number<T>, Q <: Qualifier {
    @OverflowWrapping
    public operator func +(rhs: Vec1<T, Q>): Vec2<T, Q>
    @OverflowWrapping
    public operator func -(rhs: Vec1<T, Q>): Vec2<T, Q>
    @OverflowWrapping
    public operator func *(rhs: Vec1<T, Q>): Vec2<T, Q>
    @OverflowWrapping
    public operator func /(rhs: Vec1<T, Q>): Vec2<T, Q>
    @OverflowWrapping
    public operator func %(rhs: Vec1<T, Q>): Vec2<T, Q>
}
```

#### extend 块 5：Vec1 位广播（`T <: Integer<T>`）
```
extend<T, Q> Vec2<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public operator func &(rhs: Vec1<T, Q>): Vec2<T, Q>
    public operator func |(rhs: Vec1<T, Q>): Vec2<T, Q>
    public operator func ^(rhs: Vec1<T, Q>): Vec2<T, Q>
    @OverflowWrapping
    public operator func <<(rhs: Vec1<T, Q>): Vec2<T, Q>
    public operator func >>(rhs: Vec1<T, Q>): Vec2<T, Q>
}
```

#### extend 块 6：比较运算（`T <: Equatable<T>`）
```
extend<T, Q> Vec2<T, Q> where T <: Equatable<T>, Q <: Qualifier {
    public operator func ==(rhs: Vec2<T, Q>): Bool
    public operator func !=(rhs: Vec2<T, Q>): Bool { !(this == rhs) }
    public func equalExact(other: Vec2<T, Q>): Bool
}
```

#### extend 块 7：Epsilon 比较（`T <: Number<T> & Equatable<T> & Comparable<T>`）
```
extend<T, Q> Vec2<T, Q> where T <: Number<T> & Equatable<T> & Comparable<T>, Q <: Qualifier {
    public func equalEpsilon(other: Vec2<T, Q>): Bool
}
```

#### extend 块 8：Bool 逻辑运算（特化 `Vec2<Bool, Q>`）
```
extend<Q> Vec2<Bool, Q> where Q <: Qualifier {
    public func logicalAnd(other: Vec2<Bool, Q>): Vec2<Bool, Q>
    public func logicalOr(other: Vec2<Bool, Q>): Vec2<Bool, Q>
}
```

### Vec3<T, Q>

**形态**：struct
**包路径**：`glm.detail`
**职责**：三维向量
**类型参数**：`T` — 分量类型（无紧约束）；`Q <: Qualifier`

#### struct 体定义
```
@Derive[Hashable]
public struct Vec3<T, Q> where Q <: Qualifier {
    public var x: T
    public var y: T
    public var z: T

    public init(scalar: T)
    public const init(x: T, y: T, z: T)

    public init<T2, Q2>(v: Vec3<T2, Q2>) where Q2 <: Qualifier
    public init<T2, Q2>(a: Vec2<T2, Q2>, b: T) where Q2 <: Qualifier
    public init<T2, Q2>(a: T, b: Vec2<T2, Q2>) where Q2 <: Qualifier
    public init<T2, Q2>(a: Vec1<T2, Q2>, b: T, c: T) where Q2 <: Qualifier
    public init<T2, Q2>(a: T, b: Vec1<T2, Q2>, c: T) where Q2 <: Qualifier
    public init<T2, Q2>(a: T, b: T, c: Vec1<T2, Q2>) where Q2 <: Qualifier
    public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>, c: T) where Q2 <: Qualifier
    public init<T2, Q2>(a: Vec1<T2, Q2>, b: T, c: Vec1<T2, Q2>) where Q2 <: Qualifier
    public init<T2, Q2>(a: T, b: Vec1<T2, Q2>, c: Vec1<T2, Q2>) where Q2 <: Qualifier
    public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>, c: Vec1<T2, Q2>) where Q2 <: Qualifier
    public init<T2, Q2>(a: Vec2<T2, Q2>, b: Vec1<T2, Q2>) where Q2 <: Qualifier
    public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec2<T2, Q2>) where Q2 <: Qualifier
    public init(v: Vec1<T, Q>)
    public init<T2, Q2>(v: Vec4<T2, Q2>) where Q2 <: Qualifier

    public static func length(): Int64 { 3 }

    public operator func [](i: Int64): T
    public mut operator func [](i: Int64, value!: T): Unit
    public const func componentAt(i: Int64): T
}
```

#### extend 块 1：算术运算（`T <: Number<T>`）
同 Vec2 算术 extend 模式，3 分量，包括 +,-,*,/,%, 一元 +/-, increment/decrement, add/sub/mul/div/mod。

#### extend 块 2：Vec-Vec 位运算（`T <: Integer<T>`）
同 Vec2 位运算模式，3 分量：&, |, ^, <<, >>, bitwiseNot。

#### extend 块 3：标量右操作数位运算（`T <: Integer<T>`）
同 Vec2 标量位运算模式：&(rhs: T), |(rhs: T), ^(rhs: T), <<(shift: T), >>(shift: T)。

#### extend 块 4：Vec1 算术广播（`T <: Number<T>`）
同 Vec2 Vec1 算术广播模式，3 分量：+,-,*,/,% 各接收 Vec1<T,Q>。

#### extend 块 5：Vec1 位广播（`T <: Integer<T>`）
同 Vec2 Vec1 位广播模式，3 分量：&, |, ^, <<, >> 各接收 Vec1<T,Q>。

#### extend 块 6：比较运算（`T <: Equatable<T>`）
同 Vec2 比较模式：==, !=, equalExact。

#### extend 块 7：Epsilon 比较（`T <: Number<T> & Equatable<T> & Comparable<T>`）
同 Vec2 epsilon 模式：equalEpsilon。

#### extend 块 8：Bool 逻辑运算（特化 `Vec3<Bool, Q>`）
同 Vec2 Bool 逻辑模式：logicalAnd, logicalOr。

### Vec4<T, Q>

**形态**：struct
**包路径**：`glm.detail`
**职责**：四维向量
**类型参数**：`T` — 分量类型（无紧约束）；`Q <: Qualifier`

#### struct 体定义
```
@Derive[Hashable]
public struct Vec4<T, Q> where Q <: Qualifier {
    public var x: T, y: T, z: T, w: T

    public init(scalar: T)
    public const init(x: T, y: T, z: T, w: T)

    public init<T2, Q2>(v: Vec4<T2, Q2>) where Q2 <: Qualifier
    public init<T2, Q2>(a: Vec3<T2, Q2>, b: T) where Q2 <: Qualifier
    public init<T2, Q2>(a: Vec3<T2, Q2>, b: Vec1<T2, Q2>) where Q2 <: Qualifier
    public init<T2, Q2>(a: T, b: Vec3<T2, Q2>) where Q2 <: Qualifier
    public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec3<T2, Q2>) where Q2 <: Qualifier
    public init<T2, Q2>(a: Vec2<T2, Q2>, b: Vec2<T2, Q2>) where Q2 <: Qualifier
    public init<T2, Q2>(a: Vec2<T2, Q2>, b: T, c: T) where Q2 <: Qualifier
    public init<T2, Q2>(a: T, b: Vec2<T2, Q2>, c: T) where Q2 <: Qualifier
    public init<T2, Q2>(a: T, b: T, c: Vec2<T2, Q2>) where Q2 <: Qualifier
    public init<T2, Q2>(a: Vec2<T2, Q2>, b: Vec1<T2, Q2>, c: T) where Q2 <: Qualifier
    public init<T2, Q2>(a: Vec2<T2, Q2>, b: T, c: Vec1<T2, Q2>) where Q2 <: Qualifier
    public init<T2, Q2>(a: T, b: Vec2<T2, Q2>, c: Vec1<T2, Q2>) where Q2 <: Qualifier
    public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec2<T2, Q2>, c: T) where Q2 <: Qualifier
    public init<T2, Q2>(a: Vec1<T2, Q2>, b: T, c: Vec2<T2, Q2>) where Q2 <: Qualifier
    public init<T2, Q2>(a: T, b: Vec1<T2, Q2>, c: Vec2<T2, Q2>) where Q2 <: Qualifier
    public init<T2, Q2>(a: Vec2<T2, Q2>, b: Vec1<T2, Q2>, c: Vec1<T2, Q2>) where Q2 <: Qualifier
    public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec2<T2, Q2>, c: Vec1<T2, Q2>) where Q2 <: Qualifier
    public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>, c: Vec2<T2, Q2>) where Q2 <: Qualifier
    // Vec1 + 3 标量组合
    public init<T2, Q2>(a: Vec1<T2, Q2>, b: T, c: T, d: T) where Q2 <: Qualifier
    public init<T2, Q2>(a: T, b: Vec1<T2, Q2>, c: T, d: T) where Q2 <: Qualifier
    public init<T2, Q2>(a: T, b: T, c: Vec1<T2, Q2>, d: T) where Q2 <: Qualifier
    public init<T2, Q2>(a: T, b: T, c: T, d: Vec1<T2, Q2>) where Q2 <: Qualifier
    public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>, c: T, d: T) where Q2 <: Qualifier
    public init<T2, Q2>(a: Vec1<T2, Q2>, b: T, c: Vec1<T2, Q2>, d: T) where Q2 <: Qualifier
    public init<T2, Q2>(a: Vec1<T2, Q2>, b: T, c: T, d: Vec1<T2, Q2>) where Q2 <: Qualifier
    public init<T2, Q2>(a: T, b: Vec1<T2, Q2>, c: Vec1<T2, Q2>, d: T) where Q2 <: Qualifier
    public init<T2, Q2>(a: T, b: Vec1<T2, Q2>, c: T, d: Vec1<T2, Q2>) where Q2 <: Qualifier
    public init<T2, Q2>(a: T, b: T, c: Vec1<T2, Q2>, d: Vec1<T2, Q2>) where Q2 <: Qualifier
    public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>, c: Vec1<T2, Q2>, d: T) where Q2 <: Qualifier
    public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>, c: T, d: Vec1<T2, Q2>) where Q2 <: Qualifier
    public init<T2, Q2>(a: Vec1<T2, Q2>, b: T, c: Vec1<T2, Q2>, d: Vec1<T2, Q2>) where Q2 <: Qualifier
    public init<T2, Q2>(a: T, b: Vec1<T2, Q2>, c: Vec1<T2, Q2>, d: Vec1<T2, Q2>) where Q2 <: Qualifier
    public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>, c: Vec1<T2, Q2>, d: Vec1<T2, Q2>) where Q2 <: Qualifier
    public init(v: Vec1<T, Q>)

    public static func length(): Int64 { 4 }

    public operator func [](i: Int64): T
    public mut operator func [](i: Int64, value!: T): Unit
    public const func componentAt(i: Int64): T
}
```

#### extend 块 1：算术运算（`T <: Number<T>`）
同 Vec2 算术 extend 模式，4 分量，包括 +,-,*,/,%, 一元 +/-, increment/decrement, add/sub/mul/div/mod。

#### extend 块 2：Vec-Vec 位运算（`T <: Integer<T>`）
同 Vec2 位运算模式，4 分量：&, |, ^, <<, >>, bitwiseNot。

#### extend 块 3：标量右操作数位运算（`T <: Integer<T>`）
同 Vec2 标量位运算模式：&(rhs: T), |(rhs: T), ^(rhs: T), <<(shift: T), >>(shift: T)。

#### extend 块 4：Vec1 算术广播（`T <: Number<T>`）
同 Vec2 Vec1 算术广播模式，4 分量：+,-,*,/,% 各接收 Vec1<T,Q>。

#### extend 块 5：Vec1 位广播（`T <: Integer<T>`）
同 Vec2 Vec1 位广播模式，4 分量：&, |, ^, <<, >> 各接收 Vec1<T,Q>。

#### extend 块 6：比较运算（`T <: Equatable<T>`）
同 Vec2 比较模式：==, !=, equalExact。

#### extend 块 7：Epsilon 比较（`T <: Number<T> & Equatable<T> & Comparable<T>`）
同 Vec2 epsilon 模式：equalEpsilon。

#### extend 块 8：Bool 逻辑运算（特化 `Vec4<Bool, Q>`）
同 Vec2 Bool 逻辑模式：logicalAnd, logicalOr。

### scalar_vec_ops.cj

**形态**：包级独立函数
**包路径**：`glm.detail`
**职责**：提供 scalar-op-vec 方向（标量在左、Vec 在右）的算术辅助函数

函数清单（5 运算 × 4 Vec = 20 个函数）：
```
@OverflowWrapping
public const func add<T, Q>(s: T, v: Vec1<T, Q>): Vec1<T, Q> where T <: Number<T>, Q <: Qualifier
@OverflowWrapping
public const func add<T, Q>(s: T, v: Vec2<T, Q>): Vec2<T, Q> where T <: Number<T>, Q <: Qualifier
// 同理 sub, mul, div, mod 各 4 个 Vec 版本

// 实现模式：
// add(s, v) => VecN(s + v.x, s + v.y, ...)
// sub(s, v) => VecN(s - v.x, s - v.y, ...)
// mul(s, v) => VecN(s * v.x, s * v.y, ...)
// div(s, v) => VecN(s / v.x, s / v.y, ...)
// mod(s, v) => VecN(s % v.x, s % v.y, ...)
```

每个函数标注 `@OverflowWrapping` 并声明为 `const` 以支持编译期调用，使用标量类型 `T` 的原生算术运算符逐分量运算。函数附加 `where T <: Number<T>` 约束，因为实现体需要对 T 执行算术运算。

`mod` 函数的 T 约束应为 `where T <: Integer<T>`（模运算仅对整数 T 有效）。

### type_fromBoolVec.cj

**形态**：包级独立函数
**包路径**：`glm.detail`
**职责**：Bool→Numeric 转换工厂函数

函数清单（Vec1~Vec4 × 2 版本 = 8 个函数）：
```
public func fromBoolVec<T, Q>(v: Vec1<Bool, Q>): Vec1<T, Q> where Q <: Qualifier
public func fromBoolVecQ2<T, Q, Q2>(v: Vec1<Bool, Q2>): Vec1<T, Q> where Q <: Qualifier, Q2 <: Qualifier
// 同理 Vec2~Vec4
```

实现模式：`VecN(if (v.x) { T(1) } else { T(0) }, ...)`
跨 Q 版本的 `VecN(...)` 调用若编译器不支持从返回值推断类型参数，须显式标注为 `VecN<T, Q>(...)`。

注意：`fromBoolVec` 的实现体 `T(1)` 和 `T(0)` 需要对 T 的构造调用。由于 T 无约束，此函数仅在 T 支持从 Int64 构造时可用（延迟错误，由 D5 策略覆盖）。

## 错误处理

- **下标越界**：`operator[]` 和 `componentAt` 检测索引范围，越界时调用 `assert(i >= Int64(0) && i < length())`
- **整数溢出**：二元算术运算符标注 `@OverflowWrapping`，复合赋值由编译器自动继承
- **位运算溢出**：`<<` 标注 `@OverflowWrapping`；`>>`, `&`, `|`, `^` 无溢出风险
- **`%` 运算**：整数 T 正常编译，浮点 T 在实例化时报编译错误（D5 延迟检查）
- **`increment`/`decrement`**：标注 `@OverflowWrapping`；对 Bool Vec 在实例化时报错误
- **`bitwiseNot`**：对 Float32/Float64 在实例化时报错误；对 Bool 可编译但行为与 C++ `~bvec` 不同（已知差异）

## 行为契约

### Vec 构造函数
- Vec1 仅有 `const init(x: T)`，无 `init(scalar: T)`（否则重载冲突）
- Vec2~Vec4 同时提供 `init(scalar: T)` 和 `const init(x, y, ...)`
- 跨类型转换构造使用 `T(v.x)` 显式类型转换，不使用 `where T2 <: T` 约束
- 跨分量数构造（如 Vec4 从 Vec3+T）按 GLSL 5.4.1 规范

### 算术运算符
- 定义在 `extend` 块中，约束 `T <: Number<T>`，标注 `@OverflowWrapping`
- 一元 `+` 返回 `this`，一元 `-` 返回逐分量取反
- Vec1 广播运算符定义在对应 extend 块中，标注 `@OverflowWrapping`

### 比较运算符
- `==` 委托 `ComputeEqual<T>.call(a, b)` 逐分量精确比较（在 `T <: Equatable<T>` extend 块中）
- `!=` 定义为 `!(this == rhs)`
- `equalExact`：IEEE 754 精确相等比较（`T <: Equatable<T>`）
- `equalEpsilon`：浮点容差比较（`T <: Number<T> & Equatable<T> & Comparable<T>`）

### 位运算符
- 定义在 `extend` 块中，约束 `T <: Integer<T>`
- `&`, `|`, `^` 不标注 `@OverflowWrapping`
- `<<` 标注 `@OverflowWrapping`
- `>>` 不标注
- `bitwiseNot` 使用 `!` 逐分量运算

### 下标访问
- 取值：`operator func [](i: Int64): T`，越界断言
- 赋值：`mut operator func [](i: Int64, value!: T): Unit`，越界断言
- const 版本：`const func componentAt(i: Int64): T`

## 依赖关系

| 文件 | 依赖 | 说明 |
|------|------|------|
| `type_vec1~4.cj` | `qualifier.cj`(Qualifier), `compute_vector_relational.cj`(ComputeEqual), `shim_assert.cj`(assert) | Q 约束、== 委托、下标越界断言 |
| `scalar_vec_ops.cj` | `type_vec1~4.cj`(VecN 类型), `qualifier.cj`(Qualifier) | 同包可见 |
| `type_fromBoolVec.cj` | `type_vec1~4.cj`(VecN 类型), `qualifier.cj`(Qualifier) | 同包可见 |

### 现有代码兼容性
- 删除 `type_vec_stubs.cj` 后，`vectorize.cj` 和 `compute_vector_decl.cj` 中同名的 `Vec1`~`Vec4` 类型引用仍有效（同包可见）
- 构造函数签名需兼容：`Functor1Vec1.call` 中的 `Vec1<R, Q>(callable(v.x))` 应匹配 `const init(x: T)`；`compute_vector_decl.cj` 中的 `VecN<T, Q>(...)` 构造应匹配 `const init(...)` 或 `init(scalar: T)`

### 测试文件依赖
| 文件 | 依赖 | 说明 |
|------|------|------|
| `type_vecN_test.cj` | 对应 `type_vecN.cj`, `qualifier.cj`, `shim_limits.cj` | 同包 `package glm.detail` |
| `scalar_vec_ops_test.cj` | `scalar_vec_ops.cj`, `type_vec1~4.cj` | 测试各方向函数 |
| `type_fromBoolVec_test.cj` | `type_fromBoolVec.cj`, `type_vec1~4.cj` | 测试 Bool→Numeric 转换 |

### 测试框架
- 使用 `std.unittest.*` + `std.unittest.testmacro.*`
- 测试文件声明 `package glm.detail`
- 使用 `@Test` 标注 + `@Expect` 断言宏

## Vec 关键设计约束（来自 task_v3.md §关键设计约束）

1. 所有 Vec 使用 `where Q <: Qualifier` 约束，不对 T 做紧约束（D5）
2. `const init` 与普通 `init` 不可同时存在相同参数列表（const README §3.2 规则 7）
3. Vec1 仅有 `const init(x: T)`，无 `init(scalar: T)`
4. **（修订）** 二元算术运算符**不在** struct 体内定义，改为在 `extend` 块中定义，约束 `T <: Number<T>`，标注 `@OverflowWrapping`
5. **（修订）** 位运算符在 `extend` 块中定义，约束 `T <: Integer<T>`，`& | ^` 不标注，`<<` 标注 `@OverflowWrapping`
6. **（修订）** `==` 委托 `ComputeEqual<T>.call`（`T <: Equatable<T>` extend 块），`!=` 取反
7. 复合赋值由编译器自动生成，不需要也不允许显式定义
8. **（修订）** vec-op-scalar 方向具名函数在 `T <: Number<T>` extend 块中委托给二元运算符（隐式继承 `@OverflowWrapping`）
9. **（修订）** scalar-op-vec 方向独立函数在签名上附加 `where T <: Number<T>`，直接标注 `@OverflowWrapping`
10. `%` 仅对整数 T 有效，浮点 T 在实例化时报错（D5 延迟检查）
11. 跨类型运算不支持，需调用方显式转换操作数（D15）
12. `<`/`<=`/`>`/`>=` 首轮不定义
13. `hashCode()` 通过 `@Derive[Hashable]` 自动生成

## 修订说明（v3 r2）
| 审查意见 | 修改措施 |
|---------|---------|
| [严重] 所有算术/位/比较/具名函数运算符依赖对 T 的运算符操作（`this.x + rhs.x`、`!this.x`、`ComputeEqual<T>.call(this.x, rhs.x)`、`T(1)` 等），但 Vec 结构体对泛型参数 T 无任何约束，仓颉语言泛型约束规则明确：无约束泛型参数只能传递/返回，不能进行任何操作 | 将所有运算符从 struct 体和无约束 extend 块移至带正确约束的 extend 块中：算术 `T <: Number<T>`、位运算 `T <: Integer<T>`、比较 `T <: Equatable<T>`、epsilon 比较 `T <: Number<T> & Equatable<T> & Comparable<T>`、Bool 逻辑特化 `VecN<Bool, Q>`。struct 体仅保留数据成员、构造函数、length()、operator[] 取值/赋值、componentAt（这些不依赖对 T 的运算符操作） |
| [严重] `increment()`/`decrement()` 实现 `this + T(1)` 中的 `T(1)` 表达式要求 T 具有接受 Int64 的构造函数，无约束 T 无法通过编译 | 移至 `T <: Number<T>` extend 块中，与算术运算符同一 extend 块声明 |
| [引申] scalar_vec_ops 函数的实现体也需要对 T 执行算术运算（如 `s + v.x`），需要适当约束 | 为 scalar_vec_ops 的 add/sub/mul/div 函数添加 `where T <: Number<T>`；mod 函数添加 `where T <: Integer<T>` |
| [引申] 关键设计约束第 4/5/6/8/9 条的描述需与实际签名位置的变更保持一致 | 同步更新关键设计约束的第 4/5/6/8/9 条，标注「（修订）」并更新描述 |
| [引申] 行为契约中关于运算符位置的描述需与实际签名位置一致 | 同步更新行为契约中算术、比较、位运算各节的描述，说明其所在 extend 块的约束 |
