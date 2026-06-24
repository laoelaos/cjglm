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


[3F7[9999E[2F📦 group glm.detail                  100% [90m[[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[90m[0m[90m][0m [32m✓   [0m (00:00:00)

passed: [32m476[0m, failed: 0            100% [90m[[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m[0m[32m|[0m[90m[0m[90m][0m 476/476 (00:00:00) 8--------------------------------------------------------------------------------------------------
TP: [33mglm.detail[0m, time elapsed: 186567100 ns, RESULT:
    TCS: [33mTestCase_testComputeVecAdd1[0m, time elapsed: 1609200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAdd1 (267900 ns)
    TCS: [33mTestCase_testComputeVecSub2[0m, time elapsed: 553200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub2 (57700 ns)
    TCS: [33mTestCase_testComputeVecMul3[0m, time elapsed: 338000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul3 (30500 ns)
    TCS: [33mTestCase_testComputeVecMod1[0m, time elapsed: 310500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMod1 (30600 ns)
    TCS: [33mTestCase_testComputeVecMod4[0m, time elapsed: 286200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMod4 (25000 ns)
    TCS: [33mTestCase_testComputeVecAnd1[0m, time elapsed: 277200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAnd1 (25800 ns)
    TCS: [33mTestCase_testComputeVecAnd3[0m, time elapsed: 532500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAnd3 (31800 ns)
    TCS: [33mTestCase_testComputeVecOr1[0m, time elapsed: 294100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecOr1 (24500 ns)
    TCS: [33mTestCase_testComputeVecOr2[0m, time elapsed: 283000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecOr2 (19900 ns)
    TCS: [33mTestCase_testComputeVecXor1[0m, time elapsed: 301900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecXor1 (24100 ns)
    TCS: [33mTestCase_testComputeVecXor4[0m, time elapsed: 310500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecXor4 (31800 ns)
    TCS: [33mTestCase_testComputeVecShiftLeft1[0m, time elapsed: 324400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftLeft1 (22700 ns)
    TCS: [33mTestCase_testComputeVecShiftLeft3[0m, time elapsed: 316100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftLeft3 (19600 ns)
    TCS: [33mTestCase_testComputeVecShiftRight1[0m, time elapsed: 313500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftRight1 (14700 ns)
    TCS: [33mTestCase_testComputeVecShiftRight4[0m, time elapsed: 278300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftRight4 (19200 ns)
    TCS: [33mTestCase_testComputeVecEqual1[0m, time elapsed: 290300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual1 (18500 ns)
    TCS: [33mTestCase_testComputeVecNequal4[0m, time elapsed: 281800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal4 (24800 ns)
    TCS: [33mTestCase_testComputeVecBitwiseNot1[0m, time elapsed: 367500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecBitwiseNot1 (35100 ns)
    TCS: [33mTestCase_testComputeVecBitwiseNot3[0m, time elapsed: 296300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecBitwiseNot3 (25200 ns)
    TCS: [33mTestCase_testComputeVecAdd4[0m, time elapsed: 279000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAdd4 (21600 ns)
    TCS: [33mTestCase_testComputeVecSub1[0m, time elapsed: 772900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub1 (20700 ns)
    TCS: [33mTestCase_testComputeVecSub3[0m, time elapsed: 506800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub3 (72800 ns)
    TCS: [33mTestCase_testComputeVecMul1[0m, time elapsed: 380700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul1 (27500 ns)
    TCS: [33mTestCase_testComputeVecMul2[0m, time elapsed: 299500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul2 (21600 ns)
    TCS: [33mTestCase_testComputeVecDiv1[0m, time elapsed: 260900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecDiv1 (20900 ns)
    TCS: [33mTestCase_testComputeVecDiv2[0m, time elapsed: 276900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecDiv2 (17400 ns)
    TCS: [33mTestCase_testComputeVecDiv4[0m, time elapsed: 267400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecDiv4 (29100 ns)
    TCS: [33mTestCase_testComputeVecEqual2[0m, time elapsed: 254100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual2 (14100 ns)
    TCS: [33mTestCase_testComputeVecEqual3[0m, time elapsed: 700800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual3 (33500 ns)
    TCS: [33mTestCase_testComputeVecEqual4[0m, time elapsed: 691700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual4 (50400 ns)
    TCS: [33mTestCase_testComputeVecNequal1[0m, time elapsed: 315900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal1 (20400 ns)
    TCS: [33mTestCase_testComputeVecNequal2[0m, time elapsed: 291600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal2 (18300 ns)
    TCS: [33mTestCase_testComputeVecBitwiseNot4[0m, time elapsed: 276500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecBitwiseNot4 (45400 ns)
    TCS: [33mTestCase_testComputeVecAddFloat32[0m, time elapsed: 274900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAddFloat32 (51600 ns)
    TCS: [33mTestCase_testComputeVecAddFloat32Vec3[0m, time elapsed: 253600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAddFloat32Vec3 (25700 ns)
    TCS: [33mTestCase_testComputeVecSubFloat32[0m, time elapsed: 228800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSubFloat32 (22300 ns)
    TCS: [33mTestCase_testComputeVecSubFloat32Vec4[0m, time elapsed: 230300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSubFloat32Vec4 (22000 ns)
    TCS: [33mTestCase_testComputeEqualInt32Equal[0m, time elapsed: 219300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt32Equal (16100 ns)
    TCS: [33mTestCase_testComputeEqualInt32NotEqual[0m, time elapsed: 230700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt32NotEqual (16800 ns)
    TCS: [33mTestCase_testComputeEqualFloat32Equal[0m, time elapsed: 244900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32Equal (15200 ns)
    TCS: [33mTestCase_testComputeEqualFloat32NotEqual[0m, time elapsed: 256000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32NotEqual (11900 ns)
    TCS: [33mTestCase_testComputeEqualFloat64Equal[0m, time elapsed: 230900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64Equal (10800 ns)
    TCS: [33mTestCase_testComputeEqualFloat64NotEqual[0m, time elapsed: 258900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64NotEqual (12100 ns)
    TCS: [33mTestCase_testComputeEqualBoolEqual[0m, time elapsed: 240700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualBoolEqual (16200 ns)
    TCS: [33mTestCase_testComputeEqualBoolNotEqual[0m, time elapsed: 262900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualBoolNotEqual (22000 ns)
    TCS: [33mTestCase_testComputeEqualNumericInt32[0m, time elapsed: 243100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericInt32 (11900 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32[0m, time elapsed: 272800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32 (43900 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32Epsilon[0m, time elapsed: 234400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32Epsilon (10900 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64[0m, time elapsed: 243500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64 (13200 ns)
    TCS: [33mTestCase_testComputeEqualInt64Equal[0m, time elapsed: 231400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt64Equal (10300 ns)
    TCS: [33mTestCase_testComputeEqualInt64NotEqual[0m, time elapsed: 231800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt64NotEqual (9100 ns)
    TCS: [33mTestCase_testComputeEqualFloat32Nan[0m, time elapsed: 241500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32Nan (10900 ns)
    TCS: [33mTestCase_testComputeEqualFloat64Nan[0m, time elapsed: 237100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64Nan (10000 ns)
    TCS: [33mTestCase_testComputeEqualFloat32SignedZero[0m, time elapsed: 236800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32SignedZero (9700 ns)
    TCS: [33mTestCase_testComputeEqualFloat64SignedZero[0m, time elapsed: 236800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64SignedZero (8800 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32NotEqual[0m, time elapsed: 233900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32NotEqual (11500 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32BeyondEpsilon[0m, time elapsed: 230300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32BeyondEpsilon (10300 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64NotEqual[0m, time elapsed: 236600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64NotEqual (12900 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64Epsilon[0m, time elapsed: 260500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64Epsilon (11000 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64BeyondEpsilon[0m, time elapsed: 270200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64BeyondEpsilon (35000 ns)
    TCS: [33mTestCase_testComputeEqualNumericInt64[0m, time elapsed: 229500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericInt64 (10500 ns)
    TCS: [33mTestCase_testPackedHighpImplementsQualifier[0m, time elapsed: 221700 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedHighpImplementsQualifier (9400 ns)
    TCS: [33mTestCase_testPackedMediumpImplementsQualifier[0m, time elapsed: 223100 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedMediumpImplementsQualifier (10000 ns)
    TCS: [33mTestCase_testPackedLowpImplementsQualifier[0m, time elapsed: 231800 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedLowpImplementsQualifier (9700 ns)
    TCS: [33mTestCase_testDefaultpIsPackedHighp[0m, time elapsed: 244200 ns, RESULT:
    [[32m PASSED [0m] CASE: testDefaultpIsPackedHighp (9200 ns)
    TCS: [33mTestCase_testScalarAddVec1[0m, time elapsed: 270700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec1 (32300 ns)
    TCS: [33mTestCase_testScalarAddVec2[0m, time elapsed: 315100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec2 (15700 ns)
    TCS: [33mTestCase_testScalarAddVec3[0m, time elapsed: 265900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec3 (26100 ns)
    TCS: [33mTestCase_testScalarAddVec4[0m, time elapsed: 275900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec4 (25900 ns)
    TCS: [33mTestCase_testScalarSubVec1[0m, time elapsed: 258900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1 (16800 ns)
    TCS: [33mTestCase_testScalarMulVec1[0m, time elapsed: 312000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1 (23000 ns)
    TCS: [33mTestCase_testScalarDivVec1[0m, time elapsed: 291700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1 (15400 ns)
    TCS: [33mTestCase_testScalarModVec1[0m, time elapsed: 231200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1 (14600 ns)
    TCS: [33mTestCase_testScalarMulVec2[0m, time elapsed: 325900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2 (26400 ns)
    TCS: [33mTestCase_testScalarSubVec2[0m, time elapsed: 317900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2 (16200 ns)
    TCS: [33mTestCase_testScalarSubVec3[0m, time elapsed: 271300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3 (19500 ns)
    TCS: [33mTestCase_testScalarSubVec4[0m, time elapsed: 247600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4 (21200 ns)
    TCS: [33mTestCase_testScalarMulVec3[0m, time elapsed: 233100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3 (13000 ns)
    TCS: [33mTestCase_testScalarMulVec4[0m, time elapsed: 241300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4 (22600 ns)
    TCS: [33mTestCase_testScalarDivVec2[0m, time elapsed: 251400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2 (14700 ns)
    TCS: [33mTestCase_testScalarDivVec3[0m, time elapsed: 234500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3 (10600 ns)
    TCS: [33mTestCase_testScalarDivVec4[0m, time elapsed: 270100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4 (21300 ns)
    TCS: [33mTestCase_testScalarModVec2[0m, time elapsed: 275700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2 (11900 ns)
    TCS: [33mTestCase_testScalarModVec3[0m, time elapsed: 303100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3 (25700 ns)
    TCS: [33mTestCase_testScalarModVec4[0m, time elapsed: 280400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4 (17800 ns)
    TCS: [33mTestCase_testScalarModVec1Float32[0m, time elapsed: 265400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float32 (32100 ns)
    TCS: [33mTestCase_testScalarModVec2Float32[0m, time elapsed: 270100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32 (11400 ns)
    TCS: [33mTestCase_testScalarModVec3Float32[0m, time elapsed: 308600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float32 (22400 ns)
    TCS: [33mTestCase_testScalarModVec4Float32[0m, time elapsed: 318800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float32 (20800 ns)
    TCS: [33mTestCase_testScalarModVec1Float64[0m, time elapsed: 349100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float64 (17700 ns)
    TCS: [33mTestCase_testScalarModVec2Float64[0m, time elapsed: 282100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float64 (14400 ns)
    TCS: [33mTestCase_testScalarModVec3Float64[0m, time elapsed: 262200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float64 (12300 ns)
    TCS: [33mTestCase_testScalarModVec4Float64[0m, time elapsed: 245500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float64 (16700 ns)
    TCS: [33mTestCase_testScalarModVec1Float16[0m, time elapsed: 274700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float16 (41100 ns)
    TCS: [33mTestCase_testScalarModVec2Float16[0m, time elapsed: 295100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float16 (13700 ns)
    TCS: [33mTestCase_testScalarModVec3Float16[0m, time elapsed: 237700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float16 (11300 ns)
    TCS: [33mTestCase_testScalarModVec4Float16[0m, time elapsed: 326500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float16 (15200 ns)
    TCS: [33mTestCase_testScalarSubVec2PackedMediump[0m, time elapsed: 305400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2PackedMediump (18000 ns)
    TCS: [33mTestCase_testScalarSubVec2PackedLowp[0m, time elapsed: 231800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2PackedLowp (12600 ns)
    TCS: [33mTestCase_testScalarMulVec2PackedMediump[0m, time elapsed: 260600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2PackedMediump (12600 ns)
    TCS: [33mTestCase_testScalarMulVec2PackedLowp[0m, time elapsed: 226500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2PackedLowp (13300 ns)
    TCS: [33mTestCase_testScalarDivVec2PackedMediump[0m, time elapsed: 230800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2PackedMediump (12000 ns)
    TCS: [33mTestCase_testScalarDivVec2PackedLowp[0m, time elapsed: 257400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2PackedLowp (11500 ns)
    TCS: [33mTestCase_testScalarModVec2PackedMediump[0m, time elapsed: 234100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2PackedMediump (12500 ns)
    TCS: [33mTestCase_testScalarModVec2PackedLowp[0m, time elapsed: 225400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2PackedLowp (9300 ns)
    TCS: [33mTestCase_testScalarModVec2Float32PackedMediump[0m, time elapsed: 307000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32PackedMediump (13000 ns)
    TCS: [33mTestCase_testScalarModVec2Float32PackedLowp[0m, time elapsed: 224800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32PackedLowp (9700 ns)
    TCS: [33mTestCase_testScalarModVec2Float32NegativeDividend[0m, time elapsed: 234500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32NegativeDividend (10200 ns)
    TCS: [33mTestCase_testScalarModVec2Float32NegativeDivisor[0m, time elapsed: 249300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32NegativeDivisor (12800 ns)
    TCS: [33mTestCase_testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents[0m, time elapsed: 500200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents (250100 ns)
    TCS: [33mTestCase_testScalarAddVec1Float32[0m, time elapsed: 357900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec1Float32 (16800 ns)
    TCS: [33mTestCase_testScalarAddVec2Float32[0m, time elapsed: 330000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec2Float32 (22800 ns)
    TCS: [33mTestCase_testScalarAddVec3Float32[0m, time elapsed: 252100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec3Float32 (15400 ns)
    TCS: [33mTestCase_testScalarAddVec4Float32[0m, time elapsed: 271300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec4Float32 (13800 ns)
    TCS: [33mTestCase_testScalarSubVec1Float32[0m, time elapsed: 300700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1Float32 (24700 ns)
    TCS: [33mTestCase_testScalarSubVec2Float32[0m, time elapsed: 251900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2Float32 (12400 ns)
    TCS: [33mTestCase_testScalarSubVec3Float32[0m, time elapsed: 227500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3Float32 (10900 ns)
    TCS: [33mTestCase_testScalarSubVec4Float32[0m, time elapsed: 1588000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4Float32 (117400 ns)
    TCS: [33mTestCase_testScalarMulVec1Float32[0m, time elapsed: 235100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1Float32 (11000 ns)
    TCS: [33mTestCase_testScalarMulVec2Float32[0m, time elapsed: 244500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2Float32 (14000 ns)
    TCS: [33mTestCase_testScalarMulVec3Float32[0m, time elapsed: 229500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3Float32 (17200 ns)
    TCS: [33mTestCase_testScalarMulVec4Float32[0m, time elapsed: 247300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4Float32 (11600 ns)
    TCS: [33mTestCase_testScalarDivVec1Float32[0m, time elapsed: 227300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1Float32 (10300 ns)
    TCS: [33mTestCase_testScalarDivVec2Float32[0m, time elapsed: 240500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2Float32 (10000 ns)
    TCS: [33mTestCase_testScalarDivVec3Float32[0m, time elapsed: 227400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3Float32 (16600 ns)
    TCS: [33mTestCase_testScalarDivVec4Float32[0m, time elapsed: 221000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4Float32 (9800 ns)
    TCS: [33mTestCase_testScalarAddVec1Int32[0m, time elapsed: 270500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec1Int32 (24100 ns)
    TCS: [33mTestCase_testScalarAddVec2Int32[0m, time elapsed: 243000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec2Int32 (12900 ns)
    TCS: [33mTestCase_testScalarAddVec3Int32[0m, time elapsed: 270200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec3Int32 (13000 ns)
    TCS: [33mTestCase_testScalarAddVec4Int32[0m, time elapsed: 241400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec4Int32 (16500 ns)
    TCS: [33mTestCase_testScalarSubVec1Int32[0m, time elapsed: 270900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1Int32 (27200 ns)
    TCS: [33mTestCase_testScalarSubVec2Int32[0m, time elapsed: 281900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2Int32 (18900 ns)
    TCS: [33mTestCase_testScalarSubVec3Int32[0m, time elapsed: 249900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3Int32 (11500 ns)
    TCS: [33mTestCase_testScalarSubVec4Int32[0m, time elapsed: 236900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4Int32 (12000 ns)
    TCS: [33mTestCase_testScalarMulVec1Int32[0m, time elapsed: 235200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1Int32 (9000 ns)
    TCS: [33mTestCase_testScalarMulVec2Int32[0m, time elapsed: 226000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2Int32 (13100 ns)
    TCS: [33mTestCase_testScalarMulVec3Int32[0m, time elapsed: 223900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3Int32 (10300 ns)
    TCS: [33mTestCase_testScalarMulVec4Int32[0m, time elapsed: 232300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4Int32 (10400 ns)
    TCS: [33mTestCase_testScalarDivVec1Int32[0m, time elapsed: 244200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1Int32 (9800 ns)
    TCS: [33mTestCase_testScalarDivVec2Int32[0m, time elapsed: 234100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2Int32 (10700 ns)
    TCS: [33mTestCase_testScalarDivVec3Int32[0m, time elapsed: 242200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3Int32 (10800 ns)
    TCS: [33mTestCase_testScalarDivVec4Int32[0m, time elapsed: 232700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4Int32 (18600 ns)
    TCS: [33mTestCase_testScalarModVec1Int32[0m, time elapsed: 225800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Int32 (11700 ns)
    TCS: [33mTestCase_testScalarModVec2Int32[0m, time elapsed: 231700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Int32 (9500 ns)
    TCS: [33mTestCase_testScalarModVec3Int32[0m, time elapsed: 236000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Int32 (9900 ns)
    TCS: [33mTestCase_testScalarModVec4Int32[0m, time elapsed: 238000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Int32 (12100 ns)
    TCS: [33mTestCase_testScalarSubVec1PackedMediump[0m, time elapsed: 239900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1PackedMediump (17300 ns)
    TCS: [33mTestCase_testScalarSubVec1PackedLowp[0m, time elapsed: 234500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1PackedLowp (12200 ns)
    TCS: [33mTestCase_testScalarSubVec3PackedMediump[0m, time elapsed: 258800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3PackedMediump (20700 ns)
    TCS: [33mTestCase_testScalarSubVec3PackedLowp[0m, time elapsed: 439200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3PackedLowp (12100 ns)
    TCS: [33mTestCase_testScalarSubVec4PackedMediump[0m, time elapsed: 401700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4PackedMediump (30100 ns)
    TCS: [33mTestCase_testScalarSubVec4PackedLowp[0m, time elapsed: 543300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4PackedLowp (28300 ns)
    TCS: [33mTestCase_testScalarMulVec1PackedMediump[0m, time elapsed: 391300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1PackedMediump (23500 ns)
    TCS: [33mTestCase_testScalarMulVec1PackedLowp[0m, time elapsed: 345800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1PackedLowp (31200 ns)
    TCS: [33mTestCase_testScalarMulVec3PackedMediump[0m, time elapsed: 264400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3PackedMediump (16100 ns)
    TCS: [33mTestCase_testScalarMulVec3PackedLowp[0m, time elapsed: 266900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3PackedLowp (13200 ns)
    TCS: [33mTestCase_testScalarMulVec4PackedMediump[0m, time elapsed: 236100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4PackedMediump (12000 ns)
    TCS: [33mTestCase_testScalarMulVec4PackedLowp[0m, time elapsed: 230600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4PackedLowp (13500 ns)
    TCS: [33mTestCase_testScalarDivVec1PackedMediump[0m, time elapsed: 556600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1PackedMediump (42500 ns)
    TCS: [33mTestCase_testScalarDivVec1PackedLowp[0m, time elapsed: 464400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1PackedLowp (22500 ns)
    TCS: [33mTestCase_testScalarDivVec3PackedMediump[0m, time elapsed: 257000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3PackedMediump (15300 ns)
    TCS: [33mTestCase_testScalarDivVec3PackedLowp[0m, time elapsed: 236800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3PackedLowp (12600 ns)
    TCS: [33mTestCase_testScalarDivVec4PackedMediump[0m, time elapsed: 236200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4PackedMediump (19700 ns)
    TCS: [33mTestCase_testScalarDivVec4PackedLowp[0m, time elapsed: 260600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4PackedLowp (12800 ns)
    TCS: [33mTestCase_testScalarModVec1PackedMediump[0m, time elapsed: 232900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1PackedMediump (11600 ns)
    TCS: [33mTestCase_testScalarModVec1PackedLowp[0m, time elapsed: 234800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1PackedLowp (10100 ns)
    TCS: [33mTestCase_testScalarModVec3PackedMediump[0m, time elapsed: 238100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3PackedMediump (11100 ns)
    TCS: [33mTestCase_testScalarModVec3PackedLowp[0m, time elapsed: 261800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3PackedLowp (11600 ns)
    TCS: [33mTestCase_testScalarModVec4PackedMediump[0m, time elapsed: 335100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4PackedMediump (16800 ns)
    TCS: [33mTestCase_testScalarModVec4PackedLowp[0m, time elapsed: 268300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4PackedLowp (13800 ns)
    TCS: [33mTestCase_testScalarDivZeroVec1[0m, time elapsed: 307800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivZeroVec1 (20700 ns)
    TCS: [33mTestCase_testScalarAddNegVec1[0m, time elapsed: 253800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddNegVec1 (21900 ns)
    TCS: [33mTestCase_testScalarAddNegVec2[0m, time elapsed: 251500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddNegVec2 (13200 ns)
    TCS: [33mTestCase_testScalarMulOverflowVec1[0m, time elapsed: 264600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulOverflowVec1 (15800 ns)
    TCS: [33mTestCase_testScalarSubNegVec1[0m, time elapsed: 245900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubNegVec1 (13200 ns)
    TCS: [33mTestCase_testVersionMajor[0m, time elapsed: 341500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionMajor (23400 ns)
    TCS: [33mTestCase_testVersionMinor[0m, time elapsed: 239400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionMinor (8200 ns)
    TCS: [33mTestCase_testVersionPatch[0m, time elapsed: 227400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionPatch (9800 ns)
    TCS: [33mTestCase_testVersionEncoded[0m, time elapsed: 237000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionEncoded (12700 ns)
    TCS: [33mTestCase_testConfigSimd[0m, time elapsed: 240700 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigSimd (16600 ns)
    TCS: [33mTestCase_testConfigAlignedGentypes[0m, time elapsed: 238300 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigAlignedGentypes (9100 ns)
    TCS: [33mTestCase_testConfigClipControl[0m, time elapsed: 254300 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigClipControl (9400 ns)
    TCS: [33mTestCase_testConstNegationSimd[0m, time elapsed: 239300 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationSimd (10200 ns)
    TCS: [33mTestCase_testConstNegationAligned[0m, time elapsed: 239500 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationAligned (8500 ns)
    TCS: [33mTestCase_testConstNegationClip[0m, time elapsed: 240200 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationClip (9200 ns)
    TCS: [33mTestCase_testConstInt64Usage[0m, time elapsed: 240500 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstInt64Usage (17500 ns)
    TCS: [33mTestCase_testConstBoolUsage[0m, time elapsed: 229800 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstBoolUsage (9300 ns)
    TCS: [33mTestCase_testVersionEncodingConsistency[0m, time elapsed: 355400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionEncodingConsistency (15700 ns)
    TCS: [33mTestCase_testAssertPasses[0m, time elapsed: 322700 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertPasses (38300 ns)
    TCS: [33mTestCase_testAssertFails[0m, time elapsed: 398700 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertFails (101300 ns)
    TCS: [33mTestCase_testAssertWithCustomMessage[0m, time elapsed: 420800 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertWithCustomMessage (75300 ns)
    TCS: [33mTestCase_testNumericLimitsFloat32Epsilon[0m, time elapsed: 288700 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsFloat32Epsilon (19300 ns)
    TCS: [33mTestCase_testNumericLimitsFloat64Epsilon[0m, time elapsed: 298500 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsFloat64Epsilon (15100 ns)
    TCS: [33mTestCase_testIsIec559OfFloat32[0m, time elapsed: 284500 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfFloat32 (16700 ns)
    TCS: [33mTestCase_testIsIec559OfFloat64[0m, time elapsed: 273800 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfFloat64 (11500 ns)
    TCS: [33mTestCase_testIsIec559OfInt64[0m, time elapsed: 282900 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfInt64 (40600 ns)
    TCS: [33mTestCase_testEpsilonOfFloat32[0m, time elapsed: 261400 ns, RESULT:
    [[32m PASSED [0m] CASE: testEpsilonOfFloat32 (21100 ns)
    TCS: [33mTestCase_testEpsilonOfFloat64[0m, time elapsed: 255100 ns, RESULT:
    [[32m PASSED [0m] CASE: testEpsilonOfFloat64 (14200 ns)
    TCS: [33mTestCase_testNumericLimitsInt64Epsilon[0m, time elapsed: 248100 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt64Epsilon (13800 ns)
    TCS: [33mTestCase_testNumericLimitsInt32Epsilon[0m, time elapsed: 253700 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt32Epsilon (15100 ns)
    TCS: [33mTestCase_testNumericLimitsInt16Epsilon[0m, time elapsed: 288900 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt16Epsilon (20500 ns)
    TCS: [33mTestCase_testNumericLimitsInt8Epsilon[0m, time elapsed: 370700 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt8Epsilon (39000 ns)
    TCS: [33mTestCase_testCastVec1ToVec1IntToFloat[0m, time elapsed: 357400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec1ToVec1IntToFloat (37000 ns)
    TCS: [33mTestCase_testCastVec2ToVec1TakesOnlyX[0m, time elapsed: 333900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2ToVec1TakesOnlyX (31500 ns)
    TCS: [33mTestCase_testCastVec3ToVec1TakesOnlyX[0m, time elapsed: 348900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3ToVec1TakesOnlyX (32900 ns)
    TCS: [33mTestCase_testCastVec4ToVec1TakesOnlyX[0m, time elapsed: 358100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4ToVec1TakesOnlyX (29000 ns)
    TCS: [33mTestCase_testCastSameTypeIdentity[0m, time elapsed: 587600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastSameTypeIdentity (101300 ns)
    TCS: [33mTestCase_testCastInt32ToInt64[0m, time elapsed: 554200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastInt32ToInt64 (20100 ns)
    TCS: [33mTestCase_testCastFloatToIntTruncation[0m, time elapsed: 297600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastFloatToIntTruncation (12700 ns)
    TCS: [33mTestCase_testCastCrossQualifierPackedHighpToDefaultp[0m, time elapsed: 287200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastCrossQualifierPackedHighpToDefaultp (11200 ns)
    TCS: [33mTestCase_testCastCrossQualifierDefaultpToPackedHighp[0m, time elapsed: 282300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastCrossQualifierDefaultpToPackedHighp (19500 ns)
    TCS: [33mTestCase_testCastVec2CrossQualifierCrossType[0m, time elapsed: 285800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2CrossQualifierCrossType (13600 ns)
    TCS: [33mTestCase_testCastVec3CrossQualifier[0m, time elapsed: 245700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3CrossQualifier (11700 ns)
    TCS: [33mTestCase_testCastVec4CrossQualifier[0m, time elapsed: 280700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4CrossQualifier (35000 ns)
    TCS: [33mTestCase_testCastVec1DoesNotModifySource[0m, time elapsed: 271400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec1DoesNotModifySource (12200 ns)
    TCS: [33mTestCase_testCastVec2Vec1ToVec2IntToFloat[0m, time elapsed: 275700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec1ToVec2IntToFloat (9700 ns)
    TCS: [33mTestCase_testCastVec2Vec2ToVec2Identity[0m, time elapsed: 249100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec2ToVec2Identity (22500 ns)
    TCS: [33mTestCase_testCastVec2Vec3ToVec2TakesOnlyXY[0m, time elapsed: 215300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec3ToVec2TakesOnlyXY (10000 ns)
    TCS: [33mTestCase_testCastVec2Vec4ToVec2TakesOnlyXY[0m, time elapsed: 205100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec4ToVec2TakesOnlyXY (10000 ns)
    TCS: [33mTestCase_testCastVec2SameTypeIdentity[0m, time elapsed: 222800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2SameTypeIdentity (7000 ns)
    TCS: [33mTestCase_testCastVec2Int32ToInt64[0m, time elapsed: 211600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Int32ToInt64 (8000 ns)
    TCS: [33mTestCase_testCastVec2FloatToIntTruncation[0m, time elapsed: 301200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2FloatToIntTruncation (11300 ns)
    TCS: [33mTestCase_testCastVec2CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 348900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2CrossQualifierPackedHighpToDefaultp (13800 ns)
    TCS: [33mTestCase_testCastVec2DoesNotModifySource[0m, time elapsed: 240600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2DoesNotModifySource (13900 ns)
    TCS: [33mTestCase_testCastVec2Vec1ToVec2SameValueBothComponents[0m, time elapsed: 229100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec1ToVec2SameValueBothComponents (7800 ns)
    TCS: [33mTestCase_testCastVec3Vec1ToVec3IntToFloat[0m, time elapsed: 234300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec1ToVec3IntToFloat (20100 ns)
    TCS: [33mTestCase_testCastVec3Vec2ToVec3ExtendY[0m, time elapsed: 220300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec2ToVec3ExtendY (9600 ns)
    TCS: [33mTestCase_testCastVec3Vec3ToVec3Identity[0m, time elapsed: 207800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec3ToVec3Identity (11900 ns)
    TCS: [33mTestCase_testCastVec3Vec4ToVec3TakesOnlyXYZ[0m, time elapsed: 352300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec4ToVec3TakesOnlyXYZ (27500 ns)
    TCS: [33mTestCase_testCastVec3SameTypeIdentity[0m, time elapsed: 291700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3SameTypeIdentity (46400 ns)
    TCS: [33mTestCase_testCastVec3Int32ToInt64[0m, time elapsed: 228300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Int32ToInt64 (10000 ns)
    TCS: [33mTestCase_testCastVec3FloatToIntTruncation[0m, time elapsed: 420900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3FloatToIntTruncation (19200 ns)
    TCS: [33mTestCase_testCastVec3CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 235700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3CrossQualifierPackedHighpToDefaultp (8400 ns)
    TCS: [33mTestCase_testCastVec3DoesNotModifySource[0m, time elapsed: 199900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3DoesNotModifySource (7300 ns)
    TCS: [33mTestCase_testCastVec3Vec1ToVec3SameValueAllComponents[0m, time elapsed: 212000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec1ToVec3SameValueAllComponents (8200 ns)
    TCS: [33mTestCase_testCastVec4Vec1ToVec4IntToFloat[0m, time elapsed: 211000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec1ToVec4IntToFloat (11100 ns)
    TCS: [33mTestCase_testCastVec4Vec2ToVec4ExtendY[0m, time elapsed: 344800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec2ToVec4ExtendY (20200 ns)
    TCS: [33mTestCase_testCastVec4Vec3ToVec4ExtendZ[0m, time elapsed: 216900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec3ToVec4ExtendZ (11700 ns)
    TCS: [33mTestCase_testCastVec4Vec4ToVec4Identity[0m, time elapsed: 218900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec4ToVec4Identity (11900 ns)
    TCS: [33mTestCase_testCastVec4SameTypeIdentity[0m, time elapsed: 225000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4SameTypeIdentity (11800 ns)
    TCS: [33mTestCase_testCastVec4Int32ToInt64[0m, time elapsed: 219100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Int32ToInt64 (8900 ns)
    TCS: [33mTestCase_testCastVec4FloatToIntTruncation[0m, time elapsed: 261600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4FloatToIntTruncation (8600 ns)
    TCS: [33mTestCase_testCastVec4CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 232200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4CrossQualifierPackedHighpToDefaultp (8700 ns)
    TCS: [33mTestCase_testCastVec4DoesNotModifySource[0m, time elapsed: 228800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4DoesNotModifySource (7800 ns)
    TCS: [33mTestCase_testCastVec4Vec1ToVec4SameValueAllComponents[0m, time elapsed: 330100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec1ToVec4SameValueAllComponents (17200 ns)
    TCS: [33mTestCase_testFromBoolVec1[0m, time elapsed: 321900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec1 (12200 ns)
    TCS: [33mTestCase_testFromBoolVec1False[0m, time elapsed: 239100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec1False (7700 ns)
    TCS: [33mTestCase_testFromBoolVec2[0m, time elapsed: 229700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec2 (10600 ns)
    TCS: [33mTestCase_testFromBoolVec3[0m, time elapsed: 225600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec3 (13600 ns)
    TCS: [33mTestCase_testFromBoolVec4[0m, time elapsed: 588900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec4 (55800 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec1[0m, time elapsed: 243700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec1 (14100 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec2[0m, time elapsed: 234900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec2 (9300 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec3[0m, time elapsed: 227100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec3 (17000 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec4[0m, time elapsed: 236800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec4 (15600 ns)
    TCS: [33mTestCase_testFromBoolVec3AllFalse[0m, time elapsed: 237400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec3AllFalse (8000 ns)
    TCS: [33mTestCase_testFromBoolVec4AllFalse[0m, time elapsed: 237800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec4AllFalse (7000 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec3AllFalse[0m, time elapsed: 207500 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec3AllFalse (7000 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec4AllFalse[0m, time elapsed: 209200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec4AllFalse (6600 ns)
    TCS: [33mTestCase_testFromBoolVecFloat32[0m, time elapsed: 201800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecFloat32 (8800 ns)
    TCS: [33mTestCase_testFromBoolVecFloat64[0m, time elapsed: 205100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecFloat64 (8600 ns)
    TCS: [33mTestCase_testFromBoolVecInt32[0m, time elapsed: 219700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecInt32 (9600 ns)
    TCS: [33mTestCase_testFromBoolVecQ2PackedMediump[0m, time elapsed: 203600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2PackedMediump (7700 ns)
    TCS: [33mTestCase_testFromBoolVecQ2PackedLowp[0m, time elapsed: 200600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2PackedLowp (6600 ns)
    TCS: [33mTestCase_testVec1ConstInit[0m, time elapsed: 310600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ConstInit (12500 ns)
    TCS: [33mTestCase_testVec1Length[0m, time elapsed: 274800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Length (15600 ns)
    TCS: [33mTestCase_testVec1IndexAccess[0m, time elapsed: 249900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1IndexAccess (13500 ns)
    TCS: [33mTestCase_testVec1IndexMutate[0m, time elapsed: 233100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1IndexMutate (7500 ns)
    TCS: [33mTestCase_testVec1ComponentAt[0m, time elapsed: 220000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ComponentAt (11900 ns)
    TCS: [33mTestCase_testVec1Add[0m, time elapsed: 306000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Add (33100 ns)
    TCS: [33mTestCase_testVec1Sub[0m, time elapsed: 267800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Sub (20800 ns)
    TCS: [33mTestCase_testVec1Mul[0m, time elapsed: 229100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Mul (14700 ns)
    TCS: [33mTestCase_testVec1Div[0m, time elapsed: 225200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Div (13100 ns)
    TCS: [33mTestCase_testVec1Mod[0m, time elapsed: 270700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Mod (20000 ns)
    TCS: [33mTestCase_testVec1ScalarAdd[0m, time elapsed: 223600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarAdd (12700 ns)
    TCS: [33mTestCase_testVec1Negate[0m, time elapsed: 279300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Negate (13400 ns)
    TCS: [33mTestCase_testVec1AddNamed[0m, time elapsed: 253800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1AddNamed (18000 ns)
    TCS: [33mTestCase_testVec1SubNamed[0m, time elapsed: 270000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1SubNamed (18300 ns)
    TCS: [33mTestCase_testVec1MulNamed[0m, time elapsed: 232000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1MulNamed (8400 ns)
    TCS: [33mTestCase_testVec1Equal[0m, time elapsed: 261600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Equal (37900 ns)
    TCS: [33mTestCase_testVec1NotEqual[0m, time elapsed: 210400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1NotEqual (8600 ns)
    TCS: [33mTestCase_testVec1EqualExact[0m, time elapsed: 211000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1EqualExact (7600 ns)
    TCS: [33mTestCase_testVec1BitwiseAnd[0m, time elapsed: 231000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BitwiseAnd (13300 ns)
    TCS: [33mTestCase_testVec1BitwiseOr[0m, time elapsed: 222200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BitwiseOr (15200 ns)
    TCS: [33mTestCase_testVec1BitwiseXor[0m, time elapsed: 209600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BitwiseXor (11000 ns)
    TCS: [33mTestCase_testVec1ShiftLeft[0m, time elapsed: 226300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ShiftLeft (14800 ns)
    TCS: [33mTestCase_testVec1ShiftRight[0m, time elapsed: 221500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ShiftRight (11100 ns)
    TCS: [33mTestCase_testVec1BitwiseNot[0m, time elapsed: 217700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BitwiseNot (7500 ns)
    TCS: [33mTestCase_testVec1BoolLogicalAnd[0m, time elapsed: 220100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BoolLogicalAnd (12100 ns)
    TCS: [33mTestCase_testVec1BoolLogicalOr[0m, time elapsed: 251300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BoolLogicalOr (8600 ns)
    TCS: [33mTestCase_testVec1IndexOutOfBoundsAccess[0m, time elapsed: 413300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1IndexOutOfBoundsAccess (88400 ns)
    TCS: [33mTestCase_testVec1ShiftVec[0m, time elapsed: 256700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ShiftVec (9000 ns)
    TCS: [33mTestCase_testVec1ScalarSub[0m, time elapsed: 227000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarSub (8300 ns)
    TCS: [33mTestCase_testVec1ScalarMul[0m, time elapsed: 212200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarMul (7300 ns)
    TCS: [33mTestCase_testVec1ScalarDiv[0m, time elapsed: 232200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarDiv (7400 ns)
    TCS: [33mTestCase_testVec1ScalarMod[0m, time elapsed: 239400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarMod (10900 ns)
    TCS: [33mTestCase_testVec1DivNamed[0m, time elapsed: 225800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1DivNamed (7800 ns)
    TCS: [33mTestCase_testVec1ModNamed[0m, time elapsed: 277300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ModNamed (7300 ns)
    TCS: [33mTestCase_testVec1ScalarBitwiseAnd[0m, time elapsed: 256300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarBitwiseAnd (18100 ns)
    TCS: [33mTestCase_testVec1ScalarBitwiseOr[0m, time elapsed: 328500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarBitwiseOr (18000 ns)
    TCS: [33mTestCase_testVec1ScalarBitwiseXor[0m, time elapsed: 224800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarBitwiseXor (8300 ns)
    TCS: [33mTestCase_testVec1ShiftRightVec[0m, time elapsed: 228700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ShiftRightVec (7300 ns)
    TCS: [33mTestCase_testVec1EqualEpsilon[0m, time elapsed: 225100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1EqualEpsilon (17000 ns)
    TCS: [33mTestCase_testVec1BroadcastAddVec2[0m, time elapsed: 241000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastAddVec2 (18400 ns)
    TCS: [33mTestCase_testVec1BroadcastBitAndVec2[0m, time elapsed: 322700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastBitAndVec2 (15000 ns)
    TCS: [33mTestCase_testVec1BroadcastAddVec3[0m, time elapsed: 244900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastAddVec3 (24500 ns)
    TCS: [33mTestCase_testVec1BroadcastAddVec4[0m, time elapsed: 252800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastAddVec4 (25000 ns)
    TCS: [33mTestCase_testVec1BroadcastBitOrVec2[0m, time elapsed: 246300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastBitOrVec2 (11700 ns)
    TCS: [33mTestCase_testVec1BroadcastBitXorVec2[0m, time elapsed: 323800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastBitXorVec2 (18100 ns)
    TCS: [33mTestCase_testVec1BroadcastShiftLeftVec2[0m, time elapsed: 332700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastShiftLeftVec2 (16800 ns)
    TCS: [33mTestCase_testVec1BroadcastShiftRightVec2[0m, time elapsed: 271500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastShiftRightVec2 (16700 ns)
    TCS: [33mTestCase_testVec1BroadcastBitAndVec3[0m, time elapsed: 259300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastBitAndVec3 (17300 ns)
    TCS: [33mTestCase_testVec1BroadcastBitAndVec4[0m, time elapsed: 276300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastBitAndVec4 (35000 ns)
    TCS: [33mTestCase_testVec1BroadcastModVec2[0m, time elapsed: 294600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastModVec2 (17800 ns)
    TCS: [33mTestCase_testVec1BroadcastModVec3[0m, time elapsed: 240400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastModVec3 (16100 ns)
    TCS: [33mTestCase_testVec1BroadcastModVec4[0m, time elapsed: 231600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastModVec4 (15700 ns)
    TCS: [33mTestCase_testVec1Increment[0m, time elapsed: 215500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Increment (13200 ns)
    TCS: [33mTestCase_testVec1Decrement[0m, time elapsed: 200700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Decrement (11900 ns)
    TCS: [33mTestCase_testVec2ScalarInit[0m, time elapsed: 217600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarInit (14100 ns)
    TCS: [33mTestCase_testVec2ConstInit[0m, time elapsed: 222800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ConstInit (11500 ns)
    TCS: [33mTestCase_testVec2Length[0m, time elapsed: 236100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Length (11300 ns)
    TCS: [33mTestCase_testVec2Add[0m, time elapsed: 272800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Add (30300 ns)
    TCS: [33mTestCase_testVec2Sub[0m, time elapsed: 254600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Sub (19000 ns)
    TCS: [33mTestCase_testVec2Mul[0m, time elapsed: 241800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Mul (20600 ns)
    TCS: [33mTestCase_testVec2ScalarAdd[0m, time elapsed: 220800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarAdd (14500 ns)
    TCS: [33mTestCase_testVec2Negate[0m, time elapsed: 235900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Negate (21800 ns)
    TCS: [33mTestCase_testVec2IndexAccess[0m, time elapsed: 196500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2IndexAccess (7200 ns)
    TCS: [33mTestCase_testVec2IndexMutate[0m, time elapsed: 221200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2IndexMutate (10900 ns)
    TCS: [33mTestCase_testVec2ComponentAt[0m, time elapsed: 210700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ComponentAt (10400 ns)
    TCS: [33mTestCase_testVec2Equal[0m, time elapsed: 229000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Equal (18900 ns)
    TCS: [33mTestCase_testVec2NotEqual[0m, time elapsed: 239800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2NotEqual (17500 ns)
    TCS: [33mTestCase_testVec2EqualExact[0m, time elapsed: 229700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2EqualExact (15800 ns)
    TCS: [33mTestCase_testVec2BitwiseAnd[0m, time elapsed: 229800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseAnd (15400 ns)
    TCS: [33mTestCase_testVec2BitwiseNot[0m, time elapsed: 224500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseNot (7400 ns)
    TCS: [33mTestCase_testVec2FromVec1[0m, time elapsed: 217800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2FromVec1 (12100 ns)
    TCS: [33mTestCase_testVec2ShiftLeft[0m, time elapsed: 258800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeft (18600 ns)
    TCS: [33mTestCase_testVec2BoolLogicalAnd[0m, time elapsed: 270900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BoolLogicalAnd (17600 ns)
    TCS: [33mTestCase_testVec2Vec1ArithBroadcast[0m, time elapsed: 296600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Vec1ArithBroadcast (15800 ns)
    TCS: [33mTestCase_testVec2Vec1BitBroadcast[0m, time elapsed: 242500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Vec1BitBroadcast (13900 ns)
    TCS: [33mTestCase_testVec2ShiftLeftVec1[0m, time elapsed: 235500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeftVec1 (17200 ns)
    TCS: [33mTestCase_testVec2Div[0m, time elapsed: 235200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Div (14900 ns)
    TCS: [33mTestCase_testVec2Mod[0m, time elapsed: 269200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Mod (15500 ns)
    TCS: [33mTestCase_testVec2ScalarSub[0m, time elapsed: 224500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarSub (13200 ns)
    TCS: [33mTestCase_testVec2ScalarMul[0m, time elapsed: 323800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarMul (22400 ns)
    TCS: [33mTestCase_testVec2ScalarDiv[0m, time elapsed: 245700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarDiv (16200 ns)
    TCS: [33mTestCase_testVec2ScalarMod[0m, time elapsed: 279100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarMod (13300 ns)
    TCS: [33mTestCase_testVec2BoolLogicalOr[0m, time elapsed: 288500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BoolLogicalOr (12900 ns)
    TCS: [33mTestCase_testVec2EqualEpsilon[0m, time elapsed: 241900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2EqualEpsilon (21200 ns)
    TCS: [33mTestCase_testVec2DivNamed[0m, time elapsed: 232500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2DivNamed (15300 ns)
    TCS: [33mTestCase_testVec2ModNamed[0m, time elapsed: 217400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ModNamed (7300 ns)
    TCS: [33mTestCase_testVec2BitwiseOr[0m, time elapsed: 262600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseOr (21200 ns)
    TCS: [33mTestCase_testVec2BitwiseXor[0m, time elapsed: 257200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseXor (19800 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseAnd[0m, time elapsed: 239700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseAnd (12800 ns)
    TCS: [33mTestCase_testVec2ShiftRight[0m, time elapsed: 251500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRight (14400 ns)
    TCS: [33mTestCase_testVec2ShiftRightVec1[0m, time elapsed: 206300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRightVec1 (12700 ns)
    TCS: [33mTestCase_testVec2AddNamed[0m, time elapsed: 221200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2AddNamed (10400 ns)
    TCS: [33mTestCase_testVec2SubNamed[0m, time elapsed: 223400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2SubNamed (12700 ns)
    TCS: [33mTestCase_testVec2MulNamed[0m, time elapsed: 209000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2MulNamed (7800 ns)
    TCS: [33mTestCase_testVec2ShiftLeftVec[0m, time elapsed: 204900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeftVec (8700 ns)
    TCS: [33mTestCase_testVec2ShiftRightVec[0m, time elapsed: 195400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRightVec (7400 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseOr[0m, time elapsed: 209200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseOr (7500 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseXor[0m, time elapsed: 214000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseXor (20700 ns)
    TCS: [33mTestCase_testVec2Increment[0m, time elapsed: 203200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Increment (12200 ns)
    TCS: [33mTestCase_testVec2Decrement[0m, time elapsed: 204800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Decrement (12500 ns)
    TCS: [33mTestCase_testVec2IndexOutOfBoundsAccess[0m, time elapsed: 301300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2IndexOutOfBoundsAccess (60500 ns)
    TCS: [33mTestCase_testVec2NegativeIndexAccess[0m, time elapsed: 263800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2NegativeIndexAccess (55300 ns)
    TCS: [33mTestCase_testVec3ScalarInit[0m, time elapsed: 220300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarInit (10500 ns)
    TCS: [33mTestCase_testVec3ConstInit[0m, time elapsed: 192200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ConstInit (10300 ns)
    TCS: [33mTestCase_testVec3Length[0m, time elapsed: 191000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Length (5900 ns)
    TCS: [33mTestCase_testVec3Add[0m, time elapsed: 236800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Add (20900 ns)
    TCS: [33mTestCase_testVec3ScalarMul[0m, time elapsed: 211900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarMul (16500 ns)
    TCS: [33mTestCase_testVec3Negate[0m, time elapsed: 218500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Negate (15200 ns)
    TCS: [33mTestCase_testVec3IndexAccess[0m, time elapsed: 222800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3IndexAccess (17500 ns)
    TCS: [33mTestCase_testVec3IndexMutate[0m, time elapsed: 217500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3IndexMutate (7700 ns)
    TCS: [33mTestCase_testVec3ComponentAt[0m, time elapsed: 240000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ComponentAt (9000 ns)
    TCS: [33mTestCase_testVec3Equal[0m, time elapsed: 265000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Equal (26000 ns)
    TCS: [33mTestCase_testVec3NotEqual[0m, time elapsed: 253800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3NotEqual (22300 ns)
    TCS: [33mTestCase_testVec3EqualExact[0m, time elapsed: 378700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3EqualExact (44500 ns)
    TCS: [33mTestCase_testVec3BitwiseAnd[0m, time elapsed: 283100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseAnd (27200 ns)
    TCS: [33mTestCase_testVec3BitwiseNot[0m, time elapsed: 232400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseNot (9600 ns)
    TCS: [33mTestCase_testVec3Vec1ArithBroadcast[0m, time elapsed: 262100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1ArithBroadcast (20000 ns)
    TCS: [33mTestCase_testVec3ShiftLeft[0m, time elapsed: 232500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeft (17700 ns)
    TCS: [33mTestCase_testVec3BoolLogicalAnd[0m, time elapsed: 236100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BoolLogicalAnd (14600 ns)
    TCS: [33mTestCase_testVec3Sub[0m, time elapsed: 306600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Sub (22000 ns)
    TCS: [33mTestCase_testVec3Div[0m, time elapsed: 245000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Div (19100 ns)
    TCS: [33mTestCase_testVec3Mod[0m, time elapsed: 249900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Mod (16300 ns)
    TCS: [33mTestCase_testVec3ScalarSub[0m, time elapsed: 270800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarSub (21000 ns)
    TCS: [33mTestCase_testVec3ScalarDiv[0m, time elapsed: 241700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarDiv (16600 ns)
    TCS: [33mTestCase_testVec3ScalarMod[0m, time elapsed: 238400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarMod (17500 ns)
    TCS: [33mTestCase_testVec3BoolLogicalOr[0m, time elapsed: 220100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BoolLogicalOr (12700 ns)
    TCS: [33mTestCase_testVec3EqualEpsilon[0m, time elapsed: 243800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3EqualEpsilon (22200 ns)
    TCS: [33mTestCase_testVec3AddNamed[0m, time elapsed: 236100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3AddNamed (15400 ns)
    TCS: [33mTestCase_testVec3MulNamed[0m, time elapsed: 230200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3MulNamed (9100 ns)
    TCS: [33mTestCase_testVec3DivNamed[0m, time elapsed: 246200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3DivNamed (7500 ns)
    TCS: [33mTestCase_testVec3ModNamed[0m, time elapsed: 257200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ModNamed (13600 ns)
    TCS: [33mTestCase_testVec3BitwiseOr[0m, time elapsed: 260500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseOr (21900 ns)
    TCS: [33mTestCase_testVec3BitwiseXor[0m, time elapsed: 696000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseXor (40200 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseAnd[0m, time elapsed: 242500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseAnd (19200 ns)
    TCS: [33mTestCase_testVec3ShiftRight[0m, time elapsed: 270900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRight (23300 ns)
    TCS: [33mTestCase_testVec3Vec1BitBroadcast[0m, time elapsed: 394700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitBroadcast (73700 ns)
    TCS: [33mTestCase_testVec3ShiftRightVec1[0m, time elapsed: 271100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRightVec1 (32600 ns)
    TCS: [33mTestCase_testVec3FromVec1[0m, time elapsed: 225400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3FromVec1 (9600 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseOr[0m, time elapsed: 218100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseOr (15300 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseXor[0m, time elapsed: 229200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseXor (16000 ns)
    TCS: [33mTestCase_testVec3Vec1BitOrBroadcast[0m, time elapsed: 232100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitOrBroadcast (17000 ns)
    TCS: [33mTestCase_testVec3Vec1BitXorBroadcast[0m, time elapsed: 222500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitXorBroadcast (16900 ns)
    TCS: [33mTestCase_testVec3ShiftLeftVec1[0m, time elapsed: 226100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeftVec1 (16600 ns)
    TCS: [33mTestCase_testVec3ShiftLeftVec[0m, time elapsed: 244000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeftVec (10100 ns)
    TCS: [33mTestCase_testVec3ShiftRightVec[0m, time elapsed: 242700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRightVec (17800 ns)
    TCS: [33mTestCase_testVec3Increment[0m, time elapsed: 251300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Increment (22800 ns)
    TCS: [33mTestCase_testVec3Decrement[0m, time elapsed: 298000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Decrement (25700 ns)
    TCS: [33mTestCase_testVec3IndexOutOfBoundsAccess[0m, time elapsed: 270000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3IndexOutOfBoundsAccess (45700 ns)
    TCS: [33mTestCase_testVec3NegativeIndexAccess[0m, time elapsed: 236400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3NegativeIndexAccess (18400 ns)
    TCS: [33mTestCase_testVec4ScalarInit[0m, time elapsed: 226200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarInit (14000 ns)
    TCS: [33mTestCase_testVec4ConstInit[0m, time elapsed: 223400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ConstInit (9900 ns)
    TCS: [33mTestCase_testVec4Length[0m, time elapsed: 232400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Length (6900 ns)
    TCS: [33mTestCase_testVec4Add[0m, time elapsed: 358100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Add (34500 ns)
    TCS: [33mTestCase_testVec4ScalarMul[0m, time elapsed: 240300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarMul (17500 ns)
    TCS: [33mTestCase_testVec4Negate[0m, time elapsed: 241100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Negate (16500 ns)
    TCS: [33mTestCase_testVec4IndexAccess[0m, time elapsed: 317200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4IndexAccess (13200 ns)
    TCS: [33mTestCase_testVec4IndexMutate[0m, time elapsed: 219300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4IndexMutate (6500 ns)
    TCS: [33mTestCase_testVec4ComponentAt[0m, time elapsed: 220700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ComponentAt (11500 ns)
    TCS: [33mTestCase_testVec4Equal[0m, time elapsed: 244400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Equal (22600 ns)
    TCS: [33mTestCase_testVec4NotEqual[0m, time elapsed: 226800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4NotEqual (13200 ns)
    TCS: [33mTestCase_testVec4EqualExact[0m, time elapsed: 218400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4EqualExact (16100 ns)
    TCS: [33mTestCase_testVec4BitwiseAnd[0m, time elapsed: 234000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseAnd (16600 ns)
    TCS: [33mTestCase_testVec4BitwiseNot[0m, time elapsed: 213400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseNot (7000 ns)
    TCS: [33mTestCase_testVec4Vec1ArithBroadcast[0m, time elapsed: 275000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1ArithBroadcast (22500 ns)
    TCS: [33mTestCase_testVec4ShiftLeft[0m, time elapsed: 242600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeft (15700 ns)
    TCS: [33mTestCase_testVec4BoolLogicalAnd[0m, time elapsed: 212000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BoolLogicalAnd (13100 ns)
    TCS: [33mTestCase_testVec4Sub[0m, time elapsed: 222500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Sub (15100 ns)
    TCS: [33mTestCase_testVec4Div[0m, time elapsed: 222700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Div (17700 ns)
    TCS: [33mTestCase_testVec4Mod[0m, time elapsed: 216900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Mod (18000 ns)
    TCS: [33mTestCase_testVec4ScalarSub[0m, time elapsed: 220200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarSub (14900 ns)
    TCS: [33mTestCase_testVec4ScalarDiv[0m, time elapsed: 228400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarDiv (12800 ns)
    TCS: [33mTestCase_testVec4ScalarMod[0m, time elapsed: 211000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarMod (14300 ns)
    TCS: [33mTestCase_testVec4BoolLogicalOr[0m, time elapsed: 196900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BoolLogicalOr (6800 ns)
    TCS: [33mTestCase_testVec4EqualEpsilon[0m, time elapsed: 229800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4EqualEpsilon (20300 ns)
    TCS: [33mTestCase_testVec4AddNamed[0m, time elapsed: 210600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4AddNamed (18600 ns)
    TCS: [33mTestCase_testVec4MulNamed[0m, time elapsed: 206800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4MulNamed (7200 ns)
    TCS: [33mTestCase_testVec4DivNamed[0m, time elapsed: 241900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4DivNamed (6800 ns)
    TCS: [33mTestCase_testVec4ModNamed[0m, time elapsed: 505700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ModNamed (44900 ns)
    TCS: [33mTestCase_testVec4BitwiseOr[0m, time elapsed: 261500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseOr (20800 ns)
    TCS: [33mTestCase_testVec4BitwiseXor[0m, time elapsed: 364200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseXor (30500 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseAnd[0m, time elapsed: 360800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseAnd (30000 ns)
    TCS: [33mTestCase_testVec4ShiftRight[0m, time elapsed: 245500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRight (21900 ns)
    TCS: [33mTestCase_testVec4Vec1BitBroadcast[0m, time elapsed: 242200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitBroadcast (18800 ns)
    TCS: [33mTestCase_testVec4ShiftRightVec1[0m, time elapsed: 326700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRightVec1 (22900 ns)
    TCS: [33mTestCase_testVec4FromVec1[0m, time elapsed: 309600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4FromVec1 (20200 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseOr[0m, time elapsed: 281700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseOr (16900 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseXor[0m, time elapsed: 230200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseXor (18800 ns)
    TCS: [33mTestCase_testVec4Vec1BitOrBroadcast[0m, time elapsed: 241800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitOrBroadcast (22400 ns)
    TCS: [33mTestCase_testVec4Vec1BitXorBroadcast[0m, time elapsed: 258400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitXorBroadcast (21200 ns)
    TCS: [33mTestCase_testVec4ShiftLeftVec1[0m, time elapsed: 267000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeftVec1 (17400 ns)
    TCS: [33mTestCase_testVec4ShiftLeftVec[0m, time elapsed: 233100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeftVec (21900 ns)
    TCS: [33mTestCase_testVec4ShiftRightVec[0m, time elapsed: 231000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRightVec (17600 ns)
    TCS: [33mTestCase_testVec4Increment[0m, time elapsed: 251200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Increment (24400 ns)
    TCS: [33mTestCase_testVec4Decrement[0m, time elapsed: 249600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Decrement (20900 ns)
    TCS: [33mTestCase_testVec4IndexOutOfBoundsAccess[0m, time elapsed: 261000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4IndexOutOfBoundsAccess (45800 ns)
    TCS: [33mTestCase_testVec4NegativeIndexAccess[0m, time elapsed: 244700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4NegativeIndexAccess (31500 ns)
    TCS: [33mTestCase_testFunctor1Vec1Identity[0m, time elapsed: 248600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec1Identity (13200 ns)
    TCS: [33mTestCase_testFunctor1Vec1Transform[0m, time elapsed: 268700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec1Transform (12500 ns)
    TCS: [33mTestCase_testFunctor1Vec2Transform[0m, time elapsed: 274000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec2Transform (21300 ns)
    TCS: [33mTestCase_testFunctor2Vec1Add[0m, time elapsed: 355800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec1Add (19400 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec1Mul[0m, time elapsed: 346400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec1Mul (24700 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec1Shift[0m, time elapsed: 317600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec1Shift (12900 ns)
    TCS: [33mTestCase_testFunctor1Vec3Transform[0m, time elapsed: 295700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec3Transform (20600 ns)
    TCS: [33mTestCase_testFunctor1Vec4Transform[0m, time elapsed: 255900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec4Transform (14000 ns)
    TCS: [33mTestCase_testFunctor2Vec2Add[0m, time elapsed: 413000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec2Add (20000 ns)
    TCS: [33mTestCase_testFunctor2Vec3Add[0m, time elapsed: 416300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec3Add (20800 ns)
    TCS: [33mTestCase_testFunctor2Vec4Add[0m, time elapsed: 309100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec4Add (17200 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec2Mul[0m, time elapsed: 313800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec2Mul (16500 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec3Mul[0m, time elapsed: 363900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec3Mul (48800 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec4Mul[0m, time elapsed: 243400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec4Mul (11600 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec2Shift[0m, time elapsed: 245500 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec2Shift (17900 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec3Shift[0m, time elapsed: 247100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec3Shift (17800 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec4Shift[0m, time elapsed: 265700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec4Shift (11700 ns)
Summary: TOTAL: 476
    [32mPASSED[0m: 476, [32mSKIPPED[0m: 0, ERROR: 0
    [31mFAILED[0m: 0
--------------------------------------------------------------------------------------------------
Project tests finished, time elapsed: 202447900 ns, RESULT:
TP: [33mglm[0m.*, time elapsed: 202377900 ns, RESULT:
    PASSED:
    TP: [33mglm.detail[0m, time elapsed: 186567100 ns
Summary: TOTAL: 476
    [32mPASSED[0m: 476, [32mSKIPPED[0m: 0, ERROR: 0
    [31mFAILED[0m: 0
--------------------------------------------------------------------------------------------------
[0J7[;r8[?25hcjpm test success
