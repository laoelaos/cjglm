package glm.ext
import glm.detail.{ Vec1, Vec2, Vec3, Vec4, Qualifier }
import std.math.{ Number, FloatingPoint }

// ---- Vec1 epsilon ----

public func equal<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, epsilon: T): Vec1<Bool, Q>
  where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    let zero = (Float64(0) as T).getOrThrow()
    let d = x.x - y.x
    Vec1<Bool, Q>((if (d >= zero) { d } else { -d }) < epsilon)
}

public func equal<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, epsilon: Vec1<T, Q>): Vec1<Bool, Q>
  where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    let zero = (Float64(0) as T).getOrThrow()
    let d = x.x - y.x
    Vec1<Bool, Q>((if (d >= zero) { d } else { -d }) < epsilon.x)
}

public func notEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, epsilon: T): Vec1<Bool, Q>
  where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    let zero = (Float64(0) as T).getOrThrow()
    let d = x.x - y.x
    Vec1<Bool, Q>((if (d >= zero) { d } else { -d }) >= epsilon)
}

public func notEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, epsilon: Vec1<T, Q>): Vec1<Bool, Q>
  where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    let zero = (Float64(0) as T).getOrThrow()
    let d = x.x - y.x
    Vec1<Bool, Q>((if (d >= zero) { d } else { -d }) >= epsilon.x)
}

// ---- Vec2 epsilon ----

public func equal<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, epsilon: T): Vec2<Bool, Q>
  where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    let zero = (Float64(0) as T).getOrThrow()
    let dx = x.x - y.x
    let dy = x.y - y.y
    Vec2<Bool, Q>(
        (if (dx >= zero) { dx } else { -dx }) < epsilon,
        (if (dy >= zero) { dy } else { -dy }) < epsilon
    )
}

public func equal<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, epsilon: Vec2<T, Q>): Vec2<Bool, Q>
  where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    let zero = (Float64(0) as T).getOrThrow()
    let dx = x.x - y.x
    let dy = x.y - y.y
    Vec2<Bool, Q>(
        (if (dx >= zero) { dx } else { -dx }) < epsilon.x,
        (if (dy >= zero) { dy } else { -dy }) < epsilon.y
    )
}

public func notEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, epsilon: T): Vec2<Bool, Q>
  where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    let zero = (Float64(0) as T).getOrThrow()
    let dx = x.x - y.x
    let dy = x.y - y.y
    Vec2<Bool, Q>(
        (if (dx >= zero) { dx } else { -dx }) >= epsilon,
        (if (dy >= zero) { dy } else { -dy }) >= epsilon
    )
}

public func notEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, epsilon: Vec2<T, Q>): Vec2<Bool, Q>
  where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    let zero = (Float64(0) as T).getOrThrow()
    let dx = x.x - y.x
    let dy = x.y - y.y
    Vec2<Bool, Q>(
        (if (dx >= zero) { dx } else { -dx }) >= epsilon.x,
        (if (dy >= zero) { dy } else { -dy }) >= epsilon.y
    )
}

// ---- Vec3 epsilon ----

public func equal<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, epsilon: T): Vec3<Bool, Q>
  where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    let zero = (Float64(0) as T).getOrThrow()
    let dx = x.x - y.x
    let dy = x.y - y.y
    let dz = x.z - y.z
    Vec3<Bool, Q>(
        (if (dx >= zero) { dx } else { -dx }) < epsilon,
        (if (dy >= zero) { dy } else { -dy }) < epsilon,
        (if (dz >= zero) { dz } else { -dz }) < epsilon
    )
}

public func equal<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, epsilon: Vec3<T, Q>): Vec3<Bool, Q>
  where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    let zero = (Float64(0) as T).getOrThrow()
    let dx = x.x - y.x
    let dy = x.y - y.y
    let dz = x.z - y.z
    Vec3<Bool, Q>(
        (if (dx >= zero) { dx } else { -dx }) < epsilon.x,
        (if (dy >= zero) { dy } else { -dy }) < epsilon.y,
        (if (dz >= zero) { dz } else { -dz }) < epsilon.z
    )
}

public func notEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, epsilon: T): Vec3<Bool, Q>
  where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    let zero = (Float64(0) as T).getOrThrow()
    let dx = x.x - y.x
    let dy = x.y - y.y
    let dz = x.z - y.z
    Vec3<Bool, Q>(
        (if (dx >= zero) { dx } else { -dx }) >= epsilon,
        (if (dy >= zero) { dy } else { -dy }) >= epsilon,
        (if (dz >= zero) { dz } else { -dz }) >= epsilon
    )
}

public func notEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, epsilon: Vec3<T, Q>): Vec3<Bool, Q>
  where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    let zero = (Float64(0) as T).getOrThrow()
    let dx = x.x - y.x
    let dy = x.y - y.y
    let dz = x.z - y.z
    Vec3<Bool, Q>(
        (if (dx >= zero) { dx } else { -dx }) >= epsilon.x,
        (if (dy >= zero) { dy } else { -dy }) >= epsilon.y,
        (if (dz >= zero) { dz } else { -dz }) >= epsilon.z
    )
}

// ---- Vec4 epsilon ----

public func equal<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, epsilon: T): Vec4<Bool, Q>
  where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    let zero = (Float64(0) as T).getOrThrow()
    let dx = x.x - y.x
    let dy = x.y - y.y
    let dz = x.z - y.z
    let dw = x.w - y.w
    Vec4<Bool, Q>(
        (if (dx >= zero) { dx } else { -dx }) < epsilon,
        (if (dy >= zero) { dy } else { -dy }) < epsilon,
        (if (dz >= zero) { dz } else { -dz }) < epsilon,
        (if (dw >= zero) { dw } else { -dw }) < epsilon
    )
}

public func equal<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, epsilon: Vec4<T, Q>): Vec4<Bool, Q>
  where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    let zero = (Float64(0) as T).getOrThrow()
    let dx = x.x - y.x
    let dy = x.y - y.y
    let dz = x.z - y.z
    let dw = x.w - y.w
    Vec4<Bool, Q>(
        (if (dx >= zero) { dx } else { -dx }) < epsilon.x,
        (if (dy >= zero) { dy } else { -dy }) < epsilon.y,
        (if (dz >= zero) { dz } else { -dz }) < epsilon.z,
        (if (dw >= zero) { dw } else { -dw }) < epsilon.w
    )
}

public func notEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, epsilon: T): Vec4<Bool, Q>
  where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    let zero = (Float64(0) as T).getOrThrow()
    let dx = x.x - y.x
    let dy = x.y - y.y
    let dz = x.z - y.z
    let dw = x.w - y.w
    Vec4<Bool, Q>(
        (if (dx >= zero) { dx } else { -dx }) >= epsilon,
        (if (dy >= zero) { dy } else { -dy }) >= epsilon,
        (if (dz >= zero) { dz } else { -dz }) >= epsilon,
        (if (dw >= zero) { dw } else { -dw }) >= epsilon
    )
}

public func notEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, epsilon: Vec4<T, Q>): Vec4<Bool, Q>
  where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    let zero = (Float64(0) as T).getOrThrow()
    let dx = x.x - y.x
    let dy = x.y - y.y
    let dz = x.z - y.z
    let dw = x.w - y.w
    Vec4<Bool, Q>(
        (if (dx >= zero) { dx } else { -dx }) >= epsilon.x,
        (if (dy >= zero) { dy } else { -dy }) >= epsilon.y,
        (if (dz >= zero) { dz } else { -dz }) >= epsilon.z,
        (if (dw >= zero) { dw } else { -dw }) >= epsilon.w
    )
}

// ---- Vec1 ULP stub ----

public func equal<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Int64): Vec1<Bool, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier { throw Exception("stub") }

public func equal<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Vec1<Int64, Q>): Vec1<Bool, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier { throw Exception("stub") }

public func notEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Int64): Vec1<Bool, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier { throw Exception("stub") }

public func notEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Vec1<Int64, Q>): Vec1<Bool, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier { throw Exception("stub") }

// ---- Vec2 ULP stub ----

public func equal<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Int64): Vec2<Bool, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier { throw Exception("stub") }

public func equal<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Vec2<Int64, Q>): Vec2<Bool, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier { throw Exception("stub") }

public func notEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Int64): Vec2<Bool, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier { throw Exception("stub") }

public func notEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Vec2<Int64, Q>): Vec2<Bool, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier { throw Exception("stub") }

// ---- Vec3 ULP stub ----

public func equal<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Int64): Vec3<Bool, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier { throw Exception("stub") }

public func equal<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Vec3<Int64, Q>): Vec3<Bool, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier { throw Exception("stub") }

public func notEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Int64): Vec3<Bool, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier { throw Exception("stub") }

public func notEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Vec3<Int64, Q>): Vec3<Bool, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier { throw Exception("stub") }

// ---- Vec4 ULP stub ----

public func equal<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Int64): Vec4<Bool, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier { throw Exception("stub") }

public func equal<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Vec4<Int64, Q>): Vec4<Bool, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier { throw Exception("stub") }

public func notEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Int64): Vec4<Bool, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier { throw Exception("stub") }

public func notEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Vec4<Int64, Q>): Vec4<Bool, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier { throw Exception("stub") }
