# 详细设计（v10）

## 概述

为几何函数库补充边界测试覆盖，涉及 2 个测试文件、2 个问题（G21-G22）。全部为测试文件变更，不修改生产代码。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `tests/glm/detail/geometric_test.cj` | 新增函数 | G21: 补充 length 零向量、distance 同点、cross 平行向量、reflect 垂直入射边界测试 |
| `tests/glm/detail/geometric_refract_test.cj` | 新增函数 | G22: 补充 eta=1 无折射、Vec2/Vec4 全内反射边界测试 |
| `docs/diag/impl/04_diag.md:302-312` | 修改 | 标记 G21/G22 条目末尾添加 ✅ 已修复 |
| `harness/implements/202606301007_fix_04_diag/plan.md:10,24` | 修改 | 路线表 v10 列 P4-2 标记 ✅ |

## 类型定义

无新增/修改类型。仅新增测试函数。

### G21 — geometric_test.cj 补充边界测试

**新增 11 个测试函数**，置于文件末尾，与既有测试风格一致（使用 Float64, Defaultp）。

#### testLengthZeroVec2 / testLengthZeroVec3 / testLengthZeroVec4

```cangjie
@Test
func testLengthZeroVec2(): Unit {
    let v = Vec2<Float64, Defaultp>(0.0, 0.0)
    @Expect(length(v), 0.0)
}

@Test
func testLengthZeroVec3(): Unit {
    let v = Vec3<Float64, Defaultp>(0.0, 0.0, 0.0)
    @Expect(length(v), 0.0)
}

@Test
func testLengthZeroVec4(): Unit {
    let v = Vec4<Float64, Defaultp>(0.0, 0.0, 0.0, 0.0)
    @Expect(length(v), 0.0)
}
```

#### testDistanceSamePointVec2 / testDistanceSamePointVec3 / testDistanceSamePointVec4

```cangjie
@Test
func testDistanceSamePointVec2(): Unit {
    let p = Vec2<Float64, Defaultp>(1.0, 2.0)
    @Expect(distance(p, p), 0.0)
}

@Test
func testDistanceSamePointVec3(): Unit {
    let p = Vec3<Float64, Defaultp>(1.0, 2.0, 3.0)
    @Expect(distance(p, p), 0.0)
}

@Test
func testDistanceSamePointVec4(): Unit {
    let p = Vec4<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    @Expect(distance(p, p), 0.0)
}
```

#### testCrossParallel

```cangjie
@Test
func testCrossParallel(): Unit {
    // cross(parallel vectors) = zero vector
    let x = Vec3<Float64, Defaultp>(2.0, 0.0, 0.0)
    let y = Vec3<Float64, Defaultp>(5.0, 0.0, 0.0)
    let r = cross(x, y)
    @Expect(r.x, 0.0)
    @Expect(r.y, 0.0)
    @Expect(r.z, 0.0)
}
```

#### testReflectPerpendicularVec2 / testReflectPerpendicularVec3 / testReflectPerpendicularVec4

垂直入射反射：I 指向表面（与法线 N 反向平行），`reflect(I, N) = -I`。

```cangjie
@Test
func testReflectPerpendicularVec2(): Unit {
    let I = Vec2<Float64, Defaultp>(0.0, -1.0)
    let N = Vec2<Float64, Defaultp>(0.0, 1.0)
    let r = reflect(I, N)
    @Expect(r.x, 0.0)
    @Expect(r.y, 1.0)   // -I = (0, 1)
}

@Test
func testReflectPerpendicularVec3(): Unit {
    let I = Vec3<Float64, Defaultp>(0.0, -1.0, 0.0)
    let N = Vec3<Float64, Defaultp>(0.0, 1.0, 0.0)
    let r = reflect(I, N)
    @Expect(r.x, 0.0)
    @Expect(r.y, 1.0)   // -I = (0, 1, 0)
    @Expect(r.z, 0.0)
}

@Test
func testReflectPerpendicularVec4(): Unit {
    let I = Vec4<Float64, Defaultp>(0.0, -1.0, 0.0, 0.0)
    let N = Vec4<Float64, Defaultp>(0.0, 1.0, 0.0, 0.0)
    let r = reflect(I, N)
    @Expect(r.x, 0.0)
    @Expect(r.y, 1.0)   // -I = (0, 1, 0, 0)
    @Expect(r.z, 0.0)
    @Expect(r.w, 0.0)
}
```

### G22 — geometric_refract_test.cj 补充边界测试

**新增 5 个测试函数**，置于文件末尾。

#### testRefractEtaOneVec2 / testRefractEtaOneVec3 / testRefractEtaOneVec4

`eta=1.0` 时光线直穿，`refract(I, N, 1.0) = I`。使用 I 与 N 反向平行（dot < 0，物理学上光线从外部进入表面），确保 k >= 0 且折射结果等于 I。

```cangjie
@Test
func testRefractEtaOneVec2(): Unit {
    let I = Vec2<Float64, Defaultp>(0.0, -1.0)
    let N = Vec2<Float64, Defaultp>(0.0, 1.0)
    let r = refract(I, N, 1.0)
    @Expect(r.x, 0.0)
    @Expect(r.y, -1.0)  // r = I
}

@Test
func testRefractEtaOneVec3(): Unit {
    let I = Vec3<Float64, Defaultp>(0.0, -1.0, 0.0)
    let N = Vec3<Float64, Defaultp>(0.0, 1.0, 0.0)
    let r = refract(I, N, 1.0)
    @Expect(r.x, 0.0)
    @Expect(r.y, -1.0)  // r = I
    @Expect(r.z, 0.0)
}

@Test
func testRefractEtaOneVec4(): Unit {
    let I = Vec4<Float64, Defaultp>(0.0, -1.0, 0.0, 0.0)
    let N = Vec4<Float64, Defaultp>(0.0, 1.0, 0.0, 0.0)
    let r = refract(I, N, 1.0)
    @Expect(r.x, 0.0)
    @Expect(r.y, -1.0)  // r = I
    @Expect(r.z, 0.0)
    @Expect(r.w, 0.0)
}
```

#### testRefractTotalInternalReflectionVec2 / testRefractTotalInternalReflectionVec4

大 eta（2.0）+ I 与 N 垂直（dot=0）⇒ k=1-4×(1-0)=-3<0 ⇒ 全内反射返回零向量。

```cangjie
@Test
func testRefractTotalInternalReflectionVec2(): Unit {
    let I = Vec2<Float64, Defaultp>(1.0, 0.0)
    let N = Vec2<Float64, Defaultp>(0.0, 1.0)
    let r = refract(I, N, 2.0)
    @Expect(r.x, 0.0)
    @Expect(r.y, 0.0)
}

@Test
func testRefractTotalInternalReflectionVec4(): Unit {
    let I = Vec4<Float64, Defaultp>(1.0, 0.0, 0.0, 0.0)
    let N = Vec4<Float64, Defaultp>(0.0, 1.0, 0.0, 0.0)
    let r = refract(I, N, 2.0)
    @Expect(r.x, 0.0)
    @Expect(r.y, 0.0)
    @Expect(r.z, 0.0)
    @Expect(r.w, 0.0)
}
```

## 错误处理

全部为新增测试，不涉及错误处理逻辑变更。

## 行为契约

- 全部变更限于测试文件，不改变生产代码行为
- 测试函数命名遵循既有约定：`test{FunctionName}{Description}{VecDim}`
- 新增测试放在既有测试文件末尾（geometric_test.cj 已有 16 个测试函数，geometric_refract_test.cj 已有 4 个）
- 所有测试使用 Float64 + Defaultp 类型，与已有测试风格一致
- 04_diag.md 更新仅修改标记文本，不改变诊断内容结构
- plan.md 路线表更新仅修改 v10 列 P4-2 标记
- 不添加 Vec1 测试——reflect/refract/length/distance/cross 均无 Vec1 重载

## 依赖关系

| 修改文件 | 新增依赖 | 说明 |
|---------|---------|------|
| `geometric_test.cj` | 不变 | 已有 `import std.unittest.*`、`import std.unittest.testmacro.*`、`import std.math.{ sqrt, isNaN }`，新增函数无需额外 import |
| `geometric_refract_test.cj` | 不变 | 已有 `import std.unittest.*`、`import std.unittest.testmacro.*`，新增函数无需额外 import |
