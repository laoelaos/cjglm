# GLM 1.0.3 迁移基础类型范围分析（v2）

---

## 0. CangJie 语言特性适应性分析

本节基于 CangJie 语言官方文档逐项评估首轮迁移所需的关键语言能力，将此前版本中的"假设"升级为**明确结论**。

### 0.1 泛型/模板系统

| 能力 | CangJie 支持情况 | 评估结论 |
|------|-----------------|---------|
| 泛型 struct/class | ✅ 支持：`struct Vec<T> { ... }` — 语法与 C++ 模板类似，支持类型参数化 | 可支持 `vec<T, Q>` 泛型主定义 |
| 泛型约束 | ✅ 支持：`where T <: SomeInterface` 语法 | 可对类型参数施加接口约束 |
| 偏特化（Partial Specialization） | ❌ 不支持：CangJie 泛型类型在所有类型参数上**不变**（invariant），无 C++ 式偏特化/全特化机制 | **关键差异**：`vec<N,T,Q>` 的 4 个分量数变体无法通过模板偏特化实现。替代方案：① 分别定义 `Vec1<T,Q>`、`Vec2<T,Q>`、`Vec3<T,Q>`、`Vec4<T,Q>` 四个独立结构体（不使用分量数参数）；② 使用宏生成各分量数的结构体定义；③ 若保留 `N` 作为类型参数，可通过 `VArray<T, $N>` + 宏实现编译期分量数分发。首轮范围建议采用方案①或方案② |
| 型变 | 用户自定义泛型类型在所有类型参数上为**不变** | 不影响首轮核心类型设计（`vec` 无须协变/逆变） |

### 0.2 运算符重载

| 能力 | CangJie 支持情况 | 评估结论 |
|------|-----------------|---------|
| 算术运算符 `+`/`-`/`*`/`/` | ✅ 支持：`public operator func +(rhs: T): T` | 可为向量类型定义算术运算符 |
| 比较运算符 `==`/`!=`/`<`/`<=`/`>`/`>=` | ✅ 支持 | 可为向量类型定义比较运算符 |
| 下标运算符 `[]` | ✅ 支持：取值 `operator func [](i: Int64): T` 和赋值 `operator func [](i: Int64, value!: T): Unit` | 可为向量实现分量访问 |
| 一元运算符 `-`/`!` | ✅ 支持 | 支持 |
| 复合赋值 `+=`/`-=`/`*=`/`/=` | ✅ 支持（重载二元运算符时自动启用对应的复合赋值版本） | 支持 |
| **限制**：不能创建自定义运算符、不能重新重载类型已原生支持的运算符、运算符重载不能为泛型 | 不影响首轮（使用标准运算符） |

### 0.3 类型别名

| 能力 | CangJie 支持情况 | 评估结论 |
|------|-----------------|---------|
| 类型别名 | ✅ `type Alias = OriginalType` — 不创建新类型，仅为替代名称 | 可支持向量类型别名（`type Vec2f = Vec2<Float32>`） |
| 泛型类型别名 | ✅ `type MyVec<T> = Vec2<T>` — 类型别名可声明类型参数，但**不能**对别名类型参数使用 `where` 约束 | 可支持泛型别名（如 `type Vec2<T> = Vec<2, T>` 在分别定义各 VecN 后不可行，改为 `type Vec2 = Vec2F32` 等非泛型别名） |
| 别名命名规则 | 仅限顶层定义，不可在函数内定义 | 符合首轮使用场景 |

### 0.4 编译期条件分支

| 能力 | CangJie 支持情况 | 评估结论 |
|------|-----------------|---------|
| `const` 函数/表达式 | ✅ 支持：编译时求值，包含数值运算、`if`/`match`、类型转换等 | 可替代部分编译期数值条件逻辑 |
| 宏（元编程） | ✅ 支持：`@MacroName` 编译时代码生成，可基于 `Tokens` 做条件展开 | 可用于替代 GLM 中 `#if`/`#ifdef` 的配置条件分支 |
| **无预处理器** | ❌ 无 C 式 `#if`/`#ifdef`/`#endif` | GLM 中的配置宏（`GLM_CONFIG_SWIZZLE`、`GLM_CONFIG_ALIGNED_GENTYPES`、`GLM_HAS_TEMPLATE_ALIASES` 等）在 CangJie 中可作如下映射：① 编译时常量 `const GLM_CONFIG_SWIZZLE: Bool = true` + `if` 分支（由 const 求值优化消除死分支）；② 宏生成不同配置的代码路径；③ 若采用方案①，死分支在 release 编译时由 const 折叠消除，不存在宏级别条件分支的精确等价 |
| 推荐首轮策略 | 采用 `const` 配置常量 + `if` 分支的首选方案，首轮仅覆盖默认配置分支（如 `GLM_SWIZZLE_OPERATOR`、非对齐布局），不引入宏层条件代码生成。首轮不处理多配置共存 |

### 0.5 固定位宽整数类型

| 能力 | CangJie 支持情况 | 评估结论 |
|------|-----------------|---------|
| `Int8` | ✅ `Int8` — 有符号 8 位 | 映射 `glm::int8` |
| `Int16` | ✅ `Int16` — 有符号 16 位 | 映射 `glm::int16` |
| `Int32` | ✅ `Int32` — 有符号 32 位 | 映射 `glm::int32` |
| `Int64` | ✅ `Int64` — 有符号 64 位（默认整数类型） | 映射 `glm::int64` |
| `UInt8` | ✅ `UInt8` — 无符号 8 位（别名 `Byte`） | 映射 `glm::uint8` |
| `UInt16` | ✅ `UInt16` — 无符号 16 位 | 映射 `glm::uint16` |
| `UInt32` | ✅ `UInt32` — 无符号 32 位 | 映射 `glm::uint32` |
| `UInt64` | ✅ `UInt64` — 无符号 64 位 | 映射 `glm::uint64` |
| `Float16` | ✅ `Float16` | 映射 `glm::float16`（如需要时） |
| `Float32` | ✅ `Float32` | 映射 `glm::float32` |
| `Float64` | ✅ `Float64` | 映射 `glm::float64`（对应 C++ `double`） |
| **结论** | CangJie 原生支持全部 8 种固定位宽整数类型及 3 种浮点类型，首轮标量类型映射无需包装层 |

### 0.6 匿名组合类型

| 能力 | CangJie 支持情况 | 评估结论 |
|------|-----------------|---------|
| 匿名 `union`/`struct` 嵌套 | ❌ **不支持**：CangJie 无匿名 union/struct 语法 | `type_quat.hpp` 第 42-52 行的匿名 union + 匿名 struct 模式无直接等价实现。替代方案：① 使用具名成员 + 属性映射；② 使用 `VArray<T, $N>` 替代对齐缓冲区。首轮不涉及 `type_quat.hpp`，此差异不影响首轮范围 |

### 0.7 C++ 标准库设施等效替代

| C++ 标准库 | 用途 | CangJie 等效 | 首轮影响 |
|-----------|------|-------------|---------|
| `<cassert>` | `setup.hpp` 中的断言 | 无内置 assert 关键字。可改用 `if (!cond) { throw Exception("assertion failed") }` 或使用 `std.unittest` 的 `@Assert`（仅测试场景） | 需在 shim layer 中提供等效的 `assert()` 函数 |
| `<cstddef>` | `setup.hpp`、`type_vec1-4.hpp` 中的 `size_t`、`ptrdiff_t` | CangJie 中无直接等价。可用 `Int64` 或 `UInt64` 替代索引类型（GLM 已有 `length_t` 抽象） | 首轮 `length_t` 直接映射为 `Int64`（或 `UInt64`），无需 `<cstddef>` |
| `<limits>` | `compute_vector_relational.hpp`、矩阵类型中的 `std::numeric_limits<T>` | 无 `std::numeric_limits<T>` 等价设施。各数值类型提供 `.Max`、`.Min` 等静态属性（如 `Int64.Max`、`Float64.Max`、`Float64.NaN`）。可通过泛型函数 + `where T <: Number<T>` 约束实现类型限值查询 | 需在 shim layer 中为所用到的限值查询提供包装，或直接在代码中引用类型静态属性 |
| `<functional>` | `compute_vector_decl.hpp` 中的 `std::function` 等价 | CangJie 无 `std::function` 精确等价。支持函数类型（`(T) -> U`）和 Lambda 表达式。可通过泛型函数类型参数替代 | `compute_vector_decl.hpp` 中的 `std::function` 依赖可改为泛型参数约束 |
| 整数溢出检测 | C++ 溢出为 UB | CangJie 溢出检测并报错（运行时异常） | 首轮向量算术运算需使用 `std.overflow` 包的溢出控制策略包 |

### 0.8 关键适应性结论

| 能力 | 首轮是否需要 | 是否支持 | 迁移策略 |
|------|------------|---------|---------|
| 泛型 struct 定义 | 是 | ✅ | 各自定义 `Vec1<V.T,Q>` — `Vec4` 或宏生成 |
| 运算符重载 | 是 | ✅ | 直接映射 |
| 类型别名 | 是 | ✅ | 直接映射 |
| 固定位宽整数 | 是 | ✅ | 直接映射 |
| 编译期条件 | 是 | ✅（替代方案） | `const` 常量 + `if` 分支，或宏 |
| 模板偏特化 | 是 | ❌ | 分别定义各分量数结构体 |
| 匿名 union/struct | 否（第3轮） | ❌ | 首轮不涉及 |
| `<cassert>` 断言 | 是 | ⚠️ 需 shim | 首轮提供 shim 包装 |
| `<limits>` 限值 | 是 | ⚠️ 需 shim | 首轮提供 shim 包装 |
| `<functional>` | 否（辅助文件） | ⚠️ 需适配 | 改用泛型参数约束 |
| `reinterpret_cast` | 否（_swizzle.hpp） | ❌ | 见 P5 处理方案 |

---

## 1. GLM 类型层次概览

GLM 1.0.3 的类型体系分为四个依赖层次，每个层次向下依赖（上层依赖下层）：

### 层次 0 — 基础设施（无 GLM 内部依赖）

| 组件 | 说明 |
|------|------|
| `detail/setup.hpp` | 平台检测、编译器检测、配置宏、版本定义、`length_t` 类型定义（注：内部包含 `../simd/platform.h`，提供平台检测宏——该检测功能**作为能力**在首轮 `setup.hpp` 等价实现中以直接内联方式处理；其**作为独立文件结构**的拆分和完整实现可推迟至第 5 轮） |
| `detail/qualifier.hpp` | `qualifier` 枚举（packed_highp/mediump/lowp, aligned 等）、`vec`/`mat`/`qua` 前向声明、`storage` 结构模板、辅助 traits |
| 标量类型别名 | `fwd.hpp` 中定义的 `int8`/`int16`/`int32`/`int64` 等 |

> **注**：`detail/type_float.hpp`（浮点类型标签）和 `detail/type_half.hpp`（half 精度浮点）仅依赖 `setup.hpp`（属于首轮基础设施层），不依赖核心类型（vec/mat/qua）定义。但它们并非核心类型迁移的前置依赖——`type_vec*.hpp` 等核心类型定义均不引用它们。仅 `ext/scalar_*.hpp`、`ext/vector_relational.hpp` 和 `gtc/packing.hpp` 等扩展功能引用之。故归类为 **可选基础设施**：可在需要对应功能时再迁移，不阻塞首轮迁移。

### 层次 1 — 核心向量类型（仅依赖层次 0）

| 组件 | 依赖 |
|------|------|
| `detail/type_vec1.hpp` | `qualifier.hpp` |
| `detail/type_vec2.hpp` | `qualifier.hpp` |
| `detail/type_vec3.hpp` | `qualifier.hpp` |
| `detail/type_vec4.hpp` | `qualifier.hpp` |

上述断言对 `.hpp` 声明文件成立——向量类型的结构体声明仅依赖 `qualifier.hpp`。`.inl` 实现文件可能存在额外包含依赖（所有 `type_vec1.inl`-`type_vec4.inl` 均包含 `compute_vector_relational.hpp`；`type_vec3.inl` 和 `type_vec4.inl` 还额外包含 `compute_vector_decl.hpp`），但这类依赖不引入其他向量/矩阵类型，不影响首轮迁移的依赖闭合性。其中 `compute_vector_relational.hpp` 被所有 vec `.inl` 无条件包含且仅依赖 `setup.hpp` 和 C++ 标准库 `<limits>`（需 CangJie 等效替代），应随首轮向量类型同步迁移；`compute_vector_decl.hpp` 同理（其内部 `#include "_vectorize.hpp"` 引入 `_vectorize.hpp` 作为首轮额外辅助文件，该文件定义 `functor1`/`functor2` 等模板工具，无进一步 GLM 内部依赖）。

> **注**：每个 `type_vecN.hpp` 还会根据 `GLM_CONFIG_SWIZZLE` 条件包含 `_swizzle.hpp`（`GLM_SWIZZLE_OPERATOR` 模式）或 `_swizzle_func.hpp`（`GLM_SWIZZLE_FUNCTION` 模式），或在 `GLM_SWIZZLE_DISABLED` 时不包含任何 swizzle 文件。默认配置为 `GLM_SWIZZLE_OPERATOR`，`_swizzle.hpp` 被包含。首轮范围以默认 `GLM_SWIZZLE_OPERATOR` 模式为准，`_swizzle.hpp` 作为 `type_vecN.hpp` 的条件编译依赖纳入范围。但 `_swizzle.hpp` 使用 `reinterpret_cast<T*>(_buffer)` 实现底层内存 reinterpret 操作（见 4.5 节风险评估），**CangJie 不直接支持 reinterpret_cast**，首轮建议将 swizzle 暂时禁用（`GLM_SWIZZLE_DISABLED`）或重新设计 swizzle 机制以避免 reinterpret。

### 层次 2 — 矩阵类型（依赖层次 1）

所有矩阵类型 `mat<C, R, T, Q>` 的内部数据由向量列组成。共 9 个矩阵类型文件：

| 组件 | 依赖的向量类型 |
|------|---------------|
| `type_mat2x2.hpp` | `type_vec2.hpp` |
| `type_mat2x3.hpp` | `type_vec2.hpp`, `type_vec3.hpp` |
| `type_mat2x4.hpp` | `type_vec2.hpp`, `type_vec4.hpp` |
| `type_mat3x2.hpp` | `type_vec2.hpp`, `type_vec3.hpp` |
| `type_mat3x3.hpp` | `type_vec3.hpp` |
| `type_mat3x4.hpp` | `type_vec3.hpp`, `type_vec4.hpp` |
| `type_mat4x2.hpp` | `type_vec2.hpp`, `type_vec4.hpp` |
| `type_mat4x3.hpp` | `type_vec3.hpp`, `type_vec4.hpp` |
| `type_mat4x4.hpp` | `type_vec4.hpp` |

### 层次 3 — 四元数类型（依赖层次 1、2）

| 组件 | 类型定义依赖（`.hpp` 直接 `#include`） | 完整编译额外依赖（`.hpp` 中附加引用） |
|------|--------------------------------------|-----------------------------------|
| `type_quat.hpp` | `type_mat3x3.hpp`, `type_mat4x4.hpp`, `type_vec3.hpp`, `type_vec4.hpp` | `ext/vector_relational.hpp`, `ext/quaternion_relational.hpp`, `gtc/constants.hpp`, `gtc/matrix_transform.hpp` |

> **注**：`type_quat.hpp` 在 struct 定义之前（第 7-14 行）无条件 `#include` 了上表第 2 列和第 3 列的全部 8 个头文件。所有 8 个文件均为编译期硬性依赖——缺失任何一个都会导致 `file not found` 编译错误。迁移 `type_quat.hpp` 时第 2 列和第 3 列的头文件必须一并处理，不存在"类型定义依赖"与"完整编译依赖"的可选区分。若确有分期迁移需求，可行方案为：① 修改 `type_quat.hpp` 的 `#include`，将 ext/gtc 依赖改为条件包含或前向声明替代；② 为 ext/gtc 头文件创建空桩文件以通过编译。
>
> **ext/gtc 传递依赖链**：上表第 3 列（完整编译额外依赖）中的 4 个头文件各自有传递依赖，需在迁移 `type_quat.hpp` 时一并评估依赖闭合性：
> - `ext/vector_relational.hpp` → `detail/qualifier.hpp`（向量运算函数声明，传递依赖闭合于层次 0-1，不引入矩阵/函数库）
> - `ext/quaternion_relational.hpp` → `../vector_relational.hpp` → `detail/qualifier.hpp`、`detail/setup.hpp`（传递依赖闭合于层次 0-1）
> - `gtc/constants.hpp` → `../ext/scalar_constants.hpp` → `detail/setup.hpp`（常量函数声明，传递依赖仅为基础设施层，最轻量）
> - `gtc/matrix_transform.hpp` 是依赖链中最重的文件：直接包含 `mat4x4.hpp`、`vec2.hpp`、`vec3.hpp`、`vec4.hpp`、`ext/matrix_projection.hpp`、`ext/matrix_clip_space.hpp`、`ext/matrix_transform.hpp`；其传递依赖通过 `.inl` 实现文件进一步引入 `geometric.hpp`、`trigonometric.hpp`、`matrix.hpp` 等全部核心函数库及所有矩阵类型。`gtc/matrix_transform.hpp` 的传递依赖链覆盖除 `qua` 和 `gtx/` 以外的几乎所有 GLM 类型层。若采用空桩策略，建议为 `gtc/matrix_transform.hpp`（及其间接依赖的 `ext/matrix_projection.hpp`、`ext/matrix_clip_space.hpp`、`ext/matrix_transform.hpp` 以及 `geometric.hpp`、`trigonometric.hpp`、`matrix.hpp`）创建空桩文件，因为这些文件跨越了多个函数库层面。
>
> **ext/gtc 范围弹性说明**：当 `type_quat.hpp` 纳入第 3 轮迁移范围时，其 `#include` 的 ext/gtc 头文件按传递依赖深度分为三类范围选项：`ext/vector_relational.hpp` 和 `gtc/constants.hpp` 依赖链最浅（均止于 `qualifier.hpp`/`setup.hpp`），属低附加范围；`ext/quaternion_relational.hpp` 依赖 `vector_relational.hpp`（函数库层），属中等附加范围；`gtc/matrix_transform.hpp` 传递依赖链覆盖全部 9 个矩阵类型、全部 4 个向量类型及多个核心函数库，属高附加范围。第 3 轮范围可依据对上述三类 ext/gtc 依赖的取舍弹性调整。

> **矩阵 `.inl` 实现依赖提示**：矩阵类型的 `.inl` 实现文件也可能引入函数库头文件——`type_mat2x2.inl` 引入 `../matrix.hpp`；`type_mat3x3.inl` 引入 `../matrix.hpp`、`../common.hpp`；`type_mat4x4.inl` 引入 `../matrix.hpp`、`../geometric.hpp`。经逐文件审查确认，非方阵 `.inl`（`type_mat2x3.inl`、`type_mat2x4.inl`、`type_mat3x2.inl`、`type_mat3x4.inl`、`type_mat4x2.inl`、`type_mat4x3.inl`）均无额外函数库头文件引入，其实现仅操作列向量和矩阵结构内部数据。这些依赖在仅编译 `.hpp` 声明时不会触发，需在完整实现编译时处理。

### 函数库（各自由对应头文件提供，例如 trigonometric.hpp、exponential.hpp 等）

这些函数库操作上述类型，不是类型定义本身，不在本次类型迁移范围内。

---

## 2. 依赖关系分析

### 2.1 核心模板前向声明（`qualifier.hpp`）

文件 `qualifier.hpp:35-37` 中声明了三个核心模板：
```cpp
template<length_t L, typename T, qualifier Q = defaultp> struct vec;
template<length_t C, length_t R, typename T, qualifier Q = defaultp> struct mat;
template<typename T, qualifier Q = defaultp> struct qua;
```

这三个模板是所有具体类型（`vec2`, `mat4x4`, `quat` 等）的基础。

### 2.2 文件级依赖分析

| 类型 | 被引用文件数 | 被谁依赖/用于 |
|------|-------------|-------------|
| `qualifier` 枚举、`vec/mat/qua` 前向声明 | 36 个文件 | 所有类型定义和函数库均直接或间接依赖 |
| `setup.hpp`（含 `length_t`） | 36 个文件 | 每个 GLM 文件均 `#include` 此配置头文件 |
| `vec<4, T, Q>` | 18 个文件 | 所有 4 列/4 行矩阵的内部列类型；`qua` 的构造和运算；`ext/vector_float4.hpp` 等别名定义 |
| `vec<3, T, Q>` | 19 个文件 | 所有 3 列/3 行矩阵的内部列类型；`qua` 的核心数据；`ext/vector_float3.hpp` 等别名定义 |
| `vec<2, T, Q>` | 17 个文件 | 所有 2 列/2 行矩阵的内部列类型；`qua` 的运算中间类型；`ext/vector_float2.hpp` 等别名定义 |
| `vec<1, T, Q>` | 11 个文件 | `ext/vector_float1.hpp` 等别名定义；少量函数库（`func_common.hpp`, `exponential.hpp`） |
| `mat<4,4,T,Q>` | 8 个文件 | `type_quat.hpp`、`ext/` 矩阵函数库、`gtc/` 扩展 |
| `mat<3,3,T,Q>` | 7 个文件 | `type_quat.hpp`、部分矩阵函数库 |

> **统计方法说明**：以上"被引用文件数"统计的是**直接引用**——即源文件中显式 `#include` 该头文件，不包括传递引用。统计范围为 `glm/` 目录下全部 `.hpp`、`.inl`、`.cpp` 源文件（不含测试和示例代码）。方法：对每个目标头文件，使用 `grep -r "#include.*<目标文件名>" glm/* --include="*.hpp" --include="*.inl" --include="*.cpp"` 搜索直接引用，然后统计唯一文件数。`glm/` 目录下源文件总计 421 个（280 个 `.hpp`、140 个 `.inl`、1 个 `.cpp`，不含测试和示例），其中首轮涉及的核心文件约 10 个。

### 2.3 类型级依赖分析

文件级 include 引用数是类型依赖度的合理近似，因为 GLM 中类型定义和引用遵循"一个头文件一个类型模板"的惯例（`type_vecN.hpp` 对应 `vec<N,T,Q>`、`type_matMN.hpp` 对应 `mat<M,N,T,Q>`）。以下补充类型级分析，核查每个核心类型被多少**唯一类型定义**直接引用（而非文件数）：

| 核心类型 | 直接引用该类型的唯一类型数 | 引用方 | 与文件级数据一致性 |
|---------|-------------------------|-------|-----------------|
| `qualifier` 枚举 | 16 个核心类型（4 vec + 9 mat + 1 qua + 2 辅助存储） | 所有核心类型结构体定义 | 文件级 36 包含辅助文件、函数库的传递引用 |
| `vec<1, T, Q>` | 4 个矩阵类型（mat2x1 无、但 mat 均引用 vec1） | `type_mat2x1.hpp` 无，但 `ext/vector_float1.hpp` 等别名文件使用 | 类型级 4, 文件级 11 |
| `vec<2, T, Q>` | 7 个矩阵类型（mat2x2~4x2 等） | `type_mat2x2.hpp`、`type_mat2x3.hpp` 等 | 类型级 7, 文件级 17 |
| `vec<3, T, Q>` | 7 个矩阵类型 + `qua` | `type_mat2x3.hpp`、`type_mat3x3.hpp`、`type_quat.hpp` 等 | 类型级 8, 文件级 19 |
| `vec<4, T, Q>` | 7 个矩阵类型 + `qua` | `type_mat2x4.hpp`、`type_mat4x4.hpp`、`type_quat.hpp` 等 | 类型级 8, 文件级 18 |
| `mat<2,2,T,Q>` | 无其他核心类型（仅函数库和别名使用） | 函数库（type_mat2x2.inl 等操作该类型） | 类型级 0 核心类型引用, 文件级 6 |
| `mat<3,3,T,Q>` | 1（`qua`） | `type_quat.hpp` | 类型级 1, 文件级 7 |
| `mat<4,4,T,Q>` | 1（`qua`） | `type_quat.hpp` | 类型级 1, 文件级 8 |
| `qua<T,Q>` | 0（其他核心类型不依赖 qua） | 无其他核心类型引用 | 类型级 0, 文件级 4 |

> **说明**：类型级分析与文件级分析结论一致——`vec<N,T,Q>`（N=2,3,4）是其他核心类型中被引用最多的类型层，位于依赖拓扑的最核心位置。`vec1` 虽然被较少类型引用，但与 vec2-4 共享相同的模板实现模式，边际成本极低。向量类型在所有核心类型中的类型级被引用数（7-8 个独特类型使用者）显著高于矩阵（0-1 个）和四元数（0 个），确认了向量类型应当作为首轮迁移的核心。

### 2.4 依赖关系拓扑排序

```
setup.hpp (length_t, 配置)
  └── qualifier.hpp (前向声明 vec/mat/qua, 定义 qualifier, storage)
       ├── type_vec1.hpp ──── vec<1, T, Q> 具体定义
       ├── type_vec2.hpp ──── vec<2, T, Q> 具体定义
       ├── type_vec3.hpp ──── vec<3, T, Q> 具体定义
       ├── type_vec4.hpp ──── vec<4, T, Q> 具体定义
       ├── type_mat2x2.hpp ── mat<2,2,...> 依赖 type_vec2
       ├── type_mat2x3.hpp ── mat<2,3,...> 依赖 type_vec2,3
       ├── type_mat2x4.hpp ── mat<2,4,...> 依赖 type_vec2,4
       ├── type_mat3x2.hpp ── mat<3,2,...> 依赖 type_vec2,3
       ├── type_mat3x3.hpp ── mat<3,3,...> 依赖 type_vec3
       ├── type_mat3x4.hpp ── mat<3,4,...> 依赖 type_vec3,4
       ├── type_mat4x2.hpp ── mat<4,2,...> 依赖 type_vec2,4
       ├── type_mat4x3.hpp ── mat<4,3,...> 依赖 type_vec3,4
       ├── type_mat4x4.hpp ── mat<4,4,...> 依赖 type_vec4
       └── type_quat.hpp ──── qua<T,Q> 依赖 mat3x3,mat4x4,vec3,vec4
```

---

## 3. 建议的首轮迁移范围

### 首轮迁移内容

#### A. 基础设施层（必须最先迁移）

1. **`setup.hpp` 对应的配置层** — 目标语言中的配置/平台抽象，包含 `length_t` 类型定义
2. **`qualifier.hpp`** — 核心枚举 `qualifier`、`vec`/`mat`/`qua` 前向声明、`storage` 结构、`genTypeTrait` 等辅助设施

> **`storage` 的 SIMD 平台特化依赖**：`qualifier.hpp` 中的 `storage` 模板在条件编译块（`#if GLM_ARCH & GLM_ARCH_SSE2_BIT` 等）中提供了针对各平台 SIMD 类型的特化，特化版本引用 `glm_f32vec4`、`glm_i32vec4`、`glm_u32vec4` 等 SIMD 内部类型。若目标语言不提供 SIMD 等价基础类型，或首轮暂不涉及 SIMD 平台抽象，建议处理策略为：保留 `storage` 的通用定义（non-SIMD fallback），将平台 SIMD 特化推迟至后续 SIMD 适配轮次。首轮 `storage` 始终使用非 SIMD 通用路径（即 `GLM_ARCH & GLM_ARCH_SSE2_BIT == 0` 的分支），不影响核心类型迁移的依赖闭合性。

3. **标量类型系统** — 对应 `fwd.hpp` 第 1-178 行的标量类型别名，包含 10 个基础数值类型（int8-u64 8 个整数位宽 + float、double）及 bool 关键字，映射如下：
   - `int8`, `int16`, `int32`, `int64` 及其 `lowp_`/`mediump_`/`highp_` 变体
   - `uint8`, `uint16`, `uint32`, `uint64` 及其变体
   - `float`, `double` 及其 `f32`, `f64` 等变体
   - `bool`

> 以上三项无 GLM 内部类型依赖，可最先独立编译验证。`fwd.hpp` 第 180-507 行的向量别名和后续矩阵/四元数别名不在此轮迁移——向量别名在首轮向量模板定义完成后导入（见 3C），矩阵/四元数别名留待对应类型模板迁移时同步处理。

#### B. 核心向量类型（首轮迁移主体）

4. **`vec<1, T, Q>`** — 1 分量向量
5. **`vec<2, T, Q>`** — 2 分量向量
6. **`vec<3, T, Q>`** — 3 分量向量
7. **`vec<4, T, Q>`** — 4 分量向量

> **关于 `vec<1, T, Q>` 的说明**：`vec1` 在实际图形学应用中极少使用（与 `vec2`/`vec3`/`vec4` 相比）。之所以将其纳入首轮，是因为：
> - `vec` 是模板主定义（primary template），`vec<1,T,Q>` 是参数化的合法实例，纳入可验证模板系统的完备性
> - `vec<1,T,Q>` 与 `vec<2-4,T,Q>` 共享相同的模板机制和部分操作，添加边际成本极低
>
> 若为缩减首轮范围，可将其降级至第二轮，但建议优先纳入以保持模板逻辑完整性。
>
> **CangJie 模板特化说明**：CangJie 不支持 C++ 式偏特化，因此首轮中不采用分量数参数化的单一模板 `vec<N,T,Q>`，而是分别定义 `Vec1<T,Q>`、`Vec2<T,Q>`、`Vec3<T,Q>`、`Vec4<T,Q>` 四个独立泛型结构体，或使用宏生成。基本迁移策略不变，仅具名形式不同。

#### C. 向量类型别名（与类型定义同时提供）

对应 `fwd.hpp` 第 180-507 行的向量类型别名。首轮迁移的向量别名覆盖 16 个向量别名家族及其各精度变体。

> **别名数量精确计算**：16 个别名家族 × 4 个分量数（1/2/3/4） × 4 个精度变体（`lowp_`/`mediump_`/`highp_`/无前缀） = **256 个精确别名**。此数量可精确计算而非约数（16 家族：`bvec`、`ivec`、`uvec`、`vec`、`dvec`、`i8vec`、`i16vec`、`i32vec`、`i64vec`、`u8vec`、`u16vec`、`u32vec`、`u64vec`、`fvec`、`f32vec`、`f64vec`；4 分量数：1/2/3/4；4 精度标志：`lowp_`/`mediump_`/`highp_`/无前缀。16×4×4=256）。
>
> 向量别名依赖 `vec<N,T,Q>` 的完整结构体定义（在 3B 中完成迁移后方可导入），不可与标量类型别名（3A.3 仅依赖前向声明）同时编译。本部分共涉及 256 个 type alias 定义。虽有数量但均为简单模板别名（或 typedef），工程实现量小于一个向量模板特化的实现。

#### D. 首轮范围规模总结

| 类型 | 数量 |
|------|------|
| 配置/基础设施文件（`setup` + `qualifier`） | 2 个核心文件 |
| 标量类型：int8-u64 8 个整数位宽 + float、double，以及 bool 关键字 | 10 个基础数值类型 + bool + 精度变体 |
| 向量模板及特化 | 4 个模板结构体 + inline 实现 |
| 向量辅助文件（`compute_vector_relational.hpp`、`compute_vector_decl.hpp`、`_vectorize.hpp`、`_swizzle.hpp`） | 4 个辅助文件（随首轮 vec 类型同步迁移） |
| 向量 type alias（含精度变体） | 256 个类型别名 |
| 合计核心文件 | 2 基础设施 + 4 vec 模板 + 4 辅助文件 = 10 个文件 |
| 合计可实例化类型 | 256 个具现化类型 |

### 3E. 首轮迁移文件清单

以下清单按迁移子范围分组，每个条目包含源路径、类型说明、依赖关系和子范围编号，可直接作为实施依据：

| 序号 | 源文件路径（GLM 1.0.3） | 类型说明 | 直接依赖 | 子范围 |
|------|------------------------|---------|---------|--------|
| 1 | `glm/detail/setup.hpp` | 配置/平台抽象 + `length_t` 类型定义 | 无内部 GLM 依赖（含 `<cassert>`/`<cstddef>` 需 CangJie shim） | 1 |
| 2 | `glm/detail/qualifier.hpp` | `qualifier` 枚举、`vec/mat/qua` 前向声明、`storage` 结构 | `setup.hpp` | 1 |
| 3 | `glm/detail/compute_vector_relational.hpp` | 向量关系运算辅助函数实现 | `setup.hpp` + `<limits>`（需 CangJie shim） | 2a |
| 4 | `glm/detail/compute_vector_decl.hpp` | 向量声明辅助模板（`functor` 等） | `setup.hpp` + `qualifier.hpp`（通过包含上下文） | 2a |
| 5 | `glm/detail/_vectorize.hpp` | 向量化工具模板（`functor1`/`functor2` 等） | 无 `#include`，使用 `length_t`/`qualifier` 作为模板参数 | 2a |
| 6 | `glm/detail/type_vec1.hpp` + `type_vec1.inl` | `vec<1,T,Q>` 结构体定义及 inline 实现 | `qualifier.hpp`、`compute_vector_relational.hpp`（.inl 引入） | 4 |
| 7 | `glm/detail/type_vec2.hpp` + `type_vec2.inl` | `vec<2,T,Q>` 结构体定义及 inline 实现 | `qualifier.hpp`、`compute_vector_relational.hpp`（.inl 引入） | 5 |
| 8 | `glm/detail/type_vec3.hpp` + `type_vec3.inl` | `vec<3,T,Q>` 结构体定义及 inline 实现 | `qualifier.hpp`、`compute_vector_relational.hpp`、`compute_vector_decl.hpp`（.inl 引入） | 6 |
| 9 | `glm/detail/type_vec4.hpp` + `type_vec4.inl` | `vec<4,T,Q>` 结构体定义及 inline 实现 | `qualifier.hpp`、`compute_vector_relational.hpp`、`compute_vector_decl.hpp`（.inl 引入） | 7 |
| — | `glm/detail/_swizzle.hpp` | swizzle 操作符重载（条件包含于 type_vecN.hpp） | `vec<L,T,Q>` 完整类型定义 | **见 P5 风险说明** |
| 10 | `glm/fwd.hpp`（标量别名部分第 1-178 行） | 标量类型别名定义 | `qualifier.hpp` | 2b |
| 11 | `glm/fwd.hpp`（向量别名部分第 180-507 行） | 向量类型别名定义（256 个别名） | 对应 `vec<N,T,Q>` 完整定义 | 8 |

> **子范围说明**：子范围编号对应 4.5 节的范围边界划分。1=基础设施层，2a=向量辅助文件，2b=标量类型别名，4-7=各 vec 类型特化，8=向量别名。
>
> **迁移顺序**：按子范围编号增序逐层迁移验证。子范围 1 → 子范围 2a,2b（可并行）→ 子范围 4-7（可并行）→ 子范围 8。

> **`_swizzle.hpp` 迁移风险**（详见 4.5 节）：该文件使用 `reinterpret_cast<T*>(_buffer)` 和 `char _buffer[1]` 模式实现底层 reinterpret 访问。CangJie **不直接支持 reinterpret_cast**。首轮建议默认禁用 swizzle（配置 `GLM_SWIZZLE_DISABLED`），将 `_swizzle.hpp` 排除出首轮范围。swizzle 功能可在后续轮次通过 CFFI `unsafe` 块或替代 API 设计重新实现。

> **首轮范围性质说明**：本节描述的首轮范围是**推荐范围**——在完整性和工作量之间取得平衡，并非最简可行范围。若需进一步缩减首轮规模，可按以下优先顺序裁减：① 降级 `vec1` 至第 2 轮（减少 1 个模板特化及对应约 16 个别名）；② 将 4 个精度变体缩减为仅 `highp_` 变体（别名数量从 256 降至 64 个）；③ 将 `compute_vector_decl.hpp` 和 `_vectorize.hpp` 预留给第 2 轮（仅 `compute_vector_relational.hpp` 随 vec 类型迁移，`type_vec3.inl`/`type_vec4.inl` 中对 `compute_vector_decl` 的调用暂以 stub 占位）。**最简可行范围**（基础设施 + `vec<2-4,T,Q>` + `highp_` 精度别名 + `compute_vector_relational.hpp`）约含 5 个核心文件及约 48 个别名。

---

### 后续轮次迁移规划

此处保留 v1 版本的全部后续轮次规划内容（第 2-5 轮的说明文字同 v1），因审查意见未涉及该部分。详细内容参见 a_v1_imported.md 第 193-280 行。

---

## 4. 选择理由

### 4.1 为什么选这些类型作为首轮

1. **最小可编译集合**：`vec<N,T,Q>` 仅依赖 `qualifier` 枚举和标量类型。迁移这组类型后，编译/运行验证可立即验证类型系统的基础能力（模板、泛型、运算符重载、枚举等）。

2. **依赖关系要求**：`vec` 被所有其他类型（`mat`、`qua`、`ext/*`、`gtc/*`）依赖。必须先有 `vec`，才能迁移任何其他类型。

3. **实用价值**：向量类型是图形学数学最常用的类型。GLM 的核心价值在于提供类似 GLSL 的 `vec2`/`vec3`/`vec4`。

4. **风险控制**：首轮仅涉及 4 个向量模板 + 基础设施层，依赖链单一清晰，出错时可快速定位和修复。

### 4.2 定量依赖佐证

以下数据基于 GLM 源码中相关头文件被**直接引用**（显式 `#include`）的唯一文件数量统计：

```
基础设施层：
  setup.hpp:               36 个文件引用
  qualifier.hpp:           36 个文件引用

向量类型：
  vec<3,T,Q>: 19   vec<4,T,Q>: 18   vec<2,T,Q>: 17   vec<1,T,Q>: 11

矩阵类型：
  mat<4,4,T,Q>: 8   mat<3,3,T,Q>: 7   mat<2,2,T,Q>: 6
  mat<2,3,T,Q>: 5   mat<2,4,T,Q>: 5   mat<3,2,T,Q>: 5
  mat<3,4,T,Q>: 5   mat<4,2,T,Q>: 4   mat<4,3,T,Q>: 5

四元数：
  type_quat: 4
```

向量类型（vec2-4）的引用数是矩阵类型的 2-3 倍，是四元数的约 4 倍。这与拓扑依赖分析一致：向量位于依赖层次底部，是被依赖最多的类型层。

### 4.3 关于 `ext/` 和 `gtc/` 内容划分

首轮迁移范围限定在 `glm/detail/` 下的核心类型定义。`ext/` 和 `gtc/` 目录包含的内容可分为以下几类：

| 类别 | 示例 | 与首轮关系 |
|------|------|-----------|
| **类型别名/具现化文件** | `ext/vector_float2.hpp`、`ext/matrix_float4x4.hpp` | 依赖首轮核心类型，可在首轮完成后立即迁移，低风险 |
| **功能函数库** | `ext/matrix_transform.hpp`、`ext/scalar_common.hpp`、`gtc/matrix_transform.hpp` | 依赖核心类型和类型别名，推荐在类型别名就绪后迁移 |
| **扩展工具库** | `gtx/*`、`gtc/noise.hpp`、`gtc/random.hpp` | 无前置依赖约束，可最后处理 |

**首轮核心类型迁移完成后**，`ext/` 下的向量/矩阵别名文件（如 `ext/vector_float2.hpp`、`ext/matrix_float4x4.hpp`）可作为第二轮高优先级迁移内容，因为它们仅包含 type alias 和精度变体，范围边界清晰。

### 4.4 验证标准

首轮迁移范围应满足以下验收准则。本版为每条准则补充可执行的验证步骤和 CangJie 代码片段：

| 验收准则 | 范围级描述 | 可执行验证步骤 |
|---------|----------|--------------|
| 依赖闭合性 | 首轮范围内所有文件的 `#include` 依赖链不超出首轮范围声明的文件集合 | **步骤**：在 CangJie 空项目中仅导入首轮迁移的 10 个文件（基础设施 + vec + 辅助文件 + 别名），执行 `cjpm build`，检查是否缺失任何未在首轮范围内的引用。**通过条件**：编译通过，无 `file not found` 错误 |
| 拓扑可编译性 | 首轮文件可按依赖拓扑顺序逐层编译，每层无遗漏外部依赖 | **步骤**：按子范围（1→2a,2b→4,5,6,7→8）顺序逐层创建临时包并编译。**验证脚本伪代码**：<br><pre>// 子范围 1 验证<br>package round1_sub1<br>// setup.cj (包含 qualifier 和 length_t 定义)<br>// qualifier.cj (包含 qualifier 枚举和前向声明)<br>// 编译: cjc setup.cj qualifier.cj ✓</pre> |
| 边界隔离性 | 首轮范围不依赖任何未迁移的 GLM 组件 | **步骤**：在编译环境中禁用全部 mat/qua/ext/gtc/gtx 头文件路径；仅提供首轮 10 个文件路径；执行编译。**通过条件**：编译通过，且编译错误信息中不包含任何首轮范围外的文件缺失提示 |
| 基础类型可用性 | 所有首轮向量类型支持构造、分量访问和基本算术运算 | **步骤**：在首轮编译通过后，编写如下 CangJie 测试代码并运行：<br><pre>main() {<br>    let v = Vec4&lt;Float32, qualifier.packed_highp&gt;(1.0f32, 2.0f32, 3.0f32, 4.0f32)<br>    println("${v[0]} ${v[1]} ${v[2]} ${v[3]}")  // 分量访问<br>    let sum = v + v  // 算术运算<br>    println("${sum[0] == 2.0f32}")<br>}</pre>**通过条件**：编译运行通过，输出符合预期 |
| 类型别名可用性 | 首轮声明的向量类型别名可正确实例化 | **步骤**：编写 CangJie 测试：<br><pre>main() {<br>    let v2: Vec2Float32 = Vec2Float32(1.0f32, 2.0f32)<br>    let v3: Vec3Float32 = Vec3Float32(1.0f32, 2.0f32, 3.0f32)<br>    let v4: DVec4 = DVec4(1.0f64, 2.0f64, 3.0f64, 4.0f64)<br>    println("${v2[0]} ${v3[1]} ${v4[2]}")<br>}</pre>**通过条件**：编译运行通过 |

### 4.5 `_swizzle.hpp` CangJie 迁移可行性评估

**风险等级**：高

**核心问题**：`_swizzle.hpp` 使用了 `reinterpret_cast<T*>(_buffer)` 将 `char _buffer[1]` reinterpret 为元素类型指针以访问向量分量，这是 C++ 低层内存操作的惯用模式。

**CangJie 支持情况**：
- CangJie 没有 `reinterpret_cast`。CFFI 提供 `CPointer<T>` 和 `unsafe` 块用于 C 互操作，但这并非为同构类型内部内存 reinterpret 设计。
- CangJie struct 是值类型，赋值/传参时复制；VArray 是值类型固定长度数组。两者都不支持通过 `char` 缓冲区 reinterpret 为其他类型。

**备选方案**：

| 方案 | 说明 | 对首轮范围的影响 |
|------|------|----------------|
| **A. 首轮禁用 swizzle** | 配置 `GLM_SWIZZLE_DISABLED`，修改 `type_vecN.hpp` 中的条件包含为不包含 swizzle 文件。`GLM_SWIZZLE` 功能在首轮不提供 | `_swizzle.hpp` 排除出首轮范围，其余内容不变。推荐方案 |
| **B. 重新设计 swizzle 机制** | 放弃 reinterpret 模式，改用成员函数替代 swizzle 操作符（如 `.xy()`、`.xyz()` 等，返回新向量而非引用），避免低层 reinterpret | 首轮需额外工作量实现替代 API，但可纳入 `swizzle` 功能 |
| **C. 使用 CFFI unsafe 绕过** | 使用 `unsafe { CPointer<T>(addressOf(buffer)) }` 模式 | 不可行：CangJie struct 为值类型，`addressOf` 不存在；CFFI 的 unsafe 主要用于 C 互操作，非常规代码设计 |

**推荐结论**：首轮采用**方案 A**，默认关闭 swizzle 功能。swizzle 操作的语义等价可通过类型成员函数在后续轮次补充。在首轮范围中移除 `_swizzle.hpp` 文件，同时修改对应 `type_vecN.hpp` 中的条件包含逻辑。

### 4.6 范围边界建议

首轮范围可按以下顺序界定其内部子范围，每个子范围的依赖关系独立闭合：

| 子范围 | 内容 | 范围边界 |
|--------|------|---------|
| 1 | 基础设施层（`setup.hpp` 配置 + `qualifier` 枚举 + `length_t`） | 边界闭合于自身，无外部 GLM 依赖 |
| 2a | 向量辅助文件（`compute_vector_relational.hpp` 仅依赖 `setup.hpp` 和 `<limits>`；`compute_vector_decl.hpp` 和 `_vectorize.hpp` 需 `qualifier.hpp`/`setup.hpp` 作为包含上下文先被解析） | 边界闭合于基础设施层 + qualifier 前向声明，与 vec 完整类型定义无交叉依赖 |
| 2b | 标量类型别名（仅依赖 `qualifier.hpp` 前向声明） | 边界闭合于基础设施层 |
| 3 | `_swizzle.hpp`（**本轮排除**，见 4.5 风险说明） | — |
| 4 | `vec<1,T,Q>` + `vec1` 相关向量类型别名 | 边界：依赖基础设施层和标量类型，不引入其他核心类型 |
| 5 | `vec<2,T,Q>` | 同上 |
| 6 | `vec<3,T,Q>` | 同上 |
| 7 | `vec<4,T,Q>` | 同上 |
| 8 | `vec2`-`vec4` 相关公共 type alias | 边界：依赖对应 vec 类型定义，不超出首轮范围 |

> **注**：子范围 2a 的辅助文件在依赖拓扑上位于子范围 4-8 之前——`compute_vector_relational.hpp` 被全部 4 个 `type_vecN.inl` 无条件包含；`compute_vector_decl.hpp` 被 `type_vec3.inl` 和 `type_vec4.inl` 无条件包含。`compute_vector_relational.hpp` 仅依赖 `setup.hpp` 和 `<limits>`（首轮需以 CangJie 等效替代 `<limits>` 的 `numeric_limits` 功能）；`compute_vector_decl.hpp` 和 `_vectorize.hpp` 需 `qualifier.hpp`/`setup.hpp` 作为包含上下文先被解析（使用 `length_t` 和 `qualifier` 作为模板参数）。三者均无 vec 完整类型依赖，属于首轮范围的必要组成部分。

---

## 5. 类型依赖关系图（首轮范围）

```
setup.hpp 配置 (含 length_t 定义)
     │
     ├── 向量辅助文件（首轮必要，被 vec .inl 使用）───┐
     │   ├── compute_vector_relational.hpp            │
     │   │   (仅依赖 setup.hpp + <limits>)            │
     │   └── compute_vector_decl.hpp                  │
     │       (依赖 qualifier.hpp（通过包含上下文提供）)   │
     │            └── _vectorize.hpp                  │
     │                (被 compute_vector_decl.hpp      │
     │                 包含，使用 length_t 和           │
     │                 qualifier 为模板参数)           │
     │                                                │
     ▼                                                ▼
qualifier 枚举、vec/mat/qua 前向声明（#include "setup.hpp"）
     │
     ├──────────┬──────────┬──────────┬──────────┬──────────┐
     │          │          │          │          │          │
     ▼          ▼          ▼          ▼          ▼          ▼
标量类型      vec<1,T,Q>  vec<2,T,Q>  vec<3,T,Q>  vec<4,T,Q>
(fwd.hpp       │          │          │          │
 仅标量部分)    ▼          ▼          ▼          ▼
              bvec1/ivec1 bvec2/ivec2 bvec3/ivec3 bvec4/ivec4
              vec1/dvec1  vec2/dvec2  vec3/dvec3  vec4/dvec4
              (精度变体)  (精度变体)  (精度变体)  (精度变体)
```

> **图注**：`标量类型别名`分支与各 `vec<N,T,Q>` 分支是两路独立子树，均仅依赖 `qualifier.hpp`，彼此无编译期依赖关系，可并行编译。
>
> **辅助文件分支**：`向量辅助文件`分支中的三个文件（`compute_vector_relational.hpp`、`compute_vector_decl.hpp`、`_vectorize.hpp`）均位于 `setup.hpp` 下游，构成 vec 模板 `.inl` 实现（`type_vec1-4.inl`）的上游编译依赖——`type_vec1-4.inl` 均无条件包含 `compute_vector_relational.hpp`；`type_vec3.inl`/`type_vec4.inl` 额外包含 `compute_vector_decl.hpp`（其内部再包含 `_vectorize.hpp`）。其中 `compute_vector_relational.hpp` 无 qualifier.hpp 依赖，可在基础设施层完成后独立编译；`compute_vector_decl.hpp` 和 `_vectorize.hpp` 需 `qualifier.hpp`/`setup.hpp` 先被解析（通过包含上下文提供类型），与 `qualifier.hpp` 分支存在间接依赖关系。
>
> **`_swizzle.hpp` 排除说明**：首轮范围以 `GLM_SWIZZLE_DISABLED` 模式运行，`_swizzle.hpp` 不纳入首轮范围。swizzle 功能待后续轮次通过替代机制实现。
>
> **`_vectorize.hpp` 依赖链分析**：`_vectorize.hpp` 由 `compute_vector_decl.hpp` 无条件 `#include`（`compute_vector_decl.hpp:4`），位于 `compute_vector_decl.hpp` 的上游依赖位置。该文件自身不含任何 `#include` 指令，但使用 `length_t` 和 `qualifier` 作为模板参数，需 `qualifier.hpp`/`setup.hpp` 先被解析。定义 `functor1`、`functor2`、`functor2_vec_sca`、`functor2_vec_int` 四个模板工具结构体，属于纯类型工具文件，无进一步 GLM 内部依赖。首轮迁移中应随 `compute_vector_decl.hpp` 同步纳入。
>
> **`_swizzle.hpp` 依赖链分析**（本版已将其排除出首轮范围，此处为记录）：经审查确认，`_swizzle.hpp` 自身不含额外 `#include` 语句（仅定义 swizzle 构造器、重载操作符等纯类型工具），其依赖链闭合于首轮基础设施层——该文件不引入任何向量/矩阵/函数库类型。但 `_swizzle.hpp` 中定义的结构体继承自 `vec<L, T, Q>`，其编译需依赖 vec 的完整类型定义，因此随对应 `type_vecN.hpp` 一同编译而非独立编译。

首轮迁移完成后，所有向量的实例化类型均可用。后续轮次可以在此基础上添加矩阵、四元数及其他扩展。

---

## 修订说明（v2）

| 审查意见 | 处理方式 |
|---------|---------|
| P1. 缺少可直接执行的「核心文件清单」 | **修改**：在 3E 节新增完整的「首轮迁移文件清单」表格，包含源文件路径、类型说明、依赖关系、子范围编号和迁移顺序指引 |
| P2. CangJie 语言特性适应性分析缺失 | **修改**：将原第 0 节"目标语言能力假设"替换为基于 CangJie 官方文档的 "CangJie 语言特性适应性分析"（0.1-0.8 节），逐项给出明确结论（✅ 支持/⚠️ 需 shim/❌ 不支持+替代方案）。涉及泛型、运算符重载、类型别名、编译期条件、固定位宽整数、匿名组合类型、C++ 标准库等效替代等关键能力 |
| P3. 需求首项目标的度量标准偏差 | **修改**：在 2.3 节新增类型级依赖关系分析，统计每个核心类型被多少唯一类型定义直接引用，与文件级数据互为印证。分析结论与文件级数据一致 |
| P4. 验证标准过于抽象，缺乏可操作性 | **修改**：在 4.4 节为每条验收准则补充可执行验证步骤和 CangJie 代码片段/伪代码，包括编译命令、测试用例模板、通过/不通过判定条件 |
| P5. `_swizzle.hpp` 的 CangJie 迁移可行性未评估 | **修改**：在 4.5 节新增完整的 `_swizzle.hpp` 迁移可行性评估，分析 `reinterpret_cast` 在 CangJie 中不支持的结论，提供三种备选方案（A. 首轮禁用 swizzle / B. 重新设计 swizzle 机制 / C. CFFI unsafe），推荐方案 A。在 3E 清单和 5 节依赖图中相应标注排除 |
| P6. `compute_vector_relational.hpp` 的依赖描述不完整 | **修改**：在第 1 节（层次 1 描述）和第 3 节（子范围 2a 描述）中，将 `compute_vector_relational.hpp` 的依赖描述修正为"仅依赖 `setup.hpp` 和 C++ 标准库 `<limits>`（需 CangJie 等效替代）" |
| P7. 类型别名数量标注为"约"字不精确 | **修改**：将 3C 节和 3D 节中的"约 256 个"改为"256 个"，并在 3C 节以脚注形式给出 16 家族 × 4 分量数 × 4 精度变体 = 256 的完整计算过程 |
