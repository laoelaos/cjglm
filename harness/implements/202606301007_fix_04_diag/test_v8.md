# 测试报告（v8）

## 概述

修复 `gtc/ulp.cj` 中 `float_distance` 函数（Float32/Float64 重载）的 `as` 转型返回值未展开 `Option` 的编译错误。添加 `.getOrThrow()` 后行为完全等价，无运行时变化。

## 测试文件

`cjglm/tests/glm/gtc/ulp_test.cj`

## 新增测试用例

| 测试函数 | 被测函数 | 覆盖维度 | 说明 |
|---------|---------|---------|------|
| `testFloatDistanceSameValueFloat32` | `float_distance(Float32, Float32)` | 正常路径-同一值 | 验证 `distance(x, x) == 0`，覆盖正/负/零同一值 |
| `testFloatDistanceSameValueFloat64` | `float_distance(Float64, Float64)` | 正常路径-同一值 | 同上，Float64 版本 |
| `testFloatDistanceLargeRangeFloat32` | `float_distance(Float32, Float32)` | 边界条件-大范围 | 验证 1.0 与 -1.0 距离为正数 |
| `testFloatDistanceLargeRangeFloat64` | `float_distance(Float64, Float64)` | 边界条件-大范围 | 同上，Float64 版本 |
| `testFloatDistancePosNegZeroFloat32` | `float_distance(Float32, Float32)` | 边界条件-±0 | 验证 ±0 到 1.0 的距离均为正（位模式不同但均为合法输入） |
| `testFloatDistancePosNegZeroFloat64` | `float_distance(Float64, Float64)` | 边界条件-±0 | 同上，Float64 版本 |

## 覆盖分析

| 维度 | 现有用例 | 新增用例 |
|------|---------|---------|
| 正常路径-相邻值 | `testFloatDistanceAdjacent` / `testFloatDistanceAdjacentFloat64` | — |
| 正常路径-同一值（=0） | — | `SameValueFloat32` / `SameValueFloat64` |
| 错误路径-NaN | `testFloatDistanceNaN` / `testFloatDistanceNaN64` | — |
| 错误路径-Inf | `testFloatDistanceInf` / `testFloatDistanceInf64` | — |
| 边界条件-负值 | `testFloatDistanceNegative` / `testFloatDistanceNegative64` | — |
| 边界条件-大范围 | — | `LargeRangeFloat32` / `LargeRangeFloat64` |
| 边界条件-±0 | — | `PosNegZeroFloat32` / `PosNegZeroFloat64` |
| 对称性 | `Adjacent` 双向检查 | `SameValue` 隐式对称 |

## 验证要点

- `(x.toBits() as IntN).getOrThrow()` 对所有合法 Float32/Float64 输入不抛异常
- 同一值距离为 0（`getOrThrow` 展开后算术正确）
- 正数与负数距离为正（`@OverflowWrapping` 下回绕不影响符号判断）
- ±0 位模式不同但 `.getOrThrow()` 均正常展开
