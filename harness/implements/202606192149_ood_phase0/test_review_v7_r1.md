# 测试审查报告（v7 r1）

## 审查结果
REJECTED

## 发现

- **[一般]** `tests/glm/detail/test_scalar_vec_ops.cj:239-248` — `testScalarModVec1ByZero` 使用 try-catch 模式，两个分支均为 `@Expect(true, true)`，构成空断言：无论 mod-by-zero 抛出异常还是正常返回，测试均通过。该测试不会因任何行为变更而失败，无法验证 test_v7.md 声称的"捕获 Exception"行为。
- **[轻微]** `test_v7.md` — 测试用例数量不准确：项目测试文件实际 31 个用例（报告称 29 个），内联测试文件实际 20 个用例（报告称 21 个）。

## 修改要求（仅 REJECTED 时）

### 问题 1（一般）

**位置**: `tests/glm/detail/test_scalar_vec_ops.cj:239-248`，`testScalarModVec1ByZero` 函数

**问题**: 测试体使用如下模式：
```
try {
    let r = mod(Int64(10), v)
    @Expect(true, true)
} catch (_: Exception) {
    @Expect(true, true)
}
```
两个分支均无条件通过，测试永远不会失败。若 mod-by-zero 行为发生回归（例如不再抛出异常），该测试无法检出。

**原因**: 仓颉单元测试框架提供 `@ExpectThrows[ExType](expr)` 宏用于异常场景的精确断言。

**修正方向**: 
方案 A（推荐）：使用 `@ExpectThrows[Exception](mod(Int64(10), Vec1<Int64, Defaultp>(0)))` 替代 try-catch 块。
方案 B（保留 try-catch）：在 try 块中使用 `@Fail("Expected exception")` 或 `@Expect(false, true)`，确保仅在异常被捕获时测试通过。
