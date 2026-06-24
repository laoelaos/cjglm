# 详细设计（v10）

## 概述

将 `tests/glm/detail/` 目录下 4 个测试文件中全部 38 处 `@ExpectThrows[Exception](...)` 替换为 `try-catch` 块，在验证异常类型的同时验证异常消息内容为 `"stub"`。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `tests/glm/detail/test_common.cj` | 修改 | 替换 12 个 stub 测试 |
| `tests/glm/detail/test_geometric.cj` | 修改 | 替换 17 个 stub 测试 |
| `tests/glm/detail/test_geometric_refract.cj` | 修改 | 替换 3 个 stub 测试 |
| `tests/glm/detail/test_matrix.cj` | 修改 | 替换 6 个 stub 测试 |

## 类型定义

无新增类型。复用现有：
- `std.unittest.*` — `@Test`, `@Expect`
- `std.unittest.testmacro.*` — `@ExpectThrows` (仅删除)
- `std.Exception` — 异常的基类，`.message` 属性返回构造时传入的字符串

## 替换模式

### 通用模板

替换前：
```cangjie
    @ExpectThrows[Exception](<function_call>)
```

替换后：
```cangjie
    try {
        <function_call>
        @Expect(false, true)
    } catch (e: Exception) {
        @Expect(e.message, "stub")
    }
```

### 文件一：test_common.cj（12 处替换）

| 行号 | 函数 | 替换后的函数体 |
|------|------|---------------|
| `:7-9` | `testMinStub` | `try { min(Float64(1.0), Float64(2.0)); @Expect(false, true) } catch (e: Exception) { @Expect(e.message, "stub") }` |
| `:12-14` | `testMaxStub` | `try { max(Float64(1.0), Float64(3.0)); @Expect(false, true) } catch (e: Exception) { @Expect(e.message, "stub") }` |
| `:17-19` | `testAbsStub` | `try { abs(Float64(-5.0)); @Expect(false, true) } catch (e: Exception) { @Expect(e.message, "stub") }` |
| `:22-24` | `testSignStub` | `try { sign(Float64(-3.0)); @Expect(false, true) } catch (e: Exception) { @Expect(e.message, "stub") }` |
| `:27-29` | `testFloorStub` | `try { floor(Float64(3.7)); @Expect(false, true) } catch (e: Exception) { @Expect(e.message, "stub") }` |
| `:32-34` | `testCeilStub` | `try { ceil(Float64(3.2)); @Expect(false, true) } catch (e: Exception) { @Expect(e.message, "stub") }` |
| `:37-39` | `testFractStub` | `try { fract(Float64(3.7)); @Expect(false, true) } catch (e: Exception) { @Expect(e.message, "stub") }` |
| `:42-44` | `testModStub` | `try { mod(Int64(10), Int64(3)); @Expect(false, true) } catch (e: Exception) { @Expect(e.message, "stub") }` |
| `:47-49` | `testClampStub` | `try { clamp(Float64(5.0), Float64(0.0), Float64(10.0)); @Expect(false, true) } catch (e: Exception) { @Expect(e.message, "stub") }` |
| `:52-54` | `testMixStub` | `try { mix(Float64(1.0), Float64(2.0), Float64(0.5)); @Expect(false, true) } catch (e: Exception) { @Expect(e.message, "stub") }` |
| `:57-59` | `testStepStub` | `try { step(Float64(0.5), Float64(1.0)); @Expect(false, true) } catch (e: Exception) { @Expect(e.message, "stub") }` |
| `:62-64` | `testSmoothstepStub` | `try { smoothstep(Float64(0.0), Float64(1.0), Float64(0.5)); @Expect(false, true) } catch (e: Exception) { @Expect(e.message, "stub") }` |

### 文件二：test_geometric.cj（17 处替换）

| 行号 | 函数 | 替换说明 |
|------|------|---------|
| `:7-11` | `testDotVec1Stub` | try-catch 包裹 `dot(x, y)` |
| `:14-18` | `testDotVec2Stub` | try-catch 包裹 `dot(x, y)` |
| `:21-25` | `testDotVec3Stub` | try-catch 包裹 `dot(x, y)` |
| `:28-32` | `testDotVec4Stub` | try-catch 包裹 `dot(x, y)` |
| `:35-39` | `testCrossStub` | try-catch 包裹 `cross(x, y)` |
| `:42-45` | `testNormalizeVec2Stub` | try-catch 包裹 `normalize(v)` |
| `:48-51` | `testNormalizeVec3Stub` | try-catch 包裹 `normalize(v)` |
| `:54-57` | `testNormalizeVec4Stub` | try-catch 包裹 `normalize(v)` |
| `:60-63` | `testLengthVec2Stub` | try-catch 包裹 `length(v)` |
| `:66-69` | `testLengthVec3Stub` | try-catch 包裹 `length(v)` |
| `:72-75` | `testLengthVec4Stub` | try-catch 包裹 `length(v)` |
| `:78-82` | `testDistanceVec2Stub` | try-catch 包裹 `distance(p0, p1)` |
| `:85-89` | `testDistanceVec3Stub` | try-catch 包裹 `distance(p0, p1)` |
| `:92-96` | `testDistanceVec4Stub` | try-catch 包裹 `distance(p0, p1)` |
| `:99-103` | `testReflectVec2Stub` | try-catch 包裹 `reflect(I, N)` |
| `:106-110` | `testReflectVec3Stub` | try-catch 包裹 `reflect(I, N)` |
| `:113-117` | `testReflectVec4Stub` | try-catch 包裹 `reflect(I, N)` |

> 注意：每个函数中的 `let` 变量声明（如 `let x = ...`）保留在函数体顶部，仅将 `@ExpectThrows[Exception](...)` 调用替换为 try-catch 块。

### 文件三：test_geometric_refract.cj（3 处替换）

| 行号 | 函数 | 替换说明 |
|------|------|---------|
| `:7-11` | `testRefractVec2Stub` | try-catch 包裹 `refract(I, N, 1.5)` |
| `:14-18` | `testRefractVec3Stub` | try-catch 包裹 `refract(I, N, 1.5)` |
| `:21-25` | `testRefractVec4Stub` | try-catch 包裹 `refract(I, N, 1.5)` |

### 文件四：test_matrix.cj（6 处替换，仅限于 `:257-291`）

| 行号 | 函数 | 替换说明 |
|------|------|---------|
| `:258-261` | `testDeterminantMat2x2Stub` | try-catch 包裹 `determinant(m)` |
| `:264-267` | `testDeterminantMat3x3Stub` | try-catch 包裹 `determinant(m)` |
| `:270-273` | `testDeterminantMat4x4Stub` | try-catch 包裹 `determinant(m)` |
| `:276-279` | `testInverseMat2x2Stub` | try-catch 包裹 `inverse(m)` |
| `:282-285` | `testInverseMat3x3Stub` | try-catch 包裹 `inverse(m)` |
| `:288-291` | `testInverseMat4x4Stub` | try-catch 包裹 `inverse(m)` |

> 注意：`test_matrix.cj` 在 `:163-255` 有 T7 新增的 12 个 matrixCompMult/outerProduct 测试，在 `:293-485` 有 T7 后续新增的测试，修改时应仅触及 `:257-291` 范围的 6 个 stub 测试，不干扰其他测试。

## 错误处理

- 不做新的错误处理设计。所有替换后的模式统一使用 `catch (e: Exception)` 捕获异常，以 `@Expect(e.message, "stub")` 验证消息内容。
- `@Expect(false, true)` 在 try 块中作为"未抛出异常"的软失败断言（不抛异常，记录失败后继续执行），避免与 catch 块产生异常互斥。

## 行为契约

1. **import 不变**：所有 4 个文件已导入 `std.unittest.*` 和 `std.unittest.testmacro.*`，无需修改。
2. **函数签名不变**：仅修改函数体，不修改函数名、参数、返回类型或 `@Test` 注解。
3. **缩进风格不变**：与原文件保持一致，使用 4 空格缩进。
4. **`@ExpectThrows` 引用消除**：替换后文件中不再有 `@ExpectThrows` 调用。如该宏未被其他非 stub 测试引用，编译器可能产生未使用导入警告，但当前所有文件的 stub 测试是唯一的 `@ExpectThrows` 使用者，替换后该宏的导入可保留（移除属于优化，非必需）。

## 依赖关系

| 依赖 | 说明 |
|------|------|
| `std.unittest.*` | 提供 `@Test`、`@Expect` — 文件已有 |
| `std.unittest.testmacro.*` | 提供 `@ExpectThrows`（将被删除的引用）— 文件已有 |
| `std.Exception` | 仓颉内置，无需导入 |
| 参考模式 `test_shim_assert.cj:24-26` | 已验证的 `catch (e: Exception) { @Expect(e.message, msg) }` 模式 |
| 规避措施 `test_shim_assert.cj:12-16` | 已验证的 `@Expect(false, true)` 软失败模式 |
