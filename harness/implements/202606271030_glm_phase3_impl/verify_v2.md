# 验证报告（v2）

## 结果
PASSED

## 统计
- 通过：422
- 失败：0

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

13 warnings generated, 13 warnings printed.
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

warning: imported decl 'Mat2x2' is shadowed, it will be ignored by compiler
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:7:28:
  | 
7 | public import glm.detail.{ Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4 }
  |                            ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note: 'Mat2x2' is declared here
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:327:13:
    | 
327 | public type Mat2x2 = detail.Mat2x2<Float32, detail.PackedHighp>
    |             ^^^^^^ 
    | 

warning: imported decl 'Mat2x3' is shadowed, it will be ignored by compiler
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:7:36:
  | 
7 | public import glm.detail.{ Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4 }
  |                                    ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note: 'Mat2x3' is declared here
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:328:13:
    | 
328 | public type Mat2x3 = detail.Mat2x3<Float32, detail.PackedHighp>
    |             ^^^^^^ 
    | 

warning: imported decl 'Mat2x4' is shadowed, it will be ignored by compiler
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:7:44:
  | 
7 | public import glm.detail.{ Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4 }
  |                                            ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note: 'Mat2x4' is declared here
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:329:13:
    | 
329 | public type Mat2x4 = detail.Mat2x4<Float32, detail.PackedHighp>
    |             ^^^^^^ 
    | 

warning: imported decl 'Mat3x2' is shadowed, it will be ignored by compiler
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:7:52:
  | 
7 | public import glm.detail.{ Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4 }
  |                                                    ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note: 'Mat3x2' is declared here
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:330:13:
    | 
330 | public type Mat3x2 = detail.Mat3x2<Float32, detail.PackedHighp>
    |             ^^^^^^ 
    | 

warning: imported decl 'Mat3x3' is shadowed, it will be ignored by compiler
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:7:60:
  | 
7 | public import glm.detail.{ Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4 }
  |                                                            ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note: 'Mat3x3' is declared here
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:331:13:
    | 
331 | public type Mat3x3 = detail.Mat3x3<Float32, detail.PackedHighp>
    |             ^^^^^^ 
    | 

warning: imported decl 'Mat3x4' is shadowed, it will be ignored by compiler
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:7:68:
  | 
7 | public import glm.detail.{ Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4 }
  |                                                                    ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note: 'Mat3x4' is declared here
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:332:13:
    | 
332 | public type Mat3x4 = detail.Mat3x4<Float32, detail.PackedHighp>
    |             ^^^^^^ 
    | 

warning: imported decl 'Mat4x2' is shadowed, it will be ignored by compiler
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:7:76:
  | 
7 | public import glm.detail.{ Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4 }
  |                                                                            ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note: 'Mat4x2' is declared here
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:333:13:
    | 
333 | public type Mat4x2 = detail.Mat4x2<Float32, detail.PackedHighp>
    |             ^^^^^^ 
    | 

warning: imported decl 'Mat4x3' is shadowed, it will be ignored by compiler
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:7:84:
  | 
7 | public import glm.detail.{ Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4 }
  |                                                                                    ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note: 'Mat4x3' is declared here
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:334:13:
    | 
334 | public type Mat4x3 = detail.Mat4x3<Float32, detail.PackedHighp>
    |             ^^^^^^ 
    | 

warning: imported decl 'Mat4x4' is shadowed, it will be ignored by compiler
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:7:92:
  | 
7 | public import glm.detail.{ Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4 }
  |                                                                                            ^^^^^^ 
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note: 'Mat4x4' is declared here
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:335:13:
    | 
335 | public type Mat4x4 = detail.Mat4x4<Float32, detail.PackedHighp>
    |             ^^^^^^ 
    | 

13 warnings generated, 13 warnings printed.
error: expected expression after '(', found keyword 'Bool'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd_test.cj:17:26:
   | 
17 |     let b: BVec2 = BVec2(Bool(true), Bool(true))
   |                          ^^^^ expected expression here
   | 

error: expected expression after '(', found keyword 'Bool'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd_test.cj:60:26:
   | 
60 |     let v: BVec1 = BVec1(Bool(true))
   |                          ^^^^ expected expression here
   | 

error: expected expression after '(', found keyword 'Bool'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd_test.cj:66:26:
   | 
66 |     let v: BVec3 = BVec3(Bool(true), Bool(false), Bool(true))
   |                          ^^^^ expected expression here
   | 

error: expected expression after '(', found keyword 'Bool'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd_test.cj:72:26:
   | 
72 |     let v: BVec4 = BVec4(Bool(true), Bool(false), Bool(true), Bool(false))
   |                          ^^^^ expected expression here
   | 

error: expected expression after '(', found keyword 'Bool'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd_test.cj:222:76:
    | 
222 |     let v: detail.Vec3<Bool, PackedHighp> = detail.Vec3<Bool, PackedHighp>(Bool(true), Bool(false), Bool(true))
    |                                                                            ^^^^ expected expression here
    | 

5 errors generated, 5 errors printed.

--------------------------------------------------------------------------------------------------
TP: glm.detail, time elapsed: 137047700 ns, RESULT:
    TCS: TestCase_testComputeVecAdd1, time elapsed: 1321400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAdd1 (225700 ns)
    TCS: TestCase_testComputeVecSub2, time elapsed: 304500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSub2 (32400 ns)
    TCS: TestCase_testComputeVecMul3, time elapsed: 307900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMul3 (31200 ns)
    TCS: TestCase_testComputeVecMod1, time elapsed: 313400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMod1 (32200 ns)
    TCS: TestCase_testComputeVecMod4, time elapsed: 297900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMod4 (26900 ns)
    TCS: TestCase_testComputeVecAnd1, time elapsed: 311800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAnd1 (22700 ns)
    TCS: TestCase_testComputeVecAnd3, time elapsed: 273700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAnd3 (18300 ns)
    TCS: TestCase_testComputeVecOr1, time elapsed: 256100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecOr1 (18300 ns)
    TCS: TestCase_testComputeVecOr2, time elapsed: 278900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecOr2 (18500 ns)
    TCS: TestCase_testComputeVecXor1, time elapsed: 258400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecXor1 (19600 ns)
    TCS: TestCase_testComputeVecXor4, time elapsed: 248800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecXor4 (20800 ns)
    TCS: TestCase_testComputeVecShiftLeft1, time elapsed: 232000 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftLeft1 (13700 ns)
    TCS: TestCase_testComputeVecShiftLeft3, time elapsed: 243300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftLeft3 (12400 ns)
    TCS: TestCase_testComputeVecShiftRight1, time elapsed: 243500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftRight1 (11200 ns)
    TCS: TestCase_testComputeVecShiftRight4, time elapsed: 266500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftRight4 (21400 ns)
    TCS: TestCase_testComputeVecEqual1, time elapsed: 259900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual1 (18300 ns)
    TCS: TestCase_testComputeVecNequal4, time elapsed: 276800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecNequal4 (15500 ns)
    TCS: TestCase_testComputeVecBitwiseNot1, time elapsed: 242400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecBitwiseNot1 (21000 ns)
    TCS: TestCase_testComputeVecBitwiseNot3, time elapsed: 253600 ns, RESULT:
    [ PASSED ] CASE: testComputeVecBitwiseNot3 (22500 ns)
    TCS: TestCase_testComputeVecAdd4, time elapsed: 242800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAdd4 (20500 ns)
    TCS: TestCase_testComputeVecSub1, time elapsed: 745800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSub1 (17500 ns)
    TCS: TestCase_testComputeVecSub3, time elapsed: 231700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSub3 (18300 ns)
    TCS: TestCase_testComputeVecMul1, time elapsed: 223600 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMul1 (35800 ns)
    TCS: TestCase_testComputeVecMul2, time elapsed: 206200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMul2 (13800 ns)
    TCS: TestCase_testComputeVecDiv1, time elapsed: 207700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecDiv1 (13100 ns)
    TCS: TestCase_testComputeVecDiv2, time elapsed: 215800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecDiv2 (14200 ns)
    TCS: TestCase_testComputeVecDiv4, time elapsed: 211200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecDiv4 (17800 ns)
    TCS: TestCase_testComputeVecEqual2, time elapsed: 196600 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual2 (10400 ns)
    TCS: TestCase_testComputeVecEqual3, time elapsed: 217200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual3 (14400 ns)
    TCS: TestCase_testComputeVecEqual4, time elapsed: 210100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual4 (17500 ns)
    TCS: TestCase_testComputeVecNequal1, time elapsed: 197700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecNequal1 (10800 ns)
    TCS: TestCase_testComputeVecNequal2, time elapsed: 201100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecNequal2 (8400 ns)
    TCS: TestCase_testComputeVecBitwiseNot4, time elapsed: 203200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecBitwiseNot4 (17000 ns)
    TCS: TestCase_testComputeVecAddFloat32, time elapsed: 219400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAddFloat32 (27400 ns)
    TCS: TestCase_testComputeVecAddFloat32Vec3, time elapsed: 210400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAddFloat32Vec3 (22200 ns)
    TCS: TestCase_testComputeVecSubFloat32, time elapsed: 202200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSubFloat32 (14500 ns)
    TCS: TestCase_testComputeVecSubFloat32Vec4, time elapsed: 201100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSubFloat32Vec4 (17600 ns)
    TCS: TestCase_testComputeEqualInt32Equal, time elapsed: 200900 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt32Equal (13000 ns)
    TCS: TestCase_testComputeEqualInt32NotEqual, time elapsed: 384100 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt32NotEqual (19800 ns)
    TCS: TestCase_testComputeEqualFloat32Equal, time elapsed: 390300 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32Equal (21000 ns)
    TCS: TestCase_testComputeEqualFloat32NotEqual, time elapsed: 353200 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32NotEqual (15300 ns)
    TCS: TestCase_testComputeEqualFloat64Equal, time elapsed: 336400 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64Equal (19200 ns)
    TCS: TestCase_testComputeEqualFloat64NotEqual, time elapsed: 311300 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64NotEqual (16300 ns)
    TCS: TestCase_testComputeEqualBoolEqual, time elapsed: 226700 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualBoolEqual (11400 ns)
    TCS: TestCase_testComputeEqualBoolNotEqual, time elapsed: 331200 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualBoolNotEqual (40800 ns)
    TCS: TestCase_testComputeEqualNumericInt32, time elapsed: 291500 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericInt32 (21500 ns)
    TCS: TestCase_testComputeEqualNumericFloat32, time elapsed: 372900 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32 (66600 ns)
    TCS: TestCase_testComputeEqualNumericFloat32Epsilon, time elapsed: 297300 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32Epsilon (29000 ns)
    TCS: TestCase_testComputeEqualNumericFloat64, time elapsed: 291900 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64 (28600 ns)
    TCS: TestCase_testComputeEqualInt64Equal, time elapsed: 276000 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt64Equal (23100 ns)
    TCS: TestCase_testComputeEqualInt64NotEqual, time elapsed: 295500 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt64NotEqual (16000 ns)
    TCS: TestCase_testComputeEqualFloat32Nan, time elapsed: 304300 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32Nan (21300 ns)
    TCS: TestCase_testComputeEqualFloat64Nan, time elapsed: 287000 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64Nan (20200 ns)
    TCS: TestCase_testComputeEqualFloat32SignedZero, time elapsed: 292300 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32SignedZero (14500 ns)
    TCS: TestCase_testComputeEqualFloat64SignedZero, time elapsed: 285900 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64SignedZero (16100 ns)
    TCS: TestCase_testComputeEqualNumericFloat32NotEqual, time elapsed: 300800 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32NotEqual (20300 ns)
    TCS: TestCase_testComputeEqualNumericFloat32BeyondEpsilon, time elapsed: 293600 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32BeyondEpsilon (19600 ns)
    TCS: TestCase_testComputeEqualNumericFloat64NotEqual, time elapsed: 314400 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64NotEqual (28400 ns)
    TCS: TestCase_testComputeEqualNumericFloat64Epsilon, time elapsed: 367000 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64Epsilon (27400 ns)
    TCS: TestCase_testComputeEqualNumericFloat64BeyondEpsilon, time elapsed: 292700 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64BeyondEpsilon (17900 ns)
    TCS: TestCase_testComputeEqualNumericInt64, time elapsed: 343500 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericInt64 (25400 ns)
    TCS: TestCase_testPackedHighpImplementsQualifier, time elapsed: 320600 ns, RESULT:
    [ PASSED ] CASE: testPackedHighpImplementsQualifier (16900 ns)
    TCS: TestCase_testPackedMediumpImplementsQualifier, time elapsed: 297300 ns, RESULT:
    [ PASSED ] CASE: testPackedMediumpImplementsQualifier (12800 ns)
    TCS: TestCase_testPackedLowpImplementsQualifier, time elapsed: 218700 ns, RESULT:
    [ PASSED ] CASE: testPackedLowpImplementsQualifier (11800 ns)
    TCS: TestCase_testDefaultpIsPackedHighp, time elapsed: 197600 ns, RESULT:
    [ PASSED ] CASE: testDefaultpIsPackedHighp (9700 ns)
    TCS: TestCase_testScalarAddVec1, time elapsed: 222200 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec1 (17500 ns)
    TCS: TestCase_testScalarAddVec2, time elapsed: 199000 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec2 (13600 ns)
    TCS: TestCase_testScalarAddVec3, time elapsed: 192700 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec3 (9500 ns)
    TCS: TestCase_testScalarAddVec4, time elapsed: 209600 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec4 (22400 ns)
    TCS: TestCase_testScalarSubVec1, time elapsed: 205900 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1 (16000 ns)
    TCS: TestCase_testScalarMulVec1, time elapsed: 199600 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1 (15100 ns)
    TCS: TestCase_testScalarDivVec1, time elapsed: 207600 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1 (19800 ns)
    TCS: TestCase_testScalarModVec1, time elapsed: 231600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1 (14300 ns)
    TCS: TestCase_testScalarMulVec2, time elapsed: 239500 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2 (9300 ns)
    TCS: TestCase_testScalarSubVec2, time elapsed: 223200 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2 (18700 ns)
    TCS: TestCase_testScalarSubVec3, time elapsed: 226200 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3 (18600 ns)
    TCS: TestCase_testScalarSubVec4, time elapsed: 229800 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4 (22600 ns)
    TCS: TestCase_testScalarMulVec3, time elapsed: 210000 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3 (15000 ns)
    TCS: TestCase_testScalarMulVec4, time elapsed: 628700 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4 (14900 ns)
    TCS: TestCase_testScalarDivVec2, time elapsed: 374700 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2 (36200 ns)
    TCS: TestCase_testScalarDivVec3, time elapsed: 278400 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3 (26300 ns)
    TCS: TestCase_testScalarDivVec4, time elapsed: 273900 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4 (21500 ns)
    TCS: TestCase_testScalarModVec2, time elapsed: 270100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2 (22600 ns)
    TCS: TestCase_testScalarModVec3, time elapsed: 263400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3 (14900 ns)
    TCS: TestCase_testScalarModVec4, time elapsed: 244900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4 (14500 ns)
    TCS: TestCase_testScalarModVec1Float32, time elapsed: 282000 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Float32 (40200 ns)
    TCS: TestCase_testScalarModVec2Float32, time elapsed: 277400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32 (24500 ns)
    TCS: TestCase_testScalarModVec3Float32, time elapsed: 277700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Float32 (17700 ns)
    TCS: TestCase_testScalarModVec4Float32, time elapsed: 258700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Float32 (19800 ns)
    TCS: TestCase_testScalarModVec1Float64, time elapsed: 265000 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Float64 (18000 ns)
    TCS: TestCase_testScalarModVec2Float64, time elapsed: 260100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float64 (22200 ns)
    TCS: TestCase_testScalarModVec3Float64, time elapsed: 281900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Float64 (17300 ns)
    TCS: TestCase_testScalarModVec4Float64, time elapsed: 199700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Float64 (9700 ns)
    TCS: TestCase_testScalarModVec1Float16, time elapsed: 198300 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Float16 (25400 ns)
    TCS: TestCase_testScalarModVec2Float16, time elapsed: 196400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float16 (9000 ns)
    TCS: TestCase_testScalarModVec3Float16, time elapsed: 182600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Float16 (8900 ns)
    TCS: TestCase_testScalarModVec4Float16, time elapsed: 222200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Float16 (29700 ns)
    TCS: TestCase_testScalarSubVec2PackedMediump, time elapsed: 192600 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2PackedMediump (13400 ns)
    TCS: TestCase_testScalarSubVec2PackedLowp, time elapsed: 188900 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2PackedLowp (11400 ns)
    TCS: TestCase_testScalarMulVec2PackedMediump, time elapsed: 201400 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2PackedMediump (10500 ns)
    TCS: TestCase_testScalarMulVec2PackedLowp, time elapsed: 192400 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2PackedLowp (10300 ns)
    TCS: TestCase_testScalarDivVec2PackedMediump, time elapsed: 190800 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2PackedMediump (9800 ns)
    TCS: TestCase_testScalarDivVec2PackedLowp, time elapsed: 189900 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2PackedLowp (11200 ns)
    TCS: TestCase_testScalarModVec2PackedMediump, time elapsed: 204300 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2PackedMediump (9300 ns)
    TCS: TestCase_testScalarModVec2PackedLowp, time elapsed: 197600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2PackedLowp (9900 ns)
    TCS: TestCase_testScalarModVec2Float32PackedMediump, time elapsed: 203500 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32PackedMediump (10700 ns)
    TCS: TestCase_testScalarModVec2Float32PackedLowp, time elapsed: 238500 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32PackedLowp (17900 ns)
    TCS: TestCase_testScalarModVec2Float32NegativeDividend, time elapsed: 234900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32NegativeDividend (18100 ns)
    TCS: TestCase_testScalarModVec2Float32NegativeDivisor, time elapsed: 207000 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32NegativeDivisor (10700 ns)
    TCS: TestCase_testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents, time elapsed: 363800 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents (154400 ns)
    TCS: TestCase_testScalarAddVec1Float32, time elapsed: 200200 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec1Float32 (14000 ns)
    TCS: TestCase_testScalarAddVec2Float32, time elapsed: 188000 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec2Float32 (8000 ns)
    TCS: TestCase_testScalarAddVec3Float32, time elapsed: 229000 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec3Float32 (15100 ns)
    TCS: TestCase_testScalarAddVec4Float32, time elapsed: 193400 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec4Float32 (10500 ns)
    TCS: TestCase_testScalarSubVec1Float32, time elapsed: 191100 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1Float32 (11000 ns)
    TCS: TestCase_testScalarSubVec2Float32, time elapsed: 233600 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2Float32 (9500 ns)
    TCS: TestCase_testScalarSubVec3Float32, time elapsed: 209700 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3Float32 (13600 ns)
    TCS: TestCase_testScalarSubVec4Float32, time elapsed: 204800 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4Float32 (11100 ns)
    TCS: TestCase_testScalarMulVec1Float32, time elapsed: 200800 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1Float32 (10500 ns)
    TCS: TestCase_testScalarMulVec2Float32, time elapsed: 250800 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2Float32 (12400 ns)
    TCS: TestCase_testScalarMulVec3Float32, time elapsed: 183900 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3Float32 (9200 ns)
    TCS: TestCase_testScalarMulVec4Float32, time elapsed: 197700 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4Float32 (9900 ns)
    TCS: TestCase_testScalarDivVec1Float32, time elapsed: 260100 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1Float32 (13700 ns)
    TCS: TestCase_testScalarDivVec2Float32, time elapsed: 193600 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2Float32 (9300 ns)
    TCS: TestCase_testScalarDivVec3Float32, time elapsed: 189300 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3Float32 (9100 ns)
    TCS: TestCase_testScalarDivVec4Float32, time elapsed: 187000 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4Float32 (9800 ns)
    TCS: TestCase_testScalarAddVec1Int32, time elapsed: 300700 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec1Int32 (23900 ns)
    TCS: TestCase_testScalarAddVec2Int32, time elapsed: 222000 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec2Int32 (11500 ns)
    TCS: TestCase_testScalarAddVec3Int32, time elapsed: 228800 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec3Int32 (17000 ns)
    TCS: TestCase_testScalarAddVec4Int32, time elapsed: 207300 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec4Int32 (13400 ns)
    TCS: TestCase_testScalarSubVec1Int32, time elapsed: 202700 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1Int32 (15900 ns)
    TCS: TestCase_testScalarSubVec2Int32, time elapsed: 197000 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2Int32 (10000 ns)
    TCS: TestCase_testScalarSubVec3Int32, time elapsed: 210000 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3Int32 (13100 ns)
    TCS: TestCase_testScalarSubVec4Int32, time elapsed: 201600 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4Int32 (15400 ns)
    TCS: TestCase_testScalarMulVec1Int32, time elapsed: 220700 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1Int32 (13000 ns)
    TCS: TestCase_testScalarMulVec2Int32, time elapsed: 215100 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2Int32 (12600 ns)
    TCS: TestCase_testScalarMulVec3Int32, time elapsed: 199100 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3Int32 (11100 ns)
    TCS: TestCase_testScalarMulVec4Int32, time elapsed: 196300 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4Int32 (11200 ns)
    TCS: TestCase_testScalarDivVec1Int32, time elapsed: 267300 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1Int32 (22100 ns)
    TCS: TestCase_testScalarDivVec2Int32, time elapsed: 275600 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2Int32 (20900 ns)
    TCS: TestCase_testScalarDivVec3Int32, time elapsed: 259000 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3Int32 (17500 ns)
    TCS: TestCase_testScalarDivVec4Int32, time elapsed: 299600 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4Int32 (18700 ns)
    TCS: TestCase_testScalarModVec1Int32, time elapsed: 281700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Int32 (19200 ns)
    TCS: TestCase_testScalarModVec2Int32, time elapsed: 297600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Int32 (15000 ns)
    TCS: TestCase_testScalarModVec3Int32, time elapsed: 289700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Int32 (22600 ns)
    TCS: TestCase_testScalarModVec4Int32, time elapsed: 273900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Int32 (16600 ns)
    TCS: TestCase_testScalarSubVec1PackedMediump, time elapsed: 315900 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1PackedMediump (31000 ns)
    TCS: TestCase_testScalarSubVec1PackedLowp, time elapsed: 291100 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1PackedLowp (17300 ns)
    TCS: TestCase_testScalarSubVec3PackedMediump, time elapsed: 222900 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3PackedMediump (13100 ns)
    TCS: TestCase_testScalarSubVec3PackedLowp, time elapsed: 216300 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3PackedLowp (11700 ns)
    TCS: TestCase_testScalarSubVec4PackedMediump, time elapsed: 205000 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4PackedMediump (15500 ns)
    TCS: TestCase_testScalarSubVec4PackedLowp, time elapsed: 330400 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4PackedLowp (12300 ns)
    TCS: TestCase_testScalarMulVec1PackedMediump, time elapsed: 193500 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1PackedMediump (10300 ns)
    TCS: TestCase_testScalarMulVec1PackedLowp, time elapsed: 189100 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1PackedLowp (9400 ns)
    TCS: TestCase_testScalarMulVec3PackedMediump, time elapsed: 238200 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3PackedMediump (10800 ns)
    TCS: TestCase_testScalarMulVec3PackedLowp, time elapsed: 208300 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3PackedLowp (15400 ns)
    TCS: TestCase_testScalarMulVec4PackedMediump, time elapsed: 202900 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4PackedMediump (11200 ns)
    TCS: TestCase_testScalarMulVec4PackedLowp, time elapsed: 215500 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4PackedLowp (16100 ns)
    TCS: TestCase_testScalarDivVec1PackedMediump, time elapsed: 189800 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1PackedMediump (10300 ns)
    TCS: TestCase_testScalarDivVec1PackedLowp, time elapsed: 195800 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1PackedLowp (8500 ns)
    TCS: TestCase_testScalarDivVec3PackedMediump, time elapsed: 198500 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3PackedMediump (8700 ns)
    TCS: TestCase_testScalarDivVec3PackedLowp, time elapsed: 205200 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3PackedLowp (8600 ns)
    TCS: TestCase_testScalarDivVec4PackedMediump, time elapsed: 191000 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4PackedMediump (9300 ns)
    TCS: TestCase_testScalarDivVec4PackedLowp, time elapsed: 184600 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4PackedLowp (8500 ns)
    TCS: TestCase_testScalarModVec1PackedMediump, time elapsed: 185300 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1PackedMediump (8800 ns)
    TCS: TestCase_testScalarModVec1PackedLowp, time elapsed: 194100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1PackedLowp (8800 ns)
    TCS: TestCase_testScalarModVec3PackedMediump, time elapsed: 187200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3PackedMediump (12100 ns)
    TCS: TestCase_testScalarModVec3PackedLowp, time elapsed: 187700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3PackedLowp (9800 ns)
    TCS: TestCase_testScalarModVec4PackedMediump, time elapsed: 236900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4PackedMediump (9600 ns)
    TCS: TestCase_testScalarModVec4PackedLowp, time elapsed: 193500 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4PackedLowp (10000 ns)
    TCS: TestCase_testScalarDivZeroVec1, time elapsed: 194000 ns, RESULT:
    [ PASSED ] CASE: testScalarDivZeroVec1 (14100 ns)
    TCS: TestCase_testScalarAddNegVec1, time elapsed: 184700 ns, RESULT:
    [ PASSED ] CASE: testScalarAddNegVec1 (12200 ns)
    TCS: TestCase_testScalarAddNegVec2, time elapsed: 381100 ns, RESULT:
    [ PASSED ] CASE: testScalarAddNegVec2 (20300 ns)
    TCS: TestCase_testScalarMulOverflowVec1, time elapsed: 231500 ns, RESULT:
    [ PASSED ] CASE: testScalarMulOverflowVec1 (11400 ns)
    TCS: TestCase_testScalarSubNegVec1, time elapsed: 188900 ns, RESULT:
    [ PASSED ] CASE: testScalarSubNegVec1 (10200 ns)
    TCS: TestCase_testVersionMajor, time elapsed: 183200 ns, RESULT:
    [ PASSED ] CASE: testVersionMajor (8500 ns)
    TCS: TestCase_testVersionMinor, time elapsed: 178200 ns, RESULT:
    [ PASSED ] CASE: testVersionMinor (8600 ns)
    TCS: TestCase_testVersionPatch, time elapsed: 192900 ns, RESULT:
    [ PASSED ] CASE: testVersionPatch (14200 ns)
    TCS: TestCase_testVersionEncoded, time elapsed: 190000 ns, RESULT:
    [ PASSED ] CASE: testVersionEncoded (12100 ns)
    TCS: TestCase_testConfigSimd, time elapsed: 181700 ns, RESULT:
    [ PASSED ] CASE: testConfigSimd (11300 ns)
    TCS: TestCase_testConfigAlignedGentypes, time elapsed: 176300 ns, RESULT:
    [ PASSED ] CASE: testConfigAlignedGentypes (9600 ns)
    TCS: TestCase_testConfigClipControl, time elapsed: 181100 ns, RESULT:
    [ PASSED ] CASE: testConfigClipControl (7700 ns)
    TCS: TestCase_testConstNegationSimd, time elapsed: 199300 ns, RESULT:
    [ PASSED ] CASE: testConstNegationSimd (14100 ns)
    TCS: TestCase_testConstNegationAligned, time elapsed: 188700 ns, RESULT:
    [ PASSED ] CASE: testConstNegationAligned (7600 ns)
    TCS: TestCase_testConstNegationClip, time elapsed: 204200 ns, RESULT:
    [ PASSED ] CASE: testConstNegationClip (10100 ns)
    TCS: TestCase_testConstInt64Usage, time elapsed: 203600 ns, RESULT:
    [ PASSED ] CASE: testConstInt64Usage (7800 ns)
    TCS: TestCase_testConstBoolUsage, time elapsed: 200100 ns, RESULT:
    [ PASSED ] CASE: testConstBoolUsage (9100 ns)
    TCS: TestCase_testVersionEncodingConsistency, time elapsed: 188800 ns, RESULT:
    [ PASSED ] CASE: testVersionEncodingConsistency (8600 ns)
    TCS: TestCase_testAssertPasses, time elapsed: 209500 ns, RESULT:
    [ PASSED ] CASE: testAssertPasses (25700 ns)
    TCS: TestCase_testAssertFails, time elapsed: 268500 ns, RESULT:
    [ PASSED ] CASE: testAssertFails (68600 ns)
    TCS: TestCase_testAssertWithCustomMessage, time elapsed: 234300 ns, RESULT:
    [ PASSED ] CASE: testAssertWithCustomMessage (41500 ns)
    TCS: TestCase_testNumericLimitsFloat32Epsilon, time elapsed: 192700 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsFloat32Epsilon (13100 ns)
    TCS: TestCase_testNumericLimitsFloat64Epsilon, time elapsed: 216800 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsFloat64Epsilon (11600 ns)
    TCS: TestCase_testIsIec559OfFloat32, time elapsed: 194600 ns, RESULT:
    [ PASSED ] CASE: testIsIec559OfFloat32 (14300 ns)
    TCS: TestCase_testIsIec559OfFloat64, time elapsed: 202600 ns, RESULT:
    [ PASSED ] CASE: testIsIec559OfFloat64 (12400 ns)
    TCS: TestCase_testIsIec559OfInt64, time elapsed: 202200 ns, RESULT:
    [ PASSED ] CASE: testIsIec559OfInt64 (13500 ns)
    TCS: TestCase_testEpsilonOfFloat32, time elapsed: 197500 ns, RESULT:
    [ PASSED ] CASE: testEpsilonOfFloat32 (13000 ns)
    TCS: TestCase_testEpsilonOfFloat64, time elapsed: 194200 ns, RESULT:
    [ PASSED ] CASE: testEpsilonOfFloat64 (9000 ns)
    TCS: TestCase_testNumericLimitsInt64Epsilon, time elapsed: 188300 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt64Epsilon (9400 ns)
    TCS: TestCase_testNumericLimitsInt32Epsilon, time elapsed: 203900 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt32Epsilon (15500 ns)
    TCS: TestCase_testNumericLimitsInt16Epsilon, time elapsed: 194000 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt16Epsilon (14400 ns)
    TCS: TestCase_testNumericLimitsInt8Epsilon, time elapsed: 191200 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt8Epsilon (11500 ns)
    TCS: TestCase_testCastVec1ToVec1IntToFloat, time elapsed: 191000 ns, RESULT:
    [ PASSED ] CASE: testCastVec1ToVec1IntToFloat (11800 ns)
    TCS: TestCase_testCastVec2ToVec1TakesOnlyX, time elapsed: 191700 ns, RESULT:
    [ PASSED ] CASE: testCastVec2ToVec1TakesOnlyX (10400 ns)
    TCS: TestCase_testCastVec3ToVec1TakesOnlyX, time elapsed: 188700 ns, RESULT:
    [ PASSED ] CASE: testCastVec3ToVec1TakesOnlyX (12400 ns)
    TCS: TestCase_testCastVec4ToVec1TakesOnlyX, time elapsed: 184600 ns, RESULT:
    [ PASSED ] CASE: testCastVec4ToVec1TakesOnlyX (9600 ns)
    TCS: TestCase_testCastSameTypeIdentity, time elapsed: 196800 ns, RESULT:
    [ PASSED ] CASE: testCastSameTypeIdentity (13500 ns)
    TCS: TestCase_testCastInt32ToInt64, time elapsed: 184900 ns, RESULT:
    [ PASSED ] CASE: testCastInt32ToInt64 (9200 ns)
    TCS: TestCase_testCastFloatToIntTruncation, time elapsed: 359000 ns, RESULT:
    [ PASSED ] CASE: testCastFloatToIntTruncation (35200 ns)
    TCS: TestCase_testCastCrossQualifierPackedHighpToDefaultp, time elapsed: 303800 ns, RESULT:
    [ PASSED ] CASE: testCastCrossQualifierPackedHighpToDefaultp (34900 ns)
    TCS: TestCase_testCastCrossQualifierDefaultpToPackedHighp, time elapsed: 306400 ns, RESULT:
    [ PASSED ] CASE: testCastCrossQualifierDefaultpToPackedHighp (32800 ns)
    TCS: TestCase_testCastVec2CrossQualifierCrossType, time elapsed: 339000 ns, RESULT:
    [ PASSED ] CASE: testCastVec2CrossQualifierCrossType (29600 ns)
    TCS: TestCase_testCastVec3CrossQualifier, time elapsed: 290800 ns, RESULT:
    [ PASSED ] CASE: testCastVec3CrossQualifier (31800 ns)
    TCS: TestCase_testCastVec4CrossQualifier, time elapsed: 331300 ns, RESULT:
    [ PASSED ] CASE: testCastVec4CrossQualifier (35500 ns)
    TCS: TestCase_testCastVec1DoesNotModifySource, time elapsed: 305400 ns, RESULT:
    [ PASSED ] CASE: testCastVec1DoesNotModifySource (27600 ns)
    TCS: TestCase_testCastVec2Vec1ToVec2IntToFloat, time elapsed: 494800 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec1ToVec2IntToFloat (66900 ns)
    TCS: TestCase_testCastVec2Vec2ToVec2Identity, time elapsed: 208800 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec2ToVec2Identity (14000 ns)
    TCS: TestCase_testCastVec2Vec3ToVec2TakesOnlyXY, time elapsed: 210500 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec3ToVec2TakesOnlyXY (10200 ns)
    TCS: TestCase_testCastVec2Vec4ToVec2TakesOnlyXY, time elapsed: 215700 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec4ToVec2TakesOnlyXY (8800 ns)
    TCS: TestCase_testCastVec2SameTypeIdentity, time elapsed: 288700 ns, RESULT:
    [ PASSED ] CASE: testCastVec2SameTypeIdentity (17800 ns)
    TCS: TestCase_testCastVec2Int32ToInt64, time elapsed: 235400 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Int32ToInt64 (11400 ns)
    TCS: TestCase_testCastVec2FloatToIntTruncation, time elapsed: 412400 ns, RESULT:
    [ PASSED ] CASE: testCastVec2FloatToIntTruncation (20000 ns)
    TCS: TestCase_testCastVec2CrossQualifierPackedHighpToDefaultp, time elapsed: 191100 ns, RESULT:
    [ PASSED ] CASE: testCastVec2CrossQualifierPackedHighpToDefaultp (8100 ns)
    TCS: TestCase_testCastVec2DoesNotModifySource, time elapsed: 176100 ns, RESULT:
    [ PASSED ] CASE: testCastVec2DoesNotModifySource (5800 ns)
    TCS: TestCase_testCastVec2Vec1ToVec2SameValueBothComponents, time elapsed: 169800 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec1ToVec2SameValueBothComponents (9100 ns)
    TCS: TestCase_testCastVec3Vec1ToVec3IntToFloat, time elapsed: 186300 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec1ToVec3IntToFloat (14100 ns)
    TCS: TestCase_testCastVec3Vec2ToVec3ExtendY, time elapsed: 369000 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec2ToVec3ExtendY (33800 ns)
    TCS: TestCase_testCastVec3Vec3ToVec3Identity, time elapsed: 187900 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec3ToVec3Identity (8100 ns)
    TCS: TestCase_testCastVec3Vec4ToVec3TakesOnlyXYZ, time elapsed: 182500 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec4ToVec3TakesOnlyXYZ (14700 ns)
    TCS: TestCase_testCastVec3SameTypeIdentity, time elapsed: 166300 ns, RESULT:
    [ PASSED ] CASE: testCastVec3SameTypeIdentity (8700 ns)
    TCS: TestCase_testCastVec3Int32ToInt64, time elapsed: 168100 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Int32ToInt64 (7200 ns)
    TCS: TestCase_testCastVec3FloatToIntTruncation, time elapsed: 167500 ns, RESULT:
    [ PASSED ] CASE: testCastVec3FloatToIntTruncation (7300 ns)
    TCS: TestCase_testCastVec3CrossQualifierPackedHighpToDefaultp, time elapsed: 162100 ns, RESULT:
    [ PASSED ] CASE: testCastVec3CrossQualifierPackedHighpToDefaultp (6000 ns)
    TCS: TestCase_testCastVec3DoesNotModifySource, time elapsed: 170000 ns, RESULT:
    [ PASSED ] CASE: testCastVec3DoesNotModifySource (5700 ns)
    TCS: TestCase_testCastVec3Vec1ToVec3SameValueAllComponents, time elapsed: 168400 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec1ToVec3SameValueAllComponents (6700 ns)
    TCS: TestCase_testCastVec4Vec1ToVec4IntToFloat, time elapsed: 181300 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec1ToVec4IntToFloat (14800 ns)
    TCS: TestCase_testCastVec4Vec2ToVec4ExtendY, time elapsed: 191400 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec2ToVec4ExtendY (6900 ns)
    TCS: TestCase_testCastVec4Vec3ToVec4ExtendZ, time elapsed: 247200 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec3ToVec4ExtendZ (16200 ns)
    TCS: TestCase_testCastVec4Vec4ToVec4Identity, time elapsed: 195400 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec4ToVec4Identity (11300 ns)
    TCS: TestCase_testCastVec4SameTypeIdentity, time elapsed: 177900 ns, RESULT:
    [ PASSED ] CASE: testCastVec4SameTypeIdentity (6500 ns)
    TCS: TestCase_testCastVec4Int32ToInt64, time elapsed: 174000 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Int32ToInt64 (9200 ns)
    TCS: TestCase_testCastVec4FloatToIntTruncation, time elapsed: 177100 ns, RESULT:
    [ PASSED ] CASE: testCastVec4FloatToIntTruncation (8700 ns)
    TCS: TestCase_testCastVec4CrossQualifierPackedHighpToDefaultp, time elapsed: 177400 ns, RESULT:
    [ PASSED ] CASE: testCastVec4CrossQualifierPackedHighpToDefaultp (6500 ns)
    TCS: TestCase_testCastVec4DoesNotModifySource, time elapsed: 171600 ns, RESULT:
    [ PASSED ] CASE: testCastVec4DoesNotModifySource (6100 ns)
    TCS: TestCase_testCastVec4Vec1ToVec4SameValueAllComponents, time elapsed: 182800 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec1ToVec4SameValueAllComponents (7400 ns)
    TCS: TestCase_testFromBoolVec1, time elapsed: 182100 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec1 (6500 ns)
    TCS: TestCase_testFromBoolVec1False, time elapsed: 202300 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec1False (6400 ns)
    TCS: TestCase_testFromBoolVec2, time elapsed: 191800 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec2 (11600 ns)
    TCS: TestCase_testFromBoolVec3, time elapsed: 172800 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec3 (6200 ns)
    TCS: TestCase_testFromBoolVec4, time elapsed: 229300 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec4 (7000 ns)
    TCS: TestCase_testFromBoolVecQ2Vec1, time elapsed: 169600 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec1 (5400 ns)
    TCS: TestCase_testFromBoolVecQ2Vec2, time elapsed: 173400 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec2 (8100 ns)
    TCS: TestCase_testFromBoolVecQ2Vec3, time elapsed: 174500 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec3 (9200 ns)
    TCS: TestCase_testFromBoolVecQ2Vec4, time elapsed: 183300 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec4 (9700 ns)
    TCS: TestCase_testFromBoolVec3AllFalse, time elapsed: 170000 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec3AllFalse (5800 ns)
    TCS: TestCase_testFromBoolVec4AllFalse, time elapsed: 175500 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec4AllFalse (5700 ns)
    TCS: TestCase_testFromBoolVecQ2Vec3AllFalse, time elapsed: 186600 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec3AllFalse (7900 ns)
    TCS: TestCase_testFromBoolVecQ2Vec4AllFalse, time elapsed: 173800 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec4AllFalse (6300 ns)
    TCS: TestCase_testFromBoolVecFloat32, time elapsed: 172600 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecFloat32 (8200 ns)
    TCS: TestCase_testFromBoolVecFloat64, time elapsed: 167400 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecFloat64 (7200 ns)
    TCS: TestCase_testFromBoolVecInt32, time elapsed: 168600 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecInt32 (7800 ns)
    TCS: TestCase_testFromBoolVecQ2PackedMediump, time elapsed: 171300 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2PackedMediump (6300 ns)
    TCS: TestCase_testFromBoolVecQ2PackedLowp, time elapsed: 169000 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2PackedLowp (6000 ns)
    TCS: TestCase_testVec2ScalarInit, time elapsed: 182100 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarInit (14200 ns)
    TCS: TestCase_testVec2ConstInit, time elapsed: 169300 ns, RESULT:
    [ PASSED ] CASE: testVec2ConstInit (8200 ns)
    TCS: TestCase_testVec2Length, time elapsed: 176900 ns, RESULT:
    [ PASSED ] CASE: testVec2Length (6000 ns)
    TCS: TestCase_testVec2Add, time elapsed: 196400 ns, RESULT:
    [ PASSED ] CASE: testVec2Add (12700 ns)
    TCS: TestCase_testVec2Sub, time elapsed: 192800 ns, RESULT:
    [ PASSED ] CASE: testVec2Sub (17800 ns)
    TCS: TestCase_testVec2Mul, time elapsed: 248100 ns, RESULT:
    [ PASSED ] CASE: testVec2Mul (11400 ns)
    TCS: TestCase_testVec2ScalarAdd, time elapsed: 220900 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarAdd (18500 ns)
    TCS: TestCase_testVec2Negate, time elapsed: 182500 ns, RESULT:
    [ PASSED ] CASE: testVec2Negate (10100 ns)
    TCS: TestCase_testVec2IndexAccess, time elapsed: 175600 ns, RESULT:
    [ PASSED ] CASE: testVec2IndexAccess (6700 ns)
    TCS: TestCase_testVec2IndexMutate, time elapsed: 201400 ns, RESULT:
    [ PASSED ] CASE: testVec2IndexMutate (17100 ns)
    TCS: TestCase_testVec2ComponentAt, time elapsed: 186400 ns, RESULT:
    [ PASSED ] CASE: testVec2ComponentAt (6800 ns)
    TCS: TestCase_testVec2Equal, time elapsed: 181800 ns, RESULT:
    [ PASSED ] CASE: testVec2Equal (16100 ns)
    TCS: TestCase_testVec2NotEqual, time elapsed: 194600 ns, RESULT:
    [ PASSED ] CASE: testVec2NotEqual (11000 ns)
    TCS: TestCase_testVec2EqualExact, time elapsed: 177400 ns, RESULT:
    [ PASSED ] CASE: testVec2EqualExact (8800 ns)
    TCS: TestCase_testVec2BitwiseAnd, time elapsed: 184000 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseAnd (14800 ns)
    TCS: TestCase_testVec2BitwiseNot, time elapsed: 169400 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseNot (8800 ns)
    TCS: TestCase_testVec2FromVec1, time elapsed: 368900 ns, RESULT:
    [ PASSED ] CASE: testVec2FromVec1 (15300 ns)
    TCS: TestCase_testVec2ShiftLeft, time elapsed: 267800 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftLeft (31200 ns)
    TCS: TestCase_testVec2BoolLogicalAnd, time elapsed: 195400 ns, RESULT:
    [ PASSED ] CASE: testVec2BoolLogicalAnd (13300 ns)
    TCS: TestCase_testVec2Vec1ArithBroadcast, time elapsed: 205700 ns, RESULT:
    [ PASSED ] CASE: testVec2Vec1ArithBroadcast (14300 ns)
    TCS: TestCase_testVec2Vec1BitBroadcast, time elapsed: 220100 ns, RESULT:
    [ PASSED ] CASE: testVec2Vec1BitBroadcast (20900 ns)
    TCS: TestCase_testVec2ShiftLeftVec1, time elapsed: 194000 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftLeftVec1 (27300 ns)
    TCS: TestCase_testVec2Div, time elapsed: 212100 ns, RESULT:
    [ PASSED ] CASE: testVec2Div (14200 ns)
    TCS: TestCase_testVec2Mod, time elapsed: 172700 ns, RESULT:
    [ PASSED ] CASE: testVec2Mod (9400 ns)
    TCS: TestCase_testVec2ScalarSub, time elapsed: 185900 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarSub (14000 ns)
    TCS: TestCase_testVec2ScalarMul, time elapsed: 178600 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarMul (11700 ns)
    TCS: TestCase_testVec2ScalarDiv, time elapsed: 185900 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarDiv (28600 ns)
    TCS: TestCase_testVec2ScalarMod, time elapsed: 178900 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarMod (6400 ns)
    TCS: TestCase_testVec2BoolLogicalOr, time elapsed: 180200 ns, RESULT:
    [ PASSED ] CASE: testVec2BoolLogicalOr (7700 ns)
    TCS: TestCase_testVec2EqualEpsilon, time elapsed: 200600 ns, RESULT:
    [ PASSED ] CASE: testVec2EqualEpsilon (19300 ns)
    TCS: TestCase_testVec2DivNamed, time elapsed: 182100 ns, RESULT:
    [ PASSED ] CASE: testVec2DivNamed (6900 ns)
    TCS: TestCase_testVec2ModNamed, time elapsed: 178300 ns, RESULT:
    [ PASSED ] CASE: testVec2ModNamed (8000 ns)
    TCS: TestCase_testVec2BitwiseOr, time elapsed: 199300 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseOr (32900 ns)
    TCS: TestCase_testVec2BitwiseXor, time elapsed: 188400 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseXor (13300 ns)
    TCS: TestCase_testVec2ScalarBitwiseAnd, time elapsed: 193700 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarBitwiseAnd (14000 ns)
    TCS: TestCase_testVec2ShiftRight, time elapsed: 179500 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftRight (12000 ns)
    TCS: TestCase_testVec2ShiftRightVec1, time elapsed: 190300 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftRightVec1 (8800 ns)
    TCS: TestCase_testVec2AddNamed, time elapsed: 187700 ns, RESULT:
    [ PASSED ] CASE: testVec2AddNamed (21400 ns)
    TCS: TestCase_testVec2SubNamed, time elapsed: 223400 ns, RESULT:
    [ PASSED ] CASE: testVec2SubNamed (6900 ns)
    TCS: TestCase_testVec2MulNamed, time elapsed: 189400 ns, RESULT:
    [ PASSED ] CASE: testVec2MulNamed (7900 ns)
    TCS: TestCase_testVec2ShiftLeftVec, time elapsed: 361200 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftLeftVec (12200 ns)
    TCS: TestCase_testVec2ShiftRightVec, time elapsed: 239000 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftRightVec (49000 ns)
    TCS: TestCase_testVec2ScalarBitwiseOr, time elapsed: 177200 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarBitwiseOr (6300 ns)
    TCS: TestCase_testVec2ScalarBitwiseXor, time elapsed: 214500 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarBitwiseXor (19100 ns)
    TCS: TestCase_testVec2Increment, time elapsed: 186900 ns, RESULT:
    [ PASSED ] CASE: testVec2Increment (15700 ns)
    TCS: TestCase_testVec2Decrement, time elapsed: 205900 ns, RESULT:
    [ PASSED ] CASE: testVec2Decrement (15400 ns)
    TCS: TestCase_testVec2IndexOutOfBoundsAccess, time elapsed: 304200 ns, RESULT:
    [ PASSED ] CASE: testVec2IndexOutOfBoundsAccess (106400 ns)
    TCS: TestCase_testVec2NegativeIndexAccess, time elapsed: 276600 ns, RESULT:
    [ PASSED ] CASE: testVec2NegativeIndexAccess (52600 ns)
    TCS: TestCase_testVec3ScalarInit, time elapsed: 223600 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarInit (25100 ns)
    TCS: TestCase_testVec3ConstInit, time elapsed: 202400 ns, RESULT:
    [ PASSED ] CASE: testVec3ConstInit (5800 ns)
    TCS: TestCase_testVec3Length, time elapsed: 194800 ns, RESULT:
    [ PASSED ] CASE: testVec3Length (7000 ns)
    TCS: TestCase_testVec3Add, time elapsed: 203000 ns, RESULT:
    [ PASSED ] CASE: testVec3Add (21100 ns)
    TCS: TestCase_testVec3ScalarMul, time elapsed: 203100 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarMul (12300 ns)
    TCS: TestCase_testVec3Negate, time elapsed: 203800 ns, RESULT:
    [ PASSED ] CASE: testVec3Negate (14300 ns)
    TCS: TestCase_testVec3IndexAccess, time elapsed: 314500 ns, RESULT:
    [ PASSED ] CASE: testVec3IndexAccess (31600 ns)
    TCS: TestCase_testVec3IndexMutate, time elapsed: 232700 ns, RESULT:
    [ PASSED ] CASE: testVec3IndexMutate (5900 ns)
    TCS: TestCase_testVec3ComponentAt, time elapsed: 210400 ns, RESULT:
    [ PASSED ] CASE: testVec3ComponentAt (16400 ns)
    TCS: TestCase_testVec3Equal, time elapsed: 241100 ns, RESULT:
    [ PASSED ] CASE: testVec3Equal (18100 ns)
    TCS: TestCase_testVec3NotEqual, time elapsed: 239600 ns, RESULT:
    [ PASSED ] CASE: testVec3NotEqual (19100 ns)
    TCS: TestCase_testVec3EqualExact, time elapsed: 261800 ns, RESULT:
    [ PASSED ] CASE: testVec3EqualExact (57100 ns)
    TCS: TestCase_testVec3BitwiseAnd, time elapsed: 252100 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseAnd (15500 ns)
    TCS: TestCase_testVec3BitwiseNot, time elapsed: 264000 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseNot (28500 ns)
    TCS: TestCase_testVec3Vec1ArithBroadcast, time elapsed: 248100 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1ArithBroadcast (32300 ns)
    TCS: TestCase_testVec3ShiftLeft, time elapsed: 233900 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftLeft (17900 ns)
    TCS: TestCase_testVec3BoolLogicalAnd, time elapsed: 595600 ns, RESULT:
    [ PASSED ] CASE: testVec3BoolLogicalAnd (55100 ns)
    TCS: TestCase_testVec3Sub, time elapsed: 246400 ns, RESULT:
    [ PASSED ] CASE: testVec3Sub (44800 ns)
    TCS: TestCase_testVec3Div, time elapsed: 214300 ns, RESULT:
    [ PASSED ] CASE: testVec3Div (22700 ns)
    TCS: TestCase_testVec3Mod, time elapsed: 190200 ns, RESULT:
    [ PASSED ] CASE: testVec3Mod (13000 ns)
    TCS: TestCase_testVec3ScalarSub, time elapsed: 192400 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarSub (12400 ns)
    TCS: TestCase_testVec3ScalarDiv, time elapsed: 191100 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarDiv (11800 ns)
    TCS: TestCase_testVec3ScalarMod, time elapsed: 173500 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarMod (15800 ns)
    TCS: TestCase_testVec3BoolLogicalOr, time elapsed: 202400 ns, RESULT:
    [ PASSED ] CASE: testVec3BoolLogicalOr (6600 ns)
    TCS: TestCase_testVec3EqualEpsilon, time elapsed: 341500 ns, RESULT:
    [ PASSED ] CASE: testVec3EqualEpsilon (25600 ns)
    TCS: TestCase_testVec3AddNamed, time elapsed: 294900 ns, RESULT:
    [ PASSED ] CASE: testVec3AddNamed (14700 ns)
    TCS: TestCase_testVec3MulNamed, time elapsed: 289900 ns, RESULT:
    [ PASSED ] CASE: testVec3MulNamed (10500 ns)
    TCS: TestCase_testVec3DivNamed, time elapsed: 193900 ns, RESULT:
    [ PASSED ] CASE: testVec3DivNamed (6300 ns)
    TCS: TestCase_testVec3ModNamed, time elapsed: 177400 ns, RESULT:
    [ PASSED ] CASE: testVec3ModNamed (10000 ns)
    TCS: TestCase_testVec3BitwiseOr, time elapsed: 189400 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseOr (15900 ns)
    TCS: TestCase_testVec3BitwiseXor, time elapsed: 188800 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseXor (13700 ns)
    TCS: TestCase_testVec3ScalarBitwiseAnd, time elapsed: 184300 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarBitwiseAnd (11700 ns)
    TCS: TestCase_testVec3ShiftRight, time elapsed: 197200 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftRight (10900 ns)
    TCS: TestCase_testVec3Vec1BitBroadcast, time elapsed: 193000 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1BitBroadcast (14200 ns)
    TCS: TestCase_testVec3ShiftRightVec1, time elapsed: 184400 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftRightVec1 (12700 ns)
    TCS: TestCase_testVec3FromVec1, time elapsed: 185100 ns, RESULT:
    [ PASSED ] CASE: testVec3FromVec1 (6400 ns)
    TCS: TestCase_testVec3ScalarBitwiseOr, time elapsed: 178500 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarBitwiseOr (11300 ns)
    TCS: TestCase_testVec3ScalarBitwiseXor, time elapsed: 176800 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarBitwiseXor (9800 ns)
    TCS: TestCase_testVec3Vec1BitOrBroadcast, time elapsed: 191900 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1BitOrBroadcast (12600 ns)
    TCS: TestCase_testVec3Vec1BitXorBroadcast, time elapsed: 181300 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1BitXorBroadcast (14200 ns)
    TCS: TestCase_testVec3ShiftLeftVec1, time elapsed: 182800 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftLeftVec1 (12300 ns)
    TCS: TestCase_testVec3ShiftLeftVec, time elapsed: 170300 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftLeftVec (6000 ns)
    TCS: TestCase_testVec3ShiftRightVec, time elapsed: 179700 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftRightVec (10600 ns)
    TCS: TestCase_testVec3Increment, time elapsed: 181100 ns, RESULT:
    [ PASSED ] CASE: testVec3Increment (10900 ns)
    TCS: TestCase_testVec3Decrement, time elapsed: 180200 ns, RESULT:
    [ PASSED ] CASE: testVec3Decrement (13800 ns)
    TCS: TestCase_testVec3IndexOutOfBoundsAccess, time elapsed: 212700 ns, RESULT:
    [ PASSED ] CASE: testVec3IndexOutOfBoundsAccess (41200 ns)
    TCS: TestCase_testVec3NegativeIndexAccess, time elapsed: 197100 ns, RESULT:
    [ PASSED ] CASE: testVec3NegativeIndexAccess (24600 ns)
    TCS: TestCase_testVec4ScalarInit, time elapsed: 177800 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarInit (12200 ns)
    TCS: TestCase_testVec4ConstInit, time elapsed: 179200 ns, RESULT:
    [ PASSED ] CASE: testVec4ConstInit (5700 ns)
    TCS: TestCase_testVec4Length, time elapsed: 168300 ns, RESULT:
    [ PASSED ] CASE: testVec4Length (5200 ns)
    TCS: TestCase_testVec4Add, time elapsed: 200200 ns, RESULT:
    [ PASSED ] CASE: testVec4Add (24400 ns)
    TCS: TestCase_testVec4ScalarMul, time elapsed: 340700 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarMul (20900 ns)
    TCS: TestCase_testVec4Negate, time elapsed: 210300 ns, RESULT:
    [ PASSED ] CASE: testVec4Negate (28400 ns)
    TCS: TestCase_testVec4IndexAccess, time elapsed: 187700 ns, RESULT:
    [ PASSED ] CASE: testVec4IndexAccess (11000 ns)
    TCS: TestCase_testVec4IndexMutate, time elapsed: 172700 ns, RESULT:
    [ PASSED ] CASE: testVec4IndexMutate (5700 ns)
    TCS: TestCase_testVec4ComponentAt, time elapsed: 217200 ns, RESULT:
    [ PASSED ] CASE: testVec4ComponentAt (11000 ns)
    TCS: TestCase_testVec4Equal, time elapsed: 189100 ns, RESULT:
    [ PASSED ] CASE: testVec4Equal (16500 ns)
    TCS: TestCase_testVec4NotEqual, time elapsed: 190800 ns, RESULT:
    [ PASSED ] CASE: testVec4NotEqual (11500 ns)
    TCS: TestCase_testVec4EqualExact, time elapsed: 180700 ns, RESULT:
    [ PASSED ] CASE: testVec4EqualExact (13300 ns)
    TCS: TestCase_testVec4BitwiseAnd, time elapsed: 175600 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseAnd (11000 ns)
    TCS: TestCase_testVec4BitwiseNot, time elapsed: 169400 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseNot (5900 ns)
    TCS: TestCase_testVec4Vec1ArithBroadcast, time elapsed: 178800 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1ArithBroadcast (17100 ns)
    TCS: TestCase_testVec4ShiftLeft, time elapsed: 180900 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftLeft (12800 ns)
    TCS: TestCase_testVec4BoolLogicalAnd, time elapsed: 174600 ns, RESULT:
    [ PASSED ] CASE: testVec4BoolLogicalAnd (10700 ns)
    TCS: TestCase_testVec4Sub, time elapsed: 178800 ns, RESULT:
    [ PASSED ] CASE: testVec4Sub (13300 ns)
    TCS: TestCase_testVec4Div, time elapsed: 180300 ns, RESULT:
    [ PASSED ] CASE: testVec4Div (11300 ns)
    TCS: TestCase_testVec4Mod, time elapsed: 187800 ns, RESULT:
    [ PASSED ] CASE: testVec4Mod (18100 ns)
    TCS: TestCase_testVec4ScalarSub, time elapsed: 185300 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarSub (12000 ns)
    TCS: TestCase_testVec4ScalarDiv, time elapsed: 184800 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarDiv (11300 ns)
    TCS: TestCase_testVec4ScalarMod, time elapsed: 172500 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarMod (9700 ns)
    TCS: TestCase_testVec4BoolLogicalOr, time elapsed: 445300 ns, RESULT:
    [ PASSED ] CASE: testVec4BoolLogicalOr (23700 ns)
    TCS: TestCase_testVec4EqualEpsilon, time elapsed: 482300 ns, RESULT:
    [ PASSED ] CASE: testVec4EqualEpsilon (38900 ns)
    TCS: TestCase_testVec4AddNamed, time elapsed: 414300 ns, RESULT:
    [ PASSED ] CASE: testVec4AddNamed (31200 ns)
    TCS: TestCase_testVec4MulNamed, time elapsed: 226900 ns, RESULT:
    [ PASSED ] CASE: testVec4MulNamed (11400 ns)
    TCS: TestCase_testVec4DivNamed, time elapsed: 203400 ns, RESULT:
    [ PASSED ] CASE: testVec4DivNamed (9500 ns)
    TCS: TestCase_testVec4ModNamed, time elapsed: 191300 ns, RESULT:
    [ PASSED ] CASE: testVec4ModNamed (8800 ns)
    TCS: TestCase_testVec4BitwiseOr, time elapsed: 253200 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseOr (25800 ns)
    TCS: TestCase_testVec4BitwiseXor, time elapsed: 220100 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseXor (24600 ns)
    TCS: TestCase_testVec4ScalarBitwiseAnd, time elapsed: 199400 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarBitwiseAnd (18700 ns)
    TCS: TestCase_testVec4ShiftRight, time elapsed: 193700 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftRight (14500 ns)
    TCS: TestCase_testVec4Vec1BitBroadcast, time elapsed: 220300 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1BitBroadcast (22100 ns)
    TCS: TestCase_testVec4ShiftRightVec1, time elapsed: 183400 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftRightVec1 (12100 ns)
    TCS: TestCase_testVec4FromVec1, time elapsed: 177100 ns, RESULT:
    [ PASSED ] CASE: testVec4FromVec1 (11000 ns)
    TCS: TestCase_testVec4ScalarBitwiseOr, time elapsed: 180900 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarBitwiseOr (15000 ns)
    TCS: TestCase_testVec4ScalarBitwiseXor, time elapsed: 177200 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarBitwiseXor (12500 ns)
    TCS: TestCase_testVec4Vec1BitOrBroadcast, time elapsed: 176000 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1BitOrBroadcast (13300 ns)
    TCS: TestCase_testVec4Vec1BitXorBroadcast, time elapsed: 184100 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1BitXorBroadcast (13500 ns)
    TCS: TestCase_testVec4ShiftLeftVec1, time elapsed: 185100 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftLeftVec1 (11900 ns)
    TCS: TestCase_testVec4ShiftLeftVec, time elapsed: 199700 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftLeftVec (18600 ns)
    TCS: TestCase_testVec4ShiftRightVec, time elapsed: 193000 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftRightVec (16100 ns)
    TCS: TestCase_testVec4Increment, time elapsed: 189500 ns, RESULT:
    [ PASSED ] CASE: testVec4Increment (16100 ns)
    TCS: TestCase_testVec4Decrement, time elapsed: 202700 ns, RESULT:
    [ PASSED ] CASE: testVec4Decrement (17300 ns)
    TCS: TestCase_testVec4IndexOutOfBoundsAccess, time elapsed: 237500 ns, RESULT:
    [ PASSED ] CASE: testVec4IndexOutOfBoundsAccess (53400 ns)
    TCS: TestCase_testVec4NegativeIndexAccess, time elapsed: 195800 ns, RESULT:
    [ PASSED ] CASE: testVec4NegativeIndexAccess (22900 ns)
    TCS: TestCase_testFunctor1Vec1Identity, time elapsed: 177000 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec1Identity (7800 ns)
    TCS: TestCase_testFunctor1Vec1Transform, time elapsed: 282300 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec1Transform (11100 ns)
    TCS: TestCase_testFunctor1Vec2Transform, time elapsed: 174600 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec2Transform (7200 ns)
    TCS: TestCase_testFunctor2Vec1Add, time elapsed: 187200 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec1Add (6100 ns)
    TCS: TestCase_testFunctor2VecScaVec1Mul, time elapsed: 185100 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec1Mul (15000 ns)
    TCS: TestCase_testFunctor2VecIntVec1Shift, time elapsed: 193200 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec1Shift (9200 ns)
    TCS: TestCase_testFunctor1Vec3Transform, time elapsed: 177000 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec3Transform (7300 ns)
    TCS: TestCase_testFunctor1Vec4Transform, time elapsed: 198600 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec4Transform (7400 ns)
    TCS: TestCase_testFunctor2Vec2Add, time elapsed: 176000 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec2Add (6300 ns)
    TCS: TestCase_testFunctor2Vec3Add, time elapsed: 176300 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec3Add (10100 ns)
    TCS: TestCase_testFunctor2Vec4Add, time elapsed: 174700 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec4Add (6900 ns)
    TCS: TestCase_testFunctor2VecScaVec2Mul, time elapsed: 248100 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec2Mul (7100 ns)
    TCS: TestCase_testFunctor2VecScaVec3Mul, time elapsed: 176500 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec3Mul (10000 ns)
    TCS: TestCase_testFunctor2VecScaVec4Mul, time elapsed: 172800 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec4Mul (6800 ns)
    TCS: TestCase_testFunctor2VecIntVec2Shift, time elapsed: 174300 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec2Shift (6000 ns)
    TCS: TestCase_testFunctor2VecIntVec3Shift, time elapsed: 177200 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec3Shift (9100 ns)
    TCS: TestCase_testFunctor2VecIntVec4Shift, time elapsed: 175700 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec4Shift (6200 ns)
Summary: TOTAL: 422
    PASSED: 422, SKIPPED: 0, ERROR: 0
    FAILED: 0
--------------------------------------------------------------------------------------------------
Project tests finished, time elapsed: 152899300 ns, RESULT:
TP: glm.*, time elapsed: 152816600 ns, RESULT:
    PASSED:
    TP: glm.detail, time elapsed: 137047700 ns
Summary: TOTAL: 422
    PASSED: 422, SKIPPED: 0, ERROR: 0
    FAILED: 0
--------------------------------------------------------------------------------------------------
Warning: there is no '.cj' file in directory 'C:\Develop\Software\cjglm_wp\cjglm\src\gtc', and its subdirectories will not be scanned as source code
Warning: there is no '.cj' file in directory 'C:\Develop\Software\cjglm_wp\cjglm\src\gtc', and its subdirectories will not be scanned as source code
cjpm test success
