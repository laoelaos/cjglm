package glm.gtc
import glm.detail.{ Mat3x3, Mat4x4, Vec3, Vec4, Qualifier, inverse, transpose }
import std.math.FloatingPoint

public func affineInverse<T, Q>(m: Mat4x4<T, Q>): Mat4x4<T, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let m3 = Mat3x3<T, Q>(
        Vec3<T, Q>(m.c0.x, m.c0.y, m.c0.z),
        Vec3<T, Q>(m.c1.x, m.c1.y, m.c1.z),
        Vec3<T, Q>(m.c2.x, m.c2.y, m.c2.z)
    )
    let invM3 = inverse(m3)
    let v = Vec3<T, Q>(m.c3.x, m.c3.y, m.c3.z)
    let invTrans = Vec3<T, Q>(
        invM3.c0.x * v.x + invM3.c1.x * v.y + invM3.c2.x * v.z,
        invM3.c0.y * v.x + invM3.c1.y * v.y + invM3.c2.y * v.z,
        invM3.c0.z * v.x + invM3.c1.z * v.y + invM3.c2.z * v.z
    )
    let zero = (Float64(0) as T).getOrThrow()
    let one = (Float64(1) as T).getOrThrow()
    Mat4x4<T, Q>(
        Vec4<T, Q>(invM3.c0.x, invM3.c0.y, invM3.c0.z, zero),
        Vec4<T, Q>(invM3.c1.x, invM3.c1.y, invM3.c1.z, zero),
        Vec4<T, Q>(invM3.c2.x, invM3.c2.y, invM3.c2.z, zero),
        Vec4<T, Q>(-invTrans.x, -invTrans.y, -invTrans.z, one)
    )
}

public func inverseTranspose<T, Q>(m: Mat3x3<T, Q>): Mat3x3<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    transpose(inverse(m))
}

public func inverseTranspose<T, Q>(m: Mat4x4<T, Q>): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    transpose(inverse(m))
}
