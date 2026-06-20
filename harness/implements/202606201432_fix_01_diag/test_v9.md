# 测试报告（v9）

## 概述

与实现 Agent 同步写入，在 2 个测试文件中追加 12 个浮点模运算正向测试和 6 个边界测试，覆盖 Float32/Float64/Float16 × Vec1/Vec2/Vec3/Vec4。测试代码与详细设计规格一致。

## 文件变更清单

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 修改 | `src/detail/scalar_vec_ops_test.cj` | 追加 12 个浮点模正向测试（每个浮点类型 × Vec 维度各 1 个） |
| 修改 | `tests/glm/detail/test_scalar_vec_ops.cj` | 追加 12 个正向测试 + 6 个边界测试 |

## 测试内容

### `src/detail/scalar_vec_ops_test.cj` — 正向测试（12 个）

使用 `Defaultp` 限定符，测试标量对各维度的 fmod 结果：

- **Float32 组**：`testScalarModVec{1,2,3,4}Float32` — 被除数 7.5，除数向量 {2.5, 3.0, 4.0, 5.0}
- **Float64 组**：`testScalarModVec{1,2,3,4}Float64` — 同上，使用 Float64 类型
- **Float16 组**：`testScalarModVec{1,2,3,4}Float16` — 同上，使用 Float16 类型

### `tests/glm/detail/test_scalar_vec_ops.cj` — 正向测试 + 边界测试

**正向测试（12 个）**：同 `scalar_vec_ops_test.cj` 的 12 个正向测试函数。

**边界测试（6 个）**：

| 函数名 | 场景 | 预期 |
|--------|------|------|
| `testScalarModVec1Float32ByZero` | 除数 = 0 | `@ExpectThrows[IllegalArgumentException]` |
| `testScalarModVec1Float32Negative` | 被除数 = -7.5 | 结果 = -0.0（fmod 保留被除数符号） |
| `testScalarModVec1Float32InfDividend` | 被除数 = Inf | `@ExpectThrows[IllegalArgumentException]` |
| `testScalarModVec1Float64ByZero` | 除数 = 0（Float64） | `@ExpectThrows[IllegalArgumentException]` |
| `testScalarModVec1Float16ByZero` | 除数 = 0（Float16） | `@ExpectThrows[IllegalArgumentException]` |
| `testScalarModVec1Float16InfDividend` | 被除数 = Inf（Float16） | `@ExpectThrows[IllegalArgumentException]` |

## 测试组织

- 所有测试函数使用 `@Test` 标注，遵循 `testScalarModVec{N}{FloatType}` 命名模式
- `src/detail/scalar_vec_ops_test.cj` 位于包内测试目录，与被测文件并列
- `tests/glm/detail/test_scalar_vec_ops.cj` 位于项目测试目录
- 正向测试覆盖每个浮点类型 × Vec 维度组合
- 边界测试覆盖除零、负操作数、Inf 被除数三种异常/边界场景
- 每个行为契约至少一个正向用例

## 偏差说明

无偏差。测试覆盖与详细设计规格完全一致。
