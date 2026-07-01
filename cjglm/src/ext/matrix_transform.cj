package glm.ext
import glm.detail.{ Mat4x4, Vec2, Vec3, Vec4, Qualifier, dot, cross, normalize, sinT, cosT }
import std.math.{ FloatingPoint, Number }

public func translate<T, Q>(m: Mat4x4<T, Q>, v: Vec3<T, Q>): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    Mat4x4<T, Q>(
        Vec4<T, Q>(m.c0.x, m.c0.y, m.c0.z, m.c0.w),
        Vec4<T, Q>(m.c1.x, m.c1.y, m.c1.z, m.c1.w),
        Vec4<T, Q>(m.c2.x, m.c2.y, m.c2.z, m.c2.w),
        Vec4<T, Q>(m.c0.x * v.x + m.c1.x * v.y + m.c2.x * v.z + m.c3.x,
             m.c0.y * v.x + m.c1.y * v.y + m.c2.y * v.z + m.c3.y,
             m.c0.z * v.x + m.c1.z * v.y + m.c2.z * v.z + m.c3.z,
             m.c0.w * v.x + m.c1.w * v.y + m.c2.w * v.z + m.c3.w)
    )
}

public func rotate<T, Q>(m: Mat4x4<T, Q>, angle: T, axis: Vec3<T, Q>): Mat4x4<T, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let a = angle
    let c = cosT(a)
    let s = sinT(a)
    let zero = (Float64(0) as T).getOrThrow()
    let one = (Float64(1) as T).getOrThrow()
    let lenSq = dot(axis, axis)
    if (lenSq <= zero) {
        return m
    }
    let axisN = normalize(axis)
    let nx = axisN.x * (one - c)
    let ny = axisN.y * (one - c)
    let nz = axisN.z * (one - c)
    let Rot = Mat4x4<T, Q>(
        Vec4<T, Q>(nx * axisN.x + c, nx * axisN.y + s * axisN.z, nx * axisN.z - s * axisN.y, zero),
        Vec4<T, Q>(ny * axisN.x - s * axisN.z, ny * axisN.y + c, ny * axisN.z + s * axisN.x, zero),
        Vec4<T, Q>(nz * axisN.x + s * axisN.y, nz * axisN.y - s * axisN.x, nz * axisN.z + c, zero),
        Vec4<T, Q>(zero, zero, zero, one)
    )
    m * Rot
}

public func scale<T, Q>(m: Mat4x4<T, Q>, v: Vec3<T, Q>): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    let zero = (Float64(0) as T).getOrThrow()
    Mat4x4<T, Q>(
        Vec4<T, Q>(m.c0.x * v.x, m.c0.y * v.x, m.c0.z * v.x, m.c0.w * v.x),
        Vec4<T, Q>(m.c1.x * v.y, m.c1.y * v.y, m.c1.z * v.y, m.c1.w * v.y),
        Vec4<T, Q>(m.c2.x * v.z, m.c2.y * v.z, m.c2.z * v.z, m.c2.w * v.z),
        Vec4<T, Q>(m.c3.x, m.c3.y, m.c3.z, m.c3.w)
    )
}

public func shear<T, Q>(m: Mat4x4<T, Q>, p: Vec3<T, Q>, l_x: Vec2<T, Q>, l_y: Vec2<T, Q>, l_z: Vec2<T, Q>): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    let zero = (Float64(0) as T).getOrThrow()
    let one = (Float64(1) as T).getOrThrow()
    let H = Mat4x4<T, Q>(
        Vec4<T, Q>(one + l_x.x * p.x, l_x.y * p.x, zero, zero),
        Vec4<T, Q>(l_y.x * p.y, one + l_y.y * p.y, zero, zero),
        Vec4<T, Q>(l_z.x * p.z, l_z.y * p.z, one, zero),
        Vec4<T, Q>(zero, zero, zero, one)
    )
    m * H
}

public func lookAtRH<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let f = normalize(Vec3<T, Q>(center.x - eye.x, center.y - eye.y, center.z - eye.z))
    let s = normalize(cross(f, up))
    let u = cross(s, f)
    let zero = (Float64(0) as T).getOrThrow()
    let one = (Float64(1) as T).getOrThrow()
    Mat4x4<T, Q>(
        Vec4<T, Q>(s.x, u.x, -f.x, zero),
        Vec4<T, Q>(s.y, u.y, -f.y, zero),
        Vec4<T, Q>(s.z, u.z, -f.z, zero),
        Vec4<T, Q>(-dot(s, eye), -dot(u, eye), dot(f, eye), one)
    )
}

public func lookAtLH<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let f = normalize(Vec3<T, Q>(eye.x - center.x, eye.y - center.y, eye.z - center.z))
    let s = normalize(cross(f, up))
    let u = cross(s, f)
    let zero = (Float64(0) as T).getOrThrow()
    let one = (Float64(1) as T).getOrThrow()
    Mat4x4<T, Q>(
        Vec4<T, Q>(s.x, u.x, -f.x, zero),
        Vec4<T, Q>(s.y, u.y, -f.y, zero),
        Vec4<T, Q>(s.z, u.z, -f.z, zero),
        Vec4<T, Q>(-dot(s, eye), -dot(u, eye), dot(f, eye), one)
    )
}

public func lookAt<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    lookAtRH(eye, center, up)
}
