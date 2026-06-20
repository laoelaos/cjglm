package glm.detail

public func fromBoolVec<T, Q>(v: Vec1<Bool, Q>, zero: T, one: T): Vec1<T, Q> where Q <: Qualifier {
    return Vec1(if (v.x) { one } else { zero })
}

public func fromBoolVecQ2<T, Q, Q2>(v: Vec1<Bool, Q2>, zero: T, one: T): Vec1<T, Q> where Q <: Qualifier, Q2 <: Qualifier {
    return Vec1<T, Q>(if (v.x) { one } else { zero })
}

public func fromBoolVec<T, Q>(v: Vec2<Bool, Q>, zero: T, one: T): Vec2<T, Q> where Q <: Qualifier {
    return Vec2(if (v.x) { one } else { zero }, if (v.y) { one } else { zero })
}

public func fromBoolVecQ2<T, Q, Q2>(v: Vec2<Bool, Q2>, zero: T, one: T): Vec2<T, Q> where Q <: Qualifier, Q2 <: Qualifier {
    return Vec2<T, Q>(if (v.x) { one } else { zero }, if (v.y) { one } else { zero })
}

public func fromBoolVec<T, Q>(v: Vec3<Bool, Q>, zero: T, one: T): Vec3<T, Q> where Q <: Qualifier {
    return Vec3(if (v.x) { one } else { zero }, if (v.y) { one } else { zero }, if (v.z) { one } else { zero })
}

public func fromBoolVecQ2<T, Q, Q2>(v: Vec3<Bool, Q2>, zero: T, one: T): Vec3<T, Q> where Q <: Qualifier, Q2 <: Qualifier {
    return Vec3<T, Q>(if (v.x) { one } else { zero }, if (v.y) { one } else { zero }, if (v.z) { one } else { zero })
}

public func fromBoolVec<T, Q>(v: Vec4<Bool, Q>, zero: T, one: T): Vec4<T, Q> where Q <: Qualifier {
    return Vec4(if (v.x) { one } else { zero }, if (v.y) { one } else { zero }, if (v.z) { one } else { zero }, if (v.w) { one } else { zero })
}

public func fromBoolVecQ2<T, Q, Q2>(v: Vec4<Bool, Q2>, zero: T, one: T): Vec4<T, Q> where Q <: Qualifier, Q2 <: Qualifier {
    return Vec4<T, Q>(if (v.x) { one } else { zero }, if (v.y) { one } else { zero }, if (v.z) { one } else { zero }, if (v.w) { one } else { zero })
}
