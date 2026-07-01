package glm.detail

import std.math.{ isNaN, isInf }

// ── Scalar ──

@Test
func testPow(): Unit {
    @Expect(pow(Float64(2.0), Float64(3.0)), Float64(8.0))
    @Expect(pow(Float64(4.0), Float64(0.5)), Float64(2.0))
}

@Test
func testExp(): Unit {
    @Expect(exp(Float64(0.0)), Float64(1.0))
    @Expect(exp(Float64(1.0)), Float64(2.718281828459045))
}

@Test
func testLog(): Unit {
    @Expect(log(Float64(1.0)), Float64(0.0))
    @Expect(log(Float64(2.718281828459045)), Float64(1.0))
}

@Test
func testExp2(): Unit {
    @Expect(exp2(Float64(0.0)), Float64(1.0))
    @Expect(exp2(Float64(3.0)), Float64(8.0))
}

@Test
func testLog2(): Unit {
    @Expect(log2(Float64(1.0)), Float64(0.0))
    @Expect(log2(Float64(8.0)), Float64(3.0))
}

@Test
func testSqrt(): Unit {
    @Expect(sqrt(Float64(4.0)), Float64(2.0))
    @Expect(sqrt(Float64(0.0)), Float64(0.0))
}

@Test
func testInversesqrt(): Unit {
    @Expect(inversesqrt(Float64(4.0)), Float64(0.5))
}

@Test
func testInversesqrtZero(): Unit {
    let r = inversesqrt(Float64(0.0))
    @Expect(isInf(r), true)
}

@Test
func testSqrtFloat32(): Unit {
    @Expect(sqrt(Float32(4.0)), Float32(2.0))
}

@Test
func testExpFloat32(): Unit {
    @Expect(exp(Float32(0.0)), Float32(1.0))
}

@Test
func testLogFloat32(): Unit {
    @Expect(log(Float32(1.0)), Float32(0.0))
}

// ── Float16 ──

@Test
func testPowFloat16(): Unit {
    @Expect(pow(Float16(2.0), Float16(3.0)), Float16(8.0))
}

@Test
func testExpFloat16(): Unit {
    @Expect(exp(Float16(0.0)), Float16(1.0))
}

@Test
func testLogFloat16(): Unit {
    @Expect(log(Float16(1.0)), Float16(0.0))
}

@Test
func testExp2Float16(): Unit {
    @Expect(exp2(Float16(0.0)), Float16(1.0))
    @Expect(exp2(Float16(3.0)), Float16(8.0))
}

@Test
func testLog2Float16(): Unit {
    @Expect(log2(Float16(1.0)), Float16(0.0))
    @Expect(log2(Float16(8.0)), Float16(3.0))
}

@Test
func testSqrtFloat16(): Unit {
    @Expect(sqrt(Float16(4.0)), Float16(2.0))
}

@Test
func testInversesqrtFloat16(): Unit {
    @Expect(inversesqrt(Float16(4.0)), Float16(0.5))
}

// ── Vec ──

@Test
func testPowVec2(): Unit {
    let base = Vec2<Float64, Defaultp>(2.0, 4.0)
    let e = Vec2<Float64, Defaultp>(3.0, 0.5)
    let r = pow(base, e)
    @Expect(r.x, Float64(8.0))
    @Expect(r.y, Float64(2.0))
}

@Test
func testExpVec2(): Unit {
    let v = Vec2<Float64, Defaultp>(0.0, 1.0)
    let r = exp(v)
    @Expect(r.x, Float64(1.0))
    @Expect(r.y, Float64(2.718281828459045))
}

@Test
func testLogVec2(): Unit {
    let v = Vec2<Float64, Defaultp>(1.0, 2.718281828459045)
    let r = log(v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(1.0))
}

@Test
func testExp2Vec4(): Unit {
    let v = Vec4<Float64, Defaultp>(0.0, 1.0, 2.0, 3.0)
    let r = exp2(v)
    @Expect(r.x, Float64(1.0))
    @Expect(r.y, Float64(2.0))
    @Expect(r.z, Float64(4.0))
    @Expect(r.w, Float64(8.0))
}

@Test
func testLog2Vec2(): Unit {
    let v = Vec2<Float64, Defaultp>(1.0, 8.0)
    let r = log2(v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(3.0))
}

@Test
func testSqrtVec4(): Unit {
    let v = Vec4<Float64, Defaultp>(4.0, 0.0, 1.0, 9.0)
    let r = sqrt(v)
    @Expect(r.x, Float64(2.0))
    @Expect(r.y, Float64(0.0))
    @Expect(r.z, Float64(1.0))
    @Expect(r.w, Float64(3.0))
}

@Test
func testInversesqrtVec2(): Unit {
    let v = Vec2<Float64, Defaultp>(4.0, 1.0)
    let r = inversesqrt(v)
    @Expect(r.x, Float64(0.5))
    @Expect(r.y, Float64(1.0))
}

// ── Vec1 ──

@Test
func testPowVec1(): Unit {
    let base = Vec1<Float64, Defaultp>(2.0)
    let e = Vec1<Float64, Defaultp>(3.0)
    let r = pow(base, e)
    @Expect(r.x, Float64(8.0))
}

@Test
func testExpVec1(): Unit {
    let v = Vec1<Float64, Defaultp>(0.0)
    let r = exp(v)
    @Expect(r.x, Float64(1.0))
}

@Test
func testLogVec1(): Unit {
    let v = Vec1<Float64, Defaultp>(1.0)
    let r = log(v)
    @Expect(r.x, Float64(0.0))
}

@Test
func testExp2Vec1(): Unit {
    let v = Vec1<Float64, Defaultp>(3.0)
    let r = exp2(v)
    @Expect(r.x, Float64(8.0))
}

@Test
func testLog2Vec1(): Unit {
    let v = Vec1<Float64, Defaultp>(8.0)
    let r = log2(v)
    @Expect(r.x, Float64(3.0))
}

@Test
func testSqrtVec1(): Unit {
    let v = Vec1<Float64, Defaultp>(4.0)
    let r = sqrt(v)
    @Expect(r.x, Float64(2.0))
}

@Test
func testInversesqrtVec1(): Unit {
    let v = Vec1<Float64, Defaultp>(4.0)
    let r = inversesqrt(v)
    @Expect(r.x, Float64(0.5))
}

// ── Edge Cases ──

@Test
func testSqrtLogEdgeCases(): Unit {
    @Expect(isNaN(sqrt(Float64(-1.0))), true)
    @Expect(isInf(log(Float64(0.0))), true)
    @Expect(isNaN(log(Float64(-1.0))), true)
}
