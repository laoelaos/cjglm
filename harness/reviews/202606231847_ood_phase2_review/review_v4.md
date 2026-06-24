# R4: 3 个函数库文件的 stub 实现 + 对应测试（common.cj / matrix.cj / geometric.cj）

审查时间：2026-06-23

### 审查范围

**核心实现文件**：
- `cjglm/src/detail/common.cj`（纯 stub，12 个函数）
- `cjglm/src/detail/matrix.cj`（混合型，27 个实现 + 6 个 stub，共 33 个函数）
- `cjglm/src/detail/geometric.cj`（纯 stub，20 个函数）

**测试文件**：
- `cjglm/tests/glm/detail/test_common.cj`
- `cjglm/tests/glm/detail/test_matrix.cj`
- `cjglm/tests/glm/detail/test_geometric.cj`
- `cjglm/tests/glm/detail/test_geometric_refract.cj`

**OOD 参考**：`docs/04_ood_phase2.md` §3.7（stub 函数库）
**路线图参考**：`docs/02_roadmap.md` 阶段 2 验证标准
**偏差文档**：`docs/deviations.md`（DV-02）

### 发现

#### [一般] matrix.cj 中 matrixCompMult 仅 3/9 重载被单元测试覆盖

- **位置**：`cjglm/tests/glm/detail/test_matrix.cj:163-208`（仅 Mat2x2/Mat2x3/Mat4x4 三个版本），缺失 Mat2x4/Mat3x2/Mat3x3/Mat3x4/Mat4x2/Mat4x3 共 6 个版本
- **描述**：27 个直接实现的函数重载中，matrixCompMult 9 个重载仅有 3 个被独立测试覆盖（`testMatrixCompMultMat2x2`、`testMatrixCompMultMat2x3`、`testMatrixCompMultMat4x4`）。其余 6 个版本的逐分量相乘逻辑正确性未被显式验证。考虑到实现为纯机械展开（`dst.cj[i] = x.cj[i] * y.cj[i]`），理论上风险较低，但覆盖率不足将延迟集成测试阶段才发现错误。
- **影响**：非阻塞性问题，但与 OOD §3.7 的"完整函数签名清单"对应的测试覆盖不完整，违背"测什么就有什么，写什么就测什么"的实践。
- **建议**：补充 Mat2x4/Mat3x2/Mat3x3/Mat3x4/Mat4x2/Mat4x3 共 6 个 matrixCompMult 单元测试用例。每个测试仅需 2~4 行验证预期结果。

#### [一般] matrix.cj 中 outerProduct 仅 3/9 重载被单元测试覆盖

- **位置**：`cjglm/tests/glm/detail/test_matrix.cj:210-255`（仅 Vec2xVec2/Vec3xVec2/Vec4xVec4 三个组合），缺失 Vec2xVec3/Vec2xVec4/Vec3xVec3/Vec3xVec4/Vec4xVec2/Vec4xVec3 共 6 个组合
- **描述**：outerProduct 9 个重载覆盖 3 种 Vec 维度对（2×2、3×2、4×4）的非方阵/方阵组合，缺少其他 6 种组合的测试。实现遵循公式 `M[j][i] = c[i] * r[j]`（OOD §3.7 line 738），但 6 种未测试组合中至少包括 Vec3xVec3 方阵情况（应为 Mat3x3），对调试具有重要意义。
- **影响**：覆盖率不足；Vec3xVec3 → Mat3x3 是核心方阵外积场景，缺失测试可能导致该重载的回归错误难以及时发现。
- **建议**：优先补充 Vec3xVec3 → Mat3x3 与 Vec2xVec4 → Mat4x2 测试用例（覆盖方阵外积与短列长×长行向量组合）；其他 4 个组合可按需补齐。

#### [一般] test_common.cj / test_geometric.cj / test_geometric_refract.cj 缺少显式 import（与项目测试文件风格不一致）

- **位置**：`cjglm/tests/glm/detail/test_common.cj:1`、`test_geometric.cj:1`、`test_geometric_refract.cj:1` 三个文件均无 `import std.unittest.* / import std.unittest.testmacro.*`
- **描述**：项目内其他测试文件（如 `test_matrix.cj:3-4`、`test_scalar_mat_ops.cj:3-4`、`test_type_mat2x2.cj:3-4`）均显式导入单元测试框架包。但本轮审查的 3 个 stub 测试文件均未导入。依据 `cangjie-std/unittest/README.md` §1.2 "测试模式下 unittest 和 unittest.testmacro 自动导入，无需显式 import"——三种 stub 测试文件依赖测试模式的自动导入机制能正常工作，但与其他测试文件风格不一致。
- **影响**：不影响编译运行（cangjie 测试模式自动导入），但产生风格不一致性：维护者可能误以为这些文件遗漏了必要的 import。
- **建议**：补齐三个 stub 测试文件的显式 import：
  ```cangjie
  import std.unittest.*
  import std.unittest.testmacro.*
  ```
  使项目内测试文件风格保持一致，避免依赖隐式的"测试模式自动导入"行为。

#### [一般] stub 函数测试仅断言异常抛出，未验证异常信息内容

- **位置**：`cjglm/tests/glm/detail/test_common.cj:5-60`、`test_matrix.cj:258-290`、`test_geometric.cj:7-113`、`test_geometric_refract.cj:7-21`
- **描述**：所有 stub 函数测试均使用 `@ExpectThrows[Exception](...)` 模式断言抛出 Exception，但未验证异常信息是否包含 "stub" 标识字符串。例如 `throw Exception("stub")` 与 `throw Exception("not implemented")` 均会被 `@ExpectThrows[Exception]` 接受。这意味着即使有人将 stub 占位修改为其他异常信息，测试也无法检测出该变化。
- **影响**：测试粒度较粗，无法验证 stub 实现的语义占位一致性；阶段三/四补全实现时，若开发者意外保留了 `throw Exception("stub")` 也会通过测试（虽然这种场景较为罕见）。
- **建议**：使用 `@ExpectThrows[Exception](<call>, message: "stub")` 或类似断言模式验证异常信息子串。具体 cangjie 单元测试框架版本可能支持 `messageContains` 参数；若不支持，可手动捕获后断言：
  ```cangjie
  try {
      min(Float64(1.0), Float64(2.0))
      @Fail("expected exception")
  } catch (e: Exception) {
      @Expect(e.message.contains("stub"), true)
  }
  ```
  但属于次要改进，对 stub 阶段验收并非必需。

#### [轻微] double-transpose 恒等性质测试仅覆盖 Mat2x2 与 Mat4x4

- **位置**：`cjglm/tests/glm/detail/test_matrix.cj:14-18`（Mat2x2）、`:144-160`（Mat4x4）
- **描述**：转置代数性质（`(m^T)^T == m`）是 transpose 实现正确性的核心等价验证。当前测试仅对 2 个方阵尺寸做了此验证，7 个非方阵尺寸（Mat2x3/Mat2x4/Mat3x2/Mat3x3/Mat3x4/Mat4x2/Mat4x3）未做。
- **影响**：轻微覆盖率不足；非方阵 transpose 的元素映射方向不同，更需要验证恒等性质。无证据表明实现有误，但覆盖率不足将延迟错误发现。
- **建议**：为非方阵 transpose 测试用例末尾追加 `let tt = transpose(t)` 与 `@Expect` 比对原矩阵（每个尺寸 4~8 行验证代码）。

#### [轻微] common.cj 中 `mod` 函数约束从 OOD §3.7 暂定的 `Number<T>` 提前收紧为 `Integer<T>`

- **位置**：`cjglm/src/detail/common.cj:12`
- **描述**：OOD §3.7 line 679 暂定签名为 `func mod<T>(a: T, b: T): T where T <: Number<T>`，并明确说明"最终实现需拆分为整数版本（Integer<T> 约束）和浮点具体类型重载"。当前实现已直接采用 `Integer<T>` 约束（line 12），相当于已部分落实 OOD 阶段四拆分计划的第一段。
- **影响**：积极偏差。提前消除了 `Number<T>` 约束下 % 运算符不可用（与 deviations.md DV-02 记录的限制完全一致）的潜在编译错误。Float32/Float64 重载暂未提供，与 OOD 阶段四计划一致（前向兼容——阶段四可新增 `func mod(a: Float32, b: Float32): Float32` 等具体类型重载，与现有 `mod<T>(a: T, b: T)` 无重载冲突）。
- **建议**：保留当前实现。在 OOD §3.7 line 679 处的 `mod` 暂定说明中明确标注"阶段二实现已采用 Integer<T> 约束（common.cj:12），与 OOD 阶段四拆分计划第一段一致"，便于后续维护者理解设计决定。

#### [轻微] common.cj 第 3 行 `import std.math.{ Number, Integer }` 中 `Integer` 仅被 `mod` 使用

- **位置**：`cjglm/src/detail/common.cj:3`
- **描述**：当前 import 同时引入 `Number`（用于 11 个函数的 `Number<T>` 约束）和 `Integer`（仅用于 `mod` 的 `Integer<T>` 约束）。两者未合并，但形式合理。
- **影响**：无问题。`Integer` 是 `Number` 的子接口，独立引入便于阅读。
- **建议**：无需修改。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 0 |
| 一般 | 4 |
| 轻微 | 3 |

### 总评

本轮审查的 3 个函数库文件实现质量良好，**未发现严重逻辑错误**。所有 33 个函数（27 实 + 6 stub）的签名、约束、异常占位均与 OOD §3.7 完全一致，27 个直接实现的重载（transpose/matrixCompMult/outerProduct 各 9 个）按 GLM 公式正确展开，6 个 stub 重载（determinant/inverse 各 3 个）按 OOD 规范以 `throw Exception("stub")` 占位。

**核心优点**：

1. **签名完整性**：27 实 + 6 stub = 33 个函数签名全部到位，与 OOD §3.7 函数清单完全对应。
2. **依赖闭合性**：common.cj/matrix.cj/geometric.cj 的 stub 签名为 `type_mat2x2.cj/type_mat3x3.cj/type_mat4x4.cj` 的 .inl 编排提供依赖闭合（OOD §2 line 71-73），阶段二 `cjpm build` 可通过。
3. **约束放松策略**：transpose 的 9 个重载采用 `where Q <: Qualifier`（无 `Number<T>`），符合 OOD §3.7 line 730 和 D36 决策（兼容 Bool 矩阵）。matrixCompMult/outerProduct 保留 `Number<T>` 约束，符合 OOD §3.7 line 731。
4. **forward 兼容性**：所有 stub 函数签名与 OOD 阶段三（determinant/inverse）、阶段四（common/geometric）规划一致，阶段三/四补全实现时无需修改签名。
5. **测试覆盖 stub 行为**：所有 12 + 6 + 20 = 38 个 stub 函数均通过 `@ExpectThrows[Exception]` 验证抛异常。
6. **geometric.cj Vec1 覆盖差异处理**：与 OOD §3.7 line 771 显式说明一致——仅 `dot` 提供 Vec1 版本，其他几何函数（normalize/length/distance/reflect/refract）Vec1 版本推迟至阶段四确认。test_geometric.cj 的 `testDotVec1Stub` 单独验证 dot Vec1 stub 行为。
7. **mod 约束收紧**：common.cj line 12 采用 `Integer<T>` 而非 OOD 暂定的 `Number<T>`，提前避免 `Number<T>` 下 % 运算符不可用的编译错误，与 deviations.md DV-02 一致。

**测试覆盖盲点**：

- matrix.cj 中 matrixCompMult 仅 3/9 重载、outerProduct 仅 3/9 重载被单元测试覆盖（覆盖率 33%）
- double-transpose 恒等性质仅对 Mat2x2/Mat4x4 验证（覆盖率 22%）
- stub 异常仅断言抛出，未验证异常信息包含 "stub"（无法区分 stub 占位与其他异常）

**遗留建议**：

本轮审查未引入新的功能偏差或阻塞性问题。4 项 [一般] 问题均为测试覆盖与风格一致性问题，可在后续测试补充轮次中修复，不影响阶段二 squash merge 决策。3 项 [轻微] 问题中 1 项为积极偏差（mod 约束收紧）、2 项为微小改进建议。

总体而言，本轮审查的 3 个函数库文件实现严格按照 OOD §3.7 设计执行，依赖闭合性与前向兼容性均已满足，可通过 squash merge。