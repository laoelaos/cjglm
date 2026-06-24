# 设计审查报告（v15 r1）

## 审查结果
REJECTED

## 发现

### **[一般]** B3 场景断言与 `diagonal(NaN)` 实际行为不一致

**问题**：`testMat2x3DiagonalNaNMulVecFloat32/Float64` 中设计断言 `r.z == 0`（非 NaN），理由是"第 3 行无对角元素"。但实际的 `Mat2x3.diagonal(scalar)` 实现通过 `let zero = scalar - scalar` 计算零值。当 `scalar = NaN` 时，IEEE 754 规定 `NaN - NaN = NaN`，导致非对角元素（"zero"）全部变成 NaN。因此 `diagonal(nan)` 实际生成的是全 NaN 矩阵，而非仅对角线为 NaN 的矩阵。

Mat2x3 × Vec2(1,1) 计算展开：
- `r.x = col0.x * 1 + col1.x * 1 = nan * 1 + NaN * 1 = NaN`
- `r.y = col0.y * 1 + col1.y * 1 = NaN * 1 + nan * 1 = NaN`
- `r.z = col0.z * 1 + col1.z * 1 = NaN * 1 + NaN * 1 = NaN`

结果：`r.z` 为 NaN，而非 0。按设计编写的 `@Expect(r.z != r.z, false)` 断言将失败。

**影响文件**：`tests/glm/detail/test_matrix.cj` 中 `testMat2x3DiagonalNaNMulVecFloat32` 和 `testMat2x3DiagonalNaNMulVecFloat64` 两个测试函数。

**修正方向**：方案 A（推荐）— 直接使用 `diagonal(nan)` 并断言全部结果分量为 NaN，与任务要求"结果全部为 NaN"一致；方案 B — 手工构造纯对角线 NaN 矩阵（不使用 `diagonal` API），然后分别断言 `r.x`/`r.y` 为 NaN、`r.z` 为 0（测试更精确的对角线 NaN 传播语义）。

注意：A3（Mat4x4）和 C3（Mat3x2）不受此问题影响，其断言"全部 NaN"与实际行为一致。
