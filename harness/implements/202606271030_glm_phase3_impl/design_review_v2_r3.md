# 设计审查报告（v2 r3）

## 审查结果
REJECTED

## 发现

- **[一般]** 任务规范偏差：`task_v2.md` §(a)3 要求实现 `init<Q2>(q: Quat<T, Q2>)` 构造函数，但设计将其替换为 `fromQual<Q2>(q: Quat<T, Q2>)` 静态工厂。设计 §修订说明（v2 r2）虽记录了此变更，但设计正文未在独立偏差说明中标注此偏离。任务文件作为需求来源，其明确列出的构造函数签名被替换后，设计文档应显式声明偏差及理由，而非仅置于修订说明中。

- **[一般]** `fromMat4` 实现冗余：设计 §FloatingPoint 约束 extend 块中描述 `fromMat4` "提取 m.c0/c1/c2 三列构造 Mat3x3 后调 quatCast"，但 `type_quat_cast.cj` 已定义 `quatCast<T, Q>(m: Mat4x4<T, Q>)` 完成相同提取逻辑。若 `fromMat4` 重复实现列提取则造成代码重复；若委托 `quatCast(Mat4x4)` 则描述误导。应明确 `fromMat4` 直接委托 `quatCast(m)`（Mat4x4 重载），消除歧义和潜在重复。

- **[轻微]** `const init(s: T, v: Vec3<T, Q>)` 与现有 Vec 类型约定不一致。Vec2/3/4 的向量参数构造函数均为非 `const` 的 `init(...)`（如 `Vec3.init(v: Vec1)` 为 `init` 而非 `const init`）。Quat 作为同一包的并行类型，应遵守相同约定，将 `init(s: T, v: Vec3)` 改为非 `const init`。

- **[轻微]** 一元 `-` 的 `@OverflowWrapping` 标注与现有类型不一致。Vec3:82、Mat3x3:57、Mat4x4:62 的一元 `-` 均不标注 `@OverflowWrapping`，但 Quat 的设计为其添加了此标注。虽在安全角度有合理理由，但造成同包类型之间的 API 风格不一致。

- **[轻微]** 测试方案中 `fromMat4` 测试描述"验证四元数分量合理性"过于模糊，未明确验证方法（如通过 `mat4Cast` 往返验证，或与已知旋转矩阵的预期四元数对照）。

- **[轻微]** 设计未提及 `componentAt(i: Int64): T` 函数，该函数存在于所有 Vec2/3/4 类型中。虽非必须，但添加可保持包内 API 一致性。

## 修改要求

1. **`fromQual<Q2>` vs `init<Q2>` 偏差**：在设计正文中新增"设计偏差"章节（参照 `code_v1.md` 格式），显式声明 `init<Q2>` 因编译器风险被替换为 `fromQual<Q2>` 静态工厂。若不准备修正此偏差，则需说明为何任务规范不适用。

2. **`fromMat4` 实现歧义**：明确 `fromMat4` 的实现策略——应直接委托 `quatCast(m)`（Mat4x4 重载），并更新设计描述为"直接调用同包 `quatCast(m)`"，消除与 `quatCast(Mat4x4)` 的重复嫌疑。
