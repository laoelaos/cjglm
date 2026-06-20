# 测试报告（v4）

## 测试文件
`src/detail/type_fromBoolVec_test.cj`

## 测试覆盖矩阵

| 行为契约 | 覆盖用例 | 数量 |
|---------|---------|------|
| `fromBoolVec(v, zero, one)` — Vec1~Vec4 每个分量 true→one / false→zero | `testFromBoolVec1`~`testFromBoolVec4`（true/false 混合），`testFromBoolVec3AllFalse`，`testFromBoolVec4AllFalse` | 6 |
| `fromBoolVecQ2(v, zero, one)` — 跨 Q 版本相同转换 | `testFromBoolVecQ2Vec1`~`testFromBoolVecQ2Vec4`，`testFromBoolVecQ2Vec3AllFalse`，`testFromBoolVecQ2Vec4AllFalse` | 6 |
| 调用方传递 `Int64(0)`/`Int64(1)` | 全部 13 处调用均传递 `Int64(0), Int64(1)` | 隐式 |

## 覆盖维度
- **正常路径**: Vec1~Vec4 混合 true/false 输入，验证输出正确性
- **边界条件**: Vec3/Vec4 全 false（所有分量均为零）
- **错误路径**: 不适用（纯函数，无错误状态）
- **状态交互**: 不适用（无状态变更）

## 测试风格
- 使用 `@Test` 属性 + `@Expect` 断言
- 包 `glm.detail`，与源码同目录
- 每个用例独立，不依赖执行顺序

## 设计偏差
无偏差。测试完全对齐详细设计 v4 的行为契约。
