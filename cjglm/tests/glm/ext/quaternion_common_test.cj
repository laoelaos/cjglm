package glm.ext
import glm.detail.{ Quat, Defaultp }
import std.unittest.*
import std.unittest.testmacro.*

@Test
func testConjugate(): Unit {
    let q = Quat<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let c = conjugate(q)
    @Expect(c.x, -1.0)
    @Expect(c.y, -2.0)
    @Expect(c.z, -3.0)
    @Expect(c.w, 4.0)
}

@Test
func testInverse(): Unit {
    let q = Quat<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let inv = inverse(q)
    let result = q * inv
    @Expect(result.w, 1.0)
    @Expect(result.x, 0.0)
    @Expect(result.y, 0.0)
    @Expect(result.z, 0.0)
}

@Test
func testLerp(): Unit {
    let x = Quat<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let y = Quat<Float64, Defaultp>(5.0, 6.0, 7.0, 8.0)
    let r0 = lerp(x, y, 0.0)
    @Expect(r0.x, 1.0)
    @Expect(r0.y, 2.0)
    @Expect(r0.z, 3.0)
    @Expect(r0.w, 4.0)
    let r1 = lerp(x, y, 1.0)
    @Expect(r1.x, 5.0)
    @Expect(r1.y, 6.0)
    @Expect(r1.z, 7.0)
    @Expect(r1.w, 8.0)
    let r05 = lerp(x, y, 0.5)
    @Expect(r05.x, 3.0)
    @Expect(r05.y, 4.0)
    @Expect(r05.z, 5.0)
    @Expect(r05.w, 6.0)
}

@Test
func testIsnan(): Unit {
    let q = Quat<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let r = isnan(q)
    @Expect(r.x, false)
    @Expect(r.y, false)
    @Expect(r.z, false)
    @Expect(r.w, false)
}

@Test
func testIsinf(): Unit {
    let q = Quat<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let r = isinf(q)
    @Expect(r.x, false)
    @Expect(r.y, false)
    @Expect(r.z, false)
    @Expect(r.w, false)
}

@Test
func testInverseZero(): Unit {
    let q = Quat<Float64, Defaultp>(0.0, 0.0, 0.0, 0.0)
    let inv = inverse(q)
    @Expect(inv.x.isInf() || inv.x.isNaN(), true)
}

@Test
func testLerpAssertBelow(): Unit {
    let x = Quat<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let y = Quat<Float64, Defaultp>(5.0, 6.0, 7.0, 8.0)
    @ExpectThrows[Exception](lerp(x, y, -0.1))
}

@Test
func testLerpAssertAbove(): Unit {
    let x = Quat<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let y = Quat<Float64, Defaultp>(5.0, 6.0, 7.0, 8.0)
    @ExpectThrows[Exception](lerp(x, y, 1.1))
}

@Test
func testLerpFloat32(): Unit {
    let x = Quat<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32)
    let y = Quat<Float32, Defaultp>(5.0f32, 6.0f32, 7.0f32, 8.0f32)
    let r0 = lerp(x, y, 0.0f32)
    @Expect(r0.x, 1.0f32)
    @Expect(r0.y, 2.0f32)
    @Expect(r0.z, 3.0f32)
    @Expect(r0.w, 4.0f32)
    let r1 = lerp(x, y, 1.0f32)
    @Expect(r1.x, 5.0f32)
    @Expect(r1.y, 6.0f32)
    @Expect(r1.z, 7.0f32)
    @Expect(r1.w, 8.0f32)
    let r05 = lerp(x, y, 0.5f32)
    @Expect(r05.x, 3.0f32)
    @Expect(r05.y, 4.0f32)
    @Expect(r05.z, 5.0f32)
    @Expect(r05.w, 6.0f32)
}

@Test
func testLerpFloat16(): Unit {
    let x = Quat<Float16, Defaultp>(Float16(1.0), Float16(2.0), Float16(3.0), Float16(4.0))
    let y = Quat<Float16, Defaultp>(Float16(5.0), Float16(6.0), Float16(7.0), Float16(8.0))
    let r0 = lerp(x, y, Float16(0.0))
    @Expect(r0.x, Float16(1.0))
    @Expect(r0.y, Float16(2.0))
    @Expect(r0.z, Float16(3.0))
    @Expect(r0.w, Float16(4.0))
    let r1 = lerp(x, y, Float16(1.0))
    @Expect(r1.x, Float16(5.0))
    @Expect(r1.y, Float16(6.0))
    @Expect(r1.z, Float16(7.0))
    @Expect(r1.w, Float16(8.0))
    let r05 = lerp(x, y, Float16(0.5))
    @Expect(r05.x, Float16(3.0))
    @Expect(r05.y, Float16(4.0))
    @Expect(r05.z, Float16(5.0))
    @Expect(r05.w, Float16(6.0))
}

@Test
func testMix(): Unit {
    let x = Quat<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let y = Quat<Float64, Defaultp>(5.0, 6.0, 7.0, 8.0)
    let r = mix(x, y, 0.0)
    @Expect(r.x, 1.0)
    @Expect(r.y, 2.0)
    @Expect(r.z, 3.0)
    @Expect(r.w, 4.0)
    let r1 = mix(x, y, 1.0)
    @Expect(r1.x, 5.0)
    @Expect(r1.y, 6.0)
    @Expect(r1.z, 7.0)
    @Expect(r1.w, 8.0)
    let r05 = mix(x, y, 0.5)
    @Expect(r05.x, 3.0)
    @Expect(r05.y, 4.0)
    @Expect(r05.z, 5.0)
    @Expect(r05.w, 6.0)
}

@Test
func testMixFloat32(): Unit {
    let x = Quat<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32)
    let y = Quat<Float32, Defaultp>(5.0f32, 6.0f32, 7.0f32, 8.0f32)
    let r = mix(x, y, 0.5f32)
    @Expect(r.x, 3.0f32)
    @Expect(r.y, 4.0f32)
    @Expect(r.z, 5.0f32)
    @Expect(r.w, 6.0f32)
}

@Test
func testMixFloat16(): Unit {
    let x = Quat<Float16, Defaultp>(Float16(1.0), Float16(2.0), Float16(3.0), Float16(4.0))
    let y = Quat<Float16, Defaultp>(Float16(5.0), Float16(6.0), Float16(7.0), Float16(8.0))
    let r = mix(x, y, Float16(0.5))
    @Expect(r.x, Float16(3.0))
    @Expect(r.y, Float16(4.0))
    @Expect(r.z, Float16(5.0))
    @Expect(r.w, Float16(6.0))
}

@Test
func testSlerp(): Unit {
    let x = Quat<Float64, Defaultp>(1.0, 0.0, 0.0, 0.0)
    let y = Quat<Float64, Defaultp>(0.0, 1.0, 0.0, 0.0)
    let r = slerp(x, y, 0.0)
    @Expect(r.x, 1.0)
    let r1 = slerp(x, y, 1.0)
    @Expect(r1.y, 1.0)
}

@Test
func testSlerp4ArgsK(): Unit {
    let x = Quat<Float64, Defaultp>(1.0, 0.0, 0.0, 0.0)
    let y = Quat<Float64, Defaultp>(0.0, 1.0, 0.0, 0.0)
    let r = slerp(x, y, 0.0, 1)
    @Expect(r.x, 1.0)
    let r1 = slerp(x, y, 1.0, 1)
    @Expect(r1.y, 1.0)
}

@Test
func testSlerpShortestPath(): Unit {
    let x = Quat<Float64, Defaultp>(1.0, 0.0, 0.0, 0.0)
    let y = Quat<Float64, Defaultp>(-0.5, 0.5, 0.5, 0.5)
    let a = 0.25
    let r1 = slerp(x, y, a)
    let r2 = slerp(x, -y, a)
    @Expect((r1.w - r2.w).abs() < 1e-10, true)
    @Expect((r1.x - r2.x).abs() < 1e-10, true)
    @Expect((r1.y - r2.y).abs() < 1e-10, true)
    @Expect((r1.z - r2.z).abs() < 1e-10, true)
}

@Test
func testSlerp4ArgsKZero(): Unit {
    let x = Quat<Float64, Defaultp>(1.0, 0.0, 0.0, 0.0)
    let y = Quat<Float64, Defaultp>(0.0, 1.0, 0.0, 0.0)
    let r2 = slerp(x, y, 0.5)
    let r4 = slerp(x, y, 0.5, 0.0)
    @Expect((r2.w - r4.w).abs() < 1e-10, true)
    @Expect((r2.x - r4.x).abs() < 1e-10, true)
    @Expect((r2.y - r4.y).abs() < 1e-10, true)
    @Expect((r2.z - r4.z).abs() < 1e-10, true)
}

@Test
func testSlerp4ArgsShortestPath(): Unit {
    let x = Quat<Float64, Defaultp>(1.0, 0.0, 0.0, 0.0)
    let y = Quat<Float64, Defaultp>(-0.5, 0.5, 0.5, 0.5)
    let a = 0.25
    let r1 = slerp(x, y, a, 0.5)
    let r2 = slerp(x, -y, a, 0.5)
    @Expect((r1.w - r2.w).abs() < 1e-10, true)
    @Expect((r1.x - r2.x).abs() < 1e-10, true)
    @Expect((r1.y - r2.y).abs() < 1e-10, true)
    @Expect((r1.z - r2.z).abs() < 1e-10, true)
}

@Test
func testSlerpMidpoint(): Unit {
    let x = Quat<Float64, Defaultp>(1.0, 0.0, 0.0, 0.0)
    let y = Quat<Float64, Defaultp>(0.0, 1.0, 0.0, 0.0)
    let r = slerp(x, y, 0.5)
    @Expect((r.x - 0.70710678).abs() < 1e-6, true)
    @Expect((r.y - 0.70710678).abs() < 1e-6, true)
    @Expect(r.z.abs() < 1e-6, true)
    @Expect(r.w.abs() < 1e-6, true)
}

@Test
func testSlerpDegenerate(): Unit {
    let x = Quat<Float64, Defaultp>(1.0, 0.0, 0.0, 0.0)
    let y = Quat<Float64, Defaultp>(1.0, 0.0, 0.0, 0.0)
    let r = slerp(x, y, 0.5)
    @Expect(r.x, 1.0)
    @Expect(r.y, 0.0)
    @Expect(r.z, 0.0)
    @Expect(r.w, 0.0)
}

@Test
func testSlerpNegateBranch(): Unit {
    let x = Quat<Float64, Defaultp>(1.0, 0.0, 0.0, 0.0)
    let y = Quat<Float64, Defaultp>(-0.5, 0.5, 0.5, 0.5)
    let r1 = slerp(x, y, 0.5)
    let r2 = slerp(x, Quat<Float64, Defaultp>(0.5, -0.5, -0.5, -0.5), 0.5)
    @Expect((r1.x - r2.x).abs() < 1e-10, true)
    @Expect((r1.y - r2.y).abs() < 1e-10, true)
    @Expect((r1.z - r2.z).abs() < 1e-10, true)
    @Expect((r1.w - r2.w).abs() < 1e-10, true)
}

@Test
func testMixClampBelow(): Unit {
    let x = Quat<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let y = Quat<Float64, Defaultp>(5.0, 6.0, 7.0, 8.0)
    let r = mix(x, y, -0.5)
    @Expect(r.x, 1.0)
    @Expect(r.y, 2.0)
    @Expect(r.z, 3.0)
    @Expect(r.w, 4.0)
}

@Test
func testMixClampAbove(): Unit {
    let x = Quat<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let y = Quat<Float64, Defaultp>(5.0, 6.0, 7.0, 8.0)
    let r = mix(x, y, 1.5)
    @Expect(r.x, 5.0)
    @Expect(r.y, 6.0)
    @Expect(r.z, 7.0)
    @Expect(r.w, 8.0)
}
