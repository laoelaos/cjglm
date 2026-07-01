# 验证报告（v2）

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

2 | import glm.detail.{ Quat, Vec4, Qualifier, assert, clamp, acos, epsilon, sinT, cosT, dot, pi }

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



72 warnings generated, 72 warnings printed.

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

2 | import glm.detail.{ Quat, Vec4, Qualifier, assert, clamp, acos, epsilon, sinT, cosT, dot, pi }

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



72 warnings generated, 72 warnings printed.

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

2 | import glm.detail.{ Quat, Vec4, Qualifier, assert, clamp, acos, epsilon, sinT, cosT, dot, pi }

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



72 warnings generated, 72 warnings printed.

[?25l[0J7[;r8
[1F7[9999E8[0J7[;r8[?25h--------------------------------------------------------------------------------------------------
TP: glm.detail, time elapsed: 12432800 ns, RESULT:
    TCS: TestCase_testComputeVecAdd1, time elapsed: 450700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAdd1 (220100 ns)
    TCS: TestCase_testComputeVecSub2, time elapsed: 32500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSub2 (16300 ns)
    TCS: TestCase_testComputeVecMul3, time elapsed: 32000 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMul3 (13900 ns)
    TCS: TestCase_testComputeVecMod1, time elapsed: 23500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMod1 (12400 ns)
    TCS: TestCase_testComputeVecMod4, time elapsed: 31100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMod4 (13600 ns)
    TCS: TestCase_testComputeVecAnd1, time elapsed: 21200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAnd1 (9500 ns)
    TCS: TestCase_testComputeVecAnd3, time elapsed: 25600 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAnd3 (9800 ns)
    TCS: TestCase_testComputeVecOr1, time elapsed: 23700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecOr1 (12200 ns)
    TCS: TestCase_testComputeVecOr2, time elapsed: 33700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecOr2 (18500 ns)
    TCS: TestCase_testComputeVecXor1, time elapsed: 21500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecXor1 (10100 ns)
    TCS: TestCase_testComputeVecXor4, time elapsed: 27000 ns, RESULT:
    [ PASSED ] CASE: testComputeVecXor4 (10700 ns)
    TCS: TestCase_testComputeVecShiftLeft1, time elapsed: 19400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftLeft1 (7700 ns)
    TCS: TestCase_testComputeVecShiftLeft3, time elapsed: 22100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftLeft3 (10700 ns)
    TCS: TestCase_testComputeVecShiftRight1, time elapsed: 18700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftRight1 (7300 ns)
    TCS: TestCase_testComputeVecShiftRight4, time elapsed: 23500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftRight4 (12300 ns)
    TCS: TestCase_testComputeVecEqual1, time elapsed: 22500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual1 (10600 ns)
    TCS: TestCase_testComputeVecNequal4, time elapsed: 28500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecNequal4 (14800 ns)
    TCS: TestCase_testComputeVecBitwiseNot1, time elapsed: 26300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecBitwiseNot1 (14400 ns)
    TCS: TestCase_testComputeVecBitwiseNot3, time elapsed: 23700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecBitwiseNot3 (8400 ns)
    TCS: TestCase_testComputeVecAdd4, time elapsed: 19500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAdd4 (8000 ns)
    TCS: TestCase_testComputeVecSub1, time elapsed: 19300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSub1 (7200 ns)
    TCS: TestCase_testComputeVecSub3, time elapsed: 21100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSub3 (8400 ns)
    TCS: TestCase_testComputeVecMul1, time elapsed: 19100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMul1 (7800 ns)
    TCS: TestCase_testComputeVecMul2, time elapsed: 23900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMul2 (7900 ns)
    TCS: TestCase_testComputeVecDiv1, time elapsed: 19700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecDiv1 (8000 ns)
    TCS: TestCase_testComputeVecDiv2, time elapsed: 23800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecDiv2 (7800 ns)
    TCS: TestCase_testComputeVecDiv4, time elapsed: 19700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecDiv4 (8200 ns)
    TCS: TestCase_testComputeVecEqual2, time elapsed: 23400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual2 (7400 ns)
    TCS: TestCase_testComputeVecEqual3, time elapsed: 70600 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual3 (49800 ns)
    TCS: TestCase_testComputeVecEqual4, time elapsed: 75000 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual4 (19100 ns)
    TCS: TestCase_testComputeVecNequal1, time elapsed: 34400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecNequal1 (10600 ns)
    TCS: TestCase_testComputeVecNequal2, time elapsed: 36900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecNequal2 (8200 ns)
    TCS: TestCase_testComputeVecBitwiseNot4, time elapsed: 41900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecBitwiseNot4 (20900 ns)
    TCS: TestCase_testComputeVecAddFloat32, time elapsed: 54200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAddFloat32 (31100 ns)
    TCS: TestCase_testComputeVecAddFloat32Vec3, time elapsed: 44200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAddFloat32Vec3 (21700 ns)
    TCS: TestCase_testComputeVecSubFloat32, time elapsed: 43000 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSubFloat32 (22600 ns)
    TCS: TestCase_testComputeVecSubFloat32Vec4, time elapsed: 53400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSubFloat32Vec4 (19400 ns)
    TCS: TestCase_testComputeEqualInt32Equal, time elapsed: 58900 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt32Equal (24300 ns)
    TCS: TestCase_testComputeEqualInt32NotEqual, time elapsed: 29900 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt32NotEqual (9600 ns)
    TCS: TestCase_testComputeEqualFloat32Equal, time elapsed: 36100 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32Equal (10200 ns)
    TCS: TestCase_testComputeEqualFloat32NotEqual, time elapsed: 27000 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32NotEqual (7600 ns)
    TCS: TestCase_testComputeEqualFloat64Equal, time elapsed: 28500 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64Equal (8800 ns)
    TCS: TestCase_testComputeEqualFloat64NotEqual, time elapsed: 18800 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64NotEqual (4500 ns)
    TCS: TestCase_testComputeEqualBoolEqual, time elapsed: 20700 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualBoolEqual (5300 ns)
    TCS: TestCase_testComputeEqualBoolNotEqual, time elapsed: 19800 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualBoolNotEqual (4500 ns)
    TCS: TestCase_testComputeEqualNumericInt32, time elapsed: 17900 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericInt32 (6400 ns)
    TCS: TestCase_testComputeEqualNumericFloat32, time elapsed: 38100 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32 (21100 ns)
    TCS: TestCase_testComputeEqualNumericFloat32Epsilon, time elapsed: 26800 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32Epsilon (9500 ns)
    TCS: TestCase_testComputeEqualNumericFloat64, time elapsed: 45900 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64 (19400 ns)
    TCS: TestCase_testComputeEqualInt64Equal, time elapsed: 27000 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt64Equal (7300 ns)
    TCS: TestCase_testComputeEqualInt64NotEqual, time elapsed: 35000 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt64NotEqual (7700 ns)
    TCS: TestCase_testComputeEqualFloat32Nan, time elapsed: 37200 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32Nan (16000 ns)
    TCS: TestCase_testComputeEqualFloat64Nan, time elapsed: 31500 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64Nan (13500 ns)
    TCS: TestCase_testComputeEqualFloat32SignedZero, time elapsed: 24100 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32SignedZero (7100 ns)
    TCS: TestCase_testComputeEqualFloat64SignedZero, time elapsed: 31800 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64SignedZero (13800 ns)
    TCS: TestCase_testComputeEqualNumericFloat32NotEqual, time elapsed: 20000 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32NotEqual (8200 ns)
    TCS: TestCase_testComputeEqualNumericFloat32BeyondEpsilon, time elapsed: 21500 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32BeyondEpsilon (9600 ns)
    TCS: TestCase_testComputeEqualNumericFloat64NotEqual, time elapsed: 21500 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64NotEqual (8900 ns)
    TCS: TestCase_testComputeEqualNumericFloat64Epsilon, time elapsed: 21100 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64Epsilon (5500 ns)
    TCS: TestCase_testComputeEqualNumericFloat64BeyondEpsilon, time elapsed: 16500 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64BeyondEpsilon (4900 ns)
    TCS: TestCase_testComputeEqualNumericInt64, time elapsed: 18100 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericInt64 (6500 ns)
    TCS: TestCase_testPackedHighpImplementsQualifier, time elapsed: 23700 ns, RESULT:
    [ PASSED ] CASE: testPackedHighpImplementsQualifier (7400 ns)
    TCS: TestCase_testPackedMediumpImplementsQualifier, time elapsed: 22100 ns, RESULT:
    [ PASSED ] CASE: testPackedMediumpImplementsQualifier (5900 ns)
    TCS: TestCase_testPackedLowpImplementsQualifier, time elapsed: 20700 ns, RESULT:
    [ PASSED ] CASE: testPackedLowpImplementsQualifier (4100 ns)
    TCS: TestCase_testDefaultpIsPackedHighp, time elapsed: 17100 ns, RESULT:
    [ PASSED ] CASE: testDefaultpIsPackedHighp (4700 ns)
    TCS: TestCase_testScalarAddVec1, time elapsed: 25200 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec1 (9400 ns)
    TCS: TestCase_testScalarAddVec2, time elapsed: 19900 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec2 (8000 ns)
    TCS: TestCase_testScalarAddVec3, time elapsed: 24200 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec3 (7000 ns)
    TCS: TestCase_testScalarAddVec4, time elapsed: 17800 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec4 (5900 ns)
    TCS: TestCase_testScalarSubVec1, time elapsed: 24000 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1 (7900 ns)
    TCS: TestCase_testScalarMulVec1, time elapsed: 19800 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1 (7800 ns)
    TCS: TestCase_testScalarDivVec1, time elapsed: 27900 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1 (16300 ns)
    TCS: TestCase_testScalarModVec1, time elapsed: 21800 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1 (9900 ns)
    TCS: TestCase_testScalarMulVec2, time elapsed: 23300 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2 (10600 ns)
    TCS: TestCase_testScalarSubVec2, time elapsed: 16900 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2 (5300 ns)
    TCS: TestCase_testScalarSubVec3, time elapsed: 24600 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3 (6200 ns)
    TCS: TestCase_testScalarSubVec4, time elapsed: 18900 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4 (7300 ns)
    TCS: TestCase_testScalarMulVec3, time elapsed: 17200 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3 (5000 ns)
    TCS: TestCase_testScalarMulVec4, time elapsed: 18200 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4 (6700 ns)
    TCS: TestCase_testScalarDivVec2, time elapsed: 16000 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2 (5300 ns)
    TCS: TestCase_testScalarDivVec3, time elapsed: 21500 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3 (6300 ns)
    TCS: TestCase_testScalarDivVec4, time elapsed: 18700 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4 (7200 ns)
    TCS: TestCase_testScalarModVec2, time elapsed: 31700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2 (5100 ns)
    TCS: TestCase_testScalarModVec3, time elapsed: 18600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3 (6500 ns)
    TCS: TestCase_testScalarModVec4, time elapsed: 23700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4 (6300 ns)
    TCS: TestCase_testScalarModVec1Float32, time elapsed: 25500 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Float32 (13600 ns)
    TCS: TestCase_testScalarModVec2Float32, time elapsed: 23400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32 (6400 ns)
    TCS: TestCase_testScalarModVec3Float32, time elapsed: 17000 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Float32 (5600 ns)
    TCS: TestCase_testScalarModVec4Float32, time elapsed: 22200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Float32 (6600 ns)
    TCS: TestCase_testScalarModVec1Float64, time elapsed: 19400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Float64 (8000 ns)
    TCS: TestCase_testScalarModVec2Float64, time elapsed: 22200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float64 (10100 ns)
    TCS: TestCase_testScalarModVec3Float64, time elapsed: 16300 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Float64 (5000 ns)
    TCS: TestCase_testScalarModVec4Float64, time elapsed: 21000 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Float64 (9700 ns)
    TCS: TestCase_testScalarModVec1Float16, time elapsed: 25800 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Float16 (14100 ns)
    TCS: TestCase_testScalarModVec2Float16, time elapsed: 22200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float16 (10600 ns)
    TCS: TestCase_testScalarModVec3Float16, time elapsed: 17300 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Float16 (5500 ns)
    TCS: TestCase_testScalarModVec4Float16, time elapsed: 18100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Float16 (6100 ns)
    TCS: TestCase_testScalarSubVec2PackedMediump, time elapsed: 21000 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2PackedMediump (8200 ns)
    TCS: TestCase_testScalarSubVec2PackedLowp, time elapsed: 19900 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2PackedLowp (8000 ns)
    TCS: TestCase_testScalarMulVec2PackedMediump, time elapsed: 23200 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2PackedMediump (6700 ns)
    TCS: TestCase_testScalarMulVec2PackedLowp, time elapsed: 19100 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2PackedLowp (6500 ns)
    TCS: TestCase_testScalarDivVec2PackedMediump, time elapsed: 21600 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2PackedMediump (5100 ns)
    TCS: TestCase_testScalarDivVec2PackedLowp, time elapsed: 19800 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2PackedLowp (6900 ns)
    TCS: TestCase_testScalarModVec2PackedMediump, time elapsed: 35800 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2PackedMediump (12200 ns)
    TCS: TestCase_testScalarModVec2PackedLowp, time elapsed: 23500 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2PackedLowp (6600 ns)
    TCS: TestCase_testScalarModVec2Float32PackedMediump, time elapsed: 25300 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32PackedMediump (7000 ns)
    TCS: TestCase_testScalarModVec2Float32PackedLowp, time elapsed: 17700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32PackedLowp (5300 ns)
    TCS: TestCase_testScalarModVec2Float32NegativeDividend, time elapsed: 21900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32NegativeDividend (10300 ns)
    TCS: TestCase_testScalarModVec2Float32NegativeDivisor, time elapsed: 16400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32NegativeDivisor (4700 ns)
    TCS: TestCase_testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents, time elapsed: 145700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents (128100 ns)
    TCS: TestCase_testScalarAddVec1Float32, time elapsed: 20800 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec1Float32 (7600 ns)
    TCS: TestCase_testScalarAddVec2Float32, time elapsed: 22200 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec2Float32 (10500 ns)
    TCS: TestCase_testScalarAddVec3Float32, time elapsed: 17600 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec3Float32 (5600 ns)
    TCS: TestCase_testScalarAddVec4Float32, time elapsed: 21700 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec4Float32 (5700 ns)
    TCS: TestCase_testScalarSubVec1Float32, time elapsed: 18400 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1Float32 (6800 ns)
    TCS: TestCase_testScalarSubVec2Float32, time elapsed: 17300 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2Float32 (6000 ns)
    TCS: TestCase_testScalarSubVec3Float32, time elapsed: 15900 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3Float32 (4500 ns)
    TCS: TestCase_testScalarSubVec4Float32, time elapsed: 17400 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4Float32 (5400 ns)
    TCS: TestCase_testScalarMulVec1Float32, time elapsed: 20500 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1Float32 (4600 ns)
    TCS: TestCase_testScalarMulVec2Float32, time elapsed: 17100 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2Float32 (5000 ns)
    TCS: TestCase_testScalarMulVec3Float32, time elapsed: 22400 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3Float32 (5000 ns)
    TCS: TestCase_testScalarMulVec4Float32, time elapsed: 19100 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4Float32 (5700 ns)
    TCS: TestCase_testScalarDivVec1Float32, time elapsed: 28400 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1Float32 (5800 ns)
    TCS: TestCase_testScalarDivVec2Float32, time elapsed: 19200 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2Float32 (4900 ns)
    TCS: TestCase_testScalarDivVec3Float32, time elapsed: 22700 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3Float32 (4900 ns)
    TCS: TestCase_testScalarDivVec4Float32, time elapsed: 16900 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4Float32 (5200 ns)
    TCS: TestCase_testScalarAddVec1Int32, time elapsed: 27900 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec1Int32 (11600 ns)
    TCS: TestCase_testScalarAddVec2Int32, time elapsed: 17800 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec2Int32 (5700 ns)
    TCS: TestCase_testScalarAddVec3Int32, time elapsed: 24900 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec3Int32 (12000 ns)
    TCS: TestCase_testScalarAddVec4Int32, time elapsed: 19600 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec4Int32 (7000 ns)
    TCS: TestCase_testScalarSubVec1Int32, time elapsed: 25200 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1Int32 (8000 ns)
    TCS: TestCase_testScalarSubVec2Int32, time elapsed: 18700 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2Int32 (5000 ns)
    TCS: TestCase_testScalarSubVec3Int32, time elapsed: 23900 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3Int32 (11500 ns)
    TCS: TestCase_testScalarSubVec4Int32, time elapsed: 17400 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4Int32 (5400 ns)
    TCS: TestCase_testScalarMulVec1Int32, time elapsed: 25100 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1Int32 (6600 ns)
    TCS: TestCase_testScalarMulVec2Int32, time elapsed: 16700 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2Int32 (4700 ns)
    TCS: TestCase_testScalarMulVec3Int32, time elapsed: 17000 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3Int32 (5000 ns)
    TCS: TestCase_testScalarMulVec4Int32, time elapsed: 17700 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4Int32 (5300 ns)
    TCS: TestCase_testScalarDivVec1Int32, time elapsed: 16700 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1Int32 (4800 ns)
    TCS: TestCase_testScalarDivVec2Int32, time elapsed: 27600 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2Int32 (7900 ns)
    TCS: TestCase_testScalarDivVec3Int32, time elapsed: 18200 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3Int32 (5700 ns)
    TCS: TestCase_testScalarDivVec4Int32, time elapsed: 23800 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4Int32 (5300 ns)
    TCS: TestCase_testScalarModVec1Int32, time elapsed: 19000 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Int32 (6200 ns)
    TCS: TestCase_testScalarModVec2Int32, time elapsed: 21000 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Int32 (4600 ns)
    TCS: TestCase_testScalarModVec3Int32, time elapsed: 18100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Int32 (5800 ns)
    TCS: TestCase_testScalarModVec4Int32, time elapsed: 27600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Int32 (5700 ns)
    TCS: TestCase_testScalarSubVec1PackedMediump, time elapsed: 18800 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1PackedMediump (6900 ns)
    TCS: TestCase_testScalarSubVec1PackedLowp, time elapsed: 22300 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1PackedLowp (10500 ns)
    TCS: TestCase_testScalarSubVec3PackedMediump, time elapsed: 18100 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3PackedMediump (6000 ns)
    TCS: TestCase_testScalarSubVec3PackedLowp, time elapsed: 25500 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3PackedLowp (7800 ns)
    TCS: TestCase_testScalarSubVec4PackedMediump, time elapsed: 17700 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4PackedMediump (5800 ns)
    TCS: TestCase_testScalarSubVec4PackedLowp, time elapsed: 22500 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4PackedLowp (10300 ns)
    TCS: TestCase_testScalarMulVec1PackedMediump, time elapsed: 17300 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1PackedMediump (4800 ns)
    TCS: TestCase_testScalarMulVec1PackedLowp, time elapsed: 20800 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1PackedLowp (4800 ns)
    TCS: TestCase_testScalarMulVec3PackedMediump, time elapsed: 17200 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3PackedMediump (5400 ns)
    TCS: TestCase_testScalarMulVec3PackedLowp, time elapsed: 16700 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3PackedLowp (4700 ns)
    TCS: TestCase_testScalarMulVec4PackedMediump, time elapsed: 16400 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4PackedMediump (4600 ns)
    TCS: TestCase_testScalarMulVec4PackedLowp, time elapsed: 16400 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4PackedLowp (4700 ns)
    TCS: TestCase_testScalarDivVec1PackedMediump, time elapsed: 21500 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1PackedMediump (4400 ns)
    TCS: TestCase_testScalarDivVec1PackedLowp, time elapsed: 16400 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1PackedLowp (4800 ns)
    TCS: TestCase_testScalarDivVec3PackedMediump, time elapsed: 21200 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3PackedMediump (5100 ns)
    TCS: TestCase_testScalarDivVec3PackedLowp, time elapsed: 27300 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3PackedLowp (15800 ns)
    TCS: TestCase_testScalarDivVec4PackedMediump, time elapsed: 21800 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4PackedMediump (5500 ns)
    TCS: TestCase_testScalarDivVec4PackedLowp, time elapsed: 16700 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4PackedLowp (4900 ns)
    TCS: TestCase_testScalarModVec1PackedMediump, time elapsed: 21500 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1PackedMediump (5200 ns)
    TCS: TestCase_testScalarModVec1PackedLowp, time elapsed: 16200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1PackedLowp (4200 ns)
    TCS: TestCase_testScalarModVec3PackedMediump, time elapsed: 20200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3PackedMediump (8900 ns)
    TCS: TestCase_testScalarModVec3PackedLowp, time elapsed: 18200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3PackedLowp (4900 ns)
    TCS: TestCase_testScalarModVec4PackedMediump, time elapsed: 20100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4PackedMediump (8900 ns)
    TCS: TestCase_testScalarModVec4PackedLowp, time elapsed: 16700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4PackedLowp (4600 ns)
    TCS: TestCase_testScalarDivZeroVec1, time elapsed: 34700 ns, RESULT:
    [ PASSED ] CASE: testScalarDivZeroVec1 (18100 ns)
    TCS: TestCase_testScalarAddNegVec1, time elapsed: 22100 ns, RESULT:
    [ PASSED ] CASE: testScalarAddNegVec1 (6900 ns)
    TCS: TestCase_testScalarAddNegVec2, time elapsed: 29600 ns, RESULT:
    [ PASSED ] CASE: testScalarAddNegVec2 (8000 ns)
    TCS: TestCase_testScalarMulOverflowVec1, time elapsed: 17400 ns, RESULT:
    [ PASSED ] CASE: testScalarMulOverflowVec1 (5300 ns)
    TCS: TestCase_testScalarSubNegVec1, time elapsed: 18300 ns, RESULT:
    [ PASSED ] CASE: testScalarSubNegVec1 (6700 ns)
    TCS: TestCase_testVersionMajor, time elapsed: 17200 ns, RESULT:
    [ PASSED ] CASE: testVersionMajor (5100 ns)
    TCS: TestCase_testVersionMinor, time elapsed: 15900 ns, RESULT:
    [ PASSED ] CASE: testVersionMinor (4300 ns)
    TCS: TestCase_testVersionPatch, time elapsed: 21200 ns, RESULT:
    [ PASSED ] CASE: testVersionPatch (4200 ns)
    TCS: TestCase_testVersionEncoded, time elapsed: 19200 ns, RESULT:
    [ PASSED ] CASE: testVersionEncoded (7100 ns)
    TCS: TestCase_testConfigSimd, time elapsed: 21400 ns, RESULT:
    [ PASSED ] CASE: testConfigSimd (6600 ns)
    TCS: TestCase_testConfigAlignedGentypes, time elapsed: 17000 ns, RESULT:
    [ PASSED ] CASE: testConfigAlignedGentypes (4800 ns)
    TCS: TestCase_testConfigClipControl, time elapsed: 19400 ns, RESULT:
    [ PASSED ] CASE: testConfigClipControl (4600 ns)
    TCS: TestCase_testConstNegationSimd, time elapsed: 16700 ns, RESULT:
    [ PASSED ] CASE: testConstNegationSimd (5100 ns)
    TCS: TestCase_testConstNegationAligned, time elapsed: 22400 ns, RESULT:
    [ PASSED ] CASE: testConstNegationAligned (9600 ns)
    TCS: TestCase_testConstNegationClip, time elapsed: 15900 ns, RESULT:
    [ PASSED ] CASE: testConstNegationClip (4300 ns)
    TCS: TestCase_testConstInt64Usage, time elapsed: 21500 ns, RESULT:
    [ PASSED ] CASE: testConstInt64Usage (4300 ns)
    TCS: TestCase_testConstBoolUsage, time elapsed: 17500 ns, RESULT:
    [ PASSED ] CASE: testConstBoolUsage (4700 ns)
    TCS: TestCase_testVersionEncodingConsistency, time elapsed: 19700 ns, RESULT:
    [ PASSED ] CASE: testVersionEncodingConsistency (8400 ns)
    TCS: TestCase_testAssertPasses, time elapsed: 20700 ns, RESULT:
    [ PASSED ] CASE: testAssertPasses (9200 ns)
    TCS: TestCase_testAssertFails, time elapsed: 60000 ns, RESULT:
    [ PASSED ] CASE: testAssertFails (43500 ns)
    TCS: TestCase_testAssertWithCustomMessage, time elapsed: 47700 ns, RESULT:
    [ PASSED ] CASE: testAssertWithCustomMessage (34200 ns)
    TCS: TestCase_testNumericLimitsFloat32Epsilon, time elapsed: 19700 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsFloat32Epsilon (6500 ns)
    TCS: TestCase_testNumericLimitsFloat64Epsilon, time elapsed: 19300 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsFloat64Epsilon (7600 ns)
    TCS: TestCase_testIsIec559OfFloat32, time elapsed: 16200 ns, RESULT:
    [ PASSED ] CASE: testIsIec559OfFloat32 (4400 ns)
    TCS: TestCase_testIsIec559OfFloat64, time elapsed: 19900 ns, RESULT:
    [ PASSED ] CASE: testIsIec559OfFloat64 (4200 ns)
    TCS: TestCase_testIsIec559OfInt64, time elapsed: 18200 ns, RESULT:
    [ PASSED ] CASE: testIsIec559OfInt64 (6400 ns)
    TCS: TestCase_testEpsilonOfFloat32, time elapsed: 22000 ns, RESULT:
    [ PASSED ] CASE: testEpsilonOfFloat32 (5200 ns)
    TCS: TestCase_testEpsilonOfFloat64, time elapsed: 16900 ns, RESULT:
    [ PASSED ] CASE: testEpsilonOfFloat64 (5400 ns)
    TCS: TestCase_testNumericLimitsInt64Epsilon, time elapsed: 20800 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt64Epsilon (5600 ns)
    TCS: TestCase_testNumericLimitsInt32Epsilon, time elapsed: 19000 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt32Epsilon (7700 ns)
    TCS: TestCase_testNumericLimitsInt16Epsilon, time elapsed: 23700 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt16Epsilon (8600 ns)
    TCS: TestCase_testNumericLimitsInt8Epsilon, time elapsed: 20700 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt8Epsilon (8300 ns)
    TCS: TestCase_testCastVec1ToVec1IntToFloat, time elapsed: 25100 ns, RESULT:
    [ PASSED ] CASE: testCastVec1ToVec1IntToFloat (13200 ns)
    TCS: TestCase_testCastVec2ToVec1TakesOnlyX, time elapsed: 16900 ns, RESULT:
    [ PASSED ] CASE: testCastVec2ToVec1TakesOnlyX (5300 ns)
    TCS: TestCase_testCastVec3ToVec1TakesOnlyX, time elapsed: 21900 ns, RESULT:
    [ PASSED ] CASE: testCastVec3ToVec1TakesOnlyX (9500 ns)
    TCS: TestCase_testCastVec4ToVec1TakesOnlyX, time elapsed: 17000 ns, RESULT:
    [ PASSED ] CASE: testCastVec4ToVec1TakesOnlyX (4900 ns)
    TCS: TestCase_testCastSameTypeIdentity, time elapsed: 21100 ns, RESULT:
    [ PASSED ] CASE: testCastSameTypeIdentity (9400 ns)
    TCS: TestCase_testCastInt32ToInt64, time elapsed: 17700 ns, RESULT:
    [ PASSED ] CASE: testCastInt32ToInt64 (5700 ns)
    TCS: TestCase_testCastFloatToIntTruncation, time elapsed: 16000 ns, RESULT:
    [ PASSED ] CASE: testCastFloatToIntTruncation (4800 ns)
    TCS: TestCase_testCastCrossQualifierPackedHighpToDefaultp, time elapsed: 16700 ns, RESULT:
    [ PASSED ] CASE: testCastCrossQualifierPackedHighpToDefaultp (4900 ns)
    TCS: TestCase_testCastCrossQualifierDefaultpToPackedHighp, time elapsed: 16500 ns, RESULT:
    [ PASSED ] CASE: testCastCrossQualifierDefaultpToPackedHighp (5300 ns)
    TCS: TestCase_testCastVec2CrossQualifierCrossType, time elapsed: 20900 ns, RESULT:
    [ PASSED ] CASE: testCastVec2CrossQualifierCrossType (6100 ns)
    TCS: TestCase_testCastVec3CrossQualifier, time elapsed: 16900 ns, RESULT:
    [ PASSED ] CASE: testCastVec3CrossQualifier (4900 ns)
    TCS: TestCase_testCastVec4CrossQualifier, time elapsed: 22200 ns, RESULT:
    [ PASSED ] CASE: testCastVec4CrossQualifier (4900 ns)
    TCS: TestCase_testCastVec1DoesNotModifySource, time elapsed: 16400 ns, RESULT:
    [ PASSED ] CASE: testCastVec1DoesNotModifySource (4600 ns)
    TCS: TestCase_testCastVec2Vec1ToVec2IntToFloat, time elapsed: 21600 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec1ToVec2IntToFloat (5500 ns)
    TCS: TestCase_testCastVec2Vec2ToVec2Identity, time elapsed: 19400 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec2ToVec2Identity (7400 ns)
    TCS: TestCase_testCastVec2Vec3ToVec2TakesOnlyXY, time elapsed: 20200 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec3ToVec2TakesOnlyXY (5300 ns)
    TCS: TestCase_testCastVec2Vec4ToVec2TakesOnlyXY, time elapsed: 19100 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec4ToVec2TakesOnlyXY (7500 ns)
    TCS: TestCase_testCastVec2SameTypeIdentity, time elapsed: 21700 ns, RESULT:
    [ PASSED ] CASE: testCastVec2SameTypeIdentity (4800 ns)
    TCS: TestCase_testCastVec2Int32ToInt64, time elapsed: 18100 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Int32ToInt64 (5800 ns)
    TCS: TestCase_testCastVec2FloatToIntTruncation, time elapsed: 22200 ns, RESULT:
    [ PASSED ] CASE: testCastVec2FloatToIntTruncation (8700 ns)
    TCS: TestCase_testCastVec2CrossQualifierPackedHighpToDefaultp, time elapsed: 16500 ns, RESULT:
    [ PASSED ] CASE: testCastVec2CrossQualifierPackedHighpToDefaultp (5000 ns)
    TCS: TestCase_testCastVec2DoesNotModifySource, time elapsed: 20200 ns, RESULT:
    [ PASSED ] CASE: testCastVec2DoesNotModifySource (8600 ns)
    TCS: TestCase_testCastVec2Vec1ToVec2SameValueBothComponents, time elapsed: 17100 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec1ToVec2SameValueBothComponents (5100 ns)
    TCS: TestCase_testCastVec3Vec1ToVec3IntToFloat, time elapsed: 22700 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec1ToVec3IntToFloat (10600 ns)
    TCS: TestCase_testCastVec3Vec2ToVec3ExtendY, time elapsed: 21500 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec2ToVec3ExtendY (8000 ns)
    TCS: TestCase_testCastVec3Vec3ToVec3Identity, time elapsed: 22900 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec3ToVec3Identity (5500 ns)
    TCS: TestCase_testCastVec3Vec4ToVec3TakesOnlyXYZ, time elapsed: 20700 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec4ToVec3TakesOnlyXYZ (7400 ns)
    TCS: TestCase_testCastVec3SameTypeIdentity, time elapsed: 17700 ns, RESULT:
    [ PASSED ] CASE: testCastVec3SameTypeIdentity (4900 ns)
    TCS: TestCase_testCastVec3Int32ToInt64, time elapsed: 19300 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Int32ToInt64 (6100 ns)
    TCS: TestCase_testCastVec3FloatToIntTruncation, time elapsed: 18000 ns, RESULT:
    [ PASSED ] CASE: testCastVec3FloatToIntTruncation (5100 ns)
    TCS: TestCase_testCastVec3CrossQualifierPackedHighpToDefaultp, time elapsed: 23400 ns, RESULT:
    [ PASSED ] CASE: testCastVec3CrossQualifierPackedHighpToDefaultp (5300 ns)
    TCS: TestCase_testCastVec3DoesNotModifySource, time elapsed: 17900 ns, RESULT:
    [ PASSED ] CASE: testCastVec3DoesNotModifySource (5500 ns)
    TCS: TestCase_testCastVec3Vec1ToVec3SameValueAllComponents, time elapsed: 23600 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec1ToVec3SameValueAllComponents (5800 ns)
    TCS: TestCase_testCastVec4Vec1ToVec4IntToFloat, time elapsed: 21300 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec1ToVec4IntToFloat (8700 ns)
    TCS: TestCase_testCastVec4Vec2ToVec4ExtendY, time elapsed: 23200 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec2ToVec4ExtendY (6000 ns)
    TCS: TestCase_testCastVec4Vec3ToVec4ExtendZ, time elapsed: 20900 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec3ToVec4ExtendZ (7900 ns)
    TCS: TestCase_testCastVec4Vec4ToVec4Identity, time elapsed: 29400 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec4ToVec4Identity (9000 ns)
    TCS: TestCase_testCastVec4SameTypeIdentity, time elapsed: 36500 ns, RESULT:
    [ PASSED ] CASE: testCastVec4SameTypeIdentity (13200 ns)
    TCS: TestCase_testCastVec4Int32ToInt64, time elapsed: 27700 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Int32ToInt64 (6700 ns)
    TCS: TestCase_testCastVec4FloatToIntTruncation, time elapsed: 18900 ns, RESULT:
    [ PASSED ] CASE: testCastVec4FloatToIntTruncation (5600 ns)
    TCS: TestCase_testCastVec4CrossQualifierPackedHighpToDefaultp, time elapsed: 24600 ns, RESULT:
    [ PASSED ] CASE: testCastVec4CrossQualifierPackedHighpToDefaultp (10900 ns)
    TCS: TestCase_testCastVec4DoesNotModifySource, time elapsed: 21600 ns, RESULT:
    [ PASSED ] CASE: testCastVec4DoesNotModifySource (6700 ns)
    TCS: TestCase_testCastVec4Vec1ToVec4SameValueAllComponents, time elapsed: 41600 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec1ToVec4SameValueAllComponents (7400 ns)
    TCS: TestCase_testFromBoolVec1, time elapsed: 23900 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec1 (9200 ns)
    TCS: TestCase_testFromBoolVec1False, time elapsed: 25400 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec1False (10000 ns)
    TCS: TestCase_testFromBoolVec2, time elapsed: 21800 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec2 (7300 ns)
    TCS: TestCase_testFromBoolVec3, time elapsed: 27700 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec3 (8300 ns)
    TCS: TestCase_testFromBoolVec4, time elapsed: 21000 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec4 (6800 ns)
    TCS: TestCase_testFromBoolVecQ2Vec1, time elapsed: 17500 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec1 (5000 ns)
    TCS: TestCase_testFromBoolVecQ2Vec2, time elapsed: 24600 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec2 (10000 ns)
    TCS: TestCase_testFromBoolVecQ2Vec3, time elapsed: 27300 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec3 (8500 ns)
    TCS: TestCase_testFromBoolVecQ2Vec4, time elapsed: 43000 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec4 (10800 ns)
    TCS: TestCase_testFromBoolVec3AllFalse, time elapsed: 19600 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec3AllFalse (5500 ns)
    TCS: TestCase_testFromBoolVec4AllFalse, time elapsed: 23300 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec4AllFalse (5400 ns)
    TCS: TestCase_testFromBoolVecQ2Vec3AllFalse, time elapsed: 18400 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec3AllFalse (5100 ns)
    TCS: TestCase_testFromBoolVecQ2Vec4AllFalse, time elapsed: 22400 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec4AllFalse (4800 ns)
    TCS: TestCase_testFromBoolVecFloat32, time elapsed: 19800 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecFloat32 (6600 ns)
    TCS: TestCase_testFromBoolVecFloat64, time elapsed: 24600 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecFloat64 (7600 ns)
    TCS: TestCase_testFromBoolVecInt32, time elapsed: 21600 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecInt32 (7400 ns)
    TCS: TestCase_testFromBoolVecQ2PackedMediump, time elapsed: 25600 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2PackedMediump (11600 ns)
    TCS: TestCase_testFromBoolVecQ2PackedLowp, time elapsed: 24100 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2PackedLowp (9500 ns)
    TCS: TestCase_testS1QuatCastScalingXBranch, time elapsed: 109800 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastScalingXBranch (88800 ns)
    TCS: TestCase_testS1QuatCastScalingYBranch, time elapsed: 66000 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastScalingYBranch (27000 ns)
    TCS: TestCase_testS1QuatCastScalingZBranch, time elapsed: 61000 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastScalingZBranch (36500 ns)
    TCS: TestCase_testS1QuatCastScalingWBranch, time elapsed: 34500 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastScalingWBranch (13700 ns)
    TCS: TestCase_testS1QuatCastUnitRoundTrip, time elapsed: 30200 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastUnitRoundTrip (9500 ns)
    TCS: TestCase_testS1QuatCastIdentityRoundTrip, time elapsed: 21600 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastIdentityRoundTrip (8900 ns)
    TCS: TestCase_testS1QuatCastMat4Delegation, time elapsed: 54000 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastMat4Delegation (27500 ns)
    TCS: TestCase_testMat3EqualEpsilonRelaxedExactMatch, time elapsed: 21800 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedExactMatch (6100 ns)
    TCS: TestCase_testMat3EqualEpsilonRelaxedWithinPosTolerance, time elapsed: 28400 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedWithinPosTolerance (7300 ns)
    TCS: TestCase_testMat3EqualEpsilonRelaxedWithinNegTolerance, time elapsed: 32100 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedWithinNegTolerance (9900 ns)
    TCS: TestCase_testMat3EqualEpsilonRelaxedBeyondTolerance, time elapsed: 28600 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedBeyondTolerance (5400 ns)
    TCS: TestCase_testMat3EqualEpsilonRelaxedZeroMatrix, time elapsed: 20500 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedZeroMatrix (5800 ns)
    TCS: TestCase_testMat3EqualEpsilonRelaxedSingleDiffBeyond, time elapsed: 25900 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedSingleDiffBeyond (6500 ns)
    TCS: TestCase_testVec2ScalarInit, time elapsed: 27300 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarInit (13200 ns)
    TCS: TestCase_testVec2ConstInit, time elapsed: 31000 ns, RESULT:
    [ PASSED ] CASE: testVec2ConstInit (9400 ns)
    TCS: TestCase_testVec2Length, time elapsed: 21800 ns, RESULT:
    [ PASSED ] CASE: testVec2Length (6800 ns)
    TCS: TestCase_testVec2Add, time elapsed: 31700 ns, RESULT:
    [ PASSED ] CASE: testVec2Add (11600 ns)
    TCS: TestCase_testVec2Sub, time elapsed: 20200 ns, RESULT:
    [ PASSED ] CASE: testVec2Sub (8100 ns)
    TCS: TestCase_testVec2Mul, time elapsed: 25100 ns, RESULT:
    [ PASSED ] CASE: testVec2Mul (13200 ns)
    TCS: TestCase_testVec2ScalarAdd, time elapsed: 22400 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarAdd (9000 ns)
    TCS: TestCase_testVec2Negate, time elapsed: 26500 ns, RESULT:
    [ PASSED ] CASE: testVec2Negate (12600 ns)
    TCS: TestCase_testVec2IndexAccess, time elapsed: 21300 ns, RESULT:
    [ PASSED ] CASE: testVec2IndexAccess (7100 ns)
    TCS: TestCase_testVec2IndexMutate, time elapsed: 25900 ns, RESULT:
    [ PASSED ] CASE: testVec2IndexMutate (12800 ns)
    TCS: TestCase_testVec2ComponentAt, time elapsed: 25800 ns, RESULT:
    [ PASSED ] CASE: testVec2ComponentAt (9200 ns)
    TCS: TestCase_testVec2Equal, time elapsed: 34900 ns, RESULT:
    [ PASSED ] CASE: testVec2Equal (18500 ns)
    TCS: TestCase_testVec2NotEqual, time elapsed: 28900 ns, RESULT:
    [ PASSED ] CASE: testVec2NotEqual (11200 ns)
    TCS: TestCase_testVec2EqualExact, time elapsed: 24800 ns, RESULT:
    [ PASSED ] CASE: testVec2EqualExact (9800 ns)
    TCS: TestCase_testVec2BitwiseAnd, time elapsed: 26900 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseAnd (9000 ns)
    TCS: TestCase_testVec2BitwiseNot, time elapsed: 20700 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseNot (8000 ns)
    TCS: TestCase_testVec2FromVec1, time elapsed: 23500 ns, RESULT:
    [ PASSED ] CASE: testVec2FromVec1 (5600 ns)
    TCS: TestCase_testVec2ShiftLeft, time elapsed: 20000 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftLeft (8100 ns)
    TCS: TestCase_testVec2BoolLogicalAnd, time elapsed: 23400 ns, RESULT:
    [ PASSED ] CASE: testVec2BoolLogicalAnd (6800 ns)
    TCS: TestCase_testVec2Vec1ArithBroadcast, time elapsed: 25200 ns, RESULT:
    [ PASSED ] CASE: testVec2Vec1ArithBroadcast (11000 ns)
    TCS: TestCase_testVec2Vec1BitBroadcast, time elapsed: 25500 ns, RESULT:
    [ PASSED ] CASE: testVec2Vec1BitBroadcast (9500 ns)
    TCS: TestCase_testVec2ShiftLeftVec1, time elapsed: 18500 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftLeftVec1 (6500 ns)
    TCS: TestCase_testVec2Div, time elapsed: 25700 ns, RESULT:
    [ PASSED ] CASE: testVec2Div (11700 ns)
    TCS: TestCase_testVec2Mod, time elapsed: 19200 ns, RESULT:
    [ PASSED ] CASE: testVec2Mod (7100 ns)
    TCS: TestCase_testVec2ScalarSub, time elapsed: 25500 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarSub (12300 ns)
    TCS: TestCase_testVec2ScalarMul, time elapsed: 18600 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarMul (6900 ns)
    TCS: TestCase_testVec2ScalarDiv, time elapsed: 22000 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarDiv (9900 ns)
    TCS: TestCase_testVec2ScalarMod, time elapsed: 18100 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarMod (5000 ns)
    TCS: TestCase_testVec2BoolLogicalOr, time elapsed: 17700 ns, RESULT:
    [ PASSED ] CASE: testVec2BoolLogicalOr (4900 ns)
    TCS: TestCase_testVec2EqualEpsilon, time elapsed: 29900 ns, RESULT:
    [ PASSED ] CASE: testVec2EqualEpsilon (14700 ns)
    TCS: TestCase_testVec2DivNamed, time elapsed: 27400 ns, RESULT:
    [ PASSED ] CASE: testVec2DivNamed (7000 ns)
    TCS: TestCase_testVec2ModNamed, time elapsed: 18100 ns, RESULT:
    [ PASSED ] CASE: testVec2ModNamed (4900 ns)
    TCS: TestCase_testVec2BitwiseOr, time elapsed: 22400 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseOr (7700 ns)
    TCS: TestCase_testVec2BitwiseXor, time elapsed: 22900 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseXor (6500 ns)
    TCS: TestCase_testVec2ScalarBitwiseAnd, time elapsed: 17600 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarBitwiseAnd (5400 ns)
    TCS: TestCase_testVec2ShiftRight, time elapsed: 22200 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftRight (4800 ns)
    TCS: TestCase_testVec2ShiftRightVec1, time elapsed: 18900 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftRightVec1 (6200 ns)
    TCS: TestCase_testVec2AddNamed, time elapsed: 21900 ns, RESULT:
    [ PASSED ] CASE: testVec2AddNamed (5100 ns)
    TCS: TestCase_testVec2SubNamed, time elapsed: 22500 ns, RESULT:
    [ PASSED ] CASE: testVec2SubNamed (8100 ns)
    TCS: TestCase_testVec2MulNamed, time elapsed: 22900 ns, RESULT:
    [ PASSED ] CASE: testVec2MulNamed (5000 ns)
    TCS: TestCase_testVec2ShiftLeftVec, time elapsed: 17800 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftLeftVec (4800 ns)
    TCS: TestCase_testVec2ShiftRightVec, time elapsed: 22300 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftRightVec (9500 ns)
    TCS: TestCase_testVec2ScalarBitwiseOr, time elapsed: 18700 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarBitwiseOr (6400 ns)
    TCS: TestCase_testVec2ScalarBitwiseXor, time elapsed: 23300 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarBitwiseXor (10700 ns)
    TCS: TestCase_testVec2Increment, time elapsed: 20200 ns, RESULT:
    [ PASSED ] CASE: testVec2Increment (8100 ns)
    TCS: TestCase_testVec2Decrement, time elapsed: 23200 ns, RESULT:
    [ PASSED ] CASE: testVec2Decrement (10800 ns)
    TCS: TestCase_testVec2IndexOutOfBoundsAccess, time elapsed: 66700 ns, RESULT:
    [ PASSED ] CASE: testVec2IndexOutOfBoundsAccess (54100 ns)
    TCS: TestCase_testVec2NegativeIndexAccess, time elapsed: 41100 ns, RESULT:
    [ PASSED ] CASE: testVec2NegativeIndexAccess (16800 ns)
    TCS: TestCase_testVec3ScalarInit, time elapsed: 21900 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarInit (9400 ns)
    TCS: TestCase_testVec3ConstInit, time elapsed: 17400 ns, RESULT:
    [ PASSED ] CASE: testVec3ConstInit (5200 ns)
    TCS: TestCase_testVec3Length, time elapsed: 16900 ns, RESULT:
    [ PASSED ] CASE: testVec3Length (4600 ns)
    TCS: TestCase_testVec3Add, time elapsed: 23200 ns, RESULT:
    [ PASSED ] CASE: testVec3Add (10100 ns)
    TCS: TestCase_testVec3ScalarMul, time elapsed: 28600 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarMul (9800 ns)
    TCS: TestCase_testVec3Negate, time elapsed: 20900 ns, RESULT:
    [ PASSED ] CASE: testVec3Negate (7500 ns)
    TCS: TestCase_testVec3IndexAccess, time elapsed: 24600 ns, RESULT:
    [ PASSED ] CASE: testVec3IndexAccess (5700 ns)
    TCS: TestCase_testVec3IndexMutate, time elapsed: 20300 ns, RESULT:
    [ PASSED ] CASE: testVec3IndexMutate (6800 ns)
    TCS: TestCase_testVec3ComponentAt, time elapsed: 23100 ns, RESULT:
    [ PASSED ] CASE: testVec3ComponentAt (5400 ns)
    TCS: TestCase_testVec3Equal, time elapsed: 23700 ns, RESULT:
    [ PASSED ] CASE: testVec3Equal (10400 ns)
    TCS: TestCase_testVec3NotEqual, time elapsed: 26900 ns, RESULT:
    [ PASSED ] CASE: testVec3NotEqual (9400 ns)
    TCS: TestCase_testVec3EqualExact, time elapsed: 19700 ns, RESULT:
    [ PASSED ] CASE: testVec3EqualExact (7300 ns)
    TCS: TestCase_testVec3BitwiseAnd, time elapsed: 27000 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseAnd (14200 ns)
    TCS: TestCase_testVec3BitwiseNot, time elapsed: 17800 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseNot (6000 ns)
    TCS: TestCase_testVec3Vec1ArithBroadcast, time elapsed: 25400 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1ArithBroadcast (13000 ns)
    TCS: TestCase_testVec3ShiftLeft, time elapsed: 21200 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftLeft (9300 ns)
    TCS: TestCase_testVec3BoolLogicalAnd, time elapsed: 23500 ns, RESULT:
    [ PASSED ] CASE: testVec3BoolLogicalAnd (11700 ns)
    TCS: TestCase_testVec3Sub, time elapsed: 19900 ns, RESULT:
    [ PASSED ] CASE: testVec3Sub (6900 ns)
    TCS: TestCase_testVec3Div, time elapsed: 24100 ns, RESULT:
    [ PASSED ] CASE: testVec3Div (7600 ns)
    TCS: TestCase_testVec3Mod, time elapsed: 21000 ns, RESULT:
    [ PASSED ] CASE: testVec3Mod (8500 ns)
    TCS: TestCase_testVec3ScalarSub, time elapsed: 20300 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarSub (7700 ns)
    TCS: TestCase_testVec3ScalarDiv, time elapsed: 20600 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarDiv (8400 ns)
    TCS: TestCase_testVec3ScalarMod, time elapsed: 18900 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarMod (7100 ns)
    TCS: TestCase_testVec3BoolLogicalOr, time elapsed: 23300 ns, RESULT:
    [ PASSED ] CASE: testVec3BoolLogicalOr (5500 ns)
    TCS: TestCase_testVec3EqualEpsilon, time elapsed: 25000 ns, RESULT:
    [ PASSED ] CASE: testVec3EqualEpsilon (13100 ns)
    TCS: TestCase_testVec3AddNamed, time elapsed: 23000 ns, RESULT:
    [ PASSED ] CASE: testVec3AddNamed (7000 ns)
    TCS: TestCase_testVec3MulNamed, time elapsed: 17500 ns, RESULT:
    [ PASSED ] CASE: testVec3MulNamed (5300 ns)
    TCS: TestCase_testVec3DivNamed, time elapsed: 20800 ns, RESULT:
    [ PASSED ] CASE: testVec3DivNamed (5400 ns)
    TCS: TestCase_testVec3ModNamed, time elapsed: 17700 ns, RESULT:
    [ PASSED ] CASE: testVec3ModNamed (5300 ns)
    TCS: TestCase_testVec3BitwiseOr, time elapsed: 26400 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseOr (9100 ns)
    TCS: TestCase_testVec3BitwiseXor, time elapsed: 21100 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseXor (8300 ns)
    TCS: TestCase_testVec3ScalarBitwiseAnd, time elapsed: 24700 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarBitwiseAnd (11900 ns)
    TCS: TestCase_testVec3ShiftRight, time elapsed: 27600 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftRight (9300 ns)
    TCS: TestCase_testVec3Vec1BitBroadcast, time elapsed: 27300 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1BitBroadcast (13600 ns)
    TCS: TestCase_testVec3ShiftRightVec1, time elapsed: 19100 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftRightVec1 (6800 ns)
    TCS: TestCase_testVec3FromVec1, time elapsed: 22300 ns, RESULT:
    [ PASSED ] CASE: testVec3FromVec1 (10700 ns)
    TCS: TestCase_testVec3ScalarBitwiseOr, time elapsed: 20900 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarBitwiseOr (8100 ns)
    TCS: TestCase_testVec3ScalarBitwiseXor, time elapsed: 25000 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarBitwiseXor (7900 ns)
    TCS: TestCase_testVec3Vec1BitOrBroadcast, time elapsed: 29800 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1BitOrBroadcast (8800 ns)
    TCS: TestCase_testVec3Vec1BitXorBroadcast, time elapsed: 24200 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1BitXorBroadcast (8000 ns)
    TCS: TestCase_testVec3ShiftLeftVec1, time elapsed: 24200 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftLeftVec1 (10500 ns)
    TCS: TestCase_testVec3ShiftLeftVec, time elapsed: 18800 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftLeftVec (5900 ns)
    TCS: TestCase_testVec3ShiftRightVec, time elapsed: 27000 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftRightVec (6300 ns)
    TCS: TestCase_testVec3Increment, time elapsed: 24100 ns, RESULT:
    [ PASSED ] CASE: testVec3Increment (11000 ns)
    TCS: TestCase_testVec3Decrement, time elapsed: 25400 ns, RESULT:
    [ PASSED ] CASE: testVec3Decrement (8600 ns)
    TCS: TestCase_testVec3IndexOutOfBoundsAccess, time elapsed: 40800 ns, RESULT:
    [ PASSED ] CASE: testVec3IndexOutOfBoundsAccess (26900 ns)
    TCS: TestCase_testVec3NegativeIndexAccess, time elapsed: 31700 ns, RESULT:
    [ PASSED ] CASE: testVec3NegativeIndexAccess (11600 ns)
    TCS: TestCase_testVec4ScalarInit, time elapsed: 21000 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarInit (8000 ns)
    TCS: TestCase_testVec4ConstInit, time elapsed: 36500 ns, RESULT:
    [ PASSED ] CASE: testVec4ConstInit (15200 ns)
    TCS: TestCase_testVec4Length, time elapsed: 24500 ns, RESULT:
    [ PASSED ] CASE: testVec4Length (8800 ns)
    TCS: TestCase_testVec4Add, time elapsed: 33000 ns, RESULT:
    [ PASSED ] CASE: testVec4Add (11400 ns)
    TCS: TestCase_testVec4ScalarMul, time elapsed: 23200 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarMul (10700 ns)
    TCS: TestCase_testVec4Negate, time elapsed: 25300 ns, RESULT:
    [ PASSED ] CASE: testVec4Negate (12200 ns)
    TCS: TestCase_testVec4IndexAccess, time elapsed: 17100 ns, RESULT:
    [ PASSED ] CASE: testVec4IndexAccess (5300 ns)
    TCS: TestCase_testVec4IndexMutate, time elapsed: 22200 ns, RESULT:
    [ PASSED ] CASE: testVec4IndexMutate (10600 ns)
    TCS: TestCase_testVec4ComponentAt, time elapsed: 17100 ns, RESULT:
    [ PASSED ] CASE: testVec4ComponentAt (5300 ns)
    TCS: TestCase_testVec4Equal, time elapsed: 36400 ns, RESULT:
    [ PASSED ] CASE: testVec4Equal (24000 ns)
    TCS: TestCase_testVec4NotEqual, time elapsed: 20100 ns, RESULT:
    [ PASSED ] CASE: testVec4NotEqual (7300 ns)
    TCS: TestCase_testVec4EqualExact, time elapsed: 18200 ns, RESULT:
    [ PASSED ] CASE: testVec4EqualExact (6700 ns)
    TCS: TestCase_testVec4BitwiseAnd, time elapsed: 22000 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseAnd (9000 ns)
    TCS: TestCase_testVec4BitwiseNot, time elapsed: 20000 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseNot (6800 ns)
    TCS: TestCase_testVec4Vec1ArithBroadcast, time elapsed: 21200 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1ArithBroadcast (9200 ns)
    TCS: TestCase_testVec4ShiftLeft, time elapsed: 20000 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftLeft (8400 ns)
    TCS: TestCase_testVec4BoolLogicalAnd, time elapsed: 24600 ns, RESULT:
    [ PASSED ] CASE: testVec4BoolLogicalAnd (7100 ns)
    TCS: TestCase_testVec4Sub, time elapsed: 20900 ns, RESULT:
    [ PASSED ] CASE: testVec4Sub (8500 ns)
    TCS: TestCase_testVec4Div, time elapsed: 25400 ns, RESULT:
    [ PASSED ] CASE: testVec4Div (8400 ns)
    TCS: TestCase_testVec4Mod, time elapsed: 20400 ns, RESULT:
    [ PASSED ] CASE: testVec4Mod (8300 ns)
    TCS: TestCase_testVec4ScalarSub, time elapsed: 24200 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarSub (7700 ns)
    TCS: TestCase_testVec4ScalarDiv, time elapsed: 20600 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarDiv (8700 ns)
    TCS: TestCase_testVec4ScalarMod, time elapsed: 24200 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarMod (7900 ns)
    TCS: TestCase_testVec4BoolLogicalOr, time elapsed: 17200 ns, RESULT:
    [ PASSED ] CASE: testVec4BoolLogicalOr (4900 ns)
    TCS: TestCase_testVec4EqualEpsilon, time elapsed: 29600 ns, RESULT:
    [ PASSED ] CASE: testVec4EqualEpsilon (17300 ns)
    TCS: TestCase_testVec4AddNamed, time elapsed: 21200 ns, RESULT:
    [ PASSED ] CASE: testVec4AddNamed (9100 ns)
    TCS: TestCase_testVec4MulNamed, time elapsed: 21400 ns, RESULT:
    [ PASSED ] CASE: testVec4MulNamed (5300 ns)
    TCS: TestCase_testVec4DivNamed, time elapsed: 17700 ns, RESULT:
    [ PASSED ] CASE: testVec4DivNamed (5500 ns)
    TCS: TestCase_testVec4ModNamed, time elapsed: 21700 ns, RESULT:
    [ PASSED ] CASE: testVec4ModNamed (9300 ns)
    TCS: TestCase_testVec4BitwiseOr, time elapsed: 19900 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseOr (8000 ns)
    TCS: TestCase_testVec4BitwiseXor, time elapsed: 23900 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseXor (8000 ns)
    TCS: TestCase_testVec4ScalarBitwiseAnd, time elapsed: 20300 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarBitwiseAnd (7900 ns)
    TCS: TestCase_testVec4ShiftRight, time elapsed: 20400 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftRight (8400 ns)
    TCS: TestCase_testVec4Vec1BitBroadcast, time elapsed: 21400 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1BitBroadcast (9000 ns)
    TCS: TestCase_testVec4ShiftRightVec1, time elapsed: 27200 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftRightVec1 (11700 ns)
    TCS: TestCase_testVec4FromVec1, time elapsed: 34900 ns, RESULT:
    [ PASSED ] CASE: testVec4FromVec1 (11200 ns)
    TCS: TestCase_testVec4ScalarBitwiseOr, time elapsed: 28200 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarBitwiseOr (11300 ns)
    TCS: TestCase_testVec4ScalarBitwiseXor, time elapsed: 21200 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarBitwiseXor (8300 ns)
    TCS: TestCase_testVec4Vec1BitOrBroadcast, time elapsed: 21600 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1BitOrBroadcast (8900 ns)
    TCS: TestCase_testVec4Vec1BitXorBroadcast, time elapsed: 26500 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1BitXorBroadcast (8200 ns)
    TCS: TestCase_testVec4ShiftLeftVec1, time elapsed: 20600 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftLeftVec1 (7800 ns)
    TCS: TestCase_testVec4ShiftLeftVec, time elapsed: 23700 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftLeftVec (7200 ns)
    TCS: TestCase_testVec4ShiftRightVec, time elapsed: 20400 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftRightVec (7400 ns)
    TCS: TestCase_testVec4Increment, time elapsed: 29800 ns, RESULT:
    [ PASSED ] CASE: testVec4Increment (11800 ns)
    TCS: TestCase_testVec4Decrement, time elapsed: 24100 ns, RESULT:
    [ PASSED ] CASE: testVec4Decrement (10100 ns)
    TCS: TestCase_testVec4IndexOutOfBoundsAccess, time elapsed: 48900 ns, RESULT:
    [ PASSED ] CASE: testVec4IndexOutOfBoundsAccess (32400 ns)
    TCS: TestCase_testVec4NegativeIndexAccess, time elapsed: 24500 ns, RESULT:
    [ PASSED ] CASE: testVec4NegativeIndexAccess (11100 ns)
    TCS: TestCase_testFunctor1Vec1Identity, time elapsed: 24600 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec1Identity (11500 ns)
    TCS: TestCase_testFunctor1Vec1Transform, time elapsed: 18300 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec1Transform (5500 ns)
    TCS: TestCase_testFunctor1Vec2Transform, time elapsed: 23200 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec2Transform (6000 ns)
    TCS: TestCase_testFunctor2Vec1Add, time elapsed: 18000 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec1Add (6100 ns)
    TCS: TestCase_testFunctor2VecScaVec1Mul, time elapsed: 27000 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec1Mul (13400 ns)
    TCS: TestCase_testFunctor2VecIntVec1Shift, time elapsed: 19200 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec1Shift (6800 ns)
    TCS: TestCase_testFunctor1Vec3Transform, time elapsed: 22800 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec3Transform (6300 ns)
    TCS: TestCase_testFunctor1Vec4Transform, time elapsed: 20600 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec4Transform (6500 ns)
    TCS: TestCase_testFunctor2Vec2Add, time elapsed: 18900 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec2Add (5300 ns)
    TCS: TestCase_testFunctor2Vec3Add, time elapsed: 18900 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec3Add (6200 ns)
    TCS: TestCase_testFunctor2Vec4Add, time elapsed: 18300 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec4Add (6400 ns)
    TCS: TestCase_testFunctor2VecScaVec2Mul, time elapsed: 23100 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec2Mul (7000 ns)
    TCS: TestCase_testFunctor2VecScaVec3Mul, time elapsed: 17000 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec3Mul (5400 ns)
    TCS: TestCase_testFunctor2VecScaVec4Mul, time elapsed: 22400 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec4Mul (5800 ns)
    TCS: TestCase_testFunctor2VecIntVec2Shift, time elapsed: 19400 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec2Shift (6900 ns)
    TCS: TestCase_testFunctor2VecIntVec3Shift, time elapsed: 22200 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec3Shift (5200 ns)
    TCS: TestCase_testFunctor2VecIntVec4Shift, time elapsed: 17300 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec4Shift (5400 ns)
Summary: TOTAL: 435
    PASSED: 435, SKIPPED: 0, ERROR: 0
    FAILED: 0
--------------------------------------------------------------------------------------------------
