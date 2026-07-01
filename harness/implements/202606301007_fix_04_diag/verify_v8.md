# 验证报告（v8）

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
TP: [33mglm.detail[0m, time elapsed: 144967800 ns, RESULT:
    TCS: [33mTestCase_testComputeVecAdd1[0m, time elapsed: 1219800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAdd1 (254900 ns)
    TCS: [33mTestCase_testComputeVecSub2[0m, time elapsed: 441400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub2 (50000 ns)
    TCS: [33mTestCase_testComputeVecMul3[0m, time elapsed: 397100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul3 (41300 ns)
    TCS: [33mTestCase_testComputeVecMod1[0m, time elapsed: 308900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMod1 (26100 ns)
    TCS: [33mTestCase_testComputeVecMod4[0m, time elapsed: 266000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMod4 (24400 ns)
    TCS: [33mTestCase_testComputeVecAnd1[0m, time elapsed: 260700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAnd1 (25500 ns)
    TCS: [33mTestCase_testComputeVecAnd3[0m, time elapsed: 242900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAnd3 (18500 ns)
    TCS: [33mTestCase_testComputeVecOr1[0m, time elapsed: 312700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecOr1 (19900 ns)
    TCS: [33mTestCase_testComputeVecOr2[0m, time elapsed: 262500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecOr2 (18400 ns)
    TCS: [33mTestCase_testComputeVecXor1[0m, time elapsed: 294900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecXor1 (54500 ns)
    TCS: [33mTestCase_testComputeVecXor4[0m, time elapsed: 254500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecXor4 (24000 ns)
    TCS: [33mTestCase_testComputeVecShiftLeft1[0m, time elapsed: 229600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftLeft1 (14300 ns)
    TCS: [33mTestCase_testComputeVecShiftLeft3[0m, time elapsed: 237700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftLeft3 (14400 ns)
    TCS: [33mTestCase_testComputeVecShiftRight1[0m, time elapsed: 239600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftRight1 (18600 ns)
    TCS: [33mTestCase_testComputeVecShiftRight4[0m, time elapsed: 229900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftRight4 (14000 ns)
    TCS: [33mTestCase_testComputeVecEqual1[0m, time elapsed: 230900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual1 (17500 ns)
    TCS: [33mTestCase_testComputeVecNequal4[0m, time elapsed: 238000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal4 (14300 ns)
    TCS: [33mTestCase_testComputeVecBitwiseNot1[0m, time elapsed: 248300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecBitwiseNot1 (29500 ns)
    TCS: [33mTestCase_testComputeVecBitwiseNot3[0m, time elapsed: 299300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecBitwiseNot3 (47100 ns)
    TCS: [33mTestCase_testComputeVecAdd4[0m, time elapsed: 236800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAdd4 (18000 ns)
    TCS: [33mTestCase_testComputeVecSub1[0m, time elapsed: 864600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub1 (23500 ns)
    TCS: [33mTestCase_testComputeVecSub3[0m, time elapsed: 319100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub3 (28800 ns)
    TCS: [33mTestCase_testComputeVecMul1[0m, time elapsed: 379500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul1 (28600 ns)
    TCS: [33mTestCase_testComputeVecMul2[0m, time elapsed: 391200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul2 (31600 ns)
    TCS: [33mTestCase_testComputeVecDiv1[0m, time elapsed: 424500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecDiv1 (33800 ns)
    TCS: [33mTestCase_testComputeVecDiv2[0m, time elapsed: 303900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecDiv2 (27600 ns)
    TCS: [33mTestCase_testComputeVecDiv4[0m, time elapsed: 284900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecDiv4 (27100 ns)
    TCS: [33mTestCase_testComputeVecEqual2[0m, time elapsed: 268500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual2 (18300 ns)
    TCS: [33mTestCase_testComputeVecEqual3[0m, time elapsed: 290500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual3 (23200 ns)
    TCS: [33mTestCase_testComputeVecEqual4[0m, time elapsed: 300800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual4 (19300 ns)
    TCS: [33mTestCase_testComputeVecNequal1[0m, time elapsed: 264600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal1 (19400 ns)
    TCS: [33mTestCase_testComputeVecNequal2[0m, time elapsed: 658500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal2 (18700 ns)
    TCS: [33mTestCase_testComputeVecBitwiseNot4[0m, time elapsed: 313800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecBitwiseNot4 (29800 ns)
    TCS: [33mTestCase_testComputeVecAddFloat32[0m, time elapsed: 307800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAddFloat32 (35600 ns)
    TCS: [33mTestCase_testComputeVecAddFloat32Vec3[0m, time elapsed: 328200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAddFloat32Vec3 (43400 ns)
    TCS: [33mTestCase_testComputeVecSubFloat32[0m, time elapsed: 300400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSubFloat32 (24800 ns)
    TCS: [33mTestCase_testComputeVecSubFloat32Vec4[0m, time elapsed: 342000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSubFloat32Vec4 (39400 ns)
    TCS: [33mTestCase_testComputeEqualInt32Equal[0m, time elapsed: 374200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt32Equal (30600 ns)
    TCS: [33mTestCase_testComputeEqualInt32NotEqual[0m, time elapsed: 356400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt32NotEqual (25500 ns)
    TCS: [33mTestCase_testComputeEqualFloat32Equal[0m, time elapsed: 352000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32Equal (25300 ns)
    TCS: [33mTestCase_testComputeEqualFloat32NotEqual[0m, time elapsed: 384800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32NotEqual (26100 ns)
    TCS: [33mTestCase_testComputeEqualFloat64Equal[0m, time elapsed: 335000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64Equal (16000 ns)
    TCS: [33mTestCase_testComputeEqualFloat64NotEqual[0m, time elapsed: 300100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64NotEqual (11900 ns)
    TCS: [33mTestCase_testComputeEqualBoolEqual[0m, time elapsed: 319800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualBoolEqual (13000 ns)
    TCS: [33mTestCase_testComputeEqualBoolNotEqual[0m, time elapsed: 203800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualBoolNotEqual (12300 ns)
    TCS: [33mTestCase_testComputeEqualNumericInt32[0m, time elapsed: 205900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericInt32 (14100 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32[0m, time elapsed: 220800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32 (32800 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32Epsilon[0m, time elapsed: 196100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32Epsilon (15400 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64[0m, time elapsed: 205200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64 (22700 ns)
    TCS: [33mTestCase_testComputeEqualInt64Equal[0m, time elapsed: 207200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt64Equal (11700 ns)
    TCS: [33mTestCase_testComputeEqualInt64NotEqual[0m, time elapsed: 203400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt64NotEqual (9600 ns)
    TCS: [33mTestCase_testComputeEqualFloat32Nan[0m, time elapsed: 198600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32Nan (8900 ns)
    TCS: [33mTestCase_testComputeEqualFloat64Nan[0m, time elapsed: 277100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64Nan (8700 ns)
    TCS: [33mTestCase_testComputeEqualFloat32SignedZero[0m, time elapsed: 266900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32SignedZero (16000 ns)
    TCS: [33mTestCase_testComputeEqualFloat64SignedZero[0m, time elapsed: 253900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64SignedZero (14600 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32NotEqual[0m, time elapsed: 216600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32NotEqual (12300 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32BeyondEpsilon[0m, time elapsed: 209000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32BeyondEpsilon (14900 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64NotEqual[0m, time elapsed: 217000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64NotEqual (14900 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64Epsilon[0m, time elapsed: 215800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64Epsilon (11200 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64BeyondEpsilon[0m, time elapsed: 202900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64BeyondEpsilon (10900 ns)
    TCS: [33mTestCase_testComputeEqualNumericInt64[0m, time elapsed: 206200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericInt64 (11800 ns)
    TCS: [33mTestCase_testPackedHighpImplementsQualifier[0m, time elapsed: 219300 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedHighpImplementsQualifier (12500 ns)
    TCS: [33mTestCase_testPackedMediumpImplementsQualifier[0m, time elapsed: 195600 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedMediumpImplementsQualifier (7700 ns)
    TCS: [33mTestCase_testPackedLowpImplementsQualifier[0m, time elapsed: 194300 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedLowpImplementsQualifier (7600 ns)
    TCS: [33mTestCase_testDefaultpIsPackedHighp[0m, time elapsed: 177400 ns, RESULT:
    [[32m PASSED [0m] CASE: testDefaultpIsPackedHighp (8500 ns)
    TCS: [33mTestCase_testScalarAddVec1[0m, time elapsed: 199300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec1 (14000 ns)
    TCS: [33mTestCase_testScalarAddVec2[0m, time elapsed: 190600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec2 (12000 ns)
    TCS: [33mTestCase_testScalarAddVec3[0m, time elapsed: 184600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec3 (14900 ns)
    TCS: [33mTestCase_testScalarAddVec4[0m, time elapsed: 183100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec4 (12000 ns)
    TCS: [33mTestCase_testScalarSubVec1[0m, time elapsed: 191000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1 (12300 ns)
    TCS: [33mTestCase_testScalarMulVec1[0m, time elapsed: 187800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1 (12600 ns)
    TCS: [33mTestCase_testScalarDivVec1[0m, time elapsed: 185600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1 (10300 ns)
    TCS: [33mTestCase_testScalarModVec1[0m, time elapsed: 270100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1 (39600 ns)
    TCS: [33mTestCase_testScalarMulVec2[0m, time elapsed: 291700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2 (22000 ns)
    TCS: [33mTestCase_testScalarSubVec2[0m, time elapsed: 313800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2 (25900 ns)
    TCS: [33mTestCase_testScalarSubVec3[0m, time elapsed: 292200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3 (26000 ns)
    TCS: [33mTestCase_testScalarSubVec4[0m, time elapsed: 332000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4 (22800 ns)
    TCS: [33mTestCase_testScalarMulVec3[0m, time elapsed: 365400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3 (22600 ns)
    TCS: [33mTestCase_testScalarMulVec4[0m, time elapsed: 339100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4 (34700 ns)
    TCS: [33mTestCase_testScalarDivVec2[0m, time elapsed: 185700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2 (10000 ns)
    TCS: [33mTestCase_testScalarDivVec3[0m, time elapsed: 188100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3 (11300 ns)
    TCS: [33mTestCase_testScalarDivVec4[0m, time elapsed: 186000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4 (11800 ns)
    TCS: [33mTestCase_testScalarModVec2[0m, time elapsed: 205100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2 (10400 ns)
    TCS: [33mTestCase_testScalarModVec3[0m, time elapsed: 278700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3 (14200 ns)
    TCS: [33mTestCase_testScalarModVec4[0m, time elapsed: 222300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4 (21500 ns)
    TCS: [33mTestCase_testScalarModVec1Float32[0m, time elapsed: 225500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float32 (23000 ns)
    TCS: [33mTestCase_testScalarModVec2Float32[0m, time elapsed: 190600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32 (11600 ns)
    TCS: [33mTestCase_testScalarModVec3Float32[0m, time elapsed: 188900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float32 (9000 ns)
    TCS: [33mTestCase_testScalarModVec4Float32[0m, time elapsed: 205100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float32 (12500 ns)
    TCS: [33mTestCase_testScalarModVec1Float64[0m, time elapsed: 212400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float64 (17300 ns)
    TCS: [33mTestCase_testScalarModVec2Float64[0m, time elapsed: 216000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float64 (11900 ns)
    TCS: [33mTestCase_testScalarModVec3Float64[0m, time elapsed: 226300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float64 (10400 ns)
    TCS: [33mTestCase_testScalarModVec4Float64[0m, time elapsed: 202900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float64 (10200 ns)
    TCS: [33mTestCase_testScalarModVec1Float16[0m, time elapsed: 219000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float16 (26600 ns)
    TCS: [33mTestCase_testScalarModVec2Float16[0m, time elapsed: 206200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float16 (9900 ns)
    TCS: [33mTestCase_testScalarModVec3Float16[0m, time elapsed: 212200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float16 (13800 ns)
    TCS: [33mTestCase_testScalarModVec4Float16[0m, time elapsed: 192200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float16 (9700 ns)
    TCS: [33mTestCase_testScalarSubVec2PackedMediump[0m, time elapsed: 198000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2PackedMediump (14900 ns)
    TCS: [33mTestCase_testScalarSubVec2PackedLowp[0m, time elapsed: 254300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2PackedLowp (11200 ns)
    TCS: [33mTestCase_testScalarMulVec2PackedMediump[0m, time elapsed: 200800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2PackedMediump (10900 ns)
    TCS: [33mTestCase_testScalarMulVec2PackedLowp[0m, time elapsed: 187000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2PackedLowp (10000 ns)
    TCS: [33mTestCase_testScalarDivVec2PackedMediump[0m, time elapsed: 193700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2PackedMediump (10700 ns)
    TCS: [33mTestCase_testScalarDivVec2PackedLowp[0m, time elapsed: 201900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2PackedLowp (12300 ns)
    TCS: [33mTestCase_testScalarModVec2PackedMediump[0m, time elapsed: 241600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2PackedMediump (11600 ns)
    TCS: [33mTestCase_testScalarModVec2PackedLowp[0m, time elapsed: 189900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2PackedLowp (10000 ns)
    TCS: [33mTestCase_testScalarModVec2Float32PackedMediump[0m, time elapsed: 194500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32PackedMediump (13900 ns)
    TCS: [33mTestCase_testScalarModVec2Float32PackedLowp[0m, time elapsed: 200500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32PackedLowp (10100 ns)
    TCS: [33mTestCase_testScalarModVec2Float32NegativeDividend[0m, time elapsed: 197300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32NegativeDividend (9800 ns)
    TCS: [33mTestCase_testScalarModVec2Float32NegativeDivisor[0m, time elapsed: 181700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32NegativeDivisor (8800 ns)
    TCS: [33mTestCase_testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents[0m, time elapsed: 366100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents (158500 ns)
    TCS: [33mTestCase_testScalarAddVec1Float32[0m, time elapsed: 215200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec1Float32 (14200 ns)
    TCS: [33mTestCase_testScalarAddVec2Float32[0m, time elapsed: 214300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec2Float32 (13000 ns)
    TCS: [33mTestCase_testScalarAddVec3Float32[0m, time elapsed: 187900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec3Float32 (10300 ns)
    TCS: [33mTestCase_testScalarAddVec4Float32[0m, time elapsed: 180000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec4Float32 (10200 ns)
    TCS: [33mTestCase_testScalarSubVec1Float32[0m, time elapsed: 194800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1Float32 (13100 ns)
    TCS: [33mTestCase_testScalarSubVec2Float32[0m, time elapsed: 200500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2Float32 (16600 ns)
    TCS: [33mTestCase_testScalarSubVec3Float32[0m, time elapsed: 185000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3Float32 (12300 ns)
    TCS: [33mTestCase_testScalarSubVec4Float32[0m, time elapsed: 182600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4Float32 (8300 ns)
    TCS: [33mTestCase_testScalarMulVec1Float32[0m, time elapsed: 190100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1Float32 (8300 ns)
    TCS: [33mTestCase_testScalarMulVec2Float32[0m, time elapsed: 312600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2Float32 (14400 ns)
    TCS: [33mTestCase_testScalarMulVec3Float32[0m, time elapsed: 205900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3Float32 (10600 ns)
    TCS: [33mTestCase_testScalarMulVec4Float32[0m, time elapsed: 460100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4Float32 (24100 ns)
    TCS: [33mTestCase_testScalarDivVec1Float32[0m, time elapsed: 332200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1Float32 (24300 ns)
    TCS: [33mTestCase_testScalarDivVec2Float32[0m, time elapsed: 271700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2Float32 (20200 ns)
    TCS: [33mTestCase_testScalarDivVec3Float32[0m, time elapsed: 225000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3Float32 (13000 ns)
    TCS: [33mTestCase_testScalarDivVec4Float32[0m, time elapsed: 217300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4Float32 (12600 ns)
    TCS: [33mTestCase_testScalarAddVec1Int32[0m, time elapsed: 246500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec1Int32 (25300 ns)
    TCS: [33mTestCase_testScalarAddVec2Int32[0m, time elapsed: 197200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec2Int32 (11300 ns)
    TCS: [33mTestCase_testScalarAddVec3Int32[0m, time elapsed: 188800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec3Int32 (10500 ns)
    TCS: [33mTestCase_testScalarAddVec4Int32[0m, time elapsed: 204700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec4Int32 (10600 ns)
    TCS: [33mTestCase_testScalarSubVec1Int32[0m, time elapsed: 190000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1Int32 (14500 ns)
    TCS: [33mTestCase_testScalarSubVec2Int32[0m, time elapsed: 186800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2Int32 (10300 ns)
    TCS: [33mTestCase_testScalarSubVec3Int32[0m, time elapsed: 189400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3Int32 (16000 ns)
    TCS: [33mTestCase_testScalarSubVec4Int32[0m, time elapsed: 216300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4Int32 (11400 ns)
    TCS: [33mTestCase_testScalarMulVec1Int32[0m, time elapsed: 188300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1Int32 (12500 ns)
    TCS: [33mTestCase_testScalarMulVec2Int32[0m, time elapsed: 179600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2Int32 (9800 ns)
    TCS: [33mTestCase_testScalarMulVec3Int32[0m, time elapsed: 194500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3Int32 (9700 ns)
    TCS: [33mTestCase_testScalarMulVec4Int32[0m, time elapsed: 210300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4Int32 (10300 ns)
    TCS: [33mTestCase_testScalarDivVec1Int32[0m, time elapsed: 199000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1Int32 (10200 ns)
    TCS: [33mTestCase_testScalarDivVec2Int32[0m, time elapsed: 234500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2Int32 (14400 ns)
    TCS: [33mTestCase_testScalarDivVec3Int32[0m, time elapsed: 228500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3Int32 (13100 ns)
    TCS: [33mTestCase_testScalarDivVec4Int32[0m, time elapsed: 208800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4Int32 (14000 ns)
    TCS: [33mTestCase_testScalarModVec1Int32[0m, time elapsed: 200800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Int32 (10300 ns)
    TCS: [33mTestCase_testScalarModVec2Int32[0m, time elapsed: 237100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Int32 (12100 ns)
    TCS: [33mTestCase_testScalarModVec3Int32[0m, time elapsed: 199700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Int32 (13500 ns)
    TCS: [33mTestCase_testScalarModVec4Int32[0m, time elapsed: 211600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Int32 (10000 ns)
    TCS: [33mTestCase_testScalarSubVec1PackedMediump[0m, time elapsed: 270400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1PackedMediump (13700 ns)
    TCS: [33mTestCase_testScalarSubVec1PackedLowp[0m, time elapsed: 194800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1PackedLowp (10600 ns)
    TCS: [33mTestCase_testScalarSubVec3PackedMediump[0m, time elapsed: 187500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3PackedMediump (10100 ns)
    TCS: [33mTestCase_testScalarSubVec3PackedLowp[0m, time elapsed: 231900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3PackedLowp (14300 ns)
    TCS: [33mTestCase_testScalarSubVec4PackedMediump[0m, time elapsed: 254700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4PackedMediump (13300 ns)
    TCS: [33mTestCase_testScalarSubVec4PackedLowp[0m, time elapsed: 319500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4PackedLowp (11400 ns)
    TCS: [33mTestCase_testScalarMulVec1PackedMediump[0m, time elapsed: 239900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1PackedMediump (15500 ns)
    TCS: [33mTestCase_testScalarMulVec1PackedLowp[0m, time elapsed: 205300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1PackedLowp (11400 ns)
    TCS: [33mTestCase_testScalarMulVec3PackedMediump[0m, time elapsed: 213500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3PackedMediump (19200 ns)
    TCS: [33mTestCase_testScalarMulVec3PackedLowp[0m, time elapsed: 207200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3PackedLowp (10500 ns)
    TCS: [33mTestCase_testScalarMulVec4PackedMediump[0m, time elapsed: 203000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4PackedMediump (11300 ns)
    TCS: [33mTestCase_testScalarMulVec4PackedLowp[0m, time elapsed: 194600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4PackedLowp (10400 ns)
    TCS: [33mTestCase_testScalarDivVec1PackedMediump[0m, time elapsed: 202200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1PackedMediump (9300 ns)
    TCS: [33mTestCase_testScalarDivVec1PackedLowp[0m, time elapsed: 208600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1PackedLowp (14300 ns)
    TCS: [33mTestCase_testScalarDivVec3PackedMediump[0m, time elapsed: 211100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3PackedMediump (14300 ns)
    TCS: [33mTestCase_testScalarDivVec3PackedLowp[0m, time elapsed: 223100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3PackedLowp (11000 ns)
    TCS: [33mTestCase_testScalarDivVec4PackedMediump[0m, time elapsed: 211300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4PackedMediump (11200 ns)
    TCS: [33mTestCase_testScalarDivVec4PackedLowp[0m, time elapsed: 181800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4PackedLowp (9700 ns)
    TCS: [33mTestCase_testScalarModVec1PackedMediump[0m, time elapsed: 193600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1PackedMediump (10400 ns)
    TCS: [33mTestCase_testScalarModVec1PackedLowp[0m, time elapsed: 219800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1PackedLowp (14900 ns)
    TCS: [33mTestCase_testScalarModVec3PackedMediump[0m, time elapsed: 214200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3PackedMediump (11100 ns)
    TCS: [33mTestCase_testScalarModVec3PackedLowp[0m, time elapsed: 193800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3PackedLowp (10200 ns)
    TCS: [33mTestCase_testScalarModVec4PackedMediump[0m, time elapsed: 190100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4PackedMediump (10400 ns)
    TCS: [33mTestCase_testScalarModVec4PackedLowp[0m, time elapsed: 334400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4PackedLowp (16800 ns)
    TCS: [33mTestCase_testScalarDivZeroVec1[0m, time elapsed: 228100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivZeroVec1 (19700 ns)
    TCS: [33mTestCase_testScalarAddNegVec1[0m, time elapsed: 218100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddNegVec1 (14700 ns)
    TCS: [33mTestCase_testScalarAddNegVec2[0m, time elapsed: 204200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddNegVec2 (13400 ns)
    TCS: [33mTestCase_testScalarMulOverflowVec1[0m, time elapsed: 182000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulOverflowVec1 (8700 ns)
    TCS: [33mTestCase_testScalarSubNegVec1[0m, time elapsed: 193600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubNegVec1 (14400 ns)
    TCS: [33mTestCase_testVersionMajor[0m, time elapsed: 176900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionMajor (8200 ns)
    TCS: [33mTestCase_testVersionMinor[0m, time elapsed: 173700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionMinor (10400 ns)
    TCS: [33mTestCase_testVersionPatch[0m, time elapsed: 180100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionPatch (7100 ns)
    TCS: [33mTestCase_testVersionEncoded[0m, time elapsed: 197300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionEncoded (12900 ns)
    TCS: [33mTestCase_testConfigSimd[0m, time elapsed: 209100 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigSimd (12300 ns)
    TCS: [33mTestCase_testConfigAlignedGentypes[0m, time elapsed: 190200 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigAlignedGentypes (11100 ns)
    TCS: [33mTestCase_testConfigClipControl[0m, time elapsed: 178500 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigClipControl (8700 ns)
    TCS: [33mTestCase_testConstNegationSimd[0m, time elapsed: 182800 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationSimd (9800 ns)
    TCS: [33mTestCase_testConstNegationAligned[0m, time elapsed: 191700 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationAligned (7700 ns)
    TCS: [33mTestCase_testConstNegationClip[0m, time elapsed: 172400 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationClip (7900 ns)
    TCS: [33mTestCase_testConstInt64Usage[0m, time elapsed: 179600 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstInt64Usage (8000 ns)
    TCS: [33mTestCase_testConstBoolUsage[0m, time elapsed: 199600 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstBoolUsage (7900 ns)
    TCS: [33mTestCase_testVersionEncodingConsistency[0m, time elapsed: 180800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionEncodingConsistency (10200 ns)
    TCS: [33mTestCase_testAssertPasses[0m, time elapsed: 197600 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertPasses (22700 ns)
    TCS: [33mTestCase_testAssertFails[0m, time elapsed: 282500 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertFails (75600 ns)
    TCS: [33mTestCase_testAssertWithCustomMessage[0m, time elapsed: 233300 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertWithCustomMessage (46000 ns)
    TCS: [33mTestCase_testNumericLimitsFloat32Epsilon[0m, time elapsed: 188800 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsFloat32Epsilon (11300 ns)
    TCS: [33mTestCase_testNumericLimitsFloat64Epsilon[0m, time elapsed: 203400 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsFloat64Epsilon (11400 ns)
    TCS: [33mTestCase_testIsIec559OfFloat32[0m, time elapsed: 194900 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfFloat32 (16700 ns)
    TCS: [33mTestCase_testIsIec559OfFloat64[0m, time elapsed: 197900 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfFloat64 (9900 ns)
    TCS: [33mTestCase_testIsIec559OfInt64[0m, time elapsed: 216800 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfInt64 (10900 ns)
    TCS: [33mTestCase_testEpsilonOfFloat32[0m, time elapsed: 274600 ns, RESULT:
    [[32m PASSED [0m] CASE: testEpsilonOfFloat32 (12600 ns)
    TCS: [33mTestCase_testEpsilonOfFloat64[0m, time elapsed: 191100 ns, RESULT:
    [[32m PASSED [0m] CASE: testEpsilonOfFloat64 (10400 ns)
    TCS: [33mTestCase_testNumericLimitsInt64Epsilon[0m, time elapsed: 221500 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt64Epsilon (14900 ns)
    TCS: [33mTestCase_testNumericLimitsInt32Epsilon[0m, time elapsed: 208900 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt32Epsilon (12200 ns)
    TCS: [33mTestCase_testNumericLimitsInt16Epsilon[0m, time elapsed: 213400 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt16Epsilon (20200 ns)
    TCS: [33mTestCase_testNumericLimitsInt8Epsilon[0m, time elapsed: 222200 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsInt8Epsilon (12500 ns)
    TCS: [33mTestCase_testCastVec1ToVec1IntToFloat[0m, time elapsed: 230500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec1ToVec1IntToFloat (14800 ns)
    TCS: [33mTestCase_testCastVec2ToVec1TakesOnlyX[0m, time elapsed: 237100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2ToVec1TakesOnlyX (12600 ns)
    TCS: [33mTestCase_testCastVec3ToVec1TakesOnlyX[0m, time elapsed: 201300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3ToVec1TakesOnlyX (9800 ns)
    TCS: [33mTestCase_testCastVec4ToVec1TakesOnlyX[0m, time elapsed: 223200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4ToVec1TakesOnlyX (17000 ns)
    TCS: [33mTestCase_testCastSameTypeIdentity[0m, time elapsed: 1221500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastSameTypeIdentity (49600 ns)
    TCS: [33mTestCase_testCastInt32ToInt64[0m, time elapsed: 730200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastInt32ToInt64 (29900 ns)
    TCS: [33mTestCase_testCastFloatToIntTruncation[0m, time elapsed: 285200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastFloatToIntTruncation (25100 ns)
    TCS: [33mTestCase_testCastCrossQualifierPackedHighpToDefaultp[0m, time elapsed: 275700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastCrossQualifierPackedHighpToDefaultp (27200 ns)
    TCS: [33mTestCase_testCastCrossQualifierDefaultpToPackedHighp[0m, time elapsed: 312500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastCrossQualifierDefaultpToPackedHighp (24500 ns)
    TCS: [33mTestCase_testCastVec2CrossQualifierCrossType[0m, time elapsed: 334700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2CrossQualifierCrossType (40200 ns)
    TCS: [33mTestCase_testCastVec3CrossQualifier[0m, time elapsed: 611400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3CrossQualifier (54300 ns)
    TCS: [33mTestCase_testCastVec4CrossQualifier[0m, time elapsed: 218900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4CrossQualifier (11400 ns)
    TCS: [33mTestCase_testCastVec1DoesNotModifySource[0m, time elapsed: 183600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec1DoesNotModifySource (8700 ns)
    TCS: [33mTestCase_testCastVec2Vec1ToVec2IntToFloat[0m, time elapsed: 190700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec1ToVec2IntToFloat (11200 ns)
    TCS: [33mTestCase_testCastVec2Vec2ToVec2Identity[0m, time elapsed: 189800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec2ToVec2Identity (17400 ns)
    TCS: [33mTestCase_testCastVec2Vec3ToVec2TakesOnlyXY[0m, time elapsed: 219000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec3ToVec2TakesOnlyXY (18200 ns)
    TCS: [33mTestCase_testCastVec2Vec4ToVec2TakesOnlyXY[0m, time elapsed: 193500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec4ToVec2TakesOnlyXY (11000 ns)
    TCS: [33mTestCase_testCastVec2SameTypeIdentity[0m, time elapsed: 179200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2SameTypeIdentity (7900 ns)
    TCS: [33mTestCase_testCastVec2Int32ToInt64[0m, time elapsed: 188600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Int32ToInt64 (8900 ns)
    TCS: [33mTestCase_testCastVec2FloatToIntTruncation[0m, time elapsed: 184700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2FloatToIntTruncation (17200 ns)
    TCS: [33mTestCase_testCastVec2CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 182300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2CrossQualifierPackedHighpToDefaultp (8300 ns)
    TCS: [33mTestCase_testCastVec2DoesNotModifySource[0m, time elapsed: 180100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2DoesNotModifySource (7700 ns)
    TCS: [33mTestCase_testCastVec2Vec1ToVec2SameValueBothComponents[0m, time elapsed: 188200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec1ToVec2SameValueBothComponents (16300 ns)
    TCS: [33mTestCase_testCastVec3Vec1ToVec3IntToFloat[0m, time elapsed: 193300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec1ToVec3IntToFloat (17800 ns)
    TCS: [33mTestCase_testCastVec3Vec2ToVec3ExtendY[0m, time elapsed: 170500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec2ToVec3ExtendY (7800 ns)
    TCS: [33mTestCase_testCastVec3Vec3ToVec3Identity[0m, time elapsed: 200400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec3ToVec3Identity (12700 ns)
    TCS: [33mTestCase_testCastVec3Vec4ToVec3TakesOnlyXYZ[0m, time elapsed: 203600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec4ToVec3TakesOnlyXYZ (10800 ns)
    TCS: [33mTestCase_testCastVec3SameTypeIdentity[0m, time elapsed: 207500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3SameTypeIdentity (15700 ns)
    TCS: [33mTestCase_testCastVec3Int32ToInt64[0m, time elapsed: 196100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Int32ToInt64 (9800 ns)
    TCS: [33mTestCase_testCastVec3FloatToIntTruncation[0m, time elapsed: 185000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3FloatToIntTruncation (8700 ns)
    TCS: [33mTestCase_testCastVec3CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 184700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3CrossQualifierPackedHighpToDefaultp (7400 ns)
    TCS: [33mTestCase_testCastVec3DoesNotModifySource[0m, time elapsed: 201100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3DoesNotModifySource (7600 ns)
    TCS: [33mTestCase_testCastVec3Vec1ToVec3SameValueAllComponents[0m, time elapsed: 168900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec1ToVec3SameValueAllComponents (6600 ns)
    TCS: [33mTestCase_testCastVec4Vec1ToVec4IntToFloat[0m, time elapsed: 191500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec1ToVec4IntToFloat (15000 ns)
    TCS: [33mTestCase_testCastVec4Vec2ToVec4ExtendY[0m, time elapsed: 194400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec2ToVec4ExtendY (18900 ns)
    TCS: [33mTestCase_testCastVec4Vec3ToVec4ExtendZ[0m, time elapsed: 195400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec3ToVec4ExtendZ (14200 ns)
    TCS: [33mTestCase_testCastVec4Vec4ToVec4Identity[0m, time elapsed: 281900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec4ToVec4Identity (17600 ns)
    TCS: [33mTestCase_testCastVec4SameTypeIdentity[0m, time elapsed: 226100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4SameTypeIdentity (9100 ns)
    TCS: [33mTestCase_testCastVec4Int32ToInt64[0m, time elapsed: 196000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Int32ToInt64 (11100 ns)
    TCS: [33mTestCase_testCastVec4FloatToIntTruncation[0m, time elapsed: 177500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4FloatToIntTruncation (6800 ns)
    TCS: [33mTestCase_testCastVec4CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 213800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4CrossQualifierPackedHighpToDefaultp (9000 ns)
    TCS: [33mTestCase_testCastVec4DoesNotModifySource[0m, time elapsed: 228900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4DoesNotModifySource (8700 ns)
    TCS: [33mTestCase_testCastVec4Vec1ToVec4SameValueAllComponents[0m, time elapsed: 208500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec1ToVec4SameValueAllComponents (8900 ns)
    TCS: [33mTestCase_testFromBoolVec1[0m, time elapsed: 271000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec1 (25400 ns)
    TCS: [33mTestCase_testFromBoolVec1False[0m, time elapsed: 266700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec1False (10900 ns)
    TCS: [33mTestCase_testFromBoolVec2[0m, time elapsed: 293700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec2 (18200 ns)
    TCS: [33mTestCase_testFromBoolVec3[0m, time elapsed: 291300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec3 (16900 ns)
    TCS: [33mTestCase_testFromBoolVec4[0m, time elapsed: 276800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec4 (16300 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec1[0m, time elapsed: 254800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec1 (9800 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec2[0m, time elapsed: 275100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec2 (15700 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec3[0m, time elapsed: 285200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec3 (11700 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec4[0m, time elapsed: 300100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec4 (29100 ns)
    TCS: [33mTestCase_testFromBoolVec3AllFalse[0m, time elapsed: 270800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec3AllFalse (12300 ns)
    TCS: [33mTestCase_testFromBoolVec4AllFalse[0m, time elapsed: 318900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec4AllFalse (12400 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec3AllFalse[0m, time elapsed: 327400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec3AllFalse (17100 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec4AllFalse[0m, time elapsed: 188200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec4AllFalse (7700 ns)
    TCS: [33mTestCase_testFromBoolVecFloat32[0m, time elapsed: 392100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecFloat32 (14500 ns)
    TCS: [33mTestCase_testFromBoolVecFloat64[0m, time elapsed: 203500 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecFloat64 (10600 ns)
    TCS: [33mTestCase_testFromBoolVecInt32[0m, time elapsed: 167400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecInt32 (8700 ns)
    TCS: [33mTestCase_testFromBoolVecQ2PackedMediump[0m, time elapsed: 171300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2PackedMediump (7900 ns)
    TCS: [33mTestCase_testFromBoolVecQ2PackedLowp[0m, time elapsed: 172400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2PackedLowp (14800 ns)
    TCS: [33mTestCase_testS1QuatCastScalingXBranch[0m, time elapsed: 232900 ns, RESULT:
    [[32m PASSED [0m] CASE: testS1QuatCastScalingXBranch (63300 ns)
    TCS: [33mTestCase_testS1QuatCastScalingYBranch[0m, time elapsed: 178500 ns, RESULT:
    [[32m PASSED [0m] CASE: testS1QuatCastScalingYBranch (21300 ns)
    TCS: [33mTestCase_testS1QuatCastScalingZBranch[0m, time elapsed: 182900 ns, RESULT:
    [[32m PASSED [0m] CASE: testS1QuatCastScalingZBranch (16800 ns)
    TCS: [33mTestCase_testS1QuatCastScalingWBranch[0m, time elapsed: 174100 ns, RESULT:
    [[32m PASSED [0m] CASE: testS1QuatCastScalingWBranch (18300 ns)
    TCS: [33mTestCase_testS1QuatCastUnitRoundTrip[0m, time elapsed: 168000 ns, RESULT:
    [[32m PASSED [0m] CASE: testS1QuatCastUnitRoundTrip (12000 ns)
    TCS: [33mTestCase_testS1QuatCastIdentityRoundTrip[0m, time elapsed: 180100 ns, RESULT:
    [[32m PASSED [0m] CASE: testS1QuatCastIdentityRoundTrip (10800 ns)
    TCS: [33mTestCase_testS1QuatCastMat4Delegation[0m, time elapsed: 193600 ns, RESULT:
    [[32m PASSED [0m] CASE: testS1QuatCastMat4Delegation (29800 ns)
    TCS: [33mTestCase_testMat3EqualEpsilonRelaxedExactMatch[0m, time elapsed: 163900 ns, RESULT:
    [[32m PASSED [0m] CASE: testMat3EqualEpsilonRelaxedExactMatch (10200 ns)
    TCS: [33mTestCase_testMat3EqualEpsilonRelaxedWithinPosTolerance[0m, time elapsed: 165500 ns, RESULT:
    [[32m PASSED [0m] CASE: testMat3EqualEpsilonRelaxedWithinPosTolerance (7100 ns)
    TCS: [33mTestCase_testMat3EqualEpsilonRelaxedWithinNegTolerance[0m, time elapsed: 172000 ns, RESULT:
    [[32m PASSED [0m] CASE: testMat3EqualEpsilonRelaxedWithinNegTolerance (6600 ns)
    TCS: [33mTestCase_testMat3EqualEpsilonRelaxedBeyondTolerance[0m, time elapsed: 167000 ns, RESULT:
    [[32m PASSED [0m] CASE: testMat3EqualEpsilonRelaxedBeyondTolerance (6400 ns)
    TCS: [33mTestCase_testMat3EqualEpsilonRelaxedZeroMatrix[0m, time elapsed: 171500 ns, RESULT:
    [[32m PASSED [0m] CASE: testMat3EqualEpsilonRelaxedZeroMatrix (6000 ns)
    TCS: [33mTestCase_testMat3EqualEpsilonRelaxedSingleDiffBeyond[0m, time elapsed: 163300 ns, RESULT:
    [[32m PASSED [0m] CASE: testMat3EqualEpsilonRelaxedSingleDiffBeyond (5900 ns)
    TCS: [33mTestCase_testVec2ScalarInit[0m, time elapsed: 183800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarInit (11000 ns)
    TCS: [33mTestCase_testVec2ConstInit[0m, time elapsed: 170700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ConstInit (8800 ns)
    TCS: [33mTestCase_testVec2Length[0m, time elapsed: 160700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Length (5500 ns)
    TCS: [33mTestCase_testVec2Add[0m, time elapsed: 170200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Add (11300 ns)
    TCS: [33mTestCase_testVec2Sub[0m, time elapsed: 194800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Sub (13100 ns)
    TCS: [33mTestCase_testVec2Mul[0m, time elapsed: 182700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Mul (10300 ns)
    TCS: [33mTestCase_testVec2ScalarAdd[0m, time elapsed: 184800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarAdd (9500 ns)
    TCS: [33mTestCase_testVec2Negate[0m, time elapsed: 172000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Negate (8700 ns)
    TCS: [33mTestCase_testVec2IndexAccess[0m, time elapsed: 221900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2IndexAccess (5700 ns)
    TCS: [33mTestCase_testVec2IndexMutate[0m, time elapsed: 172200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2IndexMutate (8600 ns)
    TCS: [33mTestCase_testVec2ComponentAt[0m, time elapsed: 173600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ComponentAt (8400 ns)
    TCS: [33mTestCase_testVec2Equal[0m, time elapsed: 183500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Equal (15600 ns)
    TCS: [33mTestCase_testVec2NotEqual[0m, time elapsed: 180900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2NotEqual (10700 ns)
    TCS: [33mTestCase_testVec2EqualExact[0m, time elapsed: 165700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2EqualExact (8300 ns)
    TCS: [33mTestCase_testVec2BitwiseAnd[0m, time elapsed: 263800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseAnd (11300 ns)
    TCS: [33mTestCase_testVec2BitwiseNot[0m, time elapsed: 172500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseNot (7900 ns)
    TCS: [33mTestCase_testVec2FromVec1[0m, time elapsed: 166500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2FromVec1 (9700 ns)
    TCS: [33mTestCase_testVec2ShiftLeft[0m, time elapsed: 174900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeft (14000 ns)
    TCS: [33mTestCase_testVec2BoolLogicalAnd[0m, time elapsed: 170800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BoolLogicalAnd (8800 ns)
    TCS: [33mTestCase_testVec2Vec1ArithBroadcast[0m, time elapsed: 173300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Vec1ArithBroadcast (10200 ns)
    TCS: [33mTestCase_testVec2Vec1BitBroadcast[0m, time elapsed: 172400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Vec1BitBroadcast (10200 ns)
    TCS: [33mTestCase_testVec2ShiftLeftVec1[0m, time elapsed: 182300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeftVec1 (14600 ns)
    TCS: [33mTestCase_testVec2Div[0m, time elapsed: 189800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Div (9100 ns)
    TCS: [33mTestCase_testVec2Mod[0m, time elapsed: 188600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Mod (9200 ns)
    TCS: [33mTestCase_testVec2ScalarSub[0m, time elapsed: 206100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarSub (9900 ns)
    TCS: [33mTestCase_testVec2ScalarMul[0m, time elapsed: 201800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarMul (10000 ns)
    TCS: [33mTestCase_testVec2ScalarDiv[0m, time elapsed: 207100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarDiv (13800 ns)
    TCS: [33mTestCase_testVec2ScalarMod[0m, time elapsed: 322400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarMod (15800 ns)
    TCS: [33mTestCase_testVec2BoolLogicalOr[0m, time elapsed: 181500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BoolLogicalOr (7300 ns)
    TCS: [33mTestCase_testVec2EqualEpsilon[0m, time elapsed: 187300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2EqualEpsilon (12900 ns)
    TCS: [33mTestCase_testVec2DivNamed[0m, time elapsed: 197100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2DivNamed (7800 ns)
    TCS: [33mTestCase_testVec2ModNamed[0m, time elapsed: 179700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ModNamed (6400 ns)
    TCS: [33mTestCase_testVec2BitwiseOr[0m, time elapsed: 170400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseOr (13900 ns)
    TCS: [33mTestCase_testVec2BitwiseXor[0m, time elapsed: 174900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseXor (13000 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseAnd[0m, time elapsed: 182100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseAnd (9400 ns)
    TCS: [33mTestCase_testVec2ShiftRight[0m, time elapsed: 173300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRight (8300 ns)
    TCS: [33mTestCase_testVec2ShiftRightVec1[0m, time elapsed: 165300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRightVec1 (8100 ns)
    TCS: [33mTestCase_testVec2AddNamed[0m, time elapsed: 164400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2AddNamed (5900 ns)
    TCS: [33mTestCase_testVec2SubNamed[0m, time elapsed: 216300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2SubNamed (45900 ns)
    TCS: [33mTestCase_testVec2MulNamed[0m, time elapsed: 184200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2MulNamed (6600 ns)
    TCS: [33mTestCase_testVec2ShiftLeftVec[0m, time elapsed: 172200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeftVec (6100 ns)
    TCS: [33mTestCase_testVec2ShiftRightVec[0m, time elapsed: 250300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRightVec (9600 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseOr[0m, time elapsed: 291900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseOr (21400 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseXor[0m, time elapsed: 213900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseXor (14900 ns)
    TCS: [33mTestCase_testVec2Increment[0m, time elapsed: 381900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Increment (30300 ns)
    TCS: [33mTestCase_testVec2Decrement[0m, time elapsed: 365600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Decrement (35100 ns)
    TCS: [33mTestCase_testVec2IndexOutOfBoundsAccess[0m, time elapsed: 513700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2IndexOutOfBoundsAccess (175400 ns)
    TCS: [33mTestCase_testVec2NegativeIndexAccess[0m, time elapsed: 597900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2NegativeIndexAccess (179300 ns)
    TCS: [33mTestCase_testVec3ScalarInit[0m, time elapsed: 287600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarInit (20100 ns)
    TCS: [33mTestCase_testVec3ConstInit[0m, time elapsed: 296300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ConstInit (30000 ns)
    TCS: [33mTestCase_testVec3Length[0m, time elapsed: 265200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Length (10500 ns)
    TCS: [33mTestCase_testVec3Add[0m, time elapsed: 301800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Add (29600 ns)
    TCS: [33mTestCase_testVec3ScalarMul[0m, time elapsed: 284500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarMul (17400 ns)
    TCS: [33mTestCase_testVec3Negate[0m, time elapsed: 289800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Negate (19000 ns)
    TCS: [33mTestCase_testVec3IndexAccess[0m, time elapsed: 318500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3IndexAccess (27100 ns)
    TCS: [33mTestCase_testVec3IndexMutate[0m, time elapsed: 263200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3IndexMutate (11100 ns)
    TCS: [33mTestCase_testVec3ComponentAt[0m, time elapsed: 279600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ComponentAt (22000 ns)
    TCS: [33mTestCase_testVec3Equal[0m, time elapsed: 304500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Equal (36700 ns)
    TCS: [33mTestCase_testVec3NotEqual[0m, time elapsed: 280600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3NotEqual (19400 ns)
    TCS: [33mTestCase_testVec3EqualExact[0m, time elapsed: 313500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3EqualExact (22300 ns)
    TCS: [33mTestCase_testVec3BitwiseAnd[0m, time elapsed: 384400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseAnd (30200 ns)
    TCS: [33mTestCase_testVec3BitwiseNot[0m, time elapsed: 290600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseNot (14100 ns)
    TCS: [33mTestCase_testVec3Vec1ArithBroadcast[0m, time elapsed: 307700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1ArithBroadcast (32300 ns)
    TCS: [33mTestCase_testVec3ShiftLeft[0m, time elapsed: 283800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeft (23800 ns)
    TCS: [33mTestCase_testVec3BoolLogicalAnd[0m, time elapsed: 284300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BoolLogicalAnd (16500 ns)
    TCS: [33mTestCase_testVec3Sub[0m, time elapsed: 314200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Sub (26200 ns)
    TCS: [33mTestCase_testVec3Div[0m, time elapsed: 331100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Div (24400 ns)
    TCS: [33mTestCase_testVec3Mod[0m, time elapsed: 360600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Mod (23900 ns)
    TCS: [33mTestCase_testVec3ScalarSub[0m, time elapsed: 207500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarSub (16400 ns)
    TCS: [33mTestCase_testVec3ScalarDiv[0m, time elapsed: 192700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarDiv (18900 ns)
    TCS: [33mTestCase_testVec3ScalarMod[0m, time elapsed: 196600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarMod (9500 ns)
    TCS: [33mTestCase_testVec3BoolLogicalOr[0m, time elapsed: 195100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BoolLogicalOr (11600 ns)
    TCS: [33mTestCase_testVec3EqualEpsilon[0m, time elapsed: 180700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3EqualEpsilon (16700 ns)
    TCS: [33mTestCase_testVec3AddNamed[0m, time elapsed: 177800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3AddNamed (12100 ns)
    TCS: [33mTestCase_testVec3MulNamed[0m, time elapsed: 177600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3MulNamed (6300 ns)
    TCS: [33mTestCase_testVec3DivNamed[0m, time elapsed: 195200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3DivNamed (6700 ns)
    TCS: [33mTestCase_testVec3ModNamed[0m, time elapsed: 174100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ModNamed (9500 ns)
    TCS: [33mTestCase_testVec3BitwiseOr[0m, time elapsed: 181000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseOr (15300 ns)
    TCS: [33mTestCase_testVec3BitwiseXor[0m, time elapsed: 193900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseXor (10700 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseAnd[0m, time elapsed: 182700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseAnd (14100 ns)
    TCS: [33mTestCase_testVec3ShiftRight[0m, time elapsed: 188100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRight (9100 ns)
    TCS: [33mTestCase_testVec3Vec1BitBroadcast[0m, time elapsed: 178000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitBroadcast (12400 ns)
    TCS: [33mTestCase_testVec3ShiftRightVec1[0m, time elapsed: 279600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRightVec1 (13700 ns)
    TCS: [33mTestCase_testVec3FromVec1[0m, time elapsed: 181000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3FromVec1 (8300 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseOr[0m, time elapsed: 191000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseOr (10500 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseXor[0m, time elapsed: 177700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseXor (11300 ns)
    TCS: [33mTestCase_testVec3Vec1BitOrBroadcast[0m, time elapsed: 179300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitOrBroadcast (11600 ns)
    TCS: [33mTestCase_testVec3Vec1BitXorBroadcast[0m, time elapsed: 170700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitXorBroadcast (12800 ns)
    TCS: [33mTestCase_testVec3ShiftLeftVec1[0m, time elapsed: 191600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeftVec1 (14300 ns)
    TCS: [33mTestCase_testVec3ShiftLeftVec[0m, time elapsed: 183700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeftVec (11700 ns)
    TCS: [33mTestCase_testVec3ShiftRightVec[0m, time elapsed: 170500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRightVec (9500 ns)
    TCS: [33mTestCase_testVec3Increment[0m, time elapsed: 173100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Increment (10900 ns)
    TCS: [33mTestCase_testVec3Decrement[0m, time elapsed: 172600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Decrement (10400 ns)
    TCS: [33mTestCase_testVec3IndexOutOfBoundsAccess[0m, time elapsed: 211700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3IndexOutOfBoundsAccess (43200 ns)
    TCS: [33mTestCase_testVec3NegativeIndexAccess[0m, time elapsed: 184500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3NegativeIndexAccess (21300 ns)
    TCS: [33mTestCase_testVec4ScalarInit[0m, time elapsed: 172500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarInit (12000 ns)
    TCS: [33mTestCase_testVec4ConstInit[0m, time elapsed: 164200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ConstInit (5500 ns)
    TCS: [33mTestCase_testVec4Length[0m, time elapsed: 173700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Length (5000 ns)
    TCS: [33mTestCase_testVec4Add[0m, time elapsed: 184900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Add (18200 ns)
    TCS: [33mTestCase_testVec4ScalarMul[0m, time elapsed: 173700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarMul (10800 ns)
    TCS: [33mTestCase_testVec4Negate[0m, time elapsed: 167200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Negate (9000 ns)
    TCS: [33mTestCase_testVec4IndexAccess[0m, time elapsed: 195800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4IndexAccess (8300 ns)
    TCS: [33mTestCase_testVec4IndexMutate[0m, time elapsed: 163700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4IndexMutate (5800 ns)
    TCS: [33mTestCase_testVec4ComponentAt[0m, time elapsed: 165200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ComponentAt (6100 ns)
    TCS: [33mTestCase_testVec4Equal[0m, time elapsed: 178500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Equal (17400 ns)
    TCS: [33mTestCase_testVec4NotEqual[0m, time elapsed: 181800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4NotEqual (10500 ns)
    TCS: [33mTestCase_testVec4EqualExact[0m, time elapsed: 180400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4EqualExact (13500 ns)
    TCS: [33mTestCase_testVec4BitwiseAnd[0m, time elapsed: 192300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseAnd (20400 ns)
    TCS: [33mTestCase_testVec4BitwiseNot[0m, time elapsed: 173700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseNot (7200 ns)
    TCS: [33mTestCase_testVec4Vec1ArithBroadcast[0m, time elapsed: 207800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1ArithBroadcast (22600 ns)
    TCS: [33mTestCase_testVec4ShiftLeft[0m, time elapsed: 201900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeft (15200 ns)
    TCS: [33mTestCase_testVec4BoolLogicalAnd[0m, time elapsed: 201900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BoolLogicalAnd (18100 ns)
    TCS: [33mTestCase_testVec4Sub[0m, time elapsed: 193800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Sub (17500 ns)
    TCS: [33mTestCase_testVec4Div[0m, time elapsed: 178500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Div (11600 ns)
    TCS: [33mTestCase_testVec4Mod[0m, time elapsed: 176500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Mod (11400 ns)
    TCS: [33mTestCase_testVec4ScalarSub[0m, time elapsed: 171400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarSub (11900 ns)
    TCS: [33mTestCase_testVec4ScalarDiv[0m, time elapsed: 181600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarDiv (13500 ns)
    TCS: [33mTestCase_testVec4ScalarMod[0m, time elapsed: 169400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarMod (9200 ns)
    TCS: [33mTestCase_testVec4BoolLogicalOr[0m, time elapsed: 171600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BoolLogicalOr (6500 ns)
    TCS: [33mTestCase_testVec4EqualEpsilon[0m, time elapsed: 179100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4EqualEpsilon (15900 ns)
    TCS: [33mTestCase_testVec4AddNamed[0m, time elapsed: 184400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4AddNamed (12100 ns)
    TCS: [33mTestCase_testVec4MulNamed[0m, time elapsed: 175600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4MulNamed (9000 ns)
    TCS: [33mTestCase_testVec4DivNamed[0m, time elapsed: 164000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4DivNamed (6500 ns)
    TCS: [33mTestCase_testVec4ModNamed[0m, time elapsed: 168500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ModNamed (6000 ns)
    TCS: [33mTestCase_testVec4BitwiseOr[0m, time elapsed: 186100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseOr (11800 ns)
    TCS: [33mTestCase_testVec4BitwiseXor[0m, time elapsed: 178500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseXor (14300 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseAnd[0m, time elapsed: 170900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseAnd (10200 ns)
    TCS: [33mTestCase_testVec4ShiftRight[0m, time elapsed: 181700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRight (12000 ns)
    TCS: [33mTestCase_testVec4Vec1BitBroadcast[0m, time elapsed: 230100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitBroadcast (18600 ns)
    TCS: [33mTestCase_testVec4ShiftRightVec1[0m, time elapsed: 210300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRightVec1 (15000 ns)
    TCS: [33mTestCase_testVec4FromVec1[0m, time elapsed: 182400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4FromVec1 (13100 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseOr[0m, time elapsed: 196100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseOr (11500 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseXor[0m, time elapsed: 183200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseXor (10900 ns)
    TCS: [33mTestCase_testVec4Vec1BitOrBroadcast[0m, time elapsed: 182700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitOrBroadcast (13500 ns)
    TCS: [33mTestCase_testVec4Vec1BitXorBroadcast[0m, time elapsed: 172100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitXorBroadcast (10800 ns)
    TCS: [33mTestCase_testVec4ShiftLeftVec1[0m, time elapsed: 180000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeftVec1 (10700 ns)
    TCS: [33mTestCase_testVec4ShiftLeftVec[0m, time elapsed: 187100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeftVec (12500 ns)
    TCS: [33mTestCase_testVec4ShiftRightVec[0m, time elapsed: 187400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRightVec (10600 ns)
    TCS: [33mTestCase_testVec4Increment[0m, time elapsed: 178400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Increment (15200 ns)
    TCS: [33mTestCase_testVec4Decrement[0m, time elapsed: 177900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Decrement (12700 ns)
    TCS: [33mTestCase_testVec4IndexOutOfBoundsAccess[0m, time elapsed: 214300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4IndexOutOfBoundsAccess (40200 ns)
    TCS: [33mTestCase_testVec4NegativeIndexAccess[0m, time elapsed: 185600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4NegativeIndexAccess (20500 ns)
    TCS: [33mTestCase_testFunctor1Vec1Identity[0m, time elapsed: 165100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec1Identity (7300 ns)
    TCS: [33mTestCase_testFunctor1Vec1Transform[0m, time elapsed: 279600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec1Transform (10200 ns)
    TCS: [33mTestCase_testFunctor1Vec2Transform[0m, time elapsed: 275000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec2Transform (14500 ns)
    TCS: [33mTestCase_testFunctor2Vec1Add[0m, time elapsed: 181500 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec1Add (7300 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec1Mul[0m, time elapsed: 184200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec1Mul (12800 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec1Shift[0m, time elapsed: 171800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec1Shift (12200 ns)
    TCS: [33mTestCase_testFunctor1Vec3Transform[0m, time elapsed: 164600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec3Transform (7400 ns)
    TCS: [33mTestCase_testFunctor1Vec4Transform[0m, time elapsed: 173800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec4Transform (7400 ns)
    TCS: [33mTestCase_testFunctor2Vec2Add[0m, time elapsed: 229200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec2Add (8900 ns)
    TCS: [33mTestCase_testFunctor2Vec3Add[0m, time elapsed: 250700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec3Add (14600 ns)
    TCS: [33mTestCase_testFunctor2Vec4Add[0m, time elapsed: 186100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec4Add (12200 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec2Mul[0m, time elapsed: 221200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec2Mul (17900 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec3Mul[0m, time elapsed: 203900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec3Mul (8700 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec4Mul[0m, time elapsed: 178300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec4Mul (8500 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec2Shift[0m, time elapsed: 230000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec2Shift (14200 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec3Shift[0m, time elapsed: 246900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec3Shift (8400 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec4Shift[0m, time elapsed: 185000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec4Shift (8200 ns)
Summary: TOTAL: 435
    [32mPASSED[0m: 435, [32mSKIPPED[0m: 0, ERROR: 0
    [31mFAILED[0m: 0
--------------------------------------------------------------------------------------------------
Project tests finished, time elapsed: 160524100 ns, RESULT:
TP: [33mglm[0m.*, time elapsed: 160443900 ns, RESULT:
    PASSED:
    TP: [33mglm.detail[0m, time elapsed: 144967800 ns
Summary: TOTAL: 435
    [32mPASSED[0m: 435, [32mSKIPPED[0m: 0, ERROR: 0
    [31mFAILED[0m: 0
--------------------------------------------------------------------------------------------------
[0J7[;r8[?25hcjpm test success
