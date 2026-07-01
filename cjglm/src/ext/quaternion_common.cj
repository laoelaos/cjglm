package glm.ext
import glm.detail.{ Quat, Vec4, Qualifier, assert, clamp, acos, epsilon, sinT, cosT, dot, pi }
import std.math.{ Number, FloatingPoint }

public func conjugate<T, Q>(q: Quat<T, Q>): Quat<T, Q>
  where T <: Number<T>, Q <: Qualifier {
    Quat(-q.x, -q.y, -q.z, q.w)
}

public func inverse<T, Q>(q: Quat<T, Q>): Quat<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    conjugate(q) / dot(q, q)
}

@OverflowWrapping
public func lerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T): Quat<T, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let one = (Float64(1) as T).getOrThrow()
    let zero = (Float64(0) as T).getOrThrow()
    assert(a >= zero && a <= one)
    x * (one - a) + y * a
}

public func isnan<T, Q>(q: Quat<T, Q>): Vec4<Bool, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec4<Bool, Q>(q.x.isNaN(), q.y.isNaN(), q.z.isNaN(), q.w.isNaN())
}

public func isinf<T, Q>(q: Quat<T, Q>): Vec4<Bool, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec4<Bool, Q>(q.x.isInf(), q.y.isInf(), q.z.isInf(), q.w.isInf())
}

public func mix<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T): Quat<T, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let one = (Float64(1) as T).getOrThrow()
    let zero = (Float64(0) as T).getOrThrow()
    let t = clamp(a, zero, one)
    x * (one - t) + y * t
}

public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T): Quat<T, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let one = (Float64(1) as T).getOrThrow()
    let zero = (Float64(0) as T).getOrThrow()
    var z = y
    var cosOmega = dot(x, y)
    if (cosOmega < zero) { z = -y; cosOmega = -cosOmega }
    cosOmega = clamp(cosOmega, -one, one)
    let omega = acos(cosOmega)
    let sinOmega = sinT(omega)
    if (sinOmega < epsilon<T>()) {
        x * (one - a) + z * a
    } else {
        let scale0 = sinT((one - a) * omega) / sinOmega
        let scale1 = sinT(a * omega) / sinOmega
        x * scale0 + z * scale1
    }
}

public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T, k: T): Quat<T, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let one = (Float64(1) as T).getOrThrow()
    let zero = (Float64(0) as T).getOrThrow()
    var z = y
    var cosOmega = dot(x, y)
    if (cosOmega < zero) { z = -y; cosOmega = -cosOmega }
    cosOmega = clamp(cosOmega, -one, one)
    let omega = acos(cosOmega)
    let sinOmega = sinT(omega)
    if (sinOmega < epsilon<T>()) {
        x * (one - a) + z * a
    } else {
        let phi = omega + k * pi<T>()
        let scale0 = sinT(omega - a * phi) / sinOmega
        let scale1 = sinT(a * phi) / sinOmega
        x * scale0 + z * scale1
    }
}
