package glm.detail

@Test
func testVec1BroadcastShiftLeftVec2Fixed(): Unit {
    let a = Vec1<Int64, Defaultp>(2)
    let b = Vec2<Int64, Defaultp>(4, 5)
    let r = a << b
    @Expect(r.x, 32)
    @Expect(r.y, 64)
}

@Test
func testVec1BroadcastShiftRightVec2Fixed(): Unit {
    let a = Vec1<Int64, Defaultp>(128)
    let b = Vec2<Int64, Defaultp>(4, 3)
    let r = a >> b
    @Expect(r.x, 8)
    @Expect(r.y, 16)
}

@Test
func testVec1BroadcastShiftLeftVec2ZeroShift(): Unit {
    let a = Vec1<Int64, Defaultp>(42)
    let b = Vec2<Int64, Defaultp>(0, 0)
    let r = a << b
    @Expect(r.x, 42)
    @Expect(r.y, 42)
}

@Test
func testVec1BroadcastShiftRightVec2ZeroShift(): Unit {
    let a = Vec1<Int64, Defaultp>(42)
    let b = Vec2<Int64, Defaultp>(0, 0)
    let r = a >> b
    @Expect(r.x, 42)
    @Expect(r.y, 42)
}

@Test
func testVec1BroadcastShiftLeftVec2ByOne(): Unit {
    let a = Vec1<Int64, Defaultp>(3)
    let b = Vec2<Int64, Defaultp>(1, 2)
    let r = a << b
    @Expect(r.x, 6)
    @Expect(r.y, 12)
}

@Test
func testVec1BroadcastShiftRightVec2ByOne(): Unit {
    let a = Vec1<Int64, Defaultp>(16)
    let b = Vec2<Int64, Defaultp>(1, 2)
    let r = a >> b
    @Expect(r.x, 8)
    @Expect(r.y, 4)
}

@Test
func testVec1BroadcastShiftRightVec2OvershiftThrows(): Unit {
    let a = Vec1<Int64, Defaultp>(2)
    let b = Vec2<Int64, Defaultp>(64, 1)
    try {
        let _ = a >> b
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}

@Test
func testVec1BroadcastShiftLeftVec3(): Unit {
    let a = Vec1<Int64, Defaultp>(2)
    let b = Vec3<Int64, Defaultp>(1, 2, 3)
    let r = a << b
    @Expect(r.x, 4)
    @Expect(r.y, 8)
    @Expect(r.z, 16)
}

@Test
func testVec1BroadcastShiftRightVec3(): Unit {
    let a = Vec1<Int64, Defaultp>(64)
    let b = Vec3<Int64, Defaultp>(1, 2, 3)
    let r = a >> b
    @Expect(r.x, 32)
    @Expect(r.y, 16)
    @Expect(r.z, 8)
}

@Test
func testVec1BroadcastShiftLeftVec4(): Unit {
    let a = Vec1<Int64, Defaultp>(2)
    let b = Vec4<Int64, Defaultp>(1, 2, 3, 4)
    let r = a << b
    @Expect(r.x, 4)
    @Expect(r.y, 8)
    @Expect(r.z, 16)
    @Expect(r.w, 32)
}

@Test
func testVec1BroadcastShiftRightVec4(): Unit {
    let a = Vec1<Int64, Defaultp>(128)
    let b = Vec4<Int64, Defaultp>(1, 2, 3, 4)
    let r = a >> b
    @Expect(r.x, 64)
    @Expect(r.y, 32)
    @Expect(r.z, 16)
    @Expect(r.w, 8)
}

@Test
func testVec1BroadcastShiftLeftVec2PackedHighp(): Unit {
    let a = Vec1<Int64, PackedHighp>(2)
    let b = Vec2<Int64, PackedHighp>(4, 5)
    let r = a << b
    @Expect(r.x, 32)
    @Expect(r.y, 64)
}

@Test
func testVec1BroadcastShiftRightVec2PackedHighp(): Unit {
    let a = Vec1<Int64, PackedHighp>(128)
    let b = Vec2<Int64, PackedHighp>(4, 3)
    let r = a >> b
    @Expect(r.x, 8)
    @Expect(r.y, 16)
}
