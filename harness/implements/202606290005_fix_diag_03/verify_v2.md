# 验证报告（v2）

## 结果
FAILED

## 统计
- 通过：426
- 失败：3

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



warning: unused variable:'x'

 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:6:23:

  | 

6 | public func sin<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }

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



warning: unused variable:'a'

 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:8:21:

  | 

8 | public func sign<T>(a: T): T where T <: Number<T> & Comparable<T> { throw Exception("stub") }

  |                     ^ unused variable

  | 

  # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused variable:'x'

 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:8:23:

  | 

8 | public func sin<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }

  |                       ^ unused variable

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



warning: unused variable:'x'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:11:20:

   | 

11 | public func cos<T>(x: T): T where T <: FloatingPoint<T> { throw Exception("stub") }

   |                    ^ unused variable

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



warning: unused variable:'x'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:12:23:

   | 

12 | public func cos<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }

   |                       ^ unused variable

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



warning: unused variable:'x'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\trigonometric.cj:14:23:

   | 

14 | public func cos<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }

   |                       ^ unused variable

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused variable:'b'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\common.cj:14:26:

   | 

14 | public func mix<T>(a: T, b: T, t: T): T where T <: Number<T> { throw Exception("stub") }

   |                          ^ unused variable

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused variable:'v'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\geometric.cj:14:26:

   | 

14 | public func length<T, Q>(v: Vec3<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }

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



warning: unused variable:'two'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_quat_cast.cj:54:9:

   | 

54 |     let two: T = (Float64(2.0) as T).getOrThrow()

   |         ^^^ unused variable

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



warning: unused variable:'rhs'

   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_quat.cj:149:28:

    | 

149 |     public operator func *(rhs: Quat<T, Q>): Vec4<T, Q> {

    |                            ^^^ unused variable

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

   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:155:58:

    | 

155 |     public static func fromMat<SrcQ>(m: Mat2x3<T, SrcQ>, one: T): Mat3x2<T, Q>

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

   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:161:58:

    | 

161 |     public static func fromMat<SrcQ>(m: Mat2x3<T, SrcQ>, one: T): Mat4x2<T, Q>

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



warning: unused variable:'one'

   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:167:58:

    | 

167 |     public static func fromMat<SrcQ>(m: Mat3x3<T, SrcQ>, one: T): Mat3x2<T, Q>

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

   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:173:58:

    | 

173 |     public static func fromMat<SrcQ>(m: Mat4x2<T, SrcQ>, one: T): Mat2x2<T, Q>

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

   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x4.cj:191:58:

    | 

191 |     public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat3x4<T, Q>

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

   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:217:71:

    | 

217 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat3x4<U, P>, one: T): Mat2x4<T, Q>

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



238 warnings generated, 238 warnings printed.

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



warning: unused variable:'x'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:22:31:

   | 

22 | public func eulerAngles<T, Q>(x: Quat<T, Q>): Vec3<T, Q>

   |                               ^ unused variable

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused variable:'m'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:23:25:

   | 

23 | public func scale<T, Q>(m: Mat4x4<T, Q>, v: Vec3<T, Q>): Mat4x4<T, Q>

   |                         ^ unused variable

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

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:26:24:

   | 

26 | public func roll<T, Q>(q: Quat<T, Q>): T

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

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:30:25:

   | 

30 | public func pitch<T, Q>(q: Quat<T, Q>): T

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

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:34:23:

   | 

34 | public func yaw<T, Q>(q: Quat<T, Q>): T

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



warning: unused variable:'direction'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:38:30:

   | 

38 | public func quatLookAt<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>

   |                              ^^^^^^^^^ unused variable

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused variable:'up'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:38:53:

   | 

38 | public func quatLookAt<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>

   |                                                     ^^ unused variable

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused variable:'eye'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:39:28:

   | 

39 | public func lookAtRH<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>

   |                            ^^^ unused variable

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

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:39:65:

   | 

39 | public func lookAtRH<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>

   |                                                                 ^^ unused variable

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused variable:'direction'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:42:32:

   | 

42 | public func quatLookAtRH<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>

   |                                ^^^^^^^^^ unused variable

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused variable:'up'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:42:55:

   | 

42 | public func quatLookAtRH<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>

   |                                                       ^^ unused variable

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused variable:'eye'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:43:28:

   | 

43 | public func lookAtLH<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>

   |                            ^^^ unused variable

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

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:43:65:

   | 

43 | public func lookAtLH<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>

   |                                                                 ^^ unused variable

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused variable:'direction'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:46:32:

   | 

46 | public func quatLookAtLH<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>

   |                                ^^^^^^^^^ unused variable

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused variable:'up'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:46:55:

   | 

46 | public func quatLookAtLH<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>

   |                                                       ^^ unused variable

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused variable:'eye'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:47:26:

   | 

47 | public func lookAt<T, Q>(eye: Vec3<T, Q>, center: Vec3<T, Q>, up: Vec3<T, Q>): Mat4x4<T, Q>

   |                          ^^^ unused variable

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

40 | public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T, spin: Bool): Quat<T, Q>

   |                         ^ unused variable

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused variable:'y'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_common.cj:40:40:

   | 

40 | public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T, spin: Bool): Quat<T, Q>

   |                                        ^ unused variable

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused variable:'a'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_common.cj:40:55:

   | 

40 | public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T, spin: Bool): Quat<T, Q>

   |                                                       ^ unused variable

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused variable:'spin'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_common.cj:40:61:

   | 

40 | public func slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T, spin: Bool): Quat<T, Q>

   |                                                             ^^^^ unused variable

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



warning: unused import 'glm.detail.sin'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:20:

   | 

12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}

   |                    ^^^ unused import

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused import 'glm.detail.cos'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:25:

   | 

12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}

   |                         ^^^ unused import

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused import 'glm.detail.tan'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:30:

   | 

12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}

   |                              ^^^ unused import

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused import 'glm.detail.asin'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:35:

   | 

12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}

   |                                   ^^^^ unused import

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused import 'glm.detail.acos'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:41:

   | 

12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}

   |                                         ^^^^ unused import

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused import 'glm.detail.atan'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:47:

   | 

12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}

   |                                               ^^^^ unused import

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused import 'glm.detail.atan2'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:53:

   | 

12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}

   |                                                     ^^^^^ unused import

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused import 'glm.detail.sinh'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:60:

   | 

12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}

   |                                                            ^^^^ unused import

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused import 'glm.detail.cosh'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:66:

   | 

12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}

   |                                                                  ^^^^ unused import

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused import 'glm.detail.tanh'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:72:

   | 

12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}

   |                                                                        ^^^^ unused import

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused import 'glm.detail.asinh'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:78:

   | 

12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}

   |                                                                              ^^^^^ unused import

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused import 'glm.detail.acosh'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:85:

   | 

12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}

   |                                                                                     ^^^^^ unused import

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused import 'glm.detail.atanh'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:92:

   | 

12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}

   |                                                                                            ^^^^^ unused import

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused import 'glm.detail.radians'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:99:

   | 

12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}

   |                                                                                                   ^^^^^^^ unused import

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused import 'glm.detail.degrees'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:12:108:

   | 

12 | import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}

   |                                                                                                            ^^^^^^^ unused import

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused import 'glm.ext.*'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:14:1:

   | 

14 | import glm.ext.*

   | ^^^^^^^^^^^^^^^^ unused import

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused import 'glm.gtc.*'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:16:1:

   | 

16 | import glm.gtc.*

   | ^^^^^^^^^^^^^^^^ unused import

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff unused`



21 warnings generated, 21 warnings printed.

[?25l[0J7[;r8
[1F7[9999E8--------------------------------------------------------------------------------------------------
TP: glm.detail, time elapsed: 143951700 ns, RESULT:
    TCS: TestCase_testComputeVecAdd1, time elapsed: 1848800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAdd1 (317400 ns)
    TCS: TestCase_testComputeVecSub2, time elapsed: 331300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSub2 (54100 ns)
    TCS: TestCase_testComputeVecMul3, time elapsed: 341600 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMul3 (36500 ns)
    TCS: TestCase_testComputeVecMod1, time elapsed: 275600 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMod1 (30500 ns)
    TCS: TestCase_testComputeVecMod4, time elapsed: 257100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMod4 (26400 ns)
    TCS: TestCase_testComputeVecAnd1, time elapsed: 333000 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAnd1 (27100 ns)
    TCS: TestCase_testComputeVecAnd3, time elapsed: 258700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAnd3 (21700 ns)
    TCS: TestCase_testComputeVecOr1, time elapsed: 256800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecOr1 (32100 ns)
    TCS: TestCase_testComputeVecOr2, time elapsed: 257100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecOr2 (18500 ns)
    TCS: TestCase_testComputeVecXor1, time elapsed: 287300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecXor1 (23400 ns)
    TCS: TestCase_testComputeVecXor4, time elapsed: 267500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecXor4 (25900 ns)
    TCS: TestCase_testComputeVecShiftLeft1, time elapsed: 280100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftLeft1 (13800 ns)
    TCS: TestCase_testComputeVecShiftLeft3, time elapsed: 314200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftLeft3 (19500 ns)
    TCS: TestCase_testComputeVecShiftRight1, time elapsed: 244000 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftRight1 (17600 ns)
    TCS: TestCase_testComputeVecShiftRight4, time elapsed: 243500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftRight4 (14000 ns)
    TCS: TestCase_testComputeVecEqual1, time elapsed: 263100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual1 (23700 ns)
    TCS: TestCase_testComputeVecNequal4, time elapsed: 246400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecNequal4 (18000 ns)
    TCS: TestCase_testComputeVecBitwiseNot1, time elapsed: 294700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecBitwiseNot1 (23800 ns)
    TCS: TestCase_testComputeVecBitwiseNot3, time elapsed: 285600 ns, RESULT:
    [ PASSED ] CASE: testComputeVecBitwiseNot3 (47500 ns)
    TCS: TestCase_testComputeVecAdd4, time elapsed: 241600 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAdd4 (22400 ns)
    TCS: TestCase_testComputeVecSub1, time elapsed: 506600 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSub1 (24100 ns)
    TCS: TestCase_testComputeVecSub3, time elapsed: 230500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSub3 (21200 ns)
    TCS: TestCase_testComputeVecMul1, time elapsed: 210300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMul1 (17000 ns)
    TCS: TestCase_testComputeVecMul2, time elapsed: 230200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMul2 (27900 ns)
    TCS: TestCase_testComputeVecDiv1, time elapsed: 263000 ns, RESULT:
    [ PASSED ] CASE: testComputeVecDiv1 (46000 ns)
    TCS: TestCase_testComputeVecDiv2, time elapsed: 214300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecDiv2 (17700 ns)
    TCS: TestCase_testComputeVecDiv4, time elapsed: 211000 ns, RESULT:
    [ PASSED ] CASE: testComputeVecDiv4 (18500 ns)
    TCS: TestCase_testComputeVecEqual2, time elapsed: 223200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual2 (16300 ns)
    TCS: TestCase_testComputeVecEqual3, time elapsed: 231100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual3 (14800 ns)
    TCS: TestCase_testComputeVecEqual4, time elapsed: 198900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual4 (10800 ns)
    TCS: TestCase_testComputeVecNequal1, time elapsed: 226200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecNequal1 (16900 ns)
    TCS: TestCase_testComputeVecNequal2, time elapsed: 193100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecNequal2 (9700 ns)
    TCS: TestCase_testComputeVecBitwiseNot4, time elapsed: 216900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecBitwiseNot4 (23400 ns)
    TCS: TestCase_testComputeVecAddFloat32, time elapsed: 250700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAddFloat32 (33900 ns)
    TCS: TestCase_testComputeVecAddFloat32Vec3, time elapsed: 234400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAddFloat32Vec3 (27300 ns)
    TCS: TestCase_testComputeVecSubFloat32, time elapsed: 528400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSubFloat32 (38100 ns)
    TCS: TestCase_testComputeVecSubFloat32Vec4, time elapsed: 336300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSubFloat32Vec4 (36800 ns)
    TCS: TestCase_testComputeEqualInt32Equal, time elapsed: 208300 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt32Equal (12700 ns)
    TCS: TestCase_testComputeEqualInt32NotEqual, time elapsed: 206600 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt32NotEqual (9900 ns)
    TCS: TestCase_testComputeEqualFloat32Equal, time elapsed: 221500 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32Equal (15100 ns)
    TCS: TestCase_testComputeEqualFloat32NotEqual, time elapsed: 254700 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32NotEqual (17200 ns)
    TCS: TestCase_testComputeEqualFloat64Equal, time elapsed: 226100 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64Equal (12300 ns)
    TCS: TestCase_testComputeEqualFloat64NotEqual, time elapsed: 201300 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64NotEqual (11100 ns)
    TCS: TestCase_testComputeEqualBoolEqual, time elapsed: 208500 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualBoolEqual (14800 ns)
    TCS: TestCase_testComputeEqualBoolNotEqual, time elapsed: 220500 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualBoolNotEqual (10800 ns)
    TCS: TestCase_testComputeEqualNumericInt32, time elapsed: 230800 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericInt32 (22700 ns)
    TCS: TestCase_testComputeEqualNumericFloat32, time elapsed: 245700 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32 (44300 ns)
    TCS: TestCase_testComputeEqualNumericFloat32Epsilon, time elapsed: 210900 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32Epsilon (12100 ns)
    TCS: TestCase_testComputeEqualNumericFloat64, time elapsed: 205400 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64 (15600 ns)
    TCS: TestCase_testComputeEqualInt64Equal, time elapsed: 187900 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt64Equal (10800 ns)
    TCS: TestCase_testComputeEqualInt64NotEqual, time elapsed: 193700 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt64NotEqual (12000 ns)
    TCS: TestCase_testComputeEqualFloat32Nan, time elapsed: 190000 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32Nan (9100 ns)
    TCS: TestCase_testComputeEqualFloat64Nan, time elapsed: 226500 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64Nan (11100 ns)
    TCS: TestCase_testComputeEqualFloat32SignedZero, time elapsed: 193600 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32SignedZero (9600 ns)
    TCS: TestCase_testComputeEqualFloat64SignedZero, time elapsed: 191500 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64SignedZero (8600 ns)
    TCS: TestCase_testComputeEqualNumericFloat32NotEqual, time elapsed: 206000 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32NotEqual (17700 ns)
    TCS: TestCase_testComputeEqualNumericFloat32BeyondEpsilon, time elapsed: 203000 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32BeyondEpsilon (11100 ns)
    TCS: TestCase_testComputeEqualNumericFloat64NotEqual, time elapsed: 218100 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64NotEqual (12200 ns)
    TCS: TestCase_testComputeEqualNumericFloat64Epsilon, time elapsed: 207300 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64Epsilon (9900 ns)
    TCS: TestCase_testComputeEqualNumericFloat64BeyondEpsilon, time elapsed: 244100 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64BeyondEpsilon (10800 ns)
    TCS: TestCase_testComputeEqualNumericInt64, time elapsed: 222900 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericInt64 (11700 ns)
    TCS: TestCase_testPackedHighpImplementsQualifier, time elapsed: 209200 ns, RESULT:
    [ PASSED ] CASE: testPackedHighpImplementsQualifier (12800 ns)
    TCS: TestCase_testPackedMediumpImplementsQualifier, time elapsed: 255500 ns, RESULT:
    [ PASSED ] CASE: testPackedMediumpImplementsQualifier (9200 ns)
    TCS: TestCase_testPackedLowpImplementsQualifier, time elapsed: 210700 ns, RESULT:
    [ PASSED ] CASE: testPackedLowpImplementsQualifier (9800 ns)
    TCS: TestCase_testDefaultpIsPackedHighp, time elapsed: 462400 ns, RESULT:
    [ PASSED ] CASE: testDefaultpIsPackedHighp (20400 ns)
    TCS: TestCase_testScalarAddVec1, time elapsed: 236000 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec1 (21000 ns)
    TCS: TestCase_testScalarAddVec2, time elapsed: 216200 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec2 (13100 ns)
    TCS: TestCase_testScalarAddVec3, time elapsed: 208200 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec3 (15700 ns)
    TCS: TestCase_testScalarAddVec4, time elapsed: 210900 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec4 (12200 ns)
    TCS: TestCase_testScalarSubVec1, time elapsed: 258800 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1 (25600 ns)
    TCS: TestCase_testScalarMulVec1, time elapsed: 203300 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1 (12300 ns)
    TCS: TestCase_testScalarDivVec1, time elapsed: 210100 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1 (14800 ns)
    TCS: TestCase_testScalarModVec1, time elapsed: 225900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1 (22200 ns)
    TCS: TestCase_testScalarMulVec2, time elapsed: 199000 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2 (10100 ns)
    TCS: TestCase_testScalarSubVec2, time elapsed: 207600 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2 (17500 ns)
    TCS: TestCase_testScalarSubVec3, time elapsed: 337700 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3 (13500 ns)
    TCS: TestCase_testScalarSubVec4, time elapsed: 338700 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4 (16300 ns)
    TCS: TestCase_testScalarMulVec3, time elapsed: 243400 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3 (20100 ns)
    TCS: TestCase_testScalarMulVec4, time elapsed: 231500 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4 (12300 ns)
    TCS: TestCase_testScalarDivVec2, time elapsed: 213600 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2 (16600 ns)
    TCS: TestCase_testScalarDivVec3, time elapsed: 198200 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3 (10100 ns)
    TCS: TestCase_testScalarDivVec4, time elapsed: 240600 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4 (13700 ns)
    TCS: TestCase_testScalarModVec2, time elapsed: 287200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2 (10300 ns)
    TCS: TestCase_testScalarModVec3, time elapsed: 216000 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3 (21300 ns)
    TCS: TestCase_testScalarModVec4, time elapsed: 201100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4 (13500 ns)
    TCS: TestCase_testScalarModVec1Float32, time elapsed: 248900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Float32 (27600 ns)
    TCS: TestCase_testScalarModVec2Float32, time elapsed: 205400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32 (11400 ns)
    TCS: TestCase_testScalarModVec3Float32, time elapsed: 210500 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Float32 (14000 ns)
    TCS: TestCase_testScalarModVec4Float32, time elapsed: 273100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Float32 (25600 ns)
    TCS: TestCase_testScalarModVec1Float64, time elapsed: 238200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Float64 (21600 ns)
    TCS: TestCase_testScalarModVec2Float64, time elapsed: 212100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float64 (11200 ns)
    TCS: TestCase_testScalarModVec3Float64, time elapsed: 311000 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Float64 (18600 ns)
    TCS: TestCase_testScalarModVec4Float64, time elapsed: 287700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Float64 (14600 ns)
    TCS: TestCase_testScalarModVec1Float16, time elapsed: 355300 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Float16 (43000 ns)
    TCS: TestCase_testScalarModVec2Float16, time elapsed: 288900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float16 (22500 ns)
    TCS: TestCase_testScalarModVec3Float16, time elapsed: 223900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Float16 (13100 ns)
    TCS: TestCase_testScalarModVec4Float16, time elapsed: 249400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Float16 (18300 ns)
    TCS: TestCase_testScalarSubVec2PackedMediump, time elapsed: 266500 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2PackedMediump (23800 ns)
    TCS: TestCase_testScalarSubVec2PackedLowp, time elapsed: 216200 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2PackedLowp (15800 ns)
    TCS: TestCase_testScalarMulVec2PackedMediump, time elapsed: 206700 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2PackedMediump (15700 ns)
    TCS: TestCase_testScalarMulVec2PackedLowp, time elapsed: 231000 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2PackedLowp (12700 ns)
    TCS: TestCase_testScalarDivVec2PackedMediump, time elapsed: 221300 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2PackedMediump (13500 ns)
    TCS: TestCase_testScalarDivVec2PackedLowp, time elapsed: 207100 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2PackedLowp (12300 ns)
    TCS: TestCase_testScalarModVec2PackedMediump, time elapsed: 214700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2PackedMediump (11600 ns)
    TCS: TestCase_testScalarModVec2PackedLowp, time elapsed: 205300 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2PackedLowp (9500 ns)
    TCS: TestCase_testScalarModVec2Float32PackedMediump, time elapsed: 220500 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32PackedMediump (13500 ns)
    TCS: TestCase_testScalarModVec2Float32PackedLowp, time elapsed: 219100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32PackedLowp (10700 ns)
    TCS: TestCase_testScalarModVec2Float32NegativeDividend, time elapsed: 229500 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32NegativeDividend (21700 ns)
    TCS: TestCase_testScalarModVec2Float32NegativeDivisor, time elapsed: 221600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32NegativeDivisor (11500 ns)
    TCS: TestCase_testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents, time elapsed: 403400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents (174000 ns)
    TCS: TestCase_testScalarAddVec1Float32, time elapsed: 197600 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec1Float32 (17000 ns)
    TCS: TestCase_testScalarAddVec2Float32, time elapsed: 209500 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec2Float32 (14500 ns)
    TCS: TestCase_testScalarAddVec3Float32, time elapsed: 202600 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec3Float32 (11000 ns)
    TCS: TestCase_testScalarAddVec4Float32, time elapsed: 204800 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec4Float32 (11700 ns)
    TCS: TestCase_testScalarSubVec1Float32, time elapsed: 193200 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1Float32 (11400 ns)
    TCS: TestCase_testScalarSubVec2Float32, time elapsed: 202800 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2Float32 (11700 ns)
    TCS: TestCase_testScalarSubVec3Float32, time elapsed: 199500 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3Float32 (9500 ns)
    TCS: TestCase_testScalarSubVec4Float32, time elapsed: 191000 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4Float32 (13200 ns)
    TCS: TestCase_testScalarMulVec1Float32, time elapsed: 192800 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1Float32 (10300 ns)
    TCS: TestCase_testScalarMulVec2Float32, time elapsed: 187900 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2Float32 (8100 ns)
    TCS: TestCase_testScalarMulVec3Float32, time elapsed: 196800 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3Float32 (9000 ns)
    TCS: TestCase_testScalarMulVec4Float32, time elapsed: 201800 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4Float32 (12500 ns)
    TCS: TestCase_testScalarDivVec1Float32, time elapsed: 185700 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1Float32 (9400 ns)
    TCS: TestCase_testScalarDivVec2Float32, time elapsed: 180200 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2Float32 (9900 ns)
    TCS: TestCase_testScalarDivVec3Float32, time elapsed: 198300 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3Float32 (9700 ns)
    TCS: TestCase_testScalarDivVec4Float32, time elapsed: 182500 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4Float32 (10200 ns)
    TCS: TestCase_testScalarAddVec1Int32, time elapsed: 186600 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec1Int32 (14600 ns)
    TCS: TestCase_testScalarAddVec2Int32, time elapsed: 215400 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec2Int32 (13300 ns)
    TCS: TestCase_testScalarAddVec3Int32, time elapsed: 184800 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec3Int32 (10200 ns)
    TCS: TestCase_testScalarAddVec4Int32, time elapsed: 186000 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec4Int32 (11000 ns)
    TCS: TestCase_testScalarSubVec1Int32, time elapsed: 194800 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1Int32 (10600 ns)
    TCS: TestCase_testScalarSubVec2Int32, time elapsed: 181300 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2Int32 (12000 ns)
    TCS: TestCase_testScalarSubVec3Int32, time elapsed: 457200 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3Int32 (21500 ns)
    TCS: TestCase_testScalarSubVec4Int32, time elapsed: 365500 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4Int32 (26900 ns)
    TCS: TestCase_testScalarMulVec1Int32, time elapsed: 440100 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1Int32 (29900 ns)
    TCS: TestCase_testScalarMulVec2Int32, time elapsed: 377300 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2Int32 (16600 ns)
    TCS: TestCase_testScalarMulVec3Int32, time elapsed: 320300 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3Int32 (15900 ns)
    TCS: TestCase_testScalarMulVec4Int32, time elapsed: 308900 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4Int32 (23700 ns)
    TCS: TestCase_testScalarDivVec1Int32, time elapsed: 283900 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1Int32 (14500 ns)
    TCS: TestCase_testScalarDivVec2Int32, time elapsed: 457800 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2Int32 (26800 ns)
    TCS: TestCase_testScalarDivVec3Int32, time elapsed: 341100 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3Int32 (24700 ns)
    TCS: TestCase_testScalarDivVec4Int32, time elapsed: 283800 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4Int32 (16700 ns)
    TCS: TestCase_testScalarModVec1Int32, time elapsed: 346100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Int32 (29100 ns)
    TCS: TestCase_testScalarModVec2Int32, time elapsed: 215600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Int32 (11800 ns)
    TCS: TestCase_testScalarModVec3Int32, time elapsed: 212800 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Int32 (15400 ns)
    TCS: TestCase_testScalarModVec4Int32, time elapsed: 207000 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Int32 (10000 ns)
    TCS: TestCase_testScalarSubVec1PackedMediump, time elapsed: 210200 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1PackedMediump (12000 ns)
    TCS: TestCase_testScalarSubVec1PackedLowp, time elapsed: 252600 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1PackedLowp (10700 ns)
    TCS: TestCase_testScalarSubVec3PackedMediump, time elapsed: 199300 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3PackedMediump (18200 ns)
    TCS: TestCase_testScalarSubVec3PackedLowp, time elapsed: 219100 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3PackedLowp (11600 ns)
    TCS: TestCase_testScalarSubVec4PackedMediump, time elapsed: 202900 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4PackedMediump (10300 ns)
    TCS: TestCase_testScalarSubVec4PackedLowp, time elapsed: 284700 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4PackedLowp (15100 ns)
    TCS: TestCase_testScalarMulVec1PackedMediump, time elapsed: 211600 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1PackedMediump (10600 ns)
    TCS: TestCase_testScalarMulVec1PackedLowp, time elapsed: 207300 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1PackedLowp (12800 ns)
    TCS: TestCase_testScalarMulVec3PackedMediump, time elapsed: 193900 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3PackedMediump (10800 ns)
    TCS: TestCase_testScalarMulVec3PackedLowp, time elapsed: 218300 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3PackedLowp (10500 ns)
    TCS: TestCase_testScalarMulVec4PackedMediump, time elapsed: 213700 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4PackedMediump (10700 ns)
    TCS: TestCase_testScalarMulVec4PackedLowp, time elapsed: 200500 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4PackedLowp (11200 ns)
    TCS: TestCase_testScalarDivVec1PackedMediump, time elapsed: 213600 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1PackedMediump (9200 ns)
    TCS: TestCase_testScalarDivVec1PackedLowp, time elapsed: 226000 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1PackedLowp (12200 ns)
    TCS: TestCase_testScalarDivVec3PackedMediump, time elapsed: 207400 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3PackedMediump (9900 ns)
    TCS: TestCase_testScalarDivVec3PackedLowp, time elapsed: 196900 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3PackedLowp (9600 ns)
    TCS: TestCase_testScalarDivVec4PackedMediump, time elapsed: 212000 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4PackedMediump (10600 ns)
    TCS: TestCase_testScalarDivVec4PackedLowp, time elapsed: 196000 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4PackedLowp (10100 ns)
    TCS: TestCase_testScalarModVec1PackedMediump, time elapsed: 215200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1PackedMediump (15000 ns)
    TCS: TestCase_testScalarModVec1PackedLowp, time elapsed: 223200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1PackedLowp (10200 ns)
    TCS: TestCase_testScalarModVec3PackedMediump, time elapsed: 218900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3PackedMediump (13400 ns)
    TCS: TestCase_testScalarModVec3PackedLowp, time elapsed: 206100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3PackedLowp (10700 ns)
    TCS: TestCase_testScalarModVec4PackedMediump, time elapsed: 210300 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4PackedMediump (10300 ns)
    TCS: TestCase_testScalarModVec4PackedLowp, time elapsed: 210400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4PackedLowp (15400 ns)
    TCS: TestCase_testScalarDivZeroVec1, time elapsed: 216600 ns, RESULT:
    [ PASSED ] CASE: testScalarDivZeroVec1 (14300 ns)
    TCS: TestCase_testScalarAddNegVec1, time elapsed: 219000 ns, RESULT:
    [ PASSED ] CASE: testScalarAddNegVec1 (11600 ns)
    TCS: TestCase_testScalarAddNegVec2, time elapsed: 195900 ns, RESULT:
    [ PASSED ] CASE: testScalarAddNegVec2 (13100 ns)
    TCS: TestCase_testScalarMulOverflowVec1, time elapsed: 221800 ns, RESULT:
    [ PASSED ] CASE: testScalarMulOverflowVec1 (9600 ns)
    TCS: TestCase_testScalarSubNegVec1, time elapsed: 498400 ns, RESULT:
    [ PASSED ] CASE: testScalarSubNegVec1 (21900 ns)
    TCS: TestCase_testVersionMajor, time elapsed: 195300 ns, RESULT:
    [ PASSED ] CASE: testVersionMajor (12100 ns)
    TCS: TestCase_testVersionMinor, time elapsed: 193500 ns, RESULT:
    [ PASSED ] CASE: testVersionMinor (8000 ns)
    TCS: TestCase_testVersionPatch, time elapsed: 185000 ns, RESULT:
    [ PASSED ] CASE: testVersionPatch (9100 ns)
    TCS: TestCase_testVersionEncoded, time elapsed: 192200 ns, RESULT:
    [ PASSED ] CASE: testVersionEncoded (13600 ns)
    TCS: TestCase_testConfigSimd, time elapsed: 198000 ns, RESULT:
    [ PASSED ] CASE: testConfigSimd (13500 ns)
    TCS: TestCase_testConfigAlignedGentypes, time elapsed: 194400 ns, RESULT:
    [ PASSED ] CASE: testConfigAlignedGentypes (12100 ns)
    TCS: TestCase_testConfigClipControl, time elapsed: 190000 ns, RESULT:
    [ PASSED ] CASE: testConfigClipControl (8800 ns)
    TCS: TestCase_testConstNegationSimd, time elapsed: 185600 ns, RESULT:
    [ PASSED ] CASE: testConstNegationSimd (7800 ns)
    TCS: TestCase_testConstNegationAligned, time elapsed: 178700 ns, RESULT:
    [ PASSED ] CASE: testConstNegationAligned (7700 ns)
    TCS: TestCase_testConstNegationClip, time elapsed: 182800 ns, RESULT:
    [ PASSED ] CASE: testConstNegationClip (8200 ns)
    TCS: TestCase_testConstInt64Usage, time elapsed: 189500 ns, RESULT:
    [ PASSED ] CASE: testConstInt64Usage (8300 ns)
    TCS: TestCase_testConstBoolUsage, time elapsed: 216500 ns, RESULT:
    [ PASSED ] CASE: testConstBoolUsage (14000 ns)
    TCS: TestCase_testVersionEncodingConsistency, time elapsed: 184100 ns, RESULT:
    [ PASSED ] CASE: testVersionEncodingConsistency (7700 ns)
    TCS: TestCase_testAssertPasses, time elapsed: 230700 ns, RESULT:
    [ PASSED ] CASE: testAssertPasses (22100 ns)
    TCS: TestCase_testAssertFails, time elapsed: 306700 ns, RESULT:
    [ PASSED ] CASE: testAssertFails (109200 ns)
    TCS: TestCase_testAssertWithCustomMessage, time elapsed: 290600 ns, RESULT:
    [ PASSED ] CASE: testAssertWithCustomMessage (65300 ns)
    TCS: TestCase_testNumericLimitsFloat32Epsilon, time elapsed: 301800 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsFloat32Epsilon (31200 ns)
    TCS: TestCase_testNumericLimitsFloat64Epsilon, time elapsed: 305000 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsFloat64Epsilon (20800 ns)
    TCS: TestCase_testIsIec559OfFloat32, time elapsed: 293200 ns, RESULT:
    [ PASSED ] CASE: testIsIec559OfFloat32 (16000 ns)
    TCS: TestCase_testIsIec559OfFloat64, time elapsed: 286200 ns, RESULT:
    [ PASSED ] CASE: testIsIec559OfFloat64 (13000 ns)
    TCS: TestCase_testIsIec559OfInt64, time elapsed: 235000 ns, RESULT:
    [ PASSED ] CASE: testIsIec559OfInt64 (16700 ns)
    TCS: TestCase_testEpsilonOfFloat32, time elapsed: 234200 ns, RESULT:
    [ PASSED ] CASE: testEpsilonOfFloat32 (15700 ns)
    TCS: TestCase_testEpsilonOfFloat64, time elapsed: 224500 ns, RESULT:
    [ PASSED ] CASE: testEpsilonOfFloat64 (18600 ns)
    TCS: TestCase_testNumericLimitsInt64Epsilon, time elapsed: 223300 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt64Epsilon (11500 ns)
    TCS: TestCase_testNumericLimitsInt32Epsilon, time elapsed: 210100 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt32Epsilon (11700 ns)
    TCS: TestCase_testNumericLimitsInt16Epsilon, time elapsed: 214500 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt16Epsilon (22100 ns)
    TCS: TestCase_testNumericLimitsInt8Epsilon, time elapsed: 204300 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt8Epsilon (11800 ns)
    TCS: TestCase_testCastVec1ToVec1IntToFloat, time elapsed: 206000 ns, RESULT:
    [ PASSED ] CASE: testCastVec1ToVec1IntToFloat (23900 ns)
    TCS: TestCase_testCastVec2ToVec1TakesOnlyX, time elapsed: 292300 ns, RESULT:
    [ PASSED ] CASE: testCastVec2ToVec1TakesOnlyX (17900 ns)
    TCS: TestCase_testCastVec3ToVec1TakesOnlyX, time elapsed: 229600 ns, RESULT:
    [ PASSED ] CASE: testCastVec3ToVec1TakesOnlyX (10200 ns)
    TCS: TestCase_testCastVec4ToVec1TakesOnlyX, time elapsed: 196100 ns, RESULT:
    [ PASSED ] CASE: testCastVec4ToVec1TakesOnlyX (9500 ns)
    TCS: TestCase_testCastSameTypeIdentity, time elapsed: 214700 ns, RESULT:
    [ PASSED ] CASE: testCastSameTypeIdentity (9300 ns)
    TCS: TestCase_testCastInt32ToInt64, time elapsed: 370000 ns, RESULT:
    [ PASSED ] CASE: testCastInt32ToInt64 (30100 ns)
    TCS: TestCase_testCastFloatToIntTruncation, time elapsed: 314800 ns, RESULT:
    [ PASSED ] CASE: testCastFloatToIntTruncation (36600 ns)
    TCS: TestCase_testCastCrossQualifierPackedHighpToDefaultp, time elapsed: 311700 ns, RESULT:
    [ PASSED ] CASE: testCastCrossQualifierPackedHighpToDefaultp (28900 ns)
    TCS: TestCase_testCastCrossQualifierDefaultpToPackedHighp, time elapsed: 340000 ns, RESULT:
    [ PASSED ] CASE: testCastCrossQualifierDefaultpToPackedHighp (27500 ns)
    TCS: TestCase_testCastVec2CrossQualifierCrossType, time elapsed: 294100 ns, RESULT:
    [ PASSED ] CASE: testCastVec2CrossQualifierCrossType (29500 ns)
    TCS: TestCase_testCastVec3CrossQualifier, time elapsed: 297600 ns, RESULT:
    [ PASSED ] CASE: testCastVec3CrossQualifier (28600 ns)
    TCS: TestCase_testCastVec4CrossQualifier, time elapsed: 323600 ns, RESULT:
    [ PASSED ] CASE: testCastVec4CrossQualifier (34600 ns)
    TCS: TestCase_testCastVec1DoesNotModifySource, time elapsed: 234800 ns, RESULT:
    [ PASSED ] CASE: testCastVec1DoesNotModifySource (12800 ns)
    TCS: TestCase_testCastVec2Vec1ToVec2IntToFloat, time elapsed: 245200 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec1ToVec2IntToFloat (21800 ns)
    TCS: TestCase_testCastVec2Vec2ToVec2Identity, time elapsed: 643500 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec2ToVec2Identity (11900 ns)
    TCS: TestCase_testCastVec2Vec3ToVec2TakesOnlyXY, time elapsed: 526500 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec3ToVec2TakesOnlyXY (45800 ns)
    TCS: TestCase_testCastVec2Vec4ToVec2TakesOnlyXY, time elapsed: 513600 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec4ToVec2TakesOnlyXY (63600 ns)
    TCS: TestCase_testCastVec2SameTypeIdentity, time elapsed: 492400 ns, RESULT:
    [ PASSED ] CASE: testCastVec2SameTypeIdentity (22700 ns)
    TCS: TestCase_testCastVec2Int32ToInt64, time elapsed: 491700 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Int32ToInt64 (19500 ns)
    TCS: TestCase_testCastVec2FloatToIntTruncation, time elapsed: 334200 ns, RESULT:
    [ PASSED ] CASE: testCastVec2FloatToIntTruncation (13500 ns)
    TCS: TestCase_testCastVec2CrossQualifierPackedHighpToDefaultp, time elapsed: 298100 ns, RESULT:
    [ PASSED ] CASE: testCastVec2CrossQualifierPackedHighpToDefaultp (11800 ns)
    TCS: TestCase_testCastVec2DoesNotModifySource, time elapsed: 193500 ns, RESULT:
    [ PASSED ] CASE: testCastVec2DoesNotModifySource (7300 ns)
    TCS: TestCase_testCastVec2Vec1ToVec2SameValueBothComponents, time elapsed: 424000 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec1ToVec2SameValueBothComponents (20600 ns)
    TCS: TestCase_testCastVec3Vec1ToVec3IntToFloat, time elapsed: 258300 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec1ToVec3IntToFloat (21200 ns)
    TCS: TestCase_testCastVec3Vec2ToVec3ExtendY, time elapsed: 288800 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec2ToVec3ExtendY (14600 ns)
    TCS: TestCase_testCastVec3Vec3ToVec3Identity, time elapsed: 225500 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec3ToVec3Identity (17900 ns)
    TCS: TestCase_testCastVec3Vec4ToVec3TakesOnlyXYZ, time elapsed: 345300 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec4ToVec3TakesOnlyXYZ (12500 ns)
    TCS: TestCase_testCastVec3SameTypeIdentity, time elapsed: 306100 ns, RESULT:
    [ PASSED ] CASE: testCastVec3SameTypeIdentity (16100 ns)
    TCS: TestCase_testCastVec3Int32ToInt64, time elapsed: 224000 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Int32ToInt64 (13700 ns)
    TCS: TestCase_testCastVec3FloatToIntTruncation, time elapsed: 382600 ns, RESULT:
    [ PASSED ] CASE: testCastVec3FloatToIntTruncation (14900 ns)
    TCS: TestCase_testCastVec3CrossQualifierPackedHighpToDefaultp, time elapsed: 343600 ns, RESULT:
    [ PASSED ] CASE: testCastVec3CrossQualifierPackedHighpToDefaultp (15400 ns)
    TCS: TestCase_testCastVec3DoesNotModifySource, time elapsed: 228800 ns, RESULT:
    [ PASSED ] CASE: testCastVec3DoesNotModifySource (13000 ns)
    TCS: TestCase_testCastVec3Vec1ToVec3SameValueAllComponents, time elapsed: 195900 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec1ToVec3SameValueAllComponents (8300 ns)
    TCS: TestCase_testCastVec4Vec1ToVec4IntToFloat, time elapsed: 192400 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec1ToVec4IntToFloat (15300 ns)
    TCS: TestCase_testCastVec4Vec2ToVec4ExtendY, time elapsed: 197100 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec2ToVec4ExtendY (10900 ns)
    TCS: TestCase_testCastVec4Vec3ToVec4ExtendZ, time elapsed: 183800 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec3ToVec4ExtendZ (9200 ns)
    TCS: TestCase_testCastVec4Vec4ToVec4Identity, time elapsed: 183500 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec4ToVec4Identity (9900 ns)
    TCS: TestCase_testCastVec4SameTypeIdentity, time elapsed: 227600 ns, RESULT:
    [ PASSED ] CASE: testCastVec4SameTypeIdentity (7900 ns)
    TCS: TestCase_testCastVec4Int32ToInt64, time elapsed: 196000 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Int32ToInt64 (8900 ns)
    TCS: TestCase_testCastVec4FloatToIntTruncation, time elapsed: 187600 ns, RESULT:
    [ PASSED ] CASE: testCastVec4FloatToIntTruncation (8200 ns)
    TCS: TestCase_testCastVec4CrossQualifierPackedHighpToDefaultp, time elapsed: 213000 ns, RESULT:
    [ PASSED ] CASE: testCastVec4CrossQualifierPackedHighpToDefaultp (7900 ns)
    TCS: TestCase_testCastVec4DoesNotModifySource, time elapsed: 214900 ns, RESULT:
    [ PASSED ] CASE: testCastVec4DoesNotModifySource (11900 ns)
    TCS: TestCase_testCastVec4Vec1ToVec4SameValueAllComponents, time elapsed: 238800 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec1ToVec4SameValueAllComponents (10200 ns)
    TCS: TestCase_testFromBoolVec1, time elapsed: 217800 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec1 (8400 ns)
    TCS: TestCase_testFromBoolVec1False, time elapsed: 275200 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec1False (8900 ns)
    TCS: TestCase_testFromBoolVec2, time elapsed: 200300 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec2 (8300 ns)
    TCS: TestCase_testFromBoolVec3, time elapsed: 232700 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec3 (16300 ns)
    TCS: TestCase_testFromBoolVec4, time elapsed: 200900 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec4 (10400 ns)
    TCS: TestCase_testFromBoolVecQ2Vec1, time elapsed: 196500 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec1 (17900 ns)
    TCS: TestCase_testFromBoolVecQ2Vec2, time elapsed: 185900 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec2 (6500 ns)
    TCS: TestCase_testFromBoolVecQ2Vec3, time elapsed: 187800 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec3 (6400 ns)
    TCS: TestCase_testFromBoolVecQ2Vec4, time elapsed: 191400 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec4 (9400 ns)
    TCS: TestCase_testFromBoolVec3AllFalse, time elapsed: 266000 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec3AllFalse (9700 ns)
    TCS: TestCase_testFromBoolVec4AllFalse, time elapsed: 271300 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec4AllFalse (11700 ns)
    TCS: TestCase_testFromBoolVecQ2Vec3AllFalse, time elapsed: 249600 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec3AllFalse (10500 ns)
    TCS: TestCase_testFromBoolVecQ2Vec4AllFalse, time elapsed: 243700 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec4AllFalse (9800 ns)
    TCS: TestCase_testFromBoolVecFloat32, time elapsed: 279400 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecFloat32 (13400 ns)
    TCS: TestCase_testFromBoolVecFloat64, time elapsed: 243000 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecFloat64 (10900 ns)
    TCS: TestCase_testFromBoolVecInt32, time elapsed: 240000 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecInt32 (15900 ns)
    TCS: TestCase_testFromBoolVecQ2PackedMediump, time elapsed: 288000 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2PackedMediump (13700 ns)
    TCS: TestCase_testFromBoolVecQ2PackedLowp, time elapsed: 254100 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2PackedLowp (11700 ns)
    TCS: TestCase_testS1QuatCastScalingXBranch, time elapsed: 350200 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastScalingXBranch (88700 ns)
    TCS: TestCase_testS1QuatCastScalingYBranch, time elapsed: 222300 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastScalingYBranch (31000 ns)
    TCS: TestCase_testS1QuatCastScalingZBranch, time elapsed: 198200 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastScalingZBranch (21600 ns)
    TCS: TestCase_testS1QuatCastScalingWBranch, time elapsed: 352100 ns, RESULT:
    [ FAILED ] CASE: testS1QuatCastScalingWBranch (58000 ns)
    Expect Failed: `(m0.c0.equalEpsilon(m1.c0) && m0.c1.equalEpsilon(m1.c1) && m0.c2.equalEpsilon(m1.c2) == true)`
       left: false
      right: true

    TCS: TestCase_testS1QuatCastUnitRoundTrip, time elapsed: 216100 ns, RESULT:
    [ FAILED ] CASE: testS1QuatCastUnitRoundTrip (15800 ns)
    Expect Failed: `(m0.c0.equalEpsilon(m1.c0) && m0.c1.equalEpsilon(m1.c1) && m0.c2.equalEpsilon(m1.c2) == true)`
       left: false
      right: true

    TCS: TestCase_testS1QuatCastIdentityRoundTrip, time elapsed: 202400 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastIdentityRoundTrip (16500 ns)
    TCS: TestCase_testS1QuatCastMat4Delegation, time elapsed: 245900 ns, RESULT:
    [ FAILED ] CASE: testS1QuatCastMat4Delegation (38300 ns)
    Expect Failed: `(m0.c0.equalEpsilon(m1.c0) && m0.c1.equalEpsilon(m1.c1) && m0.c2.equalEpsilon(m1.c2) == true)`
       left: false
      right: true

    TCS: TestCase_testVec2ScalarInit, time elapsed: 224200 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarInit (17500 ns)
    TCS: TestCase_testVec2ConstInit, time elapsed: 192600 ns, RESULT:
    [ PASSED ] CASE: testVec2ConstInit (6100 ns)
    TCS: TestCase_testVec2Length, time elapsed: 194500 ns, RESULT:
    [ PASSED ] CASE: testVec2Length (7200 ns)
    TCS: TestCase_testVec2Add, time elapsed: 213400 ns, RESULT:
    [ PASSED ] CASE: testVec2Add (15500 ns)
    TCS: TestCase_testVec2Sub, time elapsed: 193000 ns, RESULT:
    [ PASSED ] CASE: testVec2Sub (10200 ns)
    TCS: TestCase_testVec2Mul, time elapsed: 181400 ns, RESULT:
    [ PASSED ] CASE: testVec2Mul (12200 ns)
    TCS: TestCase_testVec2ScalarAdd, time elapsed: 192400 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarAdd (11700 ns)
    TCS: TestCase_testVec2Negate, time elapsed: 225100 ns, RESULT:
    [ PASSED ] CASE: testVec2Negate (11300 ns)
    TCS: TestCase_testVec2IndexAccess, time elapsed: 204900 ns, RESULT:
    [ PASSED ] CASE: testVec2IndexAccess (11000 ns)
    TCS: TestCase_testVec2IndexMutate, time elapsed: 205600 ns, RESULT:
    [ PASSED ] CASE: testVec2IndexMutate (6600 ns)
    TCS: TestCase_testVec2ComponentAt, time elapsed: 205600 ns, RESULT:
    [ PASSED ] CASE: testVec2ComponentAt (7500 ns)
    TCS: TestCase_testVec2Equal, time elapsed: 206500 ns, RESULT:
    [ PASSED ] CASE: testVec2Equal (14800 ns)
    TCS: TestCase_testVec2NotEqual, time elapsed: 217100 ns, RESULT:
    [ PASSED ] CASE: testVec2NotEqual (17200 ns)
    TCS: TestCase_testVec2EqualExact, time elapsed: 207000 ns, RESULT:
    [ PASSED ] CASE: testVec2EqualExact (14800 ns)
    TCS: TestCase_testVec2BitwiseAnd, time elapsed: 194600 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseAnd (12500 ns)
    TCS: TestCase_testVec2BitwiseNot, time elapsed: 196400 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseNot (11900 ns)
    TCS: TestCase_testVec2FromVec1, time elapsed: 200800 ns, RESULT:
    [ PASSED ] CASE: testVec2FromVec1 (7300 ns)
    TCS: TestCase_testVec2ShiftLeft, time elapsed: 192400 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftLeft (11100 ns)
    TCS: TestCase_testVec2BoolLogicalAnd, time elapsed: 196300 ns, RESULT:
    [ PASSED ] CASE: testVec2BoolLogicalAnd (12500 ns)
    TCS: TestCase_testVec2Vec1ArithBroadcast, time elapsed: 192600 ns, RESULT:
    [ PASSED ] CASE: testVec2Vec1ArithBroadcast (9700 ns)
    TCS: TestCase_testVec2Vec1BitBroadcast, time elapsed: 179800 ns, RESULT:
    [ PASSED ] CASE: testVec2Vec1BitBroadcast (9500 ns)
    TCS: TestCase_testVec2ShiftLeftVec1, time elapsed: 201900 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftLeftVec1 (11400 ns)
    TCS: TestCase_testVec2Div, time elapsed: 202000 ns, RESULT:
    [ PASSED ] CASE: testVec2Div (10900 ns)
    TCS: TestCase_testVec2Mod, time elapsed: 184700 ns, RESULT:
    [ PASSED ] CASE: testVec2Mod (9100 ns)
    TCS: TestCase_testVec2ScalarSub, time elapsed: 201100 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarSub (13000 ns)
    TCS: TestCase_testVec2ScalarMul, time elapsed: 201000 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarMul (9200 ns)
    TCS: TestCase_testVec2ScalarDiv, time elapsed: 185000 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarDiv (9100 ns)
    TCS: TestCase_testVec2ScalarMod, time elapsed: 187200 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarMod (6200 ns)
    TCS: TestCase_testVec2BoolLogicalOr, time elapsed: 199000 ns, RESULT:
    [ PASSED ] CASE: testVec2BoolLogicalOr (6900 ns)
    TCS: TestCase_testVec2EqualEpsilon, time elapsed: 174900 ns, RESULT:
    [ PASSED ] CASE: testVec2EqualEpsilon (16100 ns)
    TCS: TestCase_testVec2DivNamed, time elapsed: 189700 ns, RESULT:
    [ PASSED ] CASE: testVec2DivNamed (6300 ns)
    TCS: TestCase_testVec2ModNamed, time elapsed: 184100 ns, RESULT:
    [ PASSED ] CASE: testVec2ModNamed (6500 ns)
    TCS: TestCase_testVec2BitwiseOr, time elapsed: 208800 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseOr (9400 ns)
    TCS: TestCase_testVec2BitwiseXor, time elapsed: 289500 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseXor (10700 ns)
    TCS: TestCase_testVec2ScalarBitwiseAnd, time elapsed: 231700 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarBitwiseAnd (9100 ns)
    TCS: TestCase_testVec2ShiftRight, time elapsed: 265500 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftRight (36200 ns)
    TCS: TestCase_testVec2ShiftRightVec1, time elapsed: 198900 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftRightVec1 (9800 ns)
    TCS: TestCase_testVec2AddNamed, time elapsed: 185700 ns, RESULT:
    [ PASSED ] CASE: testVec2AddNamed (8300 ns)
    TCS: TestCase_testVec2SubNamed, time elapsed: 186100 ns, RESULT:
    [ PASSED ] CASE: testVec2SubNamed (7900 ns)
    TCS: TestCase_testVec2MulNamed, time elapsed: 226500 ns, RESULT:
    [ PASSED ] CASE: testVec2MulNamed (7900 ns)
    TCS: TestCase_testVec2ShiftLeftVec, time elapsed: 188400 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftLeftVec (12800 ns)
    TCS: TestCase_testVec2ShiftRightVec, time elapsed: 166900 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftRightVec (6200 ns)
    TCS: TestCase_testVec2ScalarBitwiseOr, time elapsed: 169700 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarBitwiseOr (6300 ns)
    TCS: TestCase_testVec2ScalarBitwiseXor, time elapsed: 174700 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarBitwiseXor (15400 ns)
    TCS: TestCase_testVec2Increment, time elapsed: 176100 ns, RESULT:
    [ PASSED ] CASE: testVec2Increment (11900 ns)
    TCS: TestCase_testVec2Decrement, time elapsed: 171100 ns, RESULT:
    [ PASSED ] CASE: testVec2Decrement (9300 ns)
    TCS: TestCase_testVec2IndexOutOfBoundsAccess, time elapsed: 244400 ns, RESULT:
    [ PASSED ] CASE: testVec2IndexOutOfBoundsAccess (74000 ns)
    TCS: TestCase_testVec2NegativeIndexAccess, time elapsed: 206100 ns, RESULT:
    [ PASSED ] CASE: testVec2NegativeIndexAccess (35300 ns)
    TCS: TestCase_testVec3ScalarInit, time elapsed: 169400 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarInit (11100 ns)
    TCS: TestCase_testVec3ConstInit, time elapsed: 174200 ns, RESULT:
    [ PASSED ] CASE: testVec3ConstInit (6100 ns)
    TCS: TestCase_testVec3Length, time elapsed: 160200 ns, RESULT:
    [ PASSED ] CASE: testVec3Length (4900 ns)
    TCS: TestCase_testVec3Add, time elapsed: 175000 ns, RESULT:
    [ PASSED ] CASE: testVec3Add (16200 ns)
    TCS: TestCase_testVec3ScalarMul, time elapsed: 216600 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarMul (11800 ns)
    TCS: TestCase_testVec3Negate, time elapsed: 177100 ns, RESULT:
    [ PASSED ] CASE: testVec3Negate (8400 ns)
    TCS: TestCase_testVec3IndexAccess, time elapsed: 171000 ns, RESULT:
    [ PASSED ] CASE: testVec3IndexAccess (6100 ns)
    TCS: TestCase_testVec3IndexMutate, time elapsed: 173000 ns, RESULT:
    [ PASSED ] CASE: testVec3IndexMutate (7900 ns)
    TCS: TestCase_testVec3ComponentAt, time elapsed: 202400 ns, RESULT:
    [ PASSED ] CASE: testVec3ComponentAt (6100 ns)
    TCS: TestCase_testVec3Equal, time elapsed: 305100 ns, RESULT:
    [ PASSED ] CASE: testVec3Equal (23000 ns)
    TCS: TestCase_testVec3NotEqual, time elapsed: 204700 ns, RESULT:
    [ PASSED ] CASE: testVec3NotEqual (20300 ns)
    TCS: TestCase_testVec3EqualExact, time elapsed: 202100 ns, RESULT:
    [ PASSED ] CASE: testVec3EqualExact (10800 ns)
    TCS: TestCase_testVec3BitwiseAnd, time elapsed: 211700 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseAnd (12000 ns)
    TCS: TestCase_testVec3BitwiseNot, time elapsed: 185900 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseNot (6300 ns)
    TCS: TestCase_testVec3Vec1ArithBroadcast, time elapsed: 219900 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1ArithBroadcast (30800 ns)
    TCS: TestCase_testVec3ShiftLeft, time elapsed: 231300 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftLeft (13900 ns)
    TCS: TestCase_testVec3BoolLogicalAnd, time elapsed: 202400 ns, RESULT:
    [ PASSED ] CASE: testVec3BoolLogicalAnd (12400 ns)
    TCS: TestCase_testVec3Sub, time elapsed: 203500 ns, RESULT:
    [ PASSED ] CASE: testVec3Sub (13300 ns)
    TCS: TestCase_testVec3Div, time elapsed: 244300 ns, RESULT:
    [ PASSED ] CASE: testVec3Div (15900 ns)
    TCS: TestCase_testVec3Mod, time elapsed: 244900 ns, RESULT:
    [ PASSED ] CASE: testVec3Mod (21000 ns)
    TCS: TestCase_testVec3ScalarSub, time elapsed: 236000 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarSub (18100 ns)
    TCS: TestCase_testVec3ScalarDiv, time elapsed: 194000 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarDiv (10500 ns)
    TCS: TestCase_testVec3ScalarMod, time elapsed: 191700 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarMod (10700 ns)
    TCS: TestCase_testVec3BoolLogicalOr, time elapsed: 200000 ns, RESULT:
    [ PASSED ] CASE: testVec3BoolLogicalOr (8600 ns)
    TCS: TestCase_testVec3EqualEpsilon, time elapsed: 200300 ns, RESULT:
    [ PASSED ] CASE: testVec3EqualEpsilon (15000 ns)
    TCS: TestCase_testVec3AddNamed, time elapsed: 189200 ns, RESULT:
    [ PASSED ] CASE: testVec3AddNamed (14400 ns)
    TCS: TestCase_testVec3MulNamed, time elapsed: 196500 ns, RESULT:
    [ PASSED ] CASE: testVec3MulNamed (7000 ns)
    TCS: TestCase_testVec3DivNamed, time elapsed: 195100 ns, RESULT:
    [ PASSED ] CASE: testVec3DivNamed (7000 ns)
    TCS: TestCase_testVec3ModNamed, time elapsed: 166500 ns, RESULT:
    [ PASSED ] CASE: testVec3ModNamed (6500 ns)
    TCS: TestCase_testVec3BitwiseOr, time elapsed: 201800 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseOr (11300 ns)
    TCS: TestCase_testVec3BitwiseXor, time elapsed: 186800 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseXor (10000 ns)
    TCS: TestCase_testVec3ScalarBitwiseAnd, time elapsed: 231100 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarBitwiseAnd (13700 ns)
    TCS: TestCase_testVec3ShiftRight, time elapsed: 192800 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftRight (8800 ns)
    TCS: TestCase_testVec3Vec1BitBroadcast, time elapsed: 196700 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1BitBroadcast (12100 ns)
    TCS: TestCase_testVec3ShiftRightVec1, time elapsed: 181400 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftRightVec1 (10100 ns)
    TCS: TestCase_testVec3FromVec1, time elapsed: 195400 ns, RESULT:
    [ PASSED ] CASE: testVec3FromVec1 (7300 ns)
    TCS: TestCase_testVec3ScalarBitwiseOr, time elapsed: 218300 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarBitwiseOr (12800 ns)
    TCS: TestCase_testVec3ScalarBitwiseXor, time elapsed: 185500 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarBitwiseXor (10200 ns)
    TCS: TestCase_testVec3Vec1BitOrBroadcast, time elapsed: 207500 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1BitOrBroadcast (12900 ns)
    TCS: TestCase_testVec3Vec1BitXorBroadcast, time elapsed: 356500 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1BitXorBroadcast (18000 ns)
    TCS: TestCase_testVec3ShiftLeftVec1, time elapsed: 203900 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftLeftVec1 (16900 ns)
    TCS: TestCase_testVec3ShiftLeftVec, time elapsed: 192400 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftLeftVec (10300 ns)
    TCS: TestCase_testVec3ShiftRightVec, time elapsed: 170200 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftRightVec (9700 ns)
    TCS: TestCase_testVec3Increment, time elapsed: 177100 ns, RESULT:
    [ PASSED ] CASE: testVec3Increment (13200 ns)
    TCS: TestCase_testVec3Decrement, time elapsed: 176400 ns, RESULT:
    [ PASSED ] CASE: testVec3Decrement (12200 ns)
    TCS: TestCase_testVec3IndexOutOfBoundsAccess, time elapsed: 230200 ns, RESULT:
    [ PASSED ] CASE: testVec3IndexOutOfBoundsAccess (51200 ns)
    TCS: TestCase_testVec3NegativeIndexAccess, time elapsed: 194100 ns, RESULT:
    [ PASSED ] CASE: testVec3NegativeIndexAccess (22900 ns)
    TCS: TestCase_testVec4ScalarInit, time elapsed: 174800 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarInit (10900 ns)
    TCS: TestCase_testVec4ConstInit, time elapsed: 165700 ns, RESULT:
    [ PASSED ] CASE: testVec4ConstInit (5900 ns)
    TCS: TestCase_testVec4Length, time elapsed: 172900 ns, RESULT:
    [ PASSED ] CASE: testVec4Length (7300 ns)
    TCS: TestCase_testVec4Add, time elapsed: 191100 ns, RESULT:
    [ PASSED ] CASE: testVec4Add (17500 ns)
    TCS: TestCase_testVec4ScalarMul, time elapsed: 179200 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarMul (13300 ns)
    TCS: TestCase_testVec4Negate, time elapsed: 173900 ns, RESULT:
    [ PASSED ] CASE: testVec4Negate (10600 ns)
    TCS: TestCase_testVec4IndexAccess, time elapsed: 165700 ns, RESULT:
    [ PASSED ] CASE: testVec4IndexAccess (6300 ns)
    TCS: TestCase_testVec4IndexMutate, time elapsed: 174900 ns, RESULT:
    [ PASSED ] CASE: testVec4IndexMutate (8500 ns)
    TCS: TestCase_testVec4ComponentAt, time elapsed: 163800 ns, RESULT:
    [ PASSED ] CASE: testVec4ComponentAt (6200 ns)
    TCS: TestCase_testVec4Equal, time elapsed: 170400 ns, RESULT:
    [ PASSED ] CASE: testVec4Equal (11200 ns)
    TCS: TestCase_testVec4NotEqual, time elapsed: 180900 ns, RESULT:
    [ PASSED ] CASE: testVec4NotEqual (14500 ns)
    TCS: TestCase_testVec4EqualExact, time elapsed: 195600 ns, RESULT:
    [ PASSED ] CASE: testVec4EqualExact (16300 ns)
    TCS: TestCase_testVec4BitwiseAnd, time elapsed: 210300 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseAnd (15400 ns)
    TCS: TestCase_testVec4BitwiseNot, time elapsed: 166800 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseNot (6200 ns)
    TCS: TestCase_testVec4Vec1ArithBroadcast, time elapsed: 172300 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1ArithBroadcast (14400 ns)
    TCS: TestCase_testVec4ShiftLeft, time elapsed: 170600 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftLeft (10100 ns)
    TCS: TestCase_testVec4BoolLogicalAnd, time elapsed: 177700 ns, RESULT:
    [ PASSED ] CASE: testVec4BoolLogicalAnd (9600 ns)
    TCS: TestCase_testVec4Sub, time elapsed: 194200 ns, RESULT:
    [ PASSED ] CASE: testVec4Sub (23500 ns)
    TCS: TestCase_testVec4Div, time elapsed: 191000 ns, RESULT:
    [ PASSED ] CASE: testVec4Div (12300 ns)
    TCS: TestCase_testVec4Mod, time elapsed: 197800 ns, RESULT:
    [ PASSED ] CASE: testVec4Mod (17700 ns)
    TCS: TestCase_testVec4ScalarSub, time elapsed: 189400 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarSub (11300 ns)
    TCS: TestCase_testVec4ScalarDiv, time elapsed: 222600 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarDiv (39600 ns)
    TCS: TestCase_testVec4ScalarMod, time elapsed: 207700 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarMod (16900 ns)
    TCS: TestCase_testVec4BoolLogicalOr, time elapsed: 204000 ns, RESULT:
    [ PASSED ] CASE: testVec4BoolLogicalOr (8600 ns)
    TCS: TestCase_testVec4EqualEpsilon, time elapsed: 214000 ns, RESULT:
    [ PASSED ] CASE: testVec4EqualEpsilon (19400 ns)
    TCS: TestCase_testVec4AddNamed, time elapsed: 191100 ns, RESULT:
    [ PASSED ] CASE: testVec4AddNamed (11800 ns)
    TCS: TestCase_testVec4MulNamed, time elapsed: 203600 ns, RESULT:
    [ PASSED ] CASE: testVec4MulNamed (8400 ns)
    TCS: TestCase_testVec4DivNamed, time elapsed: 201800 ns, RESULT:
    [ PASSED ] CASE: testVec4DivNamed (11000 ns)
    TCS: TestCase_testVec4ModNamed, time elapsed: 195600 ns, RESULT:
    [ PASSED ] CASE: testVec4ModNamed (10400 ns)
    TCS: TestCase_testVec4BitwiseOr, time elapsed: 189800 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseOr (11400 ns)
    TCS: TestCase_testVec4BitwiseXor, time elapsed: 282700 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseXor (19200 ns)
    TCS: TestCase_testVec4ScalarBitwiseAnd, time elapsed: 300300 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarBitwiseAnd (35300 ns)
    TCS: TestCase_testVec4ShiftRight, time elapsed: 279600 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftRight (18900 ns)
    TCS: TestCase_testVec4Vec1BitBroadcast, time elapsed: 219700 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1BitBroadcast (16100 ns)
    TCS: TestCase_testVec4ShiftRightVec1, time elapsed: 209000 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftRightVec1 (10400 ns)
    TCS: TestCase_testVec4FromVec1, time elapsed: 199900 ns, RESULT:
    [ PASSED ] CASE: testVec4FromVec1 (8300 ns)
    TCS: TestCase_testVec4ScalarBitwiseOr, time elapsed: 183900 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarBitwiseOr (10300 ns)
    TCS: TestCase_testVec4ScalarBitwiseXor, time elapsed: 196200 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarBitwiseXor (10100 ns)
    TCS: TestCase_testVec4Vec1BitOrBroadcast, time elapsed: 202300 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1BitOrBroadcast (26600 ns)
    TCS: TestCase_testVec4Vec1BitXorBroadcast, time elapsed: 188100 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1BitXorBroadcast (12100 ns)
    TCS: TestCase_testVec4ShiftLeftVec1, time elapsed: 194700 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftLeftVec1 (10600 ns)
    TCS: TestCase_testVec4ShiftLeftVec, time elapsed: 175400 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftLeftVec (8700 ns)
    TCS: TestCase_testVec4ShiftRightVec, time elapsed: 182700 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftRightVec (10300 ns)
    TCS: TestCase_testVec4Increment, time elapsed: 209600 ns, RESULT:
    [ PASSED ] CASE: testVec4Increment (19100 ns)
    TCS: TestCase_testVec4Decrement, time elapsed: 193200 ns, RESULT:
    [ PASSED ] CASE: testVec4Decrement (12700 ns)
    TCS: TestCase_testVec4IndexOutOfBoundsAccess, time elapsed: 245500 ns, RESULT:
    [ PASSED ] CASE: testVec4IndexOutOfBoundsAccess (55700 ns)
    TCS: TestCase_testVec4NegativeIndexAccess, time elapsed: 227700 ns, RESULT:
    [ PASSED ] CASE: testVec4NegativeIndexAccess (24800 ns)
    TCS: TestCase_testFunctor1Vec1Identity, time elapsed: 463100 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec1Identity (19800 ns)
    TCS: TestCase_testFunctor1Vec1Transform, time elapsed: 298800 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec1Transform (20300 ns)
    TCS: TestCase_testFunctor1Vec2Transform, time elapsed: 231100 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec2Transform (16300 ns)
    TCS: TestCase_testFunctor2Vec1Add, time elapsed: 233200 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec1Add (10300 ns)
    TCS: TestCase_testFunctor2VecScaVec1Mul, time elapsed: 194400 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec1Mul (11700 ns)
    TCS: TestCase_testFunctor2VecIntVec1Shift, time elapsed: 174700 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec1Shift (9600 ns)
    TCS: TestCase_testFunctor1Vec3Transform, time elapsed: 169300 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec3Transform (7500 ns)
    TCS: TestCase_testFunctor1Vec4Transform, time elapsed: 169700 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec4Transform (10600 ns)
    TCS: TestCase_testFunctor2Vec2Add, time elapsed: 167900 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec2Add (7100 ns)
    TCS: TestCase_testFunctor2Vec3Add, time elapsed: 175300 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec3Add (7300 ns)
    TCS: TestCase_testFunctor2Vec4Add, time elapsed: 164000 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec4Add (6700 ns)
    TCS: TestCase_testFunctor2VecScaVec2Mul, time elapsed: 175900 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec2Mul (9200 ns)
    TCS: TestCase_testFunctor2VecScaVec3Mul, time elapsed: 170800 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec3Mul (6300 ns)
    TCS: TestCase_testFunctor2VecScaVec4Mul, time elapsed: 174900 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec4Mul (6700 ns)
    TCS: TestCase_testFunctor2VecIntVec2Shift, time elapsed: 179000 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec2Shift (9000 ns)
    TCS: TestCase_testFunctor2VecIntVec3Shift, time elapsed: 173300 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec3Shift (6400 ns)
    TCS: TestCase_testFunctor2VecIntVec4Shift, time elapsed: 194400 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec4Shift (6800 ns)
Summary: TOTAL: 429
    PASSED: 426, SKIPPED: 0, ERROR: 0
    FAILED: 3, listed below:
            TCS: TestCase_testS1QuatCastScalingWBranch, CASE: testS1QuatCastScalingWBranch
            TCS: TestCase_testS1QuatCastUnitRoundTrip, CASE: testS1QuatCastUnitRoundTrip
            TCS: TestCase_testS1QuatCastMat4Delegation, CASE: testS1QuatCastMat4Delegation
--------------------------------------------------------------------------------------------------
Project tests finished, time elapsed: 159466700 ns, RESULT:
TP: glm.*, time elapsed: 159402500 ns, RESULT:
    FAILED:
    TP: glm.detail, time elapsed: 143951700 ns, RESULT:
        TCS: TestCase_testComputeVecAdd1, time elapsed: 1848800 ns, RESULT:
        TCS: TestCase_testComputeVecSub2, time elapsed: 331300 ns, RESULT:
        TCS: TestCase_testComputeVecMul3, time elapsed: 341600 ns, RESULT:
        TCS: TestCase_testComputeVecMod1, time elapsed: 275600 ns, RESULT:
        TCS: TestCase_testComputeVecMod4, time elapsed: 257100 ns, RESULT:
        TCS: TestCase_testComputeVecAnd1, time elapsed: 333000 ns, RESULT:
        TCS: TestCase_testComputeVecAnd3, time elapsed: 258700 ns, RESULT:
        TCS: TestCase_testComputeVecOr1, time elapsed: 256800 ns, RESULT:
        TCS: TestCase_testComputeVecOr2, time elapsed: 257100 ns, RESULT:
        TCS: TestCase_testComputeVecXor1, time elapsed: 287300 ns, RESULT:
        TCS: TestCase_testComputeVecXor4, time elapsed: 267500 ns, RESULT:
        TCS: TestCase_testComputeVecShiftLeft1, time elapsed: 280100 ns, RESULT:
        TCS: TestCase_testComputeVecShiftLeft3, time elapsed: 314200 ns, RESULT:
        TCS: TestCase_testComputeVecShiftRight1, time elapsed: 244000 ns, RESULT:
        TCS: TestCase_testComputeVecShiftRight4, time elapsed: 243500 ns, RESULT:
        TCS: TestCase_testComputeVecEqual1, time elapsed: 263100 ns, RESULT:
        TCS: TestCase_testComputeVecNequal4, time elapsed: 246400 ns, RESULT:
        TCS: TestCase_testComputeVecBitwiseNot1, time elapsed: 294700 ns, RESULT:
        TCS: TestCase_testComputeVecBitwiseNot3, time elapsed: 285600 ns, RESULT:
        TCS: TestCase_testComputeVecAdd4, time elapsed: 241600 ns, RESULT:
        TCS: TestCase_testComputeVecSub1, time elapsed: 506600 ns, RESULT:
        TCS: TestCase_testComputeVecSub3, time elapsed: 230500 ns, RESULT:
        TCS: TestCase_testComputeVecMul1, time elapsed: 210300 ns, RESULT:
        TCS: TestCase_testComputeVecMul2, time elapsed: 230200 ns, RESULT:
        TCS: TestCase_testComputeVecDiv1, time elapsed: 263000 ns, RESULT:
        TCS: TestCase_testComputeVecDiv2, time elapsed: 214300 ns, RESULT:
        TCS: TestCase_testComputeVecDiv4, time elapsed: 211000 ns, RESULT:
        TCS: TestCase_testComputeVecEqual2, time elapsed: 223200 ns, RESULT:
        TCS: TestCase_testComputeVecEqual3, time elapsed: 231100 ns, RESULT:
        TCS: TestCase_testComputeVecEqual4, time elapsed: 198900 ns, RESULT:
        TCS: TestCase_testComputeVecNequal1, time elapsed: 226200 ns, RESULT:
        TCS: TestCase_testComputeVecNequal2, time elapsed: 193100 ns, RESULT:
        TCS: TestCase_testComputeVecBitwiseNot4, time elapsed: 216900 ns, RESULT:
        TCS: TestCase_testComputeVecAddFloat32, time elapsed: 250700 ns, RESULT:
        TCS: TestCase_testComputeVecAddFloat32Vec3, time elapsed: 234400 ns, RESULT:
        TCS: TestCase_testComputeVecSubFloat32, time elapsed: 528400 ns, RESULT:
        TCS: TestCase_testComputeVecSubFloat32Vec4, time elapsed: 336300 ns, RESULT:
        TCS: TestCase_testComputeEqualInt32Equal, time elapsed: 208300 ns, RESULT:
        TCS: TestCase_testComputeEqualInt32NotEqual, time elapsed: 206600 ns, RESULT:
        TCS: TestCase_testComputeEqualFloat32Equal, time elapsed: 221500 ns, RESULT:
        TCS: TestCase_testComputeEqualFloat32NotEqual, time elapsed: 254700 ns, RESULT:
        TCS: TestCase_testComputeEqualFloat64Equal, time elapsed: 226100 ns, RESULT:
        TCS: TestCase_testComputeEqualFloat64NotEqual, time elapsed: 201300 ns, RESULT:
        TCS: TestCase_testComputeEqualBoolEqual, time elapsed: 208500 ns, RESULT:
        TCS: TestCase_testComputeEqualBoolNotEqual, time elapsed: 220500 ns, RESULT:
        TCS: TestCase_testComputeEqualNumericInt32, time elapsed: 230800 ns, RESULT:
        TCS: TestCase_testComputeEqualNumericFloat32, time elapsed: 245700 ns, RESULT:
        TCS: TestCase_testComputeEqualNumericFloat32Epsilon, time elapsed: 210900 ns, RESULT:
        TCS: TestCase_testComputeEqualNumericFloat64, time elapsed: 205400 ns, RESULT:
        TCS: TestCase_testComputeEqualInt64Equal, time elapsed: 187900 ns, RESULT:
        TCS: TestCase_testComputeEqualInt64NotEqual, time elapsed: 193700 ns, RESULT:
        TCS: TestCase_testComputeEqualFloat32Nan, time elapsed: 190000 ns, RESULT:
        TCS: TestCase_testComputeEqualFloat64Nan, time elapsed: 226500 ns, RESULT:
        TCS: TestCase_testComputeEqualFloat32SignedZero, time elapsed: 193600 ns, RESULT:
        TCS: TestCase_testComputeEqualFloat64SignedZero, time elapsed: 191500 ns, RESULT:
        TCS: TestCase_testComputeEqualNumericFloat32NotEqual, time elapsed: 206000 ns, RESULT:
        TCS: TestCase_testComputeEqualNumericFloat32BeyondEpsilon, time elapsed: 203000 ns, RESULT:
        TCS: TestCase_testComputeEqualNumericFloat64NotEqual, time elapsed: 218100 ns, RESULT:
        TCS: TestCase_testComputeEqualNumericFloat64Epsilon, time elapsed: 207300 ns, RESULT:
        TCS: TestCase_testComputeEqualNumericFloat64BeyondEpsilon, time elapsed: 244100 ns, RESULT:
        TCS: TestCase_testComputeEqualNumericInt64, time elapsed: 222900 ns, RESULT:
        TCS: TestCase_testPackedHighpImplementsQualifier, time elapsed: 209200 ns, RESULT:
        TCS: TestCase_testPackedMediumpImplementsQualifier, time elapsed: 255500 ns, RESULT:
        TCS: TestCase_testPackedLowpImplementsQualifier, time elapsed: 210700 ns, RESULT:
        TCS: TestCase_testDefaultpIsPackedHighp, time elapsed: 462400 ns, RESULT:
        TCS: TestCase_testScalarAddVec1, time elapsed: 236000 ns, RESULT:
        TCS: TestCase_testScalarAddVec2, time elapsed: 216200 ns, RESULT:
        TCS: TestCase_testScalarAddVec3, time elapsed: 208200 ns, RESULT:
        TCS: TestCase_testScalarAddVec4, time elapsed: 210900 ns, RESULT:
        TCS: TestCase_testScalarSubVec1, time elapsed: 258800 ns, RESULT:
        TCS: TestCase_testScalarMulVec1, time elapsed: 203300 ns, RESULT:
        TCS: TestCase_testScalarDivVec1, time elapsed: 210100 ns, RESULT:
        TCS: TestCase_testScalarModVec1, time elapsed: 225900 ns, RESULT:
        TCS: TestCase_testScalarMulVec2, time elapsed: 199000 ns, RESULT:
        TCS: TestCase_testScalarSubVec2, time elapsed: 207600 ns, RESULT:
        TCS: TestCase_testScalarSubVec3, time elapsed: 337700 ns, RESULT:
        TCS: TestCase_testScalarSubVec4, time elapsed: 338700 ns, RESULT:
        TCS: TestCase_testScalarMulVec3, time elapsed: 243400 ns, RESULT:
        TCS: TestCase_testScalarMulVec4, time elapsed: 231500 ns, RESULT:
        TCS: TestCase_testScalarDivVec2, time elapsed: 213600 ns, RESULT:
        TCS: TestCase_testScalarDivVec3, time elapsed: 198200 ns, RESULT:
        TCS: TestCase_testScalarDivVec4, time elapsed: 240600 ns, RESULT:
        TCS: TestCase_testScalarModVec2, time elapsed: 287200 ns, RESULT:
        TCS: TestCase_testScalarModVec3, time elapsed: 216000 ns, RESULT:
        TCS: TestCase_testScalarModVec4, time elapsed: 201100 ns, RESULT:
        TCS: TestCase_testScalarModVec1Float32, time elapsed: 248900 ns, RESULT:
        TCS: TestCase_testScalarModVec2Float32, time elapsed: 205400 ns, RESULT:
        TCS: TestCase_testScalarModVec3Float32, time elapsed: 210500 ns, RESULT:
        TCS: TestCase_testScalarModVec4Float32, time elapsed: 273100 ns, RESULT:
        TCS: TestCase_testScalarModVec1Float64, time elapsed: 238200 ns, RESULT:
        TCS: TestCase_testScalarModVec2Float64, time elapsed: 212100 ns, RESULT:
        TCS: TestCase_testScalarModVec3Float64, time elapsed: 311000 ns, RESULT:
        TCS: TestCase_testScalarModVec4Float64, time elapsed: 287700 ns, RESULT:
        TCS: TestCase_testScalarModVec1Float16, time elapsed: 355300 ns, RESULT:
        TCS: TestCase_testScalarModVec2Float16, time elapsed: 288900 ns, RESULT:
        TCS: TestCase_testScalarModVec3Float16, time elapsed: 223900 ns, RESULT:
        TCS: TestCase_testScalarModVec4Float16, time elapsed: 249400 ns, RESULT:
        TCS: TestCase_testScalarSubVec2PackedMediump, time elapsed: 266500 ns, RESULT:
        TCS: TestCase_testScalarSubVec2PackedLowp, time elapsed: 216200 ns, RESULT:
        TCS: TestCase_testScalarMulVec2PackedMediump, time elapsed: 206700 ns, RESULT:
        TCS: TestCase_testScalarMulVec2PackedLowp, time elapsed: 231000 ns, RESULT:
        TCS: TestCase_testScalarDivVec2PackedMediump, time elapsed: 221300 ns, RESULT:
        TCS: TestCase_testScalarDivVec2PackedLowp, time elapsed: 207100 ns, RESULT:
        TCS: TestCase_testScalarModVec2PackedMediump, time elapsed: 214700 ns, RESULT:
        TCS: TestCase_testScalarModVec2PackedLowp, time elapsed: 205300 ns, RESULT:
        TCS: TestCase_testScalarModVec2Float32PackedMediump, time elapsed: 220500 ns, RESULT:
        TCS: TestCase_testScalarModVec2Float32PackedLowp, time elapsed: 219100 ns, RESULT:
        TCS: TestCase_testScalarModVec2Float32NegativeDividend, time elapsed: 229500 ns, RESULT:
        TCS: TestCase_testScalarModVec2Float32NegativeDivisor, time elapsed: 221600 ns, RESULT:
        TCS: TestCase_testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents, time elapsed: 403400 ns, RESULT:
        TCS: TestCase_testScalarAddVec1Float32, time elapsed: 197600 ns, RESULT:
        TCS: TestCase_testScalarAddVec2Float32, time elapsed: 209500 ns, RESULT:
        TCS: TestCase_testScalarAddVec3Float32, time elapsed: 202600 ns, RESULT:
        TCS: TestCase_testScalarAddVec4Float32, time elapsed: 204800 ns, RESULT:
        TCS: TestCase_testScalarSubVec1Float32, time elapsed: 193200 ns, RESULT:
        TCS: TestCase_testScalarSubVec2Float32, time elapsed: 202800 ns, RESULT:
        TCS: TestCase_testScalarSubVec3Float32, time elapsed: 199500 ns, RESULT:
        TCS: TestCase_testScalarSubVec4Float32, time elapsed: 191000 ns, RESULT:
        TCS: TestCase_testScalarMulVec1Float32, time elapsed: 192800 ns, RESULT:
        TCS: TestCase_testScalarMulVec2Float32, time elapsed: 187900 ns, RESULT:
        TCS: TestCase_testScalarMulVec3Float32, time elapsed: 196800 ns, RESULT:
        TCS: TestCase_testScalarMulVec4Float32, time elapsed: 201800 ns, RESULT:
        TCS: TestCase_testScalarDivVec1Float32, time elapsed: 185700 ns, RESULT:
        TCS: TestCase_testScalarDivVec2Float32, time elapsed: 180200 ns, RESULT:
        TCS: TestCase_testScalarDivVec3Float32, time elapsed: 198300 ns, RESULT:
        TCS: TestCase_testScalarDivVec4Float32, time elapsed: 182500 ns, RESULT:
        TCS: TestCase_testScalarAddVec1Int32, time elapsed: 186600 ns, RESULT:
        TCS: TestCase_testScalarAddVec2Int32, time elapsed: 215400 ns, RESULT:
        TCS: TestCase_testScalarAddVec3Int32, time elapsed: 184800 ns, RESULT:
        TCS: TestCase_testScalarAddVec4Int32, time elapsed: 186000 ns, RESULT:
        TCS: TestCase_testScalarSubVec1Int32, time elapsed: 194800 ns, RESULT:
        TCS: TestCase_testScalarSubVec2Int32, time elapsed: 181300 ns, RESULT:
        TCS: TestCase_testScalarSubVec3Int32, time elapsed: 457200 ns, RESULT:
        TCS: TestCase_testScalarSubVec4Int32, time elapsed: 365500 ns, RESULT:
        TCS: TestCase_testScalarMulVec1Int32, time elapsed: 440100 ns, RESULT:
        TCS: TestCase_testScalarMulVec2Int32, time elapsed: 377300 ns, RESULT:
        TCS: TestCase_testScalarMulVec3Int32, time elapsed: 320300 ns, RESULT:
        TCS: TestCase_testScalarMulVec4Int32, time elapsed: 308900 ns, RESULT:
        TCS: TestCase_testScalarDivVec1Int32, time elapsed: 283900 ns, RESULT:
        TCS: TestCase_testScalarDivVec2Int32, time elapsed: 457800 ns, RESULT:
        TCS: TestCase_testScalarDivVec3Int32, time elapsed: 341100 ns, RESULT:
        TCS: TestCase_testScalarDivVec4Int32, time elapsed: 283800 ns, RESULT:
        TCS: TestCase_testScalarModVec1Int32, time elapsed: 346100 ns, RESULT:
        TCS: TestCase_testScalarModVec2Int32, time elapsed: 215600 ns, RESULT:
        TCS: TestCase_testScalarModVec3Int32, time elapsed: 212800 ns, RESULT:
        TCS: TestCase_testScalarModVec4Int32, time elapsed: 207000 ns, RESULT:
        TCS: TestCase_testScalarSubVec1PackedMediump, time elapsed: 210200 ns, RESULT:
        TCS: TestCase_testScalarSubVec1PackedLowp, time elapsed: 252600 ns, RESULT:
        TCS: TestCase_testScalarSubVec3PackedMediump, time elapsed: 199300 ns, RESULT:
        TCS: TestCase_testScalarSubVec3PackedLowp, time elapsed: 219100 ns, RESULT:
        TCS: TestCase_testScalarSubVec4PackedMediump, time elapsed: 202900 ns, RESULT:
        TCS: TestCase_testScalarSubVec4PackedLowp, time elapsed: 284700 ns, RESULT:
        TCS: TestCase_testScalarMulVec1PackedMediump, time elapsed: 211600 ns, RESULT:
        TCS: TestCase_testScalarMulVec1PackedLowp, time elapsed: 207300 ns, RESULT:
        TCS: TestCase_testScalarMulVec3PackedMediump, time elapsed: 193900 ns, RESULT:
        TCS: TestCase_testScalarMulVec3PackedLowp, time elapsed: 218300 ns, RESULT:
        TCS: TestCase_testScalarMulVec4PackedMediump, time elapsed: 213700 ns, RESULT:
        TCS: TestCase_testScalarMulVec4PackedLowp, time elapsed: 200500 ns, RESULT:
        TCS: TestCase_testScalarDivVec1PackedMediump, time elapsed: 213600 ns, RESULT:
        TCS: TestCase_testScalarDivVec1PackedLowp, time elapsed: 226000 ns, RESULT:
        TCS: TestCase_testScalarDivVec3PackedMediump, time elapsed: 207400 ns, RESULT:
        TCS: TestCase_testScalarDivVec3PackedLowp, time elapsed: 196900 ns, RESULT:
        TCS: TestCase_testScalarDivVec4PackedMediump, time elapsed: 212000 ns, RESULT:
        TCS: TestCase_testScalarDivVec4PackedLowp, time elapsed: 196000 ns, RESULT:
        TCS: TestCase_testScalarModVec1PackedMediump, time elapsed: 215200 ns, RESULT:
        TCS: TestCase_testScalarModVec1PackedLowp, time elapsed: 223200 ns, RESULT:
        TCS: TestCase_testScalarModVec3PackedMediump, time elapsed: 218900 ns, RESULT:
        TCS: TestCase_testScalarModVec3PackedLowp, time elapsed: 206100 ns, RESULT:
        TCS: TestCase_testScalarModVec4PackedMediump, time elapsed: 210300 ns, RESULT:
        TCS: TestCase_testScalarModVec4PackedLowp, time elapsed: 210400 ns, RESULT:
        TCS: TestCase_testScalarDivZeroVec1, time elapsed: 216600 ns, RESULT:
        TCS: TestCase_testScalarAddNegVec1, time elapsed: 219000 ns, RESULT:
        TCS: TestCase_testScalarAddNegVec2, time elapsed: 195900 ns, RESULT:
        TCS: TestCase_testScalarMulOverflowVec1, time elapsed: 221800 ns, RESULT:
        TCS: TestCase_testScalarSubNegVec1, time elapsed: 498400 ns, RESULT:
        TCS: TestCase_testVersionMajor, time elapsed: 195300 ns, RESULT:
        TCS: TestCase_testVersionMinor, time elapsed: 193500 ns, RESULT:
        TCS: TestCase_testVersionPatch, time elapsed: 185000 ns, RESULT:
        TCS: TestCase_testVersionEncoded, time elapsed: 192200 ns, RESULT:
        TCS: TestCase_testConfigSimd, time elapsed: 198000 ns, RESULT:
        TCS: TestCase_testConfigAlignedGentypes, time elapsed: 194400 ns, RESULT:
        TCS: TestCase_testConfigClipControl, time elapsed: 190000 ns, RESULT:
        TCS: TestCase_testConstNegationSimd, time elapsed: 185600 ns, RESULT:
        TCS: TestCase_testConstNegationAligned, time elapsed: 178700 ns, RESULT:
        TCS: TestCase_testConstNegationClip, time elapsed: 182800 ns, RESULT:
        TCS: TestCase_testConstInt64Usage, time elapsed: 189500 ns, RESULT:
        TCS: TestCase_testConstBoolUsage, time elapsed: 216500 ns, RESULT:
        TCS: TestCase_testVersionEncodingConsistency, time elapsed: 184100 ns, RESULT:
        TCS: TestCase_testAssertPasses, time elapsed: 230700 ns, RESULT:
        TCS: TestCase_testAssertFails, time elapsed: 306700 ns, RESULT:
        TCS: TestCase_testAssertWithCustomMessage, time elapsed: 290600 ns, RESULT:
        TCS: TestCase_testNumericLimitsFloat32Epsilon, time elapsed: 301800 ns, RESULT:
        TCS: TestCase_testNumericLimitsFloat64Epsilon, time elapsed: 305000 ns, RESULT:
        TCS: TestCase_testIsIec559OfFloat32, time elapsed: 293200 ns, RESULT:
        TCS: TestCase_testIsIec559OfFloat64, time elapsed: 286200 ns, RESULT:
        TCS: TestCase_testIsIec559OfInt64, time elapsed: 235000 ns, RESULT:
        TCS: TestCase_testEpsilonOfFloat32, time elapsed: 234200 ns, RESULT:
        TCS: TestCase_testEpsilonOfFloat64, time elapsed: 224500 ns, RESULT:
        TCS: TestCase_testNumericLimitsInt64Epsilon, time elapsed: 223300 ns, RESULT:
        TCS: TestCase_testNumericLimitsInt32Epsilon, time elapsed: 210100 ns, RESULT:
        TCS: TestCase_testNumericLimitsInt16Epsilon, time elapsed: 214500 ns, RESULT:
        TCS: TestCase_testNumericLimitsInt8Epsilon, time elapsed: 204300 ns, RESULT:
        TCS: TestCase_testCastVec1ToVec1IntToFloat, time elapsed: 206000 ns, RESULT:
        TCS: TestCase_testCastVec2ToVec1TakesOnlyX, time elapsed: 292300 ns, RESULT:
        TCS: TestCase_testCastVec3ToVec1TakesOnlyX, time elapsed: 229600 ns, RESULT:
        TCS: TestCase_testCastVec4ToVec1TakesOnlyX, time elapsed: 196100 ns, RESULT:
        TCS: TestCase_testCastSameTypeIdentity, time elapsed: 214700 ns, RESULT:
        TCS: TestCase_testCastInt32ToInt64, time elapsed: 370000 ns, RESULT:
        TCS: TestCase_testCastFloatToIntTruncation, time elapsed: 314800 ns, RESULT:
        TCS: TestCase_testCastCrossQualifierPackedHighpToDefaultp, time elapsed: 311700 ns, RESULT:
        TCS: TestCase_testCastCrossQualifierDefaultpToPackedHighp, time elapsed: 340000 ns, RESULT:
        TCS: TestCase_testCastVec2CrossQualifierCrossType, time elapsed: 294100 ns, RESULT:
        TCS: TestCase_testCastVec3CrossQualifier, time elapsed: 297600 ns, RESULT:
        TCS: TestCase_testCastVec4CrossQualifier, time elapsed: 323600 ns, RESULT:
        TCS: TestCase_testCastVec1DoesNotModifySource, time elapsed: 234800 ns, RESULT:
        TCS: TestCase_testCastVec2Vec1ToVec2IntToFloat, time elapsed: 245200 ns, RESULT:
        TCS: TestCase_testCastVec2Vec2ToVec2Identity, time elapsed: 643500 ns, RESULT:
        TCS: TestCase_testCastVec2Vec3ToVec2TakesOnlyXY, time elapsed: 526500 ns, RESULT:
        TCS: TestCase_testCastVec2Vec4ToVec2TakesOnlyXY, time elapsed: 513600 ns, RESULT:
        TCS: TestCase_testCastVec2SameTypeIdentity, time elapsed: 492400 ns, RESULT:
        TCS: TestCase_testCastVec2Int32ToInt64, time elapsed: 491700 ns, RESULT:
        TCS: TestCase_testCastVec2FloatToIntTruncation, time elapsed: 334200 ns, RESULT:
        TCS: TestCase_testCastVec2CrossQualifierPackedHighpToDefaultp, time elapsed: 298100 ns, RESULT:
        TCS: TestCase_testCastVec2DoesNotModifySource, time elapsed: 193500 ns, RESULT:
        TCS: TestCase_testCastVec2Vec1ToVec2SameValueBothComponents, time elapsed: 424000 ns, RESULT:
        TCS: TestCase_testCastVec3Vec1ToVec3IntToFloat, time elapsed: 258300 ns, RESULT:
        TCS: TestCase_testCastVec3Vec2ToVec3ExtendY, time elapsed: 288800 ns, RESULT:
        TCS: TestCase_testCastVec3Vec3ToVec3Identity, time elapsed: 225500 ns, RESULT:
        TCS: TestCase_testCastVec3Vec4ToVec3TakesOnlyXYZ, time elapsed: 345300 ns, RESULT:
        TCS: TestCase_testCastVec3SameTypeIdentity, time elapsed: 306100 ns, RESULT:
        TCS: TestCase_testCastVec3Int32ToInt64, time elapsed: 224000 ns, RESULT:
        TCS: TestCase_testCastVec3FloatToIntTruncation, time elapsed: 382600 ns, RESULT:
        TCS: TestCase_testCastVec3CrossQualifierPackedHighpToDefaultp, time elapsed: 343600 ns, RESULT:
        TCS: TestCase_testCastVec3DoesNotModifySource, time elapsed: 228800 ns, RESULT:
        TCS: TestCase_testCastVec3Vec1ToVec3SameValueAllComponents, time elapsed: 195900 ns, RESULT:
        TCS: TestCase_testCastVec4Vec1ToVec4IntToFloat, time elapsed: 192400 ns, RESULT:
        TCS: TestCase_testCastVec4Vec2ToVec4ExtendY, time elapsed: 197100 ns, RESULT:
        TCS: TestCase_testCastVec4Vec3ToVec4ExtendZ, time elapsed: 183800 ns, RESULT:
        TCS: TestCase_testCastVec4Vec4ToVec4Identity, time elapsed: 183500 ns, RESULT:
        TCS: TestCase_testCastVec4SameTypeIdentity, time elapsed: 227600 ns, RESULT:
        TCS: TestCase_testCastVec4Int32ToInt64, time elapsed: 196000 ns, RESULT:
        TCS: TestCase_testCastVec4FloatToIntTruncation, time elapsed: 187600 ns, RESULT:
        TCS: TestCase_testCastVec4CrossQualifierPackedHighpToDefaultp, time elapsed: 213000 ns, RESULT:
        TCS: TestCase_testCastVec4DoesNotModifySource, time elapsed: 214900 ns, RESULT:
        TCS: TestCase_testCastVec4Vec1ToVec4SameValueAllComponents, time elapsed: 238800 ns, RESULT:
        TCS: TestCase_testFromBoolVec1, time elapsed: 217800 ns, RESULT:
        TCS: TestCase_testFromBoolVec1False, time elapsed: 275200 ns, RESULT:
        TCS: TestCase_testFromBoolVec2, time elapsed: 200300 ns, RESULT:
        TCS: TestCase_testFromBoolVec3, time elapsed: 232700 ns, RESULT:
        TCS: TestCase_testFromBoolVec4, time elapsed: 200900 ns, RESULT:
        TCS: TestCase_testFromBoolVecQ2Vec1, time elapsed: 196500 ns, RESULT:
        TCS: TestCase_testFromBoolVecQ2Vec2, time elapsed: 185900 ns, RESULT:
        TCS: TestCase_testFromBoolVecQ2Vec3, time elapsed: 187800 ns, RESULT:
        TCS: TestCase_testFromBoolVecQ2Vec4, time elapsed: 191400 ns, RESULT:
        TCS: TestCase_testFromBoolVec3AllFalse, time elapsed: 266000 ns, RESULT:
        TCS: TestCase_testFromBoolVec4AllFalse, time elapsed: 271300 ns, RESULT:
        TCS: TestCase_testFromBoolVecQ2Vec3AllFalse, time elapsed: 249600 ns, RESULT:
        TCS: TestCase_testFromBoolVecQ2Vec4AllFalse, time elapsed: 243700 ns, RESULT:
        TCS: TestCase_testFromBoolVecFloat32, time elapsed: 279400 ns, RESULT:
        TCS: TestCase_testFromBoolVecFloat64, time elapsed: 243000 ns, RESULT:
        TCS: TestCase_testFromBoolVecInt32, time elapsed: 240000 ns, RESULT:
        TCS: TestCase_testFromBoolVecQ2PackedMediump, time elapsed: 288000 ns, RESULT:
        TCS: TestCase_testFromBoolVecQ2PackedLowp, time elapsed: 254100 ns, RESULT:
        TCS: TestCase_testS1QuatCastScalingXBranch, time elapsed: 350200 ns, RESULT:
        TCS: TestCase_testS1QuatCastScalingYBranch, time elapsed: 222300 ns, RESULT:
        TCS: TestCase_testS1QuatCastScalingZBranch, time elapsed: 198200 ns, RESULT:
        TCS: TestCase_testS1QuatCastScalingWBranch, time elapsed: 352100 ns, RESULT:
        [ FAILED ] CASE: testS1QuatCastScalingWBranch (58000 ns)
        TCS: TestCase_testS1QuatCastUnitRoundTrip, time elapsed: 216100 ns, RESULT:
        [ FAILED ] CASE: testS1QuatCastUnitRoundTrip (15800 ns)
        TCS: TestCase_testS1QuatCastIdentityRoundTrip, time elapsed: 202400 ns, RESULT:
        TCS: TestCase_testS1QuatCastMat4Delegation, time elapsed: 245900 ns, RESULT:
        [ FAILED ] CASE: testS1QuatCastMat4Delegation (38300 ns)
        TCS: TestCase_testVec2ScalarInit, time elapsed: 224200 ns, RESULT:
        TCS: TestCase_testVec2ConstInit, time elapsed: 192600 ns, RESULT:
        TCS: TestCase_testVec2Length, time elapsed: 194500 ns, RESULT:
        TCS: TestCase_testVec2Add, time elapsed: 213400 ns, RESULT:
        TCS: TestCase_testVec2Sub, time elapsed: 193000 ns, RESULT:
        TCS: TestCase_testVec2Mul, time elapsed: 181400 ns, RESULT:
        TCS: TestCase_testVec2ScalarAdd, time elapsed: 192400 ns, RESULT:
        TCS: TestCase_testVec2Negate, time elapsed: 225100 ns, RESULT:
        TCS: TestCase_testVec2IndexAccess, time elapsed: 204900 ns, RESULT:
        TCS: TestCase_testVec2IndexMutate, time elapsed: 205600 ns, RESULT:
        TCS: TestCase_testVec2ComponentAt, time elapsed: 205600 ns, RESULT:
        TCS: TestCase_testVec2Equal, time elapsed: 206500 ns, RESULT:
        TCS: TestCase_testVec2NotEqual, time elapsed: 217100 ns, RESULT:
        TCS: TestCase_testVec2EqualExact, time elapsed: 207000 ns, RESULT:
        TCS: TestCase_testVec2BitwiseAnd, time elapsed: 194600 ns, RESULT:
        TCS: TestCase_testVec2BitwiseNot, time elapsed: 196400 ns, RESULT:
        TCS: TestCase_testVec2FromVec1, time elapsed: 200800 ns, RESULT:
        TCS: TestCase_testVec2ShiftLeft, time elapsed: 192400 ns, RESULT:
        TCS: TestCase_testVec2BoolLogicalAnd, time elapsed: 196300 ns, RESULT:
        TCS: TestCase_testVec2Vec1ArithBroadcast, time elapsed: 192600 ns, RESULT:
        TCS: TestCase_testVec2Vec1BitBroadcast, time elapsed: 179800 ns, RESULT:
        TCS: TestCase_testVec2ShiftLeftVec1, time elapsed: 201900 ns, RESULT:
        TCS: TestCase_testVec2Div, time elapsed: 202000 ns, RESULT:
        TCS: TestCase_testVec2Mod, time elapsed: 184700 ns, RESULT:
        TCS: TestCase_testVec2ScalarSub, time elapsed: 201100 ns, RESULT:
        TCS: TestCase_testVec2ScalarMul, time elapsed: 201000 ns, RESULT:
        TCS: TestCase_testVec2ScalarDiv, time elapsed: 185000 ns, RESULT:
        TCS: TestCase_testVec2ScalarMod, time elapsed: 187200 ns, RESULT:
        TCS: TestCase_testVec2BoolLogicalOr, time elapsed: 199000 ns, RESULT:
        TCS: TestCase_testVec2EqualEpsilon, time elapsed: 174900 ns, RESULT:
        TCS: TestCase_testVec2DivNamed, time elapsed: 189700 ns, RESULT:
        TCS: TestCase_testVec2ModNamed, time elapsed: 184100 ns, RESULT:
        TCS: TestCase_testVec2BitwiseOr, time elapsed: 208800 ns, RESULT:
        TCS: TestCase_testVec2BitwiseXor, time elapsed: 289500 ns, RESULT:
        TCS: TestCase_testVec2ScalarBitwiseAnd, time elapsed: 231700 ns, RESULT:
        TCS: TestCase_testVec2ShiftRight, time elapsed: 265500 ns, RESULT:
        TCS: TestCase_testVec2ShiftRightVec1, time elapsed: 198900 ns, RESULT:
        TCS: TestCase_testVec2AddNamed, time elapsed: 185700 ns, RESULT:
        TCS: TestCase_testVec2SubNamed, time elapsed: 186100 ns, RESULT:
        TCS: TestCase_testVec2MulNamed, time elapsed: 226500 ns, RESULT:
        TCS: TestCase_testVec2ShiftLeftVec, time elapsed: 188400 ns, RESULT:
        TCS: TestCase_testVec2ShiftRightVec, time elapsed: 166900 ns, RESULT:
        TCS: TestCase_testVec2ScalarBitwiseOr, time elapsed: 169700 ns, RESULT:
        TCS: TestCase_testVec2ScalarBitwiseXor, time elapsed: 174700 ns, RESULT:
        TCS: TestCase_testVec2Increment, time elapsed: 176100 ns, RESULT:
        TCS: TestCase_testVec2Decrement, time elapsed: 171100 ns, RESULT:
        TCS: TestCase_testVec2IndexOutOfBoundsAccess, time elapsed: 244400 ns, RESULT:
        TCS: TestCase_testVec2NegativeIndexAccess, time elapsed: 206100 ns, RESULT:
        TCS: TestCase_testVec3ScalarInit, time elapsed: 169400 ns, RESULT:
        TCS: TestCase_testVec3ConstInit, time elapsed: 174200 ns, RESULT:
        TCS: TestCase_testVec3Length, time elapsed: 160200 ns, RESULT:
        TCS: TestCase_testVec3Add, time elapsed: 175000 ns, RESULT:
        TCS: TestCase_testVec3ScalarMul, time elapsed: 216600 ns, RESULT:
        TCS: TestCase_testVec3Negate, time elapsed: 177100 ns, RESULT:
        TCS: TestCase_testVec3IndexAccess, time elapsed: 171000 ns, RESULT:
        TCS: TestCase_testVec3IndexMutate, time elapsed: 173000 ns, RESULT:
        TCS: TestCase_testVec3ComponentAt, time elapsed: 202400 ns, RESULT:
        TCS: TestCase_testVec3Equal, time elapsed: 305100 ns, RESULT:
        TCS: TestCase_testVec3NotEqual, time elapsed: 204700 ns, RESULT:
        TCS: TestCase_testVec3EqualExact, time elapsed: 202100 ns, RESULT:
        TCS: TestCase_testVec3BitwiseAnd, time elapsed: 211700 ns, RESULT:
        TCS: TestCase_testVec3BitwiseNot, time elapsed: 185900 ns, RESULT:
        TCS: TestCase_testVec3Vec1ArithBroadcast, time elapsed: 219900 ns, RESULT:
        TCS: TestCase_testVec3ShiftLeft, time elapsed: 231300 ns, RESULT:
        TCS: TestCase_testVec3BoolLogicalAnd, time elapsed: 202400 ns, RESULT:
        TCS: TestCase_testVec3Sub, time elapsed: 203500 ns, RESULT:
        TCS: TestCase_testVec3Div, time elapsed: 244300 ns, RESULT:
        TCS: TestCase_testVec3Mod, time elapsed: 244900 ns, RESULT:
        TCS: TestCase_testVec3ScalarSub, time elapsed: 236000 ns, RESULT:
        TCS: TestCase_testVec3ScalarDiv, time elapsed: 194000 ns, RESULT:
        TCS: TestCase_testVec3ScalarMod, time elapsed: 191700 ns, RESULT:
        TCS: TestCase_testVec3BoolLogicalOr, time elapsed: 200000 ns, RESULT:
        TCS: TestCase_testVec3EqualEpsilon, time elapsed: 200300 ns, RESULT:
        TCS: TestCase_testVec3AddNamed, time elapsed: 189200 ns, RESULT:
        TCS: TestCase_testVec3MulNamed, time elapsed: 196500 ns, RESULT:
        TCS: TestCase_testVec3DivNamed, time elapsed: 195100 ns, RESULT:
        TCS: TestCase_testVec3ModNamed, time elapsed: 166500 ns, RESULT:
        TCS: TestCase_testVec3BitwiseOr, time elapsed: 201800 ns, RESULT:
        TCS: TestCase_testVec3BitwiseXor, time elapsed: 186800 ns, RESULT:
        TCS: TestCase_testVec3ScalarBitwiseAnd, time elapsed: 231100 ns, RESULT:
        TCS: TestCase_testVec3ShiftRight, time elapsed: 192800 ns, RESULT:
        TCS: TestCase_testVec3Vec1BitBroadcast, time elapsed: 196700 ns, RESULT:
        TCS: TestCase_testVec3ShiftRightVec1, time elapsed: 181400 ns, RESULT:
        TCS: TestCase_testVec3FromVec1, time elapsed: 195400 ns, RESULT:
        TCS: TestCase_testVec3ScalarBitwiseOr, time elapsed: 218300 ns, RESULT:
        TCS: TestCase_testVec3ScalarBitwiseXor, time elapsed: 185500 ns, RESULT:
        TCS: TestCase_testVec3Vec1BitOrBroadcast, time elapsed: 207500 ns, RESULT:
        TCS: TestCase_testVec3Vec1BitXorBroadcast, time elapsed: 356500 ns, RESULT:
        TCS: TestCase_testVec3ShiftLeftVec1, time elapsed: 203900 ns, RESULT:
        TCS: TestCase_testVec3ShiftLeftVec, time elapsed: 192400 ns, RESULT:
        TCS: TestCase_testVec3ShiftRightVec, time elapsed: 170200 ns, RESULT:
        TCS: TestCase_testVec3Increment, time elapsed: 177100 ns, RESULT:
        TCS: TestCase_testVec3Decrement, time elapsed: 176400 ns, RESULT:
        TCS: TestCase_testVec3IndexOutOfBoundsAccess, time elapsed: 230200 ns, RESULT:
        TCS: TestCase_testVec3NegativeIndexAccess, time elapsed: 194100 ns, RESULT:
        TCS: TestCase_testVec4ScalarInit, time elapsed: 174800 ns, RESULT:
        TCS: TestCase_testVec4ConstInit, time elapsed: 165700 ns, RESULT:
        TCS: TestCase_testVec4Length, time elapsed: 172900 ns, RESULT:
        TCS: TestCase_testVec4Add, time elapsed: 191100 ns, RESULT:
        TCS: TestCase_testVec4ScalarMul, time elapsed: 179200 ns, RESULT:
        TCS: TestCase_testVec4Negate, time elapsed: 173900 ns, RESULT:
        TCS: TestCase_testVec4IndexAccess, time elapsed: 165700 ns, RESULT:
        TCS: TestCase_testVec4IndexMutate, time elapsed: 174900 ns, RESULT:
        TCS: TestCase_testVec4ComponentAt, time elapsed: 163800 ns, RESULT:
        TCS: TestCase_testVec4Equal, time elapsed: 170400 ns, RESULT:
        TCS: TestCase_testVec4NotEqual, time elapsed: 180900 ns, RESULT:
        TCS: TestCase_testVec4EqualExact, time elapsed: 195600 ns, RESULT:
        TCS: TestCase_testVec4BitwiseAnd, time elapsed: 210300 ns, RESULT:
        TCS: TestCase_testVec4BitwiseNot, time elapsed: 166800 ns, RESULT:
        TCS: TestCase_testVec4Vec1ArithBroadcast, time elapsed: 172300 ns, RESULT:
        TCS: TestCase_testVec4ShiftLeft, time elapsed: 170600 ns, RESULT:
        TCS: TestCase_testVec4BoolLogicalAnd, time elapsed: 177700 ns, RESULT:
        TCS: TestCase_testVec4Sub, time elapsed: 194200 ns, RESULT:
        TCS: TestCase_testVec4Div, time elapsed: 191000 ns, RESULT:
        TCS: TestCase_testVec4Mod, time elapsed: 197800 ns, RESULT:
        TCS: TestCase_testVec4ScalarSub, time elapsed: 189400 ns, RESULT:
        TCS: TestCase_testVec4ScalarDiv, time elapsed: 222600 ns, RESULT:
        TCS: TestCase_testVec4ScalarMod, time elapsed: 207700 ns, RESULT:
        TCS: TestCase_testVec4BoolLogicalOr, time elapsed: 204000 ns, RESULT:
        TCS: TestCase_testVec4EqualEpsilon, time elapsed: 214000 ns, RESULT:
        TCS: TestCase_testVec4AddNamed, time elapsed: 191100 ns, RESULT:
        TCS: TestCase_testVec4MulNamed, time elapsed: 203600 ns, RESULT:
        TCS: TestCase_testVec4DivNamed, time elapsed: 201800 ns, RESULT:
        TCS: TestCase_testVec4ModNamed, time elapsed: 195600 ns, RESULT:
        TCS: TestCase_testVec4BitwiseOr, time elapsed: 189800 ns, RESULT:
        TCS: TestCase_testVec4BitwiseXor, time elapsed: 282700 ns, RESULT:
        TCS: TestCase_testVec4ScalarBitwiseAnd, time elapsed: 300300 ns, RESULT:
        TCS: TestCase_testVec4ShiftRight, time elapsed: 279600 ns, RESULT:
        TCS: TestCase_testVec4Vec1BitBroadcast, time elapsed: 219700 ns, RESULT:
        TCS: TestCase_testVec4ShiftRightVec1, time elapsed: 209000 ns, RESULT:
        TCS: TestCase_testVec4FromVec1, time elapsed: 199900 ns, RESULT:
        TCS: TestCase_testVec4ScalarBitwiseOr, time elapsed: 183900 ns, RESULT:
        TCS: TestCase_testVec4ScalarBitwiseXor, time elapsed: 196200 ns, RESULT:
        TCS: TestCase_testVec4Vec1BitOrBroadcast, time elapsed: 202300 ns, RESULT:
        TCS: TestCase_testVec4Vec1BitXorBroadcast, time elapsed: 188100 ns, RESULT:
        TCS: TestCase_testVec4ShiftLeftVec1, time elapsed: 194700 ns, RESULT:
        TCS: TestCase_testVec4ShiftLeftVec, time elapsed: 175400 ns, RESULT:
        TCS: TestCase_testVec4ShiftRightVec, time elapsed: 182700 ns, RESULT:
        TCS: TestCase_testVec4Increment, time elapsed: 209600 ns, RESULT:
        TCS: TestCase_testVec4Decrement, time elapsed: 193200 ns, RESULT:
        TCS: TestCase_testVec4IndexOutOfBoundsAccess, time elapsed: 245500 ns, RESULT:
        TCS: TestCase_testVec4NegativeIndexAccess, time elapsed: 227700 ns, RESULT:
        TCS: TestCase_testFunctor1Vec1Identity, time elapsed: 463100 ns, RESULT:
        TCS: TestCase_testFunctor1Vec1Transform, time elapsed: 298800 ns, RESULT:
        TCS: TestCase_testFunctor1Vec2Transform, time elapsed: 231100 ns, RESULT:
        TCS: TestCase_testFunctor2Vec1Add, time elapsed: 233200 ns, RESULT:
        TCS: TestCase_testFunctor2VecScaVec1Mul, time elapsed: 194400 ns, RESULT:
        TCS: TestCase_testFunctor2VecIntVec1Shift, time elapsed: 174700 ns, RESULT:
        TCS: TestCase_testFunctor1Vec3Transform, time elapsed: 169300 ns, RESULT:
        TCS: TestCase_testFunctor1Vec4Transform, time elapsed: 169700 ns, RESULT:
        TCS: TestCase_testFunctor2Vec2Add, time elapsed: 167900 ns, RESULT:
        TCS: TestCase_testFunctor2Vec3Add, time elapsed: 175300 ns, RESULT:
        TCS: TestCase_testFunctor2Vec4Add, time elapsed: 164000 ns, RESULT:
        TCS: TestCase_testFunctor2VecScaVec2Mul, time elapsed: 175900 ns, RESULT:
        TCS: TestCase_testFunctor2VecScaVec3Mul, time elapsed: 170800 ns, RESULT:
        TCS: TestCase_testFunctor2VecScaVec4Mul, time elapsed: 174900 ns, RESULT:
        TCS: TestCase_testFunctor2VecIntVec2Shift, time elapsed: 179000 ns, RESULT:
        TCS: TestCase_testFunctor2VecIntVec3Shift, time elapsed: 173300 ns, RESULT:
        TCS: TestCase_testFunctor2VecIntVec4Shift, time elapsed: 194400 ns, RESULT:
Summary: TOTAL: 429
    PASSED: 426, SKIPPED: 0, ERROR: 0
    FAILED: 3
--------------------------------------------------------------------------------------------------
[0J7[;r8[?25hError: cjpm test failed
