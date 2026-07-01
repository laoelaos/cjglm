# 详细设计（v11）

## 概述

为 `tests/glm/detail/matrix_test.cj` 补充 Mat3x3/Mat4x4 在 Float32/Float64 下的 determinant 测试，共 4 个新增测试函数。全部为测试文件变更，不修改生产代码。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `tests/glm/detail/matrix_test.cj:287` 之后插入 | 新增函数 | G23: 补充 4 个 determinant 浮点测试函数 |
| `docs/diag/impl/04_diag.md:318` | 修改 | G23 条目末尾添加 `✅ 已修复` |
| `harness/implements/202606301007_fix_04_diag/plan.md:10,24` | 修改 | 路线表增加 v11 列，P4-2 标记 ✅ |

## 类型定义

无新增/修改类型。仅新增测试函数。

### 新增测试函数（插入于 `:287` 行 testDeterminantMat2x2Float64 之后）

#### testDeterminantMat3x3Float32

使用与 Int64 版本相同的矩阵值（`1,2,3,4,5,6,7,8,10`），Sarrus 规则校验行列式结果：

```cangjie
@Test
func testDeterminantMat3x3Float32(): Unit {
    let m = Mat3x3<Float32, Defaultp>(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0), Float32(7.0), Float32(8.0), Float32(10.0))
    let det = determinant(m)
    @Expect(det, Float32(1.0)*(Float32(5.0)*Float32(10.0)-Float32(6.0)*Float32(8.0))-Float32(2.0)*(Float32(4.0)*Float32(10.0)-Float32(6.0)*Float32(7.0))+Float32(3.0)*(Float32(4.0)*Float32(8.0)-Float32(5.0)*Float32(7.0)))
}
```

#### testDeterminantMat3x3Float64

与 Float32 版本相同，使用 Float64 类型：

```cangjie
@Test
func testDeterminantMat3x3Float64(): Unit {
    let m = Mat3x3<Float64, Defaultp>(Float64(1.0), Float64(2.0), Float64(3.0), Float64(4.0), Float64(5.0), Float64(6.0), Float64(7.0), Float64(8.0), Float64(10.0))
    let det = determinant(m)
    @Expect(det, Float64(1.0)*(Float64(5.0)*Float64(10.0)-Float64(6.0)*Float64(8.0))-Float64(2.0)*(Float64(4.0)*Float64(10.0)-Float64(6.0)*Float64(7.0))+Float64(3.0)*(Float64(4.0)*Float64(8.0)-Float64(5.0)*Float64(7.0)))
}
```

#### testDeterminantMat4x4Float32

使用对角矩阵 `diag(1,2,3,4)`（与 Int64 版本相同矩阵值），行列式 = 1×2×3×4：

```cangjie
@Test
func testDeterminantMat4x4Float32(): Unit {
    let m = Mat4x4<Float32, Defaultp>(Float32(1.0), Float32(0.0), Float32(0.0), Float32(0.0), Float32(0.0), Float32(2.0), Float32(0.0), Float32(0.0), Float32(0.0), Float32(0.0), Float32(3.0), Float32(0.0), Float32(0.0), Float32(0.0), Float32(0.0), Float32(4.0))
    let det = determinant(m)
    @Expect(det, Float32(1.0)*Float32(2.0)*Float32(3.0)*Float32(4.0))
}
```

#### testDeterminantMat4x4Float64

与 Float32 版本相同，使用 Float64 类型：

```cangjie
@Test
func testDeterminantMat4x4Float64(): Unit {
    let m = Mat4x4<Float64, Defaultp>(Float64(1.0), Float64(0.0), Float64(0.0), Float64(0.0), Float64(0.0), Float64(2.0), Float64(0.0), Float64(0.0), Float64(0.0), Float64(0.0), Float64(3.0), Float64(0.0), Float64(0.0), Float64(0.0), Float64(0.0), Float64(4.0))
    let det = determinant(m)
    @Expect(det, Float64(1.0)*Float64(2.0)*Float64(3.0)*Float64(4.0))
}
```

## 错误处理

全部为新增测试，不涉及错误处理逻辑变更。

## 行为契约

- 全部变更限于测试文件，不改变生产代码行为
- 测试函数命名遵循既有约定：`testDeterminantMat{3|4}x{3|4}Float{32|64}`
- 新增测试放在既有 determinant 测试之后（`:287` 行之后），与同类测试相邻
- Mat3x3 使用 Sarrus 规则校验行列式值，Mat4x4 使用对角矩阵乘积校验
- 所有测试使用对应 Float32/Float64 类型 + Defaultp 精度限定符
- `04_diag.md` 更新仅修改 G23 标记文本，不改变诊断内容结构
- `plan.md` 路线表更新仅添加 v11 列并标记 P4-2 进度

## 依赖关系

| 修改文件 | 新增依赖 | 说明 |
|---------|---------|------|
| `matrix_test.cj` | 不变 | 已有 `import std.unittest.*`、`import std.unittest.testmacro.*`，新增函数无需额外 import |
