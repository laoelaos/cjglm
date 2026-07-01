# 详细设计（v5）

## 概述

修改 `ext/scalar_common.cj` 中 `iround`/`uround` 函数，改用 `stdmath_shim.roundT` 委托路径（G6）。同步更新 `04_diag.md` G6 修复标记。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `cjglm/src/ext/scalar_common.cj:5` | 修改 | import 列表追加 `roundT`（来自 `glm.detail`） |
| `cjglm/src/ext/scalar_common.cj:104-108` | 修改 | `iround<T>(x: T): Int64` 函数体改为委托 `roundT` |
| `cjglm/src/ext/scalar_common.cj:110-114` | 修改 | `uround<T>(x: T): UInt64` 函数体改为委托 `roundT` |
| `docs/diag/impl/04_diag.md:152` | 修改 | G6 修改方向行追加 `✅ 已修复` |

## 类型定义

无新增类型。仅修改已有函数实现体。

### iround

**形态**：泛型函数
**包路径**：`glm.ext`
**当前签名**：`public func iround<T>(x: T): Int64 where T <: FloatingPoint<T>`
**变更**：函数体由 `math.round(xF64)` + 类型转换 改为委托 `roundT` + `as Int64`

```cangjie
public func iround<T>(x: T): Int64 where T <: FloatingPoint<T> {
    (roundT(x) as Int64).getOrThrow()
}
```

### uround

**形态**：泛型函数
**包路径**：`glm.ext`
**当前签名**：`public func uround<T>(x: T): UInt64 where T <: FloatingPoint<T>`
**变更**：函数体由 `math.round(xF64)` + 类型转换 改为委托 `roundT` + `as UInt64`

```cangjie
public func uround<T>(x: T): UInt64 where T <: FloatingPoint<T> {
    (roundT(x) as UInt64).getOrThrow()
}
```

## 错误处理

| 函数 | 错误处理方式 |
|------|------------|
| `iround`/`uround` | 维持 `getOrThrow()` 模式。`roundT` 内部错误传播由 shim 层统一处理，转换失败由 `as` + `getOrThrow` 抛出 |

## 行为契约

- **前置条件**：无变更（与原实现一致）
- **后置条件**：`iround` 返回 `Int64`，`uround` 返回 `UInt64`，舍入规则为 `math.round`（四舍五入）
- **等价性**：新实现与原实现在 `FloatingPoint<T>` 所有合法输入下行为一致，因为 `roundT` 内部实现与当前代码路径一致（`math.round((x as Float64).getOrThrow())`）

## 依赖关系

| 修改文件 | 新增依赖 | 暴露给外部 |
|---------|---------|-----------|
| `ext/scalar_common.cj` | import 新增 `roundT`（来自 `glm.detail`） | `lib.cj:41` 的 `public import ... iround, uround` 自动覆盖，无需额外修改 |
| `docs/diag/impl/04_diag.md` | 无 | 仅标记修复状态 |
