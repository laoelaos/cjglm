# 详细设计（v2）

## 概述
实现 GLM Phase 3 detail 基础层的四元数类型体系：Quat<T,Q> 泛型结构体、矩阵-四元数互转函数、标量-四元数全局运算。R1（scalar_constants + trigonometric stubs）已通过验证，本回合推进 R2。

## 文件规划

### 源文件
| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `src/detail/type_quat.cj` | 新建 | Quat<T,Q> 泛型结构体 + 成员运算符 + Vec3/Vec4 extend 块运算符 |
| `src/detail/type_quat_cast.cj` | 新建 | mat3Cast/mat4Cast/quatCast 包级转换函数 |
| `src/detail/scalar_quat_ops.cj` | 新建 | 标量-四元数全局运算 add/sub/mul/div |

### 测试文件
| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `tests/glm/detail/test_type_quat.cj` | 新建 | Quat 构造、工厂函数、运算符、下标、length |
| `tests/glm/detail/test_type_quat_cast.cj` | 新建 | mat3Cast/mat4Cast/quatCast 正向反向验证 |
| `tests/glm/detail/test_scalar_quat_ops.cj` | 新建 | add/sub/mul/div 标量-四元数运算 |

## 类型定义

### Quat<T, Q>

**形态**：struct
**包路径**：`glm.detail`
**职责**：表示数学四元数的值对象，用于旋转表达和插值运算
**类型签名**：
```cangjie
@Derive[Hashable]
public struct Quat<T, Q> where Q <: Qualifier {
    public var x: T
    public var y: T
    public var z: T
    public var w: T
}
```

**公开接口**：
- `const init(x: T, y: T, z: T, w: T)` — 逐分量主构造，参数顺序 x/y/z/w（w 在后），纯赋值
- `init(s: T, v: Vec3<T, Q>)` — 标量 s 作 w，Vec3 的 xyz 作 xyz（与 Vec 类型向量参数构造函数一致，为非 const init）
- `public static func length(): Int64 { 4 }`
- `public static func wxyz(w: T, x: T, y: T, z: T): Quat<T, Q>` — w 在前工厂，返回 `Quat(x, y, z, w)`
- `operator func [](i: Int64): T` — match 0=>x, 1=>y, 2=>z, 3=>w，含 assert bounds check
- `mut operator func [](i: Int64, value!: T): Unit` — 同上赋值版本

**无约束 extend 块 — 静态工厂函数**：
- `public static func fromQuat<U, P>(conv: (U) -> T, q: Quat<U, P>): Quat<T, Q> where P <: Qualifier` — 跨类型+跨 Qualifier 转换工厂
- `public static func fromQual<Q2>(q: Quat<T, Q2>): Quat<T, Q> where Q2 <: Qualifier` — 跨 Qualifier 转换工厂（替代原 init<Q2>）

**Number<T> 约束 extend 块 — 静态工厂函数**：
- `public static func identity(one: T): Quat<T, Q> where T <: Number<T>, Q <: Qualifier` — 单位四元数工厂：w=one, x/y/z=T(0)（通过 `one - one` 演算）

**FloatingPoint<T> 约束 extend 块 — 静态工厂函数**：
- `public static func fromMat3(m: Mat3x3<T, Q>): Quat<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` — 内部调用同包 `quatCast(m)`
- `public static func fromMat4(m: Mat4x4<T, Q>): Quat<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` — 直接调用同包 `quatCast(m)`（Mat4x4 重载），消除与 quatCast(Mat4x4) 的重复

**构造方式**：
- 直接调用 `Quat(x, y, z, w)`
- 调用 `Quat(s, vec3)`（非 const init）
- 调用 `Quat.identity(one)`、`Quat.wxyz(w, x, y, z)` 或 `Quat.fromQual(other)` 工厂
- 调用 `Quat.fromQuat(conv, other)` / `Quat.fromMat3(m)` / `Quat.fromMat4(m)`

**类型关系**：无继承，含 Q <: Qualifier 约束

### 成员运算符（extend 块，where T <: Number<T>, Q <: Qualifier）

```cangjie
extend<T, Q> Quat<T, Q> where T <: Number<T>, Q <: Qualifier {
    public operator func -(): Quat<T, Q>  // 逐分量否定（与 Vec3/Mat3x3/Mat4x4 一元 `-` 风格一致，不标注 @OverflowWrapping）

    @OverflowWrapping
    public operator func +(rhs: Quat<T, Q>): Quat<T, Q>
    @OverflowWrapping
    public operator func -(rhs: Quat<T, Q>): Quat<T, Q>
    @OverflowWrapping
    public operator func *(rhs: Quat<T, Q>): Quat<T, Q>  // Hamilton 乘积
    @OverflowWrapping
    public operator func /(rhs: Quat<T, Q>): Quat<T, Q>

    @OverflowWrapping
    public operator func *(rhs: Vec3<T, Q>): Vec3<T, Q>  // ⚠️ 运行时抛 stub
    @OverflowWrapping
    public operator func *(rhs: Vec4<T, Q>): Vec4<T, Q>  // ⚠️ 运行时抛 stub

    @OverflowWrapping
    public operator func *(rhs: T): Quat<T, Q>
    @OverflowWrapping
    public operator func /(rhs: T): Quat<T, Q>
}

> `operator /(Quat, Quat)` 内联 conjugate+dot 路径：`this * (Quat(-rhs.x, -rhs.y, -rhs.z, rhs.w) / (rhs.x*rhs.x + rhs.y*rhs.y + rhs.z*rhs.z + rhs.w*rhs.w))`，所有操作均在 Number\<T\> 约束内完成，无 ext 依赖。
```

**Vec3<T,Q> / Vec4<T,Q> extend 块成员运算符**（定义在 type_quat.cj 中，同包内扩展 Vec3/Vec4）：

```cangjie
extend<T, Q> Vec3<T, Q> where T <: Number<T>, Q <: Qualifier {
    @OverflowWrapping
    public operator func *(rhs: Quat<T, Q>): Vec3<T, Q>  // ⚠️ 运行时抛 stub
}

extend<T, Q> Vec4<T, Q> where T <: Number<T>, Q <: Qualifier {
    @OverflowWrapping
    public operator func *(rhs: Quat<T, Q>): Vec4<T, Q>  // ⚠️ 运行时抛 stub
}
```

**比较运算符**（extend 块，where T <: Equatable<T>, Q <: Qualifier）：

实现策略：使用 `ComputeEqual<T>.call()` 逐分量比较，与已有 Vec3/Mat3x3 类型完全一致。

```cangjie
extend<T, Q> Quat<T, Q> where T <: Equatable<T>, Q <: Qualifier {
    public operator func ==(rhs: Quat<T, Q>): Bool { ComputeEqual<T>.call(this.x, rhs.x) && ComputeEqual<T>.call(this.y, rhs.y) && ComputeEqual<T>.call(this.z, rhs.z) && ComputeEqual<T>.call(this.w, rhs.w) }
    public operator func !=(rhs: Quat<T, Q>): Bool { !(this == rhs) }
}
```

## type_quat_cast.cj — 矩阵-四元数互转

**包路径**：`glm.detail`

**依赖**：Quat<T,Q>, Mat3x3<T,Q>, Mat4x4<T,Q>, Vec3<T,Q>（同包）

**4 个包级函数**：

```cangjie
public func mat3Cast<T, Q>(q: Quat<T, Q>): Mat3x3<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier

public func mat4Cast<T, Q>(q: Quat<T, Q>): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier

public func quatCast<T, Q>(m: Mat3x3<T, Q>): Quat<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier

public func quatCast<T, Q>(m: Mat4x4<T, Q>): Quat<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier
```

## scalar_quat_ops.cj — 标量-四元数全局运算

**包路径**：`glm.detail`

**依赖**：Quat<T,Q>

**4 个包级函数**：

```cangjie
@OverflowWrapping
public func add<T, Q>(s: T, q: Quat<T, Q>): Quat<T, Q>
  where T <: Number<T>, Q <: Qualifier

@OverflowWrapping
public func sub<T, Q>(s: T, q: Quat<T, Q>): Quat<T, Q>
  where T <: Number<T>, Q <: Qualifier

@OverflowWrapping
public func mul<T, Q>(s: T, q: Quat<T, Q>): Quat<T, Q>
  where T <: Number<T>, Q <: Qualifier

@OverflowWrapping
public func div<T, Q>(s: T, q: Quat<T, Q>): Quat<T, Q>
  where T <: Number<T>, Q <: Qualifier
```

## 错误处理

- **算术异常**：整数除零时触发仓颉 `ArithmeticException`；浮点除零产生 Inf/NaN
- **下标越界**：通过 `assert` 做 bounds check，越界时 `throw Exception`
- **重载问题**：一元 `+` 运算符仓颉不支持重载（与 deviations.md IF-01 一致），直接使用 `q`
- **复合赋值**：`+=`/`-=`/`*=`/`/=` 由编译器自动生成
- **stub 函数**：`Quat×Vec3`/`Quat×Vec4`/`Vec3×Quat`/`Vec4×Quat` 内部依赖 geometric.cj 的 `cross` stub，运行时抛 `Exception("stub")`
- **非 stub**：`operator /(Quat, Quat)` 内联 conjugate+dot 路径实现，不依赖 ext 模块

## 行为契约

- `Quat<T, Q>` 是值类型，运算符返回新实例、无副作用
- `length()` 返回常量 4（编译期常量）
- `identity(one)` 返回 w=one, x/y/z=T(0) 的单位四元数，T(0) 通过 `one - one` 演算
- 下标 `[]` 索引范围 0~3，越界 `assert` 失败并抛 Exception
- `fromMat3(m)`/`fromMat4(m)` 仅对纯旋转矩阵产生有意义的四元数；对非旋转矩阵行为未定义
- `mat3Cast`/`mat4Cast`/`quatCast` 仅对 `T <: FloatingPoint<T>` 编译可用，整数 T 实例化时报类型不匹配错误
- 所有算术运算符统一标注 `@OverflowWrapping`
- Bool 四元数不支持算术运算（`Bool` 不实现 `Number<T>`），仅支持 `==`/`!=`
- `operator /(Quat, Quat)` 内联 conjugate+dot 路径实现：`this * (conjugate(rhs) / dot(rhs, rhs))`，conjugate 通过分量取负实现，dot 通过分量平方和实现，均在 `Number<T>` 约束内
- 跨 Qualifier 工厂 `fromQual<Q2>` 纯赋值，不改变分量值

## 依赖关系

**type_quat.cj** 依赖：
- `Vec3<T,Q>` — 构造函数 `init(s: T, v: Vec3<T,Q>)`、`Quat×Vec3`/`Vec3×Quat`
- `Vec4<T,Q>` — `Quat×Vec4`/`Vec4×Quat`
- `Mat3x3<T,Q>` — `fromMat3`
- `Mat4x4<T,Q>` — `fromMat4`
- `type_quat_cast.cj`（同包）— `fromMat3`/`fromMat4` 内部调用 `quatCast`
- `geometric.cj` — `Quat×Vec3` 运算符内部依赖 `cross`（当前 stub）
- `std.math.{Number, FloatingPoint}` — 泛型约束
- `std.deriving.*` — `@Derive[Hashable]`

**type_quat_cast.cj** 依赖：
- `Quat<T,Q>` — 参数/返回类型
- `Mat3x3<T,Q>`, `Mat4x4<T,Q>` — 参数/返回类型
- `Vec3<T,Q>` — 矩阵列访问
- `std.math.FloatingPoint` — 泛型约束

**scalar_quat_ops.cj** 依赖：
- `Quat<T,Q>` — 参数/返回类型
- `std.math.Number` — 泛型约束

## 设计偏差

### 设计偏差 1：`init<Q2>` 构造函数替换为 `fromQual<Q2>` 静态工厂
- **设计规格（task_v2.md）**：要求实现 `init<Q2>(q: Quat<T, Q2>) where Q2 <: Qualifier` 跨 Qualifier 构造函数
- **偏差原因**：泛型构造函数 `init<Q2>` 在仓颉中存在编译器风险——多泛型参数构造函数可能与现有构造函数的类型推断产生歧义，且同包 Vec/Mat 类型均未使用此类泛型构造函数，采用静态工厂模式更为可靠
- **实际处理**：移除 `init<Q2>`，替换为 `public static func fromQual<Q2>(q: Quat<T, Q2>): Quat<T, Q> where Q2 <: Qualifier`，与 `fromQuat` 并行置于无约束 extend 块中

### 设计偏差 2：`fromQuat` 实例方法改为静态工厂
- **设计规格（task_v2.md）**：`public func fromQuat<U, P>(conv: (U) -> T, q: Quat<U, P>): Quat<T, Q> where P <: Qualifier`（实例方法）
- **偏差原因**：`fromQuat` 的语义是"用转换函数和源四元数构造新四元数"，与实例状态无关；改为 `public static func` 使其调用方式更清晰（`Quat.fromQuat(fn, src)`），与 `fromMat3`/`fromMat4` 等工厂保持一致的静态风格
- **实际处理**：改为 `public static func fromQuat<U, P>(conv: (U) -> T, q: Quat<U, P>): Quat<T, Q> where P <: Qualifier`，置于无约束 extend 块中

### 设计偏差 3：`fromMat3` 实例方法改为静态工厂
- **设计规格（task_v2.md）**：`public func fromMat3(m: Mat3x3<T, Q>): Quat<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier`（实例方法）
- **偏差原因**：`fromMat3` 从矩阵构造四元数，与实例状态无关；改为 `public static func` 使其调用更直观（`Quat.fromMat3(m)`），与 OOD 设计中工厂函数的静态语义一致
- **实际处理**：改为 `public static func fromMat3(m: Mat3x3<T, Q>): Quat<T, Q> ...`，置于 FloatingPoint<T> 约束 extend 块中

### 设计偏差 4：`fromMat4` 实例方法改为静态工厂
- **设计规格（task_v2.md）**：`public func fromMat4(m: Mat4x4<T, Q>): Quat<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier`（实例方法）
- **偏差原因**：同 `fromMat3`，工厂语义的静态化处理
- **实际处理**：改为 `public static func fromMat4(m: Mat4x4<T, Q>): Quat<T, Q> ...`，置于 FloatingPoint<T> 约束 extend 块中

### 设计偏差 5：`init(s: T, v: Vec3<T, Q>)` 由 const 改为非 const
- **设计规格（task_v2.md）**：要求 `const init(s: T, v: Vec3<T, Q>)`
- **偏差原因**：同包 Vec2/3/4 类型的向量参数构造函数均为非 `const init`（如 `Vec3.init(v: Vec1<T, Q>)` 无 const 修饰），一致性要求对齐
- **实际处理**：改为 `init(s: T, v: Vec3<T, Q>)`（非 const），保持与同包类型相同的初始化风格

## 测试方案

### test_type_quat.cj
- package: `glm.detail`
- 构造测试：逐分量构造 `Quat(1, 2, 3, 4)` → `@Expect q (1,2,3,4)`
- 标量+向量构造：`Quat(1.0, Vec3(2.0,3.0,4.0))` → w=1.0, x=2.0, y=3.0, z=4.0
- 跨 Qualifier 工厂 `fromQual`
- identity 工厂测试：`Quat.identity(1)` → `(0, 0, 0, 1)`
- wxyz 工厂测试：`Quat.wxyz(1,2,3,4)` → `(2, 3, 4, 1)`
- fromQuat 跨类型转换：Float32←Float64
- fromMat3 工厂：单位四元数 → `fromMat3` → 验证单位矩阵 → `quatCast` 往返验证
- fromMat4 工厂：构造含旋转的 Mat4x4 → `fromMat4` → `mat4Cast` 往返验证（单位四元数→Mat4x4→fromMat4→mat4Cast 对比原始 Mat4x4）
- length 测试：`Quat.length()` → 4
- 下标测试：[] 取值和赋值
- 运算符测试：+, -, *, /, 一元 -, ==, !=
- Quat×T, Quat/T 运算

### test_type_quat_cast.cj
- package: `glm.detail`
- mat3Cast 正向验证：单位四元数 → 单位矩阵
- quatCast(mat3) → mat3Cast 往返验证
- quatCast(mat4) → mat4Cast 往返验证
- mat4Cast: 验证 4×4 结果矩阵正确性

### test_scalar_quat_ops.cj
- package: `glm.detail`
- add/sub/mul/div 标量左运算，验证各分量值
- 每个函数至少 1 个测试用例
- 使用 Int64 类型（与 scalar_vec_ops.cj 测试惯例一致）

## 修订说明（v2 r1）

| 审查意见 | 修改措施 |
|---------|---------|
| `@OverflowWrapping` 标注不一致 — `-(Quat)`, `*(Quat×Quat)`, `/(Quat×Quat)`, `*(Vec4)`, `/(T)` 及 Vec3/Vec4 extend 块的 `*(Quat)` 缺少标注 | 在 Quat 成员运算符 extend 块中为 `-(Quat)`, `*(Quat×Quat)`, `/(Quat×Quat)`, `*(Vec4)`, `/(T)` 补齐 `@OverflowWrapping`；在 Vec3/Vec4 extend 块的 `*(Quat)` 前补上 `@OverflowWrapping`。一元 `-` 保留原有 `@OverflowWrapping` 不变（逐分量否定涉及取负运算，整数 MIN_VALUE 取负有溢出风险）。 |
| `fromMat3`/`fromMat4` 工厂函数缺少成员级测试 | 在 `test_type_quat.cj` 测试方案中补充 `fromMat3` 和 `fromMat4` 的测试用例描述：`fromMat3` 单位四元数 → 单位矩阵 → `quatCast` 往返验证；`fromMat4` 含旋转 Mat4x4 → 提取三列 → 验证四元数分量。 |

## 修订说明（v2 r2）

| 审查意见 | 修改措施 |
|---------|---------|
| [严重] fromQuat/fromMat3/fromMat4 设计为实例方法，与项目惯例及语义要求不符 | 三个方法改为 `public static func`。fromMat3/fromMat4 归入 FloatingPoint<T> 约束 extend 块；fromQuat 归入无约束 extend 块。更新构造方式和测试方案中对应的调用方式。 |
| [一般] identity(one) 的位置说明歧义 | 从 struct 公开接口列表移入 Number<T> 约束 extend 块小节，明确标注其约束依赖。 |
| [一般] init<Q2> 跨 Qualifier 构造存在编译器风险 | 移除 init<Q2> 构造函数，替换为静态工厂 `fromQual<Q2>(q: Quat<T, Q2>): Quat<T, Q>`，与 fromQuat 并行放在无约束 extend 块中。 |

## 修订说明（v2 r3）

| 审查意见 | 修改措施 |
|---------|---------|
| [一般] 任务规范偏差：`init<Q2>` 构造函数被替换为 `fromQual<Q2>` 但设计正文未在独立偏差说明中标注 | 新增"设计偏差"章节（位于"依赖关系"与"测试方案"之间），显式声明替换原因：泛型构造函数在仓颉中的编译器风险，以及采用与同包 Vec/Mat 一致的静态工厂模式 |
| [一般] `fromMat4` 描述与 `quatCast(Mat4x4)` 重复嫌疑：描述为"提取三列构造 Mat3x3 后调 quatCast"，但 type_quat_cast 已含 `quatCast(Mat4x4)` 重载 | 将 `fromMat4` 实现策略更新为"直接调用同包 `quatCast(m)`（Mat4x4 重载）"，消除重复和歧义 |
| [轻微] `const init(s: T, v: Vec3<T, Q>)` 与 Vec 类型约定不一致（Vec 的向量参数构造函数均为非 `const init`） | 改为 `init(s: T, v: Vec3<T, Q>)`（非 const），与同包 Vec2/3/4 的向量参数构造函数风格一致 |
| [轻微] 一元 `-` 的 `@OverflowWrapping` 标注与现有类型不一致（Vec3/Mat3x3/Mat4x4 一元 `-` 均不标注） | 移除一元 `-` 的 `@OverflowWrapping` 标注，与同包类型 API 风格保持一致 |
| [轻微] `fromMat4` 测试描述"验证四元数分量合理性"过于模糊 | 更新为明确的往返验证方案：`mat4Cast` 往返（单位四元数→Mat4x4→fromMat4→mat4Cast 对比原始 Mat4x4） |
| [轻微] 设计未提及 `componentAt(i: Int64): T` 函数 | 不采纳。`componentAt` 为 Vec 类型的非运算符下标访问替代，Quat 已有 `operator func []`，且任务规范未要求此函数。按"只设计当前任务需要的部分"原则，不增加此 API |

## 修订说明（v2 r4）

| 审查意见 | 修改措施 |
|---------|---------|
| [一般] 设计偏差章节不完整，未覆盖 `fromQuat`/`fromMat3`/`fromMat4` 实例→静态、`const init`→非 `const init` 四个偏差 | 在设计偏差章节新增偏差 2~5，分别记录 `fromQuat`、`fromMat3`、`fromMat4` 从实例方法改为静态工厂（静态语义更清晰、调用更直观），以及 `init(s, v)` 从 const 改为非 const（与同包 Vec 类型初始化风格一致） |
| [轻微] `operator ==` 的实现策略未明确 | 在"比较运算符"小节中补充实现策略说明：使用 `ComputeEqual<T>.call()` 逐分量比较，与已有 Vec3/Mat3x3 类型完全一致；代码块中的签名也同步补全了函数体实现 |

## 修订说明（v2 r5）

| 审查意见 | 修改措施 |
|---------|---------|
| [一般] `operator /(Quat, Quat)` 的语义未指定：实现方式（内联 conjugate+dot 或 stub）不明确 | 选择内联 conjugate+dot 路径实现（`this * (conjugate(rhs) / dot(rhs, rhs))`），所有操作均在 `Number<T>` 约束内完成。在 Quat 成员运算符 extend 块中补充实现注释，在"错误处理"小节标记为非 stub，在"行为契约"小节明确实现策略。反对 stub 方案，因为依赖均在 `Number<T>` 内，无需 ext 模块，可实现完整语义。 |
