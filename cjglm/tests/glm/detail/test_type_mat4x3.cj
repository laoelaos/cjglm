package glm.detail

import std.unittest.*
import std.unittest.testmacro.*

@Test
func testMat4x3ScalarInit(): Unit {
    let m = Mat4x3<Int64, Defaultp>(5)
    @Expect(m.c0.x, 5)
    @Expect(m.c0.y, 5)
    @Expect(m.c0.z, 5)
    @Expect(m.c1.x, 5)
    @Expect(m.c1.y, 5)
    @Expect(m.c1.z, 5)
    @Expect(m.c2.x, 5)
    @Expect(m.c2.y, 5)
    @Expect(m.c2.z, 5)
    @Expect(m.c3.x, 5)
    @Expect(m.c3.y, 5)
    @Expect(m.c3.z, 5)
}

@Test
func testMat4x3ConstInitElementwise(): Unit {
    let m = Mat4x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 3)
    @Expect(m.c1.x, 4)
    @Expect(m.c1.y, 5)
    @Expect(m.c1.z, 6)
    @Expect(m.c2.x, 7)
    @Expect(m.c2.y, 8)
    @Expect(m.c2.z, 9)
    @Expect(m.c3.x, 10)
    @Expect(m.c3.y, 11)
    @Expect(m.c3.z, 12)
}

@Test
func testMat4x3ConstInitColumn(): Unit {
    let c0 = Vec3<Int64, Defaultp>(1, 2, 3)
    let c1 = Vec3<Int64, Defaultp>(4, 5, 6)
    let c2 = Vec3<Int64, Defaultp>(7, 8, 9)
    let c3 = Vec3<Int64, Defaultp>(10, 11, 12)
    let m = Mat4x3<Int64, Defaultp>(c0, c1, c2, c3)
    @Expect(m.c0, c0)
    @Expect(m.c1, c1)
    @Expect(m.c2, c2)
    @Expect(m.c3, c3)
}

@Test
func testMat4x3Length(): Unit {
    @Expect(Mat4x3<Int64, Defaultp>.length(), 4)
}

@Test
func testMat4x3IndexAccess(): Unit {
    let m = Mat4x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    @Expect(m[Int64(0)].x, 1)
    @Expect(m[Int64(0)].y, 2)
    @Expect(m[Int64(0)].z, 3)
    @Expect(m[Int64(1)].x, 4)
    @Expect(m[Int64(1)].y, 5)
    @Expect(m[Int64(1)].z, 6)
    @Expect(m[Int64(2)].x, 7)
    @Expect(m[Int64(2)].y, 8)
    @Expect(m[Int64(2)].z, 9)
    @Expect(m[Int64(3)].x, 10)
    @Expect(m[Int64(3)].y, 11)
    @Expect(m[Int64(3)].z, 12)
}

@Test
func testMat4x3IndexMutate(): Unit {
    var m = Mat4x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let newCol0 = Vec3<Int64, Defaultp>(10, 20, 30)
    m[Int64(0)] = newCol0
    @Expect(m[Int64(0)].x, 10)
    @Expect(m[Int64(0)].y, 20)
    @Expect(m[Int64(0)].z, 30)
}

@Test
func testMat4x3ColAccess(): Unit {
    let m = Mat4x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    @Expect(m.col(Int64(0)).x, 1)
    @Expect(m.col(Int64(0)).y, 2)
    @Expect(m.col(Int64(0)).z, 3)
    @Expect(m.col(Int64(1)).x, 4)
    @Expect(m.col(Int64(1)).y, 5)
    @Expect(m.col(Int64(1)).z, 6)
    @Expect(m.col(Int64(2)).x, 7)
    @Expect(m.col(Int64(2)).y, 8)
    @Expect(m.col(Int64(2)).z, 9)
    @Expect(m.col(Int64(3)).x, 10)
    @Expect(m.col(Int64(3)).y, 11)
    @Expect(m.col(Int64(3)).z, 12)
}

@Test
func testMat4x3ColOutOfBounds(): Unit {
    let m = Mat4x3<Int64, Defaultp>(5)
    try {
        let _ = m.col(Int64(4))
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}

@Test
func testMat4x3ColNegative(): Unit {
    let m = Mat4x3<Int64, Defaultp>(5)
    try {
        let _ = m.col(Int64(-1))
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}

@Test
func testMat4x3IndexOutOfBounds(): Unit {
    let m = Mat4x3<Int64, Defaultp>(5)
    try {
        let _ = m[Int64(4)]
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}

@Test
func testMat4x3NegativeIndex(): Unit {
    let m = Mat4x3<Int64, Defaultp>(5)
    try {
        let _ = m[Int64(-1)]
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}

@Test
func testMat4x3MutateThenRead(): Unit {
    var m = Mat4x3<Int64, Defaultp>(5)
    let newCol1 = Vec3<Int64, Defaultp>(7, 8, 9)
    m[Int64(1)] = newCol1
    @Expect(m.col(Int64(1)).x, 7)
    @Expect(m.col(Int64(1)).y, 8)
    @Expect(m.col(Int64(1)).z, 9)
}

@Test
func testMat4x3UnaryNegate(): Unit {
    let m = Mat4x3<Int64, Defaultp>(1, -2, 3, -4, 5, -6, -7, 8, -9, 10, -11, 12)
    let n = -m
    @Expect(n.c0.x, -1)
    @Expect(n.c0.y, 2)
    @Expect(n.c0.z, -3)
    @Expect(n.c1.x, 4)
    @Expect(n.c1.y, -5)
    @Expect(n.c1.z, 6)
    @Expect(n.c2.x, 7)
    @Expect(n.c2.y, -8)
    @Expect(n.c2.z, 9)
    @Expect(n.c3.x, -10)
    @Expect(n.c3.y, 11)
    @Expect(n.c3.z, -12)
}

@Test
func testMat4x3ScalarAdd(): Unit {
    let m = Mat4x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let r = m + Int64(10)
    @Expect(r.c0.x, 11)
    @Expect(r.c0.y, 12)
    @Expect(r.c0.z, 13)
    @Expect(r.c1.x, 14)
    @Expect(r.c1.y, 15)
    @Expect(r.c1.z, 16)
    @Expect(r.c2.x, 17)
    @Expect(r.c2.y, 18)
    @Expect(r.c2.z, 19)
    @Expect(r.c3.x, 20)
    @Expect(r.c3.y, 21)
    @Expect(r.c3.z, 22)
}

@Test
func testMat4x3ScalarSub(): Unit {
    let m = Mat4x3<Int64, Defaultp>(10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120)
    let r = m - Int64(5)
    @Expect(r.c0.x, 5)
    @Expect(r.c0.y, 15)
    @Expect(r.c0.z, 25)
    @Expect(r.c1.x, 35)
    @Expect(r.c1.y, 45)
    @Expect(r.c1.z, 55)
    @Expect(r.c2.x, 65)
    @Expect(r.c2.y, 75)
    @Expect(r.c2.z, 85)
    @Expect(r.c3.x, 95)
    @Expect(r.c3.y, 105)
    @Expect(r.c3.z, 115)
}

@Test
func testMat4x3ScalarMul(): Unit {
    let m = Mat4x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let r = m * Int64(3)
    @Expect(r.c0.x, 3)
    @Expect(r.c0.y, 6)
    @Expect(r.c0.z, 9)
    @Expect(r.c1.x, 12)
    @Expect(r.c1.y, 15)
    @Expect(r.c1.z, 18)
    @Expect(r.c2.x, 21)
    @Expect(r.c2.y, 24)
    @Expect(r.c2.z, 27)
    @Expect(r.c3.x, 30)
    @Expect(r.c3.y, 33)
    @Expect(r.c3.z, 36)
}

@Test
func testMat4x3ScalarDiv(): Unit {
    let m = Mat4x3<Int64, Defaultp>(10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120)
    let r = m / Int64(2)
    @Expect(r.c0.x, 5)
    @Expect(r.c0.y, 10)
    @Expect(r.c0.z, 15)
    @Expect(r.c1.x, 20)
    @Expect(r.c1.y, 25)
    @Expect(r.c1.z, 30)
    @Expect(r.c2.x, 35)
    @Expect(r.c2.y, 40)
    @Expect(r.c2.z, 45)
    @Expect(r.c3.x, 50)
    @Expect(r.c3.y, 55)
    @Expect(r.c3.z, 60)
}

@Test
func testMat4x3MatrixAdd(): Unit {
    let a = Mat4x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let b = Mat4x3<Int64, Defaultp>(13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24)
    let r = a + b
    @Expect(r.c0.x, 14)
    @Expect(r.c0.y, 16)
    @Expect(r.c0.z, 18)
    @Expect(r.c1.x, 20)
    @Expect(r.c1.y, 22)
    @Expect(r.c1.z, 24)
    @Expect(r.c2.x, 26)
    @Expect(r.c2.y, 28)
    @Expect(r.c2.z, 30)
    @Expect(r.c3.x, 32)
    @Expect(r.c3.y, 34)
    @Expect(r.c3.z, 36)
}

@Test
func testMat4x3MatrixSub(): Unit {
    let a = Mat4x3<Int64, Defaultp>(10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120)
    let b = Mat4x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let r = a - b
    @Expect(r.c0.x, 9)
    @Expect(r.c0.y, 18)
    @Expect(r.c0.z, 27)
    @Expect(r.c1.x, 36)
    @Expect(r.c1.y, 45)
    @Expect(r.c1.z, 54)
    @Expect(r.c2.x, 63)
    @Expect(r.c2.y, 72)
    @Expect(r.c2.z, 81)
    @Expect(r.c3.x, 90)
    @Expect(r.c3.y, 99)
    @Expect(r.c3.z, 108)
}

@Test
func testMat4x3MulMat2x4(): Unit {
    let a = Mat4x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let b = Mat2x4<Int64, Defaultp>(13, 14, 15, 16, 17, 18, 19, 20)
    let r = a * b
    @Expect(r.c0.x, 1*13 + 4*14 + 7*15 + 10*16)
    @Expect(r.c0.y, 2*13 + 5*14 + 8*15 + 11*16)
    @Expect(r.c0.z, 3*13 + 6*14 + 9*15 + 12*16)
    @Expect(r.c1.x, 1*17 + 4*18 + 7*19 + 10*20)
    @Expect(r.c1.y, 2*17 + 5*18 + 8*19 + 11*20)
    @Expect(r.c1.z, 3*17 + 6*18 + 9*19 + 12*20)
}

@Test
func testMat4x3MulMat3x4(): Unit {
    let a = Mat4x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let b = Mat3x4<Int64, Defaultp>(13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24)
    let r = a * b
    @Expect(r.c0.x, 1*13 + 4*14 + 7*15 + 10*16)
    @Expect(r.c0.y, 2*13 + 5*14 + 8*15 + 11*16)
    @Expect(r.c0.z, 3*13 + 6*14 + 9*15 + 12*16)
    @Expect(r.c1.x, 1*17 + 4*18 + 7*19 + 10*20)
    @Expect(r.c1.y, 2*17 + 5*18 + 8*19 + 11*20)
    @Expect(r.c1.z, 3*17 + 6*18 + 9*19 + 12*20)
    @Expect(r.c2.x, 1*21 + 4*22 + 7*23 + 10*24)
    @Expect(r.c2.y, 2*21 + 5*22 + 8*23 + 11*24)
    @Expect(r.c2.z, 3*21 + 6*22 + 9*23 + 12*24)
}

@Test
func testMat4x3MulMat4x4(): Unit {
    let a = Mat4x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let b = Mat4x4<Int64, Defaultp>(13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28)
    let r = a * b
    @Expect(r.c0.x, 1*13 + 4*14 + 7*15 + 10*16)
    @Expect(r.c0.y, 2*13 + 5*14 + 8*15 + 11*16)
    @Expect(r.c0.z, 3*13 + 6*14 + 9*15 + 12*16)
    @Expect(r.c1.x, 1*17 + 4*18 + 7*19 + 10*20)
    @Expect(r.c1.y, 2*17 + 5*18 + 8*19 + 11*20)
    @Expect(r.c1.z, 3*17 + 6*18 + 9*19 + 12*20)
    @Expect(r.c2.x, 1*21 + 4*22 + 7*23 + 10*24)
    @Expect(r.c2.y, 2*21 + 5*22 + 8*23 + 11*24)
    @Expect(r.c2.z, 3*21 + 6*22 + 9*23 + 12*24)
    @Expect(r.c3.x, 1*25 + 4*26 + 7*27 + 10*28)
    @Expect(r.c3.y, 2*25 + 5*26 + 8*27 + 11*28)
    @Expect(r.c3.z, 3*25 + 6*26 + 9*27 + 12*28)
}

@Test
func testMat4x3MulVec4(): Unit {
    let m = Mat4x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let v = Vec4<Int64, Defaultp>(13, 14, 15, 16)
    let r = m * v
    @Expect(r.x, 1*13 + 4*14 + 7*15 + 10*16)
    @Expect(r.y, 2*13 + 5*14 + 8*15 + 11*16)
    @Expect(r.z, 3*13 + 6*14 + 9*15 + 12*16)
}

@Test
func testMat4x3Diagonal(): Unit {
    let d = Mat4x3<Int64, Defaultp>.diagonal(Int64(7))
    @Expect(d.c0.x, 7)
    @Expect(d.c0.y, 0)
    @Expect(d.c0.z, 0)
    @Expect(d.c1.x, 0)
    @Expect(d.c1.y, 7)
    @Expect(d.c1.z, 0)
    @Expect(d.c2.x, 0)
    @Expect(d.c2.y, 0)
    @Expect(d.c2.z, 7)
    @Expect(d.c3.x, 0)
    @Expect(d.c3.y, 0)
    @Expect(d.c3.z, 0)
}

@Test
func testMat4x3Identity(): Unit {
    let id = Mat4x3<Int64, Defaultp>.identity(Int64(1))
    @Expect(id.c0.x, 1)
    @Expect(id.c0.y, 0)
    @Expect(id.c0.z, 0)
    @Expect(id.c1.x, 0)
    @Expect(id.c1.y, 1)
    @Expect(id.c1.z, 0)
    @Expect(id.c2.x, 0)
    @Expect(id.c2.y, 0)
    @Expect(id.c2.z, 1)
    @Expect(id.c3.x, 0)
    @Expect(id.c3.y, 0)
    @Expect(id.c3.z, 0)
}

@Test
func testMat4x3FromParts(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let m = Mat4x3<Float64, Defaultp>.fromParts(conv, Int64(1), Int64(2), Int64(3), Int64(4), Int64(5), Int64(6), Int64(7), Int64(8), Int64(9), Int64(10), Int64(11), Int64(12))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(3))
    @Expect(m.c1.x, Float64(4))
    @Expect(m.c1.y, Float64(5))
    @Expect(m.c1.z, Float64(6))
    @Expect(m.c2.x, Float64(7))
    @Expect(m.c2.y, Float64(8))
    @Expect(m.c2.z, Float64(9))
    @Expect(m.c3.x, Float64(10))
    @Expect(m.c3.y, Float64(11))
    @Expect(m.c3.z, Float64(12))
}

@Test
func testMat4x3FromColumns(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let c0 = Vec3<Int64, Defaultp>(1, 2, 3)
    let c1 = Vec3<Int64, Defaultp>(4, 5, 6)
    let c2 = Vec3<Int64, Defaultp>(7, 8, 9)
    let c3 = Vec3<Int64, Defaultp>(10, 11, 12)
    let m = Mat4x3<Float64, Defaultp>.fromColumns(conv, c0, c1, c2, c3)
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(3))
    @Expect(m.c1.x, Float64(4))
    @Expect(m.c1.y, Float64(5))
    @Expect(m.c1.z, Float64(6))
    @Expect(m.c2.x, Float64(7))
    @Expect(m.c2.y, Float64(8))
    @Expect(m.c2.z, Float64(9))
    @Expect(m.c3.x, Float64(10))
    @Expect(m.c3.y, Float64(11))
    @Expect(m.c3.z, Float64(12))
}

@Test
func testMat4x3FromMat7(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat4x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let m = Mat4x3<Float64, Defaultp>.fromMat(conv, src)
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(3))
    @Expect(m.c1.x, Float64(4))
    @Expect(m.c1.y, Float64(5))
    @Expect(m.c1.z, Float64(6))
    @Expect(m.c2.x, Float64(7))
    @Expect(m.c2.y, Float64(8))
    @Expect(m.c2.z, Float64(9))
    @Expect(m.c3.x, Float64(10))
    @Expect(m.c3.y, Float64(11))
    @Expect(m.c3.z, Float64(12))
}

@Test
func testMat4x3FromMat6aMat2x2(): Unit {
    let src = Mat2x2<Int64, Defaultp>(1, 2, 3, 4)
    let m = Mat4x3<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 0)
    @Expect(m.c1.x, 3)
    @Expect(m.c1.y, 4)
    @Expect(m.c1.z, 0)
    @Expect(m.c2.x, 0)
    @Expect(m.c2.y, 0)
    @Expect(m.c2.z, 1)
    @Expect(m.c3.x, 0)
    @Expect(m.c3.y, 0)
    @Expect(m.c3.z, 0)
}

@Test
func testMat4x3FromMat6aMat2x3(): Unit {
    let src = Mat2x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let m = Mat4x3<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 3)
    @Expect(m.c1.x, 4)
    @Expect(m.c1.y, 5)
    @Expect(m.c1.z, 6)
    @Expect(m.c2.x, 0)
    @Expect(m.c2.y, 0)
    @Expect(m.c2.z, 1)
    @Expect(m.c3.x, 0)
    @Expect(m.c3.y, 0)
    @Expect(m.c3.z, 0)
}

@Test
func testMat4x3FromMat6aMat2x4(): Unit {
    let src = Mat2x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let m = Mat4x3<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 3)
    @Expect(m.c1.x, 5)
    @Expect(m.c1.y, 6)
    @Expect(m.c1.z, 7)
    @Expect(m.c2.x, 0)
    @Expect(m.c2.y, 0)
    @Expect(m.c2.z, 1)
    @Expect(m.c3.x, 0)
    @Expect(m.c3.y, 0)
    @Expect(m.c3.z, 0)
}

@Test
func testMat4x3FromMat6aMat3x2(): Unit {
    let src = Mat3x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let m = Mat4x3<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 0)
    @Expect(m.c1.x, 3)
    @Expect(m.c1.y, 4)
    @Expect(m.c1.z, 0)
    @Expect(m.c2.x, 5)
    @Expect(m.c2.y, 6)
    @Expect(m.c2.z, 1)
    @Expect(m.c3.x, 0)
    @Expect(m.c3.y, 0)
    @Expect(m.c3.z, 0)
}

@Test
func testMat4x3FromMat6aMat3x3(): Unit {
    let src = Mat3x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9)
    let m = Mat4x3<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 3)
    @Expect(m.c1.x, 4)
    @Expect(m.c1.y, 5)
    @Expect(m.c1.z, 6)
    @Expect(m.c2.x, 7)
    @Expect(m.c2.y, 8)
    @Expect(m.c2.z, 9)
    @Expect(m.c3.x, 0)
    @Expect(m.c3.y, 0)
    @Expect(m.c3.z, 0)
}

@Test
func testMat4x3FromMat6aMat3x4(): Unit {
    let src = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
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
    @Expect(m.c3.x, 0)
    @Expect(m.c3.y, 0)
    @Expect(m.c3.z, 0)
}

@Test
func testMat4x3FromMat6aMat4x2(): Unit {
    let src = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let m = Mat4x3<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 0)
    @Expect(m.c1.x, 3)
    @Expect(m.c1.y, 4)
    @Expect(m.c1.z, 0)
    @Expect(m.c2.x, 5)
    @Expect(m.c2.y, 6)
    @Expect(m.c2.z, 1)
    @Expect(m.c3.x, 7)
    @Expect(m.c3.y, 8)
    @Expect(m.c3.z, 0)
}

@Test
func testMat4x3FromMat6aMat4x4(): Unit {
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
func testMat4x3FromMat6bMat2x2(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat2x2<Int64, Defaultp>(1, 2, 3, 4)
    let m = Mat4x3<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(0))
    @Expect(m.c1.x, Float64(3))
    @Expect(m.c1.y, Float64(4))
    @Expect(m.c1.z, Float64(0))
    @Expect(m.c2.x, Float64(0))
    @Expect(m.c2.y, Float64(0))
    @Expect(m.c2.z, Float64(1))
    @Expect(m.c3.x, Float64(0))
    @Expect(m.c3.y, Float64(0))
    @Expect(m.c3.z, Float64(0))
}

@Test
func testMat4x3FromMat6bMat2x3(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat2x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let m = Mat4x3<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(3))
    @Expect(m.c1.x, Float64(4))
    @Expect(m.c1.y, Float64(5))
    @Expect(m.c1.z, Float64(6))
    @Expect(m.c2.x, Float64(0))
    @Expect(m.c2.y, Float64(0))
    @Expect(m.c2.z, Float64(1))
    @Expect(m.c3.x, Float64(0))
    @Expect(m.c3.y, Float64(0))
    @Expect(m.c3.z, Float64(0))
}

@Test
func testMat4x3FromMat6bMat2x4(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat2x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let m = Mat4x3<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(3))
    @Expect(m.c1.x, Float64(5))
    @Expect(m.c1.y, Float64(6))
    @Expect(m.c1.z, Float64(7))
    @Expect(m.c2.x, Float64(0))
    @Expect(m.c2.y, Float64(0))
    @Expect(m.c2.z, Float64(1))
    @Expect(m.c3.x, Float64(0))
    @Expect(m.c3.y, Float64(0))
    @Expect(m.c3.z, Float64(0))
}

@Test
func testMat4x3FromMat6bMat3x2(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat3x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let m = Mat4x3<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(0))
    @Expect(m.c1.x, Float64(3))
    @Expect(m.c1.y, Float64(4))
    @Expect(m.c1.z, Float64(0))
    @Expect(m.c2.x, Float64(5))
    @Expect(m.c2.y, Float64(6))
    @Expect(m.c2.z, Float64(1))
    @Expect(m.c3.x, Float64(0))
    @Expect(m.c3.y, Float64(0))
    @Expect(m.c3.z, Float64(0))
}

@Test
func testMat4x3FromMat6bMat3x3(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat3x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9)
    let m = Mat4x3<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(3))
    @Expect(m.c1.x, Float64(4))
    @Expect(m.c1.y, Float64(5))
    @Expect(m.c1.z, Float64(6))
    @Expect(m.c2.x, Float64(7))
    @Expect(m.c2.y, Float64(8))
    @Expect(m.c2.z, Float64(9))
    @Expect(m.c3.x, Float64(0))
    @Expect(m.c3.y, Float64(0))
    @Expect(m.c3.z, Float64(0))
}

@Test
func testMat4x3FromMat6bMat3x4(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
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
    @Expect(m.c3.x, Float64(0))
    @Expect(m.c3.y, Float64(0))
    @Expect(m.c3.z, Float64(0))
}

@Test
func testMat4x3FromMat6bMat4x2(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let m = Mat4x3<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(0))
    @Expect(m.c1.x, Float64(3))
    @Expect(m.c1.y, Float64(4))
    @Expect(m.c1.z, Float64(0))
    @Expect(m.c2.x, Float64(5))
    @Expect(m.c2.y, Float64(6))
    @Expect(m.c2.z, Float64(1))
    @Expect(m.c3.x, Float64(7))
    @Expect(m.c3.y, Float64(8))
    @Expect(m.c3.z, Float64(0))
}

@Test
func testMat4x3FromMat6bMat4x4(): Unit {
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

@Test
func testMat4x3DiagonalFloat32(): Unit {
    let d = Mat4x3<Float32, Defaultp>.diagonal(Float32(7.5))
    @Expect(d.c0.x, Float32(7.5))
    @Expect(d.c0.y, Float32(0.0))
    @Expect(d.c0.z, Float32(0.0))
    @Expect(d.c1.x, Float32(0.0))
    @Expect(d.c1.y, Float32(7.5))
    @Expect(d.c1.z, Float32(0.0))
    @Expect(d.c2.x, Float32(0.0))
    @Expect(d.c2.y, Float32(0.0))
    @Expect(d.c2.z, Float32(7.5))
    @Expect(d.c3.x, Float32(0.0))
    @Expect(d.c3.y, Float32(0.0))
    @Expect(d.c3.z, Float32(0.0))
}

@Test
func testMat4x3DiagonalFloat64(): Unit {
    let d = Mat4x3<Float64, Defaultp>.diagonal(Float64(7.5))
    @Expect(d.c0.x, Float64(7.5))
    @Expect(d.c0.y, Float64(0.0))
    @Expect(d.c0.z, Float64(0.0))
    @Expect(d.c1.x, Float64(0.0))
    @Expect(d.c1.y, Float64(7.5))
    @Expect(d.c1.z, Float64(0.0))
    @Expect(d.c2.x, Float64(0.0))
    @Expect(d.c2.y, Float64(0.0))
    @Expect(d.c2.z, Float64(7.5))
    @Expect(d.c3.x, Float64(0.0))
    @Expect(d.c3.y, Float64(0.0))
    @Expect(d.c3.z, Float64(0.0))
}

@Test
func testMat4x3ColAccessFloat32(): Unit {
    let m = Mat4x3<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5))
    let c0 = Vec3<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5))
    let c1 = Vec3<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5))
    let c2 = Vec3<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5))
    let c3 = Vec3<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5))
    @Expect(m.col(Int64(0)), c0)
    @Expect(m.col(Int64(1)), c1)
    @Expect(m.col(Int64(2)), c2)
    @Expect(m.col(Int64(3)), c3)
}

@Test
func testMat4x3ColAccessFloat64(): Unit {
    let m = Mat4x3<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5))
    let c0 = Vec3<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5))
    let c1 = Vec3<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5))
    let c2 = Vec3<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5))
    let c3 = Vec3<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5))
    @Expect(m.col(Int64(0)), c0)
    @Expect(m.col(Int64(1)), c1)
    @Expect(m.col(Int64(2)), c2)
    @Expect(m.col(Int64(3)), c3)
}

@Test
func testMat4x3ScalarMulFloat32(): Unit {
    let m = Mat4x3<Float32, Defaultp>(Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0))
    let r = m * Float32(1.5)
    @Expect(r.c0.x, Float32(3.0))
    @Expect(r.c0.y, Float32(3.0))
    @Expect(r.c0.z, Float32(3.0))
    @Expect(r.c1.x, Float32(3.0))
    @Expect(r.c1.y, Float32(3.0))
    @Expect(r.c1.z, Float32(3.0))
    @Expect(r.c2.x, Float32(3.0))
    @Expect(r.c2.y, Float32(3.0))
    @Expect(r.c2.z, Float32(3.0))
    @Expect(r.c3.x, Float32(3.0))
    @Expect(r.c3.y, Float32(3.0))
    @Expect(r.c3.z, Float32(3.0))
}

@Test
func testMat4x3ScalarMulFloat64(): Unit {
    let m = Mat4x3<Float64, Defaultp>(Float64(2.0), Float64(2.0), Float64(2.0), Float64(2.0), Float64(2.0), Float64(2.0), Float64(2.0), Float64(2.0), Float64(2.0), Float64(2.0), Float64(2.0), Float64(2.0))
    let r = m * Float64(1.5)
    @Expect(r.c0.x, Float64(3.0))
    @Expect(r.c0.y, Float64(3.0))
    @Expect(r.c0.z, Float64(3.0))
    @Expect(r.c1.x, Float64(3.0))
    @Expect(r.c1.y, Float64(3.0))
    @Expect(r.c1.z, Float64(3.0))
    @Expect(r.c2.x, Float64(3.0))
    @Expect(r.c2.y, Float64(3.0))
    @Expect(r.c2.z, Float64(3.0))
    @Expect(r.c3.x, Float64(3.0))
    @Expect(r.c3.y, Float64(3.0))
    @Expect(r.c3.z, Float64(3.0))
}
