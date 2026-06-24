# 任务指令（v8）

## 动作
NEW

## 任务描述
T2: 补充 9 个矩阵类型 Hashable 测试

在 `test_type_mat_compare.cj` 中为矩阵类型补充 Hashable 运行时测试，验证 `@Derive[Hashable]` 正确展开。至少覆盖以下 3 类场景，选取 1~2 个代表性矩阵类型（建议 Mat4x4 + Mat2x3），每类场景以 Int64 和 Float32 两种元素类型实例化：

1. **相同性一致性**：同一值的两个矩阵副本 hash() 返回值相同
2. **不同值差异性**：不同值的矩阵 hash() 返回值不同
3. **跨类型编译**：至少 Int64 和 Float32 两种类型均可编译通过

## 选择理由
Route 表格顺序中的下一个待完成任务（T8 已验证 PASSED），操作独立文件 `test_type_mat_compare.cj`，与已有 T9/T10/T14/T17 无文件冲突，可独立并行执行。

## 任务上下文
- 所有 9 个矩阵类型（`type_mat2x2.cj`~`type_mat4x4.cj`）第 6 行均标注 `@Derive[Hashable]`
- 当前测试目录 `tests/glm/detail/` 中 0 个 hash 相关用例
- `@Derive[Hashable]` 是编译期宏展开，编译器无法检测导出错误 hash 逻辑，需运行时测试

## 已有代码上下文
- `test_type_mat_compare.cj`：已有矩阵比较测试（`==`/`!=`），可在该文件中追加 hash 测试或新建独立测试文件
- 测试框架使用 `std.unittest`，`@Test` 注解 + `@Expect` 宏
- 最小覆盖标准（摘自诊断报告 §4 T2）：
  - 不要求验证哈希冲突概率或分布质量
  - 不要求 Bool 矩阵的 Hashable 测试
  - 核心目标：确认 @Derive 宏在矩阵结构体（含多个列向量成员）上正确展开，且不同值的矩阵产生不同哈希值
