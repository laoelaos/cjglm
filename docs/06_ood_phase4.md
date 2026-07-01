# GLM 1.0.3 仓颉迁移阶段四 OOD 设计方案

> **修订日期**：2026-06-29

---

## 1. 概述

### 设计目标

在阶段一（Vec1~Vec4 向量类型 + 基础设施）、阶段二（9 个矩阵类型 + ext/ 别名）和阶段三（Quat 四元数 + ext/gtc 函数库框架）的基础上，将 GLM 全部核心函数库（core）和扩展函数库（ext/gtc）的 stub 替换为完整实现，使库具备完整的 GLSL 风格数学运算能力。阶段四完成后，本阶段定义范围内的全部 stub 文件均被替换为完整实现，所有阶段三中因依赖函数库 stub 而处于"编译通过但抛 stub"或"完全不可用"状态的四元数功能将自动解锁。

### 核心抽象

| 抽象 | 角色 | 类型形态 |
|------|------|---------|
| common.cj 函数族 | 提供 GLSL 通用数学函数（abs/sign/floor/ceil/fract/mod/min/max/clamp/mix/step/smoothstep/isnan/isinf 等） | 包级泛型函数（标量 + Vec1~Vec4 重载） |
| exponential.cj 函数族 | 提供 GLSL 指数函数（pow/exp/log/exp2/log2/sqrt/inversesqrt） | 包级泛型函数（标量 + Vec1~Vec4 重载） |
| trigonometric.cj 函数族 | 提供 GLSL 角度与三角函数（radians/degrees/sin/cos/tan/asin/acos/atan/atan2/sinh/cosh/tanh/asinh/acosh/atanh） | 包级泛型函数（标量 + Vec1~Vec4 重载） |
| geometric.cj 函数族 | 提供 GLSL 几何函数（dot/cross/normalize/length/distance/reflect/refract/faceforward） | 包级泛型函数（Vec1~Vec4 重载） |
| matrix.cj 行列式/逆 | 提供矩阵行列式和逆运算（determinant/inverse，仅方阵 2x2/3x3/4x4） | 包级泛型函数 |
| ext/scalar_common.cj | 提供标量公共扩展函数 | 包级泛型函数 |
| ext/vector_common.cj | 提供向量公共扩展函数 | 包级泛型函数 |
| ext/matrix_transform.cj | 矩阵变换扩展（translate/rotate/scale/shear/lookAt 系族） | 包级泛型函数 |
| ext/matrix_projection.cj | 投影矩阵扩展（project/unProject/pickMatrix） | 包级泛型函数 |
| ext/matrix_clip_space.cj | 裁剪空间矩阵扩展（ortho/frustum/perspective 系族） | 包级泛型函数 |
| ext/quaternion_common.cj mix/slerp | 补齐 stub（mix/slerp 依赖 trigonoic 和 geometric） | 包级泛型函数 |
| ext/quaternion_transform.cj rotate | 补齐 stub（rotate 依赖 trigonometric） | 包级泛型函数 |
| gtc/matrix_transform.cj | gtc 矩阵变换扩展（identity/translate/rotate/scale/lookAt/perspective/ortho/frustum 等系族） | 包级泛型函数 |
| gtc/matrix_inverse.cj | 矩阵逆辅助（affineInverse/inverseTranspose 等） | 包级泛型函数 |
| gtc/matrix_access.cj | 矩阵行列访问辅助（row/column 函数） | 包级泛型函数 |
| gtc/packing.cj | 数据打包与解包函数 | 包级泛型函数 |
| gtc/noise.cj | 噪声生成函数 | 包级泛型函数 |
| gtc/random.cj | 随机数生成函数 | 包级泛型函数 |
| gtc/type_precision.cj | 高精度类型别名定义 | type 别名 |
| gtc/ulp.cj | ULP（Units in the Last Place）浮点比较函数 | 包级泛型函数 |
| gtc/round.cj | 浮点舍入函数（round/roundEven/trunc/ceil/floor/fract 等补充） | 包级泛型函数 |

### 整体架构思路

沿用阶段一至三的包结构体系，保持 `glm.detail`（core 函数库）、`glm.ext`（扩展函数库）、`glm.gtc`（GTC 扩展函数库）的三层包架构。core 函数库全部位于 `glm.detail` 包中，以自由函数（free functions）形式提供，遵循 GLSL 规范的函数签名的约定。

所有 core 函数遵循"标量泛型函数 + Vec1~Vec4 向量化重载"模式：先定义 `func foo<T>(x: T): T`（标量版本），再为 Vec1~Vec4 各定义 `func foo<T, Q>(x: VecN<T, Q>): VecN<T, Q> where ...`（逐分量向量版本）。

### 约束继承与表示约定

阶段二/三已识别的系统性约束在本阶段继续适用：
- **字面量构造问题**：使用已编译验证的 `T(Float64(n))` 替代直接调用 `T(n)` 构造函数。本文档公式中使用 `T(n)` 简写表示在代码层面应替换为 `T(Float64(n))`，仅 `one: T` 作为函数参数时保留显式传入路径
- **FloatingPoint<T> 接口**：已验证 `T.getInf()`/`T.isNaN()` 等静态方法可用（验证项 20 已通过）
- **std.math Float64 委托模式**：`std.math` 的数学函数（`sqrt`/`exp`/`log`/`sin`/`cos`/`tan` 等）仅提供 `(Float64): Float64` 签名，不支持 Float16/Float32 泛型参数。在 `glm.detail` 中新增私有工具模块 `stdmath_shim.cj`，为各 std.math 函数提供统一的泛型包装函数。包装模式：`func sqrtT<T>(x: T): T where T <: FloatingPoint<T> { return (std.math.sqrt((x as Float64).getOrThrow()) as T).getOrThrow() }`。所有 core/ext 函数库通过此包装层间接调用 std.math，不直接委托。此模式已在项目现有代码（`ext/quaternion_geometric.cj` 的 `sqrtT`、`ext/quaternion_trigonometric.cj` 的 `sqrtT`、`detail/type_quat_cast.cj` 的 `sqrtT`）中得到编译验证。**已知行为差异**：`(result as T).getOrThrow()` 在 `T = Float16` 且中间值超过 ±65504 时抛出异常（因 Float64→Float16 转型溢出），而 GLM 1.0.3 返回 ±Inf。此差异在 Float16 低精度图形场景中触发概率极低，本设计接受此差异（见 D29）

  **stdmath_shim.cj 完整包装函数清单**（共 25 个包装函数，签名均遵循统一模式 `func <name>T<T>(x: T[, ...]): T where T <: FloatingPoint<T>`，内部实现为 `(std.math.<func>(Float64(x)) as T).getOrThrow()`）：

  ```
  // 指数/对数/幂
  func sqrtT<T>(x: T): T                           // std.math.sqrt(Float64)
  func inversesqrtT<T>(x: T): T                     // 直接返回 T(1) / sqrtT(x)，非 std.math 委托
  func expT<T>(x: T): T                             // std.math.exp
  func logT<T>(x: T): T                             // std.math.log
  func exp2T<T>(x: T): T                            // std.math.exp2
  func log2T<T>(x: T): T                            // std.math.log2
  func powT<T>(base: T, exp: T): T                  // std.math.pow

  // 三角函数
  func sinT<T>(x: T): T                             // std.math.sin
  func cosT<T>(x: T): T                             // std.math.cos
  func tanT<T>(x: T): T                             // std.math.tan
  func asinT<T>(x: T): T                            // std.math.asin
  func acosT<T>(x: T): T                            // std.math.acos
  func atanT<T>(x: T): T                            // std.math.atan
  func atan2T<T>(y: T, x: T): T                     // std.math.atan2

  // 双曲函数
  func sinhT<T>(x: T): T                            // std.math.sinh
  func coshT<T>(x: T): T                            // std.math.cosh
  func tanhT<T>(x: T): T                            // std.math.tanh
  func asinhT<T>(x: T): T                           // std.math.asinh
  func acoshT<T>(x: T): T                           // std.math.acosh
  func atanhT<T>(x: T): T                           // std.math.atanh

  // 舍入/绝对值
  func floorT<T>(x: T): T                           // std.math.floor
  func ceilT<T>(x: T): T                            // std.math.ceil
  func roundT<T>(x: T): T                           // std.math.round
  func truncT<T>(x: T): T                           // std.math.trunc
  func absT<T>(x: T): T                             // std.math.abs
  func fmodT<T>(x: T, y: T): T                      // std.math.fmod
  ```

  注意：`inversesqrtT` 并非 std.math 委托，而是直接实现为 `T(1) / sqrtT(x)`，因此不列在 `stdmath_shim.cj` 的委托包装函数中（它属于 `exponential.cj` 内部）。`sqrtT` 已在项目现有代码中得到编译验证。每个包装函数均提供 `T <: FloatingPoint<T>` 泛型约束，通过 `(x as Float64).getOrThrow()` → `std.math.<func>(float64Val)` → `(result as T).getOrThrow()` 三步骤完成类型转换和委托。

### 本阶段不覆盖范围

| 文件 | 原因 | 当前状态 |
|------|------|---------|
| ext/quaternion_exponential.cj | GLM 1.0.3 中四元数指数/对数/幂/平方根函数（exp/log/pow/sqrt）属于极少使用的实验性功能，不在典型 GLSL 数学运算需求范围内。其实现需依赖四元数指数级数展开，数学复杂度高且使用面窄 | 保持阶段三 stub 状态（4 个函数全部抛 stub 异常） |

本阶段结束后，库中除 `ext/quaternion_exponential.cj` 的 4 个实验性函数外，无存留 stub。

**后续规划**：`ext/quaternion_exponential.cj` 的 4 个实验性函数（exp/log/pow/sqrt）按路线图阶段 6（路线图第 262-288 行，gtx 实验性扩展）的"按需实现"策略处理——当有实际项目需求时，由后续阶段按需补充实现，不做强制迁移要求。当前阶段对这 4 个函数保持 stub + 标注为实验性 API 的决策，不排除未来将其完整实现的可能。

### 阶段四范围与路线图的交叉验证映射

以下映射表将路线图 `docs/02_roadmap.md` "阶段 4" 章节（第 137-219 行）中的范围定义与本设计方案中的对应位置建立显式关联，并标注差异：

| 路线图范围项 | 本设计对应位置 | 差异说明 |
|------------|--------------|---------|
| **基础函数库（core）** | | |
| `common.cj` | §3.1 common.cj | 一致 |
| `matrix.cj`（determinant/inverse） | §3.1 matrix.cj（determinant/inverse） | 一致 |
| `geometric.cj` | §3.1 geometric.cj | 一致 |
| `exponential.cj` | §3.1 exponential.cj | 一致 |
| `trigonometric.cj` | §3.1 trigonometric.cj | 一致 |
| **ext/ 扩展函数库** | | |
| `ext/scalar_common.cj` | §3.2 ext/scalar_common.cj | 一致 |
| `ext/vector_common.cj` | §3.2 ext/vector_common.cj | 一致 |
| `ext/matrix_transform.cj` | §3.2 ext/matrix_transform.cj | 一致 |
| `ext/matrix_projection.cj` | §3.2 ext/matrix_projection.cj | 一致 |
| `ext/matrix_clip_space.cj` | §3.2 ext/matrix_clip_space.cj | 一致 |
| `ext/quaternion_transform.cj`（补齐） | §3.2 ext/quaternion_transform.cj（rotate） | 路线图将 `angleAxis` 归于此文件；本设计将其置于 `ext/quaternion_trigonometric.cj`（见下），因三角函数语义更匹配 |
| `ext/quaternion_common.cj`（补齐） | §3.2 ext/quaternion_common.cj（mix/slerp） | 一致 |
| **gtc/ 扩展函数库** | | |
| `gtc/matrix_transform.cj` | §3.3 gtc/matrix_transform.cj | 一致 |
| `gtc/matrix_inverse.cj` | §3.3 gtc/matrix_inverse.cj | 一致 |
| `gtc/matrix_access.cj` | §3.3 gtc/matrix_access.cj | 一致 |
| `gtc/packing.cj` | §3.3 gtc/packing.cj | 一致 |
| `gtc/noise.cj` | §3.3 gtc/noise.cj | 一致 |
| `gtc/random.cj` | §3.3 gtc/random.cj | 一致 |
| `gtc/type_precision.cj` | §3.3 gtc/type_precision.cj | 一致 |
| `gtc/ulp.cj` | §3.3 gtc/ulp.cj | 一致 |
| `gtc/round.cj` | §3.3 gtc/round.cj | 一致 |

**差异说明**：`angleAxis` 在路线图中位于 `ext/quaternion_transform.cj`（路线图第 152 行"四元数变换"范围），而本设计和项目代码库将其置于 `ext/quaternion_trigonometric.cj`。理由：`angleAxis` 本质是三角函数运算（sin/cos 构造旋转四元数），语义上归属于三角函数模块而非变换模块。此差异不影响功能完整性——`angleAxis` 在两个文件位置均可正确实现，`lib.cj` 导出时以实际文件位置为准。

### 本阶段补齐范围补充

阶段三中 `ext/quaternion_trigonometric.cj` 的 `angle` 和 `angleAxis` 两个函数因依赖 `trigonometric.cj`（属于本阶段范围）而处于 stub 状态。本阶段将其纳入补齐范围——实现 `angle`（返回四元数的旋转角度，使用 `acos(w)` 公式）和 `angleAxis`（从角度和轴向量构造四元数，使用 `sin/cos` 公式）。补齐后在 §2 模块划分中以 ★ 标记。

### 设计确定性声明

本设计建立在阶段三已验证的三项 P0 核心假设之上：
1. **H1 — `T(Float64(n))` 语法可行性**：✅ 已通过编译验证
2. **H2 — `FloatingPoint<T>` 接口方法可用性**：✅ 已通过编译验证
3. **H3 — 包间依赖单向性（无循环依赖）**：✅ 已通过编译验证

本阶段新增确定性声明：
4. **H4 — 仓颉浮点类型遵循 IEEE 754 标准，浮点除零返回 ±Inf**：✅ 已通过仓颉原始文档和编译验证确认。`Float16`/`Float32`/`Float64` 明确遵循 IEEE 754 标准，`T(1) / T(0)` 自然返回 `+Inf`/`-Inf`，不抛出 `ArithmeticException`（该异常仅适用于整数除零和 Decimal/BigInt 类型）。此确定性声明支撑 `inversesqrt(0)` 返回 `+Inf` 的设计决策（D20）以及 Vec1 normalize 零值返回 NaN 的行为（依赖 `0 * Inf = NaN` 的 IEEE 754 传播规则）
5. **H5 — `ThreadLocal<T>` 在仓颉中可用且不要求 `T <: Send` 约束**：✅ 已通过仓颉并发编程文档确认。`ThreadLocal<T>` 来自 `core` 包（无需导入），提供 `get(): Option<T>` 和 `set(value: Option<T>): Unit` 接口。`ThreadLocal<T>` 对类型参数 `T` 无 `Send`/`Sync` 约束要求，任何类型均可作为线程局部变量存储
6. **H6 — 仓颉函数重载可基于参数类型自动区分同名函数**：✅ 已通过仓颉语言文档确认。仓颉支持函数重载（function overloading），编译器基于参数类型、参数数量和泛型约束进行重载决议。当 `glm.detail.mix(x: T, y: T, a: T)`（标量/向量版本）和 `glm.ext.mix(x: Quat, y: Quat, a: T)`（四元数版本）通过 `public import` 同时可见时，编译器可根据调用参数类型自动选择正确的版本。同理，`detail.exp/log/pow/sqrt`（标量/向量版本）与 `ext.exp/log/pow/sqrt`（四元数版本）也可通过参数类型自动区分

---

## 2. 模块划分

### 包组织

```
package glm.detail              — 核心实现层（修改/新建文件以 ★ 标记）
  ├── common.cj ★                — 替换 stub 为完整实现
  │                               （abs/sign/floor/ceil/trunc/round/roundEven/fract/mod/modf/
  │                                min/max/clamp/mix/step/smoothstep/isnan/isinf/
  │                                floatBitsToInt/floatBitsToUint/intBitsToFloat/uintBitsToFloat/
  │                                fma/frexp/ldexp）
  ├── exponential.cj ★           — 新建完整实现
  │                               （pow/exp/log/exp2/log2/sqrt/inversesqrt）
  ├── trigonometric.cj ★         — 替换 stub 为完整实现
  │                               （sin/cos/tan/asin/acos/atan/atan2/sinh/cosh/tanh/asinh/acosh/atanh/
  │                                radians/degrees）
  ├── geometric.cj ★             — 替换 stub 为完整实现
  │                               （dot/cross/normalize/length/distance/reflect/refract/faceforward）
  ├── matrix.cj ★                — 替换 determinant/inverse stub 为完整实现
  │                               （行列式 2x2/3x3/4x4，逆矩阵 2x2/3x3/4x4）
  │                               transpose/matrixCompMult/outerProduct 已在阶段二完整实现，本阶段无修改
  ├── stdmath_shim.cj            — 新增私有工具模块（无 ★，非公共 API 文件）
  │                               为每个 std.math 函数提供泛型包装函数（sqrtT/expT/logT/sinT/cosT 等），
  │                               内部统一使用 (x as Float64).getOrThrow() → std.math → (result as T).getOrThrow()
  │                               模式。所有 core/ext 函数库通过此包装层间接调用 std.math，不直接委托
  ├── vector_relational.cj ★     — 补全 5 个缺失函数（equal/notEqual/any/all/not_）
  │                               阶段三仅设计 lessThan/greaterThan/lessThanEqual/greaterThanEqual 四个比较函数，
  │                               本阶段补全 GLM 1.0.3 vector_relational.hpp 完整函数集
  ├── scalar_constants.cj        — 沿用阶段三（epsilon/pi/cos_one_over_two）
  └── ...（其他阶段一二三文件不变）

package glm.ext                 — 扩展函数库（修改/新建文件以 ★ 标记）
  ├── scalar_common.cj ★         — 新建完整实现
  │                               （scalar 版本的 min/max/clamp/mix/step/smoothstep 等补充重载）
  ├── vector_common.cj ★         — 新建完整实现
  │                               （向量公共运算函数）
  │                               
  ├── matrix_transform.cj ★      — 替换 stub 为完整实现
  │                               （translate/rotate/scale/shear/lookAt/lookAtRH/lookAtLH，对标
  │                                GLM 1.0.3 ext/matrix_transform.hpp）
  ├── matrix_projection.cj ★     — 替换 stub 为完整实现
  │                               （projectZO/projectNO/project/unProjectZO/unProjectNO/unProject/
  │                                pickMatrix，对标 GLM 1.0.3 ext/matrix_projection.hpp）
  ├── matrix_clip_space.cj ★     — 替换 stub 为完整实现
  │                               （ortho/frustum/perspective/perspectiveFov/infinitePerspective/
  │                                tweakedInfinitePerspective 系族，对标 GLM 1.0.3
  │                                ext/matrix_clip_space.hpp 全部函数）
  │                               
  ├── quaternion_common.cj ★     — 补齐 mix/slerp/slerp(k) stub 为完整实现
  │                               （依赖 trigonometric.cj 的 acos/sin 和 geometric.cj 的 cross）
  ├── quaternion_transform.cj ★  — 补齐 rotate stub 为完整实现
  │                               （依赖 trigonometric.cj 的 sin/cos）
  ├── quaternion_geometric.cj    — 沿用阶段三（dot/length/normalize/cross 全部实现）
  ├── quaternion_trigonometric.cj★ — 补齐 angle/angleAxis stub（依赖 trigonometric.cj，属于本阶段范围）
  ├── quaternion_relational.cj   — 沿用阶段三
  ├── quaternion_exponential.cj  — 沿用阶段三（本阶段不覆盖，见 §1.5）
  ├── scalar_constants.cj        — 沿用阶段三
  ├── vector_relational.cj       — 沿用阶段三
  └── 别名文件                   — 沿用阶段三

package glm.gtc                 — GTC 扩展函数库（修改/新建文件以 ★ 标记）
  ├── matrix_transform.cj ★      — 替换 stub 为完整实现
  │                               （identity/translate/rotate/rotate_slow/scale/scale_slow/
  │                                shear/shear_slow/lookAt/lookAtRH/lookAtLH/
  │                                ortho 系族 10 函数/frustum 系族 9 函数/
  │                                perspective 系族 9 函数/perspectiveFov 系族 9 函数/
  │                                infinitePerspective 系族 7 函数/tweakedInfinitePerspective 系族 2 函数/
  │                                projectZO/projectNO/project/unProjectZO/unProjectNO/unProject/
  │                                pickMatrix）
  ├── matrix_inverse.cj ★        — 新建完整实现
  │                               （affineInverse/inverseTranspose）
  ├── matrix_access.cj ★         — 新建完整实现
  │                               （row/column 行列访问函数）
  ├── packing.cj ★               — 新建完整实现
  │                               （packUnorm/packSnorm/packHalf/pack/unpack 等，见 §3.3
  │                                packing.cj 完整函数签名清单）
  ├── noise.cj ★                 — 新建完整实现
  │                               （perlin/simplex 噪声函数）
  ├── random.cj ★                — 新建完整实现
  │                               （linearRand/gaussRand 等随机数生成函数）
  ├── type_precision.cj ★        — 新建完整实现
  │                               （高精度类型别名定义）
  ├── ulp.cj ★                   — 新建完整实现
  │                               （next_float/prev_float/float_distance/ulp 等）
  ├── round.cj ★                 — 新建完整实现
  │                               （roundPowerOfTwo/ceilPowerOfTwo/floorPowerOfTwo/roundMultiple 等）
  ├── constants.cj               — 沿用阶段三
  └── quaternion.cj              — 沿用阶段三

package glm                     — 公共 API 面（修改文件以 ★ 标记）
  ├── lib.cj ★                   — 新增阶段四函数库的 public import
  └── fwd.cj                     — 沿用阶段三（本阶段不新增核心类型别名）
```

### 模块间依赖

```
glm.detail（同包直接可见）
  common.cj → qualifier, setup, stdmath_shim.cj（frexp 委托 logT、ldexp 委托 powT）
  exponential.cj → stdmath_shim.cj（委托 shim 包装函数调用 std.math）
   trigonometric.cj → stdmath_shim.cj + qualifier + scalar_constants（pi<T>() 函数，radians/degrees 使用）
  geometric.cj → stdmath_shim.cj + qualifier（通过 shim 包装函数 indirect 依赖 std.math）
  matrix.cj → type_mat2x2 ~ type_mat4x4（已存在）
  stdmath_shim.cj → std.math（Float64 转型模式，唯一直接依赖 std.math 的文件）
  scalar_constants.cj → setup（已存在）

glm.ext
  scalar_common.cj → glm.detail.common（复用 min/max/clamp 等）
  vector_common.cj → glm.detail（Vec 类型 + common 函数）
  matrix_transform.cj → glm.detail（Mat4x4, Vec3, Vec4 + common/geometric/trigonometric）
  matrix_projection.cj → glm.detail（Mat4x4 + trigonometric/geometric）
  matrix_clip_space.cj → glm.detail（Mat4x4 + common/geometric + trigonometric）
  quaternion_common.cj mix/slerp → glm.detail.trigonometric + glm.detail.geometric + glm.detail.common + ext/scalar_constants
    （mix 依赖 common.cj 的 mix 标量函数；slerp 依赖 trigonometric.cj 的 acos/sin/cos）
  quaternion_transform.cj rotate → glm.detail.trigonometric（sin/cos） + glm.detail.geometric（length）
  quaternion_trigonometric.cj angle/angleAxis → glm.detail.trigonometric（acos/sin/cos）+ glm.detail.common（clamp）

glm.gtc（单向依赖 glm.detail，无循环依赖）
  matrix_transform.cj → glm.detail（Mat4x4, Vec{2,3,4}, trigonometric, geometric, matrix）+ glm.ext（委托 ext/matrix_transform、ext/matrix_projection、ext/matrix_clip_space）
  matrix_inverse.cj → glm.detail（Mat{2,3,4}x{2,3,4}, matrix.determinant）
  matrix_access.cj → glm.detail（Mat{2,3,4}x{2,3,4}）
  packing.cj → glm.detail（Vec 类型 + common 函数）
  noise.cj → glm.detail（Vec 类型 + common 函数）
  random.cj → glm.detail（Vec 类型 + common 函数）
  type_precision.cj → glm.detail（Vec/Mat/Quat 类型）
  ulp.cj → glm.detail（FloatingPoint<T> 接口 + std.math）
  round.cj → glm.detail（common 函数 + Vec 类型）

glm
  lib.cj → glm.detail（core 函数库）, glm.ext, glm.gtc
```

### 依赖方向总览

- `glm.gtc → glm.detail` 单向（无循环依赖）
- `glm.ext → glm.detail` 单向（ext 的 quaternion 文件在补齐 stub 后不再依赖同名 ext 文件自身——`mix`/`slerp`/`rotate` 只依赖 `glm.detail` 的 trigonoic/geometric 函数，无跨包循环）
- `glm → glm.detail/gtc/ext` 顶层聚合
- `glm.detail` 不依赖任何上层包

### 与阶段三的依赖变化说明

阶段三中受 stub 阻塞的依赖链在本阶段全部解除：

| 阶段三阻塞点 | 本阶段解除方式 | 解锁的功能 |
|-------------|--------------|-----------|
| geometric.cj（stub） | 替换为完整实现 | Quat×Vec3/Quat×Vec4 运算符、ext/quaternion_geometric 的 cross → normalize → 完整工作链、ext/quaternion_common 的 slerp |
| trigonometric.cj（stub） | 替换为完整实现 | ext/quaternion_transform 的 rotate、ext/quaternion_common 的 slerp/mix、gtc/quaternion 的 eulerAngles/roll/pitch/yaw |
| common.cj（stub） | 替换为完整实现 | ext/quaternion_common 的 mix、全部依赖 min/max/clamp 的 ext/gtc 函数 |
| matrix.cj（determinant/inverse stub） | 替换为完整实现 | Mat2x2/Mat3x3/Mat4x4 的除法运算符 `/`（依赖 inverse）、gtc/matrix_inverse |
| ext/matrix_{transform,projection,clip_space}.cj（stub） | 替换为完整实现 | gtc/matrix_transform 的传递依赖解除 |
| gtc/matrix_transform.cj（stub） | 替换为完整实现 | 全部 64 个 GLM 矩阵变换 API |

---

## 3. 核心抽象

### 3.1 core 函数库（glm.detail）

#### common.cj

**角色**：提供 GLSL 8.3 节定义的通用数学函数的标量和向量版本。

**职责**：
- 标量版本：`func min<T>(a: T, b: T): T where T <: Number<T> & Comparable<T>` 等，直接使用 std.math 的对应函数或纯数学演算
- 向量版本：为 Vec1~Vec4 各定义逐分量应用标量函数的版本
- 约束策略：
  - `abs/sign/min/max/clamp/step/smoothstep`：`T <: Number<T> & Comparable<T>`（需要比较运算）
  - `floor/ceil/trunc/round/roundEven/fract/modf/fma/frexp/ldexp`：`T <: FloatingPoint<T>`（需要浮点特定运算）
  - `mix`：三参数版本 `T <: Number<T>`（线性插值），Bool 选择版本独立重载
  - `isnan/isinf`：`T <: FloatingPoint<T>`（需要 isNaN/isInf 实例方法）
   - `mod`：`T <: Integer<T>`（整数取模。当前 common.cj 泛型 `mod` 约束为 `Integer<T>`；`scalar_vec_ops.cj` 中已有 12 个具体浮点类型向量重载（3 种浮点类型 × 4 种向量维度），这些重载以具体类型函数形式存在，与泛型 `mod` 通过函数重载共存。编码阶段保持此格局：generic `mod` 维持 `Integer<T>` 约束不变，具体浮点重载保持不变，双方通过编译器重载解析自动选择。**推荐实现 3 个标量浮点 `mod` 重载**：`func mod(x: Float32, y: Float32): Float32`、`func mod(x: Float64, y: Float64): Float64`、`func mod(x: Float16, y: Float16): Float16`，使用 `x - y * floor(x / y)` 公式，使 GLSL 的 `mod(float, float)` 调用可直接编译）
  - `floatBitsToInt/floatBitsToUint/intBitsToFloat/uintBitsToFloat`：具体类型重载（仅 Float32/Int32/UInt32）
- **modf/frexp/ldexp 签名设计**：
  - `modf<T>(x: T): (T, T)` where T <: FloatingPoint<T>：返回 (fractional, integer) 元组，替代 C 语言的引用参数输出模式。仓颉无引用参数，元组返回是自然且类型安全的替代方案。integer 部分通过 `trunc(x)` 获得，fractional = x - integer
  - `frexp<T>(x: T): (T, Int64)` where T <: FloatingPoint<T>：返回 (mantissa, exponent) 元组。mantissa 为 `[0.5, 1)` 范围的归一化尾数，exponent 为 2 的幂指数。《=64 位浮点指数范围在 Int64 内。实际上实现时应避免将 exponent 保持为泛型 T（因指数是整数语义而非浮点），使用 Int64 作为指数类型。**边缘场景处理**：采用数学分解加前置检查策略——若 `x.isNaN()` 则返回 `(T.getNaN(), 0)`；若 `x.isInf()` 则返回 `(x, 0)`；若 `x == T(0)` 则返回 `(T(0), 0)`；合法值使用 `exponent = floor(log2(abs(x))) + 1` 计算指数（委托 std.math.log2 经 stdmath_shim.cj），`mantissa = x / pow(T(2), T(exponent))` 归一化尾数。非规范化数在此分解下的精度损失列入已知行为差异，无需特殊处理
  - `ldexp<T>(x: T, exp: Int64): T` where T <: FloatingPoint<T>：实现为 `x * pow(T(2), T(exp))`（不委托 `std.math.ldexp`，仓颉标准库不提供此函数）。`T(exp)` 转换需使用 `T(Float64(exp))` 按 §1.4 的表示约定处理。所有浮点类型（Float16/Float32/Float64）均通过 `stdmath_shim.cj` 的 `powT` 包装函数统一实现，无需特殊回退分支<br><br>**Float32 非规格化数精度损失说明**：`ldexp` 的实现 `x * powT(T(2), T(exp))` 在 `T = Float32` 且 `x` 为非规格化数（denormalized number）时，中间值 `powT(T(2), T(exp))` 与 `x` 的乘运算可能导致额外的舍入误差。GLM 1.0.3 的 C++ `std::ldexp` 在内部使用更高精度中间值处理此场景。此精度损失属于已知实现差异，在非规格化数参与的计算中触发概率低（非规格化数在典型图形计算中极少出现），当前设计接受此差异
- **modf 负数语义**：`modf(-3.14)` 应返回 `(-0.14, -3.0)`——fractional 部分带输入符号，integer 部分向零取整。公式：`integer = trunc(x)`，`fractional = x - integer`。与 GLM 1.0.3 中通过 C 标准库 `modf(-3.14, &i)` 的行为一致

**为什么是包级函数而非成员函数**：GLSL 规范将此定义为自由函数，且多个函数在 Vec 类型上按分量独立操作。包级函数签名对调用方透明（`min(a, b)` 而非 `a.min(b)`），与 GLM C++ API 一致。

**协作关系**：
- 被 trigonometric.cj（acos/atan → clamp）、geometric.cj（reflect/refract → clamp/step）、ext 和 gtc 函数库广泛调用
- 所有使用 `common.cj` 函数族的泛型函数通过 `Number<T>`/`FloatingPoint<T>` 接口操作

#### exponential.cj

**角色**：提供 GLSL 8.2 节定义的指数函数。

**职责**：
- 包含 `pow(base, exponent)`、`exp(v)`、`log(v)`、`exp2(v)`、`log2(v)`、`sqrt(v)`、`inversesqrt(v)`
- 约束策略：全部函数使用 `T <: FloatingPoint<T>`
- 实现路径：
  - 所有函数通过 `stdmath_shim.cj` 包装层调用。`exp/log/exp2/log2/sqrt` 委托对应的 shim 包装函数（`expT`/`logT`/`exp2T`/`log2T`/`sqrtT`），内部统一经 `(x as Float64).getOrThrow()` → `std.math.*(float64Val)` → `(result as T).getOrThrow()` 模式实现 Float16/Float32/Float64 全覆盖
  - `pow`：同样通过 `stdmath_shim.cj` 的 `powT` 包装函数实现（`(std.math.pow(Float64(base), Float64(exp)) as T).getOrThrow()`），Float16/Float32/Float64 三种浮点类型经同一双向转型路径处理，无需特殊回退分支
- `inversesqrt` 实现为 `T(1) / sqrt(x)`，非直接委托。当 `x == 0` 时，`sqrt(0) = 0` 导致 `T(1) / 0`，仓颉浮点类型遵循 IEEE 754 标准，`T(1) / T(0)` 自然返回 `+Inf`（已验证，见 H4）。此行为与 GLM 1.0.3 一致（GLM 文档声明输入范围为 `[0, +inf)`，零值返回 Inf 是 IEEE 754 自然结果而非显式保护）

**协作关系**：被 trigonometric.cj（无直接依赖，均为独立浮点函数）和 gtc 函数引用。

#### trigonometric.cj

**角色**：提供 GLSL 8.1 节定义的角度与三角函数。

**职责**：
- 替换阶段三的 stub 为完整实现
- 包含：`radians/degrees/sin/cos/tan/asin/acos/atan/atan2/sinh/cosh/tanh/asinh/acosh/atanh`
- 约束策略：全部使用 `T <: FloatingPoint<T>`
- 实现路径：
  - `sin/cos/tan/atan/atan2/sinh/cosh/tanh/asinh/acosh/atanh`：通过 `stdmath_shim.cj` 的包装函数委托 `std.math`（Float64 转型模式）
  - `acos`/`asin`：**需加越界保护**。仓颉 `std.math.acos`/`std.math.asin` 在输入超出 [-1, 1] 时抛出 `IllegalArgumentException`（而非返回 NaN），此行为与 GLM 1.0.3 不符。实现方案：在 `glm.detail.acos`/`glm.detail.asin` 内部增加 `if (x < -T(1) || x > T(1)) { return T.getNaN() }` 前置检查，仅对合法输入通过 `stdmath_shim.cj` 包装层委托 `std.math`。此保护确保 acos/asin 在越界时返回 NaN，与 GLM 1.0.3（委托 std::acos/std::asin 的 NaN 返回行为）一致。此保护是 acos/asin 函数自身实现契约的一部分（非调用方责任），与 slerp 中调用方对 dot 结果做 clamp 的数值稳定措施属于不同职责层面
- `radians(x)` 实现为 `x * pi<T>() / T(180)`，`degrees(x)` 实现为 `x * T(180) / pi<T>()`
- 标量版本 + Vec1~Vec4 逐分量版本，每类 5 个重载

**协作关系**：被 ext/quaternion_transform.cj（rotate 的 sin/cos）、ext/quaternion_common.cj（slerp 的 acos/sin）和 gtc/matrix_transform.cj（perspective 的 cot）调用。geometric.cj 的 normalize 函数通过 stdmath_shim.cj 包装层调用 sqrt，而非 trigonometric.cj。

#### geometric.cj

**角色**：提供 GLSL 8.5 节定义的几何函数。

**职责**：
- 替换阶段三的 stub 为完整实现
- 包含：`dot/cross/normalize/length/distance/reflect/refract/faceforward`
- `dot`：Vec1~Vec4 各版本，返回标量 T
- `cross`：仅 Vec3 版本，返回 Vec3<T, Q>
- `normalize`：Vec1~Vec4 版本
- `length/distance/reflect/refract/faceforward`：Vec2~Vec4 版本
- **Vec1 normalize 的零值行为**：Vec1 的 normalize 使用通式 `v * inversesqrt(dot(v, v))`，标量计算不设置保护分支。当输入为零时，`dot(v, v) = T(0)`，`inversesqrt(T(0)) = +Inf`（见上），`T(0) * +Inf = NaN`。此行为依赖 IEEE 754 的 NaN 传播规则（已验证，见 H4），与 GLM 1.0.3 的 `compute_normalize` 实现一致
- **Vec2~Vec4 normalize 的零值行为**：对于 Vec2 及以上维度，设置保护分支：当 `lengthSq <= T(0)` 时直接返回零向量，跳过除法。此保护采用 `<=` 而非严格 `==`，理由：IEEE 754 中 `-0.0 == +0.0` 为 true，两者在零值输入下行为一致；`<=` 更清晰地传达"保护非正长度"的防御性编程语义意图。此保护与 §5 错误表一致
- 约束策略：使用 `T <: FloatingPoint<T>`（需要 sqrt），但 `dot` 放宽为 `T <: Number<T>`
- `length` 实现为 `sqrt(dot(v, v))`
- `normalize`（Vec2~Vec4）实现为 `v / length(v)`，零向量保护返回零向量
- `distance` 实现为 `length(p0 - p1)`
- `reflect` 实现为 `I - T(2) * dot(N, I) * N`
- `refract` 实现为使用 `eta` 和 `k = T(1) - eta*eta * (T(1) - dot(N,I)*dot(N,I))` 的条件公式
- `faceforward` 实现为条件选择：`dot(Nref, I) < 0 ? N : -N`

**协作关系**：被 ext/quaternion_geometric.cj 的 cross/length/normalize（实际调用几何库而非独立实现，消除阶段三的重复设计）、ext/quaternion_common.cj 的 slerp、gtc/matrix_transform.cj 的 lookAt 调用。normalize/length 内部通过 `stdmath_shim.cj` 包装层调用 `std.math.sqrt`，非反向依赖 `trigonometric.cj`。

#### matrix.cj（determinant/inverse）

**角色**：提供方阵的行列式和逆矩阵计算的完整实现。

**职责**：
- 替换阶段二的 stub 为完整实现
- `determinant`：Mat2x2/Mat3x3/Mat4x4，各返回 `T`
  - Mat2x2：`m[0][0]*m[1][1] - m[1][0]*m[0][1]`
  - Mat3x3：标量三重积展开
  - Mat4x4：拉普拉斯展开（或分块矩阵求行列式）
- `inverse`：Mat2x2/Mat3x3/Mat4x4，各返回同尺寸矩阵
  - Mat2x2：`1/det * [[a22, -a12], [-a21, a11]]` 公式
  - Mat3x3：余子式矩阵 ÷ 行列式
  - Mat4x4：余子式展开（cofactor expansion），与 GLM 1.0.3 实现一致（见 `func_matrix.inl` 第 388~446 行 `compute_inverse<4,4,T,Q,Aligned>`）
- 约束：`T <: Number<T>`（算术运算） + `where T <: FloatingPoint<T>` 的 inverse（需要除法），或通过 `T <: Number<T>` 下的 `one/T(Float64(n))` 路径
- 奇异矩阵行为：奇异矩阵求逆的结果由 IEEE 754 浮点运算自然决定。当行列式 det=0 时，1/det → Inf，Inf × 余子式中的零分量产生 Inf × 0 = NaN，经 IEEE 754 NaN 传播最终产生 NaN 填充矩阵。此行为与 GLM 1.0.3 的余子式展开实现一致。函数不抛出异常，调用方需自行通过行列式检查矩阵的奇异性

#### detail/vector_relational.cj

**角色**：提供 GLSL 8.7 节定义的逐分量比较函数（对标 GLM 1.0.3 `vector_relational.hpp` 完整函数集）。

**职责**：
- 阶段三已实现的 4 个函数：`lessThan`、`greaterThan`、`lessThanEqual`、`greaterThanEqual`（沿用阶段三）
- 本阶段补全的 5 个函数：
  - `equal(a, b)`：逐分量相等比较，返回 Bool 向量
  - `notEqual(a, b)`：逐分量不等比较，返回 Bool 向量
  - `any(v)`：向量任一分量为 true 则返回 true（仅当 v 为 Bool 向量时定义）
  - `all(v)`：向量所有分量为 true 才返回 true（仅当 v 为 Bool 向量时定义）
  - `not_(v)`：逐分量逻辑取反（GLM 中为 `not_`，避免与 `!` 运算符命名冲突；仓颉函数名采用 `not_`）
- 约束策略：
  - `equal`/`notEqual`：`T <: Equatable<T>`，支持任意可比较类型
  - `any`/`all`/`not_`：`v: Vec<L, Bool, Q>`，仅对 Bool 向量定义
- 实现路径：`equal`/`notEqual` 内部调用各分量 `==`/`!=` 运算符构造 Bool 向量；`any`/`all` 通过短路逻辑（`||`/`&&`）逐分量判断；`not_` 逐分量应用 `!` 运算符

**为什么本阶段补全**：阶段三 OOD 设计遗漏——阶段三的 `detail/vector_relational.cj` 仅列出了 4 个比较函数（lessThan/greaterThan/lessThanEqual/greaterThanEqual），未包含 GLM 1.0.3 中同样属于 `vector_relational.hpp` 的 `equal`/`notEqual`/`any`/`all`/`not_`。阶段四继承阶段三设计时未补全此遗漏。本阶段（阶段四）发现后正式补全 5 个函数。

### 3.2 ext 扩展函数库（glm.ext）

#### ext/scalar_common.cj

**角色**：对标 GLM 1.0.3 `ext/scalar_common.hpp`，提供标量公共扩展函数集（与 core common.cj 互补）。

**职责**：对标 GLM 1.0.3 `ext/scalar_common.hpp` 的全部 17 个函数（不含 GLM 仅基于 C++11 `std::fmin`/`std::fmax` 的 `using` 声明），按分组列出函数签名映射：

```
// 3/4 输入标量 min/max
func min<T>(a: T, b: T, c: T): T where T <: Number<T> & Comparable<T>
func min<T>(a: T, b: T, c: T, d: T): T where T <: Number<T> & Comparable<T>
func max<T>(a: T, b: T, c: T): T where T <: Number<T> & Comparable<T>
func max<T>(a: T, b: T, c: T, d: T): T where T <: Number<T> & Comparable<T>

// NaN 安全 min（isnan 前置判断，委托 core common.cj 的 2 输入 min）
func fmin<T>(a: T, b: T): T where T <: FloatingPoint<T>
func fmin<T>(a: T, b: T, c: T): T where T <: FloatingPoint<T>
func fmin<T>(a: T, b: T, c: T, d: T): T where T <: FloatingPoint<T>

// NaN 安全 max（isnan 前置判断，委托 core common.cj 的 2 输入 max）
func fmax<T>(a: T, b: T): T where T <: FloatingPoint<T>
func fmax<T>(a: T, b: T, c: T): T where T <: FloatingPoint<T>
func fmax<T>(a: T, b: T, c: T, d: T): T where T <: FloatingPoint<T>

// NaN 安全 clamp：fclamp(x, minVal, maxVal) = fmin(fmax(x, minVal), maxVal)
func fclamp<T>(x: T, minVal: T, maxVal: T): T where T <: FloatingPoint<T>

// 纹理环绕模式模拟
func clamp<T>(Texcoord: T): T where T <: FloatingPoint<T>              // clamp(Texcoord, 0, 1)
func repeat<T>(Texcoord: T): T where T <: FloatingPoint<T>             // fract(Texcoord)
func mirrorClamp<T>(Texcoord: T): T where T <: FloatingPoint<T>        // fract(abs(Texcoord))
func mirrorRepeat<T>(Texcoord: T): T where T <: FloatingPoint<T>        // 分片纹理循环：Abs = abs(Texcoord) → Floor = floor(Abs) → Clamp = mod(Floor, T(2)) → Rest = Abs - Floor → Mirror = Clamp + Rest → mix(Rest, T(1) - Rest, Mirror >= T(1))。GLM 1.0.3 源码参考：`ext/scalar_common.inl` 第 78~86 行

// 浮点→整数舍入（委托 std.math.roundT 经 stdmath_shim.cj 实现，与 GLM 的 int(round(x)) 语义一致，支持负输入）
func iround<T>(x: T): Int64 where T <: FloatingPoint<T>
func uround<T>(x: T): UInt64 where T <: FloatingPoint<T>
```

- **uround 负数输入行为声明**：仓颉默认溢出策略为 `@OverflowThrowing`，`UInt64(negative_float)` 在值为负数时抛出 `ArithmeticException`。本设计选择接受此默认行为（抛出异常），而非模拟 GLM C++ 的模运算回绕。理由：负数传入 `uround` 属于语义错误（uround 设计语义为无符号整数舍入，负数输入无合理含义），异常抛出有助于尽早捕获此类错误。调用方应在调用 `uround` 前通过 `iround` 或条件判断确保输入非负。此行为差异在编码阶段文档中明确标注
- 约束策略：3/4 输入 `min`/`max` 使用 `Number<T> & Comparable<T>`（整数和浮点均可用）；`fmin`/`fmax`/`fclamp` 及纹理环绕函数使用 `FloatingPoint<T>`（NaN 判断需要浮点）；`iround`/`uround` 使用 `FloatingPoint<T>` 约束，返回具体整数类型
- 实现路径：3/4 输入 `min`/`max` 委托 core common.cj 的 2 输入 `min`/`max` 层叠调用；`fmin` 系列实现为 `if isnan(a) return b` 后委托 `min`；`fclamp` 实现为 `fmin(fmax(x, minVal), maxVal)`；纹理环绕函数直接使用 core common.cj 的 `clamp`/`fract`/`abs`/`mod`/`floor`/`mix`；`iround`/`uround` 实现为 `Int64(stdmath_shim.roundT(x))`/`UInt64(stdmath_shim.roundT(x))`，委托 stdmath_shim.cj 的 roundT 包装函数（内部经 `(x as Float64).getOrThrow() → std.math.round → (result as T).getOrThrow()` 模式），消除原公式 `Int64(x + T(0.5))` 在负数输入时的语义偏差，与 GLM `int(round(x))` 行为一致
- 与 GLM 1.0.3 的差异声明：本设计将 `iround`/`uround` 的返回类型统一为 `Int64`/`UInt64`（仓颉中 Int/uint 为 64 位），而非 GLM C++ 的 `int`/`uint`（32 位）。调用方若需 32 位结果需显式转型
- **不包含的函数**：GLM 1.0.3 的 `ext/scalar_common.hpp` 中**不包含** `mix`、`step`、`smoothstep` 的额外重载形式（这些函数属于 core `common.cj` 范围，已在 §3.1 完整覆盖）

#### ext/vector_common.cj

**角色**：对标 GLM 1.0.3 `ext/vector_common.hpp`，提供向量级别的公共扩展函数集（与 core common.cj 的逐分量向量函数互补）。

**职责**：对标 GLM 1.0.3 `ext/vector_common.hpp` 的全部 20 个函数，按分组列出函数签名映射。

**符号约定**：下文函数签名中的 `Vec<L, T, Q>` 是设计级速记记号，表示"对 Vec1~Vec4 各定义一个同构重载"。例如 `min` 的 4 个输入重载展开为：

```cangjie
func min<T, Q>(a: Vec1<T,Q>, b: Vec1<T,Q>, c: Vec1<T,Q>, d: Vec1<T,Q>): Vec1<T,Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier
func min<T, Q>(a: Vec2<T,Q>, b: Vec2<T,Q>, c: Vec2<T,Q>, d: Vec2<T,Q>): Vec2<T,Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier
func min<T, Q>(a: Vec3<T,Q>, b: Vec3<T,Q>, c: Vec3<T,Q>, d: Vec3<T,Q>): Vec3<T,Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier
func min<T, Q>(a: Vec4<T,Q>, b: Vec4<T,Q>, c: Vec4<T,Q>, d: Vec4<T,Q>): Vec4<T,Q> where T <: Number<T> & Comparable<T>, Q <: Qualifier
```

此约定与 §3.1 core 函数库的"为 Vec1~Vec4 各定义"文字表述等价，不涉及仓颉不支持的整数维度泛型参数。不包含 Vec1 版本的函数（如多数几何运算仅作用于 Vec2+）在展开时对应省略 Vec1 重载。

以下各函数签名中的 L 维度参数均遵循此展开约定：

```
// 3/4 输入向量逐分量 min/max
func min<L, T, Q>(a, b, c: Vec<L, T, Q>): Vec<L, T, Q> where T <: Number<T> & Comparable<T>
func min<L, T, Q>(a, b, c, d: Vec<L, T, Q>): Vec<L, T, Q> where T <: Number<T> & Comparable<T>
func max<L, T, Q>(a, b, c: Vec<L, T, Q>): Vec<L, T, Q> where T <: Number<T> & Comparable<T>
func max<L, T, Q>(a, b, c, d: Vec<L, T, Q>): Vec<L, T, Q> where T <: Number<T> & Comparable<T>

// NaN 安全向量 min 系列
func fmin<L, T, Q>(a: Vec<L, T, Q>, b: T): Vec<L, T, Q> where T <: FloatingPoint<T>         // 标量扩展为向量
func fmin<L, T, Q>(a: Vec<L, T, Q>, b: Vec<L, T, Q>): Vec<L, T, Q> where T <: FloatingPoint<T>
func fmin<L, T, Q>(a, b, c: Vec<L, T, Q>): Vec<L, T, Q> where T <: FloatingPoint<T>
func fmin<L, T, Q>(a, b, c, d: Vec<L, T, Q>): Vec<L, T, Q> where T <: FloatingPoint<T>

// NaN 安全向量 max 系列
func fmax<L, T, Q>(a: Vec<L, T, Q>, b: T): Vec<L, T, Q> where T <: FloatingPoint<T>         // 标量扩展为向量
func fmax<L, T, Q>(a: Vec<L, T, Q>, b: Vec<L, T, Q>): Vec<L, T, Q> where T <: FloatingPoint<T>
func fmax<L, T, Q>(a, b, c: Vec<L, T, Q>): Vec<L, T, Q> where T <: FloatingPoint<T>
func fmax<L, T, Q>(a, b, c, d: Vec<L, T, Q>): Vec<L, T, Q> where T <: FloatingPoint<T>

// NaN 安全向量 clamp（标量边界版 / 向量边界版）
func fclamp<L, T, Q>(x: Vec<L, T, Q>, minVal: T, maxVal: T): Vec<L, T, Q> where T <: FloatingPoint<T>
func fclamp<L, T, Q>(x, minVal, maxVal: Vec<L, T, Q>): Vec<L, T, Q> where T <: FloatingPoint<T>

// 纹理环绕模式（向量版本）
func clamp<L, T, Q>(Texcoord: Vec<L, T, Q>): Vec<L, T, Q> where T <: FloatingPoint<T>
func repeat<L, T, Q>(Texcoord: Vec<L, T, Q>): Vec<L, T, Q> where T <: FloatingPoint<T>
func mirrorClamp<L, T, Q>(Texcoord: Vec<L, T, Q>): Vec<L, T, Q> where T <: FloatingPoint<T>
func mirrorRepeat<L, T, Q>(Texcoord: Vec<L, T, Q>): Vec<L, T, Q> where T <: FloatingPoint<T>

// 浮点向量→整数向量舍入
func iround<L, T, Q>(x: Vec<L, T, Q>): Vec<L, Int64, Q> where T <: FloatingPoint<T>
func uround<L, T, Q>(x: Vec<L, T, Q>): Vec<L, UInt64, Q> where T <: FloatingPoint<T>
```

- 约束策略：3/4 输入 `min`/`max` 使用 `Number<T> & Comparable<T>`；`fmin`/`fmax`/`fclamp` 及纹理环绕函数使用 `FloatingPoint<T>`；`iround`/`uround` 使用 `FloatingPoint<T>` 并返回 `Vec<L, Int64, Q>`/`Vec<L, UInt64, Q>`（仓颉 Int64 对应 GLM C++ int，UInt64 对应 uint）。与 ext/scalar_common.cj 标量版的 `iround`/`uround` 返回标量 `Int64`/`UInt64` 不同，此处返回整数向量
- 实现路径：3/4 输入向量 `min`/`max` 逐分量委托 ext/scalar_common.cj 对应标量函数；`fmin`/`fmax` 系列逐分量做 NaN 判断后委托 `min`/`max`；`fclamp` 实现为 `fmin(fmax(...))`；纹理环绕函数逐分量应用 ext/scalar_common.cj 对应标量函数；`iround`/`uround` 逐分量应用 scalar_common 对应函数
- **与 ext/scalar_common.cj 的协作**：vector_common.cj 函数本质上是 scalar_common 标量函数在向量上的逐分量映射。编码阶段可为每个向量函数提供直接逐分量实现（内联标量逻辑避免函数调用开销），或通过 scalar_common 函数实现代码复用（期望编译器内联优化消解额外调用）。具体方案由编码阶段决定，设计阶段不做约束

#### ext/matrix_transform.cj

**角色**：矩阵变换扩展函数（替代阶段三的 stub）。

**职责**：
- 替换 stub 为完整实现，对标 GLM 1.0.3 `ext/matrix_transform.hpp`（第 37~169 行）的全部 6 个函数：
  - `identity()`：返回恒等矩阵，约束 `genType <: mat`，`T <: FloatingPoint<T>`
  - `translate(m, v)`：平移变换矩阵 `[I, p; 0, 1]` 左乘 m，返回 `Mat4x4<T, Q>`，约束 `T <: FloatingPoint<T>, Q <: Qualifier`
  - `rotate(m, angle, axis)`：旋转变换矩阵（依赖 trigonometric.cj 的 sin/cos 和 geometric.cj 的 cross/normalize），返回 `Mat4x4<T, Q>`
  - `scale(m, v)`：缩放变换矩阵，返回 `Mat4x4<T, Q>`
  - `shear<T, Q>(m: Mat4x4<T, Q>, p: Vec3<T, Q>, l_x: Vec2<T, Q>, l_y: Vec2<T, Q>, l_z: Vec2<T, Q>): Mat4x4<T, Q>`：剪切变换矩阵，约束 `T <: FloatingPoint<T>, Q <: Qualifier`
  - `lookAt(eye, center, up)` / `lookAtRH` / `lookAtLH`：视图矩阵构造，返回 `Mat4x4<T, Q>`
- 约束：全部使用 `T <: FloatingPoint<T>`，返回 `Mat4x4<T, Q>`

**协作关系**：依赖 glm.detail（Mat4x4, Vec3, Vec4 + common/geometric/trigonometric）。被 gtc/matrix_transform.cj 调用。

#### ext/matrix_projection.cj

**角色**：投影矩阵扩展函数（替代阶段三的 stub）。

**职责**：
- 替换 stub 为完整实现，对标 GLM 1.0.3 `ext/matrix_projection.hpp`（第 49~144 行）的全部 7 个函数：
  - project 与 unProject 函数使用独立类型参数 `U <: Number<U>` 约束 viewport 参数（viewport 为像素坐标，可为整数或浮点类型），与 obj/proj/model 的 `T <: FloatingPoint<T>` 解耦
  - 完整函数签名如下：
```
// project 系族（对象坐标 → 窗口坐标，Z 范围依赖于命名后缀）
func projectZO<T, U, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<U, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, U <: Number<U>, Q <: Qualifier
func projectNO<T, U, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<U, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, U <: Number<U>, Q <: Qualifier
func project<T, U, Q>(obj: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<U, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, U <: Number<U>, Q <: Qualifier

// unProject 系族（窗口坐标 → 对象坐标）
func unProjectZO<T, U, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<U, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, U <: Number<U>, Q <: Qualifier
func unProjectNO<T, U, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<U, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, U <: Number<U>, Q <: Qualifier
func unProject<T, U, Q>(win: Vec3<T, Q>, model: Mat4x4<T, Q>, proj: Mat4x4<T, Q>, viewport: Vec4<U, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, U <: Number<U>, Q <: Qualifier

// 拾取矩阵
func pickMatrix<T, U, Q>(center: Vec2<T, Q>, delta: Vec2<T, Q>, viewport: Vec4<U, Q>): Mat4x4<T, Q> where T <: FloatingPoint<T>, U <: Number<U>, Q <: Qualifier
```
- 实现路径：project 函数将 obj 通过 model×proj 变换到裁剪空间后，按 viewport 参数映射到窗口坐标（透视除法 → 归一化设备坐标 → 视口变换）。unProject 为逆过程（视口逆变换 → 逆投影）。pickMatrix 构造拾取区域矩阵（缩放+平移变换）

#### ext/matrix_clip_space.cj

**角色**：裁剪空间矩阵扩展函数（替代阶段三的 stub）。

**职责**：
- 替换 stub 为完整实现，对标 GLM 1.0.3 `ext/matrix_clip_space.hpp`（第 42~572 行）的全部 46 个函数：
  - **ortho 系族（10 个）**（典例）：
    `func ortho<T, Q>(left: T, right: T, bottom: T, top: T): Mat4x4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier`
    `func ortho<T, Q>(left: T, right: T, bottom: T, top: T, zNear: T, zFar: T): Mat4x4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier`
    变体差异：`LH/RH` 控制左手/右手系，`ZO/NO` 控制 Z 范围（[0,1] 或 [-1,1]）
  - **frustum 系族（9 个）**（典例）：
    `func frustum<T, Q>(left: T, right: T, bottom: T, top: T, near: T, far: T): Mat4x4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier`
    变体差异同 ortho
  - **perspective 系族（9 个）**（典例）：
    `func perspective<T, Q>(fovy: T, aspect: T, zNear: T, zFar: T): Mat4x4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier`
    变体差异同 ortho
  - **perspectiveFov 系族（9 个）**（典例）：
    `func perspectiveFov<T, Q>(fovy: T, width: T, height: T, zNear: T, zFar: T): Mat4x4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier`
    变体差异同 ortho
  - **infinitePerspective 系族（7 个）**（典例）：
    `func infinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier`
    变体差异同 ortho
  - **tweakedInfinitePerspective（2 个）**（典例）：
    `func tweakedInfinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T): Mat4x4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier`
    `func tweakedInfinitePerspective<T, Q>(fovy: T, aspect: T, zNear: T, ep: T): Mat4x4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier`
- 约束：全部使用 `T <: FloatingPoint<T>`，返回 `Mat4x4<T, defaultp>`

#### ext/quaternion_common.cj（mix/slerp 补齐）

**角色**：补齐阶段三中因依赖 geometric/trigonometric stub 而未能实现的函数。

**职责**：
- `mix(x, y, a)`：实现为 `x * (T(1) - a) + y * a`（四元数线性混合），但需注意阶段三的 mix 已存在但为 stub——本阶段直接使用 GLM 1.0.3 的四元数 mix 公式。需使用 `T(Float64(1)) - a` 避免 T(1) 构造问题。此函数使用 common.cj 的 clamp 将 a 截断至 [0,1] 后执行插值（见 D10），与阶段三 lerp 的 assert 策略不同。
- `slerp(x, y, a)`：实现为球面线性插值。公式使用 `cosOmega = clamp(dot(x, y), -T(1), T(1))` 后通过 `acos(cosOmega)`（依赖 trigonometric.cj acos）获取角度，`sinOmega = sin(omega)`（依赖 trigonometric.cj sin），再构造 `(sin((T(1)-a)*omega) / sinOmega) * x + (sin(a*omega) / sinOmega) * y`。退化判定条件：当 `sinOmega < epsilon<T>()` 时退化为 lerp（使用 `epsilon<T>()` 返回 T 类型的机器 epsilon，避免 sinOmega 接近零时分母放大数值误差）。
  - 注：slerp 中 clamp dot 到 [-1,1] 是数值稳定性措施（浮点误差可能导致 dot 略微越界），不影响 §5 中"acos 函数自身不做 clamp"的策略
- `slerp<T, Q>(x: Quat<T, Q>, y: Quat<T, Q>, a: T, k: T): Quat<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier`：扩展球面插值（额外参数 k 控制插值曲线的形状/扭曲），实现参考 GLM 1.0.3 源码。
- 约束：`T <: FloatingPoint<T>, Q <: Qualifier`

**协作关系**：依赖 trigonometric.cj（acos, sin, cos）和 common.cj（clamp）。

#### ext/quaternion_transform.cj（rotate 补齐）

**角色**：补齐阶段三中因依赖 trigonometric stub 而未能实现的 rotate 函数。

**职责**：
- `rotate(q, angle, axis)`：绕轴旋转四元数。首先对 axis 做 normalize 得到单位轴向量（依赖 geometric.cj length 做归一化检查：若 `length(axis) == T(0)` 则返回单位四元数 `Quat(T(1), T(0), T(0), T(0))`），然后构造 `halfAngle = angle / T(2)`，计算 `sinHalf = sin(halfAngle)`（依赖 trigonometric.cj sin），`cosHalf = cos(halfAngle)`（依赖 trigonometric.cj cos），返回四元数 `(sinHalf * normalizedAxis.x, sinHalf * normalizedAxis.y, sinHalf * normalizedAxis.z, cosHalf) * q`（实际内部实现为单位四元数 + 旋转四元数乘法）。
- 约束：`T <: FloatingPoint<T>, Q <: Qualifier`

#### ext/quaternion_trigonometric.cj（angle/angleAxis 补齐）

**角色**：补齐阶段三中因依赖 trigonometric stub 而未能实现的 angle 和 angleAxis 函数。

**职责**：
- `angle(x)`：返回四元数 x 的旋转角度，实现为 `T(2) * acos(clamp(x.w, T(-1), T(1)))`（依赖 trigonometric.cj acos）。clamp 保护确保 acos 输入在 [-1,1] 范围内（浮点归一化误差可能导致 w 略微越界）
- `angleAxis(angle, axis)`：从角度和轴向量构造旋转四元数，实现为 `halfAngle = angle / T(2)`，构造 Quat(cos(halfAngle), sin(halfAngle) * axis.x, sin(halfAngle) * axis.y, sin(halfAngle) * axis.z)（依赖 trigonometric.cj sin/cos）
- 约束：`T <: FloatingPoint<T>, Q <: Qualifier`

**协作关系**：依赖 trigonometric.cj（acos, sin, cos）。axis 函数已在阶段三完整实现，不依赖本阶段变更。

### 3.3 gtc 扩展函数库（glm.gtc）

#### gtc/matrix_transform.cj

**角色**：提供完整的 GLM `gtc/matrix_transform.hpp` 函数族，替代阶段三的 stub。

**职责**：
- 替换阶段三的 64 个 stub 函数签名为完整实现
- 依赖 ext/matrix_transform.cj、ext/matrix_projection.cj、ext/matrix_clip_space.cj、geometric.cj、trigonometric.cj、matrix.cj 全部就绪
- 函数族包含（全部 64 个函数）：
  - 基础变换（11 个）：`identity`、`translate`、`rotate`、`rotate_slow`、`scale`、`scale_slow`、`shear`、`shear_slow`、`lookAt`、`lookAtRH`、`lookAtLH`
  - ortho 系族（10 个）：`ortho`（2D）、`orthoLH_ZO`、`orthoLH_NO`、`orthoRH_ZO`、`orthoRH_NO`、`orthoZO`、`orthoNO`、`orthoLH`、`orthoRH`、`ortho`（6参数默认）
  - frustum 系族（9 个）：`frustumLH_ZO`、`frustumLH_NO`、`frustumRH_ZO`、`frustumRH_NO`、`frustumZO`、`frustumNO`、`frustumLH`、`frustumRH`、`frustum`
  - perspective 系族（9 个）：`perspectiveRH_ZO`、`perspectiveRH_NO`、`perspectiveLH_ZO`、`perspectiveLH_NO`、`perspectiveZO`、`perspectiveNO`、`perspectiveRH`、`perspectiveLH`、`perspective`
  - perspectiveFov 系族（9 个）：`perspectiveFovRH_ZO`、`perspectiveFovRH_NO`、`perspectiveFovLH_ZO`、`perspectiveFovLH_NO`、`perspectiveFovZO`、`perspectiveFovNO`、`perspectiveFovRH`、`perspectiveFovLH`、`perspectiveFov`
  - infinitePerspective 系族（7 个）：`infinitePerspectiveLH_ZO`、`infinitePerspectiveLH_NO`、`infinitePerspectiveRH_ZO`、`infinitePerspectiveRH_NO`、`infinitePerspectiveLH`、`infinitePerspectiveRH`、`infinitePerspective`
  - tweakedInfinitePerspective 系族（2 个）：`tweakedInfinitePerspective(fovy,aspect,near)`、`tweakedInfinitePerspective(fovy,aspect,near,ep)`
  - 投影工具（6 个）：`projectZO`、`projectNO`、`project`、`unProjectZO`、`unProjectNO`、`unProject`
  - 拾取矩阵（1 个）：`pickMatrix`
- **_slow 变体签名与说明**：
  - `func rotate_slow<T, Q>(m: Mat4x4<T, Q>, angle: T, axis: Vec3<T, Q>): Mat4x4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier`：与 `rotate` 功能相同（绕轴旋转），但使用数值更稳定的三角学实现路径（避免 sin/cos 快速逼近近似）。GLM 1.0.3 中通过带 `slow` 标志的辅助函数实现四元数→矩阵的转换
  - `func scale_slow<T, Q>(m: Mat4x4<T, Q>, v: Vec3<T, Q>): Mat4x4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier`：与 `scale` 功能相同，实现路径通过逐分量构造对角缩放矩阵后左乘 `m`，而非标准版本的矩阵乘法优化路径
  - `func shear_slow<T, Q>(m: Mat4x4<T, Q>, p: Vec3<T, Q>, l_x: Vec2<T, Q>, l_y: Vec2<T, Q>, l_z: Vec2<T, Q>): Mat4x4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier`：与 `shear` 功能相同，实现路径从 `Vec2` 参数提取分量构造剪切矩阵，而非 `shear` 的几何公式路径
  - 这三个 `_slow` 函数在 ext 层不存在对应实现，需在 gtc 层独立实现（不遵循"gtc 委托 ext"的模式）
- **GTC 与 EXT 的委托关系**：GLM 1.0.3 的 `gtc/matrix_transform.hpp` 是纯聚合头文件（仅 `#include` ext 层的三个头文件：`ext/matrix_transform.hpp`、`ext/matrix_projection.hpp`、`ext/matrix_clip_space.hpp`，另有一空 `.inl`）。gtc 层本身不定义独立函数，大部分委托给 ext 层（除 `rotate_slow`/`scale_slow`/`shear_slow` 三个 _slow 变体需在 gtc 层独立实现外）。仓颉实现中，`gtc/matrix_transform.cj` 同样应为委托层角色——通过 `public import` 从 ext 层重新导出函数签名，或直接编写转发函数。此决策使 gtc 层作为稳定公共 API 面（用户入口）与 ext 层作为实现细节分离：编码阶段可独立演进 ext 层实现而不影响 gtc 层的 API 契约
- 每个函数内部的数学公式与 GLM 1.0.3 实现一致，使用 Mat4x4 列主序存储

**为什么不是 core 而是 gtc**：GLM 1.0.3 中 `matrix_transform.hpp` 位于 `gtc/` 子目录，属于"稳定但非 core"的扩展函数库。保持此归属确保与 GLM 的文件组织一致。

#### gtc/matrix_inverse.cj

**角色**：矩阵逆辅助函数。

**职责**：
- `affineInverse(m)`：仿射逆矩阵，仅适用于 Mat4x4（前提：最后一行固定为 [0,0,0,1]），计算上三角 3x3 的逆并处理平移分量，返回 Mat4x4<T, Q>
- `inverseTranspose(m)`：逆转置矩阵 `transpose(inverse(m))`，适用于 Mat3x3 和 Mat4x4（法线变换计算的常见场景），返回与输入同尺寸的矩阵
- 约束：`T <: FloatingPoint<T>`（需要除法求逆）

#### gtc/matrix_access.cj

**角色**：行/列访问函数。

**职责**：
- `row(m, index)`：返回矩阵的第 index 行（不是数据成员存储的列！需从各列索引 index 分量构造行向量）
- `column(m, index)`：返回矩阵的第 index 列（等价于 `m[index]` 下标运算符取值版本）
- 对所有 9 个矩阵类型提供重载。典例如下（其余 6 个矩阵类型按相同模式——行向量维度对应矩阵列数、列向量维度对应矩阵行数）：

  ```cangjie
  // 典例签名：Mat2x2 → row 返回 Vec2, column 返回 Vec2
  func row<T, Q>(m: Mat2x2<T, Q>, index: Int64): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
  func column<T, Q>(m: Mat2x2<T, Q>, index: Int64): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier

  // 典例签名：Mat3x3
  func row<T, Q>(m: Mat3x3<T, Q>, index: Int64): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
  func column<T, Q>(m: Mat3x3<T, Q>, index: Int64): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier

  // 典例签名：Mat4x4
  func row<T, Q>(m: Mat4x4<T, Q>, index: Int64): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
  func column<T, Q>(m: Mat4x4<T, Q>, index: Int64): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
  ```
  对于非方阵（如 Mat2x3/Mat3x2/Mat2x4/Mat4x2/Mat3x4/Mat4x3），返回类型为对应维度的向量（GLM 1.0.3 模式）：`row` 返回的向量维度等于矩阵列数，`column` 返回的向量维度等于矩阵行数。

#### gtc/packing.cj

**角色**：浮点数据打包/解包函数。

**职责**：
对标 GLM 1.0.3 `gtc/packing.hpp` 的全部函数。函数签名如下（仓颉映射签名）：

```
// packUnorm 系族（归一化无符号整数打包）
func packUnorm1x8(v: Float32): UInt8                          // round(clamp(v, 0, 1) * 255.0)
func packUnorm2x8(v: Vec2<Float32, Q>): UInt16                // 两分量打包
func packUnorm4x8(v: Vec4<Float32, Q>): UInt32                // 四分量打包
func packUnorm1x16(v: Float32): UInt16                        // round(clamp(v, 0, 1) * 65535.0)
func packUnorm2x16(v: Vec2<Float32, Q>): UInt32               // 两分量打包
func packUnorm4x16(v: Vec4<Float32, Q>): UInt64               // 四分量打包

// unpackUnorm 系族（解包为归一化浮点值）
func unpackUnorm1x8(p: UInt8): Float32                        // p / 255.0
func unpackUnorm2x8(p: UInt16): Vec2<Float32, Q>              // 解包为两分量向量
func unpackUnorm4x8(p: UInt32): Vec4<Float32, Q>              // 解包为四分量向量
func unpackUnorm1x16(p: UInt16): Float32                      // p / 65535.0
func unpackUnorm2x16(p: UInt32): Vec2<Float32, Q>             // 解包为两分量向量
func unpackUnorm4x16(p: UInt64): Vec4<Float32, Q>             // 解包为四分量向量

// packSnorm 系族（归一化有符号整数打包）
func packSnorm1x8(v: Float32): UInt8                           // round(clamp(v, -1, 1) * 127.0)
func packSnorm2x8(v: Vec2<Float32, Q>): UInt16
func packSnorm4x8(v: Vec4<Float32, Q>): UInt32
func packSnorm1x16(v: Float32): UInt16                         // round(clamp(v, -1, 1) * 32767.0)
func packSnorm2x16(v: Vec2<Float32, Q>): UInt32
func packSnorm4x16(v: Vec4<Float32, Q>): UInt64

// unpackSnorm 系族
func unpackSnorm1x8(p: UInt8): Float32                         // clamp(p / 127.0, -1, 1)
func unpackSnorm2x8(p: UInt16): Vec2<Float32, Q>
func unpackSnorm4x8(p: UInt32): Vec4<Float32, Q>
func unpackSnorm1x16(p: UInt16): Float32                       // clamp(p / 32767.0, -1, 1)
func unpackSnorm2x16(p: UInt32): Vec2<Float32, Q>
func unpackSnorm4x16(p: UInt64): Vec4<Float32, Q>

// packHalf 系族（Float32 ↔ Float16 位模式打包）
func packHalf1x16(v: Float32): UInt16                          // Float32 → Float16 位模式
func packHalf2x16(v: Vec2<Float32, Q>): UInt32                 // 两分量 Float16 打包
func packHalf4x16(v: Vec4<Float32, Q>): UInt64                 // 四分量 Float16 打包

// unpackHalf 系族
func unpackHalf1x16(p: UInt16): Float32                        // Float16 位模式 → Float32
func unpackHalf2x16(p: UInt32): Vec2<Float32, Q>
func unpackHalf4x16(p: UInt64): Vec4<Float32, Q>

// packDouble2x32（Float64 ↔ UInt32 位模式打包）
func packDouble2x32(v: Vec2<Float64, Q>): UInt64               // 两分量 Float64 → UInt64
func unpackDouble2x32(p: UInt64): Vec2<Float64, Q>             // UInt64 → 两分量 Float64
```

- 约束：具体类型重载（主要涉及 Float32/UInt32/UInt16/UInt8 等）
- 实现路径：使用仓颉标准库原生位操作 API：`Float32.toBits(): UInt32`、`Float32.fromBits(bits: UInt32): Float32`（以及 Float16/Float64 对应版本）。Float16 的打包解包（packHalf 系族）可通过先 `toBits()` 再位操作实现，与 GLM `func_packing.inl` 的 `float2half`/`half2float` 等辅助函数对应

#### gtc/noise.cj

**角色**：噪声生成函数。

**职责**：
对标 GLM 1.0.3 `gtc/noise.inl` 的全部函数，函数签名如下：

```
// Perlin 噪声系列（返回标量 T）
func perlin1D<T, Q>(x: T): T where T <: FloatingPoint<T>, Q <: Qualifier
func perlin2D<T, Q>(v: Vec2<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier
func perlin3D<T, Q>(v: Vec3<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier
func perlin4D<T, Q>(v: Vec4<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier

// Simplex 噪声系列（全部返回标量 T）
func simplex1D<T, Q>(x: T): T where T <: FloatingPoint<T>, Q <: Qualifier
func simplex2D<T, Q>(v: Vec2<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier
func simplex3D<T, Q>(v: Vec3<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier
func simplex4D<T, Q>(v: Vec4<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier

// Perlin 周期噪声重载（1D/2D/3D/4D 各一周期版）
func perlin1D<T, Q>(x: T, period: T): T where T <: FloatingPoint<T>, Q <: Qualifier
func perlin2D<T, Q>(v: Vec2<T, Q>, period: Vec2<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier
func perlin3D<T, Q>(v: Vec3<T, Q>, period: Vec3<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier
func perlin4D<T, Q>(v: Vec4<T, Q>, period: Vec4<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier
```
- 实现参考 GLM 1.0.3 `detail/_noise.hpp`（`_noise.hpp` 第 1~81 行，定义 `mod289`、`permute`、`taylorInvSqrt`、`fade` 辅助函数）和 `gtc/noise.inl`（第 1~807 行，定义 `grad4`、`perlin`、`simplex` 系列）的算法，映射为仓颉代码
- **存储机制**：GLM 1.0.3 不使用静态排列表或梯度向量数组。排列表通过 `permute(x) = mod289(((x * 34) + 1) * x)` 函数计算产生；梯度向量通过 `grad4` 函数中的数学运算动态生成。仓颉实现亦采用纯算法方式，无需包级常量数组。所有辅助函数（`mod289`/`permute`/`taylorInvSqrt`/`fade`/`grad4`）作为 `gtc/noise.cj` 的私有（private）包级函数存在，非公共 API
- **工作量评估**：算法迁移以数学公式直译为主，约 500~800 行有效代码（含辅助函数 `mod289`/`permute`/`taylorInvSqrt`/`fade`/`grad4` 及 8 个公共噪声函数）。复杂度集中在 4D Perlin 和 4D Simplex 的索引计算，需注意仓颉 Vec4 类型的分量访问语法差异

#### gtc/random.cj

**角色**：随机数生成函数。

**职责**：
- `linearRand(min, max)`：均匀分布随机数（标量和向量版本）
- `gaussRand(mean, stddev)`：高斯分布随机数
- **随机数引擎管理**：使用仓颉 `std.random.Random` 作为底层随机数源。引擎采用 `ThreadLocal<Random>` 线程本地存储策略——每个线程持有独立的 `Random` 实例，通过仓颉 `ThreadLocal<T>`（来自 `core` 包，已验证可用，见 H5）管理，避免加锁争用
  - **初始化时机**：在 `linearRand`/`gaussRand` 首次被调用时以当前系统时间的 Unix 毫秒时间戳为种子创建 `Random` 实例（惰性初始化），存入 `ThreadLocal<Random>`。后续调用直接从 `ThreadLocal.get()` 获取实例并调用 `nextFloat64()` / `nextGaussianFloat64()` 等方法推进状态
  - **竞态保护**：`ThreadLocal<T>` 保证每个线程独立存储，无共享状态，无需加锁。初始化时线程间不存在竞态——如果两个线程同时首次调用，各自独立创建 `Random` 实例，可能因并发得到相同种子值，但后续随机数序列的推进过程天然隔离
  - **种子生成策略**：默认使用 `DateTime.now().toUnixMillisecond() ^ std.env.getProcessId()` 作为种子组合，以降低进程间种子碰撞概率（异或运算将进程 ID 混入时间戳，使同一毫秒内不同进程的种子差异化）。同一进程内多线程的惰性初始化若并发获取相同时间戳仍可能碰撞，但后续随机数序列的推进过程天然隔离（线程独立引擎），不影响数值分布的质量。`std.env.getProcessId()` 在仓颉标准库中可用，返回当前进程 ID（Int64），无需额外验证
  - **种子确定性**：不暴露种子设置 API（与 GLM 1.0.3 行为一致——GLM 的 `linearRand`/`gaussRand` 内部维护全局引擎，不提供种子控制）。若调用方需要可重复的随机序列，可扩展为支持外部种子注入，但当前设计不纳入
- **备选方案**：若 `ThreadLocal<Random>` 经编译验证不可行，备选方案为 `Mutex<Random>` 共享引擎加互斥锁保护。每次调用前获取互斥锁，完成后释放。此方案性能低于 ThreadLocal（因每次调用涉及加锁/解锁），但功能等价。经文档验证（H5），`ThreadLocal<Random>` 方案可行，无需启用备选
- **设计决策**：random.cj 是阶段四唯一包含可变状态的函数库。`linearRand`/`gaussRand` 每次调用均修改内部 `Random` 引擎的状态以推进随机数序列。此设计导致 random.cj 的函数非纯函数，需要在 §6 中作为异常声明

#### gtc/type_precision.cj

**角色**：高精度类型别名定义（与 GLM 1.0.3 `gtc/type_precision.hpp` 对应）。

**职责**：
- 定义使用 `highp/mediump/lowp` 精度的类型别名
- 涵盖向量、矩阵、四元数类型的所有精度变体
- 类型别名的具体定义可引用 `fwd.cj` 中已定义的别名，或在本文件中直接引用 `glm.detail` 的具体类型

**别名清单**（对应 GLM 1.0.3 `gtc/type_precision.hpp` 第 50~320 行）：

向量别名（每组 highp/mediump/lowp 各一）：
- `fvec1/fvec2/fvec3/fvec4`（float 向量）、`dvec1/dvec2/dvec3/dvec4`（double 向量）
- `ivec2/ivec3/ivec4`（int 向量）、`uvec2/uvec3/uvec4`（uint 向量）
- `i8vec2/i8vec3/i8vec4`（int8 向量）、`u8vec2/u8vec3/u8vec4`（uint8 向量）
- `i16vec2/i16vec3/i16vec4`（int16 向量）、`u16vec2/u16vec3/u16vec4`（uint16 向量）
- `i32vec2/i32vec3/i32vec4`（int32 向量）、`u32vec2/u32vec3/u32vec4`（uint32 向量）
- `i64vec2/i64vec3/i64vec4`（int64 向量）、`u64vec2/u64vec3/u64vec4`（uint64 向量）
- `hvec1/hvec2/hvec3/hvec4`（Float16 向量）

矩阵别名（每组 highp/mediump/lowp 各一）：
- `fmat2/fmat3/fmat4`、`fmat2x2/fmat2x3/fmat2x4/fmat3x2/fmat3x3/fmat3x4/fmat4x2/fmat4x3/fmat4x4`
- `dmat2/dmat3/dmat4`、`dmat2x2/dmat2x3/dmat2x4/dmat3x2/dmat3x3/dmat3x4/dmat4x2/dmat4x3/dmat4x4`

四元数别名：
- `fquat/dquat`、`hquat`

以上共约 100 个别名，覆盖 GLM 1.0.3 `gtc/type_precision.hpp` 的全部类型别名定义。

- **与 fwd.cj 的关系**：`type_precision.cj` 的类型别名（如 `fvec2`/`dvec3`）与 `fwd.cj` 的类型前置声明是互补而非冲突关系。`fwd.cj` 定义基础泛型类型（如 `Vec2<T, Q>`、`Mat3x3<T, Q>`），是类型构造器而非具体类型。`type_precision.cj` 在此基础上为常见精度组合定义等价别名（如 `type fvec2 = Vec2<Float32, PackedHighp>`），使调用方无需每次指定模板参数。命名空间层面，`fwd.cj` 的泛型类型通过 `public import` 暴露在 `glm` 包级（如 `glm::Vec2`），`type_precision.cj` 的别名位于 `glm.gtc` 包级（通过 `glm::fvec2` 或 `glm.gtc::fvec2` 访问）。两者命名不重叠（`Vec2` vs `fvec2`），不存在命名冲突。编码阶段可通过 `type fvec2 = Vec2<Float32, PackedHighp>` 的包级类型别名语法在 `glm.gtc` 中定义，无需修改 `fwd.cj`。

#### gtc/ulp.cj

**角色**：ULP（Units in the Last Place）浮点比较函数。

**职责**：
- `next_float(x: Float32): Float32` / `next_float(x: Float64): Float64`：返回大于 x 的下一个可表示浮点数
- `prev_float(x: Float32): Float32` / `prev_float(x: Float64): Float64`：返回小于 x 的上一个可表示浮点数
- `float_distance(x: Float32, y: Float32): Int32` / `float_distance(x: Float64, y: Float64): Int64`：返回 x 和 y 之间可表示浮点数的有符号差值（以 ULP 为单位），结果可正可负（当 y < x 时返回负值）。Float32 版本返回 Int32，Float64 版本返回 Int64（对应各自的位宽）
- `ulp(x: Float32): Float32` / `ulp(x: Float64): Float64`：返回 x 的 ULP 大小
- 约束：具体类型重载（Float32 + Float64），不使用泛型约束
- **实现路径**：内部使用 `toBits()`/`fromBits()` 操作浮点位模式。`next_float(x)` 将 x 的位模式增加 1（正数）或减少 1（负数）；`ulp(x)` 对归一化正数 x 返回 `T.fromBits(x.toBits() + 1u) - x`（即 `next_float(x) - x`），对非归一化数直接返回最小正数
- **为什么是具体类型重载而非泛型**：`FloatingPoint<T>` 接口不提供 `toBits()`/`fromBits()` 方法——这些位操作方法是具体类型 `Float32`/`Float64`/`Float16` 的实例方法，不在泛型接口中。因此无法在 `T <: FloatingPoint<T>` 约束下通过泛型代码实现 ULP 函数。改为具体类型重载后，每个版本可直接调用 `x.toBits(): UInt32/UInt64` 和 `T.fromBits(bits)` 操作位模式，实现路径清晰且可编码
- **Float16 覆盖策略**：当前设计不提供 Float16 的 ULP 函数重载，标注为已知缺失。理由：Float16 精度极低（10 位尾数），ULP 操作在典型图形计算中的实际需求近乎为零。`Float16` 同样提供 `toBits(): UInt16` 和 `fromBits(bits: UInt16): Float16` 方法，若编码阶段发现 Float16 ULP 需求，可参照 Float32 模式补充 4 个重载（`next_float`/`prev_float`/`float_distance`/`ulp`，各接收和返回 Float16），实现路径与 Float32 一致

#### gtc/round.cj

**角色**：浮点数舍入函数（与 common.cj 的 round/floor/ceil 等互补，侧重 2 的幂相关舍入）。

**职责**：
- `roundPowerOfTwo(x)`：舍入到最近的 2 的幂
- `ceilPowerOfTwo(x)`：向上舍入到最近的 2 的幂
- `floorPowerOfTwo(x)`：向下舍入到最近的 2 的幂
- `roundMultiple(x, multiple)`：舍入到最近的倍数
- `ceilMultiple(x, multiple)` / `floorMultiple(x, multiple)`
- 约束：`T <: FloatingPoint<T>`（部分函数可支持 `T <: Number<T>`）

**边界行为定义**（参照 GLM 1.0.3 `gtc/round.inl` 实现）：

| 函数 | NaN | +Inf | -Inf | 零值(±0) | 负数输入 |
|------|-----|------|------|---------|---------|
| `roundPowerOfTwo` | NaN | +Inf | -Inf | ±0 | 按负数绝对值舍入到最近的 2 的幂后恢复负号；绝对值小于 1 时返回 ±0 |
| `ceilPowerOfTwo` | NaN | +Inf | -Inf | ±0 | 向正无穷方向舍入到 2 的幂（与 GLM 一致：对负数直接返回 ±0，因负数的"向上舍入到 2 的幂"无数学意义） |
| `floorPowerOfTwo` | NaN | +Inf | -Inf | ±0 | 向负无穷方向舍入到 2 的幂（绝对值向下取 2 的幂后恢复负号） |
| `roundMultiple` | NaN | +Inf | -Inf | ±0 | `roundMultiple(x, m)` 按 `m * floor(x / m + T(0.5))` 公式运算，负数自然传播 NaN/Inf |
| `ceilMultiple` | NaN | +Inf | -Inf | ±0 | `ceilMultiple(x, m)` 按 `m * ceil(x / m)` 公式运算，负数自然传播 NaN/Inf |
| `floorMultiple` | NaN | +Inf | -Inf | ±0 | `floorMultiple(x, m)` 按 `m * floor(x / m)` 公式运算，负数自然传播 NaN/Inf |

注：所有 round 函数均遵循 GLM 1.0.3 的"不做输入有效验证"策略——函数结果由底层浮点运算自然决定，NaN/Inf 经 IEEE 754 运算传播。不抛出异常。

---

## 4. 关键行为契约

### 4.1 核心场景：基础函数调用

```
用户场景：对向量进行逐分量数学运算
输入：Vec2<Float32, PackedHighp>, Float32 标量
流程：
  1. 用户调用 glm::abs(v) / glm::ceil(v) / glm::mix(v, w, 0.5f)
  2. 编译器根据参数类型匹配对应的标量+Vec 重载集合
  3. 函数体内对每个分量通过 `stdmath_shim.cj` 包装层调用 std.math 的对应浮点函数或使用纯算术运算
  4. 返回新的 Vec 实例
约束：common.cj 使用 Number<T>/FloatingPoint<T>/Comparable<T> 多接口约束，由参数类型 T 自动推导
```

### 4.2 核心场景：几何运算

```
用户场景：计算向量长度、单位向量、反射方向和折射方向
输入：Vec3<Float32, PackedHighp>
流程：
  1. length(v): dot(v, v) → sqrt(dot_result)
  2. normalize(v): v / length(v)，零向量保护返回 Vec3(T(0), T(0), T(0))
  3. reflect(I, N): I - T(2) * dot(N, I) * N
  4. refract(I, N, eta): 使用 k = T(1) - eta*eta * (T(1) - dot(N,I)^2)
     - 若 k < 0 返回零向量（全反射）
     - 否则返回 eta * I - (eta * dot(N,I) + sqrt(k)) * N
  5. faceforward(N, I, Nref): dot(Nref, I) < T(0) ? N : -N
约束：T <: FloatingPoint<T>
```

### 4.3 核心场景：矩阵行列式与逆

```
用户场景：对方阵求逆、计算行列式
输入：Mat4x4<Float32, PackedHighp> (4x4 方阵)
流程：
  1. determinant(m4x4): 使用拉普拉斯展开或分块行列式
  2. inverse(m4x4): 计算余子式矩阵 → 转置 → 除以行列式
   3. 奇异矩阵求逆的结果由 IEEE 754 浮点运算自然决定（1/det → Inf，Inf × 0 → NaN），最终可能产生 NaN 或 Inf 填充的矩阵。函数不抛出异常
约束：T <: Number<T>（determinant），T <: FloatingPoint<T> 的 extend 块（inverse 需要除法）
```

### 4.4 核心场景：矩阵变换

```
用户场景：构造视图矩阵、投影矩阵
输入：Vec3 相机位置/目标/上方向，视场角/宽高比/近远平面
流程：
  1. lookAt(eye, center, up):
     - f = normalize(center - eye), s = normalize(cross(f, up)), u = cross(s, f)
     - 构造旋转矩阵 R = [s.x, u.x, -f.x, 0; s.y, u.y, -f.y, 0; s.z, u.z, -f.z, 0; 0,0,0,1]
     - 应用平移: R * translate(-eye)
  2. perspective(fovy, aspect, zNear, zFar):
     - tanHalfFovy = tan(fovy / T(2))
     - 构造透视投影矩阵（列主序）
  3. ortho(left, right, bottom, top, zNear, zFar):
     - 构造正交投影矩阵（列主序）
约束：T <: FloatingPoint<T>
```

### 4.5 核心场景：四元数 stub 补齐

```
用户场景：四元数球面插值（阶段三 stub 现在变为完整实现）
输入：两个四元数 x、y 和插值系数 a
流程：
  1. cosOmega = clamp(dot(x, y), -T(1), T(1))      // clamp 防止浮点误差导致 dot 略微越界
  2. omega = acos(cosOmega)                          // 依赖 trigonometric acos
  3. sinOmega = sin(omega)                           // 依赖 trigonometric sin
  4. 若 sinOmega 接近零：退化为 lerp = x*(T(1)-a) + y*a
  5. 否则：
     scale0 = sin((T(1)-a)*omega) / sinOmega
     scale1 = sin(a*omega) / sinOmega
     返回 scale0 * x + scale1 * y
约束：T <: FloatingPoint<T>
注：第 1 步的 clamp 是调用方（slerp）在调用 acos 前对输入做的数值稳定预处理，不属于 acos 函数自身的 clamp 行为。
```

### 4.6 核心场景：矩阵转置/行列式/逆的依赖关系

```
geometric.cj normalize/normalize/cross 等的完整实现 → Quat×Vec3 运算符从抛 stub 变为正常
trigonometric.cj acos/sin 的完整实现 → slerp 从 stub（❌）变为正常
trigonometric.cj sin/cos 的完整实现 → ext/quaternion_transform rotate 从 stub 变为正常
geometric.cj faceforward 的完整实现 → 新增 API 可用
matrix.cj determinant/inverse 的完整实现 → 矩阵除法 / 运算符从抛 stub 变为正常
```

---

### 4.7 深度数据流与控制流分析

#### 4.7.1 slerp 球面线性插值

**调用链**：`ext/quaternion_common.cj.slerp(x, y, a)` → `detail/common.cj.clamp(cosOmega, -1, 1)` → `detail/trigonometric.cj.acos(cosOmega)` → `detail/trigonometric.cj.sin(omega)` → `detail/common.cj`（`T(1)` 字面量构造）

**完整数据流**：

```
输入: x: Quat<T,Q>, y: Quat<T,Q>, a: T (插值系数)
类型约束: T <: FloatingPoint<T>, Q <: Qualifier

Step 1: cosOmega = dot(x, y)                     → T（标量）
  类型约束: Quat.dot 要求 T <: FloatingPoint<T> 
  数据变换: x.w*y.w + x.x*y.x + x.y*y.y + x.z*y.z

Step 2: cosOmega = clamp(cosOmega, -T(1), T(1))  → T
  类型约束: common.cj.clamp 要求 T <: Number<T> & Comparable<T>
  数据变换: max(-1, min(cosOmega, 1))
  控制流分支: 钳位只在 |cosOmega| > 1 时生效
  异常传播: 浮点误差导致 dot 略超 [-1,1] 时被静默纠正

Step 3: omega = acos(cosOmega)                   → T
  类型约束: trigonometric.cj.acos 要求 T <: FloatingPoint<T>
  异常传播: acos 内部含越界保护（§5），此处因 Step 2 的 clamp 确保输入在范围
            内，越界保护不触发。若 acos 输入超出 [-1,1] 返回 NaN。

Step 4: sinOmega = sin(omega)                    → T
  类型约束: trigonometric.cj.sin 要求 T <: FloatingPoint<T>
  数据变换: std.math.sin(Float64(omega)) 经 stdmath_shim.cj

Step 5: 控制流分支判断
  if (sinOmega < epsilon<T>()):
    // 退化路径：sinOmega 接近零（omega ≈ 0 或 omega ≈ π）
    // omega ≈ 0: x 与 y 几乎同向 → lerp 即可
    // omega ≈ π: x 与 y 几乎反向 → 退化 lerp 避免除零
    result = x * (T(1) - a) + y * a              → Quat<T,Q>
    类型约束: T(1) 构造使用 T(Float64(1))（§1.4 表示约定）
    异常传播: 无新异常引入
  else:
    // 正常路径
    scale0 = sin((T(1) - a) * omega) / sinOmega   → T
    scale1 = sin(a * omega) / sinOmega             → T
    result = scale0 * x + scale1 * y               → Quat<T,Q>
    类型约束: Quat 标量乘法和加法在阶段三已验证

输出: result: Quat<T,Q>
```

**异常传播路径汇总**：
| 异常点 | 触发条件 | 传播路径 | 最终结果 |
|--------|---------|---------|---------|
| `clamp` 无异常 | — | — | — |
| `acos` 越界 | 输入超出 [-1,1] | 返回 NaN → omega = NaN → sin(omega) = NaN → scale = NaN → result = NaN | NaN 填充的四元数 |
| `sin`(Step 4) | 无异常 | — | — |
| 退化分支 `sinOmega ≈ 0` | 细分除零 | 分母 `epsilon` 级小量 → scale 可能极大或 Inf → NaN 传播 | NaN 或 Inf 四元数 |
| 正常分支 `1/sinOmega` | sinOmega = 0 | +Inf → Inf × 0 = NaN | NaN 填充的四元数 |

#### 4.7.2 lookAt 视图矩阵构造

**调用链**：`ext/matrix_transform.cj.lookAt(eye, center, up)` → `detail/geometric.cj.normalize(center - eye)` → `detail/geometric.cj.cross(s, normalized_f)` → `detail/trigonometric.cj`（无调用，三角运算不参与 lookAt）

**完整数据流**：

```
输入: eye: Vec3<T,Q>, center: Vec3<T,Q>, up: Vec3<T,Q>
类型约束: T <: FloatingPoint<T>, Q <: Qualifier

Step 1: f = normalize(center - eye)                → Vec3<T,Q>
  子调用链: Vec3.sub → geometric.cj.normalize → geometric.cj.length → dot(f, f) → sqrt(dot)
  类型约束: Vec3.sub 要求 T <: Number<T>（阶段一）；normalize 要求 T <: FloatingPoint<T>
  控制流分支（normalize 内部）:
    - lengthSq == T(0): eye == center → f 为零向量 → 返回 Vec3(T(0),T(0),T(0))
    - lengthSq != T(0): 正常归一化
  异常传播: eye == center 时 normalize 返回零向量 → 后续 cross 运算产生零向量 → lookAt 输出退化矩阵
            此退化场景不抛出异常，结果矩阵为无效视图矩阵

Step 2: s = normalize(cross(f, up))                 → Vec3<T,Q>
  子调用链: geometric.cj.cross(f, up) → geometric.cj.normalize(cross_result)
  类型约束: cross 要求 T <: Number<T>；normalize 同 Step 1
  控制流分支（cross 无分支，纯乘减运算）
  异常传播（Step 2 起点）:
    - 若 f 为零向量（Step 1 退化），cross(f, up) = Vec3(0,0,0) → normalize(零向量) = 零向量
    - 若 up 与 f 平行，cross 结果接近零向量 → normalize 产生大数值或 NaN

Step 3: u = cross(s, f)                              → Vec3<T,Q>
  类型约束: cross 要求 T <: Number<T>
  数据变换: cross(s_normalized, f_normalized) — 此时 s 和 f 均为单位向量
  异常传播: 若 Step 2 的 s 为零向量，则 u 为零向量

Step 4: 构造 4×4 视图矩阵                          → Mat4x4<T,Q>
  构造公式（列主序）:
    col0 = [s.x,  u.x, -f.x, T(0)]
    col1 = [s.y,  u.y, -f.y, T(0)]
    col2 = [s.z,  u.z, -f.z, T(0)]
    col3 = [-dot(s, eye), -dot(u, eye), dot(f, eye), T(1)]
  类型约束: T(0)/T(1) 使用 T(Float64(n))（§1.4 表示约定）

控制流分支汇总:
  1. eye == center → f 为零向量 → s 和 u 均为零向量 → 结果矩阵退化（所有列零或含零）
  2. up ∥ f（上行与视线平行）→ cross(f, up) → 零向量 → s 为零向量 → u 也是零向量 → 结果矩阵退化（无上方向量）
  3. 正常路径 → 标准视图矩阵

输出: viewMatrix: Mat4x4<T,Q>
```

#### 4.7.3 inverse (Mat4x4) 矩阵求逆

**调用链**：`detail/matrix.cj.inverse(m: Mat4x4<T,Q>)` 内部余子式展开，不依赖外部函数库

**数据流与控制流**：

```
输入: m: Mat4x4<T,Q>
类型约束: T <: FloatingPoint<T>（需要除法 T(1)/det）

Step 1: 计算 4×4 行列式 det = determinant(m)       → T
  实现策略: 余子式展开（拉普拉斯展开）
  内部展开路径（GLM 1.0.3 标准实现）:
    det = m[0][0] * cofactor00 + m[0][1] * cofactor01 + m[0][2] * cofactor02 + m[0][3] * cofactor03
    其中每个 cofactor = 对应 3×3 子式（3 阶行列式）
    每 3 阶行列式 = 3 项乘加运算（标量三重积）
  类型约束: determinant 要求 T <: Number<T>（乘减运算即可）
  控制流: 无分支

Step 2: 余子式矩阵计算（16 个余子式）              → Mat4x4<T,Q>
  每个余子式 = (-1)^(i+j) * det(3×3 子矩阵)
  内部展开: 共 16 个余子式，每个 = 6 次乘 + 2 次加减（3×3 行列式展开）× 符号
  数据依赖: 每个余子式从输入矩阵 m 的不同行/列组合提取
  控制流: 无分支，16 个独立计算

Step 3: 构造伴随矩阵 = 余子式矩阵的转置             → Mat4x4<T,Q>
  数据变换: 行列交换（纯数据重排，无算术运算）
  控制流: 无分支

Step 4: 1 / det                                     → T
  控制流分支（关键决策点）:
    - det ≠ 0: 正常除法，结果 = 1/det（有限浮点数）
    - det = 0: 1/0 = +Inf 或 -Inf（IEEE 754，已验证 H4）
    - det = NaN: 1/NaN = NaN（IEEE 754 NaN 传播）

Step 5: result = adjugate * (1/det)                 → Mat4x4<T,Q>
  数据变换: 伴随矩阵各元素 × (1/det)，16 次标量乘法
  异常传播路径（当 det = 0 时）:
    1/det = Inf（符号取决于 det 的零值符号）
    Inf × 伴随矩阵元素:
      - Inf × 0 → NaN（IEEE 754 0×Inf = NaN）
      - Inf × 非零有限值 → ±Inf
      - Inf × NaN → NaN
    NaN 传播: 矩阵中任何含 NaN 的元素导致该列/行在后续计算中传播 NaN
    最终形态: 至少 1 个 NaN 元素 + 若干 Inf 元素的混合矩阵

控制流分支汇总:
  - det = 0: 奇异矩阵 → IEEE 754 自然传播 NaN/Inf
  - det ≠ 0: 正常求逆 → 有限精度浮点结果
  - det 为 NaN/Inf: 调用方输入异常 → 自然传播 NaN/Inf

输出: result: Mat4x4<T,Q>（det=0 时含 NaN/Inf）
  不抛出异常，调用方自行检测 det 判断奇异性
```

---

## 5. 错误处理策略

### 错误分类

| 场景 | 策略 | 说明 |
|------|------|------|
| **奇异矩阵求逆** | 由 IEEE 754 浮点运算自然决定（1/det → Inf，Inf × 0 → NaN），最终可能产生 NaN 或 Inf 填充的矩阵 | 与 GLM 1.0.3 行为一致，不抛出异常，调用方需自行通过行列式检查矩阵的奇异性 |
| **unProject 系族隐式矩阵求逆（proj×model 奇异）** | proj×model 为奇异矩阵时，内部 `inverse(proj * model)` 产生 NaN/Inf 填充结果，经由视口逆变换传播至最终 unProject 输出 | 此隐式求逆路径行为与 `matrix.cj.inverse` 的奇异行为一致（IEEE 754 自然传播 NaN/Inf，不抛异常）。不重复设计决策，行为参照 §5 奇异矩阵求逆行。调用方应确保 proj×model 非奇异后再调用 unProject |
| **Vec2~Vec4 零向量 normalize** | 返回零向量 | 保护分支：`if lengthSq <= T(0) return zero-vec`。与 GLM 1.0.3 行为一致（GLSL 10.1.1：if length(x)==0, result is undefined；此处保守返回零向量）。采用 `<=` 而非 `==` 的理由见 §3.1 geometric.cj normalize 零值行为说明 |
| **Vec1 零向量 normalize** | 返回 NaN | Vec1 使用 `v * inversesqrt(dot(v,v))` 通式，不设保护分支。零值时 `T(0) * +Inf = NaN`（IEEE 754 NaN 传播），与 GLM 1.0.3 的 `compute_normalize` 实现一致 |
| **acos/asin 输入超出 [-1,1]** | 返回 NaN | `std.math.acos`/`std.math.asin` 在越界时抛出 `IllegalArgumentException`（与 GLM 行为不符）。`glm.detail.acos`/`glm.detail.asin` 内部做 `x < -T(1) || x > T(1)` 前置检查，越界时直接返回 `T.getNaN()`，仅合法输入委托 `std.math`。此行为与 GLM 1.0.3（委托 std::acos 的 NaN 返回行为）一致。例外：slerp 实现中调用 acos 前对 dot 结果做 clamp（§3.2 · ext/quaternion_common.cj），这是调用方的数值稳定措施而非 acos 函数的契约 |
| **mod 浮点参数** | 无异常抛出 | 使用 `x - y * floor(x / y)` 公式，自然传播 NaN/Inf |
| **`inversesqrt` 零值输入** | 返回 `+Inf` | `inversesqrt(0)` = `T(1) / sqrt(0)` = `T(1) / 0` = `+Inf`（IEEE 754 自然浮点运算结果，已验证 H4）。GLM 1.0.3 文档声明输入范围为 `[0, +inf)`，零值行为是 IEEE 754 标准衍生，不额外增加保护逻辑 |
| **本阶段定义范围内的 stub 未替换** | 不存在 | 本阶段完成后，除 §1.5 列明的 ext/quaternion_exponential.cj 外无存留 stub |
| **`stdmath_shim.cj` Float64→Float16 转型溢出** | 抛出 `getOrThrow()` 异常 | `(result as T).getOrThrow()` 在 `T=Float16` 且中间值超过 ±65504 时抛出 `ArithmeticException`（转型溢出），而 GLM 1.0.3 返回 ±Inf。此差异在 Float16 低精度图形场景中触发概率极低（中间值超出 Float16 范围需要极大的输入值），本设计接受此差异（见 D29）。编码阶段可通过在 `stdmath_shim.cj` 中添加 Float16 溢出保护（`if result > Float16.MAX → T.getInf()`）消除此差异 |

本阶段不引入新的错误类型。所有函数的错误处理行为遵循 GLM 1.0.3 的约定："不验证输入有效性，函数结果由输入决定，包括 NaN/Inf 传播"。

---

## 6. 并发设计

本阶段除 `gtc/random.cj` 外不引入新的并发机制。core/ext/gtc 函数库（不含 random.cj）均为纯函数（无副作用、不修改输入参数），天然线程安全。矩阵和向量的值语义（struct + 返回副本）确保并发计算中的隔离性。

**例外 — `gtc/random.cj`**：`linearRand` 和 `gaussRand` 需要可变状态的随机数引擎以推进随机数序列，因此非纯函数。线程安全性通过 `ThreadLocal<Random>`（已验证 H5）保证——每个线程持有独立的 `Random` 实例，无共享状态，无需加锁。惰性初始化策略确保首次使用时创建引擎实例。此例外不影响其他函数库的纯函数声明。

---

## 7. 设计决策

| 编号 | 决策 | 理由 |
|------|------|------|
| D01 | **core 函数使用 `FloatingPoint<T>` 而非 `Number<T>` 约束** | 多数函数（sqrt/sin/cos/exp/log 等）仅在浮点类型上有意义。整数类型调用这些函数是编译错误而非运行时错误，符合"尽早捕获类型错误"原则 |
| D02 | **common.cj 的 `abs/min/max/clamp` 使用 `Number<T> & Comparable<T>`** | 整数和浮点均可使用，且需要比较运算。`Number<T>` 提供算术运算，`Comparable<T>` 提供比较运算 |
| D03 | **`dot` 使用 `Number<T>` 约束而非 `FloatingPoint<T>`** | dot 本质是乘加运算，对整数类型也有意义（虽然 GLSL 规范限制为浮点）。基于 D5（宽松泛型约束，延迟检查）策略，保持与阶段一一致 |
| D04 | **`normalize/length/distance` 使用 `FloatingPoint<T>`** | 需要 `sqrt`（std.math.sqrt 仅对浮点类型可用），整数类型在实例化处报错 |
| D05 | **determinant 使用 `Number<T>` 约束，inverse 需要浮点除法** | determinant 仅涉及乘减运算，整数可编译；inverse 需要除法（`T(1)/det`），对整数类型在实例化处报错 |
| D06 | **函数库契约不验证输入有效性** | 遵循 GLM 1.0.3 的原始行为——不做 NaN/Inf/越界检查，结果由底层数值运算自然决定 |
| D07 | **common.cj 的 `mix` 为 Bool 选择器版本单独重载** | `mix(x, y, a)` 当 a 为 Bool 时语义为选择而非插值，需要独立的签名 `func mix<T, Q>(x: T, y: T, a: Bool): T`（标量）和向量版本 |
| D08 | **gtc/matrix_transform.cj 使用 `FloatingPoint<T>` 而非 `Number<T>` 约束** | 所有矩阵变换函数（lookAt/perspective/ortho 等）均使用三角函数和倒数，仅在浮点类型上有意义 |
| D09 | **ext/quaternion_common.cj 的 slerp 当 sinOmega 接近零时退化为 lerp** | 与 GLM 1.0.3 行为一致。退化判定条件为 `if (sinOmega < epsilon<T>())` 时退化为线性插值，其中 `epsilon<T>()` 返回 T 类型的机器 epsilon。此条件确保 sinOmega 接近零时分母 `1/sinOmega` 不放大数值误差 |
| D10 | **ext/quaternion_common.cj 的 mix 使用 clamp(a, T(0), T(1)) 而非 assert** | 与阶段三存在已有实现的 lerp 的 assert 策略不同——lerp 使用 assert 断言 a 在 [0,1] 范围内，mix 使用 clamp 静默处理越界。理由：mix 的 GLSL 规范未要求 assert，且越界插值是常见用法。此决策引入两种约束策略的差异，属于有意识的设计选择，编码阶段需注意保持此差异 |
| D11 | **gtc/matrix_inverse.cj 不依赖 gtc/matrix_transform.cj，仅依赖 detail/matrix.cj** | 保持最小依赖。affineInverse 和 inverseTranspose 只需要行列式和逆运算，不需要矩阵变换函数 |
| D12 | **gtc/packing.cj 使用具体类型重载而非泛型** | 打包运算涉及位级操作和特定的数值转换（如 Float32 ↔ UInt32 的位模式转换），不适合泛型化。仓颉标准库已提供原生位操作 API：`Float32.toBits(): UInt32` 和 `Float32.fromBits(bits: UInt32): Float32`（以及 Float16/Float64 的对应版本），应使用这些原生 API 而非 CFFI |
| D13 | **gtc/noise.cj 的 Perlin/Simplex 实现直接内联算法，不依赖外部噪声库** | 仓颉标准库不提供噪声函数。噪声算法的参考实现在 GLM 1.0.3 的 `detail/_noise.hpp` 中已有完整数学定义，直接迁移 |
| D14 | **ext/matrix_transform.cj 与 gtc/matrix_transform.cj 的 translate/rotate/scale 重复** | 两者在 GLM 1.0.3 中均存在（ext 版本与 gtc 版本），ext 版本提供基础功能，gtc 版本提供更完整的手系/深度变体。编码阶段需注意 gtc 版本内部可委托 ext 版本以避免代码重复 |
| D15 | **`mod` 函数泛型约束为 `Integer<T>`，`scalar_vec_ops.cj` 已有浮点向量重载共存；推荐实现标量浮点 `mod` 重载** | common.cj 的泛型 `mod` 约束为 `Integer<T>`，维持不变。`scalar_vec_ops.cj` 已有 12 个具体浮点类型向量重载（Float16/Float32/Float64 × Vec1~Vec4），这些重载以具体类型函数存在，与泛型 `mod` 通过函数重载共存。**推荐编码阶段实现 3 个标量浮点 `mod` 重载**：`func mod(x: Float32, y: Float32): Float32`、`func mod(x: Float64, y: Float64): Float64`、`func mod(x: Float16, y: Float16): Float16`，使用 `x - y * floor(x / y)` 公式。此举使 GLSL 的 `mod(float, float)` 调用可直接编译，无需依赖向量重载间接路径。`Integer<T>` 约束不变不影响已有代码编译 |
| D16 | **geometric.cj 约束从 `Number<T>`（阶段三 stub）收紧为 `FloatingPoint<T>`（本阶段）** | 阶段三的 `geometric.cj` stub 为快速编译而使用了宽松的 `Number<T>` 约束。本阶段替换为完整实现后，`normalize/length/distance/reflect/refract` 均需要 `sqrt`（仅浮点类型可用），因此约束收紧为 `FloatingPoint<T>`。`dot`/`cross` 作为纯乘加运算保持 `Number<T>` 约束。此变更为向后不兼容——原通过 `Number<T>` 编译通过的整数实例化将在本阶段编译报错。<br><br>**波及范围分析**：经搜索阶段一~三全部源码（`detail/`、`ext/`、`gtc/`），未发现任何调用 `detail.geometric` 函数（`normalize`/`length`/`distance`/`reflect`/`refract`）时使用整数向量类型的现成代码。`ext/quaternion_geometric.cj` 中的 `length(q)`/`dot(q,q)` 操作 `Quat` 类型（始终为浮点），不受影响。`dot` 保持 `Number<T>` 约束不变，因此 `detail.dot(IntVec2, IntVec2)` 仍可编译。结论：理论上的向后不兼容变更在实际代码库中无受影响调用点，编码阶段无需修改阶段一~三现有代码 |
| D17 | **slerp 在调用 acos 前对 dot 结果做 clamp，不影响 §5 的"acos 不做 clamp"策略** | §5 的"acos 输入不做 clamp"指 trigonometric.cj 中 acos 函数自身的实现契约。slerp 中对 `dot(x, y)` 结果做 `clamp(..., -T(1), T(1))` 是调用方因浮点运算误差（归一化误差使 dot 略超 [-1,1]）而采取的数值稳定措施，两者属于不同职责层面，不矛盾 |
| D18 | **Mat4x4 inverse 选择余子式展开（cofactor expansion）** | 与 GLM 1.0.3 实现一致（`func_matrix.inl` `compute_inverse<4,4,T,Q,Aligned>` 使用显式 cofactor 公式）。高斯消元法虽在数值稳定性上等价，但 GLM 作为数学库的参考实现选择余子式展开，保持行为一致可降低交叉验证成本 |
| D19 | **`gtc/random.cj` 使用 `ThreadLocal<Random>` 管理随机数引擎** | `linearRand`/`gaussRand` 每次调用修改引擎内部状态，非纯函数。仓颉 `ThreadLocal<Random>`（来自 `core` 包，已验证可用 H5）确保每个线程持有独立实例，无需加锁。惰性初始化：首次调用时以系统时间 Unix 毫秒时间戳为种子创建 `Random` 实例。备选方案 `Mutex<Random>` 可用但性能较差，仅在 `ThreadLocal` 方案经编译验证不可行时启用 |
| D20 | **`inversesqrt(0)` 返回 `+Inf`，不增加零值保护分支** | 与 GLM 1.0.3 实现一致——`T(1) / sqrt(0)` 经 IEEE 754 浮点运算自然产生 `+Inf`。仓颉浮点类型遵循 IEEE 754 标准（已验证 H4），`T(1) / T(0)` 返回 `+Inf` 而非抛出异常。输入范围 `[0, +inf)` 下零值是被允许的边界值，Inf 输出是 IEEE 754 对除零的标准响应。如果增加保护分支（如返回 `T(0)` 或 `T(Inf)` 的显式写法），反而偏离了 GLM 的行为 |
| D21 | **`gtc/noise.cj` 采用纯算法实现，不使用静态排列表或梯度向量数组** | GLM 1.0.3 的噪声算法通过 `permute(x) = mod289(((x*34)+1)*x)` 函数动态计算置换，`grad4` 函数动态生成梯度向量，均无需预定义常量表。仓颉实现保持此方式，仅需 `detail/_noise.hpp` 和 `gtc/noise.inl` 中的辅助函数作为私有包级函数 |
| D22 | **`ext/quaternion_trigonometric.cj` 的 `angle`/`angleAxis` 纳入本阶段补齐** | 两函数因依赖 `trigonometric.cj`（本阶段实现）而处于 stub 状态。阶段三仅为占位 stub 而未完整实现。纳入本阶段范围后，`angle` 使用 `acos(clamp(w, -1, 1))` 公式（与 GLM 1.0.3 一致），`angleAxis` 使用 `sin/cos` 构造四元数分量 |
| D23 | **`lib.cj` 中 `mix`/`exp`/`log`/`pow`/`sqrt` 的跨包同符号导入通过函数重载决议解决，后备方案为显式限定名调用** | 经仓颉语言文档验证（H6），仓颉支持函数重载，编译器基于参数类型自动选择正确版本。<br><br>**`mix` 冲突分析**：`glm.detail.common.cj` 的 `mix` 针对标量/向量类型（`T <: Number<T>`），`glm.ext` 的 `mix` 针对四元数类型（`quat<T,Q>` 参数）。调用 `mix(quatA, quatB, 0.5f)` 时参数为四元数类型，匹配 ext 版本；调用 `mix(v1, v2, 0.5f)` 时参数为向量类型，匹配 detail 版本。无歧义。<br><br>**`exp`/`log`/`pow`/`sqrt` 冲突分析**：`glm.detail.exponential.cj` 的版本针对标量/向量类型（`T <: FloatingPoint<T>`），`glm.ext`（来自 ext/quaternion_exponential.cj，保持 stub 状态）的版本针对四元数类型。调用 `exp(vec)` 匹配 detail 版本；调用 `exp(quat)` 匹配 ext 版本（虽为 stub，但签名存在）。无歧义。<br><br>**后备方案**：若重载决议出现编译错误（如歧义调用），回退方案为在 lib.cj 中删除冲突符号的 `public import`，改为在 `glm` 包中定义转发函数——例如 `func mix<T, Q>(x: T, y: T, a: T): T { return glm.detail.mix(x, y, a) }`，通过显式包路径消除歧义。当前已验证 H6 成立，无需启用后备方案 |
| D24 | **ext/matrix_transform.cj 和 ext/matrix_clip_space.cj 的函数范围完全对标 GLM 1.0.3 对应头文件** | 避免设计遗漏。ext/matrix_transform.cj 包含 `identity/translate/rotate/scale/shear/lookAt` 系族共 6 个函数；ext/matrix_clip_space.cj 包含 `ortho/frustum/perspective/perspectiveFov/infinitePerspective/tweakedInfinitePerspective` 系族共 46 个函数。覆盖范围与 GLM 1.0.3 `ext/matrix_transform.hpp` 和 `ext/matrix_clip_space.hpp` 一一对应 |
| D25 | **`modf`/`frexp` 使用元组返回替代 C 引用参数** | 仓颉无引用参数。C 语言 `modf(x, &i)` 通过指针输出 integer 部分，仓颉以 `(T, T)` 元组返回。`frexp(x, &exp)` 以 `(T, Int64)` 元组返回（指数为整数语义，使用 Int64 而非泛型 T）。元组返回是仓颉中模拟"多个输出值"的自然方式，调用方通过 `let (frac, i) = modf(x)` 解构获取两值 |
| D26 | **`acos`/`asin` 内部做越界检查，返回 NaN 而非传播异常** | 仓颉 `std.math.acos`/`std.math.asin` 在输入超出 [-1, 1] 时抛出 `IllegalArgumentException`，与 GLM 1.0.3 委托 C 标准库的 NaN 返回行为不符。方案：在 `glm.detail.acos`/`glm.detail.asin` 内部增加 `x < -T(1) || x > T(1)` 前置检查，越界时返回 `T.getNaN()`。此保护是函数自身契约的一部分，与调用方（如 slerp）的数值稳定 clamp 属于不同职责层面 |
| D27 | **`gtc/ulp.cj` 改为具体类型重载（Float32 + Float64），放弃泛型方案** | `FloatingPoint<T>` 接口不提供 `toBits()`/`fromBits()` 方法（这些位操作方法仅存在于具体类型 `Float32`/`Float64` 上），因此无法在泛型代码中实现 ULP 操作。改为 `next_float(x: Float32): Float32`等具体类型重载后，内部可直接使用 `x.toBits(): UInt32/UInt64` 和 `T.fromBits(bits)` 操作位模式。此设计回退是仓颉类型系统限制所致，不影响最终功能完整性 |
| D28 | **`gtc/random.cj` 种子生成使用 `时间戳 ^ 进程 ID` 组合，标注已知碰撞风险** | 使用 `DateTime.now().toUnixMillisecond() ^ std.env.getProcessId()` 作为种子组合，降低同毫秒内跨进程的种子碰撞概率。同一进程内多线程惰性初始化时若并发获取相同时间戳仍可能碰撞，但后续随机数序列的推进过程天然隔离（线程独立引擎），不影响数值分布质量。标注为"已知的种子碰撞风险，与 GLM 1.0.3 行为一致，当前设计接受此风险"——GLM 1.0.3 内部维护全局引擎也不提供种子控制，仓颉实现的增强策略已优于 GLM 原始行为。`std.env.getProcessId()` 可用性已通过仓颉标准库文档确认 |
| D29 | **`exponential.cj` 的 `pow` 通过 `stdmath_shim.cj` 包装层统一实现** | `std.math.pow` 仅提供 `(Float64, Float64): Float64` 签名。`stdmath_shim.cj` 提供 `powT<T>(base, exp): T where T <: FloatingPoint<T>`，内部实现为 `(std.math.pow(Float64(base), Float64(exp)) as T).getOrThrow()`。Float16/Float32/Float64 三种浮点类型经统一的双向转型路径处理，无特殊回退分支。`ldexp` 的 `x * powT(T(2), T(exp))` 同理。此模式与 `sqrtT`/`expT`/`logT` 等其他 shim 包装器一致。<br><br>**Float16 溢出行为差异说明**：`(result as T).getOrThrow()` 模式在 `T = Float16` 且中间值超过 ±65504 时抛异常（`Float64 → Float16` 转型溢出），而 GLM 1.0.3 返回 ±Inf。此差异在 Float16 低精度图形场景中触发概率极低（中间值超出 Float16 范围需要非常大的输入值），本设计接受此差异。若编码阶段需消除此差异，可为 `stdmath_shim.cj` 添加 Float16 溢出保护：`if result > Float16.MAX → T.getInf()`。<br><br>**Float32 非规格化数精度损失说明**：`ldexp` 的 `x * powT(T(2), T(exp))` 在 `T = Float32` 且 `x` 为非规格化数时，中间值 `powT(T(2), T(exp))` 与 `x` 的乘运算可能导致额外的舍入误差（相比 GLM 1.0.3 的 C++ `std::ldexp` 使用更高精度中间值）。此精度损失在非规格化数参与的计算中触发概率低（典型图形计算极少涉及非规格化数），当前设计接受此差异。 |
| D30 | **`lib.cj` 中 translate/rotate/scale/shear/lookAt/lookAtRH/lookAtLH 跨包导入冲突通过修改现有行解决** | 现有 lib.cj 第 23 行从 gtc 导入 translate/rotate/scale/shear/lookAt/lookAtRH/lookAtLH。本阶段 §8 的 ext 导入同样导入这些符号，造成跨包重复导入冲突。<br><br>**推荐方案**：修改现有 lib.cj 第 23 行，从 gtc 的 public import 中删除 translate/rotate/scale/shear/lookAt/lookAtRH/lookAtLH，改由 §8 的 `public import glm.ext.{translate, rotate, scale, shear, lookAt, lookAtRH, lookAtLH}` 统一提供。gtc/matrix_transform.cj 内部通过 `public import` 从 ext 转发这些函数，确保通过 `glm::` 命名空间（即 `glm.gtc` 包路径）调用时仍可访问。此方案使 ext 层作为实现细节，gtc 层作为稳定 API 面，符合 GLM 1.0.3 的 gtc 委托层角色。<br><br>**验证结果**：经仓颉语言文档确认（H6），函数重载可基于参数类型自动区分。ext 和 gtc 中同名函数签名为同一实现（gtc 转发至 ext），无重载歧义。此方案已在 D23 的同符号导入分析框架中得到支撑。 |
| D31 | **噪声函数采用 `perlin1D~/perlin4D`、`simplex1D~/simplex4D` 拆分命名，而非 GLM 1.0.3 的单一函数名 `perlin`/`simplex` 加模板维度参数** | GLM 1.0.3 的 C++ 实现通过模板参数 `L` 区分噪声维度（`perlin(vec<L,T,Q>)`），同一函数名经模板实例化后产生不同维度版本。仓颉不支持整数维度泛型参数，无法用单一泛型函数覆盖所有维度。因此拆分为维度专属函数名（`perlin1D`/`perlin2D`/`perlin3D`/`perlin4D` 和 `simplex1D`/`simplex2D`/`simplex3D`/`simplex4D`），每个函数接受对应维度的向量参数。周期性 Perlin 噪声同理拆分为 `perlin1D(..., period)`/`perlin2D(..., period)`/`perlin3D(..., period)`/`perlin4D(..., period)`，每个维度各一周期重载。此命名模式与 gtc/packing.cj 中 pack 函数的分维度命名一致（如 `packUnorm2x8`/`packUnorm4x8`），保持全库命名风格统一。 |
| D32 | **`ext/quaternion_transform.cj` 的 `rotate` 零轴返回单位四元数** | 当 axis 向量长度为零时，`rotate(q, angle, axis)` 返回单位四元数 `Quat(T(1), T(0), T(0), T(0))`，而非保留原 `q` 或抛出异常。此决策的语义基础：零向量无法归一化（`normalize(zero)` 在 Vec3 版本下因 `<=` 保护分支返回零向量本身），基于零轴构造的旋转四元数为 `(0, 0, 0, cos(halfAngle))`——若 `angle` 非零则非单位四元数（无法直接使用），若 `angle` 为零则 `cos(0) = 1` 但分量均为零仍非有效四元数。返回单位四元数是最安全且无副作用的选择（单位四元数表示"无旋转"，不会引入意外的几何变换）。此行为与 GLM 1.0.3 的零轴处理一致——GLM 内部通过 `normalize(zero)` 传播零值后，cross(zero, q) = 0 导致最终旋转退化为原 q，但因 normalize 自身返回零向量，实际计算路径存在数值不确定性。仓颉实现采用显式零值检测（`length(axis) <= T(0)`）直接返回单位四元数，行为更确定。测试 `testRotateZeroAxis` 验证此行为 |

---

按拓扑依赖排序，分四批实施。每批的内部文件可并行编码。

### 第一批（无函数库内部依赖）

| 文件 | 操作 | 前置依赖 | 测试 |
|------|------|---------|------|
| common.cj | 替换 stub → 完整实现 | 阶段一二三类型就绪 | 为每个标量函数编写 3 个测试用例（正常值、边界值、NaN/Inf 传播）；向量版本测试 3 组逐分量验证 |
| exponential.cj | 新建完整实现 | 阶段一二三类型就绪 | pow/exp/log/exp2/log2/sqrt/inversesqrt 各 3 用例（含零值、负值边界、大输入值溢出）；inversesqrt(0) 验证返回 +Inf |
| stdmath_shim.cj | 新增私有工具模块（glm.detail 内部） | 阶段一二三类型就绪。作为 common.cj/exponential.cj 的编译期前置依赖——exponential.cj 所有函数通过 stdmath_shim.cj 包装层调用 std.math，common.cj 的 frexp/ldexp 也依赖 shim 的 powT/logT。需在 common.cj 和 exponential.cj 编码之前或同时完成 | 每个包装函数 1 个编译验证（确认 Float16/Float32/Float64 三种泛型实例化均可编译通过）；Float16 溢出行为交叉验证 |
| ext/scalar_common.cj | 新建完整实现 | common.cj（可延后传递依赖） | 每个函数 1~2 用例；fmin/fmax 需包含 NaN 输入验证；iround/uround 含正/负/零边界 |

### 第二批（依赖第一批的函数库）

| 文件 | 操作 | 前置依赖 | 测试 |
|------|------|---------|------|
| trigonometric.cj | 替换 stub → 完整实现 | 阶段一二三类型就绪，stdmath_shim.cj（第一批） | 每个三角函数 3 用例（正常值、零值、极值）；acos/asin 包含越界输入验证（确认返回 NaN 而非抛异常）；radians/degrees 互逆验证 |
| matrix.cj (determinant/inverse) | 替换 stub → 完整实现 | 阶段二矩阵类型就绪 | 每种矩阵尺寸各 3 用例（单位阵、一般矩阵、奇异矩阵）；奇异矩阵验证 NaN/Inf 传播而非异常抛出的行为 |
| ext/vector_common.cj | 新建完整实现 | core 函数库就绪 | 对标 scalar_common 测试模式，每种函数选一个代表向量维度验证逐分量正确性 |

### 第三批（依赖前两批的函数库）

| 文件 | 操作 | 前置依赖 | 测试 |
|------|------|---------|------|
| geometric.cj | 替换 stub → 完整实现 | exponential.cj（sqrt）, common.cj | length/dot 公式验证 + normalizc 零向量保护验证（Vec1 NaN vs Vec2~Vec4 零向量）+ reflect/refract/faceforward 各 2 组 |
| ext/matrix_transform.cj | 替换 stub → 完整实现 | geometric.cj, trigonometric.cj | identity 无变换验证 + translate/rotate/scale 逆操作验证 + shear 矩阵形状验证 + lookAt 系族（eye=center 退化场景） |
| ext/matrix_projection.cj | 替换 stub → 完整实现 | trigonometric.cj | project/unProject 互逆验证（ZO/NO 各一组）+ pickMatrix 选区验证 |
| ext/matrix_clip_space.cj | 替换 stub → 完整实现 | common.cj, geometric.cj | ortho/perspective/frustum 各选一个典型签名做互逆验证；LH 与 RH 变体对称性验证 |
| ext/quaternion_common.cj (mix/slerp) | 补齐 stub → 完整实现 | trigonometric.cj, geometric.cj, common.cj | mix 边界（a=0/a=1/越界 clamp）+ slerp 插值序列连续性 + slerp(k) 扩展参数 k 验证 |
| ext/quaternion_transform.cj (rotate) | 补齐 stub → 完整实现 | trigonometric.cj | 零轴返回单位四元数 + 90° 旋转再逆旋转恢复原始方向 |
| ext/quaternion_trigonometric.cj (angle/angleAxis) | 补齐 stub → 完整实现 | trigonometric.cj | angle(angleAxis(θ, axis)) = θ 互逆验证 + 零角/零轴边界 |

### 第四批（gtc/ 扩展函数库）

| 文件 | 操作 | 前置依赖 | 测试 |
|------|------|---------|------|
| gtc/matrix_transform.cj | 替换 stub → 完整实现 | ext/matrix_transform, ext/matrix_projection, ext/matrix_clip_space, geometric, trigonometric, matrix(detail) | 64 个函数抽样验证（每系族选 1~2 个）+ _slow 变体与常规版本输出一致验证 + gtc 与 ext 同名函数输出一致验证（重点覆盖 lib.cj 第 23 行修改涉及的 translate/rotate/scale/shear/lookAt/lookAtRH/lookAtLH 的 gtc↔ext 行为等价性） |
| gtc/matrix_inverse.cj | 新建完整实现 | matrix.cj (determinant) | affineInverse(inverseTranspose(m)) × transpose(m) = I 恒等式验证 |
| gtc/matrix_access.cj | 新建完整实现 | 矩阵类型定义 | row/column 互逆验证（row(column(m)) = m 对非方阵的维度约束） |
| gtc/packing.cj | 新建完整实现 | core 函数库 | pack→unpack→pack 还原验证 + 边界值（0/1/-1/NaN/Inf 在 packUnorm/packSnorm 中的 clamp 行为） |
| gtc/noise.cj | 新建完整实现 | core 函数库 | perlin/simplex 各维度输出范围检查（噪声值应在 [-1,1] 或 [0,1] 内）+ 周期性噪声的首尾连续验证 |
| gtc/random.cj | 新建完整实现 | core 函数库 | linearRand 统计分布均匀性（大样本均值/方差验证）+ gaussRand 均值/标准差验证 + 线程安全并发吞吐 |
| gtc/type_precision.cj | 新建完整实现 | Vec/Mat/Quat 类型 | 编译验证（确认所有别名可正确解析为对应的具体类型实例化） |
| gtc/ulp.cj | 新建完整实现 | FloatingPoint<T> 接口 | next_float(1.0) - 1.0 = 2^-23（Float32）验证 + float_distance(x, next_float(x)) = ±1 + ulp(Inf/NaN/零值) 边界 |
| gtc/round.cj | 新建完整实现 | common.cj | round/ceil/floorPowerOfTwo 各 3 用例（零值、2 的幂、非 2 的幂）+ roundMultiple 倍数边界验证 + NaN/Inf/零值/负数输入行为验证 |

### lib.cj 更新（所有批次完成后）

在 lib.cj 末尾追加以下 public import（增量追加），但需修改现有 lib.cj 第 23 行。

**lib.cj 第 23 行修改**：
- 修改前：`public import glm.gtc.{identity, translate, rotate, rotate_slow, scale, scale_slow, shear, shear_slow, lookAt, lookAtRH, lookAtLH}`
- 修改后：`public import glm.gtc.{identity, rotate_slow, scale_slow, shear_slow}`
- 解释：从 gtc 的 public import 中删除 `translate/rotate/scale/shear/lookAt/lookAtRH/lookAtLH`，改由下方 `public import glm.ext.{...}` 统一导入。`identity/rotate_slow/scale_slow/shear_slow` 保留在原行，因为这些符号在 ext 层不存在对应实现。gtc 层内部通过 `public import` 从 ext 转发这些函数，确保通过 `glm.gtc` 包路径调用时仍可访问。

```cangjie
// Phase 4 — core 函数库完整实现替换（已有 import 自动生效，无需新增）
// Phase 4 — common.cj 函数族导出（min/max/abs/floor/mix/clamp 等，供下游消费者使用）
public import glm.detail.{abs, sign, floor, ceil, trunc, round, roundEven, fract, mod, modf,
    min, max, clamp, mix, step, smoothstep, isnan, isinf,
    floatBitsToInt, floatBitsToUint, intBitsToFloat, uintBitsToFloat,
    fma, frexp, ldexp}
// Phase 4 — exponential.cj 导出
public import glm.detail.{pow, exp, log, exp2, log2, sqrt, inversesqrt}
// Phase 4 — geometric.cj 导出（Vec 版几何函数，与 ext 版通过参数类型区分）
public import glm.detail.{dot, cross, normalize, length, distance, reflect, refract, faceforward}
// Phase 4 — matrix.cj 导出（determinant/inverse，与 ext.inverse 参数类型不同无歧义）
public import glm.detail.{determinant, inverse}
// Phase 4 — ext/scalar_common.cj 与 ext/vector_common.cj 导出
// NOTE: ext.min/max（3/4 输入）与 core.min/max（2 输入）参数个数不同可区分；
//       ext.clamp（1 输入纹理环绕版）与 core.clamp（3 输入）参数个数不同可区分；
//       其余函数（fmin/fmax/fclamp/repeat/mirrorClamp/mirrorRepeat/iround/uround）名称唯一无冲突
public import glm.ext.{min, max, fmin, fmax, fclamp, clamp, repeat, mirrorClamp, mirrorRepeat, iround, uround}
// Phase 4 — ext 扩展函数库（仅导入 gtc 未覆盖的符号，避免命名冲突）
public import glm.ext.{translate, rotate, scale, shear, lookAt, lookAtRH, lookAtLH}
// NOTE: perspective/ortho/frustum/perspFov 已由 gtc/matrix_transform 模块通过
//       lib.cj 第 24-27 行导入，此处避免重复导入防止命名冲突。
// Phase 4 — gtc 新模块
public import glm.gtc.{affineInverse, inverseTranspose}
public import glm.gtc.{row, column}
public import glm.gtc.{packUnorm1x8, packUnorm2x8, packUnorm4x8, packUnorm1x16, packUnorm2x16, packUnorm4x16,
    unpackUnorm1x8, unpackUnorm2x8, unpackUnorm4x8, unpackUnorm1x16, unpackUnorm2x16, unpackUnorm4x16,
    packSnorm1x8, packSnorm2x8, packSnorm4x8, packSnorm1x16, packSnorm2x16, packSnorm4x16,
    unpackSnorm1x8, unpackSnorm2x8, unpackSnorm4x8, unpackSnorm1x16, unpackSnorm2x16, unpackSnorm4x16,
    packHalf1x16, packHalf2x16, packHalf4x16,
    unpackHalf1x16, unpackHalf2x16, unpackHalf4x16,
    packDouble2x32, unpackDouble2x32}
public import glm.gtc.{perlin1D, perlin2D, perlin3D, perlin4D, simplex1D, simplex2D, simplex3D, simplex4D}
public import glm.gtc.{linearRand, gaussRand}
public import glm.gtc.{next_float, prev_float, float_distance, ulp}
public import glm.gtc.{roundPowerOfTwo, ceilPowerOfTwo, floorPowerOfTwo, roundMultiple, ceilMultiple, floorMultiple}
// Phase 4 — gtc/type_precision.cj 高精度类型别名导出
// 下游消费者通过 glm::fvec2/dvec3/imat4x4/fquat 等路径访问高精度类型别名。
// 这些别名在 glm.gtc.type_precision 包级定义，通过 public import 暴露给用户。
public import glm.gtc.{fvec1, fvec2, fvec3, fvec4, dvec1, dvec2, dvec3, dvec4,
    ivec2, ivec3, ivec4, uvec2, uvec3, uvec4,
    i8vec2, i8vec3, i8vec4, u8vec2, u8vec3, u8vec4,
    i16vec2, i16vec3, i16vec4, u16vec2, u16vec3, u16vec4,
    i32vec2, i32vec3, i32vec4, u32vec2, u32vec3, u32vec4,
    i64vec2, i64vec3, i64vec4, u64vec2, u64vec3, u64vec4,
    hvec1, hvec2, hvec3, hvec4,
    fmat2, fmat3, fmat4, fmat2x2, fmat2x3, fmat2x4, fmat3x2, fmat3x3, fmat3x4, fmat4x2, fmat4x3, fmat4x4,
    dmat2, dmat3, dmat4, dmat2x2, dmat2x3, dmat2x4, dmat3x2, dmat3x3, dmat3x4, dmat4x2, dmat4x3, dmat4x4,
    fquat, dquat, hquat}
```

**关于 `mix` 命名冲突的处理**：
- `glm.detail.common.cj` 定义 `mix(x, y, a)`（标量和 Vec 版本的线性插值，`T <: Number<T>` 约束）
- `glm.ext` 在阶段三已导出 `mix`（四元数版本的线性混合，已有 lib.cj 第 14 行）
- 两者签名（参数类型、数量）不同。仓颉支持函数重载（已验证 H6），编译器可基于参数类型自动区分。具体而言：
  - `detail.mix(x: T, y: T, a: T)` 作用于标量/向量类型，约束 `T <: Number<T>`
  - `ext.mix(x: Quat<T, Q>, y: Quat<T, Q>, a: T)` 作用于四元数类型
  - 调用时编译器根据参数类型选择正确版本，无需额外消歧措施

**关于 `exp`/`log`/`pow`/`sqrt` 命名冲突的处理**：
- `glm.detail.exponential.cj` 定义 `exp(v)`（标量和 Vec 版本，`T <: FloatingPoint<T>` 约束）
- `glm.ext` 在阶段三已导入 `exp/log/pow/sqrt`（四元数版本，来自 ext/quaternion_exponential.cj，第 16 行）
- 与 `mix` 类似，两者参数类型不同（标量/向量 vs 四元数），仓颉函数重载可自动区分
- 编码阶段需验证：当调用 `exp(vecOfFloat)` 时，编译器正确选择 detail 版本而非 ext 版本（ext 版本为 stub，编译通过但运行时报错）。验证项：新增验证项确认 `exp(Vec3<Float32, PackedHighp>)` 正确匹配 detail 版本
- **后备方案**：若重载决议出现编译错误，回退为在 `glm` 包级定义转发函数，通过显式包路径消除歧义（见 D23）

#### lib.cj 编译验证步骤（所有批次完成后，与 lib.cj 修改同级）

编码团队完成全部 4 批次编码后，需执行以下编译验证以确认 lib.cj 导入配置正确：

1. **编译验证**：`cjpm build` 确认 lib.cj 全部 public import 可编译通过，无符号重复或歧义错误
2. **重载决议验证**：为关键跨包同名函数编写最小调用用例——
   - `mix(vec, vec, float)` 确认匹配 detail 版本
   - `mix(quat, quat, float)` 确认匹配 ext 版本
   - `exp(vec)` 确认匹配 detail 版本而非 ext 的 stub 版本
   - `log/pow/sqrt` 同理确认匹配 detail 版本
   - `translate(mat, vec)` / `perspective(...)` 确认 gtc 与 ext 统一入口处无歧义
3. **lib.cj 第 23 行修改验证**：验证 `public import glm.gtc.{identity, rotate_slow, scale_slow, shear_slow}` 可正确解析，且 `translate/rotate/scale/shear/lookAt/lookAtRH/lookAtLH` 通过 `glm.ext` 导入后通过 `glm.gtc` 包路径仍可访问（gtc 转发的行为等价性）

此验证归入实施规划中「所有批次完成后」条目，与 lib.cj 修改同级。注意此验证应在自动化 CI 流水线中作为独立检查项存在，与各批次的功能测试分离。

---

## 9. 与已有阶段的集成方式

### 9.1 对阶段三的反馈影响

阶段三的以下设计约束在本阶段将自然解除：

1. **Quat×Vec3/Quat×Vec4 从抛 stub 变为正常**：geometric.cj 的 `cross` 函数完成完整实现后，这些运算符内部调用 `cross` 不再抛 stub 异常，自动切换至正常旋转计算路径。无需修改 `type_quat.cj` 文件。

2. **slerp/mix 从 ❌ 不可用变为可用**：ext/quaternion_common.cj 的 slerp 和 mix 函数在 trigonometric.cj（acos/sin/cos）和 geometric.cj（cross/clamp）就绪后完成实现，四元数插值能力完整可用。

3. **rotate 从 stub 变为可用**：ext/quaternion_transform.cj 的 rotate 函数依赖 trigonometric.cj 的 sin/cos，完成实现后可用。

4. **gtc/matrix_transform.cj 从 stub 变为可用**：其 64 个函数中，每个函数的数学公式直接使用已就绪的 core/ext 函数库，全部解锁。
5. **angle/angleAxis 从 stub 变为可用**：ext/quaternion_trigonometric.cj 的 angle（返回旋转角度）和 angleAxis（从角度+轴构造四元数）依赖 trigonometric.cj 的 acos/sin/cos，完成实现后可用。

### 9.2 对阶段二的反向兼容

阶段二中 matrix.cj 已有 27 个真实实现（transpose/matrixCompMult/outerProduct）和 6 个 stub（determinant/inverse）。本阶段仅替换 6 个 stub，不对已有 27 个实现做任何修改，保证阶段二的验证标准不受影响。

### 9.3 对阶段一的反向兼容

本阶段不修改阶段一的任何 Vec 类型文件。所有 core/ext/gtc 函数库仅使用 Vec 类型的公开接口（构造函数、分量访问、算术运算符），不依赖阶段一内部的任何私有成员或实现细节。

### 9.4 lib.cj 导出

lib.cj 按增量追加策略更新——在现有 9-28 行（阶段二三新增）之后追加阶段四的 public import。但需修改 lib.cj 第 23 行（从 gtc 的 public import 中删除 translate/rotate/scale/shear/lookAt/lookAtRH/lookAtLH，改由 glm.ext 统一导入），以消除跨包命名冲突。详细依据见设计决策 D30。其余已有 import 行不做任何修改，确保下游消费者对阶段二三功能的调用代码不受影响。
