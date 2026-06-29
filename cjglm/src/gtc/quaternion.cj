package glm.gtc
import glm.detail.*
import std.math.FloatingPoint
public import glm.detail.{mat3Cast, mat4Cast, quatCast}
public import glm.ext.{equal, notEqual, epsilon, pi, cos_one_over_two}

public func lessThan<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>): Vec4<Bool, Q>
  where T <: Comparable<T>, Q <: Qualifier
  { Vec4(x.x < y.x, x.y < y.y, x.z < y.z, x.w < y.w) }

public func lessThanEqual<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>): Vec4<Bool, Q>
  where T <: Comparable<T>, Q <: Qualifier
  { Vec4(x.x <= y.x, x.y <= y.y, x.z <= y.z, x.w <= y.w) }

public func greaterThan<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>): Vec4<Bool, Q>
  where T <: Comparable<T>, Q <: Qualifier
  { Vec4(x.x > y.x, x.y > y.y, x.z > y.z, x.w > y.w) }

public func greaterThanEqual<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>): Vec4<Bool, Q>
  where T <: Comparable<T>, Q <: Qualifier
  { Vec4(x.x >= y.x, x.y >= y.y, x.z >= y.z, x.w >= y.w) }

public func eulerAngles<T, Q>(x: Quat<T, Q>): Vec3<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier
  { throw Exception("stub") }

public func roll<T, Q>(q: Quat<T, Q>): T
  where T <: FloatingPoint<T>, Q <: Qualifier
  { throw Exception("stub") }

public func pitch<T, Q>(q: Quat<T, Q>): T
  where T <: FloatingPoint<T>, Q <: Qualifier
  { throw Exception("stub") }

public func yaw<T, Q>(q: Quat<T, Q>): T
  where T <: FloatingPoint<T>, Q <: Qualifier
  { throw Exception("stub") }

public func quatLookAt<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier
  { throw Exception("stub") }

public func quatLookAtRH<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier
  { throw Exception("stub") }

public func quatLookAtLH<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier
  { throw Exception("stub") }
