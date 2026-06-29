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
public import glm.ext.{quat, dquat, highp_quat, mediump_quat, lowp_quat, highp_dquat, mediump_dquat, lowp_dquat}
// (perspective, ortho, translate 由 gtc 模块提供，避免与 ext 冲突)
// Phase 3 — gtc 子包（显式符号导入）
public import glm.gtc.{zero, one, two_pi, tau, root_pi, half_pi, three_over_two_pi, quarter_pi, one_over_pi, one_over_two_pi, two_over_pi, four_over_pi, two_over_root_pi, one_over_root_two, root_half_pi, root_two_pi, root_ln_four, e, euler, root_two, root_three, root_five, ln_two, ln_ten, ln_ln_two, third, two_thirds, golden_ratio}
public import glm.gtc.{lessThan, lessThanEqual, greaterThan, greaterThanEqual, eulerAngles, roll, pitch, yaw, quatLookAt, quatLookAtRH, quatLookAtLH}
public import glm.gtc.{identity, translate, rotate, rotate_slow, scale, scale_slow, shear, shear_slow, lookAt, lookAtRH, lookAtLH}
public import glm.gtc.{ortho, orthoLH_ZO, orthoLH_NO, orthoRH_ZO, orthoRH_NO, orthoZO, orthoNO, orthoLH, orthoRH}
public import glm.gtc.{frustum, frustumLH_ZO, frustumLH_NO, frustumRH_ZO, frustumRH_NO, frustumZO, frustumNO, frustumLH, frustumRH}
public import glm.gtc.{perspective, perspectiveLH_ZO, perspectiveLH_NO, perspectiveRH_ZO, perspectiveRH_NO, perspectiveZO, perspectiveNO, perspectiveLH, perspectiveRH}
public import glm.gtc.{perspectiveFov, perspectiveFovLH_ZO, perspectiveFovLH_NO, perspectiveFovRH_ZO, perspectiveFovRH_NO, perspectiveFovZO, perspectiveFovNO, perspectiveFovLH, perspectiveFovRH}
public import glm.gtc.{infinitePerspective, infinitePerspectiveLH_ZO, infinitePerspectiveLH_NO, infinitePerspectiveRH_ZO, infinitePerspectiveRH_NO, infinitePerspectiveLH, infinitePerspectiveRH, tweakedInfinitePerspective, projectZO, projectNO, project}
