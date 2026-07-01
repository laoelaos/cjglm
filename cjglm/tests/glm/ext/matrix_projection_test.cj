package glm.ext
import glm.detail.{ Mat4x4, Vec2, Vec3, Vec4, Defaultp }
import std.unittest.*
import std.unittest.testmacro.*

@Test
func testProjectZO(): Unit {
    let obj = Vec3<Float64, Defaultp>(1.0, 2.0, 3.0)
    let model = Mat4x4<Float64, Defaultp>(1.0)
    let proj = Mat4x4<Float64, Defaultp>(1.0)
    let vp = Vec4<Int64, Defaultp>(0, 0, 800, 600)
    let r = projectZO(obj, model, proj, vp)
    @Expect(r.x, 400.5)
    @Expect(r.y, 300.5)
}

@Test
func testProjectNO(): Unit {
    let obj = Vec3<Float64, Defaultp>(1.0, 2.0, 3.0)
    let model = Mat4x4<Float64, Defaultp>(1.0)
    let proj = Mat4x4<Float64, Defaultp>(1.0)
    let vp = Vec4<Int64, Defaultp>(0, 0, 800, 600)
    let r = projectNO(obj, model, proj, vp)
    @Expect(r.x, 400.5)
    @Expect(r.y, 300.5)
}

@Test
func testProject(): Unit {
    let obj = Vec3<Float64, Defaultp>(1.0, 2.0, 3.0)
    let model = Mat4x4<Float64, Defaultp>(1.0)
    let proj = Mat4x4<Float64, Defaultp>(1.0)
    let vp = Vec4<Int64, Defaultp>(0, 0, 800, 600)
    let r = project(obj, model, proj, vp)
    @Expect(r.x, 400.5)
    @Expect(r.y, 300.5)
}

@Test
func testUnProjectZO(): Unit {
    let win = Vec3<Float64, Defaultp>(400.5, 300.5, 0.5)
    let model = Mat4x4<Float64, Defaultp>(1.0)
    let proj = Mat4x4<Float64, Defaultp>(1.0)
    let vp = Vec4<Int64, Defaultp>(0, 0, 800, 600)
    let r = unProjectZO(win, model, proj, vp)
    @Expect(r.x, 1.0)
    @Expect(r.y, 2.0)
}

@Test
func testUnProjectNO(): Unit {
    let win = Vec3<Float64, Defaultp>(400.5, 300.5, 0.5)
    let model = Mat4x4<Float64, Defaultp>(1.0)
    let proj = Mat4x4<Float64, Defaultp>(1.0)
    let vp = Vec4<Int64, Defaultp>(0, 0, 800, 600)
    let r = unProjectNO(win, model, proj, vp)
    @Expect(r.x, 1.0)
    @Expect(r.y, 2.0)
}

@Test
func testUnProject(): Unit {
    let win = Vec3<Float64, Defaultp>(400.5, 300.5, 0.5)
    let model = Mat4x4<Float64, Defaultp>(1.0)
    let proj = Mat4x4<Float64, Defaultp>(1.0)
    let vp = Vec4<Int64, Defaultp>(0, 0, 800, 600)
    let r = unProject(win, model, proj, vp)
    @Expect(r.x, 1.0)
    @Expect(r.y, 2.0)
}

@Test
func testProjectUnProjectRoundtripZO(): Unit {
    let obj = Vec3<Float64, Defaultp>(2.0, -3.0, 5.0)
    let model = Mat4x4<Float64, Defaultp>(
        Vec4(1.0, 0.0, 0.0, 0.0), Vec4(0.0, 1.0, 0.0, 0.0),
        Vec4(0.0, 0.0, 1.0, 0.0), Vec4(1.0, 2.0, 3.0, 1.0)
    )
    let proj = Mat4x4<Float64, Defaultp>(
        Vec4(2.0, 0.0, 0.0, 0.0), Vec4(0.0, 3.0, 0.0, 0.0),
        Vec4(0.0, 0.0, -1.0, -1.0), Vec4(0.0, 0.0, -0.2, 0.0)
    )
    let vp = Vec4<Int64, Defaultp>(0, 0, 800, 600)
    let p = projectZO(obj, model, proj, vp)
    let obj2 = unProjectZO(p, model, proj, vp)
    @Expect((obj2.x - obj.x).abs() < 1e-10, true)
    @Expect((obj2.y - obj.y).abs() < 1e-10, true)
    @Expect((obj2.z - obj.z).abs() < 1e-10, true)
}

@Test
func testProjectUnProjectRoundtripNO(): Unit {
    let obj = Vec3<Float64, Defaultp>(2.0, -3.0, 5.0)
    let model = Mat4x4<Float64, Defaultp>(
        Vec4(0.0, 1.0, 0.0, 0.0), Vec4(-1.0, 0.0, 0.0, 0.0),
        Vec4(0.0, 0.0, 1.0, 0.0), Vec4(0.0, 0.0, 0.0, 1.0)
    )
    let proj = Mat4x4<Float64, Defaultp>(
        Vec4(1.0, 0.0, 0.0, 0.0), Vec4(0.0, 1.0, 0.0, 0.0),
        Vec4(0.0, 0.0, -1.01, -1.0), Vec4(0.0, 0.0, -0.202, 0.0)
    )
    let vp = Vec4<Int64, Defaultp>(100, 50, 640, 480)
    let p = projectNO(obj, model, proj, vp)
    let obj2 = unProjectNO(p, model, proj, vp)
    @Expect((obj2.x - obj.x).abs() < 1e-10, true)
    @Expect((obj2.y - obj.y).abs() < 1e-10, true)
    @Expect((obj2.z - obj.z).abs() < 1e-10, true)
}

@Test
func testProjectGenericDelegatesToZO(): Unit {
    let obj = Vec3<Float64, Defaultp>(2.0, -3.0, 5.0)
    let model = Mat4x4<Float64, Defaultp>(
        Vec4(1.0, 0.0, 0.0, 0.0), Vec4(0.0, 1.0, 0.0, 0.0),
        Vec4(0.0, 0.0, 1.0, 0.0), Vec4(1.0, 2.0, 3.0, 1.0)
    )
    let proj = Mat4x4<Float64, Defaultp>(
        Vec4(2.0, 0.0, 0.0, 0.0), Vec4(0.0, 3.0, 0.0, 0.0),
        Vec4(0.0, 0.0, -1.0, -1.0), Vec4(0.0, 0.0, -0.2, 0.0)
    )
    let vp = Vec4<Int64, Defaultp>(0, 0, 800, 600)
    let rGen = project(obj, model, proj, vp)
    let rZO = projectZO(obj, model, proj, vp)
    @Expect(rGen.x, rZO.x)
    @Expect(rGen.y, rZO.y)
    @Expect(rGen.z, rZO.z)
}

@Test
func testUnProjectGenericDelegatesToZO(): Unit {
    let win = Vec3<Float64, Defaultp>(400.5, 300.5, 0.5)
    let model = Mat4x4<Float64, Defaultp>(1.0)
    let proj = Mat4x4<Float64, Defaultp>(
        Vec4(1.0, 0.0, 0.0, 0.0), Vec4(0.0, 1.0, 0.0, 0.0),
        Vec4(0.0, 0.0, -1.01, -1.0), Vec4(0.0, 0.0, -0.202, 0.0)
    )
    let vp = Vec4<Int64, Defaultp>(100, 50, 640, 480)
    let rGen = unProject(win, model, proj, vp)
    let rZO = unProjectZO(win, model, proj, vp)
    @Expect(rGen.x, rZO.x)
    @Expect(rGen.y, rZO.y)
    @Expect(rGen.z, rZO.z)
}

@Test
func testPickMatrix(): Unit {
    let center = Vec2<Float64, Defaultp>(400.0, 300.0)
    let delta = Vec2<Float64, Defaultp>(100.0, 100.0)
    let vp = Vec4<Int64, Defaultp>(0, 0, 800, 600)
    let m = pickMatrix(center, delta, vp)
    @Expect(m.c0.x, 4.0)
    @Expect(m.c1.y, 3.0)
}
