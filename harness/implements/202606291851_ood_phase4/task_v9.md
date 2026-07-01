# 任务指令（v9）

## 动作
NEW

## 任务描述
实现 Batch B-1：新建 4 个 gtc 模块源文件及对应测试文件（packing/ulp/round/type_precision）。

## 文件清单

### A. 新建源文件（4 个文件）

| 文件 | 实现要点 |
|------|---------|
| `src/gtc/packing.cj` | 浮点数据打包/解包函数。使用 `toBits()`/`fromBits()` 位操作。函数清单：packUnorm1x8/2x8/4x8, packUnorm1x16/2x16/4x16, unpackUnorm 对应, packSnorm 系族, unpackSnorm 系族, packHalf1x16/2x16/4x16, unpackHalf 系族, packDouble2x32/unpackDouble2x32。共 ~27 个具体类型重载（非泛型）。包名：`glm.gtc`。详见 OOD 设计 §3.3  packing.cj 完整签名清单。 |
| `src/gtc/ulp.cj` | ULP 浮点比较函数。具体类型重载（Float32 + Float64，不使用泛型）。函数清单：`next_float(x: Float32): Float32`、`next_float(x: Float64): Float64`、`prev_float` 对应重载、`float_distance(x: Float32, y: Float32): Int32`、`float_distance(x: Float64, y: Float64): Int64`、`ulp(x: Float32): Float32`、`ulp(x: Float64): Float64`。共 8 个函数。内部使用 `toBits()`/`fromBits()` 操作浮点位模式。包名：`glm.gtc`。 |
| `src/gtc/round.cj` | 浮点数舍入/取整函数（与 common.cj round 互补，侧重 2 的幂）。函数：`roundPowerOfTwo<T>(x: T): T where T <: FloatingPoint<T>`、`ceilPowerOfTwo`、`floorPowerOfTwo`、`roundMultiple<T>(x: T, multiple: T): T where T <: FloatingPoint<T>`、`ceilMultiple`、`floorMultiple`。共 6 个泛型函数。包名：`glm.gtc`。详见 OOD 设计 §3.3  round.cj 边界行为表。 |
| `src/gtc/type_precision.cj` | 高精度类型别名定义。~100 个 type 别名：fvec1~fvec4、dvec1~dvec4、ivec2~ivec4/uvec2~uvec4、i8~i64/u8~u64 向量系族、hvec1~hvec4、fmat2x2~fmat4x4/dmat2x2~dmat4x4、fquat/dquat/hquat。使用 `type fvec2 = Vec2<Float32, PackedHighp>` 语法。包名：`glm.gtc`。无需额外实现逻辑。 |

### B. 新建测试文件（3 个测试文件）

| 测试文件 | 说明 |
|---------|------|
| `tests/glm/gtc/packing_test.cj` | pack → unpack 互逆验证。每个系族选 1~2 个典例：packUnorm4x8 + unpackUnorm4x8（边界 0/1）、packSnorm4x8 + unpackSnorm4x8（边界 -1/1）、packHalf1x16 + unpackHalf1x16（Float32↔Float16 位模式）、packDouble2x32 + unpackDouble2x32 互逆。 |
| `tests/glm/gtc/ulp_test.cj` | next_float(1.0) - 1.0 == 2^-23（Float32）验证。float_distance(x, next_float(x)) == ±1。ulp(1.0) == 2^-23、ulp(Inf/NaN/零值) 边界验证。 |
| `tests/glm/gtc/round_test.cj` | roundPowerOfTwo/ceilPowerOfTwo/floorPowerOfTwo 各 3 用例（零值、2 的幂、非 2 的幂）。roundMultiple 倍数边界。NaN/Inf/零值/负数输入行为验证。 |

## 选择理由
Batch B 剩余 6 个 gtc 新模块。按复杂度拆分为两批：
- 本批（R9）：packing（位操作，具体类型）、ulp（位操作，具体类型）、round（6 个泛型函数）、type_precision（纯别名定义）。这些模块相互独立，简短直接，可并行编码。
- 下批（R10）：noise（~500-800 行算法迁移）、random（ThreadLocal 引擎管理）+ lib.cj 更新 + 编译验证。

## 任务上下文

### 已有代码上下文
**已就绪的依赖项**：
- `glm.detail` 包：Vec1~Vec4 类型、Mat2x2~Mat4x4 类型、Quat 类型、common.cj（133 函数完整）、exponential.cj（35 函数完整）、trigonometric.cj（75 函数完整）、matrix.cj（determinant/inverse 完整）、geometric.cj（完整）
- `glm.ext` 包：scalar_common.cj、vector_common.cj、quaternion_common.cj、quaternion_trigonometric.cj、quaternion_transform.cj、matrix_transform/clip_space/projection 全部完整
- `glm.gtc` 包：constants.cj、quaternion.cj、matrix_transform.cj、matrix_inverse.cj、matrix_access.cj 全部完整（R8 完成）
- `glm` 包：lib.cj（当前层导入基础函数和部分 gtc 函数）

**当前测试状态**：435 tests 全部通过。

### 关键实现约束
1. **packing.cj**：使用具体类型重载（`Float32`、`UInt32`、`UInt16`、`UInt8` 等），不泛型化。使用 `Float32.toBits(): UInt32`、`UInt32.fromBits(bits: UInt32): Float32`（及其 Float16/Float64/UInt16/UInt8 对应）进行位操作。packUnorm：`round(clamp(v, 0, 1) * maxVal)`。packSnorm：`round(clamp(v, -1, 1) * maxVal)`。packHalf：Float32↔Float16 位模式转换，对应 toBits/fromBits 操作。
2. **ulp.cj**：具体类型重载（Float32 + Float64），不使用 `FloatingPoint<T>` 泛型（因其不提供 `toBits()`/`fromBits()` 方法）。`next_float` 正数：`fromBits(toBits(x) + 1u)`，负数：`fromBits(toBits(x) - 1u)`。`prev_float` 相反。`float_distance` 返回有符号差值。`ulp(x)` = `next_float(x) - x`，对非规格化数返回最小正数。
3. **round.cj**：泛型 `T <: FloatingPoint<T>`。`floorPowerOfTwo` 通过指数提取实现，`ceilPowerOfTwo` 通过 `floorPowerOfTwo` 后移位，`roundPowerOfTwo` 四舍五入到最近 2 的幂。`roundMultiple` = `multiple * round(x / multiple)`。
4. **type_precision.cj**：纯 type alias，无运行时行为。使用 `type myAlias = UnderlyingType` 语法（仓颉类型别名）。包 `glm.gtc` 中定义，通过 `public import glm.gtc.{...}` 暴露。
5. **lib.cj 修改不在本批范围**：留待 R10（最后一批）统一处理。

### 参考实现来源
GLM 1.0.3 对应文件：
- `gtc/packing.hpp + .inl` → gtc/packing.cj
- `gtc/ulp.hpp + .inl` → gtc/ulp.cj
- `gtc/round.hpp + .inl` → gtc/round.cj
- `gtc/type_precision.hpp` → gtc/type_precision.cj

## 修订说明（v9 r1）
| 审查意见 | 修改措施 |
|---------|---------|
| 未提及需求中的仓库状态记录要求（requirement.md 第3项） | 在 plan.md R9 条目中补充"前置步骤"说明，要求实施者工作开始前执行 git status 记录未提交变更 |
| 未提及需求中的偏差记录要求（requirement.md 第1项） | 在 plan.md R9 条目中补充"偏差记录提醒"，要求实施者遇到仓颉语言限制时按 docs/deviations.md 规范记录偏差 |
