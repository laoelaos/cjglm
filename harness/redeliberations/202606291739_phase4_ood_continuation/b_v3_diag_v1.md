# 质量审查报告 — 阶段四 OOD 设计方案 v3

**审查范围**：需求响应充分度、整体深度和完整性、实际落地可编码性

**审查对象**：`a_v3_copy_from_v2.md`（含 15 轮内部审议 + 2 轮外部审议修正）

---

## 1. 需求响应充分度评价

产出完整覆盖了需求中所有维度：

| 需求项 | 覆盖位置 | 评价 |
|--------|---------|------|
| 阶段四范围与边界定义 | §1.5 不覆盖范围、§1.6 交叉验证映射表 | ✅ 已建立与 `docs/02_roadmap.md` 的显式映射，含差异说明 |
| 结合已有阶段 OOD 成果 | §9 与已有阶段集成方式 | ✅ 详细分析阶段一二三受本阶段影响的解锁功能 |
| 仓颉语言特性与限制 | §1.4 约束继承、H4~H6 确定性声明、D26~D31 | ✅ 全面考虑了 FloatingPoint<T> 限制、ThreadLocal 可用性、函数重载决议等 |
| OOD 四大输出 | §2 模块划分、§3 核心抽象、§4 关键流程、§9 集成方式 | ✅ 全部覆盖 |

**结论**：需求响应充分，无明显遗漏。

---

## 2. 发现的问题

### 问题 1（严重 — 依赖表事实错误）

**common.cj 依赖条目遗漏 stdmath_shim.cj**

- **位置**：§2 模块间依赖，第 248 行
- **当前内容**：`common.cj → qualifier, setup（泛型约束依赖）`
- **证据**：§3.1 `common.cj` 职责中明确声明 `frexp` "委托 std.math.log2 经 stdmath_shim.cj" 以及 `ldexp` "均通过 stdmath_shim.cj 的 powT 包装函数统一实现"。而第 248 行完全未列出 `stdmath_shim.cj`，与其他三个依赖 shim 的模块形成反差：
  - `exponential.cj → stdmath_shim.cj` ✅（第 249 行）
  - `trigonometric.cj → stdmath_shim.cj` ✅（第 250 行）
  - `geometric.cj → stdmath_shim.cj` ✅（第 251 行）
  - `common.cj → <missing stdmath_shim>` ❌（第 248 行）
- **影响**：此错误若未被发现，编码团队在排查编译期依赖时可能错误认为 `common.cj` 可优先于 `stdmath_shim.cj` 编写，导致编译失败。
- **改进建议**：将第 248 行修正为 `common.cj → qualifier, setup, stdmath_shim.cj（frexp 委托 logT、ldexp 委托 powT）`

---

### 问题 2（中等 — 实施批次规划自相矛盾）

**trigonometric.cj 注释与批次分类冲突**

- **位置**：§8 实施批次规划，第 1013 行
- **当前内容**：trigonometric.cj 列在 "第二批（依赖第一批的函数库）" 下，但前置依赖列标注为 "阶段一二三类型就绪（**独立于第一批，与第一批可并行**）"
- **矛盾分析**：
  - §2 依赖表（第 250 行）明确声明 `trigonometric.cj → stdmath_shim.cj`，而 `stdmath_shim.cj` 属于第一批（第 1006 行）
  - 若 trigonometric.cj 真的独立于第一批，则依赖表有误；若依赖表正确，则批次注释有误
  - 无论是哪种情况，当前状态均让编码团队无法确定开工顺序
- **影响**：直接导致并行计划不可执行——开发人员不清楚是否能将 trigonometric.cj 分配为与第一批并行任务。
- **改进建议**：
  - **方案 A**（若依赖表正确）：删除第 1013 行 "独立于第一批，与第一批可并行" 注释，改为 "前置依赖：stdmath_shim.cj（第一批）"
  - **方案 B**（若确实独立）：先从 §2 依赖表第 250 行删除 `stdmath_shim.cj`，再明确说明 trigonometric.cj 的实现可以不依赖 shim（如直接调用 `std.math.<func>(Float64(x))`），然后在批次注释中保留并行说明

---

### 问题 3（轻微 — 计数误差）

**stdmath_shim.cj 包装函数数量声明与清单不符**

- **位置**：§1.4，第 52 行
- **当前内容**："共 **24 个**包装函数（签名均遵循统一模式...）"
- **证据**：从第 57~88 行的完整清单逐行计数为 25 个函数：
  1. sqrtT 2. expT 3. logT 4. exp2T 5. log2T 6. powT 7. sinT 8. cosT 9. tanT 10. asinT 11. acosT 12. atanT 13. atan2T 14. sinhT 15. coshT 16. tanhT 17. asinhT 18. acoshT 19. atanhT 20. floorT 21. ceilT 22. roundT 23. truncT 24. absT 25. fmodT
- 注意：文档明确声明 `inversesqrtT` **不属于** shim（属于 exponential.cj 内部），故不计入
- **改进建议**：将 "24 个" 修正为 "25 个"，或核对是否有某个函数不应出现在此清单中

---

## 3. 深度与完整性评价

### 设计可直接指导编码实现

- **core 函数库**（§3.1）：每个模块有职责清单、约束策略、实现路径，但函数签名以文字描述为主（如 "为 Vec1~Vec4 各定义逐分量版本"），未统一使用代码块形式。与 ext/gtc 层的完整代码块签名形成风格反差。**编码团队可理解但需自行为每个向量维度展开签名**。
- **ext 函数库**（§3.2）：scalar_common.cj 和 vector_common.cj 提供了完整的代码块签名清单，可直接参照编码。matrix_projection.cj 和 matrix_clip_space.cj 提供了典例签名 + 变体差异说明。
- **gtc 函数库**（§3.3）：提供了全部函数的完整签名（packing.cj 32 个函数、noise.cj 8+4 个函数、round.cj 边界表等），编码工程量可直接估算。

### 接口定义足以支持下游消费者

- `lib.cj` 导出清单（§8 第 1052~1101 行）完整定义了所有公共 API 的导入路径。跨包命名冲突分析（mix/exp/log/pow/sqrt + translate/rotate 等）给出了选型和后备方案。
- `lib.cj` 第 23 行修改策略（D30）和精确的 before/after 行内容确保编码团队可直接操作。

### 异常场景和边界条件已考虑

- §5 错误处理策略表覆盖 7 类场景（奇异矩阵、零向量 normalize × 2、acos/asin 越界、mod 浮点参数、inversesqrt 零值、Float16 转型溢出）。
- round.cj 边界行为表覆盖 NaN/+Inf/-Inf/±0/负数五种输入。

### 总体评价

产出自 15 轮内部审议和 2 轮外部审议后，整体质量较高，深度和完整性满足后续编码启动条件。上述 3 个问题是本轮发现的新问题：

1. **依赖表事实错误**（严重）是经过多轮审议仍存留的遗漏，应优先修复。
2. **批次规划矛盾**（中等）反映了大版本迭代中前后章节同步不足的问题。
3. **计数误差**（轻微）不影响编码，但宜一并修正。

修复以上 3 个问题后，产出可直接交付编码团队实施。
