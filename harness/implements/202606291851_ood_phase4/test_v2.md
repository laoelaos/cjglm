# 测试报告（v2 r1 修订）

## 概述

处理审查 v2 r1 的 2 项 REJECTED 问题和 3 项轻微建议，已覆写两个测试文件。

## 审查响应

### 问题 1：exponential_test.cj 缺少 Float16 覆盖（REJECTED）

**处理**：已修复。在 `exponential_test.cj` 中为全部 7 个指数函数（pow/exp/log/exp2/log2/sqrt/inversesqrt）各补充一个 Float16 正向用例。使用 `Float16(0.0)`、`Float16(1.0)`、`Float16(2.0)`、`Float16(8.0)` 等简单值确保结果在 Float16 精度范围内精确可表示。

### 问题 2：Vec1 类型在全部函数中零测试覆盖（REJECTED）

**处理**：已修复。在 `common_test.cj` 和 `exponential_test.cj` 中为每个函数补充 Vec1 用例：
- `common_test.cj`：Group A (7 个) + Group B (12 个) + Group C (2 个) + Group D (1 个) + Group F (2 个) = 24 个 Vec1 测试函数
- `exponential_test.cj`：全部 7 个函数各 1 个 Vec1 测试

### 问题 3（轻微）：intBitsToFloat/uintBitsToFloat 缺少独立正向用例

**处理**：已修复。为 `intBitsToFloat` 和 `uintBitsToFloat` 各添加直接正向用例，使用 `0x3F800000`（Float32 1.0 的 IEEE 754 位表示）验证返回值。

### 问题 4（轻微）：mod 整数缺少除零边界测试

**处理**：已修复。使用 `@ExpectThrows[ArithmeticException]` 添加 `mod(Int64(5), Int64(0))` 测试。

### 问题 5（轻微）：inversesqrt 零值测试应使用 isInf

**处理**：已修复。将 `isNaN(r) || r > Float64(1e308)` 替换为 `@Expect(isInf(r), true)`，精确匹配设计契约的 +Inf 预期。

## 文件变更

### 修改：`tests/glm/detail/exponential_test.cj`
- 新增 Float16 测试块（7 个测试函数）
- 新增 Vec1 测试块（7 个测试函数）
- 修正 `isInf` 导入和 `testInversesqrtZero` 断言

### 修改：`tests/glm/detail/common_test.cj`
- 新增 Group A Vec1 测试块（7 个函数：abs/sign/min/max/clamp/step/smoothstep）
- 新增 Group B Vec1 测试块（12 个函数：floor/ceil/fract/trunc/round/roundEven/fma/frexp/ldexp/modf/isnan/isinf）
- 新增 Group C Vec1 测试块（2 个函数：mix 三参数、mix Bool）
- 新增 Group D Vec1 测试块（1 个函数：mod Int）
- 新增 Group F Vec1 测试块（2 个函数：floatBitsToInt/floatBitsToUint）
- 新增 intBitsToFloat/uintBitsToFloat 直接正向用例
- 新增 mod 整数除零边界测试

## 合计新增测试

| 文件 | 新增测试函数 |
|------|------------|
| common_test.cj | 26 |
| exponential_test.cj | 14 |
| **总计** | **40** |
