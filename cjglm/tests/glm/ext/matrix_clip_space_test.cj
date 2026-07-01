package glm.ext
import glm.detail.{ Mat4x4, Vec4, Defaultp, tanT }
import std.unittest.*
import std.unittest.testmacro.*

@Test
func testFrustumLH_ZO(): Unit {
    let left=-1.0; let right=1.0; let bottom=-1.0; let top=1.0; let near=0.1; let far=100.0
    let m = frustumLH_ZO<Float64, Defaultp>(left, right, bottom, top, near, far)
    @Expect(m.c0.x, 0.1)
    @Expect(m.c1.y, 0.1)
    @Expect((m.c2.z - far / (far - near)).abs() < 1e-10, true)
    @Expect((m.c3.z + near * far / (far - near)).abs() < 1e-10, true)
    @Expect(m.c2.w, 1.0)
    @Expect(m.c3.w, 0.0)
}

@Test
func testFrustumLH_NO(): Unit {
    let left=-1.0; let right=1.0; let bottom=-1.0; let top=1.0; let near=0.1; let far=100.0
    let m = frustumLH_NO<Float64, Defaultp>(left, right, bottom, top, near, far)
    let fnf = far - near
    let near2 = 2.0 * near
    @Expect((m.c2.z - (far + near) / fnf).abs() < 1e-10, true)
    @Expect((m.c3.z - near2 * far / fnf).abs() < 1e-10, true)
}

@Test
func testFrustumRH_ZO(): Unit {
    let left=-1.0; let right=1.0; let bottom=-1.0; let top=1.0; let near=0.1; let far=100.0
    let m = frustumRH_ZO<Float64, Defaultp>(left, right, bottom, top, near, far)
    let fnf = far - near
    @Expect((m.c2.z + far / fnf).abs() < 1e-10, true)
    @Expect((m.c3.z + near * far / fnf).abs() < 1e-10, true)
}

@Test
func testFrustumRH_NO(): Unit {
    let left=-1.0; let right=1.0; let bottom=-1.0; let top=1.0; let near=0.1; let far=100.0
    let m = frustumRH_NO<Float64, Defaultp>(left, right, bottom, top, near, far)
    let fnf = far - near
    let near2 = 2.0 * near
    @Expect((m.c2.z + (far + near) / fnf).abs() < 1e-10, true)
    @Expect((m.c3.z + near2 * far / fnf).abs() < 1e-10, true)
}

@Test
func testOrtho(): Unit {
    let m = ortho<Float64, Defaultp>(-10.0, 10.0, -5.0, 5.0)
    @Expect(m.c0.x, 0.1)
    @Expect(m.c1.y, 0.2)
}

@Test
func testOrtho6Param(): Unit {
    let m = ortho<Float64, Defaultp>(-10.0, 10.0, -5.0, 5.0, 0.1, 100.0)
    @Expect(m.c0.x, 0.1)
    @Expect(m.c1.y, 0.2)
}

@Test
func testOrthoLH_NO(): Unit {
    let m = orthoLH_NO<Float64, Defaultp>(-10.0, 10.0, -5.0, 5.0, 0.1, 100.0)
    @Expect(m.c0.x, 0.1)
    @Expect(m.c1.y, 0.2)
    @Expect((m.c2.z - (2.0 / 99.9)).abs() < 1e-10, true)
}

@Test
func testOrthoRH_NO(): Unit {
    let m = orthoRH_NO<Float64, Defaultp>(-10.0, 10.0, -5.0, 5.0, 0.1, 100.0)
    @Expect(m.c0.x, 0.1)
    @Expect(m.c1.y, 0.2)
    @Expect((m.c2.z - (-2.0 / 99.9)).abs() < 1e-10, true)
}

@Test
func testPerspective(): Unit {
    let fovy = 1.57079632679
    let m = perspective<Float64, Defaultp>(fovy, 1.0, 0.1, 100.0)
    let tanHalf = tanT(fovy / 2.0)
    @Expect((m.c0.x - 1.0 / tanHalf).abs() < 1e-10, true)
    @Expect((m.c1.y - 1.0 / tanHalf).abs() < 1e-10, true)
    @Expect(m.c2.w, 1.0)
    @Expect(m.c3.w, 0.0)
}

@Test
func testPerspectiveRH_NO(): Unit {
    let fovy = 1.57079632679
    let aspect = 1.0
    let zNear = 0.1
    let zFar = 100.0
    let m = perspectiveRH_NO<Float64, Defaultp>(fovy, aspect, zNear, zFar)
    @Expect((m.c0.x).abs() > 0.0, true)
    @Expect((m.c1.y).abs() > 0.0, true)
    @Expect((m.c2.z + (zFar + zNear) / (zFar - zNear)).abs() < 1e-10, true)
}

@Test
func testPerspectiveLH_ZO(): Unit {
    let fovy = 1.57079632679
    let aspect = 1.0
    let zNear = 0.1
    let zFar = 100.0
    let m = perspectiveLH_ZO<Float64, Defaultp>(fovy, aspect, zNear, zFar)
    @Expect((m.c2.z - zFar / (zFar - zNear)).abs() < 1e-10, true)
}

@Test
func testInfinitePerspective(): Unit {
    let fovy = 1.57079632679
    let zNear = 0.1
    let m = infinitePerspective<Float64, Defaultp>(fovy, 1.0, zNear)
    let tanHalf = tanT(fovy / 2.0)
    @Expect((m.c0.x - 1.0 / tanHalf).abs() < 1e-10, true)
    @Expect((m.c1.y - 1.0 / tanHalf).abs() < 1e-10, true)
    @Expect(m.c2.z, -1.0)
    @Expect(m.c3.w, 0.0)
}

@Test
func testTweakedInfinitePerspective(): Unit {
    let fovy = 1.57079632679
    let zNear = 0.1
    let ep = 0.001
    let m = tweakedInfinitePerspective<Float64, Defaultp>(fovy, 1.0, zNear, ep)
    let tanHalf = tanT(fovy / 2.0)
    @Expect((m.c0.x - 1.0 / tanHalf).abs() < 1e-10, true)
    @Expect((m.c1.y - 1.0 / tanHalf).abs() < 1e-10, true)
    @Expect(m.c2.z, 1.0)
    @Expect((m.c3.z - (ep - 2.0 * zNear)).abs() < 1e-10, true)
}

@Test
func testPerspectiveFovRH_NO(): Unit {
    let fovy = 1.57079632679
    let width = 800.0
    let height = 600.0
    let zNear = 0.1
    let zFar = 100.0
    let m = perspectiveFovRH_NO<Float64, Defaultp>(fovy, width, height, zNear, zFar)
    let tanHalf = tanT(fovy / 2.0)
    let aspect = width / height
    @Expect((m.c0.x - 1.0 / (aspect * tanHalf)).abs() < 1e-10, true)
    @Expect((m.c1.y - 1.0 / tanHalf).abs() < 1e-10, true)
    @Expect(m.c3.w, 0.0)
}

@Test
func testPerspectiveFovLH_ZO(): Unit {
    let fovy = 1.57079632679
    let width = 800.0
    let height = 600.0
    let zNear = 0.1
    let zFar = 100.0
    let m = perspectiveFovLH_ZO<Float64, Defaultp>(fovy, width, height, zNear, zFar)
    let tanHalf = tanT(fovy / 2.0)
    let aspect = width / height
    @Expect((m.c0.x - 1.0 / (aspect * tanHalf)).abs() < 1e-10, true)
    @Expect((m.c1.y - 1.0 / tanHalf).abs() < 1e-10, true)
    @Expect((m.c2.z - zFar / (zFar - zNear)).abs() < 1e-10, true)
}
