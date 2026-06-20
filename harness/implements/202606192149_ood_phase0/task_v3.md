# 任务指令（v3）

## 动作
NEW

## 任务描述
实现向量类型层，对应计划中的 **R3 03-向量类型层（Vec1~Vec4 + scalar_vec_ops + fromBoolVec）**。

### 总体说明
本任务将替换 `type_vec_stubs.cj` 中的 Vec1~Vec4 最小桩为完整定义，删除该桩文件。共创建/修改以下文件：

| 操作 | 文件 | 说明 |
|------|------|------|
| 新建 | `src/detail/type_vec1.cj` | Vec1<T,Q> 完整结构体 |
| 新建 | `src/detail/type_vec2.cj` | Vec2<T,Q> 完整结构体 |
| 新建 | `src/detail/type_vec3.cj` | Vec3<T,Q> 完整结构体 |
| 新建 | `src/detail/type_vec4.cj` | Vec4<T,Q> 完整结构体 |
| 新建 | `src/detail/scalar_vec_ops.cj` | scalar-op-vec 方向辅助函数 |
| 新建 | `src/detail/type_fromBoolVec.cj` | fromBoolVec/fromBoolVecQ2 工厂函数 |
| 新建 | `src/detail/type_vec1_test.cj` | Vec1 单元测试 |
| 新建 | `src/detail/type_vec2_test.cj` | Vec2 单元测试 |
| 新建 | `src/detail/type_vec3_test.cj` | Vec3 单元测试 |
| 新建 | `src/detail/type_vec4_test.cj` | Vec4 单元测试 |
| 新建 | `src/detail/scalar_vec_ops_test.cj` | scalar_vec_ops 单元测试 |
| 新建 | `src/detail/type_fromBoolVec_test.cj` | fromBoolVec 单元测试 |
| 删除 | `src/detail/type_vec_stubs.cj` | 被替换为各 type_vecN.cj |

### Vec 结构体通用设计（Vec1~Vec4）

#### 包声明
`package glm.detail`

#### 数据成员
- Vec1: `public var x: T`
- Vec2: `public var x: T, public var y: T`
- Vec3: `public var x: T, public var y: T, public var z: T`
- Vec4: `public var x: T, public var y: T, public var z: T, public var w: T`

数据成员无初始值。使用 `var` 而非 `let` 以支持自动生成的复合赋值。

#### 泛型签名
```cangjie
public struct Vec1<T, Q> where Q <: Qualifier { ... }
public struct Vec2<T, Q> where Q <: Qualifier { ... }
// 同理 Vec3/Vec4
```

#### length() 静态函数
```cangjie
public static func length(): Int64 { 1 }  // Vec1
public static func length(): Int64 { 2 }  // Vec2
// Vec3: 3, Vec4: 4
```

#### 构造函数体系（§4.1 OOD 文档）

**Vec2<T, Q>** 完整签名清单（供编码参考，Vec3/Vec4 类似扩展）：
- `public init(scalar: T)` — 标量填充构造
- `public const init(x: T, y: T)` — 逐分量构造（const）
- `public init<T2, Q2>(v: Vec2<T2, Q2>) where Q2 <: Qualifier` — 跨类型转换
- `public init<T2, Q2>(a: Vec1<T2, Q2>, b: T) where Q2 <: Qualifier` — Vec1 + 标量
- `public init<T2, Q2>(a: T, b: Vec1<T2, Q2>) where Q2 <: Qualifier` — 标量 + Vec1
- `public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>) where Q2 <: Qualifier` — Vec1 + Vec1
- `public init(v: Vec1<T, Q>)` — 从 Vec1 填充全部分量（仅同类型）
- `public init<T2, Q2>(v: Vec3<T2, Q2>) where Q2 <: Qualifier` — 从 Vec3 截断取 x,y
- `public init<T2, Q2>(v: Vec4<T2, Q2>) where Q2 <: Qualifier` — 从 Vec4 截断取 x,y

**Vec1<T, Q>** 特殊说明：
- 仅有 `public const init(x: T)` —— 兼任标量填充构造（不可同时定义 `public init(scalar: T)` 否则重载冲突）
- 跨类型转换：`init<T2, Q2>(v: Vec1<T2, Q2>) where Q2 <: Qualifier`
- 从 Vec2~Vec4 截断构造：`init<T2, Q2>(v: Vec2<T2, Q2>)` / Vec3 / Vec4

**Vec3<T, Q>** 额外构造函数（补充 Vec2 模式）：
- Vec2 + 标量 / 标量 + Vec2
- Vec1 + 标量 + 标量 / 标量 + Vec1 + 标量 / 标量 + 标量 + Vec1
- Vec1 + Vec1 + 标量 / Vec1 + 标量 + Vec1 / 标量 + Vec1 + Vec1
- Vec1 + Vec1 + Vec1
- Vec2 + Vec1 / Vec1 + Vec2
- 从 Vec4 截断取 x,y,z

**Vec4<T, Q>** 额外构造函数（补充 Vec3 模式）：
- Vec3 + 标量 / 标量 + Vec3
- Vec3 + Vec1 / Vec1 + Vec3
- Vec2 + Vec2
- Vec2 + 标量 + 标量 / 多种 Vec2/Vec1 组合（参见 OOD §4.1 完整清单）
- Vec1 + 3 标量 / 多种 Vec1 + 标量组合
- 所有 Vec1 4 参数组合（4 个 Vec1 等各种排列）

#### 下标运算符（§4.2）
```cangjie
public operator func [](i: Int64): T
public mut operator func [](i: Int64, value!: T): Unit
public const func componentAt(i: Int64): T
```
- 越界时调用 `assert(i >= Int64(0) && i < length())`

#### 算术运算符（§4.3，在 struct 体内定义）
Vec2 模板（Vec3/Vec4 类似扩展，Vec1 仅 x 分量）：
```cangjie
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
// VecN op T 版本（标量右操作数）
@OverflowWrapping
public operator func +(rhs: T): Vec2<T, Q>
// 同理 -, *, /, %
// 一元运算符（不标注 @OverflowWrapping）
public operator func +(): Vec2<T, Q> { this }
public operator func -(): Vec2<T, Q>
```

#### 比较运算符（§4.5，在 struct 体内或 extend 块）
```cangjie
public operator func ==(rhs: Vec2<T, Q>): Bool
public operator func !=(rhs: Vec2<T, Q>): Bool { !(this == rhs) }
```
- `==` 委托给 `ComputeEqual<T>.call`（精确比较逐分量），全分量相等返回 true
- `!=` 取反

#### Vec1 广播运算符（Vec2~Vec4 的 extend 块）
在 `type_vecN.cj` 的 `extend` 块中定义：
```cangjie
extend<T, Q> Vec2<T, Q> where Q <: Qualifier {
    @OverflowWrapping
    public operator func +(rhs: Vec1<T, Q>): Vec2<T, Q>
    @OverflowWrapping
    public operator func -(rhs: Vec1<T, Q>): Vec2<T, Q>
    // ... mul, div, %
    // 位运算广播（Vec2 & Vec1 等）
    public operator func &(rhs: Vec1<T, Q>): Vec2<T, Q>
    public operator func |(rhs: Vec1<T, Q>): Vec2<T, Q>
    public operator func ^(rhs: Vec1<T, Q>): Vec2<T, Q>
    @OverflowWrapping
    public operator func <<(rhs: Vec1<T, Q>): Vec2<T, Q>
    public operator func >>(rhs: Vec1<T, Q>): Vec2<T, Q>
}
```
Vec1 左操作数方向的广播（`Vec1 + Vec2` 等）在 `type_vec1.cj` 的 extend 块中定义。

#### 位运算符（§4.4，在 extend 块中定义）
```cangjie
extend<T, Q> Vec2<T, Q> where Q <: Qualifier {
    public operator func &(rhs: Vec2<T, Q>): Vec2<T, Q>
    public operator func |(rhs: Vec2<T, Q>): Vec2<T, Q>
    public operator func ^(rhs: Vec2<T, Q>): Vec2<T, Q>
    @OverflowWrapping
    public operator func <<(shift: T): Vec2<T, Q>
    public operator func >>(shift: T): Vec2<T, Q>
    // VecN op T 版本（标量右操作数）
    public operator func &(rhs: T): Vec2<T, Q>
    // 同理 |, ^, <<, >>
    public func bitwiseNot(): Vec2<T, Q>
}
```

#### extend 块具名函数（§4.3/§4.5）
```cangjie
extend<T, Q> Vec2<T, Q> where Q <: Qualifier {
    @OverflowWrapping
    public func increment(): Vec2<T, Q> { this + T(1) }
    @OverflowWrapping
    public func decrement(): Vec2<T, Q> { this - T(1) }
    // vec-op-scalar 方向（委托给二元运算符，通过委托隐式继承 @OverflowWrapping）
    public func add(s: T): Vec2<T, Q> { this + s }
    public func sub(s: T): Vec2<T, Q> { this - s }
    public func mul(s: T): Vec2<T, Q> { this * s }
    public func div(s: T): Vec2<T, Q> { this / s }
    public func mod(s: T): Vec2<T, Q> { this % s }  // 仅整数 T，浮点在实例化时报错
    public func equalExact(other: Vec2<T, Q>): Bool
    public func equalEpsilon(other: Vec2<T, Q>): Bool
    // 布尔逻辑（仅 Bool Vec）
    public func logicalAnd(other: Vec2<Bool, Q>): Vec2<Bool, Q>
    public func logicalOr(other: Vec2<Bool, Q>): Vec2<Bool, Q>
}
```

### `scalar_vec_ops.cj`（§4.3）
`package glm.detail`，定义 scalar-op-vec 方向包级独立函数（5 运算 × 4 Vec = 20 个函数）：
```cangjie
@OverflowWrapping
public func add<T, Q>(s: T, v: Vec1<T, Q>): Vec1<T, Q> where Q <: Qualifier
// 同理 Vec2~Vec4
// 同理 sub, mul, div, mod 各 4 个 Vec 版本
```
- 每个函数直接标注 `@OverflowWrapping`
- 声明为 `const` 函数以支持编译期调用
- Vec2~Vec4 还额外需要 `add(s: T, v: Vec2<T, Q>)` 等形式

### `type_fromBoolVec.cj`（§4.8）
`package glm.detail`，定义 Bool→Numeric 转换工厂函数（Vec1~Vec4 各 2 个版本 = 8 个函数）：
- `fromBoolVec<T, Q>(v: VecN<Bool, Q>): VecN<T, Q>` — 同 Q 版本
- `fromBoolVecQ2<T, Q, Q2>(v: VecN<Bool, Q2>): VecN<T, Q>` — 跨 Q 版本（显式标注类型参数 `<T, Q>` 避免编译器推断依赖）

实现模式：
```cangjie
public func fromBoolVec<T, Q>(v: Vec2<Bool, Q>): Vec2<T, Q> where Q <: Qualifier {
    Vec2(if (v.x) { T(1) } else { T(0) }, if (v.y) { T(1) } else { T(0) })
}
```

### 删除 `type_vec_stubs.cj`
删除文件 `src/detail/type_vec_stubs.cj`，其功能由各 type_vecN.cj 替代。

### 测试文件

本任务需为每个 Vec 类型创建相应的测试文件（`type_vecN_test.cj`），以及 `scalar_vec_ops_test.cj` 和 `type_fromBoolVec_test.cj`。所有测试文件声明 `package glm.detail`。

**Vec1~Vec4 测试覆盖**：
- 构造函数测试：标量填充、逐分量构造、跨类型转换、跨 Vec 转换、多元组合构造（Vec3/Vec4）
- 算术运算测试：`+ - * / %`（Vec op Vec 和 Vec op T），含不同类型分量（Int32, Float32, Float64, Bool）
- 一元运算符测试：`+v`, `-v`
- 比较运算测试：`==`（等值、不等值）、`!=`
- 下标访问测试：`[]` 取值和赋值、`componentAt`、越界断言
- 位运算测试（仅整数 T）：`& | ^ << >> bitwiseNot`
- 具名函数测试：`increment`/`decrement`、`add`/`sub`/`mul`/`div`/`mod`、`equalExact`、`equalEpsilon`、`logicalAnd`/`logicalOr`（仅 Bool Vec）
- Vec1 广播运算测试（Vec2~Vec4）：算术广播和位运算广播两个方向
- `length()` 静态方法验证

**scalar_vec_ops 测试**：
- 各函数（add/sub/mul/div/mod）对 Vec1~Vec4 的正确性验证
- 标量在左、Vec 在右的场景验证

**fromBoolVec 测试**：
- 对 Vec1~Vec4 的 fromBoolVec（同 Q）和 fromBoolVecQ2（跨 Q）验证
- 对各种目标类型 T（Int32, Float32, Float64）的转换正确性
- Bool→T(1)/T(0) 映射正确性验证

## 选择理由
Vec 结构体是 GLM 数学库的核心数据类型，是后续所有运算（向量运算、矩阵运算、函数库）的基础。R1 基础设施层和 R2 核心抽象层已验证通过，为 Vec 类型提供了完整的 Qualifier 体系、相等比较策略和运算策略基础设施。本任务将这些基础设施转化为可直接使用的向量类型，是首轮中最重要的实现层。

## 任务上下文
### 设计文档引用
- §3.2 Vec 结构体系（数据成员、const init、Hashable、字符串表示、类型形态选择理由）
- §4.1 向量构造（构造函数完整签名清单）
- §4.2 分量访问（operator[] + componentAt）
- §4.3 算术运算（二元运算符、一元运算符、@OverflowWrapping 标注、Vec1 广播、复合赋值由编译器自动生成）
- §4.4 位运算（extend 块中 & | ^ << >> bitwiseNot）
- §4.5 比较运算（== 委托 ComputeEqual.call、!= 取反、equalExact、equalEpsilon）
- §4.6 @OverflowWrapping 标注策略（标注分布：20 个二元算术运算符 + 4 个 << + 8 个 increment/decrement + 20 个 scalar-op-vec 函数 + 36 个 Vec1 广播运算符）
- §4.7 哈希契约（@Derive[Hashable]）
- §4.8 Bool→Numeric 转换工厂函数 fromBoolVec

### 关键设计约束
1. 所有 Vec 结构体使用 `where Q <: Qualifier` 约束，不对 T 做紧约束（D5）
2. `const init` 与普通 `init` 不可同时存在相同参数列表（const README §3.2 规则 7）
3. Vec1 仅有 `const init(x: T)`，无 `init(scalar: T)`（否则重载冲突）
4. 二元算术运算符在 struct 体内定义，直接标注 `@OverflowWrapping`
5. 位运算符在 extend 块中定义，`& | ^` 不标注，`<<` 标注 `@OverflowWrapping`
6. `==` 委托 `ComputeEqual<T>.call`（精确比较），`!=` 取反
7. 复合赋值由编译器自动生成，不需要也不允许显式定义
8. vec-op-scalar 方向具名函数委托给二元运算符（隐式继承 @OverflowWrapping）
9. scalar-op-vec 方向独立函数直接标注 `@OverflowWrapping`
10. `%` 仅对整数 T 有效，浮点 T 在实例化时报错（D5 延迟检查）
11. 跨类型运算不支持，需调用方显式转换操作数（D15）
12. `<`/`<=`/`>`/`>=` 首轮不定义（§4.5）
13. `hashCode()` 通过 `@Derive[Hashable]` 自动生成

### 现有 stub 替换注意
当前 `type_vec_stubs.cj` 定义了 Vec1~Vec4 的最小桩（仅 var 成员 + init 构造函数）。删除该文件后，确保：
- `vectorize.cj` 中 Functor 的 `call` 方法内构造函数调用（如 `Vec1<R, Q>(callable(v.x))`）与新 Vec 类型兼容
- `compute_vector_decl.cj` 中各 `call` 方法内的 VecN 构造与新 Vec 类型兼容

## 已有代码上下文
### R1 已验证通过的基础设施
- `setup.cj`：版本/配置常量（GLM_VERSION_MAJOR = 1, GLM_CONFIG_SIMD = false）
- `qualifier.cj`：Qualifier 接口 + PackedHighp/PackedMediump/PackedLowp + Defaultp
- `shim_limits.cj`：NumericLimits<T>.epsilon(), isIec559Of<T>(hint: T), epsilonOf<T>(hint: T)
- `shim_cstddef.cj`：SizeT/LengthT 类型别名
- `shim_assert.cj`：assert(condition, message?) 函数

### R2 已验证通过的核心抽象层
- `compute_vector_relational.cj`：ComputeEqual<T>.call(a,b) + ComputeEqualNumeric<T>.callConst(a,b)
- `vectorize.cj`：Functor1Vec1~Functor2VecIntVec4 共 16 个结构体
- `compute_vector_decl.cj`：compute_vec_add/sub/mul/div 等 52 个策略结构体

### 编码规范
- 遵循仓颉编码规范
- 不使用 `continue` 表达式
- 使用 `cjpm build` 验证编译通过
- 注意：测试文件可直接引用主代码中的 pubic 和 internal 类型（同包）

### 参考实现
C++ 源文件位于 `C:\Develop\Software\cjglm_wp\references\glm-1.0.3\glm\glm\detail\type_vec1.hpp`（type_vec1.inl）、type_vec2.hpp（type_vec2.inl）等，包含完整的运算符定义、构造函数清单和类型别名。
