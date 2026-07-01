package glm.detail

import std.math.FloatingPoint

// ── sin ──

public func sin<T>(x: T): T where T <: FloatingPoint<T> { sinT(x) }
public func sin<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec1(sinT(x.x))
}
public func sin<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec2(sinT(x.x), sinT(x.y))
}
public func sin<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec3(sinT(x.x), sinT(x.y), sinT(x.z))
}
public func sin<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec4(sinT(x.x), sinT(x.y), sinT(x.z), sinT(x.w))
}

// ── cos ──

public func cos<T>(x: T): T where T <: FloatingPoint<T> { cosT(x) }
public func cos<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec1(cosT(x.x))
}
public func cos<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec2(cosT(x.x), cosT(x.y))
}
public func cos<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec3(cosT(x.x), cosT(x.y), cosT(x.z))
}
public func cos<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec4(cosT(x.x), cosT(x.y), cosT(x.z), cosT(x.w))
}

// ── tan ──

public func tan<T>(x: T): T where T <: FloatingPoint<T> { tanT(x) }
public func tan<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec1(tanT(x.x))
}
public func tan<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec2(tanT(x.x), tanT(x.y))
}
public func tan<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec3(tanT(x.x), tanT(x.y), tanT(x.z))
}
public func tan<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec4(tanT(x.x), tanT(x.y), tanT(x.z), tanT(x.w))
}

// ── asin (with out-of-range protection) ──

public func asin<T>(x: T): T where T <: FloatingPoint<T> {
    let xF64: Float64 = (x as Float64).getOrThrow()
    if (xF64 < -1.0 || xF64 > 1.0) { return T.getNaN() }
    return asinT(x)
}
public func asin<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec1(asin(x.x))
}
public func asin<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec2(asin(x.x), asin(x.y))
}
public func asin<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec3(asin(x.x), asin(x.y), asin(x.z))
}
public func asin<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec4(asin(x.x), asin(x.y), asin(x.z), asin(x.w))
}

// ── acos (with out-of-range protection) ──

public func acos<T>(x: T): T where T <: FloatingPoint<T> {
    let xF64: Float64 = (x as Float64).getOrThrow()
    if (xF64 < -1.0 || xF64 > 1.0) { return T.getNaN() }
    return acosT(x)
}
public func acos<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec1(acos(x.x))
}
public func acos<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec2(acos(x.x), acos(x.y))
}
public func acos<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec3(acos(x.x), acos(x.y), acos(x.z))
}
public func acos<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec4(acos(x.x), acos(x.y), acos(x.z), acos(x.w))
}

// ── atan ──

public func atan<T>(x: T): T where T <: FloatingPoint<T> { atanT(x) }
public func atan<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec1(atanT(x.x))
}
public func atan<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec2(atanT(x.x), atanT(x.y))
}
public func atan<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec3(atanT(x.x), atanT(x.y), atanT(x.z))
}
public func atan<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec4(atanT(x.x), atanT(x.y), atanT(x.z), atanT(x.w))
}

// ── sinh ──

public func sinh<T>(x: T): T where T <: FloatingPoint<T> { sinhT(x) }
public func sinh<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec1(sinhT(x.x))
}
public func sinh<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec2(sinhT(x.x), sinhT(x.y))
}
public func sinh<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec3(sinhT(x.x), sinhT(x.y), sinhT(x.z))
}
public func sinh<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec4(sinhT(x.x), sinhT(x.y), sinhT(x.z), sinhT(x.w))
}

// ── cosh ──

public func cosh<T>(x: T): T where T <: FloatingPoint<T> { coshT(x) }
public func cosh<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec1(coshT(x.x))
}
public func cosh<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec2(coshT(x.x), coshT(x.y))
}
public func cosh<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec3(coshT(x.x), coshT(x.y), coshT(x.z))
}
public func cosh<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec4(coshT(x.x), coshT(x.y), coshT(x.z), coshT(x.w))
}

// ── tanh ──

public func tanh<T>(x: T): T where T <: FloatingPoint<T> { tanhT(x) }
public func tanh<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec1(tanhT(x.x))
}
public func tanh<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec2(tanhT(x.x), tanhT(x.y))
}
public func tanh<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec3(tanhT(x.x), tanhT(x.y), tanhT(x.z))
}
public func tanh<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec4(tanhT(x.x), tanhT(x.y), tanhT(x.z), tanhT(x.w))
}

// ── asinh ──

public func asinh<T>(x: T): T where T <: FloatingPoint<T> { asinhT(x) }
public func asinh<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec1(asinhT(x.x))
}
public func asinh<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec2(asinhT(x.x), asinhT(x.y))
}
public func asinh<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec3(asinhT(x.x), asinhT(x.y), asinhT(x.z))
}
public func asinh<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec4(asinhT(x.x), asinhT(x.y), asinhT(x.z), asinhT(x.w))
}

// ── acosh ──

public func acosh<T>(x: T): T where T <: FloatingPoint<T> { acoshT(x) }
public func acosh<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec1(acoshT(x.x))
}
public func acosh<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec2(acoshT(x.x), acoshT(x.y))
}
public func acosh<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec3(acoshT(x.x), acoshT(x.y), acoshT(x.z))
}
public func acosh<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec4(acoshT(x.x), acoshT(x.y), acoshT(x.z), acoshT(x.w))
}

// ── atanh ──

public func atanh<T>(x: T): T where T <: FloatingPoint<T> { atanhT(x) }
public func atanh<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec1(atanhT(x.x))
}
public func atanh<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec2(atanhT(x.x), atanhT(x.y))
}
public func atanh<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec3(atanhT(x.x), atanhT(x.y), atanhT(x.z))
}
public func atanh<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec4(atanhT(x.x), atanhT(x.y), atanhT(x.z), atanhT(x.w))
}

// ── radians ──

public func radians<T>(x: T): T where T <: FloatingPoint<T> {
    let p: T = (pi<Float64>() as T).getOrThrow()
    x * p / (Float64(180) as T).getOrThrow()
}
public func radians<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec1(radians(x.x))
}
public func radians<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec2(radians(x.x), radians(x.y))
}
public func radians<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec3(radians(x.x), radians(x.y), radians(x.z))
}
public func radians<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec4(radians(x.x), radians(x.y), radians(x.z), radians(x.w))
}

// ── degrees ──

public func degrees<T>(x: T): T where T <: FloatingPoint<T> {
    let p: T = (pi<Float64>() as T).getOrThrow()
    x * (Float64(180) as T).getOrThrow() / p
}
public func degrees<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec1(degrees(x.x))
}
public func degrees<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec2(degrees(x.x), degrees(x.y))
}
public func degrees<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec3(degrees(x.x), degrees(x.y), degrees(x.z))
}
public func degrees<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec4(degrees(x.x), degrees(x.y), degrees(x.z), degrees(x.w))
}

// ── atan2 ──

public func atan2<T>(y: T, x: T): T where T <: FloatingPoint<T> { atan2T(y, x) }
public func atan2<T, Q>(y: Vec1<T, Q>, x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec1(atan2T(y.x, x.x))
}
public func atan2<T, Q>(y: Vec2<T, Q>, x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec2(atan2T(y.x, x.x), atan2T(y.y, x.y))
}
public func atan2<T, Q>(y: Vec3<T, Q>, x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec3(atan2T(y.x, x.x), atan2T(y.y, x.y), atan2T(y.z, x.z))
}
public func atan2<T, Q>(y: Vec4<T, Q>, x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec4(atan2T(y.x, x.x), atan2T(y.y, x.y), atan2T(y.z, x.z), atan2T(y.w, x.w))
}
