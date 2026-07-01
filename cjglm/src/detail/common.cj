package glm.detail

import std.math.{ Number, Integer, FloatingPoint }

// ── Group A: Number<T> & Comparable<T> (7 scalars + 28 Vec) ──

public func abs<T>(a: T): T where T <: Number<T> & Comparable<T> {
    let z: T = (Float64(0) as T).getOrThrow()
    if (a < z) {
        -a
    } else {
        a
    }
}

public func sign<T>(a: T): T where T <: Number<T> & Comparable<T> {
    let z: T = (Float64(0) as T).getOrThrow()
    let o: T = (Float64(1) as T).getOrThrow()
    if (a > z) {
        o
    } else if (a < z) {
        -o
    } else {
        z
    }
}

public func min<T>(a: T, b: T): T where T <: Number<T> & Comparable<T> {
    if (a < b) {
        a
    } else {
        b
    }
}

public func max<T>(a: T, b: T): T where T <: Number<T> & Comparable<T> {
    if (a > b) {
        a
    } else {
        b
    }
}

public func clamp<T>(a: T, minVal: T, maxVal: T): T where T <: Number<T> & Comparable<T> {
    min(max(a, minVal), maxVal)
}

public func step<T>(edge: T, x: T): T where T <: Number<T> & Comparable<T> {
    let z: T = (Float64(0) as T).getOrThrow()
    let o: T = (Float64(1) as T).getOrThrow()
    if (x < edge) {
        z
    } else {
        o
    }
}

public func smoothstep<T>(edge0: T, edge1: T, x: T): T where T <: Number<T> & Comparable<T> {
    let z: T = (Float64(0) as T).getOrThrow()
    let o: T = (Float64(1) as T).getOrThrow()
    let tw: T = (Float64(2) as T).getOrThrow()
    let th: T = (Float64(3) as T).getOrThrow()
    let t = clamp((x - edge0) / (edge1 - edge0), z, o)
    t * t * (th - tw * t)
}

// Vec1~Vec4 for Group A

public func abs<T, Q>(a: Vec1<T, Q>): Vec1<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec1(abs(a.x))
}
public func abs<T, Q>(a: Vec2<T, Q>): Vec2<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec2(abs(a.x), abs(a.y))
}
public func abs<T, Q>(a: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec3(abs(a.x), abs(a.y), abs(a.z))
}
public func abs<T, Q>(a: Vec4<T, Q>): Vec4<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec4(abs(a.x), abs(a.y), abs(a.z), abs(a.w))
}

public func sign<T, Q>(a: Vec1<T, Q>): Vec1<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec1(sign(a.x))
}
public func sign<T, Q>(a: Vec2<T, Q>): Vec2<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec2(sign(a.x), sign(a.y))
}
public func sign<T, Q>(a: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec3(sign(a.x), sign(a.y), sign(a.z))
}
public func sign<T, Q>(a: Vec4<T, Q>): Vec4<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec4(sign(a.x), sign(a.y), sign(a.z), sign(a.w))
}

public func min<T, Q>(a: Vec1<T, Q>, b: Vec1<T, Q>): Vec1<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec1(min(a.x, b.x))
}
public func min<T, Q>(a: Vec2<T, Q>, b: Vec2<T, Q>): Vec2<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec2(min(a.x, b.x), min(a.y, b.y))
}
public func min<T, Q>(a: Vec3<T, Q>, b: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec3(min(a.x, b.x), min(a.y, b.y), min(a.z, b.z))
}
public func min<T, Q>(a: Vec4<T, Q>, b: Vec4<T, Q>): Vec4<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec4(min(a.x, b.x), min(a.y, b.y), min(a.z, b.z), min(a.w, b.w))
}

public func max<T, Q>(a: Vec1<T, Q>, b: Vec1<T, Q>): Vec1<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec1(max(a.x, b.x))
}
public func max<T, Q>(a: Vec2<T, Q>, b: Vec2<T, Q>): Vec2<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec2(max(a.x, b.x), max(a.y, b.y))
}
public func max<T, Q>(a: Vec3<T, Q>, b: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec3(max(a.x, b.x), max(a.y, b.y), max(a.z, b.z))
}
public func max<T, Q>(a: Vec4<T, Q>, b: Vec4<T, Q>): Vec4<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec4(max(a.x, b.x), max(a.y, b.y), max(a.z, b.z), max(a.w, b.w))
}

public func clamp<T, Q>(a: Vec1<T, Q>, minVal: Vec1<T, Q>, maxVal: Vec1<T, Q>): Vec1<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec1(clamp(a.x, minVal.x, maxVal.x))
}
public func clamp<T, Q>(a: Vec2<T, Q>, minVal: Vec2<T, Q>, maxVal: Vec2<T, Q>): Vec2<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec2(clamp(a.x, minVal.x, maxVal.x), clamp(a.y, minVal.y, maxVal.y))
}
public func clamp<T, Q>(a: Vec3<T, Q>, minVal: Vec3<T, Q>, maxVal: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec3(clamp(a.x, minVal.x, maxVal.x), clamp(a.y, minVal.y, maxVal.y), clamp(a.z, minVal.z, maxVal.z))
}
public func clamp<T, Q>(a: Vec4<T, Q>, minVal: Vec4<T, Q>, maxVal: Vec4<T, Q>): Vec4<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec4(clamp(a.x, minVal.x, maxVal.x), clamp(a.y, minVal.y, maxVal.y), clamp(a.z, minVal.z, maxVal.z), clamp(a.w, minVal.w, maxVal.w))
}

public func step<T, Q>(edge: Vec1<T, Q>, x: Vec1<T, Q>): Vec1<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec1(step(edge.x, x.x))
}
public func step<T, Q>(edge: Vec2<T, Q>, x: Vec2<T, Q>): Vec2<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec2(step(edge.x, x.x), step(edge.y, x.y))
}
public func step<T, Q>(edge: Vec3<T, Q>, x: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec3(step(edge.x, x.x), step(edge.y, x.y), step(edge.z, x.z))
}
public func step<T, Q>(edge: Vec4<T, Q>, x: Vec4<T, Q>): Vec4<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec4(step(edge.x, x.x), step(edge.y, x.y), step(edge.z, x.z), step(edge.w, x.w))
}

public func smoothstep<T, Q>(edge0: Vec1<T, Q>, edge1: Vec1<T, Q>, x: Vec1<T, Q>): Vec1<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec1(smoothstep(edge0.x, edge1.x, x.x))
}
public func smoothstep<T, Q>(edge0: Vec2<T, Q>, edge1: Vec2<T, Q>, x: Vec2<T, Q>): Vec2<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec2(smoothstep(edge0.x, edge1.x, x.x), smoothstep(edge0.y, edge1.y, x.y))
}
public func smoothstep<T, Q>(edge0: Vec3<T, Q>, edge1: Vec3<T, Q>, x: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec3(smoothstep(edge0.x, edge1.x, x.x), smoothstep(edge0.y, edge1.y, x.y), smoothstep(edge0.z, edge1.z, x.z))
}
public func smoothstep<T, Q>(edge0: Vec4<T, Q>, edge1: Vec4<T, Q>, x: Vec4<T, Q>): Vec4<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec4(smoothstep(edge0.x, edge1.x, x.x), smoothstep(edge0.y, edge1.y, x.y), smoothstep(edge0.z, edge1.z, x.z), smoothstep(edge0.w, edge1.w, x.w))
}

// ── Group B: FloatingPoint<T> (12 scalars + 48 Vec) ──

public func floor<T>(a: T): T where T <: FloatingPoint<T> { floorT(a) }
public func ceil<T>(a: T): T where T <: FloatingPoint<T> { ceilT(a) }
public func fract<T>(a: T): T where T <: FloatingPoint<T> { a - floorT(a) }
public func trunc<T>(a: T): T where T <: FloatingPoint<T> { truncT(a) }
public func round<T>(a: T): T where T <: FloatingPoint<T> { roundT(a) }

public func roundEven<T>(a: T): T where T <: FloatingPoint<T> {
    let r = roundT(a)
    let diffF64: Float64 = (absT(r - a) as Float64).getOrThrow()
    let halfF64: Float64 = 0.5
    let one: T = (Float64(1) as T).getOrThrow()
    if (diffF64 == halfF64) {
        let rF64: Float64 = (r as Float64).getOrThrow()
        let rInt: Int64 = (rF64 as Int64).getOrThrow()
        if (rInt % 2 == 0) {
            r
        } else {
            r - one
        }
    } else {
        r
    }
}

public func fma<T>(a: T, b: T, c: T): T where T <: FloatingPoint<T> { a * b + c }

public func frexp<T>(x: T): (T, Int64) where T <: FloatingPoint<T> {
    if (x.isNaN()) {
        return (T.getNaN(), Int64(0))
    }
    if (x.isInf()) {
        return (x, Int64(0))
    }
    let xF64: Float64 = (x as Float64).getOrThrow()
    if (xF64 == 0.0) {
        return ((Float64(0) as T).getOrThrow(), Int64(0))
    }
    let absX = absT(x)
    let logVal = log2T(absX)
    let floorVal = floorT(logVal)
    let floorF64: Float64 = (floorVal as Float64).getOrThrow()
    let exp: Int64 = (floorF64 as Int64).getOrThrow() + Int64(1)
    let tw: T = (Float64(2) as T).getOrThrow()
    let expT: T = (Float64(exp) as T).getOrThrow()
    let mant = x / powT(tw, expT)
    (mant, exp)
}

public func ldexp<T>(x: T, exp: Int64): T where T <: FloatingPoint<T> {
    let tw: T = (Float64(2) as T).getOrThrow()
    let expT: T = (Float64(exp) as T).getOrThrow()
    x * powT(tw, expT)
}

public func modf<T>(x: T): (T, T) where T <: FloatingPoint<T> {
    let i = truncT(x)
    (x - i, i)
}

public func isnan<T>(x: T): Bool where T <: FloatingPoint<T> { x.isNaN() }
public func isinf<T>(x: T): Bool where T <: FloatingPoint<T> { x.isInf() }

// Vec1~Vec4 for Group B (unary)

public func floor<T, Q>(a: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec1(floorT(a.x)) }
public func floor<T, Q>(a: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec2(floorT(a.x), floorT(a.y)) }
public func floor<T, Q>(a: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec3(floorT(a.x), floorT(a.y), floorT(a.z)) }
public func floor<T, Q>(a: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec4(floorT(a.x), floorT(a.y), floorT(a.z), floorT(a.w)) }

public func ceil<T, Q>(a: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec1(ceilT(a.x)) }
public func ceil<T, Q>(a: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec2(ceilT(a.x), ceilT(a.y)) }
public func ceil<T, Q>(a: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec3(ceilT(a.x), ceilT(a.y), ceilT(a.z)) }
public func ceil<T, Q>(a: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec4(ceilT(a.x), ceilT(a.y), ceilT(a.z), ceilT(a.w)) }

public func fract<T, Q>(a: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec1(a.x - floorT(a.x)) }
public func fract<T, Q>(a: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec2(a.x - floorT(a.x), a.y - floorT(a.y)) }
public func fract<T, Q>(a: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec3(a.x - floorT(a.x), a.y - floorT(a.y), a.z - floorT(a.z)) }
public func fract<T, Q>(a: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec4(a.x - floorT(a.x), a.y - floorT(a.y), a.z - floorT(a.z), a.w - floorT(a.w)) }

public func trunc<T, Q>(a: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec1(truncT(a.x)) }
public func trunc<T, Q>(a: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec2(truncT(a.x), truncT(a.y)) }
public func trunc<T, Q>(a: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec3(truncT(a.x), truncT(a.y), truncT(a.z)) }
public func trunc<T, Q>(a: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec4(truncT(a.x), truncT(a.y), truncT(a.z), truncT(a.w)) }

public func round<T, Q>(a: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec1(roundT(a.x)) }
public func round<T, Q>(a: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec2(roundT(a.x), roundT(a.y)) }
public func round<T, Q>(a: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec3(roundT(a.x), roundT(a.y), roundT(a.z)) }
public func round<T, Q>(a: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec4(roundT(a.x), roundT(a.y), roundT(a.z), roundT(a.w)) }

public func roundEven<T, Q>(a: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec1(roundEven(a.x)) }
public func roundEven<T, Q>(a: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec2(roundEven(a.x), roundEven(a.y)) }
public func roundEven<T, Q>(a: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec3(roundEven(a.x), roundEven(a.y), roundEven(a.z)) }
public func roundEven<T, Q>(a: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec4(roundEven(a.x), roundEven(a.y), roundEven(a.z), roundEven(a.w)) }

public func fma<T, Q>(a: Vec1<T, Q>, b: Vec1<T, Q>, c: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec1(a.x * b.x + c.x) }
public func fma<T, Q>(a: Vec2<T, Q>, b: Vec2<T, Q>, c: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec2(a.x * b.x + c.x, a.y * b.y + c.y) }
public func fma<T, Q>(a: Vec3<T, Q>, b: Vec3<T, Q>, c: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec3(a.x * b.x + c.x, a.y * b.y + c.y, a.z * b.z + c.z) }
public func fma<T, Q>(a: Vec4<T, Q>, b: Vec4<T, Q>, c: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec4(a.x * b.x + c.x, a.y * b.y + c.y, a.z * b.z + c.z, a.w * b.w + c.w) }

public func ldexp<T, Q>(x: Vec1<T, Q>, exp: Int64): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec1(ldexp(x.x, exp)) }
public func ldexp<T, Q>(x: Vec2<T, Q>, exp: Int64): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec2(ldexp(x.x, exp), ldexp(x.y, exp)) }
public func ldexp<T, Q>(x: Vec3<T, Q>, exp: Int64): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec3(ldexp(x.x, exp), ldexp(x.y, exp), ldexp(x.z, exp)) }
public func ldexp<T, Q>(x: Vec4<T, Q>, exp: Int64): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec4(ldexp(x.x, exp), ldexp(x.y, exp), ldexp(x.z, exp), ldexp(x.w, exp)) }

public func modf<T, Q>(x: Vec1<T, Q>): (Vec1<T, Q>, Vec1<T, Q>) where T <: FloatingPoint<T>, Q <: Qualifier {
    let (f, i) = modf(x.x); (Vec1(f), Vec1(i))
}
public func modf<T, Q>(x: Vec2<T, Q>): (Vec2<T, Q>, Vec2<T, Q>) where T <: FloatingPoint<T>, Q <: Qualifier {
    let (f1, i1) = modf(x.x); let (f2, i2) = modf(x.y); (Vec2(f1, f2), Vec2(i1, i2))
}
public func modf<T, Q>(x: Vec3<T, Q>): (Vec3<T, Q>, Vec3<T, Q>) where T <: FloatingPoint<T>, Q <: Qualifier {
    let (f1, i1) = modf(x.x); let (f2, i2) = modf(x.y); let (f3, i3) = modf(x.z)
    (Vec3(f1, f2, f3), Vec3(i1, i2, i3))
}
public func modf<T, Q>(x: Vec4<T, Q>): (Vec4<T, Q>, Vec4<T, Q>) where T <: FloatingPoint<T>, Q <: Qualifier {
    let (f1, i1) = modf(x.x); let (f2, i2) = modf(x.y); let (f3, i3) = modf(x.z); let (f4, i4) = modf(x.w)
    (Vec4(f1, f2, f3, f4), Vec4(i1, i2, i3, i4))
}

public func frexp<T, Q>(x: Vec1<T, Q>): (Vec1<T, Q>, Vec1<Int64, Q>) where T <: FloatingPoint<T>, Q <: Qualifier {
    let (m, e) = frexp(x.x); (Vec1(m), Vec1<Int64, Q>(e))
}
public func frexp<T, Q>(x: Vec2<T, Q>): (Vec2<T, Q>, Vec2<Int64, Q>) where T <: FloatingPoint<T>, Q <: Qualifier {
    let (m1, e1) = frexp(x.x); let (m2, e2) = frexp(x.y); (Vec2(m1, m2), Vec2<Int64, Q>(e1, e2))
}
public func frexp<T, Q>(x: Vec3<T, Q>): (Vec3<T, Q>, Vec3<Int64, Q>) where T <: FloatingPoint<T>, Q <: Qualifier {
    let (m1, e1) = frexp(x.x); let (m2, e2) = frexp(x.y); let (m3, e3) = frexp(x.z)
    (Vec3(m1, m2, m3), Vec3<Int64, Q>(e1, e2, e3))
}
public func frexp<T, Q>(x: Vec4<T, Q>): (Vec4<T, Q>, Vec4<Int64, Q>) where T <: FloatingPoint<T>, Q <: Qualifier {
    let (m1, e1) = frexp(x.x); let (m2, e2) = frexp(x.y); let (m3, e3) = frexp(x.z); let (m4, e4) = frexp(x.w)
    (Vec4(m1, m2, m3, m4), Vec4<Int64, Q>(e1, e2, e3, e4))
}

public func isnan<T, Q>(x: Vec1<T, Q>): Vec1<Bool, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec1<Bool, Q>(x.x.isNaN()) }
public func isnan<T, Q>(x: Vec2<T, Q>): Vec2<Bool, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec2<Bool, Q>(x.x.isNaN(), x.y.isNaN()) }
public func isnan<T, Q>(x: Vec3<T, Q>): Vec3<Bool, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec3<Bool, Q>(x.x.isNaN(), x.y.isNaN(), x.z.isNaN()) }
public func isnan<T, Q>(x: Vec4<T, Q>): Vec4<Bool, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec4<Bool, Q>(x.x.isNaN(), x.y.isNaN(), x.z.isNaN(), x.w.isNaN()) }

public func isinf<T, Q>(x: Vec1<T, Q>): Vec1<Bool, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec1<Bool, Q>(x.x.isInf()) }
public func isinf<T, Q>(x: Vec2<T, Q>): Vec2<Bool, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec2<Bool, Q>(x.x.isInf(), x.y.isInf()) }
public func isinf<T, Q>(x: Vec3<T, Q>): Vec3<Bool, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec3<Bool, Q>(x.x.isInf(), x.y.isInf(), x.z.isInf()) }
public func isinf<T, Q>(x: Vec4<T, Q>): Vec4<Bool, Q> where T <: FloatingPoint<T>, Q <: Qualifier { Vec4<Bool, Q>(x.x.isInf(), x.y.isInf(), x.z.isInf(), x.w.isInf()) }

// ── Group C: mix (2 scalars + 8 Vec) ──

public func mix<T>(a: T, b: T, t: T): T where T <: Number<T> {
    let o: T = (Float64(1) as T).getOrThrow()
    a * (o - t) + b * t
}

public func mix<T>(x: T, y: T, a: Bool): T { if (a) { y } else { x } }

public func mix<T, Q>(a: Vec1<T, Q>, b: Vec1<T, Q>, t: Vec1<T, Q>): Vec1<T, Q> where T <: Number<T>, Q <: Qualifier { Vec1(mix(a.x, b.x, t.x)) }
public func mix<T, Q>(a: Vec2<T, Q>, b: Vec2<T, Q>, t: Vec2<T, Q>): Vec2<T, Q> where T <: Number<T>, Q <: Qualifier { Vec2(mix(a.x, b.x, t.x), mix(a.y, b.y, t.y)) }
public func mix<T, Q>(a: Vec3<T, Q>, b: Vec3<T, Q>, t: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T>, Q <: Qualifier { Vec3(mix(a.x, b.x, t.x), mix(a.y, b.y, t.y), mix(a.z, b.z, t.z)) }
public func mix<T, Q>(a: Vec4<T, Q>, b: Vec4<T, Q>, t: Vec4<T, Q>): Vec4<T, Q> where T <: Number<T>, Q <: Qualifier { Vec4(mix(a.x, b.x, t.x), mix(a.y, b.y, t.y), mix(a.z, b.z, t.z), mix(a.w, b.w, t.w)) }

public func mix<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, a: Bool): Vec1<T, Q> where Q <: Qualifier { if (a) { y } else { x } }
public func mix<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, a: Bool): Vec2<T, Q> where Q <: Qualifier { if (a) { y } else { x } }
public func mix<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, a: Bool): Vec3<T, Q> where Q <: Qualifier { if (a) { y } else { x } }
public func mix<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, a: Bool): Vec4<T, Q> where Q <: Qualifier { if (a) { y } else { x } }

// ── Group D: mod for Integer<T> (1 scalar + 4 Vec) ──

public func mod<T>(a: T, b: T): T where T <: Integer<T> { a % b }

public func mod<T, Q>(a: Vec1<T, Q>, b: Vec1<T, Q>): Vec1<T, Q> where T <: Integer<T>, Q <: Qualifier { Vec1(a.x % b.x) }
public func mod<T, Q>(a: Vec2<T, Q>, b: Vec2<T, Q>): Vec2<T, Q> where T <: Integer<T>, Q <: Qualifier { Vec2(a.x % b.x, a.y % b.y) }
public func mod<T, Q>(a: Vec3<T, Q>, b: Vec3<T, Q>): Vec3<T, Q> where T <: Integer<T>, Q <: Qualifier { Vec3(a.x % b.x, a.y % b.y, a.z % b.z) }
public func mod<T, Q>(a: Vec4<T, Q>, b: Vec4<T, Q>): Vec4<T, Q> where T <: Integer<T>, Q <: Qualifier { Vec4(a.x % b.x, a.y % b.y, a.z % b.z, a.w % b.w) }

// ── Group E: mod for concrete float types (3 scalars) ──

public func mod(x: Float32, y: Float32): Float32 { x - y * floorT(x / y) }
public func mod(x: Float64, y: Float64): Float64 { x - y * floorT(x / y) }
public func mod(x: Float16, y: Float16): Float16 { x - y * floorT(x / y) }

// ── Group F: bit conversion (4 scalars + 16 Vec) ──

public func floatBitsToInt(x: Float32): Int32 { (x.toBits() as Int32).getOrThrow() }
public func floatBitsToUint(x: Float32): UInt32 { x.toBits() }
public func intBitsToFloat(bits: Int32): Float32 { Float32.fromBits((bits as UInt32).getOrThrow()) }
public func uintBitsToFloat(bits: UInt32): Float32 { Float32.fromBits(bits) }

public func floatBitsToInt<Q>(x: Vec1<Float32, Q>): Vec1<Int32, Q> where Q <: Qualifier { Vec1<Int32, Q>((x.x.toBits() as Int32).getOrThrow()) }
public func floatBitsToInt<Q>(x: Vec2<Float32, Q>): Vec2<Int32, Q> where Q <: Qualifier { Vec2<Int32, Q>((x.x.toBits() as Int32).getOrThrow(), (x.y.toBits() as Int32).getOrThrow()) }
public func floatBitsToInt<Q>(x: Vec3<Float32, Q>): Vec3<Int32, Q> where Q <: Qualifier { Vec3<Int32, Q>((x.x.toBits() as Int32).getOrThrow(), (x.y.toBits() as Int32).getOrThrow(), (x.z.toBits() as Int32).getOrThrow()) }
public func floatBitsToInt<Q>(x: Vec4<Float32, Q>): Vec4<Int32, Q> where Q <: Qualifier { Vec4<Int32, Q>((x.x.toBits() as Int32).getOrThrow(), (x.y.toBits() as Int32).getOrThrow(), (x.z.toBits() as Int32).getOrThrow(), (x.w.toBits() as Int32).getOrThrow()) }

public func floatBitsToUint<Q>(x: Vec1<Float32, Q>): Vec1<UInt32, Q> where Q <: Qualifier { Vec1<UInt32, Q>(x.x.toBits()) }
public func floatBitsToUint<Q>(x: Vec2<Float32, Q>): Vec2<UInt32, Q> where Q <: Qualifier { Vec2<UInt32, Q>(x.x.toBits(), x.y.toBits()) }
public func floatBitsToUint<Q>(x: Vec3<Float32, Q>): Vec3<UInt32, Q> where Q <: Qualifier { Vec3<UInt32, Q>(x.x.toBits(), x.y.toBits(), x.z.toBits()) }
public func floatBitsToUint<Q>(x: Vec4<Float32, Q>): Vec4<UInt32, Q> where Q <: Qualifier { Vec4<UInt32, Q>(x.x.toBits(), x.y.toBits(), x.z.toBits(), x.w.toBits()) }

public func intBitsToFloat<Q>(bits: Vec1<Int32, Q>): Vec1<Float32, Q> where Q <: Qualifier { Vec1<Float32, Q>(Float32.fromBits((bits.x as UInt32).getOrThrow())) }
public func intBitsToFloat<Q>(bits: Vec2<Int32, Q>): Vec2<Float32, Q> where Q <: Qualifier { Vec2<Float32, Q>(Float32.fromBits((bits.x as UInt32).getOrThrow()), Float32.fromBits((bits.y as UInt32).getOrThrow())) }
public func intBitsToFloat<Q>(bits: Vec3<Int32, Q>): Vec3<Float32, Q> where Q <: Qualifier { Vec3<Float32, Q>(Float32.fromBits((bits.x as UInt32).getOrThrow()), Float32.fromBits((bits.y as UInt32).getOrThrow()), Float32.fromBits((bits.z as UInt32).getOrThrow())) }
public func intBitsToFloat<Q>(bits: Vec4<Int32, Q>): Vec4<Float32, Q> where Q <: Qualifier { Vec4<Float32, Q>(Float32.fromBits((bits.x as UInt32).getOrThrow()), Float32.fromBits((bits.y as UInt32).getOrThrow()), Float32.fromBits((bits.z as UInt32).getOrThrow()), Float32.fromBits((bits.w as UInt32).getOrThrow())) }

public func uintBitsToFloat<Q>(bits: Vec1<UInt32, Q>): Vec1<Float32, Q> where Q <: Qualifier { Vec1<Float32, Q>(Float32.fromBits(bits.x)) }
public func uintBitsToFloat<Q>(bits: Vec2<UInt32, Q>): Vec2<Float32, Q> where Q <: Qualifier { Vec2<Float32, Q>(Float32.fromBits(bits.x), Float32.fromBits(bits.y)) }
public func uintBitsToFloat<Q>(bits: Vec3<UInt32, Q>): Vec3<Float32, Q> where Q <: Qualifier { Vec3<Float32, Q>(Float32.fromBits(bits.x), Float32.fromBits(bits.y), Float32.fromBits(bits.z)) }
public func uintBitsToFloat<Q>(bits: Vec4<UInt32, Q>): Vec4<Float32, Q> where Q <: Qualifier { Vec4<Float32, Q>(Float32.fromBits(bits.x), Float32.fromBits(bits.y), Float32.fromBits(bits.z), Float32.fromBits(bits.w)) }
