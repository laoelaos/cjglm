# 详细设计（v10）

## 概述

收紧 `quaternion_common.cj` 中 `lerp` 和 `mix` 的泛型约束，从 `Number<T>` 提升至 `FloatingPoint<T>`，与 GLM `is_iec559` 静态断言对齐。单文件两行约束修改，无下游影响。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `cjglm/src/ext/quaternion_common.cj` | 修改 | 收紧 `lerp` 和 `mix` 的泛型约束 |

## 修改说明

### 1. `lerp`（第 15-22 行）

**当前签名**：
```cangjie
@OverflowWrapping
public func lerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T): Quat<T, Q>
  where T <: Number<T> & Comparable<T>, Q <: Qualifier
```

**修改后签名**：
```cangjie
@OverflowWrapping
public func lerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T): Quat<T, Q>
  where T <: FloatingPoint<T> & Comparable<T>, Q <: Qualifier
```

**理由**：`FloatingPoint<T>` 扩展自 `Number<T>`，保留 `Comparable<T>` 以满足函数体中 `>=`/`<=` 操作。

### 2. `mix`（第 34-35 行）

**当前签名**：
```cangjie
public func mix<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T): Quat<T, Q>
  where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
```

**修改后签名**：
```cangjie
public func mix<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T): Quat<T, Q>
  where T <: FloatingPoint<T>, Q <: Qualifier { throw Exception("stub") }
```

**理由**：`mix` 为 stub（仅抛出异常），收紧无编译风险，无需 `Comparable<T>`。

## 依赖关系

- `std.math.FloatingPoint` 已在第 3 行 import
- 无需新增 import
- grep 确认当前无整数 T 调用点，收紧不影响现有调用
- 无需更新 `deviations.md`（修复后与 OOD 对齐）
