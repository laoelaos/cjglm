package glm.detail

@Test
func testScalarAddQuat(): Unit {
    let q = Quat<Int64, Defaultp>(10, 20, 30, 40)
    let r = add(Int64(3), q)
    @Expect(r.x, 13)
    @Expect(r.y, 23)
    @Expect(r.z, 33)
    @Expect(r.w, 43)
}

@Test
func testScalarSubQuat(): Unit {
    let q = Quat<Int64, Defaultp>(10, 20, 30, 40)
    let r = sub(Int64(3), q)
    @Expect(r.x, -7)
    @Expect(r.y, -17)
    @Expect(r.z, -27)
    @Expect(r.w, -37)
}

@Test
func testScalarMulQuat(): Unit {
    let q = Quat<Int64, Defaultp>(2, 3, 4, 5)
    let r = mul(Int64(5), q)
    @Expect(r.x, 10)
    @Expect(r.y, 15)
    @Expect(r.z, 20)
    @Expect(r.w, 25)
}

@Test
func testScalarDivQuat(): Unit {
    let q = Quat<Int64, Defaultp>(10, 15, 20, 30)
    let r = div(Int64(60), q)
    @Expect(r.x, 6)
    @Expect(r.y, 4)
    @Expect(r.z, 3)
    @Expect(r.w, 2)
}

@Test
func testScalarAddQuatFloat64(): Unit {
    let q = Quat<Float64, Defaultp>(1.5, 2.5, 3.5, 4.5)
    let r = add(Float64(3.0), q)
    @Expect(r.x, Float64(4.5))
    @Expect(r.y, Float64(5.5))
    @Expect(r.z, Float64(6.5))
    @Expect(r.w, Float64(7.5))
}

@Test
func testScalarSubQuatNegative(): Unit {
    let q = Quat<Int64, Defaultp>(10, 20, 30, 40)
    let r = sub(Int64(-5), q)
    @Expect(r.x, -15)
    @Expect(r.y, -25)
    @Expect(r.z, -35)
    @Expect(r.w, -45)
}

@Test
func testScalarMulQuatZero(): Unit {
    let q = Quat<Int64, Defaultp>(2, 3, 4, 5)
    let r = mul(Int64(0), q)
    @Expect(r.x, 0)
    @Expect(r.y, 0)
    @Expect(r.z, 0)
    @Expect(r.w, 0)
}

@Test
func testScalarDivQuatByOne(): Unit {
    let q = Quat<Int64, Defaultp>(1, 1, 1, 1)
    let r = div(Int64(42), q)
    @Expect(r.x, 42)
    @Expect(r.y, 42)
    @Expect(r.z, 42)
    @Expect(r.w, 42)
}

@Test
func testScalarDivQuatFloatByZero(): Unit {
    let q = Quat<Float64, Defaultp>(0.0, 1.0, 0.0, 2.0)
    let r = div(Float64(1.0), q)
    @Expect(r.x.isInfinite(), true)
    @Expect(r.y.isFinite(), true)
}
