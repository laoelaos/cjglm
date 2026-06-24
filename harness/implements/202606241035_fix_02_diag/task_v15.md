# 任务指令（v15）

## 动作
NEW

## 任务描述
**T15**: 补充矩阵 NaN 传播行为测试。为 3 个代表性矩阵类型（Mat4x4 / Mat2x3 / Mat3x2）补充 Float32/Float64 NaN 传播行为测试，覆盖以下场景：

1. **矩阵含 NaN 列 × 正常向量**（Mat×Vec）
   - 构造矩阵，通过 `col(i)` 将某列替换为含 NaN 分量的列向量（使用 `Float32(0.0) / Float32(0.0)` 生成 NaN）
   - 与不含 NaN 的正常向量相乘
   - 断言：结果向量中与 NaN 列对应的行位置为 NaN（通过 `nan != nan` 判别）

2. **向量含 NaN 分量 × 正常矩阵**（Vec×Mat）
   - 构造含 NaN 分量的向量，与不含 NaN 的正常矩阵相乘
   - 断言：点积结果中与 NaN 分量对应的位置为 NaN

3. **全 NaN 矩阵 × 正常向量/矩阵**（Mat×Vec 或 Mat×Mat）
   - 构造对角线含 NaN 的矩阵（如 `diagonal(NaN)`），与正常向量/矩阵相乘
   - 断言：结果全部为 NaN

4. 每种场景 × Float32/Float64 两个精度

目标文件：`tests/glm/detail/test_matrix.cj`（追加至文件末尾）

## 选择理由
T16 已验证 PASSED（v14），建立了 Float32/Float64 浮点矩阵实例化基础设施。T15 依赖 T16 完成——没有 Float 矩阵类型基础覆盖测试，NaN 测试无从执行。T15 是 Route 表格中优先级最高的剩余任务。

## 任务上下文
- 诊断报告 §4 T15（02_diag.md `:395-428`）
- OOD §5 第 825-829 行明确要求单元测试层覆盖 Mat×Vec/Vec×Mat 的 NaN 传播行为
- NaN 仅适用于 Float32/Float64 浮点类型；Int64 等整数类型无 NaN 概念
- **推荐 3 个矩阵类型**：Mat4x4（全尺寸方阵）、Mat2x3（行<列最小非方阵）、Mat3x2（行>列非方阵，与 Mat2x3 形成维度互换对照）
- IEEE 754 NaN 语义：任意含 NaN 的操作数通过原生 `+`/`*` 算术运算符产生 NaN 结果；GLM 和仓颉实现均委托底层算术运算符
- **已确认实现正确**（02_diag.md `:428`）：当前无 NaN 测试仅意味着"无人验证过"，不意味着实现有 bug

## 已有代码上下文
- `compute_vector_relational_test.cj:81-88` 提供了已验证的 NaN 生成模式：
  ```cangjie
  let nan = Float32(0.0) / Float32(0.0)
  @Expect(ComputeEqual<Float32>.call(nan, nan), false)
  ```
- `test_matrix.cj` 末尾已有约 300 行测试函数（含 T7 回填的 matrixCompMult/outerProduct 24 个 Float 变体），新测试追加至文件末尾
- 每个测试函数以 `@Test` 注解，函数名以 `test` 开头，使用 `@Expect` 宏断言
- NaN 判别方式：`@Expect(nan != nan, true)`（IEEE 754 中 NaN 与任何值比较均返回 false，包括与自身比较）
