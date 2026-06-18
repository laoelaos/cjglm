# GLM 1.0.3 迁移基础类型范围分析（v10）

## 目标语言能力假设

本分析结果隐含以下关于目标语言能力的假设。若目标语言不满足某项假设，需相应调整首轮迁移范围：

| 假设 | 说明 | 对首轮范围的影响 | 不成立时的调整方向 |
|------|------|-----------------|------------------|
| **泛型/模板系统支持主定义+特化** | 需要支持类型参数化的模板主定义（如 `vec<T>`）及偏特化/全特化实现（如针对不同分量数的 vec 特化、storage 的 SIMD 特化） | 首轮 `vec<N,T,Q>` 的 4 个具体特化全部依赖此能力；`qualifier` 中 `storage` 的 SIMD 特化也依赖此机制 | 若仅支持主定义不支持特化，则 vec1-4 需作为独立类型手工实现（无模板复用），首轮范围应缩减至 1-2 个最常用向量类型；若不支持泛型，需为每个具体类型独立编码，首轮建议仅迁移 `vec2`、`vec4` 两个最高频类型 |
| **运算符重载** | 需要为自定义类型定义算术（`+`/`-`/`*`/`/`）、比较（`==`/`!=`）、下标（`[]`）等运算符的能力 | 首轮向量类型的基本算术和比较操作依赖运算符重载进行验证 | 若不支持，向量运算需以普通方法（如 `.add()`、`.mul()`）提供，首轮验收标准需调整为方法调用验证，语义等价但用法不同 |
| **类型别名等效机制** | 需要创建现有类型的别名（如 `using X = Y`、`type X = Y` 等） | 首轮约 100+ 个向量类型别名（`vec2`、`ivec3`、`dvec4` 等及其精度变体）全部依赖此能力 | 若不支持类型别名，每个变体需作为独立类型定义而非别名，首轮别名部分应缩减至仅迁移最常用的 4-6 个别名（`vec2`/`vec3`/`vec4`/`ivec2`/`ivec3`/`ivec4`），其余推迟至别名机制可用时 |
| **编译期条件分支或等效机制** | 需要在编译期根据条件选择代码路径（如 `#if`/`#ifdef` 或 `cfg!` 或通过泛型特化实现的条件分发） | `GLM_CONFIG_SWIZZLE`、`GLM_CONFIG_ALIGNED_GENTYPES`、`GLM_HAS_TEMPLATE_ALIASES` 等配置宏的控制逻辑依赖编译期条件分支；首轮已按推荐分支预设默认路径 | 若不支持编译期条件分支，每套配置需维护独立的源代码副本，首轮仅维护默认配置分支（`GLM_SWIZZLE_OPERATOR`、非对齐、启用别名），其余配置在编译期分支机制可用时再同步 |
| **固定位宽整数类型** | 需要 `int8`/`int16`/`int32`/`int64`/`uint8`/`uint16`/`uint32`/`uint64` 等效位宽类型 | 首轮标量类型系统的 10 个基础类型全部依赖目标语言提供对应位宽的整数 | 若目标语言不全覆盖 8 种位宽，缺失位宽需用结构体外包装模拟，标量类型迁移范围不变但实现复杂度增加；若完全不支持指定位宽，首轮标量部分缩减至语言原生范围 |
| **匿名组合类型支持** | 需要支持匿名 `union`/`struct` 嵌套或等效的组合类型内存布局能力 | `type_quat.hpp`（第 3 轮迁移）第 42-52 行使用匿名 union + 匿名 struct 嵌套模式定义四元数数据成员。首轮范围不直接依赖此特性 | 若不支持，第 3 轮迁移中 `type_quat.hpp` 的匿名 union/struct 嵌套需改用命名结构体包裹（如 `struct { T x, y, z, w; }`），在第 3 轮范围规划中标识为额外适配项 |
| **C++ 标准库设施等效替代** | 首轮文件直接使用的 C++ 标准库设施包括 `<cassert>`（`setup.hpp`）、`<cstddef>`（`setup.hpp`、`type_vec1-4.hpp`）、`<limits>`（`compute_vector_relational.hpp`）、`<functional>`（`compute_vector_decl.hpp`） | 目标语言需提供上述 C++ 标准库设施的直接等效替代，或自行提供等价实现档案（shim layer） | 若目标语言不提供上述设施的直接等效替代，需在首轮迁移中同步创建对应的 shim 类型（如 `cstddef` 对应 `size_t` 别名、`limits` 对应数值极限常量、`functional` 对应算术仿函数、`cassert` 对应运行时断言机制） |

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

上述断言对 `.hpp` 声明文件成立——向量类型的结构体声明仅依赖 `qualifier.hpp`。`.inl` 实现文件可能存在额外包含依赖（所有 `type_vec1.inl`-`type_vec4.inl` 均包含 `compute_vector_relational.hpp`；`type_vec3.inl` 和 `type_vec4.inl` 还额外包含 `compute_vector_decl.hpp`），但这类依赖不引入其他向量/矩阵类型，不影响首轮迁移的依赖闭合性。其中 `compute_vector_relational.hpp` 被所有 vec `.inl` 无条件包含且仅依赖 `setup.hpp`，应随首轮向量类型同步迁移；`compute_vector_decl.hpp` 同理（其内部 `#include "_vectorize.hpp"` 引入 `_vectorize.hpp` 作为首轮额外辅助文件，该文件定义 `functor1`/`functor2` 等模板工具，无进一步 GLM 内部依赖）。

> **注**：每个 `type_vecN.hpp` 还会根据 `GLM_CONFIG_SWIZZLE` 条件包含 `_swizzle.hpp`（`GLM_SWIZZLE_OPERATOR` 模式）、`_swizzle_func.hpp`（`GLM_SWIZZLE_FUNCTION` 模式），或在 `GLM_SWIZZLE_DISABLED` 时不包含任何 swizzle 文件。默认配置为 `GLM_SWIZZLE_OPERATOR`，`_swizzle.hpp` 被包含。这两个 swizzle 文件定义了 swizzle 操作的支持类型和构造器，属于 `type_vecN.hpp` 的条件编译依赖。首轮迁移建议以默认 `GLM_SWIZZLE_OPERATOR` 模式为准完整实现 `_swizzle.hpp`；`_swizzle_func.hpp` 可在首轮以空桩处理或编译时提示暂不支持的配置；`GLM_SWIZZLE_DISABLED` 时无需处理。

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
> **ext/gtc 处理策略**：当 `type_quat.hpp` 纳入第 3 轮迁移范围时，有两种处理方案：**(A) 完整实现**——将上表第 3 列全部 4 个文件及其完整传递依赖链一并迁移，代价最高但类型系统自洽；**(B) 部分实现 + 空桩**——对 `ext/vector_relational.hpp` 和 `gtc/constants.hpp` 可低代价完整实现（依赖链浅），对 `ext/quaternion_relational.hpp` 和 `gtc/matrix_transform.hpp` 创建空桩（仅提供最小编译占位，函数体返回默认值或抛出运行时错误）。方案 B 建议的桩边界：`ext/quaternion_relational.hpp` → `vector_relational.hpp`（桩化其 `.inl` 实现）；`gtc/matrix_transform.hpp` → `ext/matrix_projection.hpp`、`ext/matrix_clip_space.hpp`、`ext/matrix_transform.hpp`、`geometric.hpp`、`trigonometric.hpp`、`matrix.hpp`（这些文件的声明和实现均桩化，仅保留 `#pragma once` 和空函数声明）。

> **矩阵 `.inl` 实现依赖提示**：矩阵类型的 `.inl` 实现文件也可能引入函数库头文件——`type_mat2x2.inl` 引入 `../matrix.hpp`；`type_mat3x3.inl` 引入 `../matrix.hpp`、`../common.hpp`；`type_mat4x4.inl` 引入 `../matrix.hpp`、`../geometric.hpp`。非方阵（2x3、3x2 等）的 `.inl` 实现无额外引入。这些依赖在仅编译 `.hpp` 声明时不会触发，需在完整实现编译时处理。

### 函数库（各自由对应头文件提供，例如 trigonometric.hpp、exponential.hpp 等）

这些函数库操作上述类型，不是类型定义本身，不在本次类型迁移范围内。

---

## 2. 依赖关系分析：哪些类型被最多依赖

### 2.1 核心模板前向声明（`qualifier.hpp`）

文件 `qualifier.hpp:35-37` 中声明了三个核心模板：
```cpp
template<length_t L, typename T, qualifier Q = defaultp> struct vec;
template<length_t C, length_t R, typename T, qualifier Q = defaultp> struct mat;
template<typename T, qualifier Q = defaultp> struct qua;
```

这三个模板是所有具体类型（`vec2`, `mat4x4`, `quat` 等）的基础。

### 2.2 被依赖最多的类型

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

> **统计方法说明**：以上"被引用文件数"统计的是**直接引用**——即源文件中显式 `#include` 该头文件，不包括传递引用。统计范围为 `glm/` 目录下全部 `.hpp`、`.inl`、`.cpp` 源文件（不含测试和示例代码）。方法：对每个目标头文件，使用 `grep -r "#include.*<目标文件名>" glm/* --include="*.hpp" --include="*.inl" --include="*.cpp"` 搜索直接引用，然后统计唯一文件数。例如，`type_vec4.hpp` 被 18 个文件直接 `#include`，意味着除自身定义外还有 18 个文件通过 `#include "type_vec4.hpp"` 显式引用了该类型。`glm/` 目录下源文件总计 421 个（280 个 `.hpp`、140 个 `.inl`、1 个 `.cpp`，不含测试和示例），其中首轮涉及约 6 个核心文件 + 4 个向量类型文件。

### 2.3 依赖关系拓扑排序

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

> **条件编译宏对首轮可迁移性的影响**：GLM 源码中使用条件编译宏控制编译器特性适配，以下 4 条关键宏对首轮迁移方案有直接影响，需逐条分析推荐分支：
> - **`GLM_HAS_TEMPLATE_ALIASES`**：控制是否使用 C++11 `using X = Y` 模板别名语法。若目标语言支持类型别名（如仓颉 `type`、Rust `type`、Swift `typealias`），首轮推荐启用分支（`#define GLM_HAS_TEMPLATE_ALIASES 1`）以使用现代别名语法；若目标语言不支持，则回退到 `typedef`/`struct` 包装（禁用分支），选择取决于目标语言的类型系统能力而非首轮风险。
> - **`GLM_HAS_EXTENDED_INTEGER_TYPE`**：控制是否启用 `int8`/`int16`/`int64`/`uint64` 等扩展整数类型。首轮标量类型系统必须提供对应位宽的整数类型。若目标语言原生支持所有所需位宽（如 Rust 的 `i8`/`i16`/`i32`/`i64`），该宏可标记为 1 并正常使用；若目标语言仅提供部分位宽，需通过现有类型组合封装缺失位宽（如用结构体包装），此时该宏标记为 0。
> - **`GLM_CONFIG_ALIGNED_GENTYPES`**：控制向量/矩阵类型是否使用对齐存储。在 `#if GLM_CONFIG_ALIGNED_GENTYPES` 分支中，`storage` 使用 `alignas(16)` / `__declspec(align(16))` 等对齐修饰符。首轮建议禁用此宏（`GLM_CONFIG_ALIGNED_GENTYPES` 设为 0），使用通用非对齐路径——对齐可在核心类型稳定后的性能优化轮次中追加。
> - **`GLM_HAS_ALIGNOF`**：控制是否使用 `alignof` 操作符检测类型对齐。与 `GLM_CONFIG_ALIGNED_GENTYPES` 关联——若禁用对齐类型，此宏在首轮无实际影响。首轮可设为 0 或与目标语言 `alignof` 等效能力对应。
>
> 首轮迁移按以上推荐分支配置可保证基础设施层闭合编译，不受条件编译宏的跨平台差异影响。

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

#### C. 向量类型别名（与类型定义同时提供）

对应 `fwd.hpp` 第 180-507 行的向量类型别名。首轮迁移的向量别名覆盖 `fwd.hpp` 第 180-507 行定义的 16 个向量别名家族（`bvec`、`ivec`、`uvec`、`vec`、`dvec`、`i8vec`、`i16vec`、`i32vec`、`i64vec`、`u8vec`、`u16vec`、`u32vec`、`u64vec`、`fvec`、`f32vec`、`f64vec`）及其各精度变体（`lowp_*`、`mediump_*`、`highp_*`）。

> 向量别名依赖 `vec<N,T,Q>` 的完整结构体定义（在 3B 中完成迁移后方可导入），不可与标量类型别名（3A.3 仅依赖前向声明）同时编译。本部分共涉及约 100+ 个 type alias 定义。虽有数量但均为简单模板别名（或 typedef），工程实现量小于一个向量模板特化的实现。

#### D. 首轮范围规模总结

| 类型 | 数量 |
|------|------|
| 配置/基础设施文件（`setup` + `qualifier`） | 2 个核心文件 |
| 标量类型：int8-u64 8 个整数位宽 + float、double，以及 bool 关键字 | 10 个基础数值类型 + bool + 精度变体 |
| 向量模板及特化 | 4 个模板结构体 + inline 实现 |
| 向量辅助文件（`compute_vector_relational.hpp`、`compute_vector_decl.hpp`、`_vectorize.hpp`、`_swizzle.hpp`） | 4 个辅助文件（随首轮 vec 类型同步迁移） |
| 向量 type alias（含精度变体） | 约 256 个类型别名 |
| 合计核心文件 | 2 基础设施 + 4 vec 模板 + 4 辅助文件 = 10 个文件 |
| 合计可实例化类型 | 约 256 个具现化类型 |

---

### 后续轮次迁移规划

#### 第 2 轮：矩阵类型 + `ext/` 别名文件

**依赖前提**：首轮完成（`vec<N,T,Q>` 及标量/向量别名就绪）

| 内容 | 角色 | 依赖 |
|------|------|------|
| 全部 9 个矩阵类型（`mat<2-4,2-4,T,Q>`） | 核心类型层 | 依赖对应的 `vec<N,T,Q>` |
| 矩阵类型别名 | `fwd.hpp` 中的矩阵别名（如 `mat2x2`、`mat4x4` 等） | 依赖矩阵类型完整定义 |
| `ext/` 下的向量/矩阵别名文件（如 `ext/vector_float2.hpp`、`ext/matrix_float4x4.hpp` 等） | 类型具现化，仅含 type alias 和精度变体 | 依赖向量/矩阵类型定义 |
| `type_float.hpp`、`type_half.hpp` | 可选基础设施（浮点类型标签） | 仅依赖 `setup.hpp`，可在本轮或更早独立迁移 |

> 矩阵类型本身不增加新的模板复杂度（实现模式与 `vec` 类似），且全部 9 个矩阵头文件间无相互依赖，可并行实现。
>
> 矩阵 `.inl` 实现中涉及的函数库头文件（`matrix.hpp`、`common.hpp`、`geometric.hpp`）暂不迁移——可在首轮编译验证时通过 stub 空实现占位，待第 4 轮函数库迁移时替换。`.hpp` 声明文件可独立编译。

**验证标准**：
- 创建/访问矩阵（构造、行列访问、基本算术）
- `mat2x2`、`mat3x3`、`mat4x4` 各基本类型的实例化
- `ext/vector_float2.hpp` 等别名文件引用 `vec2` 成功

---

#### 第 3 轮：四元数 + 附带 ext/gtc 依赖

**依赖前提**：第 2 轮完成（矩阵类型就绪）

| 内容 | 角色 | 依赖 |
|------|------|------|
| `type_quat.hpp` + `type_quat.inl` | 四元数类型 | `type_mat3x3.hpp`、`type_mat4x4.hpp`、`type_vec3.hpp`、`type_vec4.hpp` |
| `ext/vector_relational.hpp` | type_quat 完整编译依赖 | 依赖向量类型 |
| `ext/quaternion_relational.hpp` | type_quat 完整编译依赖 | 依赖四元数自身 |
| `gtc/constants.hpp` | type_quat 完整编译依赖 | 常量定义，依赖 setup |
| `gtc/matrix_transform.hpp` | type_quat 完整编译依赖 | 依赖矩阵类型 |
| `ext/` 下的四元数别名文件（`quaternion_float.hpp`、`quaternion_double.hpp` 等） | 四元数类型具现化 | 依赖 `type_quat.hpp` |
| 四元数矩阵/向量相关函数库 | `ext/quaternion_transform.hpp`、`ext/quaternion_common.hpp` 等 | 依赖四元数类型 |

> `type_quat.hpp` 第 7-14 行在 struct 定义之前无条件 `#include` 了上表所列的全部头文件（包含 ext/gtc 文件），所有文件均为编译期硬性依赖——不存在"类型结构可不依赖 ext/gtc"的选项。若确有分期迁移需求，可行方案为：① 修改 `type_quat.hpp` 的 `#include`，将 ext/gtc 依赖改为条件包含或前向声明替代；② 为 ext/gtc 头文件创建空桩文件以通过编译。
>
> **gtc/matrix_transform.hpp 隐式依赖链分析**：`gtc/matrix_transform.hpp` 的传递依赖链是最重的——直接包含 `mat4x4.hpp`、`vec2.hpp`、`vec3.hpp`、`vec4.hpp`、`ext/matrix_projection.hpp`、`ext/matrix_clip_space.hpp`、`ext/matrix_transform.hpp`。后三个 ext 文件进一步引入 `gtc/constants.hpp`、`geometric.hpp`、`trigonometric.hpp`、`matrix.hpp`。`.inl` 实现则额外引入 `geometric.hpp`、`trigonometric.hpp`、`matrix.hpp`。完整传递依赖链覆盖：全部 9 个矩阵类型、全部 4 个向量类型、基础设施层、以及多个核心函数库（geometric、trigonometric、matrix）。是 8 个 include 中依赖范围最广的文件。
>
> **ext/gtc 桩边界建议**：若采用部分实现+空桩策略，建议按以下优先级分批处理：① `ext/vector_relational.hpp` 和 `gtc/constants.hpp` 依赖链最浅（均止于 `qualifier.hpp`/`setup.hpp`），建议完整实现；② `ext/quaternion_relational.hpp` 依赖 `vector_relational.hpp`（函数库），建议桩化；③ `gtc/matrix_transform.hpp` 依赖链最深，建议桩化其本身及间接依赖的 `ext/matrix_projection.hpp`、`ext/matrix_clip_space.hpp`、`ext/matrix_transform.hpp`、`geometric.hpp`、`trigonometric.hpp`、`matrix.hpp`——这些桩文件仅需 `#pragma once` 和函数声明（无实现体），使 `type_quat.hpp` 的结构体定义能通过编译。

**验证标准**：
- 四元数构造、旋转、插值基本功能
- `quat` 类型别名的可用性

---

#### 第 4 轮：函数库迁移

**依赖前提**：第 1-3 轮完成（所有核心类型就绪）

| 内容 | 说明 |
|------|------|
| 基础函数库 | `common.hpp`、`matrix.hpp`、`geometric.hpp`、`exponential.hpp`、`trigonometric.hpp` 等 |
| `ext/` 标量/向量/矩阵函数库 | `ext/scalar_common.hpp`、`ext/vector_common.hpp`、`ext/matrix_transform.hpp` 等 |
| `gtc/` 扩展函数库 | `gtc/matrix_transform.hpp`、`gtc/packing.hpp`、`gtc/noise.hpp` 等 |
| `gtx/` 实验性扩展 | 全部 `gtx/*` 文件，按需迁移 |

> 函数库实现依赖所有核心类型，是最外层的功能层。函数库之间可能存在相互调用（如 `geometric.hpp` 调用 `common.hpp`），需按拓扑顺序分批迁移。

**验证标准**：
- 各函数库的单元测试
- 与实际 GLM 代码的等价性验证

---

#### 第 5 轮及以后：可选/平台特化

| 内容 | 说明 |
|------|------|
| SIMD 优化特化 | 平台相关，可在核心功能稳定后按需添加 |
| SIMD 检测头文件（`simd/platform.h`） | 其提供的平台检测宏**功能**已在首轮 `setup.hpp` 等价实现中以内联方式处理；该文件**作为独立文件结构**的拆分和完整实现推迟至此轮 |
| `gtx/` 实验性扩展 | 按实际需求选择性迁移 |

---

### 分层迁移总览

| 轮次 | 内容 | 依赖前提 | 风险等级 | 复杂度 |
|------|------|---------|---------|--------|
| 1 | 基础设施 + 标量 + `vec<N,T,Q>` + 向量别名 | 无 | 低 | 中（模板核心） |
| 2 | 矩阵类型 + `ext/` 别名文件 | 第 1 轮 | 中 | 中（模式重复） |
| 3 | 四元数 + 附带的 ext/gtc 依赖 | 第 2 轮 | 中 | 中高（跨层次） |
| 4 | 函数库（common、matrix、geometric、ext、gtc） | 第 1-3 轮 | 低 | 高（量大面广） |
| 5+ | SIMD 特化、gtx 实验性扩展 | 第 4 轮 | 低 | 低（按需） |

---

## 4. 选择理由

### 4.1 为什么选这些类型作为首轮

1. **最小可编译集合**：`vec<N,T,Q>` 仅依赖 `qualifier` 枚举和标量类型。迁移这组类型后，编译/运行验证可立即验证类型系统的基础能力（模板、泛型、运算符重载、枚举等）。

2. **依赖关系要求**：`vec` 被所有其他类型（`mat`、`qua`、`ext/*`、`gtc/*`）依赖。必须先有 `vec`，才能迁移任何其他类型。

3. **实用价值**：向量类型是图形学数学最常用的类型。GLM 的核心价值在于提供类似 GLSL 的 `vec2`/`vec3`/`vec4`。

4. **风险控制**：首轮仅涉及 4 个向量模板 + 基础设施层，依赖链单一清晰，出错时可快速定位和修复。

### 4.2 定量依赖佐证

以下数据基于 GLM 源码中相关头文件被**直接引用**（显式 `#include`）的唯一文件数量统计，统计范围和方法同第 2.2 节：

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

**首轮核心类型迁移完成后**，`ext/` 下的向量/矩阵别名文件（如 `ext/vector_float2.hpp`、`ext/matrix_float4x4.hpp`）可作为第二轮高优先级迁移内容，因为它们仅包含 type alias 和精度变体，实现量极小但提供完整的类型可用性。

### 4.4 独立编译/工作的验证策略

首轮迁移范围应满足以下范围级验收准则，以确认所选类型的边界合理且可独立工作：

| 验收准则 | 范围级描述 |
|---------|----------|
| 依赖闭合性 | 首轮范围内所有文件的 `#include` 依赖链不超出首轮范围声明的文件集合 |
| 拓扑可编译性 | 首轮文件可按依赖拓扑顺序（基础设施层 → 标量类型 → 向量类型 → 类型别名）逐层编译，每层无遗漏外部依赖 |
| 边界隔离性 | 首轮范围不依赖任何未迁移的 GLM 组件（mat、qua、ext、gtc、gtx） |
| 基础类型可用性 | 所有首轮向量类型（`vec<1-4,T,Q>`）支持构造、分量访问和基本算术运算 |
| 类型别名可用性 | 首轮声明的向量类型别名（`vec2`、`ivec3`、`dvec4` 等及其精度变体）可正确实例化 |

### 4.5 范围边界建议

首轮范围可按以下顺序界定其内部子范围，每个子范围的依赖关系独立闭合：

| 子范围 | 内容 | 范围边界 |
|--------|------|---------|
| 1 | 基础设施层（`setup.hpp` 配置 + `qualifier` 枚举 + `length_t`） | 边界闭合于自身，无外部 GLM 依赖 |
| 2a | 向量辅助文件（`compute_vector_relational.hpp`、`compute_vector_decl.hpp`、`_vectorize.hpp`，均仅依赖 `setup.hpp`） | 边界闭合于基础设施层，与 vec 类型无交叉依赖 |
| 2b | 标量类型别名（仅依赖 `qualifier.hpp` 前向声明） | 边界闭合于基础设施层 |
| 2c | `vec<1,T,Q>` + `vec1` 相关向量类型别名 | 边界：依赖基础设施层和标量类型，不引入其他核心类型 |
| 3 | `vec<2,T,Q>` | 同上 |
| 4 | `vec<3,T,Q>` | 同上 |
| 5 | `vec<4,T,Q>` | 同上 |
| 6 | `vec2`-`vec4` 相关公共 type alias | 边界：依赖对应 vec 类型定义，不超出首轮范围 |

> **注**：子范围 2a 的辅助文件在依赖拓扑上位于子范围 2c-6 之前——`compute_vector_relational.hpp` 被全部 4 个 `type_vecN.inl` 无条件包含；`compute_vector_decl.hpp` 被 `type_vec3.inl` 和 `type_vec4.inl` 无条件包含。二者均仅依赖 `setup.hpp`，属于首轮范围的必要组成部分。`_swizzle.hpp` 定义的结构体继承自 `vec<L, T, Q>`，语法可解析但依赖 vec 完整类型定义，其范围边界随对应 `type_vecN.hpp` 闭合，因此归入各 vec 类型的子范围中。

---

## 5. 类型依赖关系图（首轮范围）

```
setup.hpp 配置 (含 length_t 定义)
     │
     ▼
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
> **注**：每个 `type_vecN.hpp` 还会根据 `GLM_CONFIG_SWIZZLE` 编译配置条件包含 `_swizzle.hpp`（`GLM_SWIZZLE_OPERATOR` 模式）或 `_swizzle_func.hpp`（`GLM_SWIZZLE_FUNCTION` 模式）。默认配置下 `GLM_SWIZZLE_OPERATOR` 被启用，`_swizzle.hpp` 被包含。这两个文件定义了 swizzle 操作的支持类型和构造器，属于 `type_vecN.hpp` 的条件编译依赖，迁移时需一并实现。
>
> **`_vectorize.hpp` 依赖链分析**：`_vectorize.hpp` 由 `compute_vector_decl.hpp` 无条件 `#include`（`compute_vector_decl.hpp:4`），位于 `compute_vector_decl.hpp` 的上游依赖位置。该文件自身不含任何 `#include` 指令，定义 `functor1`、`functor2`、`functor2_vec_sca`、`functor2_vec_int` 四个模板工具结构体，属于纯类型工具文件，无进一步 GLM 内部依赖。首轮迁移中应随 `compute_vector_decl.hpp` 同步纳入。
>
> **`_swizzle.hpp` 依赖链分析**：经审查确认，`_swizzle.hpp` 自身不含额外 `#include` 语句（仅定义 swizzle 构造器、重载操作符等纯类型工具），其依赖链闭合于首轮基础设施层——该文件不引入任何向量/矩阵/函数库类型。但 `_swizzle.hpp` 中定义的结构体继承自 `vec<L, T, Q>`，其编译需依赖 vec 的完整类型定义，因此随对应 `type_vecN.hpp` 一同编译而非独立编译。
>
> **非默认配置处理策略**：当 `GLM_CONFIG_SWIZZLE != GLM_SWIZZLE_OPERATOR` 时（例如设为 `GLM_SWIZZLE_FUNCTION` 或 `GLM_SWIZZLE_DISABLED`），对应的 `_swizzle_func.hpp` 或无 swizzle 支持。首轮迁移建议以默认配置（`GLM_SWIZZLE_OPERATOR`）为准，完整实现 `_swizzle.hpp`。非默认模式可通过以下方式处理：① 在目标语言中仅实现默认模式，其余模式通过空桩或编译期错误提示暂不支持的配置；② 若需完全兼容，在首轮后追加对应模式的实现。

首轮迁移完成后，所有向量的实例化类型均可用。后续轮次可以在此基础上添加矩阵、四元数及其他扩展。

---

## 修订说明（v2）

| 审查意见 | 处理方式 |
|---------|---------|
| #1 行号引用不准确：`qualifier.hpp:36` 应为 `qualifier.hpp:35-37` | 修改：已将行号引用更新为 `qualifier.hpp:35-37`，对应三个核心模板声明。 |
| #2 `length_t` 定义位置描述错误：归为 `qualifier.hpp`，实际在 `setup.hpp:636-638` | 修改：已将 `length_t` 归入 `setup.hpp`（见层次0表格及3A.1节），移除其在 `qualifier.hpp` 条目下的错误归属。 |
| #3 首轮迁移范围描述与实际规模不符：用"4个模板结构体"概括实际含配置层、标量系统、4个向量模板及数百个别名 | 修改：在节3新增"首轮范围规模总结"表格，明确列出各组成部分的数量；修正风险控制描述为"仅涉及4个向量模板+基础设施层"，不再使用"4个模板结构体"简化表述。 |
| #4 矩阵类型依赖表不完整：遗漏 `type_mat3x2.hpp`、`type_mat4x2.hpp`、`type_mat4x3.hpp` | 修改：补全全部9个矩阵类型的依赖关系表，新增缺失的3个条目。 |
| #5 `type_float.hpp` 和 `type_half.hpp` 级别归类不当：归入Level 0但非核心类型前置依赖 | 修改：将二者从Level 0基础设施降级为"可选基础设施"，在层次0表格下增加注释说明引用范围及非前置依赖属性。 |
| #6 缺少定量依赖分析：需求要求"被最多其他类型/函数依赖"——缺少定量数据支撑 | 修改：在节2.2新增"被引用文件数"列，提供每个核心类型被引用的定量数据；在节4.2新增独立的定量依赖佐证小节，按引用数降序列出各类型。 |
| #7 缺少"独立编译/工作"的验证策略 | 修改：在节4.4新增独立编译验证策略，包含编译顺序、模块隔离、基础功能、引用完整性四个验证步骤及通过标准。 |
| #8 `vec<1,T,Q>` 入选首轮缺少特殊说明：vec1是GLM扩展，实际应用极少 | 修改：在节3B中为 `vec<1,T,Q>` 新增说明段，解释其纳入首轮的三点理由（模板完备性、低边际成本、外部依赖）及建议降级选项。 |
| #9 `ext/` 和 `gtc/` 内容划分不清晰：需说明哪些 `ext/` 内容需与核心类型同步规划 | 修改：在节4.3新增 `ext/` 和 `gtc/` 内容划分分析表格，将内容分为"类型别名/具现化文件""功能函数库""扩展工具库"三类，明确各自与首轮的关系和推荐迁移时序。 |

## 修订说明（v3）

| 审查意见 | 处理方式 |
|---------|---------|
| 问题 1（中等）：Section 5 依赖关系图箭头方向——`setup → 标量类型 → qualifier` 与实际 `#include` 链不符 | 修改：将箭头方向修正为 `setup → qualifier → 标量类型(fwd.hpp)`，与 `qualifier.hpp` `#include "setup.hpp"` 及 `fwd.hpp` `#include "detail/qualifier.hpp"` 的实际链一致。各节点标注了实际 `#include` 关系。 |
| 问题 2（轻微）：未提及 `_swizzle.hpp` / `_swizzle_func.hpp` 条件编译依赖 | 修改：在 Section 1 层次 1 表格下方新增 swizzle 条件编译说明注；在 Section 5 依赖关系图下方新增 swizzle 文件条件包含注。 |
| 问题 3（轻微）：仅讨论 `.hpp` 声明依赖，未区分 `.inl` 实现的跨类型依赖 | 修改：Section 1 层次 1 中原"所有向量类型的结构定义均只依赖 `qualifier.hpp`"修改为明确限定于 `.hpp` 声明文件，并补充 `.inl` 实现文件的依赖说明。 |
| 问题 4（轻微）：标量类型计数——"约 12 个"与逐项计数的 10 个基础类型不符 | 修改：Section 3D 规模总结表格中"约 12 个类型 + 精度变体"改为"10 个基础类型 + 精度变体（含 `bool` 关键字）"。 |
| 问题 5（信息性）：`setup.hpp` 被标注为"无 GLM 内部依赖"，但其包含 `../simd/platform.h` | 修改：Section 1 层次 0 表格中 `setup.hpp` 行增加注，说明内部包含 `simd/platform.h` 提供平台检测宏，首次迁移需等价实现。 |

## 修订说明（v4）

| 审查意见 | 处理方式 |
|---------|---------|
| 问题 1（严重）：文档标题版本号与内容不一致——标题标注"(v2)"但实际已迭代至 v3 | 修改：标题中的"（v2）"更新为"（v4）"，与当前版本一致。 |
| 问题 2（中等）：`fwd.hpp` 迁移范围界定不清，存在执行歧义——未说明是否迁移全文、是否拆分、向量别名是否随首轮引入及来源何处 | 修改：Section 3A.3 明确说明首轮仅迁移 `fwd.hpp` 第 1-178 行（标量部分）；Section 3C 补充向量别名对应 `fwd.hpp` 第 180-507 行，并标注其依赖 `vec<N,T,Q>` 完整定义（3B）的前置条件；Section 5 依赖关系图中对 `fwd.hpp` 标注了仅迁移标量部分的说明。 |
| 问题 3（中等）：定量依赖统计方法可复现性不足——未说明直接/传递引用、使用工具/脚本、文件总数 | 修改：Section 2.2 和 Section 4.2 补充了统计方法详细说明：直接引用计数、`grep` 命令示例、统计范围（`glm/` 目录下全部源文件约 284 个）、示例解读。 |
| 问题 4（轻微）：`.inl` 文件额外依赖的描述范围不完整——仅以 `type_vec4.inl` 举例 | 修改：Section 1 将 `.inl` 依赖说明扩展至所有向量类型——`type_vec1.inl`-`type_vec4.inl` 均包含 `compute_vector_relational.hpp`，`type_vec3.inl`/`type_vec4.inl` 额外包含 `compute_vector_decl.hpp`。 |
| 问题 5（轻微）：`type_float.hpp` 和 `type_half.hpp`"无 GLM 内部依赖"说法不准确——两者均包含 `setup.hpp` | 修改：Section 1 中将"虽无 GLM 内部依赖"改为"仅依赖 `setup.hpp`（属于首轮基础设施层），不依赖核心类型（vec/mat/qua）定义"。 |
| 问题 6（轻微）：第 4.5 节子步骤的依赖时序不清晰——子步骤 2 将标量类型别名与 `vec<1,T,Q>` 合并，但两者依赖时序不同 | 修改：Section 4.5 将子步骤 2 拆分为 2a（标量类型别名，仅依赖前向声明）和 2b（`vec<1,T,Q>` + 向量类型别名，依赖完整结构体定义），并明确各自的可独立验证标准。 |

## 修订说明（v5）

| 审查意见 | 处理方式 |
|---------|---------|
| 问题 1（严重）：定量依赖统计数据与实际 GLM 1.0.3 源码不一致，所有类型被高估 | 修改：在 GLM 1.0.3 源码上重新运行统计并修正所有数值——`vec<4,T,Q>` 19→18、`vec<3,T,Q>` 20→19、`vec<2,T,Q>` 18→17、`vec<1,T,Q>` 12→11、`mat<4,4,T,Q>` 10→8、`mat<3,3,T,Q>` 8→7、`type_quat` 7→4。Section 2.2 和 Section 4.2 均已更新。 |
| 问题 2（中等）：源文件总数"约 284 个"与实际不符 | 修改：替换为精确统计值"421 个（280 个 `.hpp`、140 个 `.inl`、1 个 `.cpp`）"。同时修正了 Section 2.2 末尾的相关描述。 |
| 问题 3（中等）：`type_quat.hpp` 依赖描述不完整，缺失 ext/gtc 依赖 | 修改：Section 1 层次 3 表格中增补第 4 列"完整编译额外依赖"，列出 `ext/vector_relational.hpp`、`ext/quaternion_relational.hpp`、`gtc/constants.hpp`、`gtc/matrix_transform.hpp`；添加注释说明"类型定义依赖"与"完整编译依赖"的区别。同时在注中补充矩阵 `.inl` 实现的函数库头文件依赖提示。 |
| 问题 4（一般）：分层迁移建议不够充分，缺乏第 2-3 轮具体范围建议 | 修改：将原有"首轮不包含的内容"单一表格替换为第 2-5 轮详细迁移规划，每轮包含内容、依赖前提、验证标准。新增"分层迁移总览"汇总表将全部 5 轮按风险等级和复杂度归类呈现。 |
| 问题 5（轻微）：`type_mat4x4` 和 `type_quat` 统计偏差超出 +1 模式 | 修改：已在问题 1 修正中一并解决——使用实际 `#include` 计数替换所有数值，统计口径统一。偏差原因已消除。 |

## 修订说明（v6）

| 审查意见 | 处理方式 |
|---------|---------|
| 1.1（严重）type_quat.hpp 注释声称"类型定义本身仅依赖 4 个矩阵/向量头文件"、ext/gtc 依赖"可暂不迁移"——事实错误 | **修改**：Section 1 层次 3 注释和第 3 轮迁移规划注释均已修正——type_quat.hpp 第 7-14 行无条件 `#include` 全部 8 个头文件，均为编译期硬性依赖；删除"类型定义依赖"与"完整编译依赖"的可选区分表述；补充分期迁移的可行方案（修改 #include 或创建空桩）。 |
| 1.2（中等）Section 4.2 矩阵引用数据展示可读性不足 | **改善**：已将 Section 4.2 中矩阵类型数据从 vec 混合行中分离，独立成段列出，确保 mat<4,4,T,Q>(8) 和 mat<3,3,T,Q>(7) 清晰可见。 |
| 1.3（轻微）`## 4. 选择理由` 标题重复 | **修改**：删除第 2 个重复标题。 |
| 2.2 条件编译依赖边界未充分说明——swizzle 文件迁移时序、compute_vector_relational 首轮归属、GLM_CONFIG_SWIZZLE 非默认模式策略 | **修改**：Section 1 层次 1 注释中扩展了 swizzle 说明，涵盖 GLM_CONFIG_SWIZZLE 各模式的处理策略；明确 compute_vector_relational.hpp 属于首轮范围（因被所有 vec .inl 无条件包含）；明确 swizzle 文件的首轮迁移方式（跟随对应 vec 类型同步实现，默认 GLM_SWIZZLE_OPERATOR 模式优先，非默认模式可通过空桩暂缓）。 |

## 修订说明（v7）

| 审查意见 | 处理方式 |
|---------|---------|
| 问题 1（中等）：Section 1 层次 3 注释中的表格列号引用错误——原文"第 3 列和第 4 列"，表格仅有 3 列 | **修改**：将"第 3 列和第 4 列"修正为"第 2 列和第 3 列"，两处引用均已更新。 |
| 问题 2（轻微）：Section 1 层次 1 中 `compute_vector_relational.hpp` 的依赖描述与实际源码不符——声称依赖 `qualifier.hpp`，实际仅依赖 `setup.hpp` | **修改**：将"仅依赖 `setup.hpp` 和 `qualifier.hpp`"修正为"仅依赖 `setup.hpp`"。经查阅源码，`compute_vector_relational.hpp`（glm/detail/）仅 `#include "setup.hpp"` 和 `<limits>`，不含 `qualifier.hpp`。 |
| 问题 3（轻微）：Section 3B 中 `vec1` 纳入首轮的第三条理由逻辑断裂——以第 4 轮函数库的依赖论证第 1 轮的包含必要性 | **修改**：删除第三条理由（"部分函数库（`func_common`、`exponential`）也引用 `type_vec1.hpp`"），保留前两条（模板完备性、低边际成本）作为正当理由。 |
| 问题 4（中等）：Section 4.4 验证标准仅覆盖编译通过性，未定义"工作"的验收标准，不满足用户需求要求的"独立编译/工作" | **修改**：在 Section 4.4 中新增"首轮各向量类型的最小功能验收清单"表格，为每个向量类型明确列出最小验收操作及通过标准（运行时结果与 GLM 等价参考值一致）。 |
| 问题 5（中等）：Section 1 层次 3 和 Section 第 3 轮迁移规划中，`gtc/matrix_transform.hpp` 的隐式依赖链未分析，未明确 ext/gtc 处理策略 | **修改**：在 Section 1 层次 3 的注释中新增"ext/gtc 传递依赖链"段落，逐一分析 4 个 ext/gtc 文件的传递依赖深度；新增"ext/gtc 处理策略"段落，明确完整实现 vs 部分实现+空桩两种方案及桩边界建议。在第 3 轮迁移规划中补充对应的依赖链分析和桩边界建议。 |
| 问题 6（轻微）：Section 4.2 将 `setup.hpp` 和 `qualifier.hpp` 合并为一行表述存在歧义，无法区分 36 是各自计数还是合计 | **修改**：将 `setup.hpp/qualifier.hpp: 36 个文件引用` 拆分为独立两行，分别列出 `setup.hpp: 36 个文件引用` 和 `qualifier.hpp: 36 个文件引用`，消除歧义。 |

## 修订说明（v8）

| 审查意见 | 处理方式 |
|---------|---------|
| 问题 1（中等）：Section 3D 首轮范围规模总结表缺少 `compute_vector_relational.hpp`、`compute_vector_decl.hpp`、`_swizzle.hpp` 三个文件的条目 | **修改**：在 Section 3D 规模总结表中新增"向量辅助文件"行，列出三个文件及其数量（3 个），同步将"合计核心文件"由"4 个"修正为"9 个"以覆盖新条目。 |
| 问题 2（中等）：Section 4.5 子步骤表缺少三个辅助文件的对应步骤，实施者严格按表推进会在编译 vec `.inl` 时失败 | **修改**：在 Section 4.5 子步骤表中插入步骤 2a"准备向量辅助文件"，明确三个依赖文件各自可独立验证。将原步骤 2a→2b、2b→2c 重编号，新增注说明辅助文件必须在 vec `.inl` 编译前就绪及原因。 |
| 问题 3（轻微）：`_swizzle.hpp` 的自身依赖链未分析，读者无法确认该文件在首轮是否闭合 | **修改**：在 Section 5 swizzle 注中新增"依赖链分析"段落，说明该文件无额外 `#include`、依赖链闭合于首轮基础设施层，消除读者疑虑。 |
| 问题 4（中等）：`qualifier.hpp` 中 `storage` 的 SIMD 平台特化未分析，非 SIMD 目标语言处理策略未说明 | **修改**：在 Section 3A.2 `qualifier.hpp` 条目下新增注，说明 `storage` 条件编译块中 SIMD 特化的依赖风险，给出非 SIMD 环境的处理建议（保留通用定义，特化推迟至后续 SIMD 适配轮次）。 |
| 问题 5（轻微）：4 条关键条件编译宏（`GLM_HAS_TEMPLATE_ALIASES`、`GLM_HAS_EXTENDED_INTEGER_TYPE`、`GLM_CONFIG_ALIGNED_GENTYPES`、`GLM_HAS_ALIGNOF`）对首轮迁移的影响未分析 | **修改**：在 Section 3A 末尾新增条件编译宏处理说明段落，逐条分析每条宏的首轮推荐分支、不采纳分支的处理方式及与目标语言能力的映射关系。 |

## 修订说明（v9）

| 审查意见 | 处理方式 |
|---------|--------|
| 问题 1（轻微）：Section 5 依赖图中标量类型别名指向 vec 的箭头暗示了不存在的编译前置依赖 | **修改**：将依赖图改为并行结构——标量类型别名与 `vec<1-4,T,Q>` 分别从 qualifier 独立分枝，二者无编译期依赖关系。新增图注说明两路分支可并行编译。 |
| 问题 2（轻微）：Section 4.5 子步骤 2a 宣称 `_swizzle.hpp` 可独立编译通过，实际因其继承自 `vec<L,T,Q>` 而无法实现 | **修改**：将子步骤 2a 更名为"准备向量辅助文件（可独立编译部分）"，仅保留 `compute_vector_relational.hpp` 和 `compute_vector_decl.hpp`；`_swizzle.hpp` 从该列表中剔除，在注中说明其依赖 vec 完整类型定义且编译随所属 `type_vecN.hpp` 进行。Section 5 图注中的 `_swizzle.hpp` 依赖链分析同步修正，补充其继承依赖的说明。 |
| 问题 3（一般）：缺少目标语言能力假设的显式声明，产出可移植性受限 | **修改**：在正文开始处新增"目标语言能力假设"一节（全文第 0 节），列出 5 项关键假设（泛型/模板、运算符重载、类型别名、编译期条件分支、固定位宽整数），逐一说明对首轮范围的影响及不成立时的调整方向。 |
| 问题 4（轻微）：Section 1 层次 0 中 `simd/platform.h` 标注"首次迁移需等价实现"，与 Section 5 第 5 轮规划中列为第 5 轮内容矛盾 | **修改**：Section 1 注中改为"该检测功能作为能力在首轮以内联方式处理，作为独立文件结构的拆分和完整实现推迟至第 5 轮"；Section 5 第 5 轮表格中对应调整为"其提供的平台检测宏功能已在首轮 setup.hpp 等价实现中以内联方式处理；该文件作为独立文件结构的拆分和完整实现推迟至此轮"。 |
| 历史遗留（问题 3 持续）：目标语言能力假设问题在第 8 轮审查中已被识别，前一轮修复未完全解决 | **修改**：本轮新增的"目标语言能力假设"节不仅新增了章节，且每项假设均逐一说明了对首轮范围的影响及不成立时的调整方向，覆盖了审查中要求的全部 4 项关键假设（泛型/模板、运算符重载、类型别名、条件编译），并额外补充了固定位宽整数假设。该节置于正文开始处，确保读者在开始阅读正文前即了解本产出的适用前提。 |

## 修订说明（v10）

| 审查意见 | 处理方式 |
|---------|---------|
| 1（中度）Section 3C 向量别名家族列举不完整——仅列出 5/16 个家族，Section 3D 的"约 100+ 个"估计偏低 | **修改**：Section 3C 中删除具体枚举，改为引用 `fwd.hpp` 第 180-507 行并列出全部 16 个别名家族；Section 3D 中将"约 100+ 个"修正为"约 256 个"。 |
| 2（轻微）Section 3A.3 与 Section 3D 对 `bool` 的计数口径不一致 | **修改**：Section 3A.3 统一表述为"10 个基础数值类型（int8-u64 8 个整数位宽 + float、double）及 bool 关键字"；Section 3D 标量类型行统一为"标量类型：int8-u64 8 个整数位宽 + float、double，以及 bool 关键字"。 |
| 3（信息性）Section 4.5 子步骤超出"范围确定"边界，进入"实施规划"领域 | **修改**：Section 4.5 标题改为"范围边界建议"；子步骤表每项内容从实施层次的验证标准改为范围边界界定描述；移除"可独立编译通过"等实施语言。 |
| 4（轻微）目标语言能力假设缺少匿名组合类型依赖分析 | **修改**：Section 0 假设表中新增第 6 项"匿名组合类型支持"，说明 `type_quat.hpp` 第 42-52 行的匿名 union/struct 嵌套依赖及目标语言不支持的调整方向。 |

## 修订说明（v11）

| 审查意见 | 处理方式 |
|---------|---------|
| 问题 1（中等）：`_vectorize.hpp` 被首轮范围遗漏——该文件被 `compute_vector_decl.hpp` 无条件 `#include`，定义 `functor1`/`functor2` 等模板工具，无进一步 GLM 内部依赖，但未出现在 Section 3D、Section 4.5 子步骤 2a、Section 5 中 | **修改**：Section 1 中 `compute_vector_decl.hpp` 的描述补充其引入 `_vectorize.hpp` 的说明；Section 3D 向量辅助文件从 3 个更新为 4 个（新增 `_vectorize.hpp`），核心文件合计从 9 更新为 10；Section 4.5 子步骤 2a 增加 `_vectorize.hpp` 条目；Section 5 新增 `_vectorize.hpp` 依赖链分析注（位于 `compute_vector_decl.hpp` 的上游依赖位置） |
| 问题 2（轻微）：标准库依赖未在"目标语言能力假设"中提及——首轮文件使用 `<cassert>`、`<cstddef>`、`<limits>`、`<functional>` 等 C++ 标准库设施 | **修改**：Section 0 假设表中新增第 7 项"C++ 标准库设施等效替代"，列出首轮使用的标准库设施及目标语言不满足时的调整方向 |
| 问题 3（轻微）：Section 4.4 验证细节超出"只确定范围"边界——包含编译顺序设定、具体 API 测试用例（`vec2(1,2)`、`+/-/*` 等）、模块隔离构建系统建议 | **修改**：Section 4.4 从实施层级的"验证步骤 + 验收清单"替换为范围级验收准则（依赖闭合性、拓扑可编译性、边界隔离性、基础类型可用性、类型别名可用性），仅描述"验证什么"而非"如何验证" |
