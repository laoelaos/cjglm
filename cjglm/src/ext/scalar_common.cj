package glm.ext

import std.math.{ FloatingPoint, Number }
import std.math as math
import glm.detail.{ min, max, abs, clamp, floor, fract, isnan, mix, roundT }

// ── Group 1: 3/4 input min/max ──

public func min<T>(a: T, b: T, c: T): T where T <: Number<T> & Comparable<T> {
    min(min(a, b), c)
}

public func min<T>(a: T, b: T, c: T, d: T): T where T <: Number<T> & Comparable<T> {
    min(min(a, b), min(c, d))
}

public func max<T>(a: T, b: T, c: T): T where T <: Number<T> & Comparable<T> {
    max(max(a, b), c)
}

public func max<T>(a: T, b: T, c: T, d: T): T where T <: Number<T> & Comparable<T> {
    max(max(a, b), max(c, d))
}

// ── Group 2: NaN-safe fmin ──

public func fmin<T>(a: T, b: T): T where T <: FloatingPoint<T> & Comparable<T> {
    if (isnan(a)) { b }
    else if (isnan(b)) { a }
    else { min(a, b) }
}

public func fmin<T>(a: T, b: T, c: T): T where T <: FloatingPoint<T> & Comparable<T> {
    if (isnan(a)) { fmin(b, c) }
    else if (isnan(b)) { fmin(a, c) }
    else if (isnan(c)) { min(a, b) }
    else { min(min(a, b), c) }
}

public func fmin<T>(a: T, b: T, c: T, d: T): T where T <: FloatingPoint<T> & Comparable<T> {
    if (isnan(a)) { fmin(b, c, d) }
    else if (isnan(b)) { fmin(a, fmin(c, d)) }
    else if (isnan(c)) { fmin(min(a, b), d) }
    else if (isnan(d)) { min(min(a, b), c) }
    else { min(min(a, b), min(c, d)) }
}

// ── Group 3: NaN-safe fmax ──

public func fmax<T>(a: T, b: T): T where T <: FloatingPoint<T> & Comparable<T> {
    if (isnan(a)) { b }
    else if (isnan(b)) { a }
    else { max(a, b) }
}

public func fmax<T>(a: T, b: T, c: T): T where T <: FloatingPoint<T> & Comparable<T> {
    if (isnan(a)) { fmax(b, c) }
    else if (isnan(b)) { fmax(a, c) }
    else if (isnan(c)) { max(a, b) }
    else { max(max(a, b), c) }
}

public func fmax<T>(a: T, b: T, c: T, d: T): T where T <: FloatingPoint<T> & Comparable<T> {
    if (isnan(a)) { fmax(b, c, d) }
    else if (isnan(b)) { fmax(a, fmax(c, d)) }
    else if (isnan(c)) { fmax(max(a, b), d) }
    else if (isnan(d)) { max(max(a, b), c) }
    else { max(max(a, b), max(c, d)) }
}

// ── Group 4: fclamp ──

public func fclamp<T>(x: T, minVal: T, maxVal: T): T where T <: FloatingPoint<T> & Comparable<T> {
    fmin(fmax(x, minVal), maxVal)
}

// ── Group 5: Texture wrapping modes ──

public func clamp<T>(Texcoord: T): T where T <: FloatingPoint<T> & Comparable<T> {
    clamp(Texcoord, (Float64(0) as T).getOrThrow(), (Float64(1) as T).getOrThrow())
}

public func repeat<T>(Texcoord: T): T where T <: FloatingPoint<T> {
    fract(Texcoord)
}

public func mirrorClamp<T>(Texcoord: T): T where T <: FloatingPoint<T> & Comparable<T> {
    fract(abs(Texcoord))
}

public func mirrorRepeat<T>(Texcoord: T): T where T <: FloatingPoint<T> & Comparable<T> {
    let Abs = abs(Texcoord)
    let Floor = floor(Abs)
    let one = (Float64(1) as T).getOrThrow()
    let two = (Float64(2) as T).getOrThrow()
    let Clamp = Floor - two * floor(Floor / two)
    let Rest = Abs - Floor
    let Mirror = Clamp + Rest
    mix(Rest, one - Rest, Mirror >= one)
}

// ── Group 6: Float-to-integer rounding ──

public func iround<T>(x: T): Int64 where T <: FloatingPoint<T> {
    (roundT(x) as Int64).getOrThrow()
}

public func uround<T>(x: T): UInt64 where T <: FloatingPoint<T> {
    (roundT(x) as UInt64).getOrThrow()
}
