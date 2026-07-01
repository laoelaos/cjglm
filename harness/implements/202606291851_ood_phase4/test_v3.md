# 测试报告（v3）

## 概述

为 `stdmath_shim.cj` 中 25 个数学 shim 函数（`sqrtT`、`expT`、`logT` 等）添加回归测试，专门验证 R2 名称解析歧义修复 —— 确保 shim 函数通过 `math.xxx()` 全限定名调用 `std.math` 函数，不再被同包 `exponential.cj`/`common.cj` 中的同名 `public` 函数遮蔽，消除 `StackOverflowError`。

## 测试文件

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 追加 | tests/glm/detail/stdmath_shim_test.cj | 追加回归测试，覆盖全部 25 个 shim 函数 |

## 测试用例概览

### 回归测试：名称解析歧义修复

每个 shim 函数类型至少一个正向调用，验证不抛出 `StackOverflowError`：

| 测试函数 | 覆盖维度 |
|---------|---------|
| `testSqrtTNoStackOverflow` | sqrtT 正常路径 |
| `testAbsTNoStackOverflow` | absT 正常路径 |
| `testExpTNoStackOverflow` | expT 正常路径 |
| `testLogTNoStackOverflow` | logT 正常路径 |
| `testFloorTNoStackOverflow` | floorT 正常路径 |
| `testShimInteropWithSamePackageSqrt` | shim sqrtT 与同包 `exponential.cj::sqrt` 结果一致性 |
| `testShimInteropWithSamePackageAbs` | shim absT 与同包 `common.cj::abs` 结果一致性 |
| `testAllShimNoStackOverflowInBatch` | 剩余 18 个 shim 函数批量验证（exp2/sin/cos/tan/asin/acos/atan/atan2/sinh/cosh/tanh/asinh/acosh/atanh/ceil/round/trunc/fmod） |

## 行为契约验证

| 契约 | 验证方式 |
|------|---------|
| 签名/泛型约束/返回类型不变 | 全部测试使用 `@Expect` 断言结果值 |
| 语义行为不变 | 返回值与标准数学结果一致 |
| 无名称解析歧义 | 全部测试正常返回，不抛 `StackOverflowError` |
| 与同包函数互操作 | `testShimInteropWithSamePackage*` 验证 shim 值与同包 public 函数值一致 |

## 设计偏差说明

| 设计规格 | 偏差 | 原因 |
|---------|------|------|
| 无 | 无 | 完全遵循详细设计行为契约 |

## 验证标准

- 与 `cjpm test` 集成 —— 新增测试与既有 395 行测试同文件运行
- 全部断言通过（0 ERROR、0 FAILED），不抛 `StackOverflowError`
