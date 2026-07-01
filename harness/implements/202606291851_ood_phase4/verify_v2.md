# 验证报告（v2）

## 结果
FAILED

## 统计
- 通过：428
- 失败：0
- 错误：7
- 跳过：0

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

warning: unused variable:'y'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:5:38:
  | 
5 | public func dot<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
  |                                      ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:6:23:
  | 
6 | public func sin<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
  |                       ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:6:23:
  | 
6 | public func dot<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
  |                       ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'y'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:6:38:
  | 
6 | public func dot<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
  |                                      ^ unused variable
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

warning: unused variable:'x'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:8:23:
  | 
8 | public func dot<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
  |                       ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:8:23:
  | 
8 | public func sin<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
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

warning: unused variable:'v'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:11:29:
   | 
11 | public func normalize<T, Q>(v: Vec3<T, Q>): Vec3<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                             ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:12:23:
   | 
12 | public func cos<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                       ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'v'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:12:29:
   | 
12 | public func normalize<T, Q>(v: Vec4<T, Q>): Vec4<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                             ^ unused variable
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

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:14:23:
   | 
14 | public func cos<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
   |                       ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'v'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:14:26:
   | 
14 | public func length<T, Q>(v: Vec3<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                          ^ unused variable
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

warning: unused variable:'p0'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:16:28:
   | 
16 | public func distance<T, Q>(p0: Vec2<T, Q>, p1: Vec2<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
   |                            ^^ unused variable
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:143:58:
    | 
143 |     public static func fromMat<SrcQ>(m: Mat2x2<T, SrcQ>, one: T): Mat2x4<T, Q>
    |                                                          ^^^ unused variable
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:155:58:
    | 
155 |     public static func fromMat<SrcQ>(m: Mat3x2<T, SrcQ>, one: T): Mat2x4<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:161:58:
    | 
161 |     public static func fromMat<SrcQ>(m: Mat3x3<T, SrcQ>, one: T): Mat2x4<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:167:58:
    | 
167 |     public static func fromMat<SrcQ>(m: Mat3x3<T, SrcQ>, one: T): Mat3x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x4.cj:173:58:
    | 
173 |     public static func fromMat<SrcQ>(m: Mat3x3<T, SrcQ>, one: T): Mat3x4<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:176:58:
    | 
176 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat2x3<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:178:58:
    | 
178 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat2x4<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x3.cj:185:58:
    | 
185 |     public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat4x3<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:187:58:
    | 
187 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat3x3<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:212:71:
    | 
212 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat3x4<U, P>, one: T): Mat2x3<T, Q>
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

215 warnings generated, 215 warnings printed.
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
40 | public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T, k: Int64): Quat<T, Q>
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'y'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_common.cj:40:40:
   | 
40 | public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T, k: Int64): Quat<T, Q>
   |                                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'a'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_common.cj:40:55:
   | 
40 | public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T, k: Int64): Quat<T, Q>
   |                                                       ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'k'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_common.cj:40:61:
   | 
40 | public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T, k: Int64): Quat<T, Q>
   |                                                             ^ unused variable
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

warning: unused variable:'m'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:23:25:
   | 
23 | public func scale<T, Q>(m: Mat4x4<T, Q>, v: Vec3<T, Q>): Mat4x4<T, Q>
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:23:31:
   | 
23 | public func eulerAngles<T, Q>(x: Quat<T, Q>): Vec3<T, Q>
   |                               ^ unused variable
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
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:27:24:
   | 
27 | public func roll<T, Q>(q: Quat<T, Q>): T
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
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:31:25:
   | 
31 | public func pitch<T, Q>(q: Quat<T, Q>): T
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
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:35:23:
   | 
35 | public func yaw<T, Q>(q: Quat<T, Q>): T
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

warning: unused variable:'eye'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:39:28:
   | 
39 | public func lookAtRH<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>
   |                            ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'direction'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:39:30:
   | 
39 | public func quatLookAt<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
   |                              ^^^^^^^^^ unused variable
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
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:39:53:
   | 
39 | public func quatLookAt<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
   |                                                     ^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'up'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:39:65:
   | 
39 | public func lookAtRH<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>
   |                                                                 ^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'eye'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:43:28:
   | 
43 | public func lookAtLH<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>
   |                            ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'direction'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:43:32:
   | 
43 | public func quatLookAtRH<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
   |                                ^^^^^^^^^ unused variable
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
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:43:55:
   | 
43 | public func quatLookAtRH<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
   |                                                       ^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'up'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:43:65:
   | 
43 | public func lookAtLH<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>
   |                                                                 ^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'eye'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:47:26:
   | 
47 | public func lookAt<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>
   |                          ^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'direction'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:47:32:
   | 
47 | public func quatLookAtLH<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
   |                                ^^^^^^^^^ unused variable
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
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:47:55:
   | 
47 | public func quatLookAtLH<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
   |                                                       ^^ unused variable
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

warning: imported decl 'Quat' is shadowed, it will be ignored by compiler
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:10:27:
   | 
10 | public import glm.detail.{Quat, mat3Cast, mat4Cast, quatCast}
   |                           ^^^^ 
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note: 'Quat' is declared here
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:327:13:
    | 
327 | public type Quat = detail.Quat<Float32, PackedHighp>
    |             ^^^^ 
    | 

5 warnings generated, 5 warnings printed.
[?25l78
7878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:00)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:00)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:00) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:00)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:00)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:00) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:00)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:00)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:01) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:01)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:01)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:01) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:01)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:01)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:01) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:02)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:01)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:02) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:02)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:02)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:02) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:02)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:02)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:02) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:03)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:02)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:03) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:03)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:03)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:03) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:03)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:03)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:03) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:04)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:04)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:04) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:04)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:04)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:04) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:04)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:04)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:04) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:05)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:05)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:05) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:05)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:05)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:05) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:05)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:05)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:06) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:06)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:06)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:06) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:06)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:06)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:06) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:07)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:06)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:07) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:07)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:07)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:07) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:07)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:07)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:07) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:08)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:07)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:08) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:08)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:08)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:08) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:08)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:08)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:08) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:09)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:09)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:09) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:09)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:09)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:09) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:09)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:09)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:09) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:10)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:10)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:10) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:10)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:10)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:10) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:10)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:10)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:11) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:11)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:11)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:11) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:11)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:11)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:11) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:12)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:11)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:12) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:12)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:12)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:12) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:12)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:12)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:12) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:13)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:12)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:13) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:13)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:13)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:13) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:13)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:13)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:13) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:14)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:14)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:14) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:14)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:14)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:14) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:14)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:14)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:14) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:15)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:15)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:15) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:15)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:15)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:15) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:15)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:15)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:16) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:16)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:16)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:16) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:16)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:16)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:16) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:17)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:16)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:17) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:17)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:17)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:17) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:17)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:17)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:17) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:18)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:18)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:18) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:18)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:18)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:18) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:18)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:18)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:18) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:19)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:19)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:19) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:19)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:19)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:19) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:19)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:19)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:20) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:20)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:20)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:20) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:20)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:20)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:20) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:20)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:20)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:21) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:21)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:21)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:21) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:21)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:21)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:21) 878



7📦 group glm.detail                   60% [||||||||||||--------]      (00:00:22)
🧪 test TestCase_testS1QuatCastScalingXBranch.testS1QuatCastS...      (00:00:21)

passed: 263, failed: 0             60% [||||||||||||--------] 263/435 (00:00:22) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:22)
🧪 test TestCase_testS1QuatCastScalingYBranch.testS1QuatCastS...      (00:00:00)
   ERROR .TestCase_testS1QuatCastScalingXBranch.testS1...
passed: 263, failed: 1             60% [||||||||||||--------] 264/435 (00:00:22) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:22)
🧪 test TestCase_testS1QuatCastScalingYBranch.testS1QuatCastS...      (00:00:00)
   ERROR .TestCase_testS1QuatCastScalingXBranch.testS1...
passed: 263, failed: 1             60% [||||||||||||--------] 264/435 (00:00:22) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:23)
🧪 test TestCase_testS1QuatCastScalingYBranch.testS1QuatCastS...      (00:00:01)
   ERROR .TestCase_testS1QuatCastScalingXBranch.testS1...
passed: 263, failed: 1             60% [||||||||||||--------] 264/435 (00:00:23) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:23)
🧪 test TestCase_testS1QuatCastScalingYBranch.testS1QuatCastS...      (00:00:01)
   ERROR .TestCase_testS1QuatCastScalingXBranch.testS1...
passed: 263, failed: 1             60% [||||||||||||--------] 264/435 (00:00:23) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:23)
🧪 test TestCase_testS1QuatCastScalingYBranch.testS1QuatCastS...      (00:00:01)
   ERROR .TestCase_testS1QuatCastScalingXBranch.testS1...
passed: 263, failed: 1             60% [||||||||||||--------] 264/435 (00:00:23) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:24)
🧪 test TestCase_testS1QuatCastScalingYBranch.testS1QuatCastS...      (00:00:02)
   ERROR .TestCase_testS1QuatCastScalingXBranch.testS1...
passed: 263, failed: 1             60% [||||||||||||--------] 264/435 (00:00:24) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:24)
🧪 test TestCase_testS1QuatCastScalingYBranch.testS1QuatCastS...      (00:00:02)
   ERROR .TestCase_testS1QuatCastScalingXBranch.testS1...
passed: 263, failed: 1             60% [||||||||||||--------] 264/435 (00:00:24) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:24)
🧪 test TestCase_testS1QuatCastScalingYBranch.testS1QuatCastS...      (00:00:02)
   ERROR .TestCase_testS1QuatCastScalingXBranch.testS1...
passed: 263, failed: 1             60% [||||||||||||--------] 264/435 (00:00:25) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:25)
🧪 test TestCase_testS1QuatCastScalingYBranch.testS1QuatCastS...      (00:00:03)
   ERROR .TestCase_testS1QuatCastScalingXBranch.testS1...
passed: 263, failed: 1             60% [||||||||||||--------] 264/435 (00:00:25) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:25)
🧪 test TestCase_testS1QuatCastScalingYBranch.testS1QuatCastS...      (00:00:03)
   ERROR .TestCase_testS1QuatCastScalingXBranch.testS1...
passed: 263, failed: 1             60% [||||||||||||--------] 264/435 (00:00:25) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:26)
🧪 test TestCase_testS1QuatCastScalingYBranch.testS1QuatCastS...      (00:00:03)
   ERROR .TestCase_testS1QuatCastScalingXBranch.testS1...
passed: 263, failed: 1             60% [||||||||||||--------] 264/435 (00:00:26) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:26)
🧪 test TestCase_testS1QuatCastScalingYBranch.testS1QuatCastS...      (00:00:04)
   ERROR .TestCase_testS1QuatCastScalingXBranch.testS1...
passed: 263, failed: 1             60% [||||||||||||--------] 264/435 (00:00:26) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:26)
🧪 test TestCase_testS1QuatCastScalingYBranch.testS1QuatCastS...      (00:00:04)
   ERROR .TestCase_testS1QuatCastScalingXBranch.testS1...
passed: 263, failed: 1             60% [||||||||||||--------] 264/435 (00:00:26) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:27)
🧪 test TestCase_testS1QuatCastScalingYBranch.testS1QuatCastS...      (00:00:05)
   ERROR .TestCase_testS1QuatCastScalingXBranch.testS1...
passed: 263, failed: 1             60% [||||||||||||--------] 264/435 (00:00:27) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:27)
🧪 test TestCase_testS1QuatCastScalingYBranch.testS1QuatCastS...      (00:00:05)
   ERROR .TestCase_testS1QuatCastScalingXBranch.testS1...
passed: 263, failed: 1             60% [||||||||||||--------] 264/435 (00:00:27) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:27)
🧪 test TestCase_testS1QuatCastScalingYBranch.testS1QuatCastS...      (00:00:05)
   ERROR .TestCase_testS1QuatCastScalingXBranch.testS1...
passed: 263, failed: 1             60% [||||||||||||--------] 264/435 (00:00:27) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:28)
🧪 test TestCase_testS1QuatCastScalingYBranch.testS1QuatCastS...      (00:00:06)
   ERROR .TestCase_testS1QuatCastScalingXBranch.testS1...
passed: 263, failed: 1             60% [||||||||||||--------] 264/435 (00:00:28) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:28)
🧪 test TestCase_testS1QuatCastScalingYBranch.testS1QuatCastS...      (00:00:06)
   ERROR .TestCase_testS1QuatCastScalingXBranch.testS1...
passed: 263, failed: 1             60% [||||||||||||--------] 264/435 (00:00:28) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:28)
🧪 test TestCase_testS1QuatCastScalingYBranch.testS1QuatCastS...      (00:00:06)
   ERROR .TestCase_testS1QuatCastScalingXBranch.testS1...
passed: 263, failed: 1             60% [||||||||||||--------] 264/435 (00:00:28) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:29)
🧪 test TestCase_testS1QuatCastScalingYBranch.testS1QuatCastS...      (00:00:07)
   ERROR .TestCase_testS1QuatCastScalingXBranch.testS1...
passed: 263, failed: 1             60% [||||||||||||--------] 264/435 (00:00:29) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:29)
🧪 test TestCase_testS1QuatCastScalingYBranch.testS1QuatCastS...      (00:00:07)
   ERROR .TestCase_testS1QuatCastScalingXBranch.testS1...
passed: 263, failed: 1             60% [||||||||||||--------] 264/435 (00:00:29) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:29)
🧪 test TestCase_testS1QuatCastScalingYBranch.testS1QuatCastS...      (00:00:07)
   ERROR .TestCase_testS1QuatCastScalingXBranch.testS1...
passed: 263, failed: 1             60% [||||||||||||--------] 264/435 (00:00:30) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:30)
🧪 test TestCase_testS1QuatCastScalingYBranch.testS1QuatCastS...      (00:00:08)
   ERROR .TestCase_testS1QuatCastScalingXBranch.testS1...
passed: 263, failed: 1             60% [||||||||||||--------] 264/435 (00:00:30) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:30)
🧪 test TestCase_testS1QuatCastScalingYBranch.testS1QuatCastS...      (00:00:08)
   ERROR .TestCase_testS1QuatCastScalingXBranch.testS1...
passed: 263, failed: 1             60% [||||||||||||--------] 264/435 (00:00:30) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:31)
🧪 test TestCase_testS1QuatCastScalingYBranch.testS1QuatCastS...      (00:00:08)
   ERROR .TestCase_testS1QuatCastScalingXBranch.testS1...
passed: 263, failed: 1             60% [||||||||||||--------] 264/435 (00:00:31) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:31)
🧪 test TestCase_testS1QuatCastScalingYBranch.testS1QuatCastS...      (00:00:09)
   ERROR .TestCase_testS1QuatCastScalingXBranch.testS1...
passed: 263, failed: 1             60% [||||||||||||--------] 264/435 (00:00:31) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:31)
🧪 test TestCase_testS1QuatCastScalingYBranch.testS1QuatCastS...      (00:00:09)
   ERROR .TestCase_testS1QuatCastScalingXBranch.testS1...
passed: 263, failed: 1             60% [||||||||||||--------] 264/435 (00:00:31) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:32)
🧪 test TestCase_testS1QuatCastScalingYBranch.testS1QuatCastS...      (00:00:10)
   ERROR .TestCase_testS1QuatCastScalingXBranch.testS1...
passed: 263, failed: 1             60% [||||||||||||--------] 264/435 (00:00:32) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:32)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:00)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:32) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:32)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:00)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:32) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:33)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:01)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:33) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:33)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:01)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:33) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:33)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:01)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:33) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:34)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:02)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:34) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:34)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:02)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:34) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:34)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:02)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:35) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:35)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:03)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:35) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:35)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:03)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:35) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:36)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:03)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:36) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:36)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:04)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:36) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:36)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:04)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:36) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:37)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:04)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:37) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:37)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:05)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:37) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:37)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:05)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:37) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:38)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:06)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:38) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:38)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:06)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:38) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:38)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:06)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:38) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:39)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:07)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:39) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:39)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:07)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:39) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:39)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:07)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:40) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:40)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:08)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:40) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:40)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:08)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:40) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:41)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:08)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:41) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:41)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:09)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:41) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:41)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:09)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:41) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:42)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:09)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:42) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:42)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:10)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:42) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:42)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:10)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:42) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:43)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:11)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:43) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:43)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:11)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:43) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:43)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:11)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:43) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:44)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:12)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:44) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:44)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:12)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:44) 878



7📦 group glm.detail                   60% [||||||||||||--------] ✗    (00:00:44)
🧪 test TestCase_testS1QuatCastScalingZBranch.testS1QuatCastS...      (00:00:12)
   ERROR .TestCase_testS1QuatCastScalingYBranch.testS1...
passed: 263, failed: 2             60% [||||||||||||--------] 265/435 (00:00:45) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:45)
🧪 test TestCase_testS1QuatCastScalingWBranch.testS1QuatCastS...      (00:00:00)
   ERROR .TestCase_testS1QuatCastScalingZBranch.testS1...
passed: 263, failed: 3             61% [||||||||||||--------] 266/435 (00:00:45) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:45)
🧪 test TestCase_testS1QuatCastScalingWBranch.testS1QuatCastS...      (00:00:00)
   ERROR .TestCase_testS1QuatCastScalingZBranch.testS1...
passed: 263, failed: 3             61% [||||||||||||--------] 266/435 (00:00:45) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:46)
🧪 test TestCase_testS1QuatCastScalingWBranch.testS1QuatCastS...      (00:00:00)
   ERROR .TestCase_testS1QuatCastScalingZBranch.testS1...
passed: 263, failed: 3             61% [||||||||||||--------] 266/435 (00:00:46) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:46)
🧪 test TestCase_testS1QuatCastScalingWBranch.testS1QuatCastS...      (00:00:01)
   ERROR .TestCase_testS1QuatCastScalingZBranch.testS1...
passed: 263, failed: 3             61% [||||||||||||--------] 266/435 (00:00:46) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:46)
🧪 test TestCase_testS1QuatCastScalingWBranch.testS1QuatCastS...      (00:00:01)
   ERROR .TestCase_testS1QuatCastScalingZBranch.testS1...
passed: 263, failed: 3             61% [||||||||||||--------] 266/435 (00:00:46) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:47)
🧪 test TestCase_testS1QuatCastScalingWBranch.testS1QuatCastS...      (00:00:01)
   ERROR .TestCase_testS1QuatCastScalingZBranch.testS1...
passed: 263, failed: 3             61% [||||||||||||--------] 266/435 (00:00:47) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:47)
🧪 test TestCase_testS1QuatCastScalingWBranch.testS1QuatCastS...      (00:00:02)
   ERROR .TestCase_testS1QuatCastScalingZBranch.testS1...
passed: 263, failed: 3             61% [||||||||||||--------] 266/435 (00:00:47) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:47)
🧪 test TestCase_testS1QuatCastScalingWBranch.testS1QuatCastS...      (00:00:02)
   ERROR .TestCase_testS1QuatCastScalingZBranch.testS1...
passed: 263, failed: 3             61% [||||||||||||--------] 266/435 (00:00:47) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:48)
🧪 test TestCase_testS1QuatCastScalingWBranch.testS1QuatCastS...      (00:00:02)
   ERROR .TestCase_testS1QuatCastScalingZBranch.testS1...
passed: 263, failed: 3             61% [||||||||||||--------] 266/435 (00:00:48) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:48)
🧪 test TestCase_testS1QuatCastScalingWBranch.testS1QuatCastS...      (00:00:03)
   ERROR .TestCase_testS1QuatCastScalingZBranch.testS1...
passed: 263, failed: 3             61% [||||||||||||--------] 266/435 (00:00:48) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:48)
🧪 test TestCase_testS1QuatCastScalingWBranch.testS1QuatCastS...      (00:00:03)
   ERROR .TestCase_testS1QuatCastScalingZBranch.testS1...
passed: 263, failed: 3             61% [||||||||||||--------] 266/435 (00:00:48) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:49)
🧪 test TestCase_testS1QuatCastScalingWBranch.testS1QuatCastS...      (00:00:03)
   ERROR .TestCase_testS1QuatCastScalingZBranch.testS1...
passed: 263, failed: 3             61% [||||||||||||--------] 266/435 (00:00:49) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:49)
🧪 test TestCase_testS1QuatCastScalingWBranch.testS1QuatCastS...      (00:00:04)
   ERROR .TestCase_testS1QuatCastScalingZBranch.testS1...
passed: 263, failed: 3             61% [||||||||||||--------] 266/435 (00:00:49) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:49)
🧪 test TestCase_testS1QuatCastScalingWBranch.testS1QuatCastS...      (00:00:04)
   ERROR .TestCase_testS1QuatCastScalingZBranch.testS1...
passed: 263, failed: 3             61% [||||||||||||--------] 266/435 (00:00:50) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:50)
🧪 test TestCase_testS1QuatCastScalingWBranch.testS1QuatCastS...      (00:00:05)
   ERROR .TestCase_testS1QuatCastScalingZBranch.testS1...
passed: 263, failed: 3             61% [||||||||||||--------] 266/435 (00:00:50) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:50)
🧪 test TestCase_testS1QuatCastScalingWBranch.testS1QuatCastS...      (00:00:05)
   ERROR .TestCase_testS1QuatCastScalingZBranch.testS1...
passed: 263, failed: 3             61% [||||||||||||--------] 266/435 (00:00:50) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:51)
🧪 test TestCase_testS1QuatCastScalingWBranch.testS1QuatCastS...      (00:00:05)
   ERROR .TestCase_testS1QuatCastScalingZBranch.testS1...
passed: 263, failed: 3             61% [||||||||||||--------] 266/435 (00:00:51) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:51)
🧪 test TestCase_testS1QuatCastScalingWBranch.testS1QuatCastS...      (00:00:06)
   ERROR .TestCase_testS1QuatCastScalingZBranch.testS1...
passed: 263, failed: 3             61% [||||||||||||--------] 266/435 (00:00:51) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:51)
🧪 test TestCase_testS1QuatCastScalingWBranch.testS1QuatCastS...      (00:00:06)
   ERROR .TestCase_testS1QuatCastScalingZBranch.testS1...
passed: 263, failed: 3             61% [||||||||||||--------] 266/435 (00:00:51) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:52)
🧪 test TestCase_testS1QuatCastScalingWBranch.testS1QuatCastS...      (00:00:06)
   ERROR .TestCase_testS1QuatCastScalingZBranch.testS1...
passed: 263, failed: 3             61% [||||||||||||--------] 266/435 (00:00:52) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:52)
🧪 test TestCase_testS1QuatCastScalingWBranch.testS1QuatCastS...      (00:00:07)
   ERROR .TestCase_testS1QuatCastScalingZBranch.testS1...
passed: 263, failed: 3             61% [||||||||||||--------] 266/435 (00:00:52) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:52)
🧪 test TestCase_testS1QuatCastScalingWBranch.testS1QuatCastS...      (00:00:07)
   ERROR .TestCase_testS1QuatCastScalingZBranch.testS1...
passed: 263, failed: 3             61% [||||||||||||--------] 266/435 (00:00:52) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:53)
🧪 test TestCase_testS1QuatCastScalingWBranch.testS1QuatCastS...      (00:00:07)
   ERROR .TestCase_testS1QuatCastScalingZBranch.testS1...
passed: 263, failed: 3             61% [||||||||||||--------] 266/435 (00:00:53) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:53)
🧪 test TestCase_testS1QuatCastScalingWBranch.testS1QuatCastS...      (00:00:08)
   ERROR .TestCase_testS1QuatCastScalingZBranch.testS1...
passed: 263, failed: 3             61% [||||||||||||--------] 266/435 (00:00:53) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:53)
🧪 test TestCase_testS1QuatCastUnitRoundTrip.testS1QuatCastUn...      (00:00:00)
   ERROR .TestCase_testS1QuatCastScalingWBranch.testS1...
passed: 263, failed: 4             61% [||||||||||||--------] 267/435 (00:00:53) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:54)
🧪 test TestCase_testS1QuatCastUnitRoundTrip.testS1QuatCastUn...      (00:00:00)
   ERROR .TestCase_testS1QuatCastScalingWBranch.testS1...
passed: 263, failed: 4             61% [||||||||||||--------] 267/435 (00:00:54) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:54)
🧪 test TestCase_testS1QuatCastUnitRoundTrip.testS1QuatCastUn...      (00:00:01)
   ERROR .TestCase_testS1QuatCastScalingWBranch.testS1...
passed: 263, failed: 4             61% [||||||||||||--------] 267/435 (00:00:54) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:54)
🧪 test TestCase_testS1QuatCastUnitRoundTrip.testS1QuatCastUn...      (00:00:01)
   ERROR .TestCase_testS1QuatCastScalingWBranch.testS1...
passed: 263, failed: 4             61% [||||||||||||--------] 267/435 (00:00:55) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:55)
🧪 test TestCase_testS1QuatCastUnitRoundTrip.testS1QuatCastUn...      (00:00:01)
   ERROR .TestCase_testS1QuatCastScalingWBranch.testS1...
passed: 263, failed: 4             61% [||||||||||||--------] 267/435 (00:00:55) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:55)
🧪 test TestCase_testS1QuatCastUnitRoundTrip.testS1QuatCastUn...      (00:00:02)
   ERROR .TestCase_testS1QuatCastScalingWBranch.testS1...
passed: 263, failed: 4             61% [||||||||||||--------] 267/435 (00:00:55) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:56)
🧪 test TestCase_testS1QuatCastUnitRoundTrip.testS1QuatCastUn...      (00:00:02)
   ERROR .TestCase_testS1QuatCastScalingWBranch.testS1...
passed: 263, failed: 4             61% [||||||||||||--------] 267/435 (00:00:56) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:56)
🧪 test TestCase_testS1QuatCastUnitRoundTrip.testS1QuatCastUn...      (00:00:02)
   ERROR .TestCase_testS1QuatCastScalingWBranch.testS1...
passed: 263, failed: 4             61% [||||||||||||--------] 267/435 (00:00:56) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:56)
🧪 test TestCase_testS1QuatCastUnitRoundTrip.testS1QuatCastUn...      (00:00:03)
   ERROR .TestCase_testS1QuatCastScalingWBranch.testS1...
passed: 263, failed: 4             61% [||||||||||||--------] 267/435 (00:00:56) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:57)
🧪 test TestCase_testS1QuatCastUnitRoundTrip.testS1QuatCastUn...      (00:00:03)
   ERROR .TestCase_testS1QuatCastScalingWBranch.testS1...
passed: 263, failed: 4             61% [||||||||||||--------] 267/435 (00:00:57) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:57)
🧪 test TestCase_testS1QuatCastUnitRoundTrip.testS1QuatCastUn...      (00:00:03)
   ERROR .TestCase_testS1QuatCastScalingWBranch.testS1...
passed: 263, failed: 4             61% [||||||||||||--------] 267/435 (00:00:57) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:57)
🧪 test TestCase_testS1QuatCastUnitRoundTrip.testS1QuatCastUn...      (00:00:04)
   ERROR .TestCase_testS1QuatCastScalingWBranch.testS1...
passed: 263, failed: 4             61% [||||||||||||--------] 267/435 (00:00:57) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:58)
🧪 test TestCase_testS1QuatCastUnitRoundTrip.testS1QuatCastUn...      (00:00:04)
   ERROR .TestCase_testS1QuatCastScalingWBranch.testS1...
passed: 263, failed: 4             61% [||||||||||||--------] 267/435 (00:00:58) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:58)
🧪 test TestCase_testS1QuatCastUnitRoundTrip.testS1QuatCastUn...      (00:00:04)
   ERROR .TestCase_testS1QuatCastScalingWBranch.testS1...
passed: 263, failed: 4             61% [||||||||||||--------] 267/435 (00:00:58) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:58)
🧪 test TestCase_testS1QuatCastUnitRoundTrip.testS1QuatCastUn...      (00:00:05)
   ERROR .TestCase_testS1QuatCastScalingWBranch.testS1...
passed: 263, failed: 4             61% [||||||||||||--------] 267/435 (00:00:58) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:59)
🧪 test TestCase_testS1QuatCastUnitRoundTrip.testS1QuatCastUn...      (00:00:05)
   ERROR .TestCase_testS1QuatCastScalingWBranch.testS1...
passed: 263, failed: 4             61% [||||||||||||--------] 267/435 (00:00:59) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:59)
🧪 test TestCase_testS1QuatCastUnitRoundTrip.testS1QuatCastUn...      (00:00:06)
   ERROR .TestCase_testS1QuatCastScalingWBranch.testS1...
passed: 263, failed: 4             61% [||||||||||||--------] 267/435 (00:00:59) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:00:59)
🧪 test TestCase_testS1QuatCastUnitRoundTrip.testS1QuatCastUn...      (00:00:06)
   ERROR .TestCase_testS1QuatCastScalingWBranch.testS1...
passed: 263, failed: 4             61% [||||||||||||--------] 267/435 (00:01:00) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:00)
🧪 test TestCase_testS1QuatCastUnitRoundTrip.testS1QuatCastUn...      (00:00:06)
   ERROR .TestCase_testS1QuatCastScalingWBranch.testS1...
passed: 263, failed: 4             61% [||||||||||||--------] 267/435 (00:01:00) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:00)
🧪 test TestCase_testS1QuatCastUnitRoundTrip.testS1QuatCastUn...      (00:00:07)
   ERROR .TestCase_testS1QuatCastScalingWBranch.testS1...
passed: 263, failed: 4             61% [||||||||||||--------] 267/435 (00:01:00) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:01)
🧪 test TestCase_testS1QuatCastUnitRoundTrip.testS1QuatCastUn...      (00:00:07)
   ERROR .TestCase_testS1QuatCastScalingWBranch.testS1...
passed: 263, failed: 4             61% [||||||||||||--------] 267/435 (00:01:01) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:01)
🧪 test TestCase_testS1QuatCastUnitRoundTrip.testS1QuatCastUn...      (00:00:07)
   ERROR .TestCase_testS1QuatCastScalingWBranch.testS1...
passed: 263, failed: 4             61% [||||||||||||--------] 267/435 (00:01:01) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:01)
🧪 test TestCase_testS1QuatCastUnitRoundTrip.testS1QuatCastUn...      (00:00:08)
   ERROR .TestCase_testS1QuatCastScalingWBranch.testS1...
passed: 263, failed: 4             61% [||||||||||||--------] 267/435 (00:01:01) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:02)
🧪 test TestCase_testS1QuatCastUnitRoundTrip.testS1QuatCastUn...      (00:00:08)
   ERROR .TestCase_testS1QuatCastScalingWBranch.testS1...
passed: 263, failed: 4             61% [||||||||||||--------] 267/435 (00:01:02) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:02)
🧪 test TestCase_testS1QuatCastUnitRoundTrip.testS1QuatCastUn...      (00:00:08)
   ERROR .TestCase_testS1QuatCastScalingWBranch.testS1...
passed: 263, failed: 4             61% [||||||||||||--------] 267/435 (00:01:02) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:02)
🧪 test TestCase_testS1QuatCastUnitRoundTrip.testS1QuatCastUn...      (00:00:09)
   ERROR .TestCase_testS1QuatCastScalingWBranch.testS1...
passed: 263, failed: 4             61% [||||||||||||--------] 267/435 (00:01:02) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:03)
🧪 test TestCase_testS1QuatCastUnitRoundTrip.testS1QuatCastUn...      (00:00:09)
   ERROR .TestCase_testS1QuatCastScalingWBranch.testS1...
passed: 263, failed: 4             61% [||||||||||||--------] 267/435 (00:01:03) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:03)
🧪 test TestCase_testS1QuatCastUnitRoundTrip.testS1QuatCastUn...      (00:00:09)
   ERROR .TestCase_testS1QuatCastScalingWBranch.testS1...
passed: 263, failed: 4             61% [||||||||||||--------] 267/435 (00:01:03) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:03)
🧪 test TestCase_testS1QuatCastUnitRoundTrip.testS1QuatCastUn...      (00:00:10)
   ERROR .TestCase_testS1QuatCastScalingWBranch.testS1...
passed: 263, failed: 4             61% [||||||||||||--------] 267/435 (00:01:03) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:04)
🧪 test TestCase_testS1QuatCastUnitRoundTrip.testS1QuatCastUn...      (00:00:10)
   ERROR .TestCase_testS1QuatCastScalingWBranch.testS1...
passed: 263, failed: 4             61% [||||||||||||--------] 267/435 (00:01:04) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:04)
🧪 test TestCase_testS1QuatCastUnitRoundTrip.testS1QuatCastUn...      (00:00:11)
   ERROR .TestCase_testS1QuatCastScalingWBranch.testS1...
passed: 263, failed: 4             61% [||||||||||||--------] 267/435 (00:01:04) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:04)
🧪 test TestCase_testS1QuatCastUnitRoundTrip.testS1QuatCastUn...      (00:00:11)
   ERROR .TestCase_testS1QuatCastScalingWBranch.testS1...
passed: 263, failed: 4             61% [||||||||||||--------] 267/435 (00:01:05) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:05)
🧪 test TestCase_testS1QuatCastUnitRoundTrip.testS1QuatCastUn...      (00:00:11)
   ERROR .TestCase_testS1QuatCastScalingWBranch.testS1...
passed: 263, failed: 4             61% [||||||||||||--------] 267/435 (00:01:05) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:05)
🧪 test TestCase_testS1QuatCastIdentityRoundTrip.testS1QuatCa...      (00:00:00)
   ERROR .TestCase_testS1QuatCastUnitRoundTrip.testS1Q...
passed: 263, failed: 5             61% [||||||||||||--------] 268/435 (00:01:05) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:06)
🧪 test TestCase_testS1QuatCastIdentityRoundTrip.testS1QuatCa...      (00:00:00)
   ERROR .TestCase_testS1QuatCastUnitRoundTrip.testS1Q...
passed: 263, failed: 5             61% [||||||||||||--------] 268/435 (00:01:06) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:06)
🧪 test TestCase_testS1QuatCastIdentityRoundTrip.testS1QuatCa...      (00:00:01)
   ERROR .TestCase_testS1QuatCastUnitRoundTrip.testS1Q...
passed: 263, failed: 5             61% [||||||||||||--------] 268/435 (00:01:06) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:06)
🧪 test TestCase_testS1QuatCastIdentityRoundTrip.testS1QuatCa...      (00:00:01)
   ERROR .TestCase_testS1QuatCastUnitRoundTrip.testS1Q...
passed: 263, failed: 5             61% [||||||||||||--------] 268/435 (00:01:06) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:07)
🧪 test TestCase_testS1QuatCastIdentityRoundTrip.testS1QuatCa...      (00:00:01)
   ERROR .TestCase_testS1QuatCastUnitRoundTrip.testS1Q...
passed: 263, failed: 5             61% [||||||||||||--------] 268/435 (00:01:07) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:07)
🧪 test TestCase_testS1QuatCastIdentityRoundTrip.testS1QuatCa...      (00:00:02)
   ERROR .TestCase_testS1QuatCastUnitRoundTrip.testS1Q...
passed: 263, failed: 5             61% [||||||||||||--------] 268/435 (00:01:07) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:07)
🧪 test TestCase_testS1QuatCastIdentityRoundTrip.testS1QuatCa...      (00:00:02)
   ERROR .TestCase_testS1QuatCastUnitRoundTrip.testS1Q...
passed: 263, failed: 5             61% [||||||||||||--------] 268/435 (00:01:07) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:08)
🧪 test TestCase_testS1QuatCastIdentityRoundTrip.testS1QuatCa...      (00:00:02)
   ERROR .TestCase_testS1QuatCastUnitRoundTrip.testS1Q...
passed: 263, failed: 5             61% [||||||||||||--------] 268/435 (00:01:08) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:08)
🧪 test TestCase_testS1QuatCastIdentityRoundTrip.testS1QuatCa...      (00:00:03)
   ERROR .TestCase_testS1QuatCastUnitRoundTrip.testS1Q...
passed: 263, failed: 5             61% [||||||||||||--------] 268/435 (00:01:08) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:08)
🧪 test TestCase_testS1QuatCastIdentityRoundTrip.testS1QuatCa...      (00:00:03)
   ERROR .TestCase_testS1QuatCastUnitRoundTrip.testS1Q...
passed: 263, failed: 5             61% [||||||||||||--------] 268/435 (00:01:08) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:09)
🧪 test TestCase_testS1QuatCastIdentityRoundTrip.testS1QuatCa...      (00:00:03)
   ERROR .TestCase_testS1QuatCastUnitRoundTrip.testS1Q...
passed: 263, failed: 5             61% [||||||||||||--------] 268/435 (00:01:09) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:09)
🧪 test TestCase_testS1QuatCastIdentityRoundTrip.testS1QuatCa...      (00:00:04)
   ERROR .TestCase_testS1QuatCastUnitRoundTrip.testS1Q...
passed: 263, failed: 5             61% [||||||||||||--------] 268/435 (00:01:09) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:09)
🧪 test TestCase_testS1QuatCastIdentityRoundTrip.testS1QuatCa...      (00:00:04)
   ERROR .TestCase_testS1QuatCastUnitRoundTrip.testS1Q...
passed: 263, failed: 5             61% [||||||||||||--------] 268/435 (00:01:10) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:10)
🧪 test TestCase_testS1QuatCastIdentityRoundTrip.testS1QuatCa...      (00:00:04)
   ERROR .TestCase_testS1QuatCastUnitRoundTrip.testS1Q...
passed: 263, failed: 5             61% [||||||||||||--------] 268/435 (00:01:10) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:10)
🧪 test TestCase_testS1QuatCastIdentityRoundTrip.testS1QuatCa...      (00:00:05)
   ERROR .TestCase_testS1QuatCastUnitRoundTrip.testS1Q...
passed: 263, failed: 5             61% [||||||||||||--------] 268/435 (00:01:10) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:11)
🧪 test TestCase_testS1QuatCastIdentityRoundTrip.testS1QuatCa...      (00:00:05)
   ERROR .TestCase_testS1QuatCastUnitRoundTrip.testS1Q...
passed: 263, failed: 5             61% [||||||||||||--------] 268/435 (00:01:11) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:11)
🧪 test TestCase_testS1QuatCastIdentityRoundTrip.testS1QuatCa...      (00:00:06)
   ERROR .TestCase_testS1QuatCastUnitRoundTrip.testS1Q...
passed: 263, failed: 5             61% [||||||||||||--------] 268/435 (00:01:11) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:11)
🧪 test TestCase_testS1QuatCastIdentityRoundTrip.testS1QuatCa...      (00:00:06)
   ERROR .TestCase_testS1QuatCastUnitRoundTrip.testS1Q...
passed: 263, failed: 5             61% [||||||||||||--------] 268/435 (00:01:11) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:12)
🧪 test TestCase_testS1QuatCastIdentityRoundTrip.testS1QuatCa...      (00:00:06)
   ERROR .TestCase_testS1QuatCastUnitRoundTrip.testS1Q...
passed: 263, failed: 5             61% [||||||||||||--------] 268/435 (00:01:12) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:12)
🧪 test TestCase_testS1QuatCastIdentityRoundTrip.testS1QuatCa...      (00:00:07)
   ERROR .TestCase_testS1QuatCastUnitRoundTrip.testS1Q...
passed: 263, failed: 5             61% [||||||||||||--------] 268/435 (00:01:12) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:12)
🧪 test TestCase_testS1QuatCastIdentityRoundTrip.testS1QuatCa...      (00:00:07)
   ERROR .TestCase_testS1QuatCastUnitRoundTrip.testS1Q...
passed: 263, failed: 5             61% [||||||||||||--------] 268/435 (00:01:12) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:13)
🧪 test TestCase_testS1QuatCastIdentityRoundTrip.testS1QuatCa...      (00:00:07)
   ERROR .TestCase_testS1QuatCastUnitRoundTrip.testS1Q...
passed: 263, failed: 5             61% [||||||||||||--------] 268/435 (00:01:13) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:13)
🧪 test TestCase_testS1QuatCastIdentityRoundTrip.testS1QuatCa...      (00:00:08)
   ERROR .TestCase_testS1QuatCastUnitRoundTrip.testS1Q...
passed: 263, failed: 5             61% [||||||||||||--------] 268/435 (00:01:13) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:13)
🧪 test TestCase_testS1QuatCastIdentityRoundTrip.testS1QuatCa...      (00:00:08)
   ERROR .TestCase_testS1QuatCastUnitRoundTrip.testS1Q...
passed: 263, failed: 5             61% [||||||||||||--------] 268/435 (00:01:13) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:14)
🧪 test TestCase_testS1QuatCastIdentityRoundTrip.testS1QuatCa...      (00:00:08)
   ERROR .TestCase_testS1QuatCastUnitRoundTrip.testS1Q...
passed: 263, failed: 5             61% [||||||||||||--------] 268/435 (00:01:14) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:14)
🧪 test TestCase_testS1QuatCastIdentityRoundTrip.testS1QuatCa...      (00:00:09)
   ERROR .TestCase_testS1QuatCastUnitRoundTrip.testS1Q...
passed: 263, failed: 5             61% [||||||||||||--------] 268/435 (00:01:14) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:14)
🧪 test TestCase_testS1QuatCastIdentityRoundTrip.testS1QuatCa...      (00:00:09)
   ERROR .TestCase_testS1QuatCastUnitRoundTrip.testS1Q...
passed: 263, failed: 5             61% [||||||||||||--------] 268/435 (00:01:15) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:15)
🧪 test TestCase_testS1QuatCastIdentityRoundTrip.testS1QuatCa...      (00:00:09)
   ERROR .TestCase_testS1QuatCastUnitRoundTrip.testS1Q...
passed: 263, failed: 5             61% [||||||||||||--------] 268/435 (00:01:15) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:15)
🧪 test TestCase_testS1QuatCastIdentityRoundTrip.testS1QuatCa...      (00:00:10)
   ERROR .TestCase_testS1QuatCastUnitRoundTrip.testS1Q...
passed: 263, failed: 5             61% [||||||||||||--------] 268/435 (00:01:15) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:16)
🧪 test TestCase_testS1QuatCastIdentityRoundTrip.testS1QuatCa...      (00:00:10)
   ERROR .TestCase_testS1QuatCastUnitRoundTrip.testS1Q...
passed: 263, failed: 5             61% [||||||||||||--------] 268/435 (00:01:16) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:16)
🧪 test TestCase_testS1QuatCastIdentityRoundTrip.testS1QuatCa...      (00:00:11)
   ERROR .TestCase_testS1QuatCastUnitRoundTrip.testS1Q...
passed: 263, failed: 5             61% [||||||||||||--------] 268/435 (00:01:16) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:16)
🧪 test TestCase_testS1QuatCastIdentityRoundTrip.testS1QuatCa...      (00:00:11)
   ERROR .TestCase_testS1QuatCastUnitRoundTrip.testS1Q...
passed: 263, failed: 5             61% [||||||||||||--------] 268/435 (00:01:16) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:17)
🧪 test TestCase_testS1QuatCastMat4Delegation.testS1QuatCastM...      (00:00:00)
   ERROR .TestCase_testS1QuatCastIdentityRoundTrip.tes...
passed: 263, failed: 6             61% [||||||||||||--------] 269/435 (00:01:17) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:17)
🧪 test TestCase_testS1QuatCastMat4Delegation.testS1QuatCastM...      (00:00:00)
   ERROR .TestCase_testS1QuatCastIdentityRoundTrip.tes...
passed: 263, failed: 6             61% [||||||||||||--------] 269/435 (00:01:17) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:17)
🧪 test TestCase_testS1QuatCastMat4Delegation.testS1QuatCastM...      (00:00:00)
   ERROR .TestCase_testS1QuatCastIdentityRoundTrip.tes...
passed: 263, failed: 6             61% [||||||||||||--------] 269/435 (00:01:17) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:18)
🧪 test TestCase_testS1QuatCastMat4Delegation.testS1QuatCastM...      (00:00:01)
   ERROR .TestCase_testS1QuatCastIdentityRoundTrip.tes...
passed: 263, failed: 6             61% [||||||||||||--------] 269/435 (00:01:18) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:18)
🧪 test TestCase_testS1QuatCastMat4Delegation.testS1QuatCastM...      (00:00:01)
   ERROR .TestCase_testS1QuatCastIdentityRoundTrip.tes...
passed: 263, failed: 6             61% [||||||||||||--------] 269/435 (00:01:18) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:18)
🧪 test TestCase_testS1QuatCastMat4Delegation.testS1QuatCastM...      (00:00:01)
   ERROR .TestCase_testS1QuatCastIdentityRoundTrip.tes...
passed: 263, failed: 6             61% [||||||||||||--------] 269/435 (00:01:18) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:19)
🧪 test TestCase_testS1QuatCastMat4Delegation.testS1QuatCastM...      (00:00:02)
   ERROR .TestCase_testS1QuatCastIdentityRoundTrip.tes...
passed: 263, failed: 6             61% [||||||||||||--------] 269/435 (00:01:19) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:19)
🧪 test TestCase_testS1QuatCastMat4Delegation.testS1QuatCastM...      (00:00:02)
   ERROR .TestCase_testS1QuatCastIdentityRoundTrip.tes...
passed: 263, failed: 6             61% [||||||||||||--------] 269/435 (00:01:19) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:19)
🧪 test TestCase_testS1QuatCastMat4Delegation.testS1QuatCastM...      (00:00:02)
   ERROR .TestCase_testS1QuatCastIdentityRoundTrip.tes...
passed: 263, failed: 6             61% [||||||||||||--------] 269/435 (00:01:20) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:20)
🧪 test TestCase_testS1QuatCastMat4Delegation.testS1QuatCastM...      (00:00:03)
   ERROR .TestCase_testS1QuatCastIdentityRoundTrip.tes...
passed: 263, failed: 6             61% [||||||||||||--------] 269/435 (00:01:20) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:20)
🧪 test TestCase_testS1QuatCastMat4Delegation.testS1QuatCastM...      (00:00:03)
   ERROR .TestCase_testS1QuatCastIdentityRoundTrip.tes...
passed: 263, failed: 6             61% [||||||||||||--------] 269/435 (00:01:20) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:21)
🧪 test TestCase_testS1QuatCastMat4Delegation.testS1QuatCastM...      (00:00:04)
   ERROR .TestCase_testS1QuatCastIdentityRoundTrip.tes...
passed: 263, failed: 6             61% [||||||||||||--------] 269/435 (00:01:21) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:21)
🧪 test TestCase_testS1QuatCastMat4Delegation.testS1QuatCastM...      (00:00:04)
   ERROR .TestCase_testS1QuatCastIdentityRoundTrip.tes...
passed: 263, failed: 6             61% [||||||||||||--------] 269/435 (00:01:21) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:21)
🧪 test TestCase_testS1QuatCastMat4Delegation.testS1QuatCastM...      (00:00:04)
   ERROR .TestCase_testS1QuatCastIdentityRoundTrip.tes...
passed: 263, failed: 6             61% [||||||||||||--------] 269/435 (00:01:21) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:22)
🧪 test TestCase_testS1QuatCastMat4Delegation.testS1QuatCastM...      (00:00:05)
   ERROR .TestCase_testS1QuatCastIdentityRoundTrip.tes...
passed: 263, failed: 6             61% [||||||||||||--------] 269/435 (00:01:22) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:22)
🧪 test TestCase_testS1QuatCastMat4Delegation.testS1QuatCastM...      (00:00:05)
   ERROR .TestCase_testS1QuatCastIdentityRoundTrip.tes...
passed: 263, failed: 6             61% [||||||||||||--------] 269/435 (00:01:22) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:22)
🧪 test TestCase_testS1QuatCastMat4Delegation.testS1QuatCastM...      (00:00:05)
   ERROR .TestCase_testS1QuatCastIdentityRoundTrip.tes...
passed: 263, failed: 6             61% [||||||||||||--------] 269/435 (00:01:22) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:23)
🧪 test TestCase_testS1QuatCastMat4Delegation.testS1QuatCastM...      (00:00:06)
   ERROR .TestCase_testS1QuatCastIdentityRoundTrip.tes...
passed: 263, failed: 6             61% [||||||||||||--------] 269/435 (00:01:23) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:23)
🧪 test TestCase_testS1QuatCastMat4Delegation.testS1QuatCastM...      (00:00:06)
   ERROR .TestCase_testS1QuatCastIdentityRoundTrip.tes...
passed: 263, failed: 6             61% [||||||||||||--------] 269/435 (00:01:23) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:23)
🧪 test TestCase_testS1QuatCastMat4Delegation.testS1QuatCastM...      (00:00:06)
   ERROR .TestCase_testS1QuatCastIdentityRoundTrip.tes...
passed: 263, failed: 6             61% [||||||||||||--------] 269/435 (00:01:23) 878



7📦 group glm.detail                   61% [||||||||||||--------] ✗    (00:01:24)
🧪 test TestCase_testS1QuatCastMat4Delegation.testS1QuatCastM...      (00:00:07)
   ERROR .TestCase_testS1QuatCastIdentityRoundTrip.tes...
passed: 263, failed: 6             61% [||||||||||||--------] 269/435 (00:01:24) 878


7📦 group glm.detail                  100% [||||||||||||||||||||] ✗    (00:01:24)
   ERROR .TestCase_testS1QuatCastMat4Delegation.testS1...
passed: 428, failed: 7            100% [||||||||||||||||||||] 435/435 (00:01:24) 8--------------------------------------------------------------------------------------------------
TP: glm.detail, time elapsed: 84434981000 ns, RESULT:
    TCS: TestCase_testComputeVecAdd1, time elapsed: 2089200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAdd1 (401200 ns)
    TCS: TestCase_testComputeVecSub2, time elapsed: 414400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSub2 (50000 ns)
    TCS: TestCase_testComputeVecMul3, time elapsed: 400200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMul3 (53500 ns)
    TCS: TestCase_testComputeVecMod1, time elapsed: 402200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMod1 (44000 ns)
    TCS: TestCase_testComputeVecMod4, time elapsed: 373400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMod4 (42000 ns)
    TCS: TestCase_testComputeVecAnd1, time elapsed: 351500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAnd1 (32600 ns)
    TCS: TestCase_testComputeVecAnd3, time elapsed: 343100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAnd3 (27800 ns)
    TCS: TestCase_testComputeVecOr1, time elapsed: 368600 ns, RESULT:
    [ PASSED ] CASE: testComputeVecOr1 (32600 ns)
    TCS: TestCase_testComputeVecOr2, time elapsed: 357600 ns, RESULT:
    [ PASSED ] CASE: testComputeVecOr2 (28900 ns)
    TCS: TestCase_testComputeVecXor1, time elapsed: 441500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecXor1 (68600 ns)
    TCS: TestCase_testComputeVecXor4, time elapsed: 368900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecXor4 (31300 ns)
    TCS: TestCase_testComputeVecShiftLeft1, time elapsed: 384500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftLeft1 (24900 ns)
    TCS: TestCase_testComputeVecShiftLeft3, time elapsed: 360900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftLeft3 (23700 ns)
    TCS: TestCase_testComputeVecShiftRight1, time elapsed: 431800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftRight1 (41300 ns)
    TCS: TestCase_testComputeVecShiftRight4, time elapsed: 697700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftRight4 (76100 ns)
    TCS: TestCase_testComputeVecEqual1, time elapsed: 424000 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual1 (27800 ns)
    TCS: TestCase_testComputeVecNequal4, time elapsed: 303500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecNequal4 (27900 ns)
    TCS: TestCase_testComputeVecBitwiseNot1, time elapsed: 346800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecBitwiseNot1 (44800 ns)
    TCS: TestCase_testComputeVecBitwiseNot3, time elapsed: 318000 ns, RESULT:
    [ PASSED ] CASE: testComputeVecBitwiseNot3 (55300 ns)
    TCS: TestCase_testComputeVecAdd4, time elapsed: 323700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAdd4 (33900 ns)
    TCS: TestCase_testComputeVecSub1, time elapsed: 827500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSub1 (26100 ns)
    TCS: TestCase_testComputeVecSub3, time elapsed: 257800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSub3 (27400 ns)
    TCS: TestCase_testComputeVecMul1, time elapsed: 230200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMul1 (18900 ns)
    TCS: TestCase_testComputeVecMul2, time elapsed: 347400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMul2 (20100 ns)
    TCS: TestCase_testComputeVecDiv1, time elapsed: 343700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecDiv1 (48000 ns)
    TCS: TestCase_testComputeVecDiv2, time elapsed: 222300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecDiv2 (19900 ns)
    TCS: TestCase_testComputeVecDiv4, time elapsed: 438500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecDiv4 (35600 ns)
    TCS: TestCase_testComputeVecEqual2, time elapsed: 579500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual2 (43700 ns)
    TCS: TestCase_testComputeVecEqual3, time elapsed: 546100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual3 (38900 ns)
    TCS: TestCase_testComputeVecEqual4, time elapsed: 593000 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual4 (43100 ns)
    TCS: TestCase_testComputeVecNequal1, time elapsed: 226500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecNequal1 (18300 ns)
    TCS: TestCase_testComputeVecNequal2, time elapsed: 214400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecNequal2 (11200 ns)
    TCS: TestCase_testComputeVecBitwiseNot4, time elapsed: 239600 ns, RESULT:
    [ PASSED ] CASE: testComputeVecBitwiseNot4 (31100 ns)
    TCS: TestCase_testComputeVecAddFloat32, time elapsed: 235200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAddFloat32 (31200 ns)
    TCS: TestCase_testComputeVecAddFloat32Vec3, time elapsed: 252700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAddFloat32Vec3 (30900 ns)
    TCS: TestCase_testComputeVecSubFloat32, time elapsed: 208000 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSubFloat32 (17500 ns)
    TCS: TestCase_testComputeVecSubFloat32Vec4, time elapsed: 218600 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSubFloat32Vec4 (22400 ns)
    TCS: TestCase_testComputeEqualInt32Equal, time elapsed: 206100 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt32Equal (14000 ns)
    TCS: TestCase_testComputeEqualInt32NotEqual, time elapsed: 196700 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt32NotEqual (11400 ns)
    TCS: TestCase_testComputeEqualFloat32Equal, time elapsed: 211500 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32Equal (13000 ns)
    TCS: TestCase_testComputeEqualFloat32NotEqual, time elapsed: 195900 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32NotEqual (14500 ns)
    TCS: TestCase_testComputeEqualFloat64Equal, time elapsed: 196700 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64Equal (10500 ns)
    TCS: TestCase_testComputeEqualFloat64NotEqual, time elapsed: 359500 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64NotEqual (61200 ns)
    TCS: TestCase_testComputeEqualBoolEqual, time elapsed: 327800 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualBoolEqual (15500 ns)
    TCS: TestCase_testComputeEqualBoolNotEqual, time elapsed: 323200 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualBoolNotEqual (13900 ns)
    TCS: TestCase_testComputeEqualNumericInt32, time elapsed: 216600 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericInt32 (12200 ns)
    TCS: TestCase_testComputeEqualNumericFloat32, time elapsed: 280800 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32 (45200 ns)
    TCS: TestCase_testComputeEqualNumericFloat32Epsilon, time elapsed: 264900 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32Epsilon (16300 ns)
    TCS: TestCase_testComputeEqualNumericFloat64, time elapsed: 349900 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64 (30300 ns)
    TCS: TestCase_testComputeEqualInt64Equal, time elapsed: 395500 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt64Equal (18700 ns)
    TCS: TestCase_testComputeEqualInt64NotEqual, time elapsed: 351800 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt64NotEqual (25700 ns)
    TCS: TestCase_testComputeEqualFloat32Nan, time elapsed: 398100 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32Nan (27100 ns)
    TCS: TestCase_testComputeEqualFloat64Nan, time elapsed: 267000 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64Nan (16900 ns)
    TCS: TestCase_testComputeEqualFloat32SignedZero, time elapsed: 263800 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32SignedZero (13100 ns)
    TCS: TestCase_testComputeEqualFloat64SignedZero, time elapsed: 217300 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64SignedZero (8700 ns)
    TCS: TestCase_testComputeEqualNumericFloat32NotEqual, time elapsed: 225400 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32NotEqual (19000 ns)
    TCS: TestCase_testComputeEqualNumericFloat32BeyondEpsilon, time elapsed: 221300 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32BeyondEpsilon (13600 ns)
    TCS: TestCase_testComputeEqualNumericFloat64NotEqual, time elapsed: 209600 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64NotEqual (18600 ns)
    TCS: TestCase_testComputeEqualNumericFloat64Epsilon, time elapsed: 401300 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64Epsilon (27300 ns)
    TCS: TestCase_testComputeEqualNumericFloat64BeyondEpsilon, time elapsed: 295600 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64BeyondEpsilon (18100 ns)
    TCS: TestCase_testComputeEqualNumericInt64, time elapsed: 226700 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericInt64 (14900 ns)
    TCS: TestCase_testPackedHighpImplementsQualifier, time elapsed: 475300 ns, RESULT:
    [ PASSED ] CASE: testPackedHighpImplementsQualifier (20800 ns)
    TCS: TestCase_testPackedMediumpImplementsQualifier, time elapsed: 216700 ns, RESULT:
    [ PASSED ] CASE: testPackedMediumpImplementsQualifier (10100 ns)
    TCS: TestCase_testPackedLowpImplementsQualifier, time elapsed: 200800 ns, RESULT:
    [ PASSED ] CASE: testPackedLowpImplementsQualifier (10100 ns)
    TCS: TestCase_testDefaultpIsPackedHighp, time elapsed: 236700 ns, RESULT:
    [ PASSED ] CASE: testDefaultpIsPackedHighp (11100 ns)
    TCS: TestCase_testScalarAddVec1, time elapsed: 220300 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec1 (26200 ns)
    TCS: TestCase_testScalarAddVec2, time elapsed: 217600 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec2 (15600 ns)
    TCS: TestCase_testScalarAddVec3, time elapsed: 219500 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec3 (22000 ns)
    TCS: TestCase_testScalarAddVec4, time elapsed: 231400 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec4 (21600 ns)
    TCS: TestCase_testScalarSubVec1, time elapsed: 224800 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1 (18900 ns)
    TCS: TestCase_testScalarMulVec1, time elapsed: 232200 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1 (20200 ns)
    TCS: TestCase_testScalarDivVec1, time elapsed: 300200 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1 (35300 ns)
    TCS: TestCase_testScalarModVec1, time elapsed: 243800 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1 (28900 ns)
    TCS: TestCase_testScalarMulVec2, time elapsed: 280700 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2 (25300 ns)
    TCS: TestCase_testScalarSubVec2, time elapsed: 229700 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2 (14600 ns)
    TCS: TestCase_testScalarSubVec3, time elapsed: 212900 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3 (15500 ns)
    TCS: TestCase_testScalarSubVec4, time elapsed: 219500 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4 (17700 ns)
    TCS: TestCase_testScalarMulVec3, time elapsed: 220200 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3 (14400 ns)
    TCS: TestCase_testScalarMulVec4, time elapsed: 225200 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4 (20400 ns)
    TCS: TestCase_testScalarDivVec2, time elapsed: 205800 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2 (19600 ns)
    TCS: TestCase_testScalarDivVec3, time elapsed: 249600 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3 (11300 ns)
    TCS: TestCase_testScalarDivVec4, time elapsed: 214100 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4 (20300 ns)
    TCS: TestCase_testScalarModVec2, time elapsed: 222100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2 (18700 ns)
    TCS: TestCase_testScalarModVec3, time elapsed: 205600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3 (10300 ns)
    TCS: TestCase_testScalarModVec4, time elapsed: 228700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4 (18500 ns)
    TCS: TestCase_testScalarModVec1Float32, time elapsed: 323900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Float32 (29800 ns)
    TCS: TestCase_testScalarModVec2Float32, time elapsed: 253400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32 (19400 ns)
    TCS: TestCase_testScalarModVec3Float32, time elapsed: 223400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Float32 (12900 ns)
    TCS: TestCase_testScalarModVec4Float32, time elapsed: 218800 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Float32 (12600 ns)
    TCS: TestCase_testScalarModVec1Float64, time elapsed: 241700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Float64 (13100 ns)
    TCS: TestCase_testScalarModVec2Float64, time elapsed: 211600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float64 (15100 ns)
    TCS: TestCase_testScalarModVec3Float64, time elapsed: 203800 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Float64 (9600 ns)
    TCS: TestCase_testScalarModVec4Float64, time elapsed: 215600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Float64 (10000 ns)
    TCS: TestCase_testScalarModVec1Float16, time elapsed: 243400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Float16 (26500 ns)
    TCS: TestCase_testScalarModVec2Float16, time elapsed: 213900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float16 (12200 ns)
    TCS: TestCase_testScalarModVec3Float16, time elapsed: 234900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Float16 (17000 ns)
    TCS: TestCase_testScalarModVec4Float16, time elapsed: 314700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Float16 (13100 ns)
    TCS: TestCase_testScalarSubVec2PackedMediump, time elapsed: 299600 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2PackedMediump (44600 ns)
    TCS: TestCase_testScalarSubVec2PackedLowp, time elapsed: 255300 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2PackedLowp (19100 ns)
    TCS: TestCase_testScalarMulVec2PackedMediump, time elapsed: 223000 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2PackedMediump (17200 ns)
    TCS: TestCase_testScalarMulVec2PackedLowp, time elapsed: 205100 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2PackedLowp (12100 ns)
    TCS: TestCase_testScalarDivVec2PackedMediump, time elapsed: 227800 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2PackedMediump (10400 ns)
    TCS: TestCase_testScalarDivVec2PackedLowp, time elapsed: 249900 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2PackedLowp (16400 ns)
    TCS: TestCase_testScalarModVec2PackedMediump, time elapsed: 222300 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2PackedMediump (16200 ns)
    TCS: TestCase_testScalarModVec2PackedLowp, time elapsed: 200200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2PackedLowp (10800 ns)
    TCS: TestCase_testScalarModVec2Float32PackedMediump, time elapsed: 735600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32PackedMediump (82200 ns)
    TCS: TestCase_testScalarModVec2Float32PackedLowp, time elapsed: 331900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32PackedLowp (22500 ns)
    TCS: TestCase_testScalarModVec2Float32NegativeDividend, time elapsed: 290000 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32NegativeDividend (16200 ns)
    TCS: TestCase_testScalarModVec2Float32NegativeDivisor, time elapsed: 280600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32NegativeDivisor (14600 ns)
    TCS: TestCase_testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents, time elapsed: 419700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents (180200 ns)
    TCS: TestCase_testScalarAddVec1Float32, time elapsed: 225000 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec1Float32 (18700 ns)
    TCS: TestCase_testScalarAddVec2Float32, time elapsed: 255800 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec2Float32 (11400 ns)
    TCS: TestCase_testScalarAddVec3Float32, time elapsed: 215400 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec3Float32 (15600 ns)
    TCS: TestCase_testScalarAddVec4Float32, time elapsed: 254700 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec4Float32 (15300 ns)
    TCS: TestCase_testScalarSubVec1Float32, time elapsed: 307300 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1Float32 (22300 ns)
    TCS: TestCase_testScalarSubVec2Float32, time elapsed: 345500 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2Float32 (22700 ns)
    TCS: TestCase_testScalarSubVec3Float32, time elapsed: 409300 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3Float32 (45500 ns)
    TCS: TestCase_testScalarSubVec4Float32, time elapsed: 371500 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4Float32 (34000 ns)
    TCS: TestCase_testScalarMulVec1Float32, time elapsed: 315700 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1Float32 (17900 ns)
    TCS: TestCase_testScalarMulVec2Float32, time elapsed: 303100 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2Float32 (16000 ns)
    TCS: TestCase_testScalarMulVec3Float32, time elapsed: 310000 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3Float32 (23700 ns)
    TCS: TestCase_testScalarMulVec4Float32, time elapsed: 309400 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4Float32 (16300 ns)
    TCS: TestCase_testScalarDivVec1Float32, time elapsed: 299600 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1Float32 (23600 ns)
    TCS: TestCase_testScalarDivVec2Float32, time elapsed: 294900 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2Float32 (15600 ns)
    TCS: TestCase_testScalarDivVec3Float32, time elapsed: 316200 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3Float32 (17800 ns)
    TCS: TestCase_testScalarDivVec4Float32, time elapsed: 288000 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4Float32 (22000 ns)
    TCS: TestCase_testScalarAddVec1Int32, time elapsed: 294100 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec1Int32 (24700 ns)
    TCS: TestCase_testScalarAddVec2Int32, time elapsed: 316500 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec2Int32 (26400 ns)
    TCS: TestCase_testScalarAddVec3Int32, time elapsed: 334800 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec3Int32 (22700 ns)
    TCS: TestCase_testScalarAddVec4Int32, time elapsed: 343800 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec4Int32 (24400 ns)
    TCS: TestCase_testScalarSubVec1Int32, time elapsed: 335900 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1Int32 (23900 ns)
    TCS: TestCase_testScalarSubVec2Int32, time elapsed: 302900 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2Int32 (13800 ns)
    TCS: TestCase_testScalarSubVec3Int32, time elapsed: 360500 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3Int32 (40500 ns)
    TCS: TestCase_testScalarSubVec4Int32, time elapsed: 377100 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4Int32 (34400 ns)
    TCS: TestCase_testScalarMulVec1Int32, time elapsed: 390800 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1Int32 (33500 ns)
    TCS: TestCase_testScalarMulVec2Int32, time elapsed: 410300 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2Int32 (25700 ns)
    TCS: TestCase_testScalarMulVec3Int32, time elapsed: 303100 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3Int32 (15700 ns)
    TCS: TestCase_testScalarMulVec4Int32, time elapsed: 226100 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4Int32 (10700 ns)
    TCS: TestCase_testScalarDivVec1Int32, time elapsed: 215000 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1Int32 (15000 ns)
    TCS: TestCase_testScalarDivVec2Int32, time elapsed: 384800 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2Int32 (27200 ns)
    TCS: TestCase_testScalarDivVec3Int32, time elapsed: 240000 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3Int32 (13800 ns)
    TCS: TestCase_testScalarDivVec4Int32, time elapsed: 205600 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4Int32 (11500 ns)
    TCS: TestCase_testScalarModVec1Int32, time elapsed: 204100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Int32 (12000 ns)
    TCS: TestCase_testScalarModVec2Int32, time elapsed: 206700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Int32 (12200 ns)
    TCS: TestCase_testScalarModVec3Int32, time elapsed: 238100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Int32 (16400 ns)
    TCS: TestCase_testScalarModVec4Int32, time elapsed: 198100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Int32 (12100 ns)
    TCS: TestCase_testScalarSubVec1PackedMediump, time elapsed: 199400 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1PackedMediump (15000 ns)
    TCS: TestCase_testScalarSubVec1PackedLowp, time elapsed: 195900 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1PackedLowp (11400 ns)
    TCS: TestCase_testScalarSubVec3PackedMediump, time elapsed: 192700 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3PackedMediump (10300 ns)
    TCS: TestCase_testScalarSubVec3PackedLowp, time elapsed: 196800 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3PackedLowp (15700 ns)
    TCS: TestCase_testScalarSubVec4PackedMediump, time elapsed: 193200 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4PackedMediump (9700 ns)
    TCS: TestCase_testScalarSubVec4PackedLowp, time elapsed: 383600 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4PackedLowp (14100 ns)
    TCS: TestCase_testScalarMulVec1PackedMediump, time elapsed: 252500 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1PackedMediump (10900 ns)
    TCS: TestCase_testScalarMulVec1PackedLowp, time elapsed: 613300 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1PackedLowp (29800 ns)
    TCS: TestCase_testScalarMulVec3PackedMediump, time elapsed: 449200 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3PackedMediump (21300 ns)
    TCS: TestCase_testScalarMulVec3PackedLowp, time elapsed: 312400 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3PackedLowp (15300 ns)
    TCS: TestCase_testScalarMulVec4PackedMediump, time elapsed: 267400 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4PackedMediump (13900 ns)
    TCS: TestCase_testScalarMulVec4PackedLowp, time elapsed: 266000 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4PackedLowp (17100 ns)
    TCS: TestCase_testScalarDivVec1PackedMediump, time elapsed: 225700 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1PackedMediump (11700 ns)
    TCS: TestCase_testScalarDivVec1PackedLowp, time elapsed: 230000 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1PackedLowp (10000 ns)
    TCS: TestCase_testScalarDivVec3PackedMediump, time elapsed: 207100 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3PackedMediump (15000 ns)
    TCS: TestCase_testScalarDivVec3PackedLowp, time elapsed: 286700 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3PackedLowp (15500 ns)
    TCS: TestCase_testScalarDivVec4PackedMediump, time elapsed: 224300 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4PackedMediump (11300 ns)
    TCS: TestCase_testScalarDivVec4PackedLowp, time elapsed: 224100 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4PackedLowp (11300 ns)
    TCS: TestCase_testScalarModVec1PackedMediump, time elapsed: 199700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1PackedMediump (11300 ns)
    TCS: TestCase_testScalarModVec1PackedLowp, time elapsed: 204900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1PackedLowp (13600 ns)
    TCS: TestCase_testScalarModVec3PackedMediump, time elapsed: 217100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3PackedMediump (11500 ns)
    TCS: TestCase_testScalarModVec3PackedLowp, time elapsed: 216200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3PackedLowp (11300 ns)
    TCS: TestCase_testScalarModVec4PackedMediump, time elapsed: 201600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4PackedMediump (10900 ns)
    TCS: TestCase_testScalarModVec4PackedLowp, time elapsed: 196000 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4PackedLowp (10400 ns)
    TCS: TestCase_testScalarDivZeroVec1, time elapsed: 224900 ns, RESULT:
    [ PASSED ] CASE: testScalarDivZeroVec1 (18800 ns)
    TCS: TestCase_testScalarAddNegVec1, time elapsed: 210700 ns, RESULT:
    [ PASSED ] CASE: testScalarAddNegVec1 (13800 ns)
    TCS: TestCase_testScalarAddNegVec2, time elapsed: 226500 ns, RESULT:
    [ PASSED ] CASE: testScalarAddNegVec2 (9600 ns)
    TCS: TestCase_testScalarMulOverflowVec1, time elapsed: 227400 ns, RESULT:
    [ PASSED ] CASE: testScalarMulOverflowVec1 (9800 ns)
    TCS: TestCase_testScalarSubNegVec1, time elapsed: 221400 ns, RESULT:
    [ PASSED ] CASE: testScalarSubNegVec1 (14300 ns)
    TCS: TestCase_testVersionMajor, time elapsed: 188800 ns, RESULT:
    [ PASSED ] CASE: testVersionMajor (9200 ns)
    TCS: TestCase_testVersionMinor, time elapsed: 197800 ns, RESULT:
    [ PASSED ] CASE: testVersionMinor (10500 ns)
    TCS: TestCase_testVersionPatch, time elapsed: 223100 ns, RESULT:
    [ PASSED ] CASE: testVersionPatch (9900 ns)
    TCS: TestCase_testVersionEncoded, time elapsed: 354600 ns, RESULT:
    [ PASSED ] CASE: testVersionEncoded (22400 ns)
    TCS: TestCase_testConfigSimd, time elapsed: 257500 ns, RESULT:
    [ PASSED ] CASE: testConfigSimd (17500 ns)
    TCS: TestCase_testConfigAlignedGentypes, time elapsed: 260800 ns, RESULT:
    [ PASSED ] CASE: testConfigAlignedGentypes (15300 ns)
    TCS: TestCase_testConfigClipControl, time elapsed: 460200 ns, RESULT:
    [ PASSED ] CASE: testConfigClipControl (15600 ns)
    TCS: TestCase_testConstNegationSimd, time elapsed: 286400 ns, RESULT:
    [ PASSED ] CASE: testConstNegationSimd (21400 ns)
    TCS: TestCase_testConstNegationAligned, time elapsed: 255800 ns, RESULT:
    [ PASSED ] CASE: testConstNegationAligned (13400 ns)
    TCS: TestCase_testConstNegationClip, time elapsed: 234000 ns, RESULT:
    [ PASSED ] CASE: testConstNegationClip (16600 ns)
    TCS: TestCase_testConstInt64Usage, time elapsed: 221700 ns, RESULT:
    [ PASSED ] CASE: testConstInt64Usage (10800 ns)
    TCS: TestCase_testConstBoolUsage, time elapsed: 221900 ns, RESULT:
    [ PASSED ] CASE: testConstBoolUsage (11300 ns)
    TCS: TestCase_testVersionEncodingConsistency, time elapsed: 194200 ns, RESULT:
    [ PASSED ] CASE: testVersionEncodingConsistency (12300 ns)
    TCS: TestCase_testAssertPasses, time elapsed: 221700 ns, RESULT:
    [ PASSED ] CASE: testAssertPasses (27400 ns)
    TCS: TestCase_testAssertFails, time elapsed: 290500 ns, RESULT:
    [ PASSED ] CASE: testAssertFails (77100 ns)
    TCS: TestCase_testAssertWithCustomMessage, time elapsed: 244800 ns, RESULT:
    [ PASSED ] CASE: testAssertWithCustomMessage (48900 ns)
    TCS: TestCase_testNumericLimitsFloat32Epsilon, time elapsed: 215700 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsFloat32Epsilon (12200 ns)
    TCS: TestCase_testNumericLimitsFloat64Epsilon, time elapsed: 219700 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsFloat64Epsilon (12000 ns)
    TCS: TestCase_testIsIec559OfFloat32, time elapsed: 198000 ns, RESULT:
    [ PASSED ] CASE: testIsIec559OfFloat32 (14400 ns)
    TCS: TestCase_testIsIec559OfFloat64, time elapsed: 210200 ns, RESULT:
    [ PASSED ] CASE: testIsIec559OfFloat64 (12800 ns)
    TCS: TestCase_testIsIec559OfInt64, time elapsed: 207000 ns, RESULT:
    [ PASSED ] CASE: testIsIec559OfInt64 (11600 ns)
    TCS: TestCase_testEpsilonOfFloat32, time elapsed: 206000 ns, RESULT:
    [ PASSED ] CASE: testEpsilonOfFloat32 (12000 ns)
    TCS: TestCase_testEpsilonOfFloat64, time elapsed: 308100 ns, RESULT:
    [ PASSED ] CASE: testEpsilonOfFloat64 (17100 ns)
    TCS: TestCase_testNumericLimitsInt64Epsilon, time elapsed: 435700 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt64Epsilon (39600 ns)
    TCS: TestCase_testNumericLimitsInt32Epsilon, time elapsed: 247400 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt32Epsilon (14100 ns)
    TCS: TestCase_testNumericLimitsInt16Epsilon, time elapsed: 235100 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt16Epsilon (16700 ns)
    TCS: TestCase_testNumericLimitsInt8Epsilon, time elapsed: 299600 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt8Epsilon (13700 ns)
    TCS: TestCase_testCastVec1ToVec1IntToFloat, time elapsed: 311600 ns, RESULT:
    [ PASSED ] CASE: testCastVec1ToVec1IntToFloat (33500 ns)
    TCS: TestCase_testCastVec2ToVec1TakesOnlyX, time elapsed: 308700 ns, RESULT:
    [ PASSED ] CASE: testCastVec2ToVec1TakesOnlyX (22900 ns)
    TCS: TestCase_testCastVec3ToVec1TakesOnlyX, time elapsed: 240900 ns, RESULT:
    [ PASSED ] CASE: testCastVec3ToVec1TakesOnlyX (20200 ns)
    TCS: TestCase_testCastVec4ToVec1TakesOnlyX, time elapsed: 201600 ns, RESULT:
    [ PASSED ] CASE: testCastVec4ToVec1TakesOnlyX (10900 ns)
    TCS: TestCase_testCastSameTypeIdentity, time elapsed: 402500 ns, RESULT:
    [ PASSED ] CASE: testCastSameTypeIdentity (12000 ns)
    TCS: TestCase_testCastInt32ToInt64, time elapsed: 356300 ns, RESULT:
    [ PASSED ] CASE: testCastInt32ToInt64 (31900 ns)
    TCS: TestCase_testCastFloatToIntTruncation, time elapsed: 355900 ns, RESULT:
    [ PASSED ] CASE: testCastFloatToIntTruncation (34000 ns)
    TCS: TestCase_testCastCrossQualifierPackedHighpToDefaultp, time elapsed: 319100 ns, RESULT:
    [ PASSED ] CASE: testCastCrossQualifierPackedHighpToDefaultp (35300 ns)
    TCS: TestCase_testCastCrossQualifierDefaultpToPackedHighp, time elapsed: 310300 ns, RESULT:
    [ PASSED ] CASE: testCastCrossQualifierDefaultpToPackedHighp (27300 ns)
    TCS: TestCase_testCastVec2CrossQualifierCrossType, time elapsed: 288400 ns, RESULT:
    [ PASSED ] CASE: testCastVec2CrossQualifierCrossType (28500 ns)
    TCS: TestCase_testCastVec3CrossQualifier, time elapsed: 305800 ns, RESULT:
    [ PASSED ] CASE: testCastVec3CrossQualifier (29400 ns)
    TCS: TestCase_testCastVec4CrossQualifier, time elapsed: 438600 ns, RESULT:
    [ PASSED ] CASE: testCastVec4CrossQualifier (14600 ns)
    TCS: TestCase_testCastVec1DoesNotModifySource, time elapsed: 273400 ns, RESULT:
    [ PASSED ] CASE: testCastVec1DoesNotModifySource (11400 ns)
    TCS: TestCase_testCastVec2Vec1ToVec2IntToFloat, time elapsed: 245000 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec1ToVec2IntToFloat (22200 ns)
    TCS: TestCase_testCastVec2Vec2ToVec2Identity, time elapsed: 223600 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec2ToVec2Identity (10600 ns)
    TCS: TestCase_testCastVec2Vec3ToVec2TakesOnlyXY, time elapsed: 242300 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec3ToVec2TakesOnlyXY (11200 ns)
    TCS: TestCase_testCastVec2Vec4ToVec2TakesOnlyXY, time elapsed: 265500 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec4ToVec2TakesOnlyXY (27800 ns)
    TCS: TestCase_testCastVec2SameTypeIdentity, time elapsed: 282100 ns, RESULT:
    [ PASSED ] CASE: testCastVec2SameTypeIdentity (13900 ns)
    TCS: TestCase_testCastVec2Int32ToInt64, time elapsed: 760500 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Int32ToInt64 (54800 ns)
    TCS: TestCase_testCastVec2FloatToIntTruncation, time elapsed: 288000 ns, RESULT:
    [ PASSED ] CASE: testCastVec2FloatToIntTruncation (13400 ns)
    TCS: TestCase_testCastVec2CrossQualifierPackedHighpToDefaultp, time elapsed: 241800 ns, RESULT:
    [ PASSED ] CASE: testCastVec2CrossQualifierPackedHighpToDefaultp (10500 ns)
    TCS: TestCase_testCastVec2DoesNotModifySource, time elapsed: 192000 ns, RESULT:
    [ PASSED ] CASE: testCastVec2DoesNotModifySource (16700 ns)
    TCS: TestCase_testCastVec2Vec1ToVec2SameValueBothComponents, time elapsed: 184000 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec1ToVec2SameValueBothComponents (8900 ns)
    TCS: TestCase_testCastVec3Vec1ToVec3IntToFloat, time elapsed: 175400 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec1ToVec3IntToFloat (9100 ns)
    TCS: TestCase_testCastVec3Vec2ToVec3ExtendY, time elapsed: 192700 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec2ToVec3ExtendY (21700 ns)
    TCS: TestCase_testCastVec3Vec3ToVec3Identity, time elapsed: 183000 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec3ToVec3Identity (8000 ns)
    TCS: TestCase_testCastVec3Vec4ToVec3TakesOnlyXYZ, time elapsed: 185000 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec4ToVec3TakesOnlyXYZ (14000 ns)
    TCS: TestCase_testCastVec3SameTypeIdentity, time elapsed: 209500 ns, RESULT:
    [ PASSED ] CASE: testCastVec3SameTypeIdentity (13500 ns)
    TCS: TestCase_testCastVec3Int32ToInt64, time elapsed: 182500 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Int32ToInt64 (9200 ns)
    TCS: TestCase_testCastVec3FloatToIntTruncation, time elapsed: 170400 ns, RESULT:
    [ PASSED ] CASE: testCastVec3FloatToIntTruncation (7000 ns)
    TCS: TestCase_testCastVec3CrossQualifierPackedHighpToDefaultp, time elapsed: 176000 ns, RESULT:
    [ PASSED ] CASE: testCastVec3CrossQualifierPackedHighpToDefaultp (6400 ns)
    TCS: TestCase_testCastVec3DoesNotModifySource, time elapsed: 177500 ns, RESULT:
    [ PASSED ] CASE: testCastVec3DoesNotModifySource (6400 ns)
    TCS: TestCase_testCastVec3Vec1ToVec3SameValueAllComponents, time elapsed: 187300 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec1ToVec3SameValueAllComponents (7500 ns)
    TCS: TestCase_testCastVec4Vec1ToVec4IntToFloat, time elapsed: 193100 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec1ToVec4IntToFloat (16800 ns)
    TCS: TestCase_testCastVec4Vec2ToVec4ExtendY, time elapsed: 297800 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec2ToVec4ExtendY (13100 ns)
    TCS: TestCase_testCastVec4Vec3ToVec4ExtendZ, time elapsed: 197900 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec3ToVec4ExtendZ (8700 ns)
    TCS: TestCase_testCastVec4Vec4ToVec4Identity, time elapsed: 208600 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec4ToVec4Identity (15100 ns)
    TCS: TestCase_testCastVec4SameTypeIdentity, time elapsed: 181800 ns, RESULT:
    [ PASSED ] CASE: testCastVec4SameTypeIdentity (11600 ns)
    TCS: TestCase_testCastVec4Int32ToInt64, time elapsed: 190000 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Int32ToInt64 (8200 ns)
    TCS: TestCase_testCastVec4FloatToIntTruncation, time elapsed: 290700 ns, RESULT:
    [ PASSED ] CASE: testCastVec4FloatToIntTruncation (15300 ns)
    TCS: TestCase_testCastVec4CrossQualifierPackedHighpToDefaultp, time elapsed: 234100 ns, RESULT:
    [ PASSED ] CASE: testCastVec4CrossQualifierPackedHighpToDefaultp (8000 ns)
    TCS: TestCase_testCastVec4DoesNotModifySource, time elapsed: 259400 ns, RESULT:
    [ PASSED ] CASE: testCastVec4DoesNotModifySource (7200 ns)
    TCS: TestCase_testCastVec4Vec1ToVec4SameValueAllComponents, time elapsed: 304400 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec1ToVec4SameValueAllComponents (21100 ns)
    TCS: TestCase_testFromBoolVec1, time elapsed: 297400 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec1 (13300 ns)
    TCS: TestCase_testFromBoolVec1False, time elapsed: 316800 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec1False (17300 ns)
    TCS: TestCase_testFromBoolVec2, time elapsed: 344900 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec2 (21300 ns)
    TCS: TestCase_testFromBoolVec3, time elapsed: 293900 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec3 (34500 ns)
    TCS: TestCase_testFromBoolVec4, time elapsed: 247100 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec4 (11400 ns)
    TCS: TestCase_testFromBoolVecQ2Vec1, time elapsed: 245200 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec1 (14500 ns)
    TCS: TestCase_testFromBoolVecQ2Vec2, time elapsed: 262400 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec2 (12900 ns)
    TCS: TestCase_testFromBoolVecQ2Vec3, time elapsed: 296900 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec3 (23900 ns)
    TCS: TestCase_testFromBoolVecQ2Vec4, time elapsed: 288500 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec4 (13000 ns)
    TCS: TestCase_testFromBoolVec3AllFalse, time elapsed: 263800 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec3AllFalse (11300 ns)
    TCS: TestCase_testFromBoolVec4AllFalse, time elapsed: 265100 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec4AllFalse (12100 ns)
    TCS: TestCase_testFromBoolVecQ2Vec3AllFalse, time elapsed: 271600 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec3AllFalse (11900 ns)
    TCS: TestCase_testFromBoolVecQ2Vec4AllFalse, time elapsed: 268600 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec4AllFalse (10200 ns)
    TCS: TestCase_testFromBoolVecFloat32, time elapsed: 292600 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecFloat32 (13600 ns)
    TCS: TestCase_testFromBoolVecFloat64, time elapsed: 280500 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecFloat64 (15000 ns)
    TCS: TestCase_testFromBoolVecInt32, time elapsed: 277400 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecInt32 (14300 ns)
    TCS: TestCase_testFromBoolVecQ2PackedMediump, time elapsed: 379700 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2PackedMediump (11400 ns)
    TCS: TestCase_testFromBoolVecQ2PackedLowp, time elapsed: 384500 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2PackedLowp (20700 ns)
    TCS: TestCase_testS1QuatCastScalingXBranch, time elapsed: 21948903800 ns, RESULT:
    [ ERROR  ] CASE: testS1QuatCastScalingXBranch (21948146800 ns)
    REASON: An exception has occurred:StackOverflowError
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)

	at std.unittest.Framework.runCatching.lambda.1()(std/unittest\framework.cj:111)
	at std.unittest.Framework.runCatching(() -> Unit)(std/unittest\framework.cj:111)
	at std.unittest.TestCaseExecutor<...>.executeFiniteSubstrategy.lambda.0.lambda.0()(std/unittest\test_case_executor.cj:220)
	at std.unittest.Framework.runStepBody(std.unittest.StepKind, std.unittest.StepInfo, () -> Unit)(std/unittest\framework.cj:93)
	at std.unittest.DataStrategyProcessor<...>.processNextWith(std.unittest.common.Configuration, (T0, std.core.Array<...>) -> std.unittest.RunStepResult)(std/unittest\strategy_processor.cj:388)
	at std.unittest.TestCaseExecutor<...>.executeFiniteSubstrategy(std.unittest.TestCaseResult, std.unittest.common.Configuration, (T0) -> Unit)(std/unittest\test_case_executor.cj:228)
	at std.unittest.TestCaseExecutor<...>.execute(std.unittest.TestSuiteReportInfo, std.unittest.TestCaseResult, std.unittest.common.Configuration)(std/unittest\test_case_executor.cj:280)
	at std.unittest.TestSuiteExecutor.runSingleCase.lambda.0()(std/unittest\suite_executor.cj:168)
	at std.unittest.TestSuiteExecutor.tryRun(std.unittest.CaseOrBench)(std/unittest\suite_executor.cj:112)
	at std.unittest.TestSuiteExecutor.execute()(std/unittest\suite_executor.cj:53)
	at std.unittest.TestSuite.execute(std.core.String, std.unittest.common.Configuration, std.unittest.FilterService)(std/unittest\api.cj:51)
	at std.unittest.executeWorker(std.core.String, std.core.Array<...>, std.unittest.FilterService)(std/unittest\execution.cj:99)
	at std.unittest.executeSmart(std.core.String, std.core.Array<...>, std.unittest.FilterService, std.unittest.TestOutputReporter, Bool)(std/unittest\execution.cj:0)
	at std.unittest.Framework.launch<...>(std.unittest.LaunchApi, Bool, std.core.Option<...>, () -> std.unittest.TestGroupResult)(std/unittest\framework.cj:62)
	at std.unittest.entryMain(std.unittest.TestPackage)(std/unittest\entry_main.cj:44)
    TCS: TestCase_testS1QuatCastScalingYBranch, time elapsed: 10082288400 ns, RESULT:
    [ ERROR  ] CASE: testS1QuatCastScalingYBranch (10081599800 ns)
    REASON: An exception has occurred:StackOverflowError
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)

	at std.unittest.Framework.runCatching.lambda.1()(std/unittest\framework.cj:111)
	at std.unittest.Framework.runCatching(() -> Unit)(std/unittest\framework.cj:111)
	at std.unittest.TestCaseExecutor<...>.executeFiniteSubstrategy.lambda.0.lambda.0()(std/unittest\test_case_executor.cj:220)
	at std.unittest.Framework.runStepBody(std.unittest.StepKind, std.unittest.StepInfo, () -> Unit)(std/unittest\framework.cj:93)
	at std.unittest.DataStrategyProcessor<...>.processNextWith(std.unittest.common.Configuration, (T0, std.core.Array<...>) -> std.unittest.RunStepResult)(std/unittest\strategy_processor.cj:388)
	at std.unittest.TestCaseExecutor<...>.executeFiniteSubstrategy(std.unittest.TestCaseResult, std.unittest.common.Configuration, (T0) -> Unit)(std/unittest\test_case_executor.cj:228)
	at std.unittest.TestCaseExecutor<...>.execute(std.unittest.TestSuiteReportInfo, std.unittest.TestCaseResult, std.unittest.common.Configuration)(std/unittest\test_case_executor.cj:280)
	at std.unittest.TestSuiteExecutor.runSingleCase.lambda.0()(std/unittest\suite_executor.cj:168)
	at std.unittest.TestSuiteExecutor.tryRun(std.unittest.CaseOrBench)(std/unittest\suite_executor.cj:112)
	at std.unittest.TestSuiteExecutor.execute()(std/unittest\suite_executor.cj:53)
	at std.unittest.TestSuite.execute(std.core.String, std.unittest.common.Configuration, std.unittest.FilterService)(std/unittest\api.cj:51)
	at std.unittest.executeWorker(std.core.String, std.core.Array<...>, std.unittest.FilterService)(std/unittest\execution.cj:99)
	at std.unittest.executeSmart(std.core.String, std.core.Array<...>, std.unittest.FilterService, std.unittest.TestOutputReporter, Bool)(std/unittest\execution.cj:0)
	at std.unittest.Framework.launch<...>(std.unittest.LaunchApi, Bool, std.core.Option<...>, () -> std.unittest.TestGroupResult)(std/unittest\framework.cj:62)
	at std.unittest.entryMain(std.unittest.TestPackage)(std/unittest\entry_main.cj:44)
    TCS: TestCase_testS1QuatCastScalingZBranch, time elapsed: 13113208300 ns, RESULT:
    [ ERROR  ] CASE: testS1QuatCastScalingZBranch (13112569500 ns)
    REASON: An exception has occurred:StackOverflowError
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)

	at std.unittest.Framework.runCatching.lambda.1()(std/unittest\framework.cj:111)
	at std.unittest.Framework.runCatching(() -> Unit)(std/unittest\framework.cj:111)
	at std.unittest.TestCaseExecutor<...>.executeFiniteSubstrategy.lambda.0.lambda.0()(std/unittest\test_case_executor.cj:220)
	at std.unittest.Framework.runStepBody(std.unittest.StepKind, std.unittest.StepInfo, () -> Unit)(std/unittest\framework.cj:93)
	at std.unittest.DataStrategyProcessor<...>.processNextWith(std.unittest.common.Configuration, (T0, std.core.Array<...>) -> std.unittest.RunStepResult)(std/unittest\strategy_processor.cj:388)
	at std.unittest.TestCaseExecutor<...>.executeFiniteSubstrategy(std.unittest.TestCaseResult, std.unittest.common.Configuration, (T0) -> Unit)(std/unittest\test_case_executor.cj:228)
	at std.unittest.TestCaseExecutor<...>.execute(std.unittest.TestSuiteReportInfo, std.unittest.TestCaseResult, std.unittest.common.Configuration)(std/unittest\test_case_executor.cj:280)
	at std.unittest.TestSuiteExecutor.runSingleCase.lambda.0()(std/unittest\suite_executor.cj:168)
	at std.unittest.TestSuiteExecutor.tryRun(std.unittest.CaseOrBench)(std/unittest\suite_executor.cj:112)
	at std.unittest.TestSuiteExecutor.execute()(std/unittest\suite_executor.cj:53)
	at std.unittest.TestSuite.execute(std.core.String, std.unittest.common.Configuration, std.unittest.FilterService)(std/unittest\api.cj:51)
	at std.unittest.executeWorker(std.core.String, std.core.Array<...>, std.unittest.FilterService)(std/unittest\execution.cj:99)
	at std.unittest.executeSmart(std.core.String, std.core.Array<...>, std.unittest.FilterService, std.unittest.TestOutputReporter, Bool)(std/unittest\execution.cj:0)
	at std.unittest.Framework.launch<...>(std.unittest.LaunchApi, Bool, std.core.Option<...>, () -> std.unittest.TestGroupResult)(std/unittest\framework.cj:62)
	at std.unittest.entryMain(std.unittest.TestPackage)(std/unittest\entry_main.cj:44)
    TCS: TestCase_testS1QuatCastScalingWBranch, time elapsed: 8300783400 ns, RESULT:
    [ ERROR  ] CASE: testS1QuatCastScalingWBranch (8300096800 ns)
    REASON: An exception has occurred:StackOverflowError
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)

	at std.unittest.Framework.runCatching.lambda.1()(std/unittest\framework.cj:111)
	at std.unittest.Framework.runCatching(() -> Unit)(std/unittest\framework.cj:111)
	at std.unittest.TestCaseExecutor<...>.executeFiniteSubstrategy.lambda.0.lambda.0()(std/unittest\test_case_executor.cj:220)
	at std.unittest.Framework.runStepBody(std.unittest.StepKind, std.unittest.StepInfo, () -> Unit)(std/unittest\framework.cj:93)
	at std.unittest.DataStrategyProcessor<...>.processNextWith(std.unittest.common.Configuration, (T0, std.core.Array<...>) -> std.unittest.RunStepResult)(std/unittest\strategy_processor.cj:388)
	at std.unittest.TestCaseExecutor<...>.executeFiniteSubstrategy(std.unittest.TestCaseResult, std.unittest.common.Configuration, (T0) -> Unit)(std/unittest\test_case_executor.cj:228)
	at std.unittest.TestCaseExecutor<...>.execute(std.unittest.TestSuiteReportInfo, std.unittest.TestCaseResult, std.unittest.common.Configuration)(std/unittest\test_case_executor.cj:280)
	at std.unittest.TestSuiteExecutor.runSingleCase.lambda.0()(std/unittest\suite_executor.cj:168)
	at std.unittest.TestSuiteExecutor.tryRun(std.unittest.CaseOrBench)(std/unittest\suite_executor.cj:112)
	at std.unittest.TestSuiteExecutor.execute()(std/unittest\suite_executor.cj:53)
	at std.unittest.TestSuite.execute(std.core.String, std.unittest.common.Configuration, std.unittest.FilterService)(std/unittest\api.cj:51)
	at std.unittest.executeWorker(std.core.String, std.core.Array<...>, std.unittest.FilterService)(std/unittest\execution.cj:99)
	at std.unittest.executeSmart(std.core.String, std.core.Array<...>, std.unittest.FilterService, std.unittest.TestOutputReporter, Bool)(std/unittest\execution.cj:0)
	at std.unittest.Framework.launch<...>(std.unittest.LaunchApi, Bool, std.core.Option<...>, () -> std.unittest.TestGroupResult)(std/unittest\framework.cj:62)
	at std.unittest.entryMain(std.unittest.TestPackage)(std/unittest\entry_main.cj:44)
    TCS: TestCase_testS1QuatCastUnitRoundTrip, time elapsed: 11756437000 ns, RESULT:
    [ ERROR  ] CASE: testS1QuatCastUnitRoundTrip (11755773000 ns)
    REASON: An exception has occurred:StackOverflowError
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)

	at std.unittest.Framework.runCatching.lambda.1()(std/unittest\framework.cj:111)
	at std.unittest.Framework.runCatching(() -> Unit)(std/unittest\framework.cj:111)
	at std.unittest.TestCaseExecutor<...>.executeFiniteSubstrategy.lambda.0.lambda.0()(std/unittest\test_case_executor.cj:220)
	at std.unittest.Framework.runStepBody(std.unittest.StepKind, std.unittest.StepInfo, () -> Unit)(std/unittest\framework.cj:93)
	at std.unittest.DataStrategyProcessor<...>.processNextWith(std.unittest.common.Configuration, (T0, std.core.Array<...>) -> std.unittest.RunStepResult)(std/unittest\strategy_processor.cj:388)
	at std.unittest.TestCaseExecutor<...>.executeFiniteSubstrategy(std.unittest.TestCaseResult, std.unittest.common.Configuration, (T0) -> Unit)(std/unittest\test_case_executor.cj:228)
	at std.unittest.TestCaseExecutor<...>.execute(std.unittest.TestSuiteReportInfo, std.unittest.TestCaseResult, std.unittest.common.Configuration)(std/unittest\test_case_executor.cj:280)
	at std.unittest.TestSuiteExecutor.runSingleCase.lambda.0()(std/unittest\suite_executor.cj:168)
	at std.unittest.TestSuiteExecutor.tryRun(std.unittest.CaseOrBench)(std/unittest\suite_executor.cj:112)
	at std.unittest.TestSuiteExecutor.execute()(std/unittest\suite_executor.cj:53)
	at std.unittest.TestSuite.execute(std.core.String, std.unittest.common.Configuration, std.unittest.FilterService)(std/unittest\api.cj:51)
	at std.unittest.executeWorker(std.core.String, std.core.Array<...>, std.unittest.FilterService)(std/unittest\execution.cj:99)
	at std.unittest.executeSmart(std.core.String, std.core.Array<...>, std.unittest.FilterService, std.unittest.TestOutputReporter, Bool)(std/unittest\execution.cj:0)
	at std.unittest.Framework.launch<...>(std.unittest.LaunchApi, Bool, std.core.Option<...>, () -> std.unittest.TestGroupResult)(std/unittest\framework.cj:62)
	at std.unittest.entryMain(std.unittest.TestPackage)(std/unittest\entry_main.cj:44)
    TCS: TestCase_testS1QuatCastIdentityRoundTrip, time elapsed: 11644428100 ns, RESULT:
    [ ERROR  ] CASE: testS1QuatCastIdentityRoundTrip (11643840500 ns)
    REASON: An exception has occurred:StackOverflowError
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:8)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)

	at std.unittest.Framework.runCatching.lambda.1()(std/unittest\framework.cj:111)
	at std.unittest.Framework.runCatching(() -> Unit)(std/unittest\framework.cj:111)
	at std.unittest.TestCaseExecutor<...>.executeFiniteSubstrategy.lambda.0.lambda.0()(std/unittest\test_case_executor.cj:220)
	at std.unittest.Framework.runStepBody(std.unittest.StepKind, std.unittest.StepInfo, () -> Unit)(std/unittest\framework.cj:93)
	at std.unittest.DataStrategyProcessor<...>.processNextWith(std.unittest.common.Configuration, (T0, std.core.Array<...>) -> std.unittest.RunStepResult)(std/unittest\strategy_processor.cj:388)
	at std.unittest.TestCaseExecutor<...>.executeFiniteSubstrategy(std.unittest.TestCaseResult, std.unittest.common.Configuration, (T0) -> Unit)(std/unittest\test_case_executor.cj:228)
	at std.unittest.TestCaseExecutor<...>.execute(std.unittest.TestSuiteReportInfo, std.unittest.TestCaseResult, std.unittest.common.Configuration)(std/unittest\test_case_executor.cj:280)
	at std.unittest.TestSuiteExecutor.runSingleCase.lambda.0()(std/unittest\suite_executor.cj:168)
	at std.unittest.TestSuiteExecutor.tryRun(std.unittest.CaseOrBench)(std/unittest\suite_executor.cj:112)
	at std.unittest.TestSuiteExecutor.execute()(std/unittest\suite_executor.cj:53)
	at std.unittest.TestSuite.execute(std.core.String, std.unittest.common.Configuration, std.unittest.FilterService)(std/unittest\api.cj:51)
	at std.unittest.executeWorker(std.core.String, std.core.Array<...>, std.unittest.FilterService)(std/unittest\execution.cj:99)
	at std.unittest.executeSmart(std.core.String, std.core.Array<...>, std.unittest.FilterService, std.unittest.TestOutputReporter, Bool)(std/unittest\execution.cj:0)
	at std.unittest.Framework.launch<...>(std.unittest.LaunchApi, Bool, std.core.Option<...>, () -> std.unittest.TestGroupResult)(std/unittest\framework.cj:62)
	at std.unittest.entryMain(std.unittest.TestPackage)(std/unittest\entry_main.cj:44)
    TCS: TestCase_testS1QuatCastMat4Delegation, time elapsed: 7405295600 ns, RESULT:
    [ ERROR  ] CASE: testS1QuatCastMat4Delegation (7404747800 ns)
    REASON: An exception has occurred:StackOverflowError
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)
	 at glm.detail.sqrt<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\exponential.cj:12)
	 at glm.detail.sqrtT<...>(T0)(C:\Develop\Software\cjglm_wp\cjglm\src\detail\stdmath_shim.cj:9)

	at std.unittest.Framework.runCatching.lambda.1()(std/unittest\framework.cj:111)
	at std.unittest.Framework.runCatching(() -> Unit)(std/unittest\framework.cj:111)
	at std.unittest.TestCaseExecutor<...>.executeFiniteSubstrategy.lambda.0.lambda.0()(std/unittest\test_case_executor.cj:220)
	at std.unittest.Framework.runStepBody(std.unittest.StepKind, std.unittest.StepInfo, () -> Unit)(std/unittest\framework.cj:93)
	at std.unittest.DataStrategyProcessor<...>.processNextWith(std.unittest.common.Configuration, (T0, std.core.Array<...>) -> std.unittest.RunStepResult)(std/unittest\strategy_processor.cj:388)
	at std.unittest.TestCaseExecutor<...>.executeFiniteSubstrategy(std.unittest.TestCaseResult, std.unittest.common.Configuration, (T0) -> Unit)(std/unittest\test_case_executor.cj:228)
	at std.unittest.TestCaseExecutor<...>.execute(std.unittest.TestSuiteReportInfo, std.unittest.TestCaseResult, std.unittest.common.Configuration)(std/unittest\test_case_executor.cj:280)
	at std.unittest.TestSuiteExecutor.runSingleCase.lambda.0()(std/unittest\suite_executor.cj:168)
	at std.unittest.TestSuiteExecutor.tryRun(std.unittest.CaseOrBench)(std/unittest\suite_executor.cj:112)
	at std.unittest.TestSuiteExecutor.execute()(std/unittest\suite_executor.cj:53)
	at std.unittest.TestSuite.execute(std.core.String, std.unittest.common.Configuration, std.unittest.FilterService)(std/unittest\api.cj:51)
	at std.unittest.executeWorker(std.core.String, std.core.Array<...>, std.unittest.FilterService)(std/unittest\execution.cj:99)
	at std.unittest.executeSmart(std.core.String, std.core.Array<...>, std.unittest.FilterService, std.unittest.TestOutputReporter, Bool)(std/unittest\execution.cj:0)
	at std.unittest.Framework.launch<...>(std.unittest.LaunchApi, Bool, std.core.Option<...>, () -> std.unittest.TestGroupResult)(std/unittest\framework.cj:62)
	at std.unittest.entryMain(std.unittest.TestPackage)(std/unittest\entry_main.cj:44)
    TCS: TestCase_testMat3EqualEpsilonRelaxedExactMatch, time elapsed: 261100 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedExactMatch (19700 ns)
    TCS: TestCase_testMat3EqualEpsilonRelaxedWithinPosTolerance, time elapsed: 217100 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedWithinPosTolerance (12800 ns)
    TCS: TestCase_testMat3EqualEpsilonRelaxedWithinNegTolerance, time elapsed: 202500 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedWithinNegTolerance (9200 ns)
    TCS: TestCase_testMat3EqualEpsilonRelaxedBeyondTolerance, time elapsed: 192000 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedBeyondTolerance (8100 ns)
    TCS: TestCase_testMat3EqualEpsilonRelaxedZeroMatrix, time elapsed: 193000 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedZeroMatrix (7300 ns)
    TCS: TestCase_testMat3EqualEpsilonRelaxedSingleDiffBeyond, time elapsed: 194800 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedSingleDiffBeyond (7700 ns)
    TCS: TestCase_testVec2ScalarInit, time elapsed: 237600 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarInit (30500 ns)
    TCS: TestCase_testVec2ConstInit, time elapsed: 194800 ns, RESULT:
    [ PASSED ] CASE: testVec2ConstInit (12600 ns)
    TCS: TestCase_testVec2Length, time elapsed: 185300 ns, RESULT:
    [ PASSED ] CASE: testVec2Length (6400 ns)
    TCS: TestCase_testVec2Add, time elapsed: 195400 ns, RESULT:
    [ PASSED ] CASE: testVec2Add (17400 ns)
    TCS: TestCase_testVec2Sub, time elapsed: 194000 ns, RESULT:
    [ PASSED ] CASE: testVec2Sub (12700 ns)
    TCS: TestCase_testVec2Mul, time elapsed: 205500 ns, RESULT:
    [ PASSED ] CASE: testVec2Mul (14600 ns)
    TCS: TestCase_testVec2ScalarAdd, time elapsed: 198000 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarAdd (12800 ns)
    TCS: TestCase_testVec2Negate, time elapsed: 194500 ns, RESULT:
    [ PASSED ] CASE: testVec2Negate (12000 ns)
    TCS: TestCase_testVec2IndexAccess, time elapsed: 186800 ns, RESULT:
    [ PASSED ] CASE: testVec2IndexAccess (7200 ns)
    TCS: TestCase_testVec2IndexMutate, time elapsed: 227700 ns, RESULT:
    [ PASSED ] CASE: testVec2IndexMutate (8500 ns)
    TCS: TestCase_testVec2ComponentAt, time elapsed: 212400 ns, RESULT:
    [ PASSED ] CASE: testVec2ComponentAt (16300 ns)
    TCS: TestCase_testVec2Equal, time elapsed: 267500 ns, RESULT:
    [ PASSED ] CASE: testVec2Equal (21900 ns)
    TCS: TestCase_testVec2NotEqual, time elapsed: 296200 ns, RESULT:
    [ PASSED ] CASE: testVec2NotEqual (27400 ns)
    TCS: TestCase_testVec2EqualExact, time elapsed: 680300 ns, RESULT:
    [ PASSED ] CASE: testVec2EqualExact (146400 ns)
    TCS: TestCase_testVec2BitwiseAnd, time elapsed: 290400 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseAnd (22300 ns)
    TCS: TestCase_testVec2BitwiseNot, time elapsed: 195700 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseNot (14000 ns)
    TCS: TestCase_testVec2FromVec1, time elapsed: 178300 ns, RESULT:
    [ PASSED ] CASE: testVec2FromVec1 (7900 ns)
    TCS: TestCase_testVec2ShiftLeft, time elapsed: 203300 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftLeft (18000 ns)
    TCS: TestCase_testVec2BoolLogicalAnd, time elapsed: 437100 ns, RESULT:
    [ PASSED ] CASE: testVec2BoolLogicalAnd (26200 ns)
    TCS: TestCase_testVec2Vec1ArithBroadcast, time elapsed: 206900 ns, RESULT:
    [ PASSED ] CASE: testVec2Vec1ArithBroadcast (18300 ns)
    TCS: TestCase_testVec2Vec1BitBroadcast, time elapsed: 217500 ns, RESULT:
    [ PASSED ] CASE: testVec2Vec1BitBroadcast (19600 ns)
    TCS: TestCase_testVec2ShiftLeftVec1, time elapsed: 186000 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftLeftVec1 (12000 ns)
    TCS: TestCase_testVec2Div, time elapsed: 190400 ns, RESULT:
    [ PASSED ] CASE: testVec2Div (15100 ns)
    TCS: TestCase_testVec2Mod, time elapsed: 200900 ns, RESULT:
    [ PASSED ] CASE: testVec2Mod (16000 ns)
    TCS: TestCase_testVec2ScalarSub, time elapsed: 206600 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarSub (15800 ns)
    TCS: TestCase_testVec2ScalarMul, time elapsed: 219200 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarMul (7800 ns)
    TCS: TestCase_testVec2ScalarDiv, time elapsed: 194700 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarDiv (13400 ns)
    TCS: TestCase_testVec2ScalarMod, time elapsed: 632500 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarMod (25200 ns)
    TCS: TestCase_testVec2BoolLogicalOr, time elapsed: 205800 ns, RESULT:
    [ PASSED ] CASE: testVec2BoolLogicalOr (11300 ns)
    TCS: TestCase_testVec2EqualEpsilon, time elapsed: 208800 ns, RESULT:
    [ PASSED ] CASE: testVec2EqualEpsilon (16400 ns)
    TCS: TestCase_testVec2DivNamed, time elapsed: 191500 ns, RESULT:
    [ PASSED ] CASE: testVec2DivNamed (8400 ns)
    TCS: TestCase_testVec2ModNamed, time elapsed: 235900 ns, RESULT:
    [ PASSED ] CASE: testVec2ModNamed (8600 ns)
    TCS: TestCase_testVec2BitwiseOr, time elapsed: 537200 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseOr (44000 ns)
    TCS: TestCase_testVec2BitwiseXor, time elapsed: 320000 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseXor (20500 ns)
    TCS: TestCase_testVec2ScalarBitwiseAnd, time elapsed: 268300 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarBitwiseAnd (14500 ns)
    TCS: TestCase_testVec2ShiftRight, time elapsed: 273300 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftRight (15700 ns)
    TCS: TestCase_testVec2ShiftRightVec1, time elapsed: 254100 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftRightVec1 (23100 ns)
    TCS: TestCase_testVec2AddNamed, time elapsed: 210000 ns, RESULT:
    [ PASSED ] CASE: testVec2AddNamed (9600 ns)
    TCS: TestCase_testVec2SubNamed, time elapsed: 194400 ns, RESULT:
    [ PASSED ] CASE: testVec2SubNamed (7600 ns)
    TCS: TestCase_testVec2MulNamed, time elapsed: 192500 ns, RESULT:
    [ PASSED ] CASE: testVec2MulNamed (10200 ns)
    TCS: TestCase_testVec2ShiftLeftVec, time elapsed: 192500 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftLeftVec (7900 ns)
    TCS: TestCase_testVec2ShiftRightVec, time elapsed: 199100 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftRightVec (8600 ns)
    TCS: TestCase_testVec2ScalarBitwiseOr, time elapsed: 199000 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarBitwiseOr (17100 ns)
    TCS: TestCase_testVec2ScalarBitwiseXor, time elapsed: 206900 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarBitwiseXor (13700 ns)
    TCS: TestCase_testVec2Increment, time elapsed: 220100 ns, RESULT:
    [ PASSED ] CASE: testVec2Increment (17500 ns)
    TCS: TestCase_testVec2Decrement, time elapsed: 205100 ns, RESULT:
    [ PASSED ] CASE: testVec2Decrement (16900 ns)
    TCS: TestCase_testVec2IndexOutOfBoundsAccess, time elapsed: 19503200 ns, RESULT:
    [ PASSED ] CASE: testVec2IndexOutOfBoundsAccess (18907800 ns)
    TCS: TestCase_testVec2NegativeIndexAccess, time elapsed: 428900 ns, RESULT:
    [ PASSED ] CASE: testVec2NegativeIndexAccess (91300 ns)
    TCS: TestCase_testVec3ScalarInit, time elapsed: 311400 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarInit (26100 ns)
    TCS: TestCase_testVec3ConstInit, time elapsed: 357700 ns, RESULT:
    [ PASSED ] CASE: testVec3ConstInit (15300 ns)
    TCS: TestCase_testVec3Length, time elapsed: 241700 ns, RESULT:
    [ PASSED ] CASE: testVec3Length (13500 ns)
    TCS: TestCase_testVec3Add, time elapsed: 275700 ns, RESULT:
    [ PASSED ] CASE: testVec3Add (47500 ns)
    TCS: TestCase_testVec3ScalarMul, time elapsed: 209400 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarMul (20100 ns)
    TCS: TestCase_testVec3Negate, time elapsed: 230300 ns, RESULT:
    [ PASSED ] CASE: testVec3Negate (15300 ns)
    TCS: TestCase_testVec3IndexAccess, time elapsed: 198400 ns, RESULT:
    [ PASSED ] CASE: testVec3IndexAccess (13300 ns)
    TCS: TestCase_testVec3IndexMutate, time elapsed: 298300 ns, RESULT:
    [ PASSED ] CASE: testVec3IndexMutate (12100 ns)
    TCS: TestCase_testVec3ComponentAt, time elapsed: 556500 ns, RESULT:
    [ PASSED ] CASE: testVec3ComponentAt (51800 ns)
    TCS: TestCase_testVec3Equal, time elapsed: 297500 ns, RESULT:
    [ PASSED ] CASE: testVec3Equal (33400 ns)
    TCS: TestCase_testVec3NotEqual, time elapsed: 230700 ns, RESULT:
    [ PASSED ] CASE: testVec3NotEqual (19700 ns)
    TCS: TestCase_testVec3EqualExact, time elapsed: 210000 ns, RESULT:
    [ PASSED ] CASE: testVec3EqualExact (16600 ns)
    TCS: TestCase_testVec3BitwiseAnd, time elapsed: 207800 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseAnd (17600 ns)
    TCS: TestCase_testVec3BitwiseNot, time elapsed: 193500 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseNot (10400 ns)
    TCS: TestCase_testVec3Vec1ArithBroadcast, time elapsed: 234600 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1ArithBroadcast (20300 ns)
    TCS: TestCase_testVec3ShiftLeft, time elapsed: 205400 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftLeft (15700 ns)
    TCS: TestCase_testVec3BoolLogicalAnd, time elapsed: 202900 ns, RESULT:
    [ PASSED ] CASE: testVec3BoolLogicalAnd (14600 ns)
    TCS: TestCase_testVec3Sub, time elapsed: 206100 ns, RESULT:
    [ PASSED ] CASE: testVec3Sub (17100 ns)
    TCS: TestCase_testVec3Div, time elapsed: 201200 ns, RESULT:
    [ PASSED ] CASE: testVec3Div (15500 ns)
    TCS: TestCase_testVec3Mod, time elapsed: 232700 ns, RESULT:
    [ PASSED ] CASE: testVec3Mod (18200 ns)
    TCS: TestCase_testVec3ScalarSub, time elapsed: 197400 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarSub (13400 ns)
    TCS: TestCase_testVec3ScalarDiv, time elapsed: 509200 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarDiv (29800 ns)
    TCS: TestCase_testVec3ScalarMod, time elapsed: 237500 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarMod (17800 ns)
    TCS: TestCase_testVec3BoolLogicalOr, time elapsed: 228200 ns, RESULT:
    [ PASSED ] CASE: testVec3BoolLogicalOr (10400 ns)
    TCS: TestCase_testVec3EqualEpsilon, time elapsed: 323100 ns, RESULT:
    [ PASSED ] CASE: testVec3EqualEpsilon (34100 ns)
    TCS: TestCase_testVec3AddNamed, time elapsed: 376800 ns, RESULT:
    [ PASSED ] CASE: testVec3AddNamed (31900 ns)
    TCS: TestCase_testVec3MulNamed, time elapsed: 272000 ns, RESULT:
    [ PASSED ] CASE: testVec3MulNamed (11900 ns)
    TCS: TestCase_testVec3DivNamed, time elapsed: 216800 ns, RESULT:
    [ PASSED ] CASE: testVec3DivNamed (8700 ns)
    TCS: TestCase_testVec3ModNamed, time elapsed: 216400 ns, RESULT:
    [ PASSED ] CASE: testVec3ModNamed (10000 ns)
    TCS: TestCase_testVec3BitwiseOr, time elapsed: 216500 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseOr (23000 ns)
    TCS: TestCase_testVec3BitwiseXor, time elapsed: 227900 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseXor (21100 ns)
    TCS: TestCase_testVec3ScalarBitwiseAnd, time elapsed: 216200 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarBitwiseAnd (15500 ns)
    TCS: TestCase_testVec3ShiftRight, time elapsed: 205700 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftRight (13500 ns)
    TCS: TestCase_testVec3Vec1BitBroadcast, time elapsed: 204500 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1BitBroadcast (17200 ns)
    TCS: TestCase_testVec3ShiftRightVec1, time elapsed: 212500 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftRightVec1 (15800 ns)
    TCS: TestCase_testVec3FromVec1, time elapsed: 183300 ns, RESULT:
    [ PASSED ] CASE: testVec3FromVec1 (9900 ns)
    TCS: TestCase_testVec3ScalarBitwiseOr, time elapsed: 196500 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarBitwiseOr (14200 ns)
    TCS: TestCase_testVec3ScalarBitwiseXor, time elapsed: 205200 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarBitwiseXor (13100 ns)
    TCS: TestCase_testVec3Vec1BitOrBroadcast, time elapsed: 209800 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1BitOrBroadcast (15100 ns)
    TCS: TestCase_testVec3Vec1BitXorBroadcast, time elapsed: 195700 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1BitXorBroadcast (15500 ns)
    TCS: TestCase_testVec3ShiftLeftVec1, time elapsed: 227100 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftLeftVec1 (15400 ns)
    TCS: TestCase_testVec3ShiftLeftVec, time elapsed: 371800 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftLeftVec (33900 ns)
    TCS: TestCase_testVec3ShiftRightVec, time elapsed: 248300 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftRightVec (19800 ns)
    TCS: TestCase_testVec3Increment, time elapsed: 192300 ns, RESULT:
    [ PASSED ] CASE: testVec3Increment (20000 ns)
    TCS: TestCase_testVec3Decrement, time elapsed: 189800 ns, RESULT:
    [ PASSED ] CASE: testVec3Decrement (15900 ns)
    TCS: TestCase_testVec3IndexOutOfBoundsAccess, time elapsed: 217500 ns, RESULT:
    [ PASSED ] CASE: testVec3IndexOutOfBoundsAccess (45500 ns)
    TCS: TestCase_testVec3NegativeIndexAccess, time elapsed: 216200 ns, RESULT:
    [ PASSED ] CASE: testVec3NegativeIndexAccess (25900 ns)
    TCS: TestCase_testVec4ScalarInit, time elapsed: 191500 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarInit (14600 ns)
    TCS: TestCase_testVec4ConstInit, time elapsed: 179600 ns, RESULT:
    [ PASSED ] CASE: testVec4ConstInit (7700 ns)
    TCS: TestCase_testVec4Length, time elapsed: 179900 ns, RESULT:
    [ PASSED ] CASE: testVec4Length (7300 ns)
    TCS: TestCase_testVec4Add, time elapsed: 193900 ns, RESULT:
    [ PASSED ] CASE: testVec4Add (20600 ns)
    TCS: TestCase_testVec4ScalarMul, time elapsed: 225000 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarMul (23300 ns)
    TCS: TestCase_testVec4Negate, time elapsed: 187200 ns, RESULT:
    [ PASSED ] CASE: testVec4Negate (14800 ns)
    TCS: TestCase_testVec4IndexAccess, time elapsed: 228300 ns, RESULT:
    [ PASSED ] CASE: testVec4IndexAccess (21200 ns)
    TCS: TestCase_testVec4IndexMutate, time elapsed: 175000 ns, RESULT:
    [ PASSED ] CASE: testVec4IndexMutate (7500 ns)
    TCS: TestCase_testVec4ComponentAt, time elapsed: 177600 ns, RESULT:
    [ PASSED ] CASE: testVec4ComponentAt (7500 ns)
    TCS: TestCase_testVec4Equal, time elapsed: 188700 ns, RESULT:
    [ PASSED ] CASE: testVec4Equal (18100 ns)
    TCS: TestCase_testVec4NotEqual, time elapsed: 184200 ns, RESULT:
    [ PASSED ] CASE: testVec4NotEqual (15600 ns)
    TCS: TestCase_testVec4EqualExact, time elapsed: 183500 ns, RESULT:
    [ PASSED ] CASE: testVec4EqualExact (13500 ns)
    TCS: TestCase_testVec4BitwiseAnd, time elapsed: 197500 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseAnd (18900 ns)
    TCS: TestCase_testVec4BitwiseNot, time elapsed: 189600 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseNot (14500 ns)
    TCS: TestCase_testVec4Vec1ArithBroadcast, time elapsed: 311800 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1ArithBroadcast (28900 ns)
    TCS: TestCase_testVec4ShiftLeft, time elapsed: 210200 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftLeft (17200 ns)
    TCS: TestCase_testVec4BoolLogicalAnd, time elapsed: 201800 ns, RESULT:
    [ PASSED ] CASE: testVec4BoolLogicalAnd (13900 ns)
    TCS: TestCase_testVec4Sub, time elapsed: 200800 ns, RESULT:
    [ PASSED ] CASE: testVec4Sub (16100 ns)
    TCS: TestCase_testVec4Div, time elapsed: 205100 ns, RESULT:
    [ PASSED ] CASE: testVec4Div (15800 ns)
    TCS: TestCase_testVec4Mod, time elapsed: 204000 ns, RESULT:
    [ PASSED ] CASE: testVec4Mod (18200 ns)
    TCS: TestCase_testVec4ScalarSub, time elapsed: 199700 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarSub (13000 ns)
    TCS: TestCase_testVec4ScalarDiv, time elapsed: 204100 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarDiv (17600 ns)
    TCS: TestCase_testVec4ScalarMod, time elapsed: 203800 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarMod (15300 ns)
    TCS: TestCase_testVec4BoolLogicalOr, time elapsed: 197300 ns, RESULT:
    [ PASSED ] CASE: testVec4BoolLogicalOr (8800 ns)
    TCS: TestCase_testVec4EqualEpsilon, time elapsed: 214900 ns, RESULT:
    [ PASSED ] CASE: testVec4EqualEpsilon (24000 ns)
    TCS: TestCase_testVec4AddNamed, time elapsed: 210800 ns, RESULT:
    [ PASSED ] CASE: testVec4AddNamed (18600 ns)
    TCS: TestCase_testVec4MulNamed, time elapsed: 188100 ns, RESULT:
    [ PASSED ] CASE: testVec4MulNamed (9900 ns)
    TCS: TestCase_testVec4DivNamed, time elapsed: 184900 ns, RESULT:
    [ PASSED ] CASE: testVec4DivNamed (7500 ns)
    TCS: TestCase_testVec4ModNamed, time elapsed: 190000 ns, RESULT:
    [ PASSED ] CASE: testVec4ModNamed (7800 ns)
    TCS: TestCase_testVec4BitwiseOr, time elapsed: 230600 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseOr (17700 ns)
    TCS: TestCase_testVec4BitwiseXor, time elapsed: 367800 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseXor (30600 ns)
    TCS: TestCase_testVec4ScalarBitwiseAnd, time elapsed: 333000 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarBitwiseAnd (29700 ns)
    TCS: TestCase_testVec4ShiftRight, time elapsed: 262900 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftRight (23400 ns)
    TCS: TestCase_testVec4Vec1BitBroadcast, time elapsed: 242500 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1BitBroadcast (28600 ns)
    TCS: TestCase_testVec4ShiftRightVec1, time elapsed: 217100 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftRightVec1 (22600 ns)
    TCS: TestCase_testVec4FromVec1, time elapsed: 196600 ns, RESULT:
    [ PASSED ] CASE: testVec4FromVec1 (7900 ns)
    TCS: TestCase_testVec4ScalarBitwiseOr, time elapsed: 212500 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarBitwiseOr (16300 ns)
    TCS: TestCase_testVec4ScalarBitwiseXor, time elapsed: 214200 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarBitwiseXor (17900 ns)
    TCS: TestCase_testVec4Vec1BitOrBroadcast, time elapsed: 203500 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1BitOrBroadcast (16000 ns)
    TCS: TestCase_testVec4Vec1BitXorBroadcast, time elapsed: 205000 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1BitXorBroadcast (15700 ns)
    TCS: TestCase_testVec4ShiftLeftVec1, time elapsed: 238400 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftLeftVec1 (12000 ns)
    TCS: TestCase_testVec4ShiftLeftVec, time elapsed: 203800 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftLeftVec (16100 ns)
    TCS: TestCase_testVec4ShiftRightVec, time elapsed: 196600 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftRightVec (12400 ns)
    TCS: TestCase_testVec4Increment, time elapsed: 202900 ns, RESULT:
    [ PASSED ] CASE: testVec4Increment (20100 ns)
    TCS: TestCase_testVec4Decrement, time elapsed: 346000 ns, RESULT:
    [ PASSED ] CASE: testVec4Decrement (31700 ns)
    TCS: TestCase_testVec4IndexOutOfBoundsAccess, time elapsed: 229500 ns, RESULT:
    [ PASSED ] CASE: testVec4IndexOutOfBoundsAccess (48600 ns)
    TCS: TestCase_testVec4NegativeIndexAccess, time elapsed: 214600 ns, RESULT:
    [ PASSED ] CASE: testVec4NegativeIndexAccess (24700 ns)
    TCS: TestCase_testFunctor1Vec1Identity, time elapsed: 217900 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec1Identity (12200 ns)
    TCS: TestCase_testFunctor1Vec1Transform, time elapsed: 285600 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec1Transform (15400 ns)
    TCS: TestCase_testFunctor1Vec2Transform, time elapsed: 205500 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec2Transform (9700 ns)
    TCS: TestCase_testFunctor2Vec1Add, time elapsed: 190700 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec1Add (10600 ns)
    TCS: TestCase_testFunctor2VecScaVec1Mul, time elapsed: 200800 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec1Mul (26200 ns)
    TCS: TestCase_testFunctor2VecIntVec1Shift, time elapsed: 189000 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec1Shift (15100 ns)
    TCS: TestCase_testFunctor1Vec3Transform, time elapsed: 219300 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec3Transform (11900 ns)
    TCS: TestCase_testFunctor1Vec4Transform, time elapsed: 274900 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec4Transform (15100 ns)
    TCS: TestCase_testFunctor2Vec2Add, time elapsed: 332900 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec2Add (14700 ns)
    TCS: TestCase_testFunctor2Vec3Add, time elapsed: 286700 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec3Add (14600 ns)
    TCS: TestCase_testFunctor2Vec4Add, time elapsed: 254300 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec4Add (15200 ns)
    TCS: TestCase_testFunctor2VecScaVec2Mul, time elapsed: 211100 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec2Mul (13300 ns)
    TCS: TestCase_testFunctor2VecScaVec3Mul, time elapsed: 218500 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec3Mul (24200 ns)
    TCS: TestCase_testFunctor2VecScaVec4Mul, time elapsed: 203100 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec4Mul (7900 ns)
    TCS: TestCase_testFunctor2VecIntVec2Shift, time elapsed: 194100 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec2Shift (8500 ns)
    TCS: TestCase_testFunctor2VecIntVec3Shift, time elapsed: 193700 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec3Shift (8000 ns)
    TCS: TestCase_testFunctor2VecIntVec4Shift, time elapsed: 190200 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec4Shift (7600 ns)
Summary: TOTAL: 435
    PASSED: 428, SKIPPED: 0, ERROR: 7
    FAILED: 0, listed below:
            TCS: TestCase_testS1QuatCastScalingXBranch, CASE: testS1QuatCastScalingXBranch
            TCS: TestCase_testS1QuatCastScalingYBranch, CASE: testS1QuatCastScalingYBranch
            TCS: TestCase_testS1QuatCastScalingZBranch, CASE: testS1QuatCastScalingZBranch
            TCS: TestCase_testS1QuatCastScalingWBranch, CASE: testS1QuatCastScalingWBranch
            TCS: TestCase_testS1QuatCastUnitRoundTrip, CASE: testS1QuatCastUnitRoundTrip
            TCS: TestCase_testS1QuatCastIdentityRoundTrip, CASE: testS1QuatCastIdentityRoundTrip
            TCS: TestCase_testS1QuatCastMat4Delegation, CASE: testS1QuatCastMat4Delegation
--------------------------------------------------------------------------------------------------
Project tests finished, time elapsed: 84449852200 ns, RESULT:
TP: glm.*, time elapsed: 84449803400 ns, RESULT:
    FAILED:
    TP: glm.detail, time elapsed: 84434981000 ns, RESULT:
        TCS: TestCase_testComputeVecAdd1, time elapsed: 2089200 ns, RESULT:
        TCS: TestCase_testComputeVecSub2, time elapsed: 414400 ns, RESULT:
        TCS: TestCase_testComputeVecMul3, time elapsed: 400200 ns, RESULT:
        TCS: TestCase_testComputeVecMod1, time elapsed: 402200 ns, RESULT:
        TCS: TestCase_testComputeVecMod4, time elapsed: 373400 ns, RESULT:
        TCS: TestCase_testComputeVecAnd1, time elapsed: 351500 ns, RESULT:
        TCS: TestCase_testComputeVecAnd3, time elapsed: 343100 ns, RESULT:
        TCS: TestCase_testComputeVecOr1, time elapsed: 368600 ns, RESULT:
        TCS: TestCase_testComputeVecOr2, time elapsed: 357600 ns, RESULT:
        TCS: TestCase_testComputeVecXor1, time elapsed: 441500 ns, RESULT:
        TCS: TestCase_testComputeVecXor4, time elapsed: 368900 ns, RESULT:
        TCS: TestCase_testComputeVecShiftLeft1, time elapsed: 384500 ns, RESULT:
        TCS: TestCase_testComputeVecShiftLeft3, time elapsed: 360900 ns, RESULT:
        TCS: TestCase_testComputeVecShiftRight1, time elapsed: 431800 ns, RESULT:
        TCS: TestCase_testComputeVecShiftRight4, time elapsed: 697700 ns, RESULT:
        TCS: TestCase_testComputeVecEqual1, time elapsed: 424000 ns, RESULT:
        TCS: TestCase_testComputeVecNequal4, time elapsed: 303500 ns, RESULT:
        TCS: TestCase_testComputeVecBitwiseNot1, time elapsed: 346800 ns, RESULT:
        TCS: TestCase_testComputeVecBitwiseNot3, time elapsed: 318000 ns, RESULT:
        TCS: TestCase_testComputeVecAdd4, time elapsed: 323700 ns, RESULT:
        TCS: TestCase_testComputeVecSub1, time elapsed: 827500 ns, RESULT:
        TCS: TestCase_testComputeVecSub3, time elapsed: 257800 ns, RESULT:
        TCS: TestCase_testComputeVecMul1, time elapsed: 230200 ns, RESULT:
        TCS: TestCase_testComputeVecMul2, time elapsed: 347400 ns, RESULT:
        TCS: TestCase_testComputeVecDiv1, time elapsed: 343700 ns, RESULT:
        TCS: TestCase_testComputeVecDiv2, time elapsed: 222300 ns, RESULT:
        TCS: TestCase_testComputeVecDiv4, time elapsed: 438500 ns, RESULT:
        TCS: TestCase_testComputeVecEqual2, time elapsed: 579500 ns, RESULT:
        TCS: TestCase_testComputeVecEqual3, time elapsed: 546100 ns, RESULT:
        TCS: TestCase_testComputeVecEqual4, time elapsed: 593000 ns, RESULT:
        TCS: TestCase_testComputeVecNequal1, time elapsed: 226500 ns, RESULT:
        TCS: TestCase_testComputeVecNequal2, time elapsed: 214400 ns, RESULT:
        TCS: TestCase_testComputeVecBitwiseNot4, time elapsed: 239600 ns, RESULT:
        TCS: TestCase_testComputeVecAddFloat32, time elapsed: 235200 ns, RESULT:
        TCS: TestCase_testComputeVecAddFloat32Vec3, time elapsed: 252700 ns, RESULT:
        TCS: TestCase_testComputeVecSubFloat32, time elapsed: 208000 ns, RESULT:
        TCS: TestCase_testComputeVecSubFloat32Vec4, time elapsed: 218600 ns, RESULT:
        TCS: TestCase_testComputeEqualInt32Equal, time elapsed: 206100 ns, RESULT:
        TCS: TestCase_testComputeEqualInt32NotEqual, time elapsed: 196700 ns, RESULT:
        TCS: TestCase_testComputeEqualFloat32Equal, time elapsed: 211500 ns, RESULT:
        TCS: TestCase_testComputeEqualFloat32NotEqual, time elapsed: 195900 ns, RESULT:
        TCS: TestCase_testComputeEqualFloat64Equal, time elapsed: 196700 ns, RESULT:
        TCS: TestCase_testComputeEqualFloat64NotEqual, time elapsed: 359500 ns, RESULT:
        TCS: TestCase_testComputeEqualBoolEqual, time elapsed: 327800 ns, RESULT:
        TCS: TestCase_testComputeEqualBoolNotEqual, time elapsed: 323200 ns, RESULT:
        TCS: TestCase_testComputeEqualNumericInt32, time elapsed: 216600 ns, RESULT:
        TCS: TestCase_testComputeEqualNumericFloat32, time elapsed: 280800 ns, RESULT:
        TCS: TestCase_testComputeEqualNumericFloat32Epsilon, time elapsed: 264900 ns, RESULT:
        TCS: TestCase_testComputeEqualNumericFloat64, time elapsed: 349900 ns, RESULT:
        TCS: TestCase_testComputeEqualInt64Equal, time elapsed: 395500 ns, RESULT:
        TCS: TestCase_testComputeEqualInt64NotEqual, time elapsed: 351800 ns, RESULT:
        TCS: TestCase_testComputeEqualFloat32Nan, time elapsed: 398100 ns, RESULT:
        TCS: TestCase_testComputeEqualFloat64Nan, time elapsed: 267000 ns, RESULT:
        TCS: TestCase_testComputeEqualFloat32SignedZero, time elapsed: 263800 ns, RESULT:
        TCS: TestCase_testComputeEqualFloat64SignedZero, time elapsed: 217300 ns, RESULT:
        TCS: TestCase_testComputeEqualNumericFloat32NotEqual, time elapsed: 225400 ns, RESULT:
        TCS: TestCase_testComputeEqualNumericFloat32BeyondEpsilon, time elapsed: 221300 ns, RESULT:
        TCS: TestCase_testComputeEqualNumericFloat64NotEqual, time elapsed: 209600 ns, RESULT:
        TCS: TestCase_testComputeEqualNumericFloat64Epsilon, time elapsed: 401300 ns, RESULT:
        TCS: TestCase_testComputeEqualNumericFloat64BeyondEpsilon, time elapsed: 295600 ns, RESULT:
        TCS: TestCase_testComputeEqualNumericInt64, time elapsed: 226700 ns, RESULT:
        TCS: TestCase_testPackedHighpImplementsQualifier, time elapsed: 475300 ns, RESULT:
        TCS: TestCase_testPackedMediumpImplementsQualifier, time elapsed: 216700 ns, RESULT:
        TCS: TestCase_testPackedLowpImplementsQualifier, time elapsed: 200800 ns, RESULT:
        TCS: TestCase_testDefaultpIsPackedHighp, time elapsed: 236700 ns, RESULT:
        TCS: TestCase_testScalarAddVec1, time elapsed: 220300 ns, RESULT:
        TCS: TestCase_testScalarAddVec2, time elapsed: 217600 ns, RESULT:
        TCS: TestCase_testScalarAddVec3, time elapsed: 219500 ns, RESULT:
        TCS: TestCase_testScalarAddVec4, time elapsed: 231400 ns, RESULT:
        TCS: TestCase_testScalarSubVec1, time elapsed: 224800 ns, RESULT:
        TCS: TestCase_testScalarMulVec1, time elapsed: 232200 ns, RESULT:
        TCS: TestCase_testScalarDivVec1, time elapsed: 300200 ns, RESULT:
        TCS: TestCase_testScalarModVec1, time elapsed: 243800 ns, RESULT:
        TCS: TestCase_testScalarMulVec2, time elapsed: 280700 ns, RESULT:
        TCS: TestCase_testScalarSubVec2, time elapsed: 229700 ns, RESULT:
        TCS: TestCase_testScalarSubVec3, time elapsed: 212900 ns, RESULT:
        TCS: TestCase_testScalarSubVec4, time elapsed: 219500 ns, RESULT:
        TCS: TestCase_testScalarMulVec3, time elapsed: 220200 ns, RESULT:
        TCS: TestCase_testScalarMulVec4, time elapsed: 225200 ns, RESULT:
        TCS: TestCase_testScalarDivVec2, time elapsed: 205800 ns, RESULT:
        TCS: TestCase_testScalarDivVec3, time elapsed: 249600 ns, RESULT:
        TCS: TestCase_testScalarDivVec4, time elapsed: 214100 ns, RESULT:
        TCS: TestCase_testScalarModVec2, time elapsed: 222100 ns, RESULT:
        TCS: TestCase_testScalarModVec3, time elapsed: 205600 ns, RESULT:
        TCS: TestCase_testScalarModVec4, time elapsed: 228700 ns, RESULT:
        TCS: TestCase_testScalarModVec1Float32, time elapsed: 323900 ns, RESULT:
        TCS: TestCase_testScalarModVec2Float32, time elapsed: 253400 ns, RESULT:
        TCS: TestCase_testScalarModVec3Float32, time elapsed: 223400 ns, RESULT:
        TCS: TestCase_testScalarModVec4Float32, time elapsed: 218800 ns, RESULT:
        TCS: TestCase_testScalarModVec1Float64, time elapsed: 241700 ns, RESULT:
        TCS: TestCase_testScalarModVec2Float64, time elapsed: 211600 ns, RESULT:
        TCS: TestCase_testScalarModVec3Float64, time elapsed: 203800 ns, RESULT:
        TCS: TestCase_testScalarModVec4Float64, time elapsed: 215600 ns, RESULT:
        TCS: TestCase_testScalarModVec1Float16, time elapsed: 243400 ns, RESULT:
        TCS: TestCase_testScalarModVec2Float16, time elapsed: 213900 ns, RESULT:
        TCS: TestCase_testScalarModVec3Float16, time elapsed: 234900 ns, RESULT:
        TCS: TestCase_testScalarModVec4Float16, time elapsed: 314700 ns, RESULT:
        TCS: TestCase_testScalarSubVec2PackedMediump, time elapsed: 299600 ns, RESULT:
        TCS: TestCase_testScalarSubVec2PackedLowp, time elapsed: 255300 ns, RESULT:
        TCS: TestCase_testScalarMulVec2PackedMediump, time elapsed: 223000 ns, RESULT:
        TCS: TestCase_testScalarMulVec2PackedLowp, time elapsed: 205100 ns, RESULT:
        TCS: TestCase_testScalarDivVec2PackedMediump, time elapsed: 227800 ns, RESULT:
        TCS: TestCase_testScalarDivVec2PackedLowp, time elapsed: 249900 ns, RESULT:
        TCS: TestCase_testScalarModVec2PackedMediump, time elapsed: 222300 ns, RESULT:
        TCS: TestCase_testScalarModVec2PackedLowp, time elapsed: 200200 ns, RESULT:
        TCS: TestCase_testScalarModVec2Float32PackedMediump, time elapsed: 735600 ns, RESULT:
        TCS: TestCase_testScalarModVec2Float32PackedLowp, time elapsed: 331900 ns, RESULT:
        TCS: TestCase_testScalarModVec2Float32NegativeDividend, time elapsed: 290000 ns, RESULT:
        TCS: TestCase_testScalarModVec2Float32NegativeDivisor, time elapsed: 280600 ns, RESULT:
        TCS: TestCase_testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents, time elapsed: 419700 ns, RESULT:
        TCS: TestCase_testScalarAddVec1Float32, time elapsed: 225000 ns, RESULT:
        TCS: TestCase_testScalarAddVec2Float32, time elapsed: 255800 ns, RESULT:
        TCS: TestCase_testScalarAddVec3Float32, time elapsed: 215400 ns, RESULT:
        TCS: TestCase_testScalarAddVec4Float32, time elapsed: 254700 ns, RESULT:
        TCS: TestCase_testScalarSubVec1Float32, time elapsed: 307300 ns, RESULT:
        TCS: TestCase_testScalarSubVec2Float32, time elapsed: 345500 ns, RESULT:
        TCS: TestCase_testScalarSubVec3Float32, time elapsed: 409300 ns, RESULT:
        TCS: TestCase_testScalarSubVec4Float32, time elapsed: 371500 ns, RESULT:
        TCS: TestCase_testScalarMulVec1Float32, time elapsed: 315700 ns, RESULT:
        TCS: TestCase_testScalarMulVec2Float32, time elapsed: 303100 ns, RESULT:
        TCS: TestCase_testScalarMulVec3Float32, time elapsed: 310000 ns, RESULT:
        TCS: TestCase_testScalarMulVec4Float32, time elapsed: 309400 ns, RESULT:
        TCS: TestCase_testScalarDivVec1Float32, time elapsed: 299600 ns, RESULT:
        TCS: TestCase_testScalarDivVec2Float32, time elapsed: 294900 ns, RESULT:
        TCS: TestCase_testScalarDivVec3Float32, time elapsed: 316200 ns, RESULT:
        TCS: TestCase_testScalarDivVec4Float32, time elapsed: 288000 ns, RESULT:
        TCS: TestCase_testScalarAddVec1Int32, time elapsed: 294100 ns, RESULT:
        TCS: TestCase_testScalarAddVec2Int32, time elapsed: 316500 ns, RESULT:
        TCS: TestCase_testScalarAddVec3Int32, time elapsed: 334800 ns, RESULT:
        TCS: TestCase_testScalarAddVec4Int32, time elapsed: 343800 ns, RESULT:
        TCS: TestCase_testScalarSubVec1Int32, time elapsed: 335900 ns, RESULT:
        TCS: TestCase_testScalarSubVec2Int32, time elapsed: 302900 ns, RESULT:
        TCS: TestCase_testScalarSubVec3Int32, time elapsed: 360500 ns, RESULT:
        TCS: TestCase_testScalarSubVec4Int32, time elapsed: 377100 ns, RESULT:
        TCS: TestCase_testScalarMulVec1Int32, time elapsed: 390800 ns, RESULT:
        TCS: TestCase_testScalarMulVec2Int32, time elapsed: 410300 ns, RESULT:
        TCS: TestCase_testScalarMulVec3Int32, time elapsed: 303100 ns, RESULT:
        TCS: TestCase_testScalarMulVec4Int32, time elapsed: 226100 ns, RESULT:
        TCS: TestCase_testScalarDivVec1Int32, time elapsed: 215000 ns, RESULT:
        TCS: TestCase_testScalarDivVec2Int32, time elapsed: 384800 ns, RESULT:
        TCS: TestCase_testScalarDivVec3Int32, time elapsed: 240000 ns, RESULT:
        TCS: TestCase_testScalarDivVec4Int32, time elapsed: 205600 ns, RESULT:
        TCS: TestCase_testScalarModVec1Int32, time elapsed: 204100 ns, RESULT:
        TCS: TestCase_testScalarModVec2Int32, time elapsed: 206700 ns, RESULT:
        TCS: TestCase_testScalarModVec3Int32, time elapsed: 238100 ns, RESULT:
        TCS: TestCase_testScalarModVec4Int32, time elapsed: 198100 ns, RESULT:
        TCS: TestCase_testScalarSubVec1PackedMediump, time elapsed: 199400 ns, RESULT:
        TCS: TestCase_testScalarSubVec1PackedLowp, time elapsed: 195900 ns, RESULT:
        TCS: TestCase_testScalarSubVec3PackedMediump, time elapsed: 192700 ns, RESULT:
        TCS: TestCase_testScalarSubVec3PackedLowp, time elapsed: 196800 ns, RESULT:
        TCS: TestCase_testScalarSubVec4PackedMediump, time elapsed: 193200 ns, RESULT:
        TCS: TestCase_testScalarSubVec4PackedLowp, time elapsed: 383600 ns, RESULT:
        TCS: TestCase_testScalarMulVec1PackedMediump, time elapsed: 252500 ns, RESULT:
        TCS: TestCase_testScalarMulVec1PackedLowp, time elapsed: 613300 ns, RESULT:
        TCS: TestCase_testScalarMulVec3PackedMediump, time elapsed: 449200 ns, RESULT:
        TCS: TestCase_testScalarMulVec3PackedLowp, time elapsed: 312400 ns, RESULT:
        TCS: TestCase_testScalarMulVec4PackedMediump, time elapsed: 267400 ns, RESULT:
        TCS: TestCase_testScalarMulVec4PackedLowp, time elapsed: 266000 ns, RESULT:
        TCS: TestCase_testScalarDivVec1PackedMediump, time elapsed: 225700 ns, RESULT:
        TCS: TestCase_testScalarDivVec1PackedLowp, time elapsed: 230000 ns, RESULT:
        TCS: TestCase_testScalarDivVec3PackedMediump, time elapsed: 207100 ns, RESULT:
        TCS: TestCase_testScalarDivVec3PackedLowp, time elapsed: 286700 ns, RESULT:
        TCS: TestCase_testScalarDivVec4PackedMediump, time elapsed: 224300 ns, RESULT:
        TCS: TestCase_testScalarDivVec4PackedLowp, time elapsed: 224100 ns, RESULT:
        TCS: TestCase_testScalarModVec1PackedMediump, time elapsed: 199700 ns, RESULT:
        TCS: TestCase_testScalarModVec1PackedLowp, time elapsed: 204900 ns, RESULT:
        TCS: TestCase_testScalarModVec3PackedMediump, time elapsed: 217100 ns, RESULT:
        TCS: TestCase_testScalarModVec3PackedLowp, time elapsed: 216200 ns, RESULT:
        TCS: TestCase_testScalarModVec4PackedMediump, time elapsed: 201600 ns, RESULT:
        TCS: TestCase_testScalarModVec4PackedLowp, time elapsed: 196000 ns, RESULT:
        TCS: TestCase_testScalarDivZeroVec1, time elapsed: 224900 ns, RESULT:
        TCS: TestCase_testScalarAddNegVec1, time elapsed: 210700 ns, RESULT:
        TCS: TestCase_testScalarAddNegVec2, time elapsed: 226500 ns, RESULT:
        TCS: TestCase_testScalarMulOverflowVec1, time elapsed: 227400 ns, RESULT:
        TCS: TestCase_testScalarSubNegVec1, time elapsed: 221400 ns, RESULT:
        TCS: TestCase_testVersionMajor, time elapsed: 188800 ns, RESULT:
        TCS: TestCase_testVersionMinor, time elapsed: 197800 ns, RESULT:
        TCS: TestCase_testVersionPatch, time elapsed: 223100 ns, RESULT:
        TCS: TestCase_testVersionEncoded, time elapsed: 354600 ns, RESULT:
        TCS: TestCase_testConfigSimd, time elapsed: 257500 ns, RESULT:
        TCS: TestCase_testConfigAlignedGentypes, time elapsed: 260800 ns, RESULT:
        TCS: TestCase_testConfigClipControl, time elapsed: 460200 ns, RESULT:
        TCS: TestCase_testConstNegationSimd, time elapsed: 286400 ns, RESULT:
        TCS: TestCase_testConstNegationAligned, time elapsed: 255800 ns, RESULT:
        TCS: TestCase_testConstNegationClip, time elapsed: 234000 ns, RESULT:
        TCS: TestCase_testConstInt64Usage, time elapsed: 221700 ns, RESULT:
        TCS: TestCase_testConstBoolUsage, time elapsed: 221900 ns, RESULT:
        TCS: TestCase_testVersionEncodingConsistency, time elapsed: 194200 ns, RESULT:
        TCS: TestCase_testAssertPasses, time elapsed: 221700 ns, RESULT:
        TCS: TestCase_testAssertFails, time elapsed: 290500 ns, RESULT:
        TCS: TestCase_testAssertWithCustomMessage, time elapsed: 244800 ns, RESULT:
        TCS: TestCase_testNumericLimitsFloat32Epsilon, time elapsed: 215700 ns, RESULT:
        TCS: TestCase_testNumericLimitsFloat64Epsilon, time elapsed: 219700 ns, RESULT:
        TCS: TestCase_testIsIec559OfFloat32, time elapsed: 198000 ns, RESULT:
        TCS: TestCase_testIsIec559OfFloat64, time elapsed: 210200 ns, RESULT:
        TCS: TestCase_testIsIec559OfInt64, time elapsed: 207000 ns, RESULT:
        TCS: TestCase_testEpsilonOfFloat32, time elapsed: 206000 ns, RESULT:
        TCS: TestCase_testEpsilonOfFloat64, time elapsed: 308100 ns, RESULT:
        TCS: TestCase_testNumericLimitsInt64Epsilon, time elapsed: 435700 ns, RESULT:
        TCS: TestCase_testNumericLimitsInt32Epsilon, time elapsed: 247400 ns, RESULT:
        TCS: TestCase_testNumericLimitsInt16Epsilon, time elapsed: 235100 ns, RESULT:
        TCS: TestCase_testNumericLimitsInt8Epsilon, time elapsed: 299600 ns, RESULT:
        TCS: TestCase_testCastVec1ToVec1IntToFloat, time elapsed: 311600 ns, RESULT:
        TCS: TestCase_testCastVec2ToVec1TakesOnlyX, time elapsed: 308700 ns, RESULT:
        TCS: TestCase_testCastVec3ToVec1TakesOnlyX, time elapsed: 240900 ns, RESULT:
        TCS: TestCase_testCastVec4ToVec1TakesOnlyX, time elapsed: 201600 ns, RESULT:
        TCS: TestCase_testCastSameTypeIdentity, time elapsed: 402500 ns, RESULT:
        TCS: TestCase_testCastInt32ToInt64, time elapsed: 356300 ns, RESULT:
        TCS: TestCase_testCastFloatToIntTruncation, time elapsed: 355900 ns, RESULT:
        TCS: TestCase_testCastCrossQualifierPackedHighpToDefaultp, time elapsed: 319100 ns, RESULT:
        TCS: TestCase_testCastCrossQualifierDefaultpToPackedHighp, time elapsed: 310300 ns, RESULT:
        TCS: TestCase_testCastVec2CrossQualifierCrossType, time elapsed: 288400 ns, RESULT:
        TCS: TestCase_testCastVec3CrossQualifier, time elapsed: 305800 ns, RESULT:
        TCS: TestCase_testCastVec4CrossQualifier, time elapsed: 438600 ns, RESULT:
        TCS: TestCase_testCastVec1DoesNotModifySource, time elapsed: 273400 ns, RESULT:
        TCS: TestCase_testCastVec2Vec1ToVec2IntToFloat, time elapsed: 245000 ns, RESULT:
        TCS: TestCase_testCastVec2Vec2ToVec2Identity, time elapsed: 223600 ns, RESULT:
        TCS: TestCase_testCastVec2Vec3ToVec2TakesOnlyXY, time elapsed: 242300 ns, RESULT:
        TCS: TestCase_testCastVec2Vec4ToVec2TakesOnlyXY, time elapsed: 265500 ns, RESULT:
        TCS: TestCase_testCastVec2SameTypeIdentity, time elapsed: 282100 ns, RESULT:
        TCS: TestCase_testCastVec2Int32ToInt64, time elapsed: 760500 ns, RESULT:
        TCS: TestCase_testCastVec2FloatToIntTruncation, time elapsed: 288000 ns, RESULT:
        TCS: TestCase_testCastVec2CrossQualifierPackedHighpToDefaultp, time elapsed: 241800 ns, RESULT:
        TCS: TestCase_testCastVec2DoesNotModifySource, time elapsed: 192000 ns, RESULT:
        TCS: TestCase_testCastVec2Vec1ToVec2SameValueBothComponents, time elapsed: 184000 ns, RESULT:
        TCS: TestCase_testCastVec3Vec1ToVec3IntToFloat, time elapsed: 175400 ns, RESULT:
        TCS: TestCase_testCastVec3Vec2ToVec3ExtendY, time elapsed: 192700 ns, RESULT:
        TCS: TestCase_testCastVec3Vec3ToVec3Identity, time elapsed: 183000 ns, RESULT:
        TCS: TestCase_testCastVec3Vec4ToVec3TakesOnlyXYZ, time elapsed: 185000 ns, RESULT:
        TCS: TestCase_testCastVec3SameTypeIdentity, time elapsed: 209500 ns, RESULT:
        TCS: TestCase_testCastVec3Int32ToInt64, time elapsed: 182500 ns, RESULT:
        TCS: TestCase_testCastVec3FloatToIntTruncation, time elapsed: 170400 ns, RESULT:
        TCS: TestCase_testCastVec3CrossQualifierPackedHighpToDefaultp, time elapsed: 176000 ns, RESULT:
        TCS: TestCase_testCastVec3DoesNotModifySource, time elapsed: 177500 ns, RESULT:
        TCS: TestCase_testCastVec3Vec1ToVec3SameValueAllComponents, time elapsed: 187300 ns, RESULT:
        TCS: TestCase_testCastVec4Vec1ToVec4IntToFloat, time elapsed: 193100 ns, RESULT:
        TCS: TestCase_testCastVec4Vec2ToVec4ExtendY, time elapsed: 297800 ns, RESULT:
        TCS: TestCase_testCastVec4Vec3ToVec4ExtendZ, time elapsed: 197900 ns, RESULT:
        TCS: TestCase_testCastVec4Vec4ToVec4Identity, time elapsed: 208600 ns, RESULT:
        TCS: TestCase_testCastVec4SameTypeIdentity, time elapsed: 181800 ns, RESULT:
        TCS: TestCase_testCastVec4Int32ToInt64, time elapsed: 190000 ns, RESULT:
        TCS: TestCase_testCastVec4FloatToIntTruncation, time elapsed: 290700 ns, RESULT:
        TCS: TestCase_testCastVec4CrossQualifierPackedHighpToDefaultp, time elapsed: 234100 ns, RESULT:
        TCS: TestCase_testCastVec4DoesNotModifySource, time elapsed: 259400 ns, RESULT:
        TCS: TestCase_testCastVec4Vec1ToVec4SameValueAllComponents, time elapsed: 304400 ns, RESULT:
        TCS: TestCase_testFromBoolVec1, time elapsed: 297400 ns, RESULT:
        TCS: TestCase_testFromBoolVec1False, time elapsed: 316800 ns, RESULT:
        TCS: TestCase_testFromBoolVec2, time elapsed: 344900 ns, RESULT:
        TCS: TestCase_testFromBoolVec3, time elapsed: 293900 ns, RESULT:
        TCS: TestCase_testFromBoolVec4, time elapsed: 247100 ns, RESULT:
        TCS: TestCase_testFromBoolVecQ2Vec1, time elapsed: 245200 ns, RESULT:
        TCS: TestCase_testFromBoolVecQ2Vec2, time elapsed: 262400 ns, RESULT:
        TCS: TestCase_testFromBoolVecQ2Vec3, time elapsed: 296900 ns, RESULT:
        TCS: TestCase_testFromBoolVecQ2Vec4, time elapsed: 288500 ns, RESULT:
        TCS: TestCase_testFromBoolVec3AllFalse, time elapsed: 263800 ns, RESULT:
        TCS: TestCase_testFromBoolVec4AllFalse, time elapsed: 265100 ns, RESULT:
        TCS: TestCase_testFromBoolVecQ2Vec3AllFalse, time elapsed: 271600 ns, RESULT:
        TCS: TestCase_testFromBoolVecQ2Vec4AllFalse, time elapsed: 268600 ns, RESULT:
        TCS: TestCase_testFromBoolVecFloat32, time elapsed: 292600 ns, RESULT:
        TCS: TestCase_testFromBoolVecFloat64, time elapsed: 280500 ns, RESULT:
        TCS: TestCase_testFromBoolVecInt32, time elapsed: 277400 ns, RESULT:
        TCS: TestCase_testFromBoolVecQ2PackedMediump, time elapsed: 379700 ns, RESULT:
        TCS: TestCase_testFromBoolVecQ2PackedLowp, time elapsed: 384500 ns, RESULT:
        TCS: TestCase_testS1QuatCastScalingXBranch, time elapsed: 21948903800 ns, RESULT:
        [ ERROR  ] CASE: testS1QuatCastScalingXBranch (21948146800 ns)
        TCS: TestCase_testS1QuatCastScalingYBranch, time elapsed: 10082288400 ns, RESULT:
        [ ERROR  ] CASE: testS1QuatCastScalingYBranch (10081599800 ns)
        TCS: TestCase_testS1QuatCastScalingZBranch, time elapsed: 13113208300 ns, RESULT:
        [ ERROR  ] CASE: testS1QuatCastScalingZBranch (13112569500 ns)
        TCS: TestCase_testS1QuatCastScalingWBranch, time elapsed: 8300783400 ns, RESULT:
        [ ERROR  ] CASE: testS1QuatCastScalingWBranch (8300096800 ns)
        TCS: TestCase_testS1QuatCastUnitRoundTrip, time elapsed: 11756437000 ns, RESULT:
        [ ERROR  ] CASE: testS1QuatCastUnitRoundTrip (11755773000 ns)
        TCS: TestCase_testS1QuatCastIdentityRoundTrip, time elapsed: 11644428100 ns, RESULT:
        [ ERROR  ] CASE: testS1QuatCastIdentityRoundTrip (11643840500 ns)
        TCS: TestCase_testS1QuatCastMat4Delegation, time elapsed: 7405295600 ns, RESULT:
        [ ERROR  ] CASE: testS1QuatCastMat4Delegation (7404747800 ns)
        TCS: TestCase_testMat3EqualEpsilonRelaxedExactMatch, time elapsed: 261100 ns, RESULT:
        TCS: TestCase_testMat3EqualEpsilonRelaxedWithinPosTolerance, time elapsed: 217100 ns, RESULT:
        TCS: TestCase_testMat3EqualEpsilonRelaxedWithinNegTolerance, time elapsed: 202500 ns, RESULT:
        TCS: TestCase_testMat3EqualEpsilonRelaxedBeyondTolerance, time elapsed: 192000 ns, RESULT:
        TCS: TestCase_testMat3EqualEpsilonRelaxedZeroMatrix, time elapsed: 193000 ns, RESULT:
        TCS: TestCase_testMat3EqualEpsilonRelaxedSingleDiffBeyond, time elapsed: 194800 ns, RESULT:
        TCS: TestCase_testVec2ScalarInit, time elapsed: 237600 ns, RESULT:
        TCS: TestCase_testVec2ConstInit, time elapsed: 194800 ns, RESULT:
        TCS: TestCase_testVec2Length, time elapsed: 185300 ns, RESULT:
        TCS: TestCase_testVec2Add, time elapsed: 195400 ns, RESULT:
        TCS: TestCase_testVec2Sub, time elapsed: 194000 ns, RESULT:
        TCS: TestCase_testVec2Mul, time elapsed: 205500 ns, RESULT:
        TCS: TestCase_testVec2ScalarAdd, time elapsed: 198000 ns, RESULT:
        TCS: TestCase_testVec2Negate, time elapsed: 194500 ns, RESULT:
        TCS: TestCase_testVec2IndexAccess, time elapsed: 186800 ns, RESULT:
        TCS: TestCase_testVec2IndexMutate, time elapsed: 227700 ns, RESULT:
        TCS: TestCase_testVec2ComponentAt, time elapsed: 212400 ns, RESULT:
        TCS: TestCase_testVec2Equal, time elapsed: 267500 ns, RESULT:
        TCS: TestCase_testVec2NotEqual, time elapsed: 296200 ns, RESULT:
        TCS: TestCase_testVec2EqualExact, time elapsed: 680300 ns, RESULT:
        TCS: TestCase_testVec2BitwiseAnd, time elapsed: 290400 ns, RESULT:
        TCS: TestCase_testVec2BitwiseNot, time elapsed: 195700 ns, RESULT:
        TCS: TestCase_testVec2FromVec1, time elapsed: 178300 ns, RESULT:
        TCS: TestCase_testVec2ShiftLeft, time elapsed: 203300 ns, RESULT:
        TCS: TestCase_testVec2BoolLogicalAnd, time elapsed: 437100 ns, RESULT:
        TCS: TestCase_testVec2Vec1ArithBroadcast, time elapsed: 206900 ns, RESULT:
        TCS: TestCase_testVec2Vec1BitBroadcast, time elapsed: 217500 ns, RESULT:
        TCS: TestCase_testVec2ShiftLeftVec1, time elapsed: 186000 ns, RESULT:
        TCS: TestCase_testVec2Div, time elapsed: 190400 ns, RESULT:
        TCS: TestCase_testVec2Mod, time elapsed: 200900 ns, RESULT:
        TCS: TestCase_testVec2ScalarSub, time elapsed: 206600 ns, RESULT:
        TCS: TestCase_testVec2ScalarMul, time elapsed: 219200 ns, RESULT:
        TCS: TestCase_testVec2ScalarDiv, time elapsed: 194700 ns, RESULT:
        TCS: TestCase_testVec2ScalarMod, time elapsed: 632500 ns, RESULT:
        TCS: TestCase_testVec2BoolLogicalOr, time elapsed: 205800 ns, RESULT:
        TCS: TestCase_testVec2EqualEpsilon, time elapsed: 208800 ns, RESULT:
        TCS: TestCase_testVec2DivNamed, time elapsed: 191500 ns, RESULT:
        TCS: TestCase_testVec2ModNamed, time elapsed: 235900 ns, RESULT:
        TCS: TestCase_testVec2BitwiseOr, time elapsed: 537200 ns, RESULT:
        TCS: TestCase_testVec2BitwiseXor, time elapsed: 320000 ns, RESULT:
        TCS: TestCase_testVec2ScalarBitwiseAnd, time elapsed: 268300 ns, RESULT:
        TCS: TestCase_testVec2ShiftRight, time elapsed: 273300 ns, RESULT:
        TCS: TestCase_testVec2ShiftRightVec1, time elapsed: 254100 ns, RESULT:
        TCS: TestCase_testVec2AddNamed, time elapsed: 210000 ns, RESULT:
        TCS: TestCase_testVec2SubNamed, time elapsed: 194400 ns, RESULT:
        TCS: TestCase_testVec2MulNamed, time elapsed: 192500 ns, RESULT:
        TCS: TestCase_testVec2ShiftLeftVec, time elapsed: 192500 ns, RESULT:
        TCS: TestCase_testVec2ShiftRightVec, time elapsed: 199100 ns, RESULT:
        TCS: TestCase_testVec2ScalarBitwiseOr, time elapsed: 199000 ns, RESULT:
        TCS: TestCase_testVec2ScalarBitwiseXor, time elapsed: 206900 ns, RESULT:
        TCS: TestCase_testVec2Increment, time elapsed: 220100 ns, RESULT:
        TCS: TestCase_testVec2Decrement, time elapsed: 205100 ns, RESULT:
        TCS: TestCase_testVec2IndexOutOfBoundsAccess, time elapsed: 19503200 ns, RESULT:
        TCS: TestCase_testVec2NegativeIndexAccess, time elapsed: 428900 ns, RESULT:
        TCS: TestCase_testVec3ScalarInit, time elapsed: 311400 ns, RESULT:
        TCS: TestCase_testVec3ConstInit, time elapsed: 357700 ns, RESULT:
        TCS: TestCase_testVec3Length, time elapsed: 241700 ns, RESULT:
        TCS: TestCase_testVec3Add, time elapsed: 275700 ns, RESULT:
        TCS: TestCase_testVec3ScalarMul, time elapsed: 209400 ns, RESULT:
        TCS: TestCase_testVec3Negate, time elapsed: 230300 ns, RESULT:
        TCS: TestCase_testVec3IndexAccess, time elapsed: 198400 ns, RESULT:
        TCS: TestCase_testVec3IndexMutate, time elapsed: 298300 ns, RESULT:
        TCS: TestCase_testVec3ComponentAt, time elapsed: 556500 ns, RESULT:
        TCS: TestCase_testVec3Equal, time elapsed: 297500 ns, RESULT:
        TCS: TestCase_testVec3NotEqual, time elapsed: 230700 ns, RESULT:
        TCS: TestCase_testVec3EqualExact, time elapsed: 210000 ns, RESULT:
        TCS: TestCase_testVec3BitwiseAnd, time elapsed: 207800 ns, RESULT:
        TCS: TestCase_testVec3BitwiseNot, time elapsed: 193500 ns, RESULT:
        TCS: TestCase_testVec3Vec1ArithBroadcast, time elapsed: 234600 ns, RESULT:
        TCS: TestCase_testVec3ShiftLeft, time elapsed: 205400 ns, RESULT:
        TCS: TestCase_testVec3BoolLogicalAnd, time elapsed: 202900 ns, RESULT:
        TCS: TestCase_testVec3Sub, time elapsed: 206100 ns, RESULT:
        TCS: TestCase_testVec3Div, time elapsed: 201200 ns, RESULT:
        TCS: TestCase_testVec3Mod, time elapsed: 232700 ns, RESULT:
        TCS: TestCase_testVec3ScalarSub, time elapsed: 197400 ns, RESULT:
        TCS: TestCase_testVec3ScalarDiv, time elapsed: 509200 ns, RESULT:
        TCS: TestCase_testVec3ScalarMod, time elapsed: 237500 ns, RESULT:
        TCS: TestCase_testVec3BoolLogicalOr, time elapsed: 228200 ns, RESULT:
        TCS: TestCase_testVec3EqualEpsilon, time elapsed: 323100 ns, RESULT:
        TCS: TestCase_testVec3AddNamed, time elapsed: 376800 ns, RESULT:
        TCS: TestCase_testVec3MulNamed, time elapsed: 272000 ns, RESULT:
        TCS: TestCase_testVec3DivNamed, time elapsed: 216800 ns, RESULT:
        TCS: TestCase_testVec3ModNamed, time elapsed: 216400 ns, RESULT:
        TCS: TestCase_testVec3BitwiseOr, time elapsed: 216500 ns, RESULT:
        TCS: TestCase_testVec3BitwiseXor, time elapsed: 227900 ns, RESULT:
        TCS: TestCase_testVec3ScalarBitwiseAnd, time elapsed: 216200 ns, RESULT:
        TCS: TestCase_testVec3ShiftRight, time elapsed: 205700 ns, RESULT:
        TCS: TestCase_testVec3Vec1BitBroadcast, time elapsed: 204500 ns, RESULT:
        TCS: TestCase_testVec3ShiftRightVec1, time elapsed: 212500 ns, RESULT:
        TCS: TestCase_testVec3FromVec1, time elapsed: 183300 ns, RESULT:
        TCS: TestCase_testVec3ScalarBitwiseOr, time elapsed: 196500 ns, RESULT:
        TCS: TestCase_testVec3ScalarBitwiseXor, time elapsed: 205200 ns, RESULT:
        TCS: TestCase_testVec3Vec1BitOrBroadcast, time elapsed: 209800 ns, RESULT:
        TCS: TestCase_testVec3Vec1BitXorBroadcast, time elapsed: 195700 ns, RESULT:
        TCS: TestCase_testVec3ShiftLeftVec1, time elapsed: 227100 ns, RESULT:
        TCS: TestCase_testVec3ShiftLeftVec, time elapsed: 371800 ns, RESULT:
        TCS: TestCase_testVec3ShiftRightVec, time elapsed: 248300 ns, RESULT:
        TCS: TestCase_testVec3Increment, time elapsed: 192300 ns, RESULT:
        TCS: TestCase_testVec3Decrement, time elapsed: 189800 ns, RESULT:
        TCS: TestCase_testVec3IndexOutOfBoundsAccess, time elapsed: 217500 ns, RESULT:
        TCS: TestCase_testVec3NegativeIndexAccess, time elapsed: 216200 ns, RESULT:
        TCS: TestCase_testVec4ScalarInit, time elapsed: 191500 ns, RESULT:
        TCS: TestCase_testVec4ConstInit, time elapsed: 179600 ns, RESULT:
        TCS: TestCase_testVec4Length, time elapsed: 179900 ns, RESULT:
        TCS: TestCase_testVec4Add, time elapsed: 193900 ns, RESULT:
        TCS: TestCase_testVec4ScalarMul, time elapsed: 225000 ns, RESULT:
        TCS: TestCase_testVec4Negate, time elapsed: 187200 ns, RESULT:
        TCS: TestCase_testVec4IndexAccess, time elapsed: 228300 ns, RESULT:
        TCS: TestCase_testVec4IndexMutate, time elapsed: 175000 ns, RESULT:
        TCS: TestCase_testVec4ComponentAt, time elapsed: 177600 ns, RESULT:
        TCS: TestCase_testVec4Equal, time elapsed: 188700 ns, RESULT:
        TCS: TestCase_testVec4NotEqual, time elapsed: 184200 ns, RESULT:
        TCS: TestCase_testVec4EqualExact, time elapsed: 183500 ns, RESULT:
        TCS: TestCase_testVec4BitwiseAnd, time elapsed: 197500 ns, RESULT:
        TCS: TestCase_testVec4BitwiseNot, time elapsed: 189600 ns, RESULT:
        TCS: TestCase_testVec4Vec1ArithBroadcast, time elapsed: 311800 ns, RESULT:
        TCS: TestCase_testVec4ShiftLeft, time elapsed: 210200 ns, RESULT:
        TCS: TestCase_testVec4BoolLogicalAnd, time elapsed: 201800 ns, RESULT:
        TCS: TestCase_testVec4Sub, time elapsed: 200800 ns, RESULT:
        TCS: TestCase_testVec4Div, time elapsed: 205100 ns, RESULT:
        TCS: TestCase_testVec4Mod, time elapsed: 204000 ns, RESULT:
        TCS: TestCase_testVec4ScalarSub, time elapsed: 199700 ns, RESULT:
        TCS: TestCase_testVec4ScalarDiv, time elapsed: 204100 ns, RESULT:
        TCS: TestCase_testVec4ScalarMod, time elapsed: 203800 ns, RESULT:
        TCS: TestCase_testVec4BoolLogicalOr, time elapsed: 197300 ns, RESULT:
        TCS: TestCase_testVec4EqualEpsilon, time elapsed: 214900 ns, RESULT:
        TCS: TestCase_testVec4AddNamed, time elapsed: 210800 ns, RESULT:
        TCS: TestCase_testVec4MulNamed, time elapsed: 188100 ns, RESULT:
        TCS: TestCase_testVec4DivNamed, time elapsed: 184900 ns, RESULT:
        TCS: TestCase_testVec4ModNamed, time elapsed: 190000 ns, RESULT:
        TCS: TestCase_testVec4BitwiseOr, time elapsed: 230600 ns, RESULT:
        TCS: TestCase_testVec4BitwiseXor, time elapsed: 367800 ns, RESULT:
        TCS: TestCase_testVec4ScalarBitwiseAnd, time elapsed: 333000 ns, RESULT:
        TCS: TestCase_testVec4ShiftRight, time elapsed: 262900 ns, RESULT:
        TCS: TestCase_testVec4Vec1BitBroadcast, time elapsed: 242500 ns, RESULT:
        TCS: TestCase_testVec4ShiftRightVec1, time elapsed: 217100 ns, RESULT:
        TCS: TestCase_testVec4FromVec1, time elapsed: 196600 ns, RESULT:
        TCS: TestCase_testVec4ScalarBitwiseOr, time elapsed: 212500 ns, RESULT:
        TCS: TestCase_testVec4ScalarBitwiseXor, time elapsed: 214200 ns, RESULT:
        TCS: TestCase_testVec4Vec1BitOrBroadcast, time elapsed: 203500 ns, RESULT:
        TCS: TestCase_testVec4Vec1BitXorBroadcast, time elapsed: 205000 ns, RESULT:
        TCS: TestCase_testVec4ShiftLeftVec1, time elapsed: 238400 ns, RESULT:
        TCS: TestCase_testVec4ShiftLeftVec, time elapsed: 203800 ns, RESULT:
        TCS: TestCase_testVec4ShiftRightVec, time elapsed: 196600 ns, RESULT:
        TCS: TestCase_testVec4Increment, time elapsed: 202900 ns, RESULT:
        TCS: TestCase_testVec4Decrement, time elapsed: 346000 ns, RESULT:
        TCS: TestCase_testVec4IndexOutOfBoundsAccess, time elapsed: 229500 ns, RESULT:
        TCS: TestCase_testVec4NegativeIndexAccess, time elapsed: 214600 ns, RESULT:
        TCS: TestCase_testFunctor1Vec1Identity, time elapsed: 217900 ns, RESULT:
        TCS: TestCase_testFunctor1Vec1Transform, time elapsed: 285600 ns, RESULT:
        TCS: TestCase_testFunctor1Vec2Transform, time elapsed: 205500 ns, RESULT:
        TCS: TestCase_testFunctor2Vec1Add, time elapsed: 190700 ns, RESULT:
        TCS: TestCase_testFunctor2VecScaVec1Mul, time elapsed: 200800 ns, RESULT:
        TCS: TestCase_testFunctor2VecIntVec1Shift, time elapsed: 189000 ns, RESULT:
        TCS: TestCase_testFunctor1Vec3Transform, time elapsed: 219300 ns, RESULT:
        TCS: TestCase_testFunctor1Vec4Transform, time elapsed: 274900 ns, RESULT:
        TCS: TestCase_testFunctor2Vec2Add, time elapsed: 332900 ns, RESULT:
        TCS: TestCase_testFunctor2Vec3Add, time elapsed: 286700 ns, RESULT:
        TCS: TestCase_testFunctor2Vec4Add, time elapsed: 254300 ns, RESULT:
        TCS: TestCase_testFunctor2VecScaVec2Mul, time elapsed: 211100 ns, RESULT:
        TCS: TestCase_testFunctor2VecScaVec3Mul, time elapsed: 218500 ns, RESULT:
        TCS: TestCase_testFunctor2VecScaVec4Mul, time elapsed: 203100 ns, RESULT:
        TCS: TestCase_testFunctor2VecIntVec2Shift, time elapsed: 194100 ns, RESULT:
        TCS: TestCase_testFunctor2VecIntVec3Shift, time elapsed: 193700 ns, RESULT:
        TCS: TestCase_testFunctor2VecIntVec4Shift, time elapsed: 190200 ns, RESULT:
Summary: TOTAL: 435
    PASSED: 428, SKIPPED: 0, ERROR: 7
    FAILED: 0
--------------------------------------------------------------------------------------------------
Error: cjpm test failed
