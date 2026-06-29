# 任务指令（v2）

## 动作
NEW

## 任务描述
实现 GLM Phase 3 的四元数类型体系，包含以下 3 个文件：

### (a) `src/detail/type_quat.cj` — Quat<T,Q> 泛型结构体
- **包声明**: `package glm.detail`
- **依赖**: `Vec3<T,Q>`, `Vec4<T,Q>`, `Mat3x3<T,Q>`, `Mat4x4<T,Q>`（同包已有）
- **结构体定义**:
  - `@Derive[Hashable]` 泛型 struct `Quat<T, Q>` where `Q <: Qualifier`
  - 4 个 `public var x: T, y: T, z: T, w: T`
  - `public static func length(): Int64 { 4 }`
- **构造函数体系**（OOD §3.3）:
  1. `const init(x: T, y: T, z: T, w: T)` — 逐分量主构造，参数顺序 x/y/z/w（w 在后）
  2. `const init(s: T, v: Vec3<T, Q>)` — 标量 s 作 w，Vec3 的 xyz 作 xyz
  3. `init<Q2>(q: Quat<T, Q2>) where Q2 <: Qualifier` — 跨 Qualifier 构造，纯赋值
  4. `public static func identity(one: T): Quat<T, Q>` — 工厂：w=one, x/y/z=T(0)（T(0) 通过 `one - one` 演算）
  5. `public func fromQuat<U, P>(conv: (U) -> T, q: Quat<U, P>): Quat<T, Q> where P <: Qualifier` — 跨类型转换工厂
  6. `public func fromMat3(m: Mat3x3<T, Q>): Quat<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` — 内部调用同包 `quatCast(m)`
  7. `public func fromMat4(m: Mat4x4<T, Q>): Quat<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` — 提取 m.c0/c1/c2 三列构造 Mat3x3 后调 `quatCast`
  8. `public static func wxyz(w: T, x: T, y: T, z: T): Quat<T, Q>` — w 在前的工厂，返回 `Quat(x, y, z, w)`
- **下标运算符**（OOD §3.1）:
  - `operator func [](i: Int64): T` — match 0=>x, 1=>y, 2=>z, 3=>w，含 assert bounds check
  - `mut operator func [](i: Int64, value!: T): Unit` — 同上赋值版本
- **成员运算符**（定义在 extend 块中 `where T <: Number<T>, Q <: Qualifier`，OOD §3.4）:
  - 一元 `-()`（negative）
  - 二元 `+`, `-`, `*`（Hamilton 乘积）, `/`（两 Quat 间）
  - 二元 `*`(Quat×Vec3): `v + (cross(QuatVector, v) * q.w + cross(QuatVector, cross(QuatVector, v))) * T(Float64(2))` — 依赖 geometric.cj 向量 cross stub，运行时抛 stub
  - 二元 `*`(Quat×Vec4): `Vec4(q * Vec3(v), v.w)` — 同上传播 stub
  - 二元 `*`(Quat×T), `/`(Quat/T)
  - 比较 `==`, `!=`
- **Vec3×Quat / Vec4×Quat 运算符**（定义在 Vec3/Vec4 extend 块中，内联 conjugate/dot 路径）:
  - `operator func *(rhs: Quat<T, Q>): Vec3<T, Q>` — 内部 `(conjugate(q / dot(q, q))) * v`，通过 Quat×Vec3 依赖 geometric.cj stub
  - `operator func *(rhs: Quat<T, Q>): Vec4<T, Q>` — 同理，保留 w
- 所有算术运算符统一标注 `@OverflowWrapping`

### (b) `src/detail/type_quat_cast.cj` — 矩阵-四元数互转
- **包声明**: `package glm.detail`
- **依赖**: `Quat<T,Q>`, `Mat3x3<T,Q>`, `Mat4x4<T,Q>`, `Vec3<T,Q>`
- **4 个包级函数**（OOD §3.2.1）:
  1. `public func mat3Cast<T, Q>(q: Quat<T, Q>): Mat3x3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` — 逐元素填充：对角 T(Float64(1))，非对角 T(Float64(0))，再覆盖旋转分量
  2. `public func mat4Cast<T, Q>(q: Quat<T, Q>): Mat4x4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` — 同上，4×4
  3. `public func quatCast<T, Q>(m: Mat3x3<T, Q>): Quat<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` — trace/sqrt 路径
  4. `public func quatCast<T, Q>(m: Mat4x4<T, Q>): Quat<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` — 取左上 3×3 子矩阵后调 quatCast

### (c) `src/detail/scalar_quat_ops.cj` — 标量-四元数全局运算
- **包声明**: `package glm.detail`
- **4 个包级函数**（OOD §3.4）:
  1. `public func add<T, Q>(s: T, q: Quat<T, Q>): Quat<T, Q> where T <: Number<T>, Q <: Qualifier`
  2. `public func sub<T, Q>(s: T, q: Quat<T, Q>): Quat<T, Q> where T <: Number<T>, Q <: Qualifier`
  3. `public func mul<T, Q>(s: T, q: Quat<T, Q>): Quat<T, Q> where T <: Number<T>, Q <: Qualifier`
  4. `public func div<T, Q>(s: T, q: Quat<T, Q>): Quat<T, Q> where T <: Number<T>, Q <: Qualifier`

### 测试文件
- **`tests/glm/detail/test_type_quat.cj`**: Quat 构造、工厂函数、运算符、下标、length
- **`tests/glm/detail/test_type_quat_cast.cj`**: mat3Cast/mat4Cast/quatCast 正向反向验证
- **`tests/glm/detail/test_scalar_quat_ops.cj`**: add/sub/mul/div 标量-四元数运算

## 选择理由
四元数类型是阶段三所有 ext/gtc 模块的数据基础。fromMat3/fromMat4 工厂函数依赖同包 type_quat_cast.cj，合并为一轮消除编译依赖缺失。scalar_quat_ops.cj 紧耦合于 Quat 类型一并实现。R1 基础层（scalar_constants + trigonometric stubs）已通过验证，R2 可安全推进。

## 任务上下文
- OOD §3.1-§3.4 定义了 Quat 类型结构、构造函数体系（10 种）、运算符体系（成员 + Vec extend + 全局）
- OOD §3.2.1 定义了 type_quat_cast.cj 的 4 个转换函数签名（均 `where T <: FloatingPoint<T>`）
- OOD §2 确认 `glm.detail` 包无跨包 import 到 `glm.ext`，通过 `fromMat3`/`fromMat4` 调用同包 `type_quat_cast` 实现

## 已有代码上下文
- `src/detail/type_vec3.cj` — Vec3 泛型结构体，可作为 Quat 代码风格参考（`@Derive[Hashable]`、下标、extend 块运算符、`@OverflowWrapping` 标注模式）
- `src/detail/type_vec4.cj` — Vec4 结构体
- `src/detail/type_mat3x3.cj`, `src/detail/type_mat4x4.cj` — 矩阵类型，mat3Cast/mat4Cast 填充目标
- `src/detail/scalar_constants.cj` — epsilon/pi/cos_one_over_two 实现模式（`T(Float64(n))` 字面量 + 类型分派）
- R1 中 trigonometric.cj（75 stub）已提供三角函数的编译期签名解析依赖
