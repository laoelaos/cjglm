# GLM 1.0.3 仓颉迁移阶段四 OOD 设计方案

> **修订日期**：2026-06-29

---

## 1. 概述

### 设计目标

在阶段一（Vec1~Vec4 向量类型 + 基础设施）、阶段二（9 个矩阵类型 + ext/ 别名）和阶段三（Quat 四元数 + ext/gtc 函数库框架）的基础上，将 GLM 全部核心函数库（core）和扩展函数库（ext/gtc）的 stub 替换为完整实现，使库具备完整的 GLSL 风格数学运算能力。阶段四完成后，库中的全部 stub 文件均被替换，所有阶段三中因依赖函数库 stub 而处于"编译通过但抛 stub"或"完全不可用"状态的四元数功能将自动解锁。

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

### 约束继承

阶段二/三已识别的系统性约束在本阶段继续适用：
- **T(0)/T(1) 构造问题**：使用已验证的 `T(Float64(n))` 字面量替代路径（验证项 25 已通过），对 `one: T` 作为函数参数保留 T(1) 的显式传入路径
- **FloatingPoint<T> 接口**：已验证 `T.getInf()`/`T.isNaN()` 等静态方法可用（验证项 20 已通过）
- **std.math 重载覆盖**：std.math 提供 Float16/Float32/Float64 三重重载的函数可直接调用，无需额外类型转换

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
  │                               （perspective/ortho/frustum 等投影矩阵扩展）
  ├── matrix_clip_space.cj ★     — 替换 stub 为完整实现
  │                               （ortho 系族裁剪空间矩阵）
  │                               
  ├── quaternion_common.cj ★     — 补齐 mix/slerp/slerp(k) stub 为完整实现
  │                               （依赖 trigonometric.cj 的 acos/sin 和 geometric.cj 的 cross）
  ├── quaternion_transform.cj ★  — 补齐 rotate stub 为完整实现
  │                               （依赖 trigonometric.cj 的 sin/cos）
  ├── quaternion_geometric.cj    — 沿用阶段三（dot/length/normalize/cross 全部实现）
  ├── quaternion_trigonometric.cj— 沿用阶段三
  ├── quaternion_relational.cj   — 沿用阶段三
  ├── quaternion_exponential.cj  — 沿用阶段三（仍为 stub，GLM 1.0.3 中这些函数属于极少使用的实验性功能）
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
- 所有使用 `Common<T>` 约束的泛型函数通过 `Number<T>` 接口操作

#### exponential.cj

**角色**：提供 GLSL 8.2 节定义的指数函数。

**职责**：
- 包含 `pow(base, exponent)`、`exp(v)`、`log(v)`、`exp2(v)`、`log2(v)`、`sqrt(v)`、`inversesqrt(v)`
- 约束策略：全部函数使用 `T <: FloatingPoint<T>`
- 实现路径：直接委托 `std.math.pow/exp/log/exp2/log2/sqrt` 等标准库函数
- `inversesqrt` 实现为 `T(1) / sqrt(x)`，非直接委托

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

**协作关系**：被 geometric.cj（normalize 的 sqrt）、ext/quaternion_transform.cj（rotate 的 sin/cos）、ext/quaternion_common.cj（slerp 的 acos/sin）和 gtc/matrix_transform.cj（perspective 的 cot）调用。

#### geometric.cj

**角色**：提供 GLSL 8.5 节定义的几何函数。

**职责**：
- 替换阶段三的 stub 为完整实现
- 包含：`dot/cross/normalize/length/distance/reflect/refract/faceforward`
- `dot`：Vec1~Vec4 各版本，返回标量 T
- `cross`：仅 Vec3 版本，返回 Vec3<T, Q>
- `normalize/length/distance/reflect/refract/faceforward`：Vec2~Vec4（Vec1 的 normalize 退化为 T(1) 或 sign 语义）
- 约束策略：使用 `T <: FloatingPoint<T>`（需要 sqrt），但 `dot` 放宽为 `T <: Number<T>`
- `length` 实现为 `sqrt(dot(v, v))`
- `normalize` 实现为 `v / length(v)`，零向量保护返回零向量
- `distance` 实现为 `length(p0 - p1)`
- `reflect` 实现为 `I - T(2) * dot(N, I) * N`
- `refract` 实现为使用 `eta` 和 `k = T(1) - eta*eta * (T(1) - dot(N,I)*dot(N,I))` 的条件公式
- `faceforward` 实现为条件选择：`dot(Nref, I) < 0 ? N : -N`

**协作关系**：被 ext/quaternion_geometric.cj 的 cross/length/normalize（实际调用几何库而非独立实现，消除阶段三的重复设计）、ext/quaternion_common.cj 的 slerp、gtc/matrix_transform.cj 的 lookAt 调用。

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
  - Mat4x4：高斯消元或余子式展开
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
- `slerp(x, y, a, k)`：扩展球面插值（额外参数 k 控制插值曲线的形状/扭曲），实现参考 GLM 1.0.3 源码。
- 约束：`T <: FloatingPoint<T>, Q <: Qualifier`

**协作关系**：依赖 trigonometric.cj（acos, sin, cos）和 common.cj（clamp）。

#### ext/quaternion_transform.cj（rotate 补齐）

**角色**：补齐阶段三中因依赖 trigonometric stub 而未能实现的 rotate 函数。

**职责**：
- `rotate(q, angle, axis)`：绕轴旋转四元数。构造 `halfAngle = angle / T(2)`，计算 `sinHalf = sin(halfAngle)`（依赖 trigonometric.cj sin），`cosHalf = cos(halfAngle)`（依赖 trigonometric.cj cos），返回四元数 `(sinHalf * axis.x, sinHalf * axis.y, sinHalf * axis.z, cosHalf) * q`（实际内部实现为单位四元数 + 旋转四元数乘法）。
- 约束：`T <: FloatingPoint<T>, Q <: Qualifier`

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
- 实现参考 GLM 1.0.3 `detail/_noise.hpp` 和 `detail/_noise.inl` 的算法，映射为仓颉代码

#### gtc/random.cj

**角色**：随机数生成函数。

**职责**：
- `linearRand(min, max)`：均匀分布随机数（标量和向量版本）
- `gaussRand(mean, stddev)`：高斯分布随机数
- 使用仓颉 `std.random.Random` 作为底层随机数源

#### gtc/type_precision.cj

**角色**：高精度类型别名定义（与 GLM 1.0.3 `gtc/type_precision.hpp` 对应）。

**职责**：
- 定义使用 `highp/mediump/lowp` 精度的类型别名
- 涵盖向量、矩阵、四元数类型的所有精度变体
- 类型别名的具体定义可引用 `fwd.cj` 中已定义的别名，或在本文件中直接引用 `glm.detail` 的具体类型

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
  1. cosOmega = clamp(dot(x, y), -T(1), T(1))
  2. omega = acos(cosOmega)                          // 依赖 trigonometric acos
  3. sinOmega = sin(omega)                           // 依赖 trigonometric sin
  4. 若 sinOmega 接近零：退化为 lerp = x*(T(1)-a) + y*a
  5. 否则：
     scale0 = sin((T(1)-a)*omega) / sinOmega
     scale1 = sin(a*omega) / sinOmega
     返回 scale0 * x + scale1 * y
约束：T <: FloatingPoint<T>
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
| **acos 输入超出 [-1,1]** | 依赖 std.math.acos 的 NaN 传播 | 不在函数体内做 clamp，由 std.math 自然处理 |
| **mod 浮点参数** | 无异常抛出 | 使用 `x - y * floor(x / y)` 公式，自然传播 NaN/Inf |
| **函数库依赖 stub 未替换** | 不存在（所有 stub 在本阶段替换） | 阶段四完成后库中无存留 stub |

本阶段不引入新的错误类型。所有函数的错误处理行为遵循 GLM 1.0.3 的约定："不验证输入有效性，函数结果由输入决定，包括 NaN/Inf 传播"。

---

## 6. 并发设计

本阶段不引入新的并发机制。core/ext/gtc 函数库均为纯函数（无副作用、不修改输入参数），天然线程安全。矩阵和向量的值语义（struct + 返回副本）确保并发计算中的隔离性。

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
| D12 | **gtc/packing.cj 使用具体类型重载而非泛型** | 打包运算涉及位级操作和特定的数值转换（如 Float32 ↔ UInt32 的位模式转换），不适合泛型化。仓颉 CFFI 或原生位操作 API 为本文件的实现基础 |
| D13 | **gtc/noise.cj 的 Perlin/Simplex 实现直接内联算法，不依赖外部噪声库** | 仓颉标准库不提供噪声函数。噪声算法的参考实现在 GLM 1.0.3 的 `detail/_noise.hpp` 中已有完整数学定义，直接迁移 |
| D14 | **ext/matrix_transform.cj 与 gtc/matrix_transform.cj 的 translate/rotate/scale 重复** | 两者在 GLM 1.0.3 中均存在（ext 版本与 gtc 版本），ext 版本提供基础功能，gtc 版本提供更完整的手系/深度变体。编码阶段需注意 gtc 版本内部可委托 ext 版本以避免代码重复 |

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
| geometric.cj | 替换 stub → 完整实现 | trigonometric.cj, common.cj (or 独立实现 sqrt) |
| ext/matrix_transform.cj | 替换 stub → 完整实现 | geometric.cj, trigonometric.cj |
| ext/matrix_projection.cj | 替换 stub → 完整实现 | trigonometric.cj |
| ext/matrix_clip_space.cj | 替换 stub → 完整实现 | common.cj, geometric.cj |
| ext/quaternion_common.cj (mix/slerp) | 补齐 stub → 完整实现 | trigonometric.cj, geometric.cj, common.cj |
| ext/quaternion_transform.cj (rotate) | 补齐 stub → 完整实现 | trigonometric.cj |

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
// Phase 4 — ext 扩展函数库
public import glm.ext.{translate, rotate, scale, shear, lookAt, lookAtRH, lookAtLH}
public import glm.ext.{perspective, ortho, frustum, perspFov}
// Phase 4 — gtc 新模块
public import glm.gtc.{affineInverse, inverseTranspose}
public import glm.gtc.{row, column}
public import glm.gtc.{packUnorm4x8, packSnorm4x8, packHalf2x16, unpackUnorm4x8, unpackSnorm4x8, unpackHalf2x16}
public import glm.gtc.{perlin, simplex}
public import glm.gtc.{linearRand, gaussRand}
public import glm.gtc.{next_float, prev_float, float_distance, ulp}
public import glm.gtc.{roundPowerOfTwo, ceilPowerOfTwo, floorPowerOfTwo, roundMultiple}
```

---

## 9. 与已有阶段的集成方式

### 9.1 对阶段三的反馈影响

阶段三的以下设计约束在本阶段将自然解除：

1. **Quat×Vec3/Quat×Vec4 从抛 stub 变为正常**：geometric.cj 的 `cross` 函数完成完整实现后，这些运算符内部调用 `cross` 不再抛 stub 异常，自动切换至正常旋转计算路径。无需修改 `type_quat.cj` 文件。

2. **slerp/mix 从 ❌ 不可用变为可用**：ext/quaternion_common.cj 的 slerp 和 mix 函数在 trigonometric.cj（acos/sin/cos）和 geometric.cj（cross/clamp）就绪后完成实现，四元数插值能力完整可用。

3. **rotate 从 stub 变为可用**：ext/quaternion_transform.cj 的 rotate 函数依赖 trigonometric.cj 的 sin/cos，完成实现后可用。

4. **gtc/matrix_transform.cj 从 stub 变为可用**：其 64 个函数中，每个函数的数学公式直接使用已就绪的 core/ext 函数库，全部解锁。

### 9.2 对阶段二的反向兼容

阶段二中 matrix.cj 已有 27 个真实实现（transpose/matrixCompMult/outerProduct）和 6 个 stub（determinant/inverse）。本阶段仅替换 6 个 stub，不对已有 27 个实现做任何修改，保证阶段二的验证标准不受影响。

### 9.3 对阶段一的反向兼容

本阶段不修改阶段一的任何 Vec 类型文件。所有 core/ext/gtc 函数库仅使用 Vec 类型的公开接口（构造函数、分量访问、算术运算符），不依赖阶段一内部的任何私有成员或实现细节。

### 9.4 lib.cj 导出

lib.cj 按增量追加策略更新——在现有 9-28 行（阶段二三新增）之后追加阶段四的 public import。已有 import 行不做任何修改，确保下游消费者对阶段二三功能的调用代码不受影响。
