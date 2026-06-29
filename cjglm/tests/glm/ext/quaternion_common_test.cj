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
func testMixStub(): Unit {
    let x = Quat<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let y = Quat<Float64, Defaultp>(5.0, 6.0, 7.0, 8.0)
    @ExpectThrows[Exception](mix(x, y, 0.5))
}

@Test
func testMixFloat32(): Unit {
    let x = Quat<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32)
    let y = Quat<Float32, Defaultp>(5.0f32, 6.0f32, 7.0f32, 8.0f32)
    @ExpectThrows[Exception](mix(x, y, 0.5f32))
}

@Test
func testMixFloat16(): Unit {
    let x = Quat<Float16, Defaultp>(Float16(1.0), Float16(2.0), Float16(3.0), Float16(4.0))
    let y = Quat<Float16, Defaultp>(Float16(5.0), Float16(6.0), Float16(7.0), Float16(8.0))
    @ExpectThrows[Exception](mix(x, y, Float16(0.5)))
}

@Test
func testSlerpStub(): Unit {
    let x = Quat<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let y = Quat<Float64, Defaultp>(5.0, 6.0, 7.0, 8.0)
    @ExpectThrows[Exception](slerp(x, y, 0.5))
}

@Test
func testSlerp4ArgsK0(): Unit {
    let x = Quat<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let y = Quat<Float64, Defaultp>(5.0, 6.0, 7.0, 8.0)
    @ExpectThrows[Exception](slerp(x, y, 0.5, 0))
}

@Test
func testSlerp4ArgsK1(): Unit {
    let x = Quat<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let y = Quat<Float64, Defaultp>(5.0, 6.0, 7.0, 8.0)
    @ExpectThrows[Exception](slerp(x, y, 0.5, 1))
}

@Test
func testSlerp4ArgsKMinus1(): Unit {
    let x = Quat<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let y = Quat<Float64, Defaultp>(5.0, 6.0, 7.0, 8.0)
    @ExpectThrows[Exception](slerp(x, y, 0.5, -1))
}
