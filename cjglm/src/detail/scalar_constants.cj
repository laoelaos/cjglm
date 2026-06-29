package glm.detail

import std.math.FloatingPoint

public func epsilon<T>(): T where T <: FloatingPoint<T> {
    let hint: T = (Float64(0.0) as T).getOrThrow()
    return epsilonOf<T>(hint)
}

public func pi<T>(): T where T <: FloatingPoint<T> {
    let hint: T = (Float64(0.0) as T).getOrThrow()
    if (hint is Float64) {
        return (Float64.getPI() as T).getOrThrow()
    }
    if (hint is Float32) {
        return (Float32.getPI() as T).getOrThrow()
    }
    if (hint is Float16) {
        return (Float16.getPI() as T).getOrThrow()
    }
    return (Float64.getPI() as T).getOrThrow()
}

public func cos_one_over_two<T>(): T where T <: FloatingPoint<T> {
    let hint: T = (Float64(0.0) as T).getOrThrow()
    if (hint is Float64) {
        return (0.877582561890372716 as T).getOrThrow()
    }
    if (hint is Float32) {
        return (Float32(0.877582561890372716) as T).getOrThrow()
    }
    if (hint is Float16) {
        return (Float16(0.877582561890372716) as T).getOrThrow()
    }
    return (Float64(0.877582561890372716) as T).getOrThrow()
}
