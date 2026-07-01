# 任务指令（v3）

## 动作
RETRY

## 任务描述
修复 R2 回归：修正 `src/detail/stdmath_shim.cj` 中的函数名遮蔽问题。

### 问题根因
`stdmath_shim.cj` 通过 `import std.math.{ sqrt, abs, floor, ceil, round, trunc, exp, log, exp2, log2, pow }` 导入标准库函数，然后用这些函数实现包装函数（如 `sqrtT` 内部调用 `sqrt`）。R2 中 `exponential.cj` 和 `common.cj` 在**同包** `glm.detail` 下定义了同名的 public 函数（`sqrt<T>`、`abs<T>`、`floor<T>` 等），导致 `stdmath_shim.cj` 中的 `sqrt` 等调用被编译器解析为同包函数而非 `std.math` 函数，形成 `sqrtT → sqrt(exponential.cj) → sqrtT` 无限递归，7 个 quat_cast 测试全部抛出 `StackOverflowError`。

### 受影响函数列表
`stdmath_shim.cj` 中所有与其包装函数同名的 `std.math` 导入：
- `sqrt` → `sqrtT`（被 exponential.cj 的 `sqrt<T>` 遮蔽）
- `exp` → `expT`（被 exponential.cj 的 `exp<T>` 遮蔽）
- `log` → `logT`（被 exponential.cj 的 `log<T>` 遮蔽）
- `exp2` → `exp2T`（被 exponential.cj 的 `exp2<T>` 遮蔽）
- `log2` → `log2T`（被 exponential.cj 的 `log2<T>` 遮蔽）
- `pow` → `powT`（被 exponential.cj 的 `pow<T>` 遮蔽）
- `abs` → `absT`（被 common.cj 的 `abs<T>` 遮蔽）
- `floor` → `floorT`（被 common.cj 的 `floor<T>` 遮蔽）
- `ceil` → `ceilT`（被 common.cj 的 `ceil<T>` 遮蔽）
- `round` → `roundT`（被 common.cj 的 `round<T>` 遮蔽）
- `trunc` → `truncT`（被 common.cj 的 `trunc<T>` 遮蔽）

### 修正方案
将 `stdmath_shim.cj` 中所有 `std.math` 函数调用改为**全限定名**，移除显式 `import` 以避免名称解析歧义：

```cangjie
// 原：import std.math.{ sqrt, exp, ... }
// 改：import std.math.FloatingPoint  （仅保留约束导入）
// 调用时使用全限定名：std.math.sqrt(...), std.math.abs(...), etc.
```

### 验证标准
- `cjpm build` 零错误
- `cjpm test` 全部 435 测试通过（0 ERROR、0 FAILED）
- 重点验证 7 个 quat_cast 测试不再抛 StackOverflowError

## 选择理由
这是 R2 实现的回归修复，必须先完成再推进后续任务。本修复不涉及新增/修改 API，仅修正 `stdmath_shim.cj` 的内部实现模式。

## 任务上下文
- `src/detail/stdmath_shim.cj`：私有工具模块，25 个泛型包装函数，被 common.cj / exponential.cj / trigonometric.cj 等 detail 文件依赖
- `src/detail/exponential.cj`：定义 public `sqrt<T>/exp<T>/log<T>/exp2<T>/log2<T>/pow<T>`，与 `stdmath_shim` 中的同名导入冲突
- `src/detail/common.cj`：定义 public `abs<T>/floor<T>/ceil<T>/round<T>/trunc<T>`，与 `stdmath_shim` 中的同名导入冲突
- `src/detail/type_quat_cast.cj`：调用 `sqrtT`，触发递归崩溃

## 已有代码上下文
stdmath_shim.cj 当前结构：
```cangjie
package glm.detail
import std.math.{ FloatingPoint, sqrt, exp, log, ... }

func sqrtT<T>(x: T): T where T <: FloatingPoint<T> {
    (sqrt((x as Float64).getOrThrow()) as T).getOrThrow()  // sqrt → 错误解析为 exponential.cj::sqrt
}
```

## RETRY 说明
**失败原因**：`stdmath_shim.cj` 中的 `sqrt`、`abs` 等函数名被同包（`glm.detail`）中 `exponential.cj` 和 `common.cj` 定义的 public 同名函数遮蔽。`sqrtT` 调用 `sqrt` 时进入 `exponential.cj::sqrt`，后者又调用 `sqrtT`，形成无限递归 → StackOverflowError。影响全部 7 个 `testS1QuatCast*` 测试。

**修正方向**：将 `stdmath_shim.cj` 中所有 `std.math` 函数调用使用全限定名 `std.math.sqrt()`、`std.math.abs()` 等，移除与 common/exponential 同名的函数导入，消除名称解析歧义。
