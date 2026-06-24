# 测试报告（v15）

## 审查结果

18 个 NaN 传播测试函数已由编码Agent完成写入，全部追加至 `tests/glm/detail/test_matrix.cj`（行 904~1113），与详细设计完全一致。

## 验证清单

### Mat4x4（6 个测试）

| 测试函数 | 场景 | Float32 | Float64 |
|---------|------|:-:|:-:|
| testMat4x4MulVec4NaNCol | NaN 列传播 | ✓ | ✓ |
| testVec4MulMat4x4NaNComp | NaN 向量分量传播 | ✓ | ✓ |
| testMat4x4DiagonalNaNMulVec | NaN 对角矩阵 × 正常向量 | ✓ | ✓ |

### Mat2x3（6 个测试）

| 测试函数 | 场景 | Float32 | Float64 |
|---------|------|:-:|:-:|
| testMat2x3MulVec2NaNCol | NaN 列传播 | ✓ | ✓ |
| testVec3MulMat2x3NaNComp | NaN 向量分量传播 | ✓ | ✓ |
| testMat2x3DiagonalNaNMulVec | NaN 对角矩阵 × 正常向量 | ✓ | ✓ |

### Mat3x2（6 个测试）

| 测试函数 | 场景 | Float32 | Float64 |
|---------|------|:-:|:-:|
| testMat3x2MulVec3NaNCol | NaN 列传播 | ✓ | ✓ |
| testVec2MulMat3x2NaNComp | NaN 向量分量传播 | ✓ | ✓ |
| testMat3x2DiagonalNaNMulVec | NaN 对角矩阵 × 正常向量 | ✓ | ✓ |

## 设计验证

- NaN 生成：`Float32(0.0) / Float32(0.0)` 和 `Float64(0.0) / Float64(0.0)` ✓
- NaN 判别：`@Expect(val != val, true/false)`（IEEE 754 NaN 与自身不等）✓
- 列替换：使用 mut 下标操作符 `m[Int64(i)] = newCol` ✓
- 对角矩阵 NaN 行为：B3 场景 `diagonal(nan)` 全 NaN 矩阵，断言全部 3 个分量为 NaN ✓

## 结论

全部 18 个 NaN 传播测试函数已写入 `test_matrix.cj`，无新 .cj 文件创建，测试风格与项目一致。
