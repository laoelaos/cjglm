# 详细设计（v11）

## 概述

补充 Mat3x3 和 Mat4x4 的 `col()` 方法边界测试（越界索引和负数索引），与已存在的 Mat2x2 `ColOutOfBounds`/`ColNegative` 测试模式一致。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `tests/glm/detail/test_type_mat3x3.cj` | 修改 | 在文件末尾追加 2 个 `@Test` 函数 |
| `tests/glm/detail/test_type_mat4x4.cj` | 修改 | 在文件末尾追加 2 个 `@Test` 函数 |

## 类型定义

无新增类型。仅追加 `@Test` 函数。

## 错误处理

使用 `try-catch (_: Exception)` 模式捕获越界/负数索引时抛出的异常。测试函数预期 `throw` 分支命中。

## 行为契约

### testMat3x3ColOutOfBounds

```
@Test
func testMat3x3ColOutOfBounds(): Unit {
    let m = Mat3x3<Int64, Defaultp>(5)
    try {
        let _ = m.col(Int64(3))
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}
```

- Mat3x3.length() = 3，索引 3 越界
- 预期 `col(Int64(3))` 抛出 `Exception`

### testMat3x3ColNegative

```
@Test
func testMat3x3ColNegative(): Unit {
    let m = Mat3x3<Int64, Defaultp>(5)
    try {
        let _ = m.col(Int64(-1))
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}
```

- 预期 `col(Int64(-1))` 抛出 `Exception`

### testMat4x4ColOutOfBounds

```
@Test
func testMat4x4ColOutOfBounds(): Unit {
    let m = Mat4x4<Int64, Defaultp>(5)
    try {
        let _ = m.col(Int64(4))
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}
```

- Mat4x4.length() = 4，索引 4 越界
- 预期 `col(Int64(4))` 抛出 `Exception`

### testMat4x4ColNegative

```
@Test
func testMat4x4ColNegative(): Unit {
    let m = Mat4x4<Int64, Defaultp>(5)
    try {
        let _ = m.col(Int64(-1))
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}
```

- 预期 `col(Int64(-1))` 抛出 `Exception`

## 依赖关系

- 使用现有 `@Test` 和 `@Expect` 测试框架宏
- 依赖 `Mat3x3<Int64, Defaultp>` / `Mat4x4<Int64, Defaultp>` 的 `col()` 方法和构造函数
- 与已有 `testMat3x3IndexOutOfBounds` / `testMat4x4IndexOutOfBounds` 模式相同，仅将下标 `[]` 换为 `col()`
