# 详细设计（v1）

## 概述

修复 `cjglm/src/detail/type_quat_cast.cj` 中 `quatCast(Mat3)` 函数的算法因子 2 缩放 bug（诊断报告 S1）。当前实现中，`quatCast` 各分支在计算 `v = sqrtT(fourBiggestSquaredMinus1 + one)` 后，对非最大分量直接使用 `matrixElement / v`，缺少 GLM 参考实现中的 `* 0.5` 因子，导致返回四元数的非最大分量被缩放 2 倍。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `cjglm/src/detail/type_quat_cast.cj` | 修改 | 修复 `quatCast` 函数 4 个分支的算法因子（第 83-107 行） |

## 类型定义

### 无新增类型

本次修复不涉及新增类型。所有修改均在已有函数 `quatCast<T, Q>(m: Mat3x3<T, Q>): Quat<T, Q>` 内部完成。

## 修改方案

### quatCast 函数分支修复

**修改位置**：`type_quat_cast.cj:83-107`（4 个分支）

**模式变更**（每个分支）：

当前（buggy）：
```
let v: T = sqrtT(four?SquaredMinus1 + one)
// 最大分量 = v * half              // 等价于 |biggest|
// 非最大分量 = matrixElement / v   // 4*biggest*comp / (2*|biggest|) = 2*comp ❌
```

修复后（正确）：
```
let v: T = sqrtT(four?SquaredMinus1 + one)    // v = 2*|biggest|
let biggestVal = v * half                       // biggestVal = |biggest|
let mult = half / v                             // mult = 0.25/|biggest| (等价于 GLM 的 0.25 / biggestVal)
// 最大分量 = biggestVal
// 非最大分量 = matrixElement * mult            // = 4*biggest*comp * 0.25/|biggest| = comp ✅
```

### 具体修改一览

#### 分支 0（biggestIndex == 0，X 最大）
当前（line 84-88）：
```
let v: T = sqrtT(fourXSquaredMinus1 + one)
x = v * half
y = (m.c0.y + m.c1.x) / v
z = (m.c0.z + m.c2.x) / v
w = (m.c1.z - m.c2.y) / v
```
修复后：
```
let v: T = sqrtT(fourXSquaredMinus1 + one)
let biggestVal = v * half
let mult = half / v
x = biggestVal
y = (m.c0.y + m.c1.x) * mult
z = (m.c0.z + m.c2.x) * mult
w = (m.c1.z - m.c2.y) * mult
```

#### 分支 1（biggestIndex == 1，Y 最大）
当前（line 90-94）：
```
let v: T = sqrtT(fourYSquaredMinus1 + one)
x = (m.c0.y + m.c1.x) / v
y = v * half
z = (m.c1.z + m.c2.y) / v
w = (m.c2.x - m.c0.z) / v
```
修复后：
```
let v: T = sqrtT(fourYSquaredMinus1 + one)
let biggestVal = v * half
let mult = half / v
x = (m.c0.y + m.c1.x) * mult
y = biggestVal
z = (m.c1.z + m.c2.y) * mult
w = (m.c2.x - m.c0.z) * mult
```

#### 分支 2（biggestIndex == 2，Z 最大）
当前（line 96-100）：
```
let v: T = sqrtT(fourZSquaredMinus1 + one)
x = (m.c0.z + m.c2.x) / v
y = (m.c1.z + m.c2.y) / v
z = v * half
w = (m.c0.y - m.c1.x) / v
```
修复后：
```
let v: T = sqrtT(fourZSquaredMinus1 + one)
let biggestVal = v * half
let mult = half / v
x = (m.c0.z + m.c2.x) * mult
y = (m.c1.z + m.c2.y) * mult
z = biggestVal
w = (m.c0.y - m.c1.x) * mult
```

#### 分支 else（biggestIndex == 3，W 最大）
当前（line 102-106）：
```
let v: T = sqrtT(fourWSquaredMinus1 + one)
x = (m.c1.z - m.c2.y) / v
y = (m.c2.x - m.c0.z) / v
z = (m.c0.y - m.c1.x) / v
w = v * half
```
修复后：
```
let v: T = sqrtT(fourWSquaredMinus1 + one)
let biggestVal = v * half
let mult = half / v
x = (m.c1.z - m.c2.y) * mult
y = (m.c2.x - m.c0.z) * mult
z = (m.c0.y - m.c1.x) * mult
w = biggestVal
```

## 行为契约

### 前置条件
- 输入矩阵 `m` 应为纯旋转矩阵（3×3 正交矩阵）。对非旋转矩阵，行为未定义（与 OOD §3.2.1 一致）。

### 后置条件
- 返回的四元数 `q` 满足 `mat3Cast(q) ≈ m`（round-trip 等价）
- 非最大分量的计算由 `matrixElement / v` 改为 `matrixElement * mult`，各分量在数学上恢复正确值（不再 2 倍缩放）

### 算法等价性验证
`mult = half / v = 0.5 / (2 * |biggest|) = 0.25 / |biggest|`，与 GLM 的 `mult = 0.25 / biggestVal` 等价：
- `4 * biggest * comp * (0.25 / |biggest|) = comp` ✅（GLM 路径）
- `4 * biggest * comp * (0.5 / (2 * |biggest|)) = comp` ✅（本修复路径）

## 错误处理

本次修改不影响错误处理方式。函数无错误路径（`FloatingPoint<T>` 约束确保 T 为浮点类型，不存在整数除零截断）。已有测试 `type_quat_cast_s1_test.cj` 中 3 个 `@Test` 的 `@Expect` 断言从 FAIL 变为 PASS。

## 依赖关系

- **被修改文件**：`cjglm/src/detail/type_quat_cast.cj`
- **保持的依赖**：`std.math.{Number, FloatingPoint, sqrt}`（不变）
- **验证测试**：`cjglm/src/detail/type_quat_cast_s1_test.cj`（3 个 `@Test`，修复后全部通过）
- **对外暴露**：`quatCast` 函数签名不变，调用方无需修改
