根据以下审查结果，迭代上一轮的产出，形成新版的文件，从而更好地满足用户需求。

## 当前审查结果

### 严重问题

**P1. lib.cj 中 translate/rotate/scale/shear/lookAt/lookAtRH/lookAtLH 跨包重复导入冲突未解决**
- 所在位置：第909–910行（§8 lib.cj 更新）、现有 lib.cj 第23行
- 严重程度：严重
- 改进建议：明确选型并执行以下任一方案：
  - **推荐方案**：修改现有 lib.cj 第23行，删除 translate/rotate/scale/shear/lookAt/lookAtRH/lookAtLH 的 gtc import；§8 lib.cj 更新中从 ext 导入这些符号。gtc 层内部通过 public import 从 ext 转发。
  - **备选方案**：保持 lib.cj 第23行不变，§8 lib.cj 更新中不导入这些符号，改为从 gtc 统一提供。gtc 层可直接提供实现，不依赖 ext。
  - 无论选择哪一方案，均需在 D23 或新增设计决策中记录选型理由和验证结果。

**P2. frexp 零值/NaN/Inf/非规范化数边缘场景实现策略缺失**
- 所在位置：第248行（§3.1 common.cj）
- 严重程度：严重
- 改进建议：以下方案至少选择其一：
  1. 数学分解加前置检查：if x.isNaN() → (T.getNaN(), 0)、if x.isInf() → (x, 0)、if x == T(0) → (T(0), 0)，合法值使用 exponent = floor(log2(abs(x))) + mantissa = x / pow(T(2), T(exponent))。注意非规范化数场景的精度损失需标记为已知行为差异。
  2. 具体类型重载：为 Float32/Float64 各提供基于 toBits() 的位操作实现，标量版本委托 shim，类似 D27（ulp.cj）的处理方式。
  3. 在 D25 中补充策略选型理由，并新增关于非规范化数的行为声明。

### 一般问题

**G1. ext/quaternion_common.cj 依赖链遗漏 glm.detail.common**
- 所在位置：第187行（§2 模块间依赖表）
- 严重程度：一般
- 改进建议：在第187行依赖链中补充 glm.detail.common，例如 → glm.detail.trigonometric + glm.detail.geometric + glm.detail.common + ext/scalar_constants。

**G2. gtc/noise.cj 缺少完整函数签名**
- 所在位置：第610–615行（§3.3 gtc/noise.cj）
- 严重程度：一般
- 改进建议：为每个函数补充完整签名，格式参考 packing.cj 的代码块样式：
  - perlin1D<T, Q>(x: T): T where T <: FloatingPoint<T>, Q <: Qualifier
  - perlin2D<T, Q>(v: Vec2<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier
  - simplex1D<T, Q>(x: T): T where T <: FloatingPoint<T>, Q <: Qualifier
  - simplex2D<T, Q>(v: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
  根据 GLM 1.0.3 gtc/noise.inl 确认每个函数的具体返回类型（Perlin 系列返回标量 T，Simplex 1D 返回标量 T，Simplex 2D/3D/4D 返回对应向量）。

**G3. ext/scalar_common.cj 的 iround/uround 负数输入行为偏离 GLM 且差异仅以行内注释记录**
- 所在位置：第362–364行（§3.2 ext/scalar_common.cj）
- 严重程度：一般
- 改进建议：
  - 方案 A（推荐）：改用 Int64(round(x)) 公式（委托 std.math.roundT 通过 shim），消除负数语义偏差，与 GLM 行为一致。
  - 方案 B：若因性能或其他原因保留当前公式，必须在 D24 或新增设计决策条目中记录此行为偏差，说明与 GLM 的差异、约束范围和已知后果。同时在函数签名前增加 @pre(input >= T(0)) 或等效文档注释。

**G4. stdmath_shim.cj 在 Float16 上的溢出行为差异未记录**
- 所在位置：第50行（§1.4 stdmath_shim.cj 模式）、第837行（D29）
- 严重程度：一般
- 改进建议：在 §1.4 或 D29 中补充以下内容之一：
  - 标注已知行为差异：(result as T).getOrThrow() 在 T = Float16 且中间值超过 ±65504 时，与 GLM 的 ±Inf 返回行为不同。建议编码阶段为 stdmath_shim.cj 添加 Float16 溢出保护：if result > Float16.MAX → T.getInf()。
  - 或声明本设计接受此差异（因 Float16 主要用于低精度图形场景，溢出概率极低），并在偏差文档中记录。

**G5. mod 函数标量浮点重载的设计决策仍为"编码阶段可选"，留下不确定性**
- 所在位置：第244行（§3.1 common.cj）、第823行（D15）
- 严重程度：一般
- 改进建议：在 D15 中将标量浮点 mod 重载由"可选"升级为"推荐实现"，并明确参数类型和约束（3 个具体类型重载：Float32, Float64, Float16），使 GLSL 的 mod(float, float) 调用可直接编译。

## 历史迭代回顾

### 已解决的问题（出现在历史反馈但当前反馈中不再提及的问题）
- Vec1 normalize 零输入行为矛盾（第3轮问题1，第6轮问题4）— 已修复，当前反馈无相关问题
- inversesqrt(0) 零值行为依赖 CangJie IEEE 754 合规性（第2轮问题1，第3轮问题2）— 已修复，当前反馈无相关问题
- geometric.cj 约束收紧未标记向后不兼容变更（第1轮问题7）— 已修复
- random.cj 种子初始化竞态风险（第3轮问题5，第4轮问题5）— 已修复
- gtc/packing.cj 缺少完整签名（第3轮问题4）— 已修复，当前无相关问题
- trigonometric.cj 依赖图遗漏 scalar_constants（第4轮问题4）— 已修复
- gtc/ulp.cj 泛型不可编码（第4轮问题6）— 已修复
- ext/scalar_common.cj 职责描述与 GLM 不符（第5轮问题1）— 已修复
- ext/vector_common.cj 缺乏完整清单（第5轮问题2）— 已修复
- ext/matrix_clip_space.cj ortho 计数不符（第5轮问题3）— 已修复
- gtc/matrix_transform.cj 计数自相矛盾（第5轮问题4）— 已修复
- lib.cj 导出遗漏几何/determinant/inverse 函数（第6轮问题1、2）— 已修复
- ext/matrix_projection.cj 计数不一致（第6轮问题3）— 已修复
- slerp 退化条件阈值未定义（第6轮问题6）— 已修复
- acos clamp 矛盾（第1轮问题2）— 已修复
- gtc/type_precision.cj 别名范围（第1轮问题3）— 已修复
- 引用未定义 Common<T> 约束（第1轮问题4）— 已修复

### 持续存在的问题（在多轮反馈中反复出现的问题，需重点解决）
- **P1（lib.cj 跨包导入冲突）**：第2轮问题4 → 第3轮问题3 → 第7轮问题1 → 第8轮问题1 → 第9轮 P1。已持续 5 轮未解决，编译阻塞风险最高，**本轮必须解决**。
- **P2（frexp 边缘场景策略缺失）**：第4轮问题1 → 第7轮问题2 → 第8轮问题2 → 第9轮 P2。已持续 4 轮未解决，严重程度高，编码不可行动。
- **G1（quaternion_common.cj 依赖链遗漏）**：第7轮问题3 → 第8轮问题3 → 第9轮 G1。持续 3 轮未修正，修复成本低，建议本轮一并修复。
- **G2（noise.cj 缺少完整签名）**：第3轮问题4 → 第7轮问题4 → 第8轮问题4 → 第9轮 G2。持续 4 轮未解决。
- **G4（Float16 溢出差异未记录）**：第7轮问题5 → 第8轮问题6 → 第9轮 G4。持续 3 轮未处理。
- **G5（mod 浮点重载可选）**：第1轮问题6 → 第6轮问题7 → 第8轮问题7 → 第9轮 G5。持续多轮未明确。

### 新发现的问题（本轮新识别的问题）
- **G3（iround/uround 负数行为偏离 GLM）**：第8轮问题5已指出但记录不充分，本轮从 G3 角度继续推进。非全新问题，建议本轮修复。

## 上一轮产出路径
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606291301_phase4_ood\a_v8_copy_from_v7.md

## 用户需求
C:\Develop\Software\cjglm_wp\harness\redeliberations\202606291301_phase4_ood\requirement.md
