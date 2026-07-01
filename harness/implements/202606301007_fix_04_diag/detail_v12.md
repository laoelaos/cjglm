# 详细设计（v12）

## 概述

完成 P4-2 几何/矩阵测试补充的剩余任务：G33（matrix_access_test 类型维度补全）+ G32（matrix_inverse_test 恒等式验证）。全部变更限于测试文件，不修改生产代码。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `tests/glm/gtc/matrix_access_test.cj:173` 之后追加 | 新增 6 个测试函数 | G33: 补充 Mat2x2/Mat3x2/Mat4x3 的 row/column 测试 |
| `tests/glm/gtc/matrix_inverse_test.cj:71` 之后追加 | 新增 2 个测试函数 | G32: 补充 Mat3x3/Mat4x4 的 inverseTranspose 恒等式一致性验证 |
| `docs/diag/impl/04_diag.md:383,389` | 修改 | G32/G33 条目末尾添加 `✅ 已修复` |
| `harness/implements/202606301007_fix_04_diag/plan.md:10,24` | 修改 | 路线表 v12 列 P4-2 全部标记 ✅ |

## 类型定义

无新增/修改类型。仅新增测试函数。

### G33: matrix_access_test.cj 新增 6 个测试函数

#### testRowMat2x2

```cangjie
@Test
func testRowMat2x2(): Unit {
    let m = Mat2x2<Float64, Defaultp>(Vec2(1.0, 3.0), Vec2(2.0, 4.0))
    let r0 = row(m, 0)
    @Expect(r0.x, 1.0)
    @Expect(r0.y, 2.0)
    let r1 = row(m, 1)
    @Expect(r1.x, 3.0)
    @Expect(r1.y, 4.0)
}
```

矩阵布局：column0 = (1,3), column1 = (2,4) → row0 = (1,2), row1 = (3,4)

#### testColumnMat2x2

```cangjie
@Test
func testColumnMat2x2(): Unit {
    let m = Mat2x2<Float64, Defaultp>(Vec2(1.0, 3.0), Vec2(2.0, 4.0))
    let c0 = column(m, 0)
    @Expect(c0.x, 1.0)
    @Expect(c0.y, 3.0)
    let c1 = column(m, 1)
    @Expect(c1.x, 2.0)
    @Expect(c1.y, 4.0)
}
```

#### testRowMat3x2

```cangjie
@Test
func testRowMat3x2(): Unit {
    let m = Mat3x2<Float64, Defaultp>(Vec2(1.0, 4.0), Vec2(2.0, 5.0), Vec2(3.0, 6.0))
    let r0 = row(m, 0)
    @Expect(r0.x, 1.0)
    @Expect(r0.y, 2.0)
    @Expect(r0.z, 3.0)
    let r1 = row(m, 1)
    @Expect(r1.x, 4.0)
    @Expect(r1.y, 5.0)
    @Expect(r1.z, 6.0)
}
```

矩阵布局：3 列 × 2 行，row 返回 Vec3（每行 3 元素跨列）

#### testColumnMat3x2

```cangjie
@Test
func testColumnMat3x2(): Unit {
    let m = Mat3x2<Float64, Defaultp>(Vec2(1.0, 4.0), Vec2(2.0, 5.0), Vec2(3.0, 6.0))
    let c0 = column(m, 0)
    @Expect(c0.x, 1.0)
    @Expect(c0.y, 4.0)
    let c1 = column(m, 1)
    @Expect(c1.x, 2.0)
    @Expect(c1.y, 5.0)
    let c2 = column(m, 2)
    @Expect(c2.x, 3.0)
    @Expect(c2.y, 6.0)
}
```

#### testRowMat4x3

```cangjie
@Test
func testRowMat4x3(): Unit {
    let m = Mat4x3<Float64, Defaultp>(Vec3(1.0, 5.0, 9.0), Vec3(2.0, 6.0, 10.0), Vec3(3.0, 7.0, 11.0), Vec3(4.0, 8.0, 12.0))
    let r0 = row(m, 0)
    @Expect(r0.x, 1.0)
    @Expect(r0.y, 2.0)
    @Expect(r0.z, 3.0)
    @Expect(r0.w, 4.0)
    let r2 = row(m, 2)
    @Expect(r2.x, 9.0)
    @Expect(r2.y, 10.0)
    @Expect(r2.z, 11.0)
    @Expect(r2.w, 12.0)
}
```

矩阵布局：4 列 × 3 行，row 返回 Vec4（每行 4 元素跨列），验证首尾两行

#### testColumnMat4x3

```cangjie
@Test
func testColumnMat4x3(): Unit {
    let m = Mat4x3<Float64, Defaultp>(Vec3(1.0, 5.0, 9.0), Vec3(2.0, 6.0, 10.0), Vec3(3.0, 7.0, 11.0), Vec3(4.0, 8.0, 12.0))
    let c0 = column(m, 0)
    @Expect(c0.x, 1.0)
    @Expect(c0.y, 5.0)
    @Expect(c0.z, 9.0)
    let c3 = column(m, 3)
    @Expect(c3.x, 4.0)
    @Expect(c3.y, 8.0)
    @Expect(c3.z, 12.0)
}
```

### G32: matrix_inverse_test.cj 新增 2 个测试函数

注意：`inverseTranspose` 生产函数仅对 Mat3x3 和 Mat4x4 提供（`gtc/matrix_inverse.cj:29,34`），无 Mat2x2 版本。因此恒等式验证仅限于 Mat3x3 和 Mat4x4，不包含 Mat2x2。

需新增 import：`inverse`, `transpose`（来自 `glm.detail`）

#### testInverseTransposeConsistencyMat3

使用与已有 `testInverseTransposeMat3` 相同的对角矩阵值，验证 `inverseTranspose(m) == transpose(inverse(m))`：

```cangjie
@Test
func testInverseTransposeConsistencyMat3(): Unit {
    let m = Mat3x3<Float64, Defaultp>(
        Vec3(1.0, 0.0, 0.0),
        Vec3(0.0, 2.0, 0.0),
        Vec3(0.0, 0.0, 3.0)
    )
    let r = inverseTranspose(m)
    let expected = transpose(inverse(m))
    @Expect((r.c0.x - expected.c0.x).abs() < 1e-10, true)
    @Expect((r.c0.y - expected.c0.y).abs() < 1e-10, true)
    @Expect((r.c0.z - expected.c0.z).abs() < 1e-10, true)
    @Expect((r.c1.x - expected.c1.x).abs() < 1e-10, true)
    @Expect((r.c1.y - expected.c1.y).abs() < 1e-10, true)
    @Expect((r.c1.z - expected.c1.z).abs() < 1e-10, true)
    @Expect((r.c2.x - expected.c2.x).abs() < 1e-10, true)
    @Expect((r.c2.y - expected.c2.y).abs() < 1e-10, true)
    @Expect((r.c2.z - expected.c2.z).abs() < 1e-10, true)
}
```

#### testInverseTransposeConsistencyMat4

使用与已有 `testInverseTransposeMat4` 相同的对角矩阵值：

```cangjie
@Test
func testInverseTransposeConsistencyMat4(): Unit {
    let m = Mat4x4<Float64, Defaultp>(
        Vec4(1.0, 0.0, 0.0, 0.0),
        Vec4(0.0, 2.0, 0.0, 0.0),
        Vec4(0.0, 0.0, 3.0, 0.0),
        Vec4(0.0, 0.0, 0.0, 1.0)
    )
    let r = inverseTranspose(m)
    let expected = transpose(inverse(m))
    @Expect((r.c0.x - expected.c0.x).abs() < 1e-10, true)
    @Expect((r.c0.y - expected.c0.y).abs() < 1e-10, true)
    @Expect((r.c0.z - expected.c0.z).abs() < 1e-10, true)
    @Expect((r.c0.w - expected.c0.w).abs() < 1e-10, true)
    @Expect((r.c1.x - expected.c1.x).abs() < 1e-10, true)
    @Expect((r.c1.y - expected.c1.y).abs() < 1e-10, true)
    @Expect((r.c1.z - expected.c1.z).abs() < 1e-10, true)
    @Expect((r.c1.w - expected.c1.w).abs() < 1e-10, true)
    @Expect((r.c2.x - expected.c2.x).abs() < 1e-10, true)
    @Expect((r.c2.y - expected.c2.y).abs() < 1e-10, true)
    @Expect((r.c2.z - expected.c2.z).abs() < 1e-10, true)
    @Expect((r.c2.w - expected.c2.w).abs() < 1e-10, true)
    @Expect((r.c3.x - expected.c3.x).abs() < 1e-10, true)
    @Expect((r.c3.y - expected.c3.y).abs() < 1e-10, true)
    @Expect((r.c3.z - expected.c3.z).abs() < 1e-10, true)
    @Expect((r.c3.w - expected.c3.w).abs() < 1e-10, true)
}
```

## 错误处理

全部为新增测试，不涉及错误处理逻辑变更。matrix_inverse_test 使用 `abs() < 1e-10` 浮点容差比较，与本文件已有测试风格一致。

## 行为契约

- 全部变更限于测试文件，不改变生产代码行为
- G33 新增 6 个测试函数放在 matrix_access_test.cj 末尾（`:173` 之后），与同类测试遵循命名和值模式
- G32 新增 2 个测试函数放在 matrix_inverse_test.cj 末尾（`:71` 之后）
- G32 测试使用与 `testInverseTransposeMat3`/`testInverseTransposeMat4` 相同的矩阵值（对角矩阵），保证可验证性
- G32 的恒等式验证逐个分量比较 `inverseTranspose(m)` 与 `transpose(inverse(m))`，容差 1e-10
- `04_diag.md` 更新仅修改 G32/G33 标记文本，不改变诊断内容结构
- `plan.md` 路线表更新仅添加 v12 列并标记 P4-2 全部完成

## 依赖关系

| 修改文件 | 新增依赖 | 说明 |
|---------|---------|------|
| `matrix_access_test.cj` | 不变 | 已导入 `Mat2x2, Mat3x2, Mat4x3, Vec2, Vec3, Vec4, Defaultp`，新增函数无需额外 import |
| `matrix_inverse_test.cj` | `inverse`, `transpose` from `glm.detail` | 现有 import 列表需补充这两个符号，用于 `transpose(inverse(m))` 计算 |

## 设计说明

- G32 不包含 Mat2x2 测试：`inverseTranspose` 生产函数仅对 Mat3x3/Mat4x4 实现（`gtc/matrix_inverse.cj:29,34`），无 Mat2x2 重载。按约束"不修改生产代码"，恒等式验证仅限于 Mat3x3 和 Mat4x4
- 矩阵构造值的逐元素布局与已有测试保持一致模式：列优先构造，测试时通过 row/column 函数提取行/列元素验证
