# 详细设计（v5）

## 概述

在 `type_mat3x3.cj` 和 `type_mat4x4.cj` 中将矩阵乘法 `operator func *` 的右操作数参数名从 `r` 改为 `rhs`，共 6 处。仅参数名变更，不涉及行为、签名或测试变更。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `cjglm/src/detail/type_mat3x3.cj` | 编辑 | 3 处 `operator func *` 参数名 `r` → `rhs`，体内部署 `r.` → `rhs.` |
| `cjglm/src/detail/type_mat4x4.cj` | 编辑 | 3 处 `operator func *` 参数名 `r` → `rhs`，体内部署 `r.` → `rhs.` |

## 修改清单

### type_mat3x3.cj（3 处）

| 行号 | 当前签名 | 改为 |
|------|---------|------|
| 91 | `operator func *(r: Mat2x3<T, Q>)` | `operator func *(rhs: Mat2x3<T, Q>)` |
| 99 | `operator func *(r: Mat3x3<T, Q>)` | `operator func *(rhs: Mat3x3<T, Q>)` |
| 108 | `operator func *(r: Mat4x3<T, Q>)` | `operator func *(rhs: Mat4x3<T, Q>)` |

每处体内的 `r.c0` / `r.c1` / `r.c2` / `r.c3` 同步改为 `rhs.c0` / `rhs.c1` / `rhs.c2` / `rhs.c3`。

### type_mat4x4.cj（3 处）

| 行号 | 当前签名 | 改为 |
|------|---------|------|
| 97 | `operator func *(r: Mat2x4<T, Q>)` | `operator func *(rhs: Mat2x4<T, Q>)` |
| 105 | `operator func *(r: Mat3x4<T, Q>)` | `operator func *(rhs: Mat3x4<T, Q>)` |
| 114 | `operator func *(r: Mat4x4<T, Q>)` | `operator func *(rhs: Mat4x4<T, Q>)` |

每处体内的 `r.c0` / `r.c1` / `r.c2` / `r.c3` 同步改为 `rhs.c0` / `rhs.c1` / `rhs.c2` / `rhs.c3`。

## 一致性检查

- `type_mat3x3.cj:118` 的 `operator func /(rhs: Mat3x3<T, Q>)` 已使用 `rhs`，修改后保持一致
- `type_mat4x4.cj:124` 的 `operator func /(rhs: Mat4x4<T, Q>)` 已使用 `rhs`，修改后保持一致
- 同文件 `operator func *(v: Vec3<T, Q>)` / `operator func *(v: Vec4<T, Q>)` 的参数 `v` 不受影响
- 其他 7 个矩阵类型（Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x4, Mat4x2, Mat4x3）的 `operator func *` 已在 Phase 4 Group C 中处理为 `rhs`

## 错误处理

不涉及——仅参数名变更，无错误处理逻辑变更。

## 行为契约

- 所有 6 处 `operator func *` 的行为、返回值类型、重载决议完全不变
- 外部调用方无需修改（参数名不影响调用方）
- 修改后通过 `cjpm build` 编译无错误

## 依赖关系

- 无新增依赖
- 修改后的文件依赖其他矩阵类型定义（Mat2x3, Mat3x3, Mat4x3, Mat2x4, Mat3x4, Mat4x4），这些类型签名未变更
