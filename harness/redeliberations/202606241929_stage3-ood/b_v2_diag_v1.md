# 阶段三 OOD 设计方案审查诊断报告（v2 第 2 轮）

> **审查对象**：`a_v2_design_v3.md`（v3 设计方案）
> **审查定位**：第 2 轮审查，依据 a_v2_review_v3.md 已确认技术可行性、类型系统、并发、依赖方向等内部审议已覆盖维度。本轮审查侧重**需求响应充分度、整体深度与完整性、事实正确性、跨文档一致性、对下游消费者与编码实施的可用性**等内部审议未充分覆盖的维度。

---

## 审查总结

v3 设计整体上较为系统地响应了上一轮 19 项问题中的关键修复，特别是**包间循环依赖**（v3 关键决策 D11/D28）、`Quat×Vec3` 旋转公式修正（D26）、`gtc/quaternion.cj` 完整规划、依赖关系细化（pow/mix/slerp 增补 `epsilon<T>()`）、const 上下文约束说明、测试设计 §8.2 新增、跨文档一致性等。但本轮审查仍识别出 **2 项严重问题 + 8 项一般问题 + 4 项轻微问题**，主要集中在：(a) GLM 实际行为的核实不充分（`axis()` 函数边界契约）；(b) 多处依赖关系仍然缺失（`pow`/`log`/`exp`/`slerp` 4 参数版遗漏 `epsilon<T>()`/`pi<T>()`/`cos_one_over_two<T>()`/`asin` 等关键依赖）；(c) v3 设计文档与路线图 `02_roadmap.md` 在 stage 3 验证标准上存在明显不一致（slerp 可验证性、`lookRotate` 命名修正同步、stub 函数分类）。

---

## 严重问题

### 问题 1（严重）——`axis()` 函数边界行为契约与 GLM 1.0.3 实际行为不符

- **问题描述**：v3 设计 §3.9 在描述 `axis(x: Quat<T,Q>): Vec3<T,Q>` 函数时，声明「**边界行为（v3 新增契约）**：零四元数输入（q.x == q.y == q.z == 0）时，内部 `normalize(Vec3(0, 0, 0))` 返回 `Vec3(T(1), T(0), T(0))`（沿用 `quaternion_geometric.cj.normalize` 零向量保护行为，与 GLM `quaternion_geometric.inl:20-21` 一致）」。这一边界行为契约与 GLM 1.0.3 实际 `axis` 实现不符，且与 §3.9 同段前半部分「依赖 `sqrt`（std.math 提供）和 T(1) 演算，可完整实现」的描述自相矛盾。三处不一致：

  1. **实现策略错误**：GLM `ext/quaternion_trigonometric.inl:20-27` 的 `axis` 实际使用独立公式（`tmp1 = 1 - x.w * x.w`），不调用 `normalize(Vec3(q.x, q.y, q.z))`：
     ```cpp
     T const tmp1 = static_cast<T>(1) - x.w * x.w;
     if(tmp1 <= static_cast<T>(0))
         return vec<3, T, Q>(0, 0, 1);
     T const tmp2 = static_cast<T>(1) / sqrt(tmp1);
     return vec<3, T, Q>(x.x * tmp2, x.y * tmp2, x.z * tmp2);
     ```
     设计文档描述的「内部 `normalize(Vec3(0, 0, 0))`」是虚构实现，GLM 源码不存在该调用。

  2. **返回值错误**：v3 设计声称零四元数时返回 `Vec3(T(1), T(0), T(0))`。GLM 在 `(x, y, z, w) = (0, 0, 0, 0)` 时 `tmp1 = 1 - 0 = 1 > 0`，执行 else 分支返回 `Vec3(0, 0, 0)`；触发 `Vec3(0, 0, 1)` 的条件是 `1 - x.w*x.w <= 0`（即 `|w| >= 1`，典型场景为单位四元数 `(0, 0, 0, 1)`），而非 `q.x == q.y == q.z == 0`。

  3. **引用行号错误**：v3 设计引用 `quaternion_geometric.inl:20-21` 作为行为依据，但该行号属于 `ext/quaternion_geometric.inl` 的 `normalize` 函数（不是 `axis` 函数）。`axis` 函数的 GLM 实际位置为 `ext/quaternion_trigonometric.inl:20-27`。

  此外，若按 v3 设计描述采用 `normalize(Vec3(...))` 实现，则依赖 `geometric.cj` 的向量 `normalize`（阶段三为 stub），与同段「**可完整实现**」声明矛盾——意味着该函数本应归入 stub 占位列表，而非 §8 完整实现产出物清单。

- **所在位置**：§3.9 `axis` 函数描述（第 399 行附近）、§5.3 边界条件表「`axis(q)` 零四元数」行、§9 差异声明「`axis` 零四元数返回 `Vec3(1, 0, 0)`」条目、§10 覆盖矩阵 `quaternion_trigonometric.hpp` 表 `axis` 行
- **严重程度**：严重
- **改进建议**：
  1. §3.9 修订为准确描述 GLM 实现：「`axis(x)` 计算 `tmp1 = 1 - x.w*x.w`；若 `tmp1 <= 0` 返回 `Vec3(0, 0, 1)`（z 轴）；否则 `tmp2 = 1 / sqrt(tmp1)`，返回 `Vec3(x.x*tmp2, x.y*tmp2, x.z*tmp2)`」
  2. §5.3 修订「`axis(q)` 零四元数」行为契约：「`1 - x.w*x.w <= 0` 时（典型：单位四元数 (0, 0, 0, 1)），返回 `Vec3(0, 0, 1)`；对于真正的零四元数 (0, 0, 0, 0)，返回 `Vec3(0, 0, 0)`」
  3. §9 差异声明的对应条目修订为「`axis` 触发条件为 `1 - w² <= 0` 而非 q.xyz == 0，返回 `Vec3(0, 0, 1)`（与 GLM `quaternion_trigonometric.inl:20-27` 一致）」
  4. §10 覆盖矩阵 `axis` 行的边界行为标注同步修订

---

### 问题 2（严重）——`pow` 函数依赖关系不完整，行号引用错误

- **问题描述**：v3 设计 §3.10（行 414）将 `pow(x: Quat<T,Q>, y: T): Quat<T,Q>` 的依赖标注为「依赖 `abs`/`clamp`/`acos`/`sin`/`cos`/`sqrt`（其中 `abs`/`clamp` 来自 common.cj stub，`acos`/`sin`/`cos` 来自 trigonometric.cj stub，`sqrt` 来自 std.math）+ `epsilon<T>()`（scalar_constants.cj 已实现）」。但 GLM `ext/quaternion_exponential.inl:41-80` 实际 `pow` 实现包含以下 v3 设计遗漏的依赖：

  1. **`cos_one_over_two<T>()`**（line 52：`if(abs(x.w / magnitude) > cos_one_over_two<T>())`）—— 来自 `scalar_constants.cj`，v3 设计遗漏
  2. **`asin`**（line 68：`Angle = asin(sqrt(VectorMagnitude) / magnitude)`）—— 来自 `trigonometric.cj` stub，v3 设计遗漏
  3. **递归调用 `pow`（实数版本）**（line 65：`return qua<T, Q>::wxyz(pow(x.w, y), 0, 0, 0)`）—— 实际是 `std.math.pow(T, T)`，与四元数 `pow` 不同；v3 设计未明确区分四元数 `pow` 与 `std.math.pow`
  4. **`std::numeric_limits<T>::min()`**（line 63：`if (VectorMagnitude < (std::numeric_limits<T>::min)())`）—— 用于次正规数边界判断；仓颉版本如何获取浮点类型最小正值（对应 `std::numeric_limits<T>::min()` 或 `denorm_min()`）未在 v3 设计中讨论

  同时 v3 设计 §3.10 引用「GLM `ext/quaternion_exponential.inl:24-43` 实际实现为准」行号错误：GLM 文件中 `pow` 函数实际位于 line 41-80，line 24-43 范围实际跨越 `log` 函数尾部 + `pow` 函数开头，并非 `pow` 完整实现。

- **所在位置**：§3.10 `pow` 依赖描述、D21 设计决策、§10 覆盖矩阵 `quaternion_exponential.hpp` 表 `pow` 行
- **严重程度**：严重
- **改进建议**：
  1. §3.10 `pow` 依赖修订为「依赖 `epsilon<T>()`/`abs`/`clamp`/`asin`/`acos`/`sin`/`cos`/`sqrt`（其中 `epsilon<T>()` 来自 scalar_constants.cj，`abs`/`clamp` 来自 common.cj stub，`asin`/`acos`/`sin`/`cos` 来自 trigonometric.cj stub，`sqrt` 来自 std.math）+ 递归调用 `std.math.pow(T, T)`（line 65 实数版本降级路径）+ `std::numeric_limits<T>::min()` 等价的仓颉次正规数边界检查」
  2. §3.10 行号引用从 `quaternion_exponential.inl:24-43` 修订为 `quaternion_exponential.inl:41-80`
  3. D21 设计决策的「pow 依赖明确包含 `epsilon<T>>`」补充为「同时依赖 `cos_one_over_two<T>()`、`asin`、递归调用 `std.math.pow`」
  4. §8 编码启动前验证项新增「`pow` 函数在四元数 `pow` 与 `std.math.pow` 命名消歧验证」+「次正规数边界检查所需 `T <: FloatingPointNumber<T>` 类型属性的仓颉等价物验证」

---

## 一般问题

### 问题 3（一般）——`log` 函数依赖关系遗漏 `epsilon<T>()`/`pi<T>()` 与 `std::numeric_limits<T>::infinity()`

- **问题描述**：v3 设计 §3.10（行 413）将 `log(q: Quat<T,Q>): Quat<T,Q>` 的依赖标注为「依赖 `length`、`atan`、`log`（trigonometric.cj/exponential.cj 接口）」。但 GLM `ext/quaternion_exponential.inl:18-38` 实际 `log` 实现包含 v3 设计遗漏的依赖：

  1. **`epsilon<T>()`**（line 23：`if (Vec3Len < epsilon<T>())`）—— 来自 `scalar_constants.cj`，v3 设计遗漏
  2. **`pi<T>()`**（line 28：`return qua<T, Q>::wxyz(log(-q.w), pi<T>(), ...)`）—— 来自 `scalar_constants.cj`，v3 设计遗漏
  3. **`std::numeric_limits<T>::infinity()`**（line 30：`return qua<T, Q>::wxyz(std::numeric_limits<T>::infinity(), ...)`）—— 用于 w=0 的退化分支；仓颉 `FloatingPointNumber<T>` 接口是否提供此属性未在 v3 设计中说明

- **所在位置**：§3.10 `log` 依赖描述、§10 覆盖矩阵 `quaternion_exponential.hpp` 表 `log` 行
- **严重程度**：一般
- **改进建议**：§3.10 `log` 依赖修订为「依赖 `length`/`epsilon<T>()`/`pi<T>()`/`atan`/`log`（其中 `epsilon<T>()`/`pi<T>()` 来自 scalar_constants.cj，`atan`/`log` 来自 trigonometric.cj/exponential.cj 接口，`length` 来自 quaternion_geometric.cj）。仓颉版本需明确 `std::numeric_limits<T>::infinity()` 的等价处理策略（建议：若仓颉浮点类型支持 `getInf()` 实例方法则直接调用，否则通过 `T(1)/T(0)` 显式构造）」

---

### 问题 4（一般）——`exp` 函数依赖关系遗漏 `epsilon<T>()`

- **问题描述**：v3 设计 §3.10（行 412）将 `exp(q: Quat<T,Q>): Quat<T,Q>` 的依赖标注为「依赖 `length`（quaternion_geometric，已实现）、`cos`/`sin`（trigonometric.cj stub）」。GLM `ext/quaternion_exponential.inl:6-15` 实际 `exp` 实现在 line 10 使用 `epsilon<T>()`：`if (Angle < epsilon<T>())`，v3 设计遗漏此依赖。

- **所在位置**：§3.10 `exp` 依赖描述、§10 覆盖矩阵 `quaternion_exponential.hpp` 表 `exp` 行
- **严重程度**：一般
- **改进建议**：§3.10 `exp` 依赖修订为「依赖 `length`/`epsilon<T>()`/`cos`/`sin`（其中 `epsilon<T>()` 来自 scalar_constants.cj，`cos`/`sin` 来自 trigonometric.cj stub，`length` 来自 quaternion_geometric.cj）」

---

### 问题 5（一般）——`slerp` 4 参数版本依赖关系遗漏 `pi<T>()`

- **问题描述**：v3 设计 §3.11（行 432）将 `slerp<T, Q>(x: Quat<T,Q>, y: Quat<T,Q>, a: T, k: Int64)` 的依赖标注为「多旋转 slerp。**stub 占位**」。GLM `ext/quaternion_common.inl:75-110` 实际 4 参数 `slerp` 实现包含 v3 设计遗漏的关键依赖：

  1. **`pi<T>()`**（line 107：`T phi = angle + static_cast<T>(k) * glm::pi<T>();`）—— 来自 `scalar_constants.cj`，v3 设计遗漏
  2. **`mix`**（line 98-101：`mix(x.w, z.w, a)` 等四次标量 `mix` 调用）—— 来自 `common.cj`/`exponential.cj` 接口

  v3 设计仅说明 D22 决策（`k: Int64` 简化签名），但未列出 4 参数版本的完整依赖清单，编码阶段可能误判该函数的 stub 实现只需 `acos`/`sin`/`mix` 即可。

- **所在位置**：§3.11 `slerp` 4 参数版本描述、D22 设计决策
- **严重程度**：一般
- **改进建议**：§3.11 `slerp` 4 参数版本依赖补充「依赖 `dot`/`acos`/`sin`/`mix`（标量版）/`epsilon<T>()`/`pi<T>()`，其中 `acos`/`sin` 来自 trigonometric.cj stub，`mix`/`abs` 来自 common.cj stub，`epsilon<T>()`/`pi<T>()` 来自 scalar_constants.cj」

---

### 问题 6（一般）——§3.9 `axis` 函数依赖描述自相矛盾

- **问题描述**：§3.9 在同一段中对 `axis(x: Quat<T,Q>): Vec3<T,Q>` 函数给出相互矛盾的依赖描述：前半部声明「依赖 `sqrt`（std.math 提供）和 T(1) 演算。**可完整实现**」，后半部描述边界行为时引用「内部 `normalize(Vec3(0, 0, 0))`」依赖 `geometric.cj` 的向量 `normalize`（阶段三为 stub）。两段描述对应不同的实现策略，前者对应 GLM 实际公式 `tmp1 = 1 - x.w*x.w` 路径，后者对应 GLM 未采用的 `normalize` 路径。修复者无法判断实际实现应采用哪种策略。

- **所在位置**：§3.9 `axis` 函数描述（第 399 行附近）
- **严重程度**：一般
- **改进建议**：在采纳问题 1 修复方案后，§3.9 `axis` 函数描述统一为「实现公式：`tmp1 = 1 - x.w * x.w`；若 `tmp1 <= 0` 返回 `Vec3(T(0), T(0), T(1))`；否则 `tmp2 = T(1) / sqrt(tmp1)`，返回 `Vec3(x.x*tmp2, x.y*tmp2, x.z*tmp2)`（与 GLM `ext/quaternion_trigonometric.inl:20-27` 一致）。依赖仅 `std.math.sqrt` 和 T(1) 演算（通过 `x.w*x.w` 取得），**可完整实现**」。删除「内部 `normalize(Vec3(0, 0, 0))`」的错误描述

---

### 问题 7（一般）——路线图 `02_roadmap.md` 与 v3 设计在阶段三验证标准上存在多处不一致

- **问题描述**：v3 设计未与项目路线图 `docs/02_roadmap.md` 同步，存在以下不一致：

  1. **`slerp` 可验证性冲突**：路线图 §3 验证标准第 125 行明确标记「球面线性插值（slerp）操作 `[可验证]`」，但 v3 设计 §3.11、§8 产出物清单、§10 覆盖矩阵、§11.5 函数可用性对照表均将 `slerp`（含 3 参数与 4 参数版本）标记为「**stub 占位**」。路线图隐含假设 slerp 在阶段三完整实现，但 v3 设计因 `acos`/`sin` 依赖 `trigonometric.cj` stub 而将 slerp 降级为 stub，两者不一致。修复者若按 v3 设计实现 slerp stub，则路线图 `[可验证]` 标注需修订；若按路线图要求完整实现，则 v3 设计需引入 `trigonometric.cj` 最小子集（如仅 `sin`/`acos`）的完整实现
  2. **`lookRotate` 命名未同步修正**：路线图 §3 多处（第 89、102、111、129、152、163、207 行）仍引用 `lookRotate` 函数名，但 v3 设计已将此函数统一修正为 `quatLookAt`/`quatLookAtRH`/`quatLookAtLH`（D13 决策 + §9 差异声明「GLM 中不存在 `lookRotate` 函数」）。路线图未同步更新，编码阶段可能依据路线图错误命名
  3. **`ext/quaternion_common.cj` 可验证性范围不一致**：路线图 §3 第 130 行标记「`ext/quaternion_common.cj`：四元数常用函数（`conjugate`、`inverse`、`normalize` 等跨类型运算）`[可验证]`」，但 v3 设计 §3.11 + §8 明确 `mix`/`slerp`/`slerp(k)` 3 个函数为 stub。路线图「可验证」表述涵盖面过广，未明确标注 `mix`/`slerp` 属于「[待 Stage 4]」类别

- **所在位置**：v3 设计 §3.11、§8、§10、§11.5；路线图 `docs/02_roadmap.md` 第 89、102、111、125、129、130、152、163、207 行
- **严重程度**：一般
- **改进建议**：
  1. v3 设计 §3.11 / §8 / §11.5 明确声明「`slerp` 函数本阶段 stub 是设计相对路线图的合理偏差」，并新增「路线图同步修订建议」段落，说明 `02_roadmap.md` 第 125 行需修订为「球面线性插值（slerp）操作 `[待 Stage 4，依赖 trigonometric.cj 完整实现]`」
  2. v3 设计 §3.15 + §9 增补「路线图 `lookRotate` 命名同步修订建议」段落，说明 `02_roadmap.md` 第 89、102、111、129、152、163、207 行需将 `lookRotate` 修订为 `quatLookAt`/`quatLookAtRH`/`quatLookAtLH`
  3. 路线图修订或 v3 设计新增「路线图阶段三验证标准差异说明」附录，统一路线图与 v3 设计的可验证性标注口径（建议采用路线图 `[可验证]`/`[部分可验证]`/`[待 Stage 4]` 三级分类与 v3 设计 `✅`/`⚠️`/`❌` 符号的双向映射表）

---

### 问题 8（一般）——§3.15 `gtc/quaternion.cj` 表格欧拉角行「完整实现」与「改为 stub 占位」表述冲突

- **问题描述**：v3 设计 §3.15 表格（第 507 行）欧拉角函数组描述单元格同时给出「**完整实现**（v3 修正）」与「**改为 stub 占位**（v3 最终决策）」两个相互矛盾的标注。虽然整体段落末尾的「v3 修订说明」指出最终决策是 stub，但表格单元格的并列表述（特别是首部「**完整实现**（v3 修正）」粗体强调）易使快速浏览者误判为完整实现。属于轻微表述瑕疵，但因涉及关键决策状态描述，可能影响下游实施者判断。

- **所在位置**：§3.15 `gtc/quaternion.cj` 表格欧拉角函数组行（第 507 行）
- **严重程度**：一般
- **改进建议**：§3.15 表格欧拉角函数组单元格的「**完整实现**（v3 修正）」修订为「**stub 占位**（v3 最终决策，原误标为完整实现）」，删除中间冲突表述；或拆分为两行清晰展示「初版决策：完整实现 → v3 最终决策：stub 占位」决策历程

---

### 问题 9（一般）——`conjugate` 函数描述与 GLM 实际实现不一致

- **问题描述**：v3 设计 §3.11（行 425）将 `conjugate(q: Quat<T,Q>): Quat<T,Q>` 描述为「**完整实现**」「仅涉及逐分量取反」。但 GLM `ext/quaternion_common.inl:112-116` 实际 `conjugate` 实现是 `qua<T, Q>::wxyz(q.w, -q.x, -q.y, -q.z)`——保持 w 分量不变、仅对 x/y/z 分量取反，并非「逐分量取反」（逐分量取反会得到 `Quat(-q.x, -q.y, -q.z, -q.w)`）。描述不准确可能导致实施者误实现为四元数所有分量取反（数学上对应 `negative` 运算符），产生错误结果。

- **所在位置**：§3.11 `conjugate` 函数描述
- **严重程度**：一般
- **改进建议**：§3.11 `conjugate` 描述修订为「**完整实现**」「仅对 x/y/z 三个分量取反，w 分量保持不变：`Quat(-q.x, -q.y, -q.z, q.w)`（与 GLM `ext/quaternion_common.inl:112-116` `wxyz(q.w, -q.x, -q.y, -q.z)` 一致）」

---

### 问题 10（一般）——`detail/type_quat_cast.cj` 函数签名细节未定义

- **问题描述**：v3 设计 §3.2、§3.15 多次引用 `detail/type_quat_cast.cj` 中 `mat3Cast`/`mat4Cast`/`quatCast(Mat3)`/`quatCast(Mat4)` 4 个函数，但未给出这些函数的具体签名（泛型参数、约束、返回类型）。例如 `mat3Cast` 是 `func mat3Cast<T, Q>(q: Quat<T, Q>): Mat3x3<T, Q> where T <: Number<T>, Q <: Qualifier` 还是更窄约束（如 `T <: FloatingPoint<T>` 或 GLM 风格的 `T` 仅限浮点类型）？`quatCast` 重载（Mat3 vs Mat4）的签名差异如何通过仓颉泛型重载规则区分？这些问题影响编码启动，需要明确决策。

- **所在位置**：§3.2 协作关系表（行 215-218）、§3.15 跨包引用（行 540-541）、§10 覆盖矩阵 `glm/detail/type_quat_cast.hpp` 表
- **严重程度**：一般
- **改进建议**：新增 §3.2.1「type_quat_cast 函数签名规范」子节，给出 4 个函数的标准签名模板：
  - `public func mat3Cast<T, Q>(q: Quat<T, Q>): Mat3x3<T, Q> where T <: FloatingPointNumber<T>, Q <: Qualifier`
  - `public func mat4Cast<T, Q>(q: Quat<T, Q>): Mat4x4<T, Q> where T <: FloatingPointNumber<T>, Q <: Qualifier`
  - `public func quatCast<T, Q>(m: Mat3x3<T, Q>): Quat<T, Q> where T <: FloatingPointNumber<T>, Q <: Qualifier`
  - `public func quatCast<T, Q>(m: Mat4x4<T, Q>): Quat<T, Q> where T <: FloatingPointNumber<T>, Q <: Qualifier`
  并在 D29 同类约束收紧策略下，明确 GLM 的 `GLM_STATIC_ASSERT(std::numeric_limits<T>::is_iec559, ...)` 编译期断言在仓颉中通过 `where T <: FloatingPointNumber<T>` 约束或运行时 fallback 实现等价行为

---

## 轻微问题

### 问题 11（轻微）——`lib.cj`/`fwd.cj` 具体更新内容未明确

- **问题描述**：v3 设计 §2 包组织（行 86-88、737-738）描述 `lib.cj`「新增四元数类型、ext 函数、gtc 常量的 public import」和 `fwd.cj`「新增四元数类型别名」，但未列出具体的 `public import` 声明清单（如 `public import glm.detail.{Quat, mat3Cast, mat4Cast, quatCast, ...}`）与 `type alias` 声明清单。修复者需要查阅 §3.14 + §3.15 才能拼接完整内容，缺乏 §2 包组织描述的完整性。

- **所在位置**：§2 包组织 glm 包块（行 86-88）、§8 更新文件段（行 734-737）
- **严重程度**：轻微
- **改进建议**：§2 包组织 glm 块下为 `lib.cj`/`fwd.cj` 增加「具体 import/alias 清单」段落，列出：
  - `lib.cj` 新增 6 个 import：`import glm.detail.{Quat, mat3Cast, mat4Cast, quatCast}` / `import glm.ext.vector_relational` / `import glm.ext.quaternion_common` / `import glm.ext.quaternion_geometric` / `import glm.ext.scalar_constants` / `import glm.gtc.constants`
  - `fwd.cj` 新增 8 个 type alias（与 §3.14 表格对应）

---

### 问题 12（轻微）——`pow` 函数递归调用 `pow` 的命名消歧未说明

- **问题描述**：v3 设计 §3.10 描述 `pow` 函数时未明确区分「四元数 `pow`」与「实数 `pow`」。GLM `pow` 实现在 line 65 递归调用 `std::pow(T, T)`（实数版本），与四元数 `pow` 形成调用关系。仓颉版本若采用相同实现策略，需要明确：
  1. 调用的是 `std.math.pow<T>(T, T): T`（实数版本）还是其他
  2. `std.math.pow` 对所有 T 类型（Float32/Float64）的可用性
  3. 若 `std.math.pow` 不存在时如何降级实现

- **所在位置**：§3.10 `pow` 描述、D21 设计决策
- **严重程度**：轻微
- **改进建议**：§3.10 `pow` 描述补充「递归调用 `std.math.pow(x.w, y)`（实数降级路径，T 为浮点类型时 `std.math.pow` 来自仓颉标准库；若 `std.math.pow` 不存在，需以 `exp(y * ln(x.w))` 替代）」

---

### 问题 13（轻微）——`mix` 函数依赖中 `acos`/`sin` 重载版本未明确

- **问题描述**：v3 设计 §3.11（行 431）描述 `mix(x, y, a): Quat<T,Q>` 依赖「`dot`、`acos`、`sin`、`epsilon<T>()`」，但 GLM `mix` 实际在第二分支使用 `acos(cosTheta)`（单参数）和 `sin((1-a) * angle)`/`sin(a * angle)`/`sin(angle)`（单参数），v3 设计未明确 `acos`/`sin` 是 trigonometric.cj 中的单参数版本还是双参数版本。仓颉 trigonometric.cj（作为 stub）需要明确提供哪些重载。

- **所在位置**：§3.11 `mix` 描述、§3.10 `mix`/`slerp`/`pow` 描述
- **严重程度**：轻微
- **改进建议**：§3.11 `mix` 描述修订为「依赖 `dot`/`acos(cosTheta)`（`trigonometric.cj` 的 `acos(T): T` 单参数版本）/`sin(...)`（`trigonometric.cj` 的 `sin(T): T` 单参数版本）/`epsilon<T>()`，其中 `epsilon<T>()` 用于 `cosTheta > 1 - epsilon<T>()` 退化分支」

---

### 问题 14（轻微）——`@Derive[Hashable]` 派生所需 Qualifier Hashable 实现未充分核验

- **问题描述**：v3 设计 §3.1（行 203）「`@Derive[Hashable]` 约束核验（v3 新增，v4 强化）」段声称「`Q <: Qualifier` 约束下 6 个 Qualifier 实现类型均无数据成员（标记类型），其 `Hashable` 派生由编译器自动支持」，但实际 Qualifier 类型实现可能包含数据成员（如 `PackedHighp` 可能携带 alignment 属性或 SIMD 标签字段），需具体核实 6 个 Qualifier 实现类型（`PackedHighp`/`PackedMediump`/`PackedLowp`/`AlignedHighp`/`AlignedMediump`/`AlignedLowp`）是否全部为标记类型且 `Hashable` 接口自动派生。现有阶段二 `type_mat*.cj` 已使用 `@Derive[Hashable]` 且通过编译（依据 a_v2_review_v3.md 第 17 行），但阶段二矩阵的 Qualifier 使用模式与阶段三四元数是否一致需进一步确认。

- **所在位置**：§3.1 `@Derive[Hashable]` 约束核验段（行 203）、§8 编码启动前验证项 11（行 797）
- **严重程度**：轻微
- **改进建议**：§3.1 段落补充「实践依据」段落，引用阶段二 `type_mat2x2.cj` 等使用 `@Derive[Hashable]` 的具体文件与行号作为已验证实践，确保阶段三 Qualifier 类型实现与阶段二完全一致；§8 验证项 11 同步明确「若阶段三新增 Qualifier 变体或 Qualifier 数据结构变更，则需要重新验证 `@Derive[Hashable]` 派生可行性」

---

## 审查结论

| 类别 | 数量 | 问题编号 |
|------|------|---------|
| 严重 | 2 | #1, #2 |
| 一般 | 8 | #3, #4, #5, #6, #7, #8, #9, #10 |
| 轻微 | 4 | #11, #12, #13, #14 |
| **合计** | **14** | — |

**审查意见**：v3 设计相对 v2 在包间循环依赖（核心严重问题）、`Quat×Vec3` 旋转公式（核心严重问题）、依赖关系细化、测试设计、跨文档一致性等维度有显著改进，但本轮审查识别出 2 项严重问题（`axis` 函数边界行为契约与 GLM 实际不符；`pow` 依赖关系不完整 + 行号错误）和 8 项一般问题（涵盖 `log`/`exp`/`slerp` 4 参数版的依赖遗漏、`axis` 自相矛盾、路线图与设计不一致、`gtc/quaternion.cj` 表格表述冲突、`conjugate` 描述偏差、type_quat_cast 签名未定义等）。这些问题主要源于：
1. v3 设计对 GLM 1.0.3 `ext/quaternion_trigonometric.inl`、`ext/quaternion_exponential.inl`、`ext/quaternion_common.inl` 中部分函数（如 `axis`/`pow`/`log`/`slerp` 4 参数版）的实际源码核验不够充分
2. v3 设计在修订阶段三 stub 范围时未与项目路线图 `02_roadmap.md` 同步更新验证标准与函数命名
3. v3 设计在 §3.15 表格单元格的决策历程描述上采用了粗体强调「完整实现」但实际最终决策为 stub 的不一致表述

建议在下一轮迭代中重点解决 2 项严重问题与问题 7（路线图同步），以确保 v3 设计文档与 GLM 1.0.3 参考实现 + 项目路线图三方一致，为后续编码实施提供准确无误的设计输入。