package glm.detail

import std.unittest.*
import std.unittest.testmacro.*

@Test
func testMat2x3ScalarInit(): Unit {
    let m = Mat2x3<Int64, Defaultp>(5)
    @Expect(m.c0.x, 5)
    @Expect(m.c0.y, 5)
    @Expect(m.c0.z, 5)
    @Expect(m.c1.x, 5)
    @Expect(m.c1.y, 5)
    @Expect(m.c1.z, 5)
}

@Test
func testMat2x3ConstInitElementwise(): Unit {
    let m = Mat2x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 3)
    @Expect(m.c1.x, 4)
    @Expect(m.c1.y, 5)
    @Expect(m.c1.z, 6)
}

@Test
func testMat2x3ConstInitColumn(): Unit {
    let c0 = Vec3<Int64, Defaultp>(1, 2, 3)
    let c1 = Vec3<Int64, Defaultp>(4, 5, 6)
    let m = Mat2x3<Int64, Defaultp>(c0, c1)
    @Expect(m.c0, c0)
    @Expect(m.c1, c1)
}

@Test
func testMat2x3Length(): Unit {
    @Expect(Mat2x3<Int64, Defaultp>.length(), 2)
}

@Test
func testMat2x3IndexAccess(): Unit {
    let m = Mat2x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    @Expect(m[Int64(0)].x, 1)
    @Expect(m[Int64(0)].y, 2)
    @Expect(m[Int64(0)].z, 3)
    @Expect(m[Int64(1)].x, 4)
    @Expect(m[Int64(1)].y, 5)
    @Expect(m[Int64(1)].z, 6)
}

@Test
func testMat2x3IndexMutate(): Unit {
    var m = Mat2x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let newCol0 = Vec3<Int64, Defaultp>(10, 20, 30)
    m[Int64(0)] = newCol0
    @Expect(m[Int64(0)].x, 10)
    @Expect(m[Int64(0)].y, 20)
    @Expect(m[Int64(0)].z, 30)
}

@Test
func testMat2x3ColAccess(): Unit {
    let m = Mat2x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    @Expect(m.col(Int64(0)).x, 1)
    @Expect(m.col(Int64(0)).y, 2)
    @Expect(m.col(Int64(0)).z, 3)
    @Expect(m.col(Int64(1)).x, 4)
    @Expect(m.col(Int64(1)).y, 5)
    @Expect(m.col(Int64(1)).z, 6)
}

@Test
func testMat2x3ColOutOfBounds(): Unit {
    let m = Mat2x3<Int64, Defaultp>(5)
    try {
        let _ = m.col(Int64(2))
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}

@Test
func testMat2x3ColNegative(): Unit {
    let m = Mat2x3<Int64, Defaultp>(5)
    try {
        let _ = m.col(Int64(-1))
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}

@Test
func testMat2x3IndexOutOfBounds(): Unit {
    let m = Mat2x3<Int64, Defaultp>(5)
    try {
        let _ = m[Int64(2)]
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}

@Test
func testMat2x3NegativeIndex(): Unit {
    let m = Mat2x3<Int64, Defaultp>(5)
    try {
        let _ = m[Int64(-1)]
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}

@Test
func testMat2x3MutateThenRead(): Unit {
    var m = Mat2x3<Int64, Defaultp>(5)
    let newCol1 = Vec3<Int64, Defaultp>(7, 8, 9)
    m[Int64(1)] = newCol1
    @Expect(m.col(Int64(1)).x, 7)
    @Expect(m.col(Int64(1)).y, 8)
    @Expect(m.col(Int64(1)).z, 9)
}

@Test
func testMat2x3UnaryNegate(): Unit {
    let m = Mat2x3<Int64, Defaultp>(1, -2, 3, -4, 5, -6)
    let n = -m
    @Expect(n.c0.x, -1)
    @Expect(n.c0.y, 2)
    @Expect(n.c0.z, -3)
    @Expect(n.c1.x, 4)
    @Expect(n.c1.y, -5)
    @Expect(n.c1.z, 6)
}

@Test
func testMat2x3ScalarAdd(): Unit {
    let m = Mat2x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let r = m + Int64(10)
    @Expect(r.c0.x, 11)
    @Expect(r.c0.y, 12)
    @Expect(r.c0.z, 13)
    @Expect(r.c1.x, 14)
    @Expect(r.c1.y, 15)
    @Expect(r.c1.z, 16)
}

@Test
func testMat2x3ScalarSub(): Unit {
    let m = Mat2x3<Int64, Defaultp>(10, 20, 30, 40, 50, 60)
    let r = m - Int64(5)
    @Expect(r.c0.x, 5)
    @Expect(r.c0.y, 15)
    @Expect(r.c0.z, 25)
    @Expect(r.c1.x, 35)
    @Expect(r.c1.y, 45)
    @Expect(r.c1.z, 55)
}

@Test
func testMat2x3ScalarMul(): Unit {
    let m = Mat2x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let r = m * Int64(3)
    @Expect(r.c0.x, 3)
    @Expect(r.c0.y, 6)
    @Expect(r.c0.z, 9)
    @Expect(r.c1.x, 12)
    @Expect(r.c1.y, 15)
    @Expect(r.c1.z, 18)
}

@Test
func testMat2x3ScalarDiv(): Unit {
    let m = Mat2x3<Int64, Defaultp>(10, 20, 30, 40, 50, 60)
    let r = m / Int64(2)
    @Expect(r.c0.x, 5)
    @Expect(r.c0.y, 10)
    @Expect(r.c0.z, 15)
    @Expect(r.c1.x, 20)
    @Expect(r.c1.y, 25)
    @Expect(r.c1.z, 30)
}

@Test
func testMat2x3MatrixAdd(): Unit {
    let a = Mat2x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let b = Mat2x3<Int64, Defaultp>(7, 8, 9, 10, 11, 12)
    let r = a + b
    @Expect(r.c0.x, 8)
    @Expect(r.c0.y, 10)
    @Expect(r.c0.z, 12)
    @Expect(r.c1.x, 14)
    @Expect(r.c1.y, 16)
    @Expect(r.c1.z, 18)
}

@Test
func testMat2x3MatrixSub(): Unit {
    let a = Mat2x3<Int64, Defaultp>(10, 20, 30, 40, 50, 60)
    let b = Mat2x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let r = a - b
    @Expect(r.c0.x, 9)
    @Expect(r.c0.y, 18)
    @Expect(r.c0.z, 27)
    @Expect(r.c1.x, 36)
    @Expect(r.c1.y, 45)
    @Expect(r.c1.z, 54)
}

@Test
func testMat2x3MulMat2x2(): Unit {
    let a = Mat2x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let b = Mat2x2<Int64, Defaultp>(7, 8, 9, 10)
    let r = a * b
    @Expect(r.c0.x, 1*7 + 4*8)
    @Expect(r.c0.y, 2*7 + 5*8)
    @Expect(r.c0.z, 3*7 + 6*8)
    @Expect(r.c1.x, 1*9 + 4*10)
    @Expect(r.c1.y, 2*9 + 5*10)
    @Expect(r.c1.z, 3*9 + 6*10)
}

@Test
func testMat2x3MulMat3x2(): Unit {
    let a = Mat2x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let b = Mat3x2<Int64, Defaultp>(7, 8, 9, 10, 11, 12)
    let r = a * b
    @Expect(r.c0.x, 1*7 + 4*8)
    @Expect(r.c0.y, 2*7 + 5*8)
    @Expect(r.c0.z, 3*7 + 6*8)
    @Expect(r.c1.x, 1*9 + 4*10)
    @Expect(r.c1.y, 2*9 + 5*10)
    @Expect(r.c1.z, 3*9 + 6*10)
    @Expect(r.c2.x, 1*11 + 4*12)
    @Expect(r.c2.y, 2*11 + 5*12)
    @Expect(r.c2.z, 3*11 + 6*12)
}

@Test
func testMat2x3MulMat4x2(): Unit {
    let a = Mat2x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let b = Mat4x2<Int64, Defaultp>(7, 8, 9, 10, 11, 12, 13, 14)
    let r = a * b
    @Expect(r.c0.x, 1*7 + 4*8)
    @Expect(r.c0.y, 2*7 + 5*8)
    @Expect(r.c0.z, 3*7 + 6*8)
    @Expect(r.c1.x, 1*9 + 4*10)
    @Expect(r.c1.y, 2*9 + 5*10)
    @Expect(r.c1.z, 3*9 + 6*10)
    @Expect(r.c2.x, 1*11 + 4*12)
    @Expect(r.c2.y, 2*11 + 5*12)
    @Expect(r.c2.z, 3*11 + 6*12)
    @Expect(r.c3.x, 1*13 + 4*14)
    @Expect(r.c3.y, 2*13 + 5*14)
    @Expect(r.c3.z, 3*13 + 6*14)
}

@Test
func testMat2x3MulVec2(): Unit {
    let m = Mat2x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let v = Vec2<Int64, Defaultp>(7, 8)
    let r = m * v
    @Expect(r.x, 1*7 + 4*8)
    @Expect(r.y, 2*7 + 5*8)
    @Expect(r.z, 3*7 + 6*8)
}

@Test
func testMat2x3Diagonal(): Unit {
    let d = Mat2x3<Int64, Defaultp>.diagonal(Int64(7))
    @Expect(d.c0.x, 7)
    @Expect(d.c0.y, 0)
    @Expect(d.c0.z, 0)
    @Expect(d.c1.x, 0)
    @Expect(d.c1.y, 7)
    @Expect(d.c1.z, 0)
}

@Test
func testMat2x3Identity(): Unit {
    let id = Mat2x3<Int64, Defaultp>.identity(Int64(1))
    @Expect(id.c0.x, 1)
    @Expect(id.c0.y, 0)
    @Expect(id.c0.z, 0)
    @Expect(id.c1.x, 0)
    @Expect(id.c1.y, 1)
    @Expect(id.c1.z, 0)
}

@Test
func testMat2x3FromParts(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let m = Mat2x3<Float64, Defaultp>.fromParts(conv, Int64(1), Int64(2), Int64(3), Int64(4), Int64(5), Int64(6))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(3))
    @Expect(m.c1.x, Float64(4))
    @Expect(m.c1.y, Float64(5))
    @Expect(m.c1.z, Float64(6))
}

@Test
func testMat2x3FromColumns(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let c0 = Vec3<Int64, Defaultp>(1, 2, 3)
    let c1 = Vec3<Int64, Defaultp>(4, 5, 6)
    let m = Mat2x3<Float64, Defaultp>.fromColumns(conv, c0, c1)
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(3))
    @Expect(m.c1.x, Float64(4))
    @Expect(m.c1.y, Float64(5))
    @Expect(m.c1.z, Float64(6))
}

@Test
func testMat2x3FromMat7(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat2x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let m = Mat2x3<Float64, Defaultp>.fromMat(conv, src)
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(3))
    @Expect(m.c1.x, Float64(4))
    @Expect(m.c1.y, Float64(5))
    @Expect(m.c1.z, Float64(6))
}

@Test
func testMat2x3FromMat6aMat2x2(): Unit {
    let src = Mat2x2<Int64, Defaultp>(1, 2, 3, 4)
    let m = Mat2x3<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 0)
    @Expect(m.c1.x, 3)
    @Expect(m.c1.y, 4)
    @Expect(m.c1.z, 0)
}

@Test
func testMat2x3FromMat6aMat2x4(): Unit {
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
func testMat2x3FromMat6aMat3x2(): Unit {
    let src = Mat3x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let m = Mat2x3<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 0)
    @Expect(m.c1.x, 3)
    @Expect(m.c1.y, 4)
    @Expect(m.c1.z, 0)
}

@Test
func testMat2x3FromMat6aMat3x3(): Unit {
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
func testMat2x3FromMat6aMat3x4(): Unit {
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
func testMat2x3FromMat6aMat4x2(): Unit {
    let src = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let m = Mat2x3<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 0)
    @Expect(m.c1.x, 3)
    @Expect(m.c1.y, 4)
    @Expect(m.c1.z, 0)
}

@Test
func testMat2x3FromMat6aMat4x3(): Unit {
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
func testMat2x3FromMat6aMat4x4(): Unit {
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
func testMat2x3FromMat6bMat2x2(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat2x2<Int64, Defaultp>(1, 2, 3, 4)
    let m = Mat2x3<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(0))
    @Expect(m.c1.x, Float64(3))
    @Expect(m.c1.y, Float64(4))
    @Expect(m.c1.z, Float64(0))
}

@Test
func testMat2x3FromMat6bMat2x4(): Unit {
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
func testMat2x3FromMat6bMat3x2(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat3x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let m = Mat2x3<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(0))
    @Expect(m.c1.x, Float64(3))
    @Expect(m.c1.y, Float64(4))
    @Expect(m.c1.z, Float64(0))
}

@Test
func testMat2x3FromMat6bMat3x3(): Unit {
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
func testMat2x3FromMat6bMat3x4(): Unit {
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
func testMat2x3FromMat6bMat4x2(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let m = Mat2x3<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(0))
    @Expect(m.c1.x, Float64(3))
    @Expect(m.c1.y, Float64(4))
    @Expect(m.c1.z, Float64(0))
}

@Test
func testMat2x3FromMat6bMat4x3(): Unit {
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
func testMat2x3FromMat6bMat4x4(): Unit {
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

@Test
func testMat2x3DiagonalFloat32(): Unit {
    let d = Mat2x3<Float32, Defaultp>.diagonal(Float32(7.5))
    @Expect(d.c0.x, Float32(7.5))
    @Expect(d.c0.y, Float32(0.0))
    @Expect(d.c0.z, Float32(0.0))
    @Expect(d.c1.x, Float32(0.0))
    @Expect(d.c1.y, Float32(7.5))
    @Expect(d.c1.z, Float32(0.0))
}

@Test
func testMat2x3DiagonalFloat64(): Unit {
    let d = Mat2x3<Float64, Defaultp>.diagonal(Float64(7.5))
    @Expect(d.c0.x, Float64(7.5))
    @Expect(d.c0.y, Float64(0.0))
    @Expect(d.c0.z, Float64(0.0))
    @Expect(d.c1.x, Float64(0.0))
    @Expect(d.c1.y, Float64(7.5))
    @Expect(d.c1.z, Float64(0.0))
}

@Test
func testMat2x3ColAccessFloat32(): Unit {
    let m = Mat2x3<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5))
    let c0 = Vec3<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5))
    let c1 = Vec3<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5))
    @Expect(m.col(Int64(0)), c0)
    @Expect(m.col(Int64(1)), c1)
}

@Test
func testMat2x3ColAccessFloat64(): Unit {
    let m = Mat2x3<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5))
    let c0 = Vec3<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5))
    let c1 = Vec3<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5))
    @Expect(m.col(Int64(0)), c0)
    @Expect(m.col(Int64(1)), c1)
}

@Test
func testMat2x3ScalarMulFloat32(): Unit {
    let m = Mat2x3<Float32, Defaultp>(Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0))
    let r = m * Float32(1.5)
    @Expect(r.c0.x, Float32(3.0))
    @Expect(r.c0.y, Float32(3.0))
    @Expect(r.c0.z, Float32(3.0))
    @Expect(r.c1.x, Float32(3.0))
    @Expect(r.c1.y, Float32(3.0))
    @Expect(r.c1.z, Float32(3.0))
}

@Test
func testMat2x3ScalarMulFloat64(): Unit {
    let m = Mat2x3<Float64, Defaultp>(Float64(2.0), Float64(2.0), Float64(2.0), Float64(2.0), Float64(2.0), Float64(2.0))
    let r = m * Float64(1.5)
    @Expect(r.c0.x, Float64(3.0))
    @Expect(r.c0.y, Float64(3.0))
    @Expect(r.c0.z, Float64(3.0))
    @Expect(r.c1.x, Float64(3.0))
    @Expect(r.c1.y, Float64(3.0))
    @Expect(r.c1.z, Float64(3.0))
}
