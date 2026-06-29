# 测试报告（v1 r2）

## 测试文件

`cjglm/src/detail/type_quat_cast_s1_test.cj`

## 修订说明（v1 → v1 r2）

- 全部 7 个 `@Test` 的输入四元数改为**单位四元数**（x²+y²+z²+w²≈1），满足详细设计 §行为契约 前置条件
- `testS1QuatCastNonUnitRoundTrip` 更名为 `testS1QuatCastUnitRoundTrip`
- 所有 FP 断言从 `@Expect(分量, 期望值)` 精确相等改为 `Mat3x3.equalEpsilon` 基于 epsilon 的圆路比较，消除 ULP 舍入误差导致的假阴性
- Identity 测试同样改为 `equalEpsilon`，增强鲁棒性

## 测试用例

| 测试函数 | 覆盖维度 | 输入四元数 (x,y,z,w) | 说明 |
|---------|---------|---------------------|------|
| `testS1QuatCastScalingXBranch` | 正常路径，X 分支 | (0.8, 0.3, 0.2, ≈0.4796) | 验证 X 为最大分量时 round-trip 正确 |
| `testS1QuatCastScalingYBranch` | 正常路径，Y 分支 | (0.2, 0.8, 0.3, ≈0.4796) | 验证 Y 为最大分量时 round-trip 正确 |
| `testS1QuatCastScalingZBranch` | 正常路径，Z 分支 | (0.2, 0.3, 0.8, ≈0.4796) | 验证 Z 为最大分量时 round-trip 正确 |
| `testS1QuatCastScalingWBranch` | 正常路径，W 分支 | (0.3, 0.2, 0.4, ≈0.8426) | 验证 W 为最大分量时 round-trip 正确 |
| `testS1QuatCastUnitRoundTrip` | 状态交互，round-trip | (0.2, 0.3, 0.4, ≈0.8426) | 验证通用单位四元数圆路保持 |
| `testS1QuatCastIdentityRoundTrip` | 边界条件，单位矩阵 | 直接构造单位矩阵 | 验证单位矩阵的 quatCast→mat3Cast round-trip |
| `testS1QuatCastMat4Delegation` | 正常路径，Mat4 入口 | (0.3, 0.5, 0.2, ≈0.7874) | 验证 quatCast(Mat4) 委托正确性 |

## 覆盖说明

- 4 个分支（X/Y/Z/W 最大）各有一个正向用例，非最大分量均非零，确保 mult 因子被实际运算
- Unit round-trip 验证通用输入下状态传递的一致性
- Identity 测试验证边界情形
- Mat4 入口验证委托路径
- 所有断言使用 `equalEpsilon`（相对误差 ≤ machine epsilon，约 2.2e-16），消除 ULP 舍入假阴性

## 设计偏差

无偏差。测试覆盖与详细设计 §行为契约 一致。
