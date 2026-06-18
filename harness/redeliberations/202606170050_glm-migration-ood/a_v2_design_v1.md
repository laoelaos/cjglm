# GLM 1.0.3 仓颉迁移首轮 OOD 设计方案（v2 — 审查迭代修订版）

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

- **构造函数体系**（见 §4.1 详细枚举）。
- **下标运算符 `[]`** 用于分量访问。
- **算术复合赋值运算符（`+=`、`-=`、`*=`、`/=`、`%=`）** — 在结构体内部定义为 `mut operator func`，标注 `@OverflowWrapping`。
- **二元算术运算符（`+`、`-`、`*`、`/`、`%`）** — 通过 `extend VecN<T,Q>` 扩展块定义为扩展成员函数（非成员函数的等效），不标注 `@OverflowWrapping`（继承原理见 §4.6）。内部实现为"拷贝 + 复合赋值"委托模式。
- **位运算符（`&`、`|`、`^`、`<<`、`>>`、`~`）** — 二元位运算符在 extend 块中定义；`~` 在结构体内部定义为单目运算符。
- **比较运算符（`==`、`!=`）** — `==` 通过 `ComputeEqual` 策略比较，`!=` 定义为 `!(a == b)` 而非 C++ 的 `!==`（仓颉不支持 `!==` 运算符）。
- **布尔逻辑运算符（`&&`、`||` — 仅限 `Vec<Bool, Q>`）**。

**类型形态选择理由**：
- 使用 **struct** 而非 class：向量是纯值语义类型，按值传递/赋值应复制而非共享引用。Struct 的值语义与 C++ vec 的行为一致。
- 四个**独立结构体**而非单模板特化：仓颉不支持 C++ 偏特化，无法通过 `Vec<N, T, Q>` 单模板的分量数偏特化实现各分量数版本的差异化行为。四个独立类型虽然代码重复但实现模式简单直接。
- 数据成员声明为 `var`：复合赋值运算符需要修改成员，仓颉 struct 的 `mut` 函数只能修改 `var` 成员。`let` 成员在 `mut` 函数中不可赋值。
- **复合赋值运算符在结构体内部定义为 `mut operator func`；二元运算符通过 `extend VecN<T,Q>` 扩展块定义为扩展成员函数（等效于 C++ 非成员运算符函数）**。二元运算符委托给复合赋值运算符实现（"拷贝+`op=`"模式），避免代码重复。
- `scalar + vec`（标量在左、向量在右）不可作为运算符重载实现，因为左操作数 `scalar` 类型（如 `Float32`）的 `+` 运算符无法被本包扩展。替代方案是提供具名函数——例如 `add(vec, scalar)` 和 `add(scalar, vec)` 的双向重载覆盖两种操作数顺序，或者调用方自行将标量转换为 `Vec1` 后再运算。

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

- **首选路径**（依赖 `shim_limits.cj`）：由 `shim_limits.cj` 提供 `NumericLimits<T>.isIec559: Bool` 编译期属性，与 C++ `std::numeric_limits<T>::is_iec559` 等效。Vec 的 `==` 运算符函数体内通过 `const if (NumericLimits<T>.isIec559)` 在编译期选择比较路径——浮点类型使用容差比较，整数类型使用 `==` 直接比较。
- **备选路径**（shim 不提供编译期判定能力）：全部使用精确比较（`a == b`）。此路径不损失正确性——浮点数直接比较在大多数使用场景下足够，与 C++ `compute_equal` 的非浮点路径行为一致。浮点容差比较通过独立的具名函数（如 `equalEpsilon`）提供给需要容差比较的场景。

**选择理由**：`const if` 可在函数体内实现编译期分支，零运行时开销。若 `shim_limits.cj` 无法提供 `isIec559` 编译期常量的等效查询能力，则统一退化为精确比较路径，避免引入运行时类型分发。

### 3.6 Shim 层

**角色**：替代 GLM 所依赖的 C++ 标准库设施（`<cassert>`、`<cstddef>`、`<limits>`），是首轮范围的编译前提。

- **`shim_assert.cj`**：提供 `assert(condition: Bool, message?: String)` 函数，行为等价于 `if (!condition) { throw ... }`。这替代了 `setup.hpp` 中的 `assert()` 宏及其变体 `GLM_ASSERT_LENGTH`。

- **`shim_limits.cj`**：提供泛型 `NumericLimits<T>` 结构体（或独立函数），查询 `T` 类型的最大值、最小值、是否为 IEEE 754 浮点等特性。实现为各数值类型静态属性的泛型封装：`where T <: Number<T>` 约束。关键接口：
  - `static isIec559: Bool` — 编译期常量，判断 T 是否为 IEEE 754 浮点类型。
  - `static max(): T` — 类型最大值。
  - `static min(): T` — 类型最小值（非规格化最小值）。
  - `static epsilon(): T` — 浮点 Epsilon（仅浮点类型有意义）。

- **`shim_cstddef.cj`**：定义 `type SizeT = UInt64`（无符号语义场景）和 `type LengthT = Int64`（索引/长度场景）两个类型别名，明确区分有符号/无符号使用场景，替代 C++ `size_t`/`ptrdiff_t`。同时提供辅助函数 `countof(arr)`，返回数组的元素个数，等效于 GLM 中基于 C++ `sizeof` 的数组元素计数宏。该函数的典型签名：
  ```
  func countof<T>(arr: T): Int64 { ... }
  ```
  针对固定长度数组或 `VArray` 类型，在编译期计算元素数量。

### 3.7 标量类型别名

**角色**：在 `package glm` 中为仓颉原生数值类型提供与 GLM 兼容的命名体系。

映射规则：仓颉的 `Int8`/`Int16`/`Int32`/`Int64`/`UInt8`/`UInt16`/`UInt32`/`UInt64`/`Float32`/`Float64` 分别映射为 GLM 的 `int8`~`uint64`/`float`/`double`。此外为各类型提供 `lowp_`/`mediump_`/`highp_` 精度变体别名。

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
- **跨 Vec 转换构造**：从同分量数但不同 `T`/`Q` 的 Vec 构造，分量值通过 `static_cast` 的语义等价转换（仓颉中的 `T(v)` 或 `as` 转换）。
- **跨分量数构造**：Vec4 可从 Vec2+Vec2、Vec3+标量、Vec1+Vec2+Vec1 等组合构造；Vec3 类似；Vec2 从 Vec1+标量等。遵循 GLSL 5.4.1 规范。
- **从 Vec1 显式构造**：所有 Vec 支持从 `Vec1<T>` 显式构造，所有分量取 Vec1 的单一分量值。

**完整构造函数签名清单（Vec2 示例）**：
```
public init()                                              // 默认构造（成员有初始值 0/false 时自动生成）
public init(scalar: T)                                     // 标量填充
public init(x: T, y: T)                                    // 逐分量
public init(v: Vec2<T2, Q2>) where T2 <: T, Q2 <: Q       // 跨转换（同分量数）
public init(a: Vec1<T>, b: T)                              // 跨分量数组合
public init(v: Vec1<T>)                                    // 从 Vec1 显式构造
public init(a: T, b: Vec1<T>)                              // 标量+Vec1
public init(v: Vec1<T>, s: T, t: T)                        // Vec1 + 标量*2（仅 Vec3/Vec4 需要更丰富组合）
```
Vec3 和 Vec4 的构造函数数量更多，因跨分量数组合方式随分量数增长。首轮编码时各 Vec 类型的构造函数清单以 GLM C++ 源文件中的实际 `#define` 展开为准。

### 4.2 分量访问

- 通过 `operator []` 按索引访问（0 ~ N-1），带边界断言（`GLM_ASSERT_LENGTH` 等效）。
- 通过具名成员（`x`/`y`/`z`/`w`、`r`/`g`/`b`/`a`、`s`/`t`/`p`/`q`）直接访问。

### 4.3 算术运算

- 复合赋值运算符（`+=`、`-=`、`*=`、`/=`、`%=`）：在 Vec 结构体内部定义为 `mut operator func`，逐分量运算，标注 `@OverflowWrapping`。接收标量、`Vec1` 或同分量数 Vec 作为右操作数。这些函数只能通过 `var` 声明的 Vec 变量调用（`let` 声明的变量不能调用 `mut` 函数）。
- 二元算术运算符（`+`、`-`、`*`、`/`、`%`）：通过 `extend VecN<T,Q>` 扩展块定义为扩展成员函数，内部实现为"拷贝 + 复合赋值"委托模式。接收标量、`Vec1` 或同分量数 Vec 作为操作数。支持 `vec + scalar` 和 `scalar + vec` 的左侧写法仅限右侧写法（`scalar + vec` 不可实现为运算符重载，因为左操作数 scalar 类型的运算符无法由本包扩展）。
- 一元运算符（`+`、`-`）：`+v` 返回自身；`-v` 返回逐分量取反的新向量。
- **标量在左的运算替代方案**：`scalar + vec`、`scalar - vec` 等左标量右向量的运算符重载不可实现。提供具名函数替代：
  - `add(v: VecN<T,Q>, s: T): VecN<T,Q>` 和 `add(s: T, v: VecN<T,Q>): VecN<T,Q>` 等，以双向重载覆盖两种操作数顺序。

### 4.4 位运算

仅整数分量 Vec 有意义。包括 `&`、`|`、`^`、`<<`、`>>`、`~`。逐分量运算，不触发溢出检查（仓颉位运算无溢出异常）。复合赋值（`&=`、`|=`、`^=`、`<<=`、`>>=`）在 Vec 结构体内定义为 `mut operator func`。

### 4.5 比较运算

- **`==`**：逐分量调用 `ComputeEqual` 判断相等，全分量相等返回 `true`。
- **`!=`**：定义为对 `==` 结果取反——`!(a == b)`。任一分量不等返回 `true`。仓颉中无 `!==` 运算符概念，因此采用取反形式。
- **`&&`、`||`**：仅 bool 类型 Vec，逐分量逻辑运算，返回 `Vec<Bool, Q>`。

### 4.6 `@OverflowWrapping` 标注策略

本设计采用以下策略管理溢出标注：

- **复合赋值运算符**（`+=`、`-=`、`*=`、`/=`）：在 Vec 结构体内部定义为 `mut operator func`，**直接标注 `@OverflowWrapping`**。共 4 个运算符 × 4 个 Vec 类型 = 16 处标注。`%=` 不涉及溢出。

- **二元算术运算符**（`+`、`-`、`*`、`/`）：通过 `extend` 块定义为扩展成员函数，**直接标注 `@OverflowWrapping`**。内部采用"拷贝 + 复合赋值"委托模式实现，copy 操作为值语义复制（无溢出），复合赋值已在被委托方标注。

- **仓颉复合赋值自动生成机制的影响**：仓颉在重载二元运算符时，若返回类型与左操作数类型匹配，会自动生成对应的复合赋值版本（`+=` 等）。为消除歧义并保证 annotation 的可控性，需确定自动生成的版本与显式定义的 `mut operator func` 版本之间的优先级。本设计采用以下原则：
  - 在 Vec 结构体内部**显式定义**所有复合赋值运算符为 `mut operator func`，并标注 `@OverflowWrapping`。
  - 显式定义的 `mut operator func +=`（带注解）在重载解析中的优先级高于自动生成版本，从而保证 annotation 的精确性。
  - 二元运算符委托路径：`v1 + v2` → 拷贝 `v1` 到临时变量 → 临时变量调用 `+=` → `@OverflowWrapping` 生效。
  - 如果自动生成版本始终优先被解析（即仓颉编译器在存在显式定义时仍可能选择自动生成版本），则替代方案为：二元运算符也直接标注 `@OverflowWrapping`，不依赖委托继承 wrapping 语义，而是独立标注。实际编码时应验证仓颉编译器的实际行为。

- 可选运算符（`%=`、`++`、`--`）：首轮暂不标注——这些在整数向量中使用极少。

---

## 5. 错误处理策略

### 5.1 标准错误场景

| 场景 | 策略 |
|------|------|
| 下标越界（`operator[]`） | 在运行时检测索引范围，越界时调用 `assert()` 等效的 `if + throw` 模式。与 C++ `GLM_ASSERT_LENGTH` 行为一致。 |
| 整数溢出 | 通过在复合赋值运算符和二元运算符上标注 `@OverflowWrapping` 将溢出行为从"抛异常"改为"wrapping"，与 C++ UB 行为在数值结果上等价。 |
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

18 个 GLM_CONFIG_* 常量集中在 `setup.cj` 中声明，与 `LengthT`、`uint` 别名等同属全局配置层。首轮所有 `GLM_CONFIG_*` 取最保守值（如 `SIMD=false`、`SWIZZLE=DISABLED`），确保最小依赖闭合。

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

**决策**：不支持 `scalar + vec` 的运算符重载形式，以具名函数替代。

**理由**：仓颉的运算符重载要求运算符函数定义在左操作数类型的作用域内。标量类型（如 `Float32`）的 `+` 运算符无法由本包通过 `extend` 扩展（标量类型本身不在此包中定义，且扩展运算符重载也不被允许创建新的重载覆盖原生类型已有运算符）。因此 `scalar + vec` 模式不可实现。提供 `add(scalar, vec)` 和 `add(vec, scalar)` 双向具名函数覆盖两种操作数顺序。

---

## 8. 迁移文件清单与依赖拓扑

| 序号 | 文件（package glm.detail） | 依赖 | 说明 |
|------|---------------------------|------|------|
| 1 | `setup.cj` | 无 | 配置常量、`assert` |
| 2 | `qualifier.cj` | `setup.cj` | `Qualifier` 接口及实现类型、V 前向声明注释 |
| 3 | `shim_assert.cj` | 无 | `assert()` 函数 |
| 4 | `shim_limits.cj` | 无 | `NumericLimits<T>`（含 `isIec559` 编译期属性） |
| 5 | `shim_cstddef.cj` | 无 | `SizeT`/`LengthT` 别名、`countof` 辅助函数 |
| 6 | `compute_vector_relational.cj` | `shim_cstddef.cj` + `shim_limits.cj` | `ComputeEqual` |
| 7 | `vectorize.cj` | `qualifier.cj` | Functor1~4 的 Vec1~Vec4 版本 |
| 8 | `compute_vector_decl.cj` | `vectorize.cj` | ComputeVecAdd/Sub/Mul/Div/... |
| 9~12 | `type_vec1.cj`~`type_vec4.cj` | `qualifier.cj` + 辅助文件 | Vec 结构体定义（含 `mut operator func` 复合赋值运算符）+ `extend` 块（二元运算符重载） |

| 序号 | 文件（package glm） | 依赖 | 说明 |
|------|--------------------|------|------|
| 13 | `fwd.cj` | `glm.detail.*` | 标量别名 + 256 个向量别名 |

**迁移顺序**：1 + 3 + 4 + 5（基础设施，可并行）→ 2（qualifier）→ 6 + 7（辅助工具，可并行）→ 8（运算策略）→ 9~12（Vec 类型，可并行）→ 13（别名）。

**依赖说明**：
- `setup.cj` 不包含 `LengthT`/`SizeT` 类型别名——这些归入 `shim_cstddef.cj`。
- `shim_cstddef.cj` 无任何依赖，与 `setup.cj` 无重叠职责。
- `countof` 辅助函数在 `shim_cstddef.cj` 中定义，与 `SizeT`/`LengthT` 同属基础类型工具。
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
| 标量零除向量（`0 / vec`） | 若某分量为零，整数除零抛异常。 | 若某分量为零，`0.0 / 0.0 = NaN`。 |

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
