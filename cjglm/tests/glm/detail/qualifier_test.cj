package glm.detail

@Test
func testPackedHighpIsQualifier(): Unit {
    let q: Qualifier = PackedHighp()
    @Expect(true, true)
}

@Test
func testPackedMediumpIsQualifier(): Unit {
    let q: Qualifier = PackedMediump()
    @Expect(true, true)
}

@Test
func testPackedLowpIsQualifier(): Unit {
    let q: Qualifier = PackedLowp()
    @Expect(true, true)
}

@Test
func testDefaultpIsPackedHighp(): Unit {
    let d: Defaultp = Defaultp()
    let p: PackedHighp = d
    @Expect(true, true)
}

@Test
func testPackedQualifierInstantiation(): Unit {
    let high: PackedHighp = PackedHighp()
    let med: PackedMediump = PackedMediump()
    let low: PackedLowp = PackedLowp()
    @Expect(true, true)
}

