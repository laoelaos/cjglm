# 任务指令（v11）

## 动作
NEW

## 任务描述
T14: 补充 Mat3x3/Mat4x4 的 ColOutOfBounds/ColNegative 测试

在 `test_type_mat3x3.cj` 和 `test_type_mat4x4.cj` 中各追加 2 个 `@Test` 函数：
- `testMat3x3ColOutOfBounds` / `testMat3x3ColNegative`（追加到 `test_type_mat3x3.cj` 末尾）
- `testMat4x4ColOutOfBounds` / `testMat4x4ColNegative`（追加到 `test_type_mat4x4.cj` 末尾）

共 4 个测试函数，仅 Int64 类型。

## 选择理由
Route 表格顺序中的下一个待完成任务。T14 在 Phase 4 Group A（独立文件，可并行），操作 `test_type_mat3x3.cj` 和 `test_type_mat4x4.cj`，与其它未完成任务的涉及文件无冲突。

## 任务上下文
- 诊断报告 §4 T14 精确定位：7 个矩阵测试文件已有 ColOutOfBounds/ColNegative 测试，仅 Mat3x3 和 Mat4x4 缺失
- `test_type_mat2x2.cj:88-107` 提供已验证的参考模式：

```cangjie
@Test
func testMat2x2ColOutOfBounds(): Unit {
    let m = Mat2x2<Int64, Defaultp>(5)
    try {
        let _ = m.col(Int64(2))
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}

@Test
func testMat2x2ColNegative(): Unit {
    let m = Mat2x2<Int64, Defaultp>(5)
    try {
        let _ = m.col(Int64(-1))
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}
```

- Mat3x3 的 `.length()` = 3，越界索引为 `Int64(3)`；Mat4x4 的 `.length()` = 4，越界索引为 `Int64(4)`
- `col(i)` 委托 `this[i]` 实现，越界行为与 `[]` 一致

## 已有代码上下文
- `test_type_mat3x3.cj` 已有 `testMat3x3IndexOutOfBounds`（`:89-97`）和 `testMat3x3NegativeIndex`（`:100-108`），但缺少 `Col` 系列
- `test_type_mat4x4.cj` 已有 `testMat4x4IndexOutOfBounds`（`:120-128`）和 `testMat4x4NegativeIndex`（`:131-139`），但缺少 `Col` 系列
- 新测试追加到各文件末尾（`test_type_mat3x3.cj` 末尾约 `:620`，`test_type_mat4x4.cj` 末尾约 `:904`），避免行号冲突
