# 设计审查报告（v8 r1）

## 审查结果
REJECTED

## 发现

### [严重] Stdmath 辅助函数跨包不可见（系统性设计缺陷）

**问题**：设计为 `glm.ext` 和 `glm.gtc` 包的 7 个文件提供了如下形式的 import 声明，试图导入 `glm.detail` 包的 `sqrtT`/`sinT`/`cosT`/`tanT`：

```
import glm.detail.{ ..., sqrtT, sinT, cosT, tanT }
```

但实际代码中，这些函数在 `src/detail/stdmath_shim.cj` 中以 **包级可见性** 定义（无 `public` 修饰符，例如 `func sqrtT<T>(...)`），**不可被 `glm.detail` 之外的包导入**。

Cangjie 语言规则：同一 `package` 内的文件可以直接访问包级函数，但不同包（`glm.ext`、`glm.gtc`）无法引用 `glm.detail` 的包级函数。

**受影响文件及对应的不可导入函数**：

| 文件 | 不可导入的函数 |
|------|---------------|
| `src/ext/matrix_transform.cj` | `sinT`, `cosT`, `sqrtT` |
| `src/ext/matrix_clip_space.cj` | `sinT`, `cosT`, `tanT` |
| `src/ext/matrix_projection.cj` | `sqrtT` |
| `src/ext/quaternion_common.cj` | `sinT`, `cosT`, `sqrtT` |
| `src/ext/quaternion_trigonometric.cj` | `sinT`, `cosT` |
| `src/ext/quaternion_transform.cj` | `sqrtT`, `sinT`, `cosT` |
| `src/gtc/matrix_transform.cj` | `sinT`, `cosT` |

**现有代码中的正确模式**：`src/ext/quaternion_geometric.cj` 和 `src/ext/quaternion_trigonometric.cj` 已经采用了本地 `private func` 包装器模式，例如：

```cangjie
private func sqrtT<T>(x: T): T where T <: FloatingPoint<T> {
    let x64 = (x as Float64).getOrThrow()
    (sqrt(x64) as T).getOrThrow()
}
```

**期望修正方向**（任选其一，需在设计或偏差记录中明确）：
1. **方案 A**：将 `src/detail/stdmath_shim.cj` 中的所有 `func` 改为 `public func`，然后移除 `ext/quaternion_geometric.cj` 和 `ext/quaternion_trigonometric.cj` 中的私有副本。
2. **方案 B**：保持私有包装器模式，在每个需要这些函数的 ext/gtc 文件中定义本地 `private func` 包装器，并修正所有 import 声明移除不可导入的函数引用。

## 修改要求

1. **[严重]** 解决 `sqrtT`/`sinT`/`cosT`/`tanT` 在 `glm.ext` 和 `glm.gtc` 包中的跨包访问问题。选择方案 A 或方案 B 后在设计的导入声明部分做相应修正。
