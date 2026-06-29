package glm

import std.unittest.*
import std.unittest.testmacro.*

@Test
func testIntegrationAll9FloatMatAliasConstruct(): Unit {
    let m22 = Mat2x2(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))
    @Expect(m22.c0.x, Float32(1.0))
    @Expect(m22.c1.y, Float32(4.0))
    let m23 = Mat2x3(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0))
    @Expect(m23.c0.x, Float32(1.0))
    @Expect(m23.c1.z, Float32(6.0))
    let m24 = Mat2x4(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0), Float32(7.0), Float32(8.0))
    @Expect(m24.c0.w, Float32(4.0))
    @Expect(m24.c1.x, Float32(5.0))
    let m32 = Mat3x2(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0))
    @Expect(m32.c0.x, Float32(1.0))
    @Expect(m32.c2.y, Float32(6.0))
    let m33 = Mat3x3(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0), Float32(7.0), Float32(8.0), Float32(9.0))
    @Expect(m33.c0.x, Float32(1.0))
    @Expect(m33.c2.z, Float32(9.0))
    let m34 = Mat3x4(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0), Float32(7.0), Float32(8.0), Float32(9.0), Float32(10.0), Float32(11.0), Float32(12.0))
    @Expect(m34.c0.w, Float32(4.0))
    @Expect(m34.c2.x, Float32(9.0))
    let m42 = Mat4x2(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0), Float32(7.0), Float32(8.0))
    @Expect(m42.c0.x, Float32(1.0))
    @Expect(m42.c3.y, Float32(8.0))
    let m43 = Mat4x3(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0), Float32(7.0), Float32(8.0), Float32(9.0), Float32(10.0), Float32(11.0), Float32(12.0))
    @Expect(m43.c0.z, Float32(3.0))
    @Expect(m43.c3.x, Float32(10.0))
    let m44 = Mat4x4(Float32(1.0))
    @Expect(m44.c3.w, Float32(1.0))
}

@Test
func testIntegrationAll9DMatAliasConstruct(): Unit {
    let m22 = DMat2x2(Float64(1.0), Float64(2.0), Float64(3.0), Float64(4.0))
    @Expect(m22.c1.y, Float64(4.0))
    let m23 = DMat2x3(Float64(1.0), Float64(2.0), Float64(3.0), Float64(4.0), Float64(5.0), Float64(6.0))
    @Expect(m23.c1.z, Float64(6.0))
    let m24 = DMat2x4(Float64(1.0))
    @Expect(m24.c1.w, Float64(1.0))
    let m32 = DMat3x2(Float64(1.0))
    @Expect(m32.c2.y, Float64(1.0))
    let m33 = DMat3x3(Float64(1.0))
    @Expect(m33.c2.z, Float64(1.0))
    let m34 = DMat3x4(Float64(1.0))
    @Expect(m34.c2.w, Float64(1.0))
    let m42 = DMat4x2(Float64(1.0))
    @Expect(m42.c3.y, Float64(1.0))
    let m43 = DMat4x3(Float64(1.0))
    @Expect(m43.c3.z, Float64(1.0))
    let m44 = DMat4x4(Float64(1.0))
    @Expect(m44.c3.w, Float64(1.0))
}

@Test
func testIntegrationShortAliasMat2(): Unit {
    let m2: mat2 = mat2(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))
    @Expect(m2.c0.x, Float32(1.0))
    @Expect(m2.c1.y, Float32(4.0))
    let m3: mat3 = mat3(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0), Float32(7.0), Float32(8.0), Float32(9.0))
    @Expect(m3.c2.z, Float32(9.0))
    let m4: mat4 = mat4(Float32(1.0))
    @Expect(m4.c3.w, Float32(1.0))
}

@Test
func testIntegrationShortAliasDMat(): Unit {
    let m2: dmat2 = dmat2(Float64(1.0), Float64(2.0), Float64(3.0), Float64(4.0))
    @Expect(m2.c0.x, Float64(1.0))
    @Expect(m2.c1.y, Float64(4.0))
    let m3: dmat3 = dmat3(Float64(1.0))
    @Expect(m3.c2.z, Float64(1.0))
    let m4: dmat4 = dmat4(Float64(1.0))
    @Expect(m4.c3.w, Float64(1.0))
}

@Test
func testIntegrationFwdAliasGenericCompatible(): Unit {
    let alias: Mat2x2 = Mat2x2(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))
    let generic: detail.Mat2x2<Float32, PackedHighp> = alias
    @Expect(generic.c0.x, Float32(1.0))
    @Expect(generic.c1.y, Float32(4.0))
}

@Test
func testIntegrationMatAliasIdentity(): Unit {
    let id2 = Mat2x2.identity(Float32(1.0))
    @Expect(id2.c0.x, Float32(1.0))
    @Expect(id2.c0.y, Float32(0.0))
    @Expect(id2.c1.x, Float32(0.0))
    @Expect(id2.c1.y, Float32(1.0))
    let id3 = Mat3x3.identity(Float32(1.0))
    @Expect(id3.c0.x, Float32(1.0))
    @Expect(id3.c2.z, Float32(1.0))
    let id4 = Mat4x4.identity(Float32(1.0))
    @Expect(id4.c0.x, Float32(1.0))
    @Expect(id4.c3.w, Float32(1.0))
}

@Test
func testIntegrationMat2x2AddSub(): Unit {
    let a = Mat2x2(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))
    let b = Mat2x2(Float32(5.0), Float32(6.0), Float32(7.0), Float32(8.0))
    let r = a + b
    @Expect(r.c0.x, Float32(6.0))
    @Expect(r.c0.y, Float32(8.0))
    @Expect(r.c1.x, Float32(10.0))
    @Expect(r.c1.y, Float32(12.0))
    let s = a - b
    @Expect(s.c0.x, Float32(-4.0))
    @Expect(s.c1.y, Float32(-4.0))
}

@Test
func testIntegrationMat3x3AddSub(): Unit {
    let a = Mat3x3(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0), Float32(7.0), Float32(8.0), Float32(9.0))
    let b = Mat3x3(Float32(9.0), Float32(8.0), Float32(7.0), Float32(6.0), Float32(5.0), Float32(4.0), Float32(3.0), Float32(2.0), Float32(1.0))
    let r = a + b
    @Expect(r.c0.x, Float32(10.0))
    @Expect(r.c1.y, Float32(10.0))
    @Expect(r.c2.z, Float32(10.0))
    let s = a - b
    @Expect(s.c0.x, Float32(-8.0))
    @Expect(s.c2.z, Float32(8.0))
}

@Test
func testIntegrationMat4x4AddSub(): Unit {
    let a = Mat4x4(Float32(1.0))
    let b = Mat4x4(Float32(2.0))
    let r = a + b
    @Expect(r.c0.x, Float32(3.0))
    @Expect(r.c3.w, Float32(3.0))
    let s = a - b
    @Expect(s.c0.x, Float32(-1.0))
    @Expect(s.c3.w, Float32(-1.0))
}

@Test
func testIntegrationNonSquareAddSub(): Unit {
    let a = Mat2x3(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0))
    let b = Mat2x3(Float32(6.0), Float32(5.0), Float32(4.0), Float32(3.0), Float32(2.0), Float32(1.0))
    let r = a + b
    @Expect(r.c0.x, Float32(7.0))
    @Expect(r.c1.z, Float32(7.0))
    let c = Mat3x2(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0))
    let d = Mat3x2(Float32(6.0), Float32(5.0), Float32(4.0), Float32(3.0), Float32(2.0), Float32(1.0))
    let s = c + d
    @Expect(s.c0.x, Float32(7.0))
    @Expect(s.c2.y, Float32(7.0))
}

@Test
func testIntegrationMatScalarMulDiv(): Unit {
    let m2 = Mat2x2(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))
    let r2 = m2 * Float32(3.0)
    @Expect(r2.c0.x, Float32(3.0))
    @Expect(r2.c1.y, Float32(12.0))
    let d2 = m2 / Float32(2.0)
    @Expect(d2.c0.x, Float32(0.5))
    @Expect(d2.c1.y, Float32(2.0))
    let m3 = Mat3x3(Float32(2.0))
    let r3 = m3 * Float32(5.0)
    @Expect(r3.c2.z, Float32(10.0))
    let m4 = Mat4x4(Float32(3.0))
    let r4 = m4 * Float32(2.0)
    @Expect(r4.c3.w, Float32(6.0))
}

@Test
func testIntegrationScalarLeftMul(): Unit {
    let m = Mat2x2(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))
    let r = mul(Float32(10.0), m)
    @Expect(r.c0.x, Float32(10.0))
    @Expect(r.c0.y, Float32(20.0))
    @Expect(r.c1.x, Float32(30.0))
    @Expect(r.c1.y, Float32(40.0))
}

@Test
func testIntegrationMatVecMul(): Unit {
    let m22 = Mat2x2(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))
    let v2 = Vec2(Float32(5.0), Float32(6.0))
    let r2 = m22 * v2
    @Expect(r2.x, Float32(23.0))
    @Expect(r2.y, Float32(34.0))
    let m33 = Mat3x3(Float32(1.0))
    let v3 = Vec3(Float32(2.0), Float32(3.0), Float32(4.0))
    let r3 = m33 * v3
    @Expect(r3.x, Float32(9.0))
    @Expect(r3.z, Float32(9.0))
    let m44 = Mat4x4(Float32(1.0))
    let v4 = Vec4(Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0))
    let r4 = m44 * v4
    @Expect(r4.x, Float32(14.0))
    @Expect(r4.w, Float32(14.0))
}

@Test
func testIntegrationCrossSizeMatMul(): Unit {
    let a = Mat2x2(Float32(1.0), Float32(0.0), Float32(0.0), Float32(1.0))
    let b = Mat3x2(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0))
    let r1 = a * b
    @Expect(r1.c0.x, Float32(1.0))
    @Expect(r1.c2.y, Float32(6.0))
    let c = Mat3x3(Float32(1.0))
    let d = Mat2x3(Float32(2.0), Float32(0.0), Float32(0.0), Float32(0.0), Float32(2.0), Float32(0.0))
    let r2 = c * d
    @Expect(r2.c0.x, Float32(2.0))
    @Expect(r2.c1.y, Float32(2.0))
    let e = Mat4x4(Float32(1.0))
    let f = Mat2x4(Float32(3.0), Float32(0.0), Float32(0.0), Float32(0.0), Float32(0.0), Float32(3.0), Float32(0.0), Float32(0.0))
    let r3 = e * f
    @Expect(r3.c0.x, Float32(3.0))
    @Expect(r3.c1.y, Float32(3.0))
}

@Test
func testIntegrationNonSquareMatVecMul(): Unit {
    let m23 = Mat2x3(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0))
    let v2 = Vec2(Float32(7.0), Float32(8.0))
    let r1 = m23 * v2
    @Expect(r1.x, Float32(39.0))
    @Expect(r1.z, Float32(69.0))
    let m42 = Mat4x2(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0), Float32(7.0), Float32(8.0))
    let v4 = Vec4(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))
    let r2 = m42 * v4
    @Expect(r2.x, Float32(30.0))
    @Expect(r2.y, Float32(60.0))
}

@Test
func testIntegrationMatMulChain(): Unit {
    let a = Mat2x2(Float32(1.0), Float32(0.0), Float32(0.0), Float32(1.0))
    let b = Mat3x2(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0))
    let step1 = a * b
    let c = Mat2x3(Float32(1.0), Float32(0.0), Float32(0.0), Float32(0.0), Float32(1.0), Float32(0.0))
    let result = step1 * c
    @Expect(result.c0.x, Float32(1.0))
    @Expect(result.c1.y, Float32(4.0))
}

@Test
func testIntegrationMatFromMatExpandChain(): Unit {
    let m24 = Mat2x4(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0), Float32(7.0), Float32(8.0))
    let m23 = Mat2x3.fromMat(m24, Float32(1.0))
    let m22 = Mat2x2.fromMat(m23, Float32(1.0))
    @Expect(m22.c0.x, Float32(1.0))
    @Expect(m22.c0.y, Float32(2.0))
    @Expect(m22.c1.x, Float32(5.0))
    @Expect(m22.c1.y, Float32(6.0))
}

@Test
func testIntegrationMatFromMatShrinkChain(): Unit {
    let m44 = Mat4x4(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0), Float32(7.0), Float32(8.0), Float32(9.0), Float32(10.0), Float32(11.0), Float32(12.0), Float32(13.0), Float32(14.0), Float32(15.0), Float32(16.0))
    let m33 = Mat3x3.fromMat(m44, Float32(1.0))
    let m22 = Mat2x2.fromMat(m33, Float32(1.0))
    @Expect(m22.c0.x, Float32(1.0))
    @Expect(m22.c0.y, Float32(2.0))
    @Expect(m22.c1.x, Float32(5.0))
    @Expect(m22.c1.y, Float32(6.0))
}

@Test
func testIntegrationFromMatBClass(): Unit {
    let src = Mat2x2(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))
    let m23 = Mat2x3.fromMat(src, Float32(1.0))
    @Expect(m23.c0.x, Float32(1.0))
    @Expect(m23.c1.z, Float32(0.0))
    let m24 = Mat2x4.fromMat(m23, Float32(1.0))
    @Expect(m24.c0.x, Float32(1.0))
    @Expect(m24.c0.w, Float32(0.0))
    @Expect(m24.c1.x, Float32(3.0))
    @Expect(m24.c1.z, Float32(0.0))
}

@Test
func testIntegrationFromMatColExtRowExt(): Unit {
    let src = Mat2x2(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))
    let m33 = Mat3x3.fromMat(src, Float32(1.0))
    @Expect(m33.c0.x, Float32(1.0))
    @Expect(m33.c0.y, Float32(2.0))
    @Expect(m33.c0.z, Float32(0.0))
    @Expect(m33.c1.x, Float32(3.0))
    @Expect(m33.c1.y, Float32(4.0))
    @Expect(m33.c1.z, Float32(0.0))
    @Expect(m33.c2.x, Float32(0.0))
    @Expect(m33.c2.z, Float32(1.0))
}

@Test
func testIntegrationFromMatColShrink(): Unit {
    let m44 = Mat4x4(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0), Float32(7.0), Float32(8.0), Float32(9.0), Float32(10.0), Float32(11.0), Float32(12.0), Float32(13.0), Float32(14.0), Float32(15.0), Float32(16.0))
    let m33 = Mat3x3.fromMat(m44, Float32(1.0))
    @Expect(m33.c0.x, Float32(1.0))
    @Expect(m33.c2.z, Float32(11.0))
    let m22 = Mat2x2.fromMat(m33, Float32(1.0))
    @Expect(m22.c0.x, Float32(1.0))
    @Expect(m22.c1.y, Float32(6.0))
}

@Test
func testIntegrationFromMatColExtRowShrink(): Unit {
    let src = Mat2x4(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0), Float32(7.0), Float32(8.0))
    let m32 = Mat3x2.fromMat(src, Float32(1.0))
    @Expect(m32.c0.x, Float32(1.0))
    @Expect(m32.c0.y, Float32(2.0))
    @Expect(m32.c1.x, Float32(5.0))
    @Expect(m32.c1.y, Float32(6.0))
    @Expect(m32.c2.x, Float32(0.0))
    @Expect(m32.c2.y, Float32(0.0))
}

@Test
func testIntegrationFromMatColShrinkRowExt(): Unit {
    let src = Mat3x2(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0))
    let m23 = Mat2x3.fromMat(src, Float32(1.0))
    @Expect(m23.c0.x, Float32(1.0))
    @Expect(m23.c0.y, Float32(2.0))
    @Expect(m23.c0.z, Float32(0.0))
    @Expect(m23.c1.x, Float32(3.0))
    @Expect(m23.c1.y, Float32(4.0))
    @Expect(m23.c1.z, Float32(0.0))
}

@Test
func testIntegrationFromMatDeviation(): Unit {
    let src = Mat4x2(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0), Float32(7.0), Float32(8.0))
    let m44 = Mat4x4.fromMat(src, Float32(1.0))
    @Expect(m44.c0.x, Float32(1.0))
    @Expect(m44.c0.y, Float32(2.0))
    @Expect(m44.c1.x, Float32(3.0))
    @Expect(m44.c1.y, Float32(4.0))
    @Expect(m44.c2.x, Float32(0.0))
    @Expect(m44.c2.y, Float32(0.0))
    @Expect(m44.c3.x, Float32(0.0))
    @Expect(m44.c3.y, Float32(0.0))
    @Expect(m44.c0.z, Float32(0.0))
    @Expect(m44.c2.z, Float32(1.0))
    @Expect(m44.c2.w, Float32(0.0))
    @Expect(m44.c3.z, Float32(0.0))
    @Expect(m44.c3.w, Float32(1.0))
}

@Test
func testIntegrationTransposeAll(): Unit {
    let m22 = Mat2x2(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))
    let t22 = transpose(m22)
    @Expect(t22.c0.x, Float32(1.0))
    @Expect(t22.c0.y, Float32(3.0))
    @Expect(t22.c1.x, Float32(2.0))
    @Expect(t22.c1.y, Float32(4.0))
    let m33 = Mat3x3(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0), Float32(7.0), Float32(8.0), Float32(9.0))
    let t33 = transpose(m33)
    @Expect(t33.c0.x, Float32(1.0))
    @Expect(t33.c0.y, Float32(4.0))
    @Expect(t33.c0.z, Float32(7.0))
    @Expect(t33.c2.x, Float32(3.0))
    @Expect(t33.c2.z, Float32(9.0))
    let m44 = Mat4x4(Float32(1.0))
    let t44 = transpose(m44)
    @Expect(t44.c3.w, Float32(1.0))
}

@Test
func testIntegrationTransposeNonSquare(): Unit {
    let m23 = Mat2x3(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0))
    let t23 = transpose(m23)
    @Expect(t23.c0.x, Float32(1.0))
    @Expect(t23.c0.y, Float32(4.0))
    @Expect(t23.c2.x, Float32(3.0))
    @Expect(t23.c2.y, Float32(6.0))
    let m32 = Mat3x2(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0))
    let t32 = transpose(m32)
    @Expect(t32.c0.x, Float32(1.0))
    @Expect(t32.c1.x, Float32(3.0))
    @Expect(t32.c1.y, Float32(4.0))
    let m42 = Mat4x2(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0), Float32(7.0), Float32(8.0))
    let t42 = transpose(m42)
    @Expect(t42.c0.x, Float32(1.0))
    @Expect(t42.c1.y, Float32(4.0))
}

@Test
func testIntegrationMatrixCompMult(): Unit {
    let a22 = Mat2x2(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))
    let b22 = Mat2x2(Float32(5.0), Float32(6.0), Float32(7.0), Float32(8.0))
    let r22 = matrixCompMult(a22, b22)
    @Expect(r22.c0.x, Float32(5.0))
    @Expect(r22.c1.y, Float32(32.0))
    let a33 = Mat3x3(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0), Float32(7.0), Float32(8.0), Float32(9.0))
    let b33 = Mat3x3(Float32(1.0))
    let r33 = matrixCompMult(a33, b33)
    @Expect(r33.c0.x, Float32(1.0))
    @Expect(r33.c2.z, Float32(9.0))
    let a44 = Mat4x4(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0), Float32(7.0), Float32(8.0), Float32(9.0), Float32(10.0), Float32(11.0), Float32(12.0), Float32(13.0), Float32(14.0), Float32(15.0), Float32(16.0))
    let b44 = Mat4x4(Float32(1.0))
    let r44 = matrixCompMult(a44, b44)
    @Expect(r44.c0.x, Float32(1.0))
    @Expect(r44.c3.w, Float32(16.0))
}

@Test
func testIntegrationOuterProduct(): Unit {
    let c2 = Vec2(Float32(1.0), Float32(2.0))
    let r2 = Vec2(Float32(3.0), Float32(4.0))
    let m22 = outerProduct(c2, r2)
    @Expect(m22.c0.x, Float32(3.0))
    @Expect(m22.c0.y, Float32(6.0))
    @Expect(m22.c1.x, Float32(4.0))
    @Expect(m22.c1.y, Float32(8.0))
    let c3 = Vec3(Float32(1.0), Float32(2.0), Float32(3.0))
    let r3 = Vec3(Float32(4.0), Float32(5.0), Float32(6.0))
    let m33 = outerProduct(c3, r3)
    @Expect(m33.c0.x, Float32(4.0))
    @Expect(m33.c2.z, Float32(18.0))
    let c4 = Vec4(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))
    let r4 = Vec4(Float32(5.0), Float32(6.0), Float32(7.0), Float32(8.0))
    let m44 = outerProduct(c4, r4)
    @Expect(m44.c0.x, Float32(5.0))
    @Expect(m44.c3.w, Float32(32.0))
}

@Test
func testIntegrationRowVecMatMulVec2(): Unit {
    let v2 = Vec2(Float32(1.0), Float32(2.0))
    let m22 = Mat2x2(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))
    let r22 = v2 * m22
    @Expect(r22.x, Float32(7.0))
    @Expect(r22.y, Float32(10.0))
    let m32 = Mat3x2(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0))
    let r32 = v2 * m32
    @Expect(r32.x, Float32(5.0))
    @Expect(r32.z, Float32(9.0))
    let m42 = Mat4x2(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0), Float32(7.0), Float32(8.0))
    let r42 = v2 * m42
    @Expect(r42.x, Float32(5.0))
    @Expect(r42.w, Float32(11.0))
}

@Test
func testIntegrationRowVecMatMulVec3(): Unit {
    let v3 = Vec3(Float32(1.0), Float32(2.0), Float32(3.0))
    let m23 = Mat2x3(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0))
    let r23 = v3 * m23
    @Expect(r23.x, Float32(14.0))
    @Expect(r23.y, Float32(32.0))
    let m33 = Mat3x3(Float32(1.0))
    let r33 = v3 * m33
    @Expect(r33.x, Float32(6.0))
    @Expect(r33.z, Float32(6.0))
    let m43 = Mat4x3(Float32(1.0))
    let r43 = v3 * m43
    @Expect(r43.x, Float32(6.0))
    @Expect(r43.w, Float32(6.0))
}

@Test
func testIntegrationRowVecMatMulVec4(): Unit {
    let v4 = Vec4(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))
    let m24 = Mat2x4(Float32(1.0))
    let r24 = v4 * m24
    @Expect(r24.x, Float32(10.0))
    @Expect(r24.y, Float32(10.0))
    let m34 = Mat3x4(Float32(1.0))
    let r34 = v4 * m34
    @Expect(r34.x, Float32(10.0))
    @Expect(r34.z, Float32(10.0))
    let m44 = Mat4x4(Float32(1.0))
    let r44 = v4 * m44
    @Expect(r44.x, Float32(10.0))
    @Expect(r44.w, Float32(10.0))
}

@Test
func testIntegrationScalarAddSubMat(): Unit {
    let m = Mat2x2(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))
    let r = add(Float32(10.0), m)
    @Expect(r.c0.x, Float32(11.0))
    @Expect(r.c1.y, Float32(14.0))
    let s = sub(Float32(10.0), m)
    @Expect(s.c0.x, Float32(9.0))
    @Expect(s.c1.y, Float32(6.0))
}

@Test
func testIntegrationScalarMulDivMat(): Unit {
    let m = Mat2x2(Float32(2.0), Float32(4.0), Float32(6.0), Float32(8.0))
    let r = mul(Float32(3.0), m)
    @Expect(r.c0.x, Float32(6.0))
    @Expect(r.c1.y, Float32(24.0))
    let d = div(Float32(12.0), m)
    @Expect(d.c0.x, Float32(6.0))
    @Expect(d.c0.y, Float32(3.0))
    @Expect(d.c1.x, Float32(2.0))
    @Expect(d.c1.y, Float32(1.5))
}

@Test
func testIntegrationScalarOpsAllTypes(): Unit {
    let square = Mat4x4(Float32(2.0))
    let rs = add(Float32(3.0), square)
    @Expect(rs.c3.w, Float32(5.0))
    let nonSquare = Mat2x3(Float32(2.0))
    let rn = add(Float32(3.0), nonSquare)
    @Expect(rn.c1.z, Float32(5.0))
}

@Test
func testIntegrationScalarOpsConsistency(): Unit {
    let m = Mat2x2(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))
    let r1 = add(Float32(10.0), m)
    let r2 = m + Float32(10.0)
    @Expect(r1.c0.x, r2.c0.x)
    @Expect(r1.c1.y, r2.c1.y)
}

@Test
func testIntegrationScalarOpsEdgeCases(): Unit {
    let m = Mat2x2(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))
    let r0 = add(Float32(0.0), m)
    @Expect(r0.c0.x, Float32(1.0))
    @Expect(r0.c1.y, Float32(4.0))
    let rneg = add(Float32(-5.0), m)
    @Expect(rneg.c0.x, Float32(-4.0))
    @Expect(rneg.c1.y, Float32(-1.0))
}

@Test
func testIntegrationDMatConstructArithmetic(): Unit {
    let m22 = DMat2x2(Float64(1.0), Float64(2.0), Float64(3.0), Float64(4.0))
    @Expect(m22.c0.x, Float64(1.0))
    @Expect(m22.c1.y, Float64(4.0))
    let m44 = DMat4x4(Float64(2.0))
    let r = m44 + DMat4x4(Float64(3.0))
    @Expect(r.c3.w, Float64(5.0))
}

@Test
func testIntegrationDMatFromMat(): Unit {
    let src = DMat2x2(Float64(1.0), Float64(2.0), Float64(3.0), Float64(4.0))
    let m33 = DMat3x3.fromMat(src, Float64(1.0))
    @Expect(m33.c0.x, Float64(1.0))
    @Expect(m33.c2.z, Float64(1.0))
}

@Test
func testIntegrationDMatTranspose(): Unit {
    let m = DMat2x2(Float64(1.0), Float64(2.0), Float64(3.0), Float64(4.0))
    let t = transpose(m)
    @Expect(t.c0.x, Float64(1.0))
    @Expect(t.c0.y, Float64(3.0))
}

@Test
func testIntegrationDMatFwdAlias(): Unit {
    let m2: dmat2 = dmat2(Float64(1.0), Float64(2.0), Float64(3.0), Float64(4.0))
    @Expect(m2.c0.x, Float64(1.0))
    let m4: dmat4 = dmat4(Float64(1.0))
    @Expect(m4.c3.w, Float64(1.0))
}

@Test
func testIntegrationFromMatRowShrink(): Unit {
    let m44 = Mat4x4(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0), Float32(7.0), Float32(8.0), Float32(9.0), Float32(10.0), Float32(11.0), Float32(12.0), Float32(13.0), Float32(14.0), Float32(15.0), Float32(16.0))
    let m = Mat4x3.fromMat(m44, Float32(1.0))
    @Expect(m.c0.x, Float32(1.0))
    @Expect(m.c0.y, Float32(2.0))
    @Expect(m.c0.z, Float32(3.0))
    @Expect(m.c1.x, Float32(5.0))
    @Expect(m.c1.y, Float32(6.0))
    @Expect(m.c1.z, Float32(7.0))
    @Expect(m.c2.x, Float32(9.0))
    @Expect(m.c2.y, Float32(10.0))
    @Expect(m.c2.z, Float32(11.0))
    @Expect(m.c3.x, Float32(13.0))
    @Expect(m.c3.y, Float32(14.0))
    @Expect(m.c3.z, Float32(15.0))
}
