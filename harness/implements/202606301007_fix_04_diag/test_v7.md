# 测试报告（v7）

## 测试文件

`cjglm/tests/glm/gtc/round_test.cj`

## 新增用例

| @Test 函数 | 断言 | 覆盖维度 |
|-----------|------|---------|
| `testRoundPowerOfTwoNegZero` | `@ExpectTrue(roundPowerOfTwo(Float64(-0.0)).toBits() == Float64(-0.0).toBits())` | 边界条件（-0.0 符号保留） |
| `testCeilPowerOfTwoNegZero` | `@ExpectTrue(ceilPowerOfTwo(Float64(-0.0)).toBits() == Float64(-0.0).toBits())` | 边界条件（-0.0 符号保留） |
| `testFloorPowerOfTwoNegZero` | `@ExpectTrue(floorPowerOfTwo(Float64(-0.0)).toBits() == Float64(-0.0).toBits())` | 边界条件（-0.0 符号保留） |

## 设计符合性

- 采用 `toBits()` 位模式对比绕过 IEEE 754 `-0.0 == 0.0` 问题
- 使用 `@ExpectTrue(bool)` 风格，与文件内 NaN 断言风格一致
- 每个函数独立 `@Test` 用例，与现有 +0.0 测试并列
- 不修改正零行为（+0.0 测试保持不变）
