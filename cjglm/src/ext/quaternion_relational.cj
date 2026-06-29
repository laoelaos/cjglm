package glm.ext
import glm.detail.{ Quat, Vec4, Qualifier }
import std.math.Number

public func equal<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>): Vec4<Bool, Q>
  where T <: Equatable<T>, Q <: Qualifier {
    Vec4<Bool, Q>(x.w == y.w, x.x == y.x, x.y == y.y, x.z == y.z)
}

public func notEqual<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>): Vec4<Bool, Q>
  where T <: Equatable<T>, Q <: Qualifier {
    Vec4<Bool, Q>(x.w != y.w, x.x != y.x, x.y != y.y, x.z != y.z)
}

public func equal<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, epsilon: T): Vec4<Bool, Q>
  where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    let dw = x.w - y.w
    let dx = x.x - y.x
    let dy = x.y - y.y
    let dz = x.z - y.z
    let zero = (Float64(0) as T).getOrThrow()
    Vec4<Bool, Q>(
        (if (dw >= zero) { dw } else { -dw }) < epsilon,
        (if (dx >= zero) { dx } else { -dx }) < epsilon,
        (if (dy >= zero) { dy } else { -dy }) < epsilon,
        (if (dz >= zero) { dz } else { -dz }) < epsilon
    )
}

public func notEqual<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, epsilon: T): Vec4<Bool, Q>
  where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    let dw = x.w - y.w
    let dx = x.x - y.x
    let dy = x.y - y.y
    let dz = x.z - y.z
    let zero = (Float64(0) as T).getOrThrow()
    Vec4<Bool, Q>(
        (if (dw >= zero) { dw } else { -dw }) >= epsilon,
        (if (dx >= zero) { dx } else { -dx }) >= epsilon,
        (if (dy >= zero) { dy } else { -dy }) >= epsilon,
        (if (dz >= zero) { dz } else { -dz }) >= epsilon
    )
}
