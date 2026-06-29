package glm.detail

@Test
func testSinScalarThrows(): Unit {
    @ExpectThrows[Exception](sin<Float32>(0.0f32))
}

@Test
func testSinVec1Throws(): Unit {
    @ExpectThrows[Exception](sin<Float32, Defaultp>(Vec1(0.0f32)))
}

@Test
func testCosScalarThrows(): Unit {
    @ExpectThrows[Exception](cos<Float32>(0.0f32))
}

@Test
func testTanScalarThrows(): Unit {
    @ExpectThrows[Exception](tan<Float32>(0.0f32))
}

@Test
func testAsinScalarThrows(): Unit {
    @ExpectThrows[Exception](asin<Float32>(0.0f32))
}

@Test
func testAcosScalarThrows(): Unit {
    @ExpectThrows[Exception](acos<Float32>(0.0f32))
}

@Test
func testAtanScalarThrows(): Unit {
    @ExpectThrows[Exception](atan<Float32>(0.0f32))
}

@Test
func testSinhScalarThrows(): Unit {
    @ExpectThrows[Exception](sinh<Float32>(0.0f32))
}

@Test
func testCoshScalarThrows(): Unit {
    @ExpectThrows[Exception](cosh<Float32>(0.0f32))
}

@Test
func testTanhScalarThrows(): Unit {
    @ExpectThrows[Exception](tanh<Float32>(0.0f32))
}

@Test
func testAsinhScalarThrows(): Unit {
    @ExpectThrows[Exception](asinh<Float32>(0.0f32))
}

@Test
func testAcoshScalarThrows(): Unit {
    @ExpectThrows[Exception](acosh<Float32>(0.0f32))
}

@Test
func testAtanhScalarThrows(): Unit {
    @ExpectThrows[Exception](atanh<Float32>(0.0f32))
}

@Test
func testRadiansScalarThrows(): Unit {
    @ExpectThrows[Exception](radians<Float32>(0.0f32))
}

@Test
func testDegreesScalarThrows(): Unit {
    @ExpectThrows[Exception](degrees<Float32>(0.0f32))
}

@Test
func testAtan2ScalarThrows(): Unit {
    @ExpectThrows[Exception](atan2<Float32>(0.0f32, 1.0f32))
}
