根据以下审查结果，迭代上一轮的产出，形成新版的文件，从而更好地满足用户需求。

## 当前审查结果

### 问题 1（严重，上轮未修复）：跨分量数截断构造函数仍然缺失
§4.1 Vec1 缺失从 Vec2/Vec3/Vec4 的截断构造函数（共3个），Vec2 缺失从 Vec3/Vec4 的截断构造函数（共2个），Vec3 缺失从 Vec4 的截断构造函数（1个）。共6个构造函数缺失。文档声明覆盖 GLSL 5.4.1 规范但实际清单不完整。
**改进建议**：在 §4.1 中补充全部6个跨分量数截断构造函数，使用 `public` 和 `where Q2 <: Qualifier` 约束。

### 问题 2（严重，上轮未修复）：Vec3 缺少 Vec2+Vec1 和 Vec1+Vec2 组合构造
§4.1 Vec3 构造函数包含 `Vec2+T` 和 `T+Vec2`，但不包含 `Vec2+Vec1` 和 `Vec1+Vec2`。Vec4 已有对应版本，Vec3 缺失造成 API 行为不一致。
**改进建议**：补充 `init<T2,Q2>(a: Vec2<T2,Q2>, b: Vec1<T2,Q2>)` 和 `init<T2,Q2>(a: Vec1<T2,Q2>, b: Vec2<T2,Q2>)`，验证重载解析无冲突。

### 问题 3（一般，上轮未修复）：`mod` 具名函数首轮可用性状态自相矛盾
§4.3 第500行列于首轮具名函数清单中，第506行却说"不属于首轮范围"。编码人员无法判断。
**改进建议**：做出唯一决策修正矛盾：若属于首轮则修正第506行措辞，若不属首轮则从第500行移除。同步更新 §4.6 相关注释。

### 问题 4（一般，新发现）：`scalar-op-vec` 辅助函数未列入 `lib.cj` 公共 API 导出清单
§4.3 将 `scalar-op-vec` 方向辅助函数（`add(s,v)`、`sub(s,v)` 等共20个）定义为包级独立函数置于 `compute_vector_decl.cj`，但 §2 的 `lib.cj` 未重导出这些函数，违反"下游消费者只需 `import glm.*` 即可使用所有公共 API"的封装原则。
**改进建议**：在 §2 `lib.cj` 的 `public import` 中补充 `{ add, sub, mul, div, mod }` 导出行，同步更新 §8 迁移文件清单。

### 问题 5（轻微，上轮未修复）：§7 设计决策编号顺序混乱
§7 编号呈现 D1→D5→D6→...→D19→D28→D29→D30→D31→D20→D21→D22→D23→D24，D28~D31 出现在 D20~D24 之前。
**改进建议**：将 D20~D24 移至 D19 之后、D25 之前，调整为严格编号顺序。

## 历史迭代回顾

### 已解决的问题
- 迭代第1-13轮全部问题已修复（包括 `@OverflowWrapping` 策略、`const init` 与 `const if` 实现路径、`bitwiseNot`/`logicalAnd`/`logicalOr` 具名函数替代、`Hashable` 实现策略、256个别名命名约定、`operator[]` `mut` 修饰符、跨类型 fill-from-Vec1 约束、Qualifier 运行时行为约定、Aligned 可见性策略、`equalExact` 等），当前诊断不再提及。
- 迭代第14轮v14_diag_v1中识别的部分问题（如标量参数跨类型构造签名修正等）已在a_v14_design_v1中修复。

### 持续存在的问题
- **跨分量数截断构造函数缺失**（迭代第14轮问题1 → 当前问题1）：连续两轮v14诊断均指出但a_v14_design_v1未修复，需优先处理。
- **Vec3缺少Vec2+Vec1/Vec1+Vec2**（迭代第14轮问题2 → 当前问题2）：连续两轮v14诊断均指出但未修复。
- **`mod`首轮可用性矛盾**（迭代第14轮问题3 → 当前问题3）：连续两轮v14诊断均指出但未修复。
- **§7编号顺序混乱**（当前问题5）：持续存在，前轮诊断已指出但未修复。

### 新发现的问题
- **`scalar-op-vec`辅助函数未导出**（当前问题4）：本轮v14第2轮诊断新识别的问题。

## 上一轮产出路径
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606170050_glm-migration-ood\a_v14_design_v1.md

## 用户需求
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606170050_glm-migration-ood\requirement.md
