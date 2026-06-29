# 任务指令（v8）

## 动作
NEW

## 任务描述
删除误纳入仓库的 `cjglm/src/fwd.cj.bak` 备份文件：
1. 前置验证 git 跟踪状态：`git ls-files --error-unmatch src/fwd.cj.bak`
2. 若被跟踪：`git rm src/fwd.cj.bak`
3. 若未跟踪：`rm src/fwd.cj.bak`
4. 验证：`cjpm build` 编译通过 + `git status` 确认删除

## 选择理由
G2.3（sqrtT 重构）因 `std.math.sqrt` 缺少泛型重载而 BLOCKED，G3.5 是下一个可独立完成的任务。操作简单（单命令文件删除），无风险，可快速推进实施进度。

## 任务上下文
- 文件路径：`cjglm/src/fwd.cj.bak`
- 诊断报告：`docs/diag/impl/03_diag.md:441-469`（§G3.5）
- 该 `.bak` 是修复前的快照，包含 OOD §2 明确禁止的 `HighpFQuat`/`MediumpFQuat`/`LowpFQuat` 三个错误别名。当前 `fwd.cj` 已正确不含上述变体。
- 文件已被纳入 git 暂存区（`new file: cjglm/src/fwd.cj.bak`），需从版本控制和文件系统同时删除。

## 已有代码上下文
- 无依赖文件需要修改
- 删除后 `cjpm build` 应编译通过（`fwd.cj` 不受影响）
- 无需更新任何文档或测试
