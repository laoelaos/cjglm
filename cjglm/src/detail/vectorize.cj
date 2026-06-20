package glm.detail

public struct Functor1Vec1<R, T, Q> where Q <: Qualifier {
    public static func call(callable: (T) -> R, v: Vec1<T, Q>): Vec1<R, Q> {
        return Vec1<R, Q>(callable(v.x))
    }
}

public struct Functor1Vec2<R, T, Q> where Q <: Qualifier {
    public static func call(callable: (T) -> R, v: Vec2<T, Q>): Vec2<R, Q> {
        return Vec2<R, Q>(callable(v.x), callable(v.y))
    }
}

public struct Functor1Vec3<R, T, Q> where Q <: Qualifier {
    public static func call(callable: (T) -> R, v: Vec3<T, Q>): Vec3<R, Q> {
        return Vec3<R, Q>(callable(v.x), callable(v.y), callable(v.z))
    }
}

public struct Functor1Vec4<R, T, Q> where Q <: Qualifier {
    public static func call(callable: (T) -> R, v: Vec4<T, Q>): Vec4<R, Q> {
        return Vec4<R, Q>(callable(v.x), callable(v.y), callable(v.z), callable(v.w))
    }
}

public struct Functor2Vec1<T, Q> where Q <: Qualifier {
    public static func call(callable: (T, T) -> T, a: Vec1<T, Q>, b: Vec1<T, Q>): Vec1<T, Q> {
        return Vec1<T, Q>(callable(a.x, b.x))
    }
}

public struct Functor2Vec2<T, Q> where Q <: Qualifier {
    public static func call(callable: (T, T) -> T, a: Vec2<T, Q>, b: Vec2<T, Q>): Vec2<T, Q> {
        return Vec2<T, Q>(callable(a.x, b.x), callable(a.y, b.y))
    }
}

public struct Functor2Vec3<T, Q> where Q <: Qualifier {
    public static func call(callable: (T, T) -> T, a: Vec3<T, Q>, b: Vec3<T, Q>): Vec3<T, Q> {
        return Vec3<T, Q>(callable(a.x, b.x), callable(a.y, b.y), callable(a.z, b.z))
    }
}

public struct Functor2Vec4<T, Q> where Q <: Qualifier {
    public static func call(callable: (T, T) -> T, a: Vec4<T, Q>, b: Vec4<T, Q>): Vec4<T, Q> {
        return Vec4<T, Q>(callable(a.x, b.x), callable(a.y, b.y), callable(a.z, b.z), callable(a.w, b.w))
    }
}

public struct Functor2VecScaVec1<T, Q> where Q <: Qualifier {
    public static func call(callable: (T, T) -> T, v: Vec1<T, Q>, s: T): Vec1<T, Q> {
        return Vec1<T, Q>(callable(v.x, s))
    }
}

public struct Functor2VecScaVec2<T, Q> where Q <: Qualifier {
    public static func call(callable: (T, T) -> T, v: Vec2<T, Q>, s: T): Vec2<T, Q> {
        return Vec2<T, Q>(callable(v.x, s), callable(v.y, s))
    }
}

public struct Functor2VecScaVec3<T, Q> where Q <: Qualifier {
    public static func call(callable: (T, T) -> T, v: Vec3<T, Q>, s: T): Vec3<T, Q> {
        return Vec3<T, Q>(callable(v.x, s), callable(v.y, s), callable(v.z, s))
    }
}

public struct Functor2VecScaVec4<T, Q> where Q <: Qualifier {
    public static func call(callable: (T, T) -> T, v: Vec4<T, Q>, s: T): Vec4<T, Q> {
        return Vec4<T, Q>(callable(v.x, s), callable(v.y, s), callable(v.z, s), callable(v.w, s))
    }
}

public struct Functor2VecIntVec1<T, Q> where Q <: Qualifier {
    public static func call(callable: (T, Int64) -> T, v: Vec1<T, Q>, i: Int64): Vec1<T, Q> {
        return Vec1<T, Q>(callable(v.x, i))
    }
}

public struct Functor2VecIntVec2<T, Q> where Q <: Qualifier {
    public static func call(callable: (T, Int64) -> T, v: Vec2<T, Q>, i: Int64): Vec2<T, Q> {
        return Vec2<T, Q>(callable(v.x, i), callable(v.y, i))
    }
}

public struct Functor2VecIntVec3<T, Q> where Q <: Qualifier {
    public static func call(callable: (T, Int64) -> T, v: Vec3<T, Q>, i: Int64): Vec3<T, Q> {
        return Vec3<T, Q>(callable(v.x, i), callable(v.y, i), callable(v.z, i))
    }
}

public struct Functor2VecIntVec4<T, Q> where Q <: Qualifier {
    public static func call(callable: (T, Int64) -> T, v: Vec4<T, Q>, i: Int64): Vec4<T, Q> {
        return Vec4<T, Q>(callable(v.x, i), callable(v.y, i), callable(v.z, i), callable(v.w, i))
    }
}
