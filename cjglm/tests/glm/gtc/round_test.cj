package glm.gtc
import std.unittest.*
import std.unittest.testmacro.*

@Test
func testRoundPowerOfTwo(): Unit {
    @Expect(roundPowerOfTwo(Float64(0.0)), Float64(0.0))
    @Expect(roundPowerOfTwo(Float64(4.0)), Float64(4.0))
    @Expect(roundPowerOfTwo(Float64(3.0)), Float64(4.0))
    @Expect(roundPowerOfTwo(Float64(5.0)), Float64(4.0))
    @Expect(roundPowerOfTwo(Float64(-3.0)), Float64(-4.0))
    @Expect(roundPowerOfTwo(Float64(6.0)), Float64(8.0))
}

@Test
func testCeilPowerOfTwo(): Unit {
    @Expect(ceilPowerOfTwo(Float64(0.0)), Float64(0.0))
    @Expect(ceilPowerOfTwo(Float64(4.0)), Float64(4.0))
    @Expect(ceilPowerOfTwo(Float64(3.0)), Float64(4.0))
    @Expect(ceilPowerOfTwo(Float64(5.0)), Float64(8.0))
    @Expect(ceilPowerOfTwo(Float64(1.0)), Float64(1.0))
}

@Test
func testCeilPowerOfTwoNegative(): Unit {
    @Expect(ceilPowerOfTwo(Float64(-3.0)), Float64(0.0))
    @Expect(ceilPowerOfTwo(Float64(-1.0)), Float64(0.0))
}

@Test
func testFloorPowerOfTwo(): Unit {
    @Expect(floorPowerOfTwo(Float64(0.0)), Float64(0.0))
    @Expect(floorPowerOfTwo(Float64(4.0)), Float64(4.0))
    @Expect(floorPowerOfTwo(Float64(3.0)), Float64(2.0))
    @Expect(floorPowerOfTwo(Float64(5.0)), Float64(4.0))
    @Expect(floorPowerOfTwo(Float64(1.0)), Float64(1.0))
}

@Test
func testFloorPowerOfTwoNegative(): Unit {
    @Expect(floorPowerOfTwo(Float64(-3.0)), Float64(-2.0))
    @Expect(floorPowerOfTwo(Float64(-5.0)), Float64(-4.0))
}

@Test
func testRoundMultiple(): Unit {
    @Expect(roundMultiple(Float64(3.0), Float64(2.0)), Float64(4.0))
    @Expect(roundMultiple(Float64(4.0), Float64(2.0)), Float64(4.0))
    @Expect(roundMultiple(Float64(5.0), Float64(2.0)), Float64(4.0))
    @Expect(roundMultiple(Float64(0.0), Float64(2.0)), Float64(0.0))
    @Expect(roundMultiple(Float64(-3.0), Float64(2.0)), Float64(-4.0))
    @Expect(roundMultiple(Float64.nan, Float64(2.0)).isNaN(), true)
    @Expect(roundMultiple(Float64.infinity(), Float64(2.0)), Float64.infinity())
}

@Test
func testCeilMultiple(): Unit {
    @Expect(ceilMultiple(Float64(3.0), Float64(2.0)), Float64(4.0))
    @Expect(ceilMultiple(Float64(4.0), Float64(2.0)), Float64(4.0))
    @Expect(ceilMultiple(Float64(5.0), Float64(2.0)), Float64(6.0))
    @Expect(ceilMultiple(Float64(0.0), Float64(2.0)), Float64(0.0))
    @Expect(ceilMultiple(Float64(-3.0), Float64(2.0)), Float64(-2.0))
}

@Test
func testFloorMultiple(): Unit {
    @Expect(floorMultiple(Float64(3.0), Float64(2.0)), Float64(2.0))
    @Expect(floorMultiple(Float64(4.0), Float64(2.0)), Float64(4.0))
    @Expect(floorMultiple(Float64(5.0), Float64(2.0)), Float64(4.0))
    @Expect(floorMultiple(Float64(0.0), Float64(2.0)), Float64(0.0))
    @Expect(floorMultiple(Float64(-3.0), Float64(2.0)), Float64(-4.0))
}

@Test
func testRoundPowerOfTwoNaNInf(): Unit {
    @Expect(roundPowerOfTwo(Float64.nan).isNaN(), true)
    @Expect(roundPowerOfTwo(Float64.infinity()), Float64.infinity())
    @Expect(roundPowerOfTwo(Float64(-Float64.infinity())), Float64(-Float64.infinity()))
}

@Test
func testMultipleNaNInf(): Unit {
    @Expect(ceilMultiple(Float64.nan, Float64(2.0)).isNaN(), true)
    @Expect(ceilMultiple(Float64.infinity(), Float64(2.0)), Float64.infinity())
    @Expect(floorMultiple(Float64.infinity(), Float64(2.0)), Float64.infinity())
}

@Test
func testRoundPowerOfTwoNegZero(): Unit {
    @ExpectTrue(roundPowerOfTwo(Float64(-0.0)).toBits() == Float64(-0.0).toBits())
}

@Test
func testCeilPowerOfTwoNegZero(): Unit {
    @ExpectTrue(ceilPowerOfTwo(Float64(-0.0)).toBits() == Float64(-0.0).toBits())
}

@Test
func testFloorPowerOfTwoNegZero(): Unit {
    @ExpectTrue(floorPowerOfTwo(Float64(-0.0)).toBits() == Float64(-0.0).toBits())
}
