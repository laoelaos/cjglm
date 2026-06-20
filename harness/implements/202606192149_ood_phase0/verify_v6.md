# 验证报告（v6）

## 结果
FAILED

## 统计
- 通过：0
- 失败：0（编译失败，50 errors generated）

## 测试执行日志
error: expected 'const' expression
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\scalar_vec_ops.cj:7:17:
  |
7 |     return Vec1(s + v.x)
  |                 ^^^^^^^ 
  |

error: expected 'const' expression
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\scalar_vec_ops.cj:12:17:
  |
12 |     return Vec2(s + v.x, s + v.y)
  |                 ^^^^^^^ 
  |

error: expected 'const' expression
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\scalar_vec_ops.cj:12:26:
  |
12 |     return Vec2(s + v.x, s + v.y)
  |                          ^^^^^^^ 
  |

error: expected 'const' expression
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\scalar_vec_ops.cj:17:17:
  |
17 |     return Vec3(s + v.x, s + v.y, s + v.z)
  |                 ^^^^^^^ 
  |

error: expected 'const' expression
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\scalar_vec_ops.cj:17:26:
  |
17 |     return Vec3(s + v.x, s + v.y, s + v.z)
  |                          ^^^^^^^ 
  |

error: expected 'const' expression
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\scalar_vec_ops.cj:17:35:
  |
17 |     return Vec3(s + v.x, s + v.y, s + v.z)
  |                                   ^^^^^^^ 
  |

error: expected 'const' expression
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\scalar_vec_ops.cj:22:17:
  |
22 |     return Vec4(s + v.x, s + v.y, s + v.z, s + v.w)
  |                 ^^^^^^^ 
  |

error: expected 'const' expression
 ==> C:\Develop\Software\cjglm_wp\cjglm\src\detail\scalar_vec_ops.cj:22:26:
  |
22 |     return Vec4(s + v.x, s + v.y, s + v.z, s + v.w)
  |                          ^^^^^^^ 
  |

50 errors generated, 8 errors printed.

Error: failed to compile package `glm.detail`, return code is 1
Error: please execute 'cjpm.exe build -i' successfully first
Error: cjpm test failed
