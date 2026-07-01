package glm.detail

import std.unittest.*
import std.unittest.testmacro.*

@Test
func testRefractVec2(): Unit {
    let I = Vec2<Float64, Defaultp>(1.0, -1.0)
    let N = Vec2<Float64, Defaultp>(0.0, 1.0)
    let r = refract(I, N, 0.5)
    @Expect(r.x, 0.5)
    @Expect(r.y, -0.5)
}

@Test
func testRefractVec3(): Unit {
    let I = Vec3<Float64, Defaultp>(1.0, -1.0, 0.0)
    let N = Vec3<Float64, Defaultp>(0.0, 1.0, 0.0)
    let r = refract(I, N, 0.5)
    @Expect(r.x, 0.5)
    @Expect(r.y, -0.5)
    @Expect(r.z, 0.0)
}

@Test
func testRefractVec4(): Unit {
    let I = Vec4<Float64, Defaultp>(1.0, -1.0, 0.0, 0.0)
    let N = Vec4<Float64, Defaultp>(0.0, 1.0, 0.0, 0.0)
    let r = refract(I, N, 0.5)
    @Expect(r.x, 0.5)
    @Expect(r.y, -0.5)
    @Expect(r.z, 0.0)
    @Expect(r.w, 0.0)
}

@Test
func testRefractTotalInternalReflection(): Unit {
    let I = Vec3<Float64, Defaultp>(0.0, 1.0, 0.0)
    let N = Vec3<Float64, Defaultp>(0.0, 1.0, 0.0)
    let r = refract(I, N, 2.0)
    @Expect(r.x, 0.0)
    @Expect(r.y, 0.0)
    @Expect(r.z, 0.0)
}

@Test
func testRefractEtaOneVec2(): Unit {
    let I = Vec2<Float64, Defaultp>(0.0, -1.0)
    let N = Vec2<Float64, Defaultp>(0.0, 1.0)
    let r = refract(I, N, 1.0)
    @Expect(r.x, 0.0)
    @Expect(r.y, -1.0)
}

@Test
func testRefractEtaOneVec3(): Unit {
    let I = Vec3<Float64, Defaultp>(0.0, -1.0, 0.0)
    let N = Vec3<Float64, Defaultp>(0.0, 1.0, 0.0)
    let r = refract(I, N, 1.0)
    @Expect(r.x, 0.0)
    @Expect(r.y, -1.0)
    @Expect(r.z, 0.0)
}

@Test
func testRefractEtaOneVec4(): Unit {
    let I = Vec4<Float64, Defaultp>(0.0, -1.0, 0.0, 0.0)
    let N = Vec4<Float64, Defaultp>(0.0, 1.0, 0.0, 0.0)
    let r = refract(I, N, 1.0)
    @Expect(r.x, 0.0)
    @Expect(r.y, -1.0)
    @Expect(r.z, 0.0)
    @Expect(r.w, 0.0)
}

@Test
func testRefractTotalInternalReflectionVec2(): Unit {
    let I = Vec2<Float64, Defaultp>(1.0, 0.0)
    let N = Vec2<Float64, Defaultp>(0.0, 1.0)
    let r = refract(I, N, 2.0)
    @Expect(r.x, 0.0)
    @Expect(r.y, 0.0)
}

@Test
func testRefractTotalInternalReflectionVec4(): Unit {
    let I = Vec4<Float64, Defaultp>(1.0, 0.0, 0.0, 0.0)
    let N = Vec4<Float64, Defaultp>(0.0, 1.0, 0.0, 0.0)
    let r = refract(I, N, 2.0)
    @Expect(r.x, 0.0)
    @Expect(r.y, 0.0)
    @Expect(r.z, 0.0)
    @Expect(r.w, 0.0)
}
