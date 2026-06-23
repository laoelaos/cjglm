# 再审议判定报告（v16）

## 判定结果

RETRY

## 判定理由

组件B诊断报告识别出5个问题，其中P1（matrixCompMult/outerProduct约束错误）和P2（fromMat转换矩阵表Mat4x3→Mat4x4标签错误）均为严重等级的事实性错误，P3（GLM API覆盖清单缺失）和P4（scalar_mat_ops.cj签名缺失）为中等严重度，P5（col()越界处理未明确声明）为一般等级。质询报告结果为LOCATED，所有问题均经质询确认成立。由于存在严重和一般等级的问题，按判定标准应判定为RETRY。

## 需要解决的问题（仅 RETRY 时存在）

- **问题描述**：matrixCompMult和outerProduct的泛型约束从`where T <: Number<T>, Q <: Qualifier`错误地放松为`where Q <: Qualifier`，但这两个函数实现中涉及乘法运算，需要Number<T>约束
- **所在位置**：§3.7，L540-542（约束放松说明段）；L519-538（matrixCompMult/outerProduct签名）
- **严重程度**：严重
- **改进建议**：将matrixCompMult和outerProduct的泛型约束恢复为`where T <: Number<T>, Q <: Qualifier`，transpose可保留`where Q <: Qualifier`，约束放松说明段同步修正

- **问题描述**：fromMat 9×8转换矩阵表中Mat4x3→Mat4x4被错误标注为"EQL"，实际R_src=3≠R_dst=4，正确标签应为"B: rowExt(4)"
- **所在位置**：§3.3，L369-378，Mat4x3行、→Mat4x4列
- **严重程度**：严重
- **改进建议**：将Mat4x3→Mat4x4标签从"EQL"修正为"B: rowExt(4)"，并逐格复核所有非对角线单元格

- **问题描述**：设计文档未提供按GLM 1.0.3头文件组织的API覆盖度对照表，无法判断阶段二API覆盖完整性
- **所在位置**：全篇（§1-§9）
- **严重程度**：中等
- **改进建议**：新增独立章节"GLM 1.0.3 API阶段覆盖矩阵"，按GLM头文件路径组织，标注函数名、阶段覆盖状态、对应设计方案章节

- **问题描述**：scalar_mat_ops.cj全局函数（add/sub/mul/div）的完整签名模板完全缺失，实现者无法获得泛型约束、参数顺序、返回值类型等关键信息
- **所在位置**：§2 L74-76；§3.5 L407-408
- **严重程度**：中等
- **改进建议**：在§3.5中提供至少一个代表性签名模板，明确泛型约束（需要Number<T>）、参数顺序（scalar左、matrix右）、返回值类型、@OverflowWrapping标注

- **问题描述**：col()的越界行为未明确声明，虽声明与`[]`等价但未包含行为契约的一致性确认
- **所在位置**：§3.4，L400-403
- **严重程度**：一般
- **改进建议**：在col()描述后补充"下标越界时抛出Exception，与`[]`行为一致"
