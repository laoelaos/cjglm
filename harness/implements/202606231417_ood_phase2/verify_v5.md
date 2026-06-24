# 验证报告（v5）

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

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:150:13:
    | 
150 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:151:13:
    | 
151 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:154:58:
    | 
154 |     public static func fromMat<SrcQ>(m: Mat2x4<T, SrcQ>, one: T): Mat2x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:155:58:
    | 
155 |     public static func fromMat<SrcQ>(m: Mat3x2<T, SrcQ>, one: T): Mat2x3<T, Q>
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

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:156:13:
    | 
156 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:160:58:
    | 
160 |     public static func fromMat<SrcQ>(m: Mat3x2<T, SrcQ>, one: T): Mat2x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:161:58:
    | 
161 |     public static func fromMat<SrcQ>(m: Mat2x4<T, SrcQ>, one: T): Mat3x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:161:58:
    | 
161 |     public static func fromMat<SrcQ>(m: Mat3x3<T, SrcQ>, one: T): Mat2x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:162:13:
    | 
162 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:163:13:
    | 
163 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:166:58:
    | 
166 |     public static func fromMat<SrcQ>(m: Mat3x3<T, SrcQ>, one: T): Mat2x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:167:58:
    | 
167 |     public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat2x3<T, Q>
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

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:168:13:
    | 
168 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:169:13:
    | 
169 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:169:13:
    | 
169 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:169:13:
    | 
169 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:172:58:
    | 
172 |     public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat2x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:173:58:
    | 
173 |     public static func fromMat<SrcQ>(m: Mat4x2<T, SrcQ>, one: T): Mat2x4<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:173:58:
    | 
173 |     public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat3x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:173:58:
    | 
173 |     public static func fromMat<SrcQ>(m: Mat3x2<T, SrcQ>, one: T): Mat4x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:173:58:
    | 
173 |     public static func fromMat<SrcQ>(m: Mat4x2<T, SrcQ>, one: T): Mat2x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:174:13:
    | 
174 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:175:13:
    | 
175 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:176:58:
    | 
176 |     public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat3x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:178:13:
    | 
178 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:178:58:
    | 
178 |     public static func fromMat<SrcQ>(m: Mat4x2<T, SrcQ>, one: T): Mat2x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x3.cj:179:58:
    | 
179 |     public static func fromMat<SrcQ>(m: Mat3x3<T, SrcQ>, one: T): Mat4x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:179:58:
    | 
179 |     public static func fromMat<SrcQ>(m: Mat4x2<T, SrcQ>, one: T): Mat3x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:179:58:
    | 
179 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat2x4<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:179:58:
    | 
179 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat2x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:180:13:
    | 
180 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:181:13:
    | 
181 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:181:13:
    | 
181 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:184:58:
    | 
184 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat2x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:185:58:
    | 
185 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat3x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:185:58:
    | 
185 |     public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat2x4<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:185:58:
    | 
185 |     public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat2x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:186:13:
    | 
186 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:187:13:
    | 
187 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:187:13:
    | 
187 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:187:13:
    | 
187 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:188:58:
    | 
188 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat3x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:190:13:
    | 
190 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:190:58:
    | 
190 |     public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat2x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:191:58:
    | 
191 |     public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat3x2<T, Q>
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

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:192:13:
    | 
192 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x4.cj:193:13:
    | 
193 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:193:13:
    | 
193 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:193:13:
    | 
193 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:194:58:
    | 
194 |     public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat3x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:196:13:
    | 
196 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:197:58:
    | 
197 |     public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat4x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x3.cj:197:58:
    | 
197 |     public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat4x3<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x3.cj:199:13:
    | 
199 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:199:13:
    | 
199 |         let zero = m.c0.x - m.c0.x
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:202:13:
    | 
202 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:203:13:
    | 
203 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:208:13:
    | 
208 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:214:13:
    | 
214 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:215:13:
    | 
215 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:220:13:
    | 
220 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:221:13:
    | 
221 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:221:13:
    | 
221 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:221:13:
    | 
221 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:226:13:
    | 
226 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:227:13:
    | 
227 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:230:13:
    | 
230 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:232:13:
    | 
232 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:233:13:
    | 
233 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:233:13:
    | 
233 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:238:13:
    | 
238 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:239:13:
    | 
239 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:239:13:
    | 
239 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:239:13:
    | 
239 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:242:13:
    | 
242 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:244:13:
    | 
244 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:245:13:
    | 
245 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:245:13:
    | 
245 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x4.cj:245:13:
    | 
245 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x3.cj:248:13:
    | 
248 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x3.cj:251:13:
    | 
251 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:251:13:
    | 
251 |         let zero = one - one
    |             ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

165 warnings generated, 165 warnings printed.
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

4 warnings generated, 4 warnings printed.
[?25l




📦 group glm.detail                   72% [||||||||||||||------]      (00:00:00)
🧪 test TestCase_testVec2BoolLogicalOr.testVec2BoolLogicalOr          (00:00:00)

passed: 345, failed: 0             72% [||||||||||||||------] 345/476 (00:00:00) --------------------------------------------------------------------------------------------------
TP: glm.detail, time elapsed: 329130000 ns, RESULT:
    TCS: TestCase_testComputeVecAdd1, time elapsed: 1875800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAdd1 (390800 ns)
    TCS: TestCase_testComputeVecSub2, time elapsed: 492600 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSub2 (56700 ns)
    TCS: TestCase_testComputeVecMul3, time elapsed: 402300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMul3 (41100 ns)
    TCS: TestCase_testComputeVecMod1, time elapsed: 337700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMod1 (42800 ns)
    TCS: TestCase_testComputeVecMod4, time elapsed: 297900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMod4 (27100 ns)
    TCS: TestCase_testComputeVecAnd1, time elapsed: 342400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAnd1 (26600 ns)
    TCS: TestCase_testComputeVecAnd3, time elapsed: 321200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAnd3 (26000 ns)
    TCS: TestCase_testComputeVecOr1, time elapsed: 343600 ns, RESULT:
    [ PASSED ] CASE: testComputeVecOr1 (26500 ns)
    TCS: TestCase_testComputeVecOr2, time elapsed: 303300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecOr2 (32500 ns)
    TCS: TestCase_testComputeVecXor1, time elapsed: 309300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecXor1 (32400 ns)
    TCS: TestCase_testComputeVecXor4, time elapsed: 323200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecXor4 (23700 ns)
    TCS: TestCase_testComputeVecShiftLeft1, time elapsed: 365700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftLeft1 (15200 ns)
    TCS: TestCase_testComputeVecShiftLeft3, time elapsed: 379100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftLeft3 (29300 ns)
    TCS: TestCase_testComputeVecShiftRight1, time elapsed: 309100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftRight1 (20300 ns)
    TCS: TestCase_testComputeVecShiftRight4, time elapsed: 343300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftRight4 (24300 ns)
    TCS: TestCase_testComputeVecEqual1, time elapsed: 362200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual1 (30500 ns)
    TCS: TestCase_testComputeVecNequal4, time elapsed: 438900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecNequal4 (39900 ns)
    TCS: TestCase_testComputeVecBitwiseNot1, time elapsed: 560600 ns, RESULT:
    [ PASSED ] CASE: testComputeVecBitwiseNot1 (56600 ns)
    TCS: TestCase_testComputeVecBitwiseNot3, time elapsed: 475200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecBitwiseNot3 (42700 ns)
    TCS: TestCase_testComputeVecAdd4, time elapsed: 310900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAdd4 (25900 ns)
    TCS: TestCase_testComputeVecSub1, time elapsed: 60173300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSub1 (21600 ns)
    TCS: TestCase_testComputeVecSub3, time elapsed: 531100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSub3 (99000 ns)
    TCS: TestCase_testComputeVecMul1, time elapsed: 292200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMul1 (32000 ns)
    TCS: TestCase_testComputeVecMul2, time elapsed: 242300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMul2 (18200 ns)
    TCS: TestCase_testComputeVecDiv1, time elapsed: 248200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecDiv1 (29700 ns)
    TCS: TestCase_testComputeVecDiv2, time elapsed: 243700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecDiv2 (15300 ns)
    TCS: TestCase_testComputeVecDiv4, time elapsed: 249800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecDiv4 (19100 ns)
    TCS: TestCase_testComputeVecEqual2, time elapsed: 242100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual2 (14500 ns)
    TCS: TestCase_testComputeVecEqual3, time elapsed: 259300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual3 (18100 ns)
    TCS: TestCase_testComputeVecEqual4, time elapsed: 250300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual4 (14200 ns)
    TCS: TestCase_testComputeVecNequal1, time elapsed: 267200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecNequal1 (18300 ns)
    TCS: TestCase_testComputeVecNequal2, time elapsed: 228900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecNequal2 (12200 ns)
    TCS: TestCase_testComputeVecBitwiseNot4, time elapsed: 341200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecBitwiseNot4 (45200 ns)
    TCS: TestCase_testComputeVecAddFloat32, time elapsed: 335100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAddFloat32 (36800 ns)
    TCS: TestCase_testComputeVecAddFloat32Vec3, time elapsed: 343500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAddFloat32Vec3 (33300 ns)
    TCS: TestCase_testComputeVecSubFloat32, time elapsed: 291200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSubFloat32 (28100 ns)
    TCS: TestCase_testComputeVecSubFloat32Vec4, time elapsed: 254000 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSubFloat32Vec4 (25700 ns)
    TCS: TestCase_testComputeEqualInt32Equal, time elapsed: 268400 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt32Equal (24700 ns)
    TCS: TestCase_testComputeEqualInt32NotEqual, time elapsed: 246600 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt32NotEqual (19300 ns)
    TCS: TestCase_testComputeEqualFloat32Equal, time elapsed: 226800 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32Equal (14100 ns)
    TCS: TestCase_testComputeEqualFloat32NotEqual, time elapsed: 240200 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32NotEqual (11900 ns)
    TCS: TestCase_testComputeEqualFloat64Equal, time elapsed: 234800 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64Equal (10900 ns)
    TCS: TestCase_testComputeEqualFloat64NotEqual, time elapsed: 240800 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64NotEqual (9500 ns)
    TCS: TestCase_testComputeEqualBoolEqual, time elapsed: 247600 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualBoolEqual (14000 ns)
    TCS: TestCase_testComputeEqualBoolNotEqual, time elapsed: 250600 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualBoolNotEqual (9600 ns)
    TCS: TestCase_testComputeEqualNumericInt32, time elapsed: 225700 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericInt32 (11600 ns)
    TCS: TestCase_testComputeEqualNumericFloat32, time elapsed: 320700 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32 (52700 ns)
    TCS: TestCase_testComputeEqualNumericFloat32Epsilon, time elapsed: 287100 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32Epsilon (24500 ns)
    TCS: TestCase_testComputeEqualNumericFloat64, time elapsed: 278600 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64 (25200 ns)
    TCS: TestCase_testComputeEqualInt64Equal, time elapsed: 281900 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt64Equal (12400 ns)
    TCS: TestCase_testComputeEqualInt64NotEqual, time elapsed: 240400 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt64NotEqual (11500 ns)
    TCS: TestCase_testComputeEqualFloat32Nan, time elapsed: 461400 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32Nan (21300 ns)
    TCS: TestCase_testComputeEqualFloat64Nan, time elapsed: 270900 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64Nan (12600 ns)
    TCS: TestCase_testComputeEqualFloat32SignedZero, time elapsed: 249400 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32SignedZero (21500 ns)
    TCS: TestCase_testComputeEqualFloat64SignedZero, time elapsed: 261300 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64SignedZero (17300 ns)
    TCS: TestCase_testComputeEqualNumericFloat32NotEqual, time elapsed: 254000 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32NotEqual (20400 ns)
    TCS: TestCase_testComputeEqualNumericFloat32BeyondEpsilon, time elapsed: 250200 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32BeyondEpsilon (14400 ns)
    TCS: TestCase_testComputeEqualNumericFloat64NotEqual, time elapsed: 229000 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64NotEqual (14500 ns)
    TCS: TestCase_testComputeEqualNumericFloat64Epsilon, time elapsed: 238900 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64Epsilon (10300 ns)
    TCS: TestCase_testComputeEqualNumericFloat64BeyondEpsilon, time elapsed: 257400 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64BeyondEpsilon (14900 ns)
    TCS: TestCase_testComputeEqualNumericInt64, time elapsed: 243200 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericInt64 (15900 ns)
    TCS: TestCase_testPackedHighpImplementsQualifier, time elapsed: 237800 ns, RESULT:
    [ PASSED ] CASE: testPackedHighpImplementsQualifier (9100 ns)
    TCS: TestCase_testPackedMediumpImplementsQualifier, time elapsed: 218900 ns, RESULT:
    [ PASSED ] CASE: testPackedMediumpImplementsQualifier (8900 ns)
    TCS: TestCase_testPackedLowpImplementsQualifier, time elapsed: 225100 ns, RESULT:
    [ PASSED ] CASE: testPackedLowpImplementsQualifier (8700 ns)
    TCS: TestCase_testDefaultpIsPackedHighp, time elapsed: 257200 ns, RESULT:
    [ PASSED ] CASE: testDefaultpIsPackedHighp (9300 ns)
    TCS: TestCase_testScalarAddVec1, time elapsed: 236000 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec1 (25000 ns)
    TCS: TestCase_testScalarAddVec2, time elapsed: 235800 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec2 (14500 ns)
    TCS: TestCase_testScalarAddVec3, time elapsed: 222400 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec3 (13800 ns)
    TCS: TestCase_testScalarAddVec4, time elapsed: 286300 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec4 (16700 ns)
    TCS: TestCase_testScalarSubVec1, time elapsed: 271300 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1 (19800 ns)
    TCS: TestCase_testScalarMulVec1, time elapsed: 448000 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1 (80500 ns)
    TCS: TestCase_testScalarDivVec1, time elapsed: 633100 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1 (33700 ns)
    TCS: TestCase_testScalarModVec1, time elapsed: 529600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1 (39900 ns)
    TCS: TestCase_testScalarMulVec2, time elapsed: 445600 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2 (34100 ns)
    TCS: TestCase_testScalarSubVec2, time elapsed: 257200 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2 (14500 ns)
    TCS: TestCase_testScalarSubVec3, time elapsed: 244200 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3 (21100 ns)
    TCS: TestCase_testScalarSubVec4, time elapsed: 394000 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4 (52800 ns)
    TCS: TestCase_testScalarMulVec3, time elapsed: 249300 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3 (15200 ns)
    TCS: TestCase_testScalarMulVec4, time elapsed: 250900 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4 (15100 ns)
    TCS: TestCase_testScalarDivVec2, time elapsed: 257200 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2 (11300 ns)
    TCS: TestCase_testScalarDivVec3, time elapsed: 262600 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3 (14500 ns)
    TCS: TestCase_testScalarDivVec4, time elapsed: 251000 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4 (13600 ns)
    TCS: TestCase_testScalarModVec2, time elapsed: 266100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2 (17700 ns)
    TCS: TestCase_testScalarModVec3, time elapsed: 238000 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3 (11200 ns)
    TCS: TestCase_testScalarModVec4, time elapsed: 247600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4 (14500 ns)
    TCS: TestCase_testScalarModVec1Float32, time elapsed: 356200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Float32 (33300 ns)
    TCS: TestCase_testScalarModVec2Float32, time elapsed: 336100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32 (27000 ns)
    TCS: TestCase_testScalarModVec3Float32, time elapsed: 306900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Float32 (28900 ns)
    TCS: TestCase_testScalarModVec4Float32, time elapsed: 308700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Float32 (28000 ns)
    TCS: TestCase_testScalarModVec1Float64, time elapsed: 358200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Float64 (23900 ns)
    TCS: TestCase_testScalarModVec2Float64, time elapsed: 357800 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float64 (16300 ns)
    TCS: TestCase_testScalarModVec3Float64, time elapsed: 304100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Float64 (16400 ns)
    TCS: TestCase_testScalarModVec4Float64, time elapsed: 278800 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Float64 (22900 ns)
    TCS: TestCase_testScalarModVec1Float16, time elapsed: 310700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Float16 (33600 ns)
    TCS: TestCase_testScalarModVec2Float16, time elapsed: 265200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float16 (16300 ns)
    TCS: TestCase_testScalarModVec3Float16, time elapsed: 290200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Float16 (12400 ns)
    TCS: TestCase_testScalarModVec4Float16, time elapsed: 264600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Float16 (15100 ns)
    TCS: TestCase_testScalarSubVec2PackedMediump, time elapsed: 246900 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2PackedMediump (19700 ns)
    TCS: TestCase_testScalarSubVec2PackedLowp, time elapsed: 342500 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2PackedLowp (29900 ns)
    TCS: TestCase_testScalarMulVec2PackedMediump, time elapsed: 256500 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2PackedMediump (15000 ns)
    TCS: TestCase_testScalarMulVec2PackedLowp, time elapsed: 290100 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2PackedLowp (18300 ns)
    TCS: TestCase_testScalarDivVec2PackedMediump, time elapsed: 260900 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2PackedMediump (16400 ns)
    TCS: TestCase_testScalarDivVec2PackedLowp, time elapsed: 280800 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2PackedLowp (20300 ns)
    TCS: TestCase_testScalarModVec2PackedMediump, time elapsed: 319400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2PackedMediump (25600 ns)
    TCS: TestCase_testScalarModVec2PackedLowp, time elapsed: 307600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2PackedLowp (15800 ns)
    TCS: TestCase_testScalarModVec2Float32PackedMediump, time elapsed: 370200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32PackedMediump (20200 ns)
    TCS: TestCase_testScalarModVec2Float32PackedLowp, time elapsed: 360600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32PackedLowp (17700 ns)
    TCS: TestCase_testScalarModVec2Float32NegativeDividend, time elapsed: 305800 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32NegativeDividend (16100 ns)
    TCS: TestCase_testScalarModVec2Float32NegativeDivisor, time elapsed: 403600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32NegativeDivisor (21100 ns)
    TCS: TestCase_testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents, time elapsed: 582800 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents (213400 ns)
    TCS: TestCase_testScalarAddVec1Float32, time elapsed: 395900 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec1Float32 (25400 ns)
    TCS: TestCase_testScalarAddVec2Float32, time elapsed: 330600 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec2Float32 (24200 ns)
    TCS: TestCase_testScalarAddVec3Float32, time elapsed: 313500 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec3Float32 (17800 ns)
    TCS: TestCase_testScalarAddVec4Float32, time elapsed: 263100 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec4Float32 (14500 ns)
    TCS: TestCase_testScalarSubVec1Float32, time elapsed: 300800 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1Float32 (27400 ns)
    TCS: TestCase_testScalarSubVec2Float32, time elapsed: 288700 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2Float32 (12600 ns)
    TCS: TestCase_testScalarSubVec3Float32, time elapsed: 273700 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3Float32 (14400 ns)
    TCS: TestCase_testScalarSubVec4Float32, time elapsed: 281300 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4Float32 (19600 ns)
    TCS: TestCase_testScalarMulVec1Float32, time elapsed: 250800 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1Float32 (11000 ns)
    TCS: TestCase_testScalarMulVec2Float32, time elapsed: 243100 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2Float32 (16000 ns)
    TCS: TestCase_testScalarMulVec3Float32, time elapsed: 284200 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3Float32 (24000 ns)
    TCS: TestCase_testScalarMulVec4Float32, time elapsed: 289300 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4Float32 (13800 ns)
    TCS: TestCase_testScalarDivVec1Float32, time elapsed: 346500 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1Float32 (15700 ns)
    TCS: TestCase_testScalarDivVec2Float32, time elapsed: 292900 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2Float32 (13800 ns)
    TCS: TestCase_testScalarDivVec3Float32, time elapsed: 321500 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3Float32 (14600 ns)
    TCS: TestCase_testScalarDivVec4Float32, time elapsed: 299200 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4Float32 (14400 ns)
    TCS: TestCase_testScalarAddVec1Int32, time elapsed: 312300 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec1Int32 (23400 ns)
    TCS: TestCase_testScalarAddVec2Int32, time elapsed: 312700 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec2Int32 (13900 ns)
    TCS: TestCase_testScalarAddVec3Int32, time elapsed: 295700 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec3Int32 (14800 ns)
    TCS: TestCase_testScalarAddVec4Int32, time elapsed: 279900 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec4Int32 (18000 ns)
    TCS: TestCase_testScalarSubVec1Int32, time elapsed: 277100 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1Int32 (17300 ns)
    TCS: TestCase_testScalarSubVec2Int32, time elapsed: 259200 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2Int32 (13000 ns)
    TCS: TestCase_testScalarSubVec3Int32, time elapsed: 267700 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3Int32 (13700 ns)
    TCS: TestCase_testScalarSubVec4Int32, time elapsed: 251200 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4Int32 (24000 ns)
    TCS: TestCase_testScalarMulVec1Int32, time elapsed: 256500 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1Int32 (19200 ns)
    TCS: TestCase_testScalarMulVec2Int32, time elapsed: 243300 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2Int32 (11400 ns)
    TCS: TestCase_testScalarMulVec3Int32, time elapsed: 245000 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3Int32 (20300 ns)
    TCS: TestCase_testScalarMulVec4Int32, time elapsed: 256100 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4Int32 (12700 ns)
    TCS: TestCase_testScalarDivVec1Int32, time elapsed: 257600 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1Int32 (12100 ns)
    TCS: TestCase_testScalarDivVec2Int32, time elapsed: 474700 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2Int32 (33100 ns)
    TCS: TestCase_testScalarDivVec3Int32, time elapsed: 440900 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3Int32 (25600 ns)
    TCS: TestCase_testScalarDivVec4Int32, time elapsed: 554100 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4Int32 (34400 ns)
    TCS: TestCase_testScalarModVec1Int32, time elapsed: 632200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Int32 (37700 ns)
    TCS: TestCase_testScalarModVec2Int32, time elapsed: 639100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Int32 (23100 ns)
    TCS: TestCase_testScalarModVec3Int32, time elapsed: 400500 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Int32 (19400 ns)
    TCS: TestCase_testScalarModVec4Int32, time elapsed: 282000 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Int32 (15500 ns)
    TCS: TestCase_testScalarSubVec1PackedMediump, time elapsed: 295100 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1PackedMediump (14800 ns)
    TCS: TestCase_testScalarSubVec1PackedLowp, time elapsed: 266400 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1PackedLowp (19300 ns)
    TCS: TestCase_testScalarSubVec3PackedMediump, time elapsed: 254400 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3PackedMediump (13700 ns)
    TCS: TestCase_testScalarSubVec3PackedLowp, time elapsed: 248600 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3PackedLowp (14700 ns)
    TCS: TestCase_testScalarSubVec4PackedMediump, time elapsed: 563600 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4PackedMediump (43300 ns)
    TCS: TestCase_testScalarSubVec4PackedLowp, time elapsed: 359900 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4PackedLowp (17500 ns)
    TCS: TestCase_testScalarMulVec1PackedMediump, time elapsed: 500500 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1PackedMediump (21800 ns)
    TCS: TestCase_testScalarMulVec1PackedLowp, time elapsed: 265200 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1PackedLowp (13200 ns)
    TCS: TestCase_testScalarMulVec3PackedMediump, time elapsed: 259300 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3PackedMediump (13700 ns)
    TCS: TestCase_testScalarMulVec3PackedLowp, time elapsed: 500300 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3PackedLowp (12800 ns)
    TCS: TestCase_testScalarMulVec4PackedMediump, time elapsed: 691900 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4PackedMediump (39900 ns)
    TCS: TestCase_testScalarMulVec4PackedLowp, time elapsed: 406900 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4PackedLowp (35300 ns)
    TCS: TestCase_testScalarDivVec1PackedMediump, time elapsed: 445000 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1PackedMediump (25100 ns)
    TCS: TestCase_testScalarDivVec1PackedLowp, time elapsed: 398400 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1PackedLowp (23600 ns)
    TCS: TestCase_testScalarDivVec3PackedMediump, time elapsed: 262100 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3PackedMediump (17000 ns)
    TCS: TestCase_testScalarDivVec3PackedLowp, time elapsed: 520800 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3PackedLowp (31100 ns)
    TCS: TestCase_testScalarDivVec4PackedMediump, time elapsed: 393600 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4PackedMediump (18700 ns)
    TCS: TestCase_testScalarDivVec4PackedLowp, time elapsed: 322100 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4PackedLowp (36600 ns)
    TCS: TestCase_testScalarModVec1PackedMediump, time elapsed: 459300 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1PackedMediump (24000 ns)
    TCS: TestCase_testScalarModVec1PackedLowp, time elapsed: 254100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1PackedLowp (14600 ns)
    TCS: TestCase_testScalarModVec3PackedMediump, time elapsed: 664400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3PackedMediump (24000 ns)
    TCS: TestCase_testScalarModVec3PackedLowp, time elapsed: 448200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3PackedLowp (24100 ns)
    TCS: TestCase_testScalarModVec4PackedMediump, time elapsed: 427600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4PackedMediump (28200 ns)
    TCS: TestCase_testScalarModVec4PackedLowp, time elapsed: 1105000 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4PackedLowp (31100 ns)
    TCS: TestCase_testScalarDivZeroVec1, time elapsed: 452200 ns, RESULT:
    [ PASSED ] CASE: testScalarDivZeroVec1 (42900 ns)
    TCS: TestCase_testScalarAddNegVec1, time elapsed: 560700 ns, RESULT:
    [ PASSED ] CASE: testScalarAddNegVec1 (26100 ns)
    TCS: TestCase_testScalarAddNegVec2, time elapsed: 441500 ns, RESULT:
    [ PASSED ] CASE: testScalarAddNegVec2 (24900 ns)
    TCS: TestCase_testScalarMulOverflowVec1, time elapsed: 302600 ns, RESULT:
    [ PASSED ] CASE: testScalarMulOverflowVec1 (14900 ns)
    TCS: TestCase_testScalarSubNegVec1, time elapsed: 384400 ns, RESULT:
    [ PASSED ] CASE: testScalarSubNegVec1 (28000 ns)
    TCS: TestCase_testVersionMajor, time elapsed: 253900 ns, RESULT:
    [ PASSED ] CASE: testVersionMajor (11100 ns)
    TCS: TestCase_testVersionMinor, time elapsed: 236200 ns, RESULT:
    [ PASSED ] CASE: testVersionMinor (9300 ns)
    TCS: TestCase_testVersionPatch, time elapsed: 234900 ns, RESULT:
    [ PASSED ] CASE: testVersionPatch (10800 ns)
    TCS: TestCase_testVersionEncoded, time elapsed: 262900 ns, RESULT:
    [ PASSED ] CASE: testVersionEncoded (14800 ns)
    TCS: TestCase_testConfigSimd, time elapsed: 301100 ns, RESULT:
    [ PASSED ] CASE: testConfigSimd (26700 ns)
    TCS: TestCase_testConfigAlignedGentypes, time elapsed: 269900 ns, RESULT:
    [ PASSED ] CASE: testConfigAlignedGentypes (10800 ns)
    TCS: TestCase_testConfigClipControl, time elapsed: 240200 ns, RESULT:
    [ PASSED ] CASE: testConfigClipControl (15600 ns)
    TCS: TestCase_testConstNegationSimd, time elapsed: 264100 ns, RESULT:
    [ PASSED ] CASE: testConstNegationSimd (8800 ns)
    TCS: TestCase_testConstNegationAligned, time elapsed: 243900 ns, RESULT:
    [ PASSED ] CASE: testConstNegationAligned (15800 ns)
    TCS: TestCase_testConstNegationClip, time elapsed: 295500 ns, RESULT:
    [ PASSED ] CASE: testConstNegationClip (10400 ns)
    TCS: TestCase_testConstInt64Usage, time elapsed: 258600 ns, RESULT:
    [ PASSED ] CASE: testConstInt64Usage (18500 ns)
    TCS: TestCase_testConstBoolUsage, time elapsed: 267100 ns, RESULT:
    [ PASSED ] CASE: testConstBoolUsage (9900 ns)
    TCS: TestCase_testVersionEncodingConsistency, time elapsed: 227500 ns, RESULT:
    [ PASSED ] CASE: testVersionEncodingConsistency (11500 ns)
    TCS: TestCase_testAssertPasses, time elapsed: 297100 ns, RESULT:
    [ PASSED ] CASE: testAssertPasses (27300 ns)
    TCS: TestCase_testAssertFails, time elapsed: 318500 ns, RESULT:
    [ PASSED ] CASE: testAssertFails (80600 ns)
    TCS: TestCase_testAssertWithCustomMessage, time elapsed: 302200 ns, RESULT:
    [ PASSED ] CASE: testAssertWithCustomMessage (70500 ns)
    TCS: TestCase_testNumericLimitsFloat32Epsilon, time elapsed: 244900 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsFloat32Epsilon (16200 ns)
    TCS: TestCase_testNumericLimitsFloat64Epsilon, time elapsed: 258800 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsFloat64Epsilon (14000 ns)
    TCS: TestCase_testIsIec559OfFloat32, time elapsed: 448700 ns, RESULT:
    [ PASSED ] CASE: testIsIec559OfFloat32 (19400 ns)
    TCS: TestCase_testIsIec559OfFloat64, time elapsed: 243300 ns, RESULT:
    [ PASSED ] CASE: testIsIec559OfFloat64 (11000 ns)
    TCS: TestCase_testIsIec559OfInt64, time elapsed: 240100 ns, RESULT:
    [ PASSED ] CASE: testIsIec559OfInt64 (15200 ns)
    TCS: TestCase_testEpsilonOfFloat32, time elapsed: 338600 ns, RESULT:
    [ PASSED ] CASE: testEpsilonOfFloat32 (27900 ns)
    TCS: TestCase_testEpsilonOfFloat64, time elapsed: 388700 ns, RESULT:
    [ PASSED ] CASE: testEpsilonOfFloat64 (16900 ns)
    TCS: TestCase_testNumericLimitsInt64Epsilon, time elapsed: 701600 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt64Epsilon (30800 ns)
    TCS: TestCase_testNumericLimitsInt32Epsilon, time elapsed: 633000 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt32Epsilon (34100 ns)
    TCS: TestCase_testNumericLimitsInt16Epsilon, time elapsed: 1003300 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt16Epsilon (33200 ns)
    TCS: TestCase_testNumericLimitsInt8Epsilon, time elapsed: 809800 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt8Epsilon (106300 ns)
    TCS: TestCase_testCastVec1ToVec1IntToFloat, time elapsed: 781600 ns, RESULT:
    [ PASSED ] CASE: testCastVec1ToVec1IntToFloat (59100 ns)
    TCS: TestCase_testCastVec2ToVec1TakesOnlyX, time elapsed: 729800 ns, RESULT:
    [ PASSED ] CASE: testCastVec2ToVec1TakesOnlyX (54200 ns)
    TCS: TestCase_testCastVec3ToVec1TakesOnlyX, time elapsed: 516100 ns, RESULT:
    [ PASSED ] CASE: testCastVec3ToVec1TakesOnlyX (32300 ns)
    TCS: TestCase_testCastVec4ToVec1TakesOnlyX, time elapsed: 291700 ns, RESULT:
    [ PASSED ] CASE: testCastVec4ToVec1TakesOnlyX (21500 ns)
    TCS: TestCase_testCastSameTypeIdentity, time elapsed: 351300 ns, RESULT:
    [ PASSED ] CASE: testCastSameTypeIdentity (12900 ns)
    TCS: TestCase_testCastInt32ToInt64, time elapsed: 512800 ns, RESULT:
    [ PASSED ] CASE: testCastInt32ToInt64 (21300 ns)
    TCS: TestCase_testCastFloatToIntTruncation, time elapsed: 666600 ns, RESULT:
    [ PASSED ] CASE: testCastFloatToIntTruncation (32400 ns)
    TCS: TestCase_testCastCrossQualifierPackedHighpToDefaultp, time elapsed: 463200 ns, RESULT:
    [ PASSED ] CASE: testCastCrossQualifierPackedHighpToDefaultp (19800 ns)
    TCS: TestCase_testCastCrossQualifierDefaultpToPackedHighp, time elapsed: 708200 ns, RESULT:
    [ PASSED ] CASE: testCastCrossQualifierDefaultpToPackedHighp (27600 ns)
    TCS: TestCase_testCastVec2CrossQualifierCrossType, time elapsed: 1025300 ns, RESULT:
    [ PASSED ] CASE: testCastVec2CrossQualifierCrossType (110500 ns)
    TCS: TestCase_testCastVec3CrossQualifier, time elapsed: 1586800 ns, RESULT:
    [ PASSED ] CASE: testCastVec3CrossQualifier (40600 ns)
    TCS: TestCase_testCastVec4CrossQualifier, time elapsed: 3483900 ns, RESULT:
    [ PASSED ] CASE: testCastVec4CrossQualifier (25800 ns)
    TCS: TestCase_testCastVec1DoesNotModifySource, time elapsed: 587100 ns, RESULT:
    [ PASSED ] CASE: testCastVec1DoesNotModifySource (34300 ns)
    TCS: TestCase_testCastVec2Vec1ToVec2IntToFloat, time elapsed: 365000 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec1ToVec2IntToFloat (16500 ns)
    TCS: TestCase_testCastVec2Vec2ToVec2Identity, time elapsed: 471300 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec2ToVec2Identity (29300 ns)
    TCS: TestCase_testCastVec2Vec3ToVec2TakesOnlyXY, time elapsed: 565700 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec3ToVec2TakesOnlyXY (40600 ns)
    TCS: TestCase_testCastVec2Vec4ToVec2TakesOnlyXY, time elapsed: 431400 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec4ToVec2TakesOnlyXY (17200 ns)
    TCS: TestCase_testCastVec2SameTypeIdentity, time elapsed: 591400 ns, RESULT:
    [ PASSED ] CASE: testCastVec2SameTypeIdentity (19100 ns)
    TCS: TestCase_testCastVec2Int32ToInt64, time elapsed: 816200 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Int32ToInt64 (22400 ns)
    TCS: TestCase_testCastVec2FloatToIntTruncation, time elapsed: 393500 ns, RESULT:
    [ PASSED ] CASE: testCastVec2FloatToIntTruncation (25100 ns)
    TCS: TestCase_testCastVec2CrossQualifierPackedHighpToDefaultp, time elapsed: 418900 ns, RESULT:
    [ PASSED ] CASE: testCastVec2CrossQualifierPackedHighpToDefaultp (17800 ns)
    TCS: TestCase_testCastVec2DoesNotModifySource, time elapsed: 474000 ns, RESULT:
    [ PASSED ] CASE: testCastVec2DoesNotModifySource (21200 ns)
    TCS: TestCase_testCastVec2Vec1ToVec2SameValueBothComponents, time elapsed: 3292500 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec1ToVec2SameValueBothComponents (43700 ns)
    TCS: TestCase_testCastVec3Vec1ToVec3IntToFloat, time elapsed: 546600 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec1ToVec3IntToFloat (38500 ns)
    TCS: TestCase_testCastVec3Vec2ToVec3ExtendY, time elapsed: 479100 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec2ToVec3ExtendY (24600 ns)
    TCS: TestCase_testCastVec3Vec3ToVec3Identity, time elapsed: 1007800 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec3ToVec3Identity (27100 ns)
    TCS: TestCase_testCastVec3Vec4ToVec3TakesOnlyXYZ, time elapsed: 580400 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec4ToVec3TakesOnlyXYZ (35100 ns)
    TCS: TestCase_testCastVec3SameTypeIdentity, time elapsed: 878100 ns, RESULT:
    [ PASSED ] CASE: testCastVec3SameTypeIdentity (38900 ns)
    TCS: TestCase_testCastVec3Int32ToInt64, time elapsed: 2261200 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Int32ToInt64 (48900 ns)
    TCS: TestCase_testCastVec3FloatToIntTruncation, time elapsed: 820500 ns, RESULT:
    [ PASSED ] CASE: testCastVec3FloatToIntTruncation (36000 ns)
    TCS: TestCase_testCastVec3CrossQualifierPackedHighpToDefaultp, time elapsed: 920300 ns, RESULT:
    [ PASSED ] CASE: testCastVec3CrossQualifierPackedHighpToDefaultp (39800 ns)
    TCS: TestCase_testCastVec3DoesNotModifySource, time elapsed: 466100 ns, RESULT:
    [ PASSED ] CASE: testCastVec3DoesNotModifySource (25700 ns)
    TCS: TestCase_testCastVec3Vec1ToVec3SameValueAllComponents, time elapsed: 409100 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec1ToVec3SameValueAllComponents (23600 ns)
    TCS: TestCase_testCastVec4Vec1ToVec4IntToFloat, time elapsed: 369200 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec1ToVec4IntToFloat (19300 ns)
    TCS: TestCase_testCastVec4Vec2ToVec4ExtendY, time elapsed: 394000 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec2ToVec4ExtendY (28900 ns)
    TCS: TestCase_testCastVec4Vec3ToVec4ExtendZ, time elapsed: 362000 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec3ToVec4ExtendZ (28400 ns)
    TCS: TestCase_testCastVec4Vec4ToVec4Identity, time elapsed: 369800 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec4ToVec4Identity (23000 ns)
    TCS: TestCase_testCastVec4SameTypeIdentity, time elapsed: 501300 ns, RESULT:
    [ PASSED ] CASE: testCastVec4SameTypeIdentity (31800 ns)
    TCS: TestCase_testCastVec4Int32ToInt64, time elapsed: 409400 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Int32ToInt64 (26000 ns)
    TCS: TestCase_testCastVec4FloatToIntTruncation, time elapsed: 418100 ns, RESULT:
    [ PASSED ] CASE: testCastVec4FloatToIntTruncation (24900 ns)
    TCS: TestCase_testCastVec4CrossQualifierPackedHighpToDefaultp, time elapsed: 643800 ns, RESULT:
    [ PASSED ] CASE: testCastVec4CrossQualifierPackedHighpToDefaultp (44100 ns)
    TCS: TestCase_testCastVec4DoesNotModifySource, time elapsed: 640800 ns, RESULT:
    [ PASSED ] CASE: testCastVec4DoesNotModifySource (29100 ns)
    TCS: TestCase_testCastVec4Vec1ToVec4SameValueAllComponents, time elapsed: 697100 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec1ToVec4SameValueAllComponents (28900 ns)
    TCS: TestCase_testFromBoolVec1, time elapsed: 528400 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec1 (27700 ns)
    TCS: TestCase_testFromBoolVec1False, time elapsed: 565000 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec1False (29000 ns)
    TCS: TestCase_testFromBoolVec2, time elapsed: 647900 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec2 (31600 ns)
    TCS: TestCase_testFromBoolVec3, time elapsed: 370400 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec3 (22000 ns)
    TCS: TestCase_testFromBoolVec4, time elapsed: 511700 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec4 (45900 ns)
    TCS: TestCase_testFromBoolVecQ2Vec1, time elapsed: 486300 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec1 (22000 ns)
    TCS: TestCase_testFromBoolVecQ2Vec2, time elapsed: 552900 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec2 (25800 ns)
    TCS: TestCase_testFromBoolVecQ2Vec3, time elapsed: 597600 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec3 (27700 ns)
    TCS: TestCase_testFromBoolVecQ2Vec4, time elapsed: 554200 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec4 (31700 ns)
    TCS: TestCase_testFromBoolVec3AllFalse, time elapsed: 506300 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec3AllFalse (25600 ns)
    TCS: TestCase_testFromBoolVec4AllFalse, time elapsed: 454900 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec4AllFalse (22600 ns)
    TCS: TestCase_testFromBoolVecQ2Vec3AllFalse, time elapsed: 454600 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec3AllFalse (20600 ns)
    TCS: TestCase_testFromBoolVecQ2Vec4AllFalse, time elapsed: 486100 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec4AllFalse (21900 ns)
    TCS: TestCase_testFromBoolVecFloat32, time elapsed: 474500 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecFloat32 (21200 ns)
    TCS: TestCase_testFromBoolVecFloat64, time elapsed: 428600 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecFloat64 (35700 ns)
    TCS: TestCase_testFromBoolVecInt32, time elapsed: 957500 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecInt32 (26000 ns)
    TCS: TestCase_testFromBoolVecQ2PackedMediump, time elapsed: 715600 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2PackedMediump (23000 ns)
    TCS: TestCase_testFromBoolVecQ2PackedLowp, time elapsed: 360000 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2PackedLowp (20500 ns)
    TCS: TestCase_testVec1ConstInit, time elapsed: 408400 ns, RESULT:
    [ PASSED ] CASE: testVec1ConstInit (26800 ns)
    TCS: TestCase_testVec1Length, time elapsed: 504100 ns, RESULT:
    [ PASSED ] CASE: testVec1Length (25500 ns)
    TCS: TestCase_testVec1IndexAccess, time elapsed: 500500 ns, RESULT:
    [ PASSED ] CASE: testVec1IndexAccess (33300 ns)
    TCS: TestCase_testVec1IndexMutate, time elapsed: 445300 ns, RESULT:
    [ PASSED ] CASE: testVec1IndexMutate (21000 ns)
    TCS: TestCase_testVec1ComponentAt, time elapsed: 267400 ns, RESULT:
    [ PASSED ] CASE: testVec1ComponentAt (12400 ns)
    TCS: TestCase_testVec1Add, time elapsed: 347100 ns, RESULT:
    [ PASSED ] CASE: testVec1Add (17800 ns)
    TCS: TestCase_testVec1Sub, time elapsed: 340800 ns, RESULT:
    [ PASSED ] CASE: testVec1Sub (29500 ns)
    TCS: TestCase_testVec1Mul, time elapsed: 296400 ns, RESULT:
    [ PASSED ] CASE: testVec1Mul (23300 ns)
    TCS: TestCase_testVec1Div, time elapsed: 241400 ns, RESULT:
    [ PASSED ] CASE: testVec1Div (13000 ns)
    TCS: TestCase_testVec1Mod, time elapsed: 235300 ns, RESULT:
    [ PASSED ] CASE: testVec1Mod (14700 ns)
    TCS: TestCase_testVec1ScalarAdd, time elapsed: 226800 ns, RESULT:
    [ PASSED ] CASE: testVec1ScalarAdd (12000 ns)
    TCS: TestCase_testVec1Negate, time elapsed: 256400 ns, RESULT:
    [ PASSED ] CASE: testVec1Negate (14400 ns)
    TCS: TestCase_testVec1AddNamed, time elapsed: 486600 ns, RESULT:
    [ PASSED ] CASE: testVec1AddNamed (23200 ns)
    TCS: TestCase_testVec1SubNamed, time elapsed: 520100 ns, RESULT:
    [ PASSED ] CASE: testVec1SubNamed (39000 ns)
    TCS: TestCase_testVec1MulNamed, time elapsed: 401300 ns, RESULT:
    [ PASSED ] CASE: testVec1MulNamed (27100 ns)
    TCS: TestCase_testVec1Equal, time elapsed: 306800 ns, RESULT:
    [ PASSED ] CASE: testVec1Equal (23200 ns)
    TCS: TestCase_testVec1NotEqual, time elapsed: 356100 ns, RESULT:
    [ PASSED ] CASE: testVec1NotEqual (17500 ns)
    TCS: TestCase_testVec1EqualExact, time elapsed: 315200 ns, RESULT:
    [ PASSED ] CASE: testVec1EqualExact (15500 ns)
    TCS: TestCase_testVec1BitwiseAnd, time elapsed: 278600 ns, RESULT:
    [ PASSED ] CASE: testVec1BitwiseAnd (23600 ns)
    TCS: TestCase_testVec1BitwiseOr, time elapsed: 235700 ns, RESULT:
    [ PASSED ] CASE: testVec1BitwiseOr (13600 ns)
    TCS: TestCase_testVec1BitwiseXor, time elapsed: 235200 ns, RESULT:
    [ PASSED ] CASE: testVec1BitwiseXor (11600 ns)
    TCS: TestCase_testVec1ShiftLeft, time elapsed: 247600 ns, RESULT:
    [ PASSED ] CASE: testVec1ShiftLeft (14800 ns)
    TCS: TestCase_testVec1ShiftRight, time elapsed: 225100 ns, RESULT:
    [ PASSED ] CASE: testVec1ShiftRight (11800 ns)
    TCS: TestCase_testVec1BitwiseNot, time elapsed: 233700 ns, RESULT:
    [ PASSED ] CASE: testVec1BitwiseNot (12700 ns)
    TCS: TestCase_testVec1BoolLogicalAnd, time elapsed: 233800 ns, RESULT:
    [ PASSED ] CASE: testVec1BoolLogicalAnd (9100 ns)
    TCS: TestCase_testVec1BoolLogicalOr, time elapsed: 246000 ns, RESULT:
    [ PASSED ] CASE: testVec1BoolLogicalOr (9000 ns)
    TCS: TestCase_testVec1IndexOutOfBoundsAccess, time elapsed: 313600 ns, RESULT:
    [ PASSED ] CASE: testVec1IndexOutOfBoundsAccess (81700 ns)
    TCS: TestCase_testVec1ShiftVec, time elapsed: 305400 ns, RESULT:
    [ PASSED ] CASE: testVec1ShiftVec (17800 ns)
    TCS: TestCase_testVec1ScalarSub, time elapsed: 209400 ns, RESULT:
    [ PASSED ] CASE: testVec1ScalarSub (9200 ns)
    TCS: TestCase_testVec1ScalarMul, time elapsed: 203500 ns, RESULT:
    [ PASSED ] CASE: testVec1ScalarMul (11500 ns)
    TCS: TestCase_testVec1ScalarDiv, time elapsed: 202300 ns, RESULT:
    [ PASSED ] CASE: testVec1ScalarDiv (8300 ns)
    TCS: TestCase_testVec1ScalarMod, time elapsed: 214100 ns, RESULT:
    [ PASSED ] CASE: testVec1ScalarMod (6900 ns)
    TCS: TestCase_testVec1DivNamed, time elapsed: 277800 ns, RESULT:
    [ PASSED ] CASE: testVec1DivNamed (12300 ns)
    TCS: TestCase_testVec1ModNamed, time elapsed: 238100 ns, RESULT:
    [ PASSED ] CASE: testVec1ModNamed (11000 ns)
    TCS: TestCase_testVec1ScalarBitwiseAnd, time elapsed: 256300 ns, RESULT:
    [ PASSED ] CASE: testVec1ScalarBitwiseAnd (22600 ns)
    TCS: TestCase_testVec1ScalarBitwiseOr, time elapsed: 239100 ns, RESULT:
    [ PASSED ] CASE: testVec1ScalarBitwiseOr (9200 ns)
    TCS: TestCase_testVec1ScalarBitwiseXor, time elapsed: 211400 ns, RESULT:
    [ PASSED ] CASE: testVec1ScalarBitwiseXor (7600 ns)
    TCS: TestCase_testVec1ShiftRightVec, time elapsed: 228100 ns, RESULT:
    [ PASSED ] CASE: testVec1ShiftRightVec (14400 ns)
    TCS: TestCase_testVec1EqualEpsilon, time elapsed: 253200 ns, RESULT:
    [ PASSED ] CASE: testVec1EqualEpsilon (19200 ns)
    TCS: TestCase_testVec1BroadcastAddVec2, time elapsed: 232200 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastAddVec2 (16600 ns)
    TCS: TestCase_testVec1BroadcastBitAndVec2, time elapsed: 374100 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastBitAndVec2 (26300 ns)
    TCS: TestCase_testVec1BroadcastAddVec3, time elapsed: 278200 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastAddVec3 (17400 ns)
    TCS: TestCase_testVec1BroadcastAddVec4, time elapsed: 249600 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastAddVec4 (18100 ns)
    TCS: TestCase_testVec1BroadcastBitOrVec2, time elapsed: 226400 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastBitOrVec2 (14500 ns)
    TCS: TestCase_testVec1BroadcastBitXorVec2, time elapsed: 223400 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastBitXorVec2 (13800 ns)
    TCS: TestCase_testVec1BroadcastShiftLeftVec2, time elapsed: 234000 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastShiftLeftVec2 (11100 ns)
    TCS: TestCase_testVec1BroadcastShiftRightVec2, time elapsed: 215200 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastShiftRightVec2 (8000 ns)
    TCS: TestCase_testVec1BroadcastBitAndVec3, time elapsed: 226700 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastBitAndVec3 (14500 ns)
    TCS: TestCase_testVec1BroadcastBitAndVec4, time elapsed: 531100 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastBitAndVec4 (33100 ns)
    TCS: TestCase_testVec1BroadcastModVec2, time elapsed: 306300 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastModVec2 (12500 ns)
    TCS: TestCase_testVec1BroadcastModVec3, time elapsed: 272400 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastModVec3 (14100 ns)
    TCS: TestCase_testVec1BroadcastModVec4, time elapsed: 227300 ns, RESULT:
    [ PASSED ] CASE: testVec1BroadcastModVec4 (13600 ns)
    TCS: TestCase_testVec1Increment, time elapsed: 248700 ns, RESULT:
    [ PASSED ] CASE: testVec1Increment (12400 ns)
    TCS: TestCase_testVec1Decrement, time elapsed: 222800 ns, RESULT:
    [ PASSED ] CASE: testVec1Decrement (10900 ns)
    TCS: TestCase_testVec2ScalarInit, time elapsed: 285500 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarInit (13900 ns)
    TCS: TestCase_testVec2ConstInit, time elapsed: 247400 ns, RESULT:
    [ PASSED ] CASE: testVec2ConstInit (12600 ns)
    TCS: TestCase_testVec2Length, time elapsed: 247500 ns, RESULT:
    [ PASSED ] CASE: testVec2Length (12200 ns)
    TCS: TestCase_testVec2Add, time elapsed: 224300 ns, RESULT:
    [ PASSED ] CASE: testVec2Add (14700 ns)
    TCS: TestCase_testVec2Sub, time elapsed: 248600 ns, RESULT:
    [ PASSED ] CASE: testVec2Sub (12900 ns)
    TCS: TestCase_testVec2Mul, time elapsed: 215000 ns, RESULT:
    [ PASSED ] CASE: testVec2Mul (11900 ns)
    TCS: TestCase_testVec2ScalarAdd, time elapsed: 218400 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarAdd (11300 ns)
    TCS: TestCase_testVec2Negate, time elapsed: 248100 ns, RESULT:
    [ PASSED ] CASE: testVec2Negate (13300 ns)
    TCS: TestCase_testVec2IndexAccess, time elapsed: 261400 ns, RESULT:
    [ PASSED ] CASE: testVec2IndexAccess (14100 ns)
    TCS: TestCase_testVec2IndexMutate, time elapsed: 291700 ns, RESULT:
    [ PASSED ] CASE: testVec2IndexMutate (15500 ns)
    TCS: TestCase_testVec2ComponentAt, time elapsed: 276900 ns, RESULT:
    [ PASSED ] CASE: testVec2ComponentAt (12600 ns)
    TCS: TestCase_testVec2Equal, time elapsed: 239600 ns, RESULT:
    [ PASSED ] CASE: testVec2Equal (19100 ns)
    TCS: TestCase_testVec2NotEqual, time elapsed: 246100 ns, RESULT:
    [ PASSED ] CASE: testVec2NotEqual (14800 ns)
    TCS: TestCase_testVec2EqualExact, time elapsed: 237000 ns, RESULT:
    [ PASSED ] CASE: testVec2EqualExact (17300 ns)
    TCS: TestCase_testVec2BitwiseAnd, time elapsed: 229200 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseAnd (14100 ns)
    TCS: TestCase_testVec2BitwiseNot, time elapsed: 244400 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseNot (10400 ns)
    TCS: TestCase_testVec2FromVec1, time elapsed: 240700 ns, RESULT:
    [ PASSED ] CASE: testVec2FromVec1 (11200 ns)
    TCS: TestCase_testVec2ShiftLeft, time elapsed: 696400 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftLeft (42900 ns)
    TCS: TestCase_testVec2BoolLogicalAnd, time elapsed: 442400 ns, RESULT:
    [ PASSED ] CASE: testVec2BoolLogicalAnd (31500 ns)
    TCS: TestCase_testVec2Vec1ArithBroadcast, time elapsed: 722000 ns, RESULT:
    [ PASSED ] CASE: testVec2Vec1ArithBroadcast (58600 ns)
    TCS: TestCase_testVec2Vec1BitBroadcast, time elapsed: 639200 ns, RESULT:
    [ PASSED ] CASE: testVec2Vec1BitBroadcast (53800 ns)
    TCS: TestCase_testVec2ShiftLeftVec1, time elapsed: 458900 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftLeftVec1 (33400 ns)
    TCS: TestCase_testVec2Div, time elapsed: 450300 ns, RESULT:
    [ PASSED ] CASE: testVec2Div (33600 ns)
    TCS: TestCase_testVec2Mod, time elapsed: 573800 ns, RESULT:
    [ PASSED ] CASE: testVec2Mod (33300 ns)
    TCS: TestCase_testVec2ScalarSub, time elapsed: 963300 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarSub (123300 ns)
    TCS: TestCase_testVec2ScalarMul, time elapsed: 483000 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarMul (31500 ns)
    TCS: TestCase_testVec2ScalarDiv, time elapsed: 254400 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarDiv (14300 ns)
    TCS: TestCase_testVec2ScalarMod, time elapsed: 243400 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarMod (10600 ns)
    TCS: TestCase_testVec2BoolLogicalOr, time elapsed: 239600 ns, RESULT:
    [ PASSED ] CASE: testVec2BoolLogicalOr (11400 ns)
    TCS: TestCase_testVec2EqualEpsilon, time elapsed: 281100 ns, RESULT:
    [ PASSED ] CASE: testVec2EqualEpsilon (23000 ns)
    TCS: TestCase_testVec2DivNamed, time elapsed: 247200 ns, RESULT:
    [ PASSED ] CASE: testVec2DivNamed (14500 ns)
    TCS: TestCase_testVec2ModNamed, time elapsed: 277700 ns, RESULT:
    [ PASSED ] CASE: testVec2ModNamed (11900 ns)
    TCS: TestCase_testVec2BitwiseOr, time elapsed: 293100 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseOr (21300 ns)
    TCS: TestCase_testVec2BitwiseXor, time elapsed: 386800 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseXor (33400 ns)
    TCS: TestCase_testVec2ScalarBitwiseAnd, time elapsed: 348400 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarBitwiseAnd (19200 ns)
    TCS: TestCase_testVec2ShiftRight, time elapsed: 289900 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftRight (25000 ns)
    TCS: TestCase_testVec2ShiftRightVec1, time elapsed: 294000 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftRightVec1 (17300 ns)
    TCS: TestCase_testVec2AddNamed, time elapsed: 296400 ns, RESULT:
    [ PASSED ] CASE: testVec2AddNamed (14700 ns)
    TCS: TestCase_testVec2SubNamed, time elapsed: 464200 ns, RESULT:
    [ PASSED ] CASE: testVec2SubNamed (19900 ns)
    TCS: TestCase_testVec2MulNamed, time elapsed: 383500 ns, RESULT:
    [ PASSED ] CASE: testVec2MulNamed (19700 ns)
    TCS: TestCase_testVec2ShiftLeftVec, time elapsed: 307700 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftLeftVec (15800 ns)
    TCS: TestCase_testVec2ShiftRightVec, time elapsed: 238400 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftRightVec (14300 ns)
    TCS: TestCase_testVec2ScalarBitwiseOr, time elapsed: 230700 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarBitwiseOr (10200 ns)
    TCS: TestCase_testVec2ScalarBitwiseXor, time elapsed: 847700 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarBitwiseXor (57900 ns)
    TCS: TestCase_testVec2Increment, time elapsed: 865100 ns, RESULT:
    [ PASSED ] CASE: testVec2Increment (42600 ns)
    TCS: TestCase_testVec2Decrement, time elapsed: 344100 ns, RESULT:
    [ PASSED ] CASE: testVec2Decrement (18300 ns)
    TCS: TestCase_testVec2IndexOutOfBoundsAccess, time elapsed: 330600 ns, RESULT:
    [ PASSED ] CASE: testVec2IndexOutOfBoundsAccess (78400 ns)
    TCS: TestCase_testVec2NegativeIndexAccess, time elapsed: 278200 ns, RESULT:
    [ PASSED ] CASE: testVec2NegativeIndexAccess (44900 ns)
    TCS: TestCase_testVec3ScalarInit, time elapsed: 245200 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarInit (15100 ns)
    TCS: TestCase_testVec3ConstInit, time elapsed: 516600 ns, RESULT:
    [ PASSED ] CASE: testVec3ConstInit (30400 ns)
    TCS: TestCase_testVec3Length, time elapsed: 331100 ns, RESULT:
    [ PASSED ] CASE: testVec3Length (12400 ns)
    TCS: TestCase_testVec3Add, time elapsed: 366500 ns, RESULT:
    [ PASSED ] CASE: testVec3Add (29600 ns)
    TCS: TestCase_testVec3ScalarMul, time elapsed: 388300 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarMul (36900 ns)
    TCS: TestCase_testVec3Negate, time elapsed: 983000 ns, RESULT:
    [ PASSED ] CASE: testVec3Negate (98000 ns)
    TCS: TestCase_testVec3IndexAccess, time elapsed: 290700 ns, RESULT:
    [ PASSED ] CASE: testVec3IndexAccess (19500 ns)
    TCS: TestCase_testVec3IndexMutate, time elapsed: 270800 ns, RESULT:
    [ PASSED ] CASE: testVec3IndexMutate (9500 ns)
    TCS: TestCase_testVec3ComponentAt, time elapsed: 245000 ns, RESULT:
    [ PASSED ] CASE: testVec3ComponentAt (8300 ns)
    TCS: TestCase_testVec3Equal, time elapsed: 236800 ns, RESULT:
    [ PASSED ] CASE: testVec3Equal (24100 ns)
    TCS: TestCase_testVec3NotEqual, time elapsed: 243300 ns, RESULT:
    [ PASSED ] CASE: testVec3NotEqual (14600 ns)
    TCS: TestCase_testVec3EqualExact, time elapsed: 246900 ns, RESULT:
    [ PASSED ] CASE: testVec3EqualExact (13100 ns)
    TCS: TestCase_testVec3BitwiseAnd, time elapsed: 239500 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseAnd (15100 ns)
    TCS: TestCase_testVec3BitwiseNot, time elapsed: 212600 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseNot (8500 ns)
    TCS: TestCase_testVec3Vec1ArithBroadcast, time elapsed: 732200 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1ArithBroadcast (50000 ns)
    TCS: TestCase_testVec3ShiftLeft, time elapsed: 238500 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftLeft (19600 ns)
    TCS: TestCase_testVec3BoolLogicalAnd, time elapsed: 242900 ns, RESULT:
    [ PASSED ] CASE: testVec3BoolLogicalAnd (12900 ns)
    TCS: TestCase_testVec3Sub, time elapsed: 222400 ns, RESULT:
    [ PASSED ] CASE: testVec3Sub (14400 ns)
    TCS: TestCase_testVec3Div, time elapsed: 227500 ns, RESULT:
    [ PASSED ] CASE: testVec3Div (13100 ns)
    TCS: TestCase_testVec3Mod, time elapsed: 777200 ns, RESULT:
    [ PASSED ] CASE: testVec3Mod (45300 ns)
    TCS: TestCase_testVec3ScalarSub, time elapsed: 318000 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarSub (27500 ns)
    TCS: TestCase_testVec3ScalarDiv, time elapsed: 610300 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarDiv (19500 ns)
    TCS: TestCase_testVec3ScalarMod, time elapsed: 897100 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarMod (57200 ns)
    TCS: TestCase_testVec3BoolLogicalOr, time elapsed: 701100 ns, RESULT:
    [ PASSED ] CASE: testVec3BoolLogicalOr (49200 ns)
    TCS: TestCase_testVec3EqualEpsilon, time elapsed: 439600 ns, RESULT:
    [ PASSED ] CASE: testVec3EqualEpsilon (41400 ns)
    TCS: TestCase_testVec3AddNamed, time elapsed: 792500 ns, RESULT:
    [ PASSED ] CASE: testVec3AddNamed (48600 ns)
    TCS: TestCase_testVec3MulNamed, time elapsed: 728700 ns, RESULT:
    [ PASSED ] CASE: testVec3MulNamed (34200 ns)
    TCS: TestCase_testVec3DivNamed, time elapsed: 705700 ns, RESULT:
    [ PASSED ] CASE: testVec3DivNamed (75900 ns)
    TCS: TestCase_testVec3ModNamed, time elapsed: 585000 ns, RESULT:
    [ PASSED ] CASE: testVec3ModNamed (25100 ns)
    TCS: TestCase_testVec3BitwiseOr, time elapsed: 1272300 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseOr (107800 ns)
    TCS: TestCase_testVec3BitwiseXor, time elapsed: 381200 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseXor (38800 ns)
    TCS: TestCase_testVec3ScalarBitwiseAnd, time elapsed: 302800 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarBitwiseAnd (24700 ns)
    TCS: TestCase_testVec3ShiftRight, time elapsed: 412200 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftRight (25000 ns)
    TCS: TestCase_testVec3Vec1BitBroadcast, time elapsed: 497100 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1BitBroadcast (34600 ns)
    TCS: TestCase_testVec3ShiftRightVec1, time elapsed: 303700 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftRightVec1 (17600 ns)
    TCS: TestCase_testVec3FromVec1, time elapsed: 353500 ns, RESULT:
    [ PASSED ] CASE: testVec3FromVec1 (16100 ns)
    TCS: TestCase_testVec3ScalarBitwiseOr, time elapsed: 272800 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarBitwiseOr (16800 ns)
    TCS: TestCase_testVec3ScalarBitwiseXor, time elapsed: 245600 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarBitwiseXor (18300 ns)
    TCS: TestCase_testVec3Vec1BitOrBroadcast, time elapsed: 285600 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1BitOrBroadcast (15100 ns)
    TCS: TestCase_testVec3Vec1BitXorBroadcast, time elapsed: 288100 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1BitXorBroadcast (14800 ns)
    TCS: TestCase_testVec3ShiftLeftVec1, time elapsed: 1338100 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftLeftVec1 (297900 ns)
    TCS: TestCase_testVec3ShiftLeftVec, time elapsed: 336200 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftLeftVec (14900 ns)
    TCS: TestCase_testVec3ShiftRightVec, time elapsed: 274700 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftRightVec (22600 ns)
    TCS: TestCase_testVec3Increment, time elapsed: 283700 ns, RESULT:
    [ PASSED ] CASE: testVec3Increment (17300 ns)
    TCS: TestCase_testVec3Decrement, time elapsed: 523600 ns, RESULT:
    [ PASSED ] CASE: testVec3Decrement (37100 ns)
    TCS: TestCase_testVec3IndexOutOfBoundsAccess, time elapsed: 1493700 ns, RESULT:
    [ PASSED ] CASE: testVec3IndexOutOfBoundsAccess (326600 ns)
    TCS: TestCase_testVec3NegativeIndexAccess, time elapsed: 683900 ns, RESULT:
    [ PASSED ] CASE: testVec3NegativeIndexAccess (74500 ns)
    TCS: TestCase_testVec4ScalarInit, time elapsed: 345000 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarInit (25800 ns)
    TCS: TestCase_testVec4ConstInit, time elapsed: 255400 ns, RESULT:
    [ PASSED ] CASE: testVec4ConstInit (14700 ns)
    TCS: TestCase_testVec4Length, time elapsed: 231700 ns, RESULT:
    [ PASSED ] CASE: testVec4Length (7600 ns)
    TCS: TestCase_testVec4Add, time elapsed: 245000 ns, RESULT:
    [ PASSED ] CASE: testVec4Add (30100 ns)
    TCS: TestCase_testVec4ScalarMul, time elapsed: 242600 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarMul (15100 ns)
    TCS: TestCase_testVec4Negate, time elapsed: 263900 ns, RESULT:
    [ PASSED ] CASE: testVec4Negate (15600 ns)
    TCS: TestCase_testVec4IndexAccess, time elapsed: 242100 ns, RESULT:
    [ PASSED ] CASE: testVec4IndexAccess (16900 ns)
    TCS: TestCase_testVec4IndexMutate, time elapsed: 358200 ns, RESULT:
    [ PASSED ] CASE: testVec4IndexMutate (20300 ns)
    TCS: TestCase_testVec4ComponentAt, time elapsed: 347600 ns, RESULT:
    [ PASSED ] CASE: testVec4ComponentAt (14900 ns)
    TCS: TestCase_testVec4Equal, time elapsed: 421400 ns, RESULT:
    [ PASSED ] CASE: testVec4Equal (26900 ns)
    TCS: TestCase_testVec4NotEqual, time elapsed: 428700 ns, RESULT:
    [ PASSED ] CASE: testVec4NotEqual (37600 ns)
    TCS: TestCase_testVec4EqualExact, time elapsed: 455300 ns, RESULT:
    [ PASSED ] CASE: testVec4EqualExact (35600 ns)
    TCS: TestCase_testVec4BitwiseAnd, time elapsed: 296000 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseAnd (17700 ns)
    TCS: TestCase_testVec4BitwiseNot, time elapsed: 280600 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseNot (10800 ns)
    TCS: TestCase_testVec4Vec1ArithBroadcast, time elapsed: 260800 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1ArithBroadcast (17800 ns)
    TCS: TestCase_testVec4ShiftLeft, time elapsed: 264800 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftLeft (16300 ns)
    TCS: TestCase_testVec4BoolLogicalAnd, time elapsed: 250000 ns, RESULT:
    [ PASSED ] CASE: testVec4BoolLogicalAnd (15800 ns)
    TCS: TestCase_testVec4Sub, time elapsed: 269700 ns, RESULT:
    [ PASSED ] CASE: testVec4Sub (24800 ns)
    TCS: TestCase_testVec4Div, time elapsed: 236200 ns, RESULT:
    [ PASSED ] CASE: testVec4Div (15500 ns)
    TCS: TestCase_testVec4Mod, time elapsed: 240800 ns, RESULT:
    [ PASSED ] CASE: testVec4Mod (15200 ns)
    TCS: TestCase_testVec4ScalarSub, time elapsed: 261100 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarSub (14900 ns)
    TCS: TestCase_testVec4ScalarDiv, time elapsed: 234000 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarDiv (12200 ns)
    TCS: TestCase_testVec4ScalarMod, time elapsed: 254100 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarMod (20300 ns)
    TCS: TestCase_testVec4BoolLogicalOr, time elapsed: 731600 ns, RESULT:
    [ PASSED ] CASE: testVec4BoolLogicalOr (156900 ns)
    TCS: TestCase_testVec4EqualEpsilon, time elapsed: 519000 ns, RESULT:
    [ PASSED ] CASE: testVec4EqualEpsilon (40800 ns)
    TCS: TestCase_testVec4AddNamed, time elapsed: 919400 ns, RESULT:
    [ PASSED ] CASE: testVec4AddNamed (34100 ns)
    TCS: TestCase_testVec4MulNamed, time elapsed: 679200 ns, RESULT:
    [ PASSED ] CASE: testVec4MulNamed (37500 ns)
    TCS: TestCase_testVec4DivNamed, time elapsed: 366600 ns, RESULT:
    [ PASSED ] CASE: testVec4DivNamed (23400 ns)
    TCS: TestCase_testVec4ModNamed, time elapsed: 631000 ns, RESULT:
    [ PASSED ] CASE: testVec4ModNamed (26100 ns)
    TCS: TestCase_testVec4BitwiseOr, time elapsed: 416200 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseOr (35600 ns)
    TCS: TestCase_testVec4BitwiseXor, time elapsed: 443000 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseXor (30300 ns)
    TCS: TestCase_testVec4ScalarBitwiseAnd, time elapsed: 438200 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarBitwiseAnd (26100 ns)
    TCS: TestCase_testVec4ShiftRight, time elapsed: 355300 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftRight (31100 ns)
    TCS: TestCase_testVec4Vec1BitBroadcast, time elapsed: 368600 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1BitBroadcast (16400 ns)
    TCS: TestCase_testVec4ShiftRightVec1, time elapsed: 449900 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftRightVec1 (29700 ns)
    TCS: TestCase_testVec4FromVec1, time elapsed: 250800 ns, RESULT:
    [ PASSED ] CASE: testVec4FromVec1 (13100 ns)
    TCS: TestCase_testVec4ScalarBitwiseOr, time elapsed: 246100 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarBitwiseOr (17100 ns)
    TCS: TestCase_testVec4ScalarBitwiseXor, time elapsed: 535600 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarBitwiseXor (42900 ns)
    TCS: TestCase_testVec4Vec1BitOrBroadcast, time elapsed: 508300 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1BitOrBroadcast (61300 ns)
    TCS: TestCase_testVec4Vec1BitXorBroadcast, time elapsed: 685400 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1BitXorBroadcast (63300 ns)
    TCS: TestCase_testVec4ShiftLeftVec1, time elapsed: 420700 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftLeftVec1 (46300 ns)
    TCS: TestCase_testVec4ShiftLeftVec, time elapsed: 494700 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftLeftVec (42800 ns)
    TCS: TestCase_testVec4ShiftRightVec, time elapsed: 408800 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftRightVec (41000 ns)
    TCS: TestCase_testVec4Increment, time elapsed: 435200 ns, RESULT:
    [ PASSED ] CASE: testVec4Increment (48300 ns)
    TCS: TestCase_testVec4Decrement, time elapsed: 355200 ns, RESULT:
    [ PASSED ] CASE: testVec4Decrement (47500 ns)
    TCS: TestCase_testVec4IndexOutOfBoundsAccess, time elapsed: 437000 ns, RESULT:
    [ PASSED ] CASE: testVec4IndexOutOfBoundsAccess (72200 ns)
    TCS: TestCase_testVec4NegativeIndexAccess, time elapsed: 368700 ns, RESULT:
    [ PASSED ] CASE: testVec4NegativeIndexAccess (43700 ns)
    TCS: TestCase_testFunctor1Vec1Identity, time elapsed: 304500 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec1Identity (12900 ns)
    TCS: TestCase_testFunctor1Vec1Transform, time elapsed: 253100 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec1Transform (11800 ns)
    TCS: TestCase_testFunctor1Vec2Transform, time elapsed: 327100 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec2Transform (21200 ns)
    TCS: TestCase_testFunctor2Vec1Add, time elapsed: 255400 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec1Add (12700 ns)
    TCS: TestCase_testFunctor2VecScaVec1Mul, time elapsed: 307800 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec1Mul (18700 ns)
    TCS: TestCase_testFunctor2VecIntVec1Shift, time elapsed: 241400 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec1Shift (9600 ns)
    TCS: TestCase_testFunctor1Vec3Transform, time elapsed: 502900 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec3Transform (21600 ns)
    TCS: TestCase_testFunctor1Vec4Transform, time elapsed: 456600 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec4Transform (23500 ns)
    TCS: TestCase_testFunctor2Vec2Add, time elapsed: 402600 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec2Add (21800 ns)
    TCS: TestCase_testFunctor2Vec3Add, time elapsed: 410200 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec3Add (22800 ns)
    TCS: TestCase_testFunctor2Vec4Add, time elapsed: 333800 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec4Add (18100 ns)
    TCS: TestCase_testFunctor2VecScaVec2Mul, time elapsed: 257400 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec2Mul (29700 ns)
    TCS: TestCase_testFunctor2VecScaVec3Mul, time elapsed: 235900 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec3Mul (10500 ns)
    TCS: TestCase_testFunctor2VecScaVec4Mul, time elapsed: 230400 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec4Mul (10100 ns)
    TCS: TestCase_testFunctor2VecIntVec2Shift, time elapsed: 286900 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec2Shift (33800 ns)
    TCS: TestCase_testFunctor2VecIntVec3Shift, time elapsed: 229800 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec3Shift (9000 ns)
    TCS: TestCase_testFunctor2VecIntVec4Shift, time elapsed: 203500 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec4Shift (12300 ns)
Summary: TOTAL: 476
    PASSED: 476, SKIPPED: 0, ERROR: 0
    FAILED: 0
--------------------------------------------------------------------------------------------------
Project tests finished, time elapsed: 345509800 ns, RESULT:
TP: glm.*, time elapsed: 345433400 ns, RESULT:
    PASSED:
    TP: glm.detail, time elapsed: 329130000 ns
Summary: TOTAL: 476
    PASSED: 476, SKIPPED: 0, ERROR: 0
    FAILED: 0
--------------------------------------------------------------------------------------------------
cjpm test success
