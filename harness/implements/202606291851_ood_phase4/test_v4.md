# 测试报告（v1）

## 概述
对 `trigonometric.cj` 的 75 个 public 函数（15 标量 + 60 Vec 重载）编写单元测试。基于详细设计的行为契约，遵循 `exponential_test.cj` / `common_test.cj` 模式。

## 文件变更
| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 删除 | tests/glm/detail/trigonometric_stub_test.cj | 原存根测试（81 行 @ExpectThrows[Exception]），已不再适用 |
| 增强 | tests/glm/detail/trigonometric_test.cj | 从原约 65 个 @Test 扩展至 111 个 @Test，填补 Float32/Float16 标量和 Vec3/Vec4 维度缺口 |

## 测试覆盖矩阵

### 标量（15 函数 × 3 类型 = 45 函数签名）
| 类型 | 覆盖函数数 | 缺漏 |
|------|-----------|------|
| Float64 | 15/15 | 无 |
| Float32 | 15/15 | 无 |
| Float16 | 15/15 | 无 |

### Vec 重载（15 函数 × 4 维度 = 60 函数签名）
| 函数 | Vec1 | Vec2 | Vec3 | Vec4 |
|------|------|------|------|------|
| sin | ✓ | ✓ | ✓ | ✓ |
| cos | ✓ | ✓ | ✓ | ✓ |
| tan | ✓ | ✓ | ✓ | ✓ |
| asin | ✓ | ✓ | ✓ | ✓ |
| acos | ✓ | ✓ | ✓ | ✓ |
| atan | ✓ | ✓ | ✓ | ✓ |
| radians | ✓ | ✓ | ✓ | ✓ |
| degrees | ✓ | ✓ | ✓ | ✓ |
| sinh | ✓ | ✓ | ✓ | ✓ |
| cosh | ✓ | ✓ | ✓ | ✓ |
| tanh | ✓ | ✓ | ✓ | ✓ |
| asinh | ✓ | ✓ | ✓ | ✓ |
| acosh | ✓ | ✓ | ✓ | ✓ |
| atanh | ✓ | ✓ | ✓ | ✓ |
| atan2 | ✓ | ✓ | ✓ | ✓ |

### 边界条件覆盖
- asin(±1) 返回 ±π/2（不抛异常）：✓
- acos(±1) 返回 0/π（不抛异常）：✓
- asin/acos 越界输入（>1 / <-1）返回 NaN：✓（Float64/Float32/Float16 均覆盖）
- atanh(0) 返回 0：✓
- radians(180) ≈ pi：✓
- degrees(pi) ≈ 180：✓

## 行为契约验证
1. 标量版本行为与 std.math 对应函数一致（经 stdmath_shim 委托）：已通过已知值断言验证
2. Vec 版本行为等价于逐分量应用标量版本：已通过逐分量断言验证
3. asin/acos 越界保护：已覆盖 Float64/Float32/Float16 越界输入 → NaN
4. atan2 象限覆盖：已覆盖 (0,1)、(1,0)、(0,-1)、(-1,0) 四个象限

## 总计
111 个 @Test 函数，覆盖全部 75 个 public 函数签名，无覆盖缺口。
