# 详细设计（v2）

## 概述

为 `cjglm/tests/glm/detail/test_scalar_mat_ops.cj` 补充 24 个非方阵标量-矩阵运算单元测试函数（6 非方阵类型 × 4 运算，仅 Int64 类型），覆盖当前覆盖率缺口，消除 T6 阻塞项。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `cjglm/tests/glm/detail/test_scalar_mat_ops.cj` | 追加 | 在第 231 行后追加 24 个 `@Test` 函数 |

## 测试函数清单

### 命名规范

`testScalar{Op}Mat{Rows}x{Cols}Int64`，其中 Op ∈ {Add, Sub, Mul, Div}，非方阵类型均为 6 种。

### 全部 24 个函数签名

```cangjie
@Test func testScalarAddMat2x3Int64(): Unit
@Test func testScalarAddMat2x4Int64(): Unit
@Test func testScalarAddMat3x2Int64(): Unit
@Test func testScalarAddMat3x4Int64(): Unit
@Test func testScalarAddMat4x2Int64(): Unit
@Test func testScalarAddMat4x3Int64(): Unit

@Test func testScalarSubMat2x3Int64(): Unit
@Test func testScalarSubMat2x4Int64(): Unit
@Test func testScalarSubMat3x2Int64(): Unit
@Test func testScalarSubMat3x4Int64(): Unit
@Test func testScalarSubMat4x2Int64(): Unit
@Test func testScalarSubMat4x3Int64(): Unit

@Test func testScalarMulMat2x3Int64(): Unit
@Test func testScalarMulMat2x4Int64(): Unit
@Test func testScalarMulMat3x2Int64(): Unit
@Test func testScalarMulMat3x4Int64(): Unit
@Test func testScalarMulMat4x2Int64(): Unit
@Test func testScalarMulMat4x3Int64(): Unit

@Test func testScalarDivMat2x3Int64(): Unit
@Test func testScalarDivMat2x4Int64(): Unit
@Test func testScalarDivMat3x2Int64(): Unit
@Test func testScalarDivMat3x4Int64(): Unit
@Test func testScalarDivMat4x2Int64(): Unit
@Test func testScalarDivMat4x3Int64(): Unit
```

### 每个测试函数的构造参数与断言预期值

#### add(s=3) 系列 — 6 个函数

| 测试函数 | 矩阵构造参数 | 标量 s | 预期值（逐分量） |
|---------|-------------|-------|----------------|
| `testScalarAddMat2x3Int64` | `Mat2x3<Int64, Defaultp>(1,2,3, 4,5,6)` | `Int64(3)` | c0=(4,5,6), c1=(7,8,9) |
| `testScalarAddMat2x4Int64` | `Mat2x4<Int64, Defaultp>(1,2,3,4, 5,6,7,8)` | `Int64(3)` | c0=(4,5,6,7), c1=(8,9,10,11) |
| `testScalarAddMat3x2Int64` | `Mat3x2<Int64, Defaultp>(1,2, 3,4, 5,6)` | `Int64(3)` | c0=(4,5), c1=(6,7), c2=(8,9) |
| `testScalarAddMat3x4Int64` | `Mat3x4<Int64, Defaultp>(1,2,3,4, 5,6,7,8, 9,10,11,12)` | `Int64(3)` | c0=(4,5,6,7), c1=(8,9,10,11), c2=(12,13,14,15) |
| `testScalarAddMat4x2Int64` | `Mat4x2<Int64, Defaultp>(1,2, 3,4, 5,6, 7,8)` | `Int64(3)` | c0=(4,5), c1=(6,7), c2=(8,9), c3=(10,11) |
| `testScalarAddMat4x3Int64` | `Mat4x3<Int64, Defaultp>(1,2,3, 4,5,6, 7,8,9, 10,11,12)` | `Int64(3)` | c0=(4,5,6), c1=(7,8,9), c2=(10,11,12), c3=(13,14,15) |

#### sub(s) 系列 — 6 个函数

| 测试函数 | 矩阵构造参数 | 标量 s | 预期值（逐分量） |
|---------|-------------|-------|----------------|
| `testScalarSubMat2x3Int64` | `Mat2x3<Int64, Defaultp>(1,2,3, 4,5,6)` | `Int64(100)` | c0=(99,98,97), c1=(96,95,94) |
| `testScalarSubMat2x4Int64` | `Mat2x4<Int64, Defaultp>(1,2,3,4, 5,6,7,8)` | `Int64(10)` | c0=(9,8,7,6), c1=(5,4,3,2) |
| `testScalarSubMat3x2Int64` | `Mat3x2<Int64, Defaultp>(1,2, 3,4, 5,6)` | `Int64(100)` | c0=(99,98), c1=(97,96), c2=(95,94) |
| `testScalarSubMat3x4Int64` | `Mat3x4<Int64, Defaultp>(1,2,3,4, 5,6,7,8, 9,10,11,12)` | `Int64(10)` | c0=(9,8,7,6), c1=(5,4,3,2), c2=(1,0,-1,-2) |
| `testScalarSubMat4x2Int64` | `Mat4x2<Int64, Defaultp>(1,2, 3,4, 5,6, 7,8)` | `Int64(100)` | c0=(99,98), c1=(97,96), c2=(95,94), c3=(93,92) |
| `testScalarSubMat4x3Int64` | `Mat4x3<Int64, Defaultp>(1,2,3, 4,5,6, 7,8,9, 10,11,12)` | `Int64(10)` | c0=(9,8,7), c1=(6,5,4), c2=(3,2,1), c3=(0,-1,-2) |

#### mul(s) 系列 — 6 个函数

| 测试函数 | 矩阵构造参数 | 标量 s | 预期值（逐分量） |
|---------|-------------|-------|----------------|
| `testScalarMulMat2x3Int64` | `Mat2x3<Int64, Defaultp>(1,2,3, 4,5,6)` | `Int64(3)` | c0=(3,6,9), c1=(12,15,18) |
| `testScalarMulMat2x4Int64` | `Mat2x4<Int64, Defaultp>(1,2,3,4, 5,6,7,8)` | `Int64(2)` | c0=(2,4,6,8), c1=(10,12,14,16) |
| `testScalarMulMat3x2Int64` | `Mat3x2<Int64, Defaultp>(1,2, 3,4, 5,6)` | `Int64(3)` | c0=(3,6), c1=(9,12), c2=(15,18) |
| `testScalarMulMat3x4Int64` | `Mat3x4<Int64, Defaultp>(1,2,3,4, 5,6,7,8, 9,10,11,12)` | `Int64(2)` | c0=(2,4,6,8), c1=(10,12,14,16), c2=(18,20,22,24) |
| `testScalarMulMat4x2Int64` | `Mat4x2<Int64, Defaultp>(1,2, 3,4, 5,6, 7,8)` | `Int64(3)` | c0=(3,6), c1=(9,12), c2=(15,18), c3=(21,24) |
| `testScalarMulMat4x3Int64` | `Mat4x3<Int64, Defaultp>(1,2,3, 4,5,6, 7,8,9, 10,11,12)` | `Int64(2)` | c0=(2,4,6), c1=(8,10,12), c2=(14,16,18), c3=(20,22,24) |

#### div(s) 系列 — 6 个函数

| 测试函数 | 矩阵构造参数 | 标量 s | 预期值（逐分量） |
|---------|-------------|-------|----------------|
| `testScalarDivMat2x3Int64` | `Mat2x3<Int64, Defaultp>(1,2,3, 4,5,6)` | `Int64(30)` | c0=(30,15,10), c1=(7,6,5) |
| `testScalarDivMat2x4Int64` | `Mat2x4<Int64, Defaultp>(1,2,3,4, 5,6,7,8)` | `Int64(60)` | c0=(60,30,20,15), c1=(12,10,8,7) |
| `testScalarDivMat3x2Int64` | `Mat3x2<Int64, Defaultp>(1,2, 3,4, 5,6)` | `Int64(30)` | c0=(30,15), c1=(10,7), c2=(6,5) |
| `testScalarDivMat3x4Int64` | `Mat3x4<Int64, Defaultp>(1,2,3,4, 5,6,7,8, 9,10,11,12)` | `Int64(60)` | c0=(60,30,20,15), c1=(12,10,8,7), c2=(6,6,5,5) |
| `testScalarDivMat4x2Int64` | `Mat4x2<Int64, Defaultp>(1,2, 3,4, 5,6, 7,8)` | `Int64(30)` | c0=(30,15), c1=(10,7), c2=(6,5), c3=(4,3) |
| `testScalarDivMat4x3Int64` | `Mat4x3<Int64, Defaultp>(1,2,3, 4,5,6, 7,8,9, 10,11,12)` | `Int64(60)` | c0=(60,30,20), c1=(15,12,10), c2=(8,7,6), c3=(6,5,5) |

### 断言表达式模板

以 `testScalarAddMat2x3Int64` 为例：

```cangjie
@Test
func testScalarAddMat2x3Int64(): Unit {
    let m = Mat2x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let r = add(Int64(3), m)
    @Expect(r.c0.x, 4)
    @Expect(r.c0.y, 5)
    @Expect(r.c0.z, 6)
    @Expect(r.c1.x, 7)
    @Expect(r.c1.y, 8)
    @Expect(r.c1.z, 9)
}
```

所有 24 个函数遵循相同的结构模式：`Mat{R}x{C}<Int64, Defaultp>(...)` → 调用 `op(Int64(s), m)` → 逐列逐分量 `@Expect`。

断言顺序：按列优先，每列内按 `.x, .y, .z, .w` 顺序（非方阵的短向量仅到有效分量）。

## 错误处理

不涉及——仅追加测试断言函数，无错误处理逻辑变更。

## 行为契约

- 24 个新增测试函数应全部通过 `cjpm test` 运行
- 每个测试函数对标量-矩阵运算全局函数 `add`/`sub`/`mul`/`div` 做逐分量验证
- 预期值与 `src/detail/scalar_mat_ops.cj` 中对应重载的实现逻辑完全一致
- 新增测试追加到文件末尾（第 231 行之后），不修改现有测试

## 依赖关系

- 依赖于 `src/detail/scalar_mat_ops.cj` 中已实现的非方阵重载（`add(Mat2x3)`, `sub(Mat2x4)`, `mul(Mat3x2)`, `div(Mat4x3)` 等 24 个函数签名）
- 参考现有方阵测试模式：`testScalarAddMat2x2Int64`、`testScalarAddMat3x3Int64`、`testScalarAddMat4x4Int64`
- 矩阵类型依赖：`type_mat2x3.cj`、`type_mat2x4.cj`、`type_mat3x2.cj`、`type_mat3x4.cj`、`type_mat4x2.cj`、`type_mat4x3.cj`
