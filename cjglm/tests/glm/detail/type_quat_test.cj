package glm.detail

@Test
func testQuatConstruct(): Unit {
    let q = Quat<Int64, Defaultp>(1, 2, 3, 4)
    @Expect(q.x, 1)
    @Expect(q.y, 2)
    @Expect(q.z, 3)
    @Expect(q.w, 4)
}

@Test
func testQuatScalarVecConstruct(): Unit {
    let q = Quat<Float64, Defaultp>(1.0, Vec3<Float64, Defaultp>(2.0, 3.0, 4.0))
    @Expect(q.w, 1.0)
    @Expect(q.x, 2.0)
    @Expect(q.y, 3.0)
    @Expect(q.z, 4.0)
}

@Test
func testQuatFromQual(): Unit {
    let q1 = Quat<Int64, PackedHighp>(1, 2, 3, 4)
    let q2 = Quat.fromQual<Defaultp>(q1)
    @Expect(q2.x, 1)
    @Expect(q2.y, 2)
    @Expect(q2.z, 3)
    @Expect(q2.w, 4)
}

@Test
func testQuatIdentity(): Unit {
    let q = Quat.identity(Int64(1))
    @Expect(q.x, 0)
    @Expect(q.y, 0)
    @Expect(q.z, 0)
    @Expect(q.w, 1)
}

@Test
func testQuatWxyz(): Unit {
    let q = Quat.wxyz(Int64(1), Int64(2), Int64(3), Int64(4))
    @Expect(q.x, 2)
    @Expect(q.y, 3)
    @Expect(q.z, 4)
    @Expect(q.w, 1)
}

@Test
func testQuatFromQuat(): Unit {
    let q1 = Quat<Float64, Defaultp>(1.0, 2.0, 3.0, 4.0)
    let q2 = Quat.fromQuat({ x => Float32(x) }, q1)
    @Expect(q2.x, Float32(1.0))
    @Expect(q2.y, Float32(2.0))
    @Expect(q2.z, Float32(3.0))
    @Expect(q2.w, Float32(4.0))
}

@Test
func testQuatLength(): Unit {
    @Expect(Quat.length(), 4)
}

@Test
func testQuatIndex(): Unit {
    let q = Quat<Int64, Defaultp>(10, 20, 30, 40)
    @Expect(q[0], 10)
    @Expect(q[1], 20)
    @Expect(q[2], 30)
    @Expect(q[3], 40)
}

@Test
func testQuatIndexMut(): Unit {
    var q = Quat<Int64, Defaultp>(10, 20, 30, 40)
    q[1] = 99
    @Expect(q[1], 99)
    @Expect(q.x, 10)
    @Expect(q.y, 99)
    @Expect(q.z, 30)
    @Expect(q.w, 40)
}

@Test
func testQuatAdd(): Unit {
    let a = Quat<Int64, Defaultp>(1, 2, 3, 4)
    let b = Quat<Int64, Defaultp>(5, 6, 7, 8)
    let r = a + b
    @Expect(r.x, 6)
    @Expect(r.y, 8)
    @Expect(r.z, 10)
    @Expect(r.w, 12)
}

@Test
func testQuatSub(): Unit {
    let a = Quat<Int64, Defaultp>(5, 6, 7, 8)
    let b = Quat<Int64, Defaultp>(1, 2, 3, 4)
    let r = a - b
    @Expect(r.x, 4)
    @Expect(r.y, 4)
    @Expect(r.z, 4)
    @Expect(r.w, 4)
}

@Test
func testQuatMul(): Unit {
    let a = Quat<Int64, Defaultp>(1, 2, 3, 4)
    let b = Quat<Int64, Defaultp>(2, 3, 4, 5)
    let r = a * b
    @Expect(r.x, 12)
    @Expect(r.y, 24)
    @Expect(r.z, 30)
    @Expect(r.w, 0)
}

@Test
func testQuatDiv(): Unit {
    let a = Quat<Int64, Defaultp>(10, 20, 30, 40)
    let b = Quat<Int64, Defaultp>(1, 0, 0, 2)
    let r = a / b
    @Expect(r.x, -4)
    @Expect(r.y, 2)
    @Expect(r.z, 16)
    @Expect(r.w, 18)
}

@Test
func testQuatNeg(): Unit {
    let q = Quat<Int64, Defaultp>(1, -2, 3, -4)
    let r = -q
    @Expect(r.x, -1)
    @Expect(r.y, 2)
    @Expect(r.z, -3)
    @Expect(r.w, 4)
}

@Test
func testQuatEq(): Unit {
    let a = Quat<Int64, Defaultp>(1, 2, 3, 4)
    let b = Quat<Int64, Defaultp>(1, 2, 3, 4)
    let c = Quat<Int64, Defaultp>(1, 2, 3, 5)
    @Expect(a == b, true)
    @Expect(a == c, false)
}

@Test
func testQuatNeq(): Unit {
    let a = Quat<Int64, Defaultp>(1, 2, 3, 4)
    let b = Quat<Int64, Defaultp>(1, 2, 3, 5)
    @Expect(a != b, true)
}

@Test
func testQuatMulScalar(): Unit {
    let q = Quat<Int64, Defaultp>(1, 2, 3, 4)
    let r = q * Int64(2)
    @Expect(r.x, 2)
    @Expect(r.y, 4)
    @Expect(r.z, 6)
    @Expect(r.w, 8)
}

@Test
func testQuatDivScalar(): Unit {
    let q = Quat<Int64, Defaultp>(2, 4, 6, 8)
    let r = q / Int64(2)
    @Expect(r.x, 1)
    @Expect(r.y, 2)
    @Expect(r.z, 3)
    @Expect(r.w, 4)
}

@Test
func testQuatFromMat3RoundTrip(): Unit {
    let q0 = Quat<Float64, Defaultp>(0.0, 0.0, 0.0, 1.0)
    let m = mat3Cast(q0)
    let q1 = Quat.fromMat3(m)
    let m2 = mat3Cast(q1)
    @Expect(m == m2, true)
}

@Test
func testQuatFromMat4RoundTrip(): Unit {
    let q0 = Quat<Float64, Defaultp>(0.0, 0.0, 0.0, 1.0)
    let m = mat4Cast(q0)
    let q1 = Quat.fromMat4(m)
    let m2 = mat4Cast(q1)
    @Expect(m == m2, true)
}

@Test
func testQuatFromMat3NonIdentityRoundTrip(): Unit {
    let q0 = Quat<Float64, Defaultp>(0.2, 0.3, 0.4, 0.8)
    let m = mat3Cast(q0)
    let q1 = Quat.fromMat3(m)
    let m2 = mat3Cast(q1)
    @Expect(m == m2, true)
}

@Test
func testQuatBoolEq(): Unit {
    let a = Quat<Bool, Defaultp>(true, false, true, false)
    let b = Quat<Bool, Defaultp>(true, false, true, false)
    let c = Quat<Bool, Defaultp>(false, true, false, true)
    @Expect(a == b, true)
    @Expect(a == c, false)
}

@Test
func testQuatBoolNeq(): Unit {
    let a = Quat<Bool, Defaultp>(true, true, false, false)
    let b = Quat<Bool, Defaultp>(true, true, false, true)
    @Expect(a != b, true)
}

@Test
func testQuatIndexOutOfBounds(): Unit {
    let q = Quat<Int64, Defaultp>(1, 2, 3, 4)
    @ExpectThrows[Exception](q[Int64(-1)])
    @ExpectThrows[Exception](q[Int64(4)])
}

@Test
func testQuatIndexMutOutOfBounds(): Unit {
    var q = Quat<Int64, Defaultp>(1, 2, 3, 4)
    @ExpectThrows[Exception]({ q[Int64(-1)] = 0 })
    @ExpectThrows[Exception]({ q[Int64(4)] = 0 })
}

@Test
func testQuatVec3Stub(): Unit {
    let q = Quat<Int64, Defaultp>(1, 0, 0, 0)
    let v = Vec3<Int64, Defaultp>(1, 2, 3)
    @ExpectThrows[Exception](q * v)
}

@Test
func testQuatVec4Stub(): Unit {
    let q = Quat<Int64, Defaultp>(1, 0, 0, 0)
    let v = Vec4<Int64, Defaultp>(1, 2, 3, 4)
    @ExpectThrows[Exception](q * v)
}

@Test
func testVec3QuatStub(): Unit {
    let v = Vec3<Int64, Defaultp>(1, 2, 3)
    let q = Quat<Int64, Defaultp>(1, 0, 0, 0)
    @ExpectThrows[Exception](v * q)
}

@Test
func testVec4QuatStub(): Unit {
    let v = Vec4<Int64, Defaultp>(1, 2, 3, 4)
    let q = Quat<Int64, Defaultp>(1, 0, 0, 0)
    @ExpectThrows[Exception](v * q)
}

@Test
func testQuatValueSemantics(): Unit {
    let a = Quat<Int64, Defaultp>(1, 2, 3, 4)
    let b = Quat<Int64, Defaultp>(5, 6, 7, 8)
    let _ = a + b
    @Expect(a.x, 1)
    @Expect(a.y, 2)
    @Expect(a.z, 3)
    @Expect(a.w, 4)
    @Expect(b.x, 5)
    @Expect(b.y, 6)
    @Expect(b.z, 7)
    @Expect(b.w, 8)
}
