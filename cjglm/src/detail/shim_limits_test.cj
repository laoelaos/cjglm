package glm.detail

import std.unittest.*
import std.unittest.testmacro.*

@Test
func testNumericLimitsFloat32Epsilon(): Unit {
    let hint: Float32 = 0.0
    @Expect(NumericLimits<Float32>.epsilon(hint), Float32(1.1920929e-7))
}

@Test
func testNumericLimitsFloat64Epsilon(): Unit {
    let hint: Float64 = 0.0
    @Expect(NumericLimits<Float64>.epsilon(hint), Float64(2.220446049250313e-16))
}

@Test
func testIsIec559OfFloat32(): Unit {
    @Expect(isIec559Of(Float32(0.0)), true)
}

@Test
func testIsIec559OfFloat64(): Unit {
    @Expect(isIec559Of(Float64(0.0)), true)
}

@Test
func testIsIec559OfInt64(): Unit {
    @Expect(isIec559Of(Int64(0)), false)
}

@Test
func testEpsilonOfFloat32(): Unit {
    @Expect(epsilonOf(Float32(0.0)), Float32(1.1920929e-7))
}

@Test
func testEpsilonOfFloat64(): Unit {
    @Expect(epsilonOf(Float64(0.0)), Float64(2.220446049250313e-16))
}

@Test
func testNumericLimitsInt64Epsilon(): Unit {
    @Expect(NumericLimits<Int64>.epsilon(Int64(0)), Int64(0))
}

@Test
func testNumericLimitsInt32Epsilon(): Unit {
    @Expect(NumericLimits<Int32>.epsilon(Int32(0)), Int32(0))
}

@Test
func testNumericLimitsInt16Epsilon(): Unit {
    @Expect(NumericLimits<Int16>.epsilon(Int16(0)), Int16(0))
}

@Test
func testNumericLimitsInt8Epsilon(): Unit {
    @Expect(NumericLimits<Int8>.epsilon(Int8(0)), Int8(0))
}
