package glm.detail

import std.math.{ Number, Integer }
import std.deriving.*

@Derive[Hashable]
public struct Vec3<T, Q> where Q <: Qualifier {
    public var x: T
    public var y: T
    public var z: T

    public init(scalar: T) {
        this.x = scalar
        this.y = scalar
        this.z = scalar
    }

    public const init(x: T, y: T, z: T) {
        this.x = x
        this.y = y
        this.z = z
    }

    public init(v: Vec1<T, Q>) {
        this.x = v.x
        this.y = v.x
        this.z = v.x
    }

    public static func length(): Int64 { 3 }

    public operator func [](i: Int64): T {
        assert(i >= Int64(0) && i < length(), message: "Vec3 index out of bounds")
        return match (i) {
            case 0 => this.x
            case 1 => this.y
            case 2 => this.z
            case _ => throw Exception("Vec3 index out of bounds")
        }
    }

    public mut operator func [](i: Int64, value!: T): Unit {
        assert(i >= Int64(0) && i < length(), message: "Vec3 index out of bounds")
        match (i) {
            case 0 => this.x = value
            case 1 => this.y = value
            case 2 => this.z = value
            case _ => throw Exception("Vec3 index out of bounds")
        }
    }

    public func componentAt(i: Int64): T {
        assert(i >= Int64(0) && i < length(), message: "Vec3 index out of bounds")
        return match (i) {
            case 0 => this.x
            case 1 => this.y
            case 2 => this.z
            case _ => throw Exception("Vec3 index out of bounds")
        }
    }
}

extend<T, Q> Vec3<T, Q> where T <: Number<T>, Q <: Qualifier {
    @OverflowWrapping
    public operator func +(rhs: Vec3<T, Q>): Vec3<T, Q> { Vec3(this.x + rhs.x, this.y + rhs.y, this.z + rhs.z) }
    @OverflowWrapping
    public operator func -(rhs: Vec3<T, Q>): Vec3<T, Q> { Vec3(this.x - rhs.x, this.y - rhs.y, this.z - rhs.z) }
    @OverflowWrapping
    public operator func *(rhs: Vec3<T, Q>): Vec3<T, Q> { Vec3(this.x * rhs.x, this.y * rhs.y, this.z * rhs.z) }
    @OverflowWrapping
    public operator func /(rhs: Vec3<T, Q>): Vec3<T, Q> { Vec3(this.x / rhs.x, this.y / rhs.y, this.z / rhs.z) }

    @OverflowWrapping
    public operator func +(rhs: T): Vec3<T, Q> { Vec3(this.x + rhs, this.y + rhs, this.z + rhs) }
    @OverflowWrapping
    public operator func -(rhs: T): Vec3<T, Q> { Vec3(this.x - rhs, this.y - rhs, this.z - rhs) }
    @OverflowWrapping
    public operator func *(rhs: T): Vec3<T, Q> { Vec3(this.x * rhs, this.y * rhs, this.z * rhs) }
    @OverflowWrapping
    public operator func /(rhs: T): Vec3<T, Q> { Vec3(this.x / rhs, this.y / rhs, this.z / rhs) }

    public operator func -(): Vec3<T, Q> { Vec3(-this.x, -this.y, -this.z) }

    public func add(s: T): Vec3<T, Q> { this + s }
    public func sub(s: T): Vec3<T, Q> { this - s }
    public func mul(s: T): Vec3<T, Q> { this * s }
    public func div(s: T): Vec3<T, Q> { this / s }

    @OverflowWrapping
    public operator func +(rhs: Vec1<T, Q>): Vec3<T, Q> { Vec3(this.x + rhs.x, this.y + rhs.x, this.z + rhs.x) }
    @OverflowWrapping
    public operator func -(rhs: Vec1<T, Q>): Vec3<T, Q> { Vec3(this.x - rhs.x, this.y - rhs.x, this.z - rhs.x) }
    @OverflowWrapping
    public operator func *(rhs: Vec1<T, Q>): Vec3<T, Q> { Vec3(this.x * rhs.x, this.y * rhs.x, this.z * rhs.x) }
    @OverflowWrapping
    public operator func /(rhs: Vec1<T, Q>): Vec3<T, Q> { Vec3(this.x / rhs.x, this.y / rhs.x, this.z / rhs.x) }
}

extend<T, Q> Vec3<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public operator func &(rhs: Vec3<T, Q>): Vec3<T, Q> { Vec3(this.x & rhs.x, this.y & rhs.y, this.z & rhs.z) }
    public operator func |(rhs: Vec3<T, Q>): Vec3<T, Q> { Vec3(this.x | rhs.x, this.y | rhs.y, this.z | rhs.z) }
    public operator func ^(rhs: Vec3<T, Q>): Vec3<T, Q> { Vec3(this.x ^ rhs.x, this.y ^ rhs.y, this.z ^ rhs.z) }
    @OverflowWrapping
    public operator func <<(rhs: Vec3<Int64, Q>): Vec3<T, Q> { Vec3(this.x << rhs.x, this.y << rhs.y, this.z << rhs.z) }
    public operator func >>(rhs: Vec3<Int64, Q>): Vec3<T, Q> { Vec3(this.x >> rhs.x, this.y >> rhs.y, this.z >> rhs.z) }

    public func bitwiseNot(): Vec3<T, Q> { Vec3(!this.x, !this.y, !this.z) }

    @OverflowWrapping
    public operator func %(rhs: Vec3<T, Q>): Vec3<T, Q> { Vec3(this.x % rhs.x, this.y % rhs.y, this.z % rhs.z) }
    @OverflowWrapping
    public operator func %(rhs: T): Vec3<T, Q> { Vec3(this.x % rhs, this.y % rhs, this.z % rhs) }
    public func mod(s: T): Vec3<T, Q> { this % s }
    @OverflowWrapping
    public operator func %(rhs: Vec1<T, Q>): Vec3<T, Q> { Vec3(this.x % rhs.x, this.y % rhs.x, this.z % rhs.x) }

    public operator func &(rhs: T): Vec3<T, Q> { Vec3(this.x & rhs, this.y & rhs, this.z & rhs) }
    public operator func |(rhs: T): Vec3<T, Q> { Vec3(this.x | rhs, this.y | rhs, this.z | rhs) }
    public operator func ^(rhs: T): Vec3<T, Q> { Vec3(this.x ^ rhs, this.y ^ rhs, this.z ^ rhs) }
    @OverflowWrapping
    public operator func <<(shift: Int64): Vec3<T, Q> { Vec3(this.x << shift, this.y << shift, this.z << shift) }
    public operator func >>(shift: Int64): Vec3<T, Q> { Vec3(this.x >> shift, this.y >> shift, this.z >> shift) }

    public operator func &(rhs: Vec1<T, Q>): Vec3<T, Q> { Vec3(this.x & rhs.x, this.y & rhs.x, this.z & rhs.x) }
    public operator func |(rhs: Vec1<T, Q>): Vec3<T, Q> { Vec3(this.x | rhs.x, this.y | rhs.x, this.z | rhs.x) }
    public operator func ^(rhs: Vec1<T, Q>): Vec3<T, Q> { Vec3(this.x ^ rhs.x, this.y ^ rhs.x, this.z ^ rhs.x) }
    @OverflowWrapping
    public operator func <<(rhs: Vec1<Int64, Q>): Vec3<T, Q> { Vec3(this.x << rhs.x, this.y << rhs.x, this.z << rhs.x) }
    public operator func >>(rhs: Vec1<Int64, Q>): Vec3<T, Q> { Vec3(this.x >> rhs.x, this.y >> rhs.x, this.z >> rhs.x) }

    @OverflowWrapping
    public mut func increment(): Unit {
        this.x = this.x + (-(!(this.x - this.x)))
        this.y = this.y + (-(!(this.y - this.y)))
        this.z = this.z + (-(!(this.z - this.z)))
    }

    @OverflowWrapping
    public mut func decrement(): Unit {
        this.x = this.x - (-(!(this.x - this.x)))
        this.y = this.y - (-(!(this.y - this.y)))
        this.z = this.z - (-(!(this.z - this.z)))
    }
}

extend<T, Q> Vec3<T, Q> where T <: Equatable<T>, Q <: Qualifier {
    public operator func ==(rhs: Vec3<T, Q>): Bool { ComputeEqual<T>.call(this.x, rhs.x) && ComputeEqual<T>.call(this.y, rhs.y) && ComputeEqual<T>.call(this.z, rhs.z) }
    public operator func !=(rhs: Vec3<T, Q>): Bool { !(this == rhs) }
    public func equalExact(other: Vec3<T, Q>): Bool { ComputeEqual<T>.call(this.x, other.x) && ComputeEqual<T>.call(this.y, other.y) && ComputeEqual<T>.call(this.z, other.z) }
}

extend<T, Q> Vec3<T, Q> where T <: Number<T> & Equatable<T> & Comparable<T>, Q <: Qualifier {
    public func equalEpsilon(other: Vec3<T, Q>): Bool { ComputeEqualNumeric<T>.callConst(this.x, other.x) && ComputeEqualNumeric<T>.callConst(this.y, other.y) && ComputeEqualNumeric<T>.callConst(this.z, other.z) }
}

extend<Q> Vec3<Bool, Q> where Q <: Qualifier {
    public func logicalAnd(other: Vec3<Bool, Q>): Vec3<Bool, Q> { Vec3(this.x && other.x, this.y && other.y, this.z && other.z) }
    public func logicalOr(other: Vec3<Bool, Q>): Vec3<Bool, Q> { Vec3(this.x || other.x, this.y || other.y, this.z || other.z) }
}
