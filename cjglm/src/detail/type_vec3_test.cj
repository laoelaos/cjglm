package glm.detail

import std.unittest.*
import std.unittest.testmacro.*

@Test
func testVec3ScalarInit(): Unit {
    let v = Vec3<Int64, Defaultp>(7)
    @Expect(v.x, 7)
    @Expect(v.y, 7)
    @Expect(v.z, 7)
}

@Test
func testVec3ConstInit(): Unit {
    let v = Vec3<Int64, Defaultp>(1, 2, 3)
    @Expect(v.x, 1)
    @Expect(v.y, 2)
    @Expect(v.z, 3)
}

@Test
func testVec3Length(): Unit {
    @Expect(Vec3<Int64, Defaultp>.length(), 3)
}

@Test
func testVec3Add(): Unit {
    let a = Vec3<Int64, Defaultp>(1, 2, 3)
    let b = Vec3<Int64, Defaultp>(10, 20, 30)
    let r = a + b
    @Expect(r.x, 11)
    @Expect(r.y, 22)
    @Expect(r.z, 33)
}

@Test
func testVec3ScalarMul(): Unit {
    let v = Vec3<Int64, Defaultp>(2, 3, 4)
    let r = v * Int64(5)
    @Expect(r.x, 10)
    @Expect(r.y, 15)
    @Expect(r.z, 20)
}

@Test
func testVec3Negate(): Unit {
    let v = Vec3<Int64, Defaultp>(1, -2, 3)
    let r = -v
    @Expect(r.x, -1)
    @Expect(r.y, 2)
    @Expect(r.z, -3)
}

@Test
func testVec3IndexAccess(): Unit {
    let v = Vec3<Int64, Defaultp>(10, 20, 30)
    @Expect(v[Int64(0)], 10)
    @Expect(v[Int64(1)], 20)
    @Expect(v[Int64(2)], 30)
}

@Test
func testVec3IndexMutate(): Unit {
    var v = Vec3<Int64, Defaultp>(10, 20, 30)
    v[Int64(2)] = 99
    @Expect(v[Int64(2)], 99)
}

@Test
func testVec3ComponentAt(): Unit {
    let v = Vec3<Int64, Defaultp>(10, 20, 30)
    @Expect(v.componentAt(Int64(0)), 10)
    @Expect(v.componentAt(Int64(1)), 20)
    @Expect(v.componentAt(Int64(2)), 30)
}

@Test
func testVec3Equal(): Unit {
    let a = Vec3<Int64, Defaultp>(1, 2, 3)
    let b = Vec3<Int64, Defaultp>(1, 2, 3)
    @Expect(a == b, true)
}

@Test
func testVec3NotEqual(): Unit {
    let a = Vec3<Int64, Defaultp>(1, 2, 3)
    let b = Vec3<Int64, Defaultp>(1, 2, 0)
    @Expect(a != b, true)
}

@Test
func testVec3EqualExact(): Unit {
    let a = Vec3<Int64, Defaultp>(1, 2, 3)
    let b = Vec3<Int64, Defaultp>(1, 2, 3)
    @Expect(a.equalExact(b), true)
}

@Test
func testVec3BitwiseAnd(): Unit {
    let a = Vec3<Int64, Defaultp>(6, 3, 5)
    let b = Vec3<Int64, Defaultp>(3, 1, 4)
    let r = a & b
    @Expect(r.x, 2)
    @Expect(r.y, 1)
    @Expect(r.z, 4)
}

@Test
func testVec3BitwiseNot(): Unit {
    let a = Vec3<Int64, Defaultp>(0, -1, 1)
    let r = a.bitwiseNot()
    @Expect(r.x, !0)
    @Expect(r.y, !(-1))
    @Expect(r.z, !1)
}

@Test
func testVec3Vec1ArithBroadcast(): Unit {
    let a = Vec3<Int64, Defaultp>(10, 20, 30)
    let b = Vec1<Int64, Defaultp>(3)
    let r = a + b
    @Expect(r.x, 13)
    @Expect(r.y, 23)
    @Expect(r.z, 33)
}

@Test
func testVec3ShiftLeft(): Unit {
    let v = Vec3<Int64, Defaultp>(8, 16, 32)
    let r = v << Int64(2)
    @Expect(r.x, 32)
    @Expect(r.y, 64)
    @Expect(r.z, 128)
}

@Test
func testVec3BoolLogicalAnd(): Unit {
    let a = Vec3<Bool, Defaultp>(true, false, true)
    let b = Vec3<Bool, Defaultp>(true, true, false)
    let r = a.logicalAnd(b)
    @Expect(r.x, true)
    @Expect(r.y, false)
    @Expect(r.z, false)
}

@Test
func testVec3Sub(): Unit {
    let a = Vec3<Int64, Defaultp>(10, 20, 30)
    let b = Vec3<Int64, Defaultp>(3, 4, 5)
    let r = a - b
    @Expect(r.x, 7)
    @Expect(r.y, 16)
    @Expect(r.z, 25)
}

@Test
func testVec3Div(): Unit {
    let a = Vec3<Int64, Defaultp>(10, 20, 30)
    let b = Vec3<Int64, Defaultp>(3, 4, 5)
    let r = a / b
    @Expect(r.x, 3)
    @Expect(r.y, 5)
    @Expect(r.z, 6)
}

@Test
func testVec3Mod(): Unit {
    let a = Vec3<Int64, Defaultp>(10, 20, 30)
    let b = Vec3<Int64, Defaultp>(3, 6, 7)
    let r = a % b
    @Expect(r.x, 1)
    @Expect(r.y, 2)
    @Expect(r.z, 2)
}

@Test
func testVec3ScalarSub(): Unit {
    let v = Vec3<Int64, Defaultp>(10, 20, 30)
    let r = v - Int64(3)
    @Expect(r.x, 7)
    @Expect(r.y, 17)
    @Expect(r.z, 27)
}

@Test
func testVec3ScalarDiv(): Unit {
    let v = Vec3<Int64, Defaultp>(10, 20, 30)
    let r = v / Int64(3)
    @Expect(r.x, 3)
    @Expect(r.y, 6)
    @Expect(r.z, 10)
}

@Test
func testVec3ScalarMod(): Unit {
    let v = Vec3<Int64, Defaultp>(10, 20, 30)
    let r = v % Int64(3)
    @Expect(r.x, 1)
    @Expect(r.y, 2)
    @Expect(r.z, 0)
}

@Test
func testVec3BoolLogicalOr(): Unit {
    let a = Vec3<Bool, Defaultp>(true, false, true)
    let b = Vec3<Bool, Defaultp>(false, false, true)
    let r = a.logicalOr(b)
    @Expect(r.x, true)
    @Expect(r.y, false)
    @Expect(r.z, true)
}

@Test
func testVec3EqualEpsilon(): Unit {
    let a = Vec3<Float64, Defaultp>(1.0, 2.0, 3.0)
    let b = Vec3<Float64, Defaultp>(1.0, 2.0, 3.0)
    @Expect(a.equalEpsilon(b), true)
}

@Test
func testVec3AddNamed(): Unit {
    let v = Vec3<Int64, Defaultp>(1, 2, 3)
    let r = v.add(Int64(5))
    @Expect(r.x, 6)
    @Expect(r.y, 7)
    @Expect(r.z, 8)
}

@Test
func testVec3MulNamed(): Unit {
    let v = Vec3<Int64, Defaultp>(2, 3, 4)
    let r = v.mul(Int64(5))
    @Expect(r.x, 10)
    @Expect(r.y, 15)
    @Expect(r.z, 20)
}

@Test
func testVec3DivNamed(): Unit {
    let v = Vec3<Int64, Defaultp>(10, 20, 30)
    let r = v.div(Int64(3))
    @Expect(r.x, 3)
    @Expect(r.y, 6)
    @Expect(r.z, 10)
}

@Test
func testVec3ModNamed(): Unit {
    let v = Vec3<Int64, Defaultp>(10, 20, 30)
    let r = v.mod(Int64(3))
    @Expect(r.x, 1)
    @Expect(r.y, 2)
    @Expect(r.z, 0)
}

@Test
func testVec3BitwiseOr(): Unit {
    let a = Vec3<Int64, Defaultp>(6, 3, 5)
    let b = Vec3<Int64, Defaultp>(3, 1, 4)
    let r = a | b
    @Expect(r.x, 7)
    @Expect(r.y, 3)
    @Expect(r.z, 5)
}

@Test
func testVec3BitwiseXor(): Unit {
    let a = Vec3<Int64, Defaultp>(6, 3, 5)
    let b = Vec3<Int64, Defaultp>(3, 1, 4)
    let r = a ^ b
    @Expect(r.x, 5)
    @Expect(r.y, 2)
    @Expect(r.z, 1)
}

@Test
func testVec3ScalarBitwiseAnd(): Unit {
    let a = Vec3<Int64, Defaultp>(6, 3, 5)
    let r = a & Int64(3)
    @Expect(r.x, 2)
    @Expect(r.y, 3)
    @Expect(r.z, 1)
}

@Test
func testVec3ShiftRight(): Unit {
    let v = Vec3<Int64, Defaultp>(32, 64, 128)
    let r = v >> Int64(2)
    @Expect(r.x, 8)
    @Expect(r.y, 16)
    @Expect(r.z, 32)
}

@Test
func testVec3Vec1BitBroadcast(): Unit {
    let a = Vec3<Int64, Defaultp>(6, 3, 5)
    let b = Vec1<Int64, Defaultp>(3)
    let r = a & b
    @Expect(r.x, 2)
    @Expect(r.y, 3)
    @Expect(r.z, 1)
}

@Test
func testVec3ShiftRightVec1(): Unit {
    let a = Vec3<Int64, Defaultp>(32, 64, 128)
    let b = Vec1<Int64, Defaultp>(2)
    let r = a >> b
    @Expect(r.x, 8)
    @Expect(r.y, 16)
    @Expect(r.z, 32)
}

@Test
func testVec3FromVec1(): Unit {
    let v1 = Vec1<Int64, Defaultp>(5)
    let v3 = Vec3(v1)
    @Expect(v3.x, 5)
    @Expect(v3.y, 5)
    @Expect(v3.z, 5)
}

@Test
func testVec3ScalarBitwiseOr(): Unit {
    let a = Vec3<Int64, Defaultp>(6, 3, 5)
    let r = a | Int64(3)
    @Expect(r.x, 7)
    @Expect(r.y, 3)
    @Expect(r.z, 7)
}

@Test
func testVec3ScalarBitwiseXor(): Unit {
    let a = Vec3<Int64, Defaultp>(6, 3, 5)
    let r = a ^ Int64(3)
    @Expect(r.x, 5)
    @Expect(r.y, 0)
    @Expect(r.z, 6)
}

@Test
func testVec3Vec1BitOrBroadcast(): Unit {
    let a = Vec3<Int64, Defaultp>(6, 3, 5)
    let b = Vec1<Int64, Defaultp>(3)
    let r = a | b
    @Expect(r.x, 7)
    @Expect(r.y, 3)
    @Expect(r.z, 7)
}

@Test
func testVec3Vec1BitXorBroadcast(): Unit {
    let a = Vec3<Int64, Defaultp>(6, 3, 5)
    let b = Vec1<Int64, Defaultp>(3)
    let r = a ^ b
    @Expect(r.x, 5)
    @Expect(r.y, 0)
    @Expect(r.z, 6)
}

@Test
func testVec3ShiftLeftVec1(): Unit {
    let a = Vec3<Int64, Defaultp>(8, 16, 32)
    let b = Vec1<Int64, Defaultp>(2)
    let r = a << b
    @Expect(r.x, 32)
    @Expect(r.y, 64)
    @Expect(r.z, 128)
}

@Test
func testVec3ShiftLeftVec(): Unit {
    let a = Vec3<Int64, Defaultp>(8, 16, 32)
    let b = Vec3<Int64, Defaultp>(2, 1, 0)
    let r = a << b
    @Expect(r.x, 32)
    @Expect(r.y, 32)
    @Expect(r.z, 32)
}

@Test
func testVec3ShiftRightVec(): Unit {
    let a = Vec3<Int64, Defaultp>(32, 64, 128)
    let b = Vec3<Int64, Defaultp>(2, 3, 4)
    let r = a >> b
    @Expect(r.x, 8)
    @Expect(r.y, 8)
    @Expect(r.z, 8)
}

@Test
func testVec3Increment(): Unit {
    var v = Vec3<Int64, Defaultp>(5, 10, 15)
    v.increment()
    @Expect(v.x, 6)
    @Expect(v.y, 11)
    @Expect(v.z, 16)
}

@Test
func testVec3Decrement(): Unit {
    var v = Vec3<Int64, Defaultp>(5, 10, 15)
    v.decrement()
    @Expect(v.x, 4)
    @Expect(v.y, 9)
    @Expect(v.z, 14)
}

@Test
func testVec3IndexOutOfBoundsAccess(): Unit {
    let v = Vec3<Int64, Defaultp>(1, 2, 3)
    try {
        let _ = v[Int64(3)]
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}

@Test
func testVec3NegativeIndexAccess(): Unit {
    let v = Vec3<Int64, Defaultp>(1, 2, 3)
    try {
        let _ = v[Int64(-1)]
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}
