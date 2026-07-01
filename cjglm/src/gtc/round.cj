package glm.gtc
import glm.detail.{ floor, ceil, round, frexp, ldexp }
import std.math.FloatingPoint

public func roundPowerOfTwo<T>(x: T): T where T <: FloatingPoint<T> {
    if (x.isNaN()) { return x }
    if (x.isInf()) { return x }
    let xF64 = (x as Float64).getOrThrow()
    if (xF64 == 0.0) {
        return x
    }
    let absX = if (xF64 < 0.0) { -x } else { x }
    let (_, exp) = frexp(absX)
    let one = (Float64(1) as T).getOrThrow()
    let floorPow = ldexp(one, exp - Int64(1))
    let ceilPow = ldexp(one, exp)
    let floorF64 = (floorPow as Float64).getOrThrow()
    let ceilF64 = (ceilPow as Float64).getOrThrow()
    let absF64 = (absX as Float64).getOrThrow()
    let diffFloor = absF64 - floorF64
    let diffCeil = ceilF64 - absF64
    let nearest = if (diffFloor < diffCeil) { floorPow } else { ceilPow }
    if (xF64 < 0.0) { -nearest } else { nearest }
}

public func ceilPowerOfTwo<T>(x: T): T where T <: FloatingPoint<T> {
    if (x.isNaN()) { return x }
    if (x.isInf()) { return x }
    let xF64 = (x as Float64).getOrThrow()
    if (xF64 == 0.0) {
        return x
    }
    if (xF64 < 0.0) {
        return (Float64(0) as T).getOrThrow()
    }
    let (_, exp) = frexp(x)
    let one = (Float64(1) as T).getOrThrow()
    let floorPow = ldexp(one, exp - Int64(1))
    let floorF64 = (floorPow as Float64).getOrThrow()
    if (floorF64 == xF64) { return x }
    ldexp(one, exp)
}

public func floorPowerOfTwo<T>(x: T): T where T <: FloatingPoint<T> {
    if (x.isNaN()) { return x }
    if (x.isInf()) { return x }
    let xF64 = (x as Float64).getOrThrow()
    if (xF64 == 0.0) {
        return x
    }
    let absX = if (xF64 < 0.0) { -x } else { x }
    let (_, exp) = frexp(absX)
    let one = (Float64(1) as T).getOrThrow()
    let result = ldexp(one, exp - Int64(1))
    if (xF64 < 0.0) { -result } else { result }
}

public func roundMultiple<T>(x: T, multiple: T): T where T <: FloatingPoint<T> {
    multiple * round(x / multiple)
}

public func ceilMultiple<T>(x: T, multiple: T): T where T <: FloatingPoint<T> {
    multiple * ceil(x / multiple)
}

public func floorMultiple<T>(x: T, multiple: T): T where T <: FloatingPoint<T> {
    multiple * floor(x / multiple)
}
