# 详细设计（v3）

## 概述

在 `cjglm/tests/glm/detail/test_matrix.cj` 末尾追加 12 个 `@Test` 函数，覆盖 `matrixCompMult`（6 个缺失非方阵类型）和 `outerProduct`（6 个缺失向量组合），仅 Int64 类型。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `cjglm/tests/glm/detail/test_matrix.cj` | 追加 | 在第 291 行后追加 12 个 `@Test` 函数 |

## 测试函数清单

### matrixCompMult（6 个）

**testMatrixCompMultMat2x4**
```cangjie
@Test
func testMatrixCompMultMat2x4(): Unit {
    let x = Mat2x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let y = Mat2x4<Int64, Defaultp>(2, 3, 4, 5, 6, 7, 8, 9)
    let r = matrixCompMult(x, y)
    @Expect(r.c0.x, 1 * 2)
    @Expect(r.c0.y, 2 * 3)
    @Expect(r.c0.z, 3 * 4)
    @Expect(r.c0.w, 4 * 5)
    @Expect(r.c1.x, 5 * 6)
    @Expect(r.c1.y, 6 * 7)
    @Expect(r.c1.z, 7 * 8)
    @Expect(r.c1.w, 8 * 9)
}
```

**testMatrixCompMultMat3x2**
```cangjie
@Test
func testMatrixCompMultMat3x2(): Unit {
    let x = Mat3x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let y = Mat3x2<Int64, Defaultp>(2, 3, 4, 5, 6, 7)
    let r = matrixCompMult(x, y)
    @Expect(r.c0.x, 1 * 2)
    @Expect(r.c0.y, 2 * 3)
    @Expect(r.c1.x, 3 * 4)
    @Expect(r.c1.y, 4 * 5)
    @Expect(r.c2.x, 5 * 6)
    @Expect(r.c2.y, 6 * 7)
}
```

**testMatrixCompMultMat3x3**
```cangjie
@Test
func testMatrixCompMultMat3x3(): Unit {
    let x = Mat3x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9)
    let y = Mat3x3<Int64, Defaultp>(1, 1, 1, 1, 1, 1, 1, 1, 1)
    let r = matrixCompMult(x, y)
    @Expect(r.c0.x, 1)
    @Expect(r.c0.y, 2)
    @Expect(r.c0.z, 3)
    @Expect(r.c1.x, 4)
    @Expect(r.c1.y, 5)
    @Expect(r.c1.z, 6)
    @Expect(r.c2.x, 7)
    @Expect(r.c2.y, 8)
    @Expect(r.c2.z, 9)
}
```

**testMatrixCompMultMat3x4**
```cangjie
@Test
func testMatrixCompMultMat3x4(): Unit {
    let x = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let y = Mat3x4<Int64, Defaultp>(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
    let r = matrixCompMult(x, y)
    @Expect(r.c0.x, 1)
    @Expect(r.c0.y, 2)
    @Expect(r.c0.z, 3)
    @Expect(r.c0.w, 4)
    @Expect(r.c1.x, 5)
    @Expect(r.c1.y, 6)
    @Expect(r.c1.z, 7)
    @Expect(r.c1.w, 8)
    @Expect(r.c2.x, 9)
    @Expect(r.c2.y, 10)
    @Expect(r.c2.z, 11)
    @Expect(r.c2.w, 12)
}
```

**testMatrixCompMultMat4x2**
```cangjie
@Test
func testMatrixCompMultMat4x2(): Unit {
    let x = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let y = Mat4x2<Int64, Defaultp>(2, 3, 4, 5, 6, 7, 8, 9)
    let r = matrixCompMult(x, y)
    @Expect(r.c0.x, 1 * 2)
    @Expect(r.c0.y, 2 * 3)
    @Expect(r.c1.x, 3 * 4)
    @Expect(r.c1.y, 4 * 5)
    @Expect(r.c2.x, 5 * 6)
    @Expect(r.c2.y, 6 * 7)
    @Expect(r.c3.x, 7 * 8)
    @Expect(r.c3.y, 8 * 9)
}
```

**testMatrixCompMultMat4x3**
```cangjie
@Test
func testMatrixCompMultMat4x3(): Unit {
    let x = Mat4x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let y = Mat4x3<Int64, Defaultp>(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
    let r = matrixCompMult(x, y)
    @Expect(r.c0.x, 1)
    @Expect(r.c0.y, 2)
    @Expect(r.c0.z, 3)
    @Expect(r.c1.x, 4)
    @Expect(r.c1.y, 5)
    @Expect(r.c1.z, 6)
    @Expect(r.c2.x, 7)
    @Expect(r.c2.y, 8)
    @Expect(r.c2.z, 9)
    @Expect(r.c3.x, 10)
    @Expect(r.c3.y, 11)
    @Expect(r.c3.z, 12)
}
```

### outerProduct（6 个）

**testOuterProductVec2Vec3**
```cangjie
@Test
func testOuterProductVec2Vec3(): Unit {
    let c = Vec2<Int64, Defaultp>(2, 3)
    let r = Vec3<Int64, Defaultp>(5, 7, 11)
    let m = outerProduct(c, r)
    @Expect(m.c0.x, 2 * 5)
    @Expect(m.c0.y, 3 * 5)
    @Expect(m.c1.x, 2 * 7)
    @Expect(m.c1.y, 3 * 7)
    @Expect(m.c2.x, 2 * 11)
    @Expect(m.c2.y, 3 * 11)
}
```

**testOuterProductVec2Vec4**
```cangjie
@Test
func testOuterProductVec2Vec4(): Unit {
    let c = Vec2<Int64, Defaultp>(2, 3)
    let r = Vec4<Int64, Defaultp>(5, 7, 11, 13)
    let m = outerProduct(c, r)
    @Expect(m.c0.x, 2 * 5)
    @Expect(m.c0.y, 3 * 5)
    @Expect(m.c1.x, 2 * 7)
    @Expect(m.c1.y, 3 * 7)
    @Expect(m.c2.x, 2 * 11)
    @Expect(m.c2.y, 3 * 11)
    @Expect(m.c3.x, 2 * 13)
    @Expect(m.c3.y, 3 * 13)
}
```

**testOuterProductVec3Vec3**
```cangjie
@Test
func testOuterProductVec3Vec3(): Unit {
    let c = Vec3<Int64, Defaultp>(2, 3, 5)
    let r = Vec3<Int64, Defaultp>(7, 11, 13)
    let m = outerProduct(c, r)
    @Expect(m.c0.x, 2 * 7)
    @Expect(m.c0.y, 3 * 7)
    @Expect(m.c0.z, 5 * 7)
    @Expect(m.c1.x, 2 * 11)
    @Expect(m.c1.y, 3 * 11)
    @Expect(m.c1.z, 5 * 11)
    @Expect(m.c2.x, 2 * 13)
    @Expect(m.c2.y, 3 * 13)
    @Expect(m.c2.z, 5 * 13)
}
```

**testOuterProductVec3Vec4**
```cangjie
@Test
func testOuterProductVec3Vec4(): Unit {
    let c = Vec3<Int64, Defaultp>(2, 3, 5)
    let r = Vec4<Int64, Defaultp>(7, 11, 13, 17)
    let m = outerProduct(c, r)
    @Expect(m.c0.x, 2 * 7)
    @Expect(m.c0.y, 3 * 7)
    @Expect(m.c0.z, 5 * 7)
    @Expect(m.c1.x, 2 * 11)
    @Expect(m.c1.y, 3 * 11)
    @Expect(m.c1.z, 5 * 11)
    @Expect(m.c2.x, 2 * 13)
    @Expect(m.c2.y, 3 * 13)
    @Expect(m.c2.z, 5 * 13)
    @Expect(m.c3.x, 2 * 17)
    @Expect(m.c3.y, 3 * 17)
    @Expect(m.c3.z, 5 * 17)
}
```

**testOuterProductVec4Vec2**
```cangjie
@Test
func testOuterProductVec4Vec2(): Unit {
    let c = Vec4<Int64, Defaultp>(1, 2, 3, 4)
    let r = Vec2<Int64, Defaultp>(5, 7)
    let m = outerProduct(c, r)
    @Expect(m.c0.x, 1 * 5)
    @Expect(m.c0.y, 2 * 5)
    @Expect(m.c0.z, 3 * 5)
    @Expect(m.c0.w, 4 * 5)
    @Expect(m.c1.x, 1 * 7)
    @Expect(m.c1.y, 2 * 7)
    @Expect(m.c1.z, 3 * 7)
    @Expect(m.c1.w, 4 * 7)
}
```

**testOuterProductVec4Vec3**
```cangjie
@Test
func testOuterProductVec4Vec3(): Unit {
    let c = Vec4<Int64, Defaultp>(1, 2, 3, 4)
    let r = Vec3<Int64, Defaultp>(5, 7, 11)
    let m = outerProduct(c, r)
    @Expect(m.c0.x, 1 * 5)
    @Expect(m.c0.y, 2 * 5)
    @Expect(m.c0.z, 3 * 5)
    @Expect(m.c0.w, 4 * 5)
    @Expect(m.c1.x, 1 * 7)
    @Expect(m.c1.y, 2 * 7)
    @Expect(m.c1.z, 3 * 7)
    @Expect(m.c1.w, 4 * 7)
    @Expect(m.c2.x, 1 * 11)
    @Expect(m.c2.y, 2 * 11)
    @Expect(m.c2.z, 3 * 11)
    @Expect(m.c2.w, 4 * 11)
}
```

## 断言模式

- 列优先逐分量：先 `c0.x, c0.y, ...`，再 `c1.x, c1.y, ...`，依此类推
- 短向量仅访问有效分量（Vec2→.x.y, Vec3→.x.y.z, Vec4→.x.y.z.w）
- y 为全 1 的场景用字面量常量断言，其余用 `a * b` 表达式

## 错误处理

不涉及——仅追加测试断言函数，无错误处理逻辑变更。

## 行为契约

- 12 个新增测试函数应全部通过 `cjpm test` 运行
- 每个测试函数对 `matrixCompMult`/`outerProduct` 全局函数做逐分量验证
- 预期值与 `src/detail/matrix.cj:41-165` 中对应重载的实现逻辑完全一致
- 新增测试追加到文件末尾（第 291 行之后），不修改现有测试

## 依赖关系

- 依赖于 `src/detail/matrix.cj` 中已实现的非方阵重载：
  - `matrixCompMult` 全部 9 个重载（Mat2x2~Mat4x4）已实现
  - `outerProduct` 全部 9 个重载（Vec2×Vec2~Vec4×Vec4）已实现
- 参考现有测试模式：`testMatrixCompMultMat2x2`、`testMatrixCompMultMat2x3`、`testMatrixCompMultMat4x4`、`testOuterProductVec2Vec2`、`testOuterProductVec3Vec2`、`testOuterProductVec4Vec4`
- 矩阵类型依赖：`type_mat2x4.cj`、`type_mat3x2.cj`、`type_mat3x3.cj`、`type_mat3x4.cj`、`type_mat4x2.cj`、`type_mat4x3.cj`
- 向量类型依赖：`type_vec2.cj`、`type_vec3.cj`、`type_vec4.cj`
