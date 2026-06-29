根据以下审查结果，迭代上一轮的产出，形成新版的文件，从而更好地满足用户需求。

## 当前审查结果

### P1（严重）— modf/frexp/ldexp 签名设计完全缺失

- **位置**：§3.1 common.cj 职责（第85-88行）
- **问题**：设计文档列出了 modf、frexp、ldexp 三个函数，但全文未给出任何一处在仓颉中的签名设计方案。C/GLM 1.0.3 中 modf(x, &i) 和 frexp(x, &exp) 均使用引用/指针参数输出第二个值，仓颉没有引用参数。现行阶段三 stub 也未包含这三个函数。设计文档未讨论元组返回、封装类型或其他替代方案。
- **影响**：编码阶段无法直接实现——实现者不清楚签名形态。
- **改进建议**：在 §3.1 common.cj 中为 modf/frexp/ldexp 补充仓颉签名设计。建议：modf(x: T): (T, T) 返回 (fractional, integer) 元组；frexp(x: T): (T, Int64) 返回 (mantissa, exponent) 元组；ldexp(x: T, exp: Int64): T 直接委托 std.math.ldexp。

### P2（严重）— 奇异矩阵求逆行为在三处自相矛盾

- **位置**：§3.1 matrix.cj 职责（第310行）、§4.3 核心场景：矩阵行列式与逆（第621行）、§5 错误处理策略表（第679行）
- **问题**：三处对同一行为的描述不一致：（a）"零矩阵或全NaN"、（b）"零矩阵"、（c）"零矩阵或保留未定义值"。此外，GLM 1.0.3 的余子式展开在 det=0 时实际产生 NaN 填充矩阵（因 1/0 → Inf，然后 Inf × cofactor 中的零分量产生 Inf × 0 = NaN，经 IEEE 754 NaN 传播），而非"零矩阵"。
- **影响**：编码阶段实现者将无法确定奇异矩阵的正确行为。
- **改进建议**：统一为与 GLM 1.0.3 一致的行为描述。建议表述："奇异矩阵求逆的结果由 IEEE 754 浮点运算自然决定（1/det → Inf，Inf × 0 → NaN），最终可能产生 NaN 或 Inf 填充的矩阵。函数不抛出异常。调用方需自行通过行列式检查矩阵的奇异性。"

### P3（严重）— mod 约束的当前状态描述与代码事实不符

- **位置**：§3.1 common.cj 约束策略（第239行）、D15（第717行）
- **问题**：设计文档声称 mod 函数"当前约束为 FloatingPoint<T>"，但现有 common.cj 第12行的实际约束是 Integer<T>（func mod<T>(a: T, b: T): T where T <: Integer<T>）。设计文档错误描述了当前状态。此外，D15 中"编码阶段可根据实际需求补充整数版本的重载"也需对应修正。
- **影响**：从 Integer<T> 改为 FloatingPoint<T> 是向后不兼容变更——现有使用整数类型调用 mod 的代码将在阶段四编译报错。该变更未被标注。
- **改进建议**：1. 修正 D15 的"当前约束"描述为 Integer<T>（而非 FloatingPoint<T>）；2. 在 D15 或 §1 中明确标注此变更为向后不兼容（与 D16 对 geometric.cj 的处理一致）；3. 评估现有代码是否在 Integer<T> 约束下调用了 mod，确认退回影响。

### P4（一般）— trigonometric.cj 依赖图中遗漏 scalar_constants.cj

- **位置**：§2 模块间依赖表（第171行）
- **问题**：trigonometric.cj 的 radians(deg) 和 degrees(rad) 使用 pi<T>()（来自同包 scalar_constants.cj），但依赖表中仅列出 std.math + qualifier，缺少 scalar_constants。虽然同包内自动可见，但依赖图的不完整可能误导实现者的批处理顺序判断。
- **改进建议**：在第171行补充 scalar_constants（pi<T>() 函数）。

### P5（一般）— gtc/random.cj 种子初始化竞态风险评估不足

- **位置**：§3.3 random.cj 随机数引擎管理（第523-524行）
- **问题**：设计文档认为"可能因并发得到相同种子值，但后续随机数序列的推进过程天然隔离"。若两个线程在相同毫秒时间戳内同时首次调用 linearRand/gaussRand，二者将获得相同种子，生成完全相同的随机数序列。这在图形渲染的多线程场景（如并行粒子发射器）中将产生视觉上可感知的模式重复。
- **影响**：尽管与 GLM 1.0.3 的行为一致（GLM 也不提供种子控制），但仓颉实现有机会做得更好。
- **改进建议**：在 D19 中补充种子生成策略的增强说明，例如使用 (DateTime.now().toUnixMillisecond() ^ threadId) 作为种子组合，以降低碰撞概率。如确定为已知风险且接受，在 D19 中明确标注"已知的种子碰撞风险，与 GLM 1.0.3 行为一致，当前设计接受此风险"。

### P6（严重）— gtc/ulp.cj 泛型函数在仓颉中缺少实现路径

- **位置**：§3.3 gtc/ulp.cj（第557-566行）、§4（无对应场景）、§7（无对应设计决策）
- **问题**：设计文档为 gtc/ulp.cj 的四个函数定义了 T <: FloatingPoint<T> 泛型约束的签名：next_float/prev_float/float_distance/ulp。这些函数需要操作浮点数的位表示。在 GLM 1.0.3 中，通过 C++ 的 reinterpret_cast 或 memcpy 进行浮点位模式与整数的互转实现。仓颉标准库的 FloatingPoint<T> 接口仅提供有限方法，不提供位级操作能力。Float32.toBits(): UInt32 和 Float32.fromBits(bits: UInt32): Float32 等位操作方法仅存在于具体类型 Float32/Float64 上，不在 FloatingPoint<T> 接口中。因此，以 T <: FloatingPoint<T> 泛型约束声明的 ULP 函数在仓颉中无法通过泛型代码实现。
- **影响**：编码阶段无法按当前签名实现——实现者面临两个选择：要么放弃泛型改用具体类型重载（Float32/Float64 各一份），要么重新设计实现策略。该设计回退未被文档讨论。
- **改进建议**：1. 在 §3.3 ulp.cj 中补充实现路径分析；2. 推荐改为具体类型重载——next_float(x: Float32): Float32 + next_float(x: Float64): Float64，在内部使用 toBits()/fromBits() 操作位模式；3. 新增设计决策条目记录选择理由。

## 历史迭代回顾

### 已解决的问题
第4轮的所有6个问题均在第5轮诊断中再次出现，未有任何问题被解决。

### 持续存在的问题
以下问题从第4轮持续到第5轮，需重点解决：
- modf/frexp/ldexp 签名缺失（P1，严重）— 与第4轮问题1完全一致
- 奇异矩阵行为不一致（P2，严重）— 与第4轮问题2完全一致
- mod 约束事实错误（P3，严重）— 与第4轮问题3完全一致
- trigonometric.cj 依赖图遗漏（P4，一般）— 与第4轮问题4完全一致
- random.cj 种子碰撞风险（P5，一般）— 与第4轮问题5完全一致
- ulp.cj 泛型不可编码（P6，严重）— 与第4轮问题6完全一致

### 新发现的问题
本轮未发现新的质量问题。当前诊断聚焦于第4轮已识别问题的修复情况，确认6个问题均未得到修正。

### 总体评估
第5轮诊断确认第4轮提出的6个问题（P1-P6）仍然全部存在，无任何问题被解决。本轮迭代应集中力量一次性修复所有6个遗留问题。

## 上一轮产出路径
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606291301_phase4_ood\a_v4_design_v1.md

## 用户需求
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606291301_phase4_ood\requirement.md
