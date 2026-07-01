# 详细设计（v14）

## 概述

完成 P4-3 次批：vector_common_test.cj 的 Vec1/Vec4 维度补全（G25）+ fclamp 边界值测试（G26）。全部变更限于测试文件和文档标记，不修改生产代码。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `tests/glm/ext/vector_common_test.cj:361` 之后追加 | 新增 18 个测试函数 | G25: 6 个 Vec1/Vec4 2-input fmin/fmax/fclamp 测试; G26: 12 个 fclamp 边界值测试 |
| `docs/diag/impl/04_diag.md:328,334` | 修改 | G25/G26 添加 `✅ 已修复` |
| `harness/implements/202606301007_fix_04_diag/plan.md:25` | 修改 | 路线表 v14 列 P4-3 标记 ✅ |

## 类型定义

无新增/修改类型。仅新增测试函数。

### G25: vector_common_test.cj Vec1/Vec4 维度补全（6 个测试）

参照 `testFminVec2`(L28-35) / `testFmaxVec3`(L37-45) / `testFclampVec2`(L47-53) 模式，为 Vec1 和 Vec4 补充 2-input fmin/fmax/fclamp。

#### testFminVec1
```cangjie
@Test
func testFminVec1(): Unit {
    let a = Vec1<Float64, Defaultp>(1.0)
    let b = Vec1<Float64, Defaultp>(2.0)
    let r = fmin(a, b)
    @Expect(r.x, 1.0)
}
```

#### testFmaxVec1
```cangjie
@Test
func testFmaxVec1(): Unit {
    let a = Vec1<Float64, Defaultp>(1.0)
    let b = Vec1<Float64, Defaultp>(2.0)
    let r = fmax(a, b)
    @Expect(r.x, 2.0)
}
```

#### testFclampVec1
```cangjie
@Test
func testFclampVec1(): Unit {
    let x = Vec1<Float64, Defaultp>(0.5)
    let r = fclamp(x, 0.0, 1.0)
    @Expect(r.x, 0.5)
}
```

#### testFminVec4
```cangjie
@Test
func testFminVec4(): Unit {
    let a = Vec4<Float64, Defaultp>(1.0, 3.0, 5.0, 7.0)
    let b = Vec4<Float64, Defaultp>(2.0, 1.0, 4.0, 6.0)
    let r = fmin(a, b)
    @Expect(r.x, 1.0)
    @Expect(r.y, 1.0)
    @Expect(r.z, 4.0)
    @Expect(r.w, 6.0)
}
```

#### testFmaxVec4
```cangjie
@Test
func testFmaxVec4(): Unit {
    let a = Vec4<Float64, Defaultp>(1.0, 3.0, 5.0, 2.0)
    let b = Vec4<Float64, Defaultp>(2.0, 1.0, 4.0, 6.0)
    let r = fmax(a, b)
    @Expect(r.x, 2.0)
    @Expect(r.y, 3.0)
    @Expect(r.z, 5.0)
    @Expect(r.w, 6.0)
}
```

#### testFclampVec4
```cangjie
@Test
func testFclampVec4(): Unit {
    let x = Vec4<Float64, Defaultp>(0.5, 1.5, -0.5, 2.0)
    let r = fclamp(x, 0.0, 1.0)
    @Expect(r.x, 0.5)
    @Expect(r.y, 1.0)
    @Expect(r.z, 0.0)
    @Expect(r.w, 1.0)
}
```

### G26: fclamp 边界值测试（12 个测试）

对 Vec2/Vec3/Vec4 三组维度各补充 4 个边界场景：全低于下限、全高于上限、零宽度区间、NaN 输入。

#### Vec2 边界（4 个）

```cangjie
@Test
func testFclampVec2Underflow(): Unit {
    let x = Vec2<Float64, Defaultp>(-1.0, -1.0)
    let r = fclamp(x, 0.0, 1.0)
    @Expect(r.x, 0.0)
    @Expect(r.y, 0.0)
}

@Test
func testFclampVec2Overflow(): Unit {
    let x = Vec2<Float64, Defaultp>(2.0, 2.0)
    let r = fclamp(x, 0.0, 1.0)
    @Expect(r.x, 1.0)
    @Expect(r.y, 1.0)
}

@Test
func testFclampVec2ZeroWidth(): Unit {
    let x = Vec2<Float64, Defaultp>(0.3, 0.7)
    let r = fclamp(x, 0.5, 0.5)
    @Expect(r.x, 0.5)
    @Expect(r.y, 0.5)
}

@Test
func testFclampVec2NaN(): Unit {
    let x = Vec2<Float64, Defaultp>(Float64.getNaN(), 0.5)
    let r = fclamp(x, 0.0, 1.0)
    @Expect(r.x, 0.0)
    @Expect(r.y, 0.5)
}
```

#### Vec3 边界（4 个）

```cangjie
@Test
func testFclampVec3Underflow(): Unit {
    let x = Vec3<Float64, Defaultp>(-1.0, -1.0, -1.0)
    let r = fclamp(x, 0.0, 1.0)
    @Expect(r.x, 0.0)
    @Expect(r.y, 0.0)
    @Expect(r.z, 0.0)
}

@Test
func testFclampVec3Overflow(): Unit {
    let x = Vec3<Float64, Defaultp>(2.0, 2.0, 2.0)
    let r = fclamp(x, 0.0, 1.0)
    @Expect(r.x, 1.0)
    @Expect(r.y, 1.0)
    @Expect(r.z, 1.0)
}

@Test
func testFclampVec3ZeroWidth(): Unit {
    let x = Vec3<Float64, Defaultp>(0.3, 0.7, 0.5)
    let r = fclamp(x, 0.5, 0.5)
    @Expect(r.x, 0.5)
    @Expect(r.y, 0.5)
    @Expect(r.z, 0.5)
}

@Test
func testFclampVec3NaN(): Unit {
    let x = Vec3<Float64, Defaultp>(Float64.getNaN(), 0.5, 0.5)
    let r = fclamp(x, 0.0, 1.0)
    @Expect(r.x, 0.0)
    @Expect(r.y, 0.5)
    @Expect(r.z, 0.5)
}
```

#### Vec4 边界（4 个）

```cangjie
@Test
func testFclampVec4Underflow(): Unit {
    let x = Vec4<Float64, Defaultp>(-1.0, -1.0, -1.0, -1.0)
    let r = fclamp(x, 0.0, 1.0)
    @Expect(r.x, 0.0)
    @Expect(r.y, 0.0)
    @Expect(r.z, 0.0)
    @Expect(r.w, 0.0)
}

@Test
func testFclampVec4Overflow(): Unit {
    let x = Vec4<Float64, Defaultp>(2.0, 2.0, 2.0, 2.0)
    let r = fclamp(x, 0.0, 1.0)
    @Expect(r.x, 1.0)
    @Expect(r.y, 1.0)
    @Expect(r.z, 1.0)
    @Expect(r.w, 1.0)
}

@Test
func testFclampVec4ZeroWidth(): Unit {
    let x = Vec4<Float64, Defaultp>(0.3, 0.7, 0.5, 0.2)
    let r = fclamp(x, 0.5, 0.5)
    @Expect(r.x, 0.5)
    @Expect(r.y, 0.5)
    @Expect(r.z, 0.5)
    @Expect(r.w, 0.5)
}

@Test
func testFclampVec4NaN(): Unit {
    let x = Vec4<Float64, Defaultp>(Float64.getNaN(), 0.5, 0.5, 0.5)
    let r = fclamp(x, 0.0, 1.0)
    @Expect(r.x, 0.0)
    @Expect(r.y, 0.5)
    @Expect(r.z, 0.5)
    @Expect(r.w, 0.5)
}
```

## 错误处理

全部为新增测试，不涉及错误处理逻辑变更。NaN 测试依赖 `Float64.getNaN()`，已在现有 NaN 保护测试中验证可用。

## 行为契约

- 全部变更限于测试文件，不改变生产代码行为
- G25 的 6 个测试追加到文件末尾（`:361` 之后）
- G26 的 12 个测试追加在 G25 之后，所有 18 个测试集中在文件末尾
- `04_diag.md` 更新仅修改 G25/G26 行添加 `✅ 已修复`，不改变诊断内容结构
- `plan.md` 路线表 v14 列 P4-3 标记 ✅

## 依赖关系

| 修改文件 | 新增依赖 | 说明 |
|---------|---------|------|
| `vector_common_test.cj` | 无 | 已有 `Vec1/Vec2/Vec3/Vec4/Defaultp` import，`fmin/fmax/fclamp` 通过 `package glm.ext` 自动可见 |
| `04_diag.md` | 无 | 纯文本标记 |
| `plan.md` | 无 | 纯文本标记 |
