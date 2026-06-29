# R3: 标量-四元数运算与标量常量审查

审查时间：2026-06-27

### 审查范围

| 文件 | 行数 | 职责 |
|------|------|------|
| `cjglm/src/detail/scalar_quat_ops.cj` | 27 | 标量-四元数运算（`add`/`sub`/`mul`/`div`） |
| `cjglm/src/detail/scalar_constants.cj` | 36 | 标量常量（`epsilon<T>()`/`pi<T>()`/`cos_one_over_two<T>()`） |

参考基线：
- `cjglm/src/detail/scalar_vec_ops.cj`（阶段一命名风格参照）
- `cjglm/src/detail/setup.cj`（GLM_CONFIG_* 常量）
- `cjglm/src/detail/shim_limits.cj`（`epsilonOf<T>(hint)` 实现）
- `docs/05_ood_phase3.md` §3.11（scalar_quat_ops）+ §3.12（scalar_constants）
- `docs/deviations.md` DV-04（`epsilonOf`/`isIec559Of` hint 参数）

### 发现

#### [一般] `cos_one_over_two<T>()` 取值与 OOD §3.12「具体类型硬编码」策略不一致

- **位置**：`cjglm/src/detail/scalar_constants.cj:24-35`
- **描述**：OOD §3.12 line 806 明确规定 `pi<T>()` 与 `cos_one_over_two<T>()`「同理使用具体类型硬编码值」——即 `Float32`/`Float64` 应直接返回各自类型的字面量。当前 `pi<T>()` 实现（line 12-21）实际采用 `Float64.getPI()`/`Float32.getPI()`/`Float16.getPI()` 静态方法而非硬编码字面量（如 `3.14159265358979323846`），与 OOD 描述偏差。
  - **判断**：`pi<T>()` 实际调用 `FloatingPoint<T>.getPI()` 接口是**更优实现**（标准库对每个类型已精度调优，避免重复硬编码易出错的 π 值）。`cos_one_over_two<T>()` line 27/30/33 的字面量 `0.877582561890372716` 是 GLM `cos_one_over_two`（即 `cos(0.5 rad)`）的精确值，符合 OOD 描述。
  - **偏差性质**：实现优于 OOD 设计文档，但与文档字面承诺不一致。该偏差未在 `docs/deviations.md` 中登记。
- **建议**：
  1. 方案 A（推荐）：保留当前 `pi<T>()`/`cos_one_over_two<T>()` 实际行为，在 `docs/deviations.md` 新增条目（如 DV-XX：`pi<T>()` 委托 `FloatingPoint<T>.getPI()` 而非硬编码 π 值），注明实际行为与 OOD §3.12 描述的偏差及理由。
  2. 方案 B：将 OOD §3.12 line 806 中「同理使用具体类型硬编码值」修订为「同理：pi 优先委托 `FloatingPoint<T>.getPI()` 标准库方法，cos_one_over_two 使用具体类型硬编码值」。

#### [一般] 任务描述中 `cos_one_over_two` 语义存在数学事实错误，需复核任务派发

- **位置**：`harness/reviews/202606271542_glm_phase3_review/scope.md`（任务派发）以及本轮审查重点中
- **描述**：本轮任务描述指出「GLM 中此常量为 `0.5 * cos(0.5) ≈ 0.87758…`」，该描述**与实际 GLM 1.0.3 `scalar_constants.inl` 不一致**：
  - GLM 1.0.3 `scalar_constants.inl:74` 定义：`return genType(0.87758256189037271611628658211901570552574150604983);`
  - 该值精确等于 `cos(0.5 rad)` ≈ 0.8775825618903728，而非 `0.5 * cos(0.5)` ≈ 0.4387912809451864
  - GLM 命名 `cos_one_over_two` 的语义为「`cos` of `one_over_two` (radian)」，即 `cos(1/2)`，而非「`0.5 * cos(0.5)`」。
- **影响判断**：当前实现 `scalar_constants.cj:27/30/33` 硬编码 `0.877582561890372716` 与 GLM 实际值**完全一致**（即 `cos(0.5)`），实现本身**正确**。问题在于任务描述/审查重点的事实陈述错误，可能误导后续审查者或迁移用户。
- **建议**：在 `scope.md` 中纠正 `cos_one_over_two` 的描述为「GLM `cos(1/2 rad)` ≈ 0.8775825618903728」；实施侧无需修改代码。

#### [一般] `scalar_constants.cj` 缺少 OOD §3.12 line 805 约定的非浮点类型运行时异常 fallback

- **位置**：`cjglm/src/detail/scalar_constants.cj:5-35`
- **描述**：OOD §3.12 line 805 约定「若仓颉泛型不支持窄约束，则在 `match` 中增加 `case _ => throw Exception("epsilon/pi/cos_one_over_two not defined for non-floating-point types")` 显式错误分支」。当前三个函数均**缺少**该 fallback：
  - `epsilon<T>()` (line 5-8)：依赖 `epsilonOf<T>(hint)` 内部 `match` 分派，对非浮点 T 走 `hint - hint` 降级路径返回零值（与 shim_limits.cj:13 一致）。
  - `pi<T>()` (line 10-22)：三个 `if` 分支均不匹配时**默认 fall-through 至 `Float64.getPI()` 返回**，不抛异常。
  - `cos_one_over_two<T>()` (line 24-35)：同样默认 fall-through 至 `Float64(0.877582561890372716)` 返回，不抛异常。
- **影响**：当前 `FloatingPoint<T>` 约束已限制 T 仅可为 Float16/Float32/Float64（标准库文档确认 `FloatingPoint<T>` 仅由这三个类型实现），fallback 实际不可触发。**但**：`pi<T>()` 与 `cos_one_over_two<T>()` 对所有 `if` 分支均不匹配的情形（如自定义实现 `FloatingPoint<T>` 的类型）静默返回 Float64 值，与 OOD 契约「非浮点类型抛运行时异常」存在偏差。
- **建议**：保留当前实现（约束已保证 `FloatingPoint<T>` 适用），但建议：
  1. 在 OOD §3.12 line 805 补充一行：「当前实现因 `FloatingPoint<T>` 约束生效而省略 fallback；下游若放宽约束需补回 `case _ => throw Exception(...)`」，消除文档与实现的隐含矛盾。
  2. 或者在三个函数末尾追加 `throw Exception("epsilon/pi/cos_one_over_two not defined for type ${typeof<T>()}")` 防御性分支，确保未预期的 T 实例化能显式报错（当前静默返回 Float64 行为可能掩盖上游约束/导入错误）。

#### [一般] `pi<T>()` 与 `cos_one_over_two<T>()` 未利用 `FloatingPoint<T>` 接口的静态方法

- **位置**：`cjglm/src/detail/scalar_constants.cj:10-22`（`pi<T>()`）
- **描述**：标准库 `FloatingPoint<T>` 接口（依据 `cangjie-original-docs/std/math/math_package_api/math_package_interfaces.md` line 5-17）声明 6 个静态方法：`getE()` / `getInf()` / `getPI()` / `getMinDenormal()` / `getMinNormal()` / `getNaN()`。当前 `pi<T>()` 实现（line 10-22）通过 3 次 `hint is FloatXX` 运行时类型分派分别调用 `Float64.getPI()`/`Float32.getPI()`/`Float16.getPI()`，可简化为一行业务逻辑：
  ```cangjie
  public func pi<T>(): T where T <: FloatingPoint<T> {
      FloatingPoint<T>.getPI()
  }
  ```
- **优势**：
  1. 减少 4 行重复类型分派代码（line 11 hint 构造 + line 12-20 三个 `if` 分支 + line 21 fall-through）
  2. 编译期类型分发替代运行时 `is` 判定（消除运行时分派开销）
  3. 自动支持 `FloatingPoint<T>` 接口的任意实现类型（当前实现仅显式处理 3 种）
- **建议**：
  - 方案 A（推荐）：将 `pi<T>()` 实现替换为 `FloatingPoint<T>.getPI()` 调用，并在 `deviations.md` 中记录与 OOD §3.12「具体类型分派」描述的偏差。
  - 方案 B：保留当前实现，在 OOD §3.12 line 806 追加注释说明「实现选择运行时分派以兼容未来扩展」。
- **不影响正确性**：当前实现运行结果与 `FloatingPoint<T>.getPI()` 完全一致（均返回标准库精度调优值）。

#### [轻微] `cos_one_over_two<T>()` 对 Float32/Float16 使用从 Float64 截断的硬编码值

- **位置**：`cjglm/src/detail/scalar_constants.cj:30`（Float32）、`scalar_constants.cj:33`（Float16）
- **描述**：Float32 分支 `Float32(0.877582561890372716)` 与 Float16 分支 `Float16(0.877582561890372716)` 均从 Float64 字面量 `0.877582561890372716` 截断至目标类型精度：
  - `Float32(0.877582561890372716)` ≈ `0.87758255f`（保留 7 位有效数字）
  - `Float16(0.877582561890372716)` ≈ `0.8776h`（保留 4 位有效数字）
- **判断**：与 GLM 1.0.3 行为**一致**——GLM `scalar_constants.inl` 对所有 `genType` 返回同一字面量，截断由调用方赋值时的类型转换完成。当前实现的预截断提前到字面量阶段，语义等价。
- **建议**：可选优化——为 Float32/Float16 提供各自精度的独立字面量（如 `Float32(0.87758255f)`、`Float16(0.8776h)`），提高类型特异精度，但与 GLM 字面量级行为一致。**不阻塞审查通过**。

#### [轻微] `scalar_quat_ops.cj` 与 GLM 习惯的「交换律覆盖」偏差未在 deviations.md 登记

- **位置**：`cjglm/src/detail/scalar_quat_ops.cj:1-27`（整文件）
- **描述**：本文件实现 `T + Quat` / `T - Quat` / `T * Quat` / `T / Quat` 四个全局具名函数，对应 GLM 的四元数运算符覆盖。OOD §3.11 line 660 已明确说明此偏差——「标量×四元数乘法无需单独『交换律别名』函数，`T * Quat`（左操作数为 T）由于仓颉运算符重载规则必须通过全局函数 `mul<T, Q>(s: T, q: Quat<T, Q>)` 实现」。
- **判断**：实现严格符合 OOD §3.11 line 651-660 表格规范（函数签名、约束 `@OverflowWrapping`、约束 `T <: Number<T>`/`Q <: Qualifier`、构造顺序 `Quat(x, y, z, w)` 均一致），且 OOD 文档已将偏差根因（运算符归属规则）记入正文。
- **建议**：可选——将 OOD §3.11 line 660 的说明提升为 `deviations.md` 的独立偏差条目（如 DV-XX：标量-四元数运算因运算符重载规则采用全局函数而非 Quat 成员运算符），便于未来跨文件查找。**不阻塞审查通过**。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 0 |
| 一般 | 4 |
| 轻微 | 2 |

### 总评

本轮审查的 `scalar_quat_ops.cj`（27 行）与 `scalar_constants.cj`（36 行）总体**实现质量良好**，符合 OOD §3.11/§3.12 设计意图：

- **`scalar_quat_ops.cj`** 实现简洁、与阶段一 `scalar_vec_ops.cj` 命名约定一致（`add`/`sub`/`mul`/`div` 全部使用 `@OverflowWrapping` 修饰符 + `Number<T>` 约束 + `Qualifier` 约束）、构造顺序 `Quat(x, y, z, w)` 与 `type_quat.cj:13` 主构造函数严格对齐。
- **`scalar_constants.cj`** 三个常量函数功能正确：
  - `epsilon<T>()` 委托 `epsilonOf<T>(hint)`（`shim_limits.cj:25`）复用阶段二实现，与 deviations.md DV-04 hint 参数风格一致
  - `pi<T>()` 使用 `FloatingPoint<T>.getPI()` 静态方法（优于硬编码 π 值）
  - `cos_one_over_two<T>()` 硬编码值 `0.877582561890372716` 与 GLM `cos(0.5 rad)` 一致（**注意：任务派发描述中 `0.5 * cos(0.5)` 是数学事实错误，实现正确**）

**主要改进方向**：建议将 `pi<T>()`/`cos_one_over_two<T>()` 的运行时类型分派简化为 `FloatingPoint<T>` 接口调用，并在 `deviations.md` 补充相关偏差登记；同时修正任务派发中的 `cos_one_over_two` 数学语义错误（GLM 中为 `cos(0.5)`，非 `0.5 * cos(0.5)`）。