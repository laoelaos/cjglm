# 测试审查报告（v1 r2）

## 审查结果
REJECTED

## 发现

- **[严重]** `cjglm/src/detail/type_quat_cast_s1_test.cj:4-81` — 全部 7 个 `@Test` 均 FAILED（实测确认）。根本原因：所有测试输入均使用非单位四元数，违反详细设计 §行为契约 前置条件「输入矩阵 `m` 应为纯旋转矩阵（3×3 正交矩阵）」。非单位四元数经 `mat3Cast` 产生的矩阵并非纯旋转矩阵，导致 `quatCast` round-trip 无法恢复原值。

- **[严重]** `cjglm/src/detail/type_quat_cast_s1_test.cj:14-23` — `testS1QuatCastScalingWBranch` 使用非单位四元数 `(0.1, 0.1, 0.1, 0.8)`（$\|q\|^2=0.67$）。W 分支的 trace 公式 `fourWSquaredMinus1 = 3 - 4(x^2+y^2+z^2)` 依赖四元数模长 N，当 N ≠ 1 时 round-trip 不成立。实测 `q1 ≈ (0.081, 0.081, 0.081, 0.985)`，与期望 `(0.1, 0.1, 0.1, 0.8)` 偏差显著。

- **[严重]** `cjglm/src/detail/type_quat_cast_s1_test.cj:47-58` — `testS1QuatCastNonUnitRoundTrip` 使用非单位四元数 `(0.2, 0.3, 0.4, 0.8)`。触发 W 分支，round-trip 不成立。实测各分量均与期望不符。

- **[严重]** `cjglm/src/detail/type_quat_cast_s1_test.cj:72-81` — `testS1QuatCastMat4Delegation` 使用非单位四元数 `(0.3, 0.5, 0.2, 0.1)`。因 N 偏移导致 `biggestIndex` 判定异常，实际进入 W 分支而非期望的 Y 分支，结果偏差极大。

- **[一般]** `cjglm/src/detail/type_quat_cast_s1_test.cj:3-12,25-34,36-45` — X/Y/Z 分支测试虽数学上正确（trace 公式与 N 无关），但非单位输入导致 FP 舍入误差（~1 ULP，delta ~1.39e-17），`@Expect` 精确相等断言失败。

- **[一般]** `cjglm/src/detail/type_quat_cast_s1_test.cj:60-70` — Identity round-trip 测试失败（`m == m2` 为 false），需调查 `Mat3x3` 的 `==` 实现或测试构造方式是否存在问题。

## 修改要求

所有测试必须使用单位四元数作为输入。全部 7 个 `@Test` 均需修正输入值，使 $x^2 + y^2 + z^2 + w^2 = 1$，以满足详细设计前置条件。修正后重新验证全部 7 个测试应全部 PASS。
