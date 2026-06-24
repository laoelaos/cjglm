package glm.detail

import std.math.{ Number }

@OverflowWrapping
public func add<T, Q>(s: T, m: Mat2x2<T, Q>): Mat2x2<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat2x2(Vec2<T, Q>(s + m.c0.x, s + m.c0.y), Vec2<T, Q>(s + m.c1.x, s + m.c1.y))
}

@OverflowWrapping
public func add<T, Q>(s: T, m: Mat2x3<T, Q>): Mat2x3<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat2x3(Vec3<T, Q>(s + m.c0.x, s + m.c0.y, s + m.c0.z), Vec3<T, Q>(s + m.c1.x, s + m.c1.y, s + m.c1.z))
}

@OverflowWrapping
public func add<T, Q>(s: T, m: Mat2x4<T, Q>): Mat2x4<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat2x4(Vec4<T, Q>(s + m.c0.x, s + m.c0.y, s + m.c0.z, s + m.c0.w), Vec4<T, Q>(s + m.c1.x, s + m.c1.y, s + m.c1.z, s + m.c1.w))
}

@OverflowWrapping
public func add<T, Q>(s: T, m: Mat3x2<T, Q>): Mat3x2<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat3x2(Vec2<T, Q>(s + m.c0.x, s + m.c0.y), Vec2<T, Q>(s + m.c1.x, s + m.c1.y), Vec2<T, Q>(s + m.c2.x, s + m.c2.y))
}

@OverflowWrapping
public func add<T, Q>(s: T, m: Mat3x3<T, Q>): Mat3x3<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat3x3(Vec3<T, Q>(s + m.c0.x, s + m.c0.y, s + m.c0.z), Vec3<T, Q>(s + m.c1.x, s + m.c1.y, s + m.c1.z), Vec3<T, Q>(s + m.c2.x, s + m.c2.y, s + m.c2.z))
}

@OverflowWrapping
public func add<T, Q>(s: T, m: Mat3x4<T, Q>): Mat3x4<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat3x4(Vec4<T, Q>(s + m.c0.x, s + m.c0.y, s + m.c0.z, s + m.c0.w), Vec4<T, Q>(s + m.c1.x, s + m.c1.y, s + m.c1.z, s + m.c1.w), Vec4<T, Q>(s + m.c2.x, s + m.c2.y, s + m.c2.z, s + m.c2.w))
}

@OverflowWrapping
public func add<T, Q>(s: T, m: Mat4x2<T, Q>): Mat4x2<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat4x2(Vec2<T, Q>(s + m.c0.x, s + m.c0.y), Vec2<T, Q>(s + m.c1.x, s + m.c1.y), Vec2<T, Q>(s + m.c2.x, s + m.c2.y), Vec2<T, Q>(s + m.c3.x, s + m.c3.y))
}

@OverflowWrapping
public func add<T, Q>(s: T, m: Mat4x3<T, Q>): Mat4x3<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat4x3(Vec3<T, Q>(s + m.c0.x, s + m.c0.y, s + m.c0.z), Vec3<T, Q>(s + m.c1.x, s + m.c1.y, s + m.c1.z), Vec3<T, Q>(s + m.c2.x, s + m.c2.y, s + m.c2.z), Vec3<T, Q>(s + m.c3.x, s + m.c3.y, s + m.c3.z))
}

@OverflowWrapping
public func add<T, Q>(s: T, m: Mat4x4<T, Q>): Mat4x4<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat4x4(Vec4<T, Q>(s + m.c0.x, s + m.c0.y, s + m.c0.z, s + m.c0.w), Vec4<T, Q>(s + m.c1.x, s + m.c1.y, s + m.c1.z, s + m.c1.w), Vec4<T, Q>(s + m.c2.x, s + m.c2.y, s + m.c2.z, s + m.c2.w), Vec4<T, Q>(s + m.c3.x, s + m.c3.y, s + m.c3.z, s + m.c3.w))
}

@OverflowWrapping
public func sub<T, Q>(s: T, m: Mat2x2<T, Q>): Mat2x2<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat2x2(Vec2<T, Q>(s - m.c0.x, s - m.c0.y), Vec2<T, Q>(s - m.c1.x, s - m.c1.y))
}

@OverflowWrapping
public func sub<T, Q>(s: T, m: Mat2x3<T, Q>): Mat2x3<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat2x3(Vec3<T, Q>(s - m.c0.x, s - m.c0.y, s - m.c0.z), Vec3<T, Q>(s - m.c1.x, s - m.c1.y, s - m.c1.z))
}

@OverflowWrapping
public func sub<T, Q>(s: T, m: Mat2x4<T, Q>): Mat2x4<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat2x4(Vec4<T, Q>(s - m.c0.x, s - m.c0.y, s - m.c0.z, s - m.c0.w), Vec4<T, Q>(s - m.c1.x, s - m.c1.y, s - m.c1.z, s - m.c1.w))
}

@OverflowWrapping
public func sub<T, Q>(s: T, m: Mat3x2<T, Q>): Mat3x2<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat3x2(Vec2<T, Q>(s - m.c0.x, s - m.c0.y), Vec2<T, Q>(s - m.c1.x, s - m.c1.y), Vec2<T, Q>(s - m.c2.x, s - m.c2.y))
}

@OverflowWrapping
public func sub<T, Q>(s: T, m: Mat3x3<T, Q>): Mat3x3<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat3x3(Vec3<T, Q>(s - m.c0.x, s - m.c0.y, s - m.c0.z), Vec3<T, Q>(s - m.c1.x, s - m.c1.y, s - m.c1.z), Vec3<T, Q>(s - m.c2.x, s - m.c2.y, s - m.c2.z))
}

@OverflowWrapping
public func sub<T, Q>(s: T, m: Mat3x4<T, Q>): Mat3x4<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat3x4(Vec4<T, Q>(s - m.c0.x, s - m.c0.y, s - m.c0.z, s - m.c0.w), Vec4<T, Q>(s - m.c1.x, s - m.c1.y, s - m.c1.z, s - m.c1.w), Vec4<T, Q>(s - m.c2.x, s - m.c2.y, s - m.c2.z, s - m.c2.w))
}

@OverflowWrapping
public func sub<T, Q>(s: T, m: Mat4x2<T, Q>): Mat4x2<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat4x2(Vec2<T, Q>(s - m.c0.x, s - m.c0.y), Vec2<T, Q>(s - m.c1.x, s - m.c1.y), Vec2<T, Q>(s - m.c2.x, s - m.c2.y), Vec2<T, Q>(s - m.c3.x, s - m.c3.y))
}

@OverflowWrapping
public func sub<T, Q>(s: T, m: Mat4x3<T, Q>): Mat4x3<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat4x3(Vec3<T, Q>(s - m.c0.x, s - m.c0.y, s - m.c0.z), Vec3<T, Q>(s - m.c1.x, s - m.c1.y, s - m.c1.z), Vec3<T, Q>(s - m.c2.x, s - m.c2.y, s - m.c2.z), Vec3<T, Q>(s - m.c3.x, s - m.c3.y, s - m.c3.z))
}

@OverflowWrapping
public func sub<T, Q>(s: T, m: Mat4x4<T, Q>): Mat4x4<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat4x4(Vec4<T, Q>(s - m.c0.x, s - m.c0.y, s - m.c0.z, s - m.c0.w), Vec4<T, Q>(s - m.c1.x, s - m.c1.y, s - m.c1.z, s - m.c1.w), Vec4<T, Q>(s - m.c2.x, s - m.c2.y, s - m.c2.z, s - m.c2.w), Vec4<T, Q>(s - m.c3.x, s - m.c3.y, s - m.c3.z, s - m.c3.w))
}

@OverflowWrapping
public func mul<T, Q>(s: T, m: Mat2x2<T, Q>): Mat2x2<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat2x2(Vec2<T, Q>(s * m.c0.x, s * m.c0.y), Vec2<T, Q>(s * m.c1.x, s * m.c1.y))
}

@OverflowWrapping
public func mul<T, Q>(s: T, m: Mat2x3<T, Q>): Mat2x3<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat2x3(Vec3<T, Q>(s * m.c0.x, s * m.c0.y, s * m.c0.z), Vec3<T, Q>(s * m.c1.x, s * m.c1.y, s * m.c1.z))
}

@OverflowWrapping
public func mul<T, Q>(s: T, m: Mat2x4<T, Q>): Mat2x4<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat2x4(Vec4<T, Q>(s * m.c0.x, s * m.c0.y, s * m.c0.z, s * m.c0.w), Vec4<T, Q>(s * m.c1.x, s * m.c1.y, s * m.c1.z, s * m.c1.w))
}

@OverflowWrapping
public func mul<T, Q>(s: T, m: Mat3x2<T, Q>): Mat3x2<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat3x2(Vec2<T, Q>(s * m.c0.x, s * m.c0.y), Vec2<T, Q>(s * m.c1.x, s * m.c1.y), Vec2<T, Q>(s * m.c2.x, s * m.c2.y))
}

@OverflowWrapping
public func mul<T, Q>(s: T, m: Mat3x3<T, Q>): Mat3x3<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat3x3(Vec3<T, Q>(s * m.c0.x, s * m.c0.y, s * m.c0.z), Vec3<T, Q>(s * m.c1.x, s * m.c1.y, s * m.c1.z), Vec3<T, Q>(s * m.c2.x, s * m.c2.y, s * m.c2.z))
}

@OverflowWrapping
public func mul<T, Q>(s: T, m: Mat3x4<T, Q>): Mat3x4<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat3x4(Vec4<T, Q>(s * m.c0.x, s * m.c0.y, s * m.c0.z, s * m.c0.w), Vec4<T, Q>(s * m.c1.x, s * m.c1.y, s * m.c1.z, s * m.c1.w), Vec4<T, Q>(s * m.c2.x, s * m.c2.y, s * m.c2.z, s * m.c2.w))
}

@OverflowWrapping
public func mul<T, Q>(s: T, m: Mat4x2<T, Q>): Mat4x2<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat4x2(Vec2<T, Q>(s * m.c0.x, s * m.c0.y), Vec2<T, Q>(s * m.c1.x, s * m.c1.y), Vec2<T, Q>(s * m.c2.x, s * m.c2.y), Vec2<T, Q>(s * m.c3.x, s * m.c3.y))
}

@OverflowWrapping
public func mul<T, Q>(s: T, m: Mat4x3<T, Q>): Mat4x3<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat4x3(Vec3<T, Q>(s * m.c0.x, s * m.c0.y, s * m.c0.z), Vec3<T, Q>(s * m.c1.x, s * m.c1.y, s * m.c1.z), Vec3<T, Q>(s * m.c2.x, s * m.c2.y, s * m.c2.z), Vec3<T, Q>(s * m.c3.x, s * m.c3.y, s * m.c3.z))
}

@OverflowWrapping
public func mul<T, Q>(s: T, m: Mat4x4<T, Q>): Mat4x4<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat4x4(Vec4<T, Q>(s * m.c0.x, s * m.c0.y, s * m.c0.z, s * m.c0.w), Vec4<T, Q>(s * m.c1.x, s * m.c1.y, s * m.c1.z, s * m.c1.w), Vec4<T, Q>(s * m.c2.x, s * m.c2.y, s * m.c2.z, s * m.c2.w), Vec4<T, Q>(s * m.c3.x, s * m.c3.y, s * m.c3.z, s * m.c3.w))
}

@OverflowWrapping
public func div<T, Q>(s: T, m: Mat2x2<T, Q>): Mat2x2<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat2x2(Vec2<T, Q>(s / m.c0.x, s / m.c0.y), Vec2<T, Q>(s / m.c1.x, s / m.c1.y))
}

@OverflowWrapping
public func div<T, Q>(s: T, m: Mat2x3<T, Q>): Mat2x3<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat2x3(Vec3<T, Q>(s / m.c0.x, s / m.c0.y, s / m.c0.z), Vec3<T, Q>(s / m.c1.x, s / m.c1.y, s / m.c1.z))
}

@OverflowWrapping
public func div<T, Q>(s: T, m: Mat2x4<T, Q>): Mat2x4<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat2x4(Vec4<T, Q>(s / m.c0.x, s / m.c0.y, s / m.c0.z, s / m.c0.w), Vec4<T, Q>(s / m.c1.x, s / m.c1.y, s / m.c1.z, s / m.c1.w))
}

@OverflowWrapping
public func div<T, Q>(s: T, m: Mat3x2<T, Q>): Mat3x2<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat3x2(Vec2<T, Q>(s / m.c0.x, s / m.c0.y), Vec2<T, Q>(s / m.c1.x, s / m.c1.y), Vec2<T, Q>(s / m.c2.x, s / m.c2.y))
}

@OverflowWrapping
public func div<T, Q>(s: T, m: Mat3x3<T, Q>): Mat3x3<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat3x3(Vec3<T, Q>(s / m.c0.x, s / m.c0.y, s / m.c0.z), Vec3<T, Q>(s / m.c1.x, s / m.c1.y, s / m.c1.z), Vec3<T, Q>(s / m.c2.x, s / m.c2.y, s / m.c2.z))
}

@OverflowWrapping
public func div<T, Q>(s: T, m: Mat3x4<T, Q>): Mat3x4<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat3x4(Vec4<T, Q>(s / m.c0.x, s / m.c0.y, s / m.c0.z, s / m.c0.w), Vec4<T, Q>(s / m.c1.x, s / m.c1.y, s / m.c1.z, s / m.c1.w), Vec4<T, Q>(s / m.c2.x, s / m.c2.y, s / m.c2.z, s / m.c2.w))
}

@OverflowWrapping
public func div<T, Q>(s: T, m: Mat4x2<T, Q>): Mat4x2<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat4x2(Vec2<T, Q>(s / m.c0.x, s / m.c0.y), Vec2<T, Q>(s / m.c1.x, s / m.c1.y), Vec2<T, Q>(s / m.c2.x, s / m.c2.y), Vec2<T, Q>(s / m.c3.x, s / m.c3.y))
}

@OverflowWrapping
public func div<T, Q>(s: T, m: Mat4x3<T, Q>): Mat4x3<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat4x3(Vec3<T, Q>(s / m.c0.x, s / m.c0.y, s / m.c0.z), Vec3<T, Q>(s / m.c1.x, s / m.c1.y, s / m.c1.z), Vec3<T, Q>(s / m.c2.x, s / m.c2.y, s / m.c2.z), Vec3<T, Q>(s / m.c3.x, s / m.c3.y, s / m.c3.z))
}

@OverflowWrapping
public func div<T, Q>(s: T, m: Mat4x4<T, Q>): Mat4x4<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat4x4(Vec4<T, Q>(s / m.c0.x, s / m.c0.y, s / m.c0.z, s / m.c0.w), Vec4<T, Q>(s / m.c1.x, s / m.c1.y, s / m.c1.z, s / m.c1.w), Vec4<T, Q>(s / m.c2.x, s / m.c2.y, s / m.c2.z, s / m.c2.w), Vec4<T, Q>(s / m.c3.x, s / m.c3.y, s / m.c3.z, s / m.c3.w))
}
