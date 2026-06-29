# OOD 设计方案审查报告（v5）

## 审查结果

REJECTED

## 逐维度审查

### 1. 类型系统可行性

**[通过]** `FloatingPoint<T>` 接口提供 `isNaN()`/`isInf()` 等实例方法及 `getInf()`/`getNaN()` 等静态方法，可支撑 common.cj 的 `isnan`/`isinf` 等函数的设计方案。

**[通过]** `toBits()`/`fromBits()` 方法确认存在于 `Float16`/`Float32`/`Float64` 具体类型上，不在 `FloatingPoint<T>` 接口中。gtc/ulp.cj 改为具体类型重载（Float32/Float64）的决策正确。

**[通过]** `std.math` 确认提供 `Float16`/`Float32`/`Float64` 三重重载的三角函数和指数函数（sin/cos/tan/sqrt/pow/exp/log 等），泛型函数 `T <: FloatingPoint<T>` 通过 `std.math.sin(x)` 委托实现可行。

**[通过]** 单继承、多接口实现、泛型约束等类型系统选择均符合仓颉语言能力。

### 2. 标准库与生态覆盖

**[通过]** `std.math` 覆盖所需全部三角函数、指数函数和取整函数。

**[通过]** `ThreadLocal<T>` 确认来自 `core` 包，`init()`/`get(): Option<T>`/`set(value: Option<T>): Unit` 接口可用，对类型参数 `T` 无 `Send`/`Sync` 约束要求。random.cj 的 ThreadLocal 方案可行。

**[通过]** `std.random.Random` 提供 `nextFloat64()` 和 `nextGaussianFloat64()` 等方法，可支撑 `linearRand`/`gaussRand` 实现。

**[通过]** `DateTime`（来自 `std.time`）提供 `toUnixMillisecond()` 方法，`Thread.currentThread().id` 可用，种子组合策略可行。

**[通过]** `std.math` 不提供 `ldexp`/`frexp` 函数，设计选择自行实现是准确的。

### 3. 语言特性可行性

**[通过]** 函数重载机制确认可用，`mix`/`exp`/`log`/`pow`/`sqrt` 跨包同名符号可通过参数类型自动区分（H6）。

**[通过]** 仓颉浮点类型遵循 IEEE 754，`T(1) / T(0)` 自然返回 ±Inf（H4），支撑 `inversesqrt(0) → +Inf` 及奇异矩阵求逆的 NaN 传播行为。

**[通过]** 仓颉无引用参数，modf/frexp 采用元组返回替代 C 引用参数（D25）的设计可行。

**[一般]** **`std.math.acos`/`asin` 的异常行为与设计声称的 NaN 传播不一致**：

- **位置**：§5 错误处理策略表 "acos 输入超出 [-1,1]" 行（第 709 行）、§3.1 trigonometric.cj 实现路径描述（第 273 行）
- **问题**：设计声称 `acos` 函数 "依赖 `std.math.acos` 的 NaN 传播"、 "由 std.math 自然处理"，但经仓颉标准库文档确认，`std.math.acos` 在输入超出 [-1, 1] 时抛出 `IllegalArgumentException`，而非传播 NaN。同理，`std.math.asin` 也抛出 `IllegalArgumentException`。该假设不成立。
- **影响**：（a）若 `trigonometric.cj` 的 `acos`/`asin` 直接委托 `std.math.acos`/`std.math.asin` 而无保护，则越界输入将抛出异常而非返回 NaN，与 GLM 1.0.3 的行为不一致；（b）slerp 实现中在调用 `acos` 前对 `dot` 结果做 `clamp` 避开了此问题，但设计文档未说明 general `acos`/`asin` 是否需要在 `glm.detail` 层添加 clamp 保护。
- **建议方向**：在 §3.1 trigonometric.cj 实现路径中明确 `acos`/`asin` 的越界处理策略。可选择：方案 A — 在 `glm.detail.acos`/`glm.detail.asin` 中添加输入 clamp 保护（`clamp(x, -T(1), T(1))`）后再委托 `std.math`，确保与 GLM NaN 返回行为一致；方案 B — 使用 try-catch 包装，越界时返回 `T.getNaN()`。任一方案需在 §5 错误处理表中同步修正描述。

**[通过]** 仓颉包组织方式（package/import/public import）支持设计中的三层包结构（glm.detail/glm.ext/glm.gtc），无循环依赖。

### 4. 设计一致性

**[通过]** 前次审查的 6 个问题（P1-P6）已全部得到修正：
- P1（modf/frexp/ldexp 签名缺失）：§3.1 新增签名设计段落，D25 记录决策
- P2（奇异矩阵行为不一致）：三处统一为 IEEE 754 自然决定行为，D26 记录
- P3（mod 约束事实错误）：修正描述为 Integer<T>（当前），标注不兼容变更
- P4（trigonometric 依赖遗漏）：补充 scalar_constants 依赖
- P5（random 种子碰撞风险）：采用时间戳 ^ 线程 ID 组合策略，标注已知风险
- P6（ulp 泛型不可编码）：改为 Float32/Float64 具体类型重载，D27 记录

**[通过]** 前次额外识别的问题也已修正：
- modf 负数公式：从 fract 基值改为 trunc 基值统一公式
- ldexp 声称委托 std.math.ldexp 不存在：改为自行实现 `x * pow(T(2), T(exp))`

**[通过]** 模块间依赖方向合理，无循环依赖。实施批次按拓扑排序。

**[通过]** 各抽象职责描述清晰，协作关系形成闭环。

### 5. 设计质量

**[通过]** 职责划分遵循单一职责原则，core/ext/gtc 分层清晰。

**[通过]** ulp.cj 改为具体类型重载的决策避免了泛型不可编码的问题。

**[通过]** 实施批次建议按拓扑依赖排序，便于有序实现。

**[通过]** 函数库均为纯函数（除 random.cj 外），天然可测试、可并行。

## 修改要求（REJECTED 时存在）

### 问题 1（一般）

- **问题**：§5 错误处理策略表声称 `acos` 输入超出 [-1,1] 时"依赖 `std.math.acos` 的 NaN 传播"，但 `std.math.acos` 实际抛出 `IllegalArgumentException`（当 `x > 1.0` 或 `x < -1.0` 时），不传播 NaN。`asin` 同理。该假设与仓颉标准库实际行为不符。
- **原因**：如果 `glm.detail.acos` 直接委托 `std.math.acos`，越界输入将抛出异常而非返回 NaN，与 GLM 1.0.3 的行为不一致。设计文档描述的 "由 std.math 自然处理" 不成立。
- **建议方向**：在 §3.1 trigonometric.cj 实现路径中补充 `acos`/`asin` 的越界处理策略。推荐方案：在 `glm.detail.acos` 和 `glm.detail.asin` 内部对输入做 `clamp(x, -T(1), T(1))` 后再委托 `std.math`，确保与 GLM 的 NaN 返回行为一致。同步修正 §5 错误处理策略表中的对应描述。
