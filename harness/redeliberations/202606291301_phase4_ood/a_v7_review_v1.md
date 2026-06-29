# OOD 设计方案审查报告（v7）

## 审查结果

REJECTED

## 逐维度审查

### 1. 类型系统可行性

**[通过]** 设计使用的包级泛型函数 + `FloatingPoint<T>`/`Number<T>`/`Comparable<T>` 约束均为仓颉标准接口，类型形态选择合理。

**[通过]** Vec1~Vec4 展开模式（而非整数维度泛型参数）已在 §3.2 `ext/vector_common.cj` 中以"符号约定"明确声明，属于设计级速记记号，展开为具体重载后完全在仓颉类型系统能力范围内。

**[通过]** 元组返回替代引用参数（`modf`/`frexp`）是仓颉中的自然模式。

**[通过]** 所有继承/实现关系均为自由函数，无 class/interface 继承约束问题。

### 2. 标准库与生态覆盖

**[严重]** §1.4（第 50 行）声明 "std.math 提供 Float16/Float32/Float64 三重重载的函数可直接调用，无需额外类型转换"，并在 §3.1 `exponential.cj`（第 261 行）和 §3.1 `trigonometric.cj`（第 276 行）中声称 `sqrt/exp/log/exp2/log2/sin/cos/tan` 等 std.math 函数已"验证 Float16/Float32/Float64 三重载均可用"。然而：① 可查阅的 std.math 文档显示上述函数仅为 `(Float64): Float64` 签名，无 Float16/Float32 重载；② 现有项目代码（`ext/quaternion_geometric.cj:5-8`、`ext/quaternion_trigonometric.cj:5-8`、`detail/type_quat_cast.cj:5-7`）已明确使用 `(x as Float64).getOrThrow()` 转换后再调用 `std.math.sqrt` 的包装函数 `sqrtT`，这直接证明 `std.math.sqrt` 不接受 Float16/Float32 泛型参数。设计的"已验证"断言与现有代码事实矛盾。此问题影响 `exponential.cj`（全部 7 个函数）、`trigonometric.cj`（全部 15 个函数）、`geometric.cj`（`length`/`normalize`/`distance`/`reflect` 等依赖 sqrt 的函数）以及 `matrix.cj` 的 `inverse`（依赖除法运算），覆盖阶段四大部分核心函数库。**设计不可行**。

**[通过]** `ThreadLocal<T>` 用于 `gtc/random.cj` 的随机数引擎管理经仓颉并发编程文档确认可用，`Random` 类的 `nextFloat16/32/64()` 和 `nextGaussianFloat64()` 方法均存在。✓

**[轻微]** `gtc/packing.cj` 和 `gtc/ulp.cj` 依赖的 `Float32.toBits(): UInt32` / `Float32.fromBits(bits: UInt32): Float32` 等位操作方法在现有文档和代码中均未发现使用记录。建议在编码前增加编译验证项确认这些 API 的可用性和签名。

### 3. 语言特性可行性

**[通过]** 函数重载决议机制（H6）经仓颉函数文档确认：基于参数类型和参数数量区分，与设计的 `mix`/`exp`/`log`/`pow`/`sqrt` 跨包同名符号消歧策略一致。✓

**[通过]** `acos`/`asin` 越界返回 NaN 的前置保护策略（D26）正确反映了仓颉 `std.math.acos`/`std.math.asin` 抛出 `IllegalArgumentException` 的行为，替代方案合理。✓

**[通过]** 并发模型设计：除 `gtc/random.cj` 外均为纯函数，`ThreadLocal<Random>` 方案经仓颉并发文档确认可行。✓

**[通过]** 模块依赖方向清晰单向，无循环依赖。包结构遵循 cjpm 组织方式。✓

**[一般]** §3.1 `exponential.cj` 的 D29（第 832 行）正确识别了 `std.math.pow` 缺 Float16 重载的问题并提供了 `exp(T(exp) * log(base))` 回退。但 D29 的逻辑自洽性存在问题：若 `std.math.exp` 和 `std.math.log` 确如设计所言提供 Float16 重载，而 `std.math.pow` 却没有，这在同一个 `std.math` 模块中是不一致的设计。结合 `sqrtT` 包装函数的既有模式，更合理的推断是 `exp`/`log`/`sqrt` 等函数同样仅有 Float64 重载。因此 D29 的回退路径本身也可能不可行（`exp` 和 `log` 同样缺少 Float16 入口）。此问题与维 2 的严重问题相关，但限于 D29 局部范围，单独分类为一般。

### 4. 设计一致性

**[通过]** 各抽象的职责描述清晰，协作关系形成闭环，模块间依赖方向合理。

**[通过]** 迭代需求中的 7 个问题（P1-P7）在「修订说明（v6 → v7）」和正文中均已正确修复。逐一确认：
- P1: §8 lib.cj 第 896 行新增 `geometric.cj` 导出 ✓
- P2: §8 lib.cj 第 898 行新增 `matrix.cj determinant/inverse` 导出 ✓
- P3: §3.2 第 445 行计数从"8"修正为"7" ✓
- P4: §3.1 第 292-294 行 `normalize` 职责明确覆盖 Vec1~Vec4 ✓
- P5: §8 lib.cj 第 899-903 行新增 `ext/scalar_common/vector_common` 导出 ✓
- P6: §3.2 第 475 行明确 `epsilon<T>()` 退化判定条件 ✓
- P7: §3.1 第 239 行更新 `mod` 约束共存策略 ✓

**[通过]** 与阶段一/二/三的集成关系描述完整，反向兼容性分析到位。

### 5. 设计质量

**[通过]** 职责划分清晰，单一职责原则得到遵循。抽象层次恰当——不包含实现级细节（如具体字段命名、算法循环展开等），符合架构级 OOD 的抽象粒度。

**[通过]** 实施批次建议（§8）按拓扑依赖排序，分批合理，可为编码阶段提供良好的指导。

**[轻微]** `gtc/noise.cj` 的噪声算法实现参考 GLM 1.0.3 的 `detail/_noise.hpp` 和 `gtc/noise.inl`，评估约 250~300 行有效代码。此评估未注明仓颉 `Vec4` 分量访问语法与 C++ 的差异可能引入的额外工作量。建议编码阶段预留缓冲。

## 修改要求

### 问题 1（严重）— std.math 函数 Float16/Float32 重载不可用的设计假设错误

- **问题**：设计的核心假设 H4/H5 的推论"std.math 提供 Float16/Float32/Float64 三重重载"与现有代码事实不符。现有代码已使用 `(x as Float64).getOrThrow()` 包装函数规避此限制。设计在 §3.1 `exponential.cj` 和 `trigonometric.cj` 中声称"直接委托 std.math 对应函数"无法在 Float16/Float32 泛型代码中工作。
- **原因**：此假设影响 `exponential.cj`（7 个函数）、`trigonometric.cj`（15 个函数）、`geometric.cj`（依赖 sqrt）、`inversesqrt` 实现，覆盖阶段四核心函数库的大部分。按设计所述直接委托，代码将无法通过编译。
- **建议方向**：
  1. 参照现有项目代码的 `sqrtT` 模式，为 `std.math.sqrt`/`exp`/`log`/`exp2`/`log2`/`sin`/`cos`/`tan`/`asin`/`acos`/`atan`/`atan2`/`sinh`/`cosh`/`tanh`/`asinh`/`acosh`/`atanh` 等每个 std.math 函数提供统一的泛型包装函数（如 `sqrtT<T>(x: T): T where T <: FloatingPoint<T>`），内部使用 `(x as Float64).getOrThrow()` 转换为 Float64 后委托 std.math 函数，或将结果 `(result as T).getOrThrow()` 转回。
  2. 或者在 `glm.detail` 中定义一个私有工具包（如 `stdmath_shim.cj`），集中提供所有需要的 std.math 包装器，各函数库统一调用此包装层而非直接委托 std.math。
  3. 更新 H4/H5 的确定性声明，删除"已验证 Float16/Float32/Float64 三重载"的不准确表述，替换为准确的 Float64-only 委托模式说明。
  4. 同步更新 D29：`exp(T(exp) * log(base))` 回退路径同样需要包装函数（`exp`/`log` 也没有 Float16 重载），或直接在 D29 中使用 `(pow(Float64(base), Float64(exp)) as T).getOrThrow()`。

### 问题 2（一般）— D29 回退路径自洽性问题

- **问题**：D29 认为 `std.math.pow` 缺 Float16 重载而 `std.math.exp`/`std.math.log` 有。这与维 2 的严重问题相关——若 `exp`/`log` 同样仅有 Float64 重载，D29 的 `exp(T(exp) * log(base))` 回退路径同样不可行。
- **原因**：D29 的假设在现有代码中无法验证，与可查阅的 std.math 文档不一致。
- **建议方向**：将 D29 的回退路径统一为 Float64 转换模式：`(pow(Float64(base), Float64(exp)) as T).getOrThrow()`。此模式无需依赖 `std.math.exp`/`log` 的 Float16 重载，与 `sqrtT` 一致。
