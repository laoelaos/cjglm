package glm.gtc
import glm.detail.{Vec2, Vec3, Vec4, PackedHighp}
import std.unittest.*
import std.unittest.testmacro.*

@Test
func testPerlin1DRange(): Unit {
    let result = perlin1D(Float64(1.5))
    @Expect(result >= -1.1 && result <= 1.1, true)
}

@Test
func testPerlin2DRange(): Unit {
    let v = Vec2<Float64, PackedHighp>(1.5, 2.3)
    let result = perlin2D(v)
    @Expect(result >= -1.1 && result <= 1.1, true)
}

@Test
func testPerlin3DRange(): Unit {
    let v = Vec3<Float64, PackedHighp>(1.5, 2.3, 0.7)
    let result = perlin3D(v)
    @Expect(result >= -1.1 && result <= 1.1, true)
}

@Test
func testPerlin4DRange(): Unit {
    let v = Vec4<Float64, PackedHighp>(1.5, 2.3, 0.7, 3.1)
    let result = perlin4D(v)
    @Expect(result >= -1.1 && result <= 1.1, true)
}

@Test
func testSimplex1DRange(): Unit {
    let result = simplex1D(Float64(1.5))
    @Expect(result >= -1.1 && result <= 1.1, true)
}

@Test
func testSimplex2DRange(): Unit {
    let v = Vec2<Float64, PackedHighp>(1.5, 2.3)
    let result = simplex2D(v)
    @Expect(result >= -1.1 && result <= 1.1, true)
}

@Test
func testSimplex3DRange(): Unit {
    let v = Vec3<Float64, PackedHighp>(1.5, 2.3, 0.7)
    let result = simplex3D(v)
    @Expect(result >= -1.1 && result <= 1.1, true)
}

@Test
func testSimplex4DRange(): Unit {
    let v = Vec4<Float64, PackedHighp>(1.5, 2.3, 0.7, 3.1)
    let result = simplex4D(v)
    @Expect(result >= -1.1 && result <= 1.1, true)
}

@Test
func testPerlin1DPeriodic(): Unit {
    let p = Float64(3.0)
    let v1 = perlin1D(Float64(0.5), p)
    let v2 = perlin1D(Float64(3.5), p)
    @Expect(abs(v1 - v2) < 0.001, true)
}

@Test
func testPerlin2DPeriodic(): Unit {
    let period = Vec2<Float64, PackedHighp>(2.0, 2.0)
    let v1 = Vec2<Float64, PackedHighp>(0.5, 0.3)
    let v2 = Vec2<Float64, PackedHighp>(2.5, 2.3)
    let r1 = perlin2D(v1, period)
    let r2 = perlin2D(v2, period)
    @Expect(abs(r1 - r2) < 0.001, true)
}

@Test
func testPerlin3DPeriodic(): Unit {
    let period = Vec3<Float64, PackedHighp>(2.0, 2.0, 2.0)
    let v1 = Vec3<Float64, PackedHighp>(0.5, 0.3, 0.1)
    let v2 = Vec3<Float64, PackedHighp>(2.5, 2.3, 2.1)
    let r1 = perlin3D(v1, period)
    let r2 = perlin3D(v2, period)
    @Expect(abs(r1 - r2) < 0.001, true)
}

@Test
func testPerlin4DPeriodic(): Unit {
    let period = Vec4<Float64, PackedHighp>(2.0, 2.0, 2.0, 2.0)
    let v1 = Vec4<Float64, PackedHighp>(0.5, 0.3, 0.1, 0.7)
    let v2 = Vec4<Float64, PackedHighp>(2.5, 2.3, 2.1, 2.7)
    let r1 = perlin4D(v1, period)
    let r2 = perlin4D(v2, period)
    @Expect(abs(r1 - r2) < 0.001, true)
}

@Test
func testPerlin1DDeterministic(): Unit {
    let x = Float64(1.5)
    let r1 = perlin1D(x)
    let r2 = perlin1D(x)
    @Expect(r1, r2)
}

@Test
func testSimplex1DDeterministic(): Unit {
    let x = Float64(1.5)
    let r1 = simplex1D(x)
    let r2 = simplex1D(x)
    @Expect(r1, r2)
}

@Test
func testPerlin1DNegative(): Unit {
    let result = perlin1D(Float64(-2.5))
    @Expect(result >= -1.1 && result <= 1.1, true)
}

@Test
func testSimplex1DZero(): Unit {
    let result = simplex1D(Float64(0.0))
    @Expect(result >= -1.1 && result <= 1.1, true)
}

@Test
func testSimplex1DFloat32(): Unit {
    let result = simplex1D(Float32(1.5))
    @Expect(result >= -1.1f32 && result <= 1.1f32, true)
}

@Test
func testPerlin1DIsFinite(): Unit {
    let result = perlin1D(Float64(1.5))
    @Expect(result.isFinite(), true)
}

@Test
func testPerlin2DIsFinite(): Unit {
    let v = Vec2<Float64, PackedHighp>(1.5, 2.3)
    let result = perlin2D(v)
    @Expect(result.isFinite(), true)
}

@Test
func testPerlin3DIsFinite(): Unit {
    let v = Vec3<Float64, PackedHighp>(1.5, 2.3, 0.7)
    let result = perlin3D(v)
    @Expect(result.isFinite(), true)
}

@Test
func testPerlin4DIsFinite(): Unit {
    let v = Vec4<Float64, PackedHighp>(1.5, 2.3, 0.7, 3.1)
    let result = perlin4D(v)
    @Expect(result.isFinite(), true)
}

@Test
func testSimplex1DIsFinite(): Unit {
    let result = simplex1D(Float64(1.5))
    @Expect(result.isFinite(), true)
}

@Test
func testSimplex2DIsFinite(): Unit {
    let v = Vec2<Float64, PackedHighp>(1.5, 2.3)
    let result = simplex2D(v)
    @Expect(result.isFinite(), true)
}

@Test
func testSimplex3DIsFinite(): Unit {
    let v = Vec3<Float64, PackedHighp>(1.5, 2.3, 0.7)
    let result = simplex3D(v)
    @Expect(result.isFinite(), true)
}

@Test
func testSimplex4DIsFinite(): Unit {
    let v = Vec4<Float64, PackedHighp>(1.5, 2.3, 0.7, 3.1)
    let result = simplex4D(v)
    @Expect(result.isFinite(), true)
}

@Test
func testPerlin2DZeroVector(): Unit {
    let v = Vec2<Float64, PackedHighp>(0.0, 0.0)
    let result = perlin2D(v)
    @Expect(result.isFinite(), true)
}

@Test
func testPerlin3DZeroVector(): Unit {
    let v = Vec3<Float64, PackedHighp>(0.0, 0.0, 0.0)
    let result = perlin3D(v)
    @Expect(result.isFinite(), true)
}

@Test
func testPerlin4DZeroVector(): Unit {
    let v = Vec4<Float64, PackedHighp>(0.0, 0.0, 0.0, 0.0)
    let result = perlin4D(v)
    @Expect(result.isFinite(), true)
}

@Test
func testSimplex2DZeroVector(): Unit {
    let v = Vec2<Float64, PackedHighp>(0.0, 0.0)
    let result = simplex2D(v)
    @Expect(result.isFinite(), true)
}

@Test
func testSimplex3DZeroVector(): Unit {
    let v = Vec3<Float64, PackedHighp>(0.0, 0.0, 0.0)
    let result = simplex3D(v)
    @Expect(result.isFinite(), true)
}

@Test
func testSimplex4DZeroVector(): Unit {
    let v = Vec4<Float64, PackedHighp>(0.0, 0.0, 0.0, 0.0)
    let result = simplex4D(v)
    @Expect(result.isFinite(), true)
}

@Test
func testPerlin1DMinNormal(): Unit {
    let result = perlin1D(Float64(Float32.MinNormal))
    @Expect(result.isFinite(), true)
}

@Test
func testPerlin1DLargeInput(): Unit {
    let result = perlin1D(Float64(1e6))
    @Expect(result.isFinite(), true)
}

@Test
func testSimplex1DMinNormal(): Unit {
    let result = simplex1D(Float64(Float32.MinNormal))
    @Expect(result.isFinite(), true)
}

@Test
func testSimplex1DLargeInput(): Unit {
    let result = simplex1D(Float64(1e6))
    @Expect(result.isFinite(), true)
}
