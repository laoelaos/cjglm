# 验证报告（v13）

## 结果
PASSED

## 统计
- 通过：476
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x4.cj:124:28:
    | 
124 |     public operator func /(rhs: Mat4x4<T, Q>): Mat4x4<T, Q> { throw Exception("stub") }
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

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:149:58:
    | 
149 |     public static func fromMat<SrcQ>(m: Mat2x2<T, SrcQ>, one: T): Mat3x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:149:58:
    | 
149 |     public static func fromMat<SrcQ>(m: Mat2x3<T, SrcQ>, one: T): Mat2x4<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:150:13:
    | 
150 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:151:13:
    | 
151 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:154:58:
    | 
154 |     public static func fromMat<SrcQ>(m: Mat2x4<T, SrcQ>, one: T): Mat2x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:155:58:
    | 
155 |     public static func fromMat<SrcQ>(m: Mat3x2<T, SrcQ>, one: T): Mat2x3<T, Q>
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

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:156:13:
    | 
156 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:160:58:
    | 
160 |     public static func fromMat<SrcQ>(m: Mat3x2<T, SrcQ>, one: T): Mat2x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:161:58:
    | 
161 |     public static func fromMat<SrcQ>(m: Mat3x3<T, SrcQ>, one: T): Mat2x3<T, Q>
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

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:162:13:
    | 
162 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:163:13:
    | 
163 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:166:58:
    | 
166 |     public static func fromMat<SrcQ>(m: Mat3x3<T, SrcQ>, one: T): Mat2x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:167:58:
    | 
167 |     public static func fromMat<SrcQ>(m: Mat3x3<T, SrcQ>, one: T): Mat3x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:167:58:
    | 
167 |     public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat2x3<T, Q>
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

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:168:13:
    | 
168 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'m'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\matrix.cj:168:31:
    | 
168 | public func determinant<T, Q>(m: Mat3x3<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
    |                               ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:169:13:
    | 
169 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:169:13:
    | 
169 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:169:13:
    | 
169 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'m'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\matrix.cj:169:31:
    | 
169 | public func determinant<T, Q>(m: Mat4x4<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
    |                               ^ unused variable
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:172:58:
    | 
172 |     public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat2x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:173:58:
    | 
173 |     public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat3x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:173:58:
    | 
173 |     public static func fromMat<SrcQ>(m: Mat4x2<T, SrcQ>, one: T): Mat2x4<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:173:58:
    | 
173 |     public static func fromMat<SrcQ>(m: Mat4x2<T, SrcQ>, one: T): Mat2x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:174:13:
    | 
174 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:175:13:
    | 
175 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:176:58:
    | 
176 |     public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat3x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:178:13:
    | 
178 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:178:58:
    | 
178 |     public static func fromMat<SrcQ>(m: Mat4x2<T, SrcQ>, one: T): Mat2x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:179:58:
    | 
179 |     public static func fromMat<SrcQ>(m: Mat4x2<T, SrcQ>, one: T): Mat3x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:179:58:
    | 
179 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat2x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:179:58:
    | 
179 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat2x4<T, Q>
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

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:180:13:
    | 
180 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:181:13:
    | 
181 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:181:13:
    | 
181 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:184:58:
    | 
184 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat2x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:185:58:
    | 
185 |     public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat2x3<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:185:58:
    | 
185 |     public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat2x4<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:185:58:
    | 
185 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat3x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x3.cj:185:58:
    | 
185 |     public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat4x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:186:13:
    | 
186 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:187:13:
    | 
187 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:187:13:
    | 
187 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:187:13:
    | 
187 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:188:58:
    | 
188 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat3x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:190:13:
    | 
190 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:190:58:
    | 
190 |     public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat2x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:191:58:
    | 
191 |     public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat3x2<T, Q>
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

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:192:13:
    | 
192 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x4.cj:193:13:
    | 
193 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:193:13:
    | 
193 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:193:13:
    | 
193 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:194:58:
    | 
194 |     public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat3x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:196:13:
    | 
196 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:197:58:
    | 
197 |     public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat4x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:199:13:
    | 
199 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x3.cj:199:13:
    | 
199 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:202:13:
    | 
202 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:203:13:
    | 
203 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:208:13:
    | 
208 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:214:13:
    | 
214 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:215:13:
    | 
215 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:220:13:
    | 
220 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:221:13:
    | 
221 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:221:13:
    | 
221 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:221:13:
    | 
221 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:226:13:
    | 
226 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:227:13:
    | 
227 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:230:13:
    | 
230 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:232:13:
    | 
232 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:233:13:
    | 
233 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:233:13:
    | 
233 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:238:13:
    | 
238 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:239:13:
    | 
239 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:239:13:
    | 
239 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:239:13:
    | 
239 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:242:13:
    | 
242 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:244:13:
    | 
244 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:245:13:
    | 
245 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x4.cj:245:13:
    | 
245 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:245:13:
    | 
245 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:248:13:
    | 
248 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:251:13:
    | 
251 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x3.cj:251:13:
    | 
251 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

180 warnings generated, 180 warnings printed.
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

13 warnings generated, 13 warnings printed.
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
[?25l[0J7[;r8
[1F7[9999E8--------------------------------------------------------------------------------------------------
TP: [33mglm.detail[0m, time elapsed: 165211600 ns, RESULT:
    TCS: [33mTestCase_testComputeVecAdd1[0m, time elapsed: 1500900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAdd1 (269500 ns)
    TCS: [33mTestCase_testComputeVecSub2[0m, time elapsed: 466000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub2 (45700 ns)
    TCS: [33mTestCase_testComputeVecMul3[0m, time elapsed: 973400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul3 (31000 ns)
    TCS: [33mTestCase_testComputeVecMod1[0m, time elapsed: 1160900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMod1 (47500 ns)
    TCS: [33mTestCase_testComputeVecMod4[0m, time elapsed: 290300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMod4 (24100 ns)
    TCS: [33mTestCase_testComputeVecAnd1[0m, time elapsed: 249300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAnd1 (23000 ns)
    TCS: [33mTestCase_testComputeVecAnd3[0m, time elapsed: 311000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAnd3 (31600 ns)
    TCS: [33mTestCase_testComputeVecOr1[0m, time elapsed: 410500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecOr1 (24800 ns)
    TCS: [33mTestCase_testComputeVecOr2[0m, time elapsed: 351500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecOr2 (29300 ns)
    TCS: [33mTestCase_testComputeVecXor1[0m, time elapsed: 372400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecXor1 (39100 ns)
    TCS: [33mTestCase_testComputeVecXor4[0m, time elapsed: 452100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecXor4 (38200 ns)
    TCS: [33mTestCase_testComputeVecShiftLeft1[0m, time elapsed: 358400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftLeft1 (27600 ns)
    TCS: [33mTestCase_testComputeVecShiftLeft3[0m, time elapsed: 322500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftLeft3 (19100 ns)
    TCS: [33mTestCase_testComputeVecShiftRight1[0m, time elapsed: 321000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftRight1 (24000 ns)
    TCS: [33mTestCase_testComputeVecShiftRight4[0m, time elapsed: 391900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftRight4 (26500 ns)
    TCS: [33mTestCase_testComputeVecEqual1[0m, time elapsed: 427000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual1 (29600 ns)
    TCS: [33mTestCase_testComputeVecNequal4[0m, time elapsed: 415200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal4 (30100 ns)
    TCS: [33mTestCase_testComputeVecBitwiseNot1[0m, time elapsed: 454100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecBitwiseNot1 (32800 ns)
    TCS: [33mTestCase_testComputeVecBitwiseNot3[0m, time elapsed: 418400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecBitwiseNot3 (46800 ns)
    TCS: [33mTestCase_testComputeVecAdd4[0m, time elapsed: 277500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAdd4 (22000 ns)
    TCS: [33mTestCase_testComputeVecSub1[0m, time elapsed: 1006300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub1 (20100 ns)
    TCS: [33mTestCase_testComputeVecSub3[0m, time elapsed: 687500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub3 (100500 ns)
    TCS: [33mTestCase_testComputeVecMul1[0m, time elapsed: 373500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul1 (35100 ns)
    TCS: [33mTestCase_testComputeVecMul2[0m, time elapsed: 429000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul2 (39900 ns)
    TCS: [33mTestCase_testComputeVecDiv1[0m, time elapsed: 372600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecDiv1 (45500 ns)
    TCS: [33mTestCase_testComputeVecDiv2[0m, time elapsed: 325900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecDiv2 (29400 ns)
    TCS: [33mTestCase_testComputeVecDiv4[0m, time elapsed: 261400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecDiv4 (21100 ns)
    TCS: [33mTestCase_testComputeVecEqual2[0m, time elapsed: 215000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual2 (17900 ns)
    TCS: [33mTestCase_testComputeVecEqual3[0m, time elapsed: 250200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual3 (18400 ns)
    TCS: [33mTestCase_testComputeVecEqual4[0m, time elapsed: 257600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual4 (20800 ns)
    TCS: [33mTestCase_testComputeVecNequal1[0m, time elapsed: 240200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal1 (19300 ns)
    TCS: [33mTestCase_testComputeVecNequal2[0m, time elapsed: 239500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal2 (10700 ns)
    TCS: [33mTestCase_testComputeVecBitwiseNot4[0m, time elapsed: 250800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecBitwiseNot4 (25700 ns)
    TCS: [33mTestCase_testComputeVecAddFloat32[0m, time elapsed: 230100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAddFloat32 (28300 ns)
    TCS: [33mTestCase_testComputeVecAddFloat32Vec3[0m, time elapsed: 258900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAddFloat32Vec3 (28100 ns)
    TCS: [33mTestCase_testComputeVecSubFloat32[0m, time elapsed: 246200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSubFloat32 (22800 ns)
    TCS: [33mTestCase_testComputeVecSubFloat32Vec4[0m, time elapsed: 232200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSubFloat32Vec4 (25500 ns)
    TCS: [33mTestCase_testComputeEqualInt32Equal[0m, time elapsed: 240800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt32Equal (18500 ns)
    TCS: [33mTestCase_testComputeEqualInt32NotEqual[0m, time elapsed: 226000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt32NotEqual (18600 ns)
    TCS: [33mTestCase_testComputeEqualFloat32Equal[0m, time elapsed: 226200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32Equal (15200 ns)
    TCS: [33mTestCase_testComputeEqualFloat32NotEqual[0m, time elapsed: 238400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32NotEqual (11100 ns)
    TCS: [33mTestCase_testComputeEqualFloat64Equal[0m, time elapsed: 236300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64Equal (11900 ns)
    TCS: [33mTestCase_testComputeEqualFloat64NotEqual[0m, time elapsed: 255400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64NotEqual (14300 ns)
    TCS: [33mTestCase_testComputeEqualBoolEqual[0m, time elapsed: 246400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualBoolEqual (18800 ns)
    TCS: [33mTestCase_testComputeEqualBoolNotEqual[0m, time elapsed: 218200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualBoolNotEqual (17200 ns)
    TCS: [33mTestCase_testComputeEqualNumericInt32[0m, time elapsed: 202900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericInt32 (11500 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32[0m, time elapsed: 228400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32 (32000 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32Epsilon[0m, time elapsed: 215800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32Epsilon (11900 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64[0m, time elapsed: 211000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64 (26000 ns)
    TCS: [33mTestCase_testComputeEqualInt64Equal[0m, time elapsed: 189600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt64Equal (12500 ns)
    TCS: [33mTestCase_testComputeEqualInt64NotEqual[0m, time elapsed: 210000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt64NotEqual (8700 ns)
    TCS: [33mTestCase_testComputeEqualFloat32Nan[0m, time elapsed: 192300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32Nan (8500 ns)
    TCS: [33mTestCase_testComputeEqualFloat64Nan[0m, time elapsed: 185800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64Nan (9500 ns)
    TCS: [33mTestCase_testComputeEqualFloat32SignedZero[0m, time elapsed: 183900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32SignedZero (9200 ns)
    TCS: [33mTestCase_testComputeEqualFloat64SignedZero[0m, time elapsed: 189000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64SignedZero (11200 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32NotEqual[0m, time elapsed: 199500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32NotEqual (14700 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32BeyondEpsilon[0m, time elapsed: 192300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32BeyondEpsilon (10500 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64NotEqual[0m, time elapsed: 206200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64NotEqual (12300 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64Epsilon[0m, time elapsed: 196200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64Epsilon (12200 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64BeyondEpsilon[0m, time elapsed: 194600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64BeyondEpsilon (13500 ns)
    TCS: [33mTestCase_testComputeEqualNumericInt64[0m, time elapsed: 187500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericInt64 (9600 ns)
    TCS: [33mTestCase_testPackedHighpImplementsQualifier[0m, time elapsed: 182900 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedHighpImplementsQualifier (7600 ns)
    TCS: [33mTestCase_testPackedMediumpImplementsQualifier[0m, time elapsed: 185600 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedMediumpImplementsQualifier (7700 ns)
    TCS: [33mTestCase_testPackedLowpImplementsQualifier[0m, time elapsed: 187700 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedLowpImplementsQualifier (7800 ns)
    TCS: [33mTestCase_testDefaultpIsPackedHighp[0m, time elapsed: 197400 ns, RESULT:
    [[32m PASSED [0m] CASE: testDefaultpIsPackedHighp (8600 ns)
    TCS: [33mTestCase_testScalarAddVec1[0m, time elapsed: 348000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec1 (28000 ns)
    TCS: [33mTestCase_testScalarAddVec2[0m, time elapsed: 306600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec2 (24600 ns)
    TCS: [33mTestCase_testScalarAddVec3[0m, time elapsed: 318800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec3 (23800 ns)
    TCS: [33mTestCase_testScalarAddVec4[0m, time elapsed: 331300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec4 (23500 ns)
    TCS: [33mTestCase_testScalarSubVec1[0m, time elapsed: 277500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1 (33100 ns)
    TCS: [33mTestCase_testScalarMulVec1[0m, time elapsed: 246000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1 (28300 ns)
    TCS: [33mTestCase_testScalarDivVec1[0m, time elapsed: 204800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1 (12600 ns)
    TCS: [33mTestCase_testScalarModVec1[0m, time elapsed: 206900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1 (15300 ns)
    TCS: [33mTestCase_testScalarMulVec2[0m, time elapsed: 201100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2 (13600 ns)
    TCS: [33mTestCase_testScalarSubVec2[0m, time elapsed: 197000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2 (9100 ns)
    TCS: [33mTestCase_testScalarSubVec3[0m, time elapsed: 199400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3 (11600 ns)
    TCS: [33mTestCase_testScalarSubVec4[0m, time elapsed: 187600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4 (14600 ns)
    TCS: [33mTestCase_testScalarMulVec3[0m, time elapsed: 190700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3 (9700 ns)
    TCS: [33mTestCase_testScalarMulVec4[0m, time elapsed: 201600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4 (12900 ns)
    TCS: [33mTestCase_testScalarDivVec2[0m, time elapsed: 195800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2 (10700 ns)
    TCS: [33mTestCase_testScalarDivVec3[0m, time elapsed: 188000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3 (8600 ns)
    TCS: [33mTestCase_testScalarDivVec4[0m, time elapsed: 200300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4 (15400 ns)
    TCS: [33mTestCase_testScalarModVec2[0m, time elapsed: 201000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2 (9400 ns)
    TCS: [33mTestCase_testScalarModVec3[0m, time elapsed: 222200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3 (13800 ns)
    TCS: [33mTestCase_testScalarModVec4[0m, time elapsed: 196800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4 (12600 ns)
    TCS: [33mTestCase_testScalarModVec1Float32[0m, time elapsed: 225400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float32 (25000 ns)
    TCS: [33mTestCase_testScalarModVec2Float32[0m, time elapsed: 207400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32 (9500 ns)
    TCS: [33mTestCase_testScalarModVec3Float32[0m, time elapsed: 203000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float32 (16900 ns)
    TCS: [33mTestCase_testScalarModVec4Float32[0m, time elapsed: 258800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float32 (12900 ns)
    TCS: [33mTestCase_testScalarModVec1Float64[0m, time elapsed: 204100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float64 (11200 ns)
    TCS: [33mTestCase_testScalarModVec2Float64[0m, time elapsed: 197200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float64 (9600 ns)
    TCS: [33mTestCase_testScalarModVec3Float64[0m, time elapsed: 206900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float64 (9000 ns)
    TCS: [33mTestCase_testScalarModVec4Float64[0m, time elapsed: 268200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float64 (18200 ns)
    TCS: [33mTestCase_testScalarModVec1Float16[0m, time elapsed: 233300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float16 (24800 ns)
    TCS: [33mTestCase_testScalarModVec2Float16[0m, time elapsed: 209000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float16 (10700 ns)
    TCS: [33mTestCase_testScalarModVec3Float16[0m, time elapsed: 233500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float16 (12200 ns)
    TCS: [33mTestCase_testScalarModVec4Float16[0m, time elapsed: 257300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float16 (12300 ns)
    TCS: [33mTestCase_testScalarSubVec2PackedMediump[0m, time elapsed: 268400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2PackedMediump (24100 ns)
    TCS: [33mTestCase_testScalarSubVec2PackedLowp[0m, time elapsed: 218900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2PackedLowp (20100 ns)
    TCS: [33mTestCase_testScalarMulVec2PackedMediump[0m, time elapsed: 198600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2PackedMediump (12400 ns)
    TCS: [33mTestCase_testScalarMulVec2PackedLowp[0m, time elapsed: 199000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2PackedLowp (13000 ns)
    TCS: [33mTestCase_testScalarDivVec2PackedMediump[0m, time elapsed: 221100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2PackedMediump (13400 ns)
    TCS: [33mTestCase_testScalarDivVec2PackedLowp[0m, time elapsed: 204100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2PackedLowp (12100 ns)
    TCS: [33mTestCase_testScalarModVec2PackedMediump[0m, time elapsed: 198400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2PackedMediump (9900 ns)
    TCS: [33mTestCase_testScalarModVec2PackedLowp[0m, time elapsed: 213000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2PackedLowp (9600 ns)
    TCS: [33mTestCase_testScalarModVec2Float32PackedMediump[0m, time elapsed: 215600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32PackedMediump (12200 ns)
    TCS: [33mTestCase_testScalarModVec2Float32PackedLowp[0m, time elapsed: 199400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32PackedLowp (10600 ns)
    TCS: [33mTestCase_testScalarModVec2Float32NegativeDividend[0m, time elapsed: 195000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32NegativeDividend (9800 ns)
    TCS: [33mTestCase_testScalarModVec2Float32NegativeDivisor[0m, time elapsed: 204200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32NegativeDivisor (11700 ns)
    TCS: [33mTestCase_testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents[0m, time elapsed: 365300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents (157800 ns)
    TCS: [33mTestCase_testScalarAddVec1Float32[0m, time elapsed: 193200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec1Float32 (11200 ns)
    TCS: [33mTestCase_testScalarAddVec2Float32[0m, time elapsed: 183000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec2Float32 (12400 ns)
    TCS: [33mTestCase_testScalarAddVec3Float32[0m, time elapsed: 185000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec3Float32 (9300 ns)
    TCS: [33mTestCase_testScalarAddVec4Float32[0m, time elapsed: 187300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec4Float32 (9500 ns)
    TCS: [33mTestCase_testScalarSubVec1Float32[0m, time elapsed: 343100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1Float32 (22900 ns)
    TCS: [33mTestCase_testScalarSubVec2Float32[0m, time elapsed: 287700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2Float32 (18000 ns)
    TCS: [33mTestCase_testScalarSubVec3Float32[0m, time elapsed: 216300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3Float32 (11800 ns)
    TCS: [33mTestCase_testScalarSubVec4Float32[0m, time elapsed: 208200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4Float32 (15400 ns)
    TCS: [33mTestCase_testScalarMulVec1Float32[0m, time elapsed: 222700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1Float32 (13800 ns)
    TCS: [33mTestCase_testScalarMulVec2Float32[0m, time elapsed: 208300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2Float32 (10500 ns)
    TCS: [33mTestCase_testScalarMulVec3Float32[0m, time elapsed: 209500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3Float32 (12000 ns)
    TCS: [33mTestCase_testScalarMulVec4Float32[0m, time elapsed: 207900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4Float32 (12900 ns)
    TCS: [33mTestCase_testScalarDivVec1Float32[0m, time elapsed: 202700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1Float32 (10500 ns)
    TCS: [33mTestCase_testScalarDivVec2Float32[0m, time elapsed: 194700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2Float32 (9700 ns)
    TCS: [33mTestCase_testScalarDivVec3Float32[0m, time elapsed: 193300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3Float32 (13100 ns)
    TCS: [33mTestCase_testScalarDivVec4Float32[0m, time elapsed: 187900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4Float32 (9900 ns)
    TCS: [33mTestCase_testScalarAddVec1Int32[0m, time elapsed: 200400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec1Int32 (19900 ns)
    TCS: [33mTestCase_testScalarAddVec2Int32[0m, time elapsed: 191400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec2Int32 (10500 ns)
    TCS: [33mTestCase_testScalarAddVec3Int32[0m, time elapsed: 194500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec3Int32 (14000 ns)
    TCS: [33mTestCase_testScalarAddVec4Int32[0m, time elapsed: 202300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec4Int32 (14100 ns)
    TCS: [33mTestCase_testScalarSubVec1Int32[0m, time elapsed: 208400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1Int32 (18800 ns)
    TCS: [33mTestCase_testScalarSubVec2Int32[0m, time elapsed: 201700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2Int32 (11100 ns)
    TCS: [33mTestCase_testScalarSubVec3Int32[0m, time elapsed: 198600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3Int32 (9500 ns)
    TCS: [33mTestCase_testScalarSubVec4Int32[0m, time elapsed: 191500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4Int32 (10700 ns)
    TCS: [33mTestCase_testScalarMulVec1Int32[0m, time elapsed: 188400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1Int32 (9000 ns)
    TCS: [33mTestCase_testScalarMulVec2Int32[0m, time elapsed: 193200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2Int32 (12000 ns)
    TCS: [33mTestCase_testScalarMulVec3Int32[0m, time elapsed: 191200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3Int32 (9300 ns)
    TCS: [33mTestCase_testScalarMulVec4Int32[0m, time elapsed: 231700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4Int32 (9900 ns)
    TCS: [33mTestCase_testScalarDivVec1Int32[0m, time elapsed: 183700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1Int32 (8400 ns)
    TCS: [33mTestCase_testScalarDivVec2Int32[0m, time elapsed: 189200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2Int32 (7900 ns)
    TCS: [33mTestCase_testScalarDivVec3Int32[0m, time elapsed: 194100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3Int32 (9200 ns)
    TCS: [33mTestCase_testScalarDivVec4Int32[0m, time elapsed: 195400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4Int32 (16200 ns)
    TCS: [33mTestCase_testScalarModVec1Int32[0m, time elapsed: 204600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Int32 (10400 ns)
    TCS: [33mTestCase_testScalarModVec2Int32[0m, time elapsed: 192200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Int32 (9300 ns)
    TCS: [33mTestCase_testScalarModVec3Int32[0m, time elapsed: 197200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Int32 (8700 ns)
    TCS: [33mTestCase_testScalarModVec4Int32[0m, time elapsed: 183200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Int32 (8500 ns)
    TCS: [33mTestCase_testScalarSubVec1PackedMediump[0m, time elapsed: 199700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1PackedMediump (13800 ns)
    TCS: [33mTestCase_testScalarSubVec1PackedLowp[0m, time elapsed: 188600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1PackedLowp (9700 ns)
    TCS: [33mTestCase_testScalarSubVec3PackedMediump[0m, time elapsed: 214900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3PackedMediump (10300 ns)
    TCS: [33mTestCase_testScalarSubVec3PackedLowp[0m, time elapsed: 194800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3PackedLowp (16900 ns)
    TCS: [33mTestCase_testScalarSubVec4PackedMediump[0m, time elapsed: 195500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4PackedMediump (13000 ns)
    TCS: [33mTestCase_testScalarSubVec4PackedLowp[0m, time elapsed: 305700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4PackedLowp (11400 ns)
    TCS: [33mTestCase_testScalarMulVec1PackedMediump[0m, time elapsed: 201200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1PackedMediump (9800 ns)
    TCS: [33mTestCase_testScalarMulVec1PackedLowp[0m, time elapsed: 190500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1PackedLowp (12100 ns)
    TCS: [33mTestCase_testScalarMulVec3PackedMediump[0m, time elapsed: 186300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3PackedMediump (10700 ns)
    TCS: [33mTestCase_testScalarMulVec3PackedLowp[0m, time elapsed: 198100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3PackedLowp (9600 ns)
    TCS: [33mTestCase_testScalarMulVec4PackedMediump[0m, time elapsed: 206100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4PackedMediump (15700 ns)
    TCS: [33mTestCase_testScalarMulVec4PackedLowp[0m, time elapsed: 204600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4PackedLowp (9100 ns)
    TCS: [33mTestCase_testScalarDivVec1PackedMediump[0m, time elapsed: 189600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1PackedMediump (9800 ns)
    TCS: [33mTestCase_testScalarDivVec1PackedLowp[0m, time elapsed: 191500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1PackedLowp (10400 ns)
    TCS: [33mTestCase_testScalarDivVec3PackedMediump[0m, time elapsed: 187700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3PackedMediump (10500 ns)
    TCS: [33mTestCase_testScalarDivVec3PackedLowp[0m, time elapsed: 187000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3PackedLowp (8500 ns)
    TCS: [33mTestCase_testScalarDivVec4PackedMediump[0m, time elapsed: 181300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4PackedMediump (12100 ns)
    TCS: [33mTestCase_testScalarDivVec4PackedLowp[0m, time elapsed: 190200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4PackedLowp (8900 ns)
    TCS: [33mTestCase_testScalarModVec1PackedMediump[0m, time elapsed: 190900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1PackedMediump (8900 ns)
    TCS: [33mTestCase_testScalarModVec1PackedLowp[0m, time elapsed: 179500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1PackedLowp (8400 ns)
    TCS: [33mTestCase_testScalarModVec3PackedMediump[0m, time elapsed: 181000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3PackedMediump (9800 ns)
    TCS: [33mTestCase_testScalarModVec3PackedLowp[0m, time elapsed: 198900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3PackedLowp (12900 ns)
    TCS: [33mTestCase_testScalarModVec4PackedMediump[0m, time elapsed: 201000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4PackedMediump (8200 ns)
    TCS: [33mTestCase_testScalarModVec4PackedLowp[0m, time elapsed: 276800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4PackedLowp (11500 ns)
    TCS: [33mTestCase_testScalarDivZeroVec1[0m, time elapsed: 268100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivZeroVec1 (24600 ns)
    TCS: [33mTestCase_testScalarAddNegVec1[0m, time elapsed: 296300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddNegVec1 (19700 ns)
    TCS: [33mTestCase_testScalarAddNegVec2[0m, time elapsed: 267100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddNegVec2 (15000 ns)
    TCS: [33mTestCase_testScalarMulOverflowVec1[0m, time elapsed: 191900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulOverflowVec1 (12000 ns)
    TCS: [33mTestCase_testScalarSubNegVec1[0m, time elapsed: 211000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubNegVec1 (10600 ns)
    TCS: [33mTestCase_testVersionMajor[0m, time elapsed: 221800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionMajor (12200 ns)
    TCS: [33mTestCase_testVersionMinor[0m, time elapsed: 239800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionMinor (9700 ns)
    TCS: [33mTestCase_testVersionPatch[0m, time elapsed: 264900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionPatch (12800 ns)
    TCS: [33mTestCase_testVersionEncoded[0m, time elapsed: 292900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionEncoded (28300 ns)
    TCS: [33mTestCase_testConfigSimd[0m, time elapsed: 348200 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigSimd (34100 ns)
    TCS: [33mTestCase_testConfigAlignedGentypes[0m, time elapsed: 259200 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigAlignedGentypes (12700 ns)
    TCS: [33mTestCase_testConfigClipControl[0m, time elapsed: 375400 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigClipControl (14300 ns)
    TCS: [33mTestCase_testConstNegationSimd[0m, time elapsed: 294000 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationSimd (16300 ns)
    TCS: [33mTestCase_testConstNegationAligned[0m, time elapsed: 220500 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationAligned (9300 ns)
    TCS: [33mTestCase_testConstNegationClip[0m, time elapsed: 206800 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationClip (8300 ns)
    TCS: [33mTestCase_testConstInt64Usage[0m, time elapsed: 248000 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstInt64Usage (10800 ns)
    TCS: [33mTestCase_testConstBoolUsage[0m, time elapsed: 207800 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstBoolUsage (9400 ns)
    TCS: [33mTestCase_testVersionEncodingConsistency[0m, time elapsed: 232700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionEncodingConsistency (10400 ns)
    TCS: [33mTestCase_testAssertPasses[0m, time elapsed: 238400 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertPasses (29800 ns)
    TCS: [33mTestCase_testAssertFails[0m, time elapsed: 305700 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertFails (73300 ns)
    TCS: [33mTestCase_testAssertWithCustomMessage[0m, time elapsed: 303000 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertWithCustomMessage (53200 ns)
    TCS: [33mTestCase_testNumericLimitsFloat32Epsilon[0m, time elapsed: 215200 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsFloat32Epsilon (12700 ns)
    TCS: [33mTestCase_testNumericLimitsFloat64Epsilon[0m, time elapsed: 194400 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsFloat64Epsilon (12600 ns)
    TCS: [33mTestCase_testIsIec559OfFloat32[0m, time elapsed: 197000 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfFloat32 (9700 ns)
    TCS: [33mTestCase_testIsIec559OfFloat64[0m, time elapsed: 220400 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfFloat64 (8500 ns)
    TCS: [33mTestCase_testIsIec559OfInt64[0m, time elapsed: 215400 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfInt64 (16100 ns)
    TCS: [33mTestCase_testEpsilonOfFloat32[0m, time elapsed: 203500 ns, RESULT:
    [[32m PASSED [0m] CASE: testEpsilonOfFloat32 (13500 ns)
    TCS: [33mTestCase_testEpsilonOfFloat64[0m, time elapsed: 201300 ns, RESULT:
    [[32m PASSED [0m] CASE: testEpsilonOfFloat64 (10000 ns)
    TCS: [33mTestCase_testNumericLimitsInt64Epsilon[0m, time elapsed: 206700 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt64Epsilon (11600 ns)
    TCS: [33mTestCase_testNumericLimitsInt32Epsilon[0m, time elapsed: 279600 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt32Epsilon (14300 ns)
    TCS: [33mTestCase_testNumericLimitsInt16Epsilon[0m, time elapsed: 255200 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt16Epsilon (17300 ns)
    TCS: [33mTestCase_testNumericLimitsInt8Epsilon[0m, time elapsed: 473100 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt8Epsilon (47400 ns)
    TCS: [33mTestCase_testCastVec1ToVec1IntToFloat[0m, time elapsed: 437700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec1ToVec1IntToFloat (43500 ns)
    TCS: [33mTestCase_testCastVec2ToVec1TakesOnlyX[0m, time elapsed: 393000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2ToVec1TakesOnlyX (37300 ns)
    TCS: [33mTestCase_testCastVec3ToVec1TakesOnlyX[0m, time elapsed: 362000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3ToVec1TakesOnlyX (30600 ns)
    TCS: [33mTestCase_testCastVec4ToVec1TakesOnlyX[0m, time elapsed: 353400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4ToVec1TakesOnlyX (31100 ns)
    TCS: [33mTestCase_testCastSameTypeIdentity[0m, time elapsed: 385400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastSameTypeIdentity (36500 ns)
    TCS: [33mTestCase_testCastInt32ToInt64[0m, time elapsed: 398700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastInt32ToInt64 (37200 ns)
    TCS: [33mTestCase_testCastFloatToIntTruncation[0m, time elapsed: 320600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastFloatToIntTruncation (17800 ns)
    TCS: [33mTestCase_testCastCrossQualifierPackedHighpToDefaultp[0m, time elapsed: 673900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastCrossQualifierPackedHighpToDefaultp (24600 ns)
    TCS: [33mTestCase_testCastCrossQualifierDefaultpToPackedHighp[0m, time elapsed: 266600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastCrossQualifierDefaultpToPackedHighp (19400 ns)
    TCS: [33mTestCase_testCastVec2CrossQualifierCrossType[0m, time elapsed: 240500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2CrossQualifierCrossType (14400 ns)
    TCS: [33mTestCase_testCastVec3CrossQualifier[0m, time elapsed: 210600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3CrossQualifier (12500 ns)
    TCS: [33mTestCase_testCastVec4CrossQualifier[0m, time elapsed: 224500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4CrossQualifier (8200 ns)
    TCS: [33mTestCase_testCastVec1DoesNotModifySource[0m, time elapsed: 208300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec1DoesNotModifySource (8100 ns)
    TCS: [33mTestCase_testCastVec2Vec1ToVec2IntToFloat[0m, time elapsed: 231100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec1ToVec2IntToFloat (16800 ns)
    TCS: [33mTestCase_testCastVec2Vec2ToVec2Identity[0m, time elapsed: 257500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec2ToVec2Identity (19900 ns)
    TCS: [33mTestCase_testCastVec2Vec3ToVec2TakesOnlyXY[0m, time elapsed: 243400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec3ToVec2TakesOnlyXY (11200 ns)
    TCS: [33mTestCase_testCastVec2Vec4ToVec2TakesOnlyXY[0m, time elapsed: 224800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec4ToVec2TakesOnlyXY (9100 ns)
    TCS: [33mTestCase_testCastVec2SameTypeIdentity[0m, time elapsed: 232100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2SameTypeIdentity (8700 ns)
    TCS: [33mTestCase_testCastVec2Int32ToInt64[0m, time elapsed: 274300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Int32ToInt64 (12200 ns)
    TCS: [33mTestCase_testCastVec2FloatToIntTruncation[0m, time elapsed: 283700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2FloatToIntTruncation (8500 ns)
    TCS: [33mTestCase_testCastVec2CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 313000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2CrossQualifierPackedHighpToDefaultp (12900 ns)
    TCS: [33mTestCase_testCastVec2DoesNotModifySource[0m, time elapsed: 269100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2DoesNotModifySource (11900 ns)
    TCS: [33mTestCase_testCastVec2Vec1ToVec2SameValueBothComponents[0m, time elapsed: 281500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec1ToVec2SameValueBothComponents (12800 ns)
    TCS: [33mTestCase_testCastVec3Vec1ToVec3IntToFloat[0m, time elapsed: 314300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec1ToVec3IntToFloat (26000 ns)
    TCS: [33mTestCase_testCastVec3Vec2ToVec3ExtendY[0m, time elapsed: 431700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec2ToVec3ExtendY (29500 ns)
    TCS: [33mTestCase_testCastVec3Vec3ToVec3Identity[0m, time elapsed: 316900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec3ToVec3Identity (14400 ns)
    TCS: [33mTestCase_testCastVec3Vec4ToVec3TakesOnlyXYZ[0m, time elapsed: 304900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec4ToVec3TakesOnlyXYZ (20900 ns)
    TCS: [33mTestCase_testCastVec3SameTypeIdentity[0m, time elapsed: 252000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3SameTypeIdentity (11600 ns)
    TCS: [33mTestCase_testCastVec3Int32ToInt64[0m, time elapsed: 260500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Int32ToInt64 (12200 ns)
    TCS: [33mTestCase_testCastVec3FloatToIntTruncation[0m, time elapsed: 277900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3FloatToIntTruncation (16300 ns)
    TCS: [33mTestCase_testCastVec3CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 284500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3CrossQualifierPackedHighpToDefaultp (12300 ns)
    TCS: [33mTestCase_testCastVec3DoesNotModifySource[0m, time elapsed: 282000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3DoesNotModifySource (11800 ns)
    TCS: [33mTestCase_testCastVec3Vec1ToVec3SameValueAllComponents[0m, time elapsed: 279100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec1ToVec3SameValueAllComponents (12900 ns)
    TCS: [33mTestCase_testCastVec4Vec1ToVec4IntToFloat[0m, time elapsed: 342500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec1ToVec4IntToFloat (17800 ns)
    TCS: [33mTestCase_testCastVec4Vec2ToVec4ExtendY[0m, time elapsed: 239600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec2ToVec4ExtendY (26700 ns)
    TCS: [33mTestCase_testCastVec4Vec3ToVec4ExtendZ[0m, time elapsed: 220300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec3ToVec4ExtendZ (14000 ns)
    TCS: [33mTestCase_testCastVec4Vec4ToVec4Identity[0m, time elapsed: 213200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec4ToVec4Identity (13400 ns)
    TCS: [33mTestCase_testCastVec4SameTypeIdentity[0m, time elapsed: 178200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4SameTypeIdentity (7200 ns)
    TCS: [33mTestCase_testCastVec4Int32ToInt64[0m, time elapsed: 172900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Int32ToInt64 (7500 ns)
    TCS: [33mTestCase_testCastVec4FloatToIntTruncation[0m, time elapsed: 257600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4FloatToIntTruncation (7900 ns)
    TCS: [33mTestCase_testCastVec4CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 363800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4CrossQualifierPackedHighpToDefaultp (14100 ns)
    TCS: [33mTestCase_testCastVec4DoesNotModifySource[0m, time elapsed: 282700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4DoesNotModifySource (11000 ns)
    TCS: [33mTestCase_testCastVec4Vec1ToVec4SameValueAllComponents[0m, time elapsed: 174000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec1ToVec4SameValueAllComponents (7400 ns)
    TCS: [33mTestCase_testFromBoolVec1[0m, time elapsed: 168800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec1 (6000 ns)
    TCS: [33mTestCase_testFromBoolVec1False[0m, time elapsed: 256800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec1False (9000 ns)
    TCS: [33mTestCase_testFromBoolVec2[0m, time elapsed: 187100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec2 (10800 ns)
    TCS: [33mTestCase_testFromBoolVec3[0m, time elapsed: 177600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec3 (7800 ns)
    TCS: [33mTestCase_testFromBoolVec4[0m, time elapsed: 176300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec4 (6800 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec1[0m, time elapsed: 173500 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec1 (7300 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec2[0m, time elapsed: 171800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec2 (6500 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec3[0m, time elapsed: 177300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec3 (16900 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec4[0m, time elapsed: 168100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec4 (5900 ns)
    TCS: [33mTestCase_testFromBoolVec3AllFalse[0m, time elapsed: 272000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec3AllFalse (11600 ns)
    TCS: [33mTestCase_testFromBoolVec4AllFalse[0m, time elapsed: 221300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec4AllFalse (12200 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec3AllFalse[0m, time elapsed: 197900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec3AllFalse (8200 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec4AllFalse[0m, time elapsed: 197800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec4AllFalse (8200 ns)
    TCS: [33mTestCase_testFromBoolVecFloat32[0m, time elapsed: 182300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecFloat32 (12000 ns)
    TCS: [33mTestCase_testFromBoolVecFloat64[0m, time elapsed: 173400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecFloat64 (8800 ns)
    TCS: [33mTestCase_testFromBoolVecInt32[0m, time elapsed: 185100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecInt32 (10200 ns)
    TCS: [33mTestCase_testFromBoolVecQ2PackedMediump[0m, time elapsed: 175600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2PackedMediump (6700 ns)
    TCS: [33mTestCase_testFromBoolVecQ2PackedLowp[0m, time elapsed: 185600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2PackedLowp (6900 ns)
    TCS: [33mTestCase_testVec1ConstInit[0m, time elapsed: 190300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ConstInit (16300 ns)
    TCS: [33mTestCase_testVec1Length[0m, time elapsed: 198400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Length (16300 ns)
    TCS: [33mTestCase_testVec1IndexAccess[0m, time elapsed: 184500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1IndexAccess (11800 ns)
    TCS: [33mTestCase_testVec1IndexMutate[0m, time elapsed: 181300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1IndexMutate (6000 ns)
    TCS: [33mTestCase_testVec1ComponentAt[0m, time elapsed: 170300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ComponentAt (5700 ns)
    TCS: [33mTestCase_testVec1Add[0m, time elapsed: 178400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Add (11800 ns)
    TCS: [33mTestCase_testVec1Sub[0m, time elapsed: 184900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Sub (14500 ns)
    TCS: [33mTestCase_testVec1Mul[0m, time elapsed: 195200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Mul (17400 ns)
    TCS: [33mTestCase_testVec1Div[0m, time elapsed: 175100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Div (9400 ns)
    TCS: [33mTestCase_testVec1Mod[0m, time elapsed: 180100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Mod (11100 ns)
    TCS: [33mTestCase_testVec1ScalarAdd[0m, time elapsed: 178400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarAdd (8100 ns)
    TCS: [33mTestCase_testVec1Negate[0m, time elapsed: 175200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Negate (5800 ns)
    TCS: [33mTestCase_testVec1AddNamed[0m, time elapsed: 168100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1AddNamed (5600 ns)
    TCS: [33mTestCase_testVec1SubNamed[0m, time elapsed: 174900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1SubNamed (10800 ns)
    TCS: [33mTestCase_testVec1MulNamed[0m, time elapsed: 170800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1MulNamed (6000 ns)
    TCS: [33mTestCase_testVec1Equal[0m, time elapsed: 190900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Equal (12800 ns)
    TCS: [33mTestCase_testVec1NotEqual[0m, time elapsed: 167200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1NotEqual (6100 ns)
    TCS: [33mTestCase_testVec1EqualExact[0m, time elapsed: 172800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1EqualExact (11800 ns)
    TCS: [33mTestCase_testVec1BitwiseAnd[0m, time elapsed: 179900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BitwiseAnd (8700 ns)
    TCS: [33mTestCase_testVec1BitwiseOr[0m, time elapsed: 198500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BitwiseOr (8300 ns)
    TCS: [33mTestCase_testVec1BitwiseXor[0m, time elapsed: 175200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BitwiseXor (8300 ns)
    TCS: [33mTestCase_testVec1ShiftLeft[0m, time elapsed: 179400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ShiftLeft (9400 ns)
    TCS: [33mTestCase_testVec1ShiftRight[0m, time elapsed: 181600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ShiftRight (11600 ns)
    TCS: [33mTestCase_testVec1BitwiseNot[0m, time elapsed: 177200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BitwiseNot (5900 ns)
    TCS: [33mTestCase_testVec1BoolLogicalAnd[0m, time elapsed: 175900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BoolLogicalAnd (9900 ns)
    TCS: [33mTestCase_testVec1BoolLogicalOr[0m, time elapsed: 169800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BoolLogicalOr (5900 ns)
    TCS: [33mTestCase_testVec1IndexOutOfBoundsAccess[0m, time elapsed: 241800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1IndexOutOfBoundsAccess (65400 ns)
    TCS: [33mTestCase_testVec1ShiftVec[0m, time elapsed: 173900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ShiftVec (5800 ns)
    TCS: [33mTestCase_testVec1ScalarSub[0m, time elapsed: 168900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarSub (9600 ns)
    TCS: [33mTestCase_testVec1ScalarMul[0m, time elapsed: 169300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarMul (5800 ns)
    TCS: [33mTestCase_testVec1ScalarDiv[0m, time elapsed: 181700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarDiv (5500 ns)
    TCS: [33mTestCase_testVec1ScalarMod[0m, time elapsed: 172900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarMod (5900 ns)
    TCS: [33mTestCase_testVec1DivNamed[0m, time elapsed: 171300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1DivNamed (5600 ns)
    TCS: [33mTestCase_testVec1ModNamed[0m, time elapsed: 170800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ModNamed (10000 ns)
    TCS: [33mTestCase_testVec1ScalarBitwiseAnd[0m, time elapsed: 181600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarBitwiseAnd (11800 ns)
    TCS: [33mTestCase_testVec1ScalarBitwiseOr[0m, time elapsed: 175200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarBitwiseOr (8500 ns)
    TCS: [33mTestCase_testVec1ScalarBitwiseXor[0m, time elapsed: 161000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarBitwiseXor (5800 ns)
    TCS: [33mTestCase_testVec1ShiftRightVec[0m, time elapsed: 164200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ShiftRightVec (5200 ns)
    TCS: [33mTestCase_testVec1EqualEpsilon[0m, time elapsed: 185500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1EqualEpsilon (12200 ns)
    TCS: [33mTestCase_testVec1BroadcastAddVec2[0m, time elapsed: 174100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastAddVec2 (13200 ns)
    TCS: [33mTestCase_testVec1BroadcastBitAndVec2[0m, time elapsed: 389100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastBitAndVec2 (16400 ns)
    TCS: [33mTestCase_testVec1BroadcastAddVec3[0m, time elapsed: 340000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastAddVec3 (23200 ns)
    TCS: [33mTestCase_testVec1BroadcastAddVec4[0m, time elapsed: 300700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastAddVec4 (26100 ns)
    TCS: [33mTestCase_testVec1BroadcastBitOrVec2[0m, time elapsed: 256300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastBitOrVec2 (13600 ns)
    TCS: [33mTestCase_testVec1BroadcastBitXorVec2[0m, time elapsed: 296700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastBitXorVec2 (26900 ns)
    TCS: [33mTestCase_testVec1BroadcastShiftLeftVec2[0m, time elapsed: 280400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastShiftLeftVec2 (12300 ns)
    TCS: [33mTestCase_testVec1BroadcastShiftRightVec2[0m, time elapsed: 339500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastShiftRightVec2 (16900 ns)
    TCS: [33mTestCase_testVec1BroadcastBitAndVec3[0m, time elapsed: 1372200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastBitAndVec3 (92200 ns)
    TCS: [33mTestCase_testVec1BroadcastBitAndVec4[0m, time elapsed: 402800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastBitAndVec4 (32300 ns)
    TCS: [33mTestCase_testVec1BroadcastModVec2[0m, time elapsed: 410100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastModVec2 (28200 ns)
    TCS: [33mTestCase_testVec1BroadcastModVec3[0m, time elapsed: 344400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastModVec3 (32400 ns)
    TCS: [33mTestCase_testVec1BroadcastModVec4[0m, time elapsed: 301600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastModVec4 (21800 ns)
    TCS: [33mTestCase_testVec1Increment[0m, time elapsed: 318700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Increment (23500 ns)
    TCS: [33mTestCase_testVec1Decrement[0m, time elapsed: 267300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Decrement (11900 ns)
    TCS: [33mTestCase_testVec2ScalarInit[0m, time elapsed: 206000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarInit (14600 ns)
    TCS: [33mTestCase_testVec2ConstInit[0m, time elapsed: 193300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ConstInit (13300 ns)
    TCS: [33mTestCase_testVec2Length[0m, time elapsed: 195500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Length (6100 ns)
    TCS: [33mTestCase_testVec2Add[0m, time elapsed: 208100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Add (12900 ns)
    TCS: [33mTestCase_testVec2Sub[0m, time elapsed: 203500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Sub (13500 ns)
    TCS: [33mTestCase_testVec2Mul[0m, time elapsed: 216800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Mul (11500 ns)
    TCS: [33mTestCase_testVec2ScalarAdd[0m, time elapsed: 224900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarAdd (10400 ns)
    TCS: [33mTestCase_testVec2Negate[0m, time elapsed: 192000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Negate (14200 ns)
    TCS: [33mTestCase_testVec2IndexAccess[0m, time elapsed: 180400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2IndexAccess (6800 ns)
    TCS: [33mTestCase_testVec2IndexMutate[0m, time elapsed: 189000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2IndexMutate (10300 ns)
    TCS: [33mTestCase_testVec2ComponentAt[0m, time elapsed: 173100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ComponentAt (6200 ns)
    TCS: [33mTestCase_testVec2Equal[0m, time elapsed: 181300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Equal (12700 ns)
    TCS: [33mTestCase_testVec2NotEqual[0m, time elapsed: 175600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2NotEqual (12400 ns)
    TCS: [33mTestCase_testVec2EqualExact[0m, time elapsed: 187500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2EqualExact (8900 ns)
    TCS: [33mTestCase_testVec2BitwiseAnd[0m, time elapsed: 197900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseAnd (11800 ns)
    TCS: [33mTestCase_testVec2BitwiseNot[0m, time elapsed: 180900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseNot (7100 ns)
    TCS: [33mTestCase_testVec2FromVec1[0m, time elapsed: 169800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2FromVec1 (7300 ns)
    TCS: [33mTestCase_testVec2ShiftLeft[0m, time elapsed: 185700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeft (10300 ns)
    TCS: [33mTestCase_testVec2BoolLogicalAnd[0m, time elapsed: 182200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BoolLogicalAnd (10200 ns)
    TCS: [33mTestCase_testVec2Vec1ArithBroadcast[0m, time elapsed: 175400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Vec1ArithBroadcast (9200 ns)
    TCS: [33mTestCase_testVec2Vec1BitBroadcast[0m, time elapsed: 174400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Vec1BitBroadcast (10100 ns)
    TCS: [33mTestCase_testVec2ShiftLeftVec1[0m, time elapsed: 176500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeftVec1 (8800 ns)
    TCS: [33mTestCase_testVec2Div[0m, time elapsed: 217800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Div (14300 ns)
    TCS: [33mTestCase_testVec2Mod[0m, time elapsed: 189600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Mod (9400 ns)
    TCS: [33mTestCase_testVec2ScalarSub[0m, time elapsed: 178600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarSub (12400 ns)
    TCS: [33mTestCase_testVec2ScalarMul[0m, time elapsed: 184800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarMul (8900 ns)
    TCS: [33mTestCase_testVec2ScalarDiv[0m, time elapsed: 193700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarDiv (8600 ns)
    TCS: [33mTestCase_testVec2ScalarMod[0m, time elapsed: 272100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarMod (9400 ns)
    TCS: [33mTestCase_testVec2BoolLogicalOr[0m, time elapsed: 196000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BoolLogicalOr (8100 ns)
    TCS: [33mTestCase_testVec2EqualEpsilon[0m, time elapsed: 296500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2EqualEpsilon (34200 ns)
    TCS: [33mTestCase_testVec2DivNamed[0m, time elapsed: 329300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2DivNamed (17600 ns)
    TCS: [33mTestCase_testVec2ModNamed[0m, time elapsed: 346100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ModNamed (18700 ns)
    TCS: [33mTestCase_testVec2BitwiseOr[0m, time elapsed: 321000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseOr (22000 ns)
    TCS: [33mTestCase_testVec2BitwiseXor[0m, time elapsed: 256400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseXor (13800 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseAnd[0m, time elapsed: 236100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseAnd (14500 ns)
    TCS: [33mTestCase_testVec2ShiftRight[0m, time elapsed: 230800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRight (17500 ns)
    TCS: [33mTestCase_testVec2ShiftRightVec1[0m, time elapsed: 219400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRightVec1 (13500 ns)
    TCS: [33mTestCase_testVec2AddNamed[0m, time elapsed: 230100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2AddNamed (13000 ns)
    TCS: [33mTestCase_testVec2SubNamed[0m, time elapsed: 215600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2SubNamed (10100 ns)
    TCS: [33mTestCase_testVec2MulNamed[0m, time elapsed: 229600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2MulNamed (9200 ns)
    TCS: [33mTestCase_testVec2ShiftLeftVec[0m, time elapsed: 207700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeftVec (18200 ns)
    TCS: [33mTestCase_testVec2ShiftRightVec[0m, time elapsed: 192100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRightVec (8000 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseOr[0m, time elapsed: 207400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseOr (27200 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseXor[0m, time elapsed: 177700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseXor (11300 ns)
    TCS: [33mTestCase_testVec2Increment[0m, time elapsed: 181300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Increment (12100 ns)
    TCS: [33mTestCase_testVec2Decrement[0m, time elapsed: 183000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Decrement (11400 ns)
    TCS: [33mTestCase_testVec2IndexOutOfBoundsAccess[0m, time elapsed: 275200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2IndexOutOfBoundsAccess (56500 ns)
    TCS: [33mTestCase_testVec2NegativeIndexAccess[0m, time elapsed: 367200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2NegativeIndexAccess (56600 ns)
    TCS: [33mTestCase_testVec3ScalarInit[0m, time elapsed: 286500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarInit (16400 ns)
    TCS: [33mTestCase_testVec3ConstInit[0m, time elapsed: 252900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ConstInit (10400 ns)
    TCS: [33mTestCase_testVec3Length[0m, time elapsed: 254200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Length (10700 ns)
    TCS: [33mTestCase_testVec3Add[0m, time elapsed: 287700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Add (28200 ns)
    TCS: [33mTestCase_testVec3ScalarMul[0m, time elapsed: 243800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarMul (18000 ns)
    TCS: [33mTestCase_testVec3Negate[0m, time elapsed: 222200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Negate (13600 ns)
    TCS: [33mTestCase_testVec3IndexAccess[0m, time elapsed: 220300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3IndexAccess (14000 ns)
    TCS: [33mTestCase_testVec3IndexMutate[0m, time elapsed: 206100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3IndexMutate (6700 ns)
    TCS: [33mTestCase_testVec3ComponentAt[0m, time elapsed: 189500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ComponentAt (6900 ns)
    TCS: [33mTestCase_testVec3Equal[0m, time elapsed: 196500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Equal (18800 ns)
    TCS: [33mTestCase_testVec3NotEqual[0m, time elapsed: 187800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3NotEqual (10700 ns)
    TCS: [33mTestCase_testVec3EqualExact[0m, time elapsed: 182000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3EqualExact (8800 ns)
    TCS: [33mTestCase_testVec3BitwiseAnd[0m, time elapsed: 184800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseAnd (19400 ns)
    TCS: [33mTestCase_testVec3BitwiseNot[0m, time elapsed: 171800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseNot (6100 ns)
    TCS: [33mTestCase_testVec3Vec1ArithBroadcast[0m, time elapsed: 187800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1ArithBroadcast (16000 ns)
    TCS: [33mTestCase_testVec3ShiftLeft[0m, time elapsed: 185100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeft (10300 ns)
    TCS: [33mTestCase_testVec3BoolLogicalAnd[0m, time elapsed: 177300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BoolLogicalAnd (8700 ns)
    TCS: [33mTestCase_testVec3Sub[0m, time elapsed: 189300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Sub (11500 ns)
    TCS: [33mTestCase_testVec3Div[0m, time elapsed: 181500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Div (10200 ns)
    TCS: [33mTestCase_testVec3Mod[0m, time elapsed: 183000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Mod (9400 ns)
    TCS: [33mTestCase_testVec3ScalarSub[0m, time elapsed: 177000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarSub (13000 ns)
    TCS: [33mTestCase_testVec3ScalarDiv[0m, time elapsed: 181400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarDiv (9800 ns)
    TCS: [33mTestCase_testVec3ScalarMod[0m, time elapsed: 179100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarMod (8600 ns)
    TCS: [33mTestCase_testVec3BoolLogicalOr[0m, time elapsed: 172100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BoolLogicalOr (5900 ns)
    TCS: [33mTestCase_testVec3EqualEpsilon[0m, time elapsed: 180900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3EqualEpsilon (15500 ns)
    TCS: [33mTestCase_testVec3AddNamed[0m, time elapsed: 186400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3AddNamed (12900 ns)
    TCS: [33mTestCase_testVec3MulNamed[0m, time elapsed: 315100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3MulNamed (15400 ns)
    TCS: [33mTestCase_testVec3DivNamed[0m, time elapsed: 253400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3DivNamed (12100 ns)
    TCS: [33mTestCase_testVec3ModNamed[0m, time elapsed: 244100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ModNamed (11400 ns)
    TCS: [33mTestCase_testVec3BitwiseOr[0m, time elapsed: 246000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseOr (20300 ns)
    TCS: [33mTestCase_testVec3BitwiseXor[0m, time elapsed: 287700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseXor (18500 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseAnd[0m, time elapsed: 257700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseAnd (21000 ns)
    TCS: [33mTestCase_testVec3ShiftRight[0m, time elapsed: 218500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRight (15100 ns)
    TCS: [33mTestCase_testVec3Vec1BitBroadcast[0m, time elapsed: 210900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitBroadcast (15400 ns)
    TCS: [33mTestCase_testVec3ShiftRightVec1[0m, time elapsed: 199100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRightVec1 (11900 ns)
    TCS: [33mTestCase_testVec3FromVec1[0m, time elapsed: 223200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3FromVec1 (9600 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseOr[0m, time elapsed: 208700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseOr (16200 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseXor[0m, time elapsed: 239700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseXor (11900 ns)
    TCS: [33mTestCase_testVec3Vec1BitOrBroadcast[0m, time elapsed: 198000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitOrBroadcast (12100 ns)
    TCS: [33mTestCase_testVec3Vec1BitXorBroadcast[0m, time elapsed: 190400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitXorBroadcast (10500 ns)
    TCS: [33mTestCase_testVec3ShiftLeftVec1[0m, time elapsed: 189400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeftVec1 (11300 ns)
    TCS: [33mTestCase_testVec3ShiftLeftVec[0m, time elapsed: 184000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeftVec (6900 ns)
    TCS: [33mTestCase_testVec3ShiftRightVec[0m, time elapsed: 191500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRightVec (10000 ns)
    TCS: [33mTestCase_testVec3Increment[0m, time elapsed: 204200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Increment (14400 ns)
    TCS: [33mTestCase_testVec3Decrement[0m, time elapsed: 216000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Decrement (15200 ns)
    TCS: [33mTestCase_testVec3IndexOutOfBoundsAccess[0m, time elapsed: 266000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3IndexOutOfBoundsAccess (47100 ns)
    TCS: [33mTestCase_testVec3NegativeIndexAccess[0m, time elapsed: 223200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3NegativeIndexAccess (29400 ns)
    TCS: [33mTestCase_testVec4ScalarInit[0m, time elapsed: 195800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarInit (11500 ns)
    TCS: [33mTestCase_testVec4ConstInit[0m, time elapsed: 176200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ConstInit (8800 ns)
    TCS: [33mTestCase_testVec4Length[0m, time elapsed: 172500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Length (5700 ns)
    TCS: [33mTestCase_testVec4Add[0m, time elapsed: 210300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Add (15800 ns)
    TCS: [33mTestCase_testVec4ScalarMul[0m, time elapsed: 273000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarMul (12800 ns)
    TCS: [33mTestCase_testVec4Negate[0m, time elapsed: 190300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Negate (14600 ns)
    TCS: [33mTestCase_testVec4IndexAccess[0m, time elapsed: 214700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4IndexAccess (15500 ns)
    TCS: [33mTestCase_testVec4IndexMutate[0m, time elapsed: 226700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4IndexMutate (7500 ns)
    TCS: [33mTestCase_testVec4ComponentAt[0m, time elapsed: 235000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ComponentAt (9300 ns)
    TCS: [33mTestCase_testVec4Equal[0m, time elapsed: 279600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Equal (24500 ns)
    TCS: [33mTestCase_testVec4NotEqual[0m, time elapsed: 210900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4NotEqual (15800 ns)
    TCS: [33mTestCase_testVec4EqualExact[0m, time elapsed: 204600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4EqualExact (17000 ns)
    TCS: [33mTestCase_testVec4BitwiseAnd[0m, time elapsed: 198100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseAnd (13600 ns)
    TCS: [33mTestCase_testVec4BitwiseNot[0m, time elapsed: 168300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseNot (6500 ns)
    TCS: [33mTestCase_testVec4Vec1ArithBroadcast[0m, time elapsed: 178700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1ArithBroadcast (12500 ns)
    TCS: [33mTestCase_testVec4ShiftLeft[0m, time elapsed: 183900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeft (11300 ns)
    TCS: [33mTestCase_testVec4BoolLogicalAnd[0m, time elapsed: 179600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BoolLogicalAnd (12500 ns)
    TCS: [33mTestCase_testVec4Sub[0m, time elapsed: 176800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Sub (10700 ns)
    TCS: [33mTestCase_testVec4Div[0m, time elapsed: 177200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Div (12100 ns)
    TCS: [33mTestCase_testVec4Mod[0m, time elapsed: 177400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Mod (10400 ns)
    TCS: [33mTestCase_testVec4ScalarSub[0m, time elapsed: 177500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarSub (9800 ns)
    TCS: [33mTestCase_testVec4ScalarDiv[0m, time elapsed: 168700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarDiv (9600 ns)
    TCS: [33mTestCase_testVec4ScalarMod[0m, time elapsed: 169000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarMod (12200 ns)
    TCS: [33mTestCase_testVec4BoolLogicalOr[0m, time elapsed: 182200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BoolLogicalOr (8100 ns)
    TCS: [33mTestCase_testVec4EqualEpsilon[0m, time elapsed: 188600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4EqualEpsilon (16500 ns)
    TCS: [33mTestCase_testVec4AddNamed[0m, time elapsed: 174500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4AddNamed (12400 ns)
    TCS: [33mTestCase_testVec4MulNamed[0m, time elapsed: 165400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4MulNamed (6300 ns)
    TCS: [33mTestCase_testVec4DivNamed[0m, time elapsed: 168100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4DivNamed (9200 ns)
    TCS: [33mTestCase_testVec4ModNamed[0m, time elapsed: 174900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ModNamed (6300 ns)
    TCS: [33mTestCase_testVec4BitwiseOr[0m, time elapsed: 184800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseOr (10600 ns)
    TCS: [33mTestCase_testVec4BitwiseXor[0m, time elapsed: 190300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseXor (11600 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseAnd[0m, time elapsed: 186100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseAnd (9300 ns)
    TCS: [33mTestCase_testVec4ShiftRight[0m, time elapsed: 189000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRight (12000 ns)
    TCS: [33mTestCase_testVec4Vec1BitBroadcast[0m, time elapsed: 269300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitBroadcast (34000 ns)
    TCS: [33mTestCase_testVec4ShiftRightVec1[0m, time elapsed: 251100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRightVec1 (14100 ns)
    TCS: [33mTestCase_testVec4FromVec1[0m, time elapsed: 196800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4FromVec1 (9700 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseOr[0m, time elapsed: 349200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseOr (19800 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseXor[0m, time elapsed: 395100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseXor (20700 ns)
    TCS: [33mTestCase_testVec4Vec1BitOrBroadcast[0m, time elapsed: 240600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitOrBroadcast (20300 ns)
    TCS: [33mTestCase_testVec4Vec1BitXorBroadcast[0m, time elapsed: 214200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitXorBroadcast (17400 ns)
    TCS: [33mTestCase_testVec4ShiftLeftVec1[0m, time elapsed: 251000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeftVec1 (17000 ns)
    TCS: [33mTestCase_testVec4ShiftLeftVec[0m, time elapsed: 220000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeftVec (17700 ns)
    TCS: [33mTestCase_testVec4ShiftRightVec[0m, time elapsed: 269200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRightVec (18600 ns)
    TCS: [33mTestCase_testVec4Increment[0m, time elapsed: 245800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Increment (27500 ns)
    TCS: [33mTestCase_testVec4Decrement[0m, time elapsed: 217600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Decrement (16500 ns)
    TCS: [33mTestCase_testVec4IndexOutOfBoundsAccess[0m, time elapsed: 243900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4IndexOutOfBoundsAccess (47500 ns)
    TCS: [33mTestCase_testVec4NegativeIndexAccess[0m, time elapsed: 216100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4NegativeIndexAccess (25300 ns)
    TCS: [33mTestCase_testFunctor1Vec1Identity[0m, time elapsed: 206100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec1Identity (15200 ns)
    TCS: [33mTestCase_testFunctor1Vec1Transform[0m, time elapsed: 193300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec1Transform (8800 ns)
    TCS: [33mTestCase_testFunctor1Vec2Transform[0m, time elapsed: 214300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec2Transform (13300 ns)
    TCS: [33mTestCase_testFunctor2Vec1Add[0m, time elapsed: 188700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec1Add (10400 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec1Mul[0m, time elapsed: 187000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec1Mul (13300 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec1Shift[0m, time elapsed: 193400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec1Shift (9300 ns)
    TCS: [33mTestCase_testFunctor1Vec3Transform[0m, time elapsed: 194300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec3Transform (9400 ns)
    TCS: [33mTestCase_testFunctor1Vec4Transform[0m, time elapsed: 193000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec4Transform (10200 ns)
    TCS: [33mTestCase_testFunctor2Vec2Add[0m, time elapsed: 188700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec2Add (9200 ns)
    TCS: [33mTestCase_testFunctor2Vec3Add[0m, time elapsed: 191200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec3Add (10200 ns)
    TCS: [33mTestCase_testFunctor2Vec4Add[0m, time elapsed: 196900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec4Add (11100 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec2Mul[0m, time elapsed: 194300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec2Mul (10700 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec3Mul[0m, time elapsed: 201700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec3Mul (17400 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec4Mul[0m, time elapsed: 207100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec4Mul (11400 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec2Shift[0m, time elapsed: 213000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec2Shift (13500 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec3Shift[0m, time elapsed: 289300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec3Shift (15700 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec4Shift[0m, time elapsed: 222000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec4Shift (13000 ns)
Summary: TOTAL: 476
    [32mPASSED[0m: 476, [32mSKIPPED[0m: 0, ERROR: 0
    [31mFAILED[0m: 0
--------------------------------------------------------------------------------------------------
Project tests finished, time elapsed: 181367200 ns, RESULT:
TP: [33mglm[0m.*, time elapsed: 181323200 ns, RESULT:
    PASSED:
    TP: [33mglm.detail[0m, time elapsed: 165211600 ns
Summary: TOTAL: 476
    [32mPASSED[0m: 476, [32mSKIPPED[0m: 0, ERROR: 0
    [31mFAILED[0m: 0
--------------------------------------------------------------------------------------------------
[0J7[;r8[?25hcjpm test success
