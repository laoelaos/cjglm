# 设计审查报告（v2 r1）

## 审查结果
REJECTED

## 发现

- **[一般]** `@OverflowWrapping` 标注不一致 — 任务要求"所有算术运算符统一标注 `@OverflowWrapping`"，但设计 §成员运算符代码块中以下运算符缺少该标注：`-(Quat×Quat)`、`*(Quat×Quat)`、`/(Quat×Quat)`、`*(Quat×Vec4)`、`/(Quat×T)`、`Vec3×Quat`、`Vec4×Quat`。修正方向：统一为成员运算符 extend 块和 Vec3/Vec4 extend 块中的所有算术运算符添加 `@OverflowWrapping`，或对有正当理由排除的运算符明确说明。

- **[一般]** `fromMat3`/`fromMat4` 工厂函数缺少成员级测试 — 任务测试方案中 `test_type_quat.cj` 覆盖"工厂函数"，但设计 §测试方案仅提及 `fromQuat` 未提及 `fromMat3`/`fromMat4` 的测试用例。修正方向：在 `test_type_quat.cj` 中补充 `fromMat3`（单位四元数→单位矩阵→quatCast 往返）和 `fromMat4`（Mat4x4 提取三列后转 Quat 验证）的测试描述。

## 修改要求（仅 REJECTED 时）

### 问题 1：`@OverflowWrapping` 标注不一致
**问题**：§成员运算符 extend 块代码块中，`@OverflowWrapping` 仅出现在 `-()`、`+(Quat)`、`*(Vec3)`、`*(T)` 四个运算符上，而 `-(Quat)`、`*(Quat×Quat)`、`/(Quat×Quat)`、`*(Vec4)`、`/(T)` 及 Vec3/Vec4 extend 块的 `*(Quat)` 均缺少标注。与任务"所有算术运算符统一标注 @OverflowWrapping"的要求明显不符。

**为什么是问题**：整数类型（如 Int64/Int32）算术溢出时，缺少 `@OverflowWrapping` 会导致运行时 `ArithmeticException` 而非符合 GLM 惯例的 wrapping 行为，产生行为偏差。

**期望的修正方向**：将 §成员运算符 extend 块和 Vec3/Vec4 extend 块中所有算术运算符补齐 `@OverflowWrapping`，确保与任务要求一致。

### 问题 2：`fromMat3`/`fromMat4` 工厂函数缺少成员级测试
**问题**：§测试方案 `test_type_quat.cj` 中列出了 `fromQuat` 跨类型转换测试，但未提及 `fromMat3` 和 `fromMat4` 两个工厂函数的测试。

**为什么是问题**：`fromMat3`/`fromMat4` 作为 Quat 的成员工厂函数，内部依赖 `type_quat_cast.cj` 的 `quatCast`。虽然在 `test_type_quat_cast.cj` 中已有 `quatCast` 的往返验证，但缺少成员函数级别的调用测试（尤其是 `fromMat4` 的 Mat4x4→Mat3x3 提取逻辑），无法验证 `fromMat4` 的列提取正确性。

**期望的修正方向**：在 `test_type_quat.cj` 测试方案中补充 `fromMat3` 和 `fromMat4` 的测试用例描述：
- `fromMat3`：单位四元数 → `fromMat3` → 验证结果为单位矩阵 → `quatCast` 往返验证
- `fromMat4`：构建含旋转的 Mat4x4 → `fromMat4` → 验证四元数分量合理性
