package glm.ext
import glm.detail.{ Quat, Vec4, Qualifier, assert }
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
  where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }

public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T): Quat<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }

public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T, k: Int64): Quat<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
