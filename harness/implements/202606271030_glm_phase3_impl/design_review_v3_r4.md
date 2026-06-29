# 设计审查报告（v3 r4）

## 审查结果
REJECTED

## 发现

### [严重] 泛型 T 的零值/壹值构造模式不可编译

设计在 10 处以上的实现说明和代码示例中使用 `T(Float64(0))` / `T(Float64(1))` / `T(0)` 作为泛型类型 `T` 的零值或壹值构造语法（`normalize` 第 70 行、`quaternion_relational` 第 115-118 行、`vector_relational` 第 185 行、`lerp` 第 236 行、`axis` 第 270-272 行、错误处理第 365/369 行、行为契约第 376 行、测试设计第 464 行等）。**仓颉编译器不支持通过泛型类型参数构造实例**——在 `where T <: FloatingPoint<T>` 或 `where T <: Number<T>` 的泛型函数体内，`T(Float64(0))` 和 `T(0)` 都无法通过编译。上一轮编码阶段（code_v1.md 第 22-23 行）已明确验证此限制，实际使用 `(Float64(0.0) as T).getOrThrow()` 模式。设计未采纳已验证的工作模式，照此编码将产出不可编译的代码。

**期望的修正方向**：将设计文档中所有 `T(Float64(0))`、`T(Float64(1))`、`T(0)`、`T(1)` 的泛型构造用法统一修正为 `(Float64(n) as T).getOrThrow()` 模式（与 `type_quat_cast.cj:122-124` 的 `sqrtT` 和同文件第 7 行的 `let one: T = (Float64(1.0) as T).getOrThrow()` 一致）。零值也可通过 `one - one` 演算获得。

### [一般] vector_relational.cj ULP 函数计数内部不一致

设计第 132 行称 "24 个包级函数（16 epsilon 重载 + 8 ULP stub）"，但第 168 行的详细节明确显示 ULP 重载为 16 个（Vec1~Vec4 × 4 重载/Vec）。v3 r2 修订说明第 485 行已承认此错误并声称修正为 "16 个重载"，但修正未实现在第 132 行的摘要中。此不一致会导致实施者对文件规模产生错误预期，也无法通过 16+8=24 与实际的 16+16=32 之间的核对检查。

**期望的修正方向**：将第 132 行的 "24 个包级函数（16 epsilon 重载 + 8 ULP stub）" 修正为 "32 个包级函数（16 epsilon 重载 + 16 ULP stub）"。

### [轻微] lerp 缺少 `@OverflowWrapping` 注解说明

`lerp` 函数约束为 `Number<T> & Comparable<T>`（整数类型也可实例化），其实现 `x * (T(Float64(1)) - a) + y * a` 包含乘法和加法运算。现有代码库中所有 `Number<T>` 约束下的算术运算均一致使用 `@OverflowWrapping` 注解（`scalar_quat_ops.cj:5-27`、`type_quat.cj:88-136`），设计未提及此注解。虽不影响浮点类型（溢出到 Inf），但对整数 T 实例化时缺少 `@OverflowWrapping` 可能导致溢出行为不一致。

**期望的修正方向**：在 `lerp` 函数签名前标注 `@OverflowWrapping`，或新增一条说明：因 `lerp` 的 `Number<T>` 约束允许整数实例化，实现时须标注 `@OverflowWrapping` 以匹配代码库惯例。

## 修改要求（仅 REJECTED 时）

### 问题 1：泛型 T 值构造模式错误（严重）

- **问题**：设计使用 `T(Float64(0))` / `T(0)` 等语法构造泛型 T 的零值和壹值，该语法在仓颉泛型上下文中不可编译——编译器无法确认泛型类型参数 T 拥有接受 `Float64` 或 `Int64` 的构造函数。
- **期望修正**：替换所有 `T(Float64(n))` / `T(0)` / `T(1)` 泛型构造用法为已验证的 `(Float64(n) as T).getOrThrow()` 模式。需要修改的具体位置：`normalize`（第 70 行）、`quaternion_relational`（第 115-118 行）、`vector_relational`（第 185 行）、`lerp`（第 236 行）、`axis`（第 270-272 行）、错误处理表（第 365/369 行）、行为契约（第 376/382 行）、测试设计（第 464 行）以及设计各处作为代码示例或实现说明出现的类似构造。

### 问题 2：ULP 函数计数不一致（一般）

- **问题**：第 132 行摘要写 "8 ULP stub"，第 168 行详细节写 "16 个重载"，r2 修订说明声称已修正但未落实。
- **期望修正**：将第 132 行 "24 个包级函数（16 epsilon 重载 + 8 ULP stub）" 修正为 "32 个包级函数（16 epsilon 重载 + 16 ULP stub）"。
