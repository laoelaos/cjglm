package glm.detail

import std.math.{ Number }

public func lessThan<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>): Vec1<Bool, Q>
    where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec1<Bool, Q>(x.x < y.x)
}
public func lessThan<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>): Vec2<Bool, Q>
    where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec2<Bool, Q>(x.x < y.x, x.y < y.y)
}
public func lessThan<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>): Vec3<Bool, Q>
    where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec3<Bool, Q>(x.x < y.x, x.y < y.y, x.z < y.z)
}
public func lessThan<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>): Vec4<Bool, Q>
    where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec4<Bool, Q>(x.x < y.x, x.y < y.y, x.z < y.z, x.w < y.w)
}

public func greaterThan<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>): Vec1<Bool, Q>
    where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec1<Bool, Q>(x.x > y.x)
}
public func greaterThan<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>): Vec2<Bool, Q>
    where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec2<Bool, Q>(x.x > y.x, x.y > y.y)
}
public func greaterThan<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>): Vec3<Bool, Q>
    where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec3<Bool, Q>(x.x > y.x, x.y > y.y, x.z > y.z)
}
public func greaterThan<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>): Vec4<Bool, Q>
    where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec4<Bool, Q>(x.x > y.x, x.y > y.y, x.z > y.z, x.w > y.w)
}

public func lessThanEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>): Vec1<Bool, Q>
    where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec1<Bool, Q>(x.x <= y.x)
}
public func lessThanEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>): Vec2<Bool, Q>
    where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec2<Bool, Q>(x.x <= y.x, x.y <= y.y)
}
public func lessThanEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>): Vec3<Bool, Q>
    where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec3<Bool, Q>(x.x <= y.x, x.y <= y.y, x.z <= y.z)
}
public func lessThanEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>): Vec4<Bool, Q>
    where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec4<Bool, Q>(x.x <= y.x, x.y <= y.y, x.z <= y.z, x.w <= y.w)
}

public func greaterThanEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>): Vec1<Bool, Q>
    where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec1<Bool, Q>(x.x >= y.x)
}
public func greaterThanEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>): Vec2<Bool, Q>
    where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec2<Bool, Q>(x.x >= y.x, x.y >= y.y)
}
public func greaterThanEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>): Vec3<Bool, Q>
    where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec3<Bool, Q>(x.x >= y.x, x.y >= y.y, x.z >= y.z)
}
public func greaterThanEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>): Vec4<Bool, Q>
    where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec4<Bool, Q>(x.x >= y.x, x.y >= y.y, x.z >= y.z, x.w >= y.w)
}

public func equal<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>): Vec1<Bool, Q>
    where T <: Number<T> & Equatable<T>, Q <: Qualifier {
    Vec1<Bool, Q>(x.x == y.x)
}
public func equal<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>): Vec2<Bool, Q>
    where T <: Number<T> & Equatable<T>, Q <: Qualifier {
    Vec2<Bool, Q>(x.x == y.x, x.y == y.y)
}
public func equal<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>): Vec3<Bool, Q>
    where T <: Number<T> & Equatable<T>, Q <: Qualifier {
    Vec3<Bool, Q>(x.x == y.x, x.y == y.y, x.z == y.z)
}
public func equal<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>): Vec4<Bool, Q>
    where T <: Number<T> & Equatable<T>, Q <: Qualifier {
    Vec4<Bool, Q>(x.x == y.x, x.y == y.y, x.z == y.z, x.w == y.w)
}

public func notEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>): Vec1<Bool, Q>
    where T <: Number<T> & Equatable<T>, Q <: Qualifier {
    Vec1<Bool, Q>(x.x != y.x)
}
public func notEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>): Vec2<Bool, Q>
    where T <: Number<T> & Equatable<T>, Q <: Qualifier {
    Vec2<Bool, Q>(x.x != y.x, x.y != y.y)
}
public func notEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>): Vec3<Bool, Q>
    where T <: Number<T> & Equatable<T>, Q <: Qualifier {
    Vec3<Bool, Q>(x.x != y.x, x.y != y.y, x.z != y.z)
}
public func notEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>): Vec4<Bool, Q>
    where T <: Number<T> & Equatable<T>, Q <: Qualifier {
    Vec4<Bool, Q>(x.x != y.x, x.y != y.y, x.z != y.z, x.w != y.w)
}

public func any<Q>(v: Vec1<Bool, Q>): Bool where Q <: Qualifier {
    v.x
}
public func any<Q>(v: Vec2<Bool, Q>): Bool where Q <: Qualifier {
    v.x || v.y
}
public func any<Q>(v: Vec3<Bool, Q>): Bool where Q <: Qualifier {
    v.x || v.y || v.z
}
public func any<Q>(v: Vec4<Bool, Q>): Bool where Q <: Qualifier {
    v.x || v.y || v.z || v.w
}

public func all<Q>(v: Vec1<Bool, Q>): Bool where Q <: Qualifier {
    v.x
}
public func all<Q>(v: Vec2<Bool, Q>): Bool where Q <: Qualifier {
    v.x && v.y
}
public func all<Q>(v: Vec3<Bool, Q>): Bool where Q <: Qualifier {
    v.x && v.y && v.z
}
public func all<Q>(v: Vec4<Bool, Q>): Bool where Q <: Qualifier {
    v.x && v.y && v.z && v.w
}

public func not_<Q>(v: Vec1<Bool, Q>): Vec1<Bool, Q> where Q <: Qualifier {
    Vec1<Bool, Q>(!v.x)
}
public func not_<Q>(v: Vec2<Bool, Q>): Vec2<Bool, Q> where Q <: Qualifier {
    Vec2<Bool, Q>(!v.x, !v.y)
}
public func not_<Q>(v: Vec3<Bool, Q>): Vec3<Bool, Q> where Q <: Qualifier {
    Vec3<Bool, Q>(!v.x, !v.y, !v.z)
}
public func not_<Q>(v: Vec4<Bool, Q>): Vec4<Bool, Q> where Q <: Qualifier {
    Vec4<Bool, Q>(!v.x, !v.y, !v.z, !v.w)
}
