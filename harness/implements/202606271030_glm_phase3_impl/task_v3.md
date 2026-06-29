# 任务指令（v3）

## 动作
NEW

## 任务描述
实现 `glm.ext` 包下全部 ~14 个文件：

### (a) 完整实现文件（5 个）
- **`src/ext/quaternion_geometric.cj`** — dot/length/normalize/cross 四个四元数几何函数。所有函数约束 `where T <: FloatingPoint<T>, Q <: Qualifier`。dot 纯算术内联；length 调用 dot + std.math.sqrt；normalize 零四元数保护返回 `Quat(T(Float64(0)), T(Float64(0)), T(Float64(0)), T(Float64(1)))`；cross 即 Hamilton 乘积逐分量展开。
- **`src/ext/quaternion_relational.cj`** — equal/notEqual 精确+epsilon 共 4 函数。精确比较使用 `==`；epsilon 比较使用内联 abs 模式（`let d = x - y; if (d >= T(0) { d } else { -d }`）避免 common.cj stub 依赖。
- **`src/ext/vector_relational.cj`** — 16 个 epsilon 重载（equal/notEqual 各含标量 epsilon 和 Vec 向量 epsilon，× Vec1~Vec4）+ 8 个 ULP 重载 stub（equal/notEqual 含 int ULPs 和 VecN<int,Q> ULPs，× Vec1~Vec4）。epsilon 版本内联 abs 模式。约束 `where T <: Number<T> & Comparable<T>, Q <: Qualifier`。ULP 版本函数体 `throw Exception("stub")`。
- **`src/ext/quaternion_common.cj`** — conjugate（const func，无约束）、inverse（`conjugate(q) / dot(q,q)`，约束 `where T <: FloatingPoint<T>`）、lerp（含 `assert(a >= 0 && a <= 1)`）、isnan/isinf（依赖 `FloatingPoint<T>` 实例方法）+ mix/slerp×2 stub（`throw Exception("stub")`）。约束 `where T <: Number<T>`（lerp）/ `where T <: FloatingPoint<T>`（inverse/isnan/isinf）。
- **`src/ext/quaternion_trigonometric.cj`** — axis 完整实现（公式 `tmp1 = T(Float64(1)) - x.w*x.w`；若 `tmp1 <= T(Float64(0))` 返回 `Vec3(T(Float64(0)), T(Float64(0)), T(Float64(1)))`；否则 `tmp2 = T(Float64(1)) / std.math.sqrt(tmp1)` 返回 `Vec3(x.x*tmp2, x.y*tmp2, x.z*tmp2)`）+ angle/angleAxis stub。

### (b) stub 文件（5 个）
- **`src/ext/quaternion_transform.cj`** — rotate 1 函数 stub
- **`src/ext/quaternion_exponential.cj`** — exp/log/pow/sqrt 4 函数 stub
- **`src/ext/matrix_projection.cj`** — 空桩（至少 1 个函数签名如 `perspective`）
- **`src/ext/matrix_clip_space.cj`** — 空桩（至少 1 个函数签名如 `ortho`）
- **`src/ext/matrix_transform.cj`** — 空桩（至少 1 个函数签名如 `translate`）

### (c) 别名文件（4 个）
- **`src/ext/quaternion_float.cj`** — `type quat = Quat<Float32, PackedHighp>`
- **`src/ext/quaternion_double.cj`** — `type dquat = Quat<Float64, PackedHighp>`
- **`src/ext/quaternion_float_precision.cj`** — `type highp_quat = Quat<Float32, Highp>` / `mediump_quat = Quat<Float32, Mediump>` / `lowp_quat = Quat<Float32, Lowp>`
- **`src/ext/quaternion_double_precision.cj`** — `type highp_dquat = Quat<Float64, Highp>` / `mediump_dquat = Quat<Float64, Mediump>` / `lowp_dquat = Quat<Float64, Lowp>`

### 测试文件（5 个）
- `tests/glm/ext/test_quaternion_geometric.cj` — dot/length/normalize/cross 正例 + normalize 零四元数保护 + 非单位四元数 normalize
- `tests/glm/ext/test_quaternion_relational.cj` — equal/notEqual 精确+epsilon 正例 + 边界（epsilon 极小/零）
- `tests/glm/ext/test_vector_relational.cj` — 16 epsilon 重载每类至少 1 用例 + ULP stub assertThrows
- `tests/glm/ext/test_quaternion_common.cj` — conjugate/inverse/lerp/isnan/isinf 正例 + mix/slerp stub assertThrows + inverse 零除边界
- `tests/glm/ext/test_quaternion_trigonometric.cj` — axis 正例（单位四元数/非单位/零四元数）+ angle/angleAxis stub assertThrows

## 选择理由
R2（四元数类型体系）已通过验证后，ext/ 函数库是下一层依赖——quaternion_geometric 和 vector_relational 无 stub 依赖，可先行完整实现，其产出直接供给 quaternion_common（依赖 dot/length）和 quaternion_trigonometric（依赖 std.math.sqrt）。stub 文件（quaternion_transform/exponential/matrix_*）和别名文件（仅 1-3 行声明）与完整实现文件同步创建，合并为同一批减少轮次循环。测试文件与源文件一一对应，每个测试文件覆盖正例 + 边界 + stub 异常路径。

## 任务上下文
- 全部 ~14 个文件同属 `package glm.ext`，相互依赖链在同一包内可编译时解析（无包间循环依赖风险）
- quaternion_geometric 的 4 个函数不依赖任何 stub（dot/cross 纯算术，length/normalize 依赖 std.math.sqrt），可完整实现
- vector_relational 的 epsilon 版本函数体内 abs 内联为 `let d = x - y; (d >= T(0)) ? d : -d` 避免 common.cj stub 依赖
- quaternion_common 的 conjugate 声明为 `const func`（仅逐分量取反）；inverse 约束 `T <: FloatingPoint<T>` 阻止整数 T 编译；lerp 不可声明 const（含 assert）
- axis 函数内 T(1) 通过 `T(Float64(1))` 字面量替代路径获取（无需 `one: T` 形参）
- 别名文件命名与 GLM 1.0.3 习惯一致（quat/dquat/highp_quat 等）

## 已有代码上下文
- `src/detail/type_quat.cj` — Quat<T,Q> 结构体已实现，含运算符/工厂/下标/length
- `src/detail/type_quat_cast.cj` — mat3Cast/mat4Cast/quatCast 已实现
- `src/detail/scalar_quat_ops.cj` — add/sub/mul/div 已实现
- `src/detail/scalar_constants.cj` — epsilon/pi/cos_one_over_two 已实现
- `src/detail/trigonometric.cj` — 75 个三角函数 stub 签名已存在
- `src/ext/scalar_constants.cj` — public import 重导出已存在
- 已有 Vec1~Vec4、Mat3x3、Mat4x4 类型可用
- fwd.cj（自动生成）和 lib.cj（手动维护）将在 R5 统一更新
