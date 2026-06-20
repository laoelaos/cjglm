package glm.detail

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
func testIsIec559OfFloat32ReturnsTrue(): Unit {
    @Expect(isIec559Of(Float32(0.0)), true)
}

@Test
func testIsIec559OfFloat64ReturnsTrue(): Unit {
    @Expect(isIec559Of(Float64(0.0)), true)
}

@Test
func testIsIec559OfInt64ReturnsFalse(): Unit {
    @Expect(isIec559Of(Int64(0)), false)
}

@Test
func testIsIec559OfBoolReturnsFalse(): Unit {
    @Expect(isIec559Of(false), false)
}

@Test
func testEpsilonOfFloat32(): Unit {
    @Expect(epsilonOf(Float32(0.0)), Float32(1.1920929e-7))
}

@Test
func testEpsilonOfFloat64(): Unit {
    @Expect(epsilonOf(Float64(0.0)), Float64(2.220446049250313e-16))
}
