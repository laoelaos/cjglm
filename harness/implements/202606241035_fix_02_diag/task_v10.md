# 任务指令（v10）

## 动作
NEW

## 任务描述
T10: 补充 stub 异常信息内容验证

在以下四个 stub 测试文件中，将全部 38 个 `@ExpectThrows[Exception](...)` 替换为 try-catch 块，同时验证异常消息内容为 `"stub"`：

1. **`tests/glm/detail/test_common.cj`**（12 个测试：min/max/abs/sign/floor/ceil/fract/mod/clamp/mix/step/smoothstep）
2. **`tests/glm/detail/test_geometric.cj`**（17 个测试：dot×4/cross/normalize×3/length×3/distance×3/reflect×3）
3. **`tests/glm/detail/test_geometric_refract.cj`**（3 个测试：refract×3）
4. **`tests/glm/detail/test_matrix.cj`**（6 个测试：determinant Mat2x2/Mat3x3/Mat4x4，inverse Mat2x2/Mat3x3/Mat4x4，位于 `:257-291`）

替换模式（每个测试函数）：
```cangjie
// 之前：
@Test
func testMinStub(): Unit {
    @ExpectThrows[Exception](min(Float64(1.0), Float64(2.0)))
}

// 之后：
@Test
func testMinStub(): Unit {
    try {
        min(Float64(1.0), Float64(2.0))
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
}
```

### ⚠ `@Expect(false, true)` 与 `catch(e: Exception)` 互斥风险说明

**风险描述**：若被测 stub 函数未来被实现后不再抛出异常，则 `try` 块中 `@Expect(false, true)` 可能触发断言失败异常（如 `AssertFailException`）。该异常继承自 `Exception`，会被 `catch(e: Exception)` 捕获，导致 `@Expect(e.message, "stub")` 以"消息不匹配"而非"未抛出异常"的方式失败，产生误导性错误消息。

**规避措施**：当前采用 `@Expect(false, true)`（软失败，记录失败后继续执行，不抛出异常）而非 `@Fail`（强制停止，可能抛异常），已在 `test_shim_assert.cj:12-16` 验证此模式正常工作。若未来需要更强的区分，可在 catch 块首行检查 `e.message != "stub"` 时重新抛出异常。

参考文件：`tests/glm/detail/test_shim_assert.cj:19-26`

## 选择理由
Route 表格顺序中的下一个待完成任务。T9 已验证 PASSED，T10 与 T9 共享同一组文件，先于后续任务完成以避免合并冲突。

## 任务上下文
- 所有 stub 实现均 `throw Exception("stub")`，当前仅用 `@ExpectThrows[Exception]` 验证异常类型
- 诊断要求补充异常消息内容验证（Verify exception message matches "stub"）
- `test_shim_assert.cj:24-26` 已提供已验证的异常消息验证模式

## 已有代码上下文
- `test_common.cj` — 12 个 `@ExpectThrows[Exception]` 测试，已导入 `std.unittest.*` 和 `std.unittest.testmacro.*`
- `test_geometric.cj` — 17 个 `@ExpectThrows[Exception]` 测试，已导入 `std.unittest.*` 和 `std.unittest.testmacro.*`
- `test_geometric_refract.cj` — 3 个 `@ExpectThrows[Exception]` 测试，已导入 `std.unittest.*` 和 `std.unittest.testmacro.*`
- `test_matrix.cj:257-291` — 6 个 `@ExpectThrows[Exception]` 测试（determinant×3, inverse×3），已导入 `std.unittest.*` 和 `std.unittest.testmacro.*`
- 引用模式来自 `test_shim_assert.cj:19-26` 的 `catch (e: Exception) { @Expect(e.message, msg) }` 结构
- Exception 的 `.message` 属性返回构造时传入的字符串（即 `"stub"`）

## 实现约束
- 保留现有测试函数名称和 `@Test` 注解不变
- 仅替换函数体，不改动 import、package 或其他内容
- 遵循现有代码风格：`@Expect(false, true)` 作为"未抛出异常"的失败断言
- `test_matrix.cj` 的 6 个 stub 位于 `:257-291`，须注意不破坏 T7 在 `:163-255` 新增的 12 个 matrixCompMult/outerProduct 测试

## 修订说明（v10 r1）
| 审查意见 | 修改措施 |
|---------|---------|
| T10 范围遗漏：test_matrix.cj 的 6 个 stub 测试未被纳入 | 将 `test_matrix.cj:257-291`（6 个 determinant/inverse stub）纳入 T10，更新涉及文件列表为 4 文件，总测试数更新为 12+17+3+6=38 |
| @Expect/@Fail 与 catch 互斥风险未记录 | 在替换模式说明后添加"互斥风险说明"段落，记录风险描述和当前采用的规避措施（使用 `@Expect(false, true)` 软失败而非 `@Fail`） |
