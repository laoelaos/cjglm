package glm.gtc
import std.unittest.*
import std.unittest.testmacro.*

@Test
func testZeroFloat32(): Unit {
    @Expect(zero<Float32>(), Float32(0.0))
}

@Test
func testZeroFloat64(): Unit {
    @Expect(zero<Float64>(), Float64(0.0))
}

@Test
func testOneFloat32(): Unit {
    @Expect(one<Float32>(), Float32(1.0))
}

@Test
func testOneFloat64(): Unit {
    @Expect(one<Float64>(), Float64(1.0))
}

@Test
func testTwoPiFloat32(): Unit {
    @Expect(two_pi<Float32>(), Float32(6.2831853071795864769))
}

@Test
func testTwoPiFloat64(): Unit {
    @Expect(two_pi<Float64>(), Float64(6.2831853071795864769))
}

@Test
func testTauFloat32(): Unit {
    @Expect(tau<Float32>(), Float32(6.2831853071795864769))
}

@Test
func testTauFloat64(): Unit {
    @Expect(tau<Float64>(), Float64(6.2831853071795864769))
}

@Test
func testRootPiFloat32(): Unit {
    @Expect(root_pi<Float32>(), Float32(1.7724538509055160273))
}

@Test
func testRootPiFloat64(): Unit {
    @Expect(root_pi<Float64>(), Float64(1.7724538509055160273))
}

@Test
func testHalfPiFloat32(): Unit {
    @Expect(half_pi<Float32>(), Float32(1.5707963267948966192))
}

@Test
func testHalfPiFloat64(): Unit {
    @Expect(half_pi<Float64>(), Float64(1.5707963267948966192))
}

@Test
func testThreeOverTwoPiFloat32(): Unit {
    @Expect(three_over_two_pi<Float32>(), Float32(4.7123889803846898577))
}

@Test
func testThreeOverTwoPiFloat64(): Unit {
    @Expect(three_over_two_pi<Float64>(), Float64(4.7123889803846898577))
}

@Test
func testQuarterPiFloat32(): Unit {
    @Expect(quarter_pi<Float32>(), Float32(0.7853981633974483096))
}

@Test
func testQuarterPiFloat64(): Unit {
    @Expect(quarter_pi<Float64>(), Float64(0.7853981633974483096))
}

@Test
func testOneOverPiFloat32(): Unit {
    @Expect(one_over_pi<Float32>(), Float32(0.3183098861837906715))
}

@Test
func testOneOverPiFloat64(): Unit {
    @Expect(one_over_pi<Float64>(), Float64(0.3183098861837906715))
}

@Test
func testOneOverTwoPiFloat32(): Unit {
    @Expect(one_over_two_pi<Float32>(), Float32(0.1591549430918953358))
}

@Test
func testOneOverTwoPiFloat64(): Unit {
    @Expect(one_over_two_pi<Float64>(), Float64(0.1591549430918953358))
}

@Test
func testTwoOverPiFloat32(): Unit {
    @Expect(two_over_pi<Float32>(), Float32(0.6366197723675813431))
}

@Test
func testTwoOverPiFloat64(): Unit {
    @Expect(two_over_pi<Float64>(), Float64(0.6366197723675813431))
}

@Test
func testFourOverPiFloat32(): Unit {
    @Expect(four_over_pi<Float32>(), Float32(1.2732395447351626861))
}

@Test
func testFourOverPiFloat64(): Unit {
    @Expect(four_over_pi<Float64>(), Float64(1.2732395447351626861))
}

@Test
func testTwoOverRootPiFloat32(): Unit {
    @Expect(two_over_root_pi<Float32>(), Float32(1.1283791670955125739))
}

@Test
func testTwoOverRootPiFloat64(): Unit {
    @Expect(two_over_root_pi<Float64>(), Float64(1.1283791670955125739))
}

@Test
func testOneOverRootTwoFloat32(): Unit {
    @Expect(one_over_root_two<Float32>(), Float32(0.7071067811865475244))
}

@Test
func testOneOverRootTwoFloat64(): Unit {
    @Expect(one_over_root_two<Float64>(), Float64(0.7071067811865475244))
}

@Test
func testRootHalfPiFloat32(): Unit {
    @Expect(root_half_pi<Float32>(), Float32(1.2533141373155002512))
}

@Test
func testRootHalfPiFloat64(): Unit {
    @Expect(root_half_pi<Float64>(), Float64(1.2533141373155002512))
}

@Test
func testRootTwoPiFloat32(): Unit {
    @Expect(root_two_pi<Float32>(), Float32(2.5066282746310005024))
}

@Test
func testRootTwoPiFloat64(): Unit {
    @Expect(root_two_pi<Float64>(), Float64(2.5066282746310005024))
}

@Test
func testRootLnFourFloat32(): Unit {
    @Expect(root_ln_four<Float32>(), Float32(1.1774100225154746910))
}

@Test
func testRootLnFourFloat64(): Unit {
    @Expect(root_ln_four<Float64>(), Float64(1.1774100225154746910))
}

@Test
func testEFloat32(): Unit {
    @Expect(e<Float32>(), Float32(2.71828182845904523536))
}

@Test
func testEFloat64(): Unit {
    @Expect(e<Float64>(), Float64(2.71828182845904523536))
}

@Test
func testEulerFloat32(): Unit {
    @Expect(euler<Float32>(), Float32(0.5772156649015328606))
}

@Test
func testEulerFloat64(): Unit {
    @Expect(euler<Float64>(), Float64(0.5772156649015328606))
}

@Test
func testRootTwoFloat32(): Unit {
    @Expect(root_two<Float32>(), Float32(1.4142135623730950488))
}

@Test
func testRootTwoFloat64(): Unit {
    @Expect(root_two<Float64>(), Float64(1.4142135623730950488))
}

@Test
func testRootThreeFloat32(): Unit {
    @Expect(root_three<Float32>(), Float32(1.7320508075688772935))
}

@Test
func testRootThreeFloat64(): Unit {
    @Expect(root_three<Float64>(), Float64(1.7320508075688772935))
}

@Test
func testRootFiveFloat32(): Unit {
    @Expect(root_five<Float32>(), Float32(2.2360679774997896964))
}

@Test
func testRootFiveFloat64(): Unit {
    @Expect(root_five<Float64>(), Float64(2.2360679774997896964))
}

@Test
func testLnTwoFloat32(): Unit {
    @Expect(ln_two<Float32>(), Float32(0.6931471805599453094))
}

@Test
func testLnTwoFloat64(): Unit {
    @Expect(ln_two<Float64>(), Float64(0.6931471805599453094))
}

@Test
func testLnTenFloat32(): Unit {
    @Expect(ln_ten<Float32>(), Float32(2.3025850929940456840))
}

@Test
func testLnTenFloat64(): Unit {
    @Expect(ln_ten<Float64>(), Float64(2.3025850929940456840))
}

@Test
func testLnLnTwoFloat32(): Unit {
    @Expect(ln_ln_two<Float32>(), Float32(-0.3665129205816643270))
}

@Test
func testLnLnTwoFloat64(): Unit {
    @Expect(ln_ln_two<Float64>(), Float64(-0.3665129205816643270))
}

@Test
func testThirdFloat32(): Unit {
    @Expect(third<Float32>(), Float32(0.3333333333333333333))
}

@Test
func testThirdFloat64(): Unit {
    @Expect(third<Float64>(), Float64(0.3333333333333333333))
}

@Test
func testTwoThirdsFloat32(): Unit {
    @Expect(two_thirds<Float32>(), Float32(0.6666666666666666667))
}

@Test
func testTwoThirdsFloat64(): Unit {
    @Expect(two_thirds<Float64>(), Float64(0.6666666666666666667))
}

@Test
func testGoldenRatioFloat32(): Unit {
    @Expect(golden_ratio<Float32>(), Float32(1.6180339887498948482))
}

@Test
func testGoldenRatioFloat64(): Unit {
    @Expect(golden_ratio<Float64>(), Float64(1.6180339887498948482))
}
