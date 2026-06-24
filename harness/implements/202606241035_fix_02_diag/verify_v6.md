# 验证报告（v6）

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
[1F7[9999E8[0J7[;r8


[3F7[9999E[2F📦 group glm.detail                   73% [90m[[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[90m------[0m[90m][0m [32m    [0m (00:00:00)

passed: [32m350[0m, failed: 0             73% [90m[[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[90m------[0m[90m][0m 350/476 (00:00:00) 8--------------------------------------------------------------------------------------------------
TP: [33mglm.detail[0m, time elapsed: 241412000 ns, RESULT:
    TCS: [33mTestCase_testComputeVecAdd1[0m, time elapsed: 1771500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAdd1 (356000 ns)
    TCS: [33mTestCase_testComputeVecSub2[0m, time elapsed: 366600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub2 (47200 ns)
    TCS: [33mTestCase_testComputeVecMul3[0m, time elapsed: 326300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul3 (36700 ns)
    TCS: [33mTestCase_testComputeVecMod1[0m, time elapsed: 342800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMod1 (42800 ns)
    TCS: [33mTestCase_testComputeVecMod4[0m, time elapsed: 301200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMod4 (26200 ns)
    TCS: [33mTestCase_testComputeVecAnd1[0m, time elapsed: 304700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAnd1 (23900 ns)
    TCS: [33mTestCase_testComputeVecAnd3[0m, time elapsed: 275800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAnd3 (21900 ns)
    TCS: [33mTestCase_testComputeVecOr1[0m, time elapsed: 276000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecOr1 (22600 ns)
    TCS: [33mTestCase_testComputeVecOr2[0m, time elapsed: 303100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecOr2 (18600 ns)
    TCS: [33mTestCase_testComputeVecXor1[0m, time elapsed: 272000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecXor1 (22200 ns)
    TCS: [33mTestCase_testComputeVecXor4[0m, time elapsed: 296900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecXor4 (30500 ns)
    TCS: [33mTestCase_testComputeVecShiftLeft1[0m, time elapsed: 433900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftLeft1 (35300 ns)
    TCS: [33mTestCase_testComputeVecShiftLeft3[0m, time elapsed: 363800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftLeft3 (18900 ns)
    TCS: [33mTestCase_testComputeVecShiftRight1[0m, time elapsed: 287200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftRight1 (17700 ns)
    TCS: [33mTestCase_testComputeVecShiftRight4[0m, time elapsed: 290200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftRight4 (18200 ns)
    TCS: [33mTestCase_testComputeVecEqual1[0m, time elapsed: 296600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual1 (30300 ns)
    TCS: [33mTestCase_testComputeVecNequal4[0m, time elapsed: 262900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal4 (20000 ns)
    TCS: [33mTestCase_testComputeVecBitwiseNot1[0m, time elapsed: 332300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecBitwiseNot1 (29100 ns)
    TCS: [33mTestCase_testComputeVecBitwiseNot3[0m, time elapsed: 282300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecBitwiseNot3 (22200 ns)
    TCS: [33mTestCase_testComputeVecAdd4[0m, time elapsed: 301100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAdd4 (45700 ns)
    TCS: [33mTestCase_testComputeVecSub1[0m, time elapsed: 53904100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub1 (18200 ns)
    TCS: [33mTestCase_testComputeVecSub3[0m, time elapsed: 461500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub3 (58700 ns)
    TCS: [33mTestCase_testComputeVecMul1[0m, time elapsed: 300700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul1 (38300 ns)
    TCS: [33mTestCase_testComputeVecMul2[0m, time elapsed: 263800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul2 (20600 ns)
    TCS: [33mTestCase_testComputeVecDiv1[0m, time elapsed: 305600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecDiv1 (29200 ns)
    TCS: [33mTestCase_testComputeVecDiv2[0m, time elapsed: 250600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecDiv2 (19800 ns)
    TCS: [33mTestCase_testComputeVecDiv4[0m, time elapsed: 243800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecDiv4 (20500 ns)
    TCS: [33mTestCase_testComputeVecEqual2[0m, time elapsed: 232000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual2 (17400 ns)
    TCS: [33mTestCase_testComputeVecEqual3[0m, time elapsed: 235300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual3 (16600 ns)
    TCS: [33mTestCase_testComputeVecEqual4[0m, time elapsed: 256600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual4 (15900 ns)
    TCS: [33mTestCase_testComputeVecNequal1[0m, time elapsed: 217400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal1 (10500 ns)
    TCS: [33mTestCase_testComputeVecNequal2[0m, time elapsed: 224200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal2 (9900 ns)
    TCS: [33mTestCase_testComputeVecBitwiseNot4[0m, time elapsed: 252200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecBitwiseNot4 (23900 ns)
    TCS: [33mTestCase_testComputeVecAddFloat32[0m, time elapsed: 242100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAddFloat32 (27300 ns)
    TCS: [33mTestCase_testComputeVecAddFloat32Vec3[0m, time elapsed: 245300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAddFloat32Vec3 (22100 ns)
    TCS: [33mTestCase_testComputeVecSubFloat32[0m, time elapsed: 242800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSubFloat32 (20100 ns)
    TCS: [33mTestCase_testComputeVecSubFloat32Vec4[0m, time elapsed: 237300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSubFloat32Vec4 (22200 ns)
    TCS: [33mTestCase_testComputeEqualInt32Equal[0m, time elapsed: 232400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt32Equal (15100 ns)
    TCS: [33mTestCase_testComputeEqualInt32NotEqual[0m, time elapsed: 227400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt32NotEqual (15900 ns)
    TCS: [33mTestCase_testComputeEqualFloat32Equal[0m, time elapsed: 222900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32Equal (13800 ns)
    TCS: [33mTestCase_testComputeEqualFloat32NotEqual[0m, time elapsed: 225500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32NotEqual (10400 ns)
    TCS: [33mTestCase_testComputeEqualFloat64Equal[0m, time elapsed: 269200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64Equal (13100 ns)
    TCS: [33mTestCase_testComputeEqualFloat64NotEqual[0m, time elapsed: 235200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64NotEqual (9000 ns)
    TCS: [33mTestCase_testComputeEqualBoolEqual[0m, time elapsed: 258100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualBoolEqual (13200 ns)
    TCS: [33mTestCase_testComputeEqualBoolNotEqual[0m, time elapsed: 236700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualBoolNotEqual (11400 ns)
    TCS: [33mTestCase_testComputeEqualNumericInt32[0m, time elapsed: 246400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericInt32 (11600 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32[0m, time elapsed: 245900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32 (35400 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32Epsilon[0m, time elapsed: 225100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32Epsilon (10600 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64[0m, time elapsed: 238600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64 (16500 ns)
    TCS: [33mTestCase_testComputeEqualInt64Equal[0m, time elapsed: 218100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt64Equal (9500 ns)
    TCS: [33mTestCase_testComputeEqualInt64NotEqual[0m, time elapsed: 221900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt64NotEqual (9000 ns)
    TCS: [33mTestCase_testComputeEqualFloat32Nan[0m, time elapsed: 235400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32Nan (11300 ns)
    TCS: [33mTestCase_testComputeEqualFloat64Nan[0m, time elapsed: 236100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64Nan (9900 ns)
    TCS: [33mTestCase_testComputeEqualFloat32SignedZero[0m, time elapsed: 231200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32SignedZero (14800 ns)
    TCS: [33mTestCase_testComputeEqualFloat64SignedZero[0m, time elapsed: 245300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64SignedZero (9000 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32NotEqual[0m, time elapsed: 240500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32NotEqual (14800 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32BeyondEpsilon[0m, time elapsed: 225400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32BeyondEpsilon (10600 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64NotEqual[0m, time elapsed: 255700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64NotEqual (11200 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64Epsilon[0m, time elapsed: 407700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64Epsilon (20200 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64BeyondEpsilon[0m, time elapsed: 455000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64BeyondEpsilon (30200 ns)
    TCS: [33mTestCase_testComputeEqualNumericInt64[0m, time elapsed: 410700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericInt64 (26900 ns)
    TCS: [33mTestCase_testPackedHighpImplementsQualifier[0m, time elapsed: 468300 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedHighpImplementsQualifier (19400 ns)
    TCS: [33mTestCase_testPackedMediumpImplementsQualifier[0m, time elapsed: 280400 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedMediumpImplementsQualifier (15000 ns)
    TCS: [33mTestCase_testPackedLowpImplementsQualifier[0m, time elapsed: 436800 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedLowpImplementsQualifier (27400 ns)
    TCS: [33mTestCase_testDefaultpIsPackedHighp[0m, time elapsed: 445700 ns, RESULT:
    [[32m PASSED [0m] CASE: testDefaultpIsPackedHighp (16400 ns)
    TCS: [33mTestCase_testScalarAddVec1[0m, time elapsed: 303600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec1 (31500 ns)
    TCS: [33mTestCase_testScalarAddVec2[0m, time elapsed: 278900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec2 (21600 ns)
    TCS: [33mTestCase_testScalarAddVec3[0m, time elapsed: 257900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec3 (17200 ns)
    TCS: [33mTestCase_testScalarAddVec4[0m, time elapsed: 276100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec4 (24200 ns)
    TCS: [33mTestCase_testScalarSubVec1[0m, time elapsed: 270700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1 (24000 ns)
    TCS: [33mTestCase_testScalarMulVec1[0m, time elapsed: 244900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1 (17800 ns)
    TCS: [33mTestCase_testScalarDivVec1[0m, time elapsed: 231900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1 (13100 ns)
    TCS: [33mTestCase_testScalarModVec1[0m, time elapsed: 262800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1 (23200 ns)
    TCS: [33mTestCase_testScalarMulVec2[0m, time elapsed: 225900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2 (18800 ns)
    TCS: [33mTestCase_testScalarSubVec2[0m, time elapsed: 229200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2 (11300 ns)
    TCS: [33mTestCase_testScalarSubVec3[0m, time elapsed: 282700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3 (15800 ns)
    TCS: [33mTestCase_testScalarSubVec4[0m, time elapsed: 230700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4 (18800 ns)
    TCS: [33mTestCase_testScalarMulVec3[0m, time elapsed: 285800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3 (35500 ns)
    TCS: [33mTestCase_testScalarMulVec4[0m, time elapsed: 234700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4 (14000 ns)
    TCS: [33mTestCase_testScalarDivVec2[0m, time elapsed: 229500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2 (12200 ns)
    TCS: [33mTestCase_testScalarDivVec3[0m, time elapsed: 233800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3 (11500 ns)
    TCS: [33mTestCase_testScalarDivVec4[0m, time elapsed: 243200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4 (16100 ns)
    TCS: [33mTestCase_testScalarModVec2[0m, time elapsed: 236400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2 (10600 ns)
    TCS: [33mTestCase_testScalarModVec3[0m, time elapsed: 222000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3 (12800 ns)
    TCS: [33mTestCase_testScalarModVec4[0m, time elapsed: 219100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4 (12300 ns)
    TCS: [33mTestCase_testScalarModVec1Float32[0m, time elapsed: 242100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float32 (17900 ns)
    TCS: [33mTestCase_testScalarModVec2Float32[0m, time elapsed: 259200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32 (12000 ns)
    TCS: [33mTestCase_testScalarModVec3Float32[0m, time elapsed: 293300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float32 (19000 ns)
    TCS: [33mTestCase_testScalarModVec4Float32[0m, time elapsed: 325200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float32 (26900 ns)
    TCS: [33mTestCase_testScalarModVec1Float64[0m, time elapsed: 269100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float64 (13500 ns)
    TCS: [33mTestCase_testScalarModVec2Float64[0m, time elapsed: 219300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float64 (10000 ns)
    TCS: [33mTestCase_testScalarModVec3Float64[0m, time elapsed: 260000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float64 (10700 ns)
    TCS: [33mTestCase_testScalarModVec4Float64[0m, time elapsed: 227400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float64 (13800 ns)
    TCS: [33mTestCase_testScalarModVec1Float16[0m, time elapsed: 231500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float16 (20000 ns)
    TCS: [33mTestCase_testScalarModVec2Float16[0m, time elapsed: 230500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float16 (9700 ns)
    TCS: [33mTestCase_testScalarModVec3Float16[0m, time elapsed: 225600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float16 (11000 ns)
    TCS: [33mTestCase_testScalarModVec4Float16[0m, time elapsed: 378000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float16 (16400 ns)
    TCS: [33mTestCase_testScalarSubVec2PackedMediump[0m, time elapsed: 301100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2PackedMediump (20100 ns)
    TCS: [33mTestCase_testScalarSubVec2PackedLowp[0m, time elapsed: 324400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2PackedLowp (22100 ns)
    TCS: [33mTestCase_testScalarMulVec2PackedMediump[0m, time elapsed: 244400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2PackedMediump (15700 ns)
    TCS: [33mTestCase_testScalarMulVec2PackedLowp[0m, time elapsed: 229200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2PackedLowp (15000 ns)
    TCS: [33mTestCase_testScalarDivVec2PackedMediump[0m, time elapsed: 283400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2PackedMediump (19500 ns)
    TCS: [33mTestCase_testScalarDivVec2PackedLowp[0m, time elapsed: 238000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2PackedLowp (14400 ns)
    TCS: [33mTestCase_testScalarModVec2PackedMediump[0m, time elapsed: 263600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2PackedMediump (17900 ns)
    TCS: [33mTestCase_testScalarModVec2PackedLowp[0m, time elapsed: 274700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2PackedLowp (12800 ns)
    TCS: [33mTestCase_testScalarModVec2Float32PackedMediump[0m, time elapsed: 250400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32PackedMediump (13600 ns)
    TCS: [33mTestCase_testScalarModVec2Float32PackedLowp[0m, time elapsed: 275600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32PackedLowp (12200 ns)
    TCS: [33mTestCase_testScalarModVec2Float32NegativeDividend[0m, time elapsed: 256400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32NegativeDividend (11300 ns)
    TCS: [33mTestCase_testScalarModVec2Float32NegativeDivisor[0m, time elapsed: 251400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32NegativeDivisor (11700 ns)
    TCS: [33mTestCase_testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents[0m, time elapsed: 392700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents (128900 ns)
    TCS: [33mTestCase_testScalarAddVec1Float32[0m, time elapsed: 241500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec1Float32 (15300 ns)
    TCS: [33mTestCase_testScalarAddVec2Float32[0m, time elapsed: 237000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec2Float32 (23700 ns)
    TCS: [33mTestCase_testScalarAddVec3Float32[0m, time elapsed: 264600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec3Float32 (12000 ns)
    TCS: [33mTestCase_testScalarAddVec4Float32[0m, time elapsed: 245500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec4Float32 (12900 ns)
    TCS: [33mTestCase_testScalarSubVec1Float32[0m, time elapsed: 239600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1Float32 (18600 ns)
    TCS: [33mTestCase_testScalarSubVec2Float32[0m, time elapsed: 320800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2Float32 (28700 ns)
    TCS: [33mTestCase_testScalarSubVec3Float32[0m, time elapsed: 271800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3Float32 (12300 ns)
    TCS: [33mTestCase_testScalarSubVec4Float32[0m, time elapsed: 238100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4Float32 (17100 ns)
    TCS: [33mTestCase_testScalarMulVec1Float32[0m, time elapsed: 243600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1Float32 (10800 ns)
    TCS: [33mTestCase_testScalarMulVec2Float32[0m, time elapsed: 266600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2Float32 (14100 ns)
    TCS: [33mTestCase_testScalarMulVec3Float32[0m, time elapsed: 345900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3Float32 (18600 ns)
    TCS: [33mTestCase_testScalarMulVec4Float32[0m, time elapsed: 245300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4Float32 (13000 ns)
    TCS: [33mTestCase_testScalarDivVec1Float32[0m, time elapsed: 238000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1Float32 (11700 ns)
    TCS: [33mTestCase_testScalarDivVec2Float32[0m, time elapsed: 265700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2Float32 (12200 ns)
    TCS: [33mTestCase_testScalarDivVec3Float32[0m, time elapsed: 222800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3Float32 (9500 ns)
    TCS: [33mTestCase_testScalarDivVec4Float32[0m, time elapsed: 226000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4Float32 (14600 ns)
    TCS: [33mTestCase_testScalarAddVec1Int32[0m, time elapsed: 241300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec1Int32 (19800 ns)
    TCS: [33mTestCase_testScalarAddVec2Int32[0m, time elapsed: 219700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec2Int32 (9900 ns)
    TCS: [33mTestCase_testScalarAddVec3Int32[0m, time elapsed: 236100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec3Int32 (10500 ns)
    TCS: [33mTestCase_testScalarAddVec4Int32[0m, time elapsed: 266600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec4Int32 (15300 ns)
    TCS: [33mTestCase_testScalarSubVec1Int32[0m, time elapsed: 235800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1Int32 (18700 ns)
    TCS: [33mTestCase_testScalarSubVec2Int32[0m, time elapsed: 230300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2Int32 (11000 ns)
    TCS: [33mTestCase_testScalarSubVec3Int32[0m, time elapsed: 320700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3Int32 (13400 ns)
    TCS: [33mTestCase_testScalarSubVec4Int32[0m, time elapsed: 245100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4Int32 (11200 ns)
    TCS: [33mTestCase_testScalarMulVec1Int32[0m, time elapsed: 271700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1Int32 (10800 ns)
    TCS: [33mTestCase_testScalarMulVec2Int32[0m, time elapsed: 224700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2Int32 (9400 ns)
    TCS: [33mTestCase_testScalarMulVec3Int32[0m, time elapsed: 249900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3Int32 (15300 ns)
    TCS: [33mTestCase_testScalarMulVec4Int32[0m, time elapsed: 251800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4Int32 (12500 ns)
    TCS: [33mTestCase_testScalarDivVec1Int32[0m, time elapsed: 691500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1Int32 (20800 ns)
    TCS: [33mTestCase_testScalarDivVec2Int32[0m, time elapsed: 568000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2Int32 (24900 ns)
    TCS: [33mTestCase_testScalarDivVec3Int32[0m, time elapsed: 479700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3Int32 (21900 ns)
    TCS: [33mTestCase_testScalarDivVec4Int32[0m, time elapsed: 409500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4Int32 (41500 ns)
    TCS: [33mTestCase_testScalarModVec1Int32[0m, time elapsed: 396000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Int32 (23400 ns)
    TCS: [33mTestCase_testScalarModVec2Int32[0m, time elapsed: 440700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Int32 (23100 ns)
    TCS: [33mTestCase_testScalarModVec3Int32[0m, time elapsed: 610000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Int32 (30900 ns)
    TCS: [33mTestCase_testScalarModVec4Int32[0m, time elapsed: 459800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Int32 (17900 ns)
    TCS: [33mTestCase_testScalarSubVec1PackedMediump[0m, time elapsed: 294800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1PackedMediump (16200 ns)
    TCS: [33mTestCase_testScalarSubVec1PackedLowp[0m, time elapsed: 260000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1PackedLowp (22000 ns)
    TCS: [33mTestCase_testScalarSubVec3PackedMediump[0m, time elapsed: 283400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3PackedMediump (13100 ns)
    TCS: [33mTestCase_testScalarSubVec3PackedLowp[0m, time elapsed: 263500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3PackedLowp (12200 ns)
    TCS: [33mTestCase_testScalarSubVec4PackedMediump[0m, time elapsed: 247200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4PackedMediump (18200 ns)
    TCS: [33mTestCase_testScalarSubVec4PackedLowp[0m, time elapsed: 344000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4PackedLowp (16100 ns)
    TCS: [33mTestCase_testScalarMulVec1PackedMediump[0m, time elapsed: 273800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1PackedMediump (14600 ns)
    TCS: [33mTestCase_testScalarMulVec1PackedLowp[0m, time elapsed: 267700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1PackedLowp (13200 ns)
    TCS: [33mTestCase_testScalarMulVec3PackedMediump[0m, time elapsed: 225800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3PackedMediump (11100 ns)
    TCS: [33mTestCase_testScalarMulVec3PackedLowp[0m, time elapsed: 225400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3PackedLowp (9800 ns)
    TCS: [33mTestCase_testScalarMulVec4PackedMediump[0m, time elapsed: 229200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4PackedMediump (12000 ns)
    TCS: [33mTestCase_testScalarMulVec4PackedLowp[0m, time elapsed: 226000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4PackedLowp (14500 ns)
    TCS: [33mTestCase_testScalarDivVec1PackedMediump[0m, time elapsed: 235900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1PackedMediump (12100 ns)
    TCS: [33mTestCase_testScalarDivVec1PackedLowp[0m, time elapsed: 272800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1PackedLowp (9600 ns)
    TCS: [33mTestCase_testScalarDivVec3PackedMediump[0m, time elapsed: 215800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3PackedMediump (11300 ns)
    TCS: [33mTestCase_testScalarDivVec3PackedLowp[0m, time elapsed: 223200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3PackedLowp (11000 ns)
    TCS: [33mTestCase_testScalarDivVec4PackedMediump[0m, time elapsed: 229500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4PackedMediump (11100 ns)
    TCS: [33mTestCase_testScalarDivVec4PackedLowp[0m, time elapsed: 227200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4PackedLowp (15700 ns)
    TCS: [33mTestCase_testScalarModVec1PackedMediump[0m, time elapsed: 263300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1PackedMediump (28400 ns)
    TCS: [33mTestCase_testScalarModVec1PackedLowp[0m, time elapsed: 231200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1PackedLowp (10600 ns)
    TCS: [33mTestCase_testScalarModVec3PackedMediump[0m, time elapsed: 224900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3PackedMediump (11400 ns)
    TCS: [33mTestCase_testScalarModVec3PackedLowp[0m, time elapsed: 217600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3PackedLowp (10600 ns)
    TCS: [33mTestCase_testScalarModVec4PackedMediump[0m, time elapsed: 229700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4PackedMediump (14400 ns)
    TCS: [33mTestCase_testScalarModVec4PackedLowp[0m, time elapsed: 372900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4PackedLowp (15200 ns)
    TCS: [33mTestCase_testScalarDivZeroVec1[0m, time elapsed: 256300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivZeroVec1 (18800 ns)
    TCS: [33mTestCase_testScalarAddNegVec1[0m, time elapsed: 227800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddNegVec1 (12700 ns)
    TCS: [33mTestCase_testScalarAddNegVec2[0m, time elapsed: 231400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddNegVec2 (10700 ns)
    TCS: [33mTestCase_testScalarMulOverflowVec1[0m, time elapsed: 435900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulOverflowVec1 (13500 ns)
    TCS: [33mTestCase_testScalarSubNegVec1[0m, time elapsed: 497900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubNegVec1 (30700 ns)
    TCS: [33mTestCase_testVersionMajor[0m, time elapsed: 457300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionMajor (16100 ns)
    TCS: [33mTestCase_testVersionMinor[0m, time elapsed: 485600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionMinor (25500 ns)
    TCS: [33mTestCase_testVersionPatch[0m, time elapsed: 463400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionPatch (20000 ns)
    TCS: [33mTestCase_testVersionEncoded[0m, time elapsed: 438200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionEncoded (25800 ns)
    TCS: [33mTestCase_testConfigSimd[0m, time elapsed: 460400 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigSimd (47100 ns)
    TCS: [33mTestCase_testConfigAlignedGentypes[0m, time elapsed: 418600 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigAlignedGentypes (19400 ns)
    TCS: [33mTestCase_testConfigClipControl[0m, time elapsed: 391500 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigClipControl (15400 ns)
    TCS: [33mTestCase_testConstNegationSimd[0m, time elapsed: 360000 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationSimd (15400 ns)
    TCS: [33mTestCase_testConstNegationAligned[0m, time elapsed: 424900 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationAligned (17000 ns)
    TCS: [33mTestCase_testConstNegationClip[0m, time elapsed: 413000 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationClip (18500 ns)
    TCS: [33mTestCase_testConstInt64Usage[0m, time elapsed: 393900 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstInt64Usage (26600 ns)
    TCS: [33mTestCase_testConstBoolUsage[0m, time elapsed: 338600 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstBoolUsage (14400 ns)
    TCS: [33mTestCase_testVersionEncodingConsistency[0m, time elapsed: 369200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionEncodingConsistency (16400 ns)
    TCS: [33mTestCase_testAssertPasses[0m, time elapsed: 411900 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertPasses (33700 ns)
    TCS: [33mTestCase_testAssertFails[0m, time elapsed: 438400 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertFails (85800 ns)
    TCS: [33mTestCase_testAssertWithCustomMessage[0m, time elapsed: 406200 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertWithCustomMessage (62600 ns)
    TCS: [33mTestCase_testNumericLimitsFloat32Epsilon[0m, time elapsed: 376300 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsFloat32Epsilon (20600 ns)
    TCS: [33mTestCase_testNumericLimitsFloat64Epsilon[0m, time elapsed: 360000 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsFloat64Epsilon (18100 ns)
    TCS: [33mTestCase_testIsIec559OfFloat32[0m, time elapsed: 318200 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfFloat32 (15600 ns)
    TCS: [33mTestCase_testIsIec559OfFloat64[0m, time elapsed: 337300 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfFloat64 (13400 ns)
    TCS: [33mTestCase_testIsIec559OfInt64[0m, time elapsed: 357200 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfInt64 (18100 ns)
    TCS: [33mTestCase_testEpsilonOfFloat32[0m, time elapsed: 294900 ns, RESULT:
    [[32m PASSED [0m] CASE: testEpsilonOfFloat32 (22900 ns)
    TCS: [33mTestCase_testEpsilonOfFloat64[0m, time elapsed: 237100 ns, RESULT:
    [[32m PASSED [0m] CASE: testEpsilonOfFloat64 (10100 ns)
    TCS: [33mTestCase_testNumericLimitsInt64Epsilon[0m, time elapsed: 226300 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt64Epsilon (10900 ns)
    TCS: [33mTestCase_testNumericLimitsInt32Epsilon[0m, time elapsed: 223200 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt32Epsilon (13600 ns)
    TCS: [33mTestCase_testNumericLimitsInt16Epsilon[0m, time elapsed: 605100 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt16Epsilon (26200 ns)
    TCS: [33mTestCase_testNumericLimitsInt8Epsilon[0m, time elapsed: 576000 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt8Epsilon (64200 ns)
    TCS: [33mTestCase_testCastVec1ToVec1IntToFloat[0m, time elapsed: 504900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec1ToVec1IntToFloat (44300 ns)
    TCS: [33mTestCase_testCastVec2ToVec1TakesOnlyX[0m, time elapsed: 514000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2ToVec1TakesOnlyX (50800 ns)
    TCS: [33mTestCase_testCastVec3ToVec1TakesOnlyX[0m, time elapsed: 465600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3ToVec1TakesOnlyX (50800 ns)
    TCS: [33mTestCase_testCastVec4ToVec1TakesOnlyX[0m, time elapsed: 493200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4ToVec1TakesOnlyX (21100 ns)
    TCS: [33mTestCase_testCastSameTypeIdentity[0m, time elapsed: 293000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastSameTypeIdentity (14600 ns)
    TCS: [33mTestCase_testCastInt32ToInt64[0m, time elapsed: 293000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastInt32ToInt64 (14100 ns)
    TCS: [33mTestCase_testCastFloatToIntTruncation[0m, time elapsed: 262200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastFloatToIntTruncation (11100 ns)
    TCS: [33mTestCase_testCastCrossQualifierPackedHighpToDefaultp[0m, time elapsed: 384000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastCrossQualifierPackedHighpToDefaultp (13300 ns)
    TCS: [33mTestCase_testCastCrossQualifierDefaultpToPackedHighp[0m, time elapsed: 341200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastCrossQualifierDefaultpToPackedHighp (15100 ns)
    TCS: [33mTestCase_testCastVec2CrossQualifierCrossType[0m, time elapsed: 252600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2CrossQualifierCrossType (12700 ns)
    TCS: [33mTestCase_testCastVec3CrossQualifier[0m, time elapsed: 220100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3CrossQualifier (9300 ns)
    TCS: [33mTestCase_testCastVec4CrossQualifier[0m, time elapsed: 208900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4CrossQualifier (7300 ns)
    TCS: [33mTestCase_testCastVec1DoesNotModifySource[0m, time elapsed: 307800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec1DoesNotModifySource (13000 ns)
    TCS: [33mTestCase_testCastVec2Vec1ToVec2IntToFloat[0m, time elapsed: 262900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec1ToVec2IntToFloat (12500 ns)
    TCS: [33mTestCase_testCastVec2Vec2ToVec2Identity[0m, time elapsed: 240300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec2ToVec2Identity (21900 ns)
    TCS: [33mTestCase_testCastVec2Vec3ToVec2TakesOnlyXY[0m, time elapsed: 230100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec3ToVec2TakesOnlyXY (13200 ns)
    TCS: [33mTestCase_testCastVec2Vec4ToVec2TakesOnlyXY[0m, time elapsed: 215300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec4ToVec2TakesOnlyXY (7600 ns)
    TCS: [33mTestCase_testCastVec2SameTypeIdentity[0m, time elapsed: 215300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2SameTypeIdentity (7100 ns)
    TCS: [33mTestCase_testCastVec2Int32ToInt64[0m, time elapsed: 326700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Int32ToInt64 (13000 ns)
    TCS: [33mTestCase_testCastVec2FloatToIntTruncation[0m, time elapsed: 228300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2FloatToIntTruncation (11100 ns)
    TCS: [33mTestCase_testCastVec2CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 200500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2CrossQualifierPackedHighpToDefaultp (7200 ns)
    TCS: [33mTestCase_testCastVec2DoesNotModifySource[0m, time elapsed: 215100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2DoesNotModifySource (7100 ns)
    TCS: [33mTestCase_testCastVec2Vec1ToVec2SameValueBothComponents[0m, time elapsed: 205400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec1ToVec2SameValueBothComponents (7500 ns)
    TCS: [33mTestCase_testCastVec3Vec1ToVec3IntToFloat[0m, time elapsed: 225900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec1ToVec3IntToFloat (14800 ns)
    TCS: [33mTestCase_testCastVec3Vec2ToVec3ExtendY[0m, time elapsed: 207200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec2ToVec3ExtendY (10600 ns)
    TCS: [33mTestCase_testCastVec3Vec3ToVec3Identity[0m, time elapsed: 201300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec3ToVec3Identity (7100 ns)
    TCS: [33mTestCase_testCastVec3Vec4ToVec3TakesOnlyXYZ[0m, time elapsed: 213500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec4ToVec3TakesOnlyXYZ (10100 ns)
    TCS: [33mTestCase_testCastVec3SameTypeIdentity[0m, time elapsed: 229700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3SameTypeIdentity (7100 ns)
    TCS: [33mTestCase_testCastVec3Int32ToInt64[0m, time elapsed: 197400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Int32ToInt64 (7100 ns)
    TCS: [33mTestCase_testCastVec3FloatToIntTruncation[0m, time elapsed: 211000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3FloatToIntTruncation (6700 ns)
    TCS: [33mTestCase_testCastVec3CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 220400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3CrossQualifierPackedHighpToDefaultp (9900 ns)
    TCS: [33mTestCase_testCastVec3DoesNotModifySource[0m, time elapsed: 196100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3DoesNotModifySource (7100 ns)
    TCS: [33mTestCase_testCastVec3Vec1ToVec3SameValueAllComponents[0m, time elapsed: 208300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec1ToVec3SameValueAllComponents (7300 ns)
    TCS: [33mTestCase_testCastVec4Vec1ToVec4IntToFloat[0m, time elapsed: 209800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec1ToVec4IntToFloat (8000 ns)
    TCS: [33mTestCase_testCastVec4Vec2ToVec4ExtendY[0m, time elapsed: 213400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec2ToVec4ExtendY (10800 ns)
    TCS: [33mTestCase_testCastVec4Vec3ToVec4ExtendZ[0m, time elapsed: 200800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec3ToVec4ExtendZ (13300 ns)
    TCS: [33mTestCase_testCastVec4Vec4ToVec4Identity[0m, time elapsed: 206100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec4ToVec4Identity (9900 ns)
    TCS: [33mTestCase_testCastVec4SameTypeIdentity[0m, time elapsed: 264400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4SameTypeIdentity (10700 ns)
    TCS: [33mTestCase_testCastVec4Int32ToInt64[0m, time elapsed: 458100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Int32ToInt64 (19100 ns)
    TCS: [33mTestCase_testCastVec4FloatToIntTruncation[0m, time elapsed: 236000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4FloatToIntTruncation (11400 ns)
    TCS: [33mTestCase_testCastVec4CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 307500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4CrossQualifierPackedHighpToDefaultp (13900 ns)
    TCS: [33mTestCase_testCastVec4DoesNotModifySource[0m, time elapsed: 252500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4DoesNotModifySource (11000 ns)
    TCS: [33mTestCase_testCastVec4Vec1ToVec4SameValueAllComponents[0m, time elapsed: 309400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec1ToVec4SameValueAllComponents (13000 ns)
    TCS: [33mTestCase_testFromBoolVec1[0m, time elapsed: 268300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec1 (11000 ns)
    TCS: [33mTestCase_testFromBoolVec1False[0m, time elapsed: 300700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec1False (7700 ns)
    TCS: [33mTestCase_testFromBoolVec2[0m, time elapsed: 283100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec2 (17500 ns)
    TCS: [33mTestCase_testFromBoolVec3[0m, time elapsed: 213100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec3 (11100 ns)
    TCS: [33mTestCase_testFromBoolVec4[0m, time elapsed: 238500 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec4 (9300 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec1[0m, time elapsed: 226800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec1 (9300 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec2[0m, time elapsed: 211000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec2 (8000 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec3[0m, time elapsed: 221000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec3 (20200 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec4[0m, time elapsed: 200600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec4 (10600 ns)
    TCS: [33mTestCase_testFromBoolVec3AllFalse[0m, time elapsed: 196900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec3AllFalse (7000 ns)
    TCS: [33mTestCase_testFromBoolVec4AllFalse[0m, time elapsed: 207800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec4AllFalse (6700 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec3AllFalse[0m, time elapsed: 233400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec3AllFalse (8200 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec4AllFalse[0m, time elapsed: 227700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec4AllFalse (7400 ns)
    TCS: [33mTestCase_testFromBoolVecFloat32[0m, time elapsed: 283100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecFloat32 (15800 ns)
    TCS: [33mTestCase_testFromBoolVecFloat64[0m, time elapsed: 650000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecFloat64 (20700 ns)
    TCS: [33mTestCase_testFromBoolVecInt32[0m, time elapsed: 223300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecInt32 (10100 ns)
    TCS: [33mTestCase_testFromBoolVecQ2PackedMediump[0m, time elapsed: 290300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2PackedMediump (13800 ns)
    TCS: [33mTestCase_testFromBoolVecQ2PackedLowp[0m, time elapsed: 240100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2PackedLowp (9500 ns)
    TCS: [33mTestCase_testVec1ConstInit[0m, time elapsed: 347100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ConstInit (20800 ns)
    TCS: [33mTestCase_testVec1Length[0m, time elapsed: 235700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Length (11600 ns)
    TCS: [33mTestCase_testVec1IndexAccess[0m, time elapsed: 222800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1IndexAccess (11300 ns)
    TCS: [33mTestCase_testVec1IndexMutate[0m, time elapsed: 213500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1IndexMutate (6300 ns)
    TCS: [33mTestCase_testVec1ComponentAt[0m, time elapsed: 207400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ComponentAt (6900 ns)
    TCS: [33mTestCase_testVec1Add[0m, time elapsed: 211600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Add (13000 ns)
    TCS: [33mTestCase_testVec1Sub[0m, time elapsed: 225200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Sub (11700 ns)
    TCS: [33mTestCase_testVec1Mul[0m, time elapsed: 223400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Mul (15100 ns)
    TCS: [33mTestCase_testVec1Div[0m, time elapsed: 206400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Div (10900 ns)
    TCS: [33mTestCase_testVec1Mod[0m, time elapsed: 214600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Mod (12500 ns)
    TCS: [33mTestCase_testVec1ScalarAdd[0m, time elapsed: 209600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarAdd (9500 ns)
    TCS: [33mTestCase_testVec1Negate[0m, time elapsed: 200700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Negate (6700 ns)
    TCS: [33mTestCase_testVec1AddNamed[0m, time elapsed: 204500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1AddNamed (10100 ns)
    TCS: [33mTestCase_testVec1SubNamed[0m, time elapsed: 214800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1SubNamed (12900 ns)
    TCS: [33mTestCase_testVec1MulNamed[0m, time elapsed: 196800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1MulNamed (6600 ns)
    TCS: [33mTestCase_testVec1Equal[0m, time elapsed: 206000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Equal (14700 ns)
    TCS: [33mTestCase_testVec1NotEqual[0m, time elapsed: 208800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1NotEqual (6700 ns)
    TCS: [33mTestCase_testVec1EqualExact[0m, time elapsed: 213200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1EqualExact (12700 ns)
    TCS: [33mTestCase_testVec1BitwiseAnd[0m, time elapsed: 205400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BitwiseAnd (13400 ns)
    TCS: [33mTestCase_testVec1BitwiseOr[0m, time elapsed: 221900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BitwiseOr (10400 ns)
    TCS: [33mTestCase_testVec1BitwiseXor[0m, time elapsed: 249700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BitwiseXor (9300 ns)
    TCS: [33mTestCase_testVec1ShiftLeft[0m, time elapsed: 358200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ShiftLeft (20400 ns)
    TCS: [33mTestCase_testVec1ShiftRight[0m, time elapsed: 353100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ShiftRight (22500 ns)
    TCS: [33mTestCase_testVec1BitwiseNot[0m, time elapsed: 323400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BitwiseNot (16300 ns)
    TCS: [33mTestCase_testVec1BoolLogicalAnd[0m, time elapsed: 413700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BoolLogicalAnd (24600 ns)
    TCS: [33mTestCase_testVec1BoolLogicalOr[0m, time elapsed: 355700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BoolLogicalOr (13000 ns)
    TCS: [33mTestCase_testVec1IndexOutOfBoundsAccess[0m, time elapsed: 354700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1IndexOutOfBoundsAccess (73500 ns)
    TCS: [33mTestCase_testVec1ShiftVec[0m, time elapsed: 244400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ShiftVec (15000 ns)
    TCS: [33mTestCase_testVec1ScalarSub[0m, time elapsed: 205500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarSub (9600 ns)
    TCS: [33mTestCase_testVec1ScalarMul[0m, time elapsed: 258900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarMul (14800 ns)
    TCS: [33mTestCase_testVec1ScalarDiv[0m, time elapsed: 228400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarDiv (8600 ns)
    TCS: [33mTestCase_testVec1ScalarMod[0m, time elapsed: 218300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarMod (8400 ns)
    TCS: [33mTestCase_testVec1DivNamed[0m, time elapsed: 214700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1DivNamed (8200 ns)
    TCS: [33mTestCase_testVec1ModNamed[0m, time elapsed: 227800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ModNamed (7600 ns)
    TCS: [33mTestCase_testVec1ScalarBitwiseAnd[0m, time elapsed: 227000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarBitwiseAnd (22000 ns)
    TCS: [33mTestCase_testVec1ScalarBitwiseOr[0m, time elapsed: 206900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarBitwiseOr (10600 ns)
    TCS: [33mTestCase_testVec1ScalarBitwiseXor[0m, time elapsed: 200500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarBitwiseXor (6500 ns)
    TCS: [33mTestCase_testVec1ShiftRightVec[0m, time elapsed: 213300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ShiftRightVec (7100 ns)
    TCS: [33mTestCase_testVec1EqualEpsilon[0m, time elapsed: 242300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1EqualEpsilon (16700 ns)
    TCS: [33mTestCase_testVec1BroadcastAddVec2[0m, time elapsed: 253700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastAddVec2 (14700 ns)
    TCS: [33mTestCase_testVec1BroadcastBitAndVec2[0m, time elapsed: 368100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastBitAndVec2 (17600 ns)
    TCS: [33mTestCase_testVec1BroadcastAddVec3[0m, time elapsed: 227400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastAddVec3 (12600 ns)
    TCS: [33mTestCase_testVec1BroadcastAddVec4[0m, time elapsed: 232100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastAddVec4 (16200 ns)
    TCS: [33mTestCase_testVec1BroadcastBitOrVec2[0m, time elapsed: 211700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastBitOrVec2 (7500 ns)
    TCS: [33mTestCase_testVec1BroadcastBitXorVec2[0m, time elapsed: 228400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastBitXorVec2 (13400 ns)
    TCS: [33mTestCase_testVec1BroadcastShiftLeftVec2[0m, time elapsed: 265200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastShiftLeftVec2 (12000 ns)
    TCS: [33mTestCase_testVec1BroadcastShiftRightVec2[0m, time elapsed: 266600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastShiftRightVec2 (14800 ns)
    TCS: [33mTestCase_testVec1BroadcastBitAndVec3[0m, time elapsed: 336100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastBitAndVec3 (16400 ns)
    TCS: [33mTestCase_testVec1BroadcastBitAndVec4[0m, time elapsed: 280600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastBitAndVec4 (19300 ns)
    TCS: [33mTestCase_testVec1BroadcastModVec2[0m, time elapsed: 205800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastModVec2 (9600 ns)
    TCS: [33mTestCase_testVec1BroadcastModVec3[0m, time elapsed: 217400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastModVec3 (11200 ns)
    TCS: [33mTestCase_testVec1BroadcastModVec4[0m, time elapsed: 231100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastModVec4 (19600 ns)
    TCS: [33mTestCase_testVec1Increment[0m, time elapsed: 204500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Increment (11600 ns)
    TCS: [33mTestCase_testVec1Decrement[0m, time elapsed: 193800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Decrement (6900 ns)
    TCS: [33mTestCase_testVec2ScalarInit[0m, time elapsed: 227100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarInit (12100 ns)
    TCS: [33mTestCase_testVec2ConstInit[0m, time elapsed: 207900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ConstInit (9000 ns)
    TCS: [33mTestCase_testVec2Length[0m, time elapsed: 197900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Length (9600 ns)
    TCS: [33mTestCase_testVec2Add[0m, time elapsed: 213300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Add (11900 ns)
    TCS: [33mTestCase_testVec2Sub[0m, time elapsed: 240000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Sub (12000 ns)
    TCS: [33mTestCase_testVec2Mul[0m, time elapsed: 200600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Mul (10900 ns)
    TCS: [33mTestCase_testVec2ScalarAdd[0m, time elapsed: 202800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarAdd (9200 ns)
    TCS: [33mTestCase_testVec2Negate[0m, time elapsed: 211300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Negate (9600 ns)
    TCS: [33mTestCase_testVec2IndexAccess[0m, time elapsed: 198400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2IndexAccess (10100 ns)
    TCS: [33mTestCase_testVec2IndexMutate[0m, time elapsed: 204300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2IndexMutate (9900 ns)
    TCS: [33mTestCase_testVec2ComponentAt[0m, time elapsed: 304500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ComponentAt (10700 ns)
    TCS: [33mTestCase_testVec2Equal[0m, time elapsed: 307800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Equal (19900 ns)
    TCS: [33mTestCase_testVec2NotEqual[0m, time elapsed: 330800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2NotEqual (16600 ns)
    TCS: [33mTestCase_testVec2EqualExact[0m, time elapsed: 259300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2EqualExact (23800 ns)
    TCS: [33mTestCase_testVec2BitwiseAnd[0m, time elapsed: 293400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseAnd (16400 ns)
    TCS: [33mTestCase_testVec2BitwiseNot[0m, time elapsed: 273400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseNot (12400 ns)
    TCS: [33mTestCase_testVec2FromVec1[0m, time elapsed: 298600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2FromVec1 (14100 ns)
    TCS: [33mTestCase_testVec2ShiftLeft[0m, time elapsed: 237900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeft (17300 ns)
    TCS: [33mTestCase_testVec2BoolLogicalAnd[0m, time elapsed: 208100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BoolLogicalAnd (13800 ns)
    TCS: [33mTestCase_testVec2Vec1ArithBroadcast[0m, time elapsed: 240700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Vec1ArithBroadcast (22800 ns)
    TCS: [33mTestCase_testVec2Vec1BitBroadcast[0m, time elapsed: 257600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Vec1BitBroadcast (13900 ns)
    TCS: [33mTestCase_testVec2ShiftLeftVec1[0m, time elapsed: 221700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeftVec1 (11800 ns)
    TCS: [33mTestCase_testVec2Div[0m, time elapsed: 228900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Div (13500 ns)
    TCS: [33mTestCase_testVec2Mod[0m, time elapsed: 221700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Mod (11000 ns)
    TCS: [33mTestCase_testVec2ScalarSub[0m, time elapsed: 231100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarSub (16400 ns)
    TCS: [33mTestCase_testVec2ScalarMul[0m, time elapsed: 214900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarMul (10100 ns)
    TCS: [33mTestCase_testVec2ScalarDiv[0m, time elapsed: 222800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarDiv (12100 ns)
    TCS: [33mTestCase_testVec2ScalarMod[0m, time elapsed: 217700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarMod (8800 ns)
    TCS: [33mTestCase_testVec2BoolLogicalOr[0m, time elapsed: 206500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BoolLogicalOr (9700 ns)
    TCS: [33mTestCase_testVec2EqualEpsilon[0m, time elapsed: 237000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2EqualEpsilon (20300 ns)
    TCS: [33mTestCase_testVec2DivNamed[0m, time elapsed: 214800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2DivNamed (12400 ns)
    TCS: [33mTestCase_testVec2ModNamed[0m, time elapsed: 212100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ModNamed (7900 ns)
    TCS: [33mTestCase_testVec2BitwiseOr[0m, time elapsed: 218100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseOr (12100 ns)
    TCS: [33mTestCase_testVec2BitwiseXor[0m, time elapsed: 241500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseXor (14700 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseAnd[0m, time elapsed: 230000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseAnd (11600 ns)
    TCS: [33mTestCase_testVec2ShiftRight[0m, time elapsed: 262100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRight (14200 ns)
    TCS: [33mTestCase_testVec2ShiftRightVec1[0m, time elapsed: 211300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRightVec1 (10300 ns)
    TCS: [33mTestCase_testVec2AddNamed[0m, time elapsed: 200700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2AddNamed (7100 ns)
    TCS: [33mTestCase_testVec2SubNamed[0m, time elapsed: 200600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2SubNamed (6900 ns)
    TCS: [33mTestCase_testVec2MulNamed[0m, time elapsed: 220100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2MulNamed (7100 ns)
    TCS: [33mTestCase_testVec2ShiftLeftVec[0m, time elapsed: 267100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeftVec (6600 ns)
    TCS: [33mTestCase_testVec2ShiftRightVec[0m, time elapsed: 229400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRightVec (12800 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseOr[0m, time elapsed: 230100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseOr (12500 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseXor[0m, time elapsed: 222200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseXor (10400 ns)
    TCS: [33mTestCase_testVec2Increment[0m, time elapsed: 225100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Increment (11400 ns)
    TCS: [33mTestCase_testVec2Decrement[0m, time elapsed: 213000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Decrement (12200 ns)
    TCS: [33mTestCase_testVec2IndexOutOfBoundsAccess[0m, time elapsed: 259100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2IndexOutOfBoundsAccess (52900 ns)
    TCS: [33mTestCase_testVec2NegativeIndexAccess[0m, time elapsed: 237600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2NegativeIndexAccess (25400 ns)
    TCS: [33mTestCase_testVec3ScalarInit[0m, time elapsed: 243300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarInit (10200 ns)
    TCS: [33mTestCase_testVec3ConstInit[0m, time elapsed: 202500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ConstInit (6300 ns)
    TCS: [33mTestCase_testVec3Length[0m, time elapsed: 203600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Length (6100 ns)
    TCS: [33mTestCase_testVec3Add[0m, time elapsed: 221700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Add (14600 ns)
    TCS: [33mTestCase_testVec3ScalarMul[0m, time elapsed: 212300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarMul (18700 ns)
    TCS: [33mTestCase_testVec3Negate[0m, time elapsed: 210000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Negate (10300 ns)
    TCS: [33mTestCase_testVec3IndexAccess[0m, time elapsed: 198300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3IndexAccess (9700 ns)
    TCS: [33mTestCase_testVec3IndexMutate[0m, time elapsed: 586100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3IndexMutate (17700 ns)
    TCS: [33mTestCase_testVec3ComponentAt[0m, time elapsed: 347600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ComponentAt (14800 ns)
    TCS: [33mTestCase_testVec3Equal[0m, time elapsed: 436500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Equal (37000 ns)
    TCS: [33mTestCase_testVec3NotEqual[0m, time elapsed: 526500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3NotEqual (37700 ns)
    TCS: [33mTestCase_testVec3EqualExact[0m, time elapsed: 422700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3EqualExact (27000 ns)
    TCS: [33mTestCase_testVec3BitwiseAnd[0m, time elapsed: 497700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseAnd (29200 ns)
    TCS: [33mTestCase_testVec3BitwiseNot[0m, time elapsed: 313800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseNot (13800 ns)
    TCS: [33mTestCase_testVec3Vec1ArithBroadcast[0m, time elapsed: 282400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1ArithBroadcast (24100 ns)
    TCS: [33mTestCase_testVec3ShiftLeft[0m, time elapsed: 227900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeft (18300 ns)
    TCS: [33mTestCase_testVec3BoolLogicalAnd[0m, time elapsed: 215000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BoolLogicalAnd (12300 ns)
    TCS: [33mTestCase_testVec3Sub[0m, time elapsed: 444800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Sub (26100 ns)
    TCS: [33mTestCase_testVec3Div[0m, time elapsed: 357200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Div (20700 ns)
    TCS: [33mTestCase_testVec3Mod[0m, time elapsed: 250100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Mod (13200 ns)
    TCS: [33mTestCase_testVec3ScalarSub[0m, time elapsed: 256200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarSub (16700 ns)
    TCS: [33mTestCase_testVec3ScalarDiv[0m, time elapsed: 216400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarDiv (12600 ns)
    TCS: [33mTestCase_testVec3ScalarMod[0m, time elapsed: 205700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarMod (10500 ns)
    TCS: [33mTestCase_testVec3BoolLogicalOr[0m, time elapsed: 221500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BoolLogicalOr (9700 ns)
    TCS: [33mTestCase_testVec3EqualEpsilon[0m, time elapsed: 249500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3EqualEpsilon (21500 ns)
    TCS: [33mTestCase_testVec3AddNamed[0m, time elapsed: 210200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3AddNamed (10800 ns)
    TCS: [33mTestCase_testVec3MulNamed[0m, time elapsed: 205800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3MulNamed (10700 ns)
    TCS: [33mTestCase_testVec3DivNamed[0m, time elapsed: 204700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3DivNamed (7300 ns)
    TCS: [33mTestCase_testVec3ModNamed[0m, time elapsed: 193500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ModNamed (6800 ns)
    TCS: [33mTestCase_testVec3BitwiseOr[0m, time elapsed: 215700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseOr (12300 ns)
    TCS: [33mTestCase_testVec3BitwiseXor[0m, time elapsed: 207700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseXor (11300 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseAnd[0m, time elapsed: 205900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseAnd (13300 ns)
    TCS: [33mTestCase_testVec3ShiftRight[0m, time elapsed: 228800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRight (30100 ns)
    TCS: [33mTestCase_testVec3Vec1BitBroadcast[0m, time elapsed: 218500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitBroadcast (12900 ns)
    TCS: [33mTestCase_testVec3ShiftRightVec1[0m, time elapsed: 203800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRightVec1 (10100 ns)
    TCS: [33mTestCase_testVec3FromVec1[0m, time elapsed: 313700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3FromVec1 (11700 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseOr[0m, time elapsed: 318300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseOr (18400 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseXor[0m, time elapsed: 304700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseXor (29100 ns)
    TCS: [33mTestCase_testVec3Vec1BitOrBroadcast[0m, time elapsed: 239900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitOrBroadcast (13800 ns)
    TCS: [33mTestCase_testVec3Vec1BitXorBroadcast[0m, time elapsed: 204800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitXorBroadcast (10500 ns)
    TCS: [33mTestCase_testVec3ShiftLeftVec1[0m, time elapsed: 170600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeftVec1 (11400 ns)
    TCS: [33mTestCase_testVec3ShiftLeftVec[0m, time elapsed: 103000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeftVec (5900 ns)
    TCS: [33mTestCase_testVec3ShiftRightVec[0m, time elapsed: 102400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRightVec (11400 ns)
    TCS: [33mTestCase_testVec3Increment[0m, time elapsed: 103400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Increment (12600 ns)
    TCS: [33mTestCase_testVec3Decrement[0m, time elapsed: 103200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Decrement (10400 ns)
    TCS: [33mTestCase_testVec3IndexOutOfBoundsAccess[0m, time elapsed: 153800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3IndexOutOfBoundsAccess (46800 ns)
    TCS: [33mTestCase_testVec3NegativeIndexAccess[0m, time elapsed: 116400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3NegativeIndexAccess (21700 ns)
    TCS: [33mTestCase_testVec4ScalarInit[0m, time elapsed: 99100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarInit (11700 ns)
    TCS: [33mTestCase_testVec4ConstInit[0m, time elapsed: 98200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ConstInit (8100 ns)
    TCS: [33mTestCase_testVec4Length[0m, time elapsed: 99200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Length (5600 ns)
    TCS: [33mTestCase_testVec4Add[0m, time elapsed: 108900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Add (13400 ns)
    TCS: [33mTestCase_testVec4ScalarMul[0m, time elapsed: 98800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarMul (9900 ns)
    TCS: [33mTestCase_testVec4Negate[0m, time elapsed: 99900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Negate (9800 ns)
    TCS: [33mTestCase_testVec4IndexAccess[0m, time elapsed: 158400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4IndexAccess (12600 ns)
    TCS: [33mTestCase_testVec4IndexMutate[0m, time elapsed: 175500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4IndexMutate (9900 ns)
    TCS: [33mTestCase_testVec4ComponentAt[0m, time elapsed: 625200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ComponentAt (17600 ns)
    TCS: [33mTestCase_testVec4Equal[0m, time elapsed: 348900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Equal (23600 ns)
    TCS: [33mTestCase_testVec4NotEqual[0m, time elapsed: 274100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4NotEqual (18000 ns)
    TCS: [33mTestCase_testVec4EqualExact[0m, time elapsed: 496600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4EqualExact (35100 ns)
    TCS: [33mTestCase_testVec4BitwiseAnd[0m, time elapsed: 380400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseAnd (30100 ns)
    TCS: [33mTestCase_testVec4BitwiseNot[0m, time elapsed: 321100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseNot (16100 ns)
    TCS: [33mTestCase_testVec4Vec1ArithBroadcast[0m, time elapsed: 236700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1ArithBroadcast (21100 ns)
    TCS: [33mTestCase_testVec4ShiftLeft[0m, time elapsed: 256200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeft (17300 ns)
    TCS: [33mTestCase_testVec4BoolLogicalAnd[0m, time elapsed: 234600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BoolLogicalAnd (15900 ns)
    TCS: [33mTestCase_testVec4Sub[0m, time elapsed: 247200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Sub (20400 ns)
    TCS: [33mTestCase_testVec4Div[0m, time elapsed: 221800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Div (16200 ns)
    TCS: [33mTestCase_testVec4Mod[0m, time elapsed: 207000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Mod (12500 ns)
    TCS: [33mTestCase_testVec4ScalarSub[0m, time elapsed: 223200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarSub (14600 ns)
    TCS: [33mTestCase_testVec4ScalarDiv[0m, time elapsed: 225000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarDiv (12100 ns)
    TCS: [33mTestCase_testVec4ScalarMod[0m, time elapsed: 205700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarMod (15200 ns)
    TCS: [33mTestCase_testVec4BoolLogicalOr[0m, time elapsed: 198400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BoolLogicalOr (9700 ns)
    TCS: [33mTestCase_testVec4EqualEpsilon[0m, time elapsed: 268200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4EqualEpsilon (22600 ns)
    TCS: [33mTestCase_testVec4AddNamed[0m, time elapsed: 214800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4AddNamed (15400 ns)
    TCS: [33mTestCase_testVec4MulNamed[0m, time elapsed: 203200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4MulNamed (7800 ns)
    TCS: [33mTestCase_testVec4DivNamed[0m, time elapsed: 209200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4DivNamed (7300 ns)
    TCS: [33mTestCase_testVec4ModNamed[0m, time elapsed: 210500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ModNamed (8200 ns)
    TCS: [33mTestCase_testVec4BitwiseOr[0m, time elapsed: 223000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseOr (13800 ns)
    TCS: [33mTestCase_testVec4BitwiseXor[0m, time elapsed: 439700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseXor (14400 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseAnd[0m, time elapsed: 397200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseAnd (22600 ns)
    TCS: [33mTestCase_testVec4ShiftRight[0m, time elapsed: 225300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRight (11100 ns)
    TCS: [33mTestCase_testVec4Vec1BitBroadcast[0m, time elapsed: 221500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitBroadcast (14000 ns)
    TCS: [33mTestCase_testVec4ShiftRightVec1[0m, time elapsed: 226100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRightVec1 (10700 ns)
    TCS: [33mTestCase_testVec4FromVec1[0m, time elapsed: 204000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4FromVec1 (7300 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseOr[0m, time elapsed: 210000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseOr (12200 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseXor[0m, time elapsed: 230100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseXor (11300 ns)
    TCS: [33mTestCase_testVec4Vec1BitOrBroadcast[0m, time elapsed: 250700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitOrBroadcast (26300 ns)
    TCS: [33mTestCase_testVec4Vec1BitXorBroadcast[0m, time elapsed: 229400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitXorBroadcast (15600 ns)
    TCS: [33mTestCase_testVec4ShiftLeftVec1[0m, time elapsed: 318100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeftVec1 (14400 ns)
    TCS: [33mTestCase_testVec4ShiftLeftVec[0m, time elapsed: 265600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeftVec (15500 ns)
    TCS: [33mTestCase_testVec4ShiftRightVec[0m, time elapsed: 258400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRightVec (24600 ns)
    TCS: [33mTestCase_testVec4Increment[0m, time elapsed: 312400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Increment (37500 ns)
    TCS: [33mTestCase_testVec4Decrement[0m, time elapsed: 235700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Decrement (19400 ns)
    TCS: [33mTestCase_testVec4IndexOutOfBoundsAccess[0m, time elapsed: 271500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4IndexOutOfBoundsAccess (49000 ns)
    TCS: [33mTestCase_testVec4NegativeIndexAccess[0m, time elapsed: 230600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4NegativeIndexAccess (22300 ns)
    TCS: [33mTestCase_testFunctor1Vec1Identity[0m, time elapsed: 244500 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec1Identity (18500 ns)
    TCS: [33mTestCase_testFunctor1Vec1Transform[0m, time elapsed: 257600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec1Transform (15500 ns)
    TCS: [33mTestCase_testFunctor1Vec2Transform[0m, time elapsed: 636200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec2Transform (28800 ns)
    TCS: [33mTestCase_testFunctor2Vec1Add[0m, time elapsed: 347100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec1Add (16400 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec1Mul[0m, time elapsed: 328800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec1Mul (24300 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec1Shift[0m, time elapsed: 349700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec1Shift (16600 ns)
    TCS: [33mTestCase_testFunctor1Vec3Transform[0m, time elapsed: 350200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec3Transform (18400 ns)
    TCS: [33mTestCase_testFunctor1Vec4Transform[0m, time elapsed: 291100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec4Transform (15400 ns)
    TCS: [33mTestCase_testFunctor2Vec2Add[0m, time elapsed: 290800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec2Add (13500 ns)
    TCS: [33mTestCase_testFunctor2Vec3Add[0m, time elapsed: 241900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec3Add (12600 ns)
    TCS: [33mTestCase_testFunctor2Vec4Add[0m, time elapsed: 300500 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec4Add (29700 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec2Mul[0m, time elapsed: 301500 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec2Mul (16200 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec3Mul[0m, time elapsed: 267700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec3Mul (17900 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec4Mul[0m, time elapsed: 240700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec4Mul (10700 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec2Shift[0m, time elapsed: 257000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec2Shift (14800 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec3Shift[0m, time elapsed: 246500 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec3Shift (10300 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec4Shift[0m, time elapsed: 246600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec4Shift (12500 ns)
Summary: TOTAL: 476
    [32mPASSED[0m: 476, [32mSKIPPED[0m: 0, ERROR: 0
    [31mFAILED[0m: 0
--------------------------------------------------------------------------------------------------
Project tests finished, time elapsed: 257890100 ns, RESULT:
TP: [33mglm[0m.*, time elapsed: 257810200 ns, RESULT:
    PASSED:
    TP: [33mglm.detail[0m, time elapsed: 241412000 ns
Summary: TOTAL: 476
    [32mPASSED[0m: 476, [32mSKIPPED[0m: 0, ERROR: 0
    [31mFAILED[0m: 0
--------------------------------------------------------------------------------------------------
cjpm test success
