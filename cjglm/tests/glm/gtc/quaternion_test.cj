package glm.gtc
import std.unittest.*
import std.unittest.testmacro.*
import glm.detail.{ Quat, Defaultp, Vec3, Vec4, epsilonOf }

@Test
func testEpsilonAccessible(): Unit {
    @Expect(epsilon<Float32>() > Float32(0.0), true)
    @Expect(epsilon<Float64>() > Float64(0.0), true)
}

@Test
func testPiAccessible(): Unit {
    @Expect(pi<Float64>() > Float64(3.14), true)
    @Expect(pi<Float64>() < Float64(3.15), true)
}

@Test
func testCosOneOverTwoAccessible(): Unit {
    let v = cos_one_over_two<Float64>()
    @Expect(v > Float64(0.87), true)
    @Expect(v < Float64(0.88), true)
}

@Test
func testEqualVec4Accessible(): Unit {
    let a = Vec4<Float64, Defaultp>(Float64(1.0), Float64(2.0), Float64(3.0), Float64(4.0))
    let b = Vec4<Float64, Defaultp>(Float64(1.0), Float64(2.0), Float64(3.0), Float64(4.0))
    @Expect(equal(a, b, Float64(0.001)), Vec4<Bool, Defaultp>(true, true, true, true))
}

@Test
func testEqualVec4NotEqualCase(): Unit {
    let a = Vec4<Float64, Defaultp>(Float64(1.0), Float64(2.0), Float64(3.0), Float64(4.0))
    let b = Vec4<Float64, Defaultp>(Float64(2.0), Float64(3.0), Float64(4.0), Float64(5.0))
    @Expect(equal(a, b, Float64(0.001)), Vec4<Bool, Defaultp>(false, false, false, false))
}

@Test
func testNotEqualVec4Accessible(): Unit {
    let a = Vec4<Float64, Defaultp>(Float64(1.0), Float64(2.0), Float64(3.0), Float64(4.0))
    let b = Vec4<Float64, Defaultp>(Float64(2.0), Float64(3.0), Float64(4.0), Float64(5.0))
    @Expect(notEqual(a, b, Float64(0.001)), Vec4<Bool, Defaultp>(true, true, true, true))
}

@Test
func testNotEqualVec4EqualCase(): Unit {
    let a = Vec4<Float64, Defaultp>(Float64(1.0), Float64(2.0), Float64(3.0), Float64(4.0))
    let b = Vec4<Float64, Defaultp>(Float64(1.0), Float64(2.0), Float64(3.0), Float64(4.0))
    @Expect(notEqual(a, b, Float64(0.001)), Vec4<Bool, Defaultp>(false, false, false, false))
}

@Test
func testLessThan(): Unit {
    let x = Quat<Int64, Defaultp>(Int64(1), Int64(2), Int64(3), Int64(4))
    let y = Quat<Int64, Defaultp>(Int64(2), Int64(3), Int64(4), Int64(5))
    let r = lessThan(x, y)
    @Expect(r, Vec4<Bool, Defaultp>(true, true, true, true))
}

@Test
func testLessThanEqual(): Unit {
    let x = Quat<Int64, Defaultp>(Int64(1), Int64(2), Int64(3), Int64(4))
    let y = Quat<Int64, Defaultp>(Int64(1), Int64(2), Int64(3), Int64(5))
    let r = lessThanEqual(x, y)
    @Expect(r, Vec4<Bool, Defaultp>(true, true, true, true))
}

@Test
func testGreaterThan(): Unit {
    let x = Quat<Int64, Defaultp>(Int64(5), Int64(4), Int64(3), Int64(2))
    let y = Quat<Int64, Defaultp>(Int64(4), Int64(3), Int64(2), Int64(1))
    let r = greaterThan(x, y)
    @Expect(r, Vec4<Bool, Defaultp>(true, true, true, true))
}

@Test
func testGreaterThanEqual(): Unit {
    let x = Quat<Int64, Defaultp>(Int64(5), Int64(4), Int64(3), Int64(2))
    let y = Quat<Int64, Defaultp>(Int64(5), Int64(4), Int64(3), Int64(1))
    let r = greaterThanEqual(x, y)
    @Expect(r, Vec4<Bool, Defaultp>(true, true, true, true))
}

@Test
func testAllComponentsEqual(): Unit {
    let x = Quat<Int64, Defaultp>(Int64(1), Int64(1), Int64(1), Int64(1))
    let y = Quat<Int64, Defaultp>(Int64(1), Int64(1), Int64(1), Int64(1))
    let lt = lessThan(x, y)
    let gt = greaterThan(x, y)
    @Expect(lt, Vec4<Bool, Defaultp>(false, false, false, false))
    @Expect(gt, Vec4<Bool, Defaultp>(false, false, false, false))
}

@Test
func testEulerAnglesStub(): Unit {
    let q = Quat<Float64, Defaultp>(Float64(0.0), Float64(0.0), Float64(0.0), Float64(1.0))
    @ExpectThrows[Exception](eulerAngles(q))
}

@Test
func testRollStub(): Unit {
    let q = Quat<Float64, Defaultp>(Float64(0.0), Float64(0.0), Float64(0.0), Float64(1.0))
    @ExpectThrows[Exception](roll(q))
}

@Test
func testPitchStub(): Unit {
    let q = Quat<Float64, Defaultp>(Float64(0.0), Float64(0.0), Float64(0.0), Float64(1.0))
    @ExpectThrows[Exception](pitch(q))
}

@Test
func testYawStub(): Unit {
    let q = Quat<Float64, Defaultp>(Float64(0.0), Float64(0.0), Float64(0.0), Float64(1.0))
    @ExpectThrows[Exception](yaw(q))
}

@Test
func testQuatLookAtStub(): Unit {
    let dir = Vec3<Float64, Defaultp>(Float64(0.0), Float64(0.0), Float64(-1.0))
    let up = Vec3<Float64, Defaultp>(Float64(0.0), Float64(1.0), Float64(0.0))
    @ExpectThrows[Exception](quatLookAt(dir, up))
}

@Test
func testQuatLookAtRHStub(): Unit {
    let dir = Vec3<Float64, Defaultp>(Float64(0.0), Float64(0.0), Float64(-1.0))
    let up = Vec3<Float64, Defaultp>(Float64(0.0), Float64(1.0), Float64(0.0))
    @ExpectThrows[Exception](quatLookAtRH(dir, up))
}

@Test
func testQuatLookAtLHStub(): Unit {
    let dir = Vec3<Float64, Defaultp>(Float64(0.0), Float64(0.0), Float64(-1.0))
    let up = Vec3<Float64, Defaultp>(Float64(0.0), Float64(1.0), Float64(0.0))
    @ExpectThrows[Exception](quatLookAtLH(dir, up))
}
