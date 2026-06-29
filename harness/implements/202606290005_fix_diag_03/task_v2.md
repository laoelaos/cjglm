# 任务指令（v2）

## 动作
RETRY

## 任务描述
S1: 修复 quatCast 算法因子 2 缩放 bug（`type_quat_cast.cj`）——测试修复版本。

代码修复已在 R1 中正确实施（`type_quat_cast.cj` 4 个分支引入 `mult = half / v` 模式）。但 `type_quat_cast_s1_test.cj` 的 7 个 `@Test` 全部因 `Mat3x3.equalEpsilon` 返回 false 而 FAIL。

## 选择理由
S1 是最严重的功能缺陷，影响所有四元数-矩阵互转的 round-trip 行为。代码修复已验证数学正确，需修复测试验证手段。

## 任务上下文
### 代码修复（已实施，保留不变）
- 文件：`cjglm/src/detail/type_quat_cast.cj`
- 修改：4 个分支中将非最大分量计算从 `matrixElement / v` 改为 `matrixElement * mult`（`mult = half / v`）
- 数学验证：`mult = half / v = 0.5 / (2*|biggest|) = 0.25/|biggest|`，与 GLM 1.0.3 一致

### 测试文件
- 文件：`cjglm/src/detail/type_quat_cast_s1_test.cj`
- 7 个 `@Test`：X/Y/Z/W 分支各一、unit round-trip、identity round-trip、Mat4 委托

## 已有代码上下文
- `Mat3x3<T, Q>` 在 `type_mat3x3.cj:269-277` 的 `equalEpsilon` 存在预存 bug：`extend` 方法体内通过 `this.c0.x` 字段路径的 9 个 `&&` 链式调用返回错误结果（已验证：`equalExact`、`==` 同样失败）
- `Vec3<T, Q>.equalEpsilon` 在 `type_vec3.cj:153` 正常工作（3 `&&`，已在 `type_vec3_test.cj:218` 验证通过）
- `ComputeEqualNumeric<T>.callConst` 单次调用正常工作

## RETRY 说明
失败原因：`Mat3x3.equalEpsilon` 存在预存 bug，7 个测试全部因 `@Expect(m0.equalEpsilon(mat3Cast(q1)), true)` 断言返回 false 而 FAIL。该 bug 影响所有 `Mat3x3` 的比较方法（`==`、`equalExact`、`equalEpsilon`），经诊断：
- `ComputeEqualNumeric<Float64>.callConst(a, b)` 单次调用正常
- 手动内联 9 `&&` 链 `ComputeEqualNumeric<Float64>.callConst(m.c0.x, m.c0.x) && ...` 正常
- 仅 `extend` 方法体内通过 `this.c0.x` 路径的链式表达返回错误

修正方向：测试断言将 `m0.equalEpsilon(mat3Cast(q1))` 替换为 `m0.c0.equalEpsilon(m1.c0) && m0.c1.equalEpsilon(m1.c1) && m0.c2.equalEpsilon(m1.c2)`（使用 Vec3.equalEpsilon 逐列比较），绕过 Mat3x3 的 extend bug。该绕过方案后续将在 G3.8/G3.9/lib.cj 任务中合并修复 Mat3x3 的 extend 方法。
