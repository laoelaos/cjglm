# 任务指令（v1）

## 动作
NEW

## 任务描述
修复 `cjglm/src/detail/type_quat_cast.cj` 中 `quatCast` 函数的算法因子 2 缩放 bug。

**问题根因**：`type_quat_cast.cj:83-107` 中 quatCast 各分支计算 `v = sqrtT(fourBiggestSquaredMinus1 + one)` 后，对非最大分量直接使用 `matrixElement / v`，缺少 GLM 参考实现中的 `* 0.5` 因子。

**GLM 参考算法**（`quaternion.inl:106-122`）：
```
biggestVal = sqrt(fourBiggestSquaredMinus1 + 1) * 0.5;   // = |biggest_component|
mult = 0.25 / biggestVal;                                 // = 0.25 / |biggest|
// 非最大分量 = matrix_element * mult = 4*biggest*comp * 0.25/|biggest| = comp
```

**当前错误算法**：
```
v = sqrtT(fourBiggestSquaredMinus1 + one);                // = 2*|biggest|（缺少 *0.5）
// 非最大分量 = matrix_element / v = 4*biggest*comp / (2*|biggest|) = 2*comp
```

**修复要点**：将每个分支改为与 GLM 一致的三步模式：
1. `v = sqrtT(fourBiggestSquaredMinus1 + one)` — 与当前一致
2. `biggestVal = v * half` — 计算最大分量的绝对值
3. `mult = half / v` — 计算乘法因子（等价于 GLM 的 `0.25 / biggestVal`）
4. 非最大分量使用 `matrixElement * mult` 替代 `matrixElement / v`

**具体修改**（涉及 4 个分支：biggestIndex == 0/1/2/else，对应 `type_quat_cast.cj:83-107`）：

每个分支的修改模式：
```cangjie
// 当前（错误）：
let v: T = sqrtT(fourXSquaredMinus1 + one)
x = v * half
y = (m.c0.y + m.c1.x) / v
z = (m.c0.z + m.c2.x) / v
w = (m.c1.z - m.c2.y) / v

// 修复后（正确）：
let v: T = sqrtT(fourXSquaredMinus1 + one)
let biggestVal = v * half
let mult = half / v
x = biggestVal
y = (m.c0.y + m.c1.x) * mult
z = (m.c0.z + m.c2.x) * mult
w = (m.c1.z - m.c2.y) * mult
```

四个分支的 matrix_element 对应关系（保持现有矩阵元素表达式不变，仅将 `/ v` 改为 `* mult`）：
- **biggestIndex == 0（X 最大）**：y = (c0.y + c1.x), z = (c0.z + c2.x), w = (c1.z - c2.y)
- **biggestIndex == 1（Y 最大）**：x = (c0.y + c1.x), z = (c1.z + c2.y), w = (c2.x - c0.z)
- **biggestIndex == 2（Z 最大）**：x = (c0.z + c2.x), y = (c1.z + c2.y), w = (c0.y - c1.x)
- **biggestIndex == 3（W 最大）**：x = (c1.z - c2.y), y = (c2.x - c0.z), z = (c0.y - c1.x)

## 选择理由
S1 是最严重的功能缺陷（真实存在，实现与参考实现存在算法偏差），影响所有调用 `quatCast`（含 `fromMat3`/`fromMat4` 工厂函数）的 round-trip 场景。修复后可通过现有的 `src/detail/type_quat_cast_s1_test.cj`（3 个 `@Test`）直接验证，不依赖其他任务。

## 任务上下文
- **待修复文件**：`cjglm/src/detail/type_quat_cast.cj:51-110`（quatCast 函数体）
- **GLM 参考实现**：`references/glm-1.0.3/glm/glm/gtc/quaternion.inl:106-122`
- **验证测试**：`cjglm/src/detail/type_quat_cast_s1_test.cj`
- **OOD 设计引用**：`docs/05_ood_phase3.md` §3.2.1（quatCast 签名与算法说明）
- **诊断报告**：`docs/diag/impl/03_diag.md` §S1

## 已有代码上下文
当前 `type_quat_cast.cj:51-110` 的 quatCast 实现使用 4 个分支确定最大分量，每个分支先用 `sqrtT(four?SquaredMinus1 + one)` 计算 `v`（= `2*|biggest|`），再将 `v * half` 赋给最大分量，非最大分量使用 `matrixElement / v` 计算。

已有的验证测试文件 `type_quat_cast_s1_test.cj` 包含 3 个 `@Test`：
- `testS1QuatCastScalingXBranch`：q=(0.8,0.1,0.1,0.1)，X 分支，预期各分量恢复原值
- `testS1QuatCastScalingWBranch`：q=(0.1,0.1,0.1,0.8)，W 分支，预期各分量恢复原值
- `testS1QuatCastNonUnitRoundTrip`：q=(0.2,0.3,0.4,0.8)，非单位 round-trip

**`cjpm test` 验证预期**：修复前 `cjpm test` 输出 3 FAILED（均来自 `type_quat_cast_s1_test.cj`）；修复后这 3 个用例应变为 PASSED，且无新增 FAILED 用例。
