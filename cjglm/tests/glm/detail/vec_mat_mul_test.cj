package glm.detail

@Test
func testVec2MulMat2x2(): Unit {
    let v = Vec2<Int64, Defaultp>(2, 3)
    let m = Mat2x2<Int64, Defaultp>(5, 7, 9, 11)
    let r = v * m
    @Expect(r.x, 31)
    @Expect(r.y, 51)
}

@Test
func testVec2MulMat3x2(): Unit {
    let v = Vec2<Int64, Defaultp>(2, 3)
    let m = Mat3x2<Int64, Defaultp>(5, 7, 9, 11, 13, 17)
    let r = v * m
    @Expect(r.x, 31)
    @Expect(r.y, 51)
    @Expect(r.z, 77)
}

@Test
func testVec2MulMat4x2(): Unit {
    let v = Vec2<Int64, Defaultp>(1, 2)
    let m = Mat4x2<Int64, Defaultp>(3, 5, 7, 9, 11, 13, 15, 17)
    let r = v * m
    @Expect(r.x, 13)
    @Expect(r.y, 25)
    @Expect(r.z, 37)
    @Expect(r.w, 49)
}

@Test
func testVec3MulMat2x3(): Unit {
    let v = Vec3<Int64, Defaultp>(1, 2, 3)
    let m = Mat2x3<Int64, Defaultp>(4, 5, 6, 7, 8, 9)
    let r = v * m
    @Expect(r.x, 32)
    @Expect(r.y, 50)
}

@Test
func testVec3MulMat3x3(): Unit {
    let v = Vec3<Int64, Defaultp>(1, 2, 3)
    let m = Mat3x3<Int64, Defaultp>(4, 5, 6, 7, 8, 9, 10, 11, 12)
    let r = v * m
    @Expect(r.x, 32)
    @Expect(r.y, 50)
    @Expect(r.z, 68)
}

@Test
func testVec3MulMat4x3(): Unit {
    let v = Vec3<Int64, Defaultp>(1, 2, 3)
    let m = Mat4x3<Int64, Defaultp>(4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15)
    let r = v * m
    @Expect(r.x, 32)
    @Expect(r.y, 50)
    @Expect(r.z, 68)
    @Expect(r.w, 86)
}

@Test
func testVec4MulMat2x4(): Unit {
    let v = Vec4<Int64, Defaultp>(1, 2, 3, 4)
    let m = Mat2x4<Int64, Defaultp>(5, 6, 7, 8, 9, 10, 11, 12)
    let r = v * m
    @Expect(r.x, 70)
    @Expect(r.y, 110)
}

@Test
func testVec4MulMat3x4(): Unit {
    let v = Vec4<Int64, Defaultp>(1, 2, 3, 4)
    let m = Mat3x4<Int64, Defaultp>(5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    let r = v * m
    @Expect(r.x, 70)
    @Expect(r.y, 110)
    @Expect(r.z, 150)
}

@Test
func testVec4MulMat4x4(): Unit {
    let v = Vec4<Int64, Defaultp>(1, 2, 3, 4)
    let m = Mat4x4<Int64, Defaultp>(5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20)
    let r = v * m
    @Expect(r.x, 70)
    @Expect(r.y, 110)
    @Expect(r.z, 150)
    @Expect(r.w, 190)
}

/**
 * ZeroVec 测试评估结论（T18）：
 * 保留全部 9 个 ZeroVec 测试，理由：
 * 1. 维护成本极低（与基础测试共享展开公式，仅输入向量值不同）
 * 2. 每个矩阵类型（2×2～4×4）均有独立验证价值
 * 3. 零向量×任意矩阵=零矩阵，该恒等式需逐矩阵类型验证
 */

// === Boundary: Zero Vector ===

@Test
func testVec2MulMat2x2ZeroVec(): Unit {
    let v = Vec2<Int64, Defaultp>(0, 0)
    let m = Mat2x2<Int64, Defaultp>(5, 7, 9, 11)
    let r = v * m
    @Expect(r.x, 0)
    @Expect(r.y, 0)
}

@Test
func testVec2MulMat3x2ZeroVec(): Unit {
    let v = Vec2<Int64, Defaultp>(0, 0)
    let m = Mat3x2<Int64, Defaultp>(5, 7, 9, 11, 13, 17)
    let r = v * m
    @Expect(r.x, 0)
    @Expect(r.y, 0)
    @Expect(r.z, 0)
}

@Test
func testVec2MulMat4x2ZeroVec(): Unit {
    let v = Vec2<Int64, Defaultp>(0, 0)
    let m = Mat4x2<Int64, Defaultp>(3, 5, 7, 9, 11, 13, 15, 17)
    let r = v * m
    @Expect(r.x, 0)
    @Expect(r.y, 0)
    @Expect(r.z, 0)
    @Expect(r.w, 0)
}

@Test
func testVec3MulMat2x3ZeroVec(): Unit {
    let v = Vec3<Int64, Defaultp>(0, 0, 0)
    let m = Mat2x3<Int64, Defaultp>(4, 5, 6, 7, 8, 9)
    let r = v * m
    @Expect(r.x, 0)
    @Expect(r.y, 0)
}

@Test
func testVec3MulMat3x3ZeroVec(): Unit {
    let v = Vec3<Int64, Defaultp>(0, 0, 0)
    let m = Mat3x3<Int64, Defaultp>(4, 5, 6, 7, 8, 9, 10, 11, 12)
    let r = v * m
    @Expect(r.x, 0)
    @Expect(r.y, 0)
    @Expect(r.z, 0)
}

@Test
func testVec3MulMat4x3ZeroVec(): Unit {
    let v = Vec3<Int64, Defaultp>(0, 0, 0)
    let m = Mat4x3<Int64, Defaultp>(4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15)
    let r = v * m
    @Expect(r.x, 0)
    @Expect(r.y, 0)
    @Expect(r.z, 0)
    @Expect(r.w, 0)
}

@Test
func testVec4MulMat2x4ZeroVec(): Unit {
    let v = Vec4<Int64, Defaultp>(0, 0, 0, 0)
    let m = Mat2x4<Int64, Defaultp>(5, 6, 7, 8, 9, 10, 11, 12)
    let r = v * m
    @Expect(r.x, 0)
    @Expect(r.y, 0)
}

@Test
func testVec4MulMat3x4ZeroVec(): Unit {
    let v = Vec4<Int64, Defaultp>(0, 0, 0, 0)
    let m = Mat3x4<Int64, Defaultp>(5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
    let r = v * m
    @Expect(r.x, 0)
    @Expect(r.y, 0)
    @Expect(r.z, 0)
}

@Test
func testVec4MulMat4x4ZeroVec(): Unit {
    let v = Vec4<Int64, Defaultp>(0, 0, 0, 0)
    let m = Mat4x4<Int64, Defaultp>(5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20)
    let r = v * m
    @Expect(r.x, 0)
    @Expect(r.y, 0)
    @Expect(r.z, 0)
    @Expect(r.w, 0)
}

// === Boundary: Negative Values ===

@Test
func testVec2MulMat2x2Negative(): Unit {
    let v = Vec2<Int64, Defaultp>(-2, 3)
    let m = Mat2x2<Int64, Defaultp>(5, 7, 9, 11)
    let r = v * m
    @Expect(r.x, -2*5 + 3*7)
    @Expect(r.y, -2*9 + 3*11)
}

@Test
func testVec3MulMat3x3Negative(): Unit {
    let v = Vec3<Int64, Defaultp>(-1, 2, -3)
    let m = Mat3x3<Int64, Defaultp>(4, 5, 6, 7, 8, 9, 10, 11, 12)
    let r = v * m
    @Expect(r.x, -1*4 + 2*5 + -3*6)
    @Expect(r.y, -1*7 + 2*8 + -3*9)
    @Expect(r.z, -1*10 + 2*11 + -3*12)
}

@Test
func testVec4MulMat4x4Negative(): Unit {
    let v = Vec4<Int64, Defaultp>(1, -2, 3, -4)
    let m = Mat4x4<Int64, Defaultp>(5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20)
    let r = v * m
    @Expect(r.x, 1*5 + -2*6 + 3*7 + -4*8)
    @Expect(r.y, 1*9 + -2*10 + 3*11 + -4*12)
    @Expect(r.z, 1*13 + -2*14 + 3*15 + -4*16)
    @Expect(r.w, 1*17 + -2*18 + 3*19 + -4*20)
}

// === Immutability: Original vector and matrix unchanged after operation ===

@Test
func testVec2MulMat2x2Immutability(): Unit {
    let v = Vec2<Int64, Defaultp>(2, 3)
    let m = Mat2x2<Int64, Defaultp>(5, 7, 9, 11)
    let _ = v * m
    @Expect(v.x, 2)
    @Expect(v.y, 3)
    @Expect(m.c0.x, 5)
    @Expect(m.c0.y, 7)
    @Expect(m.c1.x, 9)
    @Expect(m.c1.y, 11)
}

@Test
func testVec3MulMat3x3Immutability(): Unit {
    let v = Vec3<Int64, Defaultp>(1, 2, 3)
    let m = Mat3x3<Int64, Defaultp>(4, 5, 6, 7, 8, 9, 10, 11, 12)
    let _ = v * m
    @Expect(v.x, 1)
    @Expect(v.y, 2)
    @Expect(v.z, 3)
    @Expect(m.c0.x, 4)
    @Expect(m.c0.y, 5)
    @Expect(m.c0.z, 6)
    @Expect(m.c1.x, 7)
    @Expect(m.c1.y, 8)
    @Expect(m.c1.z, 9)
    @Expect(m.c2.x, 10)
    @Expect(m.c2.y, 11)
    @Expect(m.c2.z, 12)
}

@Test
func testVec4MulMat4x4Immutability(): Unit {
    let v = Vec4<Int64, Defaultp>(1, 2, 3, 4)
    let m = Mat4x4<Int64, Defaultp>(5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20)
    let _ = v * m
    @Expect(v.x, 1)
    @Expect(v.y, 2)
    @Expect(v.z, 3)
    @Expect(v.w, 4)
    @Expect(m.c0.x, 5)
    @Expect(m.c0.y, 6)
    @Expect(m.c0.z, 7)
    @Expect(m.c0.w, 8)
    @Expect(m.c1.x, 9)
    @Expect(m.c1.y, 10)
    @Expect(m.c1.z, 11)
    @Expect(m.c1.w, 12)
    @Expect(m.c2.x, 13)
    @Expect(m.c2.y, 14)
    @Expect(m.c2.z, 15)
    @Expect(m.c2.w, 16)
    @Expect(m.c3.x, 17)
    @Expect(m.c3.y, 18)
    @Expect(m.c3.z, 19)
    @Expect(m.c3.w, 20)
}

// === Float64 Type ===

@Test
func testVec2MulMat2x2Float64(): Unit {
    let v = Vec2<Float64, Defaultp>(Float64(2.0), Float64(3.0))
    let m = Mat2x2<Float64, Defaultp>(Float64(5.0), Float64(7.0), Float64(9.0), Float64(11.0))
    let r = v * m
    @Expect(r.x, Float64(31.0))
    @Expect(r.y, Float64(51.0))
}

@Test
func testVec3MulMat3x3Float64(): Unit {
    let v = Vec3<Float64, Defaultp>(Float64(1.0), Float64(2.0), Float64(3.0))
    let m = Mat3x3<Float64, Defaultp>(Float64(4.0), Float64(5.0), Float64(6.0), Float64(7.0), Float64(8.0), Float64(9.0), Float64(10.0), Float64(11.0), Float64(12.0))
    let r = v * m
    @Expect(r.x, Float64(32.0))
    @Expect(r.y, Float64(50.0))
    @Expect(r.z, Float64(68.0))
}

@Test
func testVec4MulMat4x4Float64(): Unit {
    let v = Vec4<Float64, Defaultp>(Float64(1.0), Float64(2.0), Float64(3.0), Float64(4.0))
    let m = Mat4x4<Float64, Defaultp>(Float64(5.0), Float64(6.0), Float64(7.0), Float64(8.0), Float64(9.0), Float64(10.0), Float64(11.0), Float64(12.0), Float64(13.0), Float64(14.0), Float64(15.0), Float64(16.0), Float64(17.0), Float64(18.0), Float64(19.0), Float64(20.0))
    let r = v * m
    @Expect(r.x, Float64(70.0))
    @Expect(r.y, Float64(110.0))
    @Expect(r.z, Float64(150.0))
    @Expect(r.w, Float64(190.0))
}

// === Different Qualifier ===

@Test
func testVec2MulMat2x2PackedHighp(): Unit {
    let v = Vec2<Int64, PackedHighp>(2, 3)
    let m = Mat2x2<Int64, PackedHighp>(5, 7, 9, 11)
    let r = v * m
    @Expect(r.x, 31)
    @Expect(r.y, 51)
}

@Test
func testVec3MulMat3x3PackedHighp(): Unit {
    let v = Vec3<Int64, PackedHighp>(1, 2, 3)
    let m = Mat3x3<Int64, PackedHighp>(4, 5, 6, 7, 8, 9, 10, 11, 12)
    let r = v * m
    @Expect(r.x, 32)
    @Expect(r.y, 50)
    @Expect(r.z, 68)
}

@Test
func testVec4MulMat4x4PackedHighp(): Unit {
    let v = Vec4<Int64, PackedHighp>(1, 2, 3, 4)
    let m = Mat4x4<Int64, PackedHighp>(5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20)
    let r = v * m
    @Expect(r.x, 70)
    @Expect(r.y, 110)
    @Expect(r.z, 150)
    @Expect(r.w, 190)
}
