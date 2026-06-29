# 详细设计（v8）

## 概述

删除误纳入仓库的 `src/fwd.cj.bak` 备份文件。该文件是修复前的快照，包含 OOD §2 明确禁止的 `HighpFQuat`/`MediumpFQuat`/`LowpFQuat` 三个错误别名，当前 `fwd.cj` 已正确不含上述变体。当前状态：文件已被 git 跟踪。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `cjglm/src/fwd.cj.bak` | 删除 | 从版本控制和文件系统移除误纳入的备份快照 |

## 操作步骤

1. **前置验证**（git 跟踪状态确认）：
   - 命令：`git ls-files --error-unmatch src/fwd.cj.bak`
   - 预期：返回 `src/fwd.cj.bak`（已跟踪）

2. **执行删除**：
   - 命令：`git rm src/fwd.cj.bak`
   - 作用：从 git 跟踪和文件系统同时删除

3. **验证**：
   - `cjpm build` — 编译通过（0 errors）
   - `git status` — 确认 `src/fwd.cj.bak` 不再出现在工作区或暂存区

## 依赖关系

- 无依赖文件需要修改
- 删除后 `cjpm build` 应编译通过（`fwd.cj` 不受影响）
- 无需更新任何文档或测试
