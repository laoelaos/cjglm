# 设计审查报告（v5 r1）

## 审查结果
REJECTED

## 发现

### **[严重]** `Quat` 名称冲突将导致编译错误而非警告

`lib.cj` 中 `public import glm.detail.{Quat, ...}` 在 `glm` 包中引入声明 `Quat`（泛型类型 `detail.Quat<T, Q>`），`fwd.cj` 中 `public type Quat = detail.Quat<Float32, PackedHighp>` 在同一包中定义同名类型别名。仓颉语言规范规定"包有自己的命名空间（顶层名称不允许重复，函数重载除外）"（[package/README.md:6-7](./.opencode/skills/cangjie-lang-features/package/README.md)），二者构成**硬性编译错误**，而非设计所述的"冲突警告但正确编译"。

**期望修正方向**：二者择一：(a) 去掉 `lib.cj` 中对 `Quat` 的 public import，仅保留 cast 函数 (`mat3Cast`, `mat4Cast`, `quatCast`)——`fwd.cj` 已定义 `public type Quat` 提供具体别名；或 (b) 若需将泛型 `detail.Quat<T, Q>` 也暴露到 `glm` 顶层，则需使用 `import as` 重命名（如 `public import glm.detail.Quat as GenericQuat`）避免冲突。

### **[严重]** Quat type alias 数量与任务规格不符（12 vs 9）

任务规格明确要求 9 个 Quat 家族 alias（task_v5.md:83-94），设计及生成的 `fwd.cj` 实现了 12 个。多出的 3 个（`HighpFQuat`、`MediumpFQuat`、`LowpFQuat`）在任务规格中不存在。`FQuat` 与 `Quat` 语义等价（均为 `Float32`），其精度变体是冗余的。若后续验证脚本检查 alias 数量或具体名称列表，将直接失败。

**期望修正方向**：将 Quat 生成循环改为仅对 `Quat` 和 `DQuat` 生成精度前缀变体，`FQuat` 仅生成无前缀形式。具体：`QUAT_FAMILIES` 拆为两组，或增加过滤逻辑避免为 FQuat 生成精度前缀。

### **[一般]** 完整遗漏了 `import glm.detail.trigonometric`

任务规格要求追加 `import glm.detail.trigonometric`（task_v5.md:29）。设计对此完全未提及。虽因 `trigonometric.cj` 声明 `package glm.detail`（非子包），语法 `import glm.detail.trigonometric` 本身确实无效（仓颉 import 语法不支持按文件名导入），但设计应记录此偏差并提供等效替代方案。

**期望修正方向**：文档化此偏差，并用 `import glm.detail.{sin, cos, tan, asin, acos, atan, ...}` 或 `import glm.detail.*` 替换，使 `glm` 包可访问 trigonometric 模块中的函数。

### **[一般]** import 方案偏离任务规格但理由不够完整

设计用 `import glm.ext.*` 和 `import glm.gtc.*` 替代任务规格中的 18 个逐个文件名 import。此方向正确（因 ext/gtc 各文件共享同一包声明，无法按文件名导入），但设计说明仅覆盖了 ext/gtc，未一并说明 `import glm.detail.trigonometric` 的同等问题（见上条）。此外，使用 `import glm.ext.*` 的副作用（可能引入 ext 中测试用或内部符号）未做评估。

**期望修正方向**：完善 deviatioin 说明，将 ext/gtc/detail.trigonometric 的 import 偏差统一记录。

### **[轻微]** lib.cj 导入规划描述与实际不一致

设计文件规划一节（"文件规划"表格）称 lib.cj 末尾追加"3 个 import"，但任务规格描述为"20 个 import"。虽然设计因语言限制选择了不同的语法，但表格的数字与任务规格差异过大，容易让审查者/后续维护者产生困惑。

**期望修正方向**：表格中同步说明"因仓颉包管理限制，20 个逐个文件名 import 被合并为 3 个包级通配符 import"。

## 修改要求

1. **Quat 名称冲突**（严重）：必须解决 `lib.cj` 的 `public import` 与 `fwd.cj` 的 `public type` 之间的命名冲突，当前方案会导致编译错误。
2. **Quat alias 数量**（严重）：必须将 12 个 alias 修正为任务规格要求的 9 个，去掉 `FQuat` 的精度前缀变体。
3. **trigonometric import 遗漏**（一般）：document 偏差并提供等效替代方案。
4. **import 说明补全**（一般）：完善偏离任务规格的完整说明。
