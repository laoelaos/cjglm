package glm.detail

import std.unittest.*
import std.unittest.testmacro.*

@Test
func testCastVec1ToVec1IntToFloat(): Unit {
    let v = Vec1<Int64, Defaultp>(42)
    let r = castVec1<Float32, Defaultp, Int64, Defaultp>(v, { x => Float32(x) })
    @Expect(r.x, Float32(42.0))
}

@Test
func testCastVec2ToVec1TakesOnlyX(): Unit {
    let v = Vec2<Int64, Defaultp>(10, 99)
    let r = castVec1<Int64, Defaultp, Int64, Defaultp>(v, { x => x })
    @Expect(r.x, 10)
}

@Test
func testCastVec3ToVec1TakesOnlyX(): Unit {
    let v = Vec3<Int64, Defaultp>(20, 99, 88)
    let r = castVec1<Int64, Defaultp, Int64, Defaultp>(v, { x => x })
    @Expect(r.x, 20)
}

@Test
func testCastVec4ToVec1TakesOnlyX(): Unit {
    let v = Vec4<Int64, Defaultp>(30, 99, 88, 77)
    let r = castVec1<Int64, Defaultp, Int64, Defaultp>(v, { x => x })
    @Expect(r.x, 30)
}

@Test
func testCastSameTypeIdentity(): Unit {
    let v = Vec1<Int64, Defaultp>(7)
    let r = castVec1<Int64, Defaultp, Int64, Defaultp>(v, { x => x })
    @Expect(r.x, 7)
}

@Test
func testCastInt32ToInt64(): Unit {
    let v = Vec1<Int32, Defaultp>(Int32(99))
    let r = castVec1<Int64, Defaultp, Int32, Defaultp>(v, { x => Int64(x) })
    @Expect(r.x, Int64(99))
}

@Test
func testCastFloatToIntTruncation(): Unit {
    let v = Vec1<Float32, Defaultp>(Float32(3.7))
    let r = castVec1<Int64, Defaultp, Float32, Defaultp>(v, { x => Int64(x) })
    @Expect(r.x, Int64(3))
}

@Test
func testCastCrossQualifierPackedHighpToDefaultp(): Unit {
    let v = Vec1<Int64, PackedHighp>(5)
    let r = castVec1<Int64, Defaultp, Int64, PackedHighp>(v, { x => x })
    @Expect(r.x, 5)
}

@Test
func testCastCrossQualifierDefaultpToPackedHighp(): Unit {
    let v = Vec1<Int64, Defaultp>(8)
    let r = castVec1<Int64, PackedHighp, Int64, Defaultp>(v, { x => x })
    @Expect(r.x, 8)
}

@Test
func testCastVec2CrossQualifierCrossType(): Unit {
    let v = Vec2<Int32, PackedLowp>(Int32(4), Int32(9))
    let r = castVec1<Float32, Defaultp, Int32, PackedLowp>(v, { x => Float32(x) })
    @Expect(r.x, Float32(4.0))
}

@Test
func testCastVec3CrossQualifier(): Unit {
    let v = Vec3<Int64, PackedMediump>(15, 99, 88)
    let r = castVec1<Int64, Defaultp, Int64, PackedMediump>(v, { x => x })
    @Expect(r.x, 15)
}

@Test
func testCastVec4CrossQualifier(): Unit {
    let v = Vec4<Int64, PackedMediump>(25, 99, 88, 77)
    let r = castVec1<Int64, Defaultp, Int64, PackedMediump>(v, { x => x })
    @Expect(r.x, 25)
}

@Test
func testCastVec1DoesNotModifySource(): Unit {
    let v = Vec1<Int64, Defaultp>(42)
    let _ = castVec1<Int64, Defaultp, Int64, Defaultp>(v, { x => x + Int64(1) })
    @Expect(v.x, 42)
}

@Test
func testCastVec2Vec1ToVec2IntToFloat(): Unit {
    let v = Vec1<Int64, Defaultp>(42)
    let r = castVec2<Float32, Defaultp, Int64, Defaultp>(v, { x => Float32(x) })
    @Expect(r.x, Float32(42.0))
    @Expect(r.y, Float32(42.0))
}

@Test
func testCastVec2Vec2ToVec2Identity(): Unit {
    let v = Vec2<Int64, Defaultp>(10, 20)
    let r = castVec2<Int64, Defaultp, Int64, Defaultp>(v, { x => x })
    @Expect(r.x, 10)
    @Expect(r.y, 20)
}

@Test
func testCastVec2Vec3ToVec2TakesOnlyXY(): Unit {
    let v = Vec3<Int64, Defaultp>(10, 20, 30)
    let r = castVec2<Int64, Defaultp, Int64, Defaultp>(v, { x => x })
    @Expect(r.x, 10)
    @Expect(r.y, 20)
}

@Test
func testCastVec2Vec4ToVec2TakesOnlyXY(): Unit {
    let v = Vec4<Int64, Defaultp>(10, 20, 30, 40)
    let r = castVec2<Int64, Defaultp, Int64, Defaultp>(v, { x => x })
    @Expect(r.x, 10)
    @Expect(r.y, 20)
}

@Test
func testCastVec2SameTypeIdentity(): Unit {
    let v = Vec2<Int64, Defaultp>(7, 8)
    let r = castVec2<Int64, Defaultp, Int64, Defaultp>(v, { x => x })
    @Expect(r.x, 7)
    @Expect(r.y, 8)
}

@Test
func testCastVec2Int32ToInt64(): Unit {
    let v = Vec2<Int32, Defaultp>(Int32(99), Int32(88))
    let r = castVec2<Int64, Defaultp, Int32, Defaultp>(v, { x => Int64(x) })
    @Expect(r.x, Int64(99))
    @Expect(r.y, Int64(88))
}

@Test
func testCastVec2FloatToIntTruncation(): Unit {
    let v = Vec2<Float32, Defaultp>(Float32(3.7), Float32(5.2))
    let r = castVec2<Int64, Defaultp, Float32, Defaultp>(v, { x => Int64(x) })
    @Expect(r.x, Int64(3))
    @Expect(r.y, Int64(5))
}

@Test
func testCastVec2CrossQualifierPackedHighpToDefaultp(): Unit {
    let v = Vec2<Int64, PackedHighp>(5, 6)
    let r = castVec2<Int64, Defaultp, Int64, PackedHighp>(v, { x => x })
    @Expect(r.x, 5)
    @Expect(r.y, 6)
}

@Test
func testCastVec2DoesNotModifySource(): Unit {
    let v = Vec2<Int64, Defaultp>(42, 43)
    let _ = castVec2<Int64, Defaultp, Int64, Defaultp>(v, { x => x + Int64(1) })
    @Expect(v.x, 42)
    @Expect(v.y, 43)
}

@Test
func testCastVec2Vec1ToVec2SameValueBothComponents(): Unit {
    let v = Vec1<Int64, Defaultp>(7)
    let r = castVec2<Int64, Defaultp, Int64, Defaultp>(v, { x => x })
    @Expect(r.x, 7)
    @Expect(r.y, 7)
}

@Test
func testCastVec3Vec1ToVec3IntToFloat(): Unit {
    let v = Vec1<Int64, Defaultp>(42)
    let r = castVec3<Float32, Defaultp, Int64, Defaultp>(v, { x => Float32(x) })
    @Expect(r.x, Float32(42.0))
    @Expect(r.y, Float32(42.0))
    @Expect(r.z, Float32(42.0))
}

@Test
func testCastVec3Vec2ToVec3ExtendY(): Unit {
    let v = Vec2<Int64, Defaultp>(10, 20)
    let r = castVec3<Int64, Defaultp, Int64, Defaultp>(v, { x => x })
    @Expect(r.x, 10)
    @Expect(r.y, 20)
    @Expect(r.z, 20)
}

@Test
func testCastVec3Vec3ToVec3Identity(): Unit {
    let v = Vec3<Int64, Defaultp>(10, 20, 30)
    let r = castVec3<Int64, Defaultp, Int64, Defaultp>(v, { x => x })
    @Expect(r.x, 10)
    @Expect(r.y, 20)
    @Expect(r.z, 30)
}

@Test
func testCastVec3Vec4ToVec3TakesOnlyXYZ(): Unit {
    let v = Vec4<Int64, Defaultp>(10, 20, 30, 40)
    let r = castVec3<Int64, Defaultp, Int64, Defaultp>(v, { x => x })
    @Expect(r.x, 10)
    @Expect(r.y, 20)
    @Expect(r.z, 30)
}

@Test
func testCastVec3SameTypeIdentity(): Unit {
    let v = Vec3<Int64, Defaultp>(7, 8, 9)
    let r = castVec3<Int64, Defaultp, Int64, Defaultp>(v, { x => x })
    @Expect(r.x, 7)
    @Expect(r.y, 8)
    @Expect(r.z, 9)
}

@Test
func testCastVec3Int32ToInt64(): Unit {
    let v = Vec3<Int32, Defaultp>(Int32(99), Int32(88), Int32(77))
    let r = castVec3<Int64, Defaultp, Int32, Defaultp>(v, { x => Int64(x) })
    @Expect(r.x, Int64(99))
    @Expect(r.y, Int64(88))
    @Expect(r.z, Int64(77))
}

@Test
func testCastVec3FloatToIntTruncation(): Unit {
    let v = Vec3<Float32, Defaultp>(Float32(3.7), Float32(5.2), Float32(6.9))
    let r = castVec3<Int64, Defaultp, Float32, Defaultp>(v, { x => Int64(x) })
    @Expect(r.x, Int64(3))
    @Expect(r.y, Int64(5))
    @Expect(r.z, Int64(6))
}

@Test
func testCastVec3CrossQualifierPackedHighpToDefaultp(): Unit {
    let v = Vec3<Int64, PackedHighp>(5, 6, 7)
    let r = castVec3<Int64, Defaultp, Int64, PackedHighp>(v, { x => x })
    @Expect(r.x, 5)
    @Expect(r.y, 6)
    @Expect(r.z, 7)
}

@Test
func testCastVec3DoesNotModifySource(): Unit {
    let v = Vec3<Int64, Defaultp>(42, 43, 44)
    let _ = castVec3<Int64, Defaultp, Int64, Defaultp>(v, { x => x + Int64(1) })
    @Expect(v.x, 42)
    @Expect(v.y, 43)
    @Expect(v.z, 44)
}

@Test
func testCastVec3Vec1ToVec3SameValueAllComponents(): Unit {
    let v = Vec1<Int64, Defaultp>(7)
    let r = castVec3<Int64, Defaultp, Int64, Defaultp>(v, { x => x })
    @Expect(r.x, 7)
    @Expect(r.y, 7)
    @Expect(r.z, 7)
}

@Test
func testCastVec4Vec1ToVec4IntToFloat(): Unit {
    let v = Vec1<Int64, Defaultp>(42)
    let r = castVec4<Float32, Defaultp, Int64, Defaultp>(v, { x => Float32(x) })
    @Expect(r.x, Float32(42.0))
    @Expect(r.y, Float32(42.0))
    @Expect(r.z, Float32(42.0))
    @Expect(r.w, Float32(42.0))
}

@Test
func testCastVec4Vec2ToVec4ExtendY(): Unit {
    let v = Vec2<Int64, Defaultp>(10, 20)
    let r = castVec4<Int64, Defaultp, Int64, Defaultp>(v, { x => x })
    @Expect(r.x, 10)
    @Expect(r.y, 20)
    @Expect(r.z, 20)
    @Expect(r.w, 20)
}

@Test
func testCastVec4Vec3ToVec4ExtendZ(): Unit {
    let v = Vec3<Int64, Defaultp>(10, 20, 30)
    let r = castVec4<Int64, Defaultp, Int64, Defaultp>(v, { x => x })
    @Expect(r.x, 10)
    @Expect(r.y, 20)
    @Expect(r.z, 30)
    @Expect(r.w, 30)
}

@Test
func testCastVec4Vec4ToVec4Identity(): Unit {
    let v = Vec4<Int64, Defaultp>(10, 20, 30, 40)
    let r = castVec4<Int64, Defaultp, Int64, Defaultp>(v, { x => x })
    @Expect(r.x, 10)
    @Expect(r.y, 20)
    @Expect(r.z, 30)
    @Expect(r.w, 40)
}

@Test
func testCastVec4SameTypeIdentity(): Unit {
    let v = Vec4<Int64, Defaultp>(7, 8, 9, 10)
    let r = castVec4<Int64, Defaultp, Int64, Defaultp>(v, { x => x })
    @Expect(r.x, 7)
    @Expect(r.y, 8)
    @Expect(r.z, 9)
    @Expect(r.w, 10)
}

@Test
func testCastVec4Int32ToInt64(): Unit {
    let v = Vec4<Int32, Defaultp>(Int32(99), Int32(88), Int32(77), Int32(66))
    let r = castVec4<Int64, Defaultp, Int32, Defaultp>(v, { x => Int64(x) })
    @Expect(r.x, Int64(99))
    @Expect(r.y, Int64(88))
    @Expect(r.z, Int64(77))
    @Expect(r.w, Int64(66))
}

@Test
func testCastVec4FloatToIntTruncation(): Unit {
    let v = Vec4<Float32, Defaultp>(Float32(3.7), Float32(5.2), Float32(6.9), Float32(8.1))
    let r = castVec4<Int64, Defaultp, Float32, Defaultp>(v, { x => Int64(x) })
    @Expect(r.x, Int64(3))
    @Expect(r.y, Int64(5))
    @Expect(r.z, Int64(6))
    @Expect(r.w, Int64(8))
}

@Test
func testCastVec4CrossQualifierPackedHighpToDefaultp(): Unit {
    let v = Vec4<Int64, PackedHighp>(5, 6, 7, 8)
    let r = castVec4<Int64, Defaultp, Int64, PackedHighp>(v, { x => x })
    @Expect(r.x, 5)
    @Expect(r.y, 6)
    @Expect(r.z, 7)
    @Expect(r.w, 8)
}

@Test
func testCastVec4DoesNotModifySource(): Unit {
    let v = Vec4<Int64, Defaultp>(42, 43, 44, 45)
    let _ = castVec4<Int64, Defaultp, Int64, Defaultp>(v, { x => x + Int64(1) })
    @Expect(v.x, 42)
    @Expect(v.y, 43)
    @Expect(v.z, 44)
    @Expect(v.w, 45)
}

@Test
func testCastVec4Vec1ToVec4SameValueAllComponents(): Unit {
    let v = Vec1<Int64, Defaultp>(7)
    let r = castVec4<Int64, Defaultp, Int64, Defaultp>(v, { x => x })
    @Expect(r.x, 7)
    @Expect(r.y, 7)
    @Expect(r.z, 7)
    @Expect(r.w, 7)
}
