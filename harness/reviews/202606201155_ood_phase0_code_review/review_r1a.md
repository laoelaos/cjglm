# R1a: 审查基础设施层代码与 OOD 设计一致性

审查时间：2026-06-20

### 审查范围

- `cjglm/src/detail/setup.cj`
- `cjglm/src/detail/qualifier.cj`
- `cjglm/src/detail/shim_assert.cj`
- `cjglm/src/detail/shim_limits.cj`
- `cjglm/src/detail/shim_cstddef.cj`
- `cjglm/src/detail/setup_test.cj`
- `cjglm/src/detail/qualifier_test.cj`
- `cjglm/src/detail/shim_assert_test.cj`
- `cjglm/src/detail/shim_limits_test.cj`

### 发现

#### [一般] setup.cj: 配置常量使用 `public let` 而非 `public const`

- **位置**：`cjglm/src/detail/setup.cj:3-9`
- **描述**：设计文档（`02_ood_phase0.md` §2）明确标明 `setup.cj` 为"配置常量"，并在 §2.1 中注明"`setup.cj` 仅包含 `const` 配置常量"。当前实现全部使用 `public let` 而非 `public const`。所有初始化表达式均为字面量（`Int64(1)`、`false`、`Int64(103)` 等），属于合法的 const 表达式（仓颉 `const` 函数调用和数值字面量均可作为 const 表达式），语法上完全可替换为 `public const`。
- **建议**：将所有 7 个 `public let` 替换为 `public const`：`public const GLM_VERSION_MAJOR: Int64 = Int64(1)` 等等。如需保持 `let` 延迟绑定的意图，应在设计文档中说明与设计的偏离理由。

#### [一般] shim_limits.cj: 函数签名与设计文档不一致（非 `const`、带 hint 参数）

- **位置**：`cjglm/src/detail/shim_limits.cj:5-27`
- **描述**：设计文档（§3.6）明确规定以下签名：
  - `const func isIec559Of<T>(): Bool`（无参数，`const`，内部使用 `T(0) is Float64` 检测类型）
  - `const func epsilonOf<T>(): T where T <: Number<T>`（无参数，`const`）
  - `NumericLimits<T>` 的 `static func epsilon(): T`（无参数）

  当前实现使用了带 `hint` 参数的运行时版：
  - `public func isIec559Of<T>(hint: T): Bool` — 非 const，带 hint
  - `public func epsilonOf<T>(hint: T): T where T <: Number<T>` — 非 const，带 hint
  - `NumericLimits<T>.epsilon(hint: T): T` — 带 hint 参数

  此偏离影响设计文档中 `ComputeEqual.callConst` 的 const 依赖链——若 `isIec559Of` 和 `epsilonOf` 非 const，它们无法在 `const` 函数体（`ComputeEqual.callConst`）中被调用。
- **建议**：确认 `ComputeEqual.callConst` 是否仍需要 const 版本的 `isIec559Of` 和 `epsilonOf`。若需要，则恢复为设计文档指定的 `const` 无参签名；若已整体放弃 const 路径，则需同步更新设计文档并评估对相等比较策略的影响。

#### [轻微] shim_limits.cj: 未使用的导入 `import std.math.*`

- **位置**：`cjglm/src/detail/shim_limits.cj:3`
- **描述**：`import std.math.*` 导入未在文件中使用任何 `std.math` 的功能。设计文档（§2）声明 shim_* 文件"无依赖（仅使用仓颉原生类型）"，此导入与设计意图不符。
- **建议**：移除 `import std.math.*` 行。

#### [轻微] qualifier_test.cj: Aligned 系列类型未纳入测试覆盖

- **位置**：`cjglm/src/detail/qualifier_test.cj`
- **描述**：`qualifier_test.cj` 测试了 PackedHighp/Mediump/Lowp 及 Defaultp 别名的正确性，但未覆盖 AlignedHighp/AlignedMediump/AlignedLowp。测试文件与生产代码同属 `package glm.detail`，`internal` 可见性对测试不影响。
- **建议**：补充 Aligned 系列类型的测试用例，验证其同样实现 `Qualifier` 接口（格式与 Packed 系列测试一致）。

#### [轻微] shim_cstddef_test.cj: 缺少单元测试

- **位置**：（无测试文件）
- **描述**：`shim_cstddef.cj` 定义了 `SizeT` 和 `LengthT` 两个公开类型别名，但不存在对应的 `shim_cstddef_test.cj` 测试文件。虽然类型别名定义简单，但缺乏测试意味着回归无法被自动检测。
- **建议**：新增 `shim_cstddef_test.cj`，添加对 `SizeT`（验证其等于 `UInt64`）和 `LengthT`（验证其等于 `Int64`）的类型相等性检查。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 0 |
| 一般 | 2 |
| 轻微 | 3 |

### 总评

基础设施层整体实现质量良好——`qualifier.cj`、`shim_assert.cj`、`shim_cstddef.cj` 的实现与设计一致，代码简洁正确。主要问题集中在两个方面：

1. **`setup.cj` 的 `let`/`const` 选择**（一般）：与设计文档"const 配置常量"的明确要求不一致，需统一。
2. **`shim_limits.cj` 的设计偏离**（一般）：`isIec559Of`/`epsilonOf`/`NumericLimits.epsilon` 的签名从 const 无参模式改为 hint 参数模式，属于系统性的设计偏离。若 `ComputeEqual.callConst` 依赖 const 版本，此偏离将导致编译或功能问题；若不依赖，应更新设计文档以反映实际签名。

测试覆盖方面：`setup_test.cj`、`shim_limits_test.cj`、`shim_assert_test.cj` 均充分覆盖了核心行为。`qualifier_test.cj` 缺少 Aligned 系列覆盖，`shim_cstddef_test.cj` 完全缺失——后者虽然不是高密度逻辑但建议补充以建立回归防护网。
