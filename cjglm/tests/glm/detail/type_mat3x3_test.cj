package glm.detail

import std.unittest.*
import std.unittest.testmacro.*

@Test
func testMat3x3ScalarInit(): Unit {
    let m = Mat3x3<Int64, Defaultp>(5)
    @Expect(m.c0.x, 5)
    @Expect(m.c0.y, 5)
    @Expect(m.c0.z, 5)
    @Expect(m.c1.x, 5)
    @Expect(m.c1.y, 5)
    @Expect(m.c1.z, 5)
    @Expect(m.c2.x, 5)
    @Expect(m.c2.y, 5)
    @Expect(m.c2.z, 5)
}

@Test
func testMat3x3ConstInitElementwise(): Unit {
    let m = Mat3x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9)
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
func testMat3x3ConstInitColumn(): Unit {
    let c0 = Vec3<Int64, Defaultp>(1, 2, 3)
    let c1 = Vec3<Int64, Defaultp>(4, 5, 6)
    let c2 = Vec3<Int64, Defaultp>(7, 8, 9)
    let m = Mat3x3<Int64, Defaultp>(c0, c1, c2)
    @Expect(m.c0, c0)
    @Expect(m.c1, c1)
    @Expect(m.c2, c2)
}

@Test
func testMat3x3Length(): Unit {
    @Expect(Mat3x3<Int64, Defaultp>.length(), 3)
}

@Test
func testMat3x3IndexAccess(): Unit {
    let m = Mat3x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9)
    @Expect(m[Int64(0)].x, 1)
    @Expect(m[Int64(0)].y, 2)
    @Expect(m[Int64(0)].z, 3)
    @Expect(m[Int64(1)].x, 4)
    @Expect(m[Int64(1)].y, 5)
    @Expect(m[Int64(1)].z, 6)
    @Expect(m[Int64(2)].x, 7)
    @Expect(m[Int64(2)].y, 8)
    @Expect(m[Int64(2)].z, 9)
}

@Test
func testMat3x3IndexMutate(): Unit {
    var m = Mat3x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9)
    let newCol0 = Vec3<Int64, Defaultp>(10, 20, 30)
    m[Int64(0)] = newCol0
    @Expect(m[Int64(0)].x, 10)
    @Expect(m[Int64(0)].y, 20)
    @Expect(m[Int64(0)].z, 30)
}

@Test
func testMat3x3ColAccess(): Unit {
    let m = Mat3x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9)
    @Expect(m.col(Int64(0)).x, 1)
    @Expect(m.col(Int64(0)).y, 2)
    @Expect(m.col(Int64(0)).z, 3)
    @Expect(m.col(Int64(1)).x, 4)
    @Expect(m.col(Int64(1)).y, 5)
    @Expect(m.col(Int64(1)).z, 6)
    @Expect(m.col(Int64(2)).x, 7)
    @Expect(m.col(Int64(2)).y, 8)
    @Expect(m.col(Int64(2)).z, 9)
}

@Test
func testMat3x3IndexOutOfBounds(): Unit {
    let m = Mat3x3<Int64, Defaultp>(5)
    try {
        let _ = m[Int64(3)]
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}

@Test
func testMat3x3NegativeIndex(): Unit {
    let m = Mat3x3<Int64, Defaultp>(5)
    try {
        let _ = m[Int64(-1)]
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}

@Test
func testMat3x3MutateThenRead(): Unit {
    var m = Mat3x3<Int64, Defaultp>(5)
    let newCol2 = Vec3<Int64, Defaultp>(7, 8, 9)
    m[Int64(2)] = newCol2
    @Expect(m.col(Int64(2)).x, 7)
    @Expect(m.col(Int64(2)).y, 8)
    @Expect(m.col(Int64(2)).z, 9)
}

@Test
func testMat3x3UnaryNegate(): Unit {
    let m = Mat3x3<Int64, Defaultp>(1, -2, 3, -4, 5, -6, 7, -8, 9)
    let n = -m
    @Expect(n.c0.x, -1)
    @Expect(n.c0.y, 2)
    @Expect(n.c0.z, -3)
    @Expect(n.c1.x, 4)
    @Expect(n.c1.y, -5)
    @Expect(n.c1.z, 6)
    @Expect(n.c2.x, -7)
    @Expect(n.c2.y, 8)
    @Expect(n.c2.z, -9)
}

@Test
func testMat3x3ScalarAdd(): Unit {
    let m = Mat3x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9)
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
}

@Test
func testMat3x3ScalarSub(): Unit {
    let m = Mat3x3<Int64, Defaultp>(10, 20, 30, 40, 50, 60, 70, 80, 90)
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
}

@Test
func testMat3x3ScalarMul(): Unit {
    let m = Mat3x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9)
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
}

@Test
func testMat3x3ScalarDiv(): Unit {
    let m = Mat3x3<Int64, Defaultp>(10, 20, 30, 40, 50, 60, 70, 80, 90)
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
}

@Test
func testMat3x3MatrixAdd(): Unit {
    let a = Mat3x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9)
    let b = Mat3x3<Int64, Defaultp>(9, 8, 7, 6, 5, 4, 3, 2, 1)
    let r = a + b
    @Expect(r.c0.x, 10)
    @Expect(r.c0.y, 10)
    @Expect(r.c0.z, 10)
    @Expect(r.c1.x, 10)
    @Expect(r.c1.y, 10)
    @Expect(r.c1.z, 10)
    @Expect(r.c2.x, 10)
    @Expect(r.c2.y, 10)
    @Expect(r.c2.z, 10)
}

@Test
func testMat3x3MatrixSub(): Unit {
    let a = Mat3x3<Int64, Defaultp>(10, 20, 30, 40, 50, 60, 70, 80, 90)
    let b = Mat3x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9)
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
}

@Test
func testMat3x3MulMat2x3(): Unit {
    let a = Mat3x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9)
    let b = Mat2x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let r = a * b
    @Expect(r.c0.x, 1*1 + 4*2 + 7*3)
    @Expect(r.c0.y, 2*1 + 5*2 + 8*3)
    @Expect(r.c0.z, 3*1 + 6*2 + 9*3)
    @Expect(r.c1.x, 1*4 + 4*5 + 7*6)
    @Expect(r.c1.y, 2*4 + 5*5 + 8*6)
    @Expect(r.c1.z, 3*4 + 6*5 + 9*6)
}

@Test
func testMat3x3MulMat3x3(): Unit {
    let a = Mat3x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9)
    let b = Mat3x3<Int64, Defaultp>(9, 8, 7, 6, 5, 4, 3, 2, 1)
    let r = a * b
    @Expect(r.c0.x, 1*9 + 4*8 + 7*7)
    @Expect(r.c0.y, 2*9 + 5*8 + 8*7)
    @Expect(r.c0.z, 3*9 + 6*8 + 9*7)
    @Expect(r.c1.x, 1*6 + 4*5 + 7*4)
    @Expect(r.c1.y, 2*6 + 5*5 + 8*4)
    @Expect(r.c1.z, 3*6 + 6*5 + 9*4)
    @Expect(r.c2.x, 1*3 + 4*2 + 7*1)
    @Expect(r.c2.y, 2*3 + 5*2 + 8*1)
    @Expect(r.c2.z, 3*3 + 6*2 + 9*1)
}

@Test
func testMat3x3MulMat4x3(): Unit {
    let a = Mat3x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9)
    let b = Mat4x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let r = a * b
    @Expect(r.c0.x, 1*1 + 4*2 + 7*3)
    @Expect(r.c0.y, 2*1 + 5*2 + 8*3)
    @Expect(r.c0.z, 3*1 + 6*2 + 9*3)
    @Expect(r.c1.x, 1*4 + 4*5 + 7*6)
    @Expect(r.c1.y, 2*4 + 5*5 + 8*6)
    @Expect(r.c1.z, 3*4 + 6*5 + 9*6)
    @Expect(r.c2.x, 1*7 + 4*8 + 7*9)
    @Expect(r.c2.y, 2*7 + 5*8 + 8*9)
    @Expect(r.c2.z, 3*7 + 6*8 + 9*9)
    @Expect(r.c3.x, 1*10 + 4*11 + 7*12)
    @Expect(r.c3.y, 2*10 + 5*11 + 8*12)
    @Expect(r.c3.z, 3*10 + 6*11 + 9*12)
}

@Test
func testMat3x3MatrixDivStub(): Unit {
    let a = Mat3x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9)
    let b = Mat3x3<Int64, Defaultp>(9, 8, 7, 6, 5, 4, 3, 2, 1)
    try {
        let _ = a / b
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}

@Test
func testMat3x3MulVec3(): Unit {
    let m = Mat3x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9)
    let v = Vec3<Int64, Defaultp>(5, 6, 7)
    let r = m * v
    @Expect(r.x, 1*5 + 4*6 + 7*7)
    @Expect(r.y, 2*5 + 5*6 + 8*7)
    @Expect(r.z, 3*5 + 6*6 + 9*7)
}

@Test
func testMat3x3Diagonal(): Unit {
    let d = Mat3x3<Int64, Defaultp>.diagonal(Int64(7))
    @Expect(d.c0.x, 7)
    @Expect(d.c0.y, 0)
    @Expect(d.c0.z, 0)
    @Expect(d.c1.x, 0)
    @Expect(d.c1.y, 7)
    @Expect(d.c1.z, 0)
    @Expect(d.c2.x, 0)
    @Expect(d.c2.y, 0)
    @Expect(d.c2.z, 7)
}

@Test
func testMat3x3Identity(): Unit {
    let id = Mat3x3<Int64, Defaultp>.identity(Int64(1))
    @Expect(id.c0.x, 1)
    @Expect(id.c0.y, 0)
    @Expect(id.c0.z, 0)
    @Expect(id.c1.x, 0)
    @Expect(id.c1.y, 1)
    @Expect(id.c1.z, 0)
    @Expect(id.c2.x, 0)
    @Expect(id.c2.y, 0)
    @Expect(id.c2.z, 1)
}

@Test
func testMat3x3FromParts(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let m = Mat3x3<Float64, Defaultp>.fromParts(conv, Int64(1), Int64(2), Int64(3), Int64(4), Int64(5), Int64(6), Int64(7), Int64(8), Int64(9))
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
func testMat3x3FromColumns(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let c0 = Vec3<Int64, Defaultp>(1, 2, 3)
    let c1 = Vec3<Int64, Defaultp>(4, 5, 6)
    let c2 = Vec3<Int64, Defaultp>(7, 8, 9)
    let m = Mat3x3<Float64, Defaultp>.fromColumns(conv, c0, c1, c2)
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
func testMat3x3FromMat7(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat3x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9)
    let m = Mat3x3<Float64, Defaultp>.fromMat(conv, src)
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
func testMat3x3FromMat6aMat2x2(): Unit {
    let src = Mat2x2<Int64, Defaultp>(1, 2, 3, 4)
    let m = Mat3x3<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 0)
    @Expect(m.c1.x, 3)
    @Expect(m.c1.y, 4)
    @Expect(m.c1.z, 0)
    @Expect(m.c2.x, 0)
    @Expect(m.c2.y, 0)
    @Expect(m.c2.z, 1)
}

@Test
func testMat3x3FromMat6aMat2x3(): Unit {
    let src = Mat2x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let m = Mat3x3<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 3)
    @Expect(m.c1.x, 4)
    @Expect(m.c1.y, 5)
    @Expect(m.c1.z, 6)
    @Expect(m.c2.x, 0)
    @Expect(m.c2.y, 0)
    @Expect(m.c2.z, 1)
}

@Test
func testMat3x3FromMat6aMat2x4(): Unit {
    let src = Mat2x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let m = Mat3x3<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 3)
    @Expect(m.c1.x, 5)
    @Expect(m.c1.y, 6)
    @Expect(m.c1.z, 7)
    @Expect(m.c2.x, 0)
    @Expect(m.c2.y, 0)
    @Expect(m.c2.z, 1)
}

@Test
func testMat3x3FromMat6aMat3x2(): Unit {
    let src = Mat3x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let m = Mat3x3<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 0)
    @Expect(m.c1.x, 3)
    @Expect(m.c1.y, 4)
    @Expect(m.c1.z, 0)
    @Expect(m.c2.x, 5)
    @Expect(m.c2.y, 6)
    @Expect(m.c2.z, 1)
}

@Test
func testMat3x3FromMat6aMat3x4(): Unit {
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
func testMat3x3FromMat6aMat4x2(): Unit {
    let src = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let m = Mat3x3<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c0.z, 0)
    @Expect(m.c1.x, 3)
    @Expect(m.c1.y, 4)
    @Expect(m.c1.z, 0)
    @Expect(m.c2.x, 5)
    @Expect(m.c2.y, 6)
    @Expect(m.c2.z, 1)
}

@Test
func testMat3x3FromMat6aMat4x3(): Unit {
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
func testMat3x3FromMat6aMat4x4(): Unit {
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
func testMat3x3FromMat6bMat2x2(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat2x2<Int64, Defaultp>(1, 2, 3, 4)
    let m = Mat3x3<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(0))
    @Expect(m.c1.x, Float64(3))
    @Expect(m.c1.y, Float64(4))
    @Expect(m.c1.z, Float64(0))
    @Expect(m.c2.x, Float64(0))
    @Expect(m.c2.y, Float64(0))
    @Expect(m.c2.z, Float64(1))
}

@Test
func testMat3x3FromMat6bMat2x3(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat2x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let m = Mat3x3<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(3))
    @Expect(m.c1.x, Float64(4))
    @Expect(m.c1.y, Float64(5))
    @Expect(m.c1.z, Float64(6))
    @Expect(m.c2.x, Float64(0))
    @Expect(m.c2.y, Float64(0))
    @Expect(m.c2.z, Float64(1))
}

@Test
func testMat3x3FromMat6bMat2x4(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat2x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let m = Mat3x3<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(3))
    @Expect(m.c1.x, Float64(5))
    @Expect(m.c1.y, Float64(6))
    @Expect(m.c1.z, Float64(7))
    @Expect(m.c2.x, Float64(0))
    @Expect(m.c2.y, Float64(0))
    @Expect(m.c2.z, Float64(1))
}

@Test
func testMat3x3FromMat6bMat3x2(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat3x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let m = Mat3x3<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(0))
    @Expect(m.c1.x, Float64(3))
    @Expect(m.c1.y, Float64(4))
    @Expect(m.c1.z, Float64(0))
    @Expect(m.c2.x, Float64(5))
    @Expect(m.c2.y, Float64(6))
    @Expect(m.c2.z, Float64(1))
}

@Test
func testMat3x3FromMat6bMat3x4(): Unit {
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
func testMat3x3FromMat6bMat4x2(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let m = Mat3x3<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c0.z, Float64(0))
    @Expect(m.c1.x, Float64(3))
    @Expect(m.c1.y, Float64(4))
    @Expect(m.c1.z, Float64(0))
    @Expect(m.c2.x, Float64(5))
    @Expect(m.c2.y, Float64(6))
    @Expect(m.c2.z, Float64(1))
}

@Test
func testMat3x3FromMat6bMat4x3(): Unit {
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
func testMat3x3FromMat6bMat4x4(): Unit {
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

@Test
func testMat3x3DiagonalFloat32(): Unit {
    let d = Mat3x3<Float32, Defaultp>.diagonal(Float32(7.5))
    @Expect(d.c0.x, Float32(7.5))
    @Expect(d.c0.y, Float32(0.0))
    @Expect(d.c0.z, Float32(0.0))
    @Expect(d.c1.x, Float32(0.0))
    @Expect(d.c1.y, Float32(7.5))
    @Expect(d.c1.z, Float32(0.0))
    @Expect(d.c2.x, Float32(0.0))
    @Expect(d.c2.y, Float32(0.0))
    @Expect(d.c2.z, Float32(7.5))
}

@Test
func testMat3x3DiagonalFloat64(): Unit {
    let d = Mat3x3<Float64, Defaultp>.diagonal(Float64(7.5))
    @Expect(d.c0.x, Float64(7.5))
    @Expect(d.c0.y, Float64(0.0))
    @Expect(d.c0.z, Float64(0.0))
    @Expect(d.c1.x, Float64(0.0))
    @Expect(d.c1.y, Float64(7.5))
    @Expect(d.c1.z, Float64(0.0))
    @Expect(d.c2.x, Float64(0.0))
    @Expect(d.c2.y, Float64(0.0))
    @Expect(d.c2.z, Float64(7.5))
}

@Test
func testMat3x3ColAccessFloat32(): Unit {
    let m = Mat3x3<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5))
    let c0 = Vec3<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5))
    let c1 = Vec3<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5))
    let c2 = Vec3<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5))
    @Expect(m.col(Int64(0)), c0)
    @Expect(m.col(Int64(1)), c1)
    @Expect(m.col(Int64(2)), c2)
}

@Test
func testMat3x3ColAccessFloat64(): Unit {
    let m = Mat3x3<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5))
    let c0 = Vec3<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5))
    let c1 = Vec3<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5))
    let c2 = Vec3<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5))
    @Expect(m.col(Int64(0)), c0)
    @Expect(m.col(Int64(1)), c1)
    @Expect(m.col(Int64(2)), c2)
}

@Test
func testMat3x3ScalarMulFloat32(): Unit {
    let m = Mat3x3<Float32, Defaultp>(Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0))
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
}

@Test
func testMat3x3ScalarMulFloat64(): Unit {
    let m = Mat3x3<Float64, Defaultp>(Float64(2.0), Float64(2.0), Float64(2.0), Float64(2.0), Float64(2.0), Float64(2.0), Float64(2.0), Float64(2.0), Float64(2.0))
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
}

@Test
func testMat3x3ColOutOfBounds(): Unit {
    let m = Mat3x3<Int64, Defaultp>(5)
    try {
        let _ = m.col(Int64(3))
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}

@Test
func testMat3x3ColNegative(): Unit {
    let m = Mat3x3<Int64, Defaultp>(5)
    try {
        let _ = m.col(Int64(-1))
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}
