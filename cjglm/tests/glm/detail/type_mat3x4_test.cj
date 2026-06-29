package glm.detail

import std.unittest.*
import std.unittest.testmacro.*

@Test
func testMat3x4ScalarInit(): Unit {
    let m = Mat3x4<Int64, Defaultp>(5)
    @Expect(m.c0.x, 5)
    @Expect(m.c0.y, 5)
    @Expect(m.c0.z, 5)
    @Expect(m.c0.w, 5)
    @Expect(m.c1.x, 5)
    @Expect(m.c1.y, 5)
    @Expect(m.c1.z, 5)
    @Expect(m.c1.w, 5)
    @Expect(m.c2.x, 5)
    @Expect(m.c2.y, 5)
    @Expect(m.c2.z, 5)
    @Expect(m.c2.w, 5)
}

@Test
func testMat3x4ConstInitElementwise(): Unit {
    let m = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
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
func testMat3x4ConstInitColumn(): Unit {
    let c0 = Vec4<Int64, Defaultp>(1, 2, 3, 4)
    let c1 = Vec4<Int64, Defaultp>(5, 6, 7, 8)
    let c2 = Vec4<Int64, Defaultp>(9, 10, 11, 12)
    let m = Mat3x4<Int64, Defaultp>(c0, c1, c2)
    @Expect(m.c0, c0)
    @Expect(m.c1, c1)
    @Expect(m.c2, c2)
}

@Test
func testMat3x4Length(): Unit {
    @Expect(Mat3x4<Int64, Defaultp>.length(), 3)
}

@Test
func testMat3x4IndexAccess(): Unit {
    let m = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    @Expect(m[Int64(0)].x, 1)
    @Expect(m[Int64(0)].y, 2)
    @Expect(m[Int64(0)].z, 3)
    @Expect(m[Int64(0)].w, 4)
    @Expect(m[Int64(1)].x, 5)
    @Expect(m[Int64(1)].y, 6)
    @Expect(m[Int64(1)].z, 7)
    @Expect(m[Int64(1)].w, 8)
    @Expect(m[Int64(2)].x, 9)
    @Expect(m[Int64(2)].y, 10)
    @Expect(m[Int64(2)].z, 11)
    @Expect(m[Int64(2)].w, 12)
}

@Test
func testMat3x4IndexMutate(): Unit {
    var m = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let newCol1 = Vec4<Int64, Defaultp>(10, 20, 30, 40)
    m[Int64(1)] = newCol1
    @Expect(m[Int64(1)].x, 10)
    @Expect(m[Int64(1)].y, 20)
    @Expect(m[Int64(1)].z, 30)
    @Expect(m[Int64(1)].w, 40)
}

@Test
func testMat3x4ColAccess(): Unit {
    let m = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    @Expect(m.col(Int64(0)).x, 1)
    @Expect(m.col(Int64(0)).y, 2)
    @Expect(m.col(Int64(0)).z, 3)
    @Expect(m.col(Int64(0)).w, 4)
    @Expect(m.col(Int64(1)).x, 5)
    @Expect(m.col(Int64(1)).y, 6)
    @Expect(m.col(Int64(1)).z, 7)
    @Expect(m.col(Int64(1)).w, 8)
    @Expect(m.col(Int64(2)).x, 9)
    @Expect(m.col(Int64(2)).y, 10)
    @Expect(m.col(Int64(2)).z, 11)
    @Expect(m.col(Int64(2)).w, 12)
}

@Test
func testMat3x4ColOutOfBounds(): Unit {
    let m = Mat3x4<Int64, Defaultp>(5)
    try {
        let _ = m.col(Int64(3))
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}

@Test
func testMat3x4ColNegative(): Unit {
    let m = Mat3x4<Int64, Defaultp>(5)
    try {
        let _ = m.col(Int64(-1))
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}

@Test
func testMat3x4IndexOutOfBounds(): Unit {
    let m = Mat3x4<Int64, Defaultp>(5)
    try {
        let _ = m[Int64(3)]
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}

@Test
func testMat3x4NegativeIndex(): Unit {
    let m = Mat3x4<Int64, Defaultp>(5)
    try {
        let _ = m[Int64(-1)]
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}

@Test
func testMat3x4MutateThenRead(): Unit {
    var m = Mat3x4<Int64, Defaultp>(5)
    let newCol0 = Vec4<Int64, Defaultp>(7, 8, 9, 10)
    m[Int64(0)] = newCol0
    @Expect(m.col(Int64(0)).x, 7)
    @Expect(m.col(Int64(0)).y, 8)
    @Expect(m.col(Int64(0)).z, 9)
    @Expect(m.col(Int64(0)).w, 10)
}

@Test
func testMat3x4UnaryNegate(): Unit {
    let m = Mat3x4<Int64, Defaultp>(1, -2, 3, -4, -5, 6, -7, 8, 9, -10, 11, -12)
    let n = -m
    @Expect(n.c0.x, -1)
    @Expect(n.c0.y, 2)
    @Expect(n.c0.z, -3)
    @Expect(n.c0.w, 4)
    @Expect(n.c1.x, 5)
    @Expect(n.c1.y, -6)
    @Expect(n.c1.z, 7)
    @Expect(n.c1.w, -8)
    @Expect(n.c2.x, -9)
    @Expect(n.c2.y, 10)
    @Expect(n.c2.z, -11)
    @Expect(n.c2.w, 12)
}

@Test
func testMat3x4ScalarAdd(): Unit {
    let m = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let r = m + Int64(10)
    @Expect(r.c0.x, 11)
    @Expect(r.c0.y, 12)
    @Expect(r.c0.z, 13)
    @Expect(r.c0.w, 14)
    @Expect(r.c1.x, 15)
    @Expect(r.c1.y, 16)
    @Expect(r.c1.z, 17)
    @Expect(r.c1.w, 18)
    @Expect(r.c2.x, 19)
    @Expect(r.c2.y, 20)
    @Expect(r.c2.z, 21)
    @Expect(r.c2.w, 22)
}

@Test
func testMat3x4ScalarSub(): Unit {
    let m = Mat3x4<Int64, Defaultp>(10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120)
    let r = m - Int64(5)
    @Expect(r.c0.x, 5)
    @Expect(r.c0.y, 15)
    @Expect(r.c0.z, 25)
    @Expect(r.c0.w, 35)
    @Expect(r.c1.x, 45)
    @Expect(r.c1.y, 55)
    @Expect(r.c1.z, 65)
    @Expect(r.c1.w, 75)
    @Expect(r.c2.x, 85)
    @Expect(r.c2.y, 95)
    @Expect(r.c2.z, 105)
    @Expect(r.c2.w, 115)
}

@Test
func testMat3x4ScalarMul(): Unit {
    let m = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let r = m * Int64(3)
    @Expect(r.c0.x, 3)
    @Expect(r.c0.y, 6)
    @Expect(r.c0.z, 9)
    @Expect(r.c0.w, 12)
    @Expect(r.c1.x, 15)
    @Expect(r.c1.y, 18)
    @Expect(r.c1.z, 21)
    @Expect(r.c1.w, 24)
    @Expect(r.c2.x, 27)
    @Expect(r.c2.y, 30)
    @Expect(r.c2.z, 33)
    @Expect(r.c2.w, 36)
}

@Test
func testMat3x4ScalarDiv(): Unit {
    let m = Mat3x4<Int64, Defaultp>(10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120)
    let r = m / Int64(2)
    @Expect(r.c0.x, 5)
    @Expect(r.c0.y, 10)
    @Expect(r.c0.z, 15)
    @Expect(r.c0.w, 20)
    @Expect(r.c1.x, 25)
    @Expect(r.c1.y, 30)
    @Expect(r.c1.z, 35)
    @Expect(r.c1.w, 40)
    @Expect(r.c2.x, 45)
    @Expect(r.c2.y, 50)
    @Expect(r.c2.z, 55)
    @Expect(r.c2.w, 60)
}

@Test
func testMat3x4MatrixAdd(): Unit {
    let a = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let b = Mat3x4<Int64, Defaultp>(13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24)
    let r = a + b
    @Expect(r.c0.x, 14)
    @Expect(r.c0.y, 16)
    @Expect(r.c0.z, 18)
    @Expect(r.c0.w, 20)
    @Expect(r.c1.x, 22)
    @Expect(r.c1.y, 24)
    @Expect(r.c1.z, 26)
    @Expect(r.c1.w, 28)
    @Expect(r.c2.x, 30)
    @Expect(r.c2.y, 32)
    @Expect(r.c2.z, 34)
    @Expect(r.c2.w, 36)
}

@Test
func testMat3x4MatrixSub(): Unit {
    let a = Mat3x4<Int64, Defaultp>(10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120)
    let b = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let r = a - b
    @Expect(r.c0.x, 9)
    @Expect(r.c0.y, 18)
    @Expect(r.c0.z, 27)
    @Expect(r.c0.w, 36)
    @Expect(r.c1.x, 45)
    @Expect(r.c1.y, 54)
    @Expect(r.c1.z, 63)
    @Expect(r.c1.w, 72)
    @Expect(r.c2.x, 81)
    @Expect(r.c2.y, 90)
    @Expect(r.c2.z, 99)
    @Expect(r.c2.w, 108)
}

@Test
func testMat3x4MulMat2x3(): Unit {
    let a = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let b = Mat2x3<Int64, Defaultp>(13, 14, 15, 16, 17, 18)
    let r = a * b
    @Expect(r.c0.x, 1*13 + 5*14 + 9*15)
    @Expect(r.c0.y, 2*13 + 6*14 + 10*15)
    @Expect(r.c0.z, 3*13 + 7*14 + 11*15)
    @Expect(r.c0.w, 4*13 + 8*14 + 12*15)
    @Expect(r.c1.x, 1*16 + 5*17 + 9*18)
    @Expect(r.c1.y, 2*16 + 6*17 + 10*18)
    @Expect(r.c1.z, 3*16 + 7*17 + 11*18)
    @Expect(r.c1.w, 4*16 + 8*17 + 12*18)
}

@Test
func testMat3x4MulMat3x3(): Unit {
    let a = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let b = Mat3x3<Int64, Defaultp>(13, 14, 15, 16, 17, 18, 19, 20, 21)
    let r = a * b
    @Expect(r.c0.x, 1*13 + 5*14 + 9*15)
    @Expect(r.c0.y, 2*13 + 6*14 + 10*15)
    @Expect(r.c0.z, 3*13 + 7*14 + 11*15)
    @Expect(r.c0.w, 4*13 + 8*14 + 12*15)
    @Expect(r.c1.x, 1*16 + 5*17 + 9*18)
    @Expect(r.c1.y, 2*16 + 6*17 + 10*18)
    @Expect(r.c1.z, 3*16 + 7*17 + 11*18)
    @Expect(r.c1.w, 4*16 + 8*17 + 12*18)
    @Expect(r.c2.x, 1*19 + 5*20 + 9*21)
    @Expect(r.c2.y, 2*19 + 6*20 + 10*21)
    @Expect(r.c2.z, 3*19 + 7*20 + 11*21)
    @Expect(r.c2.w, 4*19 + 8*20 + 12*21)
}

@Test
func testMat3x4MulMat4x3(): Unit {
    let a = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let b = Mat4x3<Int64, Defaultp>(13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24)
    let r = a * b
    @Expect(r.c0.x, 1*13 + 5*14 + 9*15)
    @Expect(r.c0.y, 2*13 + 6*14 + 10*15)
    @Expect(r.c0.z, 3*13 + 7*14 + 11*15)
    @Expect(r.c0.w, 4*13 + 8*14 + 12*15)
    @Expect(r.c1.x, 1*16 + 5*17 + 9*18)
    @Expect(r.c1.y, 2*16 + 6*17 + 10*18)
    @Expect(r.c1.z, 3*16 + 7*17 + 11*18)
    @Expect(r.c1.w, 4*16 + 8*17 + 12*18)
    @Expect(r.c2.x, 1*19 + 5*20 + 9*21)
    @Expect(r.c2.y, 2*19 + 6*20 + 10*21)
    @Expect(r.c2.z, 3*19 + 7*20 + 11*21)
    @Expect(r.c2.w, 4*19 + 8*20 + 12*21)
    @Expect(r.c3.x, 1*22 + 5*23 + 9*24)
    @Expect(r.c3.y, 2*22 + 6*23 + 10*24)
    @Expect(r.c3.z, 3*22 + 7*23 + 11*24)
    @Expect(r.c3.w, 4*22 + 8*23 + 12*24)
}

@Test
func testMat3x4MulVec3(): Unit {
    let m = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let v = Vec3<Int64, Defaultp>(13, 14, 15)
    let r = m * v
    @Expect(r.x, 1*13 + 5*14 + 9*15)
    @Expect(r.y, 2*13 + 6*14 + 10*15)
    @Expect(r.z, 3*13 + 7*14 + 11*15)
    @Expect(r.w, 4*13 + 8*14 + 12*15)
}

@Test
func testMat3x4Diagonal(): Unit {
    let d = Mat3x4<Int64, Defaultp>.diagonal(Int64(7))
    @Expect(d.c0.x, 7)
    @Expect(d.c0.y, 0)
    @Expect(d.c0.z, 0)
    @Expect(d.c0.w, 0)
    @Expect(d.c1.x, 0)
    @Expect(d.c1.y, 7)
    @Expect(d.c1.z, 0)
    @Expect(d.c1.w, 0)
    @Expect(d.c2.x, 0)
    @Expect(d.c2.y, 0)
    @Expect(d.c2.z, 7)
    @Expect(d.c2.w, 0)
}

@Test
func testMat3x4Identity(): Unit {
    let id = Mat3x4<Int64, Defaultp>.identity(Int64(1))
    @Expect(id.c0.x, 1)
    @Expect(id.c0.y, 0)
    @Expect(id.c0.z, 0)
    @Expect(id.c0.w, 0)
    @Expect(id.c1.x, 0)
    @Expect(id.c1.y, 1)
    @Expect(id.c1.z, 0)
    @Expect(id.c1.w, 0)
    @Expect(id.c2.x, 0)
    @Expect(id.c2.y, 0)
    @Expect(id.c2.z, 1)
    @Expect(id.c2.w, 0)
}

@Test
func testMat3x4FromParts(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let m = Mat3x4<Float64, Defaultp>.fromParts(conv, Int64(1), Int64(2), Int64(3), Int64(4), Int64(5), Int64(6), Int64(7), Int64(8), Int64(9), Int64(10), Int64(11), Int64(12))
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

@Test
func testMat3x4FromColumns(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let c0 = Vec4<Int64, Defaultp>(1, 2, 3, 4)
    let c1 = Vec4<Int64, Defaultp>(5, 6, 7, 8)
    let c2 = Vec4<Int64, Defaultp>(9, 10, 11, 12)
    let m = Mat3x4<Float64, Defaultp>.fromColumns(conv, c0, c1, c2)
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

@Test
func testMat3x4FromMat7(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let m = Mat3x4<Float64, Defaultp>.fromMat(conv, src)
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

@Test
func testMat3x4FromMat6aMat2x2(): Unit {
    let src = Mat2x2<Int64, Defaultp>(1, 2, 3, 4)
    let m = Mat3x4<Int64, Defaultp>.fromMat(src, Int64(1))
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
}

@Test
func testMat3x4FromMat6aMat2x3(): Unit {
    let src = Mat2x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let m = Mat3x4<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 3)
    @Expect(m.c0.w, 0)
    @Expect(m.c1.x, 4)
    @Expect(m.c1.y, 5)
    @Expect(m.c1.z, 6)
    @Expect(m.c1.w, 0)
    @Expect(m.c2.x, 0)
    @Expect(m.c2.y, 0)
    @Expect(m.c2.z, 1)
    @Expect(m.c2.w, 0)
}

@Test
func testMat3x4FromMat6aMat2x4(): Unit {
    let src = Mat2x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let m = Mat3x4<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 3)
    @Expect(m.c0.w, 4)
    @Expect(m.c1.x, 5)
    @Expect(m.c1.y, 6)
    @Expect(m.c1.z, 7)
    @Expect(m.c1.w, 8)
    @Expect(m.c2.x, 0)
    @Expect(m.c2.y, 0)
    @Expect(m.c2.z, 1)
    @Expect(m.c2.w, 0)
}

@Test
func testMat3x4FromMat6aMat3x2(): Unit {
    let src = Mat3x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let m = Mat3x4<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 0)
    @Expect(m.c0.w, 0)
    @Expect(m.c1.x, 3)
    @Expect(m.c1.y, 4)
    @Expect(m.c1.z, 0)
    @Expect(m.c1.w, 0)
    @Expect(m.c2.x, 5)
    @Expect(m.c2.y, 6)
    @Expect(m.c2.z, 1)
    @Expect(m.c2.w, 0)
}

@Test
func testMat3x4FromMat6aMat3x3(): Unit {
    let src = Mat3x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9)
    let m = Mat3x4<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 3)
    @Expect(m.c0.w, 0)
    @Expect(m.c1.x, 4)
    @Expect(m.c1.y, 5)
    @Expect(m.c1.z, 6)
    @Expect(m.c1.w, 0)
    @Expect(m.c2.x, 7)
    @Expect(m.c2.y, 8)
    @Expect(m.c2.z, 9)
    @Expect(m.c2.w, 0)
}

@Test
func testMat3x4FromMat6aMat4x2(): Unit {
    let src = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let m = Mat3x4<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 0)
    @Expect(m.c0.w, 0)
    @Expect(m.c1.x, 3)
    @Expect(m.c1.y, 4)
    @Expect(m.c1.z, 0)
    @Expect(m.c1.w, 0)
    @Expect(m.c2.x, 5)
    @Expect(m.c2.y, 6)
    @Expect(m.c2.z, 1)
    @Expect(m.c2.w, 0)
}

@Test
func testMat3x4FromMat6aMat4x3(): Unit {
    let src = Mat4x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let m = Mat3x4<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 3)
    @Expect(m.c0.w, 0)
    @Expect(m.c1.x, 4)
    @Expect(m.c1.y, 5)
    @Expect(m.c1.z, 6)
    @Expect(m.c1.w, 0)
    @Expect(m.c2.x, 7)
    @Expect(m.c2.y, 8)
    @Expect(m.c2.z, 9)
    @Expect(m.c2.w, 0)
}

@Test
func testMat3x4FromMat6aMat4x4(): Unit {
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
func testMat3x4FromMat6bMat2x2(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat2x2<Int64, Defaultp>(1, 2, 3, 4)
    let m = Mat3x4<Float64, Defaultp>.fromMat(conv, src, Float64(1))
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
}

@Test
func testMat3x4FromMat6bMat2x3(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat2x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let m = Mat3x4<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(3))
    @Expect(m.c0.w, Float64(0))
    @Expect(m.c1.x, Float64(4))
    @Expect(m.c1.y, Float64(5))
    @Expect(m.c1.z, Float64(6))
    @Expect(m.c1.w, Float64(0))
    @Expect(m.c2.x, Float64(0))
    @Expect(m.c2.y, Float64(0))
    @Expect(m.c2.z, Float64(1))
    @Expect(m.c2.w, Float64(0))
}

@Test
func testMat3x4FromMat6bMat2x4(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat2x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let m = Mat3x4<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(3))
    @Expect(m.c0.w, Float64(4))
    @Expect(m.c1.x, Float64(5))
    @Expect(m.c1.y, Float64(6))
    @Expect(m.c1.z, Float64(7))
    @Expect(m.c1.w, Float64(8))
    @Expect(m.c2.x, Float64(0))
    @Expect(m.c2.y, Float64(0))
    @Expect(m.c2.z, Float64(1))
    @Expect(m.c2.w, Float64(0))
}

@Test
func testMat3x4FromMat6bMat3x2(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat3x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let m = Mat3x4<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(0))
    @Expect(m.c0.w, Float64(0))
    @Expect(m.c1.x, Float64(3))
    @Expect(m.c1.y, Float64(4))
    @Expect(m.c1.z, Float64(0))
    @Expect(m.c1.w, Float64(0))
    @Expect(m.c2.x, Float64(5))
    @Expect(m.c2.y, Float64(6))
    @Expect(m.c2.z, Float64(1))
    @Expect(m.c2.w, Float64(0))
}

@Test
func testMat3x4FromMat6bMat3x3(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat3x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9)
    let m = Mat3x4<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(3))
    @Expect(m.c0.w, Float64(0))
    @Expect(m.c1.x, Float64(4))
    @Expect(m.c1.y, Float64(5))
    @Expect(m.c1.z, Float64(6))
    @Expect(m.c1.w, Float64(0))
    @Expect(m.c2.x, Float64(7))
    @Expect(m.c2.y, Float64(8))
    @Expect(m.c2.z, Float64(9))
    @Expect(m.c2.w, Float64(0))
}

@Test
func testMat3x4FromMat6bMat4x2(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let m = Mat3x4<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(0))
    @Expect(m.c0.w, Float64(0))
    @Expect(m.c1.x, Float64(3))
    @Expect(m.c1.y, Float64(4))
    @Expect(m.c1.z, Float64(0))
    @Expect(m.c1.w, Float64(0))
    @Expect(m.c2.x, Float64(5))
    @Expect(m.c2.y, Float64(6))
    @Expect(m.c2.z, Float64(1))
    @Expect(m.c2.w, Float64(0))
}

@Test
func testMat3x4FromMat6bMat4x3(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat4x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let m = Mat3x4<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(3))
    @Expect(m.c0.w, Float64(0))
    @Expect(m.c1.x, Float64(4))
    @Expect(m.c1.y, Float64(5))
    @Expect(m.c1.z, Float64(6))
    @Expect(m.c1.w, Float64(0))
    @Expect(m.c2.x, Float64(7))
    @Expect(m.c2.y, Float64(8))
    @Expect(m.c2.z, Float64(9))
    @Expect(m.c2.w, Float64(0))
}

@Test
func testMat3x4FromMat6bMat4x4(): Unit {
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

@Test
func testMat3x4DiagonalFloat32(): Unit {
    let d = Mat3x4<Float32, Defaultp>.diagonal(Float32(7.5))
    @Expect(d.c0.x, Float32(7.5))
    @Expect(d.c0.y, Float32(0.0))
    @Expect(d.c0.z, Float32(0.0))
    @Expect(d.c0.w, Float32(0.0))
    @Expect(d.c1.x, Float32(0.0))
    @Expect(d.c1.y, Float32(7.5))
    @Expect(d.c1.z, Float32(0.0))
    @Expect(d.c1.w, Float32(0.0))
    @Expect(d.c2.x, Float32(0.0))
    @Expect(d.c2.y, Float32(0.0))
    @Expect(d.c2.z, Float32(7.5))
    @Expect(d.c2.w, Float32(0.0))
}

@Test
func testMat3x4DiagonalFloat64(): Unit {
    let d = Mat3x4<Float64, Defaultp>.diagonal(Float64(7.5))
    @Expect(d.c0.x, Float64(7.5))
    @Expect(d.c0.y, Float64(0.0))
    @Expect(d.c0.z, Float64(0.0))
    @Expect(d.c0.w, Float64(0.0))
    @Expect(d.c1.x, Float64(0.0))
    @Expect(d.c1.y, Float64(7.5))
    @Expect(d.c1.z, Float64(0.0))
    @Expect(d.c1.w, Float64(0.0))
    @Expect(d.c2.x, Float64(0.0))
    @Expect(d.c2.y, Float64(0.0))
    @Expect(d.c2.z, Float64(7.5))
    @Expect(d.c2.w, Float64(0.0))
}

@Test
func testMat3x4ColAccessFloat32(): Unit {
    let m = Mat3x4<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5))
    let c0 = Vec4<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5))
    let c1 = Vec4<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5))
    let c2 = Vec4<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5))
    @Expect(m.col(Int64(0)), c0)
    @Expect(m.col(Int64(1)), c1)
    @Expect(m.col(Int64(2)), c2)
}

@Test
func testMat3x4ColAccessFloat64(): Unit {
    let m = Mat3x4<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5))
    let c0 = Vec4<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5))
    let c1 = Vec4<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5))
    let c2 = Vec4<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5))
    @Expect(m.col(Int64(0)), c0)
    @Expect(m.col(Int64(1)), c1)
    @Expect(m.col(Int64(2)), c2)
}

@Test
func testMat3x4ScalarMulFloat32(): Unit {
    let m = Mat3x4<Float32, Defaultp>(Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0))
    let r = m * Float32(1.5)
    @Expect(r.c0.x, Float32(3.0))
    @Expect(r.c0.y, Float32(3.0))
    @Expect(r.c0.z, Float32(3.0))
    @Expect(r.c0.w, Float32(3.0))
    @Expect(r.c1.x, Float32(3.0))
    @Expect(r.c1.y, Float32(3.0))
    @Expect(r.c1.z, Float32(3.0))
    @Expect(r.c1.w, Float32(3.0))
    @Expect(r.c2.x, Float32(3.0))
    @Expect(r.c2.y, Float32(3.0))
    @Expect(r.c2.z, Float32(3.0))
    @Expect(r.c2.w, Float32(3.0))
}

@Test
func testMat3x4ScalarMulFloat64(): Unit {
    let m = Mat3x4<Float64, Defaultp>(Float64(2.0), Float64(2.0), Float64(2.0), Float64(2.0), Float64(2.0), Float64(2.0), Float64(2.0), Float64(2.0), Float64(2.0), Float64(2.0), Float64(2.0), Float64(2.0))
    let r = m * Float64(1.5)
    @Expect(r.c0.x, Float64(3.0))
    @Expect(r.c0.y, Float64(3.0))
    @Expect(r.c0.z, Float64(3.0))
    @Expect(r.c0.w, Float64(3.0))
    @Expect(r.c1.x, Float64(3.0))
    @Expect(r.c1.y, Float64(3.0))
    @Expect(r.c1.z, Float64(3.0))
    @Expect(r.c1.w, Float64(3.0))
    @Expect(r.c2.x, Float64(3.0))
    @Expect(r.c2.y, Float64(3.0))
    @Expect(r.c2.z, Float64(3.0))
    @Expect(r.c2.w, Float64(3.0))
}
