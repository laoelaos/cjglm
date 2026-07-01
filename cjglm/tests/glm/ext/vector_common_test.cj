package glm.ext
import glm.detail.{ Vec1, Vec2, Vec3, Vec4, Defaultp }
import std.unittest.*
import std.unittest.testmacro.*

@Test
func testMin3Vec2(): Unit {
    let a = Vec2<Float64, Defaultp>(3.0, 5.0)
    let b = Vec2<Float64, Defaultp>(1.0, 7.0)
    let c = Vec2<Float64, Defaultp>(2.0, 4.0)
    let r = min(a, b, c)
    @Expect(r.x, 1.0)
    @Expect(r.y, 4.0)
}

@Test
func testMax4Vec3(): Unit {
    let a = Vec3<Float64, Defaultp>(1.0, 5.0, 3.0)
    let b = Vec3<Float64, Defaultp>(4.0, 2.0, 6.0)
    let c = Vec3<Float64, Defaultp>(7.0, 1.0, 2.0)
    let d = Vec3<Float64, Defaultp>(0.0, 3.0, 5.0)
    let r = max(a, b, c, d)
    @Expect(r.x, 7.0)
    @Expect(r.y, 5.0)
    @Expect(r.z, 6.0)
}

@Test
func testFminVec2(): Unit {
    let a = Vec2<Float64, Defaultp>(1.0, 3.0)
    let b = Vec2<Float64, Defaultp>(2.0, 1.0)
    let r = fmin(a, b)
    @Expect(r.x, 1.0)
    @Expect(r.y, 1.0)
}

@Test
func testFmaxVec3(): Unit {
    let a = Vec3<Float64, Defaultp>(1.0, 3.0, 5.0)
    let b = Vec3<Float64, Defaultp>(2.0, 1.0, 4.0)
    let r = fmax(a, b)
    @Expect(r.x, 2.0)
    @Expect(r.y, 3.0)
    @Expect(r.z, 5.0)
}

@Test
func testFclampVec2(): Unit {
    let x = Vec2<Float64, Defaultp>(0.5, 1.5)
    let r = fclamp(x, 0.0, 1.0)
    @Expect(r.x, 0.5)
    @Expect(r.y, 1.0)
}

@Test
func testClampTexcoordVec2(): Unit {
    let tc = Vec2<Float64, Defaultp>(1.5, -0.5)
    let r = clamp(tc)
    @Expect(r.x, 1.0)
    @Expect(r.y, 0.0)
}

@Test
func testRepeatVec2(): Unit {
    let tc = Vec2<Float64, Defaultp>(2.7, -0.3)
    let r = repeat(tc)
    @Expect(r.x, 0.7)
    @Expect(r.y, 0.7)
}

@Test
func testIroundVec2(): Unit {
    let x = Vec2<Float64, Defaultp>(1.2, 3.7)
    let r = iround(x)
    @Expect(r.x, 1)
    @Expect(r.y, 4)
}

@Test
func testUroundVec2(): Unit {
    let x = Vec2<Float64, Defaultp>(1.2, 3.7)
    let r = uround(x)
    @Expect(r.x, 1u64)
    @Expect(r.y, 4u64)
}

@Test
func testMin3Vec3(): Unit {
    let a = Vec3<Float64, Defaultp>(3.0, 5.0, 2.0)
    let b = Vec3<Float64, Defaultp>(1.0, 7.0, 4.0)
    let c = Vec3<Float64, Defaultp>(2.0, 4.0, 6.0)
    let r = min(a, b, c)
    @Expect(r.x, 1.0)
    @Expect(r.y, 4.0)
    @Expect(r.z, 2.0)
}

@Test
func testFminVec3Scalar(): Unit {
    let a = Vec3<Float64, Defaultp>(1.0, 3.0, 5.0)
    let r = fmin(a, 3.0)
    @Expect(r.x, 1.0)
    @Expect(r.y, 3.0)
    @Expect(r.z, 3.0)
}

@Test
func testFclampVec3(): Unit {
    let x = Vec3<Float64, Defaultp>(0.5, 1.5, -0.5)
    let r = fclamp(x, 0.0, 1.0)
    @Expect(r.x, 0.5)
    @Expect(r.y, 1.0)
    @Expect(r.z, 0.0)
}

@Test
func testMirrorRepeatVec2(): Unit {
    let tc = Vec2<Float64, Defaultp>(1.3, -0.7)
    let r = mirrorRepeat(tc)
    @Expect((r.x - 0.3).abs() < 1e-10, true)
    @Expect((r.y - 0.7).abs() < 1e-10, true)
}

@Test
func testIroundVec3(): Unit {
    let x = Vec3<Float64, Defaultp>(1.2, 3.7, -0.5)
    let r = iround(x)
    @Expect(r.x, 1)
    @Expect(r.y, 4)
    @Expect(r.z, -1)
}

// ── fmin 3-input vector ──

@Test
func testFmin3Vec2(): Unit {
    let a = Vec2<Float64, Defaultp>(3.0, 5.0)
    let b = Vec2<Float64, Defaultp>(1.0, 7.0)
    let c = Vec2<Float64, Defaultp>(2.0, 4.0)
    let r = fmin(a, b, c)
    @Expect(r.x, 1.0)
    @Expect(r.y, 4.0)
}

@Test
func testFmin3Vec3(): Unit {
    let a = Vec3<Float64, Defaultp>(3.0, 5.0, 8.0)
    let b = Vec3<Float64, Defaultp>(1.0, 7.0, 2.0)
    let c = Vec3<Float64, Defaultp>(2.0, 4.0, 6.0)
    let r = fmin(a, b, c)
    @Expect(r.x, 1.0)
    @Expect(r.y, 4.0)
    @Expect(r.z, 2.0)
}

@Test
func testFmin3Vec4(): Unit {
    let a = Vec4<Float64, Defaultp>(4.0, 3.0, 2.0, 1.0)
    let b = Vec4<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let c = Vec4<Float64, Defaultp>(3.0, 1.0, 4.0, 2.0)
    let r = fmin(a, b, c)
    @Expect(r.x, 1.0)
    @Expect(r.y, 1.0)
    @Expect(r.z, 2.0)
    @Expect(r.w, 1.0)
}

@Test
func testFmin3Vec1(): Unit {
    let a = Vec1<Float64, Defaultp>(3.0)
    let b = Vec1<Float64, Defaultp>(1.0)
    let c = Vec1<Float64, Defaultp>(2.0)
    let r = fmin(a, b, c)
    @Expect(r.x, 1.0)
}

// ── fmin 4-input vector ──

@Test
func testFmin4Vec2(): Unit {
    let a = Vec2<Float64, Defaultp>(4.0, 3.0)
    let b = Vec2<Float64, Defaultp>(1.0, 5.0)
    let c = Vec2<Float64, Defaultp>(3.0, 2.0)
    let d = Vec2<Float64, Defaultp>(2.0, 4.0)
    let r = fmin(a, b, c, d)
    @Expect(r.x, 1.0)
    @Expect(r.y, 2.0)
}

@Test
func testFmin4Vec3(): Unit {
    let a = Vec3<Float64, Defaultp>(4.0, 3.0, 2.0)
    let b = Vec3<Float64, Defaultp>(1.0, 5.0, 3.0)
    let c = Vec3<Float64, Defaultp>(3.0, 2.0, 4.0)
    let d = Vec3<Float64, Defaultp>(2.0, 4.0, 1.0)
    let r = fmin(a, b, c, d)
    @Expect(r.x, 1.0)
    @Expect(r.y, 2.0)
    @Expect(r.z, 1.0)
}

@Test
func testFmin4Vec4(): Unit {
    let a = Vec4<Float64, Defaultp>(4.0, 3.0, 2.0, 1.0)
    let b = Vec4<Float64, Defaultp>(1.0, 5.0, 3.0, 4.0)
    let c = Vec4<Float64, Defaultp>(3.0, 2.0, 4.0, 2.0)
    let d = Vec4<Float64, Defaultp>(2.0, 4.0, 1.0, 3.0)
    let r = fmin(a, b, c, d)
    @Expect(r.x, 1.0)
    @Expect(r.y, 2.0)
    @Expect(r.z, 1.0)
    @Expect(r.w, 1.0)
}

@Test
func testFmin4Vec1(): Unit {
    let a = Vec1<Float64, Defaultp>(4.0)
    let b = Vec1<Float64, Defaultp>(1.0)
    let c = Vec1<Float64, Defaultp>(3.0)
    let d = Vec1<Float64, Defaultp>(2.0)
    let r = fmin(a, b, c, d)
    @Expect(r.x, 1.0)
}

// ── fmax 3-input vector ──

@Test
func testFmax3Vec2(): Unit {
    let a = Vec2<Float64, Defaultp>(1.0, 3.0)
    let b = Vec2<Float64, Defaultp>(2.0, 1.0)
    let c = Vec2<Float64, Defaultp>(3.0, 2.0)
    let r = fmax(a, b, c)
    @Expect(r.x, 3.0)
    @Expect(r.y, 3.0)
}

@Test
func testFmax3Vec3(): Unit {
    let a = Vec3<Float64, Defaultp>(1.0, 3.0, 5.0)
    let b = Vec3<Float64, Defaultp>(2.0, 1.0, 4.0)
    let c = Vec3<Float64, Defaultp>(3.0, 2.0, 6.0)
    let r = fmax(a, b, c)
    @Expect(r.x, 3.0)
    @Expect(r.y, 3.0)
    @Expect(r.z, 6.0)
}

@Test
func testFmax3Vec4(): Unit {
    let a = Vec4<Float64, Defaultp>(1.0, 3.0, 5.0, 2.0)
    let b = Vec4<Float64, Defaultp>(2.0, 1.0, 4.0, 6.0)
    let c = Vec4<Float64, Defaultp>(3.0, 2.0, 6.0, 4.0)
    let r = fmax(a, b, c)
    @Expect(r.x, 3.0)
    @Expect(r.y, 3.0)
    @Expect(r.z, 6.0)
    @Expect(r.w, 6.0)
}

@Test
func testFmax3Vec1(): Unit {
    let a = Vec1<Float64, Defaultp>(1.0)
    let b = Vec1<Float64, Defaultp>(2.0)
    let c = Vec1<Float64, Defaultp>(3.0)
    let r = fmax(a, b, c)
    @Expect(r.x, 3.0)
}

// ── fmax 4-input vector ──

@Test
func testFmax4Vec2(): Unit {
    let a = Vec2<Float64, Defaultp>(1.0, 3.0)
    let b = Vec2<Float64, Defaultp>(2.0, 1.0)
    let c = Vec2<Float64, Defaultp>(4.0, 2.0)
    let d = Vec2<Float64, Defaultp>(3.0, 5.0)
    let r = fmax(a, b, c, d)
    @Expect(r.x, 4.0)
    @Expect(r.y, 5.0)
}

@Test
func testFmax4Vec3(): Unit {
    let a = Vec3<Float64, Defaultp>(1.0, 3.0, 5.0)
    let b = Vec3<Float64, Defaultp>(2.0, 1.0, 4.0)
    let c = Vec3<Float64, Defaultp>(4.0, 2.0, 6.0)
    let d = Vec3<Float64, Defaultp>(3.0, 5.0, 2.0)
    let r = fmax(a, b, c, d)
    @Expect(r.x, 4.0)
    @Expect(r.y, 5.0)
    @Expect(r.z, 6.0)
}

@Test
func testFmax4Vec4(): Unit {
    let a = Vec4<Float64, Defaultp>(1.0, 3.0, 5.0, 2.0)
    let b = Vec4<Float64, Defaultp>(2.0, 1.0, 4.0, 6.0)
    let c = Vec4<Float64, Defaultp>(4.0, 2.0, 6.0, 3.0)
    let d = Vec4<Float64, Defaultp>(3.0, 5.0, 2.0, 4.0)
    let r = fmax(a, b, c, d)
    @Expect(r.x, 4.0)
    @Expect(r.y, 5.0)
    @Expect(r.z, 6.0)
    @Expect(r.w, 6.0)
}

@Test
func testFmax4Vec1(): Unit {
    let a = Vec1<Float64, Defaultp>(1.0)
    let b = Vec1<Float64, Defaultp>(2.0)
    let c = Vec1<Float64, Defaultp>(4.0)
    let d = Vec1<Float64, Defaultp>(3.0)
    let r = fmax(a, b, c, d)
    @Expect(r.x, 4.0)
}

// ── NaN protection ──

@Test
func testFmin3Vec2WithNaN(): Unit {
    let a = Vec2<Float64, Defaultp>(Float64.getNaN(), 5.0)
    let b = Vec2<Float64, Defaultp>(1.0, Float64.getNaN())
    let c = Vec2<Float64, Defaultp>(2.0, 4.0)
    let r = fmin(a, b, c)
    @Expect(r.x, 1.0)
    @Expect(r.y, 4.0)
}

@Test
func testFmax3Vec3WithNaN(): Unit {
    let a = Vec3<Float64, Defaultp>(1.0, Float64.getNaN(), 3.0)
    let b = Vec3<Float64, Defaultp>(2.0, 4.0, Float64.getNaN())
    let c = Vec3<Float64, Defaultp>(3.0, 2.0, 5.0)
    let r = fmax(a, b, c)
    @Expect(r.x, 3.0)
    @Expect(r.y, 4.0)
    @Expect(r.z, 5.0)
}

@Test
func testFmin4Vec3WithNaN(): Unit {
    let a = Vec3<Float64, Defaultp>(Float64.getNaN(), 3.0, 1.0)
    let b = Vec3<Float64, Defaultp>(2.0, Float64.getNaN(), 3.0)
    let c = Vec3<Float64, Defaultp>(3.0, 1.0, Float64.getNaN())
    let d = Vec3<Float64, Defaultp>(1.0, 2.0, 2.0)
    let r = fmin(a, b, c, d)
    @Expect(r.x, 1.0)
    @Expect(r.y, 1.0)
    @Expect(r.z, 1.0)
}

@Test
func testFmax4Vec2WithNaN(): Unit {
    let a = Vec2<Float64, Defaultp>(1.0, Float64.getNaN())
    let b = Vec2<Float64, Defaultp>(Float64.getNaN(), 2.0)
    let c = Vec2<Float64, Defaultp>(3.0, 4.0)
    let d = Vec2<Float64, Defaultp>(2.0, 3.0)
    let r = fmax(a, b, c, d)
    @Expect(r.x, 3.0)
    @Expect(r.y, 4.0)
}

// ── G25: Vec1/Vec4 2-input fmin/fmax/fclamp ──

@Test
func testFminVec1(): Unit {
    let a = Vec1<Float64, Defaultp>(1.0)
    let b = Vec1<Float64, Defaultp>(2.0)
    let r = fmin(a, b)
    @Expect(r.x, 1.0)
}

@Test
func testFmaxVec1(): Unit {
    let a = Vec1<Float64, Defaultp>(1.0)
    let b = Vec1<Float64, Defaultp>(2.0)
    let r = fmax(a, b)
    @Expect(r.x, 2.0)
}

@Test
func testFclampVec1(): Unit {
    let x = Vec1<Float64, Defaultp>(0.5)
    let r = fclamp(x, 0.0, 1.0)
    @Expect(r.x, 0.5)
}

@Test
func testFminVec4(): Unit {
    let a = Vec4<Float64, Defaultp>(1.0, 3.0, 5.0, 7.0)
    let b = Vec4<Float64, Defaultp>(2.0, 1.0, 4.0, 6.0)
    let r = fmin(a, b)
    @Expect(r.x, 1.0)
    @Expect(r.y, 1.0)
    @Expect(r.z, 4.0)
    @Expect(r.w, 6.0)
}

@Test
func testFmaxVec4(): Unit {
    let a = Vec4<Float64, Defaultp>(1.0, 3.0, 5.0, 2.0)
    let b = Vec4<Float64, Defaultp>(2.0, 1.0, 4.0, 6.0)
    let r = fmax(a, b)
    @Expect(r.x, 2.0)
    @Expect(r.y, 3.0)
    @Expect(r.z, 5.0)
    @Expect(r.w, 6.0)
}

@Test
func testFclampVec4(): Unit {
    let x = Vec4<Float64, Defaultp>(0.5, 1.5, -0.5, 2.0)
    let r = fclamp(x, 0.0, 1.0)
    @Expect(r.x, 0.5)
    @Expect(r.y, 1.0)
    @Expect(r.z, 0.0)
    @Expect(r.w, 1.0)
}

// ── G26: fclamp 边界值测试 ──

// Vec2 boundary
@Test
func testFclampVec2Underflow(): Unit {
    let x = Vec2<Float64, Defaultp>(-1.0, -1.0)
    let r = fclamp(x, 0.0, 1.0)
    @Expect(r.x, 0.0)
    @Expect(r.y, 0.0)
}

@Test
func testFclampVec2Overflow(): Unit {
    let x = Vec2<Float64, Defaultp>(2.0, 2.0)
    let r = fclamp(x, 0.0, 1.0)
    @Expect(r.x, 1.0)
    @Expect(r.y, 1.0)
}

@Test
func testFclampVec2ZeroWidth(): Unit {
    let x = Vec2<Float64, Defaultp>(0.3, 0.7)
    let r = fclamp(x, 0.5, 0.5)
    @Expect(r.x, 0.5)
    @Expect(r.y, 0.5)
}

@Test
func testFclampVec2NaN(): Unit {
    let x = Vec2<Float64, Defaultp>(Float64.getNaN(), 0.5)
    let r = fclamp(x, 0.0, 1.0)
    @Expect(r.x, 0.0)
    @Expect(r.y, 0.5)
}

// Vec3 boundary
@Test
func testFclampVec3Underflow(): Unit {
    let x = Vec3<Float64, Defaultp>(-1.0, -1.0, -1.0)
    let r = fclamp(x, 0.0, 1.0)
    @Expect(r.x, 0.0)
    @Expect(r.y, 0.0)
    @Expect(r.z, 0.0)
}

@Test
func testFclampVec3Overflow(): Unit {
    let x = Vec3<Float64, Defaultp>(2.0, 2.0, 2.0)
    let r = fclamp(x, 0.0, 1.0)
    @Expect(r.x, 1.0)
    @Expect(r.y, 1.0)
    @Expect(r.z, 1.0)
}

@Test
func testFclampVec3ZeroWidth(): Unit {
    let x = Vec3<Float64, Defaultp>(0.3, 0.7, 0.5)
    let r = fclamp(x, 0.5, 0.5)
    @Expect(r.x, 0.5)
    @Expect(r.y, 0.5)
    @Expect(r.z, 0.5)
}

@Test
func testFclampVec3NaN(): Unit {
    let x = Vec3<Float64, Defaultp>(Float64.getNaN(), 0.5, 0.5)
    let r = fclamp(x, 0.0, 1.0)
    @Expect(r.x, 0.0)
    @Expect(r.y, 0.5)
    @Expect(r.z, 0.5)
}

// Vec4 boundary
@Test
func testFclampVec4Underflow(): Unit {
    let x = Vec4<Float64, Defaultp>(-1.0, -1.0, -1.0, -1.0)
    let r = fclamp(x, 0.0, 1.0)
    @Expect(r.x, 0.0)
    @Expect(r.y, 0.0)
    @Expect(r.z, 0.0)
    @Expect(r.w, 0.0)
}

@Test
func testFclampVec4Overflow(): Unit {
    let x = Vec4<Float64, Defaultp>(2.0, 2.0, 2.0, 2.0)
    let r = fclamp(x, 0.0, 1.0)
    @Expect(r.x, 1.0)
    @Expect(r.y, 1.0)
    @Expect(r.z, 1.0)
    @Expect(r.w, 1.0)
}

@Test
func testFclampVec4ZeroWidth(): Unit {
    let x = Vec4<Float64, Defaultp>(0.3, 0.7, 0.5, 0.2)
    let r = fclamp(x, 0.5, 0.5)
    @Expect(r.x, 0.5)
    @Expect(r.y, 0.5)
    @Expect(r.z, 0.5)
    @Expect(r.w, 0.5)
}

@Test
func testFclampVec4NaN(): Unit {
    let x = Vec4<Float64, Defaultp>(Float64.getNaN(), 0.5, 0.5, 0.5)
    let r = fclamp(x, 0.0, 1.0)
    @Expect(r.x, 0.0)
    @Expect(r.y, 0.5)
    @Expect(r.z, 0.5)
    @Expect(r.w, 0.5)
}
