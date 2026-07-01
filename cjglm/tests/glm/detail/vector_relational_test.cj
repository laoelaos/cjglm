package glm.detail

import std.unittest.*
import std.unittest.testmacro.*

// ── equal ──

@Test
func testEqualVec1Float64Equal(): Unit {
    let a = Vec1<Float64, Defaultp>(3.0)
    let b = Vec1<Float64, Defaultp>(3.0)
    let r = equal(a, b)
    @Expect(r.x, true)
}

@Test
func testEqualVec1Float64NotEqual(): Unit {
    let a = Vec1<Float64, Defaultp>(3.0)
    let b = Vec1<Float64, Defaultp>(5.0)
    let r = equal(a, b)
    @Expect(r.x, false)
}

@Test
func testEqualVec1Int64Equal(): Unit {
    let a = Vec1<Int64, Defaultp>(Int64(42))
    let b = Vec1<Int64, Defaultp>(Int64(42))
    let r = equal(a, b)
    @Expect(r.x, true)
}

@Test
func testEqualVec2AllEqual(): Unit {
    let a = Vec2<Float64, Defaultp>(1.0, 2.0)
    let b = Vec2<Float64, Defaultp>(1.0, 2.0)
    let r = equal(a, b)
    @Expect(r.x, true)
    @Expect(r.y, true)
}

@Test
func testEqualVec2Mixed(): Unit {
    let a = Vec2<Float64, Defaultp>(1.0, 2.0)
    let b = Vec2<Float64, Defaultp>(1.0, 3.0)
    let r = equal(a, b)
    @Expect(r.x, true)
    @Expect(r.y, false)
}

@Test
func testEqualVec2AllNotEqual(): Unit {
    let a = Vec2<Float64, Defaultp>(1.0, 2.0)
    let b = Vec2<Float64, Defaultp>(3.0, 4.0)
    let r = equal(a, b)
    @Expect(r.x, false)
    @Expect(r.y, false)
}

@Test
func testEqualVec3AllEqual(): Unit {
    let a = Vec3<Float64, Defaultp>(1.0, 2.0, 3.0)
    let b = Vec3<Float64, Defaultp>(1.0, 2.0, 3.0)
    let r = equal(a, b)
    @Expect(r.x, true)
    @Expect(r.y, true)
    @Expect(r.z, true)
}

@Test
func testEqualVec3Mixed(): Unit {
    let a = Vec3<Float64, Defaultp>(1.0, 2.0, 3.0)
    let b = Vec3<Float64, Defaultp>(1.0, 5.0, 3.0)
    let r = equal(a, b)
    @Expect(r.x, true)
    @Expect(r.y, false)
    @Expect(r.z, true)
}

@Test
func testEqualVec4AllEqual(): Unit {
    let a = Vec4<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let b = Vec4<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let r = equal(a, b)
    @Expect(r.x, true)
    @Expect(r.y, true)
    @Expect(r.z, true)
    @Expect(r.w, true)
}

@Test
func testEqualVec4Mixed(): Unit {
    let a = Vec4<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let b = Vec4<Float64, Defaultp>(1.0, 2.0, 9.0, 4.0)
    let r = equal(a, b)
    @Expect(r.x, true)
    @Expect(r.y, true)
    @Expect(r.z, false)
    @Expect(r.w, true)
}

@Test
func testEqualVec4AllNotEqual(): Unit {
    let a = Vec4<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let b = Vec4<Float64, Defaultp>(5.0, 6.0, 7.0, 8.0)
    let r = equal(a, b)
    @Expect(r.x, false)
    @Expect(r.y, false)
    @Expect(r.z, false)
    @Expect(r.w, false)
}

// ── notEqual ──

@Test
func testNotEqualVec1Float64NotEqual(): Unit {
    let a = Vec1<Float64, Defaultp>(3.0)
    let b = Vec1<Float64, Defaultp>(5.0)
    let r = notEqual(a, b)
    @Expect(r.x, true)
}

@Test
func testNotEqualVec1Float64Equal(): Unit {
    let a = Vec1<Float64, Defaultp>(3.0)
    let b = Vec1<Float64, Defaultp>(3.0)
    let r = notEqual(a, b)
    @Expect(r.x, false)
}

@Test
func testNotEqualVec2Mixed(): Unit {
    let a = Vec2<Float64, Defaultp>(1.0, 2.0)
    let b = Vec2<Float64, Defaultp>(1.0, 3.0)
    let r = notEqual(a, b)
    @Expect(r.x, false)
    @Expect(r.y, true)
}

@Test
func testNotEqualVec2AllEqual(): Unit {
    let a = Vec2<Float64, Defaultp>(1.0, 2.0)
    let b = Vec2<Float64, Defaultp>(1.0, 2.0)
    let r = notEqual(a, b)
    @Expect(r.x, false)
    @Expect(r.y, false)
}

@Test
func testNotEqualVec3Mixed(): Unit {
    let a = Vec3<Float64, Defaultp>(1.0, 2.0, 3.0)
    let b = Vec3<Float64, Defaultp>(1.0, 5.0, 3.0)
    let r = notEqual(a, b)
    @Expect(r.x, false)
    @Expect(r.y, true)
    @Expect(r.z, false)
}

@Test
func testNotEqualVec4Mixed(): Unit {
    let a = Vec4<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let b = Vec4<Float64, Defaultp>(1.0, 2.0, 9.0, 4.0)
    let r = notEqual(a, b)
    @Expect(r.x, false)
    @Expect(r.y, false)
    @Expect(r.z, true)
    @Expect(r.w, false)
}

@Test
func testNotEqualVec4AllNotEqual(): Unit {
    let a = Vec4<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let b = Vec4<Float64, Defaultp>(5.0, 6.0, 7.0, 8.0)
    let r = notEqual(a, b)
    @Expect(r.x, true)
    @Expect(r.y, true)
    @Expect(r.z, true)
    @Expect(r.w, true)
}

// ── any ──

@Test
func testAnyVec1False(): Unit {
    let v = Vec1<Bool, Defaultp>(false)
    @Expect(any(v), false)
}

@Test
func testAnyVec1True(): Unit {
    let v = Vec1<Bool, Defaultp>(true)
    @Expect(any(v), true)
}

@Test
func testAnyVec2AllFalse(): Unit {
    let v = Vec2<Bool, Defaultp>(false, false)
    @Expect(any(v), false)
}

@Test
func testAnyVec2FirstTrue(): Unit {
    let v = Vec2<Bool, Defaultp>(true, false)
    @Expect(any(v), true)
}

@Test
func testAnyVec2SecondTrue(): Unit {
    let v = Vec2<Bool, Defaultp>(false, true)
    @Expect(any(v), true)
}

@Test
func testAnyVec3AllFalse(): Unit {
    let v = Vec3<Bool, Defaultp>(false, false, false)
    @Expect(any(v), false)
}

@Test
func testAnyVec3LastTrue(): Unit {
    let v = Vec3<Bool, Defaultp>(false, false, true)
    @Expect(any(v), true)
}

@Test
func testAnyVec4AllFalse(): Unit {
    let v = Vec4<Bool, Defaultp>(false, false, false, false)
    @Expect(any(v), false)
}

@Test
func testAnyVec4FirstTrue(): Unit {
    let v = Vec4<Bool, Defaultp>(true, false, false, false)
    @Expect(any(v), true)
}

@Test
func testAnyVec4LastTrue(): Unit {
    let v = Vec4<Bool, Defaultp>(false, false, false, true)
    @Expect(any(v), true)
}

@Test
func testAnyVec4AllTrue(): Unit {
    let v = Vec4<Bool, Defaultp>(true, true, true, true)
    @Expect(any(v), true)
}

// ── all ──

@Test
func testAllVec1True(): Unit {
    let v = Vec1<Bool, Defaultp>(true)
    @Expect(all(v), true)
}

@Test
func testAllVec1False(): Unit {
    let v = Vec1<Bool, Defaultp>(false)
    @Expect(all(v), false)
}

@Test
func testAllVec2AllTrue(): Unit {
    let v = Vec2<Bool, Defaultp>(true, true)
    @Expect(all(v), true)
}

@Test
func testAllVec2FirstFalse(): Unit {
    let v = Vec2<Bool, Defaultp>(false, true)
    @Expect(all(v), false)
}

@Test
func testAllVec2SecondFalse(): Unit {
    let v = Vec2<Bool, Defaultp>(true, false)
    @Expect(all(v), false)
}

@Test
func testAllVec3AllTrue(): Unit {
    let v = Vec3<Bool, Defaultp>(true, true, true)
    @Expect(all(v), true)
}

@Test
func testAllVec3MiddleFalse(): Unit {
    let v = Vec3<Bool, Defaultp>(true, false, true)
    @Expect(all(v), false)
}

@Test
func testAllVec4AllTrue(): Unit {
    let v = Vec4<Bool, Defaultp>(true, true, true, true)
    @Expect(all(v), true)
}

@Test
func testAllVec4FirstFalse(): Unit {
    let v = Vec4<Bool, Defaultp>(false, true, true, true)
    @Expect(all(v), false)
}

@Test
func testAllVec4LastFalse(): Unit {
    let v = Vec4<Bool, Defaultp>(true, true, true, false)
    @Expect(all(v), false)
}

@Test
func testAllVec4AllFalse(): Unit {
    let v = Vec4<Bool, Defaultp>(false, false, false, false)
    @Expect(all(v), false)
}

// ── not_ ──

@Test
func testNotVec1True(): Unit {
    let v = Vec1<Bool, Defaultp>(true)
    let r = not_(v)
    @Expect(r.x, false)
}

@Test
func testNotVec1False(): Unit {
    let v = Vec1<Bool, Defaultp>(false)
    let r = not_(v)
    @Expect(r.x, true)
}

@Test
func testNotVec2Mixed(): Unit {
    let v = Vec2<Bool, Defaultp>(true, false)
    let r = not_(v)
    @Expect(r.x, false)
    @Expect(r.y, true)
}

@Test
func testNotVec2AllTrue(): Unit {
    let v = Vec2<Bool, Defaultp>(true, true)
    let r = not_(v)
    @Expect(r.x, false)
    @Expect(r.y, false)
}

@Test
func testNotVec3Mixed(): Unit {
    let v = Vec3<Bool, Defaultp>(true, false, true)
    let r = not_(v)
    @Expect(r.x, false)
    @Expect(r.y, true)
    @Expect(r.z, false)
}

@Test
func testNotVec4Mixed(): Unit {
    let v = Vec4<Bool, Defaultp>(true, false, false, true)
    let r = not_(v)
    @Expect(r.x, false)
    @Expect(r.y, true)
    @Expect(r.z, true)
    @Expect(r.w, false)
}

@Test
func testNotVec4AllFalse(): Unit {
    let v = Vec4<Bool, Defaultp>(false, false, false, false)
    let r = not_(v)
    @Expect(r.x, true)
    @Expect(r.y, true)
    @Expect(r.z, true)
    @Expect(r.w, true)
}
