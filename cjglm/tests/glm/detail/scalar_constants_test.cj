package glm.detail

@Test
func testEpsilonFloat32CrossValidation(): Unit {
    @Expect(epsilon<Float32>(), epsilonOf(Float32(0.0)))
}

@Test
func testEpsilonFloat64CrossValidation(): Unit {
    @Expect(epsilon<Float64>(), epsilonOf(Float64(0.0)))
}

@Test
func testEpsilonFloat32Precision(): Unit {
    @Expect(epsilon<Float32>(), Float32(1.1920929e-7))
}

@Test
func testEpsilonFloat64Precision(): Unit {
    @Expect(epsilon<Float64>(), Float64(2.220446049250313e-16))
}

@Test
func testPiFloat32Precision(): Unit {
    @Expect(pi<Float32>(), Float32(3.14159265358979323846))
}

@Test
func testPiFloat64Precision(): Unit {
    @Expect(pi<Float64>(), Float64(3.14159265358979323846))
}

@Test
func testCosOneOverTwoFloat32Value(): Unit {
    @Expect(cos_one_over_two<Float32>(), Float32(0.877582561890372716))
}

@Test
func testCosOneOverTwoFloat64Value(): Unit {
    @Expect(cos_one_over_two<Float64>(), Float64(0.877582561890372716))
}
