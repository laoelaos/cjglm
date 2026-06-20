package glm.detail

public func castVec1<T, Q, T2, Q2>(v: Vec1<T2, Q2>, conv: (T2) -> T): Vec1<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier {
    Vec1<T, Q>(conv(v.x))
}

public func castVec1<T, Q, T2, Q2>(v: Vec2<T2, Q2>, conv: (T2) -> T): Vec1<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier {
    Vec1<T, Q>(conv(v.x))
}

public func castVec1<T, Q, T2, Q2>(v: Vec3<T2, Q2>, conv: (T2) -> T): Vec1<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier {
    Vec1<T, Q>(conv(v.x))
}

public func castVec1<T, Q, T2, Q2>(v: Vec4<T2, Q2>, conv: (T2) -> T): Vec1<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier {
    Vec1<T, Q>(conv(v.x))
}

public func castVec2<T, Q, T2, Q2>(v: Vec1<T2, Q2>, conv: (T2) -> T): Vec2<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier {
    Vec2<T, Q>(conv(v.x), conv(v.x))
}

public func castVec2<T, Q, T2, Q2>(v: Vec2<T2, Q2>, conv: (T2) -> T): Vec2<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier {
    Vec2<T, Q>(conv(v.x), conv(v.y))
}

public func castVec2<T, Q, T2, Q2>(v: Vec3<T2, Q2>, conv: (T2) -> T): Vec2<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier {
    Vec2<T, Q>(conv(v.x), conv(v.y))
}

public func castVec2<T, Q, T2, Q2>(v: Vec4<T2, Q2>, conv: (T2) -> T): Vec2<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier {
    Vec2<T, Q>(conv(v.x), conv(v.y))
}

public func castVec3<T, Q, T2, Q2>(v: Vec1<T2, Q2>, conv: (T2) -> T): Vec3<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier {
    Vec3<T, Q>(conv(v.x), conv(v.x), conv(v.x))
}

public func castVec3<T, Q, T2, Q2>(v: Vec2<T2, Q2>, conv: (T2) -> T): Vec3<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier {
    Vec3<T, Q>(conv(v.x), conv(v.y), conv(v.y))
}

public func castVec3<T, Q, T2, Q2>(v: Vec3<T2, Q2>, conv: (T2) -> T): Vec3<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier {
    Vec3<T, Q>(conv(v.x), conv(v.y), conv(v.z))
}

public func castVec3<T, Q, T2, Q2>(v: Vec4<T2, Q2>, conv: (T2) -> T): Vec3<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier {
    Vec3<T, Q>(conv(v.x), conv(v.y), conv(v.z))
}

public func castVec4<T, Q, T2, Q2>(v: Vec1<T2, Q2>, conv: (T2) -> T): Vec4<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier {
    Vec4<T, Q>(conv(v.x), conv(v.x), conv(v.x), conv(v.x))
}

public func castVec4<T, Q, T2, Q2>(v: Vec2<T2, Q2>, conv: (T2) -> T): Vec4<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier {
    Vec4<T, Q>(conv(v.x), conv(v.y), conv(v.y), conv(v.y))
}

public func castVec4<T, Q, T2, Q2>(v: Vec3<T2, Q2>, conv: (T2) -> T): Vec4<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier {
    Vec4<T, Q>(conv(v.x), conv(v.y), conv(v.z), conv(v.z))
}

public func castVec4<T, Q, T2, Q2>(v: Vec4<T2, Q2>, conv: (T2) -> T): Vec4<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier {
    Vec4<T, Q>(conv(v.x), conv(v.y), conv(v.z), conv(v.w))
}
