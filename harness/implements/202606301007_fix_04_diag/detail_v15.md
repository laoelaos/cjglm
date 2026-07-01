# 详细设计（v15）

## 概述

完成 P4-3 末批 G31：为 `tests/glm/gtc/matrix_transform_test.cj` 补充 ext 重导出函数的 gtc 入口委托路径测试。验证通过 `glm.gtc` 命名空间调用 ext 函数时行为正确。全部变更限于测试文件和文档标记，不修改生产代码。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `tests/glm/gtc/matrix_transform_test.cj:138` 之后追加 | 新增 9 个测试函数 | G31: rotate/scale/shear(ext Vec2)/lookAt/lookAtRH/lookAtLH/frustum/perspective/pickMatrix 的 gtc 入口委托测试 |
| `tests/glm/gtc/matrix_transform_test.cj:2` | 修改 | 添加 `Vec2` 到 import 列表 |
| `docs/diag/impl/04_diag.md:377` | 修改 | G31 行添加 `✅ 已修复` |
| `harness/implements/202606301007_fix_04_diag/plan.md:25` | 修改 | 路线表 v15 列 P4-3 标记 ✅ |

## 类型定义

无新增/修改类型。仅新增测试函数和调整 import。

### import 变更

当前导入：
```cangjie
import glm.detail.{ Mat4x4, Vec3, Vec4, Defaultp }
```

变更为：
```cangjie
import glm.detail.{ Mat4x4, Vec2, Vec3, Vec4, Defaultp }
```

（`Vec2` 为 `shear` ext Vec2 版本和 `pickMatrix` 所需）

### G31: 9 个 gtc 入口委托测试

参照 `testTranslateViaExt`（:124-131）模式编写，使用与 ext 层测试一致的数据，调用时通过 gtc 包级函数名（当前文件 `package glm.gtc`）。

#### testRotateViaExt

参照 `ext/matrix_transform_test.cj:54-62` `testRotateExt90Z`，验证绕 Z 轴 90 度旋转。

```cangjie
@Test
func testRotateViaExt(): Unit {
    let m = Mat4x4<Float64, Defaultp>(1.0)
    let axis = Vec3<Float64, Defaultp>(0.0, 0.0, 1.0)
    let r = rotate(m, 1.5707963267948966, axis)
    @Expect((r.c0.y - 1.0).abs() < 1e-10, true)
    @Expect((r.c1.x + 1.0).abs() < 1e-10, true)
    @Expect((r.c2.z - 1.0).abs() < 1e-10, true)
    @Expect((r.c3.w - 1.0).abs() < 1e-10, true)
}
```

#### testScaleViaExt

参照 `ext/matrix_transform_test.cj:17-24` `testScale`，验证 Vec3(2,3,4) 缩放。

```cangjie
@Test
func testScaleViaExt(): Unit {
    let m = Mat4x4<Float64, Defaultp>(1.0)
    let v = Vec3<Float64, Defaultp>(2.0, 3.0, 4.0)
    let r = scale(m, v)
    @Expect(r.c0.x, 2.0)
    @Expect(r.c1.y, 3.0)
    @Expect(r.c2.z, 4.0)
}
```

#### testShearExtViaExt

参照 `ext/matrix_transform_test.cj:76-87` `testShearExt`，调用 ext 的 Vec2 版本 shear（与 gtc 自有 shear(n+s) 签名区分——ext 版 5 参数 vs gtc 版 3 参数）。

```cangjie
@Test
func testShearExtViaExt(): Unit {
    let m = Mat4x4<Float64, Defaultp>(1.0)
    let p = Vec3<Float64, Defaultp>(1.0, 0.0, 0.0)
    let l_x = Vec2<Float64, Defaultp>(1.0, 0.0)
    let l_y = Vec2<Float64, Defaultp>(0.0, 1.0)
    let l_z = Vec2<Float64, Defaultp>(0.0, 0.0)
    let r = shear(m, p, l_x, l_y, l_z)
    @Expect(r.c0.x, 2.0)
    @Expect(r.c1.y, 1.0)
    @Expect(r.c2.z, 1.0)
    @Expect(r.c3.w, 1.0)
}
```

#### testLookAtViaExt

参照 `ext/matrix_transform_test.cj:45-51` `testLookAt`，验证默认 RH 视图。

```cangjie
@Test
func testLookAtViaExt(): Unit {
    let eye = Vec3<Float64, Defaultp>(0.0, 0.0, 1.0)
    let center = Vec3<Float64, Defaultp>(0.0, 0.0, 0.0)
    let up = Vec3<Float64, Defaultp>(0.0, 1.0, 0.0)
    let r = lookAt(eye, center, up)
    @Expect(r.c2.z, -1.0)
}
```

#### testLookAtRHViaExt

参照 `ext/matrix_transform_test.cj:27-33` `testLookAtRH`，验证右手系视图。

```cangjie
@Test
func testLookAtRHViaExt(): Unit {
    let eye = Vec3<Float64, Defaultp>(0.0, 0.0, 1.0)
    let center = Vec3<Float64, Defaultp>(0.0, 0.0, 0.0)
    let up = Vec3<Float64, Defaultp>(0.0, 1.0, 0.0)
    let r = lookAtRH(eye, center, up)
    @Expect(r.c2.z, -1.0)
}
```

#### testLookAtLHViaExt

参照 `ext/matrix_transform_test.cj:36-42` `testLookAtLH`，验证左手系视图。

```cangjie
@Test
func testLookAtLHViaExt(): Unit {
    let eye = Vec3<Float64, Defaultp>(0.0, 0.0, 1.0)
    let center = Vec3<Float64, Defaultp>(0.0, 0.0, 0.0)
    let up = Vec3<Float64, Defaultp>(0.0, 1.0, 0.0)
    let r = lookAtLH(eye, center, up)
    @Expect(r.c2.z, 1.0)
}
```

#### testFrustumViaExt

参照 `ext/matrix_clip_space_test.cj:38-45` `testFrustumRH_NO`（`frustum` 委托给 `frustumRH_NO`），验证对称视锥体。

```cangjie
@Test
func testFrustumViaExt(): Unit {
    let left = -1.0; let right = 1.0; let bottom = -1.0; let top = 1.0; let near = 0.1; let far = 100.0
    let m = frustum<Float64, Defaultp>(left, right, bottom, top, near, far)
    let fnf = far - near
    let near2 = 2.0 * near
    @Expect((m.c2.z + (far + near) / fnf).abs() < 1e-10, true)
    @Expect((m.c3.z + near2 * far / fnf).abs() < 1e-10, true)
}
```

#### testPerspectiveViaExt

参照 `ext/matrix_clip_space_test.cj:89-98` `testPerspectiveRH_NO`（`perspective` 委托给 `perspectiveRH_NO`），简化为不依赖 `tanT` 的断言。

```cangjie
@Test
func testPerspectiveViaExt(): Unit {
    let fovy = 1.57079632679
    let aspect = 1.0
    let zNear = 0.1
    let zFar = 100.0
    let m = perspective<Float64, Defaultp>(fovy, aspect, zNear, zFar)
    @Expect((m.c2.z + (zFar + zNear) / (zFar - zNear)).abs() < 1e-10, true)
    @Expect(m.c2.w, 1.0)
    @Expect(m.c3.w, 0.0)
}
```

#### testPickMatrixViaExt

参照 `ext/matrix_projection_test.cj:146-153` `testPickMatrix`，验证拾取矩阵缩放系数。

```cangjie
@Test
func testPickMatrixViaExt(): Unit {
    let center = Vec2<Float64, Defaultp>(400.0, 300.0)
    let delta = Vec2<Float64, Defaultp>(100.0, 100.0)
    let vp = Vec4<Int64, Defaultp>(0, 0, 800, 600)
    let m = pickMatrix(center, delta, vp)
    @Expect(m.c0.x, 4.0)
    @Expect(m.c1.y, 3.0)
}
```

## 错误处理

全部为新增测试，不涉及错误处理逻辑变更。浮点比较使用 `@Expect` + `abs() < 1e-10` 容忍模式（与已有 `testRotateSlow90Z`/`testFrustumViaExt` 一致）。

## 行为契约

- 全部变更限于 `tests/glm/gtc/matrix_transform_test.cj`，不改变生产代码
- import 行追加 `Vec2`，不修改已有的 import 项
- 9 个测试函数追加到文件末尾（`:138` 之后）
- 测试命名遵循 `{functionName}ViaExt` 模式（与 `testTranslateViaExt`/`testOrthoViaExt` 一致）
- `04_diag.md` 仅修改 G31 行添加 `✅ 已修复`
- `plan.md` 路线表 v15 列标记 P4-3 ✅

## 依赖关系

| 修改文件 | 新增依赖 | 说明 |
|---------|---------|------|
| `matrix_transform_test.cj` | `Vec2` (glm.detail) | shear ext Vec2 版本 + pickMatrix 的 Vec2 center/delta 参数需要 |
| `04_diag.md` | 无 | 纯文本标记 |
| `plan.md` | 无 | 纯文本标记 |
