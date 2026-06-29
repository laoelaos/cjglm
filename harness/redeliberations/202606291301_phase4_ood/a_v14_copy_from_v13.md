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

### 本阶段不覆盖范围

| 文件 | 原因 | 当前状态 |
|------|------|---------|
| ext/quaternion_exponential.cj | GLM 1.0.3 中四元数指数/对数/幂/平方根函数（exp/log/pow/sqrt）属于极少使用的实验性功能，不在典型 GLSL 数学运算需求范围内。其实现需依赖四元数指数级数展开，数学复杂度高且使用面窄 | 保持阶段三 stub 状态（4 个函数全部抛 stub 异常） |

本阶段结束后，库中除 `ext/quaternion_exponential.cj` 的 4 个实验性函数外，无存留 stub。

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
  common.cj → qualifier, setup（泛型约束依赖）
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
- **Vec2~Vec4 normalize 的零值行为**：对于 Vec2 及以上维度，设置保护分支：当 `lengthSq == T(0)` 时直接返回零向量，跳过除法。此保护与 §5 错误表一致
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
  - `shear(m, p, l_x, l_y, l_z)`：剪切变换矩阵，返回 `Mat4x4<T, Q>`，约束 `T <: FloatingPoint<T>, Q <: Qualifier`
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
- `mix(x, y, a)`：实现为 `x * (T(1) - a) + y * a`（四元数线性混合），但需注意阶段三的 mix 已存在但为 stub——本阶段直接使用 GLM 1.0.3 的四元数 mix 公式。需使用 `T(Float64(1)) - a` 避免 T(1) 构造问题。此函数可能需要 common.cj 的 clamp 来确保 a 在 [0,1] 内（与阶段三 lerp 的 assert 策略不同）。
- `slerp(x, y, a)`：实现为球面线性插值。公式使用 `cosOmega = clamp(dot(x, y), -T(1), T(1))` 后通过 `acos(cosOmega)`（依赖 trigonometric.cj acos）获取角度，`sinOmega = sin(omega)`（依赖 trigonometric.cj sin），再构造 `(sin((T(1)-a)*omega) / sinOmega) * x + (sin(a*omega) / sinOmega) * y`。退化判定条件：当 `sinOmega < epsilon<T>()` 时退化为 lerp（使用 `epsilon<T>()` 返回 T 类型的机器 epsilon，避免 sinOmega 接近零时分母放大数值误差）。
  - 注：slerp 中 clamp dot 到 [-1,1] 是数值稳定性措施（浮点误差可能导致 dot 略微越界），不影响 §5 中"acos 函数自身不做 clamp"的策略
- `slerp(x, y, a, k)`：扩展球面插值（额外参数 k 控制插值曲线的形状/扭曲），实现参考 GLM 1.0.3 源码。
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
  - `func shear_slow<T, Q>(m: Mat4x4<T, Q>, p: T, l_x: T, l_y: T, l_z: T): Mat4x4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier`：与 `shear` 功能相同，实现路径使用非线性角度计算构造剪切矩阵。GLM 1.0.3 中 `shear_slow` 使用 `tan` 计算剪切因子，而 `shear` 使用更直接的几何公式
  - 这三个 `_slow` 函数在 ext 层不存在对应实现，需在 gtc 层独立实现（不遵循"gtc 委托 ext"的模式）
- **GTC 与 EXT 的委托关系**：GLM 1.0.3 的 `gtc/matrix_transform.hpp` 是纯聚合头文件（仅 `#include` ext 层的三个头文件：`ext/matrix_transform.hpp`、`ext/matrix_projection.hpp`、`ext/matrix_clip_space.hpp`，另有一空 `.inl`）。gtc 层本身不定义独立函数，大部分委托给 ext 层（除 `rotate_slow`/`scale_slow`/`shear_slow` 三个 _slow 变体需在 gtc 层独立实现外）。仓颉实现中，`gtc/matrix_transform.cj` 同样应为委托层角色——通过 `public import` 从 ext 层重新导出函数签名，或直接编写转发函数。此决策使 gtc 层作为稳定公共 API 面（用户入口）与 ext 层作为实现细节分离：编码阶段可独立演进 ext 层实现而不影响 gtc 层的 API 契约
- 每个函数内部的数学公式与 GLM 1.0.3 实现一致，使用 Mat4x4 列主序存储

**为什么不是 core 而是 gtc**：GLM 1.0.3 中 `matrix_transform.hpp` 位于 `gtc/` 子目录，属于"稳定但非 core"的扩展函数库。保持此归属确保与 GLM 的文件组织一致。

#### gtc/matrix_inverse.cj

**角色**：矩阵逆辅助函数。

**职责**：
- `affineInverse(m)`：仿射逆矩阵（最后一行固定为 [0,0,0,1] 的 4x4 矩阵的快速求逆），计算上三角 3x3 的逆并处理平移分量
- `inverseTranspose(m)`：逆转置矩阵 `transpose(inverse(m))`，用于法线变换计算
- 约束：`T <: FloatingPoint<T>`（需要除法求逆）

#### gtc/matrix_access.cj

**角色**：行/列访问函数。

**职责**：
- `row(m, index)`：返回矩阵的第 index 行（不是数据成员存储的列！需从各列索引 index 分量构造行向量）
- `column(m, index)`：返回矩阵的第 index 列（等价于 `m[index]` 下标运算符取值版本）
- 对所有 9 个矩阵类型提供重载

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

// Perlin 周期噪声重载（4D 周期版）
func perlin4D<T, Q>(v: Vec4<T, Q>, period: Vec4<T, Q>): T where T <: FloatingPoint<T>, Q <: Qualifier
```
- 实现参考 GLM 1.0.3 `detail/_noise.hpp`（`_noise.hpp` 第 1~81 行，定义 `mod289`、`permute`、`taylorInvSqrt`、`fade` 辅助函数）和 `gtc/noise.inl`（第 1~807 行，定义 `grad4`、`perlin`、`simplex` 系列）的算法，映射为仓颉代码
- **存储机制**：GLM 1.0.3 不使用静态排列表或梯度向量数组。排列表通过 `permute(x) = mod289(((x * 34) + 1) * x)` 函数计算产生；梯度向量通过 `grad4` 函数中的数学运算动态生成。仓颉实现亦采用纯算法方式，无需包级常量数组。所有辅助函数（`mod289`/`permute`/`taylorInvSqrt`/`fade`/`grad4`）作为 `gtc/noise.cj` 的私有（private）包级函数存在，非公共 API
- **工作量评估**：算法迁移以数学公式直译为主，约 250~300 行有效代码。复杂度集中在 4D Perlin 和 4D Simplex 的索引计算，需注意仓颉 Vec4 类型的分量访问语法差异

#### gtc/random.cj

**角色**：随机数生成函数。

**职责**：
- `linearRand(min, max)`：均匀分布随机数（标量和向量版本）
- `gaussRand(mean, stddev)`：高斯分布随机数
- **随机数引擎管理**：使用仓颉 `std.random.Random` 作为底层随机数源。引擎采用 `ThreadLocal<Random>` 线程本地存储策略——每个线程持有独立的 `Random` 实例，通过仓颉 `ThreadLocal<T>`（来自 `core` 包，已验证可用，见 H5）管理，避免加锁争用
  - **初始化时机**：在 `linearRand`/`gaussRand` 首次被调用时以当前系统时间的 Unix 毫秒时间戳为种子创建 `Random` 实例（惰性初始化），存入 `ThreadLocal<Random>`。后续调用直接从 `ThreadLocal.get()` 获取实例并调用 `nextFloat64()` / `nextGaussianFloat64()` 等方法推进状态
  - **竞态保护**：`ThreadLocal<T>` 保证每个线程独立存储，无共享状态，无需加锁。初始化时线程间不存在竞态——如果两个线程同时首次调用，各自独立创建 `Random` 实例，可能因并发得到相同种子值，但后续随机数序列的推进过程天然隔离
  - **种子生成策略**：默认使用 `DateTime.now().toUnixMillisecond() ^ Thread.currentThread().id` 作为种子组合，以降低线程间种子碰撞概率（异或运算将线程 ID 混入时间戳，使同一毫秒内不同线程的种子差异化）。此策略降低了碰撞概率但不能完全消除（若不同毫秒的线程 ID 与时间戳异或后恰巧相等，仍可能碰撞）。此简化策略已足够，因后续随机数序列的推进过程天然隔离（线程独立引擎），不影响数值分布的质量
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

#### gtc/ulp.cj

**角色**：ULP（Units in the Last Place）浮点比较函数。

**职责**：
- `next_float(x: Float32): Float32` / `next_float(x: Float64): Float64`：返回大于 x 的下一个可表示浮点数
- `prev_float(x: Float32): Float32` / `prev_float(x: Float64): Float64`：返回小于 x 的上一个可表示浮点数
- `float_distance(x: Float32, y: Float32): Int32` / `float_distance(x: Float64, y: Float64): Int64`：返回 x 和 y 之间可表示浮点数的个数（以 ULP 为单位）。Float32 版本返回 Int32，Float64 版本返回 Int64（对应各自的位宽）
- `ulp(x: Float32): Float32` / `ulp(x: Float64): Float64`：返回 x 的 ULP 大小
- 约束：具体类型重载（Float32 + Float64），不使用泛型约束
- **实现路径**：内部使用 `toBits()`/`fromBits()` 操作浮点位模式。`next_float(x)` 将 x 的位模式增加 1（正数）或减少 1（负数）；`ulp(x)` 对归一化正数 x 返回 `T.fromBits(x.toBits() + 1u) - x`（即 `next_float(x) - x`），对非归一化数直接返回最小正数
- **为什么是具体类型重载而非泛型**：`FloatingPoint<T>` 接口不提供 `toBits()`/`fromBits()` 方法——这些位操作方法是具体类型 `Float32`/`Float64`/`Float16` 的实例方法，不在泛型接口中。因此无法在 `T <: FloatingPoint<T>` 约束下通过泛型代码实现 ULP 函数。改为具体类型重载后，每个版本可直接调用 `x.toBits(): UInt32/UInt64` 和 `T.fromBits(bits)` 操作位模式，实现路径清晰且可编码

#### gtc/round.cj

**角色**：浮点数舍入函数（与 common.cj 的 round/floor/ceil 等互补，侧重 2 的幂相关舍入）。

**职责**：
- `roundPowerOfTwo(x)`：舍入到最近的 2 的幂
- `ceilPowerOfTwo(x)`：向上舍入到最近的 2 的幂
- `floorPowerOfTwo(x)`：向下舍入到最近的 2 的幂
- `roundMultiple(x, multiple)`：舍入到最近的倍数
- `ceilMultiple(x, multiple)` / `floorMultiple(x, multiple)`
- 约束：`T <: FloatingPoint<T>`（部分函数可支持 `T <: Number<T>`）

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

## 5. 错误处理策略

### 错误分类

| 场景 | 策略 | 说明 |
|------|------|------|
| **奇异矩阵求逆** | 由 IEEE 754 浮点运算自然决定（1/det → Inf，Inf × 0 → NaN），最终可能产生 NaN 或 Inf 填充的矩阵 | 与 GLM 1.0.3 行为一致，不抛出异常，调用方需自行通过行列式检查矩阵的奇异性 |
| **Vec2~Vec4 零向量 normalize** | 返回零向量 | 保护分支：`if lengthSq == T(0) return zero-vec`。与 GLM 1.0.3 行为一致（GLSL 10.1.1：if length(x)==0, result is undefined；此处保守返回零向量） |
| **Vec1 零向量 normalize** | 返回 NaN | Vec1 使用 `v * inversesqrt(dot(v,v))` 通式，不设保护分支。零值时 `T(0) * +Inf = NaN`（IEEE 754 NaN 传播），与 GLM 1.0.3 的 `compute_normalize` 实现一致 |
| **acos/asin 输入超出 [-1,1]** | 返回 NaN | `std.math.acos`/`std.math.asin` 在越界时抛出 `IllegalArgumentException`（与 GLM 行为不符）。`glm.detail.acos`/`glm.detail.asin` 内部做 `x < -T(1) || x > T(1)` 前置检查，越界时直接返回 `T.getNaN()`，仅合法输入委托 `std.math`。此行为与 GLM 1.0.3（委托 std::acos 的 NaN 返回行为）一致。例外：slerp 实现中调用 acos 前对 dot 结果做 clamp（§3.2 · ext/quaternion_common.cj），这是调用方的数值稳定措施而非 acos 函数的契约 |
| **mod 浮点参数** | 无异常抛出 | 使用 `x - y * floor(x / y)` 公式，自然传播 NaN/Inf |
| **`inversesqrt` 零值输入** | 返回 `+Inf` | `inversesqrt(0)` = `T(1) / sqrt(0)` = `T(1) / 0` = `+Inf`（IEEE 754 自然浮点运算结果，已验证 H4）。GLM 1.0.3 文档声明输入范围为 `[0, +inf)`，零值行为是 IEEE 754 标准衍生，不额外增加保护逻辑 |
| **本阶段定义范围内的 stub 未替换** | 不存在 | 本阶段完成后，除 §1.5 列明的 ext/quaternion_exponential.cj 外无存留 stub |

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
| D16 | **geometric.cj 约束从 `Number<T>`（阶段三 stub）收紧为 `FloatingPoint<T>`（本阶段）** | 阶段三的 `geometric.cj` stub 为快速编译而使用了宽松的 `Number<T>` 约束。本阶段替换为完整实现后，`normalize/length/distance/reflect/refract` 均需要 `sqrt`（仅浮点类型可用），因此约束收紧为 `FloatingPoint<T>`。`dot` 作为纯乘加运算保持 `Number<T>` 约束。此变更为向后不兼容——原通过 `Number<T>` 编译通过的整数实例化将在本阶段编译报错 |
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
| D28 | **`gtc/random.cj` 种子生成使用 `时间戳 ^ 线程 ID` 组合，标注已知碰撞风险** | 使用 `DateTime.now().toUnixMillisecond() ^ Thread.currentThread().id` 作为种子组合，降低同毫秒内多线程的种子碰撞概率。此策略不能完全消除碰撞（不同毫秒的线程 ID 与时间戳异或后恰巧相等仍可能碰撞），但实践中碰撞概率极低。标注为"已知的种子碰撞风险，与 GLM 1.0.3 行为一致，当前设计接受此风险"——GLM 1.0.3 内部维护全局引擎也不提供种子控制，仓颉实现的增强策略已优于 GLM 原始行为 |
| D29 | **`exponential.cj` 的 `pow` 通过 `stdmath_shim.cj` 包装层统一实现** | `std.math.pow` 仅提供 `(Float64, Float64): Float64` 签名。`stdmath_shim.cj` 提供 `powT<T>(base, exp): T where T <: FloatingPoint<T>`，内部实现为 `(std.math.pow(Float64(base), Float64(exp)) as T).getOrThrow()`。Float16/Float32/Float64 三种浮点类型经统一的双向转型路径处理，无特殊回退分支。`ldexp` 的 `x * powT(T(2), T(exp))` 同理。此模式与 `sqrtT`/`expT`/`logT` 等其他 shim 包装器一致。<br><br>**Float16 溢出行为差异说明**：`(result as T).getOrThrow()` 模式在 `T = Float16` 且中间值超过 ±65504 时抛异常（`Float64 → Float16` 转型溢出），而 GLM 1.0.3 返回 ±Inf。此差异在 Float16 低精度图形场景中触发概率极低（中间值超出 Float16 范围需要非常大的输入值），本设计接受此差异。若编码阶段需消除此差异，可为 `stdmath_shim.cj` 添加 Float16 溢出保护：`if result > Float16.MAX → T.getInf()`。<br><br>**Float32 非规格化数精度损失说明**：`ldexp` 的 `x * powT(T(2), T(exp))` 在 `T = Float32` 且 `x` 为非规格化数时，中间值 `powT(T(2), T(exp))` 与 `x` 的乘运算可能导致额外的舍入误差（相比 GLM 1.0.3 的 C++ `std::ldexp` 使用更高精度中间值）。此精度损失在非规格化数参与的计算中触发概率低（典型图形计算极少涉及非规格化数），当前设计接受此差异。 |
| D30 | **`lib.cj` 中 translate/rotate/scale/shear/lookAt/lookAtRH/lookAtLH 跨包导入冲突通过修改现有行解决** | 现有 lib.cj 第 23 行从 gtc 导入 translate/rotate/scale/shear/lookAt/lookAtRH/lookAtLH。本阶段 §8 的 ext 导入（第 910 行）同样导入这些符号，造成跨包重复导入冲突。<br><br>**推荐方案**：修改现有 lib.cj 第 23 行，从 gtc 的 public import 中删除 translate/rotate/scale/shear/lookAt/lookAtRH/lookAtLH，改由 §8 的 `public import glm.ext.{translate, rotate, scale, shear, lookAt, lookAtRH, lookAtLH}` 统一提供。gtc/matrix_transform.cj 内部通过 `public import` 从 ext 转发这些函数，确保通过 `glm::` 命名空间（即 `glm.gtc` 包路径）调用时仍可访问。此方案使 ext 层作为实现细节，gtc 层作为稳定 API 面，符合 GLM 1.0.3 的 gtc 委托层角色。<br><br>**验证结果**：经仓颉语言文档确认（H6），函数重载可基于参数类型自动区分。ext 和 gtc 中同名函数签名为同一实现（gtc 转发至 ext），无重载歧义。此方案已在 D23 的同符号导入分析框架中得到支撑。 |

---

按拓扑依赖排序，分四批实施。每批的内部文件可并行编码。

### 第一批（无函数库内部依赖）

| 文件 | 操作 | 前置依赖 |
|------|------|---------|
| common.cj | 替换 stub → 完整实现 | 阶段一二三类型就绪 |
| exponential.cj | 新建完整实现 | 阶段一二三类型就绪 |
| ext/scalar_common.cj | 新建完整实现 | common.cj（可延后传递依赖） |

### 第二批（依赖第一批的函数库）

| 文件 | 操作 | 前置依赖 |
|------|------|---------|
| trigonometric.cj | 替换 stub → 完整实现 | 阶段一二三类型就绪（独立于第一批，与第一批可并行） |
| matrix.cj (determinant/inverse) | 替换 stub → 完整实现 | 阶段二矩阵类型就绪 |
| ext/vector_common.cj | 新建完整实现 | core 函数库就绪 |

### 第三批（依赖前两批的函数库）

| 文件 | 操作 | 前置依赖 |
|------|------|---------|
| geometric.cj | 替换 stub → 完整实现 | exponential.cj（sqrt）, common.cj |
| ext/matrix_transform.cj | 替换 stub → 完整实现 | geometric.cj, trigonometric.cj |
| ext/matrix_projection.cj | 替换 stub → 完整实现 | trigonometric.cj |
| ext/matrix_clip_space.cj | 替换 stub → 完整实现 | common.cj, geometric.cj |
| ext/quaternion_common.cj (mix/slerp) | 补齐 stub → 完整实现 | trigonometric.cj, geometric.cj, common.cj |
| ext/quaternion_transform.cj (rotate) | 补齐 stub → 完整实现 | trigonometric.cj |
| ext/quaternion_trigonometric.cj (angle/angleAxis) | 补齐 stub → 完整实现 | trigonometric.cj |

### 第四批（gtc/ 扩展函数库）

| 文件 | 操作 | 前置依赖 |
|------|------|---------|
| gtc/matrix_transform.cj | 替换 stub → 完整实现 | ext/matrix_transform, ext/matrix_projection, ext/matrix_clip_space, geometric, trigonometric, matrix(detail) |
| gtc/matrix_inverse.cj | 新建完整实现 | matrix.cj (determinant) |
| gtc/matrix_access.cj | 新建完整实现 | 矩阵类型定义 |
| gtc/packing.cj | 新建完整实现 | core 函数库 |
| gtc/noise.cj | 新建完整实现 | core 函数库 |
| gtc/random.cj | 新建完整实现 | core 函数库 |
| gtc/type_precision.cj | 新建完整实现 | Vec/Mat/Quat 类型 |
| gtc/ulp.cj | 新建完整实现 | FloatingPoint<T> 接口 |
| gtc/round.cj | 新建完整实现 | common.cj |

### lib.cj 更新（所有批次完成后）

在 lib.cj 末尾追加以下 public import（增量追加，不修改已有行，但需修改现有 lib.cj 第 23 行：从 gtc 的 public import 中删除 translate/rotate/scale/shear/lookAt/lookAtRH/lookAtLH 这些符号，改从 glm.ext 统一导入。gtc 层内部通过 public import 从 ext 转发这些函数，确保 gtc API 面不受影响）：

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
    hvec2, hvec3, hvec4,
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

lib.cj 按增量追加策略更新——在现有 9-28 行（阶段二三新增）之后追加阶段四的 public import。已有 import 行不做任何修改，确保下游消费者对阶段二三功能的调用代码不受影响。

---

## 修订说明（v1 → v2）

| 审查意见 | 修改措施 |
|---------|---------|
| P1 — 矛盾声明："全部 stub 替换完成" vs. `quaternion_exponential.cj` 保留为 stub | 在 §1 新增 §1.5「本阶段不覆盖范围」章节，明确列出 `ext/quaternion_exponential.cj` 及其排除理由（GLM 实验性功能，使用面极窄）；修改 §1 概述的"全部 stub 文件均被替换"为"本阶段定义范围内的 stub 文件均被替换"；同步更新 §5 错误处理策略表格的最后一行 |
| P2 — 错误处理策略与具体设计自相矛盾：acos 输入是否 clamp | 新增 D17 设计决策条目，阐明 slerp 中 clamp dot 是调用方数值稳定措施（因浮点误差导致 dot 略微越界），与 acos 函数自身"不做 clamp"的契约属于不同职责层面，二者不矛盾；在 §4.5 slerp 场景契约中增加注释说明；在 §5 acos 行增加"例外"说明 |
| P3 — `gtc/type_precision.cj` 未定义具体别名范围 | 在 §3.3 type_precision.cj 描述中补充完整别名清单，按向量/矩阵/四元数分类，标注引用 GLM 1.0.3 对应头文件的行号范围（~50-320 行），预估别名总数约 100 个 |
| P4 — 引用未定义的 `Common<T>` 约束 | 将 §3.1 common.cj 协作关系中 "所有使用 `Common<T>` 约束的泛型函数" 修改为 "所有使用 `common.cj` 函数族的泛型函数" |
| P5 — `T(0)/T(1)` 字面量写法与 §1.4 确立的 `T(Float64(n))` 约定不一致 | 在 §1.4 标题改为「约束继承与表示约定」，增加说明：文档公式中使用 `T(n)` 简写表示，代码层面应替换为 `T(Float64(n))` |
| P6 — `mod` 函数约束策略与现有 stub 及 GLSL 行为不一致 | 新增 D15 设计决策条目，记录 `mod` 选择 `FloatingPoint<T>` 约束的理由（GLM 1.0.3 语义、整数 mod 通过 `%` 运算符替代），并建议编码阶段可按需补充整数重载 |
| P7 — `geometric.cj` 约束收紧未显式标记为向后不兼容变更 | 新增 D16 设计决策条目，记录 geometric.cj 约束从阶段性 stub 的 `Number<T>` 收紧为 `FloatingPoint<T>` 的完整理由，并标注此变更属于向后不兼容 |
| P8 — `floatBitsToInt/uintBitsToFloat` 等位运算函数的实现路径未确认 | 更新 D12 设计决策条目，将实现路径从 "CFFI 或原生位操作 API" 修正为直接引用仓颉标准库原生 API：`Float32.toBits(): UInt32`、`Float32.fromBits(bits: UInt32): Float32`（以及 Float16/Float64 对应版本），并建议新增验证项确认这些 API 的可用性 |

## 修订说明（v2 → v3）

| 审查意见 | 修改措施 |
|---------|---------|
| P1（严重）— `inversesqrt` 零值输入边界条件未处理 | 在 §3.1 exponential.cj 职责中补充 `inversesqrt(0)` 返回 `+Inf` 的行为说明（IEEE 754 自然结果）；在 §5 错误处理策略表中新增 `inversesqrt` 零值输入行；新增 D20 设计决策条目记录选择理由 |
| P2（严重）— `geometric.cj` `Vec1 normalize` 语义未定 | 在 §3.1 geometric.cj 中将 Vec1 normalize 描述从"退化为 T(1) 或 sign 语义"修正为"使用通式 `v * inversesqrt(dot(v, v))`，非零时返回 sign(v.x)，零值时返回 NaN"，与 GLM 1.0.3 的 `compute_normalize` 实现一致 |
| P3（严重）— `trigonometric.cj` 协作关系事实错误：`sqrt` 不属于 trigonometric.cj | 修正 §3.1 trigonometric.cj 协作关系：移除"被 geometric.cj（normalize 的 sqrt）调用"，改为说明 geometric.cj 依赖 exponential.cj 的 sqrt；同步修正 §3.1 geometric.cj 协作关系以注明依赖 exponential.cj（sqrt）；修正 §8 实施批次中 geometric.cj 的前置依赖 |
| P4（严重）— `lib.cj` 更新存在命名冲突：`perspective/ortho/frustum` 同时从 ext 和 gtc 导入 | 在 §8 lib.cj 更新中删除 `perspective/ortho/frustum/perspFov` 从 ext 的导入行；添加注释说明这些符号已由 gtc 模块通过 lib.cj 第 24-27 行导入 |
| P5（严重）— `common.cj` 函数族未从 `lib.cj` 导出，且 `mix` 存在命名冲突隐患 | 在 §8 lib.cj 更新代码块中新增 `glm.detail` 的 common.cj 函数族导出（包含 `abs/sign/floor/ceil/.../mix/clamp` 等全部公共函数）和 exponential.cj 导出；新增「关于 `mix` 命名冲突的处理」说明段落，分析 detail 与 ext 版本签名差异并得出仓颉函数重载可自动区分、无需额外消歧的结论 |
| P6（一般）— `gtc/random.cj` 随机数状态管理与 §6"纯函数"声明矛盾 | 在 §3.3 random.cj 中补充随机数引擎管理策略：使用 `ThreadLocal<Random>` 线程本地存储，系统时间初始化种子；更新 §6 并发设计为 random.cj 增加例外说明；新增 D19 设计决策条目记录选择理由 |
| P7（一般）— `gtc/noise.cj` 排列表与梯度向量的存储/初始化方式未涉及 | 在 §3.3 noise.cj 中补充排列表和梯度向量的存储机制说明：GLM 1.0.3 使用纯算法方式（`permute` 函数动态计算、`grad4` 函数动态生成），无需静态常量数组；标注 GLM 源码行号范围（`_noise.hpp` 第 1-81 行、`noise.inl` 第 1-807 行）；评估工作量约 250-300 行；新增 D21 设计决策条目 |
| P8（一般）— `matrix.cj inverse` 的 Mat4x4 实现策略未决 | 在 §3.1 matrix.cj 中将 Mat4x4 inverse 策略从"高斯消元或余子式展开"明确为"余子式展开（cofactor expansion）"，引用 GLM 1.0.3 源码行号；新增 D18 设计决策条目记录选择理由 |
| P9（一般）— `ext/quaternion_trigonometric.cj` 的 `angle`/`angleAxis` stub 未纳入阶段四范围 | 在 §1 新增「本阶段补齐范围补充」章节说明纳入理由；在 §2 模块划分中将 quaternion_trigonometric.cj 从"沿用阶段三"修正为带 ★ 的补齐文件；在 §3.2 新增 `ext/quaternion_trigonometric.cj (angle/angleAxis 补齐)` 设计描述；在 §8 实施批次第三批中新增该文件条目；在 §9.1 对阶段三反馈影响中增加第 5 点；新增 D22 设计决策条目 |

## 修订说明（v3 → v4）

| 审查意见 | 修改措施 |
|---------|---------|
| P1（严重）— Vec1 normalize 零输入行为自相矛盾 | §3.1 geometric.cj 中将 Vec1 normalize 与 Vec2~Vec4 的零值行为明确分离描述：Vec1 使用通式 `v * inversesqrt(dot(v,v))`，零值时 `T(0) * +Inf = NaN`（IEEE 754 NaN 传播）；Vec2~Vec4 设置保护分支直接返回零向量。§5 错误表将"零向量 normalize"拆为两行：Vec2~Vec4 返回零向量 + Vec1 返回 NaN |
| P2（严重）— `inversesqrt(0)` 返回 +Inf 依赖 CangJie 浮点除零行为未经验证 | 在 §1.7 新增 H4 确定性声明，记录"仓颉浮点类型遵循 IEEE 754 标准，浮点除零返回 ±Inf"已通过仓颉原始文档和编译验证确认；在 §3.1 exponential.cj 和 D20 中引用 H4 作为支撑证据；修正 D20 措辞从"假设"改为"已验证" |
| P3（严重）— lib.cj 中 `mix` 和 `exp/log/pow/sqrt` 的跨包同符号导入存在编译风险 | 在 §1.7 新增 H6 确定性声明（仓颉函数重载基于参数类型自动区分）；在 §8 lib.cj 更新中补充 `exp/log/pow/sqrt` 命名冲突分析段落，详细分析 detail 版本（标量/向量类型）和 ext 版本（四元数类型）的参数差异，得出无歧义结论；新增 D23 设计决策条目汇总冲突分析和后备方案（显式限定名转发函数） |
| P4（一般）— gtc/packing.cj 设计粒度不足 | 在 §3.3 packing.cj 中替换简略描述为完整函数签名清单，按 packUnorm/unpackUnorm/packSnorm/unpackSnorm/packHalf/unpackHalf/packDouble2x32/unpackDouble2x32 八组分类列出每个函数的仓颉签名（参数类型、返回类型），并标注 2-3 个典例函数的实现公式 |
| P5（一般）— gtc/random.cj 线程本地存储方案缺少可行性验证 | 在 §1.7 新增 H5 确定性声明（`ThreadLocal<T>` 可用且不要求 `Send`/`Sync` 约束，已通过仓颉并发编程文档确认）；在 §3.3 random.cj 中补充初始化时机（惰性初始化）、竞态保护（ThreadLocal 天然隔离，无需加锁）、种子确定性（系统时间戳）的完整策略；在 D19 中补充备选方案 `Mutex<Random>` |
| P6（一般）— ext/matrix_transform.cj 与 ext/matrix_clip_space.cj 实际函数范围未明确 | 在 §3.2 中将原简略函数列表替换为完整函数签名清单（ext/matrix_transform.cj 的 6 个函数 + ext/matrix_clip_space.cj 的 46 个函数，按系族分类），标注对标 GLM 1.0.3 对应头文件的行号范围；新增 D24 设计决策条目记录函数范围对标策略 |

## 修订说明（v4 → v5）

| 审查意见 | 修改措施 |
|---------|---------|
| P1（严重）— modf/frexp/ldexp 签名设计完全缺失 | 在 §3.1 common.cj 约束策略后新增「modf/frexp/ldexp 签名设计」段落，定义 modf 返回 (T, T) 元组、frexp 返回 (T, Int64) 元组、ldexp 实现为 x \* pow(T(2), T(exp))；补充 modf 负数语义说明（trunc 基值）；新增 D25 设计决策条目 |
| P2（严重）— 奇异矩阵求逆行为在三处自相矛盾 | 统一三处（§3.1 matrix.cj、§4.3 核心场景、§5 错误表）的行为描述为：奇异矩阵求逆结果由 IEEE 754 浮点运算自然决定（1/det → Inf，Inf × 0 → NaN），最终可能产生 NaN 或 Inf 填充的矩阵，函数不抛出异常；新增 D26 设计决策条目 |
| P3（严重）— mod 约束当前状态描述与代码事实不符 | 修正 §3.1 common.cj mod 约束描述为 `Integer<T>`（当前实际约束）；修正 D15 条目描述为 `Integer<T>` 并标注向 `FloatingPoint<T>` 收紧为向后不兼容变更；保留当前 `Integer<T>` 约束不变，编码阶段可按需补充浮点重载 |
| P4（一般）— trigonometric.cj 依赖图中遗漏 scalar_constants.cj | 在 §2 模块间依赖表中 trigonometric.cj 的依赖补充 `scalar_constants`（pi\<T\>() 函数，radians/degrees 使用） |
| P5（一般）— gtc/random.cj 种子初始化竞态风险评估不足 | 在 §3.3 random.cj 种子策略中改用 `DateTime.now().toUnixMillisecond() ^ Thread.currentThread().id` 组合种子以降低线程间碰撞概率；明确标注"已知的种子碰撞风险，与 GLM 1.0.3 行为一致，当前设计接受此风险"；新增 D28 设计决策条目 |
| P6（严重）— gtc/ulp.cj 泛型函数在仓颉中缺少实现路径 | 将 §3.3 ulp.cj 全部函数从 `T <: FloatingPoint<T>` 泛型约束改为 Float32/Float64 具体类型重载；补充实现路径说明（使用 toBits()/fromBits() 操作位模式）和设计理由（FloatingPoint\<T\> 接口不提供位操作方法）；新增 D27 设计决策条目 |
| 审查问题 — acos/asin 越界时 std.math.acos 抛出 IllegalArgumentException 而非返回 NaN | 在 §3.1 trigonometric.cj 实现路径中为 acos/asin 增加越界保护：`if (x < -T(1) \|\| x > T(1)) { return T.getNaN() }`，仅合法输入委托 std.math；同步修正 §5 错误表中 acos 输入的描述从"依赖 std.math.acos 的 NaN 传播"改为"返回 NaN，函数自身做越界检查"；新增 D26 设计决策条目 |

## 修订说明（v5 → v6）

| 审查意见 | 修改措施 |
|---------|---------|
| P1（严重）— ext/scalar_common.cj 职责描述与 GLM 1.0.3 事实不符 | 经查阅 GLM 1.0.3 `ext/scalar_common.hpp` 确认实际函数集（min 3/4 输入、max 3/4 输入、fmin 系、fmax 系、fclamp、纹理环绕 clamp/repeat/mirrorClamp/mirrorRepeat、iround/uround），彻底重写 §3.2 ext/scalar_common.cj 小节。新增完整 17 个函数签名映射（代码块形式分组列出，各附约束策略和实现路径）。在职责末尾补充"不包含的函数"标注，明确声明 mix/step/smoothstep 不属于此文件范围。iround/uround 返回类型声明为 Int64/UInt64（仓颉 64 位默认整数类型），并标注与 GLM C++ int/uint（32 位）的差异 |
| P2（严重）— ext/vector_common.cj 缺乏完整函数清单 | 彻底重写 §3.2 ext/vector_common.cj 小节。对标 GLM 1.0.3 `ext/vector_common.hpp` 实际内容，列出全部 20 个函数的完整签名清单（min 3/4 输入、max 3/4 输入、fmin 系列 4 个、fmax 系列 4 个、fclamp 2 个、纹理环绕 4 个、iround/uround 2 个）。每个函数标注约束策略和实现路径。新增"与 ext/scalar_common.cj 的协作"段落说明标量→向量映射关系 |
| P3（一般）— ext/matrix_clip_space.cj ortho 系族函数计数错误 | 修正 §3.2 ext/matrix_clip_space.cj ortho 系族计数从 11 改为 10（经查验 GLM 1.0.3 `ext/matrix_clip_space.hpp` 确认 10 个：2D 版 ortho + orthoLH_ZO + orthoLH_NO + orthoRH_ZO + orthoRH_NO + orthoZO + orthoNO + orthoLH + orthoRH + 6 参数版 ortho） |
| P4（一般）— gtc/matrix_transform.cj 函数总数与分项求和自相矛盾 | 修正 §3.3 gtc/matrix_transform.cj 基础变换计数从"9 个"改为"11 个"（展开 lookAt 系族为 lookAt/lookAtRH/lookAtLH 三个独立函数，identity/translate/rotate/rotate_slow/scale/scale_slow/shear/shear_slow 各计 1 个，共 11 个），使分类求和 11+10+9+9+9+7+2+6+1=64 与全文声称的 64 一致。同步将函数族枚举从简略分组改为逐个列出完整函数名。在函数族列表后新增"GTC 与 EXT 的委托关系"段落，说明 GLM 1.0.3 的 gtc/matrix_transform.hpp 是纯聚合头文件，仓颉实现中 gtc 层同样应为委托层（public import 转发），使 gtc 作为稳定 API 面与 ext 实现细节分离 |

## 修订说明（v6 v1 → v6 v2）

| 审查意见 | 修改措施 |
|---------|---------|
| 问题 1（一般）— ext/vector_common.cj 使用不存在的 `Vec<L, T, Q>` 类型，仓颉不支持整数维度泛型参数 | 在 §3.2 ext/vector_common.cj 职责开头新增「符号约定」段落，明确声明 `Vec<L, T, Q>` 是设计级速记记号，表示"对 Vec1~Vec4 各定义一个同构重载"；提供 `min` 的 4 输入重载展开为 4 个独立函数签名的完整示例；说明此约定与 §3.1 core 函数库的"为 Vec1~Vec4 各定义"文字表述等价。无 Vec1 版本的函数在展开时对应省略 |
| 问题 2（一般）— `std.math.pow` 不提供 Float16 重载导致 generic pow 和 ldexp 在 `T = Float16` 时不可行 | 在 §3.1 exponential.cj 实现路径中将 `pow` 拆分为独立说明：明确 `std.math.pow` 仅提供 Float32/Float64 重载，`T = Float16` 时使用 `exp(T(exp) * log(base))` 恒等式回退（`std.math.exp` 和 `std.math.log` 均提供 Float16 重载）；同步修正 §3.1 common.cj 中 `ldexp` 的实现路径，标注 Float16 依赖 `pow` 的 `exp` 回退路径；新增 D29 设计决策条目记录 Float16 pow 回退策略及其理由（保持 `FloatingPoint<T>` 泛型约束一致 vs. 收紧约束破坏统一性） |

## 修订说明（v6 → v7）

| 审查意见 | 修改措施 |
|---------|---------|
| P1（严重）— geometric.cj 的 Vec 几何函数未纳入 lib.cj 导出 | 在 §8 lib.cj 更新中新增 `public import glm.detail.{dot, cross, normalize, length, distance, reflect, refract, faceforward}`。确认与 `lib.cj:15` 的 `glm.ext.{dot, length, normalize, cross}`（Quat 版本）在仓颉重载解析下可自动区分——Vec 参数与 Quat 参数类型不同 |
| P2（严重）— matrix.cj 的 determinant/inverse 未纳入 lib.cj 导出 | 在 §8 lib.cj 更新中新增 `public import glm.detail.{determinant, inverse}`。确认 `detail.inverse`（Mat 参数）与 `lib.cj:14` 的 `ext.inverse`（Quat 参数）重载解析无歧义 |
| P3（严重）— ext/matrix_projection.cj 函数计数与清单不一致 | 将 §3.2 ext/matrix_projection.cj 的计数从"8"修正为"7"，与紧随的函数签名清单一致 |
| P4（一般）— Vec1 normalize 在职责清单中缺失，形成内部矛盾 | 将 §3.1 geometric.cj 的职责从"`normalize/length/distance/...`：Vec2~Vec4"拆分为"`normalize`：Vec1~Vec4"和"`length/distance/...`：Vec2~Vec4"，使 normalize 职责范围与后续 Vec1 零值行为描述一致 |
| P5（一般）— ext/scalar_common.cj 和 ext/vector_common.cj 的公共函数未纳入 lib.cj 导出 | 在 §8 lib.cj 更新中新增 `public import glm.ext.{min, max, fmin, fmax, fclamp, clamp, repeat, mirrorClamp, mirrorRepeat, iround, uround}`。ext.min/max（3/4 输入）与 core.min/max（2 输入）参数个数不同可区分；ext.clamp（1 输入纹理环绕版）与 core.clamp（3 输入）参数个数不同可区分；其余函数名称唯一无冲突 |
| P6（一般）— slerp 退化条件阈值未定义 | 在 §3.2 ext/quaternion_common.cj 的 slerp 描述中补充退化判定条件：`if (sinOmega < epsilon<T>())` 时退化为线性插值；同步更新 D09 设计决策条目，替换原"（或类似经验值）"模糊表述为具体判定条件 |
| P7（一般）— mod 浮点重载的处理策略未明确 | 更新 §3.1 common.cj 的 mod 约束描述，补充说明 `scalar_vec_ops.cj` 已有 12 个具体浮点类型向量重载与泛型 `Integer<T>` mod 通过重载共存；更新 D15 设计决策条目，明确编码阶段补充标量浮点 `mod` 重载作为可选增强，`Integer<T>` 约束维持不变 |

## 修订说明（v7 → v2）

| 审查意见 | 修改措施 |
|---------|---------|
| 问题1（严重）— std.math 函数 Float16/Float32 重载不可用的设计假设错误 | ① §1.4 将"std.math 提供 Float16/Float32/Float64 三重重载"替换为"std.math Float64 委托模式"，说明 std.math 仅提供 (Float64):Float64 签名，引入 `stdmath_shim.cj` 私有工具模块集中提供泛型包装函数（模式：`(x as Float64).getOrThrow() → std.math → (result as T).getOrThrow()`）。② §2 模块划分的 `glm.detail` 包中新增 `stdmath_shim.cj`（无 ★），依赖关系表中新增 `stdmath_shim.cj → std.math`（唯一直接依赖 std.math 的文件）以及函数库对 shim 的依赖。③ §3.1 exponential.cj 实现路径中所有函数改为通过 `stdmath_shim.cj` 包装层调用（`expT`/`logT`/`sqrtT`/`powT` 等），删除"已验证 Float16/Float32/Float64 三重载"和"Float16 pow 使用 exp(b*log(a)) 回退"的不准确描述。④ §3.1 trigonometric.cj 实现路径中核心三角函数改为通过 `stdmath_shim.cj` 包装层委托。⑤ §3.1 geometric.cj 协作关系中将"或直接委托 std.math.sqrt"修正为"通过 `stdmath_shim.cj` 包装层间接调用 `std.math.sqrt`"。⑥ §4.1 核心场景中将"调用 std.math 的对应浮点函数"修正为"通过 `stdmath_shim.cj` 包装层调用 std.math 的对应浮点函数" |
| 问题2（一般）— D29 回退路径自洽性问题 | 重写 D29 设计决策条目：将 `pow` 的实现路径从 `exp(T(exp) * log(base))` 恒等式回退改为和所有其他函数一致的 `stdmath_shim.cj` `powT` 包装函数（内部 `(std.math.pow(Float64(base), Float64(exp)) as T).getOrThrow()`）。`ldexp` 同样通过 `powT` 实现。无特殊 Float16 回退分支 |

## 修订说明（v8 → v9）

| 审查意见 | 修改措施 |
|---------|---------|
| P1（严重）— lib.cj 中 translate/rotate/scale/shear/lookAt/lookAtRH/lookAtLH 跨包重复导入冲突未解决 | 在 §8 lib.cj 更新说明中将"增量追加，不修改已有行"修正为：需修改现有 lib.cj 第 23 行，从 gtc 的 public import 中删除这些符号，改由 §8 的 ext import 统一提供。新增 D30 设计决策条目，记录跨包导入选型理由和验证结果，引用 H6（仓颉函数重载规则）作为可行性支撑 |
| P2（严重）— frexp 零值/NaN/Inf/非规范化数边缘场景实现策略缺失 | 在 §3.1 common.cj 的 frexp 签名设计中补充边缘场景策略：采用数学分解加前置检查方案。NaN→(NaN,0)、Inf→(Inf,0)、zero→(0,0)；合法值使用 exponent = floor(log2(abs(x))) + mantissa = x / pow(T(2), T(exponent))。非规范化数精度损失列入已知行为差异 |
| G1（一般）— ext/quaternion_common.cj 依赖链遗漏 glm.detail.common | 在 §2 模块间依赖表中将 `quaternion_common.cj → ... + ext/scalar_constants` 修正为 `... + glm.detail.common + ext/scalar_constants`（mix/slerp 依赖 common.cj 的 clamp/mix 标量函数） |
| G2（一般）— gtc/noise.cj 缺少完整函数签名 | 在 §3.3 noise.cj 中将简略的"perlin 系列/simplex 系列"描述替换为完整的 8 个函数签名清单（perlin1D~perlin4D、simplex1D~simplex4D），格式参考 packing.cj 的代码块样式。明确 Perlin 系列返回标量 T，Simplex 1D 返回标量 T，Simplex 2D/3D/4D 返回对应向量 |
| G3（一般）— ext/scalar_common.cj 的 iround/uround 负数输入行为偏离 GLM 且仅以行内注释记录 | 将 iround/uround 实现路径从 `Int64(x + T(0.5))`（负数语义偏差）改为 `Int64(stdmath_shim.roundT(x))`/`UInt64(stdmath_shim.roundT(x))`，委托 stdmath_shim.cj 的 roundT 包装函数。消除负数输入时的语义偏差，与 GLM `int(round(x))` 行为一致。同步更新注释删除"非负输入"限制 |
| G4（一般）— stdmath_shim.cj 在 Float16 上的溢出行为差异未记录 | 在 §1.4 stdmath_shim.cj 模式说明中新增已知行为差异标注：`(result as T).getOrThrow()` 在 T=Float16 且中间值超过 ±65504 时抛异常，而 GLM 返回 ±Inf。同步在 D29 中补充 Float16 溢出行为差异说明，声明本设计接受此差异并标注溢出保护可选方案 |
| G5（一般）— mod 函数标量浮点重载的设计决策仍为"可选"，留下不确定性 | 将 §3.1 common.cj 中 mod 浮点重载由"补充标量浮点版本的可选方案在编码阶段按需决策"升级为"推荐实现 3 个标量浮点 mod 重载"（Float32/Float64/Float16），使用 `x - y * floor(x / y)` 公式。同步更新 D15 设计决策条目，将标量浮点 mod 重载由"可选增强"升级为"推荐实现" |

## 修订说明（v9 → v10）

| 审查意见 | 修改措施 |
|---------|---------|
| P1（严重）— `ldexp` 的 Float16 回退描述与 D29 及 `pow` 设计自相矛盾 | §3.1 common.cj 中 `ldexp` 的 Float16 回退描述从"依赖 `pow` 的 `exp(T(exp) * log(T(2)))` 回退路径"替换为与 D29 一致的表述："所有浮点类型（Float16/Float32/Float64）均通过 `stdmath_shim.cj` 的 `powT` 包装函数统一实现，无需特殊回退分支。" |
| P2（一般）— `ext/quaternion_transform.cj` rotate 的依赖关系与 GLM 事实不符，且遗漏 normalize axis 步骤 | ① §2 模块间依赖表：`glm.ext.quaternion_geometric（cross）` 改为 `glm.detail.geometric（length）`。② §3.2 rotate 职责描述中补充 axis normalize 步骤：先对 axis 做 normalize（依赖 geometric.cj length 做归一化检查，零轴返回单位四元数），再使用归一化后的轴向量构造旋转四元数。 |
| P3（一般）— `ext/scalar_common.cj` 的 `mirrorRepeat` 缺少具体实现公式 | §3.2 mirrorRepeat 注释补全为完整公式描述并标注 GLM 1.0.3 源码行号，格式与其他三个纹理环绕函数一致。 |

## 修订说明（v10 → v11）

| 审查意见 | 修改措施 |
|---------|---------|
| P1（严重）— `lib.cj` 中 gtc/noise.cj 的 public import 引用了不存在的函数名 `{perlin, simplex}` | 将 `public import glm.gtc.{perlin, simplex}` 替换为 `{perlin1D, perlin2D, perlin3D, perlin4D, simplex1D, simplex2D, simplex3D, simplex4D}`，与 §3.3 noise.cj 的 8 个实际函数签名一一对应 |
| P2（严重）— `lib.cj` 中 gtc/packing.cj 的 public import 仅导出了约 6/32 个函数且未提供设计理由 | 方案 A：将 packing 导出扩展为全部 32 个函数（packUnorm/unpackUnorm/packSnorm/unpackSnorm/packHalf/unpackHalf/packDouble2x32 各系族全部导出），消除子集选择不确定性 |
| P3（严重）— `lib.cj` 遗漏 gtc/round.cj 的 `ceilMultiple`/`floorMultiple` 导出 | 在 `public import glm.gtc.{...}` 中追加 `ceilMultiple` 和 `floorMultiple`，与 §3.3 round.cj 职责清单一致 |
| P4（严重）— `lib.cj` 遗漏 gtc/type_precision.cj 的类型别名导出 | 新增 `public import glm.gtc.{fvec1, fvec2, ..., fquat, dquat, hquat}` 完整导出约 100 个高精度类型别名，包含向量/矩阵/四元数三大类，并补充下游消费者访问路径说明 |
| P5（严重）— `gtc/matrix_transform.cj` 的"全部委托给 ext 层"声明与实际情况不符 | 将"全部委托给 ext 层"修正为"大部分委托给 ext 层，rotate_slow/scale_slow/shear_slow 需在 gtc 层独立实现"——这三个函数在 ext 层不存在对应实现 |
| P6（一般）— geometric.cj 对 sqrt 的依赖描述与依赖关系表不一致 | 统一两处描述（§3.1 trigonometric.cj 协作关系 + §3.1 geometric.cj 协作关系）：将"依赖 exponential.cj 的 sqrt"修正为"通过 stdmath_shim.cj 包装层调用 sqrt"，与 §2 模块间依赖表一致 |

## 修订说明（v11 → v12）

| 审查意见 | 修改措施 |
|---------|---------|
| P1（中等 — 事实错误）frexp 指数计算公式错误：`floor(log2(abs(x)))` 产生 mantissa 在 [1,2) 范围与声明 [0.5,1) 矛盾 | §3.1 common.cj 中 `frexp` 的指数计算公式由 `exponent = floor(log2(abs(x)))` 修正为 `exponent = floor(log2(abs(x))) + 1`，使 mantissa 归一化至 [0.5,1) 范围 |
| P2（中等 — 事实错误）ulp(x) 公式 `T.fromBits(T(1).toBits() - T(1))` 类型不匹配且仅计算 ulp(1.0) 而非与 x 指数相关的 ulp(x) | §3.3 gtc/ulp.cj 实现路径中 `ulp(x)` 公式由 `T.fromBits(T(1).toBits() - T(1))` 修正为 `T.fromBits(x.toBits() + 1u) - x`（即 `next_float(x) - x`），正确反映与 x 指数相关的 ULP 大小 |
| P3（轻微 — 边缘场景遗漏）uround 负数输入与 GLM 行为不一致：仓颉 `@OverflowThrowing` 默认策略下 `UInt64(negative_float)` 抛出 `ArithmeticException`，而 GLM 模运算回绕 | §3.2 ext/scalar_common.cj 在 `uround` 签名后新增「uround 负数输入行为声明」段落，明确选型：接受仓颉默认 `@OverflowThrowing` 行为（抛出异常），理由为负数输入 `uround` 属语义错误，异常有助于及早捕获 |
| P4（轻微 — 完整性遗漏）ext/quaternion_trigonometric.cj 未出现在 §2 glm.ext 依赖表中 | §2 模块间依赖 glm.ext 依赖清单中新增条目：`quaternion_trigonometric.cj angle/angleAxis → glm.detail.trigonometric（acos/sin/cos）+ glm.detail.common（clamp）` |

## 修订说明（v12 → v13）

| 审查意见 | 修改措施 |
|---------|---------|
| 问题 1（中等 — 依赖表事实错误）：§2 依赖表遗漏 gtc/matrix_transform.cj 对 glm.ext 的依赖 | §2 模块间依赖第 193 行将 `matrix_transform.cj → glm.detail（Mat4x4, Vec{2,3,4}, trigonometric, geometric, matrix）` 修正为 `matrix_transform.cj → glm.detail（Mat4x4, Vec{2,3,4}, trigonometric, geometric, matrix）+ glm.ext（委托 ext/matrix_transform、ext/matrix_projection、ext/matrix_clip_space）`，与 §3.3 第 516 行的声明一致 |
| 问题 2（轻微 — 依赖表遗漏）：ext/matrix_clip_space.cj 缺少 trigonometric 依赖 | §2 模块间依赖第 186 行将 `matrix_clip_space.cj → glm.detail（Mat4x4 + common/geometric）` 修正为 `matrix_clip_space.cj → glm.detail（Mat4x4 + common/geometric + trigonometric）`，该文件 46 个函数中 27 个使用 tan，与同层次其他 ext/ 文件表述一致 |

## 修订说明（v13 → v14）

| 审查意见 | 修改措施 |
|---------|---------|
| P0-1（严重）— `ext/scalar_common.cj` 的 `mirrorRepeat` 公式与 GLM 1.0.3 不符（使用 `clamp(Floor, 0, 1)` 应为 `mod(Floor, T(2))`） | §3.2 ext/scalar_common.cj 中 `mirrorRepeat` 的实现公式从 `Abs → Floor → Rest → clamp(Floor, 0, 1) → mix(Rest, 1-Rest, Mirror%2>=1)` 修正为 `Abs → Floor → mod(Floor, T(2)) → Rest → Clamp + Rest → mix(Rest, T(1)-Rest, Mirror>=T(1))`，与 GLM 1.0.3 源码 `ext/scalar_common.inl` 第 78~86 行一致 |
| P0-2（严重）— `gtc/noise.cj` Simplex 噪声 2D/3D/4D 返回类型错误声明为 `Vec2`/`Vec3`/`Vec4`，应返回标量 `T` | §3.3 gtc/noise.cj 中 `simplex2D`/`simplex3D`/`simplex4D` 返回类型从 `Vec2<T,Q>`/`Vec3<T,Q>`/`Vec4<T,Q>` 修正为 `T`，与 GLM 1.0.3 签名一致。同步补充 Perlin 周期噪声重载 `perlin4D(v, period)` |
| P1-1（中等）— `ext/matrix_projection.cj` 使用单一泛型 `T` 约束所有参数，viewport 应使用独立类型参数 | §3.2 ext/matrix_projection.cj 全部 7 个函数签名中为 viewport 引入独立类型参数 `U <: Number<U>`，与 obj/proj/model 的 `T <: FloatingPoint<T>` 解耦 |
| P1-2（中等）— `ext/matrix_projection.cj` 函数签名缺少参数类型、返回类型和约束 | §3.2 ext/matrix_projection.cj 完整重写，以代码块形式给出全部 7 个函数的完整仓颉签名（参数类型、返回类型、泛型约束），格式参照 `ext/scalar_common.cj` |
| P1-3（中等）— `ext/matrix_clip_space.cj` 46 个函数仅按系族列出函数名 | §3.2 ext/matrix_clip_space.cj 为每个系族给出一个典例函数的完整签名（参数类型、返回类型、泛型约束），并标注变体差异（LH/RH 手系、ZO/NO Z 范围） |
| P2-1（中等）— `gtc/matrix_transform.cj` 的 `rotate_slow`/`scale_slow`/`shear_slow` 缺少独立签名和实现路径说明 | §3.3 gtc/matrix_transform.cj 在函数族列表与 GTC-EXT 委托关系段落之间新增 `_slow` 变体说明子段落，逐一给出 `rotate_slow`/`scale_slow`/`shear_slow` 的完整仓颉签名、约束和实现路径差异 |
| P2-2（轻微）— `gtc/type_precision.cj` 缺失 `hvec1` 别名 | §3.3 gtc/type_precision.cj 别名清单中将 `hvec2/hvec3/hvec4` 修正为 `hvec1/hvec2/hvec3/hvec4` |
| P2-3（轻微）— `ldexp` 未讨论 Float32 非规格化数精度损失 | §3.1 common.cj `ldexp` 签名后新增「Float32 非规格化数精度损失说明」段落；D29 设计决策条目同步补充 Float32 非规格化数精度损失说明 |
