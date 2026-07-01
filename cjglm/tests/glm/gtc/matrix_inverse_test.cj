package glm.gtc
import glm.detail.{ Mat3x3, Mat4x4, Vec3, Vec4, Defaultp, inverse, transpose }
import std.unittest.*
import std.unittest.testmacro.*

@Test
func testAffineInverse(): Unit {
    let m = Mat4x4<Float64, Defaultp>(
        Vec4(1.0, 0.0, 0.0, 0.0),
        Vec4(0.0, 2.0, 0.0, 0.0),
        Vec4(0.0, 0.0, 3.0, 0.0),
        Vec4(1.0, 2.0, 3.0, 1.0)
    )
    let inv = affineInverse(m)
    let result = m * inv
    @Expect((result.c0.x - 1.0).abs() < 1e-10, true)
    @Expect((result.c1.y - 1.0).abs() < 1e-10, true)
    @Expect((result.c2.z - 1.0).abs() < 1e-10, true)
    @Expect((result.c3.w - 1.0).abs() < 1e-10, true)
}

@Test
func testAffineInverseRotation(): Unit {
    let c = 0.8660254037844386
    let s = 0.5
    let m = Mat4x4<Float64, Defaultp>(
        Vec4(c, -s, 0.0, 0.0),
        Vec4(s, c, 0.0, 0.0),
        Vec4(0.0, 0.0, 1.0, 0.0),
        Vec4(1.0, 2.0, 3.0, 1.0)
    )
    let inv = affineInverse(m)
    let result = m * inv
    @Expect((result.c0.x - 1.0).abs() < 1e-10, true)
    @Expect((result.c0.y).abs() < 1e-10, true)
    @Expect((result.c1.x).abs() < 1e-10, true)
    @Expect((result.c1.y - 1.0).abs() < 1e-10, true)
    @Expect((result.c2.z - 1.0).abs() < 1e-10, true)
    @Expect((result.c3.w - 1.0).abs() < 1e-10, true)
    @Expect((result.c3.x).abs() < 1e-10, true)
    @Expect((result.c3.y).abs() < 1e-10, true)
    @Expect((result.c3.z).abs() < 1e-10, true)
}

@Test
func testInverseTransposeMat3(): Unit {
    let m = Mat3x3<Float64, Defaultp>(
        Vec3(1.0, 0.0, 0.0),
        Vec3(0.0, 2.0, 0.0),
        Vec3(0.0, 0.0, 3.0)
    )
    let r = inverseTranspose(m)
    @Expect((r.c0.x - 1.0).abs() < 1e-10, true)
    @Expect((r.c1.y - 0.5).abs() < 1e-10, true)
    @Expect((r.c2.z - (1.0/3.0)).abs() < 1e-10, true)
}

@Test
func testInverseTransposeMat4(): Unit {
    let m = Mat4x4<Float64, Defaultp>(
        Vec4(1.0, 0.0, 0.0, 0.0),
        Vec4(0.0, 2.0, 0.0, 0.0),
        Vec4(0.0, 0.0, 3.0, 0.0),
        Vec4(0.0, 0.0, 0.0, 1.0)
    )
    let r = inverseTranspose(m)
    @Expect((r.c0.x - 1.0).abs() < 1e-10, true)
    @Expect((r.c1.y - 0.5).abs() < 1e-10, true)
    @Expect((r.c2.z - (1.0/3.0)).abs() < 1e-10, true)
    @Expect((r.c3.w - 1.0).abs() < 1e-10, true)
}

@Test
func testInverseTransposeConsistencyMat3(): Unit {
    let m = Mat3x3<Float64, Defaultp>(
        Vec3(1.0, 0.0, 0.0),
        Vec3(0.0, 2.0, 0.0),
        Vec3(0.0, 0.0, 3.0)
    )
    let r = inverseTranspose(m)
    let expected = transpose(inverse(m))
    @Expect((r.c0.x - expected.c0.x).abs() < 1e-10, true)
    @Expect((r.c0.y - expected.c0.y).abs() < 1e-10, true)
    @Expect((r.c0.z - expected.c0.z).abs() < 1e-10, true)
    @Expect((r.c1.x - expected.c1.x).abs() < 1e-10, true)
    @Expect((r.c1.y - expected.c1.y).abs() < 1e-10, true)
    @Expect((r.c1.z - expected.c1.z).abs() < 1e-10, true)
    @Expect((r.c2.x - expected.c2.x).abs() < 1e-10, true)
    @Expect((r.c2.y - expected.c2.y).abs() < 1e-10, true)
    @Expect((r.c2.z - expected.c2.z).abs() < 1e-10, true)
}

@Test
func testInverseTransposeConsistencyMat4(): Unit {
    let m = Mat4x4<Float64, Defaultp>(
        Vec4(1.0, 0.0, 0.0, 0.0),
        Vec4(0.0, 2.0, 0.0, 0.0),
        Vec4(0.0, 0.0, 3.0, 0.0),
        Vec4(0.0, 0.0, 0.0, 1.0)
    )
    let r = inverseTranspose(m)
    let expected = transpose(inverse(m))
    @Expect((r.c0.x - expected.c0.x).abs() < 1e-10, true)
    @Expect((r.c0.y - expected.c0.y).abs() < 1e-10, true)
    @Expect((r.c0.z - expected.c0.z).abs() < 1e-10, true)
    @Expect((r.c0.w - expected.c0.w).abs() < 1e-10, true)
    @Expect((r.c1.x - expected.c1.x).abs() < 1e-10, true)
    @Expect((r.c1.y - expected.c1.y).abs() < 1e-10, true)
    @Expect((r.c1.z - expected.c1.z).abs() < 1e-10, true)
    @Expect((r.c1.w - expected.c1.w).abs() < 1e-10, true)
    @Expect((r.c2.x - expected.c2.x).abs() < 1e-10, true)
    @Expect((r.c2.y - expected.c2.y).abs() < 1e-10, true)
    @Expect((r.c2.z - expected.c2.z).abs() < 1e-10, true)
    @Expect((r.c2.w - expected.c2.w).abs() < 1e-10, true)
    @Expect((r.c3.x - expected.c3.x).abs() < 1e-10, true)
    @Expect((r.c3.y - expected.c3.y).abs() < 1e-10, true)
    @Expect((r.c3.z - expected.c3.z).abs() < 1e-10, true)
    @Expect((r.c3.w - expected.c3.w).abs() < 1e-10, true)
}
