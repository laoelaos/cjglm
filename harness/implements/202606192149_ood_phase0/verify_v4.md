# 验证报告（v4）

## 结果
FAILED

## 统计
- 通过：0
- 失败：0（96个编译错误，构建失败，无测试执行）

## 测试执行日志
cjpm : error[0m: invalid binary operator '%' on type 'Generics-T' and 'Generics-T'
所在位置 行:1 字符: 2
+ (cjpm test) 2>&1 | Out-File -FilePath "C:\Develop\Software\cjglm_wp\h ...
+  ~~~~~~~~~
    + CategoryInfo          : NotSpecified: (error[0m: inva...nd 'Generics-T':String) [], RemoteException
    + FullyQualifiedErrorId : NativeCommandError
 

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_vec1.cj:51:71:

   | 

51 |     public operator func %(rhs: Vec1<T, Q>): Vec1<T, Q> { Vec1(this.x % rhs.x) }

   |                                                                       ^ 

   | 

   # note: you may want to implement 'operator func %(right: Generics-T)' for type 'Generics-T'



error[0m: invalid binary operator '%' on type 'Generics-T' and 'Generics-T'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_vec1.cj:62:62:

   | 

62 |     public operator func %(rhs: T): Vec1<T, Q> { Vec1(this.x % rhs) }

   |                                                              ^ 

   | 

   # note: you may want to implement 'operator func %(right: Generics-T)' for type 'Generics-T'



error[0m: invalid number of parameters for operator '+'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_vec1.cj:64:5:

   | 

64 |     public operator func +(): Vec1<T, Q> { this }

   |     ^ 

   | 



error[0m: invalid binary operator '%' on type 'Generics-T' and 'Generics-T'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_vec1.cj:82:71:

   | 

82 |     public operator func %(rhs: Vec2<T, Q>): Vec2<T, Q> { Vec2(this.x % rhs.x, this.x % rhs.y) }

   |                                                                       ^ 

   | 

   # note: you may want to implement 'operator func %(right: Generics-T)' for type 'Generics-T'



error[0m: invalid binary operator '%' on type 'Generics-T' and 'Generics-T'

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_vec1.cj:93:71:

   | 

93 |     public operator func %(rhs: Vec3<T, Q>): Vec3<T, Q> { Vec3(this.x % rhs.x, this.x % rhs.y, this.x % rhs.z) }

   |                                                                       ^ 

   | 

   # note: you may want to implement 'operator func %(right: Generics-T)' for type 'Generics-T'



error[0m: invalid binary operator '%' on type 'Generics-T' and 'Generics-T'

   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_vec1.cj:104:71:

    | 

104 |     public operator func %(rhs: Vec4<T, Q>): Vec4<T, Q> { Vec4(this.x % rhs.x, this.x % rhs.y, this.x % rhs.z, th
is.x % rhs.w) }

    |                                                                       ^ 

    | 

    # note: you may want to implement 'operator func %(right: Generics-T)' for type 'Generics-T'



error[0m: invalid binary operator '<<' on type 'Generics-T' and 'Generics-T'

   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_vec1.cj:112:72:

    | 

112 |     public operator func <<(rhs: Vec1<T, Q>): Vec1<T, Q> { Vec1(this.x << rhs.x) }

    |                                                                        ^^ 

    | 

    # note: you may want to implement 'operator func <<(right: Generics-T)' for type 'Generics-T'



error[0m: invalid binary operator '>>' on type 'Generics-T' and 'Generics-T'

   ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\type_vec1.cj:113:72:

    | 

113 |     public operator func >>(rhs: Vec1<T, Q>): Vec1<T, Q> { Vec1(this.x >> rhs.x) }

    |                                                                        ^^ 

    | 

    # note: you may want to implement 'operator func >>(right: Generics-T)' for type 'Generics-T'



96 errors generated, 8 errors printed.

Error: failed to compile package `glm.detail`, return code is 1
Error: please execute 'cjpm.exe build -i' successfully first
Error: cjpm test failed
