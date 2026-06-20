package glm.detail

import std.math.{ Number, Integer }
import std.deriving.*

@Derive[Hashable]
public struct Vec2<T, Q> where Q <: Qualifier {
    public var x: T
    public var y: T

    public init(scalar: T) {
        this.x = scalar
        this.y = scalar
    }

    public const init(x: T, y: T) {
        this.x = x
        this.y = y
    }

    public init(v: Vec1<T, Q>) {
        this.x = v.x
        this.y = v.x
    }

    public static func length(): Int64 { 2 }

    public operator func [](i: Int64): T {
        assert(i >= Int64(0) && i < length(), message: "Vec2 index out of bounds")
        return match (i) {
            case 0 => this.x
            case 1 => this.y
            case _ => throw Exception("Vec2 index out of bounds")
        }
    }

    public mut operator func [](i: Int64, value!: T): Unit {
        assert(i >= Int64(0) && i < length(), message: "Vec2 index out of bounds")
        match (i) {
            case 0 => this.x = value
            case 1 => this.y = value
            case _ => throw Exception("Vec2 index out of bounds")
        }
    }

    public func componentAt(i: Int64): T {
        assert(i >= Int64(0) && i < length(), message: "Vec2 index out of bounds")
        return match (i) {
            case 0 => this.x
            case 1 => this.y
            case _ => throw Exception("Vec2 index out of bounds")
        }
    }
}

extend<T, Q> Vec2<T, Q> where T <: Number<T>, Q <: Qualifier {
    @OverflowWrapping
    public operator func +(rhs: Vec2<T, Q>): Vec2<T, Q> { Vec2(this.x + rhs.x, this.y + rhs.y) }
    @OverflowWrapping
    public operator func -(rhs: Vec2<T, Q>): Vec2<T, Q> { Vec2(this.x - rhs.x, this.y - rhs.y) }
    @OverflowWrapping
    public operator func *(rhs: Vec2<T, Q>): Vec2<T, Q> { Vec2(this.x * rhs.x, this.y * rhs.y) }
    @OverflowWrapping
    public operator func /(rhs: Vec2<T, Q>): Vec2<T, Q> { Vec2(this.x / rhs.x, this.y / rhs.y) }

    @OverflowWrapping
    public operator func +(rhs: T): Vec2<T, Q> { Vec2(this.x + rhs, this.y + rhs) }
    @OverflowWrapping
    public operator func -(rhs: T): Vec2<T, Q> { Vec2(this.x - rhs, this.y - rhs) }
    @OverflowWrapping
    public operator func *(rhs: T): Vec2<T, Q> { Vec2(this.x * rhs, this.y * rhs) }
    @OverflowWrapping
    public operator func /(rhs: T): Vec2<T, Q> { Vec2(this.x / rhs, this.y / rhs) }

    public operator func -(): Vec2<T, Q> { Vec2(-this.x, -this.y) }

    public func add(s: T): Vec2<T, Q> { this + s }
    public func sub(s: T): Vec2<T, Q> { this - s }
    public func mul(s: T): Vec2<T, Q> { this * s }
    public func div(s: T): Vec2<T, Q> { this / s }

    @OverflowWrapping
    public operator func +(rhs: Vec1<T, Q>): Vec2<T, Q> { Vec2(this.x + rhs.x, this.y + rhs.x) }
    @OverflowWrapping
    public operator func -(rhs: Vec1<T, Q>): Vec2<T, Q> { Vec2(this.x - rhs.x, this.y - rhs.x) }
    @OverflowWrapping
    public operator func *(rhs: Vec1<T, Q>): Vec2<T, Q> { Vec2(this.x * rhs.x, this.y * rhs.x) }
    @OverflowWrapping
    public operator func /(rhs: Vec1<T, Q>): Vec2<T, Q> { Vec2(this.x / rhs.x, this.y / rhs.x) }
}

extend<T, Q> Vec2<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public operator func &(rhs: Vec2<T, Q>): Vec2<T, Q> { Vec2(this.x & rhs.x, this.y & rhs.y) }
    public operator func |(rhs: Vec2<T, Q>): Vec2<T, Q> { Vec2(this.x | rhs.x, this.y | rhs.y) }
    public operator func ^(rhs: Vec2<T, Q>): Vec2<T, Q> { Vec2(this.x ^ rhs.x, this.y ^ rhs.y) }
    @OverflowWrapping
    public operator func <<(rhs: Vec2<Int64, Q>): Vec2<T, Q> { Vec2(this.x << rhs.x, this.y << rhs.y) }
    public operator func >>(rhs: Vec2<Int64, Q>): Vec2<T, Q> { Vec2(this.x >> rhs.x, this.y >> rhs.y) }

    public func bitwiseNot(): Vec2<T, Q> { Vec2(!this.x, !this.y) }

    @OverflowWrapping
    public operator func %(rhs: Vec2<T, Q>): Vec2<T, Q> { Vec2(this.x % rhs.x, this.y % rhs.y) }
    @OverflowWrapping
    public operator func %(rhs: T): Vec2<T, Q> { Vec2(this.x % rhs, this.y % rhs) }
    public func mod(s: T): Vec2<T, Q> { this % s }
    @OverflowWrapping
    public operator func %(rhs: Vec1<T, Q>): Vec2<T, Q> { Vec2(this.x % rhs.x, this.y % rhs.x) }

    public operator func &(rhs: T): Vec2<T, Q> { Vec2(this.x & rhs, this.y & rhs) }
    public operator func |(rhs: T): Vec2<T, Q> { Vec2(this.x | rhs, this.y | rhs) }
    public operator func ^(rhs: T): Vec2<T, Q> { Vec2(this.x ^ rhs, this.y ^ rhs) }
    @OverflowWrapping
    public operator func <<(shift: Int64): Vec2<T, Q> { Vec2(this.x << shift, this.y << shift) }
    public operator func >>(shift: Int64): Vec2<T, Q> { Vec2(this.x >> shift, this.y >> shift) }

    public operator func &(rhs: Vec1<T, Q>): Vec2<T, Q> { Vec2(this.x & rhs.x, this.y & rhs.x) }
    public operator func |(rhs: Vec1<T, Q>): Vec2<T, Q> { Vec2(this.x | rhs.x, this.y | rhs.x) }
    public operator func ^(rhs: Vec1<T, Q>): Vec2<T, Q> { Vec2(this.x ^ rhs.x, this.y ^ rhs.x) }
    @OverflowWrapping
    public operator func <<(rhs: Vec1<Int64, Q>): Vec2<T, Q> { Vec2(this.x << rhs.x, this.y << rhs.x) }
    public operator func >>(rhs: Vec1<Int64, Q>): Vec2<T, Q> { Vec2(this.x >> rhs.x, this.y >> rhs.x) }

    @OverflowWrapping
    public mut func increment(): Unit {
        this.x = this.x + (-(!(this.x - this.x)))
        this.y = this.y + (-(!(this.y - this.y)))
    }

    @OverflowWrapping
    public mut func decrement(): Unit {
        this.x = this.x - (-(!(this.x - this.x)))
        this.y = this.y - (-(!(this.y - this.y)))
    }
}

extend<T, Q> Vec2<T, Q> where T <: Equatable<T>, Q <: Qualifier {
    public operator func ==(rhs: Vec2<T, Q>): Bool { ComputeEqual<T>.call(this.x, rhs.x) && ComputeEqual<T>.call(this.y, rhs.y) }
    public operator func !=(rhs: Vec2<T, Q>): Bool { !(this == rhs) }
    public func equalExact(other: Vec2<T, Q>): Bool { ComputeEqual<T>.call(this.x, other.x) && ComputeEqual<T>.call(this.y, other.y) }
}

extend<T, Q> Vec2<T, Q> where T <: Number<T> & Equatable<T> & Comparable<T>, Q <: Qualifier {
    public func equalEpsilon(other: Vec2<T, Q>): Bool { ComputeEqualNumeric<T>.callConst(this.x, other.x) && ComputeEqualNumeric<T>.callConst(this.y, other.y) }
}

extend<Q> Vec2<Bool, Q> where Q <: Qualifier {
    public func logicalAnd(other: Vec2<Bool, Q>): Vec2<Bool, Q> { Vec2(this.x && other.x, this.y && other.y) }
    public func logicalOr(other: Vec2<Bool, Q>): Vec2<Bool, Q> { Vec2(this.x || other.x, this.y || other.y) }
}
