package glm

import std.unittest.*
import std.unittest.testmacro.*

@Test
func testLibVec2Construct(): Unit {
    let v = Vec2<Float32, PackedHighp>(Float32(1.0), Float32(2.0))
    @Expect(v.x, Float32(1.0))
}

@Test
func testLibAddScalarVec(): Unit {
    let v = Vec2<Float32, PackedHighp>(Float32(1.0), Float32(2.0))
    let r = add(Float32(10.0), v)
    @Expect(r.x, Float32(11.0))
}

@Test
func testLibFromBoolVec(): Unit {
    let bv = Vec2<Bool, PackedHighp>(Bool(true), Bool(false))
    let r = fromBoolVec(bv, Float32(0.0), Float32(1.0))
    @Expect(r.x, Float32(1.0))
}

@Test
func testLibQualifierType(): Unit {
    let _q: Qualifier = PackedHighp()
    let _d: Defaultp = Defaultp()
    @Expect(true, true)
}

@Test
func testLibVec1Construct(): Unit {
    let v = Vec1<Float32, PackedHighp>(Float32(1.0))
    @Expect(v.x, Float32(1.0))
}

@Test
func testLibVec3Construct(): Unit {
    let v = Vec3<Float32, PackedHighp>(Float32(1.0), Float32(2.0), Float32(3.0))
    @Expect(v.x, Float32(1.0))
}

@Test
func testLibVec4Construct(): Unit {
    let v = Vec4<Float32, PackedHighp>(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))
    @Expect(v.x, Float32(1.0))
}

@Test
func testLibVec1Components(): Unit {
    let v = Vec1<Float32, PackedHighp>(Float32(1.0))
    @Expect(v.x, Float32(1.0))
}

@Test
func testLibVec3Components(): Unit {
    let v = Vec3<Float32, PackedHighp>(Float32(1.0), Float32(2.0), Float32(3.0))
    @Expect(v.x, Float32(1.0))
    @Expect(v.y, Float32(2.0))
    @Expect(v.z, Float32(3.0))
}

@Test
func testLibVec4Components(): Unit {
    let v = Vec4<Float32, PackedHighp>(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))
    @Expect(v.x, Float32(1.0))
    @Expect(v.y, Float32(2.0))
    @Expect(v.z, Float32(3.0))
    @Expect(v.w, Float32(4.0))
}

@Test
func testLibSubScalarVec(): Unit {
    let v = Vec2<Int64, PackedHighp>(Int64(1), Int64(2))
    let r = sub(Int64(10), v)
    @Expect(r.x, Int64(9))
}

@Test
func testLibMulScalarVec(): Unit {
    let v = Vec2<Int64, PackedHighp>(Int64(1), Int64(2))
    let r = mul(Int64(10), v)
    @Expect(r.x, Int64(10))
}

@Test
func testLibDivScalarVec(): Unit {
    let v = Vec2<Int64, PackedHighp>(Int64(1), Int64(2))
    let r = div(Int64(10), v)
    @Expect(r.x, Int64(10))
}

@Test
func testLibModScalarVec(): Unit {
    let v = Vec2<Int64, PackedHighp>(Int64(3), Int64(2))
    let r = mod(Int64(10), v)
    @Expect(r.x, Int64(1))
}

// === Matrix type & function import tests (T9) ===

@Test
func testLibMat2x2Construct(): Unit {
    let m = Mat2x2<Float32, PackedHighp>(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))
    @Expect(m.c0.x, Float32(1.0))
    @Expect(m.c1.y, Float32(4.0))
}

@Test
func testLibMat4x4Construct(): Unit {
    let m = Mat4x4<Float32, PackedHighp>(Float32(1.0))
    @Expect(m.c0.x, Float32(1.0))
    @Expect(m.c3.w, Float32(1.0))
}

@Test
func testLibTransposeMat2x2(): Unit {
    let m = Mat2x2<Float32, PackedHighp>(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))
    let t = transpose(m)
    @Expect(t.c0.x, Float32(1.0))
    @Expect(t.c0.y, Float32(3.0))
    @Expect(t.c1.x, Float32(2.0))
    @Expect(t.c1.y, Float32(4.0))
}

@Test
func testLibTransposeMat4x4(): Unit {
    let m = Mat4x4<Float32, PackedHighp>(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0), Float32(5.0), Float32(6.0), Float32(7.0), Float32(8.0), Float32(9.0), Float32(10.0), Float32(11.0), Float32(12.0), Float32(13.0), Float32(14.0), Float32(15.0), Float32(16.0))
    let t = transpose(m)
    @Expect(t.c0.x, Float32(1.0))
    @Expect(t.c0.y, Float32(5.0))
    @Expect(t.c0.z, Float32(9.0))
    @Expect(t.c0.w, Float32(13.0))
    @Expect(t.c3.x, Float32(4.0))
    @Expect(t.c3.y, Float32(8.0))
    @Expect(t.c3.z, Float32(12.0))
    @Expect(t.c3.w, Float32(16.0))
}

@Test
func testLibMatrixCompMultMat2x2(): Unit {
    let a = Mat2x2<Int64, PackedHighp>(Int64(1), Int64(2), Int64(3), Int64(4))
    let b = Mat2x2<Int64, PackedHighp>(Int64(5), Int64(6), Int64(7), Int64(8))
    let r = matrixCompMult(a, b)
    @Expect(r.c0.x, Int64(5))
    @Expect(r.c0.y, Int64(12))
    @Expect(r.c1.x, Int64(21))
    @Expect(r.c1.y, Int64(32))
}

@Test
func testLibOuterProductVec2(): Unit {
    let c = Vec2<Int64, PackedHighp>(Int64(1), Int64(2))
    let r = Vec2<Int64, PackedHighp>(Int64(3), Int64(4))
    let m = outerProduct(c, r)
    @Expect(m.c0.x, Int64(3))
    @Expect(m.c0.y, Int64(6))
    @Expect(m.c1.x, Int64(4))
    @Expect(m.c1.y, Int64(8))
}

// === Phase 3 — Trigonometric function import tests ===

@Test
func testLibSinAccessible(): Unit {
    @ExpectThrows[Exception](sin<Float32>(0.0f32))
}

@Test
func testLibCosAccessible(): Unit {
    @ExpectThrows[Exception](cos<Float32>(0.0f32))
}

@Test
func testLibTanAccessible(): Unit {
    @ExpectThrows[Exception](tan<Float32>(0.0f32))
}

@Test
func testLibAsinAccessible(): Unit {
    @ExpectThrows[Exception](asin<Float32>(0.0f32))
}

@Test
func testLibAcosAccessible(): Unit {
    @ExpectThrows[Exception](acos<Float32>(0.0f32))
}

@Test
func testLibAtanAccessible(): Unit {
    @ExpectThrows[Exception](atan<Float32>(0.0f32))
}

@Test
func testLibAtan2Accessible(): Unit {
    @ExpectThrows[Exception](atan2<Float32>(0.0f32, 1.0f32))
}

@Test
func testLibSinhAccessible(): Unit {
    @ExpectThrows[Exception](sinh<Float32>(0.0f32))
}

@Test
func testLibCoshAccessible(): Unit {
    @ExpectThrows[Exception](cosh<Float32>(0.0f32))
}

@Test
func testLibTanhAccessible(): Unit {
    @ExpectThrows[Exception](tanh<Float32>(0.0f32))
}

@Test
func testLibAsinhAccessible(): Unit {
    @ExpectThrows[Exception](asinh<Float32>(0.0f32))
}

@Test
func testLibAcoshAccessible(): Unit {
    @ExpectThrows[Exception](acosh<Float32>(0.0f32))
}

@Test
func testLibAtanhAccessible(): Unit {
    @ExpectThrows[Exception](atanh<Float32>(0.0f32))
}

@Test
func testLibRadiansAccessible(): Unit {
    @ExpectThrows[Exception](radians<Float32>(0.0f32))
}

@Test
func testLibDegreesAccessible(): Unit {
    @ExpectThrows[Exception](degrees<Float32>(0.0f32))
}

// === Phase 3 — Quat type resolution (via fwd.cj, not lib.cj) ===

@Test
func testLibQuatFromFwd(): Unit {
    let q: Quat = Quat(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))
    @Expect(q.x, Float32(1.0))
    @Expect(q.w, Float32(4.0))
}

@Test
func testLibMat3CastAccessible(): Unit {
    let q = Quat<Float64, Defaultp>(Float64(0.0), Float64(0.0), Float64(0.0), Float64(1.0))
    let m = mat3Cast(q)
    @Expect(m.c0.x, Float64(1.0))
}

@Test
func testLibQuatCastAccessible(): Unit {
    let q = Quat<Float64, Defaultp>(Float64(0.0), Float64(0.0), Float64(0.0), Float64(1.0))
    let m = mat3Cast(q)
    let q1 = quatCast(m)
    @Expect(q1.w, Float64(1.0))
}

// === Phase 3 — G3.8b: ext common quaternion operation import tests ===

@Test
func testLibExtConjugateAccessible(): Unit {
    let q = Quat<Float32, PackedHighp>(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))
    let r = conjugate(q)
    @Expect(r.x, Float32(-1.0))
    @Expect(r.w, Float32(4.0))
}

@Test
func testLibExtInverseAccessible(): Unit {
    let q = Quat<Float64, Defaultp>(Float64(1.0), Float64(0.0), Float64(0.0), Float64(1.0))
    @ExpectThrows[Exception](inverse(q))
}

@Test
func testLibExtLerpAccessible(): Unit {
    let q1 = Quat<Float64, Defaultp>(Float64(0.0), Float64(0.0), Float64(0.0), Float64(1.0))
    let q2 = Quat<Float64, Defaultp>(Float64(0.0), Float64(0.0), Float64(0.0), Float64(1.0))
    let r = lerp(q1, q2, Float64(0.5))
    @Expect(r.w, Float64(1.0))
}

@Test
func testLibExtIsnanAccessible(): Unit {
    let q = Quat<Float64, Defaultp>(Float64(0.0), Float64(0.0), Float64(0.0), Float64(1.0))
    let r = isnan(q)
    @Expect(r.x, false)
    @Expect(r.w, false)
}

@Test
func testLibExtIsinfAccessible(): Unit {
    let q = Quat<Float64, Defaultp>(Float64(0.0), Float64(0.0), Float64(0.0), Float64(1.0))
    let r = isinf(q)
    @Expect(r.x, false)
    @Expect(r.w, false)
}

@Test
func testLibExtSlerpAccessible(): Unit {
    let q1 = Quat<Float64, Defaultp>(Float64(1.0), Float64(0.0), Float64(0.0), Float64(0.0))
    let q2 = Quat<Float64, Defaultp>(Float64(0.0), Float64(1.0), Float64(0.0), Float64(0.0))
    @ExpectThrows[Exception](slerp(q1, q2, Float64(0.5)))
}

@Test
func testLibExtMixAccessible(): Unit {
    let q1 = Quat<Float64, Defaultp>(Float64(0.0), Float64(0.0), Float64(0.0), Float64(1.0))
    let q2 = Quat<Float64, Defaultp>(Float64(0.0), Float64(0.0), Float64(0.0), Float64(1.0))
    @ExpectThrows[Exception](mix(q1, q2, Float64(0.5)))
}

// === Phase 3 — G3.8b: ext geometric function import tests ===

@Test
func testLibExtDotAccessible(): Unit {
    let q1 = Quat<Float64, Defaultp>(Float64(1.0), Float64(0.0), Float64(0.0), Float64(0.0))
    let q2 = Quat<Float64, Defaultp>(Float64(0.0), Float64(1.0), Float64(0.0), Float64(0.0))
    let d = dot(q1, q2)
    @Expect(d, Float64(0.0))
}

@Test
func testLibExtLengthAccessible(): Unit {
    let q = Quat<Float64, Defaultp>(Float64(3.0), Float64(0.0), Float64(0.0), Float64(4.0))
    let l = length(q)
    @Expect(l, Float64(5.0))
}

@Test
func testLibExtNormalizeAccessible(): Unit {
    let q = Quat<Float64, Defaultp>(Float64(3.0), Float64(0.0), Float64(0.0), Float64(4.0))
    let n = normalize(q)
    @Expect(n.x, Float64(0.6))
    @Expect(n.w, Float64(0.8))
}

@Test
func testLibExtCrossAccessible(): Unit {
    let q1 = Quat<Float64, Defaultp>(Float64(1.0), Float64(0.0), Float64(0.0), Float64(0.0))
    let q2 = Quat<Float64, Defaultp>(Float64(0.0), Float64(1.0), Float64(0.0), Float64(0.0))
    let r = cross(q1, q2)
    @Expect(r.z, Float64(-1.0))
}

@Test
func testLibExtAxisAccessible(): Unit {
    let q = Quat<Float64, Defaultp>(Float64(0.0), Float64(0.0), Float64(0.0), Float64(1.0))
    let a = axis(q)
    @Expect(a.z, Float64(1.0))
}

@Test
func testLibExtAngleAccessible(): Unit {
    let q = Quat<Float64, Defaultp>(Float64(0.0), Float64(0.0), Float64(0.0), Float64(1.0))
    @ExpectThrows[Exception](angle(q))
}

@Test
func testLibExtAngleAxisAccessible(): Unit {
    let axis = Vec3<Float64, Defaultp>(Float64(0.0), Float64(0.0), Float64(1.0))
    @ExpectThrows[Exception](angleAxis(Float64(1.0), axis))
}

// === Phase 3 — G3.8b: ext exponential function import tests ===

@Test
func testLibExtExpAccessible(): Unit {
    let q = Quat<Float64, Defaultp>(Float64(0.0), Float64(0.0), Float64(0.0), Float64(1.0))
    @ExpectThrows[Exception](exp(q))
}

@Test
func testLibExtLogAccessible(): Unit {
    let q = Quat<Float64, Defaultp>(Float64(0.0), Float64(0.0), Float64(0.0), Float64(1.0))
    @ExpectThrows[Exception](log(q))
}

@Test
func testLibExtPowAccessible(): Unit {
    let q = Quat<Float64, Defaultp>(Float64(0.0), Float64(0.0), Float64(0.0), Float64(1.0))
    @ExpectThrows[Exception](pow(q, Float64(2.0)))
}

@Test
func testLibExtSqrtAccessible(): Unit {
    let q = Quat<Float64, Defaultp>(Float64(0.0), Float64(0.0), Float64(0.0), Float64(1.0))
    @ExpectThrows[Exception](sqrt(q))
}

// === Phase 3 — G3.8b: ext constant import tests ===

@Test
func testLibExtEpsilonAccessible(): Unit {
    let v = epsilon<Float64>()
    @Expect(v > Float64(0.0), true)
}

@Test
func testLibExtPiAccessible(): Unit {
    let v = pi<Float64>()
    @Expect(v > Float64(3.14), true)
}

@Test
func testLibExtCosOneOverTwoAccessible(): Unit {
    let v = cos_one_over_two<Float64>()
    @Expect(v > Float64(0.0), true)
}

// === Phase 3 — G3.8b: ext quaternion type alias import tests ===

@Test
func testLibExtQuatAliasAccessible(): Unit {
    let _q: quat = quat(Float32(1.0), Float32(2.0), Float32(3.0), Float32(4.0))
    @Expect(true, true)
}

@Test
func testLibExtDquatAliasAccessible(): Unit {
    let _q: dquat = dquat(Float64(1.0), Float64(2.0), Float64(3.0), Float64(4.0))
    @Expect(true, true)
}

@Test
func testLibExtQuatAliasAndGenericCompatible(): Unit {
    let alias: quat = quat(Float32(1.0), Float32(0.0), Float32(0.0), Float32(0.0))
    let generic: detail.Quat<Float32, PackedHighp> = alias
    @Expect(generic.x, Float32(1.0))
}

// === Phase 3 — G3.8c: gtc constant import tests ===

@Test
func testLibGtcZeroAccessible(): Unit {
    let v = zero<Float64>()
    @Expect(v, Float64(0.0))
}

@Test
func testLibGtcOneAccessible(): Unit {
    let v = one<Float64>()
    @Expect(v, Float64(1.0))
}

@Test
func testLibGtcPiConstantsAccessible(): Unit {
    let v = half_pi<Float64>()
    @Expect(v > Float64(1.5), true)
}

@Test
func testLibGtcEulerAccessible(): Unit {
    let v = euler<Float64>()
    @Expect(v > Float64(0.5), true)
}

// === Phase 3 — G3.8c: gtc quaternion relational import tests ===

@Test
func testLibGtcLessThanAccessible(): Unit {
    let q1 = Quat<Float64, Defaultp>(Float64(0.0), Float64(0.0), Float64(0.0), Float64(0.0))
    let q2 = Quat<Float64, Defaultp>(Float64(1.0), Float64(1.0), Float64(1.0), Float64(1.0))
    let r = lessThan(q1, q2)
    @Expect(r.x, true)
    @Expect(r.w, true)
}

@Test
func testLibGtcGreaterThanAccessible(): Unit {
    let q1 = Quat<Float64, Defaultp>(Float64(2.0), Float64(2.0), Float64(2.0), Float64(2.0))
    let q2 = Quat<Float64, Defaultp>(Float64(1.0), Float64(1.0), Float64(1.0), Float64(1.0))
    let r = greaterThan(q1, q2)
    @Expect(r.x, true)
    @Expect(r.w, true)
}

@Test
func testLibGtcEulerAnglesAccessible(): Unit {
    let q = Quat<Float64, Defaultp>(Float64(0.0), Float64(0.0), Float64(0.0), Float64(1.0))
    @ExpectThrows[Exception](eulerAngles(q))
}

@Test
func testLibGtcQuatLookAtAccessible(): Unit {
    let dir = Vec3<Float64, Defaultp>(Float64(0.0), Float64(0.0), Float64(-1.0))
    let up = Vec3<Float64, Defaultp>(Float64(0.0), Float64(1.0), Float64(0.0))
    @ExpectThrows[Exception](quatLookAt(dir, up))
}

// === Phase 3 — G3.8c: gtc matrix transform import tests ===

@Test
func testLibGtcIdentityAccessible(): Unit {
    @ExpectThrows[Exception](identity<Float64, PackedHighp>())
}

@Test
func testLibGtcTranslateAccessible(): Unit {
    let m = Mat4x4<Float64, Defaultp>(Float64(1.0))
    let v = Vec3<Float64, Defaultp>(Float64(1.0), Float64(0.0), Float64(0.0))
    @ExpectThrows[Exception](translate(m, v))
}

@Test
func testLibGtcRotateAccessible(): Unit {
    let m = Mat4x4<Float64, Defaultp>(Float64(1.0))
    let axis = Vec3<Float64, Defaultp>(Float64(0.0), Float64(1.0), Float64(0.0))
    @ExpectThrows[Exception](rotate(m, Float64(0.5), axis))
}

@Test
func testLibGtcLookAtAccessible(): Unit {
    let eye = Vec3<Float64, Defaultp>(Float64(0.0), Float64(0.0), Float64(3.0))
    let center = Vec3<Float64, Defaultp>(Float64(0.0), Float64(0.0), Float64(0.0))
    let up = Vec3<Float64, Defaultp>(Float64(0.0), Float64(1.0), Float64(0.0))
    @ExpectThrows[Exception](lookAt(eye, center, up))
}

// === Phase 3 — G3.8c: gtc projection function import tests ===

@Test
func testLibGtcOrthoAccessible(): Unit {
    @ExpectThrows[Exception](ortho<Float64, Defaultp>(Float64(-1.0), Float64(1.0), Float64(-1.0), Float64(1.0)))
}

@Test
func testLibGtcFrustumAccessible(): Unit {
    @ExpectThrows[Exception](frustum<Float64, Defaultp>(Float64(-1.0), Float64(1.0), Float64(-1.0), Float64(1.0), Float64(0.1), Float64(100.0)))
}

@Test
func testLibGtcPerspectiveAccessible(): Unit {
    @ExpectThrows[Exception](perspective<Float64, Defaultp>(Float64(1.57), Float64(1.33), Float64(0.1), Float64(100.0)))
}

@Test
func testLibGtcPerspectiveFovAccessible(): Unit {
    @ExpectThrows[Exception](perspectiveFov<Float64, Defaultp>(Float64(1.57), Float64(800.0), Float64(600.0), Float64(0.1), Float64(100.0)))
}

@Test
func testLibGtcInfinitePerspectiveAccessible(): Unit {
    @ExpectThrows[Exception](infinitePerspective<Float64, Defaultp>(Float64(1.57), Float64(1.33), Float64(0.1)))
}
