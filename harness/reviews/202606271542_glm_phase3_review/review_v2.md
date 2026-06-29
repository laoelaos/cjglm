# R2.1: 四元数 ext 函数库（common + geometric）审查

审查时间：2026-06-27

### 审查范围

| 文件 | 行数 | 职责 |
|------|------|------|
| `cjglm/src/ext/quaternion_common.cj` | 41 | 四元数公共函数（`conjugate`/`inverse`/`lerp`/`isnan`/`isinf` 完整 + `mix`/`slerp`(2 重载) stub） |
| `cjglm/src/ext/quaternion_geometric.cj` | 40 | 四元数几何函数（`dot`/`length`/`normalize`/`cross` 完整） |

**主依据**：`docs/05_ood_phase3.md` §3.7（四元数几何函数）/§3.11（四元数公共函数）/§1「系统性设计约束：T(0)/T(1) 字面量替代路径」/§1「Float32 与 std.math 的交互约束」

**辅助参照**：
- `references/glm-1.0.3/glm/glm/ext/quaternion_geometric.inl`（GLM 1.0.3 源实现）
- `references/glm-1.0.3/glm/glm/ext/quaternion_common.inl`（GLM 1.0.3 源实现）
- `cjglm/src/ext/quaternion_relational.cj`（同目录姊妹文件风格基线）
- `cjglm/src/ext/vector_relational.cj`（阶段一/二 ext 函数库风格基线）
- `cjglm/src/detail/type_quat.cj`（Quat 类型定义 + 运算符重载）
- `cjglm/src/ext/quaternion_trigonometric.cj`（同目录姊妹文件，sqrtT 用法参照）

### 发现

#### [一般] `slerp` 4 参数版本 `spin: Bool` 与 OOD §3.11 / D22 决策 `k: Int64` 显著偏离

- **位置**：`cjglm/src/ext/quaternion_common.cj:40`
- **描述**：OOD §3.11 line 791、D22 决策（line 1703）、§11.5 函数可用性对照表（line 2212）三处明确声明 `slerp` 4 参数版本采用「**`slerp<T, Q>(x: Quat<T,Q>, y: Quat<T,Q>, a: T, k: Int64)` 简化版签名**」，理由是「与 deviations.md DV-03『移位运算右操作数固定为 Int64』风格一致，牺牲泛型灵活性换取签名简洁性」。GLM 1.0.3 原始 `slerp(x, y, a, k)`（`references/glm-1.0.3/glm/glm/ext/quaternion_common.inl:75-110`）使用独立泛型 `S` 配合 `GLM_STATIC_ASSERT(std::numeric_limits<S>::is_integer, ...)` 约束接受任意整数类型。**实现采用 `spin: Bool`（第 40 行），与上述 OOD 三处承诺及 GLM 原始设计均不一致**：
  1. **语义错误**——`Bool` 类型在仓颉 stdlib 中**不实现** `Integer<Bool>` 接口（`Integer<T>` 仅由 `Int8`/`Int16`/`Int32`/`Int64`/`UInt8`/`UInt16`/`UInt32`/`UInt64` 实现），即使阶段四按 GLM `phi = angle + k * pi<T>()` 公式实现，`k * pi<T>()` 的 `*` 运算符需要 `Number<T>` 接口，Bool 不实现 `Number<Bool>` 将编译失败。
  2. **取值域错位**——`Bool` 仅能取 `true`/`false`（0/1），无法表达 GLM 允许的「3 整圈旋转」（`k = 3`）等多圈场景；GLM 与 OOD 选定的 `Int64` 满足 `k ∈ [Int64.Min, Int64.Max]`，取值范围充足。
  3. **命名歧义**——`spin` 在 GLM 习惯中为「自旋标志」（如 `quatLookAt` 系列），用于控制是否执行自旋选择而非「整圈数」。GLM `slerp` 第 4 形参为「整圈数 k」（`angle + k * pi`），命名为 `k` 体现「整圈数」语义；命名为 `spin` 与 GLM 命名风格不一致。
- **影响**：阶段三为 stub，运行时均抛 `Exception("stub")` 无实际影响；但 API 形态偏差将传递至阶段四——若阶段四按 OOD 选定的 `Int64` 简化签名实现函数体，则函数签名需从 `spin: Bool` 改为 `k: Int64`，所有调用方（即使是阶段四新增测试用例）需同步更新。
- **建议**：将第 40 行签名从 `slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T, spin: Bool): Quat<T, Q>` 修改为 `slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T, k: Int64): Quat<T, Q>`，与 OOD §3.11 line 791 / D22 / §11.5 三处承诺完全一致。

#### [一般] `mix` 约束 `Number<T>` 较 GLM `is_iec559` 静态断言过宽

- **位置**：`cjglm/src/ext/quaternion_common.cj:34-35`
- **描述**：GLM 1.0.3 `references/glm-1.0.3/glm/glm/ext/quaternion_common.inl:6` 对 `mix` 函数使用 `GLM_STATIC_ASSERT(std::numeric_limits<T>::is_iec559 || GLM_CONFIG_UNRESTRICTED_FLOAT, "'mix' only accept floating-point inputs")`——明确限定为浮点类型。实现采用 `where T <: Number<T>, Q <: Qualifier`（第 34-35 行），`Number<T>` 在仓颉 stdlib 中由 `Integer<T>` 与 `FloatingPoint<T>` 共同实现，**允许** `Int8`/`Int16`/`Int32`/`Int64`/`UInt8`~`UInt64` 等整数类型实例化。语义上 `mix`（球面插值 / 角度内插退化）需要 `acos`/`sin` 等三角函数（均为 `FloatingPoint<T>` 约束），整数 T 实例化将无法在阶段四补齐时编译通过，需届时回退收紧约束——与 OOD §1 「T(0)/T(1) 字面量替代」段对「类型约束一旦放宽收紧易触发 API 形态偏差扩大」的告诫一致。
- **影响**：当前 stub 抛 `Exception("stub")`，整数 T 实例化无运行时错误；但阶段四实现时若直接调用 `acos`/`sin`/`epsilon<T>()` 等浮点 API，整数 T 将编译失败。约束收紧策略应提前到 stub 阶段。
- **建议**：将第 34 行约束从 `Number<T>` 收紧为 `FloatingPoint<T>`（与 `slerp` 3-arg/4-arg stub 约束保持一致，与 GLM `is_iec559` 静态断言语义对齐），消除阶段四实现时的回退成本。

#### [一般] `lerp` 约束 `Number<T> & Comparable<T>` 较 GLM `is_iec559` 静态断言过宽

- **位置**：`cjglm/src/ext/quaternion_common.cj:16-17`
- **描述**：与上一条 `mix` 同根问题。GLM 1.0.3 `quaternion_common.inl:31` 使用 `GLM_STATIC_ASSERT(std::numeric_limits<T>::is_iec559 || ..., "'lerp' only accept floating-point inputs")`。实现采用 `where T <: Number<T> & Comparable<T>`（第 17 行），允许整数 T 实例化。OOD §3.11 line 783 仅说「`lerp` 完整实现（运行时，非 const，含 assert(a >= 0 && a <= 1) 断言）」未明确约束选择，约束「`& Comparable<T>`」是为支持 `assert` 中的 `>=`/`<=` 比较运算所必需——但应同时收紧到 `FloatingPoint<T>`（`FloatingPoint<T>` 自动满足 `Comparable<T>`，仓颉 stdlib 原生支持）。
- **影响**：与 `mix` 同——整数 T 实例化当前无运行时影响（仅抛 assert 或返回线性插值结果），但阶段四迁移到 `slerp`/`mix` 路径时需保持约束一致性。
- **建议**：将第 17 行约束从 `Number<T> & Comparable<T>` 收紧为 `FloatingPoint<T>`（`FloatingPoint<T>` 隐含 `Comparable<T>`），与 OOD §3.11 整体约束策略（`inverse`/`slerp`/`mix`/`isnan`/`isinf` 全部收紧为 `FloatingPoint<T>`）保持一致。

#### [一般] `length` 使用 `sqrtT` Float64 中转包装，未按 OOD §1「方案 A」直接调用 `std.math.sqrt` 重载

- **位置**：`cjglm/src/ext/quaternion_geometric.cj:5-8, 17`
- **描述**：OOD §1「Float32 与 std.math 的交互约束」段 + §3.7 line 716 明确说明 `std.math.sqrt` 提供 Float16/Float32/Float64 三种重载（已在 `cangjie-original-docs/std/math/math_package_api/math_package_funcs.md:5158/5196/5234` 验证：`public func sqrt(x: Float16): Float16`、`public func sqrt(x: Float32): Float32`、`public func sqrt(x: Float64): Float64`），T=Float32 实例化时**应直接调用** `std.math.sqrt(dot_qq)` 利用 Float32 重载（**方案 A 推荐**），T=Float64 时直接使用返回值。实现却定义私有 `sqrtT<T>(x: T): T where T <: FloatingPoint<T>` 工具函数（第 5-8 行），通过 `Float64` 中转——`(x as Float64).getOrThrow()` → `sqrt(x64)` → `(sqrt(x64) as T).getOrThrow()`——所有 T 实例化路径均**强制**走 Float64 中转，违反 OOD §1 方案 A 策略。
- **影响**：
  1. **跨文件一致性**——`quaternion_trigonometric.cj:5-8` 与 `type_quat_cast.cj:122-125` 均存在完全相同的 `sqrtT` 工具函数（grep 全文 9 处匹配），表明该模式是**项目级一致性偏差**而非单文件遗漏，但仍偏离 OOD §1 统一策略。
  2. **精度影响**——Float32 输入经 Float64 中转再截断回 Float32，理论上**不会**损失精度（Float64 → Float32 截断与 Float32 直接计算结果一致或更优），**不会**引入正确性错误，但**违反 OOD 显式约束**且增加不必要的运行时类型转换开销。
- **建议**：
  1. **方案 A（推荐，跨文件统一修订）**——删除 `sqrtT` 工具函数（`quaternion_geometric.cj:5-8` + `quaternion_trigonometric.cj:5-8` + `type_quat_cast.cj:122-125`），将 `length`（line 17）/ `axis`（`quaternion_trigonometric.cj:18`）/ `quatCast`（`type_quat_cast.cj:84, 90, 96, 102`）中的 `sqrtT(x)` 调用替换为直接 `sqrt(x)`——利用 std.math 的 Float16/Float32/Float64 重载实现编译期类型分发（`T = Float32` 时调用 `sqrt(Float32): Float32` 重载，零运行时开销），与 OOD §1「方案 A」对齐。
  2. **方案 B（最小改动）**——保留 `sqrtT` 但在 OOD §1 追加「`sqrtT` 中转模式：跨文件一致接受作为 OOD 方案 A 的可行替代」的偏差声明，并登记到 `docs/deviations.md`（与 DV-04 `epsilonOf` hint 参数风格一致）。

#### [一般] 任务描述中 `cross` GLM 公式与 GLM 1.0.3 实际实现不符——实现正确，任务描述错误

- **位置**：`harness/reviews/202606271542_glm_phase3_review/scope.md`（任务派发描述）以及本轮审查重点 #2
- **描述**：本轮任务派发描述指出「四元数 `cross` 的 GLM 公式：`(a.y*b.z - a.z*b.y, a.z*b.x - a.x*b.z, a.x*b.y - a.y*b.x, 0)`」（w 分量为 0），该描述**与实际 GLM 1.0.3 `references/glm-1.0.3/glm/glm/ext/quaternion_geometric.inl:27-34` 不一致**。GLM 1.0.3 实际实现为 Hamilton 乘积形式——w 分量为 `q1.w * q2.w - q1.x * q2.x - q1.y * q2.y - q1.z * q2.z`（非零）：

  ```cpp
  // GLM 1.0.3 ext/quaternion_geometric.inl:27-34
  template<typename T, qualifier Q>
  GLM_FUNC_QUALIFIER GLM_CONSTEXPR qua<T, Q> cross(qua<T, Q> const& q1, qua<T, Q> const& q2)
  {
      return qua<T, Q>::wxyz(
          q1.w * q2.w - q1.x * q2.x - q1.y * q2.y - q1.z * q2.z,  // w (非零)
          q1.w * q2.x + q1.x * q2.w + q1.y * q2.z - q1.z * q2.y,  // x
          q1.w * q2.y + q1.y * q2.w + q1.z * q2.x - q1.x * q2.z,  // y
          q1.w * q2.z + q1.z * q2.w + q1.x * q2.y - q1.y * q2.x); // z
  }
  ```

  实现 `quaternion_geometric.cj:32-40` 逐分量与 GLM 1.0.3 完全吻合（仅分量排列顺序因主构造函数 vs `wxyz` 工厂而不同）：

  | 分量 | GLM 1.0.3 公式 | 实现公式（`quaternion_geometric.cj:35-38`） | 一致性 |
  |------|---------------|--------------------------------------------|------|
  | x | `w1*x2 + x1*w2 + y1*z2 - z1*y2` | `q1.w * q2.x + q1.x * q2.w + q1.y * q2.z - q1.z * q2.y` | ✅ |
  | y | `w1*y2 + y1*w2 + z1*x2 - x1*z2` | `q1.w * q2.y - q1.x * q2.z + q1.y * q2.w + q1.z * q2.x` | ✅（重排） |
  | z | `w1*z2 + z1*w2 + x1*y2 - y1*x2` | `q1.w * q2.z + q1.x * q2.y - q1.y * q2.x + q1.z * q2.w` | ✅（重排） |
  | w | `w1*w2 - x1*x2 - y1*y2 - z1*z2` | `q1.w * q2.w - q1.x * q2.x - q1.y * q2.y - q1.z * q2.z` | ✅ |

  OOD §3.7 line 720 描述「四元数 `cross`（Hamilton 乘积的逐分量展开）」也明确指出四元数 `cross` 是 Hamilton 乘积的逐分量展开——与 GLM 1.0.3 实际行为一致。**任务派发描述与 OOD §3.7 段落及 GLM 1.0.3 实际实现均不一致**。

- **影响判断**：
  1. **实现正确**——仓颉版 `cross` 与 GLM 1.0.3 行为 1:1 对齐，符合 OOD §3.7「四元数 `cross` Hamilton 乘积逐分量展开」承诺，应判定为「✅ 真完整实现」。
  2. **任务派发描述错误**——scope.md 中给出的 w=0 公式实为「Vec3 叉乘扩展到 Quat.w=0」的几何意义变体，**非** GLM 1.0.3 实现的 `cross` 函数。任务派发描述错误可能误导后续审查者或下游用户对四元数 `cross` 行为的预期。
- **建议**：
  1. 修正 `scope.md` 中关于 `cross` 的描述为「四元数 `cross` 即 Hamilton 乘积的逐分量展开（与 `Quat * Quat` 运算符等价），GLM 1.0.3 `ext/quaternion_geometric.inl:27-34` 实际公式：`w = w1*w2 - x1*x2 - y1*y2 - z1*z2; x = w1*x2 + x1*w2 + y1*z2 - z1*y2; y = w1*y2 + y1*w2 + z1*x2 - x1*z2; z = w1*z2 + z1*w2 + x1*y2 - y1*x2`」。
  2. 实施侧无需修改代码。
  3. 进一步建议在 OOD §3.7「命名歧义说明」段（line 722-725）补强一句：「**注：四元数 `cross` 与 `Quat * Quat` 运算符（`type_quat.cj:99-106` Hamilton 乘积）实现完全等价**，不是 Vec3 叉乘的扩展形式（w=0），下游消费者无需因命名『cross』而误判其为向量叉乘的扩展」。

#### [轻微] `conjugate` 未声明为 `const func`

- **位置**：`cjglm/src/ext/quaternion_common.cj:5-8`
- **描述**：OOD §3.11 line 779 详细论证了 `conjugate` 函数体「仅涉及 `Quat` 主构造函数的逐分量取反调用（`Quat(-q.x, -q.y, -q.z, q.w)`），无 `assert`/无 `throw`/无 `dot`/`normalize`/其他非 const 函数调用，**可声明为 `const func`**」，并新增 §8 编码启动前验证项 24「`conjugate` const func 编译可行性验证」作为门禁。实现（第 5 行）采用非 const 形式 `public func conjugate<T, Q>(q: Quat<T, Q>): Quat<T, Q>`，未标注 `const` 修饰符。
- **影响**：`const val q = conjugate(q0)` 在阶段三编译期失败；与项目矩阵家族风格不一致——`type_mat3x3.cj` 9 个矩阵类型的逐分量运算符（如 `negative(mat): Mat`）均已声明为 `const func`。
- **建议**：将第 5 行声明修改为 `public const func conjugate<T, Q>(q: Quat<T, Q>): Quat<T, Q> where T <: Number<T>, Q <: Qualifier`，与 OOD §3.11 line 779 论证一致；`const` 修饰符不影响 stub 函数（项目其他 `const` 函数如 `wxyz` 工厂、矩阵 `negative` 均为 const 实践成功）。

#### [轻微] 任务派发描述与 OOD §3.11 line 783 中 `lerp` 公式括号位置轻微不一致

- **位置**：`cjglm/src/ext/quaternion_common.cj:21`（实现） vs OOD §3.11 line 783（描述）
- **描述**：OOD §3.11 line 783 描述 `lerp` 公式为「`x * (1 - a) + y * a`」，实现（第 21 行）严格遵循 `x * (one - a) + y * a`（替换 `1` 为 `one` 字面量）。但 OOD §1 段强调 lerp 不可声明为 `const func`，仅描述了**数学形式**而非最终代码形式，公式表述与最终代码**结构一致**——`(1 - a)` 与 `(one - a)` 对应，无偏差。
- **影响判断**：无功能影响，仅审查者对 OOD 文字描述与实现代码之间一致性做的字面核验。
- **建议**：无需修改。该条目仅作「字面一致性核验通过」记录。

### 正确性细节附录

| 检查项 | 结论 | 备注 |
|-------|------|------|
| `conjugate` 公式（`quaternion_common.cj:7`） | ✅ 正确 | `Quat(-q.x, -q.y, -q.z, q.w)` 与 GLM 1.0.3 `quaternion_common.inl:113-116` `wxyz(q.w, -q.x, -q.y, -q.z)` 完全等价（仓颉主构造 x,y,z,w vs GLM wxyz w,x,y,z 顺序互补） |
| `inverse` 公式（`quaternion_common.cj:12`） | ✅ 正确 | `conjugate(q) / dot(q, q)` 与 GLM 1.0.3 `quaternion_common.inl:119-122` 完全一致 |
| `lerp` 公式（`quaternion_common.cj:21`） | ✅ 正确 | `x * (one - a) + y * a` 与 GLM 1.0.3 `quaternion_common.inl:29-38` `x * (T(1) - a) + (y * a)` 结构一致（括号位置不同，运算符优先级结果相同） |
| `lerp` 约束（line 17） | ⚠️ 过宽 | `Number<T> & Comparable<T>` 应收紧为 `FloatingPoint<T>`（GLM 静态断言 `is_iec559`） |
| `lerp` 断言（line 20） | ✅ 正确 | `assert(a >= zero && a <= one)` 与 GLM `assert(a >= T(0)) && assert(a <= T(1))`（`quaternion_common.inl:34-35`）语义一致；T(0)/T(1) 通过 `(Float64(0)/1 as T).getOrThrow()` 字面量替代路径获取（与 OOD §1 策略一致） |
| `lerp` 标注（line 15） | ✅ 正确 | `@OverflowWrapping` 标注与 OOD §3.4「统一标注 `@OverflowWrapping`」一致 |
| `isnan`/`isinf` 公式（line 26, 31） | ✅ 正确 | `Vec4<Bool, Q>(q.x.isNaN(), ...)` 与 GLM 1.0.3 `quaternion_common.inl:124-138` `vec<4, bool, Q>(isnan(q.x), ...)` 语义一致（仓颉使用实例方法 `x.isNaN()`，GLM 使用自由函数 `isnan(x)`，std.math 实例方法与自由函数行为等价） |
| `isnan`/`isinf` 约束（line 25, 30） | ✅ 正确 | `FloatingPoint<T>` 与 OOD §3.11 line 792-793 / D29 决策一致，与 GLM `is_iec559` 静态断言语义一致 |
| `mix` stub（line 35） | ✅ 正确 | `throw Exception("stub")` 与 OOD §3.11 line 790「stub 占位」承诺一致 |
| `mix` 约束（line 34） | ⚠️ 过宽 | `Number<T>` 应收紧为 `FloatingPoint<T>`（GLM `is_iec559` 静态断言） |
| `slerp` 3-arg stub（line 38） | ✅ 正确 | `throw Exception("stub")` 与 OOD §3.11 line 789「stub 占位」承诺一致 |
| `slerp` 3-arg 约束（line 37） | ✅ 正确 | `FloatingPoint<T>` 与 OOD §3.11 / D29 决策一致 |
| `slerp` 4-arg stub（line 41） | ✅ 正确（运行时） | `throw Exception("stub")` 运行时行为正确 |
| `slerp` 4-arg 约束（line 40） | ✅ 正确 | `FloatingPoint<T>` 与 OOD §3.11 一致 |
| `slerp` 4-arg `spin: Bool` 类型（line 40） | ❌ 偏离 OOD | OOD §3.11 line 791 / D22 / §11.5 line 2212 三处声明 `k: Int64`，实现为 `spin: Bool`，详见「一般问题 #1」 |
| `dot` 公式（`quaternion_geometric.cj:12`） | ✅ 正确 | `x.w * y.w + x.x * y.x + x.y * y.y + x.z * y.z` 与 GLM 1.0.3 `quaternion_geometric.inl:4-8` `compute_dot<qua<T,Q>,T>` 特化结果一致 |
| `dot` 约束（line 11） | ✅ 正确 | `FloatingPoint<T>` 与 OOD §3.7 / D32 决策一致，与 GLM `is_iec559` 静态断言语义一致 |
| `length` 公式（`quaternion_geometric.cj:17`） | ✅ 正确 | `sqrtT(dot(q, q))` 与 GLM 1.0.3 `quaternion_geometric.inl:11-14` `sqrt(dot(q, q))` 语义一致；实现通过 `sqrtT` Float64 中转（OOD §1 方案 A 偏离，详见「一般问题 #4」） |
| `length` 约束（line 16） | ✅ 正确 | `FloatingPoint<T>` 与 OOD §3.7 一致 |
| `normalize` 零保护分支（`quaternion_geometric.cj:25-26`） | ✅ 正确 | `if (len <= zero) { Quat(zero, zero, zero, one) }` 与 GLM 1.0.3 `quaternion_geometric.inl:19-21` `if (len <= T(0)) return wxyz(T(1), T(0), T(0), T(0))` 语义一致（仓颉主构造 x,y,z,w 顺序对应 w=one=1, xyz=zero=0；GLM wxyz 顺序对应 w=1, x=y=z=0） |
| `normalize` 非零分支（`quaternion_geometric.cj:28`） | ✅ 正确 | `q / len` 与 GLM 1.0.3 `quaternion_geometric.inl:23` `q.w*oneOverLen, q.x*oneOverLen, ...` 通过 `Quat / T` 运算符重载（`type_quat.cj:135-137`）实现，结果等价 |
| `normalize` 约束（line 21） | ✅ 正确 | `FloatingPoint<T> & Comparable<T>` 与 OOD §3.7 line 717 / D32 一致；`Comparable<T>` 是 `len <= zero` 比较运算所需（与 OOD §1「Float32 与 std.math 交互约束」段一致） |
| `normalize` T(0)/T(1) 获取（line 22-23） | ✅ 正确 | `(Float64(0/1) as T).getOrThrow()` 与 OOD §1「常量型 T(n) 字面量替代」策略一致 |
| `cross` 公式（`quaternion_geometric.cj:35-38`） | ✅ 正确 | Hamilton 乘积逐分量展开，与 GLM 1.0.3 `quaternion_geometric.inl:27-34` 1:1 对齐（分量顺序因 `Quat(x,y,z,w)` 主构造 vs `wxyz(w,x,y,z)` 工厂而重排，数学等价） |
| `cross` 约束（line 33） | ✅ 正确 | `FloatingPoint<T>` 与 OOD §3.7 一致 |
| `sqrtT` 工具函数（`quaternion_geometric.cj:5-8`） | ⚠️ 偏离 OOD | OOD §1 方案 A 应直接调用 `std.math.sqrt` 重载；`sqrtT` 通过 Float64 中转实现（详见「一般问题 #4」） |
| 包间依赖方向（`quaternion_common.cj:2` + `quaternion_geometric.cj:2`） | ✅ 正确 | 两个文件均 `import glm.detail.{ Quat, ... }` 单向依赖，`quaternion_common.cj` 还引用 `Vec4`（`isnan`/`isinf` 返回类型），无任何 `import glm.gtc.*` 跨包引用；与 OOD §2「`glm.ext → glm.detail` 单向依赖」约束一致 |

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 0 |
| 一般 | 5 |
| 轻微 | 2 |

### 总评

`quaternion_common.cj`（41 行）与 `quaternion_geometric.cj`（40 行）**整体实现质量良好**，核心数学逻辑（Hamilton 乘积、conjugate/inverse 公式、normalize 零保护分支、isnan/isinf 实例方法、lerp 断言 + 公式、dot 点积、T(0)/T(1) 字面量替代路径）均与 GLM 1.0.3 实际实现及 OOD §3.7/§3.11 严格一致。2 个 stub 函数（`mix`）与 2 个 slerp stub 函数正确抛 `Exception("stub")`，与 OOD §3.11 段落「stub 占位」承诺及 D37 决策一致。

**核心数学正确性结论**：
- **`dot`** ✅ 与 GLM 1.0.3 `compute_dot<qua<T,Q>,T>` 特化结果完全一致
- **`length`** ✅ 语义与 GLM `sqrt(dot(q, q))` 等价（仅 sqrtT 中转为偏离 OOD §1 方案 A 的实现选择，**无正确性错误**）
- **`normalize`** ✅ 零保护分支 `len <= zero → Quat(0,0,0,1)` 与 GLM `wxyz(T(1), T(0), T(0), T(0))` 数学等价；非零分支 `q / len` 通过 `Quat / T` 运算符重载实现，结果与 GLM `q.w*oneOverLen, q.x*oneOverLen, ...` 等价
- **`cross`** ✅ Hamilton 乘积逐分量展开与 GLM 1.0.3 1:1 对齐（任务派发描述中的「w=0 公式」与 GLM 实际实现不符，**实现正确**而任务描述错误）
- **`conjugate`/`inverse`/`lerp`/`isnan`/`isinf`** ✅ 5 个完整实现函数与 GLM 1.0.3 逐字符验证一致

**主要遗留问题**集中在 **OOD 文档/API 形态层面**：

1. **`slerp` 4 参数签名 `spin: Bool` 偏离 OOD `k: Int64`**（一般）——语义错误（Bool 不实现 `Integer<Bool>`/`Number<Bool>`，阶段四实现 `phi = angle + k * pi<T>()` 时 `k * pi` 编译失败）+ 取值域错位（仅 0/1）+ 命名歧义（`spin` 在 GLM 习惯中为「自旋标志」而非「整圈数」）。建议修正为 `k: Int64`。

2. **`mix`/`lerp` 约束过宽**（一般 × 2）——`Number<T>` / `Number<T> & Comparable<T>` 应收紧为 `FloatingPoint<T>`，与 GLM `is_iec559` 静态断言及项目内 `slerp`/`isnan`/`isinf`/`inverse` 约束策略保持一致。

3. **`length` 使用 `sqrtT` Float64 中转包装**（一般）——偏离 OOD §1 方案 A「直接调用 `std.math.sqrt` 重载」策略；但**与 `quaternion_trigonometric.cj`/`type_quat_cast.cj` 的 `sqrtT` 模式跨文件一致**（grep 全文 9 处匹配），属于**项目级一致性偏差**。建议跨文件统一修订（删除 sqrtT）或在 `deviations.md` 登记为已知偏差。

4. **`conjugate` 未声明为 `const func`**（轻微）——OOD §3.11 line 779 详细论证其可 const 化（与阶段一 Vec3 `negative` 函数、阶段二 Mat 家族 `negative` 模式一致）；建议补充 `const` 修饰符。

5. **任务派发描述 `cross` 公式与 GLM 1.0.3 实际实现不符**（一般）——scope.md 中给出的 w=0 公式实为「Vec3 叉乘扩展到 Quat.w=0」的几何意义变体，**非** GLM 1.0.3 实现的 `cross` 函数；建议修正任务描述。

上述问题均**不阻塞**阶段三发布（无运行时逻辑错误、无崩溃风险），属于「API 形态与 OOD 文档双向同步 + 约束收紧策略一致性」类清理项。建议在阶段三文档冻结前完成 OOD 文档与 `quaternion_common.cj`/`quaternion_geometric.cj` 实现的同步修订，并将上述差异纳入 `docs/deviations.md` 暂存记录。
