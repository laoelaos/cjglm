# 任务指令（v6）

## 动作
NEW

## 任务描述
实现 P2-4（G8）：删除 `ext/quaternion_double.cj` 中的 `dquat` 定义，统一使用 `gtc/type_precision.cj` 版本。

具体变更：
1. `ext/quaternion_double.cj`：删除 `public type dquat = Quat<Float64, PackedHighp>` 行，保留空文件（避免 cjpm 报缺失源文件错误），也可添加注释说明
2. `lib.cj:18`：从提取列表移除 `dquat` 符号（仅删除 ext 层 dquat，保留 gtc 层 dquat）
3. 标记 `docs/diag/impl/04_diag.md` 中 G8 条目（`480-482` 行附近）为已修复

## 选择理由
P2-3（iround/uround 委托 roundT）已完成并验证通过（435 通过，0 失败）。P2-4 是 P2 批次中优先级最高的下一任务——G8（dquat 命名冲突）是 OOD 已知设计问题，修改范围极小（删除一行类型别名 + 从 lib.cj 移除一个符号），风险低、自包含，快速完成后可继续 P2-5（round.cj ±0 保留符号）。

## 任务上下文
- **问题**：G8 — `ext/quaternion_double.cj` 中定义的 `dquat` 与 `gtc/type_precision.cj:86` 的 `dquat` 命名冲突
- **OOD 设计覆盖**：OOD §3.3 注释明确说明"R10 更新 lib.cj 时，删除 ext/quaternion_double.cj 的 dquat 定义，统一由此处(gtc/type_precision.cj)提供"
- **类型等价性**：`ext.dquat = Quat<Float64, PackedHighp>` vs `gtc.dquat = Quat<Float64, Defaultp>`，`Defaultp == PackedHighp`，类型实质相同
- **04_diag.md 修改方向**：行 183-188 详细描述了删除方案

## 已有代码上下文
- `ext/quaternion_double.cj` 当前只有 3 行内容：
  ```cangjie
  package glm.ext
  import glm.detail.{ Quat, PackedHighp }
  public type dquat = Quat<Float64, PackedHighp>
  ```
- `lib.cj:18`：`public import glm.ext.{quat, dquat, highp_quat, mediump_quat, lowp_quat, highp_dquat, mediump_dquat, lowp_dquat}`
- `lib.cj:70`：`fquat, dquat, hquat}`（gtc 版本，保持不动）
- 测试 `lib_test.cj:425-429` 的 `testLibExtDquatAliasAccessible` 已通过 lib.cj 导入 `dquat`，删除 ext 版本后，该测试通过 lib.cj 第 70 行的 gtc.dquat 仍可正常编译通过（lib.cj 作为顶层重新导出两个来源的 `dquat`，gtc 版本自动生效），无需修改测试代码
- 删除 `dquat` 后，包 `glm.ext` 中 `quaternion_double.cj` 变为空文件；保留该文件以防 cjpm 报错（建议保留文件体，添加注释说明已被 gtc 版本替代）

## 修订说明（v6 r1）
| 审查意见 | 修改措施 |
|---------|---------|
| 实施路线表格缺少 v6 列 | plan.md 新增 v6 列，P2-4 行可于完成后打勾确认 |
