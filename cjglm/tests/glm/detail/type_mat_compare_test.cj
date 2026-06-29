package glm.detail

import std.unittest.*
import std.unittest.testmacro.*

@Test
func test2x2EqualTrue(): Unit {
    let a = Mat2x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32)
    let b = Mat2x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32)
    @Expect(a == b, true)
}

@Test
func test2x2EqualFalse(): Unit {
    let a = Mat2x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32)
    let b = Mat2x2<Float32, Defaultp>(1.0f32, 2.0f32, 0.0f32, 4.0f32)
    @Expect(a == b, false)
}

@Test
func test2x2NotEqualTrue(): Unit {
    let a = Mat2x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32)
    let b = Mat2x2<Float32, Defaultp>(1.0f32, 2.0f32, 0.0f32, 4.0f32)
    @Expect(a != b, true)
}

@Test
func test2x2NotEqualFalse(): Unit {
    let a = Mat2x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32)
    let b = Mat2x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32)
    @Expect(a != b, false)
}

@Test
func test2x2EqualExactTrue(): Unit {
    let a = Mat2x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32)
    let b = Mat2x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32)
    @Expect(a.equalExact(b), true)
}

@Test
func test2x2EqualExactFalse(): Unit {
    let a = Mat2x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32)
    let b = Mat2x2<Float32, Defaultp>(1.0f32, 2.0f32, 0.0f32, 4.0f32)
    @Expect(a.equalExact(b), false)
}

@Test
func test2x2EqualEpsilonTrue(): Unit {
    let a = Mat2x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32)
    let b = Mat2x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32)
    @Expect(a.equalEpsilon(b), true)
}

@Test
func test2x2EqualEpsilonFalse(): Unit {
    let a = Mat2x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32)
    let b = Mat2x2<Float32, Defaultp>(1.0f32, 2.0f32, 30.0f32, 4.0f32)
    @Expect(a.equalEpsilon(b), false)
}

@Test
func testBool2x2Equal(): Unit {
    let a = Mat2x2<Bool, Defaultp>(true, false, true, false)
    let b = Mat2x2<Bool, Defaultp>(true, false, true, false)
    @Expect(a == b, true)
}

@Test
func testBool2x2NotEqual(): Unit {
    let a = Mat2x2<Bool, Defaultp>(true, false, true, false)
    let b = Mat2x2<Bool, Defaultp>(true, false, false, false)
    @Expect(a != b, true)
}

@Test
func test2x3EqualTrue(): Unit {
    let a = Mat2x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32)
    let b = Mat2x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32)
    @Expect(a == b, true)
}

@Test
func test2x3EqualFalse(): Unit {
    let a = Mat2x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32)
    let b = Mat2x3<Float32, Defaultp>(1.0f32, 2.0f32, 0.0f32, 4.0f32, 5.0f32, 6.0f32)
    @Expect(a == b, false)
}

@Test
func test2x3NotEqualTrue(): Unit {
    let a = Mat2x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32)
    let b = Mat2x3<Float32, Defaultp>(1.0f32, 2.0f32, 0.0f32, 4.0f32, 5.0f32, 6.0f32)
    @Expect(a != b, true)
}

@Test
func test2x3NotEqualFalse(): Unit {
    let a = Mat2x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32)
    let b = Mat2x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32)
    @Expect(a != b, false)
}

@Test
func test2x3EqualExactTrue(): Unit {
    let a = Mat2x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32)
    let b = Mat2x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32)
    @Expect(a.equalExact(b), true)
}

@Test
func test2x3EqualExactFalse(): Unit {
    let a = Mat2x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32)
    let b = Mat2x3<Float32, Defaultp>(1.0f32, 2.0f32, 0.0f32, 4.0f32, 5.0f32, 6.0f32)
    @Expect(a.equalExact(b), false)
}

@Test
func test2x3EqualEpsilonTrue(): Unit {
    let a = Mat2x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32)
    let b = Mat2x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32)
    @Expect(a.equalEpsilon(b), true)
}

@Test
func test2x3EqualEpsilonFalse(): Unit {
    let a = Mat2x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32)
    let b = Mat2x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 40.0f32, 5.0f32, 6.0f32)
    @Expect(a.equalEpsilon(b), false)
}

@Test
func testBool2x3Equal(): Unit {
    let a = Mat2x3<Bool, Defaultp>(true, false, true, false, true, false)
    let b = Mat2x3<Bool, Defaultp>(true, false, true, false, true, false)
    @Expect(a == b, true)
}

@Test
func testBool2x3NotEqual(): Unit {
    let a = Mat2x3<Bool, Defaultp>(true, false, true, false, true, false)
    let b = Mat2x3<Bool, Defaultp>(true, false, false, false, true, false)
    @Expect(a != b, true)
}

@Test
func test2x4EqualTrue(): Unit {
    let a = Mat2x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32)
    let b = Mat2x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32)
    @Expect(a == b, true)
}

@Test
func test2x4EqualFalse(): Unit {
    let a = Mat2x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32)
    let b = Mat2x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 0.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32)
    @Expect(a == b, false)
}

@Test
func test2x4NotEqualTrue(): Unit {
    let a = Mat2x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32)
    let b = Mat2x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 0.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32)
    @Expect(a != b, true)
}

@Test
func test2x4NotEqualFalse(): Unit {
    let a = Mat2x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32)
    let b = Mat2x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32)
    @Expect(a != b, false)
}

@Test
func test2x4EqualExactTrue(): Unit {
    let a = Mat2x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32)
    let b = Mat2x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32)
    @Expect(a.equalExact(b), true)
}

@Test
func test2x4EqualExactFalse(): Unit {
    let a = Mat2x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32)
    let b = Mat2x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 0.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32)
    @Expect(a.equalExact(b), false)
}

@Test
func test2x4EqualEpsilonTrue(): Unit {
    let a = Mat2x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32)
    let b = Mat2x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32)
    @Expect(a.equalEpsilon(b), true)
}

@Test
func test2x4EqualEpsilonFalse(): Unit {
    let a = Mat2x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32)
    let b = Mat2x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 60.0f32, 7.0f32, 8.0f32)
    @Expect(a.equalEpsilon(b), false)
}

@Test
func testBool2x4Equal(): Unit {
    let a = Mat2x4<Bool, Defaultp>(true, false, true, false, true, false, true, false)
    let b = Mat2x4<Bool, Defaultp>(true, false, true, false, true, false, true, false)
    @Expect(a == b, true)
}

@Test
func testBool2x4NotEqual(): Unit {
    let a = Mat2x4<Bool, Defaultp>(true, false, true, false, true, false, true, false)
    let b = Mat2x4<Bool, Defaultp>(true, false, true, false, false, false, true, false)
    @Expect(a != b, true)
}

@Test
func test3x2EqualTrue(): Unit {
    let a = Mat3x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32)
    let b = Mat3x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32)
    @Expect(a == b, true)
}

@Test
func test3x2EqualFalse(): Unit {
    let a = Mat3x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32)
    let b = Mat3x2<Float32, Defaultp>(0.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32)
    @Expect(a == b, false)
}

@Test
func test3x2NotEqualTrue(): Unit {
    let a = Mat3x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32)
    let b = Mat3x2<Float32, Defaultp>(0.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32)
    @Expect(a != b, true)
}

@Test
func test3x2NotEqualFalse(): Unit {
    let a = Mat3x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32)
    let b = Mat3x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32)
    @Expect(a != b, false)
}

@Test
func test3x2EqualExactTrue(): Unit {
    let a = Mat3x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32)
    let b = Mat3x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32)
    @Expect(a.equalExact(b), true)
}

@Test
func test3x2EqualExactFalse(): Unit {
    let a = Mat3x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32)
    let b = Mat3x2<Float32, Defaultp>(0.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32)
    @Expect(a.equalExact(b), false)
}

@Test
func test3x2EqualEpsilonTrue(): Unit {
    let a = Mat3x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32)
    let b = Mat3x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32)
    @Expect(a.equalEpsilon(b), true)
}

@Test
func test3x2EqualEpsilonFalse(): Unit {
    let a = Mat3x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32)
    let b = Mat3x2<Float32, Defaultp>(1.0f32, 20.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32)
    @Expect(a.equalEpsilon(b), false)
}

@Test
func testBool3x2Equal(): Unit {
    let a = Mat3x2<Bool, Defaultp>(true, false, true, false, true, false)
    let b = Mat3x2<Bool, Defaultp>(true, false, true, false, true, false)
    @Expect(a == b, true)
}

@Test
func testBool3x2NotEqual(): Unit {
    let a = Mat3x2<Bool, Defaultp>(true, false, true, false, true, false)
    let b = Mat3x2<Bool, Defaultp>(true, false, true, false, false, false)
    @Expect(a != b, true)
}

@Test
func test3x3EqualTrue(): Unit {
    let a = Mat3x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32)
    let b = Mat3x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32)
    @Expect(a == b, true)
}

@Test
func test3x3EqualFalse(): Unit {
    let a = Mat3x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32)
    let b = Mat3x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 0.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32)
    @Expect(a == b, false)
}

@Test
func test3x3NotEqualTrue(): Unit {
    let a = Mat3x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32)
    let b = Mat3x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 0.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32)
    @Expect(a != b, true)
}

@Test
func test3x3NotEqualFalse(): Unit {
    let a = Mat3x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32)
    let b = Mat3x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32)
    @Expect(a != b, false)
}

@Test
func test3x3EqualExactTrue(): Unit {
    let a = Mat3x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32)
    let b = Mat3x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32)
    @Expect(a.equalExact(b), true)
}

@Test
func test3x3EqualExactFalse(): Unit {
    let a = Mat3x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32)
    let b = Mat3x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 0.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32)
    @Expect(a.equalExact(b), false)
}

@Test
func test3x3EqualEpsilonTrue(): Unit {
    let a = Mat3x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32)
    let b = Mat3x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32)
    @Expect(a.equalEpsilon(b), true)
}

@Test
func test3x3EqualEpsilonFalse(): Unit {
    let a = Mat3x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32)
    let b = Mat3x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 50.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32)
    @Expect(a.equalEpsilon(b), false)
}

@Test
func testBool3x3Equal(): Unit {
    let a = Mat3x3<Bool, Defaultp>(true, false, true, false, true, false, true, false, true)
    let b = Mat3x3<Bool, Defaultp>(true, false, true, false, true, false, true, false, true)
    @Expect(a == b, true)
}

@Test
func testBool3x3NotEqual(): Unit {
    let a = Mat3x3<Bool, Defaultp>(true, false, true, false, true, false, true, false, true)
    let b = Mat3x3<Bool, Defaultp>(true, false, true, false, false, false, true, false, true)
    @Expect(a != b, true)
}

@Test
func test3x4EqualTrue(): Unit {
    let a = Mat3x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32)
    let b = Mat3x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32)
    @Expect(a == b, true)
}

@Test
func test3x4EqualFalse(): Unit {
    let a = Mat3x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32)
    let b = Mat3x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 0.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32)
    @Expect(a == b, false)
}

@Test
func test3x4NotEqualTrue(): Unit {
    let a = Mat3x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32)
    let b = Mat3x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 0.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32)
    @Expect(a != b, true)
}

@Test
func test3x4NotEqualFalse(): Unit {
    let a = Mat3x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32)
    let b = Mat3x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32)
    @Expect(a != b, false)
}

@Test
func test3x4EqualExactTrue(): Unit {
    let a = Mat3x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32)
    let b = Mat3x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32)
    @Expect(a.equalExact(b), true)
}

@Test
func test3x4EqualExactFalse(): Unit {
    let a = Mat3x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32)
    let b = Mat3x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 0.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32)
    @Expect(a.equalExact(b), false)
}

@Test
func test3x4EqualEpsilonTrue(): Unit {
    let a = Mat3x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32)
    let b = Mat3x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32)
    @Expect(a.equalEpsilon(b), true)
}

@Test
func test3x4EqualEpsilonFalse(): Unit {
    let a = Mat3x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32)
    let b = Mat3x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 80.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32)
    @Expect(a.equalEpsilon(b), false)
}

@Test
func testBool3x4Equal(): Unit {
    let a = Mat3x4<Bool, Defaultp>(true, false, true, false, true, false, true, false, true, false, true, false)
    let b = Mat3x4<Bool, Defaultp>(true, false, true, false, true, false, true, false, true, false, true, false)
    @Expect(a == b, true)
}

@Test
func testBool3x4NotEqual(): Unit {
    let a = Mat3x4<Bool, Defaultp>(true, false, true, false, true, false, true, false, true, false, true, false)
    let b = Mat3x4<Bool, Defaultp>(true, false, true, false, false, false, true, false, true, false, true, false)
    @Expect(a != b, true)
}

@Test
func test4x2EqualTrue(): Unit {
    let a = Mat4x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32)
    let b = Mat4x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32)
    @Expect(a == b, true)
}

@Test
func test4x2EqualFalse(): Unit {
    let a = Mat4x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32)
    let b = Mat4x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 0.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32)
    @Expect(a == b, false)
}

@Test
func test4x2NotEqualTrue(): Unit {
    let a = Mat4x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32)
    let b = Mat4x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 0.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32)
    @Expect(a != b, true)
}

@Test
func test4x2NotEqualFalse(): Unit {
    let a = Mat4x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32)
    let b = Mat4x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32)
    @Expect(a != b, false)
}

@Test
func test4x2EqualExactTrue(): Unit {
    let a = Mat4x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32)
    let b = Mat4x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32)
    @Expect(a.equalExact(b), true)
}

@Test
func test4x2EqualExactFalse(): Unit {
    let a = Mat4x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32)
    let b = Mat4x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 0.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32)
    @Expect(a.equalExact(b), false)
}

@Test
func test4x2EqualEpsilonTrue(): Unit {
    let a = Mat4x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32)
    let b = Mat4x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32)
    @Expect(a.equalEpsilon(b), true)
}

@Test
func test4x2EqualEpsilonFalse(): Unit {
    let a = Mat4x2<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32)
    let b = Mat4x2<Float32, Defaultp>(1.0f32, 2.0f32, 30.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32)
    @Expect(a.equalEpsilon(b), false)
}

@Test
func testBool4x2Equal(): Unit {
    let a = Mat4x2<Bool, Defaultp>(true, false, true, false, true, false, true, false)
    let b = Mat4x2<Bool, Defaultp>(true, false, true, false, true, false, true, false)
    @Expect(a == b, true)
}

@Test
func testBool4x2NotEqual(): Unit {
    let a = Mat4x2<Bool, Defaultp>(true, false, true, false, true, false, true, false)
    let b = Mat4x2<Bool, Defaultp>(true, false, true, false, false, false, true, false)
    @Expect(a != b, true)
}

@Test
func test4x3EqualTrue(): Unit {
    let a = Mat4x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32)
    let b = Mat4x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32)
    @Expect(a == b, true)
}

@Test
func test4x3EqualFalse(): Unit {
    let a = Mat4x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32)
    let b = Mat4x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 0.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32)
    @Expect(a == b, false)
}

@Test
func test4x3NotEqualTrue(): Unit {
    let a = Mat4x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32)
    let b = Mat4x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 0.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32)
    @Expect(a != b, true)
}

@Test
func test4x3NotEqualFalse(): Unit {
    let a = Mat4x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32)
    let b = Mat4x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32)
    @Expect(a != b, false)
}

@Test
func test4x3EqualExactTrue(): Unit {
    let a = Mat4x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32)
    let b = Mat4x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32)
    @Expect(a.equalExact(b), true)
}

@Test
func test4x3EqualExactFalse(): Unit {
    let a = Mat4x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32)
    let b = Mat4x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 0.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32)
    @Expect(a.equalExact(b), false)
}

@Test
func test4x3EqualEpsilonTrue(): Unit {
    let a = Mat4x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32)
    let b = Mat4x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32)
    @Expect(a.equalEpsilon(b), true)
}

@Test
func test4x3EqualEpsilonFalse(): Unit {
    let a = Mat4x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32)
    let b = Mat4x3<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 60.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32)
    @Expect(a.equalEpsilon(b), false)
}

@Test
func testBool4x3Equal(): Unit {
    let a = Mat4x3<Bool, Defaultp>(true, false, true, false, true, false, true, false, true, false, true, false)
    let b = Mat4x3<Bool, Defaultp>(true, false, true, false, true, false, true, false, true, false, true, false)
    @Expect(a == b, true)
}

@Test
func testBool4x3NotEqual(): Unit {
    let a = Mat4x3<Bool, Defaultp>(true, false, true, false, true, false, true, false, true, false, true, false)
    let b = Mat4x3<Bool, Defaultp>(true, false, true, false, true, false, false, false, true, false, true, false)
    @Expect(a != b, true)
}

@Test
func test4x4EqualTrue(): Unit {
    let a = Mat4x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32, 13.0f32, 14.0f32, 15.0f32, 16.0f32)
    let b = Mat4x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32, 13.0f32, 14.0f32, 15.0f32, 16.0f32)
    @Expect(a == b, true)
}

@Test
func test4x4EqualFalse(): Unit {
    let a = Mat4x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32, 13.0f32, 14.0f32, 15.0f32, 16.0f32)
    let b = Mat4x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 0.0f32, 12.0f32, 13.0f32, 14.0f32, 15.0f32, 16.0f32)
    @Expect(a == b, false)
}

@Test
func test4x4NotEqualTrue(): Unit {
    let a = Mat4x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32, 13.0f32, 14.0f32, 15.0f32, 16.0f32)
    let b = Mat4x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 0.0f32, 12.0f32, 13.0f32, 14.0f32, 15.0f32, 16.0f32)
    @Expect(a != b, true)
}

@Test
func test4x4NotEqualFalse(): Unit {
    let a = Mat4x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32, 13.0f32, 14.0f32, 15.0f32, 16.0f32)
    let b = Mat4x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32, 13.0f32, 14.0f32, 15.0f32, 16.0f32)
    @Expect(a != b, false)
}

@Test
func test4x4EqualExactTrue(): Unit {
    let a = Mat4x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32, 13.0f32, 14.0f32, 15.0f32, 16.0f32)
    let b = Mat4x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32, 13.0f32, 14.0f32, 15.0f32, 16.0f32)
    @Expect(a.equalExact(b), true)
}

@Test
func test4x4EqualExactFalse(): Unit {
    let a = Mat4x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32, 13.0f32, 14.0f32, 15.0f32, 16.0f32)
    let b = Mat4x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 0.0f32, 12.0f32, 13.0f32, 14.0f32, 15.0f32, 16.0f32)
    @Expect(a.equalExact(b), false)
}

@Test
func test4x4EqualEpsilonTrue(): Unit {
    let a = Mat4x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32, 13.0f32, 14.0f32, 15.0f32, 16.0f32)
    let b = Mat4x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32, 13.0f32, 14.0f32, 15.0f32, 16.0f32)
    @Expect(a.equalEpsilon(b), true)
}

@Test
func test4x4EqualEpsilonFalse(): Unit {
    let a = Mat4x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 10.0f32, 11.0f32, 12.0f32, 13.0f32, 14.0f32, 15.0f32, 16.0f32)
    let b = Mat4x4<Float32, Defaultp>(1.0f32, 2.0f32, 3.0f32, 4.0f32, 5.0f32, 6.0f32, 7.0f32, 8.0f32, 9.0f32, 100.0f32, 11.0f32, 12.0f32, 13.0f32, 14.0f32, 15.0f32, 16.0f32)
    @Expect(a.equalEpsilon(b), false)
}

@Test
func testBool4x4Equal(): Unit {
    let a = Mat4x4<Bool, Defaultp>(true, false, true, false, true, false, true, false, true, false, true, false, true, false, true, false)
    let b = Mat4x4<Bool, Defaultp>(true, false, true, false, true, false, true, false, true, false, true, false, true, false, true, false)
    @Expect(a == b, true)
}

@Test
func testBool4x4NotEqual(): Unit {
    let a = Mat4x4<Bool, Defaultp>(true, false, true, false, true, false, true, false, true, false, true, false, true, false, true, false)
    let b = Mat4x4<Bool, Defaultp>(true, false, true, false, true, false, true, false, true, false, false, false, true, false, true, false)
    @Expect(a != b, true)
}

// Hashable tests

@Test
func testHashMat4x4Int64SameValue(): Unit {
    let a = Mat4x4<Int64, Defaultp>(Int64(1))
    let b = Mat4x4<Int64, Defaultp>(Int64(1))
    @Expect(a.hashCode() == b.hashCode(), true)
}

@Test
func testHashMat4x4Int64DiffValue(): Unit {
    let a = Mat4x4<Int64, Defaultp>(Int64(1))
    let b = Mat4x4<Int64, Defaultp>(Int64(2))
    @Expect(a.hashCode() != b.hashCode(), true)
}

@Test
func testHashMat4x4Float32SameValue(): Unit {
    let a = Mat4x4<Float32, Defaultp>(Float32(1.0))
    let b = Mat4x4<Float32, Defaultp>(Float32(1.0))
    @Expect(a.hashCode() == b.hashCode(), true)
}

@Test
func testHashMat4x4Float32DiffValue(): Unit {
    let a = Mat4x4<Float32, Defaultp>(Float32(1.0))
    let b = Mat4x4<Float32, Defaultp>(Float32(2.0))
    @Expect(a.hashCode() != b.hashCode(), true)
}

@Test
func testHashMat2x3Int64SameValue(): Unit {
    let a = Mat2x3<Int64, Defaultp>(Int64(1))
    let b = Mat2x3<Int64, Defaultp>(Int64(1))
    @Expect(a.hashCode() == b.hashCode(), true)
}

@Test
func testHashMat2x3Int64DiffValue(): Unit {
    let a = Mat2x3<Int64, Defaultp>(Int64(1))
    let b = Mat2x3<Int64, Defaultp>(Int64(2))
    @Expect(a.hashCode() != b.hashCode(), true)
}

@Test
func testHashMat2x3Float32SameValue(): Unit {
    let a = Mat2x3<Float32, Defaultp>(Float32(1.0))
    let b = Mat2x3<Float32, Defaultp>(Float32(1.0))
    @Expect(a.hashCode() == b.hashCode(), true)
}

@Test
func testHashMat2x3Float32DiffValue(): Unit {
    let a = Mat2x3<Float32, Defaultp>(Float32(1.0))
    let b = Mat2x3<Float32, Defaultp>(Float32(2.0))
    @Expect(a.hashCode() != b.hashCode(), true)
}
