# 任务指令（v5）

## 动作
NEW

## 任务描述
在 `src/detail/type_cast.cj` 中追加 4 个 `castVec3` 重载（Vec1/Vec2/Vec3/Vec4 → Vec3）。在 `type_cast_test.cj` 中追加 Vec3-target 测试用例。

### 新增函数签名

```cangjie
// Vec1→Vec3：单分量 conv(v.x) 填充 xyz
public func castVec3<T, Q, T2, Q2>(v: Vec1<T2, Q2>, conv: (T2) -> T): Vec3<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier {
    Vec3<T, Q>(conv(v.x), conv(v.x), conv(v.x))
}

// Vec2→Vec3：conv(v.x) → x, conv(v.y) → yz
public func castVec3<T, Q, T2, Q2>(v: Vec2<T2, Q2>, conv: (T2) -> T): Vec3<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier {
    Vec3<T, Q>(conv(v.x), conv(v.y), conv(v.y))
}

// Vec3→Vec3：逐分量映射
public func castVec3<T, Q, T2, Q2>(v: Vec3<T2, Q2>, conv: (T2) -> T): Vec3<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier {
    Vec3<T, Q>(conv(v.x), conv(v.y), conv(v.z))
}

// Vec4→Vec3：截取 xyz，丢弃 w
public func castVec3<T, Q, T2, Q2>(v: Vec4<T2, Q2>, conv: (T2) -> T): Vec3<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier {
    Vec3<T, Q>(conv(v.x), conv(v.y), conv(v.z))
}
```

### 转换规则

| 源类型 | 取分量 | 函数体 |
|--------|--------|--------|
| `Vec1<T2, Q2>` | `.x`（单分量填充 xyz） | `Vec3<T, Q>(conv(v.x), conv(v.x), conv(v.x))` |
| `Vec2<T2, Q2>` | `.x`, `.y`（y 扩展到 z） | `Vec3<T, Q>(conv(v.x), conv(v.y), conv(v.y))` |
| `Vec3<T2, Q2>` | `.x`, `.y`, `.z`（逐分量映射） | `Vec3<T, Q>(conv(v.x), conv(v.y), conv(v.z))` |
| `Vec4<T2, Q2>` | `.x`, `.y`, `.z`（截取前三分量） | `Vec3<T, Q>(conv(v.x), conv(v.y), conv(v.z))` |

### 新增测试要求

| 测试函数 | 场景 | 验证点 |
|---------|------|--------|
| `testCastVec3Vec1ToVec3IntToFloat` | Vec1<Int64> → Vec3<Float32> | xyz 均为 `conv(v.x)` 的 Float32 值 |
| `testCastVec3Vec2ToVec3ExtendY` | Vec2<Int64>(10,20) → Vec3<Int64> | x=10, y=20, z=20 |
| `testCastVec3Vec3ToVec3Identity` | Vec3<Int64>(10,20,30) → Vec3<Int64> | x=10, y=20, z=30 |
| `testCastVec3Vec4ToVec3TakesOnlyXYZ` | Vec4<Int64>(10,20,30,40) → Vec3<Int64> | x=10, y=20, z=30（w 丢弃） |
| `testCastVec3SameTypeIdentity` | Vec3<Int64>(7,8,9) → Vec3<Int64>, conv={x=>x} | x=7, y=8, z=9 |
| `testCastVec3Int32ToInt64` | Vec3<Int32> → Vec3<Int64> | 跨整数类型提升 |
| `testCastVec3FloatToIntTruncation` | Vec3<Float32> → Vec3<Int64> | 浮点→整数截断 |
| `testCastVec3CrossQualifierPackedHighpToDefaultp` | Vec3<Int64,PackedHighp> → Vec3<Int64,Defaultp> | 跨 Q 转换 |
| `testCastVec3DoesNotModifySource` | Vec3<Int64> → Vec3<Int64> | 源分量不变 |
| `testCastVec3Vec1ToVec3SameValueAllComponents` | Vec1<Int64> → Vec3<Int64> | xyz 三值相同 |

## 选择理由
R4 已验证 castVec2 模式可编译通过且 332/332 测试通过。Vec3 是下一个目标类型（对应 #14 Vec3 跨类型转换构造函数 + #15 Vec3 多元组合构造函数的一部分）。扩展至 Vec3 无新增技术风险——只需处理 3 个分量，模式与 castVec2 完全相同。

## 任务上下文

### 现有 type_cast.cj（R4）
已有 castVec1（4 个 Vec1-target 重载）+ castVec2（4 个 Vec2-target 重载）。新增 castVec3 为独立函数名，无重载歧义。

### Vec3 构造函数引用
```cangjie
// Vec3<T, Q> 已有
public const init(x: T, y: T, z: T)
public init(scalar: T)
public init(v: Vec1<T, Q>) // x=y=z=v.x
```

### Vec2→Vec3 扩展决策
Vec2→Vec3 时 z 分量取 `conv(v.y)`（扩展 y 到 z），而非取 `conv(v.x)`。原因：y 是 Vec2 的"最后一个分量"，扩展最后一个已知分量比回退到第一个分量更符合直觉（类似于 GLM 中低维→高维的扩展习惯）。此决策与 Vec1→Vec2 时 xy 均取 `conv(v.x)`（扩展 x 到 y）一致。

## 偏差记录要求
与 R3/R4 相同性质。需在 `code_v5.md` 中记录此偏差。

## 重载歧义声明
`castVec3` 为全新函数名，与 `castVec1`/`castVec2` 通过函数名区分，4 个内部重载通过源 Vec 参数类型区分。无任何重载歧义。
