# 任务指令（v5）

## 动作
NEW

## 任务描述
在 `type_mat3x3.cj` 和 `type_mat4x4.cj` 中将矩阵乘法 `operator func *` 的右操作数参数名从 `r` 改为 `rhs`，共 6 处：

| 文件 | 行号 | 当前签名 | 需改为 |
|------|------|---------|--------|
| `src/detail/type_mat3x3.cj` | 91 | `operator func *(r: Mat2x3<T, Q>)` | `operator func *(rhs: Mat2x3<T, Q>)` |
| `src/detail/type_mat3x3.cj` | 99 | `operator func *(r: Mat3x3<T, Q>)` | `operator func *(rhs: Mat3x3<T, Q>)` |
| `src/detail/type_mat3x3.cj` | 108 | `operator func *(r: Mat4x3<T, Q>)` | `operator func *(rhs: Mat4x3<T, Q>)` |
| `src/detail/type_mat4x4.cj` | 97 | `operator func *(r: Mat2x4<T, Q>)` | `operator func *(rhs: Mat2x4<T, Q>)` |
| `src/detail/type_mat4x4.cj` | 105 | `operator func *(r: Mat3x4<T, Q>)` | `operator func *(rhs: Mat3x4<T, Q>)` |
| `src/detail/type_mat4x4.cj` | 114 | `operator func *(r: Mat4x4<T, Q>)` | `operator func *(rhs: Mat4x4<T, Q>)` |

## 选择理由
Phase 4 Group A（独立文件，可并行），代码风格一致性，操作简单明确（仅改参数名，不影响行为或测试）。其余 7 个矩阵类型及同文件的 `/` 运算符已使用 `rhs`。

## 任务上下文
- 诊断报告 §3 T3 已精确定位 6 处不一致
- `type_mat3x3.cj:118`：`operator func /(rhs: Mat3x3<T, Q>)` — 同文件已用 `rhs`
- `type_mat4x4.cj:124`：`operator func /(rhs: Mat4x4<T, Q>)` — 同文件已用 `rhs`
- 仅参数名变更，不涉及行为、签名或测试变更

## 已有代码上下文
- `cjglm/src/detail/type_mat3x3.cj` — 项目根目录 `cjglm/` 下
- `cjglm/src/detail/type_mat4x4.cj` — 项目根目录 `cjglm/` 下
- `type_mat3x3.cj:91` 当前签名：`public operator func *(r: Mat2x3<T, Q>): Mat3x3<T, Q> {`
- `type_mat4x4.cj:97` 当前签名：`public operator func *(r: Mat2x4<T, Q>): Mat4x4<T, Q> {`
