package glm.ext
import glm.detail.{ Quat, Defaultp }
import std.unittest.*
import std.unittest.testmacro.*

@Test
func testEqualExact(): Unit {
    let q1 = Quat<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let q2 = Quat<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let r = equal(q1, q2)
    @Expect(r.x, true)
    @Expect(r.y, true)
    @Expect(r.z, true)
    @Expect(r.w, true)
}

@Test
func testNotEqualExact(): Unit {
    let q1 = Quat<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let q2 = Quat<Float64, Defaultp>(5.0, 6.0, 7.0, 8.0)
    let r = notEqual(q1, q2)
    @Expect(r.x, true)
    @Expect(r.y, true)
    @Expect(r.z, true)
    @Expect(r.w, true)
}

@Test
func testEqualEpsilon(): Unit {
    let q1 = Quat<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let q2 = Quat<Float64, Defaultp>(1.0000000001, 2.0, 3.0, 4.0)
    let r = equal(q1, q2, 1e-6)
    @Expect(r.x, true)
    @Expect(r.y, true)
    @Expect(r.z, true)
    @Expect(r.w, true)
}

@Test
func testNotEqualEpsilon(): Unit {
    let q1 = Quat<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let q2 = Quat<Float64, Defaultp>(1.1, 2.0, 3.0, 4.0)
    let r = notEqual(q1, q2, 0.05)
    @Expect(r.x, true)
    @Expect(r.y, false)
    @Expect(r.z, false)
    @Expect(r.w, false)
}

@Test
func testEqualEpsilonBoundary(): Unit {
    let q = Quat<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let qsame = Quat<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let r0 = equal(q, qsame, 0.0)
    @Expect(r0.x, false)
    @Expect(r0.y, false)
    @Expect(r0.z, false)
    @Expect(r0.w, false)
    let rSmall = equal(q, qsame, 1e-15)
    @Expect(rSmall.x, true)
    @Expect(rSmall.y, true)
    @Expect(rSmall.z, true)
    @Expect(rSmall.w, true)
}
