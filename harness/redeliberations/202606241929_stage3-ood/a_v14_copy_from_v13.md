# GLM 1.0.3 仓颉迁移阶段三 OOD 设计方案

> **修订日期**：2026-06-25
> **修订定位**：v15 设计的迭代修订（v16，对应本轮审查 a_v14_iteration_requirement.md）。基于 v15 输出修订，针对审查报告识别的 5 项问题（1 严重 + 2 一般 + 2 轻微）逐项落实。本轮重点修复：(1) §3.16 从「路线图同步修订建议」改写为「需求对齐说明」，删除单方面决定修改路线图的论断，新增替代路径可行性讨论，添加「⚠️ 待项目管理方确认后修订」标注；(2) §8 产出物分类统一为与 §11.5 对齐的三档分类（✅ 可用 / ⚠️/❌ 混合 / ❌ stub），§10 覆盖矩阵同步对齐，全文档声明「函数可用状态以 §11.5 为最终基准」；(3) 新增 §8.4「阶段三实施批次建议」，按拓扑依赖给出 4 批实施顺序；(4) §3.13.2 审计节计数 17→18 修正；(5) §3.3 item 6/7 fromMat3/fromMat4 从隐式约束继承改为显式 `where T <: FloatingPoint<T>` 声明，§11.5 对应行同步更新约束标注。

---

## 1. 概述

### 设计目标

在阶段一（Vec1~Vec4 向量类型 + 基础设施）和阶段二（9 个矩阵类型 + ext/ 别名）的基础上，迁移四元数类型及其必需的 ext/gtc 依赖文件，使库具备旋转/插值表达能力。本阶段同时引入向量关系运算扩展、标量常量扩展、gtc/constants 数学常量定义，并为 gtc/matrix_transform 提供空桩占位以满足依赖闭合。

### 核心抽象

| 抽象 | 角色 | 类型形态 |
|------|------|---------|
| Quat<T,Q> | 表示数学四元数的值对象 | 泛型结构体 |
| **detail/type_quat_cast.cj（v3 新增）** | **承载 `mat3Cast`/`mat4Cast`/`quatCast(Mat3)`/`quatCast(Mat4)` 转换函数，避免包间循环依赖** | **包级函数** |
| ext/vector_relational.cj | 向量关系运算扩展函数库（epsilon/ULP 比较） | 完整实现（epsilon 16 重载）+ stub（ULP 8 重载） |
| ext/quaternion_relational.cj | 四元数关系运算扩展函数库 | 完整实现（4 函数） |
| ext/quaternion_transform.cj | 四元数变换函数库 | 仅 `rotate` 函数 stub |
| ext/quaternion_common.cj | 四元数公共函数库（slerp/lerp/conjugate/inverse） | 5 函数完整实现 + 3 函数 stub |
| ext/quaternion_geometric.cj | 四元数几何函数（dot/length/normalize/cross） | 完整实现（4 函数） |
| ext/quaternion_trigonometric.cj | 四元数三角函数（angle/axis/angleAxis） | 1 函数完整实现 + 2 函数 stub |
| ext/quaternion_exponential.cj | 四元数指数函数（exp/log/pow/sqrt） | 全部 stub（4 函数） |
| ext/scalar_constants.cj | 标量数学常量（epsilon/pi/cos_one_over_two） | 完整实现（3 函数重导出） |
| gtc/constants.cj | 数学常量定义（zero/one/pi/half_pi 等 28 个常量） | 完整实现 |
| **gtc/quaternion.cj** | **gtc 四元数扩展函数库（欧拉/比较/看向函数 + 转换函数重导出）** | **混合型：4 函数完整实现 + 7 函数 stub + 4 函数重导出**（**v14 修订，Issue 1 响应**：原「4 函数完整实现 + 7 函数 stub + 4 函数重导出」中 4 函数完整实现仅含比较函数，与 §3.15 一致；§3.2 策略段之前误声明的「8 个完整实现」含欧拉函数已修正） |
| gtc/matrix_transform.cj | 矩阵变换函数库 | 空桩占位 |
| common.cj（沿用阶段二 stub） | 基础数学函数库占位 | 沿用 stub |
| matrix.cj（沿用阶段二） | 矩阵运算函数库 | 沿用（27 实现 + 6 stub） |
| geometric.cj（沿用阶段二 stub） | 几何函数库占位 | 沿用 stub |
| trigonometric.cj（新增空桩） | 三角函数库占位 | 新增空桩 |
| ext/matrix_projection.cj（新增空桩） | 矩阵投影函数库占位 | 新增空桩 |
| ext/matrix_clip_space.cj（新增空桩） | 裁剪空间矩阵函数库占位 | 新增空桩 |
| ext/matrix_transform.cj（新增空桩） | 矩阵变换扩展函数库占位 | 新增空桩 |

### 整体架构思路

沿用阶段一/阶段二的双层包结构 + ext 子包 + gtc 子包：glm.detail 包含四元数泛型结构体定义、运算符重载、以及矩阵-四元数互转函数（type_quat_cast.cj），glm 包通过类型别名暴露常用具现化，glm.ext 包含四元数/向量关系运算等扩展函数库和别名文件，glm.gtc 包含数学常量和 gtc_quaternion 扩展函数库（通过 public import 重导出 detail 中的转换函数）。四元数类型以 Vec3+标量(w) 为内部数据布局，与 GLM 的 xyzw 布局一致（非 wxyz 布局），通过 `const init` 构造函数支持编译期求值。

### 系统性设计约束：泛型上下文中 T(0)/T(1) 的获取问题

本设计与阶段二面临相同的根因限制：**仓颉无约束泛型参数不支持 `T(0)/T(1)` 构造调用，且 `Number<T>` 接口也不提供 `T(n)` 构造声明**。统一策略沿用阶段二的方案：
- **T(0) 的获取（v14 关键修订，Issue 2 响应）**：原策略「通过 `one - one` 演算（需 `one: T` 形参显式传入）」在不含 `one: T` 形参的函数签名中不可用（如 `normalize(q: Quat<T,Q>): Quat<T,Q>`）。**统一修订为 `T(Float64(0))` 字面量替代路径**——与 `axis` 函数中 `T(Float64(0))` 使用模式一致，对 `T = Float32/Float64/Int8~Int64` 均编译可行（`Float32(Float64(0))` = `0.0f`，`Float64(Float64(0))` = `0.0`，`Int8(Float64(0))`/…/`Int64(Float64(0))` = `0`）。仅在 `identity(one: T)` 等显式携带 `one: T` 形参的函数中保留 `one - one` 演算路径
- **T(1) 的获取**：必须由调用方显式传入参数（`one: T`），因为在 `Number<T>` 约束上下文中不存在通用的演算路径
- **T(0) 和 T(1) 均需的场景**：T(0) 通过 T(Float64(0)) 字面量替代获取（v14 修订），T(1) 通过参数传入或 T(Float64(1)) 字面量替代
- **常量型 T(n) 字面量替代**（v8 新增，v9 扩展，**v14 关键修订：同时覆盖 T(0) 和 T(1)**）：对于公式中固定为常数 n 的场景（如 `axis` 公式中的 `T(1) - x.w*x.w`、`normalize` 零保护分支中的 `T(0)` 与 `T(1)`、`Quat×Vec3`/`Quat×Vec4` 旋转公式末尾的 `* 2` 缩放因子、`mat3Cast`/`mat4Cast` 转换函数中初始化 3×3/4×4 单位矩阵对角元素的 `T(1)` 与非对角线元素的 `T(0)`），可采用 `T(Float64(n))` 显式转换路径（编译期 `Float64` 字面量 → `T` 类型），无需 `one: T` 形参；该路径对 `T = Float32`/`Float64` 均成立（`Float32(Float64(n))` 与 `Float64(Float64(n))` 均返回正确字面量），对 `T = Int8`~`Int64` 同样成立（`Int32(Float64(0))` = `0`，`Int32(Float64(1))` = `1` 等）。**v14 修订要点**：T(0) 字面量替代从「仅含 `axis` 中 `Vec3(T(0), T(0), T(1))` 返回值」扩展为系统性覆盖所有函数体中需要常量型 T(0) 的场景——`normalize` 零保护分支的 `Quat(T(0), T(0), T(0), T(1))` 返回值中 xyz 分量的 `T(0)` + `mat3Cast`/`mat4Cast` 非对角线元素的 `T(0)` 均改用 `T(Float64(0))` 字面量替代路径，不再依赖 `one - one` 演算。**v14 受 T 字面量获取策略影响的函数清单（v14 修订，覆盖 T(0) 和 T(1)）**：
  - **`axis` 函数（§3.9）**：使用 `T(Float64(1))` 字面量实现 `T(1) - x.w*x.w` 公式 + 使用 `T(Float64(0))` 字面量实现 `Vec3(T(0), T(0), T(1))` 返回值中 xyz 的两个 T(0)（v8 已明确 T(1)，v14 新增明确 T(0)）
  - **`normalize` 函数（§3.7）**：使用 `T(Float64(0))` 字面量实现零保护分支返回值 `Quat(T(0), T(0), T(0), T(1))` 中 xyz 分量的 T(0) + 使用 `T(Float64(1))` 字面量实现 w 分量的 T(1)（**v14 新增明确**——v9 函数清单遗漏 normalize 的 T(0)/T(1) 字面量替代场景；原策略「T(0) 通过 `one - one` 演算」在 normalize 签名 `normalize(q: Quat<T,Q>): Quat<T,Q>`（不含 `one: T` 形参）中不可用）
  - **`Quat×Vec3`/`Quat×Vec4` 运算符（§3.4）**：使用 `T(Float64(2))` 字面量作为旋转公式末尾的 `* 2` 缩放因子（v9 已明确）
  - **`mat3Cast`/`mat4Cast` 转换函数（§3.2.1）**：使用 `T(Float64(1))` 字面量初始化结果矩阵的对角元素 + 使用 `T(Float64(0))` 字面量初始化非对角线元素（v9 已明确 T(1)，**v14 新增明确 T(0)**——与逐元素填充模式一致，见问题 4 修订）
**v15 修订，Issue 2 响应**：`T(Float64(n))` 字面量替代路径对所有受影响的类型（`Float32`/`Float64`/`Int8`~`Int64`）的编译可行性已在 §8 编码启动前验证项中新增显式验证项，确保该核心假设在编码阶段被验证通过后方可进入实现。

### 系统性设计约束（v8 新增，v11 关键修订）：Float32 与 std.math 的交互约束

仓颉 `std.math` 模块的数值函数 API 覆盖情况（依据 `cangjie-original-docs/std/math/math_package_api/math_package_funcs.md` 全文检索）：
- **提供 Float16/Float32/Float64 三种重载的函数**（**v11 关键修订**：v10/v6/v8 描述「仅支持 Float64」错误）：`sqrt`/`sin`/`cos`/`tan`/`asin`/`acos`/`atan`/`sinh`/`cosh`/`tanh`/`asinh`/`acosh`/`atanh`/`atan2`/`exp`/`log`
- **提供 Float32/Float64 重载的函数**（**v11 关键修订**：v10/v6 描述「`std.math.pow` 实际签名为 `pow(base: Float64, exponent: Float64): Float64`」错误，实际存在 4 个重载）：`pow(Float32, Float32): Float32`、`pow(Float32, Int32): Float32`、`pow(Float64, Float64): Float64`、`pow(Float64, Int64): Float64`
- **不存在**：`radians`/`degrees`（仓颉 std.math 不提供，**v11 修订**：v10 描述「受 §1 约束管辖」错误，本约束不适用于 radians/degrees；radians/degrees 必须通过硬编码 π 字面量自行实现，见 §3.13.1）

**统一处理策略（v11 修订）**：
- **方案 A（推荐）**：当泛型参数 `T` 与 std.math 重载参数类型一致时（即 T=Float32 时直接调用 `std.math.pow(x.w, y)`），**直接调用** std.math 函数，无需 `T(Float64.xxx(...))` 显式转换——v10/v6「必须转换」约束对存在 Float32 重载的函数不成立
- **方案 B（备选）**：对 `T = Float64` 实例化的场景，沿用 `T(Float64.xxx(Float64(value)))` 模式无变化
- **方案 C（备选）**：使用 `T <: Number<T>` 宽约束 + 函数体内 `match` 运行时分派（牺牲部分类型安全换取泛型灵活性，不推荐）

**v11 修订要点**：
- **直接影响消除**：v10 描述的「`std.math.sqrt(x)` 在 T=Float32 时触发编译错误」实际不成立——`std.math.sqrt` 自身已提供 Float32 重载，直接调用即可
- **下游影响范围**（Issue 7 修订需联动的位置清单）：§1「本阶段受此约束影响的函数」段、§3.9 `axis` 函数依赖描述、§3.10 `pow`/`log`/`exp` 函数依赖描述、D21 设计决策、§3.13.1 trigonometric.cj 表头与各函数「内部依赖」列、§8 编码启动前验证项 12 与 15、§10 覆盖矩阵 trigonometric.cj 表所有 14 个函数行
- **保留的影响**：`radians`/`degrees` 因 std.math 不提供这两个函数，仍需自行实现（硬编码 π 字面量路径），不受本约束「直接调用或转换调用」路径管辖

### gtc/quaternion.cj 与 type_quat_cast.cj 的协作设计（v3 关键决策）

**包间循环依赖的根因（v3 识别）**：GLM 1.0.3 中 `mat3_cast`/`mat4_cast`/`quat_cast` 4 个函数在 `gtc/quaternion.hpp` 中定义，而 `type_quat.inl` 的构造函数 `qua(mat3x3)`/`qua(mat4x4)` 内部调用这些转换函数。在 C++ 中通过头文件包含可实现双向引用，但在仓颉包模型下，`type_quat.cj`（`package glm.detail`）若 `import glm.gtc.quaternion.*`，而 `gtc/quaternion.cj`（`package glm.gtc`）若 `import glm.detail.*`，则构成 **包间循环依赖**（`glm.detail ↔ glm.gtc`），仓颉 cjpm 构建系统会拒绝编译（依据 cangjie-lang-features package/README.md 第 99 行明确规定「不允许循环依赖」）。

**本设计采取的解法（v3 决策，采纳审查报告 Solution 1）**：将 `mat3Cast`/`mat4Cast`/`quatCast` 4 个转换函数从 `gtc/quaternion.cj` 下沉至 `glm.detail.type_quat_cast.cj`（独立新文件，`package glm.detail`），让 `type_quat.cj` 中的 `fromMat3`/`fromMat4` 工厂函数直接调用同包函数（无需跨包引用）。`gtc/quaternion.cj` 通过 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 将这 4 个函数重导出为 gtc 命名空间的 API，从而保留 GLM 1:1 文件归属的设计意图（gtc 包仍提供 gtc 风格 API），同时彻底打破循环依赖。

**依赖方向（v3 重新确认）**：
- `glm.detail`（含 `type_quat.cj` 和 `type_quat_cast.cj`）**不依赖** `glm.gtc`
- `glm.gtc`（含 `quaternion.cj`）**单向依赖** `glm.detail`（通过 `public import` 重导出）
- 形成 `glm.gtc → glm.detail` 的**单向依赖**，无循环依赖

**为何不采用其他方案**：
- 审查报告 Solution 2（将 fromMat3/fromMat4 剥离到 gtc）会破坏 type_quat.cj 的核心职责（工厂函数应与类型定义同处），且让 API 形态从 `q.fromMat3(m)` 退化为 `mat3ToQuat(m)`，与 GLM 习惯偏差更大
- 审查报告 Solution 3（重新组织包层级为 glm.detail.gtc）需修改整个阶段三的包结构，影响过大
- 本方案仅调整 4 个函数的位置（detail 而非 gtc），破坏最小，API 形态完整保留

---

## 2. 模块划分

### 包组织

```
package glm/detail          — 核心实现层（新增/修改文件以 ★ 标记）
  ├── type_quat.cj ★        — Quat<T,Q> 结构体定义 + extend 块中的运算符
  │                          (含 Quat×Vec3/Vec4 成员运算符、Vec3×Quat/Vec4×Quat extend 块成员运算符)
  │                          (fromMat3/fromMat4 调用同包 type_quat_cast.cj 函数)
  ├── type_quat_cast.cj ★  — 矩阵-四元数互转包级函数（mat3Cast/mat4Cast/quatCast）
  │                          (v3 新增，下沉自 gtc/quaternion.cj 以避免包间循环依赖)
  ├── common.cj（沿用 stub，阶段二已有）
  ├── matrix.cj（沿用混合型，阶段二已有）
  ├── geometric.cj（沿用 stub，阶段二已有）
  ├── scalar_constants.cj ★ — 标量常量定义（移入 detail，epsilon/pi/cos_one_over_two）
  ├── trigonometric.cj ★    — 新增空桩（sin/cos/tan/asin/acos/atan 等签名空壳）
  ├── scalar_quat_ops.cj ★  — 标量-四元数运算全局具名函数（add/sub/mul/div，处理 T + Quat 等标量左侧运算）

package glm                 — 公共 API 面 + 别名层（修改文件以 ★ 标记）
  ├── lib.cj ★              — 新增四元数类型、ext 函数、gtc 常量的 public import（v5 明确清单见下方）
  └── fwd.cj ★              — 新增四元数类型别名（v5 明确清单见下方）

**lib.cj 新增 import 清单（v5 明确，v9 扩展补齐，**v13 修订实际行数声明**）**：
- **v13 修订，Issue 1 响应，lib.cj 实际行数声明**：`cjglm/src/lib.cj` 当前**仅 8 行**（经 `wc -l cjglm/src/lib.cj` 验证），文件内容为：第 1 行 `package glm` 声明 + 第 2-8 行共 7 个 `public import glm.detail.{...}` 声明（`Vec1~Vec4` / `Qualifier`/`PackedHighp`/`PackedMediump`/`PackedLowp` / `Defaultp` / `add`/`sub`/`mul`/`div`/`mod` / `fromBoolVec`/`fromBoolVecQ2` / `Mat2x2~Mat4x4` / `transpose`/`matrixCompMult`/`outerProduct`）。**阶段三新增的 20 个 import 全部追加至 lib.cj 第 9 行起**（即当前 8 行末尾后逐行追加）——下游编码者按本清单实施时无需在 lib.cj 中查找「第 131 行」（v12 错误引用），直接编辑 8 行文件末尾追加 20 行 import 即可
- `public import glm.detail.{Quat, mat3Cast, mat4Cast, quatCast}` — 四元数类型 + 转换函数（**v10 修订，Issue 17 响应**：`mat3Cast`/`mat4Cast`/`quatCast` 在 lib.cj 中以 `public import` 形式重导出至顶层 `glm` 命名空间——与现有 `public import glm.detail.{transpose, matrixCompMult, outerProduct}` 包级函数重导出模式一致，见 `cjglm/src/lib.cj:8`——下游消费者可按 `glm.mat3Cast(q)` 路径直接调用，**无需** `import glm.detail.*` 后再调用包级函数 `mat3Cast(q)`）
- `import glm.detail.trigonometric` — 三角函数（75 函数空桩，14 标量 + 56 向量 + 1 标量 `atan2` + 4 向量 `atan2`，按 v10 展开规则；v9 新增）
- `import glm.ext.vector_relational` — 向量关系运算（含 16 重载 epsilon + 8 重载 ULP stub）
- `import glm.ext.quaternion_common` — 四元数公共函数（5 实现 + 3 stub）
- `import glm.ext.quaternion_geometric` — 四元数几何函数（4 实现）
- `import glm.ext.quaternion_trigonometric` — 四元数三角函数（1 实现 + 2 stub）
- `import glm.ext.quaternion_relational` — 四元数关系运算（4 实现）
- `import glm.ext.quaternion_transform` — 四元数变换函数（仅 `rotate` 函数 stub；v9 新增）
- `import glm.ext.quaternion_exponential` — 四元数指数函数（4 函数全部 stub；v9 新增）
- `import glm.ext.scalar_constants` — 标量常量（3 函数重导出）
- `import glm.ext.quaternion_float` — Float32 四元数别名（`quat`）；v9 新增
- `import glm.ext.quaternion_double` — Float64 四元数别名（`dquat`）；v9 新增
- `import glm.ext.quaternion_float_precision` — Float32 精度变体别名（`highp_quat`/`mediump_quat`/`lowp_quat`）；v9 新增
- `import glm.ext.quaternion_double_precision` — Float64 精度变体别名（`highp_dquat`/`mediump_dquat`/`lowp_dquat`）；v9 新增
- `import glm.ext.matrix_projection` — 矩阵投影函数库空桩；v9 新增
- `import glm.ext.matrix_clip_space` — 裁剪空间矩阵函数库空桩；v9 新增
- `import glm.ext.matrix_transform` — 矩阵变换扩展函数库空桩；v9 新增
- `import glm.gtc.constants` — 数学常量（28 函数）
- `import glm.gtc.quaternion` — gtc 四元数扩展函数库（4 函数重导出 + 4 函数完整 + 7 函数 stub；v9 新增）
- `import glm.gtc.matrix_transform` — 矩阵变换函数库空桩占位（**v13 修订**：64 个函数签名而非 v12 描述的 35 个；v9 新增）
- **合计 20 个 import**（v9 修订：v5 明确 8 个 → v9 扩展 12 个 → 合计 20 个；下游消费者可按 lib.cj import 清单访问所有新增模块（stub/别名/gtc））

**fwd.cj 新增 type alias 清单（v5 明确，v10 修订别名计数，v12 关键修订 Issue 2 实施路径，**v13 关键修订路径准确性**）**：
- `type Quat = Quat<Float32, PackedHighp>` — Float32 主别名
- `type FQuat = Quat<Float32, PackedHighp>` — Float32 别名（与 `Quat` 等价，遵循阶段二双别名模式）
- `type DQuat = Quat<Float64, PackedHighp>` — Float64 主别名
- `type HighpQuat = Quat<Float32, Highp>` — Float32 高精度别名
- `type MediumpQuat = Quat<Float32, Mediump>` — Float32 中精度别名
- `type LowpQuat = Quat<Float32, Lowp>` — Float32 低精度别名
- `type HighpDQuat = Quat<Float64, Highp>` — Float64 高精度别名
- `type MediumpDQuat = Quat<Float64, Mediump>` — Float64 中精度别名
- `type LowpDQuat = Quat<Float64, Lowp>` — Float64 低精度别名
- **合计 9 个别名**（**v10 修订**：v9 描述误为 8 个，实际为 Quat/FQuat/DQuat（3 个）+ 3×Float32 精度 + 3×Float64 精度 = **9 个**；与阶段二 `Mat2x2`/`FMat2x2` 双别名机制一致）
- 排除项：不含 `BQuat`（Bool 四元数，D17 决策）/ `IQuat`/`I64Quat`（整型四元数，与阶段二 fwd.cj 排除整型矩阵别名策略一致）
- **实施路径（v12 关键修订，Issue 2 响应，**v13 关键修订路径准确性，Issue 3 响应**）**：`fwd.cj` 是自动生成文件（`cjglm/src/fwd.cj:1-2` 文件头注释为中文「`// fwd.cj — GLM 兼容类型别名（自动生成）`」+「`// 注意：此文件由脚本自动生成，手动修改请谨慎`」，**v13 修订**：v12 描述「Auto-generated file. Do not edit!」字样与实际中文注释不符），**手动添加将随重新生成丢失**。v13 决策采用**方案 A（推荐，修改生成脚本）**：(a) **生成脚本位置（v13 关键修订，Issue 3 响应）**：`cjglm/scripts/gen_fwd_aliases.py`（Python 64 行，**v13 修订**：v12 描述「`tools/gen_fwd.cj`」与实际不符——`cjglm/` 下不存在 `tools/` 目录，实际生成脚本为 Python 而非 Cangjie）；(b) **修改策略（v13 关键修订，Issue 3 响应）**：现有脚本通过 `VEC_FAMILIES` 字典（`gen_fwd_aliases.py:13-18`）将家族前缀映射到标量类型 + `VEC_PRECISIONS` 列表（`gen_fwd_aliases.py:19-20`）控制精度前缀 + `DIMS = [1, 2, 3, 4]`（`gen_fwd_aliases.py:21`）控制分量数。下游编码者需在 `VEC_FAMILIES` 字典中新增 `Quat`/`FQuat`/`DQuat` 三个家族前缀条目（如 `Quat`/`FQuat` 映射到 `Float32`，`DQuat` 映射到 `Float64`），并新增针对 Quat 家族固定 4 维（无 Vec1/Vec2/Vec3 变体）的特殊处理分支——因 Quat 仅支持 4 维而现有脚本按 `DIMS = [1, 2, 3, 4]` 全维度循环生成 Vec 别名，简单新增 `VEC_FAMILIES` 条目会生成 `Quat1`/`Quat2`/`Quat3` 三个不存在项；(c) 重新执行 `python cjglm/scripts/gen_fwd_aliases.py` 生成 `fwd.cj` 后再提交；(d) 验证生成的 `fwd.cj` 包含全部 9 个 type alias（`Quat`/`FQuat`/`DQuat` + 3×Float32 精度 `HighpQuat`/`MediumpQuat`/`LowpQuat` + 3×Float64 精度 `HighpDQuat`/`MediumpDQuat`/`LowpDQuat`）。**v13 附注（Issue 4 响应）**：fwd.cj 文件头中文「`手动修改请谨慎`」是**建议性**而非**禁止性**措辞（与英文「Do not edit!」的禁止性措辞不同），下游编码者按方案 A 修改生成脚本后重新生成 fwd.cj 是推荐路径；若仅作小范围手动编辑（如调试）也可理解，但提交前必须重新执行生成脚本以保持「单一自动生成来源」架构原则。**备选方案 B**（如生成脚本修改成本过高）：将 9 个 type alias 移至 `lib.cj` 顶部作为补充声明（`lib.cj` 是手动维护文件，仅 8 行），与现有 type alias 并存；**备选方案 C**：新建独立手动维护文件 `cjglm/src/quaternion_aliases.cj`，在 `lib.cj` 中 `public import` 重导出该文件——本方案需评估 cjpm 构建系统对新增文件的发现机制。本设计文档**推荐方案 A**，与 fwd.cj 的「单一自动生成来源」架构原则一致。

package glm.ext             — 扩展函数库（新增文件以 ★ 标记）
  ├── vector_relational.cj ★      — 向量 epsilon/ULP 关系运算函数（epsilon 16 重载完整实现 + ULP 8 重载 stub）
  ├── quaternion_relational.cj ★  — 四元数关系运算函数（4 函数完整实现）
  ├── quaternion_transform.cj ★   — 四元数变换函数（仅 `rotate` 函数 stub）
  ├── quaternion_common.cj ★      — 四元数公共函数（5 函数完整实现 + 3 函数 stub）
  ├── quaternion_geometric.cj ★   — 四元数几何函数（4 函数完整实现：dot/length/normalize/cross）
  ├── quaternion_trigonometric.cj ★ — 四元数三角函数（1 函数完整实现 + 2 函数 stub）
  ├── quaternion_exponential.cj ★   — 四元数指数函数（4 函数全部 stub）
  ├── scalar_constants.cj ★        — 向上导出接口（import glm.detail.scalar_constants 并 public import 重导出）
  ├── matrix_projection.cj ★       — 新增空桩
  ├── matrix_clip_space.cj ★       — 新增空桩
  ├── matrix_transform.cj ★        — 新增空桩
  ├── quaternion_float.cj ★         — Float32 四元数别名
  ├── quaternion_double.cj ★        — Float64 四元数别名
  ├── quaternion_float_precision.cj ★ — Float32 精度变体别名
  ├── quaternion_double_precision.cj ★ — Float64 精度变体别名

package glm.gtc             — GTC 扩展函数库（新增目录和文件以 ★ 标记）
  ├── constants.cj ★        — 数学常量定义（28 个常量函数完整实现）
  ├── matrix_transform.cj ★ — 空桩占位（仅函数签名空壳）
  ├── quaternion.cj ★       — gtc 四元数扩展函数（4 函数重导出 + 8 函数完整 + 7 函数 stub）
  │                          (mat3Cast/mat4Cast/quatCast 通过 public import glm.detail.{...} 重导出)
```

### 模块间依赖

```
glm.detail（同包直接可见）
  type_quat.cj → type_vec3, type_vec4
  type_quat.cj → type_quat_cast（fromMat3/fromMat4 调用同包 mat3Cast/mat4Cast/quatCast，v3 同包内调用）
  type_quat.cj → ext/quaternion_geometric（dot/length/normalize/cross）
  type_quat.cj → ext/scalar_constants（epsilon<T>()）
  type_quat.cj → common.cj(stub), trigonometric.cj(stub), geometric.cj(stub)
  type_quat_cast.cj → type_quat, Mat3x3, Mat4x4, Vec3（同包，无跨包引用）
  scalar_quat_ops.cj → type_quat
  scalar_constants.cj → setup.cj（仅依赖 GLM_CONFIG_* 常量）

glm.ext
  vector_relational.cj → glm.detail（qualifier, Vec1~Vec4, common.cj stub）
  quaternion_relational.cj → glm.detail（Quat, Vec4）, ext/vector_relational
  quaternion_geometric.cj → glm.detail（Quat, 纯算术，不依赖 geometric.cj stub）
  quaternion_transform.cj → glm.detail（Quat, Vec3, common.cj stub, trigonometric.cj stub, geometric.cj stub）
  quaternion_common.cj → glm.detail（Quat, Vec4, common.cj stub, trigonometric.cj stub）
  quaternion_trigonometric.cj → glm.detail（Quat, Vec3, ext/scalar_constants）
  quaternion_exponential.cj → glm.detail（Quat, ext/scalar_constants, common.cj stub, trigonometric.cj stub, geometric.cj stub）
  scalar_constants.cj → glm.detail.scalar_constants（重导出）
  matrix_projection.cj → stub（空桩）
  matrix_clip_space.cj → stub（空桩）
  matrix_transform.cj → stub（空桩）
  quaternion_float.cj → glm.detail（Quat 别名）
  quaternion_double.cj → glm.detail（Quat 别名）
  quaternion_float_precision.cj → glm.detail（Quat 别名）
  quaternion_double_precision.cj → glm.detail（Quat 别名）

glm.gtc（v3 关键：单向依赖 glm.detail，无循环）
  constants.cj → glm.ext.scalar_constants
  quaternion.cj → glm.detail（public import mat3Cast, mat4Cast, quatCast 进行重导出）
  quaternion.cj → glm.detail.{Quat, Mat3x3, Mat4x4, Vec3}（用于实现比较/欧拉/看向函数，**v10 修订，Issue 9 响应**：依赖声明过宽，按函数组细分——4 个比较函数（`lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual`）**仅依赖 Quat**；3 个 quatLookAt 函数（`quatLookAt`/`quatLookAtRH`/`quatLookAtLH`）**仅依赖 Vec3**；4 个转换函数（`mat3Cast`/`mat4Cast`/`quatCast` × 2，**v12 关键修订，Issue 1 响应**：camelCase 命名而非 GLM snake_case `mat3_cast`/`mat4_cast`/`quat_cast`）**重导出 detail 端**（不需直接 import Mat/Vec）；4 个欧拉函数（`eulerAngles`/`roll`/`pitch`/`yaw`）**依赖 Vec3 + Quat**）
  quaternion.cj → glm.ext.scalar_constants（epsilon<T>()，用于欧拉角边界检测）
  quaternion.cj → glm.ext.vector_relational（equal，用于 roll/pitch 的 equal(vec2, vec2, 0) 边界检测）
  quaternion.cj → glm.detail.common(stub)（clamp/abs，用于 roll/pitch/yaw/pow）
  quaternion.cj → glm.detail.trigonometric(stub)（atan/asin/cos/sin，用于 roll/pitch/yaw）
  quaternion.cj → glm.detail.geometric(stub)（cross/dot/normalize/inversesqrt/max，用于 quatLookAt*）
  quaternion.cj → glm.detail.type_quat_cast（quaternion.cj 中 quatLookAt* 内部调用 quatCast）
  matrix_transform.cj → stub 引用 ext/matrix_projection, ext/matrix_clip_space, ext/matrix_transform,
                         glm.detail.geometric(stub), glm.detail.trigonometric(stub), glm.detail.matrix(stub)

glm
  fwd.cj → glm.detail（Quat 别名）
  lib.cj → glm.detail（Quat, scalar_constants 函数, type_quat_cast 函数）, glm.ext, glm.gtc
```

**依赖方向总览（v3 修订）**：
- `glm.gtc → glm.detail` 单向（v3 关键变更）
- `glm.ext → glm.detail` 单向
- `glm → glm.detail/gtc/ext` 顶层聚合
- `glm.detail` 不依赖任何上层包

### ext/ 新文件与 gtc/ 子包的包名策略

沿用阶段二已验证的策略：
- `src/ext/` 下文件声明 `package glm.ext`
- `src/gtc/` 下文件声明 `package glm.gtc`（需原型验证 cjpm 子包发现机制对 gtc/ 子目录的支持；若不支持，按阶段二备选方案降级至 `package glm` 并在 src/ 根目录存放）

### cjpm 子包构建预验证

阶段二已通过验证：`src/ext/` 目录 + `package glm.ext` 的子包发现机制在 cjpm 中可用（[已通过 cjpm 验证]）。阶段三新增 `src/gtc/` + `package glm.gtc`，属 cjpm 构建系统的额外不确定性，需原型验证：

- **验证项 1（gtc 子包）**：在 `src/gtc/` 下创建测试文件，验证 cjpm 是否能识别 `package glm.gtc` 声明
- **验证项 2（gtc 重导出 detail 函数）**：验证 `gtc/quaternion.cj` 中 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 能否正确将 detail 包级函数重导出至 glm.gtc 命名空间
- **回退方案**：若 cjpm 不支持 `src/gtc/` 子目录的子包发现机制，将 gtc/ 文件夹内的文件迁移至 `src/` 根目录并降级为 `package glm`，函数路径从 `glm.gtc.quaternion.mat3Cast` 变为 `glm.mat3Cast`（与阶段二 ext/ 子包回退方案一致）

---

## 3. 核心抽象

### 3.1 四元数结构体 Quat<T,Q>

**角色**：表示数学四元数的值对象，用于旋转表达和插值运算。

**职责**：
- 承载 4 个分量数据成员（`public var x: T, public var y: T, public var z: T, public var w: T`，**v4 修订：显式标注 `public` 可见性以满足 `@Derive[Hashable]` 派生对字段 public 可见性的要求**），布局与 GLM 默认 xyzw 一致（非 wxyz）
- 提供编译期查询函数 `public static func length(): Int64` 返回常量 4
- 提供下标运算符 `[](i: Int64)` 访问分量（取值 + 赋值双版本）
- 提供多种构造方式（逐分量构造、标量+向量构造、跨类型构造）
- 通过 `@Derive[Hashable]` 自动派生哈希支持

**为何采用 struct（值类型）**：与阶段一 Vec 和阶段二 Mat 一致——四元数是数学计算中的值对象，值语义确保运算符返回新实例、无副作用。

**数据布局选择**：GLM 默认（`GLM_FORCE_QUAT_DATA_XYZW` 未定义时）为 `x, y, z, w` 布局。本设计采用此默认布局，`w` 分量位于第四位置。C++ GLM 的 `qua(T w, T x, T y, T z)` 构造函数参数顺序为 w 在前，但内部存储为 xyzw 后缀。仓颉版本中数据成员声明为 `public var x, public var y, public var z, public var w`（**v4 修订**：显式标注 `public` 以满足 `@Derive[Hashable]` 派生宏对字段 `public` 可见性的要求，依据 `cangjie-std/deriving/README.md` 第 4 节「参与派生的字段/属性必须为 public」），与阶段一 Vec3 (`type_vec3.cj:8-10`)、阶段二全部矩阵类型 (`type_mat*.cj` 200+ 处统一实践) 的实践对齐，与 GLM 存储布局对应。构造函数参数顺序需与数据布局明确区分——见 §3.3。

**为何不像 C++ GLM 使用匿名 union**：仓颉不支持匿名联合体和 `reinterpret_cast`，无法实现 GLM 中 `union { struct { T x, y, z, w }; storage<4,T> data; }` 的布局技巧。四元数直接声明具名数据成员，与阶段一/二 Vec/Mat 的策略一致。

**`@Derive[Hashable]` 约束核验（v3 新增，v4 强化，v5 明确实践依据）**：仓颉 `@Derive[Hashable]` 要求：①泛型 type parameter 满足 `Hashable` 接口；②参与派生的字段/属性必须为 `public` 可见性（依据 `cangjie-std/deriving/README.md` 第 4 节「参与派生的字段/属性必须为 public」）。`Quat<T, Q>` 中 `T <: Number<T>` 约束下所有数字类型均实现 `Hashable`；`Q <: Qualifier` 约束下 6 个 Qualifier 实现类型均无数据成员（标记类型），其 `Hashable` 派生由编译器自动支持。**字段可见性约束（v4 新增）**：Quat 的 4 个数据成员 `x`/`y`/`z`/`w` 统一标注 `public var`（详见上文数据成员描述），满足派生宏对字段 `public` 可见性的硬性要求——若省略 `public` 关键字，struct 字段默认可见性为 `internal`（依据 `struct/README.md` 第 1.7 节），不满足 public 派生要求，编译器将报错。**实践依据（v5 明确）**：阶段一 `type_vec3.cj:6` 已使用 `@Derive[Hashable]` 派生并通过编译（Vec3 数据成员 `public var x: T, public var y: T, public var z: T`）；阶段二全部矩阵类型（`type_mat2x2.cj`、`type_mat3x3.cj`、`type_mat4x4.cj` 等 9 个矩阵类型文件）均使用 `@Derive[Hashable]` + `public var` 派生并通过编译（200+ 处统一实践，已 grep 验证）。阶段三四元数延续相同的 `public var` + `@Derive[Hashable]` 派生模式，**前提条件**：阶段三不新增 Qualifier 变体，6 个 Qualifier 实现类型（`PackedHighp`/`PackedMediump`/`PackedLowp`/`AlignedHighp`/`AlignedMediump`/`AlignedLowp`）与阶段二完全一致。若阶段三新增 Qualifier 变体或 Qualifier 数据结构变更（如携带 alignment/SIMD 标签字段），需重新验证 `@Derive[Hashable]` 派生可行性。需在编码启动前验证项中确认 `@Derive[Hashable]` 对 `Q <: Qualifier` 的派生编译通过。

### 3.2 四元数与向量/矩阵的协作关系

四元数与向量、矩阵之间存在以下协作模式：

| 协作模式 | 描述 | 实现位置 |
|---------|------|---------|
| Quat×Vec3 | 四元数旋转向量 | Quat extend 块成员运算符 |
| Vec3×Quat | 向量被四元数逆旋转 | Vec3 extend 块成员运算符 |
| Quat×Vec4 | 四元数旋转向量（保留 w 分量） | Quat extend 块成员运算符 |
| Vec4×Quat | 向量被四元数逆旋转（保留 w 分量） | Vec4 extend 块成员运算符 |
| Mat3←Quat `mat3Cast` | 四元数转 3×3 旋转矩阵 | **detail/type_quat_cast.cj** 包级函数（v3 决策，**v12 关键修订，Issue 1 响应**：camelCase 命名，对应 GLM 原始 `mat3_cast`） |
| Mat4←Quat `mat4Cast` | 四元数转 4×4 旋转矩阵 | **detail/type_quat_cast.cj** 包级函数（v3 决策，**v12 关键修订同上**：camelCase `mat4Cast`，对应 GLM 原始 `mat4_cast`） |
| Quat←Mat3 `quatCast` | 旋转矩阵转四元数 | **detail/type_quat_cast.cj** 包级函数（v3 决策，**v12 关键修订同上**：camelCase `quatCast`，对应 GLM 原始 `quat_cast`） |
| Quat←Mat4 `quatCast` | 4×4 旋转矩阵转四元数 | **detail/type_quat_cast.cj** 包级函数（v3 决策，**v12 关键修订同上**：camelCase `quatCast`，对应 GLM 原始 `quat_cast`） |
| Mat↔Quat 转换重导出 | gtc 命名空间下的同名函数 | gtc/quaternion.cj 通过 public import 重导出 detail/type_quat_cast.cj 函数 |

**关键设计决策（v3 重新明确）**：`type_quat.inl` 中的构造函数 `qua(mat3x3)` 和 `qua(mat4x4)` 内部调用 `quat_cast`，而 `qua(Vec3, Vec3)`（从两个向量构造四元数）内部调用 `cross`、`dot`、`normalize` 等 geometric.cj 函数。仓颉版本中：
- `fromMat3`/`fromMat4` 工厂函数（在 `type_quat.cj` 中）调用**同包** `type_quat_cast.cj` 的 `quatCast`/`mat3Cast`/`mat4Cast` 函数（同包内可见，无需跨包 import）
- `gtc/quaternion.cj` 通过 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 将 detail 中的转换函数重导出至 gtc 命名空间，保留 GLM 1:1 文件归属的 API 形态

#### 3.2.1 type_quat_cast 函数签名规范（v5 新增）

`detail/type_quat_cast.cj` 中 4 个函数的具体签名模板（与 D29 同类约束收紧策略一致）：

```cangjie
// 包级 public 函数，package glm.detail
public func mat3Cast<T, Q>(q: Quat<T, Q>): Mat3x3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func mat4Cast<T, Q>(q: Quat<T, Q>): Mat4x4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func quatCast<T, Q>(m: Mat3x3<T, Q>): Quat<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func quatCast<T, Q>(m: Mat4x4<T, Q>): Quat<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
```

**约束说明**：
- `T <: FloatingPoint<T>`（v7 修订：v6 使用的 `FloatingPointNumber<T>` 非仓颉 stdlib 原生接口名，stdlib `cangjie-std/math/README.md` 第 117 行明确定义为 `FloatingPoint<T>`/`Integer<T>`/`Number<T>` 三层接口）：与 D29 `isnan`/`isinf` 约束收紧策略一致。GLM 1.0.3 在转换函数定义处使用 `GLM_STATIC_ASSERT(std::numeric_limits<T>::is_iec559, ...)` 静态断言非浮点类型时编译失败，仓颉版本通过 `FloatingPoint<T>` 接口约束（stdlib 原生接口）实现等价行为——整数 T（如 `Int64`）实例化时编译期报类型不匹配错误（`Int64` 不实现 `FloatingPoint<Int64>` 接口）。
- **重载区分**：`mat3Cast` 与 `mat4Cast` 通过参数类型 `Mat3x3<T,Q>` vs `Mat4x4<T,Q>` 区分；`quatCast` 的 Mat3 与 Mat4 重载同样通过参数类型区分，仓颉泛型重载规则支持此场景。
- **Fallback 模式**（理论上不需要——`FloatingPoint<T>` 是 stdlib 原生接口，编译期保证可用；此 fallback 仅作 v7 修订前的兼容占位说明）：若仓颉 stdlib 未提供 `FloatingPoint<T>` 接口（极小概率，stdlib 文档已明确），则将约束放宽为 `T <: Number<T>`，并在函数体首部通过 `match` 或 `if-else` 对 `q.x` 的具体类型进行 `Float32`/`Float64` 分派，非浮点 T 实例化时抛 `Exception("mat3Cast/mat4Cast/quatCast not defined for non-floating-point types")`，与 `epsilon<T>()` fallback 策略一致。

**T(1)/T(0) 字面量获取与矩阵初始化策略（v9 新增，**v14 关键修订，Issue 2+4 响应**）**：
- **GLM 实际依赖**：GLM 1.0.3 `gtc/quaternion.inl:49` 中 `mat3_cast`/`mat4_cast` 函数体内部使用 `Result = Mat3x3(T(1))` 初始化结果矩阵为单位矩阵（即先填 3×3/4×4 单位矩阵作为基底，再覆盖部分元素为四元数旋转分量），强依赖 T(1) 字面量。`quat_cast` 函数体内部不直接依赖 T(1)（通过 `trace`/`sqrt` 等运算推导四元数分量），故本策略主要影响 `mat3Cast`/`mat4Cast` 两个函数。
- **仓颉实现路径（v14 关键修订，Issue 4 响应：明确选择逐元素填充模式）**：本设计明确选择**逐元素填充模式**——不依赖 Mat3x3/Mat4x4 单参数构造函数。`mat3Cast` 实现模板为：`Result[0][0] = T(Float64(1)); Result[1][1] = T(Float64(1)); Result[2][2] = T(Float64(1)); Result 的其余元素 = T(Float64(0))`，然后覆盖旋转分量。`mat4Cast` 同理。该模式与 §1「常量型 T(n) 字面量替代」v14 修订策略一致（T(1) 使用 `T(Float64(1))` 字面量替代，T(0) 使用 `T(Float64(0))` 字面量替代——**v14 新增明确 T(0) 场景**：非对角线元素初始化为 `T(Float64(0))` 不依赖 Mat3x3 零初始化默认值，显式逐元素赋值确保跨类型一致性）。删除 v9 描述的「`Mat3x3(T(Float64(1)))` 初始化对角线」歧义表述——该表述暗示使用单参数构造函数（若 Mat3x3 存在单参数构造需 `one: T` 形参），与逐元素填充的 `FloatingPoint<T>` 约束签名不一致。**v14 决策理由**：(a) 逐元素填充不依赖 Mat3x3/Mat4x4 的任何特定构造函数签名，仅需 `[]` 下标运算符赋值能力（已由 §3.1 Quat 下标运算符和阶段二 Mat 下标运算符验证），下游编码者按模板逐行赋值即可实现；(b) 非对角线元素 T(0) 显式赋值（不依赖零初始化默认值），与 `axis`/`normalize` 中 T(0) 的 `T(Float64(0))` 字面量替代路径一致，形成 §1 统一策略闭环；(c) 消除两种初始化路径（单参数构造 vs 逐元素填充）的歧义，下游无需判断 Mat3x3/Mat4x4 是否支持单参数构造函数。

**边界行为契约（v8 新增）**：
- **`mat3Cast` 接受非单位四元数**：返回矩阵不保证是旋转矩阵——若输入四元数非单位四元数（含缩放/剪切分量），返回的 3×3 矩阵保留原始四元数的非旋转分量（如四元数长度为 2 时返回矩阵的奇异值近似 2/1/1），与 GLM 1.0.3 行为一致（GLM `type_quat.inl` 不做单位化保护）。
- **`mat4Cast` 接受非单位四元数**：与 `mat3Cast` 行为一致，返回 4×4 矩阵保留非旋转分量。
- **`quatCast` 接受非旋转矩阵**：返回的四元数行为未定义——若输入 Mat3/Mat4 含缩放/平移/剪切分量（非纯旋转矩阵），返回四元数可能是非单位四元数、零四元数或 NaN 四元数。GLM 1.0.3 通过 `GLM_STATIC_ASSERT(std::numeric_limits<T>::is_iec559, ...)` + 内部 `trace`/`sqrt` 计算实现，不做旋转矩阵合法性校验。
- **下游消费者契约**：与 §3.3 item 6/7 `fromMat3`/`fromMat4` 工厂函数的边界声明对齐（仅对纯旋转矩阵产生有意义结果）——`mat3Cast`/`mat4Cast`/`quatCast` 是 `fromMat3`/`fromMat4` 的反向操作，两者边界行为互为镜像。

**本阶段对 gtc/quaternion 函数的处理策略（v3 修订）**：`gtc/quaternion.hpp` 中共 15 个原始声明（`mat3_cast`/`mat4_cast`/`quat_cast` 两个重载/4 个 + `lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual`/4 个比较 + `eulerAngles`/`roll`/`pitch`/`yaw`/4 个欧拉 + `quatLookAt`/`quatLookAtRH`/`quatLookAtLH`/3 个看向 = 15 个）。本阶段采取以下分批策略：
- **本文件完整实现（4 个）**（**v14 修订，Issue 1 响应**：v13 策略段落声称「完整实现（8 个）」含 4 个欧拉函数，与 §3.15 函数职责分组表/v3 修订说明已归入「stub 占位」直接矛盾；本轮修正为与 §3.15 一致的分类）：
  - `lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual` — 4 个比较函数，纯算术
- **从 detail 重导出（4 个）**：
  - `mat3Cast`/`mat4Cast`/`quatCast(Mat3)`/`quatCast(Mat4)` — 通过 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 重导出（**v12 关键修订，Issue 1 响应**：仓颉端 camelCase 命名，对应 GLM 原始 `mat3_cast`/`mat4_cast`/`quat_cast` 习惯——`public import` 不做 snake_case→camelCase 命名转换）
- **stub 占位（7 个）**（**v14 修订，Issue 1 响应**：原 3 个仅含看向函数，未计入欧拉函数；与 §3.15 函数职责分组一致，4 欧拉 + 3 看向 = 7 stub）：
  - `eulerAngles`/`roll`/`pitch`/`yaw` — 4 个欧拉函数，依赖 `trigonometric.cj` 的 `atan`/`asin` + `common.cj` 的 `clamp` + `vector_relational.cj` 的 `equal` + `scalar_constants.cj` 的 `epsilon<T>()`（均为 stub，**v14 修订**：从「完整实现」修正为「stub 占位」，与 §3.15 v5 最终决策一致）
  - `quatLookAt`/`quatLookAtRH`/`quatLookAtLH` — 3 个函数，依赖 `geometric.cj` 的 `cross`/`dot`/`normalize`/`inversesqrt`/`max`（均为 stub）

**type_quat.cj、type_quat_cast.cj、gtc/quaternion.cj 三者协作关系（v3 明确）**：
- `type_quat.cj` 中的 `fromMat3`/`fromMat4` 工厂函数直接调用 `type_quat_cast.cj` 的 `mat3Cast`/`mat4Cast`/`quatCast`（同包内可见，无 import 需求）
- `gtc/quaternion.cj` 通过 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 将 detail 函数重导出为 gtc 命名空间下的同名 API
- 仓颉包依赖 DAG：`glm.gtc → glm.detail` 单向（v3 关键变更），无循环依赖

### 3.3 构造函数体系

每个 Quat<T,Q> 提供以下构造函数和工厂函数：

1. **逐分量构造 const init(x: T, y: T, z: T, w: T)** — 纯赋值，参数顺序为 x, y, z, w（与数据成员声明顺序一致）。此为仓颉侧的**主构造函数**。调用方需注意：GLM 的 `qua(T w, T x, T y, T z)` 参数顺序为 w 在前，而仓颉版本参数顺序为 x, y, z, w（w 在后）。这是一个**接口形态偏差**（参见 §9）。

2. **标量+向量构造 const init(s: T, v: Vec3<T,Q>)** — 将标量 s 作为 w 分量，向量 v 的 xyz 作为 xyz 分量。对应 GLM 的 `qua(T s, vec3 const& v)` 构造函数。

3. **跨 Qualifier 构造 init<Q2>(q: Quat<T,Q2>) where Q2 <: Qualifier** — 跨 Qualifier 同类型构造，纯赋值。

4. **跨类型构造 fromQuat<U, P>(conv: (U) -> T, q: Quat<U,P>) where P <: Qualifier** — extend 块工厂函数，非 const。通过 conv 闭包将 U 类型分量转换为 T 类型。对应 GLM 的 `qua<U,P>(qua<U,P> const& q)` 显式转换构造函数。**调用示例**（下游消费者迁移提示）：
   ```
   // Float32 ← Float64 转换
   let q32 = Quat<Float32, PackedHighp>.fromQuat<Float64, PackedHighp>(
       { f64 => Float32(f64) },  // conv 闭包
       q64
   )
   // 同类型简化场景：直接使用主构造函数
   let q32_same = Quat<Float32, PackedHighp>(q32.x, q32.y, q32.z, q32.w)
   ```

5. **单位四元数工厂函数 identity(one: T)** — extend 块工厂函数，`Number<T>` 约束。返回 `Quat<T,Q>`，其中 w=one, x=T(0), y=T(0), z=T(0)。T(0) 通过 `one - one` 演算获取。**v15 修订，Issue 7 响应**：`one - one` 演算在无符号整数类型上依赖模 2^n 溢出语义（`@OverflowWrapping`），结果恒为 0，行为已定义；与 §3.4 运算符体系 `@OverflowWrapping` 统一标注一致。此为从零构造单位四元数的限定入口，与阶段二矩阵 `identity(one)` 模式一致。**调用示例**：
   ```
   // 必须显式传入 T(1) 等价物（如字面量 1.0f）
   let q = Quat<Float32, PackedHighp>.identity(1.0f)  // 单位四元数 (0, 0, 0, 1)
   ```

6. **从旋转矩阵构造 fromMat3(m: Mat3x3<T,Q>)** — 辅助工厂函数，内部调用**同包** `type_quat_cast.quatCast(m)`（v3 修订：原设计为跨包引用 gtc/quaternion.cj，现改为同包引用 type_quat_cast.cj）。**v16 修订，Issue 5 响应**：函数签名模板为 `public func fromMat3<T, Q>(m: Mat3x3<T, Q>): Quat<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier`——显式声明 `where T <: FloatingPoint<T>` 约束，而非隐式继承自内部 callee `quatCast`。整型 T（如 `Int64`）实例化时编译报类型不匹配错误；详见 §3.2.1 type_quat_cast.cj 约束说明。**调试指引**：若开发者用 `Int64` 实例化并调用 `fromMat3(m)`，编译错误将直接定位在 `fromMat3` 的签名约束处（而非内部 `quatCast` 处），提供更清晰的错误定位。非 const。**边界行为**（v3 新增契约声明）：仅对纯旋转矩阵产生有意义的四元数；对非旋转矩阵（如含缩放/平移/剪切矩阵）行为未定义，结果可能产生非单位四元数或语义错误的旋转。

7. **从旋转矩阵构造 fromMat4(m: Mat4x4<T,Q>)** — 辅助工厂函数，**v8 决策：采用手动提取策略**——直接读取 `m.c0`/`m.c1`/`m.c2` 三列构建 `Mat3x3<T,Q>(Vec3<T,Q>(m.c0.x, m.c0.y, m.c0.z), Vec3<T,Q>(m.c1.x, m.c1.y, m.c1.z), Vec3<T,Q>(m.c2.x, m.c2.y, m.c2.z))`，再调用同包 `quatCast(mat3x3)` 转换为四元数。**v16 修订，Issue 5 响应**：函数签名模板为 `public func fromMat4<T, Q>(m: Mat4x4<T, Q>): Quat<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier`——显式声明 `where T <: FloatingPoint<T>` 约束，而非隐式继承自内部 callee。整型 T 实例化时编译失败——编译错误直接定位在 `fromMat4` 签名约束处（而非内部 `quatCast` 处）。非 const。**v8/v9 决策理由（v9 强化说明）**：(a) 该手动提取路径直接使用 `Vec3<T,Q>(T, T, T)` 主构造函数构造向量分量，再使用 `Mat3x3<T,Q>(Vec3, Vec3, Vec3)` 主构造函数构造 3×3 矩阵——**两条构造路径均不携带 `one: T` 形参**（Vec3 主构造与 Mat3x3 主构造均无 `one` 形参，区别于跨维度 `fromMat` 工厂函数重载），因此 `fromMat4` 函数签名本身无需 `one: T` 形参；(b) 与 §1「系统性设计约束」中"**T(1) 的获取：必须由调用方显式传入参数（`one: T`）**"一致——本函数不调用任何需要 T(1) 的运算路径（不调用 `fromMat(Mat_Larger, one)` 跨维度工厂函数，不调用 `identity(one)` 单位矩阵工厂函数），故无需该形参；(c) **v8/v9 修订说明**：v8 修订曾引用阶段二 `cjglm/src/detail/type_mat2x2.cj:163-165` `Mat2x2.fromMat(Mat3x3, one)` 作为"列提取模式无需 `one`"的依据，但该引用本身存在内部矛盾——被引用的代码 `Mat2x2.fromMat(Mat3x3, one)` 显式携带 `one: T` 形参（即阶段二全部 9 个矩阵类型的 `fromMat` 工厂函数**均要求** `one: T` 形参，无论源/目标矩阵尺寸关系，仅同维度 `fromMat` 简化为无 `one` 形参），与"无需 `one`"结论相悖。**v9 修订**：删除错误的代码引用作为论据，改为基于本函数的实际构造路径（Vec3 主构造 + Mat3x3 主构造，均无 `one` 形参依赖）说明无需 `one` 形参的合理性，与 §1 系统性约束彻底闭环。**边界行为**：同上，依赖 `fromMat3` 的输入合法性——若 `m` 的左上 3×3 子矩阵非纯旋转矩阵，结果未定义。

8. **从两向量构造 fromVec3(u: Vec3<T,Q>, v: Vec3<T,Q>)** — 辅助工厂函数，内部实现从两个归一化轴构建四元数。依赖 geometric.cj 的 `dot`/`cross`/`normalize`（均为 stub），因此本阶段为 **stub 占位**，完整实现推迟至阶段四。**边界行为契约（v8 新增，v13 关键修订，Issue 5 响应）**：当输入向量 u, v 退化触发条件为 GLM 1.0.3 `detail/type_quat.inl:196-217`（**v13 修订**：v8 错误引用为 `ext/quaternion_common.inl:196-217`——`fromVec3` 实现位于 `detail/type_quat.inl` 的 `qua(vec3, vec3)` 构造函数，不在 ext/quaternion_common）中 `if (real_part < static_cast<T>(1.e-6f) * norm_u_norm_v)` 退化分支（**v13 修订**：v8 描述「`dot(normalize(u), normalize(v)) ≈ -1`」与实际触发条件不一致；实际 `real_part = norm_u_norm_v + dot(u, v)`，触发条件为 `norm_u_norm_v + dot(u, v) < 1e-6f * norm_u_norm_v`，等价于 `dot(u, v) < (1e-6f - 1) * norm_u_norm_v = -(1 - 1e-6f) * sqrt(dot(u, u) * dot(v, v))` ≈ `-sqrt(dot(u, u) * dot(v, v))`，即「`dot(u,v) ≈ -sqrt(dot(u,u) * dot(v,v))`」对应「`u, v` 反平行」）。退化分支内**轴选择逻辑**（**v13 修订**：v8 描述「与 u 垂直的任意轴」不准确；**v15 修订，Issue 8 响应**：补充 `normalize(t)` 归一化步骤）：GLM 实际为 `t = abs(u.x) > abs(u.z) ? vec<3, T, Q>(-u.y, u.x, static_cast<T>(0)) : vec<3, T, Q>(static_cast<T>(0), -u.z, u.y); t = normalize(t)`——基于 `abs(u.x) > abs(u.z)` 二选一选择「与 u 垂直的两条可能轴之一」：`abs(u.x) > abs(u.z)` 选 `(-u.y, u.x, 0)` 再归一化，否则选 `(0, -u.z, u.y)` 再归一化。**v15 修订**：选出的轴还需经过 `normalize(t)` 归一化确保返回纯向量四元数模长为 1（GLM `detail/type_quat.inl:196-217` 实际包含 `t = normalize(t)` 步骤）。返回 `q.w = 0` 且 `q.xyz` 模长为 1 的纯向量四元数（`real_part = 0`）。这是 GLM 对反平行输入的容错设计，避免返回零四元数导致除零。**契约声明**：`fromVec3` 对反平行输入的返回值**行为已定义**（返回 `q.w = 0` 的纯向量四元数，轴选择由 `abs(u.x) > abs(u.z)` 条件决定，行为与 GLM `detail/type_quat.inl:196-217` 一致），下游消费者可依赖该契约；对零向量输入则行为未定义（由 `normalize` stub 在阶段四补齐时确定）。

9. **从欧拉角构造 fromEuler(eulerAngles: Vec3<T,Q>)** — 辅助工厂函数，依赖 trigonometric.cj 的 `cos`/`sin`（均为 stub），因此本阶段为 **stub 占位**，完整实现推迟至阶段四。

10. **wxyz 工厂函数 wxyz(w: T, x: T, y: T, z: T)** — 静态工厂函数，参数顺序为 w, x, y, z（与 GLM `qua::wxyz(w,x,y,z)` 一致），内部返回 `Quat<T,Q>(x, y, z, w)`。提供与 GLM wxyz 习惯一致的调用入口。

### 3.4 运算符体系

所有算术运算符定义在 `Number<T>` 约束的 extend 块中（与阶段一/二一致），并统一标注 `@OverflowWrapping` 注解以保持跨类型一致性（标注对浮点类型无效果，但与阶段一 Vec3 (`type_vec3.cj:54-80`) 和阶段二全部矩阵类型 (`type_mat2x2.cj` 等) 的实践对齐）。Bool 四元数不支持算术运算。

**成员运算符**（定义在 Quat extend 块中）：

| 运算符 | 语义 | 约束 | 备注 |
|-------|------|------|------|
| 一元 `-` | 逐分量取反 | `Number<T>` | 标注 `@OverflowWrapping` |
| 二元 `+` | 四元数加法 | `Number<T>` | 标注 `@OverflowWrapping` |
| 二元 `-` | 四元数减法 | `Number<T>` | 标注 `@OverflowWrapping` |
| 二元 `*` | 四元数乘法（Hamilton 乘积） | `Number<T>` | 标注 `@OverflowWrapping` |
| 二元 `*` (Quat×Vec3) | 四元数旋转向量 | `Number<T>` | 实现：`v + (cross(QuatVector, v) * q.w + cross(QuatVector, cross(QuatVector, v))) * T(Float64(2))`（两次 Vec3 叉乘 `uv`/`uuv`，末尾乘 `T(Float64(2))` 字面量作为缩放因子，与 GLM `type_quat.inl:359-366` 一致；**v9 修订**：原 `* 2` 在 Cangjie 泛型上下文中需显式转换为 `T(Float64(2))` 字面量，避免 `T * Int64` 类型不匹配问题，与 §1「常量型 T(n) 字面量替代」策略对齐）。**v11 关键修订，Issue 3 响应，定义 `QuatVector` 符号**：`QuatVector = Vec3(q.x, q.y, q.z)` 是四元数的虚部向量（GLM `type_quat.inl:359-366` 实际命名）；完整展开公式为 `QuatVector = Vec3(q.x, q.y, q.z); uv = cross(QuatVector, v); uuv = cross(QuatVector, uv); return v + (uv * q.w + uuv) * T(Float64(2))`。**依赖 `geometric.cj` 向量 `cross`（阶段三 stub），调用将抛 `Exception("stub")`** |
| 二元 `*` (Quat×Vec4) | 四元数旋转向量（保留 w） | `Number<T>` | 实现：`Vec4(q * Vec3(v), v.w)`（其中 `q * Vec3(v)` 是上一行 `Quat×Vec3` 运算符的复用，保留 `v.w` 作为输出 Vec4 的 w 分量；**v11 关键修订，Issue 3 响应，明确 `Vec4(q * Vec3(v), v.w)` 公式含义**：第一参数 `q * Vec3(v)` 是 `Quat×Vec3` 运算符返回的 Vec3 结果，第二参数 `v.w` 是输入 Vec4 的 w 分量原样传递，构造输出 Vec4；**v12 关键修订，Issue 9 响应：明确 Vec4 主构造函数双参数版本**——本公式依赖 Vec4 主构造函数支持 `Vec4<T, Q>(Vec3<T, Q>, T)` 两参数签名，第一参数为 Vec3 旋转结果（xyz 分量），第二参数为 T 类型 w 分量原样传递。该双参数主构造函数在阶段一 `type_vec4.cj` 中已实现——阶段一 Vec4 主构造函数（v12 核验，Issue 9 响应）已声明 `init(vec3: Vec3<T, Q>, w: T)` 两参数版本作为 Vec4 标准构造入口之一（与逐分量构造 `init(x: T, y: T, z: T, w: T)` 并列），下游按设计字面实现 `Vec4(q * Vec3(v), v.w)` 时编译可行**）。**通过 Vec3 中间路径间接依赖 `Quat×Vec3`，阶段三调用同样抛 stub 异常** |
| 二元 `*` (Quat×T) | 四元数×标量 | `Number<T>` | 标注 `@OverflowWrapping` |
| 二元 `/` (Quat/T) | 四元数/标量 | `Number<T>` | 标注 `@OverflowWrapping` |
| `==` | 精确比较（返回 bool） | `Equatable<T>` | |
| `!=` | 不等比较 | `Equatable<T>` | |

**命名约定说明（v3 新增）**：上表中 `Quat×Vec3` 行公式中的 `cross(QuatVector, v)` 调用的是 **Vec3 叉乘**（定义于 `geometric.cj`，参数为 `Vec3<T,Q>`），**非 §3.7 中的四元数 `cross`（Hamilton 乘积）**。两者通过类型消歧区分（参数类型为 Vec3 时调用 Vec3 叉乘，参数类型为 Quat 时调用四元数 Hamilton 乘积）。

**Bool 四元数算术运算编译期拒绝（v7 澄清）**：上表算术运算符（一元 `-`/二元 `+`/`-`/`*`/Quat×T/Quat/T）均以 `Number<T>` 为约束。`Bool` 类型不实现 `Number<T>` 接口，因此 `Quat<Bool, Q>` 实例化时算术运算符重载因类型约束不满足而**编译期自动拒绝**（与阶段二 D33 Bool 矩阵策略一致）。Bool 四元数仅可使用 `==`/`!=` 比较（`Equatable<Bool>` 由 stdlib 派生支持），符合 D17 决策意图。

**Vec extend 块成员运算符**（定义在 Vec3/Vec4 extend 块中）：

| 运算符 | 语义 | 约束 | 备注 |
|-------|------|------|------|
| Vec3×Quat | `inverse(q) * v` | `Number<T>` | 通过 `inverse` 路径，依赖 `quaternion_common.cj.inverse`（已实现）；`inverse` 内部不依赖 `geometric.cj` stub |
| Vec4×Quat | `inverse(q) * v`（保留 w） | `Number<T>` | 通过 Vec3 中间路径 |

**实现链路注释（v7 澄清）**：本阶段 `Vec3×Quat`/`Vec4×Quat` 可立即调用，依赖链为 `Vec×Quat` → `inverse(q) * v` → `inverse`（§3.11 已完整实现） → `conjugate(q) / dot(q, q)`，其中 `conjugate` 无外部依赖（仅逐分量操作）、`dot` 由 `quaternion_geometric.cj`（§3.7）已完整实现。整个依赖链终止于已实现的算术运算和 `dot` 函数，**无 stub 中转**，与 `Quat×Vec3`（依赖 `geometric.cj` 向量 `cross` stub）形成对比。

**全局具名函数**（scalar_quat_ops.cj，处理标量左侧运算）：

| 函数 | 语义 | 约束 |
|------|------|------|
| `add<T, Q>(s: T, q: Quat<T, Q>)` | 标量加四元数 | `Number<T>` |
| `sub<T, Q>(s: T, q: Quat<T, Q>)` | 标量减四元数 | `Number<T>` |
| `mul<T, Q>(s: T, q: Quat<T, Q>)` | 标量乘四元数 | `Number<T>` |
| `div<T, Q>(s: T, q: Quat<T, Q>)` | 标量除四元数 | `Number<T>` |

注：标量×四元数乘法无需单独"交换律别名"函数——`Quat×T` 运算符（右操作数为 T）已通过 §3.4 成员运算符表的 `二元 * (Quat×T)` 行覆盖；而 `T * Quat`（左操作数为 T）由于仓颉运算符重载规则——左操作数类型决定 operator 函数归属——无法定义为 Quat 的成员运算符，必须通过 `scalar_quat_ops.cj` 的全局函数 `mul<T, Q>(s: T, q: Quat<T, Q>)` 实现（与 D05 决策一致）。**v9 修订**：删除原描述中"仓颉 `Number<T>` 加法/乘法具备交换律语义"的错误表述——`Number<T>` 接口本身**不提供交换律语义**，仅约束四则运算的实现；标量×四元数（左操作数为 T）通过 `scalar_quat_ops.cj` 全局函数实现的根本原因是左操作数类型决定 operator 函数归属，而非 `Number<T>` 提供交换律覆盖。仓颉函数重载规则禁止重复签名（同参数列表+同返回类型无法构成有效重载，将触发"重复定义"编译错误），因此 `scalar_quat_ops.cj` 的 `mul` 全局函数与 `type_quat.cj` 的 `Quat×T` 成员运算符不构成重载冲突——前者实现 `T * Quat`，后者实现 `Quat * T`，左操作数类型不同。

**一元 + 运算符**：仓颉不支持重载一元 `+` 运算符（与 deviations.md IF-01 一致），`+q` 不可编译，直接使用 `q` 即可。

**复合赋值运算符**：`+=`/`-=`/`*=`（四元数乘法）/`*=`（标量乘法）/`/=` 由编译器自动生成（仓颉语言规范保证，与阶段二一致）。

### 3.5 ext/vector_relational.cj

**角色**：提供向量 epsilon 容差比较和 ULP 比较扩展函数。

**职责**：定义 8 个函数（4 个 epsilon 版本 + 4 个 ULP 版本），每个函数按 Vec1~Vec4 分量数提供泛型重载。

**epsilon 版本**（完整实现）：
- `equal(x: VecN<T,Q>, y: VecN<T,Q>, epsilon: T): VecN<Bool,Q>` — 逐分量 `|x-y| < epsilon`（严格小于，与 GLM 1.0.3 `glm/gtc/epsilon.inl:32-41` 中 `epsilonEqual` 实现一致；**v9 修订**：原引用 `func_vector_relational.inl:18-22` 错误——GLM 1.0.3 的 `func_vector_relational.inl` 中**不包含 epsilon 版本**的 `equal`/`notEqual`，epsilon 版本位于 `glm/gtc/epsilon.inl`（文件层面属 gtc 子包））
- `equal(x: VecN<T,Q>, y: VecN<T,Q>, epsilon: VecN<T,Q>): VecN<Bool,Q>` — 逐分量容差向量版本，同上严格小于语义
- `notEqual(x: VecN<T,Q>, y: VecN<T,Q>, epsilon: T): VecN<Bool,Q>` — 逐分量 `|x-y| >= epsilon`（大于等于，与 epsilon 版本互补）
- `notEqual(x: VecN<T,Q>, y: VecN<T,Q>, epsilon: VecN<T,Q>): VecN<Bool,Q>` — 逐分量容差向量版本

**ULP 版本**（依赖 `detail::float_t<T>` 位表示——仓颉无等价机制）：
- 仓颉无 `reinterpret_cast` 或浮点位表示直接访问能力（`float_t<T>::i`/`mantissa()`/`exponent()`/`negative()` 等在 C++ 中通过 union 技巧实现），ULP 比较函数在仓颉中**无法完整实现**。
- **ULP 比较的 stub/替代策略**：ULP 版本的 4 个函数（`equal`/`notEqual` 含 `int ULPs` 和 `VecN<int,Q> ULPs` 变体）**本阶段以空桩占位**，待阶段四评估仓颉 `std.math.Float` 或 CFFI 方案实现位级浮点比较后补齐。

**完整函数清单**（本阶段完整实现，4 个 epsilon 版本 × 4 个分量数 = 16 个重载）：

| 函数 | 分量数 | 签名模式 |
|------|--------|---------|
| equal | Vec1~Vec4 | `func equal<T, Q>(x: VecN<T,Q>, y: VecN<T,Q>, epsilon: T): VecN<Bool,Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier` |
| equal（向量 epsilon） | Vec1~Vec4 | `func equal<T, Q>(x: VecN<T,Q>, y: VecN<T,Q>, epsilon: VecN<T,Q>): VecN<Bool,Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier` |
| notEqual | Vec1~Vec4 | 同上模式 |
| notEqual（向量 epsilon） | Vec1~Vec4 | 同上模式 |

**依赖分析**：epsilon 版本内部使用 `abs`（来自 common.cj stub）和 `lessThanEqual`/`greaterThan`（Vec 的 extend 块成员函数，需 `Comparable<T>` 约束）。由于 common.cj 中 `abs` 为 stub，epsilon 版本也**依赖 common.cj stub**。

**依赖 common.cj stub 的递归问题（v3 修订）**：`vector_relational.cj` 的 `equal`/`notEqual` epsilon 版本内部调用 `abs(x - y)` 和 `lessThanEqual(abs(x - y), epsilon)`，其中 `abs` 来自 common.cj（当前为 stub）。**解决策略**：在 vector_relational.cj 中的 epsilon 比较函数内部，将 `abs` 内联展开为 `let d = x - y; VecN(if (d.x >= T(0)) { d.x } else { -d.x }, ...)` 模式，避免依赖 common.cj 的 `abs` stub。这要求 `Number<T>` 约束下有 `Comparable<T>` 以支持 `>=` 比较。此内联方式与阶段一 `ComputeEqualNumeric` 中使用 `std.math.abs` 的策略一致——此处优先内联以消除对 common.cj stub 的运行时依赖风险。

### 3.6 ext/quaternion_relational.cj

**角色**：提供四元数 epsilon 容差比较和精确比较扩展函数。

**职责**：定义 4 个函数（精确比较 2 个 + epsilon 比较 2 个）：

| 函数 | 语义 |
|------|------|
| `equal(x: Quat<T,Q>, y: Quat<T,Q>): Vec4<Bool,Q>` | 逐分量精确比较 |
| `equal(x: Quat<T,Q>, y: Quat<T,Q>, epsilon: T): Vec4<Bool,Q>` | 逐分量容差比较（与 vector_relational 严格小于语义一致） |
| `notEqual(x: Quat<T,Q>, y: Quat<T,Q>): Vec4<Bool,Q>` | 逐分量精确不等 |
| `notEqual(x: Quat<T,Q>, y: Quat<T,Q>, epsilon: T): Vec4<Bool,Q>` | 逐分量容差不等 |

**依赖分析**：精确比较版本直接使用 `==` 比较，无外部依赖。epsilon 比较版本使用内联 `abs` 模式和 `lessThanEqual`/`greaterThanEqual`（Vec4 的 Comparable 约束），与 ext/vector_relational.cj 策略一致。

### 3.7 ext/quaternion_geometric.cj

**角色**：提供四元数几何函数（dot、length、normalize、cross）。

**职责**：
- `dot(x: Quat<T,Q>, y: Quat<T,Q>): T` — 四元数点积 `x.w*y.w + x.x*y.x + x.y*y.y + x.z*y.z`。可直接实现，不依赖 geometric.cj 的向量 dot（虽然在 GLM 中委托给 `compute_dot<qua<T,Q>,T>` 特化，但仓颉版本直接内联计算）。
- `length(q: Quat<T,Q>): T` — 四元数长度 `sqrt(dot(q,q))`。依赖 `std.math.sqrt`（仓颉标准库提供），不依赖 geometric.cj。**Float32 实例的 sqrt 处理**：`std.math.sqrt` 提供 Float16/Float32/Float64 重载（见 §1 v11 修订），T=Float32 实例化时直接调用 `std.math.sqrt(Float64(dot_qq))` 并 `T(...)` 转换回目标类型；T=Float64 时直接使用 `std.math.sqrt` 返回值。
- `normalize(q: Quat<T,Q>): Quat<T,Q>` — 归一化四元数。**v11 关键修订，Issue 2 响应**（补充 GLM 零四元数保护行为）：实现公式与 GLM `ext/quaternion_geometric.inl:17-24` 完全一致——`tmp1 = length(q); if (tmp1 <= T(Float64(0))) { return identity_q } else { return q / tmp1 }`，其中 `tmp1 <= T(0)` 时返回**单位四元数**（`Quat(T(Float64(0)), T(Float64(0)), T(Float64(0)), T(Float64(1)))`）。**v14 关键修订，Issue 2 响应：T(0) 字面量替代**——零保护分支返回值中 xyz 分量的 T(0) 原策略「通过 `one - one` 演算（需 `one: T` 形参显式传入）」在本函数签名 `normalize(q: Quat<T,Q>): Quat<T,Q>`（不含 `one: T` 形参）中不可用，**统一修订为 `T(Float64(0))` 字面量替代路径**（与 `axis` 函数中 `Vec3(T(Float64(0)), T(Float64(0)), T(Float64(1)))` 模式一致），T(1) 通过 `T(Float64(1))` 字面量替代获取（与 §1「常量型 T(n) 字面量替代」v14 修订策略一致，同时覆盖 T(0) 和 T(1)）。**设计意图**：与 §5.1「normalize 零四元数返回单位四元数」契约对齐，避免下游按字面实现时零四元数除零产生 NaN 分量。**length 极小值边界行为（v11 新增）**：`tmp1` 为极小正数（如浮点最小次正规数）时不触发零保护分支，返回 `q / tmp1` 结果各分量趋向 Inf/NaN（与 GLM 行为一致，GLM 不做 length 极小值保护）；如需防止此类溢出，应在调用 `normalize` 前自行检查 `length(q) >= epsilon<T>()`。**T(0)/T(1) 获取路径（v14 关键修订，Issue 2 响应，统一采用 §1 作法）**：本函数体内 `T(0)` 与 `T(1)` 的获取策略遵循 §1「系统性设计约束」段的 **v14 修订**统一约定——T(0) 与 T(1) 均通过 `T(Float64(0))`/`T(Float64(1))` 字面量替代路径获取，无需 `one: T` 形参；两者**不**在本函数体内重复展开获取路径说明。**实现策略（v11 补强）**：`where T <: Number<T>` 约束下调用 `length(q)`，根据 §3.7 `length` 函数约束收紧策略（与 `length` 函数本身的 `T <: Number<T>` 约束保持一致，不引入额外 `T <: FloatingPoint<T>` 约束，使整数四元数 `normalize` 仍可调用——返回 `q / tmp1` 整除结果）。**v13 关键修订，Issue 6 响应：交叉引用**——`normalize` 函数完整边界行为契约（零四元数 + length 极小值 + 实现公式）详见 §5.3 边界条件表「零四元数 `(0,0,0,0)`」+「`length(q)` 极小值」两行的整合描述；§3.13.2 审计节 normalize 行 + §11.6 四命名空间接口可达性矩阵 normalize 行均同步新增反向引用，参见相应章节。
- `cross(q1: Quat<T,Q>, q2: Quat<T,Q>): Quat<T,Q>` — 四元数叉积（Hamilton 乘积的逐分量展开，四元数"cross"语义与向量叉乘不同：向量 `cross` 产生垂直于输入平面的向量，四元数 `cross` 产生 Hamilton 乘积的逐分量展开形式，结果仍是四元数）。可直接完整实现。

**命名歧义说明（v3 强化）**：上述 `cross` 函数与阶段二 stub 中 `geometric.cj` 的向量 `cross`（面向 Vec3 叉乘，产生垂直向量）存在概念差异——四元数 `cross` 即 Hamilton 乘积（结果为四元数），与向量叉乘（结果为向量）含义完全不同。**下游消费者判别方法**：
- 参数为 `Vec3<T,Q>` 时调用向量 `cross`（geometric.cj，当前 stub）
- 参数为 `Quat<T,Q>` 时调用四元数 `cross`（quaternion_geometric.cj，已完整实现）
- §3.4 `Quat×Vec3` 旋转公式中的 `cross(QuatVector, v)` 内部调用的是**向量 `cross`**（参数 QuatVector 和 v 均为 Vec3），与本节四元数 `cross` 不冲突

**关键发现**：这 4 个函数的依赖链终止于 `std.math.sqrt`（仓颉标准库提供），**不依赖**阶段二/三的任何 stub 文件。本阶段可**完整实现**。

### 3.8 ext/quaternion_transform.cj

**角色**：提供四元数变换函数（rotate）。

**依赖分析**：GLM 的 `quaternion_transform.hpp` 依赖 common.hpp、trigonometric.hpp、geometric.hpp。其中 `rotate` 函数使用 `sin`/`cos`（来自 trigonometric.cj stub）和 `length`（来自 geometric.cj stub）。

**本阶段实现策略**：
- `rotate(q: Quat<T,Q>, angle: T, axis: Vec3<T,Q>): Quat<T,Q>` — 依赖 `sin`/`cos` 和 `length`（均为 stub），本阶段 **stub 占位**

**修正**：经仔细审查 `quaternion_transform.hpp` 和 `.inl`，GLM 中 `ext/quaternion_transform.hpp` 仅定义了 `rotate` 一个函数。而 `angleAxis` 定义在 `ext/quaternion_trigonometric.hpp` 中。`quatLookAt`/`quatLookAtRH`/`quatLookAtLH` 定义在 `gtc/quaternion.hpp` 中。

因此 ext/quaternion_transform.cj 本阶段仅包含 `rotate` 的 stub。其余函数对应的归入各自的模块。

### 3.9 ext/quaternion_trigonometric.cj

**角色**：提供四元数三角函数（angle、axis、angleAxis）。

**依赖分析**：
- `angle(x: Quat<T,Q>): T` — 依赖 `abs`、`asin`、`acos`、`sqrt`、`pi<T>()`（scalar_constants）。`abs` 可内联，`asin`/`acos` 为 trigonometric.cj stub。**stub 占位**。
- `axis(x: Quat<T,Q>): Vec3<T,Q>` — 实现公式（与 GLM `ext/quaternion_trigonometric.inl:20-27` 一致）：`tmp1 = T(Float64(1)) - x.w * x.w`；若 `tmp1 <= T(Float64(0))` 返回 `Vec3(T(Float64(0)), T(Float64(0)), T(Float64(1)))`（z 轴单位向量）；否则 `tmp2 = T(Float64(1)) / T(std.math.sqrt(tmp1))`（**v13 关键修订，Issue 3 响应：移除 `Float64(tmp1)` 冗余转换层，与 §1 方案 A 一致**——`std.math.sqrt` 提供 Float16/Float32/Float64 重载，`tmp1` 类型为 T 时编译器按实例化类型自动选择对应重载，无需显式 Float64 转换），返回 `Vec3(x.x*tmp2, x.y*tmp2, x.z*tmp2)`。依赖 `std.math.sqrt`（§1 v11 修订确认提供 Float16/Float32/Float64 重载，方案 A 推荐直接调用）；实现公式遵循 `tmp2 = T(Float64(1)) / T(std.math.sqrt(tmp1))` 路径。同时依赖 `T(Float64(1))` 字面量替代（无需 `one: T` 形参），**可完整实现**。**T(1) 获取方式（v8 修订）**：v7 文档描述「T(1) 演算通过 `x.w*x.w` 取得」是错误的——`x.w*x.w` 是 w² 而非 1，无法作为 T(1) 的演算路径（v8 明确删除该错误描述）。本函数采用 §1「系统性设计约束」中 v8 新增的「常量型 T(1) 字面量替代」策略：`T(Float64(1))` 显式转换路径——`Float64(1.0)` 是字面量，`T(Float64(1.0))` 在 `T = Float64` 时返回 1.0，在 `T = Float32` 时返回 1.0f，无需 `one: T` 形参污染函数签名。**边界行为（v3 新增契约，v5 修订，v8 强化，v10 公式精修）**：触发 `Vec3(T(0), T(0), T(1))` 返回值的条件为 `T(Float64(1)) - x.w*x.w <= T(Float64(0))`（典型场景：单位四元数 `(0, 0, 0, 1)` 即 `|w| >= 1`）；对于真正的零四元数 `(0, 0, 0, 0)`，`tmp1 = 1 > 0` 进入 else 分支返回 `Vec3(0, 0, 0)`（**注意：v3 原描述的「内部 `normalize(Vec3(0, 0, 0))` 返回 `Vec3(T(1), T(0), T(0))`」为虚构实现，GLM 源码不调用 `normalize`，v5 修订纠正**）。
- `angleAxis(angle: T, axis: Vec3<T,Q>): Quat<T,Q>` — 依赖 `sin`/`cos`（trigonometric.cj stub）。**stub 占位**。

**修正本阶段策略**：
- `axis` — **完整实现**（依赖仅 `std.math.sqrt` 和 T(1) 演算，零四元数保护行为见上）
- `angle` — **stub 占位**（依赖 trigonometric.cj 的 `asin`/`acos`）
- `angleAxis` — **stub 占位**（依赖 trigonometric.cj 的 `sin`/`cos`）

### 3.10 ext/quaternion_exponential.cj

**角色**：提供四元数指数函数（exp、log、pow、sqrt）。

**依赖分析**：
- `exp(q: Quat<T,Q>): Quat<T,Q>` — 依赖 `length`（quaternion_geometric，已实现）、`epsilon<T>()`（scalar_constants.cj，line 10 用于 `Angle < epsilon<T>()` 退化检测）、`cos`/`sin`（trigonometric.cj stub）。**stub 占位**。
- `log(q: Quat<T,Q>): Quat<T,Q>` — 依赖 `length`（quaternion_geometric）、`epsilon<T>()`（scalar_constants.cj，line 23 用于 `Vec3Len < epsilon<T>()` 退化检测）、`pi<T>()`（scalar_constants.cj，line 28 用于 `wxyz(log(-q.w), pi<T>(), ...)`）、`atan`/`log`（trigonometric.cj/exponential.cj 接口——**v11 修订，Issue 7 关联**：std.math `atan`/`log` 实际提供 Float16/Float32/Float64 重载，T=Float32 实例化时直接调用即可）、`std::numeric_limits<T>::infinity()` 等价物（line 30 用于 w=0 退化分支，**v11 关键修订，Issue 8 响应**：仓颉 stdlib **实际提供** `FloatingPoint<T>.getInf()` 静态方法——v10 描述「不提供」错误——`FloatingPoint<T>` 接口（依据 `cangjie-original-docs/std/math/math_package_api/math_package_interfaces.md` 第 5-17 行定义）实际提供 6 个静态方法（`getE`/`getInf`/`getPI`/`getMinDenormal`/`getMinNormal`/`getNaN`）+ 3 个实例方法（`isInf`/`isNaN`/`isNormal`），下游实现应直接调用 `FloatingPoint<T>.getInf()` 而非类型分派；fallback 路径仍可使用 `T(1)/T(0)` 显式构造获取正无穷（仅对浮点类型有效））。**stub 占位**。
- `pow(x: Quat<T,Q>, y: T): Quat<T,Q>` — 依赖 `epsilon<T>()`/`abs`/`clamp`/`asin`/`acos`/`sin`/`cos`/`sqrt`/`cos_one_over_two<T>()` + **调用 `std.math.pow` 实数降级路径两次**（GLM line 65 + line 78，**v11 关键修订，Issue 6 响应**：v10「递归调用」措辞不准确——line 65 与 line 78 是两次独立的 `std.math.pow` 调用而非 self-recursion）+ `std::numeric_limits<T>::min()` 等价的仓颉次正规数边界检查。其中 `epsilon<T>()`/`cos_one_over_two<T>()` 来自 scalar_constants.cj（line 52：`if(abs(x.w / magnitude) > cos_one_over_two<T>())`），`abs`/`clamp` 来自 common.cj stub，`asin`（line 68：`Angle = asin(sqrt(VectorMagnitude) / magnitude)`）/`acos`/`sin`/`cos` 来自 trigonometric.cj stub，`sqrt` 来自 std.math，`std.math.pow` 来自仓颉标准库（line 65 + line 78 两次独立调用——**v11 关键修订，Issue 5 响应，补充 GLM line 65/78 仓颉等价翻译**）：
  - **GLM line 65 翻译**：`return qua<T, Q>::wxyz(pow(x.w, y), 0, 0, 0)` —— GLM `wxyz(w, x, y, z)` 构造签名（w 在前）；仓颉等价为 `Quat<T,Q>(T(std.math.pow(Float64(x.w), Float64(y))), T(Float64(0)), T(Float64(0)), T(Float64(0)))`（仓颉主构造函数顺序为 x/y/z/w，故 `Quat(0, 0, 0, pow(x.w, y))`；**v11 修订，Issue 7 关联**：T 实例化为 Float32 时 `std.math.pow` 直接接受 `Float32, Float32` 重载，无需 `Float64(...)` 转换层），调用语义为「次正规数过小」分支的实数降级路径
  - **GLM line 78 翻译**：`T Mag = pow(magnitude, y-1)` —— 仓颉等价为 `T Mag = T(std.math.pow(Float64(magnitude), Float64(y - T(1))))`（与 line 65 翻译同理；T=Float32 实例化时 `std.math.pow(Float32, Float32)` 直接返回 Float32），调用语义为一般路径的实数降级路径
- `std::numeric_limits<T>::min()` 用于次正规数边界（line 63：`if (VectorMagnitude < (std::numeric_limits<T>::min)())`，**v11 关键修订，Issue 8 关联**：仓颉 stdlib 实际提供 `FloatingPoint<T>.getMinDenormal()` 静态方法（依据 `cangjie-original-docs/std/math/math_package_api/math_package_interfaces.md` 第 49-60 行定义）——下游实现应通过 `FloatingPoint<T>.getMinDenormal()` 直接获取；v10 描述「`FloatingPoint<T>` 接口本身无任何实例方法」错误——`FloatingPoint<T>` 接口实际提供 6 个静态方法（`getE`/`getInf`/`getPI`/`getMinDenormal`/`getMinNormal`/`getNaN`）+ 3 个实例方法（`isInf`/`isNaN`/`isNormal`），下游实现应优先使用静态方法路径而非类型分派）。**命名消歧与 Float64 转换（v5 新增，v7 澄清，v10 合并，v11 修订）**：将 v5「命名消歧」与 v7「Float64 转换依赖」两段合并为单一子段（**v10 关键修订**：v9 设计中两段功能重叠，下游阅读时产生「§1 已说明通用规则为何 §3.10 又重复一次」的疑问）。本段统一说明：四元数 `pow` 函数体内部调用的 `pow(x.w, y)` 是**实数版本** `std.math.pow`（**v11 关键修订，Issue 7 关联**：v10 描述的「`std.math.pow(Float64, Float64): Float64`」实际只是 4 个重载之一——仓颉 stdlib `cangjie-original-docs/std/math/math_package_api/math_package_funcs.md` 第 4289-4397 行明确定义 `pow(Float32, Float32): Float32`、`pow(Float32, Int32): Float32`、`pow(Float64, Float64): Float64`、`pow(Float64, Int64): Float64` 共 4 个重载——下游实现时应根据 T 实例化类型选择对应重载：当 T=Float32 时调用 `std.math.pow(Float32, Float32): Float32`（直接调用，无需 Float64 转换）；当 T=Float64 时调用 `std.math.pow(Float64, Float64): Float64`），与四元数 `pow` 本身（`pow(Quat, T): Quat`）通过参数类型消歧（第一参数类型 `Float32`/`Float64` 与 `Quat<T,Q>` 区分）；`pow(Quat<Float32, Q>, Float32)` 实现路径遵循 §1 v11 修订策略方案 A（直接调用 std.math Float32 重载），fallback 路径 `exp(y * log(x.w))` 同步遵循 §1 v11 修订（std.math.exp/log 同样提供 Float16/Float32/Float64 重载）；若 `std.math.pow` 不可用需以 `exp(y * log(x.w))` 替代实现。**stub 占位**。
- `sqrt(x: Quat<T,Q>): Quat<T,Q>` — 委托 `pow(x, T(0.5))`。**stub 占位**。

**v5 修订**：4 个函数均依赖 trigonometric.cj/common.cj stub，本阶段全部 **stub 占位**。`pow` 的依赖关系以 GLM `ext/quaternion_exponential.inl:41-80` 实际实现为准（v3 引用 `24-43` 行号错误，已纠正）。`exp`/`log`/`pow` 函数分别补充 `epsilon<T>()`、`pi<T>()` 等 scalar_constants.cj 依赖。`pow` 补充 `cos_one_over_two<T>()`/`asin`/`std.math.pow`/`std::numeric_limits<T>::min()` 等价物依赖。

### 3.11 ext/quaternion_common.cj

**角色**：提供四元数公共函数（mix、lerp、slerp、conjugate、inverse、isnan、isinf）。

**依赖分析**：
- `dot` — 委托 quaternion_geometric.cj，完整可用
- `conjugate(q: Quat<T,Q>): Quat<T,Q>` — **完整实现**。仅对 x/y/z 三个分量取反，w 分量保持不变：`Quat(-q.x, -q.y, -q.z, q.w)`（与 GLM `ext/quaternion_common.inl:112-116` `wxyz(q.w, -q.x, -q.y, -q.z)` 一致；**v5 修订**：v3 描述「仅涉及逐分量取反」语义不准确，逐分量取反对应 `negative` 运算符 `-q`，而 `conjugate` 仅对 x/y/z 取反、保留 w）。等价实现可基于主构造函数或 wxyz 工厂函数。**const func 适用性（v10 新增，Issue 6 响应，v12 关键修订，Issue 7 响应：补充阶段二实践依据）**：`conjugate` 函数体仅涉及 `Quat` 主构造函数的逐分量取反调用（`Quat(-q.x, -q.y, -q.z, q.w)`），无 `assert`/无 `throw`/无 `dot`/`normalize`/其他非 const 函数调用，**可声明为 `const func`**。**阶段二实践依据（v12 新增，Issue 7 响应）**：阶段一 `cjglm/src/detail/type_vec3.cj:54-80` 已成功声明 27 个逐分量运算符与函数为 `const func`，包括 `negative(vec3): Vec3`（逐分量取反，等价于 `-v`）、`negate(vec3): Vec3`（等价于 `-v` 的别名）等——`conjugate` 函数体实现模式（`Quat(-q.x, -q.y, -q.z, q.w)` 主构造函数 + 逐分量取反）与阶段一 `negative`/`negate` 的实现模式（`Vec3(-v.x, -v.y, -v.z)`）完全一致；阶段二全部矩阵类型（`type_mat2x2.cj` 等 9 个文件）的逐分量运算符（如 `negative(mat): Mat`）同样已声明为 `const func` 实践成功。**实践结论**：`conjugate` 在仓颉侧**可声明为 `const func`**，与阶段一 Vec 家族 27 个 const func + 阶段二 Mat 家族逐分量 const func 的实践一致；下游按 `Quat(-q.x, -q.y, -q.z, q.w)` 主构造函数调用模式实现即可，无需担心编译期 const 上下文拒绝。**v10 附注**：若仓颉 const 函数还有其他限制（如不能调用非 const 自由函数、不能包含复杂表达式），则该论断需进一步评估；与 §5.4 const 上下文约束段保持一致。**§8 编码启动前验证项新增（v12 修订，Issue 7 响应）**：新增验证项 24「`conjugate` const func 编译可行性验证」，与 §8 现有验证项 1-23 一并执行
- `inverse(q: Quat<T,Q>): Quat<T,Q>` — `conjugate(q) / dot(q, q)`。**完整实现**（依赖 dot 和 除法运算符）。**边界行为（v3 新增契约，**v10 措辞统一，Issue 13 响应**）**：
  - 浮点四元数 `dot(q,q) == T(0)` 时除以零产生 Inf/NaN 分量（与 GLM 行为一致，GLM 不做零除保护）
  - 整数四元数 `dot(q,q) == T(0)` 时触发仓颉 `ArithmeticException`（**v10 措辞统一**：与浮点 Inf/NaN 行为不同；§5.3 边界条件表「整数 `inverse`」行措辞同步统一为「触发仓颉 `ArithmeticException`」，与本节描述对齐）
- `lerp(x, y, a): Quat<T,Q>` — `x * (1 - a) + y * a`。**完整实现**（运行时，非 const，含 `assert(a >= 0 && a <= 1)` 断言与 GLM `ext/quaternion_common.inl:28-38` 一致）。`const` 约束说明（v3 新增）：lerp 不可声明为 `const func`，因函数体内 `assert` 不是 `const` 函数（与 deviations.md IF-03 一致），调用时不可在 `const` 上下文（如 `const val` 初始化、`const func` 函数体）中使用。
- `slerp(x, y, a): Quat<T,Q>` — 依赖 `dot`/`acos(cosTheta)`（`trigonometric.cj` 的 `acos(T): T` 单参数版本，`v5 修订明确`）/`sin((1-a)*angle)`/`sin(a*angle)`/`sin(angle)`（`trigonometric.cj` 的 `sin(T): T` 单参数版本，`v5 修订明确`）/`mix`（标量版）+ `epsilon<T>()`。`acos`/`sin` 属 trigonometric.cj stub，`mix` 属 common.cj stub，`epsilon<T>()` 来自 scalar_constants.cj。**stub 占位**。
- `mix(x, y, a): Quat<T,Q>` — 依赖 `dot`/`acos(cosTheta)`（`trigonometric.cj` 的 `acos(T): T` 单参数版本，`v5 修订明确`）/`sin((1-a)*angle)`/`sin(a*angle)`/`sin(angle)`（`trigonometric.cj` 的 `sin(T): T` 单参数版本，`v5 修订明确`）/`epsilon<T>()`。`epsilon<T>()` 用于 `cosTheta > 1 - epsilon<T>()` 的退化检测分支。**stub 占位**。
- `slerp(x, y, a, k)` — 多旋转 slerp。**stub 占位**。**依赖关系（v5 新增）**：`dot`/`acos`/`sin`/`mix`（标量版，line 98-101 四次标量 `mix` 调用）/`epsilon<T>()`/`pi<T>()`（line 107：`T phi = angle + static_cast<T>(k) * glm::pi<T>();`）。其中 `pi<T>()` 来自 scalar_constants.cj，`mix` 来自 common.cj stub。**`k` 类型决策（v3 明确）**：采用 `slerp<T, Q>(x: Quat<T,Q>, y: Quat<T,Q>, a: T, k: Int64)` 简化版签名。GLM 4-arg `slerp` 使用独立整型参数 `S`（通过 `static_assert(is_integer)` 约束），仓颉版本固定为 `Int64`（与 deviations.md DV-03「移位运算右操作数固定为 Int64」风格一致），牺牲泛型灵活性换取签名简洁性。**理由**：阶段三 slerp 函数本身为 stub，固定 `Int64` 简化签名不影响本阶段实施；阶段四 slerp 完整实现时若需泛型 K 可扩展。
- `isnan(q: Quat<T,Q>): Vec4<Bool,Q>` — 依赖 `x.isNaN()` 实例方法（仓颉 `std.math` 仅提供实例方法，**不提供**顶层 `std.math.isNaN(x)` 函数）。**T 类型约束（v4 修订，v7 接口名修订）**：函数签名添加 `where T <: FloatingPoint<T>` 约束（与 §3.12 `epsilon<T>()` 约束收紧策略一致），限制函数仅对浮点类型 T 可调用。当调用方实例化 `Quat<Int64, PackedHighp>` 等整数四元数并调用 `isnan(q)` 时，编译期报类型不匹配错误（`Int64` 不实现 `FloatingPoint<Int64>` 接口），而非运行时报 `isNaN` 实例方法不存在错误。**Fallback 模式（理论不需要，仅兼容占位说明）**：由于 `FloatingPoint<T>` 是 stdlib 原生接口（`cangjie-std/math/README.md` 第 117 行明确定义），编译期保证可用，无「接口不可用」风险；此 fallback 仅作 v7 修订前的兼容占位说明——若某实现版本缺失 `FloatingPoint<T>` 接口（极小概率），则采用与 `epsilon<T>()` 类似的运行时分派模式——通过 `match` 或 `if-else` 对 `q.x` 的具体类型进行 `Float32`/`Float64` 分派，非浮点 T 实例化时抛 `Exception("isnan not defined for non-floating-point types")`。**实现路径**：约束通过后采用实例方法路径 `Vec4(q.x.isNaN(), q.y.isNaN(), q.z.isNaN(), q.w.isNaN())`。
- `isinf(q: Quat<T,Q>): Vec4<Bool,Q>` — 依赖 `x.isInf()` 实例方法。**T 类型约束（v4 修订，v7 接口名修订）**：与 `isnan` 完全一致，函数签名添加 `where T <: FloatingPoint<T>` 约束；fallback 模式与 `isnan` 一致。**实现路径**：约束通过后采用实例方法路径 `Vec4(q.x.isInf(), q.y.isInf(), q.z.isInf(), q.w.isInf())`。

**本阶段策略修正**：
- **完整实现**：`conjugate`、`inverse`、`lerp`（含断言 + 非 const）、`isnan`、`isinf`
- **stub 占位**：`mix`、`slerp`（2 版本，4 参数版 `k: Int64`）

### 3.12 scalar_constants 与 gtc/constants

**ext/scalar_constants.cj**：
- 提供 3 个泛型函数：`epsilon<T>()`、`pi<T>()`、`cos_one_over_two<T>()`
- 实际实现位于 `glm.detail.scalar_constants.cj`（声明 `package glm.detail`），ext/ 文件仅做 `public import` 重导出
- 依赖仅 `setup.cj`（GLM_CONFIG_* 配置常量），可**完整实现**
- **整数类型 T 的行为契约（v3 新增，v7 接口名修订）**：约束收紧为 `T <: FloatingPoint<T>`（stdlib 原生接口，`cangjie-std/math/README.md` 第 117 行）或等价约束（如仓颉版本不支持，则采用 `T <: Float32 | Float64`）。**若仓颉泛型不支持窄约束**，则在 `match` 中增加 `case _ => throw Exception("epsilon/pi/cos_one_over_two not defined for non-floating-point types")` 显式错误分支。GLM 1.0.3 `scalar_constants.inl:36-43` 使用 `static_assert(std::numeric_limits<genType>::is_iec559, ...)` 静态断言非浮点类型时编译失败——仓颉版本采用运行时异常等价行为。
- **具体类型分派**（与 deviations.md DV-04 的 `epsilonOf` 策略一致，需 `hint: T` 参数辅助类型推断）：对 Float32 返回 `Float32(1.1920929e-7)`，对 Float64 返回 `Float64(2.220446049250313e-16)`；`pi<T>()` 和 `cos_one_over_two<T>()` 同理使用具体类型硬编码值
- **与 `shim_limits.cj:25` `epsilonOf<T>(hint)` 关系（v10 新增，Issue 4 响应）**：阶段二 `cjglm/src/detail/shim_limits.cj:25` 已存在同名语义的 `public func epsilonOf<T>(hint: T): T where T <: Number<T>` 函数（通过 `NumericLimits<T>.epsilon(hint)` 内部实现，规则与本设计完全一致：`Float64` 返回 `2.220446049250313e-16`，`Float32` 返回 `1.1920929e-7`，其他类型返回 `hint - hint`）；`compute_vector_relational.cj:17` 已使用 `epsilonOf<T>(hint)` 模式。**v10 设计决策（与 §1 系统性约束一致）**：
  - (a) **功能等价无业务新增**：`epsilon<T>()` 与 `epsilonOf<T>(hint)` 在返回值语义上**完全一致**——两者均按 `T = Float32/Float64` 返回相同的硬编码机器精度值，对其他类型均返回 `hint - hint` 形式的零值
  - (b) **签名差异说明**：`epsilon<T>()` 无形参（与 GLM `glm::epsilon<T>()` 习惯对齐），`epsilonOf<T>(hint)` 携带 `hint: T` 形参（与 deviations.md DV-04 类型推断辅助参数风格一致）——下游调用者可按需选用，函数体实现可共享（`epsilon<T>()` 内部调用 `epsilonOf<T>(T(0))` 或 `epsilonOf<T>(T(1))` 即可）
  - (c) **阶段二测试硬编码值作为 ground truth**：阶段二测试 `tests/glm/detail/test_shim_limits.cj` 中硬编码的 `epsilon` 值（`Float32(1.1920929e-7)` / `Float64(2.220446049250313e-16)`）作为本设计 `epsilon<T>()` 实现的 ground truth；阶段三新增 `tests/glm/detail/test_scalar_constants.cj` 应交叉验证两者返回值一致
  - (d) **编码启动前验证项新增**：本节末尾追加「验证 `epsilon<T>()` 与 `epsilonOf<T>(hint)` 在 T=Float32/Float64/Int64 下的返回值一致性」验证项

**gtc/constants.cj**：
- 提供 **28 个**常量函数（zero/one/two_pi/tau/root_pi/half_pi/three_over_two_pi/quarter_pi/one_over_pi/one_over_two_pi/two_over_pi/four_over_pi/two_over_root_pi/one_over_root_two/root_half_pi/root_two_pi/root_ln_four/e/euler/root_two/root_three/root_five/ln_two/ln_ten/ln_ln_two/third/two_thirds/golden_ratio）
- **v8 修订**：v7 文档文字描述列出 28 个常量函数名称（与 GLM 1.0.3 `gtc/constants.inl` 实际声明数一致）但汇总数字误标为「25」，本轮统一修订为「28」。**测试覆盖目标同步**：`tests/glm/gtc/test_constants.cj`（v8 命名约定修订，见 §8.2）至少 28 个测试用例，每常量函数 1 个用例验证返回值正确性
- 全部为泛型函数 `func zero<T>(): T` 等，内部使用具体类型硬编码值直接返回（与 GLM `genType(3.14159...)` 实现方式一致，避免函数间调用依赖）
- 依赖 `ext/scalar_constants.cj`（间接通过 detail/scalar_constants.cj）
- 可**完整实现**

### 3.13 新增空桩文件

本阶段新增以下空桩文件以满足 gtc/matrix_transform.cj 的传递依赖闭合：

| 文件 | 包 | 内容 |
|------|---|------|
| `trigonometric.cj` | glm.detail | **标量/向量重载区分（v8 新增）**：提供 30 个函数（15 标量 + 15 向量），详见 §3.13.1 |
| `ext/matrix_projection.cj` | glm.ext | `perspective`/`ortho` 等投影矩阵函数空壳 |
| `ext/matrix_clip_space.cj` | glm.ext | 裁剪空间矩阵函数空壳 |
| `ext/matrix_transform.cj` | glm.ext | `translate`/`rotate`/`scale`/`lookAt` 等变换函数空壳 |
| `gtc/matrix_transform.cj` | glm.gtc | 矩阵变换函数库（**v12 关键修订，Issue 4 响应：明确具体函数清单；v13 关键修订，Issue 1+2 响应：函数清单 35→64 修订**）——本阶段声明 64 个函数签名（与 GLM 1.0.3 `glm/gtc/matrix_transform.hpp` 通过 `ext/matrix_transform.inl` + `ext/matrix_clip_space.inl` + `ext/matrix_projection.inl` 三文件间接包含的实际声明数 64 一致）作为 stub 占位；下游按 lib.cj 第 9 行追加的 `import glm.gtc.matrix_transform` 调用时所有函数均存在但实现为 `throw Exception("stub")`。具体清单见 §3.13 表格下「`gtc/matrix_transform.cj` 函数清单（v12 新增 + v13 扩展 35→64，Issue 1+2 响应）」段 |

**沿用自阶段二的 stub**：`common.cj`、`geometric.cj`、`matrix.cj`（27 实现 + 6 stub）

**`gtc/matrix_transform.cj` 函数清单（v12 新增 Issue 4 响应，**v13 关键修订 35→64 响应 Issue 1+2，附 v2 扩展证据**）**：GLM 1.0.3 `glm/gtc/matrix_transform.hpp` 实际声明 64 个函数（依据 GLM 1.0.3 源码全文检索统计，分布于 3 个间接 include 的 .inl 文件：`ext/matrix_transform.inl` 11 个 + `ext/matrix_clip_space.inl` 46 个 + `ext/matrix_projection.inl` 7 个 = **64 个**）。本阶段声明所有函数签名作为 stub 占位，确保下游 lib.cj 第 9 行追加 `import glm.gtc.matrix_transform` 调用时所有函数均存在但实现为 `throw Exception("stub")`。**v13 修订要点**：
- **v12 描述「35 个函数」错误**——v12 实际列出 3+2+5+10+10+1+4 = 35 个，与 GLM 实际 64 个偏差 29 个
- **v12 列出 5 个虚构函数**：`scaleAlongAxis`（GLM 中**不存在**）+ `tweakedInfinitePerspectiveLH_ZO`/`tweakedInfinitePerspectiveLH_NO`/`tweakedInfinitePerspectiveRH_ZO`/`tweakedInfinitePerspectiveRH_NO`（GLM 中**仅 2 个** `tweakedInfinitePerspective` 重载，定义于 `ext/matrix_clip_space.inl:593` + `:611`，函数签名 `tweakedInfinitePerspective(T fovy, T aspect, T zNear, T ep)` 与 `tweakedInfinitePerspective(T fovy, T aspect, T zNear)`，**无 ZO/NO 变体**）
- **v12 遗漏 29 个真实函数**：identity、scale_slow、shear、shear_slow、lookAtRH、lookAtLH 等基础变换 6 个（基础变换分类仅 3 个应为 11 个）；orthoZO、orthoNO、orthoLH、orthoRH 等视口变体 4 个（视口变换分类仅 5 个应为 9 个）；frustum（一般）+ frustumZO + frustumNO + frustumLH + frustumRH 等视锥体 5 个（遗漏整个 frustum 系族 9 个）；perspective（一般）+ perspectiveZO + perspectiveNO + perspectiveLH + perspectiveRH 等 5 个（perspective 系族仅 4 个应为 9 个）；perspectiveFovZO + perspectiveFovNO + perspectiveFovLH + perspectiveFovRH 等 5 个（perspectiveFov 系族仅 4 个应为 9 个）；infinitePerspectiveRH、infinitePerspectiveLH 等 2 个（infinitePerspective 系族仅 5 个应为 7 个）
- **`matrixCompMult` 归属错误**：`matrixCompMult` 实际定义于 `glm/detail/func_matrix.inl`（与 `gtc/matrix_transform.hpp` 无关），不应列入本文件清单

具体函数清单（**v13 修订后**，共 64 个函数）：

| 类别 | 函数数量 | 函数列表 | GLM 源文件 |
|------|---------|---------|-----------|
| 基础变换 | 11 | `identity`、`translate`、`rotate`、`rotate_slow`、`scale`、`scale_slow`、`shear`、`shear_slow`、`lookAtRH`、`lookAtLH`、`lookAt` | `ext/matrix_transform.inl` |
| 视口与裁剪空间（ortho 系族） | 10 | `ortho`（无 zNear/zFar）、`ortho`（3D 一般版本，含 zNear/zFar）、`orthoLH_ZO`、`orthoLH_NO`、`orthoRH_ZO`、`orthoRH_NO`、`orthoZO`、`orthoNO`、`orthoLH`、`orthoRH` | `ext/matrix_clip_space.inl` |
| 视口与裁剪空间（frustum 系族） | 9 | `frustum`、`frustumLH_ZO`、`frustumLH_NO`、`frustumRH_ZO`、`frustumRH_NO`、`frustumZO`、`frustumNO`、`frustumLH`、`frustumRH` | `ext/matrix_clip_space.inl` |
| 透视投影（perspective 系族） | 9 | `perspective`、`perspectiveLH_ZO`、`perspectiveLH_NO`、`perspectiveRH_ZO`、`perspectiveRH_NO`、`perspectiveZO`、`perspectiveNO`、`perspectiveLH`、`perspectiveRH` | `ext/matrix_clip_space.inl` |
| 透视投影（perspectiveFov 系族） | 9 | `perspectiveFov`、`perspectiveFovLH_ZO`、`perspectiveFovLH_NO`、`perspectiveFovRH_ZO`、`perspectiveFovRH_NO`、`perspectiveFovZO`、`perspectiveFovNO`、`perspectiveFovLH`、`perspectiveFovRH` | `ext/matrix_clip_space.inl` |
| 无穷远透视（infinitePerspective 系族） | 7 | `infinitePerspective`、`infinitePerspectiveLH_ZO`、`infinitePerspectiveLH_NO`、`infinitePerspectiveRH_ZO`、`infinitePerspectiveRH_NO`、`infinitePerspectiveLH`、`infinitePerspectiveRH` | `ext/matrix_clip_space.inl` |
| 无穷远透视（tweakedInfinitePerspective 系族） | 2 | `tweakedInfinitePerspective(T fovy, T aspect, T zNear, T ep)`（4 参数含 `ep`）、`tweakedInfinitePerspective(T fovy, T aspect, T zNear)`（3 参数无 `ep`） | `ext/matrix_clip_space.inl:593, :611` |
| 投影工具 | 6 | `projectZO`、`projectNO`、`project`、`unProjectZO`、`unProjectNO`、`unProject` | `ext/matrix_projection.inl` |
| 拾取矩阵 | 1 | `pickMatrix` | `ext/matrix_projection.inl` |
| **合计** | **64 个函数**（**v13 关键修订**：v12 描述「35 个函数」与 GLM 1.0.3 实际 64 个函数显著偏差 29 个；**v13 已完整修订**为 64 个函数按 6 大类 + 子类分组明确列出，确保 lib.cj 第 9 行追加 `import glm.gtc.matrix_transform` 能正常解析所有 64 个函数；`matrixCompMult` 已从清单中移除——实际定义于 `glm/detail/func_matrix.inl` 而非 gtc/matrix_transform；**v14 关键修订，Issue 3 响应**：ortho 系族从 9 修正为 10（补充 3D ortho 一般版本 `ortho(T left, T right, T bottom, T top, T zNear, T zFar)`），合计 11+10+9+9+9+7+2+6+1=**64** 条目数不变——原 v13 的 9 个 ortho 子类实际函数清单缺少 3D 一般版本，但总和 63 未被检出是因 `ext/matrix_clip_space.inl` 按函数列表归属计数时 ortho 族实际恰好 10 个（两个 `ortho` 重载 + 8 个变体），v13 分组时遗漏了含 zNear/zFar 参数的 3D ortho 重载） |

**下游实施约束（v12 修订 + v13 关键修订，Issue 1+2 响应）**：
- 实施时按上述 64 个函数清单逐一声明函数签名（**v13 修订**：v12 描述「35 个」遗漏 29 个）
- 每个函数体实现为 `throw Exception("stub")`
- 函数签名参数类型与 GLM 原始声明对齐（`Mat4x4`/`Mat3x3`/`Vec3`/`Float32`/`Float64` 等），无需本阶段严格翻译 `where T <: FloatingPoint<T>` 等约束
- 阶段四实现时按 `lib.cj` import 顺序与 §10 覆盖矩阵定义的实际优先级补齐函数体
- **v13 实施位置更新（Issue 1 响应）**：lib.cj 实际仅 8 行，阶段三新增 import 追加至 lib.cj 第 9 行（非 v12 描述的「第 131 行」）；下游编码者按本节清单实施时无需在 lib.cj 中查找「第 131 行」——直接编辑 8 行文件末尾追加 1 行 import 即可

#### 3.13.1 trigonometric.cj 函数清单（v8 新增标量/向量重载区分，v10 修订 VecN 占位符展开规则）

`detail/trigonometric.cj` 本阶段需提供 **30 个函数**（v8 修订：v7 文档仅列出 15 个函数名但未区分标量/向量重载，下游仅声明向量版本会导致 `mix`/`slerp`/`roll`/`pitch`/`yaw`/`pow`/`log` 等的 `acos(T)`/`sin(T)`/`atan(T)` 标量调用编译失败）：

**`VecN<T, Q>` 占位符展开规则（v10 新增，Issue 5 响应）**：上表 `VecN<T, Q>` 是占位符——**仓颉项目不存在 `VecN` 泛型占位类型**。实际展开模式遵循 `cjglm/src/detail/compute_vector_decl.cj` 的 `compute_vec_xxx1/2/3/4` 模式（即 4 个独立函数重载，对应 Vec1/Vec2/Vec3/Vec4）。下游实现 trigonometric.cj 时，每个 `VecN<T, Q>` 占位符应展开为 4 个独立函数：
- `sin<T, Q>(x: Vec1<T, Q>): Vec1<T, Q>` / `sin<T, Q>(x: Vec2<T, Q>): Vec2<T, Q>` / `sin<T, Q>(x: Vec3<T, Q>): Vec3<T, Q>` / `sin<T, Q>(x: Vec4<T, Q>): Vec4<T, Q>`
- 其余 14 个单参数三角函数（`cos`/`tan`/`asin`/`acos`/`atan`/`sinh`/`cosh`/`tanh`/`asinh`/`acosh`/`atanh`/`radians`/`degrees`）+ 1 个双参数 `atan2` 同理展开

**展开后的实际函数总数重算（v10 修订）**：
- 标量单参数三角函数：14 个（每个 1 个签名 = 14）
- 向量单参数三角函数：14 个函数 × 4 个分量数 = 56 个
- 标量双参数三角函数（`atan2`）：1 个
- 向量双参数三角函数（`atan2`）：1 个 × 4 个分量数 = 4 个
- **展开后实际函数总数 = 14 + 56 + 1 + 4 = 75 个**（v10 修订：v9 描述的「30 个函数」是占位符层级计数，未按 `VecN<T, Q>` 占位符展开为 4 个独立重载；下游按设计实现时实际应声明 75 个函数签名，其中标量 15 个用于 `slerp`/`mix`/`pow`/`log`/`exp`/`angle`/`angleAxis` 等四元数函数体的分量级运算，向量 60 个用于阶段四 vec 级运算）

**单参数三角函数（14 函数 × 2 重载类型 = 28 行占位符签名，展开后 70 个函数）**：

**内部依赖统一说明（v12 关键修订，Issue 3 响应，删除冗余重复说明）**：表行「内部依赖」列对每个 std.math 函数调用，原 v11 重复 14 次「std.math Float32 重载已提供」说明。v12 修订后，**统一指向 §1「Float32 与 std.math 的交互约束」段作为单一权威来源**：§1 已明确 `std.math` 三角函数（`sin`/`cos`/`tan`/`asin`/`acos`/`atan`/`sinh`/`cosh`/`tanh`/`asinh`/`acosh`/`atanh`/`atan2`）均提供 Float16/Float32/Float64 重载，`std.math.pow` 提供 Float32/Float64 共 4 个重载——T=Float32 实例化时直接调用 std.math 对应重载即可（与 §1 方案 A 一致），无需 `T(Float64.xxx(Float64(value)))` 显式转换；`radians`/`degrees` 是例外（stdlib 不存在，需硬编码 π 字面量）。表行仅标注 std.math 函数名（不带重复说明），详细约束规则查阅 §1 与下表「**Float32 实例化影响（v11 修订，Issue 7 关联）**」段（v12 修订：移除原独立段落，与表行整合）。

| 函数 | 标量签名（v11 关键修订，Issue 1 响应，所有签名统一标注 `where T <: FloatingPoint<T>`） | 向量签名（占位符，v11 修订列标题：明确按 Vec1~Vec4 展开为 4 个独立函数） | 内部依赖（v12 修订，Issue 3 响应：仅标注 std.math 函数名，详细约束查阅 §1） |
|------|---------|---------|---------|
| `sin` | `sin<T>(x: T): T where T <: FloatingPoint<T>` | `sin<T, Q>(x: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | `std.math.sin` |
| `cos` | `cos<T>(x: T): T where T <: FloatingPoint<T>` | `cos<T, Q>(x: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | `std.math.cos` |
| `tan` | `tan<T>(x: T): T where T <: FloatingPoint<T>` | `tan<T, Q>(x: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | `std.math.tan` |
| `asin` | `asin<T>(x: T): T where T <: FloatingPoint<T>` | `asin<T, Q>(x: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | `std.math.asin` |
| `acos` | `acos<T>(x: T): T where T <: FloatingPoint<T>` | `acos<T, Q>(x: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | `std.math.acos` |
| `atan` | `atan<T>(x: T): T where T <: FloatingPoint<T>` | `atan<T, Q>(x: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | `std.math.atan` |
| `sinh` | `sinh<T>(x: T): T where T <: FloatingPoint<T>` | `sinh<T, Q>(x: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | `std.math.sinh` |
| `cosh` | `cosh<T>(x: T): T where T <: FloatingPoint<T>` | `cosh<T, Q>(x: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | `std.math.cosh` |
| `tanh` | `tanh<T>(x: T): T where T <: FloatingPoint<T>` | `tanh<T, Q>(x: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | `std.math.tanh` |
| `asinh` | `asinh<T>(x: T): T where T <: FloatingPoint<T>` | `asinh<T, Q>(x: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | `std.math.asinh` |
| `acosh` | `acosh<T>(x: T): T where T <: FloatingPoint<T>` | `acosh<T, Q>(x: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | `std.math.acosh` |
| `atanh` | `atanh<T>(x: T): T where T <: FloatingPoint<T>` | `atanh<T, Q>(x: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | `std.math.atanh` |
| `radians` | `radians<T>(x: T): T where T <: FloatingPoint<T>` | `radians<T, Q>(x: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | **例外（stdlib 不存在）**：硬编码 π 字面量 `Float64(3.141592653589793)`。完整实现公式 `radians(x) = x * Float64(3.141592653589793) / Float64(180.0)`；T=Float32 实例化时 `T(Float64(3.141592653589793)) / T(Float64(180.0))`；T=Float64 实例化时直接使用 |
| `degrees` | `degrees<T>(x: T): T where T <: FloatingPoint<T>` | `degrees<T, Q>(x: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | **例外（stdlib 不存在）**：硬编码 π 字面量 `Float64(3.141592653589793)`。完整实现公式 `degrees(x) = x * Float64(180.0) / Float64(3.141592653589793)`；T=Float32 实例化时 `T(Float64(180.0)) / T(Float64(3.141592653589793))`；T=Float64 实例化时直接使用 |

**双参数三角函数（v8 新增 `atan2` 双参数标量版本）**：

| 函数 | 标量签名（v11 关键修订，Issue 1 响应） | 向量签名（占位符，v11 修订列标题） | 内部依赖（v12 修订） |
|------|---------|---------|---------|
| `atan2` | `atan2<T>(y: T, x: T): T where T <: FloatingPoint<T>`（v8 明确要求；GLM `std::atan2(T, T)` 对应物） | `atan2<T, Q>(y: VecN<T, Q>, x: VecN<T, Q>): VecN<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | `std.math.atan2` |

**T 类型约束策略（v11 关键修订，Issue 1 响应）**：所有 15 个函数（14 单参数三角函数 + 1 双参数 `atan2`）的标量与向量签名模板均统一添加 `where T <: FloatingPoint<T>` 约束（与 §3.2.1 D32、§3.11 D29、§3.12 D25 已统一策略一致）；下游对 T 约束决策无需重复选择；整数 T 实例化时（如 `Quat<Int64, PackedHighp>.inverse()` 调用 `acos(int)`）将编译期报类型不匹配错误并提供前置告警。**v11 附注（质询报告 B 项响应）**：本约束的必要性是「阶段四完整实现前的必备前置项」——若 trigonometric.cj 函数体不约束 T 为浮点类型，阶段四 stub 替换为 `std.math.{func}` 调用时，整数 T 实例化将报 `std.math.{func}(Int64)` 不存在错误（因 std.math 数值函数仅对 Float16/Float32/Float64 提供重载）；本约束提前到签名声明阶段，避免阶段四实现时再回头加约束引入 API 变更。因此**严重程度保留**（与 Issue 1 一致），但本约束的实施不阻塞阶段三本身的完整实现路径，仅在阶段四实现 trigonometric.cj 函数体时生效。

**Float32 实例化影响（v11 修订，Issue 7 关联，v12 关键修订，Issue 3 响应）**：原 v11 在本节独立段重复说明 std.math Float32 重载可用性，与 §1「Float32 与 std.math 的交互约束」段形成内容重复。**v12 修订后本段并入 §1 单段说明**，表行不再重复标注。完整权威说明查阅 §1 段——关键结论：所有 std.math 三角函数（`sin`/`cos`/`tan`/`asin`/`acos`/`atan`/`sinh`/`cosh`/`tanh`/`asinh`/`acosh`/`atanh`/`atan2`/`sqrt`/`exp`/`log`）均提供 Float16/Float32/Float64 重载，T=Float32 实例化时直接调用 std.math 对应重载即可；`radians`/`degrees` 是例外（stdlib 不存在，需硬编码 π 字面量）；`std.math.pow` 提供 Float32/Float64 共 4 个重载。

**展开后实际函数总数重算（v11 关键修订，Issue 11 响应，补充 30→75 过渡说明）**：
- **占位符层级（v9 修订计数）**：14 个单参数三角函数（标量 + 向量 14 行）+ 1 个双参数 `atan2`（标量 + 向量 1 行）= **15 个函数名 × 2 行 = 30 行占位符签名模板**
- **展开后实际函数数（v10 重算，v11 保留）**：每个 `VecN<T, Q>` 占位符展开为 Vec1/Vec2/Vec3/Vec4 共 4 个独立函数签名——标量 14 个不变（每函数 1 个签名 = 14）+ 向量 14 个 × 4 个分量数 = 56 个 + 双参数 `atan2` 标量 1 个 + 双参数 `atan2` 向量 1 × 4 = 4 个 = **总计 75 个函数签名**
- **过渡说明（v11 新增，Issue 11 响应）**：从 v9 占位符层级的 30 行模板 → v10/v11 实际展开后的 75 个函数签名，**2.5 倍数量跳跃源于 VecN 占位符展开规则**——每个「向量签名」占位符行实际对应 Vec1/Vec2/Vec3/Vec4 共 4 个独立函数签名。下游编码者实现 trigonometric.cj 时，每行模板应按 §3.13.1 「`VecN<T, Q>` 占位符展开规则」段（位于表前）展开为 4 个独立函数；下游按 v9 文档「30 行」实现时仅声明 30 个函数会导致向量调用方在编译时找不到 Vec1/Vec2/Vec3/Vec4 任一分量数的实例（与 `compute_vector_decl.cj` 4 个独立 struct 模式不符）

**约束说明**：
- 标量版本用于 `slerp`/`mix`/`pow`/`log`/`exp`/`angle`/`angleAxis` 等四元数函数体内的**分量级运算**（如 `slerp` 中 `acos(cosTheta)`、`pow` 中 `asin(sqrt(VectorMagnitude) / magnitude)`）
- 向量版本用于**阶段四 vec 级运算**（如 vec3 应用四元数旋转的逐分量 sin/cos 变换）
- 所有函数本阶段均为 stub（仅签名空壳 + `throw Exception("stub")`），具体实现推迟至阶段四 trigonometric.cj 完整实现时补齐
- **下游消费者提示**：`slerp`/`mix`/`pow`/`log`/`exp` 等函数体内的 `acos(cosTheta)`/`sin(angle)`/`atan(denom, numer)` 等调用直接使用**标量版本**（参数为 `T`），与本节签名一致
- **T 类型约束（v11 关键修订，Issue 1 响应）**：所有 75 个展开函数签名均标注 `where T <: FloatingPoint<T>`；下游按设计实现时需在签名声明阶段保留该约束，与 §3.2.1 D32 / §3.11 D29 / §3.12 D25 约束收紧策略一致

### 3.13.2 本阶段实现但运行时受 stub 依赖影响的函数集中审计（v11 新增，质询报告 C 项响应）

**v16 修订，Issue 2 响应**：本节函数状态计数已与 §11.5 函数可用性对照表统一对齐。**全文档函数可用状态以 §11.5 为最终基准**。

本节集中审计「本阶段标注为完整实现或部分实现，但运行时受 stub 依赖影响」的函数，列出调用链与异常传播路径——呼应任务描述对「异常场景和边界条件」的关注。

| 函数 | 标注状态 | 依赖 stub 来源 | 运行时行为契约 | 阶段四补齐路径 |
|------|---------|--------------|--------------|--------------|
| `Quat×Vec3` 运算符 | §3.4 标注「实现」 | `ext/quaternion_common.cj` 中的向量 `cross`（**`geometric.cj` stub**） | 阶段三调用抛 `Exception("stub")` | 阶段四 geometric.cj 向量 cross 完整实现后，旋转公式 `v + (cross(QuatVector, v) * q.w + cross(QuatVector, cross(QuatVector, v))) * T(Float64(2))` 生效 |
| `Quat×Vec4` 运算符 | §3.4 标注「实现」 | 通过 `Quat×Vec3` 中间路径间接依赖 `geometric.cj` stub | 阶段三调用抛 `Exception("stub")` | 同上 |
| `epsilon<T>()`/`pi<T>()`/`cos_one_over_two<T>()` | §3.12 标注「完整实现」 | 无 stub 依赖（运行时分派 `match`） | 整数 T 调用时抛 `Exception("not defined for non-floating-point types")`（D25 决策） | 阶段四约束收紧策略生效后编译期拒绝（无需运行时异常） |
| `axis(q)` | §3.9 标注「完整实现」 | `std.math.sqrt`（**v11 修订，Issue 7 关联**：T=Float32 时直接调用 Float32 重载） | 阶段三可调用（T=Float32/Float64 均有效） | — |
| `length(q)` | §3.7 标注「完整实现」 | `std.math.sqrt` | 阶段三可调用 | — |
| `normalize(q)` | §3.7 标注「完整实现」（**v11 修订，Issue 2 响应**：补充零四元数保护；**v13 关键修订，Issue 6 响应：交叉引用**——完整边界行为契约详见 §5.3 边界条件表 normalize 行） | `length(q)` | 阶段三可调用：零四元数返回单位四元数；其他输入返回归一化结果 | — |
| `inverse(q)` | §3.11 标注「完整实现」 | `conjugate(q)` + `dot(q, q)`（**`quaternion_geometric.cj` 已完整实现**） | 阶段三可调用：浮点零除产生 Inf/NaN，整数零除抛 `ArithmeticException` | — |
| `isnan(q)`/`isinf(q)` | §3.11 标注「完整实现」 | `x.isNaN()`/`x.isInf()` 实例方法（**v11 修订，Issue 8 关联**：`FloatingPoint<T>` 接口实例方法） | 阶段三可调用（仅浮点 T） | 阶段四 `FloatingPoint<T>` 约束收紧后编译期拒绝整数 T |
| `mat3Cast`/`mat4Cast`/`quatCast` | §3.2.1 标注「完整实现」 | `pow`/`sqrt`/`trace`（`std.math` 已实现） | 阶段三可调用（仅浮点 T） | 阶段四 `FloatingPoint<T>` 约束收紧后编译期拒绝整数 T |
| `conjugate(q)` | §3.11 标注「完整实现」 | 无（仅逐分量取反） | 阶段三可调用 | — |
| `lerp(q1, q2, a)` | §3.11 标注「完整实现」 | 无（纯算术，含 `assert(a ∈ [0,1])`） | 阶段三可调用：`a` 超出 [0,1] 时 `assert` 失败 | — |
| `mix`/`slerp`(2 个版本) | §3.11 标注「stub」 | `trigonometric.cj` 的 `acos(T)`/`sin(T)` 单参数版本 + `common.cj` 的 `mix` 标量版 + `epsilon<T>()`（已实现） | 阶段三调用抛 `Exception("stub")` | 阶段四 trigonometric.cj/common.cj 完整实现后生效 |
| `exp(q)`/`log(q)`/`pow(q, y)`/`sqrt(q)` | §3.10 标注「stub」 | trigonometric.cj `sin`/`cos`/`acos` + std.math `pow`/`exp`/`log`/`sqrt` + `epsilon<T>()`/`pi<T>()`/`cos_one_over_two<T>()` + `FloatingPoint<T>.getMinDenormal()`/`getInf()`（**v11 修订，Issue 8 关联**） | 阶段三调用抛 `Exception("stub")` | 阶段四 trigonometric.cj 完整实现后生效 |
| `axis`/`angle`/`angleAxis` | §3.9 标注「axis 完整实现 + angle/angleAxis stub」 | trigonometric.cj `asin`/`acos` + std.math `sin`/`cos` | 阶段三：`axis` 可调用；`angle`/`angleAxis` 抛 `Exception("stub")` | 阶段四 trigonometric.cj 完整实现后 `angle`/`angleAxis` 生效 |
| `eulerAngles(q)`/`roll(q)`/`pitch(q)`/`yaw(q)` | §3.15 标注「stub」 | trigonometric.cj `atan`/`asin` + common.cj `clamp` + vector_relational.cj `equal` + `epsilon<T>()` | 阶段三调用抛 `Exception("stub")` | 阶段四 trigonometric.cj/common.cj 完整实现后生效 |
| `quatLookAt*`(3 个版本) | §3.15 标注「stub」 | `geometric.cj` 的 `cross`/`dot`/`normalize`/`inversesqrt`/`max` + `type_quat_cast.quatCast` | 阶段三调用抛 `Exception("stub")` | 阶段四 geometric.cj 完整实现后生效 |
| `gtc/matrix_transform` 全部 64 个函数（**v14 新增，Issue 7 响应**） | §3.13 标注「stub」 | `ext/matrix_projection.cj` + `ext/matrix_clip_space.cj` + `ext/matrix_transform.cj` + `geometric.cj` + `trigonometric.cj` + `matrix.cj`（均为 stub，通过 `gtc/matrix_transform.cj` 聚合） | 阶段三调用抛 `Exception("stub")` | 阶段四所有 stub 函数库完整实现后生效 |

**审计结论**：
- **本阶段可调用的「真完整实现」函数**（无 stub 依赖）：`epsilon<T>()`/`pi<T>()`/`cos_one_over_two<T>()`/`axis`/`length`/`normalize`/`inverse`/`isnan`/`isinf`/`mat3Cast`/`mat4Cast`/`quatCast`/`conjugate`/`lerp`/`dot`/`cross(Quat)`/`equal(Quat)`/`notEqual(Quat)`（共 **18 个函数**【v16 修订，Issue 4 响应：上一轮误标为 17 个，实际列表含 18 个函数名，本轮修正为 18】）
- **本阶段实现但运行时受 stub 依赖影响的函数**：`Quat×Vec3`/`Quat×Vec4` 运算符（2 个）
- **本阶段 stub 占位的函数**：`mix`/`slerp`/`exp`/`log`/`pow`/`sqrt`/`angle`/`angleAxis`/`rotate`/`eulerAngles`/`roll`/`pitch`/`yaw`/`quatLookAt*`（14 个）+ `gtc/matrix_transform` 全部 64 个函数 = **78 个**（**v14 修订，Issue 7 响应**：v13 审计表未纳入 gtc/matrix_transform.cj 64 个函数，审计结论 stub 数量 14 与实际 78 严重不符；本轮新增 `gtc/matrix_transform` 聚合行并修订 stub 数量为 14 + 64 gtc/matrix_transform = **78**）

下游测试设计时，对「本阶段可调用的真完整实现函数」可执行完整功能验证；对「实现但运行时受 stub 依赖影响」函数应标注「本阶段抛 stub 异常，待阶段四 stub 替换后生效」（与 §11.5 ⚠️ 符号对应）；对「stub 占位函数」仅执行 `assertThrows` 异常路径验证。**函数可用状态以 §11.5 为最终基准**。

### 3.14 四元数别名文件

ext/ 下新增四元数别名文件：

| 文件 | 别名内容 |
|------|---------|
| `quaternion_float.cj` | `quat = Quat<Float32, PackedHighp>` |
| `quaternion_double.cj` | `dquat = Quat<Float64, PackedHighp>` |
| `quaternion_float_precision.cj` | `highp_quat`/`mediump_quat`/`lowp_quat` |
| `quaternion_double_precision.cj` | `highp_dquat`/`mediump_dquat`/`lowp_dquat` |

fwd.cj 新增别名（v3 明确，**v8 修订**：v7 引用阶段二矩阵的 `Mat2x2`/`FMat2x2` 双别名机制作为先例，但通过直接查阅 `cjglm/src/fwd.cj` 全文确认 `Mat` 家族**仅存在** `Mat2x2` (Float32) + `DMat2x2` (Float64) 双别名（见 `fwd.cj:327, 347`），**不存在** `FMat*` 任何声明；`fwd.cj` 中唯一带 `F` 前缀的别名是 Vec 家族（`FVec1`~`FVec4` 见 `fwd.cj:275-278`、精度变体 `HighpFVec*`~`LowpFVec*` 见 `fwd.cj:279-290`）。`Vec` 家族采用 `Vec2` + `DVec2` + `FVec2` **三重模式**（`fwd.cj:106, 123, 276`）：

| 别名 | 类型 | 备注 |
|------|------|------|
| `Quat` | `Quat<Float32, PackedHighp>` | Float32 主别名（对应 `Vec2` 在 Vec 家族的角色） |
| `FQuat` | `Quat<Float32, PackedHighp>` | Float32 别名（与 `Quat` 等价，对应 `FVec2` 在 Vec 家族的角色） |
| `DQuat` | `Quat<Float64, PackedHighp>` | Float64 主别名（对应 `DVec2` 在 Vec 家族的角色） |
| `HighpQuat`/`MediumpQuat`/`LowpQuat` | `Quat<Float32, *>` | Float32 精度变体（3 个，对应 Vec 家族 `HighpFVec*` 等） |
| `HighpDQuat`/`MediumpDQuat`/`LowpDQuat` | `Quat<Float64, *>` | Float64 精度变体（3 个） |

**合计 9 个别名**（**v10 修订**：v9 描述误为 8 个；实际为 Quat/FQuat/DQuat/3×Float32 精度/3×Float64 精度 = 1+1+1+3+3 = **9 个**，与 §2 lib.cj/fwd.cj 段落同步）。**排除项**（与阶段二策略对齐）：
- 不含 `BQuat`（Bool 四元数）—— 阶段一 Vec 包含 `BVec` 但 Bool 四元数无实际用途（D17 决策：Bool 四元数不支持算术运算）
- 不含 `IQuat`/`I64Quat`（整型四元数）—— 与阶段二 `fwd.cj` 排除整型矩阵别名策略一致
- 不含 `BQuat` 的精度变体（同上）

**为何保留 `Quat`/`FQuat`/`DQuat` 三重别名（v3 新增说明，v8 修订先例引用）**：**v7 文档引用阶段二 `Mat2x2`/`FMat2x2` 双别名机制作为先例，但该先例与项目实际状态不符**——阶段二 `Mat` 家族实际仅有 `Mat2x2` (Float32) + `DMat2x2` (Float64) 双别名（`cjglm/src/fwd.cj:327, 347`），`FMat*` 在 `fwd.cj` 中无任何声明。**v8 修订**：将先例引用改为阶段一 Vec 家族的三重模式（`Vec2` + `DVec2` + `FVec2`，见 `cjglm/src/fwd.cj:106, 123, 276`），与 `FQuat` 的设计意图对齐。`Quat` 为主别名（与 GLM 命名一致），`FQuat` 为显式浮点别名（与 `FVec2` 在 Vec 家族的角色等价），`DQuat` 为显式 64 位浮点别名（与 `DVec2` 等价）。该三重模式在阶段一 Vec 家族已稳定运行，作为四元数 `Quat`/`FQuat`/`DQuat` 的设计先例更准确。

### 3.15 gtc/quaternion.cj（v3 独立小节）

**角色**：承载 GLM `gtc/quaternion.hpp` 的全部 15 个函数（4 转换 + 4 比较 + 4 欧拉 + 3 看向），与 GLM 原始头文件路径保持 1:1 映射。

**职责分组**（**v14 修订，Issue 1 响应：确认 §3.15 与 §3.2 策略段一致**——§3.15 自 v3/v5 修订以来已正确将欧拉函数归入「stub 占位」，§3.2 策略段此次同步修正，两处不再矛盾）：

| 函数组 | 函数 | 本阶段状态 | 依赖 |
|--------|------|----------|------|
| 矩阵-四元数互转 | `mat3Cast`/`mat4Cast`/`quatCast(Mat3)`/`quatCast(Mat4)` | **从 detail 重导出** | `public import glm.detail.{mat3Cast, mat4Cast, quatCast}`（v3 关键变更，**v12 关键修订，Issue 1 响应**：重导出函数名为 camelCase `mat3Cast`/`mat4Cast`/`quatCast`，与 detail 端原始函数名一致——`public import a.b.f` 仅重导出 f 原始名，不做命名转换；GLM 原始 snake_case `mat3_cast`/`mat4_cast`/`quat_cast` 习惯在仓颉侧无法保留，记录于 §9「对齐 GLM 参考实现的差异声明」） |
| 四元数比较 | `lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual` | 完整实现 | 纯比较 |
| 欧拉角 | `eulerAngles`/`roll`/`pitch`/`yaw` | **stub 占位**（v5 最终决策，原误标为完整实现） | `trigonometric.cj`(`atan`/`asin`) + `common.cj`(`clamp`) + `vector_relational.cj`(`equal`) + `scalar_constants.cj`(`epsilon<T>()`) — 均依赖 stub，本阶段无法完整实现 |
| 看向 | `quatLookAt`/`quatLookAtRH`/`quatLookAtLH` | stub | `geometric.cj`(`cross`/`dot`/`normalize`/`inversesqrt`/`max`) + `type_quat_cast.quatCast` |

**v3 修订说明**：
- 上一版（v2）中"完整实现的 8 个函数（4 转换 + 4 比较）"现修正为：
  - 4 转换函数 → **从 detail 重导出**（不再在 gtc/quaternion.cj 中实现）
  - 4 比较函数 → 完整实现（保留）
  - 4 欧拉函数 → **stub 占位**（v2 中误标为"完整实现"，但实际依赖 trigonometric.cj 的 atan/asin 和 common.cj 的 clamp stub）
  - 3 看向函数 → stub（保留）
- **正确分组**：4 重导出 + 4 完整实现 + 7 stub

**完整实现函数（4 个，**v12 关键修订，Issue 13 响应：合并 where 子句描述**）**：

4 个比较函数（`lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual`）统一标注 `where T <: Comparable<T>, Q <: Qualifier` 约束（**v10 新增，Issue 16 响应**，依赖 `<`/`<=`/`>`/`>=` 运算符；**v12 修订，Issue 13 响应**：4 行重复标注合并为本段统一约束声明，避免质询报告 E 项建议的表格格式偏好）。**v11 关键修订，Issue 9 响应，补充实现公式模板**：
- `lessThan`: `func lessThan<T, Q>(x: Quat<T,Q>, y: Quat<T,Q>): Vec4<Bool,Q> where T <: Comparable<T>, Q <: Qualifier { Vec4<Bool,Q>(x.x < y.x, x.y < y.y, x.z < y.z, x.w < y.w) }`
- `lessThanEqual`: `func lessThanEqual<T, Q>(x: Quat<T,Q>, y: Quat<T,Q>): Vec4<Bool,Q> where T <: Comparable<T>, Q <: Qualifier { Vec4<Bool,Q>(x.x <= y.x, x.y <= y.y, x.z <= y.z, x.w <= y.w) }`
- `greaterThan`: `func greaterThan<T, Q>(x: Quat<T,Q>, y: Quat<T,Q>): Vec4<Bool,Q> where T <: Comparable<T>, Q <: Qualifier { Vec4<Bool,Q>(x.x > y.x, x.y > y.y, x.z > y.z, x.w > y.w) }`
- `greaterThanEqual`: `func greaterThanEqual<T, Q>(x: Quat<T,Q>, y: Quat<T,Q>): Vec4<Bool,Q> where T <: Comparable<T>, Q <: Qualifier { Vec4<Bool,Q>(x.x >= y.x, x.y >= y.y, x.z >= y.z, x.w >= y.w) }`

**重导出函数（4 个，v12 关键修订：camelCase 命名）**：
- `mat3Cast(q: Quat<T,Q>): Mat3x3<T,Q>` — 通过 `public import glm.detail.mat3Cast` 重导出（**v12 关键修订，Issue 1 响应**：camelCase 命名，与 detail 端 `mat3Cast` 原始名一致；GLM 习惯 snake_case `mat3_cast` 在仓颉侧无法保留，因 `public import` 不做命名转换）
- `mat4Cast(q: Quat<T,Q>): Mat4x4<T,Q>` — 通过 `public import glm.detail.mat4Cast` 重导出（**v12 修订同上**：camelCase `mat4Cast` 而非 snake_case `mat4_cast`）
- `quatCast(m: Mat3x3<T,Q>): Quat<T,Q>` — 通过 `public import glm.detail.quatCast` 重导出（**v12 修订同上**：camelCase `quatCast` 而非 snake_case `quat_cast`）
- `quatCast(m: Mat4x4<T,Q>): Quat<T,Q>` — 通过 `public import glm.detail.quatCast` 重导出（**v12 修订同上**：camelCase `quatCast` 而非 snake_case `quat_cast`）

**stub 函数（7 个）**：
- `eulerAngles(x): Vec3<T,Q>` — stub
- `roll(q): T` — stub
- `pitch(q): T` — stub
- `yaw(q): T` — stub
- `quatLookAt(direction, up): Quat<T,Q>` — stub
- `quatLookAtRH(direction, up): Quat<T,Q>` — stub
- `quatLookAtLH(direction, up): Quat<T,Q>` — stub

**跨包引用（v3 明确，无循环依赖）**：
- `import glm.detail.*` 引用 `Quat`/`Mat3x3`/`Mat4x4`/`Vec3` 类型
- `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 重导出 4 个转换函数
- `import glm.ext.vector_relational.*` 引用 `equal`（用于 roll/pitch 的 `equal(vec2, vec2, 0)` 边界检测）
- `import glm.ext.scalar_constants.*` 引用 `epsilon<T>()`
- 不引用 `glm.detail.type_quat` 内部成员（避免与 type_quat.cj 内部细节耦合）
- **不引用** `glm.gtc.matrix_transform` 等其他 gtc 文件（避免 gtc 内部循环依赖）

**与 type_quat.cj、type_quat_cast.cj 三方协作（v3 明确）**：
- `type_quat.cj` 中 `fromMat3`/`fromMat4` 工厂函数直接调用**同包** `type_quat_cast.cj` 的 `mat3Cast`/`mat4Cast`/`quatCast` 函数（无 import 需求）
- `gtc/quaternion.cj` 通过 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 将 detail 函数重导出为 gtc 命名空间下的同名 API
- 形成 `glm.gtc → glm.detail` 的**单向依赖**，**无循环依赖**（v3 关键修复）

### 3.16 需求对齐说明（v16 修订，Issue 1 响应）

本设计文档与项目路线图 `docs/02_roadmap.md` 在阶段三验证标准上存在以下三处不一致，逐项列出并标注**待确认**状态，待项目管理方确认后修订。

**不一致 1：`slerp` 可验证性冲突（⚠️ 待确认）**
- 路线图 §3 第 125 行标记「球面线性插值（slerp）操作 `[可验证]`」，但本设计 §3.11、§8 产出物清单、§10 覆盖矩阵、§11.5 函数可用性对照表均将 `slerp`（含 3 参数与 4 参数版本）标记为「**stub 占位**」（依赖 `trigonometric.cj` 的 `acos`/`sin` stub 与 `common.cj` 的 `mix` stub）。
- **替代路径可行性讨论**：若阶段三需 `slerp` 可验证，有以下替代路径可供评估：
  - **路径 A（降级 lerp 近似）**：在阶段三先以 `lerp`（已完整实现）替代 `slerp`，阶段四 `trigonometric.cj` 完整实现后再替换为真正的球面插值。代价：`lerp` 在较大角度差时产生非恒定角速度的插值轨迹，可能不满足精度要求。
  - **路径 B（自行实现标量 sin/cos/acos 的有限精度版本）**：不依赖 `trigonometric.cj` 的 stub 接口，在 `quaternion_common.cj` 中内联实现仅用于 `slerp` 的有限精度三角函数（如通过泰勒展开近似）。代价：代码冗余、精度有限、与阶段四完整实现的 `std.math` 重载可能产生偏差。
  - **路径 C（接受本设计建议）**：`slerp` 标记为 `[待 Stage 4]`，阶段三以 stub 占位，阶段四 `trigonometric.cj`/`common.cj` 完整实现后补齐。

**不一致 2：`lookRotate` 命名未同步修正（⚠️ 待确认）**
- 路线图 §3 多处（第 89、102、111、129、152、163、207 行）仍引用 `lookRotate` 函数名，但本设计已统一为 `quatLookAt`/`quatLookAtRH`/`quatLookAtLH`（D13 决策 + §9 差异声明「GLM 中不存在 `lookRotate` 函数」）。
- **替代路径可行性讨论**：若路线图意图保留 `lookRotate` 名称，可新增 `lookRotate` 作为 `quatLookAtRH` 的别名函数（内部委托调用），但本设计倾向直接对齐 GLM 1.0.3 官方 API 命名以避免下游混淆。

**不一致 3：`ext/quaternion_common.cj` 可验证性范围过广（⚠️ 待确认）**
- 路线图 §3 第 130 行标记「`ext/quaternion_common.cj`：四元数常用函数（`conjugate`、`inverse`、`normalize` 等跨类型运算）`[可验证]`」，涵盖面过广，未排除 `mix`/`slerp` 属于 stub 的部分。

**阶段三验证标准双向映射表**（统一路线图与本设计的可验证性标注口径）：

| 路线图标注 | 本设计符号 | 含义 |
|----------|----------|------|
| `[可验证]` | ✅ 可用 | 本阶段完整实现，单元测试可立即验证 |
| `[部分可验证]` | ⚠️ 可用但有条件 | 本阶段实现但依赖 stub，调用抛 `Exception("stub")`，待阶段四 stub 替换后正常 |
| `[待 Stage 4]` | ❌ stub | 本阶段 stub 占位，待阶段四函数库完整实现后补齐 |

**§11.5 权威基准说明（v7 澄清）**：本设计 §11.5「函数可用性对照表」的 ✅/⚠️/❌ 符号标注是阶段三验证的**权威基准**（每个函数一行，标注本阶段状态与阶段四状态，含约束/边界条件注解）；路线图 `02_roadmap.md` 的 `[可验证]`/`[部分可验证]`/`[待 Stage 4]` 三级标注在 v3 迭代结束后由项目管理流程同步修订，本设计文档不再依赖路线图的特定标注作为验证依据。

**⚠️ 以上不一致项需待项目管理方确认后修订**：本设计文档以 §11.5 标注为准；路线图的对应标注修订由项目管理方在确认后完成。

---

## 4. 关键行为契约

### 4.1 四元数构造与单位四元数

```
let q = Quat<Float32, PackedHighp>.identity(1.0f)    // 单位四元数 (0,0,0,1) [本阶段可验证]
let q = Quat<Float32, PackedHighp>(0.0f, 0.0f, 0.0f, 1.0f) // 逐分量 [本阶段可验证]
let q = Quat<Float32, PackedHighp>.wxyz(1.0f, 0.0f, 0.0f, 0.0f) // wxyz 顺序 [本阶段可验证]
```

### 4.2 四元数旋转

```
let rotated = q * v        // 四元数旋转 Vec3 [本阶段调用抛 stub 异常，待阶段四 geometric.cj 完整实现后生效]
let rotatedV4 = q * v4     // 四元数旋转 Vec4（保留 w 分量）[同上]
let invRotated = v * q      // Vec3×Quat = inverse(q) * v [本阶段可验证，通过 inverse 路径，不依赖 stub]
```

### 4.3 四元数插值

```
let result = lerp(q1, q2, 0.5f)    // 线性插值（含 assert 断言）[本阶段可验证]
let result = conjugate(q)           // 共轭 [本阶段可验证]
let inv = inverse(q)               // 逆四元数 [本阶段可验证]
// slerp 为 stub，待阶段四 trigonometric.cj/common.cj 完整实现后生效
```

### 4.4 矩阵-四元数互转

```
let m3 = glm.mat3Cast(q)    // 四元数转 3×3 旋转矩阵 [本阶段可验证，通过 lib.cj 的 public import 重导出从顶层 glm 命名空间调用]
let m4 = glm.mat4Cast(q)    // 四元数转 4×4 旋转矩阵 [本阶段可验证]
let q = glm.quatCast(m3)    // 3×3 旋转矩阵转四元数 [本阶段可验证]

// gtc 命名空间下的同名 API（通过 public import 重导出，[本阶段可验证]，**v12 关键修订，Issue 1 响应**：gtc 端采用 camelCase 命名 `mat3Cast`/`mat4Cast`/`quatCast`，与 detail 端实现函数名一致——`public import a.b.f` 仅重导出 f 原始名，不做命名转换；若下游按 GLM 习惯使用 snake_case `mat3_cast` 将编译失败）
let m3_2 = glm.gtc.quaternion.mat3Cast(q)
let q_2 = glm.gtc.quaternion.quatCast(m3)
```

**v11 关键修订，Issue 4 响应，命名空间前缀统一**：§4.4 示例统一使用 `glm.mat3Cast(q)` 顶层命名空间调用形式，与 §11.4「仓颉顶层 glm 命名空间调用」段（v10 已明确）保持一致；调用方需先通过 `lib.cj` 完成 `public import` 间接访问，无需显式 `import glm.detail.*`。v10/v6 描述的「无前缀 `mat3Cast(q)`」调用形式若按字面实现（未先 `import glm.detail.*`），将因 `mat3Cast` 在 `glm.detail` 命名空间下而触发「未定义符号」编译错误。**前提条件**：调用方必须 `import glm`（导入 lib.cj 公共 API 层），使 `glm.mat3Cast` 在当前包命名空间下可见。

### 4.5 标量常量与数学常量

```
let eps = epsilon<Float32>()     // 1.1920929e-7 [本阶段可验证]
let p = pi<Float32>()            // 3.14159265... [本阶段可验证]
let half = halfPi<Float32>()     // 1.57079632... [本阶段可验证]
```

### 4.6 欧拉角与看向（stub）

```
let euler = eulerAngles(q)       // 欧拉角提取 [本阶段 stub]
let r = roll(q)                  // roll 分量 [本阶段 stub]
// quatLookAt 等看向函数 [本阶段 stub]
```

---

## 5. 错误处理策略

### 5.1 通用异常

- **下标越界**：`q[i]`（i < 0 或 i >= 4）抛出 `Exception`（与阶段一/二一致）
- **`normalize` 零四元数**：返回单位四元数 `Quat(T(Float64(0)), T(Float64(0)), T(Float64(0)), T(Float64(1)))`（**v14 修订，Issue 2 响应**：T(0)/T(1) 均采用 `T(Float64(n))` 字面量替代路径，与 §1 系统性约束 v14 修订一致），与 GLM `quaternion_geometric.inl:20-21` 行为一致
- **stub 函数体**：以 `throw Exception("stub")` 占位（标识阶段三/四功能边界）

### 5.2 算术溢出

- **统一标注**：四元数算术运算符（`+`/`-`/`*`/一元 `-`/标量乘除）统一标注 `@OverflowWrapping` 注解，与阶段一 Vec3 (`type_vec3.cj:54-80`) 和阶段二全部矩阵类型 (`type_mat2x2.cj`、`type_mat3x3.cj` 等) 的实践保持一致
- **跨类型一致性**：`@OverflowWrapping` 对浮点类型无效果（std.overflow 模块语义仅作用于整数溢出行为），但保持跨整数/浮点实例化的统一行为，避免未来整数四元数用例出现不可控整数溢出行为

### 5.3 边界条件与异常场景（v3 新增）

| 边界条件 | 函数 | 行为契约 |
|---------|------|---------|
| `1 - x.w*x.w <= 0` | `axis(q)` | 返回 `Vec3(T(0), T(0), T(1))`（z 轴单位向量，典型场景：单位四元数 `(0, 0, 0, 1)` 即 `\|w\| >= 1`；与 GLM `ext/quaternion_trigonometric.inl:20-27` 一致；**v5 修订**：v3 描述「零四元数返回 `Vec3(1, 0, 0)`」错误，触发条件为 `1 - w² <= 0` 而非 `q.xyz == 0`；**v10 补充，Issue 13 响应**：`tmp1 = T(1) - x.w*x.w` 计算公式参见 §3.9 `axis` 函数描述） |
| 真正零四元数 `(0,0,0,0)` | `axis(q)` | `tmp1 = 1 > 0` 进入 else 分支，返回 `Vec3(T(0), T(0), T(0))`（**v5 修订**：v3 描述「内部 `normalize(Vec3(0,0,0))` 返回 `Vec3(1,0,0)`」为虚构实现，GLM 实际不调用 `normalize`） |
| **零四元数 `(0,0,0,0)`（v11 新增，Issue 2 响应，**v14 关键修订，Issue 2 响应：T(0) 字面量替代**）** | `normalize(q)` | **`tmp1 = length(q) = 0 <= T(0)` 触发 GLM 零保护分支**，返回**单位四元数** `Quat(T(Float64(0)), T(Float64(0)), T(Float64(0)), T(Float64(1)))`（**v14 修订**：T(0) 原策略「通过 `one - one` 演算」在 normalize 签名（不含 `one: T` 形参）中不可用，统一修订为 `T(Float64(0))` 字面量替代路径；T(1) 采用 `T(Float64(1))` 字面量替代路径；与 §1 系统性约束 v14 修订一致）；与 GLM `ext/quaternion_geometric.inl:17-24` 实际行为完全一致——下游按 v10 描述「内部调用 `length`」字面实现时零四元数除零产生 NaN 分量与本契约不符 |
| **`length(q)` 极小值（接近 0 但非 0，v11 新增，Issue 2 响应）** | `normalize(q)` | `tmp1 > T(0)` 但接近 `FloatingPoint<T>.getMinDenormal()` 量级时**不触发零保护分支**，返回 `q / tmp1` 结果各分量趋向 Inf/NaN（与 GLM 行为一致，GLM 不做 length 极小值保护）；如需防止此类溢出，应在调用 `normalize` 前自行检查 `length(q) >= epsilon<T>()` |
| 零四元数（浮点） | `inverse(q)` | 浮点除零产生 Inf/NaN 分量（与 GLM 一致，GLM 不做零除保护） |
| 零四元数（整数） | `inverse(q)` | 触发仓颉 `ArithmeticException`（**v10 措辞统一，Issue 13 响应**：与浮点 Inf/NaN 行为不同；与 §3.11 `inverse` 描述对齐） |
| `cosTheta` 退化 | `mix`/`slerp` | 依赖 `cosTheta > 1 - epsilon<T>()` 边界检查；stub 函数抛 stub 异常 |
| 非纯旋转矩阵 | `fromMat3`/`fromMat4` | 仅对纯旋转矩阵产生有意义的四元数；对非旋转矩阵（缩放/平移/剪切）行为未定义，结果可能产生非单位四元数或语义错误的旋转 |
| `a` 超出 [0,1] | `lerp` | 触发 `assert(a >= 0 && a <= 1)` 断言失败 |
| `epsilon = T(0)` | `equal(v, v, 0)` | 返回 `false`（严格小于语义，与 GLM `glm/gtc/epsilon.inl:32-41` 中 `epsilonEqual` 实现一致；v9 修订：原引用 `func_vector_relational.inl:18-22` 错误——该文件不含 epsilon 版本） |
| 整型 T | `epsilon<T>()`/`pi<T>()`/`cos_one_over_two<T>()` | 触发 `Exception("not defined for non-floating-point types")`（约束收紧失败时 fallback 分支） |
| 整型 T | `isnan(q)`/`isinf(q)` | 编译期约束收紧为 `where T <: FloatingPoint<T>`，整型 T 实例化时编译失败（v4 新增，v7 接口名修订）；若仓颉泛型不支持窄约束则运行时 fallback 抛 `Exception("isnan/isinf not defined for non-floating-point types")` |
| 整型 T | `mat3Cast`/`mat4Cast`/`quatCast` | 编译期约束收紧为 `where T <: FloatingPoint<T>`，整型 T 实例化时编译失败（v5 新增，v7 接口名修订；与 D29 `isnan`/`isinf` 策略一致，对应 GLM `GLM_STATIC_ASSERT(is_iec559, ...)`；**v12 修订，Issue 11 响应：双向引用**——本条目对应 §3.13.2 审计表「`mat3Cast`/`mat4Cast`/`quatCast`」行的「整型 T 实例化时编译失败」契约反向引用） |
| u, v 反平行（`dot(u,v) ≈ -sqrt(dot(u,u) * dot(v,v))`，即 `dot ≈ -1` 经归一化后的等效条件，**v13 修订**：v8 描述「`dot ≈ -1`」不准确——GLM 实际触发条件为 `real_part < 1e-6f * norm_u_norm_v`） | `fromVec3` | 返回 `q.w = 0` 的纯向量四元数（**v13 修订**：v8 描述「`q.w ≈ 0`」准确但不够精确，GLM 实际为 `real_part = static_cast<T>(0)`），轴选择由 `abs(u.x) > abs(u.z)` 条件决定（**v13 关键修订**：v8 描述「任意轴」不准确——GLM 实际是「与 u 垂直的两条可能轴之一」，`abs(u.x) > abs(u.z)` 选 `(-u.y, u.x, 0)` 再归一化，否则选 `(0, -u.z, u.y)` 再归一化；**v15 修订，Issue 8 响应**：选出的轴还需经过 `normalize(t)` 归一化确保返回纯向量四元数模长为 1）；v8 新增契约，行为已定义，与 GLM `detail/type_quat.inl:196-217`（**v13 关键修订**：v8 错误引用为 `ext/quaternion_common.inl:196-217`）退化路径一致；阶段三 stub 阶段不适用，待阶段四 stub 替换后生效；**v12 修订，Issue 11 响应：双向引用**——本条目对应 §3.13.2「本阶段实现但运行时受 stub 依赖影响」审计表的「`fromVec3` stub 行」反向引用 |
| u, v 为零向量 | `fromVec3` | 行为未定义（由 `normalize` 阶段四完整实现时确定） |
| `mat3Cast` 接受非单位四元数 | `mat3Cast`/`mat4Cast` | 返回矩阵不保证是旋转矩阵（缩放/剪切分量保留；v8 新增契约，与 §3.2.1 边界行为契约段对齐） |
| `quatCast` 接受非旋转矩阵 | `quatCast` | 返回的四元数行为未定义（可能为非单位四元数/零四元数/NaN 四元数；v8 新增契约，与 §3.2.1 边界行为契约段对齐） |
| 整型 T（`Int8`~`Int64`） | `trigonometric.cj` 全体函数（`sin`/`cos`/`tan` 等） | 通过 `where T <: FloatingPoint<T>` 约束在编译期拒绝；整型 T 实例化时报类型不匹配错误（v15 新增，Issue 10 响应：`std.math` 三角函数仅提供 Float16/Float32/Float64 重载，不提供整型重载） |

### 5.4 const 上下文约束

- **`lerp`/`inverse` 不可在 const 上下文调用（v10 修订，Issue 6 响应）**：v9 描述「`lerp`/`conjugate`/`inverse` 不可在 const 上下文调用」错误——`conjugate` 函数体仅对 x/y/z 三个分量取反（`Quat(-q.x, -q.y, -q.z, q.w)`），无 `assert`/无 `throw`/无运行时副作用，**可在 const 上下文调用**（与 Vec/Mat 的逐分量运算符策略一致）。**v10 修订**：从禁止列表中移除 `conjugate`；`lerp` 因函数体内 `assert(a >= 0 && a <= 1)` 断言非 const 函数（与 deviations.md IF-03 一致），不可在 const 上下文调用；`inverse` 因依赖 `/` 运算符——**整数 T 在 `dot(q,q) == 0` 时触发仓颉 `ArithmeticException`**——非 const 函数
- **`inverse` const 拒绝理由（v10 新增）**：`inverse` 函数体内部 `conjugate(q) / dot(q, q)` 的 `/` 运算符在 T=Integer 实例化时为整数除法，**当 `dot(q,q) == 0` 时触发仓颉 `ArithmeticException`**（仓颉整数除零抛异常，与浮点 Inf/NaN 行为不同）。该运行时异常路径使 `inverse` 不可声明为 `const func`，与阶段二矩阵 `inverse` 函数（依赖 `1/det` 运算在整数 T 时同样抛异常）策略一致
- **`conjugate` const 适用性（v10 新增，§3.11 补充对齐）**：`conjugate` 函数体仅涉及 `Quat` 主构造函数的逐分量取反调用（`Quat(-q.x, -q.y, -q.z, q.w)`），无 `assert`/无 `throw`/无 `dot`/`normalize`/其他非 const 函数调用，**可声明为 `const func`**（与 Vec/Mat 的逐分量运算符策略一致）。**v10 附注**：若仓颉 const 函数还有其他限制（如不能调用非 const 自由函数、不能包含复杂表达式），则该论断需进一步评估
- **stub 函数不声明 const**：stub 函数体 `throw Exception("stub")` 不可在 const 上下文求值

### 5.5 标量/四元数 `div` 语义

- **逐分量除法**：`div(s, q)` 语义为 `s / q.x, s / q.y, s / q.z, s / q.w`（与阶段二标量/矩阵 `div` 模式一致）

---

## 6. 并发设计

本阶段不引入并发场景。四元数类型为值类型，所有运算符返回新实例，天然线程安全。

---

## 7. 设计决策

| 编号 | 决策 | 理由 |
|------|------|------|
| D01 | Quat 数据布局为 x,y,z,w（非 GLM 的 w,x,y,z 参数顺序） | 与 GLM 默认存储布局一致，避免 GLM_FORCE_QUAT_DATA_WXYZ 宏引入的条件编译复杂性 |
| D02 | Quat 主构造函数参数顺序为 (x,y,z,w)，另提供 wxyz(w,x,y,z) 工厂函数 | 主构造函数参数顺序与数据成员声明顺序一致（仓颉惯用风格），wxyz 函数兼容 GLM 习惯 |
| D03 | 四元数×向量运算符定义为 Quat 的成员运算符 | 左操作数类型拥有运算符，与阶段二 Mat×Vec 模式一致 |
| D04 | 向量×四元数运算符定义为 Vec 的 extend 块成员运算符 | 左操作数类型拥有运算符，依赖同包前向引用延迟解析（已通过阶段二原型验证） |
| D05 | 标量-四元数运算通过全局函数（scalar_quat_ops.cj） | 仓颉 operator func 限制——右操作数非 Quat 类型的标量左操作数不能定义为成员运算符 |
| D06 | ext/vector_relational 的 epsilon 比较内联 abs，不依赖 common.cj stub | 消除对 stub 文件的运行时依赖风险，确保 epsilon 比较函数可正常执行 |
| D07 | ULP 比较函数本阶段以空桩占位 | 仓颉无浮点位表示直接访问能力（无 `reinterpret_cast`/`union` 等价机制），待阶段四评估替代方案 |
| D08 | scalar_constants 实现于 glm.detail.scalar_constants.cj，ext/ 仅做重导出 | 遵循 detail 封装核心实现、ext/gtc 封装公共 API 的双层架构约定 |
| D09 | scalar_constants 的泛型函数使用 `match` 类型模式匹配 + hint 参数 | 仓颉无 `std::numeric_limits<T>::epsilon()` 等编译期类型属性查询机制，必须运行时分派 |
| D10 | gtc/constants 中 **28 个**常量函数使用具体类型硬编码值直接返回（v8 修订：v7 误标为 25） | 与 GLM `genType(3.14159...)` 实现方式一致，避免函数间调用依赖 |
| D11 | **v3 关键决策，v12 修订**：转换函数实现位于 `glm.detail.type_quat_cast.cj`，`gtc/quaternion.cj` 通过 `public import` 重导出；gtc 端重导出函数名为 camelCase `mat3Cast`/`mat4Cast`/`quatCast`（与 detail 端原始函数名一致），**非** GLM 习惯的 snake_case `mat3_cast`/`mat4_cast`/`quat_cast` | **消除包间循环依赖**（v3 核心理由）：v2 设计将转换函数放在 gtc 导致 `type_quat.cj` 需 `import glm.gtc.quaternion` 形成 `glm.detail ↔ glm.gtc` 双向依赖，违反仓颉包间循环依赖约束（cangjie-lang-features package/README.md 第 99 行）。v3 决策将转换函数下沉至 detail 包，让 `type_quat.cj` 通过同包访问直接调用（无需 import），`gtc/quaternion.cj` 通过 `public import` 重导出至 gtc 命名空间，保留 GLM 1:1 API 形态的同时彻底打破循环依赖。**v12 修订理由**：仓颉 `public import a.b.f` 仅重导出 f 原始名（依据 `cangjie-lang-features/package/README.md` 第 156-166 行规范），不做命名转换；detail 端原始函数名为 camelCase `mat3Cast`/`mat4Cast`/`quatCast`，因此 gtc 端重导出后仍为 camelCase——下游按 GLM 习惯使用 snake_case `mat3_cast`/`mat4_cast`/`quat_cast` 调用 `glm.gtc.quaternion.mat3_cast(q)` 将编译失败。该偏差属「API 命名风格」类差异，与现有 `public import glm.detail.{transpose, matrixCompMult, outerProduct}`（`cjglm/src/lib.cj:8`，camelCase）模式一致 |
| D12 | type_quat.inl 中 fromVec3(u,v) 和 fromEuler(eulerAngle) 构造函数本阶段化简为独立工厂函数 | 避免在 Quat 结构体内引入对 stub 函数的编译依赖；工厂函数在 extend 块中定义，可推迟至阶段四完整实现 |
| D13 | quatLookAt/quatLookAtRH/quatLookAtLH 等 gtc/quaternion 函数本阶段 stub 占位 | 这些函数依赖 geometric.cj 的 cross/dot/normalize/inversesqrt（均为 stub），无法完整实现 |
| D14 | quaternion_geometric.cj（dot/length/normalize/cross）本阶段完整实现 | 经分析确认依赖链仅止于 std.math.sqrt，不依赖任何 stub 文件 |
| D15 | quaternion_common.cj 中 conjugate/inverse/lerp/isnan/isinf 本阶段完整实现 | conjugate/inverse/lerp 仅需算术运算和 dot（已完整实现）；isnan/isinf 采用 std.math 实例方法路径，不依赖顶层函数 |
| D16 | trigonometric.cj 新增为空桩文件 | type_quat.inl 依赖 trigonometric.hpp，本阶段仅提供签名空壳供依赖闭合 |
| D17 | Bool 四元数不支持算术运算 | Bool 不实现 Number<T> 接口，与阶段二 D33 Bool 矩阵策略一致 |
| D18 | scalar_quat_ops.cj 与 scalar_vec_ops.cj/scalar_mat_ops.cj 同名重载 | add/sub/mul/div 与向量/矩阵版本通过第二参数类型消歧，与阶段二策略一致 |
| D19 | 四元数算术运算符统一标注 @OverflowWrapping | 与阶段一/二所有算术运算符（含浮点重载）保持一致；标注对浮点无效果但保持跨整数/浮点实例化的统一行为 |
| D20 | **`gtc/quaternion.cj` 独立文件承载 15 函数（v3 明确：4 重导出 + 4 完整 + 7 stub）** | 与 GLM `gtc/quaternion.hpp` 1:1 映射，便于 GLM 函数到仓颉文件的追溯；与阶段二 gtc 子包策略一致 |
| D21 | **`mix`/`slerp`/`pow` 的依赖明确包含 `epsilon<T>()`（v3 新增）；`pow` 进一步包含 `cos_one_over_two<T>()`、`asin`、**调用 `std.math.pow` 实数降级路径两次（line 65 + line 78，两次独立调用而非 self-recursion）**与 `std::numeric_limits<T>::min()` 等价物（v5 强化，v7 接口名修订，**v10 关键修订：std.math.pow 实际签名为 `(Float64, Float64): Float64`，非泛型 `(T, T): T`，v11 关键修订：std.math.pow 实际有 4 个重载 `pow(Float32, Float32)`/`pow(Float32, Int32)`/`pow(Float64, Float64)`/`pow(Float64, Int64)`**；**v11 关键修订：line 65 `wxyz(pow(x.w, y), 0, 0, 0)` 仓颉等价为 `Quat(0, 0, 0, T(std.math.pow(...)))`（仓颉主构造顺序为 x/y/z/w 与 GLM wxyz 顺序相反）；line 78 `T Mag = pow(magnitude, y-1)` 仓颉等价为 `T Mag = T(std.math.pow(Float64(magnitude), Float64(y - T(1))))`**；**v11 关键修订，Issue 6 响应：将 v10「递归调用」措辞修订为「调用 `std.math.pow` 实数降级路径两次」**）** | 与 GLM `quaternion_common.inl`/`quaternion_exponential.inl:41-80` 实际依赖一致：`mix`/`slerp` 依赖 `cosTheta > 1 - epsilon<T>()` 退化检测分支；`pow` 在 line 52 使用 `cos_one_over_two<T>()`，line 63 使用 `std::numeric_limits<T>::min()` 进行次正规数边界检查，line 65 + line 78 分别调用 `std::pow` 实数降级路径（line 65 在次正规数过小分支返回时调用一次，line 78 在一般路径调用一次计算 `magnitude^(y-1)`），line 68 使用 `asin`。仓颉版本需明确：(1) `pow` 函数体内部调用的是 `std.math.pow` 实数版本（**v11 关键修订**：仓颉 stdlib 实际提供 4 个 `pow` 重载——`pow(Float32, Float32): Float32`、`pow(Float32, Int32): Float32`、`pow(Float64, Float64): Float64`、`pow(Float64, Int64): Float64`，依据 `cangjie-original-docs/std/math/math_package_api/math_package_funcs.md` 第 4289-4397 行明确定义——下游实现时根据 T 实例化类型选择对应重载，T=Float32 时直接调用 `pow(Float32, Float32)` 即可，无需 Float64 转换），与四元数 `pow` 通过参数类型消歧；(2) 若 `std.math.pow` 不存在，需以 `exp(y * log(x.w))` 替代（`std.math.exp`/`log` 同样提供 Float16/Float32/Float64 重载）；(3) **`std::numeric_limits<T>::min()` 等价物获取（v11 关键修订）**：仓颉 stdlib **实际提供** `FloatingPoint<T>.getMinDenormal()` 静态方法（依据 `cangjie-original-docs/std/math/math_package_api/math_package_interfaces.md` 第 49-60 行定义）——v10 描述「`FloatingPoint<T>` 接口本身无任何实例方法」错误（Issue 8 关联），`FloatingPoint<T>` 接口实际提供 6 个静态方法（`getE`/`getInf`/`getPI`/`getMinDenormal`/`getMinNormal`/`getNaN`）+ 3 个实例方法（`isInf`/`isNaN`/`isNormal`），下游实现应直接调用 `FloatingPoint<T>.getMinDenormal()` 而非类型分派；(4) **`std::numeric_limits<T>::infinity()` 等价物获取（v11 关键修订）**：仓颉 stdlib **实际提供** `FloatingPoint<T>.getInf()` 静态方法（依据同接口定义第 37-48 行）——v10 描述的「`FloatingPoint<T>.getInf()` 实例方法不存在」错误，下游实现应直接调用 `FloatingPoint<T>.getInf()` |
| D22 | **`slerp` 4 参数版本 `k: Int64` 简化签名（v3 新增）** | 与 deviations.md DV-03「移位运算右操作数固定为 Int64」风格一致；阶段三 slerp 为 stub，固定 `Int64` 简化签名不影响本阶段实施 |
| D23 | **`lerp` 实现含 `assert(a >= 0 && a <= 1)` 断言（v3 新增）** | 与 GLM `ext/quaternion_common.inl:28-38` 一致，确保插值因子在 [0, 1] 范围内 |
| D24 | **向量 `equal` epsilon 比较采用严格 `<` 语义（v3 新增，v9 修订 GLM 文件引用）** | 与 GLM `glm/gtc/epsilon.inl:32-41` 中 `epsilonEqual` 实现一致，避免边界用例下 `equal(v, v, 0) = true` 的语义偏差。原引用 `func_vector_relational.inl:18-22` 错误——GLM 1.0.3 的 `func_vector_relational.inl` 中**不包含 epsilon 版本**的 `equal`/`notEqual`，epsilon 版本位于 `glm/gtc/epsilon.inl`（文件层面属 gtc 子包） |
| D25 | **`scalar_constants` 对整数类型 T 触发运行时异常（v3 新增）** | 与 GLM `static_assert(is_iec559, ...)` 编译期断言等价行为（仓颉泛型若不支持窄约束则用运行时异常） |
| D26 | **`Quat×Vec3` 旋转公式采用两次 Vec3 叉乘（v3 新增）** | 与 GLM `type_quat.inl:359-366` 实际实现一致：`v + (cross(QuatVector, v) * q.w + cross(QuatVector, cross(QuatVector, v))) * 2`（uv 和 uuv 两次叉乘） |
| D27 | **fwd.cj 排除整型与 Bool 四元数别名（v3 明确，v8 修订先例引用）** | **v8 修订**：v7 文档引用阶段二「fwd.cj 排除整型矩阵别名」作为唯一先例，但该先例存在两处不准确：① 阶段一 Vec 家族**包含** `BVec2`（Bool 向量，见 `cjglm/src/fwd.cj:140-143`）的 Bool 别名，Vec 家族对 Bool 类型的处理策略与 Mat 家族不同；② 阶段二 Mat 家族明确不含整型别名（`cjglm/src/fwd.cj` 全文 grep 验证零整型别名），阶段一 Vec 家族对整型的处理（无 `IVec*`）与 Mat 家族策略一致。**v8 明确**：fwd.cj 排除整型与 Bool 四元数别名的依据是——**整型四元数无实际用例**（quaternion 自然语义是旋转表达，整型四元数不参与实际数学运算）+ **Bool 四元数无实际用途**（D17：Bool 不实现 `Number<T>` 接口，算术运算编译期拒绝，无实用价值）。**v8 新增统一策略**：阶段三所有自定义类型族（Vec/Mat/Quat）均排除整型别名（语义不适用）+ 选择性排除 Bool 别名（Vec 家族保留 `BVec*` 因位运算是核心用例，Mat 家族不含 `BMat*` 因矩阵不参与位运算，Quat 家族不含 `BQuat*` 因四元数不参与位运算且算术不可用）。下游可参考本策略理解「哪些类型族为何种用途排除何种别名」。 |
| D28 | **v3 关键决策**：包间依赖方向严格单向——`glm.gtc → glm.detail`、`glm.ext → glm.detail`、上层不依赖下层 | 仓颉 cjpm 构建系统严格禁止包间循环依赖（cangjie-lang-features package/README.md 第 99 行）；D11 的 `type_quat_cast.cj` 下沉决策是本约束的直接体现 |
| D29 | **`isnan`/`isinf` 函数约束收紧为 `where T <: FloatingPoint<T>`（v4 修订，v7 接口名修订）** | `std.math` 的 `isNaN()`/`isInf()` 实例方法仅定义于浮点类型（`FloatingPoint<T>` 接口，stdlib 原生接口名），整数类型（`Int8`/`Int16`/`Int32`/`Int64`）无此方法。若不收紧约束，当用户实例化 `Quat<Int64, PackedHighp>` 并调用 `isnan(q)` 时，函数体内部 `q.x.isNaN()` 因 `Int64` 不实现 `isNaN()` 而编译失败。与 §3.12 `epsilon<T>()` 约束收紧策略（v3 已明确）保持一致；`FloatingPoint<T>` 是 stdlib 原生接口，编译期保证可用，无需 fallback |
| D30 | **Quat 字段统一标注 `public var`（v4 修订）** | 满足 `@Derive[Hashable]` 派生宏对字段 `public` 可见性的硬性要求（依据 `cangjie-std/deriving/README.md` 第 4 节「参与派生的字段/属性必须为 public」）。仓颉 struct 字段默认可见性为 `internal`（依据 `struct/README.md` 第 1.7 节），不满足 public 派生要求；与阶段一 Vec3 (`type_vec3.cj:8-10`)、阶段二全部矩阵类型 (`type_mat*.cj` 200+ 处统一实践) 对齐 |
| D31 | **`axis` 函数实现采用 GLM 独立公式路径而非 `normalize` 路径（v5 关键修订）** | GLM `ext/quaternion_trigonometric.inl:20-27` 实际实现是 `tmp1 = 1 - x.w*x.w` 独立公式，不调用 `normalize(Vec3(q.x, q.y, q.z))`。v3 描述的「内部 `normalize(Vec3(0, 0, 0))`」为虚构实现——若按 v3 描述实现，则需依赖 `geometric.cj` 的向量 `normalize`（阶段三为 stub），与同段「可完整实现」声明矛盾。v5 修订后：`axis` 依赖仅 `std.math.sqrt` 和 T(1) 演算，触发 `Vec3(0, 0, 1)` 返回值的条件为 `1 - x.w*x.w <= 0`（典型：单位四元数 (0, 0, 0, 1)），对于真正零四元数 (0, 0, 0, 0) 返回 `Vec3(0, 0, 0)` |
| D32 | **`type_quat_cast` 函数约束收紧为 `where T <: FloatingPoint<T>`（v5 新增，v7 接口名修订）** | 与 D29 `isnan`/`isinf` 约束收紧策略一致。GLM 1.0.3 在转换函数定义处使用 `GLM_STATIC_ASSERT(std::numeric_limits<T>::is_iec559, ...)` 静态断言非浮点类型时编译失败，仓颉版本通过 `FloatingPoint<T>` 接口约束（stdlib 原生接口）实现等价行为。`mat3Cast`/`mat4Cast`/`quatCast` 两个重载共 4 个函数统一采用此约束；`FloatingPoint<T>` 是 stdlib 原生接口，编译期保证可用，无需 fallback |
| D33 | **比较函数（`lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual`）采用 `Comparable<T>` 宽约束而非 `FloatingPoint<T>` 窄约束（v14 新增，Issue 6 响应）** | 理由：(a) GLM 原始实现中 4 个比较函数无 `GLM_STATIC_ASSERT(is_iec559)` 断言，整数类型也可合法调用——与 `mat3Cast`/`mat4Cast`/`quatCast` 等带 `is_iec559` 断言的函数有别；(b) 比较运算符 `<`/`<=`/`>`/`>=` 对整数类型语义正确（整数四元数按分量大小比较有实际意义），收紧至 `FloatingPoint<T>` 会排除整数四元数的合法比较用例；(c) 与需浮点运算的 `mat3Cast`/`quatCast` 场景区分——后者涉及 `sqrt`/`trace` 等仅在浮点类型上有意义的运算，而比较仅依赖 `<`/`<=`/`>`/`>=` 运算符，`Comparable<T>` 约束已足够保证运算符可用性；与 §3.15 完整实现函数段/§11.5 函数可用性对照表 `where T <: Comparable<T>` 声明一致 |

---

## 8. 阶段三产出物清单

**v16 修订，Issue 2 响应**：本节产出物分类统一调整为与 §11.5 函数可用性对照表对齐的三档分类——「✅ 可用（无 stub 依赖）」/「⚠️/❌ 混合（部分可用、部分 stub）」/「❌ stub（空桩占位）」。**全文档函数可用状态以 §11.5 为最终基准**。

### ✅ 可用（无 stub 依赖，运行时可正常调用）

- `detail/type_quat.cj`（四元数核心类型 + 运算符，fromMat3/fromMat4 调用同包 type_quat_cast.cj 函数）
- **`detail/type_quat_cast.cj（v3 新增）`**（4 个矩阵-四元数互转函数：mat3Cast/mat4Cast/quatCast 两个重载）
- `detail/scalar_constants.cj`（标量常量 epsilon/pi/cos_one_over_two，对整数类型抛异常）
- `detail/scalar_quat_ops.cj`（标量-四元数全局函数 add/sub/mul/div）
- `ext/quaternion_relational.cj`（四元数关系运算，4 函数完整实现）
- `ext/quaternion_geometric.cj`（四元数 dot/length/normalize/cross，4 函数完整实现）
- `ext/scalar_constants.cj`（ext 重导出接口）
- `gtc/constants.cj`（**28 个**数学常量函数，v8 修订：与 GLM 1.0.3 `gtc/constants.inl` 实际声明数一致）
- 四元数别名文件（4 个 ext/ 文件）
- 四元数测试文件（详见 §8.2，`test_xxx.cj` 命名约定，v8 修订）

**说明**：以上文件中的函数均为「真完整实现」（无 stub 依赖），运行时可正常调用，不抛 `Exception("stub")`。共 **21 个函数**（epsilon/pi/cos_one_over_two/axis/length/normalize/inverse/isnan/isinf/mat3Cast/mat4Cast/quatCast(Mat3)/quatCast(Mat4)/conjugate/lerp/dot/cross(Quat)/equal(Quat)/notEqual(Quat)/identity/±*/==!= 等运算符），详见 §11.5 函数可用性对照表。

### ⚠️/❌ 混合（部分函数 ✅ 可用、部分 ❌ stub）

- `ext/quaternion_common.cj`（conjugate/inverse/lerp/isnan/isinf 共 5 函数 ✅ 可用；mix/slerp(2 版本) 共 3 函数 ❌ stub）
- `ext/quaternion_trigonometric.cj`（axis 1 函数 ✅ 可用；angle/angleAxis 2 函数 ❌ stub）
- `ext/quaternion_transform.cj`（rotate 1 函数 ❌ stub。**v13 关键修订，Issue 5 响应**：该文件仅含 `rotate` 一个函数且为 stub，即 100% stub）
- `ext/quaternion_exponential.cj`（exp/log/pow/sqrt 全部 ❌ stub）
- `gtc/quaternion.cj`（mat3Cast/mat4Cast/quatCast×2 重导出 4 函数 ✅ 可用 + lessThan/lessThanEqual/greaterThan/greaterThanEqual 4 函数 ✅ 可用 + eulerAngles/roll/pitch/yaw/quatLookAt/quatLookAtRH/quatLookAtLH 7 函数 ❌ stub = 4 重导出 + 4 完整 + 7 stub）
- `ext/vector_relational.cj`（epsilon 版 16 重载 ✅ 可用；ULP 版 8 重载 ❌ stub）

### ❌ stub（空桩占位，运行均抛 Exception("stub")）

- `gtc/matrix_transform.cj`（64 个函数全部 ❌ stub）
- `detail/trigonometric.cj`（75 个展开函数全部 ❌ stub）
- `ext/matrix_projection.cj`
- `ext/matrix_clip_space.cj`
- `ext/matrix_transform.cj`

### 沿用自阶段二的 stub（❌ stub，运行均抛 Exception("stub")）

- `detail/common.cj`
- `detail/geometric.cj`
- `detail/matrix.cj`（27 实现 + 6 stub，均视为 stub 引用，本阶段不新增实现）

### 更新文件

- `fwd.cj`：新增 9 个四元数类型别名（Quat/FQuat/DQuat + 3×Float32 精度 + 3×Float64 精度；具体清单见 §2 lib.cj/fwd.cj 段落，v5 明确，**v12 关键修订，Issue 2 响应，v13 关键修订 Issue 3 响应**：fwd.cj 是自动生成文件（`cjglm/src/fwd.cj:1-2` 文件头注释为中文而非 v12 描述的英文「Auto-generated file. Do not edit!」），下游实施路径为方案 A 修改 `cjglm/scripts/gen_fwd_aliases.py` 生成脚本（**v13 修订**：v12 描述 `tools/gen_fwd.cj` 与实际不符），新增 `VEC_FAMILIES` 字典条目 + Quat 固定 4 维特殊处理分支；详见 §2 段落末尾「实施路径」说明）
- `lib.cj`：新增 Quat 类型、type_quat_cast 函数、ext/gtc 函数和常量的 public import（具体清单见 §2 lib.cj/fwd.cj 段落，v5 明确：20 个 `import` 声明，v9 扩展补齐）

### 测试设计（v3 新增 §8.2）

#### 测试文件清单与位置

阶段三测试文件位于 `tests/glm/` 目录下，按模块拆分：

| 测试文件 | 覆盖模块 | 预计用例数 |
|---------|---------|----------|
| `tests/glm/detail/test_type_quat.cj` | Quat 核心类型 + 运算符 | ≥40 |
| `tests/glm/detail/test_type_quat_cast.cj` | 矩阵-四元数互转函数（v3 新增） | ≥8 |
| `tests/glm/test_ext_quaternion_relational.cj` | 四元数关系运算（v10 修订：与 `test_ext.cj` 同层平铺命名，避免新建 `tests/glm/ext/` 子目录） | ≥8 |
| `tests/glm/test_ext_quaternion_geometric.cj` | 四元数几何函数（v10 修订：同层平铺命名） | ≥12 |
| `tests/glm/test_ext_quaternion_common.cj` | 四元数公共函数（v10 修订：同层平铺命名） | ≥16 |
| `tests/glm/test_ext_quaternion_trigonometric.cj` | 四元数三角函数（v10 修订：同层平铺命名） | ≥8 |
| `tests/glm/test_ext_quaternion_exponential.cj` | 四元数指数函数（stub）（v10 修订：同层平铺命名） | ≥4 |
| `tests/glm/test_ext_quaternion_transform.cj` | 四元数变换函数（stub）（v10 修订：同层平铺命名） | ≥2 |
| `tests/glm/test_ext_vector_relational.cj` | 向量 epsilon/ULP 比较（v10 修订：同层平铺命名） | ≥16 |
| `tests/glm/test_ext_scalar_constants.cj` | 标量常量（v10 修订：同层平铺命名；**v12 修订，Issue 8 响应**：用例数按「完整实现函数：每函数 ≥2 个用例」原则计算——3 个泛型函数 × 2 种浮点类型 × 2 用例 + 1 整数类型异常路径 = 13） | ≥13 |
| `tests/glm/test_ext_quaternion_aliases.cj` | 四元数别名（4 个别名文件合并测试，v10 修订：避免为每个别名文件单独建测试文件，**v12 关键修订，Issue 8 响应**：每别名 ≥1 用例，9 个别名共 ≥9 用例） | ≥9 |
| `tests/glm/gtc/test_constants.cj` | 数学常量 | ≥28（v8 修订：与 §3.12 gtc/constants 28 个常量函数对齐） |
| `tests/glm/gtc/test_quaternion.cj` | gtc 四元数转换重导出/比较/欧拉/看向 | ≥27（v8 修订：见下方用例分配原则） |
| `tests/glm/gtc/test_matrix_transform_stubs.cj` | gtc/matrix_transform 64 个 stub 函数 | ≥8 |
| **合计** | — | **≥199**（v12 修订，Issue 8 响应：v11 累加 179 + `test_ext_quaternion_aliases.cj` 从 ≥4 提升至 ≥9 增量 5；`test_ext_scalar_constants.cj` 从 ≥7 提升至 ≥13 增量 6；按上述每行 ≥值求和：40+8+8+12+16+8+4+2+16+13+9+28+27+8=199） |

**v8 修订**：v7 文档 13 个测试文件均使用 `xxx_test.cj` 命名，但与项目实际不一致——通过 `ls cjglm/tests/glm/detail/` 验证阶段二现有约定**全部使用** `test_xxx.cj` 风格（`test_common.cj`/`test_geometric.cj`/`test_matrix.cj`/`test_qualifier.cj`/`test_scalar_mat_ops.cj`/`test_scalar_vec_ops.cj`/`test_setup.cj` 等 10+ 个文件），阶段三测试文件统一调整为 `test_xxx.cj` 风格以与现有约定对齐。

**测试目录结构对齐策略（v10 新增，Issue 8 响应）**：v9 设计的测试文件位于 `tests/glm/ext/` 与 `tests/glm/gtc/` 子目录中（与 `src/ext/` + `src/gtc/` 子包目录结构对齐），但**项目当前无 `tests/glm/ext/` 与 `tests/glm/gtc/` 子目录先例**——阶段二 25 个测试文件均位于 `tests/glm/` 根目录（如 `test_ext.cj`）或 `tests/glm/detail/` 子目录；`test_ext.cj` 是单一聚合文件而非按函数拆分。**v10 修订策略**：
- (a) **避免新建子目录**：`tests/glm/ext/` 与 `tests/glm/gtc/` 子目录本轮不新建；所有新增测试文件采用 `tests/glm/test_xxx.cj` 同层平铺命名（与 `test_ext.cj` 一致）；gtc 相关测试暂使用 `tests/glm/gtc/test_xxx.cj` 平铺子目录结构（避免与既有 ext 测试文件混淆）
- (b) **既有 `test_ext.cj` 兼容策略**：现有 `tests/glm/test_ext.cj`（102 行，验证 ext 包基础别名如 `ext.Mat4x4`）保持原状；新增的 `tests/glm/test_ext_xxx.cj` 文件按 ext 子模块拆分（如 `test_ext_vector_relational.cj`/`test_ext_quaternion_xxx.cj` 等），与 `test_ext.cj` 并存不冲突
- (c) **别名测试合并**：4 个 ext/ 别名文件（`quaternion_float.cj`/`quaternion_double.cj`/`quaternion_float_precision.cj`/`quaternion_double_precision.cj`）的测试合并为单一 `tests/glm/test_ext_quaternion_aliases.cj` 文件，避免为每个别名文件单独建测试文件
- (d) **下游实施步骤**：测试文件创建前无需 `mkdir -p`，按上述命名直接创建在对应目录即可

**v10 修订**：v9 设计的 `tests/glm/ext/test_xxx.cj` 与 `tests/glm/gtc/test_xxx.cj` 命名方案修订为上表所示的同层平铺命名；gtc 子目录保留但仅用于阶段三新增的 gtc 测试文件（与 src/gtc/ 子包源码位置镜像），不引入更深的子目录层级。

**用例分配原则（v8 新增）**：
- **完整实现函数**：每函数 **≥2 个用例**（覆盖正常路径 + 边界场景）
- **stub 函数**：每函数 **≥1 个用例**（验证抛 `Exception("stub")` 异常）
- **重导出函数**：每函数 **≥1 个用例**（验证可达性，调用返回正确结果）

**`tests/glm/gtc/test_quaternion.cj` 用例数重算（v8 修订）**：v7 文档原 20 个用例，8 个完整实现函数（4 比较 + 4 转换重导出）平均仅 2.5 个/函数，低于用例分配原则。按 v8 原则重算：
- 4 个完整实现（`lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual`）：4 × 2 = **8 个用例**
- 4 个重导出（`mat3Cast`/`mat4Cast`/`quatCast(Mat3)`/`quatCast(Mat4)`，每函数另加 1 个可达性测试）：4 × (2 + 1) = **12 个用例**（v8 修订：重导出函数按"完整实现函数 + 1 可达性测试"双重覆盖，确保下游消费者既验证返回值正确性也验证调用链通畅）
- 7 个 stub（`eulerAngles`/`roll`/`pitch`/`yaw`/`quatLookAt`/`quatLookAtRH`/`quatLookAtLH`）：7 × 1 = **7 个用例**（验证抛 stub 异常）
- **合计**：8 + 12 + 7 = **27 个用例**（v8 修订：与 8×2 + 7×1 + 4×1 = 27 公式一致，分解为「8 可测函数 × 2 = 16 + 4 重导出可达性测试 × 1 = 4 + 7 stub × 1 = 7 = 27」）

#### 用例到函数的逐项分配依据（v13 新增，Issue 6 响应）

为满足 ≥199 用例的覆盖充分性可追溯性，以下按测试文件逐一列明函数分组与用例分配依据，确保每个用例均可追溯到§11.5表中的对应函数：

| 测试文件 | 函数分组 | 函数数 | 每函数用例数 | 分组合计 | 分配依据 |
|---------|---------|--------|------------|---------|---------|
| `test_type_quat.cj` | 构造函数（item 1-7, 10，共 8 个完整实现） | 8 | 2 | 16 | 完整实现 ≥2用例/函数 |
| | fromVec3/fromEuler（2 个 stub） | 2 | 1 | 2 | stub ≥1用例/函数 |
| | 运算符算术（`+`/`-`/`*`/`/`/一元`-`，共 5 个） | 5 | 2 | 10 | 完整实现 ≥2用例/函数 |
| | 运算符 `==`/`!=`（2 个） | 2 | 1 | 2 | 精确比较 ≥1用例/函数 |
| | Quat×Vec3/Vec4（2 个 ⚠️） | 2 | 2（1 编译 + 1 assertThrows） | 4 | ⚠️ 阻塞函数 ≥1编译 + ≥1运行时 |
| | Vec3×Quat/Vec4×Quat（2 个） | 2 | 1 | 2 | 依赖 inverse 路径 ≥1用例 |
| | Quat×T/T×Quat/Quat/T/scalar_quat_ops（6 个） | 6 | 1 | 6 | 标量运算 ≥1用例 |
| | **小计** | **27 函数** | — | **42** | 略超 ≥40 下限 |
| `test_type_quat_cast.cj` | mat3Cast/mat4Cast/quatCast×2（4 个） | 4 | 2 | 8 | 完整实现 ≥2用例/函数 |
| `test_ext_quaternion_relational.cj` | equal×2/notEqual×2（4 个） | 4 | 2 | 8 | 完整实现 ≥2用例/函数 |
| `test_ext_quaternion_geometric.cj` | dot/length/normalize/cross（4 个） | 4 | 3 | 12 | 完整实现 ≥2用例 + 边界(如normalize零保护) |
| `test_ext_quaternion_common.cj` | conjugate/inverse/lerp/isnan/isinf（5 个完整） | 5 | 2 | 10 | 完整实现 ≥2用例/函数 |
| | mix/slerp×2（3 个 stub） | 3 | 1 | 3 | stub ≥1用例/函数 |
| | **小计** | **8 函数** | — | **13** | 略低于 ≥16 下限（可提升至 16 通过增加边界用例） |
| `test_ext_quaternion_trigonometric.cj` | axis（1 个完整） | 1 | 2 | 2 | 完整实现 ≥2用例/函数（含零四元数边界） |
| | angle/angleAxis（2 个 stub） | 2 | 1 | 2 | stub ≥1用例/函数 |
| | **小计** | **3 函数** | — | **4** | 略低于 ≥8 下限（可用 4 个多余用例补足至 8） |
| `test_ext_quaternion_exponential.cj` | exp/log/pow/sqrt（4 个 stub） | 4 | 1 | 4 | stub ≥1用例/函数 |
| `test_ext_quaternion_transform.cj` | rotate（1 个 stub） | 1 | 1 | 1 | stub ≥1用例/函数（≥2 含 1 个额外边界验证） |
| `test_ext_vector_relational.cj` | epsilon equal/notEqual（16 个重载） | 16 | 1 | 16 | 完整实现 ≥2用例/函数（实际每重载 1 用例即可；16 略低于 ≥16 下限，实际可补至 32） |
| `test_ext_scalar_constants.cj` | epsilon/pi/cos_one_over_two（3 函数 × 2 浮点类型） | 6 | 2 | 12 | 完整实现 ≥2用例 × 2 类型 |
| | 整数异常路径 | 1 | 1 | 1 | 异常路径 1 用例 |
| | **小计** | **7 条目标** | — | **13** | 与 ≥13 一致 |
| `test_ext_quaternion_aliases.cj` | 9 个别名（Quat/FQuat/DQuat + 3×Float32精度 + 3×Float64精度） | 9 | 1 | 9 | 每别名 ≥1用例 |
| `test_constants.cj` | 28 个常量函数 | 28 | 1 | 28 | 每常量 ≥1用例 |
| `test_quaternion.cj` | 4 个比较函数 | 4 | 2 | 8 | 完整实现 ≥2用例/函数 |
| | 4 个重导出函数 | 4 | 3（2 功能 + 1 可达性） | 12 | 完整实现 + 可达性 |
| | 7 个 stub | 7 | 1 | 7 | stub ≥1用例/函数 |
| | **小计** | **15 函数** | — | **27** | 与 ≥27 一致 |
| `test_matrix_transform_stubs.cj` | 64 个 stub 函数 | 64 | 按类别抽样 | 8 | stub ≥1用例/函数（64 个同类 stub 按类别分组抽样验证） |
| | **全表总计** | — | — | ≥199 | 逐项相加：42+8+8+12+13(≥16)+4(≥8)+4+2(≥2)+16(≥16)+13+9+28+27+8 = 194（下限）；通过增补三角函数/geometric 边界用例 5 个可轻松达到 ≥199 |

**v13 修订，Issue 6 响应**：上表中 `test_ext_quaternion_trigonometric.cj`（4 ≤ 8）与 `test_ext_quaternion_common.cj`（13 ≤ 16）的分组合计略低于各自文件中声明的 ≥下限。下游编码者可依据「每函数 ≥1 额外边界用例」原则补齐差值（如为 `trigonometric` 的 2 个 stub 各增加 1 个不同参数类型边界用例 + 为 `common` 的 `isnan`/`isinf` 各增加 1 个跨 Qualifier 用例），确保各文件实际用例数不低于表中原声明的 ≥值。全表 ≥199 合计值通过上述补齐可达。

#### 测试覆盖维度

1. **构造路径**：单位构造、逐分量构造、wxyz 工厂、标量+向量构造、跨 Qualifier 构造、跨类型构造（fromQuat）、从矩阵构造（fromMat3/fromMat4）、从两向量构造（fromVec3 stub）、从欧拉角构造（fromEuler stub）
2. **运算符正常路径**：算术运算（+ - * / 一元 -）、Quat×Vec3/Vec4 旋转、Vec3×Quat/Vec4×Quat 逆旋转、Quat×T 标量运算、==/!= 比较
3. **ext 函数库正常路径**：vector_relational 16 重载、quaternion_relational 4 函数、quaternion_geometric 4 函数、quaternion_common 中 conjugate/inverse/lerp/isnan/isinf 5 函数、quaternion_trigonometric 中 axis 1 函数
4. **gtc/quaternion.cj 正常路径（v3 新增）**：4 个比较函数（lessThan/lessThanEqual/greaterThan/greaterThanEqual）+ 4 个转换函数重导出（mat3Cast/mat4Cast/quatCast 两个重载）+ **detail/type_quat_cast 单元测试覆盖实现细节**（v3 新增）
5. **stub 函数异常路径**：mix/slerp(2 版本)/angle/angleAxis/exp/log/pow/sqrt/rotate/eulerAngles/roll/pitch/yaw/quatLookAt* 调用时验证抛 `Exception("stub")`
6. **跨 Qualifier 实例化**：PackedHighp/PackedMediump/PackedLowp/AlignedHighp/AlignedMediump/AlignedLowp 6 种精度的 Quat 运算符测试
7. **跨类型实例化**：Float32/Float64 的 Quat 完整测试，整型 Quat 仅测试非依赖 stub 的运算符（边界处理）
8. **⚠️ 已实现但被 stub 阻塞函数**（v12 新增，Issue 7 响应）：覆盖 `Quat×Vec3`/`Quat×Vec4` 运算符。要求：每函数 ≥1 个编译期测试（验证 `cjpm build` 通过）+ ≥1 个运行时 `assertThrows` 测试（验证抛 `Exception("stub")`）。§11.5 ⚠️ 符号行同步引用本覆盖要求。

#### 浮点比较策略

- **epsilon 版本**：使用 `epsilon<Float32>() = 1.1920929e-7` 作为容差，调用 `equal(v1, v2, epsilon<Float32>())` 验证
- **精确比较**：对于 should be 精确相等的运算结果（如 `identity * v == v`），使用 `==` 直接比较
- **角度比较**：旋转等价性使用「四元数点积绝对值接近 1」判断（`abs(dot(q1, q2)) > 1 - epsilon<Float32>()`），避免 q 与 -q 的双重覆盖
- **type_quat_cast 单元测试（v3 新增）**：使用「旋转矩阵 * 向量 = 四元数 * 向量」等价性测试（`m3 * v == q * v`）验证互转正确性

#### 阶段三可验证 vs 待阶段四拆分

- **本阶段可验证**（路线图标注 `[可验证]`）：所有「完整实现」函数 + 「stub 函数异常路径」（验证抛 stub 异常）
- **部分可验证**（路线图标注 `[部分可验证]`）：运算符依赖 stub 的部分（如 `Quat×Vec3` 旋转调用抛 stub 异常），需在测试中标注「本阶段抛 stub 异常，待阶段四 geometric.cj 完整实现后生效」
- **待阶段四**（路线图标注 `[待 Stage 4]`）：stub 函数的正常路径测试（如 slerp 球面插值结果、pow 指数运算结果）推迟至阶段四函数库完整实现后补齐

### 8.4 阶段三实施批次建议（v16 新增，Issue 3 响应）

本阶段涉及 25+ 个源文件的创建与修改，按拓扑依赖排序给出以下 4 批实施顺序建议。每批完成后可独立验证（`cjpm build` 编译通过）。

**实施批次划分原则**：① 被依赖的文件先于依赖者实施；② 每个批次内的文件无相互依赖，可并行实施；③ `gen_fwd_aliases.py` 修改在第一批完成，确保后续 alias 引用可用。

| 批次 | 文件清单 | 实施内容 | 验证标准 |
|------|---------|---------|---------|
| **第一批（基础设施 + 别名）** | `detail/type_quat.cj` + `detail/type_quat_cast.cj` + `detail/scalar_constants.cj` + `detail/scalar_quat_ops.cj` + 4 个 ext/ 别名文件 + `gen_fwd_aliases.py` 修改 + `fwd.cj` 重新生成 + `lib.cj` 追加 import 声明 | 四元数核心类型定义、运算符、转换函数；标量常量；标量-四元数运算；别名文件；自动生成脚本修改 | `cjpm build` 通过；`Quat<Float32,PackedHighp>.identity(1.0f)` 编译通过 |
| **第二批（ext 函数库 - 无 stub 依赖部分）** | `ext/quaternion_relational.cj` + `ext/quaternion_geometric.cj` + `ext/quaternion_common.cj`（先实现 conjugate/inverse/lerp/isnan/isinf 5 函数，mix/slerp stub 占位）+ `ext/quaternion_trigonometric.cj`（先实现 axis 函数，angle/angleAxis stub 占位）+ `ext/scalar_constants.cj`（重导出接口） | 四元数关系运算、几何函数、公共函数（可用部分）、三角函数（axis 部分） | 第二批函数运行时不抛 stub 异常；`assertThrows` 验证 stub 函数抛 `Exception("stub")` |
| **第三批（stub 函数库 + gtc 常量）** | `ext/quaternion_transform.cj`（rotate stub）+ `ext/quaternion_exponential.cj`（exp/log/pow/sqrt 全部 stub）+ `gtc/quaternion.cj`（4 重导出 + 4 完整 + 7 stub）+ `gtc/constants.cj`（28 常量） | 剩余 stub 函数声明；gtc 四元数重导出与比较函数；gtc 数学常量 | `cjpm build` 通过；gtc/quaternion 比较函数运行时正常；stub 函数 `assertThrows` 验证 |
| **第四批（空桩 + 继承 stub）** | `detail/trigonometric.cj`（75 展开函数 stub）+ `ext/matrix_projection.cj` + `ext/matrix_clip_space.cj` + `ext/matrix_transform.cj` + `gtc/matrix_transform.cj`（64 函数 stub）+ `ext/vector_relational.cj`（epsilon 16 重载 ✅ + ULP 8 重载 ❌） | 所有空桩文件函数签名声明；vector_relational 的 epsilon 比较部分 | `cjpm build` 通过；所有 stub 函数 `assertThrows` 验证 |

**关键依赖链说明**：
- `gen_fwd_aliases.py` 修改（第一批）→ 所有引用 `glm.Quat`/`glm.FQuat`/`glm.DQuat` 别名的代码
- `detail/type_quat.cj`（第一批）→ 所有 ext/gtc 函数库（第二~四批均依赖 Quat 类型存在）
- `ext/quaternion_geometric.cj`（第二批）→ `normalize`/`dot`/`length`/`cross` 被 `ext/quaternion_common.cj` 的 `inverse`/`lerp` 调用
- `detail/trigonometric.cj`（第四批）→ 仅需函数签名（stub），不影响第二~三批函数编译；运行时调用 stub 函数才抛异常

> **与项目路线图实施风格对齐说明**：本批次划分方式与 `docs/02_roadmap.md` 第 165-169 行的阶段四实施批次建议（按「第一批无函数库内部依赖 → 第二批依赖基础函数库 → 第三批依赖前两批 → 第四批 gtc/ 扩展函数库」拓扑排序）风格一致。

### 编码启动前验证项

1. **cjpm gtc 子包构建预验证**：验证 `src/gtc/` + `package glm.gtc` 的构建可行性（与 §2 末尾 cjpm 子包构建预验证策略对应）
2. **gtc/quaternion.cj 重导出 detail 函数验证（v3 新增）**：验证 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 能否正确将 detail 包级函数重导出至 glm.gtc 命名空间（无编译错误，外部 `glm.gtc.quaternion.mat3_cast(q)` 调用正常）
3. **包间无循环依赖验证（v3 新增）**：使用 `cjpm check` 命令验证整个项目不包含包间循环依赖（特别是 `glm.gtc` 与 `glm.detail` 之间），符合 cangjie-lang-features package/README.md 第 99 行约束
4. **type_quat.cj 同包调用 type_quat_cast.cj 函数验证**：验证 `fromMat3`/`fromMat4` 在 `type_quat.cj` 中调用同包 `type_quat_cast.cj` 的 `mat3Cast`/`mat4Cast`/`quatCast` 函数（同包内可见性，无需 import）
5. **Vec3/Vec4 extend 块中 Quat 类型前向引用验证**：Vec3×Quat 和 Vec4×Quat 运算符需在 Vec3/Vec4 的 extend 块中引用 Quat 类型，验证同包延迟解析（已通过阶段二原型验证，仅为防御性确认）
6. **scalar_constants 的泛型 `match` 类型模式匹配验证**：验证 `func epsilon<T>(hint: T): T where T <: Number<T>` 函数体内 `match (hint) { case _: Float32 => ... }` 编译通过
7. **scalar_constants 对整数类型 T 的行为契约验证**：验证 `epsilon<Int64>()` 调用时按 D25 决策抛出运行时异常（约束收紧若失败时的 fallback 路径）
8. **标量-四元数与标量-向量/标量-矩阵同名重载消歧验证**：`add(s: T, q: Quat<T,Q>)` 与 `add(s: T, v: Vec2<T,Q>)`/`add(s: T, m: Mat2x2<T,Q>)` 等的编译器消歧
9. **`x.isNaN()`/`x.isInf()` 实例方法路径验证**：确认仓颉标准库为所有浮点类型提供 `isNaN()`/`isInf()` 实例方法（影响 quaternion_common.cj 中 isnan/isinf 的实现可行性）
10. **ext/vector_relational 内联 abs 验证**：验证 `if (d >= T(0)) { d } else { -d }` 模式在 `Number<T> & Comparable<T>` 约束下的编译通过性
11. **`@Derive[Hashable]` 对 `Q <: Qualifier` 的支持验证**：验证 Hashable 派生宏对 6 个 Qualifier 实现类型的编译通过性
12. **`length(q)` 在 Float32 实例的 sqrt 转换验证**：验证 `T(Float64.sqrt(Float64(dot_qq)))` 路径或额外 Float32 重载的编译可行性
13. **`isnan`/`isinf` 函数约束收紧验证（v4 新增，v7 接口名修订，**v10 修订：删除错误引用**）**：验证 `where T <: FloatingPoint<T>` 约束（stdlib 原生接口，见 `cangjie-std/math/README.md` 第 117 行）在仓颉编译器的支持情况；实例化 `Quat<Float32, PackedHighp>` 调用 `isnan`/`isinf` 通过编译；实例化 `Quat<Int64, PackedHighp>` 调用 `isnan`/`isinf` 报类型不匹配错误。`FloatingPoint<T>` 是 stdlib 原生接口，无「不可用」风险，本验证项无需 fallback 验证。**v10 修订**：删除 v9 描述中「可验证 `FloatingPoint<T>` 接口的 `getMin()`/`getInf()` 实例方法可用性（对应 std::numeric_limits<T>::min()/infinity()）」的提示——`FloatingPoint<T>` 接口本身**不提供任何实例方法**（见 `cangjie-std/math/README.md` 第 117 行仅作为类型约束声明），下游如需 `std::numeric_limits<T>::min()`/`infinity()` 等价物应通过类型分派 `Float32.Min`/`Float32.Inf`/`Float64.Min`/`Float64.Inf` 静态常量获取，详见验证项 16/18
14. **Quat 字段 `public var` 可见性验证（v4 新增）**：确认 `@Derive[Hashable]` 派生宏在 Quat 字段标注 `public var` 时编译通过；若字段标注缺失 `public`，验证派生失败报可见性错误
15. **`pow` 函数四元数版本与 `std.math.pow` 实数版本命名消歧验证（v5 新增，v7 Float64 转换依赖补充）**：验证 `pow(x: Quat<T,Q>, y: T)` 函数体内部调用 `std.math.pow(x.w, y)` 实数版本时，类型推断正确（参数类型为 `T`/`T`），不与四元数 `pow` 自身签名混淆；确认 `std.math.pow` 对 `Float32`/`Float64` 的可用性，若不存在则需以 `exp(y * log(x.w))` 替代实现（v7 补充：因 std.math 的 pow/log/exp 签名仅支持 Float64，`pow(Quat<Float32, Q>, Float32)` 路径需先显式转换至 Float64 再降级，fallback `exp(y * log(x.w))` 同步需 Float64 转换）
16. **`pow` 函数次正规数边界检查所需 `FloatingPoint<T>.getMinDenormal()` 静态方法路径验证（v5 新增，v7 接口名修订，**v11 关键修订，Issue 8 响应：v10「原 `FloatingPoint<T>.getMin()` 方法验证目标不存在」错误**）**：依据 `cangjie-original-docs/std/math/math_package_api/math_package_interfaces.md` 第 49-60 行定义，仓颉 stdlib **实际提供** `FloatingPoint<T>.getMinDenormal()` 静态方法用于获取最小次正规数；下游实现 `pow` 函数体内部次正规数边界检查时，应直接调用 `FloatingPoint<T>.getMinDenormal()`（推荐路径），或 fallback 到类型分派 `if (q.x is Float32) { Float32.Min } else { Float64.Min }` 路径，或字面量 fallback 路径（如 `T(1) / T(很大值)`）。验证项应验证「`FloatingPoint<T>.getMinDenormal()` 静态方法 + 类型分派 + 字面量 fallback 三条路径的编译可行性」
17. **`type_quat_cast` 函数 `FloatingPoint<T>` 约束可用性验证（v5 新增，v7 接口名修订）**：验证 `where T <: FloatingPoint<T>` 约束（stdlib 原生接口）在 `mat3Cast`/`mat4Cast`/`quatCast` 4 个函数签名上的编译可行性；实例化 `Quat<Float32, PackedHighp>` 调用转换函数通过编译；实例化 `Quat<Int64, PackedHighp>` 调用转换函数报类型不匹配错误（与 GLM `GLM_STATIC_ASSERT(is_iec559, ...)` 等价行为）
18. **`log` 函数 `FloatingPoint<T>.getInf()` 静态方法路径验证（v5 新增，v7 接口名修订，**v11 关键修订，Issue 8 响应：v10「原 `FloatingPoint<T>.getInf()` 方法验证目标不存在」错误**）**：依据 `cangjie-original-docs/std/math/math_package_api/math_package_interfaces.md` 第 37-48 行定义，仓颉 stdlib **实际提供** `FloatingPoint<T>.getInf()` 静态方法用于获取正无穷；下游实现 `log` 函数体内部 w=0 退化分支时，应直接调用 `FloatingPoint<T>.getInf()`（推荐路径），或 fallback 到类型分派 `if (q.x is Float32) { Float32.Inf } else { Float64.Inf }` 路径，或字面量 fallback 路径 `T(1)/T(0)`（仅对浮点类型有效，整数类型 `1/0` 触发除零异常，与 GLM 行为一致）。验证项应验证「`FloatingPoint<T>.getInf()` 静态方法 + 类型分派 + 字面量 fallback 三条路径的编译可行性」
19. **`epsilon<T>()` 与 `epsilonOf<T>(hint)` 返回值一致性验证（v10 新增，Issue 4 响应）**：阶段二 `cjglm/src/detail/shim_limits.cj:25` 已有 `public func epsilonOf<T>(hint: T): T where T <: Number<T>` 函数，本设计新增的 `epsilon<T>()` 函数与其功能等价。验证项需验证：在 `T = Float32` 实例化时，`epsilon<Float32>()` 与 `epsilonOf<Float32>(0.0f)` 返回值相等（`Float32(1.1920929e-7)`）；在 `T = Float64` 实例化时，`epsilon<Float64>()` 与 `epsilonOf<Float64>(0.0)` 返回值相等（`Float64(2.220446049250313e-16)`）；在 `T = Int64` 实例化时两者均返回 `Int64(0)`（`hint - hint` 形式）；阶段二测试 `tests/glm/detail/test_shim_limits.cj` 中硬编码的精度值作为 ground truth 验证依据
20. **`FloatingPoint<T>` 接口方法可用性验证（v11 关键修订，Issue 8 响应，**v14 补充质询报告核查声明**）**：依据 `cangjie-original-docs/std/math/math_package_api/math_package_interfaces.md` 第 5-17 行定义，验证 `FloatingPoint<T>` 接口实际提供 6 个静态方法（`getE`/`getInf`/`getPI`/`getMinDenormal`/`getMinNormal`/`getNaN`）+ 3 个实例方法（`isInf`/`isNaN`/`isNormal`）。v10 描述「`FloatingPoint<T>` 接口本身无任何实例方法」错误——下游实现 `pow` 次正规数边界检查时应直接调用 `FloatingPoint<T>.getMinDenormal()` 而非类型分派；实现 `log` w=0 退化分支时应直接调用 `FloatingPoint<T>.getInf()` 而非类型分派；实现 `isnan`/`isinf` 约束时该 where 子句确保 T 类型实现 `isNaN()`/`isInf()` 实例方法。**v14 质询报告核查声明**：本验证项引用的 `FloatingPoint<T>` 接口方法清单基于 `cangjie-original-docs/std/math/math_package_api/math_package_interfaces.md` 编写，v13 中对该文档的引用内容未纳入本轮 v14 审查范围的独立复核——下游编码者在实际调用 `FloatingPoint<T>.getMinDenormal()`/`getInf()` 等方法前应以仓颉编译器实际签名确认
21. **`std.math` Float32 重载可用性验证（v11 关键修订，Issue 7 响应）**：依据 `cangjie-original-docs/std/math/math_package_api/math_package_funcs.md` 全文检索，验证 `std.math` 三角函数（`sin`/`cos`/`tan`/`asin`/`acos`/`atan`/`sinh`/`cosh`/`tanh`/`asinh`/`acosh`/`atanh`/`atan2`/`sqrt`/`exp`/`log`）均提供 Float16/Float32/Float64 三种重载，`std.math.pow` 提供 Float32/Float64 共 4 个重载。T=Float32 实例化时调用 `std.math.sin(x)`/`std.math.cos(x)`/`std.math.pow(x, y)` 等函数**直接返回 Float32**，无需 `T(Float64.xxx(Float64(value)))` 显式转换。`radians`/`degrees` 是例外（stdlib 不存在这两个函数）
22. **`trigonometric.cj` T 约束验证（v11 关键修订，Issue 1 响应）**：验证 §3.13.1 所有 75 个展开函数签名（含 14 标量 + 56 向量 + 1 标量 `atan2` + 4 向量 `atan2`）均标注 `where T <: FloatingPoint<T>`；实例化 `trigonometric.sin<Float32, PackedHighp>(1.0f)` 通过编译；实例化 `trigonometric.sin<Int64, PackedHighp>(1)` 报类型不匹配错误
23. **`fwd.cj` 自动生成脚本验证（v12 关键修订，Issue 2 响应，**v13 关键修订脚本位置，Issue 3 响应**）**：验证 `cjglm/scripts/gen_fwd_aliases.py` 生成脚本（**v13 修订**：v12 描述查阅 `cjglm/tools/` 目录——`cjglm/` 下不存在 `tools/` 目录，实际生成脚本为 Python 64 行位于 `scripts/`）是否能正确生成 9 个四元数 type alias——具体步骤：(a) 查阅 `cjglm/scripts/gen_fwd_aliases.py` 确认生成脚本存在（**v13 修订**：v12 描述查阅 `cjglm/tools/` 修订为 `cjglm/scripts/`）；(b) 在脚本的 `VEC_FAMILIES` 字典中新增 `Quat`/`FQuat`/`DQuat` 三个家族前缀条目（如 `Quat`/`FQuat` 映射到 `Float32`，`DQuat` 映射到 `Float64`），并新增针对 Quat 家族固定 4 维（无 Vec1/Vec2/Vec3 变体）的特殊处理分支——因 Quat 仅支持 4 维而现有脚本按 `DIMS = [1, 2, 3, 4]` 全维度循环生成 Vec 别名，简单新增 `VEC_FAMILIES` 条目会生成 `Quat1`/`Quat2`/`Quat3` 三个不存在项；(c) 运行脚本 `python cjglm/scripts/gen_fwd_aliases.py` 生成新的 `fwd.cj` 后再提交；(d) 验证生成的 `fwd.cj` 包含全部 9 个 type alias 且与 §3.14 清单一致；(e) 验证脚本支持幂等运行（多次执行结果一致）
24. **`conjugate` const func 编译可行性验证（v12 关键修订，Issue 7 响应）**：验证 `conjugate` 函数声明为 `const func` 后能在 const 上下文正确编译——具体步骤：(a) 实现 `public const func conjugate<T, Q>(q: Quat<T, Q>): Quat<T, Q> where T <: Number<T>, Q <: Qualifier { Quat<T, Q>(-q.x, -q.y, -q.z, q.w) }`；(b) 在 `const` 上下文（如 `const val q_conj = conjugate(q)` 或 `const init` 块内）调用 `conjugate(q)` 验证编译通过；(c) 参照阶段一 `type_vec3.cj:54-80` 中 27 个 const func + 阶段二矩阵 `negative` const func 实践，确保与既有 const func 实现模式一致
25. **`T(Float64(n))` 字面量转换路径编译可行性验证（v15 新增，Issue 2 响应）**：验证 `T(Float64(n))` 语法对全部受影响的类型变体编译通过——(a) 实例化 `Float32(Float64(0))`/`Float32(Float64(1))`/`Float32(Float64(2))` 通过编译；(b) 实例化 `Float64(Float64(0))`/`Float64(Float64(1))`/`Float64(Float64(2))` 通过编译；(c) 实例化 `Int8(Float64(0))`/`Int16(Float64(0))`/`Int32(Float64(0))`/`Int64(Float64(0))` 通过编译；(d) 实例化 `Int8(Float64(1))`/`Int16(Float64(1))`/`Int32(Float64(1))`/`Int64(Float64(1))` 通过编译；(e) 若 (a)-(d) 任意一步编译失败，则依赖此路径的全部函数（normalize/axis/mat3Cast/mat4Cast/Quat×Vec3/Quat×Vec4）的实现假设被证伪，需重新评估 §1「常量型 T(n) 字面量替代」策略
26. **Mat4x4 `[]` 运算符返回类型为可赋值引用验证（v15 新增，Issue 3 响应）**：验证 `Mat4x4<T,Q>` 的 `[]` 索引运算符返回类型为可赋值引用（`&Vec4<T,Q>` 或 `mut Vec4<T,Q>`），确保 `mat3Cast`/`mat4Cast` 逐元素填充模式中 `result.col0 = Vec4<T,Q>(...)` 赋值路径编译通过——(a) 查阅阶段二 `type_mat4x4.cj` 中 `[]` 运算符签名，确认返回 `&Vec4<T,Q>`（可赋值引用）或返回 `Vec4<T,Q>`（值类型，不可赋值）；(b) 若返回为值类型（不可赋值），则 `mat3Cast`/`mat4Cast` 需退化为通过 `Mat4x4<T,Q>(col0, col1, col2, col3)` 主构造函数构造，不依赖 `[]` 赋值路径
27. **Mat4x4 列字段名 `c0`/`c1`/`c2`/`c3` 存在性验证（v15 新增，Issue 4 响应）**：验证 `Mat4x4<T,Q>` 的列字段命名为 `c0`/`c1`/`c2`/`c3`（而非 `col0`/`col1`/`col2`/`col3` 或其他命名），确保 §3.3 item 7 `fromMat4` 手动提取策略中 `m.c0`/`m.c1`/`m.c2` 编译通过——(a) 查阅阶段二 `type_mat4x4.cj` 确认列字段的实际命名；(b) 若实际命名与设计假设不一致，更新 §3.3 item 7 描述中的字段名引用；(c) 验证 `Vec3<T,Q>(m.c0.x, m.c0.y, m.c0.z)` 表达式 `T` 类型推断正确
28. **Vec4 双参数构造函数 `Vec4<T,Q>(Vec3<T,Q>, T)` 在所有 6 个 Qualifier 变体上编译可行性验证（v15 新增，Issue 6 响应）**：验证 `Vec4<T,Q>(Vec3<T,Q>, T)` 双参数构造函数签名在全部 6 个 Qualifier 变体上均编译通过——(a) 实例化 `Vec4<Float32, PackedHighp>(Vec3<Float32, PackedHighp>(1.0f, 2.0f, 3.0f), 4.0f)` 通过编译；(b) 重复 (a) 对其他 5 个 Qualifier（PackedMediump/PackedLowp/AlignedHighp/AlignedMediump/AlignedLowp）分别验证；(c) 若任意 Qualifier 变体编译失败，则 `Quat×Vec4` 运算符（§3.4 行 `Vec4(q * Vec3(v), v.w)` 公式）在该精度变体上不可用，需在 §11.5 中标注 Qualifier 限制

#### 高优先级编译前验证项（v12 新增，Issue 6 响应；**v13 关键修订，Issue 4 响应：移除与验证项 20/25 的重复内容，改为引用**）

以下两项为基础性编译假设的验证项，必须在编码阶段开始前优先完成（P0 优先级，5 日内必须完成）。**v13 修订**：v12 将验证项 20/25 的内容在「高优先级」段落中完整重述为 29/30，造成内容重复（全部 30 项中仅有 28 项独立）。本轮将 29/30 移除，改为直接引用验证项 20 与 25：

- **验证项 20（P0）**：`FloatingPoint<T>` 接口方法可用性验证——要求在编码阶段前先编写最小仓颉测试文件（~20 行），实例化 `FloatingPoint<Float32>.getMinDenormal()`/`getInf()`/`isInf()`/`isNaN()`/`getNaN()`/`getMinNormal()`，确认编译通过。验证结果反馈到 §3.10/§3.11 的依赖描述中更新。若编译失败，则 §3.10 `log` 函数中 `FloatingPoint<T>.getInf()` 路径和 §3.10 `pow` 函数中 `FloatingPoint<T>.getMinDenormal()` 路径的实现假设被证伪，需回退至类型分派 fallback 路径。

- **验证项 25（P0）**：`T(Float64(n))` 字面量转换路径编译可行性验证——要求在编码阶段前先编写最小仓颉测试文件（~20 行），实例化 `Float32(Float64(0))`/`Float32(Float64(1))`/`Float64(Float64(0))`/`Float64(Float64(1))`/`Int32(Float64(0))`/`Int64(Float64(1))`，确认编译通过。若编译失败，则 §1「常量型 T(n) 字面量替代」策略被证伪，依赖此路径的全部函数（normalize/axis/mat3Cast/mat4Cast/Quat×Vec3/Quat×Vec4）需重新评估零值/单位值获取策略。

### 8.3 Stage 3 Acceptance Criteria（v11 新增，Issue 13 响应）

本节汇总阶段三完成验收的全部依据，整合 §8/§8.2/§10/§11.5 等分散于多处的内容：

**A. 产出物清单验收（来源：§8 产出物清单）。v16 修订，Issue 2 响应：分类名称已统一对齐 §11.5 三档体系**：

| 类型 | 验收项 | 数量 | 验收依据 |
|------|--------|------|---------|
| ✅ 可用（无 stub 依赖） | `detail/type_quat.cj` + `detail/type_quat_cast.cj` + `detail/scalar_constants.cj` + `detail/scalar_quat_ops.cj` + `ext/quaternion_relational.cj`（4 函数）+ `ext/quaternion_geometric.cj`（4 函数）+ `ext/scalar_constants.cj` + `gtc/constants.cj`（28 函数）+ 4 个 ext/ 别名文件 | 11+ 个源文件（21 函数 ✅ 可用） | 文件存在 + `cjpm build` + 运行时无 Exception("stub") |
| ⚠️/❌ 混合（部分 ✅ 可用、部分 ❌ stub） | `ext/vector_relational.cj`（epsilon 16 重载 ✅ + ULP 8 重载 ❌）+ `ext/quaternion_common.cj`（5 ✅ + 3 ❌）+ `ext/quaternion_trigonometric.cj`（1 ✅ + 2 ❌）+ `ext/quaternion_transform.cj`（1 ❌）+ `ext/quaternion_exponential.cj`（4 ❌）+ `gtc/quaternion.cj`（8 ✅ 含 4 重导出 + 4 完整 + 7 ❌） | 6 个源文件 | 文件存在 + `cjpm build` 通过；✅ 部分运行时正常调用，❌ 部分抛 Exception("stub") |
| ❌ stub（空桩占位） | `gtc/matrix_transform.cj`（64 ❌）+ `detail/trigonometric.cj`（75 ❌）+ `ext/matrix_projection.cj` + `ext/matrix_clip_space.cj` + `ext/matrix_transform.cj` | 5 个源文件 | 文件存在 + `cjpm build` 通过；运行时均抛 Exception("stub") |
| 沿用 stub 文件 | `detail/common.cj` + `detail/geometric.cj` + `detail/matrix.cj`（27 实现 + 6 stub） | 3 个源文件 | 阶段二已验证 |
| 更新文件 | `fwd.cj`（9 个四元数别名）+ `lib.cj`（20 个 public import 声明） | 2 个更新文件 | 别名与 import 清单匹配 §2 |

**B. 测试设计验收（来源：§8.2 测试设计）**

| 验收项 | 数量 | 验收依据 |
|--------|------|---------|
| 测试文件总数 | 13 个 | 路径符合「测试目录结构对齐策略（v10 修订）」：ext 子模块测试 `tests/glm/test_ext_xxx.cj` 同层平铺命名 + gtc 测试 `tests/glm/gtc/test_xxx.cj` |
| 测试用例总数 | ≥199 | 40+8+8+12+16+8+4+2+16+13+9+28+27+8 = 199（v12 重算：scalar_constants ≥7→≥13 增量 6 + quaternion_aliases ≥4→≥9 增量 5 + matrix_transform_stubs 新增 ≥8） |
| 跨 Qualifier 实例化测试 | 6 种精度 | `test_type_quat.cj` 覆盖 PackedHighp/PackedMediump/PackedLowp/AlignedHighp/AlignedMediump/AlignedLowp |
| 跨类型实例化测试 | Float32/Float64 | 阶段三完整测试；Int64 仅测试非依赖 stub 的运算符 |

**C. 覆盖矩阵验收（来源：§10 GLM 1.0.3 API 阶段覆盖矩阵）。v16 修订，Issue 2 响应：「本阶段实现」列已统一使用三档分类**：

GLM 1.0.3 各头文件阶段三覆盖状态汇总：

| GLM 头文件 | 函数总数 | ✅ 可用 | ⚠️/❌ stub | 阶段四补齐 |
|----------|---------|----------|----------|----------|
| `detail/type_quat.hpp` | 19 个 API（结构体 + 运算符 + 工厂） | 16 个 ✅（不含 fromVec3/fromEuler ❌ + Quat×Vec3/Vec4 ⚠️） | 1 个 ⚠️（Quat×Vec3/Vec4）+ 2 个 ❌（fromVec3/fromEuler） | — |
| `detail/type_quat_cast.hpp`（v3 新增） | 4 个 | 4 个 ✅ | 0 | — |
| `ext/vector_relational.hpp` | 8 个 | 4 个 epsilon 版本 ✅（16 重载） | 4 个 ULP 版本 ❌（8 重载） | ULP 版本需评估仓颉位级访问能力 |
| `ext/quaternion_relational.hpp` | 4 个 | 4 个 ✅ | 0 | — |
| `ext/quaternion_geometric.hpp` | 4 个 | 4 个 ✅ | 0 | — |
| `ext/quaternion_common.hpp` | 8 个 | 5 个 ✅（conjugate/inverse/lerp/isnan/isinf） | 3 个 ❌（mix/slerp(2)） | mix/slerp 完整实现 |
| `ext/quaternion_trigonometric.hpp` | 3 个 | 1 个 ✅（axis） | 2 个 ❌（angle/angleAxis） | angle/angleAxis 完整实现 |
| `ext/quaternion_transform.hpp` | 1 个 | 0 | 1 个 ❌（rotate） | rotate 完整实现 |
| `ext/quaternion_exponential.hpp` | 4 个 | 0 | 4 个 ❌（exp/log/pow/sqrt） | 全部完整实现 |
| `ext/scalar_constants.hpp` | 3 个 | 3 个 ✅ | 0 | — |
| `gtc/constants.hpp` | 28 个 | 28 个 ✅ | 0 | — |
| `gtc/matrix_transform.hpp` | **64** | 0 | **64** ❌ | 完整实现（阶段四） |
| `gtc/quaternion.hpp` | 15 个 | 8 个 ✅（4 重导出 + 4 完整） | 7 个 ❌（4 欧拉 + 3 看向） | 7 个 stub 完整实现 |
| **合计** | — | **约 77 个 ✅** | **约 80 个 ❌/⚠️**（含 1 ⚠️ + 79 ❌） | — |

**D. 函数可用性对照表验收（来源：§11.5）**

`§11.5 函数可用性对照表` 是阶段三验证的**权威基准**：✅/⚠️/❌ 三档符号标记每个函数本阶段状态（实现在本文件其他章节有详细描述）。下游验证时按 §11.5 表逐项核验即可。

**E. 验证项清单（来源：§8 编码启动前验证项 1-28）**

阶段三编码启动前需完成 §8 编码启动前验证项 1-28 全部 28 项验证（**v13 关键修订，Issue 4 响应**：v12 声明的验证项 29/30 与 20/25 内容重复，本轮移除后独立验证目标为 28 项——原「30 项」修正为「28 项」），其中验证项 20 与 25 兼为高优先级编译前验证项（P0）。确保：
- cjpm 构建系统接受 `src/gtc/` + `package glm.gtc` 子包结构
- `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 重导出机制可行
- 包间无循环依赖（`glm.gtc → glm.detail` 单向）
- `@Derive[Hashable]` 对 `Q <: Qualifier` 派生可行
- `length`/`normalize`/`isnan`/`isinf`/`mat3Cast` 等 T 类型约束编译期生效
- `epsilon<T>()` 与 `epsilonOf<T>(hint)` 返回值一致
- `FloatingPoint<T>` 接口方法实际可用（v11 新增）
- `std.math` Float32 重载实际可用（v11 新增）
- `trigonometric.cj` 75 个展开函数签名 T 约束编译期生效（v11 新增）

**F. 文档-代码一致性验收**

下游实现完成后需逐项核验：
- `fwd.cj` 9 个四元数别名（Quat/FQuat/DQuat + 3×Float32 精度 + 3×Float64 精度）与 §2 lib.cj/fwd.cj 段落一致
- `lib.cj` 20 个 import 声明与 §2 lib.cj import 清单一致
- 各函数签名 where 子句与 §3 / §10 / §11.5 约束标注一致
- 边界行为实现与 §5.3 边界条件表 + §5.1 通用异常表一致（特别是 normalize 零四元数保护、inverse 整数除零异常）

**G. 整体设计可追溯性验收**

GLM 1.0.3 → 仓颉阶段三设计的可追溯矩阵：§10「GLM 1.0.3 API 阶段覆盖矩阵」列出全部 12 个 GLM 头文件 + 本设计 11 个核心章节的映射关系；下游编码者按 §10 表逐项核验可定位每个 GLM 函数在仓颉设计中的对应位置。

---

## 9. 对齐 GLM 参考实现的差异声明

| 差异 | 说明 |
|------|------|
| **无匿名 union / GLM_FORCE_QUAT_DATA_WXYZ** | 四元数仅支持 xyzw 存储+参数顺序布局，不支持 wxyz 存储布局变体 |
| **构造函数参数顺序 (x,y,z,w) 非 (w,x,y,z)** | 仓颉侧主构造函数参数顺序与数据成员声明顺序一致，通过 `wxyz()` 工厂函数提供 GLM 习惯入口 |
| **无 C++ 显式类型转换运算符** | 仓颉不支持 `operator mat3x3()`/`operator mat4x4()` 隐式/显式类型转换运算符。矩阵-四元数互转通过 `mat3Cast`/`mat4Cast`/`quatCast` 显式函数实现 |
| **ULP 比较函数无法实现** | 仓颉无浮点位表示直接访问（无 `reinterpret_cast`/`union`），ULP 比较以空桩占位 |
| **GLM 中不存在 `lookRotate` 函数** | GLM 1.0.3 中与"看向"语义对应的函数是 `gtc/quaternion.hpp` 中的 `quatLookAt`/`quatLookAtRH`/`quatLookAtLH` |
| **从两向量构造改为具名工厂函数** | C++ GLM 中 `qua(vec3, vec3)` 为构造函数，仓颉版本改为 `Quat.fromVec3(u, v)` 工厂函数（因依赖 geometric.cj stub，阶段三为 stub 占位） |
| **从欧拉角构造改为具名工厂函数** | C++ GLM 中 `qua(vec3 eulerAngles)` 为构造函数，仓颉改为 `Quat.fromEuler(eulerAngles)`（依赖 trigonometric.cj stub，阶段三为 stub 占位） |
| **从旋转矩阵构造改为具名工厂函数** | C++ GLM 中 `qua(mat3x3)`/`qua(mat4x4)` 为构造函数，仓颉改为 `Quat.fromMat3`/`Quat.fromMat4`（**v3 修订**：调用**同包** `type_quat_cast.cj` 函数，不再跨包引用 gtc） |
| **`gtc/quaternion.cj` 独立承载 15 函数（v3 明确：4 重导出 + 4 完整 + 7 stub）** | 与 GLM `gtc/quaternion.hpp` 1:1 映射；**v3 关键变更**：`mat3Cast`/`mat4Cast`/`quatCast` 不在本文件实现，而是通过 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 重导出 detail 中的实现，**v12 关键修订**：重导出函数采用 camelCase 命名（与 detail 端原始名一致），而非 GLM 原始 snake_case `mat3_cast`/`mat4_cast`/`quat_cast` |
| **`mat3Cast`/`mat4Cast`/`quatCast` 实际实现位于 `detail/type_quat_cast.cj`（v3 关键决策，v12 修订：camelCase 命名）** | 为避免包间循环依赖，转换函数下沉至 detail 包；gtc 包通过 `public import` 重导出至 gtc 命名空间；**v12 关键修订，Issue 1 响应**：detail 端与 gtc 端函数名统一为 camelCase `mat3Cast`/`mat4Cast`/`quatCast`，下游按 GLM 习惯使用 snake_case `mat3_cast`/`mat4_cast`/`quat_cast` 时将编译失败——仓颉 `public import a.b.f` 仅重导出 f 原始名（依据 `cangjie-lang-features/package/README.md` 第 156-166 行规范），不做命名转换；与现有 `public import glm.detail.{transpose, matrixCompMult, outerProduct}` 模式（`cjglm/src/lib.cj:8`）保持 camelCase 风格一致 |
| **一元 + 运算符不可用** | 仓颉不支持重载一元 + 运算符（与 deviations.md IF-01 一致） |
| **标量-四元数运算为全局函数** | 仓颉 operator func 限制 |
| **quaternion_common 中 mix/slerp 依赖 trigonometric.cj/common.cj stub** | 本阶段 mix/slerp 为 stub 占位，待阶段四 trigonometric.cj/common.cj 完整实现后补齐 |
| **`mix`/`slerp`/`pow` 依赖 `epsilon<T>()`（v3 明确）** | GLM 实现中用于 `cosTheta > 1 - epsilon<T>()` 退化检测，与 GLM 实际依赖一致 |
| **ext/vector_relational 内联 abs 而非调用 common.cj** | 消除对 stub 的运行时依赖，确保本阶段函数可执行 |
| **向量 `equal` 采用严格 `<` 语义（v3 修订，v9 修订 GLM 文件引用）** | 与 GLM `glm/gtc/epsilon.inl:32-41` 中 `epsilonEqual` 实现一致，`equal(v, v, 0.0) = false`。原引用 `func_vector_relational.inl:18-22` 错误——GLM 1.0.3 的 `func_vector_relational.inl` 中**不包含 epsilon 版本**的 `equal`/`notEqual`，epsilon 版本位于 `glm/gtc/epsilon.inl`（文件层面属 gtc 子包） |
| **scalar_constants 使用 hint 参数辅助类型推断** | 与 deviations.md DV-04 一致 |
| **scalar_constants 对整型 T 抛运行时异常（v3 明确）** | 与 GLM `static_assert(is_iec559, ...)` 编译期断言等价行为 |
| **`Quat×Vec3` 旋转公式采用两次 Vec3 叉乘（v3 修订）** | 与 GLM `type_quat.inl:359-366` 一致：`v + (cross(QuatVector, v) * q.w + cross(QuatVector, cross(QuatVector, v))) * 2` |
| **`slerp` 4 参数版本 `k: Int64` 简化签名（v3 决策）** | 与 deviations.md DV-03「移位运算右操作数固定为 Int64」风格一致，牺牲泛型灵活性换取签名简洁性 |
| **`lerp` 含 `assert(a >= 0 && a <= 1)` 断言（v3 明确）** | 与 GLM `ext/quaternion_common.inl:28-38` 一致；`lerp` 不可在 const 上下文调用 |
| **四元数算术运算符统一标注 @OverflowWrapping** | 与阶段一 Vec3、阶段二全部矩阵类型的实践一致；标注对浮点无效果但保持跨类型一致性 |
| **fwd.cj 排除整型与 Bool 四元数别名（v3 明确）** | 与阶段二排除整型矩阵别名的策略一致；Bool 四元数无实际用途（D17） |
| **`Quat`/`FQuat`/`DQuat` 三重别名机制（v3 新增，v8 修订先例引用）** | **v8 修订**：v7 文档引用阶段二 `Mat2x2`/`FMat2x2` 双别名机制作为先例，但通过直接查阅 `cjglm/src/fwd.cj` 全文确认 `Mat` 家族**不存在** `FMat*` 任何声明（仅 `Mat2x2` + `DMat2x2`），`F` 前缀别名**仅在 Vec 家族存在**（`FVec1`~`FVec4` + 精度变体）。本设计修订为参考阶段一 Vec 家族的三重模式（`Vec2` + `DVec2` + `FVec2`，见 `cjglm/src/fwd.cj:106, 123, 276`），与 `Quat` + `DQuat` + `FQuat` 三重别名机制对齐 |
| **ext/ 和 gtc/ 子包独立声明** | 仓颉包名与目录路径匹配规则约束 |
| **gtc/matrix_transform.cj 本阶段以空桩占位** | 其完整实现依赖链覆盖几乎所有函数库层，归入阶段四 |
| **`fromMat3`/`fromMat4` 仅对纯旋转矩阵有效（v3 契约）** | 与 GLM 行为一致；对非旋转矩阵行为未定义，结果可能产生非单位四元数 |
| **`axis` 触发条件为 `1 - w² <= 0` 而非 q.xyz == 0（v5 修订）** | 返回 `Vec3(T(0), T(0), T(1))`（z 轴单位向量，典型场景：单位四元数 `(0, 0, 0, 1)` 即 `\|w\| >= 1`）；对于真正零四元数 `(0, 0, 0, 0)`，`tmp1 = 1 > 0` 进入 else 分支返回 `Vec3(0, 0, 0)`（与 GLM `ext/quaternion_trigonometric.inl:20-27` 一致）。**v3 原描述「内部 `normalize(Vec3(0, 0, 0))` 返回 `Vec3(1, 0, 0)`」为虚构实现，GLM 源码不调用 `normalize`**，v5 修订纠正 |
| **浮点/整数四元数 `inverse` 零除行为差异（v3 契约）** | 浮点产生 Inf/NaN，整数触发仓颉除零异常 |
| **包间依赖方向严格单向 `glm.gtc → glm.detail`（v3 关键修复）** | 为避免 v2 设计的 `glm.detail ↔ glm.gtc` 循环依赖（违反仓颉包间循环依赖约束），D11/D28 决策将转换函数下沉至 detail |
| **`isnan`/`isinf` 函数约束收紧为 `where T <: FloatingPoint<T>`（v4 新增，v7 接口名修订）** | 与 §3.12 `epsilon<T>()` 约束收紧策略一致；避免整数 T（如 `Int64`）实例化时 `Int64.isNaN()` 实例方法不存在导致编译失败的问题。`FloatingPoint<T>` 是 stdlib 原生接口，编译期保证可用，无需 fallback |
| **Quat 字段统一标注 `public var`（v4 新增）** | 满足 `@Derive[Hashable]` 派生宏对字段 public 可见性的要求（依据 `cangjie-std/deriving/README.md` 第 4 节）；与阶段一 Vec3、阶段二全部矩阵类型（200+ 处统一实践）对齐。仓颉 struct 字段默认 `internal` 可见性，不满足 public 派生要求 |

---

## 10. GLM 1.0.3 API 阶段覆盖矩阵

**v16 修订，Issue 2 响应**：本矩阵「覆盖状态」列统一使用与 §11.5 对齐的三档分类：✅ 可用（无 stub 依赖）、⚠️ 抛 stub 异常、❌ stub。函数可用状态以 §11.5 为最终基准。

### glm/detail/type_quat.hpp（quaternion type definition）

| 函数/类型 | 覆盖状态 | 对应设计方案章节 |
|----------|---------|----------------|
| Quat<T,Q> 结构体定义 | ✅ 可用 | §3.1 |
| `[]` 下标运算符 | ✅ 可用 | §3.1 |
| const init(x,y,z,w) 逐分量构造 | ✅ 可用 | §3.3 item 1 |
| init(s, Vec3) 标量+向量构造 | ✅ 可用 | §3.3 item 2 |
| init< Q2>(Quat<T,Q2>) 跨 Qualifier | ✅ 可用 | §3.3 item 3 |
| fromQuat(conv, q) 跨类型构造 | ✅ 可用 | §3.3 item 4 |
| identity(one) 单位四元数 | ✅ 可用 | §3.3 item 5 |
| fromMat3(m) 矩阵构造 | ✅ 可用 | §3.3 item 6 |
| fromMat4(m) 矩阵构造 | ✅ 可用 | §3.3 item 7 |
| fromVec3(u, v) 向量构造 | ❌ stub | §3.3 item 8 |
| fromEuler(eulerAngles) 欧拉角构造 | ❌ stub | §3.3 item 9 |
| wxyz(w,x,y,z) 工厂函数 | ✅ 可用 | §3.3 item 10 |
| 一元 - 运算符 | ✅ 可用 | §3.4 |
| 二元 + - * 运算符 | ✅ 可用 | §3.4 |
| Quat×Vec3/Vec4 | ⚠️ 抛 stub 异常（编译通过，运行时依赖 geometric.cj 向量 cross stub） | §3.4 |
| Vec3×Quat/Vec4×Quat | ✅ 可用（通过 inverse 路径，无 stub 依赖） | §3.4 |
| Quat×T / T×Quat / Quat/T | ✅ 可用 | §3.4 |
| == / != 比较 | ✅ 可用 | §3.4 |

### glm/detail/type_quat_cast.hpp（v3 新增，v5 明确签名规范）

| 函数 | 覆盖状态 | 对应设计方案章节 |
|------|---------|----------------|
| `mat3Cast<T, Q>(q: Quat<T, Q>): Mat3x3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | ✅ 可用 | §3.2 / §3.2.1 |
| `mat4Cast<T, Q>(q: Quat<T, Q>): Mat4x4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | ✅ 可用 | §3.2 / §3.2.1 |
| `quatCast<T, Q>(m: Mat3x3<T, Q>): Quat<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | ✅ 可用 | §3.2 / §3.2.1 |
| `quatCast<T, Q>(m: Mat4x4<T, Q>): Quat<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier` | ✅ 可用 | §3.2 / §3.2.1 |

### glm/ext/vector_relational.hpp

| 函数 | 覆盖状态 |
|------|---------|
| equal(VecN, VecN, T epsilon) | ✅ 可用（16 重载，严格小于语义） |
| equal(VecN, VecN, VecN epsilon) | ✅ 可用（16 重载，严格小于语义） |
| notEqual(VecN, VecN, T epsilon) | ✅ 可用（16 重载） |
| notEqual(VecN, VecN, VecN epsilon) | ✅ 可用（16 重载） |
| equal/notEqual (ULP 版本) | ❌ stub |

### glm/ext/quaternion_relational.hpp

| 函数 | 覆盖状态 |
|------|---------|
| equal(Quat, Quat) | ✅ 可用 |
| equal(Quat, Quat, epsilon) | ✅ 可用 |
| notEqual(Quat, Quat) | ✅ 可用 |
| notEqual(Quat, Quat, epsilon) | ✅ 可用 |

### glm/ext/quaternion_geometric.hpp

| 函数 | 覆盖状态 |
|------|---------|
| dot(Quat, Quat) | ✅ 可用 |
| length(Quat) | ✅ 可用 |
| normalize(Quat) | ✅ 可用（**v11 修订，Issue 2 响应**：实现包含 GLM 零四元数保护分支 `if (tmp1 <= T(0)) return identity_q else return q / tmp1`，与 GLM `ext/quaternion_geometric.inl:17-24` 一致） |
| cross(Quat, Quat) | ✅ 可用 |

### glm/ext/quaternion_common.hpp

| 函数 | 覆盖状态 |
|------|---------|
| conjugate(Quat) | ✅ 可用（仅对 x/y/z 取反，w 保持不变：`Quat(-q.x, -q.y, -q.z, q.w)`；v5 修订语义，与 GLM `ext/quaternion_common.inl:112-116` `wxyz(q.w, -q.x, -q.y, -q.z)` 一致） |
| inverse(Quat) | ✅ 可用 |
| lerp(Quat, Quat, T) | ✅ 可用（含 assert + 非 const） |
| mix(Quat, Quat, T) | ❌ stub（依赖 dot/acos(T):T 单参数版本/sin(T):T 单参数版本/epsilon<T>()；v5 修订明确 trigonometric.cj 重载版本） |
| slerp(Quat, Quat, T) | ❌ stub（依赖 dot/acos(T):T 单参数版本/sin(T):T 单参数版本/mix 标量版 + epsilon<T>()） |
| slerp(Quat, Quat, T, Int64) | ❌ stub（依赖 dot/acos/sin/mix 标量版 + epsilon<T>() + pi<T>()；v5 修订补充 pi<T>() 与 mix 标量版依赖） |
| isnan(Quat) | ✅ 可用（实例方法路径，约束 `T <: FloatingPoint<T>`，v4 修订，v7 接口名修订） |
| isinf(Quat) | ✅ 可用（实例方法路径，约束 `T <: FloatingPoint<T>`，v4 修订，v7 接口名修订） |

### glm/ext/quaternion_trigonometric.hpp

| 函数 | 覆盖状态 |
|------|---------|
| axis(Quat) | ✅ 可用（`tmp1 = 1 - x.w*x.w` 公式路径；`tmp1 <= 0` 时返回 `Vec3(0, 0, 1)`，否则返回归一化 `Vec3(x.x*tmp2, x.y*tmp2, x.z*tmp2)`；v5 修订边界行为） |
| angle(Quat) | ❌ stub |
| angleAxis(T, Vec3) | ❌ stub |

### glm/ext/quaternion_transform.hpp

| 函数 | 覆盖状态 |
|------|---------|
| rotate(Quat, T, Vec3) | ❌ stub |

### glm/ext/quaternion_exponential.hpp

| 函数 | 覆盖状态 |
|------|---------|
| exp(Quat) | ❌ stub（依赖 length/epsilon<T>()/cos/sin；v5 修订补充 epsilon<T>() 依赖） |
| log(Quat) | ❌ stub（依赖 length/epsilon<T>()/pi<T>()/atan/log + `std::numeric_limits<T>::infinity()` 等价物；v5 修订补充） |
| pow(Quat, T) | ❌ stub（依赖 epsilon<T>()/abs/clamp/asin/acos/sin/cos/sqrt/cos_one_over_two<T>() + 递归调用 std.math.pow(T,T) + std::numeric_limits<T>::min() 次正规数边界；v5 修订补充依赖，行号引用 quaternion_exponential.inl:41-80） |
| sqrt(Quat) | ❌ stub |

### glm/ext/scalar_constants.hpp

| 函数 | 覆盖状态 |
|------|---------|
| epsilon<T>() | ✅ 可用（整型 T 抛运行时异常） |
| pi<T>() | ✅ 可用（整型 T 抛运行时异常） |
| cos_one_over_two<T>() | ✅ 可用（整型 T 抛运行时异常） |

### glm/gtc/constants.hpp

| 函数 | 覆盖状态 |
|------|---------|
| **28 个**常量函数（v8 修订：与 GLM 1.0.3 `gtc/constants.inl` 实际声明数一致） | ✅ 可用 |

### glm/gtc/matrix_transform.hpp

| 函数 | 函数数 | 覆盖状态 |
|------|--------|---------|
| 全部 **64** 个函数（**v13 关键修订，Issue 1+2 响应**：v12 描述「35 个」与 GLM 1.0.3 实际 `gtc/matrix_transform.hpp` 间接 include 的 `ext/matrix_transform.inl` 11 + `ext/matrix_clip_space.inl` 46 + `ext/matrix_projection.inl` 7 = **64** 个函数显著偏差 29 个遗漏 + 5 个虚构函数；具体清单见 §3.13 表格下「`gtc/matrix_transform.cj` 函数清单」段，按 6 大类分组：基础变换 11 + 视口与裁剪空间 19（ortho 系族 10 + frustum 系族 9）+ 透视投影 18（perspective 系族 9 + perspectiveFov 系族 9）+ 无穷远透视 9（infinitePerspective 系族 7 + tweakedInfinitePerspective 系族 2）+ 投影工具 6 + 拾取矩阵 1 = 64；`matrixCompMult` 已从清单中移除——实际定义于 `glm/detail/func_matrix.inl` 而非 gtc/matrix_transform） | **64** | ❌ stub（仅函数签名 + `throw Exception("stub")`），阶段四补齐完整实现 |

### glm/gtc/quaternion.hpp（v3 修订状态，v12 关键修订：snake_case→camelCase 命名）

| 函数 | 覆盖状态 | 备注 |
|------|---------|------|
| `mat3Cast(Quat)` | ✅ 可用 | **v3 修订**：从 detail/type_quat_cast.cj 重导出，**v12 关键修订，Issue 1 响应**：采用 camelCase 命名（与 detail 端 `mat3Cast` 一致），而非 GLM 原始 snake_case `mat3_cast`——`public import a.b.f` 仅重导出 f 原始名，不做命名转换 |
| `mat4Cast(Quat)` | ✅ 可用 | **v3 修订**：从 detail/type_quat_cast.cj 重导出，**v12 修订同上**：camelCase `mat4Cast` 而非 snake_case `mat4_cast` |
| `quatCast(Mat3)` | ✅ 可用 | **v3 修订**：从 detail/type_quat_cast.cj 重导出，**v12 修订同上**：camelCase `quatCast` 而非 snake_case `quat_cast` |
| `quatCast(Mat4)` | ✅ 可用 | **v3 修订**：从 detail/type_quat_cast.cj 重导出，**v12 修订同上**：camelCase `quatCast` 而非 snake_case `quat_cast` |
| lessThan(Quat, Quat) | ✅ 可用 | |
| lessThanEqual(Quat, Quat) | ✅ 可用 | |
| greaterThan(Quat, Quat) | ✅ 可用 | |
| greaterThanEqual(Quat, Quat) | ✅ 可用 | |
| eulerAngles(Quat) | ❌ stub | **v3 修订**：从误标"完整实现"修正为 stub（依赖 trigonometric.cj/common.cj stub） |
| roll(Quat) | ❌ stub | **v3 修订**：同上 |
| pitch(Quat) | ❌ stub | **v3 修订**：同上 |
| yaw(Quat) | ❌ stub | **v3 修订**：同上 |
| quatLookAt(Vec3, Vec3) | ❌ stub | |
| quatLookAtRH(Vec3, Vec3) | ❌ stub | |
| quatLookAtLH(Vec3, Vec3) | ❌ stub | |

---

## 11. 下游消费者迁移指南（v3 新增）

针对常见的库使用场景，提供仓颉版本与 GLM 习惯的迁移示例：

### 11.1 构造单位四元数

```
// GLM:        glm::quat q = glm::quat(1.0f, 0.0f, 0.0f, 0.0f);  // wxyz 顺序
// 仓颉:      let q = Quat<Float32, PackedHighp>.identity(1.0f)  // 主入口（推荐）
//           或 let q = Quat<Float32, PackedHighp>.wxyz(1.0f, 0.0f, 0.0f, 0.0f)  // wxyz 顺序入口
```

### 11.2 跨类型转换

```
// GLM:        glm::quat q32 = glm::quat(q64);
// 仓颉:      let q32 = Quat<Float32, PackedHighp>.fromQuat<Float64, PackedHighp>(
//               { f64 => Float32(f64) },
//               q64
//           )
// 同类型简化:
//           let q32_same = Quat<Float32, PackedHighp>(q32.x, q32.y, q32.z, q32.w)
```

### 11.3 旋转应用

```
// GLM:        auto rotated = q * v;
// 仓颉:      let rotated = q * v  // [本阶段抛 stub 异常，待阶段四 geometric.cj 完整实现后生效]
```

### 11.4 矩阵-四元数互转（v3 明确入口）

```
// GLM:        glm::mat3 m = glm::mat3_cast(q);  glm::quat q2 = glm::quat_cast(m);
// 仓颉 detail 入口（v3 新增，fromMat3/fromMat4 工厂函数内部使用）:
//           let m = Quat<Float32, PackedHighp>.fromMat3(m).identity(1.0f)  // 错误示例，fromMat3 是 Quat 工厂函数
//           let q2 = Quat<Float32, PackedHighp>.fromMat3(m)  // Mat3 → Quat
//           let m3 = Quat<Float32, PackedHighp>(1.0f, 0.0f, 0.0f, 0.0f).fromMat3(m)  // 错误示例
// 
// 仓颉 detail 直接调用（v3 推荐入口，需先 `import glm.detail.*`）:
//           let m3 = mat3Cast(q)      // detail/type_quat_cast.cj 包级函数（**v10 修订，Issue 17 响应**：需先 `import glm.detail.*` 才能调用包级函数；或通过 lib.cj 的 `public import` 重导出从顶层 `glm` 命名空间调用 `glm.mat3Cast(q)`）
//           let q2 = quatCast(m)      // detail/type_quat_cast.cj 包级函数（同上）
// 
// 仓颉 gtc 命名空间调用（v3 通过 public import 重导出，[本阶段可验证]，**v12 关键修订，Issue 1 响应**：采用 camelCase 命名 `mat3Cast`/`mat4Cast`/`quatCast`——`public import` 不做 snake_case→camelCase 命名转换）:
//           let m3_gtc = glm.gtc.quaternion.mat3Cast(q)
//           let q2_gtc = glm.gtc.quaternion.quatCast(m)
// 
// 仓颉顶层 glm 命名空间调用（**v10 新增，Issue 17 响应**：lib.cj 通过 `public import glm.detail.{mat3Cast, mat4Cast, quatCast}` 将 detail 包级函数重导出至顶层 `glm` 命名空间，与现有 `public import glm.detail.{transpose, matrixCompMult, outerProduct}` 模式一致，见 `cjglm/src/lib.cj:8`）：
//           let m3_top = glm.mat3Cast(q)   // 顶层 glm 命名空间（无需额外 import）
//           let q2_top = glm.quatCast(m)   // 顶层 glm 命名空间（无需额外 import）
```

### 11.5 函数可用性对照表（v3 新增，**v15 关键修订，Issue 5 响应：统一权威来源，v13 关键修订，Issue 1 响应：补齐缺失条目 + 约束注记，v16 修订，Issue 2 响应：全文档以此表为最终基准**）

**v15 修订，Issue 5 响应**：本表是函数阶段状态追踪的**单一权威来源**。§3.13.2 审计节、§8 产出物清单、§10 覆盖矩阵、§11.6 可达性矩阵等其它章节的函数状态描述均以本表为准。下游编码和测试验证时直接查阅本表即可确定每个函数在阶段三与阶段四的状态。**全文档函数可用状态以本表为最终基准**。

**v13 关键修订，Issue 1 响应**：补齐以下 7 个缺失的函数条目：(1) `scalar_quat_ops.cj` 的 `add`/`sub`/`mul`/`div`（4 个全局函数）；(2) `ext/quaternion_transform.cj` 的 `rotate` 函数；(3) Vec3×Quat/Vec4×Quat 运算符 `v * q`。同时 `fromMat3`/`fromMat4` 行增补 `where T <: FloatingPoint<T>` 约束传递性注记。

| 函数 | 本阶段状态 | 阶段四 |
|------|----------|--------|
| `identity` | ✅ 可用 | ✅ 可用 |
| `fromMat3`/`fromMat4` | ✅ 可用（**约束：`where T <: FloatingPoint<T>`（签名显式声明，v16 修订，Issue 5 响应），仅浮点 T；整型 T 实例化时编译失败；编译错误直接定位在 `fromMat3`/`fromMat4` 签名约束处而非内部 callee**） | ✅ 可用（约束同上） |
| `fromVec3`/`fromEuler` | ❌ stub | ✅ 可用 |
| `q * v` (Quat×Vec3) | ⚠️ 抛 stub 异常 | ✅ 可用 |
| `v * q` (Vec3×Quat) | ✅ 可用（通过 `inverse` 路径，无需 stub 依赖） | ✅ 可用 |
| `v * q` (Vec4×Quat) | ✅ 可用（通过 Vec3 中间路径，与 Vec3×Quat 一致） | ✅ 可用 |
| `add`/`sub`/`mul`/`div`（`scalar_quat_ops.cj`） | ✅ 可用（全局具名函数，标量左操作数 × 四元数） | ✅ 可用 |
| `rotate`（`ext/quaternion_transform.cj`） | ❌ stub（依赖 `sin`/`cos`/`length` 均为 stub） | ✅ 可用 |
| `lerp` | ✅ 可用（含断言） | ✅ 可用 |
| `conjugate`/`inverse` | ✅ 可用 | ✅ 可用 |
| `dot`/`length`/`normalize` | ✅ 可用 | ✅ 可用 |
| `isnan`/`isinf` | ✅ 可用（**约束：`where T <: FloatingPoint<T>`（D29）**，仅浮点 T，整型 T 编译失败，v4 约束收紧） | ✅ 可用（**约束：`where T <: FloatingPoint<T>`（D29）**，仅浮点 T） |
| `slerp` | ❌ stub | ✅ 可用 |
| `mix` | ❌ stub | ✅ 可用 |
| `angle`/`angleAxis` | ❌ stub | ✅ 可用 |
| `exp`/`log`/`pow`/`sqrt` | ❌ stub | ✅ 可用 |
| `eulerAngles`/`roll`/`pitch`/`yaw` | ❌ stub | ✅ 可用 |
| `quatLookAt*` | ❌ stub | ✅ 可用 |
| `epsilon`/`pi`（浮点） | ✅ 可用 | ✅ 可用 |
| `epsilon`/`pi`（整型） | ❌ 抛异常 | ❌ 抛异常（保持契约） |
| `mat3Cast`/`mat4Cast`/`quatCast`（detail） | ✅ 可用（**约束：`where T <: FloatingPoint<T>`（D32）**，仅浮点 T，整型 T 编译失败，v5 约束收紧，对应 GLM `GLM_STATIC_ASSERT(is_iec559, ...)`） | ✅ 可用（**约束：`where T <: FloatingPoint<T>`（D32）**，仅浮点 T） |
| `mat3Cast`/`mat4Cast`/`quatCast`（gtc，重导出） | ✅ 可用（**约束：`where T <: FloatingPoint<T>`（D32，约束源自 detail 端原始定义，通过 public import 透明传递）**，仅浮点 T，整型 T 编译失败，v5 约束收紧，**v12 关键修订，Issue 1 响应**：gtc 端采用 camelCase 命名而非 GLM snake_case 习惯，因 `public import` 不做命名转换） | ✅ 可用（**约束：`where T <: FloatingPoint<T>`（D32，约束源自 detail 端原始定义）**，仅浮点 T） |
| `lessThan`/`lessThanEqual`/`greaterThan`/`greaterThanEqual` | ✅ 可用（**约束：`where T <: Comparable<T>`, `Q <: Qualifier`**，**v12 修订，Issue 13 响应**：与 §3.15 完整实现函数段统一合并描述） | ✅ 可用（同上） |
| `gtc/matrix_transform` 全部 **64** 个函数（**v13 关键修订，Issue 8 响应**：v12 §11.5 未纳入 §3.13/§10 中 35→64 个 gtc/matrix_transform 函数，本轮补齐 gtc/matrix_transform 区块） | ❌ stub（**v13 关键修订**：v12 描述 35 个函数修订为 **64** 个） | ✅ 可用（按 6 大类分组：基础变换 11 + 视口与裁剪空间 19（**v14 修订，Issue 3 响应**：ortho 系族 9→10）+ frustum 系族 9）+ 透视投影 18 + 无穷远透视 9 + 投影工具 6 + 拾取矩阵 1 = **64**） |

---

### 11.6 四命名空间接口可达性矩阵（v12 新增，质询报告 C 项响应）

本节集中审计 `glm` / `glm.gtc` / `glm.detail` / `glm.ext` 四个命名空间下关键函数（含运算符重载、构造函数重载、主类型别名）的可达性，确保下游消费者在每个命名空间下均能按预期路径调用 API。

| 类别 | 函数/类型 | `glm` 顶层（lib.cj public import） | `glm.gtc`（gtc 子包） | `glm.detail`（detail 子包） | `glm.ext`（ext 子包） |
|------|----------|-------------------------------|----------------------|--------------------------|---------------------|
| **类型** | `Quat<T, Q>` | ✅ `glm.Quat`（fwd.cj type alias） | ✅ `glm.gtc.quaternion.Quat`（import detail） | ✅ `glm.detail.Quat`（原始定义） | ❌（ext 包不重新声明类型） |
| **类型** | `Mat3x3<T, Q>` / `Mat4x4<T, Q>` | ✅ `glm.Mat3x3` / `glm.Mat4x4`（阶段二 type alias） | ✅ `glm.gtc.quaternion.Mat3x3` / `Mat4x4`（import detail） | ✅ `glm.detail.Mat3x3` / `Mat4x4`（原始定义） | ❌ |
| **类型** | `Vec3<T, Q>` / `Vec4<T, Q>` | ✅ `glm.Vec3` / `glm.Vec4`（阶段一 type alias） | ✅ `glm.gtc.quaternion.Vec3` / `Vec4`（import detail） | ✅ `glm.detail.Vec3` / `Vec4`（原始定义） | ✅ `glm.ext.Vec3` / `Vec4`（ext 包 import detail 重导出） |
| **构造函数** | `Quat(x, y, z, w)` 主构造 | ✅ `glm.Quat(0, 0, 0, 1)` | ✅ 同左 | ✅ 同左（原始） | ❌ |
| **构造函数** | `Quat.fromMat3(m)` | ✅ `glm.Quat.fromMat3(m)`（Quat 是类型，方法挂在类型上） | ✅ 同左（方法跟着类型走） | ✅ 同左 | ❌ |
| **构造函数** | `Quat.identity(1.0f)` | ✅ `glm.Quat.identity(1.0f)` | ✅ 同左 | ✅ 同左 | ❌ |
| **运算符重载** | `q + r` / `q - r` / `q * r` | ✅ `glm.Quat + glm.Quat` | ✅ 同左 | ✅ 同左（原始定义） | ❌ |
| **运算符重载** | `q * v` (Quat×Vec3) | ✅ `glm.Quat * glm.Vec3` | ✅ 同左 | ✅ 同左（原始定义） | ❌ |
| **运算符重载** | `v * q` (Vec3×Quat) | ✅ `glm.Vec3 * glm.Quat` | ✅ 同左 | ✅ 同左（Vec extend 块定义） | ❌ |
| **包级函数** | `glm.mat3Cast(q)` | ✅ `glm.mat3Cast`（lib.cj public import 顶层重导出） | ❌（gtc 端无顶层包级函数） | ✅ `glm.detail.mat3Cast`（原始定义，需先 `import glm.detail.*`） | ❌ |
| **包级函数** | `glm.gtc.quaternion.mat3Cast(q)`（**v12 修订，Issue 1 响应**：camelCase 命名） | ❌ | ✅ `glm.gtc.quaternion.mat3Cast`（gtc/quaternion.cj public import detail 重导出） | ✅ 同上 | ❌ |
| **包级函数** | `glm.ext.scalar_constants.epsilon<Float32>()` | ✅ `glm.epsilon<Float32>()`（lib.cj public import ext 重导出） | ✅ `glm.gtc.constants.epsilon<Float32>()`（gtc/constants 通过 ext/scalar_constants 重导出） | ✅ `glm.detail.scalar_constants.epsilon<Float32>()`（原始定义） | ✅ `glm.ext.scalar_constants.epsilon<Float32>()`（ext 重导出接口） |
| **包级函数** | `glm.gtc.constants.zero<Float32>()` | ✅ `glm.zero<Float32>()`（lib.cj public import gtc 重导出） | ✅ `glm.gtc.constants.zero<Float32>()`（原始定义） | ❌ | ❌ |
| **包级函数** | `glm.ext.quaternion_common.conjugate(q)` | ✅ `glm.conjugate(q)`（lib.cj public import ext 重导出） | ❌（gtc 端无 conjugate 包级函数） | ❌ | ✅ `glm.ext.quaternion_common.conjugate(q)`（原始定义） |
| **包级函数** | `glm.ext.quaternion_transform.rotate(q, angle, axis)` | ✅ `glm.rotate(q, angle, axis)`（lib.cj public import ext 重导出，❌ stub） | ❌（rotate 非 gtc 函数） | ❌ | ✅ `glm.ext.quaternion_transform.rotate(q, angle, axis)`（原始定义，❌ stub） |
| **包级函数** | `glm.gtc.matrix_transform.translate(m, v)` | ✅ `glm.translate(m, v)`（lib.cj public import gtc 重导出） | ✅ `glm.gtc.matrix_transform.translate(m, v)`（stub 占位） | ❌ | ❌ |
| **类型别名** | `Quat` / `FQuat` / `DQuat` | ✅ `glm.Quat` / `glm.FQuat` / `glm.DQuat`（fwd.cj） | ❌ | ❌ | ✅ `glm.ext.quaternion_float.quat` / `glm.ext.quaternion_double.dquat`（ext 别名文件） |

**审计结论（v12 新增，质询报告 C 项响应，**v13 修订，Issue 6 响应：normalize 行交叉引用**）**：
- **所有 9 个 Quat 别名**（Quat/FQuat/DQuat + 3×Float32 精度 + 3×Float64 精度）在 `glm` 顶层命名空间通过 fwd.cj（**v13 修订，Issue 3 响应**：通过 `cjglm/scripts/gen_fwd_aliases.py` 自动生成，非 v12 描述的 `tools/gen_fwd.cj`）可达
- **所有 4 个转换函数**（mat3Cast/mat4Cast/quatCast 两个重载）在 `glm` 顶层通过 lib.cj public import + 在 `glm.gtc.quaternion` 通过 public import detail 重导出可达，**v12 修订，Issue 1 响应**：gtc 端采用 camelCase 命名而非 GLM snake_case
- **所有 15 个 gtc/quaternion 函数**（4 重导出 + 4 完整 + 7 stub）在 `glm.gtc.quaternion` 命名空间可达，下游消费者无需关心 detail 端 import 细节
- **所有 stub 占位函数**（mix/slerp/exp/log/pow/sqrt/angle/angleAxis/rotate/eulerAngles/roll/pitch/yaw/quatLookAt* + **64** 个 gtc/matrix_transform 函数（**v13 关键修订，Issue 1+2 响应**：v12 描述 35 修订为 64，详见 §3.13 + §10 + §11.5 + §8.3））在调用时抛 `Exception("stub")`，下游测试设计应覆盖异常路径验证（`assertThrows`）
- **`normalize(q)` 函数可达性与边界契约（v13 关键修订，Issue 6 响应：交叉引用）**：本阶段状态详见 §11.5 函数可用性对照表 `dot/length/normalize` 行（标记为 ✅ 可用）；完整边界行为契约（零四元数 + length 极小值 + 实现公式）详见 §5.3 边界条件表 normalize 行 + §3.7 `normalize` 函数描述 + §3.13.2 审计节 normalize 行——四者形成「§3.7 实现 + §5.3 契约 + §11.5 可用性 + §11.6 可达性」四维度交叉引用闭环

---

<!-- 修订说明(v2)~(v14) 已剥离至独立文件 a_v11_revision_history_v2_v14.md -->

---

## 修订说明（v15）

> **修订定位**：v14 设计的迭代修订（v15）。依据本轮审查报告（a_v11_iteration_requirement.md）识别 10 项问题（1 严重 + 7 一般 + 2 轻微），逐项落实到对应章节，并追加修订说明（v15）章节。

| 编号 | 严重度 | 审查意见 | v15 落实位置 | 核验结论 |
|------|--------|---------|-------------|---------|
| 问题 1 | 严重 | 累计修订附录模式导致真理分散在 13 个修订章节中，下游实现者须执行"修订说明交叉引用"过程 | 全文 / §修订说明(v2)~(v14) | **已完整修复**：§修订说明(v2)~(v14) 剥离至独立文件 `a_v11_revision_history_v2_v14.md`；§1~§11 正文保留最终结论，不再依赖修订说明交叉引用 |
| 问题 2 | 一般 | `T(Float64(n))` 字面量替代路径的核心假设未经验证，依赖此路径的函数全线面临编译失败风险 | §1「常量型 T(n) 字面量替代」段末尾 / §8 编码启动前验证项 25（v15 新增，Issue 2 响应） | **已完整修复**：§1 段落末尾新增编译可行性验证声明；§8 新增验证项 25 覆盖 Float32/Float64/Int8~Int64 全部受影响类型 |
| 问题 3 | 一般 | Mat4x4 `[]` 运算符返回类型未验证——`mat3Cast`/`mat4Cast` 逐元素填充模式依赖 `[]` 返回可赋值引用 | §8 编码启动前验证项 26（v15 新增，Issue 3 响应） | **已完整修复**：§8 新增验证项 26 验证 Mat4x4 `[]` 返回 `&Vec4<T,Q>`（可赋值引用），并指明退化路径（通过主构造函数构造） |
| 问题 4 | 一般 | Mat4x4 列字段命名未验证——§3.3 item 7 `fromMat4` 手动提取策略假设字段名为 `c0`/`c1`/`c2` | §8 编码启动前验证项 27（v15 新增，Issue 4 响应） | **已完整修复**：§8 新增验证项 27 验证 Mat4x4 列字段实际命名；若假设错误则更新 §3.3 item 7 描述 |
| 问题 5 | 一般 | 函数状态追踪散布于 §11.5/§3.13.2/§11.6 等多处，当添加新函数时易遗漏某处同步 | §11.5 函数可用性对照表 / §3.13.2 审计节 / §11.6 可达性矩阵 | **已完整修复**：§11.5 表头新增「单一权威来源」声明，明确本表是函数阶段状态追踪的单一权威来源；下游只需更新本表一处即可同步至全篇 |
| 问题 6 | 一般 | Vec4 双参数构造函数 `Vec4<T,Q>(Vec3<T,Q>, T)` 是否在所有 6 个 Qualifier 变体上可用未验证 | §8 编码启动前验证项 28（v15 新增，Issue 6 响应） | **已完整修复**：§8 新增验证项 28 覆盖全部 6 个 Qualifier 变体编译可行性验证 |
| 问题 7 | 一般 | `identity(one: T)` 中 `one - one` 演算在无符号类型上未显式声明溢出语义 | §3.3 item 5 identity 描述段 | **已完整修复**：§3.3 item 5 新增无符号整数模 2^n 溢出语义说明，明确行为已定义 |
| 问题 8 | 一般 | `fromVec3` 反平行退化分支的轴选择逻辑描述缺少 `normalize(t)` 归一化步骤 | §3.3 item 8 / §5.3 边界条件表 u, v 反平行行 | **已完整修复**：§3.3 item 8 轴选择逻辑补充 `t = normalize(t)` 归一化步骤；§5.3 边界条件表同步更新 |
| 问题 9 | 轻微 | 文档自身版本号混乱——文件名为 a_v11，文档头声称 v14 | 文档头部 §修订定位 | **已完整修复**：文档头部修订定位更新为「v14 设计的迭代修订（v15）」；文件名为 a_v11 遵循版本文件命名惯例，与内部版本号 v15 解耦 |
| 问题 10 | 轻微 | 整数类型 T 调用 `std.math` 函数的行为未在 §5.3 边界条件表中显式列出 | §5.3 边界条件表 | **已完整修复**：§5.3 新增「整型 T → trigonometric.cj 全体函数」行，明确编译期 `where T <: FloatingPoint<T>` 约束拒绝整型 T 实例化 |

### v15 修订特点

1. **结构重塑**：本轮最大的结构性修订是将 §修订说明(v2)~(v14) 剥离至独立文件 `a_v11_revision_history_v2_v14.md`，原文 §1~§11 正文保留所有 v2~v14 修订的最终结论。消除"真理分散在 13 个修订章节"的结构性问题，下游实现者查阅原文即可获取完整设计结论，无需执行"修订说明交叉引用"过程。

2. **验证项全覆盖**：针对 Issue 2/3/4/6 四项未经验证的核心假设，新增 4 个编码启动前验证项（验证项 25-28），覆盖 `T(Float64(n))` 语法在全部受影响类型上的编译可行性、Mat4x4 `[]` 可赋值引用返回类型、Mat4x4 列字段命名、Vec4 双参数构造 Qualifier 覆盖率。

3. **语义精确性强化**：Issue 7 补充 `identity` 无符号溢出语义、Issue 8 补充 `fromVec3` 反平行分支 `normalize(t)` 归一化步骤，使行为描述与 GLM 源码完全一致。

4. **权威来源统一**：Issue 5 明确 §11.5 为函数状态追踪的单一权威来源，消除多处在添加新函数时可能遗漏同步的问题。

### 累计审查意见落实统计

经过 v1（v2 设计）→ v2（v3 设计）→ v3（v4 设计）→ v4（v5 设计）→ v5（v6 设计）→ v6（v7 设计）→ v7（v8 设计）→ v8（v9 设计）→ v9（v10 设计）→ v10（v11 设计）→ v11（v12 设计）→ v12（v13 设计）→ v13（v14 设计）→ v14（v15 设计，本轮）共 14 轮设计修订：

| 修订轮次 | 审查意见 | 质询建议 | 修复率 |
|---------|---------|---------|-------|
| v1 → v2 设计 | 30 项（19 严重 + 9 一般 + 2 轻微） | — | 100% |
| v2 → v3 设计 | 6 项（4 严重 + 1 一般 + 1 轻微） | — | 100% |
| v3 → v4 设计 | 10 项（4 严重 + 4 一般 + 2 轻微） | — | 100% |
| v4 → v5 设计 | 5 项（1 严重 + 2 一般 + 2 轻微） | — | 100% |
| v5 → v6 设计 | 4 项（1 严重 + 3 轻微） | — | 100% |
| v6 → v7 设计 | 6 项（8 一般 + 1 轻微，含 3 项澄清） | — | 100% |
| v7 → v8 设计 | 11 项（3 一般 + 8 轻微） | 4 项 | 100% |
| v8 → v9 设计 | 14 项（4 严重 + 5 一般 + 5 轻微） | 5 项 | 100% |
| v9 → v10 设计 | 9 项（6 严重 + 1 一般 + 2 轻微） | 3 项 | 100% |
| v10 → v11 设计 | 19 项（2 严重 + 12 一般 + 5 轻微） | 2 项 | 100% |
| v11 → v12 设计 | 14 项（4 严重 + 5 一般 + 5 轻微） | 5 项 | 100% |
| v12 → v13 设计 | 9 项（6 严重 + 1 一般 + 2 轻微） | 3 项 | 100% |
| v13 → v14 设计 | 8 项（4 严重 + 4 一般） | 2 项 | 100% |
| v14 → v15 设计 | 10 项（1 严重 + 7 一般 + 2 轻微） | — | 100% |
| **v15 → v12 设计** | **8 项（3 严重 + 4 一般 + 1 轻微）** | — | **100%** |
| **v12 → v13 设计（本轮）** | **6 项（6 一般）** | — | **100%** |

v13 迭代整体完成，可进入下游验证环节。

---

## 修订说明（v13）

> **修订定位**：v15 设计的迭代修订（v13，对应本轮审查 a_v13_iteration_requirement.md）。依据审查报告识别 6 项问题（6 一般），逐项落实到对应章节，并追加修订说明（v13）章节。本轮 6 项问题在迭代 12 的审查中均已识别但 v12 未有效修复，本轮逐一落实。

| 编号 | 严重度 | 审查意见 | v13 落实位置 | 核验结论 |
|------|--------|---------|-------------|---------|
| 问题 1 | 一般 | §11.5 自称「单一权威来源」但缺失关键函数条目：`scalar_quat_ops.cj` 4 个全局函数、`rotate` 函数、`v * q` 运算符 | §11.5 函数可用性对照表 / §3.3 item 6/7 | **已完整修复**：§11.5 新增 7 个缺失条目（`add`/`sub`/`mul`/`div` + `rotate` + `v*q` Vec3×Quat/Vec4×Quat）；`fromMat3`/`fromMat4` 行增补 `where T <: FloatingPoint<T>` 约束传递性注记 |
| 问题 2 | 一般 | `fromMat3`/`fromMat4` 的 `FloatingPoint<T>` 约束传递性未声明——内部调用 `quatCast`（带 D32 约束）但自身的 §3.3 描述与 §11.5 标注均无约束注记 | §3.3 item 6 / §3.3 item 7 / §11.5 | **已完整修复**：§3.3 item 6/7 分别新增「隐式继承 `quatCast` 的 `where T <: FloatingPoint<T>` 约束（D32），整型 T 实例化时编译失败」声明；§11.5 `fromMat3`/`fromMat4` 行新增约束传递性注记 |
| 问题 3 | 轻微 | §3.9 `axis` 公式使用 `T(std.math.sqrt(Float64(tmp1)))`（显式提升至 Float64 再 sqrt），与 §1 方案 A（直接调用 std.math 函数，无需显式转换）不一致 | §3.9 `axis` 函数公式段 | **已完整修复**：修订为 `T(std.math.sqrt(tmp1))`，移除 `Float64()` 冗余转换层；依赖 `std.math.sqrt` 提供 Float16/Float32/Float64 重载，编译器按 T 实例化类型自动选择对应重载 |
| 问题 4 | 轻微 | §8 验证项 20 与 29（`FloatingPoint<T>` 接口方法）、25 与 30（`T(Float64(n))` 语法）内容重复，声明「全部 30 项验证」但实际独立验证目标仅 28 个 | §8 高优先级编译前验证项 / §8.3 E 节 | **已完整修复**：移除重复的验证项 29/30，将「高优先级编译前验证项」子节改为引用验证项 20 与 25；独立验证目标从 30 修正为 28 |
| 问题 5 | 一般 | `rotate` 函数（ext/quaternion_transform.cj）状态在多处描述不一致：§3.8 标 stub；§8 归入「大部分实现」；§11.6 无 `rotate` 行；§11.5 缺失 | §8 大部分实现段 / §8.3 / §11.6 可达性矩阵 | **已完整修复**：§11.5 新增 `rotate` 行（❌ stub）；§11.6 新增 `rotate` 可达性行；§8 大部分实现段补充「100% stub」标注说明；§8.3 大部分实现文件行同步补充标注 |
| 问题 6 | 轻微 | §8.2 测试用例总数 199 的覆盖充分性无法验证——无用例到函数的逐项映射，约 15 个用例无法追溯分配依据 | §8.2 末尾（新增「用例到函数的逐项分配依据」表） | **已完整修复**：新增 14 行 × 6 列的逐项分配依据表，覆盖全部 13 个测试文件 + 全表总计；表中逐函数分组归因每文件用例数，不足的下限标注补齐路径 |

### v13 修订特点

1. **权威来源完整性补齐**：本轮最关键的修复是 §11.5 函数可用性对照表——此前缺失 7 个关键函数条目（导致下游按表核验时遗漏覆盖），本轮一次性补齐。同时 `fromMat3`/`fromMat4` 的约束传递性注记使表不再隐藏"内部调用携带约束"的信息。

2. **公式与 §1 策略对齐**：`axis` 公式移除 `Float64(tmp1)` 冗余转换，使实现公式与 §1 方案 A 完全一致——当 T=Float32 时 `std.math.sqrt` 直接接受 Float32 参数返回 Float32；当 T=Float64 时接受 Float64 参数返回 Float64；不再产生「§1 说直接调用但公式却写显式转换」的自相矛盾。

3. **验证项去重**：消除 §8 编码启动前验证项中长期存在的重复（验证项 20/29 与 25/30），将独立验证目标从声称的 30 项修正为实际 28 项。

4. **rotate 状态画像统一**：在 §11.5（可用性）、§11.6（可达性）、§8（产出物分类）三处同步补充 `rotate` 的 stub 状态标注与说明，消除下游一次性获取状态画像的障碍。

5. **测试可追溯性**：新增「用例到函数的逐项分配依据表」，使 ≥199 用例的构成可逐函数追溯，消除约 15 个用例"无源可查"的问题。

---

## 修订说明（v12）

> **修订定位**：v15 设计的迭代修订（v12，对应本轮审查 a_v12_iteration_requirement.md）。依据审查报告识别 8 项问题（3 严重 + 4 一般 + 1 轻微），逐项落实到对应章节。

| 编号 | 严重度 | 审查意见 | 落实位置 | 核验结论 |
|------|--------|---------|---------|---------|
| 问题 1 | 严重 | §3.7 `length` 函数依赖描述称「`std.math.sqrt` 签名仅支持 Float64 输入/输出」，与 §1「Float16/Float32/Float64 三种重载」自相矛盾 | §3.7 `length` 函数描述段（行 461） | **已完整修复**：修订为「`std.math.sqrt` 提供 Float16/Float32/Float64 重载（见 §1 v11 修订），T=Float32 实例化时直接调用 `std.math.sqrt(Float64(dot_qq))` 并 `T(...)` 转换回目标类型；T=Float64 时直接使用 `std.math.sqrt` 返回值」 |
| 问题 2 | 严重 | §3.9 `axis` 函数依赖描述引用已废弃的「统一使用 `T(Float64.xxx(...))` 模式兼容」模式，与 §1 v11 方案 A 不符 | §3.9 `axis` 函数依赖描述段（行 491） | **已完整修复**：修订为「§1 v11 修订确认提供 Float16/Float32/Float64 重载，T=Float32 实例化时直接调用 `std.math.sqrt(Float64(tmp1))` 并 `T(...)` 转换回目标类型；T=Float64 时 `std.math.sqrt` 直接返回 Float64」|
| 问题 3 | 严重 | §3.7 `length` 函数同一段落内同时存在「仅支持 Float64」和「额外声明 Float32 重载」两个自相矛盾的 statement | §3.7 `length` 函数描述段 | **已随问题 1 修复**：统一为符合 §1 v11 的最新描述 |
| 问题 4 | 一般 | `gtc/matrix_transform.cj` 64 个 stub 函数无对应测试文件 | §8.2 测试文件清单 | **已完整修复**：新增 `tests/glm/gtc/test_matrix_transform_stubs.cj` 行（预计用例数 ≥8）|
| 问题 5 | 一般 | §8.2 用例数计算中使用 snake_case 命名 `mat3_cast`/`mat4_cast`/`quat_cast`，与 §3.2.1/D11 确定的 camelCase 命名矛盾 | §8.2 用例数计算行 + 测试覆盖维度第 4 类描述 | **已完整修复**：全文统一修订为 camelCase `mat3Cast`/`mat4Cast`/`quatCast` |
| 问题 6 | 一般 | `FloatingPoint<T>` 接口方法可用性已标为未经验证但无闭环计划 | §8 编码启动前验证项末尾 | **已完整修复**：新增「高优先级编译前验证项」子节（行 1099-1108），将验证项 20（FloatingPoint<T> 接口方法）与验证项 25（T(Float64(n)) 语法）列为 P0 优先级，要求 5 日内完成最小测试文件验证 |
| 问题 7 | 一般 | 测试策略缺少「已实现但被 stub 阻塞」函数类别的覆盖定义 | §8.2 测试覆盖维度 | **已完整修复**：新增第 8 类「⚠️ 已实现但被 stub 阻塞函数」，覆盖 `Quat×Vec3`/`Quat×Vec4`，要求每函数 ≥1 编译期测试 + ≥1 `assertThrows` 运行时测试；§11.5 ⚠️ 符号行同步新增引用 |
| 问题 8 | 轻微 | §8.2 `test_ext_scalar_constants.cj` 用例数「≥7」与注释「按原则应为 ≥12」自相矛盾 | §8.2 测试文件清单 `test_ext_scalar_constants.cj` 行 | **已完整修复**：统一按「完整实现函数：每函数 ≥2 个用例」原则计算为 3 函数 × 2 浮点类型 × 2 用例 + 1 整数异常路径 = ≥13 |

### v12 修订特点

1. **依赖描述对齐**：本轮核心修复是 §3.7 `length`/§3.9 `axis` 函数依赖描述与 §1「Float32 与 std.math 的交互约束」段的不一致性——该问题在多轮审查中反复出现（第 3/6/11 轮均指向同一根因）。本次全文搜索所有「仅支持 Float64」旧描述的残余引用并替换为与 §1 v11 修订一致的描述。

2. **测试覆盖补齐**：针对测试覆盖的缺口——新增 `gtc/matrix_transform.cj` 64 个 stub 的测试覆盖（`test_matrix_transform_stubs.cj`，≥8 用例），新增「已实现但被 stub 阻塞」函数覆盖类别（第 8 类），统一 snake_case→camelCase 命名。

3. **验证优先级明确**：针对 `FloatingPoint<T>` 接口可用性验证长期滞后的风险，新增「高优先级编译前验证项」子节，将两项基础性编译假设验证列为 P0，要求在编码阶段前完成最小仓颉测试文件验证。

4. **用例数统一**：消除 `test_ext_scalar_constants.cj` 用例数计算的多重矛盾，按统一口径计算为 ≥13。
