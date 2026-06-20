# 详细设计（v6）

## 概述
追加 4 个 `castVec4` 重载（Vec1/Vec2/Vec3/Vec4 → Vec4）。

## 文件规划
| 文件 | 操作 | 职责 |
|------|------|------|
| `src/detail/type_cast.cj` | 追加 | 4 个 `castVec4` 重载 |
| `src/detail/type_cast_test.cj` | 追加 | 10 个测试 |

## 函数签名

```cangjie
public func castVec4<T, Q, T2, Q2>(v: Vec1<T2, Q2>, conv: (T2) -> T): Vec4<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier
// Vec4<T, Q>(conv(v.x), conv(v.x), conv(v.x), conv(v.x))

public func castVec4<T, Q, T2, Q2>(v: Vec2<T2, Q2>, conv: (T2) -> T): Vec4<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier
// Vec4<T, Q>(conv(v.x), conv(v.y), conv(v.y), conv(v.y))

public func castVec4<T, Q, T2, Q2>(v: Vec3<T2, Q2>, conv: (T2) -> T): Vec4<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier
// Vec4<T, Q>(conv(v.x), conv(v.y), conv(v.z), conv(v.z))

public func castVec4<T, Q, T2, Q2>(v: Vec4<T2, Q2>, conv: (T2) -> T): Vec4<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier
// Vec4<T, Q>(conv(v.x), conv(v.y), conv(v.z), conv(v.w))
```

## 转换规则
| 源 | 取分量 | 函数体 |
|----|--------|--------|
| Vec1 | x 填充全部 | `Vec4<T, Q>(conv(v.x), conv(v.x), conv(v.x), conv(v.x))` |
| Vec2 | x→x, y→yzw | `Vec4<T, Q>(conv(v.x), conv(v.y), conv(v.y), conv(v.y))` |
| Vec3 | x→x, y→y, z→zw | `Vec4<T, Q>(conv(v.x), conv(v.y), conv(v.z), conv(v.z))` |
| Vec4 | 逐分量映射 | `Vec4<T, Q>(conv(v.x), conv(v.y), conv(v.z), conv(v.w))` |
