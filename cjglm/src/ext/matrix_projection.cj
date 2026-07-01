package glm.ext
import glm.detail.{ Mat4x4, Vec2, Vec3, Vec4, Qualifier, inverse }
import std.math.{ FloatingPoint, Number }

func projectImpl<T, U, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<U, Q>, zZeroToOne: Bool): Vec3<T, Q>
  where T <: FloatingPoint<T>, U <: Number<U>, Q <: Qualifier {
    let tmp = proj * model * Vec4<T, Q>(obj.x, obj.y, obj.z, (Float64(1) as T).getOrThrow())
    let ndc = Vec4<T, Q>(tmp.x / tmp.w, tmp.y / tmp.w, tmp.z / tmp.w, tmp.w / tmp.w)
    let one = (Float64(1) as T).getOrThrow()
    let half = (Float64(0.5) as T).getOrThrow()
    let z = if (zZeroToOne) {(ndc.z + one) * half} else {ndc.z}
    let vpX = (viewport.x as T).getOrThrow()
    let vpY = (viewport.y as T).getOrThrow()
    let vpZ = (viewport.z as T).getOrThrow()
    let vpW = (viewport.w as T).getOrThrow()
    Vec3<T, Q>(vpX + vpZ * (ndc.x * half + half), vpY + vpW * (ndc.y * half + half), z)
}

public func projectZO<T, U, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<U, Q>): Vec3<T, Q>
  where T <: FloatingPoint<T>, U <: Number<U>, Q <: Qualifier {
    projectImpl(obj, model, proj, viewport, true)
}

public func projectNO<T, U, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<U, Q>): Vec3<T, Q>
  where T <: FloatingPoint<T>, U <: Number<U>, Q <: Qualifier {
    projectImpl(obj, model, proj, viewport, false)
}

public func project<T, U, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<U, Q>): Vec3<T, Q>
  where T <: FloatingPoint<T>, U <: Number<U>, Q <: Qualifier {
    projectZO(obj, model, proj, viewport)
}

func unProjectImpl<T, U, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<U, Q>, zZeroToOne: Bool): Vec3<T, Q>
  where T <: FloatingPoint<T>, U <: Number<U>, Q <: Qualifier {
    let one = (Float64(1) as T).getOrThrow()
    let two = (Float64(2) as T).getOrThrow()
    let vpX = (viewport.x as T).getOrThrow()
    let vpY = (viewport.y as T).getOrThrow()
    let vpZ = (viewport.z as T).getOrThrow()
    let vpW = (viewport.w as T).getOrThrow()
    let ndcX = (two * (win.x - vpX) / vpZ) - one
    let ndcY = (two * (win.y - vpY) / vpW) - one
    let ndcZ = if (zZeroToOne) {two * win.z - one} else {win.z}
    let ndc = Vec4<T, Q>(ndcX, ndcY, ndcZ, one)
    let invMVP = inverse(proj * model)
    let tmp = invMVP * ndc
    Vec3<T, Q>(tmp.x / tmp.w, tmp.y / tmp.w, tmp.z / tmp.w)
}

public func unProjectZO<T, U, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<U, Q>): Vec3<T, Q>
  where T <: FloatingPoint<T>, U <: Number<U>, Q <: Qualifier {
    unProjectImpl(win, model, proj, viewport, true)
}

public func unProjectNO<T, U, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<U, Q>): Vec3<T, Q>
  where T <: FloatingPoint<T>, U <: Number<U>, Q <: Qualifier {
    unProjectImpl(win, model, proj, viewport, false)
}

public func unProject<T, U, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<U, Q>): Vec3<T, Q>
  where T <: FloatingPoint<T>, U <: Number<U>, Q <: Qualifier {
    unProjectZO(win, model, proj, viewport)
}

public func pickMatrix<T, U, Q>(center: Vec2<T, Q>, delta: Vec2<T, Q>, viewport: Vec4<U, Q>): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, U <: Number<U>, Q <: Qualifier {
    let zero = (Float64(0) as T).getOrThrow()
    let one = (Float64(1) as T).getOrThrow()
    let two = (Float64(2) as T).getOrThrow()
    let vpZ = (viewport.z as T).getOrThrow()
    let vpW = (viewport.w as T).getOrThrow()
    let vpX = (viewport.x as T).getOrThrow()
    let vpY = (viewport.y as T).getOrThrow()
    let sx = vpZ / (two * delta.x)
    let sy = vpW / (two * delta.y)
    let tx = (vpZ + two * (vpX - center.x)) / (two * delta.x)
    let ty = (vpW + two * (vpY - center.y)) / (two * delta.y)
    Mat4x4<T, Q>(
        Vec4<T, Q>(sx, zero, zero, zero),
        Vec4<T, Q>(zero, sy, zero, zero),
        Vec4<T, Q>(zero, zero, one, zero),
        Vec4<T, Q>(tx, ty, zero, one)
    )
}
