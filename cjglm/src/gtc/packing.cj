package glm.gtc
import glm.detail.{ Vec2, Vec4, Qualifier }
import glm.detail.{ clamp, round }

public func packUnorm1x8(v: Float32): UInt8 {
    (round(clamp(v, Float32(0.0), Float32(1.0)) * Float32(255.0)) as UInt8).getOrThrow()
}

public func packUnorm2x8<Q>(v: Vec2<Float32, Q>): UInt16 where Q <: Qualifier {
    let a = (round(clamp(v.x, Float32(0.0), Float32(1.0)) * Float32(255.0)) as UInt16).getOrThrow()
    let b = (round(clamp(v.y, Float32(0.0), Float32(1.0)) * Float32(255.0)) as UInt16).getOrThrow()
    a | (b << 8)
}

public func packUnorm4x8<Q>(v: Vec4<Float32, Q>): UInt32 where Q <: Qualifier {
    let a = (round(clamp(v.x, Float32(0.0), Float32(1.0)) * Float32(255.0)) as UInt32).getOrThrow()
    let b = (round(clamp(v.y, Float32(0.0), Float32(1.0)) * Float32(255.0)) as UInt32).getOrThrow()
    let c = (round(clamp(v.z, Float32(0.0), Float32(1.0)) * Float32(255.0)) as UInt32).getOrThrow()
    let d = (round(clamp(v.w, Float32(0.0), Float32(1.0)) * Float32(255.0)) as UInt32).getOrThrow()
    a | (b << 8) | (c << 16) | (d << 24)
}

public func packUnorm1x16(v: Float32): UInt16 {
    (round(clamp(v, Float32(0.0), Float32(1.0)) * Float32(65535.0)) as UInt16).getOrThrow()
}

public func packUnorm2x16<Q>(v: Vec2<Float32, Q>): UInt32 where Q <: Qualifier {
    let a = (round(clamp(v.x, Float32(0.0), Float32(1.0)) * Float32(65535.0)) as UInt32).getOrThrow()
    let b = (round(clamp(v.y, Float32(0.0), Float32(1.0)) * Float32(65535.0)) as UInt32).getOrThrow()
    a | (b << 16)
}

public func packUnorm4x16<Q>(v: Vec4<Float32, Q>): UInt64 where Q <: Qualifier {
    let a = (round(clamp(v.x, Float32(0.0), Float32(1.0)) * Float32(65535.0)) as UInt64).getOrThrow()
    let b = (round(clamp(v.y, Float32(0.0), Float32(1.0)) * Float32(65535.0)) as UInt64).getOrThrow()
    let c = (round(clamp(v.z, Float32(0.0), Float32(1.0)) * Float32(65535.0)) as UInt64).getOrThrow()
    let d = (round(clamp(v.w, Float32(0.0), Float32(1.0)) * Float32(65535.0)) as UInt64).getOrThrow()
    a | (b << 16) | (c << 32) | (d << 48)
}

public func unpackUnorm1x8(p: UInt8): Float32 { Float32(p) / Float32(255.0) }

public func unpackUnorm2x8<Q>(p: UInt16): Vec2<Float32, Q> where Q <: Qualifier {
    let a = Float32(p & UInt16(0xFF)) / Float32(255.0)
    let b = Float32((p >> 8) & UInt16(0xFF)) / Float32(255.0)
    Vec2(a, b)
}

public func unpackUnorm4x8<Q>(p: UInt32): Vec4<Float32, Q> where Q <: Qualifier {
    let a = Float32(p & UInt32(0xFF)) / Float32(255.0)
    let b = Float32((p >> 8) & UInt32(0xFF)) / Float32(255.0)
    let c = Float32((p >> 16) & UInt32(0xFF)) / Float32(255.0)
    let d = Float32((p >> 24) & UInt32(0xFF)) / Float32(255.0)
    Vec4(a, b, c, d)
}

public func unpackUnorm1x16(p: UInt16): Float32 { Float32(p) / Float32(65535.0) }

public func unpackUnorm2x16<Q>(p: UInt32): Vec2<Float32, Q> where Q <: Qualifier {
    let a = Float32(p & UInt32(0xFFFF)) / Float32(65535.0)
    let b = Float32((p >> 16) & UInt32(0xFFFF)) / Float32(65535.0)
    Vec2(a, b)
}

public func unpackUnorm4x16<Q>(p: UInt64): Vec4<Float32, Q> where Q <: Qualifier {
    let a = Float32(p & UInt64(0xFFFF)) / Float32(65535.0)
    let b = Float32((p >> 16) & UInt64(0xFFFF)) / Float32(65535.0)
    let c = Float32((p >> 32) & UInt64(0xFFFF)) / Float32(65535.0)
    let d = Float32((p >> 48) & UInt64(0xFFFF)) / Float32(65535.0)
    Vec4(a, b, c, d)
}

public func packSnorm1x8(v: Float32): UInt8 {
    (Int8(round(clamp(v, Float32(-1.0), Float32(1.0)) * Float32(127.0))) as UInt8).getOrThrow()
}

public func packSnorm2x8<Q>(v: Vec2<Float32, Q>): UInt16 where Q <: Qualifier {
    let a = UInt16((Int8(round(clamp(v.x, Float32(-1.0), Float32(1.0)) * Float32(127.0))) as UInt8).getOrThrow())
    let b = UInt16((Int8(round(clamp(v.y, Float32(-1.0), Float32(1.0)) * Float32(127.0))) as UInt8).getOrThrow())
    a | (b << 8)
}

public func packSnorm4x8<Q>(v: Vec4<Float32, Q>): UInt32 where Q <: Qualifier {
    let a = UInt32((Int8(round(clamp(v.x, Float32(-1.0), Float32(1.0)) * Float32(127.0))) as UInt8).getOrThrow())
    let b = UInt32((Int8(round(clamp(v.y, Float32(-1.0), Float32(1.0)) * Float32(127.0))) as UInt8).getOrThrow())
    let c = UInt32((Int8(round(clamp(v.z, Float32(-1.0), Float32(1.0)) * Float32(127.0))) as UInt8).getOrThrow())
    let d = UInt32((Int8(round(clamp(v.w, Float32(-1.0), Float32(1.0)) * Float32(127.0))) as UInt8).getOrThrow())
    a | (b << 8) | (c << 16) | (d << 24)
}

public func packSnorm1x16(v: Float32): UInt16 {
    (Int16(round(clamp(v, Float32(-1.0), Float32(1.0)) * Float32(32767.0))) as UInt16).getOrThrow()
}

public func packSnorm2x16<Q>(v: Vec2<Float32, Q>): UInt32 where Q <: Qualifier {
    let a = UInt32((Int16(round(clamp(v.x, Float32(-1.0), Float32(1.0)) * Float32(32767.0))) as UInt16).getOrThrow())
    let b = UInt32((Int16(round(clamp(v.y, Float32(-1.0), Float32(1.0)) * Float32(32767.0))) as UInt16).getOrThrow())
    a | (b << 16)
}

public func packSnorm4x16<Q>(v: Vec4<Float32, Q>): UInt64 where Q <: Qualifier {
    let a = UInt64((Int16(round(clamp(v.x, Float32(-1.0), Float32(1.0)) * Float32(32767.0))) as UInt16).getOrThrow())
    let b = UInt64((Int16(round(clamp(v.y, Float32(-1.0), Float32(1.0)) * Float32(32767.0))) as UInt16).getOrThrow())
    let c = UInt64((Int16(round(clamp(v.z, Float32(-1.0), Float32(1.0)) * Float32(32767.0))) as UInt16).getOrThrow())
    let d = UInt64((Int16(round(clamp(v.w, Float32(-1.0), Float32(1.0)) * Float32(32767.0))) as UInt16).getOrThrow())
    a | (b << 16) | (c << 32) | (d << 48)
}

public func unpackSnorm1x8(p: UInt8): Float32 {
    clamp(Float32((p as Int8).getOrThrow()) / Float32(127.0), Float32(-1.0), Float32(1.0))
}

public func unpackSnorm2x8<Q>(p: UInt16): Vec2<Float32, Q> where Q <: Qualifier {
    let lo = (p & UInt16(0xFF)) as UInt8
    let hi = ((p >> 8) & UInt16(0xFF)) as UInt8
    let a = clamp(Float32((lo.getOrThrow() as Int8).getOrThrow()) / Float32(127.0), Float32(-1.0), Float32(1.0))
    let b = clamp(Float32((hi.getOrThrow() as Int8).getOrThrow()) / Float32(127.0), Float32(-1.0), Float32(1.0))
    Vec2(a, b)
}

public func unpackSnorm4x8<Q>(p: UInt32): Vec4<Float32, Q> where Q <: Qualifier {
    let b0 = (p & UInt32(0xFF)) as UInt8
    let b1 = ((p >> 8) & UInt32(0xFF)) as UInt8
    let b2 = ((p >> 16) & UInt32(0xFF)) as UInt8
    let b3 = ((p >> 24) & UInt32(0xFF)) as UInt8
    let a = clamp(Float32((b0.getOrThrow() as Int8).getOrThrow()) / Float32(127.0), Float32(-1.0), Float32(1.0))
    let b = clamp(Float32((b1.getOrThrow() as Int8).getOrThrow()) / Float32(127.0), Float32(-1.0), Float32(1.0))
    let c = clamp(Float32((b2.getOrThrow() as Int8).getOrThrow()) / Float32(127.0), Float32(-1.0), Float32(1.0))
    let d = clamp(Float32((b3.getOrThrow() as Int8).getOrThrow()) / Float32(127.0), Float32(-1.0), Float32(1.0))
    Vec4(a, b, c, d)
}

public func unpackSnorm1x16(p: UInt16): Float32 {
    clamp(Float32((p as Int16).getOrThrow()) / Float32(32767.0), Float32(-1.0), Float32(1.0))
}

public func unpackSnorm2x16<Q>(p: UInt32): Vec2<Float32, Q> where Q <: Qualifier {
    let lo = (p & UInt32(0xFFFF)) as UInt16
    let hi = ((p >> 16) & UInt32(0xFFFF)) as UInt16
    let a = clamp(Float32((lo.getOrThrow() as Int16).getOrThrow()) / Float32(32767.0), Float32(-1.0), Float32(1.0))
    let b = clamp(Float32((hi.getOrThrow() as Int16).getOrThrow()) / Float32(32767.0), Float32(-1.0), Float32(1.0))
    Vec2(a, b)
}

public func unpackSnorm4x16<Q>(p: UInt64): Vec4<Float32, Q> where Q <: Qualifier {
    let b0 = (p & UInt64(0xFFFF)) as UInt16
    let b1 = ((p >> 16) & UInt64(0xFFFF)) as UInt16
    let b2 = ((p >> 32) & UInt64(0xFFFF)) as UInt16
    let b3 = ((p >> 48) & UInt64(0xFFFF)) as UInt16
    let a = clamp(Float32((b0.getOrThrow() as Int16).getOrThrow()) / Float32(32767.0), Float32(-1.0), Float32(1.0))
    let b = clamp(Float32((b1.getOrThrow() as Int16).getOrThrow()) / Float32(32767.0), Float32(-1.0), Float32(1.0))
    let c = clamp(Float32((b2.getOrThrow() as Int16).getOrThrow()) / Float32(32767.0), Float32(-1.0), Float32(1.0))
    let d = clamp(Float32((b3.getOrThrow() as Int16).getOrThrow()) / Float32(32767.0), Float32(-1.0), Float32(1.0))
    Vec4(a, b, c, d)
}

public func packHalf1x16(v: Float32): UInt16 {
    let bits32 = v.toBits()
    let sign = (bits32 >> 16) & UInt32(0x8000)
    let exp32 = (bits32 >> 23) & UInt32(0xFF)
    let mant32 = bits32 & UInt32(0x7FFFFF)

    var result: UInt32
    if (exp32 == UInt32(255)) {
        result = sign | UInt32(0x7C00) | (mant32 >> 13)
    } else if (exp32 <= UInt32(112)) {
        var m = mant32 | UInt32(0x800000)
        let shift = UInt32(113) - exp32
        m = m + (UInt32(1) << (shift - UInt32(1)))
        if ((m & (UInt32(1) << (UInt32(13) + shift))) != UInt32(0)) {
            m = UInt32(0)
        }
        result = sign | (m >> shift)
    } else {
        var exp16 = exp32 - UInt32(127) + UInt32(15)
        var m = mant32 + UInt32(0x1000) + ((mant32 >> 13) & UInt32(1))
        if ((m & UInt32(0x800000)) != UInt32(0)) {
            m = UInt32(0)
            exp16 += UInt32(1)
        }
        result = sign | (exp16 << 10) | (m >> 13)
    }
    (result as UInt16).getOrThrow()
}

public func packHalf2x16<Q>(v: Vec2<Float32, Q>): UInt32 where Q <: Qualifier {
    let a = UInt32(packHalf1x16(v.x))
    let b = UInt32(packHalf1x16(v.y))
    a | (b << 16)
}

public func packHalf4x16<Q>(v: Vec4<Float32, Q>): UInt64 where Q <: Qualifier {
    let a = UInt64(packHalf1x16(v.x))
    let b = UInt64(packHalf1x16(v.y))
    let c = UInt64(packHalf1x16(v.z))
    let d = UInt64(packHalf1x16(v.w))
    a | (b << 16) | (c << 32) | (d << 48)
}

public func unpackHalf1x16(p: UInt16): Float32 {
    let b = UInt32(p)
    let sign32 = (b & UInt32(0x8000)) << 16
    let exp16 = (b >> 10) & UInt32(0x1F)
    let mant16 = b & UInt32(0x3FF)

    var result: UInt32
    if (exp16 == UInt32(31)) {
        result = sign32 | UInt32(0x7F800000) | (mant16 << 13)
    } else if (exp16 == UInt32(0)) {
        if (mant16 == UInt32(0)) {
            result = sign32
        } else {
            var e = Int64(-1)
            var m = mant16
            while ((m & UInt32(0x400)) == UInt32(0)) {
                m <<= 1
                e -= Int64(1)
            }
            m = (m & UInt32(0x3FF)) << 13
            let exp32 = UInt32(e + Int64(127))
            result = sign32 | (exp32 << 23) | m
        }
    } else {
        let exp32 = exp16 - UInt32(15) + UInt32(127)
        result = sign32 | (exp32 << 23) | (mant16 << 13)
    }
    Float32.fromBits(result)
}

public func unpackHalf2x16<Q>(p: UInt32): Vec2<Float32, Q> where Q <: Qualifier {
    let a = unpackHalf1x16(((p & UInt32(0xFFFF)) as UInt16).getOrThrow())
    let b = unpackHalf1x16((((p >> 16) & UInt32(0xFFFF)) as UInt16).getOrThrow())
    Vec2(a, b)
}

public func unpackHalf4x16<Q>(p: UInt64): Vec4<Float32, Q> where Q <: Qualifier {
    let a = unpackHalf1x16(((p & UInt64(0xFFFF)) as UInt16).getOrThrow())
    let b = unpackHalf1x16((((p >> 16) & UInt64(0xFFFF)) as UInt16).getOrThrow())
    let c = unpackHalf1x16((((p >> 32) & UInt64(0xFFFF)) as UInt16).getOrThrow())
    let d = unpackHalf1x16((((p >> 48) & UInt64(0xFFFF)) as UInt16).getOrThrow())
    Vec4(a, b, c, d)
}

public func packDouble2x32<Q>(v: Vec2<UInt32, Q>): Float64 where Q <: Qualifier {
    Float64.fromBits(UInt64(v.x) | (UInt64(v.y) << 32))
}

public func unpackDouble2x32<Q>(p: Float64): Vec2<UInt32, Q> where Q <: Qualifier {
    let bits = p.toBits()
    Vec2(UInt32(bits), UInt32(bits >> 32))
}
