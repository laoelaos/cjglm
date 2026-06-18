# GLM 1.0.3 迁移基础类型范围分析（v5）

## 1. GLM 类型层次概览

GLM 1.0.3 的类型体系分为四个依赖层次，每个层次向下依赖（上层依赖下层）：

### 层次 0 — 基础设施（无 GLM 内部依赖）

| 组件 | 说明 |
|------|------|
| `detail/setup.hpp` | 平台检测、编译器检测、配置宏、版本定义、`length_t` 类型定义（注：内部包含 `../simd/platform.h`，提供平台检测宏，首次迁移需等价实现） |
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

上述断言对 `.hpp` 声明文件成立——向量类型的结构体声明仅依赖 `qualifier.hpp`。`.inl` 实现文件可能存在额外包含依赖（所有 `type_vec1.inl`-`type_vec4.inl` 均包含 `compute_vector_relational.hpp`；`type_vec3.inl` 和 `type_vec4.inl` 还额外包含 `compute_vector_decl.hpp`），但这类依赖不引入其他向量/矩阵类型，不影响首轮迁移的依赖闭合性。

> **注**：每个 `type_vecN.hpp` 还会根据编译配置条件包含 `_swizzle.hpp`（`GLM_SWIZZLE_OPERATOR` 模式）或 `_swizzle_func.hpp`（`GLM_SWIZZLE_FUNCTION` 模式），在默认配置下两者之一会被包含。这两个 swizzle 文件不属于类型定义的核心依赖，但迁移时需一并提供以实现 swizzle 操作语法支持。

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

> **注**：`type_quat.hpp` 的类型定义本身仅依赖 4 个矩阵/向量类型头文件（上表第 3 列）。第 4 列的 ext/gtc 依赖用于实现四元数的部分运算符和函数，属于"完整编译依赖"而非"类型定义依赖"。迁移 `type_quat.hpp` 时，若仅需类型定义可暂不迁移 ext/gtc 依赖，但若需完整编译则须一并提供。
>
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
3. **标量类型系统** — 对应 `fwd.hpp` 第 1-178 行的标量类型别名，包括以下映射：
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
> - `ext/vector_float1.hpp` 等别名文件依赖它，部分函数库（`func_common`、`exponential`）也引用 `type_vec1.hpp`
>
> 若为缩减首轮范围，可将其降级至第二轮，但建议优先纳入以保持模板逻辑完整性。

#### C. 向量类型别名（与类型定义同时提供）

对应 `fwd.hpp` 第 180-507 行的向量类型别名。首轮迁移的向量别名包括：

- `bvec1`-`bvec4`, `ivec1`-`ivec4`, `uvec1`-`uvec4`, `vec1`-`vec4`, `dvec1`-`dvec4`
- 各精度变体（`lowp_*`, `mediump_*`, `highp_*`）

> 向量别名依赖 `vec<N,T,Q>` 的完整结构体定义（在 3B 中完成迁移后方可导入），不可与标量类型别名（3A.3 仅依赖前向声明）同时编译。本部分共涉及约 100+ 个 type alias 定义。虽有数量但均为简单模板别名（或 typedef），工程实现量小于一个向量模板特化的实现。

#### D. 首轮范围规模总结

| 类型 | 数量 |
|------|------|
| 配置/基础设施文件（`setup` + `qualifier`） | 2 个核心文件 |
| 标量类型（`int8`-`int64`, `uint8`-`uint64`, `float`, `double`, `bool`） | 10 个基础类型 + 精度变体（含 `bool` 关键字） |
| 向量模板及特化 | 4 个模板结构体 + inline 实现 |
| 向量 type alias（含精度变体） | 约 100+ 个类型别名 |
| 合计核心模板 | 4 个模板结构体 |
| 合计可实例化类型 | 约 100+ 个具现化类型 |

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

> `type_quat.hpp` 的类型定义本身仅依赖 4 个类型头文件，若仅需类型结构可暂不迁移 ext/gtc 依赖。上表中的 ext/gtc 依赖为完整编译 `type_quat.hpp` 所必需。

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
| SIMD 检测头文件（`simd/platform.h`） | 首轮 `setup.hpp` 的等价实现中可能需要 |
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

## 4. 选择理由

### 4.1 为什么选这些类型作为首轮

1. **最小可编译集合**：`vec<N,T,Q>` 仅依赖 `qualifier` 枚举和标量类型。迁移这组类型后，编译/运行验证可立即验证类型系统的基础能力（模板、泛型、运算符重载、枚举等）。

2. **依赖关系要求**：`vec` 被所有其他类型（`mat`、`qua`、`ext/*`、`gtc/*`）依赖。必须先有 `vec`，才能迁移任何其他类型。

3. **实用价值**：向量类型是图形学数学最常用的类型。GLM 的核心价值在于提供类似 GLSL 的 `vec2`/`vec3`/`vec4`。

4. **风险控制**：首轮仅涉及 4 个向量模板 + 基础设施层，依赖链单一清晰，出错时可快速定位和修复。

### 4.2 定量依赖佐证

以下数据基于 GLM 源码中相关头文件被**直接引用**（显式 `#include`）的唯一文件数量统计，统计范围和方法同第 2.2 节：

```
setup.hpp/qualifier.hpp:    36 个文件引用（几乎所有 GLM 文件）
vec<3,T,Q>:                 19   vec<4,T,Q>:  18   vec<2,T,Q>:  17
vec<1,T,Q>:                 11   mat<4,4,T,Q>: 8   mat<3,3,T,Q>: 7
mat<2,2,T,Q>:                6   mat<2,3,T,Q>: 5   mat<2,4,T,Q>: 5
mat<3,2,T,Q>:                5   mat<3,4,T,Q>: 5   mat<4,2,T,Q>: 4
mat<4,3,T,Q>:                5   type_quat:    4
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

首轮迁移应确保所选类型能够独立编译并通过以下验证：

| 验证步骤 | 方法 | 通过标准 |
|---------|------|---------|
| 编译顺序 | 按 `setup → qualifier → 标量类型 → vec1 → vec2 → vec3 → vec4 → 类型别名` 顺序逐级编译 | 每步无编译错误 |
| 模块隔离 | 首轮组成一个独立模块，禁止依赖未迁移的 GLM 组件（mat、qua、ext、gtc、gtx） | 编译时若误引用未迁移组件则报错 |
| 基础功能 | 实例化 `vec2/3/4` 各基本类型，验证构造、成员访问、基本算术操作 | 编译通过且运行时结果正确 |
| 引用完整性 | 所有首轮头文件的 `#include` 链不超出首轮范围 | `#include` 依赖图闭合 |

建议在项目配置中设置首轮模块的 `include` 路径白名单，只允许引用已迁移的头文件。具体可通过目标语言的模块系统或构建系统的可见性控制实现。

### 4.5 粒度建议

建议按以下子步骤执行第一轮迁移：

| 子步骤 | 内容 | 可独立验证 |
|--------|------|-----------|
| 1 | `setup.hpp` 配置 + `qualifier` 枚举 + `length_t` | 确认枚举值和前向声明编译通过 |
| 2a | 标量类型别名（仅依赖 `qualifier.hpp` 前向声明即可） | 确认标量类型别名编译通过 |
| 2b | `vec<1,T,Q>` + `vec1` 相关向量类型别名（依赖 `vec<1,T,Q>` 完整定义） | 创建向量、访问成员 |
| 3 | `vec<2,T,Q>` | 基本 2D 向量操作 |
| 4 | `vec<3,T,Q>` | 基本 3D 向量操作 |
| 5 | `vec<4,T,Q>` | 基本 4D 向量操作 |
| 6 | `vec2`-`vec4` 相关公共 type alias | 确认 `vec2`、`vec3`、`vec4` 等可用 |

每子步骤独立编译验证后方可进入下一步，确保问题及早发现。

---

## 5. 类型依赖关系图（首轮范围）

```
setup.hpp 配置 (含 length_t 定义)
     │
     ▼
qualifier 枚举、vec/mat/qua 前向声明（#include "setup.hpp"）
     │
     ▼
标量类型别名：int8～int64, uint8～uint64, float, double, bool（fwd.hpp #include "detail/qualifier.hpp"，仅迁移第 1-178 行标量部分）
     │
     ├─────────────┬──────────────┬──────────────┐
     ▼              ▼              ▼              ▼
  vec<1,T,Q>    vec<2,T,Q>    vec<3,T,Q>    vec<4,T,Q>
     │              │              │              │
     ▼              ▼              ▼              ▼
  bvec1/ivec1    bvec2/ivec2    bvec3/ivec3    bvec4/ivec4
  vec1/dvec1     vec2/vec3      vec3/dvec3     vec4/dvec4
  (所有精度变体)  (所有精度变体)  (所有精度变体)  (所有精度变体)
```

> **注**：每个 `type_vecN.hpp` 还会根据 `GLM_CONFIG_SWIZZLE` 编译配置条件包含 `_swizzle.hpp`（`GLM_SWIZZLE_OPERATOR` 模式）或 `_swizzle_func.hpp`（`GLM_SWIZZLE_FUNCTION` 模式）。默认配置下 `GLM_SWIZZLE_OPERATOR` 被启用，`_swizzle.hpp` 被包含。这两个文件定义了 swizzle 操作的支持类型和构造器，属于 `type_vecN.hpp` 的条件编译依赖，迁移时需一并实现。

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
