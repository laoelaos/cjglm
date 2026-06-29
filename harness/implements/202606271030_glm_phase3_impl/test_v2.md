# 测试报告（v2）

## 测试清单

### test_type_quat.cj
| 测试函数 | 验证点 | 设计契约 |
|---------|--------|---------|
| testQuatConstruct | 逐分量构造 `Quat(1,2,3,4)` → (1,2,3,4) | 主构造函数行为 |
| testQuatScalarVecConstruct | 标量+Vec3 构造 `Quat(1.0, Vec3(2.0,3.0,4.0))` → w=1.0,x=2.0,y=3.0,z=4.0 | init(s, v) 行为 |
| testQuatFromQual | 跨 Qualifier 工厂 `fromQual<Defaultp>` → 分量不变 | 跨 Qualifier 工厂 |
| testQuatIdentity | `identity(1)` → (0,0,0,1) | 单位四元数工厂 |
| testQuatWxyz | `wxyz(1,2,3,4)` → (2,3,4,1) | w 在前工厂 |
| testQuatFromQuat | Float64→Float32 跨类型转换 | fromQuat 工厂 |
| testQuatLength | `length()` → 4 | 编译期常量 |
| testQuatIndex | `[0]`~`[3]` 下标取值 | 下标读取 |
| testQuatIndexMut | `[1]=99` 下标赋值 | 下标写入 |
| testQuatAdd | 四元数加法 | 算术运算 |
| testQuatSub | 四元数减法 | 算术运算 |
| testQuatMul | Hamilton 乘积 | 算术运算 |
| testQuatDiv | conjugate+dot 除法 | 算术运算 |
| testQuatNeg | 一元否定 | 算术运算 |
| testQuatEq | `==` 相等比较 | 比较运算 |
| testQuatNeq | `!=` 不等比较 | 比较运算 |
| testQuatMulScalar | `* T` 标量乘 | 算术运算 |
| testQuatDivScalar | `/ T` 标量除 | 算术运算 |
| testQuatFromMat3RoundTrip | 单位四元数→fromMat3→quatCast 往返 | 矩阵-四元数互转 |
| testQuatFromMat4RoundTrip | 单位四元数→fromMat4→mat4Cast 往返 | 矩阵-四元数互转 |
| testQuatFromMat3NonIdentityRoundTrip | 非单位四元数→fromMat3→quatCast 往返 | 矩阵-四元数互转 |
| testQuatBoolEq | Bool 四元数 `==` | Bool 类型比较 |
| testQuatBoolNeq | Bool 四元数 `!=` | Bool 类型比较 |
| testQuatIndexOutOfBounds | 下标越界 `[-1]` `[4]` → Exception | bounds check |
| testQuatIndexMutOutOfBounds | 赋值下标越界 → Exception | bounds check |
| testQuatVec3Stub | Quat×Vec3 → Exception("stub") | stub 函数 |
| testQuatVec4Stub | Quat×Vec4 → Exception("stub") | stub 函数 |
| testVec3QuatStub | Vec3×Quat → Exception("stub") | stub 函数 |
| testVec4QuatStub | Vec4×Quat → Exception("stub") | stub 函数 |
| testQuatValueSemantics | `a+b` 不修改源操作数 | 值语义 |

### test_type_quat_cast.cj
| 测试函数 | 验证点 | 设计契约 |
|---------|--------|---------|
| testMat3CastIdentityQuat | 单位四元数→单位矩阵 | mat3Cast 正向 |
| testQuatCastMat3RoundTrip | quatCast(mat3)→mat3Cast 往返 | 往返一致性 |
| testMat4CastIdentityQuat | 单位四元数→单位4×4矩阵 | mat4Cast 正向 |
| testQuatCastMat4RoundTrip | quatCast(mat4)→mat4Cast 往返 | 往返一致性 |
| testMat3CastNonIdentityQuat | 非单位四元数→矩阵→quatCast 往返 | 非单位往返 |
| testMat4CastNonIdentityQuat | 非单位四元数 → 4×4 矩阵验证 | 矩阵结构正确性 |
| testQuatCastNonIdentityMat3RoundTrip | 非平凡旋转 quatCast(Mat3x3) 往返 | 非平凡往返 |
| testQuatCastNonIdentityMat4RoundTrip | 非平凡旋转 quatCast(Mat4x4) 往返 | 非平凡往返 |

### test_scalar_quat_ops.cj
| 测试函数 | 验证点 | 设计契约 |
|---------|--------|---------|
| testScalarAddQuat | `add(3, q)` 分量验证 | 标量加 |
| testScalarSubQuat | `sub(3, q)` 分量验证 | 标量减 |
| testScalarMulQuat | `mul(5, q)` 分量验证 | 标量乘 |
| testScalarDivQuat | `div(60, q)` 分量验证 | 标量除 |
| testScalarAddQuatFloat64 | Float64 标量加 | 浮点支持 |
| testScalarSubQuatNegative | 负数标量减 | 负数边界 |
| testScalarMulQuatZero | 零标量乘 | 零边界 |
| testScalarDivQuatByOne | 标量除分量全 1 | 除单位分量 |
| testScalarDivQuatFloatByZero | 浮点除零 → Inf | 浮点除零 |

## 修订说明（v2 R1）

| 审查意见 | 修改措施 |
|---------|---------|
| [严重] testQuatFromMat3NonIdentityRoundTrip 依赖三角函数 stub（sin/cos 运行时抛 Exception） | 改用显式 Float64 字面量 `(0.2, 0.3, 0.4, 0.8)` 构造非恒等四元数，消除对三角函数的依赖 |
| [严重] testMat3CastNonIdentityQuat 依赖三角函数 stub | 同上，改用显式 Float64 字面量 |
| [严重] testMat4CastNonIdentityQuat 依赖三角函数 stub | 同上，改用显式 Float64 字面量 |

## 覆盖维度
- **正常路径**: 构造、工厂、算术、比较、转换 ✅
- **边界条件**: 下标越界、零乘、除一、负数 ✅
- **错误路径**: stub Exception、下标越界 Exception、浮点除零 ✅
- **状态交互**: fromMat3/fromMat4/quatCast 往返验证 ✅
- **类型变体**: Bool、Int64、Float64、Float64→Float32 跨类型转换 ✅
