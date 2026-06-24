package glm.detail

import std.math.{ Number, Integer }
import std.deriving.*

@Derive[Hashable]
public struct Mat3x3<T, Q> where Q <: Qualifier {
    public var c0: Vec3<T, Q>
    public var c1: Vec3<T, Q>
    public var c2: Vec3<T, Q>

    public const init(a00: T, a01: T, a02: T, a10: T, a11: T, a12: T, a20: T, a21: T, a22: T) {
        this.c0 = Vec3(a00, a01, a02)
        this.c1 = Vec3(a10, a11, a12)
        this.c2 = Vec3(a20, a21, a22)
    }

    public const init(c0: Vec3<T, Q>, c1: Vec3<T, Q>, c2: Vec3<T, Q>) {
        this.c0 = c0
        this.c1 = c1
        this.c2 = c2
    }

    public init(scalar: T) {
        this.c0 = Vec3(scalar, scalar, scalar)
        this.c1 = Vec3(scalar, scalar, scalar)
        this.c2 = Vec3(scalar, scalar, scalar)
    }

    public static func length(): Int64 { 3 }

    public operator func [](i: Int64): Vec3<T, Q> {
        assert(i >= Int64(0) && i < length(), message: "Mat3x3 index out of bounds")
        return match (i) {
            case 0 => this.c0
            case 1 => this.c1
            case 2 => this.c2
            case _ => throw Exception("Mat3x3 index out of bounds")
        }
    }

    public mut operator func [](i: Int64, value!: Vec3<T, Q>): Unit {
        assert(i >= Int64(0) && i < length(), message: "Mat3x3 index out of bounds")
        match (i) {
            case 0 => this.c0 = value
            case 1 => this.c1 = value
            case 2 => this.c2 = value
            case _ => throw Exception("Mat3x3 index out of bounds")
        }
    }

    public func col(i: Int64): Vec3<T, Q> { this[i] }
}

extend<T, Q> Mat3x3<T, Q> where T <: Number<T>, Q <: Qualifier {
    public operator func -(): Mat3x3<T, Q> {
        Mat3x3(-this.c0.x, -this.c0.y, -this.c0.z, -this.c1.x, -this.c1.y, -this.c1.z, -this.c2.x, -this.c2.y, -this.c2.z)
    }

    @OverflowWrapping
    public operator func +(rhs: T): Mat3x3<T, Q> {
        Mat3x3(this.c0.x + rhs, this.c0.y + rhs, this.c0.z + rhs, this.c1.x + rhs, this.c1.y + rhs, this.c1.z + rhs, this.c2.x + rhs, this.c2.y + rhs, this.c2.z + rhs)
    }

    @OverflowWrapping
    public operator func -(rhs: T): Mat3x3<T, Q> {
        Mat3x3(this.c0.x - rhs, this.c0.y - rhs, this.c0.z - rhs, this.c1.x - rhs, this.c1.y - rhs, this.c1.z - rhs, this.c2.x - rhs, this.c2.y - rhs, this.c2.z - rhs)
    }

    @OverflowWrapping
    public operator func *(rhs: T): Mat3x3<T, Q> {
        Mat3x3(this.c0.x * rhs, this.c0.y * rhs, this.c0.z * rhs, this.c1.x * rhs, this.c1.y * rhs, this.c1.z * rhs, this.c2.x * rhs, this.c2.y * rhs, this.c2.z * rhs)
    }

    @OverflowWrapping
    public operator func /(rhs: T): Mat3x3<T, Q> {
        Mat3x3(this.c0.x / rhs, this.c0.y / rhs, this.c0.z / rhs, this.c1.x / rhs, this.c1.y / rhs, this.c1.z / rhs, this.c2.x / rhs, this.c2.y / rhs, this.c2.z / rhs)
    }

    @OverflowWrapping
    public operator func +(rhs: Mat3x3<T, Q>): Mat3x3<T, Q> {
        Mat3x3(this.c0.x + rhs.c0.x, this.c0.y + rhs.c0.y, this.c0.z + rhs.c0.z, this.c1.x + rhs.c1.x, this.c1.y + rhs.c1.y, this.c1.z + rhs.c1.z, this.c2.x + rhs.c2.x, this.c2.y + rhs.c2.y, this.c2.z + rhs.c2.z)
    }

    @OverflowWrapping
    public operator func -(rhs: Mat3x3<T, Q>): Mat3x3<T, Q> {
        Mat3x3(this.c0.x - rhs.c0.x, this.c0.y - rhs.c0.y, this.c0.z - rhs.c0.z, this.c1.x - rhs.c1.x, this.c1.y - rhs.c1.y, this.c1.z - rhs.c1.z, this.c2.x - rhs.c2.x, this.c2.y - rhs.c2.y, this.c2.z - rhs.c2.z)
    }

    @OverflowWrapping
    public operator func *(rhs: Mat2x3<T, Q>): Mat2x3<T, Q> {
        Mat2x3<T, Q>(
            Vec3<T, Q>(this.c0.x * rhs.c0.x + this.c1.x * rhs.c0.y + this.c2.x * rhs.c0.z, this.c0.y * rhs.c0.x + this.c1.y * rhs.c0.y + this.c2.y * rhs.c0.z, this.c0.z * rhs.c0.x + this.c1.z * rhs.c0.y + this.c2.z * rhs.c0.z),
            Vec3<T, Q>(this.c0.x * rhs.c1.x + this.c1.x * rhs.c1.y + this.c2.x * rhs.c1.z, this.c0.y * rhs.c1.x + this.c1.y * rhs.c1.y + this.c2.y * rhs.c1.z, this.c0.z * rhs.c1.x + this.c1.z * rhs.c1.y + this.c2.z * rhs.c1.z)
        )
    }

    @OverflowWrapping
    public operator func *(rhs: Mat3x3<T, Q>): Mat3x3<T, Q> {
        Mat3x3<T, Q>(
            Vec3<T, Q>(this.c0.x * rhs.c0.x + this.c1.x * rhs.c0.y + this.c2.x * rhs.c0.z, this.c0.y * rhs.c0.x + this.c1.y * rhs.c0.y + this.c2.y * rhs.c0.z, this.c0.z * rhs.c0.x + this.c1.z * rhs.c0.y + this.c2.z * rhs.c0.z),
            Vec3<T, Q>(this.c0.x * rhs.c1.x + this.c1.x * rhs.c1.y + this.c2.x * rhs.c1.z, this.c0.y * rhs.c1.x + this.c1.y * rhs.c1.y + this.c2.y * rhs.c1.z, this.c0.z * rhs.c1.x + this.c1.z * rhs.c1.y + this.c2.z * rhs.c1.z),
            Vec3<T, Q>(this.c0.x * rhs.c2.x + this.c1.x * rhs.c2.y + this.c2.x * rhs.c2.z, this.c0.y * rhs.c2.x + this.c1.y * rhs.c2.y + this.c2.y * rhs.c2.z, this.c0.z * rhs.c2.x + this.c1.z * rhs.c2.y + this.c2.z * rhs.c2.z)
        )
    }

    @OverflowWrapping
    public operator func *(rhs: Mat4x3<T, Q>): Mat4x3<T, Q> {
        Mat4x3<T, Q>(
            Vec3<T, Q>(this.c0.x * rhs.c0.x + this.c1.x * rhs.c0.y + this.c2.x * rhs.c0.z, this.c0.y * rhs.c0.x + this.c1.y * rhs.c0.y + this.c2.y * rhs.c0.z, this.c0.z * rhs.c0.x + this.c1.z * rhs.c0.y + this.c2.z * rhs.c0.z),
            Vec3<T, Q>(this.c0.x * rhs.c1.x + this.c1.x * rhs.c1.y + this.c2.x * rhs.c1.z, this.c0.y * rhs.c1.x + this.c1.y * rhs.c1.y + this.c2.y * rhs.c1.z, this.c0.z * rhs.c1.x + this.c1.z * rhs.c1.y + this.c2.z * rhs.c1.z),
            Vec3<T, Q>(this.c0.x * rhs.c2.x + this.c1.x * rhs.c2.y + this.c2.x * rhs.c2.z, this.c0.y * rhs.c2.x + this.c1.y * rhs.c2.y + this.c2.y * rhs.c2.z, this.c0.z * rhs.c2.x + this.c1.z * rhs.c2.y + this.c2.z * rhs.c2.z),
            Vec3<T, Q>(this.c0.x * rhs.c3.x + this.c1.x * rhs.c3.y + this.c2.x * rhs.c3.z, this.c0.y * rhs.c3.x + this.c1.y * rhs.c3.y + this.c2.y * rhs.c3.z, this.c0.z * rhs.c3.x + this.c1.z * rhs.c3.y + this.c2.z * rhs.c3.z)
        )
    }

    @OverflowWrapping
    public operator func /(rhs: Mat3x3<T, Q>): Mat3x3<T, Q> { throw Exception("stub") }

    @OverflowWrapping
    public operator func *(v: Vec3<T, Q>): Vec3<T, Q> {
        Vec3<T, Q>(this.c0.x * v.x + this.c1.x * v.y + this.c2.x * v.z, this.c0.y * v.x + this.c1.y * v.y + this.c2.y * v.z, this.c0.z * v.x + this.c1.z * v.y + this.c2.z * v.z)
    }

    public static func diagonal(scalar: T): Mat3x3<T, Q> {
        let zero = scalar - scalar
        Mat3x3(Vec3<T, Q>(scalar, zero, zero), Vec3<T, Q>(zero, scalar, zero), Vec3<T, Q>(zero, zero, scalar))
    }

    public static func identity(one: T): Mat3x3<T, Q> { diagonal(one) }
}

extend<T, Q> Mat3x3<T, Q> where Q <: Qualifier {
    public static func fromParts<U>(conv: (U) -> T, a00: U, a01: U, a02: U, a10: U, a11: U, a12: U, a20: U, a21: U, a22: U): Mat3x3<T, Q> {
        Mat3x3(Vec3<T, Q>(conv(a00), conv(a01), conv(a02)), Vec3<T, Q>(conv(a10), conv(a11), conv(a12)), Vec3<T, Q>(conv(a20), conv(a21), conv(a22)))
    }

    public static func fromColumns<U, P>(conv: (U) -> T, c0: Vec3<U, P>, c1: Vec3<U, P>, c2: Vec3<U, P>): Mat3x3<T, Q>
      where P <: Qualifier {
        Mat3x3(Vec3<T, Q>(conv(c0.x), conv(c0.y), conv(c0.z)), Vec3<T, Q>(conv(c1.x), conv(c1.y), conv(c1.z)), Vec3<T, Q>(conv(c2.x), conv(c2.y), conv(c2.z)))
    }

    public static func fromMat<U, P>(conv: (U) -> T, m: Mat3x3<U, P>): Mat3x3<T, Q>
      where P <: Qualifier {
        Mat3x3(Vec3<T, Q>(conv(m.c0.x), conv(m.c0.y), conv(m.c0.z)), Vec3<T, Q>(conv(m.c1.x), conv(m.c1.y), conv(m.c1.z)), Vec3<T, Q>(conv(m.c2.x), conv(m.c2.y), conv(m.c2.z)))
    }
}

extend<T, Q> Mat3x3<T, Q>
  where T <: Number<T>, Q <: Qualifier {

    public static func fromMat<SrcQ>(m: Mat2x2<T, SrcQ>, one: T): Mat3x3<T, Q>
      where SrcQ <: Qualifier {
        let zero = m.c0.x - m.c0.x
        Mat3x3(Vec3<T, Q>(m.c0.x, m.c0.y, zero), Vec3<T, Q>(m.c1.x, m.c1.y, zero), Vec3<T, Q>(zero, zero, one))
    }

    public static func fromMat<SrcQ>(m: Mat2x3<T, SrcQ>, one: T): Mat3x3<T, Q>
      where SrcQ <: Qualifier {
        let zero = m.c0.x - m.c0.x
        Mat3x3(Vec3<T, Q>(m.c0.x, m.c0.y, m.c0.z), Vec3<T, Q>(m.c1.x, m.c1.y, m.c1.z), Vec3<T, Q>(zero, zero, one))
    }

    public static func fromMat<SrcQ>(m: Mat2x4<T, SrcQ>, one: T): Mat3x3<T, Q>
      where SrcQ <: Qualifier {
        let zero = m.c0.x - m.c0.x
        Mat3x3(Vec3<T, Q>(m.c0.x, m.c0.y, m.c0.z), Vec3<T, Q>(m.c1.x, m.c1.y, m.c1.z), Vec3<T, Q>(zero, zero, one))
    }

    public static func fromMat<SrcQ>(m: Mat3x2<T, SrcQ>, one: T): Mat3x3<T, Q>
      where SrcQ <: Qualifier {
        let zero = m.c0.x - m.c0.x
        Mat3x3(Vec3<T, Q>(m.c0.x, m.c0.y, zero), Vec3<T, Q>(m.c1.x, m.c1.y, zero), Vec3<T, Q>(m.c2.x, m.c2.y, one))
    }

    public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat3x3<T, Q>
      where SrcQ <: Qualifier {
        Mat3x3(Vec3<T, Q>(m.c0.x, m.c0.y, m.c0.z), Vec3<T, Q>(m.c1.x, m.c1.y, m.c1.z), Vec3<T, Q>(m.c2.x, m.c2.y, m.c2.z))
    }

    public static func fromMat<SrcQ>(m: Mat4x2<T, SrcQ>, one: T): Mat3x3<T, Q>
      where SrcQ <: Qualifier {
        let zero = m.c0.x - m.c0.x
        Mat3x3(Vec3<T, Q>(m.c0.x, m.c0.y, zero), Vec3<T, Q>(m.c1.x, m.c1.y, zero), Vec3<T, Q>(m.c2.x, m.c2.y, one))
    }

    public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat3x3<T, Q>
      where SrcQ <: Qualifier {
        Mat3x3(Vec3<T, Q>(m.c0.x, m.c0.y, m.c0.z), Vec3<T, Q>(m.c1.x, m.c1.y, m.c1.z), Vec3<T, Q>(m.c2.x, m.c2.y, m.c2.z))
    }

    public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat3x3<T, Q>
      where SrcQ <: Qualifier {
        Mat3x3(Vec3<T, Q>(m.c0.x, m.c0.y, m.c0.z), Vec3<T, Q>(m.c1.x, m.c1.y, m.c1.z), Vec3<T, Q>(m.c2.x, m.c2.y, m.c2.z))
    }
}

extend<T, Q> Mat3x3<T, Q>
  where T <: Number<T>, Q <: Qualifier {

    public static func fromMat<U, P>(conv: (U) -> T, m: Mat2x2<U, P>, one: T): Mat3x3<T, Q>
      where P <: Qualifier {
        let zero = one - one
        Mat3x3(Vec3<T, Q>(conv(m.c0.x), conv(m.c0.y), zero), Vec3<T, Q>(conv(m.c1.x), conv(m.c1.y), zero), Vec3<T, Q>(zero, zero, one))
    }

    public static func fromMat<U, P>(conv: (U) -> T, m: Mat2x3<U, P>, one: T): Mat3x3<T, Q>
      where P <: Qualifier {
        let zero = one - one
        Mat3x3(Vec3<T, Q>(conv(m.c0.x), conv(m.c0.y), conv(m.c0.z)), Vec3<T, Q>(conv(m.c1.x), conv(m.c1.y), conv(m.c1.z)), Vec3<T, Q>(zero, zero, one))
    }

    public static func fromMat<U, P>(conv: (U) -> T, m: Mat2x4<U, P>, one: T): Mat3x3<T, Q>
      where P <: Qualifier {
        let zero = one - one
        Mat3x3(Vec3<T, Q>(conv(m.c0.x), conv(m.c0.y), conv(m.c0.z)), Vec3<T, Q>(conv(m.c1.x), conv(m.c1.y), conv(m.c1.z)), Vec3<T, Q>(zero, zero, one))
    }

    public static func fromMat<U, P>(conv: (U) -> T, m: Mat3x2<U, P>, one: T): Mat3x3<T, Q>
      where P <: Qualifier {
        let zero = one - one
        Mat3x3(Vec3<T, Q>(conv(m.c0.x), conv(m.c0.y), zero), Vec3<T, Q>(conv(m.c1.x), conv(m.c1.y), zero), Vec3<T, Q>(conv(m.c2.x), conv(m.c2.y), one))
    }

    public static func fromMat<U, P>(conv: (U) -> T, m: Mat3x4<U, P>, one: T): Mat3x3<T, Q>
      where P <: Qualifier {
        Mat3x3(Vec3<T, Q>(conv(m.c0.x), conv(m.c0.y), conv(m.c0.z)), Vec3<T, Q>(conv(m.c1.x), conv(m.c1.y), conv(m.c1.z)), Vec3<T, Q>(conv(m.c2.x), conv(m.c2.y), conv(m.c2.z)))
    }

    public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x2<U, P>, one: T): Mat3x3<T, Q>
      where P <: Qualifier {
        let zero = one - one
        Mat3x3(Vec3<T, Q>(conv(m.c0.x), conv(m.c0.y), zero), Vec3<T, Q>(conv(m.c1.x), conv(m.c1.y), zero), Vec3<T, Q>(conv(m.c2.x), conv(m.c2.y), one))
    }

    public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x3<U, P>, one: T): Mat3x3<T, Q>
      where P <: Qualifier {
        Mat3x3(Vec3<T, Q>(conv(m.c0.x), conv(m.c0.y), conv(m.c0.z)), Vec3<T, Q>(conv(m.c1.x), conv(m.c1.y), conv(m.c1.z)), Vec3<T, Q>(conv(m.c2.x), conv(m.c2.y), conv(m.c2.z)))
    }

    public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x4<U, P>, one: T): Mat3x3<T, Q>
      where P <: Qualifier {
        Mat3x3(Vec3<T, Q>(conv(m.c0.x), conv(m.c0.y), conv(m.c0.z)), Vec3<T, Q>(conv(m.c1.x), conv(m.c1.y), conv(m.c1.z)), Vec3<T, Q>(conv(m.c2.x), conv(m.c2.y), conv(m.c2.z)))
    }
}

extend<T, Q> Mat3x3<T, Q> where T <: Equatable<T>, Q <: Qualifier {
    public operator func ==(rhs: Mat3x3<T, Q>): Bool {
        ComputeEqual<T>.call(this.c0.x, rhs.c0.x) && ComputeEqual<T>.call(this.c0.y, rhs.c0.y) &&
        ComputeEqual<T>.call(this.c0.z, rhs.c0.z) && ComputeEqual<T>.call(this.c1.x, rhs.c1.x) &&
        ComputeEqual<T>.call(this.c1.y, rhs.c1.y) && ComputeEqual<T>.call(this.c1.z, rhs.c1.z) &&
        ComputeEqual<T>.call(this.c2.x, rhs.c2.x) && ComputeEqual<T>.call(this.c2.y, rhs.c2.y) &&
        ComputeEqual<T>.call(this.c2.z, rhs.c2.z)
    }

    public operator func !=(rhs: Mat3x3<T, Q>): Bool {
        !(this == rhs)
    }

    public func equalExact(other: Mat3x3<T, Q>): Bool {
        ComputeEqual<T>.call(this.c0.x, other.c0.x) && ComputeEqual<T>.call(this.c0.y, other.c0.y) &&
        ComputeEqual<T>.call(this.c0.z, other.c0.z) && ComputeEqual<T>.call(this.c1.x, other.c1.x) &&
        ComputeEqual<T>.call(this.c1.y, other.c1.y) && ComputeEqual<T>.call(this.c1.z, other.c1.z) &&
        ComputeEqual<T>.call(this.c2.x, other.c2.x) && ComputeEqual<T>.call(this.c2.y, other.c2.y) &&
        ComputeEqual<T>.call(this.c2.z, other.c2.z)
    }
}

extend<T, Q> Mat3x3<T, Q> where T <: Number<T> & Equatable<T> & Comparable<T>, Q <: Qualifier {
    public func equalEpsilon(other: Mat3x3<T, Q>): Bool {
        ComputeEqualNumeric<T>.callConst(this.c0.x, other.c0.x) && ComputeEqualNumeric<T>.callConst(this.c0.y, other.c0.y) &&
        ComputeEqualNumeric<T>.callConst(this.c0.z, other.c0.z) && ComputeEqualNumeric<T>.callConst(this.c1.x, other.c1.x) &&
        ComputeEqualNumeric<T>.callConst(this.c1.y, other.c1.y) && ComputeEqualNumeric<T>.callConst(this.c1.z, other.c1.z) &&
        ComputeEqualNumeric<T>.callConst(this.c2.x, other.c2.x) && ComputeEqualNumeric<T>.callConst(this.c2.y, other.c2.y) &&
        ComputeEqualNumeric<T>.callConst(this.c2.z, other.c2.z)
    }
}
