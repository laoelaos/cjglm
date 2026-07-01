package glm.ext

import std.unittest.*
import std.unittest.testmacro.*
import glm.detail.{ Defaultp }

// ── Group 1: 3/4 input min/max ──

@Test
func testMin3Input(): Unit {
    let r = min(Float64(3.0), Float64(1.0), Float64(2.0))
    @Expect(r, Float64(1.0))
}

@Test
func testMin4Input(): Unit {
    let r = min(Float64(3.0), Float64(1.0), Float64(2.0), Float64(4.0))
    @Expect(r, Float64(1.0))
}

@Test
func testMax3Input(): Unit {
    let r = max(Float64(3.0), Float64(1.0), Float64(2.0))
    @Expect(r, Float64(3.0))
}

@Test
func testMax4Input(): Unit {
    let r = max(Float64(3.0), Float64(1.0), Float64(2.0), Float64(4.0))
    @Expect(r, Float64(4.0))
}

// ── Group 2: NaN-safe fmin ──

@Test
func testFmin2BothNormal(): Unit {
    let r = fmin(Float64(3.0), Float64(1.0))
    @Expect(r, Float64(1.0))
}

@Test
func testFmin2WithNaN(): Unit {
    let r = fmin(Float64(3.0), Float64.getNaN())
    @Expect(r, Float64(3.0))
}

@Test
func testFmin2NaNFirst(): Unit {
    let r = fmin(Float64.getNaN(), Float64(2.0))
    @Expect(r, Float64(2.0))
}

@Test
func testFmin3WithNaN(): Unit {
    let r = fmin(Float64.getNaN(), Float64(2.0), Float64(1.0))
    @Expect(r, Float64(1.0))
}

@Test
func testFmin3NaNMid(): Unit {
    let r = fmin(Float64(3.0), Float64.getNaN(), Float64(1.0))
    @Expect(r, Float64(1.0))
}

@Test
func testFmin3NaNLast(): Unit {
    let r = fmin(Float64(3.0), Float64(1.0), Float64.getNaN())
    @Expect(r, Float64(1.0))
}

@Test
func testFmin4WithNaN(): Unit {
    let r = fmin(Float64.getNaN(), Float64.getNaN(), Float64(3.0), Float64(1.0))
    @Expect(r, Float64(1.0))
}

@Test
func testFmin4NaNMixed(): Unit {
    let r = fmin(Float64(4.0), Float64.getNaN(), Float64(3.0), Float64(1.0))
    @Expect(r, Float64(1.0))
}

@Test
func testFmin4AllNaN(): Unit {
    let r = fmin(Float64.getNaN(), Float64.getNaN(), Float64.getNaN(), Float64.getNaN())
    @Expect(r.isNaN(), true)
}

@Test
func testFmin4FirstOnlyNormal(): Unit {
    let r = fmin(Float64(5.0), Float64.getNaN(), Float64.getNaN(), Float64.getNaN())
    @Expect(r, Float64(5.0))
}

// ── Group 3: NaN-safe fmax ──

@Test
func testFmax2BothNormal(): Unit {
    let r = fmax(Float64(3.0), Float64(1.0))
    @Expect(r, Float64(3.0))
}

@Test
func testFmax2WithNaN(): Unit {
    let r = fmax(Float64(3.0), Float64.getNaN())
    @Expect(r, Float64(3.0))
}

@Test
func testFmax2NaNFirst(): Unit {
    let r = fmax(Float64.getNaN(), Float64(2.0))
    @Expect(r, Float64(2.0))
}

@Test
func testFmax3WithNaN(): Unit {
    let r = fmax(Float64.getNaN(), Float64(2.0), Float64(1.0))
    @Expect(r, Float64(2.0))
}

@Test
func testFmax3NaNMid(): Unit {
    let r = fmax(Float64(1.0), Float64.getNaN(), Float64(3.0))
    @Expect(r, Float64(3.0))
}

@Test
func testFmax3NaNLast(): Unit {
    let r = fmax(Float64(1.0), Float64(2.0), Float64.getNaN())
    @Expect(r, Float64(2.0))
}

@Test
func testFmax4WithNaN(): Unit {
    let r = fmax(Float64.getNaN(), Float64.getNaN(), Float64(3.0), Float64(1.0))
    @Expect(r, Float64(3.0))
}

@Test
func testFmax4NaNMixed(): Unit {
    let r = fmax(Float64(1.0), Float64.getNaN(), Float64(3.0), Float64.getNaN())
    @Expect(r, Float64(3.0))
}

@Test
func testFmax4AllNaN(): Unit {
    let r = fmax(Float64.getNaN(), Float64.getNaN(), Float64.getNaN(), Float64.getNaN())
    @Expect(r.isNaN(), true)
}

@Test
func testFmax4FirstOnlyNormal(): Unit {
    let r = fmax(Float64(5.0), Float64.getNaN(), Float64.getNaN(), Float64.getNaN())
    @Expect(r, Float64(5.0))
}

// ── Group 4: fclamp ──

@Test
func testFclampInside(): Unit {
    let r = fclamp(Float64(0.5), Float64(0.0), Float64(1.0))
    @Expect(r, Float64(0.5))
}

@Test
func testFclampAbove(): Unit {
    let r = fclamp(Float64(5.0), Float64(0.0), Float64(1.0))
    @Expect(r, Float64(1.0))
}

@Test
func testFclampBelow(): Unit {
    let r = fclamp(Float64(-1.0), Float64(0.0), Float64(1.0))
    @Expect(r, Float64(0.0))
}

// ── Group 5: Texture wrapping modes ──

@Test
func testClampTexcoordAbove(): Unit {
    let r = clamp(Float64(1.5))
    @Expect(r, Float64(1.0))
}

@Test
func testClampTexcoordBelow(): Unit {
    let r = clamp(Float64(-0.5))
    @Expect(r, Float64(0.0))
}

@Test
func testClampTexcoordInside(): Unit {
    let r = clamp(Float64(0.3))
    @Expect(r, Float64(0.3))
}

@Test
func testRepeatPositive(): Unit {
    let r = repeat(Float64(3.7))
    @Expect(r, Float64(0.7))
}

@Test
func testRepeatNegative(): Unit {
    let r = repeat(Float64(-1.3))
    @Expect(r, Float64(0.7))
}

@Test
func testMirrorClampPositive(): Unit {
    let r = mirrorClamp(Float64(1.3))
    @Expect(r, Float64(0.3))
}

@Test
func testMirrorClampNegative(): Unit {
    let r = mirrorClamp(Float64(-1.3))
    @Expect(r, Float64(0.3))
}

@Test
func testMirrorRepeatPositiveInside(): Unit {
    let r = mirrorRepeat(Float64(0.7))
    @Expect(r, Float64(0.7))
}

@Test
func testMirrorRepeatPositiveMirror(): Unit {
    let r = mirrorRepeat(Float64(1.7))
    @Expect(r, Float64(0.3))
}

@Test
func testMirrorRepeatNegative(): Unit {
    let r = mirrorRepeat(Float64(-2.3))
    @Expect(r, Float64(0.3))
}

// ── Group 6: Float-to-integer rounding ──

@Test
func testIroundUp(): Unit {
    let r = iround(Float64(3.7))
    @Expect(r, Int64(4))
}

@Test
func testIroundDown(): Unit {
    let r = iround(Float64(3.2))
    @Expect(r, Int64(3))
}

@Test
func testIroundHalf(): Unit {
    let r = iround(Float64(3.5))
    @Expect(r, Int64(4))
}

@Test
func testIroundNegative(): Unit {
    let r = iround(Float64(-2.3))
    @Expect(r, Int64(-2))
}

@Test
func testUroundUp(): Unit {
    let r = uround(Float64(3.7))
    @Expect(r, UInt64(4))
}

@Test
func testUroundDown(): Unit {
    let r = uround(Float64(3.2))
    @Expect(r, UInt64(3))
}

@Test
func testUroundHalf(): Unit {
    let r = uround(Float64(3.5))
    @Expect(r, UInt64(4))
}

// ── Additional boundary & error coverage ──

@Test
func testMin3Tie(): Unit {
    let r = min(Float64(2.0), Float64(2.0), Float64(3.0))
    @Expect(r, Float64(2.0))
}

@Test
func testMax3Tie(): Unit {
    let r = max(Float64(3.0), Float64(3.0), Float64(1.0))
    @Expect(r, Float64(3.0))
}

@Test
func testMin4Tie(): Unit {
    let r = min(Float64(1.0), Float64(1.0), Float64(2.0), Float64(3.0))
    @Expect(r, Float64(1.0))
}

@Test
func testMax4Tie(): Unit {
    let r = max(Float64(4.0), Float64(4.0), Float64(2.0), Float64(1.0))
    @Expect(r, Float64(4.0))
}

@Test
func testIroundZero(): Unit {
    let r = iround(Float64(0.0))
    @Expect(r, Int64(0))
}

@Test
func testIroundNegZero(): Unit {
    let r = iround(Float64(-0.0))
    @Expect(r, Int64(0))
}

@Test
func testUroundZero(): Unit {
    let r = uround(Float64(0.0))
    @Expect(r, UInt64(0))
}

@Test
func testUroundNeg(): Unit {
    @ExpectThrows[ArithmeticException](uround(Float64(-1.0)))
}

@Test
func testFclampNaNMinVal(): Unit {
    let r = fclamp(Float64.getNaN(), Float64.getNaN(), Float64(1.0))
    @Expect(r.isNaN(), true)
}

@Test
func testFclampNaNMaxVal(): Unit {
    let r = fclamp(Float64(0.5), Float64(0.0), Float64.getNaN())
    @Expect(r.isNaN(), true)
}

@Test
func testRepeatZero(): Unit {
    let r = repeat(Float64(0.0))
    @Expect(r, Float64(0.0))
}

@Test
func testClampTexcoordAtZero(): Unit {
    let r = clamp(Float64(0.0))
    @Expect(r, Float64(0.0))
}

@Test
func testClampTexcoordAtOne(): Unit {
    let r = clamp(Float64(1.0))
    @Expect(r, Float64(1.0))
}

@Test
func testMirrorRepeatZero(): Unit {
    let r = mirrorRepeat(Float64(0.0))
    @Expect(r, Float64(0.0))
}

// ── Group 6 extended: Multi-type iround/uround via roundT ──

@Test
func testIroundFloat32Up(): Unit {
    let r = iround(Float32(3.7))
    @Expect(r, Int64(4))
}

@Test
func testIroundFloat32Down(): Unit {
    let r = iround(Float32(3.2))
    @Expect(r, Int64(3))
}

@Test
func testIroundFloat32Half(): Unit {
    let r = iround(Float32(3.5))
    @Expect(r, Int64(4))
}

@Test
func testIroundFloat32Negative(): Unit {
    let r = iround(Float32(-2.3))
    @Expect(r, Int64(-2))
}

@Test
func testIroundFloat32Zero(): Unit {
    let r = iround(Float32(0.0))
    @Expect(r, Int64(0))
}

@Test
func testIroundFloat16Up(): Unit {
    let r = iround(Float16(3.7))
    @Expect(r, Int64(4))
}

@Test
func testIroundFloat16Half(): Unit {
    let r = iround(Float16(2.5))
    @Expect(r, Int64(3))
}

@Test
func testIroundFloat16NegativeHalf(): Unit {
    let r = iround(Float16(-2.5))
    @Expect(r, Int64(-2))
}

@Test
func testUroundFloat32Up(): Unit {
    let r = uround(Float32(3.7))
    @Expect(r, UInt64(4))
}

@Test
func testUroundFloat32Down(): Unit {
    let r = uround(Float32(3.2))
    @Expect(r, UInt64(3))
}

@Test
func testUroundFloat32Half(): Unit {
    let r = uround(Float32(3.5))
    @Expect(r, UInt64(4))
}

@Test
func testUroundFloat32Zero(): Unit {
    let r = uround(Float32(0.0))
    @Expect(r, UInt64(0))
}

@Test
func testUroundFloat32NegThrows(): Unit {
    @ExpectThrows[ArithmeticException](uround(Float32(-1.0)))
}

@Test
func testUroundFloat16Up(): Unit {
    let r = uround(Float16(3.7))
    @Expect(r, UInt64(4))
}

@Test
func testUroundFloat16Half(): Unit {
    let r = uround(Float16(2.5))
    @Expect(r, UInt64(3))
}

@Test
func testUroundFloat16Zero(): Unit {
    let r = uround(Float16(0.0))
    @Expect(r, UInt64(0))
}
