package glm.gtc
import glm.detail.{Vec1, Vec2, Vec3, Vec4, Qualifier, floor, fract, abs, min, max, dot, mix, step, clamp, roundEven, mod, trunc, lessThan}
import std.math.{FloatingPoint, Number}

// ── Private scalar helpers ──

private func mod289<T>(x: T): T where T <: FloatingPoint<T> {
    let inv289 = ((Float64(1.0) / Float64(289.0)) as T).getOrThrow()
    let t289 = (Float64(289.0) as T).getOrThrow()
    x - floor(x * inv289) * t289
}

private func permute<T>(x: T): T where T <: FloatingPoint<T> {
    let t34 = (Float64(34.0) as T).getOrThrow()
    let t1 = (Float64(1.0) as T).getOrThrow()
    mod289(((x * t34 + t1) * x))
}

private func mod289<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: Number<T> & FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let inv289 = ((Float64(1.0) / Float64(289.0)) as T).getOrThrow()
    let t289 = (Float64(289.0) as T).getOrThrow()
    x - floor(x * Vec2<T, Q>(inv289, inv289)) * Vec2<T, Q>(t289, t289)
}

private func mod289<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T> & FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let inv289 = ((Float64(1.0) / Float64(289.0)) as T).getOrThrow()
    let t289 = (Float64(289.0) as T).getOrThrow()
    x - floor(x * Vec3<T, Q>(inv289, inv289, inv289)) * Vec3<T, Q>(t289, t289, t289)
}

private func mod289<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: Number<T> & FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let inv289 = ((Float64(1.0) / Float64(289.0)) as T).getOrThrow()
    let t289 = (Float64(289.0) as T).getOrThrow()
    x - floor(x * Vec4<T, Q>(inv289, inv289, inv289, inv289)) * Vec4<T, Q>(t289, t289, t289, t289)
}

private func permute<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: Number<T> & FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let t34 = (Float64(34.0) as T).getOrThrow()
    let t1 = (Float64(1.0) as T).getOrThrow()
    mod289(((x * Vec2<T, Q>(t34, t34) + Vec2<T, Q>(t1, t1)) * x))
}

private func permute<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T> & FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let t34 = (Float64(34.0) as T).getOrThrow()
    let t1 = (Float64(1.0) as T).getOrThrow()
    mod289(((x * Vec3<T, Q>(t34, t34, t34) + Vec3<T, Q>(t1, t1, t1)) * x))
}

private func permute<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: Number<T> & FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let t34 = (Float64(34.0) as T).getOrThrow()
    let t1 = (Float64(1.0) as T).getOrThrow()
    mod289(((x * Vec4<T, Q>(t34, t34, t34, t34) + Vec4<T, Q>(t1, t1, t1, t1)) * x))
}

private func taylorInvSqrt<T, Q>(r: Vec2<T, Q>): Vec2<T, Q> where T <: Number<T> & FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let c1 = (Float64(1.79284291400159) as T).getOrThrow()
    let c2 = (Float64(0.85373472095314) as T).getOrThrow()
    Vec2<T, Q>(c1, c1) - Vec2<T, Q>(c2, c2) * r
}

private func taylorInvSqrt<T, Q>(r: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T> & FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let c1 = (Float64(1.79284291400159) as T).getOrThrow()
    let c2 = (Float64(0.85373472095314) as T).getOrThrow()
    Vec3<T, Q>(c1, c1, c1) - Vec3<T, Q>(c2, c2, c2) * r
}

private func taylorInvSqrt<T, Q>(r: Vec4<T, Q>): Vec4<T, Q> where T <: Number<T> & FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let c1 = (Float64(1.79284291400159) as T).getOrThrow()
    let c2 = (Float64(0.85373472095314) as T).getOrThrow()
    Vec4<T, Q>(c1, c1, c1, c1) - Vec4<T, Q>(c2, c2, c2, c2) * r
}

private func fade<T, Q>(t: Vec2<T, Q>): Vec2<T, Q> where T <: Number<T> & FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let t6 = (Float64(6.0) as T).getOrThrow()
    let t15 = (Float64(15.0) as T).getOrThrow()
    let t10 = (Float64(10.0) as T).getOrThrow()
    t * t * t * (t * (t * Vec2<T, Q>(t6, t6) - Vec2<T, Q>(t15, t15)) + Vec2<T, Q>(t10, t10))
}

private func fade<T, Q>(t: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T> & FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let t6 = (Float64(6.0) as T).getOrThrow()
    let t15 = (Float64(15.0) as T).getOrThrow()
    let t10 = (Float64(10.0) as T).getOrThrow()
    t * t * t * (t * (t * Vec3<T, Q>(t6, t6, t6) - Vec3<T, Q>(t15, t15, t15)) + Vec3<T, Q>(t10, t10, t10))
}

private func fade<T, Q>(t: Vec4<T, Q>): Vec4<T, Q> where T <: Number<T> & FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let t6 = (Float64(6.0) as T).getOrThrow()
    let t15 = (Float64(15.0) as T).getOrThrow()
    let t10 = (Float64(10.0) as T).getOrThrow()
    t * t * t * (t * (t * Vec4<T, Q>(t6, t6, t6, t6) - Vec4<T, Q>(t15, t15, t15, t15)) + Vec4<T, Q>(t10, t10, t10, t10))
}

private func grad4<T, Q>(j: T, ip: Vec4<T, Q>): Vec4<T, Q> where T <: Number<T> & FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let zero = (Float64(0.0) as T).getOrThrow()
    let one = (Float64(1.0) as T).getOrThrow()
    let two = (Float64(2.0) as T).getOrThrow()
    let f7 = (Float64(7.0) as T).getOrThrow()
    let pxyz = floor(fract(Vec3<T, Q>(j, j, j) / Vec3<T, Q>(ip.x, ip.y, ip.z)) * Vec3<T, Q>(f7, f7, f7)) - Vec3<T, Q>(one, one, one)
    let pw = one - two * fract(j / ip.w)
    let pz = (Float64(0.5) as T).getOrThrow() - (Float64(0.5) as T).getOrThrow() * abs(pxyz.x)
    let py = (Float64(0.5) as T).getOrThrow() - (Float64(0.5) as T).getOrThrow() * abs(pxyz.y)
    let px = (Float64(0.5) as T).getOrThrow() - (Float64(0.5) as T).getOrThrow() * abs(pxyz.z)
    let oz = step(Vec3<T, Q>(px, py, pz), Vec3<T, Q>(zero, zero, zero)) - Vec3<T, Q>(one, one, one) * step(-Vec3<T, Q>(px, py, pz), Vec3<T, Q>(zero, zero, zero))
    Vec4<T, Q>(oz.x, oz.y, oz.z, pw)
}

// ── Perlin noise: scalar 1D ──

public func perlin1D<T>(x: T): T where T <: FloatingPoint<T> {
    let one = (Float64(1.0) as T).getOrThrow()
    let two = (Float64(2.0) as T).getOrThrow()
    let t41 = (Float64(41.0) as T).getOrThrow()
    let ix = floor(x)
    let fx = fract(x)
    let a = permute(ix)
    let b = permute(a + one)
    let g0 = fract(a / t41) * two - one
    let g1 = fract(b / t41) * two - one
    let u = fx * fx * fx * (fx * (fx * (Float64(6.0) as T).getOrThrow() - (Float64(15.0) as T).getOrThrow()) + (Float64(10.0) as T).getOrThrow())
    mix(g0 * fx, g1 * (fx - one), u)
}

public func perlin1D<T>(x: T, period: T): T where T <: FloatingPoint<T> {
    let one = (Float64(1.0) as T).getOrThrow()
    let two = (Float64(2.0) as T).getOrThrow()
    let t41 = (Float64(41.0) as T).getOrThrow()
    let ix = floor(x)
    let fx = fract(x)
    let modP = ix - floor(ix / period) * period
    let a = permute(modP)
    let b = permute(modP + one)
    let g0 = fract(a / t41) * two - one
    let g1 = fract(b / t41) * two - one
    let u = fx * fx * fx * (fx * (fx * (Float64(6.0) as T).getOrThrow() - (Float64(15.0) as T).getOrThrow()) + (Float64(10.0) as T).getOrThrow())
    mix(g0 * fx, g1 * (fx - one), u)
}

// ── Perlin noise: 2D (shared impl for plain + periodic) ──

private func perlin2Imp<T, Q>(v: Vec2<T, Q>, period: Vec2<T, Q>, hasPeriod: Bool): T where T <: Number<T> & FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let one = (Float64(1.0) as T).getOrThrow()
    let half = (Float64(0.5) as T).getOrThrow()
    let zero = (Float64(0.0) as T).getOrThrow()
    let f7 = (Float64(7.0) as T).getOrThrow()
    let Pi0 = floor(v)
    let Pf0 = fract(v)
    let Pi0m = mod289(Pi0)
    let Pi1m = mod289(Pi0 + Vec2<T, Q>(one, one))
    let Pi0p = if (hasPeriod) { Pi0m - floor(Pi0m / period) * period } else { Pi0m }
    let Pi1p = if (hasPeriod) { Pi1m - floor(Pi1m / period) * period } else { Pi1m }
    let ix = Vec4<T, Q>(Pi0p.x, Pi1p.x, Pi0p.x, Pi1p.x)
    let iy = Vec4<T, Q>(Pi0p.y, Pi0p.y, Pi1p.y, Pi1p.y)
    let ixy = permute(permute(ix) + iy)
    let gx0 = ixy / Vec4<T, Q>(f7, f7, f7, f7)
    let gy0 = fract(floor(gx0) / Vec4<T, Q>(f7, f7, f7, f7)) - Vec4<T, Q>(half, half, half, half)
    let gx0f = fract(gx0)
    let gz0 = Vec4<T, Q>(half, half, half, half) - abs(gx0f) - abs(gy0)
    let sz0 = step(gz0, Vec4<T, Q>(zero, zero, zero, zero))
    let gx0n = gx0f + sz0 * (step(Vec4<T, Q>(zero, zero, zero, zero), gx0f) - Vec4<T, Q>(half, half, half, half))
    let gy0n = gy0 + sz0 * (step(Vec4<T, Q>(zero, zero, zero, zero), gy0) - Vec4<T, Q>(half, half, half, half))
    let vec0 = Vec4<T, Q>(Pf0.x, Pf0.x + one, Pf0.x, Pf0.x + one)
    let vec1 = Vec4<T, Q>(Pf0.y, Pf0.y, Pf0.y + one, Pf0.y + one)
    let n00 = gx0n * vec0 + gy0n * vec1
    let fade_xy = fade(Pf0)
    let nx0 = mix(n00.x, n00.y, fade_xy.x)
    let nx1 = mix(n00.z, n00.w, fade_xy.x)
    mix(nx0, nx1, fade_xy.y)
}

public func perlin2D<T, Q>(v: Vec2<T, Q>): T where T <: Number<T> & FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    perlin2Imp(v, Vec2<T, Q>((Float64(0.0) as T).getOrThrow(), (Float64(0.0) as T).getOrThrow()), false)
}

public func perlin2D<T, Q>(v: Vec2<T, Q>, period: Vec2<T, Q>): T where T <: Number<T> & FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    perlin2Imp(v, period, true)
}

// ── Perlin noise: 3D (shared impl for plain + periodic) ──

private func perlin3Imp<T, Q>(v: Vec3<T, Q>, period: Vec3<T, Q>, hasPeriod: Bool): T where T <: Number<T> & FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let one = (Float64(1.0) as T).getOrThrow()
    let half = (Float64(0.5) as T).getOrThrow()
    let zero = (Float64(0.0) as T).getOrThrow()
    let f7 = (Float64(7.0) as T).getOrThrow()
    let Pi0 = floor(v)
    let Pf0 = fract(v)
    let Pi0m = mod289(Pi0)
    let Pi1m = mod289(Pi0 + Vec3<T, Q>(one, one, one))
    let Pi0p = if (hasPeriod) { Pi0m - floor(Pi0m / period) * period } else { Pi0m }
    let Pi1p = if (hasPeriod) { Pi1m - floor(Pi1m / period) * period } else { Pi1m }
    let ix = Vec4<T, Q>(Pi0p.x, Pi1p.x, Pi0p.x, Pi1p.x)
    let iy = Vec4<T, Q>(Pi0p.y, Pi0p.y, Pi1p.y, Pi1p.y)
    let iz0 = Vec4<T, Q>(Pi0p.z, Pi0p.z, Pi0p.z, Pi0p.z)
    let iz1 = Vec4<T, Q>(Pi1p.z, Pi1p.z, Pi1p.z, Pi1p.z)
    let ixy = permute(permute(ix) + iy)
    let ixy0 = permute(ixy + iz0)
    let ixy1 = permute(ixy + iz1)
    let gx00 = ixy0 / Vec4<T, Q>(f7, f7, f7, f7)
    let gy00 = fract(floor(gx00) / Vec4<T, Q>(f7, f7, f7, f7)) - Vec4<T, Q>(half, half, half, half)
    let gx0f = fract(gx00)
    let gz00 = Vec4<T, Q>(half, half, half, half) - abs(gx0f) - abs(gy00)
    let sz00 = step(gz00, Vec4<T, Q>(zero, zero, zero, zero))
    let gx0n = gx0f + sz00 * (step(Vec4<T, Q>(zero, zero, zero, zero), gx0f) - Vec4<T, Q>(half, half, half, half))
    let gy0n = gy00 + sz00 * (step(Vec4<T, Q>(zero, zero, zero, zero), gy00) - Vec4<T, Q>(half, half, half, half))
    let gx10 = ixy1 / Vec4<T, Q>(f7, f7, f7, f7)
    let gy10 = fract(floor(gx10) / Vec4<T, Q>(f7, f7, f7, f7)) - Vec4<T, Q>(half, half, half, half)
    let gx1f = fract(gx10)
    let gz10 = Vec4<T, Q>(half, half, half, half) - abs(gx1f) - abs(gy10)
    let sz10 = step(gz10, Vec4<T, Q>(zero, zero, zero, zero))
    let gx1n = gx1f + sz10 * (step(Vec4<T, Q>(zero, zero, zero, zero), gx1f) - Vec4<T, Q>(half, half, half, half))
    let gy1n = gy10 + sz10 * (step(Vec4<T, Q>(zero, zero, zero, zero), gy10) - Vec4<T, Q>(half, half, half, half))
    let vec00 = Vec4<T, Q>(Pf0.x, Pf0.x + one, Pf0.x, Pf0.x + one)
    let vec01 = Vec4<T, Q>(Pf0.y, Pf0.y, Pf0.y + one, Pf0.y + one)
    let n00 = gx0n * vec00 + gy0n * vec01 + iz0
    let n10 = gx1n * vec00 + gy1n * vec01 + iz1
    let fade_xyz = fade(Pf0)
    let nx0 = mix(n00.x, n00.y, fade_xyz.x)
    let nx1 = mix(n00.z, n00.w, fade_xyz.x)
    let ny0 = mix(nx0, nx1, fade_xyz.y)
    let nz0 = mix(n10.x, n10.y, fade_xyz.x)
    let nz1 = mix(n10.z, n10.w, fade_xyz.x)
    let ny1 = mix(nz0, nz1, fade_xyz.y)
    mix(ny0, ny1, fade_xyz.z)
}

public func perlin3D<T, Q>(v: Vec3<T, Q>): T where T <: Number<T> & FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    perlin3Imp(v, Vec3<T, Q>((Float64(0.0) as T).getOrThrow(), (Float64(0.0) as T).getOrThrow(), (Float64(0.0) as T).getOrThrow()), false)
}

public func perlin3D<T, Q>(v: Vec3<T, Q>, period: Vec3<T, Q>): T where T <: Number<T> & FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    perlin3Imp(v, period, true)
}

// ── Perlin noise: 4D (shared impl for plain + periodic) ──

private func perlin4Imp<T, Q>(v: Vec4<T, Q>, period: Vec4<T, Q>, hasPeriod: Bool): T where T <: Number<T> & FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let one = (Float64(1.0) as T).getOrThrow()
    let half = (Float64(0.5) as T).getOrThrow()
    let zero = (Float64(0.0) as T).getOrThrow()
    let f7 = (Float64(7.0) as T).getOrThrow()
    let Pi0 = floor(v)
    let Pf0 = fract(v)
    let Pi0m = mod289(Pi0)
    let Pi1m = mod289(Pi0 + Vec4<T, Q>(one, one, one, one))
    let Pi0p = if (hasPeriod) { Pi0m - floor(Pi0m / period) * period } else { Pi0m }
    let Pi1p = if (hasPeriod) { Pi1m - floor(Pi1m / period) * period } else { Pi1m }
    let ix = Vec4<T, Q>(Pi0p.x, Pi1p.x, Pi0p.x, Pi1p.x)
    let iy = Vec4<T, Q>(Pi0p.y, Pi0p.y, Pi1p.y, Pi1p.y)
    let iz0 = Vec4<T, Q>(Pi0p.z, Pi0p.z, Pi0p.z, Pi0p.z)
    let iz1 = Vec4<T, Q>(Pi1p.z, Pi1p.z, Pi1p.z, Pi1p.z)
    let iw0 = Vec4<T, Q>(Pi0p.w, Pi0p.w, Pi0p.w, Pi0p.w)
    let iw1 = Vec4<T, Q>(Pi1p.w, Pi1p.w, Pi1p.w, Pi1p.w)
    let ixy = permute(permute(ix) + iy)
    let ixy0 = permute(ixy + iz0)
    let ixy1 = permute(ixy + iz1)
    let ixy00 = permute(ixy0 + iw0)
    let ixy01 = permute(ixy0 + iw1)
    let ixy10 = permute(ixy1 + iw0)
    let ixy11 = permute(ixy1 + iw1)
    let gx00 = ixy00 / Vec4<T, Q>(f7, f7, f7, f7)
    let gy00 = fract(floor(gx00) / Vec4<T, Q>(f7, f7, f7, f7)) - Vec4<T, Q>(half, half, half, half)
    let gx0f = fract(gx00)
    let gz00 = Vec4<T, Q>(half, half, half, half) - abs(gx0f) - abs(gy00)
    let sz00 = step(gz00, Vec4<T, Q>(zero, zero, zero, zero))
    let gx0n = gx0f + sz00 * (step(Vec4<T, Q>(zero, zero, zero, zero), gx0f) - Vec4<T, Q>(half, half, half, half))
    let gy0n = gy00 + sz00 * (step(Vec4<T, Q>(zero, zero, zero, zero), gy00) - Vec4<T, Q>(half, half, half, half))
    let gx10 = ixy01 / Vec4<T, Q>(f7, f7, f7, f7)
    let gy10 = fract(floor(gx10) / Vec4<T, Q>(f7, f7, f7, f7)) - Vec4<T, Q>(half, half, half, half)
    let gx1f = fract(gx10)
    let gz10 = Vec4<T, Q>(half, half, half, half) - abs(gx1f) - abs(gy10)
    let sz10 = step(gz10, Vec4<T, Q>(zero, zero, zero, zero))
    let gx1n = gx1f + sz10 * (step(Vec4<T, Q>(zero, zero, zero, zero), gx1f) - Vec4<T, Q>(half, half, half, half))
    let gy1n = gy10 + sz10 * (step(Vec4<T, Q>(zero, zero, zero, zero), gy10) - Vec4<T, Q>(half, half, half, half))
    let gx20 = ixy10 / Vec4<T, Q>(f7, f7, f7, f7)
    let gy20 = fract(floor(gx20) / Vec4<T, Q>(f7, f7, f7, f7)) - Vec4<T, Q>(half, half, half, half)
    let gx2f = fract(gx20)
    let gz20 = Vec4<T, Q>(half, half, half, half) - abs(gx2f) - abs(gy20)
    let sz20 = step(gz20, Vec4<T, Q>(zero, zero, zero, zero))
    let gx2n = gx2f + sz20 * (step(Vec4<T, Q>(zero, zero, zero, zero), gx2f) - Vec4<T, Q>(half, half, half, half))
    let gy2n = gy20 + sz20 * (step(Vec4<T, Q>(zero, zero, zero, zero), gy20) - Vec4<T, Q>(half, half, half, half))
    let gx30 = ixy11 / Vec4<T, Q>(f7, f7, f7, f7)
    let gy30 = fract(floor(gx30) / Vec4<T, Q>(f7, f7, f7, f7)) - Vec4<T, Q>(half, half, half, half)
    let gx3f = fract(gx30)
    let gz30 = Vec4<T, Q>(half, half, half, half) - abs(gx3f) - abs(gy30)
    let sz30 = step(gz30, Vec4<T, Q>(zero, zero, zero, zero))
    let gx3n = gx3f + sz30 * (step(Vec4<T, Q>(zero, zero, zero, zero), gx3f) - Vec4<T, Q>(half, half, half, half))
    let gy3n = gy30 + sz30 * (step(Vec4<T, Q>(zero, zero, zero, zero), gy30) - Vec4<T, Q>(half, half, half, half))
    let vec00 = Vec4<T, Q>(Pf0.x, Pf0.x + one, Pf0.x, Pf0.x + one)
    let vec01 = Vec4<T, Q>(Pf0.y, Pf0.y, Pf0.y + one, Pf0.y + one)
    let n00 = gx0n * vec00 + gy0n * vec01 + iz0 + iw0
    let n01 = gx1n * vec00 + gy1n * vec01 + iz0 + iw1
    let n10 = gx2n * vec00 + gy2n * vec01 + iz1 + iw0
    let n11 = gx3n * vec00 + gy3n * vec01 + iz1 + iw1
    let fade_xyzw = fade(Pf0)
    let nx00 = mix(n00.x, n00.y, fade_xyzw.x)
    let nx01 = mix(n00.z, n00.w, fade_xyzw.x)
    let ny00 = mix(nx00, nx01, fade_xyzw.y)
    let nx10 = mix(n01.x, n01.y, fade_xyzw.x)
    let nx11 = mix(n01.z, n01.w, fade_xyzw.x)
    let ny01 = mix(nx10, nx11, fade_xyzw.y)
    let nz00 = mix(ny00, ny01, fade_xyzw.z)
    let nx20 = mix(n10.x, n10.y, fade_xyzw.x)
    let nx21 = mix(n10.z, n10.w, fade_xyzw.x)
    let ny10 = mix(nx20, nx21, fade_xyzw.y)
    let nx30 = mix(n11.x, n11.y, fade_xyzw.x)
    let nx31 = mix(n11.z, n11.w, fade_xyzw.x)
    let ny11 = mix(nx30, nx31, fade_xyzw.y)
    let nz10 = mix(ny10, ny11, fade_xyzw.z)
    mix(nz00, nz10, fade_xyzw.w)
}

public func perlin4D<T, Q>(v: Vec4<T, Q>): T where T <: Number<T> & FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    perlin4Imp(v, Vec4<T, Q>((Float64(0.0) as T).getOrThrow(), (Float64(0.0) as T).getOrThrow(), (Float64(0.0) as T).getOrThrow(), (Float64(0.0) as T).getOrThrow()), false)
}

public func perlin4D<T, Q>(v: Vec4<T, Q>, period: Vec4<T, Q>): T where T <: Number<T> & FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    perlin4Imp(v, period, true)
}

// ── Simplex noise 1D ──

public func simplex1D<T>(x: T): T where T <: FloatingPoint<T> {
    let one = (Float64(1.0) as T).getOrThrow()
    let i0 = floor(x)
    let i1 = i0 + one
    let x0 = x - i0
    let x1 = x0 - one
    let t0 = one - x0 * x0
    let n0 = t0 * t0 * t0 * t0 * x0
    let t1 = one - x1 * x1
    let n1 = t1 * t1 * t1 * t1 * x1
    (Float64(0.395) as T).getOrThrow() * (n0 + n1)
}

// ── Simplex noise 2D ──

public func simplex2D<T, Q>(v: Vec2<T, Q>): T where T <: Number<T> & FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let one = (Float64(1.0) as T).getOrThrow()
    let zero = (Float64(0.0) as T).getOrThrow()
    let f2 = (Float64(0.3660254037844386) as T).getOrThrow()
    let g2 = (Float64(0.21132486540518713) as T).getOrThrow()
    let sg = v.x + v.y
    let s = sg * f2
    let i = floor(Vec2(v.x + s, v.y + s))
    let ig = i.x + i.y
    let t = ig * g2
    let x0 = Vec2(v.x - (i.x - t), v.y - (i.y - t))
    let i1 = if (x0.x > x0.y) { Vec2(one, zero) } else { Vec2(zero, one) }
    let x1 = Vec2(x0.x - i1.x + g2, x0.y - i1.y + g2)
    let x2 = Vec2(x0.x - one + g2 + g2, x0.y - one + g2 + g2)
    let iMod = mod289(Vec2(i.x, i.y))
    let h0 = permute(permute(iMod.x) + iMod.y)
    let h1 = permute(permute(iMod.x + i1.x) + iMod.y + i1.y)
    let h2 = permute(permute(iMod.x + one) + iMod.y + one)
    let n1 = simplex2Contrib(h0, x0)
    let n2 = simplex2Contrib(h1, x1)
    let n3 = simplex2Contrib(h2, x2)
    (Float64(70.0) as T).getOrThrow() * (n1 + n2 + n3)
}

private func simplex2Contrib<T, Q>(hash: T, x: Vec2<T, Q>): T where T <: Number<T> & FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let half = (Float64(0.5) as T).getOrThrow()
    let zero = (Float64(0.0) as T).getOrThrow()
    let t = half - x.x * x.x - x.y * x.y
    if (t < zero) {
        zero
    } else {
        let hInt = (hash as Int64).getOrThrow()
        let h = hInt & Int64(7)
        let u = if (h < Int64(4)) { x.x } else { x.y }
        let v = if (h < Int64(4)) { x.y } else { x.x }
        let two = (Float64(2.0) as T).getOrThrow()
        let grad = (if ((h & Int64(1)) != Int64(0)) { -u } else { u }) + (if ((h & Int64(2)) != Int64(0)) { -two * v } else { two * v })
        let t4 = t * t * t * t
        t4 * grad
    }
}

// ── Simplex noise 3D ──

public func simplex3D<T, Q>(v: Vec3<T, Q>): T where T <: Number<T> & FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let one = (Float64(1.0) as T).getOrThrow()
    let zero = (Float64(0.0) as T).getOrThrow()
    let f3 = (Float64(0.3333333333333333) as T).getOrThrow()
    let g3 = (Float64(0.16666666666666666) as T).getOrThrow()
    let sg = v.x + v.y + v.z
    let s = sg * f3
    let i = floor(Vec3<T, Q>(v.x + s, v.y + s, v.z + s))
    let ig = i.x + i.y + i.z
    let t = ig * g3
    let x0 = Vec3<T, Q>(v.x - (i.x - t), v.y - (i.y - t), v.z - (i.z - t))
    let i1: Vec3<T, Q>
    let j1: Vec3<T, Q>
    if (x0.x >= x0.y) {
        if (x0.y >= x0.z) {
            i1 = Vec3<T, Q>(one, zero, zero); j1 = Vec3<T, Q>(zero, one, zero)
        } else if (x0.x >= x0.z) {
            i1 = Vec3<T, Q>(one, zero, zero); j1 = Vec3<T, Q>(zero, zero, one)
        } else {
            i1 = Vec3<T, Q>(zero, zero, one); j1 = Vec3<T, Q>(one, zero, zero)
        }
    } else {
        if (x0.y < x0.z) {
            i1 = Vec3<T, Q>(zero, one, zero); j1 = Vec3<T, Q>(zero, zero, one)
        } else if (x0.x < x0.z) {
            i1 = Vec3<T, Q>(zero, one, zero); j1 = Vec3<T, Q>(one, zero, zero)
        } else {
            i1 = Vec3<T, Q>(one, zero, zero); j1 = Vec3<T, Q>(zero, one, zero)
        }
    }
    let x1 = Vec3<T, Q>(x0.x - i1.x + g3, x0.y - i1.y + g3, x0.z - i1.z + g3)
    let x2 = Vec3<T, Q>(x0.x - j1.x + g3 + g3, x0.y - j1.y + g3 + g3, x0.z - j1.z + g3 + g3)
    let x3 = Vec3<T, Q>(x0.x - one + g3 + g3 + g3, x0.y - one + g3 + g3 + g3, x0.z - one + g3 + g3 + g3)
    let iMod = mod289(Vec3<T, Q>(i.x, i.y, i.z))
    let h0 = permute(permute(permute(iMod.x) + iMod.y) + iMod.z)
    let h1 = permute(permute(permute(iMod.x + i1.x) + iMod.y + i1.y) + iMod.z + i1.z)
    let h2 = permute(permute(permute(iMod.x + j1.x) + iMod.y + j1.y) + iMod.z + j1.z)
    let h3 = permute(permute(permute(iMod.x + one) + iMod.y + one) + iMod.z + one)
    let n1 = simplex3Contrib(h0, x0)
    let n2 = simplex3Contrib(h1, x1)
    let n3 = simplex3Contrib(h2, x2)
    let n4 = simplex3Contrib(h3, x3)
    (Float64(32.0) as T).getOrThrow() * (n1 + n2 + n3 + n4)
}

private func simplex3Contrib<T, Q>(hash: T, x: Vec3<T, Q>): T where T <: Number<T> & FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let zero = (Float64(0.0) as T).getOrThrow()
    let t = (Float64(0.6) as T).getOrThrow() - x.x * x.x - x.y * x.y - x.z * x.z
    if (t < zero) {
        zero
    } else {
        let hInt = (hash as Int64).getOrThrow()
        let h = hInt & Int64(15)
        let a = if (h < Int64(8)) { x.x } else { x.y }
        let b = if (h < Int64(4)) { x.y } else if (h == Int64(12) || h == Int64(14)) { x.x } else { x.z }
        let t4 = t * t * t * t
        t4 * (a + b)
    }
}

// ── Simplex noise 4D ──

public func simplex4D<T, Q>(v: Vec4<T, Q>): T where T <: Number<T> & FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let one = (Float64(1.0) as T).getOrThrow()
    let zero = (Float64(0.0) as T).getOrThrow()
    let half = (Float64(0.5) as T).getOrThrow()
    let f4 = (Float64(0.3090169943749474) as T).getOrThrow()
    let g4 = (Float64(0.1381966011250105) as T).getOrThrow()
    let sg = v.x + v.y + v.z + v.w
    let s = sg * f4
    let i = floor(Vec4<T, Q>(v.x + s, v.y + s, v.z + s, v.w + s))
    let ig = i.x + i.y + i.z + i.w
    let t = ig * g4
    let x0 = Vec4<T, Q>(v.x - (i.x - t), v.y - (i.y - t), v.z - (i.z - t), v.w - (i.w - t))
    let i1: Vec4<T, Q>
    let j1: Vec4<T, Q>
    let k1: Vec4<T, Q>
    if (x0.x >= x0.y) {
        if (x0.y >= x0.z) {
            if (x0.z >= x0.w) {
                i1 = Vec4<T, Q>(one, zero, zero, zero)
                j1 = Vec4<T, Q>(zero, one, zero, zero)
                k1 = Vec4<T, Q>(zero, zero, one, zero)
            } else if (x0.y >= x0.w) {
                i1 = Vec4<T, Q>(one, zero, zero, zero)
                j1 = Vec4<T, Q>(zero, one, zero, zero)
                k1 = Vec4<T, Q>(zero, zero, zero, one)
            } else {
                i1 = Vec4<T, Q>(one, zero, zero, zero)
                j1 = Vec4<T, Q>(zero, zero, zero, one)
                k1 = Vec4<T, Q>(zero, one, zero, zero)
            }
        } else if (x0.y < x0.z) {
            if (x0.z >= x0.w) {
                i1 = Vec4<T, Q>(one, zero, zero, zero)
                j1 = Vec4<T, Q>(zero, zero, one, zero)
                k1 = Vec4<T, Q>(zero, one, zero, zero)
            } else if (x0.x >= x0.w) {
                i1 = Vec4<T, Q>(one, zero, zero, zero)
                j1 = Vec4<T, Q>(zero, zero, one, zero)
                k1 = Vec4<T, Q>(zero, zero, zero, one)
            } else {
                i1 = Vec4<T, Q>(zero, zero, one, zero)
                j1 = Vec4<T, Q>(zero, zero, zero, one)
                k1 = Vec4<T, Q>(one, zero, zero, zero)
            }
        } else {
            if (x0.y >= x0.w) {
                i1 = Vec4<T, Q>(zero, one, zero, zero)
                j1 = Vec4<T, Q>(one, zero, zero, zero)
                k1 = Vec4<T, Q>(zero, zero, one, zero)
            } else if (x0.x >= x0.w) {
                i1 = Vec4<T, Q>(zero, one, zero, zero)
                j1 = Vec4<T, Q>(one, zero, zero, zero)
                k1 = Vec4<T, Q>(zero, zero, zero, one)
            } else {
                i1 = Vec4<T, Q>(zero, one, zero, zero)
                j1 = Vec4<T, Q>(zero, zero, zero, one)
                k1 = Vec4<T, Q>(one, zero, zero, zero)
            }
        }
    } else {
        if (x0.y >= x0.z) {
            if (x0.z >= x0.w) {
                i1 = Vec4<T, Q>(zero, one, zero, zero)
                j1 = Vec4<T, Q>(zero, zero, one, zero)
                k1 = Vec4<T, Q>(one, zero, zero, zero)
            } else if (x0.y >= x0.w) {
                i1 = Vec4<T, Q>(zero, one, zero, zero)
                j1 = Vec4<T, Q>(zero, zero, one, zero)
                k1 = Vec4<T, Q>(zero, zero, zero, one)
            } else {
                i1 = Vec4<T, Q>(zero, one, zero, zero)
                j1 = Vec4<T, Q>(zero, zero, zero, one)
                k1 = Vec4<T, Q>(zero, zero, one, zero)
            }
        } else if (x0.y < x0.z) {
            if (x0.z >= x0.w) {
                i1 = Vec4<T, Q>(zero, zero, one, zero)
                j1 = Vec4<T, Q>(zero, one, zero, zero)
                k1 = Vec4<T, Q>(one, zero, zero, zero)
            } else if (x0.y >= x0.w) {
                i1 = Vec4<T, Q>(zero, zero, one, zero)
                j1 = Vec4<T, Q>(zero, one, zero, zero)
                k1 = Vec4<T, Q>(zero, zero, zero, one)
            } else {
                i1 = Vec4<T, Q>(zero, zero, one, zero)
                j1 = Vec4<T, Q>(zero, zero, zero, one)
                k1 = Vec4<T, Q>(zero, one, zero, zero)
            }
        } else {
            if (x0.z >= x0.w) {
                i1 = Vec4<T, Q>(zero, zero, zero, one)
                j1 = Vec4<T, Q>(zero, one, zero, zero)
                k1 = Vec4<T, Q>(one, zero, zero, zero)
            } else if (x0.y >= x0.w) {
                i1 = Vec4<T, Q>(zero, zero, zero, one)
                j1 = Vec4<T, Q>(zero, one, zero, zero)
                k1 = Vec4<T, Q>(zero, zero, one, zero)
            } else {
                i1 = Vec4<T, Q>(zero, zero, zero, one)
                j1 = Vec4<T, Q>(zero, zero, one, zero)
                k1 = Vec4<T, Q>(zero, one, zero, zero)
            }
        }
    }
    let x1 = Vec4<T, Q>(x0.x - i1.x + g4, x0.y - i1.y + g4, x0.z - i1.z + g4, x0.w - i1.w + g4)
    let x2 = Vec4<T, Q>(x0.x - j1.x + g4 + g4, x0.y - j1.y + g4 + g4, x0.z - j1.z + g4 + g4, x0.w - j1.w + g4 + g4)
    let x3 = Vec4<T, Q>(x0.x - k1.x + g4 + g4 + g4, x0.y - k1.y + g4 + g4 + g4, x0.z - k1.z + g4 + g4 + g4, x0.w - k1.w + g4 + g4 + g4)
    let x4 = Vec4<T, Q>(x0.x - one + g4 + g4 + g4 + g4, x0.y - one + g4 + g4 + g4 + g4, x0.z - one + g4 + g4 + g4 + g4, x0.w - one + g4 + g4 + g4 + g4)
    let iMod = mod289(Vec4<T, Q>(i.x, i.y, i.z, i.w))
    let h0 = permute(permute(permute(permute(iMod.x) + iMod.y) + iMod.z) + iMod.w)
    let h1 = permute(permute(permute(permute(iMod.x + i1.x) + iMod.y + i1.y) + iMod.z + i1.z) + iMod.w + i1.w)
    let h2 = permute(permute(permute(permute(iMod.x + j1.x) + iMod.y + j1.y) + iMod.z + j1.z) + iMod.w + j1.w)
    let h3 = permute(permute(permute(permute(iMod.x + k1.x) + iMod.y + k1.y) + iMod.z + k1.z) + iMod.w + k1.w)
    let h4 = permute(permute(permute(permute(iMod.x + one) + iMod.y + one) + iMod.z + one) + iMod.w + one)
    let n1 = simplex4Contrib(h0, x0)
    let n2 = simplex4Contrib(h1, x1)
    let n3 = simplex4Contrib(h2, x2)
    let n4 = simplex4Contrib(h3, x3)
    let n5 = simplex4Contrib(h4, x4)
    (Float64(62.0) as T).getOrThrow() * (n1 + n2 + n3 + n4 + n5)
}

private func simplex4Contrib<T, Q>(hash: T, x: Vec4<T, Q>): T where T <: Number<T> & FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let zero = (Float64(0.0) as T).getOrThrow()
    let t = (Float64(0.6) as T).getOrThrow() - x.x * x.x - x.y * x.y - x.z * x.z - x.w * x.w
    if (t < zero) {
        zero
    } else {
        let hInt = (hash as Int64).getOrThrow()
        let h = hInt & Int64(31)
        let a = if (h < Int64(16)) { x.x } else { x.y }
        let b = if (h < Int64(8)) { x.y } else { x.z }
        let c = if (h < Int64(4)) { x.z } else if (h == Int64(12) || h == Int64(14) || h == Int64(28) || h == Int64(30)) { x.x } else { x.w }
        let t4 = t * t * t * t
        t4 * (a + b + c)
    }
}
