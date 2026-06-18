# GLM 1.0.3 仓颉迁移首轮 OOD 设计方案（v1）

---

## 1. 概述

### 设计目标

将 GLM 1.0.3 首轮迁移范围内的 C++ 实现（基础设施层 + 向量类型系统 + 类型别名体系）以仓颉语言重新实现，提供一个在仓颉泛型系统和值类型语义下可独立编译运行的向量数学基础库。

### 核心抽象

| 抽象 | 角色 | 类型形态 |
|------|------|---------|
| `Qualifier` | 定义精度/对齐策略的多态契约 | 接口 |
| `PackedHighp` / `PackedMediump` / `PackedLowp` / `AlignedHighp` / 等 | 具体精度/对齐策略标记 | 空结构体（实现 `Qualifier`） |
| `Vec1<T,Q>` / `Vec2<T,Q>` / `Vec3<T,Q>` / `Vec4<T,Q>` | 表示数学向量的值对象 | 泛型结构体 |
| `Functor1` / `Functor2` / `Functor2VecSca` / `Functor2VecInt` | 逐分量标量函数映射工具 | 结构体（各分量数分别定义） |
| `ComputeVecAdd` / `ComputeVecSub` / 等 | 向量逐分量运算策略 | 结构体 |
| `ComputeEqual` | 分量相等比较策略（区分浮点/整数） | 结构体 |
| 标量类型别名 | 仓颉原生整数/浮点类型的 GLM 兼容命名 | `type` 别名 |
| 向量类型别名 | 具现化 Vec 类型的便捷命名 | `type` 别名 |

### 整体架构思路

采用"双层包结构 + 独立具象化别名"的架构：`glm.detail` 包封装全部核心泛型类型定义和运算逻辑，`glm` 包通过类型别名暴露已具现化的常用向量类型。类型系统以 `Qualifier` 接口为精度/对齐策略的多态入口，四个 Vec 结构体作为独立泛型类型（而非分量数参数化的单一模板）承载向量数据与运算。

---

## 2. 模块划分

### 包组织

```
package glm.detail        — 核心实现层
  ├── setup.cj            — 配置常量、length_t、辅助宏等效
  ├── qualifier.cj        — Qualifier 接口及实现类型、前向声明
  ├── shim_assert.cj      — 断言替代
  ├── shim_limits.cj      — numeric_limits 等效
  ├── shim_cstddef.cj     — size_t/length_t 类型别名
  ├── compute_vector_relational.cj  — compute_equal
  ├── compute_vector_decl.cj        — compute_vec_add/sub/mul/div 等运算策略
  ├── vectorize.cj                  — functor1/functor2/functor2_vec_sca/functor2_vec_int（各分量数版本）
  ├── type_vec1.cj                  — Vec1<T,Q> 结构体定义 + 运算符
  ├── type_vec2.cj                  — Vec2<T,Q> 结构体定义 + 运算符
  ├── type_vec3.cj                  — Vec3<T,Q> 结构体定义 + 运算符
  └── type_vec4.cj                  — Vec4<T,Q> 结构体定义 + 运算符

package glm               — 公共别名层
  └── fwd.cj              — 标量类型别名 + 向量类型别名
```

### 模块间依赖

```
glm.detail（内部无包引用，同包直接可见）
  setup 无依赖
  qualifier → setup
  shim_* 无依赖（仅使用仓颉原生类型）
  compute_vector_relational → setup + shim_limits
  vectorize → setup + qualifier（使用 length_t / Qualifier 接口约束）
  compute_vector_decl → vectorize + qualifier
  type_vecN → qualifier + compute_vector_relational + compute_vector_decl（按需）

glm
  fwd.cj → glm.detail.{Vec1,Vec2,Vec3,Vec4,Qualifier 实现类型}
```

`glm` 包单向依赖 `glm.detail`，反向无依赖。

---

## 3. 核心抽象

### 3.1 Qualifier 体系

**角色**：为向量类型的精度（ULP）和对齐策略提供编译期类型级区分能力。

C++ GLM 中 `qualifier` 是枚举值，可直接作为模板非类型参数传递。仓颉泛型系统仅接受类型作为泛型实参，因此将枚举映射为"接口 + 实现结构体"模式：

- **`interface Qualifier`** — 标记接口，无成员。所有精度/对齐策略类型实现此接口。
- **`struct PackedHighp <: Qualifier {}`** — 默认精度/对齐策略。代表数据紧凑存储、高精度运算。
- **`struct PackedMediump <: Qualifier {}`** / **`struct PackedLowp <: Qualifier {}`** — 紧缩中/低精度。
- **`struct AlignedHighp <: Qualifier {}`** / **`struct AlignedMediump <: Qualifier {}`** / **`struct AlignedLowp <: Qualifier {}`** — 对齐策略（首轮 `GLM_CONFIG_ALIGNED_GENTYPES = false`，对齐类型可定义但内部不使用）。
- **`type Defaultp = PackedHighp`** — 默认精度别名。

Vec 泛型结构体通过 `where Q <: Qualifier` 约束 Q 参数，确保精度标记的类型安全性。预定义的 `lowp_`/`mediump_`/`highp_` 别名等价于分别绑定不同的 Qualifier 实现类型。

**选择理由**：采用接口而非 sealed 枚举+匹配（enum），是因为泛型参数需要类型级区分以支持不同 Vec 实例的编译期类型区分，而非运行时分支分发。空结构体的零开销值与接口的泛型约束能力结合，是仓颉泛型系统下最直接的映射方案。

### 3.2 Vec 结构体系

**角色**：表示 N 维数学向量，是 GLM 中最核心的领域实体。每个 Vec 是值类型（struct），支持构造、分量访问、算术运算、比较运算和位运算。

四个 Vec 类型（`Vec1<T,Q>`、`Vec2<T,Q>`、`Vec3<T,Q>`、`Vec4<T,Q>`）各自独立定义，而非使用分量数参数化的单一泛型模板。每个 Vec 有自己的：

- 数据成员（`T x, y, z, w` 等，数量对应分量数）
- 构造函数体系（默认构造、标量填充构造、逐分量构造、跨 Vec 转换构造、跨 Qualifier 转换构造）
- 下标运算符 `[]` 用于分量访问
- 算术复合赋值运算符（`+=`、`-=`、`*=`、`/=`、`%=`）——标注 `@OverflowWrapping`
- 一元/二元算术运算符（`+`、`-`、`*`、`/`、`%`）——通过委托复合赋值实现，自动继承 wrapping 语义
- 位运算符（`&`、`|`、`^`、`<<`、`>>`、`~`）
- 比较运算符（`==`、`!=`）——浮点分量通过 `ComputeEqual` 策略比较
- 布尔逻辑运算符（`&&`、`||`——仅限 `Vec<Bool, Q>`）

**类型形态选择理由**：
- 使用 **struct** 而非 class：向量是纯值语义类型，按值传递/赋值应复制而非共享引用。Struct 的值语义与 C++ vec 的行为一致。
- 四个**独立结构体**而非单模板特化：仓颉不支持 C++ 偏特化，无法通过 `Vec<N, T, Q>` 单模板的分量数偏特化实现各分量数版本的差异化行为。四个独立类型虽然代码重复但实现模式简单直接。
- **运算符均在结构体外部**定义为包级函数：仓颉的运算符重载语法要求在结构体/类外部定义非成员运算符函数，同时复合赋值运算符（`op=`）在结构体内部定义。二元运算符委托给复合赋值运算符实现（"拷贝+`op=`"模式），避免代码重复。

### 3.3 Functor 体系

**角色**：封装"对标量函数逐分量映射到向量"的调用模式，是 `compute_vector_decl` 中运算策略的实现基础。

C++ `_vectorize.hpp` 中的四个 functor 模板（`functor1`、`functor2`、`functor2_vec_sca`、`functor2_vec_int`）使用了模板模板参数（`template<length_t L, typename T, qualifier Q> class vec`）来统一接收不同分量数的 vec 特化。由于仓颉中 Vec1~Vec4 是四个独立结构体而非同一模板的特化，模板模板参数模式无法复用。

首轮设计按分量数拆分 functor——为 Vec1~Vec4 各定义四组独立的 functor 结构体：

- **`Functor1Vec1<R, T, Q>`** ~ **`Functor1Vec4<R, T, Q>`** — 一元映射（`Func(T) -> R`）
- **`Functor2Vec1<T, Q>`** ~ **`Functor2Vec4<T, Q>`** — 二元映射（`Func(T, T) -> T`）
- **`Functor2VecScaVec1<T, Q>`** ~ **`Functor2VecScaVec4<T, Q>`** — 向量-标量二元映射
- **`Functor2VecIntVec1<T, Q>`** ~ **`Functor2VecIntVec4<T, Q>`** — 向量-整数向量二元映射

每个 functor 提供一个静态 `call` 方法，接收一个仿函数/函数引用和向量操作数，返回向量结果。

**选择理由**：拆分后 functor 总数从 4 个变为 16 个（4 种模式 × 4 分量数），但每个 functor 的实现极其简单（仅为逐分量调用函数并构造结果向量），代码生成工作量虽增加但实现复杂度极低。后续可通过宏（仓颉宏）生成这些重复定义。

### 3.4 ComputeVec* 运算策略体系

**角色**：封装向量逐分量运算的具体实现，是 Vec 运算符函数的内部委托目标。

`compute_vector_decl.hpp` 中定义的 `compute_vec_add`、`compute_vec_sub`、`compute_vec_mul`、`compute_vec_div`、`compute_vec_mod`、`compute_vec_and`、`compute_vec_or`、`compute_vec_xor`、`compute_vec_shift_left`、`compute_vec_shift_right`、`compute_vec_equal`、`compute_vec_nequal`、`compute_vec_bitwise_not` 等结构体，在 C++ 中通过偏特化的 `UseSimd` 和 `IsInt`/`Size` 参数进行 SIMD/非 SIMD 和整数/非整数的分支。

首轮设计简化策略：

- **所有 `UseSimd` 参数取 `false`**：`GLM_CONFIG_SIMD = false`，无 SIMD 路径。
- **整数/浮点运算直接在 Vec 运算符中通过泛型 `+`/`-`/`*`/`/` 等原生运算处理**，无需通过 `<functional>` 中的 `std::plus<T>` 等函数对象——仓颉中改用 lambda 或直接内联运算表达式。
- **相等比较通过 `ComputeEqual` 策略处理**：区分浮点类型（通过 `std::numeric_limits<T>::is_iec559` 判断）和整数类型的比较路径。仓颉中该判断映射为 `ComputeEqual<T, IsFloat>` 的双路径——`IsFloat = true` 时使用容差比较，`IsFloat = false` 时使用 `==` 直接比较。

**结构体定义方式**：每个 `ComputeVec*` 定义为结构体（无状态，仅提供静态 `call` 方法），按分量数分别定义 Vec1~Vec4 版本，或通过泛型参数化 Vec 类型实现统一。首轮推荐为 Vec1~Vec4 分别定义以保持与 Vec 独立结构体模式的一致性，后续可通过宏统一生成。

### 3.5 ComputeEqual

**角色**：提供分量级别的相等比较策略，向量的 `==` 运算符委托此类型做逐分量比较。

```cangjie
struct ComputeEqual<T, IsFloat> {
    static func call(a: T, b: T): Bool { a == b }
}
// 浮点特化（当前 C++ GLM 中注释掉的路径，首轮暂不启用）
struct ComputeEqual<T, True> {
    // 容差比较逻辑
}
```

首轮中 `IsFloat` 的判定依赖 `shim_limits` 提供的类型特性查询——判断 `T` 是否为 IEEE 754 浮点类型。若 shim 层无法提供 `is_iec559` 等效判断，则统一走精确比较路径（`a == b`），与 C++ `compute_equal` 的非浮点路径一致，且不损失正确性（浮点数直接比较在大多数使用场景下足够）。

### 3.6 Shim 层

**角色**：替代 GLM 所依赖的 C++ 标准库设施（`<cassert>`、`<cstddef>`、`<limits>`），是首轮范围的编译前提。

- **`shim_assert.cj`**：提供 `assert(condition: Bool, message?: String)` 函数，行为等价于 `if (!condition) { throw ... }`。这替代了 `setup.hpp` 中的 `assert()` 宏及其变体 `GLM_ASSERT_LENGTH`。
- **`shim_limits.cj`**：提供泛型 `NumericLimits<T>` 结构体（或独立函数），查询 `T` 类型的最大值、最小值、是否为 IEEE 754 浮点等特性。实现为各数值类型静态属性的泛型封装：`where T <: Number<T>` 约束。
- **`shim_cstddef.cj`**：定义 `type SizeT = UInt64`（无符号语义场景）和 `type LengthT = Int64`（索引/长度场景）两个类型别名，明确区分有符号/无符号使用场景，替代 C++ `size_t`/`ptrdiff_t`。

### 3.7 标量类型别名

**角色**：在 `package glm` 中为仓颉原生数值类型提供与 GLM 兼容的命名体系。

映射规则：仓颉的 `Int8`/`Int16`/`Int32`/`Int64`/`UInt8`/`UInt16`/`UInt32`/`UInt64`/`Float32`/`Float64` 分别映射为 GLM 的 `int8`~`uint64`/`float`/`double`。此外为各类型提供 `lowp_`/`mediump_`/`highp_` 精度变体别名。

由于仓颉原生数值类型名称已足够简洁（如 `Int32` 比 `i32` 更清晰且是语言关键字），标量别名在 `package glm` 中定义以供需要 GLM 命名风格的代码使用，但 `package glm.detail` 内部直接使用仓颉原生类型名。

### 3.8 向量类型别名

**角色**：在 `package glm` 中为 Vec1~Vec4 的常用具现化提供简洁命名。

共 16 个别名家族（bvec/ivec/uvec/vec/dvec/i8vec/...）× 4 分量数 × 4 精度变体 = 256 个别名。每个别名形式如：

```cangjie
type Vec2Float32 = Vec2<Float32, PackedHighp>
type LowpVec2Float32 = Vec2<Float32, PackedLowp>
type IVec2 = Vec2<Int32, PackedHighp>
```

选择将别名集中在 `fwd.cj`（`package glm`）中，而非分散在各 Vec 定义文件，以保持良好的关注点分离——Vec 结构体关心类型定义，别名层关心命名约定。

---

## 4. 关键行为契约

### 4.1 向量构造

- 默认构造：所有分量初始化为零（对于数值类型）或 `false`（对于 bool）。
- 标量填充构造：将所有分量设置为同一标量值。
- 逐分量构造：接收与分量数相同数量的标量参数。
- 跨 Vec 转换构造：从同分量数但不同 `T`/`Q` 的 Vec 构造，分量值通过 `static_cast` 的语义等价转换（仓颉中的 `T(v)` 或 `as` 转换）。
- 跨分量数构造：Vec4 可从 Vec2+Vec2、Vec3+标量、Vec1+Vec2+Vec1 等组合构造；Vec3 类似；Vec2 从 Vec1+标量等。遵循 GLSL 5.4.1 规范。
- 从 Vec1 显式构造：所有 Vec 支持从 `Vec1<T>` 显式构造，所有分量取 Vec1 的单一分量值。

### 4.2 分量访问

- 通过 `operator []` 按索引访问（0 ~ N-1），带边界断言（`GLM_ASSERT_LENGTH` 等效）。
- 通过具名成员（`x`/`y`/`z`/`w`、`r`/`g`/`b`/`a`、`s`/`t`/`p`/`q`）直接访问。

### 4.3 算术运算

- 复合赋值运算符（`+=`、`-=`、`*=`、`/=`、`%=`）：逐分量运算，标注 `@OverflowWrapping`。接收标量、`Vec1` 或同分量数 Vec 作为右操作数。
- 二元算术运算符（`+`、`-`、`*`、`/`、`%`）：非成员函数，内部实现为"拷贝 + 复合赋值"委托模式。接收标量、`Vec1` 或同分量数 Vec 作为操作数，支持左右交换（scalar + vec 和 vec + scalar）。
- 一元运算符（`+`、`-`）：`+v` 返回自身；`-v` 返回逐分量取反的新向量。

### 4.4 位运算

仅整数分量 Vec 有意义。包括 `&`、`|`、`^`、`<<`、`>>`、`~`。逐分量运算，不触发溢出检查（仓颉位运算无溢出异常）。复合赋值（`&=`、`|=`、`^=`、`<<=`、`>>=`）在 Vec 结构体内定义。

### 4.5 比较运算

- `==`：逐分量调用 `ComputeEqual` 判断相等，全分量相等返回 `true`。
- `!=`：`!==` 语义——任一分量不等返回 `true`。
- `&&`、`||`：仅 bool 类型 Vec，逐分量逻辑运算，返回 `Vec<Bool, Q>`。

### 4.6 `@OverflowWrapping` 标注策略

遵循 roadmap 0.5.1 节的精确策略——仅在以下成员运算符函数上标注：
- 算术复合赋值：`+=`、`-=`、`*=`、`/=`（4 个运算符 × 4 个 Vec 类型 = 16 处标注）
- 可选：`%=`、`++`、`--`（首轮可暂不标注——这些在整数向量中使用极少）

二元算术运算符通过"拷贝 + 复合赋值"委托模式自动继承 wrapping 语义，无需重复标注。

---

## 5. 错误处理策略

首轮范围内的错误处理场景极为有限：

| 场景 | 策略 |
|------|------|
| 下标越界（`operator[]`） | 在运行时检测索引范围，越界时调用 `assert()` 等效的 `if + throw` 模式。与 C++ `GLM_ASSERT_LENGTH` 行为一致。 |
| 整数溢出 | 通过在复合赋值运算符上标注 `@OverflowWrapping` 将溢出行为从"抛异常"改为"wrapping"，与 C++ UB 行为在数值结果上等价。 |
| 除零 | 依赖底层仓颉运行时行为（整数除零抛异常，浮点除零返回 `±Inf`）。首轮不添加额外保护层。 |

无 `Option`/`Result` 使用场景——向量算术运算始终返回有效值（在 wrapping 语义下），类型构造始终有效，不涉及可能失败的 I/O 或资源获取。

---

## 6. 并发设计

首轮范围无共享状态：Vec 结构体是值类型，所有运算不可变（产生新向量）或就地修改（复合赋值）。值类型的复制语义天然线程安全——不存在同一内存位置的并发写冲突。Vec 类型不做内部加锁，调用者负责在多线程场景下的值隔离（通过局部变量或消息传递）。

---

## 7. 设计决策

### D1. 独立 Vec 结构体 vs 单模板 + 宏生成

**决策**：四个独立泛型结构体（Vec1~Vec4），不使用宏生成。

**理由**：仓颉不支持 C++ 偏特化，无法实现 `Vec<N,T,Q>` 单模板的分量数差异。宏生成虽然可减少重复代码，但首轮四个 Vec 结构体的定义模式高度一致且数量可控（4 个），独立编写可提供更好的 IDE 支持、调试可见性和代码导航体验。后续可在第二轮通过宏重构减少重复。

### D2. Qualifier 接口 vs 枚举 vs sealed class

**决策**：`interface Qualifier` + 空结构体实现。

**理由**：
- 枚举（enum）：仓颉 enum 值不能作为泛型类型实参传递，enum 构造器在泛型参数位置不被接受。
- Sealed class：引入继承和引用语义（class 为引用类型），而 precision tag 是零成本类型标记，不应有堆分配开销。
- 接口 + 空结构体：零运行时开销（空结构体的大小为零或极小），类型参数 `Q <: Qualifier` 编译期约束保证了类型安全性，可提供默认类型参数 `= PackedHighp`。

### D3. 二元运算符委托模式 vs 逐分量独立实现

**决策**：二元运算符采用"拷贝 + 复合赋值"委托模式。

**理由**：减少代码量——每个 Vec 类型约 20 个二元运算符函数，若独立实现则需要各写一份逐分量逻辑；委托模式下二元运算符函数体极其简短（3-4 行）。性能上增加一次结构体拷贝（16-64 字节），在首轮功能实现阶段可接受。后续性能优化轮次可按需改为直接实现。

### D4. 仓颉原生类型名 vs GLM 兼容别名

**决策**：`package glm.detail` 内部直接使用 `Int32`/`Float32` 等仓颉原生类型名；`package glm` 中通过 `type` 别名提供 `int32`/`f32` 等 GLM 兼容命名。

**理由**：`package glm.detail` 是内部实现，应遵循仓颉语言惯例和最佳实践。`package glm` 是公共 API，需保持与现有 GLM 用户代码的兼容性。适当分离内部实现命名和外部接口命名。

### D5. 泛型约束粒度

**决策**：Vec 的 `T` 参数不做紧约束（不要求 `T <: Number<T>`），仅约束 `Q <: Qualifier`。

**理由**：GLM 的 vec 类型在 C++ 中对分量类型几乎不做约束（通过 SFINAE 校验有效性）。在仓颉中若对 `T` 加 `Number<T>` 约束，排除了 `Bool` 类型向量。宽松约束允许编译器在运算符函数体中因类型不支持运算报错，而非在类型定义处报错，与 C++ 模板的延迟检查行为一致。

### D6. GLM_CONFIG_* 配置常量采用 const 声明

**决策**：将 C++ `#define` 宏映射为仓颉 `const` 常量（编译期常量），在 `setup.cj` 中集中声明。首轮所有配置取最保守值。

**理由**：`const` 常量是仓颉编译时求值的基本机制，可被 `if` 分支用于消除死代码（const 求值优化）。18 个 GLM_CONFIG_* 常量集中在 `setup.cj` 中声明，与 `length_t`、`uint` 别名等同属全局配置层。首轮所有 `GLM_CONFIG_*` 取最保守值（如 `SIMD=false`、`SWIZZLE=DISABLED`），确保最小依赖闭合。

### D7. Functor 不直接映射 C++ `<functional>` 中的 `std::plus<T>` 等

**决策**：functor 的 `call` 方法直接接受 lambda 或函数引用作为参数，不引入 `std::plus` 等函数对象的直接等效。

**理由**：仓颉无 `std::plus`，但函数类型 `(T, T) -> T` 和 lambda 表达式可直接作为参数传递。泛型 functor 接收 `F: (T, T) -> T` 类型的函数参数即可。对比 C++ 需要 `std::plus<T>`（一个标准函数对象类型），仓颉更简洁——直接在调用点使用 `{ a, b => a + b }` 或运算符引用。

---

## 8. 迁移文件清单与依赖拓扑

| 序号 | 文件（package glm.detail） | 依赖 | 说明 |
|------|---------------------------|------|------|
| 1 | `setup.cj` | 无 | 配置常量、`LengthT`/`SizeT`、`assert` |
| 2 | `qualifier.cj` | `setup.cj` | `Qualifier` 接口及实现类型、V 前向声明注释 |
| 3 | `shim_assert.cj` | 无 | `assert()` 函数 |
| 4 | `shim_limits.cj` | 无 | `NumericLimits<T>` |
| 5 | `shim_cstddef.cj` | 无 | `SizeT`/`LengthT` 别名 |
| 6 | `compute_vector_relational.cj` | `shim_limits.cj` | `ComputeEqual` |
| 7 | `vectorize.cj` | `qualifier.cj` | Functor1~4 的 Vec1~Vec4 版本 |
| 8 | `compute_vector_decl.cj` | `vectorize.cj` | ComputeVecAdd/Sub/Mul/Div/... |
| 9~12 | `type_vec1.cj`~`type_vec4.cj` | `qualifier.cj` + 辅助文件 | Vec 结构体定义 + 运算符 |

| 序号 | 文件（package glm） | 依赖 | 说明 |
|------|--------------------|------|------|
| 13 | `fwd.cj` | `glm.detail.*` | 标量别名 + 256 个向量别名 |

迁移顺序：1~5（基础设施）→ 6~8（辅助工具）→ 9~12（Vec 类型，可并行）→ 13（别名）。
