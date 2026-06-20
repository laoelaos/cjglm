# 测试报告（v5）

## 概述

在 `type_cast_test.cj` 中追加 10 个 `castVec3` 测试函数。

## 测试用例

| 测试函数 | 输入 | 断言 |
|---------|------|------|
| `testCastVec3Vec1ToVec3IntToFloat` | Vec1<Int64>(42) | xyz=Float32(42.0) |
| `testCastVec3Vec2ToVec3ExtendY` | Vec2<Int64>(10,20) | x=10, y=20, z=20 |
| `testCastVec3Vec3ToVec3Identity` | Vec3<Int64>(10,20,30) | x=10, y=20, z=30 |
| `testCastVec3Vec4ToVec3TakesOnlyXYZ` | Vec4<Int64>(10,20,30,40) | x=10, y=20, z=30 |
| `testCastVec3SameTypeIdentity` | Vec3<Int64>(7,8,9), conv={x=>x} | x=7, y=8, z=9 |
| `testCastVec3Int32ToInt64` | Vec3<Int32>(99,88,77) | x=Int64(99), y=Int64(88), z=Int64(77) |
| `testCastVec3FloatToIntTruncation` | Vec3<Float32>(3.7,5.2,6.9) | x=3, y=5, z=6 |
| `testCastVec3CrossQualifierPackedHighpToDefaultp` | Vec3<Int64,PackedHighp>(5,6,7) | x=5, y=6, z=7 |
| `testCastVec3DoesNotModifySource` | Vec3<Int64>(42,43,44) | 源不变 |
| `testCastVec3Vec1ToVec3SameValueAllComponents` | Vec1<Int64>(7) | xyz=7 |

## 执行结果

`cjpm test` —— 342/342 PASSED
