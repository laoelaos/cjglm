# R1c: 标量-向量运算层代码与 OOD 设计一致性审查

审查时间：2026-06-20

### 审查范围

- `cjglm/src/detail/scalar_vec_ops.cj` — 标量-向量运算包级函数实现
- `cjglm/src/detail/scalar_vec_ops_test.cj` — 对应单元测试
- 参考依据：`docs/02_ood_phase0.md`（OOD 设计方案）

### 发现

#### [一般] 所有 20 个包级函数缺少 `const` 修饰符

- **位置**：`scalar_vec_ops.cj:6-103`（add/sub/mul/div/mod 全部重载）
- **描述**：OOD 设计 §4.3 及 §7 D32 明确要求 scalar-op-vec 方向包级独立函数声明为 `const` 函数。理由包括：① 与 `mod`（需编译期 `if` 分支选择）的 API 签名一致；② 允许在 const 表达式中调用；③ 为后续轮次预留。当前代码所有函数均使用 `public func`，缺少 `const` 修饰符。
- **建议**：在每个函数签名中添加 `const` 修饰符，即 `const public func add<T, Q>(s: T, v: Vec1<T, Q>): Vec1<T, Q> ...`

#### [一般] `mod` 函数仅实现整数路径，缺少浮点双路径

- **位置**：`scalar_vec_ops.cj:85-103`
- **描述**：OOD 设计 §4.3 要求 `mod` 包级独立函数通过 `if (isIec559Of<T>())` 编译期分支实现整数/浮点双路径：整数 T 使用 `%` 运算符，浮点 T 使用算术恒等式 `x - y * trunc(x / y)`。当前 4 个 `mod` 函数均使用 `where T <: Integer<T>` 约束，仅支持整数类型，未实现浮点路径。`Float32`/`Float64` Vec 上无法调用 `mod(s, v)`。
- **建议**：① 将约束扩展为 `where T <: Number<T>` 以涵盖浮点类型；② 在函数体内添加编译期 `if (isIec559Of(v.x))` 分支处理浮点路径；③ 导入 `std.math.trunc`。注意：此方案依赖编译期 `if` 分支抑制验证（§2.1 项④/⑫）通过，且 `isIec559Of` 函数当前为非 `const` 形式（`shim_limits.cj:17`），需同步改造为 `const` 函数方可配合编译期 `if` 使用。

#### [轻微] 缺少 `std.math.trunc` 导入

- **位置**：`scalar_vec_ops.cj:2`
- **描述**：OOD 设计 §8.1 文件清单标注 `scalar_vec_ops.cj` 的浮点 `mod` 路径依赖 `std.math.trunc`（`Float64` 版本，`Float32` 提升至 `Float64` 后调用）。当前 `import` 行 `import std.math.{ Number, Integer }` 未包含 `trunc`。
- **建议**：在 `import` 行补充 `trunc`，改为 `import std.math.{ Number, Integer, trunc }`。

#### [一般] 测试覆盖不够完整

- **位置**：`scalar_vec_ops_test.cj:7-174`
- **描述**：20 个测试用例覆盖了 `Int64` 类型的 add/sub/mul/div/mod 针对 Vec1~Vec4 的基本正确性，但存在以下缺失：
  - 仅覆盖 `Int64` 单一类型，未覆盖 `Float32`/`Float64` 浮点类型的 add/sub/mul/div 测试
  - 未覆盖其他整数类型（`Int32`、`UInt8` 等）的运算
  - 未覆盖溢出 `@OverflowWrapping` 行为验证（如 `MAX + 1` 是否 wrapping 而非抛异常）
  - 未覆盖边界值：除零、负操作数浮点 mod 边界值（Inf/NaN）
- **建议**：① 增加 `Float32`/`Float64` 类型的 add/sub/mul/div 测试（至少 Vec2/Vec4）；② 增加整数溢出 wrapping 验证；③ 补充除零/负操作数等边界值用例。

### 额外发现（审查范围外但相关）

- **位置**：`shim_limits.cj:17`
- OOD 设计（§3.5）中的 `isIec559Of<T>()` 为 `const` 函数（无参），但实际实现为 `public func isIec559Of<T>(hint: T): Bool`（非 `const`，需要 `hint` 参数）。此差异影响 `scalar_vec_ops.cj` 中 `mod` 浮点路径的编译期 `if` 方案可行性——若 `isIec559Of` 非 `const`，则无法在 `const` 函数中作为编译期 `if` 条件。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 0 |
| 一般 | 3 |
| 轻微 | 1 |

### 总评

`scalar_vec_ops.cj` 的整体代码结构与 OOD 设计一致：包声明正确（`package glm.detail`）、函数签名参数顺序正确（标量在左、Vec 在右）、`@OverflowWrapping` 标注已存在、泛型约束 `Number<T>`/`Integer<T>` 使用正确。主要偏差集中在 **缺少 `const` 修饰符**（全部 20 个函数）和 **`mod` 函数未实现浮点双路径**——前者影响 const 上下文中的可用性，后者使浮点 Vec 无法使用 `mod(s, v)`。测试覆盖偏窄，仅覆盖 `Int64` 类型，缺少浮点类型测试和溢出行为验证。
