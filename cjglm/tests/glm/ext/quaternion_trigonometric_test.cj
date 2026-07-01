package glm.ext
import glm.detail.{ Quat, Vec3, Defaultp }
import std.unittest.*
import std.unittest.testmacro.*

@Test
func testAxisUnitQuat(): Unit {
    let q = Quat<Float64, Defaultp>(0.0, 0.0, 0.0, 1.0)
    let a = axis(q)
    @Expect(a.x, 0.0)
    @Expect(a.y, 0.0)
    @Expect(a.z, 1.0)
}

@Test
func testAxisNonUnit(): Unit {
    let q = Quat<Float64, Defaultp>(1.0, 0.0, 0.0, 0.0)
    let a = axis(q)
    @Expect(a.x, 1.0)
    @Expect(a.y, 0.0)
    @Expect(a.z, 0.0)
}

@Test
func testAxisZeroQuat(): Unit {
    let q = Quat<Float64, Defaultp>(0.0, 0.0, 0.0, 0.0)
    let a = axis(q)
    @Expect(a.x, 0.0)
    @Expect(a.y, 0.0)
    @Expect(a.z, 0.0)
}

@Test
func testAngle(): Unit {
    let q = Quat<Float64, Defaultp>(1.0, 0.0, 0.0, 0.0)
    @Expect(angle(q), 0.0)
}

@Test
func testAngleRightAngle(): Unit {
    let half = 0.7071067811865476
    let q = Quat<Float64, Defaultp>(half, 0.0, 0.0, half)
    @Expect(angle(q), 1.5707963267948966)
}

@Test
func testAngleAxis(): Unit {
    let axisVec = Vec3<Float64, Defaultp>(0.0, 0.0, 1.0)
    let q = angleAxis(0.0, axisVec)
    @Expect(q.w, 1.0)
    @Expect(q.x, 0.0)
    @Expect(q.y, 0.0)
    @Expect(q.z, 0.0)
}

@Test
func testAngleAxisRightAngle(): Unit {
    let axisVec = Vec3<Float64, Defaultp>(0.0, 0.0, 1.0)
    let half = 0.7071067811865476
    let q = angleAxis(1.5707963267948966, axisVec)
    @Expect(q.w, half)
    @Expect(q.x, 0.0)
    @Expect(q.y, 0.0)
    @Expect(q.z, half)
}

@Test
func testAngleAngleAxisRoundtrip(): Unit {
    let theta = 0.7853981633974483
    let axisVec = Vec3<Float64, Defaultp>(0.0, 1.0, 0.0)
    let q = angleAxis(theta, axisVec)
    let a = angle(q)
    @Expect((a - theta).abs() < 1e-10, true)
}

@Test
func testAxisAngleAxisRoundtrip(): Unit {
    let theta = 0.7853981633974483
    let axisVec = Vec3<Float64, Defaultp>(0.0, 1.0, 0.0)
    let q = angleAxis(theta, axisVec)
    let a = axis(q)
    let dotResult = a.x * axisVec.x + a.y * axisVec.y + a.z * axisVec.z
    @Expect(dotResult > 0.999999, true)
}
