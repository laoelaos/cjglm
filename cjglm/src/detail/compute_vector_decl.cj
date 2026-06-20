package glm.detail

import std.math.{ Number, Integer }

public struct compute_vec_add1<T, Q> where T <: Number<T>, Q <: Qualifier {
    public static func call(a: Vec1<T, Q>, b: Vec1<T, Q>): Vec1<T, Q> {
        return Functor2Vec1<T, Q>.call({ x, y => x + y }, a, b)
    }
}

public struct compute_vec_add2<T, Q> where T <: Number<T>, Q <: Qualifier {
    public static func call(a: Vec2<T, Q>, b: Vec2<T, Q>): Vec2<T, Q> {
        return Functor2Vec2<T, Q>.call({ x, y => x + y }, a, b)
    }
}

public struct compute_vec_add3<T, Q> where T <: Number<T>, Q <: Qualifier {
    public static func call(a: Vec3<T, Q>, b: Vec3<T, Q>): Vec3<T, Q> {
        return Functor2Vec3<T, Q>.call({ x, y => x + y }, a, b)
    }
}

public struct compute_vec_add4<T, Q> where T <: Number<T>, Q <: Qualifier {
    public static func call(a: Vec4<T, Q>, b: Vec4<T, Q>): Vec4<T, Q> {
        return Functor2Vec4<T, Q>.call({ x, y => x + y }, a, b)
    }
}

public struct compute_vec_sub1<T, Q> where T <: Number<T>, Q <: Qualifier {
    public static func call(a: Vec1<T, Q>, b: Vec1<T, Q>): Vec1<T, Q> {
        return Functor2Vec1<T, Q>.call({ x, y => x - y }, a, b)
    }
}

public struct compute_vec_sub2<T, Q> where T <: Number<T>, Q <: Qualifier {
    public static func call(a: Vec2<T, Q>, b: Vec2<T, Q>): Vec2<T, Q> {
        return Functor2Vec2<T, Q>.call({ x, y => x - y }, a, b)
    }
}

public struct compute_vec_sub3<T, Q> where T <: Number<T>, Q <: Qualifier {
    public static func call(a: Vec3<T, Q>, b: Vec3<T, Q>): Vec3<T, Q> {
        return Functor2Vec3<T, Q>.call({ x, y => x - y }, a, b)
    }
}

public struct compute_vec_sub4<T, Q> where T <: Number<T>, Q <: Qualifier {
    public static func call(a: Vec4<T, Q>, b: Vec4<T, Q>): Vec4<T, Q> {
        return Functor2Vec4<T, Q>.call({ x, y => x - y }, a, b)
    }
}

public struct compute_vec_mul1<T, Q> where T <: Number<T>, Q <: Qualifier {
    public static func call(a: Vec1<T, Q>, b: Vec1<T, Q>): Vec1<T, Q> {
        return Functor2Vec1<T, Q>.call({ x, y => x * y }, a, b)
    }
}

public struct compute_vec_mul2<T, Q> where T <: Number<T>, Q <: Qualifier {
    public static func call(a: Vec2<T, Q>, b: Vec2<T, Q>): Vec2<T, Q> {
        return Functor2Vec2<T, Q>.call({ x, y => x * y }, a, b)
    }
}

public struct compute_vec_mul3<T, Q> where T <: Number<T>, Q <: Qualifier {
    public static func call(a: Vec3<T, Q>, b: Vec3<T, Q>): Vec3<T, Q> {
        return Functor2Vec3<T, Q>.call({ x, y => x * y }, a, b)
    }
}

public struct compute_vec_mul4<T, Q> where T <: Number<T>, Q <: Qualifier {
    public static func call(a: Vec4<T, Q>, b: Vec4<T, Q>): Vec4<T, Q> {
        return Functor2Vec4<T, Q>.call({ x, y => x * y }, a, b)
    }
}

public struct compute_vec_div1<T, Q> where T <: Number<T>, Q <: Qualifier {
    public static func call(a: Vec1<T, Q>, b: Vec1<T, Q>): Vec1<T, Q> {
        return Functor2Vec1<T, Q>.call({ x, y => x / y }, a, b)
    }
}

public struct compute_vec_div2<T, Q> where T <: Number<T>, Q <: Qualifier {
    public static func call(a: Vec2<T, Q>, b: Vec2<T, Q>): Vec2<T, Q> {
        return Functor2Vec2<T, Q>.call({ x, y => x / y }, a, b)
    }
}

public struct compute_vec_div3<T, Q> where T <: Number<T>, Q <: Qualifier {
    public static func call(a: Vec3<T, Q>, b: Vec3<T, Q>): Vec3<T, Q> {
        return Functor2Vec3<T, Q>.call({ x, y => x / y }, a, b)
    }
}

public struct compute_vec_div4<T, Q> where T <: Number<T>, Q <: Qualifier {
    public static func call(a: Vec4<T, Q>, b: Vec4<T, Q>): Vec4<T, Q> {
        return Functor2Vec4<T, Q>.call({ x, y => x / y }, a, b)
    }
}

public struct compute_vec_mod1<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public static func call(a: Vec1<T, Q>, b: Vec1<T, Q>): Vec1<T, Q> {
        return Functor2Vec1<T, Q>.call({ x, y => x % y }, a, b)
    }
}

public struct compute_vec_mod2<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public static func call(a: Vec2<T, Q>, b: Vec2<T, Q>): Vec2<T, Q> {
        return Functor2Vec2<T, Q>.call({ x, y => x % y }, a, b)
    }
}

public struct compute_vec_mod3<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public static func call(a: Vec3<T, Q>, b: Vec3<T, Q>): Vec3<T, Q> {
        return Functor2Vec3<T, Q>.call({ x, y => x % y }, a, b)
    }
}

public struct compute_vec_mod4<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public static func call(a: Vec4<T, Q>, b: Vec4<T, Q>): Vec4<T, Q> {
        return Functor2Vec4<T, Q>.call({ x, y => x % y }, a, b)
    }
}

public struct compute_vec_and1<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public static func call(a: Vec1<T, Q>, b: Vec1<T, Q>): Vec1<T, Q> {
        return Functor2Vec1<T, Q>.call({ x, y => x & y }, a, b)
    }
}

public struct compute_vec_and2<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public static func call(a: Vec2<T, Q>, b: Vec2<T, Q>): Vec2<T, Q> {
        return Functor2Vec2<T, Q>.call({ x, y => x & y }, a, b)
    }
}

public struct compute_vec_and3<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public static func call(a: Vec3<T, Q>, b: Vec3<T, Q>): Vec3<T, Q> {
        return Functor2Vec3<T, Q>.call({ x, y => x & y }, a, b)
    }
}

public struct compute_vec_and4<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public static func call(a: Vec4<T, Q>, b: Vec4<T, Q>): Vec4<T, Q> {
        return Functor2Vec4<T, Q>.call({ x, y => x & y }, a, b)
    }
}

public struct compute_vec_or1<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public static func call(a: Vec1<T, Q>, b: Vec1<T, Q>): Vec1<T, Q> {
        return Functor2Vec1<T, Q>.call({ x, y => x | y }, a, b)
    }
}

public struct compute_vec_or2<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public static func call(a: Vec2<T, Q>, b: Vec2<T, Q>): Vec2<T, Q> {
        return Functor2Vec2<T, Q>.call({ x, y => x | y }, a, b)
    }
}

public struct compute_vec_or3<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public static func call(a: Vec3<T, Q>, b: Vec3<T, Q>): Vec3<T, Q> {
        return Functor2Vec3<T, Q>.call({ x, y => x | y }, a, b)
    }
}

public struct compute_vec_or4<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public static func call(a: Vec4<T, Q>, b: Vec4<T, Q>): Vec4<T, Q> {
        return Functor2Vec4<T, Q>.call({ x, y => x | y }, a, b)
    }
}

public struct compute_vec_xor1<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public static func call(a: Vec1<T, Q>, b: Vec1<T, Q>): Vec1<T, Q> {
        return Functor2Vec1<T, Q>.call({ x, y => x ^ y }, a, b)
    }
}

public struct compute_vec_xor2<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public static func call(a: Vec2<T, Q>, b: Vec2<T, Q>): Vec2<T, Q> {
        return Functor2Vec2<T, Q>.call({ x, y => x ^ y }, a, b)
    }
}

public struct compute_vec_xor3<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public static func call(a: Vec3<T, Q>, b: Vec3<T, Q>): Vec3<T, Q> {
        return Functor2Vec3<T, Q>.call({ x, y => x ^ y }, a, b)
    }
}

public struct compute_vec_xor4<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public static func call(a: Vec4<T, Q>, b: Vec4<T, Q>): Vec4<T, Q> {
        return Functor2Vec4<T, Q>.call({ x, y => x ^ y }, a, b)
    }
}

public struct compute_vec_shift_left1<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public static func call(a: Vec1<T, Q>, b: Vec1<Int64, Q>): Vec1<T, Q> {
        return Vec1<T, Q>(a.x << b.x)
    }
}

public struct compute_vec_shift_left2<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public static func call(a: Vec2<T, Q>, b: Vec2<Int64, Q>): Vec2<T, Q> {
        return Vec2<T, Q>(a.x << b.x, a.y << b.y)
    }
}

public struct compute_vec_shift_left3<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public static func call(a: Vec3<T, Q>, b: Vec3<Int64, Q>): Vec3<T, Q> {
        return Vec3<T, Q>(a.x << b.x, a.y << b.y, a.z << b.z)
    }
}

public struct compute_vec_shift_left4<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public static func call(a: Vec4<T, Q>, b: Vec4<Int64, Q>): Vec4<T, Q> {
        return Vec4<T, Q>(a.x << b.x, a.y << b.y, a.z << b.z, a.w << b.w)
    }
}

public struct compute_vec_shift_right1<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public static func call(a: Vec1<T, Q>, b: Vec1<Int64, Q>): Vec1<T, Q> {
        return Vec1<T, Q>(a.x >> b.x)
    }
}

public struct compute_vec_shift_right2<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public static func call(a: Vec2<T, Q>, b: Vec2<Int64, Q>): Vec2<T, Q> {
        return Vec2<T, Q>(a.x >> b.x, a.y >> b.y)
    }
}

public struct compute_vec_shift_right3<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public static func call(a: Vec3<T, Q>, b: Vec3<Int64, Q>): Vec3<T, Q> {
        return Vec3<T, Q>(a.x >> b.x, a.y >> b.y, a.z >> b.z)
    }
}

public struct compute_vec_shift_right4<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public static func call(a: Vec4<T, Q>, b: Vec4<Int64, Q>): Vec4<T, Q> {
        return Vec4<T, Q>(a.x >> b.x, a.y >> b.y, a.z >> b.z, a.w >> b.w)
    }
}

public struct compute_vec_equal1<T, Q> where T <: Equatable<T>, Q <: Qualifier {
    public static func call(a: Vec1<T, Q>, b: Vec1<T, Q>): Vec1<Bool, Q> {
        return Vec1<Bool, Q>(a.x == b.x)
    }
}

public struct compute_vec_equal2<T, Q> where T <: Equatable<T>, Q <: Qualifier {
    public static func call(a: Vec2<T, Q>, b: Vec2<T, Q>): Vec2<Bool, Q> {
        return Vec2<Bool, Q>(a.x == b.x, a.y == b.y)
    }
}

public struct compute_vec_equal3<T, Q> where T <: Equatable<T>, Q <: Qualifier {
    public static func call(a: Vec3<T, Q>, b: Vec3<T, Q>): Vec3<Bool, Q> {
        return Vec3<Bool, Q>(a.x == b.x, a.y == b.y, a.z == b.z)
    }
}

public struct compute_vec_equal4<T, Q> where T <: Equatable<T>, Q <: Qualifier {
    public static func call(a: Vec4<T, Q>, b: Vec4<T, Q>): Vec4<Bool, Q> {
        return Vec4<Bool, Q>(a.x == b.x, a.y == b.y, a.z == b.z, a.w == b.w)
    }
}

public struct compute_vec_nequal1<T, Q> where T <: Equatable<T>, Q <: Qualifier {
    public static func call(a: Vec1<T, Q>, b: Vec1<T, Q>): Vec1<Bool, Q> {
        return Vec1<Bool, Q>(a.x != b.x)
    }
}

public struct compute_vec_nequal2<T, Q> where T <: Equatable<T>, Q <: Qualifier {
    public static func call(a: Vec2<T, Q>, b: Vec2<T, Q>): Vec2<Bool, Q> {
        return Vec2<Bool, Q>(a.x != b.x, a.y != b.y)
    }
}

public struct compute_vec_nequal3<T, Q> where T <: Equatable<T>, Q <: Qualifier {
    public static func call(a: Vec3<T, Q>, b: Vec3<T, Q>): Vec3<Bool, Q> {
        return Vec3<Bool, Q>(a.x != b.x, a.y != b.y, a.z != b.z)
    }
}

public struct compute_vec_nequal4<T, Q> where T <: Equatable<T>, Q <: Qualifier {
    public static func call(a: Vec4<T, Q>, b: Vec4<T, Q>): Vec4<Bool, Q> {
        return Vec4<Bool, Q>(a.x != b.x, a.y != b.y, a.z != b.z, a.w != b.w)
    }
}

public struct compute_vec_bitwise_not1<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public static func call(a: Vec1<T, Q>): Vec1<T, Q> {
        return Functor1Vec1<T, T, Q>.call({ x => !x }, a)
    }
}

public struct compute_vec_bitwise_not2<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public static func call(a: Vec2<T, Q>): Vec2<T, Q> {
        return Functor1Vec2<T, T, Q>.call({ x => !x }, a)
    }
}

public struct compute_vec_bitwise_not3<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public static func call(a: Vec3<T, Q>): Vec3<T, Q> {
        return Functor1Vec3<T, T, Q>.call({ x => !x }, a)
    }
}

public struct compute_vec_bitwise_not4<T, Q> where T <: Integer<T>, Q <: Qualifier {
    public static func call(a: Vec4<T, Q>): Vec4<T, Q> {
        return Functor1Vec4<T, T, Q>.call({ x => !x }, a)
    }
}
