# 设计审查报告（v2 r1）

## 审查结果
REJECTED

## 发现

### **[严重]** `ComputeEqual<T>.callConst` 对非数值类型（如 `Bool`）编译不通过，与"对任意 T 均可用"的声明矛盾

- **问题**：`ComputeEqual<T>` 声明为"无约束泛型"，且明确声称"对任意 T 均可用：非数值类型（如 Bool）参与 callConst 时走 else 分支精确比较，无编译错误"。但 `callConst` 的 then 分支体包含 `a - b`、`abs(a - b)`、`epsilonOf(a)`，其中：
  - `a - b`：要求 `T` 支持减法运算符
  - `abs(a - b)`：`std.math.abs` 仅支持数值类型（Float16/32/64, Int8/16/32/64），不支持 `Bool`
  - `epsilonOf(a)`：`epsilonOf<T>(hint: T)` 的签名包含 `where T <: Number<T>`
- **为什么是问题**：Cang Jie 的运行时 `if` 分支两个分支均需编译通过。当 `T = Bool` 时，then 分支无法编译（即使运行时永不进入），导致 `ComputeEqual<Bool>.callConst` 编译失败。这意味着：
  1. 设计声明与实际可编译类型不匹配
  2. 测试文件中对 `Bool` 调用 `callConst` 将无法通过编译
- **期望的修正方向**：
  - 方案 A：将 `callConst` 从 `ComputeEqual<T>` 分离，移到单独的约束结构体（如 `ComputeEqualNumeric<T> where T <: Number<T>`），仅对数值类型提供 epsilon 容差比较
  - 方案 B：明确标注 `callConst` 仅支持 `T <: Number<T>`，并为 `Bool` 等非数值类型的测试仅验证 `call` 而非 `callConst`
  - 方案 C：如果需求要求同一类型同时提供精确比较和 epsilon 容差比较，可采用重载策略——`ComputeEqual<T>` 提供 `call`（无约束，仅 `a == b`），另以独立泛型函数或特化提供 `callConst`

### **[一般]** `ComputeEqual<T>.call` 使用 `a == b` 但缺少 `where T <: Equatable<T>` 约束

- **问题**：`ComputeEqual<T>` 声明为无约束泛型，但 `call` 方法体为 `a == b`。在 Cang Jie 中，`==` 运算符要求类型实现 `Equatable<T>` 接口（参考：枚举文档"枚举默认不实现 Equatable 接口，不能直接使用 == 比较枚举值"，以及集合文档"相等比较（需要 T <: Equatable<T>）"）。无约束泛型只能传递/返回值，不能调用运算符。
- **为什么是问题**：虽然 `Int32`、`Float32`、`Float64`、`Bool` 均已实现 `Equatable<T>`，但结构体定义层面缺少约束会导致编译器对类型参数 `T` 执行 `a == b` 时报错。
- **期望的修正方向**：为 `ComputeEqual<T>` 添加 `where T <: Equatable<T>` 约束，确保 `call` 中的 `a == b` 可编译。

### **[轻微]** `vectorize.cj` 的依赖描述中 `shim_cstddef.cj`（LengthT）不必要

- **问题**：设计方案中的依赖表声明 `vectorize.cj` 依赖 `shim_cstddef.cj` 中的 `LengthT`（并注明"Functor2VecInt 的 `Int64` 参数使用 `LengthT`"），但实际类型定义中参数为 `i: Int64`（直接使用原始类型），而非 `LengthT`。由于 `LengthT` 和 `Int64` 是同一类型，功能上等同，但依赖关系描述与实际代码不一致，且 `shim_cstddef.cj` 的 import 对 `vectorize.cj` 无实际用处。
- **期望的修正方向**：统一处理——要么实际使用 `LengthT` 类型（保持与 `shim_cstddef.cj` 的关联），要么从 `vectorize.cj` 的依赖表中移除 `shim_cstddef.cj`。
