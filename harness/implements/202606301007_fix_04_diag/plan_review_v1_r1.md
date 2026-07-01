# 计划审查报告（v1 r1）

## 审查结果
APPROVED

## 发现

审查确认：

1. **需求覆盖完整**：计划覆盖了 04_diag.md 识别的全部问题（S1-S4、G1-G37），按优先级分 4 批处理，与修改流程建议一致。

2. **S1 修复确认**：已验证 GLM 1.0.3 `ext/matrix_transform.inl:40-44`（rotate）和 `:119-123`（shear）使用 `m[0]*Rot[0][0] + m[1]*Rot[0][1] + ...` 左乘模式（等价于 `m * Rot`/`m * Shear`），当前 Cangjie 代码 `Rot * m`/`H * m` 确为顺序反转。修复方向正确。

3. **任务范围合理**：task_v1.md 正确地将 R1 限定为 P1-1（S1），单文件 `ext/matrix_transform.cj`，两个乘法表达式修改，自包含无外部代码依赖。

4. **lib.cj 重导出验证**：`lib.cj:43` 已通过 `public import glm.ext.{translate, rotate, scale, shear, ...}` 重导出这些函数，修复后无需修改 lib.cj。

5. **ext 测试不受影响**：`matrix_transform_test.cj` 中的 rotate/shear 测试均使用单位矩阵作为输入 `m = I`，`I * Rot == Rot * I`，因此 S1 修复后这些测试不会失败，P1-1 确实可以独立于测试修正确认。

6. **实施路线表格**：plan.md 已包含实施路线表格，符合 requirement.md 要求。
