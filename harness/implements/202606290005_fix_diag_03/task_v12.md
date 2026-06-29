# 任务指令（v12）

## 动作
NEW

## 任务描述
修改 `cjglm/src/gtc/quaternion.cj`，添加缺失的依赖 import，与 OOD §3.15 一致：

1. **添加 `public import glm.ext.{equal, notEqual}`** — 引用 `equal`（OOD §3.15 line 1276：用于 roll/pitch 的 `equal(vec2, vec2, 0)` 边界检测）；使用 `public import` 避免编译警告（当前所有函数均为 stub，符号不会被直接使用）
2. **添加 `public import glm.ext.{epsilon, pi, cos_one_over_two}`** — 引用 `epsilon<T>()`（OOD §3.15 line 1277：`epsilon<T>()` 用于欧拉角边界检测）；使用 `public import` 避免编译警告

当前文件已有（`gtc/quaternion.cj:1-4`）：
```
package glm.gtc
import glm.detail.*
import std.math.FloatingPoint
public import glm.detail.{mat3Cast, mat4Cast, quatCast}
```

修改后应添加上述 2 行 `public import`（可以合并为 1 行 `public import glm.ext.{equal, notEqual, epsilon, pi, cos_one_over_two}` 或保持 2 行分组）。

## 选择理由
G3.8+G3.9 完成后，G3.1 为路线中下一个 Medium 优先级任务。当前 `gtc/quaternion.cj` 所有函数均为 stub（`throw Exception("stub")`），因此缺失 import 不影响编译和运行。但按照 OOD §3.15，这些 import 应在阶段三添加，表明阶段四完整实现时的依赖意图。

## 任务上下文
- 源文件：`cjglm/src/gtc/quaternion.cj`（48 行，4 个 import + 10 个函数）
- 诊断报告：`docs/diag/impl/03_diag.md:400-413`（§G3.1）
- OOD §3.15：`docs/05_ood_phase3.md:1274-1279`（跨包引用清单）
- 所有函数当前均为 stub（`throw Exception("stub")`），添加 import 后编译不受影响
- 无需 `deviations.md` 登记（仅补充前瞻性 import 声明，无行为偏差残留）

## 依赖关系
- 仅修改 `cjglm/src/gtc/quaternion.cj` 一个文件
- 无需新增文件
- 修改后需 `cjpm build` 编译通过
- 已有的 `cjpm test` 结果不受影响

## 修订说明（v12 r1）
| 审查意见 | 修改措施 |
|---------|---------|
| 未使用的 import 会触发编译器警告；需要使用 `public import` 替代普通 `import` 以避免警告（与 v11 lib.cj 采用相同模式） | 将 `import glm.ext.{equal, notEqual}` 和 `import glm.ext.{epsilon, pi, cos_one_over_two}` 均改为 `public import`，与 v11 lib.cj 中 G3.8b/G3.8c 的 `public import` 模式一致 |
