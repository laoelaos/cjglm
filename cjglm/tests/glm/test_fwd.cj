package glm

import std.unittest.*
import std.unittest.testmacro.*
import std.fs.*

private func readFwdSource(): String {
    try {
        return String.fromUtf8(File.readFrom(Path("src/fwd.cj")))
    } catch (_: Exception) {
        return String.fromUtf8(File.readFrom(Path("cjglm/src/fwd.cj")))
    }
}

@Test
func testFwdBVec2(): Unit {
    let b: BVec2 = BVec2(Bool(true), Bool(true))
    @Expect(b.x, Bool(true))
}

@Test
func testFwdVec4(): Unit {
    let v: Vec4 = Vec4(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))
    @Expect(v.w, Float32(4.0))
}

@Test
func testFwdLowpIVec3(): Unit {
    let lv: LowpIVec3 = LowpIVec3(Int32(1), Int32(2), Int32(3))
    @Expect(lv.z, Int32(3))
}

@Test
func testFwdScalarAlias(): Unit {
    let _: int32 = Int32(42)
    @Expect(true, true)
}

@Test
func testFwdVec1Alias(): Unit {
    let v: Vec1 = Vec1(Float32(1.0))
    @Expect(v.x, Float32(1.0))
}

@Test
func testFwdVec2Alias(): Unit {
    let v: Vec2 = Vec2(Float32(1.0), Float32(2.0))
    @Expect(v.x, Float32(1.0))
    @Expect(v.y, Float32(2.0))
}

@Test
func testFwdVec3Alias(): Unit {
    let v: Vec3 = Vec3(Float32(1.0), Float32(2.0), Float32(3.0))
    @Expect(v.z, Float32(3.0))
}

@Test
func testFwdBVec1Alias(): Unit {
    let v: BVec1 = BVec1(Bool(true))
    @Expect(v.x, Bool(true))
}

@Test
func testFwdBVec3Alias(): Unit {
    let v: BVec3 = BVec3(Bool(true), Bool(false), Bool(true))
    @Expect(v.z, Bool(true))
}

@Test
func testFwdBVec4Alias(): Unit {
    let v: BVec4 = BVec4(Bool(true), Bool(false), Bool(true), Bool(false))
    @Expect(v.w, Bool(false))
}

@Test
func testFwdIVec1Alias(): Unit {
    let v: IVec1 = IVec1(Int32(42))
    @Expect(v.x, Int32(42))
}

@Test
func testFwdIVec2Alias(): Unit {
    let v: IVec2 = IVec2(Int32(1), Int32(2))
    @Expect(v.y, Int32(2))
}

@Test
func testFwdIVec4Alias(): Unit {
    let v: IVec4 = IVec4(Int32(1), Int32(2), Int32(3), Int32(4))
    @Expect(v.w, Int32(4))
}

@Test
func testFwdUVec1Alias(): Unit {
    let v: UVec1 = UVec1(UInt32(10))
    @Expect(v.x, UInt32(10))
}

@Test
func testFwdUVec3Alias(): Unit {
    let v: UVec3 = UVec3(UInt32(1), UInt32(2), UInt32(3))
    @Expect(v.z, UInt32(3))
}

@Test
func testFwdDVec2Alias(): Unit {
    let v: DVec2 = DVec2(Float64(1.5), Float64(2.5))
    @Expect(v.y, Float64(2.5))
}

@Test
func testFwdDVec4Alias(): Unit {
    let v: DVec4 = DVec4(Float64(1.0), Float64(2.0), Float64(3.0), Float64(4.0))
    @Expect(v.w, Float64(4.0))
}

@Test
func testFwdMediumpVec2Alias(): Unit {
    let v: MediumpVec2 = MediumpVec2(Float32(1.0), Float32(2.0))
    @Expect(v.y, Float32(2.0))
}

@Test
func testFwdLowpVec4Alias(): Unit {
    let v: LowpVec4 = LowpVec4(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))
    @Expect(v.w, Float32(4.0))
}

@Test
func testFwdHighpIVec2Alias(): Unit {
    let v: HighpIVec2 = HighpIVec2(Int32(1), Int32(2))
    @Expect(v.x, Int32(1))
}

@Test
func testFwdLowpIVec1Alias(): Unit {
    let v: LowpIVec1 = LowpIVec1(Int32(99))
    @Expect(v.x, Int32(99))
}

@Test
func testFwdI8Vec2Alias(): Unit {
    let v: I8Vec2 = I8Vec2(Int8(1), Int8(2))
    @Expect(v.x, Int8(1))
}

@Test
func testFwdI16Vec3Alias(): Unit {
    let v: I16Vec3 = I16Vec3(Int16(1), Int16(2), Int16(3))
    @Expect(v.z, Int16(3))
}

@Test
func testFwdI32Vec1Alias(): Unit {
    let v: I32Vec1 = I32Vec1(Int32(100))
    @Expect(v.x, Int32(100))
}

@Test
func testFwdI64Vec4Alias(): Unit {
    let v: I64Vec4 = I64Vec4(Int64(1), Int64(2), Int64(3), Int64(4))
    @Expect(v.w, Int64(4))
}

@Test
func testFwdU8Vec3Alias(): Unit {
    let v: U8Vec3 = U8Vec3(UInt8(1), UInt8(2), UInt8(3))
    @Expect(v.z, UInt8(3))
}

@Test
func testFwdU16Vec2Alias(): Unit {
    let v: U16Vec2 = U16Vec2(UInt16(1), UInt16(2))
    @Expect(v.y, UInt16(2))
}

@Test
func testFwdU32Vec4Alias(): Unit {
    let v: U32Vec4 = U32Vec4(UInt32(1), UInt32(2), UInt32(3), UInt32(4))
    @Expect(v.w, UInt32(4))
}

@Test
func testFwdU64Vec1Alias(): Unit {
    let v: U64Vec1 = U64Vec1(UInt64(42))
    @Expect(v.x, UInt64(42))
}

@Test
func testFwdFVec3Alias(): Unit {
    let v: FVec3 = FVec3(Float32(1.0), Float32(2.0), Float32(3.0))
    @Expect(v.z, Float32(3.0))
}

@Test
func testFwdF64Vec2Alias(): Unit {
    let v: F64Vec2 = F64Vec2(Float64(1.0), Float64(2.0))
    @Expect(v.y, Float64(2.0))
}

@Test
func testFwdF32Vec4Alias(): Unit {
    let v: F32Vec4 = F32Vec4(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))
    @Expect(v.w, Float32(4.0))
}

@Test
func testFwdGenericVec1Accessible(): Unit {
    let v: detail.Vec1<Float32, PackedHighp> = detail.Vec1<Float32, PackedHighp>(Float32(1.0))
    @Expect(v.x, Float32(1.0))
}

@Test
func testFwdGenericVec2Accessible(): Unit {
    let v: detail.Vec2<Int32, PackedHighp> = detail.Vec2<Int32, PackedHighp>(Int32(1), Int32(2))
    @Expect(v.y, Int32(2))
}

@Test
func testFwdGenericVec3Accessible(): Unit {
    let v: detail.Vec3<Bool, PackedHighp> = detail.Vec3<Bool, PackedHighp>(Bool(true), Bool(false), Bool(true))
    @Expect(v.z, Bool(true))
}

@Test
func testFwdGenericVec4Accessible(): Unit {
    let v: detail.Vec4<Float64, PackedLowp> = detail.Vec4<Float64, PackedLowp>(Float64(1.0), Float64(2.0), Float64(3.0), Float64(4.0))
    @Expect(v.w, Float64(4.0))
}

@Test
func testFwdAliasAndGenericCompatible(): Unit {
    let alias: Vec1 = Vec1(Float32(5.0))
    let generic: detail.Vec1<Float32, PackedHighp> = alias
    @Expect(generic.x, Float32(5.0))
}

@Test
func testFwdAliasAndGenericVec2Compatible(): Unit {
    let alias: Vec2 = Vec2(Float32(1.0), Float32(2.0))
    let generic: detail.Vec2<Float32, PackedHighp> = alias
    @Expect(generic.y, Float32(2.0))
}

@Test
func testFwdHeaderComments(): Unit {
    let content = readFwdSource()
    let lines = content.split("\n")
    @Expect(lines[0].startsWith("// fwd.cj"), true)
    @Expect(lines[1].startsWith("// 注意"), true)
}

@Test
func testFwdFamilyComments(): Unit {
    let content = readFwdSource()
    let families = ["B", "I", "U", "Vec", "DVec", "I8", "I16", "I32", "I64", "U8", "U16", "U32", "U64", "FVec", "F32", "F64"]
    for (fam in families) {
        @Expect(content.contains("// === ${fam} family ==="), true)
    }
}

