# 详细设计（v2）

## 概述

修复 `type_quat_cast_s1_test.cj` 中 7 个 `@Test` 的断言方式，绕过 `Mat3x3.equalEpsilon`（`extend` 方法体内 `this.c0.x` 路径的 9 `&&` 链式表达因仓颉 extend bug 返回错误结果）。将基于 `Mat3x3.equalEpsilon` 的断言替换为基于 `Vec3.equalEpsilon` 的逐列比较。

代码修复（`type_quat_cast.cj` 的 4 个分支引入 `mult = half / v` 模式）已在 R1 中正确实施，本次不作修改。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `cjglm/src/detail/type_quat_cast_s1_test.cj` | 修改 | 7 个 `@Test` 的断言绕过 `Mat3x3.equalEpsilon`，改用 `Vec3.equalEpsilon` 逐列比较 |

## 修改方案

### 通用替换模式

所有 7 个测试中，形如 `@Expect(m0.equalEpsilon(m1), true)` 的断言统一替换为：

```
@Expect(m0.c0.equalEpsilon(m1.c0) && m0.c1.equalEpsilon(m1.c1) && m0.c2.equalEpsilon(m1.c2), true)
```

其中 `m1 = mat3Cast(q1)` 需引入局部变量（tests 1-4, 7 当前使用内联 `mat3Cast(q1)` 作为参数，需拆分为声明 + 引用两步）。

### 逐测试变更

| 序号 | 测试函数 | 当前断言 | 修改后断言 | 需新增变量 |
|------|---------|---------|-----------|-----------|
| 1 | `testS1QuatCastScalingXBranch` | `@Expect(m0.equalEpsilon(mat3Cast(q1)), true)` | `let m1 = mat3Cast(q1)` + `@Expect(m0.c0.equalEpsilon(m1.c0) && m0.c1.equalEpsilon(m1.c1) && m0.c2.equalEpsilon(m1.c2), true)` | `m1` |
| 2 | `testS1QuatCastScalingYBranch` | 同上 | 同上 | `m1` |
| 3 | `testS1QuatCastScalingZBranch` | 同上 | 同上 | `m1` |
| 4 | `testS1QuatCastScalingWBranch` | 同上 | 同上 | `m1` |
| 5 | `testS1QuatCastUnitRoundTrip` | `@Expect(m0.equalEpsilon(m1), true)`（`m1` 已存在） | `@Expect(m0.c0.equalEpsilon(m1.c0) && m0.c1.equalEpsilon(m1.c1) && m0.c2.equalEpsilon(m1.c2), true)` | 无 |
| 6 | `testS1QuatCastIdentityRoundTrip` | `@Expect(m.equalEpsilon(m2), true)` | `@Expect(m.c0.equalEpsilon(m2.c0) && m.c1.equalEpsilon(m2.c1) && m.c2.equalEpsilon(m2.c2), true)` | 无 |
| 7 | `testS1QuatCastMat4Delegation` | `@Expect(m0.equalEpsilon(mat3Cast(q1)), true)` | `let m1 = mat3Cast(q1)` + `@Expect(m0.c0.equalEpsilon(m1.c0) && m0.c1.equalEpsilon(m1.c1) && m0.c2.equalEpsilon(m1.c2), true)` | `m1` |

## 类型定义

无新增类型。仅修改测试断言表达式。

## Vec3.equalEpsilon 签名确认

`type_vec3.cj:153`：
```
public func equalEpsilon(other: Vec3<T, Q>): Bool
  where T <: Number<T> & Equatable<T> & Comparable<T>, Q <: Qualifier
```

返回 `Bool`，3 个 `ComputeEqualNumeric<T>.callConst` 的 `&&` 链，已验证正常工作（`type_vec3_test.cj:218` 通过）。

## 行为契约

### 前置条件
- 每个测试函数中 `m0`/`m1`/`m`/`m2` 均为 `Mat3x3<Float64, Defaultp>` 类型
- `Vec3<Float64, Defaultp>.equalEpsilon` 工作正常（已验证）

### 后置条件
- 7 个 `@Test` 全部 PASS
- Round-trip 等价性断言 `quatCast(mat3Cast(q)) ≈ q` 覆盖所有四元数分量和分支路径

## 错误处理

本次修改不涉及错误处理。所有断言保持 `@Expect(expr, true)` 形式不变。

## 依赖关系

- **被修改文件**：`cjglm/src/detail/type_quat_cast_s1_test.cj`
- **依赖的已有类型/方法**：`Vec3<T, Q>.equalEpsilon(other: Vec3<T, Q>): Bool`（`type_vec3.cj:153`）
- **绕过的有 bug 方法**：`Mat3x3<T, Q>.equalEpsilon(other: Mat3x3<T, Q>): Bool`（`type_mat3x3.cj:270`，预存 extend bug）
- **后续治理**：`Mat3x3` 的 extend bug 将在 G3.8/G3.9/lib.cj 任务中合并修复
