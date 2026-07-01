package glm.gtc
import glm.detail.{Vec1, Vec2, Vec3, Vec4, PackedHighp}
import std.unittest.*
import std.unittest.testmacro.*
import std.math as m

@Test
func testLinearRandScalarInRange(): Unit {
    var sum = Float64(0.0)
    let count = Int64(1000)
    for (_ in 0..count) {
        let v = linearRand(Float64(0.0), Float64(10.0))
        sum += v
        @Expect(v >= 0.0 && v <= 10.0, true)
    }
    let mean = sum / Float64(count)
    @Expect(mean > 3.0 && mean < 7.0, true)
}

@Test
func testLinearRandVec1InRange(): Unit {
    let min = Vec1<Float64, PackedHighp>(0.0)
    let max = Vec1<Float64, PackedHighp>(10.0)
    for (_ in 0..10) {
        let v = linearRand(min, max)
        @Expect(v.x >= 0.0 && v.x <= 10.0, true)
    }
}

@Test
func testLinearRandVec2InRange(): Unit {
    let min = Vec2<Float64, PackedHighp>(0.0, 1.0)
    let max = Vec2<Float64, PackedHighp>(10.0, 11.0)
    let v = linearRand(min, max)
    @Expect(v.x >= 0.0 && v.x <= 10.0, true)
    @Expect(v.y >= 1.0 && v.y <= 11.0, true)
}

@Test
func testLinearRandVec3InRange(): Unit {
    let min = Vec3<Float64, PackedHighp>(0.0, 1.0, -1.0)
    let max = Vec3<Float64, PackedHighp>(10.0, 11.0, 9.0)
    let v = linearRand(min, max)
    @Expect(v.x >= 0.0 && v.x <= 10.0, true)
    @Expect(v.y >= 1.0 && v.y <= 11.0, true)
    @Expect(v.z >= -1.0 && v.z <= 9.0, true)
}

@Test
func testLinearRandVec4InRange(): Unit {
    let min = Vec4<Float64, PackedHighp>(0.0, 1.0, -1.0, 5.0)
    let max = Vec4<Float64, PackedHighp>(10.0, 11.0, 9.0, 15.0)
    let v = linearRand(min, max)
    @Expect(v.x >= 0.0 && v.x <= 10.0, true)
    @Expect(v.y >= 1.0 && v.y <= 11.0, true)
    @Expect(v.z >= -1.0 && v.z <= 9.0, true)
    @Expect(v.w >= 5.0 && v.w <= 15.0, true)
}

@Test
func testLinearRandScalarMinEqMax(): Unit {
    for (_ in 0..10) {
        let v = linearRand(Float64(5.0), Float64(5.0))
        @Expect(v, Float64(5.0))
    }
}

@Test
func testLinearRandScalarFloat32(): Unit {
    for (_ in 0..10) {
        let v = linearRand(Float32(0.0), Float32(10.0))
        @Expect(v >= 0.0f32 && v <= 10.0f32, true)
    }
}

@Test
func testGaussRandScalar(): Unit {
    var sum = Float64(0.0)
    var sumSq = Float64(0.0)
    let count = Int64(10000)
    let mean = Float64(5.0)
    let stddev = Float64(2.0)
    for (_ in 0..count) {
        let v = gaussRand(mean, stddev)
        sum += v
        sumSq += (v - mean) * (v - mean)
    }
    let sampleMean = sum / Float64(count)
    let sampleStd = mathSqrt(sumSq / Float64(count))
    @Expect(abs(sampleMean - mean) < 0.3, true)
    @Expect(abs(sampleStd - stddev) < 0.3, true)
}

private func mathSqrt(x: Float64): Float64 {
    m.sqrt(x)
}
