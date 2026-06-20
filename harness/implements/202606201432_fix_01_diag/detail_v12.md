# 详细设计（v12）

## 概述

在 `src/detail/shim_limits_test.cj` 末尾追加 4 个测试函数，验证整数类型（Int64, Int32, Int16, Int8）的 `NumericLimits<T>.epsilon(hint)` 返回 `T(0)`。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `src/detail/shim_limits_test.cj` | 追加 | 在第 41 行后追加 4 个新测试函数 |

## 类型定义

本设计不引入新类型。所有测试函数为包级函数，使用现有 `NumericLimits<T>.epsilon(hint)` 静态方法。

## 测试函数设计

所有新函数遵循文件内已有模式：`@Test` 标注，返回 `Unit`，使用 `@Expect(expected, actual)` 断言。

### 测试函数清单

参照 `testNumericLimitsFloat32Epsilon` 模式：

| 函数名 | hint 构造 | 期望值 |
|--------|----------|--------|
| `testNumericLimitsInt64Epsilon` | `Int64(0)` | `Int64(0)` |
| `testNumericLimitsInt32Epsilon` | `Int32(0)` | `Int32(0)` |
| `testNumericLimitsInt16Epsilon` | `Int16(0)` | `Int16(0)` |
| `testNumericLimitsInt8Epsilon` | `Int8(0)` | `Int8(0)` |

### 函数签名模板

```cangjie
@Test
func testNumericLimits{Type}Epsilon(): Unit {
    @Expect(NumericLimits<{Type}>.epsilon({Type}(0)), {Type}(0))
}
```

每个函数调用 `NumericLimits<T>.epsilon(hint)` 并以 `hint - hint` 作为实现（见 `shim_limits.cj:13`），对整数类型返回 `T(0)`。

## 命名约定

遵循 `shim_limits_test.cj` 中已有模式：`testNumericLimits{Type}Epsilon`，所有函数为包级函数（同文件已有函数未显式标注 `public`，包级可见即可被测试框架反射发现）。

## 错误处理

无变更。所有断言使用 `@Expect(expected, actual)` 宏。

## 行为契约

- 每个测试函数独立，无状态依赖
- 测试框架通过 `@Test` 标注反射发现所有测试函数，函数名不影响测试执行顺序或结果
- 所有新测试函数验证 `NumericLimits<T>.epsilon(hint)` 对整数类型的返回值语义：`hint - hint` → `T(0)`

## 依赖关系

- 依赖 `src/detail/shim_limits_test.cj`（已有文件，追加内容）
- 依赖 `src/detail/shim_limits.cj` 中定义的 `NumericLimits<T>.epsilon(hint)` 方法
- 隐式依赖 `std.core` 中的 Int8/Int16/Int32/Int64 类型
- 无新增外部依赖
