# 详细设计（v3）

## 概述

在 `src/detail/type_cast.cj` 中定义 4 个 `public func cast` 重载，实现从 `Vec1`/`Vec2`/`Vec3`/`Vec4` 到 `Vec1` 的跨类型分量转换，替代不可实现的构造函数方案。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `src/detail/type_cast.cj` | 新建 | 定义 4 个 `cast` 重载，包声明 `package glm.detail` |

## 类型定义

无新增类型。仅新增 4 个顶层泛型函数重载。

## 函数签名

### cast(v: Vec1\<T2, Q2\>)

**形态**：顶层函数
**包路径**：`glm.detail`
**职责**：Vec1→Vec1 跨类型分量转换

```cangjie
public func cast<T, Q, T2, Q2>(v: Vec1<T2, Q2>, conv: (T2) -> T): Vec1<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier
```

**函数体**：`Vec1<T, Q>(conv(v.x))`

---

### cast(v: Vec2\<T2, Q2\>)

```cangjie
public func cast<T, Q, T2, Q2>(v: Vec2<T2, Q2>, conv: (T2) -> T): Vec1<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier
```

**函数体**：`Vec1<T, Q>(conv(v.x))`

---

### cast(v: Vec3\<T2, Q2\>)

```cangjie
public func cast<T, Q, T2, Q2>(v: Vec3<T2, Q2>, conv: (T2) -> T): Vec1<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier
```

**函数体**：`Vec1<T, Q>(conv(v.x))`

---

### cast(v: Vec4\<T2, Q2\>)

```cangjie
public func cast<T, Q, T2, Q2>(v: Vec4<T2, Q2>, conv: (T2) -> T): Vec1<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier
```

**函数体**：`Vec1<T, Q>(conv(v.x))`

## 转换规则

| 源类型 | 取分量 | 函数体 |
|--------|--------|--------|
| `Vec1<T2, Q2>` | `.x` | `Vec1<T, Q>(conv(v.x))` |
| `Vec2<T2, Q2>` | `.x`（第一分量） | `Vec1<T, Q>(conv(v.x))` |
| `Vec3<T2, Q2>` | `.x`（第一分量） | `Vec1<T, Q>(conv(v.x))` |
| `Vec4<T2, Q2>` | `.x`（第一分量） | `Vec1<T, Q>(conv(v.x))` |

## 重载分析

4 个重载通过参数类型 `Vec1<T2,Q2>`/`Vec2<T2,Q2>`/`Vec3<T2,Q2>`/`Vec4<T2,Q2>` 区分，编译器无重载歧义。

## 类型设计决策

- **T2 无约束**：T2 签名层面可为任意类型（含 Bool）。`conv` 闭包的类型兼容性由调用方保证，不匹配时编译器报告闭包类型错误（D5 延迟检查）
- **Q2 <: Qualifier**：允许任意 Qualifier 之间的跨 Q 转换
- **跨 Q 显式类型参数**：所有 4 个重载均为跨 Q 模式（存在 `Q` 和 `Q2` 两个限定符参数），函数体使用 `Vec1<T, Q>(conv(v.x))` 而非 `Vec1(conv(v.x))`。原因：编译器无法从 `v: VecN<T2, Q2>` 推断 `Vec1` 构造函数的 `Q` 类型参数，必须显式指定。此模式已在 `fromBoolVecQ2`（`type_fromBoolVec.cj:8`）中验证
- **函数名 `cast`**：4 个重载通过参数类型区分，无重载歧义

## 错误处理

无新增错误处理逻辑。`conv(v.x)` 返回类型不匹配时由编译器报告类型错误，为 D5 延迟检查的预期行为。

## 行为契约

- 各函数仅读取源 Vec 的 `x` 分量（不修改源 Vec）
- 通过 `conv` 闭包完成 `T2`→`T` 的分量值转换
- 结果通过 `Vec1<T, Q>(conv(v.x))` 构造函数构造

## 依赖关系

- 依赖 `Vec1`/`Vec2`/`Vec3`/`Vec4` 类型的定义（仅在签名中使用，不依赖内部实现）
- 被依赖方：无（新增函数为纯新增，不影响已有调用代码）

## 偏差记录

`cast` 函数以顶层函数替代跨类型构造函数，属于**接口/行为有偏差**（类别二）。因仓颉不支持构造函数的独立泛型参数，且不支持以类型参数作为构造函数调用，无法在 `Vec1` struct 体内定义跨类型转换构造函数，改为顶层 `cast` 函数 + 转换闭包参数。

根据 `deviations.md` 头部说明，尚未验证的偏差写入 §四。此偏差需在编码阶段或之后以草案形式写入 `docs/deviations.md` §四（未验证的偏差添加），格式参考 `DV-01` 或 `DEV-04`。

## 已有代码参考

已验证的顶层泛型函数模式（`fromBoolVecQ2`，`src/detail/type_fromBoolVec.cj:7-8`）：

```cangjie
public func fromBoolVecQ2<T, Q, Q2>(v: Vec1<Bool, Q2>, zero: T, one: T): Vec1<T, Q>
    where Q <: Qualifier, Q2 <: Qualifier {
    return Vec1<T, Q>(if (v.x) { one } else { zero })
}
```

本设计的 4 个 `cast` 重载均采用相同的跨 Q 显式类型参数模式。

## 修订说明（v3 r1）

| 审查意见 | 修改措施 |
|---------|---------|
| [严重] 所有 4 个重载的函数体使用 `Vec1(conv(v.x))` 但应为 `Vec1<T, Q>(conv(v.x))`（跨 Q 模式，参照 `fromBoolVecQ2`） | **认可。** 修正所有 4 个函数体为 `Vec1<T, Q>(conv(v.x))`，与 `fromBoolVecQ2` 模式一致。新增"类型设计决策"章节显式说明跨 Q 构造函数调用规则及已验证参考 |
| [一般] `cast` 函数作为构造函数 bypass 是否需记录为偏差 | **认可。** 在"偏差记录"章节说明该偏差（类别二：接口/行为有偏差），指明以草案形式写入 `docs/deviations.md` §四 |
