package glm.detail

import std.unittest.*
import std.unittest.testmacro.*

@Test
func testMinStub(): Unit {
    try {
        min(Float64(1.0), Float64(2.0))
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}

@Test
func testMaxStub(): Unit {
    try {
        max(Float64(1.0), Float64(3.0))
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}

@Test
func testAbsStub(): Unit {
    try {
        abs(Float64(-5.0))
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}

@Test
func testSignStub(): Unit {
    try {
        sign(Float64(-3.0))
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}

@Test
func testFloorStub(): Unit {
    try {
        floor(Float64(3.7))
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}

@Test
func testCeilStub(): Unit {
    try {
        ceil(Float64(3.2))
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}

@Test
func testFractStub(): Unit {
    try {
        fract(Float64(3.7))
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}

@Test
func testModStub(): Unit {
    try {
        mod(Int64(10), Int64(3))
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}

@Test
func testClampStub(): Unit {
    try {
        clamp(Float64(5.0), Float64(0.0), Float64(10.0))
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}

@Test
func testMixStub(): Unit {
    try {
        mix(Float64(1.0), Float64(2.0), Float64(0.5))
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}

@Test
func testStepStub(): Unit {
    try {
        step(Float64(0.5), Float64(1.0))
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}

@Test
func testSmoothstepStub(): Unit {
    try {
        smoothstep(Float64(0.0), Float64(1.0), Float64(0.5))
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}
