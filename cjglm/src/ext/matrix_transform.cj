package glm.ext
import glm.detail.{ Mat4x4, Vec3, Qualifier }
import std.math.FloatingPoint
public func translate<T, Q>(m: Mat4x4<T, Q>, v: Vec3<T, Q>): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
