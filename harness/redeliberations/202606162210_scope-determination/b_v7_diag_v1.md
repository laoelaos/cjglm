# 质量审查报告 — a_v7_output_v1.md

审查视角：通用执行产出质量审查，侧重需求响应充分度、事实准确性、深度与完整性

---

## 问题 1（严重）：Section 1 中 `_swizzle.hpp` 范围状态与排除结论矛盾

**问题描述**：Section 1（层次 1 描述，第 127 行）的注文同时包含两个矛盾的断言——前半句称 `_swizzle.hpp` "作为 `type_vecN.hpp` 的条件编译依赖纳入范围"，后半句称"首轮建议将 swizzle 暂时禁用"。若 swizzle 被禁用，则 `_swizzle.hpp` 在任何意义上都不属于首轮范围，不存在"纳入范围但禁用"的状态。Section 3D、3E、4.5 节均已明确将 `_swizzle.hpp` 排除出首轮范围（3D 辅助文件从 4 个减为 3 个，3E 标注为"已排除"），此时 Section 1 仍保留"纳入范围"的描述，构成逻辑矛盾。实现者若仅阅读 Section 1 会得到错误的范围认知。

**所在位置**：第 1 节，层次 1 描述末尾的注文（第 127 行）

**严重程度**：严重

**改进建议**：将 Section 1 注文中的"纳入范围"表述删除或修改为"在默认 `GLM_SWIZZLE_OPERATOR` 模式下本应作为条件编译依赖被包含，但首轮已选择禁用 swizzle（方案 A，详见 4.5 节），故 `_swizzle.hpp` 排除出首轮范围"。确保全文对 `_swizzle.hpp` 的范围状态表述一致。

---

## 问题 2（严重）：`type_vec3.inl` 和 `type_vec4.inl` 的 `GLM_CONFIG_SIMD` 条件包含未被覆盖

**问题描述**：文档在 3A.2 节讨论了 `qualifier.hpp` 中 `storage` 结构体的 SIMD 平台特化，但未分析 `type_vec3.inl`（第 833 行）和 `type_vec4.inl`（第 1023 行）底部的条件编译块：
```cpp
#if GLM_CONFIG_SIMD == GLM_ENABLE
#  include "type_vec_simd.inl"
```
这两个 `.inl` 文件各自包含了约 150 行 SIMD 平台特化代码（含 `reinterpret_cast`、SSE/NEON 内部指令等），且 `type_vec_simd.inl` 不在首轮范围内。文档当前未提及 `GLM_CONFIG_SIMD` 的首轮配置策略，若实现者将 `GLM_CONFIG_SIMD` 保留为默认的 `GLM_ENABLE`，`cjpm build` 必然失败（缺少 `type_vec_simd.inl`）。

经源文件确认，`type_vec1.inl` 和 `type_vec2.inl` 底部无此条件包含，但 `type_vec3.inl` 和 `type_vec4.inl` 均有。

**所在位置**：第 3A 节（首轮基础设施层）、第 3E 节文件清单第 8-9 行的依赖列

**严重程度**：严重

**改进建议**：
1. 在 3A.1 节的 `GLM_CONFIG_*` 常量清单中明确列出 `GLM_CONFIG_SIMD`，标注首轮必须设置为 `GLM_DISABLE`
2. 在 3E 节文件清单第 8 行（`type_vec3`）和第 9 行（`type_vec4`）的依赖列补充条件性注释："注：当 `GLM_CONFIG_SIMD == GLM_ENABLE` 时传递依赖 `type_vec_simd.inl`（首轮已置为 `GLM_DISABLE`，此条件包含不触发）"
3. 在 4.4 节验证标准的"依赖闭合性"步骤中增加 `GLM_CONFIG_SIMD` 配置检查

---

## 问题 3（中）：`compute_vector_decl.hpp` 的 `<limits>` 依赖类型描述不精确

**问题描述**：文档在 3E 节文件清单第 4 行的依赖列中将 `<limits>` 列为 `compute_vector_decl.hpp` 的直接依赖。经查源文件 `compute_vector_decl.hpp` 未直接 `#include <limits>`——该文件第 163 行使用 `std::numeric_limits<T>::is_iec559`，但此符号通过包含链中的 `compute_vector_relational.hpp`（第 5 行 `#include <limits>`）间接获得。文档将其标注为"直接依赖"不够精确。在 CangJie 迁移中，直接依赖和传递依赖的区别影响 shim 层的 import 语句设计——如果 `compute_vector_decl.cj` 需要 `shim_limits`，它必须自己 `import` 或通过明确的传递链获得，不能依赖 C++ 式的间接包含。

**所在位置**：3E 节文件清单第 4 行（`compute_vector_decl.hpp`）的依赖列

**严重程度**：中

**改进建议**：将依赖列中的 `<limits>` 改为注释形式 "（`<limits>` 通过传递包含链引入——`compute_vector_relational.hpp` 已包含；CangJie 迁移中需确保 `shim_limits.cj` 在 import 路径中可用）"。同时检查 0.7 节 `<limits>` 行的描述，补充说明此依赖为传递性质。

---

## 问题 4（中）：`@OverflowWrapping` 标注范围缺乏量化指导和类别区分

**问题描述**：文档 0.5 节和 0.8 节推荐"在每个向量算术运算符函数上标注 `@OverflowWrapping`"，但未区分以下关键细节：

1. **运算符类别**：CangJie 中只有算术运算符（`+`、`-`、`*`、`/`、`++`、`--`）和左移（`<<`）可能溢出；位运算（`&`、`|`、`^`、`>>`、`~`）和比较运算（`==`、`!=`、`&&`、`||`）不会溢出。不需要全部标注，但文档未给出区分标准。

2. **标注范围量化**：仅 `type_vec1.inl` 就有约 35 个运算符函数（含成员和非成员）；4 个 Vec 类型合计约 140+ 个运算符函数。若不加区分地全部标注，不仅冗余且遗漏了"哪些不应标注"的判断依据。

3. **非成员运算符**：`operator+`、`operator-` 等非成员运算符通过委托 `operator+=` 等成员运算符实现（如 `return vec<4,T,Q>(v1) += v2`），理论上只需标注成员运算符即可覆盖。文档未利用此特性减少标注量。

4. **浮点类型的溢出语义**：Vector 的分量类型可以是 `Float32`/`Float64`。CangJie 浮点运算不会抛出整数溢出异常，但 `@OverflowWrapping` 在浮点类型上的行为语义未讨论。不加区分地"每个算术运算符函数"标注可能导致浮点运算函数上无意义地附加注解。

**所在位置**：第 0.5 节（第 65 行）、第 0.8 节（第 98 行）

**严重程度**：中

**改进建议**：
1. 补充运算符分类表，明确标注策略：算术运算符（`+`、`-`、`*`、`/`、`++`、`--`）→ `@OverflowWrapping`；左移 `<<` → `@OverflowWrapping`；位运算/比较/布尔运算 → 无需标注
2. 建议利用 `operator+` 等非成员运算符委托 `operator+=` 的特性，实际仅需在复合赋值运算符（`+=`、`-=`、`*=`、`/=`）上标注，而非"每个运算符函数"
3. 补充说明浮点类型分量不受溢出注解影响的可忽略性，以简化实现决策
4. 量化标注工作量（首轮 Vec1~Vec4 按此策略约需标注 16~20 个成员运算符函数）

---

## 总结

文档整体质量较高，经过 6 轮内部迭代后核心内容准确完整。上述 4 个问题中，问题 1 和 2 属逻辑矛盾和关键遗漏，建议优先修复；问题 3 和 4 属精确性和完整性不足，建议择机补充。
