# 设计审查报告（v10 r1）

## 审查结果
APPROVED

## 发现

无严重或一般发现。设计核实要点：

- **范围准确**：4 个文件、38 处替换，逐一核对源文件 `@ExpectThrows` 数量（12+17+3+6）与设计文档一致。
- **模板正确**：try-catch 替换模式与 `test_shim_assert.cj:19-26` 已验证的 `catch (e: Exception) { @Expect(e.message, msg) }` 一致。
- **边界清晰**：`test_matrix.cj` 明确限定 `:257-291`，不触及 T7 新增的 `:163-255` 及 `:293-485` 范围。
- **风险已记录**：`@Expect(false, true)` 与 `catch(e: Exception)` 互斥风险已按任务要求记录并给出规避措施。
- **行为契约完整**：import 不变、函数签名不变、缩进风格不变、`@ExpectThrows` 引用消除。
