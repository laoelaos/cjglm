# 任务指令（v7）

## 动作
NEW

## 任务描述
**detail/matrix.cj** — 替换 `src/detail/matrix.cj` 中第 167~173 行的 6 个 stub 为完整实现：`determinant`（Mat2x2/Mat3x3/Mat4x4）+ `inverse`（Mat2x2/Mat3x3/Mat4x4）。

同时修改 `tests/glm/detail/matrix_test.cj` 中 6 个 stub 测试（`testDeterminantMat*Stub`、`testInverseMat*Stub`）为真实测试，补充 Float32/Float64 浮点覆盖和奇异矩阵 NaN 传播验证。

## 选择理由
Task 6 是路线表中下一个未完成的任务。matrix.cj 的 determinant/inverse 是后续任务（gtc/matrix_inverse、gtc/matrix_transform 等）的直接依赖。所有输入类型（Mat2x2/3x3/4x4）已在阶段二就绪，无其他未完成任务依赖。

## 任务上下文

### 设计规格（来自 docs/06_ood_phase4.md §3.1 matrix.cj）

- **determinant**：
  - Mat2x2：`m[0][0]*m[1][1] - m[1][0]*m[0][1]`
  - Mat3x3：标量三重积展开
  - Mat4x4：拉普拉斯展开（或分块矩阵求行列式）
- **inverse**：
  - Mat2x2：`1/det * [[a22, -a12], [-a21, a11]]` 公式
  - Mat3x3：余子式矩阵 ÷ 行列式
  - Mat4x4：余子式展开（cofactor expansion），与 GLM 1.0.3 `func_matrix.inl` 第 388~446 行 `compute_inverse<4,4,T,Q,Aligned>` 一致
- 约束：`determinant` 使用 `T <: Number<T>`（纯算术运算）；`inverse` 需要 `T <: FloatingPoint<T>`（需要除法）
- 奇异矩阵行为：奇异矩阵求逆的结果由 IEEE 754 浮点运算自然决定。当 det=0 时，1/det → Inf，Inf × 余子式中的零分量产生 NaN，函数不抛出异常

### 已有代码上下文

- 当前 stub 在 `src/detail/matrix.cj:167-173`：
  ```cangjie
  public func determinant<T, Q>(m: Mat2x2<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
  public func determinant<T, Q>(m: Mat3x3<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
  public func determinant<T, Q>(m: Mat4x4<T, Q>): T where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
  public func inverse<T, Q>(m: Mat2x2<T, Q>): Mat2x2<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
  public func inverse<T, Q>(m: Mat3x3<T, Q>): Mat3x3<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
  public func inverse<T, Q>(m: Mat4x4<T, Q>): Mat4x4<T, Q> where T <: Number<T>, Q <: Qualifier { throw Exception("stub") }
  ```
- 已有完整实现的函数：`transpose`（9 重载）、`matrixCompMult`（9 重载）、`outerProduct`（9 重载）——同文件的前 166 行
- 测试文件 `tests/glm/detail/matrix_test.cj` 已有 1113 行，含 transpose/matrixCompMult/outerProduct 测试和 NaN 传播测试
- 6 个 stub 测试在 matrix_test.cj:258-321，使用 `try-catch` 断言 `@Expect(e.message, "stub")`

### 修改文件
- `src/detail/matrix.cj` — 替换第 167-173 行的 6 个 stub 为完整实现
- `tests/glm/detail/matrix_test.cj` — 替换 6 个 stub 测试为真实测试，补充浮点覆盖
