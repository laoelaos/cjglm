根据以下审查结果，迭代上一轮的产出，形成新版的文件，从而更好地满足用户需求。

## 当前审查结果

### P1（严重）— 缺少 `Hashable` 实现，Vec 类型无法作为哈希键正常使用
- **位置**：§3.2（Vec 结构体系）、§4（关键行为契约）、§12（验收标准）
- **改进建议**：在 §3.2 或 §7 中明确 Vec 类型的 `Hashable` 实现策略。推荐：整数/Bool 分量 Vec 使用 `@Derive[Hashable]`；浮点分量 Vec 记录为已知限制（不实现 `Hashable` 或提供精确按位 `hashCode()` 并标注行为差异）。在 §4 补充 `hashCode()` 签名和行为约定。在 §12.2 新增哈希集合可用性验收项。

### P2（严重）— Vec2 缺少 `Vec1+Vec1` 构造函数，与 C++ GLM `type_vec2.inl` 行为不一致
- **位置**：§4.1（Vec2 构造函数清单）
- **改进建议**：补充 `public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>) where Q2 <: Qualifier`。

### P3（严重）— Vec3 缺少 4 个 `Vec1` 参与的组合构造函数，与 C++ GLM `type_vec3.inl` 行为不一致
- **位置**：§4.1（Vec3 构造函数清单）
- **改进建议**：补充 `Vec1+Vec1+T`、`Vec1+T+Vec1`、`T+Vec1+Vec1`、`Vec1+Vec1+Vec1` 四个构造函数，保持与 Vec4 的 `Vec1` 组合构造覆盖模式一致。

### P4（一般）— `ComputeEqual` 被 `public import` 暴露为公共 API，泄漏实现细节
- **位置**：§2（公共 API 面设计），`lib.cj` 的 `public import` 列表
- **改进建议**：从 `lib.cj` 的 `public import` 列表中移除 `ComputeEqual`，降级为 `internal` 包级可见类型。

### P5（一般）— `isIec559Of<T>()` 实现中包含 `Float16` 类型增加不必要的验证风险
- **位置**：§10，`isIec559Of<T>()` 实现代码
- **改进建议**：简化实现为仅检查 `Float32`/`Float64`：`const if (T(0) is Float64 || T(0) is Float32) { true } else { false }`。将 `Float16` 分支推迟至后续轮次。

### P6（轻微）— `bitwiseNot()` 对 `VecN<Bool,Q>` 的迁移影响未纳入 §11 迁移成本评估
- **位置**：§3.2、§4.4、§11
- **改进建议**：在 §11 中新增子节（如 §11.3），评估 `~bvec` 迁移为 `bitwiseNot()` 或 `!` 的影响，包括受影响的表达式模式、迁移规则和工作量。

### P7（轻微）— `Format`/`Display`/`ToString` 输出未覆盖
- **位置**：§3.2、§4、§7
- **改进建议**：在 §3.2 或 §7 中约定 Vec 类型的字符串表示策略（推荐 `@Derive[ToString]` 或自定义 `toString(): String`）。在 §12.2 可选补充对应验证项。

## 历史迭代回顾

### 已解决的问题（出现在历史反馈但当前反馈中不再提及）
- v10 之前的多轮问题（如 `operator[]` 缺少 `mut`、`const operator ==` 表达式链兼容性、`@OverflowWrapping` 继承性验证、`Vec<Bool, Q>` 抽象类型引用、跨类型 fill-from-Vec1 构造器约束、别名数量不一致、`public import` 缺失、roadmap 可追溯性缺失等）已在 v10 中修复，当前审查未再检出。

### 持续存在的问题（在多轮反馈中反复出现，需重点解决）
- **P1（`Hashable` 缺失）**：自 v10 诊断首报，本轮仍检出，未修复。
- **P2（Vec2 `Vec1+Vec1` 构造函数缺失）**：自 v10 诊断首报，本轮仍检出，未修复。
- **P3（Vec3 `Vec1` 组合构造函数缺失）**：自 v10 诊断首报，本轮仍检出，未修复。
- **P4（`ComputeEqual` 被 `public import` 暴露）**：自 v10 诊断首报，本轮仍检出，未修复。
- **P5（`isIec559Of<T>()` 含 `Float16`）**：自 v10 诊断首报，本轮仍检出，未修复。

### 新发现的问题（本轮新识别的问题）
- **P6**（`bitwiseNot()` 迁移影响未纳入 §11）：v10 诊断新增问题。
- **P7**（`Format`/`Display`/`ToString` 输出未覆盖）：v10 诊断新增问题。

## 上一轮产出路径
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606170050_glm-migration-ood\a_v10_design_v1.md

## 用户需求
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606170050_glm-migration-ood\requirement.md
