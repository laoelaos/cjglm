# 测试报告（v11）

## 验证结果

测试已存在，与详细设计完全一致，无需追加。

## 测试验证清单

| 测试函数 | 文件 | 状态 | 说明 |
|---------|------|------|------|
| `testMat3x3ColOutOfBounds` | `tests/glm/detail/test_type_mat3x3.cj` | ✅ 已存在 | 使用 `Mat3x3<Int64, Defaultp>(5)`，调用 `col(Int64(3))` 期望抛出 `Exception`，与设计一致 |
| `testMat3x3ColNegative` | `tests/glm/detail/test_type_mat3x3.cj` | ✅ 已存在 | 使用 `Mat3x3<Int64, Defaultp>(5)`，调用 `col(Int64(-1))` 期望抛出 `Exception`，与设计一致 |
| `testMat4x4ColOutOfBounds` | `tests/glm/detail/test_type_mat4x4.cj` | ✅ 已存在 | 使用 `Mat4x4<Int64, Defaultp>(5)`，调用 `col(Int64(4))` 期望抛出 `Exception`，与设计一致 |
| `testMat4x4ColNegative` | `tests/glm/detail/test_type_mat4x4.cj` | ✅ 已存在 | 使用 `Mat4x4<Int64, Defaultp>(5)`，调用 `col(Int64(-1))` 期望抛出 `Exception`，与设计一致 |

## 设计偏差

无偏差。
