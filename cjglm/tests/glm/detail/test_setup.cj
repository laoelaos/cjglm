package glm.detail

@Test
func testVersionMajor(): Unit {
    @Expect(GLM_VERSION_MAJOR, Int64(1))
}

@Test
func testVersionMinor(): Unit {
    @Expect(GLM_VERSION_MINOR, Int64(0))
}

@Test
func testVersionPatch(): Unit {
    @Expect(GLM_VERSION_PATCH, Int64(3))
}

@Test
func testVersionEncoded(): Unit {
    @Expect(GLM_VERSION, Int64(103))
}

@Test
func testConfigSimdDisabled(): Unit {
    @Expect(GLM_CONFIG_SIMD, false)
}

@Test
func testConfigAlignedGentypesDisabled(): Unit {
    @Expect(GLM_CONFIG_ALIGNED_GENTYPES, false)
}

@Test
func testConfigClipControlDisabled(): Unit {
    @Expect(GLM_CONFIG_CLIP_CONTROL, false)
}

// === Const Compile-Time Semantics ===

@Test
func testConstNegationSimd(): Unit {
    @Expect(!GLM_CONFIG_SIMD, true)
}

@Test
func testConstNegationAligned(): Unit {
    @Expect(!GLM_CONFIG_ALIGNED_GENTYPES, true)
}

@Test
func testConstNegationClip(): Unit {
    @Expect(!GLM_CONFIG_CLIP_CONTROL, true)
}

// === Type Compatibility ===

@Test
func testConstInt64Usage(): Unit {
    let sum: Int64 = GLM_VERSION_MAJOR + GLM_VERSION_MINOR + GLM_VERSION_PATCH
    @Expect(sum, Int64(4))
}

@Test
func testConstBoolUsage(): Unit {
    let allDisabled: Bool = !GLM_CONFIG_SIMD && !GLM_CONFIG_ALIGNED_GENTYPES && !GLM_CONFIG_CLIP_CONTROL
    @Expect(allDisabled, true)
}

// === Cross-Reference Consistency ===

@Test
func testVersionEncodingConsistency(): Unit {
    let expected: Int64 = GLM_VERSION_MAJOR * 100 + GLM_VERSION_PATCH
    @Expect(expected, GLM_VERSION)
}
