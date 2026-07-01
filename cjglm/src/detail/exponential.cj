package glm.detail

import std.math.FloatingPoint

// ── 7 exponential functions: scalar + Vec1~Vec4 ──

public func pow<T>(base: T, exp: T): T where T <: FloatingPoint<T> { powT(base, exp) }
public func exp<T>(x: T): T where T <: FloatingPoint<T> { expT(x) }
public func log<T>(x: T): T where T <: FloatingPoint<T> { logT(x) }
public func exp2<T>(x: T): T where T <: FloatingPoint<T> { exp2T(x) }
public func log2<T>(x: T): T where T <: FloatingPoint<T> { log2T(x) }
public func sqrt<T>(x: T): T where T <: FloatingPoint<T> { sqrtT(x) }
public func inversesqrt<T>(x: T): T where T <: FloatingPoint<T> {
    let o: T = (Float64(1) as T).getOrThrow()
    o / sqrtT(x)
}

// Vec1~Vec4 overloads

public func pow<T, Q>(base: Vec1<T, Q>, exp: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec1(powT(base.x, exp.x))
}
public func pow<T, Q>(base: Vec2<T, Q>, exp: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec2(powT(base.x, exp.x), powT(base.y, exp.y))
}
public func pow<T, Q>(base: Vec3<T, Q>, exp: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec3(powT(base.x, exp.x), powT(base.y, exp.y), powT(base.z, exp.z))
}
public func pow<T, Q>(base: Vec4<T, Q>, exp: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec4(powT(base.x, exp.x), powT(base.y, exp.y), powT(base.z, exp.z), powT(base.w, exp.w))
}

public func exp<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec1(expT(x.x)) }
public func exp<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec2(expT(x.x), expT(x.y)) }
public func exp<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec3(expT(x.x), expT(x.y), expT(x.z)) }
public func exp<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec4(expT(x.x), expT(x.y), expT(x.z), expT(x.w)) }

public func log<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec1(logT(x.x)) }
public func log<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec2(logT(x.x), logT(x.y)) }
public func log<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec3(logT(x.x), logT(x.y), logT(x.z)) }
public func log<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec4(logT(x.x), logT(x.y), logT(x.z), logT(x.w)) }

public func exp2<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec1(exp2T(x.x)) }
public func exp2<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec2(exp2T(x.x), exp2T(x.y)) }
public func exp2<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec3(exp2T(x.x), exp2T(x.y), exp2T(x.z)) }
public func exp2<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec4(exp2T(x.x), exp2T(x.y), exp2T(x.z), exp2T(x.w)) }

public func log2<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec1(log2T(x.x)) }
public func log2<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec2(log2T(x.x), log2T(x.y)) }
public func log2<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec3(log2T(x.x), log2T(x.y), log2T(x.z)) }
public func log2<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec4(log2T(x.x), log2T(x.y), log2T(x.z), log2T(x.w)) }

public func sqrt<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec1(sqrtT(x.x)) }
public func sqrt<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec2(sqrtT(x.x), sqrtT(x.y)) }
public func sqrt<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec3(sqrtT(x.x), sqrtT(x.y), sqrtT(x.z)) }
public func sqrt<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec4(sqrtT(x.x), sqrtT(x.y), sqrtT(x.z), sqrtT(x.w)) }

public func inversesqrt<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec1(inversesqrt(x.x)) }
public func inversesqrt<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec2(inversesqrt(x.x), inversesqrt(x.y)) }
public func inversesqrt<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec3(inversesqrt(x.x), inversesqrt(x.y), inversesqrt(x.z)) }
public func inversesqrt<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec4(inversesqrt(x.x), inversesqrt(x.y), inversesqrt(x.z), inversesqrt(x.w)) }
