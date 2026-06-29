package glm.detail

@Test
func testMat3CastIdentityQuat(): Unit {
    let q = Quat<Float64, Defaultp>(0.0, 0.0, 0.0, 1.0)
    let m = mat3Cast(q)
    @Expect(m.c0.x, 1.0)
    @Expect(m.c0.y, 0.0)
    @Expect(m.c0.z, 0.0)
    @Expect(m.c1.x, 0.0)
    @Expect(m.c1.y, 1.0)
    @Expect(m.c1.z, 0.0)
    @Expect(m.c2.x, 0.0)
    @Expect(m.c2.y, 0.0)
    @Expect(m.c2.z, 1.0)
}

@Test
func testQuatCastMat3RoundTrip(): Unit {
    let q0 = Quat<Float64, Defaultp>(0.0, 0.0, 0.0, 1.0)
    let m = mat3Cast(q0)
    let q1 = quatCast(m)
    let m2 = mat3Cast(q1)
    @Expect(m == m2, true)
}

@Test
func testMat4CastIdentityQuat(): Unit {
    let q = Quat<Float64, Defaultp>(0.0, 0.0, 0.0, 1.0)
    let m = mat4Cast(q)
    @Expect(m.c0.x, 1.0)
    @Expect(m.c0.y, 0.0)
    @Expect(m.c0.z, 0.0)
    @Expect(m.c0.w, 0.0)
    @Expect(m.c1.x, 0.0)
    @Expect(m.c1.y, 1.0)
    @Expect(m.c1.z, 0.0)
    @Expect(m.c1.w, 0.0)
    @Expect(m.c2.x, 0.0)
    @Expect(m.c2.y, 0.0)
    @Expect(m.c2.z, 1.0)
    @Expect(m.c2.w, 0.0)
    @Expect(m.c3.w, 1.0)
}

@Test
func testQuatCastMat4RoundTrip(): Unit {
    let q0 = Quat<Float64, Defaultp>(0.0, 0.0, 0.0, 1.0)
    let m = mat4Cast(q0)
    let q1 = quatCast(m)
    let m2 = mat4Cast(q1)
    @Expect(m == m2, true)
}

@Test
func testMat3CastNonIdentityQuat(): Unit {
    let q = Quat<Float64, Defaultp>(0.2, 0.3, 0.4, 0.8)
    let m = mat3Cast(q)
    let q1 = quatCast(m)
    let m2 = mat3Cast(q1)
    @Expect(m == m2, true)
}

@Test
func testMat4CastNonIdentityQuat(): Unit {
    let q = Quat<Float64, Defaultp>(0.2, 0.3, 0.4, 0.8)
    let m = mat4Cast(q)
    @Expect(m.c3.x, 0.0)
    @Expect(m.c3.y, 0.0)
    @Expect(m.c3.z, 0.0)
    @Expect(m.c3.w, 1.0)
    let q1 = quatCast(m)
    let m2 = mat4Cast(q1)
    @Expect(m == m2, true)
}

@Test
func testQuatCastNonIdentityMat3RoundTrip(): Unit {
    let q0 = Quat<Float64, Defaultp>(0.2, 0.3, 0.4, 0.8)
    let m = mat3Cast(q0)
    let q1 = quatCast(m)
    let m2 = mat3Cast(q1)
    @Expect(m == m2, true)
}

@Test
func testQuatCastNonIdentityMat4RoundTrip(): Unit {
    let q0 = Quat<Float64, Defaultp>(0.2, 0.3, 0.4, 0.8)
    let m = mat4Cast(q0)
    let q1 = quatCast(m)
    let m2 = mat4Cast(q1)
    @Expect(m == m2, true)
}

@Test
func testQuatCastFloat32AllBranches(): Unit {
    let qW = Quat<Float32, Defaultp>(Float32(0.2), Float32(0.3), Float32(0.4), Float32(0.8))
    let mW = mat3Cast(qW)
    let q1W = quatCast(mW)
    let m2W = mat3Cast(q1W)
    @Expect(mW == m2W, true)
    let qX = Quat<Float32, Defaultp>(Float32(0.8), Float32(0.1), Float32(0.1), Float32(0.1))
    let mX = mat3Cast(qX)
    let q1X = quatCast(mX)
    let m2X = mat3Cast(q1X)
    @Expect(mX == m2X, true)
    let qY = Quat<Float32, Defaultp>(Float32(0.1), Float32(0.8), Float32(0.1), Float32(0.1))
    let mY = mat3Cast(qY)
    let q1Y = quatCast(mY)
    let m2Y = mat3Cast(q1Y)
    @Expect(mY == m2Y, true)
    let qZ = Quat<Float32, Defaultp>(Float32(0.1), Float32(0.1), Float32(0.8), Float32(0.1))
    let mZ = mat3Cast(qZ)
    let q1Z = quatCast(mZ)
    let m2Z = mat3Cast(q1Z)
    @Expect(mZ == m2Z, true)
}

@Test
func testQuatCastPackedHighpRoundTrip(): Unit {
    let q0 = Quat<Float64, PackedHighp>(Float64(0.2), Float64(0.3), Float64(0.4), Float64(0.8))
    let m = mat3Cast(q0)
    let q1 = quatCast(m)
    let m2 = mat3Cast(q1)
    @Expect(m == m2, true)
}

@Test
func testQuatCastAllBranchesRoundTrip(): Unit {
    let qW = Quat<Float64, Defaultp>(0.2, 0.3, 0.4, 0.8)
    let mW = mat3Cast(qW)
    let q1W = quatCast(mW)
    let m2W = mat3Cast(q1W)
    @Expect(mW == m2W, true)
    let qX = Quat<Float64, Defaultp>(0.8, 0.2, 0.1, 0.1)
    let mX = mat3Cast(qX)
    let q1X = quatCast(mX)
    let m2X = mat3Cast(q1X)
    @Expect(mX == m2X, true)
    let qY = Quat<Float64, Defaultp>(0.1, 0.8, 0.2, 0.1)
    let mY = mat3Cast(qY)
    let q1Y = quatCast(mY)
    let m2Y = mat3Cast(q1Y)
    @Expect(mY == m2Y, true)
    let qZ = Quat<Float64, Defaultp>(0.1, 0.1, 0.8, 0.2)
    let mZ = mat3Cast(qZ)
    let q1Z = quatCast(mZ)
    let m2Z = mat3Cast(q1Z)
    @Expect(mZ == m2Z, true)
}

@Test
func testQuatCastNegativeComponentsRoundTrip(): Unit {
    let q0 = Quat<Float64, Defaultp>(-0.2, -0.3, 0.4, -0.8)
    let m = mat3Cast(q0)
    let q1 = quatCast(m)
    let m2 = mat3Cast(q1)
    @Expect(m == m2, true)
}

@Test
func testQuatCastMat4Float32RoundTrip(): Unit {
    let q0 = Quat<Float32, Defaultp>(Float32(0.2), Float32(0.3), Float32(0.4), Float32(0.8))
    let m = mat4Cast(q0)
    let q1 = quatCast(m)
    let m2 = mat4Cast(q1)
    @Expect(m == m2, true)
}
