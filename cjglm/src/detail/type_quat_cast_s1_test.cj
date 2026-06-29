package glm.detail

func mat3EqualEpsilonRelaxed(a: Mat3x3<Float64, Defaultp>, b: Mat3x3<Float64, Defaultp>): Bool {
    let eps = epsilon<Float64>() * 250000000.0
    func comp(x: Float64, y: Float64): Bool {
        let d = x - y
        let z = x - x
        let ad = if (d < z) { -d } else { d }
        ad <= eps
    }
    comp(a.c0.x, b.c0.x) && comp(a.c0.y, b.c0.y) && comp(a.c0.z, b.c0.z) &&
    comp(a.c1.x, b.c1.x) && comp(a.c1.y, b.c1.y) && comp(a.c1.z, b.c1.z) &&
    comp(a.c2.x, b.c2.x) && comp(a.c2.y, b.c2.y) && comp(a.c2.z, b.c2.z)
}

@Test
func testS1QuatCastScalingXBranch(): Unit {
    let q0 = Quat<Float64, Defaultp>(0.8, 0.3, 0.2, 0.47958315233127196)
    let m0 = mat3Cast(q0)
    let q1 = quatCast(m0)
    let m1 = mat3Cast(q1)
    @Expect(mat3EqualEpsilonRelaxed(m0, m1), true)
}

@Test
func testS1QuatCastScalingYBranch(): Unit {
    let q0 = Quat<Float64, Defaultp>(0.2, 0.8, 0.3, 0.47958315233127196)
    let m0 = mat3Cast(q0)
    let q1 = quatCast(m0)
    let m1 = mat3Cast(q1)
    @Expect(mat3EqualEpsilonRelaxed(m0, m1), true)
}

@Test
func testS1QuatCastScalingZBranch(): Unit {
    let q0 = Quat<Float64, Defaultp>(0.2, 0.3, 0.8, 0.47958315233127196)
    let m0 = mat3Cast(q0)
    let q1 = quatCast(m0)
    let m1 = mat3Cast(q1)
    @Expect(mat3EqualEpsilonRelaxed(m0, m1), true)
}

@Test
func testS1QuatCastScalingWBranch(): Unit {
    let q0 = Quat<Float64, Defaultp>(0.3, 0.2, 0.4, 0.8426150151015876)
    let m0 = mat3Cast(q0)
    let q1 = quatCast(m0)
    let m1 = mat3Cast(q1)
    @Expect(mat3EqualEpsilonRelaxed(m0, m1), true)
}

@Test
func testS1QuatCastUnitRoundTrip(): Unit {
    let q0 = Quat<Float64, Defaultp>(0.2, 0.3, 0.4, 0.8426150151015876)
    let m0 = mat3Cast(q0)
    let q1 = quatCast(m0)
    let m1 = mat3Cast(q1)
    @Expect(mat3EqualEpsilonRelaxed(m0, m1), true)
}

@Test
func testS1QuatCastIdentityRoundTrip(): Unit {
    let m = Mat3x3<Float64, Defaultp>(
        Vec3<Float64, Defaultp>(1.0, 0.0, 0.0),
        Vec3<Float64, Defaultp>(0.0, 1.0, 0.0),
        Vec3<Float64, Defaultp>(0.0, 0.0, 1.0)
    )
    let q = quatCast(m)
    let m2 = mat3Cast(q)
    @Expect(mat3EqualEpsilonRelaxed(m, m2), true)
}

@Test
func testS1QuatCastMat4Delegation(): Unit {
    let q0 = Quat<Float64, Defaultp>(0.3, 0.5, 0.2, 0.7874007874011816)
    let m4 = mat4Cast(q0)
    let q1 = quatCast(m4)
    let m0 = mat3Cast(q0)
    let m1 = mat3Cast(q1)
    @Expect(mat3EqualEpsilonRelaxed(m0, m1), true)
}

@Test
func testMat3EqualEpsilonRelaxedExactMatch(): Unit {
    let a = Mat3x3<Float64, Defaultp>(
        Vec3<Float64, Defaultp>(1.0, 2.0, 3.0),
        Vec3<Float64, Defaultp>(4.0, 5.0, 6.0),
        Vec3<Float64, Defaultp>(7.0, 8.0, 9.0)
    )
    @Expect(mat3EqualEpsilonRelaxed(a, a), true)
}

@Test
func testMat3EqualEpsilonRelaxedWithinPosTolerance(): Unit {
    let eps = epsilon<Float64>() * 100.0
    let a = Mat3x3<Float64, Defaultp>(
        Vec3<Float64, Defaultp>(1.0, 0.0, 0.0),
        Vec3<Float64, Defaultp>(0.0, 1.0, 0.0),
        Vec3<Float64, Defaultp>(0.0, 0.0, 1.0)
    )
    let b = Mat3x3<Float64, Defaultp>(
        Vec3<Float64, Defaultp>(1.0 + eps * 0.5, 0.0, 0.0),
        Vec3<Float64, Defaultp>(0.0, 1.0, 0.0),
        Vec3<Float64, Defaultp>(0.0, 0.0, 1.0)
    )
    @Expect(mat3EqualEpsilonRelaxed(a, b), true)
}

@Test
func testMat3EqualEpsilonRelaxedWithinNegTolerance(): Unit {
    let eps = epsilon<Float64>() * 100.0
    let a = Mat3x3<Float64, Defaultp>(
        Vec3<Float64, Defaultp>(-1.0, -2.0, -3.0),
        Vec3<Float64, Defaultp>(-4.0, -5.0, -6.0),
        Vec3<Float64, Defaultp>(-7.0, -8.0, -9.0)
    )
    let b = Mat3x3<Float64, Defaultp>(
        Vec3<Float64, Defaultp>(-1.0 - eps * 0.5, -2.0, -3.0),
        Vec3<Float64, Defaultp>(-4.0, -5.0, -6.0),
        Vec3<Float64, Defaultp>(-7.0, -8.0, -9.0)
    )
    @Expect(mat3EqualEpsilonRelaxed(a, b), true)
}

@Test
func testMat3EqualEpsilonRelaxedBeyondTolerance(): Unit {
    let a = Mat3x3<Float64, Defaultp>(
        Vec3<Float64, Defaultp>(1.0, 0.0, 0.0),
        Vec3<Float64, Defaultp>(0.0, 1.0, 0.0),
        Vec3<Float64, Defaultp>(0.0, 0.0, 1.0)
    )
    let b = Mat3x3<Float64, Defaultp>(
        Vec3<Float64, Defaultp>(1.0, 0.0, 0.0),
        Vec3<Float64, Defaultp>(0.0, 1.0 + 1e-6, 0.0),
        Vec3<Float64, Defaultp>(0.0, 0.0, 1.0)
    )
    @Expect(mat3EqualEpsilonRelaxed(a, b), false)
}

@Test
func testMat3EqualEpsilonRelaxedZeroMatrix(): Unit {
    let z = Mat3x3<Float64, Defaultp>(
        Vec3<Float64, Defaultp>(0.0, 0.0, 0.0),
        Vec3<Float64, Defaultp>(0.0, 0.0, 0.0),
        Vec3<Float64, Defaultp>(0.0, 0.0, 0.0)
    )
    @Expect(mat3EqualEpsilonRelaxed(z, z), true)
}

@Test
func testMat3EqualEpsilonRelaxedSingleDiffBeyond(): Unit {
    let a = Mat3x3<Float64, Defaultp>(
        Vec3<Float64, Defaultp>(1.0, 2.0, 3.0),
        Vec3<Float64, Defaultp>(4.0, 5.0, 6.0),
        Vec3<Float64, Defaultp>(7.0, 8.0, 9.0)
    )
    let b = Mat3x3<Float64, Defaultp>(
        Vec3<Float64, Defaultp>(1.0, 2.0, 3.0),
        Vec3<Float64, Defaultp>(4.0, 5.0, 6.0),
        Vec3<Float64, Defaultp>(7.0, 8.0, 9.0 + 1e-6)
    )
    @Expect(mat3EqualEpsilonRelaxed(a, b), false)
}
