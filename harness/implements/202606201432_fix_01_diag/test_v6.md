# 测试报告（v6）

## 概述
追加 10 个 `castVec4` 测试。

## 测试用例
| 测试 | 场景 | 断言 |
|------|------|------|
| testCastVec4Vec1ToVec4IntToFloat | Vec1→Vec4 | xyzw=Float32(42.0) |
| testCastVec4Vec2ToVec4ExtendY | Vec2→Vec4 | x=10,y=20,z=20,w=20 |
| testCastVec4Vec3ToVec4ExtendZ | Vec3→Vec4 | x=10,y=20,z=30,w=30 |
| testCastVec4Vec4ToVec4Identity | Vec4→Vec4 | x=10,y=20,z=30,w=40 |
| testCastVec4SameTypeIdentity | identity | x=7,y=8,z=9,w=10 |
| testCastVec4Int32ToInt64 | 跨类型 | Int64 提升 |
| testCastVec4FloatToIntTruncation | 浮点截断 | 截断正确 |
| testCastVec4CrossQualifierPackedHighpToDefaultp | 跨 Q | 值不变 |
| testCastVec4DoesNotModifySource | 不可变性 | 源不变 |
| testCastVec4Vec1ToVec4SameValueAllComponents | Vec1→Vec4 | xyzw 相同 |

## 执行结果
`cjpm test` —— 352/352 PASSED
