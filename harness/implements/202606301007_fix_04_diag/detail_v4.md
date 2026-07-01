# 详细设计（v4）

## 概述

在 `ext/vector_common.cj` 补齐 `fmin`/`fmax` 缺失的 3/4 输入向量版本（G5），每函数 8 个重载（Vec1~Vec4 × 3输入 + 4输入），共 16 个。同步更新 `04_diag.md` G5 修复标记。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `cjglm/src/ext/vector_common.cj` | 修改 | 在现有 fmin/fmax 2-输入版本之后（`:107`）追加 16 个函数重载 |
| `docs/diag/impl/04_diag.md:135` | 修改 | G5 修改方向行追加 `✅ 已修复` |

## 类型定义

### fmin 3-输入向量版本 — 4 个重载

**形态**：泛型函数重载（Vec1~Vec4）
**包路径**：`glm.ext`
**约束**：`T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier`（与现有 fmin 2-输入版本一致）

```cangjie
public func fmin<T, Q>(a: Vec1<T, Q>, b: Vec1<T, Q>, c: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec1(fmin(a.x, b.x, c.x))
}
public func fmin<T, Q>(a: Vec2<T, Q>, b: Vec2<T, Q>, c: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec2(fmin(a.x, b.x, c.x), fmin(a.y, b.y, c.y))
}
public func fmin<T, Q>(a: Vec3<T, Q>, b: Vec3<T, Q>, c: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec3(fmin(a.x, b.x, c.x), fmin(a.y, b.y, c.y), fmin(a.z, b.z, c.z))
}
public func fmin<T, Q>(a: Vec4<T, Q>, b: Vec4<T, Q>, c: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec4(fmin(a.x, b.x, c.x), fmin(a.y, b.y, c.y), fmin(a.z, b.z, c.z), fmin(a.w, b.w, c.w))
}
```

### fmin 4-输入向量版本 — 4 个重载

```cangjie
public func fmin<T, Q>(a: Vec1<T, Q>, b: Vec1<T, Q>, c: Vec1<T, Q>, d: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec1(fmin(a.x, b.x, c.x, d.x))
}
public func fmin<T, Q>(a: Vec2<T, Q>, b: Vec2<T, Q>, c: Vec2<T, Q>, d: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec2(fmin(a.x, b.x, c.x, d.x), fmin(a.y, b.y, c.y, d.y))
}
public func fmin<T, Q>(a: Vec3<T, Q>, b: Vec3<T, Q>, c: Vec3<T, Q>, d: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec3(fmin(a.x, b.x, c.x, d.x), fmin(a.y, b.y, c.y, d.y), fmin(a.z, b.z, c.z, d.z))
}
public func fmin<T, Q>(a: Vec4<T, Q>, b: Vec4<T, Q>, c: Vec4<T, Q>, d: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec4(fmin(a.x, b.x, c.x, d.x), fmin(a.y, b.y, c.y, d.y), fmin(a.z, b.z, c.z, d.z), fmin(a.w, b.w, c.w, d.w))
}
```

### fmax 3-输入向量版本 — 4 个重载

模式与 fmin 3-输入相同，仅函数名替换为 `fmax`，所有 `fmin(...)` 内部调用替换为 `fmax(...)`。

```cangjie
public func fmax<T, Q>(a: Vec1<T, Q>, b: Vec1<T, Q>, c: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec1(fmax(a.x, b.x, c.x))
}
public func fmax<T, Q>(a: Vec2<T, Q>, b: Vec2<T, Q>, c: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec2(fmax(a.x, b.x, c.x), fmax(a.y, b.y, c.y))
}
public func fmax<T, Q>(a: Vec3<T, Q>, b: Vec3<T, Q>, c: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec3(fmax(a.x, b.x, c.x), fmax(a.y, b.y, c.y), fmax(a.z, b.z, c.z))
}
public func fmax<T, Q>(a: Vec4<T, Q>, b: Vec4<T, Q>, c: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec4(fmax(a.x, b.x, c.x), fmax(a.y, b.y, c.y), fmax(a.z, b.z, c.z), fmax(a.w, b.w, c.w))
}
```

### fmax 4-输入向量版本 — 4 个重载

```cangjie
public func fmax<T, Q>(a: Vec1<T, Q>, b: Vec1<T, Q>, c: Vec1<T, Q>, d: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec1(fmax(a.x, b.x, c.x, d.x))
}
public func fmax<T, Q>(a: Vec2<T, Q>, b: Vec2<T, Q>, c: Vec2<T, Q>, d: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec2(fmax(a.x, b.x, c.x, d.x), fmax(a.y, b.y, c.y, d.y))
}
public func fmax<T, Q>(a: Vec3<T, Q>, b: Vec3<T, Q>, c: Vec3<T, Q>, d: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec3(fmax(a.x, b.x, c.x, d.x), fmax(a.y, b.y, c.y, d.y), fmax(a.z, b.z, c.z, d.z))
}
public func fmax<T, Q>(a: Vec4<T, Q>, b: Vec4<T, Q>, c: Vec4<T, Q>, d: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier {
    Vec4(fmax(a.x, b.x, c.x, d.x), fmax(a.y, b.y, c.y, d.y), fmax(a.z, b.z, c.z, d.z), fmax(a.w, b.w, c.w, d.w))
}
```

## 错误处理

| 函数 | 错误处理方式 |
|------|------------|
| `fmin`/`fmax` 3/4-输入版本 | 无异常路径。委托 `ext/scalar_common.cj` 的标量 `fmin`/`fmax`，NaN 保护在标量层内部处理 |

## 行为契约

- **前置条件**：无
- **后置条件**：返回与输入相同维度的向量，逐分量取 NaN 安全的 fmin/fmax
- **NaN 保护**：标量层 `fmin`/`fmax` 已有 NaN 前置判断（`isnan(a)` → 返回另一参数），向量版本通过逐分量委托继承了此保护
- **放置顺序**：在现有 fmin/fmax 2-输入版本之后（`:107`），与 min/max 3/4 输入版本的放置模式一致（min/max 3/4 输入在 2-输入之前）

## 依赖关系

| 修改文件 | 新增依赖 | 暴露给外部 |
|---------|---------|-----------|
| `ext/vector_common.cj` | 无新增（`FloatingPoint`、`Comparable`、`Vec1~Vec4`、`Qualifier`、`fmin`/`fmax` 已在现有代码中导入） | `lib.cj:41` 的 `public import glm.ext.{fmin, fmax, ...}` 自动覆盖新增重载，无需额外修改 |
| `docs/diag/impl/04_diag.md` | 无 | 仅标记修复状态 |
