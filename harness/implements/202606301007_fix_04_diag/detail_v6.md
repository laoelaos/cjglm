# 详细设计（v6）

## 概述

删除 `ext/quaternion_double.cj` 中的 `dquat` 定义，统一使用 `gtc/type_precision.cj:86` 的 `dquat` 版本，消除命名冲突（G8）。同步更新 `lib.cj` ext 层导入列表和 `04_diag.md` 修复标记。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `cjglm/src/ext/quaternion_double.cj:3` | 删除 | 删除 `public type dquat = Quat<Float64, PackedHighp>` 行，添加注释说明已被 gtc 版本替代 |
| `cjglm/src/lib.cj:18` | 修改 | 从 `glm.ext` 导入列表移除 `dquat` 符号 |
| `../../docs/diag/impl/04_diag.md:482` | 修改 | G8 条目追加 `✅ 已修复` |

## 类型定义

无新增/修改类型。仅删除 `ext` 包下的冗余类型别名。

### 被删除的定义

**类型**：`dquat`（`ext/quaternion_double.cj`）
**包路径**：`glm.ext`
**原定义**：`public type dquat = Quat<Float64, PackedHighp>`
**替代来源**：`glm.gtc` 包的 `gtc/type_precision.cj:86` — `public type dquat = Quat<Float64, Defaultp>`
**等价性**：`Defaultp == PackedHighp`，两种定义实质相同

### lib.cj 导入变更

| 行号 | 当前内容 | 变更后内容 |
|------|---------|-----------|
| 18 | `public import glm.ext.{quat, dquat, highp_quat, mediump_quat, lowp_quat, highp_dquat, mediump_dquat, lowp_dquat}` | `public import glm.ext.{quat, highp_quat, mediump_quat, lowp_quat, highp_dquat, mediump_dquat, lowp_dquat}` |
| 70 | `fquat, dquat, hquat}` | 保持不变（gtc 来源） |

## 错误处理

无变更。不涉及错误处理逻辑。

## 行为契约

- **前置条件**：无变更
- **后置条件**：`dquat` 仍可通过 `lib.cj` 获取（来自 gtc 版本），类型行为完全一致
- **兼容性**：显式 `import glm.ext.dquat` 的代码需改为 `import glm.gtc.dquat`；通过 `lib.cj` 使用的代码无感知

## 依赖关系

| 修改文件 | 新增依赖 | 移除了依赖 |
|---------|---------|-----------|
| `ext/quaternion_double.cj` | 无 | `Quat`、`PackedHighp` 导入（import 行保留但不再使用，空文件保留以通过 cjpm 编译） |
| `lib.cj` | 无 | `ext` 包的 `dquat` 符号 |
| `04_diag.md` | 无 | 无 |

### 受影响测试分析

| 测试文件 | 用例 | 影响 |
|---------|------|------|
| `tests/glm/lib_test.cj:425-429` | `testLibExtDquatAliasAccessible` | 无影响。该测试通过 `lib.cj` 获取 `dquat`，删除 ext 版本后，lib.cj:70 的 `gtc.dquat` 自动生效，测试仍可通过 |
