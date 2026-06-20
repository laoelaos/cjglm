# 任务指令（v3）

## 动作
NEW

## 任务描述
新建 `src/detail/type_cast.cj`，在其中定义 4 个 `public func cast` 重载，实现从 `Vec1`/`Vec2`/`Vec3`/`Vec4` 到 `Vec1` 的跨类型分量转换。

## 选择理由
原始方案（在 struct 体内定义 `public init<T2, Q2>(v: VecN<T2, Q2>)`）经 3 轮审议后确认不可实现：
- 仓颉不支持构造函数的独立泛型参数（`init<T2, Q2>` 语法不合法）
- 仓颉不支持 `T(v.x)` 将类型参数作为构造函数调用

本 bypass 方案同时解决两个问题：
- 改用**顶层泛型函数**（而非构造函数）——顶层函数支持独立泛型参数（已验证于 `type_fromBoolVec.cj`）
- 改用**转换闭包参数** `conv: (T2) -> T`——由调用方提供分量值转换逻辑，避免 `T(v.x)` 语法

Vec1 作为最简单的 Vec 类型（单分量），是 cast 模式最直接的验证起点。

## 任务上下文

### 需求来源
`docs/diag/impl/01_diag.md` #9 — Vec1 缺少跨类型转换构造函数。OOD §4.1 要求能从任意 VecN 构造 Vec1（分量类型可不同）。

### 预期 API 签名

```cangjie
// Vec1 → Vec1
public func cast<T, Q, T2, Q2>(v: Vec1<T2, Q2>, conv: (T2) -> T): Vec1<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier

// Vec2 → Vec1（取 .x 分量）
public func cast<T, Q, T2, Q2>(v: Vec2<T2, Q2>, conv: (T2) -> T): Vec1<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier

// Vec3 → Vec1（取 .x 分量）
public func cast<T, Q, T2, Q2>(v: Vec3<T2, Q2>, conv: (T2) -> T): Vec1<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier

// Vec4 → Vec1（取 .x 分量）
public func cast<T, Q, T2, Q2>(v: Vec4<T2, Q2>, conv: (T2) -> T): Vec1<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier
```

### 各函数体

```cangjie
Vec1(conv(v.x))
```

通过 `const init(x: T)` 构造。`conv(v.x)` 返回 T 类型，直接传入构造函数。

### 转换规则

| 源类型 | 取分量 | 转换方式 |
|--------|--------|---------|
| `Vec1<T2, Q2>` | `.x` | `conv(v.x)` |
| `Vec2<T2, Q2>` | `.x`（第一分量） | `conv(v.x)` |
| `Vec3<T2, Q2>` | `.x`（第一分量） | `conv(v.x)` |
| `Vec4<T2, Q2>` | `.x`（第一分量） | `conv(v.x)` |

### 类型设计决策

- **T2 无约束**：`T2` 在签名层面可为任意类型（含 Bool）。`conv` 闭包的类型兼容性由调用方保证，不匹配时编译器报告闭包类型错误（D5 延迟检查）
- **Q2 <: Qualifier**：允许任意 Qualifier 之间的跨 Q 转换
- **函数名 `cast`**：4 个重载通过参数类型 `Vec1<T2,Q2>`/`Vec2<T2,Q2>`/`Vec3<T2,Q2>`/`Vec4<T2,Q2>` 区分，编译器无重载歧义

## 已有代码上下文

### Vec1 当前构造函数
`src/detail/type_vec1.cj:10-12`:
```cangjie
public const init(x: T) {
    this.x = x
}
```

### 已验证的顶层泛型函数模式
`src/detail/type_fromBoolVec.cj:7-8`:
```cangjie
public func fromBoolVecQ2<T, Q, Q2>(v: Vec1<Bool, Q2>, zero: T, one: T): Vec1<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier {
    return Vec1<T, Q>(if (v.x) { one } else { zero })
}
```

### 新文件
需新建 `src/detail/type_cast.cj`，包声明 `package glm.detail`，无额外 import 依赖（`Vec1`/`Vec2`/`Vec3`/`Vec4` 同包可见）。

### 依赖关系
- 依赖 `Vec1`/`Vec2`/`Vec3`/`Vec4` 类型的定义（仅在签名中使用，不依赖内部实现）
- 被依赖方：无（新增函数为纯新增，不影响已有调用代码）
- 测试需在 `src/detail/type_cast_test.cj` 中编写（可选，或追加到 `type_vec1_test.cj`）
