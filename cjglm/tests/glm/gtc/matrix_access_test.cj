package glm.gtc
import glm.detail.{ Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4, Vec2, Vec3, Vec4, Defaultp }
import std.unittest.*
import std.unittest.testmacro.*

@Test
func testRowMat4x4(): Unit {
    let m = Mat4x4<Float64, Defaultp>(Vec4(1.0, 5.0, 9.0, 13.0), Vec4(2.0, 6.0, 10.0, 14.0), Vec4(3.0, 7.0, 11.0, 15.0), Vec4(4.0, 8.0, 12.0, 16.0))
    let r0 = row(m, 0)
    @Expect(r0.x, 1.0)
    @Expect(r0.y, 2.0)
    @Expect(r0.z, 3.0)
    @Expect(r0.w, 4.0)
    let r3 = row(m, 3)
    @Expect(r3.x, 13.0)
    @Expect(r3.y, 14.0)
    @Expect(r3.z, 15.0)
    @Expect(r3.w, 16.0)
}

@Test
func testRowMat2x3(): Unit {
    let m = Mat2x3<Float64, Defaultp>(Vec3(1.0, 3.0, 5.0), Vec3(2.0, 4.0, 6.0))
    let r1 = row(m, 1)
    @Expect(r1.x, 3.0)
    @Expect(r1.y, 4.0)
}

@Test
func testColumnMat4x4(): Unit {
    let m = Mat4x4<Float64, Defaultp>(Vec4(1.0, 5.0, 9.0, 13.0), Vec4(2.0, 6.0, 10.0, 14.0), Vec4(3.0, 7.0, 11.0, 15.0), Vec4(4.0, 8.0, 12.0, 16.0))
    let c0 = column(m, 0)
    @Expect(c0.x, 1.0)
    @Expect(c0.y, 5.0)
    @Expect(c0.z, 9.0)
    @Expect(c0.w, 13.0)
    let c3 = column(m, 3)
    @Expect(c3.x, 4.0)
    @Expect(c3.y, 8.0)
    @Expect(c3.z, 12.0)
    @Expect(c3.w, 16.0)
}

@Test
func testColumnMat2x3(): Unit {
    let m = Mat2x3<Float64, Defaultp>(Vec3(1.0, 3.0, 5.0), Vec3(2.0, 4.0, 6.0))
    let c0 = column(m, 0)
    @Expect(c0.x, 1.0)
    @Expect(c0.y, 3.0)
    @Expect(c0.z, 5.0)
    let c1 = column(m, 1)
    @Expect(c1.x, 2.0)
    @Expect(c1.y, 4.0)
    @Expect(c1.z, 6.0)
}

@Test
func testRowOutOfRange(): Unit {
    let m = Mat4x4<Float64, Defaultp>(1.0)
    @ExpectThrows[Exception](row(m, 4))
}

@Test
func testColumnOutOfRange(): Unit {
    let m = Mat4x4<Float64, Defaultp>(1.0)
    @ExpectThrows[Exception](column(m, 4))
}

@Test
func testRowMat3x3(): Unit {
    let m = Mat3x3<Float64, Defaultp>(Vec3(1.0, 4.0, 7.0), Vec3(2.0, 5.0, 8.0), Vec3(3.0, 6.0, 9.0))
    let r0 = row(m, 0)
    @Expect(r0.x, 1.0)
    @Expect(r0.y, 2.0)
    @Expect(r0.z, 3.0)
    let r2 = row(m, 2)
    @Expect(r2.x, 7.0)
    @Expect(r2.y, 8.0)
    @Expect(r2.z, 9.0)
}

@Test
func testColumnMat3x3(): Unit {
    let m = Mat3x3<Float64, Defaultp>(Vec3(1.0, 4.0, 7.0), Vec3(2.0, 5.0, 8.0), Vec3(3.0, 6.0, 9.0))
    let c0 = column(m, 0)
    @Expect(c0.x, 1.0)
    @Expect(c0.y, 4.0)
    @Expect(c0.z, 7.0)
    let c2 = column(m, 2)
    @Expect(c2.x, 3.0)
    @Expect(c2.y, 6.0)
    @Expect(c2.z, 9.0)
}

@Test
func testRowMat4x2(): Unit {
    let m = Mat4x2<Float64, Defaultp>(Vec2(1.0, 5.0), Vec2(2.0, 6.0), Vec2(3.0, 7.0), Vec2(4.0, 8.0))
    let r0 = row(m, 0)
    @Expect(r0.x, 1.0)
    @Expect(r0.y, 2.0)
    @Expect(r0.z, 3.0)
    @Expect(r0.w, 4.0)
    let r1 = row(m, 1)
    @Expect(r1.x, 5.0)
    @Expect(r1.y, 6.0)
    @Expect(r1.z, 7.0)
    @Expect(r1.w, 8.0)
}

@Test
func testColumnMat4x2(): Unit {
    let m = Mat4x2<Float64, Defaultp>(Vec2(1.0, 5.0), Vec2(2.0, 6.0), Vec2(3.0, 7.0), Vec2(4.0, 8.0))
    let c0 = column(m, 0)
    @Expect(c0.x, 1.0)
    @Expect(c0.y, 5.0)
    let c3 = column(m, 3)
    @Expect(c3.x, 4.0)
    @Expect(c3.y, 8.0)
}

@Test
func testRowMat2x4(): Unit {
    let m = Mat2x4<Float64, Defaultp>(Vec4(1.0, 4.0, 7.0, 10.0), Vec4(2.0, 5.0, 8.0, 11.0))
    let r2 = row(m, 2)
    @Expect(r2.x, 7.0)
    @Expect(r2.y, 8.0)
    let r3 = row(m, 3)
    @Expect(r3.x, 10.0)
    @Expect(r3.y, 11.0)
}

@Test
func testColumnMat2x4(): Unit {
    let m = Mat2x4<Float64, Defaultp>(Vec4(1.0, 4.0, 7.0, 10.0), Vec4(2.0, 5.0, 8.0, 11.0))
    let c0 = column(m, 0)
    @Expect(c0.x, 1.0)
    @Expect(c0.y, 4.0)
    @Expect(c0.z, 7.0)
    @Expect(c0.w, 10.0)
    let c1 = column(m, 1)
    @Expect(c1.x, 2.0)
    @Expect(c1.y, 5.0)
    @Expect(c1.z, 8.0)
    @Expect(c1.w, 11.0)
}

@Test
func testRowMat3x4(): Unit {
    let m = Mat3x4<Float64, Defaultp>(Vec4(1.0, 5.0, 9.0, 13.0), Vec4(2.0, 6.0, 10.0, 14.0), Vec4(3.0, 7.0, 11.0, 15.0))
    let r0 = row(m, 0)
    @Expect(r0.x, 1.0)
    @Expect(r0.y, 2.0)
    @Expect(r0.z, 3.0)
    let r3 = row(m, 3)
    @Expect(r3.x, 13.0)
    @Expect(r3.y, 14.0)
    @Expect(r3.z, 15.0)
}

@Test
func testColumnMat3x4(): Unit {
    let m = Mat3x4<Float64, Defaultp>(Vec4(1.0, 5.0, 9.0, 13.0), Vec4(2.0, 6.0, 10.0, 14.0), Vec4(3.0, 7.0, 11.0, 15.0))
    let c0 = column(m, 0)
    @Expect(c0.x, 1.0)
    @Expect(c0.y, 5.0)
    @Expect(c0.z, 9.0)
    @Expect(c0.w, 13.0)
    let c2 = column(m, 2)
    @Expect(c2.x, 3.0)
    @Expect(c2.y, 7.0)
    @Expect(c2.z, 11.0)
    @Expect(c2.w, 15.0)
}

@Test
func testRowMat2x2(): Unit {
    let m = Mat2x2<Float64, Defaultp>(Vec2(1.0, 3.0), Vec2(2.0, 4.0))
    let r0 = row(m, 0)
    @Expect(r0.x, 1.0)
    @Expect(r0.y, 2.0)
    let r1 = row(m, 1)
    @Expect(r1.x, 3.0)
    @Expect(r1.y, 4.0)
}

@Test
func testColumnMat2x2(): Unit {
    let m = Mat2x2<Float64, Defaultp>(Vec2(1.0, 3.0), Vec2(2.0, 4.0))
    let c0 = column(m, 0)
    @Expect(c0.x, 1.0)
    @Expect(c0.y, 3.0)
    let c1 = column(m, 1)
    @Expect(c1.x, 2.0)
    @Expect(c1.y, 4.0)
}

@Test
func testRowMat3x2(): Unit {
    let m = Mat3x2<Float64, Defaultp>(Vec2(1.0, 4.0), Vec2(2.0, 5.0), Vec2(3.0, 6.0))
    let r0 = row(m, 0)
    @Expect(r0.x, 1.0)
    @Expect(r0.y, 2.0)
    @Expect(r0.z, 3.0)
    let r1 = row(m, 1)
    @Expect(r1.x, 4.0)
    @Expect(r1.y, 5.0)
    @Expect(r1.z, 6.0)
}

@Test
func testColumnMat3x2(): Unit {
    let m = Mat3x2<Float64, Defaultp>(Vec2(1.0, 4.0), Vec2(2.0, 5.0), Vec2(3.0, 6.0))
    let c0 = column(m, 0)
    @Expect(c0.x, 1.0)
    @Expect(c0.y, 4.0)
    let c1 = column(m, 1)
    @Expect(c1.x, 2.0)
    @Expect(c1.y, 5.0)
    let c2 = column(m, 2)
    @Expect(c2.x, 3.0)
    @Expect(c2.y, 6.0)
}

@Test
func testRowMat4x3(): Unit {
    let m = Mat4x3<Float64, Defaultp>(Vec3(1.0, 5.0, 9.0), Vec3(2.0, 6.0, 10.0), Vec3(3.0, 7.0, 11.0), Vec3(4.0, 8.0, 12.0))
    let r0 = row(m, 0)
    @Expect(r0.x, 1.0)
    @Expect(r0.y, 2.0)
    @Expect(r0.z, 3.0)
    @Expect(r0.w, 4.0)
    let r2 = row(m, 2)
    @Expect(r2.x, 9.0)
    @Expect(r2.y, 10.0)
    @Expect(r2.z, 11.0)
    @Expect(r2.w, 12.0)
}

@Test
func testColumnMat4x3(): Unit {
    let m = Mat4x3<Float64, Defaultp>(Vec3(1.0, 5.0, 9.0), Vec3(2.0, 6.0, 10.0), Vec3(3.0, 7.0, 11.0), Vec3(4.0, 8.0, 12.0))
    let c0 = column(m, 0)
    @Expect(c0.x, 1.0)
    @Expect(c0.y, 5.0)
    @Expect(c0.z, 9.0)
    let c3 = column(m, 3)
    @Expect(c3.x, 4.0)
    @Expect(c3.y, 8.0)
    @Expect(c3.z, 12.0)
}
