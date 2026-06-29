package glm.detail

import std.unittest.*
import std.unittest.testmacro.*

@Test
func testRefractVec2Stub(): Unit {
    let I = Vec2<Float64, Defaultp>(1.0, -1.0)
    let N = Vec2<Float64, Defaultp>(0.0, 1.0)
    try {
        refract(I, N, 1.5)
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}

@Test
func testRefractVec3Stub(): Unit {
    let I = Vec3<Float64, Defaultp>(1.0, -1.0, 0.0)
    let N = Vec3<Float64, Defaultp>(0.0, 1.0, 0.0)
    try {
        refract(I, N, 1.5)
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}

@Test
func testRefractVec4Stub(): Unit {
    let I = Vec4<Float64, Defaultp>(1.0, -1.0, 0.0, 0.0)
    let N = Vec4<Float64, Defaultp>(0.0, 1.0, 0.0, 0.0)
    try {
        refract(I, N, 1.5)
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}
