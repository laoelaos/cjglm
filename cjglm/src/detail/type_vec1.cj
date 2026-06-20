package glm.detail

import std.math.{ Number, Integer }
import std.deriving.*

@Derive[Hashable]
public struct Vec1<T, Q> where Q <: Qualifier {
    public var x: T

    public const init(x: T) {
        this.x = x
    }

    public static func length(): Int64 { 1 }

    public operator func [](i: Int64): T {
        assert(i >= Int64(0) && i < length(), message: "Vec1 index out of bounds")
        return match (i) {
            case 0 => this.x
            case _ => throw Exception("Vec1 index out of bounds")
        }
    }

    public mut operator func [](i: Int64, value!: T): Unit {
        assert(i >= Int64(0) && i < length(), message: "Vec1 index out of bounds")
        match (i) {
            case 0 => this.x = value
            case _ => throw Exception("Vec1 index out of bounds")
        }
    }

    public func componentAt(i: Int64): T {
        assert(i >= Int64(0) && i < length(), message: "Vec1 index out of bounds")
        return match (i) {
            case 0 => this.x
            case _ => throw Exception("Vec1 index out of bounds")
        }
    }
}

extend<T, Q> Vec1<T, Q> where T <: Number<T>, Q <: Qualifier {
    @OverflowWrapping
    public operator func +(rhs: Vec1<T, Q>): Vec1<T, Q> { Vec1(this.x + rhs.x) }
    @OverflowWrapping
    public operator func -(rhs: Vec1<T, Q>): Vec1<T, Q> { Vec1(this.x - rhs.x) }
    @OverflowWrapping
    public operator func *(rhs: Vec1<T, Q>): Vec1<T, Q> { Vec1(this.x * rhs.x) }
    @OverflowWrapping
    public operator func /(rhs: Vec1<T, Q>): Vec1<T, Q> { Vec1(this.x / rhs.x) }

    @OverflowWrapping
    public operator func +(rhs: T): Vec1<T, Q> { Vec1(this.x + rhs) }
    @OverflowWrapping
    public operator func -(rhs: T): Vec1<T, Q> { Vec1(this.x - rhs) }
    @OverflowWrapping
    public operator func *(rhs: T): Vec1<T, Q> { Vec1(this.x * rhs) }
    @OverflowWrapping
    public operator func /(rhs: T): Vec1<T, Q> { Vec1(this.x / rhs) }

    public operator func -(): Vec1<T, Q> { Vec1(-this.x) }

    public func add(s: T): Vec1<T, Q> { this + s }
    public func sub(s: T): Vec1<T, Q> { this - s }
    public func mul(s: T): Vec1<T, Q> { this * s }
    public func div(s: T): Vec1<T, Q> { this / s }

    @OverflowWrapping
    public operator func +(rhs: Vec2<T, Q>): Vec2<T, Q> { Vec2(this.x + rhs.x, this.x + rhs.y) }
    @OverflowWrapping
    public operator func -(rhs: Vec2<T, Q>): Vec2<T, Q> { Vec2(this.x - rhs.x, this.x - rhs.y) }
    @OverflowWrapping
    public operator func *(rhs: Vec2<T, Q>): Vec2<T, Q> { Vec2(this.x * rhs.x, this.x * rhs.y) }
    @OverflowWrapping
    public operator func /(rhs: Vec2<T, Q>): Vec2<T, Q> { Vec2(this.x / rhs.x, this.x / rhs.y) }

    @OverflowWrapping
    public operator func +(rhs: Vec3<T, Q>): Vec3<T, Q> { Vec3(this.x + rhs.x, this.x + rhs.y, this.x + rhs.z) }
    @OverflowWrapping
    public operator func -(rhs: Vec3<T, Q>): Vec3<T, Q> { Vec3(this.x - rhs.x, this.x - rhs.y, this.x - rhs.z) }
    @OverflowWrapping
    public operator func *(rhs: Vec3<T, Q>): Vec3<T, Q> { Vec3(this.x * rhs.x, this.x * rhs.y, this.x * rhs.z) }
    @OverflowWrapping
    public operator func /(rhs: Vec3<T, Q>): Vec3<T, Q> { Vec3(this.x / rhs.x, this.x / rhs.y, this.x / rhs.z) }

    @OverflowWrapping
    public operator func +(rhs: Vec4<T, Q>): Vec4<T, Q> { Vec4(this.x + rhs.x, this.x + rhs.y, this.x + rhs.z, this.x + rhs.w) }
    @OverflowWrapping
    public operator func -(rhs: Vec4<T, Q>): Vec4<T, Q> { Vec4(this.x - rhs.x, this.x - rhs.y, this.x - rhs.z, this.x - rhs.w) }
    @OverflowWrapping
    public operator func *(rhs: Vec4<T, Q>): Vec4<T, Q> { Vec4(this.x * rhs.x, this.x * rhs.y, this.x * rhs.z, this.x * rhs.w) }
    @OverflowWrapping
    public operator func /(rhs: Vec4<T, Q>): Vec4<T, Q> { Vec4(this.x / rhs.x, this.x / rhs.y, this.x / rhs.z, this.x / rhs.w) }
}

extend<T, Q> Vec1<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public operator func &(rhs: Vec1<T, Q>): Vec1<T, Q> { Vec1(this.x & rhs.x) }
    public operator func |(rhs: Vec1<T, Q>): Vec1<T, Q> { Vec1(this.x | rhs.x) }
    public operator func ^(rhs: Vec1<T, Q>): Vec1<T, Q> { Vec1(this.x ^ rhs.x) }
    @OverflowWrapping
    public operator func <<(rhs: Vec1<Int64, Q>): Vec1<T, Q> { Vec1(this.x << rhs.x) }
    public operator func >>(rhs: Vec1<Int64, Q>): Vec1<T, Q> { Vec1(this.x >> rhs.x) }

    public func bitwiseNot(): Vec1<T, Q> { Vec1(!this.x) }

    @OverflowWrapping
    public operator func %(rhs: Vec1<T, Q>): Vec1<T, Q> { Vec1(this.x % rhs.x) }
    @OverflowWrapping
    public operator func %(rhs: T): Vec1<T, Q> { Vec1(this.x % rhs) }
    public func mod(s: T): Vec1<T, Q> { this % s }
    @OverflowWrapping
    public operator func %(rhs: Vec2<T, Q>): Vec2<T, Q> { Vec2(this.x % rhs.x, this.x % rhs.y) }
    @OverflowWrapping
    public operator func %(rhs: Vec3<T, Q>): Vec3<T, Q> { Vec3(this.x % rhs.x, this.x % rhs.y, this.x % rhs.z) }
    @OverflowWrapping
    public operator func %(rhs: Vec4<T, Q>): Vec4<T, Q> { Vec4(this.x % rhs.x, this.x % rhs.y, this.x % rhs.z, this.x % rhs.w) }

    public operator func &(rhs: T): Vec1<T, Q> { Vec1(this.x & rhs) }
    public operator func |(rhs: T): Vec1<T, Q> { Vec1(this.x | rhs) }
    public operator func ^(rhs: T): Vec1<T, Q> { Vec1(this.x ^ rhs) }
    @OverflowWrapping
    public operator func <<(shift: Int64): Vec1<T, Q> { Vec1(this.x << shift) }
    public operator func >>(shift: Int64): Vec1<T, Q> { Vec1(this.x >> shift) }

    public operator func &(rhs: Vec2<T, Q>): Vec2<T, Q> { Vec2(this.x & rhs.x, this.x & rhs.y) }
    public operator func |(rhs: Vec2<T, Q>): Vec2<T, Q> { Vec2(this.x | rhs.x, this.x | rhs.y) }
    public operator func ^(rhs: Vec2<T, Q>): Vec2<T, Q> { Vec2(this.x ^ rhs.x, this.x ^ rhs.y) }
    @OverflowWrapping
    public operator func <<(rhs: Vec2<Int64, Q>): Vec2<T, Q> { Vec2(this.x << rhs.x, this.x << rhs.y) }
    public operator func >>(rhs: Vec2<Int64, Q>): Vec2<T, Q> { Vec2(this.x >> rhs.x, this.x >> rhs.y) }

    public operator func &(rhs: Vec3<T, Q>): Vec3<T, Q> { Vec3(this.x & rhs.x, this.x & rhs.y, this.x & rhs.z) }
    public operator func |(rhs: Vec3<T, Q>): Vec3<T, Q> { Vec3(this.x | rhs.x, this.x | rhs.y, this.x | rhs.z) }
    public operator func ^(rhs: Vec3<T, Q>): Vec3<T, Q> { Vec3(this.x ^ rhs.x, this.x ^ rhs.y, this.x ^ rhs.z) }
    @OverflowWrapping
    public operator func <<(rhs: Vec3<Int64, Q>): Vec3<T, Q> { Vec3(this.x << rhs.x, this.x << rhs.y, this.x << rhs.z) }
    public operator func >>(rhs: Vec3<Int64, Q>): Vec3<T, Q> { Vec3(this.x >> rhs.x, this.x >> rhs.y, this.x >> rhs.z) }

    public operator func &(rhs: Vec4<T, Q>): Vec4<T, Q> { Vec4(this.x & rhs.x, this.x & rhs.y, this.x & rhs.z, this.x & rhs.w) }
    public operator func |(rhs: Vec4<T, Q>): Vec4<T, Q> { Vec4(this.x | rhs.x, this.x | rhs.y, this.x | rhs.z, this.x | rhs.w) }
    public operator func ^(rhs: Vec4<T, Q>): Vec4<T, Q> { Vec4(this.x ^ rhs.x, this.x ^ rhs.y, this.x ^ rhs.z, this.x ^ rhs.w) }
    @OverflowWrapping
    public operator func <<(rhs: Vec4<Int64, Q>): Vec4<T, Q> { Vec4(this.x << rhs.x, this.x << rhs.y, this.x << rhs.z, this.x << rhs.w) }
    public operator func >>(rhs: Vec4<Int64, Q>): Vec4<T, Q> { Vec4(this.x >> rhs.x, this.x >> rhs.y, this.x >> rhs.z, this.x >> rhs.w) }

    @OverflowWrapping
    public mut func increment(): Unit {
        this.x = this.x + (-(!(this.x - this.x)))
    }

    @OverflowWrapping
    public mut func decrement(): Unit {
        this.x = this.x - (-(!(this.x - this.x)))
    }
}

extend<T, Q> Vec1<T, Q> where T <: Equatable<T>, Q <: Qualifier {
    public operator func ==(rhs: Vec1<T, Q>): Bool { ComputeEqual<T>.call(this.x, rhs.x) }
    public operator func !=(rhs: Vec1<T, Q>): Bool { !(this == rhs) }
    public func equalExact(other: Vec1<T, Q>): Bool { ComputeEqual<T>.call(this.x, other.x) }
}

extend<T, Q> Vec1<T, Q> where T <: Number<T> & Equatable<T> & Comparable<T>, Q <: Qualifier {
    public func equalEpsilon(other: Vec1<T, Q>): Bool { ComputeEqualNumeric<T>.callConst(this.x, other.x) }
}

extend<Q> Vec1<Bool, Q> where Q <: Qualifier {
    public func logicalAnd(other: Vec1<Bool, Q>): Vec1<Bool, Q> { Vec1(this.x && other.x) }
    public func logicalOr(other: Vec1<Bool, Q>): Vec1<Bool, Q> { Vec1(this.x || other.x) }
}
