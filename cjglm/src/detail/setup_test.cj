package glm.detail

import std.unittest.*
import std.unittest.testmacro.*

// === Value Correctness ===

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
func testConfigSimd(): Unit {
    @Expect(GLM_CONFIG_SIMD, false)
}

@Test
func testConfigAlignedGentypes(): Unit {
    @Expect(GLM_CONFIG_ALIGNED_GENTYPES, false)
}

@Test
func testConfigClipControl(): Unit {
    @Expect(GLM_CONFIG_CLIP_CONTROL, false)
}

// === Compile-Time Const Semantics ===
// `const` enables compile-time derivation from config constants.

private const GLM_NOT_SIMD: Bool = !GLM_CONFIG_SIMD
private const GLM_NOT_ALIGNED: Bool = !GLM_CONFIG_ALIGNED_GENTYPES
private const GLM_NOT_CLIP: Bool = !GLM_CONFIG_CLIP_CONTROL

@Test
func testConstNegationSimd(): Unit {
    @Expect(GLM_NOT_SIMD, true)
}

@Test
func testConstNegationAligned(): Unit {
    @Expect(GLM_NOT_ALIGNED, true)
}

@Test
func testConstNegationClip(): Unit {
    @Expect(GLM_NOT_CLIP, true)
}

// === Type Compatibility ===
// Config constants are usable where their declared type is expected.

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
// Encoded version matches its individual components.

@Test
func testVersionEncodingConsistency(): Unit {
    let expected: Int64 = GLM_VERSION_MAJOR * 100 + GLM_VERSION_PATCH
    @Expect(expected, GLM_VERSION)
}
