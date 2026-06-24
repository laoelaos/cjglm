# 详细设计（v15）

## 概述

为 3 个代表性矩阵类型（Mat4x4 / Mat2x3 / Mat3x2）补充 Float32/Float64 NaN 传播行为测试，覆盖 Mat×Vec（矩阵含 NaN 列）、Vec×Mat（向量含 NaN 分量）、NaN 对角矩阵 × 正常向量三种场景。全部测试追加至 `tests/glm/detail/test_matrix.cj` 末尾。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| tests/glm/detail/test_matrix.cj | 追加 | 追加 18 个 NaN 传播测试函数（末尾追加） |

## NaN 生成与判别约定

- **NaN 生成**：`let nan = Float32(0.0) / Float32(0.0)`（Float32）、`let nan = Float64(0.0) / Float64(0.0)`（Float64）
- **NaN 判别**：`@Expect(val != val, true)`（IEEE 754 中 NaN 与自身比较返回 false）
- **非 NaN 确认**：`@Expect(val != val, false)`（普通浮点数与自身比较返回 true）

## 测试函数清单

共 18 个测试函数：3 种矩阵类型 × 2 种浮点精度 × 3 种场景。每个测试函数位于 `package glm.detail`，以 `@Test` 注解，遵循已有测试命名和编码风格。

### A. Mat4x4（4×4 方阵，列向量类型 Vec4）

#### A1. Mat×Vec：NaN 列传播

**函数名**：`testMat4x4MulVec4NaNColFloat32` / `testMat4x4MulVec4NaNColFloat64`

- 构造 4×4 单位矩阵（`Mat4x4<Float32, Defaultp>.identity(Float32(1.0))`）
- 用 mut 操作符 `m[Int64(2)]` 将列 2 替换为 `Vec4<Float32, Defaultp>(Float32(0.0), Float32(0.0), nan, Float32(0.0))`，使 NaN 位于 (列2, 行2)
- 乘以正常向量 `Vec4<Float32, Defaultp>(Float32(1.0), Float32(1.0), Float32(1.0), Float32(1.0))`
- 断言：`r.z != r.z` 为 true（NaN），其他分量 `!= 自身` 为 false

**乘法展开（column-major）**：
```
r.x = col0.x * 1 + col1.x * 1 + col2.x * 1 + col3.x * 1 = 1 + 0 + 0 + 0 = 1
r.y = col0.y * 1 + col1.y * 1 + col2.y * 1 + col3.y * 1 = 0 + 1 + 0 + 0 = 1
r.z = col0.z * 1 + col1.z * 1 + nan * 1 + col3.z * 1 = NaN（NaN 通过 * 和 + 传播）
r.w = col0.w * 1 + col1.w * 1 + col2.w * 1 + col3.w * 1 = 0 + 0 + 0 + 1 = 1
```

#### A2. Vec×Mat：NaN 向量分量传播

**函数名**：`testVec4MulMat4x4NaNCompFloat32` / `testVec4MulMat4x4NaNCompFloat64`

- 构造正常 4×4 单位矩阵
- 构造含 NaN 的向量 `Vec4<Float32, Defaultp>(Float32(1.0), nan, Float32(1.0), Float32(1.0))`（NaN 位于第 1 分量）
- 计算 `v * m`（Vec4 × Mat4x4 → Vec4）
- 断言：全部 4 个分量的 `!= 自身` 均为 true。因为 NaN 分量参与每个点累计，NaN×任何=NaN 且 NaN+任何=NaN，全部传播

**乘法展开**：
```
r.x = v.x * col0.x + nan * col0.y + v.z * col0.z + v.w * col0.w = NaN（NaN×col0.y=NaN，Na+…=NaN）
r.y = v.x * col1.x + nan * col1.y + v.z * col1.z + v.w * col1.w = NaN
r.z = v.x * col2.x + nan * col2.y + v.z * col2.z + v.w * col2.w = NaN
r.w = v.x * col3.x + nan * col3.y + v.z * col3.z + v.w * col3.w = NaN
```

#### A3. NaN 对角矩阵 × 正常向量

**函数名**：`testMat4x4DiagonalNaNMulVecFloat32` / `testMat4x4DiagonalNaNMulVecFloat64`

- 构造对角矩阵 `Mat4x4<Float32, Defaultp>.diagonal(nan)`
- 与正常向量相乘
- 断言：全部 4 个分量均为 NaN（NaN 对角线上每个元素参与各行点积）

### B. Mat2x3（2 列 × 3 行非方阵，列向量类型 Vec3）

#### B1. Mat×Vec：NaN 列传播

**函数名**：`testMat2x3MulVec2NaNColFloat32` / `testMat2x3MulVec2NaNColFloat64`

- 构造 2×3 对角矩阵 `Mat2x3<Float32, Defaultp>.identity(Float32(1.0))`
- 将列 1 替换为 `Vec3<Float32, Defaultp>(Float32(0.0), nan, Float32(0.0))`，使 NaN 位于 (列1, 行1)
- 与 `Vec2<Float32, Defaultp>(Float32(1.0), Float32(1.0))` 相乘（Mat2x3 × Vec2 → Vec3）
- 断言：`r.y` 为 NaN（NaN 对应行），`r.x` 和 `r.z` 非 NaN

**乘法展开（col0, col1 均为 Vec3）**：
```
r.x = col0.x * 1 + col1.x * 1 = 1 + 0 = 1
r.y = col0.y * 1 + nan * 1 = NaN（NaN 传播）
r.z = col0.z * 1 + col1.z * 1 = 0 + 0 = 0
```

#### B2. Vec×Mat：NaN 向量分量传播

**函数名**：`testVec3MulMat2x3NaNCompFloat32` / `testVec3MulMat2x3NaNCompFloat64`

- 构造正常 2×3 对角矩阵
- 构造含 NaN 的向量 `Vec3<Float32, Defaultp>(Float32(1.0), nan, Float32(1.0))`
- 计算 `v * m`（Vec3 × Mat2x3 → Vec2）
- 断言：全部 2 个结果分量均为 NaN

**乘法展开**：
```
r.x = v.x * col0.x + nan * col0.y + v.z * col0.z = NaN
r.y = v.x * col1.x + nan * col1.y + v.z * col1.z = NaN
```

#### B3. NaN 对角矩阵 × 正常向量

**函数名**：`testMat2x3DiagonalNaNMulVecFloat32` / `testMat2x3DiagonalNaNMulVecFloat64`

- 构造对角矩阵 `Mat2x3<Float32, Defaultp>.diagonal(nan)`
  - **注意**：`diagonal(nan)` 内部使用 `scalar - scalar` 计算零值，IEEE 754 `NaN - NaN = NaN` 导致非对角元素也为 NaN，实际生成全 NaN 矩阵
- 与 `Vec2<Float32, Defaultp>(Float32(1.0), Float32(1.0))` 相乘
- 断言：全部 3 个结果分量均为 NaN

**乘法展开**（全 NaN 矩阵，col0、col1 所有分量为 NaN）：
```
r.x = col0.x * 1 + col1.x * 1 = NaN + NaN = NaN
r.y = col0.y * 1 + col1.y * 1 = NaN + NaN = NaN
r.z = col0.z * 1 + col1.z * 1 = NaN + NaN = NaN
```

### C. Mat3x2（3 列 × 2 行非方阵，列向量类型 Vec2）

#### C1. Mat×Vec：NaN 列传播

**函数名**：`testMat3x2MulVec3NaNColFloat32` / `testMat3x2MulVec3NaNColFloat64`

- 构造 3×2 对角矩阵 `Mat3x2<Float32, Defaultp>.identity(Float32(1.0))`
- 将列 1 替换为 `Vec2<Float32, Defaultp>(nan, Float32(0.0))`，使 NaN 位于 (列1, 行0)
- 与 `Vec3<Float32, Defaultp>(Float32(1.0), Float32(1.0), Float32(1.0))` 相乘（Mat3x2 × Vec3 → Vec2）
- 断言：`r.x` 为 NaN，`r.y` 非 NaN

**乘法展开**：
```
r.x = col0.x * 1 + nan * 1 + col2.x * 1 = NaN
r.y = col0.y * 1 + col1.y * 1 + col2.y * 1 = 0 + 0 + 1 = 1
```

#### C2. Vec×Mat：NaN 向量分量传播

**函数名**：`testVec2MulMat3x2NaNCompFloat32` / `testVec2MulMat3x2NaNCompFloat64`

- 构造正常 3×2 对角矩阵
- 构造含 NaN 的向量 `Vec2<Float32, Defaultp>(Float32(1.0), nan)`
- 计算 `v * m`（Vec2 × Mat3x2 → Vec3）
- 断言：全部 3 个结果分量均为 NaN

**乘法展开**：
```
r.x = v.x * col0.x + nan * col0.y = NaN
r.y = v.x * col1.x + nan * col1.y = NaN
r.z = v.x * col2.x + nan * col2.y = NaN
```

#### C3. NaN 对角矩阵 × 正常向量

**函数名**：`testMat3x2DiagonalNaNMulVecFloat32` / `testMat3x2DiagonalNaNMulVecFloat64`

- 构造对角矩阵 `Mat3x2<Float32, Defaultp>.diagonal(nan)`
  - col0 = Vec2(nan, 0)，col1 = Vec2(0, nan)，col2 = Vec2(0, 0)
- 与 `Vec3<Float32, Defaultp>(Float32(1.0), Float32(1.0), Float32(1.0))` 相乘
- 断言：全部 2 个结果分量均为 NaN

### 所有测试函数签名总览

```cangjie
// Mat4x4
@Test func testMat4x4MulVec4NaNColFloat32(): Unit
@Test func testMat4x4MulVec4NaNColFloat64(): Unit
@Test func testVec4MulMat4x4NaNCompFloat32(): Unit
@Test func testVec4MulMat4x4NaNCompFloat64(): Unit
@Test func testMat4x4DiagonalNaNMulVecFloat32(): Unit
@Test func testMat4x4DiagonalNaNMulVecFloat64(): Unit

// Mat2x3
@Test func testMat2x3MulVec2NaNColFloat32(): Unit
@Test func testMat2x3MulVec2NaNColFloat64(): Unit
@Test func testVec3MulMat2x3NaNCompFloat32(): Unit
@Test func testVec3MulMat2x3NaNCompFloat64(): Unit
@Test func testMat2x3DiagonalNaNMulVecFloat32(): Unit
@Test func testMat2x3DiagonalNaNMulVecFloat64(): Unit

// Mat3x2
@Test func testMat3x2MulVec3NaNColFloat32(): Unit
@Test func testMat3x2MulVec3NaNColFloat64(): Unit
@Test func testVec2MulMat3x2NaNCompFloat32(): Unit
@Test func testVec2MulMat3x2NaNCompFloat64(): Unit
@Test func testMat3x2DiagonalNaNMulVecFloat32(): Unit
@Test func testMat3x2DiagonalNaNMulVecFloat64(): Unit
```

## 行为契约

1. **列替换方式**：使用 struct 的 mut 下标操作符 `m[Int64(i)] = newCol`（已验证于 `testMat4x4IndexMutate`），无需 `col()` 方法（col 为只读 getter）
2. **NaN 生成时机**：每个测试函数内部生成 NaN，不共享跨函数变量
3. **浮点精度隔离**：Float32 和 Float64 测试函数使用各自类型的 NaN，互不干扰

## 错误处理

- 不涉及自定义错误类型。NaN 传播通过 IEEE 754 算术自然发生
- 不涉及 `try/catch` 或 Option/Result

## 依赖关系

- 依赖已有类型：`Mat4x4<T, Q>`、`Mat2x3<T, Q>`、`Mat3x2<T, Q>`、`Vec2<T, Q>`、`Vec3<T, Q>`、`Vec4<T, Q>`（均位于 `glm.detail` 包）
- 使用已有的 `identity`、`diagonal` 静态方法
- 使用已有的 `operator *(vec)` Mat×Vec 和 Vec `operator *(mat)` Vec×Mat 运算符
- 依赖 `std.unittest.*` 和 `std.unittest.testmacro.*`（已有 import）
- 不暴露新接口给后续任务

## 修订说明（v15 r1）

| 审查意见 | 修改措施 |
|---------|---------|
| B3 场景中 `diagonal(nan)` 因 IEEE 754 `NaN - NaN = NaN` 导致全矩阵 NaN，非对角元素也为 NaN 而非 0；断言 `r.z` 为 0 将失败 | 采纳方案 A：保留 `diagonal(nan)` 调用，将 B3 断言改为"全部 3 个结果分量均为 NaN"，并更新乘法展开说明；同步添加 `diagonal(nan)` 全 NaN 行为注释 |
