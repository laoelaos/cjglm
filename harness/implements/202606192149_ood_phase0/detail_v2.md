# 详细设计（v2）

## 概述

本设计对应 OOD Phase0 的 R2 02 核心抽象层。目标是实现三个核心抽象模块：`ComputeEqual<T>` 相等比较策略结构体（Vec `operator ==` 的逐分量比较委托）、Functor 映射体系（对标量函数逐分量映射到向量的调用模式）、ComputeVec* 运算策略体系（向量逐分量运算策略，为后续 SIMD 轮次预留扩展点）。首轮这些类型定义完整接口但不被 Vec 运算符消费，仅 `ComputeEqual` 将被后续 Vec 类型的 `==` 运算符直接调用。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `src/detail/compute_vector_relational.cj` | 新建 | 定义 `ComputeEqual<T>` 相等比较策略结构体 |
| `src/detail/vectorize.cj` | 新建 | 定义 Functor 映射体系（Functor1Vec1~Functor2VecIntVec4 共 16 个结构体） |
| `src/detail/compute_vector_decl.cj` | 新建 | 定义 ComputeVec* 运算策略结构体（13 策略族 × 4 分量数 = 52 个结构体） |
| `src/detail/compute_vector_relational_test.cj` | 新建 | ComputeEqual 单元测试（对 Int32/Float32/Float64/Bool 的 call/callConst 验证） |
| `src/detail/vectorize_test.cj` | 新建 | Functor 实例化和一元映射功能验证 |
| `src/detail/compute_vector_decl_test.cj` | 新建 | ComputeVec* 实例化和逐分量运算验证 |

## 类型定义

### ComputeEqual\<T\>

**形态**：struct
**包路径**：`glm.detail`
**职责**：提供分量级别的精确相等比较策略，Vec 的 `operator ==` 委托此类型做逐分量比较
**类型参数**：`T` — 分量类型（约束 `T <: Equatable<T>`）

```
public struct ComputeEqual<T> where T <: Equatable<T> {
    public static func call(a: T, b: T): Bool
}
```

**公开接口**：
- `static func call(a: T, b: T): Bool` — 精确比较，`a == b`

**构造方式**：无实例构造，全部为静态方法
**类型关系**：`where T <: Equatable<T>`

**实现说明**：
- `call` 方法体为 `a == b`，要求 `T` 实现 `Equatable<T>` 接口

### ComputeEqualNumeric\<T\>

**形态**：struct
**包路径**：`glm.detail`
**职责**：提供带 epsilon 容差的浮点感知相等比较策略，需要数值运算支持
**类型参数**：`T` — 分量类型（约束 `T <: Number<T>`）

```
public struct ComputeEqualNumeric<T> where T <: Number<T> {
    public static func callConst(a: T, b: T): Bool
}
```

**公开接口**：
- `static func callConst(a: T, b: T): Bool` — 带运行时分支的版本：通过 `isIec559Of(a)` 判断 `T` 是否为浮点类型，浮点路径使用 `abs(a - b) <= epsilonOf(a)` 容差比较，整数路径使用 `a == b` 精确比较

**构造方式**：无实例构造，全部为静态方法
**类型关系**：`where T <: Number<T>`（`Number<T>` 位于 `std.math` 包，提供算术运算支持）

**实现说明**：
- `callConst` 为非 const 函数（R1 中 `isIec559Of`/`epsilonOf` 为非 const 运行时函数，const 函数体内无法调用）
- 使用运行时 `if` 分支选择浮点/非浮点路径（非编译期 `if`，因此无需 const 上下文）
- 浮点路径调用 `std.math.abs` 包级函数，需 `import std.math.{ abs }`
- `epsilonOf(a)` 调用 `shim_limits.cj` 中的 `epsilonOf<T>(hint: T)`，传递 `a` 作为 hint
- 由于 `Number<T>` 约束限制，`ComputeEqualNumeric<Bool>` 不可实例化。——这与设计意图一致：`Bool` 类型的 epsilon 容差比较无意义，精确比较由 `ComputeEqual<Bool>.call` 提供

### Functor1VecN\<R, T, Q\>（N = 1~4）

**形态**：struct
**包路径**：`glm.detail`
**职责**：一元函数映射包装器，将 `(T) -> R` 函数逐分量映射到 `VecN<T, Q>` 的每个分量，返回 `VecN<R, Q>`

```
public struct Functor1Vec1<R, T, Q> where Q <: Qualifier {
    public static func call(callable: (T) -> R, v: Vec1<T, Q>): Vec1<R, Q>
}
public struct Functor1Vec2<R, T, Q> where Q <: Qualifier {
    public static func call(callable: (T) -> R, v: Vec2<T, Q>): Vec2<R, Q>
}
public struct Functor1Vec3<R, T, Q> where Q <: Qualifier {
    public static func call(callable: (T) -> R, v: Vec3<T, Q>): Vec3<R, Q>
}
public struct Functor1Vec4<R, T, Q> where Q <: Qualifier {
    public static func call(callable: (T) -> R, v: Vec4<T, Q>): Vec4<R, Q>
}
```

**公开接口**：
- `static call(callable: (T) -> R, v: VecN<T, Q>): VecN<R, Q>` — 对 v 的每个分量调用 callable，构造新 VecN<R, Q>

**构造方式**：无实例构造，静态方法

### Functor2VecN\<T, Q\>（N = 1~4）

**形态**：struct
**包路径**：`glm.detail`
**职责**：二元函数映射包装器，将 `(T, T) -> T` 函数逐分量映射到两个 `VecN<T, Q>` 的对应分量

```
public struct Functor2Vec1<T, Q> where Q <: Qualifier {
    public static func call(callable: (T, T) -> T, a: Vec1<T, Q>, b: Vec1<T, Q>): Vec1<T, Q>
}
public struct Functor2Vec2<T, Q> where Q <: Qualifier {
    public static func call(callable: (T, T) -> T, a: Vec2<T, Q>, b: Vec2<T, Q>): Vec2<T, Q>
}
public struct Functor2Vec3<T, Q> where Q <: Qualifier {
    public static func call(callable: (T, T) -> T, a: Vec3<T, Q>, b: Vec3<T, Q>): Vec3<T, Q>
}
public struct Functor2Vec4<T, Q> where Q <: Qualifier {
    public static func call(callable: (T, T) -> T, a: Vec4<T, Q>, b: Vec4<T, Q>): Vec4<T, Q>
}
```

### Functor2VecScaVecN\<T, Q\>（N = 1~4）

**形态**：struct
**包路径**：`glm.detail`
**职责**：向量-标量二元映射包装器，将 `(T, T) -> T` 函数逐分量应用到 `VecN<T, Q>` 的每个分量与标量值 `s: T` 之间

```
public struct Functor2VecScaVec1<T, Q> where Q <: Qualifier {
    public static func call(callable: (T, T) -> T, v: Vec1<T, Q>, s: T): Vec1<T, Q>
}
public struct Functor2VecScaVec2<T, Q> where Q <: Qualifier {
    public static func call(callable: (T, T) -> T, v: Vec2<T, Q>, s: T): Vec2<T, Q>
}
public struct Functor2VecScaVec3<T, Q> where Q <: Qualifier {
    public static func call(callable: (T, T) -> T, v: Vec3<T, Q>, s: T): Vec3<T, Q>
}
public struct Functor2VecScaVec4<T, Q> where Q <: Qualifier {
    public static func call(callable: (T, T) -> T, v: Vec4<T, Q>, s: T): Vec4<T, Q>
}
```

### Functor2VecIntVecN\<T, Q\>（N = 1~4）

**形态**：struct
**包路径**：`glm.detail`
**职责**：向量-整数向量二元映射包装器，将 `(T, Int64) -> T` 函数逐分量应用到 `VecN<T, Q>` 的每个分量与整数 `i: Int64` 之间（适用于移位操作分量索引等场景）

```
public struct Functor2VecIntVec1<T, Q> where Q <: Qualifier {
    public static func call(callable: (T, Int64) -> T, v: Vec1<T, Q>, i: Int64): Vec1<T, Q>
}
public struct Functor2VecIntVec2<T, Q> where Q <: Qualifier {
    public static func call(callable: (T, Int64) -> T, v: Vec2<T, Q>, i: Int64): Vec2<T, Q>
}
public struct Functor2VecIntVec3<T, Q> where Q <: Qualifier {
    public static func call(callable: (T, Int64) -> T, v: Vec3<T, Q>, i: Int64): Vec3<T, Q>
}
public struct Functor2VecIntVec4<T, Q> where Q <: Qualifier {
    public static func call(callable: (T, Int64) -> T, v: Vec4<T, Q>, i: Int64): Vec4<T, Q>
}
```

### compute_vec_addN\<T, Q\>（N = 1~4）

**形态**：struct
**包路径**：`glm.detail`
**职责**：逐分量加法运算策略

```
public struct compute_vec_add1<T, Q> where Q <: Qualifier {
    public static func call(a: Vec1<T, Q>, b: Vec1<T, Q>): Vec1<T, Q>
}
public struct compute_vec_add2<T, Q> where Q <: Qualifier {
    public static func call(a: Vec2<T, Q>, b: Vec2<T, Q>): Vec2<T, Q>
}
public struct compute_vec_add3<T, Q> where Q <: Qualifier {
    public static func call(a: Vec3<T, Q>, b: Vec3<T, Q>): Vec3<T, Q>
}
public struct compute_vec_add4<T, Q> where Q <: Qualifier {
    public static func call(a: Vec4<T, Q>, b: Vec4<T, Q>): Vec4<T, Q>
}
```

以下运算策略与 `compute_vec_add` 形态相同（仅命名和运算不同），均按 Vec1~Vec4 各定义四个版本：

| 策略结构体 | 内部运算 | call 返回类型 |
|-----------|---------|-------------|
| `compute_vec_sub{N}` | `a.x - b.x, ...` | `VecN<T, Q>` |
| `compute_vec_mul{N}` | `a.x * b.x, ...` | `VecN<T, Q>` |
| `compute_vec_div{N}` | `a.x / b.x, ...` | `VecN<T, Q>` |
| `compute_vec_mod{N}` | `a.x % b.x, ...` | `VecN<T, Q>` |
| `compute_vec_and{N}` | `a.x & b.x, ...` | `VecN<T, Q>` |
| `compute_vec_or{N}` | `a.x \| b.x, ...` | `VecN<T, Q>` |
| `compute_vec_xor{N}` | `a.x ^ b.x, ...` | `VecN<T, Q>` |
| `compute_vec_shift_left{N}` | `a.x << b.x, ...` | `VecN<T, Q>` |
| `compute_vec_shift_right{N}` | `a.x >> b.x, ...` | `VecN<T, Q>` |
| `compute_vec_equal{N}` | `a.x == b.x, ...` | `VecN<Bool, Q>` |
| `compute_vec_nequal{N}` | `a.x != b.x, ...` | `VecN<Bool, Q>` |
| `compute_vec_bitwise_not{N}` | `!a.x, ...` | `VecN<T, Q>` |

**命名约定**：数字后缀表示分量数，如 `compute_vec_add1`、`compute_vec_add2`、`compute_vec_add3`、`compute_vec_add4`。同理于其他 12 个策略族。

**公开接口**：每个结构体提供 `static func call(...)` 方法，签名为 `(VecN<T, Q>, VecN<T, Q>) -> VecN<T, Q>`（或 `(VecN<T, Q>,) -> VecN<T, Q>` 对 `bitwise_not` 一元运算）

## 错误处理

本层所有类型为纯数据运算策略结构体，不涉及运行时错误路径：
- `ComputeEqual` 的比较运算无异常抛出路径
- Functor 各 `call` 方法为纯映射（调用方传入的函数可能抛异常，但 Functor 本身不处理）
- ComputeVec* 各 `call` 方法为逐分量算术/位运算，遵循仓颉原生类型默认溢出策略（不标注 `@OverflowWrapping`，因首轮无消费方）

## 行为契约

### ComputeEqual\<T\> / ComputeEqualNumeric\<T\> 契约
- **ComputeEqual\<T\>.call(a, b)**：无条件精确比较 `a == b`。对 `Float32`/`Float64` 遵循 IEEE 754 精确相等语义（`NaN == NaN` 返回 `false`，`+0.0 == -0.0` 返回 `true`）。要求 `T <: Equatable<T>`，因此 `Bool`、`Int32`、`Float32`、`Float64` 等均可使用
- **ComputeEqualNumeric\<T\>.callConst(a, b)**：运行时分支——通过 `isIec559Of(a)` 判别 `T` 是否为浮点类型：
  - 浮点路径：`abs(a - b) <= epsilonOf(a)`，其中 `abs` 为 `std.math.abs`，`epsilonOf(a)` 为 `shim_limits.cj` 中的包级函数
  - 整数路径：`a == b` 精确比较
  - 要求 `T <: Number<T>`，因此仅适用于数值类型（`Int32`、`Float32`、`Float64` 等），不适用于 `Bool`
- **前/后置条件**：无

### Functor 契约
- 所有 `call` 方法为纯函数映射，对输入向量无副作用
- 调用方提供的 `callable` 函数被每个分量依次调用
- **首轮仅定义类型**，不参与 Vec 运算符实现消费，无运行期行为验证要求
- `Functor2VecInt` 的 `Int64` 参数约定为固定类型（不移位量使用 `LengthT`），保持与 `operator[]` 索引类型一致

### ComputeVec* 契约
- 所有 `call` 方法直接实现逐分量运算（非 SIMD 路径）
- 算术运算（add/sub/mul/div/mod）遵循仓颉原生类型运算语义
- 位运算（and/or/xor/shift_left/shift_right/bitwise_not）遵循仓颉原生类型位运算语义
- 相等比较运算（equal/nequal）返回 `VecN<Bool, Q>`，分量值 `true`/`false`
- **首轮仅定义类型**，未被 Vec 运算符消费，无运行期行为验证要求

## 依赖关系

### 模块间依赖
| 文件 | 依赖 | 说明 |
|------|------|------|
| `compute_vector_relational.cj` | `shim_limits.cj`（`isIec559Of`/`epsilonOf`）、`std.math.{ abs }` | 浮点容差比较路径的运行时函数依赖 |
| `vectorize.cj` | `qualifier.cj`（Qualifier） | `where Q <: Qualifier` 约束；Functor2VecInt 的 `Int64` 参数直接使用原始类型 |
| `compute_vector_decl.cj` | `vectorize.cj`（Functor 类型）、`qualifier.cj`（Qualifier） | `call` 方法委托给 Functor 做逐分量映射 |

**VecN 类型前向引用说明**：Functor 和 ComputeVec* 各结构体的 `call` 方法签名引用 `Vec1<T,Q>`~`Vec4<T,Q>` 类型，这些类型由后续层（type_vecN.cj 文件）定义。由于同属 `package glm.detail`，同包内类型名在编译期可见。此轮定义时 VecN 类型尚未实现——编码阶段可采用以下任一策略：
- 策略 A：在 `vectorize.cj` 和 `compute_vector_decl.cj` 中直接引用 VecN 类型，编译在 Vec 层文件创建后自动通过
- 策略 B：在本轮中创建最小 VecN 桩类型（仅含 `var` 成员和 `init` 构造函数，不含运算符），待 Vec 层实现时替换为完整定义

### 测试文件依赖
| 文件 | 依赖 | 说明 |
|------|------|------|
| `compute_vector_relational_test.cj` | `compute_vector_relational.cj`、`shim_limits.cj` | ComputeEqual.call 验证（所有 Equatable 类型）+ ComputeEqualNumeric.callConst 验证（数值类型） |
| `vectorize_test.cj` | `vectorize.cj`、`qualifier.cj` | Functor 实例化验证 |
| `compute_vector_decl_test.cj` | `compute_vector_decl.cj`、`vectorize.cj`、`qualifier.cj` | ComputeVec* 实例化验证 |

### 外部依赖
- `std.math.{ abs }` — `compute_vector_relational.cj` 中 `ComputeEqualNumeric.callConst` 的浮点容差路径
- `std.unittest.*` + `std.unittest.testmacro.*` — 测试框架标注 `@Test`/`@Expect`

### 暴露给后续任务的接口
本层提供的所有类型均在 `glm.detail` 包中，后续 Vec 类型层依赖：
- `ComputeEqual<T>.call(a, b)` — Vec 的 `operator ==` 和 `!=` 的逐分量精确比较委托
- `ComputeEqualNumeric<T>.callConst(a, b)` — Vec 的浮点 epsilon 容差比较委托
- Functor 体系 — 后续 SIMD 轮次 Vec 运算符实现可改为通过 Functor 映射
- ComputeVec* 体系 — 后续 SIMD 轮次可特化这些策略结构体替换为 SIMD 加速路径

### 设计偏差说明（相对 OOD 文档）
| 设计规格 | 偏差原因 | 实际处理 |
|---------|---------|---------|
| `ComputeEqual.callConst` 声明为 `const static func` | R1 `shim_limits.cj` 中的 `isIec559Of`/`epsilonOf` 为非 const 运行时函数，const 函数体内无法调用 | 移除 `const` 修饰符，改为运行时 `if` 分支路径。此修正与 R1 交付物接口对齐（参考 R1 code_v1.md 设计偏差说明及 task_v2.md 修订说明） |
| `ComputeEqual<T>` 同时提供 `call` 和 `callConst` | 仓颉运行时 `if` 的两个分支均需编译通过。`callConst` 的 then 分支包含 `a - b`、`abs(a - b)`、`epsilonOf(a)`，要求 `T` 为数值类型；对 `Bool` 等非数值类型编译不通过 | 将 `callConst` 拆分为独立的 `ComputeEqualNumeric<T> where T <: Number<T>` 结构体，`ComputeEqual<T>` 仅保留 `call`（约束 `where T <: Equatable<T>`）。此拆分确保精确比较对任意 `Equatable` 类型可用，epsilon 容差比较仅对数值类型提供 |

## 修订说明（v2 r1）
| 审查意见 | 修改措施 |
|---------|---------|
| [严重] `ComputeEqual<T>.callConst` 对非数值类型（如 Bool）编译不通过，与"对任意 T 均可用"的声明矛盾 | 采用方案 A：将 `callConst` 从 `ComputeEqual<T>` 分离，移到新的 `ComputeEqualNumeric<T> where T <: Number<T>` 结构体。`ComputeEqual<T>` 仅保留 `call`（精确比较，约束 `where T <: Equatable<T>`）。此拆分确保：`ComputeEqual<Bool>.call` 可通过编译；`ComputeEqualNumeric<Bool>` 因 `Number<Bool>` 约束不可实例化，与语义预期一致 |
| [一般] `ComputeEqual<T>.call` 使用 `a == b` 但缺少 `where T <: Equatable<T>` 约束 | 为 `ComputeEqual<T>` 添加 `where T <: Equatable<T>` 约束，确保 `call` 方法体内 `a == b` 可通过编译器类型检查 |
| [轻微] `vectorize.cj` 的依赖描述中 `shim_cstddef.cj`（LengthT）不必要 | 从 `vectorize.cj` 的依赖表中移除 `shim_cstddef.cj`；Functor2VecInt 的 `Int64` 参数直接使用原始类型（与 task_v2.md 签名一致），确认不需引入 `LengthT` |
