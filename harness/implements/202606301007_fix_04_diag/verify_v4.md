# 验证报告（v4）

## 结果
PASSED

## 统计
- 通过：435
- 失败：0

## 测试执行日志
warning[0m: possibly confusing line terminator
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\matrix.cj:173:51:
    | 
173 |       - m.c1.x * (m.c0.y * m.c2.z - m.c2.y * m.c0.z)
    |                                                    ~^ 
    |  __________________________________________________|
174 | |     + m.c2.x * (m.c0.y * m.c1.z - m.c1.y * m.c0.z)
    | |_____~ possibly confusing line terminator between ')' and '+'
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff parser`

warning[0m: possibly confusing line terminator
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\matrix.cj:185:84:
    | 
185 |       - m.c0.y * (m.c1.x * SubFactor00 - m.c1.z * SubFactor03 + m.c1.w * SubFactor04)
    |                                                                                     ~^ 
    |  ___________________________________________________________________________________|
186 | |     + m.c0.z * (m.c1.x * SubFactor01 - m.c1.y * SubFactor03 + m.c1.w * SubFactor05)
    | |_____~ possibly confusing line terminator between ')' and '+'
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff parser`

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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_quat.cj:120:28:
    | 
120 |     public operator func *(rhs: Vec3<T, Q>): Vec3<T, Q> {
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

warning[0m: unused variable:'rhs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_quat.cj:125:28:
    | 
125 |     public operator func *(rhs: Vec4<T, Q>): Vec4<T, Q> {
    |                            ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'rhs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_quat.cj:142:28:
    | 
142 |     public operator func *(rhs: Quat<T, Q>): Vec3<T, Q> {
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

warning[0m: unused variable:'rhs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_quat.cj:149:28:
    | 
149 |     public operator func *(rhs: Quat<T, Q>): Vec4<T, Q> {
    |                            ^^^ unused variable
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

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:167:58:
    | 
167 |     public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat2x4<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:167:58:
    | 
167 |     public static func fromMat<SrcQ>(m: Mat3x3<T, SrcQ>, one: T): Mat3x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:168:58:
    | 
168 |     public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat2x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:170:58:
    | 
170 |     public static func fromMat<SrcQ>(m: Mat4x2<T, SrcQ>, one: T): Mat2x3<T, Q>
    |                                                          ^^^ unused variable
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

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:173:58:
    | 
173 |     public static func fromMat<SrcQ>(m: Mat3x2<T, SrcQ>, one: T): Mat4x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:173:58:
    | 
173 |     public static func fromMat<SrcQ>(m: Mat4x2<T, SrcQ>, one: T): Mat2x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:176:58:
    | 
176 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat2x3<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:179:58:
    | 
179 |     public static func fromMat<SrcQ>(m: Mat3x3<T, SrcQ>, one: T): Mat4x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x4.cj:185:58:
    | 
185 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat3x4<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:187:58:
    | 
187 |     public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat3x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:212:71:
    | 
212 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat3x4<U, P>, one: T): Mat2x3<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:214:71:
    | 
214 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat3x3<U, P>, one: T): Mat3x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:217:71:
    | 
217 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x2<U, P>, one: T): Mat2x2<T, Q>
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

94 warnings generated, 94 warnings printed.
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

warning[0m: unused import 'glm.detail.cosT'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_clip_space.cj:2:46:
  | 
2 | import glm.detail.{ Mat4x4, Vec4, Qualifier, cosT, sinT, tanT, epsilon }
  |                                              ^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'glm.detail.sinT'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_clip_space.cj:2:52:
  | 
2 | import glm.detail.{ Mat4x4, Vec4, Qualifier, cosT, sinT, tanT, epsilon }
  |                                                    ^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'glm.detail.cosT'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_common.cj:2:80:
  | 
2 | import glm.detail.{ Quat, Vec4, Qualifier, assert, clamp, acos, epsilon, sinT, cosT, dot, pi }
  |                                                                                ^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'q'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_exponential.cj:4:23:
  | 
4 | public func exp<T, Q>(q: Quat<T, Q>): Quat<T, Q>
  |                       ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'q'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_exponential.cj:6:23:
  | 
6 | public func log<T, Q>(q: Quat<T, Q>): Quat<T, Q>
  |                       ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_exponential.cj:8:23:
  | 
8 | public func pow<T, Q>(x: Quat<T, Q>, y: T): Quat<T, Q>
  |                       ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_exponential.cj:8:38:
  | 
8 | public func pow<T, Q>(x: Quat<T, Q>, y: T): Quat<T, Q>
  |                                      ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_exponential.cj:10:24:
   | 
10 | public func sqrt<T, Q>(x: Quat<T, Q>): Quat<T, Q>
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_transform.cj:44:9:
   | 
44 |     let zero = (Float64(0) as T).getOrThrow()
   |         ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:199:25:
    | 
199 | public func equal<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Int64): Vec1<Bool, Q>
    |                         ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:199:40:
    | 
199 | public func equal<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Int64): Vec1<Bool, Q>
    |                                        ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:199:55:
    | 
199 | public func equal<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Int64): Vec1<Bool, Q>
    |                                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:202:25:
    | 
202 | public func equal<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Vec1<Int64, Q>): Vec1<Bool, Q>
    |                         ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:202:40:
    | 
202 | public func equal<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Vec1<Int64, Q>): Vec1<Bool, Q>
    |                                        ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:202:55:
    | 
202 | public func equal<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Vec1<Int64, Q>): Vec1<Bool, Q>
    |                                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:205:28:
    | 
205 | public func notEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Int64): Vec1<Bool, Q>
    |                            ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:205:43:
    | 
205 | public func notEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Int64): Vec1<Bool, Q>
    |                                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:205:58:
    | 
205 | public func notEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Int64): Vec1<Bool, Q>
    |                                                          ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:208:28:
    | 
208 | public func notEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Vec1<Int64, Q>): Vec1<Bool, Q>
    |                            ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:208:43:
    | 
208 | public func notEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Vec1<Int64, Q>): Vec1<Bool, Q>
    |                                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:208:58:
    | 
208 | public func notEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Vec1<Int64, Q>): Vec1<Bool, Q>
    |                                                          ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:213:25:
    | 
213 | public func equal<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Int64): Vec2<Bool, Q>
    |                         ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:213:40:
    | 
213 | public func equal<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Int64): Vec2<Bool, Q>
    |                                        ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:213:55:
    | 
213 | public func equal<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Int64): Vec2<Bool, Q>
    |                                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:216:25:
    | 
216 | public func equal<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Vec2<Int64, Q>): Vec2<Bool, Q>
    |                         ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:216:40:
    | 
216 | public func equal<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Vec2<Int64, Q>): Vec2<Bool, Q>
    |                                        ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:216:55:
    | 
216 | public func equal<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Vec2<Int64, Q>): Vec2<Bool, Q>
    |                                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:219:28:
    | 
219 | public func notEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Int64): Vec2<Bool, Q>
    |                            ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:219:43:
    | 
219 | public func notEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Int64): Vec2<Bool, Q>
    |                                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:219:58:
    | 
219 | public func notEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Int64): Vec2<Bool, Q>
    |                                                          ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:222:28:
    | 
222 | public func notEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Vec2<Int64, Q>): Vec2<Bool, Q>
    |                            ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:222:43:
    | 
222 | public func notEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Vec2<Int64, Q>): Vec2<Bool, Q>
    |                                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:222:58:
    | 
222 | public func notEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Vec2<Int64, Q>): Vec2<Bool, Q>
    |                                                          ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:227:25:
    | 
227 | public func equal<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Int64): Vec3<Bool, Q>
    |                         ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:227:40:
    | 
227 | public func equal<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Int64): Vec3<Bool, Q>
    |                                        ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:227:55:
    | 
227 | public func equal<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Int64): Vec3<Bool, Q>
    |                                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:230:25:
    | 
230 | public func equal<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Vec3<Int64, Q>): Vec3<Bool, Q>
    |                         ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:230:40:
    | 
230 | public func equal<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Vec3<Int64, Q>): Vec3<Bool, Q>
    |                                        ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:230:55:
    | 
230 | public func equal<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Vec3<Int64, Q>): Vec3<Bool, Q>
    |                                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:233:28:
    | 
233 | public func notEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Int64): Vec3<Bool, Q>
    |                            ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:233:43:
    | 
233 | public func notEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Int64): Vec3<Bool, Q>
    |                                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:233:58:
    | 
233 | public func notEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Int64): Vec3<Bool, Q>
    |                                                          ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:236:28:
    | 
236 | public func notEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Vec3<Int64, Q>): Vec3<Bool, Q>
    |                            ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:236:43:
    | 
236 | public func notEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Vec3<Int64, Q>): Vec3<Bool, Q>
    |                                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:236:58:
    | 
236 | public func notEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Vec3<Int64, Q>): Vec3<Bool, Q>
    |                                                          ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:241:25:
    | 
241 | public func equal<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Int64): Vec4<Bool, Q>
    |                         ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:241:40:
    | 
241 | public func equal<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Int64): Vec4<Bool, Q>
    |                                        ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:241:55:
    | 
241 | public func equal<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Int64): Vec4<Bool, Q>
    |                                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:244:25:
    | 
244 | public func equal<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Vec4<Int64, Q>): Vec4<Bool, Q>
    |                         ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:244:40:
    | 
244 | public func equal<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Vec4<Int64, Q>): Vec4<Bool, Q>
    |                                        ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:244:55:
    | 
244 | public func equal<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Vec4<Int64, Q>): Vec4<Bool, Q>
    |                                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:247:28:
    | 
247 | public func notEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Int64): Vec4<Bool, Q>
    |                            ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:247:43:
    | 
247 | public func notEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Int64): Vec4<Bool, Q>
    |                                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:247:58:
    | 
247 | public func notEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Int64): Vec4<Bool, Q>
    |                                                          ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:250:28:
    | 
250 | public func notEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Vec4<Int64, Q>): Vec4<Bool, Q>
    |                            ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:250:43:
    | 
250 | public func notEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Vec4<Int64, Q>): Vec4<Bool, Q>
    |                                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:250:58:
    | 
250 | public func notEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Vec4<Int64, Q>): Vec4<Bool, Q>
    |                                                          ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_clip_space.cj:277:61:
    | 
277 | func perspectiveFovImpl<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T, depthScale: T, depthOffset: T): Mat4x4<T, Q>
    |                                                             ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_clip_space.cj:277:71:
    | 
277 | func perspectiveFovImpl<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T, depthScale: T, depthOffset: T): Mat4x4<T, Q>
    |                                                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

72 warnings generated, 72 warnings printed.
warning[0m: possibly confusing line terminator
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\matrix.cj:173:51:
    | 
173 |       - m.c1.x * (m.c0.y * m.c2.z - m.c2.y * m.c0.z)
    |                                                    ~^ 
    |  __________________________________________________|
174 | |     + m.c2.x * (m.c0.y * m.c1.z - m.c1.y * m.c0.z)
    | |_____~ possibly confusing line terminator between ')' and '+'
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff parser`

warning[0m: possibly confusing line terminator
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\matrix.cj:185:84:
    | 
185 |       - m.c0.y * (m.c1.x * SubFactor00 - m.c1.z * SubFactor03 + m.c1.w * SubFactor04)
    |                                                                                     ~^ 
    |  ___________________________________________________________________________________|
186 | |     + m.c0.z * (m.c1.x * SubFactor01 - m.c1.y * SubFactor03 + m.c1.w * SubFactor05)
    | |_____~ possibly confusing line terminator between ')' and '+'
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff parser`

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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_quat.cj:120:28:
    | 
120 |     public operator func *(rhs: Vec3<T, Q>): Vec3<T, Q> {
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

warning[0m: unused variable:'rhs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_quat.cj:125:28:
    | 
125 |     public operator func *(rhs: Vec4<T, Q>): Vec4<T, Q> {
    |                            ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'rhs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_quat.cj:142:28:
    | 
142 |     public operator func *(rhs: Quat<T, Q>): Vec3<T, Q> {
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

warning[0m: unused variable:'rhs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_quat.cj:149:28:
    | 
149 |     public operator func *(rhs: Quat<T, Q>): Vec4<T, Q> {
    |                            ^^^ unused variable
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

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:167:58:
    | 
167 |     public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat2x4<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:167:58:
    | 
167 |     public static func fromMat<SrcQ>(m: Mat3x3<T, SrcQ>, one: T): Mat3x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:168:58:
    | 
168 |     public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat2x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:170:58:
    | 
170 |     public static func fromMat<SrcQ>(m: Mat4x2<T, SrcQ>, one: T): Mat2x3<T, Q>
    |                                                          ^^^ unused variable
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

warning[0m: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:173:58:
    | 
173 |     public static func fromMat<SrcQ>(m: Mat3x2<T, SrcQ>, one: T): Mat4x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:173:58:
    | 
173 |     public static func fromMat<SrcQ>(m: Mat4x2<T, SrcQ>, one: T): Mat2x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:176:58:
    | 
176 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat2x3<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat4x2.cj:179:58:
    | 
179 |     public static func fromMat<SrcQ>(m: Mat3x3<T, SrcQ>, one: T): Mat4x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x4.cj:185:58:
    | 
185 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat3x4<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:187:58:
    | 
187 |     public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat3x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:212:71:
    | 
212 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat3x4<U, P>, one: T): Mat2x3<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x2.cj:214:71:
    | 
214 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat3x3<U, P>, one: T): Mat3x2<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:217:71:
    | 
217 |     public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x2<U, P>, one: T): Mat2x2<T, Q>
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

94 warnings generated, 94 warnings printed.
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

warning[0m: unused import 'glm.detail.cosT'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_clip_space.cj:2:46:
  | 
2 | import glm.detail.{ Mat4x4, Vec4, Qualifier, cosT, sinT, tanT, epsilon }
  |                                              ^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'glm.detail.sinT'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_clip_space.cj:2:52:
  | 
2 | import glm.detail.{ Mat4x4, Vec4, Qualifier, cosT, sinT, tanT, epsilon }
  |                                                    ^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'glm.detail.cosT'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_common.cj:2:80:
  | 
2 | import glm.detail.{ Quat, Vec4, Qualifier, assert, clamp, acos, epsilon, sinT, cosT, dot, pi }
  |                                                                                ^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'q'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_exponential.cj:4:23:
  | 
4 | public func exp<T, Q>(q: Quat<T, Q>): Quat<T, Q>
  |                       ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'q'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_exponential.cj:6:23:
  | 
6 | public func log<T, Q>(q: Quat<T, Q>): Quat<T, Q>
  |                       ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_exponential.cj:8:23:
  | 
8 | public func pow<T, Q>(x: Quat<T, Q>, y: T): Quat<T, Q>
  |                       ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_exponential.cj:8:38:
  | 
8 | public func pow<T, Q>(x: Quat<T, Q>, y: T): Quat<T, Q>
  |                                      ^ unused variable
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_exponential.cj:10:24:
   | 
10 | public func sqrt<T, Q>(x: Quat<T, Q>): Quat<T, Q>
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zero'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_transform.cj:44:9:
   | 
44 |     let zero = (Float64(0) as T).getOrThrow()
   |         ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:199:25:
    | 
199 | public func equal<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Int64): Vec1<Bool, Q>
    |                         ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:199:40:
    | 
199 | public func equal<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Int64): Vec1<Bool, Q>
    |                                        ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:199:55:
    | 
199 | public func equal<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Int64): Vec1<Bool, Q>
    |                                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:202:25:
    | 
202 | public func equal<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Vec1<Int64, Q>): Vec1<Bool, Q>
    |                         ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:202:40:
    | 
202 | public func equal<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Vec1<Int64, Q>): Vec1<Bool, Q>
    |                                        ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:202:55:
    | 
202 | public func equal<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Vec1<Int64, Q>): Vec1<Bool, Q>
    |                                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:205:28:
    | 
205 | public func notEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Int64): Vec1<Bool, Q>
    |                            ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:205:43:
    | 
205 | public func notEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Int64): Vec1<Bool, Q>
    |                                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:205:58:
    | 
205 | public func notEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Int64): Vec1<Bool, Q>
    |                                                          ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:208:28:
    | 
208 | public func notEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Vec1<Int64, Q>): Vec1<Bool, Q>
    |                            ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:208:43:
    | 
208 | public func notEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Vec1<Int64, Q>): Vec1<Bool, Q>
    |                                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:208:58:
    | 
208 | public func notEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>, ULPs: Vec1<Int64, Q>): Vec1<Bool, Q>
    |                                                          ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:213:25:
    | 
213 | public func equal<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Int64): Vec2<Bool, Q>
    |                         ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:213:40:
    | 
213 | public func equal<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Int64): Vec2<Bool, Q>
    |                                        ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:213:55:
    | 
213 | public func equal<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Int64): Vec2<Bool, Q>
    |                                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:216:25:
    | 
216 | public func equal<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Vec2<Int64, Q>): Vec2<Bool, Q>
    |                         ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:216:40:
    | 
216 | public func equal<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Vec2<Int64, Q>): Vec2<Bool, Q>
    |                                        ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:216:55:
    | 
216 | public func equal<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Vec2<Int64, Q>): Vec2<Bool, Q>
    |                                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:219:28:
    | 
219 | public func notEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Int64): Vec2<Bool, Q>
    |                            ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:219:43:
    | 
219 | public func notEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Int64): Vec2<Bool, Q>
    |                                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:219:58:
    | 
219 | public func notEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Int64): Vec2<Bool, Q>
    |                                                          ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:222:28:
    | 
222 | public func notEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Vec2<Int64, Q>): Vec2<Bool, Q>
    |                            ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:222:43:
    | 
222 | public func notEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Vec2<Int64, Q>): Vec2<Bool, Q>
    |                                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:222:58:
    | 
222 | public func notEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>, ULPs: Vec2<Int64, Q>): Vec2<Bool, Q>
    |                                                          ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:227:25:
    | 
227 | public func equal<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Int64): Vec3<Bool, Q>
    |                         ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:227:40:
    | 
227 | public func equal<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Int64): Vec3<Bool, Q>
    |                                        ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:227:55:
    | 
227 | public func equal<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Int64): Vec3<Bool, Q>
    |                                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:230:25:
    | 
230 | public func equal<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Vec3<Int64, Q>): Vec3<Bool, Q>
    |                         ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:230:40:
    | 
230 | public func equal<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Vec3<Int64, Q>): Vec3<Bool, Q>
    |                                        ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:230:55:
    | 
230 | public func equal<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Vec3<Int64, Q>): Vec3<Bool, Q>
    |                                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:233:28:
    | 
233 | public func notEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Int64): Vec3<Bool, Q>
    |                            ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:233:43:
    | 
233 | public func notEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Int64): Vec3<Bool, Q>
    |                                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:233:58:
    | 
233 | public func notEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Int64): Vec3<Bool, Q>
    |                                                          ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:236:28:
    | 
236 | public func notEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Vec3<Int64, Q>): Vec3<Bool, Q>
    |                            ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:236:43:
    | 
236 | public func notEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Vec3<Int64, Q>): Vec3<Bool, Q>
    |                                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:236:58:
    | 
236 | public func notEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>, ULPs: Vec3<Int64, Q>): Vec3<Bool, Q>
    |                                                          ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:241:25:
    | 
241 | public func equal<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Int64): Vec4<Bool, Q>
    |                         ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:241:40:
    | 
241 | public func equal<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Int64): Vec4<Bool, Q>
    |                                        ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:241:55:
    | 
241 | public func equal<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Int64): Vec4<Bool, Q>
    |                                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:244:25:
    | 
244 | public func equal<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Vec4<Int64, Q>): Vec4<Bool, Q>
    |                         ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:244:40:
    | 
244 | public func equal<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Vec4<Int64, Q>): Vec4<Bool, Q>
    |                                        ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:244:55:
    | 
244 | public func equal<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Vec4<Int64, Q>): Vec4<Bool, Q>
    |                                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:247:28:
    | 
247 | public func notEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Int64): Vec4<Bool, Q>
    |                            ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:247:43:
    | 
247 | public func notEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Int64): Vec4<Bool, Q>
    |                                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:247:58:
    | 
247 | public func notEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Int64): Vec4<Bool, Q>
    |                                                          ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:250:28:
    | 
250 | public func notEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Vec4<Int64, Q>): Vec4<Bool, Q>
    |                            ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'y'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:250:43:
    | 
250 | public func notEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Vec4<Int64, Q>): Vec4<Bool, Q>
    |                                           ^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'ULPs'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\vector_relational.cj:250:58:
    | 
250 | public func notEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>, ULPs: Vec4<Int64, Q>): Vec4<Bool, Q>
    |                                                          ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_clip_space.cj:277:61:
    | 
277 | func perspectiveFovImpl<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T, depthScale: T, depthOffset: T): Mat4x4<T, Q>
    |                                                             ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_clip_space.cj:277:71:
    | 
277 | func perspectiveFovImpl<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T, depthScale: T, depthOffset: T): Mat4x4<T, Q>
    |                                                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

72 warnings generated, 72 warnings printed.
[?25l[0J7[;r8
[1F7[9999E8[0J7[;r8[?25h--------------------------------------------------------------------------------------------------
TP: [33mglm.detail[0m, time elapsed: 24887600 ns, RESULT:
    TCS: [33mTestCase_testComputeVecAdd1[0m, time elapsed: 791900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAdd1 (517800 ns)
    TCS: [33mTestCase_testComputeVecSub2[0m, time elapsed: 43800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub2 (19500 ns)
    TCS: [33mTestCase_testComputeVecMul3[0m, time elapsed: 74600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul3 (16300 ns)
    TCS: [33mTestCase_testComputeVecMod1[0m, time elapsed: 29600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMod1 (15500 ns)
    TCS: [33mTestCase_testComputeVecMod4[0m, time elapsed: 59800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMod4 (16200 ns)
    TCS: [33mTestCase_testComputeVecAnd1[0m, time elapsed: 62500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAnd1 (22900 ns)
    TCS: [33mTestCase_testComputeVecAnd3[0m, time elapsed: 84800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAnd3 (14700 ns)
    TCS: [33mTestCase_testComputeVecOr1[0m, time elapsed: 29200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecOr1 (14400 ns)
    TCS: [33mTestCase_testComputeVecOr2[0m, time elapsed: 69400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecOr2 (26000 ns)
    TCS: [33mTestCase_testComputeVecXor1[0m, time elapsed: 35800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecXor1 (17800 ns)
    TCS: [33mTestCase_testComputeVecXor4[0m, time elapsed: 60100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecXor4 (14200 ns)
    TCS: [33mTestCase_testComputeVecShiftLeft1[0m, time elapsed: 36500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftLeft1 (14200 ns)
    TCS: [33mTestCase_testComputeVecShiftLeft3[0m, time elapsed: 83700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftLeft3 (57600 ns)
    TCS: [33mTestCase_testComputeVecShiftRight1[0m, time elapsed: 30100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftRight1 (9800 ns)
    TCS: [33mTestCase_testComputeVecShiftRight4[0m, time elapsed: 139900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftRight4 (76300 ns)
    TCS: [33mTestCase_testComputeVecEqual1[0m, time elapsed: 28800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual1 (12000 ns)
    TCS: [33mTestCase_testComputeVecNequal4[0m, time elapsed: 41700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal4 (23800 ns)
    TCS: [33mTestCase_testComputeVecBitwiseNot1[0m, time elapsed: 50200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecBitwiseNot1 (28100 ns)
    TCS: [33mTestCase_testComputeVecBitwiseNot3[0m, time elapsed: 68200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecBitwiseNot3 (16100 ns)
    TCS: [33mTestCase_testComputeVecAdd4[0m, time elapsed: 26500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAdd4 (12000 ns)
    TCS: [33mTestCase_testComputeVecSub1[0m, time elapsed: 22900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub1 (9400 ns)
    TCS: [33mTestCase_testComputeVecSub3[0m, time elapsed: 25900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub3 (9900 ns)
    TCS: [33mTestCase_testComputeVecMul1[0m, time elapsed: 23100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul1 (9300 ns)
    TCS: [33mTestCase_testComputeVecMul2[0m, time elapsed: 51900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul2 (9100 ns)
    TCS: [33mTestCase_testComputeVecDiv1[0m, time elapsed: 61200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecDiv1 (14900 ns)
    TCS: [33mTestCase_testComputeVecDiv2[0m, time elapsed: 66700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecDiv2 (15800 ns)
    TCS: [33mTestCase_testComputeVecDiv4[0m, time elapsed: 25400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecDiv4 (10600 ns)
    TCS: [33mTestCase_testComputeVecEqual2[0m, time elapsed: 84900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual2 (10300 ns)
    TCS: [33mTestCase_testComputeVecEqual3[0m, time elapsed: 20300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual3 (6400 ns)
    TCS: [33mTestCase_testComputeVecEqual4[0m, time elapsed: 190000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual4 (22700 ns)
    TCS: [33mTestCase_testComputeVecNequal1[0m, time elapsed: 70400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal1 (13900 ns)
    TCS: [33mTestCase_testComputeVecNequal2[0m, time elapsed: 102700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal2 (13400 ns)
    TCS: [33mTestCase_testComputeVecBitwiseNot4[0m, time elapsed: 59700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecBitwiseNot4 (30500 ns)
    TCS: [33mTestCase_testComputeVecAddFloat32[0m, time elapsed: 117700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAddFloat32 (83100 ns)
    TCS: [33mTestCase_testComputeVecAddFloat32Vec3[0m, time elapsed: 65500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAddFloat32Vec3 (33500 ns)
    TCS: [33mTestCase_testComputeVecSubFloat32[0m, time elapsed: 103500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSubFloat32 (71000 ns)
    TCS: [33mTestCase_testComputeVecSubFloat32Vec4[0m, time elapsed: 221700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSubFloat32Vec4 (186800 ns)
    TCS: [33mTestCase_testComputeEqualInt32Equal[0m, time elapsed: 66000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt32Equal (39400 ns)
    TCS: [33mTestCase_testComputeEqualInt32NotEqual[0m, time elapsed: 25200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt32NotEqual (7400 ns)
    TCS: [33mTestCase_testComputeEqualFloat32Equal[0m, time elapsed: 41500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32Equal (8200 ns)
    TCS: [33mTestCase_testComputeEqualFloat32NotEqual[0m, time elapsed: 35100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32NotEqual (9700 ns)
    TCS: [33mTestCase_testComputeEqualFloat64Equal[0m, time elapsed: 35500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64Equal (10000 ns)
    TCS: [33mTestCase_testComputeEqualFloat64NotEqual[0m, time elapsed: 38000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64NotEqual (10700 ns)
    TCS: [33mTestCase_testComputeEqualBoolEqual[0m, time elapsed: 22300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualBoolEqual (6600 ns)
    TCS: [33mTestCase_testComputeEqualBoolNotEqual[0m, time elapsed: 76700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualBoolNotEqual (24200 ns)
    TCS: [33mTestCase_testComputeEqualNumericInt32[0m, time elapsed: 31400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericInt32 (12200 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32[0m, time elapsed: 103300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32 (35700 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32Epsilon[0m, time elapsed: 41800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32Epsilon (11600 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64[0m, time elapsed: 90300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64 (26900 ns)
    TCS: [33mTestCase_testComputeEqualInt64Equal[0m, time elapsed: 36000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt64Equal (8800 ns)
    TCS: [33mTestCase_testComputeEqualInt64NotEqual[0m, time elapsed: 49700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt64NotEqual (5500 ns)
    TCS: [33mTestCase_testComputeEqualFloat32Nan[0m, time elapsed: 20200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32Nan (5700 ns)
    TCS: [33mTestCase_testComputeEqualFloat64Nan[0m, time elapsed: 40100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64Nan (22200 ns)
    TCS: [33mTestCase_testComputeEqualFloat32SignedZero[0m, time elapsed: 54800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32SignedZero (30000 ns)
    TCS: [33mTestCase_testComputeEqualFloat64SignedZero[0m, time elapsed: 75800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64SignedZero (31200 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32NotEqual[0m, time elapsed: 37900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32NotEqual (12000 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32BeyondEpsilon[0m, time elapsed: 46300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32BeyondEpsilon (22300 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64NotEqual[0m, time elapsed: 415700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64NotEqual (381400 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64Epsilon[0m, time elapsed: 79600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64Epsilon (12300 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64BeyondEpsilon[0m, time elapsed: 39200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64BeyondEpsilon (10700 ns)
    TCS: [33mTestCase_testComputeEqualNumericInt64[0m, time elapsed: 37000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericInt64 (12300 ns)
    TCS: [33mTestCase_testPackedHighpImplementsQualifier[0m, time elapsed: 27800 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedHighpImplementsQualifier (9100 ns)
    TCS: [33mTestCase_testPackedMediumpImplementsQualifier[0m, time elapsed: 21100 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedMediumpImplementsQualifier (5200 ns)
    TCS: [33mTestCase_testPackedLowpImplementsQualifier[0m, time elapsed: 31100 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedLowpImplementsQualifier (6000 ns)
    TCS: [33mTestCase_testDefaultpIsPackedHighp[0m, time elapsed: 20900 ns, RESULT:
    [[32m PASSED [0m] CASE: testDefaultpIsPackedHighp (5500 ns)
    TCS: [33mTestCase_testScalarAddVec1[0m, time elapsed: 39200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec1 (13400 ns)
    TCS: [33mTestCase_testScalarAddVec2[0m, time elapsed: 287300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec2 (261500 ns)
    TCS: [33mTestCase_testScalarAddVec3[0m, time elapsed: 70700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec3 (13400 ns)
    TCS: [33mTestCase_testScalarAddVec4[0m, time elapsed: 35500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec4 (11100 ns)
    TCS: [33mTestCase_testScalarSubVec1[0m, time elapsed: 49100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1 (11600 ns)
    TCS: [33mTestCase_testScalarMulVec1[0m, time elapsed: 54300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1 (13600 ns)
    TCS: [33mTestCase_testScalarDivVec1[0m, time elapsed: 41600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1 (20800 ns)
    TCS: [33mTestCase_testScalarModVec1[0m, time elapsed: 25100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1 (11200 ns)
    TCS: [33mTestCase_testScalarMulVec2[0m, time elapsed: 32100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2 (17300 ns)
    TCS: [33mTestCase_testScalarSubVec2[0m, time elapsed: 20500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2 (5700 ns)
    TCS: [33mTestCase_testScalarSubVec3[0m, time elapsed: 34300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3 (7900 ns)
    TCS: [33mTestCase_testScalarSubVec4[0m, time elapsed: 22700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4 (7700 ns)
    TCS: [33mTestCase_testScalarMulVec3[0m, time elapsed: 20000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3 (6100 ns)
    TCS: [33mTestCase_testScalarMulVec4[0m, time elapsed: 21800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4 (7900 ns)
    TCS: [33mTestCase_testScalarDivVec2[0m, time elapsed: 20400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2 (6000 ns)
    TCS: [33mTestCase_testScalarDivVec3[0m, time elapsed: 33400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3 (7800 ns)
    TCS: [33mTestCase_testScalarDivVec4[0m, time elapsed: 21200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4 (7400 ns)
    TCS: [33mTestCase_testScalarModVec2[0m, time elapsed: 29900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2 (5700 ns)
    TCS: [33mTestCase_testScalarModVec3[0m, time elapsed: 22600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3 (7800 ns)
    TCS: [33mTestCase_testScalarModVec4[0m, time elapsed: 38600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4 (12500 ns)
    TCS: [33mTestCase_testScalarModVec1Float32[0m, time elapsed: 66100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float32 (20100 ns)
    TCS: [33mTestCase_testScalarModVec2Float32[0m, time elapsed: 39400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32 (8000 ns)
    TCS: [33mTestCase_testScalarModVec3Float32[0m, time elapsed: 21400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float32 (6200 ns)
    TCS: [33mTestCase_testScalarModVec4Float32[0m, time elapsed: 31200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float32 (7900 ns)
    TCS: [33mTestCase_testScalarModVec1Float64[0m, time elapsed: 24900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float64 (10200 ns)
    TCS: [33mTestCase_testScalarModVec2Float64[0m, time elapsed: 32500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float64 (17800 ns)
    TCS: [33mTestCase_testScalarModVec3Float64[0m, time elapsed: 20900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float64 (6800 ns)
    TCS: [33mTestCase_testScalarModVec4Float64[0m, time elapsed: 30900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float64 (16000 ns)
    TCS: [33mTestCase_testScalarModVec1Float16[0m, time elapsed: 30300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float16 (15800 ns)
    TCS: [33mTestCase_testScalarModVec2Float16[0m, time elapsed: 31800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float16 (16400 ns)
    TCS: [33mTestCase_testScalarModVec3Float16[0m, time elapsed: 20700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float16 (6700 ns)
    TCS: [33mTestCase_testScalarModVec4Float16[0m, time elapsed: 20200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float16 (6700 ns)
    TCS: [33mTestCase_testScalarSubVec2PackedMediump[0m, time elapsed: 25100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2PackedMediump (9200 ns)
    TCS: [33mTestCase_testScalarSubVec2PackedLowp[0m, time elapsed: 22600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2PackedLowp (8100 ns)
    TCS: [33mTestCase_testScalarMulVec2PackedMediump[0m, time elapsed: 31600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2PackedMediump (7200 ns)
    TCS: [33mTestCase_testScalarMulVec2PackedLowp[0m, time elapsed: 21400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2PackedLowp (7200 ns)
    TCS: [33mTestCase_testScalarDivVec2PackedMediump[0m, time elapsed: 33600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2PackedMediump (6000 ns)
    TCS: [33mTestCase_testScalarDivVec2PackedLowp[0m, time elapsed: 21700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2PackedLowp (7600 ns)
    TCS: [33mTestCase_testScalarModVec2PackedMediump[0m, time elapsed: 32400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2PackedMediump (7400 ns)
    TCS: [33mTestCase_testScalarModVec2PackedLowp[0m, time elapsed: 20100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2PackedLowp (5600 ns)
    TCS: [33mTestCase_testScalarModVec2Float32PackedMediump[0m, time elapsed: 31400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32PackedMediump (6900 ns)
    TCS: [33mTestCase_testScalarModVec2Float32PackedLowp[0m, time elapsed: 20800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32PackedLowp (5900 ns)
    TCS: [33mTestCase_testScalarModVec2Float32NegativeDividend[0m, time elapsed: 30800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32NegativeDividend (16000 ns)
    TCS: [33mTestCase_testScalarModVec2Float32NegativeDivisor[0m, time elapsed: 19300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32NegativeDivisor (5300 ns)
    TCS: [33mTestCase_testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents[0m, time elapsed: 144600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents (114600 ns)
    TCS: [33mTestCase_testScalarAddVec1Float32[0m, time elapsed: 38500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec1Float32 (14200 ns)
    TCS: [33mTestCase_testScalarAddVec2Float32[0m, time elapsed: 67300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec2Float32 (33900 ns)
    TCS: [33mTestCase_testScalarAddVec3Float32[0m, time elapsed: 56100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec3Float32 (10100 ns)
    TCS: [33mTestCase_testScalarAddVec4Float32[0m, time elapsed: 58000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec4Float32 (10700 ns)
    TCS: [33mTestCase_testScalarSubVec1Float32[0m, time elapsed: 36000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1Float32 (12200 ns)
    TCS: [33mTestCase_testScalarSubVec2Float32[0m, time elapsed: 33500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2Float32 (10400 ns)
    TCS: [33mTestCase_testScalarSubVec3Float32[0m, time elapsed: 32400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3Float32 (7500 ns)
    TCS: [33mTestCase_testScalarSubVec4Float32[0m, time elapsed: 21300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4Float32 (5900 ns)
    TCS: [33mTestCase_testScalarMulVec1Float32[0m, time elapsed: 42100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1Float32 (5900 ns)
    TCS: [33mTestCase_testScalarMulVec2Float32[0m, time elapsed: 19500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2Float32 (5600 ns)
    TCS: [33mTestCase_testScalarMulVec3Float32[0m, time elapsed: 38600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3Float32 (5600 ns)
    TCS: [33mTestCase_testScalarMulVec4Float32[0m, time elapsed: 19500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4Float32 (6100 ns)
    TCS: [33mTestCase_testScalarDivVec1Float32[0m, time elapsed: 40200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1Float32 (5900 ns)
    TCS: [33mTestCase_testScalarDivVec2Float32[0m, time elapsed: 19400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2Float32 (5300 ns)
    TCS: [33mTestCase_testScalarDivVec3Float32[0m, time elapsed: 39100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3Float32 (5500 ns)
    TCS: [33mTestCase_testScalarDivVec4Float32[0m, time elapsed: 19800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4Float32 (6300 ns)
    TCS: [33mTestCase_testScalarAddVec1Int32[0m, time elapsed: 44100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec1Int32 (12200 ns)
    TCS: [33mTestCase_testScalarAddVec2Int32[0m, time elapsed: 20100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec2Int32 (6800 ns)
    TCS: [33mTestCase_testScalarAddVec3Int32[0m, time elapsed: 41700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec3Int32 (25200 ns)
    TCS: [33mTestCase_testScalarAddVec4Int32[0m, time elapsed: 23100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec4Int32 (6700 ns)
    TCS: [33mTestCase_testScalarSubVec1Int32[0m, time elapsed: 40800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1Int32 (8200 ns)
    TCS: [33mTestCase_testScalarSubVec2Int32[0m, time elapsed: 20100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2Int32 (5400 ns)
    TCS: [33mTestCase_testScalarSubVec3Int32[0m, time elapsed: 31800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3Int32 (18100 ns)
    TCS: [33mTestCase_testScalarSubVec4Int32[0m, time elapsed: 20500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4Int32 (6100 ns)
    TCS: [33mTestCase_testScalarMulVec1Int32[0m, time elapsed: 34300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1Int32 (7000 ns)
    TCS: [33mTestCase_testScalarMulVec2Int32[0m, time elapsed: 21300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2Int32 (5700 ns)
    TCS: [33mTestCase_testScalarMulVec3Int32[0m, time elapsed: 19600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3Int32 (5400 ns)
    TCS: [33mTestCase_testScalarMulVec4Int32[0m, time elapsed: 20100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4Int32 (5900 ns)
    TCS: [33mTestCase_testScalarDivVec1Int32[0m, time elapsed: 19000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1Int32 (5800 ns)
    TCS: [33mTestCase_testScalarDivVec2Int32[0m, time elapsed: 62300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2Int32 (33600 ns)
    TCS: [33mTestCase_testScalarDivVec3Int32[0m, time elapsed: 21200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3Int32 (5600 ns)
    TCS: [33mTestCase_testScalarDivVec4Int32[0m, time elapsed: 40600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4Int32 (6600 ns)
    TCS: [33mTestCase_testScalarModVec1Int32[0m, time elapsed: 21500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Int32 (6700 ns)
    TCS: [33mTestCase_testScalarModVec2Int32[0m, time elapsed: 37200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Int32 (5300 ns)
    TCS: [33mTestCase_testScalarModVec3Int32[0m, time elapsed: 21400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Int32 (6300 ns)
    TCS: [33mTestCase_testScalarModVec4Int32[0m, time elapsed: 40600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Int32 (6800 ns)
    TCS: [33mTestCase_testScalarSubVec1PackedMediump[0m, time elapsed: 21400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1PackedMediump (6900 ns)
    TCS: [33mTestCase_testScalarSubVec1PackedLowp[0m, time elapsed: 38000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1PackedLowp (24000 ns)
    TCS: [33mTestCase_testScalarSubVec3PackedMediump[0m, time elapsed: 20800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3PackedMediump (6600 ns)
    TCS: [33mTestCase_testScalarSubVec3PackedLowp[0m, time elapsed: 46200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3PackedLowp (8900 ns)
    TCS: [33mTestCase_testScalarSubVec4PackedMediump[0m, time elapsed: 21200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4PackedMediump (6800 ns)
    TCS: [33mTestCase_testScalarSubVec4PackedLowp[0m, time elapsed: 31200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4PackedLowp (14800 ns)
    TCS: [33mTestCase_testScalarMulVec1PackedMediump[0m, time elapsed: 30900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1PackedMediump (11300 ns)
    TCS: [33mTestCase_testScalarMulVec1PackedLowp[0m, time elapsed: 48800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1PackedLowp (11000 ns)
    TCS: [33mTestCase_testScalarMulVec3PackedMediump[0m, time elapsed: 20700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3PackedMediump (6300 ns)
    TCS: [33mTestCase_testScalarMulVec3PackedLowp[0m, time elapsed: 19500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3PackedLowp (5200 ns)
    TCS: [33mTestCase_testScalarMulVec4PackedMediump[0m, time elapsed: 20500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4PackedMediump (6100 ns)
    TCS: [33mTestCase_testScalarMulVec4PackedLowp[0m, time elapsed: 21300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4PackedLowp (6600 ns)
    TCS: [33mTestCase_testScalarDivVec1PackedMediump[0m, time elapsed: 42300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1PackedMediump (5500 ns)
    TCS: [33mTestCase_testScalarDivVec1PackedLowp[0m, time elapsed: 20100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1PackedLowp (6100 ns)
    TCS: [33mTestCase_testScalarDivVec3PackedMediump[0m, time elapsed: 37400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3PackedMediump (5700 ns)
    TCS: [33mTestCase_testScalarDivVec3PackedLowp[0m, time elapsed: 20600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3PackedLowp (5600 ns)
    TCS: [33mTestCase_testScalarDivVec4PackedMediump[0m, time elapsed: 47000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4PackedMediump (6200 ns)
    TCS: [33mTestCase_testScalarDivVec4PackedLowp[0m, time elapsed: 20300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4PackedLowp (5900 ns)
    TCS: [33mTestCase_testScalarModVec1PackedMediump[0m, time elapsed: 69800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1PackedMediump (6700 ns)
    TCS: [33mTestCase_testScalarModVec1PackedLowp[0m, time elapsed: 20100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1PackedLowp (5300 ns)
    TCS: [33mTestCase_testScalarModVec3PackedMediump[0m, time elapsed: 96100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3PackedMediump (80600 ns)
    TCS: [33mTestCase_testScalarModVec3PackedLowp[0m, time elapsed: 24100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3PackedLowp (6500 ns)
    TCS: [33mTestCase_testScalarModVec4PackedMediump[0m, time elapsed: 64200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4PackedMediump (46800 ns)
    TCS: [33mTestCase_testScalarModVec4PackedLowp[0m, time elapsed: 43800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4PackedLowp (12500 ns)
    TCS: [33mTestCase_testScalarDivZeroVec1[0m, time elapsed: 85100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivZeroVec1 (57400 ns)
    TCS: [33mTestCase_testScalarAddNegVec1[0m, time elapsed: 55900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddNegVec1 (15600 ns)
    TCS: [33mTestCase_testScalarAddNegVec2[0m, time elapsed: 105900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddNegVec2 (11500 ns)
    TCS: [33mTestCase_testScalarMulOverflowVec1[0m, time elapsed: 56900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulOverflowVec1 (13700 ns)
    TCS: [33mTestCase_testScalarSubNegVec1[0m, time elapsed: 46800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubNegVec1 (13500 ns)
    TCS: [33mTestCase_testVersionMajor[0m, time elapsed: 73000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionMajor (22500 ns)
    TCS: [33mTestCase_testVersionMinor[0m, time elapsed: 49500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionMinor (11900 ns)
    TCS: [33mTestCase_testVersionPatch[0m, time elapsed: 76000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionPatch (6700 ns)
    TCS: [33mTestCase_testVersionEncoded[0m, time elapsed: 26700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionEncoded (9900 ns)
    TCS: [33mTestCase_testConfigSimd[0m, time elapsed: 63000 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigSimd (10200 ns)
    TCS: [33mTestCase_testConfigAlignedGentypes[0m, time elapsed: 24200 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigAlignedGentypes (6100 ns)
    TCS: [33mTestCase_testConfigClipControl[0m, time elapsed: 52200 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigClipControl (6000 ns)
    TCS: [33mTestCase_testConstNegationSimd[0m, time elapsed: 46800 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationSimd (6000 ns)
    TCS: [33mTestCase_testConstNegationAligned[0m, time elapsed: 62600 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationAligned (47100 ns)
    TCS: [33mTestCase_testConstNegationClip[0m, time elapsed: 20500 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationClip (5000 ns)
    TCS: [33mTestCase_testConstInt64Usage[0m, time elapsed: 44000 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstInt64Usage (5300 ns)
    TCS: [33mTestCase_testConstBoolUsage[0m, time elapsed: 21200 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstBoolUsage (5600 ns)
    TCS: [33mTestCase_testVersionEncodingConsistency[0m, time elapsed: 47200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionEncodingConsistency (32400 ns)
    TCS: [33mTestCase_testAssertPasses[0m, time elapsed: 25900 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertPasses (11700 ns)
    TCS: [33mTestCase_testAssertFails[0m, time elapsed: 91500 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertFails (44500 ns)
    TCS: [33mTestCase_testAssertWithCustomMessage[0m, time elapsed: 52200 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertWithCustomMessage (35400 ns)
    TCS: [33mTestCase_testNumericLimitsFloat32Epsilon[0m, time elapsed: 26100 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsFloat32Epsilon (9400 ns)
    TCS: [33mTestCase_testNumericLimitsFloat64Epsilon[0m, time elapsed: 24200 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsFloat64Epsilon (8200 ns)
    TCS: [33mTestCase_testIsIec559OfFloat32[0m, time elapsed: 21600 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfFloat32 (5500 ns)
    TCS: [33mTestCase_testIsIec559OfFloat64[0m, time elapsed: 52500 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfFloat64 (5500 ns)
    TCS: [33mTestCase_testIsIec559OfInt64[0m, time elapsed: 23400 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfInt64 (8200 ns)
    TCS: [33mTestCase_testEpsilonOfFloat32[0m, time elapsed: 108300 ns, RESULT:
    [[32m PASSED [0m] CASE: testEpsilonOfFloat32 (14400 ns)
    TCS: [33mTestCase_testEpsilonOfFloat64[0m, time elapsed: 38900 ns, RESULT:
    [[32m PASSED [0m] CASE: testEpsilonOfFloat64 (10300 ns)
    TCS: [33mTestCase_testNumericLimitsInt64Epsilon[0m, time elapsed: 83100 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt64Epsilon (12900 ns)
    TCS: [33mTestCase_testNumericLimitsInt32Epsilon[0m, time elapsed: 34800 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt32Epsilon (9400 ns)
    TCS: [33mTestCase_testNumericLimitsInt16Epsilon[0m, time elapsed: 78400 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt16Epsilon (36700 ns)
    TCS: [33mTestCase_testNumericLimitsInt8Epsilon[0m, time elapsed: 28200 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt8Epsilon (10800 ns)
    TCS: [33mTestCase_testCastVec1ToVec1IntToFloat[0m, time elapsed: 84700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec1ToVec1IntToFloat (62800 ns)
    TCS: [33mTestCase_testCastVec2ToVec1TakesOnlyX[0m, time elapsed: 27300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2ToVec1TakesOnlyX (10100 ns)
    TCS: [33mTestCase_testCastVec3ToVec1TakesOnlyX[0m, time elapsed: 56300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3ToVec1TakesOnlyX (38000 ns)
    TCS: [33mTestCase_testCastVec4ToVec1TakesOnlyX[0m, time elapsed: 24400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4ToVec1TakesOnlyX (8700 ns)
    TCS: [33mTestCase_testCastSameTypeIdentity[0m, time elapsed: 92300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastSameTypeIdentity (65700 ns)
    TCS: [33mTestCase_testCastInt32ToInt64[0m, time elapsed: 41600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastInt32ToInt64 (10900 ns)
    TCS: [33mTestCase_testCastFloatToIntTruncation[0m, time elapsed: 26300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastFloatToIntTruncation (7200 ns)
    TCS: [33mTestCase_testCastCrossQualifierPackedHighpToDefaultp[0m, time elapsed: 23400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastCrossQualifierPackedHighpToDefaultp (6400 ns)
    TCS: [33mTestCase_testCastCrossQualifierDefaultpToPackedHighp[0m, time elapsed: 24300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastCrossQualifierDefaultpToPackedHighp (6500 ns)
    TCS: [33mTestCase_testCastVec2CrossQualifierCrossType[0m, time elapsed: 44600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2CrossQualifierCrossType (7100 ns)
    TCS: [33mTestCase_testCastVec3CrossQualifier[0m, time elapsed: 20700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3CrossQualifier (6500 ns)
    TCS: [33mTestCase_testCastVec4CrossQualifier[0m, time elapsed: 46100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4CrossQualifier (6600 ns)
    TCS: [33mTestCase_testCastVec1DoesNotModifySource[0m, time elapsed: 20000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec1DoesNotModifySource (5900 ns)
    TCS: [33mTestCase_testCastVec2Vec1ToVec2IntToFloat[0m, time elapsed: 55100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec1ToVec2IntToFloat (7200 ns)
    TCS: [33mTestCase_testCastVec2Vec2ToVec2Identity[0m, time elapsed: 23400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec2ToVec2Identity (9500 ns)
    TCS: [33mTestCase_testCastVec2Vec3ToVec2TakesOnlyXY[0m, time elapsed: 42600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec3ToVec2TakesOnlyXY (7100 ns)
    TCS: [33mTestCase_testCastVec2Vec4ToVec2TakesOnlyXY[0m, time elapsed: 22000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec4ToVec2TakesOnlyXY (7700 ns)
    TCS: [33mTestCase_testCastVec2SameTypeIdentity[0m, time elapsed: 57000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2SameTypeIdentity (23800 ns)
    TCS: [33mTestCase_testCastVec2Int32ToInt64[0m, time elapsed: 59100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Int32ToInt64 (16300 ns)
    TCS: [33mTestCase_testCastVec2FloatToIntTruncation[0m, time elapsed: 127900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2FloatToIntTruncation (52000 ns)
    TCS: [33mTestCase_testCastVec2CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 35400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2CrossQualifierPackedHighpToDefaultp (9300 ns)
    TCS: [33mTestCase_testCastVec2DoesNotModifySource[0m, time elapsed: 79200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2DoesNotModifySource (54000 ns)
    TCS: [33mTestCase_testCastVec2Vec1ToVec2SameValueBothComponents[0m, time elapsed: 35600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec1ToVec2SameValueBothComponents (9600 ns)
    TCS: [33mTestCase_testCastVec3Vec1ToVec3IntToFloat[0m, time elapsed: 97600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec1ToVec3IntToFloat (73300 ns)
    TCS: [33mTestCase_testCastVec3Vec2ToVec3ExtendY[0m, time elapsed: 42500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec2ToVec3ExtendY (19500 ns)
    TCS: [33mTestCase_testCastVec3Vec3ToVec3Identity[0m, time elapsed: 56100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec3ToVec3Identity (5700 ns)
    TCS: [33mTestCase_testCastVec3Vec4ToVec3TakesOnlyXYZ[0m, time elapsed: 25500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec4ToVec3TakesOnlyXYZ (9300 ns)
    TCS: [33mTestCase_testCastVec3SameTypeIdentity[0m, time elapsed: 20200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3SameTypeIdentity (5800 ns)
    TCS: [33mTestCase_testCastVec3Int32ToInt64[0m, time elapsed: 23900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Int32ToInt64 (6800 ns)
    TCS: [33mTestCase_testCastVec3FloatToIntTruncation[0m, time elapsed: 22400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3FloatToIntTruncation (6000 ns)
    TCS: [33mTestCase_testCastVec3CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 61000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3CrossQualifierPackedHighpToDefaultp (5800 ns)
    TCS: [33mTestCase_testCastVec3DoesNotModifySource[0m, time elapsed: 21100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3DoesNotModifySource (5900 ns)
    TCS: [33mTestCase_testCastVec3Vec1ToVec3SameValueAllComponents[0m, time elapsed: 61900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec1ToVec3SameValueAllComponents (6400 ns)
    TCS: [33mTestCase_testCastVec4Vec1ToVec4IntToFloat[0m, time elapsed: 31400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec1ToVec4IntToFloat (12300 ns)
    TCS: [33mTestCase_testCastVec4Vec2ToVec4ExtendY[0m, time elapsed: 69900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec2ToVec4ExtendY (7600 ns)
    TCS: [33mTestCase_testCastVec4Vec3ToVec4ExtendZ[0m, time elapsed: 29400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec3ToVec4ExtendZ (11100 ns)
    TCS: [33mTestCase_testCastVec4Vec4ToVec4Identity[0m, time elapsed: 199500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec4ToVec4Identity (24600 ns)
    TCS: [33mTestCase_testCastVec4SameTypeIdentity[0m, time elapsed: 143100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4SameTypeIdentity (26700 ns)
    TCS: [33mTestCase_testCastVec4Int32ToInt64[0m, time elapsed: 107200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Int32ToInt64 (14900 ns)
    TCS: [33mTestCase_testCastVec4FloatToIntTruncation[0m, time elapsed: 39500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4FloatToIntTruncation (10200 ns)
    TCS: [33mTestCase_testCastVec4CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 81800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4CrossQualifierPackedHighpToDefaultp (54300 ns)
    TCS: [33mTestCase_testCastVec4DoesNotModifySource[0m, time elapsed: 29200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4DoesNotModifySource (8400 ns)
    TCS: [33mTestCase_testCastVec4Vec1ToVec4SameValueAllComponents[0m, time elapsed: 62100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec1ToVec4SameValueAllComponents (9700 ns)
    TCS: [33mTestCase_testFromBoolVec1[0m, time elapsed: 32900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec1 (12500 ns)
    TCS: [33mTestCase_testFromBoolVec1False[0m, time elapsed: 60900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec1False (40700 ns)
    TCS: [33mTestCase_testFromBoolVec2[0m, time elapsed: 31700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec2 (11100 ns)
    TCS: [33mTestCase_testFromBoolVec3[0m, time elapsed: 66300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec3 (11900 ns)
    TCS: [33mTestCase_testFromBoolVec4[0m, time elapsed: 32300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec4 (11200 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec1[0m, time elapsed: 28800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec1 (8200 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec2[0m, time elapsed: 41200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec2 (14400 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec3[0m, time elapsed: 37400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec3 (10000 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec4[0m, time elapsed: 135800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec4 (13200 ns)
    TCS: [33mTestCase_testFromBoolVec3AllFalse[0m, time elapsed: 43100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec3AllFalse (10200 ns)
    TCS: [33mTestCase_testFromBoolVec4AllFalse[0m, time elapsed: 101600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec4AllFalse (10400 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec3AllFalse[0m, time elapsed: 30700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec3AllFalse (8600 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec4AllFalse[0m, time elapsed: 78800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec4AllFalse (11700 ns)
    TCS: [33mTestCase_testFromBoolVecFloat32[0m, time elapsed: 30400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecFloat32 (9500 ns)
    TCS: [33mTestCase_testFromBoolVecFloat64[0m, time elapsed: 81200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecFloat64 (15200 ns)
    TCS: [33mTestCase_testFromBoolVecInt32[0m, time elapsed: 40200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecInt32 (13700 ns)
    TCS: [33mTestCase_testFromBoolVecQ2PackedMediump[0m, time elapsed: 58400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2PackedMediump (36900 ns)
    TCS: [33mTestCase_testFromBoolVecQ2PackedLowp[0m, time elapsed: 31700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2PackedLowp (11100 ns)
    TCS: [33mTestCase_testS1QuatCastScalingXBranch[0m, time elapsed: 123700 ns, RESULT:
    [[32m PASSED [0m] CASE: testS1QuatCastScalingXBranch (103700 ns)
    TCS: [33mTestCase_testS1QuatCastScalingYBranch[0m, time elapsed: 46900 ns, RESULT:
    [[32m PASSED [0m] CASE: testS1QuatCastScalingYBranch (24300 ns)
    TCS: [33mTestCase_testS1QuatCastScalingZBranch[0m, time elapsed: 69200 ns, RESULT:
    [[32m PASSED [0m] CASE: testS1QuatCastScalingZBranch (48200 ns)
    TCS: [33mTestCase_testS1QuatCastScalingWBranch[0m, time elapsed: 80000 ns, RESULT:
    [[32m PASSED [0m] CASE: testS1QuatCastScalingWBranch (18900 ns)
    TCS: [33mTestCase_testS1QuatCastUnitRoundTrip[0m, time elapsed: 81600 ns, RESULT:
    [[32m PASSED [0m] CASE: testS1QuatCastUnitRoundTrip (17800 ns)
    TCS: [33mTestCase_testS1QuatCastIdentityRoundTrip[0m, time elapsed: 35000 ns, RESULT:
    [[32m PASSED [0m] CASE: testS1QuatCastIdentityRoundTrip (13300 ns)
    TCS: [33mTestCase_testS1QuatCastMat4Delegation[0m, time elapsed: 103500 ns, RESULT:
    [[32m PASSED [0m] CASE: testS1QuatCastMat4Delegation (38400 ns)
    TCS: [33mTestCase_testMat3EqualEpsilonRelaxedExactMatch[0m, time elapsed: 30000 ns, RESULT:
    [[32m PASSED [0m] CASE: testMat3EqualEpsilonRelaxedExactMatch (8800 ns)
    TCS: [33mTestCase_testMat3EqualEpsilonRelaxedWithinPosTolerance[0m, time elapsed: 70000 ns, RESULT:
    [[32m PASSED [0m] CASE: testMat3EqualEpsilonRelaxedWithinPosTolerance (9200 ns)
    TCS: [33mTestCase_testMat3EqualEpsilonRelaxedWithinNegTolerance[0m, time elapsed: 27800 ns, RESULT:
    [[32m PASSED [0m] CASE: testMat3EqualEpsilonRelaxedWithinNegTolerance (8300 ns)
    TCS: [33mTestCase_testMat3EqualEpsilonRelaxedBeyondTolerance[0m, time elapsed: 60500 ns, RESULT:
    [[32m PASSED [0m] CASE: testMat3EqualEpsilonRelaxedBeyondTolerance (8500 ns)
    TCS: [33mTestCase_testMat3EqualEpsilonRelaxedZeroMatrix[0m, time elapsed: 28300 ns, RESULT:
    [[32m PASSED [0m] CASE: testMat3EqualEpsilonRelaxedZeroMatrix (8500 ns)
    TCS: [33mTestCase_testMat3EqualEpsilonRelaxedSingleDiffBeyond[0m, time elapsed: 61900 ns, RESULT:
    [[32m PASSED [0m] CASE: testMat3EqualEpsilonRelaxedSingleDiffBeyond (7900 ns)
    TCS: [33mTestCase_testVec2ScalarInit[0m, time elapsed: 33200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarInit (13200 ns)
    TCS: [33mTestCase_testVec2ConstInit[0m, time elapsed: 62800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ConstInit (10400 ns)
    TCS: [33mTestCase_testVec2Length[0m, time elapsed: 27200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Length (7500 ns)
    TCS: [33mTestCase_testVec2Add[0m, time elapsed: 71600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Add (14400 ns)
    TCS: [33mTestCase_testVec2Sub[0m, time elapsed: 30100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Sub (10400 ns)
    TCS: [33mTestCase_testVec2Mul[0m, time elapsed: 60500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Mul (41200 ns)
    TCS: [33mTestCase_testVec2ScalarAdd[0m, time elapsed: 31000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarAdd (11900 ns)
    TCS: [33mTestCase_testVec2Negate[0m, time elapsed: 96500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Negate (38600 ns)
    TCS: [33mTestCase_testVec2IndexAccess[0m, time elapsed: 31500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2IndexAccess (10100 ns)
    TCS: [33mTestCase_testVec2IndexMutate[0m, time elapsed: 39700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2IndexMutate (20400 ns)
    TCS: [33mTestCase_testVec2ComponentAt[0m, time elapsed: 48100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ComponentAt (16000 ns)
    TCS: [33mTestCase_testVec2Equal[0m, time elapsed: 53600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Equal (22400 ns)
    TCS: [33mTestCase_testVec2NotEqual[0m, time elapsed: 49600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2NotEqual (22900 ns)
    TCS: [33mTestCase_testVec2EqualExact[0m, time elapsed: 29400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2EqualExact (9700 ns)
    TCS: [33mTestCase_testVec2BitwiseAnd[0m, time elapsed: 73900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseAnd (12900 ns)
    TCS: [33mTestCase_testVec2BitwiseNot[0m, time elapsed: 29200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseNot (10000 ns)
    TCS: [33mTestCase_testVec2FromVec1[0m, time elapsed: 76500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2FromVec1 (10400 ns)
    TCS: [33mTestCase_testVec2ShiftLeft[0m, time elapsed: 34000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeft (12600 ns)
    TCS: [33mTestCase_testVec2BoolLogicalAnd[0m, time elapsed: 66100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BoolLogicalAnd (10600 ns)
    TCS: [33mTestCase_testVec2Vec1ArithBroadcast[0m, time elapsed: 30600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Vec1ArithBroadcast (10900 ns)
    TCS: [33mTestCase_testVec2Vec1BitBroadcast[0m, time elapsed: 62300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Vec1BitBroadcast (13900 ns)
    TCS: [33mTestCase_testVec2ShiftLeftVec1[0m, time elapsed: 29400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeftVec1 (9700 ns)
    TCS: [33mTestCase_testVec2Div[0m, time elapsed: 62500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Div (41100 ns)
    TCS: [33mTestCase_testVec2Mod[0m, time elapsed: 31400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Mod (10900 ns)
    TCS: [33mTestCase_testVec2ScalarSub[0m, time elapsed: 59300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarSub (39900 ns)
    TCS: [33mTestCase_testVec2ScalarMul[0m, time elapsed: 67700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarMul (10500 ns)
    TCS: [33mTestCase_testVec2ScalarDiv[0m, time elapsed: 61800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarDiv (40300 ns)
    TCS: [33mTestCase_testVec2ScalarMod[0m, time elapsed: 124100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarMod (15100 ns)
    TCS: [33mTestCase_testVec2BoolLogicalOr[0m, time elapsed: 36100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BoolLogicalOr (10000 ns)
    TCS: [33mTestCase_testVec2EqualEpsilon[0m, time elapsed: 55000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2EqualEpsilon (22000 ns)
    TCS: [33mTestCase_testVec2DivNamed[0m, time elapsed: 157400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2DivNamed (13400 ns)
    TCS: [33mTestCase_testVec2ModNamed[0m, time elapsed: 39500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ModNamed (10300 ns)
    TCS: [33mTestCase_testVec2BitwiseOr[0m, time elapsed: 37000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseOr (13100 ns)
    TCS: [33mTestCase_testVec2BitwiseXor[0m, time elapsed: 67900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseXor (12700 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseAnd[0m, time elapsed: 32100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseAnd (8900 ns)
    TCS: [33mTestCase_testVec2ShiftRight[0m, time elapsed: 70600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRight (10400 ns)
    TCS: [33mTestCase_testVec2ShiftRightVec1[0m, time elapsed: 33900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRightVec1 (12600 ns)
    TCS: [33mTestCase_testVec2AddNamed[0m, time elapsed: 64400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2AddNamed (10000 ns)
    TCS: [33mTestCase_testVec2SubNamed[0m, time elapsed: 31100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2SubNamed (9400 ns)
    TCS: [33mTestCase_testVec2MulNamed[0m, time elapsed: 100400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2MulNamed (11100 ns)
    TCS: [33mTestCase_testVec2ShiftLeftVec[0m, time elapsed: 51300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeftVec (12800 ns)
    TCS: [33mTestCase_testVec2ShiftRightVec[0m, time elapsed: 85000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRightVec (59300 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseOr[0m, time elapsed: 35600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseOr (12300 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseXor[0m, time elapsed: 78200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseXor (55600 ns)
    TCS: [33mTestCase_testVec2Increment[0m, time elapsed: 41000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Increment (14600 ns)
    TCS: [33mTestCase_testVec2Decrement[0m, time elapsed: 80000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Decrement (52900 ns)
    TCS: [33mTestCase_testVec2IndexOutOfBoundsAccess[0m, time elapsed: 87800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2IndexOutOfBoundsAccess (59600 ns)
    TCS: [33mTestCase_testVec2NegativeIndexAccess[0m, time elapsed: 96800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2NegativeIndexAccess (27000 ns)
    TCS: [33mTestCase_testVec3ScalarInit[0m, time elapsed: 39300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarInit (13400 ns)
    TCS: [33mTestCase_testVec3ConstInit[0m, time elapsed: 37200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ConstInit (9700 ns)
    TCS: [33mTestCase_testVec3Length[0m, time elapsed: 35100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Length (9700 ns)
    TCS: [33mTestCase_testVec3Add[0m, time elapsed: 39400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Add (17500 ns)
    TCS: [33mTestCase_testVec3ScalarMul[0m, time elapsed: 68900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarMul (15100 ns)
    TCS: [33mTestCase_testVec3Negate[0m, time elapsed: 79500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Negate (13100 ns)
    TCS: [33mTestCase_testVec3IndexAccess[0m, time elapsed: 80000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3IndexAccess (10100 ns)
    TCS: [33mTestCase_testVec3IndexMutate[0m, time elapsed: 36100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3IndexMutate (11900 ns)
    TCS: [33mTestCase_testVec3ComponentAt[0m, time elapsed: 93100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ComponentAt (15100 ns)
    TCS: [33mTestCase_testVec3Equal[0m, time elapsed: 42100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Equal (18000 ns)
    TCS: [33mTestCase_testVec3NotEqual[0m, time elapsed: 75900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3NotEqual (13700 ns)
    TCS: [33mTestCase_testVec3EqualExact[0m, time elapsed: 36100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3EqualExact (11800 ns)
    TCS: [33mTestCase_testVec3BitwiseAnd[0m, time elapsed: 95100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseAnd (69800 ns)
    TCS: [33mTestCase_testVec3BitwiseNot[0m, time elapsed: 37200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseNot (11600 ns)
    TCS: [33mTestCase_testVec3Vec1ArithBroadcast[0m, time elapsed: 85200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1ArithBroadcast (59400 ns)
    TCS: [33mTestCase_testVec3ShiftLeft[0m, time elapsed: 51200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeft (21900 ns)
    TCS: [33mTestCase_testVec3BoolLogicalAnd[0m, time elapsed: 91400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BoolLogicalAnd (63200 ns)
    TCS: [33mTestCase_testVec3Sub[0m, time elapsed: 51900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Sub (18700 ns)
    TCS: [33mTestCase_testVec3Div[0m, time elapsed: 79900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Div (14200 ns)
    TCS: [33mTestCase_testVec3Mod[0m, time elapsed: 43400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Mod (14600 ns)
    TCS: [33mTestCase_testVec3ScalarSub[0m, time elapsed: 38000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarSub (13700 ns)
    TCS: [33mTestCase_testVec3ScalarDiv[0m, time elapsed: 41400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarDiv (15100 ns)
    TCS: [33mTestCase_testVec3ScalarMod[0m, time elapsed: 34200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarMod (11200 ns)
    TCS: [33mTestCase_testVec3BoolLogicalOr[0m, time elapsed: 93100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BoolLogicalOr (12800 ns)
    TCS: [33mTestCase_testVec3EqualEpsilon[0m, time elapsed: 47200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3EqualEpsilon (24400 ns)
    TCS: [33mTestCase_testVec3AddNamed[0m, time elapsed: 81900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3AddNamed (13600 ns)
    TCS: [33mTestCase_testVec3MulNamed[0m, time elapsed: 32000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3MulNamed (9400 ns)
    TCS: [33mTestCase_testVec3DivNamed[0m, time elapsed: 70400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3DivNamed (10700 ns)
    TCS: [33mTestCase_testVec3ModNamed[0m, time elapsed: 31400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ModNamed (7800 ns)
    TCS: [33mTestCase_testVec3BitwiseOr[0m, time elapsed: 46400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseOr (17800 ns)
    TCS: [33mTestCase_testVec3BitwiseXor[0m, time elapsed: 42500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseXor (13600 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseAnd[0m, time elapsed: 66200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseAnd (45300 ns)
    TCS: [33mTestCase_testVec3ShiftRight[0m, time elapsed: 22500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRight (7400 ns)
    TCS: [33mTestCase_testVec3Vec1BitBroadcast[0m, time elapsed: 51500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitBroadcast (36300 ns)
    TCS: [33mTestCase_testVec3ShiftRightVec1[0m, time elapsed: 24300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRightVec1 (8500 ns)
    TCS: [33mTestCase_testVec3FromVec1[0m, time elapsed: 44900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3FromVec1 (30200 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseOr[0m, time elapsed: 25600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseOr (10000 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseXor[0m, time elapsed: 76700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseXor (9300 ns)
    TCS: [33mTestCase_testVec3Vec1BitOrBroadcast[0m, time elapsed: 26300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitOrBroadcast (8700 ns)
    TCS: [33mTestCase_testVec3Vec1BitXorBroadcast[0m, time elapsed: 23200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitXorBroadcast (8600 ns)
    TCS: [33mTestCase_testVec3ShiftLeftVec1[0m, time elapsed: 25000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeftVec1 (9900 ns)
    TCS: [33mTestCase_testVec3ShiftLeftVec[0m, time elapsed: 20400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeftVec (6300 ns)
    TCS: [33mTestCase_testVec3ShiftRightVec[0m, time elapsed: 52600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRightVec (7500 ns)
    TCS: [33mTestCase_testVec3Increment[0m, time elapsed: 26900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Increment (11900 ns)
    TCS: [33mTestCase_testVec3Decrement[0m, time elapsed: 52400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Decrement (10000 ns)
    TCS: [33mTestCase_testVec3IndexOutOfBoundsAccess[0m, time elapsed: 56400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3IndexOutOfBoundsAccess (40900 ns)
    TCS: [33mTestCase_testVec3NegativeIndexAccess[0m, time elapsed: 55000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3NegativeIndexAccess (14000 ns)
    TCS: [33mTestCase_testVec4ScalarInit[0m, time elapsed: 22400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarInit (8400 ns)
    TCS: [33mTestCase_testVec4ConstInit[0m, time elapsed: 51800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ConstInit (6400 ns)
    TCS: [33mTestCase_testVec4Length[0m, time elapsed: 20800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Length (5600 ns)
    TCS: [33mTestCase_testVec4Add[0m, time elapsed: 53500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Add (12300 ns)
    TCS: [33mTestCase_testVec4ScalarMul[0m, time elapsed: 26400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarMul (11600 ns)
    TCS: [33mTestCase_testVec4Negate[0m, time elapsed: 50100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Negate (35900 ns)
    TCS: [33mTestCase_testVec4IndexAccess[0m, time elapsed: 21500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4IndexAccess (6400 ns)
    TCS: [33mTestCase_testVec4IndexMutate[0m, time elapsed: 54800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4IndexMutate (39600 ns)
    TCS: [33mTestCase_testVec4ComponentAt[0m, time elapsed: 22400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ComponentAt (6400 ns)
    TCS: [33mTestCase_testVec4Equal[0m, time elapsed: 53200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Equal (38600 ns)
    TCS: [33mTestCase_testVec4NotEqual[0m, time elapsed: 23600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4NotEqual (7600 ns)
    TCS: [33mTestCase_testVec4EqualExact[0m, time elapsed: 21200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4EqualExact (7600 ns)
    TCS: [33mTestCase_testVec4BitwiseAnd[0m, time elapsed: 25100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseAnd (9700 ns)
    TCS: [33mTestCase_testVec4BitwiseNot[0m, time elapsed: 43900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseNot (8000 ns)
    TCS: [33mTestCase_testVec4Vec1ArithBroadcast[0m, time elapsed: 25400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1ArithBroadcast (9900 ns)
    TCS: [33mTestCase_testVec4ShiftLeft[0m, time elapsed: 23200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeft (9300 ns)
    TCS: [33mTestCase_testVec4BoolLogicalAnd[0m, time elapsed: 49300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BoolLogicalAnd (8400 ns)
    TCS: [33mTestCase_testVec4Sub[0m, time elapsed: 23300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Sub (9300 ns)
    TCS: [33mTestCase_testVec4Div[0m, time elapsed: 51200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Div (9800 ns)
    TCS: [33mTestCase_testVec4Mod[0m, time elapsed: 23800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Mod (9300 ns)
    TCS: [33mTestCase_testVec4ScalarSub[0m, time elapsed: 53400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarSub (8600 ns)
    TCS: [33mTestCase_testVec4ScalarDiv[0m, time elapsed: 23700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarDiv (9400 ns)
    TCS: [33mTestCase_testVec4ScalarMod[0m, time elapsed: 49400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarMod (9400 ns)
    TCS: [33mTestCase_testVec4BoolLogicalOr[0m, time elapsed: 20200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BoolLogicalOr (5800 ns)
    TCS: [33mTestCase_testVec4EqualEpsilon[0m, time elapsed: 61000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4EqualEpsilon (45300 ns)
    TCS: [33mTestCase_testVec4AddNamed[0m, time elapsed: 25100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4AddNamed (10600 ns)
    TCS: [33mTestCase_testVec4MulNamed[0m, time elapsed: 54700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4MulNamed (7200 ns)
    TCS: [33mTestCase_testVec4DivNamed[0m, time elapsed: 20900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4DivNamed (6000 ns)
    TCS: [33mTestCase_testVec4ModNamed[0m, time elapsed: 49700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ModNamed (35000 ns)
    TCS: [33mTestCase_testVec4BitwiseOr[0m, time elapsed: 24900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseOr (9900 ns)
    TCS: [33mTestCase_testVec4BitwiseXor[0m, time elapsed: 53200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseXor (9600 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseAnd[0m, time elapsed: 24300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseAnd (8900 ns)
    TCS: [33mTestCase_testVec4ShiftRight[0m, time elapsed: 32300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRight (18100 ns)
    TCS: [33mTestCase_testVec4Vec1BitBroadcast[0m, time elapsed: 27400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitBroadcast (10400 ns)
    TCS: [33mTestCase_testVec4ShiftRightVec1[0m, time elapsed: 23600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRightVec1 (8200 ns)
    TCS: [33mTestCase_testVec4FromVec1[0m, time elapsed: 21500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4FromVec1 (5800 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseOr[0m, time elapsed: 23400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseOr (9800 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseXor[0m, time elapsed: 31600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseXor (11500 ns)
    TCS: [33mTestCase_testVec4Vec1BitOrBroadcast[0m, time elapsed: 24000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitOrBroadcast (9900 ns)
    TCS: [33mTestCase_testVec4Vec1BitXorBroadcast[0m, time elapsed: 55800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitXorBroadcast (9700 ns)
    TCS: [33mTestCase_testVec4ShiftLeftVec1[0m, time elapsed: 22300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeftVec1 (8700 ns)
    TCS: [33mTestCase_testVec4ShiftLeftVec[0m, time elapsed: 60100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeftVec (7800 ns)
    TCS: [33mTestCase_testVec4ShiftRightVec[0m, time elapsed: 22000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRightVec (7600 ns)
    TCS: [33mTestCase_testVec4Increment[0m, time elapsed: 66100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Increment (12500 ns)
    TCS: [33mTestCase_testVec4Decrement[0m, time elapsed: 25000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Decrement (10700 ns)
    TCS: [33mTestCase_testVec4IndexOutOfBoundsAccess[0m, time elapsed: 78900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4IndexOutOfBoundsAccess (31900 ns)
    TCS: [33mTestCase_testVec4NegativeIndexAccess[0m, time elapsed: 27900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4NegativeIndexAccess (13200 ns)
    TCS: [33mTestCase_testFunctor1Vec1Identity[0m, time elapsed: 48600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec1Identity (33900 ns)
    TCS: [33mTestCase_testFunctor1Vec1Transform[0m, time elapsed: 20300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec1Transform (6000 ns)
    TCS: [33mTestCase_testFunctor1Vec2Transform[0m, time elapsed: 38800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec2Transform (10400 ns)
    TCS: [33mTestCase_testFunctor2Vec1Add[0m, time elapsed: 35000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec1Add (13300 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec1Mul[0m, time elapsed: 79700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec1Mul (56300 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec1Shift[0m, time elapsed: 24400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec1Shift (8700 ns)
    TCS: [33mTestCase_testFunctor1Vec3Transform[0m, time elapsed: 64400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec3Transform (7800 ns)
    TCS: [33mTestCase_testFunctor1Vec4Transform[0m, time elapsed: 30500 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec4Transform (9500 ns)
    TCS: [33mTestCase_testFunctor2Vec2Add[0m, time elapsed: 23100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec2Add (6300 ns)
    TCS: [33mTestCase_testFunctor2Vec3Add[0m, time elapsed: 22000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec3Add (6400 ns)
    TCS: [33mTestCase_testFunctor2Vec4Add[0m, time elapsed: 21100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec4Add (7200 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec2Mul[0m, time elapsed: 67400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec2Mul (8700 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec3Mul[0m, time elapsed: 19500 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec3Mul (5800 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec4Mul[0m, time elapsed: 38000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec4Mul (6700 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec2Shift[0m, time elapsed: 22000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec2Shift (7300 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec3Shift[0m, time elapsed: 30300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec3Shift (5900 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec4Shift[0m, time elapsed: 19700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec4Shift (5800 ns)
Summary: TOTAL: 435
    [32mPASSED[0m: 435, [32mSKIPPED[0m: 0, ERROR: 0
    [31mFAILED[0m: 0
--------------------------------------------------------------------------------------------------
