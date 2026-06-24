# 详细设计（v14）

## 概述

为 9 个矩阵类型测试文件补充 Float32/Float64 浮点行为断言测试，回填 T6/T7 浮点变体。消除 T6→T16、T7→T16 前向依赖。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `tests/glm/detail/test_type_mat2x2.cj` | 修改追加 | Part 1: Float32/Float64 diagonal + col + scalar-mul 测试 |
| `tests/glm/detail/test_type_mat2x3.cj` | 修改追加 | 同上 |
| `tests/glm/detail/test_type_mat2x4.cj` | 修改追加 | 同上 |
| `tests/glm/detail/test_type_mat3x2.cj` | 修改追加 | 同上 |
| `tests/glm/detail/test_type_mat3x3.cj` | 修改追加 | 同上 |
| `tests/glm/detail/test_type_mat3x4.cj` | 修改追加 | 同上 |
| `tests/glm/detail/test_type_mat4x2.cj` | 修改追加 | 同上 |
| `tests/glm/detail/test_type_mat4x3.cj` | 修改追加 | 同上 |
| `tests/glm/detail/test_type_mat4x4.cj` | 修改追加 | 同上 |
| `tests/glm/detail/test_scalar_mat_ops.cj` | 修改追加 | Part 2: 24 个非方阵标量-矩阵运算 × Float32/Float64 |
| `tests/glm/detail/test_matrix.cj` | 修改追加 | Part 3: 12 个 matrixCompMult/outerProduct × Float32/Float64 |

## Part 1: 主覆盖（9 个 test_type_matNxM.cj 文件）

### 模式
每个文件末尾追加 6 个测试函数（3 场景 × 2 精度）。命名约定：

| 场景 | 精度 | 函数名模式 |
|------|------|-----------|
| `diagonal(scalar)` | Float32 | `testMat{N}x{M}DiagonalFloat32` |
| `diagonal(scalar)` | Float64 | `testMat{N}x{M}DiagonalFloat64` |
| `col(i)` | Float32 | `testMat{N}x{M}ColAccessFloat32` |
| `col(i)` | Float64 | `testMat{N}x{M}ColAccessFloat64` |
| scalar-matrix `*` | Float32 | `testMat{N}x{M}ScalarMulFloat32` |
| scalar-matrix `*` | Float64 | `testMat{N}x{M}ScalarMulFloat64` |

### 构造测试：`diagonal(scalar: T)`
- 使用 `Mat{N}x{M}<FP, Defaultp>.diagonal(FP(某个值))` 构造
- 断言：对角线位置 == scalar，非对角线位置 == FP(0)
- 注意：非方阵情况下对角线取 min(C,R) 个元素，其余超出部分为 FP(0)

### 列访问测试：`col(i: Int64)`
- 先用逐分量构造生成矩阵（所有元素为特定 FP 值）
- 对每个列 i 调用 `m.col(Int64(i))`，断言返回列向量与预期对照

### 算术运算测试：标量乘法
- 使用 `m * FP(标量)` 运算符
- 断言结果各分量等于原始分量乘以标量

**测试数据选取原则**：乘法运算使用 .5 结尾的浮点值（如 1.5, 2.5, 3.5），因 .5 = 2^(-1) 保证乘积 IEEE 754 精确可表示。除法运算需选择被除数/除数对使商精确可表示（如 `30.0 / 1.5 = 20.0`、`10.0 / 2.5 = 4.0`），避免非精确商导致的断言失败。

## Part 2: T6 回填（test_scalar_mat_ops.cj）

### 模式
为 T6 新增的 24 个非方阵 Int64 测试（testScalarAdd/Sub/Mul/Div 各 6 个非方阵类型）追加 Float32/Float64 变体。

命名约定：在现有 `testScalar<Op>Mat<N>x<M>Int64` 后面追加 `testScalar<Op>Mat<N>x<M>Float32` 和 `testScalar<Op>Mat<N>x<M>Float64`。

### 覆盖矩阵

| 运算 | 矩阵类型 | Int64 已有 | Float32 新增 | Float64 新增 |
|------|---------|-----------|-------------|-------------|
| add | Mat2x3/2x4/3x2/3x4/4x2/4x3 | 6 | 6 | 6 |
| sub | Mat2x3/2x4/3x2/3x4/4x2/4x3 | 6 | 6 | 6 |
| mul | Mat2x3/2x4/3x2/3x4/4x2/4x3 | 6 | 6 | 6 |
| div | Mat2x3/2x4/3x2/3x4/4x2/4x3 | 6 | 6 | 6 |

总计新增：48 个测试函数。

### 测试数据
- Float32: 使用 `Float32(1.5), Float32(2.5), ...` 等 .5 结尾值
- Float64: 使用 `Float64(2.5), Float64(4.0), Float64(5.0), Float64(8.0)` 等常用值
- 标量值：`Float32(3.0)`, `Float32(10.0)`, `Float64(10.0)` 等
- **除法专用值对**（保证商精确可表示）：
  - `30.0 / 1.5 = 20.0`, `10.0 / 2.5 = 4.0`, `1.5 / 1.5 = 1.0`, `5.0 / 2.5 = 2.0`
  - Float32/Float64 统一使用上述值对，各元素与标量按需组合

## Part 3: T7 回填（test_matrix.cj）

### 模式
为 T7 新增的 12 个 Int64 测试追加 Float32/Float64 变体。

### matrixCompMult 浮点变体（6 个缺失重载 × 2 精度 = 12 函数）
| 重载 | 已有的 Int64 | Float32 新增 | Float64 新增 |
|------|-------------|-------------|-------------|
| Mat2x4 | test_matrix.cj:323-336 | `testMatrixCompMultMat2x4Float32` | `testMatrixCompMultMat2x4Float64` |
| Mat3x2 | test_matrix.cj:338-349 | `testMatrixCompMultMat3x2Float32` | `testMatrixCompMultMat3x2Float64` |
| Mat3x3 | test_matrix.cj:351-365 | `testMatrixCompMultMat3x3Float32` | `testMatrixCompMultMat3x3Float64` |
| Mat3x4 | test_matrix.cj:367-384 | `testMatrixCompMultMat3x4Float32` | `testMatrixCompMultMat3x4Float64` |
| Mat4x2 | test_matrix.cj:386-399 | `testMatrixCompMultMat4x2Float32` | `testMatrixCompMultMat4x2Float64` |
| Mat4x3 | test_matrix.cj:401-418 | `testMatrixCompMultMat4x3Float32` | `testMatrixCompMultMat4x3Float64` |

### outerProduct 浮点变体（6 个缺失重载 × 2 精度 = 12 函数）
| 重载 | 已有的 Int64 | Float32 新增 | Float64 新增 |
|------|-------------|-------------|-------------|
| Vec2×Vec3 | test_matrix.cj:421-431 | `testOuterProductVec2Vec3Float32` | `testOuterProductVec2Vec3Float64` |
| Vec2×Vec4 | test_matrix.cj:433-446 | `testOuterProductVec2Vec4Float32` | `testOuterProductVec2Vec4Float64` |
| Vec3×Vec3 | test_matrix.cj:448-462 | `testOuterProductVec3Vec3Float32` | `testOuterProductVec3Vec3Float64` |
| Vec3×Vec4 | test_matrix.cj:464-481 | `testOuterProductVec3Vec4Float32` | `testOuterProductVec3Vec4Float64` |
| Vec4×Vec2 | test_matrix.cj:483-496 | `testOuterProductVec4Vec2Float32` | `testOuterProductVec4Vec2Float64` |
| Vec4×Vec3 | test_matrix.cj:498-515 | `testOuterProductVec4Vec3Float32` | `testOuterProductVec4Vec3Float64` |

总计新增：24 个测试函数。

## 错误处理
- 所有现有测试函数不做修改，仅在末尾追加
- 不涉及新的错误类型或异常处理
- 浮点运算使用原生 IEEE 754 语义（`@OverflowWrapping` 对浮点无害）

## 行为契约
- 每个追加的测试函数以 `@Test` 注解，函数名以 `test` 开头
- 使用 `@Expect(actual, expected)` 宏断言
- `diagonal(scalar)` 的 off-diagonal 元素通过 `scalar - scalar` 获取 T(0) 等价物
- Float32 字面量使用 `Float32(1.5)` 构造，Float64 使用 `Float64(2.5)` 或 `2.5`（仓颉自动推导）
- 测试函数追加位置：各文件末尾的最后一个 `}` 之后，保持与已有代码格式一致

## 依赖关系
- 依赖 `glm.detail` 包中 9 个矩阵类型及其 `diagonal`/`col`/算术运算符 API
- 依赖 `std.unittest.*` 和 `std.unittest.testmacro.*` 测试框架
- 依赖 `scalar_mat_ops.cj` 中 `add`/`sub`/`mul`/`div` 全局函数（Part 2）
- 依赖 `matrix.cj` 中 `matrixCompMult`/`outerProduct` 全局函数（Part 3）

## 修订说明（v14 r1）
| 审查意见 | 修改措施 |
|---------|---------|
| Part 2 浮点除法测试数据可能因 IEEE 754 非精确商导致断言失败 | 修订"测试数据选取原则"段落，区分乘法（.5 值安全）和除法（需精确可商值对）；Part 2 补充除法专用值对（`30.0/1.5=20.0` 等）保证商精确可表示 |
