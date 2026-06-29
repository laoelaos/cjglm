package glm.detail

import std.math.Number

@OverflowWrapping
public func add<T, Q>(s: T, q: Quat<T, Q>): Quat<T, Q>
  where T <: Number<T>, Q <: Qualifier {
    Quat(s + q.x, s + q.y, s + q.z, s + q.w)
}

@OverflowWrapping
public func sub<T, Q>(s: T, q: Quat<T, Q>): Quat<T, Q>
  where T <: Number<T>, Q <: Qualifier {
    Quat(s - q.x, s - q.y, s - q.z, s - q.w)
}

@OverflowWrapping
public func mul<T, Q>(s: T, q: Quat<T, Q>): Quat<T, Q>
  where T <: Number<T>, Q <: Qualifier {
    Quat(s * q.x, s * q.y, s * q.z, s * q.w)
}

@OverflowWrapping
public func div<T, Q>(s: T, q: Quat<T, Q>): Quat<T, Q>
  where T <: Number<T>, Q <: Qualifier {
    Quat(s / q.x, s / q.y, s / q.z, s / q.w)
}
