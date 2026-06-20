# R3C: 公共API+别名+项目配置 设计一致性审查

审查时间：2026-06-20

### 审查范围

- `cjglm/src/lib.cj` — 对照 OOD §2 (公共 API 面)
- `cjglm/src/fwd.cj` — 对照 OOD §3.8 (类型别名体系)
- `cjglm/cjpm.toml` — 对照 OOD §2
- `cjglm/.gitignore` — 标准仓颉项目 gitignore
- `cjglm/src/detail/type_cast.cj` — 对照 OOD §4.1 (跨类型转换设计约定)

### 发现

#### [一般] lib.cj: public import 完整且正确，与 OOD §2 一致

- **位置**：`cjglm/src/lib.cj:1-6`
- **验证结果**：逐行对照 OOD §2 公共 API 面设计：
  - `public import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }` — ✓
  - `public import glm.detail.{ Qualifier, PackedHighp, PackedMediump, PackedLowp }` — ✓
  - `public import glm.detail.{ Defaultp }` — ✓
  - `public import glm.detail.{ add, sub, mul, div, mod }` — ✓
  - `public import glm.detail.{ fromBoolVec, fromBoolVecQ2 }` — ✓
- **结论**：所有设计的公共类型和函数均已正确导出，Aligned 系列按 OOD §3.1 策略未导出（internal），无缺失或多余项。

---

#### [轻微] fwd.cj: uint 存在额外精度变体别名，与 OOD §3.7 表不完全一致

- **位置**：`cjglm/src/fwd.cj:29,40,51`
- **描述**：OOD §3.7 标量别名表末行 `uint` 仅列出 `public type uint = UInt32`，明确标注高/中/低精度变体列（highp_/mediump_/lowp_）为"—"（不存在）。但实际生成的 `fwd.cj` 包含 `highp_uint` (行29)、`mediump_uint` (行40)、`lowp_uint` (行51) 三个额外变体别名（均映射到 `UInt32`），与设计表约定不完全一致。
- **建议**：确认 OOD §3.7 的精度变体标注是否为有意的限制（即 uint 不应有精度变体，因其已是最常用 UInt32 映射，低精度无意义）。若是，移除脚本中 uint 的 3 个精度变体生成逻辑；若非限制（属表格省略），将表末行高/中/低列纠正为 ✓ 或更新设计文档对齐。无论方向，需同步脚本、fwd.cj 输出和设计文档三者。

---

#### [一般] fwd.cj: 生成脚本 gen_fwd_aliases.py 与输出文件存在同步风险

- **位置**：`cjglm/scripts/gen_fwd_aliases.py` ↔ `cjglm/src/fwd.cj`
- **描述**：OOD §3.8 脚本产出规范要求脚本生成的文件头注释、家族分组注释（`// === {FamilyName} family ===`），当前脚本均未实现。实际 `fwd.cj` 中的手动添加注释（行1-2 头部注释 + 53 行起的家族分组注释）在脚本重新生成时将被覆盖丢失。此外，脚本中 `import glm.detail`（命名空间导入）与 OOD §3.8 脚本示例的 `import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }`（命名导入）不一致——此差异虽由 INT-03 记录为偏差，但脚本中未使用 `Qualifier` 导入（OOD 期望结构包含 `Qualifier`），脚本当前使用的 `detail.VecN<...>` 限定访问格式实际不需要 `Qualifier` 导入。**脚本与输出之间的同步契约未建立**——当前两者已不同步，任意一方的修改将导致另一方不一致。
- **建议**：① 将脚本升级为全量生成模式——按 OOD 产出规范生成完整的 `fwd.cj`（含文件头注释和家族分组注释），确保脚本与输出完全等价；② 或声明脚本"仅更新别名定义区"的半自动策略，在 `fwd.cj` 中使用 `// === GENERATED REGION START ===` / `// === GENERATED REGION END ===` 标记，脚本仅更新标记区内内容，保留外侧手动维护的注释和导入。

---

#### [一般] cjpm.toml: package version 与 OOD 不一致（1.0.3 vs 0.1.0）

- **位置**：`cjglm/cjpm.toml:4`
- **描述**：OOD §2 项目初始化 `cjpm.toml` 指定 `version = "0.1.0"`，但实际配置为 `version = "1.0.3"`。`cjc-version = "1.1.0"` 已满足 OOD 要求的 ≥1.0.5，无影响。但 `version = "1.0.3"` 直接取了 GLM 库版本号，偏离了 OOD 中作为独立仓颉静态库的 0.1.0 语义版本约定（"1.0.3" 暗示完整版本号与 C++ GLM 1.0.3 的成熟度等价，而实际仅是首轮迁移）。
- **建议**：与主 Agent 确认版本号策略：若沿用 OOD 约定的 `0.1.0`（首轮孵化版本），修改 `cjpm.toml`；若有意使用 GLM 对齐版本号，更新 `docs/02_ood_phase0.md` §2 的 `cjpm.toml` 模板。

---

#### [一般] cjpm.toml: cjc-version 高于 OOD 要求，但未记录版本升级验证

- **位置**：`cjglm/cjpm.toml:2`
- **描述**：`cjc-version = "1.1.0"` 高于 OOD 要求的 `1.0.5`。OOD §2 版本要求说明中列出的 4 个关键功能点（编译期 `if` 分支抑制、`@OverflowWrapping` 继承性、`@Derive[Hashable]` 自动派生、`extend` 块泛型语法）在 1.1.0 下的回归验证未记录。版本升级可能伴随编译器行为变化，设计阶段验证（§2.1 的 26 项验证）应在 1.1.0 下重新确认。
- **建议**：在项目文档或编码日志中记录 1.1.0 下的验证结论——至少确认 OOD §2.1 项⑮ 已通过（编译器版本确认），并选择性重验证项④⑫㉑（编译期`if`、`@OverflowWrapping` 继承性、`@Derive` 约束）以排除回归风险。

---

#### [一般] type_cast.cj: 文件不在 OOD §8.1 文件清单中，设计框架无对应定位

- **位置**：`cjglm/src/detail/type_cast.cj:1-81`
- **描述**：该文件定义了 16 个 `castVec1`~`castVec4` 包级独立函数（4 目标 Vec 类型 × 4 源 Vec 类型），使用 `conv: (T2) -> T` 闭包参数进行类型转换。但 OOD 设计文档中**完全不包含此文件**——§4.1 跨类型转换设计约定仅描述构造函数式的 `init<T2, Q2>(v: VecN<T2, Q2>)` 方案，§8.1 文件清单（12 个 detail + 2 个 glm 文件）也未列出 `type_cast.cj`。此文件作为首轮新增代码在设计中无对应章节，其存在位置、命名约定、函数签名模式和设计意图均无设计文档可追溯。R2A 已审查该文件的实现正确性（3 个轻微项），本处仅报告设计一致性问题。
- **建议**：将 `type_cast.cj` 纳入 OOD 文档：① 在 §8.1 文件清单中增加 `type_cast.cj` 条目（序号 12c），说明依赖关系；② 评估 16 个 castVec 函数与 `type_vecN.cj` 中跨类型构造函数的关系——是补充性的"闭包-转换工具"还是与构造函数功能重叠；③ 在 §4.1 后新增子节或 OOD 偏差记录中说明其角色定位。若确认是设计遗漏，需在正式文档中补齐设计决策记录。

---

#### [一般] .gitignore: 包含大量非标准仓颉项目条目，缺乏设计依据标注

- **位置**：`cjglm/.gitignore:1-15`
- **描述**：除标准仓颉忽略项（`.cache/`、`target/`、`cjpm.lock`、`*.macrocall`）外，还包含 `.devbrain/`、`cov_output/`、`reports/`、`.arts/`、`*.gcda`、`*.gcno` 等团队/工具特定条目。这些条目在 OOD 设计文档中无提及，也未以注释说明用途。虽不影响功能，但缺乏可维护性——新加入团队的开发者无法判断哪些条目仍在使用、哪些是历史遗留。
- **建议**：为每个非标准条目添加简要注释说明用途（如 `# Coverage artifacts from cjcov`），或在项目 README/CONTRIBUTING 中统一说明开发工具链产生的文件类型。

---

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 0 |
| 一般 | 5 |
| 轻微 | 1 |

### 总评

本轮 R3C 审查覆盖 5 个文件，对照 OOD §2/§3.7/§3.8/§4.1 评估设计一致性。**lib.cj 完全符合 OOD §2 设计**，无偏差。**fwd.cj 的别名命名和数量（256 个向量别名 + 44 个标量别名）整体正确**，Vec/DVec/FVec 三家族命名策略（避免 VecVec）正确执行；但 uint 精度变体与 OOD 表不一致，且生成脚本与输出文件存在同步契约风险。**cjpm.toml 的 version 字段（1.0.3）偏离 OOD 约定（0.1.0）**，cjc-version 升级至 1.1.0 的回归验证未记录。**type_cast.cj 整体在 OOD 设计框架中缺位**——§4.1 和 §8.1 均未涉及此文件，需补充设计文档或确认是否属于有意偏离。**.gitignore 条目全面但缺少维护性标注**。未发现 blocking 问题，需主 Agent 确认版本号策略和 type_cast.cj 的设计定位。
