# 验证报告（v8）

## 结果
PASSED

## 统计
- 通过：435
- 失败：0

## 测试执行日志
warning[0m: unused import 'std.math.Integer'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:3:27:
  | 
3 | import std.math.{ Number, Integer }
  |                           ^^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'std.math.Integer'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:3:27:
  | 
3 | import std.math.{ Number, Integer }
  |                           ^^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'std.math.Integer'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:3:27:
  | 
3 | import std.math.{ Number, Integer }
  |                           ^^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'std.math.Integer'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:3:27:
  | 
3 | import std.math.{ Number, Integer }
  |                           ^^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'std.math.Integer'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:3:27:
  | 
3 | import std.math.{ Number, Integer }
  |                           ^^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'std.math.Integer'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x4.cj:3:27:
  | 
3 | import std.math.{ Number, Integer }
  |                           ^^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'std.math.Integer'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:3:27:
  | 
3 | import std.math.{ Number, Integer }
  |                           ^^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'std.math.Integer'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x3.cj:3:27:
  | 
3 | import std.math.{ Number, Integer }
  |                           ^^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'std.math.Integer'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x4.cj:3:27:
  | 
3 | import std.math.{ Number, Integer }
  |                           ^^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'a'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:5:20:
  | 
5 | public func min<T>(a: T, b: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }
  |                    ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:5:20:
  | 
5 | public func sin<T>(x: T): T where T <: FloatingPoint<T> { throw Exception("stub") }
  |                    ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:5:23:
  | 
5 | public func dot<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
  |                       ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'b'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:5:26:
  | 
5 | public func min<T>(a: T, b: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }
  |                          ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:5:38:
  | 
5 | public func dot<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
  |                                      ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'a'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:6:20:
  | 
6 | public func max<T>(a: T, b: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }
  |                    ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:6:23:
  | 
6 | public func dot<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
  |                       ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:6:23:
  | 
6 | public func sin<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
  |                       ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'b'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:6:26:
  | 
6 | public func max<T>(a: T, b: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }
  |                          ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:6:38:
  | 
6 | public func dot<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
  |                                      ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'a'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:7:20:
  | 
7 | public func abs<T>(a: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }
  |                    ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:7:23:
  | 
7 | public func dot<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
  |                       ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:7:23:
  | 
7 | public func sin<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
  |                       ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:7:38:
  | 
7 | public func dot<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
  |                                      ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'a'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:8:21:
  | 
8 | public func sign<T>(a: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }
  |                     ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:8:23:
  | 
8 | public func sin<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
  |                       ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:8:23:
  | 
8 | public func dot<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
  |                       ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:8:38:
  | 
8 | public func dot<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
  |                                      ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'a'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:9:22:
  | 
9 | public func floor<T>(a: T): T where T <: Number<T> { throw Exception("stub") }
  |                      ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:9:23:
  | 
9 | public func sin<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
  |                       ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:9:25:
  | 
9 | public func cross<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
  |                         ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:9:40:
  | 
9 | public func cross<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
  |                                        ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'a'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:10:21:
   | 
10 | public func ceil<T>(a: T): T where T <: Number<T> { throw Exception("stub") }
   |                     ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'v'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:10:29:
   | 
10 | public func normalize<T, Q>(v: Vec2<T, Q>): Vec2<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                             ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:11:20:
   | 
11 | public func cos<T>(x: T): T where T <: FloatingPoint<T> { throw Exception("stub") }
   |                    ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'a'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:11:22:
   | 
11 | public func fract<T>(a: T): T where T <: Number<T> { throw Exception("stub") }
   |                      ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'v'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:11:29:
   | 
11 | public func normalize<T, Q>(v: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                             ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'a'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:12:20:
   | 
12 | public func mod<T>(a: T, b: T): T where T <: Integer<T> { throw Exception("stub") }
   |                    ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:12:23:
   | 
12 | public func cos<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                       ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'b'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:12:26:
   | 
12 | public func mod<T>(a: T, b: T): T where T <: Integer<T> { throw Exception("stub") }
   |                          ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'v'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:12:29:
   | 
12 | public func normalize<T, Q>(v: Vec4<T, Q>): Vec4<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                             ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'a'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:13:22:
   | 
13 | public func clamp<T>(a: T, minVal: T, maxVal: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }
   |                      ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:13:23:
   | 
13 | public func cos<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                       ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'v'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:13:26:
   | 
13 | public func length<T, Q>(v: Vec2<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                          ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'minVal'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:13:28:
   | 
13 | public func clamp<T>(a: T, minVal: T, maxVal: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }
   |                            ^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'maxVal'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:13:39:
   | 
13 | public func clamp<T>(a: T, minVal: T, maxVal: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }
   |                                       ^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'a'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:14:20:
   | 
14 | public func mix<T>(a: T, b: T, t: T): T where T <: Number<T> { throw Exception("stub") }
   |                    ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:14:23:
   | 
14 | public func cos<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                       ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'b'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:14:26:
   | 
14 | public func mix<T>(a: T, b: T, t: T): T where T <: Number<T> { throw Exception("stub") }
   |                          ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'v'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:14:26:
   | 
14 | public func length<T, Q>(v: Vec3<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                          ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'t'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:14:32:
   | 
14 | public func mix<T>(a: T, b: T, t: T): T where T <: Number<T> { throw Exception("stub") }
   |                                ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'edge'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:15:21:
   | 
15 | public func step<T>(edge: T, x: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }
   |                     ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:15:23:
   | 
15 | public func cos<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                       ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'v'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:15:26:
   | 
15 | public func length<T, Q>(v: Vec4<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                          ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:15:30:
   | 
15 | public func step<T>(edge: T, x: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }
   |                              ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'edge0'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:16:27:
   | 
16 | public func smoothstep<T>(edge0: T, edge1: T, x: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }
   |                           ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'p0'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:16:28:
   | 
16 | public func distance<T, Q>(p0: Vec2<T, Q>, p1: Vec2<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                            ^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'edge1'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:16:37:
   | 
16 | public func smoothstep<T>(edge0: T, edge1: T, x: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }
   |                                     ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'p1'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:16:44:
   | 
16 | public func distance<T, Q>(p0: Vec2<T, Q>, p1: Vec2<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                                            ^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:16:47:
   | 
16 | public func smoothstep<T>(edge0: T, edge1: T, x: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }
   |                                               ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:17:20:
   | 
17 | public func tan<T>(x: T): T where T <: FloatingPoint<T> { throw Exception("stub") }
   |                    ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'p0'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:17:28:
   | 
17 | public func distance<T, Q>(p0: Vec3<T, Q>, p1: Vec3<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                            ^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'p1'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:17:44:
   | 
17 | public func distance<T, Q>(p0: Vec3<T, Q>, p1: Vec3<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                                            ^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:18:23:
   | 
18 | public func tan<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                       ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'p0'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:18:28:
   | 
18 | public func distance<T, Q>(p0: Vec4<T, Q>, p1: Vec4<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                            ^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'p1'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:18:44:
   | 
18 | public func distance<T, Q>(p0: Vec4<T, Q>, p1: Vec4<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                                            ^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:19:23:
   | 
19 | public func tan<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                       ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'I'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:19:27:
   | 
19 | public func reflect<T, Q>(I: Vec2<T, Q>, N: Vec2<T, Q>): Vec2<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                           ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'N'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:19:42:
   | 
19 | public func reflect<T, Q>(I: Vec2<T, Q>, N: Vec2<T, Q>): Vec2<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                                          ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:20:23:
   | 
20 | public func tan<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                       ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'I'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:20:27:
   | 
20 | public func reflect<T, Q>(I: Vec3<T, Q>, N: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                           ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'N'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:20:42:
   | 
20 | public func reflect<T, Q>(I: Vec3<T, Q>, N: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                                          ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:21:23:
   | 
21 | public func tan<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                       ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'I'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:21:27:
   | 
21 | public func reflect<T, Q>(I: Vec4<T, Q>, N: Vec4<T, Q>): Vec4<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                           ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'N'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:21:42:
   | 
21 | public func reflect<T, Q>(I: Vec4<T, Q>, N: Vec4<T, Q>): Vec4<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                                          ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'I'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:22:27:
   | 
22 | public func refract<T, Q>(I: Vec2<T, Q>, N: Vec2<T, Q>, eta: T): Vec2<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                           ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'N'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:22:42:
   | 
22 | public func refract<T, Q>(I: Vec2<T, Q>, N: Vec2<T, Q>, eta: T): Vec2<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                                          ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'eta'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:22:57:
   | 
22 | public func refract<T, Q>(I: Vec2<T, Q>, N: Vec2<T, Q>, eta: T): Vec2<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                                                         ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:23:21:
   | 
23 | public func asin<T>(x: T): T where T <: FloatingPoint<T> { throw Exception("stub") }
   |                     ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'I'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:23:27:
   | 
23 | public func refract<T, Q>(I: Vec3<T, Q>, N: Vec3<T, Q>, eta: T): Vec3<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                           ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'N'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:23:42:
   | 
23 | public func refract<T, Q>(I: Vec3<T, Q>, N: Vec3<T, Q>, eta: T): Vec3<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                                          ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'eta'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:23:57:
   | 
23 | public func refract<T, Q>(I: Vec3<T, Q>, N: Vec3<T, Q>, eta: T): Vec3<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                                                         ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:24:24:
   | 
24 | public func asin<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'I'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:24:27:
   | 
24 | public func refract<T, Q>(I: Vec4<T, Q>, N: Vec4<T, Q>, eta: T): Vec4<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                           ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'N'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:24:42:
   | 
24 | public func refract<T, Q>(I: Vec4<T, Q>, N: Vec4<T, Q>, eta: T): Vec4<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                                          ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'eta'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:24:57:
   | 
24 | public func refract<T, Q>(I: Vec4<T, Q>, N: Vec4<T, Q>, eta: T): Vec4<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                                                         ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:25:24:
   | 
25 | public func asin<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:26:24:
   | 
26 | public func asin<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:27:24:
   | 
27 | public func asin<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:29:21:
   | 
29 | public func acos<T>(x: T): T where T <: FloatingPoint<T> { throw Exception("stub") }
   |                     ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:30:24:
   | 
30 | public func acos<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:31:24:
   | 
31 | public func acos<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:32:24:
   | 
32 | public func acos<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:33:24:
   | 
33 | public func acos<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:35:21:
   | 
35 | public func atan<T>(x: T): T where T <: FloatingPoint<T> { throw Exception("stub") }
   |                     ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:36:24:
   | 
36 | public func atan<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:37:24:
   | 
37 | public func atan<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:38:24:
   | 
38 | public func atan<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:39:24:
   | 
39 | public func atan<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:41:21:
   | 
41 | public func sinh<T>(x: T): T where T <: FloatingPoint<T> { throw Exception("stub") }
   |                     ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:42:24:
   | 
42 | public func sinh<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:43:24:
   | 
43 | public func sinh<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:44:24:
   | 
44 | public func sinh<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:45:24:
   | 
45 | public func sinh<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:47:21:
   | 
47 | public func cosh<T>(x: T): T where T <: FloatingPoint<T> { throw Exception("stub") }
   |                     ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:48:24:
   | 
48 | public func cosh<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:49:24:
   | 
49 | public func cosh<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:50:24:
   | 
50 | public func cosh<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:51:24:
   | 
51 | public func cosh<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:53:21:
   | 
53 | public func tanh<T>(x: T): T where T <: FloatingPoint<T> { throw Exception("stub") }
   |                     ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:54:24:
   | 
54 | public func tanh<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:55:24:
   | 
55 | public func tanh<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:56:24:
   | 
56 | public func tanh<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:57:24:
   | 
57 | public func tanh<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:59:22:
   | 
59 | public func asinh<T>(x: T): T where T <: FloatingPoint<T> { throw Exception("stub") }
   |                      ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:60:25:
   | 
60 | public func asinh<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:61:25:
   | 
61 | public func asinh<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:62:25:
   | 
62 | public func asinh<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:63:25:
   | 
63 | public func asinh<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:65:22:
   | 
65 | public func acosh<T>(x: T): T where T <: FloatingPoint<T> { throw Exception("stub") }
   |                      ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:66:25:
   | 
66 | public func acosh<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:67:25:
   | 
67 | public func acosh<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:68:25:
   | 
68 | public func acosh<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:69:25:
   | 
69 | public func acosh<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:71:22:
   | 
71 | public func atanh<T>(x: T): T where T <: FloatingPoint<T> { throw Exception("stub") }
   |                      ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:72:25:
   | 
72 | public func atanh<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:73:25:
   | 
73 | public func atanh<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:74:25:
   | 
74 | public func atanh<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:75:25:
   | 
75 | public func atanh<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:77:24:
   | 
77 | public func radians<T>(x: T): T where T <: FloatingPoint<T> { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:78:27:
   | 
78 | public func radians<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                           ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:79:27:
   | 
79 | public func radians<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                           ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:80:27:
   | 
80 | public func radians<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                           ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:81:27:
   | 
81 | public func radians<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                           ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:83:24:
   | 
83 | public func degrees<T>(x: T): T where T <: FloatingPoint<T> { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:84:27:
   | 
84 | public func degrees<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                           ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:85:27:
   | 
85 | public func degrees<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                           ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:86:27:
   | 
86 | public func degrees<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                           ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:87:27:
   | 
87 | public func degrees<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                           ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:89:22:
   | 
89 | public func atan2<T>(y: T, x: T): T where T <: FloatingPoint<T> { throw Exception("stub") }
   |                      ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:89:28:
   | 
89 | public func atan2<T>(y: T, x: T): T where T <: FloatingPoint<T> { throw Exception("stub") }
   |                            ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:90:25:
   | 
90 | public func atan2<T, Q>(y: Vec1<T, Q>, x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:90:40:
   | 
90 | public func atan2<T, Q>(y: Vec1<T, Q>, x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:91:25:
   | 
91 | public func atan2<T, Q>(y: Vec2<T, Q>, x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:91:40:
   | 
91 | public func atan2<T, Q>(y: Vec2<T, Q>, x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:92:25:
   | 
92 | public func atan2<T, Q>(y: Vec3<T, Q>, x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:92:40:
   | 
92 | public func atan2<T, Q>(y: Vec3<T, Q>, x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:93:25:
   | 
93 | public func atan2<T, Q>(y: Vec4<T, Q>, x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:93:40:
   | 
93 | public func atan2<T, Q>(y: Vec4<T, Q>, x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'rhs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:114:28:
    | 
114 |     public operator func /(rhs: Mat2x2<T, Q>): Mat2x2<T, Q> { throw Exception("stub") }
    |                            ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'rhs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:118:28:
    | 
118 |     public operator func /(rhs: Mat3x3<T, Q>): Mat3x3<T, Q> { throw Exception("stub") }
    |                            ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'rhs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_quat.cj:120:28:
    | 
120 |     public operator func *(rhs: Vec3<T, Q>): Vec3<T, Q> {
    |                            ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'rhs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x4.cj:124:28:
    | 
124 |     public operator func /(rhs: Mat4x4<T, Q>): Mat4x4<T, Q> { throw Exception("stub") }
    |                            ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'rhs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_quat.cj:125:28:
    | 
125 |     public operator func *(rhs: Vec4<T, Q>): Vec4<T, Q> {
    |                            ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'rhs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_quat.cj:142:28:
    | 
142 |     public operator func *(rhs: Quat<T, Q>): Vec3<T, Q> {
    |                            ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:143:58:
    | 
143 |     public static func fromMat<SrcQ>(m: Mat2x2<T, SrcQ>, one: T): Mat2x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:143:58:
    | 
143 |     public static func fromMat<SrcQ>(m: Mat2x2<T, SrcQ>, one: T): Mat2x4<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:148:58:
    | 
148 |     public static func fromMat<SrcQ>(m: Mat2x3<T, SrcQ>, one: T): Mat2x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'rhs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_quat.cj:149:28:
    | 
149 |     public operator func *(rhs: Quat<T, Q>): Vec4<T, Q> {
    |                            ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:149:58:
    | 
149 |     public static func fromMat<SrcQ>(m: Mat2x4<T, SrcQ>, one: T): Mat2x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:149:58:
    | 
149 |     public static func fromMat<SrcQ>(m: Mat2x3<T, SrcQ>, one: T): Mat2x4<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:149:58:
    | 
149 |     public static func fromMat<SrcQ>(m: Mat2x2<T, SrcQ>, one: T): Mat3x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:153:58:
    | 
153 |     public static func fromMat<SrcQ>(m: Mat2x4<T, SrcQ>, one: T): Mat2x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:154:58:
    | 
154 |     public static func fromMat<SrcQ>(m: Mat3x2<T, SrcQ>, one: T): Mat2x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:155:58:
    | 
155 |     public static func fromMat<SrcQ>(m: Mat3x2<T, SrcQ>, one: T): Mat2x4<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:155:58:
    | 
155 |     public static func fromMat<SrcQ>(m: Mat2x2<T, SrcQ>, one: T): Mat4x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:155:58:
    | 
155 |     public static func fromMat<SrcQ>(m: Mat2x3<T, SrcQ>, one: T): Mat3x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:158:58:
    | 
158 |     public static func fromMat<SrcQ>(m: Mat3x2<T, SrcQ>, one: T): Mat2x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:160:58:
    | 
160 |     public static func fromMat<SrcQ>(m: Mat3x3<T, SrcQ>, one: T): Mat2x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:161:58:
    | 
161 |     public static func fromMat<SrcQ>(m: Mat2x3<T, SrcQ>, one: T): Mat4x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:161:58:
    | 
161 |     public static func fromMat<SrcQ>(m: Mat3x3<T, SrcQ>, one: T): Mat2x4<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:161:58:
    | 
161 |     public static func fromMat<SrcQ>(m: Mat2x4<T, SrcQ>, one: T): Mat3x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:163:58:
    | 
163 |     public static func fromMat<SrcQ>(m: Mat3x3<T, SrcQ>, one: T): Mat2x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:165:58:
    | 
165 |     public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat2x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'m'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\matrix.cj:167:31:
    | 
167 | public func determinant<T, Q>(m: Mat2x2<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
    |                               ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:167:58:
    | 
167 |     public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat2x4<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:167:58:
    | 
167 |     public static func fromMat<SrcQ>(m: Mat2x4<T, SrcQ>, one: T): Mat4x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:167:58:
    | 
167 |     public static func fromMat<SrcQ>(m: Mat3x3<T, SrcQ>, one: T): Mat3x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'m'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\matrix.cj:168:31:
    | 
168 | public func determinant<T, Q>(m: Mat3x3<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
    |                               ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:168:58:
    | 
168 |     public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat2x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'m'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\matrix.cj:169:31:
    | 
169 | public func determinant<T, Q>(m: Mat4x4<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
    |                               ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:170:58:
    | 
170 |     public static func fromMat<SrcQ>(m: Mat4x2<T, SrcQ>, one: T): Mat2x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'m'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\matrix.cj:171:27:
    | 
171 | public func inverse<T, Q>(m: Mat2x2<T, Q>): Mat2x2<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
    |                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'m'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\matrix.cj:172:27:
    | 
172 | public func inverse<T, Q>(m: Mat3x3<T, Q>): Mat3x3<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
    |                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:172:58:
    | 
172 |     public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat3x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:172:58:
    | 
172 |     public static func fromMat<SrcQ>(m: Mat4x2<T, SrcQ>, one: T): Mat2x4<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'m'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\matrix.cj:173:27:
    | 
173 | public func inverse<T, Q>(m: Mat4x4<T, Q>): Mat4x4<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
    |                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:173:58:
    | 
173 |     public static func fromMat<SrcQ>(m: Mat4x2<T, SrcQ>, one: T): Mat2x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:173:58:
    | 
173 |     public static func fromMat<SrcQ>(m: Mat3x2<T, SrcQ>, one: T): Mat4x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x4.cj:173:58:
    | 
173 |     public static func fromMat<SrcQ>(m: Mat3x3<T, SrcQ>, one: T): Mat3x4<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:176:58:
    | 
176 |     public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat3x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:176:58:
    | 
176 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat2x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:177:58:
    | 
177 |     public static func fromMat<SrcQ>(m: Mat4x2<T, SrcQ>, one: T): Mat3x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:178:58:
    | 
178 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat2x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:178:58:
    | 
178 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat2x4<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:179:58:
    | 
179 |     public static func fromMat<SrcQ>(m: Mat3x3<T, SrcQ>, one: T): Mat4x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x3.cj:179:58:
    | 
179 |     public static func fromMat<SrcQ>(m: Mat3x3<T, SrcQ>, one: T): Mat4x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:181:58:
    | 
181 |     public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat2x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:182:58:
    | 
182 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat3x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:183:58:
    | 
183 |     public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat2x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:184:58:
    | 
184 |     public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat2x4<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x4.cj:185:58:
    | 
185 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat3x4<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:185:58:
    | 
185 |     public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat4x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x3.cj:185:58:
    | 
185 |     public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat4x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:187:58:
    | 
187 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat3x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:187:58:
    | 
187 |     public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat3x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x4.cj:191:58:
    | 
191 |     public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat3x4<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:191:58:
    | 
191 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat4x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:192:58:
    | 
192 |     public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat3x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:192:71:
    | 
192 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat2x3<U, P>, one: T): Mat2x2<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:196:58:
    | 
196 |     public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat4x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:196:71:
    | 
196 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat2x4<U, P>, one: T): Mat2x3<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x3.cj:197:58:
    | 
197 |     public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat4x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:197:71:
    | 
197 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat2x4<U, P>, one: T): Mat2x2<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:202:71:
    | 
202 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat3x2<U, P>, one: T): Mat2x2<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:207:71:
    | 
207 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat3x3<U, P>, one: T): Mat2x2<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:207:71:
    | 
207 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat3x3<U, P>, one: T): Mat2x3<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:212:71:
    | 
212 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat3x4<U, P>, one: T): Mat2x2<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:212:71:
    | 
212 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat3x4<U, P>, one: T): Mat2x3<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:214:71:
    | 
214 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat3x3<U, P>, one: T): Mat3x2<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:217:71:
    | 
217 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat3x4<U, P>, one: T): Mat2x4<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:217:71:
    | 
217 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x2<U, P>, one: T): Mat2x2<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:219:71:
    | 
219 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat3x4<U, P>, one: T): Mat3x2<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:222:71:
    | 
222 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x3<U, P>, one: T): Mat2x2<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:223:71:
    | 
223 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x3<U, P>, one: T): Mat2x3<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:224:71:
    | 
224 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x2<U, P>, one: T): Mat3x2<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:225:71:
    | 
225 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat3x4<U, P>, one: T): Mat3x3<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:227:71:
    | 
227 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x4<U, P>, one: T): Mat2x2<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:228:71:
    | 
228 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x4<U, P>, one: T): Mat2x3<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:229:71:
    | 
229 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x3<U, P>, one: T): Mat3x2<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:234:71:
    | 
234 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x4<U, P>, one: T): Mat2x4<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:234:71:
    | 
234 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x4<U, P>, one: T): Mat3x2<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:236:71:
    | 
236 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x3<U, P>, one: T): Mat3x3<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:241:71:
    | 
241 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x4<U, P>, one: T): Mat3x3<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:241:71:
    | 
241 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x3<U, P>, one: T): Mat4x2<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x4.cj:242:71:
    | 
242 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x4<U, P>, one: T): Mat3x4<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:246:71:
    | 
246 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x4<U, P>, one: T): Mat4x2<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x3.cj:248:71:
    | 
248 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x4<U, P>, one: T): Mat4x3<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

237 warnings generated, 237 warnings printed.
warning[0m: unused variable:'m'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:11:29:
   | 
11 | public func translate<T, Q>(m: Mat4x4<T, Q>, v: Vec3<T, Q>): Mat4x4<T, Q>
   |                             ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'v'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:11:46:
   | 
11 | public func translate<T, Q>(m: Mat4x4<T, Q>, v: Vec3<T, Q>): Mat4x4<T, Q>
   |                                              ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'m'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:15:26:
   | 
15 | public func rotate<T, Q>(m: Mat4x4<T, Q>, angle: T, axis: Vec3<T, Q>): Mat4x4<T, Q>
   |                          ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'angle'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:15:43:
   | 
15 | public func rotate<T, Q>(m: Mat4x4<T, Q>, angle: T, axis: Vec3<T, Q>): Mat4x4<T, Q>
   |                                           ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'axis'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:15:53:
   | 
15 | public func rotate<T, Q>(m: Mat4x4<T, Q>, angle: T, axis: Vec3<T, Q>): Mat4x4<T, Q>
   |                                                     ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'m'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:19:31:
   | 
19 | public func rotate_slow<T, Q>(m: Mat4x4<T, Q>, angle: T, axis: Vec3<T, Q>): Mat4x4<T, Q>
   |                               ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'angle'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:19:48:
   | 
19 | public func rotate_slow<T, Q>(m: Mat4x4<T, Q>, angle: T, axis: Vec3<T, Q>): Mat4x4<T, Q>
   |                                                ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'axis'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:19:58:
   | 
19 | public func rotate_slow<T, Q>(m: Mat4x4<T, Q>, angle: T, axis: Vec3<T, Q>): Mat4x4<T, Q>
   |                                                          ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:22:31:
   | 
22 | public func eulerAngles<T, Q>(x: Quat<T, Q>): Vec3<T, Q>
   |                               ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'m'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:23:25:
   | 
23 | public func scale<T, Q>(m: Mat4x4<T, Q>, v: Vec3<T, Q>): Mat4x4<T, Q>
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'v'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:23:42:
   | 
23 | public func scale<T, Q>(m: Mat4x4<T, Q>, v: Vec3<T, Q>): Mat4x4<T, Q>
   |                                          ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'q'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:26:24:
   | 
26 | public func roll<T, Q>(q: Quat<T, Q>): T
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'m'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:27:30:
   | 
27 | public func scale_slow<T, Q>(m: Mat4x4<T, Q>, v: Vec3<T, Q>): Mat4x4<T, Q>
   |                              ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'v'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:27:47:
   | 
27 | public func scale_slow<T, Q>(m: Mat4x4<T, Q>, v: Vec3<T, Q>): Mat4x4<T, Q>
   |                                               ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'q'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:30:25:
   | 
30 | public func pitch<T, Q>(q: Quat<T, Q>): T
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'m'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:31:25:
   | 
31 | public func shear<T, Q>(m: Mat4x4<T, Q>, n: Vec3<T, Q>, s: T): Mat4x4<T, Q>
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'n'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:31:42:
   | 
31 | public func shear<T, Q>(m: Mat4x4<T, Q>, n: Vec3<T, Q>, s: T): Mat4x4<T, Q>
   |                                          ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'s'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:31:57:
   | 
31 | public func shear<T, Q>(m: Mat4x4<T, Q>, n: Vec3<T, Q>, s: T): Mat4x4<T, Q>
   |                                                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'q'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:34:23:
   | 
34 | public func yaw<T, Q>(q: Quat<T, Q>): T
   |                       ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'m'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:35:30:
   | 
35 | public func shear_slow<T, Q>(m: Mat4x4<T, Q>, n: Vec3<T, Q>, s: T): Mat4x4<T, Q>
   |                              ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'n'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:35:47:
   | 
35 | public func shear_slow<T, Q>(m: Mat4x4<T, Q>, n: Vec3<T, Q>, s: T): Mat4x4<T, Q>
   |                                               ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'s'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:35:62:
   | 
35 | public func shear_slow<T, Q>(m: Mat4x4<T, Q>, n: Vec3<T, Q>, s: T): Mat4x4<T, Q>
   |                                                              ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'direction'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:38:30:
   | 
38 | public func quatLookAt<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
   |                              ^^^^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'up'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:38:53:
   | 
38 | public func quatLookAt<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
   |                                                     ^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'eye'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:39:28:
   | 
39 | public func lookAtRH<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>
   |                            ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'center'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:39:45:
   | 
39 | public func lookAtRH<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>
   |                                             ^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'up'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:39:65:
   | 
39 | public func lookAtRH<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>
   |                                                                 ^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'direction'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:42:32:
   | 
42 | public func quatLookAtRH<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
   |                                ^^^^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'up'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:42:55:
   | 
42 | public func quatLookAtRH<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
   |                                                       ^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'eye'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:43:28:
   | 
43 | public func lookAtLH<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>
   |                            ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'center'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:43:45:
   | 
43 | public func lookAtLH<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>
   |                                             ^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'up'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:43:65:
   | 
43 | public func lookAtLH<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>
   |                                                                 ^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'direction'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:46:32:
   | 
46 | public func quatLookAtLH<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
   |                                ^^^^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'up'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:46:55:
   | 
46 | public func quatLookAtLH<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
   |                                                       ^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'eye'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:47:26:
   | 
47 | public func lookAt<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>
   |                          ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'center'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:47:43:
   | 
47 | public func lookAt<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>
   |                                           ^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'up'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:47:63:
   | 
47 | public func lookAt<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>
   |                                                               ^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'left'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:53:25:
   | 
53 | public func ortho<T, Q>(left: T, right: T, bottom: T, top: T): Mat4x4<T, Q>
   |                         ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'right'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:53:34:
   | 
53 | public func ortho<T, Q>(left: T, right: T, bottom: T, top: T): Mat4x4<T, Q>
   |                                  ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'bottom'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:53:44:
   | 
53 | public func ortho<T, Q>(left: T, right: T, bottom: T, top: T): Mat4x4<T, Q>
   |                                            ^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'top'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:53:55:
   | 
53 | public func ortho<T, Q>(left: T, right: T, bottom: T, top: T): Mat4x4<T, Q>
   |                                                       ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'left'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:57:25:
   | 
57 | public func ortho<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                         ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'right'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:57:34:
   | 
57 | public func ortho<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                  ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'bottom'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:57:44:
   | 
57 | public func ortho<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                            ^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'top'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:57:55:
   | 
57 | public func ortho<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                       ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:57:63:
   | 
57 | public func ortho<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                               ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:57:73:
   | 
57 | public func ortho<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                         ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'left'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:61:30:
   | 
61 | public func orthoLH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                              ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'right'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:61:39:
   | 
61 | public func orthoLH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                       ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'bottom'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:61:49:
   | 
61 | public func orthoLH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                 ^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'top'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:61:60:
   | 
61 | public func orthoLH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                            ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:61:68:
   | 
61 | public func orthoLH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                    ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:61:78:
   | 
61 | public func orthoLH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                              ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'left'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:65:30:
   | 
65 | public func orthoLH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                              ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'right'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:65:39:
   | 
65 | public func orthoLH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                       ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'bottom'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:65:49:
   | 
65 | public func orthoLH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                 ^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'top'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:65:60:
   | 
65 | public func orthoLH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                            ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:65:68:
   | 
65 | public func orthoLH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                    ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:65:78:
   | 
65 | public func orthoLH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                              ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'left'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:69:30:
   | 
69 | public func orthoRH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                              ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'right'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:69:39:
   | 
69 | public func orthoRH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                       ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'bottom'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:69:49:
   | 
69 | public func orthoRH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                 ^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'top'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:69:60:
   | 
69 | public func orthoRH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                            ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:69:68:
   | 
69 | public func orthoRH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                    ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:69:78:
   | 
69 | public func orthoRH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                              ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'left'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:73:30:
   | 
73 | public func orthoRH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                              ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'right'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:73:39:
   | 
73 | public func orthoRH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                       ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'bottom'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:73:49:
   | 
73 | public func orthoRH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                 ^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'top'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:73:60:
   | 
73 | public func orthoRH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                            ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:73:68:
   | 
73 | public func orthoRH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                    ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:73:78:
   | 
73 | public func orthoRH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                              ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'left'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:77:27:
   | 
77 | public func orthoZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                           ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'right'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:77:36:
   | 
77 | public func orthoZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                    ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'bottom'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:77:46:
   | 
77 | public func orthoZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                              ^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'top'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:77:57:
   | 
77 | public func orthoZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                         ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:77:65:
   | 
77 | public func orthoZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                 ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:77:75:
   | 
77 | public func orthoZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                           ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'left'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:81:27:
   | 
81 | public func orthoNO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                           ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'right'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:81:36:
   | 
81 | public func orthoNO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                    ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'bottom'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:81:46:
   | 
81 | public func orthoNO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                              ^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'top'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:81:57:
   | 
81 | public func orthoNO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                         ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:81:65:
   | 
81 | public func orthoNO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                 ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:81:75:
   | 
81 | public func orthoNO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                           ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'left'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:85:27:
   | 
85 | public func orthoLH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                           ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'right'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:85:36:
   | 
85 | public func orthoLH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                    ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'bottom'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:85:46:
   | 
85 | public func orthoLH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                              ^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'top'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:85:57:
   | 
85 | public func orthoLH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                         ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:85:65:
   | 
85 | public func orthoLH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                 ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:85:75:
   | 
85 | public func orthoLH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                           ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'left'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:89:27:
   | 
89 | public func orthoRH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                           ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'right'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:89:36:
   | 
89 | public func orthoRH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                    ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'bottom'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:89:46:
   | 
89 | public func orthoRH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                              ^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'top'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:89:57:
   | 
89 | public func orthoRH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                         ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:89:65:
   | 
89 | public func orthoRH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                 ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:89:75:
   | 
89 | public func orthoRH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                           ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'left'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:95:27:
   | 
95 | public func frustum<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                           ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'right'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:95:36:
   | 
95 | public func frustum<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                    ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'bottom'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:95:46:
   | 
95 | public func frustum<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                              ^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'top'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:95:57:
   | 
95 | public func frustum<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                         ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:95:65:
   | 
95 | public func frustum<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                 ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:95:75:
   | 
95 | public func frustum<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                           ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'left'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:99:32:
   | 
99 | public func frustumLH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'right'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:99:41:
   | 
99 | public func frustumLH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                         ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'bottom'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:99:51:
   | 
99 | public func frustumLH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                   ^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'top'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:99:62:
   | 
99 | public func frustumLH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                              ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:99:70:
   | 
99 | public func frustumLH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                      ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:99:80:
   | 
99 | public func frustumLH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                                ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'left'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:103:32:
    | 
103 | public func frustumLH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'right'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:103:41:
    | 
103 | public func frustumLH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                         ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'bottom'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:103:51:
    | 
103 | public func frustumLH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                   ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'top'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:103:62:
    | 
103 | public func frustumLH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                              ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:103:70:
    | 
103 | public func frustumLH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                      ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:103:80:
    | 
103 | public func frustumLH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                                ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'left'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:107:32:
    | 
107 | public func frustumRH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'right'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:107:41:
    | 
107 | public func frustumRH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                         ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'bottom'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:107:51:
    | 
107 | public func frustumRH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                   ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'top'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:107:62:
    | 
107 | public func frustumRH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                              ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:107:70:
    | 
107 | public func frustumRH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                      ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:107:80:
    | 
107 | public func frustumRH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                                ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'left'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:111:32:
    | 
111 | public func frustumRH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'right'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:111:41:
    | 
111 | public func frustumRH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                         ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'bottom'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:111:51:
    | 
111 | public func frustumRH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                   ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'top'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:111:62:
    | 
111 | public func frustumRH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                              ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:111:70:
    | 
111 | public func frustumRH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                      ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:111:80:
    | 
111 | public func frustumRH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                                ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'left'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:115:29:
    | 
115 | public func frustumZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'right'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:115:38:
    | 
115 | public func frustumZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                      ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'bottom'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:115:48:
    | 
115 | public func frustumZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'top'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:115:59:
    | 
115 | public func frustumZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                           ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:115:67:
    | 
115 | public func frustumZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                   ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:115:77:
    | 
115 | public func frustumZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'left'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:119:29:
    | 
119 | public func frustumNO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'right'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:119:38:
    | 
119 | public func frustumNO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                      ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'bottom'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:119:48:
    | 
119 | public func frustumNO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'top'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:119:59:
    | 
119 | public func frustumNO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                           ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:119:67:
    | 
119 | public func frustumNO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                   ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:119:77:
    | 
119 | public func frustumNO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'left'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:123:29:
    | 
123 | public func frustumLH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'right'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:123:38:
    | 
123 | public func frustumLH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                      ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'bottom'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:123:48:
    | 
123 | public func frustumLH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'top'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:123:59:
    | 
123 | public func frustumLH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                           ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:123:67:
    | 
123 | public func frustumLH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                   ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:123:77:
    | 
123 | public func frustumLH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'left'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:127:29:
    | 
127 | public func frustumRH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'right'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:127:38:
    | 
127 | public func frustumRH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                      ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'bottom'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:127:48:
    | 
127 | public func frustumRH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'top'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:127:59:
    | 
127 | public func frustumRH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                           ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:127:67:
    | 
127 | public func frustumRH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                   ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:127:77:
    | 
127 | public func frustumRH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:133:31:
    | 
133 | public func perspective<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                               ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:133:40:
    | 
133 | public func perspective<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                        ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:133:51:
    | 
133 | public func perspective<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                   ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:133:61:
    | 
133 | public func perspective<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:137:36:
    | 
137 | public func perspectiveLH_ZO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                    ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:137:45:
    | 
137 | public func perspectiveLH_ZO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                             ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:137:56:
    | 
137 | public func perspectiveLH_ZO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                        ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:137:66:
    | 
137 | public func perspectiveLH_ZO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                  ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:141:36:
    | 
141 | public func perspectiveLH_NO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                    ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:141:45:
    | 
141 | public func perspectiveLH_NO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                             ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:141:56:
    | 
141 | public func perspectiveLH_NO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                        ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:141:66:
    | 
141 | public func perspectiveLH_NO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                  ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:145:36:
    | 
145 | public func perspectiveRH_ZO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                    ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:145:45:
    | 
145 | public func perspectiveRH_ZO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                             ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:145:56:
    | 
145 | public func perspectiveRH_ZO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                        ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:145:66:
    | 
145 | public func perspectiveRH_ZO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                  ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:149:36:
    | 
149 | public func perspectiveRH_NO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                    ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:149:45:
    | 
149 | public func perspectiveRH_NO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                             ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:149:56:
    | 
149 | public func perspectiveRH_NO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                        ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:149:66:
    | 
149 | public func perspectiveRH_NO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                  ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:153:33:
    | 
153 | public func perspectiveZO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                 ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:153:42:
    | 
153 | public func perspectiveZO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                          ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:153:53:
    | 
153 | public func perspectiveZO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                     ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:153:63:
    | 
153 | public func perspectiveZO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                               ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:157:33:
    | 
157 | public func perspectiveNO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                 ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:157:42:
    | 
157 | public func perspectiveNO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                          ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:157:53:
    | 
157 | public func perspectiveNO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                     ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:157:63:
    | 
157 | public func perspectiveNO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                               ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:161:33:
    | 
161 | public func perspectiveLH<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                 ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:161:42:
    | 
161 | public func perspectiveLH<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                          ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:161:53:
    | 
161 | public func perspectiveLH<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                     ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:161:63:
    | 
161 | public func perspectiveLH<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                               ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:165:33:
    | 
165 | public func perspectiveRH<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                 ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:165:42:
    | 
165 | public func perspectiveRH<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                          ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:165:53:
    | 
165 | public func perspectiveRH<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                     ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:165:63:
    | 
165 | public func perspectiveRH<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                               ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:171:34:
    | 
171 | public func perspectiveFov<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                  ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'width'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:171:43:
    | 
171 | public func perspectiveFov<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                           ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'height'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:171:53:
    | 
171 | public func perspectiveFov<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                     ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:171:64:
    | 
171 | public func perspectiveFov<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:171:74:
    | 
171 | public func perspectiveFov<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                          ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:175:39:
    | 
175 | public func perspectiveFovLH_ZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'width'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:175:48:
    | 
175 | public func perspectiveFovLH_ZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'height'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:175:58:
    | 
175 | public func perspectiveFovLH_ZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                          ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:175:69:
    | 
175 | public func perspectiveFovLH_ZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                     ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:175:79:
    | 
175 | public func perspectiveFovLH_ZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                               ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:179:39:
    | 
179 | public func perspectiveFovLH_NO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'width'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:179:48:
    | 
179 | public func perspectiveFovLH_NO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'height'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:179:58:
    | 
179 | public func perspectiveFovLH_NO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                          ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:179:69:
    | 
179 | public func perspectiveFovLH_NO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                     ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:179:79:
    | 
179 | public func perspectiveFovLH_NO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                               ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:183:39:
    | 
183 | public func perspectiveFovRH_ZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'width'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:183:48:
    | 
183 | public func perspectiveFovRH_ZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'height'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:183:58:
    | 
183 | public func perspectiveFovRH_ZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                          ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:183:69:
    | 
183 | public func perspectiveFovRH_ZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                     ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:183:79:
    | 
183 | public func perspectiveFovRH_ZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                               ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:187:39:
    | 
187 | public func perspectiveFovRH_NO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'width'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:187:48:
    | 
187 | public func perspectiveFovRH_NO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'height'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:187:58:
    | 
187 | public func perspectiveFovRH_NO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                          ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:187:69:
    | 
187 | public func perspectiveFovRH_NO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                     ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:187:79:
    | 
187 | public func perspectiveFovRH_NO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                               ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:191:36:
    | 
191 | public func perspectiveFovZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                    ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'width'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:191:45:
    | 
191 | public func perspectiveFovZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                             ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'height'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:191:55:
    | 
191 | public func perspectiveFovZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                       ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:191:66:
    | 
191 | public func perspectiveFovZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                  ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:191:76:
    | 
191 | public func perspectiveFovZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                            ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:195:36:
    | 
195 | public func perspectiveFovNO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                    ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'width'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:195:45:
    | 
195 | public func perspectiveFovNO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                             ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'height'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:195:55:
    | 
195 | public func perspectiveFovNO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                       ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:195:66:
    | 
195 | public func perspectiveFovNO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                  ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:195:76:
    | 
195 | public func perspectiveFovNO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                            ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:199:36:
    | 
199 | public func perspectiveFovLH<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                    ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'width'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:199:45:
    | 
199 | public func perspectiveFovLH<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                             ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'height'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:199:55:
    | 
199 | public func perspectiveFovLH<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                       ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:199:66:
    | 
199 | public func perspectiveFovLH<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                  ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:199:76:
    | 
199 | public func perspectiveFovLH<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                            ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:203:36:
    | 
203 | public func perspectiveFovRH<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                    ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'width'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:203:45:
    | 
203 | public func perspectiveFovRH<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                             ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'height'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:203:55:
    | 
203 | public func perspectiveFovRH<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                       ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:203:66:
    | 
203 | public func perspectiveFovRH<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                  ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:203:76:
    | 
203 | public func perspectiveFovRH<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                            ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:209:39:
    | 
209 | public func infinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:209:48:
    | 
209 | public func infinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                                ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:209:59:
    | 
209 | public func infinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                                           ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:213:44:
    | 
213 | public func infinitePerspectiveLH_ZO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                            ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:213:53:
    | 
213 | public func infinitePerspectiveLH_ZO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                                     ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:213:64:
    | 
213 | public func infinitePerspectiveLH_ZO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                                                ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:217:44:
    | 
217 | public func infinitePerspectiveLH_NO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                            ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:217:53:
    | 
217 | public func infinitePerspectiveLH_NO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                                     ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:217:64:
    | 
217 | public func infinitePerspectiveLH_NO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                                                ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:221:44:
    | 
221 | public func infinitePerspectiveRH_ZO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                            ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:221:53:
    | 
221 | public func infinitePerspectiveRH_ZO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                                     ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:221:64:
    | 
221 | public func infinitePerspectiveRH_ZO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                                                ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:225:44:
    | 
225 | public func infinitePerspectiveRH_NO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                            ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:225:53:
    | 
225 | public func infinitePerspectiveRH_NO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                                     ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:225:64:
    | 
225 | public func infinitePerspectiveRH_NO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                                                ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:229:41:
    | 
229 | public func infinitePerspectiveLH<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                         ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:229:50:
    | 
229 | public func infinitePerspectiveLH<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                                  ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:229:61:
    | 
229 | public func infinitePerspectiveLH<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                                             ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:233:41:
    | 
233 | public func infinitePerspectiveRH<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                         ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:233:50:
    | 
233 | public func infinitePerspectiveRH<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                                  ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:233:61:
    | 
233 | public func infinitePerspectiveRH<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                                             ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:239:46:
    | 
239 | public func tweakedInfinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T, ep: T): Mat4x4<T, Q>
    |                                              ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:239:55:
    | 
239 | public func tweakedInfinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T, ep: T): Mat4x4<T, Q>
    |                                                       ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:239:66:
    | 
239 | public func tweakedInfinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T, ep: T): Mat4x4<T, Q>
    |                                                                  ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ep'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:239:76:
    | 
239 | public func tweakedInfinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T, ep: T): Mat4x4<T, Q>
    |                                                                            ^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:243:46:
    | 
243 | public func tweakedInfinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                              ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:243:55:
    | 
243 | public func tweakedInfinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                                       ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:243:66:
    | 
243 | public func tweakedInfinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                                                  ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'obj'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:249:29:
    | 
249 | public func projectZO<T, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                             ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'model'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:249:46:
    | 
249 | public func projectZO<T, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                              ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'proj'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:249:67:
    | 
249 | public func projectZO<T, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                                                   ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'viewport'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:249:87:
    | 
249 | public func projectZO<T, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                                                                       ^^^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'obj'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:253:29:
    | 
253 | public func projectNO<T, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                             ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'model'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:253:46:
    | 
253 | public func projectNO<T, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                              ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'proj'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:253:67:
    | 
253 | public func projectNO<T, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                                                   ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'viewport'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:253:87:
    | 
253 | public func projectNO<T, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                                                                       ^^^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'obj'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:257:27:
    | 
257 | public func project<T, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                           ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'model'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:257:44:
    | 
257 | public func project<T, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                            ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'proj'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:257:65:
    | 
257 | public func project<T, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                                                 ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'viewport'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:257:85:
    | 
257 | public func project<T, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                                                                     ^^^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'win'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:261:31:
    | 
261 | public func unProjectZO<T, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                               ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'model'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:261:48:
    | 
261 | public func unProjectZO<T, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                                ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'proj'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:261:69:
    | 
261 | public func unProjectZO<T, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                                                     ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'viewport'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:261:89:
    | 
261 | public func unProjectZO<T, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                                                                         ^^^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'win'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:265:31:
    | 
265 | public func unProjectNO<T, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                               ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'model'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:265:48:
    | 
265 | public func unProjectNO<T, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                                ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'proj'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:265:69:
    | 
265 | public func unProjectNO<T, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                                                     ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'viewport'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:265:89:
    | 
265 | public func unProjectNO<T, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                                                                         ^^^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'win'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:269:29:
    | 
269 | public func unProject<T, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                             ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'model'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:269:46:
    | 
269 | public func unProject<T, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                              ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'proj'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:269:67:
    | 
269 | public func unProject<T, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                                                   ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'viewport'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:269:87:
    | 
269 | public func unProject<T, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                                                                       ^^^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'center'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:275:30:
    | 
275 | public func pickMatrix<T, Q>(center: Vec2<T, Q>, delta: Vec2<T, Q>, viewport: Vec4<T, Q>): Mat4x4<T, Q>
    |                              ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'delta'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:275:50:
    | 
275 | public func pickMatrix<T, Q>(center: Vec2<T, Q>, delta: Vec2<T, Q>, viewport: Vec4<T, Q>): Mat4x4<T, Q>
    |                                                  ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'viewport'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:275:69:
    | 
275 | public func pickMatrix<T, Q>(center: Vec2<T, Q>, delta: Vec2<T, Q>, viewport: Vec4<T, Q>): Mat4x4<T, Q>
    |                                                                     ^^^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

285 warnings generated, 285 warnings printed.
warning[0m: imported decl 'Mat2x2' is conflicted with other import
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_float2x2.cj:2:26:
  | 
2 | public import glm.detail.Mat2x2
  |                          ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: The previous was imported here
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_double2x2.cj:2:26:
  | 
2 | public import glm.detail.Mat2x2
  |                          ^^^^^^ 
  | 

warning[0m: imported decl 'Mat2x3' is conflicted with other import
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_float2x3.cj:2:26:
  | 
2 | public import glm.detail.Mat2x3
  |                          ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: The previous was imported here
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_double2x3.cj:2:26:
  | 
2 | public import glm.detail.Mat2x3
  |                          ^^^^^^ 
  | 

warning[0m: imported decl 'Mat2x4' is conflicted with other import
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_float2x4.cj:2:26:
  | 
2 | public import glm.detail.Mat2x4
  |                          ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: The previous was imported here
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_double2x4.cj:2:26:
  | 
2 | public import glm.detail.Mat2x4
  |                          ^^^^^^ 
  | 

warning[0m: imported decl 'Mat3x2' is conflicted with other import
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_float3x2.cj:2:26:
  | 
2 | public import glm.detail.Mat3x2
  |                          ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: The previous was imported here
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_double3x2.cj:2:26:
  | 
2 | public import glm.detail.Mat3x2
  |                          ^^^^^^ 
  | 

warning[0m: imported decl 'Mat3x3' is conflicted with other import
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_float3x3.cj:2:26:
  | 
2 | public import glm.detail.Mat3x3
  |                          ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: The previous was imported here
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_double3x3.cj:2:26:
  | 
2 | public import glm.detail.Mat3x3
  |                          ^^^^^^ 
  | 

warning[0m: imported decl 'Mat3x4' is conflicted with other import
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_float3x4.cj:2:26:
  | 
2 | public import glm.detail.Mat3x4
  |                          ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: The previous was imported here
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_double3x4.cj:2:26:
  | 
2 | public import glm.detail.Mat3x4
  |                          ^^^^^^ 
  | 

warning[0m: imported decl 'Mat4x2' is conflicted with other import
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_float4x2.cj:2:26:
  | 
2 | public import glm.detail.Mat4x2
  |                          ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: The previous was imported here
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_double4x2.cj:2:26:
  | 
2 | public import glm.detail.Mat4x2
  |                          ^^^^^^ 
  | 

warning[0m: imported decl 'Mat4x3' is conflicted with other import
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_float4x3.cj:2:26:
  | 
2 | public import glm.detail.Mat4x3
  |                          ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: The previous was imported here
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_double4x3.cj:2:26:
  | 
2 | public import glm.detail.Mat4x3
  |                          ^^^^^^ 
  | 

warning[0m: imported decl 'Mat4x4' is conflicted with other import
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_float4x4.cj:2:26:
  | 
2 | public import glm.detail.Mat4x4
  |                          ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: The previous was imported here
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_double4x4.cj:2:26:
  | 
2 | public import glm.detail.Mat4x4
  |                          ^^^^^^ 
  | 

warning[0m: imported decl 'Vec1' is conflicted with other import
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_float1.cj:2:26:
  | 
2 | public import glm.detail.Vec1
  |                          ^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: The previous was imported here
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_double1.cj:2:26:
  | 
2 | public import glm.detail.Vec1
  |                          ^^^^ 
  | 

warning[0m: imported decl 'Vec2' is conflicted with other import
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_float2.cj:2:26:
  | 
2 | public import glm.detail.Vec2
  |                          ^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: The previous was imported here
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_double2.cj:2:26:
  | 
2 | public import glm.detail.Vec2
  |                          ^^^^ 
  | 

warning[0m: imported decl 'Vec3' is conflicted with other import
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_float3.cj:2:26:
  | 
2 | public import glm.detail.Vec3
  |                          ^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: The previous was imported here
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_double3.cj:2:26:
  | 
2 | public import glm.detail.Vec3
  |                          ^^^^ 
  | 

warning[0m: imported decl 'Vec4' is conflicted with other import
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_float4.cj:2:26:
  | 
2 | public import glm.detail.Vec4
  |                          ^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: The previous was imported here
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_double4.cj:2:26:
  | 
2 | public import glm.detail.Vec4
  |                          ^^^^ 
  | 

warning[0m: unused variable:'q'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_exponential.cj:4:23:
  | 
4 | public func exp<T, Q>(q: Quat<T, Q>): Quat<T, Q>
  |                       ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'left'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_clip_space.cj:4:25:
  | 
4 | public func ortho<T, Q>(left: T, right: T, bottom: T, top: T): Mat4x4<T, Q>
  |                         ^^^^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'q'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_transform.cj:4:26:
  | 
4 | public func rotate<T, Q>(q: Quat<T, Q>, angle: T, axis: Vec3<T, Q>): Quat<T, Q>
  |                          ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'m'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_transform.cj:4:29:
  | 
4 | public func translate<T, Q>(m: Mat4x4<T, Q>, v: Vec3<T, Q>): Mat4x4<T, Q>
  |                             ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'fovy'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_projection.cj:4:31:
  | 
4 | public func perspective<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
  |                               ^^^^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'right'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_clip_space.cj:4:34:
  | 
4 | public func ortho<T, Q>(left: T, right: T, bottom: T, top: T): Mat4x4<T, Q>
  |                                  ^^^^^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'aspect'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_projection.cj:4:40:
  | 
4 | public func perspective<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
  |                                        ^^^^^^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'angle'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_transform.cj:4:41:
  | 
4 | public func rotate<T, Q>(q: Quat<T, Q>, angle: T, axis: Vec3<T, Q>): Quat<T, Q>
  |                                         ^^^^^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'bottom'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_clip_space.cj:4:44:
  | 
4 | public func ortho<T, Q>(left: T, right: T, bottom: T, top: T): Mat4x4<T, Q>
  |                                            ^^^^^^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'v'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_transform.cj:4:46:
  | 
4 | public func translate<T, Q>(m: Mat4x4<T, Q>, v: Vec3<T, Q>): Mat4x4<T, Q>
  |                                              ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'axis'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_transform.cj:4:51:
  | 
4 | public func rotate<T, Q>(q: Quat<T, Q>, angle: T, axis: Vec3<T, Q>): Quat<T, Q>
  |                                                   ^^^^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_projection.cj:4:51:
  | 
4 | public func perspective<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
  |                                                   ^^^^^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'top'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_clip_space.cj:4:55:
  | 
4 | public func ortho<T, Q>(left: T, right: T, bottom: T, top: T): Mat4x4<T, Q>
  |                                                       ^^^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_projection.cj:4:61:
  | 
4 | public func perspective<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
  |                                                             ^^^^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'q'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_exponential.cj:6:23:
  | 
6 | public func log<T, Q>(q: Quat<T, Q>): Quat<T, Q>
  |                       ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_exponential.cj:8:23:
  | 
8 | public func pow<T, Q>(x: Quat<T, Q>, y: T): Quat<T, Q>
  |                       ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_exponential.cj:8:38:
  | 
8 | public func pow<T, Q>(x: Quat<T, Q>, y: T): Quat<T, Q>
  |                                      ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_exponential.cj:10:24:
   | 
10 | public func sqrt<T, Q>(x: Quat<T, Q>): Quat<T, Q>
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_trigonometric.cj:23:25:
   | 
23 | public func angle<T, Q>(x: Quat<T, Q>): T
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'angle'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_trigonometric.cj:26:29:
   | 
26 | public func angleAxis<T, Q>(angle: T, axis: Vec3<T, Q>): Quat<T, Q>
   |                             ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'axis'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_trigonometric.cj:26:39:
   | 
26 | public func angleAxis<T, Q>(angle: T, axis: Vec3<T, Q>): Quat<T, Q>
   |                                       ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_common.cj:34:23:
   | 
34 | public func mix<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T): Quat<T, Q>
   |                       ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_common.cj:34:38:
   | 
34 | public func mix<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T): Quat<T, Q>
   |                                      ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'a'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_common.cj:34:53:
   | 
34 | public func mix<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T): Quat<T, Q>
   |                                                     ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_common.cj:37:25:
   | 
37 | public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T): Quat<T, Q>
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_common.cj:37:40:
   | 
37 | public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T): Quat<T, Q>
   |                                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'a'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_common.cj:37:55:
   | 
37 | public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T): Quat<T, Q>
   |                                                       ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_common.cj:40:25:
   | 
40 | public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T, k: Int64): Quat<T, Q>
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_common.cj:40:40:
   | 
40 | public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T, k: Int64): Quat<T, Q>
   |                                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'a'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_common.cj:40:55:
   | 
40 | public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T, k: Int64): Quat<T, Q>
   |                                                       ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'k'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_common.cj:40:61:
   | 
40 | public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T, k: Int64): Quat<T, Q>
   |                                                             ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:199:25:
    | 
199 | public func equal<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Int64): Vec1<Bool, Q>
    |                         ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:199:40:
    | 
199 | public func equal<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Int64): Vec1<Bool, Q>
    |                                        ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:199:55:
    | 
199 | public func equal<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Int64): Vec1<Bool, Q>
    |                                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:202:25:
    | 
202 | public func equal<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Vec1<Int64, Q>): Vec1<Bool, Q>
    |                         ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:202:40:
    | 
202 | public func equal<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Vec1<Int64, Q>): Vec1<Bool, Q>
    |                                        ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:202:55:
    | 
202 | public func equal<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Vec1<Int64, Q>): Vec1<Bool, Q>
    |                                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:205:28:
    | 
205 | public func notEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Int64): Vec1<Bool, Q>
    |                            ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:205:43:
    | 
205 | public func notEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Int64): Vec1<Bool, Q>
    |                                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:205:58:
    | 
205 | public func notEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Int64): Vec1<Bool, Q>
    |                                                          ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:208:28:
    | 
208 | public func notEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Vec1<Int64, Q>): Vec1<Bool, Q>
    |                            ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:208:43:
    | 
208 | public func notEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Vec1<Int64, Q>): Vec1<Bool, Q>
    |                                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:208:58:
    | 
208 | public func notEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Vec1<Int64, Q>): Vec1<Bool, Q>
    |                                                          ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:213:25:
    | 
213 | public func equal<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Int64): Vec2<Bool, Q>
    |                         ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:213:40:
    | 
213 | public func equal<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Int64): Vec2<Bool, Q>
    |                                        ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:213:55:
    | 
213 | public func equal<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Int64): Vec2<Bool, Q>
    |                                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:216:25:
    | 
216 | public func equal<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Vec2<Int64, Q>): Vec2<Bool, Q>
    |                         ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:216:40:
    | 
216 | public func equal<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Vec2<Int64, Q>): Vec2<Bool, Q>
    |                                        ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:216:55:
    | 
216 | public func equal<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Vec2<Int64, Q>): Vec2<Bool, Q>
    |                                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:219:28:
    | 
219 | public func notEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Int64): Vec2<Bool, Q>
    |                            ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:219:43:
    | 
219 | public func notEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Int64): Vec2<Bool, Q>
    |                                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:219:58:
    | 
219 | public func notEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Int64): Vec2<Bool, Q>
    |                                                          ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:222:28:
    | 
222 | public func notEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Vec2<Int64, Q>): Vec2<Bool, Q>
    |                            ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:222:43:
    | 
222 | public func notEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Vec2<Int64, Q>): Vec2<Bool, Q>
    |                                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:222:58:
    | 
222 | public func notEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Vec2<Int64, Q>): Vec2<Bool, Q>
    |                                                          ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:227:25:
    | 
227 | public func equal<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Int64): Vec3<Bool, Q>
    |                         ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:227:40:
    | 
227 | public func equal<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Int64): Vec3<Bool, Q>
    |                                        ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:227:55:
    | 
227 | public func equal<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Int64): Vec3<Bool, Q>
    |                                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:230:25:
    | 
230 | public func equal<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Vec3<Int64, Q>): Vec3<Bool, Q>
    |                         ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:230:40:
    | 
230 | public func equal<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Vec3<Int64, Q>): Vec3<Bool, Q>
    |                                        ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:230:55:
    | 
230 | public func equal<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Vec3<Int64, Q>): Vec3<Bool, Q>
    |                                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:233:28:
    | 
233 | public func notEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Int64): Vec3<Bool, Q>
    |                            ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:233:43:
    | 
233 | public func notEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Int64): Vec3<Bool, Q>
    |                                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:233:58:
    | 
233 | public func notEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Int64): Vec3<Bool, Q>
    |                                                          ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:236:28:
    | 
236 | public func notEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Vec3<Int64, Q>): Vec3<Bool, Q>
    |                            ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:236:43:
    | 
236 | public func notEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Vec3<Int64, Q>): Vec3<Bool, Q>
    |                                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:236:58:
    | 
236 | public func notEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Vec3<Int64, Q>): Vec3<Bool, Q>
    |                                                          ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:241:25:
    | 
241 | public func equal<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Int64): Vec4<Bool, Q>
    |                         ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:241:40:
    | 
241 | public func equal<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Int64): Vec4<Bool, Q>
    |                                        ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:241:55:
    | 
241 | public func equal<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Int64): Vec4<Bool, Q>
    |                                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:244:25:
    | 
244 | public func equal<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Vec4<Int64, Q>): Vec4<Bool, Q>
    |                         ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:244:40:
    | 
244 | public func equal<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Vec4<Int64, Q>): Vec4<Bool, Q>
    |                                        ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:244:55:
    | 
244 | public func equal<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Vec4<Int64, Q>): Vec4<Bool, Q>
    |                                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:247:28:
    | 
247 | public func notEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Int64): Vec4<Bool, Q>
    |                            ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:247:43:
    | 
247 | public func notEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Int64): Vec4<Bool, Q>
    |                                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:247:58:
    | 
247 | public func notEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Int64): Vec4<Bool, Q>
    |                                                          ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:250:28:
    | 
250 | public func notEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Vec4<Int64, Q>): Vec4<Bool, Q>
    |                            ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:250:43:
    | 
250 | public func notEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Vec4<Int64, Q>): Vec4<Bool, Q>
    |                                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:250:58:
    | 
250 | public func notEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Vec4<Int64, Q>): Vec4<Bool, Q>
    |                                                          ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

92 warnings generated, 92 warnings printed.
warning[0m: imported decl 'Vec1' is shadowed, it will be ignored by compiler
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:2:28:
  | 
2 | public import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }
  |                            ^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: 'Vec1' is declared here
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:105:13:
    | 
105 | public type Vec1 = detail.Vec1<Float32, PackedHighp>
    |             ^^^^ 
    | 

warning[0m: imported decl 'Vec2' is shadowed, it will be ignored by compiler
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:2:34:
  | 
2 | public import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }
  |                                  ^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: 'Vec2' is declared here
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:106:13:
    | 
106 | public type Vec2 = detail.Vec2<Float32, PackedHighp>
    |             ^^^^ 
    | 

warning[0m: imported decl 'Vec3' is shadowed, it will be ignored by compiler
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:2:40:
  | 
2 | public import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }
  |                                        ^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: 'Vec3' is declared here
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:107:13:
    | 
107 | public type Vec3 = detail.Vec3<Float32, PackedHighp>
    |             ^^^^ 
    | 

warning[0m: imported decl 'Vec4' is shadowed, it will be ignored by compiler
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:2:46:
  | 
2 | public import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }
  |                                              ^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: 'Vec4' is declared here
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:108:13:
    | 
108 | public type Vec4 = detail.Vec4<Float32, PackedHighp>
    |             ^^^^ 
    | 

warning[0m: unused import 'glm.detail.sin'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:20:
   | 
12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}
   |                    ^^^ unused import
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'glm.detail.cos'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:25:
   | 
12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}
   |                         ^^^ unused import
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'glm.detail.tan'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:30:
   | 
12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}
   |                              ^^^ unused import
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'glm.detail.asin'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:35:
   | 
12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}
   |                                   ^^^^ unused import
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'glm.detail.acos'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:41:
   | 
12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}
   |                                         ^^^^ unused import
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'glm.detail.atan'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:47:
   | 
12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}
   |                                               ^^^^ unused import
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'glm.detail.atan2'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:53:
   | 
12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}
   |                                                     ^^^^^ unused import
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'glm.detail.sinh'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:60:
   | 
12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}
   |                                                            ^^^^ unused import
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'glm.detail.cosh'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:66:
   | 
12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}
   |                                                                  ^^^^ unused import
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'glm.detail.tanh'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:72:
   | 
12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}
   |                                                                        ^^^^ unused import
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'glm.detail.asinh'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:78:
   | 
12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}
   |                                                                              ^^^^^ unused import
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'glm.detail.acosh'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:85:
   | 
12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}
   |                                                                                     ^^^^^ unused import
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'glm.detail.atanh'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:92:
   | 
12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}
   |                                                                                            ^^^^^ unused import
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'glm.detail.radians'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:99:
   | 
12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}
   |                                                                                                   ^^^^^^^ unused import
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'glm.detail.degrees'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:108:
   | 
12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}
   |                                                                                                            ^^^^^^^ unused import
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'glm.ext.*'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:14:1:
   | 
14 | import glm.ext.*
   | ^^^^^^^^^^^^^^^^ unused import
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'glm.gtc.*'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:16:1:
   | 
16 | import glm.gtc.*
   | ^^^^^^^^^^^^^^^^ unused import
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

21 warnings generated, 21 warnings printed.
[?25l[0J7[;r8
[1F7[9999E8--------------------------------------------------------------------------------------------------
TP: [33mglm.detail[0m, time elapsed: 144864700 ns, RESULT:
    TCS: [33mTestCase_testComputeVecAdd1[0m, time elapsed: 1583300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAdd1 (284700 ns)
    TCS: [33mTestCase_testComputeVecSub2[0m, time elapsed: 384500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub2 (37400 ns)
    TCS: [33mTestCase_testComputeVecMul3[0m, time elapsed: 267500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul3 (31000 ns)
    TCS: [33mTestCase_testComputeVecMod1[0m, time elapsed: 274400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMod1 (24700 ns)
    TCS: [33mTestCase_testComputeVecMod4[0m, time elapsed: 267200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMod4 (24000 ns)
    TCS: [33mTestCase_testComputeVecAnd1[0m, time elapsed: 243300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAnd1 (19600 ns)
    TCS: [33mTestCase_testComputeVecAnd3[0m, time elapsed: 250400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAnd3 (18600 ns)
    TCS: [33mTestCase_testComputeVecOr1[0m, time elapsed: 274300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecOr1 (21200 ns)
    TCS: [33mTestCase_testComputeVecOr2[0m, time elapsed: 247100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecOr2 (15000 ns)
    TCS: [33mTestCase_testComputeVecXor1[0m, time elapsed: 297100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecXor1 (60300 ns)
    TCS: [33mTestCase_testComputeVecXor4[0m, time elapsed: 245900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecXor4 (23800 ns)
    TCS: [33mTestCase_testComputeVecShiftLeft1[0m, time elapsed: 231500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftLeft1 (14900 ns)
    TCS: [33mTestCase_testComputeVecShiftLeft3[0m, time elapsed: 242600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftLeft3 (11800 ns)
    TCS: [33mTestCase_testComputeVecShiftRight1[0m, time elapsed: 347000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftRight1 (23700 ns)
    TCS: [33mTestCase_testComputeVecShiftRight4[0m, time elapsed: 375800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftRight4 (25800 ns)
    TCS: [33mTestCase_testComputeVecEqual1[0m, time elapsed: 443100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual1 (31200 ns)
    TCS: [33mTestCase_testComputeVecNequal4[0m, time elapsed: 382800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal4 (27400 ns)
    TCS: [33mTestCase_testComputeVecBitwiseNot1[0m, time elapsed: 293600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecBitwiseNot1 (32700 ns)
    TCS: [33mTestCase_testComputeVecBitwiseNot3[0m, time elapsed: 277600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecBitwiseNot3 (23300 ns)
    TCS: [33mTestCase_testComputeVecAdd4[0m, time elapsed: 359300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAdd4 (38100 ns)
    TCS: [33mTestCase_testComputeVecSub1[0m, time elapsed: 631800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub1 (31300 ns)
    TCS: [33mTestCase_testComputeVecSub3[0m, time elapsed: 235000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub3 (22900 ns)
    TCS: [33mTestCase_testComputeVecMul1[0m, time elapsed: 284000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul1 (17800 ns)
    TCS: [33mTestCase_testComputeVecMul2[0m, time elapsed: 226000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul2 (18600 ns)
    TCS: [33mTestCase_testComputeVecDiv1[0m, time elapsed: 222500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecDiv1 (23700 ns)
    TCS: [33mTestCase_testComputeVecDiv2[0m, time elapsed: 248300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecDiv2 (18400 ns)
    TCS: [33mTestCase_testComputeVecDiv4[0m, time elapsed: 240200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecDiv4 (21400 ns)
    TCS: [33mTestCase_testComputeVecEqual2[0m, time elapsed: 238300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual2 (19800 ns)
    TCS: [33mTestCase_testComputeVecEqual3[0m, time elapsed: 256500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual3 (22200 ns)
    TCS: [33mTestCase_testComputeVecEqual4[0m, time elapsed: 234200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual4 (15200 ns)
    TCS: [33mTestCase_testComputeVecNequal1[0m, time elapsed: 217400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal1 (13100 ns)
    TCS: [33mTestCase_testComputeVecNequal2[0m, time elapsed: 353400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal2 (11900 ns)
    TCS: [33mTestCase_testComputeVecBitwiseNot4[0m, time elapsed: 399300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecBitwiseNot4 (38600 ns)
    TCS: [33mTestCase_testComputeVecAddFloat32[0m, time elapsed: 248900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAddFloat32 (27500 ns)
    TCS: [33mTestCase_testComputeVecAddFloat32Vec3[0m, time elapsed: 227100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAddFloat32Vec3 (26800 ns)
    TCS: [33mTestCase_testComputeVecSubFloat32[0m, time elapsed: 205700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSubFloat32 (15600 ns)
    TCS: [33mTestCase_testComputeVecSubFloat32Vec4[0m, time elapsed: 276600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSubFloat32Vec4 (26100 ns)
    TCS: [33mTestCase_testComputeEqualInt32Equal[0m, time elapsed: 365200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt32Equal (22400 ns)
    TCS: [33mTestCase_testComputeEqualInt32NotEqual[0m, time elapsed: 361100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt32NotEqual (22700 ns)
    TCS: [33mTestCase_testComputeEqualFloat32Equal[0m, time elapsed: 221500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32Equal (13400 ns)
    TCS: [33mTestCase_testComputeEqualFloat32NotEqual[0m, time elapsed: 212000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32NotEqual (21100 ns)
    TCS: [33mTestCase_testComputeEqualFloat64Equal[0m, time elapsed: 194200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64Equal (9300 ns)
    TCS: [33mTestCase_testComputeEqualFloat64NotEqual[0m, time elapsed: 196400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64NotEqual (9700 ns)
    TCS: [33mTestCase_testComputeEqualBoolEqual[0m, time elapsed: 204900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualBoolEqual (13400 ns)
    TCS: [33mTestCase_testComputeEqualBoolNotEqual[0m, time elapsed: 195000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualBoolNotEqual (9400 ns)
    TCS: [33mTestCase_testComputeEqualNumericInt32[0m, time elapsed: 191600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericInt32 (11400 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32[0m, time elapsed: 225900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32 (39900 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32Epsilon[0m, time elapsed: 206800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32Epsilon (13100 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64[0m, time elapsed: 201000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64 (14500 ns)
    TCS: [33mTestCase_testComputeEqualInt64Equal[0m, time elapsed: 197300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt64Equal (15200 ns)
    TCS: [33mTestCase_testComputeEqualInt64NotEqual[0m, time elapsed: 274600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt64NotEqual (17100 ns)
    TCS: [33mTestCase_testComputeEqualFloat32Nan[0m, time elapsed: 210000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32Nan (13000 ns)
    TCS: [33mTestCase_testComputeEqualFloat64Nan[0m, time elapsed: 202500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64Nan (8200 ns)
    TCS: [33mTestCase_testComputeEqualFloat32SignedZero[0m, time elapsed: 223600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32SignedZero (12800 ns)
    TCS: [33mTestCase_testComputeEqualFloat64SignedZero[0m, time elapsed: 199900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64SignedZero (9200 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32NotEqual[0m, time elapsed: 203300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32NotEqual (12100 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32BeyondEpsilon[0m, time elapsed: 290000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32BeyondEpsilon (11100 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64NotEqual[0m, time elapsed: 339700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64NotEqual (26700 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64Epsilon[0m, time elapsed: 451400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64Epsilon (31200 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64BeyondEpsilon[0m, time elapsed: 394200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64BeyondEpsilon (35700 ns)
    TCS: [33mTestCase_testComputeEqualNumericInt64[0m, time elapsed: 266900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericInt64 (18100 ns)
    TCS: [33mTestCase_testPackedHighpImplementsQualifier[0m, time elapsed: 352900 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedHighpImplementsQualifier (12700 ns)
    TCS: [33mTestCase_testPackedMediumpImplementsQualifier[0m, time elapsed: 294100 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedMediumpImplementsQualifier (32900 ns)
    TCS: [33mTestCase_testPackedLowpImplementsQualifier[0m, time elapsed: 277500 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedLowpImplementsQualifier (12300 ns)
    TCS: [33mTestCase_testDefaultpIsPackedHighp[0m, time elapsed: 220700 ns, RESULT:
    [[32m PASSED [0m] CASE: testDefaultpIsPackedHighp (10100 ns)
    TCS: [33mTestCase_testScalarAddVec1[0m, time elapsed: 225800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec1 (18700 ns)
    TCS: [33mTestCase_testScalarAddVec2[0m, time elapsed: 229000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec2 (16800 ns)
    TCS: [33mTestCase_testScalarAddVec3[0m, time elapsed: 231100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec3 (17200 ns)
    TCS: [33mTestCase_testScalarAddVec4[0m, time elapsed: 211700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec4 (13400 ns)
    TCS: [33mTestCase_testScalarSubVec1[0m, time elapsed: 241800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1 (19100 ns)
    TCS: [33mTestCase_testScalarMulVec1[0m, time elapsed: 205800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1 (16200 ns)
    TCS: [33mTestCase_testScalarDivVec1[0m, time elapsed: 202600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1 (12500 ns)
    TCS: [33mTestCase_testScalarModVec1[0m, time elapsed: 303600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1 (18100 ns)
    TCS: [33mTestCase_testScalarMulVec2[0m, time elapsed: 258900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2 (19800 ns)
    TCS: [33mTestCase_testScalarSubVec2[0m, time elapsed: 198000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2 (10900 ns)
    TCS: [33mTestCase_testScalarSubVec3[0m, time elapsed: 219800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3 (15000 ns)
    TCS: [33mTestCase_testScalarSubVec4[0m, time elapsed: 208500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4 (14400 ns)
    TCS: [33mTestCase_testScalarMulVec3[0m, time elapsed: 192700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3 (8500 ns)
    TCS: [33mTestCase_testScalarMulVec4[0m, time elapsed: 206600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4 (14800 ns)
    TCS: [33mTestCase_testScalarDivVec2[0m, time elapsed: 202000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2 (11700 ns)
    TCS: [33mTestCase_testScalarDivVec3[0m, time elapsed: 202700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3 (9300 ns)
    TCS: [33mTestCase_testScalarDivVec4[0m, time elapsed: 190700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4 (13600 ns)
    TCS: [33mTestCase_testScalarModVec2[0m, time elapsed: 206000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2 (9800 ns)
    TCS: [33mTestCase_testScalarModVec3[0m, time elapsed: 205400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3 (13700 ns)
    TCS: [33mTestCase_testScalarModVec4[0m, time elapsed: 192900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4 (14700 ns)
    TCS: [33mTestCase_testScalarModVec1Float32[0m, time elapsed: 216600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float32 (19300 ns)
    TCS: [33mTestCase_testScalarModVec2Float32[0m, time elapsed: 196500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32 (12500 ns)
    TCS: [33mTestCase_testScalarModVec3Float32[0m, time elapsed: 209400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float32 (11600 ns)
    TCS: [33mTestCase_testScalarModVec4Float32[0m, time elapsed: 268800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float32 (11900 ns)
    TCS: [33mTestCase_testScalarModVec1Float64[0m, time elapsed: 202400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float64 (19900 ns)
    TCS: [33mTestCase_testScalarModVec2Float64[0m, time elapsed: 187700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float64 (9700 ns)
    TCS: [33mTestCase_testScalarModVec3Float64[0m, time elapsed: 193900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float64 (9200 ns)
    TCS: [33mTestCase_testScalarModVec4Float64[0m, time elapsed: 207300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float64 (9900 ns)
    TCS: [33mTestCase_testScalarModVec1Float16[0m, time elapsed: 205100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float16 (19100 ns)
    TCS: [33mTestCase_testScalarModVec2Float16[0m, time elapsed: 277500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float16 (17700 ns)
    TCS: [33mTestCase_testScalarModVec3Float16[0m, time elapsed: 218600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float16 (16400 ns)
    TCS: [33mTestCase_testScalarModVec4Float16[0m, time elapsed: 242800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float16 (12200 ns)
    TCS: [33mTestCase_testScalarSubVec2PackedMediump[0m, time elapsed: 219700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2PackedMediump (16600 ns)
    TCS: [33mTestCase_testScalarSubVec2PackedLowp[0m, time elapsed: 216300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2PackedLowp (14500 ns)
    TCS: [33mTestCase_testScalarMulVec2PackedMediump[0m, time elapsed: 203900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2PackedMediump (11800 ns)
    TCS: [33mTestCase_testScalarMulVec2PackedLowp[0m, time elapsed: 206300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2PackedLowp (19200 ns)
    TCS: [33mTestCase_testScalarDivVec2PackedMediump[0m, time elapsed: 213200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2PackedMediump (10900 ns)
    TCS: [33mTestCase_testScalarDivVec2PackedLowp[0m, time elapsed: 202600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2PackedLowp (10600 ns)
    TCS: [33mTestCase_testScalarModVec2PackedMediump[0m, time elapsed: 193700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2PackedMediump (11800 ns)
    TCS: [33mTestCase_testScalarModVec2PackedLowp[0m, time elapsed: 195200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2PackedLowp (8500 ns)
    TCS: [33mTestCase_testScalarModVec2Float32PackedMediump[0m, time elapsed: 201500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32PackedMediump (10800 ns)
    TCS: [33mTestCase_testScalarModVec2Float32PackedLowp[0m, time elapsed: 518100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32PackedLowp (23100 ns)
    TCS: [33mTestCase_testScalarModVec2Float32NegativeDividend[0m, time elapsed: 293200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32NegativeDividend (17200 ns)
    TCS: [33mTestCase_testScalarModVec2Float32NegativeDivisor[0m, time elapsed: 276400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32NegativeDivisor (16700 ns)
    TCS: [33mTestCase_testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents[0m, time elapsed: 366700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents (126900 ns)
    TCS: [33mTestCase_testScalarAddVec1Float32[0m, time elapsed: 248800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec1Float32 (16600 ns)
    TCS: [33mTestCase_testScalarAddVec2Float32[0m, time elapsed: 209300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec2Float32 (13400 ns)
    TCS: [33mTestCase_testScalarAddVec3Float32[0m, time elapsed: 208000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec3Float32 (10900 ns)
    TCS: [33mTestCase_testScalarAddVec4Float32[0m, time elapsed: 209000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec4Float32 (11700 ns)
    TCS: [33mTestCase_testScalarSubVec1Float32[0m, time elapsed: 200500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1Float32 (13400 ns)
    TCS: [33mTestCase_testScalarSubVec2Float32[0m, time elapsed: 211200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2Float32 (12300 ns)
    TCS: [33mTestCase_testScalarSubVec3Float32[0m, time elapsed: 231000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3Float32 (12700 ns)
    TCS: [33mTestCase_testScalarSubVec4Float32[0m, time elapsed: 209300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4Float32 (10100 ns)
    TCS: [33mTestCase_testScalarMulVec1Float32[0m, time elapsed: 205800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1Float32 (10400 ns)
    TCS: [33mTestCase_testScalarMulVec2Float32[0m, time elapsed: 195500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2Float32 (9600 ns)
    TCS: [33mTestCase_testScalarMulVec3Float32[0m, time elapsed: 312800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3Float32 (15100 ns)
    TCS: [33mTestCase_testScalarMulVec4Float32[0m, time elapsed: 192500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4Float32 (9700 ns)
    TCS: [33mTestCase_testScalarDivVec1Float32[0m, time elapsed: 191600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1Float32 (10800 ns)
    TCS: [33mTestCase_testScalarDivVec2Float32[0m, time elapsed: 190100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2Float32 (10300 ns)
    TCS: [33mTestCase_testScalarDivVec3Float32[0m, time elapsed: 190900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3Float32 (10200 ns)
    TCS: [33mTestCase_testScalarDivVec4Float32[0m, time elapsed: 190600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4Float32 (9200 ns)
    TCS: [33mTestCase_testScalarAddVec1Int32[0m, time elapsed: 209700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec1Int32 (18000 ns)
    TCS: [33mTestCase_testScalarAddVec2Int32[0m, time elapsed: 191900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec2Int32 (9100 ns)
    TCS: [33mTestCase_testScalarAddVec3Int32[0m, time elapsed: 193400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec3Int32 (9800 ns)
    TCS: [33mTestCase_testScalarAddVec4Int32[0m, time elapsed: 191700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec4Int32 (10800 ns)
    TCS: [33mTestCase_testScalarSubVec1Int32[0m, time elapsed: 189300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1Int32 (13400 ns)
    TCS: [33mTestCase_testScalarSubVec2Int32[0m, time elapsed: 186600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2Int32 (9800 ns)
    TCS: [33mTestCase_testScalarSubVec3Int32[0m, time elapsed: 193400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3Int32 (15600 ns)
    TCS: [33mTestCase_testScalarSubVec4Int32[0m, time elapsed: 337700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4Int32 (17800 ns)
    TCS: [33mTestCase_testScalarMulVec1Int32[0m, time elapsed: 349400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1Int32 (20900 ns)
    TCS: [33mTestCase_testScalarMulVec2Int32[0m, time elapsed: 293400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2Int32 (16500 ns)
    TCS: [33mTestCase_testScalarMulVec3Int32[0m, time elapsed: 222300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3Int32 (10800 ns)
    TCS: [33mTestCase_testScalarMulVec4Int32[0m, time elapsed: 203700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4Int32 (10200 ns)
    TCS: [33mTestCase_testScalarDivVec1Int32[0m, time elapsed: 201700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1Int32 (9800 ns)
    TCS: [33mTestCase_testScalarDivVec2Int32[0m, time elapsed: 278600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2Int32 (16500 ns)
    TCS: [33mTestCase_testScalarDivVec3Int32[0m, time elapsed: 251900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3Int32 (12500 ns)
    TCS: [33mTestCase_testScalarDivVec4Int32[0m, time elapsed: 211600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4Int32 (11500 ns)
    TCS: [33mTestCase_testScalarModVec1Int32[0m, time elapsed: 224500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Int32 (11900 ns)
    TCS: [33mTestCase_testScalarModVec2Int32[0m, time elapsed: 210000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Int32 (9500 ns)
    TCS: [33mTestCase_testScalarModVec3Int32[0m, time elapsed: 209700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Int32 (13600 ns)
    TCS: [33mTestCase_testScalarModVec4Int32[0m, time elapsed: 204400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Int32 (9700 ns)
    TCS: [33mTestCase_testScalarSubVec1PackedMediump[0m, time elapsed: 223200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1PackedMediump (13600 ns)
    TCS: [33mTestCase_testScalarSubVec1PackedLowp[0m, time elapsed: 214500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1PackedLowp (13300 ns)
    TCS: [33mTestCase_testScalarSubVec3PackedMediump[0m, time elapsed: 281400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3PackedMediump (13400 ns)
    TCS: [33mTestCase_testScalarSubVec3PackedLowp[0m, time elapsed: 313400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3PackedLowp (25100 ns)
    TCS: [33mTestCase_testScalarSubVec4PackedMediump[0m, time elapsed: 212500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4PackedMediump (12000 ns)
    TCS: [33mTestCase_testScalarSubVec4PackedLowp[0m, time elapsed: 270200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4PackedLowp (11200 ns)
    TCS: [33mTestCase_testScalarMulVec1PackedMediump[0m, time elapsed: 212600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1PackedMediump (11900 ns)
    TCS: [33mTestCase_testScalarMulVec1PackedLowp[0m, time elapsed: 219400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1PackedLowp (11400 ns)
    TCS: [33mTestCase_testScalarMulVec3PackedMediump[0m, time elapsed: 320500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3PackedMediump (23000 ns)
    TCS: [33mTestCase_testScalarMulVec3PackedLowp[0m, time elapsed: 499400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3PackedLowp (28700 ns)
    TCS: [33mTestCase_testScalarMulVec4PackedMediump[0m, time elapsed: 369400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4PackedMediump (22300 ns)
    TCS: [33mTestCase_testScalarMulVec4PackedLowp[0m, time elapsed: 311100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4PackedLowp (16800 ns)
    TCS: [33mTestCase_testScalarDivVec1PackedMediump[0m, time elapsed: 328600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1PackedMediump (18500 ns)
    TCS: [33mTestCase_testScalarDivVec1PackedLowp[0m, time elapsed: 231700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1PackedLowp (12400 ns)
    TCS: [33mTestCase_testScalarDivVec3PackedMediump[0m, time elapsed: 232800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3PackedMediump (18300 ns)
    TCS: [33mTestCase_testScalarDivVec3PackedLowp[0m, time elapsed: 227900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3PackedLowp (12700 ns)
    TCS: [33mTestCase_testScalarDivVec4PackedMediump[0m, time elapsed: 209900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4PackedMediump (11300 ns)
    TCS: [33mTestCase_testScalarDivVec4PackedLowp[0m, time elapsed: 201100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4PackedLowp (11100 ns)
    TCS: [33mTestCase_testScalarModVec1PackedMediump[0m, time elapsed: 386000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1PackedMediump (18400 ns)
    TCS: [33mTestCase_testScalarModVec1PackedLowp[0m, time elapsed: 217200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1PackedLowp (18100 ns)
    TCS: [33mTestCase_testScalarModVec3PackedMediump[0m, time elapsed: 197400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3PackedMediump (12200 ns)
    TCS: [33mTestCase_testScalarModVec3PackedLowp[0m, time elapsed: 193400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3PackedLowp (10200 ns)
    TCS: [33mTestCase_testScalarModVec4PackedMediump[0m, time elapsed: 184900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4PackedMediump (10700 ns)
    TCS: [33mTestCase_testScalarModVec4PackedLowp[0m, time elapsed: 191400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4PackedLowp (10400 ns)
    TCS: [33mTestCase_testScalarDivZeroVec1[0m, time elapsed: 196100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivZeroVec1 (15700 ns)
    TCS: [33mTestCase_testScalarAddNegVec1[0m, time elapsed: 191400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddNegVec1 (13200 ns)
    TCS: [33mTestCase_testScalarAddNegVec2[0m, time elapsed: 189000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddNegVec2 (9900 ns)
    TCS: [33mTestCase_testScalarMulOverflowVec1[0m, time elapsed: 183400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulOverflowVec1 (8700 ns)
    TCS: [33mTestCase_testScalarSubNegVec1[0m, time elapsed: 188300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubNegVec1 (12300 ns)
    TCS: [33mTestCase_testVersionMajor[0m, time elapsed: 185000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionMajor (9000 ns)
    TCS: [33mTestCase_testVersionMinor[0m, time elapsed: 182100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionMinor (11300 ns)
    TCS: [33mTestCase_testVersionPatch[0m, time elapsed: 197000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionPatch (7700 ns)
    TCS: [33mTestCase_testVersionEncoded[0m, time elapsed: 206600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionEncoded (22700 ns)
    TCS: [33mTestCase_testConfigSimd[0m, time elapsed: 192800 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigSimd (11600 ns)
    TCS: [33mTestCase_testConfigAlignedGentypes[0m, time elapsed: 202300 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigAlignedGentypes (9300 ns)
    TCS: [33mTestCase_testConfigClipControl[0m, time elapsed: 207600 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigClipControl (10000 ns)
    TCS: [33mTestCase_testConstNegationSimd[0m, time elapsed: 193500 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationSimd (11200 ns)
    TCS: [33mTestCase_testConstNegationAligned[0m, time elapsed: 205000 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationAligned (8900 ns)
    TCS: [33mTestCase_testConstNegationClip[0m, time elapsed: 208800 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationClip (9300 ns)
    TCS: [33mTestCase_testConstInt64Usage[0m, time elapsed: 209700 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstInt64Usage (10100 ns)
    TCS: [33mTestCase_testConstBoolUsage[0m, time elapsed: 193700 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstBoolUsage (7900 ns)
    TCS: [33mTestCase_testVersionEncodingConsistency[0m, time elapsed: 193900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionEncodingConsistency (11300 ns)
    TCS: [33mTestCase_testAssertPasses[0m, time elapsed: 211300 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertPasses (16100 ns)
    TCS: [33mTestCase_testAssertFails[0m, time elapsed: 256100 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertFails (57000 ns)
    TCS: [33mTestCase_testAssertWithCustomMessage[0m, time elapsed: 269200 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertWithCustomMessage (30400 ns)
    TCS: [33mTestCase_testNumericLimitsFloat32Epsilon[0m, time elapsed: 210100 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsFloat32Epsilon (13800 ns)
    TCS: [33mTestCase_testNumericLimitsFloat64Epsilon[0m, time elapsed: 199700 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsFloat64Epsilon (11200 ns)
    TCS: [33mTestCase_testIsIec559OfFloat32[0m, time elapsed: 204600 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfFloat32 (13900 ns)
    TCS: [33mTestCase_testIsIec559OfFloat64[0m, time elapsed: 219000 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfFloat64 (9000 ns)
    TCS: [33mTestCase_testIsIec559OfInt64[0m, time elapsed: 220700 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfInt64 (13100 ns)
    TCS: [33mTestCase_testEpsilonOfFloat32[0m, time elapsed: 225500 ns, RESULT:
    [[32m PASSED [0m] CASE: testEpsilonOfFloat32 (14400 ns)
    TCS: [33mTestCase_testEpsilonOfFloat64[0m, time elapsed: 229100 ns, RESULT:
    [[32m PASSED [0m] CASE: testEpsilonOfFloat64 (12200 ns)
    TCS: [33mTestCase_testNumericLimitsInt64Epsilon[0m, time elapsed: 207300 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt64Epsilon (15000 ns)
    TCS: [33mTestCase_testNumericLimitsInt32Epsilon[0m, time elapsed: 209500 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt32Epsilon (11100 ns)
    TCS: [33mTestCase_testNumericLimitsInt16Epsilon[0m, time elapsed: 209500 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt16Epsilon (13500 ns)
    TCS: [33mTestCase_testNumericLimitsInt8Epsilon[0m, time elapsed: 204300 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt8Epsilon (13400 ns)
    TCS: [33mTestCase_testCastVec1ToVec1IntToFloat[0m, time elapsed: 218500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec1ToVec1IntToFloat (15200 ns)
    TCS: [33mTestCase_testCastVec2ToVec1TakesOnlyX[0m, time elapsed: 206200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2ToVec1TakesOnlyX (12500 ns)
    TCS: [33mTestCase_testCastVec3ToVec1TakesOnlyX[0m, time elapsed: 206000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3ToVec1TakesOnlyX (14500 ns)
    TCS: [33mTestCase_testCastVec4ToVec1TakesOnlyX[0m, time elapsed: 333100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4ToVec1TakesOnlyX (19600 ns)
    TCS: [33mTestCase_testCastSameTypeIdentity[0m, time elapsed: 854600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastSameTypeIdentity (57800 ns)
    TCS: [33mTestCase_testCastInt32ToInt64[0m, time elapsed: 443300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastInt32ToInt64 (37900 ns)
    TCS: [33mTestCase_testCastFloatToIntTruncation[0m, time elapsed: 505400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastFloatToIntTruncation (37400 ns)
    TCS: [33mTestCase_testCastCrossQualifierPackedHighpToDefaultp[0m, time elapsed: 484600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastCrossQualifierPackedHighpToDefaultp (53600 ns)
    TCS: [33mTestCase_testCastCrossQualifierDefaultpToPackedHighp[0m, time elapsed: 531600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastCrossQualifierDefaultpToPackedHighp (33000 ns)
    TCS: [33mTestCase_testCastVec2CrossQualifierCrossType[0m, time elapsed: 355900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2CrossQualifierCrossType (20200 ns)
    TCS: [33mTestCase_testCastVec3CrossQualifier[0m, time elapsed: 338800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3CrossQualifier (18200 ns)
    TCS: [33mTestCase_testCastVec4CrossQualifier[0m, time elapsed: 358700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4CrossQualifier (22100 ns)
    TCS: [33mTestCase_testCastVec1DoesNotModifySource[0m, time elapsed: 330500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec1DoesNotModifySource (16000 ns)
    TCS: [33mTestCase_testCastVec2Vec1ToVec2IntToFloat[0m, time elapsed: 252100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec1ToVec2IntToFloat (14100 ns)
    TCS: [33mTestCase_testCastVec2Vec2ToVec2Identity[0m, time elapsed: 233000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec2ToVec2Identity (13300 ns)
    TCS: [33mTestCase_testCastVec2Vec3ToVec2TakesOnlyXY[0m, time elapsed: 307000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec3ToVec2TakesOnlyXY (22300 ns)
    TCS: [33mTestCase_testCastVec2Vec4ToVec2TakesOnlyXY[0m, time elapsed: 209900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec4ToVec2TakesOnlyXY (8900 ns)
    TCS: [33mTestCase_testCastVec2SameTypeIdentity[0m, time elapsed: 188000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2SameTypeIdentity (7000 ns)
    TCS: [33mTestCase_testCastVec2Int32ToInt64[0m, time elapsed: 183300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Int32ToInt64 (7500 ns)
    TCS: [33mTestCase_testCastVec2FloatToIntTruncation[0m, time elapsed: 194300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2FloatToIntTruncation (9900 ns)
    TCS: [33mTestCase_testCastVec2CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 179200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2CrossQualifierPackedHighpToDefaultp (6400 ns)
    TCS: [33mTestCase_testCastVec2DoesNotModifySource[0m, time elapsed: 186000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2DoesNotModifySource (6200 ns)
    TCS: [33mTestCase_testCastVec2Vec1ToVec2SameValueBothComponents[0m, time elapsed: 187800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec1ToVec2SameValueBothComponents (6800 ns)
    TCS: [33mTestCase_testCastVec3Vec1ToVec3IntToFloat[0m, time elapsed: 202200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec1ToVec3IntToFloat (13700 ns)
    TCS: [33mTestCase_testCastVec3Vec2ToVec3ExtendY[0m, time elapsed: 195500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec2ToVec3ExtendY (10900 ns)
    TCS: [33mTestCase_testCastVec3Vec3ToVec3Identity[0m, time elapsed: 195100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec3ToVec3Identity (10200 ns)
    TCS: [33mTestCase_testCastVec3Vec4ToVec3TakesOnlyXYZ[0m, time elapsed: 246900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec4ToVec3TakesOnlyXYZ (9700 ns)
    TCS: [33mTestCase_testCastVec3SameTypeIdentity[0m, time elapsed: 196900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3SameTypeIdentity (7400 ns)
    TCS: [33mTestCase_testCastVec3Int32ToInt64[0m, time elapsed: 196000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Int32ToInt64 (8000 ns)
    TCS: [33mTestCase_testCastVec3FloatToIntTruncation[0m, time elapsed: 193100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3FloatToIntTruncation (8600 ns)
    TCS: [33mTestCase_testCastVec3CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 186000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3CrossQualifierPackedHighpToDefaultp (9900 ns)
    TCS: [33mTestCase_testCastVec3DoesNotModifySource[0m, time elapsed: 190700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3DoesNotModifySource (6900 ns)
    TCS: [33mTestCase_testCastVec3Vec1ToVec3SameValueAllComponents[0m, time elapsed: 185400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec1ToVec3SameValueAllComponents (7700 ns)
    TCS: [33mTestCase_testCastVec4Vec1ToVec4IntToFloat[0m, time elapsed: 277500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec1ToVec4IntToFloat (20200 ns)
    TCS: [33mTestCase_testCastVec4Vec2ToVec4ExtendY[0m, time elapsed: 212800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec2ToVec4ExtendY (12200 ns)
    TCS: [33mTestCase_testCastVec4Vec3ToVec4ExtendZ[0m, time elapsed: 199300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec3ToVec4ExtendZ (10100 ns)
    TCS: [33mTestCase_testCastVec4Vec4ToVec4Identity[0m, time elapsed: 201200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec4ToVec4Identity (9800 ns)
    TCS: [33mTestCase_testCastVec4SameTypeIdentity[0m, time elapsed: 180500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4SameTypeIdentity (6700 ns)
    TCS: [33mTestCase_testCastVec4Int32ToInt64[0m, time elapsed: 187900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Int32ToInt64 (7600 ns)
    TCS: [33mTestCase_testCastVec4FloatToIntTruncation[0m, time elapsed: 192500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4FloatToIntTruncation (7400 ns)
    TCS: [33mTestCase_testCastVec4CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 180700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4CrossQualifierPackedHighpToDefaultp (9500 ns)
    TCS: [33mTestCase_testCastVec4DoesNotModifySource[0m, time elapsed: 179500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4DoesNotModifySource (6700 ns)
    TCS: [33mTestCase_testCastVec4Vec1ToVec4SameValueAllComponents[0m, time elapsed: 185100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec1ToVec4SameValueAllComponents (7000 ns)
    TCS: [33mTestCase_testFromBoolVec1[0m, time elapsed: 185600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec1 (7200 ns)
    TCS: [33mTestCase_testFromBoolVec1False[0m, time elapsed: 182600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec1False (6000 ns)
    TCS: [33mTestCase_testFromBoolVec2[0m, time elapsed: 186600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec2 (10500 ns)
    TCS: [33mTestCase_testFromBoolVec3[0m, time elapsed: 234100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec3 (11400 ns)
    TCS: [33mTestCase_testFromBoolVec4[0m, time elapsed: 181400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec4 (6500 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec1[0m, time elapsed: 183300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec1 (6500 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec2[0m, time elapsed: 248000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec2 (14800 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec3[0m, time elapsed: 373800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec3 (13500 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec4[0m, time elapsed: 494100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec4 (31300 ns)
    TCS: [33mTestCase_testFromBoolVec3AllFalse[0m, time elapsed: 292600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec3AllFalse (13200 ns)
    TCS: [33mTestCase_testFromBoolVec4AllFalse[0m, time elapsed: 272000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec4AllFalse (13700 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec3AllFalse[0m, time elapsed: 244400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec3AllFalse (11100 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec4AllFalse[0m, time elapsed: 176300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec4AllFalse (7300 ns)
    TCS: [33mTestCase_testFromBoolVecFloat32[0m, time elapsed: 177400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecFloat32 (12200 ns)
    TCS: [33mTestCase_testFromBoolVecFloat64[0m, time elapsed: 175300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecFloat64 (9300 ns)
    TCS: [33mTestCase_testFromBoolVecInt32[0m, time elapsed: 189500 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecInt32 (9500 ns)
    TCS: [33mTestCase_testFromBoolVecQ2PackedMediump[0m, time elapsed: 165800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2PackedMediump (7900 ns)
    TCS: [33mTestCase_testFromBoolVecQ2PackedLowp[0m, time elapsed: 173200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2PackedLowp (12200 ns)
    TCS: [33mTestCase_testS1QuatCastScalingXBranch[0m, time elapsed: 222600 ns, RESULT:
    [[32m PASSED [0m] CASE: testS1QuatCastScalingXBranch (49700 ns)
    TCS: [33mTestCase_testS1QuatCastScalingYBranch[0m, time elapsed: 186400 ns, RESULT:
    [[32m PASSED [0m] CASE: testS1QuatCastScalingYBranch (21000 ns)
    TCS: [33mTestCase_testS1QuatCastScalingZBranch[0m, time elapsed: 193200 ns, RESULT:
    [[32m PASSED [0m] CASE: testS1QuatCastScalingZBranch (17000 ns)
    TCS: [33mTestCase_testS1QuatCastScalingWBranch[0m, time elapsed: 186400 ns, RESULT:
    [[32m PASSED [0m] CASE: testS1QuatCastScalingWBranch (15600 ns)
    TCS: [33mTestCase_testS1QuatCastUnitRoundTrip[0m, time elapsed: 210700 ns, RESULT:
    [[32m PASSED [0m] CASE: testS1QuatCastUnitRoundTrip (12200 ns)
    TCS: [33mTestCase_testS1QuatCastIdentityRoundTrip[0m, time elapsed: 204000 ns, RESULT:
    [[32m PASSED [0m] CASE: testS1QuatCastIdentityRoundTrip (18900 ns)
    TCS: [33mTestCase_testS1QuatCastMat4Delegation[0m, time elapsed: 243400 ns, RESULT:
    [[32m PASSED [0m] CASE: testS1QuatCastMat4Delegation (40400 ns)
    TCS: [33mTestCase_testMat3EqualEpsilonRelaxedExactMatch[0m, time elapsed: 185400 ns, RESULT:
    [[32m PASSED [0m] CASE: testMat3EqualEpsilonRelaxedExactMatch (8000 ns)
    TCS: [33mTestCase_testMat3EqualEpsilonRelaxedWithinPosTolerance[0m, time elapsed: 183700 ns, RESULT:
    [[32m PASSED [0m] CASE: testMat3EqualEpsilonRelaxedWithinPosTolerance (7500 ns)
    TCS: [33mTestCase_testMat3EqualEpsilonRelaxedWithinNegTolerance[0m, time elapsed: 182900 ns, RESULT:
    [[32m PASSED [0m] CASE: testMat3EqualEpsilonRelaxedWithinNegTolerance (6800 ns)
    TCS: [33mTestCase_testMat3EqualEpsilonRelaxedBeyondTolerance[0m, time elapsed: 181300 ns, RESULT:
    [[32m PASSED [0m] CASE: testMat3EqualEpsilonRelaxedBeyondTolerance (7100 ns)
    TCS: [33mTestCase_testMat3EqualEpsilonRelaxedZeroMatrix[0m, time elapsed: 298700 ns, RESULT:
    [[32m PASSED [0m] CASE: testMat3EqualEpsilonRelaxedZeroMatrix (6400 ns)
    TCS: [33mTestCase_testMat3EqualEpsilonRelaxedSingleDiffBeyond[0m, time elapsed: 349200 ns, RESULT:
    [[32m PASSED [0m] CASE: testMat3EqualEpsilonRelaxedSingleDiffBeyond (14500 ns)
    TCS: [33mTestCase_testVec2ScalarInit[0m, time elapsed: 196200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarInit (16900 ns)
    TCS: [33mTestCase_testVec2ConstInit[0m, time elapsed: 194000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ConstInit (12900 ns)
    TCS: [33mTestCase_testVec2Length[0m, time elapsed: 187800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Length (6800 ns)
    TCS: [33mTestCase_testVec2Add[0m, time elapsed: 208500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Add (14600 ns)
    TCS: [33mTestCase_testVec2Sub[0m, time elapsed: 186900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Sub (11200 ns)
    TCS: [33mTestCase_testVec2Mul[0m, time elapsed: 195200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Mul (9100 ns)
    TCS: [33mTestCase_testVec2ScalarAdd[0m, time elapsed: 188700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarAdd (10000 ns)
    TCS: [33mTestCase_testVec2Negate[0m, time elapsed: 182600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Negate (10100 ns)
    TCS: [33mTestCase_testVec2IndexAccess[0m, time elapsed: 183000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2IndexAccess (6800 ns)
    TCS: [33mTestCase_testVec2IndexMutate[0m, time elapsed: 175600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2IndexMutate (5700 ns)
    TCS: [33mTestCase_testVec2ComponentAt[0m, time elapsed: 173600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ComponentAt (5700 ns)
    TCS: [33mTestCase_testVec2Equal[0m, time elapsed: 239800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Equal (13500 ns)
    TCS: [33mTestCase_testVec2NotEqual[0m, time elapsed: 189800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2NotEqual (15100 ns)
    TCS: [33mTestCase_testVec2EqualExact[0m, time elapsed: 182100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2EqualExact (9200 ns)
    TCS: [33mTestCase_testVec2BitwiseAnd[0m, time elapsed: 185600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseAnd (11000 ns)
    TCS: [33mTestCase_testVec2BitwiseNot[0m, time elapsed: 176400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseNot (8900 ns)
    TCS: [33mTestCase_testVec2FromVec1[0m, time elapsed: 174000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2FromVec1 (6500 ns)
    TCS: [33mTestCase_testVec2ShiftLeft[0m, time elapsed: 181400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeft (11300 ns)
    TCS: [33mTestCase_testVec2BoolLogicalAnd[0m, time elapsed: 188300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BoolLogicalAnd (9000 ns)
    TCS: [33mTestCase_testVec2Vec1ArithBroadcast[0m, time elapsed: 179300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Vec1ArithBroadcast (9300 ns)
    TCS: [33mTestCase_testVec2Vec1BitBroadcast[0m, time elapsed: 181600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Vec1BitBroadcast (10100 ns)
    TCS: [33mTestCase_testVec2ShiftLeftVec1[0m, time elapsed: 170900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeftVec1 (6400 ns)
    TCS: [33mTestCase_testVec2Div[0m, time elapsed: 174300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Div (9800 ns)
    TCS: [33mTestCase_testVec2Mod[0m, time elapsed: 182000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Mod (8700 ns)
    TCS: [33mTestCase_testVec2ScalarSub[0m, time elapsed: 174100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarSub (11200 ns)
    TCS: [33mTestCase_testVec2ScalarMul[0m, time elapsed: 172700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarMul (7900 ns)
    TCS: [33mTestCase_testVec2ScalarDiv[0m, time elapsed: 184400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarDiv (6000 ns)
    TCS: [33mTestCase_testVec2ScalarMod[0m, time elapsed: 360300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarMod (13000 ns)
    TCS: [33mTestCase_testVec2BoolLogicalOr[0m, time elapsed: 194700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BoolLogicalOr (6700 ns)
    TCS: [33mTestCase_testVec2EqualEpsilon[0m, time elapsed: 262100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2EqualEpsilon (28500 ns)
    TCS: [33mTestCase_testVec2DivNamed[0m, time elapsed: 901000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2DivNamed (207900 ns)
    TCS: [33mTestCase_testVec2ModNamed[0m, time elapsed: 298600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ModNamed (11700 ns)
    TCS: [33mTestCase_testVec2BitwiseOr[0m, time elapsed: 190100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseOr (12500 ns)
    TCS: [33mTestCase_testVec2BitwiseXor[0m, time elapsed: 199300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseXor (13200 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseAnd[0m, time elapsed: 194500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseAnd (10100 ns)
    TCS: [33mTestCase_testVec2ShiftRight[0m, time elapsed: 191800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRight (14500 ns)
    TCS: [33mTestCase_testVec2ShiftRightVec1[0m, time elapsed: 178300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRightVec1 (9800 ns)
    TCS: [33mTestCase_testVec2AddNamed[0m, time elapsed: 272700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2AddNamed (14500 ns)
    TCS: [33mTestCase_testVec2SubNamed[0m, time elapsed: 183000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2SubNamed (8400 ns)
    TCS: [33mTestCase_testVec2MulNamed[0m, time elapsed: 177000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2MulNamed (6600 ns)
    TCS: [33mTestCase_testVec2ShiftLeftVec[0m, time elapsed: 175000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeftVec (10600 ns)
    TCS: [33mTestCase_testVec2ShiftRightVec[0m, time elapsed: 173100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRightVec (6400 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseOr[0m, time elapsed: 178000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseOr (11000 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseXor[0m, time elapsed: 171700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseXor (10000 ns)
    TCS: [33mTestCase_testVec2Increment[0m, time elapsed: 184200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Increment (12500 ns)
    TCS: [33mTestCase_testVec2Decrement[0m, time elapsed: 178400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Decrement (9300 ns)
    TCS: [33mTestCase_testVec2IndexOutOfBoundsAccess[0m, time elapsed: 248100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2IndexOutOfBoundsAccess (66800 ns)
    TCS: [33mTestCase_testVec2NegativeIndexAccess[0m, time elapsed: 204700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2NegativeIndexAccess (27200 ns)
    TCS: [33mTestCase_testVec3ScalarInit[0m, time elapsed: 180700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarInit (10400 ns)
    TCS: [33mTestCase_testVec3ConstInit[0m, time elapsed: 177100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ConstInit (5700 ns)
    TCS: [33mTestCase_testVec3Length[0m, time elapsed: 172800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Length (6000 ns)
    TCS: [33mTestCase_testVec3Add[0m, time elapsed: 197000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Add (17300 ns)
    TCS: [33mTestCase_testVec3ScalarMul[0m, time elapsed: 188900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarMul (11100 ns)
    TCS: [33mTestCase_testVec3Negate[0m, time elapsed: 186700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Negate (9500 ns)
    TCS: [33mTestCase_testVec3IndexAccess[0m, time elapsed: 182000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3IndexAccess (6600 ns)
    TCS: [33mTestCase_testVec3IndexMutate[0m, time elapsed: 189600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3IndexMutate (9200 ns)
    TCS: [33mTestCase_testVec3ComponentAt[0m, time elapsed: 186600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ComponentAt (7000 ns)
    TCS: [33mTestCase_testVec3Equal[0m, time elapsed: 205000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Equal (17700 ns)
    TCS: [33mTestCase_testVec3NotEqual[0m, time elapsed: 205800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3NotEqual (11200 ns)
    TCS: [33mTestCase_testVec3EqualExact[0m, time elapsed: 214100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3EqualExact (12000 ns)
    TCS: [33mTestCase_testVec3BitwiseAnd[0m, time elapsed: 201000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseAnd (15200 ns)
    TCS: [33mTestCase_testVec3BitwiseNot[0m, time elapsed: 195300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseNot (7700 ns)
    TCS: [33mTestCase_testVec3Vec1ArithBroadcast[0m, time elapsed: 204200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1ArithBroadcast (17500 ns)
    TCS: [33mTestCase_testVec3ShiftLeft[0m, time elapsed: 234600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeft (13700 ns)
    TCS: [33mTestCase_testVec3BoolLogicalAnd[0m, time elapsed: 187500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BoolLogicalAnd (10600 ns)
    TCS: [33mTestCase_testVec3Sub[0m, time elapsed: 190300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Sub (11700 ns)
    TCS: [33mTestCase_testVec3Div[0m, time elapsed: 184400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Div (10500 ns)
    TCS: [33mTestCase_testVec3Mod[0m, time elapsed: 181500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Mod (10200 ns)
    TCS: [33mTestCase_testVec3ScalarSub[0m, time elapsed: 185400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarSub (13000 ns)
    TCS: [33mTestCase_testVec3ScalarDiv[0m, time elapsed: 188000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarDiv (9900 ns)
    TCS: [33mTestCase_testVec3ScalarMod[0m, time elapsed: 180300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarMod (9200 ns)
    TCS: [33mTestCase_testVec3BoolLogicalOr[0m, time elapsed: 178400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BoolLogicalOr (9100 ns)
    TCS: [33mTestCase_testVec3EqualEpsilon[0m, time elapsed: 197800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3EqualEpsilon (16000 ns)
    TCS: [33mTestCase_testVec3AddNamed[0m, time elapsed: 181200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3AddNamed (12900 ns)
    TCS: [33mTestCase_testVec3MulNamed[0m, time elapsed: 175100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3MulNamed (6600 ns)
    TCS: [33mTestCase_testVec3DivNamed[0m, time elapsed: 183900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3DivNamed (7200 ns)
    TCS: [33mTestCase_testVec3ModNamed[0m, time elapsed: 175100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ModNamed (6900 ns)
    TCS: [33mTestCase_testVec3BitwiseOr[0m, time elapsed: 183400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseOr (11900 ns)
    TCS: [33mTestCase_testVec3BitwiseXor[0m, time elapsed: 190800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseXor (10900 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseAnd[0m, time elapsed: 186400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseAnd (14700 ns)
    TCS: [33mTestCase_testVec3ShiftRight[0m, time elapsed: 195100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRight (9900 ns)
    TCS: [33mTestCase_testVec3Vec1BitBroadcast[0m, time elapsed: 182600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitBroadcast (9900 ns)
    TCS: [33mTestCase_testVec3ShiftRightVec1[0m, time elapsed: 262500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRightVec1 (15700 ns)
    TCS: [33mTestCase_testVec3FromVec1[0m, time elapsed: 185300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3FromVec1 (8200 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseOr[0m, time elapsed: 191700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseOr (14800 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseXor[0m, time elapsed: 179100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseXor (11400 ns)
    TCS: [33mTestCase_testVec3Vec1BitOrBroadcast[0m, time elapsed: 260000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitOrBroadcast (18200 ns)
    TCS: [33mTestCase_testVec3Vec1BitXorBroadcast[0m, time elapsed: 211200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitXorBroadcast (13300 ns)
    TCS: [33mTestCase_testVec3ShiftLeftVec1[0m, time elapsed: 285500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeftVec1 (16700 ns)
    TCS: [33mTestCase_testVec3ShiftLeftVec[0m, time elapsed: 307200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeftVec (16900 ns)
    TCS: [33mTestCase_testVec3ShiftRightVec[0m, time elapsed: 195400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRightVec (12000 ns)
    TCS: [33mTestCase_testVec3Increment[0m, time elapsed: 253100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Increment (24000 ns)
    TCS: [33mTestCase_testVec3Decrement[0m, time elapsed: 192700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Decrement (13900 ns)
    TCS: [33mTestCase_testVec3IndexOutOfBoundsAccess[0m, time elapsed: 232300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3IndexOutOfBoundsAccess (43300 ns)
    TCS: [33mTestCase_testVec3NegativeIndexAccess[0m, time elapsed: 195600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3NegativeIndexAccess (18900 ns)
    TCS: [33mTestCase_testVec4ScalarInit[0m, time elapsed: 184500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarInit (9900 ns)
    TCS: [33mTestCase_testVec4ConstInit[0m, time elapsed: 179000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ConstInit (6900 ns)
    TCS: [33mTestCase_testVec4Length[0m, time elapsed: 187400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Length (7300 ns)
    TCS: [33mTestCase_testVec4Add[0m, time elapsed: 180600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Add (16700 ns)
    TCS: [33mTestCase_testVec4ScalarMul[0m, time elapsed: 184000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarMul (12600 ns)
    TCS: [33mTestCase_testVec4Negate[0m, time elapsed: 185500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Negate (11300 ns)
    TCS: [33mTestCase_testVec4IndexAccess[0m, time elapsed: 175600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4IndexAccess (13000 ns)
    TCS: [33mTestCase_testVec4IndexMutate[0m, time elapsed: 173600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4IndexMutate (5900 ns)
    TCS: [33mTestCase_testVec4ComponentAt[0m, time elapsed: 179600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ComponentAt (7600 ns)
    TCS: [33mTestCase_testVec4Equal[0m, time elapsed: 192900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Equal (14100 ns)
    TCS: [33mTestCase_testVec4NotEqual[0m, time elapsed: 188700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4NotEqual (10400 ns)
    TCS: [33mTestCase_testVec4EqualExact[0m, time elapsed: 186800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4EqualExact (15100 ns)
    TCS: [33mTestCase_testVec4BitwiseAnd[0m, time elapsed: 245500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseAnd (30100 ns)
    TCS: [33mTestCase_testVec4BitwiseNot[0m, time elapsed: 193900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseNot (8100 ns)
    TCS: [33mTestCase_testVec4Vec1ArithBroadcast[0m, time elapsed: 195000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1ArithBroadcast (15100 ns)
    TCS: [33mTestCase_testVec4ShiftLeft[0m, time elapsed: 197100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeft (11700 ns)
    TCS: [33mTestCase_testVec4BoolLogicalAnd[0m, time elapsed: 205800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BoolLogicalAnd (12200 ns)
    TCS: [33mTestCase_testVec4Sub[0m, time elapsed: 186300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Sub (16100 ns)
    TCS: [33mTestCase_testVec4Div[0m, time elapsed: 182100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Div (10700 ns)
    TCS: [33mTestCase_testVec4Mod[0m, time elapsed: 256300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Mod (51500 ns)
    TCS: [33mTestCase_testVec4ScalarSub[0m, time elapsed: 185000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarSub (10600 ns)
    TCS: [33mTestCase_testVec4ScalarDiv[0m, time elapsed: 182400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarDiv (9900 ns)
    TCS: [33mTestCase_testVec4ScalarMod[0m, time elapsed: 180600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarMod (13200 ns)
    TCS: [33mTestCase_testVec4BoolLogicalOr[0m, time elapsed: 173900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BoolLogicalOr (6600 ns)
    TCS: [33mTestCase_testVec4EqualEpsilon[0m, time elapsed: 185100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4EqualEpsilon (17200 ns)
    TCS: [33mTestCase_testVec4AddNamed[0m, time elapsed: 183100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4AddNamed (11500 ns)
    TCS: [33mTestCase_testVec4MulNamed[0m, time elapsed: 190900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4MulNamed (7400 ns)
    TCS: [33mTestCase_testVec4DivNamed[0m, time elapsed: 191900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4DivNamed (6700 ns)
    TCS: [33mTestCase_testVec4ModNamed[0m, time elapsed: 194300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ModNamed (11200 ns)
    TCS: [33mTestCase_testVec4BitwiseOr[0m, time elapsed: 191200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseOr (12000 ns)
    TCS: [33mTestCase_testVec4BitwiseXor[0m, time elapsed: 183300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseXor (10400 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseAnd[0m, time elapsed: 190800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseAnd (11100 ns)
    TCS: [33mTestCase_testVec4ShiftRight[0m, time elapsed: 181300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRight (10200 ns)
    TCS: [33mTestCase_testVec4Vec1BitBroadcast[0m, time elapsed: 184000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitBroadcast (14800 ns)
    TCS: [33mTestCase_testVec4ShiftRightVec1[0m, time elapsed: 188400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRightVec1 (11400 ns)
    TCS: [33mTestCase_testVec4FromVec1[0m, time elapsed: 174200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4FromVec1 (6200 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseOr[0m, time elapsed: 177500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseOr (9100 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseXor[0m, time elapsed: 212100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseXor (12200 ns)
    TCS: [33mTestCase_testVec4Vec1BitOrBroadcast[0m, time elapsed: 191000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitOrBroadcast (13800 ns)
    TCS: [33mTestCase_testVec4Vec1BitXorBroadcast[0m, time elapsed: 190400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitXorBroadcast (10400 ns)
    TCS: [33mTestCase_testVec4ShiftLeftVec1[0m, time elapsed: 176500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeftVec1 (10000 ns)
    TCS: [33mTestCase_testVec4ShiftLeftVec[0m, time elapsed: 312000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeftVec (18400 ns)
    TCS: [33mTestCase_testVec4ShiftRightVec[0m, time elapsed: 274400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRightVec (15200 ns)
    TCS: [33mTestCase_testVec4Increment[0m, time elapsed: 280600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Increment (26300 ns)
    TCS: [33mTestCase_testVec4Decrement[0m, time elapsed: 271800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Decrement (19500 ns)
    TCS: [33mTestCase_testVec4IndexOutOfBoundsAccess[0m, time elapsed: 309000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4IndexOutOfBoundsAccess (53000 ns)
    TCS: [33mTestCase_testVec4NegativeIndexAccess[0m, time elapsed: 295000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4NegativeIndexAccess (23500 ns)
    TCS: [33mTestCase_testFunctor1Vec1Identity[0m, time elapsed: 355400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec1Identity (17500 ns)
    TCS: [33mTestCase_testFunctor1Vec1Transform[0m, time elapsed: 306200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec1Transform (20200 ns)
    TCS: [33mTestCase_testFunctor1Vec2Transform[0m, time elapsed: 295600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec2Transform (12600 ns)
    TCS: [33mTestCase_testFunctor2Vec1Add[0m, time elapsed: 201700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec1Add (9200 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec1Mul[0m, time elapsed: 217700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec1Mul (19800 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec1Shift[0m, time elapsed: 188300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec1Shift (10500 ns)
    TCS: [33mTestCase_testFunctor1Vec3Transform[0m, time elapsed: 188700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec3Transform (8300 ns)
    TCS: [33mTestCase_testFunctor1Vec4Transform[0m, time elapsed: 191600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec4Transform (8500 ns)
    TCS: [33mTestCase_testFunctor2Vec2Add[0m, time elapsed: 196400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec2Add (8600 ns)
    TCS: [33mTestCase_testFunctor2Vec3Add[0m, time elapsed: 183800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec3Add (7300 ns)
    TCS: [33mTestCase_testFunctor2Vec4Add[0m, time elapsed: 174500 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec4Add (7900 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec2Mul[0m, time elapsed: 212800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec2Mul (11100 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec3Mul[0m, time elapsed: 191900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec3Mul (12200 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec4Mul[0m, time elapsed: 188000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec4Mul (7600 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec2Shift[0m, time elapsed: 198900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec2Shift (10700 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec3Shift[0m, time elapsed: 193900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec3Shift (6700 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec4Shift[0m, time elapsed: 179500 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec4Shift (6700 ns)
Summary: TOTAL: 435
    [32mPASSED[0m: 435, [32mSKIPPED[0m: 0, ERROR: 0
    [31mFAILED[0m: 0
--------------------------------------------------------------------------------------------------
Project tests finished, time elapsed: 160326000 ns, RESULT:
TP: [33mglm[0m.*, time elapsed: 160264900 ns, RESULT:
    PASSED:
    TP: [33mglm.detail[0m, time elapsed: 144864700 ns
Summary: TOTAL: 435
    [32mPASSED[0m: 435, [32mSKIPPED[0m: 0, ERROR: 0
    [31mFAILED[0m: 0
--------------------------------------------------------------------------------------------------
[0J7[;r8[?25hcjpm test success
