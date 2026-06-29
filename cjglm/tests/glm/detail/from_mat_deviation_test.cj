package glm.detail

import std.unittest.*
import std.unittest.testmacro.*

@Test
func testFromMatDeviation6aMat4x2FullContract(): Unit {
    let src = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let m = Mat4x4<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 0)
    @Expect(m.c0.w, 0)
    @Expect(m.c1.x, 3)
    @Expect(m.c1.y, 4)
    @Expect(m.c1.z, 0)
    @Expect(m.c1.w, 0)
    @Expect(m.c2.x, 0)
    @Expect(m.c2.y, 0)
    @Expect(m.c2.z, 1)
    @Expect(m.c2.w, 0)
    @Expect(m.c3.x, 0)
    @Expect(m.c3.y, 0)
    @Expect(m.c3.z, 0)
    @Expect(m.c3.w, 1)
}

@Test
func testFromMatDeviation6aMat4x2OneIsZero(): Unit {
    let src = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let m = Mat4x4<Int64, Defaultp>.fromMat(src, Int64(0))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 0)
    @Expect(m.c0.w, 0)
    @Expect(m.c1.x, 3)
    @Expect(m.c1.y, 4)
    @Expect(m.c1.z, 0)
    @Expect(m.c1.w, 0)
    @Expect(m.c2.x, 0)
    @Expect(m.c2.y, 0)
    @Expect(m.c2.z, 0)
    @Expect(m.c2.w, 0)
    @Expect(m.c3.x, 0)
    @Expect(m.c3.y, 0)
    @Expect(m.c3.z, 0)
    @Expect(m.c3.w, 0)
}

@Test
func testFromMatDeviation6aMat4x2OneIsNegative(): Unit {
    let src = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let m = Mat4x4<Int64, Defaultp>.fromMat(src, Int64(-1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 0)
    @Expect(m.c0.w, 0)
    @Expect(m.c1.x, 3)
    @Expect(m.c1.y, 4)
    @Expect(m.c1.z, 0)
    @Expect(m.c1.w, 0)
    @Expect(m.c2.x, 0)
    @Expect(m.c2.y, 0)
    @Expect(m.c2.z, -1)
    @Expect(m.c2.w, 0)
    @Expect(m.c3.x, 0)
    @Expect(m.c3.y, 0)
    @Expect(m.c3.z, 0)
    @Expect(m.c3.w, -1)
}

@Test
func testFromMatDeviation6aMat4x2AllZeroSource(): Unit {
    let src = Mat4x2<Int64, Defaultp>(0, 0, 0, 0, 0, 0, 0, 0)
    let m = Mat4x4<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 0)
    @Expect(m.c0.y, 0)
    @Expect(m.c0.z, 0)
    @Expect(m.c0.w, 0)
    @Expect(m.c1.x, 0)
    @Expect(m.c1.y, 0)
    @Expect(m.c1.z, 0)
    @Expect(m.c1.w, 0)
    @Expect(m.c2.x, 0)
    @Expect(m.c2.y, 0)
    @Expect(m.c2.z, 1)
    @Expect(m.c2.w, 0)
    @Expect(m.c3.x, 0)
    @Expect(m.c3.y, 0)
    @Expect(m.c3.z, 0)
    @Expect(m.c3.w, 1)
}

@Test
func testFromMatDeviation6bMat4x2FullContract(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let m = Mat4x4<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(0))
    @Expect(m.c0.w, Float64(0))
    @Expect(m.c1.x, Float64(3))
    @Expect(m.c1.y, Float64(4))
    @Expect(m.c1.z, Float64(0))
    @Expect(m.c1.w, Float64(0))
    @Expect(m.c2.x, Float64(0))
    @Expect(m.c2.y, Float64(0))
    @Expect(m.c2.z, Float64(1))
    @Expect(m.c2.w, Float64(0))
    @Expect(m.c3.x, Float64(0))
    @Expect(m.c3.y, Float64(0))
    @Expect(m.c3.z, Float64(0))
    @Expect(m.c3.w, Float64(1))
}

@Test
func testFromMatDeviation6bMat4x2OneIsZero(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let m = Mat4x4<Float64, Defaultp>.fromMat(conv, src, Float64(0))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(0))
    @Expect(m.c0.w, Float64(0))
    @Expect(m.c1.x, Float64(3))
    @Expect(m.c1.y, Float64(4))
    @Expect(m.c1.z, Float64(0))
    @Expect(m.c1.w, Float64(0))
    @Expect(m.c2.x, Float64(0))
    @Expect(m.c2.y, Float64(0))
    @Expect(m.c2.z, Float64(0))
    @Expect(m.c2.w, Float64(0))
    @Expect(m.c3.x, Float64(0))
    @Expect(m.c3.y, Float64(0))
    @Expect(m.c3.z, Float64(0))
    @Expect(m.c3.w, Float64(0))
}

@Test
func testFromMatDeviation6bMat4x2AllZeroSource(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat4x2<Int64, Defaultp>(0, 0, 0, 0, 0, 0, 0, 0)
    let m = Mat4x4<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(0))
    @Expect(m.c0.y, Float64(0))
    @Expect(m.c0.z, Float64(0))
    @Expect(m.c0.w, Float64(0))
    @Expect(m.c1.x, Float64(0))
    @Expect(m.c1.y, Float64(0))
    @Expect(m.c1.z, Float64(0))
    @Expect(m.c1.w, Float64(0))
    @Expect(m.c2.x, Float64(0))
    @Expect(m.c2.y, Float64(0))
    @Expect(m.c2.z, Float64(1))
    @Expect(m.c2.w, Float64(0))
    @Expect(m.c3.x, Float64(0))
    @Expect(m.c3.y, Float64(0))
    @Expect(m.c3.z, Float64(0))
    @Expect(m.c3.w, Float64(1))
}
