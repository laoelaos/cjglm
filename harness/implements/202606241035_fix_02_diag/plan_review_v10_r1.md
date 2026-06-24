# 计划审查报告（v10 r1）

## 审查结果
REJECTED

## 发现

### **[严重] T10 范围遗漏：test_matrix.cj 的 6 个 stub 测试未被纳入当前任务**

计划 T10 描述（第 151-160 行）和 task_v10.md 仅将 `test_common.cj`（12）、`test_geometric.cj`（17）、`test_geometric_refract.cj`（3）共 **32 个** stub 测试列为本次任务范围，完全未提及 `test_matrix.cj`。

然而：
- **诊断报告 §T10**（`02_diag.md:345-350`）明确列出 4 个文件、合计 **38 个** stub 测试函数，其中包括 `test_matrix.cj:258-290`（6 个）
- **计划自身的依赖图**（第 664 行）明确指出：`T10 操作 test_matrix.cj:258-290 修改 6 个 stub 测试`
- **实际文件验证**确认 `test_matrix.cj:257-291` 确实存在 6 个 `@ExpectThrows[Exception]` stub 测试（`testDeterminantMat2x2Stub`、`testDeterminantMat3x3Stub`、`testDeterminantMat4x4Stub`、`testInverseMat2x2Stub`、`testInverseMat3x3Stub`、`testInverseMat4x4Stub`），且 **T7 完成后这些测试未被移除或替换**，仍需要 T10 处理

计划第 153 行与第 664 行之间存在内部矛盾。当前 task 的范围遗漏将导致实施不完整——6 个 stub 测试不会被转换，届时需要额外的轮次来处理。

**修正方向**：将 `test_matrix.cj`（6 个 stub 测试）纳入 T10 任务范围，更新 task_v10.md 中涉及文件列表和总测试数（12+17+3+6=38），或明确说明为何 `test_matrix.cj` 的 6 个 stub 测试在本轮不处理（如拆分到后续子任务）。

### **[一般] 已知的 @Expect/@Fail 与 catch 互斥风险未在计划中记录或规避**

诊断报告 §T10（`02_diag.md:342-344`）明确警告：`@Expect(false, true)`（或 `@Fail`）在 stub 函数未抛异常时抛出的断言异常会被 `catch(e: Exception)` 捕获，导致错误的失败消息。该报告推荐了检查异常类型的规避方案（第 358-360 行）。

task_v10.md 第 24-32 行的替换模式未采取任何规避措施，计划也未记录此风险或讨论是否需要处理。现有 `test_shim_assert.cj:19-26` 使用相同的简单模式，但这不足以作为不处理的充分理由——诊断报告已明确指出这是一个已知风险。

**修正方向**：在计划中记录此风险，并决定是否采用诊断报告推荐的 `Type(e) == AssertFailException` 检查方式，或明确接受现有模式的风险。
