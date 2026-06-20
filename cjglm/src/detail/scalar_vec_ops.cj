package glm.detail

import std.math.{ Number, Integer, fmod }

@OverflowWrapping
public func add<T, Q>(s: T, v: Vec1<T, Q>): Vec1<T, Q> where T <: Number<T>, Q <: Qualifier {
    return Vec1(s + v.x)
}

@OverflowWrapping
public func add<T, Q>(s: T, v: Vec2<T, Q>): Vec2<T, Q> where T <: Number<T>, Q <: Qualifier {
    return Vec2(s + v.x, s + v.y)
}

@OverflowWrapping
public func add<T, Q>(s: T, v: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T>, Q <: Qualifier {
    return Vec3(s + v.x, s + v.y, s + v.z)
}

@OverflowWrapping
public func add<T, Q>(s: T, v: Vec4<T, Q>): Vec4<T, Q> where T <: Number<T>, Q <: Qualifier {
    return Vec4(s + v.x, s + v.y, s + v.z, s + v.w)
}

@OverflowWrapping
public func sub<T, Q>(s: T, v: Vec1<T, Q>): Vec1<T, Q> where T <: Number<T>, Q <: Qualifier {
    return Vec1(s - v.x)
}

@OverflowWrapping
public func sub<T, Q>(s: T, v: Vec2<T, Q>): Vec2<T, Q> where T <: Number<T>, Q <: Qualifier {
    return Vec2(s - v.x, s - v.y)
}

@OverflowWrapping
public func sub<T, Q>(s: T, v: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T>, Q <: Qualifier {
    return Vec3(s - v.x, s - v.y, s - v.z)
}

@OverflowWrapping
public func sub<T, Q>(s: T, v: Vec4<T, Q>): Vec4<T, Q> where T <: Number<T>, Q <: Qualifier {
    return Vec4(s - v.x, s - v.y, s - v.z, s - v.w)
}

@OverflowWrapping
public func mul<T, Q>(s: T, v: Vec1<T, Q>): Vec1<T, Q> where T <: Number<T>, Q <: Qualifier {
    return Vec1(s * v.x)
}

@OverflowWrapping
public func mul<T, Q>(s: T, v: Vec2<T, Q>): Vec2<T, Q> where T <: Number<T>, Q <: Qualifier {
    return Vec2(s * v.x, s * v.y)
}

@OverflowWrapping
public func mul<T, Q>(s: T, v: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T>, Q <: Qualifier {
    return Vec3(s * v.x, s * v.y, s * v.z)
}

@OverflowWrapping
public func mul<T, Q>(s: T, v: Vec4<T, Q>): Vec4<T, Q> where T <: Number<T>, Q <: Qualifier {
    return Vec4(s * v.x, s * v.y, s * v.z, s * v.w)
}

@OverflowWrapping
public func div<T, Q>(s: T, v: Vec1<T, Q>): Vec1<T, Q> where T <: Number<T>, Q <: Qualifier {
    return Vec1(s / v.x)
}

@OverflowWrapping
public func div<T, Q>(s: T, v: Vec2<T, Q>): Vec2<T, Q> where T <: Number<T>, Q <: Qualifier {
    return Vec2(s / v.x, s / v.y)
}

@OverflowWrapping
public func div<T, Q>(s: T, v: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T>, Q <: Qualifier {
    return Vec3(s / v.x, s / v.y, s / v.z)
}

@OverflowWrapping
public func div<T, Q>(s: T, v: Vec4<T, Q>): Vec4<T, Q> where T <: Number<T>, Q <: Qualifier {
    return Vec4(s / v.x, s / v.y, s / v.z, s / v.w)
}

@OverflowWrapping
public func mod<T, Q>(s: T, v: Vec1<T, Q>): Vec1<T, Q> where T <: Integer<T>, Q <: Qualifier {
    return Vec1(s % v.x)
}

@OverflowWrapping
public func mod<T, Q>(s: T, v: Vec2<T, Q>): Vec2<T, Q> where T <: Integer<T>, Q <: Qualifier {
    return Vec2(s % v.x, s % v.y)
}

@OverflowWrapping
public func mod<T, Q>(s: T, v: Vec3<T, Q>): Vec3<T, Q> where T <: Integer<T>, Q <: Qualifier {
    return Vec3(s % v.x, s % v.y, s % v.z)
}

@OverflowWrapping
public func mod<T, Q>(s: T, v: Vec4<T, Q>): Vec4<T, Q> where T <: Integer<T>, Q <: Qualifier {
    return Vec4(s % v.x, s % v.y, s % v.z, s % v.w)
}

public func mod<Q>(s: Float32, v: Vec1<Float32, Q>): Vec1<Float32, Q> where Q <: Qualifier {
    return Vec1(fmod(s, v.x))
}

public func mod<Q>(s: Float32, v: Vec2<Float32, Q>): Vec2<Float32, Q> where Q <: Qualifier {
    return Vec2(fmod(s, v.x), fmod(s, v.y))
}

public func mod<Q>(s: Float32, v: Vec3<Float32, Q>): Vec3<Float32, Q> where Q <: Qualifier {
    return Vec3(fmod(s, v.x), fmod(s, v.y), fmod(s, v.z))
}

public func mod<Q>(s: Float32, v: Vec4<Float32, Q>): Vec4<Float32, Q> where Q <: Qualifier {
    return Vec4(fmod(s, v.x), fmod(s, v.y), fmod(s, v.z), fmod(s, v.w))
}

public func mod<Q>(s: Float64, v: Vec1<Float64, Q>): Vec1<Float64, Q> where Q <: Qualifier {
    return Vec1(fmod(s, v.x))
}

public func mod<Q>(s: Float64, v: Vec2<Float64, Q>): Vec2<Float64, Q> where Q <: Qualifier {
    return Vec2(fmod(s, v.x), fmod(s, v.y))
}

public func mod<Q>(s: Float64, v: Vec3<Float64, Q>): Vec3<Float64, Q> where Q <: Qualifier {
    return Vec3(fmod(s, v.x), fmod(s, v.y), fmod(s, v.z))
}

public func mod<Q>(s: Float64, v: Vec4<Float64, Q>): Vec4<Float64, Q> where Q <: Qualifier {
    return Vec4(fmod(s, v.x), fmod(s, v.y), fmod(s, v.z), fmod(s, v.w))
}

public func mod<Q>(s: Float16, v: Vec1<Float16, Q>): Vec1<Float16, Q> where Q <: Qualifier {
    return Vec1(fmod(s, v.x))
}

public func mod<Q>(s: Float16, v: Vec2<Float16, Q>): Vec2<Float16, Q> where Q <: Qualifier {
    return Vec2(fmod(s, v.x), fmod(s, v.y))
}

public func mod<Q>(s: Float16, v: Vec3<Float16, Q>): Vec3<Float16, Q> where Q <: Qualifier {
    return Vec3(fmod(s, v.x), fmod(s, v.y), fmod(s, v.z))
}

public func mod<Q>(s: Float16, v: Vec4<Float16, Q>): Vec4<Float16, Q> where Q <: Qualifier {
    return Vec4(fmod(s, v.x), fmod(s, v.y), fmod(s, v.z), fmod(s, v.w))
}
