# GLM 1.0.3 仓颉迁移首轮 OOD 设计方案（v10 — 审查迭代修订版）

---

## 1. 概述

### 设计目标

**范围可追溯性**：本方案全量映射 roadmap §3E/3G 定义的首轮迁移范围。§8 提供范围可追溯性对照表，逐项定位 roadmap 子范围编号对应的设计章节与迁移文件。

### 设计目标

将 GLM 1.0.3 首轮迁移范围内的 C++ 实现（基础设施层 + 向量类型系统 + 类型别名体系）以仓颉语言重新实现，提供一个在仓颉泛型系统和值类型语义下可独立编译运行的向量数学基础库。

### 核心抽象

| 抽象 | 角色 | 类型形态 |
|------|------|---------|
| `Qualifier` | 定义精度/对齐策略的多态契约 | 接口 |
| `PackedHighp` / `PackedMediump` / `PackedLowp` / `AlignedHighp` / 等 | 具体精度/对齐策略标记 | 空结构体（实现 `Qualifier`） |
| `Vec1<T,Q>` / `Vec2<T,Q>` / `Vec3<T,Q>` / `Vec4<T,Q>` | 表示数学向量的值对象 | 泛型结构体 |
| `Functor1` / `Functor2` / `Functor2VecSca` / `Functor2VecInt` | 逐分量标量函数映射工具（按分量数分别定义，为后续轮次预留） | 结构体（各分量数分别定义） |
| `ComputeVecAdd` / `ComputeVecSub` / 等 | 向量逐分量运算策略（为后续 SIMD 轮次预留） | 结构体 |
| `ComputeEqual<T>` | 分量相等比较策略 | 结构体 |
| 标量类型别名 | 仓颉原生整数/浮点类型的 GLM 兼容命名 | `type` 别名 |
| 向量类型别名 | 具现化 Vec 类型的便捷命名 | `type` 别名 |

### 整体架构思路

采用"双层包结构 + 独立具象化别名"的架构：`glm.detail` 包封装全部核心泛型类型定义和运算逻辑，`glm` 包通过类型别名暴露已具现化的常用向量类型。类型系统以 `Qualifier` 接口为精度/对齐策略的多态入口，四个 Vec 结构体作为独立泛型类型（而非分量数参数化的单一模板）承载向量数据与运算。

---

## 2. 模块划分

### 包组织

```
package glm.detail        — 核心实现层
  ├── setup.cj            — 配置常量
  ├── qualifier.cj        — Qualifier 接口及实现类型、前向声明
  ├── shim_assert.cj      — 断言替代
  ├── shim_limits.cj      — numeric_limits 等效
  ├── shim_cstddef.cj     — SizeT/LengthT 类型别名（VArray size 属性提供编译期长度查询）
  ├── compute_vector_relational.cj  — compute_equal
  ├── compute_vector_decl.cj        — compute_vec_add/sub/mul/div 等运算策略（为后续轮次预留）
  ├── vectorize.cj                  — functor1/functor2/functor2_vec_sca/functor2_vec_int（为后续轮次预留）
  ├── type_vec1.cj                  — Vec1<T,Q> 结构体定义（含二元运算符 + 扩展块）
  ├── type_vec2.cj                  — Vec2<T,Q> 结构体定义（含二元运算符 + 扩展块）
  ├── type_vec3.cj                  — Vec3<T,Q> 结构体定义（含二元运算符 + 扩展块）
  └── type_vec4.cj                  — Vec4<T,Q> 结构体定义（含二元运算符 + 扩展块）

package glm               — 公共 API 面 + 别名层
  ├── lib.cj              — 公共 API 重导出（使用 public import 暴露 Vec/Qualifier 核心类型）
  └── fwd.cj              — 标量类型别名 + 向量类型别名
```

### 公共 API 面设计

`lib.cj`（`package glm`）通过 `public import` 将 `glm.detail` 中的核心类型重新导出，下游消费者只需 `import glm.*` 即可使用所有公共 API，无需直接依赖 `glm.detail` 内部包。具体导出内容：

```
package glm
public import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }
public import glm.detail.{ Qualifier, PackedHighp, PackedMediump, PackedLowp }
public import glm.detail.{ Defaultp }
// 后续轮次新增的矩阵/四元数类型在对应轮次追加至此文件
```

此设计确保：
- `package glm.detail` 中的内部实现类型（如 shim 文件、functor、compute_vector_decl 等）对下游不可见
- 下游消费者仅通过 `import glm.Vec2` 等获得类型，包路径中不含 `detail`
- 后续轮次扩展公共 API 面时只需在 `lib.cj` 追加对应的 `public import` 行

### 模块间依赖

```
glm.detail（内部无包引用，同包直接可见）
  setup 无依赖
  qualifier → setup
  shim_* 无依赖（仅使用仓颉原生类型）
  compute_vector_relational → shim_cstddef + shim_limits
  vectorize → qualifier（使用 LengthT / Qualifier 接口约束）
  compute_vector_decl → vectorize + qualifier
  type_vecN → qualifier + compute_vector_relational（按需）

glm
  lib.cj → glm.detail.{Vec1,Vec2,Vec3,Vec4,Qualifier 实现类型}
  fwd.cj → glm.detail.{Vec1,Vec2,Vec3,Vec4,Qualifier 实现类型}
```

`glm` 包单向依赖 `glm.detail`，反向无依赖。

### 依赖拓扑澄清

`setup.cj` 不包含 `LengthT`/`SizeT` 类型别名定义，这些归入 `shim_cstddef.cj`。`setup.cj` 仅包含 `const` 配置常量。`shim_cstddef.cj` 无任何依赖，所有 shim 文件与 `setup.cj` 之间不存在相互依赖。

首轮中 `compute_vector_decl.cj` 和 `vectorize.cj` 定义类型但不被 Vec 运算符实现消费，为后续轮次预留。

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

**C++ `storage<L,T,Q>` 模板结构体说明**：GLM 的 `qualifier.hpp` 中定义了 `storage` 模板（`namespace detail`），用于根据 `L`（分量数）、`T`（分量类型）和 `is_aligned` 标志选择底层数据存储类型——在非 SIMD 路径下为 `T data[L]`，在 SIMD 路径下为 SIMD 内部类型（如 `glm_f32vec4`）。仓颉 Vec 结构体直接声明具名数据成员（`var x: T` 等），不依赖 C 数组或 SIMD 内部类型，因此 `storage` 抽象在首轮中**无需也不可映射**。Vec 的数据布局由编译器根据 struct 成员定义自动确定，与 `storage` 在 C++ 中角色等效。`storage` 的 SIMD 特化（SSE2/AVX/NEON 路径）待后续 SIMD 轮次重新设计。

**选择理由**：采用接口而非 sealed 枚举+匹配（enum），是因为泛型参数需要类型级区分以支持不同 Vec 实例的编译期类型区分，而非运行时分支分发。空结构体的零开销值与接口的泛型约束能力结合，是仓颉泛型系统下最直接的映射方案。

**Qualifier 运行时行为约定**：
- **跨 Q 赋值/转换规则（首轮）**：不同 Qualifier 之间**可相互赋值和转换**。由于首轮所有 Qualifier 实现类型（PackedHighp、PackedMediump、PackedLowp、AlignedHighp 等）均为空结构体，无运行时数据差异，跨 Q 赋值在数据语义上等价于同 Q 赋值。因此 Vec 的跨类型转换构造函数（`init<T2, Q2>(v: VecN<T2, Q2>) where Q2 <: Qualifier`）已在类型层面允许 Q2→Q 的转换——Q 参数仅影响编译期类型签名，不影响数据表示。首轮编码阶段无需对跨 Q 转换添加额外的静态断言或运行时检查。
- **跨 Q 赋值/转换规则（后续轮次）**：当后续轮次为不同 Qualifier 引入差异化行为（如 aligned 类型使用不同内存对齐策略、SIMD 变体使用不同内部数据布局）时，跨 Q 赋值的语义需要重新评估。届时可按需引入编译期静态检查（如通过仓颉宏或自定义注解）限制特定 Q 组合间的转换。此评估留待对应轮次的设计审议中处理。
- **Qualifier 差异引入路径的预期说明**：当前首轮设计将 Qualifier 定义为实现统一空接口的独立空结构体，它们在类型层面是不同的泛型参数但行为完全等价。后续轮次可通过以下路径逐步引入差异化：
  1. **对齐策略差异化**（第 2 轮）：`AlignedHighp` 等对齐类型可关联自定义对齐元数据（如通过仓颉 `@Align` 注解或包装结构体），在 `GLM_CONFIG_ALIGNED_GENTYPES = true` 时生效。
  2. **SIMD 路径差异化**（第 5+ 轮）：`PackedHighp` 可关联 SIMD 内部数据布局（如通过条件编译选择 `Vector128<T>` 等 SIMD 类型），在 `GLM_CONFIG_SIMD = true` 时生效。
  3. **精度语义差异化**（后续轮次）：`PackedLowp`/`PackedMediump` 可在函数库层面（如三角函数、标准化运算）通过 `const if (isLowp<Q>())` 分支选择精度折衷算法路径。
  上述差异化路径均在当前接口+空结构体框架下兼容，无需改变类型形态。

### 3.2 Vec 结构体系

**角色**：表示 N 维数学向量，是 GLM 中最核心的领域实体。每个 Vec 是值类型（struct），支持构造、分量访问、算术运算、比较运算和位运算。

四个 Vec 类型（`Vec1<T,Q>`、`Vec2<T,Q>`、`Vec3<T,Q>`、`Vec4<T,Q>`）各自独立定义，而非使用分量数参数化的单一泛型模板。每个 Vec 有自己的：

- **数据成员**：声明为 `var`（可变，无初始值），命名约定如下：
  - `Vec1<T,Q>`：`var x: T`
  - `Vec2<T,Q>`：`var x: T, var y: T`
  - `Vec3<T,Q>`：`var x: T, var y: T, var z: T`
  - `Vec4<T,Q>`：`var x: T, var y: T, var z: T, var w: T`

  数据成员使用 `var` 而非 `let`。成员无初始值——仓颉 struct 允许 `var x: T` 形式。因此编译器不会为 Vec 结构体自动生成无参默认构造函数。所有 Vec 实例必须通过显式构造函数创建。（具体构造方式见 §4.1。）

- **`public static func length(): Int64`** — 返回编译期常量：Vec1 返回 1，Vec2 返回 2，Vec3 返回 3，Vec4 返回 4。此函数是计算分量数的静态接口，替代 C++ `length_t` 参数在泛型运算中的角色。

- **`const init` 构造函数**：每个 Vec 定义一个 `const init(x: T, y: T, ...)` 构造函数，允许 `const` 实例成员函数的定义，同时其本身在非 const 上下文中也可用于运行时构造（const README §3.2 规则 5），因此不再需要同参数列表的普通 `init`。`const init` 的存在使得 `==` 等比较运算符可以声明为 `const` 函数，从而在函数体内使用 `const if` 实现编译期分支选择。

- **类型参数显式指定**：仓颉泛型系统不支持类型参数默认值，Q 参数必须显式指定。`Vec2<Float32, PackedHighp>` 为完整合法写法。对于需要省略 Q 参数的场景，在 `fwd.cj` 中通过 `type` 别名提供常用具现化（如 `type Vec2f = Vec2<Float32, PackedHighp>`）。如需在泛型代码中编写 `Vec2<T>` 形式，可将不同精度包装为不同别名。

- **构造函数体系**（见 §4.1 完整清单）。
- **下标运算符 `[]`** 用于分量访问。有取值和赋值两种形式（见 §4.2）。
- **二元算术运算符**在 Vec 结构体内部定义（或通过 extend 块扩展），标注 `@OverflowWrapping`，直接实现逐分量运算。复合赋值运算符由编译器自动生成（仓颉在重载二元算术运算符且返回类型与左操作数类型匹配时自动生成对应的复合赋值版本）。
- **位运算符** — 二元位运算符（`&`、`|`、`^`、`<<`、`>>`）在 extend 块中定义。`~`（按位取反）不在仓颉可重载运算符列表中，改为提供具名函数 `bitwiseNot()`。
- **比较运算符** — `==` 通过 `ComputeEqual` 策略比较，声明为 `const` 函数以支持 `const if` 编译期分支。`!=` 定义为 `!(a == b)`。`<`/`<=`/`>`/`>=` 运算符的覆盖见 §4.5。
- **布尔逻辑运算**：`&&` 和 `||` 不在仓颉可重载运算符列表内，不可实现为运算符。改为提供具名函数 `logicalAnd()` 和 `logicalOr()`。各 VecN 类型分别定义对应版本，接收 `VecN<Bool, Q>` 并返回 `VecN<Bool, Q>`。
- **`%` 运算符**：在 Vec 结构体内部或 extend 块中定义，直接实现逐分量取模。当 `T` 为整数类型时编译通过；当 `T` 为浮点类型时，因仓颉原生浮点类型不支持 `%`，在实例化时产生编译错误。此行为与 D5（宽松泛型约束，延迟检查）一致。
- **`++`/`--` 运算符**：仓颉可重载运算符列表中不包含 `++`/`--`，因此无法为 Vec 类型重载。改为提供具名函数 `increment()`（返回逐分量加 1 的新向量）和 `decrement()`（返回逐分量减 1 的新向量）。这些函数标注 `@OverflowWrapping`，语义与 C++ GLM 的 `operator++`/`operator--` 返回新副本的行为一致（C++ 前缀形式返回引用，后缀返回副本；仓颉值类型统一返回副本）。C++ 的后缀 `v++` 在迁移时需替换为 `v = v.increment()`，前缀 `++v` 替换为 `v.increment()` 后重新赋值。

**`VecN<Bool, Q>` 完整行为约定**（集中说明）：
- Bool 分量 Vec 支持构造、下标访问、`==`/`!=` 比较（返回 `bool`）、`!` 一元运算符（逐分量逻辑非）、`logicalAnd`/`logicalOr` 具名函数。
- 算术运算符（`+`/`-`/`*`/`/`/`%`）在 `VecN<Bool, Q>` 上实例化时报编译错误（`Bool` 不支持算术运算），与 D5 延迟检查语义一致。
- 位运算符（`&`/`|`/`^`）在 `VecN<Bool, Q>` 上可编译通过——仓颉 `Bool` 支持 `&`/`|`/`^`，语义为逐分量逻辑运算，与 C++ GLM 的 `bvec` 位运算行为等价。
- `<<`/`>>` 在 `VecN<Bool, Q>` 上实例化时报编译错误（`Bool` 不支持移位）。
- `increment()`/`decrement()` 在 `VecN<Bool, Q>` 上实例化时报编译错误。
- `bitwiseNot()` 在 `VecN<Bool, Q>` 上可编译通过——`!` 对 `Bool` 执行逻辑非。**已知行为差异**：C++ GLM 的 `~bvec` 因整数提升机制（`bool` → `int` 按位取反 → `bool` 转换，非零即 `true`）对任一分量始终返回 `true`；而仓颉 `!Bool` 执行逻辑否定（`!true = false`），两种行为完全相反。若编码阶段需要与 C++ GLM 行为严格一致，应为 `VecN<Bool, Q>` 排除 `bitwiseNot()`，使其在实例化时产生编译错误。

**Hashable 实现策略**：
- **整数/Bool 分量 Vec**：使用 `@Derive[Hashable]` 自动派生。仓颉的 `Hashable` 接口要求实现 `hashCode(): Int64` 和 `==` 运算符。Vec 已定义 `==`，自动派生 `hashCode()` 即可。
- **浮点分量 Vec**：**不实现 `Hashable`**。浮点数 `NaN` 不符合 `Hashable` 的相等性一致性要求（`NaN != NaN`），且浮点容差比较使 `hashCode()` 与 `==` 无法保持一致性。标记为已知限制——需要哈希集合/映射中使用的场景，调用方应显式包装为自定义类型。
- **不采用按位 `hashCode()` 方案**：按位精确 `hashCode()`（如 `Float32.toBits().hashCode()`）虽可编译，但无法与浮点容差 `==` 保持一致（两个在容差范围内相等的向量可能具有不同的按位表示），违反 `Hashable` 契约。

**字符串表示策略**：
- Vec 类型不实现自定义 `toString()` 或 `Format`/`Display`。仓颉 struct 未实现 `ToString` 时，编译器可能自动生成调试格式输出（`Vec2(1, 2)` 形式）。
- 若下游需要格式化输出，可通过独立具名函数（如 `to_string(v: VecN<T, Q>): String`）在后续函数库轮次中提供。
- 首轮约定：依赖仓颉默认的 struct 字符串表示，不额外实现格式化接口。

**类型形态选择理由**：
- 使用 **struct** 而非 class：向量是纯值语义类型，按值传递/赋值应复制而非共享引用。Struct 的值语义与 C++ vec 的行为一致。
- 四个**独立结构体**而非单模板特化：仓颉不支持 C++ 偏特化，无法通过 `Vec<N, T, Q>` 单模板的分量数偏特化实现各分量数版本的差异化行为。四个独立类型虽然代码重复但实现模式简单直接。
- 数据成员声明为 `var` 且无初始值：`var` 使 `mut` 函数（在 `var` 绑定的变量上）可修改成员；无初始值意味着编译器不生成默认构造函数，调用方须显式构造。
- **二元算术运算符在 Vec 结构体内部定义为 `operator func`（非 `mut`），标注 `@OverflowWrapping`；复合赋值由编译器自动生成**。此策略替代了 v3 中"copy + op="委托模式——因复合赋值运算符（`+=` 等）不在仓颉可重载运算符列表中，无法显式定义。编译器在检测到返回类型匹配的二元运算符后自动生成复合赋值版本，`@OverflowWrapping` 标注在二元运算符上，复合赋值继承其 wrapping 语义。
- `scalar + vec`（标量在左、向量在右）不可作为运算符重载实现，因为左操作数 `scalar` 类型（如 `Float32`）的 `+` 运算符无法被本包扩展。替代方案是提供具名函数。`scalar / vec` 同理。
- `const init` 的引入：为支持 `const` 实例成员函数（如 `const` 版本的 `==` 运算符），需定义一个 `const init` 构造函数。仓颉要求：对于 struct，只有定义了 `const init` 才能定义 `const` 实例成员函数。`const init` 内可使用 `=` 赋值初始化 `var` 成员。数据成员声明为 `var` 与 `const init` 不冲突——`const init` 初始化成员，`const` 实例函数（如 `==`）非 `mut`，可正常访问 `var` 成员。`const init` 在非 const 上下文中同样可用于运行时构造（const README §3.2 规则 5），因此同参数列表的普通 `init` 不再需要——移除后仅保留 `const init` 可避免仓颉函数重载规则中因 `const` 修饰符不构成区分依据而导致的重复定义编译错误。
- **Q 参数显式指定**：仓颉泛型系统不支持类型参数默认值，Q 必须显式指定。使用 `type` 别名（如 `type Vec2f = Vec2<Float32, PackedHighp>`）提供常用具现化的简写形式，在 `glm` 包中通过别名隐藏 Q 参数细节。

### 3.3 Functor 体系

**角色**：封装"对标量函数逐分量映射到向量"的调用模式，是后续轮次 SIMD 优化或 swizzle 操作的基础设施。首轮 Functor 定义其类型但不被 Vec 运算符实现调用，为后续轮次预留。

C++ `_vectorize.hpp` 中的四个 functor 模板（`functor1`、`functor2`、`functor2_vec_sca`、`functor2_vec_int`）使用了模板模板参数。由于仓颉中 Vec1~Vec4 是四个独立结构体而非同一模板的特化，模板模板参数模式无法复用。

首轮按分量数拆分 functor——为 Vec1~Vec4 各定义四组独立的 functor 结构体：

- **`Functor1Vec1<R, T, Q>`** ~ **`Functor1Vec4<R, T, Q>`** — 一元映射（`Func(T) -> R`）
- **`Functor2Vec1<T, Q>`** ~ **`Functor2Vec4<T, Q>`** — 二元映射（`Func(T, T) -> T`）
- **`Functor2VecScaVec1<T, Q>`** ~ **`Functor2VecScaVec4<T, Q>`** — 向量-标量二元映射
- **`Functor2VecIntVec1<T, Q>`** ~ **`Functor2VecIntVec4<T, Q>`** — 向量-整数向量二元映射

每个 functor 提供一个静态 `call` 方法，接收一个仿函数/函数引用和向量操作数，返回向量结果。首轮这些类型仅定义为结构体，不产生消费代码。后续轮次可对 Vec 运算符实现进行优化，通过宏生成这些重复定义。

### 3.4 ComputeVec* 运算策略体系

**角色**：封装向量逐分量运算的具体实现，为后续轮次 SIMD 路径或特化提供扩展点。首轮 ComputeVec* 定义其类型但不被 Vec 运算符实现调用。

`compute_vector_decl.hpp` 中定义的 `compute_vec_add`、`compute_vec_sub`、`compute_vec_mul`、`compute_vec_div`、`compute_vec_mod`、`compute_vec_and`、`compute_vec_or`、`compute_vec_xor`、`compute_vec_shift_left`、`compute_vec_shift_right`、`compute_vec_equal`、`compute_vec_nequal`、`compute_vec_bitwise_not` 等结构体，在 C++ 中通过偏特化的参数进行 SIMD/非 SIMD 和整数/非整数的分支。

首轮设计简化策略：

- **所有 `UseSimd` 参数取 `false`**：`GLM_CONFIG_SIMD = false`，无 SIMD 路径。
- **整数/浮点运算直接在 Vec 运算符中通过泛型 `+`/`-`/`*`/`/` 等原生运算处理**，无需通过 ComputeVec* 委托。
- **相等比较通过 `ComputeEqual<T>` 策略处理**：简化后的 `ComputeEqual` 不再携带 `IsFloat` 参数，使用 `const if` 在编译期分支（详见 §3.5）。

首轮 ComputeVec* 结构体定义为无状态结构体（仅提供静态 `call` 方法），按分量数分别定义 Vec1~Vec4 版本。首轮这些类型仅定义但不被 Vec 运算符实现调用，为后续 SIMD 轮次预留。

### 3.5 ComputeEqual

**角色**：提供分量级别的相等比较策略，向量的 `==` 运算符委托此类型做逐分量比较。简化后的 `ComputeEqual<T>` 不再携带 `IsFloat` 参数。

`ComputeEqual<T>` 的 `isIec559` 判定依赖 `const if` 配合 `is` 运算符在编译期完成。`isIec559Of<T>()` 对所有 `T`（含 `Bool`）可用，非数值类型默认返回 `false`。

```
struct ComputeEqual<T> {
    static func call(a: T, b: T): Bool { a == b }
    // const 版本：通过 const if 实现编译期分支
    const static func callConst(a: T, b: T): Bool {
        const if (isIec559Of<T>()) {
            // 浮点路径：使用 Epsilon 容差比较
            abs(a - b) <= epsilonOf<T>()
        } else {
            // 整数/Bool 路径：精确比较
            a == b
        }
    }
}
```

`IsFloat` 参数不再需要——`const if (isIec559Of<T>())` 在编译期直接查询 `T` 是否为 IEEE 754 浮点类型，零运行时开销地选择比较路径。`ComputeEqual` 的类型参数简化为单一 `T`。

**编译期判定路径**：
1. Vec 结构体定义 `const init` 构造函数。
2. Vec 的 `==` 运算符声明为 `const` 函数。
3. `const` 函数体内通过 `const if (isIec559Of<T>())` 在编译期选择比较路径——浮点类型使用容差比较，整数/Bool 类型使用 `==` 直接比较。
4. `isIec559Of<T>()` 由 `shim_limits.cj` 提供。实现策略：在 `const` 函数体内使用 `is` 运算符对类型实例进行编译期类型检测——创建 `T` 类型的临时值并通过 `is` 判断其是否为 `Float32` 或 `Float64`。该模式在仓颉 `const` 函数上下文中可行，因为 `is` 属于可参与 `const` 表达式的运算符，且 `T(0)` 作为数值/布尔类型的 const 构造是合法的（数值类型构造函数、`Bool(0)` 均在 const 表达式中可用）。

**实现方案**：
```cangjie
const func isIec559Of<T>(): Bool {
    const if (T(0) is Float64 || T(0) is Float32) { true } else { false }
}
```
此方案不依赖函数重载或模板特化——通过 `is` 运算符在编译期直接检测类型身份，完全符合仓颉泛型函数的重载规则（单一泛型函数，无非泛型部分的差异）。`T(0) is Float64` 中，`T(0)` 是合法的 const 表达式（数值/布尔类型的构造函数在 const 上下文中可用），`is` 是合法的 const 表达式运算符。

**备选路径**（若 `const init` 或 `const if` 在特定上下文不可用）：所有类型使用精确比较（`a == b`）。此路径不损失正确性——浮点数直接比较在大多数使用场景下足够。浮点容差比较通过独立的具名函数（如 `equalEpsilon`）提供给需要容差比较的场景。

**`const operator ==` 表达式链兼容性**：`abs(a - b) <= epsilonOf<T>()` 表达式链中各环节（减法、`abs()`、`epsilonOf<T>()`、`<=` 比较）的 const 兼容性要求及验证状态详见 §7 D29。编码阶段需逐一验证后方可确认完整 const 路径的可行性。

### 3.6 Shim 层

**角色**：替代 GLM 所依赖的 C++ 标准库设施（`<cassert>`、`<cstddef>`、`<limits>`），是首轮范围的编译前提。

- **`shim_assert.cj`**：提供 `assert(condition: Bool, message?: String)` 函数，行为等价于 `if (!condition) { throw ... }`。这替代了 `setup.hpp` 中的 `assert()` 宏及其变体 `GLM_ASSERT_LENGTH`。首轮 Debug 模式下 `assert` 触发异常，Release 模式不做断言消除（两种模式均保留断言）。后续轮次可通过 `const` 配置 + `const if` 在 Release 模式下跳过断言检查。

- **`shim_limits.cj`**：提供数值极限查询功能。为避免 `NumericLimits<T>` 上的 `where T <: Number<T>` 约束与 D5（宽松泛型约束，允许 `Bool` 作为 `T`）冲突，将 `NumericLimits` 拆分为两个独立部分：
  - **`NumericLimits<T>` 结构体**（保留 `where T <: Number<T>` 约束）：提供 `static max(): T`、`static min(): T`、`static epsilon(): T` 等需要数值运算的支持接口。此结构体仅在需要数值极限的场景中使用（如 `ComputeEqual` 的浮点容差 `epsilon` 路径）。
  - **`isIec559Of<T>()` 函数**（无约束，`const` 函数）：提供编译期 `Bool` 常量，判断 `T` 是否为 IEEE 754 浮点类型。对任意 `T`（含 `Bool`）可用，非浮点类型默认返回 `false`。此函数由 `ComputeEqual.callConst` 中的 `const if` 分支使用，无 `Number<T>` 约束要求。

  `isIec559Of<T>()` 的实现策略：在 `shim_limits.cj` 中定义一个 `const` 泛型函数，函数体内使用 `const if` 配合 `is` 运算符检测类型：
  ```cangjie
  const func isIec559Of<T>(): Bool {
      const if (T(0) is Float64 || T(0) is Float32) { true } else { false }
  }
  ```
  `T(0) is Float64` 在编译期求值——当 `T` 被实例化为具体类型后，`T(0)` 的值类型在编译期已完全确定，`is` 运算符可静态判定。此方案不依赖函数重载或模板特化，符合仓颉泛型系统的约束规则（类型变量约束不参与重载解析，但此处不涉及重载）。

- **`shim_cstddef.cj`**：定义 `type SizeT = UInt64`（无符号语义场景）和 `type LengthT = Int64`（索引/长度场景）两个类型别名，明确区分有符号/无符号使用场景，替代 C++ `size_t`/`ptrdiff_t`。VArray 的 `size` 属性提供编译期长度查询，等效于 C++ 中基于 `sizeof` 的数组元素计数宏。不单独定义 `countof` 函数——`VArray<T, $N>` 的 `$N` 必须是固定数值字面量，不可声明为值泛型参数。

### 3.7 标量类型别名

**角色**：在 `package glm` 中为仓颉原生数值类型提供与 GLM 兼容的命名体系。

映射规则：仓颉的 `Int8`/`Int16`/`Int32`/`Int64`/`UInt8`/`UInt16`/`UInt32`/`UInt64`/`Float32`/`Float64` 分别映射为 GLM 的 `int8`~`uint64`/`float`/`double`。此外为各类型提供 `lowp_`/`mediump_`/`highp_` 精度变体别名。

补充 `uint` 别名：`type uint = UInt32`，对应 C++ GLM 中的 `typedef unsigned int uint;`。

由于仓颉原生数值类型名称已足够简洁（如 `Int32` 比 `i32` 更清晰且是语言关键字），标量别名在 `package glm` 中定义以供需要 GLM 命名风格的代码使用，但 `package glm.detail` 内部直接使用仓颉原生类型名。

### 3.8 向量类型别名

**角色**：在 `package glm` 中为 Vec1~Vec4 的常用具现化提供简洁命名。

**别名数量**：16 个别名家族（bvec/ivec/uvec/vec/dvec/i8vec/i16vec/i32vec/i64vec/u8vec/u16vec/u32vec/u64vec/fvec/f32vec/f64vec）× 4 分量数（1/2/3/4）× 4 精度变体（`lowp_`/`mediump_`/`highp_`/无前缀） = **256 个别名**。此数量与 roadmap §3C/§3G 中明确的"256 个类型别名定义数"一致，是首轮强制交付标准，不存在其他替代数量。

每个别名形式如：

```
type Vec2Float32 = Vec2<Float32, PackedHighp>
type LowpVec2Float32 = Vec2<Float32, PackedLowp>
type IVec2 = Vec2<Int32, PackedHighp>
```

**别名实用性分级（仅用于编码顺序规划，非交付标准）**：256 个别名可按使用频率分为三级，用于指导编码阶段的实现顺序而非定义交付边界：

| 级别 | 数量 | 涵盖范围 | 说明 |
|------|------|---------|------|
| **必备** | 64 | 4 标量家族（b/ i/ u/ vec）× 4 分量数 × 4 精度变体 | 最常用的布尔/整数/无符号/浮点向量全体精度 |
| **常用** | 48 | 3 标量家族（d/ i8/ u8）× 4 分量数 × 4 精度变体 | 双精度和 8 位整数向量全体精度 |
| **可选** | 144 | 其余 9 家族 × 4 分量数 × 4 精度变体 | 16/32/64 位整数及 fvec/f32/f64 向量全体精度 |
| **合计** | 256 | 16 家族 × 4 分量数 × 4 精度变体 | — |

**首轮实现策略**：
- **强制交付标准**：`fwd.cj` 中**全量定义 256 个别名**，此为首轮验收强制标准。
- **降级策略（可选，需触发范围变更评审）**：若首轮孵化阶段因进度或资源限制需要缩小范围，可将别名覆盖范围从 256 缩减至**无精度前缀别名 + `highp_` 精度变体**（16 家族 × 4 分量数 × 1 默认精度 = 64 个）。此缩编必须经过**范围变更评审**并由主 Agent 确认。降级后剩余的 192 个别名纳入第 2 轮范围，在首轮验收通过后立即实施。roadmap 中描述的"最简可行范围 48 个"（16 家族 × 3 分量数 × 1 精度变体，排除 Vec1 别名）可作为进一步缩编的边界参考，但同样需触发范围变更评审。
- **编码顺序**：在 `fwd.cj` 中按标量家族分组组织，每组内按分量数递增排列。首轮编码时按"必备→常用→可选"顺序依次实现，每完成一组即编译验证。

选择将别名集中在 `fwd.cj`（`package glm`）中，而非分散在各 Vec 定义文件，以保持良好的关注点分离——Vec 结构体关心类型定义，别名层关心命名约定。

### 3.9 C++ 辅助设施省略说明

**`genTypeTrait` 和 `find_best_type` 等辅助设施**：
- C++ `qualifier.hpp` 的 `detail` 命名空间中定义了 `genTypeEnum` 枚举（`GENTYPE_VEC`/`GENTYPE_MAT`/`GENTYPE_QUAT`）、`genTypeTrait<genType>` 模板偏特化（查询类型是 VEC/MAT/QUAT）、`init_gentype<genType, type>` 模板（提供 `identity()` 静态方法），以及 `find_best_type` 等类型选择工具。
- 这些辅助设施在首轮中**不需要且不迁移**。理由：它们的功能服务于矩阵/四元数层的泛型代码（如 `init_gentype` 为矩阵和四元数提供单位值生成），当前首轮范围不包含矩阵和四元数类型。这些设施将在第 2-3 轮（矩阵/四元数迁移）时随对应实现一并引入。首轮保留 `qualifier.cj` 中的 `vec`/`mat`/`qua` 前向声明注释即可。

---

## 4. 关键行为契约

### 4.1 向量构造

- **默认构造**：**不可用**。数据成员无初始值，编译器不自动生成无参构造函数。需要默认值的场景应使用标量填充构造（传入 `T(0)`）。
- **标量填充构造**：接收单一标量，赋值给所有分量。对 Vec1~Vec4 均有效。也是事实上的"默认构造"替代。
- **逐分量构造**：接收与分量数相同数量的标量参数。Vec2 接收 `(x, y)`，Vec3 接收 `(x, y, z)`，Vec4 接收 `(x, y, z, w)`。
- **跨 Vec 转换构造**：从同分量数但不同 `T`/`Q` 的 Vec 构造，分量值通过 `T(v)` 显式类型构造函数转换。不使用 `where T2 <: T` 类型的泛型约束——仓颉原始数值类型间不存在子类型关系（`Int8` 不是 `Int32` 的子类型），因此 `where T2 <: T` 约束对于数值类型转换无效。改用无约束泛型参数配合分量级 `T(v2.components)` 显式转换实现。
- **跨分量数构造**：Vec4 可从 Vec2+Vec2、Vec3+标量、Vec1+Vec2+Vec1 等组合构造；Vec3 类似；Vec2 从 Vec1+标量等。遵循 GLSL 5.4.1 规范。
- **从 Vec1 显式构造**：所有 Vec 支持从 `Vec1<T, Q>` 显式构造，所有分量取 Vec1 的单一分量值。

**完整构造函数签名清单**（仓颉语法）：

**Vec1<T, Q> where Q <: Qualifier**：
```
// const 构造函数（同时作为运行时构造函数，const README §3.2 规则 5）
const init(x: T)
// 跨类型转换
public init<T2, Q2>(v: Vec1<T2, Q2>) where Q2 <: Qualifier
```

**Vec2<T, Q> where Q <: Qualifier**：
```
// 标量填充
public init(scalar: T)
// const 构造函数（同时作为逐分量运行时构造函数）
const init(x: T, y: T)
// 跨类型转换（同分量数）
public init<T2, Q2>(v: Vec2<T2, Q2>) where Q2 <: Qualifier
// Vec1 + 标量组合
public init<T2, Q2>(a: Vec1<T2, Q2>, b: T) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec1<T2, Q2>) where Q2 <: Qualifier
// Vec1 + Vec1 组合
public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>) where Q2 <: Qualifier
// 从 Vec1 填充全部分量（仅同类型，跨类型受限原因见 §7 D31）
public init(v: Vec1<T, Q>)
```

**Vec3<T, Q> where Q <: Qualifier**：
```
// 标量填充
public init(scalar: T)
// const 构造函数（同时作为逐分量运行时构造函数）
const init(x: T, y: T, z: T)
// 跨类型转换（同分量数）
public init<T2, Q2>(v: Vec3<T2, Q2>) where Q2 <: Qualifier
// Vec2 + 标量组合
public init<T2, Q2>(a: Vec2<T2, Q2>, b: T) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec2<T2, Q2>) where Q2 <: Qualifier
// Vec1 + 2 标量组合
public init<T2, Q2>(a: Vec1<T2, Q2>, b: T, c: T) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec1<T2, Q2>, c: T) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: T, c: Vec1<T2, Q2>) where Q2 <: Qualifier
// Vec1 + Vec1 + 标量组合
public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>, c: T) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: T, c: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec1<T2, Q2>, c: Vec1<T2, Q2>) where Q2 <: Qualifier
// Vec1 + Vec1 + Vec1 组合
public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>, c: Vec1<T2, Q2>) where Q2 <: Qualifier
// 从 Vec1 填充全部分量（仅同类型，跨类型受限原因见 §7 D31）
public init(v: Vec1<T, Q>)
```

**Vec4<T, Q> where Q <: Qualifier**：
```
// 标量填充
public init(scalar: T)
// const 构造函数（同时作为逐分量运行时构造函数）
const init(x: T, y: T, z: T, w: T)
// 跨类型转换（同分量数）
public init<T2, Q2>(v: Vec4<T2, Q2>) where Q2 <: Qualifier
// Vec3 + 标量组合
public init<T2, Q2>(a: Vec3<T2, Q2>, b: T) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec3<T2, Q2>, b: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec3<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec3<T2, Q2>) where Q2 <: Qualifier
// Vec2 + Vec2 组合
public init<T2, Q2>(a: Vec2<T2, Q2>, b: Vec2<T2, Q2>) where Q2 <: Qualifier
// Vec2 + 2 标量组合
public init<T2, Q2>(a: Vec2<T2, Q2>, b: T, c: T) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec2<T2, Q2>, c: T) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: T, c: Vec2<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec2<T2, Q2>, b: Vec1<T2, Q2>, c: T) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec2<T2, Q2>, b: T, c: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec2<T2, Q2>, c: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec2<T2, Q2>, c: T) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: T, c: Vec2<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec1<T2, Q2>, c: Vec2<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec2<T2, Q2>, b: Vec1<T2, Q2>, c: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec2<T2, Q2>, c: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>, c: Vec2<T2, Q2>) where Q2 <: Qualifier
// Vec1 + 3 标量组合
public init<T2, Q2>(a: Vec1<T2, Q2>, b: T, c: T, d: T) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec1<T2, Q2>, c: T, d: T) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: T, c: Vec1<T2, Q2>, d: T) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: T, c: T, d: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>, c: T, d: T) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: T, c: Vec1<T2, Q2>, d: T) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: T, c: T, d: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec1<T2, Q2>, c: Vec1<T2, Q2>, d: T) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec1<T2, Q2>, c: T, d: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: T, c: Vec1<T2, Q2>, d: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>, c: Vec1<T2, Q2>, d: T) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>, c: T, d: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: T, c: Vec1<T2, Q2>, d: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec1<T2, Q2>, c: Vec1<T2, Q2>, d: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>, c: Vec1<T2, Q2>, d: Vec1<T2, Q2>) where Q2 <: Qualifier
// 从 Vec1 填充全部分量（仅同类型，跨类型受限原因见 §7 D31）
public init(v: Vec1<T, Q>)
```

以上清单覆盖 GLSL 5.4.1 规范定义的构造语义。编码阶段按此清单实现每个 Vec 的构造函数，无需额外参考 C++ 源码中的宏展开。

### 4.2 分量访问

- 通过 `operator []` 按索引访问（0 ~ N-1），带边界断言（`GLM_ASSERT_LENGTH` 等效）。仓颉 `[]` 运算符有两种形式：
  - **取值形式**：`public operator func [](i: Int64): T` — 返回第 i 分量。越界时触发断言。
  - **赋值形式**：`public mut operator func [](i: Int64, value!: T): Unit` — 将第 i 分量设为 value。`value` 为命名参数。必须声明为 `mut` 函数，因为 struct 的非 `mut` 实例成员函数不能修改实例成员。越界时触发断言。
- 通过具名成员（`x`/`y`/`z`/`w`、`r`/`g`/`b`/`a`、`s`/`t`/`p`/`q`）直接访问。

断言行为：Debug/Release 模式下均保留断言检查（首轮简化策略）。后续轮次可通过 `const` 配置 + `const if` 在 Release 模式下跳过。

**`operator[]` 索引类型选择理由**：采用 `Int64` 作为索引类型。原因：① `shim_cstddef.cj` 中的 `LengthT` 别名定义为 `Int64`，`length()` 静态函数返回 `Int64`，索引类型与之保持一致可避免编译器在有符号/无符号比较时的告警；② `Int64` 是仓颉默认整数类型，在索引场景中覆盖所有可能的向量长度（当前 Vec1~Vec4 的最大索引为 3）；③ 与 GLM 默认 `length_t = int`（有符号）的行为一致。

### 4.3 算术运算

- **二元算术运算符**（`+`、`-`、`*`、`/`、`%`）：在 Vec 结构体内部定义为 `operator func`（非 `mut`），标注 `@OverflowWrapping`，内部实现为逐分量直接运算。支持 `vec + vec`、`vec + scalar` 等右操作数为标量或 Vec 的形式。
- **复合赋值运算符**（`+=`、`-=`、`*=`、`/=`、`%=`）：由仓颉编译器从对应的二元运算符自动生成。不需要也不允许在源码中显式定义。`@OverflowWrapping` 标注在二元运算符上，复合赋值继承 wrapping 语义。
- **一元运算符**（`+`、`-`）：`+v` 返回自身；`-v` 返回逐分量取反的新向量。
- **标量在左的运算替代方案**：`scalar + vec`、`scalar - vec`、`scalar / vec` 等左标量右向量的运算符重载不可实现。提供具名函数替代，包括双向重载覆盖两种操作数顺序：
  - `add(v: VecN<T,Q>, s: T): VecN<T,Q>` 和 `add(s: T, v: VecN<T,Q>): VecN<T,Q>`
  - `sub(v: VecN<T,Q>, s: T): VecN<T,Q>` 和 `sub(s: T, v: VecN<T,Q>): VecN<T,Q>`
  - `mul(v: VecN<T,Q>, s: T): VecN<T,Q>` 和 `mul(s: T, v: VecN<T,Q>): VecN<T,Q>`
  - `div(v: VecN<T,Q>, s: T): VecN<T,Q>` 和 `div(s: T, v: VecN<T,Q>): VecN<T,Q>`
  - `mod(v: VecN<T,Q>, s: T): VecN<T,Q>` 和 `mod(s: T, v: VecN<T,Q>): VecN<T,Q>`
- **`%` 运算的整数约束**：`%` 运算符在 Vec 上定义为逐分量取模。当 `T` 为整数类型时正常编译；当 `T` 为浮点类型时，因仓颉原生 `Float32`/`Float64` 不支持 `%`，在实例化时产生编译错误。此行为与 D5（宽松泛型约束）一致——错误触发于使用处而非定义处。对于需要浮点数取模的场景，使用具名函数（如 `mod`，不属于首轮范围）。
- **`++`/`--` 替代方案**：`++`/`--` 不在仓颉可重载运算符列表中，不可实现为运算符重载。改为提供具名函数 `increment(): VecN<T,Q>` 和 `decrement(): VecN<T,Q>`（标注 `@OverflowWrapping`），返回逐分量加/减 1 的新向量。C++ 的 `v++`（后缀）迁移为 `v = v.increment()`，`++v`（前缀）迁移为 `v = v.increment()`。对于 `VecN<Bool, Q>`，`increment()`/`decrement()` 在实例化时因 `Bool` 不支持 `+`/`-` 产生编译错误，与 `%` 的整数约束行为一致。
- **跨类型操作**：二元运算符仅支持同类型操作数（`VecN<T, Q> op VecN<T, Q>` 及 `VecN<T, Q> op T`）。不支持跨类型操作数（如 `Vec2<Int32> + Vec2<Int16>`）。需要跨类型运算时，调用方应显式转换操作数类型（使用跨 Vec 转换构造函数）。此限制源自仓颉运算符重载不能为泛型的语言规则——运算符函数定义中无法声明额外的类型形参 `U`（运算符不能使用 `operator func +<U>(rhs: U)` 的形式引入新类型参数）。

### 4.4 位运算

仅整数分量 Vec 有意义。包括 `&`、`|`、`^`、`<<`、`>>`。逐分量运算。二元位运算符通过 `extend` 块定义为扩展成员函数。

**溢出策略**：`&`、`|`、`^` 运算不会产生溢出（按位运算结果在位宽内）。`<<`（左移）可能溢出——仓颉中 `<<` 默认使用 `@OverflowThrowing` 策略，在移位超出位宽时抛出 `ArithmeticException`。而 C++ GLM 中 `vec << scalar` 是定义良好的（高位丢弃）。因此 `<<` 运算符在 Vec 的 extend 块中定义时需要标注 `@OverflowWrapping` 以匹配 C++ GLM 的行为。`>>` 右移不会产生溢出异常（高位补符号位或 0），保持默认策略。

`~`（单目按位取反）不在仓颉可重载运算符列表内，不可实现为运算符重载。改为提供具名函数 `bitwiseNot(): VecN<T,Q>`，通过 `extend` 块定义为扩展成员函数。实现方式：`!` 是仓颉可重载的一元运算符，且对整数类型执行按位取反、对 `Bool` 执行逻辑非。因此 `bitwiseNot()` 的内部实现统一对每个分量调用 `!` 即可——对于整数分量，`!` 执行按位取反（与 C++ GLM 的 `~` 语义一致）；对于 `Bool` 分量（`VecN<Bool, Q>` 场景），`!` 执行逻辑否定（`!true = false`），这与 C++ GLM 的 `~bvec` 因整数提升始终返回 `true` 的行为完全相反。详见 §3.2 `VecN<Bool, Q>` 行为约定的已知行为差异说明。

**浮点类型约束**：`bitwiseNot()` 在 `VecN<Float32, Q>` 或 `VecN<Float64, Q>` 实例上会产生编译错误。原因是仓颉浮点类型（`Float32`/`Float64`）不原生支持 `!` 一元运算符（`!` 仅定义于整数类型和 `Bool`）。当 `T = Float32` 时，`bitwiseNot()` 函数体内的 `!component` 表达式无法通过编译。此行为与 D5（宽松泛型约束，延迟检查到实例化处）一致——错误发生在 Vec 使用者实例化 `VecN<Float32, Q>.bitwiseNot()` 的调用处，而非 Vec 结构体定义处。

**`<<` 和 `>>` 的移位量参数**：仓颉运算符重载不能为泛型——即不能定义 `operator func <<<U>(rhs: U)` 引入新类型参数。因此移位量的类型必须是具体类型（不可为模板参数 `U`）。可选方案：
- **方案 A（采用）：移位量取 `T`** ——右操作数类型与分量类型相同。对于 `Vec2<UInt8> << UInt8(3)`，移位量为 `UInt8`。方案 A 与 C++ GLM 的 `operator<<(vec, T scalar)` 行为一致，且适用于所有整数 `T`。注意：当 `T = UInt8` 时，移位量范围受限（0~7），但 `UInt8(3)` 在语义上与 `Int64(3)` 等效。
- **方案 B（备选）：移位量取 `Int64`** ——右操作数为固定 `Int64` 类型，与分量类型无关。此方案使移位量类型与 `LengthT` 一致（均为 `Int64`），移位移位较大向量时无需类型转换。但无法用 VecN 作为右操作数（`vec << vec` 形式在 GLM 中存在但极少使用），且需为每个 VecN 单独定义接受 `Int64` 的 `<<` 运算符（无法复用分量类型 `T` 的运算符）。
- **决策**：首轮采用方案 A（移位量取 `T`），在 Vec 的 extend 块中定义为 `operator func <<(shift: T): VecN<T, Q>`。此方案与 D5（宽松泛型约束）一致——移位操作在整数 `T` 上正确编译，在非整数 `T` 上于实例化处报错。方案 B（`Int64` 移位量）作为备选，若后续编码阶段发现 `T` 类型移位量在位宽较窄时（如 `UInt8`）产生过多截断转换，可改为方案 B。

### 4.5 比较运算

**相等比较**：
- **`==`**：逐分量调用 `ComputeEqual<T>.callConst` 比较，全分量相等返回 `true`。声明为 `const` 函数，利用 Vec 的 `const init` 构造函数支持，在函数体内通过 `const if (isIec559Of<T>())` 在编译期选择比较路径——浮点类型使用 Epsilon 容差比较，整数/Bool 类型使用 `==` 直接比较。
- **`!=`**：定义为对 `==` 结果取反——`!(a == b)`。任一分量不等返回 `true`。仓颉中无 `!==` 运算符概念，因此采用取反形式。

**`<`/`<=`/`>`/`>=` 运算符**：
- **决策**：首轮**不定义** `<`/`<=`/`>`/`>=` 运算符。
- **理由**：C++ GLM 的 Vec 类型上未定义这四个运算符——`type_vecN.hpp` 中仅声明了 `==`、`!=`、`&&`、`||`。在 GLSL 语义中，向量的逐分量比较通过具名函数（`lessThan`、`greaterThan`、`lessThanEqual`、`greaterThanEqual`）完成，而非运算符。在仓颉中若定义这些运算符，需要明确语义选择——聚合比较（返回 `bool`，类似 `==`）与 C++ GLM 行为不一致，逐分量比较（返回 `VecN<Bool, Q>`）则无法在 `if` 中直接使用。因此首轮不提供，避免语义混淆。逐分量比较函数纳入后续函数库迁移轮次（从 `vector_relational.hpp` 迁移）。
- **替代方案**：需要逐分量比较时，使用 `ext/vector_relational.hpp` 中的具名函数（将来迁移）。

**布尔逻辑运算**：
- `&&` 和 `||` 不在仓颉可重载运算符列表内，不可实现为运算符重载。改为提供具名函数。各 VecN 类型分别定义对应版本：
  - `logicalAnd(a: VecN<Bool, Q>, b: VecN<Bool, Q>): VecN<Bool, Q>` — 逐分量逻辑与（各 VecN 分别定义）
  - `logicalOr(a: VecN<Bool, Q>, b: VecN<Bool, Q>): VecN<Bool, Q>` — 逐分量逻辑或（各 VecN 分别定义）
  - 一元 `!` 可为 `VecN<Bool, Q>` 重载（`!` 在可重载运算符列表中）。

### 4.6 `@OverflowWrapping` 标注策略

本设计采用以下唯一确定的策略管理溢出标注：

**策略与 roadmap §0.5.1 的差异说明**：
- Roadmap §0.5.1 推荐的策略是：在**复合赋值运算符**（`+=`、`-=` 等）上标注 `@OverflowWrapping`，二元算术运算符委托给复合赋值实现，因此二元运算符无需标注。
- **本设计采用相反策略**：在**二元算术运算符**（`+`、`-`、`*`、`/`、`%`）上直接标注 `@OverflowWrapping`，复合赋值由编译器自动生成并继承标注语义。
- **理由**：仓颉的可重载运算符列表**不包含**复合赋值运算符（`+=`、`-=` 等），因此无法在源码中显式定义复合赋值函数，也就无法在其上直接标注 `@OverflowWrapping`。编译器在检测到返回类型与左操作数类型匹配的二元运算符后会自动生成对应的复合赋值版本，且自动生成时继承二元运算符上的 `@OverflowWrapping` 标注。因此将标注置于二元运算符上是唯一可行路径，且与 roadmap 在运行时语义上等价——wrapping 行为覆盖所有算术运算路径（包括复合赋值）。

具体标注分布：

- **二元算术运算符**（`+`、`-`、`*`、`/`、`%`）：在 Vec 结构体内部或 extend 块中定义为 `operator func`（非 `mut`），**直接标注 `@OverflowWrapping`**。`%` 虽整数取模不产生溢出，但标注 `@OverflowWrapping` 保持与所有算术运算符的一致性策略。共 5 个运算符 × 4 个 Vec 类型 = 20 处标注。运算符内部实现逐分量直接运算——不再使用"copy + op="委托模式（因复合赋值不可显式定义）。
- **`<<` 运算符**：在 extend 块中定义为位运算符，**标注 `@OverflowWrapping`**。仓颉中 `<<` 默认使用 `@OverflowThrowing` 策略（移位超出位宽抛 `ArithmeticException`），而 C++ GLM 的 `vec << scalar` 高位丢弃（wrapping 语义）。标注 `@OverflowWrapping` 可对齐行为。共 1 个运算符 × 4 个 Vec 类型 = 4 处标注。
- **`>>` 运算符**：右移不会产生溢出异常，不需要标注。
- **`&`、`|`、`^` 运算符**：按位运算不会产生溢出，不需要标注。
- **`increment()`/`decrement()` 具名函数**：作为 `++`/`--` 的替代，标注 `@OverflowWrapping`。共 2 个函数 × 4 个 Vec 类型 = 8 处标注。
- **复合赋值运算符**（`+=`、`-=`、`*=`、`/=`、`%=`、`<<=`）：由仓颉编译器**自动生成**，不需要也不允许在源码中显式定义。编译器在检测到返回类型与左操作数类型匹配的二元运算符后自动生成对应的复合赋值版本。`@OverflowWrapping` 标注在二元运算符上，自动生成的复合赋值继承 wrapping 语义。
- **浮点类型无需标注**：浮点类型（`Float32`、`Float64`）在仓颉中不会触发溢出异常（浮点溢出产生 `±Infinity` 而非异常），因此 `@OverflowWrapping` 在浮点类型的 Vec 上语义无影响（标注与否行为一致）。首轮采用统一标注的简化策略——在所有 Vec 二元算术运算符上标注，无论 `T` 为何类型。
- **`%` 运算符的溢出行为**：`%` 的溢出行为与 C++ GLM 一致——整数取模不产生溢出（除零仍抛异常）。`@OverflowWrapping` 标注在 `%` 上主要是为了一致性，实际不影响取模运算的语义。

**总结**：`@OverflowWrapping` 在二元算术运算符（5 个：`+`、`-`、`*`、`/`、`%`）、`<<`（1 个）、`increment()`/`decrement()`（2 个）上直接标注，共约 32 处标注 = (5 + 1 + 2) × 4；复合赋值通过编译器自动生成继承标注语义。`@OverflowThrowing` 默认策略对 `>>`、`&`、`|`、`^` 保持原样（这些运算不产生溢出）。无内部矛盾的唯一决策。

**`@OverflowWrapping` 标注继承性验证要求**：当前策略断言编译器自动生成的复合赋值版本继承二元运算符上的 `@OverflowWrapping` 标注（见 §7 D30 验证计划）。该行为未在仓颉文档中明确确认，编码阶段需优先编写原型测试代码进行验证。若验证失败，整体切换到备选方案——所有 Vec 算术运算通过 extend 块中的具名函数实现，在这些具名函数上直接标注 `@OverflowWrapping`，二元运算符委托给这些具名函数。

### 4.7 哈希契约

- Vec 类型实现 `Hashable` 接口。整数/Bool 分量 Vec 使用 `@Derive[Hashable]` 自动派生 `hashCode(): Int64`，其行为约定为：相同 `==` 值的两个 Vec 实例返回相同的 `hashCode()`。
- 浮点分量 Vec **不实现 `Hashable`**，原因见 §3.2 Hashable 实现策略。在哈希集合/映射中使用浮点 Vec 时，调用方需显式包装。
- `hashCode()` 覆盖 Vec 的所有数据分量（Vec1 覆盖 x，Vec2 覆盖 x/y，Vec3 覆盖 x/y/z，Vec4 覆盖 x/y/z/w）。

---

## 5. 错误处理策略

### 5.1 标准错误场景

| 场景 | 策略 |
|------|------|
| 下标越界（`operator[]`） | 在运行时检测索引范围，越界时调用 `assert()` 等效的 `if + throw` 模式。与 C++ `GLM_ASSERT_LENGTH` 行为一致。**注意语义差异**：C++ `GLM_ASSERT_LENGTH` 在 Release 模式下被宏定义移除（编译为空），而仓颉的 `if + throw` 无法通过编译消除（除非使用 `const` 配置常量 + `const if` 在 Release 模式下跳过断言检查）。首轮统一策略：Debug 和 Release 模式下均保留断言检查，Release 模式消除标记为后续轮次任务。 |
| 整数溢出 | 通过在二元算术运算符和 `<<` 运算符上标注 `@OverflowWrapping` 将溢出行为从"抛异常"改为"wrapping"，与 C++ UB 行为在数值结果上等价。`<<` 的默认行为是 `@OverflowThrowing`（超出位宽抛 `ArithmeticException`），标注 `@OverflowWrapping` 后与 C++ GLM 的高位丢弃行为一致。 |
| 除零 | 依赖底层仓颉运行时行为（整数除零抛 `ArithmeticException`，浮点除零返回 `±Inf`）。首轮不添加额外保护层。 |
| 位运算溢出 | `<<` 按 `@OverflowWrapping` 处理；`>>`、`&`、`|`、`^` 无溢出风险，保持默认策略。`increment()`/`decrement()` 按 `@OverflowWrapping` 处理。 |

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
- 接口 + 空结构体：零运行时开销（空结构体的大小为零或极小），类型参数 `Q <: Qualifier` 编译期约束保证了类型安全性。通过 `type` 别名在 `glm` 包中提供常用具现化的简写形式。

### D3. 二元运算符 `@OverflowWrapping` 直接标注 vs 委托模式

**决策**：二元算术运算符直接标注 `@OverflowWrapping`、直接实现逐分量运算；复合赋值由编译器自动生成。

**理由**：v3 中采用"copy + op="委托模式，但仓颉可重载运算符列表中不包含复合赋值运算符（`+=` 等），因此 `mut operator func +=` 无法显式定义。v4 将标注和实现重心从复合赋值移到二元运算符——二元运算符在定义时标注 `@OverflowWrapping`，编译器自动生成复合赋值版本。此方案消除了 v3 中的可行性错误，同时保持 wrapping 语义的精确可控。

关于 roadmap §0.5.1 的差异：roadmap 推荐在复合赋值上标注、二元运算符委托的模式在仓颉中不可行（复合赋值不可显式定义）。本设计采用的"二元运算符直接标注"方案与 roadmap 在运行时语义等价——标注继承机制确保复合赋值自动获得 wrapping 语义，与 roadmap 的最终效果一致。

### D4. 仓颉原生类型名 vs GLM 兼容别名

**决策**：`package glm.detail` 内部直接使用 `Int32`/`Float32` 等仓颉原生类型名；`package glm` 中通过 `type` 别名提供 `int32`/`f32` 等 GLM 兼容命名。

**理由**：`package glm.detail` 是内部实现，应遵循仓颉语言惯例和最佳实践。`package glm` 是公共 API，需保持与现有 GLM 用户代码的兼容性。适当分离内部实现命名和外部接口命名。

### D5. 泛型约束粒度

**决策**：Vec 的 `T` 参数不做紧约束（不要求 `T <: Number<T>`），仅约束 `Q <: Qualifier`。

**理由**：GLM 的 vec 类型在 C++ 中对分量类型几乎不做约束（通过 SFINAE 校验有效性）。在仓颉中若对 `T` 加 `Number<T>` 约束，排除了 `Bool` 类型向量。宽松约束允许编译器在运算符函数体中因类型不支持运算报错，而非在类型定义处报错，与 C++ 模板的延迟检查行为一致。`ComputeEqual` 的浮点判定（`isIec559Of<T>()`）与 `NumericLimits` 的 `Number<T>` 约束解耦后，不再与 D5 冲突——对任意 `T`（含 `Bool`）均可编译通过（详见 D18）。

### D6. GLM_CONFIG_* 配置常量采用 const 声明

**决策**：将 C++ `#define` 宏映射为仓颉 `const` 常量（编译期常量），在 `setup.cj` 中集中声明。首轮所有配置取最保守值。

**理由**：`const` 常量是仓颉编译时求值的基本机制，可被 `if` 分支用于消除死代码（const 求值优化）。**作用域限制**：`const` 常量可用于全局、局部或静态成员（不可在扩展中声明）。`const + if` 的分支消除仅适用于函数体内的内联条件代码——在函数体外部（如顶层类型选择或成员定义）无法使用此模式。因此编译期类型选择（如 `ComputeEqual` 的浮点判定）必须在函数体内通过 `const if` 实现，而非在泛型参数约束或类型定义层面。

**18 个 GLM_CONFIG_* 常量完整清单**（与 v3 一致，子常量均已替换为字面量）：

| GLM 宏名 | 仓颉等效常量名 | 首轮推荐值 | 用途说明 |
|---------|--------------|-----------|---------|
| `GLM_CONFIG_SWIZZLE` | `const GLM_CONFIG_SWIZZLE: Int64` | `2` | 控制 swizzle 操作：0=operator, 1=function, 2=disabled。首轮必须设为 disabled。对应 C++ `GLM_SWIZZLE_DISABLED`=2 |
| `GLM_CONFIG_SIMD` | `const GLM_CONFIG_SIMD: Bool` | `false` | 控制 SIMD 指令集启用。首轮必须设为 false 以避免 `type_vec_simd.inl` 依赖。对应 C++ `GLM_DISABLE` |
| `GLM_CONFIG_ALIGNED_GENTYPES` | `const GLM_CONFIG_ALIGNED_GENTYPES: Bool` | `false` | 控制对齐类型（aligned/packed）。首轮使用非对齐默认布局 |
| `GLM_CONFIG_ANONYMOUS_STRUCT` | `const GLM_CONFIG_ANONYMOUS_STRUCT: Bool` | `false` | 控制匿名 struct 特性。仓颉不支持，首轮禁用 |
| `GLM_CONFIG_UNRESTRICTED_GENTYPE` | `const GLM_CONFIG_UNRESTRICTED_GENTYPE: Bool` | `false` | 控制泛型类型约束松弛。首轮遵循 GLSL 严格约束 |
| `GLM_CONFIG_UNRESTRICTED_FLOAT` | `const GLM_CONFIG_UNRESTRICTED_FLOAT: Bool` | `false` | 控制浮点类型约束松弛。首轮遵循 GLSL 严格约束 |
| `GLM_CONFIG_CLIP_CONTROL` | `const GLM_CONFIG_CLIP_CONTROL: Int64` | `0x0A`（十进制 10） | 裁剪空间约定（LH/RH, NO/ZO 位组合）。对应 C++ `RH_BIT(8) \| NO_BIT(2)` = 0x0A，首轮使用默认 RH_NO |
| `GLM_CONFIG_CONSTEXP` | `const GLM_CONFIG_CONSTEXP: Bool` | `false` | 控制 constexpr 标识函数。仓颉中 `const` 函数编译期求值可替代 |
| `GLM_CONFIG_XYZW_ONLY` | `const GLM_CONFIG_XYZW_ONLY: Bool` | `false` | 控制仅 xyzw 分量命名模式。首轮使用完整 rgba/stpq 命名 |
| `GLM_CONFIG_CTOR_INIT` | `const GLM_CONFIG_CTOR_INIT: Int64` | `0` | 控制构造函数初始化策略。首轮不依赖特定初始化。对应 C++ `GLM_CTOR_INIT_DISABLE`=0 |
| `GLM_CONFIG_DEFAULTED_FUNCTIONS` | `const GLM_CONFIG_DEFAULTED_FUNCTIONS: Bool` | `false` | 控制 C++11 defaulted 函数 |
| `GLM_CONFIG_DEFAULTED_DEFAULT_CTOR` | `const GLM_CONFIG_DEFAULTED_DEFAULT_CTOR: Bool` | `false` | 控制 defaulted 默认构造函数 |
| `GLM_CONFIG_LENGTH_TYPE` | `const GLM_CONFIG_LENGTH_TYPE: Int64` | `1` | 控制 `length_t` 类型选择：1=int（有符号），2=size_t（无符号）。对应 C++ `GLM_LENGTH_INT`=1，首轮使用有符号 Int64 |
| `GLM_CONFIG_PRECISION_BOOL` | `const GLM_CONFIG_PRECISION_BOOL: Int64` | `3` | 控制 bool 类型默认精度等级。对应 C++ `GLM_HIGHP`=3 |
| `GLM_CONFIG_PRECISION_INT` | `const GLM_CONFIG_PRECISION_INT: Int64` | `3` | 控制 int 类型默认精度等级。对应 C++ `GLM_HIGHP`=3 |
| `GLM_CONFIG_PRECISION_UINT` | `const GLM_CONFIG_PRECISION_UINT: Int64` | `3` | 控制 uint 类型默认精度等级。对应 C++ `GLM_HIGHP`=3 |
| `GLM_CONFIG_PRECISION_FLOAT` | `const GLM_CONFIG_PRECISION_FLOAT: Int64` | `3` | 控制 float 类型默认精度等级。对应 C++ `GLM_HIGHP`=3 |
| `GLM_CONFIG_PRECISION_DOUBLE` | `const GLM_CONFIG_PRECISION_DOUBLE: Int64` | `3` | 控制 double 类型默认精度等级。对应 C++ `GLM_HIGHP`=3 |

18 个常量集中在 `setup.cj` 中声明。首轮所有 `GLM_CONFIG_*` 取最保守值（如 `SIMD=false`、`SWIZZLE=2`），确保最小依赖闭合。`setup.cj` 不包含类型别名或 `assert` 函数（分别归入 `shim_cstddef.cj` 和 `shim_assert.cj`）。

**子常量编码策略**：上表中所有 C++ 宏常量（`GLM_SWIZZLE_DISABLED`、`GLM_DISABLE`、`GLM_HIGHP`、`GLM_LENGTH_INT`、`GLM_CTOR_INIT_DISABLE`、`RH_BIT(8)`、`NO_BIT(2)` 等）在首轮 `setup.cj` 中**统一采用字面量替换**，不定义对应的独立命名常量。理由：① 这些 C++ 宏在 GLM 中为 `#define` 整数值，在其余首轮源代码中不被直接引用（`GLM_CONFIG_*` 值仅在 `setup.cj` 中定义，首轮 Vec 运算符不依赖 C++ `GLM_ARCH`/`GLM_HAS_CONSTEXPR` 等检测宏的值）；② 后续轮次引入平台检测或 SIMD 路径时，如需引用这些子常量对应值，可在对应轮次的 `setup.cj` 更新中补充命名常量定义；③ 字面量直接写在配置表中，编码阶段无需查找外部宏定义即可获得完整常量值。

**`GLM_CONFIG_CLIP_CONTROL` 类型选择**：采用 `Int64` 而非自定义 enum。该配置值为位掩码（由 `LH_BIT`/`RH_BIT`/`ZO_BIT`/`NO_BIT` 按位或组合），`Int64` 类型直接匹配位运算语义。C++ GLM 中该宏定义为整数 `#define` 常量值的组合，映射到 `Int64` 是最直接的一对一对应。

### D7. Functor 不直接映射 C++ `<functional>` 中的 `std::plus<T>` 等

**决策**：functor 的 `call` 方法直接接受 lambda 或函数引用作为参数，不引入 `std::plus` 等函数对象的直接等效。

**理由**：仓颉无 `std::plus`，但函数类型 `(T, T) -> T` 和 lambda 表达式可直接作为参数传递。泛型 functor 接收 `F: (T, T) -> T` 类型的函数参数即可。对比 C++ 需要 `std::plus<T>`（一个标准函数对象类型），仓颉更简洁——直接在调用点使用 `{ a, b => a + b }` 或运算符引用。

### D8. var 数据成员对 let 绑定变量的影响

**决策**：Vec 结构体的数据成员全部声明为 `var`（无初始值）。

**理由**：编译器自动生成的复合赋值运算符需要能够修改 Vec 实例的成员。若使用 `let` 声明成员，则即使通过 `var` 绑定的结构体变量也无法执行复合赋值（`var` 绑定允许调用 `mut` 函数，但 `mut` 函数不能修改 `let` 成员）。将数据成员声明为 `var`，使得 `var v = Vec2(...)` 可以正常执行 `v += 1` 等自动生成的复合赋值。对于 `let v = Vec2(...)` 的变量，复合赋值触发编译错误，这与 C++ 中 `const` 向量不能执行 `op=` 的行为一致。

数据成员无初始值的决定：避免为默认构造函数引入不合理的约束。调用方需显式构造，使用标量填充构造 `Vec2(T(0))` 作为默认值替代。

### D9. `!=` 运算符的实现形态

**决策**：`!=` 定义为 `!(a == b)`。

**理由**：仓颉语言中不存在 `!==` 运算符。将 `!=` 重载为对 `==` 结果取反的语义是最直接且正确的实现。这一实现与 C++ GLM 中 `operator!=` 的语义等价。

### D10. 标量在左的运算无法重载

**决策**：不支持 `scalar + vec`、`scalar / vec` 等左标量右向量的运算符重载形式，以具名函数替代。

**理由**：仓颉的运算符重载要求运算符函数定义在左操作数类型的作用域内。标量类型（如 `Float32`）的 `+` 运算符无法由本包通过 `extend` 扩展（标量类型本身不在此包中定义，且扩展运算符重载也不被允许创建新的重载覆盖原生类型已有运算符）。因此 `scalar + vec` 模式不可实现。提供 `add(scalar, vec)` 和 `add(vec, scalar)` 双向具名函数覆盖两种操作数顺序。同样，`div`、`sub`、`mul`、`mod` 等也需提供双向重载。

### D11. 引入 `const init` 支持编译期分支

**决策**：为每个 Vec 结构体定义 `const init` 构造函数，移除与 `const init` 参数列表相同的普通 `init`。

**理由**：仓颉语言要求仅当 struct 定义了 `const init` 时，才能定义 `const` 实例成员函数。`const` 实例成员函数（如 `==`）可以在函数体内使用 `const if` 实现编译期分支，零运行时开销地选择浮点容差比较路径或精确比较路径。`const init` 在非 const 上下文中同样可用于运行时构造（const README §3.2 规则 5），因此同参数列表的普通 `init` 不再需要。仓颉函数重载规则中 `const` 修饰符不构成区分依据（const README §3.2 规则 7），若同时保留二者将导致重复定义编译错误。移除冗余额外的普通 `init`，仅保留 `const init` 即可覆盖所有构造场景。

### D12. `&&`/`||`/`~` 以具名函数替代运算符重载

**决策**：`&&`、`||`、`~` 不可作为运算符重载，以具名函数 `logicalAnd`、`logicalOr`、`bitwiseNot` 替代。

**理由**：仓颉可重载运算符列表为：`()`、`[]`、`!`、`-`（一元）、`**`、`*`、`/`、`%`、`+`、`-`（二元）、`<<`、`>>`、`<`、`<=`、`>`、`>=`、`==`、`!=`、`&`、`^`、`|`。该列表不包含 `&&`、`||`、`~`，因此无法为 Vec 类型重载这些运算符。具名函数在语义上等价，且可通过函数重载支持多参数形式。

### D13. `%` 运算符的可用性约束

**决策**：`%` 在 Vec 结构体上定义为逐分量取模运算符。对于整数 `T` 实例正常编译；对于浮点 `T` 实例在实例化时产生编译错误（因仓颉原生浮点类型不支持 `%`）。

**理由**：采用 D5 的宽松约束策略——`T` 在 Vec 结构体上不做紧约束，`%` 运算符体中使用 `T % T` 表达式。编译器在定义处通过语法检查，在实例化处验证语义。此行为与 C++ 模板的延迟检查一致（`std::vector<float> v; v % v;` 在 C++ 中同样在实例化处报错）。对于需要浮点取模的场景，使用具名函数方案（不属于首轮范围）。

### D14. 跨 Vec 类型转换不使用子类型约束

**决策**：跨 Vec 转换构造不使用 `where T2 <: T` 约束，改用无约束泛型 + `T(v)` 显式转换。

**理由**：仓颉原始数值类型间不存在子类型关系。`Int8` 不是 `Int32` 的子类型，因此 `where T2 <: T` 约束无法用于数值类型的跨类型 Vec 构造。改为无约束泛型参数，在构造函数体内对各分量调用 `T(v2.x)` 等显式类型构造函数，由仓颉的类型构造函数转换规则处理数值类型间的转换。这种方式的语义与 C++ `static_cast` 更为一致。

### D15. 跨类型运算不支持

**决策**：二元运算符不支持跨类型操作数（如 `Vec2<Int32> + Vec2<Int16>`）。

**理由**：仓颉运算符重载不能为泛型（不能引入新类型参数）。Vec 的 `operator +` 只能接受 `VecN<T, Q>` 类型的右操作数（`T` 和 `Q` 与左操作数相同）。对于跨类型运算，调用方必须使用跨 Vec 转换构造函数先将操作数转为同一类型。此限制在迁移时需通过搜索替换规则处理（详见 §11 迁移成本评估）。

### D16. Functor/ComputeVec 首轮仅定义不消费

**决策**：`vectorize.cj` 和 `compute_vector_decl.cj` 中的类型在首轮仅定义结构体，不被 Vec 运算符实现调用。

**理由**：首轮 Vec 运算符实现直接使用泛型算术运算符逐分量运算，无需通过 ComputeVec* 或 Functor 委托。Functor 和 ComputeVec 为后续 SIMD 轮次、swizzle 操作轮次或性能优化轮次预留。首轮定义它们可以尽早验证其在仓颉类型系统中的可行性，但运算符代码不引用它们。后续轮次引入 SIMD 路径时，可将 Vec 运算符实现重构为通过 ComputeVec* 委托，利用 Functor 实现函数映射。

### D17. 跨类型赋值语义

**决策**：不提供跨类型 `=` 赋值（`VecN<Int32, Q> = VecN<Float32, Q>`）。跨类型赋值要求调用方显式使用跨 Vec 转换构造函数转换后赋值。

**理由**：仓颉 struct 的 `=` 赋值运算符由编译器自动生成，且仅接受完全相同类型的右操作数。无法为 Vec 泛型结构体重载自定义 `=` 以支持跨类型赋值。三种候选方案中：① 显式转换后赋值（采用）——调用方编写 `v = Vec2<Int32, Q>(w)` 将 `Vec2<Float32, Q>` 转换为 `Vec2<Int32, Q>` 后再赋值，转换语义清晰无歧义；② 定义泛型 `=` ——仓颉运算符不能为泛型，不可行；③ 记录为已知差异——在迁移成本评估中标注此差异。选用方案①，因为语义最明确且与 D14（跨 Vec 转换构造）和 D15（跨类型运算不支持）的设计一致。

### D18. `NumericLimits` 与宽松泛型约束的兼容性

**决策**：将 `NumericLimits<T>` 拆分为两个独立部分——保留 `NumericLimits<T> where T <: Number<T>` 用于数值极限查询，新增无约束的 `isIec559Of<T>()` 函数用于浮点类型判定。

**理由**：`ComputeEqual<T>` 的 `const if (isIec559Of<T>())` 需要在不约束 `T` 的前提下判断 `T` 是否为浮点类型。若使用 `where T <: Number<T>` 约束，`Bool` 作为 `T` 时将编译失败（`Bool` 不实现 `Number<T>`）。将 `isIec559` 分离为独立的无约束函数，与 `NumericLimits` 的 `max()`/`min()`/`epsilon()` 等需要数值运算支持的功能解耦。此拆分后，`NumericLimits<T>` 仅在需要数值极限的浮点路径中被引用（由 `const if` 在编译期已排除非浮点分支），因此 `Number<T>` 约束在浮点 `T` 上自然满足，不会产生编译错误。

### D19. `isIec559Of<T>()` 的实现方案选择

**决策**：采用 `const if` 配合 `is` 运算符的值级类型检测方案。

**理由**：仓颉泛型函数的重载规则禁止按类型参数约束进行重载（类型变量约束不参与重载解析判断），因此 v5 描述的"为每类数值类型提供重载函数"的路径不可行。三种可行方案的分析：

| 方案 | 描述 | 评估 |
|------|------|------|
| ① `const if` + `is` 运算符值级检测（采用） | `const if (T(0) is Float64 \|\| T(0) is Float32)` | 无重载依赖，完全在仓颉 const 表达式约束内——`is` 属于可参与 const 表达式的运算符，`T(0)` 为合法的 const 构造表达式（数值/布尔类型的构造函数在 const 上下文中可用）。编码阶段需验证所有目标类型是否支持 `T(0)` const 构造。 |
| ② 放弃编译期分支 | 所有类型统一使用 `==` 精确比较 | 功能正确但丢失浮点容差比较优势。可作为备选回退路径。 |
| ③ 反射或注解方式 | 运行时通过 `TypeInfo` 或自定义注解实现 | 引入运行时开销，背离编译期零开销的设计目标。 |

采用方案①，理由：保持编译期零开销类型分发，不依赖语言尚未确认的特性，实现模式与 `const if` 的现有语义一致。

### D28. `operator[]` 赋值形式须为 `mut` 函数

**决策**：`operator[]` 的赋值形式需声明为 `mut operator func`。

**理由**：仓颉 struct 的普通（非 `mut`）实例成员函数不能修改实例成员。`operator[]` 赋值形式需要修改第 i 分量的值，因此必须标注 `mut` 修饰符。否则 `v[i] = val` 将无法编译通过（struct 的 `let` 绑定变量上调用 `mut` 函数报错，`var` 绑定变量上调用非 `mut` 函数无法修改成员）。此规则同样适用于 extend 块中定义的 `[]` 赋值形式——extend 块中的 `operator func []` 赋值形式同样需要 `mut` 修饰符方可修改实例成员。

### D29. `const operator ==` 的表达式链 const 兼容性要求

**决策**：`ComputeEqual<T>.callConst` 中 `const operator ==` 的完整表达式链需系统性标注每项的 const 兼容性。

**理由**：`const operator ==` 体内表达式链 `abs(a - b) <= epsilonOf<T>()` 的每个环节必须支持在 `const` 函数上下文中编译通过。各环节的 const 兼容性要求及验证状态如下：

| 表达式环节 | const 兼容性要求 | 验证状态 | 回退方案 |
|-----------|----------------|---------|---------|
| `a - b`（浮点减法） | 仓颉 `Float32`/`Float64` 的二元 `-` 可在 const 函数体内调用 | 待验证（需原型测试） | 若不可用，使用备选路径（所有类型精确比较 `a == b`） |
| `abs(x)`（绝对值） | `Float32.abs()` / `Float64.abs()` 静态方法须为 `const` 函数 | 待验证（需原型测试） | 若不可用，内联绝对值逻辑（`x >= T(0) ? x : -x`，其中 `x >= T(0)` 在 const 上下文中可用） |
| `epsilonOf<T>()`（获取 epsilon） | `NumericLimits<T>.epsilon()` 须为 `const` 函数。且 `NumericLimits<T> where T <: Number<T>` 的约束在此路径中自动满足（`const if` 确保仅浮点类型进入此分支） | 待验证（需原型测试） | 若不可用，使用固定容差值（如 `T(1e-6)`）替代 `epsilon()` |
| `result <= epsilon`（比较） | `Float32`/`Float64` 的 `<=` 可在 const 函数体内调用 | 可确认（仓颉 `<=` 为原生比较运算符，在 const 上下文中可用） | 无 |
| `T(0) is Float64`（编译期类型检测） | 数值类型的 `T(0)` const 构造 + `is` 运算符 | 待验证（需原型测试，见 §10 编码前验证要求） | 若 `T(0)` const 构造不可用，使用备选路径（所有类型精确比较 `a == b`）；或改用重载方案（若后续仓颉支持） |

**验证计划**：在编码阶段编写原型测试函数，在 `const` 上下文中逐一测试上述表达式链中各环节的编译通过性。若任一环节 const 兼容性不满足，则整体回退到备选路径（所有类型使用精确比较 `a == b`），浮点容差比较通过独立的非 `const` 具名函数（如 `equalEpsilon`）提供。

### D30. `@OverflowWrapping` 标注继承性验证计划

**决策**：在 §4.6 中补充备选方案——若 `@OverflowWrapping` 标注继承性经验证不成立，则通过 extend 块中的具名函数实现 Vec 算术运算。

**理由**：当前设计断言编译器自动生成的复合赋值版本继承二元运算符上的 `@OverflowWrapping` 标注。此行为未在仓颉文档中明确确认，属于对编译器实现行为的推测。因此需要：
1. **编码前验证**：编写原型测试代码，验证二元算术运算符上的 `@OverflowWrapping` 标注是否能被编译器自动生成的复合赋值版本继承。测试核心：对自定义 struct 定义标注 `@OverflowWrapping` 的 `+` 运算符，验证 `+=` 在溢出时执行 wrapping 而非 throwing。
2. **备选方案（若继承性不成立）**：所有 Vec 算术运算通过 extend 块中的具名函数（如 `add`、`sub`、`mul`、`div`）实现，在这些具名函数体内标注 `@OverflowWrapping`。此方案虽失去运算符语法糖，但确保溢出语义精确可控。二元运算符可委托给这些具名函数实现，但需接受运算符本身无法直接标注 `@OverflowWrapping`（复合赋值也无法自动标注）的约束。

**决策路径**：原型验证优先。若标注继承性成立，维持当前设计（二元运算符直接标注，复合赋值自动继承）。若不成立，切换到备选方案（具名函数 + 运算符委托）。

### D31. 跨类型 fill-from-Vec1 构造器的重载冲突约束

**决策**：Vec2~Vec4 的 fill-from-Vec1 构造器仅提供同类型版本 `public init(v: Vec1<T, Q>)`，不提供跨类型版本 `public init<T2, Q2>(v: Vec1<T2, Q2>)`。

**理由**：仓颉函数重载规则中，当泛型参数被实例化为具体类型时，重载解析按实际类型匹配。若同时存在 `public init(v: Vec1<T, Q>)` 和 `public init<T2, Q2>(v: Vec1<T2, Q2>) where Q2 <: Qualifier`，在 `T2 = T` 且 `Q2 = Q` 的场景下两个构造函数具有相同的参数列表（`Vec1<T, Q>`），导致重载冲突编译错误。受仓颉泛型实例化的重载解析规则限制，此冲突无法通过添加额外泛型约束（如 `where T2 != T`）解决——仓颉的 `where` 子句不支持否定约束或不等约束。

因此当前设计仅保留同类型版本，跨类型 fill-from-Vec1 场景可通过其他构造函数形式覆盖（如 Vec4 可通过 `Vec4(v1_x, v1_y, v1_z, v1_w)` 组合构造或通过 `init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>, ...)` 等形式间接实现）。若编码阶段需要跨类型 fill-from-Vec1 构造，可通过将 Vec 类型变量显式转换为目标类型后调用同类型版本实现（`let v = Vec2<T, Q>(Vec2<T2, Q2>(src).x)` 等模式）。

### D20. `VecN<Bool, Q>` 的完整行为约定集中化

**决策**：在 §3.2 中集中描述 `VecN<Bool, Q>`（指 Vec1~Vec4 分别以 Bool 为 T 参数的实例）的完整行为约定，各运算符章节仅引用之。

**理由**：Bool 分量 Vec 在不同运算符类别中表现出不同的行为模式（部分可编译、部分不可编译），分散描述易导致遗漏或矛盾。统一在 Vec 结构体系的总体描述中给出完整表格，各运算符章节以"详见 §3.2 VecN<Bool, Q> 行为约定"方式引用，确保一处定义、各处同步。

### D21. `operator[]` 索引类型选择

**决策**：索引类型统一采用 `Int64`。

**理由**：① `LengthT` 别名为 `Int64`，`length()` 返回值也是 `Int64`，保持一致避免有符号/无符号比较告警；② `Int64` 为仓颉默认整数类型，在所有目标平台上覆盖所有有效索引范围（Vec1~Vec4 的索引 0~3）；③ 与 GLM 默认 `length_t = int`（有符号整数）行为一致。

### D22. `<`/`<=`/`>`/`>=` 运算符首轮不提供

**决策**：首轮不定义 `<`/`<=`/`>`/`>=` 运算符。

**理由**：C++ GLM 的 Vec 类型上未定义这些运算符。若在仓颉中定义则需要决定语义是聚合比较还是逐分量比较——前者与 GLM 行为不一致，后者在仓颉中（返回 `VecN<Bool, Q>`）无法直接用于 `if` 条件。首轮保留 `==` 和 `!=`（返回 `bool` 的聚合比较），逐分量比较功能随后续函数库轮次（`vector_relational.hpp` 的 `lessThan`/`greaterThan` 等具名函数）一并迁移。

### D23. C++ `storage<L,T,Q>` 模板省略理由

**决策**：首轮不映射 `storage<L,T,Q>` 模板结构体。

**理由**：`storage` 是 C++ 中用于在不同条件下（非对齐/对齐/SIMD）选择底层数据类型的辅助类型。仓颉 Vec 结构体的数据成员直接声明为 `var x: T` 等形式，编译器自动负责内存布局和对齐，无需手动选择存储类型。`storage` 的 SIMD 特化路径待后续 SIMD 支持轮次时重新设计。

### D24. `genTypeTrait`/`find_best_type` 等辅助设施省略理由

**决策**：首轮不迁移 `genTypeTrait`、`init_gentype`、`find_best_type` 等类型查询设施。

**理由**：这些设施服务于矩阵和四元数类型的泛型代码（如 `init_gentype` 为矩阵和四元数提供 `identity()` 方法），首轮范围不包含这些类型。这些辅助设施将在第 2-3 轮（矩阵/四元数迁移）时随对应类型定义一并引入。首轮 `qualifier.cj` 中保留 `vec`/`mat`/`qua` 的注释性前向声明即可。

---

## 8. 迁移文件清单与依赖拓扑

### 8.1 文件清单与 roadmap 子范围映射

| 序号 | 文件（package glm.detail） | 依赖 | 说明 | Roadmap 子范围 | Roadmap §3E 序号 |
|------|---------------------------|------|------|---------------|-----------------|
| 1 | `setup.cj` | 无 | 18 个 `GLM_CONFIG_*` 编译期常量 | S | S1（前身为 C++ `setup.hpp` 映射，shim 配置层） |
| 2 | `qualifier.cj` | `setup.cj` | `Qualifier` 接口及实现类型、V 前向声明注释 | 1 | 2 |
| 3 | `shim_assert.cj` | 无 | `assert()` 函数 | S | S1 |
| 4 | `shim_limits.cj` | 无 | `NumericLimits<T>`（含 `isIec559Of<T>()` 无约束 const 函数，`max/min/epsilon` 受 `Number<T>` 约束） | S | S2 |
| 5 | `shim_cstddef.cj` | 无 | `SizeT`/`LengthT` 别名（`VArray` 的 `size` 属性提供编译期长度查询） | S | S3 |
| 6 | `compute_vector_relational.cj` | `shim_cstddef.cj` + `shim_limits.cj` | `ComputeEqual<T>`（简化版，无 `IsFloat` 参数） | 2a | 3 |
| 7 | `vectorize.cj` | `qualifier.cj` | Functor1~4 的 Vec1~Vec4 版本（为后续轮次预留） | 2a | 5 |
| 8 | `compute_vector_decl.cj` | `vectorize.cj` | ComputeVecAdd/Sub/Mul/Div/...（为后续轮次预留） | 2a | 4 |
| 9~12 | `type_vec1.cj`~`type_vec4.cj` | `qualifier.cj` + `compute_vector_relational.cj` | Vec 结构体定义（含 `const init`、`@OverflowWrapping` 二元算术运算符、`@OverflowWrapping` 对 `<<`）、extend 块（位运算符 + 具名函数 `increment`/`decrement`/`bitwiseNot`/`logicalAnd`/`logicalOr`） | 4~7 | 6~9 |

| 序号 | 文件（package glm） | 依赖 | 说明 | Roadmap 子范围 | Roadmap §3E 序号 |
|------|--------------------|------|------|---------------|-----------------|
| 13 | `lib.cj`（新增） | `glm.detail.*` | 公共 API 重导出——通过 `public import` 暴露 Vec 类型和 Qualifier 类型 | 8（随向量别名） | 新增 |
| 14 | `fwd.cj` | `glm.detail.*` | 标量别名（含 `uint`）+ 256 个向量别名 | 2b（标量部分）+ 8（向量部分） | 10（标量部分）+ 11（向量部分） |

### 8.2 范围可追溯性对照表

以下对照表将 roadmap §3E/§3G 定义的首轮范围逐项映射到本设计的对应章节和迁移文件，确保无范围歧义或遗漏：

| Roadmap §3E 序号 | Roadmap 子范围 | GLM 源文件 | 本设计对应章节 | 本设计对应仓颉文件 | 偏离说明 |
|-----------------|--------------|-----------|--------------|----------------|---------|
| 1 | 1 | `setup.hpp` | §3.6 Shim 层、§7 D6 | `setup.cj` | 无偏离。C++ `setup.hpp` 中 1000+ 行平台/编译器检测宏首轮不迁移，仅迁移约 80-120 行配置常量（详见 roadmap 3A.1 说明）。此偏离已在 roadmap 中预声明 |
| 2 | 1 | `qualifier.hpp` | §3.1 Qualifier 体系 | `qualifier.cj` | 无偏离。C++ `storage<L,T,Q>` 模板在首轮无需映射（D23），`genTypeTrait`/`find_best_type` 等辅助设施已推迟至后续轮次（D24） |
| 3 | 2a | `compute_vector_relational.hpp` | §3.5 ComputeEqual | `compute_vector_relational.cj` | 无偏离。简化版 `ComputeEqual<T>` 移除 `IsFloat` 参数 |
| 4 | 2a | `compute_vector_decl.hpp` | §3.4 ComputeVec* 运算策略体系 | `compute_vector_decl.cj` | 无偏离。首轮仅定义类型，不被 Vec 运算符消费（D16） |
| 5 | 2a | `_vectorize.hpp` | §3.3 Functor 体系 | `vectorize.cj` | 无偏离。按分量数拆分 functor（4 × 4 = 16 个定义），首轮仅定义不消费（D16） |
| 6 | 4 | `type_vec1.hpp` + `type_vec1.inl` | §3.2 Vec 结构体系、§4 关键行为契约 | `type_vec1.cj` | 无偏离 |
| 7 | 5 | `type_vec2.hpp` + `type_vec2.inl` | §3.2 Vec 结构体系、§4 关键行为契约 | `type_vec2.cj` | 无偏离 |
| 8 | 6 | `type_vec3.hpp` + `type_vec3.inl` | §3.2 Vec 结构体系、§4 关键行为契约 | `type_vec3.cj` | 无偏离。`.inl` 中 `#if GLM_CONFIG_SIMD` 条件包含 `type_vec_simd.inl` 由 `GLM_CONFIG_SIMD=false` 消除 |
| 9 | 7 | `type_vec4.hpp` + `type_vec4.inl` | §3.2 Vec 结构体系、§4 关键行为契约 | `type_vec4.cj` | 无偏离。同上 SIMD 条件分支消除 |
| 10 | 2b | `fwd.hpp` 标量别名部分（第 1-178 行） | §3.7 标量类型别名 | `fwd.cj`（标量别名部分） | 无偏离 |
| 11 | 8 | `fwd.hpp` 向量别名部分（第 180-507 行） | §3.8 向量类型别名 | `fwd.cj`（向量别名部分） | 无偏离。256 个别名全量定义，与 roadmap §3C 一致 |
| S1 | S | `<cassert>` shim | §3.6 Shim 层 | `shim_assert.cj` | 无偏离。新增仓颉 shim 文件 |
| S2 | S | `<limits>` shim | §3.6 Shim 层 | `shim_limits.cj` | 无偏离。新增仓颉 shim 文件 |
| S3 | S | `<cstddef>` shim | §3.6 Shim 层 | `shim_cstddef.cj` | 无偏离。新增仓颉 shim 文件 |
| — | 8（新增） | —（新增） | §2 模块划分 | `lib.cj` | **偏离说明**：新增 `lib.cj` 用于 `public import` 重导出核心类型。此文件不在 roadmap 原始清单中，但为满足公共 API 面封装性而新增，不引入新的类型定义或依赖，不影响范围完整性和依赖闭合性 |

### 8.3 迁移顺序与依赖说明

**迁移顺序**：1 + 3 + 4 + 5（基础设施，可并行）→ 2（qualifier）→ 6 + 7（辅助工具，可并行）→ 8（运算策略）→ 9~12（Vec 类型，可并行）→ 13（lib.cj）+ 14（fwd.cj 别名）。

**依赖说明**：
- `setup.cj` 包含 18 个 `GLM_CONFIG_*` 编译期常量定义，**不包含** `assert` 函数（归入 `shim_assert.cj`）或 `LengthT`/`SizeT` 类型别名（归入 `shim_cstddef.cj`）。
- `shim_cstddef.cj` 无任何依赖，与 `setup.cj` 无重叠职责。
- `VArray<T, $N>` 的 `size` 属性提供编译期长度查询，等效于 C++ 中的元素计数宏。`$N` 必须为固定数值字面量，不可声明为值泛型参数。
- `compute_vector_relational.cj` 定义简化后的 `ComputeEqual<T>`（无 `IsFloat` 参数）。
- `vectorize.cj` 和 `compute_vector_decl.cj` 首轮仅定义类型，不被 Vec 运算符消费。

---

## 9. 异常场景和边界条件补充

### 9.1 零向量相关行为

| 场景 | 行为约定 |
|------|---------|
| 零向量定义 | 所有分量为 `T(0)` 的 Vec 实例。对整数类型（`Int8`~`Int64`、`UInt8`~`UInt64`）和浮点类型（`Float32`/`Float64`）及 `Bool`（`false`）均适用。 |
| 零向量参与算术运算 | 零向量 + 向量 = 向量（与加法单位元一致）。零向量 - 向量 = 取负后的向量。零向量 × 标量 = 零向量。零向量 / 标量 = 零向量（除零情况按 §9.2 约定）。 |
| 零向量逐分量比较 | `ComputeEqual<T>` 在 `const if` 路径下对整数类型通过 `==` 直接比较，对浮点类型通过容差比较。零向量与自身比较始终返回 `true`。 |
| 零向量标准化 | 首轮不实现 `normalize` 函数。标准化场景中的零向量处理约定推迟到后续轮次定义。 |

### 9.2 除零行为

| 场景 | 行为约定 |
|------|---------|
| 整数 Vec / 标量 0 | 仓颉运行时抛 `ArithmeticException`（整数除零）。Vec 运算符不做预防性检查。 |
| 浮点 Vec / 标量 0 | 仓颉运行时返回 `±Inf`（IEEE 754 默认行为）。Vec 运算符不做预防性检查。 |
| Vec / Vec（全零分量） | 逐分量运算，每个分量独立按标量规则处理。 |
| Vec % 0（取模除零） | 整数取模除零抛 `ArithmeticException`。浮点 Vec 实例在编译期即因 `%` 不支持浮点类型而报错（§4.3 整数约束）。 |
| 零向量 / 零标量 | 与"任意向量 / 零标量"行为一致（整数抛异常，浮点返回 `±Inf`/`NaN`）。 |

### 9.3 NaN/Infinity 传播

| 场景 | 行为约定 |
|------|---------|
| NaN 参与算术运算 | 所有算术运算直接委托给仓颉原生浮点运算，严格遵循 IEEE 754 标准：`NaN + x = NaN`，`NaN - x = NaN`，`NaN * x = NaN`，`NaN / x = NaN`。 |
| NaN 参与比较运算 | `ComputeEqual` 的浮点容差比较路径使用 `abs(a - b) <= epsilonOf<T>()`。`NaN - x = NaN`，`abs(NaN) = NaN`，`NaN <= epsilon` 为 `false`，因此 `NaN == x`（对任意 x，含 NaN 自身）均返回 `false`。此行为与 IEEE 754 标准一致。 |
| Infinity 参与算术运算 | `Inf + Inf = Inf`，`Inf - Inf = NaN`，`Inf * 0 = NaN`，`Inf / Inf = NaN`，`Inf + finite = Inf`。严格遵循 IEEE 754 标准。 |
| Infinity 参与比较运算 | 浮点容差比较路径下，`Inf - Inf = NaN`，`abs(NaN) = NaN`，`NaN <= epsilon` 为 `false`。因此 `Inf == Inf` 在容差比较路径下返回 `false`（IEEE 754 标准行为：`Inf == Inf` 在 `==` 运算符层面返回 `true`，但在容差路径下因减法表达式产生 NaN 而被误判）。此为容差比较路径的已知局限性。改进方案：在容差比较前先通过 `Float64.isNaN(a)` / `Float64.isInfinite(a)` 运行时检测（或 `const` 函数中通过 `const if` 编译期判断）对特殊值进行预检，若为 NaN/Infinity 则回退到仓颉原生 `==` 直接比较。首轮约定：容差路径适用于有限值范围内的浮点比较，NaN/Infinity 的比较行为以 IEEE 754 默认规则为准（`Inf == Inf` 在容差路径下预期返回 `false`）。若需精确比较，使用备选路径（所有类型精确比较 `==`）或调用方自行通过 `Float64.isNaN()` 等确认特殊值。 |
| `NumericLimits<T>.epsilon()` 与 Infinity | `epsilon()` 的语义：对于浮点分量的容差比较，`epsilonOf<T>()` 返回 `epsilon() * magnitude` 的缩放容差。当 `a` 或 `b` 为 `Inf`/`NaN` 时，缩放容差计算可能产生 `Inf` 或 `NaN`，导致比较结果不稳定。首轮约定：`ComputeEqual` 的容差路径适用于有限值范围内的浮点比较。Infinity/NaN 的相等性判断回退到仓颉原生 `==`（调用方可通过 `equalEpsilon` 具名函数获取更精确的控制，不属于首轮范围）。 |

### 9.4 类型转换边界

| 转换场景 | 行为约定 |
|---------|---------|
| 整数宽度提升 | `Int8 → Int16 → Int32 → Int64` 等，无精度损失。 | 
| 整数宽度截断 | `Int64 → Int32 → Int16 → Int8` 等，高位截断。仓颉运行时在 Debug 模式可能产生溢出检测，但在 `@OverflowWrapping` 标注下截断语义与 C++ 隐式转换一致。 |
| 无符号 ↔ 有符号互转 | `UInt32 → Int32` 等。仓颉的类型构造函数直接处理。超出有符号范围的值按 wrapping 语义截断。 |
| 浮点 → 整数 | `Float64 → Int32` 等。仓颉的类型构造函数对溢出值抛 `ArithmeticException`。C++ 中此场景是 UB。设计约定：迁移代码中若涉及浮点到整数的 Vec 转换，应在调用处确保值在目标类型的表示范围内，或通过 `clamp` 等辅助函数处理（不属于首轮范围）。 |
| 整数 → 浮点 | `Int32 → Float32` 等。大整数可能因浮点精度限制而损失精度（`Float32` 的 mantissa 为 23 位，无法精确表示超过 2^24 的整数）。此行为与 C++ 隐式转换一致，不做特殊处理。 |
| 浮点宽度提升/截断 | `Float32 ↔ Float64`。宽度提升无损，宽度截断可能损失精度。 |
| `Bool` → 数值 | 跨 Vec 转换构造中 `Bool` 不可直接转换为数值类型（仓颉中 `Int32(Bool)` 可能不被支持）。非首轮范围——首轮 `Bool` 类型的 Vec 不参与跨类型数值转换。若需此功能，在构造函数中通过 `if` 分支显式处理（`true → T(1)`，`false → T(0)`）。 |
| `Vec1` → `Vec2`/`Vec3`/`Vec4` | 所有分量取 `Vec1` 的单一分量值。适用于标量传播构造场景。 |

---

## 10. `isIec559Of<T>()` 取值对照表

`isIec559Of<T>()` 在 `shim_limits.cj` 中以 `const` 泛型函数形式实现，函数体内使用 `const if` 配合 `is` 运算符进行编译期类型检测。各类型取值如下：

| 类型 | `isIec559Of` 值 | 说明 |
|------|--------------|------|
| `Int8` | `false` | 整数类型，非 IEC 559 |
| `Int16` | `false` | 整数类型，非 IEC 559 |
| `Int32` | `false` | 整数类型，非 IEC 559 |
| `Int64` | `false` | 整数类型，非 IEC 559 |
| `UInt8` | `false` | 整数类型，非 IEC 559 |
| `UInt16` | `false` | 整数类型，非 IEC 559 |
| `UInt32` | `false` | 整数类型，非 IEC 559 |
| `UInt64` | `false` | 整数类型，非 IEC 559 |
| `Float16` | `false` | 半精度浮点，类型身份检测已排除（简化策略，首轮不纳入 `isIec559Of` 判断） |
| `Float32` | `true` | IEC 60559 单精度（需验证仓颉运行时符合性） |
| `Float64` | `true` | IEC 60559 双精度（需验证仓颉运行时符合性） |
| `Bool` | `false` | 布尔类型，非 IEC 559。`isIec559Of<Bool>()` 通过 `const if` 的 `else` 分支返回 `false` |

**实现方式**：
```cangjie
  const func isIec559Of<T>(): Bool {
      const if (T(0) is Float64 || T(0) is Float32) { true } else { false }
  }
```
该函数为单一泛型函数，不涉及重载或特化。编译期实例化时，`T(0) is Float64` 等表达式在 const 上下文中求值，零运行时开销。

**注**：C++ `is_iec559` 判断类型是否完全符合 IEEE 754 标准。仓颉的 `Float32`/`Float64` 预期符合 IEC 60559（IEEE 754），但此符合性需在目标平台上验证。若平台浮点实现有偏差，`isIec559Of<Float32>()`/`isIec559Of<Float64>()` 应回退到 `false` 以使用精确比较路径。当前设计保持编译期判断，若需运行时动态判断则需改为反射方案（不属于首轮范围）。

**编码前验证要求**：`isIec559Of<T>()` 的 `const if (T(0) is Float64 || T(0) is Float32)` 方案依赖两个假设——① `T(0)` 在 const 上下文中对所有目标类型（`Int32`、`Float32`、`Bool` 等）合法；② `is` 运算符在 const 泛型函数中可参与编译期求值。虽然 `is` 在 const 表达式列表中确认可用，但泛型 `T` 的 `T(0)` 构造在 const 上下文中的统一合法性需在目标编译器上验证。**建议**：在编码阶段优先编写 `isIec559Of<T>()` 的原型测试代码，针对 `T = Int32`、`Float32`、`Bool` 三种类型验证 `const` 上下文的 `T(0) is Float64` 表达式是否可通过编译。若验证失败，备选方案为所有类型统一使用精确比较路径（`a == b`），浮点容差比较通过独立的具名函数（如 `equalEpsilon`）提供给需要容差比较的场景（详见 §3.5 备选路径）。

---

## 11. 迁移成本评估

### 11.1 `&&`/`||` 具名函数迁移

C++ GLM 中 `&&` 和 `||` 是运算符重载，迁移到仓颉后需改为具名函数 `logicalAnd`/`logicalOr`。此语法变更对下游代码的影响和迁移模式如下：

#### 受影响的表达式模式

| C++ GLM 代码 | 仓颉等效代码 | 搜索规则 |
|-------------|-------------|---------|
| `a && b`（a,b 为 vec） | `a.logicalAnd(b)` | 在 Vec 类型变量上搜索 `&&` 替换为 `.logicalAnd()` |
| `a \|\| b`（a,b 为 vec） | `a.logicalOr(b)` | 在 Vec 类型变量上搜索 `\|\|` 替换为 `.logicalOr()` |
| `!a`（a 为 vec） | `!a` 或 `a.logicalNot()` | `!` 可重载，保持语法不变 |

#### 迁移模式

1. **纯语法替换**（机械可执行）：在 Vec 类型表达式中，将 `v1 && v2` 替换为 `v1.logicalAnd(v2)`，将 `v1 || v2` 替换为 `v1.logicalOr(v2)`。此替换可通过正则搜索完成，不涉及语义分析。
2. **短路语义丢失**：C++ 中 `&&`/`||` 的短路求值语义在具名函数中不保留——`logicalAnd(a, b)` 始终求值两个参数。在 GLM 向量运算场景中，所有参数均为纯表达式（无副作用），因此短路语义丢失不影响正确性。
3. **迁移影响范围**：仅影响使用 `bvec*`（`VecN<Bool, Q>`）类型布尔向量运算的代码。标量布尔值不受影响（仓颉原生 `&&`/`||` 保留）。

#### 自动迁移工具建议

可编写搜索脚本（基于正则表达式）处理以下模式：
- `(\w+)\s*&&\s*(\w+)` → `$1.logicalAnd($2)`
- `(\w+)\s*\|\|\s*(\w+)` → `$1.logicalOr($2)`

注意：此搜索替换需限定在 `bvec*` 类型变量范围内以避免误改标量 `Bool` 类型的 `&&` 表达式。在迁移实践中，建议在代码审查过程中手动标注 Vec 类型变量范围，或通过类型注解辅助搜索脚本。

### 11.2 `++`/`--` 具名函数迁移

C++ GLM 中 `++` 和 `--` 是前缀/后缀运算符重载，迁移到仓颉后需改为具名函数 `increment()`/`decrement()`。此语法变更对下游代码的影响和迁移模式如下：

#### 受影响的表达式模式

| C++ GLM 代码 | 仓颉等效代码 | 搜索规则 |
|-------------|-------------|---------|
| `++v`（前缀） | `v = v.increment()` | 在 Vec 类型变量上搜索前缀 `++` 替换为 `.increment()` |
| `v++`（后缀） | `v = v.increment()` | 在 Vec 类型变量上搜索后缀 `++` 替换为 `.increment()` |
| `--v`（前缀） | `v = v.decrement()` | 在 Vec 类型变量上搜索前缀 `--` 替换为 `.decrement()` |
| `v--`（后缀） | `v = v.decrement()` | 在 Vec 类型变量上搜索后缀 `--` 替换为 `.decrement()` |

#### 迁移模式

1. **前缀与后缀统一替换**：仓颉值类型中 `increment()` 和 `decrement()` 返回新向量（值语义的副本）。C++ 中前缀 `++v` 返回左值引用，后缀 `v++` 返回旧值副本。在仓颉中，两种形式均统一为 `v = v.increment()`（返回新向量后再赋值）。若原 C++ 代码依赖后缀 `++` 的"返回旧值"行为（如 `auto old = v++`），则需在迁移时拆分——`let old = v; v = v.increment()`。
2. **迁移影响范围**：影响所有使用 `vec++`、`++vec`、`vec--`、`--vec` 表达式的代码。通常用于循环计数或状态更新。
3. **`@OverflowWrapping` 继承**：`increment()`/`decrement()` 标注 `@OverflowWrapping`，行为与 C++ GLM 的 `operator++`（高位丢弃）一致。

#### C++ `++`/`--` 使用模式分类与映射

以下分类表涵盖 C++ 中 `++`/`--` 在 Vec 类型上的所有典型使用模式，逐一给出正确的仓颉映射方式和迁移工作量评估：

| 模式 | C++ 代码 | C++ 行为 | 仓颉等效代码 | 迁移工作量 | 说明 |
|------|---------|---------|-------------|-----------|------|
| **I. 独立语句（不依赖返回值）** | `v++;` `++v;` `v--;` `--v;` | 仅执行副作用（修改 v），返回值被忽略 | `v = v.increment()` / `v = v.decrement()` | 低（机械替换，搜索替换即可） | 前缀与后缀在仓颉中无差异。C++ 中前缀性能更优（无临时副本），仓颉中始终产生新向量 |
| **II. 作为右值（后缀返回旧值）** | `auto old = v++;` | old 获得 v 递增前的值，v 递增 | `let old = v; v = v.increment()` | 中（需拆分语句） | 必须解构为临时保存旧值和更新两步。不能简化为 `v.increment()` 的单一表达式 |
| **III. 作为右值（前缀返回新值）** | `auto newv = ++v;` | newv 获得 v 递增后的值，v 递增 | `v = v.increment(); let newv = v` 或 `let newv = v.increment()`（若可覆盖原变量） | 中（需拆分语句） | 若调用方只需新值且可丢弃原变量，可直接 `let newv = v.increment()` |
| **IV. 嵌套表达式** | `arr[++v] = val;` | v 先递增，然后用新值索引数组 | `v = v.increment(); arr[v] = val` | 中（需拆分表达式） | 仓颉表达式要求显式分步。可用复合赋值：`v = v.increment(); arr[v] = val` |
| **V. 循环计数** | `for(; condition; ++v) { ... }` | 循环的增量部分独立修改 v | `v = v.increment()` 作为循环增量表达式 | 低（机械替换） | 在循环的增量表达式中直接替换 |
| **VI. 函数参数** | `foo(v++);` | v 递增前的值传给 foo，然后 v 递增 | `let tmp = v; foo(tmp); v = v.increment()` | 中（需拆分语句） | 必须保存旧值副本后传递 |
| **VII. 后缀链式操作** | `v++->method();` | 对 v 递增前的旧值调用 method | `let tmp = v; v = v.increment(); tmp.method()` | 中（需拆分语句） | 通过临时变量交换方法调用方 |
| **VIII. 返回值传播** | `return v++;` `return ++v;` | 返回 v 递增前/后的值 | `let newv = v.increment(); return newv` 或 `return v.increment()` | 低-中（依赖返回值语义） | 若仅需新值，直接返回 `v.increment()`；若需旧值，先保存旧值再更新 |

**迁移工作量评估**：
- **低（机械替换）**：约占总出现次数的 60-70%。直接搜索替换即可，无需语义分析。
- **中（拆分语句）**：约占总出现次数的 30-40%。需要人工阅读上下文，理解返回值使用方式后拆分为多条语句。
- **高（涉及前缀/后缀语义差异）**：在 Vec 类型上不适用（前缀/后缀在仓颉中行为统一），但在非 Vec 标量类型场景中仍需区分。

**编码阶段建议**：
1. 先用正则搜索替换处理模式 I（独立语句）和模式 V（循环计数），覆盖大部分迁移工作。
2. 对模式 II-IV 和 VI-VIII，在代码审查中逐处人工识别并标注改造方式。
3. 对于 `Vec<Bool, Q>` 上的 `increment()`/`decrement()`，由于 Bool 不支持算术运算，在实例化时产生编译错误。迁移时需将涉及 `VecN<Bool>` 的 `++`/`--` 替换为逻辑非操作（`!`）或移除。

### 11.3 跨类型赋值差异

C++ GLM 允许从同分量数但不同分量类型的 Vec 赋值（如 `ivec2 = vec2` 通过隐式转换）。仓颉中 struct 自动生成的 `=` 仅接受完全相同类型的右操作数，跨类型赋值需显式转换：

| C++ GLM 代码 | 仓颉等效代码 | 说明 |
|-------------|-------------|------|
| `ivec2 a; vec2 b; a = b;` | `let a: IVec2; let b: Vec2Float32; a = IVec2(b);` | 显式使用跨 Vec 转换构造 |
| `uvec4 a; vec4 b; a = b;` | `let a: UVec4; let b: Vec4Float32; a = UVec4(b);` | 分量级类型转换在构造函数内完成 |

此差异为机械可替换的语法变化，通过搜索 `vecTypeName =` 后跟不同 Vec 类型的赋值模式进行替换。

### 11.4 `bitwiseNot()` 迁移影响（`VecN<Bool, Q>` 场景）

`bitwiseNot()` 对 `VecN<Bool, Q>` 的行为与 C++ GLM 的 `~bvec` 存在根本性差异（详见 §3.2 已知行为差异说明）：
- C++ GLM 中 `~bvec` 因整数提升机制（`bool` → `int` → 按位取反 → 转回 `bool`，非零即 `true`）对任一分量始终返回 `true`。
- 仓颉中 `bitwiseNot()` 对 `VecN<Bool, Q>` 调用 `!` 执行逻辑否定（`!true = false`，`!false = true`），行为完全相反。

**受影响的表达式模式**：

| C++ GLM 代码 | 仓颉等效代码 | 说明 |
|-------------|-------------|------|
| `~bvec`（布尔向量） | `!bvec` 或 `bvec.bitwiseNot()` | 行为完全相反。若需保持 C++ 行为，应替换为 `VecN<Bool, Q>(true)`（全 true）或按需使用 `logicalNot` |
| `~ivec`（整数向量） | `ivec.bitwiseNot()` | 语义等价（整数 `!` 为按位取反） |

**迁移规则**：
1. 整数分量 Vec 的 `~` 直接替换为 `.bitwiseNot()`，语义等价。
2. 布尔分量 Vec 的 `~` 需根据上下文选择替换方式：
   - 若期望行为是"全 false"（与仓颉 `!` 一致），替换为 `!bvec` 或 `bvec.logicalNot()`。
   - 若期望行为是"全 true"（与 C++ `~bvec` 一致），替换为 `VecN<Bool, Q>(true)`。
   - 若无法确定，应在代码审查中标记并手动确认。

**工作量评估**：影响范围较小（`~bvec` 使用频率低于整数/浮点向量位运算），主要在代码审查阶段人工识别处理。

---

## 12. 实现验证与验收策略

### 12.1 验证层次

首轮实现完成后，从以下三个层次验证正确性：

#### 层次一：编译验证
- 每个 `.cj` 文件可独立通过 `cjc` 编译（包内依赖闭合）。
- `type_vecN.cj` 在 `T = Int32`、`Float32`、`Bool` 三种分量类型及 `Q = PackedHighp`、`PackedLowp` 两种精度策略下可实例化编译通过。
- `fwd.cj` 中全部 256 个别名编译后不产生重复定义错误。
- 验证命令：`cjpm build` 无报错。

#### 层次二：构造与访问验证
- 每种 Vec 类型（Vec1~Vec4）每种构造方式（标量填充、逐分量、跨 Vec 转换、跨分量数组合）至少构造一个实例。
- 下标运算符正/边界测试：索引 0 到 N-1 返回正确分量；索引越界触发断言。
- 具名分量访问（`x`/`y`/`z`/`w`）返回值正确。

#### 层次三：运算正确性验证
- **算术运算**：对 `Vec4<Int32>` 和 `Vec4<Float32>` 分别验证 `+`、`-`、`*`、`/`、`-`（一元）的正确性。验证 `Vec4<Int32>` 的 `%`。验证复合赋值（`+=`、`-=` 等）语义与二元运算符一致。
- **溢出验证**：验证 `@OverflowWrapping` 标注的二元算术运算在整数溢出时 wrapping 而非抛异常。构造 `Vec2<UInt8>(255, 128) + Vec2<UInt8>(1, 128)`，期望结果为 `(0, 0)`（wrapping）。
- **位运算**：对 `Vec4<Int32>` 验证 `&`、`|`、`^`、`<<`、`>>`。验证 `<<` 的 `@OverflowWrapping` 语义（`Vec2<UInt8>(1, 128) << 1` 期望 `(2, 0)`）。
- **`bitwiseNot()`/`increment()`/`decrement()`**：验证整数分量下的正确性。验证 `Vec4<Float32>.bitwiseNot()` 产生编译错误。
- **比较运算**：验证 `==` 在整数和浮点分量下的正确性（浮点容差比较）。验证 `!=` 为 `!(==)` 的等价性。
- **布尔逻辑**：对 `Vec2<Bool>` 验证 `logicalAnd`、`logicalOr`、`!` 的正确性。

#### 层次四：异常场景与边界验证（补充）
- **零向量算术**：`Vec3<Int32>(0,0,0) + Vec3<Int32>(1,2,3)` 返回 `(1,2,3)`。`Vec4<Float32>(0,0,0,0) * Float32(5)` 返回 `(0,0,0,0)`。
- **除零行为**：整数 Vec 除以 0 抛 `ArithmeticException`。浮点 Vec 除以 0 返回 `±Inf` 分量（无异常）。
- **NaN/Infinity 传播**：构造包含 `Float32.NaN` 分量的 Vec，验证 `+` 运算中 NaN 传播。构造包含 `Float32.Infinity` 分量的 Vec，验证算术运算。
- **类型转换边界**：`Vec2<Int64>(Int64.Max, Int64.Max)` 转为 `Vec2<Int32>` 验证 wrapping 截断。`Vec2<Float64>(1.79e308, -1.79e308)` 转为 `Vec2<Float32>` 验证 ±Inf 传播。
- **Bool Vec 行为**：验证 `Vec2<Bool>` 的 `&`/`|`/`^`/`!` 运算正确性。验证 `Vec2<Bool> + Vec2<Bool>` 产生编译错误。

### 12.2 验收标准

对照 roadmap §4.4 验证标准摘要：

| 验收项 | 标准 | 验证方法 |
|--------|------|---------|
| 编译通过性 | 全量编译无语法/类型错误 | `cjpm build` |
| 构造完备性 | 支持 §4.1 约定的所有构造函数形态 | 层次二测试覆盖 |
| 运算等价性 | 基本算术/位运算结果与 C++ GLM 对应类型一致（在绕过了运算符重载差异的前提下） | 层次三测试 + 与 C++ 等效代码逐值比较 |
| 溢出行为 | `@OverflowWrapping` 标注的运算在整数溢出时 wrapping 而非抛异常 | 层次三溢出验证 |
| 边界行为 | §9 约定的零向量、除零、NaN/Infinity 传播、类型转换边界行为与约定一致 | 层次四异常场景测试 |
| 别名覆盖 | `fwd.cj` 中**256 个别名全量正确定义和使用**，无重复定义或缺失错误。此为首轮强制交付标准，不可降级 | `cjpm build` + 确认每个别名家族（16 家族）至少各验证一个分量数和一个精度变体的可实例化 |
| 公共 API 导入 | 下游消费者通过 `import glm.Vec2` 等直接导入向量类型，无需引用 `glm.detail` 包路径 | 在独立测试包中编写 `import glm.*` 测试代码，确认 `Vec2<Float32, PackedHighp>` 可通过 `glm` 包直接使用且类型完整 |
| 公共 API 重导出 | `lib.cj` 中的 `public import` 覆盖所有公共 API 类型（Vec1~Vec4、Qualifier 及实现类型） | 审查 `lib.cj` 的 `public import` 列表覆盖 §3.1 和 §3.2 中定义的公开类型；确认 `glm.detail` 内部类型（shim、functor、compute_vector_decl）对下游不可见 |
| 跨类型操作限制 | 跨类型运算（如 `Vec2<Int32> + Vec2<Int16>`）产生编译错误 | 编译测试 |
| `<`/`<=`/`>`/`>=` 缺失确认 | 使用这些运算符的 Vec 表达式产生编译错误 | 编译测试 |
| Bool Vec 行为一致性 | `VecN<Bool>` 各运算的行为与 §3.2 约定一致 | 层次三布尔逻辑测试 + 编译测试验证算术/移位报错 |
| Qualifier 跨 Q 转换 | 不同 Qualifier 之间（如 `PackedHighp` ↔ `PackedLowp`）的 Vec 转换构造可编译通过与正确运行 | 编写 `Vec2<Float32, PackedHighp>` 跨 Q 转换为 `Vec2<Float32, PackedLowp>` 的测试代码，验证构造及后续运算正确性 |
| 哈希集合可用性 | 整数/Bool 分量 Vec 可正常用作 `HashSet`/`HashMap` 键；浮点分量 Vec 在哈希上下文中产生编译错误 | 编译测试：`HashSet<Vec2<Int32, PackedHighp>>` 通过；`HashSet<Vec2<Float32, PackedHighp>>` 报错 |

### 12.3 测试工具

首轮验证使用仓颉内置 `@Test`/`@TestCase` 框架（`std.unittest`），编写端到端验证函数覆盖 §12.1 的验证层次。测试用例应放置在 `tests/` 目录下的独立测试包中。

---

## 修订说明（v7）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题 1（严重）**：§4.3/§4.4 `<<` 运算符右操作数类型描述不准确——仓颉禁止"引入新的类型参数"而非"右操作数类型必须与分量类型相同"，移位量可定义为 `Int64` | §4.3 和 §4.4 重写相关描述：修正为限制语（运算符不能为泛型，即不能引入新类型参数 `U`）。在 §4.4 中新增方案 A（移位量取 `T`，当前采用）和方案 B（移位量取 `Int64`，备选）的对比评估。列出选择理由和备选条件。 |
| **问题 2（严重）**：§4.6 `@OverflowWrapping` 标注策略声明"与 roadmap §0.5.1 完全对齐"但实际策略完全相反——roadmap 标注复合赋值运算符，设计标注二元算术运算符 | §4.6 修正文字声明：用独立段落说明与 roadmap §0.5.1 的策略差异——roadmap 推荐在复合赋值上标注，但仓颉中复合赋值不可显式定义（编译器自动生成）。本设计在二元运算符上直接标注，由编译器自动生成的复合赋值继承 wrapping 语义。运行时语义等价。 |
| **问题 3（严重）**：构造函数体系不自包含，依赖外部 C++ 源码 | §4.1 完全重写：以仓颉语法列出 Vec1~Vec4 各类型的完整构造函数签名清单，按构造函数类别组织（逐分量/标量填充/跨类型转换/跨分量数组合/const init/从 Vec1 构造），所有签名包含完整的类型参数声明和 `where` 约束。编码阶段以本清单为准，无需参考 C++ 宏展开。 |
| **问题 4（一般）**：别名分级表格数值与实际计算不一致（必备~32/常用~64/可选~160，合计128≠256） | §3.8 别名分级表格修正为：必备 64（4 家族 × 4 分量数 × 4 精度）、常用 48（3 家族 × 4 分量数 × 4 精度）、可选 144（9 家族 × 4 分量数 × 4 精度），合计 256。 |
| **问题 5（一般）**：缺失 `<`/`<=`/`>`/`>=` 逐分量比较运算符的设计覆盖 | §4.5 新增「`<`/`<=`/`>`/`>=` 运算符」子节，说明首轮不定义的理由（C++ GLM 未定义、语义歧义——聚合 vs 逐分量）。§7 新增 D22 设计决策记录。§12 验收标准表新增"`<`/`<=`/`>`/`>=` 缺失确认"项。 |
| **问题 6（一般）**：`<<` 移位量类型设计未评估 `Int64` 固定整数路径 | §4.4 新增方案 B（移位量取 `Int64`）的完整评估，包括优点（与 LengthT 一致）、缺点（无法支持 `vec << vec` 形式、需各 VecN 单独定义）。决策结论为方案 A（取 `T`），方案 B 作为备选。 |
| **问题 7（一般）**：C++ GLM 的 `storage<L,T,Q>` 模板结构体未映射也未解释省略理由 | §3.1 末尾新增「C++ `storage<L,T,Q>` 模板结构体说明」段落，解释省略理由——仓颉 Vec 直接声明具名成员，不依赖 C 数组或 SIMD 内部类型。§7 新增 D23 设计决策记录。 |
| **问题 8（一般）**：`genTypeTrait`/`find_best_type` 等辅助设施在设计文档中未覆盖 | §3.1 末尾新增「C++ 辅助设施省略说明」子节（§3.9），列出 `genTypeTrait`、`init_gentype`、`find_best_type` 等设施并解释首轮不迁移的理由（服务于矩阵/四元数层，后续轮次伴随迁移）。§7 新增 D24 设计决策记录。 |
| **问题 9（一般）**：Vec 结构体 Q 参数未指定是否具有默认类型参数 | §3.2 的「类型参数默认值」段落明确声明 `where Q <: Qualifier = PackedHighp`，说明 `Vec2<Float32>` 和 `Vec2<Float32, PackedLowp>` 均为合法写法。 |
| **问题 10（轻微）**：`Vec<Bool, Q>` 完整行为约定分布过于分散 | §3.2 新增「`Vec<Bool, Q>` 完整行为约定」集中化描述段落，以项目符号列出 Bool 分量 Vec 在各运算类别中的行为（可编译/不可编译及报错原因）。§7 新增 D20 设计决策记录。 |
| **问题 11（轻微）**：D6 配置常量 `GLM_CONFIG_CLIP_CONTROL` 的类型选择 | §7/D6 表格后新增「`GLM_CONFIG_CLIP_CONTROL` 类型选择」说明段落，论证采用 `Int` 而非自定义 enum 的理由（位掩码语义、与 C++ `#define` 直接对应）。 |
| **问题 12（轻微）**：`operator[]` 索引类型未做设计决策记录 | §4.2 末尾新增「`operator[]` 索引类型选择理由」说明段落。§7 新增 D21 设计决策记录。 |
| **问题 13（轻微）**：§9.3 NaN/Infinity 比较描述的改进方案不可行（"通过 `is` 检查"在仓颉中为类型检测而非值检测） | §9.3 NaN/Infinity 参与比较运算行的改进方案描述修正：移除"通过 `is` 检查"的不正确表述，改为使用 `Float64.isNaN(a)` / `Float64.isInfinite(a)` 运行时检测方案，或 `const` 函数中通过 `const if` 编译期判断。同时说明首轮容差路径的局限性——NaN/Infinity 比较行为以 IEEE 754 默认规则为准，不做特殊处理。 |
| **问题 14（轻微）**：迁移验证标准未覆盖全部异常场景（§12 验收标准声明覆盖的场景在验证步骤中缺少对应用例） | §12.1 新增「层次四：异常场景与边界验证」子节，覆盖零向量算术、除零行为、NaN/Infinity 传播、类型转换边界、Bool Vec 行为等五类异常/边界场景。§12.2 验收标准表新增"跨类型操作限制"、"`<`/`<=`/`>`/`>=` 缺失确认"、"Bool Vec 行为一致性"等验收项，每项给出验证方法。 |

---

## 修订说明（v7 — 第二轮）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题 1（严重）**：类型参数默认值语法不支持 — 设计使用 `where Q <: Qualifier = PackedHighp` 为 Q 类型参数声明默认值，仓颉泛型系统不支持此语法 | 全文移除 `= PackedHighp` 默认值声明。§3.2「类型参数默认值」重写为「类型参数显式指定」，说明 Q 必须显式指定，通过 `type` 别名在 `glm` 包中提供常用具现化简写。§3.2 形态选择理由中对应项重写。§4.1 四个 Vec 类型头部的声明语法修正为 `VecN<T, Q> where Q <: Qualifier`。§7 D2 中删除"可提供默认类型参数"声明。 |
| **问题 2（一般）**：`countof<T, $N>(arr: VArray<T, $N>)` 签名不合法 — `$N` 必须是固定数值字面量，不可声明为值泛型参数 | 移除 `countof` 函数定义。§3.6 `shim_cstddef.cj` 说明改用 `VArray` 内置的 `size` 属性提供编译期长度查询。§2 模块注释、§8 依赖表格和依赖说明中相关引用同步修正。 |

---

## 修订说明（v8）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题 1（严重）** — `bitwiseNot()` 对 `VecN<Bool, Q>` 的行为等价性声明错误：原声明"语义与 C++ GLM 的 `~bvec` 一致"不成立 — C++ `~bool` 因整数提升始终返回 `true`，仓颉 `!Bool` 执行逻辑否定（`!true = false`），二者行为完全相反 | §3.2 修正 `Vec<Bool, Q>` 行为约定中 `bitwiseNot()` 的声明：移除"语义与 C++ GLM 的 `~bvec` 一致"断言，标注为"已知行为差异"，详细说明差异机理并建议若需严格兼容则编码时排除该函数。新增 D25 设计决策记录。 |
| **问题 2（严重）** — `GLM_CONFIG_CLIP_CONTROL` 默认值错误：设计文档给出 `0x02`（仅 `NO_BIT`），GLM 源码中 `GLM_CLIP_CONTROL_RH_NO = RH_BIT(8) \| NO_BIT(2) = 0x0A` | §7 D6 配置常量表修正 `GLM_CONFIG_CLIP_CONTROL` 值为 `0x0A`（十进制 10），标注为 `RH_BIT(8) \| NO_BIT(2)`。 |
| **问题 3（严重）** — 问题 1 和问题 2 的事实错误影响文档编码就绪度 | 已通过修正问题 1 和问题 2 的事实错误解决。 |
| **问题 4（严重）** — 跨类型 Vec 构造函数中标量参数错误地使用了 `T2`（源分量类型）而非 `T`（目标分量类型）。C++ GLM 中标量隐式转换为目标类型，仓颉中应使用 `T` 类型参数 | §4.1 全面修正 Vec2~Vec4 跨类型构造函数签名：所有标量参数由 `T2` 改为 `T`。Vec2 涉及 2 处，Vec3 涉及 5 处，Vec4 涉及 30 处标量参数。Vec 类型参数（如 `Vec1<T2, Q2>`）保持不变。新增 D26 设计决策记录。 |
| **问题 6（轻微）** — `isIec559Of<T>()` 的 `const if (T(0) is Float64)` 方案仍为设计假设，`T(0)` 在 const 上下文中对泛型 `T` 的统一合法性未在目标编译器上验证 | §10 末尾新增"编码前验证要求"段落，建议在编码阶段针对 `T = Int32, Float32, Bool` 编写原型测试代码。若验证失败，备选路径为所有类型统一使用精确比较（§3.5 备选路径已定义）。 |

---

## 新增设计决策（v8）

### D25. `VecN<Bool, Q>.bitwiseNot()` 的行为差异认定

**决策**：`bitwiseNot()` 对 `VecN<Bool, Q>` 可编译通过，但声明为**已知行为差异**而非语义等价。

**理由**：C++ GLM 中 `~bvec` 因整数提升机制（`bool` → `int` → 按位取反 → 转换回 `bool`，非零即 `true`）对任一分量始终返回 `true`。仓颉中 `!Bool` 执行逻辑否定（`!true = false`，`!false = true`），两种行为完全相反。将 `bitwiseNot()` 对 `Bool` 的行为认定为已知差异而非等价迁移，允许调用方按需调整。若编码阶段需要严格兼容 C++ GLM 行为，应为 `VecN<Bool, Q>` 排除 `bitwiseNot()` 使其实例化时报编译错误。

### D26. 跨类型构造函数标量参数使用目标类型

**决策**：跨类型构造函数中的所有标量参数使用目标分量类型 `T`，而非源分量类型 `T2`。

**理由**：C++ GLM 的跨类型构造中，标量参数虽然声明为 `T2` 类型，但因 C++ 隐式类型转换规则自动转换到目标类型 `T`。仓颉无隐式数值类型转换，若标量参数保持 `T2` 类型，调用方必须将标量值显式构造为 `T2` 类型再传入，与 GLM 的"标量可自然使用目标类型字面量"的调用体验不一致。将标量参数改为 `T` 类型后，调用方可直接使用目标类型的字面量或变量，构造函数体内通过 `T(scalar)` 完成转换（若需跨类型转换）。Vec 类型参数（如 `Vec2<T2, Q2>`）保持 `T2` 不变，因构造函数体内需对 Vec 分量逐一调用 `T(v.x)` 进行类型转换。

### D27. Qualifier 跨 Q 赋值/转换行为约定

**决策**：首轮中不同 Qualifier 之间的赋值和转换默认允许，无运行时或编译期限制。后续轮次引入 Qualifier 差异化时重新评估此约定。

**理由**：首轮所有 Qualifier 实现类型（PackedHighp、PackedMediump、PackedLowp、AlignedHighp 等）均为空结构体，无运行时数据差异。跨 Q 赋值（如 `Vec2<Float32, PackedHighp>` 赋给 `Vec2<Float32, PackedLowp>` 类型变量）在数据语义上等价于同 Q 赋值——仅类型签名改变。Vec 的跨类型转换构造函数（`init<T2, Q2>(v: VecN<T2, Q2>) where Q2 <: Qualifier`）在类型层面已允许 Q2→Q 的转换。若在首轮禁止跨 Q 转换（如通过 `static assert` 限制特定 Q 组合），将增加不必要的复杂性且无实际收益。后续轮次引入差异化行为时，可按需通过编译期约束（如 `where` 条件、宏或自定义注解）重新限制跨 Q 转换路径。

---

## 修订说明（v8 — 第二轮）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题 1（一般）**：§4.1 中 Vec1~Vec4 同时声明了 `public init(x: T, y: T, ...)` 和 `const init(x: T, y: T, ...)` 两个具有相同参数列表的构造函数。仓颉函数重载规则中 `const` 修饰符不构成区分依据（const README §3.2 规则 7），二者将产生重复定义编译错误。 | 全文统一移除与 `const init` 参数列表相同的非 `const` `init` 版本。Vec1 移除 `public init(x: T)`，Vec2 移除 `public init(x: T, y: T)`，Vec3 移除 `public init(x: T, y: T, z: T)`，Vec4 移除 `public init(x: T, y: T, z: T, w: T)`。`const init` 在非 const 上下文中同样可用于运行时构造（const README §3.2 规则 5），替代被移除的普通 `init`。其他不同参数列表的 `init` 构造函数（标量填充、跨类型转换、跨分量数组合等）不受影响。§3.2 中 `const init` 描述更新为反映此变更。§7 D11 设计决策修正理由说明 `const` 修饰符不构成重载区分依据的技术约束。 |
| **问题 2（轻微）**：§4.4 中 `bitwiseNot()` 对 `Bool` 分量的行为仍声明为"两种语义均正确匹配 C++ GLM 的 `~`"，与 §3.2 中"已知行为差异"的表述矛盾。 | §4.4 修正为：整数分量行为与 C++ GLM 一致，`Bool` 分量行为完全相反（详见 §3.2 已知行为差异说明）。消除全文内关于 `Vec<Bool, Q>` 行为表述的不一致性。 |

---

## 修订说明（v9）

| 审查意见 | 修改措施 |
|---------|---------|
| **P1（严重）**：别名目标数量三处不一致——§3.8 声称 256 个、§3.8 第 3 段声称"最简可行范围 48 个"、§12.2 验收标准要求 ≥64 个。编码人员无法确定首轮实际应实现的别名数量 | §3.8 完全重写：明确 256 个别名为首轮**强制交付标准**，与 roadmap §3C/§3G 一致。"最简可行范围 48 个"改为可选降级策略并标注"需触发范围变更评审"；降级后范围改为 64 个（16 家族 × 4 分量数 × 1 默认精度）而非 48 个（含 Vec1 别名）。§12.2 验收标准中"别名覆盖"项修正为"256 个别名全量正确定义和使用，此为首轮强制交付标准，不可降级"。消除全文内关于别名目标值的任何歧义 |
| **P2（严重）**：设计未利用 `public import` 定义公共 API 面——下游消费者导入 `glm.detail` 核心类型时需直接依赖 detail 内部包，违背封装原则 | §2 模块划分中重构：① `package glm` 新增 `lib.cj`，使用 `public import` 重导出 Vec 类型和 Qualifier 类型；② 新增「公共 API 面设计」子节，描述 `lib.cj` 的导出内容、封装策略和后续轮次扩展方式；③ 依赖图更新 `lib.cj` 的依赖关系。§8 迁移文件清单新增 `lib.cj`（序号 13），并标注该新增在范围可追溯性对照表中的偏离项。§12.2 验收标准新增"公共 API 导入"和"公共 API 重导出"两项验收标准 |
| **P3（严重）**：缺少与 roadmap 首轮范围的可追溯性映射——设计未引用 roadmap 子范围编号，编码阶段无法独立验证范围完整性 | §1 概述新增「范围可追溯性」段落。§8 完全重写：① §8.1 文件清单表新增"Roadmap 子范围"和"Roadmap §3E 序号"两列，每个文件标注对应的 roadmap 子范围和序号；② §8.2 新增"范围可追溯性对照表"，将 roadmap §3E/§3G 的 14 个条目逐项映射到本设计的对应章节和仓颉文件，对偏离项标注理由和偏离条件（C++ `setup.hpp` 平台检测宏消减、`storage`/`genTypeTrait` 省略、`lib.cj` 新增）；③ 原依赖说明归入 §8.3 |
| **P4（一般）**：D6 配置常量表引用未定义的子常量（如 `GLM_SWIZZLE_DISABLED`、`RH_BIT(8)` 等），编码人员无法独立获取完整常量值 | §7 D6 配置常量表修正：① 所有 C++ 宏常量值统一替换为**字面量**（如 `GLM_SWIZZLE_DISABLED`=2 → `2`，`GLM_HIGHP`=3 → `3`，`RH_BIT(8) \| NO_BIT(2)` → `0x0A`）；② 新增"子常量编码策略"段落，明确首轮采用字面量替换方案、不定义独立命名常量的理由及后续轮次补充路径 |
| **P5（一般）**：Qualifier 的运行时行为约定未涉及——不同 Qualifier 在当前设计下功能等价但未明确约定跨 Q 赋值/转换行为 | §3.1 Qualifier 体系末尾新增「Qualifier 运行时行为约定」段落，明确三个约定：① 首轮跨 Q 赋值/转换默认允许（无运行时差异）；② 后续轮次引入差异化时重新评估跨 Q 转换限制；③ Qualifier 差异引入路径的预期说明（对齐策略差异、SIMD 路径差异、精度语义差异三条路径）。§7 新增 D27 设计决策记录。§12.2 验收标准新增"Qualifier 跨 Q 转换"验收项 |

---

## 修订说明（v10）

| 审查意见 | 修改措施 |
|---------|---------|
| **P1（严重）** — `operator[]` 赋值形式缺少 `mut` 修饰符：§4.2 的赋值形式签名缺少 `mut`，struct 的非 `mut` 实例成员函数不能修改实例成员 | §4.2 修正：`operator[]` 赋值形式改为 `public mut operator func [](i: Int64, value!: T): Unit`，并添加说明阐明 `mut` 的必要性。§7 新增 D28 设计决策 |
| **P2（中高）** — `const operator ==` 表达式链的 const 兼容性未系统评估：`abs(a - b) <= epsilonOf<T>()` 中各环节的 const 属性未逐项标注验证状态 | §3.5 末尾新增段落引用 §7 D29 的完整兼容性要求。§7 新增 D29 设计决策，系统性罗列 `const operator ==` 完整表达式链的 const 兼容性要求、验证状态和回退方案 |
| **P3（中高）** — `@OverflowWrapping` 标注继承性未经验证：断言编译器自动生成的复合赋值版本继承二元运算符上的 `@OverflowWrapping` 标注属于对编译器行为的推测 | §4.6 总结后新增验证要求段落。§7 新增 D30 设计决策，明确编码前原型验证计划及备选方案（通过 extend 块中的具名函数实现 Vec 算术运算） |
| **P4（中等）** — `Vec<Bool, Q>` 抽象类型引用未彻底消除：§3.2 仍使用 `Vec<Bool, Q>` 格式，实际设计中不存在此类型 | 全文主章节中所有 `Vec<Bool, Q>` 替换为 `VecN<Bool, Q>`（§3.2 标题、§4.3 `++`/`--` 说明、§4.4 已知行为差异引用、§7 D20 标题及正文、§11.1 迁移影响范围、§12.2 验收标准）。历史修订说明中的引用保持原样 |
| **P5（中等）** — 跨类型 fill-from-Vec1 构造器缺失限制未记录为设计决策：跨类型 `Vec1<T2, Q2>` 的 fill-from-Vec1 构造器不可与 `Vec1<T, Q>` 版本共存 | §4.1 中 Vec2~Vec4 的 fill-from-Vec1 构造器注释后追加引用标记 `（仅同类型，跨类型受限原因见 §7 D31）`。§7 新增 D31 设计决策，记录此约束及理由 |
| **P6（轻微）** — `increment()`/`decrement()` 语义差异未充分评估：§11.2 对依赖 `++`/`--` 返回值的迁移模式覆盖不完整 | §11.2 新增「C++ `++`/`--` 使用模式分类与映射」子节，以表格形式列出 8 类典型使用模式（独立语句、右值、嵌套表达式、循环计数、函数参数、后缀链式、返回值传播），每类标注迁移工作量和正确映射方式 |
| **P7（轻微）** — 配置常量表中 `Int` 类型在仓颉中非标准类型：仓颉无未修饰的 `Int` 类型，正确类型应为 `Int64` | §7 D6 配置常量表中所有 `Int` 类型声明改为 `Int64`（涉及 `GLM_CONFIG_SWIZZLE`、`GLM_CONFIG_CLIP_CONTROL`、`GLM_CONFIG_CTOR_INIT`、`GLM_CONFIG_LENGTH_TYPE`、`GLM_CONFIG_PRECISION_BOOL/INT/UINT/FLOAT/DOUBLE` 共 9 个常量）。`GLM_CONFIG_CLIP_CONTROL` 类型选择说明段落同步修正 |

## 修订说明（v11）

| 审查意见 | 修改措施 |
|---------|---------|
| **P1（严重）** — 缺少 `Hashable` 实现，Vec 类型无法作为哈希键正常使用 | §3.2 在 `VecN<Bool, Q>` 行为约定后新增「Hashable 实现策略」段落，明确整数/Bool 分量 Vec 使用 `@Derive[Hashable]`、浮点分量 Vec 不实现 `Hashable` 并记录为已知限制。§4 新增「4.7 哈希契约」子节描述 `hashCode()` 行为约定。§12.2 验收标准表新增"哈希集合可用性"验收项 |
| **P2（严重）** — Vec2 缺少 `Vec1+Vec1` 构造函数，与 C++ GLM `type_vec2.inl` 行为不一致 | §4.1 Vec2 构造函数清单中，在 `Vec1+标量` 组合后新增 `Vec1+Vec1` 组合构造函数：`public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>) where Q2 <: Qualifier` |
| **P3（严重）** — Vec3 缺少 4 个 `Vec1` 参与的组合构造函数，与 C++ GLM `type_vec3.inl` 行为不一致 | §4.1 Vec3 构造函数清单中，在 `Vec1+2标量` 组合后新增 `Vec1+Vec1+标量`（3 个）和 `Vec1+Vec1+Vec1`（1 个）共 4 个构造函数 |
| **P4（一般）** — `ComputeEqual` 被 `public import` 暴露为公共 API，泄漏实现细节 | §2 公共 API 面设计：从 `lib.cj` 的 `public import` 列表中移除 `ComputeEqual`。同步更新模块依赖图中 `lib.cj` 的依赖声明 |
| **P5（一般）** — `isIec559Of<T>()` 实现中包含 `Float16` 类型增加不必要的验证风险 | §3.6 和 §10 中 `isIec559Of<T>()` 的实现代码移除 `T(0) is Float16` 分支，仅保留 `Float64`/`Float32` 检测。§10 对照表中 `Float16` 行改为 `false`，标注为简化策略排除项 |
| **P6（轻微）** — `bitwiseNot()` 对 `VecN<Bool,Q>` 的迁移影响未纳入 §11 迁移成本评估 | §11 新增「11.4 `bitwiseNot()` 迁移影响（`VecN<Bool, Q>` 场景）」子节，评估行为差异、受影响的表达式模式、迁移规则和工作量估测 |
| **P7（轻微）** — `Format`/`Display`/`ToString` 输出未覆盖 | §3.2 Hashable 实现策略后新增「字符串表示策略」段落，约定首轮不实现自定义 `toString()`/`Format`/`Display`，依赖仓颉默认 struct 字符串输出 |

---

`DESIGN_WRITTEN:C:\Develop\Software\cjglm_wp\harness\redeliberations\202606170050_glm-migration-ood\a_v11_copy_from_v10.md`
主Agent请勿阅读产出文件内容，直接将路径转发给相关方。
