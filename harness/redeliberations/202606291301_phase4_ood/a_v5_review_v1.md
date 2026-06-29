# OOD 设计方案审查报告（v5）

## 审查结果

REJECTED

## 逐维度审查

### 1. 类型系统可行性

**[通过]** 包级泛型函数（`T <: FloatingPoint<T>` / `T <: Number<T>` / `T <: Comparable<T>`）的类型形态匹配仓颉类型系统能力，单继承多接口约束模式已在阶段一二三验证

**[通过]** 具体类型重载（ulp.cj 的 Float32/Float64、packing.cj 的 UInt8/UInt16/UInt32/UInt64）正确规避了泛型不可行问题

**[通过]** modf/frexp 采用元组返回替代 C 引用参数，签名设计符合仓颉语言约束

**[通过]** `T(Float64(n))` 字面量构造模式已在阶段三验证

**[一般]** modf 公式在负数情况下不正确 — 设计文档（§3.1 common.cj 第 243 行）给出的公式：`fractional = fract(x)`，`integer = x - fract(x)`（x >= 0）或 `(x - fract(x)) - T(1)`（x < 0）与 C 标准 modf 的向零截断行为不一致。以 x = -3.7 为例：fract(-3.7) = 0.3，按此公式 integer = (-3.7 - 0.3) - 1 = -5.0，fractional = 0.3；而 C modf(-3.7, &i) 期望 integer = -3.0，fractional = -0.7。应改用 `integer = trunc(x)`、`fractional = x - trunc(x)` 的向零截断公式

### 2. 标准库与生态覆盖

**[通过]** std.math 确认提供 Float16/Float32/Float64 三重重载的 sin/cos/tan/exp/log/pow/sqrt 等函数

**[通过]** Float32.toBits(): UInt32、Float32.fromBits(UInt32): Float32 等位操作方法确认存在于具体类型上

**[通过]** std.random.Random 类（含 nextGaussianFloat64 方法）和 ThreadLocal<T>（无 Send 约束）均确认可用

**[一般]** ldexp 声称"直接委托 std.math.ldexp"，但 std.math 不提供 ldexp 函数（经仓颉原始文档搜索确认，无任何匹配）。编码阶段若直接调用 `std.math.ldexp` 将编译报错。建议改为自行实现：`ldexp(x, exp) = x * pow(T(2), T(exp))`

**[轻微]** fma（fused multiply-add）同样不在 std.math 中，但设计未明确声明委托 std.math，仅在函数清单中出现，编码阶段需注意自行实现 `x * y + z`（不含 fused 语义）

### 3. 语言特性可行性

**[通过]** 错误处理策略采用 IEEE 754 NaN/Inf 自然传播，不引入异常，与仓颉错误处理能力匹配

**[通过]** ThreadLocal<Random> 管理随机数引擎的并发方案经仓颉并发编程文档确认可行：ThreadLocal<T> 来自 core 包（无需导入），对类型参数 T 无 Send/Sync 约束

**[通过]** 包结构（glm.detail / glm.ext / glm.gtc / glm）保持阶段一至三体系，与 cjpm 项目组织方式兼容

**[通过]** 函数重载决议（H6）经仓颉语言文档确认支持，基于参数类型自动区分同名函数

### 4. 设计一致性

**[通过]** 前次审查识别的 6 个问题（P1-P6）均在本版设计中被正确修复：
- P1: §3.1 新增 modf/frexp/ldexp 签名设计 + D25
- P2: §3.1/§4.3/§5 奇异矩阵行为统一为 IEEE 754 自然决定 + D26
- P3: mod 约束描述修正为 Integer<T> + D15 更新 + 向后不兼容标注
- P4: trigonometric.cj 依赖图补充 scalar_constants.cj
- P5: random.cj 种子策略增强为时间戳异或线程 ID + 已知风险标注
- P6: ulp.cj 从泛型改为 Float32/Float64 具体类型重载 + D27

**[通过]** 模块间依赖方向清晰（glm.gtc → glm.detail，glm.ext → glm.detail，glm → 聚合），无循环依赖

**[通过]** 实施批次按拓扑依赖排序，批次内可并行编码

### 5. 设计质量

**[通过]** 职责划分遵循单一职责原则，每个 .cj 文件对应一组密切相关的函数族

**[通过]** 抽象层次恰当：泛型函数 + 具体类型重载的分层覆盖了 GLM 的函数族结构

**[通过]** 设计便于测试：纯函数（除 random.cj）无副作用，输入输出关系明确

**[通过]** 增量追加 lib.cj public import 策略最小化了对已有消费代码的影响

## 修改要求（REJECTED）

### 问题 1：modf 公式在负数情况下不正确

- **问题**：§3.1 common.cj 第 243 行的 modf 公式使用 `fract(x)`（`x - floor(x)`）计算小数部分，然后对负数做 `(x - fract(x)) - T(1)` 修正。该公式与 C 标准 modf 的向零截断行为不一致。例如 x = -3.7 时：fract(-3.7) = 0.3，按公式 integer = -5.0；而 C modf 期望 integer = -3.0、fractional = -0.7
- **原因**：实现者按此公式编码将产生错误的负数 modf 结果，与 GLM 1.0.3 行为不一致
- **建议方向**：将公式修正为向零截断：`integer = trunc(x)`（通过 monomorphization 委托 std.math.trunc），`fractional = x - integer`。或采用位操作路径（对具体类型 Float32/Float64 使用 toBits/fromBits 提取指数和尾数）

### 问题 2：ldexp 声称直接委托 std.math.ldexp 但该函数不存在

- **问题**：§3.1 common.cj 第 245 行称"std.math 已提供 ldexp 函数，标量版本直接转发"，但经仓颉原始文档验证，std.math **不提供** ldexp 函数（全文搜索 0 匹配）
- **原因**：编码阶段直接调用 `std.math.ldexp` 将产生编译错误
- **建议方向**：删除"直接委托 std.math.ldexp"的描述，改为自行实现：`ldexp<T>(x: T, exp: Int64): T where T <: FloatingPoint<T>` = `x * pow(T(2), T(exp))`。或对具体类型 Float32/Float64 使用位操作（提取指数 + exp 偏移后重新组合）
