# 验证报告（v15）

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
TP: glm.detail, time elapsed: 134581000 ns, RESULT:
    TCS: TestCase_testComputeVecAdd1, time elapsed: 1366200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAdd1 (282100 ns)
    TCS: TestCase_testComputeVecSub2, time elapsed: 332500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSub2 (37200 ns)
    TCS: TestCase_testComputeVecMul3, time elapsed: 314400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMul3 (33200 ns)
    TCS: TestCase_testComputeVecMod1, time elapsed: 259200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMod1 (25400 ns)
    TCS: TestCase_testComputeVecMod4, time elapsed: 284800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMod4 (29500 ns)
    TCS: TestCase_testComputeVecAnd1, time elapsed: 333100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAnd1 (25200 ns)
    TCS: TestCase_testComputeVecAnd3, time elapsed: 250900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAnd3 (22500 ns)
    TCS: TestCase_testComputeVecOr1, time elapsed: 244900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecOr1 (22700 ns)
    TCS: TestCase_testComputeVecOr2, time elapsed: 229600 ns, RESULT:
    [ PASSED ] CASE: testComputeVecOr2 (16900 ns)
    TCS: TestCase_testComputeVecXor1, time elapsed: 267400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecXor1 (47600 ns)
    TCS: TestCase_testComputeVecXor4, time elapsed: 232200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecXor4 (21300 ns)
    TCS: TestCase_testComputeVecShiftLeft1, time elapsed: 232500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftLeft1 (15000 ns)
    TCS: TestCase_testComputeVecShiftLeft3, time elapsed: 231300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftLeft3 (14200 ns)
    TCS: TestCase_testComputeVecShiftRight1, time elapsed: 237200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftRight1 (17800 ns)
    TCS: TestCase_testComputeVecShiftRight4, time elapsed: 228900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecShiftRight4 (15500 ns)
    TCS: TestCase_testComputeVecEqual1, time elapsed: 227400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual1 (18700 ns)
    TCS: TestCase_testComputeVecNequal4, time elapsed: 218400 ns, RESULT:
    [ PASSED ] CASE: testComputeVecNequal4 (15600 ns)
    TCS: TestCase_testComputeVecBitwiseNot1, time elapsed: 239900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecBitwiseNot1 (25900 ns)
    TCS: TestCase_testComputeVecBitwiseNot3, time elapsed: 262600 ns, RESULT:
    [ PASSED ] CASE: testComputeVecBitwiseNot3 (39600 ns)
    TCS: TestCase_testComputeVecAdd4, time elapsed: 234100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAdd4 (22700 ns)
    TCS: TestCase_testComputeVecSub1, time elapsed: 841500 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSub1 (18300 ns)
    TCS: TestCase_testComputeVecSub3, time elapsed: 227900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSub3 (22600 ns)
    TCS: TestCase_testComputeVecMul1, time elapsed: 203300 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMul1 (16500 ns)
    TCS: TestCase_testComputeVecMul2, time elapsed: 200700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecMul2 (16300 ns)
    TCS: TestCase_testComputeVecDiv1, time elapsed: 197700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecDiv1 (18800 ns)
    TCS: TestCase_testComputeVecDiv2, time elapsed: 201200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecDiv2 (15000 ns)
    TCS: TestCase_testComputeVecDiv4, time elapsed: 215000 ns, RESULT:
    [ PASSED ] CASE: testComputeVecDiv4 (17300 ns)
    TCS: TestCase_testComputeVecEqual2, time elapsed: 187900 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual2 (11300 ns)
    TCS: TestCase_testComputeVecEqual3, time elapsed: 201000 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual3 (14800 ns)
    TCS: TestCase_testComputeVecEqual4, time elapsed: 192800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecEqual4 (13600 ns)
    TCS: TestCase_testComputeVecNequal1, time elapsed: 194100 ns, RESULT:
    [ PASSED ] CASE: testComputeVecNequal1 (15700 ns)
    TCS: TestCase_testComputeVecNequal2, time elapsed: 185700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecNequal2 (10200 ns)
    TCS: TestCase_testComputeVecBitwiseNot4, time elapsed: 205700 ns, RESULT:
    [ PASSED ] CASE: testComputeVecBitwiseNot4 (22000 ns)
    TCS: TestCase_testComputeVecAddFloat32, time elapsed: 228000 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAddFloat32 (38900 ns)
    TCS: TestCase_testComputeVecAddFloat32Vec3, time elapsed: 211800 ns, RESULT:
    [ PASSED ] CASE: testComputeVecAddFloat32Vec3 (24000 ns)
    TCS: TestCase_testComputeVecSubFloat32, time elapsed: 197200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSubFloat32 (17700 ns)
    TCS: TestCase_testComputeVecSubFloat32Vec4, time elapsed: 192200 ns, RESULT:
    [ PASSED ] CASE: testComputeVecSubFloat32Vec4 (18900 ns)
    TCS: TestCase_testComputeEqualInt32Equal, time elapsed: 185400 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt32Equal (13400 ns)
    TCS: TestCase_testComputeEqualInt32NotEqual, time elapsed: 178300 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt32NotEqual (11000 ns)
    TCS: TestCase_testComputeEqualFloat32Equal, time elapsed: 222600 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32Equal (11300 ns)
    TCS: TestCase_testComputeEqualFloat32NotEqual, time elapsed: 224200 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32NotEqual (10100 ns)
    TCS: TestCase_testComputeEqualFloat64Equal, time elapsed: 183200 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64Equal (13100 ns)
    TCS: TestCase_testComputeEqualFloat64NotEqual, time elapsed: 180200 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64NotEqual (9000 ns)
    TCS: TestCase_testComputeEqualBoolEqual, time elapsed: 177500 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualBoolEqual (8700 ns)
    TCS: TestCase_testComputeEqualBoolNotEqual, time elapsed: 176200 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualBoolNotEqual (7400 ns)
    TCS: TestCase_testComputeEqualNumericInt32, time elapsed: 182500 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericInt32 (10000 ns)
    TCS: TestCase_testComputeEqualNumericFloat32, time elapsed: 196700 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32 (27300 ns)
    TCS: TestCase_testComputeEqualNumericFloat32Epsilon, time elapsed: 196600 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32Epsilon (11200 ns)
    TCS: TestCase_testComputeEqualNumericFloat64, time elapsed: 183900 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64 (14000 ns)
    TCS: TestCase_testComputeEqualInt64Equal, time elapsed: 177700 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt64Equal (13400 ns)
    TCS: TestCase_testComputeEqualInt64NotEqual, time elapsed: 180400 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualInt64NotEqual (9700 ns)
    TCS: TestCase_testComputeEqualFloat32Nan, time elapsed: 176500 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32Nan (11100 ns)
    TCS: TestCase_testComputeEqualFloat64Nan, time elapsed: 180500 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64Nan (8100 ns)
    TCS: TestCase_testComputeEqualFloat32SignedZero, time elapsed: 177400 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat32SignedZero (7600 ns)
    TCS: TestCase_testComputeEqualFloat64SignedZero, time elapsed: 175700 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualFloat64SignedZero (7700 ns)
    TCS: TestCase_testComputeEqualNumericFloat32NotEqual, time elapsed: 205200 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32NotEqual (10300 ns)
    TCS: TestCase_testComputeEqualNumericFloat32BeyondEpsilon, time elapsed: 198700 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat32BeyondEpsilon (10700 ns)
    TCS: TestCase_testComputeEqualNumericFloat64NotEqual, time elapsed: 185400 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64NotEqual (15100 ns)
    TCS: TestCase_testComputeEqualNumericFloat64Epsilon, time elapsed: 266000 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64Epsilon (17500 ns)
    TCS: TestCase_testComputeEqualNumericFloat64BeyondEpsilon, time elapsed: 191400 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericFloat64BeyondEpsilon (11200 ns)
    TCS: TestCase_testComputeEqualNumericInt64, time elapsed: 207600 ns, RESULT:
    [ PASSED ] CASE: testComputeEqualNumericInt64 (10700 ns)
    TCS: TestCase_testPackedHighpImplementsQualifier, time elapsed: 206500 ns, RESULT:
    [ PASSED ] CASE: testPackedHighpImplementsQualifier (15100 ns)
    TCS: TestCase_testPackedMediumpImplementsQualifier, time elapsed: 204400 ns, RESULT:
    [ PASSED ] CASE: testPackedMediumpImplementsQualifier (14000 ns)
    TCS: TestCase_testPackedLowpImplementsQualifier, time elapsed: 200400 ns, RESULT:
    [ PASSED ] CASE: testPackedLowpImplementsQualifier (9300 ns)
    TCS: TestCase_testDefaultpIsPackedHighp, time elapsed: 200100 ns, RESULT:
    [ PASSED ] CASE: testDefaultpIsPackedHighp (8200 ns)
    TCS: TestCase_testScalarAddVec1, time elapsed: 197200 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec1 (17000 ns)
    TCS: TestCase_testScalarAddVec2, time elapsed: 195900 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec2 (12800 ns)
    TCS: TestCase_testScalarAddVec3, time elapsed: 204300 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec3 (12400 ns)
    TCS: TestCase_testScalarAddVec4, time elapsed: 201900 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec4 (16600 ns)
    TCS: TestCase_testScalarSubVec1, time elapsed: 206800 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1 (13300 ns)
    TCS: TestCase_testScalarMulVec1, time elapsed: 195400 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1 (13000 ns)
    TCS: TestCase_testScalarDivVec1, time elapsed: 195400 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1 (11900 ns)
    TCS: TestCase_testScalarModVec1, time elapsed: 199200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1 (13700 ns)
    TCS: TestCase_testScalarMulVec2, time elapsed: 196300 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2 (12600 ns)
    TCS: TestCase_testScalarSubVec2, time elapsed: 223400 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2 (18700 ns)
    TCS: TestCase_testScalarSubVec3, time elapsed: 215600 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3 (10100 ns)
    TCS: TestCase_testScalarSubVec4, time elapsed: 198600 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4 (13500 ns)
    TCS: TestCase_testScalarMulVec3, time elapsed: 205500 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3 (11200 ns)
    TCS: TestCase_testScalarMulVec4, time elapsed: 190100 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4 (12100 ns)
    TCS: TestCase_testScalarDivVec2, time elapsed: 183800 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2 (12800 ns)
    TCS: TestCase_testScalarDivVec3, time elapsed: 224200 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3 (12100 ns)
    TCS: TestCase_testScalarDivVec4, time elapsed: 196600 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4 (15300 ns)
    TCS: TestCase_testScalarModVec2, time elapsed: 198000 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2 (10500 ns)
    TCS: TestCase_testScalarModVec3, time elapsed: 192100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3 (12200 ns)
    TCS: TestCase_testScalarModVec4, time elapsed: 189900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4 (13200 ns)
    TCS: TestCase_testScalarModVec1Float32, time elapsed: 199100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Float32 (16700 ns)
    TCS: TestCase_testScalarModVec2Float32, time elapsed: 239900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32 (10500 ns)
    TCS: TestCase_testScalarModVec3Float32, time elapsed: 217300 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Float32 (14400 ns)
    TCS: TestCase_testScalarModVec4Float32, time elapsed: 247200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Float32 (17700 ns)
    TCS: TestCase_testScalarModVec1Float64, time elapsed: 222900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Float64 (12400 ns)
    TCS: TestCase_testScalarModVec2Float64, time elapsed: 202700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float64 (13900 ns)
    TCS: TestCase_testScalarModVec3Float64, time elapsed: 194400 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Float64 (10300 ns)
    TCS: TestCase_testScalarModVec4Float64, time elapsed: 232200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Float64 (10800 ns)
    TCS: TestCase_testScalarModVec1Float16, time elapsed: 227500 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Float16 (25500 ns)
    TCS: TestCase_testScalarModVec2Float16, time elapsed: 212700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float16 (10300 ns)
    TCS: TestCase_testScalarModVec3Float16, time elapsed: 205300 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Float16 (13800 ns)
    TCS: TestCase_testScalarModVec4Float16, time elapsed: 186800 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Float16 (10800 ns)
    TCS: TestCase_testScalarSubVec2PackedMediump, time elapsed: 199300 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2PackedMediump (19400 ns)
    TCS: TestCase_testScalarSubVec2PackedLowp, time elapsed: 194500 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2PackedLowp (16300 ns)
    TCS: TestCase_testScalarMulVec2PackedMediump, time elapsed: 195400 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2PackedMediump (13500 ns)
    TCS: TestCase_testScalarMulVec2PackedLowp, time elapsed: 191800 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2PackedLowp (11400 ns)
    TCS: TestCase_testScalarDivVec2PackedMediump, time elapsed: 194600 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2PackedMediump (9300 ns)
    TCS: TestCase_testScalarDivVec2PackedLowp, time elapsed: 191500 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2PackedLowp (11200 ns)
    TCS: TestCase_testScalarModVec2PackedMediump, time elapsed: 182600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2PackedMediump (13400 ns)
    TCS: TestCase_testScalarModVec2PackedLowp, time elapsed: 189300 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2PackedLowp (11800 ns)
    TCS: TestCase_testScalarModVec2Float32PackedMediump, time elapsed: 191100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32PackedMediump (11700 ns)
    TCS: TestCase_testScalarModVec2Float32PackedLowp, time elapsed: 196200 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32PackedLowp (9000 ns)
    TCS: TestCase_testScalarModVec2Float32NegativeDividend, time elapsed: 203600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32NegativeDividend (13500 ns)
    TCS: TestCase_testScalarModVec2Float32NegativeDivisor, time elapsed: 196500 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32NegativeDivisor (9800 ns)
    TCS: TestCase_testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents, time elapsed: 318700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Float32ZeroDivisorDoesNotAffectOtherComponents (117900 ns)
    TCS: TestCase_testScalarAddVec1Float32, time elapsed: 219400 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec1Float32 (15900 ns)
    TCS: TestCase_testScalarAddVec2Float32, time elapsed: 199200 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec2Float32 (8200 ns)
    TCS: TestCase_testScalarAddVec3Float32, time elapsed: 208300 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec3Float32 (11100 ns)
    TCS: TestCase_testScalarAddVec4Float32, time elapsed: 196500 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec4Float32 (10500 ns)
    TCS: TestCase_testScalarSubVec1Float32, time elapsed: 199000 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1Float32 (11900 ns)
    TCS: TestCase_testScalarSubVec2Float32, time elapsed: 207000 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2Float32 (14500 ns)
    TCS: TestCase_testScalarSubVec3Float32, time elapsed: 204200 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3Float32 (15700 ns)
    TCS: TestCase_testScalarSubVec4Float32, time elapsed: 205100 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4Float32 (15300 ns)
    TCS: TestCase_testScalarMulVec1Float32, time elapsed: 190000 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1Float32 (8300 ns)
    TCS: TestCase_testScalarMulVec2Float32, time elapsed: 188600 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2Float32 (8900 ns)
    TCS: TestCase_testScalarMulVec3Float32, time elapsed: 197700 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3Float32 (9100 ns)
    TCS: TestCase_testScalarMulVec4Float32, time elapsed: 219600 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4Float32 (8900 ns)
    TCS: TestCase_testScalarDivVec1Float32, time elapsed: 192600 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1Float32 (12100 ns)
    TCS: TestCase_testScalarDivVec2Float32, time elapsed: 197400 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2Float32 (9600 ns)
    TCS: TestCase_testScalarDivVec3Float32, time elapsed: 197400 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3Float32 (9500 ns)
    TCS: TestCase_testScalarDivVec4Float32, time elapsed: 184800 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4Float32 (9900 ns)
    TCS: TestCase_testScalarAddVec1Int32, time elapsed: 195100 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec1Int32 (15200 ns)
    TCS: TestCase_testScalarAddVec2Int32, time elapsed: 186600 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec2Int32 (11300 ns)
    TCS: TestCase_testScalarAddVec3Int32, time elapsed: 181700 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec3Int32 (9900 ns)
    TCS: TestCase_testScalarAddVec4Int32, time elapsed: 187600 ns, RESULT:
    [ PASSED ] CASE: testScalarAddVec4Int32 (9700 ns)
    TCS: TestCase_testScalarSubVec1Int32, time elapsed: 213400 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1Int32 (13100 ns)
    TCS: TestCase_testScalarSubVec2Int32, time elapsed: 236500 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec2Int32 (10300 ns)
    TCS: TestCase_testScalarSubVec3Int32, time elapsed: 260600 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3Int32 (23700 ns)
    TCS: TestCase_testScalarSubVec4Int32, time elapsed: 209800 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4Int32 (13600 ns)
    TCS: TestCase_testScalarMulVec1Int32, time elapsed: 220400 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1Int32 (14800 ns)
    TCS: TestCase_testScalarMulVec2Int32, time elapsed: 212300 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec2Int32 (10600 ns)
    TCS: TestCase_testScalarMulVec3Int32, time elapsed: 212200 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3Int32 (14800 ns)
    TCS: TestCase_testScalarMulVec4Int32, time elapsed: 222200 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4Int32 (9500 ns)
    TCS: TestCase_testScalarDivVec1Int32, time elapsed: 263300 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1Int32 (17900 ns)
    TCS: TestCase_testScalarDivVec2Int32, time elapsed: 269900 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec2Int32 (18700 ns)
    TCS: TestCase_testScalarDivVec3Int32, time elapsed: 251200 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3Int32 (14500 ns)
    TCS: TestCase_testScalarDivVec4Int32, time elapsed: 343700 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4Int32 (15300 ns)
    TCS: TestCase_testScalarModVec1Int32, time elapsed: 426300 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1Int32 (28300 ns)
    TCS: TestCase_testScalarModVec2Int32, time elapsed: 559100 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec2Int32 (37300 ns)
    TCS: TestCase_testScalarModVec3Int32, time elapsed: 352700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3Int32 (26800 ns)
    TCS: TestCase_testScalarModVec4Int32, time elapsed: 343700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4Int32 (27300 ns)
    TCS: TestCase_testScalarSubVec1PackedMediump, time elapsed: 298200 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1PackedMediump (33200 ns)
    TCS: TestCase_testScalarSubVec1PackedLowp, time elapsed: 295700 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec1PackedLowp (19300 ns)
    TCS: TestCase_testScalarSubVec3PackedMediump, time elapsed: 194500 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3PackedMediump (10900 ns)
    TCS: TestCase_testScalarSubVec3PackedLowp, time elapsed: 211000 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec3PackedLowp (21600 ns)
    TCS: TestCase_testScalarSubVec4PackedMediump, time elapsed: 188000 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4PackedMediump (10400 ns)
    TCS: TestCase_testScalarSubVec4PackedLowp, time elapsed: 267000 ns, RESULT:
    [ PASSED ] CASE: testScalarSubVec4PackedLowp (11900 ns)
    TCS: TestCase_testScalarMulVec1PackedMediump, time elapsed: 192000 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1PackedMediump (10200 ns)
    TCS: TestCase_testScalarMulVec1PackedLowp, time elapsed: 181500 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec1PackedLowp (9100 ns)
    TCS: TestCase_testScalarMulVec3PackedMediump, time elapsed: 179800 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3PackedMediump (9200 ns)
    TCS: TestCase_testScalarMulVec3PackedLowp, time elapsed: 189900 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec3PackedLowp (9600 ns)
    TCS: TestCase_testScalarMulVec4PackedMediump, time elapsed: 190600 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4PackedMediump (12200 ns)
    TCS: TestCase_testScalarMulVec4PackedLowp, time elapsed: 186700 ns, RESULT:
    [ PASSED ] CASE: testScalarMulVec4PackedLowp (8700 ns)
    TCS: TestCase_testScalarDivVec1PackedMediump, time elapsed: 198400 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1PackedMediump (9500 ns)
    TCS: TestCase_testScalarDivVec1PackedLowp, time elapsed: 199700 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec1PackedLowp (9100 ns)
    TCS: TestCase_testScalarDivVec3PackedMediump, time elapsed: 208000 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3PackedMediump (14300 ns)
    TCS: TestCase_testScalarDivVec3PackedLowp, time elapsed: 203400 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec3PackedLowp (10400 ns)
    TCS: TestCase_testScalarDivVec4PackedMediump, time elapsed: 192900 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4PackedMediump (10400 ns)
    TCS: TestCase_testScalarDivVec4PackedLowp, time elapsed: 226000 ns, RESULT:
    [ PASSED ] CASE: testScalarDivVec4PackedLowp (10400 ns)
    TCS: TestCase_testScalarModVec1PackedMediump, time elapsed: 210700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1PackedMediump (12200 ns)
    TCS: TestCase_testScalarModVec1PackedLowp, time elapsed: 238600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec1PackedLowp (14700 ns)
    TCS: TestCase_testScalarModVec3PackedMediump, time elapsed: 225700 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3PackedMediump (12400 ns)
    TCS: TestCase_testScalarModVec3PackedLowp, time elapsed: 249600 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec3PackedLowp (11600 ns)
    TCS: TestCase_testScalarModVec4PackedMediump, time elapsed: 208900 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4PackedMediump (11400 ns)
    TCS: TestCase_testScalarModVec4PackedLowp, time elapsed: 200000 ns, RESULT:
    [ PASSED ] CASE: testScalarModVec4PackedLowp (9500 ns)
    TCS: TestCase_testScalarDivZeroVec1, time elapsed: 203100 ns, RESULT:
    [ PASSED ] CASE: testScalarDivZeroVec1 (17100 ns)
    TCS: TestCase_testScalarAddNegVec1, time elapsed: 194200 ns, RESULT:
    [ PASSED ] CASE: testScalarAddNegVec1 (15600 ns)
    TCS: TestCase_testScalarAddNegVec2, time elapsed: 195600 ns, RESULT:
    [ PASSED ] CASE: testScalarAddNegVec2 (9500 ns)
    TCS: TestCase_testScalarMulOverflowVec1, time elapsed: 188500 ns, RESULT:
    [ PASSED ] CASE: testScalarMulOverflowVec1 (8500 ns)
    TCS: TestCase_testScalarSubNegVec1, time elapsed: 192700 ns, RESULT:
    [ PASSED ] CASE: testScalarSubNegVec1 (11800 ns)
    TCS: TestCase_testVersionMajor, time elapsed: 199400 ns, RESULT:
    [ PASSED ] CASE: testVersionMajor (9300 ns)
    TCS: TestCase_testVersionMinor, time elapsed: 182900 ns, RESULT:
    [ PASSED ] CASE: testVersionMinor (10200 ns)
    TCS: TestCase_testVersionPatch, time elapsed: 186000 ns, RESULT:
    [ PASSED ] CASE: testVersionPatch (8800 ns)
    TCS: TestCase_testVersionEncoded, time elapsed: 190800 ns, RESULT:
    [ PASSED ] CASE: testVersionEncoded (12100 ns)
    TCS: TestCase_testConfigSimd, time elapsed: 212700 ns, RESULT:
    [ PASSED ] CASE: testConfigSimd (13800 ns)
    TCS: TestCase_testConfigAlignedGentypes, time elapsed: 190500 ns, RESULT:
    [ PASSED ] CASE: testConfigAlignedGentypes (9200 ns)
    TCS: TestCase_testConfigClipControl, time elapsed: 190100 ns, RESULT:
    [ PASSED ] CASE: testConfigClipControl (8400 ns)
    TCS: TestCase_testConstNegationSimd, time elapsed: 188200 ns, RESULT:
    [ PASSED ] CASE: testConstNegationSimd (10500 ns)
    TCS: TestCase_testConstNegationAligned, time elapsed: 226000 ns, RESULT:
    [ PASSED ] CASE: testConstNegationAligned (9200 ns)
    TCS: TestCase_testConstNegationClip, time elapsed: 205300 ns, RESULT:
    [ PASSED ] CASE: testConstNegationClip (10900 ns)
    TCS: TestCase_testConstInt64Usage, time elapsed: 192700 ns, RESULT:
    [ PASSED ] CASE: testConstInt64Usage (9200 ns)
    TCS: TestCase_testConstBoolUsage, time elapsed: 211500 ns, RESULT:
    [ PASSED ] CASE: testConstBoolUsage (10700 ns)
    TCS: TestCase_testVersionEncodingConsistency, time elapsed: 272200 ns, RESULT:
    [ PASSED ] CASE: testVersionEncodingConsistency (19100 ns)
    TCS: TestCase_testAssertPasses, time elapsed: 296900 ns, RESULT:
    [ PASSED ] CASE: testAssertPasses (27400 ns)
    TCS: TestCase_testAssertFails, time elapsed: 468700 ns, RESULT:
    [ PASSED ] CASE: testAssertFails (118100 ns)
    TCS: TestCase_testAssertWithCustomMessage, time elapsed: 304900 ns, RESULT:
    [ PASSED ] CASE: testAssertWithCustomMessage (50800 ns)
    TCS: TestCase_testNumericLimitsFloat32Epsilon, time elapsed: 268200 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsFloat32Epsilon (15700 ns)
    TCS: TestCase_testNumericLimitsFloat64Epsilon, time elapsed: 223000 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsFloat64Epsilon (12100 ns)
    TCS: TestCase_testIsIec559OfFloat32, time elapsed: 196800 ns, RESULT:
    [ PASSED ] CASE: testIsIec559OfFloat32 (14300 ns)
    TCS: TestCase_testIsIec559OfFloat64, time elapsed: 207400 ns, RESULT:
    [ PASSED ] CASE: testIsIec559OfFloat64 (10000 ns)
    TCS: TestCase_testIsIec559OfInt64, time elapsed: 212200 ns, RESULT:
    [ PASSED ] CASE: testIsIec559OfInt64 (14200 ns)
    TCS: TestCase_testEpsilonOfFloat32, time elapsed: 189600 ns, RESULT:
    [ PASSED ] CASE: testEpsilonOfFloat32 (11500 ns)
    TCS: TestCase_testEpsilonOfFloat64, time elapsed: 187600 ns, RESULT:
    [ PASSED ] CASE: testEpsilonOfFloat64 (10200 ns)
    TCS: TestCase_testNumericLimitsInt64Epsilon, time elapsed: 190000 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt64Epsilon (15400 ns)
    TCS: TestCase_testNumericLimitsInt32Epsilon, time elapsed: 185800 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt32Epsilon (11900 ns)
    TCS: TestCase_testNumericLimitsInt16Epsilon, time elapsed: 194200 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt16Epsilon (16500 ns)
    TCS: TestCase_testNumericLimitsInt8Epsilon, time elapsed: 189500 ns, RESULT:
    [ PASSED ] CASE: testNumericLimitsInt8Epsilon (12000 ns)
    TCS: TestCase_testCastVec1ToVec1IntToFloat, time elapsed: 191000 ns, RESULT:
    [ PASSED ] CASE: testCastVec1ToVec1IntToFloat (15600 ns)
    TCS: TestCase_testCastVec2ToVec1TakesOnlyX, time elapsed: 185300 ns, RESULT:
    [ PASSED ] CASE: testCastVec2ToVec1TakesOnlyX (10300 ns)
    TCS: TestCase_testCastVec3ToVec1TakesOnlyX, time elapsed: 183000 ns, RESULT:
    [ PASSED ] CASE: testCastVec3ToVec1TakesOnlyX (12200 ns)
    TCS: TestCase_testCastVec4ToVec1TakesOnlyX, time elapsed: 193700 ns, RESULT:
    [ PASSED ] CASE: testCastVec4ToVec1TakesOnlyX (12800 ns)
    TCS: TestCase_testCastSameTypeIdentity, time elapsed: 401400 ns, RESULT:
    [ PASSED ] CASE: testCastSameTypeIdentity (129900 ns)
    TCS: TestCase_testCastInt32ToInt64, time elapsed: 299100 ns, RESULT:
    [ PASSED ] CASE: testCastInt32ToInt64 (27700 ns)
    TCS: TestCase_testCastFloatToIntTruncation, time elapsed: 291000 ns, RESULT:
    [ PASSED ] CASE: testCastFloatToIntTruncation (25900 ns)
    TCS: TestCase_testCastCrossQualifierPackedHighpToDefaultp, time elapsed: 293800 ns, RESULT:
    [ PASSED ] CASE: testCastCrossQualifierPackedHighpToDefaultp (30500 ns)
    TCS: TestCase_testCastCrossQualifierDefaultpToPackedHighp, time elapsed: 278200 ns, RESULT:
    [ PASSED ] CASE: testCastCrossQualifierDefaultpToPackedHighp (26200 ns)
    TCS: TestCase_testCastVec2CrossQualifierCrossType, time elapsed: 281800 ns, RESULT:
    [ PASSED ] CASE: testCastVec2CrossQualifierCrossType (26700 ns)
    TCS: TestCase_testCastVec3CrossQualifier, time elapsed: 425300 ns, RESULT:
    [ PASSED ] CASE: testCastVec3CrossQualifier (38700 ns)
    TCS: TestCase_testCastVec4CrossQualifier, time elapsed: 344000 ns, RESULT:
    [ PASSED ] CASE: testCastVec4CrossQualifier (18500 ns)
    TCS: TestCase_testCastVec1DoesNotModifySource, time elapsed: 372100 ns, RESULT:
    [ PASSED ] CASE: testCastVec1DoesNotModifySource (18000 ns)
    TCS: TestCase_testCastVec2Vec1ToVec2IntToFloat, time elapsed: 408100 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec1ToVec2IntToFloat (33600 ns)
    TCS: TestCase_testCastVec2Vec2ToVec2Identity, time elapsed: 345700 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec2ToVec2Identity (27900 ns)
    TCS: TestCase_testCastVec2Vec3ToVec2TakesOnlyXY, time elapsed: 325400 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec3ToVec2TakesOnlyXY (32200 ns)
    TCS: TestCase_testCastVec2Vec4ToVec2TakesOnlyXY, time elapsed: 251300 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec4ToVec2TakesOnlyXY (11300 ns)
    TCS: TestCase_testCastVec2SameTypeIdentity, time elapsed: 235900 ns, RESULT:
    [ PASSED ] CASE: testCastVec2SameTypeIdentity (9200 ns)
    TCS: TestCase_testCastVec2Int32ToInt64, time elapsed: 246700 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Int32ToInt64 (10300 ns)
    TCS: TestCase_testCastVec2FloatToIntTruncation, time elapsed: 264700 ns, RESULT:
    [ PASSED ] CASE: testCastVec2FloatToIntTruncation (14400 ns)
    TCS: TestCase_testCastVec2CrossQualifierPackedHighpToDefaultp, time elapsed: 293400 ns, RESULT:
    [ PASSED ] CASE: testCastVec2CrossQualifierPackedHighpToDefaultp (12400 ns)
    TCS: TestCase_testCastVec2DoesNotModifySource, time elapsed: 193700 ns, RESULT:
    [ PASSED ] CASE: testCastVec2DoesNotModifySource (7300 ns)
    TCS: TestCase_testCastVec2Vec1ToVec2SameValueBothComponents, time elapsed: 173100 ns, RESULT:
    [ PASSED ] CASE: testCastVec2Vec1ToVec2SameValueBothComponents (7500 ns)
    TCS: TestCase_testCastVec3Vec1ToVec3IntToFloat, time elapsed: 177600 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec1ToVec3IntToFloat (13600 ns)
    TCS: TestCase_testCastVec3Vec2ToVec3ExtendY, time elapsed: 180500 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec2ToVec3ExtendY (7200 ns)
    TCS: TestCase_testCastVec3Vec3ToVec3Identity, time elapsed: 233200 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec3ToVec3Identity (12700 ns)
    TCS: TestCase_testCastVec3Vec4ToVec3TakesOnlyXYZ, time elapsed: 174100 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec4ToVec3TakesOnlyXYZ (7000 ns)
    TCS: TestCase_testCastVec3SameTypeIdentity, time elapsed: 176400 ns, RESULT:
    [ PASSED ] CASE: testCastVec3SameTypeIdentity (6800 ns)
    TCS: TestCase_testCastVec3Int32ToInt64, time elapsed: 179800 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Int32ToInt64 (7200 ns)
    TCS: TestCase_testCastVec3FloatToIntTruncation, time elapsed: 321800 ns, RESULT:
    [ PASSED ] CASE: testCastVec3FloatToIntTruncation (14500 ns)
    TCS: TestCase_testCastVec3CrossQualifierPackedHighpToDefaultp, time elapsed: 276200 ns, RESULT:
    [ PASSED ] CASE: testCastVec3CrossQualifierPackedHighpToDefaultp (23000 ns)
    TCS: TestCase_testCastVec3DoesNotModifySource, time elapsed: 168700 ns, RESULT:
    [ PASSED ] CASE: testCastVec3DoesNotModifySource (7200 ns)
    TCS: TestCase_testCastVec3Vec1ToVec3SameValueAllComponents, time elapsed: 181000 ns, RESULT:
    [ PASSED ] CASE: testCastVec3Vec1ToVec3SameValueAllComponents (7700 ns)
    TCS: TestCase_testCastVec4Vec1ToVec4IntToFloat, time elapsed: 181300 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec1ToVec4IntToFloat (18800 ns)
    TCS: TestCase_testCastVec4Vec2ToVec4ExtendY, time elapsed: 302600 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec2ToVec4ExtendY (20300 ns)
    TCS: TestCase_testCastVec4Vec3ToVec4ExtendZ, time elapsed: 201900 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec3ToVec4ExtendZ (15600 ns)
    TCS: TestCase_testCastVec4Vec4ToVec4Identity, time elapsed: 174300 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec4ToVec4Identity (10600 ns)
    TCS: TestCase_testCastVec4SameTypeIdentity, time elapsed: 183400 ns, RESULT:
    [ PASSED ] CASE: testCastVec4SameTypeIdentity (7500 ns)
    TCS: TestCase_testCastVec4Int32ToInt64, time elapsed: 163200 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Int32ToInt64 (7200 ns)
    TCS: TestCase_testCastVec4FloatToIntTruncation, time elapsed: 164900 ns, RESULT:
    [ PASSED ] CASE: testCastVec4FloatToIntTruncation (6500 ns)
    TCS: TestCase_testCastVec4CrossQualifierPackedHighpToDefaultp, time elapsed: 161500 ns, RESULT:
    [ PASSED ] CASE: testCastVec4CrossQualifierPackedHighpToDefaultp (8900 ns)
    TCS: TestCase_testCastVec4DoesNotModifySource, time elapsed: 163100 ns, RESULT:
    [ PASSED ] CASE: testCastVec4DoesNotModifySource (6000 ns)
    TCS: TestCase_testCastVec4Vec1ToVec4SameValueAllComponents, time elapsed: 170900 ns, RESULT:
    [ PASSED ] CASE: testCastVec4Vec1ToVec4SameValueAllComponents (6700 ns)
    TCS: TestCase_testFromBoolVec1, time elapsed: 170100 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec1 (10800 ns)
    TCS: TestCase_testFromBoolVec1False, time elapsed: 169000 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec1False (5600 ns)
    TCS: TestCase_testFromBoolVec2, time elapsed: 183100 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec2 (9400 ns)
    TCS: TestCase_testFromBoolVec3, time elapsed: 179300 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec3 (9700 ns)
    TCS: TestCase_testFromBoolVec4, time elapsed: 176700 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec4 (8700 ns)
    TCS: TestCase_testFromBoolVecQ2Vec1, time elapsed: 171800 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec1 (5900 ns)
    TCS: TestCase_testFromBoolVecQ2Vec2, time elapsed: 170400 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec2 (8200 ns)
    TCS: TestCase_testFromBoolVecQ2Vec3, time elapsed: 164000 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec3 (5800 ns)
    TCS: TestCase_testFromBoolVecQ2Vec4, time elapsed: 170600 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec4 (8900 ns)
    TCS: TestCase_testFromBoolVec3AllFalse, time elapsed: 170700 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec3AllFalse (6500 ns)
    TCS: TestCase_testFromBoolVec4AllFalse, time elapsed: 210500 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVec4AllFalse (6400 ns)
    TCS: TestCase_testFromBoolVecQ2Vec3AllFalse, time elapsed: 190800 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec3AllFalse (7000 ns)
    TCS: TestCase_testFromBoolVecQ2Vec4AllFalse, time elapsed: 190900 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2Vec4AllFalse (6600 ns)
    TCS: TestCase_testFromBoolVecFloat32, time elapsed: 189500 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecFloat32 (9800 ns)
    TCS: TestCase_testFromBoolVecFloat64, time elapsed: 184200 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecFloat64 (10100 ns)
    TCS: TestCase_testFromBoolVecInt32, time elapsed: 190300 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecInt32 (11900 ns)
    TCS: TestCase_testFromBoolVecQ2PackedMediump, time elapsed: 180500 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2PackedMediump (6300 ns)
    TCS: TestCase_testFromBoolVecQ2PackedLowp, time elapsed: 188000 ns, RESULT:
    [ PASSED ] CASE: testFromBoolVecQ2PackedLowp (12400 ns)
    TCS: TestCase_testS1QuatCastScalingXBranch, time elapsed: 273300 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastScalingXBranch (85000 ns)
    TCS: TestCase_testS1QuatCastScalingYBranch, time elapsed: 209100 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastScalingYBranch (33200 ns)
    TCS: TestCase_testS1QuatCastScalingZBranch, time elapsed: 209700 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastScalingZBranch (17200 ns)
    TCS: TestCase_testS1QuatCastScalingWBranch, time elapsed: 243500 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastScalingWBranch (24800 ns)
    TCS: TestCase_testS1QuatCastUnitRoundTrip, time elapsed: 205500 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastUnitRoundTrip (13700 ns)
    TCS: TestCase_testS1QuatCastIdentityRoundTrip, time elapsed: 204800 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastIdentityRoundTrip (26300 ns)
    TCS: TestCase_testS1QuatCastMat4Delegation, time elapsed: 262900 ns, RESULT:
    [ PASSED ] CASE: testS1QuatCastMat4Delegation (46900 ns)
    TCS: TestCase_testMat3EqualEpsilonRelaxedExactMatch, time elapsed: 188000 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedExactMatch (7900 ns)
    TCS: TestCase_testMat3EqualEpsilonRelaxedWithinPosTolerance, time elapsed: 209000 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedWithinPosTolerance (7800 ns)
    TCS: TestCase_testMat3EqualEpsilonRelaxedWithinNegTolerance, time elapsed: 311000 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedWithinNegTolerance (27900 ns)
    TCS: TestCase_testMat3EqualEpsilonRelaxedBeyondTolerance, time elapsed: 192800 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedBeyondTolerance (6500 ns)
    TCS: TestCase_testMat3EqualEpsilonRelaxedZeroMatrix, time elapsed: 221500 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedZeroMatrix (6300 ns)
    TCS: TestCase_testMat3EqualEpsilonRelaxedSingleDiffBeyond, time elapsed: 167500 ns, RESULT:
    [ PASSED ] CASE: testMat3EqualEpsilonRelaxedSingleDiffBeyond (6200 ns)
    TCS: TestCase_testVec2ScalarInit, time elapsed: 182600 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarInit (14300 ns)
    TCS: TestCase_testVec2ConstInit, time elapsed: 177800 ns, RESULT:
    [ PASSED ] CASE: testVec2ConstInit (8400 ns)
    TCS: TestCase_testVec2Length, time elapsed: 205900 ns, RESULT:
    [ PASSED ] CASE: testVec2Length (8400 ns)
    TCS: TestCase_testVec2Add, time elapsed: 183200 ns, RESULT:
    [ PASSED ] CASE: testVec2Add (13100 ns)
    TCS: TestCase_testVec2Sub, time elapsed: 168600 ns, RESULT:
    [ PASSED ] CASE: testVec2Sub (10700 ns)
    TCS: TestCase_testVec2Mul, time elapsed: 172500 ns, RESULT:
    [ PASSED ] CASE: testVec2Mul (9100 ns)
    TCS: TestCase_testVec2ScalarAdd, time elapsed: 185900 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarAdd (10000 ns)
    TCS: TestCase_testVec2Negate, time elapsed: 181300 ns, RESULT:
    [ PASSED ] CASE: testVec2Negate (14500 ns)
    TCS: TestCase_testVec2IndexAccess, time elapsed: 180600 ns, RESULT:
    [ PASSED ] CASE: testVec2IndexAccess (7000 ns)
    TCS: TestCase_testVec2IndexMutate, time elapsed: 185100 ns, RESULT:
    [ PASSED ] CASE: testVec2IndexMutate (9600 ns)
    TCS: TestCase_testVec2ComponentAt, time elapsed: 180400 ns, RESULT:
    [ PASSED ] CASE: testVec2ComponentAt (9100 ns)
    TCS: TestCase_testVec2Equal, time elapsed: 309500 ns, RESULT:
    [ PASSED ] CASE: testVec2Equal (18400 ns)
    TCS: TestCase_testVec2NotEqual, time elapsed: 197200 ns, RESULT:
    [ PASSED ] CASE: testVec2NotEqual (12000 ns)
    TCS: TestCase_testVec2EqualExact, time elapsed: 190300 ns, RESULT:
    [ PASSED ] CASE: testVec2EqualExact (15200 ns)
    TCS: TestCase_testVec2BitwiseAnd, time elapsed: 178600 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseAnd (13700 ns)
    TCS: TestCase_testVec2BitwiseNot, time elapsed: 183900 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseNot (9500 ns)
    TCS: TestCase_testVec2FromVec1, time elapsed: 170000 ns, RESULT:
    [ PASSED ] CASE: testVec2FromVec1 (7700 ns)
    TCS: TestCase_testVec2ShiftLeft, time elapsed: 170900 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftLeft (11700 ns)
    TCS: TestCase_testVec2BoolLogicalAnd, time elapsed: 168900 ns, RESULT:
    [ PASSED ] CASE: testVec2BoolLogicalAnd (13800 ns)
    TCS: TestCase_testVec2Vec1ArithBroadcast, time elapsed: 315400 ns, RESULT:
    [ PASSED ] CASE: testVec2Vec1ArithBroadcast (21500 ns)
    TCS: TestCase_testVec2Vec1BitBroadcast, time elapsed: 207500 ns, RESULT:
    [ PASSED ] CASE: testVec2Vec1BitBroadcast (18500 ns)
    TCS: TestCase_testVec2ShiftLeftVec1, time elapsed: 179900 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftLeftVec1 (10600 ns)
    TCS: TestCase_testVec2Div, time elapsed: 185400 ns, RESULT:
    [ PASSED ] CASE: testVec2Div (14000 ns)
    TCS: TestCase_testVec2Mod, time elapsed: 171000 ns, RESULT:
    [ PASSED ] CASE: testVec2Mod (9200 ns)
    TCS: TestCase_testVec2ScalarSub, time elapsed: 178700 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarSub (17600 ns)
    TCS: TestCase_testVec2ScalarMul, time elapsed: 170700 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarMul (9800 ns)
    TCS: TestCase_testVec2ScalarDiv, time elapsed: 170500 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarDiv (9000 ns)
    TCS: TestCase_testVec2ScalarMod, time elapsed: 266300 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarMod (11200 ns)
    TCS: TestCase_testVec2BoolLogicalOr, time elapsed: 191300 ns, RESULT:
    [ PASSED ] CASE: testVec2BoolLogicalOr (11000 ns)
    TCS: TestCase_testVec2EqualEpsilon, time elapsed: 185000 ns, RESULT:
    [ PASSED ] CASE: testVec2EqualEpsilon (18800 ns)
    TCS: TestCase_testVec2DivNamed, time elapsed: 178900 ns, RESULT:
    [ PASSED ] CASE: testVec2DivNamed (6300 ns)
    TCS: TestCase_testVec2ModNamed, time elapsed: 177300 ns, RESULT:
    [ PASSED ] CASE: testVec2ModNamed (6200 ns)
    TCS: TestCase_testVec2BitwiseOr, time elapsed: 167600 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseOr (9400 ns)
    TCS: TestCase_testVec2BitwiseXor, time elapsed: 201100 ns, RESULT:
    [ PASSED ] CASE: testVec2BitwiseXor (8900 ns)
    TCS: TestCase_testVec2ScalarBitwiseAnd, time elapsed: 206900 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarBitwiseAnd (8800 ns)
    TCS: TestCase_testVec2ShiftRight, time elapsed: 275700 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftRight (18200 ns)
    TCS: TestCase_testVec2ShiftRightVec1, time elapsed: 196900 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftRightVec1 (10100 ns)
    TCS: TestCase_testVec2AddNamed, time elapsed: 199400 ns, RESULT:
    [ PASSED ] CASE: testVec2AddNamed (7600 ns)
    TCS: TestCase_testVec2SubNamed, time elapsed: 230700 ns, RESULT:
    [ PASSED ] CASE: testVec2SubNamed (7400 ns)
    TCS: TestCase_testVec2MulNamed, time elapsed: 182100 ns, RESULT:
    [ PASSED ] CASE: testVec2MulNamed (7100 ns)
    TCS: TestCase_testVec2ShiftLeftVec, time elapsed: 193100 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftLeftVec (10000 ns)
    TCS: TestCase_testVec2ShiftRightVec, time elapsed: 182400 ns, RESULT:
    [ PASSED ] CASE: testVec2ShiftRightVec (6900 ns)
    TCS: TestCase_testVec2ScalarBitwiseOr, time elapsed: 193900 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarBitwiseOr (12500 ns)
    TCS: TestCase_testVec2ScalarBitwiseXor, time elapsed: 183700 ns, RESULT:
    [ PASSED ] CASE: testVec2ScalarBitwiseXor (9400 ns)
    TCS: TestCase_testVec2Increment, time elapsed: 181400 ns, RESULT:
    [ PASSED ] CASE: testVec2Increment (9700 ns)
    TCS: TestCase_testVec2Decrement, time elapsed: 191100 ns, RESULT:
    [ PASSED ] CASE: testVec2Decrement (11100 ns)
    TCS: TestCase_testVec2IndexOutOfBoundsAccess, time elapsed: 267200 ns, RESULT:
    [ PASSED ] CASE: testVec2IndexOutOfBoundsAccess (62900 ns)
    TCS: TestCase_testVec2NegativeIndexAccess, time elapsed: 205300 ns, RESULT:
    [ PASSED ] CASE: testVec2NegativeIndexAccess (25200 ns)
    TCS: TestCase_testVec3ScalarInit, time elapsed: 268000 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarInit (17600 ns)
    TCS: TestCase_testVec3ConstInit, time elapsed: 204000 ns, RESULT:
    [ PASSED ] CASE: testVec3ConstInit (7800 ns)
    TCS: TestCase_testVec3Length, time elapsed: 192000 ns, RESULT:
    [ PASSED ] CASE: testVec3Length (6200 ns)
    TCS: TestCase_testVec3Add, time elapsed: 191000 ns, RESULT:
    [ PASSED ] CASE: testVec3Add (20000 ns)
    TCS: TestCase_testVec3ScalarMul, time elapsed: 183900 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarMul (11000 ns)
    TCS: TestCase_testVec3Negate, time elapsed: 177600 ns, RESULT:
    [ PASSED ] CASE: testVec3Negate (9000 ns)
    TCS: TestCase_testVec3IndexAccess, time elapsed: 168400 ns, RESULT:
    [ PASSED ] CASE: testVec3IndexAccess (8700 ns)
    TCS: TestCase_testVec3IndexMutate, time elapsed: 165500 ns, RESULT:
    [ PASSED ] CASE: testVec3IndexMutate (5400 ns)
    TCS: TestCase_testVec3ComponentAt, time elapsed: 182500 ns, RESULT:
    [ PASSED ] CASE: testVec3ComponentAt (6000 ns)
    TCS: TestCase_testVec3Equal, time elapsed: 179000 ns, RESULT:
    [ PASSED ] CASE: testVec3Equal (15600 ns)
    TCS: TestCase_testVec3NotEqual, time elapsed: 178200 ns, RESULT:
    [ PASSED ] CASE: testVec3NotEqual (9900 ns)
    TCS: TestCase_testVec3EqualExact, time elapsed: 185800 ns, RESULT:
    [ PASSED ] CASE: testVec3EqualExact (10300 ns)
    TCS: TestCase_testVec3BitwiseAnd, time elapsed: 203000 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseAnd (12200 ns)
    TCS: TestCase_testVec3BitwiseNot, time elapsed: 166500 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseNot (6100 ns)
    TCS: TestCase_testVec3Vec1ArithBroadcast, time elapsed: 175000 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1ArithBroadcast (14900 ns)
    TCS: TestCase_testVec3ShiftLeft, time elapsed: 178000 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftLeft (9800 ns)
    TCS: TestCase_testVec3BoolLogicalAnd, time elapsed: 215400 ns, RESULT:
    [ PASSED ] CASE: testVec3BoolLogicalAnd (14900 ns)
    TCS: TestCase_testVec3Sub, time elapsed: 174900 ns, RESULT:
    [ PASSED ] CASE: testVec3Sub (11200 ns)
    TCS: TestCase_testVec3Div, time elapsed: 169400 ns, RESULT:
    [ PASSED ] CASE: testVec3Div (10100 ns)
    TCS: TestCase_testVec3Mod, time elapsed: 164100 ns, RESULT:
    [ PASSED ] CASE: testVec3Mod (9200 ns)
    TCS: TestCase_testVec3ScalarSub, time elapsed: 166200 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarSub (12600 ns)
    TCS: TestCase_testVec3ScalarDiv, time elapsed: 164700 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarDiv (9400 ns)
    TCS: TestCase_testVec3ScalarMod, time elapsed: 225300 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarMod (7700 ns)
    TCS: TestCase_testVec3BoolLogicalOr, time elapsed: 279000 ns, RESULT:
    [ PASSED ] CASE: testVec3BoolLogicalOr (12500 ns)
    TCS: TestCase_testVec3EqualEpsilon, time elapsed: 291100 ns, RESULT:
    [ PASSED ] CASE: testVec3EqualEpsilon (18100 ns)
    TCS: TestCase_testVec3AddNamed, time elapsed: 285800 ns, RESULT:
    [ PASSED ] CASE: testVec3AddNamed (22200 ns)
    TCS: TestCase_testVec3MulNamed, time elapsed: 218200 ns, RESULT:
    [ PASSED ] CASE: testVec3MulNamed (7100 ns)
    TCS: TestCase_testVec3DivNamed, time elapsed: 202600 ns, RESULT:
    [ PASSED ] CASE: testVec3DivNamed (7500 ns)
    TCS: TestCase_testVec3ModNamed, time elapsed: 180900 ns, RESULT:
    [ PASSED ] CASE: testVec3ModNamed (8400 ns)
    TCS: TestCase_testVec3BitwiseOr, time elapsed: 245700 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseOr (14000 ns)
    TCS: TestCase_testVec3BitwiseXor, time elapsed: 210100 ns, RESULT:
    [ PASSED ] CASE: testVec3BitwiseXor (15400 ns)
    TCS: TestCase_testVec3ScalarBitwiseAnd, time elapsed: 205700 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarBitwiseAnd (28200 ns)
    TCS: TestCase_testVec3ShiftRight, time elapsed: 196900 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftRight (16800 ns)
    TCS: TestCase_testVec3Vec1BitBroadcast, time elapsed: 189000 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1BitBroadcast (15600 ns)
    TCS: TestCase_testVec3ShiftRightVec1, time elapsed: 201600 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftRightVec1 (12400 ns)
    TCS: TestCase_testVec3FromVec1, time elapsed: 192800 ns, RESULT:
    [ PASSED ] CASE: testVec3FromVec1 (6000 ns)
    TCS: TestCase_testVec3ScalarBitwiseOr, time elapsed: 175400 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarBitwiseOr (13800 ns)
    TCS: TestCase_testVec3ScalarBitwiseXor, time elapsed: 272000 ns, RESULT:
    [ PASSED ] CASE: testVec3ScalarBitwiseXor (20400 ns)
    TCS: TestCase_testVec3Vec1BitOrBroadcast, time elapsed: 296100 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1BitOrBroadcast (20100 ns)
    TCS: TestCase_testVec3Vec1BitXorBroadcast, time elapsed: 313700 ns, RESULT:
    [ PASSED ] CASE: testVec3Vec1BitXorBroadcast (20100 ns)
    TCS: TestCase_testVec3ShiftLeftVec1, time elapsed: 190600 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftLeftVec1 (13700 ns)
    TCS: TestCase_testVec3ShiftLeftVec, time elapsed: 171900 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftLeftVec (9400 ns)
    TCS: TestCase_testVec3ShiftRightVec, time elapsed: 172600 ns, RESULT:
    [ PASSED ] CASE: testVec3ShiftRightVec (12200 ns)
    TCS: TestCase_testVec3Increment, time elapsed: 177500 ns, RESULT:
    [ PASSED ] CASE: testVec3Increment (13700 ns)
    TCS: TestCase_testVec3Decrement, time elapsed: 168600 ns, RESULT:
    [ PASSED ] CASE: testVec3Decrement (11700 ns)
    TCS: TestCase_testVec3IndexOutOfBoundsAccess, time elapsed: 212900 ns, RESULT:
    [ PASSED ] CASE: testVec3IndexOutOfBoundsAccess (43800 ns)
    TCS: TestCase_testVec3NegativeIndexAccess, time elapsed: 226100 ns, RESULT:
    [ PASSED ] CASE: testVec3NegativeIndexAccess (16100 ns)
    TCS: TestCase_testVec4ScalarInit, time elapsed: 221400 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarInit (15800 ns)
    TCS: TestCase_testVec4ConstInit, time elapsed: 199200 ns, RESULT:
    [ PASSED ] CASE: testVec4ConstInit (7700 ns)
    TCS: TestCase_testVec4Length, time elapsed: 193500 ns, RESULT:
    [ PASSED ] CASE: testVec4Length (6800 ns)
    TCS: TestCase_testVec4Add, time elapsed: 230000 ns, RESULT:
    [ PASSED ] CASE: testVec4Add (17200 ns)
    TCS: TestCase_testVec4ScalarMul, time elapsed: 215500 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarMul (14700 ns)
    TCS: TestCase_testVec4Negate, time elapsed: 254400 ns, RESULT:
    [ PASSED ] CASE: testVec4Negate (15600 ns)
    TCS: TestCase_testVec4IndexAccess, time elapsed: 269400 ns, RESULT:
    [ PASSED ] CASE: testVec4IndexAccess (16200 ns)
    TCS: TestCase_testVec4IndexMutate, time elapsed: 184000 ns, RESULT:
    [ PASSED ] CASE: testVec4IndexMutate (6200 ns)
    TCS: TestCase_testVec4ComponentAt, time elapsed: 174300 ns, RESULT:
    [ PASSED ] CASE: testVec4ComponentAt (6100 ns)
    TCS: TestCase_testVec4Equal, time elapsed: 228600 ns, RESULT:
    [ PASSED ] CASE: testVec4Equal (14800 ns)
    TCS: TestCase_testVec4NotEqual, time elapsed: 216000 ns, RESULT:
    [ PASSED ] CASE: testVec4NotEqual (14500 ns)
    TCS: TestCase_testVec4EqualExact, time elapsed: 208200 ns, RESULT:
    [ PASSED ] CASE: testVec4EqualExact (19600 ns)
    TCS: TestCase_testVec4BitwiseAnd, time elapsed: 202300 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseAnd (16400 ns)
    TCS: TestCase_testVec4BitwiseNot, time elapsed: 185100 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseNot (7500 ns)
    TCS: TestCase_testVec4Vec1ArithBroadcast, time elapsed: 190800 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1ArithBroadcast (15100 ns)
    TCS: TestCase_testVec4ShiftLeft, time elapsed: 195400 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftLeft (11300 ns)
    TCS: TestCase_testVec4BoolLogicalAnd, time elapsed: 185400 ns, RESULT:
    [ PASSED ] CASE: testVec4BoolLogicalAnd (11800 ns)
    TCS: TestCase_testVec4Sub, time elapsed: 186900 ns, RESULT:
    [ PASSED ] CASE: testVec4Sub (17400 ns)
    TCS: TestCase_testVec4Div, time elapsed: 187200 ns, RESULT:
    [ PASSED ] CASE: testVec4Div (11200 ns)
    TCS: TestCase_testVec4Mod, time elapsed: 187000 ns, RESULT:
    [ PASSED ] CASE: testVec4Mod (12500 ns)
    TCS: TestCase_testVec4ScalarSub, time elapsed: 198700 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarSub (10100 ns)
    TCS: TestCase_testVec4ScalarDiv, time elapsed: 249700 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarDiv (11200 ns)
    TCS: TestCase_testVec4ScalarMod, time elapsed: 229000 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarMod (19400 ns)
    TCS: TestCase_testVec4BoolLogicalOr, time elapsed: 166900 ns, RESULT:
    [ PASSED ] CASE: testVec4BoolLogicalOr (7400 ns)
    TCS: TestCase_testVec4EqualEpsilon, time elapsed: 189400 ns, RESULT:
    [ PASSED ] CASE: testVec4EqualEpsilon (18200 ns)
    TCS: TestCase_testVec4AddNamed, time elapsed: 175600 ns, RESULT:
    [ PASSED ] CASE: testVec4AddNamed (12400 ns)
    TCS: TestCase_testVec4MulNamed, time elapsed: 179900 ns, RESULT:
    [ PASSED ] CASE: testVec4MulNamed (9300 ns)
    TCS: TestCase_testVec4DivNamed, time elapsed: 188300 ns, RESULT:
    [ PASSED ] CASE: testVec4DivNamed (16900 ns)
    TCS: TestCase_testVec4ModNamed, time elapsed: 164000 ns, RESULT:
    [ PASSED ] CASE: testVec4ModNamed (6400 ns)
    TCS: TestCase_testVec4BitwiseOr, time elapsed: 170800 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseOr (13600 ns)
    TCS: TestCase_testVec4BitwiseXor, time elapsed: 166500 ns, RESULT:
    [ PASSED ] CASE: testVec4BitwiseXor (10900 ns)
    TCS: TestCase_testVec4ScalarBitwiseAnd, time elapsed: 169500 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarBitwiseAnd (10200 ns)
    TCS: TestCase_testVec4ShiftRight, time elapsed: 182000 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftRight (9400 ns)
    TCS: TestCase_testVec4Vec1BitBroadcast, time elapsed: 174000 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1BitBroadcast (11500 ns)
    TCS: TestCase_testVec4ShiftRightVec1, time elapsed: 175500 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftRightVec1 (10100 ns)
    TCS: TestCase_testVec4FromVec1, time elapsed: 179300 ns, RESULT:
    [ PASSED ] CASE: testVec4FromVec1 (6400 ns)
    TCS: TestCase_testVec4ScalarBitwiseOr, time elapsed: 182500 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarBitwiseOr (12500 ns)
    TCS: TestCase_testVec4ScalarBitwiseXor, time elapsed: 181900 ns, RESULT:
    [ PASSED ] CASE: testVec4ScalarBitwiseXor (10500 ns)
    TCS: TestCase_testVec4Vec1BitOrBroadcast, time elapsed: 189700 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1BitOrBroadcast (15600 ns)
    TCS: TestCase_testVec4Vec1BitXorBroadcast, time elapsed: 183300 ns, RESULT:
    [ PASSED ] CASE: testVec4Vec1BitXorBroadcast (10800 ns)
    TCS: TestCase_testVec4ShiftLeftVec1, time elapsed: 273500 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftLeftVec1 (16700 ns)
    TCS: TestCase_testVec4ShiftLeftVec, time elapsed: 190000 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftLeftVec (11400 ns)
    TCS: TestCase_testVec4ShiftRightVec, time elapsed: 198600 ns, RESULT:
    [ PASSED ] CASE: testVec4ShiftRightVec (11700 ns)
    TCS: TestCase_testVec4Increment, time elapsed: 191500 ns, RESULT:
    [ PASSED ] CASE: testVec4Increment (18300 ns)
    TCS: TestCase_testVec4Decrement, time elapsed: 183600 ns, RESULT:
    [ PASSED ] CASE: testVec4Decrement (12800 ns)
    TCS: TestCase_testVec4IndexOutOfBoundsAccess, time elapsed: 219500 ns, RESULT:
    [ PASSED ] CASE: testVec4IndexOutOfBoundsAccess (42600 ns)
    TCS: TestCase_testVec4NegativeIndexAccess, time elapsed: 178700 ns, RESULT:
    [ PASSED ] CASE: testVec4NegativeIndexAccess (15300 ns)
    TCS: TestCase_testFunctor1Vec1Identity, time elapsed: 168100 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec1Identity (7600 ns)
    TCS: TestCase_testFunctor1Vec1Transform, time elapsed: 165500 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec1Transform (9400 ns)
    TCS: TestCase_testFunctor1Vec2Transform, time elapsed: 213800 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec2Transform (7400 ns)
    TCS: TestCase_testFunctor2Vec1Add, time elapsed: 170000 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec1Add (6700 ns)
    TCS: TestCase_testFunctor2VecScaVec1Mul, time elapsed: 180000 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec1Mul (12200 ns)
    TCS: TestCase_testFunctor2VecIntVec1Shift, time elapsed: 180300 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec1Shift (8500 ns)
    TCS: TestCase_testFunctor1Vec3Transform, time elapsed: 169700 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec3Transform (7000 ns)
    TCS: TestCase_testFunctor1Vec4Transform, time elapsed: 168200 ns, RESULT:
    [ PASSED ] CASE: testFunctor1Vec4Transform (7300 ns)
    TCS: TestCase_testFunctor2Vec2Add, time elapsed: 171500 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec2Add (7000 ns)
    TCS: TestCase_testFunctor2Vec3Add, time elapsed: 167600 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec3Add (6300 ns)
    TCS: TestCase_testFunctor2Vec4Add, time elapsed: 175100 ns, RESULT:
    [ PASSED ] CASE: testFunctor2Vec4Add (6800 ns)
    TCS: TestCase_testFunctor2VecScaVec2Mul, time elapsed: 178900 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec2Mul (9600 ns)
    TCS: TestCase_testFunctor2VecScaVec3Mul, time elapsed: 171500 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec3Mul (9600 ns)
    TCS: TestCase_testFunctor2VecScaVec4Mul, time elapsed: 187400 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecScaVec4Mul (7400 ns)
    TCS: TestCase_testFunctor2VecIntVec2Shift, time elapsed: 185300 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec2Shift (10900 ns)
    TCS: TestCase_testFunctor2VecIntVec3Shift, time elapsed: 169500 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec3Shift (6200 ns)
    TCS: TestCase_testFunctor2VecIntVec4Shift, time elapsed: 177800 ns, RESULT:
    [ PASSED ] CASE: testFunctor2VecIntVec4Shift (7100 ns)
Summary: TOTAL: 435
    PASSED: 435, SKIPPED: 0, ERROR: 0
    FAILED: 0
--------------------------------------------------------------------------------------------------
Project tests finished, time elapsed: 150058200 ns, RESULT:
TP: glm.*, time elapsed: 149997000 ns, RESULT:
    PASSED:
    TP: glm.detail, time elapsed: 134581000 ns
Summary: TOTAL: 435
    PASSED: 435, SKIPPED: 0, ERROR: 0
    FAILED: 0
--------------------------------------------------------------------------------------------------
?25hcjpm test success
