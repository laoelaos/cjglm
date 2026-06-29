package glm.ext
import glm.detail.{ Quat, Defaultp }
import std.unittest.*
import std.unittest.testmacro.*
import std.math.sqrt

@Test
func testDot(): Unit {
    let q1 = Quat<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let q2 = Quat<Float64, Defaultp>(5.0, 6.0, 7.0, 8.0)
    @Expect(dot(q1, q2), 70.0)
}

@Test
func testLength(): Unit {
    let q = Quat<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    @Expect(length(q), sqrt(30.0))
}

@Test
func testNormalize(): Unit {
    let q = Quat<Float64, Defaultp>(3.0, 0.0, 0.0, 0.0)
    let n = normalize(q)
    @Expect(n.x, 1.0)
    @Expect(n.y, 0.0)
    @Expect(n.z, 0.0)
    @Expect(n.w, 0.0)
}

@Test
func testNormalizeZero(): Unit {
    let q = Quat<Float64, Defaultp>(0.0, 0.0, 0.0, 0.0)
    let n = normalize(q)
    @Expect(n.x, 0.0)
    @Expect(n.y, 0.0)
    @Expect(n.z, 0.0)
    @Expect(n.w, 1.0)
}

@Test
func testCross(): Unit {
    let q1 = Quat<Float64, Defaultp>(1.0, 0.0, 0.0, 0.0)
    let q2 = Quat<Float64, Defaultp>(0.0, 1.0, 0.0, 0.0)
    let c = cross(q1, q2)
    @Expect(c.w, 0.0)
    @Expect(c.x, 0.0)
    @Expect(c.y, 0.0)
    @Expect(c.z, 1.0)
}
