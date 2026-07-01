# 设计审查报告（v2 r3）

## 审查结果
**REJECTED**

## 发现

- **[严重] P1-2 float_distance S2 问题描述与修正方案存在根本矛盾**：问题节称 "`as Int32` 对 UInt32 大值（>2^31-1，即负浮点位模式）做数值转换时超出 Int32 范围抛异常"，但设计说明节又声称相同操作是"安全的位重解释（非数值转型）"。二者不可同时成立。若 `as Int32` 是位重解释（永不抛异常），则 S2 描述错误，修正方案中 `(x.toBits() as Int32).getOrThrow()` → `(a as UInt32).getOrThrow()` 这一转两回的 roundtrip 毫无必要（可以直接用 `x.toBits()`）。若 `as Int32` 是数值转换（可能抛异常），则修正方案仍使用相同转换，未解决根本问题。设计必须澄清 `as` 在此处的确切语义，并据此调整修正方案。

- **[一般] P1-3 slerp 的 `pi<T>()` 缺少导入说明**：四参数 slerp 修正代码使用 `pi<T>()`，但 `quaternion_common.cj:2` 的 import 列表 `glm.detail.{..., epsilon, sinT, cosT, dot}` 未包含 `pi`。文件规划表只标注修改 `:42-56` 和 `:58-71`，未提及第 2 行的 import 语句需同步更新。设计应明确要求在 import 列表中添加 `pi`。

- **[轻微] P1-5 S3 期望值替换关系不明确**：设计只展示了新的 4 个 `@Expect` 断言，未明确说明原 `testRotateNonIdentity` 中 lines 68-69 的 `@Expect((r.x).abs() < 1e-10, true)` 和 `@Expect((r.z - 1.0).abs() < 1e-10, true)` 应被替换还是保留。虽然合理推断是替换，但设计应明确写入。

## 最终裁定
REJECTED
