# GLM 1.0.3 仓颉迁移首轮 OOD 设计方案（v3 — 审查迭代修订版）

---

## 1. 概述

### 设计目标

将 GLM 1.0.3 首轮迁移范围内的 C++ 实现（基础设施层 + 向量类型系统 + 类型别名体系）以仓颉语言重新实现，提供一个在仓颉泛型系统和值类型语义下可独立编译运行的向量数学基础库。

### 核心抽象

| 抽象 | 角色 | 类型形态 |
|------|------|---------|
| `Qualifier` | 定义精度/对齐策略的多态契约 | 接口 |
| `PackedHighp` / `PackedMediump` / `PackedLowp` / `AlignedHighp` / 等 | 具体精度/对齐策略标记 | 空结构体（实现 `Qualifier`） |
| `Vec1<T,Q>` / `Vec2<T,Q>` / `Vec3<T,Q>` / `Vec4<T,Q>` | 表示数学向量的值对象 | 泛型结构体 |
| `Functor1` / `Functor2` / `Functor2VecSca` / `Functor2VecInt` | 逐分量标量函数映射工具 | 结构体（各分量数分别定义） |
| `ComputeVecAdd` / `ComputeVecSub` / 等 | 向量逐分量运算策略 | 结构体 |
| `ComputeEqual` | 分量相等比较策略（区分浮点/整数） | 结构体 |
| 标量类型别名 | 仓颉原生整数/浮点类型的 GLM 兼容命名 | `type` 别名 |
| 向量类型别名 | 具现化 Vec 类型的便捷命名 | `type` 别名 |

### 整体架构思路

采用"双层包结构 + 独立具象化别名"的架构：`glm.detail` 包封装全部核心泛型类型定义和运算逻辑，`glm` 包通过类型别名暴露已具现化的常用向量类型。类型系统以 `Qualifier` 接口为精度/对齐策略的多态入口，四个 Vec 结构体作为独立泛型类型（而非分量数参数化的单一模板）承载向量数据与运算。

---

## 2. 模块划分

### 包组织

```
package glm.detail        — 核心实现层
  ├── setup.cj            — 配置常量、辅助宏等效
  ├── qualifier.cj        — Qualifier 接口及实现类型、前向声明
  ├── shim_assert.cj      — 断言替代
  ├── shim_limits.cj      — numeric_limits 等效
  ├── shim_cstddef.cj     — SizeT/LengthT 类型别名、countof 辅助函数
  ├── compute_vector_relational.cj  — compute_equal
  ├── compute_vector_decl.cj        — compute_vec_add/sub/mul/div 等运算策略
  ├── vectorize.cj                  — functor1/functor2/functor2_vec_sca/functor2_vec_int（各分量数版本）
  ├── type_vec1.cj                  — Vec1<T,Q> 结构体定义（含复合赋值运算符）+ extend 块（二元运算符重载）
  ├── type_vec2.cj                  — Vec2<T,Q> 结构体定义（含复合赋值运算符）+ extend 块（二元运算符重载）
  ├── type_vec3.cj                  — Vec3<T,Q> 结构体定义（含复合赋值运算符）+ extend 块（二元运算符重载）
  └── type_vec4.cj                  — Vec4<T,Q> 结构体定义（含复合赋值运算符）+ extend 块（二元运算符重载）

package glm               — 公共别名层
  └── fwd.cj              — 标量类型别名 + 向量类型别名
```

### 模块间依赖

```
glm.detail（内部无包引用，同包直接可见）
  setup 无依赖
  qualifier → setup
  shim_* 无依赖（仅使用仓颉原生类型）
  compute_vector_relational → shim_cstddef + shim_limits
  vectorize → qualifier（使用 LengthT / Qualifier 接口约束）
  compute_vector_decl → vectorize + qualifier
  type_vecN → qualifier + compute_vector_relational + compute_vector_decl（按需）

glm
  fwd.cj → glm.detail.{Vec1,Vec2,Vec3,Vec4,Qualifier 实现类型}
```

`glm` 包单向依赖 `glm.detail`，反向无依赖。

### 依赖拓扑澄清

`setup.cj` 不包含 `LengthT`/`SizeT` 类型别名定义，这些归入 `shim_cstddef.cj`。`setup.cj` 仅包含 `const` 配置常量和全局辅助宏等效。`shim_cstddef.cj` 无任何依赖，所有 shim 文件与 `setup.cj` 之间不存在相互依赖。

---

## 3. 核心抽象

### 3.1 Qualifier 体系

**角色**：为向量类型的精度（ULP）和对齐策略提供编译期类型级区分能力。

C++ GLM 中 `qualifier` 是枚举值，可直接作为模板非类型参数传递。仓颉泛型系统仅接受类型作为泛型实参，因此将枚举映射为"接口 + 实现结构体"模式：

- **`interface Qualifier`** — 标记接口，无成员。所有精度/对齐策略类型实现此接口。
- **`struct PackedHighp <: Qualifier {}`** — 默认精度/对齐策略。代表数据紧凑存储、高精度运算。
- **`struct PackedMediump <: Qualifier {}`** / **`struct PackedLowp <: Qualifier {}`** — 紧缩中/低精度。
- **`struct AlignedHighp <: Qualifier {}`** / **`struct AlignedMediump <: Qualifier {}`** / **`struct AlignedLowp <: Qualifier {}`** — 对齐策略（首轮 `GLM_CONFIG_ALIGNED_GENTYPES = false`，对齐类型可定义但内部不使用）。
- **`type Defaultp = PackedHighp`** — 默认精度别名。

Vec 泛型结构体通过 `where Q <: Qualifier` 约束 Q 参数，确保精度标记的类型安全性。预定义的 `lowp_`/`mediump_`/`highp_` 别名等价于分别绑定不同的 Qualifier 实现类型。

**选择理由**：采用接口而非 sealed 枚举+匹配（enum），是因为泛型参数需要类型级区分以支持不同 Vec 实例的编译期类型区分，而非运行时分支分发。空结构体的零开销值与接口的泛型约束能力结合，是仓颉泛型系统下最直接的映射方案。

### 3.2 Vec 结构体系

**角色**：表示 N 维数学向量，是 GLM 中最核心的领域实体。每个 Vec 是值类型（struct），支持构造、分量访问、算术运算、比较运算和位运算。

四个 Vec 类型（`Vec1<T,Q>`、`Vec2<T,Q>`、`Vec3<T,Q>`、`Vec4<T,Q>`）各自独立定义，而非使用分量数参数化的单一泛型模板。每个 Vec 有自己的：

- **数据成员**：声明为 `var`（可变），命名约定如下：
  - `Vec1<T,Q>`：`var x: T`
  - `Vec2<T,Q>`：`var x: T, var y: T`
  - `Vec3<T,Q>`：`var x: T, var y: T, var z: T`
  - `Vec4<T,Q>`：`var x: T, var y: T, var z: T, var w: T`
  
  数据成员使用 `var` 而非 `let`，因为复合赋值运算符（`+=`、`-=` 等）作为 `mut` 函数需要修改成员变量。使用 `let` 声明的结构体变量（`let v = Vec2(...)`）不能调用 `mut` 函数，因此对于需要复合赋值的场景，调用方须使用 `var v = Vec2(...)` 声明。这一限制与 C++ 中 `const vec` 不能执行 `+=` 的行为一致。

- **`public static func length(): Int64`** — 返回编译期常量：Vec1 返回 1，Vec2 返回 2，Vec3 返回 3，Vec4 返回 4。此函数是计算分量数的静态接口，替代 C++ `length_t` 参数在泛型运算中的角色。

- **`const init` 构造函数**：每个 Vec 定义一个 `const init(x: T, y: T, ...)` 构造函数，允许 `const` 实例成员函数的定义。同时保留普通 `init` 构造函数用于运行时构造。`const init` 的存在使得 `==` 等比较运算符可以声明为 `const` 函数，从而在函数体内使用 `const if` 实现编译期分支选择。

- **构造函数体系**（见 §4.1 详细枚举）。
- **下标运算符 `[]`** 用于分量访问。
- **算术复合赋值运算符（`+=`、`-=`、`*=`、`/=`、`%=`）** — 在结构体内部定义为 `mut operator func`，标注 `@OverflowWrapping`。
- **二元算术运算符（`+`、`-`、`*`、`/`、`%`）** — 通过 `extend VecN<T,Q>` 扩展块定义为扩展成员函数（非成员函数的等效），不标注 `@OverflowWrapping`（委托给复合赋值，详见 §4.6）。内部实现为"拷贝 + 复合赋值"委托模式。
- **位运算符（`&`、`|`、`^`、`<<`、`>>`）** — 二元位运算符在 extend 块中定义；`~`（按位取反）不可作为运算符重载（仓颉可重载运算符列表中不包含 `~`），改为提供具名函数 `bitwiseNot()`。
- **比较运算符（`==`、`!=`）** — `==` 通过 `ComputeEqual` 策略比较，声明为 `const` 函数以支持 `const if` 编译期分支；`!=` 定义为 `!(a == b)` 而非 C++ 的 `!==`（仓颉不支持 `!==` 运算符）。
- **布尔逻辑运算**：`&&` 和 `||` 不在仓颉可重载运算符列表内，不可实现为运算符。改为提供具名函数 `logicalAnd()` 和 `logicalOr()`，接收 `Vec<Bool, Q>` 并返回 `Vec<Bool, Q>`。
- **`%` 运算符**：仓颉中 `%` 仅对整数类型有定义，浮点类型不支持 `%`。因此 `%` 仅在 `T` 为整数类型时可用，编码时通过约束（`where T <: Integer<T>`）限定，或在运算符函数体内提供编译期类型检查。

**类型形态选择理由**：
- 使用 **struct** 而非 class：向量是纯值语义类型，按值传递/赋值应复制而非共享引用。Struct 的值语义与 C++ vec 的行为一致。
- 四个**独立结构体**而非单模板特化：仓颉不支持 C++ 偏特化，无法通过 `Vec<N, T, Q>` 单模板的分量数偏特化实现各分量数版本的差异化行为。四个独立类型虽然代码重复但实现模式简单直接。
- 数据成员声明为 `var`：复合赋值运算符需要修改成员，仓颉 struct 的 `mut` 函数只能修改 `var` 成员。`let` 成员在 `mut` 函数中不可赋值。
- **复合赋值运算符在结构体内部定义为 `mut operator func`；二元运算符通过 `extend VecN<T,Q>` 扩展块定义为扩展成员函数（等效于 C++ 非成员运算符函数）**。二元运算符委托给复合赋值运算符实现（"拷贝+`op=`"模式），避免代码重复。
- `scalar + vec`（标量在左、向量在右）不可作为运算符重载实现，因为左操作数 `scalar` 类型（如 `Float32`）的 `+` 运算符无法被本包扩展。替代方案是提供具名函数——例如 `add(vec, scalar)` 和 `add(scalar, vec)` 的双向重载覆盖两种操作数顺序，或者调用方自行将标量转换为 `Vec1` 后再运算。`scalar / vec` 同理。
- `const init` 的引入：为支持 `const` 实例成员函数（如 `const` 版本的 `==` 运算符），每个 Vec 需定义一个 `const init` 构造函数。仓颉要求：对于 struct，只有定义了 `const init` 才能定义 `const` 实例成员函数。由于 Vec 的数据成员声明为 `var`（允许 `mut` 函数修改），`const init` 不影响此设计——`const init` 内可使用 `=` 赋值初始化 `var` 成员，而 `const` 实例函数（如 `==`）非 `mut`，可正常访问 `var` 成员。

### 3.3 Functor 体系

**角色**：封装"对标量函数逐分量映射到向量"的调用模式，是 `compute_vector_decl` 中运算策略的实现基础。

C++ `_vectorize.hpp` 中的四个 functor 模板（`functor1`、`functor2`、`functor2_vec_sca`、`functor2_vec_int`）使用了模板模板参数（`template<length_t L, typename T, qualifier Q> class vec`）来统一接收不同分量数的 vec 特化。由于仓颉中 Vec1~Vec4 是四个独立结构体而非同一模板的特化，模板模板参数模式无法复用。

首轮设计按分量数拆分 functor——为 Vec1~Vec4 各定义四组独立的 functor 结构体：

- **`Functor1Vec1<R, T, Q>`** ~ **`Functor1Vec4<R, T, Q>`** — 一元映射（`Func(T) -> R`）
- **`Functor2Vec1<T, Q>`** ~ **`Functor2Vec4<T, Q>`** — 二元映射（`Func(T, T) -> T`）
- **`Functor2VecScaVec1<T, Q>`** ~ **`Functor2VecScaVec4<T, Q>`** — 向量-标量二元映射
- **`Functor2VecIntVec1<T, Q>`** ~ **`Functor2VecIntVec4<T, Q>`** — 向量-整数向量二元映射

每个 functor 提供一个静态 `call` 方法，接收一个仿函数/函数引用和向量操作数，返回向量结果。

**选择理由**：拆分后 functor 总数从 4 个变为 16 个（4 种模式 × 4 分量数），但每个 functor 的实现极其简单（仅为逐分量调用函数并构造结果向量），代码生成工作量虽增加但实现复杂度极低。后续可通过宏（仓颉宏）生成这些重复定义。

### 3.4 ComputeVec* 运算策略体系

**角色**：封装向量逐分量运算的具体实现，是 Vec 运算符函数的内部委托目标。

`compute_vector_decl.hpp` 中定义的 `compute_vec_add`、`compute_vec_sub`、`compute_vec_mul`、`compute_vec_div`、`compute_vec_mod`、`compute_vec_and`、`compute_vec_or`、`compute_vec_xor`、`compute_vec_shift_left`、`compute_vec_shift_right`、`compute_vec_equal`、`compute_vec_nequal`、`compute_vec_bitwise_not` 等结构体，在 C++ 中通过偏特化的 `UseSimd` 和 `IsInt`/`Size` 参数进行 SIMD/非 SIMD 和整数/非整数的分支。

首轮设计简化策略：

- **所有 `UseSimd` 参数取 `false`**：`GLM_CONFIG_SIMD = false`，无 SIMD 路径。
- **整数/浮点运算直接在 Vec 运算符中通过泛型 `+`/`-`/`*`/`/` 等原生运算处理**，无需通过 `<functional>` 中的 `std::plus<T>` 等函数对象——仓颉中改用 lambda 或直接内联运算表达式。
- **相等比较通过 `ComputeEqual` 策略处理**：区分浮点类型（通过类型特性查询判断）和整数类型的比较路径。

**结构体定义方式**：每个 `ComputeVec*` 定义为结构体（无状态，仅提供静态 `call` 方法），按分量数分别定义 Vec1~Vec4 版本，或通过泛型参数化 Vec 类型实现统一。首轮推荐为 Vec1~Vec4 分别定义以保持与 Vec 独立结构体模式的一致性，后续可通过宏统一生成。

### 3.5 ComputeEqual

**角色**：提供分量级别的相等比较策略，向量的 `==` 运算符委托此类型做逐分量比较。

```
struct ComputeEqual<T, IsFloat> {
    static func call(a: T, b: T): Bool { a == b }
}
// 浮点特化（当前 C++ GLM 中注释掉的路径，首轮是否启用取决于 shim_limits 能力）
```

`IsFloat` 的编译期判定采用以下路径：

- **首选路径**（依赖 `shim_limits.cj` + Vec 的 `const init`）：由 `shim_limits.cj` 提供 `NumericLimits<T>.isIec559: Bool` 编译期属性，与 C++ `std::numeric_limits<T>::is_iec559` 等效。Vec 结构体定义 `const init` 构造函数，使得 `==` 运算符可声明为 `const` 函数，在函数体内通过 `const if (NumericLimits<T>.isIec559)` 在编译期选择比较路径——浮点类型使用容差比较，整数类型使用 `==` 直接比较。
- **备选路径**（shim 不提供编译期判定能力，或 `const init` 不可用）：全部使用精确比较（`a == b`）。此路径不损失正确性——浮点数直接比较在大多数使用场景下足够，与 C++ `compute_equal` 的非浮点路径行为一致。浮点容差比较通过独立的具名函数（如 `equalEpsilon`）提供给需要容差比较的场景。

**选择理由**：`const if` 可在 `const` 函数体内实现编译期分支，零运行时开销。`const init` 为此提供必要前提。若 `shim_limits.cj` 无法提供 `isIec559` 编译期常量的等效查询能力，或 Vec 无法提供 `const init`，则统一退化为精确比较路径，避免引入运行时类型分发。

### 3.6 Shim 层

**角色**：替代 GLM 所依赖的 C++ 标准库设施（`<cassert>`、`<cstddef>`、`<limits>`），是首轮范围的编译前提。

- **`shim_assert.cj`**：提供 `assert(condition: Bool, message?: String)` 函数，行为等价于 `if (!condition) { throw ... }`。这替代了 `setup.hpp` 中的 `assert()` 宏及其变体 `GLM_ASSERT_LENGTH`。Debug 模式下 `assert` 触发异常，Release 模式下应通过 `GLM_CONFIG_*` 配置编译消除断言代码（首轮暂不做消除，均保留断言；后续轮次可通过 `const` 配置 + `if` 分支在 Release 模式下跳过断言检查）。

- **`shim_limits.cj`**：提供泛型 `NumericLimits<T>` 结构体（或独立函数），查询 `T` 类型的最大值、最小值、是否为 IEEE 754 浮点等特性。实现为各数值类型静态属性的泛型封装：`where T <: Number<T>` 约束。关键接口：
  - `static isIec559: Bool` — 编译期常量，判断 T 是否为 IEEE 754 浮点类型。
  - `static max(): T` — 类型最大值。
  - `static min(): T` — 类型最小值（非规格化最小值）。
  - `static epsilon(): T` — 浮点 Epsilon（仅浮点类型有意义）。

- **`shim_cstddef.cj`**：定义 `type SizeT = UInt64`（无符号语义场景）和 `type LengthT = Int64`（索引/长度场景）两个类型别名，明确区分有符号/无符号使用场景，替代 C++ `size_t`/`ptrdiff_t`。同时提供辅助函数 `countof(arr)`，返回数组的元素个数，等效于 GLM 中基于 C++ `sizeof` 的数组元素计数宏。该函数的签名：
  ```
  func countof<T, N>(arr: VArray<T, N>): Int64 { ... }
  ```
  通过 `VArray<T, N>` 的编译期长度参数 `N` 获取元素数量，而非通过未约束的泛型参数 `T`。

### 3.7 标量类型别名

**角色**：在 `package glm` 中为仓颉原生数值类型提供与 GLM 兼容的命名体系。

映射规则：仓颉的 `Int8`/`Int16`/`Int32`/`Int64`/`UInt8`/`UInt16`/`UInt32`/`UInt64`/`Float32`/`Float64` 分别映射为 GLM 的 `int8`~`uint64`/`float`/`double`。此外为各类型提供 `lowp_`/`mediump_`/`highp_` 精度变体别名。

补充 `uint` 别名：`type uint = UInt32`，对应 C++ GLM 中的 `typedef unsigned int uint;`。

由于仓颉原生数值类型名称已足够简洁（如 `Int32` 比 `i32` 更清晰且是语言关键字），标量别名在 `package glm` 中定义以供需要 GLM 命名风格的代码使用，但 `package glm.detail` 内部直接使用仓颉原生类型名。

### 3.8 向量类型别名

**角色**：在 `package glm` 中为 Vec1~Vec4 的常用具现化提供简洁命名。

共 16 个别名家族（bvec/ivec/uvec/vec/dvec/i8vec/...）× 4 分量数 × 4 精度变体 = 256 个别名。每个别名形式如：

```
type Vec2Float32 = Vec2<Float32, PackedHighp>
type LowpVec2Float32 = Vec2<Float32, PackedLowp>
type IVec2 = Vec2<Int32, PackedHighp>
```

**别名实用性分级**：256 个别名可按使用频率分为三级：

| 级别 | 数量 | 说明 | 示例 |
|------|------|------|------|
| **必备** | ~32 | 最常用的 4 标量家族（b/ i/ u/ vec）× 4 分量数 × 2 精度（默认 + lowp） | `bvec2` ~ `bvec4`, `ivec2` ~ `ivec4`, `uvec2` ~ `uvec4`, `vec2` ~ `vec4`（含 highp/lowp 变体） |
| **常用** | ~64 | 双精度和 8 位家族（d/ i8/ u8）× 4 分量数 × 2 精度 | `dvec2` ~ `dvec4`, `i8vec2` ~ `i8vec4`, `u8vec2` ~ `u8vec4` |
| **可选** | ~160 | 16/32/64 位等其余家族的中/高精度组合 | `mediump_ivec2`, `highp_i16vec4` 等 |

选择将别名集中在 `fwd.cj`（`package glm`）中，而非分散在各 Vec 定义文件，以保持良好的关注点分离——Vec 结构体关心类型定义，别名层关心命名约定。

---

## 4. 关键行为契约

### 4.1 向量构造

- **默认构造**：所有分量初始化为零（对于数值类型）或 `false`（对于 bool）。由仓颉 struct 默认构造函数自动生成（所有成员有初始值时）。
- **标量填充构造**：接收单一标量，赋值给所有分量。对 Vec1~Vec4 均有效。
- **逐分量构造**：接收与分量数相同数量的标量参数。Vec2 接收 `(x, y)`，Vec3 接收 `(x, y, z)`，Vec4 接收 `(x, y, z, w)`。
- **跨 Vec 转换构造**：从同分量数但不同 `T`/`Q` 的 Vec 构造，分量值通过 `T(v)` 显式类型构造函数转换。不使用 `where T2 <: T` 类型的泛型约束——仓颉原始数值类型间不存在子类型关系（`Int8` 不是 `Int32` 的子类型），因此 `where T2 <: T` 约束对于数值类型转换无效。改用无约束泛型参数配合分量级 `T(v2.components)` 显式转换实现。
- **跨分量数构造**：Vec4 可从 Vec2+Vec2、Vec3+标量、Vec1+Vec2+Vec1 等组合构造；Vec3 类似；Vec2 从 Vec1+标量等。遵循 GLSL 5.4.1 规范。
- **从 Vec1 显式构造**：所有 Vec 支持从 `Vec1<T>` 显式构造，所有分量取 Vec1 的单一分量值。

**完整构造函数签名清单（Vec2 示例）**：
```
public init()                                              // 默认构造（成员有初始值 0/false 时自动生成）
public init(scalar: T)                                     // 标量填充
public init(x: T, y: T)                                    // 逐分量
public init(v: Vec2<T2, Q2>)                               // 跨转换（同分量数，无 T2 <: T 约束）
public init(a: Vec1<T>, b: T)                              // 跨分量数组合
public init(v: Vec1<T>)                                    // 从 Vec1 显式构造
public init(a: T, b: Vec1<T>)                              // 标量+Vec1
public init(v: Vec1<T>, s: T, t: T)                        // Vec1 + 标量*2（仅 Vec3/Vec4 需要更丰富组合）
const init(x: T, y: T)                                     // const 构造函数，用于 const 实例函数
```

Vec3 和 Vec4 的构造函数数量更多，因跨分量数组合方式随分量数增长。首轮编码时各 Vec 类型的构造函数清单以 GLM C++ 源文件中的实际 `#define` 展开为准。每个 Vec 至少定义一个 `const init` 构造函数（接收全部分量参数），以支持 `const` 实例成员函数的定义。

### 4.2 分量访问

- 通过 `operator []` 按索引访问（0 ~ N-1），带边界断言（`GLM_ASSERT_LENGTH` 等效）。Debug 模式下断言触发异常；Release 模式下通过 `GLM_CONFIG_*` 配置编译消除断言（首轮暂全部保留，后续轮次可添加条件编译）。
- 通过具名成员（`x`/`y`/`z`/`w`、`r`/`g`/`b`/`a`、`s`/`t`/`p`/`q`）直接访问。

### 4.3 算术运算

- 复合赋值运算符（`+=`、`-=`、`*=`、`/=`、`%=`）：在 Vec 结构体内部定义为 `mut operator func`，逐分量运算，标注 `@OverflowWrapping`。接收标量、`Vec1` 或同分量数 Vec 作为右操作数。这些函数只能通过 `var` 声明的 Vec 变量调用（`let` 声明的变量不能调用 `mut` 函数）。
- 二元算术运算符（`+`、`-`、`*`、`/`、`%`）：通过 `extend VecN<T,Q>` 扩展块定义为扩展成员函数，内部实现为"拷贝 + 复合赋值"委托模式。接收标量、`Vec1` 或同分量数 Vec 作为操作数。支持 `vec + scalar` 和 `scalar + vec` 的左侧写法仅限右侧写法（`scalar + vec` 不可实现为运算符重载，因为左操作数 scalar 类型的运算符无法由本包扩展）。
- 一元运算符（`+`、`-`）：`+v` 返回自身；`-v` 返回逐分量取反的新向量。
- **标量在左的运算替代方案**：`scalar + vec`、`scalar - vec`、`scalar / vec` 等左标量右向量的运算符重载不可实现。提供具名函数替代：
  - `add(v: VecN<T,Q>, s: T): VecN<T,Q>` 和 `add(s: T, v: VecN<T,Q>): VecN<T,Q>` 等，以双向重载覆盖两种操作数顺序。
- **`%` 运算的整数约束**：仓颉中 `%` 运算符仅对整数类型有定义，浮点类型（`Float32`/`Float64`）不支持 `%`。因此 `%` 在 Vec 上的可用性仅限 `T` 为整数类型的实例。编码实现时建议在 `%` 复合赋值和二元 `%` 运算符上添加 `where T <: Integer<T>` 约束，或通过编译期类型检查在浮点类型实例上不提供 `%` 的定义。

### 4.4 位运算

仅整数分量 Vec 有意义。包括 `&`、`|`、`^`、`<<`、`>>`。逐分量运算，不触发溢出检查（仓颉位运算无溢出异常）。复合赋值（`&=`、`|=`、`^=`、`<<=`、`>>=`）在 Vec 结构体内定义为 `mut operator func`。

`~`（单目按位取反）不在仓颉可重载运算符列表内，不可实现为运算符重载。改为提供具名函数 `bitwiseNot(): VecN<T,Q>`，通过 `extend` 块定义为扩展成员函数，内部逐分量对每个分量调用 `!`（逻辑非）或按位取反逻辑。

### 4.5 比较运算

- **`==`**：逐分量调用 `ComputeEqual` 判断相等，全分量相等返回 `true`。声明为 `const` 函数，利用 Vec 的 `const init` 构造函数支持，在函数体内通过 `const if` 实现浮点/整数类型的分支判定。
- **`!=`**：定义为对 `==` 结果取反——`!(a == b)`。任一分量不等返回 `true`。仓颉中无 `!==` 运算符概念，因此采用取反形式。
- **布尔逻辑运算**：`&&` 和 `||` 不在仓颉可重载运算符列表内，不可实现为运算符重载。改为提供具名函数：
  - `logicalAnd(a: Vec<Bool, Q>, b: Vec<Bool, Q>): Vec<Bool, Q>` — 逐分量逻辑与
  - `logicalOr(a: Vec<Bool, Q>, b: Vec<Bool, Q>): Vec<Bool, Q>` — 逐分量逻辑或
  - 一元 `!` 可为 `Vec<Bool, Q>` 重载（`!` 在可重载运算符列表中）。

### 4.6 `@OverflowWrapping` 标注策略

本设计采用以下唯一确定的策略管理溢出标注，与 roadmap §0.5.1 完全对齐：

- **复合赋值运算符**（`+=`、`-=`、`*=`、`/=`）：在 Vec 结构体内部定义为 `mut operator func`，**直接标注 `@OverflowWrapping`**。共 4 个运算符 × 4 个 Vec 类型 = 16 处标注。`%=` 仅在整数类型上需标注（浮点类型无 `%`），自增自减（`++`、`--`）首轮暂不纳入标注范围。

- **二元算术运算符**（`+`、`-`、`*`、`/`）：通过 `extend` 块定义为扩展成员函数，**不标注 `@OverflowWrapping`**。实现采用"拷贝 + 复合赋值"委托模式：
  ```
  // 示例：二元 + 运算符
  public operator func +(rhs: Vec2<T, Q>): Vec2<T, Q> {
      let mut tmp = this  // 拷贝（值语义）
      tmp += rhs         // 委托给复合赋值，@OverflowWrapping 在此生效
      return tmp
  }
  ```
  copy 操作为值语义复制（无溢出），复合赋值运算符上已标注 `@OverflowWrapping`，因而 wrapping 语义通过委托传播。二元运算符无需重复标注。

- **仓颉复合赋值自动生成机制**：仓颉在重载二元运算符时，若返回类型与左操作数类型匹配，会自动生成对应的复合赋值版本。但本设计在 Vec 结构体内部**显式定义**所有复合赋值运算符为 `mut operator func` 并标注 `@OverflowWrapping`。显式定义的 `mut operator func +=`（带注解）在重载解析中的优先级高于自动生成版本，从而保证 annotation 的精确可控性。二元运算符的委托路径为：`v1 + v2` → 拷贝 `v1` 到临时变量 → 临时变量调用 `+=` → `@OverflowWrapping` 生效。

- **浮点类型无需标注**：浮点类型（`Float32`、`Float64`）在仓颉中不会触发溢出异常（浮点溢出产生 `±Infinity` 而非异常），因此 `@OverflowWrapping` 在浮点类型的 Vec 上语义无影响（标注与否行为一致）。首轮采用统一标注的简化策略——在所有 Vec 复合赋值运算符上标注，无论 `T` 为何类型。

- **总结**：`@OverflowWrapping` 唯一在复合赋值运算符上标注，二元运算符通过委托继承 wrapping 语义，不重复标注。无内部矛盾的唯一决策。

---

## 5. 错误处理策略

### 5.1 标准错误场景

| 场景 | 策略 |
|------|------|
| 下标越界（`operator[]`） | 在运行时检测索引范围，越界时调用 `assert()` 等效的 `if + throw` 模式。与 C++ `GLM_ASSERT_LENGTH` 行为一致。**注意语义差异**：C++ `GLM_ASSERT_LENGTH` 在 Release 模式下被宏定义移除（编译为空），而仓颉的 `if + throw` 无法通过编译消除（除非使用 `const` 配置常量 + `if` 分支在 Release 模式下跳过断言检查）。首轮建议通过 `GLM_CONFIG_*` 配置 + `const if` 在 Release 模式下跳过断言，Debug 模式下保留。若首轮简化实现，则全部保留断言，在后续轮次引入 Debug/Release 区分。 |
| 整数溢出 | 通过在复合赋值运算符上标注 `@OverflowWrapping` 将溢出行为从"抛异常"改为"wrapping"，与 C++ UB 行为在数值结果上等价。 |
| 除零 | 依赖底层仓颉运行时行为（整数除零抛 `ArithmeticException`，浮点除零返回 `±Inf`）。首轮不添加额外保护层。 |

### 5.2 异常场景和边界条件

首轮需明确约定以下边界行为：

| 场景 | 行为约定 |
|------|---------|
| 零向量标准化（`normalize(0,0,0)`） | 首轮不实现 `normalize` 函数，此约定适用于后续轮次。在算子层面，零向量的算术运算始终返回有效值（零向量加零向量得零向量，等）。 |
| 零向量除零保护 | 标量除零：`vec / 0` 对整数分量抛 `ArithmeticException`，对浮点分量返回包含 `±Inf`/`NaN` 的向量。与仓颉运行时行为一致，不做预防性检查。 |
| 浮点 NaN/Infinity 在各运算中的传播策略 | 所有算术运算直接委托给仓颉原生浮点运算，因此 NaN/Infinity 的传播行为与 IEEE 754 标准一致（NaN 参与的任何运算产生 NaN，Infinity 参与算术运算按 IEEE 754 规则传播）。首轮不引入 NaN 检测或特殊处理。 |
| 跨 Vec 转换中的精度损失 | 从较宽类型向较窄类型转换（如 `Float64` → `Int32`）时使用仓颉的类型构造函数转换语义。若为隐式转换不支持的场景（如 `Float64` → `Int32`），构造函数应要求调用方显式执行转换后传入。不默认截断或 saturate。 |

无 `Option`/`Result` 使用场景——向量算术运算始终返回有效值（在 wrapping 语义下），类型构造始终有效，不涉及可能失败的 I/O 或资源获取。

---

## 6. 并发设计

首轮范围无共享状态：Vec 结构体是值类型，所有运算不可变（产生新向量）或就地修改（复合赋值）。值类型的复制语义天然线程安全——不存在同一内存位置的并发写冲突。Vec 类型不做内部加锁，调用者负责在多线程场景下的值隔离（通过局部变量或消息传递）。

---

## 7. 设计决策

### D1. 独立 Vec 结构体 vs 单模板 + 宏生成

**决策**：四个独立泛型结构体（Vec1~Vec4），不使用宏生成。

**理由**：仓颉不支持 C++ 偏特化，无法实现 `Vec<N,T,Q>` 单模板的分量数差异。宏生成虽然可减少重复代码，但首轮四个 Vec 结构体的定义模式高度一致且数量可控（4 个），独立编写可提供更好的 IDE 支持、调试可见性和代码导航体验。后续可在第二轮通过宏重构减少重复。

### D2. Qualifier 接口 vs 枚举 vs sealed class

**决策**：`interface Qualifier` + 空结构体实现。

**理由**：
- 枚举（enum）：仓颉 enum 值不能作为泛型类型实参传递，enum 构造器在泛型参数位置不被接受。
- Sealed class：引入继承和引用语义（class 为引用类型），而 precision tag 是零成本类型标记，不应有堆分配开销。
- 接口 + 空结构体：零运行时开销（空结构体的大小为零或极小），类型参数 `Q <: Qualifier` 编译期约束保证了类型安全性，可提供默认类型参数 `= PackedHighp`。

### D3. 二元运算符委托模式 vs 逐分量独立实现

**决策**：二元运算符采用"拷贝 + 复合赋值"委托模式。

**理由**：减少代码量——每个 Vec 类型约 20 个二元运算符函数，若独立实现则需要各写一份逐分量逻辑；委托模式下二元运算符函数体极其简短（3-4 行）。性能上增加一次结构体拷贝（16-64 字节），在首轮功能实现阶段可接受。后续性能优化轮次可按需改为直接实现。

### D4. 仓颉原生类型名 vs GLM 兼容别名

**决策**：`package glm.detail` 内部直接使用 `Int32`/`Float32` 等仓颉原生类型名；`package glm` 中通过 `type` 别名提供 `int32`/`f32` 等 GLM 兼容命名。

**理由**：`package glm.detail` 是内部实现，应遵循仓颉语言惯例和最佳实践。`package glm` 是公共 API，需保持与现有 GLM 用户代码的兼容性。适当分离内部实现命名和外部接口命名。

### D5. 泛型约束粒度

**决策**：Vec 的 `T` 参数不做紧约束（不要求 `T <: Number<T>`），仅约束 `Q <: Qualifier`。

**理由**：GLM 的 vec 类型在 C++ 中对分量类型几乎不做约束（通过 SFINAE 校验有效性）。在仓颉中若对 `T` 加 `Number<T>` 约束，排除了 `Bool` 类型向量。宽松约束允许编译器在运算符函数体中因类型不支持运算报错，而非在类型定义处报错，与 C++ 模板的延迟检查行为一致。

### D6. GLM_CONFIG_* 配置常量采用 const 声明

**决策**：将 C++ `#define` 宏映射为仓颉 `const` 常量（编译期常量），在 `setup.cj` 中集中声明。首轮所有配置取最保守值。

**理由**：`const` 常量是仓颉编译时求值的基本机制，可被 `if` 分支用于消除死代码（const 求值优化）。**作用域限制**：`const` 常量可用于全局、局部或静态成员（不可在扩展中声明）。`const + if` 的分支消除仅适用于函数体内的内联条件代码——在函数体外部（如顶层类型选择或成员定义）无法使用此模式。因此编译期类型选择（如 `ComputeEqual` 的浮点判定）必须在函数体内通过 `const if` 实现，而非在泛型参数约束或类型定义层面。

**18 个 GLM_CONFIG_* 常量完整清单**：

| GLM 宏名 | 仓颉等效常量名 | 首轮推荐值 | 用途说明 |
|---------|--------------|-----------|---------|
| `GLM_CONFIG_SWIZZLE` | `const GLM_CONFIG_SWIZZLE: Int` | `GLM_SWIZZLE_DISABLED`（=2） | 控制 swizzle 操作：0=operator, 1=function, 2=disabled。首轮必须设为 disabled |
| `GLM_CONFIG_SIMD` | `const GLM_CONFIG_SIMD: Bool` | `false`（=GLM_DISABLE） | 控制 SIMD 指令集启用。首轮必须设为 false 以避免 `type_vec_simd.inl` 依赖 |
| `GLM_CONFIG_ALIGNED_GENTYPES` | `const GLM_CONFIG_ALIGNED_GENTYPES: Bool` | `false`（=GLM_DISABLE） | 控制对齐类型（aligned/packed）。首轮使用非对齐默认布局 |
| `GLM_CONFIG_ANONYMOUS_STRUCT` | `const GLM_CONFIG_ANONYMOUS_STRUCT: Bool` | `false`（=GLM_DISABLE） | 控制匿名 struct 特性。仓颉不支持，首轮禁用 |
| `GLM_CONFIG_UNRESTRICTED_GENTYPE` | `const GLM_CONFIG_UNRESTRICTED_GENTYPE: Bool` | `false`（=GLM_DISABLE） | 控制泛型类型约束松弛。首轮遵循 GLSL 严格约束 |
| `GLM_CONFIG_UNRESTRICTED_FLOAT` | `const GLM_CONFIG_UNRESTRICTED_FLOAT: Bool` | `false`（=GLM_DISABLE） | 控制浮点类型约束松弛。首轮遵循 GLSL 严格约束 |
| `GLM_CONFIG_CLIP_CONTROL` | `const GLM_CONFIG_CLIP_CONTROL: Int` | `0x02`（=GLM_CLIP_CONTROL_RH_NO） | 裁剪空间约定（LH/RH, NO/ZO 位组合）。首轮使用默认 RH_NO |
| `GLM_CONFIG_CONSTEXP` | `const GLM_CONFIG_CONSTEXP: Bool` | `false`（=GLM_DISABLE） | 控制 constexpr 标识函数。仓颉中 `const` 函数编译期求值可替代 |
| `GLM_CONFIG_XYZW_ONLY` | `const GLM_CONFIG_XYZW_ONLY: Bool` | `false`（=GLM_DISABLE） | 控制仅 xyzw 分量命名模式。首轮使用完整 rgba/stpq 命名 |
| `GLM_CONFIG_CTOR_INIT` | `const GLM_CONFIG_CTOR_INIT: Int` | `0`（=GLM_CTOR_INIT_DISABLE） | 控制构造函数初始化策略。首轮不依赖特定初始化 |
| `GLM_CONFIG_DEFAULTED_FUNCTIONS` | `const GLM_CONFIG_DEFAULTED_FUNCTIONS: Bool` | `false`（=GLM_DISABLE） | 控制 C++11 defaulted 函数 |
| `GLM_CONFIG_DEFAULTED_DEFAULT_CTOR` | `const GLM_CONFIG_DEFAULTED_DEFAULT_CTOR: Bool` | `false`（=GLM_DISABLE） | 控制 defaulted 默认构造函数 |
| `GLM_CONFIG_LENGTH_TYPE` | `const GLM_CONFIG_LENGTH_TYPE: Int` | `GLM_LENGTH_INT`（=1） | 控制 `length_t` 类型选择：1=int（有符号），2=size_t（无符号）。首轮使用有符号 Int64 |
| `GLM_CONFIG_PRECISION_BOOL` | `const GLM_CONFIG_PRECISION_BOOL: Int` | `GLM_HIGHP`（=3） | 控制 bool 类型默认精度等级 |
| `GLM_CONFIG_PRECISION_INT` | `const GLM_CONFIG_PRECISION_INT: Int` | `GLM_HIGHP`（=3） | 控制 int 类型默认精度等级 |
| `GLM_CONFIG_PRECISION_UINT` | `const GLM_CONFIG_PRECISION_UINT: Int` | `GLM_HIGHP`（=3） | 控制 uint 类型默认精度等级 |
| `GLM_CONFIG_PRECISION_FLOAT` | `const GLM_CONFIG_PRECISION_FLOAT: Int` | `GLM_HIGHP`（=3） | 控制 float 类型默认精度等级 |
| `GLM_CONFIG_PRECISION_DOUBLE` | `const GLM_CONFIG_PRECISION_DOUBLE: Int` | `GLM_HIGHP`（=3） | 控制 double 类型默认精度等级 |

18 个常量集中在 `setup.cj` 中声明，与 `uint` 别名等同属全局配置层。首轮所有 `GLM_CONFIG_*` 取最保守值（如 `SIMD=false`、`SWIZZLE=DISABLED`），确保最小依赖闭合。

### D7. Functor 不直接映射 C++ `<functional>` 中的 `std::plus<T>` 等

**决策**：functor 的 `call` 方法直接接受 lambda 或函数引用作为参数，不引入 `std::plus` 等函数对象的直接等效。

**理由**：仓颉无 `std::plus`，但函数类型 `(T, T) -> T` 和 lambda 表达式可直接作为参数传递。泛型 functor 接收 `F: (T, T) -> T` 类型的函数参数即可。对比 C++ 需要 `std::plus<T>`（一个标准函数对象类型），仓颉更简洁——直接在调用点使用 `{ a, b => a + b }` 或运算符引用。

### D8. var 数据成员对 let 绑定变量的影响

**决策**：Vec 结构体的数据成员全部声明为 `var`。

**理由**：复合赋值运算符需要在 Vec 结构体内部定义为 `mut operator func`。仓颉语言规则要求：`mut` 函数只能修改声明为 `var` 的成员变量；`let` 声明的结构体变量不能调用 `mut` 函数。将数据成员声明为 `var` 使得 `var v = Vec2(...)` 可以正常执行 `v += Vec2(...)` 等复合赋值。对于 `let v = Vec2(...)` 的变量，任何复合赋值操作都会触发编译错误，这与 C++ 中 `const` 向量不能执行 `op=` 的行为一致，是合理的语言强制约束。

### D9. `!=` 运算符的实现形态

**决策**：`!=` 定义为 `!(a == b)`。

**理由**：仓颉语言中不存在 `!==` 运算符。将 `!=` 重载为对 `==` 结果取反的语义是最直接且正确的实现。这一实现与 C++ GLM 中 `operator!=` 的语义等价。

### D10. 标量在左的运算无法重载

**决策**：不支持 `scalar + vec`、`scalar / vec` 等左标量右向量的运算符重载形式，以具名函数替代。

**理由**：仓颉的运算符重载要求运算符函数定义在左操作数类型的作用域内。标量类型（如 `Float32`）的 `+` 运算符无法由本包通过 `extend` 扩展（标量类型本身不在此包中定义，且扩展运算符重载也不被允许创建新的重载覆盖原生类型已有运算符）。因此 `scalar + vec` 模式不可实现。提供 `add(scalar, vec)` 和 `add(vec, scalar)` 双向具名函数覆盖两种操作数顺序。同样，`div`、`sub`、`mul` 等也需提供双向重载。

### D11. 引入 `const init` 支持编译期分支

**决策**：为每个 Vec 结构体定义 `const init` 构造函数。

**理由**：仓颉语言要求仅当 struct 定义了 `const init` 时，才能定义 `const` 实例成员函数。`const` 实例成员函数（如 `==`）可以在函数体内使用 `const if` 实现编译期分支，零运行时开销地选择浮点容差比较路径或精确比较路径。Vec 数据成员虽为 `var`（支持 `mut` 函数），`const init` 仍可对其使用 `=` 赋值初始化。`const init` 与普通 `init` 共存，`const` 上下文调用 `const init`，运行时上下文调用普通 `init`。

### D12. `&&`/`||`/`~` 以具名函数替代运算符重载

**决策**：`&&`、`||`、`~` 不可作为运算符重载，以具名函数 `logicalAnd`、`logicalOr`、`bitwiseNot` 替代。

**理由**：仓颉可重载运算符列表为：`()`、`[]`、`!`、`-`（一元）、`**`、`*`、`/`、`%`、`+`、`-`（二元）、`<<`、`>>`、`<`、`<=`、`>`、`>=`、`==`、`!=`、`&`、`^`、`|`。该列表不包含 `&&`、`||`、`~`，因此无法为 Vec 类型重载这些运算符。具名函数在语义上等价，且可通过函数重载支持多参数形式。`&` 和 `|` 作为位运算符在可重载列表中，可用于整数类型 Vec 的逐分量位运算，但不适用于 `Vec<Bool, Q>` 的逻辑运算语义（需要短路求值语义的 `&&`/`||` 无法通过位运算替代）。

### D13. `%` 运算符的可用性约束

**决策**：`%` 仅在 `T` 为整数类型时可用。

**理由**：仓颉中 `%` 运算符仅对整数类型有定义，`Float32` 和 `Float64` 不支持 `%`。因此 Vec 的 `%` 运算符必须限定为整数分量。编码实现时建议在 `%` 相关函数上添加 `where T <: Integer<T>` 约束，或在函数体内进行编译期类型检查跳过浮点类型的定义。这与 GLM 中 `mod` 函数的行为一致——浮点类型使用 `mod` 函数而非 `%` 运算符。

### D14. 跨 Vec 类型转换不使用子类型约束

**决策**：跨 Vec 转换构造不使用 `where T2 <: T` 约束，改用无约束泛型 + `T(v)` 显式转换。

**理由**：仓颉原始数值类型间不存在子类型关系。`Int8` 不是 `Int32` 的子类型，因此 `where T2 <: T` 约束无法用于数值类型的跨类型 Vec 构造。改为无约束泛型参数，在构造函数体内对各分量调用 `T(v2.x)` 等显式类型构造函数，由仓颉的类型构造函数转换规则处理数值类型间的转换。这种方式的语义与 C++ `static_cast` 更为一致。

---

## 8. 迁移文件清单与依赖拓扑

| 序号 | 文件（package glm.detail） | 依赖 | 说明 |
|------|---------------------------|------|------|
| 1 | `setup.cj` | 无 | 配置常量、`assert` |
| 2 | `qualifier.cj` | `setup.cj` | `Qualifier` 接口及实现类型、V 前向声明注释 |
| 3 | `shim_assert.cj` | 无 | `assert()` 函数 |
| 4 | `shim_limits.cj` | 无 | `NumericLimits<T>`（含 `isIec559` 编译期属性） |
| 5 | `shim_cstddef.cj` | 无 | `SizeT`/`LengthT` 别名、`countof` 辅助函数（`VArray<T,N>` 签名） |
| 6 | `compute_vector_relational.cj` | `shim_cstddef.cj` + `shim_limits.cj` | `ComputeEqual` |
| 7 | `vectorize.cj` | `qualifier.cj` | Functor1~4 的 Vec1~Vec4 版本 |
| 8 | `compute_vector_decl.cj` | `vectorize.cj` | ComputeVecAdd/Sub/Mul/Div/... |
| 9~12 | `type_vec1.cj`~`type_vec4.cj` | `qualifier.cj` + 辅助文件 | Vec 结构体定义（含 `const init`、`mut operator func` 复合赋值运算符）+ `extend` 块（二元运算符 + 具名函数） |

| 序号 | 文件（package glm） | 依赖 | 说明 |
|------|--------------------|------|------|
| 13 | `fwd.cj` | `glm.detail.*` | 标量别名（含 `uint`）+ 256 个向量别名 |

**迁移顺序**：1 + 3 + 4 + 5（基础设施，可并行）→ 2（qualifier）→ 6 + 7（辅助工具，可并行）→ 8（运算策略）→ 9~12（Vec 类型，可并行）→ 13（别名）。

**依赖说明**：
- `setup.cj` 包含 18 个 `GLM_CONFIG_*` 编译期常量和 `uint` 别名定义，不包含 `LengthT`/`SizeT` 类型别名——这些归入 `shim_cstddef.cj`。
- `shim_cstddef.cj` 无任何依赖，与 `setup.cj` 无重叠职责。
- `countof` 辅助函数在 `shim_cstddef.cj` 中定义，签名使用 `VArray<T, N>` 获取编译期长度。
- 所有 shim 文件与 `setup.cj` 之间不存在相互依赖。

---

## 9. 异常场景和边界条件补充

本节补充首轮设计中需要明确约定的异常和边界行为，作为 §5 错误处理策略的扩展。

### 9.1 零向量相关行为

| 场景 | 约定 |
|------|------|
| 零向量加/减/乘/除标量 | 标量加/减/乘/除零向量：零向量的各分量为 `0`，运算结果与 C++ GLM 行为一致（零向量加标量得分量为标量值的向量等）。 |
| 零向量逐分量运算 | 两个零向量逐分量运算结果为零向量。 |
| 零向量与任意 Vec 的点积/叉积 | 点积/叉积不在首轮范围内。 |
| 零向量的模长 | 模长函数不在首轮范围内。 |

### 9.2 除零行为

| 场景 | Vec<T, Q> 中 T = 整数类型 | Vec<T, Q> 中 T = 浮点类型 |
|------|---------------------------|--------------------------|
| 向量逐分量除零（`vec / zero`） | 各分量整数除零抛 `ArithmeticException`，由仓颉运行时触发。不提前检测。 | 各分量浮点除零返回 `±Inf`。 |
| 向量除标量零（`vec / 0`） | 同上 | 同上 |
| 标量零除向量（`0 / vec`） | 标量在左的除法不可实现为运算符重载，通过具名函数 `div(0, vec)` 实现。整数除零仍抛异常。 | 通过具名函数 `div(0, vec)` 实现。`0.0 / 0.0 = NaN`。 |

首轮不做预防性检测，依赖运行时行为。后续轮次可考虑在 Debug 模式下添加断言。

### 9.3 NaN/Infinity 传播

所有算术运算直接委托给仓颉原生浮点运算，NaN/Infinity 传播行为完全遵循 IEEE 754 标准：

- `NaN` 参与的任何算术运算产生 `NaN`。
- `NaN` 参与 `==` 比较时：分量级 `NaN == NaN` 返回 `false`，因此 `Vec2(Float32.NaN, 1.0) == Vec2(Float32.NaN, 1.0)` 返回 `false`（与 IEEE 754 语义一致）。
- `Infinity` 运算：`vec + Infinity` 各分量得 `Infinity`；`vec / Infinity` 得 `0`（逐分量）；`vec * 0` 与 `Infinity` 组合得 `NaN`（`Inf * 0 = NaN`）。
- 首轮不提供 NaN 检测函数（如 `isnan`）或 NaN-safe 比较。需要 NaN 容差的比较使用 `ComputeEqual` 的浮点容差比较路径。

### 9.4 类型转换边界

| 转换方向 | 行为 |
|---------|------|
| 较宽浮点 → 较窄浮点（`Float64` → `Float32`） | 使用仓颉显式类型构造函数 `Float32(value)`，可能产生 ±Inf 或 ±0。 |
| 浮点 → 整数（`Float32` → `Int32`） | 使用仓颉显式类型构造函数。当浮点值超出整数范围时，在默认溢出策略（`@OverflowThrowing`）下抛 `ArithmeticException`。 |
| 整数 → 浮点 | 使用仓颉隐式或显式转换，大整数可能损失精度。 |
| 整数 → 较窄整数 | 使用仓颉显式类型构造函数，配合 `@OverflowWrapping` 标注实现截断语义。 |

Vec 的跨类型转换构造函数使用仓颉的 `T(v)` 形式进行分量级转换，不做额外检查，由仓颉运行时类型转换规则和溢出标注策略共同决定行为。

---

## 修订说明（v2）

| 审查意见 | 修改措施 |
|---------|---------|
| P1: Vec 结构体数据成员未指定 `let`/`var` | §3.2 明确数据成员声明为 `var`，说明理由（`mut` 函数需修改成员），并在 §7 D8 中补充说明 `var` 成员对 `let` 绑定变量的影响。 |
| P2: `@OverflowWrapping` 标注策略与仓颉复合赋值自动生成机制存在矛盾 | §4.6 重写标注策略：复合赋值运算符定义为 `mut operator func` 并标注；二元运算符也直接标注 `@OverflowWrapping`；分析了自动生成与显式定义的优先级问题，给出两条验证路径。 |
| P3: 缺少 `length()` 成员函数定义 | §3.2 补充 `public static func length(): Int64` 声明，说明 Vec1~Vec4 分别返回 1/2/3/4 编译期常量。 |
| P4: `!=` 运算符使用不合法的 `!==` | §4.5 将 `!=` 定义改为 `!(a == b)`，并在 §7 D9 中记录决策理由。 |
| P5: 构造函数体系缺少完整枚举 | §4.1 补充 Vec2 的完整构造函数签名清单（8 个重载），并说明 Vec3/Vec4 的数量更多，以 GLM C++ 源文件为准。 |
| P6: 缺少 `operator` 重载所属位置精确描述 | §3.2 明确说明"复合赋值运算符在 Vec 结构体内定义为 `mut operator func`；二元运算符通过 `extend VecN<T,Q>` 块定义为扩展成员函数"。 |
| P7: `scalar + vec` 不可行的结论未体现 | §4.3 明确标注 `scalar + vec` 不可作为运算符重载实现，并提供具名函数（`add(s, v)`/`add(v, s)`）替代方案。§7 D10 记录决策理由。 |
| P8: `setup.cj` 依赖声明与 Shim 职责重叠 | §2 修正包组织描述，`LengthT`/`SizeT` 归入 `shim_cstddef.cj`；§8 更新依赖拓扑，`setup.cj` 不包含类型别名定义。 |
| P9: 缺少 `countof` 辅助函数说明 | §3.6 在 `shim_cstddef.cj` 说明中补充 `countof` 函数的作用和典型签名。 |
| P10: `ComputeEqual` 的 `IsFloat` 编译期判定方案存在不确定性 | §3.5 明确两条路径：首选 `shim_limits.cj` 提供 `isIec559` + `const if`；备选统一使用精确比较。 |
| P11: 缺少 Vec1 数据成员命名 | §3.2 明确 Vec1 数据成员名为 `x`。 |
| P12: `const` 配置常量作用域限制未提及 | §7 D6 补充 `const + if` 仅适用于函数体内的内联条件代码，编译期类型选择须在函数体内实现。 |
| P13: 256 个别名的实用性未做分析 | §3.8 增加别名实用性分级表（必备 ~32 / 常用 ~64 / 可选 ~160）。 |
| 质询建议：补充异常场景和边界条件 | 新增 §9 "异常场景和边界条件补充"，覆盖零向量行为、除零保护（整数/浮点分别约定）、NaN/Infinity 传播策略、类型转换边界。 |

---

## 修订说明（v3）

| 审查意见 | 修改措施 |
|---------|---------|
| P1: `&&`/`||` 不可重载（严重） | §3.2 和 §4.5 移除 `&&`/`||` 的运算符重载设计，改为具名函数 `logicalAnd()`/`logicalOr()`。§7 新增 D12 记录决策理由。 |
| P2: `~` 不可重载（严重） | §3.2 和 §4.4 移除 `~` 运算符重载设计，改为具名函数 `bitwiseNot()`。§7 D12 统一记录。 |
| P3: 跨 Vec 转换的 `where T2 <: T` 约束不适用于数值类型（严重） | §4.1 修改跨 Vec 转换构造签名：移除 `where T2 <: T, Q2 <: Q` 约束，改用无约束泛型参数 + 分量级 `T(v)` 显式类型构造函数转换。§7 新增 D14 记录决策理由。 |
| P4: `const if` 需要 `const init`（严重） | §3.2 新增 `const init` 构造函数说明，§3.5 更新 `ComputeEqual` 路径一的前提为"Vec 定义 `const init` 使 `==` 可声明为 `const` 函数"。§7 新增 D11 记录决策理由。§4.1 在构造函数清单中补充 `const init` 签名。 |
| P5: `@OverflowWrapping` 标注策略内部矛盾（严重） | §4.6 完全重写为唯一确定的策略，与 roadmap §0.5.1 对齐：复合赋值运算符标注 `@OverflowWrapping`（16 处），二元运算符不标注（委托继承 wrapping 语义）。消除所有矛盾表述。 |
| P6: `scalar / vec` 行为与不存在运算符矛盾（一般） | §4.3 在标量在左的运算替代方案中增加 `scalar / vec` 的说明，§9.2 除零表格中对应行从"运算符"改为"具名函数"描述。 |
| P7: 缺少 GLM_CONFIG_* 常量完整清单与值（一般） | §7 D6 补充 18 个 `GLM_CONFIG_*` 常量的完整清单表格（含仓颉等效名、首轮值、简要说明），共 18 行。 |
| P8: `%` 在浮点 Vec 上不可用未分析（一般） | §3.2 和 §4.3 增加 `%` 仅在 `T` 为整数类型时可用的说明，建议添加 `where T <: Integer<T>` 约束或编译期类型检查。§7 新增 D13 记录决策。 |
| P9: `countof<T>(arr: T): Int64` 签名无法实现（一般） | §3.6 修正 `countof` 签名为 `func countof<T, N>(arr: VArray<T, N>): Int64`，通过 `VArray` 的编译期参数 `N` 获取长度。§8 更新文件说明中注明 `VArray<T,N>` 签名。 |
| P10: 缺少 `uint` 标量类型别名（轻微） | §3.7 补充 `type uint = UInt32` 别名声明。 |
| P11: `operator[]` 错误处理与 C++ 语义差异未说明（轻微） | §5.1 补充 Debug/Release 语义差异说明：C++ `GLM_ASSERT_LENGTH` 在 Release 模式被编译掉，仓颉 `if + throw` 无法消除；建议通过 `GLM_CONFIG_*` + `const if` 在 Release 模式下跳过断言。§3.6 `shim_assert.cj` 补充 Release 配置说明。 |
| 持续问题 P5：`@OverflowWrapping` 标注策略内部矛盾未收敛 | 见上 P5 修改措施：已全面重写 §4.6，消除所有矛盾表述，唯一决策对齐 roadmap。 |
