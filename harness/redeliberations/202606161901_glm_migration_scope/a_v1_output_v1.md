# GLM 1.0.3 迁移基础类型范围分析

## 1. GLM 类型层次概览

GLM 1.0.3 的类型体系分为四个依赖层次，每个层次向下依赖（上层依赖下层）：

### 层次 0 — 基础设施（无 GLM 内部依赖）
| 组件 | 说明 |
|------|------|
| `detail/setup.hpp` | 平台检测、编译器检测、配置宏、版本定义 |
| `detail/qualifier.hpp` | `qualifier` 枚举（packed_highp/mediump/lowp, aligned 等）、`vec`/`mat`/`qua` 前向声明、`storage` 结构模板、辅助 traits |
| `detail/type_float.hpp` | 浮点类型标签 |
| `detail/type_half.hpp` | half 精度浮点 |
| 标量类型别名 | `fwd.hpp` 中定义的 `int8`/`int16`/`int32`/`int64` 等 |

### 层次 1 — 核心向量类型（仅依赖层次 0）
| 组件 | 依赖 |
|------|------|
| `detail/type_vec1.hpp` | `qualifier.hpp` |
| `detail/type_vec2.hpp` | `qualifier.hpp` |
| `detail/type_vec3.hpp` | `qualifier.hpp` |
| `detail/type_vec4.hpp` | `qualifier.hpp` |

所有向量类型的结构定义均只依赖 `qualifier.hpp`，不依赖其他类型。

### 层次 2 — 矩阵类型（依赖层次 1）
所有矩阵类型 `mat<C, R, T, Q>` 的内部数据由向量列组成。每个矩阵类型的定义依赖其列向量类型。例如：

| 组件 | 依赖的向量类型 |
|------|---------------|
| `type_mat2x2.hpp` | `type_vec2.hpp` |
| `type_mat2x3.hpp` | `type_vec2.hpp`, `type_vec3.hpp` |
| `type_mat2x4.hpp` | `type_vec2.hpp`, `type_vec4.hpp` |
| `type_mat3x3.hpp` | `type_vec3.hpp` |
| `type_mat3x4.hpp` | `type_vec3.hpp`, `type_vec4.hpp` |
| `type_mat4x4.hpp` | `type_vec4.hpp` |
| ... | ... |

### 层次 3 — 四元数类型（依赖层次 1、2）
| 组件 | 依赖 |
|------|------|
| `type_quat.hpp` | `type_mat3x3.hpp`, `type_mat4x4.hpp`, `type_vec3.hpp`, `type_vec4.hpp` |

### 函数库（各自由对应头文件提供，例如 trigonometric.hpp、exponential.hpp 等）
这些函数库操作上述类型，不是类型定义本身，不在本次类型迁移范围内。

---

## 2. 依赖关系分析：哪些类型被最多依赖

### 2.1 核心模板前向声明（`qualifier.hpp`）
文件 `qualifier.hpp:36` 中声明了三个核心模板：
```cpp
template<length_t L, typename T, qualifier Q = defaultp> struct vec;
template<length_t C, length_t R, typename T, qualifier Q = defaultp> struct mat;
template<typename T, qualifier Q = defaultp> struct qua;
```
这三个模板是所有具体类型（`vec2`, `mat4x4`, `quat` 等）的基础。

### 2.2 被依赖最多的类型

| 类型 | 被谁依赖/用于 |
|------|-------------|
| `vec<2, T, Q>` | 所有 2 列/2 行矩阵的内部列类型；所有 2 分量向量 typedef；`qua` 的运算中间类型 |
| `vec<3, T, Q>` | 所有 3 列/3 行矩阵的内部列类型；`qua` 的核心数据 |
| `vec<4, T, Q>` | 所有 4 列/4 行矩阵的内部列类型；`qua` 的构造和运算 |
| `qualifier` 枚举 | 每个向量的第三个模板参数 |
| `length_t` | 所有向量/矩阵的维度参数 |

### 2.3 依赖关系拓扑排序
```
setup.hpp
  └── qualifier.hpp (前向声明 vec/mat/qua, 定义 qualifier, storage)
       ├── type_vec1.hpp ──── vec<1, T, Q> 具体定义
       ├── type_vec2.hpp ──── vec<2, T, Q> 具体定义
       ├── type_vec3.hpp ──── vec<3, T, Q> 具体定义
       ├── type_vec4.hpp ──── vec<4, T, Q> 具体定义
       ├── type_mat2x2.hpp ── mat<2,2,...> 依赖 type_vec2
       ├── type_mat2x3.hpp ── mat<2,3,...> 依赖 type_vec2,3
       ├── ... (其他矩阵类型)
       ├── type_mat4x4.hpp ── mat<4,4,...> 依赖 type_vec4
       └── type_quat.hpp ──── qua<T,Q> 依赖 mat3x3,mat4x4,vec3,vec4
```

---

## 3. 建议的首轮迁移范围

### 首轮迁移内容

#### A. 基础设施层（必须最先迁移）
1. **`setup.hpp` 对应的配置层** — 目标语言中的配置/平台抽象
2. **`qualifier.hpp`** — 核心枚举 `qualifier`、`length_t`、`vec`/`mat`/`qua` 前向声明、`storage` 结构、`genTypeTrait` 等辅助设施
3. **标量类型系统** — 以下类型的映射：
   - `int8`, `int16`, `int32`, `int64` 及其 `lowp_`/`mediump_`/`highp_` 变体
   - `uint8`, `uint16`, `uint32`, `uint64` 及其变体
   - `float`, `double` 及其 `f32`, `f64` 等变体
   - `bool`

#### B. 核心向量类型（首轮迁移主体）
4. **`vec<1, T, Q>`** — 1 分量向量
5. **`vec<2, T, Q>`** — 2 分量向量
6. **`vec<3, T, Q>`** — 3 分量向量
7. **`vec<4, T, Q>`** — 4 分量向量

#### C. 向量类型别名（与类型定义同时提供）
- `bvec1`-`bvec4`, `ivec1`-`ivec4`, `uvec1`-`uvec4`, `vec1`-`vec4`, `dvec1`-`dvec4`
- 各精度变体（`lowp_*`, `mediump_*`, `highp_*`）

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

4. **风险控制**：只包含 4 个模板结构体（及其实例化），范围可控；不涉及矩阵乘法等复杂运算逻辑（那些属于函数库，不在类型迁移范围内）。

### 4.2 粒度建议

建议按以下子步骤执行第一轮迁移：

| 子步骤 | 内容 | 可独立验证 |
|--------|------|-----------|
| 1 | `setup.hpp` 配置 + `qualifier` 枚举 + `length_t` | 确认枚举值和前向声明编译通过 |
| 2 | `vec<1,T,Q>` + 标量类型别名 | 创建向量、访问成员 |
| 3 | `vec<2,T,Q>` | 基本 2D 向量操作 |
| 4 | `vec<3,T,Q>` | 基本 3D 向量操作 |
| 5 | `vec<4,T,Q>` | 基本 4D 向量操作 |
| 6 | 所有公共 type alias | 确认 `vec2`、`vec3`、`vec4` 等可用 |

---

## 5. 类型依赖关系图（首轮范围）

```
(无依赖)  setup.hpp 配置
     │
     ▼
(无依赖)  标量类型：int8, int16, int32, int64, uint8, uint16, uint32, uint64, float, double, bool
     │
     ▼
(无依赖)  qualifier 枚举、length_t、vec/mat/qua 前向声明
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

首轮迁移完成后，所有向量的实例化类型均可用。后续轮次可以在此基础上添加矩阵、四元数及其他扩展。
