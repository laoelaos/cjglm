# 验证报告（v9）

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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:155:58:
    | 
155 |     public static func fromMat<SrcQ>(m: Mat3x2<T, SrcQ>, one: T): Mat2x4<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:161:58:
    | 
161 |     public static func fromMat<SrcQ>(m: Mat3x3<T, SrcQ>, one: T): Mat2x4<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:167:58:
    | 
167 |     public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat2x3<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:169:13:
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:169:13:
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:173:58:
    | 
173 |     public static func fromMat<SrcQ>(m: Mat4x2<T, SrcQ>, one: T): Mat2x3<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:173:58:
    | 
173 |     public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat3x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x3.cj:179:58:
    | 
179 |     public static func fromMat<SrcQ>(m: Mat3x3<T, SrcQ>, one: T): Mat4x3<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:179:58:
    | 
179 |     public static func fromMat<SrcQ>(m: Mat3x3<T, SrcQ>, one: T): Mat4x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:179:58:
    | 
179 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat2x3<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x4.cj:185:58:
    | 
185 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat3x4<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:185:58:
    | 
185 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat3x2<T, Q>
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

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:186:13:
    | 
186 |         let zero = m.c0.x - m.c0.x
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

warning[0m: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:187:13:
    | 
187 |         let zero = m.c0.x - m.c0.x
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:193:13:
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:197:58:
    | 
197 |     public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat4x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x3.cj:197:58:
    | 
197 |     public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat4x3<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:221:13:
    | 
221 |         let zero = one - one
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:239:13:
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:239:13:
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x4.cj:245:13:
    | 
245 |         let zero = one - one
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x3.cj:251:13:
    | 
251 |         let zero = one - one
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

171 warnings generated, 171 warnings printed.
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


[3F7[9999E[2F📦 group glm.detail                   71% [90m[[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[90m------[0m[90m][0m [32m    [0m (00:00:00)

passed: [32m338[0m, failed: 0             71% [90m[[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[90m------[0m[90m][0m 338/476 (00:00:00) 8--------------------------------------------------------------------------------------------------
TP: [33mglm.detail[0m, time elapsed: 237986700 ns, RESULT:
    TCS: [33mTestCase_testComputeVecAdd1[0m, time elapsed: 1787500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAdd1 (350000 ns)
    TCS: [33mTestCase_testComputeVecSub2[0m, time elapsed: 533600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub2 (65900 ns)
    TCS: [33mTestCase_testComputeVecMul3[0m, time elapsed: 620100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul3 (68600 ns)
    TCS: [33mTestCase_testComputeVecMod1[0m, time elapsed: 414500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMod1 (37100 ns)
    TCS: [33mTestCase_testComputeVecMod4[0m, time elapsed: 322800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMod4 (30900 ns)
    TCS: [33mTestCase_testComputeVecAnd1[0m, time elapsed: 388200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAnd1 (28100 ns)
    TCS: [33mTestCase_testComputeVecAnd3[0m, time elapsed: 316300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAnd3 (25400 ns)
    TCS: [33mTestCase_testComputeVecOr1[0m, time elapsed: 346400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecOr1 (24100 ns)
    TCS: [33mTestCase_testComputeVecOr2[0m, time elapsed: 332600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecOr2 (22400 ns)
    TCS: [33mTestCase_testComputeVecXor1[0m, time elapsed: 481800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecXor1 (40100 ns)
    TCS: [33mTestCase_testComputeVecXor4[0m, time elapsed: 363600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecXor4 (27300 ns)
    TCS: [33mTestCase_testComputeVecShiftLeft1[0m, time elapsed: 425800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftLeft1 (64100 ns)
    TCS: [33mTestCase_testComputeVecShiftLeft3[0m, time elapsed: 306400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftLeft3 (19900 ns)
    TCS: [33mTestCase_testComputeVecShiftRight1[0m, time elapsed: 378900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftRight1 (21700 ns)
    TCS: [33mTestCase_testComputeVecShiftRight4[0m, time elapsed: 320500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftRight4 (23500 ns)
    TCS: [33mTestCase_testComputeVecEqual1[0m, time elapsed: 425600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual1 (64700 ns)
    TCS: [33mTestCase_testComputeVecNequal4[0m, time elapsed: 419300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal4 (45100 ns)
    TCS: [33mTestCase_testComputeVecBitwiseNot1[0m, time elapsed: 390400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecBitwiseNot1 (46400 ns)
    TCS: [33mTestCase_testComputeVecBitwiseNot3[0m, time elapsed: 326800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecBitwiseNot3 (38700 ns)
    TCS: [33mTestCase_testComputeVecAdd4[0m, time elapsed: 283900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAdd4 (24000 ns)
    TCS: [33mTestCase_testComputeVecSub1[0m, time elapsed: 24438600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub1 (20000 ns)
    TCS: [33mTestCase_testComputeVecSub3[0m, time elapsed: 475500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub3 (96900 ns)
    TCS: [33mTestCase_testComputeVecMul1[0m, time elapsed: 263100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul1 (20400 ns)
    TCS: [33mTestCase_testComputeVecMul2[0m, time elapsed: 250800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul2 (18400 ns)
    TCS: [33mTestCase_testComputeVecDiv1[0m, time elapsed: 299200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecDiv1 (21800 ns)
    TCS: [33mTestCase_testComputeVecDiv2[0m, time elapsed: 254100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecDiv2 (17600 ns)
    TCS: [33mTestCase_testComputeVecDiv4[0m, time elapsed: 249300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecDiv4 (18000 ns)
    TCS: [33mTestCase_testComputeVecEqual2[0m, time elapsed: 247300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual2 (14200 ns)
    TCS: [33mTestCase_testComputeVecEqual3[0m, time elapsed: 263600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual3 (19300 ns)
    TCS: [33mTestCase_testComputeVecEqual4[0m, time elapsed: 309300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual4 (26200 ns)
    TCS: [33mTestCase_testComputeVecNequal1[0m, time elapsed: 243500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal1 (19100 ns)
    TCS: [33mTestCase_testComputeVecNequal2[0m, time elapsed: 262700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal2 (13600 ns)
    TCS: [33mTestCase_testComputeVecBitwiseNot4[0m, time elapsed: 320700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecBitwiseNot4 (37600 ns)
    TCS: [33mTestCase_testComputeVecAddFloat32[0m, time elapsed: 408600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAddFloat32 (40900 ns)
    TCS: [33mTestCase_testComputeVecAddFloat32Vec3[0m, time elapsed: 524700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAddFloat32Vec3 (62300 ns)
    TCS: [33mTestCase_testComputeVecSubFloat32[0m, time elapsed: 508700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSubFloat32 (47600 ns)
    TCS: [33mTestCase_testComputeVecSubFloat32Vec4[0m, time elapsed: 505700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSubFloat32Vec4 (63400 ns)
    TCS: [33mTestCase_testComputeEqualInt32Equal[0m, time elapsed: 295900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt32Equal (25600 ns)
    TCS: [33mTestCase_testComputeEqualInt32NotEqual[0m, time elapsed: 612800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt32NotEqual (47800 ns)
    TCS: [33mTestCase_testComputeEqualFloat32Equal[0m, time elapsed: 697700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32Equal (38100 ns)
    TCS: [33mTestCase_testComputeEqualFloat32NotEqual[0m, time elapsed: 365700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32NotEqual (23300 ns)
    TCS: [33mTestCase_testComputeEqualFloat64Equal[0m, time elapsed: 249600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64Equal (13000 ns)
    TCS: [33mTestCase_testComputeEqualFloat64NotEqual[0m, time elapsed: 415600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64NotEqual (25500 ns)
    TCS: [33mTestCase_testComputeEqualBoolEqual[0m, time elapsed: 466800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualBoolEqual (25500 ns)
    TCS: [33mTestCase_testComputeEqualBoolNotEqual[0m, time elapsed: 281600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualBoolNotEqual (15200 ns)
    TCS: [33mTestCase_testComputeEqualNumericInt32[0m, time elapsed: 305700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericInt32 (14200 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32[0m, time elapsed: 316000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32 (47900 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32Epsilon[0m, time elapsed: 298200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32Epsilon (12800 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64[0m, time elapsed: 322200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64 (18600 ns)
    TCS: [33mTestCase_testComputeEqualInt64Equal[0m, time elapsed: 391500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt64Equal (20400 ns)
    TCS: [33mTestCase_testComputeEqualInt64NotEqual[0m, time elapsed: 402700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt64NotEqual (20700 ns)
    TCS: [33mTestCase_testComputeEqualFloat32Nan[0m, time elapsed: 419100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32Nan (15900 ns)
    TCS: [33mTestCase_testComputeEqualFloat64Nan[0m, time elapsed: 317000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64Nan (13800 ns)
    TCS: [33mTestCase_testComputeEqualFloat32SignedZero[0m, time elapsed: 337100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32SignedZero (13400 ns)
    TCS: [33mTestCase_testComputeEqualFloat64SignedZero[0m, time elapsed: 252400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64SignedZero (11000 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32NotEqual[0m, time elapsed: 323900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32NotEqual (19300 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32BeyondEpsilon[0m, time elapsed: 258400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32BeyondEpsilon (12400 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64NotEqual[0m, time elapsed: 260500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64NotEqual (17800 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64Epsilon[0m, time elapsed: 315300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64Epsilon (13500 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64BeyondEpsilon[0m, time elapsed: 291200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64BeyondEpsilon (30700 ns)
    TCS: [33mTestCase_testComputeEqualNumericInt64[0m, time elapsed: 382300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericInt64 (16100 ns)
    TCS: [33mTestCase_testPackedHighpImplementsQualifier[0m, time elapsed: 230300 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedHighpImplementsQualifier (9100 ns)
    TCS: [33mTestCase_testPackedMediumpImplementsQualifier[0m, time elapsed: 235300 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedMediumpImplementsQualifier (8500 ns)
    TCS: [33mTestCase_testPackedLowpImplementsQualifier[0m, time elapsed: 272300 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedLowpImplementsQualifier (15500 ns)
    TCS: [33mTestCase_testDefaultpIsPackedHighp[0m, time elapsed: 219400 ns, RESULT:
    [[32m PASSED [0m] CASE: testDefaultpIsPackedHighp (8500 ns)
    TCS: [33mTestCase_testScalarAddVec1[0m, time elapsed: 224500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec1 (17500 ns)
    TCS: [33mTestCase_testScalarAddVec2[0m, time elapsed: 275800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec2 (25500 ns)
    TCS: [33mTestCase_testScalarAddVec3[0m, time elapsed: 252400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec3 (27400 ns)
    TCS: [33mTestCase_testScalarAddVec4[0m, time elapsed: 333800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec4 (15200 ns)
    TCS: [33mTestCase_testScalarSubVec1[0m, time elapsed: 282200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1 (19300 ns)
    TCS: [33mTestCase_testScalarMulVec1[0m, time elapsed: 267100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1 (23100 ns)
    TCS: [33mTestCase_testScalarDivVec1[0m, time elapsed: 589000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1 (39200 ns)
    TCS: [33mTestCase_testScalarModVec1[0m, time elapsed: 561500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1 (30600 ns)
    TCS: [33mTestCase_testScalarMulVec2[0m, time elapsed: 285000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2 (27900 ns)
    TCS: [33mTestCase_testScalarSubVec2[0m, time elapsed: 263300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2 (13500 ns)
    TCS: [33mTestCase_testScalarSubVec3[0m, time elapsed: 228800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3 (15700 ns)
    TCS: [33mTestCase_testScalarSubVec4[0m, time elapsed: 262800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4 (18800 ns)
    TCS: [33mTestCase_testScalarMulVec3[0m, time elapsed: 231900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3 (13100 ns)
    TCS: [33mTestCase_testScalarMulVec4[0m, time elapsed: 241200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4 (19600 ns)
    TCS: [33mTestCase_testScalarDivVec2[0m, time elapsed: 286700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2 (16000 ns)
    TCS: [33mTestCase_testScalarDivVec3[0m, time elapsed: 273000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3 (18100 ns)
    TCS: [33mTestCase_testScalarDivVec4[0m, time elapsed: 239000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4 (15400 ns)
    TCS: [33mTestCase_testScalarModVec2[0m, time elapsed: 294500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2 (19600 ns)
    TCS: [33mTestCase_testScalarModVec3[0m, time elapsed: 223300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3 (12000 ns)
    TCS: [33mTestCase_testScalarModVec4[0m, time elapsed: 222300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4 (11900 ns)
    TCS: [33mTestCase_testScalarModVec1Float32[0m, time elapsed: 261400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float32 (24800 ns)
    TCS: [33mTestCase_testScalarModVec2Float32[0m, time elapsed: 259300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32 (17900 ns)
    TCS: [33mTestCase_testScalarModVec3Float32[0m, time elapsed: 283000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float32 (17700 ns)
    TCS: [33mTestCase_testScalarModVec4Float32[0m, time elapsed: 295900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float32 (18600 ns)
    TCS: [33mTestCase_testScalarModVec1Float64[0m, time elapsed: 360900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float64 (16000 ns)
    TCS: [33mTestCase_testScalarModVec2Float64[0m, time elapsed: 343900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float64 (16200 ns)
    TCS: [33mTestCase_testScalarModVec3Float64[0m, time elapsed: 257100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float64 (11600 ns)
    TCS: [33mTestCase_testScalarModVec4Float64[0m, time elapsed: 290400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float64 (18200 ns)
    TCS: [33mTestCase_testScalarModVec1Float16[0m, time elapsed: 274300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float16 (35100 ns)
    TCS: [33mTestCase_testScalarModVec2Float16[0m, time elapsed: 276900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float16 (11600 ns)
    TCS: [33mTestCase_testScalarModVec3Float16[0m, time elapsed: 235300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float16 (10300 ns)
    TCS: [33mTestCase_testScalarModVec4Float16[0m, time elapsed: 245100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float16 (11600 ns)
    TCS: [33mTestCase_testScalarSubVec2PackedMediump[0m, time elapsed: 329500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2PackedMediump (37100 ns)
    TCS: [33mTestCase_testScalarSubVec2PackedLowp[0m, time elapsed: 242500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2PackedLowp (18800 ns)
    TCS: [33mTestCase_testScalarMulVec2PackedMediump[0m, time elapsed: 227300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2PackedMediump (13100 ns)
    TCS: [33mTestCase_testScalarMulVec2PackedLowp[0m, time elapsed: 248700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2PackedLowp (13600 ns)
    TCS: [33mTestCase_testScalarDivVec2PackedMediump[0m, time elapsed: 224300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2PackedMediump (13300 ns)
    TCS: [33mTestCase_testScalarDivVec2PackedLowp[0m, time elapsed: 224600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2PackedLowp (12800 ns)
    TCS: [33mTestCase_testScalarModVec2PackedMediump[0m, time elapsed: 320200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2PackedMediump (17200 ns)
    TCS: [33mTestCase_testScalarModVec2PackedLowp[0m, time elapsed: 241200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2PackedLowp (10300 ns)
    TCS: [33mTestCase_testScalarModVec2Float32PackedMediump[0m, time elapsed: 325700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32PackedMediump (12500 ns)
    TCS: [33mTestCase_testScalarModVec2Float32PackedLowp[0m, time elapsed: 248300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32PackedLowp (20300 ns)
    TCS: [33mTestCase_testScalarModVec2Float32NegativeDividend[0m, time elapsed: 243300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32NegativeDividend (10000 ns)
    TCS: [33mTestCase_testScalarModVec2Float32NegativeDivisor[0m, time elapsed: 290500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32NegativeDivisor (30100 ns)
    TCS: [33mTestCase_testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents[0m, time elapsed: 609500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents (226100 ns)
    TCS: [33mTestCase_testScalarAddVec1Float32[0m, time elapsed: 735700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec1Float32 (33600 ns)
    TCS: [33mTestCase_testScalarAddVec2Float32[0m, time elapsed: 571500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec2Float32 (44000 ns)
    TCS: [33mTestCase_testScalarAddVec3Float32[0m, time elapsed: 582700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec3Float32 (32800 ns)
    TCS: [33mTestCase_testScalarAddVec4Float32[0m, time elapsed: 369300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec4Float32 (21900 ns)
    TCS: [33mTestCase_testScalarSubVec1Float32[0m, time elapsed: 284700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1Float32 (28000 ns)
    TCS: [33mTestCase_testScalarSubVec2Float32[0m, time elapsed: 230200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2Float32 (12100 ns)
    TCS: [33mTestCase_testScalarSubVec3Float32[0m, time elapsed: 308700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3Float32 (12100 ns)
    TCS: [33mTestCase_testScalarSubVec4Float32[0m, time elapsed: 294200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4Float32 (20800 ns)
    TCS: [33mTestCase_testScalarMulVec1Float32[0m, time elapsed: 234700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1Float32 (11400 ns)
    TCS: [33mTestCase_testScalarMulVec2Float32[0m, time elapsed: 318800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2Float32 (18400 ns)
    TCS: [33mTestCase_testScalarMulVec3Float32[0m, time elapsed: 261500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3Float32 (12900 ns)
    TCS: [33mTestCase_testScalarMulVec4Float32[0m, time elapsed: 345000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4Float32 (14800 ns)
    TCS: [33mTestCase_testScalarDivVec1Float32[0m, time elapsed: 254900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1Float32 (13800 ns)
    TCS: [33mTestCase_testScalarDivVec2Float32[0m, time elapsed: 243000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2Float32 (11000 ns)
    TCS: [33mTestCase_testScalarDivVec3Float32[0m, time elapsed: 276300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3Float32 (12300 ns)
    TCS: [33mTestCase_testScalarDivVec4Float32[0m, time elapsed: 256200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4Float32 (17200 ns)
    TCS: [33mTestCase_testScalarAddVec1Int32[0m, time elapsed: 382100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec1Int32 (33200 ns)
    TCS: [33mTestCase_testScalarAddVec2Int32[0m, time elapsed: 349300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec2Int32 (14200 ns)
    TCS: [33mTestCase_testScalarAddVec3Int32[0m, time elapsed: 409000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec3Int32 (62400 ns)
    TCS: [33mTestCase_testScalarAddVec4Int32[0m, time elapsed: 313000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec4Int32 (19500 ns)
    TCS: [33mTestCase_testScalarSubVec1Int32[0m, time elapsed: 356700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1Int32 (83900 ns)
    TCS: [33mTestCase_testScalarSubVec2Int32[0m, time elapsed: 273500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2Int32 (13600 ns)
    TCS: [33mTestCase_testScalarSubVec3Int32[0m, time elapsed: 266100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3Int32 (13200 ns)
    TCS: [33mTestCase_testScalarSubVec4Int32[0m, time elapsed: 243600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4Int32 (12600 ns)
    TCS: [33mTestCase_testScalarMulVec1Int32[0m, time elapsed: 243700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1Int32 (12100 ns)
    TCS: [33mTestCase_testScalarMulVec2Int32[0m, time elapsed: 297400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2Int32 (11100 ns)
    TCS: [33mTestCase_testScalarMulVec3Int32[0m, time elapsed: 284900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3Int32 (20400 ns)
    TCS: [33mTestCase_testScalarMulVec4Int32[0m, time elapsed: 314200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4Int32 (12300 ns)
    TCS: [33mTestCase_testScalarDivVec1Int32[0m, time elapsed: 257700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1Int32 (12500 ns)
    TCS: [33mTestCase_testScalarDivVec2Int32[0m, time elapsed: 257800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2Int32 (12800 ns)
    TCS: [33mTestCase_testScalarDivVec3Int32[0m, time elapsed: 303500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3Int32 (13600 ns)
    TCS: [33mTestCase_testScalarDivVec4Int32[0m, time elapsed: 252900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4Int32 (23300 ns)
    TCS: [33mTestCase_testScalarModVec1Int32[0m, time elapsed: 270700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Int32 (11000 ns)
    TCS: [33mTestCase_testScalarModVec2Int32[0m, time elapsed: 298800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Int32 (14600 ns)
    TCS: [33mTestCase_testScalarModVec3Int32[0m, time elapsed: 257400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Int32 (14700 ns)
    TCS: [33mTestCase_testScalarModVec4Int32[0m, time elapsed: 266800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Int32 (15300 ns)
    TCS: [33mTestCase_testScalarSubVec1PackedMediump[0m, time elapsed: 270100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1PackedMediump (14900 ns)
    TCS: [33mTestCase_testScalarSubVec1PackedLowp[0m, time elapsed: 349900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1PackedLowp (23300 ns)
    TCS: [33mTestCase_testScalarSubVec3PackedMediump[0m, time elapsed: 257300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3PackedMediump (15000 ns)
    TCS: [33mTestCase_testScalarSubVec3PackedLowp[0m, time elapsed: 238200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3PackedLowp (15900 ns)
    TCS: [33mTestCase_testScalarSubVec4PackedMediump[0m, time elapsed: 249700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4PackedMediump (16600 ns)
    TCS: [33mTestCase_testScalarSubVec4PackedLowp[0m, time elapsed: 310900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4PackedLowp (12300 ns)
    TCS: [33mTestCase_testScalarMulVec1PackedMediump[0m, time elapsed: 275600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1PackedMediump (11500 ns)
    TCS: [33mTestCase_testScalarMulVec1PackedLowp[0m, time elapsed: 226300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1PackedLowp (10100 ns)
    TCS: [33mTestCase_testScalarMulVec3PackedMediump[0m, time elapsed: 233700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3PackedMediump (11200 ns)
    TCS: [33mTestCase_testScalarMulVec3PackedLowp[0m, time elapsed: 299500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3PackedLowp (15700 ns)
    TCS: [33mTestCase_testScalarMulVec4PackedMediump[0m, time elapsed: 234900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4PackedMediump (11700 ns)
    TCS: [33mTestCase_testScalarMulVec4PackedLowp[0m, time elapsed: 270500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4PackedLowp (17700 ns)
    TCS: [33mTestCase_testScalarDivVec1PackedMediump[0m, time elapsed: 271200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1PackedMediump (10300 ns)
    TCS: [33mTestCase_testScalarDivVec1PackedLowp[0m, time elapsed: 215700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1PackedLowp (9500 ns)
    TCS: [33mTestCase_testScalarDivVec3PackedMediump[0m, time elapsed: 221100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3PackedMediump (10800 ns)
    TCS: [33mTestCase_testScalarDivVec3PackedLowp[0m, time elapsed: 244800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3PackedLowp (11400 ns)
    TCS: [33mTestCase_testScalarDivVec4PackedMediump[0m, time elapsed: 221800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4PackedMediump (10400 ns)
    TCS: [33mTestCase_testScalarDivVec4PackedLowp[0m, time elapsed: 267600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4PackedLowp (15100 ns)
    TCS: [33mTestCase_testScalarModVec1PackedMediump[0m, time elapsed: 224200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1PackedMediump (12000 ns)
    TCS: [33mTestCase_testScalarModVec1PackedLowp[0m, time elapsed: 212600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1PackedLowp (10500 ns)
    TCS: [33mTestCase_testScalarModVec3PackedMediump[0m, time elapsed: 287900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3PackedMediump (11500 ns)
    TCS: [33mTestCase_testScalarModVec3PackedLowp[0m, time elapsed: 282100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3PackedLowp (11200 ns)
    TCS: [33mTestCase_testScalarModVec4PackedMediump[0m, time elapsed: 248100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4PackedMediump (17000 ns)
    TCS: [33mTestCase_testScalarModVec4PackedLowp[0m, time elapsed: 311700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4PackedLowp (12300 ns)
    TCS: [33mTestCase_testScalarDivZeroVec1[0m, time elapsed: 303300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivZeroVec1 (37900 ns)
    TCS: [33mTestCase_testScalarAddNegVec1[0m, time elapsed: 432900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddNegVec1 (31800 ns)
    TCS: [33mTestCase_testScalarAddNegVec2[0m, time elapsed: 253300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddNegVec2 (14300 ns)
    TCS: [33mTestCase_testScalarMulOverflowVec1[0m, time elapsed: 282300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulOverflowVec1 (9300 ns)
    TCS: [33mTestCase_testScalarSubNegVec1[0m, time elapsed: 222700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubNegVec1 (14500 ns)
    TCS: [33mTestCase_testVersionMajor[0m, time elapsed: 224400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionMajor (11600 ns)
    TCS: [33mTestCase_testVersionMinor[0m, time elapsed: 272200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionMinor (9400 ns)
    TCS: [33mTestCase_testVersionPatch[0m, time elapsed: 224300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionPatch (10000 ns)
    TCS: [33mTestCase_testVersionEncoded[0m, time elapsed: 221800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionEncoded (11200 ns)
    TCS: [33mTestCase_testConfigSimd[0m, time elapsed: 259000 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigSimd (44600 ns)
    TCS: [33mTestCase_testConfigAlignedGentypes[0m, time elapsed: 218100 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigAlignedGentypes (9800 ns)
    TCS: [33mTestCase_testConfigClipControl[0m, time elapsed: 229500 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigClipControl (8800 ns)
    TCS: [33mTestCase_testConstNegationSimd[0m, time elapsed: 1053100 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationSimd (32600 ns)
    TCS: [33mTestCase_testConstNegationAligned[0m, time elapsed: 334800 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationAligned (17900 ns)
    TCS: [33mTestCase_testConstNegationClip[0m, time elapsed: 541800 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationClip (18900 ns)
    TCS: [33mTestCase_testConstInt64Usage[0m, time elapsed: 366400 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstInt64Usage (25900 ns)
    TCS: [33mTestCase_testConstBoolUsage[0m, time elapsed: 427100 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstBoolUsage (18000 ns)
    TCS: [33mTestCase_testVersionEncodingConsistency[0m, time elapsed: 354300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionEncodingConsistency (16300 ns)
    TCS: [33mTestCase_testAssertPasses[0m, time elapsed: 277400 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertPasses (35100 ns)
    TCS: [33mTestCase_testAssertFails[0m, time elapsed: 344200 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertFails (86900 ns)
    TCS: [33mTestCase_testAssertWithCustomMessage[0m, time elapsed: 407900 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertWithCustomMessage (77600 ns)
    TCS: [33mTestCase_testNumericLimitsFloat32Epsilon[0m, time elapsed: 276200 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsFloat32Epsilon (17100 ns)
    TCS: [33mTestCase_testNumericLimitsFloat64Epsilon[0m, time elapsed: 336500 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsFloat64Epsilon (16400 ns)
    TCS: [33mTestCase_testIsIec559OfFloat32[0m, time elapsed: 259100 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfFloat32 (13000 ns)
    TCS: [33mTestCase_testIsIec559OfFloat64[0m, time elapsed: 235500 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfFloat64 (9400 ns)
    TCS: [33mTestCase_testIsIec559OfInt64[0m, time elapsed: 255700 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfInt64 (17900 ns)
    TCS: [33mTestCase_testEpsilonOfFloat32[0m, time elapsed: 268200 ns, RESULT:
    [[32m PASSED [0m] CASE: testEpsilonOfFloat32 (17500 ns)
    TCS: [33mTestCase_testEpsilonOfFloat64[0m, time elapsed: 272200 ns, RESULT:
    [[32m PASSED [0m] CASE: testEpsilonOfFloat64 (14400 ns)
    TCS: [33mTestCase_testNumericLimitsInt64Epsilon[0m, time elapsed: 233700 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt64Epsilon (13800 ns)
    TCS: [33mTestCase_testNumericLimitsInt32Epsilon[0m, time elapsed: 282300 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt32Epsilon (13700 ns)
    TCS: [33mTestCase_testNumericLimitsInt16Epsilon[0m, time elapsed: 305400 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt16Epsilon (17800 ns)
    TCS: [33mTestCase_testNumericLimitsInt8Epsilon[0m, time elapsed: 397600 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt8Epsilon (41600 ns)
    TCS: [33mTestCase_testCastVec1ToVec1IntToFloat[0m, time elapsed: 387600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec1ToVec1IntToFloat (38200 ns)
    TCS: [33mTestCase_testCastVec2ToVec1TakesOnlyX[0m, time elapsed: 430300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2ToVec1TakesOnlyX (35500 ns)
    TCS: [33mTestCase_testCastVec3ToVec1TakesOnlyX[0m, time elapsed: 421300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3ToVec1TakesOnlyX (38700 ns)
    TCS: [33mTestCase_testCastVec4ToVec1TakesOnlyX[0m, time elapsed: 435400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4ToVec1TakesOnlyX (42000 ns)
    TCS: [33mTestCase_testCastSameTypeIdentity[0m, time elapsed: 370300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastSameTypeIdentity (30700 ns)
    TCS: [33mTestCase_testCastInt32ToInt64[0m, time elapsed: 462800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastInt32ToInt64 (40000 ns)
    TCS: [33mTestCase_testCastFloatToIntTruncation[0m, time elapsed: 323900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastFloatToIntTruncation (18700 ns)
    TCS: [33mTestCase_testCastCrossQualifierPackedHighpToDefaultp[0m, time elapsed: 258000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastCrossQualifierPackedHighpToDefaultp (10100 ns)
    TCS: [33mTestCase_testCastCrossQualifierDefaultpToPackedHighp[0m, time elapsed: 536400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastCrossQualifierDefaultpToPackedHighp (29400 ns)
    TCS: [33mTestCase_testCastVec2CrossQualifierCrossType[0m, time elapsed: 571200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2CrossQualifierCrossType (89900 ns)
    TCS: [33mTestCase_testCastVec3CrossQualifier[0m, time elapsed: 424400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3CrossQualifier (24300 ns)
    TCS: [33mTestCase_testCastVec4CrossQualifier[0m, time elapsed: 329600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4CrossQualifier (16500 ns)
    TCS: [33mTestCase_testCastVec1DoesNotModifySource[0m, time elapsed: 323800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec1DoesNotModifySource (14900 ns)
    TCS: [33mTestCase_testCastVec2Vec1ToVec2IntToFloat[0m, time elapsed: 291700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec1ToVec2IntToFloat (14700 ns)
    TCS: [33mTestCase_testCastVec2Vec2ToVec2Identity[0m, time elapsed: 226000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec2ToVec2Identity (18800 ns)
    TCS: [33mTestCase_testCastVec2Vec3ToVec2TakesOnlyXY[0m, time elapsed: 200800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec3ToVec2TakesOnlyXY (8300 ns)
    TCS: [33mTestCase_testCastVec2Vec4ToVec2TakesOnlyXY[0m, time elapsed: 380200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec4ToVec2TakesOnlyXY (16500 ns)
    TCS: [33mTestCase_testCastVec2SameTypeIdentity[0m, time elapsed: 339500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2SameTypeIdentity (15600 ns)
    TCS: [33mTestCase_testCastVec2Int32ToInt64[0m, time elapsed: 385700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Int32ToInt64 (16000 ns)
    TCS: [33mTestCase_testCastVec2FloatToIntTruncation[0m, time elapsed: 424600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2FloatToIntTruncation (73200 ns)
    TCS: [33mTestCase_testCastVec2CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 247800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2CrossQualifierPackedHighpToDefaultp (10000 ns)
    TCS: [33mTestCase_testCastVec2DoesNotModifySource[0m, time elapsed: 225700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2DoesNotModifySource (8700 ns)
    TCS: [33mTestCase_testCastVec2Vec1ToVec2SameValueBothComponents[0m, time elapsed: 248600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec1ToVec2SameValueBothComponents (11800 ns)
    TCS: [33mTestCase_testCastVec3Vec1ToVec3IntToFloat[0m, time elapsed: 255100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec1ToVec3IntToFloat (21300 ns)
    TCS: [33mTestCase_testCastVec3Vec2ToVec3ExtendY[0m, time elapsed: 275300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec2ToVec3ExtendY (12500 ns)
    TCS: [33mTestCase_testCastVec3Vec3ToVec3Identity[0m, time elapsed: 252300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec3ToVec3Identity (13100 ns)
    TCS: [33mTestCase_testCastVec3Vec4ToVec3TakesOnlyXYZ[0m, time elapsed: 223300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec4ToVec3TakesOnlyXYZ (11800 ns)
    TCS: [33mTestCase_testCastVec3SameTypeIdentity[0m, time elapsed: 278800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3SameTypeIdentity (9000 ns)
    TCS: [33mTestCase_testCastVec3Int32ToInt64[0m, time elapsed: 235000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Int32ToInt64 (9100 ns)
    TCS: [33mTestCase_testCastVec3FloatToIntTruncation[0m, time elapsed: 220300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3FloatToIntTruncation (11400 ns)
    TCS: [33mTestCase_testCastVec3CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 282400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3CrossQualifierPackedHighpToDefaultp (8000 ns)
    TCS: [33mTestCase_testCastVec3DoesNotModifySource[0m, time elapsed: 215900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3DoesNotModifySource (7600 ns)
    TCS: [33mTestCase_testCastVec3Vec1ToVec3SameValueAllComponents[0m, time elapsed: 219800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec1ToVec3SameValueAllComponents (7800 ns)
    TCS: [33mTestCase_testCastVec4Vec1ToVec4IntToFloat[0m, time elapsed: 234100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec1ToVec4IntToFloat (11900 ns)
    TCS: [33mTestCase_testCastVec4Vec2ToVec4ExtendY[0m, time elapsed: 238200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec2ToVec4ExtendY (21700 ns)
    TCS: [33mTestCase_testCastVec4Vec3ToVec4ExtendZ[0m, time elapsed: 232000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec3ToVec4ExtendZ (10900 ns)
    TCS: [33mTestCase_testCastVec4Vec4ToVec4Identity[0m, time elapsed: 242000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec4ToVec4Identity (13100 ns)
    TCS: [33mTestCase_testCastVec4SameTypeIdentity[0m, time elapsed: 232800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4SameTypeIdentity (9900 ns)
    TCS: [33mTestCase_testCastVec4Int32ToInt64[0m, time elapsed: 341800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Int32ToInt64 (9900 ns)
    TCS: [33mTestCase_testCastVec4FloatToIntTruncation[0m, time elapsed: 257800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4FloatToIntTruncation (11200 ns)
    TCS: [33mTestCase_testCastVec4CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 329900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4CrossQualifierPackedHighpToDefaultp (15600 ns)
    TCS: [33mTestCase_testCastVec4DoesNotModifySource[0m, time elapsed: 274000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4DoesNotModifySource (10900 ns)
    TCS: [33mTestCase_testCastVec4Vec1ToVec4SameValueAllComponents[0m, time elapsed: 238800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec1ToVec4SameValueAllComponents (10000 ns)
    TCS: [33mTestCase_testFromBoolVec1[0m, time elapsed: 649600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec1 (25400 ns)
    TCS: [33mTestCase_testFromBoolVec1False[0m, time elapsed: 765800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec1False (17800 ns)
    TCS: [33mTestCase_testFromBoolVec2[0m, time elapsed: 331400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec2 (19100 ns)
    TCS: [33mTestCase_testFromBoolVec3[0m, time elapsed: 229000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec3 (8400 ns)
    TCS: [33mTestCase_testFromBoolVec4[0m, time elapsed: 207200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec4 (7700 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec1[0m, time elapsed: 446900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec1 (9000 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec2[0m, time elapsed: 279300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec2 (14500 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec3[0m, time elapsed: 222500 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec3 (25300 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec4[0m, time elapsed: 205900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec4 (8000 ns)
    TCS: [33mTestCase_testFromBoolVec3AllFalse[0m, time elapsed: 249700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec3AllFalse (7400 ns)
    TCS: [33mTestCase_testFromBoolVec4AllFalse[0m, time elapsed: 452700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec4AllFalse (20000 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec3AllFalse[0m, time elapsed: 469900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec3AllFalse (77100 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec4AllFalse[0m, time elapsed: 315900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec4AllFalse (8900 ns)
    TCS: [33mTestCase_testFromBoolVecFloat32[0m, time elapsed: 357400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecFloat32 (23100 ns)
    TCS: [33mTestCase_testFromBoolVecFloat64[0m, time elapsed: 265300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecFloat64 (10500 ns)
    TCS: [33mTestCase_testFromBoolVecInt32[0m, time elapsed: 237000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecInt32 (11200 ns)
    TCS: [33mTestCase_testFromBoolVecQ2PackedMediump[0m, time elapsed: 219400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2PackedMediump (9500 ns)
    TCS: [33mTestCase_testFromBoolVecQ2PackedLowp[0m, time elapsed: 202400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2PackedLowp (6500 ns)
    TCS: [33mTestCase_testVec1ConstInit[0m, time elapsed: 277600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ConstInit (18200 ns)
    TCS: [33mTestCase_testVec1Length[0m, time elapsed: 215900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Length (7400 ns)
    TCS: [33mTestCase_testVec1IndexAccess[0m, time elapsed: 226000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1IndexAccess (10500 ns)
    TCS: [33mTestCase_testVec1IndexMutate[0m, time elapsed: 194500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1IndexMutate (6400 ns)
    TCS: [33mTestCase_testVec1ComponentAt[0m, time elapsed: 231100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ComponentAt (18800 ns)
    TCS: [33mTestCase_testVec1Add[0m, time elapsed: 773200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Add (45000 ns)
    TCS: [33mTestCase_testVec1Sub[0m, time elapsed: 435600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Sub (28300 ns)
    TCS: [33mTestCase_testVec1Mul[0m, time elapsed: 371900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Mul (17800 ns)
    TCS: [33mTestCase_testVec1Div[0m, time elapsed: 292600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Div (11100 ns)
    TCS: [33mTestCase_testVec1Mod[0m, time elapsed: 225700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Mod (11400 ns)
    TCS: [33mTestCase_testVec1ScalarAdd[0m, time elapsed: 258500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarAdd (11800 ns)
    TCS: [33mTestCase_testVec1Negate[0m, time elapsed: 214700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Negate (6900 ns)
    TCS: [33mTestCase_testVec1AddNamed[0m, time elapsed: 203900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1AddNamed (10200 ns)
    TCS: [33mTestCase_testVec1SubNamed[0m, time elapsed: 226700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1SubNamed (13200 ns)
    TCS: [33mTestCase_testVec1MulNamed[0m, time elapsed: 208600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1MulNamed (7400 ns)
    TCS: [33mTestCase_testVec1Equal[0m, time elapsed: 260500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Equal (28300 ns)
    TCS: [33mTestCase_testVec1NotEqual[0m, time elapsed: 242900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1NotEqual (8100 ns)
    TCS: [33mTestCase_testVec1EqualExact[0m, time elapsed: 213600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1EqualExact (12800 ns)
    TCS: [33mTestCase_testVec1BitwiseAnd[0m, time elapsed: 212700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BitwiseAnd (14300 ns)
    TCS: [33mTestCase_testVec1BitwiseOr[0m, time elapsed: 401100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BitwiseOr (21700 ns)
    TCS: [33mTestCase_testVec1BitwiseXor[0m, time elapsed: 421400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BitwiseXor (12400 ns)
    TCS: [33mTestCase_testVec1ShiftLeft[0m, time elapsed: 773100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ShiftLeft (38800 ns)
    TCS: [33mTestCase_testVec1ShiftRight[0m, time elapsed: 596700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ShiftRight (41900 ns)
    TCS: [33mTestCase_testVec1BitwiseNot[0m, time elapsed: 298900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BitwiseNot (10800 ns)
    TCS: [33mTestCase_testVec1BoolLogicalAnd[0m, time elapsed: 263600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BoolLogicalAnd (20500 ns)
    TCS: [33mTestCase_testVec1BoolLogicalOr[0m, time elapsed: 255800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BoolLogicalOr (8700 ns)
    TCS: [33mTestCase_testVec1IndexOutOfBoundsAccess[0m, time elapsed: 346500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1IndexOutOfBoundsAccess (73000 ns)
    TCS: [33mTestCase_testVec1ShiftVec[0m, time elapsed: 233200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ShiftVec (10800 ns)
    TCS: [33mTestCase_testVec1ScalarSub[0m, time elapsed: 226300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarSub (13800 ns)
    TCS: [33mTestCase_testVec1ScalarMul[0m, time elapsed: 298700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarMul (8900 ns)
    TCS: [33mTestCase_testVec1ScalarDiv[0m, time elapsed: 288100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarDiv (7300 ns)
    TCS: [33mTestCase_testVec1ScalarMod[0m, time elapsed: 225700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarMod (8400 ns)
    TCS: [33mTestCase_testVec1DivNamed[0m, time elapsed: 236800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1DivNamed (9500 ns)
    TCS: [33mTestCase_testVec1ModNamed[0m, time elapsed: 238300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ModNamed (12800 ns)
    TCS: [33mTestCase_testVec1ScalarBitwiseAnd[0m, time elapsed: 304200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarBitwiseAnd (20900 ns)
    TCS: [33mTestCase_testVec1ScalarBitwiseOr[0m, time elapsed: 279100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarBitwiseOr (22100 ns)
    TCS: [33mTestCase_testVec1ScalarBitwiseXor[0m, time elapsed: 289100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarBitwiseXor (12700 ns)
    TCS: [33mTestCase_testVec1ShiftRightVec[0m, time elapsed: 322300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ShiftRightVec (15200 ns)
    TCS: [33mTestCase_testVec1EqualEpsilon[0m, time elapsed: 232900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1EqualEpsilon (16600 ns)
    TCS: [33mTestCase_testVec1BroadcastAddVec2[0m, time elapsed: 235200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastAddVec2 (26200 ns)
    TCS: [33mTestCase_testVec1BroadcastBitAndVec2[0m, time elapsed: 373700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastBitAndVec2 (19100 ns)
    TCS: [33mTestCase_testVec1BroadcastAddVec3[0m, time elapsed: 272500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastAddVec3 (13600 ns)
    TCS: [33mTestCase_testVec1BroadcastAddVec4[0m, time elapsed: 311600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastAddVec4 (21500 ns)
    TCS: [33mTestCase_testVec1BroadcastBitOrVec2[0m, time elapsed: 224700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastBitOrVec2 (7800 ns)
    TCS: [33mTestCase_testVec1BroadcastBitXorVec2[0m, time elapsed: 254900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastBitXorVec2 (17700 ns)
    TCS: [33mTestCase_testVec1BroadcastShiftLeftVec2[0m, time elapsed: 241600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastShiftLeftVec2 (17800 ns)
    TCS: [33mTestCase_testVec1BroadcastShiftRightVec2[0m, time elapsed: 230800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastShiftRightVec2 (11100 ns)
    TCS: [33mTestCase_testVec1BroadcastBitAndVec3[0m, time elapsed: 264400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastBitAndVec3 (10800 ns)
    TCS: [33mTestCase_testVec1BroadcastBitAndVec4[0m, time elapsed: 222500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastBitAndVec4 (18900 ns)
    TCS: [33mTestCase_testVec1BroadcastModVec2[0m, time elapsed: 216100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastModVec2 (9600 ns)
    TCS: [33mTestCase_testVec1BroadcastModVec3[0m, time elapsed: 249300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastModVec3 (13100 ns)
    TCS: [33mTestCase_testVec1BroadcastModVec4[0m, time elapsed: 221300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastModVec4 (13300 ns)
    TCS: [33mTestCase_testVec1Increment[0m, time elapsed: 204700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Increment (9900 ns)
    TCS: [33mTestCase_testVec1Decrement[0m, time elapsed: 229300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Decrement (6600 ns)
    TCS: [33mTestCase_testVec2ScalarInit[0m, time elapsed: 243500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarInit (14000 ns)
    TCS: [33mTestCase_testVec2ConstInit[0m, time elapsed: 1267500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ConstInit (116500 ns)
    TCS: [33mTestCase_testVec2Length[0m, time elapsed: 354700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Length (13500 ns)
    TCS: [33mTestCase_testVec2Add[0m, time elapsed: 290000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Add (54700 ns)
    TCS: [33mTestCase_testVec2Sub[0m, time elapsed: 237200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Sub (16800 ns)
    TCS: [33mTestCase_testVec2Mul[0m, time elapsed: 215500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Mul (14400 ns)
    TCS: [33mTestCase_testVec2ScalarAdd[0m, time elapsed: 226000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarAdd (15700 ns)
    TCS: [33mTestCase_testVec2Negate[0m, time elapsed: 210000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Negate (16800 ns)
    TCS: [33mTestCase_testVec2IndexAccess[0m, time elapsed: 200300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2IndexAccess (7700 ns)
    TCS: [33mTestCase_testVec2IndexMutate[0m, time elapsed: 312300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2IndexMutate (18000 ns)
    TCS: [33mTestCase_testVec2ComponentAt[0m, time elapsed: 266000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ComponentAt (17800 ns)
    TCS: [33mTestCase_testVec2Equal[0m, time elapsed: 528100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Equal (35900 ns)
    TCS: [33mTestCase_testVec2NotEqual[0m, time elapsed: 277000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2NotEqual (28400 ns)
    TCS: [33mTestCase_testVec2EqualExact[0m, time elapsed: 215400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2EqualExact (14400 ns)
    TCS: [33mTestCase_testVec2BitwiseAnd[0m, time elapsed: 211400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseAnd (14000 ns)
    TCS: [33mTestCase_testVec2BitwiseNot[0m, time elapsed: 248700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseNot (7800 ns)
    TCS: [33mTestCase_testVec2FromVec1[0m, time elapsed: 216800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2FromVec1 (8100 ns)
    TCS: [33mTestCase_testVec2ShiftLeft[0m, time elapsed: 206800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeft (16200 ns)
    TCS: [33mTestCase_testVec2BoolLogicalAnd[0m, time elapsed: 278100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BoolLogicalAnd (41300 ns)
    TCS: [33mTestCase_testVec2Vec1ArithBroadcast[0m, time elapsed: 315700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Vec1ArithBroadcast (19500 ns)
    TCS: [33mTestCase_testVec2Vec1BitBroadcast[0m, time elapsed: 363700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Vec1BitBroadcast (22600 ns)
    TCS: [33mTestCase_testVec2ShiftLeftVec1[0m, time elapsed: 257300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeftVec1 (19400 ns)
    TCS: [33mTestCase_testVec2Div[0m, time elapsed: 289300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Div (18700 ns)
    TCS: [33mTestCase_testVec2Mod[0m, time elapsed: 326100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Mod (23600 ns)
    TCS: [33mTestCase_testVec2ScalarSub[0m, time elapsed: 246500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarSub (20800 ns)
    TCS: [33mTestCase_testVec2ScalarMul[0m, time elapsed: 224800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarMul (11400 ns)
    TCS: [33mTestCase_testVec2ScalarDiv[0m, time elapsed: 258500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarDiv (18600 ns)
    TCS: [33mTestCase_testVec2ScalarMod[0m, time elapsed: 262700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarMod (10200 ns)
    TCS: [33mTestCase_testVec2BoolLogicalOr[0m, time elapsed: 269100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BoolLogicalOr (10800 ns)
    TCS: [33mTestCase_testVec2EqualEpsilon[0m, time elapsed: 259600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2EqualEpsilon (29900 ns)
    TCS: [33mTestCase_testVec2DivNamed[0m, time elapsed: 222800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2DivNamed (10400 ns)
    TCS: [33mTestCase_testVec2ModNamed[0m, time elapsed: 248900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ModNamed (8400 ns)
    TCS: [33mTestCase_testVec2BitwiseOr[0m, time elapsed: 228700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseOr (19500 ns)
    TCS: [33mTestCase_testVec2BitwiseXor[0m, time elapsed: 210600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseXor (12600 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseAnd[0m, time elapsed: 241800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseAnd (12100 ns)
    TCS: [33mTestCase_testVec2ShiftRight[0m, time elapsed: 211900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRight (15400 ns)
    TCS: [33mTestCase_testVec2ShiftRightVec1[0m, time elapsed: 210400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRightVec1 (11800 ns)
    TCS: [33mTestCase_testVec2AddNamed[0m, time elapsed: 240200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2AddNamed (6800 ns)
    TCS: [33mTestCase_testVec2SubNamed[0m, time elapsed: 221700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2SubNamed (7500 ns)
    TCS: [33mTestCase_testVec2MulNamed[0m, time elapsed: 205900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2MulNamed (6100 ns)
    TCS: [33mTestCase_testVec2ShiftLeftVec[0m, time elapsed: 239900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeftVec (9800 ns)
    TCS: [33mTestCase_testVec2ShiftRightVec[0m, time elapsed: 202100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRightVec (6900 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseOr[0m, time elapsed: 1014100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseOr (39900 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseXor[0m, time elapsed: 447000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseXor (42000 ns)
    TCS: [33mTestCase_testVec2Increment[0m, time elapsed: 799000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Increment (55700 ns)
    TCS: [33mTestCase_testVec2Decrement[0m, time elapsed: 396300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Decrement (36100 ns)
    TCS: [33mTestCase_testVec2IndexOutOfBoundsAccess[0m, time elapsed: 381600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2IndexOutOfBoundsAccess (69300 ns)
    TCS: [33mTestCase_testVec2NegativeIndexAccess[0m, time elapsed: 277300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2NegativeIndexAccess (43500 ns)
    TCS: [33mTestCase_testVec3ScalarInit[0m, time elapsed: 229200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarInit (15200 ns)
    TCS: [33mTestCase_testVec3ConstInit[0m, time elapsed: 305400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ConstInit (12100 ns)
    TCS: [33mTestCase_testVec3Length[0m, time elapsed: 319600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Length (12800 ns)
    TCS: [33mTestCase_testVec3Add[0m, time elapsed: 402700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Add (42400 ns)
    TCS: [33mTestCase_testVec3ScalarMul[0m, time elapsed: 418500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarMul (27900 ns)
    TCS: [33mTestCase_testVec3Negate[0m, time elapsed: 357400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Negate (23500 ns)
    TCS: [33mTestCase_testVec3IndexAccess[0m, time elapsed: 345500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3IndexAccess (16200 ns)
    TCS: [33mTestCase_testVec3IndexMutate[0m, time elapsed: 359100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3IndexMutate (12400 ns)
    TCS: [33mTestCase_testVec3ComponentAt[0m, time elapsed: 457400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ComponentAt (12900 ns)
    TCS: [33mTestCase_testVec3Equal[0m, time elapsed: 445600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Equal (41500 ns)
    TCS: [33mTestCase_testVec3NotEqual[0m, time elapsed: 561800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3NotEqual (53100 ns)
    TCS: [33mTestCase_testVec3EqualExact[0m, time elapsed: 473300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3EqualExact (28900 ns)
    TCS: [33mTestCase_testVec3BitwiseAnd[0m, time elapsed: 361300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseAnd (25800 ns)
    TCS: [33mTestCase_testVec3BitwiseNot[0m, time elapsed: 421700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseNot (16600 ns)
    TCS: [33mTestCase_testVec3Vec1ArithBroadcast[0m, time elapsed: 446600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1ArithBroadcast (38100 ns)
    TCS: [33mTestCase_testVec3ShiftLeft[0m, time elapsed: 393100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeft (28000 ns)
    TCS: [33mTestCase_testVec3BoolLogicalAnd[0m, time elapsed: 426600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BoolLogicalAnd (82700 ns)
    TCS: [33mTestCase_testVec3Sub[0m, time elapsed: 363500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Sub (26700 ns)
    TCS: [33mTestCase_testVec3Div[0m, time elapsed: 388300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Div (25900 ns)
    TCS: [33mTestCase_testVec3Mod[0m, time elapsed: 316200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Mod (20900 ns)
    TCS: [33mTestCase_testVec3ScalarSub[0m, time elapsed: 370300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarSub (30000 ns)
    TCS: [33mTestCase_testVec3ScalarDiv[0m, time elapsed: 707100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarDiv (48500 ns)
    TCS: [33mTestCase_testVec3ScalarMod[0m, time elapsed: 500600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarMod (35400 ns)
    TCS: [33mTestCase_testVec3BoolLogicalOr[0m, time elapsed: 359400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BoolLogicalOr (14100 ns)
    TCS: [33mTestCase_testVec3EqualEpsilon[0m, time elapsed: 240300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3EqualEpsilon (29200 ns)
    TCS: [33mTestCase_testVec3AddNamed[0m, time elapsed: 246600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3AddNamed (22300 ns)
    TCS: [33mTestCase_testVec3MulNamed[0m, time elapsed: 199400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3MulNamed (7800 ns)
    TCS: [33mTestCase_testVec3DivNamed[0m, time elapsed: 194200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3DivNamed (7400 ns)
    TCS: [33mTestCase_testVec3ModNamed[0m, time elapsed: 291700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ModNamed (9900 ns)
    TCS: [33mTestCase_testVec3BitwiseOr[0m, time elapsed: 461300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseOr (32400 ns)
    TCS: [33mTestCase_testVec3BitwiseXor[0m, time elapsed: 328200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseXor (23500 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseAnd[0m, time elapsed: 258100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseAnd (18300 ns)
    TCS: [33mTestCase_testVec3ShiftRight[0m, time elapsed: 265700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRight (18700 ns)
    TCS: [33mTestCase_testVec3Vec1BitBroadcast[0m, time elapsed: 214500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitBroadcast (15600 ns)
    TCS: [33mTestCase_testVec3ShiftRightVec1[0m, time elapsed: 245500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRightVec1 (39700 ns)
    TCS: [33mTestCase_testVec3FromVec1[0m, time elapsed: 202000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3FromVec1 (6800 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseOr[0m, time elapsed: 207300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseOr (16600 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseXor[0m, time elapsed: 260700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseXor (13600 ns)
    TCS: [33mTestCase_testVec3Vec1BitOrBroadcast[0m, time elapsed: 221900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitOrBroadcast (15800 ns)
    TCS: [33mTestCase_testVec3Vec1BitXorBroadcast[0m, time elapsed: 222300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitXorBroadcast (12500 ns)
    TCS: [33mTestCase_testVec3ShiftLeftVec1[0m, time elapsed: 247000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeftVec1 (14800 ns)
    TCS: [33mTestCase_testVec3ShiftLeftVec[0m, time elapsed: 203900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeftVec (7400 ns)
    TCS: [33mTestCase_testVec3ShiftRightVec[0m, time elapsed: 216700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRightVec (13000 ns)
    TCS: [33mTestCase_testVec3Increment[0m, time elapsed: 453400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Increment (33400 ns)
    TCS: [33mTestCase_testVec3Decrement[0m, time elapsed: 380800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Decrement (35300 ns)
    TCS: [33mTestCase_testVec3IndexOutOfBoundsAccess[0m, time elapsed: 469500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3IndexOutOfBoundsAccess (53900 ns)
    TCS: [33mTestCase_testVec3NegativeIndexAccess[0m, time elapsed: 302500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3NegativeIndexAccess (37200 ns)
    TCS: [33mTestCase_testVec4ScalarInit[0m, time elapsed: 252200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarInit (16200 ns)
    TCS: [33mTestCase_testVec4ConstInit[0m, time elapsed: 231100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ConstInit (10100 ns)
    TCS: [33mTestCase_testVec4Length[0m, time elapsed: 205800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Length (6100 ns)
    TCS: [33mTestCase_testVec4Add[0m, time elapsed: 251500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Add (25700 ns)
    TCS: [33mTestCase_testVec4ScalarMul[0m, time elapsed: 283000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarMul (15000 ns)
    TCS: [33mTestCase_testVec4Negate[0m, time elapsed: 283000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Negate (19100 ns)
    TCS: [33mTestCase_testVec4IndexAccess[0m, time elapsed: 215300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4IndexAccess (11200 ns)
    TCS: [33mTestCase_testVec4IndexMutate[0m, time elapsed: 201800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4IndexMutate (6200 ns)
    TCS: [33mTestCase_testVec4ComponentAt[0m, time elapsed: 195600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ComponentAt (7000 ns)
    TCS: [33mTestCase_testVec4Equal[0m, time elapsed: 219100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Equal (18800 ns)
    TCS: [33mTestCase_testVec4NotEqual[0m, time elapsed: 830000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4NotEqual (72700 ns)
    TCS: [33mTestCase_testVec4EqualExact[0m, time elapsed: 362200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4EqualExact (37600 ns)
    TCS: [33mTestCase_testVec4BitwiseAnd[0m, time elapsed: 364900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseAnd (33300 ns)
    TCS: [33mTestCase_testVec4BitwiseNot[0m, time elapsed: 261500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseNot (11000 ns)
    TCS: [33mTestCase_testVec4Vec1ArithBroadcast[0m, time elapsed: 477200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1ArithBroadcast (35300 ns)
    TCS: [33mTestCase_testVec4ShiftLeft[0m, time elapsed: 475600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeft (40300 ns)
    TCS: [33mTestCase_testVec4BoolLogicalAnd[0m, time elapsed: 376600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BoolLogicalAnd (26600 ns)
    TCS: [33mTestCase_testVec4Sub[0m, time elapsed: 396000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Sub (62700 ns)
    TCS: [33mTestCase_testVec4Div[0m, time elapsed: 332600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Div (28400 ns)
    TCS: [33mTestCase_testVec4Mod[0m, time elapsed: 246400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Mod (19500 ns)
    TCS: [33mTestCase_testVec4ScalarSub[0m, time elapsed: 231100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarSub (18400 ns)
    TCS: [33mTestCase_testVec4ScalarDiv[0m, time elapsed: 246900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarDiv (16400 ns)
    TCS: [33mTestCase_testVec4ScalarMod[0m, time elapsed: 221600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarMod (20000 ns)
    TCS: [33mTestCase_testVec4BoolLogicalOr[0m, time elapsed: 225500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BoolLogicalOr (9900 ns)
    TCS: [33mTestCase_testVec4EqualEpsilon[0m, time elapsed: 291500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4EqualEpsilon (23300 ns)
    TCS: [33mTestCase_testVec4AddNamed[0m, time elapsed: 265100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4AddNamed (23500 ns)
    TCS: [33mTestCase_testVec4MulNamed[0m, time elapsed: 283800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4MulNamed (7800 ns)
    TCS: [33mTestCase_testVec4DivNamed[0m, time elapsed: 227400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4DivNamed (7500 ns)
    TCS: [33mTestCase_testVec4ModNamed[0m, time elapsed: 240900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ModNamed (8800 ns)
    TCS: [33mTestCase_testVec4BitwiseOr[0m, time elapsed: 306300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseOr (23300 ns)
    TCS: [33mTestCase_testVec4BitwiseXor[0m, time elapsed: 256500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseXor (23100 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseAnd[0m, time elapsed: 267300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseAnd (17000 ns)
    TCS: [33mTestCase_testVec4ShiftRight[0m, time elapsed: 263100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRight (19200 ns)
    TCS: [33mTestCase_testVec4Vec1BitBroadcast[0m, time elapsed: 230800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitBroadcast (17800 ns)
    TCS: [33mTestCase_testVec4ShiftRightVec1[0m, time elapsed: 298200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRightVec1 (18300 ns)
    TCS: [33mTestCase_testVec4FromVec1[0m, time elapsed: 233600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4FromVec1 (9500 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseOr[0m, time elapsed: 261200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseOr (18100 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseXor[0m, time elapsed: 305600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseXor (21000 ns)
    TCS: [33mTestCase_testVec4Vec1BitOrBroadcast[0m, time elapsed: 227500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitOrBroadcast (19600 ns)
    TCS: [33mTestCase_testVec4Vec1BitXorBroadcast[0m, time elapsed: 246500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitXorBroadcast (17700 ns)
    TCS: [33mTestCase_testVec4ShiftLeftVec1[0m, time elapsed: 288500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeftVec1 (17300 ns)
    TCS: [33mTestCase_testVec4ShiftLeftVec[0m, time elapsed: 263200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeftVec (15000 ns)
    TCS: [33mTestCase_testVec4ShiftRightVec[0m, time elapsed: 278700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRightVec (42800 ns)
    TCS: [33mTestCase_testVec4Increment[0m, time elapsed: 250600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Increment (29000 ns)
    TCS: [33mTestCase_testVec4Decrement[0m, time elapsed: 248100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Decrement (20400 ns)
    TCS: [33mTestCase_testVec4IndexOutOfBoundsAccess[0m, time elapsed: 297900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4IndexOutOfBoundsAccess (41900 ns)
    TCS: [33mTestCase_testVec4NegativeIndexAccess[0m, time elapsed: 244100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4NegativeIndexAccess (23100 ns)
    TCS: [33mTestCase_testFunctor1Vec1Identity[0m, time elapsed: 300900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec1Identity (11400 ns)
    TCS: [33mTestCase_testFunctor1Vec1Transform[0m, time elapsed: 294200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec1Transform (13800 ns)
    TCS: [33mTestCase_testFunctor1Vec2Transform[0m, time elapsed: 264600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec2Transform (22100 ns)
    TCS: [33mTestCase_testFunctor2Vec1Add[0m, time elapsed: 305200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec1Add (13000 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec1Mul[0m, time elapsed: 251100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec1Mul (24700 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec1Shift[0m, time elapsed: 284500 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec1Shift (19900 ns)
    TCS: [33mTestCase_testFunctor1Vec3Transform[0m, time elapsed: 237700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec3Transform (10900 ns)
    TCS: [33mTestCase_testFunctor1Vec4Transform[0m, time elapsed: 353400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec4Transform (29600 ns)
    TCS: [33mTestCase_testFunctor2Vec2Add[0m, time elapsed: 339900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec2Add (14800 ns)
    TCS: [33mTestCase_testFunctor2Vec3Add[0m, time elapsed: 250300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec3Add (14600 ns)
    TCS: [33mTestCase_testFunctor2Vec4Add[0m, time elapsed: 312800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec4Add (21900 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec2Mul[0m, time elapsed: 282400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec2Mul (15400 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec3Mul[0m, time elapsed: 290100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec3Mul (28600 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec4Mul[0m, time elapsed: 263700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec4Mul (13600 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec2Shift[0m, time elapsed: 284600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec2Shift (25800 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec3Shift[0m, time elapsed: 313200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec3Shift (11200 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec4Shift[0m, time elapsed: 229300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec4Shift (11500 ns)
Summary: TOTAL: 476
    [32mPASSED[0m: 476, [32mSKIPPED[0m: 0, ERROR: 0
    [31mFAILED[0m: 0
--------------------------------------------------------------------------------------------------
Project tests finished, time elapsed: 254945800 ns, RESULT:
TP: [33mglm[0m.*, time elapsed: 254772900 ns, RESULT:
    PASSED:
    TP: [33mglm.detail[0m, time elapsed: 237986700 ns
Summary: TOTAL: 476
    [32mPASSED[0m: 476, [32mSKIPPED[0m: 0, ERROR: 0
    [31mFAILED[0m: 0
--------------------------------------------------------------------------------------------------
[0J7[;r8[?25hcjpm test success
