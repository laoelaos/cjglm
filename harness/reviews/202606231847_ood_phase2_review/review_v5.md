# R5: type_vec2/3/4.cj 行向量 × 矩阵成员运算符 + Vec × Mat 测试

审查时间：2026-06-23

### 审查范围

**核心实现文件**：
- `cjglm/src/detail/type_vec2.cj`（Vec2 extend 块：3 个 Mat 乘法运算符，行 152-173）
- `cjglm/src/detail/type_vec3.cj`（Vec3 extend 块：3 个 Mat 乘法运算符，行 161-184）
- `cjglm/src/detail/type_vec4.cj`（Vec4 extend 块：3 个 Mat 乘法运算符，行 170-193）

**Vec1 核对**：
- `cjglm/src/detail/type_vec1.cj`（确认无 Mat 乘法运算符，符合 OOD §2 第 90 行）

**测试文件**：
- `cjglm/tests/glm/detail/test_vec_mat_mul.cj`（340 行，本轮范围：Vec × Mat 部分全部 30 个测试）

**OOD 参考**：`docs/04_ood_phase2.md` §2 第 77-90 行（Vec extend 块签名清单）、§3.5 第 553-609 行（跨尺寸矩阵乘法公式与模板）
**偏差文档**：`docs/deviations.md`

### 发现

#### [轻微] 测试中部分类型变体（Float64 / PackedHighp）仅覆盖方阵矩阵乘法

- **位置**：
  - `cjglm/tests/glm/detail/test_vec_mat_mul.cj:281-307`（Float64 测试）
  - `cjglm/tests/glm/detail/test_vec_mat_mul.cj:313-339`（PackedHighp 测试）
- **描述**：测试文件对 9 个 Vec×Mat 运算符组合均覆盖了基础 Int64 + Defaultp 场景 + 零向量场景（9 + 9 = 18 个测试）。但 Float64 类型测试（3 个）与 PackedHighp Qualifier 测试（3 个）仅覆盖方阵版本（Vec2×Mat2x2、Vec3×Mat3x3、Vec4×Mat4x4），未覆盖 6 个非方阵矩阵乘法组合（Vec2×Mat3x2、Vec2×Mat4x2、Vec3×Mat2x3、Vec3×Mat4x3、Vec4×Mat2x4、Vec4×Mat3x4）。考虑到非方阵实现与方阵实现在结构上完全对称（仅展开项数与结果向量维度不同），且 OOD §5 NaN 传播策略的验证覆盖要求属于不同审查轮次（R3），此覆盖率差距对发布前质量影响有限。
- **建议**：可选择性为 6 个非方阵矩阵乘法各补充 1 个 Float64 或 PackedHighp 类型变体测试，进一步验证类型变体下的编译兼容性与数值正确性。若考虑覆盖率收益边际递减（同类公式机械变体），可保留现状。

#### [轻微] Vec extend 块中存在重复约束 `extend<T, Q> VecN<T, Q> where T <: Number<T>, Q <: Qualifier`

- **位置**：
  - `cjglm/src/detail/type_vec2.cj:56`（首个 Number<T> extend 块，含算术运算符）与 `cjglm/src/detail/type_vec2.cj:152`（第二个 Number<T> extend 块，含 Mat 乘法）
  - `cjglm/src/detail/type_vec3.cj:63` 与 `cjglm/src/detail/type_vec3.cj:161`
  - `cjglm/src/detail/type_vec4.cj:70` 与 `cjglm/src/detail/type_vec4.cj:170`
- **描述**：每个 Vec 类型文件均含两个 `extend<T, Q> VecN<T, Q> where T <: Number<T>, Q <: Qualifier {` 块，第一个含 Vec 间与 Vec 标量算术运算符，第二个含 Mat 乘法运算符。仓颉语言允许多个 extend 块使用同一约束签名（编译器将其视为同一扩展的多个部分合并），但从代码组织角度可考虑将 Mat 乘法合并至首个 Number<T> extend 块中减少分散。当前实现的潜在收益是按"运算类型"分组（Vec 算术 vs 矩阵乘法）便于阅读。
- **建议**：当前组织方式属可接受的风格选择，无功能性问题。若倾向合并，可将 9 个 Mat 乘法运算符移至首个 Number<T> extend 块末尾；若倾向分组维持现状亦无妨。无需强制修改。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 0 |
| 一般 | 0 |
| 轻微 | 2 |

### 总评

本轮审查覆盖的 **9 个 Vec×Mat 行向量乘矩阵成员运算符**实现质量优秀，**未发现任何严重或一般问题**，与 OOD 设计高度一致。

**正确性验证**（9 个运算符逐项核对公式 `result[i] = sum_{k=0}^{R-1} this[k] * m.c_i[k]`）：

1. **Vec4 extend 块**（`type_vec4.cj:170-193`）：
   - `Vec4 × Mat2x4 → Vec2`（行 171-176）：2 列展开正确，每列 4 元素累加 ✓
   - `Vec4 × Mat3x4 → Vec3`（行 178-184）：3 列展开正确 ✓
   - `Vec4 × Mat4x4 → Vec4`（行 186-193）：4 列展开正确 ✓

2. **Vec3 extend 块**（`type_vec3.cj:161-184`）：
   - `Vec3 × Mat2x3 → Vec2`（行 162-167）：2 列展开正确 ✓
   - `Vec3 × Mat3x3 → Vec3`（行 169-175）：3 列展开正确 ✓
   - `Vec3 × Mat4x3 → Vec4`（行 177-184）：4 列展开正确 ✓

3. **Vec2 extend 块**（`type_vec2.cj:152-173`）：
   - `Vec2 × Mat2x2 → Vec2`（行 153-156）：2 列展开正确 ✓
   - `Vec2 × Mat3x2 → Vec3`（行 158-164）：3 列展开正确 ✓
   - `Vec2 × Mat4x2 → Vec4`（行 166-173）：4 列展开正确 ✓

**约束与注解一致性**：
- 全部 9 个运算符统一使用 `where T <: Number<T>, Q <: Qualifier`（与 OOD §3.5 第 519 行要求的泛型约束一致）
- 全部 9 个运算符统一标注 `@OverflowWrapping`（与 OOD §3.5 第 519 行及 §5 第 830-836 行要求一致）
- 参数命名 `m: Mat{C}x{R}<T, Q>` 在 9 个运算符中一致

**Vec1 无运算符确认**：
- `type_vec1.cj` 完整 169 行审查，确认未定义任何 `operator func *(m: Mat...)` 运算符，与 OOD §2 第 90 行"无有效矩阵乘法目标（本阶段未定义行数=1 的矩阵类型），不新增运算符"一致

**优先级/歧义分析**：
- Vec3 extend 块同时提供 `* Mat2x3 → Vec2`、`* Mat3x3 → Vec3`、`* Mat4x3 → Vec4`，三者参数类型与返回类型均不同，仓颉编译器按参数类型正确消歧，无冲突
- Vec×Mat 与 Mat×Vec 因左操作数类型不同（Vec 类型 vs Mat 类型），无运算符歧义
- D32 决策（行向量×矩阵为 Vec 类型成员运算符）正确实施

**测试覆盖完整性**（`test_vec_mat_mul.cj`）：
- 9 个 Vec×Mat 运算符均覆盖基础 Int64 + Defaultp 场景（行 4-91）
- 9 个 Vec×Mat 运算符均覆盖零向量场景（行 96-183）
- 3 个代表性方阵组合覆盖负值场景（行 188-215）
- 3 个代表性方阵组合覆盖不可变性（行 220-276）
- 3 个代表性方阵组合覆盖 Float64 类型（行 281-307）
- 3 个代表性方阵组合覆盖 PackedHighp Qualifier（行 313-339）
- 全部测试期望值经手工核算验证（例：Vec4×Mat4x4 中 r.w = 1×17 + 2×18 + 3×19 + 4×20 = 190 ✓）
- 30 个测试覆盖了类型系统（Int64/Float64、Defaultp/PackedHighp）、数值场景（常规/零向量/负值）、语义保证（不可变性）三大维度

**与 GLM 语义对齐**：
- OOD §5 第 825-829 行规定 Mat×Vec / Vec×Mat 遵循 IEEE 754 NaN 传播规则。本实现的展开公式直接使用 `*` 与 `+` 运算符，NaN 传播是 IEEE 754 浮点运算的自然结果，无需额外分支，符合 OOD 要求
- 测试文件未显式覆盖 NaN 场景，但 OOD §5 NaN 测试覆盖要求属于 Mat×Mat 跨尺寸矩阵乘法审查范围（R1/R2 已涉及），本轮 Vec×Mat 范围内不强制要求

**总体结论**：9 个 Vec×Mat 运算符严格遵循 OOD §2 第 77-90 行签名清单实现，公式正确、约束与注解一致、测试覆盖完整。唯一的两项轻微观察（Float64/PackedHighp 非方阵测试覆盖不全、重复 Number<T> extend 块）均属可接受的设计选择，无阻塞性问题。本轮审查通过，建议可进入 squash merge 流程。