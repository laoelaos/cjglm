package glm.detail

import std.math.{ Number, FloatingPoint }

public func transpose<T, Q>(m: Mat2x2<T, Q>): Mat2x2<T, Q> where Q <: Qualifier {
    Mat2x2<T, Q>(Vec2<T, Q>(m.c0.x, m.c1.x), Vec2<T, Q>(m.c0.y, m.c1.y))
}

public func transpose<T, Q>(m: Mat2x3<T, Q>): Mat3x2<T, Q> where Q <: Qualifier {
    Mat3x2<T, Q>(Vec2<T, Q>(m.c0.x, m.c1.x), Vec2<T, Q>(m.c0.y, m.c1.y), Vec2<T, Q>(m.c0.z, m.c1.z))
}

public func transpose<T, Q>(m: Mat2x4<T, Q>): Mat4x2<T, Q> where Q <: Qualifier {
    Mat4x2<T, Q>(Vec2<T, Q>(m.c0.x, m.c1.x), Vec2<T, Q>(m.c0.y, m.c1.y), Vec2<T, Q>(m.c0.z, m.c1.z), Vec2<T, Q>(m.c0.w, m.c1.w))
}

public func transpose<T, Q>(m: Mat3x2<T, Q>): Mat2x3<T, Q> where Q <: Qualifier {
    Mat2x3<T, Q>(Vec3<T, Q>(m.c0.x, m.c1.x, m.c2.x), Vec3<T, Q>(m.c0.y, m.c1.y, m.c2.y))
}

public func transpose<T, Q>(m: Mat3x3<T, Q>): Mat3x3<T, Q> where Q <: Qualifier {
    Mat3x3<T, Q>(Vec3<T, Q>(m.c0.x, m.c1.x, m.c2.x), Vec3<T, Q>(m.c0.y, m.c1.y, m.c2.y), Vec3<T, Q>(m.c0.z, m.c1.z, m.c2.z))
}

public func transpose<T, Q>(m: Mat3x4<T, Q>): Mat4x3<T, Q> where Q <: Qualifier {
    Mat4x3<T, Q>(Vec3<T, Q>(m.c0.x, m.c1.x, m.c2.x), Vec3<T, Q>(m.c0.y, m.c1.y, m.c2.y), Vec3<T, Q>(m.c0.z, m.c1.z, m.c2.z), Vec3<T, Q>(m.c0.w, m.c1.w, m.c2.w))
}

public func transpose<T, Q>(m: Mat4x2<T, Q>): Mat2x4<T, Q> where Q <: Qualifier {
    Mat2x4<T, Q>(Vec4<T, Q>(m.c0.x, m.c1.x, m.c2.x, m.c3.x), Vec4<T, Q>(m.c0.y, m.c1.y, m.c2.y, m.c3.y))
}

public func transpose<T, Q>(m: Mat4x3<T, Q>): Mat3x4<T, Q> where Q <: Qualifier {
    Mat3x4<T, Q>(Vec4<T, Q>(m.c0.x, m.c1.x, m.c2.x, m.c3.x), Vec4<T, Q>(m.c0.y, m.c1.y, m.c2.y, m.c3.y), Vec4<T, Q>(m.c0.z, m.c1.z, m.c2.z, m.c3.z))
}

public func transpose<T, Q>(m: Mat4x4<T, Q>): Mat4x4<T, Q> where Q <: Qualifier {
    Mat4x4<T, Q>(Vec4<T, Q>(m.c0.x, m.c1.x, m.c2.x, m.c3.x), Vec4<T, Q>(m.c0.y, m.c1.y, m.c2.y, m.c3.y), Vec4<T, Q>(m.c0.z, m.c1.z, m.c2.z, m.c3.z), Vec4<T, Q>(m.c0.w, m.c1.w, m.c2.w, m.c3.w))
}

public func matrixCompMult<T, Q>(x: Mat2x2<T, Q>, y: Mat2x2<T, Q>): Mat2x2<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat2x2<T, Q>(Vec2<T, Q>(x.c0.x * y.c0.x, x.c0.y * y.c0.y),
                 Vec2<T, Q>(x.c1.x * y.c1.x, x.c1.y * y.c1.y))
}

public func matrixCompMult<T, Q>(x: Mat2x3<T, Q>, y: Mat2x3<T, Q>): Mat2x3<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat2x3<T, Q>(Vec3<T, Q>(x.c0.x * y.c0.x, x.c0.y * y.c0.y, x.c0.z * y.c0.z),
                 Vec3<T, Q>(x.c1.x * y.c1.x, x.c1.y * y.c1.y, x.c1.z * y.c1.z))
}

public func matrixCompMult<T, Q>(x: Mat2x4<T, Q>, y: Mat2x4<T, Q>): Mat2x4<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat2x4<T, Q>(Vec4<T, Q>(x.c0.x * y.c0.x, x.c0.y * y.c0.y, x.c0.z * y.c0.z, x.c0.w * y.c0.w),
                 Vec4<T, Q>(x.c1.x * y.c1.x, x.c1.y * y.c1.y, x.c1.z * y.c1.z, x.c1.w * y.c1.w))
}

public func matrixCompMult<T, Q>(x: Mat3x2<T, Q>, y: Mat3x2<T, Q>): Mat3x2<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat3x2<T, Q>(Vec2<T, Q>(x.c0.x * y.c0.x, x.c0.y * y.c0.y),
                 Vec2<T, Q>(x.c1.x * y.c1.x, x.c1.y * y.c1.y),
                 Vec2<T, Q>(x.c2.x * y.c2.x, x.c2.y * y.c2.y))
}

public func matrixCompMult<T, Q>(x: Mat3x3<T, Q>, y: Mat3x3<T, Q>): Mat3x3<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat3x3<T, Q>(Vec3<T, Q>(x.c0.x * y.c0.x, x.c0.y * y.c0.y, x.c0.z * y.c0.z),
                 Vec3<T, Q>(x.c1.x * y.c1.x, x.c1.y * y.c1.y, x.c1.z * y.c1.z),
                 Vec3<T, Q>(x.c2.x * y.c2.x, x.c2.y * y.c2.y, x.c2.z * y.c2.z))
}

public func matrixCompMult<T, Q>(x: Mat3x4<T, Q>, y: Mat3x4<T, Q>): Mat3x4<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat3x4<T, Q>(Vec4<T, Q>(x.c0.x * y.c0.x, x.c0.y * y.c0.y, x.c0.z * y.c0.z, x.c0.w * y.c0.w),
                 Vec4<T, Q>(x.c1.x * y.c1.x, x.c1.y * y.c1.y, x.c1.z * y.c1.z, x.c1.w * y.c1.w),
                 Vec4<T, Q>(x.c2.x * y.c2.x, x.c2.y * y.c2.y, x.c2.z * y.c2.z, x.c2.w * y.c2.w))
}

public func matrixCompMult<T, Q>(x: Mat4x2<T, Q>, y: Mat4x2<T, Q>): Mat4x2<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat4x2<T, Q>(Vec2<T, Q>(x.c0.x * y.c0.x, x.c0.y * y.c0.y),
                 Vec2<T, Q>(x.c1.x * y.c1.x, x.c1.y * y.c1.y),
                 Vec2<T, Q>(x.c2.x * y.c2.x, x.c2.y * y.c2.y),
                 Vec2<T, Q>(x.c3.x * y.c3.x, x.c3.y * y.c3.y))
}

public func matrixCompMult<T, Q>(x: Mat4x3<T, Q>, y: Mat4x3<T, Q>): Mat4x3<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat4x3<T, Q>(Vec3<T, Q>(x.c0.x * y.c0.x, x.c0.y * y.c0.y, x.c0.z * y.c0.z),
                 Vec3<T, Q>(x.c1.x * y.c1.x, x.c1.y * y.c1.y, x.c1.z * y.c1.z),
                 Vec3<T, Q>(x.c2.x * y.c2.x, x.c2.y * y.c2.y, x.c2.z * y.c2.z),
                 Vec3<T, Q>(x.c3.x * y.c3.x, x.c3.y * y.c3.y, x.c3.z * y.c3.z))
}

public func matrixCompMult<T, Q>(x: Mat4x4<T, Q>, y: Mat4x4<T, Q>): Mat4x4<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat4x4<T, Q>(Vec4<T, Q>(x.c0.x * y.c0.x, x.c0.y * y.c0.y, x.c0.z * y.c0.z, x.c0.w * y.c0.w),
                 Vec4<T, Q>(x.c1.x * y.c1.x, x.c1.y * y.c1.y, x.c1.z * y.c1.z, x.c1.w * y.c1.w),
                 Vec4<T, Q>(x.c2.x * y.c2.x, x.c2.y * y.c2.y, x.c2.z * y.c2.z, x.c2.w * y.c2.w),
                 Vec4<T, Q>(x.c3.x * y.c3.x, x.c3.y * y.c3.y, x.c3.z * y.c3.z, x.c3.w * y.c3.w))
}

public func outerProduct<T, Q>(c: Vec2<T, Q>, r: Vec2<T, Q>): Mat2x2<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat2x2<T, Q>(Vec2<T, Q>(c.x * r.x, c.y * r.x),
                 Vec2<T, Q>(c.x * r.y, c.y * r.y))
}

public func outerProduct<T, Q>(c: Vec2<T, Q>, r: Vec3<T, Q>): Mat3x2<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat3x2<T, Q>(Vec2<T, Q>(c.x * r.x, c.y * r.x),
                 Vec2<T, Q>(c.x * r.y, c.y * r.y),
                 Vec2<T, Q>(c.x * r.z, c.y * r.z))
}

public func outerProduct<T, Q>(c: Vec2<T, Q>, r: Vec4<T, Q>): Mat4x2<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat4x2<T, Q>(Vec2<T, Q>(c.x * r.x, c.y * r.x),
                 Vec2<T, Q>(c.x * r.y, c.y * r.y),
                 Vec2<T, Q>(c.x * r.z, c.y * r.z),
                 Vec2<T, Q>(c.x * r.w, c.y * r.w))
}

public func outerProduct<T, Q>(c: Vec3<T, Q>, r: Vec2<T, Q>): Mat2x3<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat2x3<T, Q>(Vec3<T, Q>(c.x * r.x, c.y * r.x, c.z * r.x),
                 Vec3<T, Q>(c.x * r.y, c.y * r.y, c.z * r.y))
}

public func outerProduct<T, Q>(c: Vec3<T, Q>, r: Vec3<T, Q>): Mat3x3<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat3x3<T, Q>(Vec3<T, Q>(c.x * r.x, c.y * r.x, c.z * r.x),
                 Vec3<T, Q>(c.x * r.y, c.y * r.y, c.z * r.y),
                 Vec3<T, Q>(c.x * r.z, c.y * r.z, c.z * r.z))
}

public func outerProduct<T, Q>(c: Vec3<T, Q>, r: Vec4<T, Q>): Mat4x3<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat4x3<T, Q>(Vec3<T, Q>(c.x * r.x, c.y * r.x, c.z * r.x),
                 Vec3<T, Q>(c.x * r.y, c.y * r.y, c.z * r.y),
                 Vec3<T, Q>(c.x * r.z, c.y * r.z, c.z * r.z),
                 Vec3<T, Q>(c.x * r.w, c.y * r.w, c.z * r.w))
}

public func outerProduct<T, Q>(c: Vec4<T, Q>, r: Vec2<T, Q>): Mat2x4<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat2x4<T, Q>(Vec4<T, Q>(c.x * r.x, c.y * r.x, c.z * r.x, c.w * r.x),
                 Vec4<T, Q>(c.x * r.y, c.y * r.y, c.z * r.y, c.w * r.y))
}

public func outerProduct<T, Q>(c: Vec4<T, Q>, r: Vec3<T, Q>): Mat3x4<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat3x4<T, Q>(Vec4<T, Q>(c.x * r.x, c.y * r.x, c.z * r.x, c.w * r.x),
                 Vec4<T, Q>(c.x * r.y, c.y * r.y, c.z * r.y, c.w * r.y),
                 Vec4<T, Q>(c.x * r.z, c.y * r.z, c.z * r.z, c.w * r.z))
}

public func outerProduct<T, Q>(c: Vec4<T, Q>, r: Vec4<T, Q>): Mat4x4<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat4x4<T, Q>(Vec4<T, Q>(c.x * r.x, c.y * r.x, c.z * r.x, c.w * r.x),
                 Vec4<T, Q>(c.x * r.y, c.y * r.y, c.z * r.y, c.w * r.y),
                 Vec4<T, Q>(c.x * r.z, c.y * r.z, c.z * r.z, c.w * r.z),
                 Vec4<T, Q>(c.x * r.w, c.y * r.w, c.z * r.w, c.w * r.w))
}

public func determinant<T, Q>(m: Mat2x2<T, Q>): T where T <: Number<T>, Q <: Qualifier {
    m.c0.x * m.c1.y - m.c1.x * m.c0.y
}

public func determinant<T, Q>(m: Mat3x3<T, Q>): T where T <: Number<T>, Q <: Qualifier {
    m.c0.x * (m.c1.y * m.c2.z - m.c2.y * m.c1.z)
    - m.c1.x * (m.c0.y * m.c2.z - m.c2.y * m.c0.z)
    + m.c2.x * (m.c0.y * m.c1.z - m.c1.y * m.c0.z)
}

public func determinant<T, Q>(m: Mat4x4<T, Q>): T where T <: Number<T>, Q <: Qualifier {
    let SubFactor00 = m.c2.z * m.c3.w - m.c3.z * m.c2.w
    let SubFactor01 = m.c2.y * m.c3.w - m.c3.y * m.c2.w
    let SubFactor02 = m.c2.y * m.c3.z - m.c3.y * m.c2.z
    let SubFactor03 = m.c2.x * m.c3.w - m.c3.x * m.c2.w
    let SubFactor04 = m.c2.x * m.c3.z - m.c3.x * m.c2.z
    let SubFactor05 = m.c2.x * m.c3.y - m.c3.x * m.c2.y
    m.c0.x * (m.c1.y * SubFactor00 - m.c1.z * SubFactor01 + m.c1.w * SubFactor02)
    - m.c0.y * (m.c1.x * SubFactor00 - m.c1.z * SubFactor03 + m.c1.w * SubFactor04)
    + m.c0.z * (m.c1.x * SubFactor01 - m.c1.y * SubFactor03 + m.c1.w * SubFactor05)
    - m.c0.w * (m.c1.x * SubFactor02 - m.c1.y * SubFactor04 + m.c1.z * SubFactor05)
}

public func inverse<T, Q>(m: Mat2x2<T, Q>): Mat2x2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    let det = determinant(m)
    let one: T = (Float64(1) as T).getOrThrow()
    let invDet = one / det
    Mat2x2<T, Q>(Vec2<T, Q>(m.c1.y * invDet, -m.c0.y * invDet),
                 Vec2<T, Q>(-m.c1.x * invDet, m.c0.x * invDet))
}

public func inverse<T, Q>(m: Mat3x3<T, Q>): Mat3x3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    let det = determinant(m)
    let one: T = (Float64(1) as T).getOrThrow()
    let invDet = one / det
    Mat3x3<T, Q>(
        Vec3<T, Q>((m.c1.y * m.c2.z - m.c2.y * m.c1.z) * invDet,
             -(m.c1.x * m.c2.z - m.c2.x * m.c1.z) * invDet,
             (m.c1.x * m.c2.y - m.c2.x * m.c1.y) * invDet),
        Vec3<T, Q>(-(m.c0.y * m.c2.z - m.c2.y * m.c0.z) * invDet,
             (m.c0.x * m.c2.z - m.c2.x * m.c0.z) * invDet,
             -(m.c0.x * m.c2.y - m.c2.x * m.c0.y) * invDet),
        Vec3<T, Q>((m.c0.y * m.c1.z - m.c1.y * m.c0.z) * invDet,
             -(m.c0.x * m.c1.z - m.c1.x * m.c0.z) * invDet,
             (m.c0.x * m.c1.y - m.c1.x * m.c0.y) * invDet)
    )
}

public func inverse<T, Q>(m: Mat4x4<T, Q>): Mat4x4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    let SubFactor00 = m.c2.z * m.c3.w - m.c3.z * m.c2.w
    let SubFactor01 = m.c2.y * m.c3.w - m.c3.y * m.c2.w
    let SubFactor02 = m.c2.y * m.c3.z - m.c3.y * m.c2.z
    let SubFactor03 = m.c2.x * m.c3.w - m.c3.x * m.c2.w
    let SubFactor04 = m.c2.x * m.c3.z - m.c3.x * m.c2.z
    let SubFactor05 = m.c2.x * m.c3.y - m.c3.x * m.c2.y
    let SubFactor06 = m.c1.z * m.c3.w - m.c3.z * m.c1.w
    let SubFactor07 = m.c1.y * m.c3.w - m.c3.y * m.c1.w
    let SubFactor08 = m.c1.y * m.c3.z - m.c3.y * m.c1.z
    let SubFactor09 = m.c1.x * m.c3.w - m.c3.x * m.c1.w
    let SubFactor10 = m.c1.x * m.c3.z - m.c3.x * m.c1.z
    let SubFactor11 = m.c1.x * m.c3.y - m.c3.x * m.c1.y
    let SubFactor12 = m.c1.z * m.c2.w - m.c2.z * m.c1.w
    let SubFactor13 = m.c1.y * m.c2.w - m.c2.y * m.c1.w
    let SubFactor14 = m.c1.y * m.c2.z - m.c2.y * m.c1.z
    let SubFactor15 = m.c1.x * m.c2.w - m.c2.x * m.c1.w
    let SubFactor16 = m.c1.x * m.c2.z - m.c2.x * m.c1.z
    let SubFactor17 = m.c1.x * m.c2.y - m.c2.x * m.c1.y
    let det = determinant(m)
    let one: T = (Float64(1) as T).getOrThrow()
    let invDet = one / det
    Mat4x4<T, Q>(
        Vec4<T, Q>(
            ( m.c1.y * SubFactor00 - m.c1.z * SubFactor01 + m.c1.w * SubFactor02) * invDet,
            (-m.c1.x * SubFactor00 + m.c1.z * SubFactor03 - m.c1.w * SubFactor04) * invDet,
            ( m.c1.x * SubFactor01 - m.c1.y * SubFactor03 + m.c1.w * SubFactor05) * invDet,
            (-m.c1.x * SubFactor02 + m.c1.y * SubFactor04 - m.c1.z * SubFactor05) * invDet
        ),
        Vec4<T, Q>(
            (-m.c0.y * SubFactor00 + m.c0.z * SubFactor01 - m.c0.w * SubFactor02) * invDet,
            ( m.c0.x * SubFactor00 - m.c0.z * SubFactor03 + m.c0.w * SubFactor04) * invDet,
            (-m.c0.x * SubFactor01 + m.c0.y * SubFactor03 - m.c0.w * SubFactor05) * invDet,
            ( m.c0.x * SubFactor02 - m.c0.y * SubFactor04 + m.c0.z * SubFactor05) * invDet
        ),
        Vec4<T, Q>(
            ( m.c0.y * SubFactor06 - m.c0.z * SubFactor07 + m.c0.w * SubFactor08) * invDet,
            (-m.c0.x * SubFactor06 + m.c0.z * SubFactor09 - m.c0.w * SubFactor10) * invDet,
            ( m.c0.x * SubFactor07 - m.c0.y * SubFactor09 + m.c0.w * SubFactor11) * invDet,
            (-m.c0.x * SubFactor08 + m.c0.y * SubFactor10 - m.c0.z * SubFactor11) * invDet
        ),
        Vec4<T, Q>(
            (-m.c0.y * SubFactor12 + m.c0.z * SubFactor13 - m.c0.w * SubFactor14) * invDet,
            ( m.c0.x * SubFactor12 - m.c0.z * SubFactor15 + m.c0.w * SubFactor16) * invDet,
            (-m.c0.x * SubFactor13 + m.c0.y * SubFactor15 - m.c0.w * SubFactor17) * invDet,
            ( m.c0.x * SubFactor14 - m.c0.y * SubFactor16 + m.c0.z * SubFactor17) * invDet
        )
    )
}
