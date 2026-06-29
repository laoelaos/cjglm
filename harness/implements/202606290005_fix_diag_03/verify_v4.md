# 验证报告（v4）

## 结果
FAILED

## 统计
- 通过：433
- 失败：2

## 测试执行日志
warning: unused import 'std.math.Integer'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:3:27:
  | 
3 | import std.math.{ Number, Integer }
  |                           ^^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused import 'std.math.Integer'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:3:27:
  | 
3 | import std.math.{ Number, Integer }
  |                           ^^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused import 'std.math.Integer'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:3:27:
  | 
3 | import std.math.{ Number, Integer }
  |                           ^^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused import 'std.math.Integer'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:3:27:
  | 
3 | import std.math.{ Number, Integer }
  |                           ^^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused import 'std.math.Integer'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:3:27:
  | 
3 | import std.math.{ Number, Integer }
  |                           ^^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused import 'std.math.Integer'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x4.cj:3:27:
  | 
3 | import std.math.{ Number, Integer }
  |                           ^^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused import 'std.math.Integer'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:3:27:
  | 
3 | import std.math.{ Number, Integer }
  |                           ^^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused import 'std.math.Integer'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x3.cj:3:27:
  | 
3 | import std.math.{ Number, Integer }
  |                           ^^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused import 'std.math.Integer'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x4.cj:3:27:
  | 
3 | import std.math.{ Number, Integer }
  |                           ^^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'a'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:5:20:
  | 
5 | public func min<T>(a: T, b: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }
  |                    ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:5:20:
  | 
5 | public func sin<T>(x: T): T where T <: FloatingPoint<T> { throw Exception("stub") }
  |                    ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:5:23:
  | 
5 | public func dot<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
  |                       ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'b'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:5:26:
  | 
5 | public func min<T>(a: T, b: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }
  |                          ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'y'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:5:38:
  | 
5 | public func dot<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
  |                                      ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'a'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:6:20:
  | 
6 | public func max<T>(a: T, b: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }
  |                    ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:6:23:
  | 
6 | public func dot<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
  |                       ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:6:23:
  | 
6 | public func sin<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
  |                       ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'b'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:6:26:
  | 
6 | public func max<T>(a: T, b: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }
  |                          ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'y'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:6:38:
  | 
6 | public func dot<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
  |                                      ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'a'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:7:20:
  | 
7 | public func abs<T>(a: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }
  |                    ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:7:23:
  | 
7 | public func dot<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
  |                       ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:7:23:
  | 
7 | public func sin<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
  |                       ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'y'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:7:38:
  | 
7 | public func dot<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
  |                                      ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'a'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:8:21:
  | 
8 | public func sign<T>(a: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }
  |                     ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:8:23:
  | 
8 | public func sin<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
  |                       ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:8:23:
  | 
8 | public func dot<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
  |                       ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'y'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:8:38:
  | 
8 | public func dot<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
  |                                      ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'a'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:9:22:
  | 
9 | public func floor<T>(a: T): T where T <: Number<T> { throw Exception("stub") }
  |                      ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:9:23:
  | 
9 | public func sin<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
  |                       ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:9:25:
  | 
9 | public func cross<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
  |                         ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'y'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:9:40:
  | 
9 | public func cross<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
  |                                        ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'a'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:10:21:
   | 
10 | public func ceil<T>(a: T): T where T <: Number<T> { throw Exception("stub") }
   |                     ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'v'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:10:29:
   | 
10 | public func normalize<T, Q>(v: Vec2<T, Q>): Vec2<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                             ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:11:20:
   | 
11 | public func cos<T>(x: T): T where T <: FloatingPoint<T> { throw Exception("stub") }
   |                    ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'a'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:11:22:
   | 
11 | public func fract<T>(a: T): T where T <: Number<T> { throw Exception("stub") }
   |                      ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'v'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:11:29:
   | 
11 | public func normalize<T, Q>(v: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                             ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'a'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:12:20:
   | 
12 | public func mod<T>(a: T, b: T): T where T <: Integer<T> { throw Exception("stub") }
   |                    ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:12:23:
   | 
12 | public func cos<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                       ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'b'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:12:26:
   | 
12 | public func mod<T>(a: T, b: T): T where T <: Integer<T> { throw Exception("stub") }
   |                          ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'v'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:12:29:
   | 
12 | public func normalize<T, Q>(v: Vec4<T, Q>): Vec4<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                             ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'a'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:13:22:
   | 
13 | public func clamp<T>(a: T, minVal: T, maxVal: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }
   |                      ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:13:23:
   | 
13 | public func cos<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                       ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'v'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:13:26:
   | 
13 | public func length<T, Q>(v: Vec2<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                          ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'minVal'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:13:28:
   | 
13 | public func clamp<T>(a: T, minVal: T, maxVal: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }
   |                            ^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'maxVal'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:13:39:
   | 
13 | public func clamp<T>(a: T, minVal: T, maxVal: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }
   |                                       ^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'a'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:14:20:
   | 
14 | public func mix<T>(a: T, b: T, t: T): T where T <: Number<T> { throw Exception("stub") }
   |                    ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:14:23:
   | 
14 | public func cos<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                       ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'b'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:14:26:
   | 
14 | public func mix<T>(a: T, b: T, t: T): T where T <: Number<T> { throw Exception("stub") }
   |                          ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'v'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:14:26:
   | 
14 | public func length<T, Q>(v: Vec3<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                          ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'t'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:14:32:
   | 
14 | public func mix<T>(a: T, b: T, t: T): T where T <: Number<T> { throw Exception("stub") }
   |                                ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'edge'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:15:21:
   | 
15 | public func step<T>(edge: T, x: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }
   |                     ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:15:23:
   | 
15 | public func cos<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                       ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'v'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:15:26:
   | 
15 | public func length<T, Q>(v: Vec4<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                          ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:15:30:
   | 
15 | public func step<T>(edge: T, x: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }
   |                              ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'edge0'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:16:27:
   | 
16 | public func smoothstep<T>(edge0: T, edge1: T, x: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }
   |                           ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'p0'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:16:28:
   | 
16 | public func distance<T, Q>(p0: Vec2<T, Q>, p1: Vec2<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                            ^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'edge1'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:16:37:
   | 
16 | public func smoothstep<T>(edge0: T, edge1: T, x: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }
   |                                     ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'p1'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:16:44:
   | 
16 | public func distance<T, Q>(p0: Vec2<T, Q>, p1: Vec2<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                                            ^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:16:47:
   | 
16 | public func smoothstep<T>(edge0: T, edge1: T, x: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }
   |                                               ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:17:20:
   | 
17 | public func tan<T>(x: T): T where T <: FloatingPoint<T> { throw Exception("stub") }
   |                    ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'p0'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:17:28:
   | 
17 | public func distance<T, Q>(p0: Vec3<T, Q>, p1: Vec3<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                            ^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'p1'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:17:44:
   | 
17 | public func distance<T, Q>(p0: Vec3<T, Q>, p1: Vec3<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                                            ^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:18:23:
   | 
18 | public func tan<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                       ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'p0'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:18:28:
   | 
18 | public func distance<T, Q>(p0: Vec4<T, Q>, p1: Vec4<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                            ^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'p1'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:18:44:
   | 
18 | public func distance<T, Q>(p0: Vec4<T, Q>, p1: Vec4<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                                            ^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:19:23:
   | 
19 | public func tan<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                       ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'I'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:19:27:
   | 
19 | public func reflect<T, Q>(I: Vec2<T, Q>, N: Vec2<T, Q>): Vec2<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                           ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'N'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:19:42:
   | 
19 | public func reflect<T, Q>(I: Vec2<T, Q>, N: Vec2<T, Q>): Vec2<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                                          ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:20:23:
   | 
20 | public func tan<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                       ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'I'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:20:27:
   | 
20 | public func reflect<T, Q>(I: Vec3<T, Q>, N: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                           ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'N'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:20:42:
   | 
20 | public func reflect<T, Q>(I: Vec3<T, Q>, N: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                                          ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:21:23:
   | 
21 | public func tan<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                       ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'I'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:21:27:
   | 
21 | public func reflect<T, Q>(I: Vec4<T, Q>, N: Vec4<T, Q>): Vec4<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                           ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'N'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:21:42:
   | 
21 | public func reflect<T, Q>(I: Vec4<T, Q>, N: Vec4<T, Q>): Vec4<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                                          ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'I'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:22:27:
   | 
22 | public func refract<T, Q>(I: Vec2<T, Q>, N: Vec2<T, Q>, eta: T): Vec2<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                           ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'N'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:22:42:
   | 
22 | public func refract<T, Q>(I: Vec2<T, Q>, N: Vec2<T, Q>, eta: T): Vec2<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                                          ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'eta'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:22:57:
   | 
22 | public func refract<T, Q>(I: Vec2<T, Q>, N: Vec2<T, Q>, eta: T): Vec2<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                                                         ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:23:21:
   | 
23 | public func asin<T>(x: T): T where T <: FloatingPoint<T> { throw Exception("stub") }
   |                     ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'I'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:23:27:
   | 
23 | public func refract<T, Q>(I: Vec3<T, Q>, N: Vec3<T, Q>, eta: T): Vec3<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                           ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'N'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:23:42:
   | 
23 | public func refract<T, Q>(I: Vec3<T, Q>, N: Vec3<T, Q>, eta: T): Vec3<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                                          ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'eta'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:23:57:
   | 
23 | public func refract<T, Q>(I: Vec3<T, Q>, N: Vec3<T, Q>, eta: T): Vec3<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                                                         ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:24:24:
   | 
24 | public func asin<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'I'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:24:27:
   | 
24 | public func refract<T, Q>(I: Vec4<T, Q>, N: Vec4<T, Q>, eta: T): Vec4<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                           ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'N'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:24:42:
   | 
24 | public func refract<T, Q>(I: Vec4<T, Q>, N: Vec4<T, Q>, eta: T): Vec4<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                                          ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'eta'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:24:57:
   | 
24 | public func refract<T, Q>(I: Vec4<T, Q>, N: Vec4<T, Q>, eta: T): Vec4<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                                                         ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:25:24:
   | 
25 | public func asin<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:26:24:
   | 
26 | public func asin<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:27:24:
   | 
27 | public func asin<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:29:21:
   | 
29 | public func acos<T>(x: T): T where T <: FloatingPoint<T> { throw Exception("stub") }
   |                     ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:30:24:
   | 
30 | public func acos<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:31:24:
   | 
31 | public func acos<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:32:24:
   | 
32 | public func acos<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:33:24:
   | 
33 | public func acos<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:35:21:
   | 
35 | public func atan<T>(x: T): T where T <: FloatingPoint<T> { throw Exception("stub") }
   |                     ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:36:24:
   | 
36 | public func atan<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:37:24:
   | 
37 | public func atan<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:38:24:
   | 
38 | public func atan<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:39:24:
   | 
39 | public func atan<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:41:21:
   | 
41 | public func sinh<T>(x: T): T where T <: FloatingPoint<T> { throw Exception("stub") }
   |                     ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:42:24:
   | 
42 | public func sinh<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:43:24:
   | 
43 | public func sinh<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:44:24:
   | 
44 | public func sinh<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:45:24:
   | 
45 | public func sinh<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:47:21:
   | 
47 | public func cosh<T>(x: T): T where T <: FloatingPoint<T> { throw Exception("stub") }
   |                     ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:48:24:
   | 
48 | public func cosh<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:49:24:
   | 
49 | public func cosh<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:50:24:
   | 
50 | public func cosh<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:51:24:
   | 
51 | public func cosh<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:53:21:
   | 
53 | public func tanh<T>(x: T): T where T <: FloatingPoint<T> { throw Exception("stub") }
   |                     ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'two'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_quat_cast.cj:54:9:
   | 
54 |     let two: T = (Float64(2.0) as T).getOrThrow()
   |         ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:54:24:
   | 
54 | public func tanh<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:55:24:
   | 
55 | public func tanh<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:56:24:
   | 
56 | public func tanh<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:57:24:
   | 
57 | public func tanh<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:59:22:
   | 
59 | public func asinh<T>(x: T): T where T <: FloatingPoint<T> { throw Exception("stub") }
   |                      ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:60:25:
   | 
60 | public func asinh<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:61:25:
   | 
61 | public func asinh<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:62:25:
   | 
62 | public func asinh<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:63:25:
   | 
63 | public func asinh<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:65:22:
   | 
65 | public func acosh<T>(x: T): T where T <: FloatingPoint<T> { throw Exception("stub") }
   |                      ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:66:25:
   | 
66 | public func acosh<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:67:25:
   | 
67 | public func acosh<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:68:25:
   | 
68 | public func acosh<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:69:25:
   | 
69 | public func acosh<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:71:22:
   | 
71 | public func atanh<T>(x: T): T where T <: FloatingPoint<T> { throw Exception("stub") }
   |                      ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:72:25:
   | 
72 | public func atanh<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:73:25:
   | 
73 | public func atanh<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:74:25:
   | 
74 | public func atanh<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:75:25:
   | 
75 | public func atanh<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:77:24:
   | 
77 | public func radians<T>(x: T): T where T <: FloatingPoint<T> { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:78:27:
   | 
78 | public func radians<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                           ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:79:27:
   | 
79 | public func radians<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                           ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:80:27:
   | 
80 | public func radians<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                           ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:81:27:
   | 
81 | public func radians<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                           ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:83:24:
   | 
83 | public func degrees<T>(x: T): T where T <: FloatingPoint<T> { throw Exception("stub") }
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:84:27:
   | 
84 | public func degrees<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                           ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:85:27:
   | 
85 | public func degrees<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                           ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:86:27:
   | 
86 | public func degrees<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                           ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:87:27:
   | 
87 | public func degrees<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                           ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'y'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:89:22:
   | 
89 | public func atan2<T>(y: T, x: T): T where T <: FloatingPoint<T> { throw Exception("stub") }
   |                      ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:89:28:
   | 
89 | public func atan2<T>(y: T, x: T): T where T <: FloatingPoint<T> { throw Exception("stub") }
   |                            ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'y'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:90:25:
   | 
90 | public func atan2<T, Q>(y: Vec1<T, Q>, x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:90:40:
   | 
90 | public func atan2<T, Q>(y: Vec1<T, Q>, x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'y'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:91:25:
   | 
91 | public func atan2<T, Q>(y: Vec2<T, Q>, x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:91:40:
   | 
91 | public func atan2<T, Q>(y: Vec2<T, Q>, x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'y'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:92:25:
   | 
92 | public func atan2<T, Q>(y: Vec3<T, Q>, x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:92:40:
   | 
92 | public func atan2<T, Q>(y: Vec3<T, Q>, x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'y'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:93:25:
   | 
93 | public func atan2<T, Q>(y: Vec4<T, Q>, x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:93:40:
   | 
93 | public func atan2<T, Q>(y: Vec4<T, Q>, x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'rhs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:114:28:
    | 
114 |     public operator func /(rhs: Mat2x2<T, Q>): Mat2x2<T, Q> { throw Exception("stub") }
    |                            ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'rhs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:118:28:
    | 
118 |     public operator func /(rhs: Mat3x3<T, Q>): Mat3x3<T, Q> { throw Exception("stub") }
    |                            ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'rhs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_quat.cj:120:28:
    | 
120 |     public operator func *(rhs: Vec3<T, Q>): Vec3<T, Q> {
    |                            ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'rhs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x4.cj:124:28:
    | 
124 |     public operator func /(rhs: Mat4x4<T, Q>): Mat4x4<T, Q> { throw Exception("stub") }
    |                            ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'rhs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_quat.cj:125:28:
    | 
125 |     public operator func *(rhs: Vec4<T, Q>): Vec4<T, Q> {
    |                            ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'rhs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_quat.cj:142:28:
    | 
142 |     public operator func *(rhs: Quat<T, Q>): Vec3<T, Q> {
    |                            ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:143:58:
    | 
143 |     public static func fromMat<SrcQ>(m: Mat2x2<T, SrcQ>, one: T): Mat2x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:143:58:
    | 
143 |     public static func fromMat<SrcQ>(m: Mat2x2<T, SrcQ>, one: T): Mat2x4<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:148:58:
    | 
148 |     public static func fromMat<SrcQ>(m: Mat2x3<T, SrcQ>, one: T): Mat2x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'rhs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_quat.cj:149:28:
    | 
149 |     public operator func *(rhs: Quat<T, Q>): Vec4<T, Q> {
    |                            ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:149:58:
    | 
149 |     public static func fromMat<SrcQ>(m: Mat2x3<T, SrcQ>, one: T): Mat2x4<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:149:58:
    | 
149 |     public static func fromMat<SrcQ>(m: Mat2x4<T, SrcQ>, one: T): Mat2x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:149:58:
    | 
149 |     public static func fromMat<SrcQ>(m: Mat2x2<T, SrcQ>, one: T): Mat3x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:153:58:
    | 
153 |     public static func fromMat<SrcQ>(m: Mat2x4<T, SrcQ>, one: T): Mat2x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:154:58:
    | 
154 |     public static func fromMat<SrcQ>(m: Mat3x2<T, SrcQ>, one: T): Mat2x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:155:58:
    | 
155 |     public static func fromMat<SrcQ>(m: Mat2x2<T, SrcQ>, one: T): Mat4x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:155:58:
    | 
155 |     public static func fromMat<SrcQ>(m: Mat3x2<T, SrcQ>, one: T): Mat2x4<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:155:58:
    | 
155 |     public static func fromMat<SrcQ>(m: Mat2x3<T, SrcQ>, one: T): Mat3x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:158:58:
    | 
158 |     public static func fromMat<SrcQ>(m: Mat3x2<T, SrcQ>, one: T): Mat2x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:160:58:
    | 
160 |     public static func fromMat<SrcQ>(m: Mat3x3<T, SrcQ>, one: T): Mat2x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:161:58:
    | 
161 |     public static func fromMat<SrcQ>(m: Mat2x3<T, SrcQ>, one: T): Mat4x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:161:58:
    | 
161 |     public static func fromMat<SrcQ>(m: Mat2x4<T, SrcQ>, one: T): Mat3x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:161:58:
    | 
161 |     public static func fromMat<SrcQ>(m: Mat3x3<T, SrcQ>, one: T): Mat2x4<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:163:58:
    | 
163 |     public static func fromMat<SrcQ>(m: Mat3x3<T, SrcQ>, one: T): Mat2x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:165:58:
    | 
165 |     public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat2x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'m'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\matrix.cj:167:31:
    | 
167 | public func determinant<T, Q>(m: Mat2x2<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
    |                               ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:167:58:
    | 
167 |     public static func fromMat<SrcQ>(m: Mat2x4<T, SrcQ>, one: T): Mat4x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:167:58:
    | 
167 |     public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat2x4<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:167:58:
    | 
167 |     public static func fromMat<SrcQ>(m: Mat3x3<T, SrcQ>, one: T): Mat3x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'m'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\matrix.cj:168:31:
    | 
168 | public func determinant<T, Q>(m: Mat3x3<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
    |                               ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:168:58:
    | 
168 |     public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat2x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'m'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\matrix.cj:169:31:
    | 
169 | public func determinant<T, Q>(m: Mat4x4<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
    |                               ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:170:58:
    | 
170 |     public static func fromMat<SrcQ>(m: Mat4x2<T, SrcQ>, one: T): Mat2x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'m'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\matrix.cj:171:27:
    | 
171 | public func inverse<T, Q>(m: Mat2x2<T, Q>): Mat2x2<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
    |                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'m'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\matrix.cj:172:27:
    | 
172 | public func inverse<T, Q>(m: Mat3x3<T, Q>): Mat3x3<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
    |                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:172:58:
    | 
172 |     public static func fromMat<SrcQ>(m: Mat4x2<T, SrcQ>, one: T): Mat2x4<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:172:58:
    | 
172 |     public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat3x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'m'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\matrix.cj:173:27:
    | 
173 | public func inverse<T, Q>(m: Mat4x4<T, Q>): Mat4x4<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
    |                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:173:58:
    | 
173 |     public static func fromMat<SrcQ>(m: Mat3x2<T, SrcQ>, one: T): Mat4x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x4.cj:173:58:
    | 
173 |     public static func fromMat<SrcQ>(m: Mat3x3<T, SrcQ>, one: T): Mat3x4<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:173:58:
    | 
173 |     public static func fromMat<SrcQ>(m: Mat4x2<T, SrcQ>, one: T): Mat2x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:176:58:
    | 
176 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat2x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:176:58:
    | 
176 |     public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat3x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:177:58:
    | 
177 |     public static func fromMat<SrcQ>(m: Mat4x2<T, SrcQ>, one: T): Mat3x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:178:58:
    | 
178 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat2x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:178:58:
    | 
178 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat2x4<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x3.cj:179:58:
    | 
179 |     public static func fromMat<SrcQ>(m: Mat3x3<T, SrcQ>, one: T): Mat4x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:179:58:
    | 
179 |     public static func fromMat<SrcQ>(m: Mat3x3<T, SrcQ>, one: T): Mat4x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:181:58:
    | 
181 |     public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat2x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:182:58:
    | 
182 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat3x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:183:58:
    | 
183 |     public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat2x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:184:58:
    | 
184 |     public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat2x4<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x4.cj:185:58:
    | 
185 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat3x4<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:185:58:
    | 
185 |     public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat4x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x3.cj:185:58:
    | 
185 |     public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat4x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:187:58:
    | 
187 |     public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat3x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:187:58:
    | 
187 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat3x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x4.cj:191:58:
    | 
191 |     public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat3x4<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:191:58:
    | 
191 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat4x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:192:58:
    | 
192 |     public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat3x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:192:71:
    | 
192 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat2x3<U, P>, one: T): Mat2x2<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:196:58:
    | 
196 |     public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat4x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:196:71:
    | 
196 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat2x4<U, P>, one: T): Mat2x3<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x3.cj:197:58:
    | 
197 |     public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat4x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:197:71:
    | 
197 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat2x4<U, P>, one: T): Mat2x2<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:202:71:
    | 
202 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat3x2<U, P>, one: T): Mat2x2<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:207:71:
    | 
207 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat3x3<U, P>, one: T): Mat2x3<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:207:71:
    | 
207 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat3x3<U, P>, one: T): Mat2x2<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:212:71:
    | 
212 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat3x4<U, P>, one: T): Mat2x2<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:212:71:
    | 
212 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat3x4<U, P>, one: T): Mat2x3<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:214:71:
    | 
214 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat3x3<U, P>, one: T): Mat3x2<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:217:71:
    | 
217 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat3x4<U, P>, one: T): Mat2x4<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:217:71:
    | 
217 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x2<U, P>, one: T): Mat2x2<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:219:71:
    | 
219 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat3x4<U, P>, one: T): Mat3x2<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:222:71:
    | 
222 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x3<U, P>, one: T): Mat2x2<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:223:71:
    | 
223 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x3<U, P>, one: T): Mat2x3<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:224:71:
    | 
224 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x2<U, P>, one: T): Mat3x2<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:225:71:
    | 
225 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat3x4<U, P>, one: T): Mat3x3<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:227:71:
    | 
227 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x4<U, P>, one: T): Mat2x2<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:228:71:
    | 
228 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x4<U, P>, one: T): Mat2x3<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:229:71:
    | 
229 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x3<U, P>, one: T): Mat3x2<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:234:71:
    | 
234 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x4<U, P>, one: T): Mat2x4<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:234:71:
    | 
234 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x4<U, P>, one: T): Mat3x2<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:236:71:
    | 
236 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x3<U, P>, one: T): Mat3x3<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:241:71:
    | 
241 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x4<U, P>, one: T): Mat3x3<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:241:71:
    | 
241 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x3<U, P>, one: T): Mat4x2<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x4.cj:242:71:
    | 
242 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x4<U, P>, one: T): Mat3x4<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:246:71:
    | 
246 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x4<U, P>, one: T): Mat4x2<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x3.cj:248:71:
    | 
248 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x4<U, P>, one: T): Mat4x3<T, Q>
    |                                                                       ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

238 warnings generated, 238 warnings printed.
warning: unused variable:'m'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:11:29:
   | 
11 | public func translate<T, Q>(m: Mat4x4<T, Q>, v: Vec3<T, Q>): Mat4x4<T, Q>
   |                             ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'v'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:11:46:
   | 
11 | public func translate<T, Q>(m: Mat4x4<T, Q>, v: Vec3<T, Q>): Mat4x4<T, Q>
   |                                              ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'m'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:15:26:
   | 
15 | public func rotate<T, Q>(m: Mat4x4<T, Q>, angle: T, axis: Vec3<T, Q>): Mat4x4<T, Q>
   |                          ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'angle'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:15:43:
   | 
15 | public func rotate<T, Q>(m: Mat4x4<T, Q>, angle: T, axis: Vec3<T, Q>): Mat4x4<T, Q>
   |                                           ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'axis'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:15:53:
   | 
15 | public func rotate<T, Q>(m: Mat4x4<T, Q>, angle: T, axis: Vec3<T, Q>): Mat4x4<T, Q>
   |                                                     ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'m'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:19:31:
   | 
19 | public func rotate_slow<T, Q>(m: Mat4x4<T, Q>, angle: T, axis: Vec3<T, Q>): Mat4x4<T, Q>
   |                               ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'angle'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:19:48:
   | 
19 | public func rotate_slow<T, Q>(m: Mat4x4<T, Q>, angle: T, axis: Vec3<T, Q>): Mat4x4<T, Q>
   |                                                ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'axis'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:19:58:
   | 
19 | public func rotate_slow<T, Q>(m: Mat4x4<T, Q>, angle: T, axis: Vec3<T, Q>): Mat4x4<T, Q>
   |                                                          ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:22:31:
   | 
22 | public func eulerAngles<T, Q>(x: Quat<T, Q>): Vec3<T, Q>
   |                               ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'m'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:23:25:
   | 
23 | public func scale<T, Q>(m: Mat4x4<T, Q>, v: Vec3<T, Q>): Mat4x4<T, Q>
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'v'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:23:42:
   | 
23 | public func scale<T, Q>(m: Mat4x4<T, Q>, v: Vec3<T, Q>): Mat4x4<T, Q>
   |                                          ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'q'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:26:24:
   | 
26 | public func roll<T, Q>(q: Quat<T, Q>): T
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'m'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:27:30:
   | 
27 | public func scale_slow<T, Q>(m: Mat4x4<T, Q>, v: Vec3<T, Q>): Mat4x4<T, Q>
   |                              ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'v'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:27:47:
   | 
27 | public func scale_slow<T, Q>(m: Mat4x4<T, Q>, v: Vec3<T, Q>): Mat4x4<T, Q>
   |                                               ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'q'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:30:25:
   | 
30 | public func pitch<T, Q>(q: Quat<T, Q>): T
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'m'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:31:25:
   | 
31 | public func shear<T, Q>(m: Mat4x4<T, Q>, n: Vec3<T, Q>, s: T): Mat4x4<T, Q>
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'n'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:31:42:
   | 
31 | public func shear<T, Q>(m: Mat4x4<T, Q>, n: Vec3<T, Q>, s: T): Mat4x4<T, Q>
   |                                          ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'s'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:31:57:
   | 
31 | public func shear<T, Q>(m: Mat4x4<T, Q>, n: Vec3<T, Q>, s: T): Mat4x4<T, Q>
   |                                                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'q'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:34:23:
   | 
34 | public func yaw<T, Q>(q: Quat<T, Q>): T
   |                       ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'m'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:35:30:
   | 
35 | public func shear_slow<T, Q>(m: Mat4x4<T, Q>, n: Vec3<T, Q>, s: T): Mat4x4<T, Q>
   |                              ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'n'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:35:47:
   | 
35 | public func shear_slow<T, Q>(m: Mat4x4<T, Q>, n: Vec3<T, Q>, s: T): Mat4x4<T, Q>
   |                                               ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'s'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:35:62:
   | 
35 | public func shear_slow<T, Q>(m: Mat4x4<T, Q>, n: Vec3<T, Q>, s: T): Mat4x4<T, Q>
   |                                                              ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'direction'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:38:30:
   | 
38 | public func quatLookAt<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
   |                              ^^^^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'up'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:38:53:
   | 
38 | public func quatLookAt<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
   |                                                     ^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'eye'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:39:28:
   | 
39 | public func lookAtRH<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>
   |                            ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'center'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:39:45:
   | 
39 | public func lookAtRH<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>
   |                                             ^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'up'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:39:65:
   | 
39 | public func lookAtRH<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>
   |                                                                 ^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'direction'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:42:32:
   | 
42 | public func quatLookAtRH<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
   |                                ^^^^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'up'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:42:55:
   | 
42 | public func quatLookAtRH<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
   |                                                       ^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'eye'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:43:28:
   | 
43 | public func lookAtLH<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>
   |                            ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'center'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:43:45:
   | 
43 | public func lookAtLH<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>
   |                                             ^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'up'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:43:65:
   | 
43 | public func lookAtLH<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>
   |                                                                 ^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'direction'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:46:32:
   | 
46 | public func quatLookAtLH<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
   |                                ^^^^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'up'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:46:55:
   | 
46 | public func quatLookAtLH<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
   |                                                       ^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'eye'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:47:26:
   | 
47 | public func lookAt<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>
   |                          ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'center'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:47:43:
   | 
47 | public func lookAt<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>
   |                                           ^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'up'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:47:63:
   | 
47 | public func lookAt<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>
   |                                                               ^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'left'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:53:25:
   | 
53 | public func ortho<T, Q>(left: T, right: T, bottom: T, top: T): Mat4x4<T, Q>
   |                         ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'right'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:53:34:
   | 
53 | public func ortho<T, Q>(left: T, right: T, bottom: T, top: T): Mat4x4<T, Q>
   |                                  ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'bottom'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:53:44:
   | 
53 | public func ortho<T, Q>(left: T, right: T, bottom: T, top: T): Mat4x4<T, Q>
   |                                            ^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'top'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:53:55:
   | 
53 | public func ortho<T, Q>(left: T, right: T, bottom: T, top: T): Mat4x4<T, Q>
   |                                                       ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'left'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:57:25:
   | 
57 | public func ortho<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                         ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'right'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:57:34:
   | 
57 | public func ortho<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                  ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'bottom'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:57:44:
   | 
57 | public func ortho<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                            ^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'top'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:57:55:
   | 
57 | public func ortho<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                       ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:57:63:
   | 
57 | public func ortho<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                               ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:57:73:
   | 
57 | public func ortho<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                         ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'left'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:61:30:
   | 
61 | public func orthoLH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                              ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'right'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:61:39:
   | 
61 | public func orthoLH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                       ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'bottom'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:61:49:
   | 
61 | public func orthoLH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                 ^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'top'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:61:60:
   | 
61 | public func orthoLH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                            ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:61:68:
   | 
61 | public func orthoLH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                    ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:61:78:
   | 
61 | public func orthoLH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                              ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'left'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:65:30:
   | 
65 | public func orthoLH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                              ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'right'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:65:39:
   | 
65 | public func orthoLH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                       ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'bottom'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:65:49:
   | 
65 | public func orthoLH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                 ^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'top'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:65:60:
   | 
65 | public func orthoLH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                            ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:65:68:
   | 
65 | public func orthoLH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                    ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:65:78:
   | 
65 | public func orthoLH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                              ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'left'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:69:30:
   | 
69 | public func orthoRH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                              ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'right'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:69:39:
   | 
69 | public func orthoRH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                       ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'bottom'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:69:49:
   | 
69 | public func orthoRH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                 ^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'top'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:69:60:
   | 
69 | public func orthoRH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                            ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:69:68:
   | 
69 | public func orthoRH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                    ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:69:78:
   | 
69 | public func orthoRH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                              ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'left'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:73:30:
   | 
73 | public func orthoRH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                              ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'right'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:73:39:
   | 
73 | public func orthoRH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                       ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'bottom'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:73:49:
   | 
73 | public func orthoRH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                 ^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'top'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:73:60:
   | 
73 | public func orthoRH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                            ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:73:68:
   | 
73 | public func orthoRH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                    ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:73:78:
   | 
73 | public func orthoRH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                              ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'left'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:77:27:
   | 
77 | public func orthoZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                           ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'right'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:77:36:
   | 
77 | public func orthoZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                    ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'bottom'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:77:46:
   | 
77 | public func orthoZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                              ^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'top'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:77:57:
   | 
77 | public func orthoZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                         ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:77:65:
   | 
77 | public func orthoZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                 ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:77:75:
   | 
77 | public func orthoZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                           ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'left'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:81:27:
   | 
81 | public func orthoNO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                           ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'right'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:81:36:
   | 
81 | public func orthoNO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                    ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'bottom'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:81:46:
   | 
81 | public func orthoNO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                              ^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'top'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:81:57:
   | 
81 | public func orthoNO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                         ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:81:65:
   | 
81 | public func orthoNO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                 ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:81:75:
   | 
81 | public func orthoNO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                           ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'left'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:85:27:
   | 
85 | public func orthoLH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                           ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'right'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:85:36:
   | 
85 | public func orthoLH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                    ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'bottom'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:85:46:
   | 
85 | public func orthoLH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                              ^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'top'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:85:57:
   | 
85 | public func orthoLH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                         ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:85:65:
   | 
85 | public func orthoLH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                 ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:85:75:
   | 
85 | public func orthoLH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                           ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'left'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:89:27:
   | 
89 | public func orthoRH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                           ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'right'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:89:36:
   | 
89 | public func orthoRH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                    ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'bottom'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:89:46:
   | 
89 | public func orthoRH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                              ^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'top'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:89:57:
   | 
89 | public func orthoRH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                         ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:89:65:
   | 
89 | public func orthoRH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                 ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:89:75:
   | 
89 | public func orthoRH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                           ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'left'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:95:27:
   | 
95 | public func frustum<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                           ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'right'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:95:36:
   | 
95 | public func frustum<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                    ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'bottom'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:95:46:
   | 
95 | public func frustum<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                              ^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'top'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:95:57:
   | 
95 | public func frustum<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                         ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:95:65:
   | 
95 | public func frustum<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                 ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:95:75:
   | 
95 | public func frustum<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                           ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'left'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:99:32:
   | 
99 | public func frustumLH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'right'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:99:41:
   | 
99 | public func frustumLH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                         ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'bottom'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:99:51:
   | 
99 | public func frustumLH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                   ^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'top'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:99:62:
   | 
99 | public func frustumLH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                              ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:99:70:
   | 
99 | public func frustumLH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                      ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:99:80:
   | 
99 | public func frustumLH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
   |                                                                                ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'left'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:103:32:
    | 
103 | public func frustumLH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'right'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:103:41:
    | 
103 | public func frustumLH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                         ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'bottom'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:103:51:
    | 
103 | public func frustumLH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                   ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'top'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:103:62:
    | 
103 | public func frustumLH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                              ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:103:70:
    | 
103 | public func frustumLH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                      ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:103:80:
    | 
103 | public func frustumLH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                                ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'left'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:107:32:
    | 
107 | public func frustumRH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'right'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:107:41:
    | 
107 | public func frustumRH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                         ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'bottom'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:107:51:
    | 
107 | public func frustumRH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                   ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'top'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:107:62:
    | 
107 | public func frustumRH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                              ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:107:70:
    | 
107 | public func frustumRH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                      ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:107:80:
    | 
107 | public func frustumRH_ZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                                ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'left'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:111:32:
    | 
111 | public func frustumRH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'right'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:111:41:
    | 
111 | public func frustumRH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                         ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'bottom'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:111:51:
    | 
111 | public func frustumRH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                   ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'top'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:111:62:
    | 
111 | public func frustumRH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                              ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:111:70:
    | 
111 | public func frustumRH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                      ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:111:80:
    | 
111 | public func frustumRH_NO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                                ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'left'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:115:29:
    | 
115 | public func frustumZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'right'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:115:38:
    | 
115 | public func frustumZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                      ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'bottom'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:115:48:
    | 
115 | public func frustumZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'top'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:115:59:
    | 
115 | public func frustumZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                           ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:115:67:
    | 
115 | public func frustumZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                   ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:115:77:
    | 
115 | public func frustumZO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'left'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:119:29:
    | 
119 | public func frustumNO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'right'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:119:38:
    | 
119 | public func frustumNO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                      ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'bottom'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:119:48:
    | 
119 | public func frustumNO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'top'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:119:59:
    | 
119 | public func frustumNO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                           ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:119:67:
    | 
119 | public func frustumNO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                   ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:119:77:
    | 
119 | public func frustumNO<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'left'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:123:29:
    | 
123 | public func frustumLH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'right'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:123:38:
    | 
123 | public func frustumLH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                      ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'bottom'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:123:48:
    | 
123 | public func frustumLH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'top'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:123:59:
    | 
123 | public func frustumLH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                           ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:123:67:
    | 
123 | public func frustumLH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                   ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:123:77:
    | 
123 | public func frustumLH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'left'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:127:29:
    | 
127 | public func frustumRH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'right'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:127:38:
    | 
127 | public func frustumRH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                      ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'bottom'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:127:48:
    | 
127 | public func frustumRH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'top'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:127:59:
    | 
127 | public func frustumRH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                           ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:127:67:
    | 
127 | public func frustumRH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                   ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:127:77:
    | 
127 | public func frustumRH<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:133:31:
    | 
133 | public func perspective<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                               ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:133:40:
    | 
133 | public func perspective<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                        ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:133:51:
    | 
133 | public func perspective<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                   ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:133:61:
    | 
133 | public func perspective<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:137:36:
    | 
137 | public func perspectiveLH_ZO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                    ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:137:45:
    | 
137 | public func perspectiveLH_ZO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                             ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:137:56:
    | 
137 | public func perspectiveLH_ZO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                        ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:137:66:
    | 
137 | public func perspectiveLH_ZO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                  ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:141:36:
    | 
141 | public func perspectiveLH_NO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                    ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:141:45:
    | 
141 | public func perspectiveLH_NO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                             ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:141:56:
    | 
141 | public func perspectiveLH_NO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                        ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:141:66:
    | 
141 | public func perspectiveLH_NO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                  ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:145:36:
    | 
145 | public func perspectiveRH_ZO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                    ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:145:45:
    | 
145 | public func perspectiveRH_ZO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                             ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:145:56:
    | 
145 | public func perspectiveRH_ZO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                        ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:145:66:
    | 
145 | public func perspectiveRH_ZO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                  ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:149:36:
    | 
149 | public func perspectiveRH_NO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                    ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:149:45:
    | 
149 | public func perspectiveRH_NO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                             ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:149:56:
    | 
149 | public func perspectiveRH_NO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                        ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:149:66:
    | 
149 | public func perspectiveRH_NO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                  ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:153:33:
    | 
153 | public func perspectiveZO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                 ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:153:42:
    | 
153 | public func perspectiveZO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                          ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:153:53:
    | 
153 | public func perspectiveZO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                     ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:153:63:
    | 
153 | public func perspectiveZO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                               ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:157:33:
    | 
157 | public func perspectiveNO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                 ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:157:42:
    | 
157 | public func perspectiveNO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                          ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:157:53:
    | 
157 | public func perspectiveNO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                     ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:157:63:
    | 
157 | public func perspectiveNO<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                               ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:161:33:
    | 
161 | public func perspectiveLH<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                 ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:161:42:
    | 
161 | public func perspectiveLH<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                          ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:161:53:
    | 
161 | public func perspectiveLH<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                     ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:161:63:
    | 
161 | public func perspectiveLH<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                               ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:165:33:
    | 
165 | public func perspectiveRH<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                 ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:165:42:
    | 
165 | public func perspectiveRH<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                          ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:165:53:
    | 
165 | public func perspectiveRH<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                     ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:165:63:
    | 
165 | public func perspectiveRH<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                               ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:171:34:
    | 
171 | public func perspectiveFov<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                  ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'width'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:171:43:
    | 
171 | public func perspectiveFov<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                           ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'height'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:171:53:
    | 
171 | public func perspectiveFov<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                     ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:171:64:
    | 
171 | public func perspectiveFov<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:171:74:
    | 
171 | public func perspectiveFov<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                          ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:175:39:
    | 
175 | public func perspectiveFovLH_ZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'width'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:175:48:
    | 
175 | public func perspectiveFovLH_ZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'height'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:175:58:
    | 
175 | public func perspectiveFovLH_ZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                          ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:175:69:
    | 
175 | public func perspectiveFovLH_ZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                     ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:175:79:
    | 
175 | public func perspectiveFovLH_ZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                               ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:179:39:
    | 
179 | public func perspectiveFovLH_NO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'width'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:179:48:
    | 
179 | public func perspectiveFovLH_NO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'height'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:179:58:
    | 
179 | public func perspectiveFovLH_NO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                          ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:179:69:
    | 
179 | public func perspectiveFovLH_NO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                     ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:179:79:
    | 
179 | public func perspectiveFovLH_NO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                               ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:183:39:
    | 
183 | public func perspectiveFovRH_ZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'width'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:183:48:
    | 
183 | public func perspectiveFovRH_ZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'height'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:183:58:
    | 
183 | public func perspectiveFovRH_ZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                          ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:183:69:
    | 
183 | public func perspectiveFovRH_ZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                     ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:183:79:
    | 
183 | public func perspectiveFovRH_ZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                               ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:187:39:
    | 
187 | public func perspectiveFovRH_NO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'width'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:187:48:
    | 
187 | public func perspectiveFovRH_NO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'height'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:187:58:
    | 
187 | public func perspectiveFovRH_NO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                          ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:187:69:
    | 
187 | public func perspectiveFovRH_NO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                     ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:187:79:
    | 
187 | public func perspectiveFovRH_NO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                               ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:191:36:
    | 
191 | public func perspectiveFovZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                    ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'width'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:191:45:
    | 
191 | public func perspectiveFovZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                             ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'height'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:191:55:
    | 
191 | public func perspectiveFovZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                       ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:191:66:
    | 
191 | public func perspectiveFovZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                  ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:191:76:
    | 
191 | public func perspectiveFovZO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                            ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:195:36:
    | 
195 | public func perspectiveFovNO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                    ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'width'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:195:45:
    | 
195 | public func perspectiveFovNO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                             ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'height'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:195:55:
    | 
195 | public func perspectiveFovNO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                       ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:195:66:
    | 
195 | public func perspectiveFovNO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                  ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:195:76:
    | 
195 | public func perspectiveFovNO<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                            ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:199:36:
    | 
199 | public func perspectiveFovLH<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                    ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'width'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:199:45:
    | 
199 | public func perspectiveFovLH<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                             ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'height'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:199:55:
    | 
199 | public func perspectiveFovLH<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                       ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:199:66:
    | 
199 | public func perspectiveFovLH<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                  ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:199:76:
    | 
199 | public func perspectiveFovLH<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                            ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:203:36:
    | 
203 | public func perspectiveFovRH<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                    ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'width'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:203:45:
    | 
203 | public func perspectiveFovRH<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                             ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'height'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:203:55:
    | 
203 | public func perspectiveFovRH<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                       ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:203:66:
    | 
203 | public func perspectiveFovRH<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                  ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:203:76:
    | 
203 | public func perspectiveFovRH<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q>
    |                                                                            ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:209:39:
    | 
209 | public func infinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:209:48:
    | 
209 | public func infinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                                ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:209:59:
    | 
209 | public func infinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                                           ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:213:44:
    | 
213 | public func infinitePerspectiveLH_ZO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                            ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:213:53:
    | 
213 | public func infinitePerspectiveLH_ZO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                                     ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:213:64:
    | 
213 | public func infinitePerspectiveLH_ZO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                                                ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:217:44:
    | 
217 | public func infinitePerspectiveLH_NO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                            ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:217:53:
    | 
217 | public func infinitePerspectiveLH_NO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                                     ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:217:64:
    | 
217 | public func infinitePerspectiveLH_NO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                                                ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:221:44:
    | 
221 | public func infinitePerspectiveRH_ZO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                            ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:221:53:
    | 
221 | public func infinitePerspectiveRH_ZO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                                     ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:221:64:
    | 
221 | public func infinitePerspectiveRH_ZO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                                                ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:225:44:
    | 
225 | public func infinitePerspectiveRH_NO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                            ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:225:53:
    | 
225 | public func infinitePerspectiveRH_NO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                                     ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:225:64:
    | 
225 | public func infinitePerspectiveRH_NO<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                                                ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:229:41:
    | 
229 | public func infinitePerspectiveLH<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                         ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:229:50:
    | 
229 | public func infinitePerspectiveLH<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                                  ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:229:61:
    | 
229 | public func infinitePerspectiveLH<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                                             ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:233:41:
    | 
233 | public func infinitePerspectiveRH<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                         ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:233:50:
    | 
233 | public func infinitePerspectiveRH<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                                  ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:233:61:
    | 
233 | public func infinitePerspectiveRH<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                                             ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:239:46:
    | 
239 | public func tweakedInfinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T, ep: T): Mat4x4<T, Q>
    |                                              ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:239:55:
    | 
239 | public func tweakedInfinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T, ep: T): Mat4x4<T, Q>
    |                                                       ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:239:66:
    | 
239 | public func tweakedInfinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T, ep: T): Mat4x4<T, Q>
    |                                                                  ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'ep'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:239:76:
    | 
239 | public func tweakedInfinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T, ep: T): Mat4x4<T, Q>
    |                                                                            ^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'fovy'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:243:46:
    | 
243 | public func tweakedInfinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                              ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'aspect'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:243:55:
    | 
243 | public func tweakedInfinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                                       ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:243:66:
    | 
243 | public func tweakedInfinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q>
    |                                                                  ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'obj'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:249:29:
    | 
249 | public func projectZO<T, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                             ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'model'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:249:46:
    | 
249 | public func projectZO<T, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                              ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'proj'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:249:67:
    | 
249 | public func projectZO<T, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                                                   ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'viewport'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:249:87:
    | 
249 | public func projectZO<T, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                                                                       ^^^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'obj'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:253:29:
    | 
253 | public func projectNO<T, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                             ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'model'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:253:46:
    | 
253 | public func projectNO<T, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                              ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'proj'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:253:67:
    | 
253 | public func projectNO<T, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                                                   ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'viewport'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:253:87:
    | 
253 | public func projectNO<T, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                                                                       ^^^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'obj'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:257:27:
    | 
257 | public func project<T, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                           ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'model'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:257:44:
    | 
257 | public func project<T, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                            ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'proj'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:257:65:
    | 
257 | public func project<T, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                                                 ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'viewport'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:257:85:
    | 
257 | public func project<T, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                                                                     ^^^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'win'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:261:31:
    | 
261 | public func unProjectZO<T, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                               ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'model'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:261:48:
    | 
261 | public func unProjectZO<T, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                                ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'proj'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:261:69:
    | 
261 | public func unProjectZO<T, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                                                     ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'viewport'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:261:89:
    | 
261 | public func unProjectZO<T, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                                                                         ^^^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'win'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:265:31:
    | 
265 | public func unProjectNO<T, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                               ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'model'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:265:48:
    | 
265 | public func unProjectNO<T, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                                ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'proj'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:265:69:
    | 
265 | public func unProjectNO<T, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                                                     ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'viewport'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:265:89:
    | 
265 | public func unProjectNO<T, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                                                                         ^^^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'win'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:269:29:
    | 
269 | public func unProject<T, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                             ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'model'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:269:46:
    | 
269 | public func unProject<T, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                              ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'proj'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:269:67:
    | 
269 | public func unProject<T, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                                                   ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'viewport'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:269:87:
    | 
269 | public func unProject<T, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<T, Q>): Vec3<T, Q>
    |                                                                                       ^^^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'center'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:275:30:
    | 
275 | public func pickMatrix<T, Q>(center: Vec2<T, Q>, delta: Vec2<T, Q>, viewport: Vec4<T, Q>): Mat4x4<T, Q>
    |                              ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'delta'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:275:50:
    | 
275 | public func pickMatrix<T, Q>(center: Vec2<T, Q>, delta: Vec2<T, Q>, viewport: Vec4<T, Q>): Mat4x4<T, Q>
    |                                                  ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'viewport'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:275:69:
    | 
275 | public func pickMatrix<T, Q>(center: Vec2<T, Q>, delta: Vec2<T, Q>, viewport: Vec4<T, Q>): Mat4x4<T, Q>
    |                                                                     ^^^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

285 warnings generated, 285 warnings printed.
warning: imported decl 'Mat2x2' is conflicted with other import
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_float2x2.cj:2:26:
  | 
2 | public import glm.detail.Mat2x2
  |                          ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note: The previous was imported here
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_double2x2.cj:2:26:
  | 
2 | public import glm.detail.Mat2x2
  |                          ^^^^^^ 
  | 

warning: imported decl 'Mat2x3' is conflicted with other import
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_float2x3.cj:2:26:
  | 
2 | public import glm.detail.Mat2x3
  |                          ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note: The previous was imported here
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_double2x3.cj:2:26:
  | 
2 | public import glm.detail.Mat2x3
  |                          ^^^^^^ 
  | 

warning: imported decl 'Mat2x4' is conflicted with other import
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_float2x4.cj:2:26:
  | 
2 | public import glm.detail.Mat2x4
  |                          ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note: The previous was imported here
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_double2x4.cj:2:26:
  | 
2 | public import glm.detail.Mat2x4
  |                          ^^^^^^ 
  | 

warning: imported decl 'Mat3x2' is conflicted with other import
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_float3x2.cj:2:26:
  | 
2 | public import glm.detail.Mat3x2
  |                          ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note: The previous was imported here
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_double3x2.cj:2:26:
  | 
2 | public import glm.detail.Mat3x2
  |                          ^^^^^^ 
  | 

warning: imported decl 'Mat3x3' is conflicted with other import
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_float3x3.cj:2:26:
  | 
2 | public import glm.detail.Mat3x3
  |                          ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note: The previous was imported here
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_double3x3.cj:2:26:
  | 
2 | public import glm.detail.Mat3x3
  |                          ^^^^^^ 
  | 

warning: imported decl 'Mat3x4' is conflicted with other import
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_float3x4.cj:2:26:
  | 
2 | public import glm.detail.Mat3x4
  |                          ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note: The previous was imported here
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_double3x4.cj:2:26:
  | 
2 | public import glm.detail.Mat3x4
  |                          ^^^^^^ 
  | 

warning: imported decl 'Mat4x2' is conflicted with other import
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_float4x2.cj:2:26:
  | 
2 | public import glm.detail.Mat4x2
  |                          ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note: The previous was imported here
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_double4x2.cj:2:26:
  | 
2 | public import glm.detail.Mat4x2
  |                          ^^^^^^ 
  | 

warning: imported decl 'Mat4x3' is conflicted with other import
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_float4x3.cj:2:26:
  | 
2 | public import glm.detail.Mat4x3
  |                          ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note: The previous was imported here
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_double4x3.cj:2:26:
  | 
2 | public import glm.detail.Mat4x3
  |                          ^^^^^^ 
  | 

warning: imported decl 'Mat4x4' is conflicted with other import
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_float4x4.cj:2:26:
  | 
2 | public import glm.detail.Mat4x4
  |                          ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note: The previous was imported here
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_double4x4.cj:2:26:
  | 
2 | public import glm.detail.Mat4x4
  |                          ^^^^^^ 
  | 

warning: imported decl 'Vec1' is conflicted with other import
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_float1.cj:2:26:
  | 
2 | public import glm.detail.Vec1
  |                          ^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note: The previous was imported here
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_double1.cj:2:26:
  | 
2 | public import glm.detail.Vec1
  |                          ^^^^ 
  | 

warning: imported decl 'Vec2' is conflicted with other import
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_float2.cj:2:26:
  | 
2 | public import glm.detail.Vec2
  |                          ^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note: The previous was imported here
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_double2.cj:2:26:
  | 
2 | public import glm.detail.Vec2
  |                          ^^^^ 
  | 

warning: imported decl 'Vec3' is conflicted with other import
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_float3.cj:2:26:
  | 
2 | public import glm.detail.Vec3
  |                          ^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note: The previous was imported here
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_double3.cj:2:26:
  | 
2 | public import glm.detail.Vec3
  |                          ^^^^ 
  | 

warning: imported decl 'Vec4' is conflicted with other import
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_float4.cj:2:26:
  | 
2 | public import glm.detail.Vec4
  |                          ^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note: The previous was imported here
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_double4.cj:2:26:
  | 
2 | public import glm.detail.Vec4
  |                          ^^^^ 
  | 

warning: unused variable:'q'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_exponential.cj:4:23:
  | 
4 | public func exp<T, Q>(q: Quat<T, Q>): Quat<T, Q>
  |                       ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'left'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_clip_space.cj:4:25:
  | 
4 | public func ortho<T, Q>(left: T, right: T, bottom: T, top: T): Mat4x4<T, Q>
  |                         ^^^^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'q'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_transform.cj:4:26:
  | 
4 | public func rotate<T, Q>(q: Quat<T, Q>, angle: T, axis: Vec3<T, Q>): Quat<T, Q>
  |                          ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'m'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_transform.cj:4:29:
  | 
4 | public func translate<T, Q>(m: Mat4x4<T, Q>, v: Vec3<T, Q>): Mat4x4<T, Q>
  |                             ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'fovy'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_projection.cj:4:31:
  | 
4 | public func perspective<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
  |                               ^^^^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'right'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_clip_space.cj:4:34:
  | 
4 | public func ortho<T, Q>(left: T, right: T, bottom: T, top: T): Mat4x4<T, Q>
  |                                  ^^^^^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'aspect'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_projection.cj:4:40:
  | 
4 | public func perspective<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
  |                                        ^^^^^^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'angle'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_transform.cj:4:41:
  | 
4 | public func rotate<T, Q>(q: Quat<T, Q>, angle: T, axis: Vec3<T, Q>): Quat<T, Q>
  |                                         ^^^^^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'bottom'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_clip_space.cj:4:44:
  | 
4 | public func ortho<T, Q>(left: T, right: T, bottom: T, top: T): Mat4x4<T, Q>
  |                                            ^^^^^^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'v'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_transform.cj:4:46:
  | 
4 | public func translate<T, Q>(m: Mat4x4<T, Q>, v: Vec3<T, Q>): Mat4x4<T, Q>
  |                                              ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'axis'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_transform.cj:4:51:
  | 
4 | public func rotate<T, Q>(q: Quat<T, Q>, angle: T, axis: Vec3<T, Q>): Quat<T, Q>
  |                                                   ^^^^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zNear'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_projection.cj:4:51:
  | 
4 | public func perspective<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
  |                                                   ^^^^^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'top'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_clip_space.cj:4:55:
  | 
4 | public func ortho<T, Q>(left: T, right: T, bottom: T, top: T): Mat4x4<T, Q>
  |                                                       ^^^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_projection.cj:4:61:
  | 
4 | public func perspective<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q>
  |                                                             ^^^^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'q'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_exponential.cj:6:23:
  | 
6 | public func log<T, Q>(q: Quat<T, Q>): Quat<T, Q>
  |                       ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_exponential.cj:8:23:
  | 
8 | public func pow<T, Q>(x: Quat<T, Q>, y: T): Quat<T, Q>
  |                       ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'y'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_exponential.cj:8:38:
  | 
8 | public func pow<T, Q>(x: Quat<T, Q>, y: T): Quat<T, Q>
  |                                      ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_exponential.cj:10:24:
   | 
10 | public func sqrt<T, Q>(x: Quat<T, Q>): Quat<T, Q>
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_trigonometric.cj:23:25:
   | 
23 | public func angle<T, Q>(x: Quat<T, Q>): T
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'angle'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_trigonometric.cj:26:29:
   | 
26 | public func angleAxis<T, Q>(angle: T, axis: Vec3<T, Q>): Quat<T, Q>
   |                             ^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'axis'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_trigonometric.cj:26:39:
   | 
26 | public func angleAxis<T, Q>(angle: T, axis: Vec3<T, Q>): Quat<T, Q>
   |                                       ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_common.cj:34:23:
   | 
34 | public func mix<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T): Quat<T, Q>
   |                       ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'y'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_common.cj:34:38:
   | 
34 | public func mix<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T): Quat<T, Q>
   |                                      ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'a'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_common.cj:34:53:
   | 
34 | public func mix<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T): Quat<T, Q>
   |                                                     ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_common.cj:37:25:
   | 
37 | public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T): Quat<T, Q>
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'y'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_common.cj:37:40:
   | 
37 | public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T): Quat<T, Q>
   |                                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'a'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_common.cj:37:55:
   | 
37 | public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T): Quat<T, Q>
   |                                                       ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_common.cj:40:25:
   | 
40 | public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T, spin: Bool): Quat<T, Q>
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'y'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_common.cj:40:40:
   | 
40 | public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T, spin: Bool): Quat<T, Q>
   |                                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'a'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_common.cj:40:55:
   | 
40 | public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T, spin: Bool): Quat<T, Q>
   |                                                       ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'spin'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_common.cj:40:61:
   | 
40 | public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T, spin: Bool): Quat<T, Q>
   |                                                             ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:199:25:
    | 
199 | public func equal<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Int64): Vec1<Bool, Q>
    |                         ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:199:40:
    | 
199 | public func equal<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Int64): Vec1<Bool, Q>
    |                                        ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:199:55:
    | 
199 | public func equal<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Int64): Vec1<Bool, Q>
    |                                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:202:25:
    | 
202 | public func equal<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Vec1<Int64, Q>): Vec1<Bool, Q>
    |                         ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:202:40:
    | 
202 | public func equal<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Vec1<Int64, Q>): Vec1<Bool, Q>
    |                                        ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:202:55:
    | 
202 | public func equal<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Vec1<Int64, Q>): Vec1<Bool, Q>
    |                                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:205:28:
    | 
205 | public func notEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Int64): Vec1<Bool, Q>
    |                            ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:205:43:
    | 
205 | public func notEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Int64): Vec1<Bool, Q>
    |                                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:205:58:
    | 
205 | public func notEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Int64): Vec1<Bool, Q>
    |                                                          ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:208:28:
    | 
208 | public func notEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Vec1<Int64, Q>): Vec1<Bool, Q>
    |                            ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:208:43:
    | 
208 | public func notEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Vec1<Int64, Q>): Vec1<Bool, Q>
    |                                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:208:58:
    | 
208 | public func notEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Vec1<Int64, Q>): Vec1<Bool, Q>
    |                                                          ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:213:25:
    | 
213 | public func equal<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Int64): Vec2<Bool, Q>
    |                         ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:213:40:
    | 
213 | public func equal<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Int64): Vec2<Bool, Q>
    |                                        ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:213:55:
    | 
213 | public func equal<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Int64): Vec2<Bool, Q>
    |                                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:216:25:
    | 
216 | public func equal<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Vec2<Int64, Q>): Vec2<Bool, Q>
    |                         ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:216:40:
    | 
216 | public func equal<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Vec2<Int64, Q>): Vec2<Bool, Q>
    |                                        ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:216:55:
    | 
216 | public func equal<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Vec2<Int64, Q>): Vec2<Bool, Q>
    |                                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:219:28:
    | 
219 | public func notEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Int64): Vec2<Bool, Q>
    |                            ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:219:43:
    | 
219 | public func notEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Int64): Vec2<Bool, Q>
    |                                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:219:58:
    | 
219 | public func notEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Int64): Vec2<Bool, Q>
    |                                                          ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:222:28:
    | 
222 | public func notEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Vec2<Int64, Q>): Vec2<Bool, Q>
    |                            ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:222:43:
    | 
222 | public func notEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Vec2<Int64, Q>): Vec2<Bool, Q>
    |                                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:222:58:
    | 
222 | public func notEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Vec2<Int64, Q>): Vec2<Bool, Q>
    |                                                          ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:227:25:
    | 
227 | public func equal<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Int64): Vec3<Bool, Q>
    |                         ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:227:40:
    | 
227 | public func equal<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Int64): Vec3<Bool, Q>
    |                                        ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:227:55:
    | 
227 | public func equal<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Int64): Vec3<Bool, Q>
    |                                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:230:25:
    | 
230 | public func equal<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Vec3<Int64, Q>): Vec3<Bool, Q>
    |                         ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:230:40:
    | 
230 | public func equal<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Vec3<Int64, Q>): Vec3<Bool, Q>
    |                                        ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:230:55:
    | 
230 | public func equal<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Vec3<Int64, Q>): Vec3<Bool, Q>
    |                                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:233:28:
    | 
233 | public func notEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Int64): Vec3<Bool, Q>
    |                            ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:233:43:
    | 
233 | public func notEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Int64): Vec3<Bool, Q>
    |                                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:233:58:
    | 
233 | public func notEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Int64): Vec3<Bool, Q>
    |                                                          ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:236:28:
    | 
236 | public func notEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Vec3<Int64, Q>): Vec3<Bool, Q>
    |                            ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:236:43:
    | 
236 | public func notEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Vec3<Int64, Q>): Vec3<Bool, Q>
    |                                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:236:58:
    | 
236 | public func notEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Vec3<Int64, Q>): Vec3<Bool, Q>
    |                                                          ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:241:25:
    | 
241 | public func equal<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Int64): Vec4<Bool, Q>
    |                         ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:241:40:
    | 
241 | public func equal<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Int64): Vec4<Bool, Q>
    |                                        ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:241:55:
    | 
241 | public func equal<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Int64): Vec4<Bool, Q>
    |                                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:244:25:
    | 
244 | public func equal<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Vec4<Int64, Q>): Vec4<Bool, Q>
    |                         ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:244:40:
    | 
244 | public func equal<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Vec4<Int64, Q>): Vec4<Bool, Q>
    |                                        ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:244:55:
    | 
244 | public func equal<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Vec4<Int64, Q>): Vec4<Bool, Q>
    |                                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:247:28:
    | 
247 | public func notEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Int64): Vec4<Bool, Q>
    |                            ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:247:43:
    | 
247 | public func notEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Int64): Vec4<Bool, Q>
    |                                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:247:58:
    | 
247 | public func notEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Int64): Vec4<Bool, Q>
    |                                                          ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:250:28:
    | 
250 | public func notEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Vec4<Int64, Q>): Vec4<Bool, Q>
    |                            ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:250:43:
    | 
250 | public func notEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Vec4<Int64, Q>): Vec4<Bool, Q>
    |                                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:250:58:
    | 
250 | public func notEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Vec4<Int64, Q>): Vec4<Bool, Q>
    |                                                          ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

92 warnings generated, 92 warnings printed.
warning: imported decl 'Vec1' is shadowed, it will be ignored by compiler
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:2:28:
  | 
2 | public import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }
  |                            ^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note: 'Vec1' is declared here
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:105:13:
    | 
105 | public type Vec1 = detail.Vec1<Float32, PackedHighp>
    |             ^^^^ 
    | 

warning: imported decl 'Vec2' is shadowed, it will be ignored by compiler
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:2:34:
  | 
2 | public import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }
  |                                  ^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note: 'Vec2' is declared here
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:106:13:
    | 
106 | public type Vec2 = detail.Vec2<Float32, PackedHighp>
    |             ^^^^ 
    | 

warning: imported decl 'Vec3' is shadowed, it will be ignored by compiler
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:2:40:
  | 
2 | public import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }
  |                                        ^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note: 'Vec3' is declared here
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:107:13:
    | 
107 | public type Vec3 = detail.Vec3<Float32, PackedHighp>
    |             ^^^^ 
    | 

warning: imported decl 'Vec4' is shadowed, it will be ignored by compiler
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:2:46:
  | 
2 | public import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }
  |                                              ^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note: 'Vec4' is declared here
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:108:13:
    | 
108 | public type Vec4 = detail.Vec4<Float32, PackedHighp>
    |             ^^^^ 
    | 

warning: unused import 'glm.detail.sin'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:20:
   | 
12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}
   |                    ^^^ unused import
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused import 'glm.detail.cos'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:25:
   | 
12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}
   |                         ^^^ unused import
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused import 'glm.detail.tan'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:30:
   | 
12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}
   |                              ^^^ unused import
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused import 'glm.detail.asin'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:35:
   | 
12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}
   |                                   ^^^^ unused import
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused import 'glm.detail.acos'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:41:
   | 
12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}
   |                                         ^^^^ unused import
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused import 'glm.detail.atan'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:47:
   | 
12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}
   |                                               ^^^^ unused import
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused import 'glm.detail.atan2'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:53:
   | 
12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}
   |                                                     ^^^^^ unused import
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused import 'glm.detail.sinh'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:60:
   | 
12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}
   |                                                            ^^^^ unused import
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused import 'glm.detail.cosh'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:66:
   | 
12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}
   |                                                                  ^^^^ unused import
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused import 'glm.detail.tanh'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:72:
   | 
12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}
   |                                                                        ^^^^ unused import
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused import 'glm.detail.asinh'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:78:
   | 
12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}
   |                                                                              ^^^^^ unused import
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused import 'glm.detail.acosh'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:85:
   | 
12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}
   |                                                                                     ^^^^^ unused import
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused import 'glm.detail.atanh'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:92:
   | 
12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}
   |                                                                                            ^^^^^ unused import
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused import 'glm.detail.radians'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:99:
   | 
12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}
   |                                                                                                   ^^^^^^^ unused import
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused import 'glm.detail.degrees'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:108:
   | 
12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}
   |                                                                                                            ^^^^^^^ unused import
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused import 'glm.ext.*'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:14:1:
   | 
14 | import glm.ext.*
   | ^^^^^^^^^^^^^^^^ unused import
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused import 'glm.gtc.*'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:16:1:
   | 
16 | import glm.gtc.*
   | ^^^^^^^^^^^^^^^^ unused import
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

21 warnings generated, 21 warnings printed.
[?25l78
78--------------------------------------------------------------------------------------------------
TP: glm.detail, time elapsed: 156233200 ns, RESULT:
    TCS: TestCase_testComputeVecAdd1, time elapsed: 1226300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAdd1 (242400 ns)
    TCS: TestCase_testComputeVecSub2, time elapsed: 316100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSub2 (33000 ns)
    TCS: TestCase_testComputeVecMul3, time elapsed: 317900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMul3 (36300 ns)
    TCS: TestCase_testComputeVecMod1, time elapsed: 280500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMod1 (24400 ns)
    TCS: TestCase_testComputeVecMod4, time elapsed: 317300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMod4 (35300 ns)
    TCS: TestCase_testComputeVecAnd1, time elapsed: 297600 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAnd1 (22000 ns)
    TCS: TestCase_testComputeVecAnd3, time elapsed: 275500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAnd3 (18000 ns)
    TCS: TestCase_testComputeVecOr1, time elapsed: 252100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecOr1 (21500 ns)
    TCS: TestCase_testComputeVecOr2, time elapsed: 252400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecOr2 (17100 ns)
    TCS: TestCase_testComputeVecXor1, time elapsed: 296200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecXor1 (65900 ns)
    TCS: TestCase_testComputeVecXor4, time elapsed: 256500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecXor4 (21200 ns)
    TCS: TestCase_testComputeVecShiftLeft1, time elapsed: 250200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftLeft1 (12800 ns)
    TCS: TestCase_testComputeVecShiftLeft3, time elapsed: 286800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftLeft3 (22800 ns)
    TCS: TestCase_testComputeVecShiftRight1, time elapsed: 321800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftRight1 (24900 ns)
    TCS: TestCase_testComputeVecShiftRight4, time elapsed: 2037700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftRight4 (124900 ns)
    TCS: TestCase_testComputeVecEqual1, time elapsed: 350700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual1 (30700 ns)
    TCS: TestCase_testComputeVecNequal4, time elapsed: 407600 ns, RESULT:
    [ PASSED ] CASE: testComputeVecNequal4 (28800 ns)
    TCS: TestCase_testComputeVecBitwiseNot1, time elapsed: 356100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecBitwiseNot1 (35600 ns)
    TCS: TestCase_testComputeVecBitwiseNot3, time elapsed: 355900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecBitwiseNot3 (33700 ns)
    TCS: TestCase_testComputeVecAdd4, time elapsed: 345800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAdd4 (36200 ns)
    TCS: TestCase_testComputeVecSub1, time elapsed: 1213600 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSub1 (33500 ns)
    TCS: TestCase_testComputeVecSub3, time elapsed: 468200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSub3 (48100 ns)
    TCS: TestCase_testComputeVecMul1, time elapsed: 324100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMul1 (25600 ns)
    TCS: TestCase_testComputeVecMul2, time elapsed: 348200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMul2 (31500 ns)
    TCS: TestCase_testComputeVecDiv1, time elapsed: 347900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecDiv1 (33200 ns)
    TCS: TestCase_testComputeVecDiv2, time elapsed: 298400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecDiv2 (25600 ns)
    TCS: TestCase_testComputeVecDiv4, time elapsed: 282700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecDiv4 (29100 ns)
    TCS: TestCase_testComputeVecEqual2, time elapsed: 292900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual2 (26400 ns)
    TCS: TestCase_testComputeVecEqual3, time elapsed: 297900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual3 (29400 ns)
    TCS: TestCase_testComputeVecEqual4, time elapsed: 276800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual4 (20800 ns)
    TCS: TestCase_testComputeVecNequal1, time elapsed: 256900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecNequal1 (18700 ns)
    TCS: TestCase_testComputeVecNequal2, time elapsed: 266800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecNequal2 (16600 ns)
    TCS: TestCase_testComputeVecBitwiseNot4, time elapsed: 297400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecBitwiseNot4 (45600 ns)
    TCS: TestCase_testComputeVecAddFloat32, time elapsed: 278400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAddFloat32 (46100 ns)
    TCS: TestCase_testComputeVecAddFloat32Vec3, time elapsed: 296800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAddFloat32Vec3 (35700 ns)
    TCS: TestCase_testComputeVecSubFloat32, time elapsed: 290600 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSubFloat32 (21500 ns)
    TCS: TestCase_testComputeVecSubFloat32Vec4, time elapsed: 306900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSubFloat32Vec4 (36400 ns)
    TCS: TestCase_testComputeEqualInt32Equal, time elapsed: 326600 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt32Equal (37400 ns)
    TCS: TestCase_testComputeEqualInt32NotEqual, time elapsed: 307100 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt32NotEqual (22600 ns)
    TCS: TestCase_testComputeEqualFloat32Equal, time elapsed: 293900 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32Equal (26200 ns)
    TCS: TestCase_testComputeEqualFloat32NotEqual, time elapsed: 286500 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32NotEqual (21400 ns)
    TCS: TestCase_testComputeEqualFloat64Equal, time elapsed: 296800 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64Equal (15200 ns)
    TCS: TestCase_testComputeEqualFloat64NotEqual, time elapsed: 306300 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64NotEqual (13600 ns)
    TCS: TestCase_testComputeEqualBoolEqual, time elapsed: 265300 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualBoolEqual (16100 ns)
    TCS: TestCase_testComputeEqualBoolNotEqual, time elapsed: 284100 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualBoolNotEqual (16300 ns)
    TCS: TestCase_testComputeEqualNumericInt32, time elapsed: 213200 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericInt32 (9500 ns)
    TCS: TestCase_testComputeEqualNumericFloat32, time elapsed: 255500 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32 (39900 ns)
    TCS: TestCase_testComputeEqualNumericFloat32Epsilon, time elapsed: 276800 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32Epsilon (15100 ns)
    TCS: TestCase_testComputeEqualNumericFloat64, time elapsed: 217700 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64 (15900 ns)
    TCS: TestCase_testComputeEqualInt64Equal, time elapsed: 218400 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt64Equal (12000 ns)
    TCS: TestCase_testComputeEqualInt64NotEqual, time elapsed: 195300 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt64NotEqual (7200 ns)
    TCS: TestCase_testComputeEqualFloat32Nan, time elapsed: 193200 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32Nan (7600 ns)
    TCS: TestCase_testComputeEqualFloat64Nan, time elapsed: 194400 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64Nan (11000 ns)
    TCS: TestCase_testComputeEqualFloat32SignedZero, time elapsed: 201600 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32SignedZero (9500 ns)
    TCS: TestCase_testComputeEqualFloat64SignedZero, time elapsed: 200500 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64SignedZero (10900 ns)
    TCS: TestCase_testComputeEqualNumericFloat32NotEqual, time elapsed: 329400 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32NotEqual (14800 ns)
    TCS: TestCase_testComputeEqualNumericFloat32BeyondEpsilon, time elapsed: 207100 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32BeyondEpsilon (14500 ns)
    TCS: TestCase_testComputeEqualNumericFloat64NotEqual, time elapsed: 201400 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64NotEqual (11500 ns)
    TCS: TestCase_testComputeEqualNumericFloat64Epsilon, time elapsed: 199800 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64Epsilon (10300 ns)
    TCS: TestCase_testComputeEqualNumericFloat64BeyondEpsilon, time elapsed: 396900 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64BeyondEpsilon (19000 ns)
    TCS: TestCase_testComputeEqualNumericInt64, time elapsed: 210700 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericInt64 (12500 ns)
    TCS: TestCase_testPackedHighpImplementsQualifier, time elapsed: 224400 ns, RESULT:
    [ PASSED ] CASE: testPackedHighpImplementsQualifier (8900 ns)
    TCS: TestCase_testPackedMediumpImplementsQualifier, time elapsed: 196700 ns, RESULT:
    [ PASSED ] CASE: testPackedMediumpImplementsQualifier (13100 ns)
    TCS: TestCase_testPackedLowpImplementsQualifier, time elapsed: 196200 ns, RESULT:
    [ PASSED ] CASE: testPackedLowpImplementsQualifier (8800 ns)
    TCS: TestCase_testDefaultpIsPackedHighp, time elapsed: 193700 ns, RESULT:
    [ PASSED ] CASE: testDefaultpIsPackedHighp (8900 ns)
    TCS: TestCase_testScalarAddVec1, time elapsed: 214000 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec1 (19600 ns)
    TCS: TestCase_testScalarAddVec2, time elapsed: 324900 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec2 (16300 ns)
    TCS: TestCase_testScalarAddVec3, time elapsed: 225300 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec3 (34200 ns)
    TCS: TestCase_testScalarAddVec4, time elapsed: 253900 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec4 (25400 ns)
    TCS: TestCase_testScalarSubVec1, time elapsed: 280300 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1 (29100 ns)
    TCS: TestCase_testScalarMulVec1, time elapsed: 262600 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1 (19800 ns)
    TCS: TestCase_testScalarDivVec1, time elapsed: 269000 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1 (24300 ns)
    TCS: TestCase_testScalarModVec1, time elapsed: 267600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1 (26100 ns)
    TCS: TestCase_testScalarMulVec2, time elapsed: 269900 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2 (24800 ns)
    TCS: TestCase_testScalarSubVec2, time elapsed: 226600 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2 (11600 ns)
    TCS: TestCase_testScalarSubVec3, time elapsed: 265400 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3 (23900 ns)
    TCS: TestCase_testScalarSubVec4, time elapsed: 280400 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4 (24600 ns)
    TCS: TestCase_testScalarMulVec3, time elapsed: 179800 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3 (8000 ns)
    TCS: TestCase_testScalarMulVec4, time elapsed: 191800 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4 (16500 ns)
    TCS: TestCase_testScalarDivVec2, time elapsed: 188600 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2 (11900 ns)
    TCS: TestCase_testScalarDivVec3, time elapsed: 225100 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3 (9200 ns)
    TCS: TestCase_testScalarDivVec4, time elapsed: 217500 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4 (18200 ns)
    TCS: TestCase_testScalarModVec2, time elapsed: 201200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2 (9300 ns)
    TCS: TestCase_testScalarModVec3, time elapsed: 217700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3 (16100 ns)
    TCS: TestCase_testScalarModVec4, time elapsed: 207600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4 (17200 ns)
    TCS: TestCase_testScalarModVec1Float32, time elapsed: 572200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Float32 (113600 ns)
    TCS: TestCase_testScalarModVec2Float32, time elapsed: 275300 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32 (12300 ns)
    TCS: TestCase_testScalarModVec3Float32, time elapsed: 219500 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Float32 (11400 ns)
    TCS: TestCase_testScalarModVec4Float32, time elapsed: 212900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Float32 (13900 ns)
    TCS: TestCase_testScalarModVec1Float64, time elapsed: 214800 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Float64 (19700 ns)
    TCS: TestCase_testScalarModVec2Float64, time elapsed: 206700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float64 (12400 ns)
    TCS: TestCase_testScalarModVec3Float64, time elapsed: 206600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Float64 (11500 ns)
    TCS: TestCase_testScalarModVec4Float64, time elapsed: 499600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Float64 (20200 ns)
    TCS: TestCase_testScalarModVec1Float16, time elapsed: 333700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Float16 (51700 ns)
    TCS: TestCase_testScalarModVec2Float16, time elapsed: 284700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float16 (18600 ns)
    TCS: TestCase_testScalarModVec3Float16, time elapsed: 281600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Float16 (21400 ns)
    TCS: TestCase_testScalarModVec4Float16, time elapsed: 399100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Float16 (12600 ns)
    TCS: TestCase_testScalarSubVec2PackedMediump, time elapsed: 373000 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2PackedMediump (24100 ns)
    TCS: TestCase_testScalarSubVec2PackedLowp, time elapsed: 222200 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2PackedLowp (14600 ns)
    TCS: TestCase_testScalarMulVec2PackedMediump, time elapsed: 222600 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2PackedMediump (13700 ns)
    TCS: TestCase_testScalarMulVec2PackedLowp, time elapsed: 216400 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2PackedLowp (16100 ns)
    TCS: TestCase_testScalarDivVec2PackedMediump, time elapsed: 190300 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2PackedMediump (9700 ns)
    TCS: TestCase_testScalarDivVec2PackedLowp, time elapsed: 191100 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2PackedLowp (10600 ns)
    TCS: TestCase_testScalarModVec2PackedMediump, time elapsed: 189100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2PackedMediump (10100 ns)
    TCS: TestCase_testScalarModVec2PackedLowp, time elapsed: 186400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2PackedLowp (8500 ns)
    TCS: TestCase_testScalarModVec2Float32PackedMediump, time elapsed: 198600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32PackedMediump (9100 ns)
    TCS: TestCase_testScalarModVec2Float32PackedLowp, time elapsed: 189800 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32PackedLowp (9600 ns)
    TCS: TestCase_testScalarModVec2Float32NegativeDividend, time elapsed: 190700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32NegativeDividend (8600 ns)
    TCS: TestCase_testScalarModVec2Float32NegativeDivisor, time elapsed: 312400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32NegativeDivisor (17800 ns)
    TCS: TestCase_testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents, time elapsed: 386900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents (180200 ns)
    TCS: TestCase_testScalarAddVec1Float32, time elapsed: 195600 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec1Float32 (14100 ns)
    TCS: TestCase_testScalarAddVec2Float32, time elapsed: 182500 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec2Float32 (12900 ns)
    TCS: TestCase_testScalarAddVec3Float32, time elapsed: 181600 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec3Float32 (10400 ns)
    TCS: TestCase_testScalarAddVec4Float32, time elapsed: 181100 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec4Float32 (10300 ns)
    TCS: TestCase_testScalarSubVec1Float32, time elapsed: 194000 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1Float32 (13500 ns)
    TCS: TestCase_testScalarSubVec2Float32, time elapsed: 181700 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2Float32 (11300 ns)
    TCS: TestCase_testScalarSubVec3Float32, time elapsed: 179400 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3Float32 (11600 ns)
    TCS: TestCase_testScalarSubVec4Float32, time elapsed: 175400 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4Float32 (9000 ns)
    TCS: TestCase_testScalarMulVec1Float32, time elapsed: 194500 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1Float32 (8500 ns)
    TCS: TestCase_testScalarMulVec2Float32, time elapsed: 181000 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2Float32 (9000 ns)
    TCS: TestCase_testScalarMulVec3Float32, time elapsed: 186700 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3Float32 (8300 ns)
    TCS: TestCase_testScalarMulVec4Float32, time elapsed: 197600 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4Float32 (8800 ns)
    TCS: TestCase_testScalarDivVec1Float32, time elapsed: 185700 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1Float32 (9400 ns)
    TCS: TestCase_testScalarDivVec2Float32, time elapsed: 188500 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2Float32 (9100 ns)
    TCS: TestCase_testScalarDivVec3Float32, time elapsed: 182200 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3Float32 (8400 ns)
    TCS: TestCase_testScalarDivVec4Float32, time elapsed: 183300 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4Float32 (8300 ns)
    TCS: TestCase_testScalarAddVec1Int32, time elapsed: 210400 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec1Int32 (12600 ns)
    TCS: TestCase_testScalarAddVec2Int32, time elapsed: 191400 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec2Int32 (9200 ns)
    TCS: TestCase_testScalarAddVec3Int32, time elapsed: 189700 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec3Int32 (9200 ns)
    TCS: TestCase_testScalarAddVec4Int32, time elapsed: 189800 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec4Int32 (9300 ns)
    TCS: TestCase_testScalarSubVec1Int32, time elapsed: 186800 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1Int32 (11700 ns)
    TCS: TestCase_testScalarSubVec2Int32, time elapsed: 185500 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2Int32 (9000 ns)
    TCS: TestCase_testScalarSubVec3Int32, time elapsed: 189700 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3Int32 (14300 ns)
    TCS: TestCase_testScalarSubVec4Int32, time elapsed: 186000 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4Int32 (9400 ns)
    TCS: TestCase_testScalarMulVec1Int32, time elapsed: 191300 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1Int32 (10300 ns)
    TCS: TestCase_testScalarMulVec2Int32, time elapsed: 192800 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2Int32 (9800 ns)
    TCS: TestCase_testScalarMulVec3Int32, time elapsed: 187600 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3Int32 (8200 ns)
    TCS: TestCase_testScalarMulVec4Int32, time elapsed: 184800 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4Int32 (7800 ns)
    TCS: TestCase_testScalarDivVec1Int32, time elapsed: 186900 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1Int32 (8100 ns)
    TCS: TestCase_testScalarDivVec2Int32, time elapsed: 194600 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2Int32 (11800 ns)
    TCS: TestCase_testScalarDivVec3Int32, time elapsed: 189300 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3Int32 (9700 ns)
    TCS: TestCase_testScalarDivVec4Int32, time elapsed: 182000 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4Int32 (9500 ns)
    TCS: TestCase_testScalarModVec1Int32, time elapsed: 192600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Int32 (9400 ns)
    TCS: TestCase_testScalarModVec2Int32, time elapsed: 227100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Int32 (8000 ns)
    TCS: TestCase_testScalarModVec3Int32, time elapsed: 195700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Int32 (12000 ns)
    TCS: TestCase_testScalarModVec4Int32, time elapsed: 189100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Int32 (8500 ns)
    TCS: TestCase_testScalarSubVec1PackedMediump, time elapsed: 189100 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1PackedMediump (10500 ns)
    TCS: TestCase_testScalarSubVec1PackedLowp, time elapsed: 186600 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1PackedLowp (8700 ns)
    TCS: TestCase_testScalarSubVec3PackedMediump, time elapsed: 187400 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3PackedMediump (9300 ns)
    TCS: TestCase_testScalarSubVec3PackedLowp, time elapsed: 195200 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3PackedLowp (11700 ns)
    TCS: TestCase_testScalarSubVec4PackedMediump, time elapsed: 190600 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4PackedMediump (10200 ns)
    TCS: TestCase_testScalarSubVec4PackedLowp, time elapsed: 276800 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4PackedLowp (10700 ns)
    TCS: TestCase_testScalarMulVec1PackedMediump, time elapsed: 190200 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1PackedMediump (10700 ns)
    TCS: TestCase_testScalarMulVec1PackedLowp, time elapsed: 182500 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1PackedLowp (9800 ns)
    TCS: TestCase_testScalarMulVec3PackedMediump, time elapsed: 183200 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3PackedMediump (12700 ns)
    TCS: TestCase_testScalarMulVec3PackedLowp, time elapsed: 188000 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3PackedLowp (9700 ns)
    TCS: TestCase_testScalarMulVec4PackedMediump, time elapsed: 193400 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4PackedMediump (9600 ns)
    TCS: TestCase_testScalarMulVec4PackedLowp, time elapsed: 182600 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4PackedLowp (9800 ns)
    TCS: TestCase_testScalarDivVec1PackedMediump, time elapsed: 183100 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1PackedMediump (9800 ns)
    TCS: TestCase_testScalarDivVec1PackedLowp, time elapsed: 181900 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1PackedLowp (8800 ns)
    TCS: TestCase_testScalarDivVec3PackedMediump, time elapsed: 181800 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3PackedMediump (12300 ns)
    TCS: TestCase_testScalarDivVec3PackedLowp, time elapsed: 185400 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3PackedLowp (9300 ns)
    TCS: TestCase_testScalarDivVec4PackedMediump, time elapsed: 179400 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4PackedMediump (9600 ns)
    TCS: TestCase_testScalarDivVec4PackedLowp, time elapsed: 181200 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4PackedLowp (9300 ns)
    TCS: TestCase_testScalarModVec1PackedMediump, time elapsed: 192900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1PackedMediump (9900 ns)
    TCS: TestCase_testScalarModVec1PackedLowp, time elapsed: 275700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1PackedLowp (20800 ns)
    TCS: TestCase_testScalarModVec3PackedMediump, time elapsed: 185300 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3PackedMediump (10500 ns)
    TCS: TestCase_testScalarModVec3PackedLowp, time elapsed: 201800 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3PackedLowp (15000 ns)
    TCS: TestCase_testScalarModVec4PackedMediump, time elapsed: 175200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4PackedMediump (10000 ns)
    TCS: TestCase_testScalarModVec4PackedLowp, time elapsed: 172000 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4PackedLowp (9000 ns)
    TCS: TestCase_testScalarDivZeroVec1, time elapsed: 182700 ns, RESULT:
    [ PASSED ] CASE: testScalarDivZeroVec1 (13400 ns)
    TCS: TestCase_testScalarAddNegVec1, time elapsed: 186600 ns, RESULT:
    [ PASSED ] CASE: testScalarAddNegVec1 (12200 ns)
    TCS: TestCase_testScalarAddNegVec2, time elapsed: 176200 ns, RESULT:
    [ PASSED ] CASE: testScalarAddNegVec2 (8600 ns)
    TCS: TestCase_testScalarMulOverflowVec1, time elapsed: 172100 ns, RESULT:
    [ PASSED ] CASE: testScalarMulOverflowVec1 (8100 ns)
    TCS: TestCase_testScalarSubNegVec1, time elapsed: 176900 ns, RESULT:
    [ PASSED ] CASE: testScalarSubNegVec1 (11900 ns)
    TCS: TestCase_testVersionMajor, time elapsed: 173800 ns, RESULT:
    [ PASSED ] CASE: testVersionMajor (8900 ns)
    TCS: TestCase_testVersionMinor, time elapsed: 173100 ns, RESULT:
    [ PASSED ] CASE: testVersionMinor (9500 ns)
    TCS: TestCase_testVersionPatch, time elapsed: 174800 ns, RESULT:
    [ PASSED ] CASE: testVersionPatch (8300 ns)
    TCS: TestCase_testVersionEncoded, time elapsed: 181000 ns, RESULT:
    [ PASSED ] CASE: testVersionEncoded (11200 ns)
    TCS: TestCase_testConfigSimd, time elapsed: 186300 ns, RESULT:
    [ PASSED ] CASE: testConfigSimd (13000 ns)
    TCS: TestCase_testConfigAlignedGentypes, time elapsed: 178600 ns, RESULT:
    [ PASSED ] CASE: testConfigAlignedGentypes (9200 ns)
    TCS: TestCase_testConfigClipControl, time elapsed: 174900 ns, RESULT:
    [ PASSED ] CASE: testConfigClipControl (7600 ns)
    TCS: TestCase_testConstNegationSimd, time elapsed: 174100 ns, RESULT:
    [ PASSED ] CASE: testConstNegationSimd (10100 ns)
    TCS: TestCase_testConstNegationAligned, time elapsed: 173500 ns, RESULT:
    [ PASSED ] CASE: testConstNegationAligned (9100 ns)
    TCS: TestCase_testConstNegationClip, time elapsed: 185800 ns, RESULT:
    [ PASSED ] CASE: testConstNegationClip (8800 ns)
    TCS: TestCase_testConstInt64Usage, time elapsed: 183100 ns, RESULT:
    [ PASSED ] CASE: testConstInt64Usage (8000 ns)
    TCS: TestCase_testConstBoolUsage, time elapsed: 181600 ns, RESULT:
    [ PASSED ] CASE: testConstBoolUsage (8600 ns)
    TCS: TestCase_testVersionEncodingConsistency, time elapsed: 186300 ns, RESULT:
    [ PASSED ] CASE: testVersionEncodingConsistency (10200 ns)
    TCS: TestCase_testAssertPasses, time elapsed: 193900 ns, RESULT:
    [ PASSED ] CASE: testAssertPasses (15800 ns)
    TCS: TestCase_testAssertFails, time elapsed: 256200 ns, RESULT:
    [ PASSED ] CASE: testAssertFails (71000 ns)
    TCS: TestCase_testAssertWithCustomMessage, time elapsed: 225500 ns, RESULT:
    [ PASSED ] CASE: testAssertWithCustomMessage (39200 ns)
    TCS: TestCase_testNumericLimitsFloat32Epsilon, time elapsed: 190400 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsFloat32Epsilon (11500 ns)
    TCS: TestCase_testNumericLimitsFloat64Epsilon, time elapsed: 188800 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsFloat64Epsilon (9500 ns)
    TCS: TestCase_testIsIec559OfFloat32, time elapsed: 192500 ns, RESULT:
    [ PASSED ] CASE: testIsIec559OfFloat32 (12600 ns)
    TCS: TestCase_testIsIec559OfFloat64, time elapsed: 196500 ns, RESULT:
    [ PASSED ] CASE: testIsIec559OfFloat64 (8400 ns)
    TCS: TestCase_testIsIec559OfInt64, time elapsed: 194600 ns, RESULT:
    [ PASSED ] CASE: testIsIec559OfInt64 (10000 ns)
    TCS: TestCase_testEpsilonOfFloat32, time elapsed: 339200 ns, RESULT:
    [ PASSED ] CASE: testEpsilonOfFloat32 (14200 ns)
    TCS: TestCase_testEpsilonOfFloat64, time elapsed: 199800 ns, RESULT:
    [ PASSED ] CASE: testEpsilonOfFloat64 (10200 ns)
    TCS: TestCase_testNumericLimitsInt64Epsilon, time elapsed: 193100 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt64Epsilon (14600 ns)
    TCS: TestCase_testNumericLimitsInt32Epsilon, time elapsed: 189300 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt32Epsilon (10000 ns)
    TCS: TestCase_testNumericLimitsInt16Epsilon, time elapsed: 201000 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt16Epsilon (13500 ns)
    TCS: TestCase_testNumericLimitsInt8Epsilon, time elapsed: 191900 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt8Epsilon (10800 ns)
    TCS: TestCase_testCastVec1ToVec1IntToFloat, time elapsed: 193700 ns, RESULT:
    [ PASSED ] CASE: testCastVec1ToVec1IntToFloat (12500 ns)
    TCS: TestCase_testCastVec2ToVec1TakesOnlyX, time elapsed: 194400 ns, RESULT:
    [ PASSED ] CASE: testCastVec2ToVec1TakesOnlyX (8600 ns)
    TCS: TestCase_testCastVec3ToVec1TakesOnlyX, time elapsed: 194500 ns, RESULT:
    [ PASSED ] CASE: testCastVec3ToVec1TakesOnlyX (15200 ns)
    TCS: TestCase_testCastVec4ToVec1TakesOnlyX, time elapsed: 205000 ns, RESULT:
    [ PASSED ] CASE: testCastVec4ToVec1TakesOnlyX (15200 ns)
    TCS: TestCase_testCastSameTypeIdentity, time elapsed: 457500 ns, RESULT:
    [ PASSED ] CASE: testCastSameTypeIdentity (11000 ns)
    TCS: TestCase_testCastInt32ToInt64, time elapsed: 302000 ns, RESULT:
    [ PASSED ] CASE: testCastInt32ToInt64 (27500 ns)
    TCS: TestCase_testCastFloatToIntTruncation, time elapsed: 386600 ns, RESULT:
    [ PASSED ] CASE: testCastFloatToIntTruncation (30100 ns)
    TCS: TestCase_testCastCrossQualifierPackedHighpToDefaultp, time elapsed: 317900 ns, RESULT:
    [ PASSED ] CASE: testCastCrossQualifierPackedHighpToDefaultp (29900 ns)
    TCS: TestCase_testCastCrossQualifierDefaultpToPackedHighp, time elapsed: 315400 ns, RESULT:
    [ PASSED ] CASE: testCastCrossQualifierDefaultpToPackedHighp (28000 ns)
    TCS: TestCase_testCastVec2CrossQualifierCrossType, time elapsed: 306800 ns, RESULT:
    [ PASSED ] CASE: testCastVec2CrossQualifierCrossType (28100 ns)
    TCS: TestCase_testCastVec3CrossQualifier, time elapsed: 396400 ns, RESULT:
    [ PASSED ] CASE: testCastVec3CrossQualifier (28800 ns)
    TCS: TestCase_testCastVec4CrossQualifier, time elapsed: 389800 ns, RESULT:
    [ PASSED ] CASE: testCastVec4CrossQualifier (16800 ns)
    TCS: TestCase_testCastVec1DoesNotModifySource, time elapsed: 504100 ns, RESULT:
    [ PASSED ] CASE: testCastVec1DoesNotModifySource (26500 ns)
    TCS: TestCase_testCastVec2Vec1ToVec2IntToFloat, time elapsed: 285700 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec1ToVec2IntToFloat (17900 ns)
    TCS: TestCase_testCastVec2Vec2ToVec2Identity, time elapsed: 300400 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec2ToVec2Identity (18300 ns)
    TCS: TestCase_testCastVec2Vec3ToVec2TakesOnlyXY, time elapsed: 370400 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec3ToVec2TakesOnlyXY (29300 ns)
    TCS: TestCase_testCastVec2Vec4ToVec2TakesOnlyXY, time elapsed: 221300 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec4ToVec2TakesOnlyXY (11600 ns)
    TCS: TestCase_testCastVec2SameTypeIdentity, time elapsed: 191100 ns, RESULT:
    [ PASSED ] CASE: testCastVec2SameTypeIdentity (8800 ns)
    TCS: TestCase_testCastVec2Int32ToInt64, time elapsed: 241500 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Int32ToInt64 (10800 ns)
    TCS: TestCase_testCastVec2FloatToIntTruncation, time elapsed: 198700 ns, RESULT:
    [ PASSED ] CASE: testCastVec2FloatToIntTruncation (13600 ns)
    TCS: TestCase_testCastVec2CrossQualifierPackedHighpToDefaultp, time elapsed: 177000 ns, RESULT:
    [ PASSED ] CASE: testCastVec2CrossQualifierPackedHighpToDefaultp (7700 ns)
    TCS: TestCase_testCastVec2DoesNotModifySource, time elapsed: 176300 ns, RESULT:
    [ PASSED ] CASE: testCastVec2DoesNotModifySource (7400 ns)
    TCS: TestCase_testCastVec2Vec1ToVec2SameValueBothComponents, time elapsed: 189200 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec1ToVec2SameValueBothComponents (9600 ns)
    TCS: TestCase_testCastVec3Vec1ToVec3IntToFloat, time elapsed: 235500 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec1ToVec3IntToFloat (21700 ns)
    TCS: TestCase_testCastVec3Vec2ToVec3ExtendY, time elapsed: 211400 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec2ToVec3ExtendY (10200 ns)
    TCS: TestCase_testCastVec3Vec3ToVec3Identity, time elapsed: 193800 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec3ToVec3Identity (15800 ns)
    TCS: TestCase_testCastVec3Vec4ToVec3TakesOnlyXYZ, time elapsed: 218100 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec4ToVec3TakesOnlyXYZ (9000 ns)
    TCS: TestCase_testCastVec3SameTypeIdentity, time elapsed: 254300 ns, RESULT:
    [ PASSED ] CASE: testCastVec3SameTypeIdentity (8000 ns)
    TCS: TestCase_testCastVec3Int32ToInt64, time elapsed: 220700 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Int32ToInt64 (10000 ns)
    TCS: TestCase_testCastVec3FloatToIntTruncation, time elapsed: 378700 ns, RESULT:
    [ PASSED ] CASE: testCastVec3FloatToIntTruncation (16100 ns)
    TCS: TestCase_testCastVec3CrossQualifierPackedHighpToDefaultp, time elapsed: 324600 ns, RESULT:
    [ PASSED ] CASE: testCastVec3CrossQualifierPackedHighpToDefaultp (15800 ns)
    TCS: TestCase_testCastVec3DoesNotModifySource, time elapsed: 600000 ns, RESULT:
    [ PASSED ] CASE: testCastVec3DoesNotModifySource (23100 ns)
    TCS: TestCase_testCastVec3Vec1ToVec3SameValueAllComponents, time elapsed: 464700 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec1ToVec3SameValueAllComponents (24200 ns)
    TCS: TestCase_testCastVec4Vec1ToVec4IntToFloat, time elapsed: 1818800 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec1ToVec4IntToFloat (96100 ns)
    TCS: TestCase_testCastVec4Vec2ToVec4ExtendY, time elapsed: 232700 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec2ToVec4ExtendY (15100 ns)
    TCS: TestCase_testCastVec4Vec3ToVec4ExtendZ, time elapsed: 232300 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec3ToVec4ExtendZ (18400 ns)
    TCS: TestCase_testCastVec4Vec4ToVec4Identity, time elapsed: 209600 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec4ToVec4Identity (10900 ns)
    TCS: TestCase_testCastVec4SameTypeIdentity, time elapsed: 221300 ns, RESULT:
    [ PASSED ] CASE: testCastVec4SameTypeIdentity (8600 ns)
    TCS: TestCase_testCastVec4Int32ToInt64, time elapsed: 200500 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Int32ToInt64 (9800 ns)
    TCS: TestCase_testCastVec4FloatToIntTruncation, time elapsed: 231500 ns, RESULT:
    [ PASSED ] CASE: testCastVec4FloatToIntTruncation (9700 ns)
    TCS: TestCase_testCastVec4CrossQualifierPackedHighpToDefaultp, time elapsed: 218900 ns, RESULT:
    [ PASSED ] CASE: testCastVec4CrossQualifierPackedHighpToDefaultp (13100 ns)
    TCS: TestCase_testCastVec4DoesNotModifySource, time elapsed: 258400 ns, RESULT:
    [ PASSED ] CASE: testCastVec4DoesNotModifySource (13500 ns)
    TCS: TestCase_testCastVec4Vec1ToVec4SameValueAllComponents, time elapsed: 209900 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec1ToVec4SameValueAllComponents (8800 ns)
    TCS: TestCase_testFromBoolVec1, time elapsed: 186500 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec1 (7100 ns)
    TCS: TestCase_testFromBoolVec1False, time elapsed: 199600 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec1False (7100 ns)
    TCS: TestCase_testFromBoolVec2, time elapsed: 192400 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec2 (7300 ns)
    TCS: TestCase_testFromBoolVec3, time elapsed: 203100 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec3 (15900 ns)
    TCS: TestCase_testFromBoolVec4, time elapsed: 192000 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec4 (7500 ns)
    TCS: TestCase_testFromBoolVecQ2Vec1, time elapsed: 393400 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec1 (15300 ns)
    TCS: TestCase_testFromBoolVecQ2Vec2, time elapsed: 239900 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec2 (10900 ns)
    TCS: TestCase_testFromBoolVecQ2Vec3, time elapsed: 257600 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec3 (24600 ns)
    TCS: TestCase_testFromBoolVecQ2Vec4, time elapsed: 249600 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec4 (13400 ns)
    TCS: TestCase_testFromBoolVec3AllFalse, time elapsed: 257100 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec3AllFalse (10700 ns)
    TCS: TestCase_testFromBoolVec4AllFalse, time elapsed: 241900 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec4AllFalse (10300 ns)
    TCS: TestCase_testFromBoolVecQ2Vec3AllFalse, time elapsed: 603300 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec3AllFalse (25800 ns)
    TCS: TestCase_testFromBoolVecQ2Vec4AllFalse, time elapsed: 317600 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec4AllFalse (13600 ns)
    TCS: TestCase_testFromBoolVecFloat32, time elapsed: 265300 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecFloat32 (13500 ns)
    TCS: TestCase_testFromBoolVecFloat64, time elapsed: 271500 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecFloat64 (19300 ns)
    TCS: TestCase_testFromBoolVecInt32, time elapsed: 234100 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecInt32 (13100 ns)
    TCS: TestCase_testFromBoolVecQ2PackedMediump, time elapsed: 248900 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2PackedMediump (11800 ns)
    TCS: TestCase_testFromBoolVecQ2PackedLowp, time elapsed: 283800 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2PackedLowp (22200 ns)
    TCS: TestCase_testS1QuatCastScalingXBranch, time elapsed: 431400 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastScalingXBranch (125200 ns)
    TCS: TestCase_testS1QuatCastScalingYBranch, time elapsed: 321800 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastScalingYBranch (37500 ns)
    TCS: TestCase_testS1QuatCastScalingZBranch, time elapsed: 373400 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastScalingZBranch (43900 ns)
    TCS: TestCase_testS1QuatCastScalingWBranch, time elapsed: 596200 ns, RESULT:
    [ FAILED ] CASE: testS1QuatCastScalingWBranch (95400 ns)
    Expect Failed: `(mat3EqualEpsilonRelaxed(m0, m1) == true)`
       left: false
      right: true

    TCS: TestCase_testS1QuatCastUnitRoundTrip, time elapsed: 353800 ns, RESULT:
    [ FAILED ] CASE: testS1QuatCastUnitRoundTrip (31300 ns)
    Expect Failed: `(mat3EqualEpsilonRelaxed(m0, m1) == true)`
       left: false
      right: true

    TCS: TestCase_testS1QuatCastIdentityRoundTrip, time elapsed: 293300 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastIdentityRoundTrip (20500 ns)
    TCS: TestCase_testS1QuatCastMat4Delegation, time elapsed: 358400 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastMat4Delegation (67000 ns)
    TCS: TestCase_testMat3EqualEpsilonRelaxedExactMatch, time elapsed: 273200 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedExactMatch (11500 ns)
    TCS: TestCase_testMat3EqualEpsilonRelaxedWithinPosTolerance, time elapsed: 275300 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedWithinPosTolerance (17900 ns)
    TCS: TestCase_testMat3EqualEpsilonRelaxedWithinNegTolerance, time elapsed: 292400 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedWithinNegTolerance (13000 ns)
    TCS: TestCase_testMat3EqualEpsilonRelaxedBeyondTolerance, time elapsed: 293700 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedBeyondTolerance (11700 ns)
    TCS: TestCase_testMat3EqualEpsilonRelaxedZeroMatrix, time elapsed: 348200 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedZeroMatrix (16400 ns)
    TCS: TestCase_testMat3EqualEpsilonRelaxedSingleDiffBeyond, time elapsed: 415700 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedSingleDiffBeyond (20800 ns)
    TCS: TestCase_testVec2ScalarInit, time elapsed: 383800 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarInit (45600 ns)
    TCS: TestCase_testVec2ConstInit, time elapsed: 289500 ns, RESULT:
    [ PASSED ] CASE: testVec2ConstInit (14600 ns)
    TCS: TestCase_testVec2Length, time elapsed: 296000 ns, RESULT:
    [ PASSED ] CASE: testVec2Length (12200 ns)
    TCS: TestCase_testVec2Add, time elapsed: 289400 ns, RESULT:
    [ PASSED ] CASE: testVec2Add (23800 ns)
    TCS: TestCase_testVec2Sub, time elapsed: 282100 ns, RESULT:
    [ PASSED ] CASE: testVec2Sub (15400 ns)
    TCS: TestCase_testVec2Mul, time elapsed: 266100 ns, RESULT:
    [ PASSED ] CASE: testVec2Mul (15000 ns)
    TCS: TestCase_testVec2ScalarAdd, time elapsed: 288500 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarAdd (15600 ns)
    TCS: TestCase_testVec2Negate, time elapsed: 353900 ns, RESULT:
    [ PASSED ] CASE: testVec2Negate (15800 ns)
    TCS: TestCase_testVec2IndexAccess, time elapsed: 329300 ns, RESULT:
    [ PASSED ] CASE: testVec2IndexAccess (17100 ns)
    TCS: TestCase_testVec2IndexMutate, time elapsed: 308600 ns, RESULT:
    [ PASSED ] CASE: testVec2IndexMutate (12600 ns)
    TCS: TestCase_testVec2ComponentAt, time elapsed: 292900 ns, RESULT:
    [ PASSED ] CASE: testVec2ComponentAt (11400 ns)
    TCS: TestCase_testVec2Equal, time elapsed: 319600 ns, RESULT:
    [ PASSED ] CASE: testVec2Equal (19800 ns)
    TCS: TestCase_testVec2NotEqual, time elapsed: 190800 ns, RESULT:
    [ PASSED ] CASE: testVec2NotEqual (17400 ns)
    TCS: TestCase_testVec2EqualExact, time elapsed: 175600 ns, RESULT:
    [ PASSED ] CASE: testVec2EqualExact (9800 ns)
    TCS: TestCase_testVec2BitwiseAnd, time elapsed: 172000 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseAnd (12300 ns)
    TCS: TestCase_testVec2BitwiseNot, time elapsed: 172900 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseNot (5700 ns)
    TCS: TestCase_testVec2FromVec1, time elapsed: 179900 ns, RESULT:
    [ PASSED ] CASE: testVec2FromVec1 (7200 ns)
    TCS: TestCase_testVec2ShiftLeft, time elapsed: 197700 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftLeft (24900 ns)
    TCS: TestCase_testVec2BoolLogicalAnd, time elapsed: 197800 ns, RESULT:
    [ PASSED ] CASE: testVec2BoolLogicalAnd (9500 ns)
    TCS: TestCase_testVec2Vec1ArithBroadcast, time elapsed: 292900 ns, RESULT:
    [ PASSED ] CASE: testVec2Vec1ArithBroadcast (17600 ns)
    TCS: TestCase_testVec2Vec1BitBroadcast, time elapsed: 220700 ns, RESULT:
    [ PASSED ] CASE: testVec2Vec1BitBroadcast (13400 ns)
    TCS: TestCase_testVec2ShiftLeftVec1, time elapsed: 247600 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftLeftVec1 (16700 ns)
    TCS: TestCase_testVec2Div, time elapsed: 211000 ns, RESULT:
    [ PASSED ] CASE: testVec2Div (11200 ns)
    TCS: TestCase_testVec2Mod, time elapsed: 253700 ns, RESULT:
    [ PASSED ] CASE: testVec2Mod (38700 ns)
    TCS: TestCase_testVec2ScalarSub, time elapsed: 236200 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarSub (12700 ns)
    TCS: TestCase_testVec2ScalarMul, time elapsed: 195100 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarMul (9200 ns)
    TCS: TestCase_testVec2ScalarDiv, time elapsed: 374700 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarDiv (21200 ns)
    TCS: TestCase_testVec2ScalarMod, time elapsed: 357200 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarMod (9300 ns)
    TCS: TestCase_testVec2BoolLogicalOr, time elapsed: 216100 ns, RESULT:
    [ PASSED ] CASE: testVec2BoolLogicalOr (14800 ns)
    TCS: TestCase_testVec2EqualEpsilon, time elapsed: 216400 ns, RESULT:
    [ PASSED ] CASE: testVec2EqualEpsilon (16100 ns)
    TCS: TestCase_testVec2DivNamed, time elapsed: 195900 ns, RESULT:
    [ PASSED ] CASE: testVec2DivNamed (8100 ns)
    TCS: TestCase_testVec2ModNamed, time elapsed: 202800 ns, RESULT:
    [ PASSED ] CASE: testVec2ModNamed (8200 ns)
    TCS: TestCase_testVec2BitwiseOr, time elapsed: 204600 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseOr (12900 ns)
    TCS: TestCase_testVec2BitwiseXor, time elapsed: 208500 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseXor (10100 ns)
    TCS: TestCase_testVec2ScalarBitwiseAnd, time elapsed: 205100 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarBitwiseAnd (14800 ns)
    TCS: TestCase_testVec2ShiftRight, time elapsed: 199700 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftRight (9400 ns)
    TCS: TestCase_testVec2ShiftRightVec1, time elapsed: 212300 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftRightVec1 (10500 ns)
    TCS: TestCase_testVec2AddNamed, time elapsed: 191200 ns, RESULT:
    [ PASSED ] CASE: testVec2AddNamed (8200 ns)
    TCS: TestCase_testVec2SubNamed, time elapsed: 288400 ns, RESULT:
    [ PASSED ] CASE: testVec2SubNamed (15800 ns)
    TCS: TestCase_testVec2MulNamed, time elapsed: 193900 ns, RESULT:
    [ PASSED ] CASE: testVec2MulNamed (12100 ns)
    TCS: TestCase_testVec2ShiftLeftVec, time elapsed: 181100 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftLeftVec (6800 ns)
    TCS: TestCase_testVec2ShiftRightVec, time elapsed: 182300 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftRightVec (6400 ns)
    TCS: TestCase_testVec2ScalarBitwiseOr, time elapsed: 198200 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarBitwiseOr (7300 ns)
    TCS: TestCase_testVec2ScalarBitwiseXor, time elapsed: 199000 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarBitwiseXor (11600 ns)
    TCS: TestCase_testVec2Increment, time elapsed: 188300 ns, RESULT:
    [ PASSED ] CASE: testVec2Increment (10200 ns)
    TCS: TestCase_testVec2Decrement, time elapsed: 187300 ns, RESULT:
    [ PASSED ] CASE: testVec2Decrement (14700 ns)
    TCS: TestCase_testVec2IndexOutOfBoundsAccess, time elapsed: 281000 ns, RESULT:
    [ PASSED ] CASE: testVec2IndexOutOfBoundsAccess (94300 ns)
    TCS: TestCase_testVec2NegativeIndexAccess, time elapsed: 217900 ns, RESULT:
    [ PASSED ] CASE: testVec2NegativeIndexAccess (33200 ns)
    TCS: TestCase_testVec3ScalarInit, time elapsed: 183300 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarInit (10800 ns)
    TCS: TestCase_testVec3ConstInit, time elapsed: 170400 ns, RESULT:
    [ PASSED ] CASE: testVec3ConstInit (5700 ns)
    TCS: TestCase_testVec3Length, time elapsed: 174000 ns, RESULT:
    [ PASSED ] CASE: testVec3Length (9600 ns)
    TCS: TestCase_testVec3Add, time elapsed: 178100 ns, RESULT:
    [ PASSED ] CASE: testVec3Add (13300 ns)
    TCS: TestCase_testVec3ScalarMul, time elapsed: 178500 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarMul (9600 ns)
    TCS: TestCase_testVec3Negate, time elapsed: 168200 ns, RESULT:
    [ PASSED ] CASE: testVec3Negate (8400 ns)
    TCS: TestCase_testVec3IndexAccess, time elapsed: 167600 ns, RESULT:
    [ PASSED ] CASE: testVec3IndexAccess (5800 ns)
    TCS: TestCase_testVec3IndexMutate, time elapsed: 170500 ns, RESULT:
    [ PASSED ] CASE: testVec3IndexMutate (7500 ns)
    TCS: TestCase_testVec3ComponentAt, time elapsed: 165800 ns, RESULT:
    [ PASSED ] CASE: testVec3ComponentAt (9400 ns)
    TCS: TestCase_testVec3Equal, time elapsed: 176100 ns, RESULT:
    [ PASSED ] CASE: testVec3Equal (12800 ns)
    TCS: TestCase_testVec3NotEqual, time elapsed: 179900 ns, RESULT:
    [ PASSED ] CASE: testVec3NotEqual (9200 ns)
    TCS: TestCase_testVec3EqualExact, time elapsed: 469300 ns, RESULT:
    [ PASSED ] CASE: testVec3EqualExact (26600 ns)
    TCS: TestCase_testVec3BitwiseAnd, time elapsed: 363500 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseAnd (19600 ns)
    TCS: TestCase_testVec3BitwiseNot, time elapsed: 283100 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseNot (15000 ns)
    TCS: TestCase_testVec3Vec1ArithBroadcast, time elapsed: 289300 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1ArithBroadcast (19500 ns)
    TCS: TestCase_testVec3ShiftLeft, time elapsed: 344500 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftLeft (32700 ns)
    TCS: TestCase_testVec3BoolLogicalAnd, time elapsed: 200700 ns, RESULT:
    [ PASSED ] CASE: testVec3BoolLogicalAnd (11000 ns)
    TCS: TestCase_testVec3Sub, time elapsed: 179100 ns, RESULT:
    [ PASSED ] CASE: testVec3Sub (11000 ns)
    TCS: TestCase_testVec3Div, time elapsed: 178800 ns, RESULT:
    [ PASSED ] CASE: testVec3Div (11300 ns)
    TCS: TestCase_testVec3Mod, time elapsed: 171400 ns, RESULT:
    [ PASSED ] CASE: testVec3Mod (12100 ns)
    TCS: TestCase_testVec3ScalarSub, time elapsed: 172300 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarSub (9800 ns)
    TCS: TestCase_testVec3ScalarDiv, time elapsed: 175400 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarDiv (10500 ns)
    TCS: TestCase_testVec3ScalarMod, time elapsed: 169400 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarMod (8000 ns)
    TCS: TestCase_testVec3BoolLogicalOr, time elapsed: 176100 ns, RESULT:
    [ PASSED ] CASE: testVec3BoolLogicalOr (7400 ns)
    TCS: TestCase_testVec3EqualEpsilon, time elapsed: 302100 ns, RESULT:
    [ PASSED ] CASE: testVec3EqualEpsilon (39800 ns)
    TCS: TestCase_testVec3AddNamed, time elapsed: 198300 ns, RESULT:
    [ PASSED ] CASE: testVec3AddNamed (13500 ns)
    TCS: TestCase_testVec3MulNamed, time elapsed: 189000 ns, RESULT:
    [ PASSED ] CASE: testVec3MulNamed (7000 ns)
    TCS: TestCase_testVec3DivNamed, time elapsed: 183400 ns, RESULT:
    [ PASSED ] CASE: testVec3DivNamed (8300 ns)
    TCS: TestCase_testVec3ModNamed, time elapsed: 211400 ns, RESULT:
    [ PASSED ] CASE: testVec3ModNamed (9800 ns)
    TCS: TestCase_testVec3BitwiseOr, time elapsed: 367300 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseOr (24900 ns)
    TCS: TestCase_testVec3BitwiseXor, time elapsed: 328700 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseXor (29800 ns)
    TCS: TestCase_testVec3ScalarBitwiseAnd, time elapsed: 234800 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarBitwiseAnd (13400 ns)
    TCS: TestCase_testVec3ShiftRight, time elapsed: 211400 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftRight (11600 ns)
    TCS: TestCase_testVec3Vec1BitBroadcast, time elapsed: 211200 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1BitBroadcast (13800 ns)
    TCS: TestCase_testVec3ShiftRightVec1, time elapsed: 208300 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftRightVec1 (10600 ns)
    TCS: TestCase_testVec3FromVec1, time elapsed: 249000 ns, RESULT:
    [ PASSED ] CASE: testVec3FromVec1 (15100 ns)
    TCS: TestCase_testVec3ScalarBitwiseOr, time elapsed: 196400 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarBitwiseOr (11800 ns)
    TCS: TestCase_testVec3ScalarBitwiseXor, time elapsed: 214400 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarBitwiseXor (11100 ns)
    TCS: TestCase_testVec3Vec1BitOrBroadcast, time elapsed: 241500 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1BitOrBroadcast (15600 ns)
    TCS: TestCase_testVec3Vec1BitXorBroadcast, time elapsed: 459000 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1BitXorBroadcast (31400 ns)
    TCS: TestCase_testVec3ShiftLeftVec1, time elapsed: 317500 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftLeftVec1 (21700 ns)
    TCS: TestCase_testVec3ShiftLeftVec, time elapsed: 237500 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftLeftVec (13400 ns)
    TCS: TestCase_testVec3ShiftRightVec, time elapsed: 230900 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftRightVec (11900 ns)
    TCS: TestCase_testVec3Increment, time elapsed: 313100 ns, RESULT:
    [ PASSED ] CASE: testVec3Increment (28000 ns)
    TCS: TestCase_testVec3Decrement, time elapsed: 426800 ns, RESULT:
    [ PASSED ] CASE: testVec3Decrement (27100 ns)
    TCS: TestCase_testVec3IndexOutOfBoundsAccess, time elapsed: 474100 ns, RESULT:
    [ PASSED ] CASE: testVec3IndexOutOfBoundsAccess (69300 ns)
    TCS: TestCase_testVec3NegativeIndexAccess, time elapsed: 377800 ns, RESULT:
    [ PASSED ] CASE: testVec3NegativeIndexAccess (48400 ns)
    TCS: TestCase_testVec4ScalarInit, time elapsed: 232800 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarInit (24400 ns)
    TCS: TestCase_testVec4ConstInit, time elapsed: 212400 ns, RESULT:
    [ PASSED ] CASE: testVec4ConstInit (6600 ns)
    TCS: TestCase_testVec4Length, time elapsed: 185300 ns, RESULT:
    [ PASSED ] CASE: testVec4Length (6100 ns)
    TCS: TestCase_testVec4Add, time elapsed: 201700 ns, RESULT:
    [ PASSED ] CASE: testVec4Add (18800 ns)
    TCS: TestCase_testVec4ScalarMul, time elapsed: 198500 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarMul (13500 ns)
    TCS: TestCase_testVec4Negate, time elapsed: 195600 ns, RESULT:
    [ PASSED ] CASE: testVec4Negate (15300 ns)
    TCS: TestCase_testVec4IndexAccess, time elapsed: 196600 ns, RESULT:
    [ PASSED ] CASE: testVec4IndexAccess (13800 ns)
    TCS: TestCase_testVec4IndexMutate, time elapsed: 314100 ns, RESULT:
    [ PASSED ] CASE: testVec4IndexMutate (15100 ns)
    TCS: TestCase_testVec4ComponentAt, time elapsed: 205100 ns, RESULT:
    [ PASSED ] CASE: testVec4ComponentAt (9900 ns)
    TCS: TestCase_testVec4Equal, time elapsed: 200900 ns, RESULT:
    [ PASSED ] CASE: testVec4Equal (17700 ns)
    TCS: TestCase_testVec4NotEqual, time elapsed: 185800 ns, RESULT:
    [ PASSED ] CASE: testVec4NotEqual (17900 ns)
    TCS: TestCase_testVec4EqualExact, time elapsed: 182500 ns, RESULT:
    [ PASSED ] CASE: testVec4EqualExact (11200 ns)
    TCS: TestCase_testVec4BitwiseAnd, time elapsed: 192800 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseAnd (20100 ns)
    TCS: TestCase_testVec4BitwiseNot, time elapsed: 184100 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseNot (8700 ns)
    TCS: TestCase_testVec4Vec1ArithBroadcast, time elapsed: 335800 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1ArithBroadcast (27900 ns)
    TCS: TestCase_testVec4ShiftLeft, time elapsed: 214800 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftLeft (21300 ns)
    TCS: TestCase_testVec4BoolLogicalAnd, time elapsed: 207800 ns, RESULT:
    [ PASSED ] CASE: testVec4BoolLogicalAnd (20700 ns)
    TCS: TestCase_testVec4Sub, time elapsed: 188000 ns, RESULT:
    [ PASSED ] CASE: testVec4Sub (12600 ns)
    TCS: TestCase_testVec4Div, time elapsed: 181200 ns, RESULT:
    [ PASSED ] CASE: testVec4Div (12700 ns)
    TCS: TestCase_testVec4Mod, time elapsed: 185200 ns, RESULT:
    [ PASSED ] CASE: testVec4Mod (10700 ns)
    TCS: TestCase_testVec4ScalarSub, time elapsed: 185200 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarSub (10500 ns)
    TCS: TestCase_testVec4ScalarDiv, time elapsed: 180700 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarDiv (13000 ns)
    TCS: TestCase_testVec4ScalarMod, time elapsed: 208900 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarMod (8900 ns)
    TCS: TestCase_testVec4BoolLogicalOr, time elapsed: 313000 ns, RESULT:
    [ PASSED ] CASE: testVec4BoolLogicalOr (7300 ns)
    TCS: TestCase_testVec4EqualEpsilon, time elapsed: 189300 ns, RESULT:
    [ PASSED ] CASE: testVec4EqualEpsilon (17500 ns)
    TCS: TestCase_testVec4AddNamed, time elapsed: 184000 ns, RESULT:
    [ PASSED ] CASE: testVec4AddNamed (12500 ns)
    TCS: TestCase_testVec4MulNamed, time elapsed: 231000 ns, RESULT:
    [ PASSED ] CASE: testVec4MulNamed (8900 ns)
    TCS: TestCase_testVec4DivNamed, time elapsed: 275800 ns, RESULT:
    [ PASSED ] CASE: testVec4DivNamed (14900 ns)
    TCS: TestCase_testVec4ModNamed, time elapsed: 215000 ns, RESULT:
    [ PASSED ] CASE: testVec4ModNamed (13800 ns)
    TCS: TestCase_testVec4BitwiseOr, time elapsed: 231000 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseOr (14800 ns)
    TCS: TestCase_testVec4BitwiseXor, time elapsed: 262400 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseXor (17600 ns)
    TCS: TestCase_testVec4ScalarBitwiseAnd, time elapsed: 224000 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarBitwiseAnd (19900 ns)
    TCS: TestCase_testVec4ShiftRight, time elapsed: 246200 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftRight (22400 ns)
    TCS: TestCase_testVec4Vec1BitBroadcast, time elapsed: 198700 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1BitBroadcast (12900 ns)
    TCS: TestCase_testVec4ShiftRightVec1, time elapsed: 197400 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftRightVec1 (9400 ns)
    TCS: TestCase_testVec4FromVec1, time elapsed: 206700 ns, RESULT:
    [ PASSED ] CASE: testVec4FromVec1 (8200 ns)
    TCS: TestCase_testVec4ScalarBitwiseOr, time elapsed: 228000 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarBitwiseOr (16500 ns)
    TCS: TestCase_testVec4ScalarBitwiseXor, time elapsed: 241500 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarBitwiseXor (22500 ns)
    TCS: TestCase_testVec4Vec1BitOrBroadcast, time elapsed: 202200 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1BitOrBroadcast (13400 ns)
    TCS: TestCase_testVec4Vec1BitXorBroadcast, time elapsed: 273400 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1BitXorBroadcast (17200 ns)
    TCS: TestCase_testVec4ShiftLeftVec1, time elapsed: 190700 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftLeftVec1 (11200 ns)
    TCS: TestCase_testVec4ShiftLeftVec, time elapsed: 209700 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftLeftVec (10500 ns)
    TCS: TestCase_testVec4ShiftRightVec, time elapsed: 196800 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftRightVec (11300 ns)
    TCS: TestCase_testVec4Increment, time elapsed: 198600 ns, RESULT:
    [ PASSED ] CASE: testVec4Increment (20500 ns)
    TCS: TestCase_testVec4Decrement, time elapsed: 231800 ns, RESULT:
    [ PASSED ] CASE: testVec4Decrement (13300 ns)
    TCS: TestCase_testVec4IndexOutOfBoundsAccess, time elapsed: 231200 ns, RESULT:
    [ PASSED ] CASE: testVec4IndexOutOfBoundsAccess (48800 ns)
    TCS: TestCase_testVec4NegativeIndexAccess, time elapsed: 209300 ns, RESULT:
    [ PASSED ] CASE: testVec4NegativeIndexAccess (25300 ns)
    TCS: TestCase_testFunctor1Vec1Identity, time elapsed: 209100 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec1Identity (7800 ns)
    TCS: TestCase_testFunctor1Vec1Transform, time elapsed: 200600 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec1Transform (11400 ns)
    TCS: TestCase_testFunctor1Vec2Transform, time elapsed: 175000 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec2Transform (7800 ns)
    TCS: TestCase_testFunctor2Vec1Add, time elapsed: 176000 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec1Add (7200 ns)
    TCS: TestCase_testFunctor2VecScaVec1Mul, time elapsed: 181000 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec1Mul (12800 ns)
    TCS: TestCase_testFunctor2VecIntVec1Shift, time elapsed: 180400 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec1Shift (8500 ns)
    TCS: TestCase_testFunctor1Vec3Transform, time elapsed: 169800 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec3Transform (11300 ns)
    TCS: TestCase_testFunctor1Vec4Transform, time elapsed: 172900 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec4Transform (8000 ns)
    TCS: TestCase_testFunctor2Vec2Add, time elapsed: 167500 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec2Add (6700 ns)
    TCS: TestCase_testFunctor2Vec3Add, time elapsed: 182700 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec3Add (11600 ns)
    TCS: TestCase_testFunctor2Vec4Add, time elapsed: 169400 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec4Add (6900 ns)
    TCS: TestCase_testFunctor2VecScaVec2Mul, time elapsed: 175200 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec2Mul (9300 ns)
    TCS: TestCase_testFunctor2VecScaVec3Mul, time elapsed: 170200 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec3Mul (9700 ns)
    TCS: TestCase_testFunctor2VecScaVec4Mul, time elapsed: 170100 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec4Mul (6200 ns)
    TCS: TestCase_testFunctor2VecIntVec2Shift, time elapsed: 242500 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec2Shift (16600 ns)
    TCS: TestCase_testFunctor2VecIntVec3Shift, time elapsed: 188400 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec3Shift (6500 ns)
    TCS: TestCase_testFunctor2VecIntVec4Shift, time elapsed: 174500 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec4Shift (6600 ns)
Summary: TOTAL: 435
    PASSED: 433, SKIPPED: 0, ERROR: 0
    FAILED: 2, listed below:
            TCS: TestCase_testS1QuatCastScalingWBranch, CASE: testS1QuatCastScalingWBranch
            TCS: TestCase_testS1QuatCastUnitRoundTrip, CASE: testS1QuatCastUnitRoundTrip
--------------------------------------------------------------------------------------------------
Project tests finished, time elapsed: 171869300 ns, RESULT:
TP: glm.*, time elapsed: 171804700 ns, RESULT:
    FAILED:
    TP: glm.detail, time elapsed: 156233200 ns, RESULT:
        TCS: TestCase_testComputeVecAdd1, time elapsed: 1226300 ns, RESULT:
        TCS: TestCase_testComputeVecSub2, time elapsed: 316100 ns, RESULT:
        TCS: TestCase_testComputeVecMul3, time elapsed: 317900 ns, RESULT:
        TCS: TestCase_testComputeVecMod1, time elapsed: 280500 ns, RESULT:
        TCS: TestCase_testComputeVecMod4, time elapsed: 317300 ns, RESULT:
        TCS: TestCase_testComputeVecAnd1, time elapsed: 297600 ns, RESULT:
        TCS: TestCase_testComputeVecAnd3, time elapsed: 275500 ns, RESULT:
        TCS: TestCase_testComputeVecOr1, time elapsed: 252100 ns, RESULT:
        TCS: TestCase_testComputeVecOr2, time elapsed: 252400 ns, RESULT:
        TCS: TestCase_testComputeVecXor1, time elapsed: 296200 ns, RESULT:
        TCS: TestCase_testComputeVecXor4, time elapsed: 256500 ns, RESULT:
        TCS: TestCase_testComputeVecShiftLeft1, time elapsed: 250200 ns, RESULT:
        TCS: TestCase_testComputeVecShiftLeft3, time elapsed: 286800 ns, RESULT:
        TCS: TestCase_testComputeVecShiftRight1, time elapsed: 321800 ns, RESULT:
        TCS: TestCase_testComputeVecShiftRight4, time elapsed: 2037700 ns, RESULT:
        TCS: TestCase_testComputeVecEqual1, time elapsed: 350700 ns, RESULT:
        TCS: TestCase_testComputeVecNequal4, time elapsed: 407600 ns, RESULT:
        TCS: TestCase_testComputeVecBitwiseNot1, time elapsed: 356100 ns, RESULT:
        TCS: TestCase_testComputeVecBitwiseNot3, time elapsed: 355900 ns, RESULT:
        TCS: TestCase_testComputeVecAdd4, time elapsed: 345800 ns, RESULT:
        TCS: TestCase_testComputeVecSub1, time elapsed: 1213600 ns, RESULT:
        TCS: TestCase_testComputeVecSub3, time elapsed: 468200 ns, RESULT:
        TCS: TestCase_testComputeVecMul1, time elapsed: 324100 ns, RESULT:
        TCS: TestCase_testComputeVecMul2, time elapsed: 348200 ns, RESULT:
        TCS: TestCase_testComputeVecDiv1, time elapsed: 347900 ns, RESULT:
        TCS: TestCase_testComputeVecDiv2, time elapsed: 298400 ns, RESULT:
        TCS: TestCase_testComputeVecDiv4, time elapsed: 282700 ns, RESULT:
        TCS: TestCase_testComputeVecEqual2, time elapsed: 292900 ns, RESULT:
        TCS: TestCase_testComputeVecEqual3, time elapsed: 297900 ns, RESULT:
        TCS: TestCase_testComputeVecEqual4, time elapsed: 276800 ns, RESULT:
        TCS: TestCase_testComputeVecNequal1, time elapsed: 256900 ns, RESULT:
        TCS: TestCase_testComputeVecNequal2, time elapsed: 266800 ns, RESULT:
        TCS: TestCase_testComputeVecBitwiseNot4, time elapsed: 297400 ns, RESULT:
        TCS: TestCase_testComputeVecAddFloat32, time elapsed: 278400 ns, RESULT:
        TCS: TestCase_testComputeVecAddFloat32Vec3, time elapsed: 296800 ns, RESULT:
        TCS: TestCase_testComputeVecSubFloat32, time elapsed: 290600 ns, RESULT:
        TCS: TestCase_testComputeVecSubFloat32Vec4, time elapsed: 306900 ns, RESULT:
        TCS: TestCase_testComputeEqualInt32Equal, time elapsed: 326600 ns, RESULT:
        TCS: TestCase_testComputeEqualInt32NotEqual, time elapsed: 307100 ns, RESULT:
        TCS: TestCase_testComputeEqualFloat32Equal, time elapsed: 293900 ns, RESULT:
        TCS: TestCase_testComputeEqualFloat32NotEqual, time elapsed: 286500 ns, RESULT:
        TCS: TestCase_testComputeEqualFloat64Equal, time elapsed: 296800 ns, RESULT:
        TCS: TestCase_testComputeEqualFloat64NotEqual, time elapsed: 306300 ns, RESULT:
        TCS: TestCase_testComputeEqualBoolEqual, time elapsed: 265300 ns, RESULT:
        TCS: TestCase_testComputeEqualBoolNotEqual, time elapsed: 284100 ns, RESULT:
        TCS: TestCase_testComputeEqualNumericInt32, time elapsed: 213200 ns, RESULT:
        TCS: TestCase_testComputeEqualNumericFloat32, time elapsed: 255500 ns, RESULT:
        TCS: TestCase_testComputeEqualNumericFloat32Epsilon, time elapsed: 276800 ns, RESULT:
        TCS: TestCase_testComputeEqualNumericFloat64, time elapsed: 217700 ns, RESULT:
        TCS: TestCase_testComputeEqualInt64Equal, time elapsed: 218400 ns, RESULT:
        TCS: TestCase_testComputeEqualInt64NotEqual, time elapsed: 195300 ns, RESULT:
        TCS: TestCase_testComputeEqualFloat32Nan, time elapsed: 193200 ns, RESULT:
        TCS: TestCase_testComputeEqualFloat64Nan, time elapsed: 194400 ns, RESULT:
        TCS: TestCase_testComputeEqualFloat32SignedZero, time elapsed: 201600 ns, RESULT:
        TCS: TestCase_testComputeEqualFloat64SignedZero, time elapsed: 200500 ns, RESULT:
        TCS: TestCase_testComputeEqualNumericFloat32NotEqual, time elapsed: 329400 ns, RESULT:
        TCS: TestCase_testComputeEqualNumericFloat32BeyondEpsilon, time elapsed: 207100 ns, RESULT:
        TCS: TestCase_testComputeEqualNumericFloat64NotEqual, time elapsed: 201400 ns, RESULT:
        TCS: TestCase_testComputeEqualNumericFloat64Epsilon, time elapsed: 199800 ns, RESULT:
        TCS: TestCase_testComputeEqualNumericFloat64BeyondEpsilon, time elapsed: 396900 ns, RESULT:
        TCS: TestCase_testComputeEqualNumericInt64, time elapsed: 210700 ns, RESULT:
        TCS: TestCase_testPackedHighpImplementsQualifier, time elapsed: 224400 ns, RESULT:
        TCS: TestCase_testPackedMediumpImplementsQualifier, time elapsed: 196700 ns, RESULT:
        TCS: TestCase_testPackedLowpImplementsQualifier, time elapsed: 196200 ns, RESULT:
        TCS: TestCase_testDefaultpIsPackedHighp, time elapsed: 193700 ns, RESULT:
        TCS: TestCase_testScalarAddVec1, time elapsed: 214000 ns, RESULT:
        TCS: TestCase_testScalarAddVec2, time elapsed: 324900 ns, RESULT:
        TCS: TestCase_testScalarAddVec3, time elapsed: 225300 ns, RESULT:
        TCS: TestCase_testScalarAddVec4, time elapsed: 253900 ns, RESULT:
        TCS: TestCase_testScalarSubVec1, time elapsed: 280300 ns, RESULT:
        TCS: TestCase_testScalarMulVec1, time elapsed: 262600 ns, RESULT:
        TCS: TestCase_testScalarDivVec1, time elapsed: 269000 ns, RESULT:
        TCS: TestCase_testScalarModVec1, time elapsed: 267600 ns, RESULT:
        TCS: TestCase_testScalarMulVec2, time elapsed: 269900 ns, RESULT:
        TCS: TestCase_testScalarSubVec2, time elapsed: 226600 ns, RESULT:
        TCS: TestCase_testScalarSubVec3, time elapsed: 265400 ns, RESULT:
        TCS: TestCase_testScalarSubVec4, time elapsed: 280400 ns, RESULT:
        TCS: TestCase_testScalarMulVec3, time elapsed: 179800 ns, RESULT:
        TCS: TestCase_testScalarMulVec4, time elapsed: 191800 ns, RESULT:
        TCS: TestCase_testScalarDivVec2, time elapsed: 188600 ns, RESULT:
        TCS: TestCase_testScalarDivVec3, time elapsed: 225100 ns, RESULT:
        TCS: TestCase_testScalarDivVec4, time elapsed: 217500 ns, RESULT:
        TCS: TestCase_testScalarModVec2, time elapsed: 201200 ns, RESULT:
        TCS: TestCase_testScalarModVec3, time elapsed: 217700 ns, RESULT:
        TCS: TestCase_testScalarModVec4, time elapsed: 207600 ns, RESULT:
        TCS: TestCase_testScalarModVec1Float32, time elapsed: 572200 ns, RESULT:
        TCS: TestCase_testScalarModVec2Float32, time elapsed: 275300 ns, RESULT:
        TCS: TestCase_testScalarModVec3Float32, time elapsed: 219500 ns, RESULT:
        TCS: TestCase_testScalarModVec4Float32, time elapsed: 212900 ns, RESULT:
        TCS: TestCase_testScalarModVec1Float64, time elapsed: 214800 ns, RESULT:
        TCS: TestCase_testScalarModVec2Float64, time elapsed: 206700 ns, RESULT:
        TCS: TestCase_testScalarModVec3Float64, time elapsed: 206600 ns, RESULT:
        TCS: TestCase_testScalarModVec4Float64, time elapsed: 499600 ns, RESULT:
        TCS: TestCase_testScalarModVec1Float16, time elapsed: 333700 ns, RESULT:
        TCS: TestCase_testScalarModVec2Float16, time elapsed: 284700 ns, RESULT:
        TCS: TestCase_testScalarModVec3Float16, time elapsed: 281600 ns, RESULT:
        TCS: TestCase_testScalarModVec4Float16, time elapsed: 399100 ns, RESULT:
        TCS: TestCase_testScalarSubVec2PackedMediump, time elapsed: 373000 ns, RESULT:
        TCS: TestCase_testScalarSubVec2PackedLowp, time elapsed: 222200 ns, RESULT:
        TCS: TestCase_testScalarMulVec2PackedMediump, time elapsed: 222600 ns, RESULT:
        TCS: TestCase_testScalarMulVec2PackedLowp, time elapsed: 216400 ns, RESULT:
        TCS: TestCase_testScalarDivVec2PackedMediump, time elapsed: 190300 ns, RESULT:
        TCS: TestCase_testScalarDivVec2PackedLowp, time elapsed: 191100 ns, RESULT:
        TCS: TestCase_testScalarModVec2PackedMediump, time elapsed: 189100 ns, RESULT:
        TCS: TestCase_testScalarModVec2PackedLowp, time elapsed: 186400 ns, RESULT:
        TCS: TestCase_testScalarModVec2Float32PackedMediump, time elapsed: 198600 ns, RESULT:
        TCS: TestCase_testScalarModVec2Float32PackedLowp, time elapsed: 189800 ns, RESULT:
        TCS: TestCase_testScalarModVec2Float32NegativeDividend, time elapsed: 190700 ns, RESULT:
        TCS: TestCase_testScalarModVec2Float32NegativeDivisor, time elapsed: 312400 ns, RESULT:
        TCS: TestCase_testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents, time elapsed: 386900 ns, RESULT:
        TCS: TestCase_testScalarAddVec1Float32, time elapsed: 195600 ns, RESULT:
        TCS: TestCase_testScalarAddVec2Float32, time elapsed: 182500 ns, RESULT:
        TCS: TestCase_testScalarAddVec3Float32, time elapsed: 181600 ns, RESULT:
        TCS: TestCase_testScalarAddVec4Float32, time elapsed: 181100 ns, RESULT:
        TCS: TestCase_testScalarSubVec1Float32, time elapsed: 194000 ns, RESULT:
        TCS: TestCase_testScalarSubVec2Float32, time elapsed: 181700 ns, RESULT:
        TCS: TestCase_testScalarSubVec3Float32, time elapsed: 179400 ns, RESULT:
        TCS: TestCase_testScalarSubVec4Float32, time elapsed: 175400 ns, RESULT:
        TCS: TestCase_testScalarMulVec1Float32, time elapsed: 194500 ns, RESULT:
        TCS: TestCase_testScalarMulVec2Float32, time elapsed: 181000 ns, RESULT:
        TCS: TestCase_testScalarMulVec3Float32, time elapsed: 186700 ns, RESULT:
        TCS: TestCase_testScalarMulVec4Float32, time elapsed: 197600 ns, RESULT:
        TCS: TestCase_testScalarDivVec1Float32, time elapsed: 185700 ns, RESULT:
        TCS: TestCase_testScalarDivVec2Float32, time elapsed: 188500 ns, RESULT:
        TCS: TestCase_testScalarDivVec3Float32, time elapsed: 182200 ns, RESULT:
        TCS: TestCase_testScalarDivVec4Float32, time elapsed: 183300 ns, RESULT:
        TCS: TestCase_testScalarAddVec1Int32, time elapsed: 210400 ns, RESULT:
        TCS: TestCase_testScalarAddVec2Int32, time elapsed: 191400 ns, RESULT:
        TCS: TestCase_testScalarAddVec3Int32, time elapsed: 189700 ns, RESULT:
        TCS: TestCase_testScalarAddVec4Int32, time elapsed: 189800 ns, RESULT:
        TCS: TestCase_testScalarSubVec1Int32, time elapsed: 186800 ns, RESULT:
        TCS: TestCase_testScalarSubVec2Int32, time elapsed: 185500 ns, RESULT:
        TCS: TestCase_testScalarSubVec3Int32, time elapsed: 189700 ns, RESULT:
        TCS: TestCase_testScalarSubVec4Int32, time elapsed: 186000 ns, RESULT:
        TCS: TestCase_testScalarMulVec1Int32, time elapsed: 191300 ns, RESULT:
        TCS: TestCase_testScalarMulVec2Int32, time elapsed: 192800 ns, RESULT:
        TCS: TestCase_testScalarMulVec3Int32, time elapsed: 187600 ns, RESULT:
        TCS: TestCase_testScalarMulVec4Int32, time elapsed: 184800 ns, RESULT:
        TCS: TestCase_testScalarDivVec1Int32, time elapsed: 186900 ns, RESULT:
        TCS: TestCase_testScalarDivVec2Int32, time elapsed: 194600 ns, RESULT:
        TCS: TestCase_testScalarDivVec3Int32, time elapsed: 189300 ns, RESULT:
        TCS: TestCase_testScalarDivVec4Int32, time elapsed: 182000 ns, RESULT:
        TCS: TestCase_testScalarModVec1Int32, time elapsed: 192600 ns, RESULT:
        TCS: TestCase_testScalarModVec2Int32, time elapsed: 227100 ns, RESULT:
        TCS: TestCase_testScalarModVec3Int32, time elapsed: 195700 ns, RESULT:
        TCS: TestCase_testScalarModVec4Int32, time elapsed: 189100 ns, RESULT:
        TCS: TestCase_testScalarSubVec1PackedMediump, time elapsed: 189100 ns, RESULT:
        TCS: TestCase_testScalarSubVec1PackedLowp, time elapsed: 186600 ns, RESULT:
        TCS: TestCase_testScalarSubVec3PackedMediump, time elapsed: 187400 ns, RESULT:
        TCS: TestCase_testScalarSubVec3PackedLowp, time elapsed: 195200 ns, RESULT:
        TCS: TestCase_testScalarSubVec4PackedMediump, time elapsed: 190600 ns, RESULT:
        TCS: TestCase_testScalarSubVec4PackedLowp, time elapsed: 276800 ns, RESULT:
        TCS: TestCase_testScalarMulVec1PackedMediump, time elapsed: 190200 ns, RESULT:
        TCS: TestCase_testScalarMulVec1PackedLowp, time elapsed: 182500 ns, RESULT:
        TCS: TestCase_testScalarMulVec3PackedMediump, time elapsed: 183200 ns, RESULT:
        TCS: TestCase_testScalarMulVec3PackedLowp, time elapsed: 188000 ns, RESULT:
        TCS: TestCase_testScalarMulVec4PackedMediump, time elapsed: 193400 ns, RESULT:
        TCS: TestCase_testScalarMulVec4PackedLowp, time elapsed: 182600 ns, RESULT:
        TCS: TestCase_testScalarDivVec1PackedMediump, time elapsed: 183100 ns, RESULT:
        TCS: TestCase_testScalarDivVec1PackedLowp, time elapsed: 181900 ns, RESULT:
        TCS: TestCase_testScalarDivVec3PackedMediump, time elapsed: 181800 ns, RESULT:
        TCS: TestCase_testScalarDivVec3PackedLowp, time elapsed: 185400 ns, RESULT:
        TCS: TestCase_testScalarDivVec4PackedMediump, time elapsed: 179400 ns, RESULT:
        TCS: TestCase_testScalarDivVec4PackedLowp, time elapsed: 181200 ns, RESULT:
        TCS: TestCase_testScalarModVec1PackedMediump, time elapsed: 192900 ns, RESULT:
        TCS: TestCase_testScalarModVec1PackedLowp, time elapsed: 275700 ns, RESULT:
        TCS: TestCase_testScalarModVec3PackedMediump, time elapsed: 185300 ns, RESULT:
        TCS: TestCase_testScalarModVec3PackedLowp, time elapsed: 201800 ns, RESULT:
        TCS: TestCase_testScalarModVec4PackedMediump, time elapsed: 175200 ns, RESULT:
        TCS: TestCase_testScalarModVec4PackedLowp, time elapsed: 172000 ns, RESULT:
        TCS: TestCase_testScalarDivZeroVec1, time elapsed: 182700 ns, RESULT:
        TCS: TestCase_testScalarAddNegVec1, time elapsed: 186600 ns, RESULT:
        TCS: TestCase_testScalarAddNegVec2, time elapsed: 176200 ns, RESULT:
        TCS: TestCase_testScalarMulOverflowVec1, time elapsed: 172100 ns, RESULT:
        TCS: TestCase_testScalarSubNegVec1, time elapsed: 176900 ns, RESULT:
        TCS: TestCase_testVersionMajor, time elapsed: 173800 ns, RESULT:
        TCS: TestCase_testVersionMinor, time elapsed: 173100 ns, RESULT:
        TCS: TestCase_testVersionPatch, time elapsed: 174800 ns, RESULT:
        TCS: TestCase_testVersionEncoded, time elapsed: 181000 ns, RESULT:
        TCS: TestCase_testConfigSimd, time elapsed: 186300 ns, RESULT:
        TCS: TestCase_testConfigAlignedGentypes, time elapsed: 178600 ns, RESULT:
        TCS: TestCase_testConfigClipControl, time elapsed: 174900 ns, RESULT:
        TCS: TestCase_testConstNegationSimd, time elapsed: 174100 ns, RESULT:
        TCS: TestCase_testConstNegationAligned, time elapsed: 173500 ns, RESULT:
        TCS: TestCase_testConstNegationClip, time elapsed: 185800 ns, RESULT:
        TCS: TestCase_testConstInt64Usage, time elapsed: 183100 ns, RESULT:
        TCS: TestCase_testConstBoolUsage, time elapsed: 181600 ns, RESULT:
        TCS: TestCase_testVersionEncodingConsistency, time elapsed: 186300 ns, RESULT:
        TCS: TestCase_testAssertPasses, time elapsed: 193900 ns, RESULT:
        TCS: TestCase_testAssertFails, time elapsed: 256200 ns, RESULT:
        TCS: TestCase_testAssertWithCustomMessage, time elapsed: 225500 ns, RESULT:
        TCS: TestCase_testNumericLimitsFloat32Epsilon, time elapsed: 190400 ns, RESULT:
        TCS: TestCase_testNumericLimitsFloat64Epsilon, time elapsed: 188800 ns, RESULT:
        TCS: TestCase_testIsIec559OfFloat32, time elapsed: 192500 ns, RESULT:
        TCS: TestCase_testIsIec559OfFloat64, time elapsed: 196500 ns, RESULT:
        TCS: TestCase_testIsIec559OfInt64, time elapsed: 194600 ns, RESULT:
        TCS: TestCase_testEpsilonOfFloat32, time elapsed: 339200 ns, RESULT:
        TCS: TestCase_testEpsilonOfFloat64, time elapsed: 199800 ns, RESULT:
        TCS: TestCase_testNumericLimitsInt64Epsilon, time elapsed: 193100 ns, RESULT:
        TCS: TestCase_testNumericLimitsInt32Epsilon, time elapsed: 189300 ns, RESULT:
        TCS: TestCase_testNumericLimitsInt16Epsilon, time elapsed: 201000 ns, RESULT:
        TCS: TestCase_testNumericLimitsInt8Epsilon, time elapsed: 191900 ns, RESULT:
        TCS: TestCase_testCastVec1ToVec1IntToFloat, time elapsed: 193700 ns, RESULT:
        TCS: TestCase_testCastVec2ToVec1TakesOnlyX, time elapsed: 194400 ns, RESULT:
        TCS: TestCase_testCastVec3ToVec1TakesOnlyX, time elapsed: 194500 ns, RESULT:
        TCS: TestCase_testCastVec4ToVec1TakesOnlyX, time elapsed: 205000 ns, RESULT:
        TCS: TestCase_testCastSameTypeIdentity, time elapsed: 457500 ns, RESULT:
        TCS: TestCase_testCastInt32ToInt64, time elapsed: 302000 ns, RESULT:
        TCS: TestCase_testCastFloatToIntTruncation, time elapsed: 386600 ns, RESULT:
        TCS: TestCase_testCastCrossQualifierPackedHighpToDefaultp, time elapsed: 317900 ns, RESULT:
        TCS: TestCase_testCastCrossQualifierDefaultpToPackedHighp, time elapsed: 315400 ns, RESULT:
        TCS: TestCase_testCastVec2CrossQualifierCrossType, time elapsed: 306800 ns, RESULT:
        TCS: TestCase_testCastVec3CrossQualifier, time elapsed: 396400 ns, RESULT:
        TCS: TestCase_testCastVec4CrossQualifier, time elapsed: 389800 ns, RESULT:
        TCS: TestCase_testCastVec1DoesNotModifySource, time elapsed: 504100 ns, RESULT:
        TCS: TestCase_testCastVec2Vec1ToVec2IntToFloat, time elapsed: 285700 ns, RESULT:
        TCS: TestCase_testCastVec2Vec2ToVec2Identity, time elapsed: 300400 ns, RESULT:
        TCS: TestCase_testCastVec2Vec3ToVec2TakesOnlyXY, time elapsed: 370400 ns, RESULT:
        TCS: TestCase_testCastVec2Vec4ToVec2TakesOnlyXY, time elapsed: 221300 ns, RESULT:
        TCS: TestCase_testCastVec2SameTypeIdentity, time elapsed: 191100 ns, RESULT:
        TCS: TestCase_testCastVec2Int32ToInt64, time elapsed: 241500 ns, RESULT:
        TCS: TestCase_testCastVec2FloatToIntTruncation, time elapsed: 198700 ns, RESULT:
        TCS: TestCase_testCastVec2CrossQualifierPackedHighpToDefaultp, time elapsed: 177000 ns, RESULT:
        TCS: TestCase_testCastVec2DoesNotModifySource, time elapsed: 176300 ns, RESULT:
        TCS: TestCase_testCastVec2Vec1ToVec2SameValueBothComponents, time elapsed: 189200 ns, RESULT:
        TCS: TestCase_testCastVec3Vec1ToVec3IntToFloat, time elapsed: 235500 ns, RESULT:
        TCS: TestCase_testCastVec3Vec2ToVec3ExtendY, time elapsed: 211400 ns, RESULT:
        TCS: TestCase_testCastVec3Vec3ToVec3Identity, time elapsed: 193800 ns, RESULT:
        TCS: TestCase_testCastVec3Vec4ToVec3TakesOnlyXYZ, time elapsed: 218100 ns, RESULT:
        TCS: TestCase_testCastVec3SameTypeIdentity, time elapsed: 254300 ns, RESULT:
        TCS: TestCase_testCastVec3Int32ToInt64, time elapsed: 220700 ns, RESULT:
        TCS: TestCase_testCastVec3FloatToIntTruncation, time elapsed: 378700 ns, RESULT:
        TCS: TestCase_testCastVec3CrossQualifierPackedHighpToDefaultp, time elapsed: 324600 ns, RESULT:
        TCS: TestCase_testCastVec3DoesNotModifySource, time elapsed: 600000 ns, RESULT:
        TCS: TestCase_testCastVec3Vec1ToVec3SameValueAllComponents, time elapsed: 464700 ns, RESULT:
        TCS: TestCase_testCastVec4Vec1ToVec4IntToFloat, time elapsed: 1818800 ns, RESULT:
        TCS: TestCase_testCastVec4Vec2ToVec4ExtendY, time elapsed: 232700 ns, RESULT:
        TCS: TestCase_testCastVec4Vec3ToVec4ExtendZ, time elapsed: 232300 ns, RESULT:
        TCS: TestCase_testCastVec4Vec4ToVec4Identity, time elapsed: 209600 ns, RESULT:
        TCS: TestCase_testCastVec4SameTypeIdentity, time elapsed: 221300 ns, RESULT:
        TCS: TestCase_testCastVec4Int32ToInt64, time elapsed: 200500 ns, RESULT:
        TCS: TestCase_testCastVec4FloatToIntTruncation, time elapsed: 231500 ns, RESULT:
        TCS: TestCase_testCastVec4CrossQualifierPackedHighpToDefaultp, time elapsed: 218900 ns, RESULT:
        TCS: TestCase_testCastVec4DoesNotModifySource, time elapsed: 258400 ns, RESULT:
        TCS: TestCase_testCastVec4Vec1ToVec4SameValueAllComponents, time elapsed: 209900 ns, RESULT:
        TCS: TestCase_testFromBoolVec1, time elapsed: 186500 ns, RESULT:
        TCS: TestCase_testFromBoolVec1False, time elapsed: 199600 ns, RESULT:
        TCS: TestCase_testFromBoolVec2, time elapsed: 192400 ns, RESULT:
        TCS: TestCase_testFromBoolVec3, time elapsed: 203100 ns, RESULT:
        TCS: TestCase_testFromBoolVec4, time elapsed: 192000 ns, RESULT:
        TCS: TestCase_testFromBoolVecQ2Vec1, time elapsed: 393400 ns, RESULT:
        TCS: TestCase_testFromBoolVecQ2Vec2, time elapsed: 239900 ns, RESULT:
        TCS: TestCase_testFromBoolVecQ2Vec3, time elapsed: 257600 ns, RESULT:
        TCS: TestCase_testFromBoolVecQ2Vec4, time elapsed: 249600 ns, RESULT:
        TCS: TestCase_testFromBoolVec3AllFalse, time elapsed: 257100 ns, RESULT:
        TCS: TestCase_testFromBoolVec4AllFalse, time elapsed: 241900 ns, RESULT:
        TCS: TestCase_testFromBoolVecQ2Vec3AllFalse, time elapsed: 603300 ns, RESULT:
        TCS: TestCase_testFromBoolVecQ2Vec4AllFalse, time elapsed: 317600 ns, RESULT:
        TCS: TestCase_testFromBoolVecFloat32, time elapsed: 265300 ns, RESULT:
        TCS: TestCase_testFromBoolVecFloat64, time elapsed: 271500 ns, RESULT:
        TCS: TestCase_testFromBoolVecInt32, time elapsed: 234100 ns, RESULT:
        TCS: TestCase_testFromBoolVecQ2PackedMediump, time elapsed: 248900 ns, RESULT:
        TCS: TestCase_testFromBoolVecQ2PackedLowp, time elapsed: 283800 ns, RESULT:
        TCS: TestCase_testS1QuatCastScalingXBranch, time elapsed: 431400 ns, RESULT:
        TCS: TestCase_testS1QuatCastScalingYBranch, time elapsed: 321800 ns, RESULT:
        TCS: TestCase_testS1QuatCastScalingZBranch, time elapsed: 373400 ns, RESULT:
        TCS: TestCase_testS1QuatCastScalingWBranch, time elapsed: 596200 ns, RESULT:
        [ FAILED ] CASE: testS1QuatCastScalingWBranch (95400 ns)
        TCS: TestCase_testS1QuatCastUnitRoundTrip, time elapsed: 353800 ns, RESULT:
        [ FAILED ] CASE: testS1QuatCastUnitRoundTrip (31300 ns)
        TCS: TestCase_testS1QuatCastIdentityRoundTrip, time elapsed: 293300 ns, RESULT:
        TCS: TestCase_testS1QuatCastMat4Delegation, time elapsed: 358400 ns, RESULT:
        TCS: TestCase_testMat3EqualEpsilonRelaxedExactMatch, time elapsed: 273200 ns, RESULT:
        TCS: TestCase_testMat3EqualEpsilonRelaxedWithinPosTolerance, time elapsed: 275300 ns, RESULT:
        TCS: TestCase_testMat3EqualEpsilonRelaxedWithinNegTolerance, time elapsed: 292400 ns, RESULT:
        TCS: TestCase_testMat3EqualEpsilonRelaxedBeyondTolerance, time elapsed: 293700 ns, RESULT:
        TCS: TestCase_testMat3EqualEpsilonRelaxedZeroMatrix, time elapsed: 348200 ns, RESULT:
        TCS: TestCase_testMat3EqualEpsilonRelaxedSingleDiffBeyond, time elapsed: 415700 ns, RESULT:
        TCS: TestCase_testVec2ScalarInit, time elapsed: 383800 ns, RESULT:
        TCS: TestCase_testVec2ConstInit, time elapsed: 289500 ns, RESULT:
        TCS: TestCase_testVec2Length, time elapsed: 296000 ns, RESULT:
        TCS: TestCase_testVec2Add, time elapsed: 289400 ns, RESULT:
        TCS: TestCase_testVec2Sub, time elapsed: 282100 ns, RESULT:
        TCS: TestCase_testVec2Mul, time elapsed: 266100 ns, RESULT:
        TCS: TestCase_testVec2ScalarAdd, time elapsed: 288500 ns, RESULT:
        TCS: TestCase_testVec2Negate, time elapsed: 353900 ns, RESULT:
        TCS: TestCase_testVec2IndexAccess, time elapsed: 329300 ns, RESULT:
        TCS: TestCase_testVec2IndexMutate, time elapsed: 308600 ns, RESULT:
        TCS: TestCase_testVec2ComponentAt, time elapsed: 292900 ns, RESULT:
        TCS: TestCase_testVec2Equal, time elapsed: 319600 ns, RESULT:
        TCS: TestCase_testVec2NotEqual, time elapsed: 190800 ns, RESULT:
        TCS: TestCase_testVec2EqualExact, time elapsed: 175600 ns, RESULT:
        TCS: TestCase_testVec2BitwiseAnd, time elapsed: 172000 ns, RESULT:
        TCS: TestCase_testVec2BitwiseNot, time elapsed: 172900 ns, RESULT:
        TCS: TestCase_testVec2FromVec1, time elapsed: 179900 ns, RESULT:
        TCS: TestCase_testVec2ShiftLeft, time elapsed: 197700 ns, RESULT:
        TCS: TestCase_testVec2BoolLogicalAnd, time elapsed: 197800 ns, RESULT:
        TCS: TestCase_testVec2Vec1ArithBroadcast, time elapsed: 292900 ns, RESULT:
        TCS: TestCase_testVec2Vec1BitBroadcast, time elapsed: 220700 ns, RESULT:
        TCS: TestCase_testVec2ShiftLeftVec1, time elapsed: 247600 ns, RESULT:
        TCS: TestCase_testVec2Div, time elapsed: 211000 ns, RESULT:
        TCS: TestCase_testVec2Mod, time elapsed: 253700 ns, RESULT:
        TCS: TestCase_testVec2ScalarSub, time elapsed: 236200 ns, RESULT:
        TCS: TestCase_testVec2ScalarMul, time elapsed: 195100 ns, RESULT:
        TCS: TestCase_testVec2ScalarDiv, time elapsed: 374700 ns, RESULT:
        TCS: TestCase_testVec2ScalarMod, time elapsed: 357200 ns, RESULT:
        TCS: TestCase_testVec2BoolLogicalOr, time elapsed: 216100 ns, RESULT:
        TCS: TestCase_testVec2EqualEpsilon, time elapsed: 216400 ns, RESULT:
        TCS: TestCase_testVec2DivNamed, time elapsed: 195900 ns, RESULT:
        TCS: TestCase_testVec2ModNamed, time elapsed: 202800 ns, RESULT:
        TCS: TestCase_testVec2BitwiseOr, time elapsed: 204600 ns, RESULT:
        TCS: TestCase_testVec2BitwiseXor, time elapsed: 208500 ns, RESULT:
        TCS: TestCase_testVec2ScalarBitwiseAnd, time elapsed: 205100 ns, RESULT:
        TCS: TestCase_testVec2ShiftRight, time elapsed: 199700 ns, RESULT:
        TCS: TestCase_testVec2ShiftRightVec1, time elapsed: 212300 ns, RESULT:
        TCS: TestCase_testVec2AddNamed, time elapsed: 191200 ns, RESULT:
        TCS: TestCase_testVec2SubNamed, time elapsed: 288400 ns, RESULT:
        TCS: TestCase_testVec2MulNamed, time elapsed: 193900 ns, RESULT:
        TCS: TestCase_testVec2ShiftLeftVec, time elapsed: 181100 ns, RESULT:
        TCS: TestCase_testVec2ShiftRightVec, time elapsed: 182300 ns, RESULT:
        TCS: TestCase_testVec2ScalarBitwiseOr, time elapsed: 198200 ns, RESULT:
        TCS: TestCase_testVec2ScalarBitwiseXor, time elapsed: 199000 ns, RESULT:
        TCS: TestCase_testVec2Increment, time elapsed: 188300 ns, RESULT:
        TCS: TestCase_testVec2Decrement, time elapsed: 187300 ns, RESULT:
        TCS: TestCase_testVec2IndexOutOfBoundsAccess, time elapsed: 281000 ns, RESULT:
        TCS: TestCase_testVec2NegativeIndexAccess, time elapsed: 217900 ns, RESULT:
        TCS: TestCase_testVec3ScalarInit, time elapsed: 183300 ns, RESULT:
        TCS: TestCase_testVec3ConstInit, time elapsed: 170400 ns, RESULT:
        TCS: TestCase_testVec3Length, time elapsed: 174000 ns, RESULT:
        TCS: TestCase_testVec3Add, time elapsed: 178100 ns, RESULT:
        TCS: TestCase_testVec3ScalarMul, time elapsed: 178500 ns, RESULT:
        TCS: TestCase_testVec3Negate, time elapsed: 168200 ns, RESULT:
        TCS: TestCase_testVec3IndexAccess, time elapsed: 167600 ns, RESULT:
        TCS: TestCase_testVec3IndexMutate, time elapsed: 170500 ns, RESULT:
        TCS: TestCase_testVec3ComponentAt, time elapsed: 165800 ns, RESULT:
        TCS: TestCase_testVec3Equal, time elapsed: 176100 ns, RESULT:
        TCS: TestCase_testVec3NotEqual, time elapsed: 179900 ns, RESULT:
        TCS: TestCase_testVec3EqualExact, time elapsed: 469300 ns, RESULT:
        TCS: TestCase_testVec3BitwiseAnd, time elapsed: 363500 ns, RESULT:
        TCS: TestCase_testVec3BitwiseNot, time elapsed: 283100 ns, RESULT:
        TCS: TestCase_testVec3Vec1ArithBroadcast, time elapsed: 289300 ns, RESULT:
        TCS: TestCase_testVec3ShiftLeft, time elapsed: 344500 ns, RESULT:
        TCS: TestCase_testVec3BoolLogicalAnd, time elapsed: 200700 ns, RESULT:
        TCS: TestCase_testVec3Sub, time elapsed: 179100 ns, RESULT:
        TCS: TestCase_testVec3Div, time elapsed: 178800 ns, RESULT:
        TCS: TestCase_testVec3Mod, time elapsed: 171400 ns, RESULT:
        TCS: TestCase_testVec3ScalarSub, time elapsed: 172300 ns, RESULT:
        TCS: TestCase_testVec3ScalarDiv, time elapsed: 175400 ns, RESULT:
        TCS: TestCase_testVec3ScalarMod, time elapsed: 169400 ns, RESULT:
        TCS: TestCase_testVec3BoolLogicalOr, time elapsed: 176100 ns, RESULT:
        TCS: TestCase_testVec3EqualEpsilon, time elapsed: 302100 ns, RESULT:
        TCS: TestCase_testVec3AddNamed, time elapsed: 198300 ns, RESULT:
        TCS: TestCase_testVec3MulNamed, time elapsed: 189000 ns, RESULT:
        TCS: TestCase_testVec3DivNamed, time elapsed: 183400 ns, RESULT:
        TCS: TestCase_testVec3ModNamed, time elapsed: 211400 ns, RESULT:
        TCS: TestCase_testVec3BitwiseOr, time elapsed: 367300 ns, RESULT:
        TCS: TestCase_testVec3BitwiseXor, time elapsed: 328700 ns, RESULT:
        TCS: TestCase_testVec3ScalarBitwiseAnd, time elapsed: 234800 ns, RESULT:
        TCS: TestCase_testVec3ShiftRight, time elapsed: 211400 ns, RESULT:
        TCS: TestCase_testVec3Vec1BitBroadcast, time elapsed: 211200 ns, RESULT:
        TCS: TestCase_testVec3ShiftRightVec1, time elapsed: 208300 ns, RESULT:
        TCS: TestCase_testVec3FromVec1, time elapsed: 249000 ns, RESULT:
        TCS: TestCase_testVec3ScalarBitwiseOr, time elapsed: 196400 ns, RESULT:
        TCS: TestCase_testVec3ScalarBitwiseXor, time elapsed: 214400 ns, RESULT:
        TCS: TestCase_testVec3Vec1BitOrBroadcast, time elapsed: 241500 ns, RESULT:
        TCS: TestCase_testVec3Vec1BitXorBroadcast, time elapsed: 459000 ns, RESULT:
        TCS: TestCase_testVec3ShiftLeftVec1, time elapsed: 317500 ns, RESULT:
        TCS: TestCase_testVec3ShiftLeftVec, time elapsed: 237500 ns, RESULT:
        TCS: TestCase_testVec3ShiftRightVec, time elapsed: 230900 ns, RESULT:
        TCS: TestCase_testVec3Increment, time elapsed: 313100 ns, RESULT:
        TCS: TestCase_testVec3Decrement, time elapsed: 426800 ns, RESULT:
        TCS: TestCase_testVec3IndexOutOfBoundsAccess, time elapsed: 474100 ns, RESULT:
        TCS: TestCase_testVec3NegativeIndexAccess, time elapsed: 377800 ns, RESULT:
        TCS: TestCase_testVec4ScalarInit, time elapsed: 232800 ns, RESULT:
        TCS: TestCase_testVec4ConstInit, time elapsed: 212400 ns, RESULT:
        TCS: TestCase_testVec4Length, time elapsed: 185300 ns, RESULT:
        TCS: TestCase_testVec4Add, time elapsed: 201700 ns, RESULT:
        TCS: TestCase_testVec4ScalarMul, time elapsed: 198500 ns, RESULT:
        TCS: TestCase_testVec4Negate, time elapsed: 195600 ns, RESULT:
        TCS: TestCase_testVec4IndexAccess, time elapsed: 196600 ns, RESULT:
        TCS: TestCase_testVec4IndexMutate, time elapsed: 314100 ns, RESULT:
        TCS: TestCase_testVec4ComponentAt, time elapsed: 205100 ns, RESULT:
        TCS: TestCase_testVec4Equal, time elapsed: 200900 ns, RESULT:
        TCS: TestCase_testVec4NotEqual, time elapsed: 185800 ns, RESULT:
        TCS: TestCase_testVec4EqualExact, time elapsed: 182500 ns, RESULT:
        TCS: TestCase_testVec4BitwiseAnd, time elapsed: 192800 ns, RESULT:
        TCS: TestCase_testVec4BitwiseNot, time elapsed: 184100 ns, RESULT:
        TCS: TestCase_testVec4Vec1ArithBroadcast, time elapsed: 335800 ns, RESULT:
        TCS: TestCase_testVec4ShiftLeft, time elapsed: 214800 ns, RESULT:
        TCS: TestCase_testVec4BoolLogicalAnd, time elapsed: 207800 ns, RESULT:
        TCS: TestCase_testVec4Sub, time elapsed: 188000 ns, RESULT:
        TCS: TestCase_testVec4Div, time elapsed: 181200 ns, RESULT:
        TCS: TestCase_testVec4Mod, time elapsed: 185200 ns, RESULT:
        TCS: TestCase_testVec4ScalarSub, time elapsed: 185200 ns, RESULT:
        TCS: TestCase_testVec4ScalarDiv, time elapsed: 180700 ns, RESULT:
        TCS: TestCase_testVec4ScalarMod, time elapsed: 208900 ns, RESULT:
        TCS: TestCase_testVec4BoolLogicalOr, time elapsed: 313000 ns, RESULT:
        TCS: TestCase_testVec4EqualEpsilon, time elapsed: 189300 ns, RESULT:
        TCS: TestCase_testVec4AddNamed, time elapsed: 184000 ns, RESULT:
        TCS: TestCase_testVec4MulNamed, time elapsed: 231000 ns, RESULT:
        TCS: TestCase_testVec4DivNamed, time elapsed: 275800 ns, RESULT:
        TCS: TestCase_testVec4ModNamed, time elapsed: 215000 ns, RESULT:
        TCS: TestCase_testVec4BitwiseOr, time elapsed: 231000 ns, RESULT:
        TCS: TestCase_testVec4BitwiseXor, time elapsed: 262400 ns, RESULT:
        TCS: TestCase_testVec4ScalarBitwiseAnd, time elapsed: 224000 ns, RESULT:
        TCS: TestCase_testVec4ShiftRight, time elapsed: 246200 ns, RESULT:
        TCS: TestCase_testVec4Vec1BitBroadcast, time elapsed: 198700 ns, RESULT:
        TCS: TestCase_testVec4ShiftRightVec1, time elapsed: 197400 ns, RESULT:
        TCS: TestCase_testVec4FromVec1, time elapsed: 206700 ns, RESULT:
        TCS: TestCase_testVec4ScalarBitwiseOr, time elapsed: 228000 ns, RESULT:
        TCS: TestCase_testVec4ScalarBitwiseXor, time elapsed: 241500 ns, RESULT:
        TCS: TestCase_testVec4Vec1BitOrBroadcast, time elapsed: 202200 ns, RESULT:
        TCS: TestCase_testVec4Vec1BitXorBroadcast, time elapsed: 273400 ns, RESULT:
        TCS: TestCase_testVec4ShiftLeftVec1, time elapsed: 190700 ns, RESULT:
        TCS: TestCase_testVec4ShiftLeftVec, time elapsed: 209700 ns, RESULT:
        TCS: TestCase_testVec4ShiftRightVec, time elapsed: 196800 ns, RESULT:
        TCS: TestCase_testVec4Increment, time elapsed: 198600 ns, RESULT:
        TCS: TestCase_testVec4Decrement, time elapsed: 231800 ns, RESULT:
        TCS: TestCase_testVec4IndexOutOfBoundsAccess, time elapsed: 231200 ns, RESULT:
        TCS: TestCase_testVec4NegativeIndexAccess, time elapsed: 209300 ns, RESULT:
        TCS: TestCase_testFunctor1Vec1Identity, time elapsed: 209100 ns, RESULT:
        TCS: TestCase_testFunctor1Vec1Transform, time elapsed: 200600 ns, RESULT:
        TCS: TestCase_testFunctor1Vec2Transform, time elapsed: 175000 ns, RESULT:
        TCS: TestCase_testFunctor2Vec1Add, time elapsed: 176000 ns, RESULT:
        TCS: TestCase_testFunctor2VecScaVec1Mul, time elapsed: 181000 ns, RESULT:
        TCS: TestCase_testFunctor2VecIntVec1Shift, time elapsed: 180400 ns, RESULT:
        TCS: TestCase_testFunctor1Vec3Transform, time elapsed: 169800 ns, RESULT:
        TCS: TestCase_testFunctor1Vec4Transform, time elapsed: 172900 ns, RESULT:
        TCS: TestCase_testFunctor2Vec2Add, time elapsed: 167500 ns, RESULT:
        TCS: TestCase_testFunctor2Vec3Add, time elapsed: 182700 ns, RESULT:
        TCS: TestCase_testFunctor2Vec4Add, time elapsed: 169400 ns, RESULT:
        TCS: TestCase_testFunctor2VecScaVec2Mul, time elapsed: 175200 ns, RESULT:
        TCS: TestCase_testFunctor2VecScaVec3Mul, time elapsed: 170200 ns, RESULT:
        TCS: TestCase_testFunctor2VecScaVec4Mul, time elapsed: 170100 ns, RESULT:
        TCS: TestCase_testFunctor2VecIntVec2Shift, time elapsed: 242500 ns, RESULT:
        TCS: TestCase_testFunctor2VecIntVec3Shift, time elapsed: 188400 ns, RESULT:
        TCS: TestCase_testFunctor2VecIntVec4Shift, time elapsed: 174500 ns, RESULT:
Summary: TOTAL: 435
    PASSED: 433, SKIPPED: 0, ERROR: 0
    FAILED: 2
--------------------------------------------------------------------------------------------------
Error: cjpm test failed
