package glm.detail

import std.unittest.*
import std.unittest.testmacro.*

@Test
func testVec2ScalarInit(): Unit {
    let v = Vec2<Int64, Defaultp>(5)
    @Expect(v.x, 5)
    @Expect(v.y, 5)
}

@Test
func testVec2ConstInit(): Unit {
    let v = Vec2<Int64, Defaultp>(1, 2)
    @Expect(v.x, 1)
    @Expect(v.y, 2)
}

@Test
func testVec2Length(): Unit {
    @Expect(Vec2<Int64, Defaultp>.length(), 2)
}

@Test
func testVec2Add(): Unit {
    let a = Vec2<Int64, Defaultp>(1, 2)
    let b = Vec2<Int64, Defaultp>(10, 20)
    let r = a + b
    @Expect(r.x, 11)
    @Expect(r.y, 22)
}

@Test
func testVec2Sub(): Unit {
    let a = Vec2<Int64, Defaultp>(5, 10)
    let b = Vec2<Int64, Defaultp>(3, 4)
    let r = a - b
    @Expect(r.x, 2)
    @Expect(r.y, 6)
}

@Test
func testVec2Mul(): Unit {
    let a = Vec2<Int64, Defaultp>(2, 3)
    let b = Vec2<Int64, Defaultp>(4, 5)
    let r = a * b
    @Expect(r.x, 8)
    @Expect(r.y, 15)
}

@Test
func testVec2ScalarAdd(): Unit {
    let v = Vec2<Int64, Defaultp>(1, 2)
    let r = v + Int64(3)
    @Expect(r.x, 4)
    @Expect(r.y, 5)
}

@Test
func testVec2Negate(): Unit {
    let v = Vec2<Int64, Defaultp>(1, -2)
    let r = -v
    @Expect(r.x, -1)
    @Expect(r.y, 2)
}

@Test
func testVec2IndexAccess(): Unit {
    let v = Vec2<Int64, Defaultp>(10, 20)
    @Expect(v[Int64(0)], 10)
    @Expect(v[Int64(1)], 20)
}

@Test
func testVec2IndexMutate(): Unit {
    var v = Vec2<Int64, Defaultp>(10, 20)
    v[Int64(1)] = 99
    @Expect(v[Int64(1)], 99)
}

@Test
func testVec2ComponentAt(): Unit {
    let v = Vec2<Int64, Defaultp>(10, 20)
    @Expect(v.componentAt(Int64(0)), 10)
    @Expect(v.componentAt(Int64(1)), 20)
}

@Test
func testVec2Equal(): Unit {
    let a = Vec2<Int64, Defaultp>(1, 2)
    let b = Vec2<Int64, Defaultp>(1, 2)
    @Expect(a == b, true)
}

@Test
func testVec2NotEqual(): Unit {
    let a = Vec2<Int64, Defaultp>(1, 2)
    let b = Vec2<Int64, Defaultp>(1, 3)
    @Expect(a != b, true)
}

@Test
func testVec2EqualExact(): Unit {
    let a = Vec2<Int64, Defaultp>(1, 2)
    let b = Vec2<Int64, Defaultp>(1, 2)
    @Expect(a.equalExact(b), true)
}

@Test
func testVec2BitwiseAnd(): Unit {
    let a = Vec2<Int64, Defaultp>(6, 3)
    let b = Vec2<Int64, Defaultp>(3, 1)
    let r = a & b
    @Expect(r.x, 2)
    @Expect(r.y, 1)
}

@Test
func testVec2BitwiseNot(): Unit {
    let a = Vec2<Int64, Defaultp>(0, -1)
    let r = a.bitwiseNot()
    @Expect(r.x, !0)
    @Expect(r.y, !(-1))
}

@Test
func testVec2FromVec1(): Unit {
    let v1 = Vec1<Int64, Defaultp>(5)
    let v2 = Vec2(v1)
    @Expect(v2.x, 5)
    @Expect(v2.y, 5)
}

@Test
func testVec2ShiftLeft(): Unit {
    let v = Vec2<Int64, Defaultp>(8, 16)
    let r = v << Int64(2)
    @Expect(r.x, 32)
    @Expect(r.y, 64)
}

@Test
func testVec2BoolLogicalAnd(): Unit {
    let a = Vec2<Bool, Defaultp>(true, false)
    let b = Vec2<Bool, Defaultp>(true, true)
    let r = a.logicalAnd(b)
    @Expect(r.x, true)
    @Expect(r.y, false)
}

@Test
func testVec2Vec1ArithBroadcast(): Unit {
    let a = Vec2<Int64, Defaultp>(10, 20)
    let b = Vec1<Int64, Defaultp>(3)
    let r = a + b
    @Expect(r.x, 13)
    @Expect(r.y, 23)
}

@Test
func testVec2Vec1BitBroadcast(): Unit {
    let a = Vec2<Int64, Defaultp>(6, 3)
    let b = Vec1<Int64, Defaultp>(3)
    let r = a & b
    @Expect(r.x, 2)
    @Expect(r.y, 3)
}

@Test
func testVec2ShiftLeftVec1(): Unit {
    let a = Vec2<Int64, Defaultp>(8, 16)
    let b = Vec1<Int64, Defaultp>(2)
    let r = a << b
    @Expect(r.x, 32)
    @Expect(r.y, 64)
}

@Test
func testVec2Div(): Unit {
    let a = Vec2<Int64, Defaultp>(10, 20)
    let b = Vec2<Int64, Defaultp>(3, 4)
    let r = a / b
    @Expect(r.x, 3)
    @Expect(r.y, 5)
}

@Test
func testVec2Mod(): Unit {
    let a = Vec2<Int64, Defaultp>(10, 20)
    let b = Vec2<Int64, Defaultp>(3, 6)
    let r = a % b
    @Expect(r.x, 1)
    @Expect(r.y, 2)
}

@Test
func testVec2ScalarSub(): Unit {
    let v = Vec2<Int64, Defaultp>(10, 20)
    let r = v - Int64(3)
    @Expect(r.x, 7)
    @Expect(r.y, 17)
}

@Test
func testVec2ScalarMul(): Unit {
    let v = Vec2<Int64, Defaultp>(2, 3)
    let r = v * Int64(5)
    @Expect(r.x, 10)
    @Expect(r.y, 15)
}

@Test
func testVec2ScalarDiv(): Unit {
    let v = Vec2<Int64, Defaultp>(10, 20)
    let r = v / Int64(3)
    @Expect(r.x, 3)
    @Expect(r.y, 6)
}

@Test
func testVec2ScalarMod(): Unit {
    let v = Vec2<Int64, Defaultp>(10, 20)
    let r = v % Int64(3)
    @Expect(r.x, 1)
    @Expect(r.y, 2)
}

@Test
func testVec2BoolLogicalOr(): Unit {
    let a = Vec2<Bool, Defaultp>(true, false)
    let b = Vec2<Bool, Defaultp>(false, false)
    let r = a.logicalOr(b)
    @Expect(r.x, true)
    @Expect(r.y, false)
}

@Test
func testVec2EqualEpsilon(): Unit {
    let a = Vec2<Float64, Defaultp>(1.0, 2.0)
    let b = Vec2<Float64, Defaultp>(1.0, 2.0)
    @Expect(a.equalEpsilon(b), true)
}

@Test
func testVec2DivNamed(): Unit {
    let v = Vec2<Int64, Defaultp>(10, 20)
    let r = v.div(Int64(3))
    @Expect(r.x, 3)
    @Expect(r.y, 6)
}

@Test
func testVec2ModNamed(): Unit {
    let v = Vec2<Int64, Defaultp>(10, 20)
    let r = v.mod(Int64(3))
    @Expect(r.x, 1)
    @Expect(r.y, 2)
}

@Test
func testVec2BitwiseOr(): Unit {
    let a = Vec2<Int64, Defaultp>(6, 3)
    let b = Vec2<Int64, Defaultp>(3, 1)
    let r = a | b
    @Expect(r.x, 7)
    @Expect(r.y, 3)
}

@Test
func testVec2BitwiseXor(): Unit {
    let a = Vec2<Int64, Defaultp>(6, 3)
    let b = Vec2<Int64, Defaultp>(3, 1)
    let r = a ^ b
    @Expect(r.x, 5)
    @Expect(r.y, 2)
}

@Test
func testVec2ScalarBitwiseAnd(): Unit {
    let a = Vec2<Int64, Defaultp>(6, 3)
    let r = a & Int64(3)
    @Expect(r.x, 2)
    @Expect(r.y, 3)
}

@Test
func testVec2ShiftRight(): Unit {
    let v = Vec2<Int64, Defaultp>(32, 64)
    let r = v >> Int64(2)
    @Expect(r.x, 8)
    @Expect(r.y, 16)
}

@Test
func testVec2ShiftRightVec1(): Unit {
    let a = Vec2<Int64, Defaultp>(32, 64)
    let b = Vec1<Int64, Defaultp>(2)
    let r = a >> b
    @Expect(r.x, 8)
    @Expect(r.y, 16)
}

@Test
func testVec2AddNamed(): Unit {
    let v = Vec2<Int64, Defaultp>(1, 2)
    let r = v.add(Int64(5))
    @Expect(r.x, 6)
    @Expect(r.y, 7)
}

@Test
func testVec2SubNamed(): Unit {
    let v = Vec2<Int64, Defaultp>(10, 20)
    let r = v.sub(Int64(3))
    @Expect(r.x, 7)
    @Expect(r.y, 17)
}

@Test
func testVec2MulNamed(): Unit {
    let v = Vec2<Int64, Defaultp>(2, 3)
    let r = v.mul(Int64(5))
    @Expect(r.x, 10)
    @Expect(r.y, 15)
}

@Test
func testVec2ShiftLeftVec(): Unit {
    let a = Vec2<Int64, Defaultp>(8, 16)
    let b = Vec2<Int64, Defaultp>(2, 1)
    let r = a << b
    @Expect(r.x, 32)
    @Expect(r.y, 32)
}

@Test
func testVec2ShiftRightVec(): Unit {
    let a = Vec2<Int64, Defaultp>(32, 64)
    let b = Vec2<Int64, Defaultp>(2, 3)
    let r = a >> b
    @Expect(r.x, 8)
    @Expect(r.y, 8)
}

@Test
func testVec2ScalarBitwiseOr(): Unit {
    let a = Vec2<Int64, Defaultp>(6, 3)
    let r = a | Int64(3)
    @Expect(r.x, 7)
    @Expect(r.y, 3)
}

@Test
func testVec2ScalarBitwiseXor(): Unit {
    let a = Vec2<Int64, Defaultp>(6, 3)
    let r = a ^ Int64(3)
    @Expect(r.x, 5)
    @Expect(r.y, 0)
}

@Test
func testVec2Increment(): Unit {
    var v = Vec2<Int64, Defaultp>(5, 10)
    v.increment()
    @Expect(v.x, 6)
    @Expect(v.y, 11)
}

@Test
func testVec2Decrement(): Unit {
    var v = Vec2<Int64, Defaultp>(5, 10)
    v.decrement()
    @Expect(v.x, 4)
    @Expect(v.y, 9)
}

@Test
func testVec2IndexOutOfBoundsAccess(): Unit {
    let v = Vec2<Int64, Defaultp>(1, 2)
    try {
        let _ = v[Int64(2)]
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}

@Test
func testVec2NegativeIndexAccess(): Unit {
    let v = Vec2<Int64, Defaultp>(1, 2)
    try {
        let _ = v[Int64(-1)]
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}
