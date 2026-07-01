# 设计审查报告（v9 r1）

## 审查结果
REJECTED

## 发现

### **[一般] 1. G15 Float16 测试计数不一致**

设计第 41-43 行称"已有 Float16 测试的（7 个）：sqrtT, expT, powT, sinT, sinhT, floorT"，但括号内实际仅列出 **6 个**函数；"需补充 Float16 测试的（18 个）"后实际列出 **19 个**函数。注中写"减去已有 6 个"进一步与正文"7 个"矛盾。

经对照源代码 `stdmath_shim_test.cj` 验证：实际已有 Float16 测试的函数为 6 个（sqrtT, expT, powT, sinT, sinhT, floorT），剩余 19 个（logT, exp2T, log2T, cosT, tanT, asinT, acosT, atanT, atan2T, coshT, tanhT, asinhT, acoshT, atanhT, ceilT, roundT, truncT, absT, fmodT）。

**修正方向**：将"7 个"改为"6 个"，将"18 个"改为"19 个"，使数量与列举内容一致。

### **[一般] 2. G17 仅限 Float64 测试，未覆盖任务要求的 Float32/Float16**

设计第 60 行明确写"使用 Float64 测试（精度足够展示恒等式正确性），不需 Float32/Float16"，但任务（`task_v9.md` 第 33 行）对 G17 明确要求使用三层精度容差：`epsilon 取 1e-12 用于 Float64，1e-6 用于 Float32，1e-3 用于 Float16`。设计将范围缩小至 Float64 仅测试不符合任务要求，缺少 Float32/Float16 版本。

**修正方向**：对 G17 补充 Float32 和 Float16 版本的三角恒等式测试（含对应 epsilon 值），或在设计文档中给出充分理由说明为何 Float64 足以覆盖且无需多精度测试。
