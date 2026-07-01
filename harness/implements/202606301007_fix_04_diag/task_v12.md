# 任务指令（v12）

## 动作
NEW

## 任务描述
完成 P4-2 几何/矩阵测试补充的剩余任务：G33（matrix_access_test 类型维度补全）+ G32（matrix_inverse_test 恒等式验证）。

1. 为 `tests/glm/gtc/matrix_access_test.cj` 补充 Mat2x2/Mat3x2/Mat4x3 三个缺失类型的 row/column 测试
2. 为 `tests/glm/gtc/matrix_inverse_test.cj` 补充 inverseTranspose == transpose(inverse(m)) 恒等式一致性验证
3. 更新 `docs/diag/impl/04_diag.md` 标记 G32/G33 为 ✅ 已修复
4. 更新 `plan.md` 路线表 v12 列标记 P4-2 全部完成 ✅

## 选择理由
v11 已完成 P4-2 第二批（G23 matrix determinant 浮点测试）。按 `04_diag.md` 几何/矩阵测试分批顺序：
- 第一批：G21/G22 ✅（v10）
- 第二批：G23 ✅（v11）
- 第三批：G33（matrix_access_test）← 当前任务
- 第四批：G32（matrix_inverse_test）← 当前任务

G33 和 G32 均为纯测试补充，修改范围小、自包含、不涉及生产代码变更，适合合并为一轮完成。

## 任务上下文

### G33: matrix_access_test.cj 缺少 Mat2x2/Mat3x2/Mat4x3 row/column 测试
**问题诊断（04_diag.md:385-389）：**
```
### G33: gtc/matrix_access_test.cj 缺少 Mat2x2/Mat3x2/Mat4x3 三个类型的 row/column 测试
- 真实性：真实问题
- 根因：测试覆盖遗漏
- 修改方向：补充缺失矩阵类型的 row/column 测试
```

**已有代码上下文：**
- `tests/glm/gtc/matrix_access_test.cj`：已有以下类型的 row/column 测试：
  - Mat3x3（testRowMat3x3, testColumnMat3x3）
  - Mat3x4（testRowMat3x4, testColumnMat3x4）
  - Mat4x2（testRowMat4x2, testColumnMat4x2）
  - Mat4x3（testRowMat4x3, testColumnMat4x3）
  - Mat4x4（testRowMat4x4, testColumnMat4x4）
- 缺失：Mat2x2, Mat3x2, Mat4x3（共 3 个类型 × row + column = 6 个测试函数，与既有模式一致）

### G32: matrix_inverse_test.cj 缺少 inverseTranspose 恒等式验证
**问题诊断（04_diag.md:379-383）：**
```
### G32: gtc/matrix_inverse_test.cj 缺少 inverseTranspose == transpose(inverse(m)) 一致性验证
- 真实性：真实问题
- 根因：测试覆盖遗漏
- 修改方向：补充恒等式一致性验证
```

**已有代码上下文：**
- `tests/glm/gtc/matrix_inverse_test.cj`：已有 inverseMat2/Mat3/Mat4 的行列式验证
- 补充方式：对 eachMatrixType（Mat2x2, Mat3x3, Mat4x4）执行 `@Expect(inverseTranspose(m), transpose(inverse(m)))`，使用已有矩阵值

## 设计要点
- 全部变更限于测试文件，不修改生产代码
- 测试函数命名遵循既有约定：`test{Row|Column}Mat{类型}`、`testInverseTransposeConsistencyMat{类型}`
- 新增测试放在各文件末尾
- 矩阵构造值和已有同类测试保持一致风格
