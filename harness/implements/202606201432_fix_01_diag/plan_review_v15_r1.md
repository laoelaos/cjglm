# 计划审查报告（v15 r1）

## 审查结果
REJECTED

## 发现

### 1. [一般] 跨 Qualifier 测试数量自相矛盾
task_v15.md 第 27-28 行对跨 Qualifier 测试存在两个矛盾的要求：
- 第 27 行明确列出计算式：`sub/mul/div/mod × PackedMediump × 3 Vec + PackedLowp × 3 Vec = 4 ops × 6 = 24 个`
- 第 28 行又说：`每类只需 1 种 Qualifier 配对验证泛型兼容性（不需要 Mediump+Lowp 都测全部组合）`

前者要求对 Vec1/Vec3/Vec4 各测 PackedMediump 和 PackedLowp 两种 qualifier（24 个测试）；后者要求每类仅需 1 种 qualifier（12 个测试）。两者数量差一倍，实现者无法确定实际需求。必须澄清：
- 若要求 24 个：删除第 28 行自相矛盾的说明
- 若要求 12 个：修正第 27 行的计算式为 `4 ops × 3 = 12 个`，并指定每个 Vec 使用哪种 qualifier

### 2. [轻微] Float 类型选择未明确
第 14 行使用 `Float32（或 Float64）` 的歧义表达。实现时需确定一个具体类型以避免理解偏差：

### 3. [轻微] 边界测试未在计划中体现
第 30-33 行边界/特殊值测试列为可选，但 plan.md 和 task_v15.md 均未说明是否包含或排除。若排除应明确标注不实现。

## 修改要求（仅 REJECTED 时）

1. **跨 Qualifier 测试数量**：在 task_v15.md 第 27-28 行消除矛盾，明确总测试数（12 或 24）。若为 12，需补充每个 Vec 类型对应的 qualifier 分配方案。
