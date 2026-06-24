# 任务指令（v4）

## 动作
NEW

## 任务描述
修订 `docs/04_ood_phase2.md`，合并处理两个相互关联的 OOD 文档问题：

### T1: `init(scalar: T)` 全填充构造函数登入 OOD

9 个矩阵类型均额外提供 `public init(scalar: T)`（填满所有 C×R 个位置），被大量测试用例使用（如 `Mat4x4<Int64, Defaultp>(5)`），但 OOD §3.3 的 8 类构造函数体系中**不含此条目**。

**修复动作**：在 OOD §3.3 构造函数体系中补充 `init(scalar: T)` 条目，位于 `diagonal(scalar)` 之前或之后均可，需说明其全填充语义。

### T19: OOD §9 `diagonal` 等价描述歧义

OOD §9 声明 "diagonal 为工厂函数...与 GLM 1.0.3 对所有 9 个矩阵类型均提供 `mat(T s)` 构造函数一致" 存在语义歧义：
- `diagonal(scalar)`：**对角填充**（非对角线为 T(0)）
- `init(scalar: T)`（当前实现）：**全填充**（所有 C×R 个位置均为 s）
- 只有 `init(scalar: T)` 才是真正等价于 GLM `mat(T s)` 的全填充构造

**修复动作**：在 OOD §9 中拆分 `diagonal(scalar)` 与 `init(scalar: T)` 的语义描述，明确 `init(scalar: T)` 对应 GLM `mat(T s)`，`diagonal(scalar)` 保留为仓颉侧新增的对角矩阵工厂函数。

### 共同要求
- 修订 `docs/04_ood_phase2.md`（位于项目根目录 `docs/` 下）
- 视需要在 `docs/deviations.md` 追加新条目说明此设计回补过程
- 保持 Markdown 格式与现有 OOD 文档一致

## 选择理由
T1 和 T19 均操作 `docs/04_ood_phase2.md` 的同一组章节（§3.3/§9），必须串行；Phase 2 的 CI 阻塞任务（T5/T6/T7）已全部完成，Phase 3 OOD 文档修正是下一个阶段

## 任务上下文
- **OOD 设计文档**: `docs/04_ood_phase2.md`
- **偏差文档**: `docs/deviations.md`
- **参考诊断**: `docs/diag/impl/02_diag.md` §2（T1 §2.1 第 130-163 行，T19 §2.2 第 165-187 行）
- 9 个 `type_mat*.cj` 文件中的实现和测试用例均大量使用 `init(scalar: T)`
- OOD §3.3 item 3 及 §9 当前将 `diagonal(scalar)` 声明为 GLM `mat(T s)` 的等价物

## 参考实现示例
- `type_mat4x4.cj:27-32`：`init(scalar: T)` 实现为 `Vec4(scalar, scalar, scalar, scalar)`（全填充）
- `type_mat4x4.cj:131-134`：`diagonal` 实现为 `Vec4(scalar, zero, zero, zero)`（对角填充）
