# R1A: 基础设施层修复质量验证

审查时间：2026-06-20

### 审查范围

- `cjglm/src/detail/setup.cj` — 配置常量 `let`→`const` 修复验证
- `cjglm/src/detail/shim_limits.cj` — `isIec559Of`/`epsilonOf` 签名修复验证
- `cjglm/src/detail/compute_vector_relational.cj` — `ComputeEqual`/`ComputeEqualNumeric` 结构归一化验证
- `cjglm/src/detail/qualifier.cj` — Qualifier 接口和实现类型完整性检查

### 发现

#### [一般] setup.cj: 配置常量已全部使用 `public const` — 已修复

- **位置**：`cjglm/src/detail/setup.cj:3-9`
- **验证**：前序待办项记载的"使用 `public let` 而非 `public const`"问题已修复。当前文件 7 个常量全部使用 `public const` 声明：
  - `GLM_VERSION_MAJOR` (行3), `GLM_VERSION_MINOR` (行4), `GLM_VERSION_PATCH` (行5), `GLM_VERSION` (行6), `GLM_CONFIG_SIMD` (行7), `GLM_CONFIG_ALIGNED_GENTYPES` (行8), `GLM_CONFIG_CLIP_CONTROL` (行9)
  - 所有初始化表达式均为字面量，符合 `const` 语法要求。
- **待办状态**：**已修复** ✅

---

#### 未修复待办（已记录偏差，按 scope 排除不报告）

以下两项前序待办在代码中均未修复，但：

- **`shim_limits.cj`** — `isIec559Of`/`epsilonOf` 仍使用 `hint: T` 参数（非无参数 const 版本）
- **`compute_vector_relational.cj`** — `ComputeEqual` 仍仅含 `call`，`ComputeEqualNumeric` 仍独立存在

但二者均在 `docs/deviations.md` 中记录为已知偏差（DV-04 和 INT-02），且当前 `docs/02_ood_phase0.md` (§3.5/§3.6) 已更新设计为当前的"拆分 + hint 参数"方案。按 scope.md 排除范围约定，**不添加到本报告问题列表**。

**待办状态**：`shim_limits.cj` — **未修复**（已记录偏差 DV-04，非本轮可修复项）
**待办状态**：`compute_vector_relational.cj` — **未修复**（已记录偏差 INT-02，非本轮可修复项）

---

#### [一般] compute_vector_relational.cj: `callConst` 内联实现 `abs` 而非使用 `std.math.abs`

- **位置**：`cjglm/src/detail/compute_vector_relational.cj:14-16`
- **描述**：`ComputeEqualNumeric.callConst` 采用手动 `if (diff < zero) { -diff } else { diff }` 实现绝对值，而非使用 `std.math.abs(a - b)`。OOD §3.5 原型签名使用 `abs(a - b) <= epsilonOf(a)`。手动实现增加了 `Comparable<T>` 约束依赖（原因：需要使用 `<` 比较符），进一步限制了 `T` 的类型范围。
- **建议**：若验证项㉒（`std.math.abs` 在 const 函数体内可调用）已通过且 `callConst` 未来有 const 化需求，可替换为 `std.math.abs`。当前 `callConst` 为运行时函数（无 const 修饰），手动实现无功能影响。
- **严重程度**：轻微（无功能性影响，属于代码风格/复用性改进）

---

#### qualifier.cj: 接口和实现类型完整 — 无需修复

- **位置**：`cjglm/src/detail/qualifier.cj:1-13`
- **验证**：与 OOD §3.1 逐项对照：
  - `interface Qualifier {}` (行3) — ✓ 标记接口，无成员
  - `struct PackedHighp <: Qualifier {}` (行5) — ✓
  - `struct PackedMediump <: Qualifier {}` (行6) — ✓
  - `struct PackedLowp <: Qualifier {}` (行7) — ✓
  - `internal struct AlignedHighp <: Qualifier {}` (行9) — ✓ internal 可见性，与设计一致
  - `internal struct AlignedMediump <: Qualifier {}` (行10) — ✓
  - `internal struct AlignedLowp <: Qualifier {}` (行11) — ✓
  - `public type Defaultp = PackedHighp` (行13) — ✓
- **结论**：所有设计元素完整，无缺失或偏离。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 0 |
| 一般 | 0（2 项未修复待办因在 deviations.md 中记录，按 scope 排除） |
| 轻微 | 1 |

### 总评

本轮 4 个审查目标中：setup.cj 的 `let`→`const` 修复已确认完成；qualifier.cj 类型体系完整无缺失。shim_limits.cj 和 compute_vector_relational.cj 的两项前序待办虽代码层面未修复，但均已纳入 `deviations.md` 记录且 OOD 设计文档已相应调整，不属于本轮的修复责任范围。发现一项轻微新问题（内联 abs 替代 std.math.abs），不影响功能正确性。整体修复质量良好。
