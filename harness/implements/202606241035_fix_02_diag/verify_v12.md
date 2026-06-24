# 验证报告（v12）

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

--------------------------------------------------------------------------------------------------
TP: glm.detail, time elapsed: 208754700 ns, RESULT:
    TCS: TestCase_testComputeVecAdd1, time elapsed: 1788000 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAdd1 (384000 ns)
    TCS: TestCase_testComputeVecSub2, time elapsed: 503400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSub2 (65500 ns)
    TCS: TestCase_testComputeVecMul3, time elapsed: 422800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMul3 (45600 ns)
    TCS: TestCase_testComputeVecMod1, time elapsed: 377100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMod1 (47300 ns)
    TCS: TestCase_testComputeVecMod4, time elapsed: 360800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMod4 (42000 ns)
    TCS: TestCase_testComputeVecAnd1, time elapsed: 298200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAnd1 (32600 ns)
    TCS: TestCase_testComputeVecAnd3, time elapsed: 295300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAnd3 (30400 ns)
    TCS: TestCase_testComputeVecOr1, time elapsed: 297500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecOr1 (29200 ns)
    TCS: TestCase_testComputeVecOr2, time elapsed: 287800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecOr2 (24500 ns)
    TCS: TestCase_testComputeVecXor1, time elapsed: 320900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecXor1 (32500 ns)
    TCS: TestCase_testComputeVecXor4, time elapsed: 325300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecXor4 (34400 ns)
    TCS: TestCase_testComputeVecShiftLeft1, time elapsed: 324000 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftLeft1 (26100 ns)
    TCS: TestCase_testComputeVecShiftLeft3, time elapsed: 324800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftLeft3 (23000 ns)
    TCS: TestCase_testComputeVecShiftRight1, time elapsed: 300500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftRight1 (25700 ns)
    TCS: TestCase_testComputeVecShiftRight4, time elapsed: 278700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftRight4 (20500 ns)
    TCS: TestCase_testComputeVecEqual1, time elapsed: 253700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual1 (20200 ns)
    TCS: TestCase_testComputeVecNequal4, time elapsed: 246500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecNequal4 (22500 ns)
    TCS: TestCase_testComputeVecBitwiseNot1, time elapsed: 263600 ns, RESULT:
    [ PASSED ] CASE: testComputeVecBitwiseNot1 (30100 ns)
    TCS: TestCase_testComputeVecBitwiseNot3, time elapsed: 251500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecBitwiseNot3 (25600 ns)
    TCS: TestCase_testComputeVecAdd4, time elapsed: 280500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAdd4 (53600 ns)
    TCS: TestCase_testComputeVecSub1, time elapsed: 36491500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSub1 (18900 ns)
    TCS: TestCase_testComputeVecSub3, time elapsed: 462700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSub3 (77300 ns)
    TCS: TestCase_testComputeVecMul1, time elapsed: 265000 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMul1 (24700 ns)
    TCS: TestCase_testComputeVecMul2, time elapsed: 256700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMul2 (19900 ns)
    TCS: TestCase_testComputeVecDiv1, time elapsed: 241100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecDiv1 (19200 ns)
    TCS: TestCase_testComputeVecDiv2, time elapsed: 243900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecDiv2 (18000 ns)
    TCS: TestCase_testComputeVecDiv4, time elapsed: 260000 ns, RESULT:
    [ PASSED ] CASE: testComputeVecDiv4 (20800 ns)
    TCS: TestCase_testComputeVecEqual2, time elapsed: 252500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual2 (15700 ns)
    TCS: TestCase_testComputeVecEqual3, time elapsed: 277100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual3 (27000 ns)
    TCS: TestCase_testComputeVecEqual4, time elapsed: 272300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual4 (19200 ns)
    TCS: TestCase_testComputeVecNequal1, time elapsed: 228300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecNequal1 (12300 ns)
    TCS: TestCase_testComputeVecNequal2, time elapsed: 272000 ns, RESULT:
    [ PASSED ] CASE: testComputeVecNequal2 (12900 ns)
    TCS: TestCase_testComputeVecBitwiseNot4, time elapsed: 287200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecBitwiseNot4 (38800 ns)
    TCS: TestCase_testComputeVecAddFloat32, time elapsed: 292000 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAddFloat32 (42800 ns)
    TCS: TestCase_testComputeVecAddFloat32Vec3, time elapsed: 264000 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAddFloat32Vec3 (27500 ns)
    TCS: TestCase_testComputeVecSubFloat32, time elapsed: 245600 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSubFloat32 (24800 ns)
    TCS: TestCase_testComputeVecSubFloat32Vec4, time elapsed: 305700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSubFloat32Vec4 (24500 ns)
    TCS: TestCase_testComputeEqualInt32Equal, time elapsed: 240300 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt32Equal (21500 ns)
    TCS: TestCase_testComputeEqualInt32NotEqual, time elapsed: 226200 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt32NotEqual (19700 ns)
    TCS: TestCase_testComputeEqualFloat32Equal, time elapsed: 228400 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32Equal (17200 ns)
    TCS: TestCase_testComputeEqualFloat32NotEqual, time elapsed: 218500 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32NotEqual (10800 ns)
    TCS: TestCase_testComputeEqualFloat64Equal, time elapsed: 218700 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64Equal (9800 ns)
    TCS: TestCase_testComputeEqualFloat64NotEqual, time elapsed: 208300 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64NotEqual (8300 ns)
    TCS: TestCase_testComputeEqualBoolEqual, time elapsed: 251700 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualBoolEqual (17200 ns)
    TCS: TestCase_testComputeEqualBoolNotEqual, time elapsed: 222700 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualBoolNotEqual (10300 ns)
    TCS: TestCase_testComputeEqualNumericInt32, time elapsed: 198100 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericInt32 (9900 ns)
    TCS: TestCase_testComputeEqualNumericFloat32, time elapsed: 229300 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32 (36000 ns)
    TCS: TestCase_testComputeEqualNumericFloat32Epsilon, time elapsed: 200300 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32Epsilon (10100 ns)
    TCS: TestCase_testComputeEqualNumericFloat64, time elapsed: 202000 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64 (12600 ns)
    TCS: TestCase_testComputeEqualInt64Equal, time elapsed: 212600 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt64Equal (10800 ns)
    TCS: TestCase_testComputeEqualInt64NotEqual, time elapsed: 229700 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt64NotEqual (10100 ns)
    TCS: TestCase_testComputeEqualFloat32Nan, time elapsed: 203900 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32Nan (9400 ns)
    TCS: TestCase_testComputeEqualFloat64Nan, time elapsed: 196700 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64Nan (7900 ns)
    TCS: TestCase_testComputeEqualFloat32SignedZero, time elapsed: 195000 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32SignedZero (7700 ns)
    TCS: TestCase_testComputeEqualFloat64SignedZero, time elapsed: 201300 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64SignedZero (7300 ns)
    TCS: TestCase_testComputeEqualNumericFloat32NotEqual, time elapsed: 194700 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32NotEqual (10700 ns)
    TCS: TestCase_testComputeEqualNumericFloat32BeyondEpsilon, time elapsed: 192600 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32BeyondEpsilon (9100 ns)
    TCS: TestCase_testComputeEqualNumericFloat64NotEqual, time elapsed: 195300 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64NotEqual (11900 ns)
    TCS: TestCase_testComputeEqualNumericFloat64Epsilon, time elapsed: 188100 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64Epsilon (8700 ns)
    TCS: TestCase_testComputeEqualNumericFloat64BeyondEpsilon, time elapsed: 187900 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64BeyondEpsilon (13300 ns)
    TCS: TestCase_testComputeEqualNumericInt64, time elapsed: 189200 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericInt64 (10400 ns)
    TCS: TestCase_testPackedHighpImplementsQualifier, time elapsed: 180600 ns, RESULT:
    [ PASSED ] CASE: testPackedHighpImplementsQualifier (8100 ns)
    TCS: TestCase_testPackedMediumpImplementsQualifier, time elapsed: 177500 ns, RESULT:
    [ PASSED ] CASE: testPackedMediumpImplementsQualifier (8300 ns)
    TCS: TestCase_testPackedLowpImplementsQualifier, time elapsed: 292600 ns, RESULT:
    [ PASSED ] CASE: testPackedLowpImplementsQualifier (13300 ns)
    TCS: TestCase_testDefaultpIsPackedHighp, time elapsed: 335500 ns, RESULT:
    [ PASSED ] CASE: testDefaultpIsPackedHighp (11500 ns)
    TCS: TestCase_testScalarAddVec1, time elapsed: 233000 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec1 (28600 ns)
    TCS: TestCase_testScalarAddVec2, time elapsed: 327300 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec2 (53700 ns)
    TCS: TestCase_testScalarAddVec3, time elapsed: 282700 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec3 (32800 ns)
    TCS: TestCase_testScalarAddVec4, time elapsed: 277700 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec4 (26500 ns)
    TCS: TestCase_testScalarSubVec1, time elapsed: 334000 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1 (38200 ns)
    TCS: TestCase_testScalarMulVec1, time elapsed: 247800 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1 (29500 ns)
    TCS: TestCase_testScalarDivVec1, time elapsed: 256300 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1 (21300 ns)
    TCS: TestCase_testScalarModVec1, time elapsed: 295800 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1 (22100 ns)
    TCS: TestCase_testScalarMulVec2, time elapsed: 338900 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2 (31300 ns)
    TCS: TestCase_testScalarSubVec2, time elapsed: 342300 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2 (21000 ns)
    TCS: TestCase_testScalarSubVec3, time elapsed: 427800 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3 (35600 ns)
    TCS: TestCase_testScalarSubVec4, time elapsed: 240000 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4 (22000 ns)
    TCS: TestCase_testScalarMulVec3, time elapsed: 319000 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3 (22200 ns)
    TCS: TestCase_testScalarMulVec4, time elapsed: 330500 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4 (24000 ns)
    TCS: TestCase_testScalarDivVec2, time elapsed: 231100 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2 (21200 ns)
    TCS: TestCase_testScalarDivVec3, time elapsed: 201400 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3 (9100 ns)
    TCS: TestCase_testScalarDivVec4, time elapsed: 216400 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4 (20500 ns)
    TCS: TestCase_testScalarModVec2, time elapsed: 197600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2 (9400 ns)
    TCS: TestCase_testScalarModVec3, time elapsed: 208000 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3 (14800 ns)
    TCS: TestCase_testScalarModVec4, time elapsed: 320300 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4 (22900 ns)
    TCS: TestCase_testScalarModVec1Float32, time elapsed: 316400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Float32 (32700 ns)
    TCS: TestCase_testScalarModVec2Float32, time elapsed: 285600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32 (9700 ns)
    TCS: TestCase_testScalarModVec3Float32, time elapsed: 268400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Float32 (23900 ns)
    TCS: TestCase_testScalarModVec4Float32, time elapsed: 211600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Float32 (14600 ns)
    TCS: TestCase_testScalarModVec1Float64, time elapsed: 205100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Float64 (15700 ns)
    TCS: TestCase_testScalarModVec2Float64, time elapsed: 195400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float64 (8300 ns)
    TCS: TestCase_testScalarModVec3Float64, time elapsed: 197600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Float64 (9000 ns)
    TCS: TestCase_testScalarModVec4Float64, time elapsed: 204400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Float64 (13600 ns)
    TCS: TestCase_testScalarModVec1Float16, time elapsed: 207000 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Float16 (19600 ns)
    TCS: TestCase_testScalarModVec2Float16, time elapsed: 195900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float16 (9800 ns)
    TCS: TestCase_testScalarModVec3Float16, time elapsed: 190600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Float16 (8800 ns)
    TCS: TestCase_testScalarModVec4Float16, time elapsed: 205500 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Float16 (9800 ns)
    TCS: TestCase_testScalarSubVec2PackedMediump, time elapsed: 213200 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2PackedMediump (16500 ns)
    TCS: TestCase_testScalarSubVec2PackedLowp, time elapsed: 211700 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2PackedLowp (14000 ns)
    TCS: TestCase_testScalarMulVec2PackedMediump, time elapsed: 213100 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2PackedMediump (15800 ns)
    TCS: TestCase_testScalarMulVec2PackedLowp, time elapsed: 205900 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2PackedLowp (14600 ns)
    TCS: TestCase_testScalarDivVec2PackedMediump, time elapsed: 280700 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2PackedMediump (21400 ns)
    TCS: TestCase_testScalarDivVec2PackedLowp, time elapsed: 239200 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2PackedLowp (13500 ns)
    TCS: TestCase_testScalarModVec2PackedMediump, time elapsed: 214300 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2PackedMediump (10300 ns)
    TCS: TestCase_testScalarModVec2PackedLowp, time elapsed: 205100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2PackedLowp (9400 ns)
    TCS: TestCase_testScalarModVec2Float32PackedMediump, time elapsed: 208900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32PackedMediump (11600 ns)
    TCS: TestCase_testScalarModVec2Float32PackedLowp, time elapsed: 252900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32PackedLowp (14600 ns)
    TCS: TestCase_testScalarModVec2Float32NegativeDividend, time elapsed: 214800 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32NegativeDividend (10700 ns)
    TCS: TestCase_testScalarModVec2Float32NegativeDivisor, time elapsed: 309000 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32NegativeDivisor (24700 ns)
    TCS: TestCase_testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents, time elapsed: 473600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents (200200 ns)
    TCS: TestCase_testScalarAddVec1Float32, time elapsed: 320200 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec1Float32 (16300 ns)
    TCS: TestCase_testScalarAddVec2Float32, time elapsed: 258400 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec2Float32 (23800 ns)
    TCS: TestCase_testScalarAddVec3Float32, time elapsed: 198100 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec3Float32 (9700 ns)
    TCS: TestCase_testScalarAddVec4Float32, time elapsed: 213900 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec4Float32 (11800 ns)
    TCS: TestCase_testScalarSubVec1Float32, time elapsed: 239000 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1Float32 (23200 ns)
    TCS: TestCase_testScalarSubVec2Float32, time elapsed: 230900 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2Float32 (11200 ns)
    TCS: TestCase_testScalarSubVec3Float32, time elapsed: 204600 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3Float32 (10100 ns)
    TCS: TestCase_testScalarSubVec4Float32, time elapsed: 457700 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4Float32 (54200 ns)
    TCS: TestCase_testScalarMulVec1Float32, time elapsed: 487800 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1Float32 (19700 ns)
    TCS: TestCase_testScalarMulVec2Float32, time elapsed: 377600 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2Float32 (21100 ns)
    TCS: TestCase_testScalarMulVec3Float32, time elapsed: 332000 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3Float32 (19200 ns)
    TCS: TestCase_testScalarMulVec4Float32, time elapsed: 248900 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4Float32 (12500 ns)
    TCS: TestCase_testScalarDivVec1Float32, time elapsed: 206100 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1Float32 (10500 ns)
    TCS: TestCase_testScalarDivVec2Float32, time elapsed: 201500 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2Float32 (8600 ns)
    TCS: TestCase_testScalarDivVec3Float32, time elapsed: 229000 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3Float32 (16600 ns)
    TCS: TestCase_testScalarDivVec4Float32, time elapsed: 221500 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4Float32 (9900 ns)
    TCS: TestCase_testScalarAddVec1Int32, time elapsed: 247900 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec1Int32 (27900 ns)
    TCS: TestCase_testScalarAddVec2Int32, time elapsed: 209800 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec2Int32 (10700 ns)
    TCS: TestCase_testScalarAddVec3Int32, time elapsed: 239000 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec3Int32 (34200 ns)
    TCS: TestCase_testScalarAddVec4Int32, time elapsed: 209300 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec4Int32 (16900 ns)
    TCS: TestCase_testScalarSubVec1Int32, time elapsed: 210300 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1Int32 (19300 ns)
    TCS: TestCase_testScalarSubVec2Int32, time elapsed: 196600 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2Int32 (9400 ns)
    TCS: TestCase_testScalarSubVec3Int32, time elapsed: 197600 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3Int32 (9400 ns)
    TCS: TestCase_testScalarSubVec4Int32, time elapsed: 195800 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4Int32 (9600 ns)
    TCS: TestCase_testScalarMulVec1Int32, time elapsed: 192900 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1Int32 (7600 ns)
    TCS: TestCase_testScalarMulVec2Int32, time elapsed: 220200 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2Int32 (14100 ns)
    TCS: TestCase_testScalarMulVec3Int32, time elapsed: 196200 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3Int32 (9500 ns)
    TCS: TestCase_testScalarMulVec4Int32, time elapsed: 200900 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4Int32 (8500 ns)
    TCS: TestCase_testScalarDivVec1Int32, time elapsed: 201500 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1Int32 (8700 ns)
    TCS: TestCase_testScalarDivVec2Int32, time elapsed: 206300 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2Int32 (9200 ns)
    TCS: TestCase_testScalarDivVec3Int32, time elapsed: 193800 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3Int32 (8800 ns)
    TCS: TestCase_testScalarDivVec4Int32, time elapsed: 206500 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4Int32 (20500 ns)
    TCS: TestCase_testScalarModVec1Int32, time elapsed: 314500 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Int32 (14300 ns)
    TCS: TestCase_testScalarModVec2Int32, time elapsed: 204200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Int32 (8400 ns)
    TCS: TestCase_testScalarModVec3Int32, time elapsed: 221500 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Int32 (9000 ns)
    TCS: TestCase_testScalarModVec4Int32, time elapsed: 230400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Int32 (12400 ns)
    TCS: TestCase_testScalarSubVec1PackedMediump, time elapsed: 231200 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1PackedMediump (27000 ns)
    TCS: TestCase_testScalarSubVec1PackedLowp, time elapsed: 222500 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1PackedLowp (11500 ns)
    TCS: TestCase_testScalarSubVec3PackedMediump, time elapsed: 202500 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3PackedMediump (10900 ns)
    TCS: TestCase_testScalarSubVec3PackedLowp, time elapsed: 188700 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3PackedLowp (10000 ns)
    TCS: TestCase_testScalarSubVec4PackedMediump, time elapsed: 207400 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4PackedMediump (18500 ns)
    TCS: TestCase_testScalarSubVec4PackedLowp, time elapsed: 290000 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4PackedLowp (13500 ns)
    TCS: TestCase_testScalarMulVec1PackedMediump, time elapsed: 202100 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1PackedMediump (8900 ns)
    TCS: TestCase_testScalarMulVec1PackedLowp, time elapsed: 511200 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1PackedLowp (29100 ns)
    TCS: TestCase_testScalarMulVec3PackedMediump, time elapsed: 422300 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3PackedMediump (25100 ns)
    TCS: TestCase_testScalarMulVec3PackedLowp, time elapsed: 300100 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3PackedLowp (17900 ns)
    TCS: TestCase_testScalarMulVec4PackedMediump, time elapsed: 351800 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4PackedMediump (21600 ns)
    TCS: TestCase_testScalarMulVec4PackedLowp, time elapsed: 357600 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4PackedLowp (13900 ns)
    TCS: TestCase_testScalarDivVec1PackedMediump, time elapsed: 218000 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1PackedMediump (12600 ns)
    TCS: TestCase_testScalarDivVec1PackedLowp, time elapsed: 191100 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1PackedLowp (10200 ns)
    TCS: TestCase_testScalarDivVec3PackedMediump, time elapsed: 191200 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3PackedMediump (10900 ns)
    TCS: TestCase_testScalarDivVec3PackedLowp, time elapsed: 194500 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3PackedLowp (11100 ns)
    TCS: TestCase_testScalarDivVec4PackedMediump, time elapsed: 277100 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4PackedMediump (23200 ns)
    TCS: TestCase_testScalarDivVec4PackedLowp, time elapsed: 198800 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4PackedLowp (11000 ns)
    TCS: TestCase_testScalarModVec1PackedMediump, time elapsed: 208700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1PackedMediump (11100 ns)
    TCS: TestCase_testScalarModVec1PackedLowp, time elapsed: 217900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1PackedLowp (9900 ns)
    TCS: TestCase_testScalarModVec3PackedMediump, time elapsed: 215800 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3PackedMediump (11100 ns)
    TCS: TestCase_testScalarModVec3PackedLowp, time elapsed: 211100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3PackedLowp (9400 ns)
    TCS: TestCase_testScalarModVec4PackedMediump, time elapsed: 200300 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4PackedMediump (10100 ns)
    TCS: TestCase_testScalarModVec4PackedLowp, time elapsed: 230400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4PackedLowp (10400 ns)
    TCS: TestCase_testScalarDivZeroVec1, time elapsed: 214400 ns, RESULT:
    [ PASSED ] CASE: testScalarDivZeroVec1 (27100 ns)
    TCS: TestCase_testScalarAddNegVec1, time elapsed: 207200 ns, RESULT:
    [ PASSED ] CASE: testScalarAddNegVec1 (13200 ns)
    TCS: TestCase_testScalarAddNegVec2, time elapsed: 194300 ns, RESULT:
    [ PASSED ] CASE: testScalarAddNegVec2 (8500 ns)
    TCS: TestCase_testScalarMulOverflowVec1, time elapsed: 208900 ns, RESULT:
    [ PASSED ] CASE: testScalarMulOverflowVec1 (12900 ns)
    TCS: TestCase_testScalarSubNegVec1, time elapsed: 204800 ns, RESULT:
    [ PASSED ] CASE: testScalarSubNegVec1 (9600 ns)
    TCS: TestCase_testVersionMajor, time elapsed: 204600 ns, RESULT:
    [ PASSED ] CASE: testVersionMajor (8600 ns)
    TCS: TestCase_testVersionMinor, time elapsed: 259300 ns, RESULT:
    [ PASSED ] CASE: testVersionMinor (8200 ns)
    TCS: TestCase_testVersionPatch, time elapsed: 195600 ns, RESULT:
    [ PASSED ] CASE: testVersionPatch (9000 ns)
    TCS: TestCase_testVersionEncoded, time elapsed: 217300 ns, RESULT:
    [ PASSED ] CASE: testVersionEncoded (16700 ns)
    TCS: TestCase_testConfigSimd, time elapsed: 216000 ns, RESULT:
    [ PASSED ] CASE: testConfigSimd (20000 ns)
    TCS: TestCase_testConfigAlignedGentypes, time elapsed: 197600 ns, RESULT:
    [ PASSED ] CASE: testConfigAlignedGentypes (8400 ns)
    TCS: TestCase_testConfigClipControl, time elapsed: 192600 ns, RESULT:
    [ PASSED ] CASE: testConfigClipControl (8600 ns)
    TCS: TestCase_testConstNegationSimd, time elapsed: 274800 ns, RESULT:
    [ PASSED ] CASE: testConstNegationSimd (8600 ns)
    TCS: TestCase_testConstNegationAligned, time elapsed: 203900 ns, RESULT:
    [ PASSED ] CASE: testConstNegationAligned (9000 ns)
    TCS: TestCase_testConstNegationClip, time elapsed: 192200 ns, RESULT:
    [ PASSED ] CASE: testConstNegationClip (7300 ns)
    TCS: TestCase_testConstInt64Usage, time elapsed: 194600 ns, RESULT:
    [ PASSED ] CASE: testConstInt64Usage (8900 ns)
    TCS: TestCase_testConstBoolUsage, time elapsed: 191800 ns, RESULT:
    [ PASSED ] CASE: testConstBoolUsage (8100 ns)
    TCS: TestCase_testVersionEncodingConsistency, time elapsed: 185000 ns, RESULT:
    [ PASSED ] CASE: testVersionEncodingConsistency (7600 ns)
    TCS: TestCase_testAssertPasses, time elapsed: 220000 ns, RESULT:
    [ PASSED ] CASE: testAssertPasses (30700 ns)
    TCS: TestCase_testAssertFails, time elapsed: 261900 ns, RESULT:
    [ PASSED ] CASE: testAssertFails (71900 ns)
    TCS: TestCase_testAssertWithCustomMessage, time elapsed: 253600 ns, RESULT:
    [ PASSED ] CASE: testAssertWithCustomMessage (48600 ns)
    TCS: TestCase_testNumericLimitsFloat32Epsilon, time elapsed: 307300 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsFloat32Epsilon (18700 ns)
    TCS: TestCase_testNumericLimitsFloat64Epsilon, time elapsed: 282900 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsFloat64Epsilon (13800 ns)
    TCS: TestCase_testIsIec559OfFloat32, time elapsed: 313900 ns, RESULT:
    [ PASSED ] CASE: testIsIec559OfFloat32 (13800 ns)
    TCS: TestCase_testIsIec559OfFloat64, time elapsed: 297200 ns, RESULT:
    [ PASSED ] CASE: testIsIec559OfFloat64 (10000 ns)
    TCS: TestCase_testIsIec559OfInt64, time elapsed: 218600 ns, RESULT:
    [ PASSED ] CASE: testIsIec559OfInt64 (22500 ns)
    TCS: TestCase_testEpsilonOfFloat32, time elapsed: 198100 ns, RESULT:
    [ PASSED ] CASE: testEpsilonOfFloat32 (13200 ns)
    TCS: TestCase_testEpsilonOfFloat64, time elapsed: 327700 ns, RESULT:
    [ PASSED ] CASE: testEpsilonOfFloat64 (19800 ns)
    TCS: TestCase_testNumericLimitsInt64Epsilon, time elapsed: 241200 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt64Epsilon (14100 ns)
    TCS: TestCase_testNumericLimitsInt32Epsilon, time elapsed: 207500 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt32Epsilon (12400 ns)
    TCS: TestCase_testNumericLimitsInt16Epsilon, time elapsed: 220000 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt16Epsilon (15000 ns)
    TCS: TestCase_testNumericLimitsInt8Epsilon, time elapsed: 301600 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt8Epsilon (34500 ns)
    TCS: TestCase_testCastVec1ToVec1IntToFloat, time elapsed: 305100 ns, RESULT:
    [ PASSED ] CASE: testCastVec1ToVec1IntToFloat (39100 ns)
    TCS: TestCase_testCastVec2ToVec1TakesOnlyX, time elapsed: 296800 ns, RESULT:
    [ PASSED ] CASE: testCastVec2ToVec1TakesOnlyX (33700 ns)
    TCS: TestCase_testCastVec3ToVec1TakesOnlyX, time elapsed: 362300 ns, RESULT:
    [ PASSED ] CASE: testCastVec3ToVec1TakesOnlyX (26800 ns)
    TCS: TestCase_testCastVec4ToVec1TakesOnlyX, time elapsed: 387400 ns, RESULT:
    [ PASSED ] CASE: testCastVec4ToVec1TakesOnlyX (35500 ns)
    TCS: TestCase_testCastSameTypeIdentity, time elapsed: 543900 ns, RESULT:
    [ PASSED ] CASE: testCastSameTypeIdentity (57700 ns)
    TCS: TestCase_testCastInt32ToInt64, time elapsed: 365900 ns, RESULT:
    [ PASSED ] CASE: testCastInt32ToInt64 (20600 ns)
    TCS: TestCase_testCastFloatToIntTruncation, time elapsed: 339200 ns, RESULT:
    [ PASSED ] CASE: testCastFloatToIntTruncation (15900 ns)
    TCS: TestCase_testCastCrossQualifierPackedHighpToDefaultp, time elapsed: 293600 ns, RESULT:
    [ PASSED ] CASE: testCastCrossQualifierPackedHighpToDefaultp (12300 ns)
    TCS: TestCase_testCastCrossQualifierDefaultpToPackedHighp, time elapsed: 289500 ns, RESULT:
    [ PASSED ] CASE: testCastCrossQualifierDefaultpToPackedHighp (23200 ns)
    TCS: TestCase_testCastVec2CrossQualifierCrossType, time elapsed: 294400 ns, RESULT:
    [ PASSED ] CASE: testCastVec2CrossQualifierCrossType (15000 ns)
    TCS: TestCase_testCastVec3CrossQualifier, time elapsed: 223900 ns, RESULT:
    [ PASSED ] CASE: testCastVec3CrossQualifier (10300 ns)
    TCS: TestCase_testCastVec4CrossQualifier, time elapsed: 222600 ns, RESULT:
    [ PASSED ] CASE: testCastVec4CrossQualifier (9700 ns)
    TCS: TestCase_testCastVec1DoesNotModifySource, time elapsed: 191900 ns, RESULT:
    [ PASSED ] CASE: testCastVec1DoesNotModifySource (6500 ns)
    TCS: TestCase_testCastVec2Vec1ToVec2IntToFloat, time elapsed: 190800 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec1ToVec2IntToFloat (14800 ns)
    TCS: TestCase_testCastVec2Vec2ToVec2Identity, time elapsed: 212700 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec2ToVec2Identity (23700 ns)
    TCS: TestCase_testCastVec2Vec3ToVec2TakesOnlyXY, time elapsed: 210100 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec3ToVec2TakesOnlyXY (7800 ns)
    TCS: TestCase_testCastVec2Vec4ToVec2TakesOnlyXY, time elapsed: 186300 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec4ToVec2TakesOnlyXY (6700 ns)
    TCS: TestCase_testCastVec2SameTypeIdentity, time elapsed: 190600 ns, RESULT:
    [ PASSED ] CASE: testCastVec2SameTypeIdentity (6700 ns)
    TCS: TestCase_testCastVec2Int32ToInt64, time elapsed: 197100 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Int32ToInt64 (7800 ns)
    TCS: TestCase_testCastVec2FloatToIntTruncation, time elapsed: 188700 ns, RESULT:
    [ PASSED ] CASE: testCastVec2FloatToIntTruncation (7800 ns)
    TCS: TestCase_testCastVec2CrossQualifierPackedHighpToDefaultp, time elapsed: 189600 ns, RESULT:
    [ PASSED ] CASE: testCastVec2CrossQualifierPackedHighpToDefaultp (6300 ns)
    TCS: TestCase_testCastVec2DoesNotModifySource, time elapsed: 184000 ns, RESULT:
    [ PASSED ] CASE: testCastVec2DoesNotModifySource (6700 ns)
    TCS: TestCase_testCastVec2Vec1ToVec2SameValueBothComponents, time elapsed: 202800 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec1ToVec2SameValueBothComponents (7200 ns)
    TCS: TestCase_testCastVec3Vec1ToVec3IntToFloat, time elapsed: 210300 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec1ToVec3IntToFloat (17700 ns)
    TCS: TestCase_testCastVec3Vec2ToVec3ExtendY, time elapsed: 202700 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec2ToVec3ExtendY (16800 ns)
    TCS: TestCase_testCastVec3Vec3ToVec3Identity, time elapsed: 179100 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec3ToVec3Identity (6200 ns)
    TCS: TestCase_testCastVec3Vec4ToVec3TakesOnlyXYZ, time elapsed: 190900 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec4ToVec3TakesOnlyXYZ (11800 ns)
    TCS: TestCase_testCastVec3SameTypeIdentity, time elapsed: 181600 ns, RESULT:
    [ PASSED ] CASE: testCastVec3SameTypeIdentity (8700 ns)
    TCS: TestCase_testCastVec3Int32ToInt64, time elapsed: 181400 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Int32ToInt64 (7600 ns)
    TCS: TestCase_testCastVec3FloatToIntTruncation, time elapsed: 189600 ns, RESULT:
    [ PASSED ] CASE: testCastVec3FloatToIntTruncation (8600 ns)
    TCS: TestCase_testCastVec3CrossQualifierPackedHighpToDefaultp, time elapsed: 177400 ns, RESULT:
    [ PASSED ] CASE: testCastVec3CrossQualifierPackedHighpToDefaultp (5700 ns)
    TCS: TestCase_testCastVec3DoesNotModifySource, time elapsed: 177400 ns, RESULT:
    [ PASSED ] CASE: testCastVec3DoesNotModifySource (5800 ns)
    TCS: TestCase_testCastVec3Vec1ToVec3SameValueAllComponents, time elapsed: 173800 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec1ToVec3SameValueAllComponents (6200 ns)
    TCS: TestCase_testCastVec4Vec1ToVec4IntToFloat, time elapsed: 176800 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec1ToVec4IntToFloat (7600 ns)
    TCS: TestCase_testCastVec4Vec2ToVec4ExtendY, time elapsed: 187100 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec2ToVec4ExtendY (15300 ns)
    TCS: TestCase_testCastVec4Vec3ToVec4ExtendZ, time elapsed: 222100 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec3ToVec4ExtendZ (11000 ns)
    TCS: TestCase_testCastVec4Vec4ToVec4Identity, time elapsed: 185500 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec4ToVec4Identity (10900 ns)
    TCS: TestCase_testCastVec4SameTypeIdentity, time elapsed: 179300 ns, RESULT:
    [ PASSED ] CASE: testCastVec4SameTypeIdentity (6100 ns)
    TCS: TestCase_testCastVec4Int32ToInt64, time elapsed: 240900 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Int32ToInt64 (9700 ns)
    TCS: TestCase_testCastVec4FloatToIntTruncation, time elapsed: 339400 ns, RESULT:
    [ PASSED ] CASE: testCastVec4FloatToIntTruncation (16100 ns)
    TCS: TestCase_testCastVec4CrossQualifierPackedHighpToDefaultp, time elapsed: 188400 ns, RESULT:
    [ PASSED ] CASE: testCastVec4CrossQualifierPackedHighpToDefaultp (7800 ns)
    TCS: TestCase_testCastVec4DoesNotModifySource, time elapsed: 193100 ns, RESULT:
    [ PASSED ] CASE: testCastVec4DoesNotModifySource (7200 ns)
    TCS: TestCase_testCastVec4Vec1ToVec4SameValueAllComponents, time elapsed: 186900 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec1ToVec4SameValueAllComponents (7700 ns)
    TCS: TestCase_testFromBoolVec1, time elapsed: 174500 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec1 (6100 ns)
    TCS: TestCase_testFromBoolVec1False, time elapsed: 187600 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec1False (6500 ns)
    TCS: TestCase_testFromBoolVec2, time elapsed: 279800 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec2 (19100 ns)
    TCS: TestCase_testFromBoolVec3, time elapsed: 201000 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec3 (9400 ns)
    TCS: TestCase_testFromBoolVec4, time elapsed: 196300 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec4 (9200 ns)
    TCS: TestCase_testFromBoolVecQ2Vec1, time elapsed: 173800 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec1 (6900 ns)
    TCS: TestCase_testFromBoolVecQ2Vec2, time elapsed: 813800 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec2 (12500 ns)
    TCS: TestCase_testFromBoolVecQ2Vec3, time elapsed: 993000 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec3 (59700 ns)
    TCS: TestCase_testFromBoolVecQ2Vec4, time elapsed: 169600 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec4 (6300 ns)
    TCS: TestCase_testFromBoolVec3AllFalse, time elapsed: 165600 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec3AllFalse (5600 ns)
    TCS: TestCase_testFromBoolVec4AllFalse, time elapsed: 162900 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec4AllFalse (5600 ns)
    TCS: TestCase_testFromBoolVecQ2Vec3AllFalse, time elapsed: 164500 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec3AllFalse (6000 ns)
    TCS: TestCase_testFromBoolVecQ2Vec4AllFalse, time elapsed: 165100 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec4AllFalse (5300 ns)
    TCS: TestCase_testFromBoolVecFloat32, time elapsed: 173100 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecFloat32 (12700 ns)
    TCS: TestCase_testFromBoolVecFloat64, time elapsed: 170700 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecFloat64 (7400 ns)
    TCS: TestCase_testFromBoolVecInt32, time elapsed: 177400 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecInt32 (8200 ns)
    TCS: TestCase_testFromBoolVecQ2PackedMediump, time elapsed: 177100 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2PackedMediump (6600 ns)
    TCS: TestCase_testFromBoolVecQ2PackedLowp, time elapsed: 240400 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2PackedLowp (6200 ns)
    TCS: TestCase_testVec1ConstInit, time elapsed: 205500 ns, RESULT:
    [ PASSED ] CASE: testVec1ConstInit (26600 ns)
    TCS: TestCase_testVec1Length, time elapsed: 190800 ns, RESULT:
    [ PASSED ] CASE: testVec1Length (6300 ns)
    TCS: TestCase_testVec1IndexAccess, time elapsed: 202500 ns, RESULT:
    [ PASSED ] CASE: testVec1IndexAccess (13300 ns)
    TCS: TestCase_testVec1IndexMutate, time elapsed: 182400 ns, RESULT:
    [ PASSED ] CASE: testVec1IndexMutate (6000 ns)
    TCS: TestCase_testVec1ComponentAt, time elapsed: 202300 ns, RESULT:
    [ PASSED ] CASE: testVec1ComponentAt (6600 ns)
    TCS: TestCase_testVec1Add, time elapsed: 213300 ns, RESULT:
    [ PASSED ] CASE: testVec1Add (18100 ns)
    TCS: TestCase_testVec1Sub, time elapsed: 210600 ns, RESULT:
    [ PASSED ] CASE: testVec1Sub (30900 ns)
    TCS: TestCase_testVec1Mul, time elapsed: 215000 ns, RESULT:
    [ PASSED ] CASE: testVec1Mul (17200 ns)
    TCS: TestCase_testVec1Div, time elapsed: 208600 ns, RESULT:
    [ PASSED ] CASE: testVec1Div (16700 ns)
    TCS: TestCase_testVec1Mod, time elapsed: 211700 ns, RESULT:
    [ PASSED ] CASE: testVec1Mod (19300 ns)
    TCS: TestCase_testVec1ScalarAdd, time elapsed: 205400 ns, RESULT:
    [ PASSED ] CASE: testVec1ScalarAdd (13500 ns)
    TCS: TestCase_testVec1Negate, time elapsed: 201800 ns, RESULT:
    [ PASSED ] CASE: testVec1Negate (6500 ns)
    TCS: TestCase_testVec1AddNamed, time elapsed: 191000 ns, RESULT:
    [ PASSED ] CASE: testVec1AddNamed (6000 ns)
    TCS: TestCase_testVec1SubNamed, time elapsed: 242900 ns, RESULT:
    [ PASSED ] CASE: testVec1SubNamed (19800 ns)
    TCS: TestCase_testVec1MulNamed, time elapsed: 189500 ns, RESULT:
    [ PASSED ] CASE: testVec1MulNamed (6300 ns)
    TCS: TestCase_testVec1Equal, time elapsed: 248400 ns, RESULT:
    [ PASSED ] CASE: testVec1Equal (17100 ns)
    TCS: TestCase_testVec1NotEqual, time elapsed: 270200 ns, RESULT:
    [ PASSED ] CASE: testVec1NotEqual (8300 ns)
    TCS: TestCase_testVec1EqualExact, time elapsed: 257000 ns, RESULT:
    [ PASSED ] CASE: testVec1EqualExact (21900 ns)
    TCS: TestCase_testVec1BitwiseAnd, time elapsed: 209000 ns, RESULT:
    [ PASSED ] CASE: testVec1BitwiseAnd (13600 ns)
    TCS: TestCase_testVec1BitwiseOr, time elapsed: 202900 ns, RESULT:
    [ PASSED ] CASE: testVec1BitwiseOr (19700 ns)
    TCS: TestCase_testVec1BitwiseXor, time elapsed: 281800 ns, RESULT:
    [ PASSED ] CASE: testVec1BitwiseXor (17000 ns)
    TCS: TestCase_testVec1ShiftLeft, time elapsed: 341800 ns, RESULT:
    [ PASSED ] CASE: testVec1ShiftLeft (17900 ns)
    TCS: TestCase_testVec1ShiftRight, time elapsed: 291100 ns, RESULT:
    [ PASSED ] CASE: testVec1ShiftRight (46100 ns)
    TCS: TestCase_testVec1BitwiseNot, time elapsed: 438800 ns, RESULT:
    [ PASSED ] CASE: testVec1BitwiseNot (18400 ns)
    TCS: TestCase_testVec1BoolLogicalAnd, time elapsed: 242500 ns, RESULT:
    [ PASSED ] CASE: testVec1BoolLogicalAnd (25100 ns)
    TCS: TestCase_testVec1BoolLogicalOr, time elapsed: 282200 ns, RESULT:
    [ PASSED ] CASE: testVec1BoolLogicalOr (15500 ns)
    TCS: TestCase_testVec1IndexOutOfBoundsAccess, time elapsed: 525500 ns, RESULT:
    [ PASSED ] CASE: testVec1IndexOutOfBoundsAccess (201900 ns)
    TCS: TestCase_testVec1ShiftVec, time elapsed: 290900 ns, RESULT:
    [ PASSED ] CASE: testVec1ShiftVec (11800 ns)
    TCS: TestCase_testVec1ScalarSub, time elapsed: 228100 ns, RESULT:
    [ PASSED ] CASE: testVec1ScalarSub (17600 ns)
    TCS: TestCase_testVec1ScalarMul, time elapsed: 193600 ns, RESULT:
    [ PASSED ] CASE: testVec1ScalarMul (10100 ns)
    TCS: TestCase_testVec1ScalarDiv, time elapsed: 177200 ns, RESULT:
    [ PASSED ] CASE: testVec1ScalarDiv (6000 ns)
    TCS: TestCase_testVec1ScalarMod, time elapsed: 169000 ns, RESULT:
    [ PASSED ] CASE: testVec1ScalarMod (6300 ns)
    TCS: TestCase_testVec1DivNamed, time elapsed: 181500 ns, RESULT:
    [ PASSED ] CASE: testVec1DivNamed (6600 ns)
    TCS: TestCase_testVec1ModNamed, time elapsed: 193500 ns, RESULT:
    [ PASSED ] CASE: testVec1ModNamed (9800 ns)
    TCS: TestCase_testVec1ScalarBitwiseAnd, time elapsed: 228600 ns, RESULT:
    [ PASSED ] CASE: testVec1ScalarBitwiseAnd (23800 ns)
    TCS: TestCase_testVec1ScalarBitwiseOr, time elapsed: 204000 ns, RESULT:
    [ PASSED ] CASE: testVec1ScalarBitwiseOr (12800 ns)
    TCS: TestCase_testVec1ScalarBitwiseXor, time elapsed: 498800 ns, RESULT:
    [ PASSED ] CASE: testVec1ScalarBitwiseXor (17000 ns)
    TCS: TestCase_testVec1ShiftRightVec, time elapsed: 379300 ns, RESULT:
    [ PASSED ] CASE: testVec1ShiftRightVec (13500 ns)
    TCS: TestCase_testVec1EqualEpsilon, time elapsed: 325100 ns, RESULT:
    [ PASSED ] CASE: testVec1EqualEpsilon (20600 ns)
    TCS: TestCase_testVec1BroadcastAddVec2, time elapsed: 241300 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastAddVec2 (32600 ns)
    TCS: TestCase_testVec1BroadcastBitAndVec2, time elapsed: 363900 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastBitAndVec2 (21800 ns)
    TCS: TestCase_testVec1BroadcastAddVec3, time elapsed: 270500 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastAddVec3 (20300 ns)
    TCS: TestCase_testVec1BroadcastAddVec4, time elapsed: 223500 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastAddVec4 (20000 ns)
    TCS: TestCase_testVec1BroadcastBitOrVec2, time elapsed: 213900 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastBitOrVec2 (8500 ns)
    TCS: TestCase_testVec1BroadcastBitXorVec2, time elapsed: 234300 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastBitXorVec2 (24600 ns)
    TCS: TestCase_testVec1BroadcastShiftLeftVec2, time elapsed: 224200 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastShiftLeftVec2 (8500 ns)
    TCS: TestCase_testVec1BroadcastShiftRightVec2, time elapsed: 226600 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastShiftRightVec2 (9000 ns)
    TCS: TestCase_testVec1BroadcastBitAndVec3, time elapsed: 263400 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastBitAndVec3 (20700 ns)
    TCS: TestCase_testVec1BroadcastBitAndVec4, time elapsed: 228300 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastBitAndVec4 (22700 ns)
    TCS: TestCase_testVec1BroadcastModVec2, time elapsed: 215200 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastModVec2 (13500 ns)
    TCS: TestCase_testVec1BroadcastModVec3, time elapsed: 214200 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastModVec3 (18800 ns)
    TCS: TestCase_testVec1BroadcastModVec4, time elapsed: 209300 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastModVec4 (15100 ns)
    TCS: TestCase_testVec1Increment, time elapsed: 203100 ns, RESULT:
    [ PASSED ] CASE: testVec1Increment (14000 ns)
    TCS: TestCase_testVec1Decrement, time elapsed: 200500 ns, RESULT:
    [ PASSED ] CASE: testVec1Decrement (6900 ns)
    TCS: TestCase_testVec2ScalarInit, time elapsed: 234000 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarInit (20100 ns)
    TCS: TestCase_testVec2ConstInit, time elapsed: 223300 ns, RESULT:
    [ PASSED ] CASE: testVec2ConstInit (18400 ns)
    TCS: TestCase_testVec2Length, time elapsed: 231000 ns, RESULT:
    [ PASSED ] CASE: testVec2Length (8300 ns)
    TCS: TestCase_testVec2Add, time elapsed: 220100 ns, RESULT:
    [ PASSED ] CASE: testVec2Add (17700 ns)
    TCS: TestCase_testVec2Sub, time elapsed: 196300 ns, RESULT:
    [ PASSED ] CASE: testVec2Sub (13800 ns)
    TCS: TestCase_testVec2Mul, time elapsed: 204600 ns, RESULT:
    [ PASSED ] CASE: testVec2Mul (13800 ns)
    TCS: TestCase_testVec2ScalarAdd, time elapsed: 294400 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarAdd (47100 ns)
    TCS: TestCase_testVec2Negate, time elapsed: 213200 ns, RESULT:
    [ PASSED ] CASE: testVec2Negate (16300 ns)
    TCS: TestCase_testVec2IndexAccess, time elapsed: 188200 ns, RESULT:
    [ PASSED ] CASE: testVec2IndexAccess (6600 ns)
    TCS: TestCase_testVec2IndexMutate, time elapsed: 295200 ns, RESULT:
    [ PASSED ] CASE: testVec2IndexMutate (10500 ns)
    TCS: TestCase_testVec2ComponentAt, time elapsed: 191900 ns, RESULT:
    [ PASSED ] CASE: testVec2ComponentAt (6900 ns)
    TCS: TestCase_testVec2Equal, time elapsed: 187000 ns, RESULT:
    [ PASSED ] CASE: testVec2Equal (18100 ns)
    TCS: TestCase_testVec2NotEqual, time elapsed: 196300 ns, RESULT:
    [ PASSED ] CASE: testVec2NotEqual (14900 ns)
    TCS: TestCase_testVec2EqualExact, time elapsed: 176400 ns, RESULT:
    [ PASSED ] CASE: testVec2EqualExact (11000 ns)
    TCS: TestCase_testVec2BitwiseAnd, time elapsed: 176900 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseAnd (13400 ns)
    TCS: TestCase_testVec2BitwiseNot, time elapsed: 163000 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseNot (5600 ns)
    TCS: TestCase_testVec2FromVec1, time elapsed: 181600 ns, RESULT:
    [ PASSED ] CASE: testVec2FromVec1 (6100 ns)
    TCS: TestCase_testVec2ShiftLeft, time elapsed: 178800 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftLeft (13800 ns)
    TCS: TestCase_testVec2BoolLogicalAnd, time elapsed: 175300 ns, RESULT:
    [ PASSED ] CASE: testVec2BoolLogicalAnd (16400 ns)
    TCS: TestCase_testVec2Vec1ArithBroadcast, time elapsed: 170700 ns, RESULT:
    [ PASSED ] CASE: testVec2Vec1ArithBroadcast (10100 ns)
    TCS: TestCase_testVec2Vec1BitBroadcast, time elapsed: 193800 ns, RESULT:
    [ PASSED ] CASE: testVec2Vec1BitBroadcast (12600 ns)
    TCS: TestCase_testVec2ShiftLeftVec1, time elapsed: 200300 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftLeftVec1 (12500 ns)
    TCS: TestCase_testVec2Div, time elapsed: 193600 ns, RESULT:
    [ PASSED ] CASE: testVec2Div (12000 ns)
    TCS: TestCase_testVec2Mod, time elapsed: 187800 ns, RESULT:
    [ PASSED ] CASE: testVec2Mod (15300 ns)
    TCS: TestCase_testVec2ScalarSub, time elapsed: 241000 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarSub (13500 ns)
    TCS: TestCase_testVec2ScalarMul, time elapsed: 188000 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarMul (11100 ns)
    TCS: TestCase_testVec2ScalarDiv, time elapsed: 183600 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarDiv (10900 ns)
    TCS: TestCase_testVec2ScalarMod, time elapsed: 183700 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarMod (6400 ns)
    TCS: TestCase_testVec2BoolLogicalOr, time elapsed: 181700 ns, RESULT:
    [ PASSED ] CASE: testVec2BoolLogicalOr (6400 ns)
    TCS: TestCase_testVec2EqualEpsilon, time elapsed: 205700 ns, RESULT:
    [ PASSED ] CASE: testVec2EqualEpsilon (26800 ns)
    TCS: TestCase_testVec2DivNamed, time elapsed: 176500 ns, RESULT:
    [ PASSED ] CASE: testVec2DivNamed (6300 ns)
    TCS: TestCase_testVec2ModNamed, time elapsed: 205300 ns, RESULT:
    [ PASSED ] CASE: testVec2ModNamed (6700 ns)
    TCS: TestCase_testVec2BitwiseOr, time elapsed: 197300 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseOr (13300 ns)
    TCS: TestCase_testVec2BitwiseXor, time elapsed: 188000 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseXor (10600 ns)
    TCS: TestCase_testVec2ScalarBitwiseAnd, time elapsed: 186300 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarBitwiseAnd (14300 ns)
    TCS: TestCase_testVec2ShiftRight, time elapsed: 194700 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftRight (11800 ns)
    TCS: TestCase_testVec2ShiftRightVec1, time elapsed: 195400 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftRightVec1 (12400 ns)
    TCS: TestCase_testVec2AddNamed, time elapsed: 176700 ns, RESULT:
    [ PASSED ] CASE: testVec2AddNamed (6800 ns)
    TCS: TestCase_testVec2SubNamed, time elapsed: 203000 ns, RESULT:
    [ PASSED ] CASE: testVec2SubNamed (5900 ns)
    TCS: TestCase_testVec2MulNamed, time elapsed: 187900 ns, RESULT:
    [ PASSED ] CASE: testVec2MulNamed (6900 ns)
    TCS: TestCase_testVec2ShiftLeftVec, time elapsed: 185600 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftLeftVec (10500 ns)
    TCS: TestCase_testVec2ShiftRightVec, time elapsed: 197000 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftRightVec (6900 ns)
    TCS: TestCase_testVec2ScalarBitwiseOr, time elapsed: 240600 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarBitwiseOr (18100 ns)
    TCS: TestCase_testVec2ScalarBitwiseXor, time elapsed: 211700 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarBitwiseXor (15000 ns)
    TCS: TestCase_testVec2Increment, time elapsed: 204600 ns, RESULT:
    [ PASSED ] CASE: testVec2Increment (12900 ns)
    TCS: TestCase_testVec2Decrement, time elapsed: 223600 ns, RESULT:
    [ PASSED ] CASE: testVec2Decrement (18800 ns)
    TCS: TestCase_testVec2IndexOutOfBoundsAccess, time elapsed: 237900 ns, RESULT:
    [ PASSED ] CASE: testVec2IndexOutOfBoundsAccess (50200 ns)
    TCS: TestCase_testVec2NegativeIndexAccess, time elapsed: 226200 ns, RESULT:
    [ PASSED ] CASE: testVec2NegativeIndexAccess (29000 ns)
    TCS: TestCase_testVec3ScalarInit, time elapsed: 258400 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarInit (15300 ns)
    TCS: TestCase_testVec3ConstInit, time elapsed: 260100 ns, RESULT:
    [ PASSED ] CASE: testVec3ConstInit (9100 ns)
    TCS: TestCase_testVec3Length, time elapsed: 269800 ns, RESULT:
    [ PASSED ] CASE: testVec3Length (9500 ns)
    TCS: TestCase_testVec3Add, time elapsed: 320500 ns, RESULT:
    [ PASSED ] CASE: testVec3Add (42700 ns)
    TCS: TestCase_testVec3ScalarMul, time elapsed: 269500 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarMul (26700 ns)
    TCS: TestCase_testVec3Negate, time elapsed: 198400 ns, RESULT:
    [ PASSED ] CASE: testVec3Negate (12200 ns)
    TCS: TestCase_testVec3IndexAccess, time elapsed: 219100 ns, RESULT:
    [ PASSED ] CASE: testVec3IndexAccess (13600 ns)
    TCS: TestCase_testVec3IndexMutate, time elapsed: 206300 ns, RESULT:
    [ PASSED ] CASE: testVec3IndexMutate (6700 ns)
    TCS: TestCase_testVec3ComponentAt, time elapsed: 194400 ns, RESULT:
    [ PASSED ] CASE: testVec3ComponentAt (11000 ns)
    TCS: TestCase_testVec3Equal, time elapsed: 216700 ns, RESULT:
    [ PASSED ] CASE: testVec3Equal (21500 ns)
    TCS: TestCase_testVec3NotEqual, time elapsed: 189900 ns, RESULT:
    [ PASSED ] CASE: testVec3NotEqual (14800 ns)
    TCS: TestCase_testVec3EqualExact, time elapsed: 175100 ns, RESULT:
    [ PASSED ] CASE: testVec3EqualExact (10600 ns)
    TCS: TestCase_testVec3BitwiseAnd, time elapsed: 200700 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseAnd (14000 ns)
    TCS: TestCase_testVec3BitwiseNot, time elapsed: 182600 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseNot (6600 ns)
    TCS: TestCase_testVec3Vec1ArithBroadcast, time elapsed: 206600 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1ArithBroadcast (22300 ns)
    TCS: TestCase_testVec3ShiftLeft, time elapsed: 189400 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftLeft (13600 ns)
    TCS: TestCase_testVec3BoolLogicalAnd, time elapsed: 423700 ns, RESULT:
    [ PASSED ] CASE: testVec3BoolLogicalAnd (27200 ns)
    TCS: TestCase_testVec3Sub, time elapsed: 234000 ns, RESULT:
    [ PASSED ] CASE: testVec3Sub (23700 ns)
    TCS: TestCase_testVec3Div, time elapsed: 250600 ns, RESULT:
    [ PASSED ] CASE: testVec3Div (15200 ns)
    TCS: TestCase_testVec3Mod, time elapsed: 414700 ns, RESULT:
    [ PASSED ] CASE: testVec3Mod (44400 ns)
    TCS: TestCase_testVec3ScalarSub, time elapsed: 384600 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarSub (31400 ns)
    TCS: TestCase_testVec3ScalarDiv, time elapsed: 330300 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarDiv (28100 ns)
    TCS: TestCase_testVec3ScalarMod, time elapsed: 1006400 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarMod (22000 ns)
    TCS: TestCase_testVec3BoolLogicalOr, time elapsed: 393200 ns, RESULT:
    [ PASSED ] CASE: testVec3BoolLogicalOr (13100 ns)
    TCS: TestCase_testVec3EqualEpsilon, time elapsed: 245900 ns, RESULT:
    [ PASSED ] CASE: testVec3EqualEpsilon (28300 ns)
    TCS: TestCase_testVec3AddNamed, time elapsed: 253400 ns, RESULT:
    [ PASSED ] CASE: testVec3AddNamed (22600 ns)
    TCS: TestCase_testVec3MulNamed, time elapsed: 201500 ns, RESULT:
    [ PASSED ] CASE: testVec3MulNamed (8600 ns)
    TCS: TestCase_testVec3DivNamed, time elapsed: 198300 ns, RESULT:
    [ PASSED ] CASE: testVec3DivNamed (8000 ns)
    TCS: TestCase_testVec3ModNamed, time elapsed: 184600 ns, RESULT:
    [ PASSED ] CASE: testVec3ModNamed (7500 ns)
    TCS: TestCase_testVec3BitwiseOr, time elapsed: 204500 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseOr (19400 ns)
    TCS: TestCase_testVec3BitwiseXor, time elapsed: 199200 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseXor (18800 ns)
    TCS: TestCase_testVec3ScalarBitwiseAnd, time elapsed: 194500 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarBitwiseAnd (11800 ns)
    TCS: TestCase_testVec3ShiftRight, time elapsed: 214500 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftRight (14400 ns)
    TCS: TestCase_testVec3Vec1BitBroadcast, time elapsed: 197900 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1BitBroadcast (15700 ns)
    TCS: TestCase_testVec3ShiftRightVec1, time elapsed: 198700 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftRightVec1 (12200 ns)
    TCS: TestCase_testVec3FromVec1, time elapsed: 186500 ns, RESULT:
    [ PASSED ] CASE: testVec3FromVec1 (6700 ns)
    TCS: TestCase_testVec3ScalarBitwiseOr, time elapsed: 197500 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarBitwiseOr (18600 ns)
    TCS: TestCase_testVec3ScalarBitwiseXor, time elapsed: 197700 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarBitwiseXor (13500 ns)
    TCS: TestCase_testVec3Vec1BitOrBroadcast, time elapsed: 203800 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1BitOrBroadcast (12400 ns)
    TCS: TestCase_testVec3Vec1BitXorBroadcast, time elapsed: 213800 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1BitXorBroadcast (11900 ns)
    TCS: TestCase_testVec3ShiftLeftVec1, time elapsed: 215500 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftLeftVec1 (18800 ns)
    TCS: TestCase_testVec3ShiftLeftVec, time elapsed: 180100 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftLeftVec (9200 ns)
    TCS: TestCase_testVec3ShiftRightVec, time elapsed: 189300 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftRightVec (11800 ns)
    TCS: TestCase_testVec3Increment, time elapsed: 195200 ns, RESULT:
    [ PASSED ] CASE: testVec3Increment (17600 ns)
    TCS: TestCase_testVec3Decrement, time elapsed: 188800 ns, RESULT:
    [ PASSED ] CASE: testVec3Decrement (13500 ns)
    TCS: TestCase_testVec3IndexOutOfBoundsAccess, time elapsed: 222900 ns, RESULT:
    [ PASSED ] CASE: testVec3IndexOutOfBoundsAccess (46000 ns)
    TCS: TestCase_testVec3NegativeIndexAccess, time elapsed: 204000 ns, RESULT:
    [ PASSED ] CASE: testVec3NegativeIndexAccess (20000 ns)
    TCS: TestCase_testVec4ScalarInit, time elapsed: 190500 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarInit (13000 ns)
    TCS: TestCase_testVec4ConstInit, time elapsed: 187000 ns, RESULT:
    [ PASSED ] CASE: testVec4ConstInit (10200 ns)
    TCS: TestCase_testVec4Length, time elapsed: 182400 ns, RESULT:
    [ PASSED ] CASE: testVec4Length (5500 ns)
    TCS: TestCase_testVec4Add, time elapsed: 191100 ns, RESULT:
    [ PASSED ] CASE: testVec4Add (17700 ns)
    TCS: TestCase_testVec4ScalarMul, time elapsed: 185900 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarMul (13500 ns)
    TCS: TestCase_testVec4Negate, time elapsed: 193000 ns, RESULT:
    [ PASSED ] CASE: testVec4Negate (16600 ns)
    TCS: TestCase_testVec4IndexAccess, time elapsed: 183700 ns, RESULT:
    [ PASSED ] CASE: testVec4IndexAccess (10500 ns)
    TCS: TestCase_testVec4IndexMutate, time elapsed: 275300 ns, RESULT:
    [ PASSED ] CASE: testVec4IndexMutate (8800 ns)
    TCS: TestCase_testVec4ComponentAt, time elapsed: 188300 ns, RESULT:
    [ PASSED ] CASE: testVec4ComponentAt (6300 ns)
    TCS: TestCase_testVec4Equal, time elapsed: 220500 ns, RESULT:
    [ PASSED ] CASE: testVec4Equal (20200 ns)
    TCS: TestCase_testVec4NotEqual, time elapsed: 187800 ns, RESULT:
    [ PASSED ] CASE: testVec4NotEqual (14200 ns)
    TCS: TestCase_testVec4EqualExact, time elapsed: 192500 ns, RESULT:
    [ PASSED ] CASE: testVec4EqualExact (13600 ns)
    TCS: TestCase_testVec4BitwiseAnd, time elapsed: 317300 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseAnd (13000 ns)
    TCS: TestCase_testVec4BitwiseNot, time elapsed: 324800 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseNot (14200 ns)
    TCS: TestCase_testVec4Vec1ArithBroadcast, time elapsed: 320200 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1ArithBroadcast (30600 ns)
    TCS: TestCase_testVec4ShiftLeft, time elapsed: 335600 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftLeft (27700 ns)
    TCS: TestCase_testVec4BoolLogicalAnd, time elapsed: 329100 ns, RESULT:
    [ PASSED ] CASE: testVec4BoolLogicalAnd (31300 ns)
    TCS: TestCase_testVec4Sub, time elapsed: 274700 ns, RESULT:
    [ PASSED ] CASE: testVec4Sub (22900 ns)
    TCS: TestCase_testVec4Div, time elapsed: 283400 ns, RESULT:
    [ PASSED ] CASE: testVec4Div (25600 ns)
    TCS: TestCase_testVec4Mod, time elapsed: 304700 ns, RESULT:
    [ PASSED ] CASE: testVec4Mod (23600 ns)
    TCS: TestCase_testVec4ScalarSub, time elapsed: 350200 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarSub (27300 ns)
    TCS: TestCase_testVec4ScalarDiv, time elapsed: 360800 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarDiv (33300 ns)
    TCS: TestCase_testVec4ScalarMod, time elapsed: 377500 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarMod (25800 ns)
    TCS: TestCase_testVec4BoolLogicalOr, time elapsed: 352000 ns, RESULT:
    [ PASSED ] CASE: testVec4BoolLogicalOr (15800 ns)
    TCS: TestCase_testVec4EqualEpsilon, time elapsed: 392100 ns, RESULT:
    [ PASSED ] CASE: testVec4EqualEpsilon (38800 ns)
    TCS: TestCase_testVec4AddNamed, time elapsed: 335900 ns, RESULT:
    [ PASSED ] CASE: testVec4AddNamed (30500 ns)
    TCS: TestCase_testVec4MulNamed, time elapsed: 300000 ns, RESULT:
    [ PASSED ] CASE: testVec4MulNamed (13600 ns)
    TCS: TestCase_testVec4DivNamed, time elapsed: 300700 ns, RESULT:
    [ PASSED ] CASE: testVec4DivNamed (12400 ns)
    TCS: TestCase_testVec4ModNamed, time elapsed: 345600 ns, RESULT:
    [ PASSED ] CASE: testVec4ModNamed (13400 ns)
    TCS: TestCase_testVec4BitwiseOr, time elapsed: 350400 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseOr (28200 ns)
    TCS: TestCase_testVec4BitwiseXor, time elapsed: 357700 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseXor (29800 ns)
    TCS: TestCase_testVec4ScalarBitwiseAnd, time elapsed: 317800 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarBitwiseAnd (21700 ns)
    TCS: TestCase_testVec4ShiftRight, time elapsed: 321500 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftRight (22700 ns)
    TCS: TestCase_testVec4Vec1BitBroadcast, time elapsed: 296300 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1BitBroadcast (24700 ns)
    TCS: TestCase_testVec4ShiftRightVec1, time elapsed: 312300 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftRightVec1 (19700 ns)
    TCS: TestCase_testVec4FromVec1, time elapsed: 270200 ns, RESULT:
    [ PASSED ] CASE: testVec4FromVec1 (11500 ns)
    TCS: TestCase_testVec4ScalarBitwiseOr, time elapsed: 286600 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarBitwiseOr (23000 ns)
    TCS: TestCase_testVec4ScalarBitwiseXor, time elapsed: 329800 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarBitwiseXor (35900 ns)
    TCS: TestCase_testVec4Vec1BitOrBroadcast, time elapsed: 374400 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1BitOrBroadcast (31100 ns)
    TCS: TestCase_testVec4Vec1BitXorBroadcast, time elapsed: 344500 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1BitXorBroadcast (28500 ns)
    TCS: TestCase_testVec4ShiftLeftVec1, time elapsed: 343100 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftLeftVec1 (25100 ns)
    TCS: TestCase_testVec4ShiftLeftVec, time elapsed: 343200 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftLeftVec (22100 ns)
    TCS: TestCase_testVec4ShiftRightVec, time elapsed: 379400 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftRightVec (30800 ns)
    TCS: TestCase_testVec4Increment, time elapsed: 388600 ns, RESULT:
    [ PASSED ] CASE: testVec4Increment (47000 ns)
    TCS: TestCase_testVec4Decrement, time elapsed: 579300 ns, RESULT:
    [ PASSED ] CASE: testVec4Decrement (63800 ns)
    TCS: TestCase_testVec4IndexOutOfBoundsAccess, time elapsed: 342400 ns, RESULT:
    [ PASSED ] CASE: testVec4IndexOutOfBoundsAccess (54200 ns)
    TCS: TestCase_testVec4NegativeIndexAccess, time elapsed: 371500 ns, RESULT:
    [ PASSED ] CASE: testVec4NegativeIndexAccess (40100 ns)
    TCS: TestCase_testFunctor1Vec1Identity, time elapsed: 319600 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec1Identity (20400 ns)
    TCS: TestCase_testFunctor1Vec1Transform, time elapsed: 299300 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec1Transform (20200 ns)
    TCS: TestCase_testFunctor1Vec2Transform, time elapsed: 289800 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec2Transform (29600 ns)
    TCS: TestCase_testFunctor2Vec1Add, time elapsed: 261400 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec1Add (14300 ns)
    TCS: TestCase_testFunctor2VecScaVec1Mul, time elapsed: 312100 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec1Mul (22600 ns)
    TCS: TestCase_testFunctor2VecIntVec1Shift, time elapsed: 228600 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec1Shift (10200 ns)
    TCS: TestCase_testFunctor1Vec3Transform, time elapsed: 221800 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec3Transform (11200 ns)
    TCS: TestCase_testFunctor1Vec4Transform, time elapsed: 231100 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec4Transform (12700 ns)
    TCS: TestCase_testFunctor2Vec2Add, time elapsed: 206400 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec2Add (10700 ns)
    TCS: TestCase_testFunctor2Vec3Add, time elapsed: 198800 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec3Add (9200 ns)
    TCS: TestCase_testFunctor2Vec4Add, time elapsed: 209600 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec4Add (10100 ns)
    TCS: TestCase_testFunctor2VecScaVec2Mul, time elapsed: 210900 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec2Mul (8600 ns)
    TCS: TestCase_testFunctor2VecScaVec3Mul, time elapsed: 244100 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec3Mul (19100 ns)
    TCS: TestCase_testFunctor2VecScaVec4Mul, time elapsed: 254400 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec4Mul (10900 ns)
    TCS: TestCase_testFunctor2VecIntVec2Shift, time elapsed: 243400 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec2Shift (18100 ns)
    TCS: TestCase_testFunctor2VecIntVec3Shift, time elapsed: 216400 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec3Shift (10400 ns)
    TCS: TestCase_testFunctor2VecIntVec4Shift, time elapsed: 214700 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec4Shift (10000 ns)
Summary: TOTAL: 476
    PASSED: 476, SKIPPED: 0, ERROR: 0
    FAILED: 0



📦 group glm.detail                  100% [||||||||||||||||||||] ✓    (00:00:00)

passed: 476, failed: 0            100% [||||||||||||||||||||] 476/476 (00:00:00) --------------------------------------------------------------------------------------------------
Project tests finished, time elapsed: 224213900 ns, RESULT:
TP: glm.*, time elapsed: 224158800 ns, RESULT:
    PASSED:
    TP: glm.detail, time elapsed: 208754700 ns
Summary: TOTAL: 476
    PASSED: 476, SKIPPED: 0, ERROR: 0
    FAILED: 0
--------------------------------------------------------------------------------------------------
cjpm test success
