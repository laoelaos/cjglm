# R3-2: gtc/constants.cj 与 gtc/quaternion.cj 审查

审查时间：2026-06-27 16:46

### 审查范围

| 文件 | 行数 | 职责 |
|------|------|------|
| `cjglm/src/gtc/constants.cj` | 31 | `glm.gtc` 包 28 个数学常量函数 |
| `cjglm/src/gtc/quaternion.cj` | 48 | `glm.gtc` 包四元数扩展（4 完整实现 + 7 stub + 4 重导出） |

参考基线：
- `cjglm/src/detail/scalar_constants.cj`（标量常量 `pi<T>()`/`epsilon<T>()`/`cos_one_over_two<T>()`，阶段三 R3 已审查）
- `cjglm/src/detail/type_quat_cast.cj`（被 `quatCast` 重导出的源实现，阶段三 R1 已审查）
- `cjglm/src/detail/type_quat.cj`（`Quat<T, Q>` 结构体定义）
- `cjglm/src/lib.cj:10`（同模式 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}`，阶段一已稳定）
- `docs/05_ood_phase3.md` §3.12（gtc/constants）、§3.15（gtc/quaternion）
- `cangjie-lang-features/package/README.md` line 99（包间循环依赖禁止）、line 156-166（public import 重导出语法）

### 发现

#### [一般] gtc/quaternion.cj 依赖声明与 OOD §3.15 不一致：缺少 ext 包的两项 import

- **位置**：`cjglm/src/gtc/quaternion.cj:1-4`
- **描述**：OOD §3.15 line 1274-1279 明确声明 `gtc/quaternion.cj` 的依赖包括：
  ```
  import glm.ext.vector_relational.*   // 引用 equal（用于 roll/pitch 的 equal(vec2, vec2, 0) 边界检测）
  import glm.ext.scalar_constants.*   // 引用 epsilon<T>()
  ```
  当前实现（line 1-4）仅含：
  ```cangjie
  package glm.gtc
  import glm.detail.*
  import std.math.FloatingPoint
  public import glm.detail.{mat3Cast, mat4Cast, quatCast}
  ```
  **缺失** `import glm.ext.vector_relational.*` 和 `import glm.ext.scalar_constants.*` 两项。
- **判断**：当前实现可编译通过，因 7 个 stub 函数体均为 `throw Exception("stub")`，未实际引用 `equal` / `epsilon<T>()`。但 OOD 明文规定这两项为预期依赖，缺少会导致：
  1. 阶段四实现 `roll`/`pitch` 函数体（依赖 `equal`/`epsilon<T>()`）时需再次修改本文件，违反 OOD §4.3 「(a) stub 函数签名在阶段四保持不变」（OOD line 1403）——**实际**该项约束的是**签名模板**，import 调整属于依赖扩展，不严格违反，但 OOD 已规划在阶段三阶段就声明依赖。
  2. 当前 `import glm.detail.*` 通配符隐式引入了 `Quat`/`Vec3`/`Vec4`/`Mat3x3`/`Mat4x4`，依赖面足够支撑 stub 函数签名，但 ext 包符号未引入。
- **建议**：在 `quaternion.cj` line 3 后追加 `import glm.ext.vector_relational.*` 与 `import glm.ext.scalar_constants.*` 两行，与 OOD §3.15 line 1274-1279 保持一致。改动量 2 行，零风险（仅扩展 import 列表，不影响 stub 函数体行为）。

#### [一般] gtc/quaternion.cj 的 4 个比较函数 Vec4 构造调用缺少显式类型参数

- **位置**：`cjglm/src/gtc/quaternion.cj:8, 12, 16, 20`
- **描述**：4 个比较函数实现统一采用 `Vec4(x.x < y.x, x.y < y.y, x.z < y.z, x.w < y.w)` 形式（无显式 `<Bool, Q>` 类型参数），依赖编译器从返回类型 `Vec4<Bool, Q>` 反向推断 Vec4 构造的类型实参：
  ```cangjie
  public func lessThan<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>): Vec4<Bool, Q>
    where T <: Comparable<T>, Q <: Qualifier
    { Vec4(x.x < y.x, x.y < y.y, x.z < y.z, x.w < y.w) }
  ```
- **判断**：
  1. **正确性**：可编译通过。`Vec4(...)` 的 4 个实参类型均为 `Bool`（`<` 比较结果），类型 T 由实参推断为 `Bool`；类型 Q 由返回类型上下文传播。`T <: Comparable<T>` 约束保证 `<` 运算符在 `T = Int64` 等类型上合法（`test_quaternion.cj:8-9` 已用 `Int64` 实例化验证）。
  2. **可读性**：相比 `Vec4<Bool, Q>(...)` 显式写法，缺少类型实参对审查者不友好，且对仓颉编译器推断顺序敏感（如果未来函数体扩展增加中间表达式，可能推断失败）。
  3. **OOD 一致性**：OOD §3.15 line 1242-1245 给出的 4 个比较函数签名模板均使用 `Vec4<Bool, Q>(...)` 显式类型实参。**当前实现与 OOD 模板不完全一致**（OOD 示例更显式）。
- **建议**：将 4 个比较函数中的 `Vec4(...)` 改为 `Vec4<Bool, Q>(...)`（4 处，每处 4 行重复）。变更后与 OOD line 1242-1245 完全对齐，提升可读性并消除对编译器推断顺序的依赖。零功能影响。

#### [轻微] gtc/constants.cj 的 28 个常量函数全部通过 Float64 中转，对 Float32/Float16 精度未特化

- **位置**：`cjglm/src/gtc/constants.cj:4-31`（全部 28 个函数）
- **描述**：所有常量函数统一使用 `(Float64(VALUE) as T).getOrThrow()` 模式：以 `Float64` 字面量为源，通过 `as` 类型转换至目标 `T`（`T <: FloatingPoint<T>`）。对 `T = Float32` 实例化时，精度由 Float64 截断至 Float32（约 7 位有效数字）；对 `T = Float16` 截断至 Float16（约 4 位有效数字）。
- **判断**：
  1. **正确性**：与 GLM 1.0.3 行为一致——GLM `gtc/constants.inl` 对所有 `genType` 返回同一字面量，截断由赋值时类型转换完成。当前实现的预截断提前到字面量阶段，语义等价。
  2. **测试匹配**：`test_constants.cj` 的 `@Expect(two_pi<Float32>(), Float32(6.2831853071795864769))` 用 Float32 字面量（自动截断）作为期望值，与实现产出完全一致。
  3. **微小精度损失**：对 `Float16` 实例化（如 `third<Float16>()`），截断后仅保留 ~4 位有效数字，与直接提供 Float16 字面量（如 `Float16(0.3333h)`）结果完全一致，但失去可读性。
- **建议**：当前实现是合理工程取舍（避免 28 × 3 = 84 个具体类型分支），**保留**。如未来追求 Float16 精度可特化，但与 GLM 行为仍等价，**不阻塞审查通过**。

#### [轻微] 任务派发描述与 OOD 范围存在偏差：`pi<T>()` / `epsilon<T>()` / `cos_one_over_two<T>()` 不在 gtc/constants.cj

- **位置**：任务派发描述 + 本轮审查重点中提及的「`pi<T>()` 应等于 `std.math.pi`，`e<T>()` 应等于 `std.math.e`」等表述
- **描述**：本轮任务派发描述将 `pi<T>()` / `epsilon<T>()` / `cos_one_over_two<T>()` 列为 `gtc/constants.cj` 应包含的常量，并要求验证 `pi<T>() == std.math.pi`、`e<T>() == std.math.e`。但 OOD §3.12 line 819-820 明确规定 `gtc/constants.cj` 仅提供 28 个常量函数（不包含 `pi<T>()`），而 `pi<T>()` / `epsilon<T>()` / `cos_one_over_two<T>()` 实际位于 `detail/scalar_constants.cj`（line 5-22），通过 `ext/scalar_constants.cj:2` `public import glm.detail.{epsilon, pi, cos_one_over_two}` 重导出至 ext 命名空间。
- **判断**：
  1. **当前实现正确遵循 OOD**：`gtc/constants.cj` 的 28 个常量函数清单与 OOD line 820 严格一致（已逐项核对：zero/one/two_pi/tau/root_pi/half_pi/three_over_two_pi/quarter_pi/one_over_pi/one_over_two_pi/two_over_pi/four_over_pi/two_over_root_pi/one_over_root_two/root_half_pi/root_two_pi/root_ln_four/e/euler/root_two/root_three/root_five/ln_two/ln_ten/ln_ln_two/third/two_thirds/golden_ratio = 28 个 ✓）。
  2. **`e<T>()` 函数名语义**：当前 `gtc/constants.cj:21` 的 `e<T>()` 是自然常数 e（≈ 2.71828...），与 OOD 描述一致。任务派发中的「`e<T>()` 应等于 `std.math.e`」是合理的关联性检查——`e<T>()` 返回值与 `FloatingPoint<T>.getE()` 标准库值一致（GLM `gtc/constants.inl` 也直接硬编码 `2.71828182845904523536`，与 `Float64.getE()` 精度一致）。
  3. **`std.math.pi`/`std.math.e` 不存在**：仓颉 std.math 不提供 `std.math.pi` / `std.math.e` 顶层常量，仅 `FloatingPoint<T>.getPI()` / `FloatingPoint<T>.getE()` 静态方法（依据 `cangjie-std/math/README.md` line 111-116 仅列举 `Float64.NaN/Inf/Max/Min`，无 pi/e 顶层常量）。任务派发中的对照基准描述不准确。
- **建议**：
  1. **无需修改代码**——实现严格遵循 OOD。
  2. **建议修订任务派发描述**：将「`pi<T>()` 应等于 `std.math.pi`，`e<T>()` 应等于 `std.math.e`」修订为「`gtc/constants.cj` 的 28 个常量函数清单应与 OOD §3.12 line 820 一致；`pi<T>()` / `epsilon<T>()` / `cos_one_over_two<T>()` 位于 `detail/scalar_constants.cj`，不在本文件范围」；如需验证 e 常量精度，可对比 `e<T>() == FloatingPoint<T>.getE()`。

#### [轻微] `Vec4<Bool, Q>(...)` 显式类型实参测试期望与实现中省略类型实参的形式存在细微不一致

- **位置**：`cjglm/tests/glm/gtc/test_quaternion.cj:11, 19, 27, 35, 45`（测试侧使用 `Vec4<Bool, Defaultp>(...)`）；`cjglm/src/gtc/quaternion.cj:8, 12, 16, 20`（实现侧使用 `Vec4(...)`）
- **描述**：测试断言使用显式类型实参 `@Expect(r, Vec4<Bool, Defaultp>(true, true, true, true))`，而 4 个比较函数实现使用 `Vec4(...)` 无类型实参（依赖返回类型上下文推断）。
- **判断**：
  1. **测试可编译**：测试侧 `r` 的类型已由 `lessThan` 签名声明为 `Vec4<Bool, Defaultp>`，`@Expect` 的期望值使用相同显式类型实参，类型匹配 ✓。
  2. **实现侧依赖反向推断**：实现侧 `Vec4(...)` 必须依赖返回类型 `Vec4<Bool, Q>` 反向推断 T=Bool、Q 来自函数签名。如果未来函数体扩展增加中间表达式或 lambda 闭包，可能引入推断歧义。
- **建议**：与 [一般] 第 2 项关联——修复实现侧 `Vec4(...)` → `Vec4<Bool, Q>(...)` 后，本项不一致自动消除，无需单独处理。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 0 |
| 一般 | 2 |
| 轻微 | 3 |

### 总评

本轮审查的 `cjglm/src/gtc/constants.cj`（31 行，28 个常量函数）与 `cjglm/src/gtc/quaternion.cj`（48 行，4 比较 + 7 stub + 4 重导出）**总体实现质量良好**，严格遵循 OOD §3.12 与 §3.15 的设计意图：

**constants.cj 优点**：
- 28 个常量函数清单与 OOD §3.12 line 820 完全一致（zero/one/two_pi/tau/root_pi/half_pi/three_over_two_pi/quarter_pi/one_over_pi/one_over_two_pi/two_over_pi/four_over_pi/two_over_root_pi/one_over_root_two/root_half_pi/root_two_pi/root_ln_four/e/euler/root_two/root_three/root_five/ln_two/ln_ten/ln_ln_two/third/two_thirds/golden_ratio）
- 所有函数统一使用 `where T <: FloatingPoint<T>` 约束，符合 OOD §3.12 line 805 约束收紧策略
- 实现模式 `(Float64(VALUE) as T).getOrThrow()` 与 OOD §1「T(Float64(n)) 字面量替代路径」一致（`as T` 与 `T(Float64(n))` 在 FloatingPoint 接口约束下语义等价）
- 测试覆盖充分：`test_constants.cj` 共 56 个用例（28 函数 × Float32/Float64 双类型），与 OOD §3.12 line 821 「至少 28 个测试用例」要求超额覆盖

**quaternion.cj 优点**：
- 4 个比较函数实现正确，使用 `T <: Comparable<T>` 约束，对 `Int64`/`Float64` 等 `Comparable<T>` 类型均可实例化
- 7 个 stub 函数（`eulerAngles`/`roll`/`pitch`/`yaw`/`quatLookAt`/`quatLookAtRH`/`quatLookAtLH`）签名模板与 OOD §3.15 line 1263-1271 完全一致，函数体统一为 `{ throw Exception("stub") }`，符合 OOD §4.3 「stub 函数签名在阶段四保持不变」约束
- 4 个转换函数重导出 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 语法合法（依据 `cangjie-lang-features/package/README.md` line 156-166），与 `cjglm/src/lib.cj:10` 同模式已稳定运行；保持 `glm.gtc → glm.detail` 单向依赖，无循环依赖（OOD §3 line 96-97 D28）
- 包间依赖方向正确：`glm.gtc` 单向依赖 `glm.detail`，无 `glm.detail → glm.gtc` 反向引用，验证 OOD §3.15 D11「消除包间循环依赖」设计意图
- 测试覆盖：`test_quaternion.cj` 共 11 个用例（4 比较 + 4 等值边界 + 7 stub `assertThrows`），符合 OOD §8.2 测试覆盖要求

**主要改进方向**：
1. **gtc/quaternion.cj 依赖声明补全**：追加 `import glm.ext.vector_relational.*` 和 `import glm.ext.scalar_constants.*` 两行，与 OOD §3.15 line 1274-1279 保持一致，为阶段四实现 `roll`/`pitch` 函数体（依赖 `equal`/`epsilon<T>()`）提供前置 import 基础。
2. **gtc/quaternion.cj 4 个比较函数显式类型实参**：将 `Vec4(...)` 改为 `Vec4<Bool, Q>(...)`，与 OOD §3.15 line 1242-1245 模板完全一致，消除对编译器反向推断的依赖。
3. **任务派发描述澄清**：`pi<T>()` / `epsilon<T>()` / `cos_one_over_two<T>()` 不在 `gtc/constants.cj` 范围（位于 `detail/scalar_constants.cj`），实现严格遵循 OOD，无需修改代码。

**总评**：本轮审查未发现严重或阻塞性问题，2 项一般问题均为可读性/依赖声明对齐性微调，3 项轻微问题均为文档层面澄清或风格改进。代码质量达到阶段三交付标准。