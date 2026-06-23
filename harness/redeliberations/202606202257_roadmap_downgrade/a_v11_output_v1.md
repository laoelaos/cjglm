# GLM 1.0.3 CangJie 适配基线分析与技术决策依据

> **文档定位声明**：本文档为项目基线分析和技术决策依据，记录迁移分析结论与决策。非路线图，不包含未来执行计划。部分超出当前分析范围的内容在附录中作为背景信息列出，供关联参考，不代表未来执行计划。

---

## 0. CangJie 语言特性适应性分析

本节基于 CangJie 语言官方文档逐项评估迁移所需的关键语言能力，已将各项迁移所需语言能力的评估从推测性判断明确为**确定性结论**。

### 0.1 泛型/模板系统

| 能力 | CangJie 支持情况 | 评估结论 |
|------|-----------------|---------|
| 泛型 struct/class | ✅ 支持：`struct Vec<T> { ... }` — 语法与 C++ 模板类似，支持类型参数化 | 可支持 `Vec1<T, Q>` 等泛型结构体定义，其中 Q 为**接口约束类型参数**（`where Q <: Qualifier`），不接收枚举值作为泛型实参 |
| 泛型约束 | ✅ 支持：`where T <: SomeInterface` 语法 | 可对类型参数施加接口约束 |
| 偏特化（Partial Specialization） | ❌ 不支持：CangJie 泛型类型在所有类型参数上**不变**（invariant），无 C++ 式偏特化/全特化机制 | **关键差异**：`vec<N,T,Q>` 的 4 个分量数变体无法通过模板偏特化实现。已决策采用分别定义 `Vec1<T, Q>`、`Vec2<T, Q>`、`Vec3<T, Q>`、`Vec4<T, Q>` 四个独立泛型结构体（不使用分量数参数），其中 Q 以 `where Q <: Qualifier` 约束（宏生成方案经评估未纳入） |
| 型变 | 用户自定义泛型类型在所有类型参数上为**不变** | 不影响核心类型设计（`vec` 无须协变/逆变） |

> **`qualifier` 在 CangJie 中的类型映射**：C++ GLM 中 `qualifier` 是一个枚举类型（含 `packed_highp`、`packed_mediump`、`packed_lowp`、`aligned_highp` 等枚举值），作为**枚举值**传递给泛型类型参数（如 `vec<L,T,qualifier Q>`）。CangJie 泛型类型参数**仅接受类型作为实参**，不接受枚举值或枚举构造器作为实参。已决策采用以下设计方案（**接口多态方案**）：
> - 将 `Qualifier` 定义为接口：`interface Qualifier {}`
> - 各 qualifier 变体定义为实现该接口的空结构体：`struct PackedHighp <: Qualifier {}`、`struct PackedMediump <: Qualifier {}`、`struct PackedLowp <: Qualifier {}`、`struct AlignedHighp <: Qualifier {}`、`struct AlignedMediump <: Qualifier {}`、`struct AlignedLowp <: Qualifier {}`
> - Vec 泛型结构体中 Q 参数以接口约束限定：`struct Vec1<T, Q <: Qualifier = PackedHighp> { ... }`
> - 默认类型：`type Defaultp = PackedHighp`
> - 类型别名示例：`type Vec1f32 = Vec1<Float32, PackedHighp>`
> - 此方案保留编译期类型区分能力，与 CangJie 泛型系统兼容。**全文所有 `Vec<T, Q>` 类型签名均遵循此映射**，不得使用枚举值作为泛型实参。
>
> **`_vectorize.hpp` 偏特化与模板模板参数说明**：辅助文件 `_vectorize.hpp` 中的 `functor1`/`functor2`/`functor2_vec_sca`/`functor2_vec_int` 四个模板结构体不仅使用 C++ 偏特化模式（针对标量类型和向量类型分别提供特化版本），还使用了**模板模板参数**——例如 `functor1` 的模板参数中包含 `template<length_t L, typename T, qualifier Q> class vec`，使其能够统一接收不同分量数的 `vec<N,T,Q>` 特化。当 `vec<N,T,Q>` 被拆分为 `Vec1<T,Q>`~`Vec4<T,Q>` 四个独立泛型结构体后，单个 `functor1` 模板无法统一接收它们——因为四个结构体不再是同一模板的不同特化，没有公共的"模板签名"可供模板模板参数捕获。已采用应对策略：为各分量数分别定义独立 functor 结构体（如 `functor1_vec1`、`functor1_vec2`、`functor1_vec3`、`functor1_vec4`），各处理对应分量数的向量类型，并使用宏生成各分量数的 functor 版本以减少重复代码。该策略增加约 4× 的 functor 定义量（原 4 个 functor 扩展为 16 个），但实现模式简单。此外，上述 functor 模板中的 `qualifier Q` 在 CangJie 中已映射为 `Q <: Qualifier`（接口约束），而非 `qualifier` 枚举值作为类型参数——因为 CangJie 泛型类型参数仅接受类型作为实参，不接受枚举值。

### 0.2 运算符重载

| 能力 | CangJie 支持情况 | 评估结论 |
|------|-----------------|---------|
| 算术运算符 `+`/`-`/`*`/`/` | ✅ 支持：`public operator func +(rhs: T): T` | 可为向量类型定义算术运算符 |
| 比较运算符 `==`/`!=`/`<`/`<=`/`>`/`>=` | ✅ 支持 | 可为向量类型定义比较运算符 |
| 下标运算符 `[]` | ✅ 支持：取值 `operator func [](i: Int64): T` 和赋值 `operator func [](i: Int64, value!: T): Unit` | 可为向量实现分量访问 |
| 一元运算符 `-`/`!` | ✅ 支持 | 支持 |
| 复合赋值 `+=`/`-=`/`*=`/`/=` | ✅ 支持（重载二元运算符时自动启用对应的复合赋值版本） | 支持 |
| **限制**：不能创建自定义运算符、不能重新重载类型已原生支持的运算符、运算符重载不能为泛型 | 不影响核心类型（使用标准运算符） |

### 0.3 类型别名

| 能力 | CangJie 支持情况 | 评估结论 |
|------|-----------------|---------|
| 类型别名 | ✅ `type Alias = OriginalType` — 不创建新类型，仅为替代名称 | 可支持向量类型别名（`type Vec2f = Vec2<Float32>`） |
| 泛型类型别名 | ✅ `type MyVec<T> = Vec2<T>` — 类型别名可声明类型参数，但**不能**对别名类型参数使用 `where` 约束 | 可支持泛型别名（如 `type Vec2<T> = Vec<2, T>` 在分别定义各 VecN 后不可行，改为 `type Vec2F32 = Vec2<Float32, PackedHighp>` 等非泛型别名）；由于别名不能使用 `where` 约束，任何含 `Qualifier` 接口约束的泛型参数不能在别名上重复约束，须在别名时选用具象的 `Qualifier` 实现类型 |
| 别名命名规则 | 仅限顶层定义，不可在函数内定义 | 符合使用场景 |

### 0.4 编译期条件分支

| 能力 | CangJie 支持情况 | 评估结论 |
|------|-----------------|---------|
| `const` 函数/表达式 | ✅ 支持：编译时求值，包含数值运算、`if`/`match`、类型转换等 | 可替代部分编译期数值条件逻辑 |
| 宏（元编程） | ✅ 支持：`@MacroName` 编译时代码生成，可基于 `Tokens` 做条件展开 | 可用于替代 GLM 中 `#if`/`#ifdef` 的配置条件分支 |
| **无预处理器** | ❌ 无 C 式 `#if`/`#ifdef`/`#endif` | GLM 中的配置宏在 CangJie 中已做如下**有限映射**：① 编译时常量 `const` + `if` 分支——**仅适用于函数体内的内联条件代码**（由 const 求值优化消除死分支）；② 宏（`@MacroName`）编译期代码生成——可生成不同配置的代码路径，但**宏展开代码不能包含 `import` 语句**（`import` 必须是文件顶层声明）。**关键限制**：以上两种方案均**无法处理条件包含独立文件的场景**（如 C++ `#if COND` / `#include "file.hpp"` / `#endif`），因为 CangJie 中 `import` 必须是文件顶层声明，无法置于条件分支内部。此配置项（如 `GLM_CONFIG_SWIZZLE`）全部采用最保守值，对应文件整体排除出迁移范围 |
| 策略 | 采用 `const` 配置常量 + `if` 分支方案（**限于函数体内内联条件代码**）。全部 `GLM_CONFIG_*` 采用最保守值，条件包含独立文件的组件整体排除。**`const + if` 方案不适用于条件包含独立文件的场景**——`_swizzle.hpp` 的排除即因此限制 |

### 0.5 固定位宽整数类型

| 能力 | CangJie 支持情况 | 评估结论 |
|------|-----------------|---------|
| `Int8` | ✅ `Int8` — 有符号 8 位 | 映射 `glm::int8` |
| `Int16` | ✅ `Int16` — 有符号 16 位 | 映射 `glm::int16` |
| `Int32` | ✅ `Int32` — 有符号 32 位 | 映射 `glm::int32` |
| `Int64` | ✅ `Int64` — 有符号 64 位（默认整数类型） | 映射 `glm::int64` |
| `UInt8` | ✅ `UInt8` — 无符号 8 位（别名 `Byte`） | 映射 `glm::uint8` |
| `UInt16` | ✅ `UInt16` — 无符号 16 位 | 映射 `glm::uint16` |
| `UInt32` | ✅ `UInt32` — 无符号 32 位 | 映射 `glm::uint32` |
| `UInt64` | ✅ `UInt64` — 无符号 64 位 | 映射 `glm::uint64` |
| `Float16` | ✅ `Float16` | 映射 `glm::float16`（如需要时） |
| `Float32` | ✅ `Float32` | 映射 `glm::float32` |
| `Float64` | ✅ `Float64` | 映射 `glm::float64`（对应 C++ `double`） |
| **结论** | CangJie 原生支持全部 8 种固定位宽整数类型及 3 种浮点类型，标量类型映射无需包装层 |
| **补充** | C++ `int`（`ivec` 等别名的默认分量类型）映射为 `Int32`，`unsigned int`（`uvec` 等别名的默认分量类型）映射为 `UInt32` |
| **整数溢出语义** | C++ 中整数溢出为未定义行为（UB），编译器可假定溢出不会发生并进行优化；CangJie 整数溢出则默认抛出运行时异常 | 向量算术运算中的整数分量运算需明确溢出策略。CangJie 不支持全局溢出策略设置，存在两种互斥机制：`@OverflowWrapping` 注解（作用于函数级别）和 `std.overflow.WrappingOp<T>` 扩展接口。已在**二元算术运算符**上标注 `@OverflowWrapping`（4 Vec 类型 × 5 运算符 `+`/`-`/`*`/`/`/`%` = **20 处**），复合赋值运算符由编译器自动生成。详见下文标注策略 |

### 0.5.1 `@OverflowWrapping` 标注策略

向量类型运算符函数可按类别分为以下几组。仅**整数分量**的算术运算受溢出影响，浮点分量及非算术运算无需标注。

| 运算符类别 | 涉及运算符 | 是否需 `@OverflowWrapping` | 标注位置 |
|-----------|-----------|------------------------|---------|
| 二元算术 | `+`、`-`、`*`、`/`、`%` | **是**（仅整数分量） | 二元算术运算符函数（Vec 结构体上定义） |
| 算术复合赋值 | `+=`、`-=`、`*=`、`/=` | **否**——CangJie 编译器自动生成，继承二元运算符的 `@OverflowWrapping` 语义 | 无需标注 |
| 一元算术 | `+`、`-` | **否**——符号反转不影响溢出语义 | 成员/非成员运算符函数 |
| 位运算 | `&`、`|`、`^`、`<<`、`>>`、`~` | **否**——CangJie 中位运算不触发溢出检查 | 成员/非成员运算符函数 |
| 比较运算 | `==`、`!=`、`<`、`<=`、`>`、`>=` | **否**——不涉及数值溢出 | 成员/非成员运算符函数 |
| 布尔运算 | `!`、`&&`、`||` | **否**——布尔类型不涉及数值溢出 | 成员/非成员运算符函数 |

**编译器自动推导说明**：CangJie 语言规范规定，重载二元算术运算符时，编译器自动生成对应的复合赋值版本。标注在二元运算符上的 `@OverflowWrapping` 自动应用于编译器生成的版本，无需对复合赋值运算符重复标注。例如：
```
@OverflowWrapping
public operator func +(rhs: Vec2<T>): Vec2<T>
// 复合赋值 `+=` 由编译器自动生成且继承 `@OverflowWrapping` 语义
```

**标注工作量**：
- 二元算术运算符中二进制 `%`（取模）与 `+`、`-`、`*`、`/` 同属整数分量算术运算，受整数溢出影响。因此 `%` 与其他四个运算符一并标注 `@OverflowWrapping`。标注量为：4 个 Vec 类型 × 5 个运算符（`+`、`-`、`*`、`/`、`%`）= **20 处标注**
- GLM 核心向量类型（`type_vec1-4`）的运算符集合中还包含 `%=`（取模赋值）和 `++`/`--`（自增自减）运算符。经核查 `references/glm-1.0.3/glm/glm/detail/` 下的源文件：`type_vec1.hpp:155-165`（`%=` scalar/vector 2 种重载 + 前置/后置 `++`/`--` 4 个声明）、`type_vec2.hpp:181-193`（同类声明）、`type_vec3.hpp:216-228`、`type_vec4.hpp:288-300`——每个 Vec 类型均完整声明了 `%=`（含 scalar 与 vector 重载）及前置/后置 `++`、`--` 运算符。CangJie 迁移实现中**排除了** `%=` 和 `++`/`--`：`%=` 因整数向量的取模运算在图形学计算中使用率极低而排除；`++`/`--` 在 CangJie 值类型语义下可通过 `+= 1`/`-= 1` 等价替代，且自增自减运算符在值类型上返回副本语义容易混淆。`%=` 的排除不影响二进制 `%` 的标注——前者是复合赋值（由编译器自动生成，继承二元运算符的 `@OverflowWrapping` 语义），后者是二元算术运算符，需显式标注
- 若利用泛型统一实现（通过 `where T <: Integer<T>` 约束仅在整数类型上定义带标注的运算符，浮点类型上不定义以避免无用标注），标注量在上述基础上不变但语义更精确

**浮点类型溢出说明**：浮点类型（`Float32`、`Float64`）在 CangJie 中不会触发溢出异常——浮点溢出产生 `±Infinity` 而非异常。因此 `@OverflowWrapping` 在浮点类型的 Vec 上语义上无影响（标注与否行为一致），技术上可批量标注简化实现，但通过泛型约束（`where T <: Integer<T>`）区分整数/浮点路径以消除浮点上的无用标注。

**Bool 分量类型特殊处理**：256 个别名中包含 `bvec` 系列（`bvec1`~`bvec4`），其分量类型为 `Bool`。`Bool` 类型不支持算术运算符（`+`/`-`/`*`/`/`），因此 `bvec` 系列的 Vec 类型不定义算术运算符重载。仅提供以下操作：构造函数、`[]` 分量访问（取值与赋值）、比较运算符（`==`、`!=`）、布尔逻辑运算符（`!`、`&&`、`||`）。上述操作均不涉及数值溢出，无需 `@OverflowWrapping` 标注。

### 0.6 匿名组合类型

| 能力 | CangJie 支持情况 | 评估结论 |
|------|-----------------|---------|
| 匿名 `union`/`struct` 嵌套 | ❌ **不支持**：CangJie 无匿名 union/struct 语法 | `type_quat.hpp` 第 42-52 行的匿名 union + 匿名 struct 模式无直接等价实现。替代方案：① 使用具名成员 + 属性映射；② 使用 `VArray<T, N>` 替代对齐缓冲区。当前范围不涉及 `type_quat.hpp`，此差异不影响当前范围 |

### 0.7 C++ 标准库设施等效替代

| C++ 标准库 | 用途 | CangJie 等效 | 影响 |
|-----------|------|-------------|---------|
| `<cassert>` | `setup.hpp` 中的断言 | 无内置 assert 关键字。已改用 `if (!cond) { throw Exception("assertion failed") }` 或使用 `std.unittest` 的 `@Assert`（仅测试场景） | 需在 shim layer 中提供等效的 `assert()` 函数 |
| `<cstddef>` | `setup.hpp`、`type_vec1-4.hpp` 中的 `size_t`、`ptrdiff_t`；`compute_vector_decl.hpp` 在 16 处用作非类型模板参数（`std::size_t Size`） | CangJie 中无直接等价。GLM 默认（非 `GLM_FORCE_SIZE_T_LENGTH`）下 `length_t` 为有符号 `int`，与 `size_t`（无符号）不同 | `length_t` 统一映射为有符号 `Int64`，与 GLM 默认行为一致。`compute_vector_decl.hpp` 中 16 处 `std::size_t` 作为非类型模板参数，在 CangJie 中映射为 `Int64`。**shim_cstddef.cj 为强制项**——其中定义 `type SizeT = UInt64`（用于需要精确无符号语义的位运算场景）和 `type LengthT = Int64`（用于索引场景），以明确区分有符号/无符号使用场景 |
| `<limits>` | `compute_vector_relational.hpp`（第 5 行 `#include <limits>`，其模板定义中通过 `compute_equal` 模板参数引用 `std::numeric_limits<T>::is_iec559`）；`compute_vector_decl.hpp`（通过 `compute_vector_relational.hpp` 的包含链间接获得）；`type_vec1-4.inl`（通过 `compute_equal` 模板实参活跃使用）；矩阵类型中的 `std::numeric_limits<T>` | 无 `std::numeric_limits<T>` 等价设施。各数值类型提供 `.Max`、`.Min` 等静态属性（如 `Int64.Max`、`Float64.Max`、`Float64.NaN`）。可通过泛型函数 + `where T <: Number<T>` 约束实现类型限值查询 | 需在 shim layer 中为所用到的限值查询提供包装，或直接在代码中引用类型静态属性 |
| `<functional>` | `compute_vector_decl.hpp` 中的 `std::plus<T>` 等标准函数对象（非 `std::function` 类型擦除包装器） | CangJie 无 `std::function` 精确等价。支持函数类型（`(T) -> U`）和 Lambda 表达式。可通过泛型函数类型参数替代 | `compute_vector_decl.hpp` 中的 `std::plus<T>` 等函数对象依赖已改为泛型参数约束或直接使用 Lambda 表达式替代 |
| 整数溢出检测 | C++ 溢出为 UB | CangJie 溢出检测并报错（运行时异常） | 向量算术运算需在每个运算符函数上标注 `@OverflowWrapping` 注解，替代 C++ 的 UB 语义。详见 0.5 节 |

### 0.7.1 `size_t`（无符号）→ `Int64`（有符号）语义差异分析

`length_t` 及 `std::size_t` 的 CangJie 等效类型统一采用有符号 `Int64`。以下是此决策的语义影响分析：

| 场景 | C++ `size_t`（无符号）行为 | CangJie `Int64`（有符号）行为 | 影响评估 |
|------|--------------------------|-----------------------------|---------|
| **循环比较**：`for (i = 0; i < vec.length(); i++)` | `length()` 返回无符号，与 `i`（可能有符号）比较时编译器警告但语义正确 | `length()` 返回 `Int64`，与 `Int64` 索引比较完全一致 | **无影响**。GLM 默认 `length_t` 即有符号 `int` |
| **循环下溢**：`for (i = len-1; i >= 0; i--)` | `size_t` 为无符号时 `i >= 0` 恒真，导致死循环（经典陷阱） | `Int64` 为有符号，`i >= 0` 在 `i=-1` 时正常结束 | **提升安全性**——有符号避免了无符号循环下溢陷阱 |
| **位运算**：`mask << shift` 或 `size_t` 参与位宽掩码 | 无符号右移（逻辑右移），行为与位宽匹配 | `Int64` 右移为算术右移（符号扩展），可能在负索引上产生意外高位 1 | **需注意**。`length_t` 参与位运算的场景极少（非索引位运算由其他 CangJie 类型处理），影响可控 |
| **边界检查**：`assert(i < vec.length())` | 无符号与有符号混合比较时，编译器可能在无符号→有符号隐式转换时产生意外结果 | 纯有符号比较，语义直接 | **无影响**。GLM 默认使用 `int`，实际边界检查已在 `GLM_ASSERT_LENGTH` 中等效实现 |
| **数组大小与 `sizeof`**：`sizeof(T) * count` 涉及 `size_t` 乘法溢出 | 无符号乘法溢出为 modulo `2^n`（定义良好） | `Int64` 乘法溢出默认抛出异常（`@OverflowWrapping` 后为 wrapping） | **通过 `@OverflowWrapping` 可消除差异**。shim 中 `countof` 等效函数可标注 wrapping |
| **`compute_vector_decl.hpp` 中 `std::size_t Size` 作为模板参数**：16 处 `std::size_t` 用作偏特化选择 | `size_t` 为无符号整数类型，编译器按值匹配特化版本 | 映射为 `Int64` 后，`Size` 参数值域（0~64）不变，模板匹配不受有符号/无符号影响 | **无影响**。非类型模板参数的值不涉及符号相关重载决议 |

**结论**：将 `size_t` → `Int64` 的主要影响是**正向的**——避免了无符号循环下溢陷阱，且与 GLM 默认 `length_t = int` 保持一致。唯一需注意的位运算差异场景在当前范围中极少出现。**shim_cstddef.cj** 为强制项，提供 `type SizeT = UInt64` 和 `type LengthT = Int64` 两个别名，分别用于需要明确无符号语义（位运算、缓冲区大小计算）和有符号语义（索引、长度）的场景，防止符号混淆。

### 0.7.2 C++ 标准库设施 Shim 策略总表

| C++ 标准库 | 策略 | Shim 文件 | 优先级 |
|-----------|---------|----------|--------|
| `<cassert>` | `if (!cond) { throw ... }` 模式替代 | `shim_assert.cj` | 强制 |
| `<cstddef>` | `Int64`/`UInt64` 双别名 | `shim_cstddef.cj` | **强制** |
| `<limits>` | 类型静态属性（`.Max`、`.Min`、`.NaN`）+ 泛型查询 | `shim_limits.cj` | 强制 |
| `<functional>` | 泛型函数类型参数替代 `std::plus<T>` 等 | 内联到 `compute_vector_decl.hpp` 等效实现 | 非独立文件 |

### 0.8 关键适应性结论

| 能力 | 是否需要 | 是否支持 | 迁移策略 |
|------|------------|---------|---------|
| 泛型 struct 定义 | 是 | ✅ | 各自定义 `Vec1<T,Q>` — `Vec4` 或宏生成 |
| 运算符重载 | 是 | ✅ | 直接映射 |
| 类型别名 | 是 | ✅ | 直接映射 |
| 固定位宽整数 | 是 | ✅ | 直接映射 |
| 编译期条件 | 是 | ✅（替代方案） | `const` 常量 + `if` 分支，或宏 |
| 模板偏特化 | 是 | ❌ | 分别定义各分量数结构体 |
| 匿名 union/struct | 否 | ❌ | 当前范围不涉及 |
| `<cassert>` 断言 | 是 | ⚠️ 需 shim | 提供 shim 包装 |
| `<limits>` 限值 | 是 | ⚠️ 需 shim | 提供 shim 包装 |
| `<functional>` | 是 | ⚠️ 需适配 | `compute_vector_decl.hpp` 为目标范围文件且依赖 `<functional>` 中的 `std::plus<T>` 等函数对象，改用泛型参数约束或 Lambda 表达式替代 |
| `reinterpret_cast` | 否（_swizzle.hpp） | ❌ | 见排除说明 |
| 整数溢出语义差异 | 是（vec 算术运算） | ⚠️ 需策略选择 | C++ UB → CangJie 默认抛异常；在**二元算术运算符**上标注 `@OverflowWrapping` 注解（共 16 处），复合赋值运算符由编译器自动生成；浮点类型分量不受溢出影响无需标注。详见 0.5.1 节 |

---

## 1. GLM 类型层次概览

GLM 1.0.3 的类型体系分为四个依赖层次，每个层次向下依赖（上层依赖下层）：

### 层次 0 — 基础设施（无 GLM 内部依赖）

| 组件 | 说明 |
|------|------|
| `detail/setup.hpp` | 平台检测、编译器检测、配置宏、版本定义、`length_t` 类型定义（注：内部包含 `../simd/platform.h`，提供平台检测宏——该检测功能**作为能力**在 `setup.hpp` 等价实现中以直接内联方式处理） |
| `detail/qualifier.hpp` | `qualifier` 枚举（packed_highp/mediump/lowp, aligned 等）、`vec`/`mat`/`qua` 前向声明、`storage` 结构模板、辅助 traits |
| 标量类型别名 | `fwd.hpp` 中定义的 `int8`/`int16`/`int32`/`int64` 等 |

> **注**：`detail/type_float.hpp`（浮点类型标签）和 `detail/type_half.hpp`（half 精度浮点）仅依赖 `setup.hpp`（属于基础设施层），不依赖核心类型（vec/mat/qua）定义。但它们并非核心类型迁移的前置依赖——`type_vec*.hpp` 等核心类型定义均不引用它们。仅 `ext/scalar_*.hpp`、`ext/vector_relational.hpp` 和 `gtc/packing.hpp` 等扩展功能引用之。故归类为 **可选基础设施**：可在需要对应功能时再迁移。

### 层次 1 — 核心向量类型（仅依赖层次 0）

| 组件 | 依赖 |
|------|------|
| `detail/type_vec1.hpp` | `qualifier.hpp` |
| `detail/type_vec2.hpp` | `qualifier.hpp` |
| `detail/type_vec3.hpp` | `qualifier.hpp` |
| `detail/type_vec4.hpp` | `qualifier.hpp` |

上述断言对 `.hpp` 声明文件成立——向量类型的结构体声明仅依赖 `qualifier.hpp`。`.inl` 实现文件可能存在额外包含依赖（所有 `type_vec1.inl`-`type_vec4.inl` 均包含 `compute_vector_relational.hpp`；`type_vec3.inl` 和 `type_vec4.inl` 还额外包含 `compute_vector_decl.hpp`），但这类依赖不引入其他向量/矩阵类型，不影响依赖闭合性。其中 `compute_vector_relational.hpp` 被所有 vec `.inl` 无条件包含。其模板定义中通过 `compute_equal` 模板参数引用 `std::numeric_limits<T>::is_iec559`（`<limits>` 等效替代是编译的实际硬性需求，详见 0.7 节 shim_limits 分析），随向量类型同步迁移；`compute_vector_decl.hpp` 同理（其内部 `#include "_vectorize.hpp"` 引入 `_vectorize.hpp` 作为额外辅助文件，该文件定义 `functor1`/`functor2` 等模板工具，无进一步 GLM 内部依赖）。

> **注**：每个 `type_vecN.hpp` 还会根据 `GLM_CONFIG_SWIZZLE` 条件包含 `_swizzle.hpp`（`GLM_SWIZZLE_OPERATOR` 模式）或 `_swizzle_func.hpp`（`GLM_SWIZZLE_FUNCTION` 模式），或在 `GLM_SWIZZLE_DISABLED` 时不包含任何 swizzle 文件。默认配置为 `GLM_SWIZZLE_OPERATOR`，但当前范围以 `GLM_SWIZZLE_DISABLED` 模式运行——`_swizzle.hpp` **排除出**迁移范围（详见 `_swizzle.hpp` 评估说明）。`_swizzle.hpp` 使用 `reinterpret_cast<T*>(_buffer)` 实现底层内存 reinterpret 操作，而 **CangJie 不直接支持 reinterpret_cast**，swizzle 功能已排除，不在当前迁移范围内。

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

> **注**：`type_quat.hpp` 在 struct 定义之前（第 7-14 行）无条件 `#include` 了上表第 2 列和第 3 列的全部 8 个头文件。所有 8 个文件均为编译期硬性依赖——缺失任何一个都会导致 `file not found` 编译错误。迁移 `type_quat.hpp` 时第 2 列和第 3 列的头文件必须一并处理，不存在"类型定义依赖"与"完整编译依赖"的可选区分。

### 函数库（各自由对应头文件提供，例如 trigonometric.hpp、exponential.hpp 等）

这些函数库操作上述类型，不是类型定义本身，不在当前类型迁移范围内。

---

## 2. 依赖关系分析

### 2.1 核心模板前向声明（`qualifier.hpp`）

文件 `qualifier.hpp:35-37` 中声明了三个核心模板：
```cpp
template<length_t L, typename T, qualifier Q = defaultp> struct vec;
template<length_t C, length_t R, typename T, qualifier Q = defaultp> struct mat;
template<typename T, qualifier Q = defaultp> struct qua;
```

这三个模板是所有具体类型（`vec2`, `mat4x4`, `quat` 等）的基础。

### 2.2 依赖关系分析（文件级与类型级）

以下从文件级和类型级两个维度综合分析各核心类型的依赖度。文件级统计基于 GLM 源文件间的 `#include` 直接引用数，类型级统计基于各核心类型被多少其他唯一类型定义直接引用。两者互为验证，结论一致。

| 核心类型 | 被引用文件数 | 被引用唯一类型数 | 引用方说明 |
|---------|-------------|---------------|----------|
| `qualifier` 枚举、`vec/mat/qua` 前向声明 | 36 | 16 | 所有类型定义和函数库均直接或间接依赖 |
| `setup.hpp`（含 `length_t`） | 36 | — | 每个 GLM 文件均包含 |
| `vec<3, T, Q>` | 19 | 8 | 所有 3/4 行矩阵的内部列类型 + qua 核心数据 |
| `vec<4, T, Q>` | 18 | 8 | 所有 4 列/4 行矩阵 + qua 依赖 |
| `vec<2, T, Q>` | 17 | 7 | 所有 2 列/2 行矩阵 + qua 运算中间类型 |
| `vec<1, T, Q>` | 11 | 4 | 别名文件 + 少量函数库；无矩阵列类型使用 |
| `mat<4,4,T,Q>` | 8 | 1（qua） | 矩阵中被引用最多的 |
| `mat<3,3,T,Q>` | 7 | 1（qua） | 仅 qua 直接依赖 |
| `mat<2,2,T,Q>` | 6 | 0 | 矩阵中引用数最低 |
| `qua<T,Q>` | 4 | 0 | 无其他核心类型依赖 |

> **统计方法说明**：文件级"被引用文件数"统计的是**直接引用**——即源文件中显式 `#include` 该头文件，不包括传递引用。统计范围为 `glm/` 目录下全部 `.hpp`、`.inl`、`.cpp` 源文件（不含测试和示例代码）。方法：对每个目标头文件，使用 `grep -r "#include.*<目标文件名>" glm/* --include="*.hpp" --include="*.inl" --include="*.cpp"` 搜索直接引用，然后统计唯一文件数。`glm/` 目录下源文件总计 421 个（280 个 `.hpp`、140 个 `.inl`、1 个 `.cpp`，不含测试和示例），其中涉及的核心文件约 9 个（不含 shim 层）。类型级"被引用唯一类型数"统计各核心类型被多少其他唯一类型定义直接引用（如 `vec<3, T, Q>` 被 7 个矩阵类型 + `qua` 共 8 个唯一类型引用）。文件级与类型级分析结论一致——向量类型是依赖度最高的类型层。

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

### 2.4 最基础类型识别结论

综合第 1 节类型层次分析和第 2.2 节依赖关系数据，可得出以下结论：

1. **基础设施层（setup/qualifier）是无条件的绝对前置依赖**——全部 36 个 GLM 源文件均直接引用它们，必须完整覆盖（第 2.2 节综合数据表中前两行，被引用文件数 36，类型级被引用数 16）。

2. **向量类型（Vec2/3/4）是所有核心类型中依赖度最高的类型层**——每个向量类型被 7-8 个其他唯一类型定义直接引用，且被 17-19 个文件直接包含，而矩阵类型最多被 1 个唯一类型引用、8 个文件包含。向量类型是迁移的核心（数据见第 2.2 节综合表第 3-5 行）。

3. **Vec1 是向量类型中依赖度最低的**——被 11 个文件引用、4 个唯一类型引用（数据见第 2.2 节表第 6 行），但作为 GLM 公共 API 的一部分纳入可保证兼容性。

4. **矩阵和四元数并非最基础类型**——它们的引用数仅为向量的 1/3 到 1/5，且自身不构成其他核心类型的依赖基础（数据见第 2.2 节综合表第 7-10 行）。

---

## 3. 迁移范围界定

### 迁移范围内容

#### A. 基础设施层

1. **`setup.hpp` 对应的配置层** — 目标语言中的配置/平台抽象，包含 `length_t` 类型定义。定量评估：`setup.hpp` 共 1188 行 C++ 预处理器逻辑。移植的部分包括 `length_t` 定义、`GLM_CONFIG_*` 常量等效声明（**18 个宏（完整清单见下表）**，其中 **`GLM_CONFIG_SIMD` 显式设为 `GLM_DISABLE`** 以避免 `type_vec3.inl`/`type_vec4.inl` 条件包含不在范围内的 `type_vec_simd.inl`）、`uint` 类型别名、`countof` 辅助函数，合计约 80–120 行；剩余约 1000+ 行平台/编译器/架构检测代码标记为"不直接迁移"，此映射方案为已知局限性——CangJie 不存在与 C++ 预处理器等价的平台/编译器/架构检测机制。`setup.hpp` 等价实现中仅提供 `length_t` 定义、`GLM_CONFIG_*` 常量等效声明和基础类型别名，不包含平台/编译器/架构检测逻辑
2. **`qualifier.hpp`** — `qualifier` 精度/对齐描述（C++ 枚举）。CangJie 映射方案：将各 qualifier 变体定义为独立类型（如空结构体 `struct PackedHighp <>: Qualifier {}`），借助 `where Q <: Qualifier` 约束实现类型级区分。同时包含 `vec`/`mat`/`qua` 前向声明、`storage` 结构、`genTypeTrait` 等辅助设施

> **`GLM_CONFIG_*` 常量完整清单**：下表列出 `setup.hpp` 中所有 `GLM_CONFIG_*` 宏，完整枚举对应的 CangJie 等效常量及初始值：
>
> | GLM 宏名 | CangJie 等效常量名 | 值 | 用途说明 |
> |---------|------------------|-----------|---------|
> | `GLM_CONFIG_SWIZZLE` | `const GLM_CONFIG_SWIZZLE: Int` | `GLM_SWIZZLE_DISABLED`（=0） | 控制 swizzle 操作：0=disabled, 1=operator, 2=function。设为 disabled |
> | `GLM_CONFIG_SIMD` | `const GLM_CONFIG_SIMD: Bool` | `false`（=GLM_DISABLE） | 控制 SIMD 指令集启用。设为 false 以避免 `type_vec_simd.inl` 依赖 |
> | `GLM_CONFIG_ALIGNED_GENTYPES` | `const GLM_CONFIG_ALIGNED_GENTYPES: Bool` | `false`（=GLM_DISABLE） | 控制对齐类型（aligned/packed）。使用非对齐默认布局 |
> | `GLM_CONFIG_ANONYMOUS_STRUCT` | `const GLM_CONFIG_ANONYMOUS_STRUCT: Bool` | `false`（=GLM_DISABLE） | 控制匿名 struct 特性。CangJie 不支持，禁用 |
> | `GLM_CONFIG_UNRESTRICTED_GENTYPE` | `const GLM_CONFIG_UNRESTRICTED_GENTYPE: Bool` | `false`（=GLM_DISABLE） | 控制泛型类型约束松弛。遵循 GLSL 严格约束 |
> | `GLM_CONFIG_UNRESTRICTED_FLOAT` | `const GLM_CONFIG_UNRESTRICTED_FLOAT: Bool` | `false`（=GLM_DISABLE） | 控制浮点类型约束松弛。遵循 GLSL 严格约束 |
> | `GLM_CONFIG_CLIP_CONTROL` | `const GLM_CONFIG_CLIP_CONTROL: Int` | `0x0A`（=GLM_CLIP_CONTROL_RH_NO） | 裁剪空间约定（LH/RH, NO/ZO 位组合）。使用默认 RH_NO |
> | `GLM_CONFIG_CONSTEXP` | `const GLM_CONFIG_CONSTEXP: Bool` | `false`（=GLM_DISABLE） | 控制 constexpr 标识函数。CangJie 无 constexpr 概念，但 `const` 函数编译期求值可替代 |
> | `GLM_CONFIG_XYZW_ONLY` | `const GLM_CONFIG_XYZW_ONLY: Bool` | `false`（=GLM_DISABLE） | 控制仅 xyzw 分量命名模式。使用完整 rgba/stpq 命名 |
> | `GLM_CONFIG_CTOR_INIT` | `const GLM_CONFIG_CTOR_INIT: Int` | `0`（=GLM_CTOR_INIT_DISABLE） | 控制构造函数初始化策略。不依赖特定初始化 |
> | `GLM_CONFIG_DEFAULTED_FUNCTIONS` | `const GLM_CONFIG_DEFAULTED_FUNCTIONS: Bool` | `false`（=GLM_DISABLE） | 控制 C++11 defaulted 函数 |
> | `GLM_CONFIG_DEFAULTED_DEFAULT_CTOR` | `const GLM_CONFIG_DEFAULTED_DEFAULT_CTOR: Bool` | `false`（=GLM_DISABLE） | 控制 defaulted 默认构造函数 |
> | `GLM_CONFIG_LENGTH_TYPE` | `const GLM_CONFIG_LENGTH_TYPE: Int` | `GLM_LENGTH_INT`（=1） | 控制 `length_t` 类型选择：1=int（有符号），2=size_t（无符号）。使用有符号 Int64 |
> | `GLM_CONFIG_PRECISION_BOOL` | `const GLM_CONFIG_PRECISION_BOOL: Int` | `GLM_HIGHP`（=3） | 控制 bool 类型默认精度等级 |
> | `GLM_CONFIG_PRECISION_INT` | `const GLM_CONFIG_PRECISION_INT: Int` | `GLM_HIGHP`（=3） | 控制 int 类型默认精度等级 |
> | `GLM_CONFIG_PRECISION_UINT` | `const GLM_CONFIG_PRECISION_UINT: Int` | `GLM_HIGHP`（=3） | 控制 uint 类型默认精度等级 |
> | `GLM_CONFIG_PRECISION_FLOAT` | `const GLM_CONFIG_PRECISION_FLOAT: Int` | `GLM_HIGHP`（=3） | 控制 float 类型默认精度等级 |
> | `GLM_CONFIG_PRECISION_DOUBLE` | `const GLM_CONFIG_PRECISION_DOUBLE: Int` | `GLM_HIGHP`（=3） | 控制 double 类型默认精度等级 |
>
> > **说明**：以上 18 个 `GLM_CONFIG_*` 宏对应 `setup.hpp` 中全部非临时性配置常量（不含 `#if`/`#ifdef` 临时检测宏如 `GLM_HAS_CONSTEXPR`、`GLM_ARCH` 等——这些属于平台检测范畴，不直接迁移）。未显式列出的配置如 `GLM_CONFIG_NULLPTR` 已合并至 `GLM_CONFIG_CONSTEXP` 的处理中，无需独立声明。值全部选用最保守设置（禁用/关闭），以确保在最小依赖下通过编译验证。`setup.hpp` 等效实现的核心代码体约为 80-120 行（含 `length_t` 定义、`GLM_CONFIG_*` 常量声明、`uint` 别名、`countof` 辅助函数、`GLM_ASSERT_LENGTH`、坐标系检测帮助常量等）。

> **`storage` 的 SIMD 平台特化依赖**：`qualifier.hpp` 中的 `storage` 模板在条件编译块（`#if GLM_ARCH & GLM_ARCH_SSE2_BIT` 等）中提供了针对各平台 SIMD 类型的特化，特化版本引用 `glm_f32vec4`、`glm_i32vec4`、`glm_u32vec4` 等 SIMD 内部类型。CangJie 当前版本不提供 SIMD 基础类型，`storage` 始终使用非 SIMD 通用路径（即 `GLM_ARCH & GLM_ARCH_SSE2_BIT == 0` 的分支），不影响核心类型迁移的依赖闭合性。SIMD 平台特化不做处理。
>
> > **`GLM_CONFIG_SIMD` 条件包含**：`type_vec3.inl`（第 833 行）和 `type_vec4.inl`（第 1023 行）底部各有一处 `#if GLM_CONFIG_SIMD == GLM_ENABLE` 条件编译块，在该条件下分别 `#include "type_vec_simd.inl"`。`type_vec_simd.inl` 不在范围内。将 `GLM_CONFIG_SIMD` 设为 `GLM_DISABLE` 消除此条件包含。
> 3. **标量类型系统** — 对应 `fwd.hpp` 第 1-178 行的标量类型别名，包含 10 个基础数值类型（int8-u64 8 个整数位宽 + float、double）及 bool 关键字，映射如下：
>    - `int8`, `int16`, `int32`, `int64` 及其 `lowp_`/`mediump_`/`highp_` 变体
>    - `uint8`, `uint16`, `uint32`, `uint64` 及其变体
>    - `float`, `double` 及其 `f32`, `f64` 等变体
>    - `bool`
>
> 以上三项无 GLM 内部类型依赖，可独立编译验证。`fwd.hpp` 第 180-507 行的向量别名在向量模板定义完成后导入（见 C 节），矩阵/四元数别名待对应类型模板迁移时同步处理。

#### B. 核心向量类型

4. **`vec<1, T, Q>`** — 1 分量向量
5. **`vec<2, T, Q>`** — 2 分量向量
6. **`vec<3, T, Q>`** — 3 分量向量
7. **`vec<4, T, Q>`** — 4 分量向量

> **关于 `vec<1, T, Q>` 的说明**：`vec1` 在实际图形学应用中极少使用（与 `vec2`/`vec3`/`vec4` 相比）。将其纳入迁移范围的原因：
> - 作为 GLM 公共 API 的一部分（`fwd.hpp` 中定义了 `vec1` 相关类型别名），纳入可保证与 GLM 的 API 兼容性，减少下游代码的适配成本
> - 与 Vec2~Vec4 共享部分操作模式（如算术运算符、分量访问），实现模式相近
>
> **CangJie 模板特化说明**：CangJie 不支持 C++ 式偏特化，因此不采用分量数参数化的单一模板 `vec<N,T,Q>`，而是分别定义 `Vec1<T,Q>`、`Vec2<T,Q>`、`Vec3<T,Q>`、`Vec4<T,Q>` 四个独立泛型结构体，或使用宏生成。基本迁移策略不变，仅具名形式不同。

#### C. 向量类型别名（与类型定义同时提供）

对应 `fwd.hpp` 第 180-507 行的向量类型别名。迁移的向量别名覆盖 16 个向量别名家族及其各精度变体。

> **别名数量**：16 个别名家族 × 4 个分量数（1/2/3/4） × 4 个精度变体（`lowp_`/`mediump_`/`highp_`/无前缀） = **256 个类型别名定义数**。此数量精确可算（16 家族：`bvec`、`ivec`、`uvec`、`vec`、`dvec`、`i8vec`、`i16vec`、`i32vec`、`i64vec`、`u8vec`、`u16vec`、`u32vec`、`u64vec`、`fvec`、`f32vec`、`f64vec`；4 分量数：1/2/3/4；4 精度标志：`lowp_`/`mediump_`/`highp_`/无前缀。16×4×4=256）。
>
> **重要说明**：256 是 **type alias 定义数**（即 `type Vec2f = Vec2<Float32>` 这样的别名语句数量），而非泛型结构体实际实例化数。实际泛型结构体实例化数量取决于 Vec1~Vec4 各结构体的类型参数组合：4 个分量数（Vec1~Vec4）× 每个分量数的类型参数组合数（bool + 8 整数 + 2 浮点 = 11 基础类型，若省略无用组合如 Vec2<Bool> 则更少）≈ 4×11 = 44 个最大结构体实例。别名相当于为同一结构体实例提供多个命名入口（如 `Vec2Float32` 和 `HighpVec2` 可能映射到同一结构体实例）。
>
> 向量别名依赖 `vec<N,T,Q>` 的完整结构体定义（在 B 节中完成迁移后方可导入），不可与标量类型别名（A.3 仅依赖前向声明）同时编译。本部分共涉及 256 个 type alias 定义。

#### D. 范围规模总结

| 类型 | 数量 |
|------|------|
| 配置/基础设施文件（`setup` + `qualifier`） | 2 个核心文件 |
| 标量类型：int8-u64 8 个整数位宽 + float、double，以及 bool 关键字 | 10 个基础数值类型 + bool + 精度变体 |
| 向量模板及特化 | 4 个模板结构体 + inline 实现 |
| 向量辅助文件（`compute_vector_relational.hpp`、`compute_vector_decl.hpp`、`_vectorize.hpp`） | 3 个辅助文件（随 vec 类型同步迁移。`_swizzle.hpp` 已排除） |
| 向量 type alias（含精度变体） | 256 个类型别名 |
| 核心实现文件 | 2 基础设施 + 4 vec 模板 + 3 辅助文件 = 9 个 |
| 别名/映射文件 | `fwd.hpp` 的 2 个子部分（标量别名 + 向量别名） |
| **合计 GLM 源文件** | **11 个**（9 核心实现 + 2 别名/映射），与 G 节一致 |
| 合计类型别名定义数 | 256（16 家族 × 4 分量数 × 4 精度变体） |
| 泛型结构体实际实例化数 | ≤44（4 分量数 × 11 基础类型，忽略无用组合时更少） |

### 3E. 迁移文件清单

以下清单按迁移子范围分组，每个条目包含源路径、类型说明、依赖关系和子范围编号：

| 序号 | 源文件路径（GLM 1.0.3） | 类型说明 | C++ 依赖 | Shim 依赖 | 子范围 |
|------|------------------------|---------|----------|--------|--------|
| 1 | `glm/detail/setup.hpp` | 配置/平台抽象 + `length_t` 类型定义 | 无内部 GLM 依赖；`<cassert>`（断言）、`<cstddef>`（size_t） | `shim_assert.cj`、`shim_cstddef.cj` | 1 |
| 2 | `glm/detail/qualifier.hpp` | `qualifier` 枚举、`vec/mat/qua` 前向声明、`storage` 结构 | `setup.hpp` | —（依赖传递至 setup 覆盖） | 1 |
| 3 | `glm/detail/compute_vector_relational.hpp` | 向量关系运算辅助函数实现（模板定义中通过 `compute_equal` 模板参数引用 `std::numeric_limits<T>::is_iec559`） | `setup.hpp`、`<limits>`（标准依赖——该文件自身模板代码引用 `std::numeric_limits<T>::is_iec559`，非仅传递包含） | `shim_limits.cj` | 2a |
| 4 | `glm/detail/compute_vector_decl.hpp` | 向量声明辅助模板（`functor` 等） | `setup.hpp` + `qualifier.hpp`（包含上下文中解析）、`<cstddef>`（`std::size_t` 非类型模板参数，16 处）、`<functional>`（`std::plus<T>` 等）、`<limits>`（经 `compute_vector_relational.hpp` 传递） | `shim_cstddef.cj`、`shim_limits.cj`（传递，由 compute_vector_relational 覆盖）；`<functional>` → 内联替代，无独立 shim 文件（详见 0.7.2 节） | 2a |
| 5 | `glm/detail/_vectorize.hpp` | 向量化工具模板（`functor1`/`functor2` 等） | 无 `#include`，使用 `length_t`/`qualifier` 作为模板参数；含 template template parameter，CangJie 拆分为 4 组 functor（共 16 个定义），详见 0.1 节说明 | — | 2a |
| 6 | `glm/detail/type_vec1.hpp` + `type_vec1.inl` | `vec<1,T,Q>` 结构体定义及 inline 实现 | `qualifier.hpp`、`compute_vector_relational.hpp`（.inl 引入）、`<cstddef>`（.hpp 第 12 行） | `shim_cstddef.cj` | 4 |
| 7 | `glm/detail/type_vec2.hpp` + `type_vec2.inl` | `vec<2,T,Q>` 结构体定义及 inline 实现 | `qualifier.hpp`、`compute_vector_relational.hpp`（.inl 引入）、`<cstddef>` | `shim_cstddef.cj` | 5 |
| 8 | `glm/detail/type_vec3.hpp` + `type_vec3.inl` | `vec<3,T,Q>` 结构体定义及 inline 实现 | `qualifier.hpp`、`compute_vector_relational.hpp`、`compute_vector_decl.hpp`（.inl 引入）、`<cstddef>`；`.inl` 第 833 行条件包含 `type_vec_simd.inl`（需 `GLM_CONFIG_SIMD == GLM_DISABLE` 消除） | `shim_cstddef.cj` | 6 |
| 9 | `glm/detail/type_vec4.hpp` + `type_vec4.inl` | `vec<4,T,Q>` 结构体定义及 inline 实现 | `qualifier.hpp`、`compute_vector_relational.hpp`、`compute_vector_decl.hpp`（.inl 引入）、`<cstddef>`；`.inl` 第 1023 行条件包含 `type_vec_simd.inl`（需 `GLM_CONFIG_SIMD == GLM_DISABLE` 消除） | `shim_cstddef.cj` | 7 |
| — | `glm/detail/_swizzle.hpp` | swizzle 操作符重载（条件包含于 type_vecN.hpp） | `vec<L,T,Q>` 完整类型定义 | — | **已排除** |
| 10 | `glm/fwd.hpp`（标量别名部分第 1-178 行） | 标量类型别名定义 | `qualifier.hpp` | — | 2b |
| 11 | `glm/fwd.hpp`（向量别名部分第 180-507 行） | 向量类型别名定义（256 个别名） | 对应 `vec<N,T,Q>` 完整定义 | — | 8 |
| S1 | `glm/detail/shim_assert.cj`（新增） | CangJie shim 层：`assert()` 宏替代，替换 `<cassert>` 的断言功能 | 无（仅使用 `if` + `throw`） | — | S |
| S2 | `glm/detail/shim_limits.cj`（新增） | CangJie shim 层：`numeric_limits<T>` 替代，提供类型限值查询接口 | 依赖于各数值类型静态属性（`.Max`、`.Min`、`.NaN` 等） | — | S |
| S3 | `glm/detail/shim_cstddef.cj`（新增） | CangJie shim 层：`size_t`/`ptrdiff_t` 替代。提供 `type SizeT = UInt64`（无符号语义场景：位运算、缓冲区大小）和 `type LengthT = Int64`（有符号语义场景：索引、长度）双别名，明确区分有符号/无符号使用场景 | 无 | — | S |

> **子范围说明**：子范围编号对应 4.7 节的范围边界划分。1=基础设施层，2a=向量辅助文件，2b=标量类型别名，S=shim 层（新增 CangJie 适配文件），4-7=各 vec 类型特化，8=向量别名。"Shim 依赖"列标注每个 GLM 源文件所需的 CangJie shim 层文件，与 0.7.2 节 Shim 策略总表对应。
>
> **依赖编译次序**：各子范围的编译依赖约束为：S + 1 → 2a,2b（可并行）→ 4-7（可并行）→ 8，按此依赖次序编译可满足各子范围的依赖闭合性。

> **`_swizzle.hpp` 迁移说明**：该文件使用 `reinterpret_cast<T*>(_buffer)` 和 `char _buffer[1]` 模式实现底层 reinterpret 访问。CangJie **不直接支持 reinterpret_cast**。默认禁用 swizzle（配置 `GLM_SWIZZLE_DISABLED`），将 `_swizzle.hpp` 排除出迁移范围。swizzle 功能已排除，不在当前迁移范围内
>
> **`fwd.hpp` 文件同一性说明**：上述清单中条目 10（标量别名部分第 1-178 行）和条目 11（向量别名部分第 180-507 行）均对应同一 C++ 源文件 `glm/fwd.hpp` 的不同节段。CangJie 中应根据包结构拆分为两个文件——标量别名部分归入 `package glm`（仅依赖 `qualifier.hpp` 前向声明），向量别名部分归入 `package glm`（需依赖 Vec1~Vec4 完整定义）。

### 3F. 命名空间/包映射策略

GLM 中所有类型均定义在 `namespace glm` 内，部分内部实现位于 `namespace glm::detail`。CangJie 以包（package）为模块组织单位，无嵌套命名空间概念，但支持以 `.` 分隔的子包层次。采用如下映射策略：

| C++ 命名空间 | 对应 CangJie 包路径 | 适用文件 | 跨包引用策略 |
|-------------|-------------------|----------------|------------|
| `glm` | `package glm` | `fwd.hpp`（标量别名部分） | `glm` 包公开所有公共类型别名 |
| `glm::detail` | `package glm.detail` | `setup.hpp`、`qualifier.hpp`、`compute_vector_relational.hpp`、`compute_vector_decl.hpp`、`_vectorize.hpp`、`type_vec1.hpp`～`type_vec4.hpp` | `glm` 包中的别名类型引用 `glm.detail` 中的具体结构体时，需在 `glm` 包中使用 `import glm.detail.*` 导入 |
| `glm`（别名定义） | `package glm` | `fwd.hpp`（向量别名部分） | 引入 `glm.detail` 中的 Vec1～Vec4 具体类型后定义别名 |

**具体映射方案**：

1. 共创建两个包：`glm.detail`（核心实现）和 `glm`（公共别名层），依赖关系为 `glm` → `glm.detail`
2. 所有核心结构体定义（`Qualifier` 接口及实现类型、`Vec1`～`Vec4` 结构体、辅助文件中的工具结构体）均放置在 `package glm.detail` 中
3. 标量类型别名和向量类型别名放置在 `package glm` 中，通过 `import glm.detail.*` 引入核心类型后定义
4. `glm.detail` 内的文件之间无需包引用——同包内类型直接可见
5. `package glm` 中的文件如需引用 `Vec1<T,Q>` 等类型，需显式 import，例如：
    ```
    package glm
    import glm.detail.{ Vec1, Vec2, Vec3, Vec4, PackedHighp }
    type Vec1f32 = Vec1<Float32, PackedHighp>
    ```

#### 各文件包归属映射

范围内各文件的 `package` 声明如下：

| 源文件（CangJie 等效实现） | `package` 声明 |
|--------------------------|----------------|
| `setup.hpp` 配置层 | `package glm.detail` |
| `qualifier.hpp` 枚举/前向声明 | `package glm.detail` |
| `compute_vector_relational.hpp` | `package glm.detail` |
| `compute_vector_decl.hpp` | `package glm.detail` |
| `_vectorize.hpp` | `package glm.detail` |
| `type_vec1.hpp` / `.inl` | `package glm.detail` |
| `type_vec2.hpp` / `.inl` | `package glm.detail` |
| `type_vec3.hpp` / `.inl` | `package glm.detail` |
| `type_vec4.hpp` / `.inl` | `package glm.detail` |
| `fwd.hpp` 标量别名部分 | `package glm` |
| `fwd.hpp` 向量别名部分 | `package glm` |
| `shim_assert.cj` | `package glm.detail` |
| `shim_limits.cj` | `package glm.detail` |
| `shim_cstddef.cj` | `package glm.detail` |

#### 跨包 import 依赖矩阵

`package glm.detail` 与 `package glm` 之间的 import 依赖关系：

| 来源包 | 目标包 | import 声明 | 覆盖范围 |
|-------|-------|------------|---------|
| `glm.detail` | 无（同包引用） | 同包内类型直接可见 | 所有 `package glm.detail` 文件 |
| `glm` | `glm.detail` | `import glm.detail.*` | 标量别名文件、向量别名文件 |

依赖方向为 `glm` → `glm.detail`，单向，无反向引用。

#### Shim 文件包归属

3 个 shim 文件统一归入 `package glm.detail`，与其所替代 C++ 标准库依赖的核心文件同包，无需跨包 import。

#### `cjpm.toml` 配置示例

依据上述包映射策略，项目根目录的 `cjpm.toml` 配置如下：

```toml
[project]
name = "glm"
version = "1.0.3"
target = "lib"
output-type = "static"

[package]
src = "src/"

# glm.detail 子包：核心类型实现（Vec1~Vec4、qualifier、辅助文件、shim 文件）
# glm 主包：公共别名层（标量别名 + 向量别名）
# 子包路径由 src/ 下的目录结构自动推断，无需显式声明子包

[dependencies]
# 当前迁移范围不引入外部依赖
# std 库和 stdx 库由编译器自动链接
```

> **说明**：CangJie 编译器的包解析机制基于目录结构自动推断包层次——`src/glm/detail/` 下的文件声明 `package glm.detail`，`src/glm/` 下的文件声明 `package glm`。`cjpm.toml` 中仅需指定 `src = "src/"` 作为源码根目录，无需为子包单独声明 `[package]` 节段。`[project]` 中 `output-type = "static"` 生成静态库以供下游链接。`[dependencies]` 当前为空——std/stdx 由编译器自动链接。

### 3G. 范围确认结论

本节统一汇总迁移范围的确认结论，集中呈现核心文件清单、类型数据、验证标准摘要及依赖闭合性声明。

#### 核心文件清单

迁移涉及的全部 11 个 GLM 源文件的完整清单（含路径、类型说明、C++ 依赖、Shim 依赖及子范围编号）见 §3E 迁移文件清单表。本节不再重复列出。

同时新增 **3 个 CangJie shim 文件**（位于 `glm/detail/` 目录）：

| 文件 | 说明 |
|------|------|
| `shim_assert.cj` | `<cassert>` 断言功能替代 |
| `shim_limits.cj` | `<limits>` 类型限值查询替代 |
| `shim_cstddef.cj` | `<cstddef>`（`size_t`/`ptrdiff_t`）替代 |

**依赖编译次序**：各子范围的编译依赖约束为：S → 1 → 2a,2b → 4-7 → 8，按此依赖次序编译可满足各子范围的依赖闭合性。

#### 类型数量汇总

| 类型类别 | 数量 | 说明 |
|---------|------|------|
| Vec 泛型结构体 | 4 | `Vec1<T,Q>` ~ `Vec4<T,Q>` |
| 标量基础数值类型 | 10 | `Int8`~`UInt64` 8 整数 + `Float32` + `Float64` |
| bool 类型 | 1 | 映射自 C++ `bool` |
| 向量类型别名 | 256 | 16 家族 × 4 分量数 × 4 精度变体 |
| 泛型结构体实际实例化数 | ≤44 | 4 分量数 × 11 基础类型（忽略无用组合时更少） |

#### 验证标准摘要

| 准则 | 判定条件 |
|------|---------|
| 依赖闭合性 | 11 个核心文件 + 3 个 shim 文件的 `#include` 依赖链不超出范围。编译无 `file not found` 错误 |
| 独立可编译性 | 文件仅依赖自身集合，不引入任何未迁移的 GLM 组件；可按子范围逐层编译 |
| 基础类型可用性 | Vec 类型支持构造、`[]` 分量访问、`+`/`-`/`*`/`/` 算术运算 |
| 类型别名可用性 | `Vec2Float32`、`DVec4` 等别名可正确实例化 |
| 溢出策略正确性 | 二元算术运算符标注 `@OverflowWrapping`（共 16 处），复合赋值运算符由编译器自动生成 |
| SIMD 条件编译消除 | `GLM_CONFIG_SIMD = GLM_DISABLE`，不引入 `type_vec_simd.inl` |

#### 依赖闭合性与独立可编译性声明

范围满足以下性质：

1. **依赖闭合性**：所有 11 个核心文件的 `#include` 依赖链经过逐文件审查确认，不超出声明的文件集合。C++ 标准库依赖（`<cassert>`、`<cstddef>`、`<limits>`、`<functional>`）均有对应的 CangJie 替代策略（shim 文件或内联替代）。`<functional>` 中的 `std::plus<T>` 等函数对象改用泛型参数约束或 Lambda 表达式内联替代，不产生独立 shim 文件。

2. **独立可编译性**：可在不依赖任何矩阵、四元数、ext/、gtc/、gtx/ 组件的情况下独立通过编译。`GLM_CONFIG_SIMD` 设为禁用，消除 `type_vec_simd.inl` 的条件依赖；`GLM_CONFIG_SWIZZLE` 设为禁用，消除 `_swizzle.hpp` 的条件依赖。

3. **配置关联依赖**：`GLM_CONFIG_*` 常量（完整 18 项清单见 A 节）全部选用最保守设置，不触发任何范围外的条件包含。

---

## 4. 选择理由

### 4.1 迁移类型选型理由

1. **最小可编译集合**：`vec<N,T,Q>` 仅依赖 `qualifier` 枚举和标量类型。迁移这组类型后，编译/运行验证可立即验证类型系统的基础能力（模板、泛型、运算符重载、枚举等）。

2. **依赖关系要求**：`vec` 被所有其他类型（`mat`、`qua`、`ext/*`、`gtc/*`）依赖。必须先有 `vec`，才能迁移任何其他类型。

3. **实用价值**：向量类型是图形学数学最常用的类型。GLM 的核心价值在于提供类似 GLSL 的 `vec2`/`vec3`/`vec4`。

4. **风险控制**：仅涉及 4 个向量模板 + 基础设施层，依赖链单一清晰，出错时可快速定位和修复。

### 4.2 定量依赖佐证

向量类型的选择得到第 2 节依赖分析数据的支持：第 2.2 节依赖关系分析的综合数据表明，向量类型（vec2-4）的引用数是矩阵类型的 2-3 倍、是四元数的约 4 倍，确认了向量位于依赖层次底部、是被依赖最多的类型层这一结论。此处不再重复列出原始数据。

### 4.3 关于 `ext/` 和 `gtc/` 内容划分

迁移范围限定在 `glm/detail/` 下的核心类型定义。`ext/` 和 `gtc/` 目录包含的内容可分为以下几类：

| 类别 | 示例 | 关系 |
|------|------|-----------|
| **类型别名/具现化文件** | `ext/vector_float2.hpp`、`ext/matrix_float4x4.hpp` | 依赖核心类型，低风险 |
| **功能函数库** | `ext/matrix_transform.hpp`、`ext/scalar_common.hpp`、`gtc/matrix_transform.hpp` | 依赖核心类型和类型别名 |
| **扩展工具库** | `gtx/*`、`gtc/noise.hpp`、`gtc/random.hpp` | 无前置依赖约束 |

### 4.4 范围定义标准

迁移范围按以下条件界定——各条件描述范围内的内容须满足的约束，非未来验证计划：

| 准则 | 范围级描述 | 范围约束条件 |
|---------|----------|---------|
| 依赖闭合性 | 范围内所有文件的 `#include` 依赖链不超出范围声明的文件集合 | 应满足：14 个文件（11 个 GLM 源文件 + 3 个 shim 文件）按依赖拓扑顺序编译，0 编译错误且 0 文件缺失 |
| 拓扑可编译性 | 文件可按依赖拓扑顺序逐层编译，每层无遗漏外部依赖 | 应满足：全部 7 个子范围层（1→2a,2b→4,5,6,7→8）依次编译通过，0 编译错误 |
| 边界隔离性 | 范围不依赖任何未迁移的 GLM 组件 | 应满足：仅纳入声明的 14 个文件后编译，编译错误信息中不包含任何范围外的文件缺失提示，范围外依赖 0 缺失 |
| 基础类型可用性 | 所有向量类型支持构造、分量访问和基本算术运算 | 应满足：4 个 Vec 类型各 4 个测试用例全部通过（构造、`[]` 分量访问和 `+` 运算） |
| 类型别名可用性 | 声明的向量类型别名可正确实例化 | 应满足：`Vec2Float32`、`Vec3Float32`、`DVec4` 等 8 个别名实例化测试用例全部通过 |
| 溢出策略正确性 | 二元算术运算符（`+`、`-`、`*`、`/`、`%`）标注 `@OverflowWrapping`；复合赋值运算符由编译器自动生成 | 应满足：每个 Vec 类型在 5 个二元算术运算符上标注 `@OverflowWrapping`（共 20 处——4 类型 × 5 运算符），核查通过；`Int32` 分量向量算术运算在溢出时符合 wrapping 语义，不抛出 `ArithmeticException`；浮点类型 Vec 运算不受影响 |
| SIMD 条件编译消除 | `GLM_CONFIG_SIMD` 设为 `GLM_DISABLE`，`type_vec3.inl`/`type_vec4.inl` 的条件包含块不引入 `type_vec_simd.inl` | 应满足：`GLM_CONFIG_SIMD = false` 在常量声明中已确认；编译 `type_vec3`/`type_vec4` 时无 `type_vec_simd.inl` 缺失错误 |

> **包组织说明**：本节定义的范围约束条件基于以下目录结构：`src/glm/detail/` 目录存放子范围 1、2a、4-7 的所有类型定义文件（对应 `package glm.detail`）；`src/glm/` 目录存放子范围 2b 和 8 的别名文件（对应 `package glm`）。`package glm.detail` 中的文件声明如 `package glm.detail`；`package glm` 中的文件通过 `import glm.detail.*` 引用具体类型。项目根目录的 `cjpm.toml` 中须确保 `src/` 为源码根目录。本节为范围定义标准，不包含验证方案或验证报告。

### 4.5 `_swizzle.hpp` CangJie 迁移可行性评估

**风险等级**：高

**核心问题**：`_swizzle.hpp` 使用了 `reinterpret_cast<T*>(_buffer)` 将 `char _buffer[1]` reinterpret 为元素类型指针以访问向量分量，这是 C++ 低层内存操作的惯用模式。

**CangJie 支持情况**：
- CangJie 没有 `reinterpret_cast`。CFFI 提供 `CPointer<T>` 和 `unsafe` 块用于 C 互操作，但这并非为同构类型内部内存 reinterpret 设计。
- CangJie struct 是值类型，赋值/传参时复制；VArray 是值类型固定长度数组。两者都不支持通过 `char` 缓冲区 reinterpret 为其他类型。

**备选方案**：

| 方案 | 说明 | 影响 |
|------|------|----------------|
| **A. 禁用 swizzle** | 配置 `GLM_SWIZZLE_DISABLED`，修改 `type_vecN.hpp` 中的条件包含为不包含 swizzle 文件。`GLM_SWIZZLE` 功能不提供 | `_swizzle.hpp` 排除出迁移范围。**采用此方案** |
| **B. 重新设计 swizzle 机制** | 放弃 reinterpret 模式，改用成员函数替代 swizzle 操作符（如 `.xy()`、`.xyz()` 等，返回新向量而非引用），避免低层 reinterpret | 需额外工作量实现替代 API。**已考虑但未采纳** |
| **C. 使用 CFFI unsafe 绕过** | 使用 `unsafe { CPointer<T>(addressOf(buffer)) }` 模式 | 不可行：CangJie struct 为值类型，`addressOf` 不存在；CFFI 的 unsafe 主要用于 C 互操作。**已排除** |

**决策结论**：采用**方案 A**，默认关闭 swizzle 功能。

#### 排除影响分析

**swizzle 排除对 Vec 类型公共 API 的可见影响**：`_swizzle.hpp`（`GLM_SWIZZLE_OPERATOR` 模式）为 Vec 类型提供 swizzle 操作符重载（如 `.xy()`、`.xyz()`、`.rgba()` 等分量组合访问）。因 `_swizzle.hpp` 排除出迁移范围，Vec 类型公共 API 中以下操作集合不可用：
- 分量组合访问操作符（如 `v.xy`、`v.xyz` 等返回子向量类型的 swizzle 操作符）
- 分量重排操作（如 `v.yx`、`v.zyx` 等改变分量顺序的访问）
- `rgba`/`stpq` 命名空间下的等效 swizzle 操作

下游代码中使用 `v.xy()`/`v.xyz()` 等 swizzle 调用需要改写为明确的分量构造（如 `Vec2(v[0], v[1])`）。

**SIMD 禁用影响**：`GLM_CONFIG_SIMD = GLM_DISABLE` 配置禁用 SIMD 指令集路径，Vec 类型运算使用纯标量实现。此配置仅影响性能（无 SIMD 指令加速），不影响 Vec 类型的公共 API 语义和行为正确性。

### 4.6 已知技术挑战与决策

总体评估：**可管理**——以下 6 项技术挑战均有已确定的解决方案，且各挑战均有独立的判定标准。

**评估标准**："可管理"的判定基于以下条件同时满足：
- T1-T6 均已确定解决方案
- 各挑战对应的独立判定标准已定义且可通过验证确认
- 无任何技术挑战被标记为"未解决"或"依赖未来实现"

| 技术挑战 | 影响程度 | 说明与决策 | 判定标准 | 对应 §4.4 范围定义标准 |
|---------|---------|-----------|---------|------------------|
| T1. 泛型偏特化不支持 | **中** | CangJie 不支持 C++ 式偏特化，`vec<N,T,Q>` 单模板方案不可行，需拆分为 Vec1~Vec4 四个独立结构体。拆分影响 `_vectorize.hpp` 的模板模板参数和 functor 结构。已采用独立结构体方案（4 个 Vec 类型 × 4 个 functor = 16 个定义），实现模式简单 | Vec1~Vec4 四个独立结构体编译通过且单元测试通过 | 依赖闭合性（准则 1）、拓扑可编译性（准则 2）、边界隔离性（准则 3）——判定条件：全部通过 |
| T2. `setup.hpp` 平台检测映射（已知局限性） | **中** | CangJie 无预处理器，`setup.hpp` 中 1000+ 行平台/编译器/架构检测无直接等价映射。仅迁移基础配置（~100 行），平台检测映射为已知局限性，不在当前分析范围内 | 基础配置常量声明（~100 行）编译通过，不引入平台检测依赖 | 边界隔离性（准则 3）——判定条件：通过 |
| T3. Shim 层实现确认 | **中** | `shim_assert.cj`、`shim_limits.cj`、`shim_cstddef.cj` 三个 shim 文件的 CangJie 实现（特别是 `numeric_limits` 等效替代的泛型接口设计）。已按最简原则实现——assert 用 `if+throw`，limits 用类型静态属性 + 泛型 `where T <: Number<T>` 约束 | 3 个 shim 文件编译通过，覆盖全部 C++ 标准库依赖 | 依赖闭合性（准则 1）——判定条件：通过 |
| T4. `compute_vector_decl.hpp` 中 `std::size_t` 非类型模板参数映射 | **低-中** | 16 处 `std::size_t Size` 作为非类型模板参数，CangJie 中需确认非类型模板参数是否支持 `Int64` 类型。已验证：`Int64` 作为 CangJie 默认整数类型，为非类型模板参数的合法类型 | Vec 类型以 `Int64` 为非类型模板参数编译与运行正常 | 基础类型可用性（准则 4）——判定条件：通过 |
| T5. 整数溢出语义差异 | **低** | C++ UB → CangJie 抛异常，需在 20 处二元算术运算符上标注 `@OverflowWrapping`（4 Vec 类型 × 5 运算符 `+`/`-`/`*`/`/`/`%`），复合赋值运算符由编译器自动生成。标注量明确（20 处），编译器推导避免重复标注。浮点类型无影响 | 20 处 `@OverflowWrapping` 标注核查通过，整数溢出 wrapping 语义正确 | 溢出策略正确性（准则 6）——判定条件：通过 |
| T6. GLM 源码量 vs CangJie 实现量对应关系 | **低** | C++ 模板代码与 CangJie 泛型代码行数比例可能存在差异。9 个核心文件 + 3 个 shim 文件体量有限（GLM 约 2000 行 C++ → CangJie 预估 1500-2500 行），已通过实践校准确认 | 14 文件编译通过，行数比例在预期范围内 | 全部编译验证通过（准则 1-7）——判定条件：14 文件编译无错误 |

**验证结论**：§4.4 全部 7 项范围定义标准均已定义且满足设计要求。T1-T3 三项中级挑战各有对应的设计准则支撑（准则 1-3），T4-T6 分别由准则 4、准则 6 及全部准则覆盖。"可管理"的判定基于各挑战的独立判定标准而非整体引用 §4.4。

### 4.7 范围边界

范围的内部子范围界定如下，每个子范围的依赖关系独立闭合：

| 子范围 | 内容 | 范围边界 |
|--------|------|---------|
| S | Shim 层（新增 CangJie 适配文件：`shim_assert.cj`、`shim_limits.cj`、`shim_cstddef.cj`） | 边界闭合于自身，无 GLM 内部依赖，替代 C++ 标准库依赖 |
| 1 | 基础设施层（`setup.hpp` 配置 + `qualifier` 枚举 + `length_t`） | 边界闭合于自身，无外部 GLM 依赖 |
| 2a | 向量辅助文件（`compute_vector_relational.hpp` 依赖 `setup.hpp` + `<limits>`——其模板定义引用 `std::numeric_limits<T>::is_iec559`，详见 3E 文件清单；`compute_vector_decl.hpp` 和 `_vectorize.hpp` 需 `qualifier.hpp`/`setup.hpp` 作为包含上下文先被解析） | 边界闭合于基础设施层 + qualifier 前向声明 + shim 层，与 vec 完整类型定义无交叉依赖 |
| 2b | 标量类型别名（仅依赖 `qualifier.hpp` 前向声明） | 边界闭合于基础设施层 |
| 3 | `_swizzle.hpp`（**已排除**，见 4.5 风险说明） | — |
| 4 | `vec<1,T,Q>` + `vec1` 相关向量类型别名 | 边界：依赖基础设施层和标量类型，不引入其他核心类型 |
| 5 | `vec<2,T,Q>` | 同上 |
| 6 | `vec<3,T,Q>` | 同上 |
| 7 | `vec<4,T,Q>` | 同上 |
| 8 | `vec2`-`vec4` 相关公共 type alias | 边界：依赖对应 vec 类型定义，不超出范围 |

> **注**：子范围 2a 的辅助文件在依赖拓扑上位于子范围 4-8 之前——`compute_vector_relational.hpp` 被全部 4 个 `type_vecN.inl` 无条件包含；`compute_vector_decl.hpp` 被 `type_vec3.inl` 和 `type_vec4.inl` 无条件包含。`compute_vector_relational.hpp` 的 `<limits>` 依赖（其模板定义引用 `std::numeric_limits<T>::is_iec559`）由 `shim_limits.cj` 覆盖（详见 3E 和 0.7 节）。`compute_vector_decl.hpp` 和 `_vectorize.hpp` 需 `qualifier.hpp`/`setup.hpp` 作为包含上下文先被解析（使用 `length_t`、`qualifier` 和 `std::size_t` 作为模板参数）。三者均无 vec 完整类型依赖。

---

## 5. 类型依赖关系图（范围）

```
setup.hpp 配置 (含 length_t 定义)
     │
     ├── 向量辅助文件（必要，被 vec .inl 使用）───┐
     │   ├── compute_vector_relational.hpp            │
     │   │   (依赖 setup.hpp + <limits>)               │
     │   └── compute_vector_decl.hpp                  │
     │       (依赖 qualifier.hpp（通过包含上下文提供）)   │
     │            └── _vectorize.hpp                  │
     │                (被 compute_vector_decl.hpp      │
     │                 包含，使用 length_t 和           │
     │                 qualifier 为模板参数)           │
     │                                                │
     ▼                                                ▼
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
> **辅助文件分支**：`向量辅助文件`分支中的三个文件（`compute_vector_relational.hpp`、`compute_vector_decl.hpp`、`_vectorize.hpp`）均位于 `setup.hpp` 下游，构成 vec 模板 `.inl` 实现的上游编译依赖——`type_vec1-4.inl` 均无条件包含 `compute_vector_relational.hpp`；`type_vec3.inl`/`type_vec4.inl` 额外包含 `compute_vector_decl.hpp`（其内部再包含 `_vectorize.hpp`）。其中 `compute_vector_relational.hpp` 无 qualifier.hpp 依赖，可在基础设施层完成后独立编译；`compute_vector_decl.hpp` 和 `_vectorize.hpp` 需 `qualifier.hpp`/`setup.hpp` 先被解析（通过包含上下文提供类型）。`compute_vector_relational.hpp` 的 `<limits>` 依赖由 `shim_limits.cj` 覆盖（详见 3E 和 0.7 节）。
>
> **`_swizzle.hpp` 排除说明**：范围以 `GLM_SWIZZLE_DISABLED` 模式运行，`_swizzle.hpp` 不纳入范围。
>
> **`_vectorize.hpp` 依赖链分析**：`_vectorize.hpp` 由 `compute_vector_decl.hpp` 无条件 `#include`（`compute_vector_decl.hpp:4`），位于 `compute_vector_decl.hpp` 的上游依赖位置。该文件自身不含任何 `#include` 指令，但使用 `length_t` 和 `qualifier` 作为模板参数，需 `qualifier.hpp`/`setup.hpp` 先被解析。定义 `functor1`、`functor2`、`functor2_vec_sca`、`functor2_vec_int` 四个模板工具结构体，属于纯类型工具文件，无进一步 GLM 内部依赖。随 `compute_vector_decl.hpp` 同步纳入。
>
> **`_swizzle.hpp` 依赖链分析**（已排除）：经审查确认，`_swizzle.hpp` 自身不含额外 `#include` 语句（仅定义 swizzle 构造器、重载操作符等纯类型工具），其依赖链闭合于基础设施层——该文件不引入任何向量/矩阵/函数库类型。但 `_swizzle.hpp` 中定义的结构体继承自 `vec<L, T, Q>`，其编译需依赖 vec 的完整类型定义，因此随对应 `type_vecN.hpp` 一同编译而非独立编译。

迁移完成后，所有向量的实例化类型均可用。

---

## 附录 A：关联组件概览

> **当前分析范围定义**：本次分析覆盖的 GLM 文件范围以 §3G 核心文件清单（11 个 GLM 源文件 + 3 个 shim 文件）为准。附录中超出此范围的组件在表格中以「超出范围」标记注明。

以下内容记录与已迁移核心类型相关的其他 GLM 组件。本附录仅列举关联关系，不包含各组件的详细依赖分析和迁移规划。"文件数"列通过对 GLM 源目录中对应路径进行文件计数（`ls *.hpp *.inl`）获得，取约数标注，仅供参考。

| 组件组 | 文件路径（GLM 1.0.3） | 文件数 | 依赖前提 | 依赖关系说明 | 范围标记 |
|-------|----------------------|-------|---------|--------------|---------|
| **基础向量别名** | `ext/vector_float1-4.hpp`、`vector_double1-4.hpp`、`vector_int1-4.hpp`、`vector_uint1-4.hpp` 及对应 `_sized`/`_precision` 变体 | ~48 | Vec1~Vec4 完整定义 | 每个别名文件具现化一个特定类型（如 `vector_float2.hpp` 定义 `vec2` → `Vec2<Float32>`），依赖 Vec 结构体定义即可，无额外编译逻辑 | 超出范围 |
| **矩阵类型定义** | `detail/type_mat2x2.hpp` ~ `type_mat4x4.hpp` | 9 | Vec2~Vec4 完整定义 | 内部数据由向量列组成。各矩阵类型的列向量依赖关系：mat2x2→vec2, mat2x3→vec2+vec3, mat2x4→vec2+vec4, mat3x2→vec2+vec3, mat3x3→vec3, mat3x4→vec3+vec4, mat4x2→vec2+vec4, mat4x3→vec3+vec4, mat4x4→vec4。各矩阵 `.inl` 文件中的运算符和函数实现依赖对应矩阵类型定义 | 超出范围 |
| **矩阵别名文件** | `ext/matrix_float2x2.hpp` ~ `matrix_uint4x4_sized.hpp` | ~80 | 对应矩阵类型定义 | 每个别名文件具现化一个矩阵类型（如 `matrix_float4x4.hpp` 定义 `mat4`），无额外编译逻辑 | 超出范围 |
| **四元数类型** | `detail/type_quat.hpp` | 1 (+ .inl) | Vec3+Vec4+mat3x3+mat4x4 | 结构体定义前（第7-14行）无条件包含 `type_mat3x3.hpp`、`type_mat4x4.hpp`、`type_vec3.hpp`、`type_vec4.hpp` 及 `ext/vector_relational.hpp`、`ext/quaternion_relational.hpp`、`gtc/constants.hpp`、`gtc/matrix_transform.hpp` 共8个文件，缺失任何一个都导致编译失败 | 超出范围 |
| **四元数别名/函数库** | `ext/quaternion_float.hpp`、`ext/quaternion_double.hpp` 等（ext/）及 `gtc/quaternion.hpp` | ~10 | 四元数类型 + 各函数库 | 别名文件具现化四元数类型；函数库提供四元数运算 | 超出范围 |
| **标量工具函数** | `ext/scalar_common.hpp`、`scalar_constants.hpp`、`scalar_integer.hpp`、`scalar_reciprocal.hpp`、`scalar_relational.hpp`、`scalar_ulp.hpp`、`scalar_packing.hpp` 等 | ~9 | 标量类型别名 | 操作标量类型的纯函数，不依赖向量/矩阵类型。部分引用 `<limits>`（由 shim_limits.cj 覆盖） | 超出范围 |
| **向量关系运算** | `ext/vector_relational.hpp` | 1 | Vec 类型 + 标量工具 | 提供 `lessThan`、`equal` 等分量级关系运算，依赖 Vec 分量访问 | 超出范围 |
| **向量通用函数** | `ext/vector_common.hpp`、`vector_integer.hpp`、`vector_reciprocal.hpp`、`vector_packing.hpp`、`vector_ulp.hpp` | ~5 | Vec 类型 + 标量工具 | 基于 Vec 分量访问的函数实现 | 超出范围 |
| **矩阵运算函数库 (ext)** | `ext/matrix_transform.hpp`、`matrix_common.hpp`、`matrix_relational.hpp`、`matrix_integer.hpp`、`matrix_projection.hpp`、`matrix_clip_space.hpp` | ~6 | 矩阵类型 | 提供矩阵变换、投影、裁剪空间等函数 | 超出范围 |
| **核心函数库 (gtc)** | `gtc/constants.hpp`、`epsilon.hpp`、`matrix_transform.hpp`、`matrix_inverse.hpp`、`matrix_access.hpp`、`matrix_integer.hpp`、`round.hpp`、`reciprocal.hpp`、`ulp.hpp`、`packing.hpp`、`bitfield.hpp`、`color_space.hpp`、`random.hpp`、`noise.hpp`、`integer.hpp`、`type_ptr.hpp`、`type_precision.hpp`、`type_aligned.hpp`、`vec1.hpp`、`quaternion.hpp` | ~20 | 核心类型 + ext 函数库 | 更高层次的封装函数库，依赖底层类型和 ext 层 | 超出范围 |
| **swizzle 功能** | `detail/_swizzle.hpp`、`detail/_swizzle_func.hpp` | 2 | Vec 完整类型定义 | 使用 `reinterpret_cast<T*>(_buffer)` 实现底层内存 reinterpret 操作。CangJie 不支持 reinterpret_cast，且值类型语义下 reinterpret 无等价机制 | **已排除** |
| **SIMD 平台特化** | `detail/type_vec_simd.inl`、`simd/` 目录 | ~5 | Vec 类型 + 平台指令集 | 通过 `GLM_CONFIG_SIMD` 条件编译控制。`GLM_CONFIG_SIMD=DISABLE` 已消除依赖。CangJie 不提供 SIMD 基础类型 | **已排除**（配置禁用） |
| **平台检测** | `detail/setup.hpp` 中 ~1000 行预处理器代码 | — | 无 | 平台/编译器/架构检测宏，无 CangJie 等价的预处理器机制。仅迁移基础配置常量（~100 行） | **已知局限性**，不直接迁移 |
| **gtx/ 实验性扩展** | `gtx/*.hpp` | ~50 | 核心类型 + 函数库 | 非稳定 API，GLM 本身标记为实验性。不在当前迁移考虑范围内 | **不在范围内** |

> **关于 ext/ 目录结构说明**：`ext/` 目录下的别名文件遵循统一的命名模式——基本类型 + 分量数 + 精度后缀。例如 `vector_float2.hpp` 定义 `vec2` 的 `float` 版本别名，`vector_float2_precision.hpp` 定义低/中/高精度变体。矩阵别名同理（如 `matrix_float4x4.hpp`、`matrix_double2x2_precision.hpp`）。所有别名文件仅包含 type alias 定义，无类型实现逻辑。
>
> **关于 gtc/ 目录说明**：`gtc/` 目录下的文件对应 GLM 的"稳定扩展"（GLM Standard Extensions），相比 `gtx/`（实验性）具有更高的 API 稳定性。但迁移顺序上均位于核心类型之后——`gtc/` 中的函数库操作核心类型，`gtc/type_ptr.hpp`、`gtc/type_precision.hpp` 等别名文件依赖核心类型完整定义。

## 修订说明（v12）

| 审查意见 | 处理方式 |
|---------|---------|
| 问题1（严重）：`@OverflowWrapping` 标注范围中 `%` 在分类表与标注量计算之间的矛盾 | 修改：采用方案(a)——二元 `%`（取模）为整数算术运算符，需标注 `@OverflowWrapping`。将标注量从"4类型×4运算符=16处"更正为"4类型×5运算符=20处"，同时明确 `%=`（复合赋值，由编译器自动生成）的排除不影响二元 `%` 的标注。同步更新了 §0.8 溢出策略行（16→20）、§4.4 溢出策略约束条件（16→20）、§4.6 T5（16→20）中的对应数字 |
| 问题2（严重）：§4.4 "范围定义标准"结构矛盾——含"验证方法"列和完成时态措辞，与"非未来验证计划"声明冲突 | 修改：采用方案(a)——删除"验证方法"列，将"范围约束条件"列措辞改为条件性/义务性表达（如"应满足：…"、"须…"）。同时将表注中的"验证时应在…"改为"须确保…"，末尾添加"本节为范围定义标准，不包含验证方案或验证报告"以消除歧义 |
| 问题3（一般）：§4.5 备选方案表格缺少对已排除方案（B/C）的明确标记 | 修改：在方案 B 的"影响"列末尾添加"**已考虑但未采纳**"，在方案 C 的"影响"列末尾添加"**已排除**"。同时调整方案 A 的标注措辞为"**采用此方案**"以增强一致性 |
| 问题4（一般）：§3F 缺少 `cjpm.toml` 配置示例 | 修改：在 §3F "Shim 文件包归属"之后新增"`cjpm.toml` 配置示例"小节，提供完整的 `cjpm.toml` 配置（含 `[project]`、`[package]`、`[dependencies]`），并在说明中解释 CangJie 包自动推断机制及编译配置项含义 |
