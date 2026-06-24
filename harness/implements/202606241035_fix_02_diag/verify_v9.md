# 验证报告（v9）

## 结果
PASSED

## 统计
- 通过：476
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

warning: unused variable:'v'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:14:26:
   | 
14 | public func length<T, Q>(v: Vec3<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                          ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'b'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:14:26:
   | 
14 | public func mix<T>(a: T, b: T, t: T): T where T <: Number<T> { throw Exception("stub") }
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x4.cj:124:28:
    | 
124 |     public operator func /(rhs: Mat4x4<T, Q>): Mat4x4<T, Q> { throw Exception("stub") }
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

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:149:58:
    | 
149 |     public static func fromMat<SrcQ>(m: Mat2x4<T, SrcQ>, one: T): Mat2x3<T, Q>
    |                                                          ^^^ unused variable
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:155:58:
    | 
155 |     public static func fromMat<SrcQ>(m: Mat2x3<T, SrcQ>, one: T): Mat3x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:161:58:
    | 
161 |     public static func fromMat<SrcQ>(m: Mat2x4<T, SrcQ>, one: T): Mat3x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:167:58:
    | 
167 |     public static func fromMat<SrcQ>(m: Mat3x3<T, SrcQ>, one: T): Mat3x2<T, Q>
    |                                                          ^^^ unused variable
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:173:58:
    | 
173 |     public static func fromMat<SrcQ>(m: Mat3x2<T, SrcQ>, one: T): Mat4x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:191:58:
    | 
191 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat4x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:207:71:
    | 
207 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat3x3<U, P>, one: T): Mat2x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:217:71:
    | 
217 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x2<U, P>, one: T): Mat2x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:234:71:
    | 
234 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x4<U, P>, one: T): Mat3x2<T, Q>
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

153 warnings generated, 153 warnings printed.
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
[?25l




📦 group glm.detail                   10% [||------------------]      (00:00:00)
🧪 test TestCase_testComputeEqualInt64NotEqual at BeforeAll           (00:00:00)

passed: 50, failed: 0              10% [||------------------]  50/476 (00:00:00) 



📦 group glm.detail                   43% [||||||||------------]      (00:00:00)
🧪 test TestCase_testCastFloatToIntTruncation.testCastFloatTo...      (00:00:00)

passed: 208, failed: 0             43% [||||||||------------] 208/476 (00:00:00) 


📦 group glm.detail                  100% [||||||||||||||||||||] ✓    (00:00:00)

passed: 476, failed: 0            100% [||||||||||||||||||||] 476/476 (00:00:01) --------------------------------------------------------------------------------------------------
TP: glm.detail, time elapsed: 759465700 ns, RESULT:
    TCS: TestCase_testComputeVecAdd1, time elapsed: 3423700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAdd1 (773100 ns)
    TCS: TestCase_testComputeVecSub2, time elapsed: 1141100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSub2 (502700 ns)
    TCS: TestCase_testComputeVecMul3, time elapsed: 1950300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMul3 (1142200 ns)
    TCS: TestCase_testComputeVecMod1, time elapsed: 702400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMod1 (81000 ns)
    TCS: TestCase_testComputeVecMod4, time elapsed: 688800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMod4 (66600 ns)
    TCS: TestCase_testComputeVecAnd1, time elapsed: 651200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAnd1 (69700 ns)
    TCS: TestCase_testComputeVecAnd3, time elapsed: 739500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAnd3 (67000 ns)
    TCS: TestCase_testComputeVecOr1, time elapsed: 630800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecOr1 (55200 ns)
    TCS: TestCase_testComputeVecOr2, time elapsed: 580700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecOr2 (52300 ns)
    TCS: TestCase_testComputeVecXor1, time elapsed: 670700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecXor1 (57000 ns)
    TCS: TestCase_testComputeVecXor4, time elapsed: 725400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecXor4 (71100 ns)
    TCS: TestCase_testComputeVecShiftLeft1, time elapsed: 665800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftLeft1 (54000 ns)
    TCS: TestCase_testComputeVecShiftLeft3, time elapsed: 549100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftLeft3 (35100 ns)
    TCS: TestCase_testComputeVecShiftRight1, time elapsed: 501000 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftRight1 (33500 ns)
    TCS: TestCase_testComputeVecShiftRight4, time elapsed: 463400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftRight4 (33100 ns)
    TCS: TestCase_testComputeVecEqual1, time elapsed: 534300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual1 (36900 ns)
    TCS: TestCase_testComputeVecNequal4, time elapsed: 585700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecNequal4 (57500 ns)
    TCS: TestCase_testComputeVecBitwiseNot1, time elapsed: 682800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecBitwiseNot1 (56700 ns)
    TCS: TestCase_testComputeVecBitwiseNot3, time elapsed: 583100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecBitwiseNot3 (56500 ns)
    TCS: TestCase_testComputeVecAdd4, time elapsed: 598100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAdd4 (85800 ns)
    TCS: TestCase_testComputeVecSub1, time elapsed: 1370200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSub1 (56500 ns)
    TCS: TestCase_testComputeVecSub3, time elapsed: 584200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSub3 (65500 ns)
    TCS: TestCase_testComputeVecMul1, time elapsed: 490100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMul1 (67300 ns)
    TCS: TestCase_testComputeVecMul2, time elapsed: 679900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMul2 (62600 ns)
    TCS: TestCase_testComputeVecDiv1, time elapsed: 465200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecDiv1 (49100 ns)
    TCS: TestCase_testComputeVecDiv2, time elapsed: 418300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecDiv2 (44600 ns)
    TCS: TestCase_testComputeVecDiv4, time elapsed: 582900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecDiv4 (44400 ns)
    TCS: TestCase_testComputeVecEqual2, time elapsed: 752200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual2 (53700 ns)
    TCS: TestCase_testComputeVecEqual3, time elapsed: 543500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual3 (39600 ns)
    TCS: TestCase_testComputeVecEqual4, time elapsed: 511300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual4 (38800 ns)
    TCS: TestCase_testComputeVecNequal1, time elapsed: 406900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecNequal1 (28800 ns)
    TCS: TestCase_testComputeVecNequal2, time elapsed: 474900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecNequal2 (29300 ns)
    TCS: TestCase_testComputeVecBitwiseNot4, time elapsed: 550200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecBitwiseNot4 (59700 ns)
    TCS: TestCase_testComputeVecAddFloat32, time elapsed: 491100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAddFloat32 (60100 ns)
    TCS: TestCase_testComputeVecAddFloat32Vec3, time elapsed: 4421000 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAddFloat32Vec3 (1050700 ns)
    TCS: TestCase_testComputeVecSubFloat32, time elapsed: 833100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSubFloat32 (75200 ns)
    TCS: TestCase_testComputeVecSubFloat32Vec4, time elapsed: 749200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSubFloat32Vec4 (62900 ns)
    TCS: TestCase_testComputeEqualInt32Equal, time elapsed: 1700900 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt32Equal (99900 ns)
    TCS: TestCase_testComputeEqualInt32NotEqual, time elapsed: 1317800 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt32NotEqual (102100 ns)
    TCS: TestCase_testComputeEqualFloat32Equal, time elapsed: 1406400 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32Equal (94800 ns)
    TCS: TestCase_testComputeEqualFloat32NotEqual, time elapsed: 1855600 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32NotEqual (207000 ns)
    TCS: TestCase_testComputeEqualFloat64Equal, time elapsed: 1367200 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64Equal (74000 ns)
    TCS: TestCase_testComputeEqualFloat64NotEqual, time elapsed: 894700 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64NotEqual (42400 ns)
    TCS: TestCase_testComputeEqualBoolEqual, time elapsed: 10700700 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualBoolEqual (768100 ns)
    TCS: TestCase_testComputeEqualBoolNotEqual, time elapsed: 8975800 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualBoolNotEqual (321100 ns)
    TCS: TestCase_testComputeEqualNumericInt32, time elapsed: 2397000 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericInt32 (177000 ns)
    TCS: TestCase_testComputeEqualNumericFloat32, time elapsed: 9576200 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32 (177900 ns)
    TCS: TestCase_testComputeEqualNumericFloat32Epsilon, time elapsed: 2101400 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32Epsilon (213700 ns)
    TCS: TestCase_testComputeEqualNumericFloat64, time elapsed: 1455800 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64 (100700 ns)
    TCS: TestCase_testComputeEqualInt64Equal, time elapsed: 3088300 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt64Equal (95700 ns)
    TCS: TestCase_testComputeEqualInt64NotEqual, time elapsed: 1463500 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt64NotEqual (117900 ns)
    TCS: TestCase_testComputeEqualFloat32Nan, time elapsed: 14772200 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32Nan (4553800 ns)
    TCS: TestCase_testComputeEqualFloat64Nan, time elapsed: 4897600 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64Nan (154900 ns)
    TCS: TestCase_testComputeEqualFloat32SignedZero, time elapsed: 1236700 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32SignedZero (93600 ns)
    TCS: TestCase_testComputeEqualFloat64SignedZero, time elapsed: 1678900 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64SignedZero (69300 ns)
    TCS: TestCase_testComputeEqualNumericFloat32NotEqual, time elapsed: 918700 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32NotEqual (62900 ns)
    TCS: TestCase_testComputeEqualNumericFloat32BeyondEpsilon, time elapsed: 1276300 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32BeyondEpsilon (85800 ns)
    TCS: TestCase_testComputeEqualNumericFloat64NotEqual, time elapsed: 2655600 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64NotEqual (109800 ns)
    TCS: TestCase_testComputeEqualNumericFloat64Epsilon, time elapsed: 1277600 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64Epsilon (72700 ns)
    TCS: TestCase_testComputeEqualNumericFloat64BeyondEpsilon, time elapsed: 7320400 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64BeyondEpsilon (1009200 ns)
    TCS: TestCase_testComputeEqualNumericInt64, time elapsed: 1748900 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericInt64 (58500 ns)
    TCS: TestCase_testPackedHighpImplementsQualifier, time elapsed: 1960600 ns, RESULT:
    [ PASSED ] CASE: testPackedHighpImplementsQualifier (188500 ns)
    TCS: TestCase_testPackedMediumpImplementsQualifier, time elapsed: 3825800 ns, RESULT:
    [ PASSED ] CASE: testPackedMediumpImplementsQualifier (288800 ns)
    TCS: TestCase_testPackedLowpImplementsQualifier, time elapsed: 3302300 ns, RESULT:
    [ PASSED ] CASE: testPackedLowpImplementsQualifier (224500 ns)
    TCS: TestCase_testDefaultpIsPackedHighp, time elapsed: 781400 ns, RESULT:
    [ PASSED ] CASE: testDefaultpIsPackedHighp (69400 ns)
    TCS: TestCase_testScalarAddVec1, time elapsed: 510000 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec1 (31700 ns)
    TCS: TestCase_testScalarAddVec2, time elapsed: 541100 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec2 (33800 ns)
    TCS: TestCase_testScalarAddVec3, time elapsed: 2923900 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec3 (1804100 ns)
    TCS: TestCase_testScalarAddVec4, time elapsed: 601800 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec4 (41300 ns)
    TCS: TestCase_testScalarSubVec1, time elapsed: 504100 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1 (31700 ns)
    TCS: TestCase_testScalarMulVec1, time elapsed: 2845200 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1 (1827800 ns)
    TCS: TestCase_testScalarDivVec1, time elapsed: 1426300 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1 (836800 ns)
    TCS: TestCase_testScalarModVec1, time elapsed: 918200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1 (291300 ns)
    TCS: TestCase_testScalarMulVec2, time elapsed: 2045700 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2 (65500 ns)
    TCS: TestCase_testScalarSubVec2, time elapsed: 1261100 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2 (44400 ns)
    TCS: TestCase_testScalarSubVec3, time elapsed: 719400 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3 (40800 ns)
    TCS: TestCase_testScalarSubVec4, time elapsed: 835100 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4 (41000 ns)
    TCS: TestCase_testScalarMulVec3, time elapsed: 2963900 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3 (112400 ns)
    TCS: TestCase_testScalarMulVec4, time elapsed: 1266600 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4 (130000 ns)
    TCS: TestCase_testScalarDivVec2, time elapsed: 5278400 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2 (1509600 ns)
    TCS: TestCase_testScalarDivVec3, time elapsed: 1572000 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3 (395200 ns)
    TCS: TestCase_testScalarDivVec4, time elapsed: 1421100 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4 (78700 ns)
    TCS: TestCase_testScalarModVec2, time elapsed: 2353000 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2 (369900 ns)
    TCS: TestCase_testScalarModVec3, time elapsed: 1027900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3 (47800 ns)
    TCS: TestCase_testScalarModVec4, time elapsed: 2996100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4 (200400 ns)
    TCS: TestCase_testScalarModVec1Float32, time elapsed: 1308000 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Float32 (246200 ns)
    TCS: TestCase_testScalarModVec2Float32, time elapsed: 623400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32 (34600 ns)
    TCS: TestCase_testScalarModVec3Float32, time elapsed: 606700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Float32 (54500 ns)
    TCS: TestCase_testScalarModVec4Float32, time elapsed: 723900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Float32 (64500 ns)
    TCS: TestCase_testScalarModVec1Float64, time elapsed: 655700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Float64 (48400 ns)
    TCS: TestCase_testScalarModVec2Float64, time elapsed: 636500 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float64 (32600 ns)
    TCS: TestCase_testScalarModVec3Float64, time elapsed: 854700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Float64 (43300 ns)
    TCS: TestCase_testScalarModVec4Float64, time elapsed: 367400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Float64 (29700 ns)
    TCS: TestCase_testScalarModVec1Float16, time elapsed: 1742700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Float16 (1133500 ns)
    TCS: TestCase_testScalarModVec2Float16, time elapsed: 913300 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float16 (42400 ns)
    TCS: TestCase_testScalarModVec3Float16, time elapsed: 661200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Float16 (35400 ns)
    TCS: TestCase_testScalarModVec4Float16, time elapsed: 583200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Float16 (33900 ns)
    TCS: TestCase_testScalarSubVec2PackedMediump, time elapsed: 950500 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2PackedMediump (60800 ns)
    TCS: TestCase_testScalarSubVec2PackedLowp, time elapsed: 730800 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2PackedLowp (73200 ns)
    TCS: TestCase_testScalarMulVec2PackedMediump, time elapsed: 652400 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2PackedMediump (45400 ns)
    TCS: TestCase_testScalarMulVec2PackedLowp, time elapsed: 1218000 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2PackedLowp (83700 ns)
    TCS: TestCase_testScalarDivVec2PackedMediump, time elapsed: 1145500 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2PackedMediump (87300 ns)
    TCS: TestCase_testScalarDivVec2PackedLowp, time elapsed: 952400 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2PackedLowp (58200 ns)
    TCS: TestCase_testScalarModVec2PackedMediump, time elapsed: 1006400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2PackedMediump (105200 ns)
    TCS: TestCase_testScalarModVec2PackedLowp, time elapsed: 1646200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2PackedLowp (251000 ns)
    TCS: TestCase_testScalarModVec2Float32PackedMediump, time elapsed: 994800 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32PackedMediump (66900 ns)
    TCS: TestCase_testScalarModVec2Float32PackedLowp, time elapsed: 1198200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32PackedLowp (45500 ns)
    TCS: TestCase_testScalarModVec2Float32NegativeDividend, time elapsed: 3141300 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32NegativeDividend (52200 ns)
    TCS: TestCase_testScalarModVec2Float32NegativeDivisor, time elapsed: 1887200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32NegativeDivisor (213700 ns)
    TCS: TestCase_testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents, time elapsed: 8589900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents (7400900 ns)
    TCS: TestCase_testScalarAddVec1Float32, time elapsed: 506600 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec1Float32 (36200 ns)
    TCS: TestCase_testScalarAddVec2Float32, time elapsed: 719900 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec2Float32 (202300 ns)
    TCS: TestCase_testScalarAddVec3Float32, time elapsed: 436500 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec3Float32 (27600 ns)
    TCS: TestCase_testScalarAddVec4Float32, time elapsed: 520100 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec4Float32 (28600 ns)
    TCS: TestCase_testScalarSubVec1Float32, time elapsed: 626000 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1Float32 (40900 ns)
    TCS: TestCase_testScalarSubVec2Float32, time elapsed: 654200 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2Float32 (46800 ns)
    TCS: TestCase_testScalarSubVec3Float32, time elapsed: 601500 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3Float32 (37700 ns)
    TCS: TestCase_testScalarSubVec4Float32, time elapsed: 868800 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4Float32 (41700 ns)
    TCS: TestCase_testScalarMulVec1Float32, time elapsed: 554000 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1Float32 (37200 ns)
    TCS: TestCase_testScalarMulVec2Float32, time elapsed: 640000 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2Float32 (42900 ns)
    TCS: TestCase_testScalarMulVec3Float32, time elapsed: 547100 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3Float32 (46100 ns)
    TCS: TestCase_testScalarMulVec4Float32, time elapsed: 523900 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4Float32 (35700 ns)
    TCS: TestCase_testScalarDivVec1Float32, time elapsed: 789300 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1Float32 (40100 ns)
    TCS: TestCase_testScalarDivVec2Float32, time elapsed: 596100 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2Float32 (42900 ns)
    TCS: TestCase_testScalarDivVec3Float32, time elapsed: 521900 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3Float32 (43000 ns)
    TCS: TestCase_testScalarDivVec4Float32, time elapsed: 581000 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4Float32 (35900 ns)
    TCS: TestCase_testScalarAddVec1Int32, time elapsed: 819600 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec1Int32 (213000 ns)
    TCS: TestCase_testScalarAddVec2Int32, time elapsed: 1357600 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec2Int32 (36500 ns)
    TCS: TestCase_testScalarAddVec3Int32, time elapsed: 635300 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec3Int32 (44600 ns)
    TCS: TestCase_testScalarAddVec4Int32, time elapsed: 957500 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec4Int32 (57100 ns)
    TCS: TestCase_testScalarSubVec1Int32, time elapsed: 1524700 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1Int32 (74400 ns)
    TCS: TestCase_testScalarSubVec2Int32, time elapsed: 708500 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2Int32 (31200 ns)
    TCS: TestCase_testScalarSubVec3Int32, time elapsed: 743100 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3Int32 (35800 ns)
    TCS: TestCase_testScalarSubVec4Int32, time elapsed: 1881700 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4Int32 (63600 ns)
    TCS: TestCase_testScalarMulVec1Int32, time elapsed: 969400 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1Int32 (50300 ns)
    TCS: TestCase_testScalarMulVec2Int32, time elapsed: 1575800 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2Int32 (116100 ns)
    TCS: TestCase_testScalarMulVec3Int32, time elapsed: 3067200 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3Int32 (779800 ns)
    TCS: TestCase_testScalarMulVec4Int32, time elapsed: 1164400 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4Int32 (36300 ns)
    TCS: TestCase_testScalarDivVec1Int32, time elapsed: 855800 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1Int32 (31500 ns)
    TCS: TestCase_testScalarDivVec2Int32, time elapsed: 1120800 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2Int32 (36600 ns)
    TCS: TestCase_testScalarDivVec3Int32, time elapsed: 648400 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3Int32 (46500 ns)
    TCS: TestCase_testScalarDivVec4Int32, time elapsed: 955100 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4Int32 (47500 ns)
    TCS: TestCase_testScalarModVec1Int32, time elapsed: 2520900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Int32 (265600 ns)
    TCS: TestCase_testScalarModVec2Int32, time elapsed: 3904500 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Int32 (147400 ns)
    TCS: TestCase_testScalarModVec3Int32, time elapsed: 2857400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Int32 (418900 ns)
    TCS: TestCase_testScalarModVec4Int32, time elapsed: 1519200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Int32 (50800 ns)
    TCS: TestCase_testScalarSubVec1PackedMediump, time elapsed: 1283400 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1PackedMediump (97700 ns)
    TCS: TestCase_testScalarSubVec1PackedLowp, time elapsed: 4284900 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1PackedLowp (89300 ns)
    TCS: TestCase_testScalarSubVec3PackedMediump, time elapsed: 2888300 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3PackedMediump (264500 ns)
    TCS: TestCase_testScalarSubVec3PackedLowp, time elapsed: 1424600 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3PackedLowp (103200 ns)
    TCS: TestCase_testScalarSubVec4PackedMediump, time elapsed: 1645100 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4PackedMediump (700100 ns)
    TCS: TestCase_testScalarSubVec4PackedLowp, time elapsed: 870100 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4PackedLowp (200600 ns)
    TCS: TestCase_testScalarMulVec1PackedMediump, time elapsed: 626400 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1PackedMediump (34800 ns)
    TCS: TestCase_testScalarMulVec1PackedLowp, time elapsed: 461600 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1PackedLowp (28400 ns)
    TCS: TestCase_testScalarMulVec3PackedMediump, time elapsed: 3112400 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3PackedMediump (82700 ns)
    TCS: TestCase_testScalarMulVec3PackedLowp, time elapsed: 5342000 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3PackedLowp (158400 ns)
    TCS: TestCase_testScalarMulVec4PackedMediump, time elapsed: 4031200 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4PackedMediump (77300 ns)
    TCS: TestCase_testScalarMulVec4PackedLowp, time elapsed: 5495200 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4PackedLowp (354400 ns)
    TCS: TestCase_testScalarDivVec1PackedMediump, time elapsed: 6446200 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1PackedMediump (287800 ns)
    TCS: TestCase_testScalarDivVec1PackedLowp, time elapsed: 3182400 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1PackedLowp (133300 ns)
    TCS: TestCase_testScalarDivVec3PackedMediump, time elapsed: 1792400 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3PackedMediump (106000 ns)
    TCS: TestCase_testScalarDivVec3PackedLowp, time elapsed: 928000 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3PackedLowp (50800 ns)
    TCS: TestCase_testScalarDivVec4PackedMediump, time elapsed: 605700 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4PackedMediump (70200 ns)
    TCS: TestCase_testScalarDivVec4PackedLowp, time elapsed: 675700 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4PackedLowp (31900 ns)
    TCS: TestCase_testScalarModVec1PackedMediump, time elapsed: 551800 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1PackedMediump (34400 ns)
    TCS: TestCase_testScalarModVec1PackedLowp, time elapsed: 514400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1PackedLowp (30400 ns)
    TCS: TestCase_testScalarModVec3PackedMediump, time elapsed: 2658400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3PackedMediump (371200 ns)
    TCS: TestCase_testScalarModVec3PackedLowp, time elapsed: 2134800 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3PackedLowp (74500 ns)
    TCS: TestCase_testScalarModVec4PackedMediump, time elapsed: 1177100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4PackedMediump (72800 ns)
    TCS: TestCase_testScalarModVec4PackedLowp, time elapsed: 786900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4PackedLowp (29300 ns)
    TCS: TestCase_testScalarDivZeroVec1, time elapsed: 815400 ns, RESULT:
    [ PASSED ] CASE: testScalarDivZeroVec1 (204600 ns)
    TCS: TestCase_testScalarAddNegVec1, time elapsed: 663600 ns, RESULT:
    [ PASSED ] CASE: testScalarAddNegVec1 (39600 ns)
    TCS: TestCase_testScalarAddNegVec2, time elapsed: 498200 ns, RESULT:
    [ PASSED ] CASE: testScalarAddNegVec2 (29400 ns)
    TCS: TestCase_testScalarMulOverflowVec1, time elapsed: 377300 ns, RESULT:
    [ PASSED ] CASE: testScalarMulOverflowVec1 (19600 ns)
    TCS: TestCase_testScalarSubNegVec1, time elapsed: 521000 ns, RESULT:
    [ PASSED ] CASE: testScalarSubNegVec1 (34300 ns)
    TCS: TestCase_testVersionMajor, time elapsed: 522700 ns, RESULT:
    [ PASSED ] CASE: testVersionMajor (27000 ns)
    TCS: TestCase_testVersionMinor, time elapsed: 903300 ns, RESULT:
    [ PASSED ] CASE: testVersionMinor (28700 ns)
    TCS: TestCase_testVersionPatch, time elapsed: 449500 ns, RESULT:
    [ PASSED ] CASE: testVersionPatch (25700 ns)
    TCS: TestCase_testVersionEncoded, time elapsed: 697800 ns, RESULT:
    [ PASSED ] CASE: testVersionEncoded (172700 ns)
    TCS: TestCase_testConfigSimd, time elapsed: 2948500 ns, RESULT:
    [ PASSED ] CASE: testConfigSimd (1341100 ns)
    TCS: TestCase_testConfigAlignedGentypes, time elapsed: 573900 ns, RESULT:
    [ PASSED ] CASE: testConfigAlignedGentypes (37800 ns)
    TCS: TestCase_testConfigClipControl, time elapsed: 446600 ns, RESULT:
    [ PASSED ] CASE: testConfigClipControl (26800 ns)
    TCS: TestCase_testConstNegationSimd, time elapsed: 452300 ns, RESULT:
    [ PASSED ] CASE: testConstNegationSimd (24000 ns)
    TCS: TestCase_testConstNegationAligned, time elapsed: 418700 ns, RESULT:
    [ PASSED ] CASE: testConstNegationAligned (21400 ns)
    TCS: TestCase_testConstNegationClip, time elapsed: 488400 ns, RESULT:
    [ PASSED ] CASE: testConstNegationClip (24500 ns)
    TCS: TestCase_testConstInt64Usage, time elapsed: 385400 ns, RESULT:
    [ PASSED ] CASE: testConstInt64Usage (23500 ns)
    TCS: TestCase_testConstBoolUsage, time elapsed: 394900 ns, RESULT:
    [ PASSED ] CASE: testConstBoolUsage (24000 ns)
    TCS: TestCase_testVersionEncodingConsistency, time elapsed: 370600 ns, RESULT:
    [ PASSED ] CASE: testVersionEncodingConsistency (14300 ns)
    TCS: TestCase_testAssertPasses, time elapsed: 589900 ns, RESULT:
    [ PASSED ] CASE: testAssertPasses (163200 ns)
    TCS: TestCase_testAssertFails, time elapsed: 2727700 ns, RESULT:
    [ PASSED ] CASE: testAssertFails (2070900 ns)
    TCS: TestCase_testAssertWithCustomMessage, time elapsed: 2027700 ns, RESULT:
    [ PASSED ] CASE: testAssertWithCustomMessage (1241600 ns)
    TCS: TestCase_testNumericLimitsFloat32Epsilon, time elapsed: 853800 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsFloat32Epsilon (47000 ns)
    TCS: TestCase_testNumericLimitsFloat64Epsilon, time elapsed: 639900 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsFloat64Epsilon (36300 ns)
    TCS: TestCase_testIsIec559OfFloat32, time elapsed: 516600 ns, RESULT:
    [ PASSED ] CASE: testIsIec559OfFloat32 (33900 ns)
    TCS: TestCase_testIsIec559OfFloat64, time elapsed: 2062200 ns, RESULT:
    [ PASSED ] CASE: testIsIec559OfFloat64 (31200 ns)
    TCS: TestCase_testIsIec559OfInt64, time elapsed: 629900 ns, RESULT:
    [ PASSED ] CASE: testIsIec559OfInt64 (63700 ns)
    TCS: TestCase_testEpsilonOfFloat32, time elapsed: 1124700 ns, RESULT:
    [ PASSED ] CASE: testEpsilonOfFloat32 (231100 ns)
    TCS: TestCase_testEpsilonOfFloat64, time elapsed: 688400 ns, RESULT:
    [ PASSED ] CASE: testEpsilonOfFloat64 (61300 ns)
    TCS: TestCase_testNumericLimitsInt64Epsilon, time elapsed: 508300 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt64Epsilon (33000 ns)
    TCS: TestCase_testNumericLimitsInt32Epsilon, time elapsed: 637200 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt32Epsilon (36900 ns)
    TCS: TestCase_testNumericLimitsInt16Epsilon, time elapsed: 617300 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt16Epsilon (38300 ns)
    TCS: TestCase_testNumericLimitsInt8Epsilon, time elapsed: 1829500 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt8Epsilon (86000 ns)
    TCS: TestCase_testCastVec1ToVec1IntToFloat, time elapsed: 1126400 ns, RESULT:
    [ PASSED ] CASE: testCastVec1ToVec1IntToFloat (271100 ns)
    TCS: TestCase_testCastVec2ToVec1TakesOnlyX, time elapsed: 873100 ns, RESULT:
    [ PASSED ] CASE: testCastVec2ToVec1TakesOnlyX (84100 ns)
    TCS: TestCase_testCastVec3ToVec1TakesOnlyX, time elapsed: 3126900 ns, RESULT:
    [ PASSED ] CASE: testCastVec3ToVec1TakesOnlyX (66000 ns)
    TCS: TestCase_testCastVec4ToVec1TakesOnlyX, time elapsed: 9429500 ns, RESULT:
    [ PASSED ] CASE: testCastVec4ToVec1TakesOnlyX (289100 ns)
    TCS: TestCase_testCastSameTypeIdentity, time elapsed: 2338500 ns, RESULT:
    [ PASSED ] CASE: testCastSameTypeIdentity (324800 ns)
    TCS: TestCase_testCastInt32ToInt64, time elapsed: 2364100 ns, RESULT:
    [ PASSED ] CASE: testCastInt32ToInt64 (374500 ns)
    TCS: TestCase_testCastFloatToIntTruncation, time elapsed: 3606400 ns, RESULT:
    [ PASSED ] CASE: testCastFloatToIntTruncation (167100 ns)
    TCS: TestCase_testCastCrossQualifierPackedHighpToDefaultp, time elapsed: 2878200 ns, RESULT:
    [ PASSED ] CASE: testCastCrossQualifierPackedHighpToDefaultp (205500 ns)
    TCS: TestCase_testCastCrossQualifierDefaultpToPackedHighp, time elapsed: 9940400 ns, RESULT:
    [ PASSED ] CASE: testCastCrossQualifierDefaultpToPackedHighp (675200 ns)
    TCS: TestCase_testCastVec2CrossQualifierCrossType, time elapsed: 2602500 ns, RESULT:
    [ PASSED ] CASE: testCastVec2CrossQualifierCrossType (171900 ns)
    TCS: TestCase_testCastVec3CrossQualifier, time elapsed: 872700 ns, RESULT:
    [ PASSED ] CASE: testCastVec3CrossQualifier (51400 ns)
    TCS: TestCase_testCastVec4CrossQualifier, time elapsed: 383300 ns, RESULT:
    [ PASSED ] CASE: testCastVec4CrossQualifier (19400 ns)
    TCS: TestCase_testCastVec1DoesNotModifySource, time elapsed: 443700 ns, RESULT:
    [ PASSED ] CASE: testCastVec1DoesNotModifySource (20800 ns)
    TCS: TestCase_testCastVec2Vec1ToVec2IntToFloat, time elapsed: 718600 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec1ToVec2IntToFloat (27000 ns)
    TCS: TestCase_testCastVec2Vec2ToVec2Identity, time elapsed: 791300 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec2ToVec2Identity (118700 ns)
    TCS: TestCase_testCastVec2Vec3ToVec2TakesOnlyXY, time elapsed: 1813800 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec3ToVec2TakesOnlyXY (259600 ns)
    TCS: TestCase_testCastVec2Vec4ToVec2TakesOnlyXY, time elapsed: 954600 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec4ToVec2TakesOnlyXY (101700 ns)
    TCS: TestCase_testCastVec2SameTypeIdentity, time elapsed: 467400 ns, RESULT:
    [ PASSED ] CASE: testCastVec2SameTypeIdentity (23100 ns)
    TCS: TestCase_testCastVec2Int32ToInt64, time elapsed: 756700 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Int32ToInt64 (24800 ns)
    TCS: TestCase_testCastVec2FloatToIntTruncation, time elapsed: 2162900 ns, RESULT:
    [ PASSED ] CASE: testCastVec2FloatToIntTruncation (151700 ns)
    TCS: TestCase_testCastVec2CrossQualifierPackedHighpToDefaultp, time elapsed: 1453600 ns, RESULT:
    [ PASSED ] CASE: testCastVec2CrossQualifierPackedHighpToDefaultp (184700 ns)
    TCS: TestCase_testCastVec2DoesNotModifySource, time elapsed: 1150000 ns, RESULT:
    [ PASSED ] CASE: testCastVec2DoesNotModifySource (48500 ns)
    TCS: TestCase_testCastVec2Vec1ToVec2SameValueBothComponents, time elapsed: 352200 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec1ToVec2SameValueBothComponents (19900 ns)
    TCS: TestCase_testCastVec3Vec1ToVec3IntToFloat, time elapsed: 978400 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec1ToVec3IntToFloat (35800 ns)
    TCS: TestCase_testCastVec3Vec2ToVec3ExtendY, time elapsed: 689300 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec2ToVec3ExtendY (49300 ns)
    TCS: TestCase_testCastVec3Vec3ToVec3Identity, time elapsed: 790400 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec3ToVec3Identity (45800 ns)
    TCS: TestCase_testCastVec3Vec4ToVec3TakesOnlyXYZ, time elapsed: 1557100 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec4ToVec3TakesOnlyXYZ (84100 ns)
    TCS: TestCase_testCastVec3SameTypeIdentity, time elapsed: 1443400 ns, RESULT:
    [ PASSED ] CASE: testCastVec3SameTypeIdentity (92500 ns)
    TCS: TestCase_testCastVec3Int32ToInt64, time elapsed: 780700 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Int32ToInt64 (61600 ns)
    TCS: TestCase_testCastVec3FloatToIntTruncation, time elapsed: 1191300 ns, RESULT:
    [ PASSED ] CASE: testCastVec3FloatToIntTruncation (82200 ns)
    TCS: TestCase_testCastVec3CrossQualifierPackedHighpToDefaultp, time elapsed: 1553600 ns, RESULT:
    [ PASSED ] CASE: testCastVec3CrossQualifierPackedHighpToDefaultp (111100 ns)
    TCS: TestCase_testCastVec3DoesNotModifySource, time elapsed: 495000 ns, RESULT:
    [ PASSED ] CASE: testCastVec3DoesNotModifySource (28700 ns)
    TCS: TestCase_testCastVec3Vec1ToVec3SameValueAllComponents, time elapsed: 441200 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec1ToVec3SameValueAllComponents (21500 ns)
    TCS: TestCase_testCastVec4Vec1ToVec4IntToFloat, time elapsed: 445200 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec1ToVec4IntToFloat (21600 ns)
    TCS: TestCase_testCastVec4Vec2ToVec4ExtendY, time elapsed: 329800 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec2ToVec4ExtendY (22200 ns)
    TCS: TestCase_testCastVec4Vec3ToVec4ExtendZ, time elapsed: 758900 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec3ToVec4ExtendZ (39800 ns)
    TCS: TestCase_testCastVec4Vec4ToVec4Identity, time elapsed: 2366800 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec4ToVec4Identity (1643700 ns)
    TCS: TestCase_testCastVec4SameTypeIdentity, time elapsed: 635400 ns, RESULT:
    [ PASSED ] CASE: testCastVec4SameTypeIdentity (44800 ns)
    TCS: TestCase_testCastVec4Int32ToInt64, time elapsed: 459500 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Int32ToInt64 (40800 ns)
    TCS: TestCase_testCastVec4FloatToIntTruncation, time elapsed: 1137700 ns, RESULT:
    [ PASSED ] CASE: testCastVec4FloatToIntTruncation (21300 ns)
    TCS: TestCase_testCastVec4CrossQualifierPackedHighpToDefaultp, time elapsed: 484100 ns, RESULT:
    [ PASSED ] CASE: testCastVec4CrossQualifierPackedHighpToDefaultp (26400 ns)
    TCS: TestCase_testCastVec4DoesNotModifySource, time elapsed: 411300 ns, RESULT:
    [ PASSED ] CASE: testCastVec4DoesNotModifySource (21900 ns)
    TCS: TestCase_testCastVec4Vec1ToVec4SameValueAllComponents, time elapsed: 426900 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec1ToVec4SameValueAllComponents (38400 ns)
    TCS: TestCase_testFromBoolVec1, time elapsed: 438900 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec1 (21800 ns)
    TCS: TestCase_testFromBoolVec1False, time elapsed: 354700 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec1False (17800 ns)
    TCS: TestCase_testFromBoolVec2, time elapsed: 356700 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec2 (17000 ns)
    TCS: TestCase_testFromBoolVec3, time elapsed: 349500 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec3 (16800 ns)
    TCS: TestCase_testFromBoolVec4, time elapsed: 385500 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec4 (19700 ns)
    TCS: TestCase_testFromBoolVecQ2Vec1, time elapsed: 532500 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec1 (22200 ns)
    TCS: TestCase_testFromBoolVecQ2Vec2, time elapsed: 366000 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec2 (17300 ns)
    TCS: TestCase_testFromBoolVecQ2Vec3, time elapsed: 568900 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec3 (167900 ns)
    TCS: TestCase_testFromBoolVecQ2Vec4, time elapsed: 436500 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec4 (22300 ns)
    TCS: TestCase_testFromBoolVec3AllFalse, time elapsed: 456000 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec3AllFalse (21800 ns)
    TCS: TestCase_testFromBoolVec4AllFalse, time elapsed: 493600 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec4AllFalse (24500 ns)
    TCS: TestCase_testFromBoolVecQ2Vec3AllFalse, time elapsed: 482900 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec3AllFalse (25700 ns)
    TCS: TestCase_testFromBoolVecQ2Vec4AllFalse, time elapsed: 502000 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec4AllFalse (24500 ns)
    TCS: TestCase_testFromBoolVecFloat32, time elapsed: 528200 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecFloat32 (26100 ns)
    TCS: TestCase_testFromBoolVecFloat64, time elapsed: 654900 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecFloat64 (39300 ns)
    TCS: TestCase_testFromBoolVecInt32, time elapsed: 533600 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecInt32 (25800 ns)
    TCS: TestCase_testFromBoolVecQ2PackedMediump, time elapsed: 508400 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2PackedMediump (25200 ns)
    TCS: TestCase_testFromBoolVecQ2PackedLowp, time elapsed: 462100 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2PackedLowp (24600 ns)
    TCS: TestCase_testVec1ConstInit, time elapsed: 924900 ns, RESULT:
    [ PASSED ] CASE: testVec1ConstInit (305000 ns)
    TCS: TestCase_testVec1Length, time elapsed: 533500 ns, RESULT:
    [ PASSED ] CASE: testVec1Length (26100 ns)
    TCS: TestCase_testVec1IndexAccess, time elapsed: 617800 ns, RESULT:
    [ PASSED ] CASE: testVec1IndexAccess (54000 ns)
    TCS: TestCase_testVec1IndexMutate, time elapsed: 479500 ns, RESULT:
    [ PASSED ] CASE: testVec1IndexMutate (22600 ns)
    TCS: TestCase_testVec1ComponentAt, time elapsed: 598100 ns, RESULT:
    [ PASSED ] CASE: testVec1ComponentAt (24700 ns)
    TCS: TestCase_testVec1Add, time elapsed: 604700 ns, RESULT:
    [ PASSED ] CASE: testVec1Add (188100 ns)
    TCS: TestCase_testVec1Sub, time elapsed: 827700 ns, RESULT:
    [ PASSED ] CASE: testVec1Sub (332200 ns)
    TCS: TestCase_testVec1Mul, time elapsed: 649600 ns, RESULT:
    [ PASSED ] CASE: testVec1Mul (174100 ns)
    TCS: TestCase_testVec1Div, time elapsed: 781400 ns, RESULT:
    [ PASSED ] CASE: testVec1Div (200000 ns)
    TCS: TestCase_testVec1Mod, time elapsed: 526500 ns, RESULT:
    [ PASSED ] CASE: testVec1Mod (34200 ns)
    TCS: TestCase_testVec1ScalarAdd, time elapsed: 739200 ns, RESULT:
    [ PASSED ] CASE: testVec1ScalarAdd (219300 ns)
    TCS: TestCase_testVec1Negate, time elapsed: 1558100 ns, RESULT:
    [ PASSED ] CASE: testVec1Negate (44700 ns)
    TCS: TestCase_testVec1AddNamed, time elapsed: 2609900 ns, RESULT:
    [ PASSED ] CASE: testVec1AddNamed (336700 ns)
    TCS: TestCase_testVec1SubNamed, time elapsed: 1268600 ns, RESULT:
    [ PASSED ] CASE: testVec1SubNamed (178900 ns)
    TCS: TestCase_testVec1MulNamed, time elapsed: 1739800 ns, RESULT:
    [ PASSED ] CASE: testVec1MulNamed (157600 ns)
    TCS: TestCase_testVec1Equal, time elapsed: 1593900 ns, RESULT:
    [ PASSED ] CASE: testVec1Equal (828600 ns)
    TCS: TestCase_testVec1NotEqual, time elapsed: 522500 ns, RESULT:
    [ PASSED ] CASE: testVec1NotEqual (24300 ns)
    TCS: TestCase_testVec1EqualExact, time elapsed: 2072700 ns, RESULT:
    [ PASSED ] CASE: testVec1EqualExact (1412800 ns)
    TCS: TestCase_testVec1BitwiseAnd, time elapsed: 846700 ns, RESULT:
    [ PASSED ] CASE: testVec1BitwiseAnd (301700 ns)
    TCS: TestCase_testVec1BitwiseOr, time elapsed: 471100 ns, RESULT:
    [ PASSED ] CASE: testVec1BitwiseOr (46200 ns)
    TCS: TestCase_testVec1BitwiseXor, time elapsed: 476000 ns, RESULT:
    [ PASSED ] CASE: testVec1BitwiseXor (46400 ns)
    TCS: TestCase_testVec1ShiftLeft, time elapsed: 2304200 ns, RESULT:
    [ PASSED ] CASE: testVec1ShiftLeft (115800 ns)
    TCS: TestCase_testVec1ShiftRight, time elapsed: 1387500 ns, RESULT:
    [ PASSED ] CASE: testVec1ShiftRight (610900 ns)
    TCS: TestCase_testVec1BitwiseNot, time elapsed: 999900 ns, RESULT:
    [ PASSED ] CASE: testVec1BitwiseNot (34300 ns)
    TCS: TestCase_testVec1BoolLogicalAnd, time elapsed: 527300 ns, RESULT:
    [ PASSED ] CASE: testVec1BoolLogicalAnd (48300 ns)
    TCS: TestCase_testVec1BoolLogicalOr, time elapsed: 359300 ns, RESULT:
    [ PASSED ] CASE: testVec1BoolLogicalOr (15700 ns)
    TCS: TestCase_testVec1IndexOutOfBoundsAccess, time elapsed: 3936300 ns, RESULT:
    [ PASSED ] CASE: testVec1IndexOutOfBoundsAccess (3183600 ns)
    TCS: TestCase_testVec1ShiftVec, time elapsed: 343700 ns, RESULT:
    [ PASSED ] CASE: testVec1ShiftVec (14800 ns)
    TCS: TestCase_testVec1ScalarSub, time elapsed: 412900 ns, RESULT:
    [ PASSED ] CASE: testVec1ScalarSub (14900 ns)
    TCS: TestCase_testVec1ScalarMul, time elapsed: 314200 ns, RESULT:
    [ PASSED ] CASE: testVec1ScalarMul (10000 ns)
    TCS: TestCase_testVec1ScalarDiv, time elapsed: 323600 ns, RESULT:
    [ PASSED ] CASE: testVec1ScalarDiv (16900 ns)
    TCS: TestCase_testVec1ScalarMod, time elapsed: 336700 ns, RESULT:
    [ PASSED ] CASE: testVec1ScalarMod (13100 ns)
    TCS: TestCase_testVec1DivNamed, time elapsed: 294800 ns, RESULT:
    [ PASSED ] CASE: testVec1DivNamed (12400 ns)
    TCS: TestCase_testVec1ModNamed, time elapsed: 318000 ns, RESULT:
    [ PASSED ] CASE: testVec1ModNamed (12200 ns)
    TCS: TestCase_testVec1ScalarBitwiseAnd, time elapsed: 345000 ns, RESULT:
    [ PASSED ] CASE: testVec1ScalarBitwiseAnd (22300 ns)
    TCS: TestCase_testVec1ScalarBitwiseOr, time elapsed: 664200 ns, RESULT:
    [ PASSED ] CASE: testVec1ScalarBitwiseOr (43300 ns)
    TCS: TestCase_testVec1ScalarBitwiseXor, time elapsed: 1856200 ns, RESULT:
    [ PASSED ] CASE: testVec1ScalarBitwiseXor (18700 ns)
    TCS: TestCase_testVec1ShiftRightVec, time elapsed: 396600 ns, RESULT:
    [ PASSED ] CASE: testVec1ShiftRightVec (20700 ns)
    TCS: TestCase_testVec1EqualEpsilon, time elapsed: 336800 ns, RESULT:
    [ PASSED ] CASE: testVec1EqualEpsilon (28300 ns)
    TCS: TestCase_testVec1BroadcastAddVec2, time elapsed: 1789400 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastAddVec2 (1456000 ns)
    TCS: TestCase_testVec1BroadcastBitAndVec2, time elapsed: 3005800 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastBitAndVec2 (56500 ns)
    TCS: TestCase_testVec1BroadcastAddVec3, time elapsed: 543600 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastAddVec3 (51100 ns)
    TCS: TestCase_testVec1BroadcastAddVec4, time elapsed: 610300 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastAddVec4 (64700 ns)
    TCS: TestCase_testVec1BroadcastBitOrVec2, time elapsed: 487200 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastBitOrVec2 (25500 ns)
    TCS: TestCase_testVec1BroadcastBitXorVec2, time elapsed: 646200 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastBitXorVec2 (53000 ns)
    TCS: TestCase_testVec1BroadcastShiftLeftVec2, time elapsed: 552600 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastShiftLeftVec2 (31700 ns)
    TCS: TestCase_testVec1BroadcastShiftRightVec2, time elapsed: 570000 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastShiftRightVec2 (38600 ns)
    TCS: TestCase_testVec1BroadcastBitAndVec3, time elapsed: 529400 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastBitAndVec3 (32200 ns)
    TCS: TestCase_testVec1BroadcastBitAndVec4, time elapsed: 596700 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastBitAndVec4 (37600 ns)
    TCS: TestCase_testVec1BroadcastModVec2, time elapsed: 2691900 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastModVec2 (224700 ns)
    TCS: TestCase_testVec1BroadcastModVec3, time elapsed: 1879300 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastModVec3 (157400 ns)
    TCS: TestCase_testVec1BroadcastModVec4, time elapsed: 3483400 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastModVec4 (193400 ns)
    TCS: TestCase_testVec1Increment, time elapsed: 646100 ns, RESULT:
    [ PASSED ] CASE: testVec1Increment (38900 ns)
    TCS: TestCase_testVec1Decrement, time elapsed: 1417100 ns, RESULT:
    [ PASSED ] CASE: testVec1Decrement (80700 ns)
    TCS: TestCase_testVec2ScalarInit, time elapsed: 701900 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarInit (163400 ns)
    TCS: TestCase_testVec2ConstInit, time elapsed: 543900 ns, RESULT:
    [ PASSED ] CASE: testVec2ConstInit (30300 ns)
    TCS: TestCase_testVec2Length, time elapsed: 671900 ns, RESULT:
    [ PASSED ] CASE: testVec2Length (55900 ns)
    TCS: TestCase_testVec2Add, time elapsed: 2774600 ns, RESULT:
    [ PASSED ] CASE: testVec2Add (2085900 ns)
    TCS: TestCase_testVec2Sub, time elapsed: 1316700 ns, RESULT:
    [ PASSED ] CASE: testVec2Sub (861000 ns)
    TCS: TestCase_testVec2Mul, time elapsed: 340400 ns, RESULT:
    [ PASSED ] CASE: testVec2Mul (23000 ns)
    TCS: TestCase_testVec2ScalarAdd, time elapsed: 384900 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarAdd (19800 ns)
    TCS: TestCase_testVec2Negate, time elapsed: 381000 ns, RESULT:
    [ PASSED ] CASE: testVec2Negate (20300 ns)
    TCS: TestCase_testVec2IndexAccess, time elapsed: 500200 ns, RESULT:
    [ PASSED ] CASE: testVec2IndexAccess (18700 ns)
    TCS: TestCase_testVec2IndexMutate, time elapsed: 404400 ns, RESULT:
    [ PASSED ] CASE: testVec2IndexMutate (28100 ns)
    TCS: TestCase_testVec2ComponentAt, time elapsed: 406400 ns, RESULT:
    [ PASSED ] CASE: testVec2ComponentAt (13900 ns)
    TCS: TestCase_testVec2Equal, time elapsed: 627200 ns, RESULT:
    [ PASSED ] CASE: testVec2Equal (189600 ns)
    TCS: TestCase_testVec2NotEqual, time elapsed: 407400 ns, RESULT:
    [ PASSED ] CASE: testVec2NotEqual (23300 ns)
    TCS: TestCase_testVec2EqualExact, time elapsed: 394100 ns, RESULT:
    [ PASSED ] CASE: testVec2EqualExact (22800 ns)
    TCS: TestCase_testVec2BitwiseAnd, time elapsed: 673800 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseAnd (224300 ns)
    TCS: TestCase_testVec2BitwiseNot, time elapsed: 457000 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseNot (20400 ns)
    TCS: TestCase_testVec2FromVec1, time elapsed: 471800 ns, RESULT:
    [ PASSED ] CASE: testVec2FromVec1 (24400 ns)
    TCS: TestCase_testVec2ShiftLeft, time elapsed: 430100 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftLeft (27100 ns)
    TCS: TestCase_testVec2BoolLogicalAnd, time elapsed: 469400 ns, RESULT:
    [ PASSED ] CASE: testVec2BoolLogicalAnd (27500 ns)
    TCS: TestCase_testVec2Vec1ArithBroadcast, time elapsed: 515300 ns, RESULT:
    [ PASSED ] CASE: testVec2Vec1ArithBroadcast (26900 ns)
    TCS: TestCase_testVec2Vec1BitBroadcast, time elapsed: 796400 ns, RESULT:
    [ PASSED ] CASE: testVec2Vec1BitBroadcast (35100 ns)
    TCS: TestCase_testVec2ShiftLeftVec1, time elapsed: 569900 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftLeftVec1 (31500 ns)
    TCS: TestCase_testVec2Div, time elapsed: 649600 ns, RESULT:
    [ PASSED ] CASE: testVec2Div (28800 ns)
    TCS: TestCase_testVec2Mod, time elapsed: 464100 ns, RESULT:
    [ PASSED ] CASE: testVec2Mod (29700 ns)
    TCS: TestCase_testVec2ScalarSub, time elapsed: 470600 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarSub (27200 ns)
    TCS: TestCase_testVec2ScalarMul, time elapsed: 595300 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarMul (28700 ns)
    TCS: TestCase_testVec2ScalarDiv, time elapsed: 636900 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarDiv (41700 ns)
    TCS: TestCase_testVec2ScalarMod, time elapsed: 555800 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarMod (52200 ns)
    TCS: TestCase_testVec2BoolLogicalOr, time elapsed: 596900 ns, RESULT:
    [ PASSED ] CASE: testVec2BoolLogicalOr (32000 ns)
    TCS: TestCase_testVec2EqualEpsilon, time elapsed: 579200 ns, RESULT:
    [ PASSED ] CASE: testVec2EqualEpsilon (65000 ns)
    TCS: TestCase_testVec2DivNamed, time elapsed: 447400 ns, RESULT:
    [ PASSED ] CASE: testVec2DivNamed (28700 ns)
    TCS: TestCase_testVec2ModNamed, time elapsed: 452700 ns, RESULT:
    [ PASSED ] CASE: testVec2ModNamed (38200 ns)
    TCS: TestCase_testVec2BitwiseOr, time elapsed: 580400 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseOr (40200 ns)
    TCS: TestCase_testVec2BitwiseXor, time elapsed: 501700 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseXor (34500 ns)
    TCS: TestCase_testVec2ScalarBitwiseAnd, time elapsed: 953900 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarBitwiseAnd (159100 ns)
    TCS: TestCase_testVec2ShiftRight, time elapsed: 945500 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftRight (145000 ns)
    TCS: TestCase_testVec2ShiftRightVec1, time elapsed: 644300 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftRightVec1 (28700 ns)
    TCS: TestCase_testVec2AddNamed, time elapsed: 679600 ns, RESULT:
    [ PASSED ] CASE: testVec2AddNamed (42300 ns)
    TCS: TestCase_testVec2SubNamed, time elapsed: 950300 ns, RESULT:
    [ PASSED ] CASE: testVec2SubNamed (30400 ns)
    TCS: TestCase_testVec2MulNamed, time elapsed: 661800 ns, RESULT:
    [ PASSED ] CASE: testVec2MulNamed (39200 ns)
    TCS: TestCase_testVec2ShiftLeftVec, time elapsed: 530200 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftLeftVec (34200 ns)
    TCS: TestCase_testVec2ShiftRightVec, time elapsed: 570700 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftRightVec (30200 ns)
    TCS: TestCase_testVec2ScalarBitwiseOr, time elapsed: 353500 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarBitwiseOr (31900 ns)
    TCS: TestCase_testVec2ScalarBitwiseXor, time elapsed: 465800 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarBitwiseXor (31500 ns)
    TCS: TestCase_testVec2Increment, time elapsed: 488700 ns, RESULT:
    [ PASSED ] CASE: testVec2Increment (25500 ns)
    TCS: TestCase_testVec2Decrement, time elapsed: 898500 ns, RESULT:
    [ PASSED ] CASE: testVec2Decrement (45800 ns)
    TCS: TestCase_testVec2IndexOutOfBoundsAccess, time elapsed: 492000 ns, RESULT:
    [ PASSED ] CASE: testVec2IndexOutOfBoundsAccess (75800 ns)
    TCS: TestCase_testVec2NegativeIndexAccess, time elapsed: 497600 ns, RESULT:
    [ PASSED ] CASE: testVec2NegativeIndexAccess (76700 ns)
    TCS: TestCase_testVec3ScalarInit, time elapsed: 519700 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarInit (28700 ns)
    TCS: TestCase_testVec3ConstInit, time elapsed: 463600 ns, RESULT:
    [ PASSED ] CASE: testVec3ConstInit (23300 ns)
    TCS: TestCase_testVec3Length, time elapsed: 473100 ns, RESULT:
    [ PASSED ] CASE: testVec3Length (23000 ns)
    TCS: TestCase_testVec3Add, time elapsed: 646700 ns, RESULT:
    [ PASSED ] CASE: testVec3Add (183600 ns)
    TCS: TestCase_testVec3ScalarMul, time elapsed: 745200 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarMul (239700 ns)
    TCS: TestCase_testVec3Negate, time elapsed: 719900 ns, RESULT:
    [ PASSED ] CASE: testVec3Negate (218500 ns)
    TCS: TestCase_testVec3IndexAccess, time elapsed: 390400 ns, RESULT:
    [ PASSED ] CASE: testVec3IndexAccess (20600 ns)
    TCS: TestCase_testVec3IndexMutate, time elapsed: 613300 ns, RESULT:
    [ PASSED ] CASE: testVec3IndexMutate (20400 ns)
    TCS: TestCase_testVec3ComponentAt, time elapsed: 411900 ns, RESULT:
    [ PASSED ] CASE: testVec3ComponentAt (18700 ns)
    TCS: TestCase_testVec3Equal, time elapsed: 731300 ns, RESULT:
    [ PASSED ] CASE: testVec3Equal (172600 ns)
    TCS: TestCase_testVec3NotEqual, time elapsed: 905400 ns, RESULT:
    [ PASSED ] CASE: testVec3NotEqual (219400 ns)
    TCS: TestCase_testVec3EqualExact, time elapsed: 1815400 ns, RESULT:
    [ PASSED ] CASE: testVec3EqualExact (207500 ns)
    TCS: TestCase_testVec3BitwiseAnd, time elapsed: 1557400 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseAnd (610000 ns)
    TCS: TestCase_testVec3BitwiseNot, time elapsed: 497500 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseNot (30900 ns)
    TCS: TestCase_testVec3Vec1ArithBroadcast, time elapsed: 506500 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1ArithBroadcast (35400 ns)
    TCS: TestCase_testVec3ShiftLeft, time elapsed: 430700 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftLeft (26300 ns)
    TCS: TestCase_testVec3BoolLogicalAnd, time elapsed: 606300 ns, RESULT:
    [ PASSED ] CASE: testVec3BoolLogicalAnd (190800 ns)
    TCS: TestCase_testVec3Sub, time elapsed: 530000 ns, RESULT:
    [ PASSED ] CASE: testVec3Sub (52700 ns)
    TCS: TestCase_testVec3Div, time elapsed: 438400 ns, RESULT:
    [ PASSED ] CASE: testVec3Div (27200 ns)
    TCS: TestCase_testVec3Mod, time elapsed: 418000 ns, RESULT:
    [ PASSED ] CASE: testVec3Mod (24500 ns)
    TCS: TestCase_testVec3ScalarSub, time elapsed: 413700 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarSub (24400 ns)
    TCS: TestCase_testVec3ScalarDiv, time elapsed: 553900 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarDiv (127900 ns)
    TCS: TestCase_testVec3ScalarMod, time elapsed: 351600 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarMod (29100 ns)
    TCS: TestCase_testVec3BoolLogicalOr, time elapsed: 374500 ns, RESULT:
    [ PASSED ] CASE: testVec3BoolLogicalOr (19500 ns)
    TCS: TestCase_testVec3EqualEpsilon, time elapsed: 398600 ns, RESULT:
    [ PASSED ] CASE: testVec3EqualEpsilon (28500 ns)
    TCS: TestCase_testVec3AddNamed, time elapsed: 474900 ns, RESULT:
    [ PASSED ] CASE: testVec3AddNamed (24100 ns)
    TCS: TestCase_testVec3MulNamed, time elapsed: 414300 ns, RESULT:
    [ PASSED ] CASE: testVec3MulNamed (23300 ns)
    TCS: TestCase_testVec3DivNamed, time elapsed: 487000 ns, RESULT:
    [ PASSED ] CASE: testVec3DivNamed (31700 ns)
    TCS: TestCase_testVec3ModNamed, time elapsed: 411200 ns, RESULT:
    [ PASSED ] CASE: testVec3ModNamed (23000 ns)
    TCS: TestCase_testVec3BitwiseOr, time elapsed: 626400 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseOr (49300 ns)
    TCS: TestCase_testVec3BitwiseXor, time elapsed: 1949600 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseXor (909600 ns)
    TCS: TestCase_testVec3ScalarBitwiseAnd, time elapsed: 1416300 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarBitwiseAnd (699800 ns)
    TCS: TestCase_testVec3ShiftRight, time elapsed: 482600 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftRight (116400 ns)
    TCS: TestCase_testVec3Vec1BitBroadcast, time elapsed: 412600 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1BitBroadcast (36400 ns)
    TCS: TestCase_testVec3ShiftRightVec1, time elapsed: 332100 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftRightVec1 (18500 ns)
    TCS: TestCase_testVec3FromVec1, time elapsed: 325500 ns, RESULT:
    [ PASSED ] CASE: testVec3FromVec1 (13800 ns)
    TCS: TestCase_testVec3ScalarBitwiseOr, time elapsed: 556300 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarBitwiseOr (28300 ns)
    TCS: TestCase_testVec3ScalarBitwiseXor, time elapsed: 330700 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarBitwiseXor (19900 ns)
    TCS: TestCase_testVec3Vec1BitOrBroadcast, time elapsed: 422200 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1BitOrBroadcast (35400 ns)
    TCS: TestCase_testVec3Vec1BitXorBroadcast, time elapsed: 361200 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1BitXorBroadcast (21800 ns)
    TCS: TestCase_testVec3ShiftLeftVec1, time elapsed: 606100 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftLeftVec1 (141800 ns)
    TCS: TestCase_testVec3ShiftLeftVec, time elapsed: 398100 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftLeftVec (20600 ns)
    TCS: TestCase_testVec3ShiftRightVec, time elapsed: 645300 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftRightVec (36900 ns)
    TCS: TestCase_testVec3Increment, time elapsed: 439000 ns, RESULT:
    [ PASSED ] CASE: testVec3Increment (39600 ns)
    TCS: TestCase_testVec3Decrement, time elapsed: 531600 ns, RESULT:
    [ PASSED ] CASE: testVec3Decrement (34100 ns)
    TCS: TestCase_testVec3IndexOutOfBoundsAccess, time elapsed: 516100 ns, RESULT:
    [ PASSED ] CASE: testVec3IndexOutOfBoundsAccess (78500 ns)
    TCS: TestCase_testVec3NegativeIndexAccess, time elapsed: 514500 ns, RESULT:
    [ PASSED ] CASE: testVec3NegativeIndexAccess (63100 ns)
    TCS: TestCase_testVec4ScalarInit, time elapsed: 502900 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarInit (28600 ns)
    TCS: TestCase_testVec4ConstInit, time elapsed: 432400 ns, RESULT:
    [ PASSED ] CASE: testVec4ConstInit (21200 ns)
    TCS: TestCase_testVec4Length, time elapsed: 349400 ns, RESULT:
    [ PASSED ] CASE: testVec4Length (13800 ns)
    TCS: TestCase_testVec4Add, time elapsed: 593800 ns, RESULT:
    [ PASSED ] CASE: testVec4Add (247000 ns)
    TCS: TestCase_testVec4ScalarMul, time elapsed: 639200 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarMul (183000 ns)
    TCS: TestCase_testVec4Negate, time elapsed: 780600 ns, RESULT:
    [ PASSED ] CASE: testVec4Negate (207900 ns)
    TCS: TestCase_testVec4IndexAccess, time elapsed: 535300 ns, RESULT:
    [ PASSED ] CASE: testVec4IndexAccess (26400 ns)
    TCS: TestCase_testVec4IndexMutate, time elapsed: 505400 ns, RESULT:
    [ PASSED ] CASE: testVec4IndexMutate (70600 ns)
    TCS: TestCase_testVec4ComponentAt, time elapsed: 591900 ns, RESULT:
    [ PASSED ] CASE: testVec4ComponentAt (27400 ns)
    TCS: TestCase_testVec4Equal, time elapsed: 4629900 ns, RESULT:
    [ PASSED ] CASE: testVec4Equal (3991700 ns)
    TCS: TestCase_testVec4NotEqual, time elapsed: 685800 ns, RESULT:
    [ PASSED ] CASE: testVec4NotEqual (184300 ns)
    TCS: TestCase_testVec4EqualExact, time elapsed: 454500 ns, RESULT:
    [ PASSED ] CASE: testVec4EqualExact (32300 ns)
    TCS: TestCase_testVec4BitwiseAnd, time elapsed: 600500 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseAnd (158400 ns)
    TCS: TestCase_testVec4BitwiseNot, time elapsed: 362700 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseNot (24000 ns)
    TCS: TestCase_testVec4Vec1ArithBroadcast, time elapsed: 614200 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1ArithBroadcast (206100 ns)
    TCS: TestCase_testVec4ShiftLeft, time elapsed: 311100 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftLeft (20000 ns)
    TCS: TestCase_testVec4BoolLogicalAnd, time elapsed: 661400 ns, RESULT:
    [ PASSED ] CASE: testVec4BoolLogicalAnd (164700 ns)
    TCS: TestCase_testVec4Sub, time elapsed: 495000 ns, RESULT:
    [ PASSED ] CASE: testVec4Sub (27900 ns)
    TCS: TestCase_testVec4Div, time elapsed: 380500 ns, RESULT:
    [ PASSED ] CASE: testVec4Div (37000 ns)
    TCS: TestCase_testVec4Mod, time elapsed: 715600 ns, RESULT:
    [ PASSED ] CASE: testVec4Mod (39400 ns)
    TCS: TestCase_testVec4ScalarSub, time elapsed: 446500 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarSub (32600 ns)
    TCS: TestCase_testVec4ScalarDiv, time elapsed: 453500 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarDiv (35500 ns)
    TCS: TestCase_testVec4ScalarMod, time elapsed: 2105200 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarMod (1244000 ns)
    TCS: TestCase_testVec4BoolLogicalOr, time elapsed: 555900 ns, RESULT:
    [ PASSED ] CASE: testVec4BoolLogicalOr (27200 ns)
    TCS: TestCase_testVec4EqualEpsilon, time elapsed: 501900 ns, RESULT:
    [ PASSED ] CASE: testVec4EqualEpsilon (52200 ns)
    TCS: TestCase_testVec4AddNamed, time elapsed: 654400 ns, RESULT:
    [ PASSED ] CASE: testVec4AddNamed (47600 ns)
    TCS: TestCase_testVec4MulNamed, time elapsed: 570500 ns, RESULT:
    [ PASSED ] CASE: testVec4MulNamed (35200 ns)
    TCS: TestCase_testVec4DivNamed, time elapsed: 1446300 ns, RESULT:
    [ PASSED ] CASE: testVec4DivNamed (33300 ns)
    TCS: TestCase_testVec4ModNamed, time elapsed: 1478800 ns, RESULT:
    [ PASSED ] CASE: testVec4ModNamed (52900 ns)
    TCS: TestCase_testVec4BitwiseOr, time elapsed: 1435000 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseOr (135700 ns)
    TCS: TestCase_testVec4BitwiseXor, time elapsed: 1383800 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseXor (175300 ns)
    TCS: TestCase_testVec4ScalarBitwiseAnd, time elapsed: 698500 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarBitwiseAnd (181200 ns)
    TCS: TestCase_testVec4ShiftRight, time elapsed: 858800 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftRight (234500 ns)
    TCS: TestCase_testVec4Vec1BitBroadcast, time elapsed: 1043500 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1BitBroadcast (50200 ns)
    TCS: TestCase_testVec4ShiftRightVec1, time elapsed: 3564800 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftRightVec1 (80400 ns)
    TCS: TestCase_testVec4FromVec1, time elapsed: 594300 ns, RESULT:
    [ PASSED ] CASE: testVec4FromVec1 (34000 ns)
    TCS: TestCase_testVec4ScalarBitwiseOr, time elapsed: 377400 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarBitwiseOr (26300 ns)
    TCS: TestCase_testVec4ScalarBitwiseXor, time elapsed: 492500 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarBitwiseXor (38800 ns)
    TCS: TestCase_testVec4Vec1BitOrBroadcast, time elapsed: 454900 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1BitOrBroadcast (31500 ns)
    TCS: TestCase_testVec4Vec1BitXorBroadcast, time elapsed: 580900 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1BitXorBroadcast (39300 ns)
    TCS: TestCase_testVec4ShiftLeftVec1, time elapsed: 631600 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftLeftVec1 (86000 ns)
    TCS: TestCase_testVec4ShiftLeftVec, time elapsed: 474500 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftLeftVec (35300 ns)
    TCS: TestCase_testVec4ShiftRightVec, time elapsed: 466600 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftRightVec (34800 ns)
    TCS: TestCase_testVec4Increment, time elapsed: 3829500 ns, RESULT:
    [ PASSED ] CASE: testVec4Increment (102000 ns)
    TCS: TestCase_testVec4Decrement, time elapsed: 431900 ns, RESULT:
    [ PASSED ] CASE: testVec4Decrement (31200 ns)
    TCS: TestCase_testVec4IndexOutOfBoundsAccess, time elapsed: 653800 ns, RESULT:
    [ PASSED ] CASE: testVec4IndexOutOfBoundsAccess (92400 ns)
    TCS: TestCase_testVec4NegativeIndexAccess, time elapsed: 516500 ns, RESULT:
    [ PASSED ] CASE: testVec4NegativeIndexAccess (69600 ns)
    TCS: TestCase_testFunctor1Vec1Identity, time elapsed: 516000 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec1Identity (36700 ns)
    TCS: TestCase_testFunctor1Vec1Transform, time elapsed: 400000 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec1Transform (23800 ns)
    TCS: TestCase_testFunctor1Vec2Transform, time elapsed: 1087300 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec2Transform (606200 ns)
    TCS: TestCase_testFunctor2Vec1Add, time elapsed: 402000 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec1Add (18200 ns)
    TCS: TestCase_testFunctor2VecScaVec1Mul, time elapsed: 1189800 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec1Mul (627700 ns)
    TCS: TestCase_testFunctor2VecIntVec1Shift, time elapsed: 374500 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec1Shift (22800 ns)
    TCS: TestCase_testFunctor1Vec3Transform, time elapsed: 359800 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec3Transform (17600 ns)
    TCS: TestCase_testFunctor1Vec4Transform, time elapsed: 423300 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec4Transform (24700 ns)
    TCS: TestCase_testFunctor2Vec2Add, time elapsed: 410800 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec2Add (21800 ns)
    TCS: TestCase_testFunctor2Vec3Add, time elapsed: 437500 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec3Add (27100 ns)
    TCS: TestCase_testFunctor2Vec4Add, time elapsed: 647600 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec4Add (42400 ns)
    TCS: TestCase_testFunctor2VecScaVec2Mul, time elapsed: 596600 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec2Mul (41600 ns)
    TCS: TestCase_testFunctor2VecScaVec3Mul, time elapsed: 469000 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec3Mul (36200 ns)
    TCS: TestCase_testFunctor2VecScaVec4Mul, time elapsed: 463000 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec4Mul (31300 ns)
    TCS: TestCase_testFunctor2VecIntVec2Shift, time elapsed: 707600 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec2Shift (66300 ns)
    TCS: TestCase_testFunctor2VecIntVec3Shift, time elapsed: 677700 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec3Shift (60800 ns)
    TCS: TestCase_testFunctor2VecIntVec4Shift, time elapsed: 640000 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec4Shift (54600 ns)
Summary: TOTAL: 476
    PASSED: 476, SKIPPED: 0, ERROR: 0
    FAILED: 0
--------------------------------------------------------------------------------------------------
Project tests finished, time elapsed: 775565800 ns, RESULT:
TP: glm.*, time elapsed: 775482600 ns, RESULT:
    PASSED:
    TP: glm.detail, time elapsed: 759465700 ns
Summary: TOTAL: 476
    PASSED: 476, SKIPPED: 0, ERROR: 0
    FAILED: 0
--------------------------------------------------------------------------------------------------
cjpm test success
