package glm.detail

import std.math.*

public struct NumericLimits<T> where T <: Number<T> {
    public static func epsilon(hint: T): T {
        if (hint is Float64) {
            return (2.220446049250313e-16 as T).getOrThrow()
        }
        if (hint is Float32) {
            return (Float32(1.1920929e-7) as T).getOrThrow()
        }
        return hint - hint
    }
}

public func isIec559Of<T>(hint: T): Bool {
    return match (hint) {
        case _: Float64 => true
        case _: Float32 => true
        case _ => false
    }
}

public func epsilonOf<T>(hint: T): T where T <: Number<T> {
    return NumericLimits<T>.epsilon(hint)
}
