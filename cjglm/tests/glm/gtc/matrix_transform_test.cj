package glm.gtc
import glm.detail.{ Mat4x4, Vec2, Vec3, Vec4, Defaultp }
import std.unittest.*
import std.unittest.testmacro.*

@Test
func testIdentity(): Unit {
    let m = identity<Float64, Defaultp>()
    @Expect(m.c0.x, 1.0)
    @Expect(m.c0.y, 0.0)
    @Expect(m.c0.z, 0.0)
    @Expect(m.c0.w, 0.0)
    @Expect(m.c1.x, 0.0)
    @Expect(m.c1.y, 1.0)
    @Expect(m.c1.z, 0.0)
    @Expect(m.c1.w, 0.0)
    @Expect(m.c2.x, 0.0)
    @Expect(m.c2.y, 0.0)
    @Expect(m.c2.z, 1.0)
    @Expect(m.c2.w, 0.0)
    @Expect(m.c3.x, 0.0)
    @Expect(m.c3.y, 0.0)
    @Expect(m.c3.z, 0.0)
    @Expect(m.c3.w, 1.0)
}

@Test
func testShear(): Unit {
    let m = Mat4x4<Float64, Defaultp>(1.0)
    let n = Vec3<Float64, Defaultp>(1.0, 0.0, 0.0)
    let r = shear(m, n, 1.0)
    @Expect(r.c0.x, 2.0)
    @Expect(r.c1.y, 1.0)
    @Expect(r.c2.z, 1.0)
    @Expect(r.c3.w, 1.0)
}

@Test
func testShearY(): Unit {
    let m = Mat4x4<Float64, Defaultp>(1.0)
    let n = Vec3<Float64, Defaultp>(0.0, 1.0, 0.0)
    let r = shear(m, n, 2.0)
    @Expect(r.c0.x, 1.0)
    @Expect(r.c1.y, 3.0)
}

@Test
func testRotateSlow90Z(): Unit {
    let m = Mat4x4<Float64, Defaultp>(1.0)
    let axis = Vec3<Float64, Defaultp>(0.0, 0.0, 1.0)
    let r = rotate_slow(m, 1.5707963267948966, axis)
    @Expect((r.c0.y - 1.0).abs() < 1e-10, true)
    @Expect((r.c1.x + 1.0).abs() < 1e-10, true)
    @Expect((r.c2.z - 1.0).abs() < 1e-10, true)
    @Expect((r.c3.w - 1.0).abs() < 1e-10, true)
}

@Test
func testRotateSlowZeroAngle(): Unit {
    let m = Mat4x4<Float64, Defaultp>(1.0)
    let axis = Vec3<Float64, Defaultp>(1.0, 0.0, 0.0)
    let r = rotate_slow(m, 0.0, axis)
    @Expect(r.c0.x, 1.0)
    @Expect(r.c1.y, 1.0)
    @Expect(r.c2.z, 1.0)
    @Expect(r.c3.w, 1.0)
}

@Test
func testScaleSlow(): Unit {
    let m = Mat4x4<Float64, Defaultp>(1.0)
    let v = Vec3<Float64, Defaultp>(2.0, 3.0, 4.0)
    let r = scale_slow(m, v)
    @Expect(r.c0.x, 2.0)
    @Expect(r.c1.y, 3.0)
    @Expect(r.c2.z, 4.0)
    @Expect(r.c3.w, 1.0)
}

@Test
func testScaleSlowUniform(): Unit {
    let m = Mat4x4<Float64, Defaultp>(1.0)
    let v = Vec3<Float64, Defaultp>(5.0, 5.0, 5.0)
    let r = scale_slow(m, v)
    @Expect(r.c0.x, 5.0)
    @Expect(r.c1.y, 5.0)
    @Expect(r.c2.z, 5.0)
}

@Test
func testShearSlow(): Unit {
    let m = Mat4x4<Float64, Defaultp>(1.0)
    let n = Vec3<Float64, Defaultp>(1.0, 0.0, 0.0)
    let r = shear_slow(m, n, 1.0)
    @Expect(r.c0.x, 2.0)
    @Expect(r.c1.y, 1.0)
    @Expect(r.c2.z, 1.0)
    @Expect(r.c3.w, 1.0)
}

@Test
func testShearSlowDiagonal(): Unit {
    let m = Mat4x4<Float64, Defaultp>(1.0)
    let n = Vec3<Float64, Defaultp>(0.5, 0.5, 0.0)
    let r = shear_slow(m, n, 2.0)
    @Expect(r.c0.x, 1.5)
    @Expect(r.c0.y, 0.5)
    @Expect(r.c1.x, 0.5)
    @Expect(r.c1.y, 1.5)
}

@Test
func testRotateSlow90X(): Unit {
    let m = Mat4x4<Float64, Defaultp>(1.0)
    let axis = Vec3<Float64, Defaultp>(1.0, 0.0, 0.0)
    let r = rotate_slow(m, 1.5707963267948966, axis)
    @Expect(r.c0.x, 1.0)
    @Expect((r.c1.z - 1.0).abs() < 1e-10, true)
    @Expect((r.c2.y + 1.0).abs() < 1e-10, true)
    @Expect(r.c3.w, 1.0)
}

@Test
func testTranslateViaExt(): Unit {
    let m = Mat4x4<Float64, Defaultp>(1.0)
    let v = Vec3<Float64, Defaultp>(1.0, 2.0, 3.0)
    let r = translate(m, v)
    @Expect(r.c3.x, 1.0)
    @Expect(r.c3.y, 2.0)
    @Expect(r.c3.z, 3.0)
}

@Test
func testOrthoViaExt(): Unit {
    let m = ortho<Float64, Defaultp>(-10.0, 10.0, -5.0, 5.0)
    @Expect(m.c0.x, 0.1)
    @Expect(m.c1.y, 0.2)
}

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

@Test
func testScaleViaExt(): Unit {
    let m = Mat4x4<Float64, Defaultp>(1.0)
    let v = Vec3<Float64, Defaultp>(2.0, 3.0, 4.0)
    let r = scale(m, v)
    @Expect(r.c0.x, 2.0)
    @Expect(r.c1.y, 3.0)
    @Expect(r.c2.z, 4.0)
}

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

@Test
func testLookAtViaExt(): Unit {
    let eye = Vec3<Float64, Defaultp>(0.0, 0.0, 1.0)
    let center = Vec3<Float64, Defaultp>(0.0, 0.0, 0.0)
    let up = Vec3<Float64, Defaultp>(0.0, 1.0, 0.0)
    let r = lookAt(eye, center, up)
    @Expect(r.c2.z, -1.0)
}

@Test
func testLookAtRHViaExt(): Unit {
    let eye = Vec3<Float64, Defaultp>(0.0, 0.0, 1.0)
    let center = Vec3<Float64, Defaultp>(0.0, 0.0, 0.0)
    let up = Vec3<Float64, Defaultp>(0.0, 1.0, 0.0)
    let r = lookAtRH(eye, center, up)
    @Expect(r.c2.z, -1.0)
}

@Test
func testLookAtLHViaExt(): Unit {
    let eye = Vec3<Float64, Defaultp>(0.0, 0.0, 1.0)
    let center = Vec3<Float64, Defaultp>(0.0, 0.0, 0.0)
    let up = Vec3<Float64, Defaultp>(0.0, 1.0, 0.0)
    let r = lookAtLH(eye, center, up)
    @Expect(r.c2.z, 1.0)
}

@Test
func testFrustumViaExt(): Unit {
    let left = -1.0; let right = 1.0; let bottom = -1.0; let top = 1.0; let near = 0.1; let far = 100.0
    let m = frustum<Float64, Defaultp>(left, right, bottom, top, near, far)
    let fnf = far - near
    let near2 = 2.0 * near
    @Expect((m.c2.z + (far + near) / fnf).abs() < 1e-10, true)
    @Expect((m.c3.z + near2 * far / fnf).abs() < 1e-10, true)
}

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

@Test
func testPickMatrixViaExt(): Unit {
    let center = Vec2<Float64, Defaultp>(400.0, 300.0)
    let delta = Vec2<Float64, Defaultp>(100.0, 100.0)
    let vp = Vec4<Int64, Defaultp>(0, 0, 800, 600)
    let m = pickMatrix(center, delta, vp)
    @Expect(m.c0.x, 4.0)
    @Expect(m.c1.y, 3.0)
}
