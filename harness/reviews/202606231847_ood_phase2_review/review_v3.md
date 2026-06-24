# R3: 9 个矩阵类型文件中的跨类型转换（fromParts/fromColumns/fromMat 6a/6b/7）+ 对应测试

审查时间：2026-06-23

### 审查范围

**核心实现文件**：
- `cjglm/src/detail/type_mat2x2.cj`
- `cjglm/src/detail/type_mat2x3.cj`
- `cjglm/src/detail/type_mat2x4.cj`
- `cjglm/src/detail/type_mat3x2.cj`
- `cjglm/src/detail/type_mat3x3.cj`
- `cjglm/src/detail/type_mat3x4.cj`
- `cjglm/src/detail/type_mat4x2.cj`
- `cjglm/src/detail/type_mat4x3.cj`
- `cjglm/src/detail/type_mat4x4.cj`

**测试文件**：
- `cjglm/tests/glm/detail/test_type_mat2x2.cj` ~ `test_type_mat4x4.cj`（9 个）
- `cjglm/tests/glm/test_integration_matrix.cj`（注意：实际路径在 `cjglm/tests/glm/` 而非 `cjglm/tests/glm/detail/`，范围界定文件描述的路径有偏差，但内容已审查）

**OOD 参考**：`docs/04_ood_phase2.md` §3.3 items 4-7 与 fromMat 四项基本操作
**偏差文档**：`docs/deviations.md`

### 发现

#### [一般] 纯收缩方向中 `let zero = m.c0.x - m.c0.x` 声明后未使用

- **位置**：`cjglm/src/detail/type_mat2x2.cj:148-194`、`type_mat2x3.cj:143-189`、`type_mat2x4.cj:143-189`、`type_mat3x2.cj:149-195`、`type_mat3x3.cj:152-198`、`type_mat3x4.cj:149-195`、`type_mat4x2.cj:155-201`、`type_mat4x3.cj:155-201`、`type_mat4x4.cj:199-245`（全部 144 个 6a/6b 重载）
- **描述**：所有 fromMat 6a 函数体统一以 `let zero = m.c0.x - m.c0.x` 开头以计算 T(0)（6b 使用 `let zero = one - one`）。但在纯收缩方向（C_dst ≤ C_src 且 R_dst ≤ R_src）的实现中，函数体仅做截断、不使用 `zero` 变量。例如 `type_mat2x2.cj:184-188`（Mat2x2 ← Mat4x3 纯收缩）：
  ```cangjie
  public static func fromMat<SrcQ>(m: Mat4x3<T, SrcQ>, one: T): Mat2x2<T, Q>
    where SrcQ <: Qualifier {
      let zero = m.c0.x - m.c0.x  // 声明后从未使用
      Mat2x2(Vec2<T, Q>(m.c0.x, m.c0.y), Vec2<T, Q>(m.c1.x, m.c1.y))
  }
  ```
  此类声明未使用的 `let zero` 在所有 144 个 6a/6b 重载中均出现，包括 6a 与 6b 同结构（6b 也以 `let zero = one - one` 开头，纯收缩时同样未使用）。
- **影响**：编译时可能产生"unused variable"警告（取决于 cjc 版本），且运行时存在 1 次无效减法/读取操作。此为性能微损耗与可维护性问题（非严重逻辑错误）。
- **建议**：在纯收缩方向的重载中省略 `let zero = ...` 声明；或在 OOD 中显式说明"为保持 144 个重载的模板一致性，所有函数均统一声明 zero 变量"，并由编码生成脚本统一处理。当前选择保持 144 个重载的结构一致性是有意设计决定（与 fromMat 6a/6b 签名模板一致，便于代码生成），但需在文档中显式说明这一权衡。

#### [一般] 范围界定文件描述的 `test_integration_matrix.cj` 路径偏差

- **位置**：`harness/reviews/202606231847_ood_phase2_review/scope.md` 引用 `cjglm/tests/glm/detail/test_integration_matrix.cj`，但实际文件位于 `cjglm/tests/glm/test_integration_matrix.cj`。
- **描述**：范围界定文件描述与实际文件系统布局存在路径偏差。`cjglm/tests/glm/detail/` 目录下不存在该文件。
- **影响**：审查 agent 在定位文件时需多一步 glob 搜索；不直接影响代码正确性。
- **建议**：下一轮审查前修正范围界定文件的路径描述。建议补注明确"测试文件路径以实际文件系统为准"。

#### [轻微] OOD §3.3 第 286 行对 `one` 参数行为的描述与代码一致性提示不足

- **位置**：`docs/04_ood_phase2.md` 第 286 行
- **描述**：OOD §3.3 第 286 行说明"在纯收缩方向下 one 参数被忽略"，但实现中纯收缩方向不仅 `one` 未使用，**`zero` 也未使用**。函数体既声明 `let zero = m.c0.x - m.c0.x` 又声明 `one: T` 参数但两者均不使用。OOD 仅描述了 `one` 的忽略行为，未提及 `zero` 也被忽略的代码模式。代码生成脚本可能因此将 zero 视为必需，统一添加到所有 144 个重载中。
- **影响**：轻微，文档与实现的微妙偏差，对用户不可见但对维护者易产生疑问。
- **建议**：在 OOD §3.3 第 286 行附近的"纯收缩方向 one 参数行为"段落补充："在纯收缩方向下，one 与 zero 在函数体中均不使用，但为保持 144 个重载的代码模板一致性，函数签名仍包含 one 参数，函数体仍以 `let zero = ...` 开头。"便于维护者理解当前实现选择。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 0 |
| 一般 | 2 |
| 轻微 | 1 |

### 总评

跨类型转换实现质量高，**未发现严重逻辑错误**。所有 144 个 fromMat 6a/6b 重载（9 目标矩阵 × 8 源矩阵 × 2 变体）按 OOD §3.3 表正确实现：

1. **签名完整性**：9 个 fromParts + 9 个 fromColumns + 9 个 fromMat 7（同尺寸）+ 72 个 fromMat 6a + 72 个 fromMat 6b = **171 个签名全部到位**。
2. **T(0) 演算策略**：6a 统一使用 `m.c0.x - m.c0.x`（`m.c0.x` 类型为 T）、6b 统一使用 `one - one`（`one` 类型为 T），与 OOD §3.3 第 469 行要求一致。
3. **列扩展规则**：i ≥ R_dst 时整列全 T(0)，所有新增列对角线 (i,i) 填入 one（在 R_dst 范围内）。
4. **行扩展规则**：i ≥ R_src 时新行 (i,i) 填入 one（在 C_dst 范围内），其余 T(0)。
5. **Mat4x4←Mat4x2 偏差**（`type_mat4x4.cj:235-239`）：正确实现 GLM 行为，丢弃源矩阵列 2、3 的前两行数据，列 2/3 分别构造为 `Vec4(0,0,1,0)` 和 `Vec4(0,0,0,1)`。已由 `test_type_mat4x4.cj:634-653`（6a）与 `:837-858`（6b）双重测试覆盖。
6. **测试覆盖完整**：每个矩阵类型文件的 fromMat 测试覆盖 8 个 6a 方向 + 8 个 6b 方向 + 1 个 7 方向。`test_integration_matrix.cj` 额外覆盖 9 个集成场景（链式扩展/收缩、B 类、双扩展、偏差方向等高风险组合）。
7. **集成测试覆盖**：`testIntegrationFromMatColExtRowExt`（双扩展）、`testIntegrationFromMatDeviation`（Mat4x4←Mat4x2 偏差）、`testIntegrationFromMatBClass`（B 类行扩展）等高风险组合均有覆盖。

唯一值得记录的问题是**纯收缩方向中 `let zero` 变量声明后未使用**——属于代码模板一致性的权衡（为 144 个重载维护同一模板），非逻辑错误。建议在 OOD 中显式记录这一设计决定，并在范围界定文件中修正测试文件路径描述。

总体而言，跨类型转换实现严格按照 OOD §3.3 规则执行，Mat4x4←Mat4x2 已知偏差被正确实现并被测试覆盖，质量良好，可通过 squash merge。