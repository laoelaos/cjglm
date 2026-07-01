package glm.gtc
import std.unittest.*
import std.unittest.testmacro.*

@Test
func testNextFloatUlpDelta(): Unit {
    let x = Float32(1.0)
    let nf = next_float(x)
    let delta = nf - x
    let expected = Float32.fromBits(UInt32(0x34000000))
    @Expect(delta, expected)
}

@Test
func testNextFloatUlpDeltaFloat64(): Unit {
    let x = Float64(1.0)
    let nf = next_float(x)
    let delta = nf - x
    let expected = Float64.fromBits(UInt64(0x3CA0000000000000))
    @Expect(delta, expected)
}

@Test
func testFloatDistanceAdjacent(): Unit {
    let x = Float32(1.0)
    let nf = next_float(x)
    @Expect(float_distance(x, nf), Int32(1))
    @Expect(float_distance(nf, x), Int32(1))
}

@Test
func testFloatDistanceAdjacentFloat64(): Unit {
    let x = Float64(1.0)
    let nf = next_float(x)
    @Expect(float_distance(x, nf), Int64(1))
    @Expect(float_distance(nf, x), Int64(1))
}

@Test
func testUlpNormal(): Unit {
    let x = Float32(1.0)
    let expected = Float32.fromBits(UInt32(0x34000000))
    @Expect(ulp(x), expected)
}

@Test
func testUlpNormalFloat64(): Unit {
    let x = Float64(1.0)
    let expected = Float64.fromBits(UInt64(0x3CA0000000000000))
    @Expect(ulp(x), expected)
}

@Test
func testUlpBoundary(): Unit {
    @Expect(ulp(Float32(0.0)), Float32.fromBits(UInt32(1)))
    @Expect(ulp(Float32.infinity()), Float32.infinity())
    @Expect(ulp(Float32.nan).isNaN(), true)
    @Expect(ulp(Float64(0.0)), Float64.fromBits(UInt64(1)))
    @Expect(ulp(Float64.infinity()), Float64.infinity())
    @Expect(ulp(Float64.nan).isNaN(), true)
}

@Test
func testPrevFloat(): Unit {
    let x = Float32(1.0)
    let pf = prev_float(x)
    @Expect(float_distance(pf, x), Int32(1))
}

@Test
func testNextFloatZero(): Unit {
    @Expect(float_distance(Float32(0.0), next_float(Float32(0.0))), Int32(1))
}

@Test
func testFloatDistanceNaN(): Unit {
    @Expect(float_distance(Float32.nan, Float32(1.0)), Int32.Max)
    @Expect(float_distance(Float32(1.0), Float32.nan), Int32.Max)
    @Expect(float_distance(Float32.nan, Float32.nan), Int32.Max)
}

@Test
func testFloatDistanceInf(): Unit {
    @Expect(float_distance(Float32.infinity(), Float32(1.0)), Int32.Max)
    @Expect(float_distance(Float32(1.0), Float32.infinity()), Int32.Max)
}

@Test
func testFloatDistanceNaN64(): Unit {
    @Expect(float_distance(Float64.nan, Float64(1.0)), Int64.Max)
    @Expect(float_distance(Float64(1.0), Float64.nan), Int64.Max)
}

@Test
func testFloatDistanceInf64(): Unit {
    @Expect(float_distance(Float64.infinity(), Float64(1.0)), Int64.Max)
    @Expect(float_distance(Float64(1.0), Float64.infinity()), Int64.Max)
}

@Test
func testFloatDistanceNegative(): Unit {
    let x = Float32(-1.0)
    let nf = next_float(x)
    @Expect(float_distance(x, nf), Int32(1))
    @Expect(float_distance(nf, x), Int32(1))
}

@Test
func testFloatDistanceNegative64(): Unit {
    let x = Float64(-1.0)
    let nf = next_float(x)
    @Expect(float_distance(x, nf), Int64(1))
    @Expect(float_distance(nf, x), Int64(1))
}

@Test
func testFloatDistanceSameValueFloat32(): Unit {
    @Expect(float_distance(Float32(1.0), Float32(1.0)), Int32(0))
    @Expect(float_distance(Float32(-1.0), Float32(-1.0)), Int32(0))
    @Expect(float_distance(Float32(0.0), Float32(0.0)), Int32(0))
}

@Test
func testFloatDistanceSameValueFloat64(): Unit {
    @Expect(float_distance(Float64(1.0), Float64(1.0)), Int64(0))
    @Expect(float_distance(Float64(-1.0), Float64(-1.0)), Int64(0))
    @Expect(float_distance(Float64(0.0), Float64(0.0)), Int64(0))
}

@Test
func testFloatDistanceLargeRangeFloat32(): Unit {
    let a = Float32(1.0)
    let b = Float32(-1.0)
    let dist = float_distance(a, b)
    @Expect(dist > Int32(0), true)
}

@Test
func testFloatDistanceLargeRangeFloat64(): Unit {
    let a = Float64(1.0)
    let b = Float64(-1.0)
    let dist = float_distance(a, b)
    @Expect(dist > Int64(0), true)
}

@Test
func testFloatDistancePosNegZeroFloat32(): Unit {
    let pos = float_distance(Float32(0.0), Float32(1.0))
    let neg = float_distance(Float32(-0.0), Float32(1.0))
    @Expect(pos > Int32(0), true)
    @Expect(neg > Int32(0), true)
}

@Test
func testFloatDistancePosNegZeroFloat64(): Unit {
    let pos = float_distance(Float64(0.0), Float64(1.0))
    let neg = float_distance(Float64(-0.0), Float64(1.0))
    @Expect(pos > Int64(0), true)
    @Expect(neg > Int64(0), true)
}

@Test
func testPrevFloatFloat64(): Unit {
    let x = Float64(1.0)
    let pf = prev_float(x)
    @Expect(float_distance(pf, x), Int64(1))
}

@Test
func testPrevFloatZero(): Unit {
    let pfPos = prev_float(Float32(0.0))
    @Expect(pfPos.isFinite(), true)
    let pfNeg = prev_float(Float32(-0.0))
    @Expect(pfNeg.isFinite(), true)
}

@Test
func testPrevFloatNaN(): Unit {
    @Expect(prev_float(Float32.nan).isNaN(), true)
}

@Test
func testPrevFloatInf(): Unit {
    let result = prev_float(Float32.infinity())
    @Expect(result.isFinite() || result.isInf(), true)
}
