package glm

import std.unittest.*
import std.unittest.testmacro.*

@Test
func testExtMat4x4Alias(): Unit {
    let _m: ext.Mat4x4 = ext.Mat4x4(Float32(1.0))
    @Expect(true, true)
}

@Test
func testExtMat2x2Alias(): Unit {
    let _m: ext.Mat2x2 = ext.Mat2x2(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))
    @Expect(true, true)
}

@Test
func testExtMat3x3Alias(): Unit {
    let _m: ext.Mat3x3 = ext.Mat3x3(Float32(1.0))
    @Expect(true, true)
}

@Test
func testExtMat2x3Alias(): Unit {
    let _m: ext.Mat2x3 = ext.Mat2x3(Float32(1.0))
    @Expect(true, true)
}

@Test
func testExtMat2x4Alias(): Unit {
    let _m: ext.Mat2x4 = ext.Mat2x4(Float32(1.0))
    @Expect(true, true)
}

@Test
func testExtMat3x2Alias(): Unit {
    let _m: ext.Mat3x2 = ext.Mat3x2(Float32(1.0))
    @Expect(true, true)
}

@Test
func testExtMat3x4Alias(): Unit {
    let _m: ext.Mat3x4 = ext.Mat3x4(Float32(1.0))
    @Expect(true, true)
}

@Test
func testExtMat4x2Alias(): Unit {
    let _m: ext.Mat4x2 = ext.Mat4x2(Float32(1.0))
    @Expect(true, true)
}

@Test
func testExtMat4x3Alias(): Unit {
    let _m: ext.Mat4x3 = ext.Mat4x3(Float32(1.0))
    @Expect(true, true)
}

@Test
func testExtDMat2x2Alias(): Unit {
    let _m: ext.DMat2x2 = ext.DMat2x2(Float64(1.0))
    @Expect(true, true)
}

@Test
func testExtDMat4x4Alias(): Unit {
    let _m: ext.DMat4x4 = ext.DMat4x4(Float64(1.0))
    @Expect(true, true)
}

@Test
func testExtVec4Alias(): Unit {
    let _v: ext.Vec4 = ext.Vec4(Float32(1.0))
    @Expect(true, true)
}

@Test
func testExtVec2Alias(): Unit {
    let _v: ext.Vec2 = ext.Vec2(Float32(1.0), Float32(2.0))
    @Expect(true, true)
}

@Test
func testExtDVec4Alias(): Unit {
    let _v: ext.DVec4 = ext.DVec4(Float64(1.0))
    @Expect(true, true)
}

@Test
func testExtCompatibilityWithFwd(): Unit {
    let fromExt: ext.Mat4x4 = ext.Mat4x4(Float32(1.0))
    let fromFwd: Mat4x4 = fromExt
    @Expect(fromFwd.c0.x, Float32(1.0))
}

@Test
func testExtConstructAndRead(): Unit {
    let m: ext.Mat4x4 = ext.Mat4x4(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0), Float32(7.0), Float32(8.0), Float32(9.0), Float32(10.0), Float32(11.0), Float32(12.0), Float32(13.0), Float32(14.0), Float32(15.0), Float32(16.0))
    @Expect(m.c0.x, Float32(1.0))
    @Expect(m.c3.w, Float32(16.0))
}
