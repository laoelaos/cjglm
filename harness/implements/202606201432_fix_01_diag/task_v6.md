# 任务指令（v6）

## 动作
NEW

## 任务描述
在 `src/detail/type_cast.cj` 追加 4 个 `castVec4` 重载（Vec1/Vec2/Vec3/Vec4 → Vec4）。在 `type_cast_test.cj` 追加测试。

### 新增函数签名

```cangjie
// Vec1→Vec4：单分量 conv(v.x) 填充 xyzw
public func castVec4<T, Q, T2, Q2>(v: Vec1<T2, Q2>, conv: (T2) -> T): Vec4<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier {
    Vec4<T, Q>(conv(v.x), conv(v.x), conv(v.x), conv(v.x))
}

// Vec2→Vec4：x→x, y→yzw
public func castVec4<T, Q, T2, Q2>(v: Vec2<T2, Q2>, conv: (T2) -> T): Vec4<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier {
    Vec4<T, Q>(conv(v.x), conv(v.y), conv(v.y), conv(v.y))
}

// Vec3→Vec4：x→x, y→y, z→zw
public func castVec4<T, Q, T2, Q2>(v: Vec3<T2, Q2>, conv: (T2) -> T): Vec4<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier {
    Vec4<T, Q>(conv(v.x), conv(v.y), conv(v.z), conv(v.z))
}

// Vec4→Vec4：逐分量映射
public func castVec4<T, Q, T2, Q2>(v: Vec4<T2, Q2>, conv: (T2) -> T): Vec4<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier {
    Vec4<T, Q>(conv(v.x), conv(v.y), conv(v.z), conv(v.w))
}
```

### 测试要求（10 个）

| 测试 | 场景 | 断言 |
|------|------|------|
| `testCastVec4Vec1ToVec4IntToFloat` | Vec1<Int64>→Vec4<Float32> | xyzw=Float32(42.0) |
| `testCastVec4Vec2ToVec4ExtendY` | Vec2<Int64>(10,20)→Vec4<Int64> | x=10, y=20, z=20, w=20 |
| `testCastVec4Vec3ToVec4ExtendZ` | Vec3<Int64>(10,20,30)→Vec4<Int64> | x=10, y=20, z=30, w=30 |
| `testCastVec4Vec4ToVec4Identity` | Vec4<Int64>(10,20,30,40)→Vec4<Int64> | x=10, y=20, z=30, w=40 |
| `testCastVec4SameTypeIdentity` | Vec4<Int64>(7,8,9,10), conv={x=>x} | x=7, y=8, z=9, w=10 |
| `testCastVec4Int32ToInt64` | Vec4<Int32>→Vec4<Int64> | 跨整数提升 |
| `testCastVec4FloatToIntTruncation` | Vec4<Float32>→Vec4<Int64> | 浮点截断 |
| `testCastVec4CrossQualifierPackedHighpToDefaultp` | 跨 Q | 值不变 |
| `testCastVec4DoesNotModifySource` | 源不可变性 | 源不变 |
| `testCastVec4Vec1ToVec4SameValueAllComponents` | Vec1→Vec4 | xyzw 相同 |

## 选择理由
R5 castVec3 模式验证通过（342/342）。Vec4 是最后一个目标类型，完成后 castVec1~castVec4 共 16 个函数覆盖所有 Vec 类型的跨类型转换需求。
