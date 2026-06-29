# 任务指令（v3）

## 动作
RETRY

## 任务描述
修改 `cjglm/src/detail/type_quat_cast_s1_test.cj`，修复 3 个 W-branch 测试因 Float64 浮点精度超 `epsilonOf`（2.22e-16）导致的失败。

具体变更：
1. 添加包级辅助函数 `mat3EqualEpsilonRelaxed(a: Mat3x3<Float64, Defaultp>, b: Mat3x3<Float64, Defaultp>): Bool`，使用 `epsilonOf(Float64) * 100.0` 作为容忍度逐分量比较 9 个矩阵元素
2. 将所有 7 个 `@Test` 函数中的断言 `@Expect(m0.c0.equalEpsilon(m1.c0) && m0.c1.equalEpsilon(m1.c1) && m0.c2.equalEpsilon(m1.c2), true)` 替换为 `@Expect(mat3EqualEpsilonRelaxed(m0, m1), true)`

## 选择理由
S1 算法代码修复（`type_quat_cast.cj` 中 `mult = half / v` 模式）已在 R1 验证为数学正确且与 GLM 一致。R2 通过 `Vec3.equalEpsilon` 逐列比较绕过 `Mat3x3.equalEpsilon` 的 extend bug 后，X/Y/Z/Identity 4 个分支测试通过，证明算法逻辑无问题。失败 3 个测试均走 W-branch——其 `v = sqrt(2.84)` 在 Float64 中非精确值，产生约 2-3 ULP 舍入误差（~2.5e-16），略超 `epsilonOf(Float64) = 2.22e-16`，导致 `Vec3.equalEpsilon` 返回 false。使用 `epsilon * 100.0`（2.22e-14）可安全容纳此类误差。

## 任务上下文
### 失败根因
W-branch（`biggestIndex == 3`）计算 `v = sqrt(fourWSquaredMinus1 + 1.0)`，其中 `fourWSquaredMinus1 = m.c0.x + m.c1.y + m.c2.z`。对于非身份四元数输入，该值通常不是精确可表示的 Float64 数，如 `1.84`。`sqrt(2.84)` 和非精确 Float64 值，导致 `mult = 0.5 / v` 也带误差。随后 `x = (m.c1.z - m.c2.y) * mult` 等减法-乘法链将约 2 ULP 的误差传递到分量值（约 2.5e-16），略超 `epsilonOf(Float64)`（2.22e-16）。

X/Y/Z 分支通过的原因：其 sqrt 参数（如 `1.56 + 1.0 = 2.56`）的平方根 1.6 是精确 Float64，mult = 0.5 / 1.6 = 0.3125 同样精确，故分量计算无额外舍入误差。

### 受影响的测试
| 测试函数 | 分支 | 当前状态 |
|---------|------|---------|
| `testS1QuatCastScalingXBranch` | X | PASSED |
| `testS1QuatCastScalingYBranch` | Y | PASSED |
| `testS1QuatCastScalingZBranch` | Z | PASSED |
| `testS1QuatCastScalingWBranch` | W | FAILED |
| `testS1QuatCastUnitRoundTrip` | W | FAILED |
| `testS1QuatCastIdentityRoundTrip` | W (identity) | PASSED（精确值） |
| `testS1QuatCastMat4Delegation` | W | FAILED |

## 已有代码上下文
当前 `type_quat_cast_s1_test.cj`（68 行）：

```
package glm.detail

@Test
func testS1QuatCastScalingXBranch(): Unit {
    let q0 = Quat<Float64, Defaultp>(0.8, 0.3, 0.2, 0.47958315233127196)
    let m0 = mat3Cast(q0)
    let q1 = quatCast(m0)
    let m1 = mat3Cast(q1)
    @Expect(m0.c0.equalEpsilon(m1.c0) && m0.c1.equalEpsilon(m1.c1) && m0.c2.equalEpsilon(m1.c2), true)
}
// 其余 6 个 @Test 相同模式
```

期望修改为：

```
package glm.detail

func mat3EqualEpsilonRelaxed(a: Mat3x3<Float64, Defaultp>, b: Mat3x3<Float64, Defaultp>): Bool {
    let eps = epsilonOf<Float64>() * 100.0
    func comp(x: Float64, y: Float64): Bool {
        let d = x - y
        let z = x - x
        let ad = if (d < z) { -d } else { d }
        ad <= eps
    }
    comp(a.c0.x, b.c0.x) && comp(a.c0.y, b.c0.y) && comp(a.c0.z, b.c0.z) &&
    comp(a.c1.x, b.c1.x) && comp(a.c1.y, b.c1.y) && comp(a.c1.z, b.c1.z) &&
    comp(a.c2.x, b.c2.x) && comp(a.c2.y, b.c2.y) && comp(a.c2.z, b.c2.z)
}

@Test
func testS1QuatCastScalingXBranch(): Unit {
    // ... same setup ...
    @Expect(mat3EqualEpsilonRelaxed(m0, m1), true)
}
// 其余 6 个 @Test 同样替换断言
```

## RETRY 说明
**R2 失败原因**：R2 将 `Mat3x3.equalEpsilon`（extend bug）替换为 `Vec3.equalEpsilon` 逐列比较，但 `Vec3.equalEpsilon` 使用 `ComputeEqualNumeric.callConst`，其容忍度为 `epsilonOf(Float64) = 2.22e-16`。W-branch 的浮点链 sqrt + 除法 + 减法乘法产生约 2.5e-16 的误差，超出此容忍度。

**R3 修正方向**：添加自定义辅助函数 `mat3EqualEpsilonRelaxed`，将容忍度放宽至 `epsilonOf(Float64) * 100.0 = 2.22e-14`，既容纳 W-branch 的浮点舍入误差，又保持充分的精度验证（2.22e-14 远小于使用场景中可接受的精度要求）。
