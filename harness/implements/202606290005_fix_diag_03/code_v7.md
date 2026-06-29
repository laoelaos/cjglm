# 实现报告（v7）

## 概述

尝试实现 G2.3：将 3 处 `sqrtT` 函数体的 Float64 中转包装替换为直接调用 `sqrt(x)`，但因 `std.math.sqrt` 签名限制，修改无法通过编译。已还原所有文件，未做任何代码变更。

## 文件变更清单

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 无变更 | `src/ext/quaternion_geometric.cj` | 未修改 |
| 无变更 | `src/ext/quaternion_trigonometric.cj` | 未修改 |
| 无变更 | `src/detail/type_quat_cast.cj` | 未修改 |

## 编译验证

首次尝试修改后编译失败（1 error）。还原后项目保持编译通过状态。

## 设计偏差说明

| 设计规格 | 偏差原因 | 实际处理 |
|---------|---------|---------|
| 将 `sqrtT` 函数体替换为 `sqrt(x)`，利用 `FloatingPoint<T>` 约束下的 `std.math.sqrt` 泛型重载 | `std.math.sqrt` 仅有针对具体类型 Float16/Float32/Float64 的独立重载（参见 `std/math/math_package_api/math_package_funcs.md`），不存在接受泛型 `T where T <: FloatingPoint<T>` 的版本。编译错误：`expected 'Float16', found 'Generics-T'` | 维持原实现中的 Float64 中转方案 `(x as Float64).getOrThrow() → sqrt → (result as T).getOrThrow()`。建议设计方确认：若需支持精度保持，需在 `FloatingPoint<T>` 接口中增加 `sqrt` 方法，或在 `std.math` 中增加泛型 `sqrt<T>(x: T): T where T <: FloatingPoint<T>` 重载 |
