package glm.detail

import std.math.{ isNaN, isInf }

// ── Group A: Number<T> & Comparable<T> (scalar) ──

@Test
func testAbsPositive(): Unit {
    @Expect(abs(Float64(5.0)), Float64(5.0))
}

@Test
func testAbsNegative(): Unit {
    @Expect(abs(Float64(-5.0)), Float64(5.0))
}

@Test
func testAbsZero(): Unit {
    @Expect(abs(Float64(0.0)), Float64(0.0))
}

@Test
func testAbsInt(): Unit {
    @Expect(abs(Int64(-3)), Int64(3))
}

@Test
func testSignPositive(): Unit {
    @Expect(sign(Float64(3.0)), Float64(1.0))
}

@Test
func testSignNegative(): Unit {
    @Expect(sign(Float64(-3.0)), Float64(-1.0))
}

@Test
func testSignZero(): Unit {
    @Expect(sign(Float64(0.0)), Float64(0.0))
}

@Test
func testMinFirstSmaller(): Unit {
    @Expect(min(Float64(2.0), Float64(5.0)), Float64(2.0))
}

@Test
func testMinSecondSmaller(): Unit {
    @Expect(min(Float64(7.0), Float64(3.0)), Float64(3.0))
}

@Test
func testMinEqual(): Unit {
    @Expect(min(Float64(4.0), Float64(4.0)), Float64(4.0))
}

@Test
func testMaxFirstLarger(): Unit {
    @Expect(max(Float64(7.0), Float64(3.0)), Float64(7.0))
}

@Test
func testMaxSecondLarger(): Unit {
    @Expect(max(Float64(2.0), Float64(8.0)), Float64(8.0))
}

@Test
func testMaxEqual(): Unit {
    @Expect(max(Float64(5.0), Float64(5.0)), Float64(5.0))
}

@Test
func testClampMid(): Unit {
    @Expect(clamp(Float64(0.5), Float64(0.0), Float64(1.0)), Float64(0.5))
}

@Test
func testClampBelow(): Unit {
    @Expect(clamp(Float64(-1.0), Float64(0.0), Float64(1.0)), Float64(0.0))
}

@Test
func testClampAbove(): Unit {
    @Expect(clamp(Float64(2.0), Float64(0.0), Float64(1.0)), Float64(1.0))
}

@Test
func testStepBelowEdge(): Unit {
    @Expect(step(Float64(0.5), Float64(0.0)), Float64(0.0))
}

@Test
func testStepAtEdge(): Unit {
    @Expect(step(Float64(0.5), Float64(0.5)), Float64(1.0))
}

@Test
func testStepAboveEdge(): Unit {
    @Expect(step(Float64(0.5), Float64(1.0)), Float64(1.0))
}

@Test
func testSmoothstepMid(): Unit {
    let r = smoothstep(Float64(0.0), Float64(1.0), Float64(0.5))
    @Expect(r, Float64(0.5))
}

@Test
func testSmoothstepBelow(): Unit {
    @Expect(smoothstep(Float64(0.0), Float64(1.0), Float64(-0.5)), Float64(0.0))
}

@Test
func testSmoothstepAbove(): Unit {
    @Expect(smoothstep(Float64(0.0), Float64(1.0), Float64(1.5)), Float64(1.0))
}

// ── Group A Vec ──

@Test
func testAbsVec2(): Unit {
    let v = Vec2<Float64, Defaultp>(-3.0, 4.0)
    let r = abs(v)
    @Expect(r.x, Float64(3.0))
    @Expect(r.y, Float64(4.0))
}

@Test
func testMinVec4(): Unit {
    let a = Vec4<Float64, Defaultp>(1.0, 5.0, 3.0, 8.0)
    let b = Vec4<Float64, Defaultp>(4.0, 2.0, 3.0, 6.0)
    let r = min(a, b)
    @Expect(r.x, Float64(1.0))
    @Expect(r.y, Float64(2.0))
    @Expect(r.z, Float64(3.0))
    @Expect(r.w, Float64(6.0))
}

@Test
func testMaxVec2(): Unit {
    let a = Vec2<Float64, Defaultp>(1.0, 5.0)
    let b = Vec2<Float64, Defaultp>(4.0, 2.0)
    let r = max(a, b)
    @Expect(r.x, Float64(4.0))
    @Expect(r.y, Float64(5.0))
}

@Test
func testClampVec3(): Unit {
    let a = Vec3<Float64, Defaultp>(-1.0, 0.5, 2.0)
    let lo = Vec3<Float64, Defaultp>(0.0, 0.0, 0.0)
    let hi = Vec3<Float64, Defaultp>(1.0, 1.0, 1.0)
    let r = clamp(a, lo, hi)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(0.5))
    @Expect(r.z, Float64(1.0))
}

@Test
func testSignVec4(): Unit {
    let v = Vec4<Float64, Defaultp>(3.0, 0.0, -5.0, -0.0)
    let r = sign(v)
    @Expect(r.x, Float64(1.0))
    @Expect(r.y, Float64(0.0))
    @Expect(r.z, Float64(-1.0))
    @Expect(r.w, Float64(0.0))
}

@Test
func testStepVec2(): Unit {
    let e = Vec2<Float64, Defaultp>(0.5, 0.5)
    let x = Vec2<Float64, Defaultp>(0.0, 1.0)
    let r = step(e, x)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(1.0))
}

@Test
func testSmoothstepVec2(): Unit {
    let e0 = Vec2<Float64, Defaultp>(0.0, 0.0)
    let e1 = Vec2<Float64, Defaultp>(1.0, 1.0)
    let x = Vec2<Float64, Defaultp>(0.5, -0.5)
    let r = smoothstep(e0, e1, x)
    @Expect(r.x, Float64(0.5))
    @Expect(r.y, Float64(0.0))
}

// ── Group A Vec1 ──

@Test
func testAbsVec1(): Unit {
    let v = Vec1<Float64, Defaultp>(-3.0)
    let r = abs(v)
    @Expect(r.x, Float64(3.0))
}

@Test
func testSignVec1(): Unit {
    let v = Vec1<Float64, Defaultp>(-3.0)
    let r = sign(v)
    @Expect(r.x, Float64(-1.0))
}

@Test
func testMinVec1(): Unit {
    let a = Vec1<Float64, Defaultp>(2.0)
    let b = Vec1<Float64, Defaultp>(5.0)
    let r = min(a, b)
    @Expect(r.x, Float64(2.0))
}

@Test
func testMaxVec1(): Unit {
    let a = Vec1<Float64, Defaultp>(2.0)
    let b = Vec1<Float64, Defaultp>(5.0)
    let r = max(a, b)
    @Expect(r.x, Float64(5.0))
}

@Test
func testClampVec1(): Unit {
    let v = Vec1<Float64, Defaultp>(-1.0)
    let lo = Vec1<Float64, Defaultp>(0.0)
    let hi = Vec1<Float64, Defaultp>(1.0)
    let r = clamp(v, lo, hi)
    @Expect(r.x, Float64(0.0))
}

@Test
func testStepVec1(): Unit {
    let e = Vec1<Float64, Defaultp>(0.5)
    let x = Vec1<Float64, Defaultp>(0.0)
    let r = step(e, x)
    @Expect(r.x, Float64(0.0))
}

@Test
func testSmoothstepVec1(): Unit {
    let e0 = Vec1<Float64, Defaultp>(0.0)
    let e1 = Vec1<Float64, Defaultp>(1.0)
    let x = Vec1<Float64, Defaultp>(0.5)
    let r = smoothstep(e0, e1, x)
    @Expect(r.x, Float64(0.5))
}

// ── Group B: FloatingPoint<T> (scalar) ──

@Test
func testFloor(): Unit {
    @Expect(floor(Float64(3.7)), Float64(3.0))
    @Expect(floor(Float64(-3.7)), Float64(-4.0))
}

@Test
func testCeil(): Unit {
    @Expect(ceil(Float64(3.2)), Float64(4.0))
    @Expect(ceil(Float64(-3.2)), Float64(-3.0))
}

@Test
func testFract(): Unit {
    @Expect(fract(Float64(3.7)), Float64(0.7))
}

@Test
func testTrunc(): Unit {
    @Expect(trunc(Float64(3.7)), Float64(3.0))
    @Expect(trunc(Float64(-3.7)), Float64(-3.0))
}

@Test
func testRound(): Unit {
    @Expect(round(Float64(3.5)), Float64(4.0))
    @Expect(round(Float64(3.2)), Float64(3.0))
    @Expect(round(Float64(-3.5)), Float64(-3.0))
}

@Test
func testRoundEvenToEven(): Unit {
    @Expect(roundEven(Float64(2.5)), Float64(2.0))
}

@Test
func testRoundEvenToOdd(): Unit {
    @Expect(roundEven(Float64(3.5)), Float64(4.0))
}

@Test
func testRoundEvenNotHalf(): Unit {
    @Expect(roundEven(Float64(3.7)), Float64(4.0))
}

@Test
func testFma(): Unit {
    @Expect(fma(Float64(2.0), Float64(3.0), Float64(1.0)), Float64(7.0))
}

@Test
func testFrexpNormal(): Unit {
    let (m, e) = frexp(Float64(12.0))
    @Expect(e, Int64(4))
    @Expect(m, Float64(0.75))
}

@Test
func testFrexpZero(): Unit {
    let (m, e) = frexp(Float64(0.0))
    @Expect(m, Float64(0.0))
    @Expect(e, Int64(0))
}

@Test
func testFrexpNaN(): Unit {
    let (m, e) = frexp(Float64.getNaN())
    @Expect(isNaN(m))
    @Expect(e, Int64(0))
}

@Test
func testFrexpInf(): Unit {
    let (m, e) = frexp(Float64.getInfinity())
    @Expect(isInf(m))
    @Expect(e, Int64(0))
}

@Test
func testLdexp(): Unit {
    @Expect(ldexp(Float64(3.0), Int64(2)), Float64(12.0))
}

@Test
func testLdexpZero(): Unit {
    @Expect(ldexp(Float64(0.0), Int64(5)), Float64(0.0))
}

@Test
func testModf(): Unit {
    let (frac, intg) = modf(Float64(3.7))
    @Expect(frac, Float64(0.7))
    @Expect(intg, Float64(3.0))
}

@Test
func testModfNegative(): Unit {
    let (frac, intg) = modf(Float64(-3.7))
    @Expect(frac, Float64(-0.7))
    @Expect(intg, Float64(-3.0))
}

@Test
func testIsnanTrue(): Unit {
    @Expect(isnan(Float64.getNaN()))
}

@Test
func testIsnanFalse(): Unit {
    @Expect(!isnan(Float64(1.0)))
}

@Test
func testIsinfTrue(): Unit {
    @Expect(isinf(Float64.getInfinity()))
    @Expect(isinf(Float64.getNegInfinity()))
}

@Test
func testIsinfFalse(): Unit {
    @Expect(!isinf(Float64(1.0)))
}

// ── Group B Vec ──

@Test
func testFloorVec2(): Unit {
    let v = Vec2<Float64, Defaultp>(3.7, -3.7)
    let r = floor(v)
    @Expect(r.x, Float64(3.0))
    @Expect(r.y, Float64(-4.0))
}

@Test
func testFractVec4(): Unit {
    let v = Vec4<Float64, Defaultp>(1.3, 2.7, -0.5, 0.0)
    let r = fract(v)
    @Expect(r.x, Float64(0.3))
    @Expect(r.y, Float64(0.7))
    @Expect(r.z, Float64(0.5))
    @Expect(r.w, Float64(0.0))
}

@Test
func testRoundVec2(): Unit {
    let v = Vec2<Float64, Defaultp>(3.5, 3.2)
    let r = round(v)
    @Expect(r.x, Float64(4.0))
    @Expect(r.y, Float64(3.0))
}

@Test
func testCeilVec3(): Unit {
    let v = Vec3<Float64, Defaultp>(3.2, -3.2, 0.0)
    let r = ceil(v)
    @Expect(r.x, Float64(4.0))
    @Expect(r.y, Float64(-3.0))
    @Expect(r.z, Float64(0.0))
}

@Test
func testTruncVec4(): Unit {
    let v = Vec4<Float64, Defaultp>(3.7, -3.7, 0.0, 1.9)
    let r = trunc(v)
    @Expect(r.x, Float64(3.0))
    @Expect(r.y, Float64(-3.0))
    @Expect(r.z, Float64(0.0))
    @Expect(r.w, Float64(1.0))
}

@Test
func testFmaVec2(): Unit {
    let a = Vec2<Float64, Defaultp>(2.0, 3.0)
    let b = Vec2<Float64, Defaultp>(3.0, 4.0)
    let c = Vec2<Float64, Defaultp>(1.0, -1.0)
    let r = fma(a, b, c)
    @Expect(r.x, Float64(7.0))
    @Expect(r.y, Float64(11.0))
}

@Test
func testFrexpVec2(): Unit {
    let v = Vec2<Float64, Defaultp>(12.0, 0.0)
    let (m, e) = frexp(v)
    @Expect(m.x, Float64(0.75))
    @Expect(e.x, Int64(4))
    @Expect(m.y, Float64(0.0))
    @Expect(e.y, Int64(0))
}

@Test
func testLdexpVec2(): Unit {
    let v = Vec2<Float64, Defaultp>(3.0, 0.0)
    let r = ldexp(v, Int64(2))
    @Expect(r.x, Float64(12.0))
    @Expect(r.y, Float64(0.0))
}

@Test
func testModfVec2(): Unit {
    let v = Vec2<Float64, Defaultp>(3.7, -1.5)
    let (frac, intg) = modf(v)
    @Expect(frac.x, Float64(0.7))
    @Expect(intg.x, Float64(3.0))
    @Expect(frac.y, Float64(-0.5))
    @Expect(intg.y, Float64(-1.0))
}

@Test
func testIsnanVec2(): Unit {
    let v = Vec2<Float64, Defaultp>(Float64.getNaN(), 1.0)
    let r = isnan(v)
    @Expect(r.x, true)
    @Expect(r.y, false)
}

@Test
func testIsinfVec2(): Unit {
    let v = Vec2<Float64, Defaultp>(Float64.getInfinity(), 1.0)
    let r = isinf(v)
    @Expect(r.x, true)
    @Expect(r.y, false)
}

@Test
func testRoundEvenVec2(): Unit {
    let v = Vec2<Float64, Defaultp>(2.5, 3.5)
    let r = roundEven(v)
    @Expect(r.x, Float64(2.0))
    @Expect(r.y, Float64(4.0))
}

// ── Group B Vec1 ──

@Test
func testFloorVec1(): Unit {
    let v = Vec1<Float64, Defaultp>(3.7)
    let r = floor(v)
    @Expect(r.x, Float64(3.0))
}

@Test
func testCeilVec1(): Unit {
    let v = Vec1<Float64, Defaultp>(3.2)
    let r = ceil(v)
    @Expect(r.x, Float64(4.0))
}

@Test
func testFractVec1(): Unit {
    let v = Vec1<Float64, Defaultp>(3.7)
    let r = fract(v)
    @Expect(r.x, Float64(0.7))
}

@Test
func testTruncVec1(): Unit {
    let v = Vec1<Float64, Defaultp>(3.7)
    let r = trunc(v)
    @Expect(r.x, Float64(3.0))
}

@Test
func testRoundVec1(): Unit {
    let v = Vec1<Float64, Defaultp>(3.5)
    let r = round(v)
    @Expect(r.x, Float64(4.0))
}

@Test
func testRoundEvenVec1(): Unit {
    let v = Vec1<Float64, Defaultp>(2.5)
    let r = roundEven(v)
    @Expect(r.x, Float64(2.0))
}

@Test
func testFmaVec1(): Unit {
    let a = Vec1<Float64, Defaultp>(2.0)
    let b = Vec1<Float64, Defaultp>(3.0)
    let c = Vec1<Float64, Defaultp>(1.0)
    let r = fma(a, b, c)
    @Expect(r.x, Float64(7.0))
}

@Test
func testFrexpVec1(): Unit {
    let v = Vec1<Float64, Defaultp>(12.0)
    let (m, e) = frexp(v)
    @Expect(m.x, Float64(0.75))
    @Expect(e.x, Int64(4))
}

@Test
func testLdexpVec1(): Unit {
    let v = Vec1<Float64, Defaultp>(3.0)
    let r = ldexp(v, Int64(2))
    @Expect(r.x, Float64(12.0))
}

@Test
func testModfVec1(): Unit {
    let v = Vec1<Float64, Defaultp>(3.7)
    let (frac, intg) = modf(v)
    @Expect(frac.x, Float64(0.7))
    @Expect(intg.x, Float64(3.0))
}

@Test
func testIsnanVec1(): Unit {
    let v = Vec1<Float64, Defaultp>(Float64.getNaN())
    let r = isnan(v)
    @Expect(r.x, true)
}

@Test
func testIsinfVec1(): Unit {
    let v = Vec1<Float64, Defaultp>(Float64.getInfinity())
    let r = isinf(v)
    @Expect(r.x, true)
}

// ── Group C: mix ──

@Test
func testMixThreeParam(): Unit {
    @Expect(mix(Float64(1.0), Float64(3.0), Float64(0.5)), Float64(2.0))
}

@Test
func testMixBoolSelectTrue(): Unit {
    @Expect(mix(Float64(1.0), Float64(3.0), true), Float64(3.0))
}

@Test
func testMixBoolSelectFalse(): Unit {
    @Expect(mix(Float64(1.0), Float64(3.0), false), Float64(1.0))
}

@Test
func testMixVec2ThreeParam(): Unit {
    let a = Vec2<Float64, Defaultp>(1.0, 2.0)
    let b = Vec2<Float64, Defaultp>(3.0, 4.0)
    let t = Vec2<Float64, Defaultp>(0.5, 0.0)
    let r = mix(a, b, t)
    @Expect(r.x, Float64(2.0))
    @Expect(r.y, Float64(2.0))
}

@Test
func testMixVec2Bool(): Unit {
    let x = Vec2<Float64, Defaultp>(1.0, 2.0)
    let y = Vec2<Float64, Defaultp>(3.0, 4.0)
    @Expect(mix(x, y, true), y)
    @Expect(mix(x, y, false), x)
}

// ── Group C Vec1 ──

@Test
func testMixVec1ThreeParam(): Unit {
    let a = Vec1<Float64, Defaultp>(1.0)
    let b = Vec1<Float64, Defaultp>(3.0)
    let t = Vec1<Float64, Defaultp>(0.5)
    let r = mix(a, b, t)
    @Expect(r.x, Float64(2.0))
}

@Test
func testMixVec1Bool(): Unit {
    let x = Vec1<Float64, Defaultp>(1.0)
    let y = Vec1<Float64, Defaultp>(3.0)
    @Expect(mix(x, y, true), y)
    @Expect(mix(x, y, false), x)
}

// ── Group D: mod Integer ──

@Test
func testModInt(): Unit {
    @Expect(mod(Int64(10), Int64(3)), Int64(1))
}

@Test
func testModIntZero(): Unit {
    @Expect(mod(Int64(0), Int64(5)), Int64(0))
}

@Test
func testModIntExact(): Unit {
    @Expect(mod(Int64(9), Int64(3)), Int64(0))
}

@Test
func testModIntVec2(): Unit {
    let a = Vec2<Int64, Defaultp>(10, 9)
    let b = Vec2<Int64, Defaultp>(3, 3)
    let r = mod(a, b)
    @Expect(r.x, Int64(1))
    @Expect(r.y, Int64(0))
}

@Test
func testModIntDivByZero(): Unit {
    @ExpectThrows[ArithmeticException](mod(Int64(5), Int64(0)))
}

// ── Group D Vec1 ──

@Test
func testModIntVec1(): Unit {
    let a = Vec1<Int64, Defaultp>(10)
    let b = Vec1<Int64, Defaultp>(3)
    let r = mod(a, b)
    @Expect(r.x, Int64(1))
}

// ── Group E: mod float concrete ──

@Test
func testModFloat64(): Unit {
    @Expect(mod(5.0, 3.0), 2.0)
}

@Test
func testModFloat32(): Unit {
    @Expect(mod(5.0f32, 3.0f32), 2.0f32)
}

@Test
func testModFloat16(): Unit {
    @Expect(mod(Float16(5.0), Float16(3.0)), Float16(2.0))
}

// ── Group F: bit conversion ──

@Test
func testFloatBitsToInt(): Unit {
    let x: Float32 = 1.0
    let bits: Int32 = floatBitsToInt(x)
    let back: Float32 = intBitsToFloat(bits)
    @Expect(back, x)
}

@Test
func testFloatBitsToUint(): Unit {
    let x: Float32 = 1.0
    let bits: UInt32 = floatBitsToUint(x)
    let back: Float32 = uintBitsToFloat(bits)
    @Expect(back, x)
}

@Test
func testFloatBitsToIntVec2(): Unit {
    let v = Vec2<Float32, Defaultp>(1.0f32, -2.0f32)
    let r = floatBitsToInt(v)
    let back = intBitsToFloat(r)
    @Expect(back.x, v.x)
    @Expect(back.y, v.y)
}

@Test
func testFloatBitsToUintVec2(): Unit {
    let v = Vec2<Float32, Defaultp>(1.0f32, -2.0f32)
    let r = floatBitsToUint(v)
    let back = uintBitsToFloat(r)
    @Expect(back.x, v.x)
    @Expect(back.y, v.y)
}

@Test
func testIntBitsToFloatDirect(): Unit {
    let bits: Int32 = 0x3F800000
    let r = intBitsToFloat(bits)
    @Expect(r, Float32(1.0))
}

@Test
func testUintBitsToFloatDirect(): Unit {
    let bits: UInt32 = 0x3F800000
    let r = uintBitsToFloat(bits)
    @Expect(r, Float32(1.0))
}

// ── Group F Vec1 ──

@Test
func testFloatBitsToIntVec1(): Unit {
    let v = Vec1<Float32, Defaultp>(1.0f32)
    let r = floatBitsToInt(v)
    let back = intBitsToFloat(r)
    @Expect(back.x, v.x)
}

@Test
func testFloatBitsToUintVec1(): Unit {
    let v = Vec1<Float32, Defaultp>(1.0f32)
    let r = floatBitsToUint(v)
    let back = uintBitsToFloat(r)
    @Expect(back.x, v.x)
}
