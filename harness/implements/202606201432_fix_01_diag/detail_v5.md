# 详细设计（v5）

## 概述

在 `src/detail/type_cast.cj` 中追加 4 个 `castVec3` 重载（Vec1/Vec2/Vec3/Vec4 → Vec3），在 `type_cast_test.cj` 中追加 10 个 Vec3-target 测试。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `src/detail/type_cast.cj` | 追加 | 新增 4 个 `castVec3` 重载 |
| `src/detail/type_cast_test.cj` | 追加 | 新增 10 个 Vec3-target 测试函数 |

## 类型定义

无新增类型。仅新增 4 个顶层泛型函数重载。

## 函数签名

### castVec3（新增）

**形态**：顶层函数
**包路径**：`glm.detail`
**职责**：Vec1/Vec2/Vec3/Vec4 → Vec3 跨类型分量转换

```cangjie
public func castVec3<T, Q, T2, Q2>(v: Vec1<T2, Q2>, conv: (T2) -> T): Vec3<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier
// 函数体：Vec3<T, Q>(conv(v.x), conv(v.x), conv(v.x))

public func castVec3<T, Q, T2, Q2>(v: Vec2<T2, Q2>, conv: (T2) -> T): Vec3<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier
// 函数体：Vec3<T, Q>(conv(v.x), conv(v.y), conv(v.y))

public func castVec3<T, Q, T2, Q2>(v: Vec3<T2, Q2>, conv: (T2) -> T): Vec3<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier
// 函数体：Vec3<T, Q>(conv(v.x), conv(v.y), conv(v.z))

public func castVec3<T, Q, T2, Q2>(v: Vec4<T2, Q2>, conv: (T2) -> T): Vec3<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier
// 函数体：Vec3<T, Q>(conv(v.x), conv(v.y), conv(v.z))
```

## 转换规则

| 源类型 | 目标类型 | 取分量 | 函数体 |
|--------|---------|--------|--------|
| `Vec1<T2, Q2>` | `Vec3<T, Q>` | `.x` 单分量填充 xyz | `Vec3<T, Q>(conv(v.x), conv(v.x), conv(v.x))` |
| `Vec2<T2, Q2>` | `Vec3<T, Q>` | `.x`→x, `.y`→yz（y 扩展到 z） | `Vec3<T, Q>(conv(v.x), conv(v.y), conv(v.y))` |
| `Vec3<T2, Q2>` | `Vec3<T, Q>` | `.x`, `.y`, `.z` 逐分量映射 | `Vec3<T, Q>(conv(v.x), conv(v.y), conv(v.z))` |
| `Vec4<T2, Q2>` | `Vec3<T, Q>` | `.x`, `.y`, `.z` 截取前三 | `Vec3<T, Q>(conv(v.x), conv(v.y), conv(v.z))` |

## 重载分析

- 4 个 `castVec3` 之间通过参数类型区分，无歧义
- `castVec3` 与 `castVec1`/`castVec2` 通过函数名区分，无歧义
- 共 12 个函数（castVec1×4 + castVec2×4 + castVec3×4）共存于 `glm.detail`，函数名+参数类型组合唯一

## 测试设计

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
| `testCastVec3Vec1ToVec3SameValueAllComponents` | Vec1<Int64>(7) | x=7, y=7, z=7 |
