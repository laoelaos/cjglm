# 质量审查报告 — a_v16_design_v1.md

**审查轮次**：第 16 轮  
**审查日期**：2026-06-22  
**审查范围**：需求响应充分度、事实正确性、深度完整性、落地可行性

---

## 发现的问题

### P1（严重）— matrixCompMult 和 outerProduct 的泛型约束错误

**问题描述**：§3.7 将 transpose、matrixCompMult、outerProduct 共 27 个重载的泛型约束统一从 `where T <: Number<T>, Q <: Qualifier` 放松为 `where Q <: Qualifier`，声称"这三种运算仅涉及元素索引重排或逐元素按位运算，不涉及算术运算，因此无需 Number<T> 约束"。该论述存在事实错误：

- **matrixCompMult**：实现方式为 `dst.cj[i] = x.cj[i] * y.cj[i]`（§3.7"直接实现说明"），元素级**乘法**（`*`）属于算术运算，需要 `Number<T>` 接口。
- **outerProduct**：实现方式为"列向量 c 的每个分量乘以标量 r[j]"（§3.7"直接实现说明"），同样需要 `*` 运算符和 `Number<T>` 接口。
- **transpose**：仅涉及元素索引重排，确实无需算术运算，约束放松是正确的。

按当前签名实施，这两个函数体中的 `*` 运算在缺少 `Number<T>` 约束时将无法通过编译（对 Float32/Float64/Float16/Int8~Int64/UInt8~UInt64 等所有元素类型均失败）。只有 transpose 的约束放松是有效的。

**所在位置**：§3.7，L540-542（约束放松说明段）；L519-538（matrixCompMult/outerProduct 签名）

**严重程度**：严重

**改进建议**：将 matrixCompMult 和 outerProduct 的泛型约束恢复为 `where T <: Number<T>, Q <: Qualifier`（与 determinant/inverse 一致）。transpose 可保留 `where Q <: Qualifier`。约束放松说明段需同步修正：仅声明 transpose 的约束已放松，matrixCompMult 和 outerProduct 因涉及算术运算仍需 Number<T>。

---

### P2（严重）— fromMat 9×8 转换矩阵表 Mat4x3→Mat4x4 标签错误

**问题描述**：在 fromMat 9×8 转换矩阵表中，源矩阵 Mat4x3（4×3, R=3）到目标矩阵 Mat4x4（4×4, R=4）的方向被标注为"EQL"（同尺寸）。但 Mat4x3 的行数 R=3，Mat4x4 的行数 R=4，两者**尺寸不同**。C_src=C_dst=4（列数相同），R_src=3 < R_dst=4（行数增加），正确标签应为"B: rowExt(4)"。

**所在位置**：§3.3，L369-378，Mat4x3 行、→Mat4x4 列

**严重程度**：严重

**改进建议**：将 Mat4x3→Mat4x4 的标签从"EQL"修正为"B: rowExt(4)"。同时建议逐格复核表中所有非对角线单元格的标签准确性（上轮迭代已发现并修正了 11 处同类错误，本轮新增此遗漏）。

---

### P3（中等）— 缺少对 GLM 1.0.3 头文件的系统性 API 覆盖清单

**问题描述**：用户需求明确指出参考依据包括"原始 GLM 1.0.3 头文件位于 references/glm-1.0.3/"，但当前设计文档未提供任何形式的**API 覆盖度对照表**。具体问题和后果包括：

- 无法从设计文档判断阶段二是否完整覆盖了 GLM 1.0.3 矩阵相关的全部 API。文档散列在各个章节中描述函数类别，但没有一个汇总表列出每个 GLM 头文件（如 type_mat2x2.inl、type_mat3x3.inl、matrix.inl、geometric.inl 等）中的哪些函数在阶段二完成、哪些推迟到后续阶段。
- 实施阶段无法按图索骥地对照 GLM 头文件逐项验证实现完整性。
- 后续阶段（三、四）的规划者无法基于本文档准确识别剩余工作边界。

虽然文档在 B 类方向分析中引用了具体的 .inl 行号（如 type_mat2x3.inl:122），但这仅覆盖 fromMat 场景，不是全量 API 覆盖度分析。

**所在位置**：全篇（§1-§9），尤其应在 §1 概述或 §8 产出物清单中添加独立章节

**严重程度**：中等

**改进建议**：新增独立章节"GLM 1.0.3 API 阶段覆盖矩阵"，按 GLM 头文件路径组织，每行标注函数名、阶段覆盖状态（本阶段实现/本阶段 stub/后续阶段）、对应设计方案章节。例如：

| GLM 头文件 | 函数 | 阶段覆盖 | 设计位置 |
|-----------|------|---------|---------|
| type_mat2x2.inl | 构造函数 | 本阶段实现 | §3.3 item 1-2 |
| type_mat2x2.inl | operator* | 本阶段实现 | §3.5 |
| matrix.inl | determinant | 本阶段 stub | §3.7 |
| matrix.inl | inverse | 本阶段 stub | §3.7 |
| ... | ... | ... | ... |

此表无需穷举每个 .inl 文件每一行，但应覆盖每个 GLM 头文件的**公开函数**层面。

---

### P4（中等）— scalar_mat_ops.cj 全局函数签名完全缺失

**问题描述**：§2 包组织图和 §3.5 算术运算符中均提及 `scalar_mat_ops.cj` 提供 T+Mat 等标量左侧运算的全局具名函数（add、sub、mul、div），但全文未提供任何一个函数的完整签名模板。对比 §3.3 对 9 个矩阵类型的构造函数逐类型列出完整签名、§3.7 对 33 个 stub/直接实现函数逐项列出签名的详尽程度，scalar_mat_ops.cj 的签名信息严重不足。

实现者需要明确的签名信息包括：泛型约束（是否需要 Number<T>）、参数顺序（scalar 在左、matrix 在右）、返回值类型、@OverflowWrapping 标注等。

**所在位置**：§2 L74-76（仅一句话描述）；§3.5 L407-408（仅提及文件职责）

**严重程度**：中等

**改进建议**：在 §3.5 或新增子节中，提供至少一个代表性签名模板（如 Mat2x2 版本），并说明其余 8 个矩阵类型的签名模式。例如：

```
// scalar_mat_ops.cj 签名模板
func add<T, Q>(scalar: T, m: Mat2x2<T,Q>): Mat2x2<T,Q> where T <: Number<T>, Q <: Qualifier @OverflowWrapping
func sub<T, Q>(scalar: T, m: Mat2x2<T,Q>): Mat2x2<T,Q> where T <: Number<T>, Q <: Qualifier @OverflowWrapping
func mul<T, Q>(scalar: T, m: Mat2x2<T,Q>): Mat2x2<T,Q> where T <: Number<T>, Q <: Qualifier @OverflowWrapping
func div<T, Q>(scalar: T, m: Mat2x2<T,Q>): Mat2x2<T,Q> where T <: Number<T>, Q <: Qualifier @OverflowWrapping
// 其余 8 个矩阵类型签名同上，仅 Mat{C}x{R} 替换为对应类型
```

同时应在描述中明确说明标量-矩阵运算是否需要 `Number<T>` 约束（因涉及 `*` 和 `/`，需要）。

---

### P5（一般）— col() 越界错误处理未明确声明

**问题描述**：§3.4 声明"下标越界抛出 Exception"覆盖 `[](i: Int64)`，但 `col(i: Int64)` 被描述为"与 [] 完全等价"。虽然等价性暗示了相同的错误处理行为，但设计文档中未明确声明 `col()` 的越界行为。对于正式的设计文档，等价性声明应包含行为契约的一致性确认。

**所在位置**：§3.4，L400-403

**严重程度**：一般

**改进建议**：在 `col()` 描述后补充"下标越界时抛出 Exception，与 `[]` 行为一致"。

---

## 整体评价

文档整体质量较高，覆盖了阶段二 OOD 的 9 个矩阵类型、构造函数体系、工厂函数家族、算术运算符、比较运算符、stub 函数库、别名体系等核心内容。与上一轮（v15）相比，转换矩阵表标签错误、约束放松、Bool 矩阵支持清单缺失等问题已得到系统修复。

本报告识别出的 P1（matrixCompMult/outerProduct 约束错误）和 P2（Mat4x3→Mat4x4 标签错误）属于事实性错误，P3（GLM API 覆盖清单缺失）和 P4（scalar_mat_ops.cj 签名缺失）属于深度不足问题。建议优先修复 P1 和 P2 后进入编码阶段。
