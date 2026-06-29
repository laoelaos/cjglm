# 验证报告（v3）

## 结果
PASSED

## 统计
- 通过：422
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

warning[0m: unused variable:'two'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_quat_cast.cj:54:9:
   | 
54 |     let two: T = (Float64(2.0) as T).getOrThrow()
   |         ^^^ unused variable
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:149:58:
    | 
149 |     public static func fromMat<SrcQ>(m: Mat2x3<T, SrcQ>, one: T): Mat2x4<T, Q>
    |                                                          ^^^ unused variable
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:155:58:
    | 
155 |     public static func fromMat<SrcQ>(m: Mat2x2<T, SrcQ>, one: T): Mat4x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:161:58:
    | 
161 |     public static func fromMat<SrcQ>(m: Mat2x4<T, SrcQ>, one: T): Mat3x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:167:58:
    | 
167 |     public static func fromMat<SrcQ>(m: Mat2x4<T, SrcQ>, one: T): Mat4x2<T, Q>
    |                                                          ^^^ unused variable
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:172:58:
    | 
172 |     public static func fromMat<SrcQ>(m: Mat4x2<T, SrcQ>, one: T): Mat2x4<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:172:58:
    | 
172 |     public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat3x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:173:58:
    | 
173 |     public static func fromMat<SrcQ>(m: Mat4x2<T, SrcQ>, one: T): Mat2x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:176:58:
    | 
176 |     public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat3x3<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x3.cj:179:58:
    | 
179 |     public static func fromMat<SrcQ>(m: Mat3x3<T, SrcQ>, one: T): Mat4x3<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:187:58:
    | 
187 |     public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat3x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:207:71:
    | 
207 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat3x3<U, P>, one: T): Mat2x3<T, Q>
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

238 warnings generated, 238 warnings printed.
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

warning[0m: imported decl 'Mat2x2' is shadowed, it will be ignored by compiler
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:7:28:
  | 
7 | public import glm.detail.{ Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4 }
  |                            ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: 'Mat2x2' is declared here
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:327:13:
    | 
327 | public type Mat2x2 = detail.Mat2x2<Float32, detail.PackedHighp>
    |             ^^^^^^ 
    | 

warning[0m: imported decl 'Mat2x3' is shadowed, it will be ignored by compiler
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:7:36:
  | 
7 | public import glm.detail.{ Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4 }
  |                                    ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: 'Mat2x3' is declared here
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:328:13:
    | 
328 | public type Mat2x3 = detail.Mat2x3<Float32, detail.PackedHighp>
    |             ^^^^^^ 
    | 

warning[0m: imported decl 'Mat2x4' is shadowed, it will be ignored by compiler
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:7:44:
  | 
7 | public import glm.detail.{ Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4 }
  |                                            ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: 'Mat2x4' is declared here
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:329:13:
    | 
329 | public type Mat2x4 = detail.Mat2x4<Float32, detail.PackedHighp>
    |             ^^^^^^ 
    | 

warning[0m: imported decl 'Mat3x2' is shadowed, it will be ignored by compiler
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:7:52:
  | 
7 | public import glm.detail.{ Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4 }
  |                                                    ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: 'Mat3x2' is declared here
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:330:13:
    | 
330 | public type Mat3x2 = detail.Mat3x2<Float32, detail.PackedHighp>
    |             ^^^^^^ 
    | 

warning[0m: imported decl 'Mat3x3' is shadowed, it will be ignored by compiler
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:7:60:
  | 
7 | public import glm.detail.{ Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4 }
  |                                                            ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: 'Mat3x3' is declared here
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:331:13:
    | 
331 | public type Mat3x3 = detail.Mat3x3<Float32, detail.PackedHighp>
    |             ^^^^^^ 
    | 

warning[0m: imported decl 'Mat3x4' is shadowed, it will be ignored by compiler
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:7:68:
  | 
7 | public import glm.detail.{ Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4 }
  |                                                                    ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: 'Mat3x4' is declared here
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:332:13:
    | 
332 | public type Mat3x4 = detail.Mat3x4<Float32, detail.PackedHighp>
    |             ^^^^^^ 
    | 

warning[0m: imported decl 'Mat4x2' is shadowed, it will be ignored by compiler
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:7:76:
  | 
7 | public import glm.detail.{ Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4 }
  |                                                                            ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: 'Mat4x2' is declared here
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:333:13:
    | 
333 | public type Mat4x2 = detail.Mat4x2<Float32, detail.PackedHighp>
    |             ^^^^^^ 
    | 

warning[0m: imported decl 'Mat4x3' is shadowed, it will be ignored by compiler
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:7:84:
  | 
7 | public import glm.detail.{ Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4 }
  |                                                                                    ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: 'Mat4x3' is declared here
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:334:13:
    | 
334 | public type Mat4x3 = detail.Mat4x3<Float32, detail.PackedHighp>
    |             ^^^^^^ 
    | 

warning[0m: imported decl 'Mat4x4' is shadowed, it will be ignored by compiler
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:7:92:
  | 
7 | public import glm.detail.{ Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4 }
  |                                                                                            ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: 'Mat4x4' is declared here
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:335:13:
    | 
335 | public type Mat4x4 = detail.Mat4x4<Float32, detail.PackedHighp>
    |             ^^^^^^ 
    | 

13 warnings generated, 13 warnings printed.
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
40 | public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T, spin: Bool): Quat<T, Q>
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_common.cj:40:40:
   | 
40 | public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T, spin: Bool): Quat<T, Q>
   |                                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'a'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_common.cj:40:55:
   | 
40 | public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T, spin: Bool): Quat<T, Q>
   |                                                       ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'spin'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_common.cj:40:61:
   | 
40 | public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T, spin: Bool): Quat<T, Q>
   |                                                             ^^^^ unused variable
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
error[0m: expected expression after '(', found keyword 'Bool'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd_test.cj:17:26:
   | 
17 |     let b: BVec2 = BVec2(Bool(true), Bool(true))
   |                          ^^^^ expected expression here
   | 

error[0m: expected expression after '(', found keyword 'Bool'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd_test.cj:60:26:
   | 
60 |     let v: BVec1 = BVec1(Bool(true))
   |                          ^^^^ expected expression here
   | 

error[0m: expected expression after '(', found keyword 'Bool'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd_test.cj:66:26:
   | 
66 |     let v: BVec3 = BVec3(Bool(true), Bool(false), Bool(true))
   |                          ^^^^ expected expression here
   | 

error[0m: expected expression after '(', found keyword 'Bool'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd_test.cj:72:26:
   | 
72 |     let v: BVec4 = BVec4(Bool(true), Bool(false), Bool(true), Bool(false))
   |                          ^^^^ expected expression here
   | 

error[0m: expected expression after '(', found keyword 'Bool'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd_test.cj:222:76:
    | 
222 |     let v: detail.Vec3<Bool, PackedHighp> = detail.Vec3<Bool, PackedHighp>(Bool(true), Bool(false), Bool(true))
    |                                                                            ^^^^ expected expression here
    | 

5 errors generated, 5 errors printed.
[?25l[0J7[;r8
[1F7[9999E8--------------------------------------------------------------------------------------------------
TP: [33mglm.detail[0m, time elapsed: 160268300 ns, RESULT:
    TCS: [33mTestCase_testComputeVecAdd1[0m, time elapsed: 1296200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAdd1 (228800 ns)
    TCS: [33mTestCase_testComputeVecSub2[0m, time elapsed: 263600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub2 (30200 ns)
    TCS: [33mTestCase_testComputeVecMul3[0m, time elapsed: 268900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul3 (27600 ns)
    TCS: [33mTestCase_testComputeVecMod1[0m, time elapsed: 258300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMod1 (23800 ns)
    TCS: [33mTestCase_testComputeVecMod4[0m, time elapsed: 249500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMod4 (22300 ns)
    TCS: [33mTestCase_testComputeVecAnd1[0m, time elapsed: 250200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAnd1 (22100 ns)
    TCS: [33mTestCase_testComputeVecAnd3[0m, time elapsed: 243300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAnd3 (17600 ns)
    TCS: [33mTestCase_testComputeVecOr1[0m, time elapsed: 244400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecOr1 (18000 ns)
    TCS: [33mTestCase_testComputeVecOr2[0m, time elapsed: 243100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecOr2 (15900 ns)
    TCS: [33mTestCase_testComputeVecXor1[0m, time elapsed: 245600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecXor1 (19500 ns)
    TCS: [33mTestCase_testComputeVecXor4[0m, time elapsed: 249900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecXor4 (22100 ns)
    TCS: [33mTestCase_testComputeVecShiftLeft1[0m, time elapsed: 255200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftLeft1 (14800 ns)
    TCS: [33mTestCase_testComputeVecShiftLeft3[0m, time elapsed: 239100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftLeft3 (13400 ns)
    TCS: [33mTestCase_testComputeVecShiftRight1[0m, time elapsed: 238400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftRight1 (12500 ns)
    TCS: [33mTestCase_testComputeVecShiftRight4[0m, time elapsed: 243100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftRight4 (18600 ns)
    TCS: [33mTestCase_testComputeVecEqual1[0m, time elapsed: 236300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual1 (15400 ns)
    TCS: [33mTestCase_testComputeVecNequal4[0m, time elapsed: 258100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal4 (14900 ns)
    TCS: [33mTestCase_testComputeVecBitwiseNot1[0m, time elapsed: 320700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecBitwiseNot1 (21100 ns)
    TCS: [33mTestCase_testComputeVecBitwiseNot3[0m, time elapsed: 256400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecBitwiseNot3 (21300 ns)
    TCS: [33mTestCase_testComputeVecAdd4[0m, time elapsed: 245400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAdd4 (20800 ns)
    TCS: [33mTestCase_testComputeVecSub1[0m, time elapsed: 1349300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub1 (18600 ns)
    TCS: [33mTestCase_testComputeVecSub3[0m, time elapsed: 404500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub3 (33200 ns)
    TCS: [33mTestCase_testComputeVecMul1[0m, time elapsed: 240700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul1 (36500 ns)
    TCS: [33mTestCase_testComputeVecMul2[0m, time elapsed: 218200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul2 (16600 ns)
    TCS: [33mTestCase_testComputeVecDiv1[0m, time elapsed: 206800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecDiv1 (14300 ns)
    TCS: [33mTestCase_testComputeVecDiv2[0m, time elapsed: 222800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecDiv2 (19600 ns)
    TCS: [33mTestCase_testComputeVecDiv4[0m, time elapsed: 208300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecDiv4 (15800 ns)
    TCS: [33mTestCase_testComputeVecEqual2[0m, time elapsed: 208500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual2 (11700 ns)
    TCS: [33mTestCase_testComputeVecEqual3[0m, time elapsed: 202600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual3 (15500 ns)
    TCS: [33mTestCase_testComputeVecEqual4[0m, time elapsed: 246700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual4 (15700 ns)
    TCS: [33mTestCase_testComputeVecNequal1[0m, time elapsed: 243200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal1 (19500 ns)
    TCS: [33mTestCase_testComputeVecNequal2[0m, time elapsed: 250700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal2 (11100 ns)
    TCS: [33mTestCase_testComputeVecBitwiseNot4[0m, time elapsed: 253500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecBitwiseNot4 (25800 ns)
    TCS: [33mTestCase_testComputeVecAddFloat32[0m, time elapsed: 321300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAddFloat32 (54600 ns)
    TCS: [33mTestCase_testComputeVecAddFloat32Vec3[0m, time elapsed: 775100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAddFloat32Vec3 (73700 ns)
    TCS: [33mTestCase_testComputeVecSubFloat32[0m, time elapsed: 277200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSubFloat32 (26300 ns)
    TCS: [33mTestCase_testComputeVecSubFloat32Vec4[0m, time elapsed: 228200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSubFloat32Vec4 (29800 ns)
    TCS: [33mTestCase_testComputeEqualInt32Equal[0m, time elapsed: 211200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt32Equal (15200 ns)
    TCS: [33mTestCase_testComputeEqualInt32NotEqual[0m, time elapsed: 196400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt32NotEqual (10500 ns)
    TCS: [33mTestCase_testComputeEqualFloat32Equal[0m, time elapsed: 211700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32Equal (9400 ns)
    TCS: [33mTestCase_testComputeEqualFloat32NotEqual[0m, time elapsed: 194500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32NotEqual (8200 ns)
    TCS: [33mTestCase_testComputeEqualFloat64Equal[0m, time elapsed: 228000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64Equal (18000 ns)
    TCS: [33mTestCase_testComputeEqualFloat64NotEqual[0m, time elapsed: 203600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64NotEqual (10700 ns)
    TCS: [33mTestCase_testComputeEqualBoolEqual[0m, time elapsed: 203800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualBoolEqual (9400 ns)
    TCS: [33mTestCase_testComputeEqualBoolNotEqual[0m, time elapsed: 192700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualBoolNotEqual (13100 ns)
    TCS: [33mTestCase_testComputeEqualNumericInt32[0m, time elapsed: 210500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericInt32 (12200 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32[0m, time elapsed: 250900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32 (41000 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32Epsilon[0m, time elapsed: 204300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32Epsilon (16200 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64[0m, time elapsed: 203400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64 (13800 ns)
    TCS: [33mTestCase_testComputeEqualInt64Equal[0m, time elapsed: 196700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt64Equal (13500 ns)
    TCS: [33mTestCase_testComputeEqualInt64NotEqual[0m, time elapsed: 199000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt64NotEqual (9900 ns)
    TCS: [33mTestCase_testComputeEqualFloat32Nan[0m, time elapsed: 212100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32Nan (11600 ns)
    TCS: [33mTestCase_testComputeEqualFloat64Nan[0m, time elapsed: 240300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64Nan (14100 ns)
    TCS: [33mTestCase_testComputeEqualFloat32SignedZero[0m, time elapsed: 221500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32SignedZero (10000 ns)
    TCS: [33mTestCase_testComputeEqualFloat64SignedZero[0m, time elapsed: 214100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64SignedZero (10400 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32NotEqual[0m, time elapsed: 247500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32NotEqual (14700 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32BeyondEpsilon[0m, time elapsed: 214700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32BeyondEpsilon (11400 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64NotEqual[0m, time elapsed: 220000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64NotEqual (17900 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64Epsilon[0m, time elapsed: 232200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64Epsilon (11800 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64BeyondEpsilon[0m, time elapsed: 484900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64BeyondEpsilon (26600 ns)
    TCS: [33mTestCase_testComputeEqualNumericInt64[0m, time elapsed: 357600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericInt64 (18600 ns)
    TCS: [33mTestCase_testPackedHighpImplementsQualifier[0m, time elapsed: 327000 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedHighpImplementsQualifier (16900 ns)
    TCS: [33mTestCase_testPackedMediumpImplementsQualifier[0m, time elapsed: 232400 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedMediumpImplementsQualifier (12900 ns)
    TCS: [33mTestCase_testPackedLowpImplementsQualifier[0m, time elapsed: 213900 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedLowpImplementsQualifier (13200 ns)
    TCS: [33mTestCase_testDefaultpIsPackedHighp[0m, time elapsed: 215000 ns, RESULT:
    [[32m PASSED [0m] CASE: testDefaultpIsPackedHighp (12900 ns)
    TCS: [33mTestCase_testScalarAddVec1[0m, time elapsed: 223000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec1 (17000 ns)
    TCS: [33mTestCase_testScalarAddVec2[0m, time elapsed: 222800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec2 (14700 ns)
    TCS: [33mTestCase_testScalarAddVec3[0m, time elapsed: 238100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec3 (10000 ns)
    TCS: [33mTestCase_testScalarAddVec4[0m, time elapsed: 235200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec4 (25400 ns)
    TCS: [33mTestCase_testScalarSubVec1[0m, time elapsed: 217900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1 (16000 ns)
    TCS: [33mTestCase_testScalarMulVec1[0m, time elapsed: 216900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1 (16300 ns)
    TCS: [33mTestCase_testScalarDivVec1[0m, time elapsed: 216800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1 (20700 ns)
    TCS: [33mTestCase_testScalarModVec1[0m, time elapsed: 209400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1 (14800 ns)
    TCS: [33mTestCase_testScalarMulVec2[0m, time elapsed: 207400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2 (9900 ns)
    TCS: [33mTestCase_testScalarSubVec2[0m, time elapsed: 219900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2 (15200 ns)
    TCS: [33mTestCase_testScalarSubVec3[0m, time elapsed: 228500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3 (21200 ns)
    TCS: [33mTestCase_testScalarSubVec4[0m, time elapsed: 351900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4 (16600 ns)
    TCS: [33mTestCase_testScalarMulVec3[0m, time elapsed: 366100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3 (30200 ns)
    TCS: [33mTestCase_testScalarMulVec4[0m, time elapsed: 345600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4 (25000 ns)
    TCS: [33mTestCase_testScalarDivVec2[0m, time elapsed: 359400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2 (33400 ns)
    TCS: [33mTestCase_testScalarDivVec3[0m, time elapsed: 260300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3 (24600 ns)
    TCS: [33mTestCase_testScalarDivVec4[0m, time elapsed: 236900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4 (18800 ns)
    TCS: [33mTestCase_testScalarModVec2[0m, time elapsed: 249300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2 (20200 ns)
    TCS: [33mTestCase_testScalarModVec3[0m, time elapsed: 222400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3 (11000 ns)
    TCS: [33mTestCase_testScalarModVec4[0m, time elapsed: 205900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4 (14200 ns)
    TCS: [33mTestCase_testScalarModVec1Float32[0m, time elapsed: 236100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float32 (29700 ns)
    TCS: [33mTestCase_testScalarModVec2Float32[0m, time elapsed: 208300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32 (16000 ns)
    TCS: [33mTestCase_testScalarModVec3Float32[0m, time elapsed: 218800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float32 (15100 ns)
    TCS: [33mTestCase_testScalarModVec4Float32[0m, time elapsed: 334400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float32 (15900 ns)
    TCS: [33mTestCase_testScalarModVec1Float64[0m, time elapsed: 415800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float64 (21700 ns)
    TCS: [33mTestCase_testScalarModVec2Float64[0m, time elapsed: 345500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float64 (26300 ns)
    TCS: [33mTestCase_testScalarModVec3Float64[0m, time elapsed: 359100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float64 (17900 ns)
    TCS: [33mTestCase_testScalarModVec4Float64[0m, time elapsed: 369300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float64 (29600 ns)
    TCS: [33mTestCase_testScalarModVec1Float16[0m, time elapsed: 795300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float16 (56300 ns)
    TCS: [33mTestCase_testScalarModVec2Float16[0m, time elapsed: 229800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float16 (10800 ns)
    TCS: [33mTestCase_testScalarModVec3Float16[0m, time elapsed: 221000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float16 (12400 ns)
    TCS: [33mTestCase_testScalarModVec4Float16[0m, time elapsed: 221500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float16 (19500 ns)
    TCS: [33mTestCase_testScalarSubVec2PackedMediump[0m, time elapsed: 454000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2PackedMediump (38200 ns)
    TCS: [33mTestCase_testScalarSubVec2PackedLowp[0m, time elapsed: 362400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2PackedLowp (21600 ns)
    TCS: [33mTestCase_testScalarMulVec2PackedMediump[0m, time elapsed: 262800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2PackedMediump (13100 ns)
    TCS: [33mTestCase_testScalarMulVec2PackedLowp[0m, time elapsed: 220100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2PackedLowp (12400 ns)
    TCS: [33mTestCase_testScalarDivVec2PackedMediump[0m, time elapsed: 238700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2PackedMediump (20200 ns)
    TCS: [33mTestCase_testScalarDivVec2PackedLowp[0m, time elapsed: 225700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2PackedLowp (15900 ns)
    TCS: [33mTestCase_testScalarModVec2PackedMediump[0m, time elapsed: 216200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2PackedMediump (10300 ns)
    TCS: [33mTestCase_testScalarModVec2PackedLowp[0m, time elapsed: 217200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2PackedLowp (9500 ns)
    TCS: [33mTestCase_testScalarModVec2Float32PackedMediump[0m, time elapsed: 221900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32PackedMediump (11800 ns)
    TCS: [33mTestCase_testScalarModVec2Float32PackedLowp[0m, time elapsed: 228100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32PackedLowp (11100 ns)
    TCS: [33mTestCase_testScalarModVec2Float32NegativeDividend[0m, time elapsed: 244900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32NegativeDividend (11500 ns)
    TCS: [33mTestCase_testScalarModVec2Float32NegativeDivisor[0m, time elapsed: 218700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32NegativeDivisor (8900 ns)
    TCS: [33mTestCase_testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents[0m, time elapsed: 399600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents (180800 ns)
    TCS: [33mTestCase_testScalarAddVec1Float32[0m, time elapsed: 220900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec1Float32 (18400 ns)
    TCS: [33mTestCase_testScalarAddVec2Float32[0m, time elapsed: 208400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec2Float32 (10500 ns)
    TCS: [33mTestCase_testScalarAddVec3Float32[0m, time elapsed: 339900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec3Float32 (26600 ns)
    TCS: [33mTestCase_testScalarAddVec4Float32[0m, time elapsed: 206700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec4Float32 (13100 ns)
    TCS: [33mTestCase_testScalarSubVec1Float32[0m, time elapsed: 208400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1Float32 (16700 ns)
    TCS: [33mTestCase_testScalarSubVec2Float32[0m, time elapsed: 199500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2Float32 (9200 ns)
    TCS: [33mTestCase_testScalarSubVec3Float32[0m, time elapsed: 206100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3Float32 (12100 ns)
    TCS: [33mTestCase_testScalarSubVec4Float32[0m, time elapsed: 208300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4Float32 (13700 ns)
    TCS: [33mTestCase_testScalarMulVec1Float32[0m, time elapsed: 195000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1Float32 (9500 ns)
    TCS: [33mTestCase_testScalarMulVec2Float32[0m, time elapsed: 237200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2Float32 (18600 ns)
    TCS: [33mTestCase_testScalarMulVec3Float32[0m, time elapsed: 207300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3Float32 (13100 ns)
    TCS: [33mTestCase_testScalarMulVec4Float32[0m, time elapsed: 230000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4Float32 (13000 ns)
    TCS: [33mTestCase_testScalarDivVec1Float32[0m, time elapsed: 230200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1Float32 (17400 ns)
    TCS: [33mTestCase_testScalarDivVec2Float32[0m, time elapsed: 234900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2Float32 (13100 ns)
    TCS: [33mTestCase_testScalarDivVec3Float32[0m, time elapsed: 214100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3Float32 (11800 ns)
    TCS: [33mTestCase_testScalarDivVec4Float32[0m, time elapsed: 254500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4Float32 (11900 ns)
    TCS: [33mTestCase_testScalarAddVec1Int32[0m, time elapsed: 228300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec1Int32 (20800 ns)
    TCS: [33mTestCase_testScalarAddVec2Int32[0m, time elapsed: 216300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec2Int32 (11400 ns)
    TCS: [33mTestCase_testScalarAddVec3Int32[0m, time elapsed: 216500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec3Int32 (10400 ns)
    TCS: [33mTestCase_testScalarAddVec4Int32[0m, time elapsed: 218400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec4Int32 (10800 ns)
    TCS: [33mTestCase_testScalarSubVec1Int32[0m, time elapsed: 224300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1Int32 (15900 ns)
    TCS: [33mTestCase_testScalarSubVec2Int32[0m, time elapsed: 239700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2Int32 (12200 ns)
    TCS: [33mTestCase_testScalarSubVec3Int32[0m, time elapsed: 236100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3Int32 (17800 ns)
    TCS: [33mTestCase_testScalarSubVec4Int32[0m, time elapsed: 232600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4Int32 (11300 ns)
    TCS: [33mTestCase_testScalarMulVec1Int32[0m, time elapsed: 231100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1Int32 (14500 ns)
    TCS: [33mTestCase_testScalarMulVec2Int32[0m, time elapsed: 222100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2Int32 (11600 ns)
    TCS: [33mTestCase_testScalarMulVec3Int32[0m, time elapsed: 254200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3Int32 (10000 ns)
    TCS: [33mTestCase_testScalarMulVec4Int32[0m, time elapsed: 364800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4Int32 (12600 ns)
    TCS: [33mTestCase_testScalarDivVec1Int32[0m, time elapsed: 276400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1Int32 (18200 ns)
    TCS: [33mTestCase_testScalarDivVec2Int32[0m, time elapsed: 236200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2Int32 (18300 ns)
    TCS: [33mTestCase_testScalarDivVec3Int32[0m, time elapsed: 221200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3Int32 (12100 ns)
    TCS: [33mTestCase_testScalarDivVec4Int32[0m, time elapsed: 229100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4Int32 (13400 ns)
    TCS: [33mTestCase_testScalarModVec1Int32[0m, time elapsed: 232300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Int32 (12100 ns)
    TCS: [33mTestCase_testScalarModVec2Int32[0m, time elapsed: 216900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Int32 (10400 ns)
    TCS: [33mTestCase_testScalarModVec3Int32[0m, time elapsed: 207700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Int32 (9500 ns)
    TCS: [33mTestCase_testScalarModVec4Int32[0m, time elapsed: 212200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Int32 (15000 ns)
    TCS: [33mTestCase_testScalarSubVec1PackedMediump[0m, time elapsed: 205800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1PackedMediump (12500 ns)
    TCS: [33mTestCase_testScalarSubVec1PackedLowp[0m, time elapsed: 193700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1PackedLowp (9500 ns)
    TCS: [33mTestCase_testScalarSubVec3PackedMediump[0m, time elapsed: 209600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3PackedMediump (11200 ns)
    TCS: [33mTestCase_testScalarSubVec3PackedLowp[0m, time elapsed: 359100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3PackedLowp (13600 ns)
    TCS: [33mTestCase_testScalarSubVec4PackedMediump[0m, time elapsed: 353500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4PackedMediump (16100 ns)
    TCS: [33mTestCase_testScalarSubVec4PackedLowp[0m, time elapsed: 427400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4PackedLowp (15700 ns)
    TCS: [33mTestCase_testScalarMulVec1PackedMediump[0m, time elapsed: 205300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1PackedMediump (9800 ns)
    TCS: [33mTestCase_testScalarMulVec1PackedLowp[0m, time elapsed: 195000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1PackedLowp (10500 ns)
    TCS: [33mTestCase_testScalarMulVec3PackedMediump[0m, time elapsed: 195700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3PackedMediump (10600 ns)
    TCS: [33mTestCase_testScalarMulVec3PackedLowp[0m, time elapsed: 219100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3PackedLowp (14500 ns)
    TCS: [33mTestCase_testScalarMulVec4PackedMediump[0m, time elapsed: 199500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4PackedMediump (10700 ns)
    TCS: [33mTestCase_testScalarMulVec4PackedLowp[0m, time elapsed: 208700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4PackedLowp (9800 ns)
    TCS: [33mTestCase_testScalarDivVec1PackedMediump[0m, time elapsed: 190100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1PackedMediump (9800 ns)
    TCS: [33mTestCase_testScalarDivVec1PackedLowp[0m, time elapsed: 256800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1PackedLowp (10300 ns)
    TCS: [33mTestCase_testScalarDivVec3PackedMediump[0m, time elapsed: 537400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3PackedMediump (36400 ns)
    TCS: [33mTestCase_testScalarDivVec3PackedLowp[0m, time elapsed: 352900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3PackedLowp (26100 ns)
    TCS: [33mTestCase_testScalarDivVec4PackedMediump[0m, time elapsed: 194700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4PackedMediump (10800 ns)
    TCS: [33mTestCase_testScalarDivVec4PackedLowp[0m, time elapsed: 186800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4PackedLowp (9900 ns)
    TCS: [33mTestCase_testScalarModVec1PackedMediump[0m, time elapsed: 194900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1PackedMediump (11800 ns)
    TCS: [33mTestCase_testScalarModVec1PackedLowp[0m, time elapsed: 221100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1PackedLowp (12000 ns)
    TCS: [33mTestCase_testScalarModVec3PackedMediump[0m, time elapsed: 202900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3PackedMediump (13800 ns)
    TCS: [33mTestCase_testScalarModVec3PackedLowp[0m, time elapsed: 202300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3PackedLowp (11200 ns)
    TCS: [33mTestCase_testScalarModVec4PackedMediump[0m, time elapsed: 203300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4PackedMediump (12100 ns)
    TCS: [33mTestCase_testScalarModVec4PackedLowp[0m, time elapsed: 250500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4PackedLowp (14500 ns)
    TCS: [33mTestCase_testScalarDivZeroVec1[0m, time elapsed: 234000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivZeroVec1 (18500 ns)
    TCS: [33mTestCase_testScalarAddNegVec1[0m, time elapsed: 278200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddNegVec1 (14500 ns)
    TCS: [33mTestCase_testScalarAddNegVec2[0m, time elapsed: 219500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddNegVec2 (21500 ns)
    TCS: [33mTestCase_testScalarMulOverflowVec1[0m, time elapsed: 212100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulOverflowVec1 (13000 ns)
    TCS: [33mTestCase_testScalarSubNegVec1[0m, time elapsed: 204400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubNegVec1 (9300 ns)
    TCS: [33mTestCase_testVersionMajor[0m, time elapsed: 204000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionMajor (9500 ns)
    TCS: [33mTestCase_testVersionMinor[0m, time elapsed: 198400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionMinor (7700 ns)
    TCS: [33mTestCase_testVersionPatch[0m, time elapsed: 293600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionPatch (13000 ns)
    TCS: [33mTestCase_testVersionEncoded[0m, time elapsed: 242900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionEncoded (14800 ns)
    TCS: [33mTestCase_testConfigSimd[0m, time elapsed: 298800 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigSimd (17600 ns)
    TCS: [33mTestCase_testConfigAlignedGentypes[0m, time elapsed: 223900 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigAlignedGentypes (12000 ns)
    TCS: [33mTestCase_testConfigClipControl[0m, time elapsed: 216900 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigClipControl (10600 ns)
    TCS: [33mTestCase_testConstNegationSimd[0m, time elapsed: 359000 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationSimd (14000 ns)
    TCS: [33mTestCase_testConstNegationAligned[0m, time elapsed: 409400 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationAligned (35500 ns)
    TCS: [33mTestCase_testConstNegationClip[0m, time elapsed: 302800 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationClip (15700 ns)
    TCS: [33mTestCase_testConstInt64Usage[0m, time elapsed: 283300 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstInt64Usage (15600 ns)
    TCS: [33mTestCase_testConstBoolUsage[0m, time elapsed: 337500 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstBoolUsage (20200 ns)
    TCS: [33mTestCase_testVersionEncodingConsistency[0m, time elapsed: 318200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionEncodingConsistency (12700 ns)
    TCS: [33mTestCase_testAssertPasses[0m, time elapsed: 464400 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertPasses (54800 ns)
    TCS: [33mTestCase_testAssertFails[0m, time elapsed: 454400 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertFails (101000 ns)
    TCS: [33mTestCase_testAssertWithCustomMessage[0m, time elapsed: 539800 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertWithCustomMessage (126400 ns)
    TCS: [33mTestCase_testNumericLimitsFloat32Epsilon[0m, time elapsed: 471100 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsFloat32Epsilon (35800 ns)
    TCS: [33mTestCase_testNumericLimitsFloat64Epsilon[0m, time elapsed: 352400 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsFloat64Epsilon (21800 ns)
    TCS: [33mTestCase_testIsIec559OfFloat32[0m, time elapsed: 385600 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfFloat32 (18400 ns)
    TCS: [33mTestCase_testIsIec559OfFloat64[0m, time elapsed: 440500 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfFloat64 (36300 ns)
    TCS: [33mTestCase_testIsIec559OfInt64[0m, time elapsed: 318700 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfInt64 (21300 ns)
    TCS: [33mTestCase_testEpsilonOfFloat32[0m, time elapsed: 337000 ns, RESULT:
    [[32m PASSED [0m] CASE: testEpsilonOfFloat32 (20900 ns)
    TCS: [33mTestCase_testEpsilonOfFloat64[0m, time elapsed: 489400 ns, RESULT:
    [[32m PASSED [0m] CASE: testEpsilonOfFloat64 (28400 ns)
    TCS: [33mTestCase_testNumericLimitsInt64Epsilon[0m, time elapsed: 330100 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt64Epsilon (20400 ns)
    TCS: [33mTestCase_testNumericLimitsInt32Epsilon[0m, time elapsed: 359100 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt32Epsilon (31600 ns)
    TCS: [33mTestCase_testNumericLimitsInt16Epsilon[0m, time elapsed: 463900 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt16Epsilon (29100 ns)
    TCS: [33mTestCase_testNumericLimitsInt8Epsilon[0m, time elapsed: 350700 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt8Epsilon (21500 ns)
    TCS: [33mTestCase_testCastVec1ToVec1IntToFloat[0m, time elapsed: 358400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec1ToVec1IntToFloat (28200 ns)
    TCS: [33mTestCase_testCastVec2ToVec1TakesOnlyX[0m, time elapsed: 490300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2ToVec1TakesOnlyX (37500 ns)
    TCS: [33mTestCase_testCastVec3ToVec1TakesOnlyX[0m, time elapsed: 492300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3ToVec1TakesOnlyX (36300 ns)
    TCS: [33mTestCase_testCastVec4ToVec1TakesOnlyX[0m, time elapsed: 295500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4ToVec1TakesOnlyX (26700 ns)
    TCS: [33mTestCase_testCastSameTypeIdentity[0m, time elapsed: 303400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastSameTypeIdentity (19600 ns)
    TCS: [33mTestCase_testCastInt32ToInt64[0m, time elapsed: 313600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastInt32ToInt64 (24100 ns)
    TCS: [33mTestCase_testCastFloatToIntTruncation[0m, time elapsed: 593500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastFloatToIntTruncation (46700 ns)
    TCS: [33mTestCase_testCastCrossQualifierPackedHighpToDefaultp[0m, time elapsed: 344900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastCrossQualifierPackedHighpToDefaultp (30600 ns)
    TCS: [33mTestCase_testCastCrossQualifierDefaultpToPackedHighp[0m, time elapsed: 375600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastCrossQualifierDefaultpToPackedHighp (40300 ns)
    TCS: [33mTestCase_testCastVec2CrossQualifierCrossType[0m, time elapsed: 360000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2CrossQualifierCrossType (44900 ns)
    TCS: [33mTestCase_testCastVec3CrossQualifier[0m, time elapsed: 325000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3CrossQualifier (30700 ns)
    TCS: [33mTestCase_testCastVec4CrossQualifier[0m, time elapsed: 324400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4CrossQualifier (28400 ns)
    TCS: [33mTestCase_testCastVec1DoesNotModifySource[0m, time elapsed: 490900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec1DoesNotModifySource (46000 ns)
    TCS: [33mTestCase_testCastVec2Vec1ToVec2IntToFloat[0m, time elapsed: 295100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec1ToVec2IntToFloat (14600 ns)
    TCS: [33mTestCase_testCastVec2Vec2ToVec2Identity[0m, time elapsed: 323700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec2ToVec2Identity (29900 ns)
    TCS: [33mTestCase_testCastVec2Vec3ToVec2TakesOnlyXY[0m, time elapsed: 248400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec3ToVec2TakesOnlyXY (13200 ns)
    TCS: [33mTestCase_testCastVec2Vec4ToVec2TakesOnlyXY[0m, time elapsed: 239600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec4ToVec2TakesOnlyXY (10000 ns)
    TCS: [33mTestCase_testCastVec2SameTypeIdentity[0m, time elapsed: 240300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2SameTypeIdentity (19500 ns)
    TCS: [33mTestCase_testCastVec2Int32ToInt64[0m, time elapsed: 228000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Int32ToInt64 (11400 ns)
    TCS: [33mTestCase_testCastVec2FloatToIntTruncation[0m, time elapsed: 218300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2FloatToIntTruncation (10100 ns)
    TCS: [33mTestCase_testCastVec2CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 194200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2CrossQualifierPackedHighpToDefaultp (8200 ns)
    TCS: [33mTestCase_testCastVec2DoesNotModifySource[0m, time elapsed: 212100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2DoesNotModifySource (8000 ns)
    TCS: [33mTestCase_testCastVec2Vec1ToVec2SameValueBothComponents[0m, time elapsed: 191600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec1ToVec2SameValueBothComponents (15400 ns)
    TCS: [33mTestCase_testCastVec3Vec1ToVec3IntToFloat[0m, time elapsed: 298600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec1ToVec3IntToFloat (21200 ns)
    TCS: [33mTestCase_testCastVec3Vec2ToVec3ExtendY[0m, time elapsed: 216400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec2ToVec3ExtendY (22100 ns)
    TCS: [33mTestCase_testCastVec3Vec3ToVec3Identity[0m, time elapsed: 199200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec3ToVec3Identity (8000 ns)
    TCS: [33mTestCase_testCastVec3Vec4ToVec3TakesOnlyXYZ[0m, time elapsed: 245100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec4ToVec3TakesOnlyXYZ (15800 ns)
    TCS: [33mTestCase_testCastVec3SameTypeIdentity[0m, time elapsed: 184200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3SameTypeIdentity (6800 ns)
    TCS: [33mTestCase_testCastVec3Int32ToInt64[0m, time elapsed: 238700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Int32ToInt64 (16200 ns)
    TCS: [33mTestCase_testCastVec3FloatToIntTruncation[0m, time elapsed: 271400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3FloatToIntTruncation (12300 ns)
    TCS: [33mTestCase_testCastVec3CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 185000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3CrossQualifierPackedHighpToDefaultp (7700 ns)
    TCS: [33mTestCase_testCastVec3DoesNotModifySource[0m, time elapsed: 299800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3DoesNotModifySource (14900 ns)
    TCS: [33mTestCase_testCastVec3Vec1ToVec3SameValueAllComponents[0m, time elapsed: 308000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec1ToVec3SameValueAllComponents (15700 ns)
    TCS: [33mTestCase_testCastVec4Vec1ToVec4IntToFloat[0m, time elapsed: 368900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec1ToVec4IntToFloat (40100 ns)
    TCS: [33mTestCase_testCastVec4Vec2ToVec4ExtendY[0m, time elapsed: 199200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec2ToVec4ExtendY (10500 ns)
    TCS: [33mTestCase_testCastVec4Vec3ToVec4ExtendZ[0m, time elapsed: 188800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec3ToVec4ExtendZ (15200 ns)
    TCS: [33mTestCase_testCastVec4Vec4ToVec4Identity[0m, time elapsed: 175900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec4ToVec4Identity (11900 ns)
    TCS: [33mTestCase_testCastVec4SameTypeIdentity[0m, time elapsed: 178800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4SameTypeIdentity (7700 ns)
    TCS: [33mTestCase_testCastVec4Int32ToInt64[0m, time elapsed: 170200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Int32ToInt64 (10800 ns)
    TCS: [33mTestCase_testCastVec4FloatToIntTruncation[0m, time elapsed: 174700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4FloatToIntTruncation (7200 ns)
    TCS: [33mTestCase_testCastVec4CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 181700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4CrossQualifierPackedHighpToDefaultp (6200 ns)
    TCS: [33mTestCase_testCastVec4DoesNotModifySource[0m, time elapsed: 171600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4DoesNotModifySource (6800 ns)
    TCS: [33mTestCase_testCastVec4Vec1ToVec4SameValueAllComponents[0m, time elapsed: 169800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec1ToVec4SameValueAllComponents (6400 ns)
    TCS: [33mTestCase_testFromBoolVec1[0m, time elapsed: 173400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec1 (9100 ns)
    TCS: [33mTestCase_testFromBoolVec1False[0m, time elapsed: 182300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec1False (5600 ns)
    TCS: [33mTestCase_testFromBoolVec2[0m, time elapsed: 200800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec2 (12000 ns)
    TCS: [33mTestCase_testFromBoolVec3[0m, time elapsed: 169300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec3 (6300 ns)
    TCS: [33mTestCase_testFromBoolVec4[0m, time elapsed: 204200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec4 (6600 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec1[0m, time elapsed: 307100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec1 (11800 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec2[0m, time elapsed: 247900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec2 (14000 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec3[0m, time elapsed: 255500 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec3 (19700 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec4[0m, time elapsed: 357000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec4 (19800 ns)
    TCS: [33mTestCase_testFromBoolVec3AllFalse[0m, time elapsed: 216200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec3AllFalse (11100 ns)
    TCS: [33mTestCase_testFromBoolVec4AllFalse[0m, time elapsed: 243800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec4AllFalse (9300 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec3AllFalse[0m, time elapsed: 201000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec3AllFalse (8500 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec4AllFalse[0m, time elapsed: 197000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec4AllFalse (7300 ns)
    TCS: [33mTestCase_testFromBoolVecFloat32[0m, time elapsed: 206000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecFloat32 (12700 ns)
    TCS: [33mTestCase_testFromBoolVecFloat64[0m, time elapsed: 194200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecFloat64 (8600 ns)
    TCS: [33mTestCase_testFromBoolVecInt32[0m, time elapsed: 192000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecInt32 (9500 ns)
    TCS: [33mTestCase_testFromBoolVecQ2PackedMediump[0m, time elapsed: 192300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2PackedMediump (8600 ns)
    TCS: [33mTestCase_testFromBoolVecQ2PackedLowp[0m, time elapsed: 219700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2PackedLowp (8500 ns)
    TCS: [33mTestCase_testVec2ScalarInit[0m, time elapsed: 218700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarInit (29400 ns)
    TCS: [33mTestCase_testVec2ConstInit[0m, time elapsed: 188000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ConstInit (10500 ns)
    TCS: [33mTestCase_testVec2Length[0m, time elapsed: 180200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Length (5500 ns)
    TCS: [33mTestCase_testVec2Add[0m, time elapsed: 218800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Add (14400 ns)
    TCS: [33mTestCase_testVec2Sub[0m, time elapsed: 190600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Sub (12900 ns)
    TCS: [33mTestCase_testVec2Mul[0m, time elapsed: 184100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Mul (13900 ns)
    TCS: [33mTestCase_testVec2ScalarAdd[0m, time elapsed: 221800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarAdd (16500 ns)
    TCS: [33mTestCase_testVec2Negate[0m, time elapsed: 199200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Negate (10200 ns)
    TCS: [33mTestCase_testVec2IndexAccess[0m, time elapsed: 181900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2IndexAccess (6500 ns)
    TCS: [33mTestCase_testVec2IndexMutate[0m, time elapsed: 214300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2IndexMutate (12300 ns)
    TCS: [33mTestCase_testVec2ComponentAt[0m, time elapsed: 181900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ComponentAt (6800 ns)
    TCS: [33mTestCase_testVec2Equal[0m, time elapsed: 198700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Equal (18100 ns)
    TCS: [33mTestCase_testVec2NotEqual[0m, time elapsed: 230500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2NotEqual (13000 ns)
    TCS: [33mTestCase_testVec2EqualExact[0m, time elapsed: 190600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2EqualExact (11000 ns)
    TCS: [33mTestCase_testVec2BitwiseAnd[0m, time elapsed: 190100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseAnd (15900 ns)
    TCS: [33mTestCase_testVec2BitwiseNot[0m, time elapsed: 176500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseNot (6800 ns)
    TCS: [33mTestCase_testVec2FromVec1[0m, time elapsed: 185100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2FromVec1 (10300 ns)
    TCS: [33mTestCase_testVec2ShiftLeft[0m, time elapsed: 197600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeft (15800 ns)
    TCS: [33mTestCase_testVec2BoolLogicalAnd[0m, time elapsed: 176200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BoolLogicalAnd (9400 ns)
    TCS: [33mTestCase_testVec2Vec1ArithBroadcast[0m, time elapsed: 180600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Vec1ArithBroadcast (10300 ns)
    TCS: [33mTestCase_testVec2Vec1BitBroadcast[0m, time elapsed: 303700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Vec1BitBroadcast (17400 ns)
    TCS: [33mTestCase_testVec2ShiftLeftVec1[0m, time elapsed: 261300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeftVec1 (24100 ns)
    TCS: [33mTestCase_testVec2Div[0m, time elapsed: 282900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Div (16400 ns)
    TCS: [33mTestCase_testVec2Mod[0m, time elapsed: 230200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Mod (14200 ns)
    TCS: [33mTestCase_testVec2ScalarSub[0m, time elapsed: 209600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarSub (16000 ns)
    TCS: [33mTestCase_testVec2ScalarMul[0m, time elapsed: 184700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarMul (12400 ns)
    TCS: [33mTestCase_testVec2ScalarDiv[0m, time elapsed: 214800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarDiv (11300 ns)
    TCS: [33mTestCase_testVec2ScalarMod[0m, time elapsed: 190300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarMod (13000 ns)
    TCS: [33mTestCase_testVec2BoolLogicalOr[0m, time elapsed: 196900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BoolLogicalOr (10100 ns)
    TCS: [33mTestCase_testVec2EqualEpsilon[0m, time elapsed: 186400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2EqualEpsilon (15500 ns)
    TCS: [33mTestCase_testVec2DivNamed[0m, time elapsed: 200900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2DivNamed (8900 ns)
    TCS: [33mTestCase_testVec2ModNamed[0m, time elapsed: 179400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ModNamed (6900 ns)
    TCS: [33mTestCase_testVec2BitwiseOr[0m, time elapsed: 258500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseOr (19400 ns)
    TCS: [33mTestCase_testVec2BitwiseXor[0m, time elapsed: 384900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseXor (25400 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseAnd[0m, time elapsed: 310300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseAnd (20300 ns)
    TCS: [33mTestCase_testVec2ShiftRight[0m, time elapsed: 312500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRight (19300 ns)
    TCS: [33mTestCase_testVec2ShiftRightVec1[0m, time elapsed: 346600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRightVec1 (18800 ns)
    TCS: [33mTestCase_testVec2AddNamed[0m, time elapsed: 326400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2AddNamed (13300 ns)
    TCS: [33mTestCase_testVec2SubNamed[0m, time elapsed: 369200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2SubNamed (22500 ns)
    TCS: [33mTestCase_testVec2MulNamed[0m, time elapsed: 309300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2MulNamed (14600 ns)
    TCS: [33mTestCase_testVec2ShiftLeftVec[0m, time elapsed: 400300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeftVec (16400 ns)
    TCS: [33mTestCase_testVec2ShiftRightVec[0m, time elapsed: 361600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRightVec (17100 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseOr[0m, time elapsed: 362800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseOr (17000 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseXor[0m, time elapsed: 383500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseXor (44500 ns)
    TCS: [33mTestCase_testVec2Increment[0m, time elapsed: 406100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Increment (35500 ns)
    TCS: [33mTestCase_testVec2Decrement[0m, time elapsed: 385900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Decrement (28700 ns)
    TCS: [33mTestCase_testVec2IndexOutOfBoundsAccess[0m, time elapsed: 324700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2IndexOutOfBoundsAccess (79600 ns)
    TCS: [33mTestCase_testVec2NegativeIndexAccess[0m, time elapsed: 322700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2NegativeIndexAccess (51400 ns)
    TCS: [33mTestCase_testVec3ScalarInit[0m, time elapsed: 309600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarInit (14600 ns)
    TCS: [33mTestCase_testVec3ConstInit[0m, time elapsed: 434900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ConstInit (24200 ns)
    TCS: [33mTestCase_testVec3Length[0m, time elapsed: 248700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Length (10400 ns)
    TCS: [33mTestCase_testVec3Add[0m, time elapsed: 243900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Add (26500 ns)
    TCS: [33mTestCase_testVec3ScalarMul[0m, time elapsed: 272400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarMul (18300 ns)
    TCS: [33mTestCase_testVec3Negate[0m, time elapsed: 224700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Negate (15400 ns)
    TCS: [33mTestCase_testVec3IndexAccess[0m, time elapsed: 281000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3IndexAccess (26100 ns)
    TCS: [33mTestCase_testVec3IndexMutate[0m, time elapsed: 401300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3IndexMutate (16300 ns)
    TCS: [33mTestCase_testVec3ComponentAt[0m, time elapsed: 417800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ComponentAt (20700 ns)
    TCS: [33mTestCase_testVec3Equal[0m, time elapsed: 309200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Equal (29900 ns)
    TCS: [33mTestCase_testVec3NotEqual[0m, time elapsed: 445100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3NotEqual (43000 ns)
    TCS: [33mTestCase_testVec3EqualExact[0m, time elapsed: 281200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3EqualExact (29500 ns)
    TCS: [33mTestCase_testVec3BitwiseAnd[0m, time elapsed: 219300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseAnd (22500 ns)
    TCS: [33mTestCase_testVec3BitwiseNot[0m, time elapsed: 214300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseNot (10300 ns)
    TCS: [33mTestCase_testVec3Vec1ArithBroadcast[0m, time elapsed: 228400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1ArithBroadcast (23800 ns)
    TCS: [33mTestCase_testVec3ShiftLeft[0m, time elapsed: 214800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeft (16100 ns)
    TCS: [33mTestCase_testVec3BoolLogicalAnd[0m, time elapsed: 241100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BoolLogicalAnd (23800 ns)
    TCS: [33mTestCase_testVec3Sub[0m, time elapsed: 206400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Sub (24600 ns)
    TCS: [33mTestCase_testVec3Div[0m, time elapsed: 236100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Div (18400 ns)
    TCS: [33mTestCase_testVec3Mod[0m, time elapsed: 285500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Mod (14800 ns)
    TCS: [33mTestCase_testVec3ScalarSub[0m, time elapsed: 217700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarSub (15500 ns)
    TCS: [33mTestCase_testVec3ScalarDiv[0m, time elapsed: 236100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarDiv (15500 ns)
    TCS: [33mTestCase_testVec3ScalarMod[0m, time elapsed: 209000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarMod (12600 ns)
    TCS: [33mTestCase_testVec3BoolLogicalOr[0m, time elapsed: 229000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BoolLogicalOr (14200 ns)
    TCS: [33mTestCase_testVec3EqualEpsilon[0m, time elapsed: 225100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3EqualEpsilon (17600 ns)
    TCS: [33mTestCase_testVec3AddNamed[0m, time elapsed: 198600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3AddNamed (11100 ns)
    TCS: [33mTestCase_testVec3MulNamed[0m, time elapsed: 210800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3MulNamed (9400 ns)
    TCS: [33mTestCase_testVec3DivNamed[0m, time elapsed: 182600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3DivNamed (6800 ns)
    TCS: [33mTestCase_testVec3ModNamed[0m, time elapsed: 215600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ModNamed (11000 ns)
    TCS: [33mTestCase_testVec3BitwiseOr[0m, time elapsed: 197700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseOr (18800 ns)
    TCS: [33mTestCase_testVec3BitwiseXor[0m, time elapsed: 222200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseXor (16400 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseAnd[0m, time elapsed: 199000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseAnd (14500 ns)
    TCS: [33mTestCase_testVec3ShiftRight[0m, time elapsed: 259500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRight (20200 ns)
    TCS: [33mTestCase_testVec3Vec1BitBroadcast[0m, time elapsed: 408300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitBroadcast (26900 ns)
    TCS: [33mTestCase_testVec3ShiftRightVec1[0m, time elapsed: 411900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRightVec1 (45300 ns)
    TCS: [33mTestCase_testVec3FromVec1[0m, time elapsed: 322200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3FromVec1 (14700 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseOr[0m, time elapsed: 315900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseOr (27500 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseXor[0m, time elapsed: 303300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseXor (20600 ns)
    TCS: [33mTestCase_testVec3Vec1BitOrBroadcast[0m, time elapsed: 333000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitOrBroadcast (37900 ns)
    TCS: [33mTestCase_testVec3Vec1BitXorBroadcast[0m, time elapsed: 364000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitXorBroadcast (33200 ns)
    TCS: [33mTestCase_testVec3ShiftLeftVec1[0m, time elapsed: 373500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeftVec1 (27800 ns)
    TCS: [33mTestCase_testVec3ShiftLeftVec[0m, time elapsed: 376300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeftVec (15400 ns)
    TCS: [33mTestCase_testVec3ShiftRightVec[0m, time elapsed: 365800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRightVec (26000 ns)
    TCS: [33mTestCase_testVec3Increment[0m, time elapsed: 399900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Increment (26300 ns)
    TCS: [33mTestCase_testVec3Decrement[0m, time elapsed: 352600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Decrement (23500 ns)
    TCS: [33mTestCase_testVec3IndexOutOfBoundsAccess[0m, time elapsed: 362700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3IndexOutOfBoundsAccess (64800 ns)
    TCS: [33mTestCase_testVec3NegativeIndexAccess[0m, time elapsed: 435700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3NegativeIndexAccess (67000 ns)
    TCS: [33mTestCase_testVec4ScalarInit[0m, time elapsed: 337000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarInit (26000 ns)
    TCS: [33mTestCase_testVec4ConstInit[0m, time elapsed: 296500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ConstInit (12900 ns)
    TCS: [33mTestCase_testVec4Length[0m, time elapsed: 250000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Length (11000 ns)
    TCS: [33mTestCase_testVec4Add[0m, time elapsed: 282100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Add (28300 ns)
    TCS: [33mTestCase_testVec4ScalarMul[0m, time elapsed: 286700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarMul (18200 ns)
    TCS: [33mTestCase_testVec4Negate[0m, time elapsed: 266300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Negate (23900 ns)
    TCS: [33mTestCase_testVec4IndexAccess[0m, time elapsed: 263500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4IndexAccess (20900 ns)
    TCS: [33mTestCase_testVec4IndexMutate[0m, time elapsed: 291800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4IndexMutate (9600 ns)
    TCS: [33mTestCase_testVec4ComponentAt[0m, time elapsed: 320000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ComponentAt (18200 ns)
    TCS: [33mTestCase_testVec4Equal[0m, time elapsed: 308500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Equal (37100 ns)
    TCS: [33mTestCase_testVec4NotEqual[0m, time elapsed: 283100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4NotEqual (23500 ns)
    TCS: [33mTestCase_testVec4EqualExact[0m, time elapsed: 294300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4EqualExact (26600 ns)
    TCS: [33mTestCase_testVec4BitwiseAnd[0m, time elapsed: 293800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseAnd (20800 ns)
    TCS: [33mTestCase_testVec4BitwiseNot[0m, time elapsed: 484100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseNot (21200 ns)
    TCS: [33mTestCase_testVec4Vec1ArithBroadcast[0m, time elapsed: 341800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1ArithBroadcast (43600 ns)
    TCS: [33mTestCase_testVec4ShiftLeft[0m, time elapsed: 230200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeft (19600 ns)
    TCS: [33mTestCase_testVec4BoolLogicalAnd[0m, time elapsed: 239000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BoolLogicalAnd (19600 ns)
    TCS: [33mTestCase_testVec4Sub[0m, time elapsed: 499200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Sub (41100 ns)
    TCS: [33mTestCase_testVec4Div[0m, time elapsed: 345600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Div (21400 ns)
    TCS: [33mTestCase_testVec4Mod[0m, time elapsed: 344000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Mod (24200 ns)
    TCS: [33mTestCase_testVec4ScalarSub[0m, time elapsed: 206100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarSub (15000 ns)
    TCS: [33mTestCase_testVec4ScalarDiv[0m, time elapsed: 290000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarDiv (17100 ns)
    TCS: [33mTestCase_testVec4ScalarMod[0m, time elapsed: 253400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarMod (15500 ns)
    TCS: [33mTestCase_testVec4BoolLogicalOr[0m, time elapsed: 234600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BoolLogicalOr (11000 ns)
    TCS: [33mTestCase_testVec4EqualEpsilon[0m, time elapsed: 229800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4EqualEpsilon (18700 ns)
    TCS: [33mTestCase_testVec4AddNamed[0m, time elapsed: 313800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4AddNamed (39800 ns)
    TCS: [33mTestCase_testVec4MulNamed[0m, time elapsed: 360000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4MulNamed (20200 ns)
    TCS: [33mTestCase_testVec4DivNamed[0m, time elapsed: 238900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4DivNamed (11200 ns)
    TCS: [33mTestCase_testVec4ModNamed[0m, time elapsed: 187600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ModNamed (7700 ns)
    TCS: [33mTestCase_testVec4BitwiseOr[0m, time elapsed: 212100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseOr (20500 ns)
    TCS: [33mTestCase_testVec4BitwiseXor[0m, time elapsed: 204100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseXor (17300 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseAnd[0m, time elapsed: 199000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseAnd (15000 ns)
    TCS: [33mTestCase_testVec4ShiftRight[0m, time elapsed: 206000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRight (13100 ns)
    TCS: [33mTestCase_testVec4Vec1BitBroadcast[0m, time elapsed: 204700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitBroadcast (16400 ns)
    TCS: [33mTestCase_testVec4ShiftRightVec1[0m, time elapsed: 256200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRightVec1 (18800 ns)
    TCS: [33mTestCase_testVec4FromVec1[0m, time elapsed: 200500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4FromVec1 (8000 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseOr[0m, time elapsed: 209900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseOr (17300 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseXor[0m, time elapsed: 256000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseXor (14300 ns)
    TCS: [33mTestCase_testVec4Vec1BitOrBroadcast[0m, time elapsed: 216800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitOrBroadcast (19500 ns)
    TCS: [33mTestCase_testVec4Vec1BitXorBroadcast[0m, time elapsed: 186500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitXorBroadcast (14700 ns)
    TCS: [33mTestCase_testVec4ShiftLeftVec1[0m, time elapsed: 182800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeftVec1 (12600 ns)
    TCS: [33mTestCase_testVec4ShiftLeftVec[0m, time elapsed: 184400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeftVec (19900 ns)
    TCS: [33mTestCase_testVec4ShiftRightVec[0m, time elapsed: 227900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRightVec (19000 ns)
    TCS: [33mTestCase_testVec4Increment[0m, time elapsed: 187100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Increment (16600 ns)
    TCS: [33mTestCase_testVec4Decrement[0m, time elapsed: 180800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Decrement (15000 ns)
    TCS: [33mTestCase_testVec4IndexOutOfBoundsAccess[0m, time elapsed: 224100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4IndexOutOfBoundsAccess (50700 ns)
    TCS: [33mTestCase_testVec4NegativeIndexAccess[0m, time elapsed: 186600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4NegativeIndexAccess (22100 ns)
    TCS: [33mTestCase_testFunctor1Vec1Identity[0m, time elapsed: 168700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec1Identity (10600 ns)
    TCS: [33mTestCase_testFunctor1Vec1Transform[0m, time elapsed: 173000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec1Transform (6700 ns)
    TCS: [33mTestCase_testFunctor1Vec2Transform[0m, time elapsed: 176500 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec2Transform (7000 ns)
    TCS: [33mTestCase_testFunctor2Vec1Add[0m, time elapsed: 171300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec1Add (6700 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec1Mul[0m, time elapsed: 173900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec1Mul (9800 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec1Shift[0m, time elapsed: 177100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec1Shift (12400 ns)
    TCS: [33mTestCase_testFunctor1Vec3Transform[0m, time elapsed: 233100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec3Transform (7000 ns)
    TCS: [33mTestCase_testFunctor1Vec4Transform[0m, time elapsed: 179700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec4Transform (7300 ns)
    TCS: [33mTestCase_testFunctor2Vec2Add[0m, time elapsed: 245800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec2Add (6400 ns)
    TCS: [33mTestCase_testFunctor2Vec3Add[0m, time elapsed: 173700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec3Add (6800 ns)
    TCS: [33mTestCase_testFunctor2Vec4Add[0m, time elapsed: 186300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec4Add (12100 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec2Mul[0m, time elapsed: 171800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec2Mul (5900 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec3Mul[0m, time elapsed: 187000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec3Mul (10100 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec4Mul[0m, time elapsed: 175900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec4Mul (6300 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec2Shift[0m, time elapsed: 172500 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec2Shift (5900 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec3Shift[0m, time elapsed: 175900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec3Shift (9200 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec4Shift[0m, time elapsed: 171400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec4Shift (6900 ns)
Summary: TOTAL: 422
    [32mPASSED[0m: 422, [32mSKIPPED[0m: 0, ERROR: 0
    [31mFAILED[0m: 0
--------------------------------------------------------------------------------------------------
Project tests finished, time elapsed: 175849700 ns, RESULT:
TP: [33mglm[0m.*, time elapsed: 175792500 ns, RESULT:
    PASSED:
    TP: [33mglm.detail[0m, time elapsed: 160268300 ns
Summary: TOTAL: 422
    [32mPASSED[0m: 422, [32mSKIPPED[0m: 0, ERROR: 0
    [31mFAILED[0m: 0
--------------------------------------------------------------------------------------------------
[0J7[;r8[?25hWarning: there is no '.cj' file in directory 'C:\Develop\Software\cjglm_wp\cjglm\src\gtc', and its subdirectories will not be scanned as source code
Warning: there is no '.cj' file in directory 'C:\Develop\Software\cjglm_wp\cjglm\src\gtc', and its subdirectories will not be scanned as source code
cjpm test success
