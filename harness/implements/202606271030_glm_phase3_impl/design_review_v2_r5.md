# 设计审查报告（v2 r5）

## 审查结果
REJECTED

## 发现

### [一般] `operator /(Quat, Quat)` 的语义未指定

- **位置**：`type_quat.cj` — extend 块成员运算符 `operator func /(rhs: Quat<T, Q>): Quat<T, Q>`
- **问题**：设计仅列出签名，未说明实现方式。GLM 中四元数间除法为 `q1 * inverse(q2)`（非逐分量），但在 `glm.detail` 包中无法 `import glm.ext.quaternion_common.inverse`（会引入 detail→ext 反向依赖，破坏单向依赖 DAG，详见 OOD §1）。
- **可能的正确方向**：
  - **内联实现**：`this * (conjugate(rhs) / dot(rhs, rhs))`，其中 `conjugate` 通过 `Quat(-rhs.x, -rhs.y, -rhs.z, rhs.w)` 内联，`dot(rhs, rhs)` = `rhs.x*rhs.x + rhs.y*rhs.y + rhs.z*rhs.z + rhs.w*rhs.w` — 所有操作均在 `Number<T>` 约束内，无需 ext 依赖。
  - **标记为 stub**：与 `Mat3x3::operator/(Mat3x3)` 一致，`throw Exception("stub")`，待阶段四统一实现。
- **期望**：设计需明确选择并写入行为契约小节。

## 修改要求

1. **[一般]** 明确 `operator /(Quat, Quat)` 的实现策略：内联 conjugate+dot 路径或 stub，并更新"行为契约"和错误处理章节。
