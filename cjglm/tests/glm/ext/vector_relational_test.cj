package glm.ext
import glm.detail.{ Vec1, Vec2, Vec3, Vec4, Defaultp }
import std.unittest.*
import std.unittest.testmacro.*

@Test
func testEqualVec1ScalarEpsilon(): Unit {
    let x = Vec1<Float64, Defaultp>(1.0)
    let y = Vec1<Float64, Defaultp>(1.0000001)
    let r = equal(x, y, 1e-5)
    @Expect(r.x, true)
}

@Test
func testEqualVec1VectorEpsilon(): Unit {
    let x = Vec1<Float64, Defaultp>(1.0)
    let y = Vec1<Float64, Defaultp>(1.0000001)
    let e = Vec1<Float64, Defaultp>(1e-5)
    let r = equal(x, y, e)
    @Expect(r.x, true)
}

@Test
func testNotEqualVec1ScalarEpsilon(): Unit {
    let x = Vec1<Float64, Defaultp>(1.0)
    let y = Vec1<Float64, Defaultp>(1.1)
    let r = notEqual(x, y, 0.05)
    @Expect(r.x, true)
}

@Test
func testNotEqualVec1VectorEpsilon(): Unit {
    let x = Vec1<Float64, Defaultp>(1.0)
    let y = Vec1<Float64, Defaultp>(1.1)
    let e = Vec1<Float64, Defaultp>(0.05)
    let r = notEqual(x, y, e)
    @Expect(r.x, true)
}

@Test
func testEqualVec2ScalarEpsilon(): Unit {
    let x = Vec2<Float64, Defaultp>(1.0, 2.0)
    let y = Vec2<Float64, Defaultp>(1.0000001, 2.0)
    let r = equal(x, y, 1e-5)
    @Expect(r.x, true)
    @Expect(r.y, true)
}

@Test
func testEqualVec2VectorEpsilon(): Unit {
    let x = Vec2<Float64, Defaultp>(1.0, 2.0)
    let y = Vec2<Float64, Defaultp>(1.0000001, 2.0)
    let e = Vec2<Float64, Defaultp>(1e-5, 1e-5)
    let r = equal(x, y, e)
    @Expect(r.x, true)
    @Expect(r.y, true)
}

@Test
func testNotEqualVec2ScalarEpsilon(): Unit {
    let x = Vec2<Float64, Defaultp>(1.0, 2.0)
    let y = Vec2<Float64, Defaultp>(1.1, 2.0)
    let r = notEqual(x, y, 0.05)
    @Expect(r.x, true)
    @Expect(r.y, false)
}

@Test
func testNotEqualVec2VectorEpsilon(): Unit {
    let x = Vec2<Float64, Defaultp>(1.0, 2.0)
    let y = Vec2<Float64, Defaultp>(1.1, 2.0)
    let e = Vec2<Float64, Defaultp>(0.05, 0.05)
    let r = notEqual(x, y, e)
    @Expect(r.x, true)
    @Expect(r.y, false)
}

@Test
func testEqualVec3ScalarEpsilon(): Unit {
    let x = Vec3<Float64, Defaultp>(1.0, 2.0, 3.0)
    let y = Vec3<Float64, Defaultp>(1.0000001, 2.0, 3.0)
    let r = equal(x, y, 1e-5)
    @Expect(r.x, true)
    @Expect(r.y, true)
    @Expect(r.z, true)
}

@Test
func testEqualVec3VectorEpsilon(): Unit {
    let x = Vec3<Float64, Defaultp>(1.0, 2.0, 3.0)
    let y = Vec3<Float64, Defaultp>(1.0000001, 2.0, 3.0)
    let e = Vec3<Float64, Defaultp>(1e-5, 1e-5, 1e-5)
    let r = equal(x, y, e)
    @Expect(r.x, true)
    @Expect(r.y, true)
    @Expect(r.z, true)
}

@Test
func testNotEqualVec3ScalarEpsilon(): Unit {
    let x = Vec3<Float64, Defaultp>(1.0, 2.0, 3.0)
    let y = Vec3<Float64, Defaultp>(1.1, 2.0, 3.0)
    let r = notEqual(x, y, 0.05)
    @Expect(r.x, true)
    @Expect(r.y, false)
    @Expect(r.z, false)
}

@Test
func testNotEqualVec3VectorEpsilon(): Unit {
    let x = Vec3<Float64, Defaultp>(1.0, 2.0, 3.0)
    let y = Vec3<Float64, Defaultp>(1.1, 2.0, 3.0)
    let e = Vec3<Float64, Defaultp>(0.05, 0.05, 0.05)
    let r = notEqual(x, y, e)
    @Expect(r.x, true)
    @Expect(r.y, false)
    @Expect(r.z, false)
}

@Test
func testEqualVec4ScalarEpsilon(): Unit {
    let x = Vec4<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let y = Vec4<Float64, Defaultp>(1.0000001, 2.0, 3.0, 4.0)
    let r = equal(x, y, 1e-5)
    @Expect(r.x, true)
    @Expect(r.y, true)
    @Expect(r.z, true)
    @Expect(r.w, true)
}

@Test
func testEqualVec4VectorEpsilon(): Unit {
    let x = Vec4<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let y = Vec4<Float64, Defaultp>(1.0000001, 2.0, 3.0, 4.0)
    let e = Vec4<Float64, Defaultp>(1e-5, 1e-5, 1e-5, 1e-5)
    let r = equal(x, y, e)
    @Expect(r.x, true)
    @Expect(r.y, true)
    @Expect(r.z, true)
    @Expect(r.w, true)
}

@Test
func testNotEqualVec4ScalarEpsilon(): Unit {
    let x = Vec4<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let y = Vec4<Float64, Defaultp>(1.1, 2.0, 3.0, 4.0)
    let r = notEqual(x, y, 0.05)
    @Expect(r.x, true)
    @Expect(r.y, false)
    @Expect(r.z, false)
    @Expect(r.w, false)
}

@Test
func testNotEqualVec4VectorEpsilon(): Unit {
    let x = Vec4<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let y = Vec4<Float64, Defaultp>(1.1, 2.0, 3.0, 4.0)
    let e = Vec4<Float64, Defaultp>(0.05, 0.05, 0.05, 0.05)
    let r = notEqual(x, y, e)
    @Expect(r.x, true)
    @Expect(r.y, false)
    @Expect(r.z, false)
    @Expect(r.w, false)
}

@Test
func testEqualVec1NegativeDiff(): Unit {
    let x = Vec1<Float64, Defaultp>(1.0)
    let y = Vec1<Float64, Defaultp>(1.0000001)
    let r = equal(x, y, 1e-5)
    @Expect(r.x, true)
}

@Test
func testEqualULPStub(): Unit {
    let x = Vec1<Float64, Defaultp>(1.0)
    let y = Vec1<Float64, Defaultp>(1.0)
    @ExpectThrows[Exception](equal(x, y, Int64(4)))
}
