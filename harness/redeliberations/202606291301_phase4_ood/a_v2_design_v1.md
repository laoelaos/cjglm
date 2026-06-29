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
| ext/matrix_transform.cj | 矩阵变换扩展（translate/rotate/scale 等） | 包级泛型函数 |
| ext/matrix_projection.cj | 投影矩阵扩展（perspective/frustum/ortho 等） | 包级泛型函数 |
| ext/matrix_clip_space.cj | 裁剪空间矩阵扩展（ortho 系族） | 包级泛型函数 |
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
- **std.math 重载覆盖**：std.math 提供 Float16/Float32/Float64 三重重载的函数可直接调用，无需额外类型转换

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

无新增 P0 假设。函数的泛型约束策略（公共函数使用 `Number<T>`、三角/几何函数使用 `FloatingPoint<T>`）均已在前序阶段实践验证。

---

## 2. 模块划分

### 包组织

```
package glm.detail              — 核心实现层（修改文件以 ★ 标记）
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
  ├── scalar_constants.cj        — 沿用阶段三（epsilon/pi/cos_one_over_two）
  └── ...（其他阶段一二三文件不变）

package glm.ext                 — 扩展函数库（修改/新建文件以 ★ 标记）
  ├── scalar_common.cj ★         — 新建完整实现
  │                               （scalar 版本的 min/max/clamp/mix/step/smoothstep 等补充重载）
  ├── vector_common.cj ★         — 新建完整实现
  │                               （向量公共运算函数）
  │                               
  ├── matrix_transform.cj ★      — 替换 stub 为完整实现
  │                               （translate/rotate/scale 等矩阵变换扩展）
  ├── matrix_projection.cj ★     — 替换 stub 为完整实现
  │                               （perspective/frustum/ortho 等投影矩阵扩展）
  ├── matrix_clip_space.cj ★     — 替换 stub 为完整实现
  │                               （ortho 系族裁剪空间矩阵）
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
  │                               （packUnorm/packSnorm/packHalf/pack/unpack 等）
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
  exponential.cj → std.math（pow/exp/log/sqrt 等）
  trigonometric.cj → std.math + qualifier（FloatingPoint<T> 约束 + Vec 重载）
  geometric.cj → qualifier + std.math（FloatingPoint<T> 约束 + Vec 重载）
  matrix.cj → type_mat2x2 ~ type_mat4x4（已存在）
  scalar_constants.cj → setup（已存在）

glm.ext
  scalar_common.cj → glm.detail.common（复用 min/max/clamp 等）
  vector_common.cj → glm.detail（Vec 类型 + common 函数）
  matrix_transform.cj → glm.detail（Mat4x4, Vec3, Vec4 + common/geometric/trigonometric）
  matrix_projection.cj → glm.detail（Mat4x4 + trigonometric/geometric）
  matrix_clip_space.cj → glm.detail（Mat4x4 + common/geometric）
  quaternion_common.cj mix/slerp → glm.detail.trigonometric + glm.detail.geometric + ext/scalar_constants
    （mix 依赖 common.cj 的 mix 标量函数；slerp 依赖 trigonometric.cj 的 acos/sin/cos）
  quaternion_transform.cj rotate → glm.detail.trigonometric（sin/cos） + glm.ext.quaternion_geometric（cross）

glm.gtc（单向依赖 glm.detail，无循环依赖）
  matrix_transform.cj → glm.detail（Mat4x4, Vec{2,3,4}, trigonometric, geometric, matrix）
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
  - `mod`：`T <: FloatingPoint<T>`（浮点取模使用 `x - y * floor(x / y)` 公式）
  - `floatBitsToInt/floatBitsToUint/intBitsToFloat/uintBitsToFloat`：具体类型重载（仅 Float32/Int32/UInt32）

**为什么是包级函数而非成员函数**：GLSL 规范将此定义为自由函数，且多个函数在 Vec 类型上按分量独立操作。包级函数签名对调用方透明（`min(a, b)` 而非 `a.min(b)`），与 GLM C++ API 一致。

**协作关系**：
- 被 trigonometric.cj（acos/atan → clamp）、geometric.cj（reflect/refract → clamp/step）、ext 和 gtc 函数库广泛调用
- 所有使用 `common.cj` 函数族的泛型函数通过 `Number<T>`/`FloatingPoint<T>` 接口操作

#### exponential.cj

**角色**：提供 GLSL 8.2 节定义的指数函数。

**职责**：
- 包含 `pow(base, exponent)`、`exp(v)`、`log(v)`、`exp2(v)`、`log2(v)`、`sqrt(v)`、`inversesqrt(v)`
- 约束策略：全部函数使用 `T <: FloatingPoint<T>`
- 实现路径：直接委托 `std.math.pow/exp/log/exp2/log2/sqrt` 等标准库函数
- `inversesqrt` 实现为 `T(1) / sqrt(x)`，非直接委托。当 `x == 0` 时，`sqrt(0) = 0` 导致 `T(1) / 0`，IEEE 754 浮点运算自然返回 `+Inf`，与 GLM 1.0.3 行为一致（GLM 文档声明输入范围为 `[0, +inf)`，零值返回 Inf 是 IEEE 754 自然结果而非显式保护）

**协作关系**：被 trigonometric.cj（无直接依赖，均为独立浮点函数）和 gtc 函数引用。

#### trigonometric.cj

**角色**：提供 GLSL 8.1 节定义的角度与三角函数。

**职责**：
- 替换阶段三的 stub 为完整实现
- 包含：`radians/degrees/sin/cos/tan/asin/acos/atan/atan2/sinh/cosh/tanh/asinh/acosh/atanh`
- 约束策略：全部使用 `T <: FloatingPoint<T>`
- 实现路径：直接委托 `std.math.sin/cos/tan/asin/acos/atan/atan2/sinh/cosh/tanh/asinh/acosh/atanh`
- `radians(x)` 实现为 `x * pi<T>() / T(180)`，`degrees(x)` 实现为 `x * T(180) / pi<T>()`
- 标量版本 + Vec1~Vec4 逐分量版本，每类 5 个重载

**协作关系**：被 ext/quaternion_transform.cj（rotate 的 sin/cos）、ext/quaternion_common.cj（slerp 的 acos/sin）和 gtc/matrix_transform.cj（perspective 的 cot）调用。geometric.cj 的 normalize 函数依赖 exponential.cj 的 sqrt（或直接委托 std.math.sqrt），而非 trigonometric.cj。

#### geometric.cj

**角色**：提供 GLSL 8.5 节定义的几何函数。

**职责**：
- 替换阶段三的 stub 为完整实现
- 包含：`dot/cross/normalize/length/distance/reflect/refract/faceforward`
- `dot`：Vec1~Vec4 各版本，返回标量 T
- `cross`：仅 Vec3 版本，返回 Vec3<T, Q>
- `normalize/length/distance/reflect/refract/faceforward`：Vec2~Vec4（Vec1 的 normalize 使用通式 `v * inversesqrt(dot(v, v))`，与高维版本一致。非零时返回 sign(v.x) 即 ±1，零值时 `0 * Inf = NaN`，与 GLM 1.0.3 行为一致）
- 约束策略：使用 `T <: FloatingPoint<T>`（需要 sqrt），但 `dot` 放宽为 `T <: Number<T>`
- `length` 实现为 `sqrt(dot(v, v))`
- `normalize` 实现为 `v / length(v)`，零向量保护返回零向量
- `distance` 实现为 `length(p0 - p1)`
- `reflect` 实现为 `I - T(2) * dot(N, I) * N`
- `refract` 实现为使用 `eta` 和 `k = T(1) - eta*eta * (T(1) - dot(N,I)*dot(N,I))` 的条件公式
- `faceforward` 实现为条件选择：`dot(Nref, I) < 0 ? N : -N`

**协作关系**：被 ext/quaternion_geometric.cj 的 cross/length/normalize（实际调用几何库而非独立实现，消除阶段三的重复设计）、ext/quaternion_common.cj 的 slerp、gtc/matrix_transform.cj 的 lookAt 调用。normalize/length 内部依赖 `exponential.cj` 的 `sqrt`（或直接委托 `std.math.sqrt`），非反向依赖 `trigonometric.cj`。

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
- 奇异矩阵行为：当行列式接近零时返回零矩阵或全 NaN（与 GLM 行为一致，不额外抛出异常）

### 3.2 ext 扩展函数库（glm.ext）

#### ext/scalar_common.cj

**角色**：提供标量公共函数的补充重载（与 core common.cj 互补）。

**职责**：包含 `min/max/clamp/mix/step/smoothstep` 的额外重载形式，如 Bool 选择器版本的 mix。直接委托 core common.cj 的对应标量函数。

#### ext/vector_common.cj

**角色**：提供向量公共运算函数（非逐分量的向量级操作）。

**职责**：提供向量级别的公共运算，如 `min(u, v)` 返回逐分量最小值构成的向量（与 core common.cj 的 min 重叠——core 已提供 Vec 逐分量版本）。本文件主要提供 GLM `ext/vector_common.hpp` 中定义的补充函数。

#### ext/matrix_transform.cj

**角色**：矩阵变换扩展函数（translate/rotate/scale 等，替代阶段三的 stub）。

**职责**：
- 替换 stub 为完整实现
- `translate(m, v)`：构造平移矩阵 `[I, p; 0, 1]` 并左乘 m
- `rotate(m, angle, axis)`：构造旋转矩阵（依赖 trigonometric.cj 的 sin/cos 和 geometric.cj 的 cross/normalize）并左乘 m
- `scale(m, v)`：构造缩放矩阵并左乘 m
- 约束：`T <: FloatingPoint<T>, Q <: Qualifier`，返回 `Mat4x4<T, Q>`

#### ext/matrix_projection.cj

**角色**：投影矩阵扩展函数（perspective/frustum 等，替代阶段三的 stub）。

**职责**：
- 替换 stub 为完整实现
- `perspective(fovy, aspect, zNear, zFar)`：透视投影矩阵（cot(fovy/2) 计算依赖 trigonmetric.cj 的 tan）
- 约束：`T <: FloatingPoint<T>`，返回 `Mat4x4<T, Q>`

#### ext/matrix_clip_space.cj

**角色**：裁剪空间矩阵扩展函数（ortho 系族，替代阶段三的 stub）。

**职责**：
- 替换 stub 为完整实现
- `ortho(left, right, bottom, top)`：正交投影矩阵
- 约束：`T <: FloatingPoint<T>`，返回 `Mat4x4<T, Q>`

#### ext/quaternion_common.cj（mix/slerp 补齐）

**角色**：补齐阶段三中因依赖 geometric/trigonometric stub 而未能实现的函数。

**职责**：
- `mix(x, y, a)`：实现为 `x * (T(1) - a) + y * a`（四元数线性混合），但需注意阶段三的 mix 已存在但为 stub——本阶段直接使用 GLM 1.0.3 的四元数 mix 公式。需使用 `T(Float64(1)) - a` 避免 T(1) 构造问题。此函数可能需要 common.cj 的 clamp 来确保 a 在 [0,1] 内（与阶段三 lerp 的 assert 策略不同）。
- `slerp(x, y, a)`：实现为球面线性插值。公式使用 `cosOmega = clamp(dot(x, y), -T(1), T(1))` 后通过 `acos(cosOmega)`（依赖 trigonometric.cj acos）获取角度，`sinOmega = sin(omega)`（依赖 trigonometric.cj sin），再构造 `(sin((T(1)-a)*omega) / sinOmega) * x + (sin(a*omega) / sinOmega) * y`。当 sinOmega 接近零时退化为 lerp。
  - 注：slerp 中 clamp dot 到 [-1,1] 是数值稳定性措施（浮点误差可能导致 dot 略微越界），不影响 §5 中"acos 函数自身不做 clamp"的策略
- `slerp(x, y, a, k)`：扩展球面插值（额外参数 k 控制插值曲线的形状/扭曲），实现参考 GLM 1.0.3 源码。
- 约束：`T <: FloatingPoint<T>, Q <: Qualifier`

**协作关系**：依赖 trigonometric.cj（acos, sin, cos）和 common.cj（clamp）。

#### ext/quaternion_transform.cj（rotate 补齐）

**角色**：补齐阶段三中因依赖 trigonometric stub 而未能实现的 rotate 函数。

**职责**：
- `rotate(q, angle, axis)`：绕轴旋转四元数。构造 `halfAngle = angle / T(2)`，计算 `sinHalf = sin(halfAngle)`（依赖 trigonometric.cj sin），`cosHalf = cos(halfAngle)`（依赖 trigonometric.cj cos），返回四元数 `(sinHalf * axis.x, sinHalf * axis.y, sinHalf * axis.z, cosHalf) * q`（实际内部实现为单位四元数 + 旋转四元数乘法）。
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
- 函数族包含：
  - 基础变换（9 个）：`identity/translate/rotate/rotate_slow/scale/scale_slow/shear/shear_slow/lookAt` 系族
  - ortho 系族（10 个）：`ortho` 各变体
  - frustum 系族（9 个）：`frustum` 各变体
  - perspective 系族（9 个）：`perspective` 各变体
  - perspectiveFov 系族（9 个）：`perspectiveFov` 各变体
  - infinitePerspective 系族（7 个）
  - tweakedInfinitePerspective 系族（2 个）
  - 投影工具（6 个）：`project`/`unProject` 系族
  - 拾取矩阵（1 个）：`pickMatrix`
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
- 包含 `packUnorm4x8/packSnorm4x8/packUnorm2x16/packSnorm2x16/packHalf2x16` 等
- 包含对应的 `unpack*` 函数
- 约束：具体类型重载（主要涉及 Float32/UInt32/UInt16/UInt8 等）

#### gtc/noise.cj

**角色**：噪声生成函数。

**职责**：
- `perlin` 系列：Perlin 噪声（1D/2D/3D/4D）
- `simplex` 系列：Simplex 噪声（1D/2D/3D/4D）
- 实现参考 GLM 1.0.3 `detail/_noise.hpp`（`_noise.hpp` 第 1~81 行，定义 `mod289`、`permute`、`taylorInvSqrt`、`fade` 辅助函数）和 `gtc/noise.inl`（第 1~807 行，定义 `grad4`、`perlin`、`simplex` 系列）的算法，映射为仓颉代码
- **存储机制**：GLM 1.0.3 不使用静态排列表或梯度向量数组。排列表通过 `permute(x) = mod289(((x * 34) + 1) * x)` 函数计算产生；梯度向量通过 `grad4` 函数中的数学运算动态生成。仓颉实现亦采用纯算法方式，无需包级常量数组。所有辅助函数（`mod289`/`permute`/`taylorInvSqrt`/`fade`/`grad4`）作为 `gtc/noise.cj` 的私有（private）包级函数存在，非公共 API
- **工作量评估**：算法迁移以数学公式直译为主，约 250~300 行有效代码。复杂度集中在 4D Perlin 和 4D Simplex 的索引计算，需注意仓颉 Vec4 类型的分量访问语法差异

#### gtc/random.cj

**角色**：随机数生成函数。

**职责**：
- `linearRand(min, max)`：均匀分布随机数（标量和向量版本）
- `gaussRand(mean, stddev)`：高斯分布随机数
- **随机数引擎管理**：使用仓颉 `std.random.Random` 作为底层随机数源。引擎采用线程本地存储策略——每个线程持有独立的 `Random` 实例，通过仓颉 `ThreadLocal` 或类似机制管理，避免加锁争用。种子初始化策略：首次使用时以当前系统时间（Unix 毫秒时间戳）作为种子值创建 `Random` 实例
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
- `hvec2/hvec3/hvec4`（Float16 向量）

矩阵别名（每组 highp/mediump/lowp 各一）：
- `fmat2/fmat3/fmat4`、`fmat2x2/fmat2x3/fmat2x4/fmat3x2/fmat3x3/fmat3x4/fmat4x2/fmat4x3/fmat4x4`
- `dmat2/dmat3/dmat4`、`dmat2x2/dmat2x3/dmat2x4/dmat3x2/dmat3x3/dmat3x4/dmat4x2/dmat4x3/dmat4x4`

四元数别名：
- `fquat/dquat`、`hquat`

以上共约 100 个别名，覆盖 GLM 1.0.3 `gtc/type_precision.hpp` 的全部类型别名定义。

#### gtc/ulp.cj

**角色**：ULP（Units in the Last Place）浮点比较函数。

**职责**：
- `next_float(x)`：返回大于 x 的下一个可表示浮点数
- `prev_float(x)`：返回小于 x 的上一个可表示浮点数
- `float_distance(x, y)`：返回 x 和 y 之间可表示浮点数的个数（以 ULP 为单位）
- `ulp(x)`：返回 x 的 ULP 大小
- 约束：`T <: FloatingPoint<T>`

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
  3. 函数体内对每个分量调用 std.math 的对应浮点函数或使用纯算术运算
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
  3. 行列式接近零时返回零矩阵（无异常抛出）
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
| **奇异矩阵求逆** | 返回零矩阵或保留未定义值 | 与 GLM 1.0.3 行为一致，不抛出异常，调用方需自行检查行列式 |
| **零向量 normalize** | 返回零向量 | 与 GLM 1.0.3 行为一致（GLSL 10.1.1：if length(x)==0, result is undefined；此处保守返回零向量） |
| **normalize 中 sqrt 零值** | 直接返回零向量（跳过除法） | 保护分支：`if lengthSq == T(0) return zero-vec` |
| **acos 输入超出 [-1,1]** | 依赖 std.math.acos 的 NaN 传播 | acos 函数自身不做 clamp，由 std.math 自然处理。例外：slerp 实现中调用 acos 前对 dot 结果做 clamp（§3.2 · ext/quaternion_common.cj），这是调用方的数值稳定措施而非 acos 函数的契约 |
| **mod 浮点参数** | 无异常抛出 | 使用 `x - y * floor(x / y)` 公式，自然传播 NaN/Inf |
| **`inversesqrt` 零值输入** | 返回 `+Inf` | `inversesqrt(0)` = `T(1) / sqrt(0)` = `T(1) / 0` = `+Inf`（IEEE 754 自然浮点运算结果）。GLM 1.0.3 文档声明输入范围为 `[0, +inf)`，零值行为是 IEEE 754 标准衍生，不额外增加保护逻辑 |
| **本阶段定义范围内的 stub 未替换** | 不存在 | 本阶段完成后，除 §1.5 列明的 ext/quaternion_exponential.cj 外无存留 stub |

本阶段不引入新的错误类型。所有函数的错误处理行为遵循 GLM 1.0.3 的约定："不验证输入有效性，函数结果由输入决定，包括 NaN/Inf 传播"。

---

## 6. 并发设计

本阶段除 `gtc/random.cj` 外不引入新的并发机制。core/ext/gtc 函数库（不含 random.cj）均为纯函数（无副作用、不修改输入参数），天然线程安全。矩阵和向量的值语义（struct + 返回副本）确保并发计算中的隔离性。

**例外 — `gtc/random.cj`**：`linearRand` 和 `gaussRand` 需要可变状态的随机数引擎以推进随机数序列，因此非纯函数。线程安全性通过线程本地存储（`ThreadLocal<Random>`）保证——每个线程持有独立的 `Random` 实例，无共享状态，无需加锁。此例外不影响其他函数库的纯函数声明。

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
| D09 | **ext/quaternion_common.cj 的 slerp 当 sinOmega 接近零时退化为 lerp** | 与 GLM 1.0.3 行为一致。阈值选取 `epsilon<T>() * T(10)`（或类似经验值）作为 sinOmega 的零判定条件 |
| D10 | **ext/quaternion_common.cj 的 mix 使用 clamp(a, T(0), T(1)) 而非 assert** | 与阶段三存在已有实现的 lerp 的 assert 策略不同——lerp 使用 assert 断言 a 在 [0,1] 范围内，mix 使用 clamp 静默处理越界。理由：mix 的 GLSL 规范未要求 assert，且越界插值是常见用法。此决策引入两种约束策略的差异，属于有意识的设计选择，编码阶段需注意保持此差异 |
| D11 | **gtc/matrix_inverse.cj 不依赖 gtc/matrix_transform.cj，仅依赖 detail/matrix.cj** | 保持最小依赖。affineInverse 和 inverseTranspose 只需要行列式和逆运算，不需要矩阵变换函数 |
| D12 | **gtc/packing.cj 使用具体类型重载而非泛型** | 打包运算涉及位级操作和特定的数值转换（如 Float32 ↔ UInt32 的位模式转换），不适合泛型化。仓颉标准库已提供原生位操作 API：`Float32.toBits(): UInt32` 和 `Float32.fromBits(bits: UInt32): Float32`（以及 Float16/Float64 的对应版本），应使用这些原生 API 而非 CFFI |
| D13 | **gtc/noise.cj 的 Perlin/Simplex 实现直接内联算法，不依赖外部噪声库** | 仓颉标准库不提供噪声函数。噪声算法的参考实现在 GLM 1.0.3 的 `detail/_noise.hpp` 中已有完整数学定义，直接迁移 |
| D14 | **ext/matrix_transform.cj 与 gtc/matrix_transform.cj 的 translate/rotate/scale 重复** | 两者在 GLM 1.0.3 中均存在（ext 版本与 gtc 版本），ext 版本提供基础功能，gtc 版本提供更完整的手系/深度变体。编码阶段需注意 gtc 版本内部可委托 ext 版本以避免代码重复 |
| D15 | **`mod` 函数当前约束为 `FloatingPoint<T>`，未提供整数版本** | GLSL 中 `mod` 支持浮点和整数类型，但 GLM 1.0.3 的 `mod` 在 C++ 泛型中实际行为依赖浮点除法。整数取模在 GLSL 中通过 `%` 运算符实现而非 `mod` 函数。编码阶段可根据实际需求补充整数版本的 `mod` 重载，但当前设计保持 `FloatingPoint<T>` 约束以匹配 GLM 语义 |
| D16 | **geometric.cj 约束从 `Number<T>`（阶段三 stub）收紧为 `FloatingPoint<T>`（本阶段）** | 阶段三的 `geometric.cj` stub 为快速编译而使用了宽松的 `Number<T>` 约束。本阶段替换为完整实现后，`normalize/length/distance/reflect/refract` 均需要 `sqrt`（仅浮点类型可用），因此约束收紧为 `FloatingPoint<T>`。`dot` 作为纯乘加运算保持 `Number<T>` 约束。此变更为向后不兼容——原通过 `Number<T>` 编译通过的整数实例化将在本阶段编译报错 |
| D17 | **slerp 在调用 acos 前对 dot 结果做 clamp，不影响 §5 的"acos 不做 clamp"策略** | §5 的"acos 输入不做 clamp"指 trigonometric.cj 中 acos 函数自身的实现契约。slerp 中对 `dot(x, y)` 结果做 `clamp(..., -T(1), T(1))` 是调用方因浮点运算误差（归一化误差使 dot 略超 [-1,1]）而采取的数值稳定措施，两者属于不同职责层面，不矛盾 |
| D18 | **Mat4x4 inverse 选择余子式展开（cofactor expansion）** | 与 GLM 1.0.3 实现一致（`func_matrix.inl` `compute_inverse<4,4,T,Q,Aligned>` 使用显式 cofactor 公式）。高斯消元法虽在数值稳定性上等价，但 GLM 作为数学库的参考实现选择余子式展开，保持行为一致可降低交叉验证成本 |
| D19 | **`gtc/random.cj` 使用线程本地存储（ThreadLocal）管理随机数引擎** | `linearRand`/`gaussRand` 每次调用修改引擎内部状态，非纯函数。仓颉 `ThreadLocal<Random>` 确保每个线程持有独立实例，无需加锁。使用系统时间作为默认种子，与 GLM 1.0.3 的未指定种子策略一致（GLM 依赖调用方自行管理引擎状态，仓颉版本代为管理以简化 API） |
| D20 | **`inversesqrt(0)` 返回 `+Inf`，不增加零值保护分支** | 与 GLM 1.0.3 实现一致——`T(1) / sqrt(0)` 经 IEEE 754 浮点运算自然产生 `+Inf`。输入范围 `[0, +inf)` 下零值是被允许的边界值，Inf 输出是 IEEE 754 对除零的标准响应。如果增加保护分支（如返回 `T(0)` 或 `T(Inf)` 的显式写法），反而偏离了 GLM 的行为 |
| D21 | **`gtc/noise.cj` 采用纯算法实现，不使用静态排列表或梯度向量数组** | GLM 1.0.3 的噪声算法通过 `permute(x) = mod289(((x*34)+1)*x)` 函数动态计算置换，`grad4` 函数动态生成梯度向量，均无需预定义常量表。仓颉实现保持此方式，仅需 `detail/_noise.hpp` 和 `gtc/noise.inl` 中的辅助函数作为私有包级函数 |
| D22 | **`ext/quaternion_trigonometric.cj` 的 `angle`/`angleAxis` 纳入本阶段补齐** | 两函数因依赖 `trigonometric.cj`（本阶段实现）而处于 stub 状态。阶段三仅为占位 stub 而未完整实现。纳入本阶段范围后，`angle` 使用 `acos(clamp(w, -1, 1))` 公式（与 GLM 1.0.3 一致），`angleAxis` 使用 `sin/cos` 构造四元数分量 |

---

## 8. 实施批次建议

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

在 lib.cj 末尾追加以下 public import（增量追加，不修改已有行）：

```cangjie
// Phase 4 — core 函数库完整实现替换（已有 import 自动生效，无需新增）
// Phase 4 — common.cj 函数族导出（min/max/abs/floor/mix/clamp 等，供下游消费者使用）
public import glm.detail.{abs, sign, floor, ceil, trunc, round, roundEven, fract, mod, modf,
    min, max, clamp, mix, step, smoothstep, isnan, isinf,
    floatBitsToInt, floatBitsToUint, intBitsToFloat, uintBitsToFloat,
    fma, frexp, ldexp}
// Phase 4 — exponential.cj 导出
public import glm.detail.{pow, exp, log, exp2, log2, sqrt, inversesqrt}
// Phase 4 — ext 扩展函数库（仅导入 gtc 未覆盖的符号，避免命名冲突）
public import glm.ext.{translate, rotate, scale, shear, lookAt, lookAtRH, lookAtLH}
// NOTE: perspective/ortho/frustum/perspFov 已由 gtc/matrix_transform 模块通过
//       lib.cj 第 24-27 行导入，此处避免重复导入防止命名冲突。
// Phase 4 — gtc 新模块
public import glm.gtc.{affineInverse, inverseTranspose}
public import glm.gtc.{row, column}
public import glm.gtc.{packUnorm4x8, packSnorm4x8, packHalf2x16, unpackUnorm4x8, unpackSnorm4x8, unpackHalf2x16}
public import glm.gtc.{perlin, simplex}
public import glm.gtc.{linearRand, gaussRand}
public import glm.gtc.{next_float, prev_float, float_distance, ulp}
public import glm.gtc.{roundPowerOfTwo, ceilPowerOfTwo, floorPowerOfTwo, roundMultiple}
```

**关于 `mix` 命名冲突的处理**：
- `glm.detail.common.cj` 定义 `mix(x, y, a)`（标量和 Vec 版本的线性插值，`T <: Number<T>` 约束）
- `glm.ext` 在阶段三已导出 `mix`（四元数版本的线性混合，已有 lib.cj 第 14 行）
- 两者签名（参数类型、数量、泛型约束）不同。仓颉支持函数重载，编译器可基于参数类型自动区分。无需额外消歧措施，正常增量导出即可
- 编码阶段需验证：当调用 `mix(quatA, quatB, 0.5f)` 时，编译器正确选择 ext 版本而非 detail/common 版本

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
