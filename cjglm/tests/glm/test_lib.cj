package glm

import std.unittest.*
import std.unittest.testmacro.*

@Test
func testLibVec2Construct(): Unit {
    let v = Vec2<Float32, PackedHighp>(Float32(1.0), Float32(2.0))
    @Expect(v.x, Float32(1.0))
}

@Test
func testLibAddScalarVec(): Unit {
    let v = Vec2<Float32, PackedHighp>(Float32(1.0), Float32(2.0))
    let r = add(Float32(10.0), v)
    @Expect(r.x, Float32(11.0))
}

@Test
func testLibFromBoolVec(): Unit {
    let bv = Vec2<Bool, PackedHighp>(Bool(true), Bool(false))
    let r = fromBoolVec(bv, Float32(0.0), Float32(1.0))
    @Expect(r.x, Float32(1.0))
}

@Test
func testLibQualifierType(): Unit {
    let _q: Qualifier = PackedHighp()
    let _d: Defaultp = Defaultp()
    @Expect(true, true)
}

@Test
func testLibVec1Construct(): Unit {
    let v = Vec1<Float32, PackedHighp>(Float32(1.0))
    @Expect(v.x, Float32(1.0))
}

@Test
func testLibVec3Construct(): Unit {
    let v = Vec3<Float32, PackedHighp>(Float32(1.0), Float32(2.0), Float32(3.0))
    @Expect(v.x, Float32(1.0))
}

@Test
func testLibVec4Construct(): Unit {
    let v = Vec4<Float32, PackedHighp>(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))
    @Expect(v.x, Float32(1.0))
}

@Test
func testLibVec1Components(): Unit {
    let v = Vec1<Float32, PackedHighp>(Float32(1.0))
    @Expect(v.x, Float32(1.0))
}

@Test
func testLibVec3Components(): Unit {
    let v = Vec3<Float32, PackedHighp>(Float32(1.0), Float32(2.0), Float32(3.0))
    @Expect(v.x, Float32(1.0))
    @Expect(v.y, Float32(2.0))
    @Expect(v.z, Float32(3.0))
}

@Test
func testLibVec4Components(): Unit {
    let v = Vec4<Float32, PackedHighp>(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))
    @Expect(v.x, Float32(1.0))
    @Expect(v.y, Float32(2.0))
    @Expect(v.z, Float32(3.0))
    @Expect(v.w, Float32(4.0))
}

@Test
func testLibSubScalarVec(): Unit {
    let v = Vec2<Int64, PackedHighp>(Int64(1), Int64(2))
    let r = sub(Int64(10), v)
    @Expect(r.x, Int64(9))
}

@Test
func testLibMulScalarVec(): Unit {
    let v = Vec2<Int64, PackedHighp>(Int64(1), Int64(2))
    let r = mul(Int64(10), v)
    @Expect(r.x, Int64(10))
}

@Test
func testLibDivScalarVec(): Unit {
    let v = Vec2<Int64, PackedHighp>(Int64(1), Int64(2))
    let r = div(Int64(10), v)
    @Expect(r.x, Int64(10))
}

@Test
func testLibModScalarVec(): Unit {
    let v = Vec2<Int64, PackedHighp>(Int64(3), Int64(2))
    let r = mod(Int64(10), v)
    @Expect(r.x, Int64(1))
}
