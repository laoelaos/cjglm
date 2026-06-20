package glm.detail

import std.unittest.*
import std.unittest.testmacro.*

@Test
func testFunctor1Vec1Identity(): Unit {
    let v = Vec1<Int64, Defaultp>(42)
    let r = Functor1Vec1<Int64, Int64, Defaultp>.call({ x => x }, v)
    @Expect(r.x, 42)
}

@Test
func testFunctor1Vec1Transform(): Unit {
    let v = Vec1<Int64, Defaultp>(3)
    let r = Functor1Vec1<Int64, Int64, Defaultp>.call({ x => x * 2 }, v)
    @Expect(r.x, 6)
}

@Test
func testFunctor1Vec2Transform(): Unit {
    let v = Vec2<Int64, Defaultp>(1, 2)
    let r = Functor1Vec2<Int64, Int64, Defaultp>.call({ x => x + 10 }, v)
    @Expect(r.x, 11)
    @Expect(r.y, 12)
}

@Test
func testFunctor2Vec1Add(): Unit {
    let a = Vec1<Int64, Defaultp>(10)
    let b = Vec1<Int64, Defaultp>(20)
    let r = Functor2Vec1<Int64, Defaultp>.call({ x, y => x + y }, a, b)
    @Expect(r.x, 30)
}

@Test
func testFunctor2VecScaVec1Mul(): Unit {
    let v = Vec1<Int64, Defaultp>(5)
    let r = Functor2VecScaVec1<Int64, Defaultp>.call({ x, s => x * s }, v, 3)
    @Expect(r.x, 15)
}

@Test
func testFunctor2VecIntVec1Shift(): Unit {
    let v = Vec1<Int64, Defaultp>(8)
    let r = Functor2VecIntVec1<Int64, Defaultp>.call({ x, i => x << i }, v, 2)
    @Expect(r.x, 32)
}

@Test
func testFunctor1Vec3Transform(): Unit {
    let v = Vec3<Int64, Defaultp>(1, 2, 3)
    let r = Functor1Vec3<Int64, Int64, Defaultp>.call({ x => x * 3 }, v)
    @Expect(r.x, 3)
    @Expect(r.y, 6)
    @Expect(r.z, 9)
}

@Test
func testFunctor1Vec4Transform(): Unit {
    let v = Vec4<Int64, Defaultp>(1, 2, 3, 4)
    let r = Functor1Vec4<Int64, Int64, Defaultp>.call({ x => x + 1 }, v)
    @Expect(r.x, 2)
    @Expect(r.y, 3)
    @Expect(r.z, 4)
    @Expect(r.w, 5)
}

@Test
func testFunctor2Vec2Add(): Unit {
    let a = Vec2<Int64, Defaultp>(1, 2)
    let b = Vec2<Int64, Defaultp>(10, 20)
    let r = Functor2Vec2<Int64, Defaultp>.call({ x, y => x + y }, a, b)
    @Expect(r.x, 11)
    @Expect(r.y, 22)
}

@Test
func testFunctor2Vec3Add(): Unit {
    let a = Vec3<Int64, Defaultp>(1, 2, 3)
    let b = Vec3<Int64, Defaultp>(10, 20, 30)
    let r = Functor2Vec3<Int64, Defaultp>.call({ x, y => x + y }, a, b)
    @Expect(r.x, 11)
    @Expect(r.y, 22)
    @Expect(r.z, 33)
}

@Test
func testFunctor2Vec4Add(): Unit {
    let a = Vec4<Int64, Defaultp>(1, 2, 3, 4)
    let b = Vec4<Int64, Defaultp>(10, 20, 30, 40)
    let r = Functor2Vec4<Int64, Defaultp>.call({ x, y => x + y }, a, b)
    @Expect(r.x, 11)
    @Expect(r.y, 22)
    @Expect(r.z, 33)
    @Expect(r.w, 44)
}

@Test
func testFunctor2VecScaVec2Mul(): Unit {
    let v = Vec2<Int64, Defaultp>(2, 3)
    let r = Functor2VecScaVec2<Int64, Defaultp>.call({ x, s => x * s }, v, 5)
    @Expect(r.x, 10)
    @Expect(r.y, 15)
}

@Test
func testFunctor2VecScaVec3Mul(): Unit {
    let v = Vec3<Int64, Defaultp>(2, 3, 4)
    let r = Functor2VecScaVec3<Int64, Defaultp>.call({ x, s => x * s }, v, 5)
    @Expect(r.x, 10)
    @Expect(r.y, 15)
    @Expect(r.z, 20)
}

@Test
func testFunctor2VecScaVec4Mul(): Unit {
    let v = Vec4<Int64, Defaultp>(2, 3, 4, 5)
    let r = Functor2VecScaVec4<Int64, Defaultp>.call({ x, s => x * s }, v, 5)
    @Expect(r.x, 10)
    @Expect(r.y, 15)
    @Expect(r.z, 20)
    @Expect(r.w, 25)
}

@Test
func testFunctor2VecIntVec2Shift(): Unit {
    let v = Vec2<Int64, Defaultp>(8, 16)
    let r = Functor2VecIntVec2<Int64, Defaultp>.call({ x, i => x << i }, v, 1)
    @Expect(r.x, 16)
    @Expect(r.y, 32)
}

@Test
func testFunctor2VecIntVec3Shift(): Unit {
    let v = Vec3<Int64, Defaultp>(1, 2, 4)
    let r = Functor2VecIntVec3<Int64, Defaultp>.call({ x, i => x << i }, v, 2)
    @Expect(r.x, 4)
    @Expect(r.y, 8)
    @Expect(r.z, 16)
}

@Test
func testFunctor2VecIntVec4Shift(): Unit {
    let v = Vec4<Int64, Defaultp>(1, 2, 4, 8)
    let r = Functor2VecIntVec4<Int64, Defaultp>.call({ x, i => x << i }, v, 3)
    @Expect(r.x, 8)
    @Expect(r.y, 16)
    @Expect(r.z, 32)
    @Expect(r.w, 64)
}
