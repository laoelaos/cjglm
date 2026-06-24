# R2: OOD Phase 2 算术运算符 + 标量-矩阵全局函数 + 对应测试审查

审查时间：2026-06-23

### 审查范围

**核心实现（9 个矩阵文件）**：
- `cjglm/src/detail/type_mat2x2.cj` ~ `type_mat4x4.cj`

**标量-矩阵全局函数**：
- `cjglm/src/detail/scalar_mat_ops.cj`

**测试文件（算术相关）**：
- `cjglm/tests/glm/detail/test_type_mat2x2.cj` ~ `test_type_mat4x4.cj`
- `cjglm/tests/glm/detail/test_scalar_mat_ops.cj`
- `cjglm/tests/glm/detail/test_type_mat_compare.cj`
- `cjglm/tests/glm/detail/test_vec_mat_mul.cj`

### 发现

#### [一般] 矩阵-矩阵乘法运算符参数命名不一致

- **位置**：
  - `cjglm/src/detail/type_mat3x3.cj:91, 99, 108`
  - `cjglm/src/detail/type_mat4x4.cj:97, 105, 114`
- **描述**：在 9 个矩阵文件中，矩阵-矩阵乘法运算符（`operator func *(...)`）的右操作数参数命名不一致：Mat2x2、Mat2x3、Mat2x4、Mat3x2、Mat3x4、Mat4x2、Mat4x3 这 7 个文件统一使用 `rhs` 作为参数名（与 OOD §3.5 模板示例一致）；而 Mat3x3 和 Mat4x4 文件中的 3 个矩阵乘法重载（每个文件各 3 个：同尺寸 + 2 个跨尺寸）使用参数名 `r`。同样地，Mat3x3.cj:118 和 Mat4x4.cj:124 的 `operator func /(rhs: ...)` 都用了 `rhs`，进一步凸显 Mat3x3 和 Mat4x4 的矩阵乘 `r` 是偶然的不一致。
- **建议**：将 `type_mat3x3.cj` 中第 91、99、108 行的 `r` 改为 `rhs`；将 `type_mat4x4.cj` 中第 97、105、114 行的 `r` 改为 `rhs`。这是简单的命名对齐，不会影响编译或语义。

#### [一般] test_scalar_mat_ops.cj 对非方阵的标量-矩阵运算测试覆盖缺失

- **位置**：`cjglm/tests/glm/detail/test_scalar_mat_ops.cj:7-222`
- **描述**：`scalar_mat_ops.cj` 提供了 36 个全局函数（4 运算 × 9 矩阵类型），但测试文件仅覆盖 3 个方阵（Mat2x2、Mat3x3、Mat4x4）。6 个非方阵矩阵类型（Mat2x3、Mat2x4、Mat3x2、Mat3x4、Mat4x2、Mat4x3）的标量-矩阵加、减、乘、除完全无单元测试。考虑到实现中按列向量逐元素展开的代码对所有矩阵类型在结构上完全对称，单测遗漏非方阵路径意味着发布前若出现列向量展开公式错误（例如把 `Vec3` 写成 `Vec2`、列数硬编码错误等），仅有方阵测试无法捕获。
- **建议**：为 6 个非方阵矩阵类型各补充 1 个 `add` / `sub` / `mul` / `div` 测试（共 24 个测试用例），每种类型至少验证一个非平凡矩阵的逐元素运算结果（Int64 类型足够）。可在 `test_scalar_mat_ops.cj` 中按矩阵尺寸分组添加，每组 4 个测试（add/sub/mul/div）。

#### [一般] 审查范围与 test_vec_mat_mul.cj 实际内容不匹配

- **位置**：`cjglm/tests/glm/detail/test_vec_mat_mul.cj`（340 行）
- **描述**：审查任务描述声明本轮应审 `test_vec_mat_mul.cj` 的"仅 Mat × Vec 部分"，但该文件实际**仅包含 Vec × Mat 测试**（如 `testVec2MulMat2x2`、`testVec4MulMat4x4` 等 9 个测试，全部使用 `v * m` 调用模式），没有任何 `m * v` 形式的 Mat × Vec 成员运算符测试。本审查范围内的 Mat × Vec 成员运算符（`m * v`）的测试实际分散在 `test_type_mat2x2.cj:233` 等 9 个 per-matrix 测试文件中（如 `testMat2x2MulVec2`、`testMat4x4MulVec4`）。该测试文件的命名与内容一致性、以及与任务范围描述的匹配性需要在协调层面澄清。
- **建议**：在主 Agent 层面确认 `test_vec_mat_mul.cj` 应归属哪个审查 agent（Vec × Mat vs Mat × Vec），并校正任务范围描述。本审查 agent 仍按范围内（9 个 type_mat* 测试文件 + 其它明确列出的测试）完成对 Mat × Vec 成员运算符测试的覆盖度检查（详见下方总评）。

#### [轻微] testScalarMatOpsConsistencyWithVecOps 一致性验证不完整

- **位置**：`cjglm/tests/glm/detail/test_scalar_mat_ops.cj:225-231`
- **描述**：测试名为 "ConsistencyWithVecOps"，意在验证 `div(s, m)` 与 `div(s, v)` 在相同输入下的行为一致性，但仅比较了 `rMat.c0.x == rVec.x` 一个分量，未覆盖 `rMat.c0.y` 等剩余 3 个分量。虽然测试中 v 是 Vec1（仅 1 个分量），实际可比较的分量仅为 `c0.x`（对应 v.x），但测试命名为"一致性"暗示了更全面的覆盖，存在轻微误导。考虑到 Vec2/Vec3/Vec4 与 Mat2x2/Mat3x3/Mat4x4 的尺寸匹配，若要真正验证"标量-矩阵 div 与标量-向量 div 行为模式一致"，应至少包含 Vec2×Mat2x2 形式的对照测试，覆盖每个矩阵尺寸。
- **建议**：补充 Vec2×Mat2x2、Vec3×Mat3x3、Vec4×Mat4x4 的对照测试，每组对比所有分量的一致性。

#### [轻微] 矩阵-矩阵除法 stub 运算符的 @OverflowWrapping 注解在 stub 阶段无效

- **位置**：
  - `cjglm/src/detail/type_mat2x2.cj:113-114`
  - `cjglm/src/detail/type_mat3x3.cj:117-118`
  - `cjglm/src/detail/type_mat4x4.cj:123-124`
- **描述**：3 个方阵 `Mat{N}x{N} / Mat{N}x{N}` 运算符当前为 stub 实现（`throw Exception("stub")`），但均带有 `@OverflowWrapping` 注解。该注解在 stub 阶段不影响行为（函数体总是抛出异常），但在 OOD §3.5 中已明确要求 stub 阶段保留 `@OverflowWrapping` 标注以便阶段三 inverse 实现时即获得一致的整数溢出行为，因此该注解是有意保留的。无需修改。
- **建议**：保留 `@OverflowWrapping` 标注，待阶段三实现 `inverse` 时保持一致性即可。无须修改。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 0 |
| 一般 | 3 |
| 轻微 | 2 |

### 总评

本轮审查范围内（9 个矩阵文件算术运算符 + scalar_mat_ops.cj 全局函数 + 对应测试）的实现质量**整体良好**，核心语义正确性验证通过：

**正确性验证通过的关键项**：
1. **27 个矩阵-矩阵乘法重载全部齐全**，覆盖 3 个同尺寸乘法（Mat2x2×Mat2x2、Mat3x3×Mat3x3、Mat4x4×Mat4x4）+ 24 个跨尺寸乘法，分布位置与 OOD §3.5 签名表完全一致。
2. **矩阵乘法公式实现正确**：按 `result[j][i] = sum_{k=0}^{C_left-1} left[k][i] * right[j][k]` 公式逐方向硬编码展开，所有抽查的样例（Mat2x2×Mat3x2、Mat2x3×Mat3x2、Mat3x3×Mat2x3、Mat4x4×Mat3x4、Mat3x4×Mat4x3、Mat4x2×Mat2x4 等）的列向量展开均与公式一致。
3. **9 个 Mat × Vec 成员运算符齐全**，每个矩阵恰好 1 个，矩阵列数 = 向量维数（C_left = vec dim）。逐分量加权和展开公式正确。
4. **9 个一元负号运算符齐全**，约束在 `where T <: Number<T>, Q <: Qualifier` 块中，自动排除 Bool 矩阵（D33 决策）。
5. **36 个标量-矩阵全局函数齐全**（add/sub/mul/div × 9 矩阵类型），`div(s, m) = s / m[i][j]` 语义与 OOD §3.5 锁定一致，参数顺序 `(s, m)` 与 add/sub/mul 保持"标量 op 各分量"对称模式。
6. **`@OverflowWrapping` 标注合规性**：所有二元算术运算符（矩阵-标量 ±*/、矩阵-矩阵 ±*/、矩阵-向量 *）均正确标注 `@OverflowWrapping`；一元负号、矩阵-矩阵 / stub 按 OOD 规则处理。一致性符合 OOD §5 溢出策略全局规则。
7. **泛型约束一致性**：所有算术运算符统一使用 `where T <: Number<T>, Q <: Qualifier`，符合 OOD §3.5 要求。
8. **矩阵-矩阵除法 stub 行为符合 OOD**：3 个方阵除法运算符（Mat2x2/Mat3x3/Mat4x4）均 `throw Exception("stub")`，与 OOD §3.5 "本阶段 stub 异常" 一致；非方阵未提供除法运算符，符合 OOD 仅限方阵的要求。
9. **测试覆盖完整**：所有 27 个矩阵乘法、9 个 Mat × Vec、3 个除法 stub、9 个一元负号、9 组（共 36 个）矩阵-标量、9 组矩阵-矩阵 ± 的单元测试均已存在，测试期望值与实现公式匹配（已抽查 Mat2x2×Mat3x2、Mat4x4×Mat3x4、Mat4x4×Mat4x4 等场景的预期值计算正确）。

**主要改进建议**：上述 3 条"一般"级别问题中，参数命名不一致（`r` vs `rhs`）属于低风险风格统一；标量-矩阵非方阵测试缺失和测试范围描述与文件实际内容不匹配属于协作/流程层面的问题，建议在 squash merge 之前由负责 agent 对齐并补充测试覆盖。