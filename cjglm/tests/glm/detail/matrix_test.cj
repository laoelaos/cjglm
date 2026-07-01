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
func testDeterminantMat2x2(): Unit {
    let m = Mat2x2<Int64, Defaultp>(1, 2, 3, 4)
    @Expect(determinant(m), Int64(-2))
}

@Test
func testDeterminantMat3x3(): Unit {
    let m = Mat3x3<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8, 10)
    @Expect(determinant(m), Int64(-3))
}

@Test
func testDeterminantMat4x4(): Unit {
    let m = Mat4x4<Int64, Defaultp>(1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 3, 0, 0, 0, 0, 4)
    @Expect(determinant(m), Int64(24))
}

@Test
func testDeterminantMat2x2Float32(): Unit {
    let m = Mat2x2<Float32, Defaultp>(Float32(1.5), Float32(2.5), Float32(3.5), Float32(4.5))
    let det = determinant(m)
    @Expect(det, Float32(1.5) * Float32(4.5) - Float32(3.5) * Float32(2.5))
}

@Test
func testDeterminantMat2x2Float64(): Unit {
    let m = Mat2x2<Float64, Defaultp>(Float64(1.5), Float64(2.5), Float64(3.5), Float64(4.5))
    let det = determinant(m)
    @Expect(det, Float64(1.5) * Float64(4.5) - Float64(3.5) * Float64(2.5))
}

@Test
func testDeterminantMat3x3Float32(): Unit {
    let m = Mat3x3<Float32, Defaultp>(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0), Float32(7.0), Float32(8.0), Float32(10.0))
    let det = determinant(m)
    @Expect(det, Float32(1.0)*(Float32(5.0)*Float32(10.0)-Float32(6.0)*Float32(8.0))-Float32(2.0)*(Float32(4.0)*Float32(10.0)-Float32(6.0)*Float32(7.0))+Float32(3.0)*(Float32(4.0)*Float32(8.0)-Float32(5.0)*Float32(7.0)))
}

@Test
func testDeterminantMat3x3Float64(): Unit {
    let m = Mat3x3<Float64, Defaultp>(Float64(1.0), Float64(2.0), Float64(3.0), Float64(4.0), Float64(5.0), Float64(6.0), Float64(7.0), Float64(8.0), Float64(10.0))
    let det = determinant(m)
    @Expect(det, Float64(1.0)*(Float64(5.0)*Float64(10.0)-Float64(6.0)*Float64(8.0))-Float64(2.0)*(Float64(4.0)*Float64(10.0)-Float64(6.0)*Float64(7.0))+Float64(3.0)*(Float64(4.0)*Float64(8.0)-Float64(5.0)*Float64(7.0)))
}

@Test
func testDeterminantMat4x4Float32(): Unit {
    let m = Mat4x4<Float32, Defaultp>(Float32(1.0), Float32(0.0), Float32(0.0), Float32(0.0), Float32(0.0), Float32(2.0), Float32(0.0), Float32(0.0), Float32(0.0), Float32(0.0), Float32(3.0), Float32(0.0), Float32(0.0), Float32(0.0), Float32(0.0), Float32(4.0))
    let det = determinant(m)
    @Expect(det, Float32(1.0)*Float32(2.0)*Float32(3.0)*Float32(4.0))
}

@Test
func testDeterminantMat4x4Float64(): Unit {
    let m = Mat4x4<Float64, Defaultp>(Float64(1.0), Float64(0.0), Float64(0.0), Float64(0.0), Float64(0.0), Float64(2.0), Float64(0.0), Float64(0.0), Float64(0.0), Float64(0.0), Float64(3.0), Float64(0.0), Float64(0.0), Float64(0.0), Float64(0.0), Float64(4.0))
    let det = determinant(m)
    @Expect(det, Float64(1.0)*Float64(2.0)*Float64(3.0)*Float64(4.0))
}

@Test
func testInverseMat2x2(): Unit {
    let m = Mat2x2<Float32, Defaultp>(Float32(1), Float32(2), Float32(3), Float32(4))
    let inv = inverse(m)
    let c0x = m.c0.x * inv.c0.x + m.c1.x * inv.c0.y
    let c0y = m.c0.y * inv.c0.x + m.c1.y * inv.c0.y
    let c1x = m.c0.x * inv.c1.x + m.c1.x * inv.c1.y
    let c1y = m.c0.y * inv.c1.x + m.c1.y * inv.c1.y
    let eps = Float32(1.0e-5)
    @Expect(abs(c0x - Float32(1)) < eps, true)
    @Expect(abs(c0y) < eps, true)
    @Expect(abs(c1x) < eps, true)
    @Expect(abs(c1y - Float32(1)) < eps, true)
}

@Test
func testInverseMat3x3(): Unit {
    let one = Float32(1)
    let m = Mat3x3<Float32, Defaultp>(one, one, one, one, one, one, one, one, one)
    // singular matrix (all ones), inverse should produce NaN
    let inv = inverse(m)
    // compute m * inv component by component
    let r00 = m.c0.x * inv.c0.x + m.c1.x * inv.c0.y + m.c2.x * inv.c0.z
    @Expect(r00 != r00, true)
}

@Test
func testInverseMat4x4(): Unit {
    let one = Float32(1)
    let m = Mat4x4<Float32, Defaultp>.identity(one)
    let inv = inverse(m)
    let r00 = m.c0.x * inv.c0.x + m.c1.x * inv.c0.y + m.c2.x * inv.c0.z + m.c3.x * inv.c0.w
    let r01 = m.c0.x * inv.c1.x + m.c1.x * inv.c1.y + m.c2.x * inv.c1.z + m.c3.x * inv.c1.w
    let r02 = m.c0.x * inv.c2.x + m.c1.x * inv.c2.y + m.c2.x * inv.c2.z + m.c3.x * inv.c2.w
    let r03 = m.c0.x * inv.c3.x + m.c1.x * inv.c3.y + m.c2.x * inv.c3.z + m.c3.x * inv.c3.w
    let r10 = m.c0.y * inv.c0.x + m.c1.y * inv.c0.y + m.c2.y * inv.c0.z + m.c3.y * inv.c0.w
    let r11 = m.c0.y * inv.c1.x + m.c1.y * inv.c1.y + m.c2.y * inv.c1.z + m.c3.y * inv.c1.w
    let r12 = m.c0.y * inv.c2.x + m.c1.y * inv.c2.y + m.c2.y * inv.c2.z + m.c3.y * inv.c2.w
    let r13 = m.c0.y * inv.c3.x + m.c1.y * inv.c3.y + m.c2.y * inv.c3.z + m.c3.y * inv.c3.w
    let r20 = m.c0.z * inv.c0.x + m.c1.z * inv.c0.y + m.c2.z * inv.c0.z + m.c3.z * inv.c0.w
    let r21 = m.c0.z * inv.c1.x + m.c1.z * inv.c1.y + m.c2.z * inv.c1.z + m.c3.z * inv.c1.w
    let r22 = m.c0.z * inv.c2.x + m.c1.z * inv.c2.y + m.c2.z * inv.c2.z + m.c3.z * inv.c2.w
    let r23 = m.c0.z * inv.c3.x + m.c1.z * inv.c3.y + m.c2.z * inv.c3.z + m.c3.z * inv.c3.w
    let r30 = m.c0.w * inv.c0.x + m.c1.w * inv.c0.y + m.c2.w * inv.c0.z + m.c3.w * inv.c0.w
    let r31 = m.c0.w * inv.c1.x + m.c1.w * inv.c1.y + m.c2.w * inv.c1.z + m.c3.w * inv.c1.w
    let r32 = m.c0.w * inv.c2.x + m.c1.w * inv.c2.y + m.c2.w * inv.c2.z + m.c3.w * inv.c2.w
    let r33 = m.c0.w * inv.c3.x + m.c1.w * inv.c3.y + m.c2.w * inv.c3.z + m.c3.w * inv.c3.w
    let eps = Float32(1.0e-5)
    @Expect(abs(r00 - one) < eps, true)
    @Expect(abs(r01) < eps, true)
    @Expect(abs(r02) < eps, true)
    @Expect(abs(r03) < eps, true)
    @Expect(abs(r10) < eps, true)
    @Expect(abs(r11 - one) < eps, true)
    @Expect(abs(r12) < eps, true)
    @Expect(abs(r13) < eps, true)
    @Expect(abs(r20) < eps, true)
    @Expect(abs(r21) < eps, true)
    @Expect(abs(r22 - one) < eps, true)
    @Expect(abs(r23) < eps, true)
    @Expect(abs(r30) < eps, true)
    @Expect(abs(r31) < eps, true)
    @Expect(abs(r32) < eps, true)
    @Expect(abs(r33 - one) < eps, true)
}

@Test
func testInverseMat4x4Full(): Unit {
    let one = Float32(1)
    let m = Mat4x4<Float32, Defaultp>(one, one, one, one, one, Float32(2), Float32(3), Float32(4), one, Float32(4), Float32(9), Float32(16), one, Float32(8), Float32(27), Float32(64))
    let inv = inverse(m)
    let r00 = m.c0.x * inv.c0.x + m.c1.x * inv.c0.y + m.c2.x * inv.c0.z + m.c3.x * inv.c0.w
    let r01 = m.c0.x * inv.c1.x + m.c1.x * inv.c1.y + m.c2.x * inv.c1.z + m.c3.x * inv.c1.w
    let r02 = m.c0.x * inv.c2.x + m.c1.x * inv.c2.y + m.c2.x * inv.c2.z + m.c3.x * inv.c2.w
    let r03 = m.c0.x * inv.c3.x + m.c1.x * inv.c3.y + m.c2.x * inv.c3.z + m.c3.x * inv.c3.w
    let r10 = m.c0.y * inv.c0.x + m.c1.y * inv.c0.y + m.c2.y * inv.c0.z + m.c3.y * inv.c0.w
    let r11 = m.c0.y * inv.c1.x + m.c1.y * inv.c1.y + m.c2.y * inv.c1.z + m.c3.y * inv.c1.w
    let r12 = m.c0.y * inv.c2.x + m.c1.y * inv.c2.y + m.c2.y * inv.c2.z + m.c3.y * inv.c2.w
    let r13 = m.c0.y * inv.c3.x + m.c1.y * inv.c3.y + m.c2.y * inv.c3.z + m.c3.y * inv.c3.w
    let r20 = m.c0.z * inv.c0.x + m.c1.z * inv.c0.y + m.c2.z * inv.c0.z + m.c3.z * inv.c0.w
    let r21 = m.c0.z * inv.c1.x + m.c1.z * inv.c1.y + m.c2.z * inv.c1.z + m.c3.z * inv.c1.w
    let r22 = m.c0.z * inv.c2.x + m.c1.z * inv.c2.y + m.c2.z * inv.c2.z + m.c3.z * inv.c2.w
    let r23 = m.c0.z * inv.c3.x + m.c1.z * inv.c3.y + m.c2.z * inv.c3.z + m.c3.z * inv.c3.w
    let r30 = m.c0.w * inv.c0.x + m.c1.w * inv.c0.y + m.c2.w * inv.c0.z + m.c3.w * inv.c0.w
    let r31 = m.c0.w * inv.c1.x + m.c1.w * inv.c1.y + m.c2.w * inv.c1.z + m.c3.w * inv.c1.w
    let r32 = m.c0.w * inv.c2.x + m.c1.w * inv.c2.y + m.c2.w * inv.c2.z + m.c3.w * inv.c2.w
    let r33 = m.c0.w * inv.c3.x + m.c1.w * inv.c3.y + m.c2.w * inv.c3.z + m.c3.w * inv.c3.w
    let eps = Float32(1.0e-4)
    @Expect(abs(r00 - one) < eps, true)
    @Expect(abs(r01) < eps, true)
    @Expect(abs(r02) < eps, true)
    @Expect(abs(r03) < eps, true)
    @Expect(abs(r10) < eps, true)
    @Expect(abs(r11 - one) < eps, true)
    @Expect(abs(r12) < eps, true)
    @Expect(abs(r13) < eps, true)
    @Expect(abs(r20) < eps, true)
    @Expect(abs(r21) < eps, true)
    @Expect(abs(r22 - one) < eps, true)
    @Expect(abs(r23) < eps, true)
    @Expect(abs(r30) < eps, true)
    @Expect(abs(r31) < eps, true)
    @Expect(abs(r32) < eps, true)
    @Expect(abs(r33 - one) < eps, true)
}

@Test
func testInverseMat2x2Float32(): Unit {
    let one = Float32(1)
    let m = Mat2x2<Float32, Defaultp>(Float32(2), Float32(3), Float32(5), Float32(7))
    let inv = inverse(m)
    let r00 = m.c0.x * inv.c0.x + m.c1.x * inv.c0.y
    let r01 = m.c0.x * inv.c1.x + m.c1.x * inv.c1.y
    let r10 = m.c0.y * inv.c0.x + m.c1.y * inv.c0.y
    let r11 = m.c0.y * inv.c1.x + m.c1.y * inv.c1.y
    let eps = Float32(1.0e-5)
    @Expect(abs(r00 - one) < eps, true)
    @Expect(abs(r01) < eps, true)
    @Expect(abs(r10) < eps, true)
    @Expect(abs(r11 - one) < eps, true)
}

@Test
func testInverseMat2x2Float64(): Unit {
    let one = Float64(1)
    let m = Mat2x2<Float64, Defaultp>(Float64(2), Float64(3), Float64(5), Float64(7))
    let inv = inverse(m)
    let r00 = m.c0.x * inv.c0.x + m.c1.x * inv.c0.y
    let r01 = m.c0.x * inv.c1.x + m.c1.x * inv.c1.y
    let r10 = m.c0.y * inv.c0.x + m.c1.y * inv.c0.y
    let r11 = m.c0.y * inv.c1.x + m.c1.y * inv.c1.y
    let eps = Float64(1.0e-10)
    @Expect(abs(r00 - one) < eps, true)
    @Expect(abs(r01) < eps, true)
    @Expect(abs(r10) < eps, true)
    @Expect(abs(r11 - one) < eps, true)
}

@Test
func testInverseMat3x3Float32(): Unit {
    let one = Float32(1)
    let m = Mat3x3<Float32, Defaultp>(Float32(2), Float32(3), Float32(1), Float32(5), Float32(7), Float32(0), Float32(1), Float32(2), Float32(3))
    let inv = inverse(m)
    let r00 = m.c0.x * inv.c0.x + m.c1.x * inv.c0.y + m.c2.x * inv.c0.z
    let r01 = m.c0.x * inv.c1.x + m.c1.x * inv.c1.y + m.c2.x * inv.c1.z
    let r02 = m.c0.x * inv.c2.x + m.c1.x * inv.c2.y + m.c2.x * inv.c2.z
    let r10 = m.c0.y * inv.c0.x + m.c1.y * inv.c0.y + m.c2.y * inv.c0.z
    let r11 = m.c0.y * inv.c1.x + m.c1.y * inv.c1.y + m.c2.y * inv.c1.z
    let r12 = m.c0.y * inv.c2.x + m.c1.y * inv.c2.y + m.c2.y * inv.c2.z
    let r20 = m.c0.z * inv.c0.x + m.c1.z * inv.c0.y + m.c2.z * inv.c0.z
    let r21 = m.c0.z * inv.c1.x + m.c1.z * inv.c1.y + m.c2.z * inv.c1.z
    let r22 = m.c0.z * inv.c2.x + m.c1.z * inv.c2.y + m.c2.z * inv.c2.z
    let eps = Float32(1.0e-4)
    @Expect(abs(r00 - one) < eps, true)
    @Expect(abs(r01) < eps, true)
    @Expect(abs(r02) < eps, true)
    @Expect(abs(r10) < eps, true)
    @Expect(abs(r11 - one) < eps, true)
    @Expect(abs(r12) < eps, true)
    @Expect(abs(r20) < eps, true)
    @Expect(abs(r21) < eps, true)
    @Expect(abs(r22 - one) < eps, true)
}

@Test
func testInverseMat3x3Float64(): Unit {
    let one = Float64(1)
    let m = Mat3x3<Float64, Defaultp>(Float64(2), Float64(3), Float64(1), Float64(5), Float64(7), Float64(0), Float64(1), Float64(2), Float64(3))
    let inv = inverse(m)
    let r00 = m.c0.x * inv.c0.x + m.c1.x * inv.c0.y + m.c2.x * inv.c0.z
    let r01 = m.c0.x * inv.c1.x + m.c1.x * inv.c1.y + m.c2.x * inv.c1.z
    let r02 = m.c0.x * inv.c2.x + m.c1.x * inv.c2.y + m.c2.x * inv.c2.z
    let r10 = m.c0.y * inv.c0.x + m.c1.y * inv.c0.y + m.c2.y * inv.c0.z
    let r11 = m.c0.y * inv.c1.x + m.c1.y * inv.c1.y + m.c2.y * inv.c1.z
    let r12 = m.c0.y * inv.c2.x + m.c1.y * inv.c2.y + m.c2.y * inv.c2.z
    let r20 = m.c0.z * inv.c0.x + m.c1.z * inv.c0.y + m.c2.z * inv.c0.z
    let r21 = m.c0.z * inv.c1.x + m.c1.z * inv.c1.y + m.c2.z * inv.c1.z
    let r22 = m.c0.z * inv.c2.x + m.c1.z * inv.c2.y + m.c2.z * inv.c2.z
    let eps = Float64(1.0e-10)
    @Expect(abs(r00 - one) < eps, true)
    @Expect(abs(r01) < eps, true)
    @Expect(abs(r02) < eps, true)
    @Expect(abs(r10) < eps, true)
    @Expect(abs(r11 - one) < eps, true)
    @Expect(abs(r12) < eps, true)
    @Expect(abs(r20) < eps, true)
    @Expect(abs(r21) < eps, true)
    @Expect(abs(r22 - one) < eps, true)
}

@Test
func testInverseMat4x4Float32(): Unit {
    let one = Float32(1)
    let m = Mat4x4<Float32, Defaultp>.identity(one)
    let inv = inverse(m)
    let r00 = m.c0.x * inv.c0.x + m.c1.x * inv.c0.y + m.c2.x * inv.c0.z + m.c3.x * inv.c0.w
    let r11 = m.c0.y * inv.c1.x + m.c1.y * inv.c1.y + m.c2.y * inv.c1.z + m.c3.y * inv.c1.w
    let r22 = m.c0.z * inv.c2.x + m.c1.z * inv.c2.y + m.c2.z * inv.c2.z + m.c3.z * inv.c2.w
    let r33 = m.c0.w * inv.c3.x + m.c1.w * inv.c3.y + m.c2.w * inv.c3.z + m.c3.w * inv.c3.w
    let eps = Float32(1.0e-5)
    @Expect(abs(r00 - one) < eps, true)
    @Expect(abs(r11 - one) < eps, true)
    @Expect(abs(r22 - one) < eps, true)
    @Expect(abs(r33 - one) < eps, true)
}

@Test
func testInverseMat4x4Float64(): Unit {
    let one = Float64(1)
    let m = Mat4x4<Float64, Defaultp>.identity(one)
    let inv = inverse(m)
    let r00 = m.c0.x * inv.c0.x + m.c1.x * inv.c0.y + m.c2.x * inv.c0.z + m.c3.x * inv.c0.w
    let r11 = m.c0.y * inv.c1.x + m.c1.y * inv.c1.y + m.c2.y * inv.c1.z + m.c3.y * inv.c1.w
    let r22 = m.c0.z * inv.c2.x + m.c1.z * inv.c2.y + m.c2.z * inv.c2.z + m.c3.z * inv.c2.w
    let r33 = m.c0.w * inv.c3.x + m.c1.w * inv.c3.y + m.c2.w * inv.c3.z + m.c3.w * inv.c3.w
    let eps = Float64(1.0e-10)
    @Expect(abs(r00 - one) < eps, true)
    @Expect(abs(r11 - one) < eps, true)
    @Expect(abs(r22 - one) < eps, true)
    @Expect(abs(r33 - one) < eps, true)
}

@Test
func testInverseSingularMat2x2NaN(): Unit {
    let m = Mat2x2<Float32, Defaultp>(Float32(1), Float32(1), Float32(1), Float32(1))
    let inv = inverse(m)
    @Expect(inv.c0.x != inv.c0.x, true)
    @Expect(inv.c0.y != inv.c0.y, true)
    @Expect(inv.c1.x != inv.c1.x, true)
    @Expect(inv.c1.y != inv.c1.y, true)
}

@Test
func testInverseSingularMat3x3NaN(): Unit {
    let m = Mat3x3<Float32, Defaultp>(Float32(1), Float32(1), Float32(1), Float32(1), Float32(1), Float32(1), Float32(1), Float32(1), Float32(1))
    let inv = inverse(m)
    @Expect(inv.c0.x != inv.c0.x, true)
    @Expect(inv.c0.y != inv.c0.y, true)
    @Expect(inv.c0.z != inv.c0.z, true)
    @Expect(inv.c1.x != inv.c1.x, true)
    @Expect(inv.c1.y != inv.c1.y, true)
    @Expect(inv.c1.z != inv.c1.z, true)
    @Expect(inv.c2.x != inv.c2.x, true)
    @Expect(inv.c2.y != inv.c2.y, true)
    @Expect(inv.c2.z != inv.c2.z, true)
}

@Test
func testInverseSingularMat4x4NaN(): Unit {
    let m = Mat4x4<Float64, Defaultp>(Float64(1), Float64(1), Float64(1), Float64(1), Float64(1), Float64(1), Float64(1), Float64(1), Float64(1), Float64(1), Float64(1), Float64(1), Float64(1), Float64(1), Float64(1), Float64(1))
    let inv = inverse(m)
    @Expect(inv.c0.x != inv.c0.x, true)
    @Expect(inv.c0.y != inv.c0.y, true)
    @Expect(inv.c0.z != inv.c0.z, true)
    @Expect(inv.c0.w != inv.c0.w, true)
    @Expect(inv.c1.x != inv.c1.x, true)
    @Expect(inv.c1.y != inv.c1.y, true)
    @Expect(inv.c1.z != inv.c1.z, true)
    @Expect(inv.c1.w != inv.c1.w, true)
    @Expect(inv.c2.x != inv.c2.x, true)
    @Expect(inv.c2.y != inv.c2.y, true)
    @Expect(inv.c2.z != inv.c2.z, true)
    @Expect(inv.c2.w != inv.c2.w, true)
    @Expect(inv.c3.x != inv.c3.x, true)
    @Expect(inv.c3.y != inv.c3.y, true)
    @Expect(inv.c3.z != inv.c3.z, true)
    @Expect(inv.c3.w != inv.c3.w, true)
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
