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
func testAngleStub(): Unit {
    let q = Quat<Float64, Defaultp>(1.0, 0.0, 0.0, 0.0)
    @ExpectThrows[Exception](angle(q))
}

@Test
func testAngleAxisStub(): Unit {
    let axisVec = Vec3<Float64, Defaultp>(0.0, 0.0, 1.0)
    @ExpectThrows[Exception](angleAxis(0.0, axisVec))
}
