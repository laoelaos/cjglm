# 任务指令（v10）

## 动作
NEW

## 任务描述
将 `tests/glm/detail/test_qualifier.cj:29` 中的测试函数 `testPackedHighpCrossAssign` 重命名为 `testPackedQualifierInstantiation`，以准确反映其测试内容（实例化三个 Packed Qualifier 类型）。

## 选择理由
#28 是剩余任务中工作量最小的（单函数重命名），且无外部依赖，适合作为 R10 的首次推进。命名 `testPackedHighpCrossAssign` 具有误导性——函数体仅分别实例化 `PackedHighp`/`PackedMediump`/`PackedLowp`，并未测试任何跨类型赋值行为。重命名后函数名 `testPackedQualifierInstantiation` 准确描述其行为。

## 任务上下文
- 01_diag.md #28：测试名不符实——testPackedHighpCrossAssign 函数名与实际测试内容不匹配
- 文件路径：`tests/glm/detail/test_qualifier.cj`
- 原始声明行 29：`func testPackedHighpCrossAssign(): Unit {`
- 目标声明：`func testPackedQualifierInstantiation(): Unit {`
- 函数体保持不变（3 个局部变量声明 + `@Expect(true, true)`）

## 已有代码上下文
- `tests/glm/detail/test_qualifier.cj` 包含 6 个测试函数，均使用 `@Test` 标注和 `@Expect(true, true)` 断言模式
- 函数 `testPackedHighpCrossAssign` 位于文件末尾（第 28-34 行）
- 同文件中其他测试函数命名遵循 `test{Type}IsQualifier` 或 `test{Feature}` 模式
- `testPackedHighpCrossAssign` 的实际测试行为仅为实例化三个 Qualifier 类型的默认实例，并验证它们不会触发编译错误
- 重命名不会影响测试框架——`@Test` 标注对函数名无约束，仅通过反射发现测试函数
