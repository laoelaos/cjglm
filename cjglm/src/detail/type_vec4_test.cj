package glm.detail

import std.unittest.*
import std.unittest.testmacro.*

@Test
func testVec4ScalarInit(): Unit {
    let v = Vec4<Int64, Defaultp>(7)
    @Expect(v.x, 7)
    @Expect(v.y, 7)
    @Expect(v.z, 7)
    @Expect(v.w, 7)
}

@Test
func testVec4ConstInit(): Unit {
    let v = Vec4<Int64, Defaultp>(1, 2, 3, 4)
    @Expect(v.x, 1)
    @Expect(v.y, 2)
    @Expect(v.z, 3)
    @Expect(v.w, 4)
}

@Test
func testVec4Length(): Unit {
    @Expect(Vec4<Int64, Defaultp>.length(), 4)
}

@Test
func testVec4Add(): Unit {
    let a = Vec4<Int64, Defaultp>(1, 2, 3, 4)
    let b = Vec4<Int64, Defaultp>(10, 20, 30, 40)
    let r = a + b
    @Expect(r.x, 11)
    @Expect(r.y, 22)
    @Expect(r.z, 33)
    @Expect(r.w, 44)
}

@Test
func testVec4ScalarMul(): Unit {
    let v = Vec4<Int64, Defaultp>(2, 3, 4, 5)
    let r = v * Int64(5)
    @Expect(r.x, 10)
    @Expect(r.y, 15)
    @Expect(r.z, 20)
    @Expect(r.w, 25)
}

@Test
func testVec4Negate(): Unit {
    let v = Vec4<Int64, Defaultp>(1, -2, 3, -4)
    let r = -v
    @Expect(r.x, -1)
    @Expect(r.y, 2)
    @Expect(r.z, -3)
    @Expect(r.w, 4)
}

@Test
func testVec4IndexAccess(): Unit {
    let v = Vec4<Int64, Defaultp>(10, 20, 30, 40)
    @Expect(v[Int64(0)], 10)
    @Expect(v[Int64(1)], 20)
    @Expect(v[Int64(2)], 30)
    @Expect(v[Int64(3)], 40)
}

@Test
func testVec4IndexMutate(): Unit {
    var v = Vec4<Int64, Defaultp>(10, 20, 30, 40)
    v[Int64(3)] = 99
    @Expect(v[Int64(3)], 99)
}

@Test
func testVec4ComponentAt(): Unit {
    let v = Vec4<Int64, Defaultp>(10, 20, 30, 40)
    @Expect(v.componentAt(Int64(0)), 10)
    @Expect(v.componentAt(Int64(1)), 20)
    @Expect(v.componentAt(Int64(2)), 30)
    @Expect(v.componentAt(Int64(3)), 40)
}

@Test
func testVec4Equal(): Unit {
    let a = Vec4<Int64, Defaultp>(1, 2, 3, 4)
    let b = Vec4<Int64, Defaultp>(1, 2, 3, 4)
    @Expect(a == b, true)
}

@Test
func testVec4NotEqual(): Unit {
    let a = Vec4<Int64, Defaultp>(1, 2, 3, 4)
    let b = Vec4<Int64, Defaultp>(1, 2, 0, 4)
    @Expect(a != b, true)
}

@Test
func testVec4EqualExact(): Unit {
    let a = Vec4<Int64, Defaultp>(1, 2, 3, 4)
    let b = Vec4<Int64, Defaultp>(1, 2, 3, 4)
    @Expect(a.equalExact(b), true)
}

@Test
func testVec4BitwiseAnd(): Unit {
    let a = Vec4<Int64, Defaultp>(6, 3, 5, 7)
    let b = Vec4<Int64, Defaultp>(3, 1, 4, 2)
    let r = a & b
    @Expect(r.x, 2)
    @Expect(r.y, 1)
    @Expect(r.z, 4)
    @Expect(r.w, 2)
}

@Test
func testVec4BitwiseNot(): Unit {
    let a = Vec4<Int64, Defaultp>(0, -1, 1, 0)
    let r = a.bitwiseNot()
    @Expect(r.x, !0)
    @Expect(r.y, !(-1))
    @Expect(r.z, !1)
    @Expect(r.w, !0)
}

@Test
func testVec4Vec1ArithBroadcast(): Unit {
    let a = Vec4<Int64, Defaultp>(10, 20, 30, 40)
    let b = Vec1<Int64, Defaultp>(3)
    let r = a + b
    @Expect(r.x, 13)
    @Expect(r.y, 23)
    @Expect(r.z, 33)
    @Expect(r.w, 43)
}

@Test
func testVec4ShiftLeft(): Unit {
    let v = Vec4<Int64, Defaultp>(1, 2, 4, 8)
    let r = v << Int64(3)
    @Expect(r.x, 8)
    @Expect(r.y, 16)
    @Expect(r.z, 32)
    @Expect(r.w, 64)
}

@Test
func testVec4BoolLogicalAnd(): Unit {
    let a = Vec4<Bool, Defaultp>(true, false, true, false)
    let b = Vec4<Bool, Defaultp>(true, true, false, false)
    let r = a.logicalAnd(b)
    @Expect(r.x, true)
    @Expect(r.y, false)
    @Expect(r.z, false)
    @Expect(r.w, false)
}

@Test
func testVec4Sub(): Unit {
    let a = Vec4<Int64, Defaultp>(10, 20, 30, 40)
    let b = Vec4<Int64, Defaultp>(3, 4, 5, 6)
    let r = a - b
    @Expect(r.x, 7)
    @Expect(r.y, 16)
    @Expect(r.z, 25)
    @Expect(r.w, 34)
}

@Test
func testVec4Div(): Unit {
    let a = Vec4<Int64, Defaultp>(10, 20, 30, 40)
    let b = Vec4<Int64, Defaultp>(3, 4, 5, 6)
    let r = a / b
    @Expect(r.x, 3)
    @Expect(r.y, 5)
    @Expect(r.z, 6)
    @Expect(r.w, 6)
}

@Test
func testVec4Mod(): Unit {
    let a = Vec4<Int64, Defaultp>(10, 20, 30, 40)
    let b = Vec4<Int64, Defaultp>(3, 6, 7, 9)
    let r = a % b
    @Expect(r.x, 1)
    @Expect(r.y, 2)
    @Expect(r.z, 2)
    @Expect(r.w, 4)
}

@Test
func testVec4ScalarSub(): Unit {
    let v = Vec4<Int64, Defaultp>(10, 20, 30, 40)
    let r = v - Int64(3)
    @Expect(r.x, 7)
    @Expect(r.y, 17)
    @Expect(r.z, 27)
    @Expect(r.w, 37)
}

@Test
func testVec4ScalarDiv(): Unit {
    let v = Vec4<Int64, Defaultp>(10, 20, 30, 40)
    let r = v / Int64(3)
    @Expect(r.x, 3)
    @Expect(r.y, 6)
    @Expect(r.z, 10)
    @Expect(r.w, 13)
}

@Test
func testVec4ScalarMod(): Unit {
    let v = Vec4<Int64, Defaultp>(10, 20, 30, 40)
    let r = v % Int64(3)
    @Expect(r.x, 1)
    @Expect(r.y, 2)
    @Expect(r.z, 0)
    @Expect(r.w, 1)
}

@Test
func testVec4BoolLogicalOr(): Unit {
    let a = Vec4<Bool, Defaultp>(true, false, true, false)
    let b = Vec4<Bool, Defaultp>(false, false, true, true)
    let r = a.logicalOr(b)
    @Expect(r.x, true)
    @Expect(r.y, false)
    @Expect(r.z, true)
    @Expect(r.w, true)
}

@Test
func testVec4EqualEpsilon(): Unit {
    let a = Vec4<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let b = Vec4<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    @Expect(a.equalEpsilon(b), true)
}

@Test
func testVec4AddNamed(): Unit {
    let v = Vec4<Int64, Defaultp>(1, 2, 3, 4)
    let r = v.add(Int64(5))
    @Expect(r.x, 6)
    @Expect(r.y, 7)
    @Expect(r.z, 8)
    @Expect(r.w, 9)
}

@Test
func testVec4MulNamed(): Unit {
    let v = Vec4<Int64, Defaultp>(2, 3, 4, 5)
    let r = v.mul(Int64(5))
    @Expect(r.x, 10)
    @Expect(r.y, 15)
    @Expect(r.z, 20)
    @Expect(r.w, 25)
}

@Test
func testVec4DivNamed(): Unit {
    let v = Vec4<Int64, Defaultp>(10, 20, 30, 40)
    let r = v.div(Int64(3))
    @Expect(r.x, 3)
    @Expect(r.y, 6)
    @Expect(r.z, 10)
    @Expect(r.w, 13)
}

@Test
func testVec4ModNamed(): Unit {
    let v = Vec4<Int64, Defaultp>(10, 20, 30, 40)
    let r = v.mod(Int64(3))
    @Expect(r.x, 1)
    @Expect(r.y, 2)
    @Expect(r.z, 0)
    @Expect(r.w, 1)
}

@Test
func testVec4BitwiseOr(): Unit {
    let a = Vec4<Int64, Defaultp>(6, 3, 5, 7)
    let b = Vec4<Int64, Defaultp>(3, 1, 4, 2)
    let r = a | b
    @Expect(r.x, 7)
    @Expect(r.y, 3)
    @Expect(r.z, 5)
    @Expect(r.w, 7)
}

@Test
func testVec4BitwiseXor(): Unit {
    let a = Vec4<Int64, Defaultp>(6, 3, 5, 7)
    let b = Vec4<Int64, Defaultp>(3, 1, 4, 2)
    let r = a ^ b
    @Expect(r.x, 5)
    @Expect(r.y, 2)
    @Expect(r.z, 1)
    @Expect(r.w, 5)
}

@Test
func testVec4ScalarBitwiseAnd(): Unit {
    let a = Vec4<Int64, Defaultp>(6, 3, 5, 7)
    let r = a & Int64(3)
    @Expect(r.x, 2)
    @Expect(r.y, 3)
    @Expect(r.z, 1)
    @Expect(r.w, 3)
}

@Test
func testVec4ShiftRight(): Unit {
    let v = Vec4<Int64, Defaultp>(32, 64, 128, 256)
    let r = v >> Int64(2)
    @Expect(r.x, 8)
    @Expect(r.y, 16)
    @Expect(r.z, 32)
    @Expect(r.w, 64)
}

@Test
func testVec4Vec1BitBroadcast(): Unit {
    let a = Vec4<Int64, Defaultp>(6, 3, 5, 7)
    let b = Vec1<Int64, Defaultp>(3)
    let r = a & b
    @Expect(r.x, 2)
    @Expect(r.y, 3)
    @Expect(r.z, 1)
    @Expect(r.w, 3)
}

@Test
func testVec4ShiftRightVec1(): Unit {
    let a = Vec4<Int64, Defaultp>(32, 64, 128, 256)
    let b = Vec1<Int64, Defaultp>(2)
    let r = a >> b
    @Expect(r.x, 8)
    @Expect(r.y, 16)
    @Expect(r.z, 32)
    @Expect(r.w, 64)
}

@Test
func testVec4FromVec1(): Unit {
    let v1 = Vec1<Int64, Defaultp>(5)
    let v4 = Vec4(v1)
    @Expect(v4.x, 5)
    @Expect(v4.y, 5)
    @Expect(v4.z, 5)
    @Expect(v4.w, 5)
}

@Test
func testVec4ScalarBitwiseOr(): Unit {
    let a = Vec4<Int64, Defaultp>(6, 3, 5, 7)
    let r = a | Int64(3)
    @Expect(r.x, 7)
    @Expect(r.y, 3)
    @Expect(r.z, 7)
    @Expect(r.w, 7)
}

@Test
func testVec4ScalarBitwiseXor(): Unit {
    let a = Vec4<Int64, Defaultp>(6, 3, 5, 7)
    let r = a ^ Int64(3)
    @Expect(r.x, 5)
    @Expect(r.y, 0)
    @Expect(r.z, 6)
    @Expect(r.w, 4)
}

@Test
func testVec4Vec1BitOrBroadcast(): Unit {
    let a = Vec4<Int64, Defaultp>(6, 3, 5, 7)
    let b = Vec1<Int64, Defaultp>(3)
    let r = a | b
    @Expect(r.x, 7)
    @Expect(r.y, 3)
    @Expect(r.z, 7)
    @Expect(r.w, 7)
}

@Test
func testVec4Vec1BitXorBroadcast(): Unit {
    let a = Vec4<Int64, Defaultp>(6, 3, 5, 7)
    let b = Vec1<Int64, Defaultp>(3)
    let r = a ^ b
    @Expect(r.x, 5)
    @Expect(r.y, 0)
    @Expect(r.z, 6)
    @Expect(r.w, 4)
}

@Test
func testVec4ShiftLeftVec1(): Unit {
    let a = Vec4<Int64, Defaultp>(1, 2, 4, 8)
    let b = Vec1<Int64, Defaultp>(3)
    let r = a << b
    @Expect(r.x, 8)
    @Expect(r.y, 16)
    @Expect(r.z, 32)
    @Expect(r.w, 64)
}

@Test
func testVec4ShiftLeftVec(): Unit {
    let a = Vec4<Int64, Defaultp>(1, 2, 4, 8)
    let b = Vec4<Int64, Defaultp>(3, 2, 1, 0)
    let r = a << b
    @Expect(r.x, 8)
    @Expect(r.y, 8)
    @Expect(r.z, 8)
    @Expect(r.w, 8)
}

@Test
func testVec4ShiftRightVec(): Unit {
    let a = Vec4<Int64, Defaultp>(32, 64, 128, 256)
    let b = Vec4<Int64, Defaultp>(2, 3, 4, 5)
    let r = a >> b
    @Expect(r.x, 8)
    @Expect(r.y, 8)
    @Expect(r.z, 8)
    @Expect(r.w, 8)
}

@Test
func testVec4Increment(): Unit {
    var v = Vec4<Int64, Defaultp>(5, 10, 15, 20)
    v.increment()
    @Expect(v.x, 6)
    @Expect(v.y, 11)
    @Expect(v.z, 16)
    @Expect(v.w, 21)
}

@Test
func testVec4Decrement(): Unit {
    var v = Vec4<Int64, Defaultp>(5, 10, 15, 20)
    v.decrement()
    @Expect(v.x, 4)
    @Expect(v.y, 9)
    @Expect(v.z, 14)
    @Expect(v.w, 19)
}

@Test
func testVec4IndexOutOfBoundsAccess(): Unit {
    let v = Vec4<Int64, Defaultp>(1, 2, 3, 4)
    try {
        let _ = v[Int64(4)]
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}

@Test
func testVec4NegativeIndexAccess(): Unit {
    let v = Vec4<Int64, Defaultp>(1, 2, 3, 4)
    try {
        let _ = v[Int64(-1)]
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}
