package glm.detail

@Test
func testScalarAddVec1(): Unit {
    let v = Vec1<Int64, Defaultp>(10)
    let r = add(Int64(3), v)
    @Expect(r.x, 13)
}

@Test
func testScalarAddVec2(): Unit {
    let v = Vec2<Int64, Defaultp>(10, 20)
    let r = add(Int64(3), v)
    @Expect(r.x, 13)
    @Expect(r.y, 23)
}

@Test
func testScalarAddVec3(): Unit {
    let v = Vec3<Int64, Defaultp>(10, 20, 30)
    let r = add(Int64(3), v)
    @Expect(r.x, 13)
    @Expect(r.y, 23)
    @Expect(r.z, 33)
}

@Test
func testScalarAddVec4(): Unit {
    let v = Vec4<Int64, Defaultp>(10, 20, 30, 40)
    let r = add(Int64(3), v)
    @Expect(r.x, 13)
    @Expect(r.y, 23)
    @Expect(r.z, 33)
    @Expect(r.w, 43)
}

@Test
func testScalarSubVec1(): Unit {
    let v = Vec1<Int64, Defaultp>(10)
    let r = sub(Int64(3), v)
    @Expect(r.x, -7)
}

@Test
func testScalarSubVec2(): Unit {
    let v = Vec2<Int64, Defaultp>(10, 20)
    let r = sub(Int64(3), v)
    @Expect(r.x, -7)
    @Expect(r.y, -17)
}

@Test
func testScalarSubVec3(): Unit {
    let v = Vec3<Int64, Defaultp>(10, 20, 30)
    let r = sub(Int64(3), v)
    @Expect(r.x, -7)
    @Expect(r.y, -17)
    @Expect(r.z, -27)
}

@Test
func testScalarSubVec4(): Unit {
    let v = Vec4<Int64, Defaultp>(10, 20, 30, 40)
    let r = sub(Int64(3), v)
    @Expect(r.x, -7)
    @Expect(r.y, -17)
    @Expect(r.z, -27)
    @Expect(r.w, -37)
}

@Test
func testScalarMulVec1(): Unit {
    let v = Vec1<Int64, Defaultp>(10)
    let r = mul(Int64(3), v)
    @Expect(r.x, 30)
}

@Test
func testScalarMulVec2(): Unit {
    let v = Vec2<Int64, Defaultp>(2, 3)
    let r = mul(Int64(5), v)
    @Expect(r.x, 10)
    @Expect(r.y, 15)
}

@Test
func testScalarMulVec3(): Unit {
    let v = Vec3<Int64, Defaultp>(2, 3, 4)
    let r = mul(Int64(5), v)
    @Expect(r.x, 10)
    @Expect(r.y, 15)
    @Expect(r.z, 20)
}

@Test
func testScalarMulVec4(): Unit {
    let v = Vec4<Int64, Defaultp>(2, 3, 4, 5)
    let r = mul(Int64(5), v)
    @Expect(r.x, 10)
    @Expect(r.y, 15)
    @Expect(r.z, 20)
    @Expect(r.w, 25)
}

@Test
func testScalarDivVec1(): Unit {
    let v = Vec1<Int64, Defaultp>(10)
    let r = div(Int64(30), v)
    @Expect(r.x, 3)
}

@Test
func testScalarDivVec2(): Unit {
    let v = Vec2<Int64, Defaultp>(10, 15)
    let r = div(Int64(30), v)
    @Expect(r.x, 3)
    @Expect(r.y, 2)
}

@Test
func testScalarDivVec3(): Unit {
    let v = Vec3<Int64, Defaultp>(10, 15, 20)
    let r = div(Int64(60), v)
    @Expect(r.x, 6)
    @Expect(r.y, 4)
    @Expect(r.z, 3)
}

@Test
func testScalarDivVec4(): Unit {
    let v = Vec4<Int64, Defaultp>(10, 15, 20, 30)
    let r = div(Int64(60), v)
    @Expect(r.x, 6)
    @Expect(r.y, 4)
    @Expect(r.z, 3)
    @Expect(r.w, 2)
}

@Test
func testScalarModVec1(): Unit {
    let v = Vec1<Int64, Defaultp>(10)
    let r = mod(Int64(33), v)
    @Expect(r.x, 3)
}

@Test
func testScalarModVec2(): Unit {
    let v = Vec2<Int64, Defaultp>(10, 15)
    let r = mod(Int64(33), v)
    @Expect(r.x, 3)
    @Expect(r.y, 3)
}

@Test
func testScalarModVec3(): Unit {
    let v = Vec3<Int64, Defaultp>(10, 15, 20)
    let r = mod(Int64(33), v)
    @Expect(r.x, 3)
    @Expect(r.y, 3)
    @Expect(r.z, 13)
}

@Test
func testScalarModVec4(): Unit {
    let v = Vec4<Int64, Defaultp>(10, 15, 20, 25)
    let r = mod(Int64(33), v)
    @Expect(r.x, 3)
    @Expect(r.y, 3)
    @Expect(r.z, 13)
    @Expect(r.w, 8)
}

@Test
func testScalarAddVec1NegativeScalar(): Unit {
    let v = Vec1<Int64, Defaultp>(10)
    let r = add(Int64(-5), v)
    @Expect(r.x, 5)
}

@Test
func testScalarSubVec1WithNegatives(): Unit {
    let v = Vec1<Int64, Defaultp>(-10)
    let r = sub(Int64(3), v)
    @Expect(r.x, 13)
}

@Test
func testScalarMulVec1ByZero(): Unit {
    let v = Vec1<Int64, Defaultp>(10)
    let r = mul(Int64(0), v)
    @Expect(r.x, 0)
}

@Test
func testScalarDivVec1DivideByOne(): Unit {
    let v = Vec1<Int64, Defaultp>(1)
    let r = div(Int64(99), v)
    @Expect(r.x, 99)
}

@Test
func testScalarAddVec2Float32(): Unit {
    let v = Vec2<Float32, PackedHighp>(Float32(1.5), Float32(2.5))
    let r = add(Float32(3.0), v)
    @Expect(r.x, Float32(4.5))
    @Expect(r.y, Float32(5.5))
}

@Test
func testScalarMulVec3Float32(): Unit {
    let v = Vec3<Float32, PackedHighp>(Float32(2.0), Float32(3.0), Float32(4.0))
    let r = mul(Float32(1.5), v)
    @Expect(r.x, Float32(3.0))
    @Expect(r.y, Float32(4.5))
    @Expect(r.z, Float32(6.0))
}

@Test
func testScalarAddVec1WithPackedMediump(): Unit {
    let v = Vec1<Int64, PackedMediump>(10)
    let r = add(Int64(3), v)
    @Expect(r.x, 13)
}

@Test
func testScalarAddVec1WithPackedLowp(): Unit {
    let v = Vec1<Int64, PackedLowp>(10)
    let r = add(Int64(3), v)
    @Expect(r.x, 13)
}

@Test
func testScalarDivVec1Float32ByZero(): Unit {
    let v = Vec1<Float32, PackedHighp>(Float32(0.0))
    let r = div(Float32(1.0), v)
    @Expect(r.x.isInfinite(), true)
}

@Test
func testScalarModVec1ByZero(): Unit {
    @ExpectThrows[Exception](mod(Int64(10), Vec1<Int64, Defaultp>(0)))
}

@Test
func testScalarModVec1NegativeDivisor(): Unit {
    let v = Vec1<Int64, Defaultp>(-10)
    let r = mod(Int64(33), v)
    @Expect(r.x, 3)
}

@Test
func testScalarModVec1Float32(): Unit {
    let v = Vec1<Float32, Defaultp>(Float32(2.5))
    let r = mod(Float32(7.5), v)
    @Expect(r.x, Float32(0.0))
}

@Test
func testScalarModVec2Float32(): Unit {
    let v = Vec2<Float32, Defaultp>(Float32(2.5), Float32(3.0))
    let r = mod(Float32(7.5), v)
    @Expect(r.x, Float32(0.0))
    @Expect(r.y, Float32(1.5))
}

@Test
func testScalarModVec3Float32(): Unit {
    let v = Vec3<Float32, Defaultp>(Float32(2.5), Float32(3.0), Float32(4.0))
    let r = mod(Float32(7.5), v)
    @Expect(r.x, Float32(0.0))
    @Expect(r.y, Float32(1.5))
    @Expect(r.z, Float32(3.5))
}

@Test
func testScalarModVec4Float32(): Unit {
    let v = Vec4<Float32, Defaultp>(Float32(2.5), Float32(3.0), Float32(4.0), Float32(5.0))
    let r = mod(Float32(7.5), v)
    @Expect(r.x, Float32(0.0))
    @Expect(r.y, Float32(1.5))
    @Expect(r.z, Float32(3.5))
    @Expect(r.w, Float32(2.5))
}

@Test
func testScalarModVec1Float64(): Unit {
    let v = Vec1<Float64, Defaultp>(Float64(2.5))
    let r = mod(Float64(7.5), v)
    @Expect(r.x, Float64(0.0))
}

@Test
func testScalarModVec2Float64(): Unit {
    let v = Vec2<Float64, Defaultp>(Float64(2.5), Float64(3.0))
    let r = mod(Float64(7.5), v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(1.5))
}

@Test
func testScalarModVec3Float64(): Unit {
    let v = Vec3<Float64, Defaultp>(Float64(2.5), Float64(3.0), Float64(4.0))
    let r = mod(Float64(7.5), v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(1.5))
    @Expect(r.z, Float64(3.5))
}

@Test
func testScalarModVec4Float64(): Unit {
    let v = Vec4<Float64, Defaultp>(Float64(2.5), Float64(3.0), Float64(4.0), Float64(5.0))
    let r = mod(Float64(7.5), v)
    @Expect(r.x, Float64(0.0))
    @Expect(r.y, Float64(1.5))
    @Expect(r.z, Float64(3.5))
    @Expect(r.w, Float64(2.5))
}

@Test
func testScalarModVec1Float16(): Unit {
    let v = Vec1<Float16, Defaultp>(Float16(2.5))
    let r = mod(Float16(7.5), v)
    @Expect(r.x, Float16(0.0))
}

@Test
func testScalarModVec2Float16(): Unit {
    let v = Vec2<Float16, Defaultp>(Float16(2.5), Float16(3.0))
    let r = mod(Float16(7.5), v)
    @Expect(r.x, Float16(0.0))
    @Expect(r.y, Float16(1.5))
}

@Test
func testScalarModVec3Float16(): Unit {
    let v = Vec3<Float16, Defaultp>(Float16(2.5), Float16(3.0), Float16(4.0))
    let r = mod(Float16(7.5), v)
    @Expect(r.x, Float16(0.0))
    @Expect(r.y, Float16(1.5))
    @Expect(r.z, Float16(3.5))
}

@Test
func testScalarModVec4Float16(): Unit {
    let v = Vec4<Float16, Defaultp>(Float16(2.5), Float16(3.0), Float16(4.0), Float16(5.0))
    let r = mod(Float16(7.5), v)
    @Expect(r.x, Float16(0.0))
    @Expect(r.y, Float16(1.5))
    @Expect(r.z, Float16(3.5))
    @Expect(r.w, Float16(2.5))
}

@Test
func testScalarModVec1Float32ByZero(): Unit {
    @ExpectThrows[IllegalArgumentException](mod(Float32(1.0), Vec1<Float32, Defaultp>(Float32(0.0))))
}

@Test
func testScalarModVec1Float32Negative(): Unit {
    let v = Vec1<Float32, Defaultp>(Float32(2.5))
    let r = mod(Float32(-7.5), v)
    @Expect(r.x, Float32(-0.0))
}

@Test
func testScalarModVec1Float32InfDividend(): Unit {
    @ExpectThrows[IllegalArgumentException](mod(Float32.Inf, Vec1<Float32, Defaultp>(Float32(1.0))))
}

@Test
func testScalarModVec1Float64ByZero(): Unit {
    @ExpectThrows[IllegalArgumentException](mod(Float64(1.0), Vec1<Float64, Defaultp>(Float64(0.0))))
}

@Test
func testScalarModVec1Float16ByZero(): Unit {
    @ExpectThrows[IllegalArgumentException](mod(Float16(1.0), Vec1<Float16, Defaultp>(Float16(0.0))))
}

@Test
func testScalarModVec1Float16InfDividend(): Unit {
    @ExpectThrows[IllegalArgumentException](mod(Float16.Inf, Vec1<Float16, Defaultp>(Float16(1.0))))
}
