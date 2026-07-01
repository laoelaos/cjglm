# 设计审查报告（v9 r1）

## 审查结果
REJECTED

## 发现

### **[一般]** `dquat` 类型别名与已有定义冲突且未提及

`type_precision.cj` 设计清单中包含 `public type dquat = Quat<Float64, Defaultp>`，但 `glm.ext.quaternion_double.cj:3` 已经定义了 `public type dquat = Quat<Float64, PackedHighp>`（虽然 `Defaultp == PackedHighp`，类型实质相同，但名称冲突）。

当前批次由于文件分属不同包 (`glm.gtc` vs `glm.ext`) 不会触发编译错误，但 R10 更新 `lib.cj` 时（使 `lib.cj` 同时 `public import glm.ext.{dquat}` 和 `public import glm.gtc.{dquat}`），将产生名称冲突导致编译失败。设计未提及此冲突或给出解决方案（如：删除 `glm.ext` 中的 `dquat` 定义、在 `type_precision.cj` 中跳过 `dquat`、或 R10 统一处理时用别名重命名）。

**期望修正方向**：在设计中明确标注此冲突，并指定解决方案（例如：R10 时删除 `glm.ext.quaternion_double.cj:3` 的 `dquat` 定义，统一由 `type_precision.cj` 提供）。

### **[轻微]** 函数数量标注不一致

`packing.cj` 节标注"函数清单（共 27 个）"，但实际列出 32 个函数签名（unorm 系 12 + snorm 系 12 + half 系 6 + double 系 2 = 32）。请将标注修正为 32 或使用"~32"近似表述。

### **[轻微]** `fvec1` 精度规范风格不统一

`type_precision.cj` 中 `fvec1 = Vec1<Float32, PackedHighp>` 使用显式 `PackedHighp`，而 `dvec1`、`ivec2` 等其他家族使用 `Defaultp`。虽 `Defaultp == PackedHighp` 无实质差异，但风格不一致，建议统一为 `Defaultp` 以保持项目惯例。

### **[轻微]** `packHalf` 位转换算法不够具体

`packHalf1x16/2x16/4x16` 的 Float32↔Float16 位转换仅描述位布局（1-8-23 / 1-5-10），未给出具体转换步骤。建议补充核心转换算法（如 IEEE 754 半精度转换伪代码）或明确引用 GLM 参考实现中 `detail::toFloat16` 的逻辑。
