package glm.gtc
import glm.detail.{ abs }

public func next_float(x: Float32): Float32 {
    if (x.isNaN()) { return x }
    if (x.isInf()) { return x }
    if (x == Float32(0.0)) { return Float32.fromBits(UInt32(1)) }
    let bits = x.toBits()
    if (x > Float32(0.0)) {
        Float32.fromBits(bits + UInt32(1))
    } else {
        Float32.fromBits(bits - UInt32(1))
    }
}

public func next_float(x: Float64): Float64 {
    if (x.isNaN()) { return x }
    if (x.isInf()) { return x }
    if (x == Float64(0.0)) { return Float64.fromBits(UInt64(1)) }
    let bits = x.toBits()
    if (x > Float64(0.0)) {
        Float64.fromBits(bits + UInt64(1))
    } else {
        Float64.fromBits(bits - UInt64(1))
    }
}

public func prev_float(x: Float32): Float32 {
    if (x.isNaN()) { return x }
    if (x.isInf()) { return x }
    if (x == Float32(0.0)) { return Float32.fromBits(UInt32(0x80000001)) }
    let bits = x.toBits()
    if (x > Float32(0.0)) {
        Float32.fromBits(bits - UInt32(1))
    } else {
        Float32.fromBits(bits + UInt32(1))
    }
}

public func prev_float(x: Float64): Float64 {
    if (x.isNaN()) { return x }
    if (x.isInf()) { return x }
    if (x == Float64(0.0)) { return Float64.fromBits((UInt64(1) << 63) | UInt64(1)) }
    let bits = x.toBits()
    if (x > Float64(0.0)) {
        Float64.fromBits(bits - UInt64(1))
    } else {
        Float64.fromBits(bits + UInt64(1))
    }
}

@OverflowWrapping
public func float_distance(x: Float32, y: Float32): Int32 {
    if (x.isNaN() || x.isInf() || y.isNaN() || y.isInf()) { return Int32.Max }
    let a = (x.toBits() as Int32).getOrThrow()
    let b = (y.toBits() as Int32).getOrThrow()
    abs(a - b)
}

@OverflowWrapping
public func float_distance(x: Float64, y: Float64): Int64 {
    if (x.isNaN() || x.isInf() || y.isNaN() || y.isInf()) { return Int64.Max }
    let a = (x.toBits() as Int64).getOrThrow()
    let b = (y.toBits() as Int64).getOrThrow()
    abs(a - b)
}

public func ulp(x: Float32): Float32 {
    if (x.isNaN()) { return x }
    if (x.isInf()) { return x }
    if (x == Float32(0.0)) { return Float32.fromBits(UInt32(1)) }
    if ((x.toBits() & UInt32(0x7F800000)) == UInt32(0)) { return Float32.fromBits(UInt32(1)) }
    next_float(x) - x
}

public func ulp(x: Float64): Float64 {
    if (x.isNaN()) { return x }
    if (x.isInf()) { return x }
    if (x == Float64(0.0)) { return Float64.fromBits(UInt64(1)) }
    if ((x.toBits() & UInt64(0x7FF0000000000000)) == UInt64(0)) { return Float64.fromBits(UInt64(1)) }
    next_float(x) - x
}
