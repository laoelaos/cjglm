# 验证报告（v3）

## 结果
FAILED

## 统计
- 通过：0
- 失败：0（编译失败，112 errors）

## 测试执行日志cjpm.exe : error[0m: '()' is not a static member of exposed generic parameter 'T'
所在位置 行:1 字符: 52
+ ... \Develop\Software\cjglm_wp\cjglm"; if ($?) { & cjpm test 2>&1 | Out-F ...
+                                                  ~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (error[0m: '()'...c parameter 'T':String) [], RemoteException
    + FullyQualifiedErrorId : NativeCommandError
 

 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_fromBoolVec.cj:4:28:

  | 

4 |     return Vec1(if (v.x) { T(1) } else { T(0) })

  |                            ^ 

  | 



error[0m: '()' is not a static member of exposed generic parameter 'T'

 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_fromBoolVec.cj:4:42:

  | 

4 |     return Vec1(if (v.x) { T(1) } else { T(0) })

  |                                          ^ 

  | 



error[0m: '()' is not a static member of exposed generic parameter 'T'

 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_fromBoolVec.cj:8:34:

  | 

8 |     return Vec1<T, Q>(if (v.x) { T(1) } else { T(0) })

  |                                  ^ 

  | 



error[0m: '()' is not a static member of exposed generic parameter 'T'

 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_fromBoolVec.cj:8:48:

  | 

8 |     return Vec1<T, Q>(if (v.x) { T(1) } else { T(0) })

  |                                                ^ 

  | 



error[0m: '()' is not a static member of exposed generic parameter 'T'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_fromBoolVec.cj:12:28:

   | 

12 |     return Vec2(if (v.x) { T(1) } else { T(0) }, if (v.y) { T(1) } else { T(0) })

   |                            ^ 

   | 



error[0m: '()' is not a static member of exposed generic parameter 'T'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_fromBoolVec.cj:12:42:

   | 

12 |     return Vec2(if (v.x) { T(1) } else { T(0) }, if (v.y) { T(1) } else { T(0) })

   |                                          ^ 

   | 



error[0m: '()' is not a static member of exposed generic parameter 'T'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_fromBoolVec.cj:16:34:

   | 

16 |     return Vec2<T, Q>(if (v.x) { T(1) } else { T(0) }, if (v.y) { T(1) } else { T(0) })

   |                                  ^ 

   | 



error[0m: '()' is not a static member of exposed generic parameter 'T'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_fromBoolVec.cj:16:48:

   | 

16 |     return Vec2<T, Q>(if (v.x) { T(1) } else { T(0) }, if (v.y) { T(1) } else { T(0) })

   |                                                ^ 

   | 



112 errors generated, 8 errors printed.

Error: failed to compile package `glm.detail`, return code is 1
Error: please execute 'cjpm.exe build -i' successfully first
Error: cjpm test failed
