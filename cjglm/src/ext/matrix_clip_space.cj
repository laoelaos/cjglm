package glm.ext
import glm.detail.{ Mat4x4, Vec4, Qualifier, cosT, sinT, tanT, epsilon }
import std.math.FloatingPoint

// ── ortho 系族 ──

public func ortho<T, Q>(left: T, right: T, bottom: T, top: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    let rml = right - left
    let tmb = top - bottom
    let zero = (Float64(0) as T).getOrThrow()
    let one = (Float64(1) as T).getOrThrow()
    let two = (Float64(2) as T).getOrThrow()
    Mat4x4<T, Q>(
        Vec4<T, Q>(two / rml, zero, zero, zero),
        Vec4<T, Q>(zero, two / tmb, zero, zero),
        Vec4<T, Q>(zero, zero, -one, zero),
        Vec4<T, Q>(-(right + left) / rml, -(top + bottom) / tmb, zero, one)
    )
}

public func ortho<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { orthoLH_NO(left, right, bottom, top, zNear, zFar) }

public func orthoLH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    let rml = right - left
    let tmb = top - bottom
    let znf = zFar - zNear
    let zero = (Float64(0) as T).getOrThrow()
    let one = (Float64(1) as T).getOrThrow()
    let two = (Float64(2) as T).getOrThrow()
    let depthScale = one / znf
    let depthOffset = -zNear / znf
    Mat4x4<T, Q>(
        Vec4<T, Q>(two / rml, zero, zero, zero),
        Vec4<T, Q>(zero, two / tmb, zero, zero),
        Vec4<T, Q>(zero, zero, depthScale, zero),
        Vec4<T, Q>(-(right + left) / rml, -(top + bottom) / tmb, depthOffset, one)
    )
}

public func orthoLH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    let rml = right - left
    let tmb = top - bottom
    let znf = zFar - zNear
    let zero = (Float64(0) as T).getOrThrow()
    let one = (Float64(1) as T).getOrThrow()
    let two = (Float64(2) as T).getOrThrow()
    let depthScale = two / znf
    let depthOffset = -(zFar + zNear) / znf
    Mat4x4<T, Q>(
        Vec4<T, Q>(two / rml, zero, zero, zero),
        Vec4<T, Q>(zero, two / tmb, zero, zero),
        Vec4<T, Q>(zero, zero, depthScale, zero),
        Vec4<T, Q>(-(right + left) / rml, -(top + bottom) / tmb, depthOffset, one)
    )
}

public func orthoRH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    let rml = right - left
    let tmb = top - bottom
    let znf = zFar - zNear
    let zero = (Float64(0) as T).getOrThrow()
    let one = (Float64(1) as T).getOrThrow()
    let two = (Float64(2) as T).getOrThrow()
    let depthScale = -one / znf
    let depthOffset = -zFar / znf
    Mat4x4<T, Q>(
        Vec4<T, Q>(two / rml, zero, zero, zero),
        Vec4<T, Q>(zero, two / tmb, zero, zero),
        Vec4<T, Q>(zero, zero, depthScale, zero),
        Vec4<T, Q>(-(right + left) / rml, -(top + bottom) / tmb, depthOffset, one)
    )
}

public func orthoRH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    let rml = right - left
    let tmb = top - bottom
    let znf = zFar - zNear
    let zero = (Float64(0) as T).getOrThrow()
    let one = (Float64(1) as T).getOrThrow()
    let two = (Float64(2) as T).getOrThrow()
    let depthScale = -two / znf
    let depthOffset = -(zFar + zNear) / znf
    Mat4x4<T, Q>(
        Vec4<T, Q>(two / rml, zero, zero, zero),
        Vec4<T, Q>(zero, two / tmb, zero, zero),
        Vec4<T, Q>(zero, zero, depthScale, zero),
        Vec4<T, Q>(-(right + left) / rml, -(top + bottom) / tmb, depthOffset, one)
    )
}

public func orthoZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { orthoLH_ZO(left, right, bottom, top, zNear, zFar) }

public func orthoNO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { orthoLH_NO(left, right, bottom, top, zNear, zFar) }

public func orthoLH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { orthoLH_NO(left, right, bottom, top, zNear, zFar) }

public func orthoRH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { orthoRH_NO(left, right, bottom, top, zNear, zFar) }

// ── frustum 系族 ──

public func frustum<T, Q>(left: T, right: T, bottom: T, top: T, near: T, far: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { frustumRH_NO(left, right, bottom, top, near, far) }

public func frustumLH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, near: T, far: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    let rml = right - left
    let tmb = top - bottom
    let fnf = far - near
    let near2 = (Float64(2) as T).getOrThrow() * near
    let zero = (Float64(0) as T).getOrThrow()
    let depthScale = far / fnf
    let depthOffset = -near * far / fnf
    Mat4x4<T, Q>(
        Vec4<T, Q>(near2 / rml, zero, zero, zero),
        Vec4<T, Q>(zero, near2 / tmb, zero, zero),
        Vec4<T, Q>((right + left) / rml, (top + bottom) / tmb, depthScale, (Float64(1) as T).getOrThrow()),
        Vec4<T, Q>(zero, zero, depthOffset, zero)
    )
}

public func frustumLH_NO<T, Q>(left: T, right: T, bottom: T, top: T, near: T, far: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    let rml = right - left
    let tmb = top - bottom
    let fnf = far - near
    let near2 = (Float64(2) as T).getOrThrow() * near
    let zero = (Float64(0) as T).getOrThrow()
    let depthScale = (far + near) / fnf
    let depthOffset = near2 * far / fnf
    Mat4x4<T, Q>(
        Vec4<T, Q>(near2 / rml, zero, zero, zero),
        Vec4<T, Q>(zero, near2 / tmb, zero, zero),
        Vec4<T, Q>((right + left) / rml, (top + bottom) / tmb, depthScale, (Float64(1) as T).getOrThrow()),
        Vec4<T, Q>(zero, zero, depthOffset, zero)
    )
}

public func frustumRH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, near: T, far: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    let rml = right - left
    let tmb = top - bottom
    let fnf = far - near
    let near2 = (Float64(2) as T).getOrThrow() * near
    let zero = (Float64(0) as T).getOrThrow()
    let depthScale = -far / fnf
    let depthOffset = -near * far / fnf
    Mat4x4<T, Q>(
        Vec4<T, Q>(near2 / rml, zero, zero, zero),
        Vec4<T, Q>(zero, near2 / tmb, zero, zero),
        Vec4<T, Q>((right + left) / rml, (top + bottom) / tmb, depthScale, (Float64(1) as T).getOrThrow()),
        Vec4<T, Q>(zero, zero, depthOffset, zero)
    )
}

public func frustumRH_NO<T, Q>(left: T, right: T, bottom: T, top: T, near: T, far: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    let rml = right - left
    let tmb = top - bottom
    let fnf = far - near
    let near2 = (Float64(2) as T).getOrThrow() * near
    let zero = (Float64(0) as T).getOrThrow()
    let depthScale = -(far + near) / fnf
    let depthOffset = -near2 * far / fnf
    Mat4x4<T, Q>(
        Vec4<T, Q>(near2 / rml, zero, zero, zero),
        Vec4<T, Q>(zero, near2 / tmb, zero, zero),
        Vec4<T, Q>((right + left) / rml, (top + bottom) / tmb, depthScale, (Float64(1) as T).getOrThrow()),
        Vec4<T, Q>(zero, zero, depthOffset, zero)
    )
}

public func frustumZO<T, Q>(left: T, right: T, bottom: T, top: T, near: T, far: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { frustumLH_ZO(left, right, bottom, top, near, far) }

public func frustumNO<T, Q>(left: T, right: T, bottom: T, top: T, near: T, far: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { frustumRH_NO(left, right, bottom, top, near, far) }

public func frustumLH<T, Q>(left: T, right: T, bottom: T, top: T, near: T, far: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { frustumLH_NO(left, right, bottom, top, near, far) }

public func frustumRH<T, Q>(left: T, right: T, bottom: T, top: T, near: T, far: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { frustumRH_NO(left, right, bottom, top, near, far) }

// ── perspective 系族 ──

public func perspective<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { perspectiveRH_NO(fovy, aspect, zNear, zFar) }

public func perspectiveLH_ZO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    let halfFovy = fovy / (Float64(2) as T).getOrThrow()
    let tanHalfFovy = tanT(halfFovy)
    let zero = (Float64(0) as T).getOrThrow()
    let one = (Float64(1) as T).getOrThrow()
    let depthScale = zFar / (zFar - zNear)
    let depthOffset = -zFar * zNear / (zFar - zNear)
    Mat4x4<T, Q>(
        Vec4<T, Q>(one / (aspect * tanHalfFovy), zero, zero, zero),
        Vec4<T, Q>(zero, one / tanHalfFovy, zero, zero),
        Vec4<T, Q>(zero, zero, depthScale, one),
        Vec4<T, Q>(zero, zero, depthOffset, zero)
    )
}

public func perspectiveLH_NO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    let halfFovy = fovy / (Float64(2) as T).getOrThrow()
    let tanHalfFovy = tanT(halfFovy)
    let zero = (Float64(0) as T).getOrThrow()
    let one = (Float64(1) as T).getOrThrow()
    let depthScale = (zFar + zNear) / (zFar - zNear)
    let depthOffset = (Float64(2) as T).getOrThrow() * zFar * zNear / (zFar - zNear)
    Mat4x4<T, Q>(
        Vec4<T, Q>(one / (aspect * tanHalfFovy), zero, zero, zero),
        Vec4<T, Q>(zero, one / tanHalfFovy, zero, zero),
        Vec4<T, Q>(zero, zero, depthScale, one),
        Vec4<T, Q>(zero, zero, depthOffset, zero)
    )
}

public func perspectiveRH_ZO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    let halfFovy = fovy / (Float64(2) as T).getOrThrow()
    let tanHalfFovy = tanT(halfFovy)
    let zero = (Float64(0) as T).getOrThrow()
    let one = (Float64(1) as T).getOrThrow()
    let depthScale = -zFar / (zFar - zNear)
    let depthOffset = -zFar * zNear / (zFar - zNear)
    Mat4x4<T, Q>(
        Vec4<T, Q>(one / (aspect * tanHalfFovy), zero, zero, zero),
        Vec4<T, Q>(zero, one / tanHalfFovy, zero, zero),
        Vec4<T, Q>(zero, zero, depthScale, one),
        Vec4<T, Q>(zero, zero, depthOffset, zero)
    )
}

public func perspectiveRH_NO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    let halfFovy = fovy / (Float64(2) as T).getOrThrow()
    let tanHalfFovy = tanT(halfFovy)
    let zero = (Float64(0) as T).getOrThrow()
    let one = (Float64(1) as T).getOrThrow()
    let depthScale = -(zFar + zNear) / (zFar - zNear)
    let depthOffset = -(Float64(2) as T).getOrThrow() * zFar * zNear / (zFar - zNear)
    Mat4x4<T, Q>(
        Vec4<T, Q>(one / (aspect * tanHalfFovy), zero, zero, zero),
        Vec4<T, Q>(zero, one / tanHalfFovy, zero, zero),
        Vec4<T, Q>(zero, zero, depthScale, one),
        Vec4<T, Q>(zero, zero, depthOffset, zero)
    )
}

public func perspectiveZO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { perspectiveLH_ZO(fovy, aspect, zNear, zFar) }

public func perspectiveNO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { perspectiveRH_NO(fovy, aspect, zNear, zFar) }

public func perspectiveLH<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { perspectiveLH_NO(fovy, aspect, zNear, zFar) }

public func perspectiveRH<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { perspectiveRH_NO(fovy, aspect, zNear, zFar) }

// ── perspectiveFov 系族 ──

func perspectiveFovImpl<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T, depthScale: T, depthOffset: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    let halfFovy = fovy / (Float64(2) as T).getOrThrow()
    let tanHalfFovy = tanT(halfFovy)
    let zero = (Float64(0) as T).getOrThrow()
    let one = (Float64(1) as T).getOrThrow()
    Mat4x4<T, Q>(
        Vec4<T, Q>(one / (width / height * tanHalfFovy), zero, zero, zero),
        Vec4<T, Q>(zero, one / tanHalfFovy, zero, zero),
        Vec4<T, Q>(zero, zero, depthScale, one),
        Vec4<T, Q>(zero, zero, depthOffset, zero)
    )
}

public func perspectiveFov<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { perspectiveFovRH_NO(fovy, width, height, zNear, zFar) }

public func perspectiveFovLH_ZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    let depthScale = zFar / (zFar - zNear)
    let depthOffset = -zFar * zNear / (zFar - zNear)
    perspectiveFovImpl(fovy, width, height, zNear, zFar, depthScale, depthOffset)
}

public func perspectiveFovLH_NO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    let depthScale = (zFar + zNear) / (zFar - zNear)
    let depthOffset = (Float64(2) as T).getOrThrow() * zFar * zNear / (zFar - zNear)
    perspectiveFovImpl(fovy, width, height, zNear, zFar, depthScale, depthOffset)
}

public func perspectiveFovRH_ZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    let depthScale = -zFar / (zFar - zNear)
    let depthOffset = -zFar * zNear / (zFar - zNear)
    perspectiveFovImpl(fovy, width, height, zNear, zFar, depthScale, depthOffset)
}

public func perspectiveFovRH_NO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    let depthScale = -(zFar + zNear) / (zFar - zNear)
    let depthOffset = -(Float64(2) as T).getOrThrow() * zFar * zNear / (zFar - zNear)
    perspectiveFovImpl(fovy, width, height, zNear, zFar, depthScale, depthOffset)
}

public func perspectiveFovZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { perspectiveFovLH_ZO(fovy, width, height, zNear, zFar) }

public func perspectiveFovNO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { perspectiveFovRH_NO(fovy, width, height, zNear, zFar) }

public func perspectiveFovLH<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { perspectiveFovLH_NO(fovy, width, height, zNear, zFar) }

public func perspectiveFovRH<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { perspectiveFovRH_NO(fovy, width, height, zNear, zFar) }

// ── infinitePerspective 系族 ──

func infinitePerspectiveImpl<T, Q>(fovy: T, aspect: T, zNear: T, depthScale: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    let halfFovy = fovy / (Float64(2) as T).getOrThrow()
    let tanHalfFovy = tanT(halfFovy)
    let zero = (Float64(0) as T).getOrThrow()
    let one = (Float64(1) as T).getOrThrow()
    let epsilonVal = epsilon<T>()
    let depthOffset = epsilonVal - (Float64(2) as T).getOrThrow() * zNear
    Mat4x4<T, Q>(
        Vec4<T, Q>(one / (aspect * tanHalfFovy), zero, zero, zero),
        Vec4<T, Q>(zero, one / tanHalfFovy, zero, zero),
        Vec4<T, Q>(zero, zero, depthScale, one),
        Vec4<T, Q>(zero, zero, depthOffset, zero)
    )
}

public func infinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { infinitePerspectiveRH_NO(fovy, aspect, zNear) }

public func infinitePerspectiveLH_ZO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    infinitePerspectiveImpl(fovy, aspect, zNear, (Float64(1) as T).getOrThrow())
}

public func infinitePerspectiveLH_NO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    infinitePerspectiveImpl(fovy, aspect, zNear, (Float64(1) as T).getOrThrow())
}

public func infinitePerspectiveRH_ZO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    infinitePerspectiveImpl(fovy, aspect, zNear, -(Float64(1) as T).getOrThrow())
}

public func infinitePerspectiveRH_NO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    infinitePerspectiveImpl(fovy, aspect, zNear, -(Float64(1) as T).getOrThrow())
}

public func infinitePerspectiveLH<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { infinitePerspectiveLH_NO(fovy, aspect, zNear) }

public func infinitePerspectiveRH<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { infinitePerspectiveRH_NO(fovy, aspect, zNear) }

// ── tweakedInfinitePerspective 系族 ──

func tweakedInfinitePerspectiveImpl<T, Q>(fovy: T, aspect: T, zNear: T, ep: T, depthScale: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    let halfFovy = fovy / (Float64(2) as T).getOrThrow()
    let tanHalfFovy = tanT(halfFovy)
    let zero = (Float64(0) as T).getOrThrow()
    let one = (Float64(1) as T).getOrThrow()
    let depthOffset = ep - (Float64(2) as T).getOrThrow() * zNear
    Mat4x4<T, Q>(
        Vec4<T, Q>(one / (aspect * tanHalfFovy), zero, zero, zero),
        Vec4<T, Q>(zero, one / tanHalfFovy, zero, zero),
        Vec4<T, Q>(zero, zero, depthScale, one),
        Vec4<T, Q>(zero, zero, depthOffset, zero)
    )
}

public func tweakedInfinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T, ep: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    tweakedInfinitePerspectiveImpl(fovy, aspect, zNear, ep, (Float64(1) as T).getOrThrow())
}

public func tweakedInfinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier {
    let ep = epsilon<T>()
    tweakedInfinitePerspectiveImpl(fovy, aspect, zNear, ep, (Float64(1) as T).getOrThrow())
}
