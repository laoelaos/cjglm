# 阶段四 OOD 实现可行性验证报告

**验证对象**：`a_v16_copy_from_v15.md`（最终 OOD 设计文档）
**验证日期**：2026-06-29
**验证方法**：逐一审查设计文档中的每条设计决策、依赖关系、类型签名和边界策略，对照仓颉语言能力文档（skills）、已有项目代码（`cjglm/src/`）、仓颉限制偏差文档（`docs/deviations.md`）及 GLM 1.0.3 参考实现进行可行性判断。

---

## 1. 模块依赖可行性 — 评分：A

**结论：设计中无循环依赖，依赖方向单一且与仓颉包管理机制完全兼容。**

### 正向证据

- **依赖图为 DAG**：`glm.detail` 不依赖任何上层包；`glm.ext → glm.detail` 单向；`glm.gtc → glm.detail + glm.ext` 单向；`glm → 全部` 聚合。无环路。
- **包结构已验证**：当前项目 `cjglm/src/` 已存在 `detail/`、`ext/`、`gtc/` 三个子目录 + `lib.cj`，包名 `glm.detail`、`glm.ext`、`glm.gtc` 与目录层级一一对应。这是仓颉包解析的标准模式。阶段四的所有文件均落入这三个已有包中，不需要新增包。
- **`public import` 机制**：设计中的跨包依赖通过 `lib.cj` 的 `public import` 实现，与已有阶段二/三的模式完全一致。设计文档 §8 给出了 lib.cj 的完整更新代码块，并逐一分析了所有同名函数跨包导入的重载决议可行性（D23、D30）。
- **stdmath_shim 定位清晰**：`stdmath_shim.cj` 定为 `glm.detail` 的私有工具模块（非公共 API），仅被同包的 core 函数库调用，不产生跨包依赖风险。

### 已确认的具体依赖链

| 依赖链 | 风险评估 |
|---------|-----------|
| `common.cj → qualifier, setup` | ✅ 同包直接可见，已有阶段验证 |
| `exponential.cj → stdmath_shim.cj` | ✅ 同包新增文件，无跨包风险 |
| `trigonometric.cj → stdmath_shim.cj + qualifier + scalar_constants` | ✅ 全部同包 |
| `geometric.cj → stdmath_shim.cj + qualifier` | ✅ 全部同包 |
| `ext.quaternion_common → detail.trigonometric + detail.geometric` | ✅ 单向，验证 H3 |
| `gtc.matrix_transform → detail.* + ext.*` | ✅ 单向，验证 H3 |
| `lib.cj import {detail, ext, gtc}` | ✅ 聚合层，无反向依赖 |

### 唯一需注意的细节

设计文档 §2 中 `ext/matrix_projection.cj` 当前的 stub 文件包含了一个 `perspective` 函数（遗留），但 OOD 设计将此函数归属到 `ext/matrix_clip_space.cj`。此不一致属于**现有 stub 文件的过时遗留问题**——编码阶段替换完整实现时需按 OOD 设计清除 `ext/matrix_projection.cj` 中不属于它的 `perspective` stub，确保与 `ext/matrix_clip_space.cj` 的职责划分一致。

---

## 2. 类型系统可行性 — 评分：A

**结论：设计中的所有泛型约束、类型别名、函数签名均可在仓颉类型系统中实现，无已验证不可行的约束模式。**

### 正向证据

- **约束模式已在阶段一~三全部编译通过**：
  - `T <: FloatingPoint<T>` → `trigonometric.cj` stub 中已有 93 行签名使用此约束
  - `T <: Number<T> & Comparable<T>` → `common.cj` 中 `min/max/clamp` 等 6 个函数使用
  - `T <: Number<T>` → `geometric.cj` 中 `dot` 使用、`matrix.cj` 中 `determinant` 使用
  - `T <: Integer<T>` → `common.cj` 中 `mod` 使用
  - `Q <: Qualifier` → 全部 Vec/Mat 参数使用
  - 带多约束的 extend 块已在 `scalar_vec_ops.cj` 中广泛验证

- **关键类型设计决策均已验证**：
  - **H1** `T(Float64(n))` 语法 → ✅ 已验证（§1.7）
  - **H2** `FloatingPoint<T>` 接口方法可用性 → ✅ 已验证
  - **H6** 函数重载自动区分同名函数 → ✅ 已验证

- **已正确处理仓颉限制的降级设计**：
  - `gtc/ulp.cj`：`FloatingPoint<T>` 不提供 `toBits()`/`fromBits()`，降级为 Float32/Float64 具体类型重载（D27）
  - `gtc/packing.cj`：使用具体类型重载 + `toBits()`/`fromBits()` 原生 API（D12）
  - `gtc/noise.cj`：C++ 模板维度参数 → 拆分命名 `perlin1D`~`perlin4D`（D31）
  - `ext/vector_common.cj`：`Vec<L, T, Q>` 设计速记 → 展开为 Vec1~Vec4 四个独立重载（§3.2 符号约定）
  - `gtc/random.cj`：`ThreadLocal<Random>` 已验证可用（H5）
  - `modf`/`frexp`：元组返回替代 C 引用参数（D25）

- **约束收紧已明确标注**：
  - `geometric.cj` 从 `Number<T>` → `FloatingPoint<T>`（D16，向后不兼容）

### 潜在风险

| 风险点 | 风险等级 | 说明 |
|--------|---------|------|
| `ext/matrix_projection.cj` 引入独立类型参数 `U <: Number<U>` 与现有 `T <: FloatingPoint<T>` 并存 | 低 | 仓颉支持多泛型参数 + 独立约束，此模式已在 `castVec3<T, Q, T2, Q2>` 等已有函数中验证 |
| `gtc/ulp.cj float_distance` 的返回类型 `Int32`/`Int64` 依赖具体类型重载的分发 | 低 | 具体类型重载是仓颉标准支持的能力 |
| `gtc/type_precision.cj` 约 100 个别名定义 | 低 | `type` 别名语法 `type fvec2 = Vec2<Float32, PackedHighp>` 在已有 `fwd.cj` 中已验证 |
| `gtc/random.cj` 的 `ThreadLocal<Random>` 惰性初始化 | 低 | `ThreadLocal<T>` API 已验证，但编码阶段需注意 `get()` 返回 `Option<T>` 的空值处理 |

---

## 3. 性能可行性 — 评分：B

**结论：设计中的性能关键路径均有可行的实现路径。SIMD 不在仓颉标准库能力范围内，设计正确选择不依赖 SIMD。主要性能开销来自 `stdmath_shim.cj` 的 Float64 转型模式。**

### 分析

| 性能场景 | 设计路径 | 评估 |
|---------|---------|------|
| **`stdmath_shim.cj` 数学函数** | `(x as Float64).getOrThrow() → std.math → (result as T).getOrThrow()` | **不可避免的开销**。仓颉 `std.math` 仅提供 `(Float64): Float64` 签名，此转型是唯一选择。已在阶段三 `sqrtT` 中编译验证。每次向量运算有 2 次 `as` 转型 + 1 次 `.getOrThrow()` + 1 次 std.math 调用。对 Vec4，一个逐分量函数（如 `sin(v)`）调用 4 次 shim，共 8 次转型 + 4 次 std.math。在图形计算中可接受 |
| **矩阵余子式展开求逆** | 显式 cofactor 公式（与 GLM 一致） | O(n!) 复杂度在 n=4 时（48 项乘加）性能可接受。与 GLM C++ 参考实现相同算法，cross-validation 成本最低 |
| **`inversesqrt(0)` 返回 +Inf** | `T(1) / sqrt(x)` 无保护分支 | 直接利用 IEEE 754 浮点除零，比加分支判断更快 |
| **SIMD** | 设计中完全不依赖 | 正确选择。仓颉标准库无 SIMD 内建函数，且 GLM 1.0.3 的 SIMD 路径是平台特化优化，不影响核心 API 契约 |
| **`gtc/random.cj` 线程局部存储** | `ThreadLocal<Random>` | 比 `Mutex<Random>` 性能更好（无锁）。但每次 `linearRand` 调用涉及一次 `ThreadLocal.get()` 的 Option 判空分支，低概率场景可接受 |
| **内联函数** | 设计未讨论 `inline` | 仓颉编译器具备自动内联优化能力。设计中的函数均较短（1~5 行算术），期望编译器内联消解调用开销 |

### 性能风险

| 风险点 | 严重程度 | 说明 |
|--------|---------|------|
| `stdmath_shim.cj` 的 `Float64` 转型路径在高频调用场景（如每帧数万次 `normalize`）的热路径开销 | 中等 | 典型图形应用每帧 `normalize` 调用量在数百~数千次级别，Float64 转型开销可忽略。但若用于科学计算的高频循环，建议编码阶段构建 benchmark 评估。当前设计无需特殊优化 |
| `gtc/noise.cj` 的 Perlin/Simplex 算法无优化 | 低 | GLM 1.0.3 参考实现本身即为纯数学实现，无 SIMD 或其他优化。仓颉直译后性能等价。噪声函数在典型使用中调用频率不高 |

---

## 4. 边界情况覆盖 — 评分：A

**结论：设计中对于 NaN、Inf、零值、越界输入等边界情况均有明确且一致的处理策略。是所有验证维度中最为详尽的一项。**

### 边界情况清单

| 场景 | 设计处理 | 与 GLM 一致性 |
|------|---------|--------------|
| **acos/asin 输入超出 [-1, 1]** | 前置检查，返回 `T.getNaN()` | ✅ 一致（GLM 委托 std::acos 返回 NaN）。仓颉 std.math 抛异常，设计正确增加了保护 |
| **inversesqrt(0)** | 返回 `+Inf`（IEEE 754 `T(1)/0`） | ✅ 一致（GLM 3.2.8 节） |
| **Vec1 normalize 零值** | `0 × Inf = NaN`（IEEE 754 NaN 传播） | ✅ 一致（GLM `compute_normalize` 实现） |
| **Vec2~Vec4 normalize 零值** | 保护分支返回零向量 | ✅ 一致（GLSL 10.1.1） |
| **奇异矩阵求逆** | IEEE 754 自然结果（可能 NaN/Inf 填充） | ✅ 一致 |
| **frexp NaN/Inf/zero** | 返回 (NaN,0)/(Inf,0)/(0,0) | ✅ 一致 |
| **modf 负数** | `trunc(x)` 向零取整，`fractional = x - integer` | ✅ 一致 |
| **slerp sinOmega 接近零** | 退化为 lerp（阈值 `epsilon<T>()`） | ✅ 一致 |
| **slerp dot 越界** | 调用方 clamp(dot, -1, 1) 数值稳定 | ✅ 一致（GLM 同样 clamp） |
| **uround 负数输入** | `@OverflowThrowing` 抛出异常 | ⚠️ 差异（GLM 模运算回绕），设计已明确标注 |
| **Float16 stdmath_shim 溢出** | `(result as T).getOrThrow()` 抛出异常 | ⚠️ 差异（GLM 返回 ±Inf），设计已明确标注（D29） |
| **ldexp Float32 非规格化精度** | 接受精度损失 | ⚠️ 差异（GLM 使用更高精度），设计已明确标注（D29） |

### 评价

设计的边界情况覆盖之所以获得 A 评分，不仅因为覆盖场景多，更因为每一项边界情况都：
1. 在 **§5 错误处理策略** 中有统一表格记录
2. 在 **§3 具体设计** 中有详细实现公式
3. 在 **§7 设计决策** 中有对应 D 编号及理由
4. 与 **GLM 1.0.3** 行为做了一致性分析
5. 对已知差异标注了**触发概率**和**接受理由**

### 唯一遗漏

`gtc/round.cj` 的 `roundPowerOfTwo/ceilPowerOfTwo/floorPowerOfTwo` 等函数未讨论输入为 NaN/Inf/zero 时的行为。建议编码阶段参照 GLM 1.0.3 源码补充这些边缘场景处理（GLM 的 `floorPowerOfTwo(+Inf)` 返回 `+Inf`，`NaN` 返回 `NaN`）。此遗漏不影响整体可行性，但编码阶段需补充。

---

## 5. 构建可行性 — 评分：A

**结论：设计的模块划分与仓颉项目结构完全兼容，包路径、可见性、增量构建策略均已考虑。**

### 正向证据

- **包路径兼容**：`cjpm.toml` 指定 `src-dir = "src"`，`src/detail/` → 包 `glm.detail`，`src/ext/` → 包 `glm.ext`，`src/gtc/` → 包 `glm.gtc`。阶段四所有文件都落在这三个已有包中，不需修改 `cjpm.toml` 或新增包路径。
- **增量实施计划**：§8 按拓扑依赖排序分为 4 批，每批内部可并行编码。此计划确保任一阶段编译不依赖未完成的后续批。
- **lib.cj 增量追加策略**：在现有 28 行之后追加 phase 4 的 `public import`，仅需修改已有第 23 行（D30 冲突解决）。保证下游消费者的 imports 不受影响。
- **可见性设计合理**：
  - `stdmath_shim.cj`（无 ★）= 无 public export，仅 `glm.detail` 内部可见
  - core/ext/gtc 函数均为 `public`，通过 `lib.cj` 的 `public import` 暴露到 `glm` 包顶级 API
  - `gtc/noise.cj` 辅助函数（`mod289`/`permute`/`taylorInvSqrt`/`fade`/`grad4`）设计为私有包级函数
- **交叉编译不适用**：仓颉 GLM 是纯算法库，无平台特定代码或 CFFI，交叉编译无影响。
- **编译缓存友好**：4 批划分确保每批内部文件可并行编译，且编译器能缓存已编译的批次。

### lib.cj 更新风险评估

| 冲突点 | 设计解决方案 | 验证 |
|--------|-------------|------|
| `translate/rotate/scale/shear/lookAt` 在 ext 和 gtc 重复 | 删除 lib.cj:23 的 gtc 导入，改由 ext 导入，gtc 内部 `public import` 转发（D30） | 已验证重载决议可行（H6） |
| `mix/detail.mix` vs `mix/ext.mix` | 参数类型不同（标量/Vec vs Quat）自动区分 | 已验证（H6） |
| `exp/log/pow/sqrt` detail vs ext | 参数类型不同（标量/Vec vs Quat）自动区分 | 已验证（H6） |
| `perspective/ortho/frustum` 从 ext 和 gtc 同时导入 | 从 ext import 中删除，仅保留 gtc 导入 | 设计已修复（v3→v4 P5） |
| `min/max/clamp` detail（2 输入）vs ext（3/4 输入/1 输入） | 参数个数不同，重载可区分 | 已验证（H6） |

---

## 总体结论：PASS

### 评分汇总

| 维度 | 评分 | 关键理由 |
|------|------|---------|
| 模块依赖可行性 | **A** | 无循环依赖，与仓颉包机制完全兼容 |
| 类型系统可行性 | **A** | 所有泛型约束/别名/签名均已在阶段一~三验证可行 |
| 性能可行性 | **B** | `stdmath_shim` Float64 转型是必要开销；SIMD 不可用但设计不依赖 |
| 边界情况覆盖 | **A** | NaN/Inf/零值/越界均详尽说明，与 GLM 一致性分析到位 |
| 构建可行性 | **A** | 增量策略+4 批实施+lib.cj 追加，与现有结构零冲突 |

### 无需修复的问题（编码阶段建议关注）

以下为编码阶段的建议关注项，**不构成可行性障碍**：

1. **`gtc/round.cj` NaN/Inf/zero 边界行为未定义**：建议编码时参照 GLM `gtc/round.inl` 补充 `floorPowerOfTwo(+Inf)`、`ceilPowerOfTwo(NaN)` 等边缘场景的处理策略，并在 `ext/` 或 `gtc/` 的错误处理策略中补充说明。

2. **`ext/matrix_projection.cj` 现有 stub 包含不属于自己的 `perspective` 函数**：编码阶段替换完整实现时，需清除该文件中不属于本文件职责的遗留 stub。

3. **`gtc/noise.cj` 算法迁移的 code review 重点**：Perlin/Simplex 算法（GLM ~800 行 C++）是阶段四最复杂的算法迁移。建议编码阶段重点 review `permute`、`grad4` 等辅助函数的数学正确性和浮点精度。

4. **`gtc/type_precision.cj` 别名命名空间测试**：约 100 个别名需要在编码阶段验证与 `fwd.cj` 的泛型类型无命名冲突（设计声明无重叠，但建议实际 build 验证）。
