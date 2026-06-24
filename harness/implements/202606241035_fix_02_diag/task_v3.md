# 任务指令（v3）

## 动作
NEW

## 任务描述
在 `test_matrix.cj` 末尾追加 12 个 `@Test` 函数，覆盖 `matrixCompMult`（6 个缺失非方阵类型）和 `outerProduct`（6 个缺失向量组合），仅 Int64 类型：

### matrixCompMult（缺失 6 个）
| 测试函数 | 矩阵构造 | 预期值 |
|---------|---------|--------|
| `testMatrixCompMultMat2x4` | x=Mat2x4(1,2,3,4,5,6,7,8), y=Mat2x4(2,3,4,5,6,7,8,9) | 逐元素乘积 |
| `testMatrixCompMultMat3x2` | x=Mat3x2(1,2,3,4,5,6), y=Mat3x2(2,3,4,5,6,7) | 逐元素乘积 |
| `testMatrixCompMultMat3x3` | x=Mat3x3(1,2,3,4,5,6,7,8,9), y=Mat3x3(1,1,1,1,1,1,1,1,1) | 保持 x 值 |
| `testMatrixCompMultMat3x4` | x=Mat3x4(1..12), y=Mat3x4(1,1,1,1,1,1,1,1,1,1,1,1) | 保持 x 值 |
| `testMatrixCompMultMat4x2` | x=Mat4x2(1..8), y=Mat4x2(2,3,4,5,6,7,8,9) | 逐元素乘积 |
| `testMatrixCompMultMat4x3` | x=Mat4x3(1..12), y=Mat4x3(1,1,1,1,1,1,1,1,1,1,1,1) | 保持 x 值 |

### outerProduct（缺失 6 个）
| 测试函数 | 向量参数 | 预期值 |
|---------|---------|--------|
| `testOuterProductVec2Vec3` | c=Vec2(2,3), r=Vec3(5,7,11) | 外积 → Mat3x2 |
| `testOuterProductVec2Vec4` | c=Vec2(2,3), r=Vec4(5,7,11,13) | 外积 → Mat4x2 |
| `testOuterProductVec3Vec3` | c=Vec3(2,3,5), r=Vec3(7,11,13) | 外积 → Mat3x3 |
| `testOuterProductVec3Vec4` | c=Vec3(2,3,5), r=Vec4(7,11,13,17) | 外积 → Mat4x3 |
| `testOuterProductVec4Vec2` | c=Vec4(1,2,3,4), r=Vec2(5,7) | 外积 → Mat2x4 |
| `testOuterProductVec4Vec3` | c=Vec4(1,2,3,4), r=Vec3(5,7,11) | 外积 → Mat3x4 |

## 选择理由
覆盖率缺口 > 66%，T6（非方阵标量-矩阵测试）已 PASSED，T7 是 Route 表格中优先级最高的下一个覆盖率缺口修复。

## 任务上下文
- **待修改文件**: `cjglm/tests/glm/detail/test_matrix.cj`（追加到末尾）
- **现有 matrixCompMult 测试**: Mat2x2(L163)、Mat2x3(L174)、Mat4x4(L187) — 缺 6 个
- **现有 outerProduct 测试**: Vec2Vec2(L210)、Vec3Vec2(L221)、Vec4Vec4(L234) — 缺 6 个
- **实现参考**: `src/detail/matrix.cj:41-165`（所有 9 个 matrixCompMult + 9 个 outerProduct 重载已实现）
- **类型**: 仅 Int64，Float 变体推迟至 T16
- **断言模式**: `@Expect(r.cN.{x,y,z,w}, expected)`，列优先逐分量
