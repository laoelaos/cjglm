# 实现报告（v9）

## 概述

实现 Batch B-1：新建 4 个 gtc 模块源文件和 3 个对应测试文件。packing/ulp/round/type_precision 四个模块相互独立，各测试文件验证对应功能。

## 文件变更清单

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 新建 | `src/gtc/packing.cj` | 实现 32 个浮点数据打包/解包函数（packUnorm/packSnorm/packHalf/packDouble 系族），含 IEEE 754 Float32↔Float16 半精度位转换 |
| 新建 | `src/gtc/ulp.cj` | 实现 8 个 ULP 函数（next_float/prev_float/float_distance/ulp，Float32 + Float64 重载） |
| 新建 | `src/gtc/round.cj` | 实现 6 个泛型舍入函数（roundPowerOfTwo/ceilPowerOfTwo/floorPowerOfTwo/roundMultiple/ceilMultiple/floorMultiple，T <: FloatingPoint<T>） |
| 新建 | `src/gtc/type_precision.cj` | 实现 69 个 type 别名（fvec/dvec/ivec/uvec/i8vec/u8vec/i16vec/u16vec/i32vec/u32vec/i64vec/u64vec/hvec/fmat/dmat/fquat/dquat/hquat） |
| 新建 | `tests/glm/gtc/packing_test.cj` | 4 个 @Test 验证 pack↔unpack 互逆及边界值 |
| 新建 | `tests/glm/gtc/ulp_test.cj` | 5 个 @Test 验证 next_float/ulp/float_distance/prev_float 及边界 |
| 新建 | `tests/glm/gtc/round_test.cj` | 10 个 @Test 验证 PowerOfTwo/Multiple 舍入及 NaN/Inf 边界 |

## 编译验证

`cjpm build` 和 `cjpm test` 均通过。共 435 个测试用例全部 PASSED，无 ERROR 或 FAILED。

## 设计偏差说明

| 设计规格 | 偏差原因 | 实际处理 |
|---------|---------|---------|
| 构造函数使用 `T(Float64(n))`，如 `(Float64(1) as T).getOrThrow()` | 现有项目已广泛使用此模式 | 沿用，无偏差 |
| `toBits()` 返回类型：Float32→UInt32, Float64→UInt64, Float16→UInt16 | 设计已明确 | 正确使用 |
| `==` 在 `FloatingPoint<T>` 约束下不可用（IMPL-03） | round.cj 使用浮点比较 | 比较时转为 Float64 后比较 |
| 类型转换使用 `(value as TargetType).getOrThrow()`（IMPL-04） | 设计已明确 | packSnorm/unpackSnorm 中使用了 Int8→UInt8→UInt16 等链式位重解释转换 |
| 0x8000000000000001 UInt64 字面量 | 编译器将此解读为 Int64 字面量导致溢出 | 改为 `(UInt64(1) << 63) \| UInt64(1)` |
| round.cj 中 `absX = if (xF64 < 0.0) { -x } else { x }` | 无法使用泛型 `T` 的 `abs`（未定义 in FloatingPoint） | 使用 if-else 基于符号手动取绝对值 |
| `Float64.fromBits()` 参数类型 | 需传入 UInt64 | 使用 `UInt64(...)` 或位移构造 |
