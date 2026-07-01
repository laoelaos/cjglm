# 验证报告（v8）

## 结果
PASSED

## 统计
- 通过：435
- 失败：0

## 测试执行日志

warning: possibly confusing line terminator
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\matrix.cj:173:51:
    | 
173 |       - m.c1.x * (m.c0.y * m.c2.z - m.c2.y * m.c0.z)
    |                                                    ~^ 
    |  __________________________________________________|
174 | |     + m.c2.x * (m.c0.y * m.c1.z - m.c1.y * m.c0.z)
    | |_____~ possibly confusing line terminator between ')' and '+'
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff parser`

warning: possibly confusing line terminator
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\matrix.cj:185:84:
    | 
185 |       - m.c0.y * (m.c1.x * SubFactor00 - m.c1.z * SubFactor03 + m.c1.w * SubFactor04)
    |                                                                                     ~^ 
    |  ___________________________________________________________________________________|
186 | |     + m.c0.z * (m.c1.x * SubFactor01 - m.c1.y * SubFactor03 + m.c1.w * SubFactor05)
    | |_____~ possibly confusing line terminator between ')' and '+'
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff parser`

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

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x4.cj:167:58:
    | 
167 |     public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat2x4<T, Q>
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x2.cj:168:58:
    | 
168 |     public static func fromMat<SrcQ>(m: Mat3x4<T, SrcQ>, one: T): Mat2x2<T, Q>
    |                                                          ^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'one'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat2x3.cj:170:58:
    | 
170 |     public static func fromMat<SrcQ>(m: Mat4x2<T, SrcQ>, one: T): Mat2x3<T, Q>
    |                                                          ^^^ unused variable
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
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_mat3x4.cj:185:58:
    | 
185 |     public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat3x4<T, Q>
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

94 warnings generated, 94 warnings printed.
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

warning: unused import 'glm.detail.cosT'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_clip_space.cj:2:46:
  | 
2 | import glm.detail.{ Mat4x4, Vec4, Qualifier, cosT, sinT, tanT, epsilon }
  |                                              ^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused import 'glm.detail.sinT'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_clip_space.cj:2:52:
  | 
2 | import glm.detail.{ Mat4x4, Vec4, Qualifier, cosT, sinT, tanT, epsilon }
  |                                                    ^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused import 'glm.detail.cosT'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_common.cj:2:80:
  | 
2 | import glm.detail.{ Quat, Vec4, Qualifier, assert, clamp, acos, epsilon, sinT, cosT, dot }
  |                                                                                ^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'q'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_exponential.cj:4:23:
  | 
4 | public func exp<T, Q>(q: Quat<T, Q>): Quat<T, Q>
  |                       ^ unused variable
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

warning: unused variable:'zero'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_transform.cj:44:9:
   | 
44 |     let zero = (Float64(0) as T).getOrThrow()
   |         ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_common.cj:45:9:
   | 
45 |     let zero = (Float64(0) as T).getOrThrow()
   |         ^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zero'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_common.cj:61:9:
   | 
61 |     let zero = (Float64(0) as T).getOrThrow()
   |         ^^^^ unused variable
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

warning: unused variable:'zNear'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_clip_space.cj:277:61:
    | 
277 | func perspectiveFovImpl<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T, depthScale: T, depthOffset: T): Mat4x4<T, Q>
    |                                                             ^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'zFar'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\matrix_clip_space.cj:277:71:
    | 
277 | func perspectiveFovImpl<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T, depthScale: T, depthOffset: T): Mat4x4<T, Q>
    |                                                                       ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

74 warnings generated, 74 warnings printed.
warning: unused import 'glm.detail.Vec2'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:2:29:
  | 
2 | import glm.detail.{ Mat4x4, Vec2, Vec3, Vec4, Qualifier, sinT, cosT, normalize }
  |                             ^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:23:31:
   | 
23 | public func eulerAngles<T, Q>(x: Quat<T, Q>): Vec3<T, Q>
   |                               ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'q'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:27:24:
   | 
27 | public func roll<T, Q>(q: Quat<T, Q>): T
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'q'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:31:25:
   | 
31 | public func pitch<T, Q>(q: Quat<T, Q>): T
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'q'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:35:23:
   | 
35 | public func yaw<T, Q>(q: Quat<T, Q>): T
   |                       ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'direction'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:39:30:
   | 
39 | public func quatLookAt<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
   |                              ^^^^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'up'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:39:53:
   | 
39 | public func quatLookAt<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
   |                                                     ^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'direction'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:43:32:
   | 
43 | public func quatLookAtRH<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
   |                                ^^^^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'up'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:43:55:
   | 
43 | public func quatLookAtRH<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
   |                                                       ^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'direction'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:47:32:
   | 
47 | public func quatLookAtLH<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
   |                                ^^^^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'up'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:47:55:
   | 
47 | public func quatLookAtLH<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
   |                                                       ^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

11 warnings generated, 11 warnings printed.
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
78--------------------------------------------------------------------------------------------------
TP: glm.detail, time elapsed: 149363500 ns, RESULT:
    TCS: TestCase_testComputeVecAdd1, time elapsed: 2474200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAdd1 (638700 ns)
    TCS: TestCase_testComputeVecSub2, time elapsed: 411600 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSub2 (51600 ns)
    TCS: TestCase_testComputeVecMul3, time elapsed: 369300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMul3 (53500 ns)
    TCS: TestCase_testComputeVecMod1, time elapsed: 373100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMod1 (39900 ns)
    TCS: TestCase_testComputeVecMod4, time elapsed: 390900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMod4 (47100 ns)
    TCS: TestCase_testComputeVecAnd1, time elapsed: 332700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAnd1 (29600 ns)
    TCS: TestCase_testComputeVecAnd3, time elapsed: 339900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAnd3 (28200 ns)
    TCS: TestCase_testComputeVecOr1, time elapsed: 343400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecOr1 (37000 ns)
    TCS: TestCase_testComputeVecOr2, time elapsed: 312700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecOr2 (22500 ns)
    TCS: TestCase_testComputeVecXor1, time elapsed: 383700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecXor1 (91200 ns)
    TCS: TestCase_testComputeVecXor4, time elapsed: 314800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecXor4 (28400 ns)
    TCS: TestCase_testComputeVecShiftLeft1, time elapsed: 383900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftLeft1 (37500 ns)
    TCS: TestCase_testComputeVecShiftLeft3, time elapsed: 344400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftLeft3 (24000 ns)
    TCS: TestCase_testComputeVecShiftRight1, time elapsed: 255600 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftRight1 (24400 ns)
    TCS: TestCase_testComputeVecShiftRight4, time elapsed: 263800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftRight4 (34400 ns)
    TCS: TestCase_testComputeVecEqual1, time elapsed: 280000 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual1 (38500 ns)
    TCS: TestCase_testComputeVecNequal4, time elapsed: 245800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecNequal4 (23600 ns)
    TCS: TestCase_testComputeVecBitwiseNot1, time elapsed: 401700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecBitwiseNot1 (59800 ns)
    TCS: TestCase_testComputeVecBitwiseNot3, time elapsed: 379600 ns, RESULT:
    [ PASSED ] CASE: testComputeVecBitwiseNot3 (71900 ns)
    TCS: TestCase_testComputeVecAdd4, time elapsed: 363400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAdd4 (34000 ns)
    TCS: TestCase_testComputeVecSub1, time elapsed: 1089200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSub1 (37600 ns)
    TCS: TestCase_testComputeVecSub3, time elapsed: 289700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSub3 (25500 ns)
    TCS: TestCase_testComputeVecMul1, time elapsed: 239000 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMul1 (21200 ns)
    TCS: TestCase_testComputeVecMul2, time elapsed: 244000 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMul2 (21400 ns)
    TCS: TestCase_testComputeVecDiv1, time elapsed: 229700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecDiv1 (25600 ns)
    TCS: TestCase_testComputeVecDiv2, time elapsed: 259300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecDiv2 (24300 ns)
    TCS: TestCase_testComputeVecDiv4, time elapsed: 409200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecDiv4 (44500 ns)
    TCS: TestCase_testComputeVecEqual2, time elapsed: 382700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual2 (40800 ns)
    TCS: TestCase_testComputeVecEqual3, time elapsed: 379900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual3 (26800 ns)
    TCS: TestCase_testComputeVecEqual4, time elapsed: 388600 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual4 (37200 ns)
    TCS: TestCase_testComputeVecNequal1, time elapsed: 381100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecNequal1 (35800 ns)
    TCS: TestCase_testComputeVecNequal2, time elapsed: 359900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecNequal2 (22800 ns)
    TCS: TestCase_testComputeVecBitwiseNot4, time elapsed: 419800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecBitwiseNot4 (38900 ns)
    TCS: TestCase_testComputeVecAddFloat32, time elapsed: 419700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAddFloat32 (54600 ns)
    TCS: TestCase_testComputeVecAddFloat32Vec3, time elapsed: 402600 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAddFloat32Vec3 (47400 ns)
    TCS: TestCase_testComputeVecSubFloat32, time elapsed: 371800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSubFloat32 (34800 ns)
    TCS: TestCase_testComputeVecSubFloat32Vec4, time elapsed: 404300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSubFloat32Vec4 (44700 ns)
    TCS: TestCase_testComputeEqualInt32Equal, time elapsed: 370300 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt32Equal (33500 ns)
    TCS: TestCase_testComputeEqualInt32NotEqual, time elapsed: 393500 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt32NotEqual (27300 ns)
    TCS: TestCase_testComputeEqualFloat32Equal, time elapsed: 203000 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32Equal (12500 ns)
    TCS: TestCase_testComputeEqualFloat32NotEqual, time elapsed: 206300 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32NotEqual (12200 ns)
    TCS: TestCase_testComputeEqualFloat64Equal, time elapsed: 181500 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64Equal (10500 ns)
    TCS: TestCase_testComputeEqualFloat64NotEqual, time elapsed: 175100 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64NotEqual (8400 ns)
    TCS: TestCase_testComputeEqualBoolEqual, time elapsed: 184900 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualBoolEqual (14200 ns)
    TCS: TestCase_testComputeEqualBoolNotEqual, time elapsed: 177300 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualBoolNotEqual (8300 ns)
    TCS: TestCase_testComputeEqualNumericInt32, time elapsed: 187300 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericInt32 (11600 ns)
    TCS: TestCase_testComputeEqualNumericFloat32, time elapsed: 203700 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32 (30300 ns)
    TCS: TestCase_testComputeEqualNumericFloat32Epsilon, time elapsed: 208200 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32Epsilon (17100 ns)
    TCS: TestCase_testComputeEqualNumericFloat64, time elapsed: 572000 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64 (32100 ns)
    TCS: TestCase_testComputeEqualInt64Equal, time elapsed: 496400 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt64Equal (27000 ns)
    TCS: TestCase_testComputeEqualInt64NotEqual, time elapsed: 403900 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt64NotEqual (21400 ns)
    TCS: TestCase_testComputeEqualFloat32Nan, time elapsed: 341800 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32Nan (24800 ns)
    TCS: TestCase_testComputeEqualFloat64Nan, time elapsed: 301600 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64Nan (14900 ns)
    TCS: TestCase_testComputeEqualFloat32SignedZero, time elapsed: 400900 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32SignedZero (32400 ns)
    TCS: TestCase_testComputeEqualFloat64SignedZero, time elapsed: 381700 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64SignedZero (17600 ns)
    TCS: TestCase_testComputeEqualNumericFloat32NotEqual, time elapsed: 237000 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32NotEqual (17200 ns)
    TCS: TestCase_testComputeEqualNumericFloat32BeyondEpsilon, time elapsed: 219200 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32BeyondEpsilon (11900 ns)
    TCS: TestCase_testComputeEqualNumericFloat64NotEqual, time elapsed: 223500 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64NotEqual (16900 ns)
    TCS: TestCase_testComputeEqualNumericFloat64Epsilon, time elapsed: 229200 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64Epsilon (21700 ns)
    TCS: TestCase_testComputeEqualNumericFloat64BeyondEpsilon, time elapsed: 223600 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64BeyondEpsilon (17000 ns)
    TCS: TestCase_testComputeEqualNumericInt64, time elapsed: 267200 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericInt64 (13900 ns)
    TCS: TestCase_testPackedHighpImplementsQualifier, time elapsed: 352700 ns, RESULT:
    [ PASSED ] CASE: testPackedHighpImplementsQualifier (32800 ns)
    TCS: TestCase_testPackedMediumpImplementsQualifier, time elapsed: 274200 ns, RESULT:
    [ PASSED ] CASE: testPackedMediumpImplementsQualifier (22000 ns)
    TCS: TestCase_testPackedLowpImplementsQualifier, time elapsed: 270100 ns, RESULT:
    [ PASSED ] CASE: testPackedLowpImplementsQualifier (14900 ns)
    TCS: TestCase_testDefaultpIsPackedHighp, time elapsed: 286800 ns, RESULT:
    [ PASSED ] CASE: testDefaultpIsPackedHighp (20300 ns)
    TCS: TestCase_testScalarAddVec1, time elapsed: 199300 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec1 (25400 ns)
    TCS: TestCase_testScalarAddVec2, time elapsed: 197300 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec2 (16300 ns)
    TCS: TestCase_testScalarAddVec3, time elapsed: 189400 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec3 (16600 ns)
    TCS: TestCase_testScalarAddVec4, time elapsed: 204700 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec4 (12200 ns)
    TCS: TestCase_testScalarSubVec1, time elapsed: 196100 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1 (14600 ns)
    TCS: TestCase_testScalarMulVec1, time elapsed: 198000 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1 (16000 ns)
    TCS: TestCase_testScalarDivVec1, time elapsed: 198600 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1 (19400 ns)
    TCS: TestCase_testScalarModVec1, time elapsed: 241300 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1 (54700 ns)
    TCS: TestCase_testScalarMulVec2, time elapsed: 217100 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2 (25600 ns)
    TCS: TestCase_testScalarSubVec2, time elapsed: 190900 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2 (10500 ns)
    TCS: TestCase_testScalarSubVec3, time elapsed: 201300 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3 (16100 ns)
    TCS: TestCase_testScalarSubVec4, time elapsed: 205600 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4 (20100 ns)
    TCS: TestCase_testScalarMulVec3, time elapsed: 199300 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3 (10100 ns)
    TCS: TestCase_testScalarMulVec4, time elapsed: 203900 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4 (19800 ns)
    TCS: TestCase_testScalarDivVec2, time elapsed: 212300 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2 (9000 ns)
    TCS: TestCase_testScalarDivVec3, time elapsed: 213200 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3 (14500 ns)
    TCS: TestCase_testScalarDivVec4, time elapsed: 195000 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4 (16600 ns)
    TCS: TestCase_testScalarModVec2, time elapsed: 208000 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2 (8500 ns)
    TCS: TestCase_testScalarModVec3, time elapsed: 282100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3 (21000 ns)
    TCS: TestCase_testScalarModVec4, time elapsed: 279300 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4 (26900 ns)
    TCS: TestCase_testScalarModVec1Float32, time elapsed: 308300 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Float32 (42400 ns)
    TCS: TestCase_testScalarModVec2Float32, time elapsed: 273500 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32 (20200 ns)
    TCS: TestCase_testScalarModVec3Float32, time elapsed: 299300 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Float32 (22500 ns)
    TCS: TestCase_testScalarModVec4Float32, time elapsed: 253100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Float32 (20800 ns)
    TCS: TestCase_testScalarModVec1Float64, time elapsed: 289300 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Float64 (34100 ns)
    TCS: TestCase_testScalarModVec2Float64, time elapsed: 264000 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float64 (15000 ns)
    TCS: TestCase_testScalarModVec3Float64, time elapsed: 285200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Float64 (16600 ns)
    TCS: TestCase_testScalarModVec4Float64, time elapsed: 305700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Float64 (18800 ns)
    TCS: TestCase_testScalarModVec1Float16, time elapsed: 366500 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Float16 (50300 ns)
    TCS: TestCase_testScalarModVec2Float16, time elapsed: 346000 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float16 (19700 ns)
    TCS: TestCase_testScalarModVec3Float16, time elapsed: 327500 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Float16 (34200 ns)
    TCS: TestCase_testScalarModVec4Float16, time elapsed: 286500 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Float16 (16700 ns)
    TCS: TestCase_testScalarSubVec2PackedMediump, time elapsed: 304700 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2PackedMediump (32500 ns)
    TCS: TestCase_testScalarSubVec2PackedLowp, time elapsed: 328400 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2PackedLowp (22300 ns)
    TCS: TestCase_testScalarMulVec2PackedMediump, time elapsed: 288200 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2PackedMediump (16800 ns)
    TCS: TestCase_testScalarMulVec2PackedLowp, time elapsed: 290400 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2PackedLowp (16700 ns)
    TCS: TestCase_testScalarDivVec2PackedMediump, time elapsed: 290600 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2PackedMediump (15000 ns)
    TCS: TestCase_testScalarDivVec2PackedLowp, time elapsed: 284100 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2PackedLowp (17900 ns)
    TCS: TestCase_testScalarModVec2PackedMediump, time elapsed: 263200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2PackedMediump (14300 ns)
    TCS: TestCase_testScalarModVec2PackedLowp, time elapsed: 274400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2PackedLowp (17300 ns)
    TCS: TestCase_testScalarModVec2Float32PackedMediump, time elapsed: 273200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32PackedMediump (26000 ns)
    TCS: TestCase_testScalarModVec2Float32PackedLowp, time elapsed: 268700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32PackedLowp (18600 ns)
    TCS: TestCase_testScalarModVec2Float32NegativeDividend, time elapsed: 317400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32NegativeDividend (24900 ns)
    TCS: TestCase_testScalarModVec2Float32NegativeDivisor, time elapsed: 392800 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32NegativeDivisor (24200 ns)
    TCS: TestCase_testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents, time elapsed: 479300 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents (197800 ns)
    TCS: TestCase_testScalarAddVec1Float32, time elapsed: 197800 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec1Float32 (13300 ns)
    TCS: TestCase_testScalarAddVec2Float32, time elapsed: 184900 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec2Float32 (8700 ns)
    TCS: TestCase_testScalarAddVec3Float32, time elapsed: 181500 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec3Float32 (10000 ns)
    TCS: TestCase_testScalarAddVec4Float32, time elapsed: 186300 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec4Float32 (10100 ns)
    TCS: TestCase_testScalarSubVec1Float32, time elapsed: 187400 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1Float32 (12600 ns)
    TCS: TestCase_testScalarSubVec2Float32, time elapsed: 177800 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2Float32 (9500 ns)
    TCS: TestCase_testScalarSubVec3Float32, time elapsed: 180300 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3Float32 (8200 ns)
    TCS: TestCase_testScalarSubVec4Float32, time elapsed: 183000 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4Float32 (8300 ns)
    TCS: TestCase_testScalarMulVec1Float32, time elapsed: 183600 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1Float32 (9400 ns)
    TCS: TestCase_testScalarMulVec2Float32, time elapsed: 176100 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2Float32 (9100 ns)
    TCS: TestCase_testScalarMulVec3Float32, time elapsed: 182600 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3Float32 (9000 ns)
    TCS: TestCase_testScalarMulVec4Float32, time elapsed: 243000 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4Float32 (16300 ns)
    TCS: TestCase_testScalarDivVec1Float32, time elapsed: 195400 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1Float32 (10800 ns)
    TCS: TestCase_testScalarDivVec2Float32, time elapsed: 191200 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2Float32 (11000 ns)
    TCS: TestCase_testScalarDivVec3Float32, time elapsed: 202000 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3Float32 (11000 ns)
    TCS: TestCase_testScalarDivVec4Float32, time elapsed: 191100 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4Float32 (11000 ns)
    TCS: TestCase_testScalarAddVec1Int32, time elapsed: 204900 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec1Int32 (21800 ns)
    TCS: TestCase_testScalarAddVec2Int32, time elapsed: 196700 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec2Int32 (15100 ns)
    TCS: TestCase_testScalarAddVec3Int32, time elapsed: 216200 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec3Int32 (13500 ns)
    TCS: TestCase_testScalarAddVec4Int32, time elapsed: 210400 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec4Int32 (12700 ns)
    TCS: TestCase_testScalarSubVec1Int32, time elapsed: 259000 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1Int32 (18100 ns)
    TCS: TestCase_testScalarSubVec2Int32, time elapsed: 296300 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2Int32 (14400 ns)
    TCS: TestCase_testScalarSubVec3Int32, time elapsed: 262000 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3Int32 (22000 ns)
    TCS: TestCase_testScalarSubVec4Int32, time elapsed: 268300 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4Int32 (16000 ns)
    TCS: TestCase_testScalarMulVec1Int32, time elapsed: 264300 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1Int32 (17300 ns)
    TCS: TestCase_testScalarMulVec2Int32, time elapsed: 333700 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2Int32 (15100 ns)
    TCS: TestCase_testScalarMulVec3Int32, time elapsed: 318800 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3Int32 (16300 ns)
    TCS: TestCase_testScalarMulVec4Int32, time elapsed: 293300 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4Int32 (17100 ns)
    TCS: TestCase_testScalarDivVec1Int32, time elapsed: 324400 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1Int32 (21700 ns)
    TCS: TestCase_testScalarDivVec2Int32, time elapsed: 200900 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2Int32 (17700 ns)
    TCS: TestCase_testScalarDivVec3Int32, time elapsed: 202600 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3Int32 (9900 ns)
    TCS: TestCase_testScalarDivVec4Int32, time elapsed: 203400 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4Int32 (9600 ns)
    TCS: TestCase_testScalarModVec1Int32, time elapsed: 285300 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Int32 (14300 ns)
    TCS: TestCase_testScalarModVec2Int32, time elapsed: 292600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Int32 (19900 ns)
    TCS: TestCase_testScalarModVec3Int32, time elapsed: 299300 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Int32 (16600 ns)
    TCS: TestCase_testScalarModVec4Int32, time elapsed: 336900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Int32 (19600 ns)
    TCS: TestCase_testScalarSubVec1PackedMediump, time elapsed: 275800 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1PackedMediump (22400 ns)
    TCS: TestCase_testScalarSubVec1PackedLowp, time elapsed: 235000 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1PackedLowp (12500 ns)
    TCS: TestCase_testScalarSubVec3PackedMediump, time elapsed: 484100 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3PackedMediump (28600 ns)
    TCS: TestCase_testScalarSubVec3PackedLowp, time elapsed: 368000 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3PackedLowp (31900 ns)
    TCS: TestCase_testScalarSubVec4PackedMediump, time elapsed: 220600 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4PackedMediump (13000 ns)
    TCS: TestCase_testScalarSubVec4PackedLowp, time elapsed: 363700 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4PackedLowp (14100 ns)
    TCS: TestCase_testScalarMulVec1PackedMediump, time elapsed: 325500 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1PackedMediump (16400 ns)
    TCS: TestCase_testScalarMulVec1PackedLowp, time elapsed: 313600 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1PackedLowp (14300 ns)
    TCS: TestCase_testScalarMulVec3PackedMediump, time elapsed: 261900 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3PackedMediump (19700 ns)
    TCS: TestCase_testScalarMulVec3PackedLowp, time elapsed: 194100 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3PackedLowp (10100 ns)
    TCS: TestCase_testScalarMulVec4PackedMediump, time elapsed: 179300 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4PackedMediump (9600 ns)
    TCS: TestCase_testScalarMulVec4PackedLowp, time elapsed: 183400 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4PackedLowp (10300 ns)
    TCS: TestCase_testScalarDivVec1PackedMediump, time elapsed: 183600 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1PackedMediump (9400 ns)
    TCS: TestCase_testScalarDivVec1PackedLowp, time elapsed: 208500 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1PackedLowp (8200 ns)
    TCS: TestCase_testScalarDivVec3PackedMediump, time elapsed: 193200 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3PackedMediump (10500 ns)
    TCS: TestCase_testScalarDivVec3PackedLowp, time elapsed: 193400 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3PackedLowp (10300 ns)
    TCS: TestCase_testScalarDivVec4PackedMediump, time elapsed: 210900 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4PackedMediump (18000 ns)
    TCS: TestCase_testScalarDivVec4PackedLowp, time elapsed: 197900 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4PackedLowp (10000 ns)
    TCS: TestCase_testScalarModVec1PackedMediump, time elapsed: 200900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1PackedMediump (11000 ns)
    TCS: TestCase_testScalarModVec1PackedLowp, time elapsed: 192500 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1PackedLowp (11800 ns)
    TCS: TestCase_testScalarModVec3PackedMediump, time elapsed: 229000 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3PackedMediump (12000 ns)
    TCS: TestCase_testScalarModVec3PackedLowp, time elapsed: 219100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3PackedLowp (11500 ns)
    TCS: TestCase_testScalarModVec4PackedMediump, time elapsed: 279400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4PackedMediump (16700 ns)
    TCS: TestCase_testScalarModVec4PackedLowp, time elapsed: 253100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4PackedLowp (16500 ns)
    TCS: TestCase_testScalarDivZeroVec1, time elapsed: 273700 ns, RESULT:
    [ PASSED ] CASE: testScalarDivZeroVec1 (29700 ns)
    TCS: TestCase_testScalarAddNegVec1, time elapsed: 247500 ns, RESULT:
    [ PASSED ] CASE: testScalarAddNegVec1 (9900 ns)
    TCS: TestCase_testScalarAddNegVec2, time elapsed: 230400 ns, RESULT:
    [ PASSED ] CASE: testScalarAddNegVec2 (12400 ns)
    TCS: TestCase_testScalarMulOverflowVec1, time elapsed: 205300 ns, RESULT:
    [ PASSED ] CASE: testScalarMulOverflowVec1 (9400 ns)
    TCS: TestCase_testScalarSubNegVec1, time elapsed: 231700 ns, RESULT:
    [ PASSED ] CASE: testScalarSubNegVec1 (10200 ns)
    TCS: TestCase_testVersionMajor, time elapsed: 206600 ns, RESULT:
    [ PASSED ] CASE: testVersionMajor (8500 ns)
    TCS: TestCase_testVersionMinor, time elapsed: 222000 ns, RESULT:
    [ PASSED ] CASE: testVersionMinor (12500 ns)
    TCS: TestCase_testVersionPatch, time elapsed: 194100 ns, RESULT:
    [ PASSED ] CASE: testVersionPatch (8400 ns)
    TCS: TestCase_testVersionEncoded, time elapsed: 186800 ns, RESULT:
    [ PASSED ] CASE: testVersionEncoded (11200 ns)
    TCS: TestCase_testConfigSimd, time elapsed: 199200 ns, RESULT:
    [ PASSED ] CASE: testConfigSimd (12700 ns)
    TCS: TestCase_testConfigAlignedGentypes, time elapsed: 195800 ns, RESULT:
    [ PASSED ] CASE: testConfigAlignedGentypes (7400 ns)
    TCS: TestCase_testConfigClipControl, time elapsed: 211200 ns, RESULT:
    [ PASSED ] CASE: testConfigClipControl (11300 ns)
    TCS: TestCase_testConstNegationSimd, time elapsed: 252600 ns, RESULT:
    [ PASSED ] CASE: testConstNegationSimd (10100 ns)
    TCS: TestCase_testConstNegationAligned, time elapsed: 233800 ns, RESULT:
    [ PASSED ] CASE: testConstNegationAligned (13100 ns)
    TCS: TestCase_testConstNegationClip, time elapsed: 187400 ns, RESULT:
    [ PASSED ] CASE: testConstNegationClip (7900 ns)
    TCS: TestCase_testConstInt64Usage, time elapsed: 202200 ns, RESULT:
    [ PASSED ] CASE: testConstInt64Usage (7600 ns)
    TCS: TestCase_testConstBoolUsage, time elapsed: 209500 ns, RESULT:
    [ PASSED ] CASE: testConstBoolUsage (9800 ns)
    TCS: TestCase_testVersionEncodingConsistency, time elapsed: 206600 ns, RESULT:
    [ PASSED ] CASE: testVersionEncodingConsistency (12300 ns)
    TCS: TestCase_testAssertPasses, time elapsed: 242600 ns, RESULT:
    [ PASSED ] CASE: testAssertPasses (28600 ns)
    TCS: TestCase_testAssertFails, time elapsed: 283500 ns, RESULT:
    [ PASSED ] CASE: testAssertFails (70900 ns)
    TCS: TestCase_testAssertWithCustomMessage, time elapsed: 273500 ns, RESULT:
    [ PASSED ] CASE: testAssertWithCustomMessage (61700 ns)
    TCS: TestCase_testNumericLimitsFloat32Epsilon, time elapsed: 211600 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsFloat32Epsilon (19000 ns)
    TCS: TestCase_testNumericLimitsFloat64Epsilon, time elapsed: 200800 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsFloat64Epsilon (17800 ns)
    TCS: TestCase_testIsIec559OfFloat32, time elapsed: 243900 ns, RESULT:
    [ PASSED ] CASE: testIsIec559OfFloat32 (10400 ns)
    TCS: TestCase_testIsIec559OfFloat64, time elapsed: 279200 ns, RESULT:
    [ PASSED ] CASE: testIsIec559OfFloat64 (13700 ns)
    TCS: TestCase_testIsIec559OfInt64, time elapsed: 400300 ns, RESULT:
    [ PASSED ] CASE: testIsIec559OfInt64 (30100 ns)
    TCS: TestCase_testEpsilonOfFloat32, time elapsed: 254400 ns, RESULT:
    [ PASSED ] CASE: testEpsilonOfFloat32 (18400 ns)
    TCS: TestCase_testEpsilonOfFloat64, time elapsed: 259500 ns, RESULT:
    [ PASSED ] CASE: testEpsilonOfFloat64 (16200 ns)
    TCS: TestCase_testNumericLimitsInt64Epsilon, time elapsed: 262200 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt64Epsilon (22000 ns)
    TCS: TestCase_testNumericLimitsInt32Epsilon, time elapsed: 255900 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt32Epsilon (23400 ns)
    TCS: TestCase_testNumericLimitsInt16Epsilon, time elapsed: 262000 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt16Epsilon (26700 ns)
    TCS: TestCase_testNumericLimitsInt8Epsilon, time elapsed: 261300 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt8Epsilon (18800 ns)
    TCS: TestCase_testCastVec1ToVec1IntToFloat, time elapsed: 276300 ns, RESULT:
    [ PASSED ] CASE: testCastVec1ToVec1IntToFloat (33500 ns)
    TCS: TestCase_testCastVec2ToVec1TakesOnlyX, time elapsed: 278400 ns, RESULT:
    [ PASSED ] CASE: testCastVec2ToVec1TakesOnlyX (20300 ns)
    TCS: TestCase_testCastVec3ToVec1TakesOnlyX, time elapsed: 272300 ns, RESULT:
    [ PASSED ] CASE: testCastVec3ToVec1TakesOnlyX (18800 ns)
    TCS: TestCase_testCastVec4ToVec1TakesOnlyX, time elapsed: 260100 ns, RESULT:
    [ PASSED ] CASE: testCastVec4ToVec1TakesOnlyX (17200 ns)
    TCS: TestCase_testCastSameTypeIdentity, time elapsed: 561300 ns, RESULT:
    [ PASSED ] CASE: testCastSameTypeIdentity (56900 ns)
    TCS: TestCase_testCastInt32ToInt64, time elapsed: 390600 ns, RESULT:
    [ PASSED ] CASE: testCastInt32ToInt64 (48700 ns)
    TCS: TestCase_testCastFloatToIntTruncation, time elapsed: 292200 ns, RESULT:
    [ PASSED ] CASE: testCastFloatToIntTruncation (30900 ns)
    TCS: TestCase_testCastCrossQualifierPackedHighpToDefaultp, time elapsed: 262600 ns, RESULT:
    [ PASSED ] CASE: testCastCrossQualifierPackedHighpToDefaultp (24700 ns)
    TCS: TestCase_testCastCrossQualifierDefaultpToPackedHighp, time elapsed: 304500 ns, RESULT:
    [ PASSED ] CASE: testCastCrossQualifierDefaultpToPackedHighp (24400 ns)
    TCS: TestCase_testCastVec2CrossQualifierCrossType, time elapsed: 306100 ns, RESULT:
    [ PASSED ] CASE: testCastVec2CrossQualifierCrossType (39500 ns)
    TCS: TestCase_testCastVec3CrossQualifier, time elapsed: 329600 ns, RESULT:
    [ PASSED ] CASE: testCastVec3CrossQualifier (42500 ns)
    TCS: TestCase_testCastVec4CrossQualifier, time elapsed: 356300 ns, RESULT:
    [ PASSED ] CASE: testCastVec4CrossQualifier (49400 ns)
    TCS: TestCase_testCastVec1DoesNotModifySource, time elapsed: 289100 ns, RESULT:
    [ PASSED ] CASE: testCastVec1DoesNotModifySource (34100 ns)
    TCS: TestCase_testCastVec2Vec1ToVec2IntToFloat, time elapsed: 373400 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec1ToVec2IntToFloat (15600 ns)
    TCS: TestCase_testCastVec2Vec2ToVec2Identity, time elapsed: 215900 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec2ToVec2Identity (15700 ns)
    TCS: TestCase_testCastVec2Vec3ToVec2TakesOnlyXY, time elapsed: 212400 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec3ToVec2TakesOnlyXY (9800 ns)
    TCS: TestCase_testCastVec2Vec4ToVec2TakesOnlyXY, time elapsed: 206200 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec4ToVec2TakesOnlyXY (22800 ns)
    TCS: TestCase_testCastVec2SameTypeIdentity, time elapsed: 218900 ns, RESULT:
    [ PASSED ] CASE: testCastVec2SameTypeIdentity (8600 ns)
    TCS: TestCase_testCastVec2Int32ToInt64, time elapsed: 209600 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Int32ToInt64 (9700 ns)
    TCS: TestCase_testCastVec2FloatToIntTruncation, time elapsed: 196500 ns, RESULT:
    [ PASSED ] CASE: testCastVec2FloatToIntTruncation (8800 ns)
    TCS: TestCase_testCastVec2CrossQualifierPackedHighpToDefaultp, time elapsed: 182100 ns, RESULT:
    [ PASSED ] CASE: testCastVec2CrossQualifierPackedHighpToDefaultp (6900 ns)
    TCS: TestCase_testCastVec2DoesNotModifySource, time elapsed: 177000 ns, RESULT:
    [ PASSED ] CASE: testCastVec2DoesNotModifySource (13100 ns)
    TCS: TestCase_testCastVec2Vec1ToVec2SameValueBothComponents, time elapsed: 172600 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec1ToVec2SameValueBothComponents (7100 ns)
    TCS: TestCase_testCastVec3Vec1ToVec3IntToFloat, time elapsed: 180100 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec1ToVec3IntToFloat (7400 ns)
    TCS: TestCase_testCastVec3Vec2ToVec3ExtendY, time elapsed: 187500 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec2ToVec3ExtendY (13900 ns)
    TCS: TestCase_testCastVec3Vec3ToVec3Identity, time elapsed: 223700 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec3ToVec3Identity (6800 ns)
    TCS: TestCase_testCastVec3Vec4ToVec3TakesOnlyXYZ, time elapsed: 204200 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec4ToVec3TakesOnlyXYZ (15800 ns)
    TCS: TestCase_testCastVec3SameTypeIdentity, time elapsed: 179900 ns, RESULT:
    [ PASSED ] CASE: testCastVec3SameTypeIdentity (6900 ns)
    TCS: TestCase_testCastVec3Int32ToInt64, time elapsed: 229800 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Int32ToInt64 (12000 ns)
    TCS: TestCase_testCastVec3FloatToIntTruncation, time elapsed: 208700 ns, RESULT:
    [ PASSED ] CASE: testCastVec3FloatToIntTruncation (8800 ns)
    TCS: TestCase_testCastVec3CrossQualifierPackedHighpToDefaultp, time elapsed: 197000 ns, RESULT:
    [ PASSED ] CASE: testCastVec3CrossQualifierPackedHighpToDefaultp (6500 ns)
    TCS: TestCase_testCastVec3DoesNotModifySource, time elapsed: 192900 ns, RESULT:
    [ PASSED ] CASE: testCastVec3DoesNotModifySource (6100 ns)
    TCS: TestCase_testCastVec3Vec1ToVec3SameValueAllComponents, time elapsed: 187700 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec1ToVec3SameValueAllComponents (9800 ns)
    TCS: TestCase_testCastVec4Vec1ToVec4IntToFloat, time elapsed: 203800 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec1ToVec4IntToFloat (21300 ns)
    TCS: TestCase_testCastVec4Vec2ToVec4ExtendY, time elapsed: 170200 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec2ToVec4ExtendY (7200 ns)
    TCS: TestCase_testCastVec4Vec3ToVec4ExtendZ, time elapsed: 175900 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec3ToVec4ExtendZ (10800 ns)
    TCS: TestCase_testCastVec4Vec4ToVec4Identity, time elapsed: 181900 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec4ToVec4Identity (12300 ns)
    TCS: TestCase_testCastVec4SameTypeIdentity, time elapsed: 181600 ns, RESULT:
    [ PASSED ] CASE: testCastVec4SameTypeIdentity (6300 ns)
    TCS: TestCase_testCastVec4Int32ToInt64, time elapsed: 276300 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Int32ToInt64 (11700 ns)
    TCS: TestCase_testCastVec4FloatToIntTruncation, time elapsed: 170100 ns, RESULT:
    [ PASSED ] CASE: testCastVec4FloatToIntTruncation (7000 ns)
    TCS: TestCase_testCastVec4CrossQualifierPackedHighpToDefaultp, time elapsed: 165200 ns, RESULT:
    [ PASSED ] CASE: testCastVec4CrossQualifierPackedHighpToDefaultp (6200 ns)
    TCS: TestCase_testCastVec4DoesNotModifySource, time elapsed: 165700 ns, RESULT:
    [ PASSED ] CASE: testCastVec4DoesNotModifySource (5900 ns)
    TCS: TestCase_testCastVec4Vec1ToVec4SameValueAllComponents, time elapsed: 170100 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec1ToVec4SameValueAllComponents (6800 ns)
    TCS: TestCase_testFromBoolVec1, time elapsed: 213000 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec1 (19700 ns)
    TCS: TestCase_testFromBoolVec1False, time elapsed: 180200 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec1False (6600 ns)
    TCS: TestCase_testFromBoolVec2, time elapsed: 174900 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec2 (13800 ns)
    TCS: TestCase_testFromBoolVec3, time elapsed: 196400 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec3 (11700 ns)
    TCS: TestCase_testFromBoolVec4, time elapsed: 188800 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec4 (12200 ns)
    TCS: TestCase_testFromBoolVecQ2Vec1, time elapsed: 174300 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec1 (18800 ns)
    TCS: TestCase_testFromBoolVecQ2Vec2, time elapsed: 179700 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec2 (13100 ns)
    TCS: TestCase_testFromBoolVecQ2Vec3, time elapsed: 162200 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec3 (5900 ns)
    TCS: TestCase_testFromBoolVecQ2Vec4, time elapsed: 187800 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec4 (14000 ns)
    TCS: TestCase_testFromBoolVec3AllFalse, time elapsed: 174600 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec3AllFalse (6000 ns)
    TCS: TestCase_testFromBoolVec4AllFalse, time elapsed: 171800 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec4AllFalse (18900 ns)
    TCS: TestCase_testFromBoolVecQ2Vec3AllFalse, time elapsed: 173500 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec3AllFalse (6300 ns)
    TCS: TestCase_testFromBoolVecQ2Vec4AllFalse, time elapsed: 181400 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec4AllFalse (5300 ns)
    TCS: TestCase_testFromBoolVecFloat32, time elapsed: 169800 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecFloat32 (9200 ns)
    TCS: TestCase_testFromBoolVecFloat64, time elapsed: 176500 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecFloat64 (10900 ns)
    TCS: TestCase_testFromBoolVecInt32, time elapsed: 183900 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecInt32 (10300 ns)
    TCS: TestCase_testFromBoolVecQ2PackedMediump, time elapsed: 172800 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2PackedMediump (19600 ns)
    TCS: TestCase_testFromBoolVecQ2PackedLowp, time elapsed: 177900 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2PackedLowp (11000 ns)
    TCS: TestCase_testS1QuatCastScalingXBranch, time elapsed: 287200 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastScalingXBranch (121300 ns)
    TCS: TestCase_testS1QuatCastScalingYBranch, time elapsed: 198600 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastScalingYBranch (23300 ns)
    TCS: TestCase_testS1QuatCastScalingZBranch, time elapsed: 198000 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastScalingZBranch (36100 ns)
    TCS: TestCase_testS1QuatCastScalingWBranch, time elapsed: 198400 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastScalingWBranch (18900 ns)
    TCS: TestCase_testS1QuatCastUnitRoundTrip, time elapsed: 229500 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastUnitRoundTrip (12700 ns)
    TCS: TestCase_testS1QuatCastIdentityRoundTrip, time elapsed: 173800 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastIdentityRoundTrip (10100 ns)
    TCS: TestCase_testS1QuatCastMat4Delegation, time elapsed: 252400 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastMat4Delegation (46600 ns)
    TCS: TestCase_testMat3EqualEpsilonRelaxedExactMatch, time elapsed: 171400 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedExactMatch (6100 ns)
    TCS: TestCase_testMat3EqualEpsilonRelaxedWithinPosTolerance, time elapsed: 172500 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedWithinPosTolerance (6100 ns)
    TCS: TestCase_testMat3EqualEpsilonRelaxedWithinNegTolerance, time elapsed: 171400 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedWithinNegTolerance (6600 ns)
    TCS: TestCase_testMat3EqualEpsilonRelaxedBeyondTolerance, time elapsed: 171500 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedBeyondTolerance (5700 ns)
    TCS: TestCase_testMat3EqualEpsilonRelaxedZeroMatrix, time elapsed: 167400 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedZeroMatrix (12500 ns)
    TCS: TestCase_testMat3EqualEpsilonRelaxedSingleDiffBeyond, time elapsed: 165800 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedSingleDiffBeyond (6200 ns)
    TCS: TestCase_testVec2ScalarInit, time elapsed: 173000 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarInit (13600 ns)
    TCS: TestCase_testVec2ConstInit, time elapsed: 182800 ns, RESULT:
    [ PASSED ] CASE: testVec2ConstInit (7600 ns)
    TCS: TestCase_testVec2Length, time elapsed: 171700 ns, RESULT:
    [ PASSED ] CASE: testVec2Length (4900 ns)
    TCS: TestCase_testVec2Add, time elapsed: 179700 ns, RESULT:
    [ PASSED ] CASE: testVec2Add (14600 ns)
    TCS: TestCase_testVec2Sub, time elapsed: 177400 ns, RESULT:
    [ PASSED ] CASE: testVec2Sub (10800 ns)
    TCS: TestCase_testVec2Mul, time elapsed: 169500 ns, RESULT:
    [ PASSED ] CASE: testVec2Mul (9800 ns)
    TCS: TestCase_testVec2ScalarAdd, time elapsed: 183600 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarAdd (12300 ns)
    TCS: TestCase_testVec2Negate, time elapsed: 175500 ns, RESULT:
    [ PASSED ] CASE: testVec2Negate (10700 ns)
    TCS: TestCase_testVec2IndexAccess, time elapsed: 181200 ns, RESULT:
    [ PASSED ] CASE: testVec2IndexAccess (10000 ns)
    TCS: TestCase_testVec2IndexMutate, time elapsed: 171900 ns, RESULT:
    [ PASSED ] CASE: testVec2IndexMutate (8600 ns)
    TCS: TestCase_testVec2ComponentAt, time elapsed: 171700 ns, RESULT:
    [ PASSED ] CASE: testVec2ComponentAt (5500 ns)
    TCS: TestCase_testVec2Equal, time elapsed: 176200 ns, RESULT:
    [ PASSED ] CASE: testVec2Equal (10200 ns)
    TCS: TestCase_testVec2NotEqual, time elapsed: 184000 ns, RESULT:
    [ PASSED ] CASE: testVec2NotEqual (8300 ns)
    TCS: TestCase_testVec2EqualExact, time elapsed: 208100 ns, RESULT:
    [ PASSED ] CASE: testVec2EqualExact (11500 ns)
    TCS: TestCase_testVec2BitwiseAnd, time elapsed: 179900 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseAnd (14100 ns)
    TCS: TestCase_testVec2BitwiseNot, time elapsed: 208800 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseNot (23400 ns)
    TCS: TestCase_testVec2FromVec1, time elapsed: 189000 ns, RESULT:
    [ PASSED ] CASE: testVec2FromVec1 (6900 ns)
    TCS: TestCase_testVec2ShiftLeft, time elapsed: 195300 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftLeft (10300 ns)
    TCS: TestCase_testVec2BoolLogicalAnd, time elapsed: 193200 ns, RESULT:
    [ PASSED ] CASE: testVec2BoolLogicalAnd (12100 ns)
    TCS: TestCase_testVec2Vec1ArithBroadcast, time elapsed: 186900 ns, RESULT:
    [ PASSED ] CASE: testVec2Vec1ArithBroadcast (10300 ns)
    TCS: TestCase_testVec2Vec1BitBroadcast, time elapsed: 176900 ns, RESULT:
    [ PASSED ] CASE: testVec2Vec1BitBroadcast (11700 ns)
    TCS: TestCase_testVec2ShiftLeftVec1, time elapsed: 172600 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftLeftVec1 (9000 ns)
    TCS: TestCase_testVec2Div, time elapsed: 174800 ns, RESULT:
    [ PASSED ] CASE: testVec2Div (8200 ns)
    TCS: TestCase_testVec2Mod, time elapsed: 219700 ns, RESULT:
    [ PASSED ] CASE: testVec2Mod (9400 ns)
    TCS: TestCase_testVec2ScalarSub, time elapsed: 297300 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarSub (19700 ns)
    TCS: TestCase_testVec2ScalarMul, time elapsed: 189400 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarMul (16100 ns)
    TCS: TestCase_testVec2ScalarDiv, time elapsed: 234600 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarDiv (16400 ns)
    TCS: TestCase_testVec2ScalarMod, time elapsed: 426000 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarMod (13600 ns)
    TCS: TestCase_testVec2BoolLogicalOr, time elapsed: 193700 ns, RESULT:
    [ PASSED ] CASE: testVec2BoolLogicalOr (11400 ns)
    TCS: TestCase_testVec2EqualEpsilon, time elapsed: 202700 ns, RESULT:
    [ PASSED ] CASE: testVec2EqualEpsilon (20700 ns)
    TCS: TestCase_testVec2DivNamed, time elapsed: 185400 ns, RESULT:
    [ PASSED ] CASE: testVec2DivNamed (7500 ns)
    TCS: TestCase_testVec2ModNamed, time elapsed: 188200 ns, RESULT:
    [ PASSED ] CASE: testVec2ModNamed (23300 ns)
    TCS: TestCase_testVec2BitwiseOr, time elapsed: 209400 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseOr (20500 ns)
    TCS: TestCase_testVec2BitwiseXor, time elapsed: 213600 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseXor (13400 ns)
    TCS: TestCase_testVec2ScalarBitwiseAnd, time elapsed: 183400 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarBitwiseAnd (5800 ns)
    TCS: TestCase_testVec2ShiftRight, time elapsed: 169800 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftRight (5800 ns)
    TCS: TestCase_testVec2ShiftRightVec1, time elapsed: 172400 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftRightVec1 (9500 ns)
    TCS: TestCase_testVec2AddNamed, time elapsed: 168400 ns, RESULT:
    [ PASSED ] CASE: testVec2AddNamed (9900 ns)
    TCS: TestCase_testVec2SubNamed, time elapsed: 165800 ns, RESULT:
    [ PASSED ] CASE: testVec2SubNamed (5800 ns)
    TCS: TestCase_testVec2MulNamed, time elapsed: 165200 ns, RESULT:
    [ PASSED ] CASE: testVec2MulNamed (5800 ns)
    TCS: TestCase_testVec2ShiftLeftVec, time elapsed: 167400 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftLeftVec (5800 ns)
    TCS: TestCase_testVec2ShiftRightVec, time elapsed: 181200 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftRightVec (6500 ns)
    TCS: TestCase_testVec2ScalarBitwiseOr, time elapsed: 185100 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarBitwiseOr (19300 ns)
    TCS: TestCase_testVec2ScalarBitwiseXor, time elapsed: 177400 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarBitwiseXor (11000 ns)
    TCS: TestCase_testVec2Increment, time elapsed: 178100 ns, RESULT:
    [ PASSED ] CASE: testVec2Increment (11400 ns)
    TCS: TestCase_testVec2Decrement, time elapsed: 166200 ns, RESULT:
    [ PASSED ] CASE: testVec2Decrement (8500 ns)
    TCS: TestCase_testVec2IndexOutOfBoundsAccess, time elapsed: 236800 ns, RESULT:
    [ PASSED ] CASE: testVec2IndexOutOfBoundsAccess (60800 ns)
    TCS: TestCase_testVec2NegativeIndexAccess, time elapsed: 198500 ns, RESULT:
    [ PASSED ] CASE: testVec2NegativeIndexAccess (29200 ns)
    TCS: TestCase_testVec3ScalarInit, time elapsed: 187300 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarInit (14300 ns)
    TCS: TestCase_testVec3ConstInit, time elapsed: 191900 ns, RESULT:
    [ PASSED ] CASE: testVec3ConstInit (12100 ns)
    TCS: TestCase_testVec3Length, time elapsed: 166100 ns, RESULT:
    [ PASSED ] CASE: testVec3Length (5900 ns)
    TCS: TestCase_testVec3Add, time elapsed: 194600 ns, RESULT:
    [ PASSED ] CASE: testVec3Add (15700 ns)
    TCS: TestCase_testVec3ScalarMul, time elapsed: 191200 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarMul (14300 ns)
    TCS: TestCase_testVec3Negate, time elapsed: 176100 ns, RESULT:
    [ PASSED ] CASE: testVec3Negate (13800 ns)
    TCS: TestCase_testVec3IndexAccess, time elapsed: 170100 ns, RESULT:
    [ PASSED ] CASE: testVec3IndexAccess (6800 ns)
    TCS: TestCase_testVec3IndexMutate, time elapsed: 179700 ns, RESULT:
    [ PASSED ] CASE: testVec3IndexMutate (11200 ns)
    TCS: TestCase_testVec3ComponentAt, time elapsed: 182800 ns, RESULT:
    [ PASSED ] CASE: testVec3ComponentAt (6300 ns)
    TCS: TestCase_testVec3Equal, time elapsed: 192200 ns, RESULT:
    [ PASSED ] CASE: testVec3Equal (16300 ns)
    TCS: TestCase_testVec3NotEqual, time elapsed: 187800 ns, RESULT:
    [ PASSED ] CASE: testVec3NotEqual (12400 ns)
    TCS: TestCase_testVec3EqualExact, time elapsed: 186600 ns, RESULT:
    [ PASSED ] CASE: testVec3EqualExact (13700 ns)
    TCS: TestCase_testVec3BitwiseAnd, time elapsed: 181300 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseAnd (13600 ns)
    TCS: TestCase_testVec3BitwiseNot, time elapsed: 176500 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseNot (11400 ns)
    TCS: TestCase_testVec3Vec1ArithBroadcast, time elapsed: 186000 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1ArithBroadcast (15500 ns)
    TCS: TestCase_testVec3ShiftLeft, time elapsed: 220200 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftLeft (15800 ns)
    TCS: TestCase_testVec3BoolLogicalAnd, time elapsed: 236100 ns, RESULT:
    [ PASSED ] CASE: testVec3BoolLogicalAnd (24700 ns)
    TCS: TestCase_testVec3Sub, time elapsed: 186100 ns, RESULT:
    [ PASSED ] CASE: testVec3Sub (11500 ns)
    TCS: TestCase_testVec3Div, time elapsed: 196300 ns, RESULT:
    [ PASSED ] CASE: testVec3Div (13700 ns)
    TCS: TestCase_testVec3Mod, time elapsed: 206400 ns, RESULT:
    [ PASSED ] CASE: testVec3Mod (13200 ns)
    TCS: TestCase_testVec3ScalarSub, time elapsed: 187700 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarSub (12700 ns)
    TCS: TestCase_testVec3ScalarDiv, time elapsed: 182000 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarDiv (12900 ns)
    TCS: TestCase_testVec3ScalarMod, time elapsed: 183500 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarMod (13100 ns)
    TCS: TestCase_testVec3BoolLogicalOr, time elapsed: 185900 ns, RESULT:
    [ PASSED ] CASE: testVec3BoolLogicalOr (6300 ns)
    TCS: TestCase_testVec3EqualEpsilon, time elapsed: 232800 ns, RESULT:
    [ PASSED ] CASE: testVec3EqualEpsilon (21100 ns)
    TCS: TestCase_testVec3AddNamed, time elapsed: 218600 ns, RESULT:
    [ PASSED ] CASE: testVec3AddNamed (14200 ns)
    TCS: TestCase_testVec3MulNamed, time elapsed: 186200 ns, RESULT:
    [ PASSED ] CASE: testVec3MulNamed (6600 ns)
    TCS: TestCase_testVec3DivNamed, time elapsed: 207500 ns, RESULT:
    [ PASSED ] CASE: testVec3DivNamed (18900 ns)
    TCS: TestCase_testVec3ModNamed, time elapsed: 201100 ns, RESULT:
    [ PASSED ] CASE: testVec3ModNamed (7700 ns)
    TCS: TestCase_testVec3BitwiseOr, time elapsed: 363700 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseOr (23900 ns)
    TCS: TestCase_testVec3BitwiseXor, time elapsed: 203900 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseXor (20400 ns)
    TCS: TestCase_testVec3ScalarBitwiseAnd, time elapsed: 190700 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarBitwiseAnd (15500 ns)
    TCS: TestCase_testVec3ShiftRight, time elapsed: 182200 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftRight (11700 ns)
    TCS: TestCase_testVec3Vec1BitBroadcast, time elapsed: 182900 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1BitBroadcast (17700 ns)
    TCS: TestCase_testVec3ShiftRightVec1, time elapsed: 174200 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftRightVec1 (10600 ns)
    TCS: TestCase_testVec3FromVec1, time elapsed: 170200 ns, RESULT:
    [ PASSED ] CASE: testVec3FromVec1 (7000 ns)
    TCS: TestCase_testVec3ScalarBitwiseOr, time elapsed: 185200 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarBitwiseOr (10300 ns)
    TCS: TestCase_testVec3ScalarBitwiseXor, time elapsed: 186300 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarBitwiseXor (13900 ns)
    TCS: TestCase_testVec3Vec1BitOrBroadcast, time elapsed: 173000 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1BitOrBroadcast (12900 ns)
    TCS: TestCase_testVec3Vec1BitXorBroadcast, time elapsed: 175500 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1BitXorBroadcast (11900 ns)
    TCS: TestCase_testVec3ShiftLeftVec1, time elapsed: 176500 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftLeftVec1 (13800 ns)
    TCS: TestCase_testVec3ShiftLeftVec, time elapsed: 162500 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftLeftVec (6000 ns)
    TCS: TestCase_testVec3ShiftRightVec, time elapsed: 174200 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftRightVec (11200 ns)
    TCS: TestCase_testVec3Increment, time elapsed: 179100 ns, RESULT:
    [ PASSED ] CASE: testVec3Increment (16500 ns)
    TCS: TestCase_testVec3Decrement, time elapsed: 189800 ns, RESULT:
    [ PASSED ] CASE: testVec3Decrement (26000 ns)
    TCS: TestCase_testVec3IndexOutOfBoundsAccess, time elapsed: 209500 ns, RESULT:
    [ PASSED ] CASE: testVec3IndexOutOfBoundsAccess (40700 ns)
    TCS: TestCase_testVec3NegativeIndexAccess, time elapsed: 173200 ns, RESULT:
    [ PASSED ] CASE: testVec3NegativeIndexAccess (14300 ns)
    TCS: TestCase_testVec4ScalarInit, time elapsed: 182700 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarInit (12600 ns)
    TCS: TestCase_testVec4ConstInit, time elapsed: 164600 ns, RESULT:
    [ PASSED ] CASE: testVec4ConstInit (5800 ns)
    TCS: TestCase_testVec4Length, time elapsed: 164100 ns, RESULT:
    [ PASSED ] CASE: testVec4Length (5600 ns)
    TCS: TestCase_testVec4Add, time elapsed: 184100 ns, RESULT:
    [ PASSED ] CASE: testVec4Add (18300 ns)
    TCS: TestCase_testVec4ScalarMul, time elapsed: 181500 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarMul (15400 ns)
    TCS: TestCase_testVec4Negate, time elapsed: 197400 ns, RESULT:
    [ PASSED ] CASE: testVec4Negate (12700 ns)
    TCS: TestCase_testVec4IndexAccess, time elapsed: 191700 ns, RESULT:
    [ PASSED ] CASE: testVec4IndexAccess (7400 ns)
    TCS: TestCase_testVec4IndexMutate, time elapsed: 199500 ns, RESULT:
    [ PASSED ] CASE: testVec4IndexMutate (15300 ns)
    TCS: TestCase_testVec4ComponentAt, time elapsed: 198900 ns, RESULT:
    [ PASSED ] CASE: testVec4ComponentAt (10200 ns)
    TCS: TestCase_testVec4Equal, time elapsed: 200000 ns, RESULT:
    [ PASSED ] CASE: testVec4Equal (18800 ns)
    TCS: TestCase_testVec4NotEqual, time elapsed: 195800 ns, RESULT:
    [ PASSED ] CASE: testVec4NotEqual (14200 ns)
    TCS: TestCase_testVec4EqualExact, time elapsed: 200500 ns, RESULT:
    [ PASSED ] CASE: testVec4EqualExact (15200 ns)
    TCS: TestCase_testVec4BitwiseAnd, time elapsed: 226900 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseAnd (20000 ns)
    TCS: TestCase_testVec4BitwiseNot, time elapsed: 203000 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseNot (18600 ns)
    TCS: TestCase_testVec4Vec1ArithBroadcast, time elapsed: 191300 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1ArithBroadcast (16500 ns)
    TCS: TestCase_testVec4ShiftLeft, time elapsed: 176300 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftLeft (13000 ns)
    TCS: TestCase_testVec4BoolLogicalAnd, time elapsed: 173000 ns, RESULT:
    [ PASSED ] CASE: testVec4BoolLogicalAnd (10500 ns)
    TCS: TestCase_testVec4Sub, time elapsed: 182400 ns, RESULT:
    [ PASSED ] CASE: testVec4Sub (12800 ns)
    TCS: TestCase_testVec4Div, time elapsed: 176600 ns, RESULT:
    [ PASSED ] CASE: testVec4Div (12700 ns)
    TCS: TestCase_testVec4Mod, time elapsed: 196200 ns, RESULT:
    [ PASSED ] CASE: testVec4Mod (15900 ns)
    TCS: TestCase_testVec4ScalarSub, time elapsed: 188400 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarSub (13000 ns)
    TCS: TestCase_testVec4ScalarDiv, time elapsed: 182200 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarDiv (12700 ns)
    TCS: TestCase_testVec4ScalarMod, time elapsed: 173500 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarMod (11700 ns)
    TCS: TestCase_testVec4BoolLogicalOr, time elapsed: 162200 ns, RESULT:
    [ PASSED ] CASE: testVec4BoolLogicalOr (5500 ns)
    TCS: TestCase_testVec4EqualEpsilon, time elapsed: 178500 ns, RESULT:
    [ PASSED ] CASE: testVec4EqualEpsilon (21000 ns)
    TCS: TestCase_testVec4AddNamed, time elapsed: 186200 ns, RESULT:
    [ PASSED ] CASE: testVec4AddNamed (16500 ns)
    TCS: TestCase_testVec4MulNamed, time elapsed: 178200 ns, RESULT:
    [ PASSED ] CASE: testVec4MulNamed (6300 ns)
    TCS: TestCase_testVec4DivNamed, time elapsed: 176000 ns, RESULT:
    [ PASSED ] CASE: testVec4DivNamed (6300 ns)
    TCS: TestCase_testVec4ModNamed, time elapsed: 187300 ns, RESULT:
    [ PASSED ] CASE: testVec4ModNamed (5700 ns)
    TCS: TestCase_testVec4BitwiseOr, time elapsed: 179800 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseOr (14400 ns)
    TCS: TestCase_testVec4BitwiseXor, time elapsed: 176100 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseXor (12600 ns)
    TCS: TestCase_testVec4ScalarBitwiseAnd, time elapsed: 185000 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarBitwiseAnd (16200 ns)
    TCS: TestCase_testVec4ShiftRight, time elapsed: 178500 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftRight (12100 ns)
    TCS: TestCase_testVec4Vec1BitBroadcast, time elapsed: 194800 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1BitBroadcast (12200 ns)
    TCS: TestCase_testVec4ShiftRightVec1, time elapsed: 199700 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftRightVec1 (11600 ns)
    TCS: TestCase_testVec4FromVec1, time elapsed: 182500 ns, RESULT:
    [ PASSED ] CASE: testVec4FromVec1 (5800 ns)
    TCS: TestCase_testVec4ScalarBitwiseOr, time elapsed: 181900 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarBitwiseOr (13700 ns)
    TCS: TestCase_testVec4ScalarBitwiseXor, time elapsed: 177000 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarBitwiseXor (12500 ns)
    TCS: TestCase_testVec4Vec1BitOrBroadcast, time elapsed: 233500 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1BitOrBroadcast (15900 ns)
    TCS: TestCase_testVec4Vec1BitXorBroadcast, time elapsed: 310800 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1BitXorBroadcast (26700 ns)
    TCS: TestCase_testVec4ShiftLeftVec1, time elapsed: 198400 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftLeftVec1 (14800 ns)
    TCS: TestCase_testVec4ShiftLeftVec, time elapsed: 242700 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftLeftVec (16800 ns)
    TCS: TestCase_testVec4ShiftRightVec, time elapsed: 319000 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftRightVec (28600 ns)
    TCS: TestCase_testVec4Increment, time elapsed: 212300 ns, RESULT:
    [ PASSED ] CASE: testVec4Increment (23500 ns)
    TCS: TestCase_testVec4Decrement, time elapsed: 189800 ns, RESULT:
    [ PASSED ] CASE: testVec4Decrement (17100 ns)
    TCS: TestCase_testVec4IndexOutOfBoundsAccess, time elapsed: 206400 ns, RESULT:
    [ PASSED ] CASE: testVec4IndexOutOfBoundsAccess (46200 ns)
    TCS: TestCase_testVec4NegativeIndexAccess, time elapsed: 176400 ns, RESULT:
    [ PASSED ] CASE: testVec4NegativeIndexAccess (15200 ns)
    TCS: TestCase_testFunctor1Vec1Identity, time elapsed: 175700 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec1Identity (7500 ns)
    TCS: TestCase_testFunctor1Vec1Transform, time elapsed: 168000 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec1Transform (6700 ns)
    TCS: TestCase_testFunctor1Vec2Transform, time elapsed: 164400 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec2Transform (6400 ns)
    TCS: TestCase_testFunctor2Vec1Add, time elapsed: 163400 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec1Add (5800 ns)
    TCS: TestCase_testFunctor2VecScaVec1Mul, time elapsed: 180000 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec1Mul (19800 ns)
    TCS: TestCase_testFunctor2VecIntVec1Shift, time elapsed: 177500 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec1Shift (10300 ns)
    TCS: TestCase_testFunctor1Vec3Transform, time elapsed: 191200 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec3Transform (9500 ns)
    TCS: TestCase_testFunctor1Vec4Transform, time elapsed: 485300 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec4Transform (26400 ns)
    TCS: TestCase_testFunctor2Vec2Add, time elapsed: 239800 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec2Add (7300 ns)
    TCS: TestCase_testFunctor2Vec3Add, time elapsed: 176700 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec3Add (13400 ns)
    TCS: TestCase_testFunctor2Vec4Add, time elapsed: 170700 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec4Add (6300 ns)
    TCS: TestCase_testFunctor2VecScaVec2Mul, time elapsed: 186500 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec2Mul (14000 ns)
    TCS: TestCase_testFunctor2VecScaVec3Mul, time elapsed: 419400 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec3Mul (15000 ns)
    TCS: TestCase_testFunctor2VecScaVec4Mul, time elapsed: 293200 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec4Mul (10900 ns)
    TCS: TestCase_testFunctor2VecIntVec2Shift, time elapsed: 266900 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec2Shift (19400 ns)
    TCS: TestCase_testFunctor2VecIntVec3Shift, time elapsed: 178800 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec3Shift (6100 ns)
    TCS: TestCase_testFunctor2VecIntVec4Shift, time elapsed: 177200 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec4Shift (6400 ns)
Summary: TOTAL: 435
    PASSED: 435, SKIPPED: 0, ERROR: 0
    FAILED: 0
--------------------------------------------------------------------------------------------------
Project tests finished, time elapsed: 165626200 ns, RESULT:
TP: glm.*, time elapsed: 165553600 ns, RESULT:
    PASSED:
    TP: glm.detail, time elapsed: 149363500 ns
Summary: TOTAL: 435
    PASSED: 435, SKIPPED: 0, ERROR: 0
    FAILED: 0
--------------------------------------------------------------------------------------------------
cjpm test success
