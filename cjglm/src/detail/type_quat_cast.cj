package glm.detail

import std.math.{ Number, FloatingPoint }

public func mat3Cast<T, Q>(q: Quat<T, Q>): Mat3x3<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    let one: T = (Float64(1.0) as T).getOrThrow()
    let tx = q.x + q.x
    let ty = q.y + q.y
    let tz = q.z + q.z
    let twx = q.w * tx
    let twy = q.w * ty
    let twz = q.w * tz
    let txx = q.x * tx
    let txy = q.x * ty
    let txz = q.x * tz
    let tyy = q.y * ty
    let tyz = q.y * tz
    let tzz = q.z * tz
    Mat3x3<T, Q>(
        Vec3<T, Q>(one - (tyy + tzz), txy + twz, txz - twy),
        Vec3<T, Q>(txy - twz, one - (txx + tzz), tyz + twx),
        Vec3<T, Q>(txz + twy, tyz - twx, one - (txx + tyy))
    )
}

public func mat4Cast<T, Q>(q: Quat<T, Q>): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    let one: T = (Float64(1.0) as T).getOrThrow()
    let zero: T = one - one
    let tx = q.x + q.x
    let ty = q.y + q.y
    let tz = q.z + q.z
    let twx = q.w * tx
    let twy = q.w * ty
    let twz = q.w * tz
    let txx = q.x * tx
    let txy = q.x * ty
    let txz = q.x * tz
    let tyy = q.y * ty
    let tyz = q.y * tz
    let tzz = q.z * tz
    Mat4x4<T, Q>(
        Vec4<T, Q>(one - (tyy + tzz), txy + twz, txz - twy, zero),
        Vec4<T, Q>(txy - twz, one - (txx + tzz), tyz + twx, zero),
        Vec4<T, Q>(txz + twy, tyz - twx, one - (txx + tyy), zero),
        Vec4<T, Q>(zero, zero, zero, one)
    )
}

public func quatCast<T, Q>(m: Mat3x3<T, Q>): Quat<T, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let one: T = (Float64(1.0) as T).getOrThrow()
    let half: T = (Float64(0.5) as T).getOrThrow()

    let fourWSquaredMinus1 = m.c0.x + m.c1.y + m.c2.z
    let fourXSquaredMinus1 = m.c0.x - m.c1.y - m.c2.z
    let fourYSquaredMinus1 = m.c1.y - m.c0.x - m.c2.z
    let fourZSquaredMinus1 = m.c2.z - m.c0.x - m.c1.y

    var fourBiggest = fourWSquaredMinus1
    var biggestIndex: Int64 = 3

    if (fourXSquaredMinus1 > fourBiggest) {
        fourBiggest = fourXSquaredMinus1
        biggestIndex = 0
    }
    if (fourYSquaredMinus1 > fourBiggest) {
        fourBiggest = fourYSquaredMinus1
        biggestIndex = 1
    }
    if (fourZSquaredMinus1 > fourBiggest) {
        fourBiggest = fourZSquaredMinus1
        biggestIndex = 2
    }

    var x: T = zeroOrOne(one)
    var y: T = zeroOrOne(one)
    var z: T = zeroOrOne(one)
    var w: T = zeroOrOne(one)

    if (biggestIndex == 0) {
        let v: T = sqrtT(fourXSquaredMinus1 + one)
        let biggestVal = v * half
        let mult = half / v
        x = biggestVal
        y = (m.c0.y + m.c1.x) * mult
        z = (m.c0.z + m.c2.x) * mult
        w = (m.c1.z - m.c2.y) * mult
    } else if (biggestIndex == 1) {
        let v: T = sqrtT(fourYSquaredMinus1 + one)
        let biggestVal = v * half
        let mult = half / v
        x = (m.c0.y + m.c1.x) * mult
        y = biggestVal
        z = (m.c1.z + m.c2.y) * mult
        w = (m.c2.x - m.c0.z) * mult
    } else if (biggestIndex == 2) {
        let v: T = sqrtT(fourZSquaredMinus1 + one)
        let biggestVal = v * half
        let mult = half / v
        x = (m.c0.z + m.c2.x) * mult
        y = (m.c1.z + m.c2.y) * mult
        z = biggestVal
        w = (m.c0.y - m.c1.x) * mult
    } else {
        let v: T = sqrtT(fourWSquaredMinus1 + one)
        let biggestVal = v * half
        let mult = half / v
        x = (m.c1.z - m.c2.y) * mult
        y = (m.c2.x - m.c0.z) * mult
        z = (m.c0.y - m.c1.x) * mult
        w = biggestVal
    }

    Quat(x, y, z, w)
}

public func quatCast<T, Q>(m: Mat4x4<T, Q>): Quat<T, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    let m3 = Mat3x3<T, Q>(
        Vec3<T, Q>(m.c0.x, m.c0.y, m.c0.z),
        Vec3<T, Q>(m.c1.x, m.c1.y, m.c1.z),
        Vec3<T, Q>(m.c2.x, m.c2.y, m.c2.z)
    )
    quatCast(m3)
}

private func zeroOrOne<T>(one: T): T where T <: Number<T> {
    let zero = one - one
    zero
}
