package glm.detail

import std.unittest.*
import std.unittest.testmacro.*

@Test
func testMat4x2ScalarInit(): Unit {
    let m = Mat4x2<Int64, Defaultp>(5)
    @Expect(m.c0.x, 5)
    @Expect(m.c0.y, 5)
    @Expect(m.c1.x, 5)
    @Expect(m.c1.y, 5)
    @Expect(m.c2.x, 5)
    @Expect(m.c2.y, 5)
    @Expect(m.c3.x, 5)
    @Expect(m.c3.y, 5)
}

@Test
func testMat4x2ConstInitElementwise(): Unit {
    let m = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c1.x, 3)
    @Expect(m.c1.y, 4)
    @Expect(m.c2.x, 5)
    @Expect(m.c2.y, 6)
    @Expect(m.c3.x, 7)
    @Expect(m.c3.y, 8)
}

@Test
func testMat4x2ConstInitColumn(): Unit {
    let c0 = Vec2<Int64, Defaultp>(1, 2)
    let c1 = Vec2<Int64, Defaultp>(3, 4)
    let c2 = Vec2<Int64, Defaultp>(5, 6)
    let c3 = Vec2<Int64, Defaultp>(7, 8)
    let m = Mat4x2<Int64, Defaultp>(c0, c1, c2, c3)
    @Expect(m.c0, c0)
    @Expect(m.c1, c1)
    @Expect(m.c2, c2)
    @Expect(m.c3, c3)
}

@Test
func testMat4x2Length(): Unit {
    @Expect(Mat4x2<Int64, Defaultp>.length(), 4)
}

@Test
func testMat4x2IndexAccess(): Unit {
    let m = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    @Expect(m[Int64(0)].x, 1)
    @Expect(m[Int64(0)].y, 2)
    @Expect(m[Int64(1)].x, 3)
    @Expect(m[Int64(1)].y, 4)
    @Expect(m[Int64(2)].x, 5)
    @Expect(m[Int64(2)].y, 6)
    @Expect(m[Int64(3)].x, 7)
    @Expect(m[Int64(3)].y, 8)
}

@Test
func testMat4x2IndexMutate(): Unit {
    var m = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let newCol3 = Vec2<Int64, Defaultp>(10, 20)
    m[Int64(3)] = newCol3
    @Expect(m[Int64(3)].x, 10)
    @Expect(m[Int64(3)].y, 20)
}

@Test
func testMat4x2ColAccess(): Unit {
    let m = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    @Expect(m.col(Int64(0)).x, 1)
    @Expect(m.col(Int64(0)).y, 2)
    @Expect(m.col(Int64(1)).x, 3)
    @Expect(m.col(Int64(1)).y, 4)
    @Expect(m.col(Int64(2)).x, 5)
    @Expect(m.col(Int64(2)).y, 6)
    @Expect(m.col(Int64(3)).x, 7)
    @Expect(m.col(Int64(3)).y, 8)
}

@Test
func testMat4x2ColOutOfBounds(): Unit {
    let m = Mat4x2<Int64, Defaultp>(5)
    try {
        let _ = m.col(Int64(4))
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}

@Test
func testMat4x2ColNegative(): Unit {
    let m = Mat4x2<Int64, Defaultp>(5)
    try {
        let _ = m.col(Int64(-1))
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}

@Test
func testMat4x2IndexOutOfBounds(): Unit {
    let m = Mat4x2<Int64, Defaultp>(5)
    try {
        let _ = m[Int64(4)]
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}

@Test
func testMat4x2NegativeIndex(): Unit {
    let m = Mat4x2<Int64, Defaultp>(5)
    try {
        let _ = m[Int64(-1)]
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}

@Test
func testMat4x2MutateThenRead(): Unit {
    var m = Mat4x2<Int64, Defaultp>(5)
    let newCol2 = Vec2<Int64, Defaultp>(7, 8)
    m[Int64(2)] = newCol2
    @Expect(m.col(Int64(2)).x, 7)
    @Expect(m.col(Int64(2)).y, 8)
}

@Test
func testMat4x2UnaryNegate(): Unit {
    let m = Mat4x2<Int64, Defaultp>(1, -2, -3, 4, 5, -6, -7, 8)
    let n = -m
    @Expect(n.c0.x, -1)
    @Expect(n.c0.y, 2)
    @Expect(n.c1.x, 3)
    @Expect(n.c1.y, -4)
    @Expect(n.c2.x, -5)
    @Expect(n.c2.y, 6)
    @Expect(n.c3.x, 7)
    @Expect(n.c3.y, -8)
}

@Test
func testMat4x2ScalarAdd(): Unit {
    let m = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let r = m + Int64(10)
    @Expect(r.c0.x, 11)
    @Expect(r.c0.y, 12)
    @Expect(r.c1.x, 13)
    @Expect(r.c1.y, 14)
    @Expect(r.c2.x, 15)
    @Expect(r.c2.y, 16)
    @Expect(r.c3.x, 17)
    @Expect(r.c3.y, 18)
}

@Test
func testMat4x2ScalarSub(): Unit {
    let m = Mat4x2<Int64, Defaultp>(10, 20, 30, 40, 50, 60, 70, 80)
    let r = m - Int64(5)
    @Expect(r.c0.x, 5)
    @Expect(r.c0.y, 15)
    @Expect(r.c1.x, 25)
    @Expect(r.c1.y, 35)
    @Expect(r.c2.x, 45)
    @Expect(r.c2.y, 55)
    @Expect(r.c3.x, 65)
    @Expect(r.c3.y, 75)
}

@Test
func testMat4x2ScalarMul(): Unit {
    let m = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let r = m * Int64(3)
    @Expect(r.c0.x, 3)
    @Expect(r.c0.y, 6)
    @Expect(r.c1.x, 9)
    @Expect(r.c1.y, 12)
    @Expect(r.c2.x, 15)
    @Expect(r.c2.y, 18)
    @Expect(r.c3.x, 21)
    @Expect(r.c3.y, 24)
}

@Test
func testMat4x2ScalarDiv(): Unit {
    let m = Mat4x2<Int64, Defaultp>(10, 20, 30, 40, 50, 60, 70, 80)
    let r = m / Int64(2)
    @Expect(r.c0.x, 5)
    @Expect(r.c0.y, 10)
    @Expect(r.c1.x, 15)
    @Expect(r.c1.y, 20)
    @Expect(r.c2.x, 25)
    @Expect(r.c2.y, 30)
    @Expect(r.c3.x, 35)
    @Expect(r.c3.y, 40)
}

@Test
func testMat4x2MatrixAdd(): Unit {
    let a = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let b = Mat4x2<Int64, Defaultp>(9, 10, 11, 12, 13, 14, 15, 16)
    let r = a + b
    @Expect(r.c0.x, 10)
    @Expect(r.c0.y, 12)
    @Expect(r.c1.x, 14)
    @Expect(r.c1.y, 16)
    @Expect(r.c2.x, 18)
    @Expect(r.c2.y, 20)
    @Expect(r.c3.x, 22)
    @Expect(r.c3.y, 24)
}

@Test
func testMat4x2MatrixSub(): Unit {
    let a = Mat4x2<Int64, Defaultp>(10, 20, 30, 40, 50, 60, 70, 80)
    let b = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let r = a - b
    @Expect(r.c0.x, 9)
    @Expect(r.c0.y, 18)
    @Expect(r.c1.x, 27)
    @Expect(r.c1.y, 36)
    @Expect(r.c2.x, 45)
    @Expect(r.c2.y, 54)
    @Expect(r.c3.x, 63)
    @Expect(r.c3.y, 72)
}

@Test
func testMat4x2MulMat2x4(): Unit {
    let a = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let b = Mat2x4<Int64, Defaultp>(9, 10, 11, 12, 13, 14, 15, 16)
    let r = a * b
    @Expect(r.c0.x, 1*9 + 3*10 + 5*11 + 7*12)
    @Expect(r.c0.y, 2*9 + 4*10 + 6*11 + 8*12)
    @Expect(r.c1.x, 1*13 + 3*14 + 5*15 + 7*16)
    @Expect(r.c1.y, 2*13 + 4*14 + 6*15 + 8*16)
}

@Test
func testMat4x2MulMat3x4(): Unit {
    let a = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let b = Mat3x4<Int64, Defaultp>(9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20)
    let r = a * b
    @Expect(r.c0.x, 1*9 + 3*10 + 5*11 + 7*12)
    @Expect(r.c0.y, 2*9 + 4*10 + 6*11 + 8*12)
    @Expect(r.c1.x, 1*13 + 3*14 + 5*15 + 7*16)
    @Expect(r.c1.y, 2*13 + 4*14 + 6*15 + 8*16)
    @Expect(r.c2.x, 1*17 + 3*18 + 5*19 + 7*20)
    @Expect(r.c2.y, 2*17 + 4*18 + 6*19 + 8*20)
}

@Test
func testMat4x2MulMat4x4(): Unit {
    let a = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let b = Mat4x4<Int64, Defaultp>(9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24)
    let r = a * b
    @Expect(r.c0.x, 1*9 + 3*10 + 5*11 + 7*12)
    @Expect(r.c0.y, 2*9 + 4*10 + 6*11 + 8*12)
    @Expect(r.c1.x, 1*13 + 3*14 + 5*15 + 7*16)
    @Expect(r.c1.y, 2*13 + 4*14 + 6*15 + 8*16)
    @Expect(r.c2.x, 1*17 + 3*18 + 5*19 + 7*20)
    @Expect(r.c2.y, 2*17 + 4*18 + 6*19 + 8*20)
    @Expect(r.c3.x, 1*21 + 3*22 + 5*23 + 7*24)
    @Expect(r.c3.y, 2*21 + 4*22 + 6*23 + 8*24)
}

@Test
func testMat4x2MulVec4(): Unit {
    let m = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let v = Vec4<Int64, Defaultp>(9, 10, 11, 12)
    let r = m * v
    @Expect(r.x, 1*9 + 3*10 + 5*11 + 7*12)
    @Expect(r.y, 2*9 + 4*10 + 6*11 + 8*12)
}

@Test
func testMat4x2Diagonal(): Unit {
    let d = Mat4x2<Int64, Defaultp>.diagonal(Int64(7))
    @Expect(d.c0.x, 7)
    @Expect(d.c0.y, 0)
    @Expect(d.c1.x, 0)
    @Expect(d.c1.y, 7)
    @Expect(d.c2.x, 0)
    @Expect(d.c2.y, 0)
    @Expect(d.c3.x, 0)
    @Expect(d.c3.y, 0)
}

@Test
func testMat4x2Identity(): Unit {
    let id = Mat4x2<Int64, Defaultp>.identity(Int64(1))
    @Expect(id.c0.x, 1)
    @Expect(id.c0.y, 0)
    @Expect(id.c1.x, 0)
    @Expect(id.c1.y, 1)
    @Expect(id.c2.x, 0)
    @Expect(id.c2.y, 0)
    @Expect(id.c3.x, 0)
    @Expect(id.c3.y, 0)
}

@Test
func testMat4x2FromParts(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let m = Mat4x2<Float64, Defaultp>.fromParts(conv, Int64(1), Int64(2), Int64(3), Int64(4), Int64(5), Int64(6), Int64(7), Int64(8))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c1.x, Float64(3))
    @Expect(m.c1.y, Float64(4))
    @Expect(m.c2.x, Float64(5))
    @Expect(m.c2.y, Float64(6))
    @Expect(m.c3.x, Float64(7))
    @Expect(m.c3.y, Float64(8))
}

@Test
func testMat4x2FromColumns(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let c0 = Vec2<Int64, Defaultp>(1, 2)
    let c1 = Vec2<Int64, Defaultp>(3, 4)
    let c2 = Vec2<Int64, Defaultp>(5, 6)
    let c3 = Vec2<Int64, Defaultp>(7, 8)
    let m = Mat4x2<Float64, Defaultp>.fromColumns(conv, c0, c1, c2, c3)
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c1.x, Float64(3))
    @Expect(m.c1.y, Float64(4))
    @Expect(m.c2.x, Float64(5))
    @Expect(m.c2.y, Float64(6))
    @Expect(m.c3.x, Float64(7))
    @Expect(m.c3.y, Float64(8))
}

@Test
func testMat4x2FromMat7(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let m = Mat4x2<Float64, Defaultp>.fromMat(conv, src)
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c1.x, Float64(3))
    @Expect(m.c1.y, Float64(4))
    @Expect(m.c2.x, Float64(5))
    @Expect(m.c2.y, Float64(6))
    @Expect(m.c3.x, Float64(7))
    @Expect(m.c3.y, Float64(8))
}

@Test
func testMat4x2FromMat6aMat2x2(): Unit {
    let src = Mat2x2<Int64, Defaultp>(1, 2, 3, 4)
    let m = Mat4x2<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c1.x, 3)
    @Expect(m.c1.y, 4)
    @Expect(m.c2.x, 0)
    @Expect(m.c2.y, 0)
    @Expect(m.c3.x, 0)
    @Expect(m.c3.y, 0)
}

@Test
func testMat4x2FromMat6aMat2x3(): Unit {
    let src = Mat2x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let m = Mat4x2<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c1.x, 4)
    @Expect(m.c1.y, 5)
    @Expect(m.c2.x, 0)
    @Expect(m.c2.y, 0)
    @Expect(m.c3.x, 0)
    @Expect(m.c3.y, 0)
}

@Test
func testMat4x2FromMat6aMat2x4(): Unit {
    let src = Mat2x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let m = Mat4x2<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c1.x, 5)
    @Expect(m.c1.y, 6)
    @Expect(m.c2.x, 0)
    @Expect(m.c2.y, 0)
    @Expect(m.c3.x, 0)
    @Expect(m.c3.y, 0)
}

@Test
func testMat4x2FromMat6aMat3x2(): Unit {
    let src = Mat3x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let m = Mat4x2<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c1.x, 3)
    @Expect(m.c1.y, 4)
    @Expect(m.c2.x, 5)
    @Expect(m.c2.y, 6)
    @Expect(m.c3.x, 0)
    @Expect(m.c3.y, 0)
}

@Test
func testMat4x2FromMat6aMat3x3(): Unit {
    let src = Mat3x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9)
    let m = Mat4x2<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c1.x, 4)
    @Expect(m.c1.y, 5)
    @Expect(m.c2.x, 7)
    @Expect(m.c2.y, 8)
    @Expect(m.c3.x, 0)
    @Expect(m.c3.y, 0)
}

@Test
func testMat4x2FromMat6aMat3x4(): Unit {
    let src = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let m = Mat4x2<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c1.x, 5)
    @Expect(m.c1.y, 6)
    @Expect(m.c2.x, 9)
    @Expect(m.c2.y, 10)
    @Expect(m.c3.x, 0)
    @Expect(m.c3.y, 0)
}

@Test
func testMat4x2FromMat6aMat4x3(): Unit {
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
func testMat4x2FromMat6aMat4x4(): Unit {
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
func testMat4x2FromMat6bMat2x2(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat2x2<Int64, Defaultp>(1, 2, 3, 4)
    let m = Mat4x2<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c1.x, Float64(3))
    @Expect(m.c1.y, Float64(4))
    @Expect(m.c2.x, Float64(0))
    @Expect(m.c2.y, Float64(0))
    @Expect(m.c3.x, Float64(0))
    @Expect(m.c3.y, Float64(0))
}

@Test
func testMat4x2FromMat6bMat2x3(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat2x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let m = Mat4x2<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c1.x, Float64(4))
    @Expect(m.c1.y, Float64(5))
    @Expect(m.c2.x, Float64(0))
    @Expect(m.c2.y, Float64(0))
    @Expect(m.c3.x, Float64(0))
    @Expect(m.c3.y, Float64(0))
}

@Test
func testMat4x2FromMat6bMat2x4(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat2x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let m = Mat4x2<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c1.x, Float64(5))
    @Expect(m.c1.y, Float64(6))
    @Expect(m.c2.x, Float64(0))
    @Expect(m.c2.y, Float64(0))
    @Expect(m.c3.x, Float64(0))
    @Expect(m.c3.y, Float64(0))
}

@Test
func testMat4x2FromMat6bMat3x2(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat3x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let m = Mat4x2<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c1.x, Float64(3))
    @Expect(m.c1.y, Float64(4))
    @Expect(m.c2.x, Float64(5))
    @Expect(m.c2.y, Float64(6))
    @Expect(m.c3.x, Float64(0))
    @Expect(m.c3.y, Float64(0))
}

@Test
func testMat4x2FromMat6bMat3x3(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat3x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9)
    let m = Mat4x2<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c1.x, Float64(4))
    @Expect(m.c1.y, Float64(5))
    @Expect(m.c2.x, Float64(7))
    @Expect(m.c2.y, Float64(8))
    @Expect(m.c3.x, Float64(0))
    @Expect(m.c3.y, Float64(0))
}

@Test
func testMat4x2FromMat6bMat3x4(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let m = Mat4x2<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c1.x, Float64(5))
    @Expect(m.c1.y, Float64(6))
    @Expect(m.c2.x, Float64(9))
    @Expect(m.c2.y, Float64(10))
    @Expect(m.c3.x, Float64(0))
    @Expect(m.c3.y, Float64(0))
}

@Test
func testMat4x2FromMat6bMat4x3(): Unit {
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
func testMat4x2FromMat6bMat4x4(): Unit {
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

@Test
func testMat4x2DiagonalFloat32(): Unit {
    let d = Mat4x2<Float32, Defaultp>.diagonal(Float32(7.5))
    @Expect(d.c0.x, Float32(7.5))
    @Expect(d.c0.y, Float32(0.0))
    @Expect(d.c1.x, Float32(0.0))
    @Expect(d.c1.y, Float32(7.5))
    @Expect(d.c2.x, Float32(0.0))
    @Expect(d.c2.y, Float32(0.0))
    @Expect(d.c3.x, Float32(0.0))
    @Expect(d.c3.y, Float32(0.0))
}

@Test
func testMat4x2DiagonalFloat64(): Unit {
    let d = Mat4x2<Float64, Defaultp>.diagonal(Float64(7.5))
    @Expect(d.c0.x, Float64(7.5))
    @Expect(d.c0.y, Float64(0.0))
    @Expect(d.c1.x, Float64(0.0))
    @Expect(d.c1.y, Float64(7.5))
    @Expect(d.c2.x, Float64(0.0))
    @Expect(d.c2.y, Float64(0.0))
    @Expect(d.c3.x, Float64(0.0))
    @Expect(d.c3.y, Float64(0.0))
}

@Test
func testMat4x2ColAccessFloat32(): Unit {
    let m = Mat4x2<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5))
    let c0 = Vec2<Float32, Defaultp>(Float32(1.5), Float32(1.5))
    let c1 = Vec2<Float32, Defaultp>(Float32(1.5), Float32(1.5))
    let c2 = Vec2<Float32, Defaultp>(Float32(1.5), Float32(1.5))
    let c3 = Vec2<Float32, Defaultp>(Float32(1.5), Float32(1.5))
    @Expect(m.col(Int64(0)), c0)
    @Expect(m.col(Int64(1)), c1)
    @Expect(m.col(Int64(2)), c2)
    @Expect(m.col(Int64(3)), c3)
}

@Test
func testMat4x2ColAccessFloat64(): Unit {
    let m = Mat4x2<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5))
    let c0 = Vec2<Float64, Defaultp>(Float64(2.5), Float64(2.5))
    let c1 = Vec2<Float64, Defaultp>(Float64(2.5), Float64(2.5))
    let c2 = Vec2<Float64, Defaultp>(Float64(2.5), Float64(2.5))
    let c3 = Vec2<Float64, Defaultp>(Float64(2.5), Float64(2.5))
    @Expect(m.col(Int64(0)), c0)
    @Expect(m.col(Int64(1)), c1)
    @Expect(m.col(Int64(2)), c2)
    @Expect(m.col(Int64(3)), c3)
}

@Test
func testMat4x2ScalarMulFloat32(): Unit {
    let m = Mat4x2<Float32, Defaultp>(Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0))
    let r = m * Float32(1.5)
    @Expect(r.c0.x, Float32(3.0))
    @Expect(r.c0.y, Float32(3.0))
    @Expect(r.c1.x, Float32(3.0))
    @Expect(r.c1.y, Float32(3.0))
    @Expect(r.c2.x, Float32(3.0))
    @Expect(r.c2.y, Float32(3.0))
    @Expect(r.c3.x, Float32(3.0))
    @Expect(r.c3.y, Float32(3.0))
}

@Test
func testMat4x2ScalarMulFloat64(): Unit {
    let m = Mat4x2<Float64, Defaultp>(Float64(2.0), Float64(2.0), Float64(2.0), Float64(2.0), Float64(2.0), Float64(2.0), Float64(2.0), Float64(2.0))
    let r = m * Float64(1.5)
    @Expect(r.c0.x, Float64(3.0))
    @Expect(r.c0.y, Float64(3.0))
    @Expect(r.c1.x, Float64(3.0))
    @Expect(r.c1.y, Float64(3.0))
    @Expect(r.c2.x, Float64(3.0))
    @Expect(r.c2.y, Float64(3.0))
    @Expect(r.c3.x, Float64(3.0))
    @Expect(r.c3.y, Float64(3.0))
}
