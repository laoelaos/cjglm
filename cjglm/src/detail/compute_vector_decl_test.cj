package glm.detail

import std.unittest.*
import std.unittest.testmacro.*

@Test
func testComputeVecAdd1(): Unit {
    let a = Vec1<Int64, Defaultp>(1)
    let b = Vec1<Int64, Defaultp>(2)
    let r = compute_vec_add1<Int64, Defaultp>.call(a, b)
    @Expect(r.x, 3)
}

@Test
func testComputeVecSub2(): Unit {
    let a = Vec2<Int64, Defaultp>(5, 10)
    let b = Vec2<Int64, Defaultp>(3, 4)
    let r = compute_vec_sub2<Int64, Defaultp>.call(a, b)
    @Expect(r.x, 2)
    @Expect(r.y, 6)
}

@Test
func testComputeVecMul3(): Unit {
    let a = Vec3<Int64, Defaultp>(2, 3, 4)
    let b = Vec3<Int64, Defaultp>(5, 6, 7)
    let r = compute_vec_mul3<Int64, Defaultp>.call(a, b)
    @Expect(r.x, 10)
    @Expect(r.y, 18)
    @Expect(r.z, 28)
}

@Test
func testComputeVecMod1(): Unit {
    let a = Vec1<Int64, Defaultp>(10)
    let b = Vec1<Int64, Defaultp>(3)
    let r = compute_vec_mod1<Int64, Defaultp>.call(a, b)
    @Expect(r.x, 1)
}

@Test
func testComputeVecMod4(): Unit {
    let a = Vec4<Int64, Defaultp>(10, 20, 30, 40)
    let b = Vec4<Int64, Defaultp>(3, 6, 7, 9)
    let r = compute_vec_mod4<Int64, Defaultp>.call(a, b)
    @Expect(r.x, 1)
    @Expect(r.y, 2)
    @Expect(r.z, 2)
    @Expect(r.w, 4)
}

@Test
func testComputeVecAnd1(): Unit {
    let a = Vec1<Int64, Defaultp>(6)
    let b = Vec1<Int64, Defaultp>(3)
    let r = compute_vec_and1<Int64, Defaultp>.call(a, b)
    @Expect(r.x, 2)
}

@Test
func testComputeVecAnd3(): Unit {
    let a = Vec3<Int64, Defaultp>(6, 3, 5)
    let b = Vec3<Int64, Defaultp>(3, 1, 4)
    let r = compute_vec_and3<Int64, Defaultp>.call(a, b)
    @Expect(r.x, 2)
    @Expect(r.y, 1)
    @Expect(r.z, 4)
}

@Test
func testComputeVecOr1(): Unit {
    let a = Vec1<Int64, Defaultp>(6)
    let b = Vec1<Int64, Defaultp>(3)
    let r = compute_vec_or1<Int64, Defaultp>.call(a, b)
    @Expect(r.x, 7)
}

@Test
func testComputeVecOr2(): Unit {
    let a = Vec2<Int64, Defaultp>(6, 3)
    let b = Vec2<Int64, Defaultp>(3, 1)
    let r = compute_vec_or2<Int64, Defaultp>.call(a, b)
    @Expect(r.x, 7)
    @Expect(r.y, 3)
}

@Test
func testComputeVecXor1(): Unit {
    let a = Vec1<Int64, Defaultp>(6)
    let b = Vec1<Int64, Defaultp>(3)
    let r = compute_vec_xor1<Int64, Defaultp>.call(a, b)
    @Expect(r.x, 5)
}

@Test
func testComputeVecXor4(): Unit {
    let a = Vec4<Int64, Defaultp>(6, 3, 5, 7)
    let b = Vec4<Int64, Defaultp>(3, 1, 4, 2)
    let r = compute_vec_xor4<Int64, Defaultp>.call(a, b)
    @Expect(r.x, 5)
    @Expect(r.y, 2)
    @Expect(r.z, 1)
    @Expect(r.w, 5)
}

@Test
func testComputeVecShiftLeft1(): Unit {
    let a = Vec1<Int64, Defaultp>(8)
    let b = Vec1<Int64, Defaultp>(2)
    let r = compute_vec_shift_left1<Int64, Defaultp>.call(a, b)
    @Expect(r.x, 32)
}

@Test
func testComputeVecShiftLeft3(): Unit {
    let a = Vec3<Int64, Defaultp>(8, 16, 32)
    let b = Vec3<Int64, Defaultp>(2, 1, 0)
    let r = compute_vec_shift_left3<Int64, Defaultp>.call(a, b)
    @Expect(r.x, 32)
    @Expect(r.y, 32)
    @Expect(r.z, 32)
}

@Test
func testComputeVecShiftRight1(): Unit {
    let a = Vec1<Int64, Defaultp>(8)
    let b = Vec1<Int64, Defaultp>(2)
    let r = compute_vec_shift_right1<Int64, Defaultp>.call(a, b)
    @Expect(r.x, 2)
}

@Test
func testComputeVecShiftRight4(): Unit {
    let a = Vec4<Int64, Defaultp>(32, 64, 128, 256)
    let b = Vec4<Int64, Defaultp>(2, 3, 4, 5)
    let r = compute_vec_shift_right4<Int64, Defaultp>.call(a, b)
    @Expect(r.x, 8)
    @Expect(r.y, 8)
    @Expect(r.z, 8)
    @Expect(r.w, 8)
}

@Test
func testComputeVecEqual1(): Unit {
    let a = Vec1<Int64, Defaultp>(1)
    let b = Vec1<Int64, Defaultp>(1)
    let c = Vec1<Int64, Defaultp>(2)
    let r1 = compute_vec_equal1<Int64, Defaultp>.call(a, b)
    let r2 = compute_vec_equal1<Int64, Defaultp>.call(a, c)
    @Expect(r1.x, true)
    @Expect(r2.x, false)
}

@Test
func testComputeVecNequal4(): Unit {
    let a = Vec4<Int64, Defaultp>(1, 2, 3, 4)
    let b = Vec4<Int64, Defaultp>(1, 2, 0, 4)
    let r = compute_vec_nequal4<Int64, Defaultp>.call(a, b)
    @Expect(r.x, false)
    @Expect(r.y, false)
    @Expect(r.z, true)
    @Expect(r.w, false)
}

@Test
func testComputeVecBitwiseNot1(): Unit {
    let a = Vec1<Int64, Defaultp>(0)
    let r = compute_vec_bitwise_not1<Int64, Defaultp>.call(a)
    @Expect(r.x, !0)
}

@Test
func testComputeVecBitwiseNot3(): Unit {
    let a = Vec3<Int64, Defaultp>(0, -1, 1)
    let r = compute_vec_bitwise_not3<Int64, Defaultp>.call(a)
    @Expect(r.x, !0)
    @Expect(r.y, !(-1))
    @Expect(r.z, !1)
}

@Test
func testComputeVecAdd4(): Unit {
    let a = Vec4<Int64, Defaultp>(1, 2, 3, 4)
    let b = Vec4<Int64, Defaultp>(10, 20, 30, 40)
    let r = compute_vec_add4<Int64, Defaultp>.call(a, b)
    @Expect(r.x, 11)
    @Expect(r.y, 22)
    @Expect(r.z, 33)
    @Expect(r.w, 44)
}

@Test
func testComputeVecSub1(): Unit {
    let a = Vec1<Int64, Defaultp>(10)
    let b = Vec1<Int64, Defaultp>(3)
    let r = compute_vec_sub1<Int64, Defaultp>.call(a, b)
    @Expect(r.x, 7)
}

@Test
func testComputeVecSub3(): Unit {
    let a = Vec3<Int64, Defaultp>(10, 20, 30)
    let b = Vec3<Int64, Defaultp>(1, 2, 3)
    let r = compute_vec_sub3<Int64, Defaultp>.call(a, b)
    @Expect(r.x, 9)
    @Expect(r.y, 18)
    @Expect(r.z, 27)
}

@Test
func testComputeVecMul1(): Unit {
    let a = Vec1<Int64, Defaultp>(5)
    let b = Vec1<Int64, Defaultp>(6)
    let r = compute_vec_mul1<Int64, Defaultp>.call(a, b)
    @Expect(r.x, 30)
}

@Test
func testComputeVecMul2(): Unit {
    let a = Vec2<Int64, Defaultp>(2, 3)
    let b = Vec2<Int64, Defaultp>(4, 5)
    let r = compute_vec_mul2<Int64, Defaultp>.call(a, b)
    @Expect(r.x, 8)
    @Expect(r.y, 15)
}

@Test
func testComputeVecDiv1(): Unit {
    let a = Vec1<Int64, Defaultp>(10)
    let b = Vec1<Int64, Defaultp>(3)
    let r = compute_vec_div1<Int64, Defaultp>.call(a, b)
    @Expect(r.x, 3)
}

@Test
func testComputeVecDiv2(): Unit {
    let a = Vec2<Int64, Defaultp>(10, 20)
    let b = Vec2<Int64, Defaultp>(3, 4)
    let r = compute_vec_div2<Int64, Defaultp>.call(a, b)
    @Expect(r.x, 3)
    @Expect(r.y, 5)
}

@Test
func testComputeVecDiv4(): Unit {
    let a = Vec4<Int64, Defaultp>(10, 20, 30, 40)
    let b = Vec4<Int64, Defaultp>(3, 4, 5, 6)
    let r = compute_vec_div4<Int64, Defaultp>.call(a, b)
    @Expect(r.x, 3)
    @Expect(r.y, 5)
    @Expect(r.z, 6)
    @Expect(r.w, 6)
}

@Test
func testComputeVecEqual2(): Unit {
    let a = Vec2<Int64, Defaultp>(1, 2)
    let b = Vec2<Int64, Defaultp>(1, 0)
    let r = compute_vec_equal2<Int64, Defaultp>.call(a, b)
    @Expect(r.x, true)
    @Expect(r.y, false)
}

@Test
func testComputeVecEqual3(): Unit {
    let a = Vec3<Int64, Defaultp>(1, 2, 3)
    let b = Vec3<Int64, Defaultp>(1, 0, 3)
    let r = compute_vec_equal3<Int64, Defaultp>.call(a, b)
    @Expect(r.x, true)
    @Expect(r.y, false)
    @Expect(r.z, true)
}

@Test
func testComputeVecEqual4(): Unit {
    let a = Vec4<Int64, Defaultp>(1, 2, 3, 4)
    let b = Vec4<Int64, Defaultp>(1, 2, 3, 0)
    let r = compute_vec_equal4<Int64, Defaultp>.call(a, b)
    @Expect(r.x, true)
    @Expect(r.y, true)
    @Expect(r.z, true)
    @Expect(r.w, false)
}

@Test
func testComputeVecNequal1(): Unit {
    let a = Vec1<Int64, Defaultp>(1)
    let b = Vec1<Int64, Defaultp>(2)
    let r = compute_vec_nequal1<Int64, Defaultp>.call(a, b)
    @Expect(r.x, true)
}

@Test
func testComputeVecNequal2(): Unit {
    let a = Vec2<Int64, Defaultp>(1, 2)
    let b = Vec2<Int64, Defaultp>(1, 0)
    let r = compute_vec_nequal2<Int64, Defaultp>.call(a, b)
    @Expect(r.x, false)
    @Expect(r.y, true)
}

@Test
func testComputeVecBitwiseNot4(): Unit {
    let a = Vec4<Int64, Defaultp>(0, -1, 1, 0)
    let r = compute_vec_bitwise_not4<Int64, Defaultp>.call(a)
    @Expect(r.x, !0)
    @Expect(r.y, !(-1))
    @Expect(r.z, !1)
    @Expect(r.w, !0)
}

@Test
func testComputeVecAddFloat32(): Unit {
    let a = Vec1<Float32, Defaultp>(1.0f32)
    let b = Vec1<Float32, Defaultp>(2.0f32)
    let r = compute_vec_add1<Float32, Defaultp>.call(a, b)
    @Expect(r.x, 3.0f32)
}

@Test
func testComputeVecAddFloat32Vec3(): Unit {
    let a = Vec3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32)
    let b = Vec3<Float32, Defaultp>(4.0f32, 5.0f32, 6.0f32)
    let r = compute_vec_add3<Float32, Defaultp>.call(a, b)
    @Expect(r.x, 5.0f32)
    @Expect(r.y, 7.0f32)
    @Expect(r.z, 9.0f32)
}

@Test
func testComputeVecSubFloat32(): Unit {
    let a = Vec1<Float32, Defaultp>(5.0f32)
    let b = Vec1<Float32, Defaultp>(3.0f32)
    let r = compute_vec_sub1<Float32, Defaultp>.call(a, b)
    @Expect(r.x, 2.0f32)
}

@Test
func testComputeVecSubFloat32Vec4(): Unit {
    let a = Vec4<Float32, Defaultp>(5.0f32, 7.0f32, 9.0f32, 11.0f32)
    let b = Vec4<Float32, Defaultp>(3.0f32, 2.0f32, 1.0f32, 0.5f32)
    let r = compute_vec_sub4<Float32, Defaultp>.call(a, b)
    @Expect(r.x, 2.0f32)
    @Expect(r.y, 5.0f32)
    @Expect(r.z, 8.0f32)
    @Expect(r.w, 10.5f32)
}
