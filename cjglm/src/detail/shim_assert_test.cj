package glm.detail

import std.unittest.*
import std.unittest.testmacro.*

@Test
func testAssertPasses(): Unit {
    assert(true)
    @Expect(true, true)
}

@Test
func testAssertFails(): Unit {
    try {
        assert(false)
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}

@Test
func testAssertWithCustomMessage(): Unit {
    try {
        assert(false, message: "Custom error")
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "Custom error")
    }
}
