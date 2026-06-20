package glm.detail

import std.unittest.*
import std.unittest.testmacro.*

@Test
func testPackedHighpImplementsQualifier(): Unit {
    let _: Qualifier = PackedHighp()
    @Expect(true, true)
}

@Test
func testPackedMediumpImplementsQualifier(): Unit {
    let _: Qualifier = PackedMediump()
    @Expect(true, true)
}

@Test
func testPackedLowpImplementsQualifier(): Unit {
    let _: Qualifier = PackedLowp()
    @Expect(true, true)
}

@Test
func testDefaultpIsPackedHighp(): Unit {
    let d: Defaultp = Defaultp()
    let _: PackedHighp = d
    @Expect(true, true)
}
