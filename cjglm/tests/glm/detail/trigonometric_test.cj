package glm.detail

import std.math.{ isNaN }

// ── Scalar Float64 ──

@Test
func testSin(): Unit {
    @Expect(sin(Float64(0.0)), Float64(0.0))
}

@Test
func testCos(): Unit {
    @Expect(cos(Float64(0.0)), Float64(1.0))
}

@Test
func testTan(): Unit {
    @Expect(tan(Float64(0.0)), Float64(0.0))
}

@Test
func testAsin(): Unit {
    @Expect(asin(Float64(0.0)), Float64(0.0))
}

@Test
func testAsinOutOfRange(): Unit {
    @Expect(isNaN(asin(Float64(2.0))))
}

@Test
func testAcos(): Unit {
    @Expect(acos(Float64(1.0)), Float64(0.0))
}

@Test
func testAcosOutOfRange(): Unit {
    @Expect(isNaN(acos(Float64(-2.0))))
}

@Test
func testAtan(): Unit {
    @Expect(atan(Float64(0.0)), Float64(0.0))
}

@Test
func testRadians(): Unit {
    let r = radians(Float64(180.0))
    let p = pi<Float64>()
    @Expect(r, p)
}

@Test
func testDegrees(): Unit {
    let p = pi<Float64>()
    @Expect(degrees(p), Float64(180.0))
}

@Test
func testSinh(): Unit {
    @Expect(sinh(Float64(0.0)), Float64(0.0))
}

@Test
func testCosh(): Unit {
    @Expect(cosh(Float64(0.0)), Float64(1.0))
}

@Test
func testTanh(): Unit {
    @Expect(tanh(Float64(0.0)), Float64(0.0))
}

@Test
func testAsinh(): Unit {
    @Expect(asinh(Float64(0.0)), Float64(0.0))
}

@Test
func testAcosh(): Unit {
    @Expect(acosh(Float64(1.0)), Float64(0.0))
}

@Test
func testAtanh(): Unit {
    @Expect(atanh(Float64(0.0)), Float64(0.0))
}

@Test
func testAtan2(): Unit {
    @Expect(atan2(Float64(0.0), Float64(1.0)), Float64(0.0))
    @Expect(atan2(Float64(1.0), Float64(0.0)), Float64(1.5707963267948966))
}

// ── Scalar Float32 ──

@Test
func testSinFloat32(): Unit {
    @Expect(sin(Float32(0.0)), Float32(0.0))
}

@Test
func testCosFloat32(): Unit {
    @Expect(cos(Float32(0.0)), Float32(1.0))
}

@Test
func testTanFloat32(): Unit {
    @Expect(tan(Float32(0.0)), Float32(0.0))
}

@Test
func testAsinFloat32(): Unit {
    @Expect(asin(Float32(0.0)), Float32(0.0))
}

@Test
func testAsinOutOfRangeFloat32(): Unit {
    @Expect(isNaN(asin(Float32(2.0))))
}

@Test
func testAcosFloat32(): Unit {
    @Expect(acos(Float32(1.0)), Float32(0.0))
}

@Test
func testAcosOutOfRangeFloat32(): Unit {
    @Expect(isNaN(acos(Float32(-2.0))))
}

@Test
func testAtanFloat32(): Unit {
    @Expect(atan(Float32(0.0)), Float32(0.0))
}

@Test
func testRadiansFloat32(): Unit {
    let r = radians(Float32(180.0))
    let p = pi<Float32>()
    @Expect(r, p)
}

@Test
func testDegreesFloat32(): Unit {
    let p = pi<Float32>()
    @Expect(degrees(p), Float32(180.0))
}

@Test
func testSinhFloat32(): Unit {
    @Expect(sinh(Float32(0.0)), Float32(0.0))
}

@Test
func testCoshFloat32(): Unit {
    @Expect(cosh(Float32(0.0)), Float32(1.0))
}

@Test
func testTanhFloat32(): Unit {
    @Expect(tanh(Float32(0.0)), Float32(0.0))
}

@Test
func testAsinhFloat32(): Unit {
    @Expect(asinh(Float32(0.0)), Float32(0.0))
}

@Test
func testAcoshFloat32(): Unit {
    @Expect(acosh(Float32(1.0)), Float32(0.0))
}

@Test
func testAtanhFloat32(): Unit {
    @Expect(atanh(Float32(0.0)), Float32(0.0))
}

@Test
func testAtan2Float32(): Unit {
    @Expect(atan2(Float32(0.0), Float32(1.0)), Float32(0.0))
    @Expect(atan2(Float32(1.0), Float32(0.0)), Float32(1.5707963267948966))
}

// ── Scalar Float16 ──

@Test
func testSinFloat16(): Unit {
    @Expect(sin(Float16(0.0)), Float16(0.0))
}

@Test
func testCosFloat16(): Unit {
    @Expect(cos(Float16(0.0)), Float16(1.0))
}

@Test
func testTanFloat16(): Unit {
    @Expect(tan(Float16(0.0)), Float16(0.0))
}

@Test
func testAsinFloat16(): Unit {
    @Expect(asin(Float16(0.0)), Float16(0.0))
}

@Test
func testAsinOutOfRangeFloat16(): Unit {
    @Expect(isNaN(asin(Float16(2.0))))
}

@Test
func testAcosFloat16(): Unit {
    @Expect(acos(Float16(1.0)), Float16(0.0))
}

@Test
func testAcosOutOfRangeFloat16(): Unit {
    @Expect(isNaN(acos(Float16(-2.0))))
}

@Test
func testAtanFloat16(): Unit {
    @Expect(atan(Float16(0.0)), Float16(0.0))
}

@Test
func testRadiansFloat16(): Unit {
    let r = radians(Float16(180.0))
    let p = pi<Float16>()
    @Expect(r, p)
}

@Test
func testDegreesFloat16(): Unit {
    let p = pi<Float16>()
    @Expect(degrees(p), Float16(180.0))
}

@Test
func testSinhFloat16(): Unit {
    @Expect(sinh(Float16(0.0)), Float16(0.0))
}

@Test
func testCoshFloat16(): Unit {
    @Expect(cosh(Float16(0.0)), Float16(1.0))
}

@Test
func testTanhFloat16(): Unit {
    @Expect(tanh(Float16(0.0)), Float16(0.0))
}

@Test
func testAsinhFloat16(): Unit {
    @Expect(asinh(Float16(0.0)), Float16(0.0))
}

@Test
func testAcoshFloat16(): Unit {
    @Expect(acosh(Float16(1.0)), Float16(0.0))
}

@Test
func testAtanhFloat16(): Unit {
    @Expect(atanh(Float16(0.0)), Float16(0.0))
}

@Test
func testAtan2Float16(): Unit {
    @Expect(atan2(Float16(0.0), Float16(1.0)), Float16(0.0))
}

@Test
func testAtan2SecondBranchFloat16(): Unit {
    @Expect(atan2(Float16(1.0), Float16(0.0)), Float16(1.5707963267948966))
    @Expect(atan2(Float16(-1.0), Float16(0.0)), Float16(-1.5707963267948966))
    @Expect(atan2(Float16(0.0), Float16(-1.0)), Float16(3.141592653589793))
}

// ── Boundary: asin/acos ──

@Test
func testAsinPlusOne(): Unit {
    @Expect(asin(Float64(1.0)), Float64(1.5707963267948966))
}

@Test
func testAsinMinusOne(): Unit {
    @Expect(asin(Float64(-1.0)), Float64(-1.5707963267948966))
}

@Test
func testAcosPlusOne(): Unit {
    @Expect(acos(Float64(1.0)), Float64(0.0))
}

@Test
func testAcosMinusOne(): Unit {
    @Expect(acos(Float64(-1.0)), Float64(3.141592653589793))
}

@Test
func testAsinPlusOneFloat16(): Unit {
    @Expect(asin(Float16(1.0)), Float16(1.5707963267948966))
}

@Test
func testAsinMinusOneFloat16(): Unit {
    @Expect(asin(Float16(-1.0)), Float16(-1.5707963267948966))
}

@Test
func testAcosPlusOneFloat16(): Unit {
    @Expect(acos(Float16(1.0)), Float16(0.0))
}

@Test
func testAcosMinusOneFloat16(): Unit {
    @Expect(acos(Float16(-1.0)), Float16(3.141592653589793))
}

// ── Vec1 ──

@Test
func testSinVec1(): Unit {
    let v = Vec1<Float64, Defaultp>(0.0)
    let r = sin(v)
    @Expect(r.x, Float64(0.0))
}

@Test
func testCosVec1(): Unit {
    let v = Vec1<Float64, Defaultp>(0.0)
    let r = cos(v)
    @Expect(r.x, Float64(1.0))
}

@Test
func testTanVec1(): Unit {
    let v = Vec1<Float64, Defaultp>(0.0)
    let r = tan(v)
    @Expect(r.x, Float64(0.0))
}

@Test
func testAsinVec1(): Unit {
    let v = Vec1<Float64, Defaultp>(2.0)
    let r = asin(v)
    @Expect(isNaN(r.x))
}

@Test
func testAcosVec1(): Unit {
    let v1 = Vec1<Float64, Defaultp>(1.0)
    @Expect(acos(v1).x, Float64(0.0))
    let v2 = Vec1<Float64, Defaultp>(-1.0)
    @Expect(acos(v2).x, Float64(3.141592653589793))
    let v3 = Vec1<Float64, Defaultp>(2.0)
    @Expect(isNaN(acos(v3).x))
}

@Test
func testAtanVec1(): Unit {
    let v = Vec1<Float64, Defaultp>(0.0)
    let r = atan(v)
    @Expect(r.x, Float64(0.0))
}

@Test
func testRadiansVec1(): Unit {
    let v = Vec1<Float64, Defaultp>(180.0)
    let r = radians(v)
    let p = pi<Float64>()
    @Expect(r.x, p)
}

@Test
func testDegreesVec1(): Unit {
    let p = pi<Float64>()
    let v = Vec1<Float64, Defaultp>(p)
    let r = degrees(v)
    @Expect(r.x, Float64(180.0))
}

@Test
func testAtan2Vec1(): Unit {
    let y = Vec1<Float64, Defaultp>(0.0)
    let x = Vec1<Float64, Defaultp>(1.0)
    let r = atan2(y, x)
    @Expect(r.x, Float64(0.0))
}

// ── Vec2 ──

@Test
func testSinVec2(): Unit {
    let v = Vec2<Float64, Defaultp>(0.0, 1.5707963267948966)
    let r = sin(v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(1.0))
}

@Test
func testCosVec2(): Unit {
    let v = Vec2<Float64, Defaultp>(0.0, 3.141592653589793)
    let r = cos(v)
    @Expect(r.x, Float64(1.0))
    @Expect(r.y, Float64(-1.0))
}

@Test
func testTanVec2(): Unit {
    let v = Vec2<Float64, Defaultp>(0.0, 0.0)
    let r = tan(v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(0.0))
}

@Test
func testAsinVec2(): Unit {
    let v = Vec2<Float64, Defaultp>(0.0, 2.0)
    let r = asin(v)
    @Expect(r.x, Float64(0.0))
    @Expect(isNaN(r.y))
}

@Test
func testAcosVec2(): Unit {
    let v = Vec2<Float64, Defaultp>(1.0, -1.0)
    let r = acos(v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(3.141592653589793))
}

@Test
func testAtanVec2(): Unit {
    let v = Vec2<Float64, Defaultp>(0.0, 1.0)
    let r = atan(v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(0.7853981633974483))
}

@Test
func testRadiansVec2(): Unit {
    let v = Vec2<Float64, Defaultp>(0.0, 180.0)
    let r = radians(v)
    @Expect(r.x, Float64(0.0))
    let p = pi<Float64>()
    @Expect(r.y, p)
}

@Test
func testDegreesVec2(): Unit {
    let p = pi<Float64>()
    let v = Vec2<Float64, Defaultp>(0.0, p)
    let r = degrees(v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(180.0))
}

@Test
func testAtan2Vec2(): Unit {
    let y = Vec2<Float64, Defaultp>(0.0, 1.0)
    let x = Vec2<Float64, Defaultp>(1.0, 0.0)
    let r = atan2(y, x)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(1.5707963267948966))
}

// ── Vec3 ──

@Test
func testSinVec3(): Unit {
    let v = Vec3<Float64, Defaultp>(0.0, 1.5707963267948966, 0.0)
    let r = sin(v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(1.0))
    @Expect(r.z, Float64(0.0))
}

@Test
func testCosVec3(): Unit {
    let v = Vec3<Float64, Defaultp>(0.0, 3.141592653589793, 0.0)
    let r = cos(v)
    @Expect(r.x, Float64(1.0))
    @Expect(r.y, Float64(-1.0))
    @Expect(r.z, Float64(1.0))
}

@Test
func testTanVec3(): Unit {
    let v = Vec3<Float64, Defaultp>(0.0, 0.0, 0.0)
    let r = tan(v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(0.0))
    @Expect(r.z, Float64(0.0))
}

@Test
func testAsinVec3(): Unit {
    let v = Vec3<Float64, Defaultp>(0.0, 1.0, 2.0)
    let r = asin(v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(1.5707963267948966))
    @Expect(isNaN(r.z))
}

@Test
func testAcosVec3(): Unit {
    let v = Vec3<Float64, Defaultp>(1.0, -1.0, 2.0)
    let r = acos(v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(3.141592653589793))
    @Expect(isNaN(r.z))
}

@Test
func testAtanVec3(): Unit {
    let v = Vec3<Float64, Defaultp>(0.0, 1.0, 0.0)
    let r = atan(v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(0.7853981633974483))
    @Expect(r.z, Float64(0.0))
}

@Test
func testRadiansVec3(): Unit {
    let p = pi<Float64>()
    let v = Vec3<Float64, Defaultp>(0.0, 90.0, 180.0)
    let r = radians(v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, p / Float64(2.0))
    @Expect(r.z, p)
}

@Test
func testDegreesVec3(): Unit {
    let p = pi<Float64>()
    let v = Vec3<Float64, Defaultp>(0.0, p / Float64(2.0), p)
    let r = degrees(v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(90.0))
    @Expect(r.z, Float64(180.0))
}

@Test
func testAtan2Vec3(): Unit {
    let y = Vec3<Float64, Defaultp>(0.0, 1.0, 0.0)
    let x = Vec3<Float64, Defaultp>(1.0, 0.0, -1.0)
    let r = atan2(y, x)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(1.5707963267948966))
    @Expect(r.z, Float64(3.141592653589793))
}

// ── Vec4 ──

@Test
func testSinVec4(): Unit {
    let v = Vec4<Float64, Defaultp>(0.0, 1.5707963267948966, 0.0, 0.0)
    let r = sin(v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(1.0))
    @Expect(r.z, Float64(0.0))
    @Expect(r.w, Float64(0.0))
}

@Test
func testCosVec4(): Unit {
    let v = Vec4<Float64, Defaultp>(0.0, 3.141592653589793, 0.0, 0.0)
    let r = cos(v)
    @Expect(r.x, Float64(1.0))
    @Expect(r.y, Float64(-1.0))
    @Expect(r.z, Float64(1.0))
    @Expect(r.w, Float64(1.0))
}

@Test
func testTanVec4(): Unit {
    let v = Vec4<Float64, Defaultp>(0.0, 0.0, 0.0, 0.0)
    let r = tan(v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(0.0))
    @Expect(r.z, Float64(0.0))
    @Expect(r.w, Float64(0.0))
}

@Test
func testAsinVec4(): Unit {
    let v = Vec4<Float64, Defaultp>(0.0, 1.0, 2.0, -1.0)
    let r = asin(v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(1.5707963267948966))
    @Expect(isNaN(r.z))
    @Expect(r.w, Float64(-1.5707963267948966))
}

@Test
func testAcosVec4(): Unit {
    let v = Vec4<Float64, Defaultp>(1.0, -1.0, 2.0, 0.0)
    let r = acos(v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(3.141592653589793))
    @Expect(isNaN(r.z))
    @Expect(r.w, Float64(1.5707963267948966))
}

@Test
func testAtanVec4(): Unit {
    let v = Vec4<Float64, Defaultp>(0.0, 1.0, 0.0, -1.0)
    let r = atan(v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(0.7853981633974483))
    @Expect(r.z, Float64(0.0))
    @Expect(r.w, Float64(-0.7853981633974483))
}

@Test
func testRadiansVec4(): Unit {
    let p = pi<Float64>()
    let v = Vec4<Float64, Defaultp>(0.0, 90.0, 180.0, 360.0)
    let r = radians(v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, p / Float64(2.0))
    @Expect(r.z, p)
    @Expect(r.w, Float64(2.0) * p)
}

@Test
func testDegreesVec4(): Unit {
    let p = pi<Float64>()
    let v = Vec4<Float64, Defaultp>(0.0, p / Float64(2.0), p, Float64(2.0) * p)
    let r = degrees(v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(90.0))
    @Expect(r.z, Float64(180.0))
    @Expect(r.w, Float64(360.0))
}

@Test
func testAtan2Vec4(): Unit {
    let y = Vec4<Float64, Defaultp>(0.0, 1.0, 0.0, -1.0)
    let x = Vec4<Float64, Defaultp>(1.0, 0.0, -1.0, 0.0)
    let r = atan2(y, x)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(1.5707963267948966))
    @Expect(r.z, Float64(3.141592653589793))
    @Expect(r.w, Float64(-1.5707963267948966))
}

// ── Sinh/Cosh/Tanh Vec ──

@Test
func testSinhVec1(): Unit {
    let v = Vec1<Float64, Defaultp>(0.0)
    let r = sinh(v)
    @Expect(r.x, Float64(0.0))
}

@Test
func testCoshVec1(): Unit {
    let v = Vec1<Float64, Defaultp>(0.0)
    let r = cosh(v)
    @Expect(r.x, Float64(1.0))
}

@Test
func testTanhVec1(): Unit {
    let v = Vec1<Float64, Defaultp>(0.0)
    let r = tanh(v)
    @Expect(r.x, Float64(0.0))
}

@Test
func testSinhVec2(): Unit {
    let v = Vec2<Float64, Defaultp>(0.0, 0.0)
    let r = sinh(v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(0.0))
}

@Test
func testCoshVec2(): Unit {
    let v = Vec2<Float64, Defaultp>(0.0, 0.0)
    let r = cosh(v)
    @Expect(r.x, Float64(1.0))
    @Expect(r.y, Float64(1.0))
}

@Test
func testTanhVec2(): Unit {
    let v = Vec2<Float64, Defaultp>(0.0, 0.0)
    let r = tanh(v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(0.0))
}

@Test
func testSinhVec3(): Unit {
    let v = Vec3<Float64, Defaultp>(0.0, 0.0, 0.0)
    let r = sinh(v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(0.0))
    @Expect(r.z, Float64(0.0))
}

@Test
func testCoshVec3(): Unit {
    let v = Vec3<Float64, Defaultp>(0.0, 0.0, 0.0)
    let r = cosh(v)
    @Expect(r.x, Float64(1.0))
    @Expect(r.y, Float64(1.0))
    @Expect(r.z, Float64(1.0))
}

@Test
func testTanhVec3(): Unit {
    let v = Vec3<Float64, Defaultp>(0.0, 0.0, 0.0)
    let r = tanh(v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(0.0))
    @Expect(r.z, Float64(0.0))
}

@Test
func testSinhVec4(): Unit {
    let v = Vec4<Float64, Defaultp>(0.0, 0.0, 0.0, 0.0)
    let r = sinh(v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(0.0))
    @Expect(r.z, Float64(0.0))
    @Expect(r.w, Float64(0.0))
}

@Test
func testCoshVec4(): Unit {
    let v = Vec4<Float64, Defaultp>(0.0, 0.0, 0.0, 0.0)
    let r = cosh(v)
    @Expect(r.x, Float64(1.0))
    @Expect(r.y, Float64(1.0))
    @Expect(r.z, Float64(1.0))
    @Expect(r.w, Float64(1.0))
}

@Test
func testTanhVec4(): Unit {
    let v = Vec4<Float64, Defaultp>(0.0, 0.0, 0.0, 0.0)
    let r = tanh(v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(0.0))
    @Expect(r.z, Float64(0.0))
    @Expect(r.w, Float64(0.0))
}

// ── Vec asinh/acosh/atanh ──

@Test
func testAsinhVec1(): Unit {
    let v = Vec1<Float64, Defaultp>(0.0)
    let r = asinh(v)
    @Expect(r.x, Float64(0.0))
}

@Test
func testAcoshVec1(): Unit {
    let v = Vec1<Float64, Defaultp>(1.0)
    let r = acosh(v)
    @Expect(r.x, Float64(0.0))
}

@Test
func testAtanhVec1(): Unit {
    let v = Vec1<Float64, Defaultp>(0.0)
    let r = atanh(v)
    @Expect(r.x, Float64(0.0))
}

@Test
func testAsinhVec2(): Unit {
    let v = Vec2<Float64, Defaultp>(0.0, 0.0)
    let r = asinh(v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(0.0))
}

@Test
func testAcoshVec2(): Unit {
    let v = Vec2<Float64, Defaultp>(1.0, 1.0)
    let r = acosh(v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(0.0))
}

@Test
func testAtanhVec2(): Unit {
    let v = Vec2<Float64, Defaultp>(0.0, 0.0)
    let r = atanh(v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(0.0))
}

@Test
func testAsinhVec3NonZero(): Unit {
    let v = Vec3<Float64, Defaultp>(0.0, 1.0, -1.0)
    let r = asinh(v)
    @Expect(r.x, Float64(0.0))
    @Expect(abs(r.y - Float64(0.881373587019543)) < Float64(1e-12), true)
    @Expect(abs(r.z - Float64(-0.881373587019543)) < Float64(1e-12), true)
}

@Test
func testAcoshVec3NonZero(): Unit {
    let v = Vec3<Float64, Defaultp>(1.0, 2.0, 1.0)
    let r = acosh(v)
    @Expect(r.x, Float64(0.0))
    @Expect(abs(r.y - Float64(1.3169578969248166)) < Float64(1e-12), true)
    @Expect(r.z, Float64(0.0))
}

@Test
func testAtanhVec3NonZero(): Unit {
    let v = Vec3<Float64, Defaultp>(0.0, 0.5, -0.5)
    let r = atanh(v)
    @Expect(r.x, Float64(0.0))
    @Expect(abs(r.y - Float64(0.5493061443340549)) < Float64(1e-12), true)
    @Expect(abs(r.z - Float64(-0.5493061443340549)) < Float64(1e-12), true)
}

@Test
func testAsinhVec4NonZero(): Unit {
    let v = Vec4<Float64, Defaultp>(0.0, 1.0, -1.0, 2.0)
    let r = asinh(v)
    @Expect(r.x, Float64(0.0))
    @Expect(abs(r.y - Float64(0.881373587019543)) < Float64(1e-12), true)
    @Expect(abs(r.z - Float64(-0.881373587019543)) < Float64(1e-12), true)
    @Expect(abs(r.w - Float64(1.4436354751788103)) < Float64(1e-12), true)
}

@Test
func testAcoshVec4NonZero(): Unit {
    let v = Vec4<Float64, Defaultp>(1.0, 2.0, 1.0, 3.0)
    let r = acosh(v)
    @Expect(r.x, Float64(0.0))
    @Expect(abs(r.y - Float64(1.3169578969248166)) < Float64(1e-12), true)
    @Expect(r.z, Float64(0.0))
    @Expect(abs(r.w - Float64(1.762747174039086)) < Float64(1e-12), true)
}

@Test
func testAtanhVec4NonZero(): Unit {
    let v = Vec4<Float64, Defaultp>(0.0, 0.5, -0.5, 0.3)
    let r = atanh(v)
    @Expect(r.x, Float64(0.0))
    @Expect(abs(r.y - Float64(0.5493061443340549)) < Float64(1e-12), true)
    @Expect(abs(r.z - Float64(-0.5493061443340549)) < Float64(1e-12), true)
    @Expect(abs(r.w - Float64(0.3095196042031117)) < Float64(1e-12), true)
}

// ── Trigonometric Identities ──

@Test
func testIdentitySin2Cos2Float64(): Unit {
    let e = Float64(1e-12)
    let p6 = pi<Float64>() / Float64(6.0)
    let p4 = pi<Float64>() / Float64(4.0)
    let p3 = pi<Float64>() / Float64(3.0)
    let p2 = pi<Float64>() / Float64(2.0)
    let np4 = -pi<Float64>() / Float64(4.0)

    let s0 = sin(Float64(0.0)); let c0 = cos(Float64(0.0)); let t0 = tan(Float64(0.0))
    @Expect(abs(s0 * s0 + c0 * c0 - Float64(1.0)) < e, true)
    @Expect(abs(s0 - t0 * c0) < e, true)
    @Expect(abs(Float64(1.0) / (c0 * c0) - (Float64(1.0) + t0 * t0)) < e, true)

    let s1 = sin(p6); let c1 = cos(p6); let t1 = tan(p6)
    @Expect(abs(s1 * s1 + c1 * c1 - Float64(1.0)) < e, true)
    @Expect(abs(s1 - t1 * c1) < e, true)
    @Expect(abs(Float64(1.0) / (c1 * c1) - (Float64(1.0) + t1 * t1)) < e, true)

    let s2 = sin(p4); let c2 = cos(p4); let t2 = tan(p4)
    @Expect(abs(s2 * s2 + c2 * c2 - Float64(1.0)) < e, true)
    @Expect(abs(s2 - t2 * c2) < e, true)
    @Expect(abs(Float64(1.0) / (c2 * c2) - (Float64(1.0) + t2 * t2)) < e, true)

    let s3 = sin(p3); let c3 = cos(p3); let t3 = tan(p3)
    @Expect(abs(s3 * s3 + c3 * c3 - Float64(1.0)) < e, true)
    @Expect(abs(s3 - t3 * c3) < e, true)
    @Expect(abs(Float64(1.0) / (c3 * c3) - (Float64(1.0) + t3 * t3)) < e, true)

    let s4 = sin(p2); let c4 = cos(p2); let t4 = tan(p2)
    @Expect(abs(s4 * s4 + c4 * c4 - Float64(1.0)) < e, true)

    let s5 = sin(np4); let c5 = cos(np4); let t5 = tan(np4)
    @Expect(abs(s5 * s5 + c5 * c5 - Float64(1.0)) < e, true)
    @Expect(abs(s5 - t5 * c5) < e, true)
    @Expect(abs(Float64(1.0) / (c5 * c5) - (Float64(1.0) + t5 * t5)) < e, true)

    let v1 = Vec1<Float64, Defaultp>(p6)
    let sv1 = sin(v1); let cv1 = cos(v1); let tv1 = tan(v1)
    @Expect(abs(sv1.x * sv1.x + cv1.x * cv1.x - Float64(1.0)) < e, true)
    @Expect(abs(sv1.x - tv1.x * cv1.x) < e, true)
    @Expect(abs(Float64(1.0) / (cv1.x * cv1.x) - (Float64(1.0) + tv1.x * tv1.x)) < e, true)

    let v2 = Vec2<Float64, Defaultp>(Float64(0.0), p6)
    let sv2 = sin(v2); let cv2 = cos(v2); let tv2 = tan(v2)
    let sc2 = sv2 * sv2 + cv2 * cv2
    @Expect(abs(sc2.x - Float64(1.0)) < e, true)
    @Expect(abs(sc2.y - Float64(1.0)) < e, true)
    @Expect(abs(sv2.x - tv2.x * cv2.x) < e, true)
    @Expect(abs(sv2.y - tv2.y * cv2.y) < e, true)
    @Expect(abs(Float64(1.0) / (cv2.x * cv2.x) - (Float64(1.0) + tv2.x * tv2.x)) < e, true)
    @Expect(abs(Float64(1.0) / (cv2.y * cv2.y) - (Float64(1.0) + tv2.y * tv2.y)) < e, true)

    let v3 = Vec3<Float64, Defaultp>(Float64(0.0), p6, p4)
    let sv3 = sin(v3); let cv3 = cos(v3); let tv3 = tan(v3)
    let sc3 = sv3 * sv3 + cv3 * cv3
    @Expect(abs(sc3.x - Float64(1.0)) < e, true)
    @Expect(abs(sc3.y - Float64(1.0)) < e, true)
    @Expect(abs(sc3.z - Float64(1.0)) < e, true)
    @Expect(abs(sv3.x - tv3.x * cv3.x) < e, true)
    @Expect(abs(sv3.y - tv3.y * cv3.y) < e, true)
    @Expect(abs(sv3.z - tv3.z * cv3.z) < e, true)
    @Expect(abs(Float64(1.0) / (cv3.x * cv3.x) - (Float64(1.0) + tv3.x * tv3.x)) < e, true)
    @Expect(abs(Float64(1.0) / (cv3.y * cv3.y) - (Float64(1.0) + tv3.y * tv3.y)) < e, true)
    @Expect(abs(Float64(1.0) / (cv3.z * cv3.z) - (Float64(1.0) + tv3.z * tv3.z)) < e, true)

    let v4 = Vec4<Float64, Defaultp>(Float64(0.0), p6, p4, p3)
    let sv4 = sin(v4); let cv4 = cos(v4); let tv4 = tan(v4)
    let sc4 = sv4 * sv4 + cv4 * cv4
    @Expect(abs(sc4.x - Float64(1.0)) < e, true)
    @Expect(abs(sc4.y - Float64(1.0)) < e, true)
    @Expect(abs(sc4.z - Float64(1.0)) < e, true)
    @Expect(abs(sc4.w - Float64(1.0)) < e, true)
    @Expect(abs(sv4.x - tv4.x * cv4.x) < e, true)
    @Expect(abs(sv4.y - tv4.y * cv4.y) < e, true)
    @Expect(abs(sv4.z - tv4.z * cv4.z) < e, true)
    @Expect(abs(sv4.w - tv4.w * cv4.w) < e, true)
    @Expect(abs(Float64(1.0) / (cv4.x * cv4.x) - (Float64(1.0) + tv4.x * tv4.x)) < e, true)
    @Expect(abs(Float64(1.0) / (cv4.y * cv4.y) - (Float64(1.0) + tv4.y * tv4.y)) < e, true)
    @Expect(abs(Float64(1.0) / (cv4.z * cv4.z) - (Float64(1.0) + tv4.z * tv4.z)) < e, true)
    @Expect(abs(Float64(1.0) / (cv4.w * cv4.w) - (Float64(1.0) + tv4.w * tv4.w)) < e, true)
}

@Test
func testIdentitySin2Cos2Float32(): Unit {
    let e = Float32(1e-6)
    let p6 = pi<Float32>() / Float32(6.0)
    let p4 = pi<Float32>() / Float32(4.0)
    let p3 = pi<Float32>() / Float32(3.0)
    let p2 = pi<Float32>() / Float32(2.0)
    let np4 = -pi<Float32>() / Float32(4.0)

    let s0 = sin(Float32(0.0)); let c0 = cos(Float32(0.0)); let t0 = tan(Float32(0.0))
    @Expect(abs(s0 * s0 + c0 * c0 - Float32(1.0)) < e, true)
    @Expect(abs(s0 - t0 * c0) < e, true)
    @Expect(abs(Float32(1.0) / (c0 * c0) - (Float32(1.0) + t0 * t0)) < e, true)

    let s1 = sin(p6); let c1 = cos(p6); let t1 = tan(p6)
    @Expect(abs(s1 * s1 + c1 * c1 - Float32(1.0)) < e, true)
    @Expect(abs(s1 - t1 * c1) < e, true)
    @Expect(abs(Float32(1.0) / (c1 * c1) - (Float32(1.0) + t1 * t1)) < e, true)

    let s2 = sin(p4); let c2 = cos(p4); let t2 = tan(p4)
    @Expect(abs(s2 * s2 + c2 * c2 - Float32(1.0)) < e, true)
    @Expect(abs(s2 - t2 * c2) < e, true)
    @Expect(abs(Float32(1.0) / (c2 * c2) - (Float32(1.0) + t2 * t2)) < e, true)

    let s3 = sin(p3); let c3 = cos(p3); let t3 = tan(p3)
    @Expect(abs(s3 * s3 + c3 * c3 - Float32(1.0)) < e, true)
    @Expect(abs(s3 - t3 * c3) < e, true)
    @Expect(abs(Float32(1.0) / (c3 * c3) - (Float32(1.0) + t3 * t3)) < e, true)

    let s4 = sin(p2); let c4 = cos(p2); let t4 = tan(p2)
    @Expect(abs(s4 * s4 + c4 * c4 - Float32(1.0)) < e, true)

    let s5 = sin(np4); let c5 = cos(np4); let t5 = tan(np4)
    @Expect(abs(s5 * s5 + c5 * c5 - Float32(1.0)) < e, true)
    @Expect(abs(s5 - t5 * c5) < e, true)
    @Expect(abs(Float32(1.0) / (c5 * c5) - (Float32(1.0) + t5 * t5)) < e, true)

    let v1 = Vec1<Float32, Defaultp>(p6)
    let sv1 = sin(v1); let cv1 = cos(v1); let tv1 = tan(v1)
    @Expect(abs(sv1.x * sv1.x + cv1.x * cv1.x - Float32(1.0)) < e, true)
    @Expect(abs(sv1.x - tv1.x * cv1.x) < e, true)
    @Expect(abs(Float32(1.0) / (cv1.x * cv1.x) - (Float32(1.0) + tv1.x * tv1.x)) < e, true)

    let v2 = Vec2<Float32, Defaultp>(Float32(0.0), p6)
    let sv2 = sin(v2); let cv2 = cos(v2); let tv2 = tan(v2)
    let sc2 = sv2 * sv2 + cv2 * cv2
    @Expect(abs(sc2.x - Float32(1.0)) < e, true)
    @Expect(abs(sc2.y - Float32(1.0)) < e, true)
    @Expect(abs(sv2.x - tv2.x * cv2.x) < e, true)
    @Expect(abs(sv2.y - tv2.y * cv2.y) < e, true)
    @Expect(abs(Float32(1.0) / (cv2.x * cv2.x) - (Float32(1.0) + tv2.x * tv2.x)) < e, true)
    @Expect(abs(Float32(1.0) / (cv2.y * cv2.y) - (Float32(1.0) + tv2.y * tv2.y)) < e, true)

    let v3 = Vec3<Float32, Defaultp>(Float32(0.0), p6, p4)
    let sv3 = sin(v3); let cv3 = cos(v3); let tv3 = tan(v3)
    let sc3 = sv3 * sv3 + cv3 * cv3
    @Expect(abs(sc3.x - Float32(1.0)) < e, true)
    @Expect(abs(sc3.y - Float32(1.0)) < e, true)
    @Expect(abs(sc3.z - Float32(1.0)) < e, true)
    @Expect(abs(sv3.x - tv3.x * cv3.x) < e, true)
    @Expect(abs(sv3.y - tv3.y * cv3.y) < e, true)
    @Expect(abs(sv3.z - tv3.z * cv3.z) < e, true)
    @Expect(abs(Float32(1.0) / (cv3.x * cv3.x) - (Float32(1.0) + tv3.x * tv3.x)) < e, true)
    @Expect(abs(Float32(1.0) / (cv3.y * cv3.y) - (Float32(1.0) + tv3.y * tv3.y)) < e, true)
    @Expect(abs(Float32(1.0) / (cv3.z * cv3.z) - (Float32(1.0) + tv3.z * tv3.z)) < e, true)

    let v4 = Vec4<Float32, Defaultp>(Float32(0.0), p6, p4, p3)
    let sv4 = sin(v4); let cv4 = cos(v4); let tv4 = tan(v4)
    let sc4 = sv4 * sv4 + cv4 * cv4
    @Expect(abs(sc4.x - Float32(1.0)) < e, true)
    @Expect(abs(sc4.y - Float32(1.0)) < e, true)
    @Expect(abs(sc4.z - Float32(1.0)) < e, true)
    @Expect(abs(sc4.w - Float32(1.0)) < e, true)
    @Expect(abs(sv4.x - tv4.x * cv4.x) < e, true)
    @Expect(abs(sv4.y - tv4.y * cv4.y) < e, true)
    @Expect(abs(sv4.z - tv4.z * cv4.z) < e, true)
    @Expect(abs(sv4.w - tv4.w * cv4.w) < e, true)
    @Expect(abs(Float32(1.0) / (cv4.x * cv4.x) - (Float32(1.0) + tv4.x * tv4.x)) < e, true)
    @Expect(abs(Float32(1.0) / (cv4.y * cv4.y) - (Float32(1.0) + tv4.y * tv4.y)) < e, true)
    @Expect(abs(Float32(1.0) / (cv4.z * cv4.z) - (Float32(1.0) + tv4.z * tv4.z)) < e, true)
    @Expect(abs(Float32(1.0) / (cv4.w * cv4.w) - (Float32(1.0) + tv4.w * tv4.w)) < e, true)
}

@Test
func testIdentitySin2Cos2Float16(): Unit {
    let e = Float16(1e-3)
    let p6 = pi<Float16>() / Float16(6.0)
    let p4 = pi<Float16>() / Float16(4.0)
    let p3 = pi<Float16>() / Float16(3.0)
    let p2 = pi<Float16>() / Float16(2.0)
    let np4 = -pi<Float16>() / Float16(4.0)

    let s0 = sin(Float16(0.0)); let c0 = cos(Float16(0.0)); let t0 = tan(Float16(0.0))
    @Expect(abs(s0 * s0 + c0 * c0 - Float16(1.0)) < e, true)
    @Expect(abs(s0 - t0 * c0) < e, true)
    @Expect(abs(Float16(1.0) / (c0 * c0) - (Float16(1.0) + t0 * t0)) < e, true)

    let s1 = sin(p6); let c1 = cos(p6); let t1 = tan(p6)
    @Expect(abs(s1 * s1 + c1 * c1 - Float16(1.0)) < e, true)
    @Expect(abs(s1 - t1 * c1) < e, true)
    @Expect(abs(Float16(1.0) / (c1 * c1) - (Float16(1.0) + t1 * t1)) < e, true)

    let s2 = sin(p4); let c2 = cos(p4); let t2 = tan(p4)
    @Expect(abs(s2 * s2 + c2 * c2 - Float16(1.0)) < e, true)
    @Expect(abs(s2 - t2 * c2) < e, true)
    @Expect(abs(Float16(1.0) / (c2 * c2) - (Float16(1.0) + t2 * t2)) < e, true)

    let s3 = sin(p3); let c3 = cos(p3); let t3 = tan(p3)
    @Expect(abs(s3 * s3 + c3 * c3 - Float16(1.0)) < e, true)
    @Expect(abs(s3 - t3 * c3) < e, true)
    @Expect(abs(Float16(1.0) / (c3 * c3) - (Float16(1.0) + t3 * t3)) < e, true)

    let s4 = sin(p2); let c4 = cos(p2); let t4 = tan(p2)
    @Expect(abs(s4 * s4 + c4 * c4 - Float16(1.0)) < e, true)

    let s5 = sin(np4); let c5 = cos(np4); let t5 = tan(np4)
    @Expect(abs(s5 * s5 + c5 * c5 - Float16(1.0)) < e, true)
    @Expect(abs(s5 - t5 * c5) < e, true)
    @Expect(abs(Float16(1.0) / (c5 * c5) - (Float16(1.0) + t5 * t5)) < e, true)

    let v1 = Vec1<Float16, Defaultp>(p6)
    let sv1 = sin(v1); let cv1 = cos(v1); let tv1 = tan(v1)
    @Expect(abs(sv1.x * sv1.x + cv1.x * cv1.x - Float16(1.0)) < e, true)
    @Expect(abs(sv1.x - tv1.x * cv1.x) < e, true)
    @Expect(abs(Float16(1.0) / (cv1.x * cv1.x) - (Float16(1.0) + tv1.x * tv1.x)) < e, true)

    let v2 = Vec2<Float16, Defaultp>(Float16(0.0), p6)
    let sv2 = sin(v2); let cv2 = cos(v2); let tv2 = tan(v2)
    let sc2 = sv2 * sv2 + cv2 * cv2
    @Expect(abs(sc2.x - Float16(1.0)) < e, true)
    @Expect(abs(sc2.y - Float16(1.0)) < e, true)
    @Expect(abs(sv2.x - tv2.x * cv2.x) < e, true)
    @Expect(abs(sv2.y - tv2.y * cv2.y) < e, true)
    @Expect(abs(Float16(1.0) / (cv2.x * cv2.x) - (Float16(1.0) + tv2.x * tv2.x)) < e, true)
    @Expect(abs(Float16(1.0) / (cv2.y * cv2.y) - (Float16(1.0) + tv2.y * tv2.y)) < e, true)

    let v3 = Vec3<Float16, Defaultp>(Float16(0.0), p6, p4)
    let sv3 = sin(v3); let cv3 = cos(v3); let tv3 = tan(v3)
    let sc3 = sv3 * sv3 + cv3 * cv3
    @Expect(abs(sc3.x - Float16(1.0)) < e, true)
    @Expect(abs(sc3.y - Float16(1.0)) < e, true)
    @Expect(abs(sc3.z - Float16(1.0)) < e, true)
    @Expect(abs(sv3.x - tv3.x * cv3.x) < e, true)
    @Expect(abs(sv3.y - tv3.y * cv3.y) < e, true)
    @Expect(abs(sv3.z - tv3.z * cv3.z) < e, true)
    @Expect(abs(Float16(1.0) / (cv3.x * cv3.x) - (Float16(1.0) + tv3.x * tv3.x)) < e, true)
    @Expect(abs(Float16(1.0) / (cv3.y * cv3.y) - (Float16(1.0) + tv3.y * tv3.y)) < e, true)
    @Expect(abs(Float16(1.0) / (cv3.z * cv3.z) - (Float16(1.0) + tv3.z * tv3.z)) < e, true)

    let v4 = Vec4<Float16, Defaultp>(Float16(0.0), p6, p4, p3)
    let sv4 = sin(v4); let cv4 = cos(v4); let tv4 = tan(v4)
    let sc4 = sv4 * sv4 + cv4 * cv4
    @Expect(abs(sc4.x - Float16(1.0)) < e, true)
    @Expect(abs(sc4.y - Float16(1.0)) < e, true)
    @Expect(abs(sc4.z - Float16(1.0)) < e, true)
    @Expect(abs(sc4.w - Float16(1.0)) < e, true)
    @Expect(abs(sv4.x - tv4.x * cv4.x) < e, true)
    @Expect(abs(sv4.y - tv4.y * cv4.y) < e, true)
    @Expect(abs(sv4.z - tv4.z * cv4.z) < e, true)
    @Expect(abs(sv4.w - tv4.w * cv4.w) < e, true)
    @Expect(abs(Float16(1.0) / (cv4.x * cv4.x) - (Float16(1.0) + tv4.x * tv4.x)) < e, true)
    @Expect(abs(Float16(1.0) / (cv4.y * cv4.y) - (Float16(1.0) + tv4.y * tv4.y)) < e, true)
    @Expect(abs(Float16(1.0) / (cv4.z * cv4.z) - (Float16(1.0) + tv4.z * tv4.z)) < e, true)
    @Expect(abs(Float16(1.0) / (cv4.w * cv4.w) - (Float16(1.0) + tv4.w * tv4.w)) < e, true)
}
