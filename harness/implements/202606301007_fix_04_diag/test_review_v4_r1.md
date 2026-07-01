# 测试审查报告（v4 r1）

## 审查结果
REJECTED

## 发现
- **[一般]** `cjglm/tests/glm/ext/vector_common_test.cj` — Vec1 重载（fmin3 Vec1、fmin4 Vec1、fmax3 Vec1、fmax4 Vec1）全部缺少测试用例。设计文档（detail_v4.md:17-34, 40-51, 59-70, 76-87）明确列出了这 4 个函数签名，但测试仅覆盖 Vec2/Vec3/Vec4。Vec1 作为基础维度类型，其缺失意味着 25% 的新增函数重载未经任何验证。

## 修改要求（仅 REJECTED 时）

### 问题：Vec1 重载零覆盖

**位置**：`cjglm/tests/glm/ext/vector_common_test.cj` — 在 `fmin/fmax 3/4−input` 测试段中补充

**问题**：以下 4 个重载未被任何测试用例覆盖：
- `fmin<T,Q>(Vec1<T,Q>, Vec1<T,Q>, Vec1<T,Q>)` — fmin 3-input Vec1
- `fmin<T,Q>(Vec1<T,Q>, Vec1<T,Q>, Vec1<T,Q>, Vec1<T,Q>)` — fmin 4-input Vec1
- `fmax<T,Q>(Vec1<T,Q>, Vec1<T,Q>, Vec1<T,Q>)` — fmax 3-input Vec1
- `fmax<T,Q>(Vec1<T,Q>, Vec1<T,Q>, Vec1<T,Q>, Vec1<T,Q>)` — fmax 4-input Vec1

**为什么是问题**：设计文档将这些重载列为该变更的正式交付物。测试套件未覆盖它们意味着回归测试存在缺口——编译器重载决议、委托链或标量层变更可能破坏这些函数而测试无法感知。Vec1 测试虽简单，但完整性对持续集成至关重要。

**期望的修正方向**：为每个缺失的 Vec1 重载添加一个测试用例（fmin3、fmin4、fmax3、fmax4 各一），采用与 Vec2/3/4 相同的模式（三输入一输出，标量值可手动验证）。可选择添加 NaN 场景的 Vec1 测试以保持一致。
