# 详细设计（v7）

## 概述

修复 G2.3：将 `quaternion_geometric.cj`、`quaternion_trigonometric.cj`、`type_quat_cast.cj` 中 3 处 `sqrtT` 私有函数的实现从 Float64 中转包装改为直接调用 `std.math.sqrt(x)`，利用 T 自身的精度重载，使与 OOD §1 方案 A 一致。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `cjglm/src/ext/quaternion_geometric.cj:5-8` | 修改 | 替换 `sqrtT` 函数体 |
| `cjglm/src/ext/quaternion_trigonometric.cj:5-8` | 修改 | 替换 `sqrtT` 函数体 |
| `cjglm/src/detail/type_quat_cast.cj:129-132` | 修改 | 替换 `sqrtT` 函数体 |

## 签名变更

### 当前实现（3 文件相同）

```cangjie
private func sqrtT<T>(x: T): T where T <: FloatingPoint<T> {
    let x64 = (x as Float64).getOrThrow()
    (sqrt(x64) as T).getOrThrow()
}
```

### 目标实现

```cangjie
private func sqrtT<T>(x: T): T where T <: FloatingPoint<T> {
    sqrt(x)
}
```

**变更项**：将 2 行的 Float64 中转（`as Float64` → `sqrt` → `as T`）替换为直接调用 `sqrt(x)`，利用 `FloatingPoint<T>` 约束下的 `std.math.sqrt` 泛型重载。

## 类型定义

本次任务不涉及类型定义变更。

## 错误处理

- 当前实现中的 `.getOrThrow()` 在直接调用 `sqrt(x)` 后不再需要——`FloatingPoint<T>` 约束的 `sqrt` 返回 `T` 而非 `Result<T, ...>`，不存在 unwrap 路径。
- `sqrtT` 调用点（`quaternion_geometric.cj:17`、`quaternion_trigonometric.cj:18`、`type_quat_cast.cj:83,91,99,107`）不受影响，返回类型保持 `T`。

## 行为契约

### 前置条件
- 3 个文件均已导入 `sqrt`：`import std.math.{ ... sqrt }`

### 后置条件
- `cjpm build` 编译通过（0 errors）
- `cjpm test` 全部 PASSED / 0 FAILED（数值结果在浮点位模式层面可能产生约 1e-7 量级的微小差异，不影响功能正确性；若测试因精度差异失败，需调整断言容差）

### 注意事项
- 无参数名引用被破坏（仅修改函数体，签名不变）
- 3 个文件的 import 列表无需修改（`sqrt` 已导入）
- 无需修改诊断文档 `03_diag.md`
- 无需修改偏差记录 `deviations.md`

## 依赖关系

- 不引入新依赖
- `std.math.sqrt` 已通过现有 import 可用
