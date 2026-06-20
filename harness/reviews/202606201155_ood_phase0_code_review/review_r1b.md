# R1B: 计算基础设施层代码 OOD 设计一致性审查

审查时间：2026-06-20

### 审查范围

- `cjglm/src/detail/compute_vector_relational.cj`
- `cjglm/src/detail/compute_vector_decl.cj`
- `cjglm/src/detail/vectorize.cj`
- `cjglm/src/detail/compute_vector_relational_test.cj`
- `cjglm/src/detail/compute_vector_decl_test.cj`
- `cjglm/src/detail/vectorize_test.cj`

参考设计文档：`docs/02_ood_phase0.md §3.3~§3.5`

### 发现

#### [一般] `ComputeEqual` 结构体设计偏离：`callConst` 被拆分到独立结构体 `ComputeEqualNumeric`

- **位置**：`cjglm/src/detail/compute_vector_relational.cj:5`
- **描述**：OOD 设计文档 §3.5 明确指出 `ComputeEqual<T>` 应同时包含 `call` 和 `const callConst` 两个静态方法，通过编译期 `if (isIec559Of<T>())` 统一分支。实际代码将 `callConst` 拆分为独立的 `ComputeEqualNumeric<T>` 结构体（第 11 行），并追加了 `Number<T> & Equatable<T> & Comparable<T>` 三重约束。这一拆分导致：(1) `ComputeEqualNumeric` 的 `Comparable<T>` 约束并非源自设计——而是因为手动实现了 `abs` 替代 `std.math.abs`，被迫使用 `<` 比较符做绝对值判断；(2) `callConst` 无法被 `==` 运算符使用（`==` 在 extend 块中直接调用 `ComputeEqual<T>.call`，走精确比较路径），浮点容差比较仅通过 `equalEpsilon` 具名函数暴露，与设计的"`==` 自动使用容差比较"意图不符。
- **建议**：如果编译器 const 表达式链验证（§2.1 项①④⑫）不通过导致 const 路径不可行，则当前拆分方案属于 §3.5 备选路径的实施，应在代码或相关记录中标注备选路径选择和触发条件。如果 const 路径实际可行，建议合回 `ComputeEqual<T>` 并恢复设计预期路径。

#### [轻微] `callConst` 缺少 `const` 修饰符

- **位置**：`cjglm/src/detail/compute_vector_relational.cj:12`
- **描述**：OOD 设计 §3.5 原型代码中 `callConst` 声明为 `const static func callConst`。实际代码为 `public static func callConst`，缺少 `const`。其依赖的 `isIec559Of`（`shim_limits.cj:17`）和 `epsilonOf`（`shim_limits.cj:25`）也均非 `const` 函数——三者采用实例参数 + match 运行时模式匹配，而非设计的 `T(0) is Float64` 编译期模式。
- **建议**：如果编译器不支持 `T(0) is Float64` 编译期模式，这是 §2.1 项③验证失败后的合法回退。建议在代码辅以注释说明为何使用运行时模式匹配替代编译期 `is` 运算符，以避免后续维护者产生混淆。

#### [轻微] `ComputeEqualNumeric.callConst` 手动实现 `abs` 而非使用 `std.math.abs`

- **位置**：`cjglm/src/detail/compute_vector_relational.cj:13-17`
- **描述**：OOD 设计 §3.5 原型代码明确使用 `abs(a - b)`（`std.math.abs` 包级函数）。实际代码使用 `let diff = a - b; let zero = a - a; let adiff = if (diff < zero) { -diff } else { diff }` 手动计算绝对值。此实现虽然功能正确，但迫使 `ComputeEqualNumeric<T>` 增加 `Comparable<T>` 约束（`diff < zero` 需要 `<`），而设计中的 `abs` 版本仅需 `Number<T>` 约束。
- **建议**：评估是否可改用 `import std.math.{ abs }`。如果 `abs` 在 `callConst` 上下文中不可用（如非 const 或约束不匹配），保留手动实现并标注理由。

#### [轻微] `compute_vec_equalN` 未委托给 `ComputeEqual<T>.call`

- **位置**：`cjglm/src/detail/compute_vector_decl.cj:245-291`
- **描述**：`compute_vec_equal1~4` 和 `compute_vec_nequal1~4` 直接使用分量级 `a.x == b.x` / `a.x != b.x`，而非委托给 `ComputeEqual<T>.call(a.x, b.x)`。OOD 设计 §3.4 明确"相等比较通过 `ComputeEqual<T>` 策略处理"。当前实现功能上等价（`T <: Equatable<T>` 时 `==` 行为一致），但绕过了未来可能通过 `ComputeEqual` 修改相等策略的统一入口。
- **建议**：将 `compute_vec_equalN.call` 中的 `a.x == b.x` 替换为 `ComputeEqual<T>.call(a.x, b.x)`，将 `compute_vec_nequalN.call` 中的 `a.x != b.x` 替换为 `!(ComputeEqual<T>.call(a.x, b.x))`。

#### [轻微] `compute_vector_decl_test.cj:66-79` 位移测试静态值缺少位移类型匹配验证

- **位置**：`cjglm/src/detail/compute_vector_decl_test.cj:67-79`
- **描述**：位移测试使用 `Vec1<Int64, Defaultp>` 作为位移量操作数 `b`，而 `compute_vec_shift_left1` 的签名要求 `Vec1<Int64, Q>`——当前 `Int64` 与 `Int64` 一致，类型匹配正确。但若未来对 `T <: Integer<T>` 类型（如 `Int8`）测试位移，需注意位移量操作数 `b` 的泛型参数固定为 `Int64` 而非 `T`。当前测试未覆盖非 `Int64` 的位移场景。
- **建议**：可选补充 `Int8`/`Int32` 等含 `<<` 的整数类型的位移测试，确认 `VecN<Int64, Q>` 作为位移量参数的类型匹配正确。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 0 |
| 一般 | 1 |
| 轻微 | 4 |

### 总评

计算基础设施层代码整体质量良好，功能正确性经测试验证无误。主要发现集中在 `ComputeEqual` 结构体设计与 OOD 文档 §3.5 之间的偏差——实际代码选择了 §3.5 备选路径（精确比较 + 独立 `equalEpsilon`），但未明确标注回退选择。`compute_vector_decl.cj` 和 `vectorize.cj` 的运算策略结构体定义工整、符合设计模式，测试覆盖充分。建议在下一轮迭代中明确标注备选路径决策理由，并考虑将 `compute_vec_equalN` 委托给 `ComputeEqual<T>.call` 以保持设计一致性。
