package glm.detail

import std.unittest.*
import std.unittest.testmacro.*

@Test
func testVec1ConstInit(): Unit {
    let v = Vec1<Int64, Defaultp>(42)
    @Expect(v.x, 42)
}

@Test
func testVec1Length(): Unit {
    @Expect(Vec1<Int64, Defaultp>.length(), 1)
}

@Test
func testVec1IndexAccess(): Unit {
    let v = Vec1<Int64, Defaultp>(99)
    @Expect(v[Int64(0)], 99)
}

@Test
func testVec1IndexMutate(): Unit {
    var v = Vec1<Int64, Defaultp>(99)
    v[Int64(0)] = 42
    @Expect(v[Int64(0)], 42)
}

@Test
func testVec1ComponentAt(): Unit {
    let v = Vec1<Int64, Defaultp>(77)
    @Expect(v.componentAt(Int64(0)), 77)
}

@Test
func testVec1Add(): Unit {
    let a = Vec1<Int64, Defaultp>(1)
    let b = Vec1<Int64, Defaultp>(2)
    let r = a + b
    @Expect(r.x, 3)
}

@Test
func testVec1Sub(): Unit {
    let a = Vec1<Int64, Defaultp>(5)
    let b = Vec1<Int64, Defaultp>(3)
    let r = a - b
    @Expect(r.x, 2)
}

@Test
func testVec1Mul(): Unit {
    let a = Vec1<Int64, Defaultp>(3)
    let b = Vec1<Int64, Defaultp>(4)
    let r = a * b
    @Expect(r.x, 12)
}

@Test
func testVec1Div(): Unit {
    let a = Vec1<Int64, Defaultp>(10)
    let b = Vec1<Int64, Defaultp>(3)
    let r = a / b
    @Expect(r.x, 3)
}

@Test
func testVec1Mod(): Unit {
    let a = Vec1<Int64, Defaultp>(10)
    let b = Vec1<Int64, Defaultp>(3)
    let r = a % b
    @Expect(r.x, 1)
}

@Test
func testVec1ScalarAdd(): Unit {
    let v = Vec1<Int64, Defaultp>(5)
    let r = v + Int64(3)
    @Expect(r.x, 8)
}

@Test
func testVec1Negate(): Unit {
    let v = Vec1<Int64, Defaultp>(5)
    let r = -v
    @Expect(r.x, -5)
}

@Test
func testVec1AddNamed(): Unit {
    let v = Vec1<Int64, Defaultp>(5)
    let r = v.add(Int64(3))
    @Expect(r.x, 8)
}

@Test
func testVec1SubNamed(): Unit {
    let v = Vec1<Int64, Defaultp>(5)
    let r = v.sub(Int64(3))
    @Expect(r.x, 2)
}

@Test
func testVec1MulNamed(): Unit {
    let v = Vec1<Int64, Defaultp>(5)
    let r = v.mul(Int64(3))
    @Expect(r.x, 15)
}

@Test
func testVec1Equal(): Unit {
    let a = Vec1<Int64, Defaultp>(1)
    let b = Vec1<Int64, Defaultp>(1)
    @Expect(a == b, true)
}

@Test
func testVec1NotEqual(): Unit {
    let a = Vec1<Int64, Defaultp>(1)
    let b = Vec1<Int64, Defaultp>(2)
    @Expect(a != b, true)
}

@Test
func testVec1EqualExact(): Unit {
    let a = Vec1<Int64, Defaultp>(1)
    let b = Vec1<Int64, Defaultp>(1)
    @Expect(a.equalExact(b), true)
}

@Test
func testVec1BitwiseAnd(): Unit {
    let a = Vec1<Int64, Defaultp>(6)
    let b = Vec1<Int64, Defaultp>(3)
    let r = a & b
    @Expect(r.x, 2)
}

@Test
func testVec1BitwiseOr(): Unit {
    let a = Vec1<Int64, Defaultp>(6)
    let b = Vec1<Int64, Defaultp>(3)
    let r = a | b
    @Expect(r.x, 7)
}

@Test
func testVec1BitwiseXor(): Unit {
    let a = Vec1<Int64, Defaultp>(6)
    let b = Vec1<Int64, Defaultp>(3)
    let r = a ^ b
    @Expect(r.x, 5)
}

@Test
func testVec1ShiftLeft(): Unit {
    let a = Vec1<Int64, Defaultp>(8)
    let r = a << Int64(2)
    @Expect(r.x, 32)
}

@Test
func testVec1ShiftRight(): Unit {
    let a = Vec1<Int64, Defaultp>(8)
    let r = a >> Int64(2)
    @Expect(r.x, 2)
}

@Test
func testVec1BitwiseNot(): Unit {
    let a = Vec1<Int64, Defaultp>(0)
    let r = a.bitwiseNot()
    @Expect(r.x, !0)
}

@Test
func testVec1BoolLogicalAnd(): Unit {
    let a = Vec1<Bool, Defaultp>(true)
    let b = Vec1<Bool, Defaultp>(false)
    let r = a.logicalAnd(b)
    @Expect(r.x, false)
}

@Test
func testVec1BoolLogicalOr(): Unit {
    let a = Vec1<Bool, Defaultp>(true)
    let b = Vec1<Bool, Defaultp>(false)
    let r = a.logicalOr(b)
    @Expect(r.x, true)
}

@Test
func testVec1IndexOutOfBoundsAccess(): Unit {
    let v = Vec1<Int64, Defaultp>(1)
    try {
        let _ = v[Int64(1)]
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}

@Test
func testVec1ShiftVec(): Unit {
    let a = Vec1<Int64, Defaultp>(8)
    let b = Vec1<Int64, Defaultp>(2)
    let r = a << b
    @Expect(r.x, 32)
}

@Test
func testVec1ScalarSub(): Unit {
    let v = Vec1<Int64, Defaultp>(10)
    let r = v - Int64(3)
    @Expect(r.x, 7)
}

@Test
func testVec1ScalarMul(): Unit {
    let v = Vec1<Int64, Defaultp>(5)
    let r = v * Int64(4)
    @Expect(r.x, 20)
}

@Test
func testVec1ScalarDiv(): Unit {
    let v = Vec1<Int64, Defaultp>(10)
    let r = v / Int64(3)
    @Expect(r.x, 3)
}

@Test
func testVec1ScalarMod(): Unit {
    let v = Vec1<Int64, Defaultp>(10)
    let r = v % Int64(3)
    @Expect(r.x, 1)
}

@Test
func testVec1DivNamed(): Unit {
    let v = Vec1<Int64, Defaultp>(10)
    let r = v.div(Int64(3))
    @Expect(r.x, 3)
}

@Test
func testVec1ModNamed(): Unit {
    let v = Vec1<Int64, Defaultp>(10)
    let r = v.mod(Int64(3))
    @Expect(r.x, 1)
}

@Test
func testVec1ScalarBitwiseAnd(): Unit {
    let a = Vec1<Int64, Defaultp>(6)
    let r = a & Int64(3)
    @Expect(r.x, 2)
}

@Test
func testVec1ScalarBitwiseOr(): Unit {
    let a = Vec1<Int64, Defaultp>(6)
    let r = a | Int64(3)
    @Expect(r.x, 7)
}

@Test
func testVec1ScalarBitwiseXor(): Unit {
    let a = Vec1<Int64, Defaultp>(6)
    let r = a ^ Int64(3)
    @Expect(r.x, 5)
}

@Test
func testVec1ShiftRightVec(): Unit {
    let a = Vec1<Int64, Defaultp>(32)
    let b = Vec1<Int64, Defaultp>(2)
    let r = a >> b
    @Expect(r.x, 8)
}

@Test
func testVec1EqualEpsilon(): Unit {
    let a = Vec1<Float64, Defaultp>(1.0)
    let b = Vec1<Float64, Defaultp>(1.0)
    @Expect(a.equalEpsilon(b), true)
}

@Test
func testVec1BroadcastAddVec2(): Unit {
    let a = Vec1<Int64, Defaultp>(3)
    let b = Vec2<Int64, Defaultp>(10, 20)
    let r = a + b
    @Expect(r.x, 13)
    @Expect(r.y, 23)
}

@Test
func testVec1BroadcastBitAndVec2(): Unit {
    let a = Vec1<Int64, Defaultp>(6)
    let b = Vec2<Int64, Defaultp>(3, 1)
    let r = a & b
    @Expect(r.x, 2)
    @Expect(r.y, 0)
}

@Test
func testVec1BroadcastAddVec3(): Unit {
    let a = Vec1<Int64, Defaultp>(3)
    let b = Vec3<Int64, Defaultp>(10, 20, 30)
    let r = a + b
    @Expect(r.x, 13)
    @Expect(r.y, 23)
    @Expect(r.z, 33)
}

@Test
func testVec1BroadcastAddVec4(): Unit {
    let a = Vec1<Int64, Defaultp>(3)
    let b = Vec4<Int64, Defaultp>(10, 20, 30, 40)
    let r = a + b
    @Expect(r.x, 13)
    @Expect(r.y, 23)
    @Expect(r.z, 33)
    @Expect(r.w, 43)
}

@Test
func testVec1BroadcastBitOrVec2(): Unit {
    let a = Vec1<Int64, Defaultp>(6)
    let b = Vec2<Int64, Defaultp>(3, 1)
    let r = a | b
    @Expect(r.x, 7)
    @Expect(r.y, 7)
}

@Test
func testVec1BroadcastBitXorVec2(): Unit {
    let a = Vec1<Int64, Defaultp>(6)
    let b = Vec2<Int64, Defaultp>(3, 1)
    let r = a ^ b
    @Expect(r.x, 5)
    @Expect(r.y, 7)
}

@Test
func testVec1BroadcastShiftLeftVec2(): Unit {
    let a = Vec1<Int64, Defaultp>(2)
    let b = Vec2<Int64, Defaultp>(4, 5)
    let r = a << b
    @Expect(r.x, 32)
    @Expect(r.y, 64)
}

@Test
func testVec1BroadcastShiftRightVec2(): Unit {
    let a = Vec1<Int64, Defaultp>(128)
    let b = Vec2<Int64, Defaultp>(4, 3)
    let r = a >> b
    @Expect(r.x, 8)
    @Expect(r.y, 16)
}

@Test
func testVec1BroadcastBitAndVec3(): Unit {
    let a = Vec1<Int64, Defaultp>(6)
    let b = Vec3<Int64, Defaultp>(3, 1, 5)
    let r = a & b
    @Expect(r.x, 2)
    @Expect(r.y, 0)
    @Expect(r.z, 4)
}

@Test
func testVec1BroadcastBitAndVec4(): Unit {
    let a = Vec1<Int64, Defaultp>(6)
    let b = Vec4<Int64, Defaultp>(3, 1, 5, 7)
    let r = a & b
    @Expect(r.x, 2)
    @Expect(r.y, 0)
    @Expect(r.z, 4)
    @Expect(r.w, 6)
}

@Test
func testVec1BroadcastModVec2(): Unit {
    let a = Vec1<Int64, Defaultp>(10)
    let b = Vec2<Int64, Defaultp>(3, 6)
    let r = a % b
    @Expect(r.x, 1)
    @Expect(r.y, 4)
}

@Test
func testVec1BroadcastModVec3(): Unit {
    let a = Vec1<Int64, Defaultp>(10)
    let b = Vec3<Int64, Defaultp>(3, 6, 7)
    let r = a % b
    @Expect(r.x, 1)
    @Expect(r.y, 4)
    @Expect(r.z, 3)
}

@Test
func testVec1BroadcastModVec4(): Unit {
    let a = Vec1<Int64, Defaultp>(10)
    let b = Vec4<Int64, Defaultp>(3, 6, 7, 9)
    let r = a % b
    @Expect(r.x, 1)
    @Expect(r.y, 4)
    @Expect(r.z, 3)
    @Expect(r.w, 1)
}

@Test
func testVec1Increment(): Unit {
    var v = Vec1<Int64, Defaultp>(5)
    v.increment()
    @Expect(v.x, 6)
}

@Test
func testVec1Decrement(): Unit {
    var v = Vec1<Int64, Defaultp>(5)
    v.decrement()
    @Expect(v.x, 4)
}
