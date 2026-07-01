package glm.gtc
import glm.detail.{ Mat4x4, Vec2, Vec3, Vec4, Qualifier, sinT, cosT, normalize }
public import glm.ext.*
import std.math.FloatingPoint

func mat4Mul<T, Q>(a: Mat4x4<T, Q>, b: Mat4x4<T, Q>): Mat4x4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Mat4x4<T, Q>(
        Vec4<T, Q>(a.c0.x * b.c0.x + a.c1.x * b.c0.y + a.c2.x * b.c0.z + a.c3.x * b.c0.w, a.c0.y * b.c0.x + a.c1.y * b.c0.y + a.c2.y * b.c0.z + a.c3.y * b.c0.w, a.c0.z * b.c0.x + a.c1.z * b.c0.y + a.c2.z * b.c0.z + a.c3.z * b.c0.w, a.c0.w * b.c0.x + a.c1.w * b.c0.y + a.c2.w * b.c0.z + a.c3.w * b.c0.w),
        Vec4<T, Q>(a.c0.x * b.c1.x + a.c1.x * b.c1.y + a.c2.x * b.c1.z + a.c3.x * b.c1.w, a.c0.y * b.c1.x + a.c1.y * b.c1.y + a.c2.y * b.c1.z + a.c3.y * b.c1.w, a.c0.z * b.c1.x + a.c1.z * b.c1.y + a.c2.z * b.c1.z + a.c3.z * b.c1.w, a.c0.w * b.c1.x + a.c1.w * b.c1.y + a.c2.w * b.c1.z + a.c3.w * b.c1.w),
        Vec4<T, Q>(a.c0.x * b.c2.x + a.c1.x * b.c2.y + a.c2.x * b.c2.z + a.c3.x * b.c2.w, a.c0.y * b.c2.x + a.c1.y * b.c2.y + a.c2.y * b.c2.z + a.c3.y * b.c2.w, a.c0.z * b.c2.x + a.c1.z * b.c2.y + a.c2.z * b.c2.z + a.c3.z * b.c2.w, a.c0.w * b.c2.x + a.c1.w * b.c2.y + a.c2.w * b.c2.z + a.c3.w * b.c2.w),
        Vec4<T, Q>(a.c0.x * b.c3.x + a.c1.x * b.c3.y + a.c2.x * b.c3.z + a.c3.x * b.c3.w, a.c0.y * b.c3.x + a.c1.y * b.c3.y + a.c2.y * b.c3.z + a.c3.y * b.c3.w, a.c0.z * b.c3.x + a.c1.z * b.c3.y + a.c2.z * b.c3.z + a.c3.z * b.c3.w, a.c0.w * b.c3.x + a.c1.w * b.c3.y + a.c2.w * b.c3.z + a.c3.w * b.c3.w)
    )
}

// identity 仅本层提供
public func identity<T, Q>(): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    let zero = (Float64(0) as T).getOrThrow()
    let one = (Float64(1) as T).getOrThrow()
    Mat4x4<T, Q>(
        Vec4<T, Q>(one, zero, zero, zero),
        Vec4<T, Q>(zero, one, zero, zero),
        Vec4<T, Q>(zero, zero, one, zero),
        Vec4<T, Q>(zero, zero, zero, one)
    )
}

// shear — gtc API 不同（n: Vec3, s: T）
public func shear<T, Q>(m: Mat4x4<T, Q>, n: Vec3<T, Q>, s: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    let zero = (Float64(0) as T).getOrThrow()
    let one = (Float64(1) as T).getOrThrow()
    let H = Mat4x4<T, Q>(
        Vec4<T, Q>(one + s * n.x * n.x, s * n.y * n.x, s * n.z * n.x, zero),
        Vec4<T, Q>(s * n.x * n.y, one + s * n.y * n.y, s * n.z * n.y, zero),
        Vec4<T, Q>(s * n.x * n.z, s * n.y * n.z, one + s * n.z * n.z, zero),
        Vec4<T, Q>(zero, zero, zero, one)
    )
    mat4Mul(H, m)
}

// slow 变体
public func rotate_slow<T, Q>(m: Mat4x4<T, Q>, angle: T, axis: Vec3<T, Q>): Mat4x4<T, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let a = angle
    let axisN = normalize(axis)
    let s = sinT(a)
    let c = cosT(a)
    let one_c = (Float64(1) as T).getOrThrow() - c
    let x = axisN.x
    let y = axisN.y
    let z = axisN.z
    let zero = (Float64(0) as T).getOrThrow()
    let one = (Float64(1) as T).getOrThrow()
    let Rot = Mat4x4<T, Q>(
        Vec4<T, Q>(c + x*x*one_c, y*x*one_c + z*s, z*x*one_c - y*s, zero),
        Vec4<T, Q>(x*y*one_c - z*s, c + y*y*one_c, z*y*one_c + x*s, zero),
        Vec4<T, Q>(x*z*one_c + y*s, y*z*one_c - x*s, c + z*z*one_c, zero),
        Vec4<T, Q>(zero, zero, zero, one)
    )
    mat4Mul(Rot, m)
}

public func scale_slow<T, Q>(m: Mat4x4<T, Q>, v: Vec3<T, Q>): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    let zero = (Float64(0) as T).getOrThrow()
    let one = (Float64(1) as T).getOrThrow()
    let S = Mat4x4<T, Q>(
        Vec4<T, Q>(v.x, zero, zero, zero),
        Vec4<T, Q>(zero, v.y, zero, zero),
        Vec4<T, Q>(zero, zero, v.z, zero),
        Vec4<T, Q>(zero, zero, zero, one)
    )
    mat4Mul(S, m)
}

public func shear_slow<T, Q>(m: Mat4x4<T, Q>, n: Vec3<T, Q>, s: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    let zero = (Float64(0) as T).getOrThrow()
    let one = (Float64(1) as T).getOrThrow()
    let H = Mat4x4<T, Q>(
        Vec4<T, Q>(one + s * n.x * n.x, s * n.y * n.x, s * n.z * n.x, zero),
        Vec4<T, Q>(s * n.x * n.y, one + s * n.y * n.y, s * n.z * n.y, zero),
        Vec4<T, Q>(s * n.x * n.z, s * n.y * n.z, one + s * n.z * n.z, zero),
        Vec4<T, Q>(zero, zero, zero, one)
    )
    mat4Mul(H, m)
}

// 其余函数（translate/rotate/scale/lookAt/ortho/frustum/perspective/.../pickMatrix）
// 均通过 import glm.ext.* 直接由 ext 层提供
