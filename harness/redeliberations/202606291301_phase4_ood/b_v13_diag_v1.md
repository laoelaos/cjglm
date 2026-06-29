# 阶段四 OOD 设计文档 — 质量审查报告

审查对象：`a_v13_copy_from_v12.md`（第 13 次迭代，基于 v12 的修订版）
审查视角：需求响应充分度、事实正确性、深度与完整性（侧重内部审议未充分覆盖的维度）

---

## 1. 需求响应充分度

### 1.1 范围覆盖

产出充分覆盖了需求要求的四个维度（架构视图、模块划分、核心类型与接口设计、关键数据流与控制流、与已有阶段的集成方式），§9 集中阐述与阶段一二三的集成，§8 给出分批次实施计划。整体结构完整。

### 1.2 未覆盖范围的风险声明

§1.5 声明 `ext/quaternion_exponential.cj` 不纳入本阶段范围。需求原文要求"将 GLM 全部核心函数库（core）和扩展函数库（ext/gtc）的 stub 替换为完整实现"。该文件属于 ext 扩展函数库，不纳入范围与需求存在张力。内部审议已记录此决策（迭代 1 P1→§1.5），但产出未评估此不覆盖是否会影响下游对 GLM API 完整性的期望。

**改进建议**：在 §1.5 或新增设计决策中补充风险评估——若下游代码调用了 `exp(quat)`/`log(quat)` 等函数，本阶段完成后仍会抛 stub 异常，用户需知晓此限制。不应仅以"极少使用"作为排除理由而不评估影响面。

---

## 2. 事实错误与逻辑矛盾

### 2.1 [严重] `mirrorRepeat` 实现公式与 GLM 1.0.3 源码不符

- **位置**：§3.2 ext/scalar_common.cj，第 361 行
- **问题**：产出给出的公式为：
  ```
  Mirror = clamp(Floor, 0, 1) → mix(Rest, 1 - Rest, Mirror % 2 >= 1)
  ```
  GLM 1.0.3 `ext/scalar_common.inl` 第 143~151 行的实际实现为：
  ```cpp
  Clamp = mod(floor(Abs), 2);
  Mirror = Clamp + Rest;
  return mix(Rest, 1 - Rest, Mirror >= 1);
  ```
  产出中的 `clamp(Floor, 0, 1)` 与 GLM 的 `mod(floor(Abs), 2)` 语义完全不同。前者的效果是"Floor≥1 时全部映射为 1"，后者的效果是"每两个整数区间交替"。产出公式仅产生一次翻转（在 Floor=1 处），而 GLM 实现在每个整数区间交替 Rest 与 1-Rest，实现镜像重复纹理环绕效果。编码团队按产出公式实现将产生错误结果。
- **根因分析**：此公式是在迭代 9→v10 时以"补全 mirrorRepeat 公式"名义添加的（见修订说明 v9→v10 P3），但此后 3 轮审查均未与 GLM 1.0.3 源码进行逐行比对验证。
- **改进建议**：修正为与 GLM 1.0.3 一致的公式：
  ```
  Abs = abs(Texcoord) → Floor = floor(Abs) → Clamp = mod(Floor, T(2)) → Rest = Abs - Floor → Mirror = Clamp + Rest → mix(Rest, T(1) - Rest, Mirror >= T(1))
  ```

### 2.2 [严重] Simplex 噪声返回类型与 GLM 1.0.3 源码不符

- **位置**：§3.3 gtc/noise.cj，第 624~626 行
- **问题**：产出声明 simplex2D 返回 `Vec2<T, Q>`、simplex3D 返回 `Vec3<T, Q>`、simplex4D 返回 `Vec4<T, Q>`。但 GLM 1.0.3 `gtc/noise.hpp` 第 54~56 行的签名明确为：
  ```cpp
  template<length_t L, typename T, qualifier Q>
  GLM_FUNC_DECL T simplex(vec<L, T, Q> const& p);
  ```
  所有维度的 simplex 噪声均返回标量 `T`，而非维度对应的向量。同样，perlin 噪声的第 2 个重载（周期噪声）在 GLM 中也接受 `(vec<L,T,Q>, vec<L,T,Q>)` 两参数版本，产出仅给出了单参数版本。
- **根因分析**：迭代 7 P4 中审查者提出"Simplex 噪声返回 Vec<T, Q>（各维度返回对应维度向量）"，产出作者直接采纳了此错误判断，未查阅 GLM 1.0.3 源码确认。此后 5 轮审查均未质疑此声明。
- **改进建议**：
  1. 将所有 simplex 函数的返回类型修正为 `T`（标量），与 GLM 1.0.3 一致
  2. 补充 Perlin 周期噪声重载：`perlin1D<T,Q>(x: T, rep: T): T`、`perlin2D<T,Q>(v: Vec2<T,Q>, rep: Vec2<T,Q>): T` 等

### 2.3 [中等] `ext/matrix_projection.cj` 签名遗漏 viewport 的独立类型参数

- **位置**：§3.2 ext/matrix_projection.cj，第 452~459 行
- **问题**：产出使用单一泛型 `T <: FloatingPoint<T>` 约束所有参数类型。但 GLM 1.0.3 `ext/matrix_projection.hpp` 中 `projectZO`/`projectNO`/`project` 等函数使用两个独立的类型参数——`T` 用于向量/矩阵分量，`U` 用于 viewport 分量：`vec<4, U, Q> const& viewport`。在仓颉实现中，viewport 的整型/浮点类型可能与 T 不同（常见情况：T=Float32，viewport 为 Int32 类型）。产出未给出 viewport 类型的独立约束策略。
- **改进建议**：为 viewport 参数引入独立类型参数 `U`，约束为 `U <: Number<U>`（viewport 可用整数或浮点），或至少注释说明编码阶段需考虑 viewport 类型与 T 解耦的可能性。

---

## 3. 深度与完整性

### 3.1 [中等] `ext/matrix_projection.cj` 函数签名缺少参数类型和返回类型

- **位置**：§3.2 ext/matrix_projection.cj，第 452~459 行
- **问题**：仅以 `projectZO(obj, model, proj, viewport)` 的形式列出函数名和参数名，未给出参数类型、返回类型、约束。编码团队无法直接从文档中获知 `obj` 是 `Vec3`、`model` 和 `proj` 是 `Mat4x4`、`viewport` 是 `Vec4`、返回类型是 `Vec3`。虽然经验丰富的 GLM 开发者可以推断，但 OOD 文档作为编码蓝图应消除此类不确定性。
- **改进建议**：参照 ext/scalar_common.cj 或 packing.cj 的格式，给出每个函数的完整仓颉签名。例如：
  ```
  func projectZO<T, U, Q>(obj: Vec3<T,Q>, model: Mat4x4<T,Q>, proj: Mat4x4<T,Q>, viewport: Vec4<U,Q>): Vec3<T,Q>
    where T <: FloatingPoint<T>, U <: Number<U>, Q <: Qualifier
  ```

### 3.2 [中等] `ext/matrix_clip_space.cj` 函数签名仅列出函数名，缺少参数类型

- **位置**：§3.2 ext/matrix_clip_space.cj，第 467~474 行
- **问题**：46 个函数仅按系族列出函数名（如 `orthoLH_ZO`、`perspectiveRH_ZO` 等），未给出任何一个函数的完整参数类型签名。虽然这些函数遵循 GLM 规范的标准签名（`(left, right, bottom, top, zNear, zFar)` 等），但缺乏显式定义意味着编码团队每次需反向查阅 GLM 源码确认。
- **改进建议**：至少为每个系族给出一个典例函数的完整签名（如 `ortho<T,Q>(left:T, right:T, bottom:T, top:T, zNear:T, zFar:T): Mat4x4<T,Q>`），并标注其他变体在此基础上的参数差异。

### 3.3 [中等] `gtc/matrix_transform.cj` 的 `rotate_slow`/`scale_slow`/`shear_slow` 缺少独立签名和实现路径说明

- **位置**：§3.3 gtc/matrix_transform.cj，第 518 行
- **问题**：迭代 10→v11 时已确认这三个函数需在 gtc 层独立实现（ext 层不存在对应版本），但产出仅将其列入函数计数，未给出各自与 ext 层对应版本（rotate/scale/shear）的签名差异和实现策略。`_slow` 后缀函数的实现路径与标准版本不同（例如 rotate_slow 使用不同的角度分解公式），编码团队无法确定实现方式。
- **改进建议**：补充每个 `_slow` 函数的完整签名（与标准版本签名相同但实现不同），并说明与标准版本的实现差异（或注明"与 GLM 1.0.3 实现一致，编码阶段参考 `gtc/matrix_transform.inl` 中对应 `_slow` 函数"）。

### 3.4 [轻微] `gtc/type_precision.cj` 缺失 `hvec1` 别名

- **位置**：§3.3 gtc/type_precision.cj，第 659~665 行
- **问题**：Float16 向量别名列出了 `hvec2/hvec3/hvec4` 但缺少 `hvec1`，而其他精度系列（fvec/dvec）均包含 `fvec1`/`dvec1`。虽然 hvec1 在图形编程中使用较少，但 GLM 1.0.3 `gtc/type_precision.hpp` 中 highp/mediump/lowp 各精度体系均提供 vec1 别名，一致性应保持。
- **改进建议**：补充 `hvec1` 别名。

### 3.5 [轻微] `ldexp` 的实现精度分析不足

- **位置**：§3.1 common.cj，第 250 行
- **问题**：`ldexp<T>(x, exp)` 实现为 `x * pow(T(2), T(exp))`。对于 `T = Float32` 且 `exp` 指向非规格化数范围（如 `exp = -127` 附近），通过 `std.math.pow(Float64(2), Float64(-127))` 经 Float64 计算后转型为 Float32，可能丢失非规格化数精度（Float64 在极端负指数下的精度保留问题）。虽然产出在 D29 中已记录 Float16 溢出差异，但未讨论 Float32 非规格化数精度损失。
- **改进建议**：在 D29 或 §3.1 ldexp 说明中补充一句："Float32 的 ldexp 在 exp 指向非规格化数范围时，Float64→Float32 转型可能丢失非规格化尾数精度。此差异对图形应用影响极低（非规格化数通常可接受截断），列入已知行为差异。"

---

## 4. 整体质量评价

产出经过 12 轮内部审议迭代，需求响应充分、架构合理、与阶段的集成方案可行。主要问题集中在对 GLM 1.0.3 源码的一处关键误读（mirrorRepeat 公式、simplex 返回类型），这两个错误均来自较早迭代中审查者的错误假设未被后续验证发现。此外，ext/matrix_projection.cj 和 ext/matrix_clip_space.cj 的函数签名粒度过粗，编码团队需频繁查阅 GLM 源码，降低了 OOD 文档作为编码蓝图的独立指导价值。

**优先级建议**：
- P0（必须修复）：§2.2（mirrorRepeat 公式）、§2.2（simplex 返回类型）
- P1（推荐修复）：§2.3（project 双类型参数）、§3.1（project 签名粒度）、§3.2（clip space 签名粒度）
- P2（建议修复）：§3.3（slow 变体签名）、§3.4（hvec1 缺失）、§3.5（ldexp 精度说明）
