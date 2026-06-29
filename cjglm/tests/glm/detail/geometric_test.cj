package glm.detail

import std.unittest.*
import std.unittest.testmacro.*

@Test
func testDotVec1Stub(): Unit {
    let x = Vec1<Float64, Defaultp>(1.0)
    let y = Vec1<Float64, Defaultp>(2.0)
    try {
        dot(x, y)
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}

@Test
func testDotVec2Stub(): Unit {
    let x = Vec2<Float64, Defaultp>(1.0, 2.0)
    let y = Vec2<Float64, Defaultp>(3.0, 4.0)
    try {
        dot(x, y)
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}

@Test
func testDotVec3Stub(): Unit {
    let x = Vec3<Float64, Defaultp>(1.0, 2.0, 3.0)
    let y = Vec3<Float64, Defaultp>(4.0, 5.0, 6.0)
    try {
        dot(x, y)
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}

@Test
func testDotVec4Stub(): Unit {
    let x = Vec4<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let y = Vec4<Float64, Defaultp>(5.0, 6.0, 7.0, 8.0)
    try {
        dot(x, y)
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}

@Test
func testCrossStub(): Unit {
    let x = Vec3<Float64, Defaultp>(1.0, 0.0, 0.0)
    let y = Vec3<Float64, Defaultp>(0.0, 1.0, 0.0)
    try {
        cross(x, y)
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}

@Test
func testNormalizeVec2Stub(): Unit {
    let v = Vec2<Float64, Defaultp>(3.0, 4.0)
    try {
        normalize(v)
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}

@Test
func testNormalizeVec3Stub(): Unit {
    let v = Vec3<Float64, Defaultp>(1.0, 2.0, 3.0)
    try {
        normalize(v)
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}

@Test
func testNormalizeVec4Stub(): Unit {
    let v = Vec4<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    try {
        normalize(v)
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}

@Test
func testLengthVec2Stub(): Unit {
    let v = Vec2<Float64, Defaultp>(3.0, 4.0)
    try {
        length(v)
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}

@Test
func testLengthVec3Stub(): Unit {
    let v = Vec3<Float64, Defaultp>(1.0, 2.0, 3.0)
    try {
        length(v)
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}

@Test
func testLengthVec4Stub(): Unit {
    let v = Vec4<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    try {
        length(v)
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}

@Test
func testDistanceVec2Stub(): Unit {
    let p0 = Vec2<Float64, Defaultp>(0.0, 0.0)
    let p1 = Vec2<Float64, Defaultp>(3.0, 4.0)
    try {
        distance(p0, p1)
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}

@Test
func testDistanceVec3Stub(): Unit {
    let p0 = Vec3<Float64, Defaultp>(0.0, 0.0, 0.0)
    let p1 = Vec3<Float64, Defaultp>(1.0, 2.0, 3.0)
    try {
        distance(p0, p1)
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}

@Test
func testDistanceVec4Stub(): Unit {
    let p0 = Vec4<Float64, Defaultp>(0.0, 0.0, 0.0, 0.0)
    let p1 = Vec4<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    try {
        distance(p0, p1)
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}

@Test
func testReflectVec2Stub(): Unit {
    let I = Vec2<Float64, Defaultp>(1.0, -1.0)
    let N = Vec2<Float64, Defaultp>(0.0, 1.0)
    try {
        reflect(I, N)
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}

@Test
func testReflectVec3Stub(): Unit {
    let I = Vec3<Float64, Defaultp>(1.0, -1.0, 0.0)
    let N = Vec3<Float64, Defaultp>(0.0, 1.0, 0.0)
    try {
        reflect(I, N)
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}

@Test
func testReflectVec4Stub(): Unit {
    let I = Vec4<Float64, Defaultp>(1.0, -1.0, 0.0, 0.0)
    let N = Vec4<Float64, Defaultp>(0.0, 1.0, 0.0, 0.0)
    try {
        reflect(I, N)
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}
