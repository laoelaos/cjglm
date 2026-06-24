# 验证报告（v8）

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

warning[0m: unused variable:'v'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:14:26:
   | 
14 | public func length<T, Q>(v: Vec3<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                          ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'b'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:14:26:
   | 
14 | public func mix<T>(a: T, b: T, t: T): T where T <: Number<T> { throw Exception("stub") }
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:155:58:
    | 
155 |     public static func fromMat<SrcQ>(m: Mat2x3<T, SrcQ>, one: T): Mat3x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:161:58:
    | 
161 |     public static func fromMat<SrcQ>(m: Mat2x4<T, SrcQ>, one: T): Mat3x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:167:58:
    | 
167 |     public static func fromMat<SrcQ>(m: Mat3x3<T, SrcQ>, one: T): Mat3x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:167:58:
    | 
167 |     public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat2x4<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:173:58:
    | 
173 |     public static func fromMat<SrcQ>(m: Mat3x2<T, SrcQ>, one: T): Mat4x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:191:58:
    | 
191 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat4x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:217:71:
    | 
217 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x2<U, P>, one: T): Mat2x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:234:71:
    | 
234 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x4<U, P>, one: T): Mat3x2<T, Q>
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

153 warnings generated, 153 warnings printed.
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
TP: [33mglm.detail[0m, time elapsed: 161489100 ns, RESULT:
    TCS: [33mTestCase_testComputeVecAdd1[0m, time elapsed: 1335100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAdd1 (322800 ns)
    TCS: [33mTestCase_testComputeVecSub2[0m, time elapsed: 278200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub2 (33100 ns)
    TCS: [33mTestCase_testComputeVecMul3[0m, time elapsed: 261100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul3 (26900 ns)
    TCS: [33mTestCase_testComputeVecMod1[0m, time elapsed: 258700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMod1 (27700 ns)
    TCS: [33mTestCase_testComputeVecMod4[0m, time elapsed: 265500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMod4 (29500 ns)
    TCS: [33mTestCase_testComputeVecAnd1[0m, time elapsed: 235000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAnd1 (19800 ns)
    TCS: [33mTestCase_testComputeVecAnd3[0m, time elapsed: 250600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAnd3 (20300 ns)
    TCS: [33mTestCase_testComputeVecOr1[0m, time elapsed: 237200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecOr1 (17600 ns)
    TCS: [33mTestCase_testComputeVecOr2[0m, time elapsed: 232800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecOr2 (18100 ns)
    TCS: [33mTestCase_testComputeVecXor1[0m, time elapsed: 242600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecXor1 (18100 ns)
    TCS: [33mTestCase_testComputeVecXor4[0m, time elapsed: 253100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecXor4 (18700 ns)
    TCS: [33mTestCase_testComputeVecShiftLeft1[0m, time elapsed: 263800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftLeft1 (15300 ns)
    TCS: [33mTestCase_testComputeVecShiftLeft3[0m, time elapsed: 232300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftLeft3 (12700 ns)
    TCS: [33mTestCase_testComputeVecShiftRight1[0m, time elapsed: 234800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftRight1 (12700 ns)
    TCS: [33mTestCase_testComputeVecShiftRight4[0m, time elapsed: 233800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftRight4 (18300 ns)
    TCS: [33mTestCase_testComputeVecEqual1[0m, time elapsed: 287800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual1 (16200 ns)
    TCS: [33mTestCase_testComputeVecNequal4[0m, time elapsed: 235300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal4 (18200 ns)
    TCS: [33mTestCase_testComputeVecBitwiseNot1[0m, time elapsed: 259400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecBitwiseNot1 (23600 ns)
    TCS: [33mTestCase_testComputeVecBitwiseNot3[0m, time elapsed: 243300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecBitwiseNot3 (20500 ns)
    TCS: [33mTestCase_testComputeVecAdd4[0m, time elapsed: 264800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAdd4 (40600 ns)
    TCS: [33mTestCase_testComputeVecSub1[0m, time elapsed: 829900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub1 (16900 ns)
    TCS: [33mTestCase_testComputeVecSub3[0m, time elapsed: 220200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub3 (23600 ns)
    TCS: [33mTestCase_testComputeVecMul1[0m, time elapsed: 210600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul1 (14400 ns)
    TCS: [33mTestCase_testComputeVecMul2[0m, time elapsed: 201300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul2 (14700 ns)
    TCS: [33mTestCase_testComputeVecDiv1[0m, time elapsed: 197600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecDiv1 (14700 ns)
    TCS: [33mTestCase_testComputeVecDiv2[0m, time elapsed: 225800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecDiv2 (15600 ns)
    TCS: [33mTestCase_testComputeVecDiv4[0m, time elapsed: 223600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecDiv4 (18600 ns)
    TCS: [33mTestCase_testComputeVecEqual2[0m, time elapsed: 218100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual2 (18400 ns)
    TCS: [33mTestCase_testComputeVecEqual3[0m, time elapsed: 220100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual3 (20800 ns)
    TCS: [33mTestCase_testComputeVecEqual4[0m, time elapsed: 215100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual4 (20900 ns)
    TCS: [33mTestCase_testComputeVecNequal1[0m, time elapsed: 258500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal1 (18300 ns)
    TCS: [33mTestCase_testComputeVecNequal2[0m, time elapsed: 233800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal2 (11300 ns)
    TCS: [33mTestCase_testComputeVecBitwiseNot4[0m, time elapsed: 286200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecBitwiseNot4 (34000 ns)
    TCS: [33mTestCase_testComputeVecAddFloat32[0m, time elapsed: 309000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAddFloat32 (45100 ns)
    TCS: [33mTestCase_testComputeVecAddFloat32Vec3[0m, time elapsed: 288100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAddFloat32Vec3 (36200 ns)
    TCS: [33mTestCase_testComputeVecSubFloat32[0m, time elapsed: 217500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSubFloat32 (17400 ns)
    TCS: [33mTestCase_testComputeVecSubFloat32Vec4[0m, time elapsed: 235500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSubFloat32Vec4 (21900 ns)
    TCS: [33mTestCase_testComputeEqualInt32Equal[0m, time elapsed: 227300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt32Equal (14700 ns)
    TCS: [33mTestCase_testComputeEqualInt32NotEqual[0m, time elapsed: 188000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt32NotEqual (14200 ns)
    TCS: [33mTestCase_testComputeEqualFloat32Equal[0m, time elapsed: 227900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32Equal (11800 ns)
    TCS: [33mTestCase_testComputeEqualFloat32NotEqual[0m, time elapsed: 350700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32NotEqual (22900 ns)
    TCS: [33mTestCase_testComputeEqualFloat64Equal[0m, time elapsed: 270900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64Equal (13200 ns)
    TCS: [33mTestCase_testComputeEqualFloat64NotEqual[0m, time elapsed: 399100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64NotEqual (18000 ns)
    TCS: [33mTestCase_testComputeEqualBoolEqual[0m, time elapsed: 395900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualBoolEqual (26800 ns)
    TCS: [33mTestCase_testComputeEqualBoolNotEqual[0m, time elapsed: 406300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualBoolNotEqual (21600 ns)
    TCS: [33mTestCase_testComputeEqualNumericInt32[0m, time elapsed: 429800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericInt32 (23800 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32[0m, time elapsed: 395900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32 (42600 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32Epsilon[0m, time elapsed: 255600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32Epsilon (11700 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64[0m, time elapsed: 322400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64 (20600 ns)
    TCS: [33mTestCase_testComputeEqualInt64Equal[0m, time elapsed: 294200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt64Equal (15400 ns)
    TCS: [33mTestCase_testComputeEqualInt64NotEqual[0m, time elapsed: 308400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt64NotEqual (13500 ns)
    TCS: [33mTestCase_testComputeEqualFloat32Nan[0m, time elapsed: 283600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32Nan (14500 ns)
    TCS: [33mTestCase_testComputeEqualFloat64Nan[0m, time elapsed: 311600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64Nan (15600 ns)
    TCS: [33mTestCase_testComputeEqualFloat32SignedZero[0m, time elapsed: 301800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32SignedZero (20200 ns)
    TCS: [33mTestCase_testComputeEqualFloat64SignedZero[0m, time elapsed: 267100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64SignedZero (15600 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32NotEqual[0m, time elapsed: 255300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32NotEqual (17000 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32BeyondEpsilon[0m, time elapsed: 237000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32BeyondEpsilon (13100 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64NotEqual[0m, time elapsed: 219600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64NotEqual (13300 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64Epsilon[0m, time elapsed: 225600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64Epsilon (11500 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64BeyondEpsilon[0m, time elapsed: 230300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64BeyondEpsilon (17700 ns)
    TCS: [33mTestCase_testComputeEqualNumericInt64[0m, time elapsed: 230700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericInt64 (11300 ns)
    TCS: [33mTestCase_testPackedHighpImplementsQualifier[0m, time elapsed: 252200 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedHighpImplementsQualifier (10400 ns)
    TCS: [33mTestCase_testPackedMediumpImplementsQualifier[0m, time elapsed: 234500 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedMediumpImplementsQualifier (10900 ns)
    TCS: [33mTestCase_testPackedLowpImplementsQualifier[0m, time elapsed: 220300 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedLowpImplementsQualifier (8800 ns)
    TCS: [33mTestCase_testDefaultpIsPackedHighp[0m, time elapsed: 206600 ns, RESULT:
    [[32m PASSED [0m] CASE: testDefaultpIsPackedHighp (8200 ns)
    TCS: [33mTestCase_testScalarAddVec1[0m, time elapsed: 209100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec1 (17000 ns)
    TCS: [33mTestCase_testScalarAddVec2[0m, time elapsed: 211200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec2 (15800 ns)
    TCS: [33mTestCase_testScalarAddVec3[0m, time elapsed: 212900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec3 (15900 ns)
    TCS: [33mTestCase_testScalarAddVec4[0m, time elapsed: 214400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec4 (13600 ns)
    TCS: [33mTestCase_testScalarSubVec1[0m, time elapsed: 204100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1 (14600 ns)
    TCS: [33mTestCase_testScalarMulVec1[0m, time elapsed: 196300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1 (15000 ns)
    TCS: [33mTestCase_testScalarDivVec1[0m, time elapsed: 204600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1 (20200 ns)
    TCS: [33mTestCase_testScalarModVec1[0m, time elapsed: 197900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1 (12400 ns)
    TCS: [33mTestCase_testScalarMulVec2[0m, time elapsed: 190900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2 (10000 ns)
    TCS: [33mTestCase_testScalarSubVec2[0m, time elapsed: 191100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2 (8400 ns)
    TCS: [33mTestCase_testScalarSubVec3[0m, time elapsed: 200000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3 (11800 ns)
    TCS: [33mTestCase_testScalarSubVec4[0m, time elapsed: 192400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4 (14900 ns)
    TCS: [33mTestCase_testScalarMulVec3[0m, time elapsed: 196500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3 (9400 ns)
    TCS: [33mTestCase_testScalarMulVec4[0m, time elapsed: 193900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4 (11900 ns)
    TCS: [33mTestCase_testScalarDivVec2[0m, time elapsed: 193600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2 (9800 ns)
    TCS: [33mTestCase_testScalarDivVec3[0m, time elapsed: 338000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3 (15700 ns)
    TCS: [33mTestCase_testScalarDivVec4[0m, time elapsed: 307100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4 (24800 ns)
    TCS: [33mTestCase_testScalarModVec2[0m, time elapsed: 316100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2 (17300 ns)
    TCS: [33mTestCase_testScalarModVec3[0m, time elapsed: 333600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3 (23300 ns)
    TCS: [33mTestCase_testScalarModVec4[0m, time elapsed: 238200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4 (16200 ns)
    TCS: [33mTestCase_testScalarModVec1Float32[0m, time elapsed: 230900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float32 (19400 ns)
    TCS: [33mTestCase_testScalarModVec2Float32[0m, time elapsed: 191600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32 (9800 ns)
    TCS: [33mTestCase_testScalarModVec3Float32[0m, time elapsed: 210100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float32 (17000 ns)
    TCS: [33mTestCase_testScalarModVec4Float32[0m, time elapsed: 294000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float32 (19000 ns)
    TCS: [33mTestCase_testScalarModVec1Float64[0m, time elapsed: 298400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float64 (21800 ns)
    TCS: [33mTestCase_testScalarModVec2Float64[0m, time elapsed: 317000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float64 (15200 ns)
    TCS: [33mTestCase_testScalarModVec3Float64[0m, time elapsed: 295500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float64 (14700 ns)
    TCS: [33mTestCase_testScalarModVec4Float64[0m, time elapsed: 285500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float64 (20600 ns)
    TCS: [33mTestCase_testScalarModVec1Float16[0m, time elapsed: 311500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float16 (33500 ns)
    TCS: [33mTestCase_testScalarModVec2Float16[0m, time elapsed: 320200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float16 (15600 ns)
    TCS: [33mTestCase_testScalarModVec3Float16[0m, time elapsed: 300500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float16 (13500 ns)
    TCS: [33mTestCase_testScalarModVec4Float16[0m, time elapsed: 286600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float16 (13900 ns)
    TCS: [33mTestCase_testScalarSubVec2PackedMediump[0m, time elapsed: 266800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2PackedMediump (19000 ns)
    TCS: [33mTestCase_testScalarSubVec2PackedLowp[0m, time elapsed: 279900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2PackedLowp (16500 ns)
    TCS: [33mTestCase_testScalarMulVec2PackedMediump[0m, time elapsed: 273100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2PackedMediump (16000 ns)
    TCS: [33mTestCase_testScalarMulVec2PackedLowp[0m, time elapsed: 331400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2PackedLowp (19900 ns)
    TCS: [33mTestCase_testScalarDivVec2PackedMediump[0m, time elapsed: 305700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2PackedMediump (20400 ns)
    TCS: [33mTestCase_testScalarDivVec2PackedLowp[0m, time elapsed: 322300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2PackedLowp (17000 ns)
    TCS: [33mTestCase_testScalarModVec2PackedMediump[0m, time elapsed: 273800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2PackedMediump (17900 ns)
    TCS: [33mTestCase_testScalarModVec2PackedLowp[0m, time elapsed: 208700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2PackedLowp (8600 ns)
    TCS: [33mTestCase_testScalarModVec2Float32PackedMediump[0m, time elapsed: 235900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32PackedMediump (15700 ns)
    TCS: [33mTestCase_testScalarModVec2Float32PackedLowp[0m, time elapsed: 196800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32PackedLowp (8500 ns)
    TCS: [33mTestCase_testScalarModVec2Float32NegativeDividend[0m, time elapsed: 225900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32NegativeDividend (10700 ns)
    TCS: [33mTestCase_testScalarModVec2Float32NegativeDivisor[0m, time elapsed: 216500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32NegativeDivisor (13800 ns)
    TCS: [33mTestCase_testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents[0m, time elapsed: 337500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents (142000 ns)
    TCS: [33mTestCase_testScalarAddVec1Float32[0m, time elapsed: 195100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec1Float32 (10800 ns)
    TCS: [33mTestCase_testScalarAddVec2Float32[0m, time elapsed: 202300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec2Float32 (12000 ns)
    TCS: [33mTestCase_testScalarAddVec3Float32[0m, time elapsed: 188800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec3Float32 (9300 ns)
    TCS: [33mTestCase_testScalarAddVec4Float32[0m, time elapsed: 187400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec4Float32 (9400 ns)
    TCS: [33mTestCase_testScalarSubVec1Float32[0m, time elapsed: 188000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1Float32 (14300 ns)
    TCS: [33mTestCase_testScalarSubVec2Float32[0m, time elapsed: 189400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2Float32 (8300 ns)
    TCS: [33mTestCase_testScalarSubVec3Float32[0m, time elapsed: 193200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3Float32 (8100 ns)
    TCS: [33mTestCase_testScalarSubVec4Float32[0m, time elapsed: 189900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4Float32 (10600 ns)
    TCS: [33mTestCase_testScalarMulVec1Float32[0m, time elapsed: 201500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1Float32 (8200 ns)
    TCS: [33mTestCase_testScalarMulVec2Float32[0m, time elapsed: 202500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2Float32 (7600 ns)
    TCS: [33mTestCase_testScalarMulVec3Float32[0m, time elapsed: 187200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3Float32 (9500 ns)
    TCS: [33mTestCase_testScalarMulVec4Float32[0m, time elapsed: 186400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4Float32 (9000 ns)
    TCS: [33mTestCase_testScalarDivVec1Float32[0m, time elapsed: 236500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1Float32 (10200 ns)
    TCS: [33mTestCase_testScalarDivVec2Float32[0m, time elapsed: 216000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2Float32 (9800 ns)
    TCS: [33mTestCase_testScalarDivVec3Float32[0m, time elapsed: 217200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3Float32 (13500 ns)
    TCS: [33mTestCase_testScalarDivVec4Float32[0m, time elapsed: 186500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4Float32 (9000 ns)
    TCS: [33mTestCase_testScalarAddVec1Int32[0m, time elapsed: 208600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec1Int32 (17100 ns)
    TCS: [33mTestCase_testScalarAddVec2Int32[0m, time elapsed: 190800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec2Int32 (10400 ns)
    TCS: [33mTestCase_testScalarAddVec3Int32[0m, time elapsed: 221300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec3Int32 (11000 ns)
    TCS: [33mTestCase_testScalarAddVec4Int32[0m, time elapsed: 194900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec4Int32 (13400 ns)
    TCS: [33mTestCase_testScalarSubVec1Int32[0m, time elapsed: 196500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1Int32 (16300 ns)
    TCS: [33mTestCase_testScalarSubVec2Int32[0m, time elapsed: 202500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2Int32 (10300 ns)
    TCS: [33mTestCase_testScalarSubVec3Int32[0m, time elapsed: 216100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3Int32 (13600 ns)
    TCS: [33mTestCase_testScalarSubVec4Int32[0m, time elapsed: 222900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4Int32 (12300 ns)
    TCS: [33mTestCase_testScalarMulVec1Int32[0m, time elapsed: 211700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1Int32 (10000 ns)
    TCS: [33mTestCase_testScalarMulVec2Int32[0m, time elapsed: 248100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2Int32 (11600 ns)
    TCS: [33mTestCase_testScalarMulVec3Int32[0m, time elapsed: 194700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3Int32 (9000 ns)
    TCS: [33mTestCase_testScalarMulVec4Int32[0m, time elapsed: 203200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4Int32 (11700 ns)
    TCS: [33mTestCase_testScalarDivVec1Int32[0m, time elapsed: 197400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1Int32 (9000 ns)
    TCS: [33mTestCase_testScalarDivVec2Int32[0m, time elapsed: 189600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2Int32 (8100 ns)
    TCS: [33mTestCase_testScalarDivVec3Int32[0m, time elapsed: 190300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3Int32 (9500 ns)
    TCS: [33mTestCase_testScalarDivVec4Int32[0m, time elapsed: 199700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4Int32 (14800 ns)
    TCS: [33mTestCase_testScalarModVec1Int32[0m, time elapsed: 201300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Int32 (11100 ns)
    TCS: [33mTestCase_testScalarModVec2Int32[0m, time elapsed: 193500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Int32 (8100 ns)
    TCS: [33mTestCase_testScalarModVec3Int32[0m, time elapsed: 190800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Int32 (8300 ns)
    TCS: [33mTestCase_testScalarModVec4Int32[0m, time elapsed: 200400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Int32 (8600 ns)
    TCS: [33mTestCase_testScalarSubVec1PackedMediump[0m, time elapsed: 202500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1PackedMediump (15500 ns)
    TCS: [33mTestCase_testScalarSubVec1PackedLowp[0m, time elapsed: 196300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1PackedLowp (10000 ns)
    TCS: [33mTestCase_testScalarSubVec3PackedMediump[0m, time elapsed: 195100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3PackedMediump (10100 ns)
    TCS: [33mTestCase_testScalarSubVec3PackedLowp[0m, time elapsed: 186300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3PackedLowp (9700 ns)
    TCS: [33mTestCase_testScalarSubVec4PackedMediump[0m, time elapsed: 209000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4PackedMediump (14100 ns)
    TCS: [33mTestCase_testScalarSubVec4PackedLowp[0m, time elapsed: 280800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4PackedLowp (10400 ns)
    TCS: [33mTestCase_testScalarMulVec1PackedMediump[0m, time elapsed: 202800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1PackedMediump (9400 ns)
    TCS: [33mTestCase_testScalarMulVec1PackedLowp[0m, time elapsed: 196500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1PackedLowp (9600 ns)
    TCS: [33mTestCase_testScalarMulVec3PackedMediump[0m, time elapsed: 187600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3PackedMediump (9300 ns)
    TCS: [33mTestCase_testScalarMulVec3PackedLowp[0m, time elapsed: 205500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3PackedLowp (8500 ns)
    TCS: [33mTestCase_testScalarMulVec4PackedMediump[0m, time elapsed: 189700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4PackedMediump (8400 ns)
    TCS: [33mTestCase_testScalarMulVec4PackedLowp[0m, time elapsed: 192400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4PackedLowp (8500 ns)
    TCS: [33mTestCase_testScalarDivVec1PackedMediump[0m, time elapsed: 200500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1PackedMediump (9200 ns)
    TCS: [33mTestCase_testScalarDivVec1PackedLowp[0m, time elapsed: 229900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1PackedLowp (12000 ns)
    TCS: [33mTestCase_testScalarDivVec3PackedMediump[0m, time elapsed: 203300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3PackedMediump (11900 ns)
    TCS: [33mTestCase_testScalarDivVec3PackedLowp[0m, time elapsed: 212900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3PackedLowp (10500 ns)
    TCS: [33mTestCase_testScalarDivVec4PackedMediump[0m, time elapsed: 233200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4PackedMediump (13700 ns)
    TCS: [33mTestCase_testScalarDivVec4PackedLowp[0m, time elapsed: 306200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4PackedLowp (22600 ns)
    TCS: [33mTestCase_testScalarModVec1PackedMediump[0m, time elapsed: 307500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1PackedMediump (16100 ns)
    TCS: [33mTestCase_testScalarModVec1PackedLowp[0m, time elapsed: 269500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1PackedLowp (14000 ns)
    TCS: [33mTestCase_testScalarModVec3PackedMediump[0m, time elapsed: 264500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3PackedMediump (10700 ns)
    TCS: [33mTestCase_testScalarModVec3PackedLowp[0m, time elapsed: 190700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3PackedLowp (8300 ns)
    TCS: [33mTestCase_testScalarModVec4PackedMediump[0m, time elapsed: 192300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4PackedMediump (8900 ns)
    TCS: [33mTestCase_testScalarModVec4PackedLowp[0m, time elapsed: 189000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4PackedLowp (7900 ns)
    TCS: [33mTestCase_testScalarDivZeroVec1[0m, time elapsed: 208500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivZeroVec1 (19700 ns)
    TCS: [33mTestCase_testScalarAddNegVec1[0m, time elapsed: 187300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddNegVec1 (9900 ns)
    TCS: [33mTestCase_testScalarAddNegVec2[0m, time elapsed: 186900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddNegVec2 (8300 ns)
    TCS: [33mTestCase_testScalarMulOverflowVec1[0m, time elapsed: 187400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulOverflowVec1 (10600 ns)
    TCS: [33mTestCase_testScalarSubNegVec1[0m, time elapsed: 279500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubNegVec1 (15700 ns)
    TCS: [33mTestCase_testVersionMajor[0m, time elapsed: 253900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionMajor (16600 ns)
    TCS: [33mTestCase_testVersionMinor[0m, time elapsed: 390700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionMinor (20800 ns)
    TCS: [33mTestCase_testVersionPatch[0m, time elapsed: 378600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionPatch (23000 ns)
    TCS: [33mTestCase_testVersionEncoded[0m, time elapsed: 320700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionEncoded (21300 ns)
    TCS: [33mTestCase_testConfigSimd[0m, time elapsed: 303800 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigSimd (29600 ns)
    TCS: [33mTestCase_testConfigAlignedGentypes[0m, time elapsed: 346300 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigAlignedGentypes (13600 ns)
    TCS: [33mTestCase_testConfigClipControl[0m, time elapsed: 222500 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigClipControl (13600 ns)
    TCS: [33mTestCase_testConstNegationSimd[0m, time elapsed: 222100 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationSimd (10800 ns)
    TCS: [33mTestCase_testConstNegationAligned[0m, time elapsed: 216300 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationAligned (9500 ns)
    TCS: [33mTestCase_testConstNegationClip[0m, time elapsed: 212100 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationClip (9300 ns)
    TCS: [33mTestCase_testConstInt64Usage[0m, time elapsed: 204200 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstInt64Usage (10000 ns)
    TCS: [33mTestCase_testConstBoolUsage[0m, time elapsed: 209300 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstBoolUsage (9800 ns)
    TCS: [33mTestCase_testVersionEncodingConsistency[0m, time elapsed: 181300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionEncodingConsistency (7500 ns)
    TCS: [33mTestCase_testAssertPasses[0m, time elapsed: 227100 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertPasses (27700 ns)
    TCS: [33mTestCase_testAssertFails[0m, time elapsed: 271600 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertFails (71600 ns)
    TCS: [33mTestCase_testAssertWithCustomMessage[0m, time elapsed: 244300 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertWithCustomMessage (43700 ns)
    TCS: [33mTestCase_testNumericLimitsFloat32Epsilon[0m, time elapsed: 210400 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsFloat32Epsilon (12700 ns)
    TCS: [33mTestCase_testNumericLimitsFloat64Epsilon[0m, time elapsed: 232200 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsFloat64Epsilon (11700 ns)
    TCS: [33mTestCase_testIsIec559OfFloat32[0m, time elapsed: 207100 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfFloat32 (12300 ns)
    TCS: [33mTestCase_testIsIec559OfFloat64[0m, time elapsed: 211200 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfFloat64 (7900 ns)
    TCS: [33mTestCase_testIsIec559OfInt64[0m, time elapsed: 201100 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfInt64 (13800 ns)
    TCS: [33mTestCase_testEpsilonOfFloat32[0m, time elapsed: 203100 ns, RESULT:
    [[32m PASSED [0m] CASE: testEpsilonOfFloat32 (11700 ns)
    TCS: [33mTestCase_testEpsilonOfFloat64[0m, time elapsed: 204900 ns, RESULT:
    [[32m PASSED [0m] CASE: testEpsilonOfFloat64 (9500 ns)
    TCS: [33mTestCase_testNumericLimitsInt64Epsilon[0m, time elapsed: 203500 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt64Epsilon (13100 ns)
    TCS: [33mTestCase_testNumericLimitsInt32Epsilon[0m, time elapsed: 228400 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt32Epsilon (14800 ns)
    TCS: [33mTestCase_testNumericLimitsInt16Epsilon[0m, time elapsed: 231900 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt16Epsilon (14600 ns)
    TCS: [33mTestCase_testNumericLimitsInt8Epsilon[0m, time elapsed: 321200 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt8Epsilon (34200 ns)
    TCS: [33mTestCase_testCastVec1ToVec1IntToFloat[0m, time elapsed: 330200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec1ToVec1IntToFloat (31500 ns)
    TCS: [33mTestCase_testCastVec2ToVec1TakesOnlyX[0m, time elapsed: 358200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2ToVec1TakesOnlyX (27800 ns)
    TCS: [33mTestCase_testCastVec3ToVec1TakesOnlyX[0m, time elapsed: 314800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3ToVec1TakesOnlyX (28700 ns)
    TCS: [33mTestCase_testCastVec4ToVec1TakesOnlyX[0m, time elapsed: 297300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4ToVec1TakesOnlyX (28000 ns)
    TCS: [33mTestCase_testCastSameTypeIdentity[0m, time elapsed: 282600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastSameTypeIdentity (30500 ns)
    TCS: [33mTestCase_testCastInt32ToInt64[0m, time elapsed: 365600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastInt32ToInt64 (15100 ns)
    TCS: [33mTestCase_testCastFloatToIntTruncation[0m, time elapsed: 276200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastFloatToIntTruncation (10800 ns)
    TCS: [33mTestCase_testCastCrossQualifierPackedHighpToDefaultp[0m, time elapsed: 262800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastCrossQualifierPackedHighpToDefaultp (10800 ns)
    TCS: [33mTestCase_testCastCrossQualifierDefaultpToPackedHighp[0m, time elapsed: 203800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastCrossQualifierDefaultpToPackedHighp (16600 ns)
    TCS: [33mTestCase_testCastVec2CrossQualifierCrossType[0m, time elapsed: 206300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2CrossQualifierCrossType (9400 ns)
    TCS: [33mTestCase_testCastVec3CrossQualifier[0m, time elapsed: 205000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3CrossQualifier (9800 ns)
    TCS: [33mTestCase_testCastVec4CrossQualifier[0m, time elapsed: 204200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4CrossQualifier (13000 ns)
    TCS: [33mTestCase_testCastVec1DoesNotModifySource[0m, time elapsed: 202800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec1DoesNotModifySource (7100 ns)
    TCS: [33mTestCase_testCastVec2Vec1ToVec2IntToFloat[0m, time elapsed: 230100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec1ToVec2IntToFloat (7800 ns)
    TCS: [33mTestCase_testCastVec2Vec2ToVec2Identity[0m, time elapsed: 533300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec2ToVec2Identity (49300 ns)
    TCS: [33mTestCase_testCastVec2Vec3ToVec2TakesOnlyXY[0m, time elapsed: 384700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec3ToVec2TakesOnlyXY (17000 ns)
    TCS: [33mTestCase_testCastVec2Vec4ToVec2TakesOnlyXY[0m, time elapsed: 208700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec4ToVec2TakesOnlyXY (12600 ns)
    TCS: [33mTestCase_testCastVec2SameTypeIdentity[0m, time elapsed: 184600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2SameTypeIdentity (8200 ns)
    TCS: [33mTestCase_testCastVec2Int32ToInt64[0m, time elapsed: 171700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Int32ToInt64 (7300 ns)
    TCS: [33mTestCase_testCastVec2FloatToIntTruncation[0m, time elapsed: 227100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2FloatToIntTruncation (9100 ns)
    TCS: [33mTestCase_testCastVec2CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 269400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2CrossQualifierPackedHighpToDefaultp (11000 ns)
    TCS: [33mTestCase_testCastVec2DoesNotModifySource[0m, time elapsed: 265600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2DoesNotModifySource (13200 ns)
    TCS: [33mTestCase_testCastVec2Vec1ToVec2SameValueBothComponents[0m, time elapsed: 258300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec1ToVec2SameValueBothComponents (10700 ns)
    TCS: [33mTestCase_testCastVec3Vec1ToVec3IntToFloat[0m, time elapsed: 202800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec1ToVec3IntToFloat (17800 ns)
    TCS: [33mTestCase_testCastVec3Vec2ToVec3ExtendY[0m, time elapsed: 195300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec2ToVec3ExtendY (11500 ns)
    TCS: [33mTestCase_testCastVec3Vec3ToVec3Identity[0m, time elapsed: 200800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec3ToVec3Identity (6600 ns)
    TCS: [33mTestCase_testCastVec3Vec4ToVec3TakesOnlyXYZ[0m, time elapsed: 200100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec4ToVec3TakesOnlyXYZ (12000 ns)
    TCS: [33mTestCase_testCastVec3SameTypeIdentity[0m, time elapsed: 200200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3SameTypeIdentity (11100 ns)
    TCS: [33mTestCase_testCastVec3Int32ToInt64[0m, time elapsed: 179600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Int32ToInt64 (7200 ns)
    TCS: [33mTestCase_testCastVec3FloatToIntTruncation[0m, time elapsed: 178400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3FloatToIntTruncation (7200 ns)
    TCS: [33mTestCase_testCastVec3CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 180600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3CrossQualifierPackedHighpToDefaultp (6300 ns)
    TCS: [33mTestCase_testCastVec3DoesNotModifySource[0m, time elapsed: 188900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3DoesNotModifySource (6500 ns)
    TCS: [33mTestCase_testCastVec3Vec1ToVec3SameValueAllComponents[0m, time elapsed: 183100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec1ToVec3SameValueAllComponents (10000 ns)
    TCS: [33mTestCase_testCastVec4Vec1ToVec4IntToFloat[0m, time elapsed: 189700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec1ToVec4IntToFloat (9500 ns)
    TCS: [33mTestCase_testCastVec4Vec2ToVec4ExtendY[0m, time elapsed: 198300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec2ToVec4ExtendY (13500 ns)
    TCS: [33mTestCase_testCastVec4Vec3ToVec4ExtendZ[0m, time elapsed: 185300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec3ToVec4ExtendZ (9300 ns)
    TCS: [33mTestCase_testCastVec4Vec4ToVec4Identity[0m, time elapsed: 187100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec4ToVec4Identity (9400 ns)
    TCS: [33mTestCase_testCastVec4SameTypeIdentity[0m, time elapsed: 184400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4SameTypeIdentity (9400 ns)
    TCS: [33mTestCase_testCastVec4Int32ToInt64[0m, time elapsed: 217800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Int32ToInt64 (8000 ns)
    TCS: [33mTestCase_testCastVec4FloatToIntTruncation[0m, time elapsed: 189000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4FloatToIntTruncation (6800 ns)
    TCS: [33mTestCase_testCastVec4CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 190600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4CrossQualifierPackedHighpToDefaultp (6700 ns)
    TCS: [33mTestCase_testCastVec4DoesNotModifySource[0m, time elapsed: 186000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4DoesNotModifySource (6100 ns)
    TCS: [33mTestCase_testCastVec4Vec1ToVec4SameValueAllComponents[0m, time elapsed: 176900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec1ToVec4SameValueAllComponents (9700 ns)
    TCS: [33mTestCase_testFromBoolVec1[0m, time elapsed: 179300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec1 (7100 ns)
    TCS: [33mTestCase_testFromBoolVec1False[0m, time elapsed: 171400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec1False (5400 ns)
    TCS: [33mTestCase_testFromBoolVec2[0m, time elapsed: 168200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec2 (5700 ns)
    TCS: [33mTestCase_testFromBoolVec3[0m, time elapsed: 170200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec3 (5800 ns)
    TCS: [33mTestCase_testFromBoolVec4[0m, time elapsed: 234000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec4 (5900 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec1[0m, time elapsed: 230500 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec1 (11200 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec2[0m, time elapsed: 293600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec2 (9600 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec3[0m, time elapsed: 300000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec3 (17400 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec4[0m, time elapsed: 213300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec4 (6600 ns)
    TCS: [33mTestCase_testFromBoolVec3AllFalse[0m, time elapsed: 191000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec3AllFalse (6300 ns)
    TCS: [33mTestCase_testFromBoolVec4AllFalse[0m, time elapsed: 169800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec4AllFalse (5600 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec3AllFalse[0m, time elapsed: 169100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec3AllFalse (6000 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec4AllFalse[0m, time elapsed: 164300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec4AllFalse (5600 ns)
    TCS: [33mTestCase_testFromBoolVecFloat32[0m, time elapsed: 161900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecFloat32 (7100 ns)
    TCS: [33mTestCase_testFromBoolVecFloat64[0m, time elapsed: 176600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecFloat64 (12800 ns)
    TCS: [33mTestCase_testFromBoolVecInt32[0m, time elapsed: 166700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecInt32 (7700 ns)
    TCS: [33mTestCase_testFromBoolVecQ2PackedMediump[0m, time elapsed: 173100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2PackedMediump (6300 ns)
    TCS: [33mTestCase_testFromBoolVecQ2PackedLowp[0m, time elapsed: 196500 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2PackedLowp (7100 ns)
    TCS: [33mTestCase_testVec1ConstInit[0m, time elapsed: 185900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ConstInit (10800 ns)
    TCS: [33mTestCase_testVec1Length[0m, time elapsed: 167400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Length (5600 ns)
    TCS: [33mTestCase_testVec1IndexAccess[0m, time elapsed: 186900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1IndexAccess (10600 ns)
    TCS: [33mTestCase_testVec1IndexMutate[0m, time elapsed: 170800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1IndexMutate (5400 ns)
    TCS: [33mTestCase_testVec1ComponentAt[0m, time elapsed: 178600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ComponentAt (9300 ns)
    TCS: [33mTestCase_testVec1Add[0m, time elapsed: 250500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Add (16300 ns)
    TCS: [33mTestCase_testVec1Sub[0m, time elapsed: 282700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Sub (16100 ns)
    TCS: [33mTestCase_testVec1Mul[0m, time elapsed: 173000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Mul (10300 ns)
    TCS: [33mTestCase_testVec1Div[0m, time elapsed: 176300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Div (10000 ns)
    TCS: [33mTestCase_testVec1Mod[0m, time elapsed: 179800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Mod (11100 ns)
    TCS: [33mTestCase_testVec1ScalarAdd[0m, time elapsed: 172200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarAdd (8400 ns)
    TCS: [33mTestCase_testVec1Negate[0m, time elapsed: 171800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Negate (8700 ns)
    TCS: [33mTestCase_testVec1AddNamed[0m, time elapsed: 160000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1AddNamed (5800 ns)
    TCS: [33mTestCase_testVec1SubNamed[0m, time elapsed: 171100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1SubNamed (10600 ns)
    TCS: [33mTestCase_testVec1MulNamed[0m, time elapsed: 164400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1MulNamed (5800 ns)
    TCS: [33mTestCase_testVec1Equal[0m, time elapsed: 170900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Equal (15900 ns)
    TCS: [33mTestCase_testVec1NotEqual[0m, time elapsed: 163500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1NotEqual (5500 ns)
    TCS: [33mTestCase_testVec1EqualExact[0m, time elapsed: 165900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1EqualExact (8600 ns)
    TCS: [33mTestCase_testVec1BitwiseAnd[0m, time elapsed: 165000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BitwiseAnd (8100 ns)
    TCS: [33mTestCase_testVec1BitwiseOr[0m, time elapsed: 167100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BitwiseOr (8200 ns)
    TCS: [33mTestCase_testVec1BitwiseXor[0m, time elapsed: 177100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BitwiseXor (11700 ns)
    TCS: [33mTestCase_testVec1ShiftLeft[0m, time elapsed: 168900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ShiftLeft (8200 ns)
    TCS: [33mTestCase_testVec1ShiftRight[0m, time elapsed: 180900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ShiftRight (8100 ns)
    TCS: [33mTestCase_testVec1BitwiseNot[0m, time elapsed: 161200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BitwiseNot (5500 ns)
    TCS: [33mTestCase_testVec1BoolLogicalAnd[0m, time elapsed: 174100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BoolLogicalAnd (9000 ns)
    TCS: [33mTestCase_testVec1BoolLogicalOr[0m, time elapsed: 180900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BoolLogicalOr (5500 ns)
    TCS: [33mTestCase_testVec1IndexOutOfBoundsAccess[0m, time elapsed: 243500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1IndexOutOfBoundsAccess (69700 ns)
    TCS: [33mTestCase_testVec1ShiftVec[0m, time elapsed: 173800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ShiftVec (5400 ns)
    TCS: [33mTestCase_testVec1ScalarSub[0m, time elapsed: 172000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarSub (5300 ns)
    TCS: [33mTestCase_testVec1ScalarMul[0m, time elapsed: 169400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarMul (5800 ns)
    TCS: [33mTestCase_testVec1ScalarDiv[0m, time elapsed: 172000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarDiv (5700 ns)
    TCS: [33mTestCase_testVec1ScalarMod[0m, time elapsed: 172100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarMod (8700 ns)
    TCS: [33mTestCase_testVec1DivNamed[0m, time elapsed: 171700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1DivNamed (5400 ns)
    TCS: [33mTestCase_testVec1ModNamed[0m, time elapsed: 169900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ModNamed (5800 ns)
    TCS: [33mTestCase_testVec1ScalarBitwiseAnd[0m, time elapsed: 173100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarBitwiseAnd (10600 ns)
    TCS: [33mTestCase_testVec1ScalarBitwiseOr[0m, time elapsed: 174400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarBitwiseOr (7700 ns)
    TCS: [33mTestCase_testVec1ScalarBitwiseXor[0m, time elapsed: 167400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarBitwiseXor (6000 ns)
    TCS: [33mTestCase_testVec1ShiftRightVec[0m, time elapsed: 173100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ShiftRightVec (5400 ns)
    TCS: [33mTestCase_testVec1EqualEpsilon[0m, time elapsed: 176100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1EqualEpsilon (11800 ns)
    TCS: [33mTestCase_testVec1BroadcastAddVec2[0m, time elapsed: 174400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastAddVec2 (10600 ns)
    TCS: [33mTestCase_testVec1BroadcastBitAndVec2[0m, time elapsed: 264400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastBitAndVec2 (11100 ns)
    TCS: [33mTestCase_testVec1BroadcastAddVec3[0m, time elapsed: 176100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastAddVec3 (10200 ns)
    TCS: [33mTestCase_testVec1BroadcastAddVec4[0m, time elapsed: 178900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastAddVec4 (15900 ns)
    TCS: [33mTestCase_testVec1BroadcastBitOrVec2[0m, time elapsed: 170300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastBitOrVec2 (6100 ns)
    TCS: [33mTestCase_testVec1BroadcastBitXorVec2[0m, time elapsed: 177100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastBitXorVec2 (10300 ns)
    TCS: [33mTestCase_testVec1BroadcastShiftLeftVec2[0m, time elapsed: 180000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastShiftLeftVec2 (6700 ns)
    TCS: [33mTestCase_testVec1BroadcastShiftRightVec2[0m, time elapsed: 175600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastShiftRightVec2 (5800 ns)
    TCS: [33mTestCase_testVec1BroadcastBitAndVec3[0m, time elapsed: 172600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastBitAndVec3 (9200 ns)
    TCS: [33mTestCase_testVec1BroadcastBitAndVec4[0m, time elapsed: 175000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastBitAndVec4 (14600 ns)
    TCS: [33mTestCase_testVec1BroadcastModVec2[0m, time elapsed: 170200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastModVec2 (8900 ns)
    TCS: [33mTestCase_testVec1BroadcastModVec3[0m, time elapsed: 173800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastModVec3 (9700 ns)
    TCS: [33mTestCase_testVec1BroadcastModVec4[0m, time elapsed: 173600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastModVec4 (10800 ns)
    TCS: [33mTestCase_testVec1Increment[0m, time elapsed: 172300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Increment (8300 ns)
    TCS: [33mTestCase_testVec1Decrement[0m, time elapsed: 180900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Decrement (9100 ns)
    TCS: [33mTestCase_testVec2ScalarInit[0m, time elapsed: 186300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarInit (10300 ns)
    TCS: [33mTestCase_testVec2ConstInit[0m, time elapsed: 168700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ConstInit (7700 ns)
    TCS: [33mTestCase_testVec2Length[0m, time elapsed: 160100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Length (5100 ns)
    TCS: [33mTestCase_testVec2Add[0m, time elapsed: 169900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Add (9900 ns)
    TCS: [33mTestCase_testVec2Sub[0m, time elapsed: 168000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Sub (9200 ns)
    TCS: [33mTestCase_testVec2Mul[0m, time elapsed: 168900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Mul (12700 ns)
    TCS: [33mTestCase_testVec2ScalarAdd[0m, time elapsed: 167600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarAdd (7900 ns)
    TCS: [33mTestCase_testVec2Negate[0m, time elapsed: 169200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Negate (8400 ns)
    TCS: [33mTestCase_testVec2IndexAccess[0m, time elapsed: 168000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2IndexAccess (6100 ns)
    TCS: [33mTestCase_testVec2IndexMutate[0m, time elapsed: 336100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2IndexMutate (17100 ns)
    TCS: [33mTestCase_testVec2ComponentAt[0m, time elapsed: 314500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ComponentAt (19000 ns)
    TCS: [33mTestCase_testVec2Equal[0m, time elapsed: 289200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Equal (20900 ns)
    TCS: [33mTestCase_testVec2NotEqual[0m, time elapsed: 398000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2NotEqual (24900 ns)
    TCS: [33mTestCase_testVec2EqualExact[0m, time elapsed: 371600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2EqualExact (25500 ns)
    TCS: [33mTestCase_testVec2BitwiseAnd[0m, time elapsed: 311200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseAnd (21600 ns)
    TCS: [33mTestCase_testVec2BitwiseNot[0m, time elapsed: 1339300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseNot (13500 ns)
    TCS: [33mTestCase_testVec2FromVec1[0m, time elapsed: 351100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2FromVec1 (15700 ns)
    TCS: [33mTestCase_testVec2ShiftLeft[0m, time elapsed: 372700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeft (25600 ns)
    TCS: [33mTestCase_testVec2BoolLogicalAnd[0m, time elapsed: 441700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BoolLogicalAnd (31900 ns)
    TCS: [33mTestCase_testVec2Vec1ArithBroadcast[0m, time elapsed: 446500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Vec1ArithBroadcast (35200 ns)
    TCS: [33mTestCase_testVec2Vec1BitBroadcast[0m, time elapsed: 389700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Vec1BitBroadcast (30300 ns)
    TCS: [33mTestCase_testVec2ShiftLeftVec1[0m, time elapsed: 371100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeftVec1 (24300 ns)
    TCS: [33mTestCase_testVec2Div[0m, time elapsed: 344300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Div (29300 ns)
    TCS: [33mTestCase_testVec2Mod[0m, time elapsed: 354500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Mod (21400 ns)
    TCS: [33mTestCase_testVec2ScalarSub[0m, time elapsed: 323600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarSub (21200 ns)
    TCS: [33mTestCase_testVec2ScalarMul[0m, time elapsed: 282500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarMul (14900 ns)
    TCS: [33mTestCase_testVec2ScalarDiv[0m, time elapsed: 272400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarDiv (15100 ns)
    TCS: [33mTestCase_testVec2ScalarMod[0m, time elapsed: 293200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarMod (17500 ns)
    TCS: [33mTestCase_testVec2BoolLogicalOr[0m, time elapsed: 307800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BoolLogicalOr (14000 ns)
    TCS: [33mTestCase_testVec2EqualEpsilon[0m, time elapsed: 357800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2EqualEpsilon (30100 ns)
    TCS: [33mTestCase_testVec2DivNamed[0m, time elapsed: 313700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2DivNamed (14100 ns)
    TCS: [33mTestCase_testVec2ModNamed[0m, time elapsed: 305700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ModNamed (13000 ns)
    TCS: [33mTestCase_testVec2BitwiseOr[0m, time elapsed: 318600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseOr (18800 ns)
    TCS: [33mTestCase_testVec2BitwiseXor[0m, time elapsed: 315500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseXor (24600 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseAnd[0m, time elapsed: 358400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseAnd (18100 ns)
    TCS: [33mTestCase_testVec2ShiftRight[0m, time elapsed: 292300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRight (17000 ns)
    TCS: [33mTestCase_testVec2ShiftRightVec1[0m, time elapsed: 272700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRightVec1 (14000 ns)
    TCS: [33mTestCase_testVec2AddNamed[0m, time elapsed: 287000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2AddNamed (13300 ns)
    TCS: [33mTestCase_testVec2SubNamed[0m, time elapsed: 248300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2SubNamed (15200 ns)
    TCS: [33mTestCase_testVec2MulNamed[0m, time elapsed: 189400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2MulNamed (7800 ns)
    TCS: [33mTestCase_testVec2ShiftLeftVec[0m, time elapsed: 193700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeftVec (7700 ns)
    TCS: [33mTestCase_testVec2ShiftRightVec[0m, time elapsed: 193300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRightVec (7700 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseOr[0m, time elapsed: 207600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseOr (14200 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseXor[0m, time elapsed: 193100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseXor (10800 ns)
    TCS: [33mTestCase_testVec2Increment[0m, time elapsed: 213600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Increment (16500 ns)
    TCS: [33mTestCase_testVec2Decrement[0m, time elapsed: 217500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Decrement (15000 ns)
    TCS: [33mTestCase_testVec2IndexOutOfBoundsAccess[0m, time elapsed: 297800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2IndexOutOfBoundsAccess (62500 ns)
    TCS: [33mTestCase_testVec2NegativeIndexAccess[0m, time elapsed: 231500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2NegativeIndexAccess (39400 ns)
    TCS: [33mTestCase_testVec3ScalarInit[0m, time elapsed: 220900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarInit (16400 ns)
    TCS: [33mTestCase_testVec3ConstInit[0m, time elapsed: 180200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ConstInit (5800 ns)
    TCS: [33mTestCase_testVec3Length[0m, time elapsed: 168900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Length (5300 ns)
    TCS: [33mTestCase_testVec3Add[0m, time elapsed: 181500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Add (13500 ns)
    TCS: [33mTestCase_testVec3ScalarMul[0m, time elapsed: 187500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarMul (14400 ns)
    TCS: [33mTestCase_testVec3Negate[0m, time elapsed: 174900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Negate (9600 ns)
    TCS: [33mTestCase_testVec3IndexAccess[0m, time elapsed: 177300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3IndexAccess (8600 ns)
    TCS: [33mTestCase_testVec3IndexMutate[0m, time elapsed: 176300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3IndexMutate (9600 ns)
    TCS: [33mTestCase_testVec3ComponentAt[0m, time elapsed: 180500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ComponentAt (7400 ns)
    TCS: [33mTestCase_testVec3Equal[0m, time elapsed: 203700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Equal (19100 ns)
    TCS: [33mTestCase_testVec3NotEqual[0m, time elapsed: 199800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3NotEqual (15100 ns)
    TCS: [33mTestCase_testVec3EqualExact[0m, time elapsed: 211500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3EqualExact (11300 ns)
    TCS: [33mTestCase_testVec3BitwiseAnd[0m, time elapsed: 214800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseAnd (20800 ns)
    TCS: [33mTestCase_testVec3BitwiseNot[0m, time elapsed: 206200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseNot (9100 ns)
    TCS: [33mTestCase_testVec3Vec1ArithBroadcast[0m, time elapsed: 217100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1ArithBroadcast (17100 ns)
    TCS: [33mTestCase_testVec3ShiftLeft[0m, time elapsed: 181900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeft (11000 ns)
    TCS: [33mTestCase_testVec3BoolLogicalAnd[0m, time elapsed: 182900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BoolLogicalAnd (9600 ns)
    TCS: [33mTestCase_testVec3Sub[0m, time elapsed: 184300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Sub (10500 ns)
    TCS: [33mTestCase_testVec3Div[0m, time elapsed: 194800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Div (14500 ns)
    TCS: [33mTestCase_testVec3Mod[0m, time elapsed: 184500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Mod (10800 ns)
    TCS: [33mTestCase_testVec3ScalarSub[0m, time elapsed: 175500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarSub (9000 ns)
    TCS: [33mTestCase_testVec3ScalarDiv[0m, time elapsed: 183000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarDiv (10200 ns)
    TCS: [33mTestCase_testVec3ScalarMod[0m, time elapsed: 179800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarMod (8700 ns)
    TCS: [33mTestCase_testVec3BoolLogicalOr[0m, time elapsed: 179000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BoolLogicalOr (9500 ns)
    TCS: [33mTestCase_testVec3EqualEpsilon[0m, time elapsed: 189600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3EqualEpsilon (15900 ns)
    TCS: [33mTestCase_testVec3AddNamed[0m, time elapsed: 181600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3AddNamed (9600 ns)
    TCS: [33mTestCase_testVec3MulNamed[0m, time elapsed: 184700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3MulNamed (6400 ns)
    TCS: [33mTestCase_testVec3DivNamed[0m, time elapsed: 175400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3DivNamed (5600 ns)
    TCS: [33mTestCase_testVec3ModNamed[0m, time elapsed: 217900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ModNamed (6000 ns)
    TCS: [33mTestCase_testVec3BitwiseOr[0m, time elapsed: 200900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseOr (18900 ns)
    TCS: [33mTestCase_testVec3BitwiseXor[0m, time elapsed: 200200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseXor (12900 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseAnd[0m, time elapsed: 187600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseAnd (10000 ns)
    TCS: [33mTestCase_testVec3ShiftRight[0m, time elapsed: 193800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRight (12400 ns)
    TCS: [33mTestCase_testVec3Vec1BitBroadcast[0m, time elapsed: 201400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitBroadcast (13800 ns)
    TCS: [33mTestCase_testVec3ShiftRightVec1[0m, time elapsed: 193500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRightVec1 (15900 ns)
    TCS: [33mTestCase_testVec3FromVec1[0m, time elapsed: 186100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3FromVec1 (6700 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseOr[0m, time elapsed: 193000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseOr (11100 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseXor[0m, time elapsed: 183400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseXor (10000 ns)
    TCS: [33mTestCase_testVec3Vec1BitOrBroadcast[0m, time elapsed: 190800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitOrBroadcast (10200 ns)
    TCS: [33mTestCase_testVec3Vec1BitXorBroadcast[0m, time elapsed: 212400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitXorBroadcast (11500 ns)
    TCS: [33mTestCase_testVec3ShiftLeftVec1[0m, time elapsed: 216100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeftVec1 (33700 ns)
    TCS: [33mTestCase_testVec3ShiftLeftVec[0m, time elapsed: 240800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeftVec (6800 ns)
    TCS: [33mTestCase_testVec3ShiftRightVec[0m, time elapsed: 183000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRightVec (9200 ns)
    TCS: [33mTestCase_testVec3Increment[0m, time elapsed: 199800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Increment (14200 ns)
    TCS: [33mTestCase_testVec3Decrement[0m, time elapsed: 370100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Decrement (26700 ns)
    TCS: [33mTestCase_testVec3IndexOutOfBoundsAccess[0m, time elapsed: 436700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3IndexOutOfBoundsAccess (116300 ns)
    TCS: [33mTestCase_testVec3NegativeIndexAccess[0m, time elapsed: 275200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3NegativeIndexAccess (29300 ns)
    TCS: [33mTestCase_testVec4ScalarInit[0m, time elapsed: 216100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarInit (16800 ns)
    TCS: [33mTestCase_testVec4ConstInit[0m, time elapsed: 490300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ConstInit (29600 ns)
    TCS: [33mTestCase_testVec4Length[0m, time elapsed: 518500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Length (23000 ns)
    TCS: [33mTestCase_testVec4Add[0m, time elapsed: 397000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Add (39300 ns)
    TCS: [33mTestCase_testVec4ScalarMul[0m, time elapsed: 328500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarMul (22600 ns)
    TCS: [33mTestCase_testVec4Negate[0m, time elapsed: 255000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Negate (14600 ns)
    TCS: [33mTestCase_testVec4IndexAccess[0m, time elapsed: 243000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4IndexAccess (16400 ns)
    TCS: [33mTestCase_testVec4IndexMutate[0m, time elapsed: 228600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4IndexMutate (7500 ns)
    TCS: [33mTestCase_testVec4ComponentAt[0m, time elapsed: 220100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ComponentAt (7600 ns)
    TCS: [33mTestCase_testVec4Equal[0m, time elapsed: 226000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Equal (22500 ns)
    TCS: [33mTestCase_testVec4NotEqual[0m, time elapsed: 203000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4NotEqual (10200 ns)
    TCS: [33mTestCase_testVec4EqualExact[0m, time elapsed: 198900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4EqualExact (12400 ns)
    TCS: [33mTestCase_testVec4BitwiseAnd[0m, time elapsed: 215200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseAnd (13900 ns)
    TCS: [33mTestCase_testVec4BitwiseNot[0m, time elapsed: 215700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseNot (6900 ns)
    TCS: [33mTestCase_testVec4Vec1ArithBroadcast[0m, time elapsed: 226000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1ArithBroadcast (20500 ns)
    TCS: [33mTestCase_testVec4ShiftLeft[0m, time elapsed: 214900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeft (13500 ns)
    TCS: [33mTestCase_testVec4BoolLogicalAnd[0m, time elapsed: 211600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BoolLogicalAnd (11900 ns)
    TCS: [33mTestCase_testVec4Sub[0m, time elapsed: 208600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Sub (13800 ns)
    TCS: [33mTestCase_testVec4Div[0m, time elapsed: 212400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Div (14100 ns)
    TCS: [33mTestCase_testVec4Mod[0m, time elapsed: 204400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Mod (12300 ns)
    TCS: [33mTestCase_testVec4ScalarSub[0m, time elapsed: 215400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarSub (17800 ns)
    TCS: [33mTestCase_testVec4ScalarDiv[0m, time elapsed: 209600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarDiv (12000 ns)
    TCS: [33mTestCase_testVec4ScalarMod[0m, time elapsed: 214600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarMod (11800 ns)
    TCS: [33mTestCase_testVec4BoolLogicalOr[0m, time elapsed: 192700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BoolLogicalOr (7400 ns)
    TCS: [33mTestCase_testVec4EqualEpsilon[0m, time elapsed: 252400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4EqualEpsilon (17600 ns)
    TCS: [33mTestCase_testVec4AddNamed[0m, time elapsed: 192800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4AddNamed (13300 ns)
    TCS: [33mTestCase_testVec4MulNamed[0m, time elapsed: 194600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4MulNamed (7100 ns)
    TCS: [33mTestCase_testVec4DivNamed[0m, time elapsed: 180200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4DivNamed (6100 ns)
    TCS: [33mTestCase_testVec4ModNamed[0m, time elapsed: 176400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ModNamed (6500 ns)
    TCS: [33mTestCase_testVec4BitwiseOr[0m, time elapsed: 194500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseOr (12300 ns)
    TCS: [33mTestCase_testVec4BitwiseXor[0m, time elapsed: 182900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseXor (14500 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseAnd[0m, time elapsed: 178300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseAnd (9000 ns)
    TCS: [33mTestCase_testVec4ShiftRight[0m, time elapsed: 175800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRight (9000 ns)
    TCS: [33mTestCase_testVec4Vec1BitBroadcast[0m, time elapsed: 179100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitBroadcast (12700 ns)
    TCS: [33mTestCase_testVec4ShiftRightVec1[0m, time elapsed: 186600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRightVec1 (9000 ns)
    TCS: [33mTestCase_testVec4FromVec1[0m, time elapsed: 174300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4FromVec1 (5800 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseOr[0m, time elapsed: 196700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseOr (10300 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseXor[0m, time elapsed: 184400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseXor (10500 ns)
    TCS: [33mTestCase_testVec4Vec1BitOrBroadcast[0m, time elapsed: 178200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitOrBroadcast (10100 ns)
    TCS: [33mTestCase_testVec4Vec1BitXorBroadcast[0m, time elapsed: 190400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitXorBroadcast (10100 ns)
    TCS: [33mTestCase_testVec4ShiftLeftVec1[0m, time elapsed: 199500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeftVec1 (12000 ns)
    TCS: [33mTestCase_testVec4ShiftLeftVec[0m, time elapsed: 200200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeftVec (16100 ns)
    TCS: [33mTestCase_testVec4ShiftRightVec[0m, time elapsed: 191500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRightVec (13300 ns)
    TCS: [33mTestCase_testVec4Increment[0m, time elapsed: 209700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Increment (17300 ns)
    TCS: [33mTestCase_testVec4Decrement[0m, time elapsed: 333500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Decrement (25500 ns)
    TCS: [33mTestCase_testVec4IndexOutOfBoundsAccess[0m, time elapsed: 323300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4IndexOutOfBoundsAccess (60200 ns)
    TCS: [33mTestCase_testVec4NegativeIndexAccess[0m, time elapsed: 202300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4NegativeIndexAccess (24100 ns)
    TCS: [33mTestCase_testFunctor1Vec1Identity[0m, time elapsed: 203400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec1Identity (11300 ns)
    TCS: [33mTestCase_testFunctor1Vec1Transform[0m, time elapsed: 189100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec1Transform (10800 ns)
    TCS: [33mTestCase_testFunctor1Vec2Transform[0m, time elapsed: 187900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec2Transform (13800 ns)
    TCS: [33mTestCase_testFunctor2Vec1Add[0m, time elapsed: 224300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec1Add (9500 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec1Mul[0m, time elapsed: 196500 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec1Mul (13400 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec1Shift[0m, time elapsed: 186700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec1Shift (9400 ns)
    TCS: [33mTestCase_testFunctor1Vec3Transform[0m, time elapsed: 215500 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec3Transform (13600 ns)
    TCS: [33mTestCase_testFunctor1Vec4Transform[0m, time elapsed: 225400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec4Transform (13300 ns)
    TCS: [33mTestCase_testFunctor2Vec2Add[0m, time elapsed: 212900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec2Add (12200 ns)
    TCS: [33mTestCase_testFunctor2Vec3Add[0m, time elapsed: 196300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec3Add (10400 ns)
    TCS: [33mTestCase_testFunctor2Vec4Add[0m, time elapsed: 252800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec4Add (17000 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec2Mul[0m, time elapsed: 208200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec2Mul (10200 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec3Mul[0m, time elapsed: 218200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec3Mul (14100 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec4Mul[0m, time elapsed: 254700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec4Mul (14600 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec2Shift[0m, time elapsed: 201400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec2Shift (11600 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec3Shift[0m, time elapsed: 196300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec3Shift (8300 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec4Shift[0m, time elapsed: 199800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec4Shift (9500 ns)
Summary: TOTAL: 476
    [32mPASSED[0m: 476, [32mSKIPPED[0m: 0, ERROR: 0
    [31mFAILED[0m: 0
--------------------------------------------------------------------------------------------------
Project tests finished, time elapsed: 176747300 ns, RESULT:
TP: [33mglm[0m.*, time elapsed: 176663800 ns, RESULT:
    PASSED:
    TP: [33mglm.detail[0m, time elapsed: 161489100 ns
Summary: TOTAL: 476
    [32mPASSED[0m: 476, [32mSKIPPED[0m: 0, ERROR: 0
    [31mFAILED[0m: 0
--------------------------------------------------------------------------------------------------
[0J7[;r8[?25hcjpm test success
