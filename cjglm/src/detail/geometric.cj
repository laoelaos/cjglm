package glm.detail

import std.math.{ Number }

public func dot<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
public func dot<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
public func dot<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
public func dot<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
public func cross<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
public func normalize<T, Q>(v: Vec2<T, Q>): Vec2<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
public func normalize<T, Q>(v: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
public func normalize<T, Q>(v: Vec4<T, Q>): Vec4<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
public func length<T, Q>(v: Vec2<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
public func length<T, Q>(v: Vec3<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
public func length<T, Q>(v: Vec4<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
public func distance<T, Q>(p0: Vec2<T, Q>, p1: Vec2<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
public func distance<T, Q>(p0: Vec3<T, Q>, p1: Vec3<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
public func distance<T, Q>(p0: Vec4<T, Q>, p1: Vec4<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
public func reflect<T, Q>(I: Vec2<T, Q>, N: Vec2<T, Q>): Vec2<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
public func reflect<T, Q>(I: Vec3<T, Q>, N: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
public func reflect<T, Q>(I: Vec4<T, Q>, N: Vec4<T, Q>): Vec4<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
public func refract<T, Q>(I: Vec2<T, Q>, N: Vec2<T, Q>, eta: T): Vec2<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
public func refract<T, Q>(I: Vec3<T, Q>, N: Vec3<T, Q>, eta: T): Vec3<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
public func refract<T, Q>(I: Vec4<T, Q>, N: Vec4<T, Q>, eta: T): Vec4<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
