package glm.ext
import glm.detail.{ Quat, Vec3, Defaultp }
import std.unittest.*
import std.unittest.testmacro.*

@Test
func testRotateZeroAngle(): Unit {
    let q = Quat<Float64, Defaultp>(1.0, 0.0, 0.0, 0.0)
    let axis = Vec3<Float64, Defaultp>(0.0, 0.0, 1.0)
    let r = rotate(q, 0.0, axis)
    @Expect(r.w, 1.0)
    @Expect(r.x, 0.0)
    @Expect(r.y, 0.0)
    @Expect(r.z, 0.0)
}

@Test
func testRotate90Z(): Unit {
    let q = Quat<Float64, Defaultp>(1.0, 0.0, 0.0, 0.0)
    let axis = Vec3<Float64, Defaultp>(0.0, 0.0, 1.0)
    let half = 0.7071067811865476
    let r = rotate(q, 1.5707963267948966, axis)
    @Expect((r.w - half).abs() < 1e-10, true)
    @Expect(r.x, 0.0)
    @Expect(r.y, 0.0)
    @Expect((r.z - half).abs() < 1e-10, true)
}

@Test
func testRotateFullCircle(): Unit {
    let q = Quat<Float64, Defaultp>(1.0, 0.0, 0.0, 0.0)
    let axis = Vec3<Float64, Defaultp>(1.0, 0.0, 0.0)
    let r = rotate(q, 6.283185307179586, axis)
    @Expect((r.w - 1.0).abs() < 1e-10, true)
    @Expect((r.x).abs() < 1e-10, true)
    @Expect((r.y).abs() < 1e-10, true)
    @Expect((r.z).abs() < 1e-10, true)
}

@Test
func testRotateNonUnitAxis(): Unit {
    let q = Quat<Float64, Defaultp>(1.0, 0.0, 0.0, 0.0)
    let axis = Vec3<Float64, Defaultp>(0.0, 0.0, 2.0)
    let half = 0.7071067811865476
    let r = rotate(q, 1.5707963267948966, axis)
    @Expect((r.w - half).abs() < 1e-10, true)
    @Expect(r.x, 0.0)
    @Expect(r.y, 0.0)
    @Expect((r.z - half).abs() < 1e-10, true)
}

@Test
func testRotateZeroAxis(): Unit {
    let q = Quat<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let axis = Vec3<Float64, Defaultp>(0.0, 0.0, 0.0)
    let r = rotate(q, 1.0, axis)
    @Expect(r.w, 1.0)
    @Expect(r.x, 0.0)
    @Expect(r.y, 0.0)
    @Expect(r.z, 0.0)
}

@Test
func testRotateNonIdentity(): Unit {
    let q = Quat<Float64, Defaultp>(0.7071067811865476, 0.0, 0.7071067811865476, 0.0)
    let axis = Vec3<Float64, Defaultp>(0.0, 0.0, 1.0)
    let r = rotate(q, 1.5707963267948966, axis)
    @Expect((r.x - 0.5).abs() < 1e-10, true)
    @Expect((r.z - 0.5).abs() < 1e-10, true)
}
