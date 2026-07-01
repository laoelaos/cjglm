# 详细设计（v3）

## 概述

补全 `detail/vector_relational.cj` 缺失的 5 个函数（G2/API 完整性）：`equal`、`notEqual`、`any`、`all`、`not_`，每函数 Vec1~Vec4 各一个重载（20 个函数体）。同步更新 `lib.cj` 导出和 `04_diag.md` 修复标记。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `cjglm/src/detail/vector_relational.cj` | 修改 | 追加 20 个函数重载（5 函数 × 4 维度） |
| `cjglm/src/lib.cj:45` | 修改 | 新增 `equal`/`notEqual`/`any`/`all`/`not_` 导出 |
| `docs/diag/impl/04_diag.md:107` | 修改 | G2 修改方向行追加 `✅ 已修复` |

## 类型定义

### equal — 逐分量相等比较

**形态**：泛型函数重载（Vec1~Vec4）
**包路径**：`glm.detail`
**约束**：`T <: Number<T>`（`Number<T>` 包含 `Equatable<T>`，提供 `==` 运算符）
**签名**：

```cangjie
public func equal<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>): Vec1<Bool, Q> where T <: Number<T>, Q <: Qualifier
public func equal<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>): Vec2<Bool, Q> where T <: Number<T>, Q <: Qualifier
public func equal<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>): Vec3<Bool, Q> where T <: Number<T>, Q <: Qualifier
public func equal<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>): Vec4<Bool, Q> where T <: Number<T>, Q <: Qualifier
```

**实现方式**：逐分量 `x.x == y.x` 等构造对应 Bool 向量。与已有 `lessThan` 模式一致，但约束中不需要 `Comparable<T>`（只用到 `==`）。

### notEqual — 逐分量不等比较

**形态**：泛型函数重载（Vec1~Vec4）
**包路径**：`glm.detail`
**约束**：`T <: Number<T>`
**签名**：

```cangjie
public func notEqual<T, Q>(x: Vec1<T, Q>, y: Vec1<T, Q>): Vec1<Bool, Q> where T <: Number<T>, Q <: Qualifier
public func notEqual<T, Q>(x: Vec2<T, Q>, y: Vec2<T, Q>): Vec2<Bool, Q> where T <: Number<T>, Q <: Qualifier
public func notEqual<T, Q>(x: Vec3<T, Q>, y: Vec3<T, Q>): Vec3<Bool, Q> where T <: Number<T>, Q <: Qualifier
public func notEqual<T, Q>(x: Vec4<T, Q>, y: Vec4<T, Q>): Vec4<Bool, Q> where T <: Number<T>, Q <: Qualifier
```

**实现方式**：逐分量 `x.x != y.x` 等构造 Bool 向量。

### any — 任一分量为 true 则返回 true

**形态**：泛型函数重载（Vec1~Vec4）
**包路径**：`glm.detail`
**签名**（无 T 类型参数，仅对 `VecN<Bool, Q>` 定义）：

```cangjie
public func any<Q>(v: Vec1<Bool, Q>): Bool where Q <: Qualifier
public func any<Q>(v: Vec2<Bool, Q>): Bool where Q <: Qualifier
public func any<Q>(v: Vec3<Bool, Q>): Bool where Q <: Qualifier
public func any<Q>(v: Vec4<Bool, Q>): Bool where Q <: Qualifier
```

**实现方式**：
- Vec1：`v.x`
- Vec2：`v.x || v.y`
- Vec3：`v.x || v.y || v.z`
- Vec4：`v.x || v.y || v.z || v.w`

Cangjie 中 `||` 操作 Bool 类型时为短路求值。

### all — 所有分量为 true 才返回 true

**形态**：泛型函数重载（Vec1~Vec4）
**包路径**：`glm.detail`
**签名**：

```cangjie
public func all<Q>(v: Vec1<Bool, Q>): Bool where Q <: Qualifier
public func all<Q>(v: Vec2<Bool, Q>): Bool where Q <: Qualifier
public func all<Q>(v: Vec3<Bool, Q>): Bool where Q <: Qualifier
public func all<Q>(v: Vec4<Bool, Q>): Bool where Q <: Qualifier
```

**实现方式**：
- Vec1：`v.x`
- Vec2：`v.x && v.y`
- Vec3：`v.x && v.y && v.z`
- Vec4：`v.x && v.y && v.z && v.w`

### not_ — 逐分量逻辑取反

**形态**：泛型函数重载（Vec1~Vec4）
**包路径**：`glm.detail`
**签名**：

```cangjie
public func not_<Q>(v: Vec1<Bool, Q>): Vec1<Bool, Q> where Q <: Qualifier
public func not_<Q>(v: Vec2<Bool, Q>): Vec2<Bool, Q> where Q <: Qualifier
public func not_<Q>(v: Vec3<Bool, Q>): Vec3<Bool, Q> where Q <: Qualifier
public func not_<Q>(v: Vec4<Bool, Q>): Vec4<Bool, Q> where Q <: Qualifier
```

**实现方式**：
- Vec1：`Vec1<Bool, Q>(!v.x)`
- Vec2：`Vec2<Bool, Q>(!v.x, !v.y)`
- Vec3：`Vec3<Bool, Q>(!v.x, !v.y, !v.z)`
- Vec4：`Vec4<Bool, Q>(!v.x, !v.y, !v.z, !v.w)`

## import 变更

### detail/vector_relational.cj

当前已有 `import std.math.{ Number }`。`Vec1`/`Vec2`/`Vec3`/`Vec4`/`Bool`/`Qualifier` 均在 `glm.detail` 包内自动可见。**无新增 import 需要**。

### lib.cj:45

第 45 行从：

```cangjie
public import glm.detail.{lessThan, greaterThan, lessThanEqual, greaterThanEqual}
```

改为：

```cangjie
public import glm.detail.{lessThan, greaterThan, lessThanEqual, greaterThanEqual, equal, notEqual, any, all, not_}
```

**重载兼容性说明**：`lib.cj:14` 已从 `glm.ext` 导出 `equal`/`notEqual`（带 epsilon 参数的三参数版本）。本次从 `glm.detail` 导出的是二参数版本（无 epsilon）。两者签名不同（参数个数不同），在 Cangjie 中属于合法重载，调用方可根据参数数量自动选择。

## 错误处理

| 函数 | 错误处理方式 |
|------|------------|
| `equal`/`notEqual` | 无异常路径。`==`/`!=` 运算符对 `Number<T>` 类型不抛异常 |
| `any`/`all`/`not_` | 无异常路径。`!`/`||`/`&&` 对 `Bool` 类型不抛异常 |

## 行为契约

- **前置条件**：无
- **后置条件**：`equal`/`notEqual` 返回与输入相同维度的 Bool 向量；`any`/`all` 返回单个 `Bool`；`not_` 返回与输入相同维度的 Bool 向量
- **`equal`/`notEqual` 与 `glm.ext` 同名函数关系**：`glm.detail.equal`（二参数，逐分量 `==`）与 `glm.ext.equal`（三参数，带 epsilon 容差）不同。调用方按参数个数区分
- **`not_` 命名约定**：GLM 中为 `not_`（C++ `not` 是保留关键字，采用 `not_` 规避）。仓颉中 `not` 非保留字，但为与 GLM 命名一致也采用 `not_`

## 依赖关系

| 修改文件 | 新增依赖 | 暴露给外部 |
|---------|---------|-----------|
| `detail/vector_relational.cj` | 无新增 | `lib.cj:45` 通过 `public import glm.detail.{...equal, notEqual, any, all, not_}` 导出到 `glm` 包 |
| `lib.cj` | 无新增 | 外部通过 `glm.equal`/`glm.notEqual`/`glm.any`/`glm.all`/`glm.not_` 即可调用 |
