# 验证报告（v11）

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



warning: unused import 'glm.detail.Quat'

 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_double.cj:2:21:

  | 

2 | import glm.detail.{ Quat, PackedHighp }

  |                     ^^^^ unused import

  | 

  # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused import 'glm.detail.PackedHighp'

 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\quaternion_double.cj:2:27:

  | 

2 | import glm.detail.{ Quat, PackedHighp }

  |                           ^^^^^^^^^^^ unused import

  | 

  # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused import 'std.math as math'

 ==> C:\Develop\Software\cjglm_wp\cjglm\src\ext\scalar_common.cj:4:1:

  | 

4 | import std.math as math

  | ^^^^^^^^^^^^^^^^^^^^^^^ unused import

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



75 warnings generated, 75 warnings printed.

warning: unused import 'glm.detail.Vec2'

 ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\matrix_transform.cj:2:29:

  | 

2 | import glm.detail.{ Mat4x4, Vec2, Vec3, Vec4, Qualifier, sinT, cosT, normalize }

  |                             ^^^^ unused import

  | 

  # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused import 'glm.detail.Vec1'

 ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\noise.cj:2:20:

  | 

2 | import glm.detail.{Vec1, Vec2, Vec3, Vec4, Qualifier, floor, fract, abs, min, max, dot, mix, step, clamp, roundEven, mod, trunc, lessThan}

  |                    ^^^^ unused import

  | 

  # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused import 'glm.detail.min'

 ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\noise.cj:2:74:

  | 

2 | import glm.detail.{Vec1, Vec2, Vec3, Vec4, Qualifier, floor, fract, abs, min, max, dot, mix, step, clamp, roundEven, mod, trunc, lessThan}

  |                                                                          ^^^ unused import

  | 

  # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused import 'glm.detail.max'

 ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\noise.cj:2:79:

  | 

2 | import glm.detail.{Vec1, Vec2, Vec3, Vec4, Qualifier, floor, fract, abs, min, max, dot, mix, step, clamp, roundEven, mod, trunc, lessThan}

  |                                                                               ^^^ unused import

  | 

  # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused import 'glm.detail.dot'

 ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\noise.cj:2:84:

  | 

2 | import glm.detail.{Vec1, Vec2, Vec3, Vec4, Qualifier, floor, fract, abs, min, max, dot, mix, step, clamp, roundEven, mod, trunc, lessThan}

  |                                                                                    ^^^ unused import

  | 

  # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused import 'glm.detail.clamp'

 ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\noise.cj:2:100:

  | 

2 | import glm.detail.{Vec1, Vec2, Vec3, Vec4, Qualifier, floor, fract, abs, min, max, dot, mix, step, clamp, roundEven, mod, trunc, lessThan}

  |                                                                                                    ^^^^^ unused import

  | 

  # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused import 'glm.detail.roundEven'

 ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\noise.cj:2:107:

  | 

2 | import glm.detail.{Vec1, Vec2, Vec3, Vec4, Qualifier, floor, fract, abs, min, max, dot, mix, step, clamp, roundEven, mod, trunc, lessThan}

  |                                                                                                           ^^^^^^^^^ unused import

  | 

  # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused import 'glm.detail.mod'

 ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\noise.cj:2:118:

  | 

2 | import glm.detail.{Vec1, Vec2, Vec3, Vec4, Qualifier, floor, fract, abs, min, max, dot, mix, step, clamp, roundEven, mod, trunc, lessThan}

  |                                                                                                                      ^^^ unused import

  | 

  # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused import 'glm.detail.trunc'

 ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\noise.cj:2:123:

  | 

2 | import glm.detail.{Vec1, Vec2, Vec3, Vec4, Qualifier, floor, fract, abs, min, max, dot, mix, step, clamp, roundEven, mod, trunc, lessThan}

  |                                                                                                                           ^^^^^ unused import

  | 

  # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused import 'glm.detail.lessThan'

 ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\noise.cj:2:130:

  | 

2 | import glm.detail.{Vec1, Vec2, Vec3, Vec4, Qualifier, floor, fract, abs, min, max, dot, mix, step, clamp, roundEven, mod, trunc, lessThan}

  |                                                                                                                                  ^^^^^^^^ unused import

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



warning: unused variable:'result'

   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\packing.cj:163:9:

    | 

163 |     var result: UInt32

    |         ^^^^^^ unused variable

    | 

    # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused variable:'i1'

   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\noise.cj:326:9:

    | 

326 |     let i1 = i0 + one

    |         ^^ unused variable

    | 

    # note: this warning can be suppressed by setting the compiler option `-Woff unused`



warning: unused variable:'half'

   ==> C:\Develop\Software\cjglm_wp\cjglm\src\gtc\noise.cj:447:9:

    | 

447 |     let half = (Float64(0.5) as T).getOrThrow()

    |         ^^^^ unused variable

    | 

    # note: this warning can be suppressed by setting the compiler option `-Woff unused`



23 warnings generated, 23 warnings printed.

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



warning: imported decl 'mod' is conflicted with other import

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:30:83:

   | 

30 | public import glm.detail.{abs, sign, floor, ceil, trunc, round, roundEven, fract, mod, modf,

   |                                                                                   ^^^ 

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`

note: The previous was imported here

 ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:5:48:

  | 

5 | public import glm.detail.{ add, sub, mul, div, mod }

  |                                                ^^^ 

  | 



warning: imported decl 'mix' is conflicted with other import

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:31:22:

   | 

31 |     min, max, clamp, mix, step, smoothstep, isnan, isinf,

   |                      ^^^ 

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`

note: The previous was imported here

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:14:81:

   | 

14 | public import glm.ext.{equal, notEqual, conjugate, inverse, lerp, isnan, isinf, mix, slerp}

   |                                                                                 ^^^ 

   | 



warning: imported decl 'isnan' is conflicted with other import

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:31:45:

   | 

31 |     min, max, clamp, mix, step, smoothstep, isnan, isinf,

   |                                             ^^^^^ 

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`

note: The previous was imported here

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:14:67:

   | 

14 | public import glm.ext.{equal, notEqual, conjugate, inverse, lerp, isnan, isinf, mix, slerp}

   |                                                                   ^^^^^ 

   | 



warning: imported decl 'isinf' is conflicted with other import

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:31:52:

   | 

31 |     min, max, clamp, mix, step, smoothstep, isnan, isinf,

   |                                                    ^^^^^ 

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`

note: The previous was imported here

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:14:74:

   | 

14 | public import glm.ext.{equal, notEqual, conjugate, inverse, lerp, isnan, isinf, mix, slerp}

   |                                                                          ^^^^^ 

   | 



warning: imported decl 'pow' is conflicted with other import

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:35:27:

   | 

35 | public import glm.detail.{pow, exp, log, exp2, log2, sqrt, inversesqrt}

   |                           ^^^ 

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`

note: The previous was imported here

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:16:34:

   | 

16 | public import glm.ext.{exp, log, pow, sqrt}

   |                                  ^^^ 

   | 



warning: imported decl 'exp' is conflicted with other import

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:35:32:

   | 

35 | public import glm.detail.{pow, exp, log, exp2, log2, sqrt, inversesqrt}

   |                                ^^^ 

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`

note: The previous was imported here

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:16:24:

   | 

16 | public import glm.ext.{exp, log, pow, sqrt}

   |                        ^^^ 

   | 



warning: imported decl 'log' is conflicted with other import

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:35:37:

   | 

35 | public import glm.detail.{pow, exp, log, exp2, log2, sqrt, inversesqrt}

   |                                     ^^^ 

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`

note: The previous was imported here

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:16:29:

   | 

16 | public import glm.ext.{exp, log, pow, sqrt}

   |                             ^^^ 

   | 



warning: imported decl 'sqrt' is conflicted with other import

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:35:54:

   | 

35 | public import glm.detail.{pow, exp, log, exp2, log2, sqrt, inversesqrt}

   |                                                      ^^^^ 

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`

note: The previous was imported here

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:16:39:

   | 

16 | public import glm.ext.{exp, log, pow, sqrt}

   |                                       ^^^^ 

   | 



warning: imported decl 'dot' is conflicted with other import

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:37:27:

   | 

37 | public import glm.detail.{dot, cross, normalize, length, distance, reflect, refract, faceforward}

   |                           ^^^ 

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`

note: The previous was imported here

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:15:24:

   | 

15 | public import glm.ext.{dot, length, normalize, cross, axis, angle, angleAxis}

   |                        ^^^ 

   | 



warning: imported decl 'cross' is conflicted with other import

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:37:32:

   | 

37 | public import glm.detail.{dot, cross, normalize, length, distance, reflect, refract, faceforward}

   |                                ^^^^^ 

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`

note: The previous was imported here

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:15:48:

   | 

15 | public import glm.ext.{dot, length, normalize, cross, axis, angle, angleAxis}

   |                                                ^^^^^ 

   | 



warning: imported decl 'normalize' is conflicted with other import

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:37:39:

   | 

37 | public import glm.detail.{dot, cross, normalize, length, distance, reflect, refract, faceforward}

   |                                       ^^^^^^^^^ 

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`

note: The previous was imported here

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:15:37:

   | 

15 | public import glm.ext.{dot, length, normalize, cross, axis, angle, angleAxis}

   |                                     ^^^^^^^^^ 

   | 



warning: imported decl 'length' is conflicted with other import

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:37:50:

   | 

37 | public import glm.detail.{dot, cross, normalize, length, distance, reflect, refract, faceforward}

   |                                                  ^^^^^^ 

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`

note: The previous was imported here

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:15:29:

   | 

15 | public import glm.ext.{dot, length, normalize, cross, axis, angle, angleAxis}

   |                             ^^^^^^ 

   | 



warning: imported decl 'inverse' is conflicted with other import

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:39:40:

   | 

39 | public import glm.detail.{determinant, inverse}

   |                                        ^^^^^^^ 

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`

note: The previous was imported here

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:14:52:

   | 

14 | public import glm.ext.{equal, notEqual, conjugate, inverse, lerp, isnan, isinf, mix, slerp}

   |                                                    ^^^^^^^ 

   | 



warning: imported decl 'min' is conflicted with other import

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:41:24:

   | 

41 | public import glm.ext.{min, max, fmin, fmax, fclamp, clamp, repeat, mirrorClamp, mirrorRepeat, iround, uround}

   |                        ^^^ 

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`

note: The previous was imported here

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:31:5:

   | 

31 |     min, max, clamp, mix, step, smoothstep, isnan, isinf,

   |     ^^^ 

   | 



warning: imported decl 'max' is conflicted with other import

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:41:29:

   | 

41 | public import glm.ext.{min, max, fmin, fmax, fclamp, clamp, repeat, mirrorClamp, mirrorRepeat, iround, uround}

   |                             ^^^ 

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`

note: The previous was imported here

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:31:10:

   | 

31 |     min, max, clamp, mix, step, smoothstep, isnan, isinf,

   |          ^^^ 

   | 



warning: imported decl 'clamp' is conflicted with other import

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:41:54:

   | 

41 | public import glm.ext.{min, max, fmin, fmax, fclamp, clamp, repeat, mirrorClamp, mirrorRepeat, iround, uround}

   |                                                      ^^^^^ 

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`

note: The previous was imported here

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:31:15:

   | 

31 |     min, max, clamp, mix, step, smoothstep, isnan, isinf,

   |               ^^^^^ 

   | 



warning: imported decl 'lessThan' is conflicted with other import

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:45:27:

   | 

45 | public import glm.detail.{lessThan, greaterThan, lessThanEqual, greaterThanEqual, equal, notEqual, any, all, not_}

   |                           ^^^^^^^^ 

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`

note: The previous was imported here

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:22:24:

   | 

22 | public import glm.gtc.{lessThan, lessThanEqual, greaterThan, greaterThanEqual, eulerAngles, roll, pitch, yaw, quatLookAt, quatLookAtRH, quatLookAtLH}

   |                        ^^^^^^^^ 

   | 



warning: imported decl 'greaterThan' is conflicted with other import

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:45:37:

   | 

45 | public import glm.detail.{lessThan, greaterThan, lessThanEqual, greaterThanEqual, equal, notEqual, any, all, not_}

   |                                     ^^^^^^^^^^^ 

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`

note: The previous was imported here

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:22:49:

   | 

22 | public import glm.gtc.{lessThan, lessThanEqual, greaterThan, greaterThanEqual, eulerAngles, roll, pitch, yaw, quatLookAt, quatLookAtRH, quatLookAtLH}

   |                                                 ^^^^^^^^^^^ 

   | 



warning: imported decl 'lessThanEqual' is conflicted with other import

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:45:50:

   | 

45 | public import glm.detail.{lessThan, greaterThan, lessThanEqual, greaterThanEqual, equal, notEqual, any, all, not_}

   |                                                  ^^^^^^^^^^^^^ 

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`

note: The previous was imported here

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:22:34:

   | 

22 | public import glm.gtc.{lessThan, lessThanEqual, greaterThan, greaterThanEqual, eulerAngles, roll, pitch, yaw, quatLookAt, quatLookAtRH, quatLookAtLH}

   |                                  ^^^^^^^^^^^^^ 

   | 



warning: imported decl 'greaterThanEqual' is conflicted with other import

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:45:65:

   | 

45 | public import glm.detail.{lessThan, greaterThan, lessThanEqual, greaterThanEqual, equal, notEqual, any, all, not_}

   |                                                                 ^^^^^^^^^^^^^^^^ 

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`

note: The previous was imported here

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:22:62:

   | 

22 | public import glm.gtc.{lessThan, lessThanEqual, greaterThan, greaterThanEqual, eulerAngles, roll, pitch, yaw, quatLookAt, quatLookAtRH, quatLookAtLH}

   |                                                              ^^^^^^^^^^^^^^^^ 

   | 



warning: imported decl 'equal' is conflicted with other import

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:45:83:

   | 

45 | public import glm.detail.{lessThan, greaterThan, lessThanEqual, greaterThanEqual, equal, notEqual, any, all, not_}

   |                                                                                   ^^^^^ 

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`

note: The previous was imported here

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:14:24:

   | 

14 | public import glm.ext.{equal, notEqual, conjugate, inverse, lerp, isnan, isinf, mix, slerp}

   |                        ^^^^^ 

   | 



warning: imported decl 'notEqual' is conflicted with other import

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:45:90:

   | 

45 | public import glm.detail.{lessThan, greaterThan, lessThanEqual, greaterThanEqual, equal, notEqual, any, all, not_}

   |                                                                                          ^^^^^^^^ 

   | 

   # note: this warning can be suppressed by setting the compiler option `-Woff package-import`

note: The previous was imported here

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:14:31:

   | 

14 | public import glm.ext.{equal, notEqual, conjugate, inverse, lerp, isnan, isinf, mix, slerp}

   |                               ^^^^^^^^ 

   | 



27 warnings generated, 27 warnings printed.

?25l
--------------------------------------------------------------------------------------------------
TP: glm.detail, time elapsed: 142984500 ns, RESULT:
    TCS: TestCase_testComputeVecAdd1, time elapsed: 1232700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAdd1 (245300 ns)
    TCS: TestCase_testComputeVecSub2, time elapsed: 352400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSub2 (42300 ns)
    TCS: TestCase_testComputeVecMul3, time elapsed: 293500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMul3 (55700 ns)
    TCS: TestCase_testComputeVecMod1, time elapsed: 249100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMod1 (24300 ns)
    TCS: TestCase_testComputeVecMod4, time elapsed: 251600 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMod4 (24600 ns)
    TCS: TestCase_testComputeVecAnd1, time elapsed: 240300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAnd1 (22900 ns)
    TCS: TestCase_testComputeVecAnd3, time elapsed: 315700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAnd3 (30700 ns)
    TCS: TestCase_testComputeVecOr1, time elapsed: 395700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecOr1 (21400 ns)
    TCS: TestCase_testComputeVecOr2, time elapsed: 430900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecOr2 (33300 ns)
    TCS: TestCase_testComputeVecXor1, time elapsed: 596900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecXor1 (98600 ns)
    TCS: TestCase_testComputeVecXor4, time elapsed: 344100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecXor4 (39400 ns)
    TCS: TestCase_testComputeVecShiftLeft1, time elapsed: 478300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftLeft1 (28900 ns)
    TCS: TestCase_testComputeVecShiftLeft3, time elapsed: 324100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftLeft3 (19600 ns)
    TCS: TestCase_testComputeVecShiftRight1, time elapsed: 291900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftRight1 (24900 ns)
    TCS: TestCase_testComputeVecShiftRight4, time elapsed: 252600 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftRight4 (17600 ns)
    TCS: TestCase_testComputeVecEqual1, time elapsed: 280400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual1 (21700 ns)
    TCS: TestCase_testComputeVecNequal4, time elapsed: 309600 ns, RESULT:
    [ PASSED ] CASE: testComputeVecNequal4 (22000 ns)
    TCS: TestCase_testComputeVecBitwiseNot1, time elapsed: 295400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecBitwiseNot1 (47200 ns)
    TCS: TestCase_testComputeVecBitwiseNot3, time elapsed: 325100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecBitwiseNot3 (61800 ns)
    TCS: TestCase_testComputeVecAdd4, time elapsed: 275000 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAdd4 (24500 ns)
    TCS: TestCase_testComputeVecSub1, time elapsed: 755900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSub1 (20500 ns)
    TCS: TestCase_testComputeVecSub3, time elapsed: 252300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSub3 (20000 ns)
    TCS: TestCase_testComputeVecMul1, time elapsed: 226800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMul1 (18200 ns)
    TCS: TestCase_testComputeVecMul2, time elapsed: 288000 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMul2 (27200 ns)
    TCS: TestCase_testComputeVecDiv1, time elapsed: 356000 ns, RESULT:
    [ PASSED ] CASE: testComputeVecDiv1 (32200 ns)
    TCS: TestCase_testComputeVecDiv2, time elapsed: 291000 ns, RESULT:
    [ PASSED ] CASE: testComputeVecDiv2 (25800 ns)
    TCS: TestCase_testComputeVecDiv4, time elapsed: 252700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecDiv4 (21800 ns)
    TCS: TestCase_testComputeVecEqual2, time elapsed: 264700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual2 (49600 ns)
    TCS: TestCase_testComputeVecEqual3, time elapsed: 242600 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual3 (18200 ns)
    TCS: TestCase_testComputeVecEqual4, time elapsed: 228400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual4 (15500 ns)
    TCS: TestCase_testComputeVecNequal1, time elapsed: 364300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecNequal1 (12400 ns)
    TCS: TestCase_testComputeVecNequal2, time elapsed: 347900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecNequal2 (19200 ns)
    TCS: TestCase_testComputeVecBitwiseNot4, time elapsed: 340300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecBitwiseNot4 (39500 ns)
    TCS: TestCase_testComputeVecAddFloat32, time elapsed: 216100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAddFloat32 (30100 ns)
    TCS: TestCase_testComputeVecAddFloat32Vec3, time elapsed: 229400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAddFloat32Vec3 (39800 ns)
    TCS: TestCase_testComputeVecSubFloat32, time elapsed: 197500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSubFloat32 (16000 ns)
    TCS: TestCase_testComputeVecSubFloat32Vec4, time elapsed: 201700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSubFloat32Vec4 (21300 ns)
    TCS: TestCase_testComputeEqualInt32Equal, time elapsed: 193100 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt32Equal (14100 ns)
    TCS: TestCase_testComputeEqualInt32NotEqual, time elapsed: 186400 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt32NotEqual (10000 ns)
    TCS: TestCase_testComputeEqualFloat32Equal, time elapsed: 185400 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32Equal (11300 ns)
    TCS: TestCase_testComputeEqualFloat32NotEqual, time elapsed: 185400 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32NotEqual (13100 ns)
    TCS: TestCase_testComputeEqualFloat64Equal, time elapsed: 209200 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64Equal (9000 ns)
    TCS: TestCase_testComputeEqualFloat64NotEqual, time elapsed: 185200 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64NotEqual (9400 ns)
    TCS: TestCase_testComputeEqualBoolEqual, time elapsed: 173000 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualBoolEqual (9500 ns)
    TCS: TestCase_testComputeEqualBoolNotEqual, time elapsed: 176300 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualBoolNotEqual (8800 ns)
    TCS: TestCase_testComputeEqualNumericInt32, time elapsed: 185300 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericInt32 (14700 ns)
    TCS: TestCase_testComputeEqualNumericFloat32, time elapsed: 205900 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32 (28200 ns)
    TCS: TestCase_testComputeEqualNumericFloat32Epsilon, time elapsed: 197200 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32Epsilon (11900 ns)
    TCS: TestCase_testComputeEqualNumericFloat64, time elapsed: 233200 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64 (15900 ns)
    TCS: TestCase_testComputeEqualInt64Equal, time elapsed: 217400 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt64Equal (11600 ns)
    TCS: TestCase_testComputeEqualInt64NotEqual, time elapsed: 199400 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt64NotEqual (10400 ns)
    TCS: TestCase_testComputeEqualFloat32Nan, time elapsed: 225400 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32Nan (13300 ns)
    TCS: TestCase_testComputeEqualFloat64Nan, time elapsed: 209600 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64Nan (9800 ns)
    TCS: TestCase_testComputeEqualFloat32SignedZero, time elapsed: 219500 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32SignedZero (10600 ns)
    TCS: TestCase_testComputeEqualFloat64SignedZero, time elapsed: 196700 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64SignedZero (10200 ns)
    TCS: TestCase_testComputeEqualNumericFloat32NotEqual, time elapsed: 203800 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32NotEqual (17800 ns)
    TCS: TestCase_testComputeEqualNumericFloat32BeyondEpsilon, time elapsed: 226300 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32BeyondEpsilon (10500 ns)
    TCS: TestCase_testComputeEqualNumericFloat64NotEqual, time elapsed: 209100 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64NotEqual (14200 ns)
    TCS: TestCase_testComputeEqualNumericFloat64Epsilon, time elapsed: 186300 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64Epsilon (10400 ns)
    TCS: TestCase_testComputeEqualNumericFloat64BeyondEpsilon, time elapsed: 181100 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64BeyondEpsilon (9900 ns)
    TCS: TestCase_testComputeEqualNumericInt64, time elapsed: 211200 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericInt64 (12400 ns)
    TCS: TestCase_testPackedHighpImplementsQualifier, time elapsed: 208600 ns, RESULT:
    [ PASSED ] CASE: testPackedHighpImplementsQualifier (17600 ns)
    TCS: TestCase_testPackedMediumpImplementsQualifier, time elapsed: 206200 ns, RESULT:
    [ PASSED ] CASE: testPackedMediumpImplementsQualifier (14600 ns)
    TCS: TestCase_testPackedLowpImplementsQualifier, time elapsed: 198300 ns, RESULT:
    [ PASSED ] CASE: testPackedLowpImplementsQualifier (11600 ns)
    TCS: TestCase_testDefaultpIsPackedHighp, time elapsed: 194400 ns, RESULT:
    [ PASSED ] CASE: testDefaultpIsPackedHighp (10600 ns)
    TCS: TestCase_testScalarAddVec1, time elapsed: 250000 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec1 (19200 ns)
    TCS: TestCase_testScalarAddVec2, time elapsed: 201600 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec2 (13300 ns)
    TCS: TestCase_testScalarAddVec3, time elapsed: 187200 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec3 (15000 ns)
    TCS: TestCase_testScalarAddVec4, time elapsed: 219700 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec4 (14400 ns)
    TCS: TestCase_testScalarSubVec1, time elapsed: 196700 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1 (15100 ns)
    TCS: TestCase_testScalarMulVec1, time elapsed: 238700 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1 (14000 ns)
    TCS: TestCase_testScalarDivVec1, time elapsed: 183000 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1 (11300 ns)
    TCS: TestCase_testScalarModVec1, time elapsed: 190900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1 (11700 ns)
    TCS: TestCase_testScalarMulVec2, time elapsed: 200700 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2 (11500 ns)
    TCS: TestCase_testScalarSubVec2, time elapsed: 203600 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2 (11800 ns)
    TCS: TestCase_testScalarSubVec3, time elapsed: 221600 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3 (12000 ns)
    TCS: TestCase_testScalarSubVec4, time elapsed: 229400 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4 (19200 ns)
    TCS: TestCase_testScalarMulVec3, time elapsed: 333400 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3 (24300 ns)
    TCS: TestCase_testScalarMulVec4, time elapsed: 239700 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4 (22200 ns)
    TCS: TestCase_testScalarDivVec2, time elapsed: 208900 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2 (11600 ns)
    TCS: TestCase_testScalarDivVec3, time elapsed: 224300 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3 (14200 ns)
    TCS: TestCase_testScalarDivVec4, time elapsed: 261000 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4 (15400 ns)
    TCS: TestCase_testScalarModVec2, time elapsed: 353400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2 (16800 ns)
    TCS: TestCase_testScalarModVec3, time elapsed: 256900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3 (25500 ns)
    TCS: TestCase_testScalarModVec4, time elapsed: 215600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4 (18600 ns)
    TCS: TestCase_testScalarModVec1Float32, time elapsed: 212600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Float32 (20200 ns)
    TCS: TestCase_testScalarModVec2Float32, time elapsed: 193400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32 (13200 ns)
    TCS: TestCase_testScalarModVec3Float32, time elapsed: 197400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Float32 (11600 ns)
    TCS: TestCase_testScalarModVec4Float32, time elapsed: 191600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Float32 (13400 ns)
    TCS: TestCase_testScalarModVec1Float64, time elapsed: 198800 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Float64 (17200 ns)
    TCS: TestCase_testScalarModVec2Float64, time elapsed: 199800 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float64 (10400 ns)
    TCS: TestCase_testScalarModVec3Float64, time elapsed: 191600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Float64 (10600 ns)
    TCS: TestCase_testScalarModVec4Float64, time elapsed: 182200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Float64 (11200 ns)
    TCS: TestCase_testScalarModVec1Float16, time elapsed: 195600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Float16 (21700 ns)
    TCS: TestCase_testScalarModVec2Float16, time elapsed: 185600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float16 (10000 ns)
    TCS: TestCase_testScalarModVec3Float16, time elapsed: 185600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Float16 (12400 ns)
    TCS: TestCase_testScalarModVec4Float16, time elapsed: 196400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Float16 (13100 ns)
    TCS: TestCase_testScalarSubVec2PackedMediump, time elapsed: 187500 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2PackedMediump (14400 ns)
    TCS: TestCase_testScalarSubVec2PackedLowp, time elapsed: 194600 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2PackedLowp (10900 ns)
    TCS: TestCase_testScalarMulVec2PackedMediump, time elapsed: 188200 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2PackedMediump (10300 ns)
    TCS: TestCase_testScalarMulVec2PackedLowp, time elapsed: 183700 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2PackedLowp (10200 ns)
    TCS: TestCase_testScalarDivVec2PackedMediump, time elapsed: 237200 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2PackedMediump (12500 ns)
    TCS: TestCase_testScalarDivVec2PackedLowp, time elapsed: 242400 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2PackedLowp (14400 ns)
    TCS: TestCase_testScalarModVec2PackedMediump, time elapsed: 194900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2PackedMediump (13600 ns)
    TCS: TestCase_testScalarModVec2PackedLowp, time elapsed: 217800 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2PackedLowp (10800 ns)
    TCS: TestCase_testScalarModVec2Float32PackedMediump, time elapsed: 228100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32PackedMediump (17400 ns)
    TCS: TestCase_testScalarModVec2Float32PackedLowp, time elapsed: 266600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32PackedLowp (11400 ns)
    TCS: TestCase_testScalarModVec2Float32NegativeDividend, time elapsed: 231600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32NegativeDividend (13500 ns)
    TCS: TestCase_testScalarModVec2Float32NegativeDivisor, time elapsed: 303500 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32NegativeDivisor (15300 ns)
    TCS: TestCase_testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents, time elapsed: 335300 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents (122700 ns)
    TCS: TestCase_testScalarAddVec1Float32, time elapsed: 224600 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec1Float32 (14900 ns)
    TCS: TestCase_testScalarAddVec2Float32, time elapsed: 218000 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec2Float32 (14700 ns)
    TCS: TestCase_testScalarAddVec3Float32, time elapsed: 198300 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec3Float32 (11500 ns)
    TCS: TestCase_testScalarAddVec4Float32, time elapsed: 198100 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec4Float32 (12000 ns)
    TCS: TestCase_testScalarSubVec1Float32, time elapsed: 202300 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1Float32 (16000 ns)
    TCS: TestCase_testScalarSubVec2Float32, time elapsed: 202000 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2Float32 (12200 ns)
    TCS: TestCase_testScalarSubVec3Float32, time elapsed: 185400 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3Float32 (12400 ns)
    TCS: TestCase_testScalarSubVec4Float32, time elapsed: 196800 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4Float32 (8700 ns)
    TCS: TestCase_testScalarMulVec1Float32, time elapsed: 198600 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1Float32 (9600 ns)
    TCS: TestCase_testScalarMulVec2Float32, time elapsed: 217200 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2Float32 (9900 ns)
    TCS: TestCase_testScalarMulVec3Float32, time elapsed: 194000 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3Float32 (11100 ns)
    TCS: TestCase_testScalarMulVec4Float32, time elapsed: 193500 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4Float32 (9100 ns)
    TCS: TestCase_testScalarDivVec1Float32, time elapsed: 190500 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1Float32 (13100 ns)
    TCS: TestCase_testScalarDivVec2Float32, time elapsed: 193600 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2Float32 (10200 ns)
    TCS: TestCase_testScalarDivVec3Float32, time elapsed: 176700 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3Float32 (8400 ns)
    TCS: TestCase_testScalarDivVec4Float32, time elapsed: 186600 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4Float32 (8800 ns)
    TCS: TestCase_testScalarAddVec1Int32, time elapsed: 197000 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec1Int32 (15700 ns)
    TCS: TestCase_testScalarAddVec2Int32, time elapsed: 205800 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec2Int32 (12400 ns)
    TCS: TestCase_testScalarAddVec3Int32, time elapsed: 340100 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec3Int32 (20000 ns)
    TCS: TestCase_testScalarAddVec4Int32, time elapsed: 243100 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec4Int32 (11600 ns)
    TCS: TestCase_testScalarSubVec1Int32, time elapsed: 343800 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1Int32 (27400 ns)
    TCS: TestCase_testScalarSubVec2Int32, time elapsed: 361600 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2Int32 (18200 ns)
    TCS: TestCase_testScalarSubVec3Int32, time elapsed: 396900 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3Int32 (37100 ns)
    TCS: TestCase_testScalarSubVec4Int32, time elapsed: 327800 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4Int32 (20700 ns)
    TCS: TestCase_testScalarMulVec1Int32, time elapsed: 337400 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1Int32 (22300 ns)
    TCS: TestCase_testScalarMulVec2Int32, time elapsed: 315700 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2Int32 (17300 ns)
    TCS: TestCase_testScalarMulVec3Int32, time elapsed: 295100 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3Int32 (17500 ns)
    TCS: TestCase_testScalarMulVec4Int32, time elapsed: 289200 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4Int32 (14700 ns)
    TCS: TestCase_testScalarDivVec1Int32, time elapsed: 304900 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1Int32 (20100 ns)
    TCS: TestCase_testScalarDivVec2Int32, time elapsed: 310400 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2Int32 (21700 ns)
    TCS: TestCase_testScalarDivVec3Int32, time elapsed: 318200 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3Int32 (17700 ns)
    TCS: TestCase_testScalarDivVec4Int32, time elapsed: 301100 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4Int32 (16600 ns)
    TCS: TestCase_testScalarModVec1Int32, time elapsed: 284000 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Int32 (15700 ns)
    TCS: TestCase_testScalarModVec2Int32, time elapsed: 269000 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Int32 (15200 ns)
    TCS: TestCase_testScalarModVec3Int32, time elapsed: 196600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Int32 (14300 ns)
    TCS: TestCase_testScalarModVec4Int32, time elapsed: 210100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Int32 (9500 ns)
    TCS: TestCase_testScalarSubVec1PackedMediump, time elapsed: 200300 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1PackedMediump (11900 ns)
    TCS: TestCase_testScalarSubVec1PackedLowp, time elapsed: 264400 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1PackedLowp (9600 ns)
    TCS: TestCase_testScalarSubVec3PackedMediump, time elapsed: 226900 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3PackedMediump (12900 ns)
    TCS: TestCase_testScalarSubVec3PackedLowp, time elapsed: 209000 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3PackedLowp (14100 ns)
    TCS: TestCase_testScalarSubVec4PackedMediump, time elapsed: 250900 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4PackedMediump (17900 ns)
    TCS: TestCase_testScalarSubVec4PackedLowp, time elapsed: 395200 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4PackedLowp (27300 ns)
    TCS: TestCase_testScalarMulVec1PackedMediump, time elapsed: 247700 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1PackedMediump (13000 ns)
    TCS: TestCase_testScalarMulVec1PackedLowp, time elapsed: 242700 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1PackedLowp (12100 ns)
    TCS: TestCase_testScalarMulVec3PackedMediump, time elapsed: 230800 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3PackedMediump (17400 ns)
    TCS: TestCase_testScalarMulVec3PackedLowp, time elapsed: 209100 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3PackedLowp (11700 ns)
    TCS: TestCase_testScalarMulVec4PackedMediump, time elapsed: 206200 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4PackedMediump (11900 ns)
    TCS: TestCase_testScalarMulVec4PackedLowp, time elapsed: 231600 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4PackedLowp (14700 ns)
    TCS: TestCase_testScalarDivVec1PackedMediump, time elapsed: 217300 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1PackedMediump (11600 ns)
    TCS: TestCase_testScalarDivVec1PackedLowp, time elapsed: 215300 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1PackedLowp (14000 ns)
    TCS: TestCase_testScalarDivVec3PackedMediump, time elapsed: 190900 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3PackedMediump (14300 ns)
    TCS: TestCase_testScalarDivVec3PackedLowp, time elapsed: 210700 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3PackedLowp (11500 ns)
    TCS: TestCase_testScalarDivVec4PackedMediump, time elapsed: 196600 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4PackedMediump (11100 ns)
    TCS: TestCase_testScalarDivVec4PackedLowp, time elapsed: 211700 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4PackedLowp (11300 ns)
    TCS: TestCase_testScalarModVec1PackedMediump, time elapsed: 193000 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1PackedMediump (11500 ns)
    TCS: TestCase_testScalarModVec1PackedLowp, time elapsed: 212000 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1PackedLowp (12900 ns)
    TCS: TestCase_testScalarModVec3PackedMediump, time elapsed: 212200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3PackedMediump (12600 ns)
    TCS: TestCase_testScalarModVec3PackedLowp, time elapsed: 217700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3PackedLowp (9300 ns)
    TCS: TestCase_testScalarModVec4PackedMediump, time elapsed: 188700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4PackedMediump (10400 ns)
    TCS: TestCase_testScalarModVec4PackedLowp, time elapsed: 199700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4PackedLowp (12700 ns)
    TCS: TestCase_testScalarDivZeroVec1, time elapsed: 217900 ns, RESULT:
    [ PASSED ] CASE: testScalarDivZeroVec1 (15300 ns)
    TCS: TestCase_testScalarAddNegVec1, time elapsed: 184900 ns, RESULT:
    [ PASSED ] CASE: testScalarAddNegVec1 (12100 ns)
    TCS: TestCase_testScalarAddNegVec2, time elapsed: 185500 ns, RESULT:
    [ PASSED ] CASE: testScalarAddNegVec2 (9500 ns)
    TCS: TestCase_testScalarMulOverflowVec1, time elapsed: 275000 ns, RESULT:
    [ PASSED ] CASE: testScalarMulOverflowVec1 (19500 ns)
    TCS: TestCase_testScalarSubNegVec1, time elapsed: 330300 ns, RESULT:
    [ PASSED ] CASE: testScalarSubNegVec1 (22000 ns)
    TCS: TestCase_testVersionMajor, time elapsed: 296100 ns, RESULT:
    [ PASSED ] CASE: testVersionMajor (14700 ns)
    TCS: TestCase_testVersionMinor, time elapsed: 296500 ns, RESULT:
    [ PASSED ] CASE: testVersionMinor (17700 ns)
    TCS: TestCase_testVersionPatch, time elapsed: 281400 ns, RESULT:
    [ PASSED ] CASE: testVersionPatch (13000 ns)
    TCS: TestCase_testVersionEncoded, time elapsed: 293200 ns, RESULT:
    [ PASSED ] CASE: testVersionEncoded (21400 ns)
    TCS: TestCase_testConfigSimd, time elapsed: 279200 ns, RESULT:
    [ PASSED ] CASE: testConfigSimd (19900 ns)
    TCS: TestCase_testConfigAlignedGentypes, time elapsed: 342300 ns, RESULT:
    [ PASSED ] CASE: testConfigAlignedGentypes (18200 ns)
    TCS: TestCase_testConfigClipControl, time elapsed: 213800 ns, RESULT:
    [ PASSED ] CASE: testConfigClipControl (10300 ns)
    TCS: TestCase_testConstNegationSimd, time elapsed: 202400 ns, RESULT:
    [ PASSED ] CASE: testConstNegationSimd (12500 ns)
    TCS: TestCase_testConstNegationAligned, time elapsed: 224100 ns, RESULT:
    [ PASSED ] CASE: testConstNegationAligned (12900 ns)
    TCS: TestCase_testConstNegationClip, time elapsed: 199500 ns, RESULT:
    [ PASSED ] CASE: testConstNegationClip (9800 ns)
    TCS: TestCase_testConstInt64Usage, time elapsed: 191000 ns, RESULT:
    [ PASSED ] CASE: testConstInt64Usage (9700 ns)
    TCS: TestCase_testConstBoolUsage, time elapsed: 313800 ns, RESULT:
    [ PASSED ] CASE: testConstBoolUsage (12900 ns)
    TCS: TestCase_testVersionEncodingConsistency, time elapsed: 230100 ns, RESULT:
    [ PASSED ] CASE: testVersionEncodingConsistency (14400 ns)
    TCS: TestCase_testAssertPasses, time elapsed: 232100 ns, RESULT:
    [ PASSED ] CASE: testAssertPasses (18300 ns)
    TCS: TestCase_testAssertFails, time elapsed: 278000 ns, RESULT:
    [ PASSED ] CASE: testAssertFails (68700 ns)
    TCS: TestCase_testAssertWithCustomMessage, time elapsed: 270800 ns, RESULT:
    [ PASSED ] CASE: testAssertWithCustomMessage (38600 ns)
    TCS: TestCase_testNumericLimitsFloat32Epsilon, time elapsed: 224700 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsFloat32Epsilon (12800 ns)
    TCS: TestCase_testNumericLimitsFloat64Epsilon, time elapsed: 210700 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsFloat64Epsilon (11700 ns)
    TCS: TestCase_testIsIec559OfFloat32, time elapsed: 253200 ns, RESULT:
    [ PASSED ] CASE: testIsIec559OfFloat32 (17900 ns)
    TCS: TestCase_testIsIec559OfFloat64, time elapsed: 219400 ns, RESULT:
    [ PASSED ] CASE: testIsIec559OfFloat64 (10000 ns)
    TCS: TestCase_testIsIec559OfInt64, time elapsed: 218800 ns, RESULT:
    [ PASSED ] CASE: testIsIec559OfInt64 (12200 ns)
    TCS: TestCase_testEpsilonOfFloat32, time elapsed: 309300 ns, RESULT:
    [ PASSED ] CASE: testEpsilonOfFloat32 (13900 ns)
    TCS: TestCase_testEpsilonOfFloat64, time elapsed: 258100 ns, RESULT:
    [ PASSED ] CASE: testEpsilonOfFloat64 (15400 ns)
    TCS: TestCase_testNumericLimitsInt64Epsilon, time elapsed: 361800 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt64Epsilon (28000 ns)
    TCS: TestCase_testNumericLimitsInt32Epsilon, time elapsed: 285400 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt32Epsilon (15000 ns)
    TCS: TestCase_testNumericLimitsInt16Epsilon, time elapsed: 300400 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt16Epsilon (22100 ns)
    TCS: TestCase_testNumericLimitsInt8Epsilon, time elapsed: 214500 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt8Epsilon (17500 ns)
    TCS: TestCase_testCastVec1ToVec1IntToFloat, time elapsed: 232600 ns, RESULT:
    [ PASSED ] CASE: testCastVec1ToVec1IntToFloat (19900 ns)
    TCS: TestCase_testCastVec2ToVec1TakesOnlyX, time elapsed: 271000 ns, RESULT:
    [ PASSED ] CASE: testCastVec2ToVec1TakesOnlyX (13300 ns)
    TCS: TestCase_testCastVec3ToVec1TakesOnlyX, time elapsed: 214400 ns, RESULT:
    [ PASSED ] CASE: testCastVec3ToVec1TakesOnlyX (15500 ns)
    TCS: TestCase_testCastVec4ToVec1TakesOnlyX, time elapsed: 224300 ns, RESULT:
    [ PASSED ] CASE: testCastVec4ToVec1TakesOnlyX (15400 ns)
    TCS: TestCase_testCastSameTypeIdentity, time elapsed: 478400 ns, RESULT:
    [ PASSED ] CASE: testCastSameTypeIdentity (40900 ns)
    TCS: TestCase_testCastInt32ToInt64, time elapsed: 334100 ns, RESULT:
    [ PASSED ] CASE: testCastInt32ToInt64 (32500 ns)
    TCS: TestCase_testCastFloatToIntTruncation, time elapsed: 336000 ns, RESULT:
    [ PASSED ] CASE: testCastFloatToIntTruncation (30900 ns)
    TCS: TestCase_testCastCrossQualifierPackedHighpToDefaultp, time elapsed: 344800 ns, RESULT:
    [ PASSED ] CASE: testCastCrossQualifierPackedHighpToDefaultp (40100 ns)
    TCS: TestCase_testCastCrossQualifierDefaultpToPackedHighp, time elapsed: 346900 ns, RESULT:
    [ PASSED ] CASE: testCastCrossQualifierDefaultpToPackedHighp (28200 ns)
    TCS: TestCase_testCastVec2CrossQualifierCrossType, time elapsed: 328000 ns, RESULT:
    [ PASSED ] CASE: testCastVec2CrossQualifierCrossType (31300 ns)
    TCS: TestCase_testCastVec3CrossQualifier, time elapsed: 443000 ns, RESULT:
    [ PASSED ] CASE: testCastVec3CrossQualifier (30400 ns)
    TCS: TestCase_testCastVec4CrossQualifier, time elapsed: 353800 ns, RESULT:
    [ PASSED ] CASE: testCastVec4CrossQualifier (15900 ns)
    TCS: TestCase_testCastVec1DoesNotModifySource, time elapsed: 323200 ns, RESULT:
    [ PASSED ] CASE: testCastVec1DoesNotModifySource (15500 ns)
    TCS: TestCase_testCastVec2Vec1ToVec2IntToFloat, time elapsed: 351000 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec1ToVec2IntToFloat (19600 ns)
    TCS: TestCase_testCastVec2Vec2ToVec2Identity, time elapsed: 343700 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec2ToVec2Identity (17300 ns)
    TCS: TestCase_testCastVec2Vec3ToVec2TakesOnlyXY, time elapsed: 399500 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec3ToVec2TakesOnlyXY (29200 ns)
    TCS: TestCase_testCastVec2Vec4ToVec2TakesOnlyXY, time elapsed: 331500 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec4ToVec2TakesOnlyXY (18300 ns)
    TCS: TestCase_testCastVec2SameTypeIdentity, time elapsed: 216800 ns, RESULT:
    [ PASSED ] CASE: testCastVec2SameTypeIdentity (10600 ns)
    TCS: TestCase_testCastVec2Int32ToInt64, time elapsed: 234300 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Int32ToInt64 (12000 ns)
    TCS: TestCase_testCastVec2FloatToIntTruncation, time elapsed: 214800 ns, RESULT:
    [ PASSED ] CASE: testCastVec2FloatToIntTruncation (16800 ns)
    TCS: TestCase_testCastVec2CrossQualifierPackedHighpToDefaultp, time elapsed: 195400 ns, RESULT:
    [ PASSED ] CASE: testCastVec2CrossQualifierPackedHighpToDefaultp (8000 ns)
    TCS: TestCase_testCastVec2DoesNotModifySource, time elapsed: 182700 ns, RESULT:
    [ PASSED ] CASE: testCastVec2DoesNotModifySource (6300 ns)
    TCS: TestCase_testCastVec2Vec1ToVec2SameValueBothComponents, time elapsed: 205800 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec1ToVec2SameValueBothComponents (8900 ns)
    TCS: TestCase_testCastVec3Vec1ToVec3IntToFloat, time elapsed: 191100 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec1ToVec3IntToFloat (15500 ns)
    TCS: TestCase_testCastVec3Vec2ToVec3ExtendY, time elapsed: 209900 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec2ToVec3ExtendY (8700 ns)
    TCS: TestCase_testCastVec3Vec3ToVec3Identity, time elapsed: 284200 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec3ToVec3Identity (19300 ns)
    TCS: TestCase_testCastVec3Vec4ToVec3TakesOnlyXYZ, time elapsed: 201300 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec4ToVec3TakesOnlyXYZ (8200 ns)
    TCS: TestCase_testCastVec3SameTypeIdentity, time elapsed: 194100 ns, RESULT:
    [ PASSED ] CASE: testCastVec3SameTypeIdentity (7300 ns)
    TCS: TestCase_testCastVec3Int32ToInt64, time elapsed: 190800 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Int32ToInt64 (8200 ns)
    TCS: TestCase_testCastVec3FloatToIntTruncation, time elapsed: 197900 ns, RESULT:
    [ PASSED ] CASE: testCastVec3FloatToIntTruncation (8700 ns)
    TCS: TestCase_testCastVec3CrossQualifierPackedHighpToDefaultp, time elapsed: 196900 ns, RESULT:
    [ PASSED ] CASE: testCastVec3CrossQualifierPackedHighpToDefaultp (10400 ns)
    TCS: TestCase_testCastVec3DoesNotModifySource, time elapsed: 176000 ns, RESULT:
    [ PASSED ] CASE: testCastVec3DoesNotModifySource (6700 ns)
    TCS: TestCase_testCastVec3Vec1ToVec3SameValueAllComponents, time elapsed: 250700 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec1ToVec3SameValueAllComponents (8500 ns)
    TCS: TestCase_testCastVec4Vec1ToVec4IntToFloat, time elapsed: 196400 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec1ToVec4IntToFloat (14700 ns)
    TCS: TestCase_testCastVec4Vec2ToVec4ExtendY, time elapsed: 199700 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec2ToVec4ExtendY (14800 ns)
    TCS: TestCase_testCastVec4Vec3ToVec4ExtendZ, time elapsed: 193900 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec3ToVec4ExtendZ (12600 ns)
    TCS: TestCase_testCastVec4Vec4ToVec4Identity, time elapsed: 203900 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec4ToVec4Identity (12200 ns)
    TCS: TestCase_testCastVec4SameTypeIdentity, time elapsed: 205400 ns, RESULT:
    [ PASSED ] CASE: testCastVec4SameTypeIdentity (7900 ns)
    TCS: TestCase_testCastVec4Int32ToInt64, time elapsed: 192600 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Int32ToInt64 (8400 ns)
    TCS: TestCase_testCastVec4FloatToIntTruncation, time elapsed: 223100 ns, RESULT:
    [ PASSED ] CASE: testCastVec4FloatToIntTruncation (9000 ns)
    TCS: TestCase_testCastVec4CrossQualifierPackedHighpToDefaultp, time elapsed: 274200 ns, RESULT:
    [ PASSED ] CASE: testCastVec4CrossQualifierPackedHighpToDefaultp (17600 ns)
    TCS: TestCase_testCastVec4DoesNotModifySource, time elapsed: 211800 ns, RESULT:
    [ PASSED ] CASE: testCastVec4DoesNotModifySource (8800 ns)
    TCS: TestCase_testCastVec4Vec1ToVec4SameValueAllComponents, time elapsed: 261700 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec1ToVec4SameValueAllComponents (10100 ns)
    TCS: TestCase_testFromBoolVec1, time elapsed: 198900 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec1 (14300 ns)
    TCS: TestCase_testFromBoolVec1False, time elapsed: 183300 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec1False (6800 ns)
    TCS: TestCase_testFromBoolVec2, time elapsed: 207000 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec2 (12700 ns)
    TCS: TestCase_testFromBoolVec3, time elapsed: 223300 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec3 (13500 ns)
    TCS: TestCase_testFromBoolVec4, time elapsed: 200200 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec4 (13400 ns)
    TCS: TestCase_testFromBoolVecQ2Vec1, time elapsed: 169400 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec1 (5700 ns)
    TCS: TestCase_testFromBoolVecQ2Vec2, time elapsed: 219000 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec2 (15700 ns)
    TCS: TestCase_testFromBoolVecQ2Vec3, time elapsed: 193000 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec3 (6400 ns)
    TCS: TestCase_testFromBoolVecQ2Vec4, time elapsed: 176100 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec4 (10900 ns)
    TCS: TestCase_testFromBoolVec3AllFalse, time elapsed: 175400 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec3AllFalse (7200 ns)
    TCS: TestCase_testFromBoolVec4AllFalse, time elapsed: 199800 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec4AllFalse (7300 ns)
    TCS: TestCase_testFromBoolVecQ2Vec3AllFalse, time elapsed: 178800 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec3AllFalse (6300 ns)
    TCS: TestCase_testFromBoolVecQ2Vec4AllFalse, time elapsed: 162600 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec4AllFalse (5500 ns)
    TCS: TestCase_testFromBoolVecFloat32, time elapsed: 166900 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecFloat32 (8600 ns)
    TCS: TestCase_testFromBoolVecFloat64, time elapsed: 291500 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecFloat64 (18700 ns)
    TCS: TestCase_testFromBoolVecInt32, time elapsed: 186700 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecInt32 (11500 ns)
    TCS: TestCase_testFromBoolVecQ2PackedMediump, time elapsed: 180500 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2PackedMediump (8400 ns)
    TCS: TestCase_testFromBoolVecQ2PackedLowp, time elapsed: 193500 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2PackedLowp (14200 ns)
    TCS: TestCase_testS1QuatCastScalingXBranch, time elapsed: 227100 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastScalingXBranch (55800 ns)
    TCS: TestCase_testS1QuatCastScalingYBranch, time elapsed: 192600 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastScalingYBranch (26900 ns)
    TCS: TestCase_testS1QuatCastScalingZBranch, time elapsed: 176700 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastScalingZBranch (14700 ns)
    TCS: TestCase_testS1QuatCastScalingWBranch, time elapsed: 178100 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastScalingWBranch (16500 ns)
    TCS: TestCase_testS1QuatCastUnitRoundTrip, time elapsed: 170600 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastUnitRoundTrip (11800 ns)
    TCS: TestCase_testS1QuatCastIdentityRoundTrip, time elapsed: 207700 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastIdentityRoundTrip (11000 ns)
    TCS: TestCase_testS1QuatCastMat4Delegation, time elapsed: 273800 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastMat4Delegation (48700 ns)
    TCS: TestCase_testMat3EqualEpsilonRelaxedExactMatch, time elapsed: 171800 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedExactMatch (7400 ns)
    TCS: TestCase_testMat3EqualEpsilonRelaxedWithinPosTolerance, time elapsed: 198100 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedWithinPosTolerance (11000 ns)
    TCS: TestCase_testMat3EqualEpsilonRelaxedWithinNegTolerance, time elapsed: 229600 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedWithinNegTolerance (13900 ns)
    TCS: TestCase_testMat3EqualEpsilonRelaxedBeyondTolerance, time elapsed: 197200 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedBeyondTolerance (6900 ns)
    TCS: TestCase_testMat3EqualEpsilonRelaxedZeroMatrix, time elapsed: 179300 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedZeroMatrix (6400 ns)
    TCS: TestCase_testMat3EqualEpsilonRelaxedSingleDiffBeyond, time elapsed: 180900 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedSingleDiffBeyond (8300 ns)
    TCS: TestCase_testVec2ScalarInit, time elapsed: 214800 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarInit (21300 ns)
    TCS: TestCase_testVec2ConstInit, time elapsed: 194700 ns, RESULT:
    [ PASSED ] CASE: testVec2ConstInit (15400 ns)
    TCS: TestCase_testVec2Length, time elapsed: 175000 ns, RESULT:
    [ PASSED ] CASE: testVec2Length (6100 ns)
    TCS: TestCase_testVec2Add, time elapsed: 191100 ns, RESULT:
    [ PASSED ] CASE: testVec2Add (13800 ns)
    TCS: TestCase_testVec2Sub, time elapsed: 188800 ns, RESULT:
    [ PASSED ] CASE: testVec2Sub (11100 ns)
    TCS: TestCase_testVec2Mul, time elapsed: 179200 ns, RESULT:
    [ PASSED ] CASE: testVec2Mul (9100 ns)
    TCS: TestCase_testVec2ScalarAdd, time elapsed: 185300 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarAdd (9500 ns)
    TCS: TestCase_testVec2Negate, time elapsed: 183700 ns, RESULT:
    [ PASSED ] CASE: testVec2Negate (13800 ns)
    TCS: TestCase_testVec2IndexAccess, time elapsed: 177300 ns, RESULT:
    [ PASSED ] CASE: testVec2IndexAccess (6200 ns)
    TCS: TestCase_testVec2IndexMutate, time elapsed: 194400 ns, RESULT:
    [ PASSED ] CASE: testVec2IndexMutate (9000 ns)
    TCS: TestCase_testVec2ComponentAt, time elapsed: 169600 ns, RESULT:
    [ PASSED ] CASE: testVec2ComponentAt (8500 ns)
    TCS: TestCase_testVec2Equal, time elapsed: 213300 ns, RESULT:
    [ PASSED ] CASE: testVec2Equal (12800 ns)
    TCS: TestCase_testVec2NotEqual, time elapsed: 188900 ns, RESULT:
    [ PASSED ] CASE: testVec2NotEqual (9700 ns)
    TCS: TestCase_testVec2EqualExact, time elapsed: 203200 ns, RESULT:
    [ PASSED ] CASE: testVec2EqualExact (13600 ns)
    TCS: TestCase_testVec2BitwiseAnd, time elapsed: 179900 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseAnd (11600 ns)
    TCS: TestCase_testVec2BitwiseNot, time elapsed: 186500 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseNot (13800 ns)
    TCS: TestCase_testVec2FromVec1, time elapsed: 176500 ns, RESULT:
    [ PASSED ] CASE: testVec2FromVec1 (6900 ns)
    TCS: TestCase_testVec2ShiftLeft, time elapsed: 184800 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftLeft (9600 ns)
    TCS: TestCase_testVec2BoolLogicalAnd, time elapsed: 221200 ns, RESULT:
    [ PASSED ] CASE: testVec2BoolLogicalAnd (17300 ns)
    TCS: TestCase_testVec2Vec1ArithBroadcast, time elapsed: 199900 ns, RESULT:
    [ PASSED ] CASE: testVec2Vec1ArithBroadcast (11000 ns)
    TCS: TestCase_testVec2Vec1BitBroadcast, time elapsed: 190700 ns, RESULT:
    [ PASSED ] CASE: testVec2Vec1BitBroadcast (9900 ns)
    TCS: TestCase_testVec2ShiftLeftVec1, time elapsed: 185400 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftLeftVec1 (8600 ns)
    TCS: TestCase_testVec2Div, time elapsed: 191200 ns, RESULT:
    [ PASSED ] CASE: testVec2Div (10200 ns)
    TCS: TestCase_testVec2Mod, time elapsed: 183000 ns, RESULT:
    [ PASSED ] CASE: testVec2Mod (10400 ns)
    TCS: TestCase_testVec2ScalarSub, time elapsed: 185000 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarSub (11700 ns)
    TCS: TestCase_testVec2ScalarMul, time elapsed: 232800 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarMul (10500 ns)
    TCS: TestCase_testVec2ScalarDiv, time elapsed: 183900 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarDiv (11500 ns)
    TCS: TestCase_testVec2ScalarMod, time elapsed: 328300 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarMod (11100 ns)
    TCS: TestCase_testVec2BoolLogicalOr, time elapsed: 213500 ns, RESULT:
    [ PASSED ] CASE: testVec2BoolLogicalOr (11700 ns)
    TCS: TestCase_testVec2EqualEpsilon, time elapsed: 223200 ns, RESULT:
    [ PASSED ] CASE: testVec2EqualEpsilon (18900 ns)
    TCS: TestCase_testVec2DivNamed, time elapsed: 179200 ns, RESULT:
    [ PASSED ] CASE: testVec2DivNamed (7700 ns)
    TCS: TestCase_testVec2ModNamed, time elapsed: 170700 ns, RESULT:
    [ PASSED ] CASE: testVec2ModNamed (6500 ns)
    TCS: TestCase_testVec2BitwiseOr, time elapsed: 195900 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseOr (14000 ns)
    TCS: TestCase_testVec2BitwiseXor, time elapsed: 186300 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseXor (9500 ns)
    TCS: TestCase_testVec2ScalarBitwiseAnd, time elapsed: 172500 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarBitwiseAnd (9000 ns)
    TCS: TestCase_testVec2ShiftRight, time elapsed: 180000 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftRight (13800 ns)
    TCS: TestCase_testVec2ShiftRightVec1, time elapsed: 190900 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftRightVec1 (9500 ns)
    TCS: TestCase_testVec2AddNamed, time elapsed: 174700 ns, RESULT:
    [ PASSED ] CASE: testVec2AddNamed (6100 ns)
    TCS: TestCase_testVec2SubNamed, time elapsed: 160900 ns, RESULT:
    [ PASSED ] CASE: testVec2SubNamed (5700 ns)
    TCS: TestCase_testVec2MulNamed, time elapsed: 164000 ns, RESULT:
    [ PASSED ] CASE: testVec2MulNamed (6100 ns)
    TCS: TestCase_testVec2ShiftLeftVec, time elapsed: 322200 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftLeftVec (20400 ns)
    TCS: TestCase_testVec2ShiftRightVec, time elapsed: 270900 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftRightVec (12500 ns)
    TCS: TestCase_testVec2ScalarBitwiseOr, time elapsed: 184600 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarBitwiseOr (14500 ns)
    TCS: TestCase_testVec2ScalarBitwiseXor, time elapsed: 176400 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarBitwiseXor (10400 ns)
    TCS: TestCase_testVec2Increment, time elapsed: 179300 ns, RESULT:
    [ PASSED ] CASE: testVec2Increment (12400 ns)
    TCS: TestCase_testVec2Decrement, time elapsed: 168700 ns, RESULT:
    [ PASSED ] CASE: testVec2Decrement (9600 ns)
    TCS: TestCase_testVec2IndexOutOfBoundsAccess, time elapsed: 233800 ns, RESULT:
    [ PASSED ] CASE: testVec2IndexOutOfBoundsAccess (57000 ns)
    TCS: TestCase_testVec2NegativeIndexAccess, time elapsed: 194000 ns, RESULT:
    [ PASSED ] CASE: testVec2NegativeIndexAccess (22600 ns)
    TCS: TestCase_testVec3ScalarInit, time elapsed: 191400 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarInit (11500 ns)
    TCS: TestCase_testVec3ConstInit, time elapsed: 188400 ns, RESULT:
    [ PASSED ] CASE: testVec3ConstInit (6000 ns)
    TCS: TestCase_testVec3Length, time elapsed: 202200 ns, RESULT:
    [ PASSED ] CASE: testVec3Length (8000 ns)
    TCS: TestCase_testVec3Add, time elapsed: 257900 ns, RESULT:
    [ PASSED ] CASE: testVec3Add (26700 ns)
    TCS: TestCase_testVec3ScalarMul, time elapsed: 206000 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarMul (15600 ns)
    TCS: TestCase_testVec3Negate, time elapsed: 233500 ns, RESULT:
    [ PASSED ] CASE: testVec3Negate (10300 ns)
    TCS: TestCase_testVec3IndexAccess, time elapsed: 214600 ns, RESULT:
    [ PASSED ] CASE: testVec3IndexAccess (13500 ns)
    TCS: TestCase_testVec3IndexMutate, time elapsed: 380900 ns, RESULT:
    [ PASSED ] CASE: testVec3IndexMutate (13300 ns)
    TCS: TestCase_testVec3ComponentAt, time elapsed: 235800 ns, RESULT:
    [ PASSED ] CASE: testVec3ComponentAt (7600 ns)
    TCS: TestCase_testVec3Equal, time elapsed: 229000 ns, RESULT:
    [ PASSED ] CASE: testVec3Equal (23800 ns)
    TCS: TestCase_testVec3NotEqual, time elapsed: 356500 ns, RESULT:
    [ PASSED ] CASE: testVec3NotEqual (27900 ns)
    TCS: TestCase_testVec3EqualExact, time elapsed: 228000 ns, RESULT:
    [ PASSED ] CASE: testVec3EqualExact (13800 ns)
    TCS: TestCase_testVec3BitwiseAnd, time elapsed: 228600 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseAnd (16200 ns)
    TCS: TestCase_testVec3BitwiseNot, time elapsed: 196200 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseNot (8000 ns)
    TCS: TestCase_testVec3Vec1ArithBroadcast, time elapsed: 186800 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1ArithBroadcast (17700 ns)
    TCS: TestCase_testVec3ShiftLeft, time elapsed: 228400 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftLeft (12600 ns)
    TCS: TestCase_testVec3BoolLogicalAnd, time elapsed: 200000 ns, RESULT:
    [ PASSED ] CASE: testVec3BoolLogicalAnd (11000 ns)
    TCS: TestCase_testVec3Sub, time elapsed: 180700 ns, RESULT:
    [ PASSED ] CASE: testVec3Sub (12100 ns)
    TCS: TestCase_testVec3Div, time elapsed: 191800 ns, RESULT:
    [ PASSED ] CASE: testVec3Div (11500 ns)
    TCS: TestCase_testVec3Mod, time elapsed: 244500 ns, RESULT:
    [ PASSED ] CASE: testVec3Mod (14100 ns)
    TCS: TestCase_testVec3ScalarSub, time elapsed: 224500 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarSub (21900 ns)
    TCS: TestCase_testVec3ScalarDiv, time elapsed: 186400 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarDiv (11300 ns)
    TCS: TestCase_testVec3ScalarMod, time elapsed: 198800 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarMod (10400 ns)
    TCS: TestCase_testVec3BoolLogicalOr, time elapsed: 203100 ns, RESULT:
    [ PASSED ] CASE: testVec3BoolLogicalOr (7900 ns)
    TCS: TestCase_testVec3EqualEpsilon, time elapsed: 189300 ns, RESULT:
    [ PASSED ] CASE: testVec3EqualEpsilon (14500 ns)
    TCS: TestCase_testVec3AddNamed, time elapsed: 213700 ns, RESULT:
    [ PASSED ] CASE: testVec3AddNamed (15600 ns)
    TCS: TestCase_testVec3MulNamed, time elapsed: 181200 ns, RESULT:
    [ PASSED ] CASE: testVec3MulNamed (6900 ns)
    TCS: TestCase_testVec3DivNamed, time elapsed: 210100 ns, RESULT:
    [ PASSED ] CASE: testVec3DivNamed (6200 ns)
    TCS: TestCase_testVec3ModNamed, time elapsed: 168700 ns, RESULT:
    [ PASSED ] CASE: testVec3ModNamed (5900 ns)
    TCS: TestCase_testVec3BitwiseOr, time elapsed: 200200 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseOr (15100 ns)
    TCS: TestCase_testVec3BitwiseXor, time elapsed: 193100 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseXor (14900 ns)
    TCS: TestCase_testVec3ScalarBitwiseAnd, time elapsed: 210500 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarBitwiseAnd (20300 ns)
    TCS: TestCase_testVec3ShiftRight, time elapsed: 198500 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftRight (10600 ns)
    TCS: TestCase_testVec3Vec1BitBroadcast, time elapsed: 204400 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1BitBroadcast (21000 ns)
    TCS: TestCase_testVec3ShiftRightVec1, time elapsed: 176200 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftRightVec1 (10100 ns)
    TCS: TestCase_testVec3FromVec1, time elapsed: 198200 ns, RESULT:
    [ PASSED ] CASE: testVec3FromVec1 (7300 ns)
    TCS: TestCase_testVec3ScalarBitwiseOr, time elapsed: 209000 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarBitwiseOr (15500 ns)
    TCS: TestCase_testVec3ScalarBitwiseXor, time elapsed: 180800 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarBitwiseXor (11600 ns)
    TCS: TestCase_testVec3Vec1BitOrBroadcast, time elapsed: 213600 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1BitOrBroadcast (14000 ns)
    TCS: TestCase_testVec3Vec1BitXorBroadcast, time elapsed: 200200 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1BitXorBroadcast (10100 ns)
    TCS: TestCase_testVec3ShiftLeftVec1, time elapsed: 208100 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftLeftVec1 (11900 ns)
    TCS: TestCase_testVec3ShiftLeftVec, time elapsed: 169600 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftLeftVec (8500 ns)
    TCS: TestCase_testVec3ShiftRightVec, time elapsed: 168600 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftRightVec (13300 ns)
    TCS: TestCase_testVec3Increment, time elapsed: 191700 ns, RESULT:
    [ PASSED ] CASE: testVec3Increment (13400 ns)
    TCS: TestCase_testVec3Decrement, time elapsed: 300700 ns, RESULT:
    [ PASSED ] CASE: testVec3Decrement (20000 ns)
    TCS: TestCase_testVec3IndexOutOfBoundsAccess, time elapsed: 227900 ns, RESULT:
    [ PASSED ] CASE: testVec3IndexOutOfBoundsAccess (48200 ns)
    TCS: TestCase_testVec3NegativeIndexAccess, time elapsed: 184400 ns, RESULT:
    [ PASSED ] CASE: testVec3NegativeIndexAccess (17000 ns)
    TCS: TestCase_testVec4ScalarInit, time elapsed: 215900 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarInit (21700 ns)
    TCS: TestCase_testVec4ConstInit, time elapsed: 199300 ns, RESULT:
    [ PASSED ] CASE: testVec4ConstInit (7700 ns)
    TCS: TestCase_testVec4Length, time elapsed: 210100 ns, RESULT:
    [ PASSED ] CASE: testVec4Length (9600 ns)
    TCS: TestCase_testVec4Add, time elapsed: 183000 ns, RESULT:
    [ PASSED ] CASE: testVec4Add (16400 ns)
    TCS: TestCase_testVec4ScalarMul, time elapsed: 191000 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarMul (12500 ns)
    TCS: TestCase_testVec4Negate, time elapsed: 177700 ns, RESULT:
    [ PASSED ] CASE: testVec4Negate (9600 ns)
    TCS: TestCase_testVec4IndexAccess, time elapsed: 191000 ns, RESULT:
    [ PASSED ] CASE: testVec4IndexAccess (15000 ns)
    TCS: TestCase_testVec4IndexMutate, time elapsed: 196900 ns, RESULT:
    [ PASSED ] CASE: testVec4IndexMutate (6300 ns)
    TCS: TestCase_testVec4ComponentAt, time elapsed: 180400 ns, RESULT:
    [ PASSED ] CASE: testVec4ComponentAt (7400 ns)
    TCS: TestCase_testVec4Equal, time elapsed: 188100 ns, RESULT:
    [ PASSED ] CASE: testVec4Equal (18400 ns)
    TCS: TestCase_testVec4NotEqual, time elapsed: 169900 ns, RESULT:
    [ PASSED ] CASE: testVec4NotEqual (8700 ns)
    TCS: TestCase_testVec4EqualExact, time elapsed: 178200 ns, RESULT:
    [ PASSED ] CASE: testVec4EqualExact (12800 ns)
    TCS: TestCase_testVec4BitwiseAnd, time elapsed: 280100 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseAnd (25200 ns)
    TCS: TestCase_testVec4BitwiseNot, time elapsed: 192900 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseNot (8300 ns)
    TCS: TestCase_testVec4Vec1ArithBroadcast, time elapsed: 319600 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1ArithBroadcast (15700 ns)
    TCS: TestCase_testVec4ShiftLeft, time elapsed: 215500 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftLeft (15100 ns)
    TCS: TestCase_testVec4BoolLogicalAnd, time elapsed: 197700 ns, RESULT:
    [ PASSED ] CASE: testVec4BoolLogicalAnd (13900 ns)
    TCS: TestCase_testVec4Sub, time elapsed: 245500 ns, RESULT:
    [ PASSED ] CASE: testVec4Sub (18900 ns)
    TCS: TestCase_testVec4Div, time elapsed: 269300 ns, RESULT:
    [ PASSED ] CASE: testVec4Div (17300 ns)
    TCS: TestCase_testVec4Mod, time elapsed: 222800 ns, RESULT:
    [ PASSED ] CASE: testVec4Mod (19300 ns)
    TCS: TestCase_testVec4ScalarSub, time elapsed: 253900 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarSub (18800 ns)
    TCS: TestCase_testVec4ScalarDiv, time elapsed: 213700 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarDiv (15500 ns)
    TCS: TestCase_testVec4ScalarMod, time elapsed: 210400 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarMod (17000 ns)
    TCS: TestCase_testVec4BoolLogicalOr, time elapsed: 210200 ns, RESULT:
    [ PASSED ] CASE: testVec4BoolLogicalOr (11800 ns)
    TCS: TestCase_testVec4EqualEpsilon, time elapsed: 199400 ns, RESULT:
    [ PASSED ] CASE: testVec4EqualEpsilon (21100 ns)
    TCS: TestCase_testVec4AddNamed, time elapsed: 209300 ns, RESULT:
    [ PASSED ] CASE: testVec4AddNamed (12800 ns)
    TCS: TestCase_testVec4MulNamed, time elapsed: 183900 ns, RESULT:
    [ PASSED ] CASE: testVec4MulNamed (9600 ns)
    TCS: TestCase_testVec4DivNamed, time elapsed: 212000 ns, RESULT:
    [ PASSED ] CASE: testVec4DivNamed (9000 ns)
    TCS: TestCase_testVec4ModNamed, time elapsed: 177300 ns, RESULT:
    [ PASSED ] CASE: testVec4ModNamed (11300 ns)
    TCS: TestCase_testVec4BitwiseOr, time elapsed: 191100 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseOr (14800 ns)
    TCS: TestCase_testVec4BitwiseXor, time elapsed: 182700 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseXor (12300 ns)
    TCS: TestCase_testVec4ScalarBitwiseAnd, time elapsed: 206800 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarBitwiseAnd (15000 ns)
    TCS: TestCase_testVec4ShiftRight, time elapsed: 179500 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftRight (9700 ns)
    TCS: TestCase_testVec4Vec1BitBroadcast, time elapsed: 176100 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1BitBroadcast (15700 ns)
    TCS: TestCase_testVec4ShiftRightVec1, time elapsed: 194000 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftRightVec1 (11300 ns)
    TCS: TestCase_testVec4FromVec1, time elapsed: 178600 ns, RESULT:
    [ PASSED ] CASE: testVec4FromVec1 (6700 ns)
    TCS: TestCase_testVec4ScalarBitwiseOr, time elapsed: 172800 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarBitwiseOr (11200 ns)
    TCS: TestCase_testVec4ScalarBitwiseXor, time elapsed: 174000 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarBitwiseXor (9500 ns)
    TCS: TestCase_testVec4Vec1BitOrBroadcast, time elapsed: 211000 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1BitOrBroadcast (13000 ns)
    TCS: TestCase_testVec4Vec1BitXorBroadcast, time elapsed: 205000 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1BitXorBroadcast (10900 ns)
    TCS: TestCase_testVec4ShiftLeftVec1, time elapsed: 180200 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftLeftVec1 (10300 ns)
    TCS: TestCase_testVec4ShiftLeftVec, time elapsed: 208800 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftLeftVec (11600 ns)
    TCS: TestCase_testVec4ShiftRightVec, time elapsed: 221500 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftRightVec (12400 ns)
    TCS: TestCase_testVec4Increment, time elapsed: 203300 ns, RESULT:
    [ PASSED ] CASE: testVec4Increment (19400 ns)
    TCS: TestCase_testVec4Decrement, time elapsed: 182800 ns, RESULT:
    [ PASSED ] CASE: testVec4Decrement (13100 ns)
    TCS: TestCase_testVec4IndexOutOfBoundsAccess, time elapsed: 254600 ns, RESULT:
    [ PASSED ] CASE: testVec4IndexOutOfBoundsAccess (52000 ns)
    TCS: TestCase_testVec4NegativeIndexAccess, time elapsed: 211600 ns, RESULT:
    [ PASSED ] CASE: testVec4NegativeIndexAccess (20800 ns)
    TCS: TestCase_testFunctor1Vec1Identity, time elapsed: 188800 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec1Identity (9800 ns)
    TCS: TestCase_testFunctor1Vec1Transform, time elapsed: 195100 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec1Transform (11900 ns)
    TCS: TestCase_testFunctor1Vec2Transform, time elapsed: 196000 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec2Transform (9600 ns)
    TCS: TestCase_testFunctor2Vec1Add, time elapsed: 171100 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec1Add (6900 ns)
    TCS: TestCase_testFunctor2VecScaVec1Mul, time elapsed: 173300 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec1Mul (15300 ns)
    TCS: TestCase_testFunctor2VecIntVec1Shift, time elapsed: 166200 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec1Shift (8600 ns)
    TCS: TestCase_testFunctor1Vec3Transform, time elapsed: 161100 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec3Transform (6800 ns)
    TCS: TestCase_testFunctor1Vec4Transform, time elapsed: 178600 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec4Transform (7600 ns)
    TCS: TestCase_testFunctor2Vec2Add, time elapsed: 176300 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec2Add (6700 ns)
    TCS: TestCase_testFunctor2Vec3Add, time elapsed: 166500 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec3Add (6800 ns)
    TCS: TestCase_testFunctor2Vec4Add, time elapsed: 164400 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec4Add (6800 ns)
    TCS: TestCase_testFunctor2VecScaVec2Mul, time elapsed: 180200 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec2Mul (9800 ns)
    TCS: TestCase_testFunctor2VecScaVec3Mul, time elapsed: 169500 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec3Mul (9900 ns)
    TCS: TestCase_testFunctor2VecScaVec4Mul, time elapsed: 173000 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec4Mul (7000 ns)
    TCS: TestCase_testFunctor2VecIntVec2Shift, time elapsed: 182100 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec2Shift (9900 ns)
    TCS: TestCase_testFunctor2VecIntVec3Shift, time elapsed: 176800 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec3Shift (5800 ns)
    TCS: TestCase_testFunctor2VecIntVec4Shift, time elapsed: 178900 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec4Shift (13300 ns)
Summary: TOTAL: 435
    PASSED: 435, SKIPPED: 0, ERROR: 0
    FAILED: 0
--------------------------------------------------------------------------------------------------
Project tests finished, time elapsed: 158707800 ns, RESULT:
TP: glm.*, time elapsed: 158637300 ns, RESULT:
    PASSED:
    TP: glm.detail, time elapsed: 142984500 ns
Summary: TOTAL: 435
    PASSED: 435, SKIPPED: 0, ERROR: 0
    FAILED: 0
--------------------------------------------------------------------------------------------------
cjpm test success
