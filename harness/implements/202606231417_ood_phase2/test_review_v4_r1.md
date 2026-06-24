# 测试审查报告（v4 r1）

## 审查结果
REJECTED

## 发现
- **[一般]** `tests/glm/detail/test_type_mat2x3.cj` — 缺失 col() 越界/负索引测试
- **[一般]** `tests/glm/detail/test_type_mat2x4.cj` — 缺失 col() 越界/负索引测试
- **[一般]** `tests/glm/detail/test_type_mat3x2.cj` — 缺失 col() 越界/负索引测试
- **[一般]** `tests/glm/detail/test_type_mat3x4.cj` — 缺失 col() 越界/负索引测试
- **[一般]** `tests/glm/detail/test_type_mat4x2.cj` — 缺失 col() 越界/负索引测试
- **[一般]** `tests/glm/detail/test_type_mat4x3.cj` — 缺失 col() 越界/负索引测试

## 修改要求（仅 REJECTED 时）

每个测试文件都在同一个位置缺失两个测试函数，以 test_type_mat2x3.cj 为例（其余 5 文件同模式）：

**问题**：设计规范明确要求 "col() 取值/越界——参照 Mat2x2 测试"，而 Mat2x2 参考测试包含 `testMat2x2ColOutOfBounds` 和 `testMat2x2ColNegative` 两个用例分别校验 `col(Int64(2))` 和 `col(Int64(-1))` 抛出 Exception。6 个非方阵测试文件当前仅实现了 col() 正常访问测试，缺少越界和负索引异常测试。

**为什么是问题**：col() 方法在无效索引下的错误处理行为未经测试，存在覆盖缺口。若 col() 实现存在缺陷（如不抛异常、返回垃圾数据、访问越界内存），现有测试无法捕获。

**期望的修正方向**：在每个测试文件末尾追加两个测试函数：
- `testMat{N}x{M}ColOutOfBounds`：对长度为 C 的矩阵调用 `m.col(Int64(C))`，捕获 Exception
- `testMat{N}x{M}ColNegative`：调用 `m.col(Int64(-1))`，捕获 Exception

参照模板（以 Mat2x3 为例）：
```cangjie
@Test
func testMat2x3ColOutOfBounds(): Unit {
    let m = Mat2x3<Int64, Defaultp>(5)
    try {
        let _ = m.col(Int64(2))
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}

@Test
func testMat2x3ColNegative(): Unit {
    let m = Mat2x3<Int64, Defaultp>(5)
    try {
        let _ = m.col(Int64(-1))
        @Expect(false, true)
    } catch (_: Exception) {
        @Expect(true, true)
    }
}
```
