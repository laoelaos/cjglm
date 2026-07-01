package glm.ext
import glm.detail.{ Vec1, Vec2, Vec3, Vec4, Qualifier, min, max, clamp }
import std.math.{ Number, FloatingPoint }

// ── 3/4 输入 min/max ──

public func min<T, Q>(a: Vec1<T, Q>, b: Vec1<T, Q>, c: Vec1<T, Q>): Vec1<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec1(min(a.x, b.x, c.x))
}
public func min<T, Q>(a: Vec1<T, Q>, b: Vec1<T, Q>, c: Vec1<T, Q>, d: Vec1<T, Q>): Vec1<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec1(min(a.x, b.x, c.x, d.x))
}
public func min<T, Q>(a: Vec2<T, Q>, b: Vec2<T, Q>, c: Vec2<T, Q>): Vec2<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec2(min(a.x, b.x, c.x), min(a.y, b.y, c.y))
}
public func min<T, Q>(a: Vec2<T, Q>, b: Vec2<T, Q>, c: Vec2<T, Q>, d: Vec2<T, Q>): Vec2<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec2(min(a.x, b.x, c.x, d.x), min(a.y, b.y, c.y, d.y))
}
public func min<T, Q>(a: Vec3<T, Q>, b: Vec3<T, Q>, c: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec3(min(a.x, b.x, c.x), min(a.y, b.y, c.y), min(a.z, b.z, c.z))
}
public func min<T, Q>(a: Vec3<T, Q>, b: Vec3<T, Q>, c: Vec3<T, Q>, d: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec3(min(a.x, b.x, c.x, d.x), min(a.y, b.y, c.y, d.y), min(a.z, b.z, c.z, d.z))
}
public func min<T, Q>(a: Vec4<T, Q>, b: Vec4<T, Q>, c: Vec4<T, Q>): Vec4<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec4(min(a.x, b.x, c.x), min(a.y, b.y, c.y), min(a.z, b.z, c.z), min(a.w, b.w, c.w))
}
public func min<T, Q>(a: Vec4<T, Q>, b: Vec4<T, Q>, c: Vec4<T, Q>, d: Vec4<T, Q>): Vec4<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec4(min(a.x, b.x, c.x, d.x), min(a.y, b.y, c.y, d.y), min(a.z, b.z, c.z, d.z), min(a.w, b.w, c.w, d.w))
}

public func max<T, Q>(a: Vec1<T, Q>, b: Vec1<T, Q>, c: Vec1<T, Q>): Vec1<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec1(max(a.x, b.x, c.x))
}
public func max<T, Q>(a: Vec1<T, Q>, b: Vec1<T, Q>, c: Vec1<T, Q>, d: Vec1<T, Q>): Vec1<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec1(max(a.x, b.x, c.x, d.x))
}
public func max<T, Q>(a: Vec2<T, Q>, b: Vec2<T, Q>, c: Vec2<T, Q>): Vec2<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec2(max(a.x, b.x, c.x), max(a.y, b.y, c.y))
}
public func max<T, Q>(a: Vec2<T, Q>, b: Vec2<T, Q>, c: Vec2<T, Q>, d: Vec2<T, Q>): Vec2<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec2(max(a.x, b.x, c.x, d.x), max(a.y, b.y, c.y, d.y))
}
public func max<T, Q>(a: Vec3<T, Q>, b: Vec3<T, Q>, c: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec3(max(a.x, b.x, c.x), max(a.y, b.y, c.y), max(a.z, b.z, c.z))
}
public func max<T, Q>(a: Vec3<T, Q>, b: Vec3<T, Q>, c: Vec3<T, Q>, d: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec3(max(a.x, b.x, c.x, d.x), max(a.y, b.y, c.y, d.y), max(a.z, b.z, c.z, d.z))
}
public func max<T, Q>(a: Vec4<T, Q>, b: Vec4<T, Q>, c: Vec4<T, Q>): Vec4<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec4(max(a.x, b.x, c.x), max(a.y, b.y, c.y), max(a.z, b.z, c.z), max(a.w, b.w, c.w))
}
public func max<T, Q>(a: Vec4<T, Q>, b: Vec4<T, Q>, c: Vec4<T, Q>, d: Vec4<T, Q>): Vec4<T, Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier {
    Vec4(max(a.x, b.x, c.x, d.x), max(a.y, b.y, c.y, d.y), max(a.z, b.z, c.z, d.z), max(a.w, b.w, c.w, d.w))
}

// ── fmin/fmax/fclamp ──

public func fmin<T, Q>(a: Vec1<T, Q>, b: T): Vec1<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec1(fmin(a.x, b))
}
public func fmin<T, Q>(a: Vec1<T, Q>, b: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec1(fmin(a.x, b.x))
}
public func fmin<T, Q>(a: Vec2<T, Q>, b: T): Vec2<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec2(fmin(a.x, b), fmin(a.y, b))
}
public func fmin<T, Q>(a: Vec2<T, Q>, b: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec2(fmin(a.x, b.x), fmin(a.y, b.y))
}
public func fmin<T, Q>(a: Vec3<T, Q>, b: T): Vec3<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec3(fmin(a.x, b), fmin(a.y, b), fmin(a.z, b))
}
public func fmin<T, Q>(a: Vec3<T, Q>, b: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec3(fmin(a.x, b.x), fmin(a.y, b.y), fmin(a.z, b.z))
}
public func fmin<T, Q>(a: Vec4<T, Q>, b: T): Vec4<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec4(fmin(a.x, b), fmin(a.y, b), fmin(a.z, b), fmin(a.w, b))
}
public func fmin<T, Q>(a: Vec4<T, Q>, b: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec4(fmin(a.x, b.x), fmin(a.y, b.y), fmin(a.z, b.z), fmin(a.w, b.w))
}

public func fmax<T, Q>(a: Vec1<T, Q>, b: T): Vec1<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec1(fmax(a.x, b))
}
public func fmax<T, Q>(a: Vec1<T, Q>, b: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec1(fmax(a.x, b.x))
}
public func fmax<T, Q>(a: Vec2<T, Q>, b: T): Vec2<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec2(fmax(a.x, b), fmax(a.y, b))
}
public func fmax<T, Q>(a: Vec2<T, Q>, b: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec2(fmax(a.x, b.x), fmax(a.y, b.y))
}
public func fmax<T, Q>(a: Vec3<T, Q>, b: T): Vec3<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec3(fmax(a.x, b), fmax(a.y, b), fmax(a.z, b))
}
public func fmax<T, Q>(a: Vec3<T, Q>, b: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec3(fmax(a.x, b.x), fmax(a.y, b.y), fmax(a.z, b.z))
}
public func fmax<T, Q>(a: Vec4<T, Q>, b: T): Vec4<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec4(fmax(a.x, b), fmax(a.y, b), fmax(a.z, b), fmax(a.w, b))
}
public func fmax<T, Q>(a: Vec4<T, Q>, b: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec4(fmax(a.x, b.x), fmax(a.y, b.y), fmax(a.z, b.z), fmax(a.w, b.w))
}

// ── fmin/fmax 3/4 输入向量版本 ──

public func fmin<T, Q>(a: Vec1<T, Q>, b: Vec1<T, Q>, c: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec1(fmin(a.x, b.x, c.x))
}
public func fmin<T, Q>(a: Vec2<T, Q>, b: Vec2<T, Q>, c: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec2(fmin(a.x, b.x, c.x), fmin(a.y, b.y, c.y))
}
public func fmin<T, Q>(a: Vec3<T, Q>, b: Vec3<T, Q>, c: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec3(fmin(a.x, b.x, c.x), fmin(a.y, b.y, c.y), fmin(a.z, b.z, c.z))
}
public func fmin<T, Q>(a: Vec4<T, Q>, b: Vec4<T, Q>, c: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec4(fmin(a.x, b.x, c.x), fmin(a.y, b.y, c.y), fmin(a.z, b.z, c.z), fmin(a.w, b.w, c.w))
}

public func fmin<T, Q>(a: Vec1<T, Q>, b: Vec1<T, Q>, c: Vec1<T, Q>, d: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec1(fmin(a.x, b.x, c.x, d.x))
}
public func fmin<T, Q>(a: Vec2<T, Q>, b: Vec2<T, Q>, c: Vec2<T, Q>, d: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec2(fmin(a.x, b.x, c.x, d.x), fmin(a.y, b.y, c.y, d.y))
}
public func fmin<T, Q>(a: Vec3<T, Q>, b: Vec3<T, Q>, c: Vec3<T, Q>, d: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec3(fmin(a.x, b.x, c.x, d.x), fmin(a.y, b.y, c.y, d.y), fmin(a.z, b.z, c.z, d.z))
}
public func fmin<T, Q>(a: Vec4<T, Q>, b: Vec4<T, Q>, c: Vec4<T, Q>, d: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec4(fmin(a.x, b.x, c.x, d.x), fmin(a.y, b.y, c.y, d.y), fmin(a.z, b.z, c.z, d.z), fmin(a.w, b.w, c.w, d.w))
}

public func fmax<T, Q>(a: Vec1<T, Q>, b: Vec1<T, Q>, c: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec1(fmax(a.x, b.x, c.x))
}
public func fmax<T, Q>(a: Vec2<T, Q>, b: Vec2<T, Q>, c: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec2(fmax(a.x, b.x, c.x), fmax(a.y, b.y, c.y))
}
public func fmax<T, Q>(a: Vec3<T, Q>, b: Vec3<T, Q>, c: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec3(fmax(a.x, b.x, c.x), fmax(a.y, b.y, c.y), fmax(a.z, b.z, c.z))
}
public func fmax<T, Q>(a: Vec4<T, Q>, b: Vec4<T, Q>, c: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec4(fmax(a.x, b.x, c.x), fmax(a.y, b.y, c.y), fmax(a.z, b.z, c.z), fmax(a.w, b.w, c.w))
}

public func fmax<T, Q>(a: Vec1<T, Q>, b: Vec1<T, Q>, c: Vec1<T, Q>, d: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec1(fmax(a.x, b.x, c.x, d.x))
}
public func fmax<T, Q>(a: Vec2<T, Q>, b: Vec2<T, Q>, c: Vec2<T, Q>, d: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec2(fmax(a.x, b.x, c.x, d.x), fmax(a.y, b.y, c.y, d.y))
}
public func fmax<T, Q>(a: Vec3<T, Q>, b: Vec3<T, Q>, c: Vec3<T, Q>, d: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec3(fmax(a.x, b.x, c.x, d.x), fmax(a.y, b.y, c.y, d.y), fmax(a.z, b.z, c.z, d.z))
}
public func fmax<T, Q>(a: Vec4<T, Q>, b: Vec4<T, Q>, c: Vec4<T, Q>, d: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec4(fmax(a.x, b.x, c.x, d.x), fmax(a.y, b.y, c.y, d.y), fmax(a.z, b.z, c.z, d.z), fmax(a.w, b.w, c.w, d.w))
}

public func fclamp<T, Q>(x: Vec1<T, Q>, minVal: T, maxVal: T): Vec1<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec1(fclamp(x.x, minVal, maxVal))
}
public func fclamp<T, Q>(x: Vec1<T, Q>, minVal: Vec1<T, Q>, maxVal: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec1(fclamp(x.x, minVal.x, maxVal.x))
}
public func fclamp<T, Q>(x: Vec2<T, Q>, minVal: T, maxVal: T): Vec2<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec2(fclamp(x.x, minVal, maxVal), fclamp(x.y, minVal, maxVal))
}
public func fclamp<T, Q>(x: Vec2<T, Q>, minVal: Vec2<T, Q>, maxVal: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec2(fclamp(x.x, minVal.x, maxVal.x), fclamp(x.y, minVal.y, maxVal.y))
}
public func fclamp<T, Q>(x: Vec3<T, Q>, minVal: T, maxVal: T): Vec3<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec3(fclamp(x.x, minVal, maxVal), fclamp(x.y, minVal, maxVal), fclamp(x.z, minVal, maxVal))
}
public func fclamp<T, Q>(x: Vec3<T, Q>, minVal: Vec3<T, Q>, maxVal: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec3(fclamp(x.x, minVal.x, maxVal.x), fclamp(x.y, minVal.y, maxVal.y), fclamp(x.z, minVal.z, maxVal.z))
}
public func fclamp<T, Q>(x: Vec4<T, Q>, minVal: T, maxVal: T): Vec4<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec4(fclamp(x.x, minVal, maxVal), fclamp(x.y, minVal, maxVal), fclamp(x.z, minVal, maxVal), fclamp(x.w, minVal, maxVal))
}
public func fclamp<T, Q>(x: Vec4<T, Q>, minVal: Vec4<T, Q>, maxVal: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec4(fclamp(x.x, minVal.x, maxVal.x), fclamp(x.y, minVal.y, maxVal.y), fclamp(x.z, minVal.z, maxVal.z), fclamp(x.w, minVal.w, maxVal.w))
}

// ── Texture wrapping modes ──

public func clamp<T, Q>(Texcoord: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec1(clamp(Texcoord.x))
}
public func clamp<T, Q>(Texcoord: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec2(clamp(Texcoord.x), clamp(Texcoord.y))
}
public func clamp<T, Q>(Texcoord: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec3(clamp(Texcoord.x), clamp(Texcoord.y), clamp(Texcoord.z))
}
public func clamp<T, Q>(Texcoord: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec4(clamp(Texcoord.x), clamp(Texcoord.y), clamp(Texcoord.z), clamp(Texcoord.w))
}

public func repeat<T, Q>(Texcoord: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec1(repeat(Texcoord.x))
}
public func repeat<T, Q>(Texcoord: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec2(repeat(Texcoord.x), repeat(Texcoord.y))
}
public func repeat<T, Q>(Texcoord: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec3(repeat(Texcoord.x), repeat(Texcoord.y), repeat(Texcoord.z))
}
public func repeat<T, Q>(Texcoord: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec4(repeat(Texcoord.x), repeat(Texcoord.y), repeat(Texcoord.z), repeat(Texcoord.w))
}

public func mirrorClamp<T, Q>(Texcoord: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec1(mirrorClamp(Texcoord.x))
}
public func mirrorClamp<T, Q>(Texcoord: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec2(mirrorClamp(Texcoord.x), mirrorClamp(Texcoord.y))
}
public func mirrorClamp<T, Q>(Texcoord: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec3(mirrorClamp(Texcoord.x), mirrorClamp(Texcoord.y), mirrorClamp(Texcoord.z))
}
public func mirrorClamp<T, Q>(Texcoord: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec4(mirrorClamp(Texcoord.x), mirrorClamp(Texcoord.y), mirrorClamp(Texcoord.z), mirrorClamp(Texcoord.w))
}

public func mirrorRepeat<T, Q>(Texcoord: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec1(mirrorRepeat(Texcoord.x))
}
public func mirrorRepeat<T, Q>(Texcoord: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec2(mirrorRepeat(Texcoord.x), mirrorRepeat(Texcoord.y))
}
public func mirrorRepeat<T, Q>(Texcoord: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec3(mirrorRepeat(Texcoord.x), mirrorRepeat(Texcoord.y), mirrorRepeat(Texcoord.z))
}
public func mirrorRepeat<T, Q>(Texcoord: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec4(mirrorRepeat(Texcoord.x), mirrorRepeat(Texcoord.y), mirrorRepeat(Texcoord.z), mirrorRepeat(Texcoord.w))
}

// ── iround/uround ──

public func iround<T, Q>(x: Vec1<T, Q>): Vec1<Int64, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec1<Int64, Q>(iround(x.x))
}
public func iround<T, Q>(x: Vec2<T, Q>): Vec2<Int64, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec2<Int64, Q>(iround(x.x), iround(x.y))
}
public func iround<T, Q>(x: Vec3<T, Q>): Vec3<Int64, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec3<Int64, Q>(iround(x.x), iround(x.y), iround(x.z))
}
public func iround<T, Q>(x: Vec4<T, Q>): Vec4<Int64, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec4<Int64, Q>(iround(x.x), iround(x.y), iround(x.z), iround(x.w))
}

public func uround<T, Q>(x: Vec1<T, Q>): Vec1<UInt64, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec1<UInt64, Q>(uround(x.x))
}
public func uround<T, Q>(x: Vec2<T, Q>): Vec2<UInt64, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec2<UInt64, Q>(uround(x.x), uround(x.y))
}
public func uround<T, Q>(x: Vec3<T, Q>): Vec3<UInt64, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec3<UInt64, Q>(uround(x.x), uround(x.y), uround(x.z))
}
public func uround<T, Q>(x: Vec4<T, Q>): Vec4<UInt64, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec4<UInt64, Q>(uround(x.x), uround(x.y), uround(x.z), uround(x.w))
}
