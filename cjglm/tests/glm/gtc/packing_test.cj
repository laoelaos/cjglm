package glm.gtc
import glm.detail.{ Vec2, Vec3, Vec4, Defaultp }
import std.unittest.*
import std.unittest.testmacro.*

@Test
func testPackUnorm4x8Roundtrip(): Unit {
    let v = Vec4<Float32, Defaultp>(Float32(0.0), Float32(0.5), Float32(1.0), Float32(0.3))
    let packed = packUnorm4x8(v)
    let unpacked = unpackUnorm4x8<Defaultp>(packed)
    let eps = Float32(1.0) / Float32(255.0)
    @Expect(abs(unpacked.x - Float32(0.0)) < eps, true)
    @Expect(abs(unpacked.y - Float32(0.5)) < eps, true)
    @Expect(abs(unpacked.z - Float32(1.0)) < eps, true)
    @Expect(abs(unpacked.w - Float32(0.3)) < eps, true)
}

@Test
func testPackUnorm4x8Boundary(): Unit {
    let v0 = Vec4<Float32, Defaultp>(Float32(0.0), Float32(0.0), Float32(0.0), Float32(0.0))
    let packed0 = packUnorm4x8(v0)
    let unpacked0 = unpackUnorm4x8<Defaultp>(packed0)
    @Expect(unpacked0.x, Float32(0.0))
    @Expect(unpacked0.y, Float32(0.0))
    @Expect(unpacked0.z, Float32(0.0))
    @Expect(unpacked0.w, Float32(0.0))

    let v1 = Vec4<Float32, Defaultp>(Float32(1.0), Float32(1.0), Float32(1.0), Float32(1.0))
    let packed1 = packUnorm4x8(v1)
    let unpacked1 = unpackUnorm4x8<Defaultp>(packed1)
    @Expect(unpacked1.x, Float32(1.0))
    @Expect(unpacked1.y, Float32(1.0))
    @Expect(unpacked1.z, Float32(1.0))
    @Expect(unpacked1.w, Float32(1.0))
}

@Test
func testPackSnorm4x8Roundtrip(): Unit {
    let v = Vec4<Float32, Defaultp>(Float32(-1.0), Float32(-0.5), Float32(0.0), Float32(0.7))
    let packed = packSnorm4x8(v)
    let unpacked = unpackSnorm4x8<Defaultp>(packed)
    let eps = Float32(1.0) / Float32(127.0)
    @Expect(abs(unpacked.x - Float32(-1.0)) < eps, true)
    @Expect(abs(unpacked.y - Float32(-0.5)) < eps, true)
    @Expect(abs(unpacked.z - Float32(0.0)) < eps, true)
    @Expect(abs(unpacked.w - Float32(0.7)) < eps, true)
}

@Test
func testPackSnorm4x8Boundary(): Unit {
    let v1 = Vec4<Float32, Defaultp>(Float32(1.0), Float32(1.0), Float32(1.0), Float32(1.0))
    let packed1 = packSnorm4x8(v1)
    let unpacked1 = unpackSnorm4x8<Defaultp>(packed1)
    @Expect(unpacked1.x, Float32(1.0))
    @Expect(unpacked1.y, Float32(1.0))
    @Expect(unpacked1.z, Float32(1.0))
    @Expect(unpacked1.w, Float32(1.0))

    let vn1 = Vec4<Float32, Defaultp>(Float32(-1.0), Float32(-1.0), Float32(-1.0), Float32(-1.0))
    let packedn1 = packSnorm4x8(vn1)
    let unpackedn1 = unpackSnorm4x8<Defaultp>(packedn1)
    @Expect(unpackedn1.x, Float32(-1.0))
    @Expect(unpackedn1.y, Float32(-1.0))
    @Expect(unpackedn1.z, Float32(-1.0))
    @Expect(unpackedn1.w, Float32(-1.0))
}

@Test
func testPackHalf1x16Roundtrip(): Unit {
    let vals = [Float32(0.0), Float32(1.0), Float32(-1.0), Float32(0.5), Float32(-0.5)]
    for (v in vals) {
        let packed = packHalf1x16(v)
        let unpacked = unpackHalf1x16(packed)
        let eps = Float32(0.001)
        @Expect(abs(unpacked - v) < eps, true)
    }
}

@Test
func testPackDouble2x32Roundtrip(): Unit {
    let v = Vec2<UInt32, Defaultp>(UInt32(0x12345678), UInt32(0x9ABCDEF0))
    let packed = packDouble2x32(v)
    let unpacked = unpackDouble2x32<Defaultp>(packed)
    @Expect(unpacked.x, v.x)
    @Expect(unpacked.y, v.y)
}

@Test
func testPackUnorm1x8Roundtrip(): Unit {
    let vals = [Float32(0.0), Float32(0.5), Float32(1.0)]
    let eps = Float32(1.0) / Float32(255.0)
    for (v in vals) {
        let packed = packUnorm1x8(v)
        let unpacked = unpackUnorm1x8(packed)
        @Expect(abs(unpacked - v) < eps, true)
    }
}

@Test
func testPackUnorm1x8Boundary(): Unit {
    let packed0 = packUnorm1x8(Float32(0.0))
    let unpacked0 = unpackUnorm1x8(packed0)
    @Expect(unpacked0, Float32(0.0))

    let packed1 = packUnorm1x8(Float32(1.0))
    let unpacked1 = unpackUnorm1x8(packed1)
    @Expect(unpacked1, Float32(1.0))
}

@Test
func testPackUnorm2x8Roundtrip(): Unit {
    let v = Vec2<Float32, Defaultp>(Float32(0.0), Float32(0.5))
    let packed = packUnorm2x8(v)
    let unpacked = unpackUnorm2x8<Defaultp>(packed)
    let eps = Float32(1.0) / Float32(255.0)
    @Expect(abs(unpacked.x - Float32(0.0)) < eps, true)
    @Expect(abs(unpacked.y - Float32(0.5)) < eps, true)
}

@Test
func testPackUnorm2x8Boundary(): Unit {
    let v0 = Vec2<Float32, Defaultp>(Float32(0.0), Float32(0.0))
    let packed0 = packUnorm2x8(v0)
    let unpacked0 = unpackUnorm2x8<Defaultp>(packed0)
    @Expect(unpacked0.x, Float32(0.0))
    @Expect(unpacked0.y, Float32(0.0))

    let v1 = Vec2<Float32, Defaultp>(Float32(1.0), Float32(1.0))
    let packed1 = packUnorm2x8(v1)
    let unpacked1 = unpackUnorm2x8<Defaultp>(packed1)
    @Expect(unpacked1.x, Float32(1.0))
    @Expect(unpacked1.y, Float32(1.0))
}

@Test
func testPackUnorm1x16Roundtrip(): Unit {
    let vals = [Float32(0.0), Float32(0.5), Float32(1.0)]
    let eps = Float32(1.0) / Float32(65535.0)
    for (v in vals) {
        let packed = packUnorm1x16(v)
        let unpacked = unpackUnorm1x16(packed)
        @Expect(abs(unpacked - v) < eps, true)
    }
}

@Test
func testPackUnorm1x16Boundary(): Unit {
    let packed0 = packUnorm1x16(Float32(0.0))
    let unpacked0 = unpackUnorm1x16(packed0)
    @Expect(unpacked0, Float32(0.0))

    let packed1 = packUnorm1x16(Float32(1.0))
    let unpacked1 = unpackUnorm1x16(packed1)
    @Expect(unpacked1, Float32(1.0))
}

@Test
func testPackUnorm2x16Roundtrip(): Unit {
    let v = Vec2<Float32, Defaultp>(Float32(0.0), Float32(0.5))
    let packed = packUnorm2x16(v)
    let unpacked = unpackUnorm2x16<Defaultp>(packed)
    let eps = Float32(1.0) / Float32(65535.0)
    @Expect(abs(unpacked.x - Float32(0.0)) < eps, true)
    @Expect(abs(unpacked.y - Float32(0.5)) < eps, true)
}

@Test
func testPackUnorm2x16Boundary(): Unit {
    let v0 = Vec2<Float32, Defaultp>(Float32(0.0), Float32(0.0))
    let packed0 = packUnorm2x16(v0)
    let unpacked0 = unpackUnorm2x16<Defaultp>(packed0)
    @Expect(unpacked0.x, Float32(0.0))
    @Expect(unpacked0.y, Float32(0.0))

    let v1 = Vec2<Float32, Defaultp>(Float32(1.0), Float32(1.0))
    let packed1 = packUnorm2x16(v1)
    let unpacked1 = unpackUnorm2x16<Defaultp>(packed1)
    @Expect(unpacked1.x, Float32(1.0))
    @Expect(unpacked1.y, Float32(1.0))
}

@Test
func testPackUnorm4x16Roundtrip(): Unit {
    let v = Vec4<Float32, Defaultp>(Float32(0.0), Float32(0.5), Float32(1.0), Float32(0.3))
    let packed = packUnorm4x16(v)
    let unpacked = unpackUnorm4x16<Defaultp>(packed)
    let eps = Float32(1.0) / Float32(65535.0)
    @Expect(abs(unpacked.x - Float32(0.0)) < eps, true)
    @Expect(abs(unpacked.y - Float32(0.5)) < eps, true)
    @Expect(abs(unpacked.z - Float32(1.0)) < eps, true)
    @Expect(abs(unpacked.w - Float32(0.3)) < eps, true)
}

@Test
func testPackUnorm4x16Boundary(): Unit {
    let v0 = Vec4<Float32, Defaultp>(Float32(0.0), Float32(0.0), Float32(0.0), Float32(0.0))
    let packed0 = packUnorm4x16(v0)
    let unpacked0 = unpackUnorm4x16<Defaultp>(packed0)
    @Expect(unpacked0.x, Float32(0.0))
    @Expect(unpacked0.y, Float32(0.0))
    @Expect(unpacked0.z, Float32(0.0))
    @Expect(unpacked0.w, Float32(0.0))

    let v1 = Vec4<Float32, Defaultp>(Float32(1.0), Float32(1.0), Float32(1.0), Float32(1.0))
    let packed1 = packUnorm4x16(v1)
    let unpacked1 = unpackUnorm4x16<Defaultp>(packed1)
    @Expect(unpacked1.x, Float32(1.0))
    @Expect(unpacked1.y, Float32(1.0))
    @Expect(unpacked1.z, Float32(1.0))
    @Expect(unpacked1.w, Float32(1.0))
}

@Test
func testPackSnorm1x8Roundtrip(): Unit {
    let vals = [Float32(-1.0), Float32(-0.5), Float32(0.0), Float32(0.7)]
    let eps = Float32(1.0) / Float32(127.0)
    for (v in vals) {
        let packed = packSnorm1x8(v)
        let unpacked = unpackSnorm1x8(packed)
        @Expect(abs(unpacked - v) < eps, true)
    }
}

@Test
func testPackSnorm1x8Boundary(): Unit {
    let packed1 = packSnorm1x8(Float32(1.0))
    let unpacked1 = unpackSnorm1x8(packed1)
    @Expect(unpacked1, Float32(1.0))

    let packedn1 = packSnorm1x8(Float32(-1.0))
    let unpackedn1 = unpackSnorm1x8(packedn1)
    @Expect(unpackedn1, Float32(-1.0))
}

@Test
func testPackSnorm2x8Roundtrip(): Unit {
    let v = Vec2<Float32, Defaultp>(Float32(-1.0), Float32(0.5))
    let packed = packSnorm2x8(v)
    let unpacked = unpackSnorm2x8<Defaultp>(packed)
    let eps = Float32(1.0) / Float32(127.0)
    @Expect(abs(unpacked.x - Float32(-1.0)) < eps, true)
    @Expect(abs(unpacked.y - Float32(0.5)) < eps, true)
}

@Test
func testPackSnorm2x8Boundary(): Unit {
    let v1 = Vec2<Float32, Defaultp>(Float32(1.0), Float32(1.0))
    let packed1 = packSnorm2x8(v1)
    let unpacked1 = unpackSnorm2x8<Defaultp>(packed1)
    @Expect(unpacked1.x, Float32(1.0))
    @Expect(unpacked1.y, Float32(1.0))

    let vn1 = Vec2<Float32, Defaultp>(Float32(-1.0), Float32(-1.0))
    let packedn1 = packSnorm2x8(vn1)
    let unpackedn1 = unpackSnorm2x8<Defaultp>(packedn1)
    @Expect(unpackedn1.x, Float32(-1.0))
    @Expect(unpackedn1.y, Float32(-1.0))
}

@Test
func testPackSnorm1x16Roundtrip(): Unit {
    let vals = [Float32(-1.0), Float32(-0.5), Float32(0.0), Float32(0.7)]
    let eps = Float32(1.0) / Float32(32767.0)
    for (v in vals) {
        let packed = packSnorm1x16(v)
        let unpacked = unpackSnorm1x16(packed)
        @Expect(abs(unpacked - v) < eps, true)
    }
}

@Test
func testPackSnorm1x16Boundary(): Unit {
    let packed1 = packSnorm1x16(Float32(1.0))
    let unpacked1 = unpackSnorm1x16(packed1)
    @Expect(unpacked1, Float32(1.0))

    let packedn1 = packSnorm1x16(Float32(-1.0))
    let unpackedn1 = unpackSnorm1x16(packedn1)
    @Expect(unpackedn1, Float32(-1.0))
}

@Test
func testPackSnorm2x16Roundtrip(): Unit {
    let v = Vec2<Float32, Defaultp>(Float32(-1.0), Float32(0.5))
    let packed = packSnorm2x16(v)
    let unpacked = unpackSnorm2x16<Defaultp>(packed)
    let eps = Float32(1.0) / Float32(32767.0)
    @Expect(abs(unpacked.x - Float32(-1.0)) < eps, true)
    @Expect(abs(unpacked.y - Float32(0.5)) < eps, true)
}

@Test
func testPackSnorm2x16Boundary(): Unit {
    let v1 = Vec2<Float32, Defaultp>(Float32(1.0), Float32(1.0))
    let packed1 = packSnorm2x16(v1)
    let unpacked1 = unpackSnorm2x16<Defaultp>(packed1)
    @Expect(unpacked1.x, Float32(1.0))
    @Expect(unpacked1.y, Float32(1.0))

    let vn1 = Vec2<Float32, Defaultp>(Float32(-1.0), Float32(-1.0))
    let packedn1 = packSnorm2x16(vn1)
    let unpackedn1 = unpackSnorm2x16<Defaultp>(packedn1)
    @Expect(unpackedn1.x, Float32(-1.0))
    @Expect(unpackedn1.y, Float32(-1.0))
}

@Test
func testPackSnorm4x16Roundtrip(): Unit {
    let v = Vec4<Float32, Defaultp>(Float32(-1.0), Float32(-0.5), Float32(0.0), Float32(0.7))
    let packed = packSnorm4x16(v)
    let unpacked = unpackSnorm4x16<Defaultp>(packed)
    let eps = Float32(1.0) / Float32(32767.0)
    @Expect(abs(unpacked.x - Float32(-1.0)) < eps, true)
    @Expect(abs(unpacked.y - Float32(-0.5)) < eps, true)
    @Expect(abs(unpacked.z - Float32(0.0)) < eps, true)
    @Expect(abs(unpacked.w - Float32(0.7)) < eps, true)
}

@Test
func testPackSnorm4x16Boundary(): Unit {
    let v1 = Vec4<Float32, Defaultp>(Float32(1.0), Float32(1.0), Float32(1.0), Float32(1.0))
    let packed1 = packSnorm4x16(v1)
    let unpacked1 = unpackSnorm4x16<Defaultp>(packed1)
    @Expect(unpacked1.x, Float32(1.0))
    @Expect(unpacked1.y, Float32(1.0))
    @Expect(unpacked1.z, Float32(1.0))
    @Expect(unpacked1.w, Float32(1.0))

    let vn1 = Vec4<Float32, Defaultp>(Float32(-1.0), Float32(-1.0), Float32(-1.0), Float32(-1.0))
    let packedn1 = packSnorm4x16(vn1)
    let unpackedn1 = unpackSnorm4x16<Defaultp>(packedn1)
    @Expect(unpackedn1.x, Float32(-1.0))
    @Expect(unpackedn1.y, Float32(-1.0))
    @Expect(unpackedn1.z, Float32(-1.0))
    @Expect(unpackedn1.w, Float32(-1.0))
}

@Test
func testPackHalf2x16Roundtrip(): Unit {
    let vals = [Vec2<Float32, Defaultp>(Float32(0.0), Float32(1.0)), Vec2<Float32, Defaultp>(Float32(-0.5), Float32(-1.0))]
    let eps = Float32(0.001)
    for (v in vals) {
        let packed = packHalf2x16(v)
        let unpacked = unpackHalf2x16<Defaultp>(packed)
        @Expect(abs(unpacked.x - v.x) < eps, true)
        @Expect(abs(unpacked.y - v.y) < eps, true)
    }
}

@Test
func testPackHalf4x16Roundtrip(): Unit {
    let v = Vec4<Float32, Defaultp>(Float32(0.0), Float32(1.0), Float32(-1.0), Float32(0.5))
    let packed = packHalf4x16(v)
    let unpacked = unpackHalf4x16<Defaultp>(packed)
    let eps = Float32(0.001)
    @Expect(abs(unpacked.x - Float32(0.0)) < eps, true)
    @Expect(abs(unpacked.y - Float32(1.0)) < eps, true)
    @Expect(abs(unpacked.z - Float32(-1.0)) < eps, true)
    @Expect(abs(unpacked.w - Float32(0.5)) < eps, true)
}
