package glm.detail

import std.math.FloatingPoint
import std.math as math

public func sqrtT<T>(x: T): T where T <: FloatingPoint<T> {
    (math.sqrt((x as Float64).getOrThrow()) as T).getOrThrow()
}

public func expT<T>(x: T): T where T <: FloatingPoint<T> {
    (math.exp((x as Float64).getOrThrow()) as T).getOrThrow()
}

public func logT<T>(x: T): T where T <: FloatingPoint<T> {
    (math.log((x as Float64).getOrThrow()) as T).getOrThrow()
}

public func exp2T<T>(x: T): T where T <: FloatingPoint<T> {
    (math.exp2((x as Float64).getOrThrow()) as T).getOrThrow()
}

public func log2T<T>(x: T): T where T <: FloatingPoint<T> {
    (math.log2((x as Float64).getOrThrow()) as T).getOrThrow()
}

public func powT<T>(base: T, exp: T): T where T <: FloatingPoint<T> {
    (math.pow((base as Float64).getOrThrow(), (exp as Float64).getOrThrow()) as T).getOrThrow()
}

public func sinT<T>(x: T): T where T <: FloatingPoint<T> {
    (math.sin((x as Float64).getOrThrow()) as T).getOrThrow()
}

public func cosT<T>(x: T): T where T <: FloatingPoint<T> {
    (math.cos((x as Float64).getOrThrow()) as T).getOrThrow()
}

public func tanT<T>(x: T): T where T <: FloatingPoint<T> {
    (math.tan((x as Float64).getOrThrow()) as T).getOrThrow()
}

public func asinT<T>(x: T): T where T <: FloatingPoint<T> {
    (math.asin((x as Float64).getOrThrow()) as T).getOrThrow()
}

public func acosT<T>(x: T): T where T <: FloatingPoint<T> {
    (math.acos((x as Float64).getOrThrow()) as T).getOrThrow()
}

public func atanT<T>(x: T): T where T <: FloatingPoint<T> {
    (math.atan((x as Float64).getOrThrow()) as T).getOrThrow()
}

public func atan2T<T>(y: T, x: T): T where T <: FloatingPoint<T> {
    (math.atan2((y as Float64).getOrThrow(), (x as Float64).getOrThrow()) as T).getOrThrow()
}

public func sinhT<T>(x: T): T where T <: FloatingPoint<T> {
    (math.sinh((x as Float64).getOrThrow()) as T).getOrThrow()
}

public func coshT<T>(x: T): T where T <: FloatingPoint<T> {
    (math.cosh((x as Float64).getOrThrow()) as T).getOrThrow()
}

public func tanhT<T>(x: T): T where T <: FloatingPoint<T> {
    (math.tanh((x as Float64).getOrThrow()) as T).getOrThrow()
}

public func asinhT<T>(x: T): T where T <: FloatingPoint<T> {
    (math.asinh((x as Float64).getOrThrow()) as T).getOrThrow()
}

public func acoshT<T>(x: T): T where T <: FloatingPoint<T> {
    (math.acosh((x as Float64).getOrThrow()) as T).getOrThrow()
}

public func atanhT<T>(x: T): T where T <: FloatingPoint<T> {
    (math.atanh((x as Float64).getOrThrow()) as T).getOrThrow()
}

public func floorT<T>(x: T): T where T <: FloatingPoint<T> {
    (math.floor((x as Float64).getOrThrow()) as T).getOrThrow()
}

public func ceilT<T>(x: T): T where T <: FloatingPoint<T> {
    (math.ceil((x as Float64).getOrThrow()) as T).getOrThrow()
}

public func roundT<T>(x: T): T where T <: FloatingPoint<T> {
    (math.round((x as Float64).getOrThrow()) as T).getOrThrow()
}

public func truncT<T>(x: T): T where T <: FloatingPoint<T> {
    (math.trunc((x as Float64).getOrThrow()) as T).getOrThrow()
}

public func absT<T>(x: T): T where T <: FloatingPoint<T> {
    (math.abs((x as Float64).getOrThrow()) as T).getOrThrow()
}

public func fmodT<T>(x: T, y: T): T where T <: FloatingPoint<T> {
    (math.fmod((x as Float64).getOrThrow(), (y as Float64).getOrThrow()) as T).getOrThrow()
}
