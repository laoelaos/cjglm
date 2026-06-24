# 任务指令（v14）

## 动作
NEW

## 任务描述
**T16**: 均衡矩阵测试的 T 类型参数化覆盖。分三部分：

1. **主覆盖**：为 9 个矩阵类型（Mat2x2/Mat2x3/Mat2x4/Mat3x2/Mat3x3/Mat3x4/Mat4x2/Mat4x3/Mat4x4）的 `test_type_mat*.cj` 文件中各补充 Float32/Float64 变体测试，覆盖：
   - 1 个构造测试（如 `diagonal(scalar)` 或 `init(scalar: T)`）
   - 1 个列访问测试（`col(i)` 返回值与预期对照）
   - 1 个算术运算测试（矩阵-矩阵乘或标量-矩阵运算）
   - 各 × Float32/Float64 两个精度

2. **T6 回填**：为 `test_scalar_mat_ops.cj` 中 T6 新增的 24 个非方阵标量-矩阵运算测试追加 Float32/Float64 变体

3. **T7 回填**：为 `test_matrix.cj` 中 T7 新增的 12 个 matrixCompMult/outerProduct 测试追加 Float32/Float64 变体

目标文件：`test_type_mat2x2.cj`、`test_type_mat2x3.cj`、`test_type_mat2x4.cj`、`test_type_mat3x2.cj`、`test_type_mat3x3.cj`、`test_type_mat3x4.cj`、`test_type_mat4x2.cj`、`test_type_mat4x3.cj`、`test_type_mat4x4.cj`、`test_scalar_mat_ops.cj`、`test_matrix.cj`

## 选择理由
Route 表格顺序中的下一个待完成任务。T18 已验证 PASSED。T16 必须先于 T15（NaN 传播测试）完成（T16 建立浮点基础覆盖后 T15 才能执行 NaN 特定验证）。T6→T16、T7→T16 前向依赖需一并回填消除。

## 任务上下文
- 诊断报告 §4 T16（02_diag.md `:432-466`）：9 个矩阵类型行为断言测试均以 Int64 为唯一底层类型，缺少 Float32/Float64 浮点行为验证
- 覆盖标准（每类型 3 场景 × 2 精度）与 OOD §4.1 阶段 2 验证要求对齐
- T6→T16 前向依赖（02_diag.md `:71`）：T6 新增的 24 个非方阵测试仅在 Int64 上执行
- T7→T16 前向依赖（02_diag.md `:120`）：T7 新增的 12 个 matrixCompMult/outerProduct 测试仅在 Int64 上执行
- T16→T15 串行依赖（02_diag.md `:692`）：T16 先于 T15，NaN 测试依赖浮点基础覆盖

## 已有代码上下文
- 9 个 `test_type_mat*.cj` 文件：每个包含约 120-180 行 Int64 行为断言测试，模式为 `@Test func test*() { let m = MatNxM<Int64>(...) ... @Expect(...) }`
- `test_scalar_mat_ops.cj`：T6 末尾追加了 24 个 Int64 测试函数（参见 verify_v2.md）
- `test_matrix.cj`：T7 末尾追加了 12 个 matrixCompMult/outerProduct Int64 测试函数（参见 verify_v3.md）
- 已有 Float 测试模式参考：`test_type_mat4x4.cj` 中 6a/6b/7 变体 `conv: (Int64) -> Float64` 的跨类型转换测试可作为浮点矩阵实例化参考
