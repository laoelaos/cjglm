package glm.detail

import std.math.{ Number, Integer }
import std.deriving.*

@Derive[Hashable]
public struct Vec4<T, Q> where Q <: Qualifier {
    public var x: T
    public var y: T
    public var z: T
    public var w: T

    public init(scalar: T) {
        this.x = scalar
        this.y = scalar
        this.z = scalar
        this.w = scalar
    }

    public const init(x: T, y: T, z: T, w: T) {
        this.x = x
        this.y = y
        this.z = z
        this.w = w
    }

    public init(v: Vec1<T, Q>) {
        this.x = v.x
        this.y = v.x
        this.z = v.x
        this.w = v.x
    }

    public static func length(): Int64 { 4 }

    public operator func [](i: Int64): T {
        assert(i >= Int64(0) && i < length(), message: "Vec4 index out of bounds")
        return match (i) {
            case 0 => this.x
            case 1 => this.y
            case 2 => this.z
            case 3 => this.w
            case _ => throw Exception("Vec4 index out of bounds")
        }
    }

    public mut operator func [](i: Int64, value!: T): Unit {
        assert(i >= Int64(0) && i < length(), message: "Vec4 index out of bounds")
        match (i) {
            case 0 => this.x = value
            case 1 => this.y = value
            case 2 => this.z = value
            case 3 => this.w = value
            case _ => throw Exception("Vec4 index out of bounds")
        }
    }

    public func componentAt(i: Int64): T {
        assert(i >= Int64(0) && i < length(), message: "Vec4 index out of bounds")
        return match (i) {
            case 0 => this.x
            case 1 => this.y
            case 2 => this.z
            case 3 => this.w
            case _ => throw Exception("Vec4 index out of bounds")
        }
    }
}

extend<T, Q> Vec4<T, Q> where T <: Number<T>, Q <: Qualifier {
    @OverflowWrapping
    public operator func +(rhs: Vec4<T, Q>): Vec4<T, Q> { Vec4(this.x + rhs.x, this.y + rhs.y, this.z + rhs.z, this.w + rhs.w) }
    @OverflowWrapping
    public operator func -(rhs: Vec4<T, Q>): Vec4<T, Q> { Vec4(this.x - rhs.x, this.y - rhs.y, this.z - rhs.z, this.w - rhs.w) }
    @OverflowWrapping
    public operator func *(rhs: Vec4<T, Q>): Vec4<T, Q> { Vec4(this.x * rhs.x, this.y * rhs.y, this.z * rhs.z, this.w * rhs.w) }
    @OverflowWrapping
    public operator func /(rhs: Vec4<T, Q>): Vec4<T, Q> { Vec4(this.x / rhs.x, this.y / rhs.y, this.z / rhs.z, this.w / rhs.w) }

    @OverflowWrapping
    public operator func +(rhs: T): Vec4<T, Q> { Vec4(this.x + rhs, this.y + rhs, this.z + rhs, this.w + rhs) }
    @OverflowWrapping
    public operator func -(rhs: T): Vec4<T, Q> { Vec4(this.x - rhs, this.y - rhs, this.z - rhs, this.w - rhs) }
    @OverflowWrapping
    public operator func *(rhs: T): Vec4<T, Q> { Vec4(this.x * rhs, this.y * rhs, this.z * rhs, this.w * rhs) }
    @OverflowWrapping
    public operator func /(rhs: T): Vec4<T, Q> { Vec4(this.x / rhs, this.y / rhs, this.z / rhs, this.w / rhs) }

    public operator func -(): Vec4<T, Q> { Vec4(-this.x, -this.y, -this.z, -this.w) }

    public func add(s: T): Vec4<T, Q> { this + s }
    public func sub(s: T): Vec4<T, Q> { this - s }
    public func mul(s: T): Vec4<T, Q> { this * s }
    public func div(s: T): Vec4<T, Q> { this / s }

    @OverflowWrapping
    public operator func +(rhs: Vec1<T, Q>): Vec4<T, Q> { Vec4(this.x + rhs.x, this.y + rhs.x, this.z + rhs.x, this.w + rhs.x) }
    @OverflowWrapping
    public operator func -(rhs: Vec1<T, Q>): Vec4<T, Q> { Vec4(this.x - rhs.x, this.y - rhs.x, this.z - rhs.x, this.w - rhs.x) }
    @OverflowWrapping
    public operator func *(rhs: Vec1<T, Q>): Vec4<T, Q> { Vec4(this.x * rhs.x, this.y * rhs.x, this.z * rhs.x, this.w * rhs.x) }
    @OverflowWrapping
    public operator func /(rhs: Vec1<T, Q>): Vec4<T, Q> { Vec4(this.x / rhs.x, this.y / rhs.x, this.z / rhs.x, this.w / rhs.x) }
}

extend<T, Q> Vec4<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public operator func &(rhs: Vec4<T, Q>): Vec4<T, Q> { Vec4(this.x & rhs.x, this.y & rhs.y, this.z & rhs.z, this.w & rhs.w) }
    public operator func |(rhs: Vec4<T, Q>): Vec4<T, Q> { Vec4(this.x | rhs.x, this.y | rhs.y, this.z | rhs.z, this.w | rhs.w) }
    public operator func ^(rhs: Vec4<T, Q>): Vec4<T, Q> { Vec4(this.x ^ rhs.x, this.y ^ rhs.y, this.z ^ rhs.z, this.w ^ rhs.w) }
    @OverflowWrapping
    public operator func <<(rhs: Vec4<Int64, Q>): Vec4<T, Q> { Vec4(this.x << rhs.x, this.y << rhs.y, this.z << rhs.z, this.w << rhs.w) }
    public operator func >>(rhs: Vec4<Int64, Q>): Vec4<T, Q> { Vec4(this.x >> rhs.x, this.y >> rhs.y, this.z >> rhs.z, this.w >> rhs.w) }

    public func bitwiseNot(): Vec4<T, Q> { Vec4(!this.x, !this.y, !this.z, !this.w) }

    @OverflowWrapping
    public operator func %(rhs: Vec4<T, Q>): Vec4<T, Q> { Vec4(this.x % rhs.x, this.y % rhs.y, this.z % rhs.z, this.w % rhs.w) }
    @OverflowWrapping
    public operator func %(rhs: T): Vec4<T, Q> { Vec4(this.x % rhs, this.y % rhs, this.z % rhs, this.w % rhs) }
    public func mod(s: T): Vec4<T, Q> { this % s }
    @OverflowWrapping
    public operator func %(rhs: Vec1<T, Q>): Vec4<T, Q> { Vec4(this.x % rhs.x, this.y % rhs.x, this.z % rhs.x, this.w % rhs.x) }

    public operator func &(rhs: T): Vec4<T, Q> { Vec4(this.x & rhs, this.y & rhs, this.z & rhs, this.w & rhs) }
    public operator func |(rhs: T): Vec4<T, Q> { Vec4(this.x | rhs, this.y | rhs, this.z | rhs, this.w | rhs) }
    public operator func ^(rhs: T): Vec4<T, Q> { Vec4(this.x ^ rhs, this.y ^ rhs, this.z ^ rhs, this.w ^ rhs) }
    @OverflowWrapping
    public operator func <<(shift: Int64): Vec4<T, Q> { Vec4(this.x << shift, this.y << shift, this.z << shift, this.w << shift) }
    public operator func >>(shift: Int64): Vec4<T, Q> { Vec4(this.x >> shift, this.y >> shift, this.z >> shift, this.w >> shift) }

    public operator func &(rhs: Vec1<T, Q>): Vec4<T, Q> { Vec4(this.x & rhs.x, this.y & rhs.x, this.z & rhs.x, this.w & rhs.x) }
    public operator func |(rhs: Vec1<T, Q>): Vec4<T, Q> { Vec4(this.x | rhs.x, this.y | rhs.x, this.z | rhs.x, this.w | rhs.x) }
    public operator func ^(rhs: Vec1<T, Q>): Vec4<T, Q> { Vec4(this.x ^ rhs.x, this.y ^ rhs.x, this.z ^ rhs.x, this.w ^ rhs.x) }
    @OverflowWrapping
    public operator func <<(rhs: Vec1<Int64, Q>): Vec4<T, Q> { Vec4(this.x << rhs.x, this.y << rhs.x, this.z << rhs.x, this.w << rhs.x) }
    public operator func >>(rhs: Vec1<Int64, Q>): Vec4<T, Q> { Vec4(this.x >> rhs.x, this.y >> rhs.x, this.z >> rhs.x, this.w >> rhs.x) }

    @OverflowWrapping
    public mut func increment(): Unit {
        this.x = this.x + (-(!(this.x - this.x)))
        this.y = this.y + (-(!(this.y - this.y)))
        this.z = this.z + (-(!(this.z - this.z)))
        this.w = this.w + (-(!(this.w - this.w)))
    }

    @OverflowWrapping
    public mut func decrement(): Unit {
        this.x = this.x - (-(!(this.x - this.x)))
        this.y = this.y - (-(!(this.y - this.y)))
        this.z = this.z - (-(!(this.z - this.z)))
        this.w = this.w - (-(!(this.w - this.w)))
    }
}

extend<T, Q> Vec4<T, Q> where T <: Equatable<T>, Q <: Qualifier {
    public operator func ==(rhs: Vec4<T, Q>): Bool { ComputeEqual<T>.call(this.x, rhs.x) && ComputeEqual<T>.call(this.y, rhs.y) && ComputeEqual<T>.call(this.z, rhs.z) && ComputeEqual<T>.call(this.w, rhs.w) }
    public operator func !=(rhs: Vec4<T, Q>): Bool { !(this == rhs) }
    public func equalExact(other: Vec4<T, Q>): Bool { ComputeEqual<T>.call(this.x, other.x) && ComputeEqual<T>.call(this.y, other.y) && ComputeEqual<T>.call(this.z, other.z) && ComputeEqual<T>.call(this.w, other.w) }
}

extend<T, Q> Vec4<T, Q> where T <: Number<T> & Equatable<T> & Comparable<T>, Q <: Qualifier {
    public func equalEpsilon(other: Vec4<T, Q>): Bool { ComputeEqualNumeric<T>.callConst(this.x, other.x) && ComputeEqualNumeric<T>.callConst(this.y, other.y) && ComputeEqualNumeric<T>.callConst(this.z, other.z) && ComputeEqualNumeric<T>.callConst(this.w, other.w) }
}

extend<Q> Vec4<Bool, Q> where Q <: Qualifier {
    public func logicalAnd(other: Vec4<Bool, Q>): Vec4<Bool, Q> { Vec4(this.x && other.x, this.y && other.y, this.z && other.z, this.w && other.w) }
    public func logicalOr(other: Vec4<Bool, Q>): Vec4<Bool, Q> { Vec4(this.x || other.x, this.y || other.y, this.z || other.z, this.w || other.w) }
}

extend<T, Q> Vec4<T, Q> where T <: Number<T>, Q <: Qualifier {
    @OverflowWrapping
    public operator func *(m: Mat2x4<T, Q>): Vec2<T, Q> {
        Vec2(
            this.x * m.c0.x + this.y * m.c0.y + this.z * m.c0.z + this.w * m.c0.w,
            this.x * m.c1.x + this.y * m.c1.y + this.z * m.c1.z + this.w * m.c1.w)
    }

    @OverflowWrapping
    public operator func *(m: Mat3x4<T, Q>): Vec3<T, Q> {
        Vec3(
            this.x * m.c0.x + this.y * m.c0.y + this.z * m.c0.z + this.w * m.c0.w,
            this.x * m.c1.x + this.y * m.c1.y + this.z * m.c1.z + this.w * m.c1.w,
            this.x * m.c2.x + this.y * m.c2.y + this.z * m.c2.z + this.w * m.c2.w)
    }

    @OverflowWrapping
    public operator func *(m: Mat4x4<T, Q>): Vec4<T, Q> {
        Vec4(
            this.x * m.c0.x + this.y * m.c0.y + this.z * m.c0.z + this.w * m.c0.w,
            this.x * m.c1.x + this.y * m.c1.y + this.z * m.c1.z + this.w * m.c1.w,
            this.x * m.c2.x + this.y * m.c2.y + this.z * m.c2.z + this.w * m.c2.w,
            this.x * m.c3.x + this.y * m.c3.y + this.z * m.c3.z + this.w * m.c3.w)
    }
}
