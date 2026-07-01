# 验证报告（v1）

## 结果
FAILED

## 统计
- 通过：0
- 失败：0 (测试执行超时，未产生测试结果)

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

