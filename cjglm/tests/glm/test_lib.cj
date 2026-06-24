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

// === Matrix type & function import tests (T9) ===

@Test
func testLibMat2x2Construct(): Unit {
    let m = Mat2x2<Float32, PackedHighp>(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))
    @Expect(m.c0.x, Float32(1.0))
    @Expect(m.c1.y, Float32(4.0))
}

@Test
func testLibMat4x4Construct(): Unit {
    let m = Mat4x4<Float32, PackedHighp>(Float32(1.0))
    @Expect(m.c0.x, Float32(1.0))
    @Expect(m.c3.w, Float32(1.0))
}

@Test
func testLibTransposeMat2x2(): Unit {
    let m = Mat2x2<Float32, PackedHighp>(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))
    let t = transpose(m)
    @Expect(t.c0.x, Float32(1.0))
    @Expect(t.c0.y, Float32(3.0))
    @Expect(t.c1.x, Float32(2.0))
    @Expect(t.c1.y, Float32(4.0))
}

@Test
func testLibTransposeMat4x4(): Unit {
    let m = Mat4x4<Float32, PackedHighp>(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0), Float32(7.0), Float32(8.0), Float32(9.0), Float32(10.0), Float32(11.0), Float32(12.0), Float32(13.0), Float32(14.0), Float32(15.0), Float32(16.0))
    let t = transpose(m)
    @Expect(t.c0.x, Float32(1.0))
    @Expect(t.c0.y, Float32(5.0))
    @Expect(t.c0.z, Float32(9.0))
    @Expect(t.c0.w, Float32(13.0))
    @Expect(t.c3.x, Float32(4.0))
    @Expect(t.c3.y, Float32(8.0))
    @Expect(t.c3.z, Float32(12.0))
    @Expect(t.c3.w, Float32(16.0))
}

@Test
func testLibMatrixCompMultMat2x2(): Unit {
    let a = Mat2x2<Int64, PackedHighp>(Int64(1), Int64(2), Int64(3), Int64(4))
    let b = Mat2x2<Int64, PackedHighp>(Int64(5), Int64(6), Int64(7), Int64(8))
    let r = matrixCompMult(a, b)
    @Expect(r.c0.x, Int64(5))
    @Expect(r.c0.y, Int64(12))
    @Expect(r.c1.x, Int64(21))
    @Expect(r.c1.y, Int64(32))
}

@Test
func testLibOuterProductVec2(): Unit {
    let c = Vec2<Int64, PackedHighp>(Int64(1), Int64(2))
    let r = Vec2<Int64, PackedHighp>(Int64(3), Int64(4))
    let m = outerProduct(c, r)
    @Expect(m.c0.x, Int64(3))
    @Expect(m.c0.y, Int64(6))
    @Expect(m.c1.x, Int64(4))
    @Expect(m.c1.y, Int64(8))
}
