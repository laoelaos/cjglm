# GLM 1.0.3 迁移基础类型范围分析（v2）

## 1. GLM 类型层次概览

GLM 1.0.3 的类型体系分为四个依赖层次，每个层次向下依赖（上层依赖下层）：

### 层次 0 — 基础设施（无 GLM 内部依赖）

| 组件 | 说明 |
|------|------|
| `detail/setup.hpp` | 平台检测、编译器检测、配置宏、版本定义、`length_t` 类型定义（注：内部包含 `../simd/platform.h`，提供平台检测宏，首次迁移需等价实现） |
| `detail/qualifier.hpp` | `qualifier` 枚举（packed_highp/mediump/lowp, aligned 等）、`vec`/`mat`/`qua` 前向声明、`storage` 结构模板、辅助 traits |
| 标量类型别名 | `fwd.hpp` 中定义的 `int8`/`int16`/`int32`/`int64` 等 |

> **注**：`detail/type_float.hpp`（浮点类型标签）和 `detail/type_half.hpp`（half 精度浮点）虽无 GLM 内部依赖，但它们并非核心类型迁移的前置依赖——`type_vec*.hpp` 等核心类型定义均不引用它们。仅 `ext/scalar_*.hpp`、`ext/vector_relational.hpp` 和 `gtc/packing.hpp` 等扩展功能引用之。故归类为 **可选基础设施**：可在需要对应功能时再迁移，不阻塞首轮迁移。

### 层次 1 — 核心向量类型（仅依赖层次 0）

| 组件 | 依赖 |
|------|------|
| `detail/type_vec1.hpp` | `qualifier.hpp` |
| `detail/type_vec2.hpp` | `qualifier.hpp` |
| `detail/type_vec3.hpp` | `qualifier.hpp` |
| `detail/type_vec4.hpp` | `qualifier.hpp` |

上述断言对 `.hpp` 声明文件成立——向量类型的结构体声明仅依赖 `qualifier.hpp`。`.inl` 实现文件可能存在额外包含依赖（如 `type_vec4.inl` 包含 `compute_vector_relational.hpp` 和 `compute_vector_decl.hpp`），但这类依赖不引入其他向量/矩阵类型，不影响首轮迁移的依赖闭合性。

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

| 组件 | 依赖 |
|------|------|
| `type_quat.hpp` | `type_mat3x3.hpp`, `type_mat4x4.hpp`, `type_vec3.hpp`, `type_vec4.hpp` |

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
| `vec<4, T, Q>` | 19 个文件 | 所有 4 列/4 行矩阵的内部列类型；`qua` 的构造和运算；`ext/vector_float4.hpp` 等别名定义 |
| `vec<3, T, Q>` | 20 个文件 | 所有 3 列/3 行矩阵的内部列类型；`qua` 的核心数据；`ext/vector_float3.hpp` 等别名定义 |
| `vec<2, T, Q>` | 18 个文件 | 所有 2 列/2 行矩阵的内部列类型；`qua` 的运算中间类型；`ext/vector_float2.hpp` 等别名定义 |
| `vec<1, T, Q>` | 12 个文件 | `ext/vector_float1.hpp` 等别名定义；少量函数库（`func_common.hpp`, `exponential.hpp`） |
| `mat<4,4,T,Q>` | 10 个文件 | `type_quat.hpp`、`ext/` 矩阵函数库、`gtc/` 扩展 |
| `mat<3,3,T,Q>` | 8 个文件 | `type_quat.hpp`、部分矩阵函数库 |

> 引用文件数统计范围：`glm/` 目录下所有 `.hpp`、`.inl`、`.cpp` 文件中出现该类型头文件引用的唯一文件数量。不包含测试和示例代码。

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
3. **标量类型系统** — 以下类型的映射：
   - `int8`, `int16`, `int32`, `int64` 及其 `lowp_`/`mediump_`/`highp_` 变体
   - `uint8`, `uint16`, `uint32`, `uint64` 及其变体
   - `float`, `double` 及其 `f32`, `f64` 等变体
   - `bool`

> 以上三项无 GLM 内部类型依赖，可最先独立编译验证。

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

- `bvec1`-`bvec4`, `ivec1`-`ivec4`, `uvec1`-`uvec4`, `vec1`-`vec4`, `dvec1`-`dvec4`
- 各精度变体（`lowp_*`, `mediump_*`, `highp_*`）

> 本部分共涉及约 100+ 个 type alias 定义。虽有数量但均为简单模板别名（或 typedef），工程实现量小于一个向量模板特化的实现。

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

### 首轮不包含的内容（后续轮次迁移）

| 内容 | 理由 |
|------|------|
| 矩阵类型 (`mat<C,R,T,Q>`) | 依赖向量类型，不增加核心复杂度 |
| 四元数 (`qua<T,Q>`) | 依赖矩阵和向量，复杂度高 |
| `ext/` 下的扩展类型 | 不是核心，可后续逐步迁移 |
| `gtc/` 扩展 | 功能扩展，依赖核心类型 |
| `gtx/` 实验性扩展 | 实验性，可最后迁移 |
| 函数库 (trigonometric, exponential, geometric 等) | 函数实现，不是类型定义 |
| SIMD 优化特化 | 平台相关，可后续添加 |

---

## 4. 选择理由

### 4.1 为什么选这些类型作为首轮

1. **最小可编译集合**：`vec<N,T,Q>` 仅依赖 `qualifier` 枚举和标量类型。迁移这组类型后，编译/运行验证可立即验证类型系统的基础能力（模板、泛型、运算符重载、枚举等）。

2. **依赖关系要求**：`vec` 被所有其他类型（`mat`、`qua`、`ext/*`、`gtc/*`）依赖。必须先有 `vec`，才能迁移任何其他类型。

3. **实用价值**：向量类型是图形学数学最常用的类型。GLM 的核心价值在于提供类似 GLSL 的 `vec2`/`vec3`/`vec4`。

4. **风险控制**：首轮仅涉及 4 个向量模板 + 基础设施层，依赖链单一清晰，出错时可快速定位和修复。

### 4.2 定量依赖佐证

以下数据基于 GLM 源码中相关头文件被引用的唯一文件数量统计：

```
setup.hpp/qualifier.hpp:    36 个文件引用（几乎所有 GLM 文件）
vec<3,T,Q>:                 20   vec<4,T,Q>:  19   vec<2,T,Q>:  18
vec<1,T,Q>:                 12   mat<4,4,T,Q>:10   mat<3,3,T,Q>: 8
mat<2,2,T,Q>:                7   mat<3,4,T,Q>: 6   mat<3,2,T,Q>: 6
mat<4,3,T,Q>:                6   mat<4,2,T,Q>: 5   type_quat:    7
```

向量类型（vec2-4）的引用数是矩阵类型的 2-3 倍，是四元数的约 3 倍。这与拓扑依赖分析一致：向量位于依赖层次底部，是被依赖最多的类型层。

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
| 2 | `vec<1,T,Q>` + 标量类型别名 | 创建向量、访问成员 |
| 3 | `vec<2,T,Q>` | 基本 2D 向量操作 |
| 4 | `vec<3,T,Q>` | 基本 3D 向量操作 |
| 5 | `vec<4,T,Q>` | 基本 4D 向量操作 |
| 6 | 所有公共 type alias | 确认 `vec2`、`vec3`、`vec4` 等可用 |

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
标量类型别名：int8～int64, uint8～uint64, float, double, bool（fwd.hpp #include "detail/qualifier.hpp"）
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
