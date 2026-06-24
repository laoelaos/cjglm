package glm.detail

import std.unittest.*
import std.unittest.testmacro.*

@Test
func testMat2x2ScalarInit(): Unit {
    let m = Mat2x2<Int64, Defaultp>(5)
    @Expect(m.c0.x, 5)
    @Expect(m.c0.y, 5)
    @Expect(m.c1.x, 5)
    @Expect(m.c1.y, 5)
}

@Test
func testMat2x2ConstInitElementwise(): Unit {
    let m = Mat2x2<Int64, Defaultp>(1, 2, 3, 4)
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c1.x, 3)
    @Expect(m.c1.y, 4)
}

@Test
func testMat2x2ConstInitColumn(): Unit {
    let c0 = Vec2<Int64, Defaultp>(1, 2)
    let c1 = Vec2<Int64, Defaultp>(3, 4)
    let m = Mat2x2<Int64, Defaultp>(c0, c1)
    @Expect(m.c0, c0)
    @Expect(m.c1, c1)
}

@Test
func testMat2x2Length(): Unit {
    @Expect(Mat2x2<Int64, Defaultp>.length(), 2)
}

@Test
func testMat2x2IndexAccess(): Unit {
    let m = Mat2x2<Int64, Defaultp>(1, 2, 3, 4)
    @Expect(m[Int64(0)].x, 1)
    @Expect(m[Int64(0)].y, 2)
    @Expect(m[Int64(1)].x, 3)
    @Expect(m[Int64(1)].y, 4)
}

@Test
func testMat2x2IndexMutate(): Unit {
    var m = Mat2x2<Int64, Defaultp>(1, 2, 3, 4)
    let newCol1 = Vec2<Int64, Defaultp>(10, 20)
    m[Int64(1)] = newCol1
    @Expect(m[Int64(1)].x, 10)
    @Expect(m[Int64(1)].y, 20)
}

@Test
func testMat2x2ColAccess(): Unit {
    let m = Mat2x2<Int64, Defaultp>(1, 2, 3, 4)
    @Expect(m.col(Int64(0)).x, 1)
    @Expect(m.col(Int64(0)).y, 2)
    @Expect(m.col(Int64(1)).x, 3)
    @Expect(m.col(Int64(1)).y, 4)
}

@Test
func testMat2x2IndexOutOfBounds(): Unit {
    let m = Mat2x2<Int64, Defaultp>(5)
    try {
        let _ = m[Int64(2)]
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}

@Test
func testMat2x2NegativeIndex(): Unit {
    let m = Mat2x2<Int64, Defaultp>(5)
    try {
        let _ = m[Int64(-1)]
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}

@Test
func testMat2x2ColOutOfBounds(): Unit {
    let m = Mat2x2<Int64, Defaultp>(5)
    try {
        let _ = m.col(Int64(2))
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}

@Test
func testMat2x2ColNegative(): Unit {
    let m = Mat2x2<Int64, Defaultp>(5)
    try {
        let _ = m.col(Int64(-1))
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}

@Test
func testMat2x2UnaryNegate(): Unit {
    let m = Mat2x2<Int64, Defaultp>(1, -2, 3, -4)
    let n = -m
    @Expect(n.c0.x, -1)
    @Expect(n.c0.y, 2)
    @Expect(n.c1.x, -3)
    @Expect(n.c1.y, 4)
}

@Test
func testMat2x2ScalarAdd(): Unit {
    let m = Mat2x2<Int64, Defaultp>(1, 2, 3, 4)
    let r = m + Int64(10)
    @Expect(r.c0.x, 11)
    @Expect(r.c0.y, 12)
    @Expect(r.c1.x, 13)
    @Expect(r.c1.y, 14)
}

@Test
func testMat2x2ScalarSub(): Unit {
    let m = Mat2x2<Int64, Defaultp>(10, 20, 30, 40)
    let r = m - Int64(5)
    @Expect(r.c0.x, 5)
    @Expect(r.c0.y, 15)
    @Expect(r.c1.x, 25)
    @Expect(r.c1.y, 35)
}

@Test
func testMat2x2ScalarMul(): Unit {
    let m = Mat2x2<Int64, Defaultp>(1, 2, 3, 4)
    let r = m * Int64(3)
    @Expect(r.c0.x, 3)
    @Expect(r.c0.y, 6)
    @Expect(r.c1.x, 9)
    @Expect(r.c1.y, 12)
}

@Test
func testMat2x2ScalarDiv(): Unit {
    let m = Mat2x2<Int64, Defaultp>(10, 20, 30, 40)
    let r = m / Int64(2)
    @Expect(r.c0.x, 5)
    @Expect(r.c0.y, 10)
    @Expect(r.c1.x, 15)
    @Expect(r.c1.y, 20)
}

@Test
func testMat2x2MatrixAdd(): Unit {
    let a = Mat2x2<Int64, Defaultp>(1, 2, 3, 4)
    let b = Mat2x2<Int64, Defaultp>(5, 6, 7, 8)
    let r = a + b
    @Expect(r.c0.x, 6)
    @Expect(r.c0.y, 8)
    @Expect(r.c1.x, 10)
    @Expect(r.c1.y, 12)
}

@Test
func testMat2x2MatrixSub(): Unit {
    let a = Mat2x2<Int64, Defaultp>(10, 20, 30, 40)
    let b = Mat2x2<Int64, Defaultp>(1, 2, 3, 4)
    let r = a - b
    @Expect(r.c0.x, 9)
    @Expect(r.c0.y, 18)
    @Expect(r.c1.x, 27)
    @Expect(r.c1.y, 36)
}

@Test
func testMat2x2MatrixMul(): Unit {
    let a = Mat2x2<Int64, Defaultp>(1, 2, 3, 4)
    let b = Mat2x2<Int64, Defaultp>(5, 6, 7, 8)
    let r = a * b
    @Expect(r.c0.x, 1*5 + 3*6)
    @Expect(r.c0.y, 2*5 + 4*6)
    @Expect(r.c1.x, 1*7 + 3*8)
    @Expect(r.c1.y, 2*7 + 4*8)
}

@Test
func testMat2x2MulMat3x2(): Unit {
    let a = Mat2x2<Int64, Defaultp>(1, 2, 3, 4)
    let b = Mat3x2<Int64, Defaultp>(5, 6, 7, 8, 9, 10)
    let r = a * b
    @Expect(r.c0.x, 1*5 + 3*6)
    @Expect(r.c0.y, 2*5 + 4*6)
    @Expect(r.c1.x, 1*7 + 3*8)
    @Expect(r.c1.y, 2*7 + 4*8)
    @Expect(r.c2.x, 1*9 + 3*10)
    @Expect(r.c2.y, 2*9 + 4*10)
}

@Test
func testMat2x2MulMat4x2(): Unit {
    let a = Mat2x2<Int64, Defaultp>(1, 2, 3, 4)
    let b = Mat4x2<Int64, Defaultp>(5, 6, 7, 8, 9, 10, 11, 12)
    let r = a * b
    @Expect(r.c0.x, 1*5 + 3*6)
    @Expect(r.c0.y, 2*5 + 4*6)
    @Expect(r.c1.x, 1*7 + 3*8)
    @Expect(r.c1.y, 2*7 + 4*8)
    @Expect(r.c2.x, 1*9 + 3*10)
    @Expect(r.c2.y, 2*9 + 4*10)
    @Expect(r.c3.x, 1*11 + 3*12)
    @Expect(r.c3.y, 2*11 + 4*12)
}

@Test
func testMat2x2MatrixDivStub(): Unit {
    let a = Mat2x2<Int64, Defaultp>(1, 2, 3, 4)
    let b = Mat2x2<Int64, Defaultp>(5, 6, 7, 8)
    try {
        let _ = a / b
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}

@Test
func testMat2x2MulVec2(): Unit {
    let m = Mat2x2<Int64, Defaultp>(1, 2, 3, 4)
    let v = Vec2<Int64, Defaultp>(5, 6)
    let r = m * v
    @Expect(r.x, 1*5 + 3*6)
    @Expect(r.y, 2*5 + 4*6)
}

@Test
func testMat2x2Diagonal(): Unit {
    let d = Mat2x2<Int64, Defaultp>.diagonal(Int64(7))
    @Expect(d.c0.x, 7)
    @Expect(d.c0.y, 0)
    @Expect(d.c1.x, 0)
    @Expect(d.c1.y, 7)
}

@Test
func testMat2x2Identity(): Unit {
    let id = Mat2x2<Int64, Defaultp>.identity(Int64(1))
    @Expect(id.c0.x, 1)
    @Expect(id.c0.y, 0)
    @Expect(id.c1.x, 0)
    @Expect(id.c1.y, 1)
}

@Test
func testMat2x2FromParts(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let m = Mat2x2<Float64, Defaultp>.fromParts(conv, Int64(1), Int64(2), Int64(3), Int64(4))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c1.x, Float64(3))
    @Expect(m.c1.y, Float64(4))
}

@Test
func testMat2x2FromColumns(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let c0 = Vec2<Int64, Defaultp>(1, 2)
    let c1 = Vec2<Int64, Defaultp>(3, 4)
    let m = Mat2x2<Float64, Defaultp>.fromColumns(conv, c0, c1)
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c1.x, Float64(3))
    @Expect(m.c1.y, Float64(4))
}

@Test
func testMat2x2FromMat7(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat2x2<Int64, Defaultp>(1, 2, 3, 4)
    let m = Mat2x2<Float64, Defaultp>.fromMat(conv, src)
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c1.x, Float64(3))
    @Expect(m.c1.y, Float64(4))
}

@Test
func testMat2x2FromMat6aMat2x3(): Unit {
    let src = Mat2x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let m = Mat2x2<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c1.x, 4)
    @Expect(m.c1.y, 5)
}

@Test
func testMat2x2FromMat6aMat2x4(): Unit {
    let src = Mat2x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let m = Mat2x2<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c1.x, 5)
    @Expect(m.c1.y, 6)
}

@Test
func testMat2x2FromMat6aMat3x2(): Unit {
    let src = Mat3x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let m = Mat2x2<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c1.x, 3)
    @Expect(m.c1.y, 4)
}

@Test
func testMat2x2FromMat6aMat3x3(): Unit {
    let src = Mat3x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9)
    let m = Mat2x2<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c1.x, 4)
    @Expect(m.c1.y, 5)
}

@Test
func testMat2x2FromMat6aMat3x4(): Unit {
    let src = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let m = Mat2x2<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c1.x, 5)
    @Expect(m.c1.y, 6)
}

@Test
func testMat2x2FromMat6aMat4x2(): Unit {
    let src = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let m = Mat2x2<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c1.x, 3)
    @Expect(m.c1.y, 4)
}

@Test
func testMat2x2FromMat6aMat4x3(): Unit {
    let src = Mat4x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let m = Mat2x2<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c1.x, 4)
    @Expect(m.c1.y, 5)
}

@Test
func testMat2x2FromMat6aMat4x4(): Unit {
    let src = Mat4x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    let m = Mat2x2<Int64, Defaultp>.fromMat(src, Int64(1))
    @Expect(m.c0.x, 1)
    @Expect(m.c0.y, 2)
    @Expect(m.c1.x, 5)
    @Expect(m.c1.y, 6)
}

@Test
func testMat2x2FromMat6bMat2x3(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat2x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let m = Mat2x2<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c1.x, Float64(4))
    @Expect(m.c1.y, Float64(5))
}

@Test
func testMat2x2FromMat6bMat2x4(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat2x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let m = Mat2x2<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c1.x, Float64(5))
    @Expect(m.c1.y, Float64(6))
}

@Test
func testMat2x2FromMat6bMat3x2(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat3x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let m = Mat2x2<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c1.x, Float64(3))
    @Expect(m.c1.y, Float64(4))
}

@Test
func testMat2x2FromMat6bMat3x3(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat3x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9)
    let m = Mat2x2<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c1.x, Float64(4))
    @Expect(m.c1.y, Float64(5))
}

@Test
func testMat2x2FromMat6bMat3x4(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let m = Mat2x2<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c1.x, Float64(5))
    @Expect(m.c1.y, Float64(6))
}

@Test
func testMat2x2FromMat6bMat4x2(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let m = Mat2x2<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c1.x, Float64(3))
    @Expect(m.c1.y, Float64(4))
}

@Test
func testMat2x2FromMat6bMat4x3(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat4x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let m = Mat2x2<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c1.x, Float64(4))
    @Expect(m.c1.y, Float64(5))
}

@Test
func testMat2x2FromMat6bMat4x4(): Unit {
    func conv(x: Int64): Float64 { Float64(x) }
    let src = Mat4x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    let m = Mat2x2<Float64, Defaultp>.fromMat(conv, src, Float64(1))
    @Expect(m.c0.x, Float64(1))
    @Expect(m.c0.y, Float64(2))
    @Expect(m.c1.x, Float64(5))
    @Expect(m.c1.y, Float64(6))
}

@Test
func testMat2x2DiagonalFloat32(): Unit {
    let d = Mat2x2<Float32, Defaultp>.diagonal(Float32(7.5))
    @Expect(d.c0.x, Float32(7.5))
    @Expect(d.c0.y, Float32(0.0))
    @Expect(d.c1.x, Float32(0.0))
    @Expect(d.c1.y, Float32(7.5))
}

@Test
func testMat2x2DiagonalFloat64(): Unit {
    let d = Mat2x2<Float64, Defaultp>.diagonal(Float64(7.5))
    @Expect(d.c0.x, Float64(7.5))
    @Expect(d.c0.y, Float64(0.0))
    @Expect(d.c1.x, Float64(0.0))
    @Expect(d.c1.y, Float64(7.5))
}

@Test
func testMat2x2ColAccessFloat32(): Unit {
    let m = Mat2x2<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5))
    let c0 = Vec2<Float32, Defaultp>(Float32(1.5), Float32(1.5))
    let c1 = Vec2<Float32, Defaultp>(Float32(1.5), Float32(1.5))
    @Expect(m.col(Int64(0)), c0)
    @Expect(m.col(Int64(1)), c1)
}

@Test
func testMat2x2ColAccessFloat64(): Unit {
    let m = Mat2x2<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5))
    let c0 = Vec2<Float64, Defaultp>(Float64(2.5), Float64(2.5))
    let c1 = Vec2<Float64, Defaultp>(Float64(2.5), Float64(2.5))
    @Expect(m.col(Int64(0)), c0)
    @Expect(m.col(Int64(1)), c1)
}

@Test
func testMat2x2ScalarMulFloat32(): Unit {
    let m = Mat2x2<Float32, Defaultp>(Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0))
    let r = m * Float32(1.5)
    @Expect(r.c0.x, Float32(3.0))
    @Expect(r.c0.y, Float32(3.0))
    @Expect(r.c1.x, Float32(3.0))
    @Expect(r.c1.y, Float32(3.0))
}

@Test
func testMat2x2ScalarMulFloat64(): Unit {
    let m = Mat2x2<Float64, Defaultp>(Float64(2.0), Float64(2.0), Float64(2.0), Float64(2.0))
    let r = m * Float64(1.5)
    @Expect(r.c0.x, Float64(3.0))
    @Expect(r.c0.y, Float64(3.0))
    @Expect(r.c1.x, Float64(3.0))
    @Expect(r.c1.y, Float64(3.0))
}
