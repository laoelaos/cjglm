# 阶段三 OOD 设计 v10 质量审查报告

> **审查轮次**：第 6 轮
> **审查对象**：`a_v6_copy_from_v5.md`（文档内部版本号 v10）
> **审查日期**：2026-06-25
> **审查维度**：需求响应充分度、整体深度和完整性、设计可落地性（避免与内部审议已确认的技术可行性维度重复）

## 审查概述

本轮审查对象为阶段三 OOD 设计文档 v10 版，该产出已通过组件 A 内部审议的多轮迭代（v2 → v10 共 9 轮，累计处理 51 项历史意见）。本轮审查侧重内部审议未充分覆盖的维度。

本轮共识别 **2 项严重 + 6 项一般 + 5 项轻微 = 13 项**质量问题。所有问题均经过 GLM 1.0.3 源码、仓颉 stdlib API 文档、阶段二已有代码的事实核查。

---

## 严重问题（2 项）

### 问题 1：§3.13 trigonometric.cj 函数签名缺少 T 约束声明

**问题描述**：§3.13.1 trigonometric.cj 函数清单中，14 个单参数三角函数（sin/cos/tan/asin/acos/atan/sinh/cosh/tanh/asinh/acosh/atanh/radians/degrees）+ 1 个双参数 atan2 共 15 个函数，签名模板 `sin<T>(x: T): T`、`sin<T, Q>(x: VecN<T, Q>): VecN<T, Q>` 等均无 `where` 子句约束。但函数体内部调用 `std.math.sin/cos/tan/asin/acos/atan/sinh/cosh/tanh/asinh/acosh/atanh/atan2`（仓颉 stdlib 数值函数，按 §1 设定仅支持 Float64 输入/输出）。下游实现 trigonometric.cj 时，T 为整数类型（Int8~Int64/UInt8~UInt64）将编译失败，且无 where 子句约束将导致：

- (a) 与 §3.2.1 `mat3Cast`/`mat4Cast`/`quatCast`（D32）、§3.11 `isnan`/`isinf`（D29）、§3.12 `epsilon<T>()`（D25）已统一为 `where T <: FloatingPoint<T>` 的约束策略不一致；
- (b) 下游编码者实现 trigonometric.cj 时对 T 约束决策无明确依据；
- (c) 与 §3.13.1 表头说明「所有 trigonometric.cj 函数在 T=Float32 实例化时需应用 `T(Float64.xxx(Float64(value)))` 转换模式」语义冲突——表头已隐含 T 受 `FloatingPoint<T>` 约束，但表行未明示。

**所在位置**：§3.13.1 trigonometric.cj 函数清单（行 573-596 附近）所有 15 个函数的标量签名与向量签名列

**严重程度**：严重

**改进建议**：§3.13.1 表头新增「**T 类型约束（v11 新增）**」段，并修订所有 15 个函数的签名模板：
- 标量版本：`sin<T>(x: T): T where T <: FloatingPoint<T>`
- 向量版本：`sin<T, Q>(x: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier`（VecN 展开为 Vec1/Vec2/Vec3/Vec4 后同理）

整数 T 实例化时编译期报类型不匹配（与 D25/D29/D32 策略一致）。表行「内部依赖」列对 `std.math.{func}` 调用统一追加「**T 必须为 FloatingPoint<T>**」标注。

### 问题 2：§3.7 normalize 实现描述未涵盖 GLM 零四元数保护行为

**问题描述**：经核查 GLM 1.0.3 `references/glm-1.0.3/glm/glm/ext/quaternion_geometric.inl:17-24`，`normalize` 函数实际实现包含零四元数保护：

```cpp
T len = length(q);
if(len <= static_cast<T>(0)) // Problem
    return qua<T, Q>::wxyz(static_cast<T>(1), static_cast<T>(0), static_cast<T>(0), static_cast<T>(0));
T oneOverLen = static_cast<T>(1) / len;
return qua<T, Q>::wxyz(q.w * oneOverLen, q.x * oneOverLen, q.y * oneOverLen, q.z * oneOverLen);
```

设计 §5.1 正确描述了「normalize 零四元数：返回单位四元数 identity(one)，其中 T(0) 通过 one - one 演算（与 GLM quaternion_geometric.inl:20-21 行为一致）」这一边界行为契约。但 §3.7 normalize 函数描述仅写「内部调用 length。可直接完整实现」，**未提及零四元数保护分支（line 20-21 `if(len <= 0) return identity`）**，下游编码者按 §3.7 实现 `q / length(q)` 时，零四元数将产生 NaN（与 §5.1 契约不符）。§3.7 与 §5.1 描述不自洽，§5.3 边界条件表也缺少 normalize 零四元数行。

**所在位置**：
- §3.7 normalize 函数描述（行 453 附近）
- §5.3 边界条件表（行 789-805 附近）缺少 normalize 零四元数行

**严重程度**：严重

**改进建议**：
1. §3.7 normalize 函数描述补充完整实现公式（与 GLM `quaternion_geometric.inl:17-24` 对齐）：`tmp1 = length(q); if (tmp1 <= T(Float64(0))) { return identity_q } else { return q / tmp1 }`（其中 identity_q 为 `Quat.wxyz(T(Float64(1)), T(Float64(0)), T(Float64(0)), T(Float64(0)))`，T(0) 通过 `T(Float64(0))` 字面量替代）
2. §5.3 边界条件表新增 2 行：
   - 「零四元数（浮点） | normalize(q) | 返回 `Quat(0, 0, 0, 1)` 单位四元数（与 GLM `quaternion_geometric.inl:20-21` 零除保护一致）」
   - 「length(q) 为极小值（如 < epsilon<T>()） | normalize(q) | `1/length(q)` 计算产生极大值，结果四元数分量精度严重损失」
3. §3.7 normalize 描述末尾新增「**实现策略（v11 补强）**」段，明确「采用 GLM 独立零除保护分支路径，不依赖 common.cj stub」

---

## 一般问题（6 项）

### 问题 3：§3.4 Quat×Vec3 运算符公式中 `QuatVector` 符号未定义

**问题描述**：§3.4 运算符体系表 Quat×Vec3 行（行 367 附近）实现公式为 `v + (cross(QuatVector, v) * q.w + cross(QuatVector, cross(QuatVector, v))) * T(Float64(2))`，但 `QuatVector` 在该公式中未定义。下游编码者按公式实现时，需先查阅 GLM `type_quat.inl:359-366` 推导 `QuatVector = Vec3(q.x, q.y, q.z)`（即 `vec<3, T, Q> const QuatVector(q.x, q.y, q.z)`），增加实现阻力。该公式是阶段三 `Quat×Vec3` 运算符的唯一算法描述来源（虽然阶段三调用抛 stub 异常，但 stage 4 实现时是直接依据），`QuatVector` 符号歧义直接影响编码正确性。

**所在位置**：§3.4 运算符体系表 Quat×Vec3 行备注列（行 367）

**严重程度**：一般

**改进建议**：§3.4 Quat×Vec3 行备注列补充完整公式定义：
```
QuatVector = Vec3(q.x, q.y, q.z)
uv = cross(QuatVector, v)           // 第一次 Vec3 叉乘
uuv = cross(QuatVector, uv)         // 第二次 Vec3 叉乘（嵌套 cross(QuatVector, uv)）
return v + (uv * q.w + uuv) * T(Float64(2))
```

或新增独立公式解读段，明确 `QuatVector` 语义。同步检查 §3.4 Quat×Vec4 行的 `Vec4(q * Vec3(v), v.w)` 公式中是否也存在类似符号歧义（`q * Vec3(v)` 内部调用 `Quat×Vec3` 路径）。

### 问题 4：§4.4 与 §11.4 调用示例命名空间前缀不一致

**问题描述**：§4.4 行为契约示例（行 747-754 附近）直接使用 `let m3 = mat3Cast(q)`、`let q = quatCast(m3)` 无命名空间前缀形式，并标注「[本阶段可验证]」。但 §11.4 v10 已明确说明「仓颉 detail 直接调用：需先 `import glm.detail.*` 才能调用包级函数」，并新增「仓颉顶层 glm 命名空间调用：`let m3_top = glm.mat3Cast(q)`」示例。下游按 §4.4 示例实现时，若未先 `import glm.detail.*` 则编译失败；§4.4 描述未对此做前置说明。

**所在位置**：
- §4.4 矩阵-四元数互转行为契约示例（行 747-754 附近）
- §11.4 迁移示例（行 1213-1233 附近）已通过 v10 修订明确路径

**严重程度**：一般

**改进建议**：§4.4 行为契约示例统一使用顶层 `glm` 命名空间调用形式：
```
let m3 = glm.mat3Cast(q)     // 四元数转 3×3 旋转矩阵 [本阶段可验证]
let m4 = glm.mat4Cast(q)     // 四元数转 4×4 旋转矩阵 [本阶段可验证]
let q = glm.quatCast(m3)     // 3×3 旋转矩阵转四元数 [本阶段可验证]

// gtc 命名空间下的同名 API（通过 public import 重导出，[本阶段可验证]）
let m3_gtc = glm.gtc.quaternion.mat3_cast(q)
let q_gtc = glm.gtc.quaternion.quat_cast(m3)
```

与 §11.4 v10 顶层 glm 命名空间调用示例对齐；§4.4 段首补充「前提：调用方已通过 lib.cj 完成 public import 间接访问」。

### 问题 5：§3.10 pow 函数 line 65/78 GLM 公式未翻译为仓颉等价

**问题描述**：§3.10 pow 函数依赖描述引用 GLM `quaternion_exponential.inl` 两处 pow 调用：
- line 65：`return qua<T, Q>::wxyz(pow(x.w, y), 0, 0, 0);`（w 分量实数降级路径）
- line 78：`T Mag = pow(magnitude, y - static_cast<T>(1));`（magnitude 缩放因子）

设计仅详细描述 line 65 的依赖（递归 `std.math.pow(Float64, Float64): Float64`），但：
- (a) 未提供 line 65 的仓颉等价翻译（GLM `wxyz(...)` 工厂函数参数顺序为 wxyz，仓颉版本主构造函数 `Quat(x, y, z, w)` 为 xyzw 顺序，下游编码者需自行推导等价形式）
- (b) 未提及 line 78 的 pow 调用与 `magnitude` 缩放逻辑

下游 stage 4 实现 pow 时，按设计字面照搬 line 65 的 `wxyz(pow(x.w, y), 0, 0, 0)` 需自行推导仓颉等价形式（`Quat.wxyz(...)` 或 `Quat(0, 0, 0, pow_result)`），增加实现阻力。

**所在位置**：§3.10 pow 函数依赖描述（行 497 附近）+ D21 设计决策（行 850 附近）

**严重程度**：一般

**改进建议**：
1. §3.10 pow 描述在 line 65 引用处补充仓颉等价实现：
   ```
   // GLM line 65: return qua<T,Q>::wxyz(pow(x.w, y), 0, 0, 0)
   // 仓颉等价: Quat<Float32, Q> 等价物
   //   Quat.wxyz(T(std.math.pow(Float64(x.w), Float64(y))), T(Float64(0)), T(Float64(0)), T(Float64(0)))
   //   或主构造: Quat(T(Float64(0)), T(Float64(0)), T(Float64(0)), T(std.math.pow(Float64(x.w), Float64(y))))
   ```
2. §3.10 pow 描述补充 line 78 引用：
   ```
   // GLM line 78: T Mag = pow(magnitude, y - static_cast<T>(1));
   // 仓颉等价: T Mag = T(std.math.pow(Float64(magnitude), Float64(y - T(1))))
   ```
3. D21 设计决策的「仓颉版本需明确」清单追加「line 65/78 pow 调用的仓颉翻译路径」。

### 问题 6：§3.10 pow 描述「递归调用 std.math.pow」措辞不准确

**问题描述**：§3.10 pow 函数依赖描述中「**命名消歧与 Float64 转换（v5 新增，v7 澄清，v10 合并）**」段写「递归调用 `std.math.pow(Float64, Float64): Float64`（实数降级路径）」。但经核查 GLM `quaternion_exponential.inl:65` 与 line 78，pow 函数体内部对 `std::pow` 的调用是**两次独立调用**（line 65 `pow(x.w, y)` + line 78 `pow(magnitude, y-1)`），并非 C++ 意义上的「递归」（pow 不调用 pow 自身）。「递归」措辞在 C++ 上下文中通常指函数自身调用，可能误导下游编码者认为 pow 存在 self-call 路径。

**所在位置**：§3.10 pow 函数描述「命名消歧与 Float64 转换」段（行 497 附近）

**严重程度**：一般

**改进建议**：将「递归调用 `std.math.pow(Float64, Float64): Float64`」修订为「**调用 `std.math.pow(Float64, Float64): Float64` 实数降级路径两次**（GLM `quaternion_exponential.inl:65` 与 line 78 各一次，分别用于 w 分量计算与 magnitude 缩放）」。v10 修订说明段同步更新。

### 问题 7：§1「std.math Float64-only」约束与仓颉 stdlib 实际 API 不一致

**问题描述**：§1「系统性设计约束（v8 新增）：Float32 与 std.math 的交互约束」段声明「仓颉 `std.math` 模块的数值函数（`sqrt`/`pow`/`log`/`exp`/`sin`/`cos`/`asin`/`acos`/`atan`/`sinh`/`cosh`/`tanh`/`asinh`/`acosh`/`atanh`/`radians`/`degrees` 等）**仅支持 Float64 输入/输出**（依据 `cangjie-std/math/README.md` 第 13 行）」。但核查仓颉 stdlib 详细 API 文档（`cangjie-original-docs/std/math/math_package_api/math_package_funcs.md`）：

- `sqrt`（行 5158、5196、5234）有 `Float16`/`Float32`/`Float64` 三个重载
- `sin`（行 4954、4988、5022）有 `Float16`/`Float32`/`Float64` 三个重载
- `cos`（行 1573、1607、1641）有 `Float16`/`Float32`/`Float64` 三个重载
- `tan`（行 5272、5306、5340）有 `Float16`/`Float32`/`Float64` 三个重载
- `asin`/`asinh`/`acosh`/`atanh`/`sinh`/`cosh`/`tanh` 均有 `Float16`/`Float32`/`Float64` 重载
- `pow`（行 4292、4328、4364、4400）有 `Float32`/`Float64` 重载（无 `Float16`）

`radians`/`degrees` 在 std.math 中**根本不存在**（详细 API 文档无此函数，README 也未列出）。

设计 §1 依据的简化 README（`cangjie-std/math/README.md`）仅展示 `sqrt/pow/log/exp` 等的 Float64 签名，与详细 API 文档存在差异。设计严格按 README Float64-only 设计，导致 §1「T(Float64.xxx(Float64(value)))」转换模式对 Float32 实例化场景可能过度设计——实际 std.math 对 Float32 有原生支持，可直接调用 `std.math.sqrt(Float32_value)` 而无需显式转换。

**所在位置**：
- §1「Float32 与 std.math 的交互约束」段（行 54-63 附近）
- §3.13.1 trigonometric.cj 表头说明（行 598 附近）

**严重程度**：一般

**改进建议**：
1. §1 「Float32 与 std.math 的交互约束」段修订为：「仓颉 `std.math` 模块的数值函数在 `cangjie-std/math/README.md` 简化文档中仅展示 `Float64` 签名，但详细 API 文档（`cangjie-original-docs/std/math/math_package_api/math_package_funcs.md`）显示 `sqrt`/`sin`/`cos`/`tan`/`asin`/`acos`/`atan`/`sinh`/`cosh`/`tanh`/`asinh`/`acosh`/`atanh` 等函数均提供 `Float16`/`Float32`/`Float64` 重载，`pow` 提供 `Float32`/`Float64` 重载。**简化策略（v11 新增）**：对 T = Float32 实例化场景，可直接调用 `std.math.{func}(Float32_value)` 而无需 `T(Float64.xxx(Float64(value)))` 显式转换；对 T = Float64 实例化场景维持现状。**风险提示**：`radians`/`degrees` 在 std.math 中**不存在**（详细 API 文档与 README 均未列出），trigonometric.cj 实现需使用硬编码 π 字面量路径，与 v10 修订一致」
2. §3.13.1 表头说明同步修订，删除「所有 trigonometric.cj 函数在 T=Float32 实例化时需应用 `T(Float64.xxx(Float64(value)))` 转换模式」的强制要求，改为「T=Float32 实例化时优先调用 std.math Float32 重载，仅当 std.math 未提供对应重载时（如 `pow` 在某些早期版本仅 Float64）才使用 Float64 转换 fallback 路径」

### 问题 8：§1 「FloatingPoint<T> 接口无任何实例方法」描述不准确

**问题描述**：§1 修订说明（v10）和 §3.10 多处声明「`FloatingPoint<T>` 接口本身**不提供任何实例方法**」或「**无任何实例方法**」（依据 `cangjie-std/math/README.md` 第 117 行仅作为类型约束声明）。但核查 `cangjie-original-docs/std/math/math_package_api/math_package_interfaces.md` 第 3-15 行，`FloatingPoint<T>` 接口实际声明：

```cangjie
public interface FloatingPoint<T> <: Number<T> {
    static func getInf(): T
    static func getMinDenormal(): T
    static func getMinNormal(): T
    static func getNaN(): T
    func isInf(): Bool          // 实例方法
    func isNaN(): Bool          // 实例方法
}
```

接口包含 2 个**实例方法**（`isInf()`/`isNaN()`）和 4 个**静态方法**（`getInf()`/`getMinDenormal()`/`getMinNormal()`/`getNaN()`）。设计 §3.11 `isnan`/`isinf` 函数实现确实使用实例方法 `q.x.isNaN()`（这是正确的），但 §1/§3.10 中「无任何实例方法」的描述与 stdlib 实际定义不符——即使 stdlib README 简化版仅展示约束声明，详细 API 文档明确定义了实例方法。

虽然对 `pow` 函数所需的 `getInf()`/`getMinNormal()`（静态方法）的可达性结论不变（设计上推荐类型分派 `if (q.x is Float32) { Float32.Inf }` 或 `FloatingPoint<Float32>.getInf()`，两者均可工作），但「**无任何实例方法**」的字面描述存在事实错误。

**所在位置**：
- §1 修订说明 v10 关于 `FloatingPoint<T>` 描述（多处）
- §3.10 log/pow 依赖描述（行 496-497 附近）
- D21 设计决策「**std::numeric_limits<T>::infinity() 等价物获取**」段（行 850 附近）
- §8 编码启动前验证项 13/16/18（行 993-998 附近）

**严重程度**：一般

**改进建议**：§1 / §3.10 / D21 / §8 验证项中「`FloatingPoint<T>` 接口本身无任何实例方法」措辞修订为：「`FloatingPoint<T>` 接口（详细定义见 `cangjie-original-docs/std/math/math_package_api/math_package_interfaces.md` 第 3-15 行）提供 `isInf()`/`isNaN()` 实例方法 + `getInf()`/`getMinDenormal()`/`getMinNormal()`/`getNaN()` 静态方法。其中 `pow`/`log` 函数所需的次正规数边界检查 / Infinity 常量可通过静态方法 `FloatingPoint<Float32>.getMinNormal()` / `FloatingPoint<Float64>.getInf()` 获取，或通过类型分派 `Float32.Min`/`Float32.Inf` 静态常量获取；两种路径均可在 `where T <: FloatingPoint<T>` 约束下编译通过。下游实现可根据需要选择路径」。D21 决策依据同步修订。

---

## 轻微问题（5 项）

### 问题 9：§3.15 比较函数实现细节未充分展开

**问题描述**：§3.15 gtc/quaternion.cj 完整实现函数段（行 656-659 附近）列出 4 个比较函数 `lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual`，约束 `where T <: Comparable<T>` 已由 v10 修订补充，但具体实现公式未给出（如 `lessThan(x, y): Vec4<Bool,Q> = Vec4<Bool,Q>(x.x < y.x, x.y < y.y, x.z < y.z, x.w < y.w)`）。下游编码者按「逐分量比较」原则实现时需自行展开，对实现正确性缺乏直接依据。

**所在位置**：§3.15 完整实现函数段（行 656-659）

**严重程度**：轻微

**改进建议**：§3.15 完整实现函数段 4 个比较函数描述补充实现公式模板：
```
lessThan(x: Quat<T,Q>, y: Quat<T,Q>): Vec4<Bool,Q> where T <: Comparable<T>, Q <: Qualifier
    = Vec4<Bool,Q>(x.x < y.x, x.y < y.y, x.z < y.z, x.w < y.w)
```

其余 3 个比较函数同理展开。说明 `Vec4<Bool,Q>` 的构造依赖阶段一 Vec4 类型（已实现）。

### 问题 10：§3.13.1 radians/degrees 实现公式未完整说明

**问题描述**：§3.13.1 trigonometric.cj 函数清单中 radians/degrees 行（行 589-590 附近）「内部依赖」列标注「硬编码 π 字面量 `Float64(3.141592653589793)`，无 std.math 依赖，无 `scalar_constants` 依赖」，但未给出实际计算公式。trigonometric.cj 在阶段三是 stub（行 603），公式在阶段四实现时才需要，但作为「系统性设计约束」应在文档中明示公式：`radians(x) = x * π / 180`、`degrees(x) = x * 180 / π`。

**所在位置**：§3.13.1 trigonometric.cj 函数清单（行 589-590）

**严重程度**：轻微

**改进建议**：§3.13.1 radians/degrees 行「内部依赖」列补充完整公式：
```
radians(x) = x * Float64(3.141592653589793) / Float64(180.0)
degrees(x) = x * Float64(180.0) / Float64(3.141592653589793)
```

T 实例化为 Float32 时需 `T(Float64(...))` 转换模式。表行更新为「**纯算术（×π/180 或 ×180/π，硬编码 π 字面量 `Float64(3.141592653589793)` 与 180.0 字面量）**」。

### 问题 11：§3.13.1 trigonometric.cj 函数总数 30→75 描述跳跃缺少过渡说明

**问题描述**：v9 设计描述 trigonometric.cj「提供 30 个函数」，v10 修订为「实际函数总数 = 75 个」。这一 2.5 倍数量跳跃源于 `VecN<T, Q>` 占位符按 Vec1/Vec2/Vec3/Vec4 展开为 4 个独立重载（v10 新增说明）。但表格本身（行 573-596）所有「向量签名（占位符）」列内容仍使用 `VecN<T, Q>` 占位符形式，未在表行中标注「**展开为 4 个独立函数**」。第一次阅读文档的读者（特别是未读到表头展开规则说明时）可能从「30 个」跳跃到「75 个」时产生认知断层。

**所在位置**：§3.13.1 trigonometric.cj 函数清单（行 573-596）

**严重程度**：轻微

**改进建议**：§3.13.1 表头新增「**符号约定**」说明：「表中 `VecN<T, Q>` 形参为占位符，每个占位符按 §3.13.1 上方『VecN 占位符展开规则』段展开为 Vec1/Vec2/Vec3/Vec4 共 4 个独立函数签名。表中「向量签名（占位符）」列 14 行单参数函数实际对应 14 × 4 = 56 个独立函数声明」。表行「向量签名（占位符）」列标题修订为「**向量签名（占位符，展开为 4 个独立函数）**」明示展开规则。

### 问题 12：修订历史章节占比过高，影响文档可读性

**问题描述**：文档 §修订说明（v2）至 §修订说明（v10）共 9 个修订章节占文档总行数约 20%（行 1261-1576，共 316 行 / 总 1576 行）。对于一份 OOD 设计文档，其核心价值是「可直接指导编码实现」，修订历史虽保留决策演化轨迹，但对下游编码者来说是噪声——他们关心的是「最终设计是什么」而非「为什么改成这样」。文档结构上，应将修订历史作为附录或独立 changelog 文件，主文档仅保留最终设计内容。

**所在位置**：§修订说明（v2）至 §修订说明（v10）（行 1261-1576）

**严重程度**：轻微

**改进建议**：将 §修订说明（v2）至 §修订说明（v10）9 个章节移至独立附录文件（如 `v10_revision_history.md`），主 OOD 文档仅保留 §1-§11 设计内容（约 1260 行）；或保留修订历史但显著弱化（仅保留版本号 + 一句话变更摘要，详细变更记录到附录）。下游编码者阅读时按需查阅附录即可。

### 问题 13：整体设计缺少 stage 3 完成的验收标准清单

**问题描述**：§8 产出物清单、§8.2 测试设计、§10 GLM 覆盖矩阵、§11.5 函数可用性对照表均涉及 stage 3 完成的判断依据，但分散在多个章节，未整合为「Stage 3 Acceptance Criteria」单章或单表。下游项目管理者评估 stage 3 是否完成时需跨多个章节交叉核对，增加评估成本。

**所在位置**：全文档分散于 §8（行 865-911 附近）、§8.2（行 912-977 附近）、§10（行 1042-1178 附近）、§11.5（行 1235-1257 附近）

**严重程度**：轻微

**改进建议**：新增 §8.3「Stage 3 Acceptance Criteria」子节，汇总：
- (a) §8 产出物清单中所有「完整实现」「大部分实现」文件已实现（约 14 个文件）；
- (b) §8.2 测试设计所有测试文件已通过（≥179 用例，覆盖 13 个测试文件）；
- (c) §10 覆盖矩阵中所有「本阶段实现」行（≈50 个函数/类型）已通过单元测试；
- (d) §11.5 函数可用性对照表中所有 ✅ 行（≈15 个函数）可在调用方代码中验证；
- (e) §8 编码启动前验证项 1-19（共 19 项）全部已执行通过。

形成单一验收检查清单。

---

## 整体评价

本轮设计文档经过 9 轮迭代修订（v2 → v10），累计处理 51 项历史意见，文档整体质量已显著提升。本轮新识别 13 项质量问题（2 严重 + 6 一般 + 5 轻微），分布如下：

| 维度 | 严重 | 一般 | 轻微 | 合计 |
|------|------|------|------|------|
| 需求响应充分度 | 0 | 0 | 1 | 1 |
| 事实错误 | 0 | 2 | 0 | 2 |
| 逻辑矛盾 | 1 | 2 | 0 | 3 |
| 设计可落地性 | 1 | 2 | 3 | 6 |
| 文档可读性/完整性 | 0 | 0 | 1 | 1 |
| **合计** | **2** | **6** | **5** | **13** |

其中 2 项严重问题均属设计可落地性维度（normalize 零四元数保护未明示 + trigonometric.cj T 约束缺失），直接影响下游编码正确性与系统性约束贯彻。

**整体而言，本文档对用户需求「迁移阶段三」的响应是充分的**：

- ✓ 覆盖了 GLM 1.0.3 阶段三所需迁移的 17+ 个文件（detail/type_quat.hpp + detail/type_quat_cast.hpp + ext/quaternion_*.hpp + ext/scalar_constants.hpp + ext/vector_relational.hpp + gtc/constants.hpp + gtc/quaternion.hpp）
- ✓ 提供了完整的数据布局、签名模板、依赖分析、边界行为契约、测试设计、迁移指南
- ✓ 关键设计决策（D01-D32）有明确理由
- ✓ 包间循环依赖等关键架构问题已妥善解决

**主要待改进维度**：
1. 设计可落地性细节（公式 Cangjie 翻译、零除保护实现、T 约束一致性）
2. stdlib API 准确性（FloatingPoint<T> 实例方法存在性、std.math Float32 重载可获得性）
3. 文档可读性（修订历史占比、Acceptance Criteria 整合）

**整体质量评价**：中等偏上——文档结构完整、决策可追溯、依赖关系清晰；但实现细节描述（特别是与 GLM 实际源码的 1:1 翻译）和 stdlib API 准确性深度仍有提升空间。