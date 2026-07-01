package glm.ext
import glm.detail.{ Mat4x4, Vec2, Vec3, Vec4, Defaultp }
import std.unittest.*
import std.unittest.testmacro.*

@Test
func testTranslate(): Unit {
    let m = Mat4x4<Float64, Defaultp>(Vec4(1.0, 0.0, 0.0, 0.0), Vec4(0.0, 1.0, 0.0, 0.0), Vec4(0.0, 0.0, 1.0, 0.0), Vec4(0.0, 0.0, 0.0, 1.0))
    let v = Vec3<Float64, Defaultp>(1.0, 2.0, 3.0)
    let r = translate(m, v)
    @Expect(r.c3.x, 1.0)
    @Expect(r.c3.y, 2.0)
    @Expect(r.c3.z, 3.0)
}

@Test
func testScale(): Unit {
    let m = Mat4x4<Float64, Defaultp>(Vec4(1.0, 0.0, 0.0, 0.0), Vec4(0.0, 1.0, 0.0, 0.0), Vec4(0.0, 0.0, 1.0, 0.0), Vec4(0.0, 0.0, 0.0, 1.0))
    let v = Vec3<Float64, Defaultp>(2.0, 3.0, 4.0)
    let r = scale(m, v)
    @Expect(r.c0.x, 2.0)
    @Expect(r.c1.y, 3.0)
    @Expect(r.c2.z, 4.0)
}

@Test
func testLookAtRH(): Unit {
    let eye = Vec3<Float64, Defaultp>(0.0, 0.0, 1.0)
    let center = Vec3<Float64, Defaultp>(0.0, 0.0, 0.0)
    let up = Vec3<Float64, Defaultp>(0.0, 1.0, 0.0)
    let r = lookAtRH(eye, center, up)
    @Expect(r.c2.z, -1.0)
}

@Test
func testLookAtLH(): Unit {
    let eye = Vec3<Float64, Defaultp>(0.0, 0.0, 1.0)
    let center = Vec3<Float64, Defaultp>(0.0, 0.0, 0.0)
    let up = Vec3<Float64, Defaultp>(0.0, 1.0, 0.0)
    let r = lookAtLH(eye, center, up)
    @Expect(r.c2.z, 1.0)
}

@Test
func testLookAt(): Unit {
    let eye = Vec3<Float64, Defaultp>(0.0, 0.0, 1.0)
    let center = Vec3<Float64, Defaultp>(0.0, 0.0, 0.0)
    let up = Vec3<Float64, Defaultp>(0.0, 1.0, 0.0)
    let r = lookAt(eye, center, up)
    @Expect(r.c2.z, -1.0)
}

@Test
func testRotateExt90Z(): Unit {
    let m = Mat4x4<Float64, Defaultp>(1.0)
    let axis = Vec3<Float64, Defaultp>(0.0, 0.0, 1.0)
    let r = rotate(m, 1.5707963267948966, axis)
    @Expect((r.c0.y - 1.0).abs() < 1e-10, true)
    @Expect((r.c1.x + 1.0).abs() < 1e-10, true)
    @Expect((r.c2.z - 1.0).abs() < 1e-10, true)
    @Expect((r.c3.w - 1.0).abs() < 1e-10, true)
}

@Test
func testRotateExtZeroAngle(): Unit {
    let m = Mat4x4<Float64, Defaultp>(1.0)
    let axis = Vec3<Float64, Defaultp>(1.0, 0.0, 0.0)
    let r = rotate(m, 0.0, axis)
    @Expect(r.c0.x, 1.0)
    @Expect(r.c1.y, 1.0)
    @Expect(r.c2.z, 1.0)
    @Expect(r.c3.w, 1.0)
}

@Test
func testShearExt(): Unit {
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
func testRotateExtLeftMultiply(): Unit {
    let t = translate(Mat4x4<Float64, Defaultp>(1.0), Vec3<Float64, Defaultp>(1.0, 2.0, 3.0))
    let r = rotate(t, 1.5707963267948966, Vec3<Float64, Defaultp>(0.0, 0.0, 1.0))
    @Expect(r.c3.x, 1.0)
    @Expect(r.c3.y, 2.0)
    @Expect(r.c3.z, 3.0)
    @Expect(r.c3.w, 1.0)
}

@Test
func testRotateExtZeroAxisNonIdentity(): Unit {
    let t = translate(Mat4x4<Float64, Defaultp>(1.0), Vec3<Float64, Defaultp>(1.0, 2.0, 3.0))
    let r = rotate(t, 1.5707963267948966, Vec3<Float64, Defaultp>(0.0, 0.0, 0.0))
    @Expect(r.c3.x, 1.0)
    @Expect(r.c3.y, 2.0)
    @Expect(r.c3.z, 3.0)
    @Expect(r.c3.w, 1.0)
}

@Test
func testShearExtLeftMultiply(): Unit {
    let t = translate(Mat4x4<Float64, Defaultp>(1.0), Vec3<Float64, Defaultp>(1.0, 2.0, 3.0))
    let p = Vec3<Float64, Defaultp>(1.0, 0.0, 0.0)
    let l_x = Vec2<Float64, Defaultp>(1.0, 0.0)
    let l_y = Vec2<Float64, Defaultp>(0.0, 1.0)
    let l_z = Vec2<Float64, Defaultp>(0.0, 0.0)
    let r = shear(t, p, l_x, l_y, l_z)
    @Expect(r.c3.x, 1.0)
    @Expect(r.c3.y, 2.0)
    @Expect(r.c3.z, 3.0)
    @Expect(r.c3.w, 1.0)
}
