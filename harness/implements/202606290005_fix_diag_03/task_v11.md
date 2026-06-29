# 任务指令（v11）

## 动作
NEW

## 任务描述
修改 `cjglm/src/lib.cj`，完成两处变更：

1. **G3.8** — 将 `import glm.ext.*`（第 14 行）和 `import glm.gtc.*`（第 16 行）两个通配符导入替换为 OOD §2（`docs/05_ood_phase3.md:304-323`）指定的逐项显式 import 列表，消除 17 个 unused import 编译警告。同时将 `import glm.detail.{sin, cos, tan, asin, acos, atan, atan2, sinh, cosh, tanh, asinh, acosh, atanh, radians, degrees}`（第 12 行）改为 `public import` 以消除对应的 unused import 警告。

2. **G3.9** — 在 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}`（第 10 行）中添加 `Quat` → `public import glm.detail.{Quat, mat3Cast, mat4Cast, quatCast}`。

## 选择理由
G2.2 完成后，G3.8+G3.9 为路线中优先级最高的剩余 Medium 任务。两者均针对同一文件（`lib.cj`），合并为单个任务集中修改。通配符→显式可消除 unused import 警告并与 OOD §2 对齐；添加 Quat public import 使 `glm.Quat` 路径可用。

## 任务上下文
### OOD §2 预期的 import 清单（docs/05_ood_phase3.md:303-324）
共 20 条，包括：
- `public import glm.detail.{Quat, mat3Cast, mat4Cast, quatCast}` — 四元数类型 + 转换函数
- `import glm.detail.trigonometric` — 三角函数（75 函数空桩）
- `import glm.ext.vector_relational` — 向量关系运算
- `import glm.ext.quaternion_common` — 四元数公共函数
- `import glm.ext.quaternion_geometric` — 四元数几何函数
- `import glm.ext.quaternion_trigonometric` — 四元数三角函数
- `import glm.ext.quaternion_relational` — 四元数关系运算
- `import glm.ext.quaternion_transform` — 四元数变换函数
- `import glm.ext.quaternion_exponential` — 四元数指数函数
- `import glm.ext.scalar_constants` — 标量常量
- `import glm.ext.quaternion_float` — Float32 四元数别名
- `import glm.ext.quaternion_double` — Float64 四元数别名
- `import glm.ext.quaternion_float_precision` — Float32 精度变体别名
- `import glm.ext.quaternion_double_precision` — Float64 精度变体别名
- `import glm.ext.matrix_projection` — 矩阵投影函数库空桩
- `import glm.ext.matrix_clip_space` — 裁剪空间矩阵函数库空桩
- `import glm.ext.matrix_transform` — 矩阵变换扩展函数库空桩
- `import glm.gtc.constants` — 数学常量
- `import glm.gtc.quaternion` — gtc 四元数扩展函数库
- `import glm.gtc.matrix_transform` — 矩阵变换函数库空桩

### G3.8 根因
`lib.cj` 第 12 行（`import glm.detail.{sin, cos, ...}`）、第 14 行（`import glm.ext.*`）、第 16 行（`import glm.gtc.*`）为非 public 导入，lib.cj 自身不直接引用这些符号，编译器判定为 unused import。需改为 `public import` 或 OOD 指定的显式模块路径导入形式。

### G3.9 根因
`public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 缺少 `Quat`。当前 `Quat` 仅通过 `fwd.cj:327` 的 `public type Quat = ...` 别名对外可见。

### 依赖关系
- 仅修改 `cjglm/src/lib.cj` 一个文件
- 无需新增文件
- 修改后需 `cjpm build` 编译通过且 unused import 警告消除
- 已有的 `cjpm test` 结果不受影响（435 PASSED / 0 FAILED）
- 无需 deviations.md 登记（修复后与 OOD 对齐）
