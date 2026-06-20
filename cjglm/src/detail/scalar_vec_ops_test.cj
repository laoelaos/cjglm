package glm.detail

import std.unittest.*
import std.unittest.testmacro.*

@Test
func testScalarAddVec1(): Unit {
    let v = Vec1<Int64, Defaultp>(10)
    let r = add(Int64(3), v)
    @Expect(r.x, 13)
}

@Test
func testScalarAddVec2(): Unit {
    let v = Vec2<Int64, Defaultp>(10, 20)
    let r = add(Int64(3), v)
    @Expect(r.x, 13)
    @Expect(r.y, 23)
}

@Test
func testScalarAddVec3(): Unit {
    let v = Vec3<Int64, Defaultp>(10, 20, 30)
    let r = add(Int64(3), v)
    @Expect(r.x, 13)
    @Expect(r.y, 23)
    @Expect(r.z, 33)
}

@Test
func testScalarAddVec4(): Unit {
    let v = Vec4<Int64, Defaultp>(10, 20, 30, 40)
    let r = add(Int64(3), v)
    @Expect(r.x, 13)
    @Expect(r.y, 23)
    @Expect(r.z, 33)
    @Expect(r.w, 43)
}

@Test
func testScalarSubVec1(): Unit {
    let v = Vec1<Int64, Defaultp>(10)
    let r = sub(Int64(3), v)
    @Expect(r.x, -7)
}

@Test
func testScalarMulVec1(): Unit {
    let v = Vec1<Int64, Defaultp>(10)
    let r = mul(Int64(3), v)
    @Expect(r.x, 30)
}

@Test
func testScalarDivVec1(): Unit {
    let v = Vec1<Int64, Defaultp>(10)
    let r = div(Int64(30), v)
    @Expect(r.x, 3)
}

@Test
func testScalarModVec1(): Unit {
    let v = Vec1<Int64, Defaultp>(10)
    let r = mod(Int64(33), v)
    @Expect(r.x, 3)
}

@Test
func testScalarMulVec2(): Unit {
    let v = Vec2<Int64, Defaultp>(2, 3)
    let r = mul(Int64(5), v)
    @Expect(r.x, 10)
    @Expect(r.y, 15)
}

@Test
func testScalarSubVec2(): Unit {
    let v = Vec2<Int64, Defaultp>(10, 20)
    let r = sub(Int64(3), v)
    @Expect(r.x, -7)
    @Expect(r.y, -17)
}

@Test
func testScalarSubVec3(): Unit {
    let v = Vec3<Int64, Defaultp>(10, 20, 30)
    let r = sub(Int64(3), v)
    @Expect(r.x, -7)
    @Expect(r.y, -17)
    @Expect(r.z, -27)
}

@Test
func testScalarSubVec4(): Unit {
    let v = Vec4<Int64, Defaultp>(10, 20, 30, 40)
    let r = sub(Int64(3), v)
    @Expect(r.x, -7)
    @Expect(r.y, -17)
    @Expect(r.z, -27)
    @Expect(r.w, -37)
}

@Test
func testScalarMulVec3(): Unit {
    let v = Vec3<Int64, Defaultp>(2, 3, 4)
    let r = mul(Int64(5), v)
    @Expect(r.x, 10)
    @Expect(r.y, 15)
    @Expect(r.z, 20)
}

@Test
func testScalarMulVec4(): Unit {
    let v = Vec4<Int64, Defaultp>(2, 3, 4, 5)
    let r = mul(Int64(5), v)
    @Expect(r.x, 10)
    @Expect(r.y, 15)
    @Expect(r.z, 20)
    @Expect(r.w, 25)
}

@Test
func testScalarDivVec2(): Unit {
    let v = Vec2<Int64, Defaultp>(10, 15)
    let r = div(Int64(30), v)
    @Expect(r.x, 3)
    @Expect(r.y, 2)
}

@Test
func testScalarDivVec3(): Unit {
    let v = Vec3<Int64, Defaultp>(10, 15, 20)
    let r = div(Int64(60), v)
    @Expect(r.x, 6)
    @Expect(r.y, 4)
    @Expect(r.z, 3)
}

@Test
func testScalarDivVec4(): Unit {
    let v = Vec4<Int64, Defaultp>(10, 15, 20, 30)
    let r = div(Int64(60), v)
    @Expect(r.x, 6)
    @Expect(r.y, 4)
    @Expect(r.z, 3)
    @Expect(r.w, 2)
}

@Test
func testScalarModVec2(): Unit {
    let v = Vec2<Int64, Defaultp>(10, 15)
    let r = mod(Int64(33), v)
    @Expect(r.x, 3)
    @Expect(r.y, 3)
}

@Test
func testScalarModVec3(): Unit {
    let v = Vec3<Int64, Defaultp>(10, 15, 20)
    let r = mod(Int64(33), v)
    @Expect(r.x, 3)
    @Expect(r.y, 3)
    @Expect(r.z, 13)
}

@Test
func testScalarModVec4(): Unit {
    let v = Vec4<Int64, Defaultp>(10, 15, 20, 25)
    let r = mod(Int64(33), v)
    @Expect(r.x, 3)
    @Expect(r.y, 3)
    @Expect(r.z, 13)
    @Expect(r.w, 8)
}

@Test
func testScalarModVec1Float32(): Unit {
    let v = Vec1<Float32, Defaultp>(Float32(2.5))
    let r = mod(Float32(7.5), v)
    @Expect(r.x, Float32(0.0))
}

@Test
func testScalarModVec2Float32(): Unit {
    let v = Vec2<Float32, Defaultp>(Float32(2.5), Float32(3.0))
    let r = mod(Float32(7.5), v)
    @Expect(r.x, Float32(0.0))
    @Expect(r.y, Float32(1.5))
}

@Test
func testScalarModVec3Float32(): Unit {
    let v = Vec3<Float32, Defaultp>(Float32(2.5), Float32(3.0), Float32(4.0))
    let r = mod(Float32(7.5), v)
    @Expect(r.x, Float32(0.0))
    @Expect(r.y, Float32(1.5))
    @Expect(r.z, Float32(3.5))
}

@Test
func testScalarModVec4Float32(): Unit {
    let v = Vec4<Float32, Defaultp>(Float32(2.5), Float32(3.0), Float32(4.0), Float32(5.0))
    let r = mod(Float32(7.5), v)
    @Expect(r.x, Float32(0.0))
    @Expect(r.y, Float32(1.5))
    @Expect(r.z, Float32(3.5))
    @Expect(r.w, Float32(2.5))
}

@Test
func testScalarModVec1Float64(): Unit {
    let v = Vec1<Float64, Defaultp>(Float64(2.5))
    let r = mod(Float64(7.5), v)
    @Expect(r.x, Float64(0.0))
}

@Test
func testScalarModVec2Float64(): Unit {
    let v = Vec2<Float64, Defaultp>(Float64(2.5), Float64(3.0))
    let r = mod(Float64(7.5), v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(1.5))
}

@Test
func testScalarModVec3Float64(): Unit {
    let v = Vec3<Float64, Defaultp>(Float64(2.5), Float64(3.0), Float64(4.0))
    let r = mod(Float64(7.5), v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(1.5))
    @Expect(r.z, Float64(3.5))
}

@Test
func testScalarModVec4Float64(): Unit {
    let v = Vec4<Float64, Defaultp>(Float64(2.5), Float64(3.0), Float64(4.0), Float64(5.0))
    let r = mod(Float64(7.5), v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(1.5))
    @Expect(r.z, Float64(3.5))
    @Expect(r.w, Float64(2.5))
}

@Test
func testScalarModVec1Float16(): Unit {
    let v = Vec1<Float16, Defaultp>(Float16(2.5))
    let r = mod(Float16(7.5), v)
    @Expect(r.x, Float16(0.0))
}

@Test
func testScalarModVec2Float16(): Unit {
    let v = Vec2<Float16, Defaultp>(Float16(2.5), Float16(3.0))
    let r = mod(Float16(7.5), v)
    @Expect(r.x, Float16(0.0))
    @Expect(r.y, Float16(1.5))
}

@Test
func testScalarModVec3Float16(): Unit {
    let v = Vec3<Float16, Defaultp>(Float16(2.5), Float16(3.0), Float16(4.0))
    let r = mod(Float16(7.5), v)
    @Expect(r.x, Float16(0.0))
    @Expect(r.y, Float16(1.5))
    @Expect(r.z, Float16(3.5))
}

@Test
func testScalarModVec4Float16(): Unit {
    let v = Vec4<Float16, Defaultp>(Float16(2.5), Float16(3.0), Float16(4.0), Float16(5.0))
    let r = mod(Float16(7.5), v)
    @Expect(r.x, Float16(0.0))
    @Expect(r.y, Float16(1.5))
    @Expect(r.z, Float16(3.5))
    @Expect(r.w, Float16(2.5))
}

@Test
func testScalarSubVec2PackedMediump(): Unit {
    let v = Vec2<Int64, PackedMediump>(10, 20)
    let r = sub(Int64(3), v)
    @Expect(r.x, -7)
    @Expect(r.y, -17)
}

@Test
func testScalarSubVec2PackedLowp(): Unit {
    let v = Vec2<Int64, PackedLowp>(10, 20)
    let r = sub(Int64(3), v)
    @Expect(r.x, -7)
    @Expect(r.y, -17)
}

@Test
func testScalarMulVec2PackedMediump(): Unit {
    let v = Vec2<Int64, PackedMediump>(2, 3)
    let r = mul(Int64(5), v)
    @Expect(r.x, 10)
    @Expect(r.y, 15)
}

@Test
func testScalarMulVec2PackedLowp(): Unit {
    let v = Vec2<Int64, PackedLowp>(2, 3)
    let r = mul(Int64(5), v)
    @Expect(r.x, 10)
    @Expect(r.y, 15)
}

@Test
func testScalarDivVec2PackedMediump(): Unit {
    let v = Vec2<Int64, PackedMediump>(10, 15)
    let r = div(Int64(30), v)
    @Expect(r.x, 3)
    @Expect(r.y, 2)
}

@Test
func testScalarDivVec2PackedLowp(): Unit {
    let v = Vec2<Int64, PackedLowp>(10, 15)
    let r = div(Int64(30), v)
    @Expect(r.x, 3)
    @Expect(r.y, 2)
}

@Test
func testScalarModVec2PackedMediump(): Unit {
    let v = Vec2<Int64, PackedMediump>(10, 15)
    let r = mod(Int64(33), v)
    @Expect(r.x, 3)
    @Expect(r.y, 3)
}

@Test
func testScalarModVec2PackedLowp(): Unit {
    let v = Vec2<Int64, PackedLowp>(10, 15)
    let r = mod(Int64(33), v)
    @Expect(r.x, 3)
    @Expect(r.y, 3)
}

@Test
func testScalarModVec2Float32PackedMediump(): Unit {
    let v = Vec2<Float32, PackedMediump>(Float32(2.5), Float32(3.0))
    let r = mod(Float32(7.5), v)
    @Expect(r.x, Float32(0.0))
    @Expect(r.y, Float32(1.5))
}

@Test
func testScalarModVec2Float32PackedLowp(): Unit {
    let v = Vec2<Float32, PackedLowp>(Float32(2.5), Float32(3.0))
    let r = mod(Float32(7.5), v)
    @Expect(r.x, Float32(0.0))
    @Expect(r.y, Float32(1.5))
}

@Test
func testScalarModVec2Float32NegativeDividend(): Unit {
    let v = Vec2<Float32, Defaultp>(Float32(2.5), Float32(3.0))
    let r = mod(Float32(-7.5), v)
    @Expect(r.x, Float32(-0.0))
    @Expect(r.y, Float32(-1.5))
}

@Test
func testScalarModVec2Float32NegativeDivisor(): Unit {
    let v = Vec2<Float32, Defaultp>(Float32(-2.5), Float32(-3.0))
    let r = mod(Float32(7.5), v)
    @Expect(r.x, Float32(0.0))
    @Expect(r.y, Float32(1.5))
}

@Test
func testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents(): Unit {
    let v = Vec2<Float32, Defaultp>(Float32(0.0), Float32(2.5))
    try {
        let r = mod(Float32(7.5), v)
        @Expect(r.y, Float32(0.0))
    } catch (_: Exception) {
        @Expect(true, true)
    }
}

@Test
func testScalarAddVec1Float32(): Unit {
    let v = Vec1<Float32, Defaultp>(Float32(1.5))
    let r = add(Float32(3.0), v)
    @Expect(r.x, Float32(4.5))
}

@Test
func testScalarAddVec2Float32(): Unit {
    let v = Vec2<Float32, Defaultp>(Float32(1.5), Float32(2.5))
    let r = add(Float32(3.0), v)
    @Expect(r.x, Float32(4.5))
    @Expect(r.y, Float32(5.5))
}

@Test
func testScalarAddVec3Float32(): Unit {
    let v = Vec3<Float32, Defaultp>(Float32(1.5), Float32(2.5), Float32(3.5))
    let r = add(Float32(3.0), v)
    @Expect(r.x, Float32(4.5))
    @Expect(r.y, Float32(5.5))
    @Expect(r.z, Float32(6.5))
}

@Test
func testScalarAddVec4Float32(): Unit {
    let v = Vec4<Float32, Defaultp>(Float32(1.5), Float32(2.5), Float32(3.5), Float32(4.5))
    let r = add(Float32(3.0), v)
    @Expect(r.x, Float32(4.5))
    @Expect(r.y, Float32(5.5))
    @Expect(r.z, Float32(6.5))
    @Expect(r.w, Float32(7.5))
}

@Test
func testScalarSubVec1Float32(): Unit {
    let v = Vec1<Float32, Defaultp>(Float32(2.5))
    let r = sub(Float32(7.0), v)
    @Expect(r.x, Float32(4.5))
}

@Test
func testScalarSubVec2Float32(): Unit {
    let v = Vec2<Float32, Defaultp>(Float32(2.5), Float32(3.0))
    let r = sub(Float32(7.0), v)
    @Expect(r.x, Float32(4.5))
    @Expect(r.y, Float32(4.0))
}

@Test
func testScalarSubVec3Float32(): Unit {
    let v = Vec3<Float32, Defaultp>(Float32(2.5), Float32(3.0), Float32(4.0))
    let r = sub(Float32(7.0), v)
    @Expect(r.x, Float32(4.5))
    @Expect(r.y, Float32(4.0))
    @Expect(r.z, Float32(3.0))
}

@Test
func testScalarSubVec4Float32(): Unit {
    let v = Vec4<Float32, Defaultp>(Float32(2.5), Float32(3.0), Float32(4.0), Float32(5.0))
    let r = sub(Float32(7.0), v)
    @Expect(r.x, Float32(4.5))
    @Expect(r.y, Float32(4.0))
    @Expect(r.z, Float32(3.0))
    @Expect(r.w, Float32(2.0))
}

@Test
func testScalarMulVec1Float32(): Unit {
    let v = Vec1<Float32, Defaultp>(Float32(3.5))
    let r = mul(Float32(2.0), v)
    @Expect(r.x, Float32(7.0))
}

@Test
func testScalarMulVec2Float32(): Unit {
    let v = Vec2<Float32, Defaultp>(Float32(3.5), Float32(4.0))
    let r = mul(Float32(2.0), v)
    @Expect(r.x, Float32(7.0))
    @Expect(r.y, Float32(8.0))
}

@Test
func testScalarMulVec3Float32(): Unit {
    let v = Vec3<Float32, Defaultp>(Float32(3.5), Float32(4.0), Float32(5.0))
    let r = mul(Float32(2.0), v)
    @Expect(r.x, Float32(7.0))
    @Expect(r.y, Float32(8.0))
    @Expect(r.z, Float32(10.0))
}

@Test
func testScalarMulVec4Float32(): Unit {
    let v = Vec4<Float32, Defaultp>(Float32(3.5), Float32(4.0), Float32(5.0), Float32(6.0))
    let r = mul(Float32(2.0), v)
    @Expect(r.x, Float32(7.0))
    @Expect(r.y, Float32(8.0))
    @Expect(r.z, Float32(10.0))
    @Expect(r.w, Float32(12.0))
}

@Test
func testScalarDivVec1Float32(): Unit {
    let v = Vec1<Float32, Defaultp>(Float32(2.5))
    let r = div(Float32(7.5), v)
    @Expect(r.x, Float32(3.0))
}

@Test
func testScalarDivVec2Float32(): Unit {
    let v = Vec2<Float32, Defaultp>(Float32(2.5), Float32(3.0))
    let r = div(Float32(7.5), v)
    @Expect(r.x, Float32(3.0))
    @Expect(r.y, Float32(2.5))
}

@Test
func testScalarDivVec3Float32(): Unit {
    let v = Vec3<Float32, Defaultp>(Float32(2.5), Float32(3.0), Float32(5.0))
    let r = div(Float32(7.5), v)
    @Expect(r.x, Float32(3.0))
    @Expect(r.y, Float32(2.5))
    @Expect(r.z, Float32(1.5))
}

@Test
func testScalarDivVec4Float32(): Unit {
    let v = Vec4<Float32, Defaultp>(Float32(2.5), Float32(3.0), Float32(5.0), Float32(15.0))
    let r = div(Float32(7.5), v)
    @Expect(r.x, Float32(3.0))
    @Expect(r.y, Float32(2.5))
    @Expect(r.z, Float32(1.5))
    @Expect(r.w, Float32(0.5))
}

@Test
func testScalarAddVec1Int32(): Unit {
    let v = Vec1<Int32, Defaultp>(Int32(10))
    let r = add(Int32(3), v)
    @Expect(r.x, Int32(13))
}

@Test
func testScalarAddVec2Int32(): Unit {
    let v = Vec2<Int32, Defaultp>(Int32(10), Int32(20))
    let r = add(Int32(3), v)
    @Expect(r.x, Int32(13))
    @Expect(r.y, Int32(23))
}

@Test
func testScalarAddVec3Int32(): Unit {
    let v = Vec3<Int32, Defaultp>(Int32(10), Int32(20), Int32(30))
    let r = add(Int32(3), v)
    @Expect(r.x, Int32(13))
    @Expect(r.y, Int32(23))
    @Expect(r.z, Int32(33))
}

@Test
func testScalarAddVec4Int32(): Unit {
    let v = Vec4<Int32, Defaultp>(Int32(10), Int32(20), Int32(30), Int32(40))
    let r = add(Int32(3), v)
    @Expect(r.x, Int32(13))
    @Expect(r.y, Int32(23))
    @Expect(r.z, Int32(33))
    @Expect(r.w, Int32(43))
}

@Test
func testScalarSubVec1Int32(): Unit {
    let v = Vec1<Int32, Defaultp>(Int32(10))
    let r = sub(Int32(3), v)
    @Expect(r.x, Int32(-7))
}

@Test
func testScalarSubVec2Int32(): Unit {
    let v = Vec2<Int32, Defaultp>(Int32(10), Int32(20))
    let r = sub(Int32(3), v)
    @Expect(r.x, Int32(-7))
    @Expect(r.y, Int32(-17))
}

@Test
func testScalarSubVec3Int32(): Unit {
    let v = Vec3<Int32, Defaultp>(Int32(10), Int32(20), Int32(30))
    let r = sub(Int32(3), v)
    @Expect(r.x, Int32(-7))
    @Expect(r.y, Int32(-17))
    @Expect(r.z, Int32(-27))
}

@Test
func testScalarSubVec4Int32(): Unit {
    let v = Vec4<Int32, Defaultp>(Int32(10), Int32(20), Int32(30), Int32(40))
    let r = sub(Int32(3), v)
    @Expect(r.x, Int32(-7))
    @Expect(r.y, Int32(-17))
    @Expect(r.z, Int32(-27))
    @Expect(r.w, Int32(-37))
}

@Test
func testScalarMulVec1Int32(): Unit {
    let v = Vec1<Int32, Defaultp>(Int32(2))
    let r = mul(Int32(5), v)
    @Expect(r.x, Int32(10))
}

@Test
func testScalarMulVec2Int32(): Unit {
    let v = Vec2<Int32, Defaultp>(Int32(2), Int32(3))
    let r = mul(Int32(5), v)
    @Expect(r.x, Int32(10))
    @Expect(r.y, Int32(15))
}

@Test
func testScalarMulVec3Int32(): Unit {
    let v = Vec3<Int32, Defaultp>(Int32(2), Int32(3), Int32(4))
    let r = mul(Int32(5), v)
    @Expect(r.x, Int32(10))
    @Expect(r.y, Int32(15))
    @Expect(r.z, Int32(20))
}

@Test
func testScalarMulVec4Int32(): Unit {
    let v = Vec4<Int32, Defaultp>(Int32(2), Int32(3), Int32(4), Int32(5))
    let r = mul(Int32(5), v)
    @Expect(r.x, Int32(10))
    @Expect(r.y, Int32(15))
    @Expect(r.z, Int32(20))
    @Expect(r.w, Int32(25))
}

@Test
func testScalarDivVec1Int32(): Unit {
    let v = Vec1<Int32, Defaultp>(Int32(10))
    let r = div(Int32(30), v)
    @Expect(r.x, Int32(3))
}

@Test
func testScalarDivVec2Int32(): Unit {
    let v = Vec2<Int32, Defaultp>(Int32(10), Int32(15))
    let r = div(Int32(30), v)
    @Expect(r.x, Int32(3))
    @Expect(r.y, Int32(2))
}

@Test
func testScalarDivVec3Int32(): Unit {
    let v = Vec3<Int32, Defaultp>(Int32(10), Int32(15), Int32(20))
    let r = div(Int32(60), v)
    @Expect(r.x, Int32(6))
    @Expect(r.y, Int32(4))
    @Expect(r.z, Int32(3))
}

@Test
func testScalarDivVec4Int32(): Unit {
    let v = Vec4<Int32, Defaultp>(Int32(10), Int32(15), Int32(20), Int32(30))
    let r = div(Int32(60), v)
    @Expect(r.x, Int32(6))
    @Expect(r.y, Int32(4))
    @Expect(r.z, Int32(3))
    @Expect(r.w, Int32(2))
}

@Test
func testScalarModVec1Int32(): Unit {
    let v = Vec1<Int32, Defaultp>(Int32(10))
    let r = mod(Int32(33), v)
    @Expect(r.x, Int32(3))
}

@Test
func testScalarModVec2Int32(): Unit {
    let v = Vec2<Int32, Defaultp>(Int32(10), Int32(15))
    let r = mod(Int32(33), v)
    @Expect(r.x, Int32(3))
    @Expect(r.y, Int32(3))
}

@Test
func testScalarModVec3Int32(): Unit {
    let v = Vec3<Int32, Defaultp>(Int32(10), Int32(15), Int32(20))
    let r = mod(Int32(33), v)
    @Expect(r.x, Int32(3))
    @Expect(r.y, Int32(3))
    @Expect(r.z, Int32(13))
}

@Test
func testScalarModVec4Int32(): Unit {
    let v = Vec4<Int32, Defaultp>(Int32(10), Int32(15), Int32(20), Int32(25))
    let r = mod(Int32(33), v)
    @Expect(r.x, Int32(3))
    @Expect(r.y, Int32(3))
    @Expect(r.z, Int32(13))
    @Expect(r.w, Int32(8))
}

@Test
func testScalarSubVec1PackedMediump(): Unit {
    let v = Vec1<Int64, PackedMediump>(10)
    let r = sub(Int64(3), v)
    @Expect(r.x, -7)
}

@Test
func testScalarSubVec1PackedLowp(): Unit {
    let v = Vec1<Int64, PackedLowp>(10)
    let r = sub(Int64(3), v)
    @Expect(r.x, -7)
}

@Test
func testScalarSubVec3PackedMediump(): Unit {
    let v = Vec3<Int64, PackedMediump>(10, 20, 30)
    let r = sub(Int64(3), v)
    @Expect(r.x, -7)
    @Expect(r.y, -17)
    @Expect(r.z, -27)
}

@Test
func testScalarSubVec3PackedLowp(): Unit {
    let v = Vec3<Int64, PackedLowp>(10, 20, 30)
    let r = sub(Int64(3), v)
    @Expect(r.x, -7)
    @Expect(r.y, -17)
    @Expect(r.z, -27)
}

@Test
func testScalarSubVec4PackedMediump(): Unit {
    let v = Vec4<Int64, PackedMediump>(10, 20, 30, 40)
    let r = sub(Int64(3), v)
    @Expect(r.x, -7)
    @Expect(r.y, -17)
    @Expect(r.z, -27)
    @Expect(r.w, -37)
}

@Test
func testScalarSubVec4PackedLowp(): Unit {
    let v = Vec4<Int64, PackedLowp>(10, 20, 30, 40)
    let r = sub(Int64(3), v)
    @Expect(r.x, -7)
    @Expect(r.y, -17)
    @Expect(r.z, -27)
    @Expect(r.w, -37)
}

@Test
func testScalarMulVec1PackedMediump(): Unit {
    let v = Vec1<Int64, PackedMediump>(2)
    let r = mul(Int64(5), v)
    @Expect(r.x, 10)
}

@Test
func testScalarMulVec1PackedLowp(): Unit {
    let v = Vec1<Int64, PackedLowp>(2)
    let r = mul(Int64(5), v)
    @Expect(r.x, 10)
}

@Test
func testScalarMulVec3PackedMediump(): Unit {
    let v = Vec3<Int64, PackedMediump>(2, 3, 4)
    let r = mul(Int64(5), v)
    @Expect(r.x, 10)
    @Expect(r.y, 15)
    @Expect(r.z, 20)
}

@Test
func testScalarMulVec3PackedLowp(): Unit {
    let v = Vec3<Int64, PackedLowp>(2, 3, 4)
    let r = mul(Int64(5), v)
    @Expect(r.x, 10)
    @Expect(r.y, 15)
    @Expect(r.z, 20)
}

@Test
func testScalarMulVec4PackedMediump(): Unit {
    let v = Vec4<Int64, PackedMediump>(2, 3, 4, 5)
    let r = mul(Int64(5), v)
    @Expect(r.x, 10)
    @Expect(r.y, 15)
    @Expect(r.z, 20)
    @Expect(r.w, 25)
}

@Test
func testScalarMulVec4PackedLowp(): Unit {
    let v = Vec4<Int64, PackedLowp>(2, 3, 4, 5)
    let r = mul(Int64(5), v)
    @Expect(r.x, 10)
    @Expect(r.y, 15)
    @Expect(r.z, 20)
    @Expect(r.w, 25)
}

@Test
func testScalarDivVec1PackedMediump(): Unit {
    let v = Vec1<Int64, PackedMediump>(10)
    let r = div(Int64(30), v)
    @Expect(r.x, 3)
}

@Test
func testScalarDivVec1PackedLowp(): Unit {
    let v = Vec1<Int64, PackedLowp>(10)
    let r = div(Int64(30), v)
    @Expect(r.x, 3)
}

@Test
func testScalarDivVec3PackedMediump(): Unit {
    let v = Vec3<Int64, PackedMediump>(10, 15, 20)
    let r = div(Int64(60), v)
    @Expect(r.x, 6)
    @Expect(r.y, 4)
    @Expect(r.z, 3)
}

@Test
func testScalarDivVec3PackedLowp(): Unit {
    let v = Vec3<Int64, PackedLowp>(10, 15, 20)
    let r = div(Int64(60), v)
    @Expect(r.x, 6)
    @Expect(r.y, 4)
    @Expect(r.z, 3)
}

@Test
func testScalarDivVec4PackedMediump(): Unit {
    let v = Vec4<Int64, PackedMediump>(10, 15, 20, 30)
    let r = div(Int64(60), v)
    @Expect(r.x, 6)
    @Expect(r.y, 4)
    @Expect(r.z, 3)
    @Expect(r.w, 2)
}

@Test
func testScalarDivVec4PackedLowp(): Unit {
    let v = Vec4<Int64, PackedLowp>(10, 15, 20, 30)
    let r = div(Int64(60), v)
    @Expect(r.x, 6)
    @Expect(r.y, 4)
    @Expect(r.z, 3)
    @Expect(r.w, 2)
}

@Test
func testScalarModVec1PackedMediump(): Unit {
    let v = Vec1<Int64, PackedMediump>(10)
    let r = mod(Int64(33), v)
    @Expect(r.x, 3)
}

@Test
func testScalarModVec1PackedLowp(): Unit {
    let v = Vec1<Int64, PackedLowp>(10)
    let r = mod(Int64(33), v)
    @Expect(r.x, 3)
}

@Test
func testScalarModVec3PackedMediump(): Unit {
    let v = Vec3<Int64, PackedMediump>(10, 15, 20)
    let r = mod(Int64(33), v)
    @Expect(r.x, 3)
    @Expect(r.y, 3)
    @Expect(r.z, 13)
}

@Test
func testScalarModVec3PackedLowp(): Unit {
    let v = Vec3<Int64, PackedLowp>(10, 15, 20)
    let r = mod(Int64(33), v)
    @Expect(r.x, 3)
    @Expect(r.y, 3)
    @Expect(r.z, 13)
}

@Test
func testScalarModVec4PackedMediump(): Unit {
    let v = Vec4<Int64, PackedMediump>(10, 15, 20, 25)
    let r = mod(Int64(33), v)
    @Expect(r.x, 3)
    @Expect(r.y, 3)
    @Expect(r.z, 13)
    @Expect(r.w, 8)
}

@Test
func testScalarModVec4PackedLowp(): Unit {
    let v = Vec4<Int64, PackedLowp>(10, 15, 20, 25)
    let r = mod(Int64(33), v)
    @Expect(r.x, 3)
    @Expect(r.y, 3)
    @Expect(r.z, 13)
    @Expect(r.w, 8)
}

@Test
func testScalarDivZeroVec1(): Unit {
    let v = Vec1<Int64, Defaultp>(Int64(1))
    let r = div(Int64(0), v)
    @Expect(r.x, Int64(0))
}

@Test
func testScalarAddNegVec1(): Unit {
    let v = Vec1<Int64, Defaultp>(Int64(3))
    let r = add(Int64(-5), v)
    @Expect(r.x, Int64(-2))
}

@Test
func testScalarAddNegVec2(): Unit {
    let v = Vec2<Int64, Defaultp>(Int64(3), Int64(7))
    let r = add(Int64(-5), v)
    @Expect(r.x, Int64(-2))
    @Expect(r.y, Int64(2))
}

@Test
func testScalarMulOverflowVec1(): Unit {
    let v = Vec1<Int64, Defaultp>(Int64(9223372036854775807))
    let r = mul(Int64(2), v)
    @Expect(r.x, Int64(-2))
}

@Test
func testScalarSubNegVec1(): Unit {
    let v = Vec1<Int64, Defaultp>(Int64(3))
    let r = sub(Int64(-5), v)
    @Expect(r.x, Int64(-8))
}
