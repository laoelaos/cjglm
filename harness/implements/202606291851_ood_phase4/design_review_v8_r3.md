# 设计审查报告（v8 r3）

## 审查结果
REJECTED

## 发现

- **[一般]** A.6 节（`src/ext/quaternion_trigonometric.cj`）与概述偏差提示第 9 条存在矛盾：A.6 节写明"`sqrtT` 私有函数仍保留供 `axis` 使用"，但偏差提示第 9 条明确要求"已存在的私有 `sqrtT` 副本需移除，改为 `import glm.detail.sqrtT`"。同一份设计文档中两种对立的指示会导致编码者困惑——若按 A.6 执行会保留私有副本，同时从 `glm.detail` 导入公开版，将产生重名冲突（遮蔽）。

- **[轻微]** B.1 节（`src/ext/vector_common.cj`）函数数量描述与实际列出的重载不精确：标题写"20 个函数"、min/max 子标题写"8 个"，但描述的 3/4 输入 min/max 模式覆盖 Vec1~Vec4 各 4 个重载（min3/min4/max3/max4）实际上为 16 个。不影响实现正确性，但精确度欠佳。

- **[轻微]** A.5 节（`src/ext/quaternion_common.cj`）的 import 列表包含了 `sqrtT`，但该文件中 mix/slerp/slerp(k) 三个函数的实现均未使用 `sqrtT`。

## 修改要求（仅 REJECTED 时）

### 问题 1：A.6 节与偏差提示第 9 条矛盾

**问题**：A.6 节要求保留 `ext/quaternion_trigonometric.cj` 中的私有 `sqrtT` 副本，而偏差提示第 9 条要求移除该副本并改为从 `glm.detail` 导入。实现者无法同时遵从两个指示。

**期望的修正方向**：统一为一种策略。建议采纳偏差提示第 9 条的方案（移除私有 `sqrtT`，改为 `import glm.detail.sqrtT`），并更新 A.6 节中"`sqrtT` 私有函数仍保留供 `axis` 使用"的表述，明确说明 `axis` 中使用的 `sqrtT` 改为从 `glm.detail` 导入。
