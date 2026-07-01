# 详细设计（v3）

## 概述

修复 R2 回归：修正 `src/detail/stdmath_shim.cj` 中因同包函数名遮蔽导致的无限递归问题。`stdmath_shim.cj` 通过 `import std.math.{ sqrt, abs, ... }` 导入标准库函数，但同包 `exponential.cj` 和 `common.cj` 定义了同名的 `public` 泛型函数，导致名称解析歧义——`sqrtT` 内部调用 `sqrt` 被解析为 `exponential.cj::sqrt` 而非 `std.math.sqrt`，形成 `sqrtT → exponential.cj.sqrt → sqrtT` 无限递归，7 个 quat_cast 测试全部抛出 `StackOverflowError`。

## 修正方案

将 `stdmath_shim.cj` 中所有 `std.math` 函数调用改为**全限定名**，移除与 common/exponential 同名的函数导入项，消除名称解析歧义。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| src/detail/stdmath_shim.cj | 修改 | 移除与 same-package 函数同名的 `std.math` 导入，改用全限定名调用 |

## 导入变更

**原导入**：
```cangjie
import std.math.{ FloatingPoint, sqrt, exp, log, exp2, log2, pow,
    sin, cos, tan, asin, acos, atan, atan2,
    sinh, cosh, tanh, asinh, acosh, atanh,
    floor, ceil, round, trunc, abs, fmod }
```

**新导入**：
```cangjie
import std.math.FloatingPoint
```

仅保留 `FloatingPoint` 约束导入（用于泛型 where 子句）。所有 `std.math` 函数通过全限定名 `std.math.sqrt(...)`、`std.math.abs(...)` 等形式调用。

## 函数调用映射

`stdmath_shim.cj` 中共 25 个包装函数需修改函数体内的调用方式：

| 包装函数 | 当前调用 | 修改后调用 |
|---------|---------|-----------|
| `sqrtT` | `sqrt(...)` | `std.math.sqrt(...)` |
| `expT` | `exp(...)` | `std.math.exp(...)` |
| `logT` | `log(...)` | `std.math.log(...)` |
| `exp2T` | `exp2(...)` | `std.math.exp2(...)` |
| `log2T` | `log2(...)` | `std.math.log2(...)` |
| `powT` | `pow(...)` | `std.math.pow(...)` |
| `sinT` | `sin(...)` | `std.math.sin(...)` |
| `cosT` | `cos(...)` | `std.math.cos(...)` |
| `tanT` | `tan(...)` | `std.math.tan(...)` |
| `asinT` | `asin(...)` | `std.math.asin(...)` |
| `acosT` | `acos(...)` | `std.math.acos(...)` |
| `atanT` | `atan(...)` | `std.math.atan(...)` |
| `atan2T` | `atan2(...)` | `std.math.atan2(...)` |
| `sinhT` | `sinh(...)` | `std.math.sinh(...)` |
| `coshT` | `cosh(...)` | `std.math.cosh(...)` |
| `tanhT` | `tanh(...)` | `std.math.tanh(...)` |
| `asinhT` | `asinh(...)` | `std.math.asinh(...)` |
| `acoshT` | `acosh(...)` | `std.math.acosh(...)` |
| `atanhT` | `atanh(...)` | `std.math.atanh(...)` |
| `floorT` | `floor(...)` | `std.math.floor(...)` |
| `ceilT` | `ceil(...)` | `std.math.ceil(...)` |
| `roundT` | `round(...)` | `std.math.round(...)` |
| `truncT` | `trunc(...)` | `std.math.trunc(...)` |
| `absT` | `abs(...)` | `std.math.abs(...)` |
| `fmodT` | `fmod(...)` | `std.math.fmod(...)` |

## 代码变更示意

```cangjie
// 修改前：
package glm.detail
import std.math.{ FloatingPoint, sqrt, exp, log, ... }

func sqrtT<T>(x: T): T where T <: FloatingPoint<T> {
    (sqrt((x as Float64).getOrThrow()) as T).getOrThrow()
}

// 修改后：
package glm.detail
import std.math.FloatingPoint

func sqrtT<T>(x: T): T where T <: FloatingPoint<T> {
    (std.math.sqrt((x as Float64).getOrThrow()) as T).getOrThrow()
}
```

## 行为契约

1. 所有 25 个包装函数的签名、泛型约束、返回类型**不变**
2. 所有 25 个包装函数的语义行为**不变**（仅调用路径从"导入名"变为"全限定名"，调用的标准库函数完全一致）
3. 不再存在名称解析歧义——`std.math.sqrt` 永远是 `std.math` 包的函数，不会被同包函数遮蔽
4. `import std.math.FloatingPoint` 仅保留用于泛型 `where T <: FloatingPoint<T>` 约束

## 依赖关系

| 依赖 | 说明 |
|------|------|
| `std.math.FloatingPoint` | 泛型约束导入，保持不变 |
| `std.math.sqrt` 等 25 个函数 | 通过全限定名调用，不再通过导入名 |

## 验证标准

- `cjpm build` 零错误
- `cjpm test` 全部测试通过（0 ERROR、0 FAILED）
- 重点验证 7 个 quat_cast 测试不再抛 `StackOverflowError`

## 修订说明（v3 R1）

| 审查意见 | 修改措施 |
|---------|---------|
| v2 验证失败：R2 引入回归，`stdmath_shim.cj` 函数名被同包函数遮蔽，导致 quat_cast 测试 StackOverflowError | 全量修改 `stdmath_shim.cj`：移除与 common/exponential 同名的 `std.math` 函数导入项，改用 `std.math.*` 全限定名调用 |
