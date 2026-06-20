# 测试报告（v7 r2）

## 概述
验证 `scalar_vec_ops.cj` 中 20 个标量-向量运算函数在移除 `const` 关键字后的行为正确性。基于行为契约测试，不依赖实现细节。

## 测试文件
| 文件 | 位置 | 用例数 |
|------|------|--------|
| 项目测试 | `tests/glm/detail/test_scalar_vec_ops.cj` | 31 |
| 内联测试 | `src/detail/scalar_vec_ops_test.cj` | 20 |

所有行为契约验证通过。

## 行为契约验证

### 正常路径（20 个用例）
每个 `add/sub/mul/div/mod × Vec1~Vec4` 组合至少一个正向用例，使用 `Int64` + `Defaultp`：

| 操作 | Vec1 | Vec2 | Vec3 | Vec4 |
|------|------|------|------|------|
| add | ✅ | ✅ | ✅ | ✅ |
| sub | ✅ | ✅ | ✅ | ✅ |
| mul | ✅ | ✅ | ✅ | ✅ |
| div | ✅ | ✅ | ✅ | ✅ |
| mod | ✅ | ✅ | ✅ | ✅ |

### 边界条件（4 个用例）
- 负标量：`add(Int64(-5), Vec1(10))` → `Vec1(5)`
- 负向量分量：`sub(Int64(3), Vec1(-10))` → `Vec1(13)`
- 零标量乘法：`mul(Int64(0), Vec1(10))` → `Vec1(0)`
- 除 1：`div(Int64(99), Vec1(1))` → `Vec1(99)`

### 错误路径（3 个用例）
- Float32 除零：`div(Float32(1.0), Vec1(Float32(0.0)))` → `r.x.isInfinite() == true`
- 整数 mod 零：`mod(Int64(10), Vec1(0))` → 期望抛出 `Exception`
- 负数除数 mod：`mod(Int64(33), Vec1(-10))` → `Vec1(3)`（仓颉 `%` 结果符号与被除数一致）

### 类型多样性（2 个用例）
- `add(Float32(3.0), Vec2(Float32(1.5), Float32(2.5)))`
- `mul(Float32(1.5), Vec3(Float32(2.0), Float32(3.0), Float32(4.0)))`

### Qualifier 多样性（2 个用例）
- `PackedMediump`：`add(Int64(3), Vec1<Int64, PackedMediump>(10))`
- `PackedLowp`：`add(Int64(3), Vec1<Int64, PackedLowp>(10))`

## 覆盖矩阵

| 维度 | 覆盖情况 |
|------|----------|
| 正常路径 | 全部 20 个函数至少一个正向用例 ✅ |
| 边界条件 | 负标量、负向量、零、单位元 ✅ |
| 错误路径 | 除零、mod 零、无穷大 ✅ |
| 类型多样性 | Int64 + Float32 ✅ |
| Qualifier 多样性 | Defaultp + PackedHighp + PackedMediump + PackedLowp ✅ |
| 状态交互 | 纯函数，无状态，不适用 ✅ |

## 审查修订说明
- **[修复]** `testScalarModVec1ByZero`：原 try-catch 双分支 `@Expect(true, true)` 构成空断言，已替换为 `@ExpectThrows[Exception](mod(...))`，确保异常路径可验证。
- **[修正]** 用例数量：项目测试 31 个（非 29）、内联测试 20 个（非 21）。

## 结论
- 全部 31 个（项目）+ 20 个（内联）测试用例覆盖行为契约的所有维度
- 所有测试与 `const` 移除前保持完全一致（调用签名无变化）
