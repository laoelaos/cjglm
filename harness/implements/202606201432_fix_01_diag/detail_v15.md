# 详细设计（v15）

## 概述

在 `src/detail/scalar_vec_ops_test.cj` 追加约 65 个测试函数，补齐 `scalar_vec_ops.cj` 中已有函数的测试缺口。纯测试追加，不修改源文件。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `src/detail/scalar_vec_ops_test.cj` | 编辑 | 在文件末尾追加约 65 个 `@Test func testXxx(): Unit` 函数 |

## 类型定义

无新增类型。所有测试使用已有类型：
- Vec1/2/3/4 模板类型（`VecN<T, Q>`）
- Qualifier 类型：`Defaultp`、`PackedMediump`、`PackedLowp`
- 标量类型：`Float32`、`Int32`、`Int64`

## 测试函数规划

所有函数遵循已有命名约定 `testScalar{Op}{VecN}[{Type}]` / `testScalar{Op}{VecN}{Qualifier}`，包级 `@Test func testXxx(): Unit`，使用 `@Expect` 逐分量断言。

### 1. Float32 add/sub/mul/div × Vec1/2/3/4（16 个）

每个 VecN 各 4 个 op，共 4 N × 4 op = 16 函数，使用 `Defaultp` qualifier。

| 函数名 | 标量 s | 向量 v | 逐分量期望 |
|-------|--------|--------|-----------|
| `testScalarAddVec1Float32` | `Float32(3.0)` | `Vec1(Float32(1.5))` | `x=4.5` |
| `testScalarAddVec2Float32` | `Float32(3.0)` | `Vec2(Float32(1.5), Float32(2.5))` | `x=4.5, y=5.5` |
| `testScalarAddVec3Float32` | `Float32(3.0)` | `Vec3(Float32(1.5), Float32(2.5), Float32(3.5))` | `x=4.5, y=5.5, z=6.5` |
| `testScalarAddVec4Float32` | `Float32(3.0)` | `Vec4(Float32(1.5), Float32(2.5), Float32(3.5), Float32(4.5))` | `x=4.5, y=5.5, z=6.5, w=7.5` |
| `testScalarSubVec1Float32` | `Float32(7.0)` | `Vec1(Float32(2.5))` | `x=4.5` |
| `testScalarSubVec2Float32` | `Float32(7.0)` | `Vec2(Float32(2.5), Float32(3.0))` | `x=4.5, y=4.0` |
| `testScalarSubVec3Float32` | `Float32(7.0)` | `Vec3(Float32(2.5), Float32(3.0), Float32(4.0))` | `x=4.5, y=4.0, z=3.0` |
| `testScalarSubVec4Float32` | `Float32(7.0)` | `Vec4(Float32(2.5), Float32(3.0), Float32(4.0), Float32(5.0))` | `x=4.5, y=4.0, z=3.0, w=2.0` |
| `testScalarMulVec1Float32` | `Float32(2.0)` | `Vec1(Float32(3.5))` | `x=7.0` |
| `testScalarMulVec2Float32` | `Float32(2.0)` | `Vec2(Float32(3.5), Float32(4.0))` | `x=7.0, y=8.0` |
| `testScalarMulVec3Float32` | `Float32(2.0)` | `Vec3(Float32(3.5), Float32(4.0), Float32(5.0))` | `x=7.0, y=8.0, z=10.0` |
| `testScalarMulVec4Float32` | `Float32(2.0)` | `Vec4(Float32(3.5), Float32(4.0), Float32(5.0), Float32(6.0))` | `x=7.0, y=8.0, z=10.0, w=12.0` |
| `testScalarDivVec1Float32` | `Float32(7.5)` | `Vec1(Float32(2.5))` | `x=3.0` |
| `testScalarDivVec2Float32` | `Float32(7.5)` | `Vec2(Float32(2.5), Float32(3.0))` | `x=3.0, y=2.5` |
| `testScalarDivVec3Float32` | `Float32(7.5)` | `Vec3(Float32(2.5), Float32(3.0), Float32(5.0))` | `x=3.0, y=2.5, z=1.5` |
| `testScalarDivVec4Float32` | `Float32(7.5)` | `Vec4(Float32(2.5), Float32(3.0), Float32(5.0), Float32(15.0))` | `x=3.0, y=2.5, z=1.5, w=0.5` |

### 2. Int32 add/sub/mul/div × Vec1/2/3/4（16 个）

每个 VecN 各 4 个 op，共 16 函数，使用 `Defaultp` qualifier。

| 函数名 | 标量 s | 向量 v | 逐分量期望 |
|-------|--------|--------|-----------|
| `testScalarAddVec1Int32` | `Int32(3)` | `Vec1(Int32(10))` | `x=13` |
| `testScalarAddVec2Int32` | `Int32(3)` | `Vec2(Int32(10), Int32(20))` | `x=13, y=23` |
| `testScalarAddVec3Int32` | `Int32(3)` | `Vec3(Int32(10), Int32(20), Int32(30))` | `x=13, y=23, z=33` |
| `testScalarAddVec4Int32` | `Int32(3)` | `Vec4(Int32(10), Int32(20), Int32(30), Int32(40))` | `x=13, y=23, z=33, w=43` |
| `testScalarSubVec1Int32` | `Int32(3)` | `Vec1(Int32(10))` | `x=-7` |
| `testScalarSubVec2Int32` | `Int32(3)` | `Vec2(Int32(10), Int32(20))` | `x=-7, y=-17` |
| `testScalarSubVec3Int32` | `Int32(3)` | `Vec3(Int32(10), Int32(20), Int32(30))` | `x=-7, y=-17, z=-27` |
| `testScalarSubVec4Int32` | `Int32(3)` | `Vec4(Int32(10), Int32(20), Int32(30), Int32(40))` | `x=-7, y=-17, z=-27, w=-37` |
| `testScalarMulVec1Int32` | `Int32(5)` | `Vec1(Int32(2))` | `x=10` |
| `testScalarMulVec2Int32` | `Int32(5)` | `Vec2(Int32(2), Int32(3))` | `x=10, y=15` |
| `testScalarMulVec3Int32` | `Int32(5)` | `Vec3(Int32(2), Int32(3), Int32(4))` | `x=10, y=15, z=20` |
| `testScalarMulVec4Int32` | `Int32(5)` | `Vec4(Int32(2), Int32(3), Int32(4), Int32(5))` | `x=10, y=15, z=20, w=25` |
| `testScalarDivVec1Int32` | `Int32(30)` | `Vec1(Int32(10))` | `x=3` |
| `testScalarDivVec2Int32` | `Int32(30)` | `Vec2(Int32(10), Int32(15))` | `x=3, y=2` |
| `testScalarDivVec3Int32` | `Int32(60)` | `Vec3(Int32(10), Int32(15), Int32(20))` | `x=6, y=4, z=3` |
| `testScalarDivVec4Int32` | `Int32(60)` | `Vec4(Int32(10), Int32(15), Int32(20), Int32(30))` | `x=6, y=4, z=3, w=2` |

### 3. mod Int32 × Vec1/2/3/4（4 个）

| 函数名 | 标量 s | 向量 v | 逐分量期望 |
|-------|--------|--------|-----------|
| `testScalarModVec1Int32` | `Int32(33)` | `Vec1(Int32(10))` | `x=3` |
| `testScalarModVec2Int32` | `Int32(33)` | `Vec2(Int32(10), Int32(15))` | `x=3, y=3` |
| `testScalarModVec3Int32` | `Int32(33)` | `Vec3(Int32(10), Int32(15), Int32(20))` | `x=3, y=3, z=13` |
| `testScalarModVec4Int32` | `Int32(33)` | `Vec4(Int32(10), Int32(15), Int32(20), Int32(25))` | `x=3, y=3, z=13, w=8` |

### 4. 跨 Qualifier 测试补齐 Vec1/Vec3/Vec4（24 个）

Vec2 已有 sub/mul/div/mod × PackedMediump/PackedLowp 共 8 个测试。补齐 Vec1/Vec3/Vec4，与 Vec2 模式一致：标量类型使用 Int64、qualifier 使用 PackedMediump 和 PackedLowp。

共 3 Vec × 4 ops × 2 qualifiers = 24 个函数。

#### sub（6 个）

| 函数名 | 标量 s | 向量 v | 逐分量期望 |
|-------|--------|--------|-----------|
| `testScalarSubVec1PackedMediump` | `Int64(3)` | `Vec1<Int64, PackedMediump>(10)` | `x=-7` |
| `testScalarSubVec1PackedLowp` | `Int64(3)` | `Vec1<Int64, PackedLowp>(10)` | `x=-7` |
| `testScalarSubVec3PackedMediump` | `Int64(3)` | `Vec3<Int64, PackedMediump>(10, 20, 30)` | `x=-7, y=-17, z=-27` |
| `testScalarSubVec3PackedLowp` | `Int64(3)` | `Vec3<Int64, PackedLowp>(10, 20, 30)` | `x=-7, y=-17, z=-27` |
| `testScalarSubVec4PackedMediump` | `Int64(3)` | `Vec4<Int64, PackedMediump>(10, 20, 30, 40)` | `x=-7, y=-17, z=-27, w=-37` |
| `testScalarSubVec4PackedLowp` | `Int64(3)` | `Vec4<Int64, PackedLowp>(10, 20, 30, 40)` | `x=-7, y=-17, z=-27, w=-37` |

#### mul（6 个）

| 函数名 | 标量 s | 向量 v | 逐分量期望 |
|-------|--------|--------|-----------|
| `testScalarMulVec1PackedMediump` | `Int64(5)` | `Vec1<Int64, PackedMediump>(2)` | `x=10` |
| `testScalarMulVec1PackedLowp` | `Int64(5)` | `Vec1<Int64, PackedLowp>(2)` | `x=10` |
| `testScalarMulVec3PackedMediump` | `Int64(5)` | `Vec3<Int64, PackedMediump>(2, 3, 4)` | `x=10, y=15, z=20` |
| `testScalarMulVec3PackedLowp` | `Int64(5)` | `Vec3<Int64, PackedLowp>(2, 3, 4)` | `x=10, y=15, z=20` |
| `testScalarMulVec4PackedMediump` | `Int64(5)` | `Vec4<Int64, PackedMediump>(2, 3, 4, 5)` | `x=10, y=15, z=20, w=25` |
| `testScalarMulVec4PackedLowp` | `Int64(5)` | `Vec4<Int64, PackedLowp>(2, 3, 4, 5)` | `x=10, y=15, z=20, w=25` |

#### div（6 个）

| 函数名 | 标量 s | 向量 v | 逐分量期望 |
|-------|--------|--------|-----------|
| `testScalarDivVec1PackedMediump` | `Int64(30)` | `Vec1<Int64, PackedMediump>(10)` | `x=3` |
| `testScalarDivVec1PackedLowp` | `Int64(30)` | `Vec1<Int64, PackedLowp>(10)` | `x=3` |
| `testScalarDivVec3PackedMediump` | `Int64(60)` | `Vec3<Int64, PackedMediump>(10, 15, 20)` | `x=6, y=4, z=3` |
| `testScalarDivVec3PackedLowp` | `Int64(60)` | `Vec3<Int64, PackedLowp>(10, 15, 20)` | `x=6, y=4, z=3` |
| `testScalarDivVec4PackedMediump` | `Int64(60)` | `Vec4<Int64, PackedMediump>(10, 15, 20, 30)` | `x=6, y=4, z=3, w=2` |
| `testScalarDivVec4PackedLowp` | `Int64(60)` | `Vec4<Int64, PackedLowp>(10, 15, 20, 30)` | `x=6, y=4, z=3, w=2` |

#### mod（6 个）

| 函数名 | 标量 s | 向量 v | 逐分量期望 |
|-------|--------|--------|-----------|
| `testScalarModVec1PackedMediump` | `Int64(33)` | `Vec1<Int64, PackedMediump>(10)` | `x=3` |
| `testScalarModVec1PackedLowp` | `Int64(33)` | `Vec1<Int64, PackedLowp>(10)` | `x=3` |
| `testScalarModVec3PackedMediump` | `Int64(33)` | `Vec3<Int64, PackedMediump>(10, 15, 20)` | `x=3, y=3, z=13` |
| `testScalarModVec3PackedLowp` | `Int64(33)` | `Vec3<Int64, PackedLowp>(10, 15, 20)` | `x=3, y=3, z=13` |
| `testScalarModVec4PackedMediump` | `Int64(33)` | `Vec4<Int64, PackedMediump>(10, 15, 20, 25)` | `x=3, y=3, z=13, w=8` |
| `testScalarModVec4PackedLowp` | `Int64(33)` | `Vec4<Int64, PackedLowp>(10, 15, 20, 25)` | `x=3, y=3, z=13, w=8` |

### 5. 边界/特殊值（5 个）

| 函数名 | 场景 | 标量 s | 向量 v | 逐分量期望 | 说明 |
|-------|------|--------|--------|-----------|------|
| `testScalarDivZeroVec1` | 零值 scalar | `Int64(0)` | `Vec1<Int64, Defaultp>(Int64(1))` | `x=0` | 0 除以任何非零值等于 0，非除零 panic |
| `testScalarAddNegVec1` | 负 scalar + 正分量 | `Int64(-5)` | `Vec1<Int64, Defaultp>(Int64(3))` | `x=-2` | 验证负值标量正确运算 |
| `testScalarAddNegVec2` | 同上，Vec2 | `Int64(-5)` | `Vec2<Int64, Defaultp>(Int64(3), Int64(7))` | `x=-2, y=2` | 验证多分量一致性 |
| `testScalarMulOverflowVec1` | 大数值溢出 | `Int64(2)` | `Vec1<Int64, Defaultp>(Int64(9223372036854775807))` | `x=-2` | `@OverflowWrapping` 下 Int64.MAX×2 回绕 |
| `testScalarSubNegVec1` | 负 scalar - 正分量 | `Int64(-5)` | `Vec1<Int64, Defaultp>(Int64(3))` | `x=-8` | 负值连续运算 |

## 错误处理

无变更。测试函数使用 `@Expect` 断言，失败由测试框架报告。源函数本身使用 `@OverflowWrapping` 处理整数溢出，除零仍为 panic（测试中只做零值 scalar 非除零场景）。

## 行为契约

- 所有新测试函数追加到 `scalar_vec_ops_test.cj` 文件末尾，不影响已有 40 个测试
- 新增约 65 个测试函数，文件行数从 340 增至约 340 + 65×~5 = 665 行
- 测试函数命名与已有模式一致，不产生编译冲突
- 所有测试使用已有 `add`/`sub`/`mul`/`div`/`mod` 函数签名，无需新增导入

## 依赖关系

- 源文件 `src/detail/scalar_vec_ops.cj`：提供 `add`/`sub`/`mul`/`div`/`mod` 函数
- 测试文件 `src/detail/scalar_vec_ops_test.cj`：追加新测试，依赖 `std.unittest.*` 和 `std.unittest.testmacro.*`（已有导入）
- 类型依赖：`Vec1/2/3/4`、`Defaultp`、`PackedMediump`、`PackedLowp`、`Float32`、`Int32`、`Int64`
