package glm.detail

import std.math.{ Number, FloatingPoint }

public func dot<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>): T where T <: Number<T>, Q <: Qualifier {
    x.x * y.x
}
public func dot<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>): T where T <: Number<T>, Q <: Qualifier {
    x.x * y.x + x.y * y.y
}
public func dot<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>): T where T <: Number<T>, Q <: Qualifier {
    x.x * y.x + x.y * y.y + x.z * y.z
}
public func dot<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>): T where T <: Number<T>, Q <: Qualifier {
    x.x * y.x + x.y * y.y + x.z * y.z + x.w * y.w
}
public func cross<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T>, Q <: Qualifier {
    Vec3(x.y * y.z - y.y * x.z, x.z * y.x - y.z * x.x, x.x * y.y - y.x * x.y)
}
public func normalize<T, Q>(v: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    v * inversesqrt(dot(v, v))
}
public func normalize<T, Q>(v: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let zero = (Float64(0) as T).getOrThrow()
    let lenSq = dot(v, v)
    if (lenSq <= zero) {
        Vec2(zero, zero)
    } else {
        v / sqrtT(lenSq)
    }
}
public func normalize<T, Q>(v: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let zero = (Float64(0) as T).getOrThrow()
    let lenSq = dot(v, v)
    if (lenSq <= zero) {
        Vec3(zero, zero, zero)
    } else {
        v / sqrtT(lenSq)
    }
}
public func normalize<T, Q>(v: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let zero = (Float64(0) as T).getOrThrow()
    let lenSq = dot(v, v)
    if (lenSq <= zero) {
        Vec4(zero, zero, zero, zero)
    } else {
        v / sqrtT(lenSq)
    }
}
public func length<T, Q>(v: Vec2<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier {
    sqrtT(dot(v, v))
}
public func length<T, Q>(v: Vec3<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier {
    sqrtT(dot(v, v))
}
public func length<T, Q>(v: Vec4<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier {
    sqrtT(dot(v, v))
}
public func distance<T, Q>(p0: Vec2<T, Q>, p1: Vec2<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier {
    length(p0 - p1)
}
public func distance<T, Q>(p0: Vec3<T, Q>, p1: Vec3<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier {
    length(p0 - p1)
}
public func distance<T, Q>(p0: Vec4<T, Q>, p1: Vec4<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier {
    length(p0 - p1)
}
public func reflect<T, Q>(I: Vec2<T, Q>, N: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    I - N * ((Float64(2) as T).getOrThrow() * dot(N, I))
}
public func reflect<T, Q>(I: Vec3<T, Q>, N: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    I - N * ((Float64(2) as T).getOrThrow() * dot(N, I))
}
public func reflect<T, Q>(I: Vec4<T, Q>, N: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    I - N * ((Float64(2) as T).getOrThrow() * dot(N, I))
}
public func refract<T, Q>(I: Vec2<T, Q>, N: Vec2<T, Q>, eta: T): Vec2<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let one = (Float64(1) as T).getOrThrow()
    let zero = (Float64(0) as T).getOrThrow()
    let dNI = dot(N, I)
    let k = one - eta * eta * (one - dNI * dNI)
    if (k < zero) {
        Vec2(zero, zero)
    } else {
        I * eta - N * (eta * dNI + sqrtT(k))
    }
}
public func refract<T, Q>(I: Vec3<T, Q>, N: Vec3<T, Q>, eta: T): Vec3<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let one = (Float64(1) as T).getOrThrow()
    let zero = (Float64(0) as T).getOrThrow()
    let dNI = dot(N, I)
    let k = one - eta * eta * (one - dNI * dNI)
    if (k < zero) {
        Vec3(zero, zero, zero)
    } else {
        I * eta - N * (eta * dNI + sqrtT(k))
    }
}
public func refract<T, Q>(I: Vec4<T, Q>, N: Vec4<T, Q>, eta: T): Vec4<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let one = (Float64(1) as T).getOrThrow()
    let zero = (Float64(0) as T).getOrThrow()
    let dNI = dot(N, I)
    let k = one - eta * eta * (one - dNI * dNI)
    if (k < zero) {
        Vec4(zero, zero, zero, zero)
    } else {
        I * eta - N * (eta * dNI + sqrtT(k))
    }
}
public func faceforward<T, Q>(N: Vec2<T, Q>, I: Vec2<T, Q>, Nref: Vec2<T, Q>): Vec2<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    let zero = (Float64(0) as T).getOrThrow()
    if (dot(Nref, I) < zero) { N } else { -N }
}
public func faceforward<T, Q>(N: Vec3<T, Q>, I: Vec3<T, Q>, Nref: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    let zero = (Float64(0) as T).getOrThrow()
    if (dot(Nref, I) < zero) { N } else { -N }
}
public func faceforward<T, Q>(N: Vec4<T, Q>, I: Vec4<T, Q>, Nref: Vec4<T, Q>): Vec4<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    let zero = (Float64(0) as T).getOrThrow()
    if (dot(Nref, I) < zero) { N } else { -N }
}
