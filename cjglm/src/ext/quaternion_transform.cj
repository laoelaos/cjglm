package glm.ext
import glm.detail.{ Quat, Vec3, Qualifier }
import std.math.FloatingPoint
public func rotate<T, Q>(q: Quat<T, Q>, angle: T, axis: Vec3<T, Q>): Quat<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
