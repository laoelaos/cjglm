package glm.ext
import glm.detail.{ Mat4x4, Qualifier }
import std.math.FloatingPoint
public func perspective<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
