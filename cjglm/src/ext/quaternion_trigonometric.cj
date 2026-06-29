package glm.ext
import glm.detail.{ Quat, Vec3, Qualifier }
import std.math.{ FloatingPoint, sqrt }

private func sqrtT<T>(x: T): T where T <: FloatingPoint<T> {
    let x64 = (x as Float64).getOrThrow()
    (sqrt(x64) as T).getOrThrow()
}

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
  where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }

public func angleAxis<T, Q>(angle: T, axis: Vec3<T, Q>): Quat<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
