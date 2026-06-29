# 测试报告（v10）

## 概述

为 `quaternion_common.cj` 中 `lerp`/`mix` 的泛型约束收紧（`Number<T>` → `FloatingPoint<T>`）编写编译验证测试，覆盖所有 `FloatingPoint` 子类型（Float64/Float32/Float16）。

## 变更清单

| 文件 | 操作 | 说明 |
|------|------|------|
| `tests/glm/ext/quaternion_common_test.cj` | 修改 | 新增 `testLerpFloat16`、`testMixFloat32`、`testMixFloat16` 三个编译验证测试 |

## 新增测试

| 测试函数 | 被测函数 | 泛型类型 | 验证点 |
|---------|---------|---------|--------|
| `testLerpFloat16` | `lerp` | `Float16` | 验证 `FloatingPoint<T> & Comparable<T>` 约束下 Float16 编译通过且线性插值结果正确（a=0.0 → x, a=1.0 → y, a=0.5 → 中点） |
| `testMixFloat32` | `mix` | `Float32` | 验证 `FloatingPoint<T>` 约束下 Float32 编译通过且 stub 抛出 `Exception` |
| `testMixFloat16` | `mix` | `Float16` | 验证 `FloatingPoint<T>` 约束下 Float16 编译通过且 stub 抛出 `Exception` |

## 覆盖分析

已有测试（未修改）：
- `testLerp` — Float64，验证 `FloatingPoint<T> & Comparable<T>` 约束
- `testLerpFloat32` — Float32，验证 `FloatingPoint<T> & Comparable<T>` 约束
- `testMixStub` — Float64，验证 `FloatingPoint<T>` 约束

新增后全部覆盖：
- `lerp`: Float64 ✅, Float32 ✅, Float16 ✅
- `mix`: Float64 ✅, Float32 ✅, Float16 ✅

三个 `FloatingPoint` 子类型（Float64/Float32/Float16）均被测试，全面验证约束收紧对所有合法的浮点类型均编译通过。

## 设计偏差
无。
