package glm.ext
import glm.detail.{ Quat, Vec3, Qualifier, sqrtT, acos, clamp, sinT, cosT }
import std.math.FloatingPoint

public func axis<T, Q>(x: Quat<T, Q>): Vec3<T, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let one = (Float64(1) as T).getOrThrow()
    let zero = (Float64(0) as T).getOrThrow()
    let tmp1 = one - x.w * x.w
    if (tmp1 <= zero) {
        Vec3<T, Q>(zero, zero, one)
    } else {
        let tmp2 = one / sqrtT(tmp1)
        Vec3<T, Q>(x.x * tmp2, x.y * tmp2, x.z * tmp2)
    }
}

public func angle<T, Q>(x: Quat<T, Q>): T
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let one = (Float64(1) as T).getOrThrow()
    (Float64(2) as T).getOrThrow() * acos(clamp(x.w, -one, one))
}

public func angleAxis<T, Q>(angle: T, axis: Vec3<T, Q>): Quat<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    let halfAngle = angle / (Float64(2) as T).getOrThrow()
    let s = sinT(halfAngle)
    let c = cosT(halfAngle)
    Quat(c, s * axis.x, s * axis.y, s * axis.z)
}
