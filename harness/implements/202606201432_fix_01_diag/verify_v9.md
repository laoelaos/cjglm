# 验证报告（v9）

## 结果
PASSED

## 统计
- 通过：372
- 失败：0

## 测试执行日志
cjpm : warning[0m: imported decl 'Vec1' is shadowed, it will be ignored by compiler
所在位置 行:1 字符: 1
+ cjpm test 2>&1 | Out-File -FilePath "C:\Develop\Software\cjglm_wp\har ...
+ ~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (warning[0m: im...red by compiler:String) [], RemoteException
    + FullyQualifiedErrorId : NativeCommandError
 

 ==> C:\Develop\Software\cjglm_wp\cjglm\src\lib.cj:2:28:

  | 

2 | public import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }

  |                            ^^^^ 

  | 

  # note: this warning can be suppressed by setting the compiler option `-Woff package-import`

note[0m: 'Vec1' is declared here

  ==> C:\Develop\Software\cjglm_wp\cjglm\src\fwd.cj:99:13:

   | 

99 | public type Vec1 = detail.Vec1<Float32, PackedHighp>

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

100 | public type Vec2 = detail.Vec2<Float32, PackedHighp>

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

101 | public type Vec3 = detail.Vec3<Float32, PackedHighp>

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

102 | public type Vec4 = detail.Vec4<Float32, PackedHighp>

    |             ^^^^ 

    | 



4 warnings generated, 4 warnings printed.

[?25l[0J7[;r8
[1F7[9999E8[0J7[;r8
[1F7[9999E8--------------------------------------------------------------------------------------------------
TP: [33mglm.detail[0m, time elapsed: 117664200 ns, RESULT:
    TCS: [33mTestCase_testComputeVecAdd1[0m, time elapsed: 1158100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAdd1 (223000 ns)
    TCS: [33mTestCase_testComputeVecSub2[0m, time elapsed: 267300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub2 (30700 ns)
    TCS: [33mTestCase_testComputeVecMul3[0m, time elapsed: 229400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul3 (28100 ns)
    TCS: [33mTestCase_testComputeVecMod1[0m, time elapsed: 276000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMod1 (49300 ns)
    TCS: [33mTestCase_testComputeVecAnd1[0m, time elapsed: 221200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAnd1 (16500 ns)
    TCS: [33mTestCase_testComputeVecOr1[0m, time elapsed: 234700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecOr1 (21900 ns)
    TCS: [33mTestCase_testComputeVecXor1[0m, time elapsed: 257600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecXor1 (20900 ns)
    TCS: [33mTestCase_testComputeVecShiftLeft1[0m, time elapsed: 220900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftLeft1 (19500 ns)
    TCS: [33mTestCase_testComputeVecShiftRight1[0m, time elapsed: 217800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecShiftRight1 (12400 ns)
    TCS: [33mTestCase_testComputeVecEqual1[0m, time elapsed: 223900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual1 (15300 ns)
    TCS: [33mTestCase_testComputeVecNequal4[0m, time elapsed: 247700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal4 (17800 ns)
    TCS: [33mTestCase_testComputeVecBitwiseNot1[0m, time elapsed: 231700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecBitwiseNot1 (20800 ns)
    TCS: [33mTestCase_testComputeVecAdd4[0m, time elapsed: 238800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAdd4 (25500 ns)
    TCS: [33mTestCase_testComputeVecSub1[0m, time elapsed: 237100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub1 (27400 ns)
    TCS: [33mTestCase_testComputeVecSub3[0m, time elapsed: 262300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSub3 (15900 ns)
    TCS: [33mTestCase_testComputeVecMul1[0m, time elapsed: 228300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul1 (16600 ns)
    TCS: [33mTestCase_testComputeVecMul2[0m, time elapsed: 220800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecMul2 (14100 ns)
    TCS: [33mTestCase_testComputeVecDiv1[0m, time elapsed: 292400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecDiv1 (17000 ns)
    TCS: [33mTestCase_testComputeVecDiv2[0m, time elapsed: 252800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecDiv2 (22200 ns)
    TCS: [33mTestCase_testComputeVecEqual2[0m, time elapsed: 231200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual2 (13700 ns)
    TCS: [33mTestCase_testComputeVecEqual4[0m, time elapsed: 1078200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecEqual4 (13000 ns)
    TCS: [33mTestCase_testComputeVecNequal1[0m, time elapsed: 215500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal1 (16700 ns)
    TCS: [33mTestCase_testComputeVecNequal2[0m, time elapsed: 192100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecNequal2 (8700 ns)
    TCS: [33mTestCase_testComputeVecBitwiseNot4[0m, time elapsed: 317200 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecBitwiseNot4 (30100 ns)
    TCS: [33mTestCase_testComputeVecAddFloat32[0m, time elapsed: 274300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecAddFloat32 (30000 ns)
    TCS: [33mTestCase_testComputeVecSubFloat32[0m, time elapsed: 379800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeVecSubFloat32 (29500 ns)
    TCS: [33mTestCase_testComputeEqualInt32Equal[0m, time elapsed: 334100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt32Equal (21800 ns)
    TCS: [33mTestCase_testComputeEqualInt32NotEqual[0m, time elapsed: 279600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt32NotEqual (16100 ns)
    TCS: [33mTestCase_testComputeEqualFloat32Equal[0m, time elapsed: 233400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32Equal (9500 ns)
    TCS: [33mTestCase_testComputeEqualFloat32NotEqual[0m, time elapsed: 221100 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32NotEqual (12300 ns)
    TCS: [33mTestCase_testComputeEqualFloat64Equal[0m, time elapsed: 194500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64Equal (8800 ns)
    TCS: [33mTestCase_testComputeEqualFloat64NotEqual[0m, time elapsed: 212300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64NotEqual (7100 ns)
    TCS: [33mTestCase_testComputeEqualBoolEqual[0m, time elapsed: 187700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualBoolEqual (7700 ns)
    TCS: [33mTestCase_testComputeEqualBoolNotEqual[0m, time elapsed: 232600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualBoolNotEqual (17100 ns)
    TCS: [33mTestCase_testComputeEqualNumericInt32[0m, time elapsed: 203900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericInt32 (11200 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32[0m, time elapsed: 243000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32 (33900 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32Epsilon[0m, time elapsed: 193900 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32Epsilon (10900 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64[0m, time elapsed: 198600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64 (18300 ns)
    TCS: [33mTestCase_testComputeEqualInt64Equal[0m, time elapsed: 191300 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt64Equal (6900 ns)
    TCS: [33mTestCase_testComputeEqualInt64NotEqual[0m, time elapsed: 200000 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualInt64NotEqual (7700 ns)
    TCS: [33mTestCase_testComputeEqualFloat32Nan[0m, time elapsed: 222800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32Nan (23400 ns)
    TCS: [33mTestCase_testComputeEqualFloat64Nan[0m, time elapsed: 254700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64Nan (10800 ns)
    TCS: [33mTestCase_testComputeEqualFloat32SignedZero[0m, time elapsed: 186700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat32SignedZero (9300 ns)
    TCS: [33mTestCase_testComputeEqualFloat64SignedZero[0m, time elapsed: 180500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualFloat64SignedZero (6800 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32NotEqual[0m, time elapsed: 181700 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32NotEqual (11400 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat32BeyondEpsilon[0m, time elapsed: 178800 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat32BeyondEpsilon (15300 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64NotEqual[0m, time elapsed: 194400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64NotEqual (10400 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64Epsilon[0m, time elapsed: 185500 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64Epsilon (9900 ns)
    TCS: [33mTestCase_testComputeEqualNumericFloat64BeyondEpsilon[0m, time elapsed: 174600 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericFloat64BeyondEpsilon (8800 ns)
    TCS: [33mTestCase_testComputeEqualNumericInt64[0m, time elapsed: 179400 ns, RESULT:
    [[32m PASSED [0m] CASE: testComputeEqualNumericInt64 (8600 ns)
    TCS: [33mTestCase_testPackedHighpImplementsQualifier[0m, time elapsed: 178000 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedHighpImplementsQualifier (13400 ns)
    TCS: [33mTestCase_testPackedMediumpImplementsQualifier[0m, time elapsed: 183700 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedMediumpImplementsQualifier (6600 ns)
    TCS: [33mTestCase_testPackedLowpImplementsQualifier[0m, time elapsed: 180500 ns, RESULT:
    [[32m PASSED [0m] CASE: testPackedLowpImplementsQualifier (7300 ns)
    TCS: [33mTestCase_testDefaultpIsPackedHighp[0m, time elapsed: 177700 ns, RESULT:
    [[32m PASSED [0m] CASE: testDefaultpIsPackedHighp (10900 ns)
    TCS: [33mTestCase_testScalarAddVec1[0m, time elapsed: 219000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec1 (23500 ns)
    TCS: [33mTestCase_testScalarAddVec2[0m, time elapsed: 199800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec2 (15400 ns)
    TCS: [33mTestCase_testScalarAddVec3[0m, time elapsed: 200300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec3 (20900 ns)
    TCS: [33mTestCase_testScalarAddVec4[0m, time elapsed: 195400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarAddVec4 (12800 ns)
    TCS: [33mTestCase_testScalarSubVec1[0m, time elapsed: 195500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec1 (15400 ns)
    TCS: [33mTestCase_testScalarMulVec1[0m, time elapsed: 192100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec1 (14800 ns)
    TCS: [33mTestCase_testScalarDivVec1[0m, time elapsed: 211000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec1 (15900 ns)
    TCS: [33mTestCase_testScalarModVec1[0m, time elapsed: 211800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1 (21200 ns)
    TCS: [33mTestCase_testScalarMulVec2[0m, time elapsed: 193200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec2 (11500 ns)
    TCS: [33mTestCase_testScalarSubVec2[0m, time elapsed: 202000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec2 (12000 ns)
    TCS: [33mTestCase_testScalarSubVec3[0m, time elapsed: 210100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec3 (14500 ns)
    TCS: [33mTestCase_testScalarSubVec4[0m, time elapsed: 188900 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarSubVec4 (7800 ns)
    TCS: [33mTestCase_testScalarMulVec3[0m, time elapsed: 189400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec3 (7200 ns)
    TCS: [33mTestCase_testScalarMulVec4[0m, time elapsed: 183400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarMulVec4 (15000 ns)
    TCS: [33mTestCase_testScalarDivVec2[0m, time elapsed: 220400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec2 (8000 ns)
    TCS: [33mTestCase_testScalarDivVec3[0m, time elapsed: 201300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec3 (13400 ns)
    TCS: [33mTestCase_testScalarDivVec4[0m, time elapsed: 201700 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarDivVec4 (8000 ns)
    TCS: [33mTestCase_testScalarModVec2[0m, time elapsed: 184500 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2 (7100 ns)
    TCS: [33mTestCase_testScalarModVec3[0m, time elapsed: 200300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3 (17300 ns)
    TCS: [33mTestCase_testScalarModVec4[0m, time elapsed: 190000 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4 (12200 ns)
    TCS: [33mTestCase_testScalarModVec1Float32[0m, time elapsed: 195600 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float32 (18300 ns)
    TCS: [33mTestCase_testScalarModVec2Float32[0m, time elapsed: 196400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float32 (19800 ns)
    TCS: [33mTestCase_testScalarModVec3Float32[0m, time elapsed: 234300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float32 (7700 ns)
    TCS: [33mTestCase_testScalarModVec4Float32[0m, time elapsed: 200800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float32 (11100 ns)
    TCS: [33mTestCase_testScalarModVec1Float64[0m, time elapsed: 194800 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float64 (18000 ns)
    TCS: [33mTestCase_testScalarModVec2Float64[0m, time elapsed: 383100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float64 (17400 ns)
    TCS: [33mTestCase_testScalarModVec3Float64[0m, time elapsed: 311300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float64 (13000 ns)
    TCS: [33mTestCase_testScalarModVec4Float64[0m, time elapsed: 411400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float64 (21200 ns)
    TCS: [33mTestCase_testScalarModVec1Float16[0m, time elapsed: 264100 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec1Float16 (31000 ns)
    TCS: [33mTestCase_testScalarModVec2Float16[0m, time elapsed: 230300 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec2Float16 (19100 ns)
    TCS: [33mTestCase_testScalarModVec3Float16[0m, time elapsed: 230400 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec3Float16 (8900 ns)
    TCS: [33mTestCase_testScalarModVec4Float16[0m, time elapsed: 201200 ns, RESULT:
    [[32m PASSED [0m] CASE: testScalarModVec4Float16 (8500 ns)
    TCS: [33mTestCase_testVersionMajor[0m, time elapsed: 205800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionMajor (12700 ns)
    TCS: [33mTestCase_testVersionMinor[0m, time elapsed: 203900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionMinor (8600 ns)
    TCS: [33mTestCase_testVersionPatch[0m, time elapsed: 198300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionPatch (6600 ns)
    TCS: [33mTestCase_testVersionEncoded[0m, time elapsed: 195200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionEncoded (18600 ns)
    TCS: [33mTestCase_testConfigSimd[0m, time elapsed: 199000 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigSimd (12500 ns)
    TCS: [33mTestCase_testConfigAlignedGentypes[0m, time elapsed: 275100 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigAlignedGentypes (14800 ns)
    TCS: [33mTestCase_testConfigClipControl[0m, time elapsed: 181400 ns, RESULT:
    [[32m PASSED [0m] CASE: testConfigClipControl (7600 ns)
    TCS: [33mTestCase_testConstNegationSimd[0m, time elapsed: 189000 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationSimd (10500 ns)
    TCS: [33mTestCase_testConstNegationAligned[0m, time elapsed: 181800 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationAligned (13400 ns)
    TCS: [33mTestCase_testConstNegationClip[0m, time elapsed: 178400 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstNegationClip (6000 ns)
    TCS: [33mTestCase_testConstInt64Usage[0m, time elapsed: 177800 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstInt64Usage (9800 ns)
    TCS: [33mTestCase_testConstBoolUsage[0m, time elapsed: 166600 ns, RESULT:
    [[32m PASSED [0m] CASE: testConstBoolUsage (6600 ns)
    TCS: [33mTestCase_testVersionEncodingConsistency[0m, time elapsed: 168800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVersionEncodingConsistency (7000 ns)
    TCS: [33mTestCase_testAssertPasses[0m, time elapsed: 190300 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertPasses (19000 ns)
    TCS: [33mTestCase_testAssertFails[0m, time elapsed: 326600 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertFails (137900 ns)
    TCS: [33mTestCase_testAssertWithCustomMessage[0m, time elapsed: 255400 ns, RESULT:
    [[32m PASSED [0m] CASE: testAssertWithCustomMessage (52600 ns)
    TCS: [33mTestCase_testNumericLimitsFloat32Epsilon[0m, time elapsed: 185200 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsFloat32Epsilon (10600 ns)
    TCS: [33mTestCase_testNumericLimitsFloat64Epsilon[0m, time elapsed: 178600 ns, RESULT:
    [[32m PASSED [0m] CASE: testNumericLimitsFloat64Epsilon (8200 ns)
    TCS: [33mTestCase_testIsIec559OfFloat32[0m, time elapsed: 181500 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfFloat32 (9000 ns)
    TCS: [33mTestCase_testIsIec559OfFloat64[0m, time elapsed: 179500 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfFloat64 (11900 ns)
    TCS: [33mTestCase_testIsIec559OfInt64[0m, time elapsed: 185800 ns, RESULT:
    [[32m PASSED [0m] CASE: testIsIec559OfInt64 (8800 ns)
    TCS: [33mTestCase_testEpsilonOfFloat32[0m, time elapsed: 201800 ns, RESULT:
    [[32m PASSED [0m] CASE: testEpsilonOfFloat32 (13600 ns)
    TCS: [33mTestCase_testEpsilonOfFloat64[0m, time elapsed: 171900 ns, RESULT:
    [[32m PASSED [0m] CASE: testEpsilonOfFloat64 (9000 ns)
    TCS: [33mTestCase_testCastVec1ToVec1IntToFloat[0m, time elapsed: 189200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec1ToVec1IntToFloat (15100 ns)
    TCS: [33mTestCase_testCastVec2ToVec1TakesOnlyX[0m, time elapsed: 188700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2ToVec1TakesOnlyX (12600 ns)
    TCS: [33mTestCase_testCastVec3ToVec1TakesOnlyX[0m, time elapsed: 201400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3ToVec1TakesOnlyX (14900 ns)
    TCS: [33mTestCase_testCastVec4ToVec1TakesOnlyX[0m, time elapsed: 178700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4ToVec1TakesOnlyX (7400 ns)
    TCS: [33mTestCase_testCastSameTypeIdentity[0m, time elapsed: 175800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastSameTypeIdentity (6600 ns)
    TCS: [33mTestCase_testCastInt32ToInt64[0m, time elapsed: 207100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastInt32ToInt64 (10000 ns)
    TCS: [33mTestCase_testCastFloatToIntTruncation[0m, time elapsed: 202900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastFloatToIntTruncation (6900 ns)
    TCS: [33mTestCase_testCastCrossQualifierPackedHighpToDefaultp[0m, time elapsed: 180200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastCrossQualifierPackedHighpToDefaultp (13900 ns)
    TCS: [33mTestCase_testCastCrossQualifierDefaultpToPackedHighp[0m, time elapsed: 177100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastCrossQualifierDefaultpToPackedHighp (6800 ns)
    TCS: [33mTestCase_testCastVec2CrossQualifierCrossType[0m, time elapsed: 190400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2CrossQualifierCrossType (8100 ns)
    TCS: [33mTestCase_testCastVec3CrossQualifier[0m, time elapsed: 171200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3CrossQualifier (7700 ns)
    TCS: [33mTestCase_testCastVec4CrossQualifier[0m, time elapsed: 183600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4CrossQualifier (7800 ns)
    TCS: [33mTestCase_testCastVec1DoesNotModifySource[0m, time elapsed: 187200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec1DoesNotModifySource (6500 ns)
    TCS: [33mTestCase_testCastVec2Vec1ToVec2IntToFloat[0m, time elapsed: 217200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec1ToVec2IntToFloat (12600 ns)
    TCS: [33mTestCase_testCastVec2Vec2ToVec2Identity[0m, time elapsed: 190500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec2ToVec2Identity (13900 ns)
    TCS: [33mTestCase_testCastVec2Vec3ToVec2TakesOnlyXY[0m, time elapsed: 185400 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec3ToVec2TakesOnlyXY (8300 ns)
    TCS: [33mTestCase_testCastVec2Vec4ToVec2TakesOnlyXY[0m, time elapsed: 182100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec4ToVec2TakesOnlyXY (7300 ns)
    TCS: [33mTestCase_testCastVec2SameTypeIdentity[0m, time elapsed: 213500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2SameTypeIdentity (9500 ns)
    TCS: [33mTestCase_testCastVec2Int32ToInt64[0m, time elapsed: 183200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Int32ToInt64 (13700 ns)
    TCS: [33mTestCase_testCastVec2FloatToIntTruncation[0m, time elapsed: 184000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2FloatToIntTruncation (7900 ns)
    TCS: [33mTestCase_testCastVec2CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 202800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2CrossQualifierPackedHighpToDefaultp (7600 ns)
    TCS: [33mTestCase_testCastVec2DoesNotModifySource[0m, time elapsed: 180700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2DoesNotModifySource (6700 ns)
    TCS: [33mTestCase_testCastVec2Vec1ToVec2SameValueBothComponents[0m, time elapsed: 179700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec2Vec1ToVec2SameValueBothComponents (6900 ns)
    TCS: [33mTestCase_testCastVec3Vec1ToVec3IntToFloat[0m, time elapsed: 195000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec1ToVec3IntToFloat (25800 ns)
    TCS: [33mTestCase_testCastVec3Vec2ToVec3ExtendY[0m, time elapsed: 194900 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec2ToVec3ExtendY (11900 ns)
    TCS: [33mTestCase_testCastVec3Vec3ToVec3Identity[0m, time elapsed: 191700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec3ToVec3Identity (7300 ns)
    TCS: [33mTestCase_testCastVec3Vec4ToVec3TakesOnlyXYZ[0m, time elapsed: 342700 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec4ToVec3TakesOnlyXYZ (21000 ns)
    TCS: [33mTestCase_testCastVec3SameTypeIdentity[0m, time elapsed: 312200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3SameTypeIdentity (15400 ns)
    TCS: [33mTestCase_testCastVec3Int32ToInt64[0m, time elapsed: 383000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Int32ToInt64 (33700 ns)
    TCS: [33mTestCase_testCastVec3FloatToIntTruncation[0m, time elapsed: 322500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3FloatToIntTruncation (18400 ns)
    TCS: [33mTestCase_testCastVec3CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 286200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3CrossQualifierPackedHighpToDefaultp (15800 ns)
    TCS: [33mTestCase_testCastVec3DoesNotModifySource[0m, time elapsed: 312800 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3DoesNotModifySource (14200 ns)
    TCS: [33mTestCase_testCastVec3Vec1ToVec3SameValueAllComponents[0m, time elapsed: 217100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec3Vec1ToVec3SameValueAllComponents (11400 ns)
    TCS: [33mTestCase_testCastVec4Vec1ToVec4IntToFloat[0m, time elapsed: 209100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec1ToVec4IntToFloat (21400 ns)
    TCS: [33mTestCase_testCastVec4Vec2ToVec4ExtendY[0m, time elapsed: 219200 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec2ToVec4ExtendY (25600 ns)
    TCS: [33mTestCase_testCastVec4Vec3ToVec4ExtendZ[0m, time elapsed: 204300 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec3ToVec4ExtendZ (15300 ns)
    TCS: [33mTestCase_testCastVec4Vec4ToVec4Identity[0m, time elapsed: 194500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec4ToVec4Identity (14500 ns)
    TCS: [33mTestCase_testCastVec4SameTypeIdentity[0m, time elapsed: 198100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4SameTypeIdentity (8500 ns)
    TCS: [33mTestCase_testCastVec4Int32ToInt64[0m, time elapsed: 182500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Int32ToInt64 (9000 ns)
    TCS: [33mTestCase_testCastVec4FloatToIntTruncation[0m, time elapsed: 184000 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4FloatToIntTruncation (8200 ns)
    TCS: [33mTestCase_testCastVec4CrossQualifierPackedHighpToDefaultp[0m, time elapsed: 176500 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4CrossQualifierPackedHighpToDefaultp (7400 ns)
    TCS: [33mTestCase_testCastVec4DoesNotModifySource[0m, time elapsed: 166100 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4DoesNotModifySource (7900 ns)
    TCS: [33mTestCase_testCastVec4Vec1ToVec4SameValueAllComponents[0m, time elapsed: 268600 ns, RESULT:
    [[32m PASSED [0m] CASE: testCastVec4Vec1ToVec4SameValueAllComponents (8500 ns)
    TCS: [33mTestCase_testFromBoolVec1[0m, time elapsed: 179500 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec1 (7200 ns)
    TCS: [33mTestCase_testFromBoolVec1False[0m, time elapsed: 175300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec1False (15300 ns)
    TCS: [33mTestCase_testFromBoolVec2[0m, time elapsed: 168000 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec2 (6700 ns)
    TCS: [33mTestCase_testFromBoolVec3[0m, time elapsed: 179300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec3 (11000 ns)
    TCS: [33mTestCase_testFromBoolVec4[0m, time elapsed: 164800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec4 (6700 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec1[0m, time elapsed: 174300 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec1 (8600 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec2[0m, time elapsed: 176900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec2 (6500 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec3[0m, time elapsed: 175900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec3 (12100 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec4[0m, time elapsed: 173400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec4 (6600 ns)
    TCS: [33mTestCase_testFromBoolVec3AllFalse[0m, time elapsed: 174700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec3AllFalse (6800 ns)
    TCS: [33mTestCase_testFromBoolVec4AllFalse[0m, time elapsed: 178400 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVec4AllFalse (6200 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec3AllFalse[0m, time elapsed: 186200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec3AllFalse (6400 ns)
    TCS: [33mTestCase_testFromBoolVecQ2Vec4AllFalse[0m, time elapsed: 180900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFromBoolVecQ2Vec4AllFalse (6100 ns)
    TCS: [33mTestCase_testVec1ConstInit[0m, time elapsed: 201800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ConstInit (6000 ns)
    TCS: [33mTestCase_testVec1Length[0m, time elapsed: 179600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Length (6200 ns)
    TCS: [33mTestCase_testVec1IndexAccess[0m, time elapsed: 166100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1IndexAccess (6600 ns)
    TCS: [33mTestCase_testVec1IndexMutate[0m, time elapsed: 216900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1IndexMutate (12500 ns)
    TCS: [33mTestCase_testVec1ComponentAt[0m, time elapsed: 177000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ComponentAt (6200 ns)
    TCS: [33mTestCase_testVec1Add[0m, time elapsed: 189100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Add (22500 ns)
    TCS: [33mTestCase_testVec1Sub[0m, time elapsed: 185000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Sub (9500 ns)
    TCS: [33mTestCase_testVec1Mul[0m, time elapsed: 211200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Mul (12000 ns)
    TCS: [33mTestCase_testVec1Div[0m, time elapsed: 176000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Div (11100 ns)
    TCS: [33mTestCase_testVec1Mod[0m, time elapsed: 246500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Mod (10100 ns)
    TCS: [33mTestCase_testVec1ScalarAdd[0m, time elapsed: 210300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarAdd (24000 ns)
    TCS: [33mTestCase_testVec1Negate[0m, time elapsed: 202900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Negate (9000 ns)
    TCS: [33mTestCase_testVec1AddNamed[0m, time elapsed: 182200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1AddNamed (7300 ns)
    TCS: [33mTestCase_testVec1SubNamed[0m, time elapsed: 221700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1SubNamed (14500 ns)
    TCS: [33mTestCase_testVec1MulNamed[0m, time elapsed: 185100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1MulNamed (9000 ns)
    TCS: [33mTestCase_testVec1Equal[0m, time elapsed: 206500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Equal (17200 ns)
    TCS: [33mTestCase_testVec1NotEqual[0m, time elapsed: 176700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1NotEqual (7000 ns)
    TCS: [33mTestCase_testVec1EqualExact[0m, time elapsed: 196300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1EqualExact (10600 ns)
    TCS: [33mTestCase_testVec1BitwiseAnd[0m, time elapsed: 195300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BitwiseAnd (15300 ns)
    TCS: [33mTestCase_testVec1BitwiseOr[0m, time elapsed: 188000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BitwiseOr (9500 ns)
    TCS: [33mTestCase_testVec1BitwiseXor[0m, time elapsed: 202600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BitwiseXor (12900 ns)
    TCS: [33mTestCase_testVec1ShiftLeft[0m, time elapsed: 197100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ShiftLeft (19600 ns)
    TCS: [33mTestCase_testVec1ShiftRight[0m, time elapsed: 194800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ShiftRight (11400 ns)
    TCS: [33mTestCase_testVec1BitwiseNot[0m, time elapsed: 192900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BitwiseNot (6500 ns)
    TCS: [33mTestCase_testVec1BoolLogicalAnd[0m, time elapsed: 192800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BoolLogicalAnd (7400 ns)
    TCS: [33mTestCase_testVec1BoolLogicalOr[0m, time elapsed: 238200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BoolLogicalOr (8700 ns)
    TCS: [33mTestCase_testVec1IndexOutOfBoundsAccess[0m, time elapsed: 420000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1IndexOutOfBoundsAccess (91200 ns)
    TCS: [33mTestCase_testVec1ShiftVec[0m, time elapsed: 396300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ShiftVec (45500 ns)
    TCS: [33mTestCase_testVec1ScalarSub[0m, time elapsed: 364800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarSub (18400 ns)
    TCS: [33mTestCase_testVec1ScalarMul[0m, time elapsed: 315000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarMul (14900 ns)
    TCS: [33mTestCase_testVec1ScalarDiv[0m, time elapsed: 325500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarDiv (20000 ns)
    TCS: [33mTestCase_testVec1ScalarMod[0m, time elapsed: 302100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarMod (15100 ns)
    TCS: [33mTestCase_testVec1DivNamed[0m, time elapsed: 318300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1DivNamed (29800 ns)
    TCS: [33mTestCase_testVec1ModNamed[0m, time elapsed: 317600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ModNamed (14600 ns)
    TCS: [33mTestCase_testVec1ScalarBitwiseAnd[0m, time elapsed: 305800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarBitwiseAnd (27300 ns)
    TCS: [33mTestCase_testVec1ScalarBitwiseOr[0m, time elapsed: 266300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarBitwiseOr (12500 ns)
    TCS: [33mTestCase_testVec1ScalarBitwiseXor[0m, time elapsed: 278400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ScalarBitwiseXor (12100 ns)
    TCS: [33mTestCase_testVec1ShiftRightVec[0m, time elapsed: 320300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1ShiftRightVec (20100 ns)
    TCS: [33mTestCase_testVec1EqualEpsilon[0m, time elapsed: 245800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1EqualEpsilon (17500 ns)
    TCS: [33mTestCase_testVec1BroadcastAddVec2[0m, time elapsed: 194400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastAddVec2 (16100 ns)
    TCS: [33mTestCase_testVec1BroadcastBitAndVec2[0m, time elapsed: 199200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastBitAndVec2 (17500 ns)
    TCS: [33mTestCase_testVec1BroadcastAddVec3[0m, time elapsed: 179200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastAddVec3 (12400 ns)
    TCS: [33mTestCase_testVec1BroadcastAddVec4[0m, time elapsed: 205100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastAddVec4 (15600 ns)
    TCS: [33mTestCase_testVec1BroadcastBitOrVec2[0m, time elapsed: 180400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastBitOrVec2 (16000 ns)
    TCS: [33mTestCase_testVec1BroadcastBitXorVec2[0m, time elapsed: 208400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastBitXorVec2 (9500 ns)
    TCS: [33mTestCase_testVec1BroadcastShiftLeftVec2[0m, time elapsed: 184000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastShiftLeftVec2 (7300 ns)
    TCS: [33mTestCase_testVec1BroadcastShiftRightVec2[0m, time elapsed: 166100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastShiftRightVec2 (7500 ns)
    TCS: [33mTestCase_testVec1BroadcastBitAndVec3[0m, time elapsed: 194900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastBitAndVec3 (14500 ns)
    TCS: [33mTestCase_testVec1BroadcastBitAndVec4[0m, time elapsed: 208500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastBitAndVec4 (27300 ns)
    TCS: [33mTestCase_testVec1BroadcastModVec2[0m, time elapsed: 181300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastModVec2 (16800 ns)
    TCS: [33mTestCase_testVec1BroadcastModVec3[0m, time elapsed: 308600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastModVec3 (11400 ns)
    TCS: [33mTestCase_testVec1BroadcastModVec4[0m, time elapsed: 311100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1BroadcastModVec4 (32000 ns)
    TCS: [33mTestCase_testVec1Increment[0m, time elapsed: 270800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Increment (30500 ns)
    TCS: [33mTestCase_testVec1Decrement[0m, time elapsed: 271900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec1Decrement (23500 ns)
    TCS: [33mTestCase_testVec2ScalarInit[0m, time elapsed: 317600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarInit (36700 ns)
    TCS: [33mTestCase_testVec2ConstInit[0m, time elapsed: 285900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ConstInit (23600 ns)
    TCS: [33mTestCase_testVec2Length[0m, time elapsed: 280000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Length (22600 ns)
    TCS: [33mTestCase_testVec2Add[0m, time elapsed: 410500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Add (18800 ns)
    TCS: [33mTestCase_testVec2Sub[0m, time elapsed: 225400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Sub (15600 ns)
    TCS: [33mTestCase_testVec2Mul[0m, time elapsed: 233000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Mul (17700 ns)
    TCS: [33mTestCase_testVec2ScalarAdd[0m, time elapsed: 274500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarAdd (18300 ns)
    TCS: [33mTestCase_testVec2Negate[0m, time elapsed: 238500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Negate (12700 ns)
    TCS: [33mTestCase_testVec2IndexAccess[0m, time elapsed: 245800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2IndexAccess (17800 ns)
    TCS: [33mTestCase_testVec2IndexMutate[0m, time elapsed: 200700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2IndexMutate (7300 ns)
    TCS: [33mTestCase_testVec2ComponentAt[0m, time elapsed: 194500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ComponentAt (7500 ns)
    TCS: [33mTestCase_testVec2Equal[0m, time elapsed: 227000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Equal (18200 ns)
    TCS: [33mTestCase_testVec2NotEqual[0m, time elapsed: 201400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2NotEqual (11100 ns)
    TCS: [33mTestCase_testVec2EqualExact[0m, time elapsed: 179800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2EqualExact (12300 ns)
    TCS: [33mTestCase_testVec2BitwiseAnd[0m, time elapsed: 198500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseAnd (16400 ns)
    TCS: [33mTestCase_testVec2BitwiseNot[0m, time elapsed: 176800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseNot (6100 ns)
    TCS: [33mTestCase_testVec2FromVec1[0m, time elapsed: 166600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2FromVec1 (6700 ns)
    TCS: [33mTestCase_testVec2ShiftLeft[0m, time elapsed: 279000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeft (20000 ns)
    TCS: [33mTestCase_testVec2BoolLogicalAnd[0m, time elapsed: 373000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BoolLogicalAnd (26000 ns)
    TCS: [33mTestCase_testVec2Vec1ArithBroadcast[0m, time elapsed: 305800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Vec1ArithBroadcast (26100 ns)
    TCS: [33mTestCase_testVec2Vec1BitBroadcast[0m, time elapsed: 394900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Vec1BitBroadcast (31600 ns)
    TCS: [33mTestCase_testVec2ShiftLeftVec1[0m, time elapsed: 303600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeftVec1 (20100 ns)
    TCS: [33mTestCase_testVec2Div[0m, time elapsed: 285700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Div (19500 ns)
    TCS: [33mTestCase_testVec2Mod[0m, time elapsed: 313100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Mod (17600 ns)
    TCS: [33mTestCase_testVec2ScalarSub[0m, time elapsed: 418500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarSub (28600 ns)
    TCS: [33mTestCase_testVec2ScalarMul[0m, time elapsed: 206800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarMul (22300 ns)
    TCS: [33mTestCase_testVec2ScalarDiv[0m, time elapsed: 182200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarDiv (10200 ns)
    TCS: [33mTestCase_testVec2ScalarMod[0m, time elapsed: 180700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarMod (7400 ns)
    TCS: [33mTestCase_testVec2BoolLogicalOr[0m, time elapsed: 173700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BoolLogicalOr (8500 ns)
    TCS: [33mTestCase_testVec2EqualEpsilon[0m, time elapsed: 184600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2EqualEpsilon (14100 ns)
    TCS: [33mTestCase_testVec2DivNamed[0m, time elapsed: 229500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2DivNamed (14000 ns)
    TCS: [33mTestCase_testVec2ModNamed[0m, time elapsed: 195000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ModNamed (7300 ns)
    TCS: [33mTestCase_testVec2BitwiseOr[0m, time elapsed: 186200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseOr (12500 ns)
    TCS: [33mTestCase_testVec2BitwiseXor[0m, time elapsed: 187100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2BitwiseXor (9400 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseAnd[0m, time elapsed: 169200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseAnd (6500 ns)
    TCS: [33mTestCase_testVec2ShiftRight[0m, time elapsed: 183400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRight (10300 ns)
    TCS: [33mTestCase_testVec2ShiftRightVec1[0m, time elapsed: 197600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRightVec1 (18000 ns)
    TCS: [33mTestCase_testVec2AddNamed[0m, time elapsed: 167700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2AddNamed (6500 ns)
    TCS: [33mTestCase_testVec2SubNamed[0m, time elapsed: 179600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2SubNamed (6600 ns)
    TCS: [33mTestCase_testVec2MulNamed[0m, time elapsed: 177200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2MulNamed (6500 ns)
    TCS: [33mTestCase_testVec2ShiftLeftVec[0m, time elapsed: 168300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftLeftVec (6200 ns)
    TCS: [33mTestCase_testVec2ShiftRightVec[0m, time elapsed: 182500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ShiftRightVec (9100 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseOr[0m, time elapsed: 200100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseOr (6600 ns)
    TCS: [33mTestCase_testVec2ScalarBitwiseXor[0m, time elapsed: 173800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2ScalarBitwiseXor (9100 ns)
    TCS: [33mTestCase_testVec2Increment[0m, time elapsed: 197000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Increment (17200 ns)
    TCS: [33mTestCase_testVec2Decrement[0m, time elapsed: 187900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec2Decrement (11400 ns)
    TCS: [33mTestCase_testVec3ScalarInit[0m, time elapsed: 188700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarInit (13100 ns)
    TCS: [33mTestCase_testVec3ConstInit[0m, time elapsed: 208300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ConstInit (11500 ns)
    TCS: [33mTestCase_testVec3Length[0m, time elapsed: 176300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Length (5500 ns)
    TCS: [33mTestCase_testVec3Add[0m, time elapsed: 191800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Add (14600 ns)
    TCS: [33mTestCase_testVec3ScalarMul[0m, time elapsed: 189300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarMul (10400 ns)
    TCS: [33mTestCase_testVec3Negate[0m, time elapsed: 187600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Negate (10800 ns)
    TCS: [33mTestCase_testVec3IndexAccess[0m, time elapsed: 194900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3IndexAccess (12800 ns)
    TCS: [33mTestCase_testVec3IndexMutate[0m, time elapsed: 190400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3IndexMutate (5500 ns)
    TCS: [33mTestCase_testVec3ComponentAt[0m, time elapsed: 176000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ComponentAt (5900 ns)
    TCS: [33mTestCase_testVec3Equal[0m, time elapsed: 176600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Equal (17400 ns)
    TCS: [33mTestCase_testVec3NotEqual[0m, time elapsed: 182300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3NotEqual (10000 ns)
    TCS: [33mTestCase_testVec3EqualExact[0m, time elapsed: 177100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3EqualExact (8200 ns)
    TCS: [33mTestCase_testVec3BitwiseAnd[0m, time elapsed: 171600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseAnd (12500 ns)
    TCS: [33mTestCase_testVec3BitwiseNot[0m, time elapsed: 180800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseNot (5800 ns)
    TCS: [33mTestCase_testVec3Vec1ArithBroadcast[0m, time elapsed: 183100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1ArithBroadcast (14800 ns)
    TCS: [33mTestCase_testVec3ShiftLeft[0m, time elapsed: 189000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeft (13600 ns)
    TCS: [33mTestCase_testVec3BoolLogicalAnd[0m, time elapsed: 182700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BoolLogicalAnd (11300 ns)
    TCS: [33mTestCase_testVec3Sub[0m, time elapsed: 195500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Sub (15000 ns)
    TCS: [33mTestCase_testVec3Div[0m, time elapsed: 167100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Div (9400 ns)
    TCS: [33mTestCase_testVec3Mod[0m, time elapsed: 175300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Mod (10600 ns)
    TCS: [33mTestCase_testVec3ScalarSub[0m, time elapsed: 179900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarSub (9000 ns)
    TCS: [33mTestCase_testVec3ScalarDiv[0m, time elapsed: 169200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarDiv (11900 ns)
    TCS: [33mTestCase_testVec3ScalarMod[0m, time elapsed: 190300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarMod (8100 ns)
    TCS: [33mTestCase_testVec3BoolLogicalOr[0m, time elapsed: 181600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BoolLogicalOr (11700 ns)
    TCS: [33mTestCase_testVec3EqualEpsilon[0m, time elapsed: 178700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3EqualEpsilon (14800 ns)
    TCS: [33mTestCase_testVec3AddNamed[0m, time elapsed: 191500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3AddNamed (9600 ns)
    TCS: [33mTestCase_testVec3MulNamed[0m, time elapsed: 183600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3MulNamed (6300 ns)
    TCS: [33mTestCase_testVec3DivNamed[0m, time elapsed: 197200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3DivNamed (5900 ns)
    TCS: [33mTestCase_testVec3ModNamed[0m, time elapsed: 310100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ModNamed (35200 ns)
    TCS: [33mTestCase_testVec3BitwiseOr[0m, time elapsed: 267800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseOr (32300 ns)
    TCS: [33mTestCase_testVec3BitwiseXor[0m, time elapsed: 247600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3BitwiseXor (24900 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseAnd[0m, time elapsed: 228600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseAnd (22700 ns)
    TCS: [33mTestCase_testVec3ShiftRight[0m, time elapsed: 391600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRight (25200 ns)
    TCS: [33mTestCase_testVec3Vec1BitBroadcast[0m, time elapsed: 356800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitBroadcast (26800 ns)
    TCS: [33mTestCase_testVec3ShiftRightVec1[0m, time elapsed: 372500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRightVec1 (41800 ns)
    TCS: [33mTestCase_testVec3FromVec1[0m, time elapsed: 340200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3FromVec1 (16900 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseOr[0m, time elapsed: 338500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseOr (26800 ns)
    TCS: [33mTestCase_testVec3ScalarBitwiseXor[0m, time elapsed: 256900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ScalarBitwiseXor (20100 ns)
    TCS: [33mTestCase_testVec3Vec1BitOrBroadcast[0m, time elapsed: 328500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitOrBroadcast (23000 ns)
    TCS: [33mTestCase_testVec3Vec1BitXorBroadcast[0m, time elapsed: 218000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Vec1BitXorBroadcast (22500 ns)
    TCS: [33mTestCase_testVec3ShiftLeftVec1[0m, time elapsed: 195100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeftVec1 (11500 ns)
    TCS: [33mTestCase_testVec3ShiftLeftVec[0m, time elapsed: 203700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftLeftVec (10100 ns)
    TCS: [33mTestCase_testVec3ShiftRightVec[0m, time elapsed: 189600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3ShiftRightVec (16500 ns)
    TCS: [33mTestCase_testVec3Increment[0m, time elapsed: 180900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Increment (14400 ns)
    TCS: [33mTestCase_testVec3Decrement[0m, time elapsed: 180300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec3Decrement (15800 ns)
    TCS: [33mTestCase_testVec4ScalarInit[0m, time elapsed: 175900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarInit (14300 ns)
    TCS: [33mTestCase_testVec4ConstInit[0m, time elapsed: 174800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ConstInit (8800 ns)
    TCS: [33mTestCase_testVec4Length[0m, time elapsed: 204300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Length (7400 ns)
    TCS: [33mTestCase_testVec4Add[0m, time elapsed: 183100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Add (17100 ns)
    TCS: [33mTestCase_testVec4ScalarMul[0m, time elapsed: 191600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarMul (16200 ns)
    TCS: [33mTestCase_testVec4Negate[0m, time elapsed: 183900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Negate (14200 ns)
    TCS: [33mTestCase_testVec4IndexAccess[0m, time elapsed: 165600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4IndexAccess (6500 ns)
    TCS: [33mTestCase_testVec4IndexMutate[0m, time elapsed: 198700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4IndexMutate (6700 ns)
    TCS: [33mTestCase_testVec4ComponentAt[0m, time elapsed: 188800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ComponentAt (7000 ns)
    TCS: [33mTestCase_testVec4Equal[0m, time elapsed: 183100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Equal (18400 ns)
    TCS: [33mTestCase_testVec4NotEqual[0m, time elapsed: 191200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4NotEqual (12000 ns)
    TCS: [33mTestCase_testVec4EqualExact[0m, time elapsed: 189100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4EqualExact (17000 ns)
    TCS: [33mTestCase_testVec4BitwiseAnd[0m, time elapsed: 176000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseAnd (11500 ns)
    TCS: [33mTestCase_testVec4BitwiseNot[0m, time elapsed: 174400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseNot (7000 ns)
    TCS: [33mTestCase_testVec4Vec1ArithBroadcast[0m, time elapsed: 189400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1ArithBroadcast (16600 ns)
    TCS: [33mTestCase_testVec4ShiftLeft[0m, time elapsed: 214200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeft (14300 ns)
    TCS: [33mTestCase_testVec4BoolLogicalAnd[0m, time elapsed: 185900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BoolLogicalAnd (15200 ns)
    TCS: [33mTestCase_testVec4Sub[0m, time elapsed: 188200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Sub (14200 ns)
    TCS: [33mTestCase_testVec4Div[0m, time elapsed: 180700 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Div (16200 ns)
    TCS: [33mTestCase_testVec4Mod[0m, time elapsed: 182200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Mod (14900 ns)
    TCS: [33mTestCase_testVec4ScalarSub[0m, time elapsed: 211800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarSub (13600 ns)
    TCS: [33mTestCase_testVec4ScalarDiv[0m, time elapsed: 175400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarDiv (11900 ns)
    TCS: [33mTestCase_testVec4ScalarMod[0m, time elapsed: 188600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarMod (15500 ns)
    TCS: [33mTestCase_testVec4BoolLogicalOr[0m, time elapsed: 191900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BoolLogicalOr (6800 ns)
    TCS: [33mTestCase_testVec4EqualEpsilon[0m, time elapsed: 181500 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4EqualEpsilon (17200 ns)
    TCS: [33mTestCase_testVec4AddNamed[0m, time elapsed: 216900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4AddNamed (14400 ns)
    TCS: [33mTestCase_testVec4MulNamed[0m, time elapsed: 182600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4MulNamed (6800 ns)
    TCS: [33mTestCase_testVec4DivNamed[0m, time elapsed: 169600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4DivNamed (10200 ns)
    TCS: [33mTestCase_testVec4ModNamed[0m, time elapsed: 185800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ModNamed (12600 ns)
    TCS: [33mTestCase_testVec4BitwiseOr[0m, time elapsed: 234200 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseOr (14300 ns)
    TCS: [33mTestCase_testVec4BitwiseXor[0m, time elapsed: 226600 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4BitwiseXor (15600 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseAnd[0m, time elapsed: 235900 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseAnd (14500 ns)
    TCS: [33mTestCase_testVec4ShiftRight[0m, time elapsed: 217800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRight (22800 ns)
    TCS: [33mTestCase_testVec4Vec1BitBroadcast[0m, time elapsed: 223000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitBroadcast (24100 ns)
    TCS: [33mTestCase_testVec4ShiftRightVec1[0m, time elapsed: 197300 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRightVec1 (16900 ns)
    TCS: [33mTestCase_testVec4FromVec1[0m, time elapsed: 169000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4FromVec1 (7300 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseOr[0m, time elapsed: 179800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseOr (15300 ns)
    TCS: [33mTestCase_testVec4ScalarBitwiseXor[0m, time elapsed: 323100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ScalarBitwiseXor (26800 ns)
    TCS: [33mTestCase_testVec4Vec1BitOrBroadcast[0m, time elapsed: 387000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitOrBroadcast (37400 ns)
    TCS: [33mTestCase_testVec4Vec1BitXorBroadcast[0m, time elapsed: 394800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Vec1BitXorBroadcast (38300 ns)
    TCS: [33mTestCase_testVec4ShiftLeftVec1[0m, time elapsed: 333800 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeftVec1 (24900 ns)
    TCS: [33mTestCase_testVec4ShiftLeftVec[0m, time elapsed: 293100 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftLeftVec (19500 ns)
    TCS: [33mTestCase_testVec4ShiftRightVec[0m, time elapsed: 238000 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4ShiftRightVec (19300 ns)
    TCS: [33mTestCase_testVec4Increment[0m, time elapsed: 212400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Increment (27100 ns)
    TCS: [33mTestCase_testVec4Decrement[0m, time elapsed: 194400 ns, RESULT:
    [[32m PASSED [0m] CASE: testVec4Decrement (16100 ns)
    TCS: [33mTestCase_testFunctor1Vec1Identity[0m, time elapsed: 184500 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec1Identity (8800 ns)
    TCS: [33mTestCase_testFunctor1Vec1Transform[0m, time elapsed: 170600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec1Transform (7500 ns)
    TCS: [33mTestCase_testFunctor1Vec2Transform[0m, time elapsed: 180500 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec2Transform (7700 ns)
    TCS: [33mTestCase_testFunctor2Vec1Add[0m, time elapsed: 192100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec1Add (8200 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec1Mul[0m, time elapsed: 272200 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec1Mul (26200 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec1Shift[0m, time elapsed: 192500 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec1Shift (9200 ns)
    TCS: [33mTestCase_testFunctor1Vec3Transform[0m, time elapsed: 177600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec3Transform (8100 ns)
    TCS: [33mTestCase_testFunctor1Vec4Transform[0m, time elapsed: 216500 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor1Vec4Transform (9100 ns)
    TCS: [33mTestCase_testFunctor2Vec2Add[0m, time elapsed: 171700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec2Add (7400 ns)
    TCS: [33mTestCase_testFunctor2Vec3Add[0m, time elapsed: 169700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec3Add (9900 ns)
    TCS: [33mTestCase_testFunctor2Vec4Add[0m, time elapsed: 208900 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2Vec4Add (10500 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec2Mul[0m, time elapsed: 188800 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec2Mul (15700 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec3Mul[0m, time elapsed: 178600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec3Mul (6700 ns)
    TCS: [33mTestCase_testFunctor2VecScaVec4Mul[0m, time elapsed: 220100 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecScaVec4Mul (9100 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec2Shift[0m, time elapsed: 180700 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec2Shift (10500 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec3Shift[0m, time elapsed: 188500 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec3Shift (10300 ns)
    TCS: [33mTestCase_testFunctor2VecIntVec4Shift[0m, time elapsed: 204600 ns, RESULT:
    [[32m PASSED [0m] CASE: testFunctor2VecIntVec4Shift (7300 ns)
Summary: TOTAL: 372
    [32mPASSED[0m: 372, [32mSKIPPED[0m: 0, ERROR: 0
    [31mFAILED[0m: 0
--------------------------------------------------------------------------------------------------
Project tests finished, time elapsed: 132971800 ns, RESULT:
TP: [33mglm[0m.*, time elapsed: 132919800 ns, RESULT:
    PASSED:
    TP: [33mglm.detail[0m, time elapsed: 117664200 ns
Summary: TOTAL: 372
    [32mPASSED[0m: 372, [32mSKIPPED[0m: 0, ERROR: 0
    [31mFAILED[0m: 0
--------------------------------------------------------------------------------------------------
[0J7[;r8[?25hcjpm test success
