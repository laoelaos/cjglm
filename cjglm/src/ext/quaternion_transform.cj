package glm.ext
import glm.detail.{ Quat, Vec3, Qualifier, dot, sqrtT, sinT, cosT }
import std.math.FloatingPoint

public func rotate<T, Q>(q: Quat<T, Q>, angle: T, axis: Vec3<T, Q>): Quat<T, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let one = (Float64(1) as T).getOrThrow()
    let zero = (Float64(0) as T).getOrThrow()
    let halfAngle = angle / (Float64(2) as T).getOrThrow()
    let lenSq = dot(axis, axis)
    if (lenSq <= zero) {
        return Quat(one, zero, zero, zero)
    }
    let invLen = one / sqrtT(lenSq)
    let normAxis = Vec3<T, Q>(axis.x * invLen, axis.y * invLen, axis.z * invLen)
    let s = sinT(halfAngle)
    let c = cosT(halfAngle)
    let r = Quat<T, Q>(c, s * normAxis.x, s * normAxis.y, s * normAxis.z)
    Quat<T, Q>(
        r.w * q.x + r.x * q.w + r.y * q.z - r.z * q.y,
        r.w * q.y - r.x * q.z + r.y * q.w + r.z * q.x,
        r.w * q.z + r.x * q.y - r.y * q.x + r.z * q.w,
        r.w * q.w - r.x * q.x - r.y * q.y - r.z * q.z
    )
}
