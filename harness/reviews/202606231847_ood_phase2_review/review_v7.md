# R7: 已知偏差处理与特殊场景的端到端审查

审查时间：2026-06-23

### 审查范围

**核心实现文件**：
- `cjglm/src/detail/type_mat4x4.cj`（重点，含 Mat4x4←Mat4x2 DEVIATION）
- `cjglm/src/detail/type_mat2x2.cj`、`type_mat2x3.cj`、`type_mat2x4.cj`
- `cjglm/src/detail/type_mat3x2.cj`、`type_mat3x3.cj`、`type_mat3x4.cj`
- `cjglm/src/detail/type_mat4x2.cj`、`type_mat4x3.cj`

**测试文件**：
- `cjglm/tests/glm/detail/test_type_mat4x4.cj`
- `cjglm/tests/glm/test_integration_matrix.cj`
- `cjglm/tests/glm/detail/test_type_mat_compare.cj`（Bool 矩阵测试，仅供交叉验证）

**参考文档**：
- `docs/04_ood_phase2.md` §3.3 items 6-8（D33、NaN 传播、纯收缩方向）
- `docs/deviations.md` DV-01
- 已知问题清单：`harness/reviews/202606231847_ood_phase2_review/known_issues.md` K1、K2

### 背景

本轮审查目标聚焦四个已知偏差处理与特殊场景：

1. **Mat4x4←Mat4x2 DEVIATION 偏差方向**：GLM 1.0.3 `type_mat4x4.inl:246` 在该方向丢弃源矩阵列 2、3 的前两行数据，填入单位矩阵对角线（c2=(0,0,1,0)、c3=(0,0,0,1)），与主规则（含修正后的对角线 one 规则）不同。OOD §3.3 第 347 行明确要求编码阶段针对该方向做特殊处理；OOD §3.3 第 391 行表格中此方向标注为 🚨 **DEVIATION**。
2. **Bool 矩阵支持范围（D33）**：Bool 不实现 `Number<T>` 接口，因此所有 `Number<T>` 约束下的算术运算、`diagonal`/`identity` 工厂函数、`equalEpsilon` 均不适用；但 `fromMat 7`（跨类型同尺寸）只需 `Qualifier` 约束，Bool 矩阵应支持。
3. **NaN 传播行为**：OOD §3.3 第 276、282 行规定 `one` 传入 NaN 时，对角填充结果按底层数值运算自然传播 NaN，**不额外定义特殊分支**。
4. **纯收缩方向 `one` 参数语义**：OOD §3.3 第 286 行规定纯收缩方向下 `one` 参数被忽略，但签名中保留以保持 API 统一。

### 审查结果摘要

| 关注项 | 验证状态 | 备注 |
|--------|---------|------|
| Mat4x4←Mat4x2 实现（6a/6b） | ✅ 一致 | 实现正确遵循 OOD §3.3 第 347 行 |
| 单元测试 6a/6b（Mat4x4←Mat4x2） | ✅ 一致 | `test_type_mat4x4.cj:633-653` 与 `:837-858` 正确断言偏差行为 |
| 集成测试偏差方向 | ❌ **未修复** | R6 已识别的严重问题（line 331-344 仍断言错误预期值），阻塞合并 |
| Bool 矩阵 `diagonal`/`identity` 不可用 | ✅ 正确 | 全 9 个矩阵类型均在 `Number<T>` 约束下定义，自动排除 Bool |
| Bool 矩阵算术运算符不可用 | ✅ 正确 | unary `-`、矩阵-标量 ±*/、矩阵-矩阵 ±*/、`/` 均在 `Number<T>` 约束下 |
| Bool 矩阵 `fromMat 7` 可用 | ✅ 正确 | 全 9 个矩阵类型的 `fromMat<U, P>(conv, m)` 均在 `where Q <: Qualifier` 约束下 |
| NaN 传播自然化（无特殊分支） | ✅ 正确 | 全 9 个矩阵类型均无 `isNaN` / `if isnan` 等特殊处理 |
| 纯收缩方向 `one` 参数保留但忽略 | ✅ 正确 | 签名保留 `one: T`，函数体内不引用 |
| Bool 矩阵不支持的负向测试覆盖 | ⚠️ 缺失 | 仅测试 `Bool` 的 `==`/`!=`，未显式验证 `identity`/`diagonal`/`+/-` 不存在 |

### 发现

#### [严重] 集成测试 `testIntegrationFromMatDeviation` 偏差方向预期值仍未修正（R6 已识别遗留问题）

- **位置**：`cjglm/tests/glm/test_integration_matrix.cj:338-341`
- **描述**：本轮审查聚焦偏差处理时再次核对，确认 R6（review_v6.md）发现的严重问题仍然存在于未提交代码中。该测试断言 `Mat4x4.fromMat(Mat4x2(...), Float32(1.0))` 应保留源矩阵列 2/3 的前两行数据：
  ```cangjie
  @Expect(m44.c2.x, Float32(5.0))   // 实际：0.0
  @Expect(m44.c2.y, Float32(6.0))   // 实际：0.0
  @Expect(m44.c3.x, Float32(7.0))   // 实际：0.0
  @Expect(m44.c3.y, Float32(8.0))   // 实际：0.0
  ```
  然而 OOD §3.3 第 347 行明确规定 Mat4x4←Mat4x2 是已知 GLM 偏差：GLM 丢弃源列 2/3 的前两行数据并填入单位矩阵对角线 `(0,0,1,0)` 和 `(0,0,0,1)`。`type_mat4x4.cj:235-239`（6a）与 `:287-291`（6b）实际实现均正确遵循此偏差行为；`test_type_mat4x4.cj:633-653`（6a）与 `:837-858`（6b）的单元测试亦正确断言偏差行为。**集成测试与单元测试、OOD 设计文档、实际实现四者自相矛盾**。

  R6 审查报告（review_v6.md:27-58）已给出完整的修复方案，本轮核对结果完全一致。集成测试是端到端验证偏差行为的关键防线，其错误预期值若不被修复，CI 运行至该测试时将失败 4 个 `@Expect`（m44.c2.x/y、m44.c3.x/y），导致整个 PR 合并阻塞。
- **影响**：阻塞 CI 通过的硬错误，必须在合并前修复。
- **建议**：按照 R6 报告建议的方案修正 `test_integration_matrix.cj:338-341` 的预期值：
  ```cangjie
  @Expect(m44.c2.x, Float32(0.0))
  @Expect(m44.c2.y, Float32(0.0))
  @Expect(m44.c2.z, Float32(1.0))
  @Expect(m44.c2.w, Float32(0.0))
  @Expect(m44.c3.x, Float32(0.0))
  @Expect(m44.c3.y, Float32(0.0))
  @Expect(m44.c3.z, Float32(0.0))
  // 末尾的 @Expect(m44.c3.w, Float32(1.0)) 已正确，无需改动
  ```

#### [轻微] `diagonal` 工厂函数在非方阵上命名易产生误解（设计层面观察，非功能问题）

- **位置**：`cjglm/src/detail/type_mat*.cj`（9 个文件，每个文件均有 `diagonal`）
- **描述**：OOD §3.3 第 236 行明确说明 `diagonal` 命名"明确表明该函数产生对角矩阵而非全填充矩阵，避免名称误导"，并在非方阵上主对角线（i = 0..min(C,R)-1）填入 `scalar`。实际实现与该说明一致，例如：
  - `type_mat3x2.cj:122-125`：`Mat3x2(Vec2(scalar, zero), Vec2(zero, scalar), Vec2(zero, zero))` —— 列 2 整列为 T(0)
  - `type_mat4x4.cj:131-134`：方阵 4×4 主对角线填 scalar
  
  然而 `diagonal(scalar)` 在非方阵（如 `Mat3x4` 即 C=3 列 × R=4 行）上产生的是一个**主对角线为 scalar 的非方阵**，从数学命名严格性角度看，`diagonal` 一词易与方阵对角矩阵混淆（例如 `Mat4x4.diagonal(s)` 与 `Mat4x4.identity(s)` 在方阵上结果相同，D34 也确认了这一点）。虽然 OOD 已解释命名选择，本审查不修改设计意图，但建议在 OOD 注释中补充一句"非方阵上 `diagonal` 退化为前 min(C,R) 行主对角线填 scalar"的明确说明，方便阅读者快速理解非方阵行为。
- **影响**：纯文档/可读性问题，不影响功能正确性。
- **建议**：在 OOD §3.3 第 234-238 行关于 `diagonal` 的描述中追加一句话，强调非方阵上 `diagonal(scalar)` 的行为特征；或在 deviations.md 中记录此命名偏差（如有跨生态对照需求）。

#### [轻微] Bool 矩阵不支持的负向测试覆盖缺失

- **位置**：`cjglm/tests/glm/detail/test_type_mat_compare.cj`（仅含 `==`/`!=`/`equalExact` 的正例测试）
- **描述**：D33 明确规定 Bool 矩阵不提供 `identity`/`diagonal`/算术运算符/`equalEpsilon`/`fromMat 6a/6b`。当前测试仅覆盖 Bool 矩阵 `==`/`!=`/`equalExact`（`test_type_mat_compare.cj:63-632`），未通过编译失败测试（compile-time negative test）显式锁定 Bool 矩阵对上述操作不可用。
  
  约束由 `extend<T, Q> ... where T <: Number<T>, Q <: Qualifier` 提供，编译器在实例化时会拒绝 Bool 类型，符合 D33 设计。但若未来有人在 `where Q <: Qualifier`（更宽松）块下误定义 `diagonal`/`identity`，没有测试能在 CI 阶段拦截此类回归。
- **影响**：缺少防护网，不影响当前实现正确性。
- **建议**：可选地添加一个编译时负向测试——尝试 `Mat4x4<Bool, Defaultp>.identity(Bool(true))` 或 `Mat4x4<Bool, Defaultp>.diagonal(Bool(true))`，预期编译失败。可在 `test_type_mat_compare.cj` 或独立的 `test_bool_matrix_negative.cj` 中实现。鉴于仓颉测试框架对编译错误的断言支持有限，此项可标记为已知覆盖空白，不阻塞合并。

### 端到端验证细节

#### 1. Mat4x4←Mat4x2 DEVIATION 实现核对

**实现（6a 同类型）**：`cjglm/src/detail/type_mat4x4.cj:235-239`
```cangjie
public static func fromMat<SrcQ>(m: Mat4x2<T, SrcQ>, one: T): Mat4x4<T, Q>
  where SrcQ <: Qualifier {
    let zero = m.c0.x - m.c0.x
    Mat4x4(Vec4<T, Q>(m.c0.x, m.c0.y, zero, zero), Vec4<T, Q>(m.c1.x, m.c1.y, zero, zero), Vec4<T, Q>(zero, zero, one, zero), Vec4<T, Q>(zero, zero, zero, one))
}
```
- 列 0、1：复制源前两行，行扩展填充 zero。✓
- 列 2：构造为 `(0, 0, 1, 0)`，**丢弃源列 2 前两行**。✓ 与 OOD §3.3 第 347 行 GLM 偏差行为一致。
- 列 3：构造为 `(0, 0, 0, 1)`，**丢弃源列 3 前两行**。✓ 与 OOD §3.3 第 347 行 GLM 偏差行为一致。

**实现（6b 跨类型）**：`cjglm/src/detail/type_mat4x4.cj:287-291`
```cangjie
public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x2<U, P>, one: T): Mat4x4<T, Q>
  where P <: Qualifier {
    let zero = one - one
    Mat4x4(Vec4<T, Q>(conv(m.c0.x), conv(m.c0.y), zero, zero), Vec4<T, Q>(conv(m.c1.x), conv(m.c1.y), zero, zero), Vec4<T, Q>(zero, zero, one, zero), Vec4<T, Q>(zero, zero, zero, one))
}
```
- 6b 与 6a 实现完全一致（仅 T(0) 演算路径不同：`one - one` vs `m.c0.x - m.c0.x`）。✓
- 列 2、3 同样构造为单位矩阵列，丢弃源列 2、3 前两行。✓

**单元测试 6a（`test_type_mat4x4.cj:633-653` `testMat4x4FromMat6aMat4x2Deviation`）**：
- 源矩阵：`Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)`（列 2=(5,6)、列 3=(7,8)）
- 预期：c0=(1,2,0,0)、c1=(3,4,0,0)、**c2=(0,0,1,0)**、**c3=(0,0,0,1)**
- 与实现完全一致。✓

**单元测试 6b（`test_type_mat4x4.cj:837-858` `testMat4x4FromMat6bMat4x2Deviation`）**：
- 源矩阵：`Mat4x2<Int64, Defaultp>(1, 2, 3, 4, 5, 6, 7, 8)`，`conv: Int64→Float64`
- 预期：c0=(1,2,0,0)、c1=(3,4,0,0)、**c2=(0,0,1,0)**、**c3=(0,0,0,1)**（Float64）
- 与实现完全一致。✓

**结论**：实现与单元测试均严格遵循 OOD 偏差设计。集成测试是唯一未对齐的环节。

#### 2. D33 Bool 矩阵支持范围核对

逐一核对 9 个矩阵类型文件中 `diagonal`/`identity`/`fromMat 7` 的 extend 块约束：

| 矩阵类型 | diagonal 所在块 | identity 所在块 | fromMat 7（cross-type same-size）所在块 |
|---------|----------------|----------------|---------------------------------------|
| Mat2x2 | `where T <: Number<T>` ✓ | `where T <: Number<T>` ✓ | `where Q <: Qualifier` ✓ |
| Mat2x3 | `where T <: Number<T>` ✓ | `where T <: Number<T>` ✓ | `where Q <: Qualifier` ✓ |
| Mat2x4 | `where T <: Number<T>` ✓ | `where T <: Number<T>` ✓ | `where Q <: Qualifier` ✓ |
| Mat3x2 | `where T <: Number<T>` ✓ | `where T <: Number<T>` ✓ | `where Q <: Qualifier` ✓ |
| Mat3x3 | `where T <: Number<T>` ✓ | `where T <: Number<T>` ✓ | `where Q <: Qualifier` ✓ |
| Mat3x4 | `where T <: Number<T>` ✓ | `where T <: Number<T>` ✓ | `where Q <: Qualifier` ✓ |
| Mat4x2 | `where T <: Number<T>` ✓ | `where T <: Number<T>` ✓ | `where Q <: Qualifier` ✓ |
| Mat4x3 | `where T <: Number<T>` ✓ | `where T <: Number<T>` ✓ | `where Q <: Qualifier` ✓ |
| Mat4x4 | `where T <: Number<T>` ✓ | `where T <: Number<T>` ✓ | `where Q <: Qualifier` ✓ |

进一步核对算术运算符约束（以 Mat4x4 为代表，其他 8 个矩阵结构相同）：
- 一元负号 `operator func -()`：line 61 `where T <: Number<T>` ✓
- 矩阵-标量 ±*/：lines 66-84 同上 ✓
- 矩阵-矩阵 +/-：lines 86-94 同上 ✓
- 矩阵-矩阵 *（同尺寸/跨尺寸）：lines 96-121 同上 ✓
- 矩阵-矩阵 /（仅方阵）：line 124 同上 ✓
- 矩阵-向量 *：line 127 同上 ✓

**结论**：所有 9 个矩阵类型的 `diagonal`/`identity`/算术运算符/`/` 均严格在 `Number<T>` 约束下提供，编译器对 Bool 实例化时会拒绝；`fromMat 7` 严格在 `Qualifier` 约束下提供，Bool 可正常调用。完全符合 D33 设计意图。

#### 3. NaN 传播行为核对

逐文件搜索 `isNaN`/`isnan`/`NaN`/`Float32.NaN` 等关键词，确认无特殊 NaN 处理逻辑：

| 文件 | 关键词搜索结果 |
|-----|--------------|
| `type_mat4x4.cj` | 无 `isNaN`/`NaN` 相关代码 |
| `type_mat2x2.cj` ~ `type_mat4x3.cj`（其余 8 个） | 无 `isNaN`/`NaN` 相关代码 |

实际 NaN 传播路径分析（以 `type_mat4x4.cj:131-134` `diagonal(scalar: T)` 为例）：
```cangjie
public static func diagonal(scalar: T): Mat4x4<T, Q> {
    let zero = scalar - scalar    // NaN - NaN = NaN
    Mat4x4(Vec4<T, Q>(scalar, zero, zero, zero), Vec4<T, Q>(zero, scalar, zero, zero), Vec4<T, Q>(zero, zero, scalar, zero), Vec4<T, Q>(zero, zero, zero, scalar))
}
```
- 若 `scalar = NaN`：则 `zero = NaN - NaN = NaN`，主对角线 `scalar = NaN`，非对角线 `zero = NaN`，整个矩阵所有元素为 NaN。✓
- 若 `one = NaN`（`identity` 委托 `diagonal`）：同 `diagonal` 行为。✓

`identity` 实现（`type_mat4x4.cj:136`）：`public static func identity(one: T): Mat4x4<T, Q> { diagonal(one) }`，直接转发，无额外处理。✓

`fromMat 6a` 实现（`type_mat4x4.cj:237-238`）：
```cangjie
let zero = m.c0.x - m.c0.x   // 不依赖 one
Mat4x4(..., Vec4<T, Q>(zero, zero, one, zero), Vec4<T, Q>(zero, zero, zero, one))
```
- 若 `one = NaN`：zero 路径不依赖 one（来自源矩阵），对角线位置 `one = NaN` 直接传播。✓

`fromMat 6b` 实现（`type_mat4x4.cj:289-290`）：
```cangjie
let zero = one - one   // NaN - NaN = NaN
Mat4x4(..., Vec4<T, Q>(zero, zero, one, zero), Vec4<T, Q>(zero, zero, zero, one))
```
- 若 `one = NaN`：zero = NaN（自然传播），对角线位置 one = NaN（自然传播）。✓

**结论**：所有 9 个矩阵类型的 `diagonal`/`identity`/`fromMat 6a/6b` 均无 NaN 特殊分支，完全依赖底层数值运算的自然 NaN 传播。严格遵循 OOD §3.3 第 276、282 行约定。

#### 4. 纯收缩方向 `one` 参数语义核对

逐一核对纯收缩方向的 `one` 参数使用情况（举例 `Mat2x2←Mat4x4`，`type_mat2x2.cj:190-194`）：

```cangjie
public static func fromMat<SrcQ>(m: Mat4x4<T, SrcQ>, one: T): Mat2x2<T, Q>
  where SrcQ <: Qualifier {
    let zero = m.c0.x - m.c0.x                        // line 192：声明但未使用（K2 已知问题）
    Mat2x2(Vec2<T, Q>(m.c0.x, m.c0.y), Vec2<T, Q>(m.c1.x, m.c1.y))    // line 193：仅截断，未引用 one 或 zero
}
```

- 签名保留 `one: T` 参数 ✓
- 函数体内不引用 `one` ✓
- 函数体内不引用 `zero`（声明但未使用，属 K2 已知风格问题，不影响功能）✓

跨类型版本（`type_mat2x2.cj:242-245` Mat2x2←Mat4x4）：
```cangjie
public static func fromMat<U, P>(conv: (U) -> T, m: Mat4x4<U, P>, one: T): Mat2x2<T, Q>
  where P <: Qualifier {
    let zero = one - one                            // 声明但未使用（K2）
    Mat2x2(Vec2<T, Q>(conv(m.c0.x), conv(m.c0.y)), Vec2<T, Q>(conv(m.c1.x), conv(m.c1.y)))
}
```
- 签名保留 `one: T` ✓
- 函数体内不引用 `one`（仅用其计算 zero，zero 本身未使用）✓

**结论**：纯收缩方向的 `one` 参数在签名中保留、函数体内未引用，符合 OOD §3.3 第 286 行约定。

附带说明：`zero` 变量在纯收缩方向函数体内虽声明但未使用（K2 已知问题），属于代码风格层面的一致性设计——保持 144 个 fromMat 重载使用同一函数体模板，提升代码生成脚本维护性。该问题已在 `known_issues.md` K2 中登记，修复涉及 9 个矩阵类型的代码风格统一，影响面大于实际收益，故暂不修复。本轮审查不重复标记。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 1 |
| 一般 | 0 |
| 轻微 | 2 |

### 总评

本轮审查覆盖四个已知偏差处理与特殊场景，其中三项（Mat4x4←Mat4x2 实现与单元测试、D33 Bool 矩阵约束设计、NaN 传播自然化、纯收缩方向 `one` 参数语义）**全部与 OOD §3.3 设计一致**：

- **Mat4x4←Mat4x2 偏差实现**：9 个矩阵类型文件中 Mat4x4 类型两个重载（6a、6b）均严格遵循 GLM `type_mat4x4.inl:246` 的偏差行为，丢弃源列 2/3 前两行并填入单位矩阵对角线。单元测试 `testMat4x4FromMat6aMat4x2Deviation`（:633-653）与 `testMat4x4FromMat6bMat4x2Deviation`（:837-858）正确断言此行为，与 OOD §3.3 第 347 行规定完全一致。
- **D33 Bool 矩阵约束设计**：所有 9 个矩阵类型的 `diagonal`/`identity`/算术运算符/`/` 均在 `where T <: Number<T>` 约束下提供（自动排除 Bool）；`fromMat 7` 严格在 `where Q <: Qualifier` 约束下提供（Bool 可用）。约束边界在所有 9 个文件中保持一致，跨文件实现零差异。
- **NaN 传播自然化**：全部 9 个矩阵类型的工厂函数和 fromMat 重载中均无 `isNaN`/`if isnan` 等特殊处理路径，完全依赖底层数值运算的自然 NaN 传播。`diagonal` 通过 `scalar - scalar` 演算 zero，`identity` 直接委托 `diagonal`；`fromMat 6a/6b` 通过 `m.c0.x - m.c0.x` 或 `one - one` 演算 zero，对角线 `one` 直接填入。所有 NaN 传播路径均为类型系统自然结果。
- **纯收缩方向 `one` 参数**：所有纯收缩方向的 fromMat 6a/6b 重载签名保留 `one: T` 参数，函数体内不引用 `one`（或仅用于演算未被使用的 zero），与 OOD §3.3 第 286 行约定一致。

**主要问题**：本轮审查的**唯一阻塞性问题**仍是 R6（review_v6.md:27-58）已识别的 `testIntegrationFromMatDeviation` 偏差方向预期值错误。该问题本应在 R6 报告后立即修复，但截至本轮审查（2026-06-23），该问题仍未在代码中修正（R6 与 R7 的 git diff 显示相关测试文件未变更）。这是端到端偏差验证的**唯一缺口**——实现正确、单元测试正确、OOD 文档正确，仅集成测试断言与上述三者矛盾。此问题必须在合并前修复，否则将阻塞 CI。

**次要问题**：`diagonal` 命名在非方阵上的语义理解依赖 OOD 注释，缺乏仓颉代码层注释辅助理解；Bool 矩阵不支持的负向编译测试覆盖空白。这两个问题不影响功能正确性，建议作为低优先级改进项处理。

**总评结论**：本轮审查**不通过**，原因与 R6 一致——`test_integration_matrix.cj:331-344` 的偏差方向预期值错误尚未修复，该阻塞性问题必须在合并前修正。修正完成后，本轮覆盖的偏差处理与特殊场景（Mat4x4←Mat4x2 实现、D33 约束、NaN 传播、纯收缩方向 `one` 语义）**全部通过审查**，实现质量良好。