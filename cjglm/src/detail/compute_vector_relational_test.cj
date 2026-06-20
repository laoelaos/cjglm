package glm.detail

import std.unittest.*
import std.unittest.testmacro.*

@Test
func testComputeEqualInt32Equal(): Unit {
    @Expect(ComputeEqual<Int32>.call(1, 1), true)
}

@Test
func testComputeEqualInt32NotEqual(): Unit {
    @Expect(ComputeEqual<Int32>.call(1, 2), false)
}

@Test
func testComputeEqualFloat32Equal(): Unit {
    @Expect(ComputeEqual<Float32>.call(1.0f32, 1.0f32), true)
}

@Test
func testComputeEqualFloat32NotEqual(): Unit {
    @Expect(ComputeEqual<Float32>.call(1.0f32, 2.0f32), false)
}

@Test
func testComputeEqualFloat64Equal(): Unit {
    @Expect(ComputeEqual<Float64>.call(1.0, 1.0), true)
}

@Test
func testComputeEqualFloat64NotEqual(): Unit {
    @Expect(ComputeEqual<Float64>.call(1.0, 2.0), false)
}

@Test
func testComputeEqualBoolEqual(): Unit {
    @Expect(ComputeEqual<Bool>.call(true, true), true)
}

@Test
func testComputeEqualBoolNotEqual(): Unit {
    @Expect(ComputeEqual<Bool>.call(true, false), false)
}

@Test
func testComputeEqualNumericInt32(): Unit {
    @Expect(ComputeEqualNumeric<Int32>.callConst(1, 1), true)
    @Expect(ComputeEqualNumeric<Int32>.callConst(1, 2), false)
}

@Test
func testComputeEqualNumericFloat32(): Unit {
    @Expect(ComputeEqualNumeric<Float32>.callConst(1.0f32, 1.0f32), true)
}

@Test
func testComputeEqualNumericFloat32Epsilon(): Unit {
    let a: Float32 = 1.0
    let b: Float32 = 1.0 + epsilonOf(1.0f32) / Float32(2.0)
    @Expect(ComputeEqualNumeric<Float32>.callConst(a, b), true)
}

@Test
func testComputeEqualNumericFloat64(): Unit {
    @Expect(ComputeEqualNumeric<Float64>.callConst(1.0, 1.0), true)
}

@Test
func testComputeEqualInt64Equal(): Unit {
    @Expect(ComputeEqual<Int64>.call(100, 100), true)
}

@Test
func testComputeEqualInt64NotEqual(): Unit {
    @Expect(ComputeEqual<Int64>.call(100, 200), false)
}

@Test
func testComputeEqualFloat32Nan(): Unit {
    let nan = Float32(0.0) / Float32(0.0)
    @Expect(ComputeEqual<Float32>.call(nan, nan), false)
}

@Test
func testComputeEqualFloat64Nan(): Unit {
    let nan = Float64(0.0) / Float64(0.0)
    @Expect(ComputeEqual<Float64>.call(nan, nan), false)
}

@Test
func testComputeEqualFloat32SignedZero(): Unit {
    @Expect(ComputeEqual<Float32>.call(-0.0f32, 0.0f32), true)
}

@Test
func testComputeEqualFloat64SignedZero(): Unit {
    @Expect(ComputeEqual<Float64>.call(-0.0, 0.0), true)
}

@Test
func testComputeEqualNumericFloat32NotEqual(): Unit {
    @Expect(ComputeEqualNumeric<Float32>.callConst(1.0f32, 2.0f32), false)
}

@Test
func testComputeEqualNumericFloat32BeyondEpsilon(): Unit {
    let a: Float32 = 1.0
    let b: Float32 = 1.0 + epsilonOf(1.0f32) * Float32(2.0)
    @Expect(ComputeEqualNumeric<Float32>.callConst(a, b), false)
}

@Test
func testComputeEqualNumericFloat64NotEqual(): Unit {
    @Expect(ComputeEqualNumeric<Float64>.callConst(1.0, 2.0), false)
}

@Test
func testComputeEqualNumericFloat64Epsilon(): Unit {
    let a: Float64 = 1.0
    let b: Float64 = 1.0 + epsilonOf(1.0) / Float64(2.0)
    @Expect(ComputeEqualNumeric<Float64>.callConst(a, b), true)
}

@Test
func testComputeEqualNumericFloat64BeyondEpsilon(): Unit {
    let a: Float64 = 1.0
    let b: Float64 = 1.0 + epsilonOf(1.0) * Float64(2.0)
    @Expect(ComputeEqualNumeric<Float64>.callConst(a, b), false)
}

@Test
func testComputeEqualNumericInt64(): Unit {
    @Expect(ComputeEqualNumeric<Int64>.callConst(100, 100), true)
    @Expect(ComputeEqualNumeric<Int64>.callConst(100, 200), false)
}
