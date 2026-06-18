# 质量审查报告（v3 首轮）

## 审查范围

- 产出：`a_v3_output_v1.md`
- 审查视角：使用者视角 — 产出是否可直接投入使用、是否覆盖所有显式和隐式需求、边界情况和异常处理是否完备
- 侧重维度：需求响应充分度、整体深度和完整性（内部审议已覆盖技术可行性，本报告不重复验证）
- 审查方法：逐项核对用户需求、查阅 GLM 参考源码（`references/glm-1.0.3/glm/glm/fwd.hpp`、`detail/setup.hpp`、`detail/compute_vector_relational.hpp`、`detail/compute_vector_decl.hpp`、`detail/_vectorize.hpp`、`detail/_swizzle.hpp`）

---

## 问题清单

### 问题1：事实错误 — 3D 节辅助文件数量与 3E 节清单状态矛盾

**问题描述**：
3D 节「首轮范围规模总结」表中"向量辅助文件"行将 `_swizzle.hpp` 列为 4 个辅助文件之一，得出"合计核心文件 = 2 基础设施 + 4 vec 模板 + 4 辅助文件 = 10 个文件"。然而 3E 节文件清单中 `_swizzle.hpp` 被标注为排除（子范围列写"见 P5 风险说明"，序号为"—"不纳入计数），4.5 节推荐方案 A 明确"首轮默认关闭 swizzle，`_swizzle.hpp` 排除出首轮范围"。两个节对同一文件的处理状态矛盾。

**所在位置**：
- 3D 节第 283 行：向量辅助文件列表包含 `_swizzle.hpp`
- 3D 节第 284 行：合计核心文件 = 10
- 3E 节第 302 行：`_swizzle.hpp` 标注排除
- 4.5 节第 508 行：推荐方案 A 排除 swizzle

**严重程度**：严重

**改进建议**：
- 将 3D 节辅助文件行中的 `_swizzle.hpp` 移除，改为 3 个辅助文件
- 合计核心文件改为 2 + 4 + 3 = 9 个文件
- 可在辅助文件行添加注释说明 `_swizzle.hpp` 已被排除（而非列为计数项）

---

### 问题2：依赖描述遗漏 — `compute_vector_decl.hpp` 的 `<functional>` 和 `<limits>` 依赖未声明

**问题描述**：
3E 节文件清单表第 4 项（`compute_vector_decl.hpp`）的"直接依赖"列标注为 `setup.hpp` + `qualifier.hpp`（通过包含上下文）。但经查阅 GLM 源码 `compute_vector_decl.hpp:3-4`，该文件 `#include <functional>`（使用 `std::plus<T>`、`std::minus<T>`、`std::multiplies<T>`、`std::divides<T>`、`std::modulus<T>` 等函数对象），且第 163 行通过传递引用使用 `std::numeric_limits<T>::is_iec559`。在 CangJie 模块系统下，不存在 C++ 的"传递包含上下文"，每个文件需显式声明自身依赖。缺失这两项依赖的描述将导致实施者低估该文件的迁移适配范围。

**所在位置**：
- 3E 节第 296 行：`compute_vector_decl.hpp` 依赖列
- 0.7 节第 75-76 行：`<limits>` 表仅关联到 `compute_vector_relational.hpp`，未提及 `compute_vector_decl.hpp` 也使用 `std::numeric_limits`
- 0.7 节第 76-77 行：`<functional>` 表仅描述 `std::function`，但实际使用是 `std::plus<T>` 等函数对象

**严重程度**：中

**改进建议**：
- 在文件清单 `compute_vector_decl.hpp` 的依赖列补充 `<functional>` 和 `<limits>`（需 CangJie 等效替代）
- 在 0.7 节 `<limits>` 行的"首轮影响"列中同步标明 `compute_vector_decl.hpp` 也使用该设施
- 在 0.7 节 `<functional>` 行中区分"函数对象（std::plus 等）"与"类型擦除包装器 std::function"的差异及各自替代方案

---

### 问题3：信息不准确 — 0.8 节关于 `<functional>` 的首轮需求判断与首轮范围自相矛盾

**问题描述**：
0.8 节关键适应性结论表中 `<functional>` 行的"首轮是否需要"列写为"否（辅助文件）"。然而 `compute_vector_decl.hpp`（依赖 `<functional>`）是首轮范围内的辅助文件（3E 节序号 4，子范围 2a）。这意味着 `<functional>` 中使用的功能（`std::plus<T>` 等函数对象）在首轮就需要提供替代实现，与表中"否"的判断矛盾。

**所在位置**：
- 0.8 节第 92 行：`<functional>` 行"首轮是否需要" = "否"

**严重程度**：轻微

**改进建议**：
- 将 `<functional>` 行的"首轮是否需要"改为"是"或"部分需要"，并说明"`compute_vector_decl.hpp` 使用的 `std::plus<T>` 等函数对象需 Lambda 替代"
- 或维持"否"但澄清：不需要完整 `<functional>` 标准库，仅需在 `compute_vector_decl.hpp` 中替换具体函数对象用法

---

### 问题4：关键遗漏 — 文件清单缺少 CangJie shim 层对应条目

**问题描述**：
首轮范围内有 3 处 C++ 标准库依赖需要 CangJie 等效替代：`setup.hpp` 依赖 `<cassert>` 和 `<cstddef>`（0.7 节第 73-74 行）、`compute_vector_relational.hpp` 依赖 `<limits>`（0.7 节第 75 行）。3E 节文件清单表中虽然在各文件依赖列标注了"需 CangJie shim"，但未在任何条目中列出 shim 层对应的文件。从"可直接投入使用"视角，实施者将首轮 11 个文件条目逐一迁移后，会发现缺少 assert 函数、`numeric_limits` 等价等功能，需要临时补充，破坏"可独立编译验证"约束。

**所在位置**：
- 3E 节第 293-305 行：文件清单表，无 shim 层条目
- 0.7 节第 73-75 行：`<cassert>`、`<cstddef>`、`<limits>` 的替代需求描述

**严重程度**：中

**改进建议**：
- 在文件清单表中新增 1-2 个 shim 层文件条目（如 `shim_assert.cj`、`shim_numeric_limits.cj`），标注其依赖为"无 GLM 内部依赖"
- 或在 3E 节增加注释说明 shim 层的处理策略（内联各文件内 vs 独立 shim 文件），并给出推荐目录位置

---

### 问题5：事实错误 — 0.7 节将 `std::plus<T>` 等函数对象误称为 `std::function`

**问题描述**：
0.7 节第 76-77 行描述 `<functional>` 的用途为"`compute_vector_decl.hpp` 中的 `std::function` 等价"。经查阅源码，`compute_vector_decl.hpp:56-92` 实际使用的是 `std::plus<T>()`、`std::minus<T>()`、`std::multiplies<T>()`、`std::divides<T>()`、`std::modulus<T>()` 等标准函数对象（function objects），而非类型擦除包装器 `std::function`（`std::function` 是该文件中不存在的类型）。函数对象在 CangJie 中可直接用 Lambda 表达式替代，复杂度远低于 `std::function` 的替代方案（泛型函数类型参数）。该错误命名可能误导实施者采取不必要的复杂替代策略。

**所在位置**：
- 0.7 节第 76 行：`<functional>` 行"用途"列

**严重程度**：轻微

**改进建议**：
- 将用途描述修正为"`compute_vector_decl.hpp` 中的 `std::plus<T>` 等标准函数对象"而非 `std::function`
- 替代方案相应调整为"直接使用 Lambda 表达式替代函数对象调用"

---

### 问题6：事实错误 — `compute_vector_decl.hpp` 对 `std::numeric_limits` 的依赖在 0.7 节 `<limits>` 行中被遗漏

**问题描述**：
0.7 节第 75 行 `<limits>` 的"用途"列仅关联到 `compute_vector_relational.hpp`。但 `compute_vector_decl.hpp:163` 也使用了 `std::numeric_limits<T>::is_iec559`，属于该依赖的消费者。此外，`compute_vector_decl.hpp` 中使用 `std::size_t` 作为模板参数（`compute_vector_decl.hpp:27` 等），属于 `<cstddef>` 的间接依赖，在 0.7 节中仅 `setup.hpp` 被关联到 `<cstddef>`。

**所在位置**：
- 0.7 节第 75 行：`<limits>` 首轮影响描述遗漏 `compute_vector_decl.hpp`
- 0.7 节第 73 行：`<cstddef>` 首轮影响描述遗漏 `compute_vector_decl.hpp`

**严重程度**：轻微

**改进建议**：
- 在 `<limits>` 行补充 `compute_vector_decl.hpp` 对 `std::numeric_limits<T>::is_iec559` 的使用
- 在 `<cstddef>` 行补充 `compute_vector_decl.hpp` 对 `std::size_t` 的使用

---

### 问题7：遗漏 — 第 0 节未评估 `_vectorize.hpp` 中偏特化模式的 CangJie 适配影响

**问题描述**：
0.1 节详细评估了 CangJie 不支持偏特化对 `vec<N,T,Q>` 的影响，并提出独立结构体或宏的替代方案。但首轮辅助文件 `_vectorize.hpp` 中的 `functor1`、`functor2`、`functor2_vec_sca`、`functor2_vec_int` 四个模板同样大量使用 C++ 偏特化（对 `L` 分量数参数的特化）。该文件被列为"纯类型工具文件，无进一步 GLM 内部依赖"，但文档未评估偏特化不支持对该文件迁移的影响。实施者到实施阶段才会发现 `_vectorize.hpp` 需要与 `vec<N,T,Q>` 相同的结构重构。

**所在位置**：
- 0.1 节第 15-16 行：偏特化评估仅提及 `vec<N,T,Q>`
- 文件清单第 5 项 `_vectorize.hpp`：依赖描述未提及偏特化问题
- 第 5 节图注第 569 行：标注"无进一步 GLM 内部依赖"但未提及偏特化影响

**严重程度**：轻微

**改进建议**：
- 在 0.1 节或文件清单 `_vectorize.hpp` 条目中补充说明其偏特化模式与 `vec<N,T,Q>` 面临相同 CangJie 限制
- 建议替代方案：为 `functor1`/`functor2` 按分量数分别定义结构体，或使用宏生成各分量数版本

---

## 整体质量评价

产出在需求响应充分度方面表现良好（三个需求均已覆盖，约束均得到响应），语言适应性分析全面，验证标准可操作。主要质量问题集中在**内部一致性和依赖完整性**方面：`_swizzle.hpp` 在 3D 节（总结表）与 3E 节（文件清单）的处理状态矛盾（问题 1）是最严重的问题，需优先修正；`compute_vector_decl.hpp` 的依赖描述缺失 `<functional>` 和 `<limits>`（问题 2）从可直接投入使用视角构成了中等程度的工程障碍；其余 5 个问题属轻微缺陷或信息不准确。修复以上 7 个问题后，产出可投入使用。
