package glm.detail

import std.unittest.*
import std.unittest.testmacro.*

@Test
func testFromBoolVec1(): Unit {
    let vb = Vec1<Bool, Defaultp>(true)
    let r = fromBoolVec(vb, Int64(0), Int64(1))
    @Expect(r.x, 1)
}

@Test
func testFromBoolVec1False(): Unit {
    let vb = Vec1<Bool, Defaultp>(false)
    let r = fromBoolVec(vb, Int64(0), Int64(1))
    @Expect(r.x, 0)
}

@Test
func testFromBoolVec2(): Unit {
    let vb = Vec2<Bool, Defaultp>(true, false)
    let r = fromBoolVec(vb, Int64(0), Int64(1))
    @Expect(r.x, 1)
    @Expect(r.y, 0)
}

@Test
func testFromBoolVec3(): Unit {
    let vb = Vec3<Bool, Defaultp>(true, false, true)
    let r = fromBoolVec(vb, Int64(0), Int64(1))
    @Expect(r.x, 1)
    @Expect(r.y, 0)
    @Expect(r.z, 1)
}

@Test
func testFromBoolVec4(): Unit {
    let vb = Vec4<Bool, Defaultp>(true, false, true, false)
    let r = fromBoolVec(vb, Int64(0), Int64(1))
    @Expect(r.x, 1)
    @Expect(r.y, 0)
    @Expect(r.z, 1)
    @Expect(r.w, 0)
}

@Test
func testFromBoolVecQ2Vec1(): Unit {
    let vb = Vec1<Bool, PackedHighp>(true)
    let r = fromBoolVecQ2<Int64, Defaultp, PackedHighp>(vb, Int64(0), Int64(1))
    @Expect(r.x, 1)
}

@Test
func testFromBoolVecQ2Vec2(): Unit {
    let vb = Vec2<Bool, PackedHighp>(true, false)
    let r = fromBoolVecQ2<Int64, Defaultp, PackedHighp>(vb, Int64(0), Int64(1))
    @Expect(r.x, 1)
    @Expect(r.y, 0)
}

@Test
func testFromBoolVecQ2Vec3(): Unit {
    let vb = Vec3<Bool, PackedHighp>(true, false, true)
    let r = fromBoolVecQ2<Int64, Defaultp, PackedHighp>(vb, Int64(0), Int64(1))
    @Expect(r.x, 1)
    @Expect(r.y, 0)
    @Expect(r.z, 1)
}

@Test
func testFromBoolVecQ2Vec4(): Unit {
    let vb = Vec4<Bool, PackedHighp>(true, false, true, false)
    let r = fromBoolVecQ2<Int64, Defaultp, PackedHighp>(vb, Int64(0), Int64(1))
    @Expect(r.x, 1)
    @Expect(r.y, 0)
    @Expect(r.z, 1)
    @Expect(r.w, 0)
}

@Test
func testFromBoolVec3AllFalse(): Unit {
    let vb = Vec3<Bool, Defaultp>(false, false, false)
    let r = fromBoolVec(vb, Int64(0), Int64(1))
    @Expect(r.x, 0)
    @Expect(r.y, 0)
    @Expect(r.z, 0)
}

@Test
func testFromBoolVec4AllFalse(): Unit {
    let vb = Vec4<Bool, Defaultp>(false, false, false, false)
    let r = fromBoolVec(vb, Int64(0), Int64(1))
    @Expect(r.x, 0)
    @Expect(r.y, 0)
    @Expect(r.z, 0)
    @Expect(r.w, 0)
}

@Test
func testFromBoolVecQ2Vec3AllFalse(): Unit {
    let vb = Vec3<Bool, PackedHighp>(false, false, false)
    let r = fromBoolVecQ2<Int64, Defaultp, PackedHighp>(vb, Int64(0), Int64(1))
    @Expect(r.x, 0)
    @Expect(r.y, 0)
    @Expect(r.z, 0)
}

@Test
func testFromBoolVecQ2Vec4AllFalse(): Unit {
    let vb = Vec4<Bool, PackedHighp>(false, false, false, false)
    let r = fromBoolVecQ2<Int64, Defaultp, PackedHighp>(vb, Int64(0), Int64(1))
    @Expect(r.x, 0)
    @Expect(r.y, 0)
    @Expect(r.z, 0)
    @Expect(r.w, 0)
}

@Test
func testFromBoolVecFloat32(): Unit {
    let vb = Vec2<Bool, Defaultp>(true, false)
    let r = fromBoolVec(vb, Float32(0.0), Float32(1.5))
    @Expect(r.x, Float32(1.5))
    @Expect(r.y, Float32(0.0))
}

@Test
func testFromBoolVecFloat64(): Unit {
    let vb = Vec3<Bool, Defaultp>(true, false, true)
    let r = fromBoolVec(vb, Float64(-1.0), Float64(2.5))
    @Expect(r.x, Float64(2.5))
    @Expect(r.y, Float64(-1.0))
    @Expect(r.z, Float64(2.5))
}

@Test
func testFromBoolVecInt32(): Unit {
    let vb = Vec4<Bool, Defaultp>(false, true, false, true)
    let r = fromBoolVec(vb, Int32(-3), Int32(7))
    @Expect(r.x, Int32(-3))
    @Expect(r.y, Int32(7))
    @Expect(r.z, Int32(-3))
    @Expect(r.w, Int32(7))
}

@Test
func testFromBoolVecQ2PackedMediump(): Unit {
    let vb = Vec2<Bool, PackedMediump>(true, false)
    let r = fromBoolVecQ2<Int64, Defaultp, PackedMediump>(vb, Int64(0), Int64(1))
    @Expect(r.x, 1)
    @Expect(r.y, 0)
}

@Test
func testFromBoolVecQ2PackedLowp(): Unit {
    let vb = Vec2<Bool, PackedLowp>(false, true)
    let r = fromBoolVecQ2<Int64, Defaultp, PackedLowp>(vb, Int64(0), Int64(1))
    @Expect(r.x, 0)
    @Expect(r.y, 1)
}
