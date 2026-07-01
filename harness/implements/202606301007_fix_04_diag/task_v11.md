# 任务指令（v11）

## 动作
NEW

## 任务描述
为 `tests/glm/detail/matrix_test.cj` 补充 Mat3x3/Mat4x4 在 Float32/Float64 下的 determinant 测试，共 4 个新增测试函数。同步更新 `docs/diag/impl/04_diag.md` 标记 G23 为已修复，更新 `plan.md` 路线表 v11 列标记 P4-2 第二批进度。

## 选择理由
v10 已完成 P4-2 第一批（G21+G22 几何边界测试）。按 `04_diag.md` 几何/矩阵测试分批顺序：
- 第一批：G21/G22 ✅（v10）
- 第二批：G23 ← 当前任务
- 第三批：G33（matrix_access_test）
- 第四批：G32（matrix_inverse_test）

G23 为 matrix_test.cj 的自然延续——已有 Mat2x2 Float32/Float64 determinant 测试，缺少 Mat3x3/Mat4x4 浮点版本，修改范围小、自包含。

## 任务上下文
**问题诊断（04_diag.md:314-318）：**
```
### G23: matrix_test.cj 缺少 3x3/4x4 Float32/Float64 determinant 测试
- 真实性：真实问题
- 根因：测试覆盖遗漏
- 修改方向：补充 Mat3x3/Mat4x4 在 Float32/Float64 下的 determinant 测试
```

## 已有代码上下文
- `tests/glm/detail/matrix_test.cj:276-287` 已有 Mat2x2 浮点 determinant 测试模式：
  ```cangjie
  @Test
  func testDeterminantMat2x2Float32(): Unit {
      let m = Mat2x2<Float32, Defaultp>(Float32(1.5), Float32(2.5), Float32(3.5), Float32(4.5))
      let det = determinant(m)
      @Expect(det, Float32(1.5) * Float32(4.5) - Float32(3.5) * Float32(2.5))
  }
  ```

- 已有 Int64 版本 Mat3x3/Mat4x4 determinant 测试（`:264-272`），提供参考矩阵输入值

- 04_diag.md:314-318 G23 条目需在末尾添加 `✅ 已修复` 标记

## 测试设计要点
- Mat3x3 浮点 determinant 使用 Sarrus 规则校验和：`a(ei−fh) − b(di−fg) + c(dh−eg)`
- Mat4x4 浮点 determinant 使用 Laplace 展开校验和
- 所有新增测试使用 Float32 + Float64 两种类型，Defaultp 精度限定符
- 测试函数命名遵循既有约定：`testDeterminantMat{3|4}x{3|4}Float{32|64}`
- 新增测试放在既有 determinant 测试之后（`:287` 行之后），与同类测试相邻
