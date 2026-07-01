package glm
public import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }
public import glm.detail.{ Qualifier, PackedHighp, PackedMediump, PackedLowp }
public import glm.detail.{ Defaultp }
public import glm.detail.{ add, sub, mul, div, mod }
public import glm.detail.{ fromBoolVec, fromBoolVecQ2 }
public import glm.detail.{ Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4 }
public import glm.detail.{ transpose, matrixCompMult, outerProduct }
// Phase 3 — 四元数类型 + 转换函数
public import glm.detail.{Quat, mat3Cast, mat4Cast, quatCast}
// Phase 3 — trigonometric 函数（detail 包内函数，按名称导入）
public import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}
// Phase 3 — ext 扩展函数库（显式符号导入）
public import glm.ext.{equal, notEqual, conjugate, inverse, lerp, isnan, isinf, mix, slerp}
public import glm.ext.{dot, length, normalize, cross, axis, angle, angleAxis}
public import glm.ext.{exp, log, pow, sqrt}
public import glm.ext.{epsilon, pi, cos_one_over_two}
public import glm.ext.{quat, highp_quat, mediump_quat, lowp_quat, highp_dquat, mediump_dquat, lowp_dquat}
// (perspective, ortho, translate 由 gtc 模块提供，避免与 ext 冲突)
// Phase 3 — gtc 子包（显式符号导入）
public import glm.gtc.{zero, one, two_pi, tau, root_pi, half_pi, three_over_two_pi, quarter_pi, one_over_pi, one_over_two_pi, two_over_pi, four_over_pi, two_over_root_pi, one_over_root_two, root_half_pi, root_two_pi, root_ln_four, e, euler, root_two, root_three, root_five, ln_two, ln_ten, ln_ln_two, third, two_thirds, golden_ratio}
public import glm.gtc.{lessThan, lessThanEqual, greaterThan, greaterThanEqual, eulerAngles, roll, pitch, yaw, quatLookAt, quatLookAtRH, quatLookAtLH}
public import glm.gtc.{identity, rotate_slow, scale_slow, shear_slow}
public import glm.gtc.{ortho, orthoLH_ZO, orthoLH_NO, orthoRH_ZO, orthoRH_NO, orthoZO, orthoNO, orthoLH, orthoRH}
public import glm.gtc.{frustum, frustumLH_ZO, frustumLH_NO, frustumRH_ZO, frustumRH_NO, frustumZO, frustumNO, frustumLH, frustumRH}
public import glm.gtc.{perspective, perspectiveLH_ZO, perspectiveLH_NO, perspectiveRH_ZO, perspectiveRH_NO, perspectiveZO, perspectiveNO, perspectiveLH, perspectiveRH}
public import glm.gtc.{perspectiveFov, perspectiveFovLH_ZO, perspectiveFovLH_NO, perspectiveFovRH_ZO, perspectiveFovRH_NO, perspectiveFovZO, perspectiveFovNO, perspectiveFovLH, perspectiveFovRH}
public import glm.gtc.{infinitePerspective, infinitePerspectiveLH_ZO, infinitePerspectiveLH_NO, infinitePerspectiveRH_ZO, infinitePerspectiveRH_NO, infinitePerspectiveLH, infinitePerspectiveRH, tweakedInfinitePerspective, projectZO, projectNO, project}
// Phase 4 — common.cj 函数族导出
public import glm.detail.{abs, sign, floor, ceil, trunc, round, roundEven, fract, mod, modf,
    min, max, clamp, mix, step, smoothstep, isnan, isinf,
    floatBitsToInt, floatBitsToUint, intBitsToFloat, uintBitsToFloat,
    fma, frexp, ldexp}
// Phase 4 — exponential.cj 导出
public import glm.detail.{pow, exp, log, exp2, log2, sqrt, inversesqrt}
// Phase 4 — geometric.cj 导出
public import glm.detail.{dot, cross, normalize, length, distance, reflect, refract, faceforward}
// Phase 4 — matrix.cj 导出
public import glm.detail.{determinant, inverse}
// Phase 4 — ext/scalar_common.cj 与 ext/vector_common.cj 导出
public import glm.ext.{min, max, fmin, fmax, fclamp, clamp, repeat, mirrorClamp, mirrorRepeat, iround, uround}
// Phase 4 — ext 扩展函数库（仅导入 gtc 未覆盖的符号，避免命名冲突）
public import glm.ext.{translate, rotate, scale, shear, lookAt, lookAtRH, lookAtLH}
// Phase 4 — detail/vector_relational.cj 导出（供 gtc noise 使用）
public import glm.detail.{lessThan, greaterThan, lessThanEqual, greaterThanEqual, equal, notEqual, any, all, not_}
// Phase 4 — gtc 新模块
public import glm.gtc.{affineInverse, inverseTranspose}
public import glm.gtc.{row, column}
public import glm.gtc.{packUnorm1x8, packUnorm2x8, packUnorm4x8, packUnorm1x16, packUnorm2x16, packUnorm4x16,
    unpackUnorm1x8, unpackUnorm2x8, unpackUnorm4x8, unpackUnorm1x16, unpackUnorm2x16, unpackUnorm4x16,
    packSnorm1x8, packSnorm2x8, packSnorm4x8, packSnorm1x16, packSnorm2x16, packSnorm4x16,
    unpackSnorm1x8, unpackSnorm2x8, unpackSnorm4x8, unpackSnorm1x16, unpackSnorm2x16, unpackSnorm4x16,
    packHalf1x16, packHalf2x16, packHalf4x16,
    unpackHalf1x16, unpackHalf2x16, unpackHalf4x16,
    packDouble2x32, unpackDouble2x32}
public import glm.gtc.{perlin1D, perlin2D, perlin3D, perlin4D, simplex1D, simplex2D, simplex3D, simplex4D}
public import glm.gtc.{linearRand, gaussRand}
public import glm.gtc.{next_float, prev_float, float_distance, ulp}
public import glm.gtc.{roundPowerOfTwo, ceilPowerOfTwo, floorPowerOfTwo, roundMultiple, ceilMultiple, floorMultiple}
// Phase 4 — gtc/type_precision.cj 高精度类型别名导出
public import glm.gtc.{fvec1, fvec2, fvec3, fvec4, dvec1, dvec2, dvec3, dvec4,
    ivec2, ivec3, ivec4, uvec2, uvec3, uvec4,
    i8vec2, i8vec3, i8vec4, u8vec2, u8vec3, u8vec4,
    i16vec2, i16vec3, i16vec4, u16vec2, u16vec3, u16vec4,
    i32vec2, i32vec3, i32vec4, u32vec2, u32vec3, u32vec4,
    i64vec2, i64vec3, i64vec4, u64vec2, u64vec3, u64vec4,
    hvec1, hvec2, hvec3, hvec4,
    fmat2, fmat3, fmat4, fmat2x2, fmat2x3, fmat2x4, fmat3x2, fmat3x3, fmat3x4, fmat4x2, fmat4x3, fmat4x4,
    dmat2, dmat3, dmat4, dmat2x2, dmat2x3, dmat2x4, dmat3x2, dmat3x3, dmat3x4, dmat4x2, dmat4x3, dmat4x4,
    fquat, dquat, hquat}
