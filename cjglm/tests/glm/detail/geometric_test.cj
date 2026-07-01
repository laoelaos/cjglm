package glm.detail

import std.unittest.*
import std.unittest.testmacro.*
import std.math.{ sqrt, isNaN }

@Test
func testDotVec1(): Unit {
    let x = Vec1<Float64, Defaultp>(1.0)
    let y = Vec1<Float64, Defaultp>(2.0)
    @Expect(dot(x, y), 2.0)
}

@Test
func testDotVec2(): Unit {
    let x = Vec2<Float64, Defaultp>(1.0, 2.0)
    let y = Vec2<Float64, Defaultp>(3.0, 4.0)
    @Expect(dot(x, y), 11.0)
}

@Test
func testDotVec3(): Unit {
    let x = Vec3<Float64, Defaultp>(1.0, 2.0, 3.0)
    let y = Vec3<Float64, Defaultp>(4.0, 5.0, 6.0)
    @Expect(dot(x, y), 32.0)
}

@Test
func testDotVec4(): Unit {
    let x = Vec4<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let y = Vec4<Float64, Defaultp>(5.0, 6.0, 7.0, 8.0)
    @Expect(dot(x, y), 70.0)
}

@Test
func testCross(): Unit {
    let x = Vec3<Float64, Defaultp>(1.0, 0.0, 0.0)
    let y = Vec3<Float64, Defaultp>(0.0, 1.0, 0.0)
    let r = cross(x, y)
    @Expect(r.x, 0.0)
    @Expect(r.y, 0.0)
    @Expect(r.z, 1.0)
}

@Test
func testNormalizeVec2(): Unit {
    let v = Vec2<Float64, Defaultp>(3.0, 4.0)
    let n = normalize(v)
    @Expect(n.x, 0.6)
    @Expect(n.y, 0.8)
}

@Test
func testNormalizeVec3(): Unit {
    let len = sqrt(14.0)
    let v = Vec3<Float64, Defaultp>(1.0, 2.0, 3.0)
    let n = normalize(v)
    @Expect(n.x, 1.0 / len)
    @Expect(n.y, 2.0 / len)
    @Expect(n.z, 3.0 / len)
}

@Test
func testNormalizeVec4(): Unit {
    let len = sqrt(30.0)
    let v = Vec4<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let n = normalize(v)
    @Expect(n.x, 1.0 / len)
    @Expect(n.y, 2.0 / len)
    @Expect(n.z, 3.0 / len)
    @Expect(n.w, 4.0 / len)
}

@Test
func testLengthVec2(): Unit {
    let v = Vec2<Float64, Defaultp>(3.0, 4.0)
    @Expect(length(v), 5.0)
}

@Test
func testLengthVec3(): Unit {
    let v = Vec3<Float64, Defaultp>(1.0, 2.0, 3.0)
    @Expect(length(v), sqrt(14.0))
}

@Test
func testLengthVec4(): Unit {
    let v = Vec4<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    @Expect(length(v), sqrt(30.0))
}

@Test
func testDistanceVec2(): Unit {
    let p0 = Vec2<Float64, Defaultp>(0.0, 0.0)
    let p1 = Vec2<Float64, Defaultp>(3.0, 4.0)
    @Expect(distance(p0, p1), 5.0)
}

@Test
func testDistanceVec3(): Unit {
    let p0 = Vec3<Float64, Defaultp>(0.0, 0.0, 0.0)
    let p1 = Vec3<Float64, Defaultp>(1.0, 2.0, 3.0)
    @Expect(distance(p0, p1), sqrt(14.0))
}

@Test
func testDistanceVec4(): Unit {
    let p0 = Vec4<Float64, Defaultp>(0.0, 0.0, 0.0, 0.0)
    let p1 = Vec4<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    @Expect(distance(p0, p1), sqrt(30.0))
}

@Test
func testReflectVec2(): Unit {
    let I = Vec2<Float64, Defaultp>(1.0, -1.0)
    let N = Vec2<Float64, Defaultp>(0.0, 1.0)
    let r = reflect(I, N)
    @Expect(r.x, 1.0)
    @Expect(r.y, 1.0)
}

@Test
func testReflectVec3(): Unit {
    let I = Vec3<Float64, Defaultp>(1.0, -1.0, 0.0)
    let N = Vec3<Float64, Defaultp>(0.0, 1.0, 0.0)
    let r = reflect(I, N)
    @Expect(r.x, 1.0)
    @Expect(r.y, 1.0)
    @Expect(r.z, 0.0)
}

@Test
func testReflectVec4(): Unit {
    let I = Vec4<Float64, Defaultp>(1.0, -1.0, 0.0, 0.0)
    let N = Vec4<Float64, Defaultp>(0.0, 1.0, 0.0, 0.0)
    let r = reflect(I, N)
    @Expect(r.x, 1.0)
    @Expect(r.y, 1.0)
    @Expect(r.z, 0.0)
    @Expect(r.w, 0.0)
}

@Test
func testFaceforwardVec2(): Unit {
    let N = Vec2<Float64, Defaultp>(1.0, 0.0)
    let I = Vec2<Float64, Defaultp>(0.0, 1.0)
    let Nref = Vec2<Float64, Defaultp>(0.0, 1.0)
    let r = faceforward(N, I, Nref)
    @Expect(r.x, 1.0)
    @Expect(r.y, 0.0)
}

@Test
func testFaceforwardVec3(): Unit {
    let N = Vec3<Float64, Defaultp>(1.0, 0.0, 0.0)
    let I = Vec3<Float64, Defaultp>(0.0, 1.0, 0.0)
    let Nref = Vec3<Float64, Defaultp>(0.0, 1.0, 0.0)
    let r = faceforward(N, I, Nref)
    @Expect(r.x, -1.0)
    @Expect(r.y, 0.0)
    @Expect(r.z, 0.0)
}

@Test
func testNormalizeVec1(): Unit {
    let v = Vec1<Float64, Defaultp>(4.0)
    let n = normalize(v)
    @Expect(n.x, 1.0)
}

@Test
func testNormalizeVec1Zero(): Unit {
    let v = Vec1<Float64, Defaultp>(0.0)
    let n = normalize(v)
    @Expect(isNaN(n.x))
}

@Test
func testNormalizeVec2Zero(): Unit {
    let v = Vec2<Float64, Defaultp>(0.0, 0.0)
    let n = normalize(v)
    @Expect(n.x, 0.0)
    @Expect(n.y, 0.0)
}

@Test
func testNormalizeVec3Zero(): Unit {
    let v = Vec3<Float64, Defaultp>(0.0, 0.0, 0.0)
    let n = normalize(v)
    @Expect(n.x, 0.0)
    @Expect(n.y, 0.0)
    @Expect(n.z, 0.0)
}

@Test
func testNormalizeVec4Zero(): Unit {
    let v = Vec4<Float64, Defaultp>(0.0, 0.0, 0.0, 0.0)
    let n = normalize(v)
    @Expect(n.x, 0.0)
    @Expect(n.y, 0.0)
    @Expect(n.z, 0.0)
    @Expect(n.w, 0.0)
}

@Test
func testFaceforwardVec4(): Unit {
    let N = Vec4<Float64, Defaultp>(1.0, 0.0, 0.0, 0.0)
    let I = Vec4<Float64, Defaultp>(0.0, 1.0, 0.0, 0.0)
    let Nref = Vec4<Float64, Defaultp>(0.0, 1.0, 0.0, 0.0)
    let r = faceforward(N, I, Nref)
    @Expect(r.x, 1.0)
    @Expect(r.y, 0.0)
    @Expect(r.z, 0.0)
    @Expect(r.w, 0.0)
}

@Test
func testLengthZeroVec2(): Unit {
    let v = Vec2<Float64, Defaultp>(0.0, 0.0)
    @Expect(length(v), 0.0)
}

@Test
func testLengthZeroVec3(): Unit {
    let v = Vec3<Float64, Defaultp>(0.0, 0.0, 0.0)
    @Expect(length(v), 0.0)
}

@Test
func testLengthZeroVec4(): Unit {
    let v = Vec4<Float64, Defaultp>(0.0, 0.0, 0.0, 0.0)
    @Expect(length(v), 0.0)
}

@Test
func testDistanceSamePointVec2(): Unit {
    let p = Vec2<Float64, Defaultp>(1.0, 2.0)
    @Expect(distance(p, p), 0.0)
}

@Test
func testDistanceSamePointVec3(): Unit {
    let p = Vec3<Float64, Defaultp>(1.0, 2.0, 3.0)
    @Expect(distance(p, p), 0.0)
}

@Test
func testDistanceSamePointVec4(): Unit {
    let p = Vec4<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    @Expect(distance(p, p), 0.0)
}

@Test
func testCrossParallel(): Unit {
    let x = Vec3<Float64, Defaultp>(2.0, 0.0, 0.0)
    let y = Vec3<Float64, Defaultp>(5.0, 0.0, 0.0)
    let r = cross(x, y)
    @Expect(r.x, 0.0)
    @Expect(r.y, 0.0)
    @Expect(r.z, 0.0)
}

@Test
func testReflectPerpendicularVec2(): Unit {
    let I = Vec2<Float64, Defaultp>(0.0, -1.0)
    let N = Vec2<Float64, Defaultp>(0.0, 1.0)
    let r = reflect(I, N)
    @Expect(r.x, 0.0)
    @Expect(r.y, 1.0)
}

@Test
func testReflectPerpendicularVec3(): Unit {
    let I = Vec3<Float64, Defaultp>(0.0, -1.0, 0.0)
    let N = Vec3<Float64, Defaultp>(0.0, 1.0, 0.0)
    let r = reflect(I, N)
    @Expect(r.x, 0.0)
    @Expect(r.y, 1.0)
    @Expect(r.z, 0.0)
}

@Test
func testReflectPerpendicularVec4(): Unit {
    let I = Vec4<Float64, Defaultp>(0.0, -1.0, 0.0, 0.0)
    let N = Vec4<Float64, Defaultp>(0.0, 1.0, 0.0, 0.0)
    let r = reflect(I, N)
    @Expect(r.x, 0.0)
    @Expect(r.y, 1.0)
    @Expect(r.z, 0.0)
    @Expect(r.w, 0.0)
}
