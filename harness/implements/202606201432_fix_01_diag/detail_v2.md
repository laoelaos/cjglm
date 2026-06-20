# 详细设计（v2）

## 概述

在 `Vec1<T, Q>` struct 体内追加 4 个跨类型转换构造函数，使 `Vec1` 能从 `Vec1`/`Vec2`/`Vec3`/`Vec4`（任意 T2、Q2）构造。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `src/detail/type_vec1.cj` | 修改 | 在 `public const init(x: T)` 之后追加 4 个跨类型构造函数 |

## 修改规格

### 插入位置

`type_vec1.cj:12`（`public const init(x: T)` 的 `}` 之后）与 `type_vec1.cj:14`（`public static func length()` 之前）之间。

### 追加内容（4 个构造函数）

```cangjie
    public init<T2, Q2>(v: Vec1<T2, Q2>) where Q2 <: Qualifier {
        this.x = T(v.x)
    }

    public init<T2, Q2>(v: Vec2<T2, Q2>) where Q2 <: Qualifier {
        this.x = T(v.x)
    }

    public init<T2, Q2>(v: Vec3<T2, Q2>) where Q2 <: Qualifier {
        this.x = T(v.x)
    }

    public init<T2, Q2>(v: Vec4<T2, Q2>) where Q2 <: Qualifier {
        this.x = T(v.x)
    }
```

### 预期文件结构

```cangjie
@Derive[Hashable]
public struct Vec1<T, Q> where Q <: Qualifier {
    public var x: T

    public const init(x: T) {
        this.x = x
    }

    public init<T2, Q2>(v: Vec1<T2, Q2>) where Q2 <: Qualifier {
        this.x = T(v.x)
    }

    public init<T2, Q2>(v: Vec2<T2, Q2>) where Q2 <: Qualifier {
        this.x = T(v.x)
    }

    public init<T2, Q2>(v: Vec3<T2, Q2>) where Q2 <: Qualifier {
        this.x = T(v.x)
    }

    public init<T2, Q2>(v: Vec4<T2, Q2>) where Q2 <: Qualifier {
        this.x = T(v.x)
    }

    public static func length(): Int64 { 1 }
    // ... 后续内容不变
}
```

## 类型定义

无新增类型。仅对现有 `Vec1<T, Q>` struct 增加构造函数重载。

## 构造函数签名

| # | 签名 | 说明 |
|---|------|------|
| 1 | `public init<T2, Q2>(v: Vec1<T2, Q2>) where Q2 <: Qualifier` | Vec1→Vec1 跨类型转换 |
| 2 | `public init<T2, Q2>(v: Vec2<T2, Q2>) where Q2 <: Qualifier` | Vec2→Vec1 取 `.x` |
| 3 | `public init<T2, Q2>(v: Vec3<T2, Q2>) where Q2 <: Qualifier` | Vec3→Vec1 取 `.x` |
| 4 | `public init<T2, Q2>(v: Vec4<T2, Q2>) where Q2 <: Qualifier` | Vec4→Vec1 取 `.x` |

所有构造函数：
- **非 const 声明**：因 `T(v.x)` 类型转换在 const 上下文中不合法
- **独立 T2 泛型**：与 struct 的 `T` 参数独立，避免类型推导冲突
- **T2 无约束**：签名层面 T2 可为任意类型（含 Bool），`T(v.x)` 编译失败由 D5 延迟检查处理
- **Q2 <: Qualifier**：允许任意 Qualifier 之间的跨 Q 转换

## 跨类型取分量规则

| 源类型 | 取分量 |
|--------|--------|
| `Vec1<T2, Q2>` | `.x` |
| `Vec2<T2, Q2>` | `.x`（第一分量） |
| `Vec3<T2, Q2>` | `.x`（第一分量） |
| `Vec4<T2, Q2>` | `.x`（第一分量） |

## 重载分析

- `const init(x: T)` vs `init<T2, Q2>(v: VecN<T2, Q2>)` — 参数类型 `T` vs `VecN<T2, Q2>`，类型不同，不构成重载歧义
- Vec1 无 `init(scalar: T)` 因与 `const init(x: T)` 重载冲突（参数列表相同，`const` 不构成区分依据）
- 4 个跨类型构造函数之间参数类型不同（`Vec1<T2, Q2>` vs `Vec2<T2, Q2>` vs `Vec3<T2, Q2>` vs `Vec4<T2, Q2>`），不构成重载歧义

## 错误处理

无新增错误处理逻辑。类型转换 `T(v.x)` 在 T2 不兼容时由编译器报告类型错误，为 D5 延迟检查的预期行为。

## 行为契约

- 各构造函数仅读取源 Vec 的 `x` 分量（不修改源 Vec）
- 转换结果等价于 `Vec1(T(v.x))`，即先取源 `.x` 再执行类型转换
- 当 `T2 = Bool`、`T` 为数值类型时，`T(v.x)` 产生编译错误（仓颉不支持 `Int32(Bool)`），由 `fromBoolVec` 工厂函数处理

## 依赖关系

- 依赖：`Vec2`/`Vec3`/`Vec4` 类型（仅在构造函数签名中使用，不依赖其内部实现）
- 被依赖方：无（新增构造函数为纯新增，不影响已有调用代码）

## 验证方式

1. 编译通过：`cjpm build` 成功
2. 测试通过：`cjpm test` 成功，新增的跨类型构造测试全部 PASSED
3. 回归：原有 309 个测试继续 PASSED
