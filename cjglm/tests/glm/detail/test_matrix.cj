package glm.detail

import std.unittest.*
import std.unittest.testmacro.*

@Test
func testTransposeMat2x2(): Unit {
    let m = Mat2x2<Int64, Defaultp>(1, 2, 3, 4)
    let t = transpose(m)
    @Expect(t.c0.x, 1)
    @Expect(t.c0.y, 3)
    @Expect(t.c1.x, 2)
    @Expect(t.c1.y, 4)
    let tt = transpose(t)
    @Expect(tt.c0.x, 1)
    @Expect(tt.c0.y, 2)
    @Expect(tt.c1.x, 3)
    @Expect(tt.c1.y, 4)
}

@Test
func testTransposeMat2x3(): Unit {
    let m = Mat2x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let t = transpose(m)
    @Expect(t.c0.x, 1)
    @Expect(t.c0.y, 4)
    @Expect(t.c1.x, 2)
    @Expect(t.c1.y, 5)
    @Expect(t.c2.x, 3)
    @Expect(t.c2.y, 6)
}

@Test
func testTransposeMat2x4(): Unit {
    let m = Mat2x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let t = transpose(m)
    @Expect(t.c0.x, 1)
    @Expect(t.c0.y, 5)
    @Expect(t.c1.x, 2)
    @Expect(t.c1.y, 6)
    @Expect(t.c2.x, 3)
    @Expect(t.c2.y, 7)
    @Expect(t.c3.x, 4)
    @Expect(t.c3.y, 8)
}

@Test
func testTransposeMat3x2(): Unit {
    let m = Mat3x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let t = transpose(m)
    @Expect(t.c0.x, 1)
    @Expect(t.c0.y, 2)
    @Expect(t.c0.z, 3)
    @Expect(t.c1.x, 4)
    @Expect(t.c1.y, 5)
    @Expect(t.c1.z, 6)
}

@Test
func testTransposeMat3x3(): Unit {
    let m = Mat3x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9)
    let t = transpose(m)
    @Expect(t.c0.x, 1)
    @Expect(t.c0.y, 4)
    @Expect(t.c0.z, 7)
    @Expect(t.c1.x, 2)
    @Expect(t.c1.y, 5)
    @Expect(t.c1.z, 8)
    @Expect(t.c2.x, 3)
    @Expect(t.c2.y, 6)
    @Expect(t.c2.z, 9)
}

@Test
func testTransposeMat3x4(): Unit {
    let m = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let t = transpose(m)
    @Expect(t.c0.x, 1)
    @Expect(t.c0.y, 5)
    @Expect(t.c0.z, 9)
    @Expect(t.c1.x, 2)
    @Expect(t.c1.y, 6)
    @Expect(t.c1.z, 10)
    @Expect(t.c2.x, 3)
    @Expect(t.c2.y, 7)
    @Expect(t.c2.z, 11)
    @Expect(t.c3.x, 4)
    @Expect(t.c3.y, 8)
    @Expect(t.c3.z, 12)
}

@Test
func testTransposeMat4x2(): Unit {
    let m = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let t = transpose(m)
    @Expect(t.c0.x, 1)
    @Expect(t.c0.y, 2)
    @Expect(t.c0.z, 3)
    @Expect(t.c0.w, 4)
    @Expect(t.c1.x, 5)
    @Expect(t.c1.y, 6)
    @Expect(t.c1.z, 7)
    @Expect(t.c1.w, 8)
}

@Test
func testTransposeMat4x3(): Unit {
    let m = Mat4x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let t = transpose(m)
    @Expect(t.c0.x, 1)
    @Expect(t.c0.y, 4)
    @Expect(t.c0.z, 7)
    @Expect(t.c0.w, 10)
    @Expect(t.c1.x, 2)
    @Expect(t.c1.y, 5)
    @Expect(t.c1.z, 8)
    @Expect(t.c1.w, 11)
    @Expect(t.c2.x, 3)
    @Expect(t.c2.y, 6)
    @Expect(t.c2.z, 9)
    @Expect(t.c2.w, 12)
}

@Test
func testTransposeMat4x4(): Unit {
    let m = Mat4x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    let t = transpose(m)
    @Expect(t.c0.x, 1)
    @Expect(t.c0.y, 5)
    @Expect(t.c0.z, 9)
    @Expect(t.c0.w, 13)
    @Expect(t.c1.x, 2)
    @Expect(t.c1.y, 6)
    @Expect(t.c1.z, 10)
    @Expect(t.c1.w, 14)
    @Expect(t.c2.x, 3)
    @Expect(t.c2.y, 7)
    @Expect(t.c2.z, 11)
    @Expect(t.c2.w, 15)
    @Expect(t.c3.x, 4)
    @Expect(t.c3.y, 8)
    @Expect(t.c3.z, 12)
    @Expect(t.c3.w, 16)
    let tt = transpose(t)
    @Expect(tt.c0.x, 1)
    @Expect(tt.c0.y, 2)
    @Expect(tt.c0.z, 3)
    @Expect(tt.c0.w, 4)
    @Expect(tt.c1.x, 5)
    @Expect(tt.c1.y, 6)
    @Expect(tt.c1.z, 7)
    @Expect(tt.c1.w, 8)
    @Expect(tt.c2.x, 9)
    @Expect(tt.c2.y, 10)
    @Expect(tt.c2.z, 11)
    @Expect(tt.c2.w, 12)
    @Expect(tt.c3.x, 13)
    @Expect(tt.c3.y, 14)
    @Expect(tt.c3.z, 15)
    @Expect(tt.c3.w, 16)
}

@Test
func testMatrixCompMultMat2x2(): Unit {
    let x = Mat2x2<Int64, Defaultp>(1, 2, 3, 4)
    let y = Mat2x2<Int64, Defaultp>(5, 6, 7, 8)
    let r = matrixCompMult(x, y)
    @Expect(r.c0.x, 1 * 5)
    @Expect(r.c0.y, 2 * 6)
    @Expect(r.c1.x, 3 * 7)
    @Expect(r.c1.y, 4 * 8)
}

@Test
func testMatrixCompMultMat2x3(): Unit {
    let x = Mat2x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let y = Mat2x3<Int64, Defaultp>(2, 3, 4, 5, 6, 7)
    let r = matrixCompMult(x, y)
    @Expect(r.c0.x, 1 * 2)
    @Expect(r.c0.y, 2 * 3)
    @Expect(r.c0.z, 3 * 4)
    @Expect(r.c1.x, 4 * 5)
    @Expect(r.c1.y, 5 * 6)
    @Expect(r.c1.z, 6 * 7)
}

@Test
func testMatrixCompMultMat4x4(): Unit {
    let x = Mat4x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    let y = Mat4x4<Int64, Defaultp>(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
    let r = matrixCompMult(x, y)
    @Expect(r.c0.x, 1)
    @Expect(r.c0.y, 2)
    @Expect(r.c0.z, 3)
    @Expect(r.c0.w, 4)
    @Expect(r.c1.x, 5)
    @Expect(r.c1.y, 6)
    @Expect(r.c1.z, 7)
    @Expect(r.c1.w, 8)
    @Expect(r.c2.x, 9)
    @Expect(r.c2.y, 10)
    @Expect(r.c2.z, 11)
    @Expect(r.c2.w, 12)
    @Expect(r.c3.x, 13)
    @Expect(r.c3.y, 14)
    @Expect(r.c3.z, 15)
    @Expect(r.c3.w, 16)
}

@Test
func testOuterProductVec2Vec2(): Unit {
    let c = Vec2<Int64, Defaultp>(2, 3)
    let r = Vec2<Int64, Defaultp>(5, 7)
    let m = outerProduct(c, r)
    @Expect(m.c0.x, 2 * 5)
    @Expect(m.c0.y, 3 * 5)
    @Expect(m.c1.x, 2 * 7)
    @Expect(m.c1.y, 3 * 7)
}

@Test
func testOuterProductVec3Vec2(): Unit {
    let c = Vec3<Int64, Defaultp>(2, 3, 5)
    let r = Vec2<Int64, Defaultp>(7, 11)
    let m = outerProduct(c, r)
    @Expect(m.c0.x, 2 * 7)
    @Expect(m.c0.y, 3 * 7)
    @Expect(m.c0.z, 5 * 7)
    @Expect(m.c1.x, 2 * 11)
    @Expect(m.c1.y, 3 * 11)
    @Expect(m.c1.z, 5 * 11)
}

@Test
func testOuterProductVec4Vec4(): Unit {
    let c = Vec4<Int64, Defaultp>(1, 2, 3, 4)
    let r = Vec4<Int64, Defaultp>(2, 3, 4, 5)
    let m = outerProduct(c, r)
    @Expect(m.c0.x, 1 * 2)
    @Expect(m.c0.y, 2 * 2)
    @Expect(m.c0.z, 3 * 2)
    @Expect(m.c0.w, 4 * 2)
    @Expect(m.c1.x, 1 * 3)
    @Expect(m.c1.y, 2 * 3)
    @Expect(m.c1.z, 3 * 3)
    @Expect(m.c1.w, 4 * 3)
    @Expect(m.c2.x, 1 * 4)
    @Expect(m.c2.y, 2 * 4)
    @Expect(m.c2.z, 3 * 4)
    @Expect(m.c2.w, 4 * 4)
    @Expect(m.c3.x, 1 * 5)
    @Expect(m.c3.y, 2 * 5)
    @Expect(m.c3.z, 3 * 5)
    @Expect(m.c3.w, 4 * 5)
}

@Test
func testDeterminantMat2x2Stub(): Unit {
    let m = Mat2x2<Int64, Defaultp>(1, 2, 3, 4)
    try {
        determinant(m)
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}

@Test
func testDeterminantMat3x3Stub(): Unit {
    let m = Mat3x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9)
    try {
        determinant(m)
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}

@Test
func testDeterminantMat4x4Stub(): Unit {
    let m = Mat4x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    try {
        determinant(m)
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}

@Test
func testInverseMat2x2Stub(): Unit {
    let m = Mat2x2<Int64, Defaultp>(1, 2, 3, 4)
    try {
        inverse(m)
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}

@Test
func testInverseMat3x3Stub(): Unit {
    let m = Mat3x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9)
    try {
        inverse(m)
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}

@Test
func testInverseMat4x4Stub(): Unit {
    let m = Mat4x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    try {
        inverse(m)
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}

@Test
func testMatrixCompMultMat2x4(): Unit {
    let x = Mat2x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let y = Mat2x4<Int64, Defaultp>(2, 3, 4, 5, 6, 7, 8, 9)
    let r = matrixCompMult(x, y)
    @Expect(r.c0.x, 1 * 2)
    @Expect(r.c0.y, 2 * 3)
    @Expect(r.c0.z, 3 * 4)
    @Expect(r.c0.w, 4 * 5)
    @Expect(r.c1.x, 5 * 6)
    @Expect(r.c1.y, 6 * 7)
    @Expect(r.c1.z, 7 * 8)
    @Expect(r.c1.w, 8 * 9)
}

@Test
func testMatrixCompMultMat3x2(): Unit {
    let x = Mat3x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6)
    let y = Mat3x2<Int64, Defaultp>(2, 3, 4, 5, 6, 7)
    let r = matrixCompMult(x, y)
    @Expect(r.c0.x, 1 * 2)
    @Expect(r.c0.y, 2 * 3)
    @Expect(r.c1.x, 3 * 4)
    @Expect(r.c1.y, 4 * 5)
    @Expect(r.c2.x, 5 * 6)
    @Expect(r.c2.y, 6 * 7)
}

@Test
func testMatrixCompMultMat3x3(): Unit {
    let x = Mat3x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9)
    let y = Mat3x3<Int64, Defaultp>(1, 1, 1, 1, 1, 1, 1, 1, 1)
    let r = matrixCompMult(x, y)
    @Expect(r.c0.x, 1)
    @Expect(r.c0.y, 2)
    @Expect(r.c0.z, 3)
    @Expect(r.c1.x, 4)
    @Expect(r.c1.y, 5)
    @Expect(r.c1.z, 6)
    @Expect(r.c2.x, 7)
    @Expect(r.c2.y, 8)
    @Expect(r.c2.z, 9)
}

@Test
func testMatrixCompMultMat3x4(): Unit {
    let x = Mat3x4<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let y = Mat3x4<Int64, Defaultp>(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
    let r = matrixCompMult(x, y)
    @Expect(r.c0.x, 1)
    @Expect(r.c0.y, 2)
    @Expect(r.c0.z, 3)
    @Expect(r.c0.w, 4)
    @Expect(r.c1.x, 5)
    @Expect(r.c1.y, 6)
    @Expect(r.c1.z, 7)
    @Expect(r.c1.w, 8)
    @Expect(r.c2.x, 9)
    @Expect(r.c2.y, 10)
    @Expect(r.c2.z, 11)
    @Expect(r.c2.w, 12)
}

@Test
func testMatrixCompMultMat4x2(): Unit {
    let x = Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)
    let y = Mat4x2<Int64, Defaultp>(2, 3, 4, 5, 6, 7, 8, 9)
    let r = matrixCompMult(x, y)
    @Expect(r.c0.x, 1 * 2)
    @Expect(r.c0.y, 2 * 3)
    @Expect(r.c1.x, 3 * 4)
    @Expect(r.c1.y, 4 * 5)
    @Expect(r.c2.x, 5 * 6)
    @Expect(r.c2.y, 6 * 7)
    @Expect(r.c3.x, 7 * 8)
    @Expect(r.c3.y, 8 * 9)
}

@Test
func testMatrixCompMultMat4x3(): Unit {
    let x = Mat4x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    let y = Mat4x3<Int64, Defaultp>(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)
    let r = matrixCompMult(x, y)
    @Expect(r.c0.x, 1)
    @Expect(r.c0.y, 2)
    @Expect(r.c0.z, 3)
    @Expect(r.c1.x, 4)
    @Expect(r.c1.y, 5)
    @Expect(r.c1.z, 6)
    @Expect(r.c2.x, 7)
    @Expect(r.c2.y, 8)
    @Expect(r.c2.z, 9)
    @Expect(r.c3.x, 10)
    @Expect(r.c3.y, 11)
    @Expect(r.c3.z, 12)
}

@Test
func testOuterProductVec2Vec3(): Unit {
    let c = Vec2<Int64, Defaultp>(2, 3)
    let r = Vec3<Int64, Defaultp>(5, 7, 11)
    let m = outerProduct(c, r)
    @Expect(m.c0.x, 2 * 5)
    @Expect(m.c0.y, 3 * 5)
    @Expect(m.c1.x, 2 * 7)
    @Expect(m.c1.y, 3 * 7)
    @Expect(m.c2.x, 2 * 11)
    @Expect(m.c2.y, 3 * 11)
}

@Test
func testOuterProductVec2Vec4(): Unit {
    let c = Vec2<Int64, Defaultp>(2, 3)
    let r = Vec4<Int64, Defaultp>(5, 7, 11, 13)
    let m = outerProduct(c, r)
    @Expect(m.c0.x, 2 * 5)
    @Expect(m.c0.y, 3 * 5)
    @Expect(m.c1.x, 2 * 7)
    @Expect(m.c1.y, 3 * 7)
    @Expect(m.c2.x, 2 * 11)
    @Expect(m.c2.y, 3 * 11)
    @Expect(m.c3.x, 2 * 13)
    @Expect(m.c3.y, 3 * 13)
}

@Test
func testOuterProductVec3Vec3(): Unit {
    let c = Vec3<Int64, Defaultp>(2, 3, 5)
    let r = Vec3<Int64, Defaultp>(7, 11, 13)
    let m = outerProduct(c, r)
    @Expect(m.c0.x, 2 * 7)
    @Expect(m.c0.y, 3 * 7)
    @Expect(m.c0.z, 5 * 7)
    @Expect(m.c1.x, 2 * 11)
    @Expect(m.c1.y, 3 * 11)
    @Expect(m.c1.z, 5 * 11)
    @Expect(m.c2.x, 2 * 13)
    @Expect(m.c2.y, 3 * 13)
    @Expect(m.c2.z, 5 * 13)
}

@Test
func testOuterProductVec3Vec4(): Unit {
    let c = Vec3<Int64, Defaultp>(2, 3, 5)
    let r = Vec4<Int64, Defaultp>(7, 11, 13, 17)
    let m = outerProduct(c, r)
    @Expect(m.c0.x, 2 * 7)
    @Expect(m.c0.y, 3 * 7)
    @Expect(m.c0.z, 5 * 7)
    @Expect(m.c1.x, 2 * 11)
    @Expect(m.c1.y, 3 * 11)
    @Expect(m.c1.z, 5 * 11)
    @Expect(m.c2.x, 2 * 13)
    @Expect(m.c2.y, 3 * 13)
    @Expect(m.c2.z, 5 * 13)
    @Expect(m.c3.x, 2 * 17)
    @Expect(m.c3.y, 3 * 17)
    @Expect(m.c3.z, 5 * 17)
}

@Test
func testOuterProductVec4Vec2(): Unit {
    let c = Vec4<Int64, Defaultp>(1, 2, 3, 4)
    let r = Vec2<Int64, Defaultp>(5, 7)
    let m = outerProduct(c, r)
    @Expect(m.c0.x, 1 * 5)
    @Expect(m.c0.y, 2 * 5)
    @Expect(m.c0.z, 3 * 5)
    @Expect(m.c0.w, 4 * 5)
    @Expect(m.c1.x, 1 * 7)
    @Expect(m.c1.y, 2 * 7)
    @Expect(m.c1.z, 3 * 7)
    @Expect(m.c1.w, 4 * 7)
}

@Test
func testOuterProductVec4Vec3(): Unit {
    let c = Vec4<Int64, Defaultp>(1, 2, 3, 4)
    let r = Vec3<Int64, Defaultp>(5, 7, 11)
    let m = outerProduct(c, r)
    @Expect(m.c0.x, 1 * 5)
    @Expect(m.c0.y, 2 * 5)
    @Expect(m.c0.z, 3 * 5)
    @Expect(m.c0.w, 4 * 5)
    @Expect(m.c1.x, 1 * 7)
    @Expect(m.c1.y, 2 * 7)
    @Expect(m.c1.z, 3 * 7)
    @Expect(m.c1.w, 4 * 7)
    @Expect(m.c2.x, 1 * 11)
    @Expect(m.c2.y, 2 * 11)
    @Expect(m.c2.z, 3 * 11)
    @Expect(m.c2.w, 4 * 11)
}

@Test
func testMatrixCompMultMat2x4Float32(): Unit {
    let x = Mat2x4<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5))
    let y = Mat2x4<Float32, Defaultp>(Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0))
    let r = matrixCompMult(x, y)
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
func testMatrixCompMultMat2x4Float64(): Unit {
    let x = Mat2x4<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5))
    let y = Mat2x4<Float64, Defaultp>(Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0))
    let r = matrixCompMult(x, y)
    @Expect(r.c0.x, Float64(10.0))
    @Expect(r.c0.y, Float64(10.0))
    @Expect(r.c0.z, Float64(10.0))
    @Expect(r.c0.w, Float64(10.0))
    @Expect(r.c1.x, Float64(10.0))
    @Expect(r.c1.y, Float64(10.0))
    @Expect(r.c1.z, Float64(10.0))
    @Expect(r.c1.w, Float64(10.0))
}

@Test
func testMatrixCompMultMat3x2Float32(): Unit {
    let x = Mat3x2<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5))
    let y = Mat3x2<Float32, Defaultp>(Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0))
    let r = matrixCompMult(x, y)
    @Expect(r.c0.x, Float32(3.0))
    @Expect(r.c0.y, Float32(3.0))
    @Expect(r.c1.x, Float32(3.0))
    @Expect(r.c1.y, Float32(3.0))
    @Expect(r.c2.x, Float32(3.0))
    @Expect(r.c2.y, Float32(3.0))
}

@Test
func testMatrixCompMultMat3x2Float64(): Unit {
    let x = Mat3x2<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5))
    let y = Mat3x2<Float64, Defaultp>(Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0))
    let r = matrixCompMult(x, y)
    @Expect(r.c0.x, Float64(10.0))
    @Expect(r.c0.y, Float64(10.0))
    @Expect(r.c1.x, Float64(10.0))
    @Expect(r.c1.y, Float64(10.0))
    @Expect(r.c2.x, Float64(10.0))
    @Expect(r.c2.y, Float64(10.0))
}

@Test
func testMatrixCompMultMat3x3Float32(): Unit {
    let x = Mat3x3<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5))
    let y = Mat3x3<Float32, Defaultp>(Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0))
    let r = matrixCompMult(x, y)
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
func testMatrixCompMultMat3x3Float64(): Unit {
    let x = Mat3x3<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5))
    let y = Mat3x3<Float64, Defaultp>(Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0))
    let r = matrixCompMult(x, y)
    @Expect(r.c0.x, Float64(10.0))
    @Expect(r.c0.y, Float64(10.0))
    @Expect(r.c0.z, Float64(10.0))
    @Expect(r.c1.x, Float64(10.0))
    @Expect(r.c1.y, Float64(10.0))
    @Expect(r.c1.z, Float64(10.0))
    @Expect(r.c2.x, Float64(10.0))
    @Expect(r.c2.y, Float64(10.0))
    @Expect(r.c2.z, Float64(10.0))
}

@Test
func testMatrixCompMultMat3x4Float32(): Unit {
    let x = Mat3x4<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5))
    let y = Mat3x4<Float32, Defaultp>(Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0))
    let r = matrixCompMult(x, y)
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
func testMatrixCompMultMat3x4Float64(): Unit {
    let x = Mat3x4<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5))
    let y = Mat3x4<Float64, Defaultp>(Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0))
    let r = matrixCompMult(x, y)
    @Expect(r.c0.x, Float64(10.0))
    @Expect(r.c0.y, Float64(10.0))
    @Expect(r.c0.z, Float64(10.0))
    @Expect(r.c0.w, Float64(10.0))
    @Expect(r.c1.x, Float64(10.0))
    @Expect(r.c1.y, Float64(10.0))
    @Expect(r.c1.z, Float64(10.0))
    @Expect(r.c1.w, Float64(10.0))
    @Expect(r.c2.x, Float64(10.0))
    @Expect(r.c2.y, Float64(10.0))
    @Expect(r.c2.z, Float64(10.0))
    @Expect(r.c2.w, Float64(10.0))
}

@Test
func testMatrixCompMultMat4x2Float32(): Unit {
    let x = Mat4x2<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5))
    let y = Mat4x2<Float32, Defaultp>(Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0))
    let r = matrixCompMult(x, y)
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
func testMatrixCompMultMat4x2Float64(): Unit {
    let x = Mat4x2<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5))
    let y = Mat4x2<Float64, Defaultp>(Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0))
    let r = matrixCompMult(x, y)
    @Expect(r.c0.x, Float64(10.0))
    @Expect(r.c0.y, Float64(10.0))
    @Expect(r.c1.x, Float64(10.0))
    @Expect(r.c1.y, Float64(10.0))
    @Expect(r.c2.x, Float64(10.0))
    @Expect(r.c2.y, Float64(10.0))
    @Expect(r.c3.x, Float64(10.0))
    @Expect(r.c3.y, Float64(10.0))
}

@Test
func testMatrixCompMultMat4x3Float32(): Unit {
    let x = Mat4x3<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5))
    let y = Mat4x3<Float32, Defaultp>(Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0))
    let r = matrixCompMult(x, y)
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
func testMatrixCompMultMat4x3Float64(): Unit {
    let x = Mat4x3<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5))
    let y = Mat4x3<Float64, Defaultp>(Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0))
    let r = matrixCompMult(x, y)
    @Expect(r.c0.x, Float64(10.0))
    @Expect(r.c0.y, Float64(10.0))
    @Expect(r.c0.z, Float64(10.0))
    @Expect(r.c1.x, Float64(10.0))
    @Expect(r.c1.y, Float64(10.0))
    @Expect(r.c1.z, Float64(10.0))
    @Expect(r.c2.x, Float64(10.0))
    @Expect(r.c2.y, Float64(10.0))
    @Expect(r.c2.z, Float64(10.0))
    @Expect(r.c3.x, Float64(10.0))
    @Expect(r.c3.y, Float64(10.0))
    @Expect(r.c3.z, Float64(10.0))
}

@Test
func testOuterProductVec2Vec3Float32(): Unit {
    let c = Vec2<Float32, Defaultp>(Float32(1.5), Float32(1.5))
    let r = Vec3<Float32, Defaultp>(Float32(2.0), Float32(2.0), Float32(2.0))
    let m = outerProduct(c, r)
    @Expect(m.c0.x, Float32(3.0))
    @Expect(m.c0.y, Float32(3.0))
    @Expect(m.c1.x, Float32(3.0))
    @Expect(m.c1.y, Float32(3.0))
    @Expect(m.c2.x, Float32(3.0))
    @Expect(m.c2.y, Float32(3.0))
}

@Test
func testOuterProductVec2Vec3Float64(): Unit {
    let c = Vec2<Float64, Defaultp>(Float64(2.5), Float64(2.5))
    let r = Vec3<Float64, Defaultp>(Float64(4.0), Float64(4.0), Float64(4.0))
    let m = outerProduct(c, r)
    @Expect(m.c0.x, Float64(10.0))
    @Expect(m.c0.y, Float64(10.0))
    @Expect(m.c1.x, Float64(10.0))
    @Expect(m.c1.y, Float64(10.0))
    @Expect(m.c2.x, Float64(10.0))
    @Expect(m.c2.y, Float64(10.0))
}

@Test
func testOuterProductVec2Vec4Float32(): Unit {
    let c = Vec2<Float32, Defaultp>(Float32(1.5), Float32(1.5))
    let r = Vec4<Float32, Defaultp>(Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0))
    let m = outerProduct(c, r)
    @Expect(m.c0.x, Float32(3.0))
    @Expect(m.c0.y, Float32(3.0))
    @Expect(m.c1.x, Float32(3.0))
    @Expect(m.c1.y, Float32(3.0))
    @Expect(m.c2.x, Float32(3.0))
    @Expect(m.c2.y, Float32(3.0))
    @Expect(m.c3.x, Float32(3.0))
    @Expect(m.c3.y, Float32(3.0))
}

@Test
func testOuterProductVec2Vec4Float64(): Unit {
    let c = Vec2<Float64, Defaultp>(Float64(2.5), Float64(2.5))
    let r = Vec4<Float64, Defaultp>(Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0))
    let m = outerProduct(c, r)
    @Expect(m.c0.x, Float64(10.0))
    @Expect(m.c0.y, Float64(10.0))
    @Expect(m.c1.x, Float64(10.0))
    @Expect(m.c1.y, Float64(10.0))
    @Expect(m.c2.x, Float64(10.0))
    @Expect(m.c2.y, Float64(10.0))
    @Expect(m.c3.x, Float64(10.0))
    @Expect(m.c3.y, Float64(10.0))
}

@Test
func testOuterProductVec3Vec3Float32(): Unit {
    let c = Vec3<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5))
    let r = Vec3<Float32, Defaultp>(Float32(2.0), Float32(2.0), Float32(2.0))
    let m = outerProduct(c, r)
    @Expect(m.c0.x, Float32(3.0))
    @Expect(m.c0.y, Float32(3.0))
    @Expect(m.c0.z, Float32(3.0))
    @Expect(m.c1.x, Float32(3.0))
    @Expect(m.c1.y, Float32(3.0))
    @Expect(m.c1.z, Float32(3.0))
    @Expect(m.c2.x, Float32(3.0))
    @Expect(m.c2.y, Float32(3.0))
    @Expect(m.c2.z, Float32(3.0))
}

@Test
func testOuterProductVec3Vec3Float64(): Unit {
    let c = Vec3<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5))
    let r = Vec3<Float64, Defaultp>(Float64(4.0), Float64(4.0), Float64(4.0))
    let m = outerProduct(c, r)
    @Expect(m.c0.x, Float64(10.0))
    @Expect(m.c0.y, Float64(10.0))
    @Expect(m.c0.z, Float64(10.0))
    @Expect(m.c1.x, Float64(10.0))
    @Expect(m.c1.y, Float64(10.0))
    @Expect(m.c1.z, Float64(10.0))
    @Expect(m.c2.x, Float64(10.0))
    @Expect(m.c2.y, Float64(10.0))
    @Expect(m.c2.z, Float64(10.0))
}

@Test
func testOuterProductVec3Vec4Float32(): Unit {
    let c = Vec3<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5))
    let r = Vec4<Float32, Defaultp>(Float32(2.0), Float32(2.0), Float32(2.0), Float32(2.0))
    let m = outerProduct(c, r)
    @Expect(m.c0.x, Float32(3.0))
    @Expect(m.c0.y, Float32(3.0))
    @Expect(m.c0.z, Float32(3.0))
    @Expect(m.c1.x, Float32(3.0))
    @Expect(m.c1.y, Float32(3.0))
    @Expect(m.c1.z, Float32(3.0))
    @Expect(m.c2.x, Float32(3.0))
    @Expect(m.c2.y, Float32(3.0))
    @Expect(m.c2.z, Float32(3.0))
    @Expect(m.c3.x, Float32(3.0))
    @Expect(m.c3.y, Float32(3.0))
    @Expect(m.c3.z, Float32(3.0))
}

@Test
func testOuterProductVec3Vec4Float64(): Unit {
    let c = Vec3<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5))
    let r = Vec4<Float64, Defaultp>(Float64(4.0), Float64(4.0), Float64(4.0), Float64(4.0))
    let m = outerProduct(c, r)
    @Expect(m.c0.x, Float64(10.0))
    @Expect(m.c0.y, Float64(10.0))
    @Expect(m.c0.z, Float64(10.0))
    @Expect(m.c1.x, Float64(10.0))
    @Expect(m.c1.y, Float64(10.0))
    @Expect(m.c1.z, Float64(10.0))
    @Expect(m.c2.x, Float64(10.0))
    @Expect(m.c2.y, Float64(10.0))
    @Expect(m.c2.z, Float64(10.0))
    @Expect(m.c3.x, Float64(10.0))
    @Expect(m.c3.y, Float64(10.0))
    @Expect(m.c3.z, Float64(10.0))
}

@Test
func testOuterProductVec4Vec2Float32(): Unit {
    let c = Vec4<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5))
    let r = Vec2<Float32, Defaultp>(Float32(2.0), Float32(2.0))
    let m = outerProduct(c, r)
    @Expect(m.c0.x, Float32(3.0))
    @Expect(m.c0.y, Float32(3.0))
    @Expect(m.c0.z, Float32(3.0))
    @Expect(m.c0.w, Float32(3.0))
    @Expect(m.c1.x, Float32(3.0))
    @Expect(m.c1.y, Float32(3.0))
    @Expect(m.c1.z, Float32(3.0))
    @Expect(m.c1.w, Float32(3.0))
}

@Test
func testOuterProductVec4Vec2Float64(): Unit {
    let c = Vec4<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5))
    let r = Vec2<Float64, Defaultp>(Float64(4.0), Float64(4.0))
    let m = outerProduct(c, r)
    @Expect(m.c0.x, Float64(10.0))
    @Expect(m.c0.y, Float64(10.0))
    @Expect(m.c0.z, Float64(10.0))
    @Expect(m.c0.w, Float64(10.0))
    @Expect(m.c1.x, Float64(10.0))
    @Expect(m.c1.y, Float64(10.0))
    @Expect(m.c1.z, Float64(10.0))
    @Expect(m.c1.w, Float64(10.0))
}

@Test
func testOuterProductVec4Vec3Float32(): Unit {
    let c = Vec4<Float32, Defaultp>(Float32(1.5), Float32(1.5), Float32(1.5), Float32(1.5))
    let r = Vec3<Float32, Defaultp>(Float32(2.0), Float32(2.0), Float32(2.0))
    let m = outerProduct(c, r)
    @Expect(m.c0.x, Float32(3.0))
    @Expect(m.c0.y, Float32(3.0))
    @Expect(m.c0.z, Float32(3.0))
    @Expect(m.c0.w, Float32(3.0))
    @Expect(m.c1.x, Float32(3.0))
    @Expect(m.c1.y, Float32(3.0))
    @Expect(m.c1.z, Float32(3.0))
    @Expect(m.c1.w, Float32(3.0))
    @Expect(m.c2.x, Float32(3.0))
    @Expect(m.c2.y, Float32(3.0))
    @Expect(m.c2.z, Float32(3.0))
    @Expect(m.c2.w, Float32(3.0))
}

@Test
func testOuterProductVec4Vec3Float64(): Unit {
    let c = Vec4<Float64, Defaultp>(Float64(2.5), Float64(2.5), Float64(2.5), Float64(2.5))
    let r = Vec3<Float64, Defaultp>(Float64(4.0), Float64(4.0), Float64(4.0))
    let m = outerProduct(c, r)
    @Expect(m.c0.x, Float64(10.0))
    @Expect(m.c0.y, Float64(10.0))
    @Expect(m.c0.z, Float64(10.0))
    @Expect(m.c0.w, Float64(10.0))
    @Expect(m.c1.x, Float64(10.0))
    @Expect(m.c1.y, Float64(10.0))
    @Expect(m.c1.z, Float64(10.0))
    @Expect(m.c1.w, Float64(10.0))
    @Expect(m.c2.x, Float64(10.0))
    @Expect(m.c2.y, Float64(10.0))
    @Expect(m.c2.z, Float64(10.0))
    @Expect(m.c2.w, Float64(10.0))
}

// --- NaN propagation tests for Mat4x4 ---

@Test
func testMat4x4MulVec4NaNColFloat32(): Unit {
    let nan = Float32(0.0) / Float32(0.0)
    var m = Mat4x4<Float32, Defaultp>.identity(Float32(1.0))
    m[Int64(2)] = Vec4<Float32, Defaultp>(Float32(0.0), Float32(0.0), nan, Float32(0.0))
    let v = Vec4<Float32, Defaultp>(Float32(1.0), Float32(1.0), Float32(1.0), Float32(1.0))
    let r = m * v
    @Expect(r.x != r.x, false)
    @Expect(r.y != r.y, false)
    @Expect(r.z != r.z, true)
    @Expect(r.w != r.w, false)
}

@Test
func testMat4x4MulVec4NaNColFloat64(): Unit {
    let nan = Float64(0.0) / Float64(0.0)
    var m = Mat4x4<Float64, Defaultp>.identity(Float64(1.0))
    m[Int64(2)] = Vec4<Float64, Defaultp>(Float64(0.0), Float64(0.0), nan, Float64(0.0))
    let v = Vec4<Float64, Defaultp>(Float64(1.0), Float64(1.0), Float64(1.0), Float64(1.0))
    let r = m * v
    @Expect(r.x != r.x, false)
    @Expect(r.y != r.y, false)
    @Expect(r.z != r.z, true)
    @Expect(r.w != r.w, false)
}

@Test
func testVec4MulMat4x4NaNCompFloat32(): Unit {
    let nan = Float32(0.0) / Float32(0.0)
    let m = Mat4x4<Float32, Defaultp>.identity(Float32(1.0))
    let v = Vec4<Float32, Defaultp>(Float32(1.0), nan, Float32(1.0), Float32(1.0))
    let r = v * m
    @Expect(r.x != r.x, true)
    @Expect(r.y != r.y, true)
    @Expect(r.z != r.z, true)
    @Expect(r.w != r.w, true)
}

@Test
func testVec4MulMat4x4NaNCompFloat64(): Unit {
    let nan = Float64(0.0) / Float64(0.0)
    let m = Mat4x4<Float64, Defaultp>.identity(Float64(1.0))
    let v = Vec4<Float64, Defaultp>(Float64(1.0), nan, Float64(1.0), Float64(1.0))
    let r = v * m
    @Expect(r.x != r.x, true)
    @Expect(r.y != r.y, true)
    @Expect(r.z != r.z, true)
    @Expect(r.w != r.w, true)
}

@Test
func testMat4x4DiagonalNaNMulVecFloat32(): Unit {
    let nan = Float32(0.0) / Float32(0.0)
    let m = Mat4x4<Float32, Defaultp>.diagonal(nan)
    let v = Vec4<Float32, Defaultp>(Float32(1.0), Float32(1.0), Float32(1.0), Float32(1.0))
    let r = m * v
    @Expect(r.x != r.x, true)
    @Expect(r.y != r.y, true)
    @Expect(r.z != r.z, true)
    @Expect(r.w != r.w, true)
}

@Test
func testMat4x4DiagonalNaNMulVecFloat64(): Unit {
    let nan = Float64(0.0) / Float64(0.0)
    let m = Mat4x4<Float64, Defaultp>.diagonal(nan)
    let v = Vec4<Float64, Defaultp>(Float64(1.0), Float64(1.0), Float64(1.0), Float64(1.0))
    let r = m * v
    @Expect(r.x != r.x, true)
    @Expect(r.y != r.y, true)
    @Expect(r.z != r.z, true)
    @Expect(r.w != r.w, true)
}

// --- NaN propagation tests for Mat2x3 ---

@Test
func testMat2x3MulVec2NaNColFloat32(): Unit {
    let nan = Float32(0.0) / Float32(0.0)
    var m = Mat2x3<Float32, Defaultp>.identity(Float32(1.0))
    m[Int64(1)] = Vec3<Float32, Defaultp>(Float32(0.0), nan, Float32(0.0))
    let v = Vec2<Float32, Defaultp>(Float32(1.0), Float32(1.0))
    let r = m * v
    @Expect(r.x != r.x, false)
    @Expect(r.y != r.y, true)
    @Expect(r.z != r.z, false)
}

@Test
func testMat2x3MulVec2NaNColFloat64(): Unit {
    let nan = Float64(0.0) / Float64(0.0)
    var m = Mat2x3<Float64, Defaultp>.identity(Float64(1.0))
    m[Int64(1)] = Vec3<Float64, Defaultp>(Float64(0.0), nan, Float64(0.0))
    let v = Vec2<Float64, Defaultp>(Float64(1.0), Float64(1.0))
    let r = m * v
    @Expect(r.x != r.x, false)
    @Expect(r.y != r.y, true)
    @Expect(r.z != r.z, false)
}

@Test
func testVec3MulMat2x3NaNCompFloat32(): Unit {
    let nan = Float32(0.0) / Float32(0.0)
    let m = Mat2x3<Float32, Defaultp>.identity(Float32(1.0))
    let v = Vec3<Float32, Defaultp>(Float32(1.0), nan, Float32(1.0))
    let r = v * m
    @Expect(r.x != r.x, true)
    @Expect(r.y != r.y, true)
}

@Test
func testVec3MulMat2x3NaNCompFloat64(): Unit {
    let nan = Float64(0.0) / Float64(0.0)
    let m = Mat2x3<Float64, Defaultp>.identity(Float64(1.0))
    let v = Vec3<Float64, Defaultp>(Float64(1.0), nan, Float64(1.0))
    let r = v * m
    @Expect(r.x != r.x, true)
    @Expect(r.y != r.y, true)
}

@Test
func testMat2x3DiagonalNaNMulVecFloat32(): Unit {
    let nan = Float32(0.0) / Float32(0.0)
    let m = Mat2x3<Float32, Defaultp>.diagonal(nan)
    let v = Vec2<Float32, Defaultp>(Float32(1.0), Float32(1.0))
    let r = m * v
    @Expect(r.x != r.x, true)
    @Expect(r.y != r.y, true)
    @Expect(r.z != r.z, true)
}

@Test
func testMat2x3DiagonalNaNMulVecFloat64(): Unit {
    let nan = Float64(0.0) / Float64(0.0)
    let m = Mat2x3<Float64, Defaultp>.diagonal(nan)
    let v = Vec2<Float64, Defaultp>(Float64(1.0), Float64(1.0))
    let r = m * v
    @Expect(r.x != r.x, true)
    @Expect(r.y != r.y, true)
    @Expect(r.z != r.z, true)
}

// --- NaN propagation tests for Mat3x2 ---

@Test
func testMat3x2MulVec3NaNColFloat32(): Unit {
    let nan = Float32(0.0) / Float32(0.0)
    var m = Mat3x2<Float32, Defaultp>.identity(Float32(1.0))
    m[Int64(1)] = Vec2<Float32, Defaultp>(nan, Float32(0.0))
    let v = Vec3<Float32, Defaultp>(Float32(1.0), Float32(1.0), Float32(1.0))
    let r = m * v
    @Expect(r.x != r.x, true)
    @Expect(r.y != r.y, false)
}

@Test
func testMat3x2MulVec3NaNColFloat64(): Unit {
    let nan = Float64(0.0) / Float64(0.0)
    var m = Mat3x2<Float64, Defaultp>.identity(Float64(1.0))
    m[Int64(1)] = Vec2<Float64, Defaultp>(nan, Float64(0.0))
    let v = Vec3<Float64, Defaultp>(Float64(1.0), Float64(1.0), Float64(1.0))
    let r = m * v
    @Expect(r.x != r.x, true)
    @Expect(r.y != r.y, false)
}

@Test
func testVec2MulMat3x2NaNCompFloat32(): Unit {
    let nan = Float32(0.0) / Float32(0.0)
    let m = Mat3x2<Float32, Defaultp>.identity(Float32(1.0))
    let v = Vec2<Float32, Defaultp>(Float32(1.0), nan)
    let r = v * m
    @Expect(r.x != r.x, true)
    @Expect(r.y != r.y, true)
    @Expect(r.z != r.z, true)
}

@Test
func testVec2MulMat3x2NaNCompFloat64(): Unit {
    let nan = Float64(0.0) / Float64(0.0)
    let m = Mat3x2<Float64, Defaultp>.identity(Float64(1.0))
    let v = Vec2<Float64, Defaultp>(Float64(1.0), nan)
    let r = v * m
    @Expect(r.x != r.x, true)
    @Expect(r.y != r.y, true)
    @Expect(r.z != r.z, true)
}

@Test
func testMat3x2DiagonalNaNMulVecFloat32(): Unit {
    let nan = Float32(0.0) / Float32(0.0)
    let m = Mat3x2<Float32, Defaultp>.diagonal(nan)
    let v = Vec3<Float32, Defaultp>(Float32(1.0), Float32(1.0), Float32(1.0))
    let r = m * v
    @Expect(r.x != r.x, true)
    @Expect(r.y != r.y, true)
}

@Test
func testMat3x2DiagonalNaNMulVecFloat64(): Unit {
    let nan = Float64(0.0) / Float64(0.0)
    let m = Mat3x2<Float64, Defaultp>.diagonal(nan)
    let v = Vec3<Float64, Defaultp>(Float64(1.0), Float64(1.0), Float64(1.0))
    let r = m * v
    @Expect(r.x != r.x, true)
    @Expect(r.y != r.y, true)
}
