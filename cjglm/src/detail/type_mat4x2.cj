package glm.detail

import std.math.{ Number, Integer }
import std.deriving.*

@Derive[Hashable]
public struct Mat4x2<T, Q> where Q <: Qualifier {
    public var c0: Vec2<T, Q>
    public var c1: Vec2<T, Q>
    public var c2: Vec2<T, Q>
    public var c3: Vec2<T, Q>

    public const init(a00: T, a01: T, a10: T, a11: T, a20: T, a21: T, a30: T, a31: T) {
        this.c0 = Vec2(a00, a01)
        this.c1 = Vec2(a10, a11)
        this.c2 = Vec2(a20, a21)
        this.c3 = Vec2(a30, a31)
    }

    public const init(c0: Vec2<T, Q>, c1: Vec2<T, Q>, c2: Vec2<T, Q>, c3: Vec2<T, Q>) {
        this.c0 = c0
        this.c1 = c1
        this.c2 = c2
        this.c3 = c3
    }

    public init(scalar: T) {
        this.c0 = Vec2(scalar, scalar)
        this.c1 = Vec2(scalar, scalar)
        this.c2 = Vec2(scalar, scalar)
        this.c3 = Vec2(scalar, scalar)
    }

    public static func length(): Int64 { 4 }

    public operator func [](i: Int64): Vec2<T, Q> {
        assert(i >= Int64(0) && i < length(), message: "Mat4x2 index out of bounds")
        return match (i) {
            case 0 => this.c0
            case 1 => this.c1
            case 2 => this.c2
            case 3 => this.c3
            case _ => throw Exception("Mat4x2 index out of bounds")
        }
    }

    public mut operator func [](i: Int64, value!: Vec2<T, Q>): Unit {
        assert(i >= Int64(0) && i < length(), message: "Mat4x2 index out of bounds")
        match (i) {
            case 0 => this.c0 = value
            case 1 => this.c1 = value
            case 2 => this.c2 = value
            case 3 => this.c3 = value
            case _ => throw Exception("Mat4x2 index out of bounds")
        }
    }

    public func col(i: Int64): Vec2<T, Q> { this[i] }
}

extend<T, Q> Mat4x2<T, Q> where T <: Number<T>, Q <: Qualifier {
    public operator func -(): Mat4x2<T, Q> {
        Mat4x2(-this.c0.x, -this.c0.y, -this.c1.x, -this.c1.y, -this.c2.x, -this.c2.y, -this.c3.x, -this.c3.y)
    }

    @OverflowWrapping
    public operator func +(rhs: T): Mat4x2<T, Q> {
        Mat4x2(this.c0.x + rhs, this.c0.y + rhs, this.c1.x + rhs, this.c1.y + rhs, this.c2.x + rhs, this.c2.y + rhs, this.c3.x + rhs, this.c3.y + rhs)
    }

    @OverflowWrapping
    public operator func -(rhs: T): Mat4x2<T, Q> {
        Mat4x2(this.c0.x - rhs, this.c0.y - rhs, this.c1.x - rhs, this.c1.y - rhs, this.c2.x - rhs, this.c2.y - rhs, this.c3.x - rhs, this.c3.y - rhs)
    }

    @OverflowWrapping
    public operator func *(rhs: T): Mat4x2<T, Q> {
        Mat4x2(this.c0.x * rhs, this.c0.y * rhs, this.c1.x * rhs, this.c1.y * rhs, this.c2.x * rhs, this.c2.y * rhs, this.c3.x * rhs, this.c3.y * rhs)
    }

    @OverflowWrapping
    public operator func /(rhs: T): Mat4x2<T, Q> {
        Mat4x2(this.c0.x / rhs, this.c0.y / rhs, this.c1.x / rhs, this.c1.y / rhs, this.c2.x / rhs, this.c2.y / rhs, this.c3.x / rhs, this.c3.y / rhs)
    }

    @OverflowWrapping
    public operator func +(rhs: Mat4x2<T, Q>): Mat4x2<T, Q> {
        Mat4x2(this.c0.x + rhs.c0.x, this.c0.y + rhs.c0.y, this.c1.x + rhs.c1.x, this.c1.y + rhs.c1.y, this.c2.x + rhs.c2.x, this.c2.y + rhs.c2.y, this.c3.x + rhs.c3.x, this.c3.y + rhs.c3.y)
    }

    @OverflowWrapping
    public operator func -(rhs: Mat4x2<T, Q>): Mat4x2<T, Q> {
        Mat4x2(this.c0.x - rhs.c0.x, this.c0.y - rhs.c0.y, this.c1.x - rhs.c1.x, this.c1.y - rhs.c1.y, this.c2.x - rhs.c2.x, this.c2.y - rhs.c2.y, this.c3.x - rhs.c3.x, this.c3.y - rhs.c3.y)
    }

    @OverflowWrapping
    public operator func *(rhs: Mat2x4<T, Q>): Mat2x2<T, Q> {
        Mat2x2<T, Q>(
            Vec2<T, Q>(this.c0.x * rhs.c0.x + this.c1.x * rhs.c0.y + this.c2.x * rhs.c0.z + this.c3.x * rhs.c0.w, this.c0.y * rhs.c0.x + this.c1.y * rhs.c0.y + this.c2.y * rhs.c0.z + this.c3.y * rhs.c0.w),
            Vec2<T, Q>(this.c0.x * rhs.c1.x + this.c1.x * rhs.c1.y + this.c2.x * rhs.c1.z + this.c3.x * rhs.c1.w, this.c0.y * rhs.c1.x + this.c1.y * rhs.c1.y + this.c2.y * rhs.c1.z + this.c3.y * rhs.c1.w)
        )
    }

    @OverflowWrapping
    public operator func *(rhs: Mat3x4<T, Q>): Mat3x2<T, Q> {
        Mat3x2<T, Q>(
            Vec2<T, Q>(this.c0.x * rhs.c0.x + this.c1.x * rhs.c0.y + this.c2.x * rhs.c0.z + this.c3.x * rhs.c0.w, this.c0.y * rhs.c0.x + this.c1.y * rhs.c0.y + this.c2.y * rhs.c0.z + this.c3.y * rhs.c0.w),
            Vec2<T, Q>(this.c0.x * rhs.c1.x + this.c1.x * rhs.c1.y + this.c2.x * rhs.c1.z + this.c3.x * rhs.c1.w, this.c0.y * rhs.c1.x + this.c1.y * rhs.c1.y + this.c2.y * rhs.c1.z + this.c3.y * rhs.c1.w),
            Vec2<T, Q>(this.c0.x * rhs.c2.x + this.c1.x * rhs.c2.y + this.c2.x * rhs.c2.z + this.c3.x * rhs.c2.w, this.c0.y * rhs.c2.x + this.c1.y * rhs.c2.y + this.c2.y * rhs.c2.z + this.c3.y * rhs.c2.w)
        )
    }

    @OverflowWrapping
    public operator func *(rhs: Mat4x4<T, Q>): Mat4x2<T, Q> {
        Mat4x2<T, Q>(
            Vec2<T, Q>(this.c0.x * rhs.c0.x + this.c1.x * rhs.c0.y + this.c2.x * rhs.c0.z + this.c3.x * rhs.c0.w, this.c0.y * rhs.c0.x + this.c1.y * rhs.c0.y + this.c2.y * rhs.c0.z + this.c3.y * rhs.c0.w),
            Vec2<T, Q>(this.c0.x * rhs.c1.x + this.c1.x * rhs.c1.y + this.c2.x * rhs.c1.z + this.c3.x * rhs.c1.w, this.c0.y * rhs.c1.x + this.c1.y * rhs.c1.y + this.c2.y * rhs.c1.z + this.c3.y * rhs.c1.w),
            Vec2<T, Q>(this.c0.x * rhs.c2.x + this.c1.x * rhs.c2.y + this.c2.x * rhs.c2.z + this.c3.x * rhs.c2.w, this.c0.y * rhs.c2.x + this.c1.y * rhs.c2.y + this.c2.y * rhs.c2.z + this.c3.y * rhs.c2.w),
            Vec2<T, Q>(this.c0.x * rhs.c3.x + this.c1.x * rhs.c3.y + this.c2.x * rhs.c3.z + this.c3.x * rhs.c3.w, this.c0.y * rhs.c3.x + this.c1.y * rhs.c3.y + this.c2.y * rhs.c3.z + this.c3.y * rhs.c3.w)
        )
    }

    @OverflowWrapping
    public operator func *(v: Vec4<T, Q>): Vec2<T, Q> {
        Vec2<T, Q>(this.c0.x * v.x + this.c1.x * v.y + this.c2.x * v.z + this.c3.x * v.w, this.c0.y * v.x + this.c1.y * v.y + this.c2.y * v.z + this.c3.y * v.w)
    }

    public static func diagonal(scalar: T): Mat4x2<T, Q> {
        let zero = scalar - scalar
        Mat4x2(Vec2<T, Q>(scalar, zero), Vec2<T, Q>(zero, scalar), Vec2<T, Q>(zero, zero), Vec2<T, Q>(zero, zero))
    }

    public static func identity(one: T): Mat4x2<T, Q> { diagonal(one) }
}

extend<T, Q> Mat4x2<T, Q> where Q <: Qualifier {
    public static func fromParts<U>(conv: (U) -> T, a00: U, a01: U, a10: U, a11: U, a20: U, a21: U, a30: U, a31: U): Mat4x2<T, Q> {
        Mat4x2(Vec2<T, Q>(conv(a00), conv(a01)), Vec2<T, Q>(conv(a10), conv(a11)), Vec2<T, Q>(conv(a20), conv(a21)), Vec2<T, Q>(conv(a30), conv(a31)))
    }

    public static func fromColumns<U, P>(conv: (U) -> T, c0: Vec2<U, P>, c1: Vec2<U, P>, c2: Vec2<U, P>, c3: Vec2<U, P>): Mat4x2<T, Q>
      where P <: Qualifier {
        Mat4x2(Vec2<T, Q>(conv(c0.x), conv(c0.y)), Vec2<T, Q>(conv(c1.x), conv(c1.y)), Vec2<T, Q>(conv(c2.x), conv(c2.y)), Vec2<T, Q>(conv(c3.x), conv(c3.y)))
    }

    public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x2<U, P>): Mat4x2<T, Q>
      where P <: Qualifier {
        Mat4x2(Vec2<T, Q>(conv(m.c0.x), conv(m.c0.y)), Vec2<T, Q>(conv(m.c1.x), conv(m.c1.y)), Vec2<T, Q>(conv(m.c2.x), conv(m.c2.y)), Vec2<T, Q>(conv(m.c3.x), conv(m.c3.y)))
    }
}

extend<T, Q> Mat4x2<T, Q>
  where T <: Number<T>, Q <: Qualifier {

    public static func fromMat<SrcQ>(m: Mat2x2<T, SrcQ>, one: T): Mat4x2<T, Q>
      where SrcQ <: Qualifier {
        let zero = m.c0.x - m.c0.x
        Mat4x2(Vec2<T, Q>(m.c0.x, m.c0.y), Vec2<T, Q>(m.c1.x, m.c1.y), Vec2<T, Q>(zero, zero), Vec2<T, Q>(zero, zero))
    }

    public static func fromMat<SrcQ>(m: Mat2x3<T, SrcQ>, one: T): Mat4x2<T, Q>
      where SrcQ <: Qualifier {
        let zero = m.c0.x - m.c0.x
        Mat4x2(Vec2<T, Q>(m.c0.x, m.c0.y), Vec2<T, Q>(m.c1.x, m.c1.y), Vec2<T, Q>(zero, zero), Vec2<T, Q>(zero, zero))
    }

    public static func fromMat<SrcQ>(m: Mat2x4<T, SrcQ>, one: T): Mat4x2<T, Q>
      where SrcQ <: Qualifier {
        let zero = m.c0.x - m.c0.x
        Mat4x2(Vec2<T, Q>(m.c0.x, m.c0.y), Vec2<T, Q>(m.c1.x, m.c1.y), Vec2<T, Q>(zero, zero), Vec2<T, Q>(zero, zero))
    }

    public static func fromMat<SrcQ>(m: Mat3x2<T, SrcQ>, one: T): Mat4x2<T, Q>
      where SrcQ <: Qualifier {
        let zero = m.c0.x - m.c0.x
        Mat4x2(Vec2<T, Q>(m.c0.x, m.c0.y), Vec2<T, Q>(m.c1.x, m.c1.y), Vec2<T, Q>(m.c2.x, m.c2.y), Vec2<T, Q>(zero, zero))
    }

    public static func fromMat<SrcQ>(m: Mat3x3<T, SrcQ>, one: T): Mat4x2<T, Q>
      where SrcQ <: Qualifier {
        let zero = m.c0.x - m.c0.x
        Mat4x2(Vec2<T, Q>(m.c0.x, m.c0.y), Vec2<T, Q>(m.c1.x, m.c1.y), Vec2<T, Q>(m.c2.x, m.c2.y), Vec2<T, Q>(zero, zero))
    }

    public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat4x2<T, Q>
      where SrcQ <: Qualifier {
        let zero = m.c0.x - m.c0.x
        Mat4x2(Vec2<T, Q>(m.c0.x, m.c0.y), Vec2<T, Q>(m.c1.x, m.c1.y), Vec2<T, Q>(m.c2.x, m.c2.y), Vec2<T, Q>(zero, zero))
    }

    public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat4x2<T, Q>
      where SrcQ <: Qualifier {
        Mat4x2(Vec2<T, Q>(m.c0.x, m.c0.y), Vec2<T, Q>(m.c1.x, m.c1.y), Vec2<T, Q>(m.c2.x, m.c2.y), Vec2<T, Q>(m.c3.x, m.c3.y))
    }

    public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat4x2<T, Q>
      where SrcQ <: Qualifier {
        Mat4x2(Vec2<T, Q>(m.c0.x, m.c0.y), Vec2<T, Q>(m.c1.x, m.c1.y), Vec2<T, Q>(m.c2.x, m.c2.y), Vec2<T, Q>(m.c3.x, m.c3.y))
    }
}

extend<T, Q> Mat4x2<T, Q>
  where T <: Number<T>, Q <: Qualifier {

    public static func fromMat<U, P>(conv: (U) -> T, m: Mat2x2<U, P>, one: T): Mat4x2<T, Q>
      where P <: Qualifier {
        let zero = one - one
        Mat4x2(Vec2<T, Q>(conv(m.c0.x), conv(m.c0.y)), Vec2<T, Q>(conv(m.c1.x), conv(m.c1.y)), Vec2<T, Q>(zero, zero), Vec2<T, Q>(zero, zero))
    }

    public static func fromMat<U, P>(conv: (U) -> T, m: Mat2x3<U, P>, one: T): Mat4x2<T, Q>
      where P <: Qualifier {
        let zero = one - one
        Mat4x2(Vec2<T, Q>(conv(m.c0.x), conv(m.c0.y)), Vec2<T, Q>(conv(m.c1.x), conv(m.c1.y)), Vec2<T, Q>(zero, zero), Vec2<T, Q>(zero, zero))
    }

    public static func fromMat<U, P>(conv: (U) -> T, m: Mat2x4<U, P>, one: T): Mat4x2<T, Q>
      where P <: Qualifier {
        let zero = one - one
        Mat4x2(Vec2<T, Q>(conv(m.c0.x), conv(m.c0.y)), Vec2<T, Q>(conv(m.c1.x), conv(m.c1.y)), Vec2<T, Q>(zero, zero), Vec2<T, Q>(zero, zero))
    }

    public static func fromMat<U, P>(conv: (U) -> T, m: Mat3x2<U, P>, one: T): Mat4x2<T, Q>
      where P <: Qualifier {
        let zero = one - one
        Mat4x2(Vec2<T, Q>(conv(m.c0.x), conv(m.c0.y)), Vec2<T, Q>(conv(m.c1.x), conv(m.c1.y)), Vec2<T, Q>(conv(m.c2.x), conv(m.c2.y)), Vec2<T, Q>(zero, zero))
    }

    public static func fromMat<U, P>(conv: (U) -> T, m: Mat3x3<U, P>, one: T): Mat4x2<T, Q>
      where P <: Qualifier {
        let zero = one - one
        Mat4x2(Vec2<T, Q>(conv(m.c0.x), conv(m.c0.y)), Vec2<T, Q>(conv(m.c1.x), conv(m.c1.y)), Vec2<T, Q>(conv(m.c2.x), conv(m.c2.y)), Vec2<T, Q>(zero, zero))
    }

    public static func fromMat<U, P>(conv: (U) -> T, m: Mat3x4<U, P>, one: T): Mat4x2<T, Q>
      where P <: Qualifier {
        let zero = one - one
        Mat4x2(Vec2<T, Q>(conv(m.c0.x), conv(m.c0.y)), Vec2<T, Q>(conv(m.c1.x), conv(m.c1.y)), Vec2<T, Q>(conv(m.c2.x), conv(m.c2.y)), Vec2<T, Q>(zero, zero))
    }

    public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x3<U, P>, one: T): Mat4x2<T, Q>
      where P <: Qualifier {
        Mat4x2(Vec2<T, Q>(conv(m.c0.x), conv(m.c0.y)), Vec2<T, Q>(conv(m.c1.x), conv(m.c1.y)), Vec2<T, Q>(conv(m.c2.x), conv(m.c2.y)), Vec2<T, Q>(conv(m.c3.x), conv(m.c3.y)))
    }

    public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x4<U, P>, one: T): Mat4x2<T, Q>
      where P <: Qualifier {
        Mat4x2(Vec2<T, Q>(conv(m.c0.x), conv(m.c0.y)), Vec2<T, Q>(conv(m.c1.x), conv(m.c1.y)), Vec2<T, Q>(conv(m.c2.x), conv(m.c2.y)), Vec2<T, Q>(conv(m.c3.x), conv(m.c3.y)))
    }
}

extend<T, Q> Mat4x2<T, Q> where T <: Equatable<T>, Q <: Qualifier {
    public operator func ==(rhs: Mat4x2<T, Q>): Bool {
        ComputeEqual<T>.call(this.c0.x, rhs.c0.x) && ComputeEqual<T>.call(this.c0.y, rhs.c0.y) &&
        ComputeEqual<T>.call(this.c1.x, rhs.c1.x) && ComputeEqual<T>.call(this.c1.y, rhs.c1.y) &&
        ComputeEqual<T>.call(this.c2.x, rhs.c2.x) && ComputeEqual<T>.call(this.c2.y, rhs.c2.y) &&
        ComputeEqual<T>.call(this.c3.x, rhs.c3.x) && ComputeEqual<T>.call(this.c3.y, rhs.c3.y)
    }

    public operator func !=(rhs: Mat4x2<T, Q>): Bool {
        !(this == rhs)
    }

    public func equalExact(other: Mat4x2<T, Q>): Bool {
        ComputeEqual<T>.call(this.c0.x, other.c0.x) && ComputeEqual<T>.call(this.c0.y, other.c0.y) &&
        ComputeEqual<T>.call(this.c1.x, other.c1.x) && ComputeEqual<T>.call(this.c1.y, other.c1.y) &&
        ComputeEqual<T>.call(this.c2.x, other.c2.x) && ComputeEqual<T>.call(this.c2.y, other.c2.y) &&
        ComputeEqual<T>.call(this.c3.x, other.c3.x) && ComputeEqual<T>.call(this.c3.y, other.c3.y)
    }
}

extend<T, Q> Mat4x2<T, Q> where T <: Number<T> & Equatable<T> & Comparable<T>, Q <: Qualifier {
    public func equalEpsilon(other: Mat4x2<T, Q>): Bool {
        ComputeEqualNumeric<T>.callConst(this.c0.x, other.c0.x) && ComputeEqualNumeric<T>.callConst(this.c0.y, other.c0.y) &&
        ComputeEqualNumeric<T>.callConst(this.c1.x, other.c1.x) && ComputeEqualNumeric<T>.callConst(this.c1.y, other.c1.y) &&
        ComputeEqualNumeric<T>.callConst(this.c2.x, other.c2.x) && ComputeEqualNumeric<T>.callConst(this.c2.y, other.c2.y) &&
        ComputeEqualNumeric<T>.callConst(this.c3.x, other.c3.x) && ComputeEqualNumeric<T>.callConst(this.c3.y, other.c3.y)
    }
}
