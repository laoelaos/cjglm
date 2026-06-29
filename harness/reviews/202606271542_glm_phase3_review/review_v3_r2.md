# R2: gtc/matrix_transform.cj + ext/matrix_*.cj + detail/trigonometric.cj 审查

审查时间：2026-06-27 16:43

### 审查范围

- `cjglm/src/gtc/matrix_transform.cj`（277 行 / 64 个函数 stub）
- `cjglm/src/ext/matrix_projection.cj`（5 行 / 1 个函数 stub）
- `cjglm/src/ext/matrix_clip_space.cj`（5 行 / 1 个函数 stub）
- `cjglm/src/ext/matrix_transform.cj`（5 行 / 1 个函数 stub）
- `cjglm/src/detail/trigonometric.cj`（93 行 / 75 个函数 stub）

合计 385 行。

### 审查依据

- `docs/05_ood_phase3.md` §3.13「新增空桩文件」、§3.13.1「trigonometric.cj 函数清单」、§9a「覆盖矩阵」、§1「lib.cj 新增 import 清单」
- `docs/02_roadmap.md` §3 阶段三文件清单 + 传递依赖列表
- `cjglm/src/detail/geometric.cj`（阶段二继承 stub，作为风格参照）
- `cjglm/src/lib.cj`（公共导出）

### 总体评估

5 个文件均严格遵循 OOD §3.13 阶段三"空桩占位"设计意图：函数签名完整、约束统一（`FloatingPoint<T>`/`Qualifier`）、函数体统一为 `throw Exception("stub")`。函数计数与 OOD 表格一致（64 / 75）。未发现严重问题。唯一一般性问题集中在 `gtc/matrix_transform.cj` 的 import 声明未覆盖 OOD 中声明的全部传递依赖路径，虽不影响 stub 编译但降低了阶段四实施时的依赖可追溯性。

### 发现

#### [一般] gtc/matrix_transform.cj import 列表未显式声明 ODD §3.13/路线图中的传递依赖

- **位置**：`cjglm/src/gtc/matrix_transform.cj:2-3`
- **描述**：当前文件仅 `import glm.detail.{ Mat4x4, Vec2, Vec3, Vec4, Qualifier }` + `import std.math.FloatingPoint`，未包含 `docs/02_roadmap.md:98` 与 `docs/05_ood_phase3.md:467` 中列出的 6 个传递依赖：`glm.ext.matrix_projection`、`glm.ext.matrix_clip_space`、`glm.ext.matrix_transform`、`glm.detail.trigonometric`、`glm.detail.geometric`、`glm.detail.matrix`。在 stub 形态下，函数体均为 `throw Exception("stub")`，编译不需要这些依赖（已通过 `cjpm build` 隐式验证），但**意图表达**缺失——下游维护者从 import 列表无法直接看出本文件是阶段三中"传递依赖链最广的依赖项"（路线图原话）。阶段四实现时需逐函数追加 `glm.detail.trigonometric`（`sin`/`cos`）、`glm.ext.matrix_*`（组合调用）等 import，可能引入合并冲突。
- **建议**：保留 stub 实现不变，在文件顶部（package 与 import 之间）添加注释块显式列出 6 个传递依赖及其用途，例如：
  ```cangjie
  // === 阶段四实现时的传递依赖（stub 形态下无需 import）===
  // - glm.detail.trigonometric：rotate/lookAt/角度转换等需要 sin/cos/atan
  // - glm.detail.geometric：lookAt 需要 cross/dot/normalize
  // - glm.detail.matrix：矩阵乘法/转置
  // - glm.ext.matrix_projection/clip_space/transform：组合实现入口
  ```
  阶段四实施时根据实际调用关系按需追加 import，避免一次性引入未使用的 import 触发 cjlint 警告。

#### [一般] trigonometric.cj 头部缺少与 OOD §3.13.1「T 类型约束策略」一致的引用说明

- **位置**：`cjglm/src/detail/trigonometric.cj:1-4`
- **描述**：当前文件头注释为空白，无任何关于约束策略的依据引用。OOD §3.13.1 第 1016 行明确指出 `where T <: FloatingPoint<T>` 约束是"阶段四完整实现前的必备前置项"——若不在 stub 阶段约束 T 为浮点类型，阶段四 stub 替换为 `std.math.{func}` 调用时，整数 T 实例化将报 `std.math.{func}(Int64)` 不存在错误（因 std.math 数值函数仅对 Float16/Float32/Float64 提供重载）。当前文件中所有 75 个签名均已正确应用该约束（标量用 `where T <: FloatingPoint<T>`，向量用 `where T <: FloatingPoint<T>, Q <: Qualifier`），但缺少注释说明该约束是 OOD 设计决策而非偶然选择。
- **建议**：在文件顶部添加注释说明约束依据：
  ```cangjie
  // OOD §3.13.1：T 约束为 FloatingPoint<T> 是阶段四完整实现前的必备前置项
  // ——避免阶段四 std.math.{func}(Int64) 编译失败
  // 标量版与向量版同时声明 15 函数 × 5 重载 = 75 函数签名，全部为 stub
  ```

#### [轻微] ext/matrix_projection.cj / matrix_clip_space.cj / matrix_transform.cj 命名空间定位与 OOD 描述

- **位置**：`cjglm/src/ext/matrix_projection.cj:4`、`cjglm/src/ext/matrix_clip_space.cj:4`、`cjglm/src/ext/matrix_transform.cj:4`
- **描述**：3 个 ext 文件分别仅声明 1 个函数（`perspective` / `ortho` / `translate`），函数名与 OOD §3.13 表格描述「`perspective`/`ortho` 等投影矩阵函数空壳」「裁剪空间矩阵函数空壳」「`translate`/`rotate`/`scale`/`lookAt` 等变换函数空壳」一致。每个文件选 1 个代表性函数作为"依赖闭合"的最小签名集——这是 OOD 的隐含设计选择（全部 64 个函数已在 `gtc/matrix_transform.cj` 重声明，ext 子包仅需保留存在性以满足 lib.cj 的 `import glm.ext.*` 路径）。但 3 个文件的代表性函数选择缺乏显式依据文档，且 OOD §3.13 表格中用「等」字暗示可能不止 1 个，下游维护者可能误以为 ext 包应补齐所有函数。
- **建议**：在 `gtc/matrix_transform.cj` 头部或 §3.13.1 邻近位置添加一句话说明"ext/matrix_*.cj 仅保留 1 个代表性 stub 函数作为依赖闭合入口，全部 64 个函数签名集中于 gtc/matrix_transform.cj"，避免阶段四实施时的重复实现疑惑。

#### [轻微] gtc/matrix_transform.cj 参数命名与 GLM 习惯一致性核验

- **位置**：`cjglm/src/gtc/matrix_transform.cj:7-277`
- **描述**：用户提示关注 "viewMatrix vs GLM view" 偏差，但经核验：64 个函数的参数命名（`m`/`v`/`angle`/`axis`/`n`/`s`/`eye`/`center`/`up`/`left`/`right`/`bottom`/`top`/`zNear`/`zFar`/`fovy`/`aspect`/`ep`/`obj`/`model`/`proj`/`viewport`/`win`/`delta`/`center`）与 GLM 1.0.3 `gtc/matrix_transform.inl` / `ext/matrix_clip_space.inl` / `ext/matrix_projection.inl` 原始声明一致。未发现 `viewMatrix` / `view` 风格的偏离。project/unProject 函数使用 `model` 和 `proj`（GLM 同样使用 `MODEL`/`PROJ`）也符合 camelCase 命名习惯。
- **结论**：参数命名与 OOD §3.13 模板及 GLM 原始声明对齐，**无问题**。在总评中确认这一点以回应用户关注点。

### 维度核查总结

| 维度 | 核查结果 |
|------|---------|
| 函数签名清单完整性 | ✅ `gtc/matrix_transform.cj` 64 个函数签名（11+10+9+9+9+7+2+6+1）与 OOD §3.13 表格一致；`trigonometric.cj` 75 个签名（15 函数 × 5 重载 = 14 标量单参 + 56 向量单参 + 1 标量 atan2 + 4 向量 atan2）与 OOD §3.13.1 一致 |
| stub 实现状态 | ✅ 全部 64 + 1 + 1 + 1 + 75 = 142 个函数均为 `{ throw Exception("stub") }`，符合 OOD §3.13 设计意图 |
| 约束选择（`FloatingPoint<T>` vs `Number<T>`） | ✅ `gtc/matrix_transform.cj` / `trigonometric.cj` 统一 `where T <: FloatingPoint<T>, Q <: Qualifier`（或无 Q），与 OOD §3.13.1「T 类型约束策略」及 §1「Float32 与 std.math 的交互约束」一致——`radians`/`degrees` 因 std.math 不提供，约束选择不受影响（仍需阶段四硬编码 π 字面量） |
| ext/matrix_*.cj 空桩占位 | ✅ 3 个文件各 1 个 stub 函数，与 OOD §3.13「`perspective`/`ortho`/`translate` 等空壳」一致；命名空间 `glm.ext` 与目录路径匹配 |
| 依赖声明正确性 | ⚠️ `gtc/matrix_transform.cj` 未显式 import 6 个传递依赖（编译 OK，意图表达缺失）；`lib.cj:14-16` 已通过 `import glm.ext.*` + `import glm.gtc.*` 通配符补齐 |
| 参数命名偏差 | ✅ 64 个函数参数命名与 GLM 原始声明一致，未发现 `viewMatrix`/`view` 风格偏离 |
| 依赖方向（OOD §2） | ✅ `glm.gtc → glm.detail` 单向（无 `glm.detail` 引用 `glm.gtc`），无循环依赖 |

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 0 |
| 一般 | 2 |
| 轻微 | 2 |

### 总评

5 个文件整体质量良好，严格遵循 OOD §3.13「空桩占位」设计意图：

- **函数签名完整性**——`gtc/matrix_transform.cj` 64 个 + `trigonometric.cj` 75 个 = 139 个签名与 OOD 表格逐项对齐，函数分类（基础变换/ortho 系族/frustum 系族/perspective 系族/perspectiveFov 系族/infinitePerspective 系族/tweakedInfinitePerspective 系族/投影工具/拾取矩阵）与 OOD §3.13 一致。
- **约束统一性**——`FloatingPoint<T>`/`Qualifier` 约束在所有 64 + 75 个签名中一致应用，与 OOD §3.13.1「T 类型约束策略」和 §1「Float32 与 std.math 的交互约束」对齐。
- **stub 实现正确性**——所有函数体均为 `{ throw Exception("stub") }`，符合 OOD 设计意图（阶段四实现时统一替换）。
- **参数命名**——与 GLM 1.0.3 原始声明及 OOD §3.13 模板一致，未发现显著偏离。
- **依赖方向**——`glm.gtc → glm.detail` 单向，无循环依赖，符合 OOD §2「模块间依赖」约束。

仅有的改进点（一般/轻微共 4 项）均为**文档化与意图表达层面**，不涉及编译正确性或功能正确性。建议阶段四实施前在 `gtc/matrix_transform.cj` 与 `trigonometric.cj` 头部追加注释说明约束依据与传递依赖列表，提升代码可维护性。
