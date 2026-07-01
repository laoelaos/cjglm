package glm.ext
import glm.detail.{ Quat, Qualifier, sqrtT }
import std.math.{ Number, FloatingPoint }

public func dot<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>): T
  where T <: FloatingPoint<T>, Q <: Qualifier {
    x.w * y.w + x.x * y.x + x.y * y.y + x.z * y.z
}

public func length<T, Q>(q: Quat<T, Q>): T
  where T <: FloatingPoint<T>, Q <: Qualifier {
    sqrtT(dot(q, q))
}

public func normalize<T, Q>(q: Quat<T, Q>): Quat<T, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let zero = (Float64(0) as T).getOrThrow()
    let one = (Float64(1) as T).getOrThrow()
    let len = length(q)
    if (len <= zero) {
        Quat(zero, zero, zero, one)
    } else {
        q / len
    }
}

public func cross<T, Q>(q1: Quat<T, Q>, q2: Quat<T, Q>): Quat<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    Quat(
        q1.w * q2.x + q1.x * q2.w + q1.y * q2.z - q1.z * q2.y,
        q1.w * q2.y - q1.x * q2.z + q1.y * q2.w + q1.z * q2.x,
        q1.w * q2.z + q1.x * q2.y - q1.y * q2.x + q1.z * q2.w,
        q1.w * q2.w - q1.x * q2.x - q1.y * q2.y - q1.z * q2.z
    )
}
