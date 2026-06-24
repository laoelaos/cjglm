package glm.detail

import std.math.{ Number, Integer }

public func min<T>(a: T, b: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }
public func max<T>(a: T, b: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }
public func abs<T>(a: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }
public func sign<T>(a: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }
public func floor<T>(a: T): T where T <: Number<T> { throw Exception("stub") }
public func ceil<T>(a: T): T where T <: Number<T> { throw Exception("stub") }
public func fract<T>(a: T): T where T <: Number<T> { throw Exception("stub") }
public func mod<T>(a: T, b: T): T where T <: Integer<T> { throw Exception("stub") }
public func clamp<T>(a: T, minVal: T, maxVal: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }
public func mix<T>(a: T, b: T, t: T): T where T <: Number<T> { throw Exception("stub") }
public func step<T>(edge: T, x: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }
public func smoothstep<T>(edge0: T, edge1: T, x: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }
