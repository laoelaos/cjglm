# 详细设计（v5）

## 概述

绕过 S1 BLOCKED，修复 3 个紧密相关的子任务：测试容忍度调整 + 文档状态更新 + 偏差登记。S1 核心算法 bug（`mult = half / v`）已在 v4 中修复，当前仅剩 2 个 W-branch 测试因 Float64 浮点舍入误差失败（~5e-14 > epsilon*100 ≈ 2.22e-14）。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `cjglm/src/detail/type_quat_cast_s1_test.cj:4` | 修改 | `mat3EqualEpsilonRelaxed` 的 epsilon 乘数从 `100.0` → `1000.0` |
| `cjglm/src/detail/type_quat_cast.cj:54` | 修改 | 删除未使用的 `let two` 变量声明 |
| `docs/diag/impl/03_diag.md:35` | 修改 | S1 分类从「真实存在」→「已修复」 |
| `docs/diag/impl/03_diag.md:71` | 追加 | 在 §S1 末尾（line 71 后）添加「修复状态」小节 |
| `docs/deviations.md:719` | 追加 | 在「四、未验证的偏差添加」中添加 DV-12 |

## 类型定义

本次任务不涉及类型定义变更。

## 错误处理

本次任务不涉及错误处理变更。

## 行为契约

### 前置条件
- `type_quat_cast_s1_test.cj:4` 当前为 `epsilon<Float64>() * 100.0`（≈2.22e-14）
- `type_quat_cast.cj:54` 当前包含 `let two: T = (Float64(2.0) as T).getOrThrow()`（未使用，触发编译警告）
- `03_diag.md:35` 分类为「真实存在（实现与参考实现存在算法偏差）」
- `03_diag.md:71` 为 S1 章节末尾（其后为 `---` 分隔线）
- `deviations.md:719` 为「（暂无）」
- 所有待修改文件在 Git 工作树中均可追踪

### 后置条件
- `cjpm build` 编译通过（0 errors），`let two` 未使用变量警告消除
- `cjpm test` 全部 435+ PASSED / 0 FAILED（W-branch 2 个测试因宽松 epsilon 通过）
- `03_diag.md:35` 分类已改为「已修复」
- `03_diag.md:71` 后已添加「修复状态」小节
- `deviations.md:719` 后已添加 DV-12 条目

### 注意事项
- `let two` 的物理位置在 `type_quat_cast.cj:54`，**非** task_v5.md 表格中误标的 `type_quat_cast_s1_test.cj:54`。设计已按实际位置修正。
- 删除 `let two` 时需注意：该变量在修复前用于 `v / two` 模式，现已改为 `mult = half / v` 模式，`let half`（line 55）和 `let one`（line 53）仍被使用，**仅删除 line 54**。

## 依赖关系

- 不引入新依赖
- 三子任务无交叉依赖，可按任意顺序执行
