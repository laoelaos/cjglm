package glm.detail

import std.math.{ Number, FloatingPoint }
import std.deriving.*

@Derive[Hashable]
public struct Quat<T, Q> where Q <: Qualifier {
    public var x: T
    public var y: T
    public var z: T
    public var w: T

    public const init(x: T, y: T, z: T, w: T) {
        this.x = x
        this.y = y
        this.z = z
        this.w = w
    }

    public init(s: T, v: Vec3<T, Q>) {
        this.x = v.x
        this.y = v.y
        this.z = v.z
        this.w = s
    }

    public static func length(): Int64 { 4 }

    public static func wxyz(w: T, x: T, y: T, z: T): Quat<T, Q> {
        Quat(x, y, z, w)
    }

    public operator func [](i: Int64): T {
        assert(i >= Int64(0) && i < length(), message: "Quat index out of bounds")
        return match (i) {
            case 0 => this.x
            case 1 => this.y
            case 2 => this.z
            case 3 => this.w
            case _ => throw Exception("Quat index out of bounds")
        }
    }

    public mut operator func [](i: Int64, value!: T): Unit {
        assert(i >= Int64(0) && i < length(), message: "Quat index out of bounds")
        match (i) {
            case 0 => this.x = value
            case 1 => this.y = value
            case 2 => this.z = value
            case 3 => this.w = value
            case _ => throw Exception("Quat index out of bounds")
        }
    }
}

extend<T, Q> Quat<T, Q> where Q <: Qualifier {
    public static func fromQuat<U, P>(conv: (U) -> T, q: Quat<U, P>): Quat<T, Q> where P <: Qualifier {
        Quat(conv(q.x), conv(q.y), conv(q.z), conv(q.w))
    }

    public static func fromQual<Q2>(q: Quat<T, Q2>): Quat<T, Q> where Q2 <: Qualifier {
        Quat(q.x, q.y, q.z, q.w)
    }
}

extend<T, Q> Quat<T, Q> where T <: Number<T>, Q <: Qualifier {
    public static func identity(one: T): Quat<T, Q> {
        let zero = one - one
        Quat(zero, zero, zero, one)
    }
}

extend<T, Q> Quat<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    public static func fromMat3(m: Mat3x3<T, Q>): Quat<T, Q> {
        quatCast(m)
    }

    public static func fromMat4(m: Mat4x4<T, Q>): Quat<T, Q> {
        quatCast(m)
    }
}

extend<T, Q> Quat<T, Q> where T <: Number<T>, Q <: Qualifier {
    public operator func -(): Quat<T, Q> {
        Quat(-this.x, -this.y, -this.z, -this.w)
    }

    @OverflowWrapping
    public operator func +(rhs: Quat<T, Q>): Quat<T, Q> {
        Quat(this.x + rhs.x, this.y + rhs.y, this.z + rhs.z, this.w + rhs.w)
    }

    @OverflowWrapping
    public operator func -(rhs: Quat<T, Q>): Quat<T, Q> {
        Quat(this.x - rhs.x, this.y - rhs.y, this.z - rhs.z, this.w - rhs.w)
    }

    @OverflowWrapping
    public operator func *(rhs: Quat<T, Q>): Quat<T, Q> {
        Quat(
            this.w * rhs.x + this.x * rhs.w + this.y * rhs.z - this.z * rhs.y,
            this.w * rhs.y - this.x * rhs.z + this.y * rhs.w + this.z * rhs.x,
            this.w * rhs.z + this.x * rhs.y - this.y * rhs.x + this.z * rhs.w,
            this.w * rhs.w - this.x * rhs.x - this.y * rhs.y - this.z * rhs.z
        )
    }

    @OverflowWrapping
    public operator func /(rhs: Quat<T, Q>): Quat<T, Q> {
        let n2 = rhs.x * rhs.x + rhs.y * rhs.y + rhs.z * rhs.z + rhs.w * rhs.w
        Quat(
            (-this.w * rhs.x + this.x * rhs.w - this.y * rhs.z + this.z * rhs.y) / n2,
            (-this.w * rhs.y + this.x * rhs.z + this.y * rhs.w - this.z * rhs.x) / n2,
            (-this.w * rhs.z - this.x * rhs.y + this.y * rhs.x + this.z * rhs.w) / n2,
            (this.w * rhs.w + this.x * rhs.x + this.y * rhs.y + this.z * rhs.z) / n2
        )
    }

    @OverflowWrapping
    public operator func *(rhs: Vec3<T, Q>): Vec3<T, Q> {
        throw Exception("stub")
    }

    @OverflowWrapping
    public operator func *(rhs: Vec4<T, Q>): Vec4<T, Q> {
        throw Exception("stub")
    }

    @OverflowWrapping
    public operator func *(rhs: T): Quat<T, Q> {
        Quat(this.x * rhs, this.y * rhs, this.z * rhs, this.w * rhs)
    }

    @OverflowWrapping
    public operator func /(rhs: T): Quat<T, Q> {
        Quat(this.x / rhs, this.y / rhs, this.z / rhs, this.w / rhs)
    }
}

extend<T, Q> Vec3<T, Q> where T <: Number<T>, Q <: Qualifier {
    @OverflowWrapping
    public operator func *(rhs: Quat<T, Q>): Vec3<T, Q> {
        throw Exception("stub")
    }
}

extend<T, Q> Vec4<T, Q> where T <: Number<T>, Q <: Qualifier {
    @OverflowWrapping
    public operator func *(rhs: Quat<T, Q>): Vec4<T, Q> {
        throw Exception("stub")
    }
}

extend<T, Q> Quat<T, Q> where T <: Equatable<T>, Q <: Qualifier {
    public operator func ==(rhs: Quat<T, Q>): Bool {
        ComputeEqual<T>.call(this.x, rhs.x) && ComputeEqual<T>.call(this.y, rhs.y) &&
        ComputeEqual<T>.call(this.z, rhs.z) && ComputeEqual<T>.call(this.w, rhs.w)
    }
    public operator func !=(rhs: Quat<T, Q>): Bool {
        !(this == rhs)
    }
}
