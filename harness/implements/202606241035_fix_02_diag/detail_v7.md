# 详细设计（v7）

## 概述

移除 9 个 `src/detail/type_mat*.cj` 文件中纯收缩方向 `fromMat` 方法体内未使用的 `let zero` 声明。

纯收缩方向判定：目标矩阵行列均不大于源矩阵（`C_dst ≤ C_src 且 R_dst ≤ R_src`），且函数体不引用 `zero` 变量。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `src/detail/type_mat2x2.cj` | 修改 | 移除 16 条 `let zero`（6a:8条 + 6b:8条）|
| `src/detail/type_mat2x3.cj` | 修改 | 移除 10 条 `let zero`（6a:5条 + 6b:5条）|
| `src/detail/type_mat2x4.cj` | 修改 | 移除 4 条 `let zero`（6a:2条 + 6b:2条）|
| `src/detail/type_mat3x2.cj` | 修改 | 移除 10 条 `let zero`（6a:5条 + 6b:5条）|
| `src/detail/type_mat3x3.cj` | 修改 | 移除 6 条 `let zero`（6a:3条 + 6b:3条）|
| `src/detail/type_mat3x4.cj` | 修改 | 移除 2 条 `let zero`（6a:1条 + 6b:1条）|
| `src/detail/type_mat4x2.cj` | 修改 | 移除 4 条 `let zero`（6a:2条 + 6b:2条）|
| `src/detail/type_mat4x3.cj` | 修改 | 移除 2 条 `let zero`（6a:1条 + 6b:1条）|
| `src/detail/type_mat4x4.cj` | 不动 | 0 条，无纯收缩方向 |

## 移除细则

### 判定规则

对每个 `type_matXxY.cj` 文件中两个 `extend<T, Q> ... where T <: Number<T>, Q <: Qualifier` 块中的 `fromMat` 方法群：

1. **6a 变体**：无 `conv` 参数，签名 `fromMat<SrcQ>(m: MatSrcColxSrcRow<T, SrcQ>, one: T)`，体内 `let zero = m.c0.x - m.c0.x`
2. **6b 变体**：有 `conv` 参数，签名 `fromMat<U, P>(conv: (U) -> T, m: MatSrcColxSrcRow<U, P>, one: T)`，体内 `let zero = one - one`

若方法体返回语句中未使用标识符 `zero`，则移除该 `let zero` 行。

### 逐文件明细

#### type_mat2x2.cj（16 条）

纯收缩方向：全部 8 个非 EQL 方向（Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4 作为源），因为 `C_dst=2 ≤ C_src` 且 `R_dst=2 ≤ R_src` 对所有源成立。

- **6a 块**（L145-L195）：移除 L150, L156, L162, L168, L174, L180, L186, L192 的 `let zero = m.c0.x - m.c0.x`
- **6b 块**（L197-L247）：移除 L202, L208, L214, L220, L226, L232, L238, L244 的 `let zero = one - one`

#### type_mat2x3.cj（10 条）

纯收缩方向（←源）：Mat2x4, Mat3x3, Mat3x4, Mat4x3, Mat4x4
保留方向：Mat2x2（`zero` 用于行填充），Mat3x2（`zero` 用于行填充），Mat4x2（`zero` 用于行填充）

- **6a 块**（L140-L190）：移除 L151, L163, L169, L181, L187 的 `let zero = m.c0.x - m.c0.x`
- **6b 块**（L192-L242）：移除 L203, L215, L221, L233, L239 的 `let zero = one - one`

#### type_mat2x4.cj（4 条）

纯收缩方向（←源）：Mat3x4, Mat4x4

- **6a 块**（L140-L190）：移除 L169, L187 的 `let zero = m.c0.x - m.c0.x`
- **6b 块**（L192-L242）：移除 L221, L239 的 `let zero = one - one`

#### type_mat3x2.cj（10 条）

纯收缩方向（←源）：Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4
保留方向：Mat2x2（`zero` 用于列填充），Mat2x3（`zero` 用于列填充），Mat2x4（`zero` 用于列填充）

- **6a 块**（L146-L196）：移除 L169, L175, L181, L187, L193 的 `let zero = m.c0.x - m.c0.x`
- **6b 块**（L198-L248）：移除 L221, L227, L233, L239, L245 的 `let zero = one - one`

#### type_mat3x3.cj（6 条）

纯收缩方向（←源）：Mat3x4, Mat4x3, Mat4x4

- **6a 块**（L149-L199）：移除 L178, L190, L196 的 `let zero = m.c0.x - m.c0.x`
- **6b 块**（L201-L251）：移除 L230, L242, L248 的 `let zero = one - one`

#### type_mat3x4.cj（2 条）

纯收缩方向（←源）：Mat4x4
说明：Mat4x4→Mat3x4 满足 `C_dst=3 ≤ C_src=4` 且 `R_dst=4 ≤ R_src=4`；函数体做纯截断操作不引用 `zero`。

- **6a 块**（L146-L196）：移除 L193 的 `let zero = m.c0.x - m.c0.x`
- **6b 块**（L198-L248）：移除 L245 的 `let zero = one - one`

#### type_mat4x2.cj（4 条）

纯收缩方向（←源）：Mat4x3, Mat4x4

- **6a 块**（L152-L202）：移除 L193, L199 的 `let zero = m.c0.x - m.c0.x`
- **6b 块**（L204-L254）：移除 L245, L251 的 `let zero = one - one`

#### type_mat4x3.cj（2 条）

纯收缩方向（←源）：Mat4x4

- **6a 块**（L152-L202）：移除 L199 的 `let zero = m.c0.x - m.c0.x`
- **6b 块**（L204-L254）：移除 L251 的 `let zero = one - one`

## 类型定义

无新增类型。

## 错误处理

无变更。移除未使用的局部变量声明不改变运行时行为。

## 行为契约

- 移除前：`let zero` 声明了未使用的局部变量，cjc 1.1.0 产生编译警告
- 移除后：无警告，语义等价
- 移除操作不改变任何函数返回值、参数、可见性或类型约束

## 依赖关系

无新依赖。对依赖这些文件的消费者完全透明。

## 修订说明（v7 r1）
| 审查意见 | 修改措施 |
|---------|---------|
| type_mat2x2.cj 6a 块行号与实际不符（仅 L150 正确） | 逐行核对源码后将 6a 块行号更正为：L150, L156, L162, L168, L174, L180, L186, L192；6b 块行号更正为：L202, L208, L214, L220, L226, L232, L238, L244 |
| type_mat2x3.cj 6a 块 Mat3x4 方向行号偏差（设计 L167，实际 L169） | 将 L167 更正为 L169 |
| 审查指出多处行号偏差 | 除上述两处外，逐文件核对了全部 8 个源文件中所有 `let zero` 行的实际行号。type_mat2x4.cj、type_mat3x2.cj、type_mat3x3.cj、type_mat3x4.cj、type_mat4x2.cj、type_mat4x3.cj 的行号均与实际源码一致，无需更改 |
| `type_mat2x3.cj` 6b 块中 `Mat3x4→Mat2x3` 方向的 `let zero` 行号标注为 L219，实际应为 L221 | 将 L219 更正为 L221 |

## 修订说明（v7 r2）
| 审查意见 | 修改措施 |
|---------|---------|
| `type_mat2x3.cj` 6b 块中 `Mat3x4→Mat2x3` 方向的 `let zero` 行号标注为 L219，实际应为 L221 | 将 L219 更正为 L221 |
