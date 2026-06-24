# 验证报告（v2）

## 结果
PASSED

## 统计
- 通过：476
- 失败：0

## 测试执行日志
warning[0m: unused import 'std.math.Number'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:3:19:
  | 
3 | import std.math.{ Number, Integer }
  |                   ^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'std.math.Integer'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:3:27:
  | 
3 | import std.math.{ Number, Integer }
  |                           ^^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'std.math.Number'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:3:19:
  | 
3 | import std.math.{ Number, Integer }
  |                   ^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'std.math.Integer'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:3:27:
  | 
3 | import std.math.{ Number, Integer }
  |                           ^^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'std.math.Number'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:3:19:
  | 
3 | import std.math.{ Number, Integer }
  |                   ^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'std.math.Integer'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:3:27:
  | 
3 | import std.math.{ Number, Integer }
  |                           ^^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'std.math.Number'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:3:19:
  | 
3 | import std.math.{ Number, Integer }
  |                   ^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'std.math.Integer'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:3:27:
  | 
3 | import std.math.{ Number, Integer }
  |                           ^^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'std.math.Number'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x4.cj:3:19:
  | 
3 | import std.math.{ Number, Integer }
  |                   ^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'std.math.Integer'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x4.cj:3:27:
  | 
3 | import std.math.{ Number, Integer }
  |                           ^^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'std.math.Number'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:3:19:
  | 
3 | import std.math.{ Number, Integer }
  |                   ^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'std.math.Integer'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:3:27:
  | 
3 | import std.math.{ Number, Integer }
  |                           ^^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'std.math.Number'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x3.cj:3:19:
  | 
3 | import std.math.{ Number, Integer }
  |                   ^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'std.math.Integer'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x3.cj:3:27:
  | 
3 | import std.math.{ Number, Integer }
  |                           ^^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'std.math.Number'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x4.cj:3:19:
  | 
3 | import std.math.{ Number, Integer }
  |                   ^^^^^^ unused import
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

66 warnings generated, 66 warnings printed.
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

4 warnings generated, 4 warnings printed.
[?25l[0J7[;r8
[1F7[9999E8[0J7[;r8
[1F7[9999E8--------------------------------------------------------------------------------------------------
TP: [33mglm.detail[0m, time elapsed: 169570000 ns, RESULT:
    TCS: [33mTestCase_testComputeVecAdd1[0m, time elapsed: 1438700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAdd1 (307900 ns)
    TCS: [33mTestCase_testComputeVecSub2[0m, time elapsed: 353800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub2 (36700 ns)
    TCS: [33mTestCase_testComputeVecMul3[0m, time elapsed: 387700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul3 (27900 ns)
    TCS: [33mTestCase_testComputeVecMod1[0m, time elapsed: 302400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMod1 (32400 ns)
    TCS: [33mTestCase_testComputeVecMod4[0m, time elapsed: 393500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMod4 (33100 ns)
    TCS: [33mTestCase_testComputeVecAnd1[0m, time elapsed: 320900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAnd1 (29100 ns)
    TCS: [33mTestCase_testComputeVecAnd3[0m, time elapsed: 475800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAnd3 (41500 ns)
    TCS: [33mTestCase_testComputeVecOr1[0m, time elapsed: 498000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecOr1 (46200 ns)
    TCS: [33mTestCase_testComputeVecOr2[0m, time elapsed: 454900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecOr2 (32600 ns)
    TCS: [33mTestCase_testComputeVecXor1[0m, time elapsed: 316700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecXor1 (31300 ns)
    TCS: [33mTestCase_testComputeVecXor4[0m, time elapsed: 297600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecXor4 (26900 ns)
    TCS: [33mTestCase_testComputeVecShiftLeft1[0m, time elapsed: 304300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftLeft1 (17600 ns)
    TCS: [33mTestCase_testComputeVecShiftLeft3[0m, time elapsed: 249100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftLeft3 (15600 ns)
    TCS: [33mTestCase_testComputeVecShiftRight1[0m, time elapsed: 240900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftRight1 (13900 ns)
    TCS: [33mTestCase_testComputeVecShiftRight4[0m, time elapsed: 222000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftRight4 (11800 ns)
    TCS: [33mTestCase_testComputeVecEqual1[0m, time elapsed: 240800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual1 (17600 ns)
    TCS: [33mTestCase_testComputeVecNequal4[0m, time elapsed: 248900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal4 (18100 ns)
    TCS: [33mTestCase_testComputeVecBitwiseNot1[0m, time elapsed: 252200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecBitwiseNot1 (20600 ns)
    TCS: [33mTestCase_testComputeVecBitwiseNot3[0m, time elapsed: 244400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecBitwiseNot3 (25100 ns)
    TCS: [33mTestCase_testComputeVecAdd4[0m, time elapsed: 263600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAdd4 (20100 ns)
    TCS: [33mTestCase_testComputeVecSub1[0m, time elapsed: 722300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub1 (15900 ns)
    TCS: [33mTestCase_testComputeVecSub3[0m, time elapsed: 448900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub3 (84300 ns)
    TCS: [33mTestCase_testComputeVecMul1[0m, time elapsed: 330300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul1 (26500 ns)
    TCS: [33mTestCase_testComputeVecMul2[0m, time elapsed: 397700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul2 (33400 ns)
    TCS: [33mTestCase_testComputeVecDiv1[0m, time elapsed: 431600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecDiv1 (44700 ns)
    TCS: [33mTestCase_testComputeVecDiv2[0m, time elapsed: 327100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecDiv2 (25800 ns)
    TCS: [33mTestCase_testComputeVecDiv4[0m, time elapsed: 301600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecDiv4 (32000 ns)
    TCS: [33mTestCase_testComputeVecEqual2[0m, time elapsed: 322900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual2 (19400 ns)
    TCS: [33mTestCase_testComputeVecEqual3[0m, time elapsed: 243300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual3 (19800 ns)
    TCS: [33mTestCase_testComputeVecEqual4[0m, time elapsed: 232200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual4 (15400 ns)
    TCS: [33mTestCase_testComputeVecNequal1[0m, time elapsed: 434300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal1 (24900 ns)
    TCS: [33mTestCase_testComputeVecNequal2[0m, time elapsed: 321000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal2 (22700 ns)
    TCS: [33mTestCase_testComputeVecBitwiseNot4[0m, time elapsed: 307300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecBitwiseNot4 (33300 ns)
    TCS: [33mTestCase_testComputeVecAddFloat32[0m, time elapsed: 333700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAddFloat32 (31900 ns)
    TCS: [33mTestCase_testComputeVecAddFloat32Vec3[0m, time elapsed: 353600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAddFloat32Vec3 (33600 ns)
    TCS: [33mTestCase_testComputeVecSubFloat32[0m, time elapsed: 289000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSubFloat32 (24400 ns)
    TCS: [33mTestCase_testComputeVecSubFloat32Vec4[0m, time elapsed: 302700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSubFloat32Vec4 (28700 ns)
    TCS: [33mTestCase_testComputeEqualInt32Equal[0m, time elapsed: 286600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt32Equal (19700 ns)
    TCS: [33mTestCase_testComputeEqualInt32NotEqual[0m, time elapsed: 314000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt32NotEqual (22000 ns)
    TCS: [33mTestCase_testComputeEqualFloat32Equal[0m, time elapsed: 288600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32Equal (21500 ns)
    TCS: [33mTestCase_testComputeEqualFloat32NotEqual[0m, time elapsed: 193400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32NotEqual (9500 ns)
    TCS: [33mTestCase_testComputeEqualFloat64Equal[0m, time elapsed: 191300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64Equal (8600 ns)
    TCS: [33mTestCase_testComputeEqualFloat64NotEqual[0m, time elapsed: 205200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64NotEqual (7500 ns)
    TCS: [33mTestCase_testComputeEqualBoolEqual[0m, time elapsed: 285400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualBoolEqual (20300 ns)
    TCS: [33mTestCase_testComputeEqualBoolNotEqual[0m, time elapsed: 242900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualBoolNotEqual (19400 ns)
    TCS: [33mTestCase_testComputeEqualNumericInt32[0m, time elapsed: 202200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericInt32 (11300 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32[0m, time elapsed: 221400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32 (24400 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32Epsilon[0m, time elapsed: 201400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32Epsilon (10100 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64[0m, time elapsed: 205900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64 (20300 ns)
    TCS: [33mTestCase_testComputeEqualInt64Equal[0m, time elapsed: 206300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt64Equal (8900 ns)
    TCS: [33mTestCase_testComputeEqualInt64NotEqual[0m, time elapsed: 201900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt64NotEqual (8800 ns)
    TCS: [33mTestCase_testComputeEqualFloat32Nan[0m, time elapsed: 195200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32Nan (8300 ns)
    TCS: [33mTestCase_testComputeEqualFloat64Nan[0m, time elapsed: 198800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64Nan (7600 ns)
    TCS: [33mTestCase_testComputeEqualFloat32SignedZero[0m, time elapsed: 188300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32SignedZero (8100 ns)
    TCS: [33mTestCase_testComputeEqualFloat64SignedZero[0m, time elapsed: 183800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64SignedZero (10800 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32NotEqual[0m, time elapsed: 198000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32NotEqual (12900 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32BeyondEpsilon[0m, time elapsed: 195100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32BeyondEpsilon (9700 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64NotEqual[0m, time elapsed: 210900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64NotEqual (13300 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64Epsilon[0m, time elapsed: 184300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64Epsilon (9100 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64BeyondEpsilon[0m, time elapsed: 190200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64BeyondEpsilon (12800 ns)
    TCS: [33mTestCase_testComputeEqualNumericInt64[0m, time elapsed: 193500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericInt64 (10400 ns)
    TCS: [33mTestCase_testPackedHighpImplementsQualifier[0m, time elapsed: 199100 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedHighpImplementsQualifier (12100 ns)
    TCS: [33mTestCase_testPackedMediumpImplementsQualifier[0m, time elapsed: 192100 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedMediumpImplementsQualifier (10100 ns)
    TCS: [33mTestCase_testPackedLowpImplementsQualifier[0m, time elapsed: 197300 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedLowpImplementsQualifier (7200 ns)
    TCS: [33mTestCase_testDefaultpIsPackedHighp[0m, time elapsed: 201500 ns, RESULT:
    [[32m PASSED [0m] CASE: testDefaultpIsPackedHighp (8300 ns)
    TCS: [33mTestCase_testScalarAddVec1[0m, time elapsed: 351400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec1 (45400 ns)
    TCS: [33mTestCase_testScalarAddVec2[0m, time elapsed: 241900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec2 (19700 ns)
    TCS: [33mTestCase_testScalarAddVec3[0m, time elapsed: 217000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec3 (16100 ns)
    TCS: [33mTestCase_testScalarAddVec4[0m, time elapsed: 200800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec4 (12000 ns)
    TCS: [33mTestCase_testScalarSubVec1[0m, time elapsed: 201000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1 (12000 ns)
    TCS: [33mTestCase_testScalarMulVec1[0m, time elapsed: 209600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1 (16500 ns)
    TCS: [33mTestCase_testScalarDivVec1[0m, time elapsed: 200800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1 (8700 ns)
    TCS: [33mTestCase_testScalarModVec1[0m, time elapsed: 201700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1 (13400 ns)
    TCS: [33mTestCase_testScalarMulVec2[0m, time elapsed: 187600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2 (10100 ns)
    TCS: [33mTestCase_testScalarSubVec2[0m, time elapsed: 196900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2 (13800 ns)
    TCS: [33mTestCase_testScalarSubVec3[0m, time elapsed: 198700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3 (16600 ns)
    TCS: [33mTestCase_testScalarSubVec4[0m, time elapsed: 204400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4 (20800 ns)
    TCS: [33mTestCase_testScalarMulVec3[0m, time elapsed: 191100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3 (14400 ns)
    TCS: [33mTestCase_testScalarMulVec4[0m, time elapsed: 292500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4 (10900 ns)
    TCS: [33mTestCase_testScalarDivVec2[0m, time elapsed: 309800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2 (16600 ns)
    TCS: [33mTestCase_testScalarDivVec3[0m, time elapsed: 267300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3 (18300 ns)
    TCS: [33mTestCase_testScalarDivVec4[0m, time elapsed: 317900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4 (24200 ns)
    TCS: [33mTestCase_testScalarModVec2[0m, time elapsed: 295100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2 (19300 ns)
    TCS: [33mTestCase_testScalarModVec3[0m, time elapsed: 260700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3 (12900 ns)
    TCS: [33mTestCase_testScalarModVec4[0m, time elapsed: 286300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4 (22000 ns)
    TCS: [33mTestCase_testScalarModVec1Float32[0m, time elapsed: 248300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float32 (21700 ns)
    TCS: [33mTestCase_testScalarModVec2Float32[0m, time elapsed: 262100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32 (12800 ns)
    TCS: [33mTestCase_testScalarModVec3Float32[0m, time elapsed: 271000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float32 (29600 ns)
    TCS: [33mTestCase_testScalarModVec4Float32[0m, time elapsed: 248200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float32 (15900 ns)
    TCS: [33mTestCase_testScalarModVec1Float64[0m, time elapsed: 221500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float64 (12700 ns)
    TCS: [33mTestCase_testScalarModVec2Float64[0m, time elapsed: 362300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float64 (21400 ns)
    TCS: [33mTestCase_testScalarModVec3Float64[0m, time elapsed: 202900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float64 (10800 ns)
    TCS: [33mTestCase_testScalarModVec4Float64[0m, time elapsed: 201500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float64 (13100 ns)
    TCS: [33mTestCase_testScalarModVec1Float16[0m, time elapsed: 240200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float16 (22300 ns)
    TCS: [33mTestCase_testScalarModVec2Float16[0m, time elapsed: 269200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float16 (14000 ns)
    TCS: [33mTestCase_testScalarModVec3Float16[0m, time elapsed: 311100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float16 (16400 ns)
    TCS: [33mTestCase_testScalarModVec4Float16[0m, time elapsed: 230800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float16 (11600 ns)
    TCS: [33mTestCase_testScalarSubVec2PackedMediump[0m, time elapsed: 229500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2PackedMediump (17900 ns)
    TCS: [33mTestCase_testScalarSubVec2PackedLowp[0m, time elapsed: 233900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2PackedLowp (21000 ns)
    TCS: [33mTestCase_testScalarMulVec2PackedMediump[0m, time elapsed: 203500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2PackedMediump (14000 ns)
    TCS: [33mTestCase_testScalarMulVec2PackedLowp[0m, time elapsed: 199500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2PackedLowp (12400 ns)
    TCS: [33mTestCase_testScalarDivVec2PackedMediump[0m, time elapsed: 253000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2PackedMediump (11000 ns)
    TCS: [33mTestCase_testScalarDivVec2PackedLowp[0m, time elapsed: 213200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2PackedLowp (17700 ns)
    TCS: [33mTestCase_testScalarModVec2PackedMediump[0m, time elapsed: 223600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2PackedMediump (12800 ns)
    TCS: [33mTestCase_testScalarModVec2PackedLowp[0m, time elapsed: 221100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2PackedLowp (9600 ns)
    TCS: [33mTestCase_testScalarModVec2Float32PackedMediump[0m, time elapsed: 206000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32PackedMediump (16100 ns)
    TCS: [33mTestCase_testScalarModVec2Float32PackedLowp[0m, time elapsed: 274900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32PackedLowp (17800 ns)
    TCS: [33mTestCase_testScalarModVec2Float32NegativeDividend[0m, time elapsed: 279800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32NegativeDividend (19200 ns)
    TCS: [33mTestCase_testScalarModVec2Float32NegativeDivisor[0m, time elapsed: 281400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32NegativeDivisor (22100 ns)
    TCS: [33mTestCase_testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents[0m, time elapsed: 564700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents (263700 ns)
    TCS: [33mTestCase_testScalarAddVec1Float32[0m, time elapsed: 279900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec1Float32 (20400 ns)
    TCS: [33mTestCase_testScalarAddVec2Float32[0m, time elapsed: 305000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec2Float32 (20400 ns)
    TCS: [33mTestCase_testScalarAddVec3Float32[0m, time elapsed: 316500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec3Float32 (19600 ns)
    TCS: [33mTestCase_testScalarAddVec4Float32[0m, time elapsed: 312300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec4Float32 (18100 ns)
    TCS: [33mTestCase_testScalarSubVec1Float32[0m, time elapsed: 226100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1Float32 (12800 ns)
    TCS: [33mTestCase_testScalarSubVec2Float32[0m, time elapsed: 223500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2Float32 (12300 ns)
    TCS: [33mTestCase_testScalarSubVec3Float32[0m, time elapsed: 234200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3Float32 (11100 ns)
    TCS: [33mTestCase_testScalarSubVec4Float32[0m, time elapsed: 198500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4Float32 (11100 ns)
    TCS: [33mTestCase_testScalarMulVec1Float32[0m, time elapsed: 192000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1Float32 (8900 ns)
    TCS: [33mTestCase_testScalarMulVec2Float32[0m, time elapsed: 276200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2Float32 (9600 ns)
    TCS: [33mTestCase_testScalarMulVec3Float32[0m, time elapsed: 349500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3Float32 (19000 ns)
    TCS: [33mTestCase_testScalarMulVec4Float32[0m, time elapsed: 352500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4Float32 (22600 ns)
    TCS: [33mTestCase_testScalarDivVec1Float32[0m, time elapsed: 340300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1Float32 (17200 ns)
    TCS: [33mTestCase_testScalarDivVec2Float32[0m, time elapsed: 261800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2Float32 (14600 ns)
    TCS: [33mTestCase_testScalarDivVec3Float32[0m, time elapsed: 253000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3Float32 (16200 ns)
    TCS: [33mTestCase_testScalarDivVec4Float32[0m, time elapsed: 194100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4Float32 (9400 ns)
    TCS: [33mTestCase_testScalarAddVec1Int32[0m, time elapsed: 293300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec1Int32 (36100 ns)
    TCS: [33mTestCase_testScalarAddVec2Int32[0m, time elapsed: 273200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec2Int32 (17900 ns)
    TCS: [33mTestCase_testScalarAddVec3Int32[0m, time elapsed: 1193500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec3Int32 (78600 ns)
    TCS: [33mTestCase_testScalarAddVec4Int32[0m, time elapsed: 1063000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec4Int32 (84400 ns)
    TCS: [33mTestCase_testScalarSubVec1Int32[0m, time elapsed: 357700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1Int32 (27900 ns)
    TCS: [33mTestCase_testScalarSubVec2Int32[0m, time elapsed: 426000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2Int32 (18400 ns)
    TCS: [33mTestCase_testScalarSubVec3Int32[0m, time elapsed: 237700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3Int32 (12600 ns)
    TCS: [33mTestCase_testScalarSubVec4Int32[0m, time elapsed: 349300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4Int32 (17300 ns)
    TCS: [33mTestCase_testScalarMulVec1Int32[0m, time elapsed: 1446000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1Int32 (18000 ns)
    TCS: [33mTestCase_testScalarMulVec2Int32[0m, time elapsed: 373600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2Int32 (36900 ns)
    TCS: [33mTestCase_testScalarMulVec3Int32[0m, time elapsed: 318200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3Int32 (13800 ns)
    TCS: [33mTestCase_testScalarMulVec4Int32[0m, time elapsed: 225800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4Int32 (12700 ns)
    TCS: [33mTestCase_testScalarDivVec1Int32[0m, time elapsed: 220100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1Int32 (10300 ns)
    TCS: [33mTestCase_testScalarDivVec2Int32[0m, time elapsed: 204300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2Int32 (9900 ns)
    TCS: [33mTestCase_testScalarDivVec3Int32[0m, time elapsed: 236400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3Int32 (10600 ns)
    TCS: [33mTestCase_testScalarDivVec4Int32[0m, time elapsed: 219900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4Int32 (24100 ns)
    TCS: [33mTestCase_testScalarModVec1Int32[0m, time elapsed: 230100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Int32 (13500 ns)
    TCS: [33mTestCase_testScalarModVec2Int32[0m, time elapsed: 211200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Int32 (10700 ns)
    TCS: [33mTestCase_testScalarModVec3Int32[0m, time elapsed: 218700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Int32 (9500 ns)
    TCS: [33mTestCase_testScalarModVec4Int32[0m, time elapsed: 211600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Int32 (10200 ns)
    TCS: [33mTestCase_testScalarSubVec1PackedMediump[0m, time elapsed: 232300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1PackedMediump (14900 ns)
    TCS: [33mTestCase_testScalarSubVec1PackedLowp[0m, time elapsed: 209400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1PackedLowp (11900 ns)
    TCS: [33mTestCase_testScalarSubVec3PackedMediump[0m, time elapsed: 219200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3PackedMediump (11200 ns)
    TCS: [33mTestCase_testScalarSubVec3PackedLowp[0m, time elapsed: 195900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3PackedLowp (9600 ns)
    TCS: [33mTestCase_testScalarSubVec4PackedMediump[0m, time elapsed: 235200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4PackedMediump (17500 ns)
    TCS: [33mTestCase_testScalarSubVec4PackedLowp[0m, time elapsed: 304400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4PackedLowp (12000 ns)
    TCS: [33mTestCase_testScalarMulVec1PackedMediump[0m, time elapsed: 359700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1PackedMediump (20600 ns)
    TCS: [33mTestCase_testScalarMulVec1PackedLowp[0m, time elapsed: 299800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1PackedLowp (14500 ns)
    TCS: [33mTestCase_testScalarMulVec3PackedMediump[0m, time elapsed: 221400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3PackedMediump (13300 ns)
    TCS: [33mTestCase_testScalarMulVec3PackedLowp[0m, time elapsed: 197300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3PackedLowp (10800 ns)
    TCS: [33mTestCase_testScalarMulVec4PackedMediump[0m, time elapsed: 193100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4PackedMediump (10200 ns)
    TCS: [33mTestCase_testScalarMulVec4PackedLowp[0m, time elapsed: 191200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4PackedLowp (9900 ns)
    TCS: [33mTestCase_testScalarDivVec1PackedMediump[0m, time elapsed: 197500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1PackedMediump (12000 ns)
    TCS: [33mTestCase_testScalarDivVec1PackedLowp[0m, time elapsed: 200100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1PackedLowp (11300 ns)
    TCS: [33mTestCase_testScalarDivVec3PackedMediump[0m, time elapsed: 200400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3PackedMediump (11800 ns)
    TCS: [33mTestCase_testScalarDivVec3PackedLowp[0m, time elapsed: 199900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3PackedLowp (10600 ns)
    TCS: [33mTestCase_testScalarDivVec4PackedMediump[0m, time elapsed: 204600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4PackedMediump (14400 ns)
    TCS: [33mTestCase_testScalarDivVec4PackedLowp[0m, time elapsed: 208600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4PackedLowp (12200 ns)
    TCS: [33mTestCase_testScalarModVec1PackedMediump[0m, time elapsed: 200000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1PackedMediump (10700 ns)
    TCS: [33mTestCase_testScalarModVec1PackedLowp[0m, time elapsed: 220300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1PackedLowp (10100 ns)
    TCS: [33mTestCase_testScalarModVec3PackedMediump[0m, time elapsed: 207100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3PackedMediump (11400 ns)
    TCS: [33mTestCase_testScalarModVec3PackedLowp[0m, time elapsed: 225300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3PackedLowp (9900 ns)
    TCS: [33mTestCase_testScalarModVec4PackedMediump[0m, time elapsed: 200600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4PackedMediump (9900 ns)
    TCS: [33mTestCase_testScalarModVec4PackedLowp[0m, time elapsed: 248000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4PackedLowp (21700 ns)
    TCS: [33mTestCase_testScalarDivZeroVec1[0m, time elapsed: 249400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivZeroVec1 (21700 ns)
    TCS: [33mTestCase_testScalarAddNegVec1[0m, time elapsed: 235000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddNegVec1 (12900 ns)
    TCS: [33mTestCase_testScalarAddNegVec2[0m, time elapsed: 208600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddNegVec2 (10000 ns)
    TCS: [33mTestCase_testScalarMulOverflowVec1[0m, time elapsed: 233700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulOverflowVec1 (9600 ns)
    TCS: [33mTestCase_testScalarSubNegVec1[0m, time elapsed: 221600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubNegVec1 (10100 ns)
    TCS: [33mTestCase_testVersionMajor[0m, time elapsed: 276600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionMajor (10900 ns)
    TCS: [33mTestCase_testVersionMinor[0m, time elapsed: 508900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionMinor (22400 ns)
    TCS: [33mTestCase_testVersionPatch[0m, time elapsed: 335100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionPatch (15500 ns)
    TCS: [33mTestCase_testVersionEncoded[0m, time elapsed: 226800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionEncoded (16600 ns)
    TCS: [33mTestCase_testConfigSimd[0m, time elapsed: 246800 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigSimd (20400 ns)
    TCS: [33mTestCase_testConfigAlignedGentypes[0m, time elapsed: 205400 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigAlignedGentypes (8800 ns)
    TCS: [33mTestCase_testConfigClipControl[0m, time elapsed: 246500 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigClipControl (9200 ns)
    TCS: [33mTestCase_testConstNegationSimd[0m, time elapsed: 211300 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationSimd (15100 ns)
    TCS: [33mTestCase_testConstNegationAligned[0m, time elapsed: 236200 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationAligned (8700 ns)
    TCS: [33mTestCase_testConstNegationClip[0m, time elapsed: 203100 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationClip (8300 ns)
    TCS: [33mTestCase_testConstInt64Usage[0m, time elapsed: 231200 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstInt64Usage (16100 ns)
    TCS: [33mTestCase_testConstBoolUsage[0m, time elapsed: 215100 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstBoolUsage (10500 ns)
    TCS: [33mTestCase_testVersionEncodingConsistency[0m, time elapsed: 259800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionEncodingConsistency (9700 ns)
    TCS: [33mTestCase_testAssertPasses[0m, time elapsed: 228900 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertPasses (27200 ns)
    TCS: [33mTestCase_testAssertFails[0m, time elapsed: 297600 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertFails (73400 ns)
    TCS: [33mTestCase_testAssertWithCustomMessage[0m, time elapsed: 247000 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertWithCustomMessage (39600 ns)
    TCS: [33mTestCase_testNumericLimitsFloat32Epsilon[0m, time elapsed: 230600 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsFloat32Epsilon (13800 ns)
    TCS: [33mTestCase_testNumericLimitsFloat64Epsilon[0m, time elapsed: 207800 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsFloat64Epsilon (11300 ns)
    TCS: [33mTestCase_testIsIec559OfFloat32[0m, time elapsed: 231300 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfFloat32 (11200 ns)
    TCS: [33mTestCase_testIsIec559OfFloat64[0m, time elapsed: 208600 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfFloat64 (8500 ns)
    TCS: [33mTestCase_testIsIec559OfInt64[0m, time elapsed: 232500 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfInt64 (18400 ns)
    TCS: [33mTestCase_testEpsilonOfFloat32[0m, time elapsed: 222100 ns, RESULT:
    [[32m PASSED [0m] CASE: testEpsilonOfFloat32 (15400 ns)
    TCS: [33mTestCase_testEpsilonOfFloat64[0m, time elapsed: 222600 ns, RESULT:
    [[32m PASSED [0m] CASE: testEpsilonOfFloat64 (12700 ns)
    TCS: [33mTestCase_testNumericLimitsInt64Epsilon[0m, time elapsed: 206800 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt64Epsilon (11600 ns)
    TCS: [33mTestCase_testNumericLimitsInt32Epsilon[0m, time elapsed: 565600 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt32Epsilon (25200 ns)
    TCS: [33mTestCase_testNumericLimitsInt16Epsilon[0m, time elapsed: 722900 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt16Epsilon (36600 ns)
    TCS: [33mTestCase_testNumericLimitsInt8Epsilon[0m, time elapsed: 628500 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt8Epsilon (57200 ns)
    TCS: [33mTestCase_testCastVec1ToVec1IntToFloat[0m, time elapsed: 614500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec1ToVec1IntToFloat (48700 ns)
    TCS: [33mTestCase_testCastVec2ToVec1TakesOnlyX[0m, time elapsed: 448500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2ToVec1TakesOnlyX (35200 ns)
    TCS: [33mTestCase_testCastVec3ToVec1TakesOnlyX[0m, time elapsed: 379500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3ToVec1TakesOnlyX (40900 ns)
    TCS: [33mTestCase_testCastVec4ToVec1TakesOnlyX[0m, time elapsed: 360400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4ToVec1TakesOnlyX (34100 ns)
    TCS: [33mTestCase_testCastSameTypeIdentity[0m, time elapsed: 350000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastSameTypeIdentity (40000 ns)
    TCS: [33mTestCase_testCastInt32ToInt64[0m, time elapsed: 294000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastInt32ToInt64 (14500 ns)
    TCS: [33mTestCase_testCastFloatToIntTruncation[0m, time elapsed: 269200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastFloatToIntTruncation (14000 ns)
    TCS: [33mTestCase_testCastCrossQualifierPackedHighpToDefaultp[0m, time elapsed: 293200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastCrossQualifierPackedHighpToDefaultp (12800 ns)
    TCS: [33mTestCase_testCastCrossQualifierDefaultpToPackedHighp[0m, time elapsed: 244900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastCrossQualifierDefaultpToPackedHighp (17300 ns)
    TCS: [33mTestCase_testCastVec2CrossQualifierCrossType[0m, time elapsed: 258000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2CrossQualifierCrossType (14400 ns)
    TCS: [33mTestCase_testCastVec3CrossQualifier[0m, time elapsed: 208400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3CrossQualifier (10900 ns)
    TCS: [33mTestCase_testCastVec4CrossQualifier[0m, time elapsed: 250200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4CrossQualifier (16100 ns)
    TCS: [33mTestCase_testCastVec1DoesNotModifySource[0m, time elapsed: 298500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec1DoesNotModifySource (9800 ns)
    TCS: [33mTestCase_testCastVec2Vec1ToVec2IntToFloat[0m, time elapsed: 257000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec1ToVec2IntToFloat (13000 ns)
    TCS: [33mTestCase_testCastVec2Vec2ToVec2Identity[0m, time elapsed: 202600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec2ToVec2Identity (10000 ns)
    TCS: [33mTestCase_testCastVec2Vec3ToVec2TakesOnlyXY[0m, time elapsed: 250300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec3ToVec2TakesOnlyXY (17700 ns)
    TCS: [33mTestCase_testCastVec2Vec4ToVec2TakesOnlyXY[0m, time elapsed: 200200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec4ToVec2TakesOnlyXY (12200 ns)
    TCS: [33mTestCase_testCastVec2SameTypeIdentity[0m, time elapsed: 197900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2SameTypeIdentity (7100 ns)
    TCS: [33mTestCase_testCastVec2Int32ToInt64[0m, time elapsed: 256600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Int32ToInt64 (11600 ns)
    TCS: [33mTestCase_testCastVec2FloatToIntTruncation[0m, time elapsed: 340700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2FloatToIntTruncation (13100 ns)
    TCS: [33mTestCase_testCastVec2CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 184400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2CrossQualifierPackedHighpToDefaultp (7300 ns)
    TCS: [33mTestCase_testCastVec2DoesNotModifySource[0m, time elapsed: 191200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2DoesNotModifySource (9900 ns)
    TCS: [33mTestCase_testCastVec2Vec1ToVec2SameValueBothComponents[0m, time elapsed: 178100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec1ToVec2SameValueBothComponents (8000 ns)
    TCS: [33mTestCase_testCastVec3Vec1ToVec3IntToFloat[0m, time elapsed: 205100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec1ToVec3IntToFloat (16300 ns)
    TCS: [33mTestCase_testCastVec3Vec2ToVec3ExtendY[0m, time elapsed: 167500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec2ToVec3ExtendY (7200 ns)
    TCS: [33mTestCase_testCastVec3Vec3ToVec3Identity[0m, time elapsed: 190800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec3ToVec3Identity (10200 ns)
    TCS: [33mTestCase_testCastVec3Vec4ToVec3TakesOnlyXYZ[0m, time elapsed: 174600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec4ToVec3TakesOnlyXYZ (7100 ns)
    TCS: [33mTestCase_testCastVec3SameTypeIdentity[0m, time elapsed: 199200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3SameTypeIdentity (9300 ns)
    TCS: [33mTestCase_testCastVec3Int32ToInt64[0m, time elapsed: 172700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Int32ToInt64 (6800 ns)
    TCS: [33mTestCase_testCastVec3FloatToIntTruncation[0m, time elapsed: 190200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3FloatToIntTruncation (7400 ns)
    TCS: [33mTestCase_testCastVec3CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 237100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3CrossQualifierPackedHighpToDefaultp (7400 ns)
    TCS: [33mTestCase_testCastVec3DoesNotModifySource[0m, time elapsed: 189400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3DoesNotModifySource (6200 ns)
    TCS: [33mTestCase_testCastVec3Vec1ToVec3SameValueAllComponents[0m, time elapsed: 176100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec1ToVec3SameValueAllComponents (6500 ns)
    TCS: [33mTestCase_testCastVec4Vec1ToVec4IntToFloat[0m, time elapsed: 197500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec1ToVec4IntToFloat (14000 ns)
    TCS: [33mTestCase_testCastVec4Vec2ToVec4ExtendY[0m, time elapsed: 214600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec2ToVec4ExtendY (11700 ns)
    TCS: [33mTestCase_testCastVec4Vec3ToVec4ExtendZ[0m, time elapsed: 188000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec3ToVec4ExtendZ (9700 ns)
    TCS: [33mTestCase_testCastVec4Vec4ToVec4Identity[0m, time elapsed: 178500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec4ToVec4Identity (9000 ns)
    TCS: [33mTestCase_testCastVec4SameTypeIdentity[0m, time elapsed: 267200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4SameTypeIdentity (10300 ns)
    TCS: [33mTestCase_testCastVec4Int32ToInt64[0m, time elapsed: 567800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Int32ToInt64 (21800 ns)
    TCS: [33mTestCase_testCastVec4FloatToIntTruncation[0m, time elapsed: 370100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4FloatToIntTruncation (18000 ns)
    TCS: [33mTestCase_testCastVec4CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 387900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4CrossQualifierPackedHighpToDefaultp (14700 ns)
    TCS: [33mTestCase_testCastVec4DoesNotModifySource[0m, time elapsed: 368900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4DoesNotModifySource (21700 ns)
    TCS: [33mTestCase_testCastVec4Vec1ToVec4SameValueAllComponents[0m, time elapsed: 354400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec1ToVec4SameValueAllComponents (25000 ns)
    TCS: [33mTestCase_testFromBoolVec1[0m, time elapsed: 370400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec1 (19500 ns)
    TCS: [33mTestCase_testFromBoolVec1False[0m, time elapsed: 427500 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec1False (19700 ns)
    TCS: [33mTestCase_testFromBoolVec2[0m, time elapsed: 266200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec2 (14800 ns)
    TCS: [33mTestCase_testFromBoolVec3[0m, time elapsed: 234000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec3 (9800 ns)
    TCS: [33mTestCase_testFromBoolVec4[0m, time elapsed: 226900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec4 (9600 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec1[0m, time elapsed: 235600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec1 (14500 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec2[0m, time elapsed: 336300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec2 (10400 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec3[0m, time elapsed: 358900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec3 (17200 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec4[0m, time elapsed: 553200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec4 (36300 ns)
    TCS: [33mTestCase_testFromBoolVec3AllFalse[0m, time elapsed: 286500 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec3AllFalse (25700 ns)
    TCS: [33mTestCase_testFromBoolVec4AllFalse[0m, time elapsed: 234100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec4AllFalse (10300 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec3AllFalse[0m, time elapsed: 244900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec3AllFalse (12000 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec4AllFalse[0m, time elapsed: 251800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec4AllFalse (11400 ns)
    TCS: [33mTestCase_testFromBoolVecFloat32[0m, time elapsed: 256900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecFloat32 (15200 ns)
    TCS: [33mTestCase_testFromBoolVecFloat64[0m, time elapsed: 235300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecFloat64 (11900 ns)
    TCS: [33mTestCase_testFromBoolVecInt32[0m, time elapsed: 362900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecInt32 (15900 ns)
    TCS: [33mTestCase_testFromBoolVecQ2PackedMediump[0m, time elapsed: 318000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2PackedMediump (12400 ns)
    TCS: [33mTestCase_testFromBoolVecQ2PackedLowp[0m, time elapsed: 284200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2PackedLowp (10200 ns)
    TCS: [33mTestCase_testVec1ConstInit[0m, time elapsed: 183100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ConstInit (15300 ns)
    TCS: [33mTestCase_testVec1Length[0m, time elapsed: 177800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Length (5800 ns)
    TCS: [33mTestCase_testVec1IndexAccess[0m, time elapsed: 171900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1IndexAccess (8800 ns)
    TCS: [33mTestCase_testVec1IndexMutate[0m, time elapsed: 180700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1IndexMutate (8200 ns)
    TCS: [33mTestCase_testVec1ComponentAt[0m, time elapsed: 170700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ComponentAt (8300 ns)
    TCS: [33mTestCase_testVec1Add[0m, time elapsed: 198300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Add (11800 ns)
    TCS: [33mTestCase_testVec1Sub[0m, time elapsed: 166800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Sub (9400 ns)
    TCS: [33mTestCase_testVec1Mul[0m, time elapsed: 181200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Mul (16900 ns)
    TCS: [33mTestCase_testVec1Div[0m, time elapsed: 177400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Div (11900 ns)
    TCS: [33mTestCase_testVec1Mod[0m, time elapsed: 181000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Mod (10800 ns)
    TCS: [33mTestCase_testVec1ScalarAdd[0m, time elapsed: 185400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarAdd (10600 ns)
    TCS: [33mTestCase_testVec1Negate[0m, time elapsed: 181600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Negate (8300 ns)
    TCS: [33mTestCase_testVec1AddNamed[0m, time elapsed: 161700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1AddNamed (5400 ns)
    TCS: [33mTestCase_testVec1SubNamed[0m, time elapsed: 180800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1SubNamed (11300 ns)
    TCS: [33mTestCase_testVec1MulNamed[0m, time elapsed: 171400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1MulNamed (9700 ns)
    TCS: [33mTestCase_testVec1Equal[0m, time elapsed: 175000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Equal (16400 ns)
    TCS: [33mTestCase_testVec1NotEqual[0m, time elapsed: 295600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1NotEqual (11300 ns)
    TCS: [33mTestCase_testVec1EqualExact[0m, time elapsed: 227300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1EqualExact (10200 ns)
    TCS: [33mTestCase_testVec1BitwiseAnd[0m, time elapsed: 201000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BitwiseAnd (16700 ns)
    TCS: [33mTestCase_testVec1BitwiseOr[0m, time elapsed: 188200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BitwiseOr (9900 ns)
    TCS: [33mTestCase_testVec1BitwiseXor[0m, time elapsed: 181400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BitwiseXor (15100 ns)
    TCS: [33mTestCase_testVec1ShiftLeft[0m, time elapsed: 188100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ShiftLeft (12600 ns)
    TCS: [33mTestCase_testVec1ShiftRight[0m, time elapsed: 190400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ShiftRight (10100 ns)
    TCS: [33mTestCase_testVec1BitwiseNot[0m, time elapsed: 164000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BitwiseNot (5500 ns)
    TCS: [33mTestCase_testVec1BoolLogicalAnd[0m, time elapsed: 167600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BoolLogicalAnd (6700 ns)
    TCS: [33mTestCase_testVec1BoolLogicalOr[0m, time elapsed: 172000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BoolLogicalOr (6100 ns)
    TCS: [33mTestCase_testVec1IndexOutOfBoundsAccess[0m, time elapsed: 235100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1IndexOutOfBoundsAccess (66600 ns)
    TCS: [33mTestCase_testVec1ShiftVec[0m, time elapsed: 183100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ShiftVec (6700 ns)
    TCS: [33mTestCase_testVec1ScalarSub[0m, time elapsed: 167400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarSub (6800 ns)
    TCS: [33mTestCase_testVec1ScalarMul[0m, time elapsed: 161900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarMul (6000 ns)
    TCS: [33mTestCase_testVec1ScalarDiv[0m, time elapsed: 168000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarDiv (5400 ns)
    TCS: [33mTestCase_testVec1ScalarMod[0m, time elapsed: 166700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarMod (8000 ns)
    TCS: [33mTestCase_testVec1DivNamed[0m, time elapsed: 164900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1DivNamed (5500 ns)
    TCS: [33mTestCase_testVec1ModNamed[0m, time elapsed: 167100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ModNamed (5200 ns)
    TCS: [33mTestCase_testVec1ScalarBitwiseAnd[0m, time elapsed: 176200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarBitwiseAnd (13700 ns)
    TCS: [33mTestCase_testVec1ScalarBitwiseOr[0m, time elapsed: 166400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarBitwiseOr (6000 ns)
    TCS: [33mTestCase_testVec1ScalarBitwiseXor[0m, time elapsed: 163700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarBitwiseXor (5200 ns)
    TCS: [33mTestCase_testVec1ShiftRightVec[0m, time elapsed: 176900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ShiftRightVec (5500 ns)
    TCS: [33mTestCase_testVec1EqualEpsilon[0m, time elapsed: 173300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1EqualEpsilon (13500 ns)
    TCS: [33mTestCase_testVec1BroadcastAddVec2[0m, time elapsed: 179100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastAddVec2 (10400 ns)
    TCS: [33mTestCase_testVec1BroadcastBitAndVec2[0m, time elapsed: 281600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastBitAndVec2 (11900 ns)
    TCS: [33mTestCase_testVec1BroadcastAddVec3[0m, time elapsed: 179400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastAddVec3 (12000 ns)
    TCS: [33mTestCase_testVec1BroadcastAddVec4[0m, time elapsed: 187100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastAddVec4 (18100 ns)
    TCS: [33mTestCase_testVec1BroadcastBitOrVec2[0m, time elapsed: 184000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastBitOrVec2 (9500 ns)
    TCS: [33mTestCase_testVec1BroadcastBitXorVec2[0m, time elapsed: 178100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastBitXorVec2 (12700 ns)
    TCS: [33mTestCase_testVec1BroadcastShiftLeftVec2[0m, time elapsed: 163500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastShiftLeftVec2 (6100 ns)
    TCS: [33mTestCase_testVec1BroadcastShiftRightVec2[0m, time elapsed: 168800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastShiftRightVec2 (6300 ns)
    TCS: [33mTestCase_testVec1BroadcastBitAndVec3[0m, time elapsed: 177600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastBitAndVec3 (8600 ns)
    TCS: [33mTestCase_testVec1BroadcastBitAndVec4[0m, time elapsed: 187400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastBitAndVec4 (19900 ns)
    TCS: [33mTestCase_testVec1BroadcastModVec2[0m, time elapsed: 170300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastModVec2 (8300 ns)
    TCS: [33mTestCase_testVec1BroadcastModVec3[0m, time elapsed: 171800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastModVec3 (10100 ns)
    TCS: [33mTestCase_testVec1BroadcastModVec4[0m, time elapsed: 177500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastModVec4 (9500 ns)
    TCS: [33mTestCase_testVec1Increment[0m, time elapsed: 172700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Increment (10800 ns)
    TCS: [33mTestCase_testVec1Decrement[0m, time elapsed: 168500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Decrement (8900 ns)
    TCS: [33mTestCase_testVec2ScalarInit[0m, time elapsed: 266500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarInit (10300 ns)
    TCS: [33mTestCase_testVec2ConstInit[0m, time elapsed: 318000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ConstInit (15600 ns)
    TCS: [33mTestCase_testVec2Length[0m, time elapsed: 187400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Length (7400 ns)
    TCS: [33mTestCase_testVec2Add[0m, time elapsed: 248800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Add (13200 ns)
    TCS: [33mTestCase_testVec2Sub[0m, time elapsed: 235200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Sub (14700 ns)
    TCS: [33mTestCase_testVec2Mul[0m, time elapsed: 191300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Mul (15800 ns)
    TCS: [33mTestCase_testVec2ScalarAdd[0m, time elapsed: 173700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarAdd (9100 ns)
    TCS: [33mTestCase_testVec2Negate[0m, time elapsed: 210000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Negate (7800 ns)
    TCS: [33mTestCase_testVec2IndexAccess[0m, time elapsed: 164300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2IndexAccess (5900 ns)
    TCS: [33mTestCase_testVec2IndexMutate[0m, time elapsed: 189600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2IndexMutate (8500 ns)
    TCS: [33mTestCase_testVec2ComponentAt[0m, time elapsed: 162100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ComponentAt (8300 ns)
    TCS: [33mTestCase_testVec2Equal[0m, time elapsed: 172800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Equal (11200 ns)
    TCS: [33mTestCase_testVec2NotEqual[0m, time elapsed: 166900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2NotEqual (9200 ns)
    TCS: [33mTestCase_testVec2EqualExact[0m, time elapsed: 173400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2EqualExact (11300 ns)
    TCS: [33mTestCase_testVec2BitwiseAnd[0m, time elapsed: 169100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseAnd (10100 ns)
    TCS: [33mTestCase_testVec2BitwiseNot[0m, time elapsed: 167100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseNot (5200 ns)
    TCS: [33mTestCase_testVec2FromVec1[0m, time elapsed: 162000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2FromVec1 (6500 ns)
    TCS: [33mTestCase_testVec2ShiftLeft[0m, time elapsed: 179400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeft (12100 ns)
    TCS: [33mTestCase_testVec2BoolLogicalAnd[0m, time elapsed: 167300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BoolLogicalAnd (10000 ns)
    TCS: [33mTestCase_testVec2Vec1ArithBroadcast[0m, time elapsed: 349100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Vec1ArithBroadcast (14700 ns)
    TCS: [33mTestCase_testVec2Vec1BitBroadcast[0m, time elapsed: 327100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Vec1BitBroadcast (21600 ns)
    TCS: [33mTestCase_testVec2ShiftLeftVec1[0m, time elapsed: 313900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeftVec1 (15100 ns)
    TCS: [33mTestCase_testVec2Div[0m, time elapsed: 303700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Div (18700 ns)
    TCS: [33mTestCase_testVec2Mod[0m, time elapsed: 241200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Mod (11900 ns)
    TCS: [33mTestCase_testVec2ScalarSub[0m, time elapsed: 172400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarSub (11500 ns)
    TCS: [33mTestCase_testVec2ScalarMul[0m, time elapsed: 201300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarMul (19100 ns)
    TCS: [33mTestCase_testVec2ScalarDiv[0m, time elapsed: 179900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarDiv (9000 ns)
    TCS: [33mTestCase_testVec2ScalarMod[0m, time elapsed: 183700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarMod (21800 ns)
    TCS: [33mTestCase_testVec2BoolLogicalOr[0m, time elapsed: 185800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BoolLogicalOr (9100 ns)
    TCS: [33mTestCase_testVec2EqualEpsilon[0m, time elapsed: 206500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2EqualEpsilon (23200 ns)
    TCS: [33mTestCase_testVec2DivNamed[0m, time elapsed: 297900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2DivNamed (18200 ns)
    TCS: [33mTestCase_testVec2ModNamed[0m, time elapsed: 339700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ModNamed (13900 ns)
    TCS: [33mTestCase_testVec2BitwiseOr[0m, time elapsed: 335600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseOr (18200 ns)
    TCS: [33mTestCase_testVec2BitwiseXor[0m, time elapsed: 275700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseXor (18600 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseAnd[0m, time elapsed: 200400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseAnd (7100 ns)
    TCS: [33mTestCase_testVec2ShiftRight[0m, time elapsed: 176400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRight (9800 ns)
    TCS: [33mTestCase_testVec2ShiftRightVec1[0m, time elapsed: 168800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRightVec1 (8300 ns)
    TCS: [33mTestCase_testVec2AddNamed[0m, time elapsed: 173500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2AddNamed (6700 ns)
    TCS: [33mTestCase_testVec2SubNamed[0m, time elapsed: 176700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2SubNamed (8600 ns)
    TCS: [33mTestCase_testVec2MulNamed[0m, time elapsed: 181000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2MulNamed (6700 ns)
    TCS: [33mTestCase_testVec2ShiftLeftVec[0m, time elapsed: 172300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeftVec (6700 ns)
    TCS: [33mTestCase_testVec2ShiftRightVec[0m, time elapsed: 165700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRightVec (6200 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseOr[0m, time elapsed: 186700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseOr (7100 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseXor[0m, time elapsed: 204600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseXor (30500 ns)
    TCS: [33mTestCase_testVec2Increment[0m, time elapsed: 185900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Increment (18600 ns)
    TCS: [33mTestCase_testVec2Decrement[0m, time elapsed: 169300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Decrement (9100 ns)
    TCS: [33mTestCase_testVec2IndexOutOfBoundsAccess[0m, time elapsed: 226000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2IndexOutOfBoundsAccess (48500 ns)
    TCS: [33mTestCase_testVec2NegativeIndexAccess[0m, time elapsed: 214200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2NegativeIndexAccess (28000 ns)
    TCS: [33mTestCase_testVec3ScalarInit[0m, time elapsed: 189000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarInit (9900 ns)
    TCS: [33mTestCase_testVec3ConstInit[0m, time elapsed: 211400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ConstInit (10700 ns)
    TCS: [33mTestCase_testVec3Length[0m, time elapsed: 194500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Length (6400 ns)
    TCS: [33mTestCase_testVec3Add[0m, time elapsed: 192300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Add (15900 ns)
    TCS: [33mTestCase_testVec3ScalarMul[0m, time elapsed: 205500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarMul (16900 ns)
    TCS: [33mTestCase_testVec3Negate[0m, time elapsed: 191200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Negate (10200 ns)
    TCS: [33mTestCase_testVec3IndexAccess[0m, time elapsed: 208200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3IndexAccess (10200 ns)
    TCS: [33mTestCase_testVec3IndexMutate[0m, time elapsed: 175000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3IndexMutate (9600 ns)
    TCS: [33mTestCase_testVec3ComponentAt[0m, time elapsed: 219300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ComponentAt (7100 ns)
    TCS: [33mTestCase_testVec3Equal[0m, time elapsed: 266400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Equal (17900 ns)
    TCS: [33mTestCase_testVec3NotEqual[0m, time elapsed: 206000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3NotEqual (12200 ns)
    TCS: [33mTestCase_testVec3EqualExact[0m, time elapsed: 177300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3EqualExact (9300 ns)
    TCS: [33mTestCase_testVec3BitwiseAnd[0m, time elapsed: 215700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseAnd (14100 ns)
    TCS: [33mTestCase_testVec3BitwiseNot[0m, time elapsed: 167200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseNot (5900 ns)
    TCS: [33mTestCase_testVec3Vec1ArithBroadcast[0m, time elapsed: 185100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1ArithBroadcast (11600 ns)
    TCS: [33mTestCase_testVec3ShiftLeft[0m, time elapsed: 175700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeft (10000 ns)
    TCS: [33mTestCase_testVec3BoolLogicalAnd[0m, time elapsed: 189900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BoolLogicalAnd (8600 ns)
    TCS: [33mTestCase_testVec3Sub[0m, time elapsed: 179500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Sub (15100 ns)
    TCS: [33mTestCase_testVec3Div[0m, time elapsed: 187600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Div (15500 ns)
    TCS: [33mTestCase_testVec3Mod[0m, time elapsed: 491900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Mod (28000 ns)
    TCS: [33mTestCase_testVec3ScalarSub[0m, time elapsed: 338600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarSub (27400 ns)
    TCS: [33mTestCase_testVec3ScalarDiv[0m, time elapsed: 340900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarDiv (23600 ns)
    TCS: [33mTestCase_testVec3ScalarMod[0m, time elapsed: 244200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarMod (17100 ns)
    TCS: [33mTestCase_testVec3BoolLogicalOr[0m, time elapsed: 235100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BoolLogicalOr (27900 ns)
    TCS: [33mTestCase_testVec3EqualEpsilon[0m, time elapsed: 253500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3EqualEpsilon (33900 ns)
    TCS: [33mTestCase_testVec3AddNamed[0m, time elapsed: 255900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3AddNamed (14600 ns)
    TCS: [33mTestCase_testVec3MulNamed[0m, time elapsed: 183600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3MulNamed (6900 ns)
    TCS: [33mTestCase_testVec3DivNamed[0m, time elapsed: 216800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3DivNamed (9700 ns)
    TCS: [33mTestCase_testVec3ModNamed[0m, time elapsed: 218400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ModNamed (8200 ns)
    TCS: [33mTestCase_testVec3BitwiseOr[0m, time elapsed: 209900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseOr (22700 ns)
    TCS: [33mTestCase_testVec3BitwiseXor[0m, time elapsed: 188800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseXor (12100 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseAnd[0m, time elapsed: 187600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseAnd (14500 ns)
    TCS: [33mTestCase_testVec3ShiftRight[0m, time elapsed: 181200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRight (13200 ns)
    TCS: [33mTestCase_testVec3Vec1BitBroadcast[0m, time elapsed: 208200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitBroadcast (11200 ns)
    TCS: [33mTestCase_testVec3ShiftRightVec1[0m, time elapsed: 212000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRightVec1 (18100 ns)
    TCS: [33mTestCase_testVec3FromVec1[0m, time elapsed: 216100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3FromVec1 (7800 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseOr[0m, time elapsed: 199200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseOr (13800 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseXor[0m, time elapsed: 207300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseXor (20600 ns)
    TCS: [33mTestCase_testVec3Vec1BitOrBroadcast[0m, time elapsed: 176300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitOrBroadcast (10400 ns)
    TCS: [33mTestCase_testVec3Vec1BitXorBroadcast[0m, time elapsed: 199400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitXorBroadcast (11800 ns)
    TCS: [33mTestCase_testVec3ShiftLeftVec1[0m, time elapsed: 174500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeftVec1 (13900 ns)
    TCS: [33mTestCase_testVec3ShiftLeftVec[0m, time elapsed: 211600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeftVec (8800 ns)
    TCS: [33mTestCase_testVec3ShiftRightVec[0m, time elapsed: 327400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRightVec (12800 ns)
    TCS: [33mTestCase_testVec3Increment[0m, time elapsed: 312200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Increment (23700 ns)
    TCS: [33mTestCase_testVec3Decrement[0m, time elapsed: 212700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Decrement (13100 ns)
    TCS: [33mTestCase_testVec3IndexOutOfBoundsAccess[0m, time elapsed: 246800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3IndexOutOfBoundsAccess (50400 ns)
    TCS: [33mTestCase_testVec3NegativeIndexAccess[0m, time elapsed: 192400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3NegativeIndexAccess (19500 ns)
    TCS: [33mTestCase_testVec4ScalarInit[0m, time elapsed: 188200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarInit (10400 ns)
    TCS: [33mTestCase_testVec4ConstInit[0m, time elapsed: 184600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ConstInit (8300 ns)
    TCS: [33mTestCase_testVec4Length[0m, time elapsed: 192200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Length (5400 ns)
    TCS: [33mTestCase_testVec4Add[0m, time elapsed: 176500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Add (13500 ns)
    TCS: [33mTestCase_testVec4ScalarMul[0m, time elapsed: 182400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarMul (9900 ns)
    TCS: [33mTestCase_testVec4Negate[0m, time elapsed: 188000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Negate (9100 ns)
    TCS: [33mTestCase_testVec4IndexAccess[0m, time elapsed: 189000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4IndexAccess (8600 ns)
    TCS: [33mTestCase_testVec4IndexMutate[0m, time elapsed: 168900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4IndexMutate (8000 ns)
    TCS: [33mTestCase_testVec4ComponentAt[0m, time elapsed: 177500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ComponentAt (5800 ns)
    TCS: [33mTestCase_testVec4Equal[0m, time elapsed: 193000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Equal (21000 ns)
    TCS: [33mTestCase_testVec4NotEqual[0m, time elapsed: 241100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4NotEqual (10300 ns)
    TCS: [33mTestCase_testVec4EqualExact[0m, time elapsed: 178500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4EqualExact (13500 ns)
    TCS: [33mTestCase_testVec4BitwiseAnd[0m, time elapsed: 186000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseAnd (10600 ns)
    TCS: [33mTestCase_testVec4BitwiseNot[0m, time elapsed: 180400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseNot (6000 ns)
    TCS: [33mTestCase_testVec4Vec1ArithBroadcast[0m, time elapsed: 200400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1ArithBroadcast (15100 ns)
    TCS: [33mTestCase_testVec4ShiftLeft[0m, time elapsed: 245800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeft (33100 ns)
    TCS: [33mTestCase_testVec4BoolLogicalAnd[0m, time elapsed: 198400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BoolLogicalAnd (10600 ns)
    TCS: [33mTestCase_testVec4Sub[0m, time elapsed: 197100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Sub (15500 ns)
    TCS: [33mTestCase_testVec4Div[0m, time elapsed: 213600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Div (16800 ns)
    TCS: [33mTestCase_testVec4Mod[0m, time elapsed: 174400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Mod (10600 ns)
    TCS: [33mTestCase_testVec4ScalarSub[0m, time elapsed: 192600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarSub (16100 ns)
    TCS: [33mTestCase_testVec4ScalarDiv[0m, time elapsed: 178900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarDiv (9100 ns)
    TCS: [33mTestCase_testVec4ScalarMod[0m, time elapsed: 174700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarMod (9200 ns)
    TCS: [33mTestCase_testVec4BoolLogicalOr[0m, time elapsed: 163800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BoolLogicalOr (8000 ns)
    TCS: [33mTestCase_testVec4EqualEpsilon[0m, time elapsed: 189400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4EqualEpsilon (16100 ns)
    TCS: [33mTestCase_testVec4AddNamed[0m, time elapsed: 185900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4AddNamed (11500 ns)
    TCS: [33mTestCase_testVec4MulNamed[0m, time elapsed: 182500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4MulNamed (6600 ns)
    TCS: [33mTestCase_testVec4DivNamed[0m, time elapsed: 162900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4DivNamed (5900 ns)
    TCS: [33mTestCase_testVec4ModNamed[0m, time elapsed: 255000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ModNamed (6400 ns)
    TCS: [33mTestCase_testVec4BitwiseOr[0m, time elapsed: 344600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseOr (24000 ns)
    TCS: [33mTestCase_testVec4BitwiseXor[0m, time elapsed: 231400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseXor (26400 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseAnd[0m, time elapsed: 192600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseAnd (11600 ns)
    TCS: [33mTestCase_testVec4ShiftRight[0m, time elapsed: 215000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRight (15300 ns)
    TCS: [33mTestCase_testVec4Vec1BitBroadcast[0m, time elapsed: 207700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitBroadcast (14900 ns)
    TCS: [33mTestCase_testVec4ShiftRightVec1[0m, time elapsed: 260800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRightVec1 (20000 ns)
    TCS: [33mTestCase_testVec4FromVec1[0m, time elapsed: 195000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4FromVec1 (7800 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseOr[0m, time elapsed: 197500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseOr (17800 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseXor[0m, time elapsed: 200700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseXor (15700 ns)
    TCS: [33mTestCase_testVec4Vec1BitOrBroadcast[0m, time elapsed: 240000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitOrBroadcast (24600 ns)
    TCS: [33mTestCase_testVec4Vec1BitXorBroadcast[0m, time elapsed: 227300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitXorBroadcast (21100 ns)
    TCS: [33mTestCase_testVec4ShiftLeftVec1[0m, time elapsed: 220900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeftVec1 (17900 ns)
    TCS: [33mTestCase_testVec4ShiftLeftVec[0m, time elapsed: 201700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeftVec (17000 ns)
    TCS: [33mTestCase_testVec4ShiftRightVec[0m, time elapsed: 195700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRightVec (15400 ns)
    TCS: [33mTestCase_testVec4Increment[0m, time elapsed: 204900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Increment (19900 ns)
    TCS: [33mTestCase_testVec4Decrement[0m, time elapsed: 202100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Decrement (20800 ns)
    TCS: [33mTestCase_testVec4IndexOutOfBoundsAccess[0m, time elapsed: 244100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4IndexOutOfBoundsAccess (46500 ns)
    TCS: [33mTestCase_testVec4NegativeIndexAccess[0m, time elapsed: 290200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4NegativeIndexAccess (51700 ns)
    TCS: [33mTestCase_testFunctor1Vec1Identity[0m, time elapsed: 300000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec1Identity (29000 ns)
    TCS: [33mTestCase_testFunctor1Vec1Transform[0m, time elapsed: 293800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec1Transform (18100 ns)
    TCS: [33mTestCase_testFunctor1Vec2Transform[0m, time elapsed: 331300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec2Transform (32500 ns)
    TCS: [33mTestCase_testFunctor2Vec1Add[0m, time elapsed: 285700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec1Add (21700 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec1Mul[0m, time elapsed: 339000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec1Mul (24400 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec1Shift[0m, time elapsed: 224600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec1Shift (11400 ns)
    TCS: [33mTestCase_testFunctor1Vec3Transform[0m, time elapsed: 231000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec3Transform (13500 ns)
    TCS: [33mTestCase_testFunctor1Vec4Transform[0m, time elapsed: 224900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec4Transform (13200 ns)
    TCS: [33mTestCase_testFunctor2Vec2Add[0m, time elapsed: 260200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec2Add (12100 ns)
    TCS: [33mTestCase_testFunctor2Vec3Add[0m, time elapsed: 213400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec3Add (10600 ns)
    TCS: [33mTestCase_testFunctor2Vec4Add[0m, time elapsed: 210700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec4Add (13900 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec2Mul[0m, time elapsed: 194300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec2Mul (14300 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec3Mul[0m, time elapsed: 208600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec3Mul (11100 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec4Mul[0m, time elapsed: 193400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec4Mul (12000 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec2Shift[0m, time elapsed: 213200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec2Shift (10800 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec3Shift[0m, time elapsed: 193000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec3Shift (8500 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec4Shift[0m, time elapsed: 207800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec4Shift (8600 ns)
Summary: TOTAL: 476
    [32mPASSED[0m: 476, [32mSKIPPED[0m: 0, ERROR: 0
    [31mFAILED[0m: 0
--------------------------------------------------------------------------------------------------
Project tests finished, time elapsed: 185640200 ns, RESULT:
TP: [33mglm[0m.*, time elapsed: 185559700 ns, RESULT:
    PASSED:
    TP: [33mglm.detail[0m, time elapsed: 169570000 ns
Summary: TOTAL: 476
    [32mPASSED[0m: 476, [32mSKIPPED[0m: 0, ERROR: 0
    [31mFAILED[0m: 0
--------------------------------------------------------------------------------------------------
[0J7[;r8[?25hcjpm test success
