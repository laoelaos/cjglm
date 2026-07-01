package glm.detail

import std.math.{ isNaN, isFinite }

// ===== Group 1: Exponential/Log/Power =====

@Test
func testSqrtTFloat64(): Unit {
    @Expect(sqrtT(Float64(4.0)), Float64(2.0))
    @Expect(sqrtT(Float64(0.0)), Float64(0.0))
}

@Test
func testSqrtTFloat16(): Unit {
    @Expect(sqrtT(Float16(4.0)), Float16(2.0))
    @Expect(sqrtT(Float16(0.0)), Float16(0.0))
}

@Test
func testSqrtTFloat32(): Unit {
    @Expect(sqrtT(Float32(4.0)), Float32(2.0))
    @Expect(sqrtT(Float32(0.0)), Float32(0.0))
}

@Test
func testSqrtTEdgeCases(): Unit {
    @Expect(isNaN(sqrtT(Float64(-1.0))))
    @Expect(sqrtT(Float64(1.0)), Float64(1.0))
}

@Test
func testExpTFloat64(): Unit {
    @Expect(expT(Float64(0.0)), Float64(1.0))
    @Expect(expT(Float64(1.0)), Float64(2.718281828459045))
}

@Test
func testExpTFloat32(): Unit {
    @Expect(expT(Float32(0.0)), Float32(1.0))
    @Expect(expT(Float32(1.0)), Float32(2.718281828459045))
}

@Test
func testExpTFloat16(): Unit {
    @Expect(expT(Float16(0.0)), Float16(1.0))
}

@Test
func testLogTFloat64(): Unit {
    @Expect(logT(Float64(1.0)), Float64(0.0))
    @Expect(logT(Float64(2.718281828459045)), Float64(1.0))
}

@Test
func testLogTFloat32(): Unit {
    @Expect(logT(Float32(1.0)), Float32(0.0))
    @Expect(logT(Float32(2.718281828459045)), Float32(1.0))
}

@Test
func testLogTFloat16(): Unit {
    @Expect(logT(Float16(1.0)), Float16(0.0))
}

@Test
func testExp2TFloat16(): Unit {
    @Expect(exp2T(Float16(0.0)), Float16(1.0))
    @Expect(exp2T(Float16(3.0)), Float16(8.0))
}

@Test
func testLog2TFloat16(): Unit {
    @Expect(log2T(Float16(1.0)), Float16(0.0))
    @Expect(log2T(Float16(8.0)), Float16(3.0))
}

@Test
func testLogTEdgeCases(): Unit {
    @Expect(!isFinite(logT(Float64(0.0))))
    @Expect(isNaN(logT(Float64(-1.0))))
}

@Test
func testExp2TFloat64(): Unit {
    @Expect(exp2T(Float64(0.0)), Float64(1.0))
    @Expect(exp2T(Float64(1.0)), Float64(2.0))
    @Expect(exp2T(Float64(3.0)), Float64(8.0))
}

@Test
func testExp2TFloat32(): Unit {
    @Expect(exp2T(Float32(0.0)), Float32(1.0))
    @Expect(exp2T(Float32(3.0)), Float32(8.0))
}

@Test
func testLog2TFloat64(): Unit {
    @Expect(log2T(Float64(1.0)), Float64(0.0))
    @Expect(log2T(Float64(8.0)), Float64(3.0))
}

@Test
func testLog2TFloat32(): Unit {
    @Expect(log2T(Float32(1.0)), Float32(0.0))
    @Expect(log2T(Float32(8.0)), Float32(3.0))
}

@Test
func testPowTFloat64(): Unit {
    @Expect(powT(Float64(2.0), Float64(3.0)), Float64(8.0))
    @Expect(powT(Float64(4.0), Float64(0.5)), Float64(2.0))
    @Expect(powT(Float64(0.0), Float64(1.0)), Float64(0.0))
}

@Test
func testPowTFloat32(): Unit {
    @Expect(powT(Float32(2.0), Float32(3.0)), Float32(8.0))
    @Expect(powT(Float32(4.0), Float32(0.5)), Float32(2.0))
}

@Test
func testPowTFloat16(): Unit {
    @Expect(powT(Float16(2.0), Float16(3.0)), Float16(8.0))
}

// ===== Group 2: Trigonometric =====

@Test
func testSinTFloat64(): Unit {
    @Expect(sinT(Float64(0.0)), Float64(0.0))
    @Expect(sinT(Float64(1.5707963267948966)), Float64(1.0))
}

@Test
func testSinTFloat32(): Unit {
    @Expect(sinT(Float32(0.0)), Float32(0.0))
    @Expect(sinT(Float32(1.5707963267948966)), Float32(1.0))
    @Expect(sinT(Float32(0.7853981633974483)), Float32(0.7071067811865476))
    @Expect(sinT(Float32(0.5235987755982988)), Float32(0.5))
}

@Test
func testSinTFloat16(): Unit {
    @Expect(sinT(Float16(0.0)), Float16(0.0))
}

@Test
func testSinhTFloat16(): Unit {
    @Expect(sinhT(Float16(0.0)), Float16(0.0))
}

@Test
func testFloorTFloat16(): Unit {
    @Expect(floorT(Float16(3.7)), Float16(3.0))
    @Expect(floorT(Float16(-3.7)), Float16(-4.0))
}

@Test
func testCosTFloat64(): Unit {
    @Expect(cosT(Float64(0.0)), Float64(1.0))
    @Expect(cosT(Float64(3.141592653589793)), Float64(-1.0))
}

@Test
func testCosTFloat32(): Unit {
    @Expect(cosT(Float32(0.0)), Float32(1.0))
    @Expect(cosT(Float32(3.141592653589793)), Float32(-1.0))
}

@Test
func testTanTFloat64(): Unit {
    @Expect(tanT(Float64(0.0)), Float64(0.0))
    @Expect(tanT(Float64(0.7853981633974483)), Float64(1.0))
}

@Test
func testTanTFloat32(): Unit {
    @Expect(tanT(Float32(0.0)), Float32(0.0))
    @Expect(tanT(Float32(0.7853981633974483)), Float32(1.0))
}

@Test
func testAsinTFloat64(): Unit {
    @Expect(asinT(Float64(0.0)), Float64(0.0))
    @Expect(asinT(Float64(1.0)), Float64(1.5707963267948966))
    @Expect(asinT(Float64(-1.0)), Float64(-1.5707963267948966))
}

@Test
func testAsinTFloat32(): Unit {
    @Expect(asinT(Float32(0.0)), Float32(0.0))
    @Expect(asinT(Float32(1.0)), Float32(1.5707963267948966))
    @Expect(asinT(Float32(-1.0)), Float32(-1.5707963267948966))
}

@Test
func testAcosTFloat64(): Unit {
    @Expect(acosT(Float64(1.0)), Float64(0.0))
    @Expect(acosT(Float64(0.0)), Float64(1.5707963267948966))
}

@Test
func testAcosTFloat32(): Unit {
    @Expect(acosT(Float32(1.0)), Float32(0.0))
    @Expect(acosT(Float32(0.0)), Float32(1.5707963267948966))
}

@Test
func testAtanTFloat64(): Unit {
    @Expect(atanT(Float64(0.0)), Float64(0.0))
    @Expect(atanT(Float64(1.0)), Float64(0.7853981633974483))
}

@Test
func testAtanTFloat32(): Unit {
    @Expect(atanT(Float32(0.0)), Float32(0.0))
    @Expect(atanT(Float32(1.0)), Float32(0.7853981633974483))
}

@Test
func testAtan2TFloat64(): Unit {
    @Expect(atan2T(Float64(0.0), Float64(1.0)), Float64(0.0))
    @Expect(atan2T(Float64(1.0), Float64(0.0)), Float64(1.5707963267948966))
}

@Test
func testAtan2TFloat32(): Unit {
    @Expect(atan2T(Float32(0.0), Float32(1.0)), Float32(0.0))
    @Expect(atan2T(Float32(1.0), Float32(0.0)), Float32(1.5707963267948966))
}

@Test
func testCosTFloat16(): Unit {
    @Expect(cosT(Float16(0.0)), Float16(1.0))
}

@Test
func testTanTFloat16(): Unit {
    @Expect(tanT(Float16(0.0)), Float16(0.0))
}

@Test
func testAsinTFloat16(): Unit {
    @Expect(asinT(Float16(0.0)), Float16(0.0))
}

@Test
func testAcosTFloat16(): Unit {
    @Expect(acosT(Float16(1.0)), Float16(0.0))
}

@Test
func testAtanTFloat16(): Unit {
    @Expect(atanT(Float16(0.0)), Float16(0.0))
}

@Test
func testAtan2TFloat16(): Unit {
    @Expect(atan2T(Float16(0.0), Float16(1.0)), Float16(0.0))
}

// ===== Group 3: Hyperbolic =====

@Test
func testSinhTFloat64(): Unit {
    @Expect(sinhT(Float64(0.0)), Float64(0.0))
}

@Test
func testSinhTFloat32(): Unit {
    @Expect(sinhT(Float32(0.0)), Float32(0.0))
}

@Test
func testCoshTFloat64(): Unit {
    @Expect(coshT(Float64(0.0)), Float64(1.0))
}

@Test
func testCoshTFloat32(): Unit {
    @Expect(coshT(Float32(0.0)), Float32(1.0))
}

@Test
func testTanhTFloat64(): Unit {
    @Expect(tanhT(Float64(0.0)), Float64(0.0))
}

@Test
func testTanhTFloat32(): Unit {
    @Expect(tanhT(Float32(0.0)), Float32(0.0))
}

@Test
func testAsinhTFloat64(): Unit {
    @Expect(asinhT(Float64(0.0)), Float64(0.0))
}

@Test
func testAsinhTFloat32(): Unit {
    @Expect(asinhT(Float32(0.0)), Float32(0.0))
}

@Test
func testAcoshTFloat64(): Unit {
    @Expect(acoshT(Float64(1.0)), Float64(0.0))
}

@Test
func testAcoshTFloat32(): Unit {
    @Expect(acoshT(Float32(1.0)), Float32(0.0))
}

@Test
func testAtanhTFloat64(): Unit {
    @Expect(atanhT(Float64(0.0)), Float64(0.0))
}

@Test
func testAtanhTFloat32(): Unit {
    @Expect(atanhT(Float32(0.0)), Float32(0.0))
}

@Test
func testCoshTFloat16(): Unit {
    @Expect(coshT(Float16(0.0)), Float16(1.0))
}

@Test
func testTanhTFloat16(): Unit {
    @Expect(tanhT(Float16(0.0)), Float16(0.0))
}

@Test
func testAsinhTFloat16(): Unit {
    @Expect(asinhT(Float16(0.0)), Float16(0.0))
}

@Test
func testAcoshTFloat16(): Unit {
    @Expect(acoshT(Float16(1.0)), Float16(0.0))
}

@Test
func testAtanhTFloat16(): Unit {
    @Expect(atanhT(Float16(0.0)), Float16(0.0))
}

// ===== Group 4: Rounding/Absolute =====

@Test
func testFloorTFloat64(): Unit {
    @Expect(floorT(Float64(3.7)), Float64(3.0))
    @Expect(floorT(Float64(-3.7)), Float64(-4.0))
    @Expect(floorT(Float64(0.0)), Float64(0.0))
}

@Test
func testFloorTFloat32(): Unit {
    @Expect(floorT(Float32(3.7)), Float32(3.0))
    @Expect(floorT(Float32(-3.7)), Float32(-4.0))
}

@Test
func testCeilTFloat64(): Unit {
    @Expect(ceilT(Float64(3.2)), Float64(4.0))
    @Expect(ceilT(Float64(-3.2)), Float64(-3.0))
    @Expect(ceilT(Float64(0.0)), Float64(0.0))
}

@Test
func testCeilTFloat32(): Unit {
    @Expect(ceilT(Float32(3.2)), Float32(4.0))
    @Expect(ceilT(Float32(-3.2)), Float32(-3.0))
}

@Test
func testRoundTFloat64(): Unit {
    @Expect(roundT(Float64(3.5)), Float64(4.0))
    @Expect(roundT(Float64(3.2)), Float64(3.0))
    @Expect(roundT(Float64(-3.5)), Float64(-3.0))
    @Expect(roundT(Float64(0.0)), Float64(0.0))
}

@Test
func testRoundTFloat32(): Unit {
    @Expect(roundT(Float32(3.5)), Float32(4.0))
    @Expect(roundT(Float32(3.2)), Float32(3.0))
}

@Test
func testTruncTFloat64(): Unit {
    @Expect(truncT(Float64(3.7)), Float64(3.0))
    @Expect(truncT(Float64(-3.7)), Float64(-3.0))
    @Expect(truncT(Float64(0.0)), Float64(0.0))
}

@Test
func testTruncTFloat32(): Unit {
    @Expect(truncT(Float32(3.7)), Float32(3.0))
    @Expect(truncT(Float32(-3.7)), Float32(-3.0))
}

@Test
func testAbsTFloat64(): Unit {
    @Expect(absT(Float64(5.0)), Float64(5.0))
    @Expect(absT(Float64(-5.0)), Float64(5.0))
    @Expect(absT(Float64(0.0)), Float64(0.0))
}

@Test
func testAbsTFloat32(): Unit {
    @Expect(absT(Float32(5.0)), Float32(5.0))
    @Expect(absT(Float32(-5.0)), Float32(5.0))
}

@Test
func testFmodTFloat64(): Unit {
    @Expect(fmodT(Float64(5.0), Float64(3.0)), Float64(2.0))
    @Expect(fmodT(Float64(-5.0), Float64(3.0)), Float64(-2.0))
    @Expect(fmodT(Float64(0.0), Float64(1.0)), Float64(0.0))
}

@Test
func testFmodTFloat32(): Unit {
    @Expect(fmodT(Float32(5.0), Float32(3.0)), Float32(2.0))
    @Expect(fmodT(Float32(-5.0), Float32(3.0)), Float32(-2.0))
}

@Test
func testCeilTFloat16(): Unit {
    @Expect(ceilT(Float16(3.2)), Float16(4.0))
    @Expect(ceilT(Float16(-3.2)), Float16(-3.0))
}

@Test
func testRoundTFloat16(): Unit {
    @Expect(roundT(Float16(3.5)), Float16(4.0))
    @Expect(roundT(Float16(3.2)), Float16(3.0))
}

@Test
func testTruncTFloat16(): Unit {
    @Expect(truncT(Float16(3.7)), Float16(3.0))
    @Expect(truncT(Float16(-3.7)), Float16(-3.0))
}

@Test
func testAbsTFloat16(): Unit {
    @Expect(absT(Float16(5.0)), Float16(5.0))
    @Expect(absT(Float16(-5.0)), Float16(5.0))
}

@Test
func testFmodTFloat16(): Unit {
    @Expect(fmodT(Float16(5.0), Float16(3.0)), Float16(2.0))
    @Expect(fmodT(Float16(-5.0), Float16(3.0)), Float16(-2.0))
}

// ===== Domain Error Tests =====

@Test
func testAsinTOutOfRange(): Unit {
    @ExpectThrows[Exception](asinT(Float64(1.5)))
    @ExpectThrows[Exception](asinT(Float64(-1.5)))
}

@Test
func testAcosTOutOfRange(): Unit {
    @ExpectThrows[Exception](acosT(Float64(1.5)))
    @ExpectThrows[Exception](acosT(Float64(-1.5)))
}

@Test
func testAcoshTDomainError(): Unit {
    @Expect(isNaN(acoshT(Float64(0.5))))
}

@Test
func testAtanhTDomainError(): Unit {
    @Expect(isNaN(atanhT(Float64(1.5))))
}

// ===== Float16 Overflow Deviation (DV) =====

@Test
func testExpTFloat16OverflowThrows(): Unit {
    let maxF16 = Float16(65504.0)
    try {
        expT(maxF16)
        @Expect(false, true)
    } catch (_: ArithmeticException) {
        @Expect(true, true)
    }
}

// ===== Return Type Consistency =====

@Test
func testReturnTypeFloat64IsFloat64(): Unit {
    let r: Float64 = sqrtT(Float64(4.0))
    @Expect(r, Float64(2.0))
}

@Test
func testReturnTypeFloat32IsFloat32(): Unit {
    let r: Float32 = sqrtT(Float32(4.0))
    @Expect(r, Float32(2.0))
}

// ===== Regression: name resolution ambiguity fix (R2) =====
// These verify that shim functions resolve to std.math (not same-package public functions)
// and do NOT cause StackOverflowError via infinite recursion.

@Test
func testSqrtTNoStackOverflow(): Unit {
    @Expect(sqrtT(Float64(4.0)), Float64(2.0))
    @Expect(sqrtT(Float64(0.0)), Float64(0.0))
}

@Test
func testAbsTNoStackOverflow(): Unit {
    @Expect(absT(Float64(5.0)), Float64(5.0))
    @Expect(absT(Float64(-5.0)), Float64(5.0))
}

@Test
func testExpTNoStackOverflow(): Unit {
    @Expect(expT(Float64(0.0)), Float64(1.0))
}

@Test
func testLogTNoStackOverflow(): Unit {
    @Expect(logT(Float64(1.0)), Float64(0.0))
}

@Test
func testFloorTNoStackOverflow(): Unit {
    @Expect(floorT(Float64(3.7)), Float64(3.0))
}

@Test
func testShimInteropWithSamePackageSqrt(): Unit {
    let shimVal: Float64 = sqrtT(Float64(4.0))
    let pkgVal: Float64 = sqrt(Float64(4.0))
    @Expect(shimVal, pkgVal)
}

@Test
func testShimInteropWithSamePackageAbs(): Unit {
    let shimVal: Float64 = absT(Float64(-5.0))
    let pkgVal: Float64 = abs(Float64(-5.0))
    @Expect(shimVal, pkgVal)
}

@Test
func testAllShimNoStackOverflowInBatch(): Unit {
    @Expect(exp2T(Float64(3.0)), Float64(8.0))
    @Expect(sinT(Float64(0.0)), Float64(0.0))
    @Expect(cosT(Float64(0.0)), Float64(1.0))
    @Expect(tanT(Float64(0.0)), Float64(0.0))
    @Expect(asinT(Float64(0.0)), Float64(0.0))
    @Expect(acosT(Float64(1.0)), Float64(0.0))
    @Expect(atanT(Float64(0.0)), Float64(0.0))
    @Expect(atan2T(Float64(0.0), Float64(1.0)), Float64(0.0))
    @Expect(sinhT(Float64(0.0)), Float64(0.0))
    @Expect(coshT(Float64(0.0)), Float64(1.0))
    @Expect(tanhT(Float64(0.0)), Float64(0.0))
    @Expect(asinhT(Float64(0.0)), Float64(0.0))
    @Expect(acoshT(Float64(1.0)), Float64(0.0))
    @Expect(atanhT(Float64(0.0)), Float64(0.0))
    @Expect(ceilT(Float64(3.2)), Float64(4.0))
    @Expect(roundT(Float64(3.5)), Float64(4.0))
    @Expect(truncT(Float64(3.7)), Float64(3.0))
    @Expect(fmodT(Float64(5.0), Float64(3.0)), Float64(2.0))
}
