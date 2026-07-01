# 验证报告（v17）

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

warning[0m: unused import 'glm.detail.Quat'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_double.cj:2:21:
  | 
2 | import glm.detail.{ Quat, PackedHighp }
  |                     ^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'glm.detail.PackedHighp'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_double.cj:2:27:
  | 
2 | import glm.detail.{ Quat, PackedHighp }
  |                           ^^^^^^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'std.math as math'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\scalar_common.cj:4:1:
  | 
4 | import std.math as math
  | ^^^^^^^^^^^^^^^^^^^^^^^ unused import
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

75 warnings generated, 75 warnings printed.
warning[0m: unused import 'glm.detail.Vec2'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:2:29:
  | 
2 | import glm.detail.{ Mat4x4, Vec2, Vec3, Vec4, Qualifier, sinT, cosT, normalize }
  |                             ^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'glm.detail.Vec1'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\noise.cj:2:20:
  | 
2 | import glm.detail.{Vec1, Vec2, Vec3, Vec4, Qualifier, floor, fract, abs, min, max, dot, mix, step, clamp, roundEven, mod, trunc, lessThan}
  |                    ^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'glm.detail.min'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\noise.cj:2:74:
  | 
2 | import glm.detail.{Vec1, Vec2, Vec3, Vec4, Qualifier, floor, fract, abs, min, max, dot, mix, step, clamp, roundEven, mod, trunc, lessThan}
  |                                                                          ^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'glm.detail.max'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\noise.cj:2:79:
  | 
2 | import glm.detail.{Vec1, Vec2, Vec3, Vec4, Qualifier, floor, fract, abs, min, max, dot, mix, step, clamp, roundEven, mod, trunc, lessThan}
  |                                                                               ^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'glm.detail.dot'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\noise.cj:2:84:
  | 
2 | import glm.detail.{Vec1, Vec2, Vec3, Vec4, Qualifier, floor, fract, abs, min, max, dot, mix, step, clamp, roundEven, mod, trunc, lessThan}
  |                                                                                    ^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'glm.detail.clamp'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\noise.cj:2:100:
  | 
2 | import glm.detail.{Vec1, Vec2, Vec3, Vec4, Qualifier, floor, fract, abs, min, max, dot, mix, step, clamp, roundEven, mod, trunc, lessThan}
  |                                                                                                    ^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'glm.detail.roundEven'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\noise.cj:2:107:
  | 
2 | import glm.detail.{Vec1, Vec2, Vec3, Vec4, Qualifier, floor, fract, abs, min, max, dot, mix, step, clamp, roundEven, mod, trunc, lessThan}
  |                                                                                                           ^^^^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'glm.detail.mod'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\noise.cj:2:118:
  | 
2 | import glm.detail.{Vec1, Vec2, Vec3, Vec4, Qualifier, floor, fract, abs, min, max, dot, mix, step, clamp, roundEven, mod, trunc, lessThan}
  |                                                                                                                      ^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'glm.detail.trunc'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\noise.cj:2:123:
  | 
2 | import glm.detail.{Vec1, Vec2, Vec3, Vec4, Qualifier, floor, fract, abs, min, max, dot, mix, step, clamp, roundEven, mod, trunc, lessThan}
  |                                                                                                                           ^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused import 'glm.detail.lessThan'
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\noise.cj:2:130:
  | 
2 | import glm.detail.{Vec1, Vec2, Vec3, Vec4, Qualifier, floor, fract, abs, min, max, dot, mix, step, clamp, roundEven, mod, trunc, lessThan}
  |                                                                                                                                  ^^^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'x'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:23:31:
   | 
23 | public func eulerAngles<T, Q>(x: Quat<T, Q>): Vec3<T, Q>
   |                               ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'q'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:27:24:
   | 
27 | public func roll<T, Q>(q: Quat<T, Q>): T
   |                        ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'q'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:31:25:
   | 
31 | public func pitch<T, Q>(q: Quat<T, Q>): T
   |                         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'q'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:35:23:
   | 
35 | public func yaw<T, Q>(q: Quat<T, Q>): T
   |                       ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'direction'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:39:30:
   | 
39 | public func quatLookAt<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
   |                              ^^^^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'up'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:39:53:
   | 
39 | public func quatLookAt<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
   |                                                     ^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'direction'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:43:32:
   | 
43 | public func quatLookAtRH<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
   |                                ^^^^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'up'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:43:55:
   | 
43 | public func quatLookAtRH<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
   |                                                       ^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'direction'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:47:32:
   | 
47 | public func quatLookAtLH<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
   |                                ^^^^^^^^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'up'
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\quaternion.cj:47:55:
   | 
47 | public func quatLookAtLH<T, Q>(direction: Vec3<T, Q>, up: Vec3<T, Q>): Quat<T, Q>
   |                                                       ^^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'result'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\packing.cj:163:9:
    | 
163 |     var result: UInt32
    |         ^^^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'i1'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\noise.cj:326:9:
    | 
326 |     let i1 = i0 + one
    |         ^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning[0m: unused variable:'half'
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\noise.cj:447:9:
    | 
447 |     let half = (Float64(0.5) as T).getOrThrow()
    |         ^^^^ unused variable
    | 
    # note: this warning can be suppressed by setting the compiler option `-Woff unused`

23 warnings generated, 23 warnings printed.
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

warning[0m: imported decl 'Quat' is shadowed, it will be ignored by compiler
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:10:27:
   | 
10 | public import glm.detail.{Quat, mat3Cast, mat4Cast, quatCast}
   |                           ^^^^ 
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: 'Quat' is declared here
   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:327:13:
    | 
327 | public type Quat = detail.Quat<Float32, PackedHighp>
    |             ^^^^ 
    | 

warning[0m: imported decl 'mod' is conflicted with other import
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:30:83:
   | 
30 | public import glm.detail.{abs, sign, floor, ceil, trunc, round, roundEven, fract, mod, modf,
   |                                                                                   ^^^ 
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: The previous was imported here
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:5:48:
  | 
5 | public import glm.detail.{ add, sub, mul, div, mod }
  |                                                ^^^ 
  | 

warning[0m: imported decl 'mix' is conflicted with other import
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:31:22:
   | 
31 |     min, max, clamp, mix, step, smoothstep, isnan, isinf,
   |                      ^^^ 
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: The previous was imported here
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:14:81:
   | 
14 | public import glm.ext.{equal, notEqual, conjugate, inverse, lerp, isnan, isinf, mix, slerp}
   |                                                                                 ^^^ 
   | 

warning[0m: imported decl 'isnan' is conflicted with other import
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:31:45:
   | 
31 |     min, max, clamp, mix, step, smoothstep, isnan, isinf,
   |                                             ^^^^^ 
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: The previous was imported here
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:14:67:
   | 
14 | public import glm.ext.{equal, notEqual, conjugate, inverse, lerp, isnan, isinf, mix, slerp}
   |                                                                   ^^^^^ 
   | 

warning[0m: imported decl 'isinf' is conflicted with other import
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:31:52:
   | 
31 |     min, max, clamp, mix, step, smoothstep, isnan, isinf,
   |                                                    ^^^^^ 
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: The previous was imported here
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:14:74:
   | 
14 | public import glm.ext.{equal, notEqual, conjugate, inverse, lerp, isnan, isinf, mix, slerp}
   |                                                                          ^^^^^ 
   | 

warning[0m: imported decl 'pow' is conflicted with other import
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:35:27:
   | 
35 | public import glm.detail.{pow, exp, log, exp2, log2, sqrt, inversesqrt}
   |                           ^^^ 
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: The previous was imported here
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:16:34:
   | 
16 | public import glm.ext.{exp, log, pow, sqrt}
   |                                  ^^^ 
   | 

warning[0m: imported decl 'exp' is conflicted with other import
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:35:32:
   | 
35 | public import glm.detail.{pow, exp, log, exp2, log2, sqrt, inversesqrt}
   |                                ^^^ 
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: The previous was imported here
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:16:24:
   | 
16 | public import glm.ext.{exp, log, pow, sqrt}
   |                        ^^^ 
   | 

warning[0m: imported decl 'log' is conflicted with other import
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:35:37:
   | 
35 | public import glm.detail.{pow, exp, log, exp2, log2, sqrt, inversesqrt}
   |                                     ^^^ 
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: The previous was imported here
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:16:29:
   | 
16 | public import glm.ext.{exp, log, pow, sqrt}
   |                             ^^^ 
   | 

warning[0m: imported decl 'sqrt' is conflicted with other import
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:35:54:
   | 
35 | public import glm.detail.{pow, exp, log, exp2, log2, sqrt, inversesqrt}
   |                                                      ^^^^ 
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: The previous was imported here
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:16:39:
   | 
16 | public import glm.ext.{exp, log, pow, sqrt}
   |                                       ^^^^ 
   | 

warning[0m: imported decl 'dot' is conflicted with other import
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:37:27:
   | 
37 | public import glm.detail.{dot, cross, normalize, length, distance, reflect, refract, faceforward}
   |                           ^^^ 
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: The previous was imported here
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:15:24:
   | 
15 | public import glm.ext.{dot, length, normalize, cross, axis, angle, angleAxis}
   |                        ^^^ 
   | 

warning[0m: imported decl 'cross' is conflicted with other import
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:37:32:
   | 
37 | public import glm.detail.{dot, cross, normalize, length, distance, reflect, refract, faceforward}
   |                                ^^^^^ 
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: The previous was imported here
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:15:48:
   | 
15 | public import glm.ext.{dot, length, normalize, cross, axis, angle, angleAxis}
   |                                                ^^^^^ 
   | 

warning[0m: imported decl 'normalize' is conflicted with other import
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:37:39:
   | 
37 | public import glm.detail.{dot, cross, normalize, length, distance, reflect, refract, faceforward}
   |                                       ^^^^^^^^^ 
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: The previous was imported here
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:15:37:
   | 
15 | public import glm.ext.{dot, length, normalize, cross, axis, angle, angleAxis}
   |                                     ^^^^^^^^^ 
   | 

warning[0m: imported decl 'length' is conflicted with other import
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:37:50:
   | 
37 | public import glm.detail.{dot, cross, normalize, length, distance, reflect, refract, faceforward}
   |                                                  ^^^^^^ 
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: The previous was imported here
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:15:29:
   | 
15 | public import glm.ext.{dot, length, normalize, cross, axis, angle, angleAxis}
   |                             ^^^^^^ 
   | 

warning[0m: imported decl 'inverse' is conflicted with other import
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:39:40:
   | 
39 | public import glm.detail.{determinant, inverse}
   |                                        ^^^^^^^ 
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: The previous was imported here
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:14:52:
   | 
14 | public import glm.ext.{equal, notEqual, conjugate, inverse, lerp, isnan, isinf, mix, slerp}
   |                                                    ^^^^^^^ 
   | 

warning[0m: imported decl 'min' is conflicted with other import
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:41:24:
   | 
41 | public import glm.ext.{min, max, fmin, fmax, fclamp, clamp, repeat, mirrorClamp, mirrorRepeat, iround, uround}
   |                        ^^^ 
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: The previous was imported here
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:31:5:
   | 
31 |     min, max, clamp, mix, step, smoothstep, isnan, isinf,
   |     ^^^ 
   | 

warning[0m: imported decl 'max' is conflicted with other import
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:41:29:
   | 
41 | public import glm.ext.{min, max, fmin, fmax, fclamp, clamp, repeat, mirrorClamp, mirrorRepeat, iround, uround}
   |                             ^^^ 
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: The previous was imported here
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:31:10:
   | 
31 |     min, max, clamp, mix, step, smoothstep, isnan, isinf,
   |          ^^^ 
   | 

warning[0m: imported decl 'clamp' is conflicted with other import
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:41:54:
   | 
41 | public import glm.ext.{min, max, fmin, fmax, fclamp, clamp, repeat, mirrorClamp, mirrorRepeat, iround, uround}
   |                                                      ^^^^^ 
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: The previous was imported here
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:31:15:
   | 
31 |     min, max, clamp, mix, step, smoothstep, isnan, isinf,
   |               ^^^^^ 
   | 

warning[0m: imported decl 'lessThan' is conflicted with other import
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:45:27:
   | 
45 | public import glm.detail.{lessThan, greaterThan, lessThanEqual, greaterThanEqual, equal, notEqual, any, all, not_}
   |                           ^^^^^^^^ 
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: The previous was imported here
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:22:24:
   | 
22 | public import glm.gtc.{lessThan, lessThanEqual, greaterThan, greaterThanEqual, eulerAngles, roll, pitch, yaw, quatLookAt, quatLookAtRH, quatLookAtLH}
   |                        ^^^^^^^^ 
   | 

warning[0m: imported decl 'greaterThan' is conflicted with other import
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:45:37:
   | 
45 | public import glm.detail.{lessThan, greaterThan, lessThanEqual, greaterThanEqual, equal, notEqual, any, all, not_}
   |                                     ^^^^^^^^^^^ 
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: The previous was imported here
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:22:49:
   | 
22 | public import glm.gtc.{lessThan, lessThanEqual, greaterThan, greaterThanEqual, eulerAngles, roll, pitch, yaw, quatLookAt, quatLookAtRH, quatLookAtLH}
   |                                                 ^^^^^^^^^^^ 
   | 

warning[0m: imported decl 'lessThanEqual' is conflicted with other import
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:45:50:
   | 
45 | public import glm.detail.{lessThan, greaterThan, lessThanEqual, greaterThanEqual, equal, notEqual, any, all, not_}
   |                                                  ^^^^^^^^^^^^^ 
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: The previous was imported here
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:22:34:
   | 
22 | public import glm.gtc.{lessThan, lessThanEqual, greaterThan, greaterThanEqual, eulerAngles, roll, pitch, yaw, quatLookAt, quatLookAtRH, quatLookAtLH}
   |                                  ^^^^^^^^^^^^^ 
   | 

warning[0m: imported decl 'greaterThanEqual' is conflicted with other import
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:45:65:
   | 
45 | public import glm.detail.{lessThan, greaterThan, lessThanEqual, greaterThanEqual, equal, notEqual, any, all, not_}
   |                                                                 ^^^^^^^^^^^^^^^^ 
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: The previous was imported here
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:22:62:
   | 
22 | public import glm.gtc.{lessThan, lessThanEqual, greaterThan, greaterThanEqual, eulerAngles, roll, pitch, yaw, quatLookAt, quatLookAtRH, quatLookAtLH}
   |                                                              ^^^^^^^^^^^^^^^^ 
   | 

warning[0m: imported decl 'equal' is conflicted with other import
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:45:83:
   | 
45 | public import glm.detail.{lessThan, greaterThan, lessThanEqual, greaterThanEqual, equal, notEqual, any, all, not_}
   |                                                                                   ^^^^^ 
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: The previous was imported here
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:14:24:
   | 
14 | public import glm.ext.{equal, notEqual, conjugate, inverse, lerp, isnan, isinf, mix, slerp}
   |                        ^^^^^ 
   | 

warning[0m: imported decl 'notEqual' is conflicted with other import
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:45:90:
   | 
45 | public import glm.detail.{lessThan, greaterThan, lessThanEqual, greaterThanEqual, equal, notEqual, any, all, not_}
   |                                                                                          ^^^^^^^^ 
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`
note[0m: The previous was imported here
  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:14:31:
   | 
14 | public import glm.ext.{equal, notEqual, conjugate, inverse, lerp, isnan, isinf, mix, slerp}
   |                               ^^^^^^^^ 
   | 

27 warnings generated, 27 warnings printed.
[?25l[0J7[;r8
[1F7[9999E8--------------------------------------------------------------------------------------------------
TP: [33mglm.detail[0m, time elapsed: 140787300 ns, RESULT:
    TCS: [33mTestCase_testComputeVecAdd1[0m, time elapsed: 1672800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAdd1 (315200 ns)
    TCS: [33mTestCase_testComputeVecSub2[0m, time elapsed: 565300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub2 (55800 ns)
    TCS: [33mTestCase_testComputeVecMul3[0m, time elapsed: 315300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul3 (36200 ns)
    TCS: [33mTestCase_testComputeVecMod1[0m, time elapsed: 327600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMod1 (38500 ns)
    TCS: [33mTestCase_testComputeVecMod4[0m, time elapsed: 278600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMod4 (29300 ns)
    TCS: [33mTestCase_testComputeVecAnd1[0m, time elapsed: 271800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAnd1 (22100 ns)
    TCS: [33mTestCase_testComputeVecAnd3[0m, time elapsed: 256600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAnd3 (21600 ns)
    TCS: [33mTestCase_testComputeVecOr1[0m, time elapsed: 247000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecOr1 (20500 ns)
    TCS: [33mTestCase_testComputeVecOr2[0m, time elapsed: 249000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecOr2 (17900 ns)
    TCS: [33mTestCase_testComputeVecXor1[0m, time elapsed: 308300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecXor1 (52200 ns)
    TCS: [33mTestCase_testComputeVecXor4[0m, time elapsed: 266700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecXor4 (23300 ns)
    TCS: [33mTestCase_testComputeVecShiftLeft1[0m, time elapsed: 233400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftLeft1 (14300 ns)
    TCS: [33mTestCase_testComputeVecShiftLeft3[0m, time elapsed: 231500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftLeft3 (13900 ns)
    TCS: [33mTestCase_testComputeVecShiftRight1[0m, time elapsed: 242100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftRight1 (19900 ns)
    TCS: [33mTestCase_testComputeVecShiftRight4[0m, time elapsed: 269800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftRight4 (16300 ns)
    TCS: [33mTestCase_testComputeVecEqual1[0m, time elapsed: 250500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual1 (19600 ns)
    TCS: [33mTestCase_testComputeVecNequal4[0m, time elapsed: 228800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal4 (14800 ns)
    TCS: [33mTestCase_testComputeVecBitwiseNot1[0m, time elapsed: 249400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecBitwiseNot1 (25600 ns)
    TCS: [33mTestCase_testComputeVecBitwiseNot3[0m, time elapsed: 318500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecBitwiseNot3 (39600 ns)
    TCS: [33mTestCase_testComputeVecAdd4[0m, time elapsed: 366600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAdd4 (39600 ns)
    TCS: [33mTestCase_testComputeVecSub1[0m, time elapsed: 947400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub1 (31500 ns)
    TCS: [33mTestCase_testComputeVecSub3[0m, time elapsed: 281700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub3 (28100 ns)
    TCS: [33mTestCase_testComputeVecMul1[0m, time elapsed: 215000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul1 (17700 ns)
    TCS: [33mTestCase_testComputeVecMul2[0m, time elapsed: 220100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul2 (18900 ns)
    TCS: [33mTestCase_testComputeVecDiv1[0m, time elapsed: 210200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecDiv1 (18600 ns)
    TCS: [33mTestCase_testComputeVecDiv2[0m, time elapsed: 251500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecDiv2 (17300 ns)
    TCS: [33mTestCase_testComputeVecDiv4[0m, time elapsed: 213100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecDiv4 (18800 ns)
    TCS: [33mTestCase_testComputeVecEqual2[0m, time elapsed: 197100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual2 (12900 ns)
    TCS: [33mTestCase_testComputeVecEqual3[0m, time elapsed: 208100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual3 (17500 ns)
    TCS: [33mTestCase_testComputeVecEqual4[0m, time elapsed: 199900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual4 (14300 ns)
    TCS: [33mTestCase_testComputeVecNequal1[0m, time elapsed: 202400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal1 (16400 ns)
    TCS: [33mTestCase_testComputeVecNequal2[0m, time elapsed: 205900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal2 (10300 ns)
    TCS: [33mTestCase_testComputeVecBitwiseNot4[0m, time elapsed: 236400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecBitwiseNot4 (25200 ns)
    TCS: [33mTestCase_testComputeVecAddFloat32[0m, time elapsed: 257000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAddFloat32 (31800 ns)
    TCS: [33mTestCase_testComputeVecAddFloat32Vec3[0m, time elapsed: 284900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAddFloat32Vec3 (25200 ns)
    TCS: [33mTestCase_testComputeVecSubFloat32[0m, time elapsed: 216500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSubFloat32 (25800 ns)
    TCS: [33mTestCase_testComputeVecSubFloat32Vec4[0m, time elapsed: 218800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSubFloat32Vec4 (22900 ns)
    TCS: [33mTestCase_testComputeEqualInt32Equal[0m, time elapsed: 192600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt32Equal (15000 ns)
    TCS: [33mTestCase_testComputeEqualInt32NotEqual[0m, time elapsed: 196100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt32NotEqual (12200 ns)
    TCS: [33mTestCase_testComputeEqualFloat32Equal[0m, time elapsed: 188100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32Equal (12800 ns)
    TCS: [33mTestCase_testComputeEqualFloat32NotEqual[0m, time elapsed: 184000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32NotEqual (8400 ns)
    TCS: [33mTestCase_testComputeEqualFloat64Equal[0m, time elapsed: 181900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64Equal (13100 ns)
    TCS: [33mTestCase_testComputeEqualFloat64NotEqual[0m, time elapsed: 269000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64NotEqual (14100 ns)
    TCS: [33mTestCase_testComputeEqualBoolEqual[0m, time elapsed: 347200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualBoolEqual (18900 ns)
    TCS: [33mTestCase_testComputeEqualBoolNotEqual[0m, time elapsed: 250500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualBoolNotEqual (12300 ns)
    TCS: [33mTestCase_testComputeEqualNumericInt32[0m, time elapsed: 218600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericInt32 (12900 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32[0m, time elapsed: 213600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32 (34800 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32Epsilon[0m, time elapsed: 188900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32Epsilon (11200 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64[0m, time elapsed: 185000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64 (13500 ns)
    TCS: [33mTestCase_testComputeEqualInt64Equal[0m, time elapsed: 178300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt64Equal (10500 ns)
    TCS: [33mTestCase_testComputeEqualInt64NotEqual[0m, time elapsed: 182100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt64NotEqual (9600 ns)
    TCS: [33mTestCase_testComputeEqualFloat32Nan[0m, time elapsed: 194600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32Nan (13100 ns)
    TCS: [33mTestCase_testComputeEqualFloat64Nan[0m, time elapsed: 208200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64Nan (8300 ns)
    TCS: [33mTestCase_testComputeEqualFloat32SignedZero[0m, time elapsed: 190900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32SignedZero (8300 ns)
    TCS: [33mTestCase_testComputeEqualFloat64SignedZero[0m, time elapsed: 194900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64SignedZero (8400 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32NotEqual[0m, time elapsed: 198300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32NotEqual (10100 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32BeyondEpsilon[0m, time elapsed: 205000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32BeyondEpsilon (11300 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64NotEqual[0m, time elapsed: 200700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64NotEqual (16700 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64Epsilon[0m, time elapsed: 217100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64Epsilon (11400 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64BeyondEpsilon[0m, time elapsed: 202800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64BeyondEpsilon (11000 ns)
    TCS: [33mTestCase_testComputeEqualNumericInt64[0m, time elapsed: 195100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericInt64 (12200 ns)
    TCS: [33mTestCase_testPackedHighpImplementsQualifier[0m, time elapsed: 194500 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedHighpImplementsQualifier (14400 ns)
    TCS: [33mTestCase_testPackedMediumpImplementsQualifier[0m, time elapsed: 195900 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedMediumpImplementsQualifier (13100 ns)
    TCS: [33mTestCase_testPackedLowpImplementsQualifier[0m, time elapsed: 201600 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedLowpImplementsQualifier (12600 ns)
    TCS: [33mTestCase_testDefaultpIsPackedHighp[0m, time elapsed: 196700 ns, RESULT:
    [[32m PASSED [0m] CASE: testDefaultpIsPackedHighp (8800 ns)
    TCS: [33mTestCase_testScalarAddVec1[0m, time elapsed: 215400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec1 (17700 ns)
    TCS: [33mTestCase_testScalarAddVec2[0m, time elapsed: 200000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec2 (13700 ns)
    TCS: [33mTestCase_testScalarAddVec3[0m, time elapsed: 203300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec3 (12300 ns)
    TCS: [33mTestCase_testScalarAddVec4[0m, time elapsed: 203000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec4 (16200 ns)
    TCS: [33mTestCase_testScalarSubVec1[0m, time elapsed: 198100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1 (13300 ns)
    TCS: [33mTestCase_testScalarMulVec1[0m, time elapsed: 204800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1 (14300 ns)
    TCS: [33mTestCase_testScalarDivVec1[0m, time elapsed: 356500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1 (17200 ns)
    TCS: [33mTestCase_testScalarModVec1[0m, time elapsed: 272100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1 (20600 ns)
    TCS: [33mTestCase_testScalarMulVec2[0m, time elapsed: 211200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2 (14400 ns)
    TCS: [33mTestCase_testScalarSubVec2[0m, time elapsed: 201900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2 (13200 ns)
    TCS: [33mTestCase_testScalarSubVec3[0m, time elapsed: 206400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3 (9800 ns)
    TCS: [33mTestCase_testScalarSubVec4[0m, time elapsed: 197800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4 (12700 ns)
    TCS: [33mTestCase_testScalarMulVec3[0m, time elapsed: 222900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3 (14200 ns)
    TCS: [33mTestCase_testScalarMulVec4[0m, time elapsed: 201800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4 (12400 ns)
    TCS: [33mTestCase_testScalarDivVec2[0m, time elapsed: 208200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2 (15300 ns)
    TCS: [33mTestCase_testScalarDivVec3[0m, time elapsed: 206400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3 (13000 ns)
    TCS: [33mTestCase_testScalarDivVec4[0m, time elapsed: 199200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4 (12600 ns)
    TCS: [33mTestCase_testScalarModVec2[0m, time elapsed: 194600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2 (9600 ns)
    TCS: [33mTestCase_testScalarModVec3[0m, time elapsed: 206600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3 (12400 ns)
    TCS: [33mTestCase_testScalarModVec4[0m, time elapsed: 317400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4 (25100 ns)
    TCS: [33mTestCase_testScalarModVec1Float32[0m, time elapsed: 236400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float32 (26800 ns)
    TCS: [33mTestCase_testScalarModVec2Float32[0m, time elapsed: 200800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32 (14700 ns)
    TCS: [33mTestCase_testScalarModVec3Float32[0m, time elapsed: 221800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float32 (10700 ns)
    TCS: [33mTestCase_testScalarModVec4Float32[0m, time elapsed: 191100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float32 (12000 ns)
    TCS: [33mTestCase_testScalarModVec1Float64[0m, time elapsed: 189200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float64 (11100 ns)
    TCS: [33mTestCase_testScalarModVec2Float64[0m, time elapsed: 214100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float64 (13300 ns)
    TCS: [33mTestCase_testScalarModVec3Float64[0m, time elapsed: 193700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float64 (12300 ns)
    TCS: [33mTestCase_testScalarModVec4Float64[0m, time elapsed: 200100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float64 (12400 ns)
    TCS: [33mTestCase_testScalarModVec1Float16[0m, time elapsed: 208100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float16 (21000 ns)
    TCS: [33mTestCase_testScalarModVec2Float16[0m, time elapsed: 190400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float16 (9700 ns)
    TCS: [33mTestCase_testScalarModVec3Float16[0m, time elapsed: 191800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float16 (13200 ns)
    TCS: [33mTestCase_testScalarModVec4Float16[0m, time elapsed: 219000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float16 (14300 ns)
    TCS: [33mTestCase_testScalarSubVec2PackedMediump[0m, time elapsed: 276800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2PackedMediump (22600 ns)
    TCS: [33mTestCase_testScalarSubVec2PackedLowp[0m, time elapsed: 228600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2PackedLowp (17000 ns)
    TCS: [33mTestCase_testScalarMulVec2PackedMediump[0m, time elapsed: 223500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2PackedMediump (15500 ns)
    TCS: [33mTestCase_testScalarMulVec2PackedLowp[0m, time elapsed: 231500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2PackedLowp (12200 ns)
    TCS: [33mTestCase_testScalarDivVec2PackedMediump[0m, time elapsed: 215300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2PackedMediump (9700 ns)
    TCS: [33mTestCase_testScalarDivVec2PackedLowp[0m, time elapsed: 220200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2PackedLowp (10600 ns)
    TCS: [33mTestCase_testScalarModVec2PackedMediump[0m, time elapsed: 227400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2PackedMediump (14500 ns)
    TCS: [33mTestCase_testScalarModVec2PackedLowp[0m, time elapsed: 205100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2PackedLowp (9700 ns)
    TCS: [33mTestCase_testScalarModVec2Float32PackedMediump[0m, time elapsed: 212100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32PackedMediump (14900 ns)
    TCS: [33mTestCase_testScalarModVec2Float32PackedLowp[0m, time elapsed: 210500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32PackedLowp (18100 ns)
    TCS: [33mTestCase_testScalarModVec2Float32NegativeDividend[0m, time elapsed: 201000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32NegativeDividend (13500 ns)
    TCS: [33mTestCase_testScalarModVec2Float32NegativeDivisor[0m, time elapsed: 197700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32NegativeDivisor (9800 ns)
    TCS: [33mTestCase_testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents[0m, time elapsed: 347000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents (126700 ns)
    TCS: [33mTestCase_testScalarAddVec1Float32[0m, time elapsed: 247000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec1Float32 (14200 ns)
    TCS: [33mTestCase_testScalarAddVec2Float32[0m, time elapsed: 206200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec2Float32 (9400 ns)
    TCS: [33mTestCase_testScalarAddVec3Float32[0m, time elapsed: 216700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec3Float32 (12000 ns)
    TCS: [33mTestCase_testScalarAddVec4Float32[0m, time elapsed: 197200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec4Float32 (10200 ns)
    TCS: [33mTestCase_testScalarSubVec1Float32[0m, time elapsed: 236100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1Float32 (15400 ns)
    TCS: [33mTestCase_testScalarSubVec2Float32[0m, time elapsed: 218300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2Float32 (11900 ns)
    TCS: [33mTestCase_testScalarSubVec3Float32[0m, time elapsed: 218800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3Float32 (14700 ns)
    TCS: [33mTestCase_testScalarSubVec4Float32[0m, time elapsed: 206100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4Float32 (12900 ns)
    TCS: [33mTestCase_testScalarMulVec1Float32[0m, time elapsed: 212700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1Float32 (9300 ns)
    TCS: [33mTestCase_testScalarMulVec2Float32[0m, time elapsed: 193100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2Float32 (9100 ns)
    TCS: [33mTestCase_testScalarMulVec3Float32[0m, time elapsed: 191400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3Float32 (9600 ns)
    TCS: [33mTestCase_testScalarMulVec4Float32[0m, time elapsed: 191800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4Float32 (8700 ns)
    TCS: [33mTestCase_testScalarDivVec1Float32[0m, time elapsed: 221200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1Float32 (12400 ns)
    TCS: [33mTestCase_testScalarDivVec2Float32[0m, time elapsed: 232400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2Float32 (11600 ns)
    TCS: [33mTestCase_testScalarDivVec3Float32[0m, time elapsed: 221200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3Float32 (13200 ns)
    TCS: [33mTestCase_testScalarDivVec4Float32[0m, time elapsed: 235200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4Float32 (14500 ns)
    TCS: [33mTestCase_testScalarAddVec1Int32[0m, time elapsed: 234300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec1Int32 (21800 ns)
    TCS: [33mTestCase_testScalarAddVec2Int32[0m, time elapsed: 208300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec2Int32 (12700 ns)
    TCS: [33mTestCase_testScalarAddVec3Int32[0m, time elapsed: 271600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec3Int32 (13100 ns)
    TCS: [33mTestCase_testScalarAddVec4Int32[0m, time elapsed: 218600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec4Int32 (15200 ns)
    TCS: [33mTestCase_testScalarSubVec1Int32[0m, time elapsed: 205300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1Int32 (12600 ns)
    TCS: [33mTestCase_testScalarSubVec2Int32[0m, time elapsed: 200700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2Int32 (11700 ns)
    TCS: [33mTestCase_testScalarSubVec3Int32[0m, time elapsed: 200200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3Int32 (15300 ns)
    TCS: [33mTestCase_testScalarSubVec4Int32[0m, time elapsed: 196400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4Int32 (13100 ns)
    TCS: [33mTestCase_testScalarMulVec1Int32[0m, time elapsed: 278700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1Int32 (28500 ns)
    TCS: [33mTestCase_testScalarMulVec2Int32[0m, time elapsed: 207200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2Int32 (11700 ns)
    TCS: [33mTestCase_testScalarMulVec3Int32[0m, time elapsed: 201000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3Int32 (14900 ns)
    TCS: [33mTestCase_testScalarMulVec4Int32[0m, time elapsed: 186200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4Int32 (8900 ns)
    TCS: [33mTestCase_testScalarDivVec1Int32[0m, time elapsed: 181500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1Int32 (12600 ns)
    TCS: [33mTestCase_testScalarDivVec2Int32[0m, time elapsed: 193800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2Int32 (13000 ns)
    TCS: [33mTestCase_testScalarDivVec3Int32[0m, time elapsed: 187100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3Int32 (8900 ns)
    TCS: [33mTestCase_testScalarDivVec4Int32[0m, time elapsed: 216200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4Int32 (8900 ns)
    TCS: [33mTestCase_testScalarModVec1Int32[0m, time elapsed: 191400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Int32 (11000 ns)
    TCS: [33mTestCase_testScalarModVec2Int32[0m, time elapsed: 187100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Int32 (9200 ns)
    TCS: [33mTestCase_testScalarModVec3Int32[0m, time elapsed: 193800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Int32 (12900 ns)
    TCS: [33mTestCase_testScalarModVec4Int32[0m, time elapsed: 184300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Int32 (9700 ns)
    TCS: [33mTestCase_testScalarSubVec1PackedMediump[0m, time elapsed: 191800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1PackedMediump (13900 ns)
    TCS: [33mTestCase_testScalarSubVec1PackedLowp[0m, time elapsed: 192000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1PackedLowp (13000 ns)
    TCS: [33mTestCase_testScalarSubVec3PackedMediump[0m, time elapsed: 203600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3PackedMediump (10300 ns)
    TCS: [33mTestCase_testScalarSubVec3PackedLowp[0m, time elapsed: 199700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3PackedLowp (16400 ns)
    TCS: [33mTestCase_testScalarSubVec4PackedMediump[0m, time elapsed: 236600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4PackedMediump (12100 ns)
    TCS: [33mTestCase_testScalarSubVec4PackedLowp[0m, time elapsed: 395200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4PackedLowp (16600 ns)
    TCS: [33mTestCase_testScalarMulVec1PackedMediump[0m, time elapsed: 283600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1PackedMediump (18300 ns)
    TCS: [33mTestCase_testScalarMulVec1PackedLowp[0m, time elapsed: 210800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1PackedLowp (11700 ns)
    TCS: [33mTestCase_testScalarMulVec3PackedMediump[0m, time elapsed: 203600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3PackedMediump (10700 ns)
    TCS: [33mTestCase_testScalarMulVec3PackedLowp[0m, time elapsed: 204800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3PackedLowp (9500 ns)
    TCS: [33mTestCase_testScalarMulVec4PackedMediump[0m, time elapsed: 206500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4PackedMediump (9800 ns)
    TCS: [33mTestCase_testScalarMulVec4PackedLowp[0m, time elapsed: 197000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4PackedLowp (9700 ns)
    TCS: [33mTestCase_testScalarDivVec1PackedMediump[0m, time elapsed: 193200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1PackedMediump (8900 ns)
    TCS: [33mTestCase_testScalarDivVec1PackedLowp[0m, time elapsed: 191700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1PackedLowp (8500 ns)
    TCS: [33mTestCase_testScalarDivVec3PackedMediump[0m, time elapsed: 202900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3PackedMediump (15400 ns)
    TCS: [33mTestCase_testScalarDivVec3PackedLowp[0m, time elapsed: 198600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3PackedLowp (9700 ns)
    TCS: [33mTestCase_testScalarDivVec4PackedMediump[0m, time elapsed: 195700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4PackedMediump (10200 ns)
    TCS: [33mTestCase_testScalarDivVec4PackedLowp[0m, time elapsed: 196600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4PackedLowp (9800 ns)
    TCS: [33mTestCase_testScalarModVec1PackedMediump[0m, time elapsed: 305700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1PackedMediump (10800 ns)
    TCS: [33mTestCase_testScalarModVec1PackedLowp[0m, time elapsed: 197300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1PackedLowp (12600 ns)
    TCS: [33mTestCase_testScalarModVec3PackedMediump[0m, time elapsed: 348600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3PackedMediump (18600 ns)
    TCS: [33mTestCase_testScalarModVec3PackedLowp[0m, time elapsed: 312600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3PackedLowp (17600 ns)
    TCS: [33mTestCase_testScalarModVec4PackedMediump[0m, time elapsed: 319700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4PackedMediump (16900 ns)
    TCS: [33mTestCase_testScalarModVec4PackedLowp[0m, time elapsed: 299300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4PackedLowp (16100 ns)
    TCS: [33mTestCase_testScalarDivZeroVec1[0m, time elapsed: 304900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivZeroVec1 (21200 ns)
    TCS: [33mTestCase_testScalarAddNegVec1[0m, time elapsed: 302100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddNegVec1 (20000 ns)
    TCS: [33mTestCase_testScalarAddNegVec2[0m, time elapsed: 277000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddNegVec2 (13400 ns)
    TCS: [33mTestCase_testScalarMulOverflowVec1[0m, time elapsed: 284100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulOverflowVec1 (12700 ns)
    TCS: [33mTestCase_testScalarSubNegVec1[0m, time elapsed: 347100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubNegVec1 (30800 ns)
    TCS: [33mTestCase_testVersionMajor[0m, time elapsed: 298400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionMajor (14800 ns)
    TCS: [33mTestCase_testVersionMinor[0m, time elapsed: 312800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionMinor (20800 ns)
    TCS: [33mTestCase_testVersionPatch[0m, time elapsed: 280200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionPatch (11100 ns)
    TCS: [33mTestCase_testVersionEncoded[0m, time elapsed: 212200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionEncoded (15400 ns)
    TCS: [33mTestCase_testConfigSimd[0m, time elapsed: 227900 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigSimd (13400 ns)
    TCS: [33mTestCase_testConfigAlignedGentypes[0m, time elapsed: 204600 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigAlignedGentypes (9900 ns)
    TCS: [33mTestCase_testConfigClipControl[0m, time elapsed: 230900 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigClipControl (9100 ns)
    TCS: [33mTestCase_testConstNegationSimd[0m, time elapsed: 229400 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationSimd (13500 ns)
    TCS: [33mTestCase_testConstNegationAligned[0m, time elapsed: 198000 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationAligned (8400 ns)
    TCS: [33mTestCase_testConstNegationClip[0m, time elapsed: 180900 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationClip (9300 ns)
    TCS: [33mTestCase_testConstInt64Usage[0m, time elapsed: 184600 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstInt64Usage (9200 ns)
    TCS: [33mTestCase_testConstBoolUsage[0m, time elapsed: 185400 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstBoolUsage (8600 ns)
    TCS: [33mTestCase_testVersionEncodingConsistency[0m, time elapsed: 210300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionEncodingConsistency (10600 ns)
    TCS: [33mTestCase_testAssertPasses[0m, time elapsed: 209400 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertPasses (27700 ns)
    TCS: [33mTestCase_testAssertFails[0m, time elapsed: 240100 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertFails (56900 ns)
    TCS: [33mTestCase_testAssertWithCustomMessage[0m, time elapsed: 209100 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertWithCustomMessage (30800 ns)
    TCS: [33mTestCase_testNumericLimitsFloat32Epsilon[0m, time elapsed: 191700 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsFloat32Epsilon (12500 ns)
    TCS: [33mTestCase_testNumericLimitsFloat64Epsilon[0m, time elapsed: 195200 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsFloat64Epsilon (11200 ns)
    TCS: [33mTestCase_testIsIec559OfFloat32[0m, time elapsed: 191600 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfFloat32 (12500 ns)
    TCS: [33mTestCase_testIsIec559OfFloat64[0m, time elapsed: 188200 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfFloat64 (8000 ns)
    TCS: [33mTestCase_testIsIec559OfInt64[0m, time elapsed: 201200 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfInt64 (12700 ns)
    TCS: [33mTestCase_testEpsilonOfFloat32[0m, time elapsed: 195400 ns, RESULT:
    [[32m PASSED [0m] CASE: testEpsilonOfFloat32 (12200 ns)
    TCS: [33mTestCase_testEpsilonOfFloat64[0m, time elapsed: 196700 ns, RESULT:
    [[32m PASSED [0m] CASE: testEpsilonOfFloat64 (10900 ns)
    TCS: [33mTestCase_testNumericLimitsInt64Epsilon[0m, time elapsed: 199800 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt64Epsilon (13700 ns)
    TCS: [33mTestCase_testNumericLimitsInt32Epsilon[0m, time elapsed: 326100 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt32Epsilon (19600 ns)
    TCS: [33mTestCase_testNumericLimitsInt16Epsilon[0m, time elapsed: 385200 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt16Epsilon (27100 ns)
    TCS: [33mTestCase_testNumericLimitsInt8Epsilon[0m, time elapsed: 220000 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt8Epsilon (16800 ns)
    TCS: [33mTestCase_testCastVec1ToVec1IntToFloat[0m, time elapsed: 226500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec1ToVec1IntToFloat (18900 ns)
    TCS: [33mTestCase_testCastVec2ToVec1TakesOnlyX[0m, time elapsed: 197600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2ToVec1TakesOnlyX (10200 ns)
    TCS: [33mTestCase_testCastVec3ToVec1TakesOnlyX[0m, time elapsed: 205600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3ToVec1TakesOnlyX (10000 ns)
    TCS: [33mTestCase_testCastVec4ToVec1TakesOnlyX[0m, time elapsed: 204200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4ToVec1TakesOnlyX (13700 ns)
    TCS: [33mTestCase_testCastSameTypeIdentity[0m, time elapsed: 417400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastSameTypeIdentity (42500 ns)
    TCS: [33mTestCase_testCastInt32ToInt64[0m, time elapsed: 293600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastInt32ToInt64 (27100 ns)
    TCS: [33mTestCase_testCastFloatToIntTruncation[0m, time elapsed: 309400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastFloatToIntTruncation (26500 ns)
    TCS: [33mTestCase_testCastCrossQualifierPackedHighpToDefaultp[0m, time elapsed: 293400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastCrossQualifierPackedHighpToDefaultp (27300 ns)
    TCS: [33mTestCase_testCastCrossQualifierDefaultpToPackedHighp[0m, time elapsed: 290300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastCrossQualifierDefaultpToPackedHighp (26000 ns)
    TCS: [33mTestCase_testCastVec2CrossQualifierCrossType[0m, time elapsed: 304600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2CrossQualifierCrossType (30400 ns)
    TCS: [33mTestCase_testCastVec3CrossQualifier[0m, time elapsed: 288900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3CrossQualifier (28500 ns)
    TCS: [33mTestCase_testCastVec4CrossQualifier[0m, time elapsed: 289600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4CrossQualifier (28100 ns)
    TCS: [33mTestCase_testCastVec1DoesNotModifySource[0m, time elapsed: 408300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec1DoesNotModifySource (145500 ns)
    TCS: [33mTestCase_testCastVec2Vec1ToVec2IntToFloat[0m, time elapsed: 225400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec1ToVec2IntToFloat (11600 ns)
    TCS: [33mTestCase_testCastVec2Vec2ToVec2Identity[0m, time elapsed: 227300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec2ToVec2Identity (10100 ns)
    TCS: [33mTestCase_testCastVec2Vec3ToVec2TakesOnlyXY[0m, time elapsed: 305900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec3ToVec2TakesOnlyXY (22400 ns)
    TCS: [33mTestCase_testCastVec2Vec4ToVec2TakesOnlyXY[0m, time elapsed: 246000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec4ToVec2TakesOnlyXY (19100 ns)
    TCS: [33mTestCase_testCastVec2SameTypeIdentity[0m, time elapsed: 226200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2SameTypeIdentity (9500 ns)
    TCS: [33mTestCase_testCastVec2Int32ToInt64[0m, time elapsed: 333800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Int32ToInt64 (17100 ns)
    TCS: [33mTestCase_testCastVec2FloatToIntTruncation[0m, time elapsed: 291100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2FloatToIntTruncation (13300 ns)
    TCS: [33mTestCase_testCastVec2CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 271800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2CrossQualifierPackedHighpToDefaultp (10200 ns)
    TCS: [33mTestCase_testCastVec2DoesNotModifySource[0m, time elapsed: 313300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2DoesNotModifySource (17200 ns)
    TCS: [33mTestCase_testCastVec2Vec1ToVec2SameValueBothComponents[0m, time elapsed: 293100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec1ToVec2SameValueBothComponents (14700 ns)
    TCS: [33mTestCase_testCastVec3Vec1ToVec3IntToFloat[0m, time elapsed: 229500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec1ToVec3IntToFloat (17200 ns)
    TCS: [33mTestCase_testCastVec3Vec2ToVec3ExtendY[0m, time elapsed: 200500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec2ToVec3ExtendY (10300 ns)
    TCS: [33mTestCase_testCastVec3Vec3ToVec3Identity[0m, time elapsed: 181200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec3ToVec3Identity (12100 ns)
    TCS: [33mTestCase_testCastVec3Vec4ToVec3TakesOnlyXYZ[0m, time elapsed: 176500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec4ToVec3TakesOnlyXYZ (12700 ns)
    TCS: [33mTestCase_testCastVec3SameTypeIdentity[0m, time elapsed: 177700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3SameTypeIdentity (7500 ns)
    TCS: [33mTestCase_testCastVec3Int32ToInt64[0m, time elapsed: 171100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Int32ToInt64 (8400 ns)
    TCS: [33mTestCase_testCastVec3FloatToIntTruncation[0m, time elapsed: 172700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3FloatToIntTruncation (7800 ns)
    TCS: [33mTestCase_testCastVec3CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 173000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3CrossQualifierPackedHighpToDefaultp (6700 ns)
    TCS: [33mTestCase_testCastVec3DoesNotModifySource[0m, time elapsed: 186300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3DoesNotModifySource (7200 ns)
    TCS: [33mTestCase_testCastVec3Vec1ToVec3SameValueAllComponents[0m, time elapsed: 177000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec1ToVec3SameValueAllComponents (11000 ns)
    TCS: [33mTestCase_testCastVec4Vec1ToVec4IntToFloat[0m, time elapsed: 179600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec1ToVec4IntToFloat (13400 ns)
    TCS: [33mTestCase_testCastVec4Vec2ToVec4ExtendY[0m, time elapsed: 176400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec2ToVec4ExtendY (10800 ns)
    TCS: [33mTestCase_testCastVec4Vec3ToVec4ExtendZ[0m, time elapsed: 181900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec3ToVec4ExtendZ (10500 ns)
    TCS: [33mTestCase_testCastVec4Vec4ToVec4Identity[0m, time elapsed: 173300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec4ToVec4Identity (9300 ns)
    TCS: [33mTestCase_testCastVec4SameTypeIdentity[0m, time elapsed: 165200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4SameTypeIdentity (9300 ns)
    TCS: [33mTestCase_testCastVec4Int32ToInt64[0m, time elapsed: 168100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Int32ToInt64 (7500 ns)
    TCS: [33mTestCase_testCastVec4FloatToIntTruncation[0m, time elapsed: 171700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4FloatToIntTruncation (7700 ns)
    TCS: [33mTestCase_testCastVec4CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 171500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4CrossQualifierPackedHighpToDefaultp (7100 ns)
    TCS: [33mTestCase_testCastVec4DoesNotModifySource[0m, time elapsed: 169600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4DoesNotModifySource (7100 ns)
    TCS: [33mTestCase_testCastVec4Vec1ToVec4SameValueAllComponents[0m, time elapsed: 173900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec1ToVec4SameValueAllComponents (10300 ns)
    TCS: [33mTestCase_testFromBoolVec1[0m, time elapsed: 207400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec1 (13300 ns)
    TCS: [33mTestCase_testFromBoolVec1False[0m, time elapsed: 179100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec1False (6400 ns)
    TCS: [33mTestCase_testFromBoolVec2[0m, time elapsed: 250400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec2 (10600 ns)
    TCS: [33mTestCase_testFromBoolVec3[0m, time elapsed: 357200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec3 (23000 ns)
    TCS: [33mTestCase_testFromBoolVec4[0m, time elapsed: 349000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec4 (22200 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec1[0m, time elapsed: 210100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec1 (12600 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec2[0m, time elapsed: 201700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec2 (11900 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec3[0m, time elapsed: 181900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec3 (6800 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec4[0m, time elapsed: 197500 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec4 (10600 ns)
    TCS: [33mTestCase_testFromBoolVec3AllFalse[0m, time elapsed: 189800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec3AllFalse (6900 ns)
    TCS: [33mTestCase_testFromBoolVec4AllFalse[0m, time elapsed: 179000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec4AllFalse (9200 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec3AllFalse[0m, time elapsed: 181100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec3AllFalse (6600 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec4AllFalse[0m, time elapsed: 179400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec4AllFalse (6300 ns)
    TCS: [33mTestCase_testFromBoolVecFloat32[0m, time elapsed: 172200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecFloat32 (8300 ns)
    TCS: [33mTestCase_testFromBoolVecFloat64[0m, time elapsed: 212600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecFloat64 (9200 ns)
    TCS: [33mTestCase_testFromBoolVecInt32[0m, time elapsed: 182500 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecInt32 (9400 ns)
    TCS: [33mTestCase_testFromBoolVecQ2PackedMediump[0m, time elapsed: 180600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2PackedMediump (11600 ns)
    TCS: [33mTestCase_testFromBoolVecQ2PackedLowp[0m, time elapsed: 182900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2PackedLowp (10400 ns)
    TCS: [33mTestCase_testS1QuatCastScalingXBranch[0m, time elapsed: 267300 ns, RESULT:
    [[32m PASSED [0m] CASE: testS1QuatCastScalingXBranch (62600 ns)
    TCS: [33mTestCase_testS1QuatCastScalingYBranch[0m, time elapsed: 190900 ns, RESULT:
    [[32m PASSED [0m] CASE: testS1QuatCastScalingYBranch (17800 ns)
    TCS: [33mTestCase_testS1QuatCastScalingZBranch[0m, time elapsed: 186800 ns, RESULT:
    [[32m PASSED [0m] CASE: testS1QuatCastScalingZBranch (18100 ns)
    TCS: [33mTestCase_testS1QuatCastScalingWBranch[0m, time elapsed: 187500 ns, RESULT:
    [[32m PASSED [0m] CASE: testS1QuatCastScalingWBranch (15700 ns)
    TCS: [33mTestCase_testS1QuatCastUnitRoundTrip[0m, time elapsed: 193000 ns, RESULT:
    [[32m PASSED [0m] CASE: testS1QuatCastUnitRoundTrip (19700 ns)
    TCS: [33mTestCase_testS1QuatCastIdentityRoundTrip[0m, time elapsed: 192200 ns, RESULT:
    [[32m PASSED [0m] CASE: testS1QuatCastIdentityRoundTrip (12200 ns)
    TCS: [33mTestCase_testS1QuatCastMat4Delegation[0m, time elapsed: 206800 ns, RESULT:
    [[32m PASSED [0m] CASE: testS1QuatCastMat4Delegation (34300 ns)
    TCS: [33mTestCase_testMat3EqualEpsilonRelaxedExactMatch[0m, time elapsed: 178600 ns, RESULT:
    [[32m PASSED [0m] CASE: testMat3EqualEpsilonRelaxedExactMatch (7200 ns)
    TCS: [33mTestCase_testMat3EqualEpsilonRelaxedWithinPosTolerance[0m, time elapsed: 179000 ns, RESULT:
    [[32m PASSED [0m] CASE: testMat3EqualEpsilonRelaxedWithinPosTolerance (7500 ns)
    TCS: [33mTestCase_testMat3EqualEpsilonRelaxedWithinNegTolerance[0m, time elapsed: 178300 ns, RESULT:
    [[32m PASSED [0m] CASE: testMat3EqualEpsilonRelaxedWithinNegTolerance (7100 ns)
    TCS: [33mTestCase_testMat3EqualEpsilonRelaxedBeyondTolerance[0m, time elapsed: 172200 ns, RESULT:
    [[32m PASSED [0m] CASE: testMat3EqualEpsilonRelaxedBeyondTolerance (6400 ns)
    TCS: [33mTestCase_testMat3EqualEpsilonRelaxedZeroMatrix[0m, time elapsed: 172500 ns, RESULT:
    [[32m PASSED [0m] CASE: testMat3EqualEpsilonRelaxedZeroMatrix (9400 ns)
    TCS: [33mTestCase_testMat3EqualEpsilonRelaxedSingleDiffBeyond[0m, time elapsed: 183500 ns, RESULT:
    [[32m PASSED [0m] CASE: testMat3EqualEpsilonRelaxedSingleDiffBeyond (6500 ns)
    TCS: [33mTestCase_testVec2ScalarInit[0m, time elapsed: 247800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarInit (17500 ns)
    TCS: [33mTestCase_testVec2ConstInit[0m, time elapsed: 282200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ConstInit (9800 ns)
    TCS: [33mTestCase_testVec2Length[0m, time elapsed: 200800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Length (7300 ns)
    TCS: [33mTestCase_testVec2Add[0m, time elapsed: 283700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Add (23300 ns)
    TCS: [33mTestCase_testVec2Sub[0m, time elapsed: 184000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Sub (10800 ns)
    TCS: [33mTestCase_testVec2Mul[0m, time elapsed: 277200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Mul (17300 ns)
    TCS: [33mTestCase_testVec2ScalarAdd[0m, time elapsed: 178500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarAdd (11300 ns)
    TCS: [33mTestCase_testVec2Negate[0m, time elapsed: 173700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Negate (8700 ns)
    TCS: [33mTestCase_testVec2IndexAccess[0m, time elapsed: 170300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2IndexAccess (6600 ns)
    TCS: [33mTestCase_testVec2IndexMutate[0m, time elapsed: 177200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2IndexMutate (12900 ns)
    TCS: [33mTestCase_testVec2ComponentAt[0m, time elapsed: 169800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ComponentAt (8100 ns)
    TCS: [33mTestCase_testVec2Equal[0m, time elapsed: 180600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Equal (14200 ns)
    TCS: [33mTestCase_testVec2NotEqual[0m, time elapsed: 166400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2NotEqual (10000 ns)
    TCS: [33mTestCase_testVec2EqualExact[0m, time elapsed: 193300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2EqualExact (10300 ns)
    TCS: [33mTestCase_testVec2BitwiseAnd[0m, time elapsed: 178300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseAnd (16700 ns)
    TCS: [33mTestCase_testVec2BitwiseNot[0m, time elapsed: 171300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseNot (8800 ns)
    TCS: [33mTestCase_testVec2FromVec1[0m, time elapsed: 167100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2FromVec1 (7100 ns)
    TCS: [33mTestCase_testVec2ShiftLeft[0m, time elapsed: 185300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeft (11000 ns)
    TCS: [33mTestCase_testVec2BoolLogicalAnd[0m, time elapsed: 171100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BoolLogicalAnd (8700 ns)
    TCS: [33mTestCase_testVec2Vec1ArithBroadcast[0m, time elapsed: 178600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Vec1ArithBroadcast (11600 ns)
    TCS: [33mTestCase_testVec2Vec1BitBroadcast[0m, time elapsed: 210100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Vec1BitBroadcast (10900 ns)
    TCS: [33mTestCase_testVec2ShiftLeftVec1[0m, time elapsed: 185300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeftVec1 (9900 ns)
    TCS: [33mTestCase_testVec2Div[0m, time elapsed: 180000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Div (9200 ns)
    TCS: [33mTestCase_testVec2Mod[0m, time elapsed: 190500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Mod (9100 ns)
    TCS: [33mTestCase_testVec2ScalarSub[0m, time elapsed: 212000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarSub (10500 ns)
    TCS: [33mTestCase_testVec2ScalarMul[0m, time elapsed: 196800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarMul (9700 ns)
    TCS: [33mTestCase_testVec2ScalarDiv[0m, time elapsed: 191400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarDiv (13100 ns)
    TCS: [33mTestCase_testVec2ScalarMod[0m, time elapsed: 277200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarMod (10100 ns)
    TCS: [33mTestCase_testVec2BoolLogicalOr[0m, time elapsed: 183100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BoolLogicalOr (6600 ns)
    TCS: [33mTestCase_testVec2EqualEpsilon[0m, time elapsed: 312400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2EqualEpsilon (21400 ns)
    TCS: [33mTestCase_testVec2DivNamed[0m, time elapsed: 345600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2DivNamed (13900 ns)
    TCS: [33mTestCase_testVec2ModNamed[0m, time elapsed: 230100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ModNamed (13600 ns)
    TCS: [33mTestCase_testVec2BitwiseOr[0m, time elapsed: 197300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseOr (15400 ns)
    TCS: [33mTestCase_testVec2BitwiseXor[0m, time elapsed: 224400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseXor (18100 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseAnd[0m, time elapsed: 191500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseAnd (11000 ns)
    TCS: [33mTestCase_testVec2ShiftRight[0m, time elapsed: 184600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRight (8900 ns)
    TCS: [33mTestCase_testVec2ShiftRightVec1[0m, time elapsed: 198600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRightVec1 (9100 ns)
    TCS: [33mTestCase_testVec2AddNamed[0m, time elapsed: 183300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2AddNamed (10900 ns)
    TCS: [33mTestCase_testVec2SubNamed[0m, time elapsed: 174100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2SubNamed (6600 ns)
    TCS: [33mTestCase_testVec2MulNamed[0m, time elapsed: 174300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2MulNamed (7000 ns)
    TCS: [33mTestCase_testVec2ShiftLeftVec[0m, time elapsed: 184400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeftVec (6300 ns)
    TCS: [33mTestCase_testVec2ShiftRightVec[0m, time elapsed: 218200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRightVec (6500 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseOr[0m, time elapsed: 183800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseOr (16500 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseXor[0m, time elapsed: 178400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseXor (8100 ns)
    TCS: [33mTestCase_testVec2Increment[0m, time elapsed: 189400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Increment (11800 ns)
    TCS: [33mTestCase_testVec2Decrement[0m, time elapsed: 188300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Decrement (10800 ns)
    TCS: [33mTestCase_testVec2IndexOutOfBoundsAccess[0m, time elapsed: 254200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2IndexOutOfBoundsAccess (51900 ns)
    TCS: [33mTestCase_testVec2NegativeIndexAccess[0m, time elapsed: 193100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2NegativeIndexAccess (23600 ns)
    TCS: [33mTestCase_testVec3ScalarInit[0m, time elapsed: 179500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarInit (9100 ns)
    TCS: [33mTestCase_testVec3ConstInit[0m, time elapsed: 172100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ConstInit (5800 ns)
    TCS: [33mTestCase_testVec3Length[0m, time elapsed: 169700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Length (6200 ns)
    TCS: [33mTestCase_testVec3Add[0m, time elapsed: 182200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Add (13400 ns)
    TCS: [33mTestCase_testVec3ScalarMul[0m, time elapsed: 179900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarMul (10300 ns)
    TCS: [33mTestCase_testVec3Negate[0m, time elapsed: 177300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Negate (12400 ns)
    TCS: [33mTestCase_testVec3IndexAccess[0m, time elapsed: 175700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3IndexAccess (9500 ns)
    TCS: [33mTestCase_testVec3IndexMutate[0m, time elapsed: 224300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3IndexMutate (5800 ns)
    TCS: [33mTestCase_testVec3ComponentAt[0m, time elapsed: 176500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ComponentAt (6800 ns)
    TCS: [33mTestCase_testVec3Equal[0m, time elapsed: 193200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Equal (16900 ns)
    TCS: [33mTestCase_testVec3NotEqual[0m, time elapsed: 264300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3NotEqual (14000 ns)
    TCS: [33mTestCase_testVec3EqualExact[0m, time elapsed: 290500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3EqualExact (68900 ns)
    TCS: [33mTestCase_testVec3BitwiseAnd[0m, time elapsed: 370700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseAnd (31300 ns)
    TCS: [33mTestCase_testVec3BitwiseNot[0m, time elapsed: 267400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseNot (14400 ns)
    TCS: [33mTestCase_testVec3Vec1ArithBroadcast[0m, time elapsed: 287700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1ArithBroadcast (21400 ns)
    TCS: [33mTestCase_testVec3ShiftLeft[0m, time elapsed: 266800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeft (17900 ns)
    TCS: [33mTestCase_testVec3BoolLogicalAnd[0m, time elapsed: 275600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BoolLogicalAnd (21400 ns)
    TCS: [33mTestCase_testVec3Sub[0m, time elapsed: 274700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Sub (17300 ns)
    TCS: [33mTestCase_testVec3Div[0m, time elapsed: 277400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Div (17200 ns)
    TCS: [33mTestCase_testVec3Mod[0m, time elapsed: 302000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Mod (16200 ns)
    TCS: [33mTestCase_testVec3ScalarSub[0m, time elapsed: 276800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarSub (16700 ns)
    TCS: [33mTestCase_testVec3ScalarDiv[0m, time elapsed: 275900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarDiv (16900 ns)
    TCS: [33mTestCase_testVec3ScalarMod[0m, time elapsed: 285400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarMod (20100 ns)
    TCS: [33mTestCase_testVec3BoolLogicalOr[0m, time elapsed: 273600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BoolLogicalOr (13600 ns)
    TCS: [33mTestCase_testVec3EqualEpsilon[0m, time elapsed: 274900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3EqualEpsilon (21300 ns)
    TCS: [33mTestCase_testVec3AddNamed[0m, time elapsed: 283600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3AddNamed (45000 ns)
    TCS: [33mTestCase_testVec3MulNamed[0m, time elapsed: 180000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3MulNamed (7200 ns)
    TCS: [33mTestCase_testVec3DivNamed[0m, time elapsed: 165700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3DivNamed (9600 ns)
    TCS: [33mTestCase_testVec3ModNamed[0m, time elapsed: 165200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ModNamed (6300 ns)
    TCS: [33mTestCase_testVec3BitwiseOr[0m, time elapsed: 179700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseOr (12500 ns)
    TCS: [33mTestCase_testVec3BitwiseXor[0m, time elapsed: 180000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseXor (12000 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseAnd[0m, time elapsed: 178500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseAnd (11000 ns)
    TCS: [33mTestCase_testVec3ShiftRight[0m, time elapsed: 240500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRight (12300 ns)
    TCS: [33mTestCase_testVec3Vec1BitBroadcast[0m, time elapsed: 259600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitBroadcast (26300 ns)
    TCS: [33mTestCase_testVec3ShiftRightVec1[0m, time elapsed: 278800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRightVec1 (18400 ns)
    TCS: [33mTestCase_testVec3FromVec1[0m, time elapsed: 238000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3FromVec1 (10700 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseOr[0m, time elapsed: 195700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseOr (12400 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseXor[0m, time elapsed: 280000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseXor (19300 ns)
    TCS: [33mTestCase_testVec3Vec1BitOrBroadcast[0m, time elapsed: 201500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitOrBroadcast (18100 ns)
    TCS: [33mTestCase_testVec3Vec1BitXorBroadcast[0m, time elapsed: 196600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitXorBroadcast (10600 ns)
    TCS: [33mTestCase_testVec3ShiftLeftVec1[0m, time elapsed: 243200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeftVec1 (14200 ns)
    TCS: [33mTestCase_testVec3ShiftLeftVec[0m, time elapsed: 215600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeftVec (12200 ns)
    TCS: [33mTestCase_testVec3ShiftRightVec[0m, time elapsed: 218400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRightVec (12800 ns)
    TCS: [33mTestCase_testVec3Increment[0m, time elapsed: 216900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Increment (16100 ns)
    TCS: [33mTestCase_testVec3Decrement[0m, time elapsed: 216400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Decrement (19000 ns)
    TCS: [33mTestCase_testVec3IndexOutOfBoundsAccess[0m, time elapsed: 262800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3IndexOutOfBoundsAccess (50000 ns)
    TCS: [33mTestCase_testVec3NegativeIndexAccess[0m, time elapsed: 226200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3NegativeIndexAccess (20700 ns)
    TCS: [33mTestCase_testVec4ScalarInit[0m, time elapsed: 225400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarInit (13700 ns)
    TCS: [33mTestCase_testVec4ConstInit[0m, time elapsed: 214100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ConstInit (35000 ns)
    TCS: [33mTestCase_testVec4Length[0m, time elapsed: 180300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Length (5400 ns)
    TCS: [33mTestCase_testVec4Add[0m, time elapsed: 193700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Add (14200 ns)
    TCS: [33mTestCase_testVec4ScalarMul[0m, time elapsed: 187500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarMul (11200 ns)
    TCS: [33mTestCase_testVec4Negate[0m, time elapsed: 176700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Negate (9800 ns)
    TCS: [33mTestCase_testVec4IndexAccess[0m, time elapsed: 180700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4IndexAccess (9500 ns)
    TCS: [33mTestCase_testVec4IndexMutate[0m, time elapsed: 179000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4IndexMutate (5500 ns)
    TCS: [33mTestCase_testVec4ComponentAt[0m, time elapsed: 183600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ComponentAt (10500 ns)
    TCS: [33mTestCase_testVec4Equal[0m, time elapsed: 190700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Equal (14400 ns)
    TCS: [33mTestCase_testVec4NotEqual[0m, time elapsed: 242900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4NotEqual (10100 ns)
    TCS: [33mTestCase_testVec4EqualExact[0m, time elapsed: 203700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4EqualExact (14700 ns)
    TCS: [33mTestCase_testVec4BitwiseAnd[0m, time elapsed: 258400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseAnd (23900 ns)
    TCS: [33mTestCase_testVec4BitwiseNot[0m, time elapsed: 203400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseNot (12600 ns)
    TCS: [33mTestCase_testVec4Vec1ArithBroadcast[0m, time elapsed: 242500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1ArithBroadcast (19500 ns)
    TCS: [33mTestCase_testVec4ShiftLeft[0m, time elapsed: 238700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeft (17800 ns)
    TCS: [33mTestCase_testVec4BoolLogicalAnd[0m, time elapsed: 209400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BoolLogicalAnd (15300 ns)
    TCS: [33mTestCase_testVec4Sub[0m, time elapsed: 195900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Sub (15300 ns)
    TCS: [33mTestCase_testVec4Div[0m, time elapsed: 212000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Div (13600 ns)
    TCS: [33mTestCase_testVec4Mod[0m, time elapsed: 197000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Mod (19500 ns)
    TCS: [33mTestCase_testVec4ScalarSub[0m, time elapsed: 194200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarSub (10200 ns)
    TCS: [33mTestCase_testVec4ScalarDiv[0m, time elapsed: 200500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarDiv (13200 ns)
    TCS: [33mTestCase_testVec4ScalarMod[0m, time elapsed: 184000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarMod (9400 ns)
    TCS: [33mTestCase_testVec4BoolLogicalOr[0m, time elapsed: 181000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BoolLogicalOr (7300 ns)
    TCS: [33mTestCase_testVec4EqualEpsilon[0m, time elapsed: 191600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4EqualEpsilon (21200 ns)
    TCS: [33mTestCase_testVec4AddNamed[0m, time elapsed: 217400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4AddNamed (12800 ns)
    TCS: [33mTestCase_testVec4MulNamed[0m, time elapsed: 180900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4MulNamed (9400 ns)
    TCS: [33mTestCase_testVec4DivNamed[0m, time elapsed: 178200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4DivNamed (6700 ns)
    TCS: [33mTestCase_testVec4ModNamed[0m, time elapsed: 181100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ModNamed (7000 ns)
    TCS: [33mTestCase_testVec4BitwiseOr[0m, time elapsed: 187600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseOr (13100 ns)
    TCS: [33mTestCase_testVec4BitwiseXor[0m, time elapsed: 211000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseXor (44300 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseAnd[0m, time elapsed: 248800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseAnd (10900 ns)
    TCS: [33mTestCase_testVec4ShiftRight[0m, time elapsed: 180700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRight (10000 ns)
    TCS: [33mTestCase_testVec4Vec1BitBroadcast[0m, time elapsed: 181900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitBroadcast (12300 ns)
    TCS: [33mTestCase_testVec4ShiftRightVec1[0m, time elapsed: 175800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRightVec1 (9800 ns)
    TCS: [33mTestCase_testVec4FromVec1[0m, time elapsed: 181500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4FromVec1 (6700 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseOr[0m, time elapsed: 180200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseOr (11500 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseXor[0m, time elapsed: 175000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseXor (9900 ns)
    TCS: [33mTestCase_testVec4Vec1BitOrBroadcast[0m, time elapsed: 178600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitOrBroadcast (10800 ns)
    TCS: [33mTestCase_testVec4Vec1BitXorBroadcast[0m, time elapsed: 196600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitXorBroadcast (12700 ns)
    TCS: [33mTestCase_testVec4ShiftLeftVec1[0m, time elapsed: 181500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeftVec1 (9400 ns)
    TCS: [33mTestCase_testVec4ShiftLeftVec[0m, time elapsed: 275700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeftVec (17600 ns)
    TCS: [33mTestCase_testVec4ShiftRightVec[0m, time elapsed: 365600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRightVec (17800 ns)
    TCS: [33mTestCase_testVec4Increment[0m, time elapsed: 307100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Increment (37300 ns)
    TCS: [33mTestCase_testVec4Decrement[0m, time elapsed: 217000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Decrement (18100 ns)
    TCS: [33mTestCase_testVec4IndexOutOfBoundsAccess[0m, time elapsed: 263800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4IndexOutOfBoundsAccess (88400 ns)
    TCS: [33mTestCase_testVec4NegativeIndexAccess[0m, time elapsed: 247500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4NegativeIndexAccess (18200 ns)
    TCS: [33mTestCase_testFunctor1Vec1Identity[0m, time elapsed: 194800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec1Identity (7800 ns)
    TCS: [33mTestCase_testFunctor1Vec1Transform[0m, time elapsed: 171400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec1Transform (6800 ns)
    TCS: [33mTestCase_testFunctor1Vec2Transform[0m, time elapsed: 179700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec2Transform (7400 ns)
    TCS: [33mTestCase_testFunctor2Vec1Add[0m, time elapsed: 172100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec1Add (6600 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec1Mul[0m, time elapsed: 178900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec1Mul (16000 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec1Shift[0m, time elapsed: 173000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec1Shift (8600 ns)
    TCS: [33mTestCase_testFunctor1Vec3Transform[0m, time elapsed: 168200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec3Transform (7700 ns)
    TCS: [33mTestCase_testFunctor1Vec4Transform[0m, time elapsed: 193200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec4Transform (8100 ns)
    TCS: [33mTestCase_testFunctor2Vec2Add[0m, time elapsed: 182000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec2Add (6700 ns)
    TCS: [33mTestCase_testFunctor2Vec3Add[0m, time elapsed: 172500 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec3Add (11200 ns)
    TCS: [33mTestCase_testFunctor2Vec4Add[0m, time elapsed: 170400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec4Add (7200 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec2Mul[0m, time elapsed: 175900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec2Mul (9500 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec3Mul[0m, time elapsed: 172700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec3Mul (6900 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec4Mul[0m, time elapsed: 173200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec4Mul (6800 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec2Shift[0m, time elapsed: 179600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec2Shift (9400 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec3Shift[0m, time elapsed: 172000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec3Shift (6300 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec4Shift[0m, time elapsed: 271300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec4Shift (7900 ns)
Summary: TOTAL: 435
    [32mPASSED[0m: 435, [32mSKIPPED[0m: 0, ERROR: 0
    [31mFAILED[0m: 0
--------------------------------------------------------------------------------------------------
Project tests finished, time elapsed: 155677900 ns, RESULT:
TP: [33mglm[0m.*, time elapsed: 155604900 ns, RESULT:
    PASSED:
    TP: [33mglm.detail[0m, time elapsed: 140787300 ns
Summary: TOTAL: 435
    [32mPASSED[0m: 435, [32mSKIPPED[0m: 0, ERROR: 0
    [31mFAILED[0m: 0
--------------------------------------------------------------------------------------------------
[0J7[;r8[?25hcjpm test success
