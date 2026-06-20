package glm.detail

import std.math.{ Number }

public struct ComputeEqual<T> where T <: Equatable<T> {
    public static func call(a: T, b: T): Bool {
        return a == b
    }
}

public struct ComputeEqualNumeric<T> where T <: Number<T> & Equatable<T> & Comparable<T> {
    public static func callConst(a: T, b: T): Bool {
        if (isIec559Of(a)) {
            let diff = a - b
            let zero = a - a
            let adiff = if (diff < zero) { -diff } else { diff }
            return adiff <= epsilonOf(a)
        }
        return a == b
    }
}
