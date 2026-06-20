# 详细设计（v10）

## 概述

将 `tests/glm/detail/test_qualifier.cj:29` 中的测试函数 `testPackedHighpCrossAssign` 重命名为 `testPackedQualifierInstantiation`，以准确反映其实际测试行为（实例化三个 Packed Qualifier 类型：PackedHighp/PackedMediump/PackedLowp）。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `tests/glm/detail/test_qualifier.cj` | 修改 | 重命名第 29 行函数声明 `func testPackedHighpCrossAssign(): Unit` → `func testPackedQualifierInstantiation(): Unit` |

## 操作细节

- **位置**：`tests/glm/detail/test_qualifier.cj:29`（文件末尾，第 28-34 行范围）
- **旧声明**：`func testPackedHighpCrossAssign(): Unit {`
- **新声明**：`func testPackedQualifierInstantiation(): Unit {`
- **函数体**：保持不变（3 个局部变量声明 `high`/`med`/`low` + `@Expect(true, true)`）
- **影响范围**：仅函数名声明行。同文件其他 5 个测试函数（`testPackedHighpIsQualifier`/`testPackedMediumpIsQualifier`/`testPackedLowpIsQualifier`/`testDefaultpIsPackedHighp`）不受影响
- **跨文件引用**：经搜索确认，函数名 `testPackedHighpCrossAssign` 在当前代码库中仅此一处声明，无其他文件引用该函数名（测试框架通过反射发现测试函数，不依赖名称字符串匹配）

## 命名约定

遵循同文件中已有的测试命名模式 `test{Feature}`，新名称 `testPackedQualifierInstantiation` 准确反映函数体仅实例化三个 Qualifier 类型的行为。

## 错误处理

无变更。`@Expect(true, true)` 行为不变。

## 行为契约

- 重命名前后运行时行为完全等价：`@Test` 标注使函数被测试框架反射发现，重命名不影响发现机制
- 测试函数体保持不变，断言语义不变

## 依赖关系

- 无新增依赖
- 无外部消费者依赖此函数名

## 偏差文档更新

无需更新。此变更为测试函数重命名，不涉及 API 行为变更，与 `deviations.md` 中记录的偏差无关。
