package glm.gtc
import std.math.FloatingPoint

public func zero<T>(): T where T <: FloatingPoint<T> { (Float64(0.0) as T).getOrThrow() }
public func one<T>(): T where T <: FloatingPoint<T> { (Float64(1.0) as T).getOrThrow() }
public func two_pi<T>(): T where T <: FloatingPoint<T> { (Float64(6.2831853071795864769) as T).getOrThrow() }
public func tau<T>(): T where T <: FloatingPoint<T> { (Float64(6.2831853071795864769) as T).getOrThrow() }
public func root_pi<T>(): T where T <: FloatingPoint<T> { (Float64(1.7724538509055160273) as T).getOrThrow() }
public func half_pi<T>(): T where T <: FloatingPoint<T> { (Float64(1.5707963267948966192) as T).getOrThrow() }
public func three_over_two_pi<T>(): T where T <: FloatingPoint<T> { (Float64(4.7123889803846898577) as T).getOrThrow() }
public func quarter_pi<T>(): T where T <: FloatingPoint<T> { (Float64(0.7853981633974483096) as T).getOrThrow() }
public func one_over_pi<T>(): T where T <: FloatingPoint<T> { (Float64(0.3183098861837906715) as T).getOrThrow() }
public func one_over_two_pi<T>(): T where T <: FloatingPoint<T> { (Float64(0.1591549430918953358) as T).getOrThrow() }
public func two_over_pi<T>(): T where T <: FloatingPoint<T> { (Float64(0.6366197723675813431) as T).getOrThrow() }
public func four_over_pi<T>(): T where T <: FloatingPoint<T> { (Float64(1.2732395447351626861) as T).getOrThrow() }
public func two_over_root_pi<T>(): T where T <: FloatingPoint<T> { (Float64(1.1283791670955125739) as T).getOrThrow() }
public func one_over_root_two<T>(): T where T <: FloatingPoint<T> { (Float64(0.7071067811865475244) as T).getOrThrow() }
public func root_half_pi<T>(): T where T <: FloatingPoint<T> { (Float64(1.2533141373155002512) as T).getOrThrow() }
public func root_two_pi<T>(): T where T <: FloatingPoint<T> { (Float64(2.5066282746310005024) as T).getOrThrow() }
public func root_ln_four<T>(): T where T <: FloatingPoint<T> { (Float64(1.1774100225154746910) as T).getOrThrow() }
public func e<T>(): T where T <: FloatingPoint<T> { (Float64(2.71828182845904523536) as T).getOrThrow() }
public func euler<T>(): T where T <: FloatingPoint<T> { (Float64(0.5772156649015328606) as T).getOrThrow() }
public func root_two<T>(): T where T <: FloatingPoint<T> { (Float64(1.4142135623730950488) as T).getOrThrow() }
public func root_three<T>(): T where T <: FloatingPoint<T> { (Float64(1.7320508075688772935) as T).getOrThrow() }
public func root_five<T>(): T where T <: FloatingPoint<T> { (Float64(2.2360679774997896964) as T).getOrThrow() }
public func ln_two<T>(): T where T <: FloatingPoint<T> { (Float64(0.6931471805599453094) as T).getOrThrow() }
public func ln_ten<T>(): T where T <: FloatingPoint<T> { (Float64(2.3025850929940456840) as T).getOrThrow() }
public func ln_ln_two<T>(): T where T <: FloatingPoint<T> { (Float64(-0.3665129205816643270) as T).getOrThrow() }
public func third<T>(): T where T <: FloatingPoint<T> { (Float64(0.3333333333333333333) as T).getOrThrow() }
public func two_thirds<T>(): T where T <: FloatingPoint<T> { (Float64(0.6666666666666666667) as T).getOrThrow() }
public func golden_ratio<T>(): T where T <: FloatingPoint<T> { (Float64(1.6180339887498948482) as T).getOrThrow() }
