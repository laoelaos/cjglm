# 测试报告（v9）

## 验证范围

4 个测试文件、8 个问题（G13-G20）的全部测试变更。

## 文件状态

| # | 文件 | 变更类型 | 状态 |
|---|------|---------|------|
| G13 | `tests/glm/detail/common_test.cj:382-388` | testFractVec4 补充 z/w 断言 | ✅ 已实现 |
| G14 | `tests/glm/detail/exponential_test.cj:226-230` | 新增 testSqrtLogEdgeCases 边界测试 | ✅ 已实现 |
| G15 | `tests/glm/detail/stdmath_shim_test.cj` | 新增 19 个 Float16 测试函数 | ✅ 已实现 |
| G16 | `tests/glm/detail/stdmath_shim_test.cj` | 10 个 Float32 测试补充多组输入 | ✅ 已实现 |
| G17 | `tests/glm/detail/trigonometric_test.cj:865-1112` | 3 个三角恒等式验证函数（Float64/Float32/Float16） | ✅ 已实现 |
| G18 | `tests/glm/detail/trigonometric_test.cj:306-324` | 4 个 Float16 asin/acos ±1 边界测试 | ✅ 已实现 |
| G19 | `tests/glm/detail/trigonometric_test.cj:277-282` | testAtan2SecondBranchFloat16 | ✅ 已实现 |
| G20 | `tests/glm/detail/trigonometric_test.cj:806-861` | 6 个 Vec3/Vec4 非零向量 asinh/acosh/atanh 测试 | ✅ 已实现 |

## 设计偏差说明

无偏差。实现与详细设计 v9 完全一致。

## 新增测试函数清单

### G13 — common_test.cj
- `testFractVec4`：补充 `@Expect(r.z, Float64(0.5))` 和 `@Expect(r.w, Float64(0.0))`

### G14 — exponential_test.cj
- `testSqrtLogEdgeCases`：sqrt(-1)→NaN, log(0)→-Inf（isInf 方式）, log(-1)→NaN

### G15 — stdmath_shim_test.cj（19 个 Float16 测试函数）
| 函数 | 位置 |
|------|------|
| testLogTFloat16 | :61 |
| testExp2TFloat16 | :66 |
| testLog2TFloat16 | :72 |
| testCosTFloat16 | :233 |
| testTanTFloat16 | :238 |
| testAsinTFloat16 | :243 |
| testAcosTFloat16 | :248 |
| testAtanTFloat16 | :253 |
| testAtan2TFloat16 | :258 |
| testCoshTFloat16 | :325 |
| testTanhTFloat16 | :330 |
| testAsinhTFloat16 | :335 |
| testAcoshTFloat16 | :340 |
| testAtanhTFloat16 | :345 |
| testCeilTFloat16 | :431 |
| testRoundTFloat16 | :437 |
| testTruncTFloat16 | :443 |
| testAbsTFloat16 | :449 |
| testFmodTFloat16 | :455 |

### G16 — stdmath_shim_test.cj（10 个 Float32 函数补充输入）
| 函数 | 补充内容 |
|------|---------|
| testSqrtTFloat32 | 补充 0.0→0.0 |
| testExpTFloat32 | 补充 1.0→2.718281828459045 |
| testLogTFloat32 | 补充 2.718281828459045→1.0 |
| testSinTFloat32 | 补充 pi/2→1.0, pi/4→0.7071, pi/6→0.5 |
| testCosTFloat32 | 补充 pi→-1.0 |
| testTanTFloat32 | 补充 pi/4→1.0 |
| testAsinTFloat32 | 补充 1.0→pi/2, -1.0→-pi/2 |
| testAcosTFloat32 | 补充 0.0→pi/2 |
| testAtanTFloat32 | 补充 1.0→pi/4 |
| testAtan2TFloat32 | 补充 (1,0)→pi/2 |

### G17 — trigonometric_test.cj（3 个恒等式验证函数）
- `testIdentitySin2Cos2Float64` (scalar+Vec1~Vec4, epsilon=1e-12)
- `testIdentitySin2Cos2Float32` (scalar+Vec1~Vec4, epsilon=1e-6)
- `testIdentitySin2Cos2Float16` (scalar+Vec1~Vec4, epsilon=1e-3)

### G18 — trigonometric_test.cj（4 个 Float16 边界测试）
- testAsinPlusOneFloat16, testAsinMinusOneFloat16
- testAcosPlusOneFloat16, testAcosMinusOneFloat16

### G19 — trigonometric_test.cj
- testAtan2SecondBranchFloat16：atan2(1,0)=pi/2, atan2(-1,0)=-pi/2, atan2(0,-1)=pi

### G20 — trigonometric_test.cj（6 个非零向量测试）
- testAsinhVec3NonZero, testAcoshVec3NonZero, testAtanhVec3NonZero
- testAsinhVec4NonZero, testAcoshVec4NonZero, testAtanhVec4NonZero

## 覆盖维度

| 维度 | 覆盖情况 |
|------|---------|
| 正常路径 | G13/G15/G16/G17 基础功能验证 |
| 边界条件 | G14 特殊域值（NaN/-Inf）、G18 asin/acos ±1 |
| 错误路径 | G14 sqrt(-1)→NaN、log(-1)→NaN |
| 状态交互 | G17 恒等式跨精度/跨维度验证 |
