package glm.gtc
import glm.detail.{ Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4, Vec2, Vec3, Vec4, Qualifier }
import std.math.FloatingPoint

// ── row ──

public func row<T, Q>(m: Mat2x2<T, Q>, index: Int64): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    match (index) {
        case 0 => Vec2(m.c0.x, m.c1.x)
        case 1 => Vec2(m.c0.y, m.c1.y)
        case _ => throw Exception("index out of range")
    }
}

public func row<T, Q>(m: Mat3x3<T, Q>, index: Int64): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    match (index) {
        case 0 => Vec3(m.c0.x, m.c1.x, m.c2.x)
        case 1 => Vec3(m.c0.y, m.c1.y, m.c2.y)
        case 2 => Vec3(m.c0.z, m.c1.z, m.c2.z)
        case _ => throw Exception("index out of range")
    }
}

public func row<T, Q>(m: Mat4x4<T, Q>, index: Int64): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    match (index) {
        case 0 => Vec4(m.c0.x, m.c1.x, m.c2.x, m.c3.x)
        case 1 => Vec4(m.c0.y, m.c1.y, m.c2.y, m.c3.y)
        case 2 => Vec4(m.c0.z, m.c1.z, m.c2.z, m.c3.z)
        case 3 => Vec4(m.c0.w, m.c1.w, m.c2.w, m.c3.w)
        case _ => throw Exception("index out of range")
    }
}

public func row<T, Q>(m: Mat2x3<T, Q>, index: Int64): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    match (index) {
        case 0 => Vec2(m.c0.x, m.c1.x)
        case 1 => Vec2(m.c0.y, m.c1.y)
        case 2 => Vec2(m.c0.z, m.c1.z)
        case _ => throw Exception("index out of range")
    }
}

public func row<T, Q>(m: Mat3x2<T, Q>, index: Int64): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    match (index) {
        case 0 => Vec3(m.c0.x, m.c1.x, m.c2.x)
        case 1 => Vec3(m.c0.y, m.c1.y, m.c2.y)
        case _ => throw Exception("index out of range")
    }
}

public func row<T, Q>(m: Mat2x4<T, Q>, index: Int64): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    match (index) {
        case 0 => Vec2(m.c0.x, m.c1.x)
        case 1 => Vec2(m.c0.y, m.c1.y)
        case 2 => Vec2(m.c0.z, m.c1.z)
        case 3 => Vec2(m.c0.w, m.c1.w)
        case _ => throw Exception("index out of range")
    }
}

public func row<T, Q>(m: Mat4x2<T, Q>, index: Int64): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    match (index) {
        case 0 => Vec4(m.c0.x, m.c1.x, m.c2.x, m.c3.x)
        case 1 => Vec4(m.c0.y, m.c1.y, m.c2.y, m.c3.y)
        case _ => throw Exception("index out of range")
    }
}

public func row<T, Q>(m: Mat3x4<T, Q>, index: Int64): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    match (index) {
        case 0 => Vec3(m.c0.x, m.c1.x, m.c2.x)
        case 1 => Vec3(m.c0.y, m.c1.y, m.c2.y)
        case 2 => Vec3(m.c0.z, m.c1.z, m.c2.z)
        case 3 => Vec3(m.c0.w, m.c1.w, m.c2.w)
        case _ => throw Exception("index out of range")
    }
}

public func row<T, Q>(m: Mat4x3<T, Q>, index: Int64): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    match (index) {
        case 0 => Vec4(m.c0.x, m.c1.x, m.c2.x, m.c3.x)
        case 1 => Vec4(m.c0.y, m.c1.y, m.c2.y, m.c3.y)
        case 2 => Vec4(m.c0.z, m.c1.z, m.c2.z, m.c3.z)
        case _ => throw Exception("index out of range")
    }
}

// ── column ──

public func column<T, Q>(m: Mat2x2<T, Q>, index: Int64): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    match (index) {
        case 0 => m.c0
        case 1 => m.c1
        case _ => throw Exception("index out of range")
    }
}

public func column<T, Q>(m: Mat3x3<T, Q>, index: Int64): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    match (index) {
        case 0 => m.c0
        case 1 => m.c1
        case 2 => m.c2
        case _ => throw Exception("index out of range")
    }
}

public func column<T, Q>(m: Mat4x4<T, Q>, index: Int64): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    match (index) {
        case 0 => m.c0
        case 1 => m.c1
        case 2 => m.c2
        case 3 => m.c3
        case _ => throw Exception("index out of range")
    }
}

public func column<T, Q>(m: Mat2x3<T, Q>, index: Int64): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    match (index) {
        case 0 => m.c0
        case 1 => m.c1
        case _ => throw Exception("index out of range")
    }
}

public func column<T, Q>(m: Mat3x2<T, Q>, index: Int64): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    match (index) {
        case 0 => m.c0
        case 1 => m.c1
        case 2 => m.c2
        case _ => throw Exception("index out of range")
    }
}

public func column<T, Q>(m: Mat2x4<T, Q>, index: Int64): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    match (index) {
        case 0 => m.c0
        case 1 => m.c1
        case _ => throw Exception("index out of range")
    }
}

public func column<T, Q>(m: Mat4x2<T, Q>, index: Int64): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    match (index) {
        case 0 => m.c0
        case 1 => m.c1
        case 2 => m.c2
        case 3 => m.c3
        case _ => throw Exception("index out of range")
    }
}

public func column<T, Q>(m: Mat3x4<T, Q>, index: Int64): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    match (index) {
        case 0 => m.c0
        case 1 => m.c1
        case 2 => m.c2
        case _ => throw Exception("index out of range")
    }
}

public func column<T, Q>(m: Mat4x3<T, Q>, index: Int64): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    match (index) {
        case 0 => m.c0
        case 1 => m.c1
        case 2 => m.c2
        case 3 => m.c3
        case _ => throw Exception("index out of range")
    }
}
