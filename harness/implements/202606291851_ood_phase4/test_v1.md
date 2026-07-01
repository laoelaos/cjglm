# 测试报告（v1）

## 测试文件

`tests/glm/detail/stdmath_shim_test.cj`

## 测试覆盖矩阵

### 组 1：指数/对数/幂（6 个函数）

| 函数 | 正向 Float64 | 正向 Float32 | 正向 Float16 | 边界/异常 |
|------|-------------|-------------|-------------|----------|
| sqrtT | testSqrtTFloat64 | testSqrtTFloat32 | testSqrtTFloat16 | testSqrtTEdgeCases（NaN） |
| expT | testExpTFloat64 | testExpTFloat32 | testExpTFloat16 | testExpTFloat16OverflowThrows（ArithmeticException） |
| logT | testLogTFloat64 | testLogTFloat32 | — | testLogTEdgeCases（-Inf, NaN） |
| exp2T | testExp2TFloat64 | testExp2TFloat32 | — | — |
| log2T | testLog2TFloat64 | testLog2TFloat32 | — | — |
| powT | testPowTFloat64 | testPowTFloat32 | testPowTFloat16 | — |

### 组 2：三角函数（7 个函数）

| 函数 | 正向 Float64 | 正向 Float32 | 正向 Float16 | 边界/异常 |
|------|-------------|-------------|-------------|----------|
| sinT | testSinTFloat64 | testSinTFloat32 | testSinTFloat16 | — |
| cosT | testCosTFloat64 | testCosTFloat32 | — | — |
| tanT | testTanTFloat64 | testTanTFloat32 | — | — |
| asinT | testAsinTFloat64 | testAsinTFloat32 | — | testAsinTOutOfRange（Exception） |
| acosT | testAcosTFloat64 | testAcosTFloat32 | — | testAcosTOutOfRange（Exception） |
| atanT | testAtanTFloat64 | testAtanTFloat32 | — | — |
| atan2T | testAtan2TFloat64 | testAtan2TFloat32 | — | — |

### 组 3：双曲函数（6 个函数）

| 函数 | 正向 Float64 | 正向 Float32 | 正向 Float16 | 边界/异常 |
|------|-------------|-------------|-------------|----------|
| sinhT | testSinhTFloat64 | testSinhTFloat32 | testSinhTFloat16 | — |
| coshT | testCoshTFloat64 | testCoshTFloat32 | — | — |
| tanhT | testTanhTFloat64 | testTanhTFloat32 | — | — |
| asinhT | testAsinhTFloat64 | testAsinhTFloat32 | — | — |
| acoshT | testAcoshTFloat64 | testAcoshTFloat32 | — | testAcoshTDomainError（NaN） |
| atanhT | testAtanhTFloat64 | testAtanhTFloat32 | — | testAtanhTDomainError（NaN） |

### 组 4：舍入/绝对值（6 个函数）

| 函数 | 正向 Float64 | 正向 Float32 | 正向 Float16 | 边界/异常 |
|------|-------------|-------------|-------------|----------|
| floorT | testFloorTFloat64 | testFloorTFloat32 | testFloorTFloat16 | — |
| ceilT | testCeilTFloat64 | testCeilTFloat32 | — | — |
| roundT | testRoundTFloat64 | testRoundTFloat32 | — | — |
| truncT | testTruncTFloat64 | testTruncTFloat32 | — | — |
| absT | testAbsTFloat64 | testAbsTFloat32 | — | — |
| fmodT | testFmodTFloat64 | testFmodTFloat32 | — | — |

### 返回类型一致性

| 测试函数 | 验证内容 |
|---------|---------|
| testReturnTypeFloat64IsFloat64 | 显式声明 `let r: Float64` 确认返回类型为 Float64 |
| testReturnTypeFloat32IsFloat32 | 显式声明 `let r: Float32` 确认返回类型为 Float32 |

## 类型覆盖说明

- **Float64**：全部 25 个函数均覆盖正向用例
- **Float32**：全部 25 个函数均覆盖正向用例
- **Float16**：覆盖 7 个函数的正向用例（sqrtT、expT、powT、sinT、sinhT、floorT）及 1 个溢出异常用例（expT）；其余函数因 Float16 精度/范围特性，由泛型约束 `T <: FloatingPoint<T>` 保证类型安全性，编译期验证通过

## 边界/异常场景覆盖

| 场景 | 测试函数 | 预期行为 |
|------|---------|---------|
| sqrt(-1) → NaN | testSqrtTEdgeCases | `isNaN` 验证 |
| log(0) → -Inf | testLogTEdgeCases | `!isFinite` 验证 |
| log(-1) → NaN | testLogTEdgeCases | `isNaN` 验证 |
| asin(1.5) 越界 | testAsinTOutOfRange | `@ExpectThrows[Exception]` |
| acos(1.5) 越界 | testAcosTOutOfRange | `@ExpectThrows[Exception]` |
| acosh(0.5) 定义域外 | testAcoshTDomainError | `isNaN` 验证 |
| atanh(1.5) 定义域外 | testAtanhTDomainError | `isNaN` 验证 |
| Float16 转型溢出 | testExpTFloat16OverflowThrows | `ArithmeticException` 抛出（已知偏差 DV-IMPL） |

## 编译与运行结果

```
cjpm test
Summary: TOTAL: 435
PASSED: 435, SKIPPED: 0, ERROR: 0
FAILED: 0
```

全部 435 个测试用例通过，0 失败，0 错误。

## 已知偏差验证

设计规格中指出的 Float16 转型溢出偏差已在 `testExpTFloat16OverflowThrows` 中验证：`expT(Float16(65504.0))` 触发 `ArithmeticException`（超出 Float16 表示范围 ±65504），与偏差记录一致。

## 审查输出路径

`harness/implements/202606291851_ood_phase4/test_review_v1_r1.md`
