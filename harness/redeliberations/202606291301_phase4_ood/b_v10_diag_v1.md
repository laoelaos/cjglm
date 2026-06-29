# 质量审查诊断报告 — v10

审查范围：OOD 设计文档 v10 的质量审查，侧重内部审议未充分覆盖的维度（需求响应充分度、事实正确性、深度与完整性）。

---

## P1（严重）— `lib.cj` 中 gtc/noise.cj 的 public import 引用了不存在的函数名

- **所在位置**：§8 lib.cj 更新，第 928 行
- **问题**：`public import glm.gtc.{perlin, simplex}` 试图导入名为 `perlin` 和 `simplex` 的符号，但 §3.3 gtc/noise.cj（第 614–624 行）中实际定义的函数名为 `perlin1D`/`perlin2D`/`perlin3D`/`perlin4D`/`simplex1D`/`simplex2D`/`simplex3D`/`simplex4D`（共 8 个函数）。编码阶段将产生编译错误——符号 `perlin` 和 `simplex` 在 `glm.gtc` 包中不存在。
- **改进建议**：将 `{perlin, simplex}` 替换为完整的函数名清单 `{perlin1D, perlin2D, perlin3D, perlin4D, simplex1D, simplex2D, simplex3D, simplex4D}`。
- **证据**：文档自身 §3.3 noise.cj 函数签名清单（第 614–624 行）明确命名为 `perlin1D`/`perlin2D`/`perlin3D`/`perlin4D`/`simplex1D`/`simplex2D`/`simplex3D`/`simplex4D`，与第 928 行 import 使用的名称不一致。

---

## P2（严重）— `lib.cj` 中 gtc/packing.cj 的 public import 仅导出了约 6/32 个函数且未提供设计理由

- **所在位置**：§8 lib.cj 更新，第 929 行
- **问题**：`public import glm.gtc.{packUnorm4x8, packSnorm4x8, packHalf2x16, unpackUnorm4x8, unpackSnorm4x8, unpackHalf2x16}` 仅导出 6 个打包函数，但 §3.3 packing.cj 定义了约 32 个函数，涵盖 packUnorm 系族（6 个）、unpackUnorm 系族（6 个）、packSnorm 系族（6 个）、unpackSnorm 系族（6 个）、packHalf 系族（3 个）、unpackHalf 系族（3 个）、packDouble2x32/unpackDouble2x32（2 个）。该子集选择（仅保留 4x8 变体和 2x16 half 变体）未提供任何设计理由或使用场景说明。下游消费者无法通过 `glm.packUnorm1x8()` 等方式调用其余打包函数，需绕过 `lib.cj` 直接导入 `glm.gtc` 包。
- **改进建议**：方案 A：导出全部 packing 函数（完整覆盖 GLM 1.0.3 的设计）。方案 B：若有意选择子集，在 §8 或设计决策章节中补充选型理由、使用场景分析，并说明省略的函数如何被下游消费者访问。
- **证据**：§3.3 packing.cj（第 553–601 行）列出完整 32 个函数签名，与第 929 行仅 6 个函数的导出形成显著不对称。

---

## P3（严重）— `lib.cj` 遗漏 gtc/round.cj 的 `ceilMultiple`/`floorMultiple` 导出

- **所在位置**：§3.3 gtc/round.cj 职责（第 695–696 行）vs. §8 lib.cj 更新（第 932 行）
- **问题**：§3.3 round.cj 职责明确列出 `ceilMultiple` 和 `floorMultiple` 作为 round.cj 的组成部分，但 §8 lib.cj 更新（第 932 行 `public import glm.gtc.{roundPowerOfTwo, ceilPowerOfTwo, floorPowerOfTwo, roundMultiple}`）仅导出 4 个函数，遗漏了 `ceilMultiple` 和 `floorMultiple`。这将导致这两个函数无法通过 `glm::` 命名空间访问。
- **改进建议**：在第 932 行增加 `ceilMultiple` 和 `floorMultiple`；或在职责描述中标注这两者为 internal 函数而非公共 API 并说明理由。
- **证据**：§3.3 round.cj 第 695-696 行明确列出 `ceilMultiple(x, multiple)` / `floorMultiple(x, multiple)` 作为职责。

---

## P4（严重）— `lib.cj` 遗漏 gtc/type_precision.cj 的类型别名导出

- **所在位置**：§3.3 gtc/type_precision.cj（第 647–672 行）vs. §8 lib.cj 更新
- **问题**：§3.3 type_precision.cj 设计了约 100 个高精度类型别名（涵盖所有向量、矩阵、四元数类型的 highp/mediump/lowp 变体），但 §8 lib.cj 更新中完全没有 type_precision.cj 的导出条目。下游消费者无法通过 `glm::fvec3`、`glm::dmat4`、`glm::fquat` 等方式使用这些类型别名，必须直接导入 `glm.gtc` 包。
- **改进建议**：在 §8 lib.cj 更新中补充 type_precision.cj 的公共导出。若这些别名已通过 `fwd.cj` 或其他方式可达，需在文档中说明路径以确保下游消费者明确知晓。
- **证据**：§3.3（第 654–672 行）详细枚举了别名清单，但 §8（第 903–933 行）中无任何 `glm.gtc.type_precision` 的引用。

---

## P5（严重）— `gtc/matrix_transform.cj` 的"全部委托给 ext 层"声明与实际情况不符

- **所在位置**：§3.3 gtc/matrix_transform.cj（第 525 行）
- **问题**：文档声称"gtc 层本身不定义独立函数，全部委托给 ext 层"。但 §3.2 ext/matrix_transform.cj 仅包含 6 个函数（identity、translate、rotate、scale、shear、lookAt），而 §3.3 gtc/matrix_transform.cj 的基础变换系族包含 11 个函数（identity、translate、rotate、rotate_slow、scale、scale_slow、shear、shear_slow、lookAt、lookAtRH、lookAtLH）。`rotate_slow`、`scale_slow`、`shear_slow` 这三个函数在 ext 层中不存在（GLM 1.0.3 中它们是 gtc-only 函数），gtc 层无法通过"全部委托"获得其实现。编码阶段将因找不到 ext 层的对应函数而无法编译。
- **改进建议**：将"全部委托给 ext 层"修正为"大部分委托给 ext 层，rotate_slow/scale_slow/shear_slow 需在 gtc 层独立实现"，或在设计决策条目中新增记录选择理由（例如：gtc-only 函数的实现可在 gtc 层直接编写，或规划扩展 ext 层以容纳这些函数）。
- **证据**：对比 ext 基础函数清单（第 434–440 行，6 个）与 gtc 基础函数清单（第 516 行，11 个）。计数差异的 3 个函数（rotate_slow、scale_slow、shear_slow）没有对应的 ext 实现可委托。

---

## P6（一般）— geometric.cj 对 sqrt 的依赖描述与依赖关系表不一致

- **所在位置**：§3.1 geometric.cj 协作关系（第 286 行、第 309 行）
- **问题**：协作关系文字描述称"normalize/length 内部依赖 `exponential.cj` 的 `sqrt`"，但 §2 模块间依赖关系表（第 176 行）显示 geometric.cj 直接依赖 `stdmath_shim.cj`（通过 shim 包装函数间接调用 std.math），而非依赖 `exponential.cj`。如果 geometric.cj 真的绕过 `exponential.cj` 直接调用 `stdmath_shim.sqrtT`，那么文字描述中的"依赖 exponential.cj"是事实错误。如果 geometric.cj 计划调用 `exponential.cj` 中封装的 `sqrt`，那么依赖关系表应补充 geometric.cj → exponential.cj 的依赖边。当前文字与表格互相矛盾。
- **改进建议**：统一描述。推荐路径：geometric.cj 直接使用 `stdmath_shim.cj` 的 `sqrtT` 包装函数（与所有其他 core 模块一致），将文字描述中的"依赖 exponential.cj 的 sqrt"修正为"通过 `stdmath_shim.cj` 包装层调用 `sqrt`"。
- **证据**：§2 依赖表第 176 行 `geometric.cj → stdmath_shim.cj + qualifier` 不含 exponential.cj；§3.1 第 309 行正文含"依赖 exponential.cj 的 sqrt"。

---

## 整体评价

文档整体质量较高，经过 9 轮迭代后主体内容（架构视图、模块划分、函数签名设计、错误处理策略、并发设计、实施批次规划）已被充分打磨，多数严重问题已在前期迭代中解决。本轮发现的 5 个严重/严重问题均集中在 **§8 lib.cj 导出设计** 部分——这正是第 9 轮迭代完成后新增/修改较少的区域，尚未得到与核心设计同等充分的交叉验证。编码阶段若直接按当前描述执行，将在 `glm.gtc` 包的导出中遇到多个编译错误或 API 缺失。建议在最终交付前完成 §8 的修正。
