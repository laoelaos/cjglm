package glm.detail

import std.unittest.*
import std.unittest.testmacro.*

// === type_mat2x2.cj: 16 pure-contraction directions (Mat2x3..Mat4x4 → Mat2x2) ===

@Test
func testMat2x2From6aMat2x3Contract(): Unit {
    let src = Mat2x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let m = Mat2x2<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c1.x, 4)
    @Expect(m.c1.y, 5)
}

@Test
func testMat2x2From6aMat2x4Contract(): Unit {
    let src = Mat2x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let m = Mat2x2<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c1.x, 5)
    @Expect(m.c1.y, 6)
}

@Test
func testMat2x2From6aMat3x2Contract(): Unit {
    let src = Mat3x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let m = Mat2x2<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c1.x, 3)
    @Expect(m.c1.y, 4)
}

@Test
func testMat2x2From6aMat3x3Contract(): Unit {
    let src = Mat3x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9)
    let m = Mat2x2<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c1.x, 4)
    @Expect(m.c1.y, 5)
}

@Test
func testMat2x2From6aMat3x4Contract(): Unit {
    let src = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let m = Mat2x2<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c1.x, 5)
    @Expect(m.c1.y, 6)
}

@Test
func testMat2x2From6aMat4x2Contract(): Unit {
    let src = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let m = Mat2x2<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c1.x, 3)
    @Expect(m.c1.y, 4)
}

@Test
func testMat2x2From6aMat4x3Contract(): Unit {
    let src = Mat4x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let m = Mat2x2<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c1.x, 4)
    @Expect(m.c1.y, 5)
}

@Test
func testMat2x2From6aMat4x4Contract(): Unit {
    let src = Mat4x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    let m = Mat2x2<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c1.x, 5)
    @Expect(m.c1.y, 6)
}

@Test
func testMat2x2From6bMat2x3Contract(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat2x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let m = Mat2x2<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c1.x, Float64(4))
    @Expect(m.c1.y, Float64(5))
}

@Test
func testMat2x2From6bMat2x4Contract(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat2x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let m = Mat2x2<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c1.x, Float64(5))
    @Expect(m.c1.y, Float64(6))
}

@Test
func testMat2x2From6bMat3x2Contract(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat3x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let m = Mat2x2<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c1.x, Float64(3))
    @Expect(m.c1.y, Float64(4))
}

@Test
func testMat2x2From6bMat3x3Contract(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat3x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9)
    let m = Mat2x2<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c1.x, Float64(4))
    @Expect(m.c1.y, Float64(5))
}

@Test
func testMat2x2From6bMat3x4Contract(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let m = Mat2x2<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c1.x, Float64(5))
    @Expect(m.c1.y, Float64(6))
}

@Test
func testMat2x2From6bMat4x2Contract(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let m = Mat2x2<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c1.x, Float64(3))
    @Expect(m.c1.y, Float64(4))
}

@Test
func testMat2x2From6bMat4x3Contract(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat4x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let m = Mat2x2<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c1.x, Float64(4))
    @Expect(m.c1.y, Float64(5))
}

@Test
func testMat2x2From6bMat4x4Contract(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat4x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    let m = Mat2x2<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c1.x, Float64(5))
    @Expect(m.c1.y, Float64(6))
}

// === type_mat2x3.cj: 10 pure-contraction directions (Mat2x4, Mat3x3, Mat3x4, Mat4x3, Mat4x4 → Mat2x3) ===

@Test
func testMat2x3From6aMat2x4Contract(): Unit {
    let src = Mat2x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let m = Mat2x3<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 3)
    @Expect(m.c1.x, 5)
    @Expect(m.c1.y, 6)
    @Expect(m.c1.z, 7)
}

@Test
func testMat2x3From6aMat3x3Contract(): Unit {
    let src = Mat3x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9)
    let m = Mat2x3<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 3)
    @Expect(m.c1.x, 4)
    @Expect(m.c1.y, 5)
    @Expect(m.c1.z, 6)
}

@Test
func testMat2x3From6aMat3x4Contract(): Unit {
    let src = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let m = Mat2x3<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 3)
    @Expect(m.c1.x, 5)
    @Expect(m.c1.y, 6)
    @Expect(m.c1.z, 7)
}

@Test
func testMat2x3From6aMat4x3Contract(): Unit {
    let src = Mat4x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let m = Mat2x3<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 3)
    @Expect(m.c1.x, 4)
    @Expect(m.c1.y, 5)
    @Expect(m.c1.z, 6)
}

@Test
func testMat2x3From6aMat4x4Contract(): Unit {
    let src = Mat4x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    let m = Mat2x3<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 3)
    @Expect(m.c1.x, 5)
    @Expect(m.c1.y, 6)
    @Expect(m.c1.z, 7)
}

@Test
func testMat2x3From6bMat2x4Contract(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat2x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let m = Mat2x3<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(3))
    @Expect(m.c1.x, Float64(5))
    @Expect(m.c1.y, Float64(6))
    @Expect(m.c1.z, Float64(7))
}

@Test
func testMat2x3From6bMat3x3Contract(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat3x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9)
    let m = Mat2x3<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(3))
    @Expect(m.c1.x, Float64(4))
    @Expect(m.c1.y, Float64(5))
    @Expect(m.c1.z, Float64(6))
}

@Test
func testMat2x3From6bMat3x4Contract(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let m = Mat2x3<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(3))
    @Expect(m.c1.x, Float64(5))
    @Expect(m.c1.y, Float64(6))
    @Expect(m.c1.z, Float64(7))
}

@Test
func testMat2x3From6bMat4x3Contract(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat4x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let m = Mat2x3<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(3))
    @Expect(m.c1.x, Float64(4))
    @Expect(m.c1.y, Float64(5))
    @Expect(m.c1.z, Float64(6))
}

@Test
func testMat2x3From6bMat4x4Contract(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat4x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    let m = Mat2x3<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(3))
    @Expect(m.c1.x, Float64(5))
    @Expect(m.c1.y, Float64(6))
    @Expect(m.c1.z, Float64(7))
}

// === type_mat2x4.cj: 4 pure-contraction directions (Mat3x4, Mat4x4 → Mat2x4) ===

@Test
func testMat2x4From6aMat3x4Contract(): Unit {
    let src = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let m = Mat2x4<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 3)
    @Expect(m.c0.w, 4)
    @Expect(m.c1.x, 5)
    @Expect(m.c1.y, 6)
    @Expect(m.c1.z, 7)
    @Expect(m.c1.w, 8)
}

@Test
func testMat2x4From6aMat4x4Contract(): Unit {
    let src = Mat4x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    let m = Mat2x4<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 3)
    @Expect(m.c0.w, 4)
    @Expect(m.c1.x, 5)
    @Expect(m.c1.y, 6)
    @Expect(m.c1.z, 7)
    @Expect(m.c1.w, 8)
}

@Test
func testMat2x4From6bMat3x4Contract(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let m = Mat2x4<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(3))
    @Expect(m.c0.w, Float64(4))
    @Expect(m.c1.x, Float64(5))
    @Expect(m.c1.y, Float64(6))
    @Expect(m.c1.z, Float64(7))
    @Expect(m.c1.w, Float64(8))
}

@Test
func testMat2x4From6bMat4x4Contract(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat4x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    let m = Mat2x4<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(3))
    @Expect(m.c0.w, Float64(4))
    @Expect(m.c1.x, Float64(5))
    @Expect(m.c1.y, Float64(6))
    @Expect(m.c1.z, Float64(7))
    @Expect(m.c1.w, Float64(8))
}

// === type_mat3x2.cj: 10 pure-contraction directions (Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4 → Mat3x2) ===

@Test
func testMat3x2From6aMat3x3Contract(): Unit {
    let src = Mat3x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9)
    let m = Mat3x2<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c1.x, 4)
    @Expect(m.c1.y, 5)
    @Expect(m.c2.x, 7)
    @Expect(m.c2.y, 8)
}

@Test
func testMat3x2From6aMat3x4Contract(): Unit {
    let src = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let m = Mat3x2<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c1.x, 5)
    @Expect(m.c1.y, 6)
    @Expect(m.c2.x, 9)
    @Expect(m.c2.y, 10)
}

@Test
func testMat3x2From6aMat4x2Contract(): Unit {
    let src = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let m = Mat3x2<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c1.x, 3)
    @Expect(m.c1.y, 4)
    @Expect(m.c2.x, 5)
    @Expect(m.c2.y, 6)
}

@Test
func testMat3x2From6aMat4x3Contract(): Unit {
    let src = Mat4x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let m = Mat3x2<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c1.x, 4)
    @Expect(m.c1.y, 5)
    @Expect(m.c2.x, 7)
    @Expect(m.c2.y, 8)
}

@Test
func testMat3x2From6aMat4x4Contract(): Unit {
    let src = Mat4x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    let m = Mat3x2<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c1.x, 5)
    @Expect(m.c1.y, 6)
    @Expect(m.c2.x, 9)
    @Expect(m.c2.y, 10)
}

@Test
func testMat3x2From6bMat3x3Contract(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat3x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9)
    let m = Mat3x2<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c1.x, Float64(4))
    @Expect(m.c1.y, Float64(5))
    @Expect(m.c2.x, Float64(7))
    @Expect(m.c2.y, Float64(8))
}

@Test
func testMat3x2From6bMat3x4Contract(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let m = Mat3x2<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c1.x, Float64(5))
    @Expect(m.c1.y, Float64(6))
    @Expect(m.c2.x, Float64(9))
    @Expect(m.c2.y, Float64(10))
}

@Test
func testMat3x2From6bMat4x2Contract(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let m = Mat3x2<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c1.x, Float64(3))
    @Expect(m.c1.y, Float64(4))
    @Expect(m.c2.x, Float64(5))
    @Expect(m.c2.y, Float64(6))
}

@Test
func testMat3x2From6bMat4x3Contract(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat4x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let m = Mat3x2<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c1.x, Float64(4))
    @Expect(m.c1.y, Float64(5))
    @Expect(m.c2.x, Float64(7))
    @Expect(m.c2.y, Float64(8))
}

@Test
func testMat3x2From6bMat4x4Contract(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat4x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    let m = Mat3x2<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c1.x, Float64(5))
    @Expect(m.c1.y, Float64(6))
    @Expect(m.c2.x, Float64(9))
    @Expect(m.c2.y, Float64(10))
}

// === type_mat3x3.cj: 6 pure-contraction directions (Mat3x4, Mat4x3, Mat4x4 → Mat3x3) ===

@Test
func testMat3x3From6aMat3x4Contract(): Unit {
    let src = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let m = Mat3x3<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 3)
    @Expect(m.c1.x, 5)
    @Expect(m.c1.y, 6)
    @Expect(m.c1.z, 7)
    @Expect(m.c2.x, 9)
    @Expect(m.c2.y, 10)
    @Expect(m.c2.z, 11)
}

@Test
func testMat3x3From6aMat4x3Contract(): Unit {
    let src = Mat4x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let m = Mat3x3<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 3)
    @Expect(m.c1.x, 4)
    @Expect(m.c1.y, 5)
    @Expect(m.c1.z, 6)
    @Expect(m.c2.x, 7)
    @Expect(m.c2.y, 8)
    @Expect(m.c2.z, 9)
}

@Test
func testMat3x3From6aMat4x4Contract(): Unit {
    let src = Mat4x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    let m = Mat3x3<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 3)
    @Expect(m.c1.x, 5)
    @Expect(m.c1.y, 6)
    @Expect(m.c1.z, 7)
    @Expect(m.c2.x, 9)
    @Expect(m.c2.y, 10)
    @Expect(m.c2.z, 11)
}

@Test
func testMat3x3From6bMat3x4Contract(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let m = Mat3x3<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(3))
    @Expect(m.c1.x, Float64(5))
    @Expect(m.c1.y, Float64(6))
    @Expect(m.c1.z, Float64(7))
    @Expect(m.c2.x, Float64(9))
    @Expect(m.c2.y, Float64(10))
    @Expect(m.c2.z, Float64(11))
}

@Test
func testMat3x3From6bMat4x3Contract(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat4x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let m = Mat3x3<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(3))
    @Expect(m.c1.x, Float64(4))
    @Expect(m.c1.y, Float64(5))
    @Expect(m.c1.z, Float64(6))
    @Expect(m.c2.x, Float64(7))
    @Expect(m.c2.y, Float64(8))
    @Expect(m.c2.z, Float64(9))
}

@Test
func testMat3x3From6bMat4x4Contract(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat4x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    let m = Mat3x3<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(3))
    @Expect(m.c1.x, Float64(5))
    @Expect(m.c1.y, Float64(6))
    @Expect(m.c1.z, Float64(7))
    @Expect(m.c2.x, Float64(9))
    @Expect(m.c2.y, Float64(10))
    @Expect(m.c2.z, Float64(11))
}

// === type_mat3x4.cj: 2 pure-contraction directions (Mat4x4 → Mat3x4) ===

@Test
func testMat3x4From6aMat4x4Contract(): Unit {
    let src = Mat4x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    let m = Mat3x4<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 3)
    @Expect(m.c0.w, 4)
    @Expect(m.c1.x, 5)
    @Expect(m.c1.y, 6)
    @Expect(m.c1.z, 7)
    @Expect(m.c1.w, 8)
    @Expect(m.c2.x, 9)
    @Expect(m.c2.y, 10)
    @Expect(m.c2.z, 11)
    @Expect(m.c2.w, 12)
}

@Test
func testMat3x4From6bMat4x4Contract(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat4x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    let m = Mat3x4<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(3))
    @Expect(m.c0.w, Float64(4))
    @Expect(m.c1.x, Float64(5))
    @Expect(m.c1.y, Float64(6))
    @Expect(m.c1.z, Float64(7))
    @Expect(m.c1.w, Float64(8))
    @Expect(m.c2.x, Float64(9))
    @Expect(m.c2.y, Float64(10))
    @Expect(m.c2.z, Float64(11))
    @Expect(m.c2.w, Float64(12))
}

// === type_mat4x2.cj: 4 pure-contraction directions (Mat4x3, Mat4x4 → Mat4x2) ===

@Test
func testMat4x2From6aMat4x3Contract(): Unit {
    let src = Mat4x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let m = Mat4x2<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c1.x, 4)
    @Expect(m.c1.y, 5)
    @Expect(m.c2.x, 7)
    @Expect(m.c2.y, 8)
    @Expect(m.c3.x, 10)
    @Expect(m.c3.y, 11)
}

@Test
func testMat4x2From6aMat4x4Contract(): Unit {
    let src = Mat4x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    let m = Mat4x2<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c1.x, 5)
    @Expect(m.c1.y, 6)
    @Expect(m.c2.x, 9)
    @Expect(m.c2.y, 10)
    @Expect(m.c3.x, 13)
    @Expect(m.c3.y, 14)
}

@Test
func testMat4x2From6bMat4x3Contract(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat4x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let m = Mat4x2<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c1.x, Float64(4))
    @Expect(m.c1.y, Float64(5))
    @Expect(m.c2.x, Float64(7))
    @Expect(m.c2.y, Float64(8))
    @Expect(m.c3.x, Float64(10))
    @Expect(m.c3.y, Float64(11))
}

@Test
func testMat4x2From6bMat4x4Contract(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat4x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    let m = Mat4x2<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c1.x, Float64(5))
    @Expect(m.c1.y, Float64(6))
    @Expect(m.c2.x, Float64(9))
    @Expect(m.c2.y, Float64(10))
    @Expect(m.c3.x, Float64(13))
    @Expect(m.c3.y, Float64(14))
}

// === type_mat4x3.cj: 2 pure-contraction directions (Mat4x4 → Mat4x3) ===

@Test
func testMat4x3From6aMat4x4Contract(): Unit {
    let src = Mat4x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    let m = Mat4x3<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 3)
    @Expect(m.c1.x, 5)
    @Expect(m.c1.y, 6)
    @Expect(m.c1.z, 7)
    @Expect(m.c2.x, 9)
    @Expect(m.c2.y, 10)
    @Expect(m.c2.z, 11)
    @Expect(m.c3.x, 13)
    @Expect(m.c3.y, 14)
    @Expect(m.c3.z, 15)
}

@Test
func testMat4x3From6bMat4x4Contract(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat4x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    let m = Mat4x3<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(3))
    @Expect(m.c1.x, Float64(5))
    @Expect(m.c1.y, Float64(6))
    @Expect(m.c1.z, Float64(7))
    @Expect(m.c2.x, Float64(9))
    @Expect(m.c2.y, Float64(10))
    @Expect(m.c2.z, Float64(11))
    @Expect(m.c3.x, Float64(13))
    @Expect(m.c3.y, Float64(14))
    @Expect(m.c3.z, Float64(15))
}
