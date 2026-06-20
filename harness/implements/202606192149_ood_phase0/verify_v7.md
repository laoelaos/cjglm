# 验证报告（v7）

## 结果
FAILED

## 统计
- 通过：0
- 失败：0（编译错误 252 个，测试未执行）

## 测试执行日志
cjpm : warning[0m: imported decl 'Vec1' is shadowed, it will be ignored by compiler
所在位置 行:1 字符: 168
+ ... C:\Develop\Software\cjglm_wp\cjglm"; if ($?) { cjpm test *>&1 | Out-F ...
+                                                    ~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (warning[0m: im...red by compiler:String) [], RemoteException
    + FullyQualifiedErrorId : NativeCommandError
 

 ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:3:21:

  | 

3 | import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }

  |                     ^^^^ 

  | 

  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`

note[0m: 'Vec1' is declared here

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:99:13:

   | 

99 | public type Vec1 = Vec1<Float32, PackedHighp>

   |             ^^^^ 

   | 



warning[0m: imported decl 'Vec2' is shadowed, it will be ignored by compiler

 ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:3:27:

  | 

3 | import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }

  |                           ^^^^ 

  | 

  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`

note[0m: 'Vec2' is declared here

   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:100:13:

    | 

100 | public type Vec2 = Vec2<Float32, PackedHighp>

    |             ^^^^ 

    | 



warning[0m: imported decl 'Vec3' is shadowed, it will be ignored by compiler

 ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:3:33:

  | 

3 | import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }

  |                                 ^^^^ 

  | 

  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`

note[0m: 'Vec3' is declared here

   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:101:13:

    | 

101 | public type Vec3 = Vec3<Float32, PackedHighp>

    |             ^^^^ 

    | 



warning[0m: imported decl 'Vec4' is shadowed, it will be ignored by compiler

 ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:3:39:

  | 

3 | import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }

  |                                       ^^^^ 

  | 

  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`

note[0m: 'Vec4' is declared here

   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:102:13:

    | 

102 | public type Vec4 = Vec4<Float32, PackedHighp>

    |             ^^^^ 

    | 



warning[0m: imported decl 'Vec1' is shadowed, it will be ignored by compiler

 ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:2:28:

  | 

2 | public import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }

  |                            ^^^^ 

  | 

  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`

note[0m: 'Vec1' is declared here

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:99:13:

   | 

99 | public type Vec1 = Vec1<Float32, PackedHighp>

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

   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:100:13:

    | 

100 | public type Vec2 = Vec2<Float32, PackedHighp>

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

   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:101:13:

    | 

101 | public type Vec3 = Vec3<Float32, PackedHighp>

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

   ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:102:13:

    | 

102 | public type Vec4 = Vec4<Float32, PackedHighp>

    |             ^^^^ 

    | 



error[0m: type argument's number does not match type parameter's number

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:51:21:

   | 

51 | public type BVec1 = Vec1<Bool, PackedHighp>

   |                     ^^^^^^^^^^^^^^^^^^^^^^^ 

   | 



error[0m: type argument's number does not match type parameter's number

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:52:21:

   | 

52 | public type BVec2 = Vec2<Bool, PackedHighp>

   |                     ^^^^^^^^^^^^^^^^^^^^^^^ 

   | 



error[0m: type argument's number does not match type parameter's number

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:53:21:

   | 

53 | public type BVec3 = Vec3<Bool, PackedHighp>

   |                     ^^^^^^^^^^^^^^^^^^^^^^^ 

   | 



error[0m: type argument's number does not match type parameter's number

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:54:21:

   | 

54 | public type BVec4 = Vec4<Bool, PackedHighp>

   |                     ^^^^^^^^^^^^^^^^^^^^^^^ 

   | 



error[0m: type argument's number does not match type parameter's number

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:55:26:

   | 

55 | public type HighpBVec1 = Vec1<Bool, PackedHighp>

   |                          ^^^^^^^^^^^^^^^^^^^^^^^ 

   | 



error[0m: type argument's number does not match type parameter's number

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:56:26:

   | 

56 | public type HighpBVec2 = Vec2<Bool, PackedHighp>

   |                          ^^^^^^^^^^^^^^^^^^^^^^^ 

   | 



error[0m: type argument's number does not match type parameter's number

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:57:26:

   | 

57 | public type HighpBVec3 = Vec3<Bool, PackedHighp>

   |                          ^^^^^^^^^^^^^^^^^^^^^^^ 

   | 



error[0m: type argument's number does not match type parameter's number

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:58:26:

   | 

58 | public type HighpBVec4 = Vec4<Bool, PackedHighp>

   |                          ^^^^^^^^^^^^^^^^^^^^^^^ 

   | 



252 errors generated, 8 errors printed.

8 warnings generated, 8 warnings printed.

Error: failed to compile package `glm`, return code is 1
Error: please execute 'cjpm.exe build -i' successfully first
Error: cjpm test failed
