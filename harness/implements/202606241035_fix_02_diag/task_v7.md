# 任务指令（v7）

## 动作
NEW

## 任务描述
移除全部 9 个 `src/detail/type_mat*.cj` 文件中纯收缩方向 `fromMat` 方法体内的未使用 `let zero` 声明。

**纯收缩方向定义**：`C_dst ≤ C_src 且 R_dst ≤ R_src`（目标行列均不大于源），该方向下函数体仅做截断操作，不引用 `zero` 变量。

受影响文件及文件内具体方法：
- **6a 变体**（`let zero = m.c0.x - m.c0.x`）和 **6b 变体**（`let zero = one - one`）均需要检查

按纯收缩方向计（从各源矩阵出发，非 EQL）：
- Mat2x2 作为目标：全部 8 个 fromMat 均为纯收缩 → 8 × 2 变体 = 16 条需移除
- Mat2x3 作为目标：from Mat2x4, Mat3x3, Mat3x4, Mat4x3, Mat4x4（5 方向）→ 10 条
- Mat2x4 作为目标：from Mat3x4, Mat4x4（2 方向）→ 4 条
- Mat3x2 作为目标：from Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4（5 方向）→ 10 条
- Mat3x3 作为目标：from Mat3x4, Mat4x3, Mat4x4（3 方向）→ 6 条
- Mat3x4 作为目标：0 个纯收缩方向（始终至少一个维度扩展）
- Mat4x2 作为目标：from Mat4x3, Mat4x4（2 方向）→ 4 条
- Mat4x3 作为目标：from Mat4x4（1 方向）→ 2 条
- Mat4x4 作为目标：0 个纯收缩方向

合计约 **54 条** `let zero` 声明需移除。

## 选择理由
Phase 4 路线表顺序执行，T8 为下一个未完成任务。cjc 1.1.0 对未使用变量产生编译警告（verify_v6.md 已验证），需消除。

## 任务上下文
- 诊断报告 §3 T8 已精确定位根因并提供计数
- OOD §3.3 第 385-393 行 9×9 转换矩阵表定义了纯收缩方向
- 纯收缩方向下签名中保留 `one` 参数（OOD §3.3 第 286 行说明"纯收缩方向下 `one` 参数被忽略"），仅移除函数体内的未使用 `let zero` 声明
- 移除操作安全：删除未使用的局部变量声明不会改变任何行为

## 已有代码上下文
每个 `type_mat*.cj` 文件包含两个 `extend` 块的 `fromMat` 方法群：
1. **6a 变体**（`extend<T, Q> MatXxY<T, Q> where T <: Number<T>, Q <: Qualifier`）：无 conv 参数，使用 `let zero = m.c0.x - m.c0.x`
2. **6b 变体**（另一个 `extend<T, Q> MatXxY<T, Q> where T <: Number<T>, Q <: Qualifier`）：有 `conv` 参数，使用 `let zero = one - one`

操作方式：逐文件、逐方法检查，若方法体未引用 `zero` 变量则移除对应的 `let zero` 行。
