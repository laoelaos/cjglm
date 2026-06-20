package glm.detail

@Test
func testAssertTruePasses(): Unit {
    assert(true)
    @Expect(true, true)
}

@Test
func testAssertFalseThrowsException(): Unit {
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
