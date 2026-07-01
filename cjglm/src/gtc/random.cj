package glm.gtc
import glm.detail.{Vec1, Vec2, Vec3, Vec4, Qualifier}
import std.random.Random
import std.time.DateTime
import std.env
import std.math.FloatingPoint

let _randomEngine = ThreadLocal<Random>()

private func getEngine(): Random {
    match (_randomEngine.get()) {
        case Some(engine) => engine
        case None =>
            let seed = (DateTime.now().toUnixTimeStamp().toMilliseconds() as UInt64).getOrThrow() ^ (env.getProcessId() as UInt64).getOrThrow()
            let engine = Random(seed)
            _randomEngine.set(engine)
            engine
    }
}

public func linearRand<T>(min: T, max: T): T where T <: FloatingPoint<T> {
    let r = getEngine()
    let t = (r.nextFloat64() as T).getOrThrow()
    min + (max - min) * t
}

public func gaussRand<T>(mean: T, stddev: T): T where T <: FloatingPoint<T> {
    let r = getEngine()
    mean + stddev * (r.nextGaussianFloat64(mean: Float64(0.0), sigma: Float64(1.0)) as T).getOrThrow()
}

public func linearRand<T, Q>(min: Vec1<T, Q>, max: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec1(linearRand(min.x, max.x))
}

public func linearRand<T, Q>(min: Vec2<T, Q>, max: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec2(linearRand(min.x, max.x), linearRand(min.y, max.y))
}

public func linearRand<T, Q>(min: Vec3<T, Q>, max: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec3(linearRand(min.x, max.x), linearRand(min.y, max.y), linearRand(min.z, max.z))
}

public func linearRand<T, Q>(min: Vec4<T, Q>, max: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec4(linearRand(min.x, max.x), linearRand(min.y, max.y), linearRand(min.z, max.z), linearRand(min.w, max.w))
}
