# OOD 设计方案审查报告（v5）

## 审查结果

APPROVED

## 逐维度审查

### 1. 类型系统可行性

**[通过]** 设计中所有类型形态选择（包级泛型函数、具体类型重载、元组返回、interface 约束）均与仓颉类型系统能力匹配。

- 泛型约束使用 `Number<T>`、`FloatingPoint<T>`、`Comparable<T>`、`Integer<T>` 均在仓颉标准库 interface 范围内
- 单继承 + 多接口实现的约束正常——设计不涉及 class 继承树，仅使用 interface 作为泛型约束
- `modf`/`frexp` 使用元组 `(T, T)`/`(T, Int64)` 返回替代 C 引用参数输出，仓颉无引用参数，元组返回是类型安全且可行的替代方案
- `gtc/ulp.cj` 已从泛型改为具体类型重载 `Float32`/`Float64`，经查验 `FloatingPoint<T>` 接口确实不提供 `toBits()`/`fromBits()` 方法（接口仅有 `getE/getInf/getPI/getMinDenormal/getMinNormal/getNaN/isInf/isNaN/isNormal`），这些位操作方法仅存在于 `Float32`/`Float64`/`Float16` 的具体类型扩展上，因此泛型方案不可行。当前设计方向正确
- `gtc/packing.cj` 使用具体类型重载同样正确——包解包涉及特定类型的位模式转换，不适合泛型化
- `acos`/`asin` 的 NaN 保护中使用 `T.getNaN()`——经确认 `FloatingPoint<T>` 接口提供 `static func getNaN(): T`，方案可行

**[轻微]** `seed = DateTime.now().toUnixMillisecond() ^ Thread.currentThread().id` 中的 `toUnixMillisecond()` API 名称需确认（DateTime 文档未显式列出此方法名，但有返回 Duration 的 UnixEpoch 差值方法）；`Thread.currentThread` 为静态属性（`static prop currentThread: Thread`），应写作 `Thread.currentThread.id` 而非 `Thread.currentThread().id`。均属实现期可自然纠正的 API 细节，不影响设计可行性。

### 2. 标准库与生态覆盖

**[通过]** 设计中使用的能力均在仓颉标准库覆盖范围内：

- `std.math` 提供 `Float16/Float32/Float64` 三重重载的 `pow/exp/log/exp2/log2/sqrt/sin/cos/tan/asin/acos/atan/atan2/sinh/cosh/tanh/asinh/acosh/atanh`——已确认重载覆盖
- `std.math.acos`/`std.math.asin` 在输入超出 `[-1, 1]` 时抛出 `IllegalArgumentException`——已从原始文档确认（`math_package_funcs.md` 中 `acos(Float16/Float32/Float64)` 均注明了此行为）。设计中的 NaN 保护方案（前置检查后返回 `T.getNaN()`）正确
- `Float32.toBits(): UInt32`、`Float32.fromBits(bits: UInt32): Float32` 等位操作方法——已从 `core_package_intrinsics.md` 确认存在，且仅作为具体类型扩展（`extend Float16/32/64`），不在 `FloatingPoint<T>` 接口中
- `std.random.Random` 提供 `Random(UInt64)` 种子构造函数和 `nextGaussianFloat64(mean!, sigma!)`——已确认
- `core.ThreadLocal<T>` 不要求 `T <: Send`——已从并发编程文档确认（`public class ThreadLocal<T> { init(); get(): Option<T>; set(value: Option<T>): Unit }`）
- 备选方案 `Mutex<Random>` 已在文档中标注，`Mutex` 可用性已确认

### 3. 语言特性可行性

**[通过]** 设计的语言特性使用在仓颉中均可实现：

- 错误处理策略采用 IEEE 754 自然浮点运算结果（NaN/Inf 传播），不抛出异常——仓颉浮点类型遵循 IEEE 754 标准，`T(1)/T(0)` 返回 `±Inf` 而非抛出异常（该异常仅适用于整数除零），与设计假设 H4 一致
- `acos`/`asin` 的 NaN 保护采用前置条件检查后手动返回 NaN——仓颉支持此模式
- 并发设计使用 `ThreadLocal<Random>` 隔离每个线程的随机数引擎——`ThreadLocal<T>` 从 `core` 包自动可用，无 Send 约束
- 包设计遵循 `glm.detail` / `glm.ext` / `glm.gtc` / `glm` 的四层结构，与 cjpm 项目组织方式一致
- 函数重载（`mix`/`exp`/`log`/`pow`/`sqrt` 的跨包同名符号）——仓颉支持基于参数类型的重载决议（H6 已验证），后备方案（显式限定名转发函数）也已准备

### 4. 设计一致性

**[通过]** 各抽象的职责描述清晰，协作关系形成闭环：

- **P1（modf/frexp/ldexp 签名缺失）**：已在 §3.1 common.cj 中完整定义了三个函数的仓颉签名（`modf<T>(x: T): (T, T)`、`frexp<T>(x: T): (T, Int64)`、`ldexp<T>(x: T, exp: Int64): T`），均附约束、实现路径和语义说明。**已解决**
- **P2（奇异矩阵求逆行为自相矛盾）**：§3.1 matrix.cj（第318行）、§4.3（第631行）、§5（第689行）三处描述已统一为"IEEE 754 浮点运算自然决定，NaN/Inf 填充，不抛异常"。D26 条目记录此决策。**已解决**
- **P3（mod 约束当前状态描述与代码事实不符）**：§3.1 common.cj（第239行）已修正为 `Integer<T>`（当前实际约束）；D15 条目同步修正。**已解决**
- **P4（trigonometric.cj 依赖图中遗漏 scalar_constants.cj）**：§2 依赖表（第171行）已补充 `scalar_constants`。**已解决**
- **P5（gtc/random.cj 种子初始化竞态风险评估不足）**：§3.3 random.cj（第531行）种子策略已改进为 `DateTime.now().toUnixMillisecond() ^ Thread.currentThread().id` 组合策略；D28 条目明确标注接受碰撞风险。**已解决**
- **P6（gtc/ulp.cj 泛型函数在仓颉中缺少实现路径）**：§3.3 ulp.cj（第570-576行）已改为 Float32/Float64 具体类型重载，附实现路径（`toBits()/fromBits()` 位模式操作）和设计理由；D27 条目记录此决策。**已解决**
- 所有模块间依赖方向为单向：`glm.gtc → glm.detail`、`glm.ext → glm.detail`、`glm → glm.detail/gtc/ext`，无循环依赖

### 5. 设计质量

**[通过]** 职责划分清晰，抽象层次恰当，便于后续详细设计、实现和测试：

- 每个文件承担明确的 GLSL 函数族角色，职责边界清晰
- 抽象层次定位为架构级设计——不包含完整实现细节（如具体方法签名内的完整参数列表），属于设计阶段的正常粒度。未因缺少实现细节而被驳回
- 设计便于单元测试：core/ext/gtc 函数库（除 random.cj 外）均为纯函数，输入决定输出，天然可测试、可 mock、可隔离
- random.cj 的可变状态已明确标注为例外（§6 并发设计中的例外声明），`ThreadLocal<Random>` 隔离策略确保每个线程有独立引擎，测试中可注入确定性种子
- 实施批次按拓扑依赖分为四批，每批内可并行，编码路径清晰

## 修改要求

本审查无严重或一般问题阻塞通过。以上标记为「轻微」的问题（`toUnixMillisecond()` API 名称确认、`Thread.currentThread.id` 语法纠正）属于实现期可自然处理的范围，不影响设计可行性或质量。

APPROVED
