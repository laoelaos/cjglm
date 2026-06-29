package glm.detail

import std.unittest.*
import std.unittest.testmacro.*

@Test
func testScalarAddMat2x2Int64(): Unit {
    let m = Mat2x2<Int64, Defaultp>(10, 20, 30, 40)
    let r = add(Int64(3), m)
    @Expect(r.c0.x, 13)
    @Expect(r.c0.y, 23)
    @Expect(r.c1.x, 33)
    @Expect(r.c1.y, 43)
}

@Test
func testScalarAddMat3x3Int64(): Unit {
    let m = Mat3x3<Int64, Defaultp>(10, 20, 30, 40, 50, 60, 70, 80, 90)
    let r = add(Int64(3), m)
    @Expect(r.c0.x, 13)
    @Expect(r.c0.y, 23)
    @Expect(r.c0.z, 33)
    @Expect(r.c1.x, 43)
    @Expect(r.c1.y, 53)
    @Expect(r.c1.z, 63)
    @Expect(r.c2.x, 73)
    @Expect(r.c2.y, 83)
    @Expect(r.c2.z, 93)
}

@Test
func testScalarAddMat4x4Int64(): Unit {
    let m = Mat4x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    let r = add(Int64(10), m)
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
    @Expect(r.c3.x, 23)
    @Expect(r.c3.y, 24)
    @Expect(r.c3.z, 25)
    @Expect(r.c3.w, 26)
}

@Test
func testScalarSubMat2x2Int64(): Unit {
    let m = Mat2x2<Int64, Defaultp>(10, 20, 30, 40)
    let r = sub(Int64(3), m)
    @Expect(r.c0.x, -7)
    @Expect(r.c0.y, -17)
    @Expect(r.c1.x, -27)
    @Expect(r.c1.y, -37)
}

@Test
func testScalarSubMat3x3Int64(): Unit {
    let m = Mat3x3<Int64, Defaultp>(10, 20, 30, 40, 50, 60, 70, 80, 90)
    let r = sub(Int64(100), m)
    @Expect(r.c0.x, 90)
    @Expect(r.c0.y, 80)
    @Expect(r.c0.z, 70)
    @Expect(r.c1.x, 60)
    @Expect(r.c1.y, 50)
    @Expect(r.c1.z, 40)
    @Expect(r.c2.x, 30)
    @Expect(r.c2.y, 20)
    @Expect(r.c2.z, 10)
}

@Test
func testScalarSubMat4x4Int64(): Unit {
    let m = Mat4x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    let r = sub(Int64(10), m)
    @Expect(r.c0.x, 9)
    @Expect(r.c0.y, 8)
    @Expect(r.c0.z, 7)
    @Expect(r.c0.w, 6)
    @Expect(r.c1.x, 5)
    @Expect(r.c1.y, 4)
    @Expect(r.c1.z, 3)
    @Expect(r.c1.w, 2)
    @Expect(r.c2.x, 1)
    @Expect(r.c2.y, 0)
    @Expect(r.c2.z, -1)
    @Expect(r.c2.w, -2)
    @Expect(r.c3.x, -3)
    @Expect(r.c3.y, -4)
    @Expect(r.c3.z, -5)
    @Expect(r.c3.w, -6)
}

@Test
func testScalarMulMat2x2Int64(): Unit {
    let m = Mat2x2<Int64, Defaultp>(2, 3, 4, 5)
    let r = mul(Int64(5), m)
    @Expect(r.c0.x, 10)
    @Expect(r.c0.y, 15)
    @Expect(r.c1.x, 20)
    @Expect(r.c1.y, 25)
}

@Test
func testScalarMulMat3x3Int64(): Unit {
    let m = Mat3x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9)
    let r = mul(Int64(3), m)
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
func testScalarMulMat4x4Int64(): Unit {
    let m = Mat4x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    let r = mul(Int64(2), m)
    @Expect(r.c0.x, 2)
    @Expect(r.c0.y, 4)
    @Expect(r.c0.z, 6)
    @Expect(r.c0.w, 8)
    @Expect(r.c1.x, 10)
    @Expect(r.c1.y, 12)
    @Expect(r.c1.z, 14)
    @Expect(r.c1.w, 16)
    @Expect(r.c2.x, 18)
    @Expect(r.c2.y, 20)
    @Expect(r.c2.z, 22)
    @Expect(r.c2.w, 24)
    @Expect(r.c3.x, 26)
    @Expect(r.c3.y, 28)
    @Expect(r.c3.z, 30)
    @Expect(r.c3.w, 32)
}

@Test
func testScalarDivMat2x2Int64(): Unit {
    let m = Mat2x2<Int64, Defaultp>(10, 15, 20, 25)
    let r = div(Int64(30), m)
    @Expect(r.c0.x, 3)
    @Expect(r.c0.y, 2)
    @Expect(r.c1.x, 1)
    @Expect(r.c1.y, 1)
}

@Test
func testScalarDivMat3x3Int64(): Unit {
    let m = Mat3x3<Int64, Defaultp>(10, 15, 20, 25, 30, 35, 40, 45, 50)
    let r = div(Int64(100), m)
    @Expect(r.c0.x, 10)
    @Expect(r.c0.y, 6)
    @Expect(r.c0.z, 5)
    @Expect(r.c1.x, 4)
    @Expect(r.c1.y, 3)
    @Expect(r.c1.z, 2)
    @Expect(r.c2.x, 2)
    @Expect(r.c2.y, 2)
    @Expect(r.c2.z, 2)
}

@Test
func testScalarDivMat4x4Int64(): Unit {
    let m = Mat4x4<Int64, Defaultp>(2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17)
    let r = div(Int64(60), m)
    @Expect(r.c0.x, 30)
    @Expect(r.c0.y, 20)
    @Expect(r.c0.z, 15)
    @Expect(r.c0.w, 12)
    @Expect(r.c1.x, 10)
    @Expect(r.c1.y, 8)
    @Expect(r.c1.z, 7)
    @Expect(r.c1.w, 6)
    @Expect(r.c2.x, 6)
    @Expect(r.c2.y, 5)
    @Expect(r.c2.z, 5)
    @Expect(r.c2.w, 4)
    @Expect(r.c3.x, 4)
    @Expect(r.c3.y, 4)
    @Expect(r.c3.z, 3)
    @Expect(r.c3.w, 3)
}

@Test
func testScalarDivMat2x2Float32(): Unit {
    let m = Mat2x2<Float32, Defaultp>(Float32(2.5), Float32(3.0), Float32(4.0), Float32(5.0))
    let r = div(Float32(7.5), m)
    @Expect(r.c0.x, Float32(3.0))
    @Expect(r.c0.y, Float32(2.5))
    @Expect(r.c1.x, Float32(1.875))
    @Expect(r.c1.y, Float32(1.5))
}

@Test
func testScalarDivMat2x2Float64(): Unit {
    let m = Mat2x2<Float64, Defaultp>(Float64(2.5), Float64(4.0), Float64(5.0), Float64(8.0))
    let r = div(Float64(10.0), m)
    @Expect(r.c0.x, Float64(4.0))
    @Expect(r.c0.y, Float64(2.5))
    @Expect(r.c1.x, Float64(2.0))
    @Expect(r.c1.y, Float64(1.25))
}

@Test
func testScalarDivMat2x2Int32Truncation(): Unit {
    let m = Mat2x2<Int32, Defaultp>(Int32(3), Int32(4), Int32(5), Int32(6))
    let r = div(Int32(10), m)
    @Expect(r.c0.x, Int32(3))
    @Expect(r.c0.y, Int32(2))
    @Expect(r.c1.x, Int32(2))
    @Expect(r.c1.y, Int32(1))
}

@Test
func testScalarMatOpsConsistencyWithVecOps(): Unit {
    let m = Mat2x2<Int64, Defaultp>(10, 20, 30, 40)
    let v = Vec1<Int64, Defaultp>(10)
    let rMat = div(Int64(30), m)
    let rVec = div(Int64(30), v)
    @Expect(rMat.c0.x, rVec.x)
}

@Test
func testScalarAddMat2x3Int64(): Unit {
    let m = Mat2x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let r = add(Int64(3), m)
    @Expect(r.c0.x, 4)
    @Expect(r.c0.y, 5)
    @Expect(r.c0.z, 6)
    @Expect(r.c1.x, 7)
    @Expect(r.c1.y, 8)
    @Expect(r.c1.z, 9)
}

@Test
func testScalarAddMat2x4Int64(): Unit {
    let m = Mat2x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let r = add(Int64(3), m)
    @Expect(r.c0.x, 4)
    @Expect(r.c0.y, 5)
    @Expect(r.c0.z, 6)
    @Expect(r.c0.w, 7)
    @Expect(r.c1.x, 8)
    @Expect(r.c1.y, 9)
    @Expect(r.c1.z, 10)
    @Expect(r.c1.w, 11)
}

@Test
func testScalarAddMat3x2Int64(): Unit {
    let m = Mat3x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let r = add(Int64(3), m)
    @Expect(r.c0.x, 4)
    @Expect(r.c0.y, 5)
    @Expect(r.c1.x, 6)
    @Expect(r.c1.y, 7)
    @Expect(r.c2.x, 8)
    @Expect(r.c2.y, 9)
}

@Test
func testScalarAddMat3x4Int64(): Unit {
    let m = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let r = add(Int64(3), m)
    @Expect(r.c0.x, 4)
    @Expect(r.c0.y, 5)
    @Expect(r.c0.z, 6)
    @Expect(r.c0.w, 7)
    @Expect(r.c1.x, 8)
    @Expect(r.c1.y, 9)
    @Expect(r.c1.z, 10)
    @Expect(r.c1.w, 11)
    @Expect(r.c2.x, 12)
    @Expect(r.c2.y, 13)
    @Expect(r.c2.z, 14)
    @Expect(r.c2.w, 15)
}

@Test
func testScalarAddMat4x2Int64(): Unit {
    let m = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let r = add(Int64(3), m)
    @Expect(r.c0.x, 4)
    @Expect(r.c0.y, 5)
    @Expect(r.c1.x, 6)
    @Expect(r.c1.y, 7)
    @Expect(r.c2.x, 8)
    @Expect(r.c2.y, 9)
    @Expect(r.c3.x, 10)
    @Expect(r.c3.y, 11)
}

@Test
func testScalarAddMat4x3Int64(): Unit {
    let m = Mat4x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let r = add(Int64(3), m)
    @Expect(r.c0.x, 4)
    @Expect(r.c0.y, 5)
    @Expect(r.c0.z, 6)
    @Expect(r.c1.x, 7)
    @Expect(r.c1.y, 8)
    @Expect(r.c1.z, 9)
    @Expect(r.c2.x, 10)
    @Expect(r.c2.y, 11)
    @Expect(r.c2.z, 12)
    @Expect(r.c3.x, 13)
    @Expect(r.c3.y, 14)
    @Expect(r.c3.z, 15)
}

@Test
func testScalarSubMat2x3Int64(): Unit {
    let m = Mat2x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let r = sub(Int64(100), m)
    @Expect(r.c0.x, 99)
    @Expect(r.c0.y, 98)
    @Expect(r.c0.z, 97)
    @Expect(r.c1.x, 96)
    @Expect(r.c1.y, 95)
    @Expect(r.c1.z, 94)
}

@Test
func testScalarSubMat2x4Int64(): Unit {
    let m = Mat2x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let r = sub(Int64(10), m)
    @Expect(r.c0.x, 9)
    @Expect(r.c0.y, 8)
    @Expect(r.c0.z, 7)
    @Expect(r.c0.w, 6)
    @Expect(r.c1.x, 5)
    @Expect(r.c1.y, 4)
    @Expect(r.c1.z, 3)
    @Expect(r.c1.w, 2)
}

@Test
func testScalarSubMat3x2Int64(): Unit {
    let m = Mat3x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let r = sub(Int64(100), m)
    @Expect(r.c0.x, 99)
    @Expect(r.c0.y, 98)
    @Expect(r.c1.x, 97)
    @Expect(r.c1.y, 96)
    @Expect(r.c2.x, 95)
    @Expect(r.c2.y, 94)
}

@Test
func testScalarSubMat3x4Int64(): Unit {
    let m = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let r = sub(Int64(10), m)
    @Expect(r.c0.x, 9)
    @Expect(r.c0.y, 8)
    @Expect(r.c0.z, 7)
    @Expect(r.c0.w, 6)
    @Expect(r.c1.x, 5)
    @Expect(r.c1.y, 4)
    @Expect(r.c1.z, 3)
    @Expect(r.c1.w, 2)
    @Expect(r.c2.x, 1)
    @Expect(r.c2.y, 0)
    @Expect(r.c2.z, -1)
    @Expect(r.c2.w, -2)
}

@Test
func testScalarSubMat4x2Int64(): Unit {
    let m = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let r = sub(Int64(100), m)
    @Expect(r.c0.x, 99)
    @Expect(r.c0.y, 98)
    @Expect(r.c1.x, 97)
    @Expect(r.c1.y, 96)
    @Expect(r.c2.x, 95)
    @Expect(r.c2.y, 94)
    @Expect(r.c3.x, 93)
    @Expect(r.c3.y, 92)
}

@Test
func testScalarSubMat4x3Int64(): Unit {
    let m = Mat4x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let r = sub(Int64(10), m)
    @Expect(r.c0.x, 9)
    @Expect(r.c0.y, 8)
    @Expect(r.c0.z, 7)
    @Expect(r.c1.x, 6)
    @Expect(r.c1.y, 5)
    @Expect(r.c1.z, 4)
    @Expect(r.c2.x, 3)
    @Expect(r.c2.y, 2)
    @Expect(r.c2.z, 1)
    @Expect(r.c3.x, 0)
    @Expect(r.c3.y, -1)
    @Expect(r.c3.z, -2)
}

@Test
func testScalarMulMat2x3Int64(): Unit {
    let m = Mat2x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let r = mul(Int64(3), m)
    @Expect(r.c0.x, 3)
    @Expect(r.c0.y, 6)
    @Expect(r.c0.z, 9)
    @Expect(r.c1.x, 12)
    @Expect(r.c1.y, 15)
    @Expect(r.c1.z, 18)
}

@Test
func testScalarMulMat2x4Int64(): Unit {
    let m = Mat2x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let r = mul(Int64(2), m)
    @Expect(r.c0.x, 2)
    @Expect(r.c0.y, 4)
    @Expect(r.c0.z, 6)
    @Expect(r.c0.w, 8)
    @Expect(r.c1.x, 10)
    @Expect(r.c1.y, 12)
    @Expect(r.c1.z, 14)
    @Expect(r.c1.w, 16)
}

@Test
func testScalarMulMat3x2Int64(): Unit {
    let m = Mat3x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let r = mul(Int64(3), m)
    @Expect(r.c0.x, 3)
    @Expect(r.c0.y, 6)
    @Expect(r.c1.x, 9)
    @Expect(r.c1.y, 12)
    @Expect(r.c2.x, 15)
    @Expect(r.c2.y, 18)
}

@Test
func testScalarMulMat3x4Int64(): Unit {
    let m = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let r = mul(Int64(2), m)
    @Expect(r.c0.x, 2)
    @Expect(r.c0.y, 4)
    @Expect(r.c0.z, 6)
    @Expect(r.c0.w, 8)
    @Expect(r.c1.x, 10)
    @Expect(r.c1.y, 12)
    @Expect(r.c1.z, 14)
    @Expect(r.c1.w, 16)
    @Expect(r.c2.x, 18)
    @Expect(r.c2.y, 20)
    @Expect(r.c2.z, 22)
    @Expect(r.c2.w, 24)
}

@Test
func testScalarMulMat4x2Int64(): Unit {
    let m = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let r = mul(Int64(3), m)
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
func testScalarMulMat4x3Int64(): Unit {
    let m = Mat4x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let r = mul(Int64(2), m)
    @Expect(r.c0.x, 2)
    @Expect(r.c0.y, 4)
    @Expect(r.c0.z, 6)
    @Expect(r.c1.x, 8)
    @Expect(r.c1.y, 10)
    @Expect(r.c1.z, 12)
    @Expect(r.c2.x, 14)
    @Expect(r.c2.y, 16)
    @Expect(r.c2.z, 18)
    @Expect(r.c3.x, 20)
    @Expect(r.c3.y, 22)
    @Expect(r.c3.z, 24)
}

@Test
func testScalarDivMat2x3Int64(): Unit {
    let m = Mat2x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let r = div(Int64(30), m)
    @Expect(r.c0.x, 30)
    @Expect(r.c0.y, 15)
    @Expect(r.c0.z, 10)
    @Expect(r.c1.x, 7)
    @Expect(r.c1.y, 6)
    @Expect(r.c1.z, 5)
}

@Test
func testScalarDivMat2x4Int64(): Unit {
    let m = Mat2x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let r = div(Int64(60), m)
    @Expect(r.c0.x, 60)
    @Expect(r.c0.y, 30)
    @Expect(r.c0.z, 20)
    @Expect(r.c0.w, 15)
    @Expect(r.c1.x, 12)
    @Expect(r.c1.y, 10)
    @Expect(r.c1.z, 8)
    @Expect(r.c1.w, 7)
}

@Test
func testScalarDivMat3x2Int64(): Unit {
    let m = Mat3x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let r = div(Int64(30), m)
    @Expect(r.c0.x, 30)
    @Expect(r.c0.y, 15)
    @Expect(r.c1.x, 10)
    @Expect(r.c1.y, 7)
    @Expect(r.c2.x, 6)
    @Expect(r.c2.y, 5)
}

@Test
func testScalarDivMat3x4Int64(): Unit {
    let m = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let r = div(Int64(60), m)
    @Expect(r.c0.x, 60)
    @Expect(r.c0.y, 30)
    @Expect(r.c0.z, 20)
    @Expect(r.c0.w, 15)
    @Expect(r.c1.x, 12)
    @Expect(r.c1.y, 10)
    @Expect(r.c1.z, 8)
    @Expect(r.c1.w, 7)
    @Expect(r.c2.x, 6)
    @Expect(r.c2.y, 6)
    @Expect(r.c2.z, 5)
    @Expect(r.c2.w, 5)
}

@Test
func testScalarDivMat4x2Int64(): Unit {
    let m = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let r = div(Int64(30), m)
    @Expect(r.c0.x, 30)
    @Expect(r.c0.y, 15)
    @Expect(r.c1.x, 10)
    @Expect(r.c1.y, 7)
    @Expect(r.c2.x, 6)
    @Expect(r.c2.y, 5)
    @Expect(r.c3.x, 4)
    @Expect(r.c3.y, 3)
}

@Test
func testScalarDivMat4x3Int64(): Unit {
    let m = Mat4x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let r = div(Int64(60), m)
    @Expect(r.c0.x, 60)
    @Expect(r.c0.y, 30)
    @Expect(r.c0.z, 20)
    @Expect(r.c1.x, 15)
    @Expect(r.c1.y, 12)
    @Expect(r.c1.z, 10)
    @Expect(r.c2.x, 8)
    @Expect(r.c2.y, 7)
    @Expect(r.c2.z, 6)
    @Expect(r.c3.x, 6)
    @Expect(r.c3.y, 5)
    @Expect(r.c3.z, 5)
}

@Test
func testScalarAddMat2x3Float32(): Unit {
    let m = Mat2x3<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5))
    let r = add(Float32(3.0), m)
    @Expect(r.c0.x, Float32(4.5))
    @Expect(r.c0.y, Float32(4.5))
    @Expect(r.c0.z, Float32(4.5))
    @Expect(r.c1.x, Float32(4.5))
    @Expect(r.c1.y, Float32(4.5))
    @Expect(r.c1.z, Float32(4.5))
}

@Test
func testScalarAddMat2x3Float64(): Unit {
    let m = Mat2x3<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5))
    let r = add(Float64(3.0), m)
    @Expect(r.c0.x, Float64(5.5))
    @Expect(r.c0.y, Float64(5.5))
    @Expect(r.c0.z, Float64(5.5))
    @Expect(r.c1.x, Float64(5.5))
    @Expect(r.c1.y, Float64(5.5))
    @Expect(r.c1.z, Float64(5.5))
}

@Test
func testScalarAddMat2x4Float32(): Unit {
    let m = Mat2x4<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5))
    let r = add(Float32(3.0), m)
    @Expect(r.c0.x, Float32(4.5))
    @Expect(r.c0.y, Float32(4.5))
    @Expect(r.c0.z, Float32(4.5))
    @Expect(r.c0.w, Float32(4.5))
    @Expect(r.c1.x, Float32(4.5))
    @Expect(r.c1.y, Float32(4.5))
    @Expect(r.c1.z, Float32(4.5))
    @Expect(r.c1.w, Float32(4.5))
}

@Test
func testScalarAddMat2x4Float64(): Unit {
    let m = Mat2x4<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5))
    let r = add(Float64(3.0), m)
    @Expect(r.c0.x, Float64(5.5))
    @Expect(r.c0.y, Float64(5.5))
    @Expect(r.c0.z, Float64(5.5))
    @Expect(r.c0.w, Float64(5.5))
    @Expect(r.c1.x, Float64(5.5))
    @Expect(r.c1.y, Float64(5.5))
    @Expect(r.c1.z, Float64(5.5))
    @Expect(r.c1.w, Float64(5.5))
}

@Test
func testScalarAddMat3x2Float32(): Unit {
    let m = Mat3x2<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5))
    let r = add(Float32(3.0), m)
    @Expect(r.c0.x, Float32(4.5))
    @Expect(r.c0.y, Float32(4.5))
    @Expect(r.c1.x, Float32(4.5))
    @Expect(r.c1.y, Float32(4.5))
    @Expect(r.c2.x, Float32(4.5))
    @Expect(r.c2.y, Float32(4.5))
}

@Test
func testScalarAddMat3x2Float64(): Unit {
    let m = Mat3x2<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5))
    let r = add(Float64(3.0), m)
    @Expect(r.c0.x, Float64(5.5))
    @Expect(r.c0.y, Float64(5.5))
    @Expect(r.c1.x, Float64(5.5))
    @Expect(r.c1.y, Float64(5.5))
    @Expect(r.c2.x, Float64(5.5))
    @Expect(r.c2.y, Float64(5.5))
}

@Test
func testScalarAddMat3x4Float32(): Unit {
    let m = Mat3x4<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5))
    let r = add(Float32(3.0), m)
    @Expect(r.c0.x, Float32(4.5))
    @Expect(r.c0.y, Float32(4.5))
    @Expect(r.c0.z, Float32(4.5))
    @Expect(r.c0.w, Float32(4.5))
    @Expect(r.c1.x, Float32(4.5))
    @Expect(r.c1.y, Float32(4.5))
    @Expect(r.c1.z, Float32(4.5))
    @Expect(r.c1.w, Float32(4.5))
    @Expect(r.c2.x, Float32(4.5))
    @Expect(r.c2.y, Float32(4.5))
    @Expect(r.c2.z, Float32(4.5))
    @Expect(r.c2.w, Float32(4.5))
}

@Test
func testScalarAddMat3x4Float64(): Unit {
    let m = Mat3x4<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5))
    let r = add(Float64(3.0), m)
    @Expect(r.c0.x, Float64(5.5))
    @Expect(r.c0.y, Float64(5.5))
    @Expect(r.c0.z, Float64(5.5))
    @Expect(r.c0.w, Float64(5.5))
    @Expect(r.c1.x, Float64(5.5))
    @Expect(r.c1.y, Float64(5.5))
    @Expect(r.c1.z, Float64(5.5))
    @Expect(r.c1.w, Float64(5.5))
    @Expect(r.c2.x, Float64(5.5))
    @Expect(r.c2.y, Float64(5.5))
    @Expect(r.c2.z, Float64(5.5))
    @Expect(r.c2.w, Float64(5.5))
}

@Test
func testScalarAddMat4x2Float32(): Unit {
    let m = Mat4x2<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5))
    let r = add(Float32(3.0), m)
    @Expect(r.c0.x, Float32(4.5))
    @Expect(r.c0.y, Float32(4.5))
    @Expect(r.c1.x, Float32(4.5))
    @Expect(r.c1.y, Float32(4.5))
    @Expect(r.c2.x, Float32(4.5))
    @Expect(r.c2.y, Float32(4.5))
    @Expect(r.c3.x, Float32(4.5))
    @Expect(r.c3.y, Float32(4.5))
}

@Test
func testScalarAddMat4x2Float64(): Unit {
    let m = Mat4x2<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5))
    let r = add(Float64(3.0), m)
    @Expect(r.c0.x, Float64(5.5))
    @Expect(r.c0.y, Float64(5.5))
    @Expect(r.c1.x, Float64(5.5))
    @Expect(r.c1.y, Float64(5.5))
    @Expect(r.c2.x, Float64(5.5))
    @Expect(r.c2.y, Float64(5.5))
    @Expect(r.c3.x, Float64(5.5))
    @Expect(r.c3.y, Float64(5.5))
}

@Test
func testScalarAddMat4x3Float32(): Unit {
    let m = Mat4x3<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5))
    let r = add(Float32(3.0), m)
    @Expect(r.c0.x, Float32(4.5))
    @Expect(r.c0.y, Float32(4.5))
    @Expect(r.c0.z, Float32(4.5))
    @Expect(r.c1.x, Float32(4.5))
    @Expect(r.c1.y, Float32(4.5))
    @Expect(r.c1.z, Float32(4.5))
    @Expect(r.c2.x, Float32(4.5))
    @Expect(r.c2.y, Float32(4.5))
    @Expect(r.c2.z, Float32(4.5))
    @Expect(r.c3.x, Float32(4.5))
    @Expect(r.c3.y, Float32(4.5))
    @Expect(r.c3.z, Float32(4.5))
}

@Test
func testScalarAddMat4x3Float64(): Unit {
    let m = Mat4x3<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5))
    let r = add(Float64(3.0), m)
    @Expect(r.c0.x, Float64(5.5))
    @Expect(r.c0.y, Float64(5.5))
    @Expect(r.c0.z, Float64(5.5))
    @Expect(r.c1.x, Float64(5.5))
    @Expect(r.c1.y, Float64(5.5))
    @Expect(r.c1.z, Float64(5.5))
    @Expect(r.c2.x, Float64(5.5))
    @Expect(r.c2.y, Float64(5.5))
    @Expect(r.c2.z, Float64(5.5))
    @Expect(r.c3.x, Float64(5.5))
    @Expect(r.c3.y, Float64(5.5))
    @Expect(r.c3.z, Float64(5.5))
}

@Test
func testScalarSubMat2x3Float32(): Unit {
    let m = Mat2x3<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5))
    let r = sub(Float32(10.0), m)
    @Expect(r.c0.x, Float32(8.5))
    @Expect(r.c0.y, Float32(8.5))
    @Expect(r.c0.z, Float32(8.5))
    @Expect(r.c1.x, Float32(8.5))
    @Expect(r.c1.y, Float32(8.5))
    @Expect(r.c1.z, Float32(8.5))
}

@Test
func testScalarSubMat2x3Float64(): Unit {
    let m = Mat2x3<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5))
    let r = sub(Float64(10.0), m)
    @Expect(r.c0.x, Float64(7.5))
    @Expect(r.c0.y, Float64(7.5))
    @Expect(r.c0.z, Float64(7.5))
    @Expect(r.c1.x, Float64(7.5))
    @Expect(r.c1.y, Float64(7.5))
    @Expect(r.c1.z, Float64(7.5))
}

@Test
func testScalarSubMat2x4Float32(): Unit {
    let m = Mat2x4<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5))
    let r = sub(Float32(10.0), m)
    @Expect(r.c0.x, Float32(8.5))
    @Expect(r.c0.y, Float32(8.5))
    @Expect(r.c0.z, Float32(8.5))
    @Expect(r.c0.w, Float32(8.5))
    @Expect(r.c1.x, Float32(8.5))
    @Expect(r.c1.y, Float32(8.5))
    @Expect(r.c1.z, Float32(8.5))
    @Expect(r.c1.w, Float32(8.5))
}

@Test
func testScalarSubMat2x4Float64(): Unit {
    let m = Mat2x4<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5))
    let r = sub(Float64(10.0), m)
    @Expect(r.c0.x, Float64(7.5))
    @Expect(r.c0.y, Float64(7.5))
    @Expect(r.c0.z, Float64(7.5))
    @Expect(r.c0.w, Float64(7.5))
    @Expect(r.c1.x, Float64(7.5))
    @Expect(r.c1.y, Float64(7.5))
    @Expect(r.c1.z, Float64(7.5))
    @Expect(r.c1.w, Float64(7.5))
}

@Test
func testScalarSubMat3x2Float32(): Unit {
    let m = Mat3x2<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5))
    let r = sub(Float32(10.0), m)
    @Expect(r.c0.x, Float32(8.5))
    @Expect(r.c0.y, Float32(8.5))
    @Expect(r.c1.x, Float32(8.5))
    @Expect(r.c1.y, Float32(8.5))
    @Expect(r.c2.x, Float32(8.5))
    @Expect(r.c2.y, Float32(8.5))
}

@Test
func testScalarSubMat3x2Float64(): Unit {
    let m = Mat3x2<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5))
    let r = sub(Float64(10.0), m)
    @Expect(r.c0.x, Float64(7.5))
    @Expect(r.c0.y, Float64(7.5))
    @Expect(r.c1.x, Float64(7.5))
    @Expect(r.c1.y, Float64(7.5))
    @Expect(r.c2.x, Float64(7.5))
    @Expect(r.c2.y, Float64(7.5))
}

@Test
func testScalarSubMat3x4Float32(): Unit {
    let m = Mat3x4<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5))
    let r = sub(Float32(10.0), m)
    @Expect(r.c0.x, Float32(8.5))
    @Expect(r.c0.y, Float32(8.5))
    @Expect(r.c0.z, Float32(8.5))
    @Expect(r.c0.w, Float32(8.5))
    @Expect(r.c1.x, Float32(8.5))
    @Expect(r.c1.y, Float32(8.5))
    @Expect(r.c1.z, Float32(8.5))
    @Expect(r.c1.w, Float32(8.5))
    @Expect(r.c2.x, Float32(8.5))
    @Expect(r.c2.y, Float32(8.5))
    @Expect(r.c2.z, Float32(8.5))
    @Expect(r.c2.w, Float32(8.5))
}

@Test
func testScalarSubMat3x4Float64(): Unit {
    let m = Mat3x4<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5))
    let r = sub(Float64(10.0), m)
    @Expect(r.c0.x, Float64(7.5))
    @Expect(r.c0.y, Float64(7.5))
    @Expect(r.c0.z, Float64(7.5))
    @Expect(r.c0.w, Float64(7.5))
    @Expect(r.c1.x, Float64(7.5))
    @Expect(r.c1.y, Float64(7.5))
    @Expect(r.c1.z, Float64(7.5))
    @Expect(r.c1.w, Float64(7.5))
    @Expect(r.c2.x, Float64(7.5))
    @Expect(r.c2.y, Float64(7.5))
    @Expect(r.c2.z, Float64(7.5))
    @Expect(r.c2.w, Float64(7.5))
}

@Test
func testScalarSubMat4x2Float32(): Unit {
    let m = Mat4x2<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5))
    let r = sub(Float32(10.0), m)
    @Expect(r.c0.x, Float32(8.5))
    @Expect(r.c0.y, Float32(8.5))
    @Expect(r.c1.x, Float32(8.5))
    @Expect(r.c1.y, Float32(8.5))
    @Expect(r.c2.x, Float32(8.5))
    @Expect(r.c2.y, Float32(8.5))
    @Expect(r.c3.x, Float32(8.5))
    @Expect(r.c3.y, Float32(8.5))
}

@Test
func testScalarSubMat4x2Float64(): Unit {
    let m = Mat4x2<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5))
    let r = sub(Float64(10.0), m)
    @Expect(r.c0.x, Float64(7.5))
    @Expect(r.c0.y, Float64(7.5))
    @Expect(r.c1.x, Float64(7.5))
    @Expect(r.c1.y, Float64(7.5))
    @Expect(r.c2.x, Float64(7.5))
    @Expect(r.c2.y, Float64(7.5))
    @Expect(r.c3.x, Float64(7.5))
    @Expect(r.c3.y, Float64(7.5))
}

@Test
func testScalarSubMat4x3Float32(): Unit {
    let m = Mat4x3<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5))
    let r = sub(Float32(10.0), m)
    @Expect(r.c0.x, Float32(8.5))
    @Expect(r.c0.y, Float32(8.5))
    @Expect(r.c0.z, Float32(8.5))
    @Expect(r.c1.x, Float32(8.5))
    @Expect(r.c1.y, Float32(8.5))
    @Expect(r.c1.z, Float32(8.5))
    @Expect(r.c2.x, Float32(8.5))
    @Expect(r.c2.y, Float32(8.5))
    @Expect(r.c2.z, Float32(8.5))
    @Expect(r.c3.x, Float32(8.5))
    @Expect(r.c3.y, Float32(8.5))
    @Expect(r.c3.z, Float32(8.5))
}

@Test
func testScalarSubMat4x3Float64(): Unit {
    let m = Mat4x3<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5))
    let r = sub(Float64(10.0), m)
    @Expect(r.c0.x, Float64(7.5))
    @Expect(r.c0.y, Float64(7.5))
    @Expect(r.c0.z, Float64(7.5))
    @Expect(r.c1.x, Float64(7.5))
    @Expect(r.c1.y, Float64(7.5))
    @Expect(r.c1.z, Float64(7.5))
    @Expect(r.c2.x, Float64(7.5))
    @Expect(r.c2.y, Float64(7.5))
    @Expect(r.c2.z, Float64(7.5))
    @Expect(r.c3.x, Float64(7.5))
    @Expect(r.c3.y, Float64(7.5))
    @Expect(r.c3.z, Float64(7.5))
}

@Test
func testScalarMulMat2x3Float32(): Unit {
    let m = Mat2x3<Float32, Defaultp>(Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0))
    let r = mul(Float32(1.5), m)
    @Expect(r.c0.x, Float32(3.0))
    @Expect(r.c0.y, Float32(3.0))
    @Expect(r.c0.z, Float32(3.0))
    @Expect(r.c1.x, Float32(3.0))
    @Expect(r.c1.y, Float32(3.0))
    @Expect(r.c1.z, Float32(3.0))
}

@Test
func testScalarMulMat2x3Float64(): Unit {
    let m = Mat2x3<Float64, Defaultp>(Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0))
    let r = mul(Float64(1.5), m)
    @Expect(r.c0.x, Float64(6.0))
    @Expect(r.c0.y, Float64(6.0))
    @Expect(r.c0.z, Float64(6.0))
    @Expect(r.c1.x, Float64(6.0))
    @Expect(r.c1.y, Float64(6.0))
    @Expect(r.c1.z, Float64(6.0))
}

@Test
func testScalarMulMat2x4Float32(): Unit {
    let m = Mat2x4<Float32, Defaultp>(Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0))
    let r = mul(Float32(1.5), m)
    @Expect(r.c0.x, Float32(3.0))
    @Expect(r.c0.y, Float32(3.0))
    @Expect(r.c0.z, Float32(3.0))
    @Expect(r.c0.w, Float32(3.0))
    @Expect(r.c1.x, Float32(3.0))
    @Expect(r.c1.y, Float32(3.0))
    @Expect(r.c1.z, Float32(3.0))
    @Expect(r.c1.w, Float32(3.0))
}

@Test
func testScalarMulMat2x4Float64(): Unit {
    let m = Mat2x4<Float64, Defaultp>(Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0))
    let r = mul(Float64(1.5), m)
    @Expect(r.c0.x, Float64(6.0))
    @Expect(r.c0.y, Float64(6.0))
    @Expect(r.c0.z, Float64(6.0))
    @Expect(r.c0.w, Float64(6.0))
    @Expect(r.c1.x, Float64(6.0))
    @Expect(r.c1.y, Float64(6.0))
    @Expect(r.c1.z, Float64(6.0))
    @Expect(r.c1.w, Float64(6.0))
}

@Test
func testScalarMulMat3x2Float32(): Unit {
    let m = Mat3x2<Float32, Defaultp>(Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0))
    let r = mul(Float32(1.5), m)
    @Expect(r.c0.x, Float32(3.0))
    @Expect(r.c0.y, Float32(3.0))
    @Expect(r.c1.x, Float32(3.0))
    @Expect(r.c1.y, Float32(3.0))
    @Expect(r.c2.x, Float32(3.0))
    @Expect(r.c2.y, Float32(3.0))
}

@Test
func testScalarMulMat3x2Float64(): Unit {
    let m = Mat3x2<Float64, Defaultp>(Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0))
    let r = mul(Float64(1.5), m)
    @Expect(r.c0.x, Float64(6.0))
    @Expect(r.c0.y, Float64(6.0))
    @Expect(r.c1.x, Float64(6.0))
    @Expect(r.c1.y, Float64(6.0))
    @Expect(r.c2.x, Float64(6.0))
    @Expect(r.c2.y, Float64(6.0))
}

@Test
func testScalarMulMat3x4Float32(): Unit {
    let m = Mat3x4<Float32, Defaultp>(Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0))
    let r = mul(Float32(1.5), m)
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
func testScalarMulMat3x4Float64(): Unit {
    let m = Mat3x4<Float64, Defaultp>(Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0))
    let r = mul(Float64(1.5), m)
    @Expect(r.c0.x, Float64(6.0))
    @Expect(r.c0.y, Float64(6.0))
    @Expect(r.c0.z, Float64(6.0))
    @Expect(r.c0.w, Float64(6.0))
    @Expect(r.c1.x, Float64(6.0))
    @Expect(r.c1.y, Float64(6.0))
    @Expect(r.c1.z, Float64(6.0))
    @Expect(r.c1.w, Float64(6.0))
    @Expect(r.c2.x, Float64(6.0))
    @Expect(r.c2.y, Float64(6.0))
    @Expect(r.c2.z, Float64(6.0))
    @Expect(r.c2.w, Float64(6.0))
}

@Test
func testScalarMulMat4x2Float32(): Unit {
    let m = Mat4x2<Float32, Defaultp>(Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0))
    let r = mul(Float32(1.5), m)
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
func testScalarMulMat4x2Float64(): Unit {
    let m = Mat4x2<Float64, Defaultp>(Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0))
    let r = mul(Float64(1.5), m)
    @Expect(r.c0.x, Float64(6.0))
    @Expect(r.c0.y, Float64(6.0))
    @Expect(r.c1.x, Float64(6.0))
    @Expect(r.c1.y, Float64(6.0))
    @Expect(r.c2.x, Float64(6.0))
    @Expect(r.c2.y, Float64(6.0))
    @Expect(r.c3.x, Float64(6.0))
    @Expect(r.c3.y, Float64(6.0))
}

@Test
func testScalarMulMat4x3Float32(): Unit {
    let m = Mat4x3<Float32, Defaultp>(Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0))
    let r = mul(Float32(1.5), m)
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
func testScalarMulMat4x3Float64(): Unit {
    let m = Mat4x3<Float64, Defaultp>(Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0))
    let r = mul(Float64(1.5), m)
    @Expect(r.c0.x, Float64(6.0))
    @Expect(r.c0.y, Float64(6.0))
    @Expect(r.c0.z, Float64(6.0))
    @Expect(r.c1.x, Float64(6.0))
    @Expect(r.c1.y, Float64(6.0))
    @Expect(r.c1.z, Float64(6.0))
    @Expect(r.c2.x, Float64(6.0))
    @Expect(r.c2.y, Float64(6.0))
    @Expect(r.c2.z, Float64(6.0))
    @Expect(r.c3.x, Float64(6.0))
    @Expect(r.c3.y, Float64(6.0))
    @Expect(r.c3.z, Float64(6.0))
}

@Test
func testScalarDivMat2x3Float32(): Unit {
    let m = Mat2x3<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5))
    let r = div(Float32(30.0), m)
    @Expect(r.c0.x, Float32(20.0))
    @Expect(r.c0.y, Float32(20.0))
    @Expect(r.c0.z, Float32(20.0))
    @Expect(r.c1.x, Float32(20.0))
    @Expect(r.c1.y, Float32(20.0))
    @Expect(r.c1.z, Float32(20.0))
}

@Test
func testScalarDivMat2x3Float64(): Unit {
    let m = Mat2x3<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5))
    let r = div(Float64(10.0), m)
    @Expect(r.c0.x, Float64(4.0))
    @Expect(r.c0.y, Float64(4.0))
    @Expect(r.c0.z, Float64(4.0))
    @Expect(r.c1.x, Float64(4.0))
    @Expect(r.c1.y, Float64(4.0))
    @Expect(r.c1.z, Float64(4.0))
}

@Test
func testScalarDivMat2x4Float32(): Unit {
    let m = Mat2x4<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5))
    let r = div(Float32(30.0), m)
    @Expect(r.c0.x, Float32(20.0))
    @Expect(r.c0.y, Float32(20.0))
    @Expect(r.c0.z, Float32(20.0))
    @Expect(r.c0.w, Float32(20.0))
    @Expect(r.c1.x, Float32(20.0))
    @Expect(r.c1.y, Float32(20.0))
    @Expect(r.c1.z, Float32(20.0))
    @Expect(r.c1.w, Float32(20.0))
}

@Test
func testScalarDivMat2x4Float64(): Unit {
    let m = Mat2x4<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5))
    let r = div(Float64(10.0), m)
    @Expect(r.c0.x, Float64(4.0))
    @Expect(r.c0.y, Float64(4.0))
    @Expect(r.c0.z, Float64(4.0))
    @Expect(r.c0.w, Float64(4.0))
    @Expect(r.c1.x, Float64(4.0))
    @Expect(r.c1.y, Float64(4.0))
    @Expect(r.c1.z, Float64(4.0))
    @Expect(r.c1.w, Float64(4.0))
}

@Test
func testScalarDivMat3x2Float32(): Unit {
    let m = Mat3x2<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5))
    let r = div(Float32(30.0), m)
    @Expect(r.c0.x, Float32(20.0))
    @Expect(r.c0.y, Float32(20.0))
    @Expect(r.c1.x, Float32(20.0))
    @Expect(r.c1.y, Float32(20.0))
    @Expect(r.c2.x, Float32(20.0))
    @Expect(r.c2.y, Float32(20.0))
}

@Test
func testScalarDivMat3x2Float64(): Unit {
    let m = Mat3x2<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5))
    let r = div(Float64(10.0), m)
    @Expect(r.c0.x, Float64(4.0))
    @Expect(r.c0.y, Float64(4.0))
    @Expect(r.c1.x, Float64(4.0))
    @Expect(r.c1.y, Float64(4.0))
    @Expect(r.c2.x, Float64(4.0))
    @Expect(r.c2.y, Float64(4.0))
}

@Test
func testScalarDivMat3x4Float32(): Unit {
    let m = Mat3x4<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5))
    let r = div(Float32(30.0), m)
    @Expect(r.c0.x, Float32(20.0))
    @Expect(r.c0.y, Float32(20.0))
    @Expect(r.c0.z, Float32(20.0))
    @Expect(r.c0.w, Float32(20.0))
    @Expect(r.c1.x, Float32(20.0))
    @Expect(r.c1.y, Float32(20.0))
    @Expect(r.c1.z, Float32(20.0))
    @Expect(r.c1.w, Float32(20.0))
    @Expect(r.c2.x, Float32(20.0))
    @Expect(r.c2.y, Float32(20.0))
    @Expect(r.c2.z, Float32(20.0))
    @Expect(r.c2.w, Float32(20.0))
}

@Test
func testScalarDivMat3x4Float64(): Unit {
    let m = Mat3x4<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5))
    let r = div(Float64(10.0), m)
    @Expect(r.c0.x, Float64(4.0))
    @Expect(r.c0.y, Float64(4.0))
    @Expect(r.c0.z, Float64(4.0))
    @Expect(r.c0.w, Float64(4.0))
    @Expect(r.c1.x, Float64(4.0))
    @Expect(r.c1.y, Float64(4.0))
    @Expect(r.c1.z, Float64(4.0))
    @Expect(r.c1.w, Float64(4.0))
    @Expect(r.c2.x, Float64(4.0))
    @Expect(r.c2.y, Float64(4.0))
    @Expect(r.c2.z, Float64(4.0))
    @Expect(r.c2.w, Float64(4.0))
}

@Test
func testScalarDivMat4x2Float32(): Unit {
    let m = Mat4x2<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5))
    let r = div(Float32(30.0), m)
    @Expect(r.c0.x, Float32(20.0))
    @Expect(r.c0.y, Float32(20.0))
    @Expect(r.c1.x, Float32(20.0))
    @Expect(r.c1.y, Float32(20.0))
    @Expect(r.c2.x, Float32(20.0))
    @Expect(r.c2.y, Float32(20.0))
    @Expect(r.c3.x, Float32(20.0))
    @Expect(r.c3.y, Float32(20.0))
}

@Test
func testScalarDivMat4x2Float64(): Unit {
    let m = Mat4x2<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5))
    let r = div(Float64(10.0), m)
    @Expect(r.c0.x, Float64(4.0))
    @Expect(r.c0.y, Float64(4.0))
    @Expect(r.c1.x, Float64(4.0))
    @Expect(r.c1.y, Float64(4.0))
    @Expect(r.c2.x, Float64(4.0))
    @Expect(r.c2.y, Float64(4.0))
    @Expect(r.c3.x, Float64(4.0))
    @Expect(r.c3.y, Float64(4.0))
}

@Test
func testScalarDivMat4x3Float32(): Unit {
    let m = Mat4x3<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5))
    let r = div(Float32(30.0), m)
    @Expect(r.c0.x, Float32(20.0))
    @Expect(r.c0.y, Float32(20.0))
    @Expect(r.c0.z, Float32(20.0))
    @Expect(r.c1.x, Float32(20.0))
    @Expect(r.c1.y, Float32(20.0))
    @Expect(r.c1.z, Float32(20.0))
    @Expect(r.c2.x, Float32(20.0))
    @Expect(r.c2.y, Float32(20.0))
    @Expect(r.c2.z, Float32(20.0))
    @Expect(r.c3.x, Float32(20.0))
    @Expect(r.c3.y, Float32(20.0))
    @Expect(r.c3.z, Float32(20.0))
}

@Test
func testScalarDivMat4x3Float64(): Unit {
    let m = Mat4x3<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5))
    let r = div(Float64(10.0), m)
    @Expect(r.c0.x, Float64(4.0))
    @Expect(r.c0.y, Float64(4.0))
    @Expect(r.c0.z, Float64(4.0))
    @Expect(r.c1.x, Float64(4.0))
    @Expect(r.c1.y, Float64(4.0))
    @Expect(r.c1.z, Float64(4.0))
    @Expect(r.c2.x, Float64(4.0))
    @Expect(r.c2.y, Float64(4.0))
    @Expect(r.c2.z, Float64(4.0))
    @Expect(r.c3.x, Float64(4.0))
    @Expect(r.c3.y, Float64(4.0))
    @Expect(r.c3.z, Float64(4.0))
}
