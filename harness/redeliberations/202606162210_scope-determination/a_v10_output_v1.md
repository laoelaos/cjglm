# GLM 1.0.3 迁移基础类型范围分析（v11）

---

## 0. CangJie 语言特性适应性分析

本节基于 CangJie 语言官方文档逐项评估首轮迁移所需的关键语言能力，将此前版本中的"假设"升级为**明确结论**。

### 0.1 泛型/模板系统

| 能力 | CangJie 支持情况 | 评估结论 |
|------|-----------------|---------|
| 泛型 struct/class | ✅ 支持：`struct Vec<T> { ... }` — 语法与 C++ 模板类似，支持类型参数化 | 可支持 `vec<T, Q>` 泛型主定义 |
| 泛型约束 | ✅ 支持：`where T <: SomeInterface` 语法 | 可对类型参数施加接口约束 |
| 偏特化（Partial Specialization） | ❌ 不支持：CangJie 泛型类型在所有类型参数上**不变**（invariant），无 C++ 式偏特化/全特化机制 | **关键差异**：`vec<N,T,Q>` 的 4 个分量数变体无法通过模板偏特化实现。替代方案：① 分别定义 `Vec1<T,Q>`、`Vec2<T,Q>`、`Vec3<T,Q>`、`Vec4<T,Q>` 四个独立结构体（不使用分量数参数）；② 使用宏生成各分量数的结构体定义；③ 若保留 `N` 作为类型参数，可通过 `VArray<T, N>`（标准语法，`N` 为编译期常量）配合宏实现编译期分量数分发。首轮范围建议采用方案①或方案② |
| 型变 | 用户自定义泛型类型在所有类型参数上为**不变** | 不影响首轮核心类型设计（`vec` 无须协变/逆变） |

> **`_vectorize.hpp` 偏特化与模板模板参数说明**：辅助文件 `_vectorize.hpp` 中的 `functor1`/`functor2`/`functor2_vec_sca`/`functor2_vec_int` 四个模板结构体不仅使用 C++ 偏特化模式（针对标量类型和向量类型分别提供特化版本），还使用了**模板模板参数**——例如 `functor1` 的模板参数中包含 `template<length_t L, typename T, qualifier Q> class vec`，使其能够统一接收不同分量数的 `vec<N,T,Q>` 特化。当 `vec<N,T,Q>` 被拆分为 `Vec1<T,Q>`~`Vec4<T,Q>` 四个独立泛型结构体后，单个 `functor1` 模板无法统一接收它们——因为四个结构体不再是同一模板的不同特化，没有公共的"模板签名"可供模板模板参数捕获。首轮应对策略：① 为各分量数分别定义独立 functor 结构体（如 `functor1_vec1`、`functor1_vec2`、`functor1_vec3`、`functor1_vec4`），各处理对应分量数的向量类型；② 使用宏生成各分量数的 functor 版本，减少重复代码。方案①增加约 4× 的 functor 定义量（原 4 个 functor 扩展为 16 个），但实现模式简单，推荐首轮采用。

### 0.2 运算符重载

| 能力 | CangJie 支持情况 | 评估结论 |
|------|-----------------|---------|
| 算术运算符 `+`/`-`/`*`/`/` | ✅ 支持：`public operator func +(rhs: T): T` | 可为向量类型定义算术运算符 |
| 比较运算符 `==`/`!=`/`<`/`<=`/`>`/`>=` | ✅ 支持 | 可为向量类型定义比较运算符 |
| 下标运算符 `[]` | ✅ 支持：取值 `operator func [](i: Int64): T` 和赋值 `operator func [](i: Int64, value!: T): Unit` | 可为向量实现分量访问 |
| 一元运算符 `-`/`!` | ✅ 支持 | 支持 |
| 复合赋值 `+=`/`-=`/`*=`/`/=` | ✅ 支持（重载二元运算符时自动启用对应的复合赋值版本） | 支持 |
| **限制**：不能创建自定义运算符、不能重新重载类型已原生支持的运算符、运算符重载不能为泛型 | 不影响首轮（使用标准运算符） |

### 0.3 类型别名

| 能力 | CangJie 支持情况 | 评估结论 |
|------|-----------------|---------|
| 类型别名 | ✅ `type Alias = OriginalType` — 不创建新类型，仅为替代名称 | 可支持向量类型别名（`type Vec2f = Vec2<Float32>`） |
| 泛型类型别名 | ✅ `type MyVec<T> = Vec2<T>` — 类型别名可声明类型参数，但**不能**对别名类型参数使用 `where` 约束 | 可支持泛型别名（如 `type Vec2<T> = Vec<2, T>` 在分别定义各 VecN 后不可行，改为 `type Vec2 = Vec2F32` 等非泛型别名） |
| 别名命名规则 | 仅限顶层定义，不可在函数内定义 | 符合首轮使用场景 |

### 0.4 编译期条件分支

| 能力 | CangJie 支持情况 | 评估结论 |
|------|-----------------|---------|
| `const` 函数/表达式 | ✅ 支持：编译时求值，包含数值运算、`if`/`match`、类型转换等 | 可替代部分编译期数值条件逻辑 |
| 宏（元编程） | ✅ 支持：`@MacroName` 编译时代码生成，可基于 `Tokens` 做条件展开 | 可用于替代 GLM 中 `#if`/`#ifdef` 的配置条件分支 |
| **无预处理器** | ❌ 无 C 式 `#if`/`#ifdef`/`#endif` | GLM 中的配置宏在 CangJie 中可作如下**有限映射**：① 编译时常量 `const` + `if` 分支——**仅适用于函数体内的内联条件代码**（由 const 求值优化消除死分支）；② 宏（`@MacroName`）编译期代码生成——可生成不同配置的代码路径，但**宏展开代码不能包含 `import` 语句**（`import` 必须是文件顶层声明）。**关键限制**：以上两种方案均**无法处理条件包含独立文件的场景**（如 C++ `#if COND` / `#include "file.hpp"` / `#endif`），因为 CangJie 中 `import` 必须是文件顶层声明，无法置于条件分支内部。应对策略：此类配置项（如 `GLM_CONFIG_SWIZZLE`）首轮全部采用最保守值，对应文件整体排除出首轮范围 |
| 推荐首轮策略 | 采用 `const` 配置常量 + `if` 分支方案（**限于函数体内内联条件代码**）。首轮全部 `GLM_CONFIG_*` 采用最保守值，条件包含独立文件的组件整体排除。**`const + if` 方案不适用于条件包含独立文件的场景**——`_swizzle.hpp` 的排除即因此限制。后续启用 swizzle 时需重新设计文件组织，将 swizzle 组件拆分为独立编译单元，通过构建配置决定是否纳入编译 |

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
| **结论** | CangJie 原生支持全部 8 种固定位宽整数类型及 3 种浮点类型，首轮标量类型映射无需包装层 |
| **补充** | C++ `int`（`ivec` 等别名的默认分量类型）映射为 `Int32`，`unsigned int`（`uvec` 等别名的默认分量类型）映射为 `UInt32` |
| **整数溢出语义** | C++ 中整数溢出为未定义行为（UB），编译器可假定溢出不会发生并进行优化；CangJie 整数溢出则默认抛出运行时异常 | 向量算术运算中的整数分量运算需明确溢出策略。CangJie 不支持全局溢出策略设置，存在两种互斥机制：`@OverflowWrapping` 注解（作用于函数级别）和 `std.overflow.WrappingOp<T>` 扩展接口。首轮推荐在**复合赋值算术运算符**上标注 `@OverflowWrapping`，利用非成员运算符委托成员运算符的特性减少标注量。详见下文标注策略 |

### 0.5.1 `@OverflowWrapping` 标注策略

向量类型运算符函数可按类别分为以下几组。仅**整数分量**的算术运算受溢出影响，浮点分量及非算术运算无需标注。

| 运算符类别 | 涉及运算符 | 是否需 `@OverflowWrapping` | 标注位置 |
|-----------|-----------|------------------------|---------|
| 算术复合赋值 | `+=`、`-=`、`*=`、`/=`、`%=` | **是**（仅整数分量） | 成员运算符函数（Vec 结构体上直接定义） |
| 二元算术（非复合赋值） | `+`、`-`、`*`、`/`、`%` | **否**——委托给复合赋值 + 拷贝，无需额外标注 | 非成员运算符函数，内部调用 `op=` 实现 |
| 一元算术 | `+`、`-` | **否**——符号反转不影响溢出语义 | 成员/非成员运算符函数 |
| 位运算 | `&`、`|`、`^`、`<<`、`>>`、`~` | **否**——CangJie 中位运算不触发溢出检查 | 成员/非成员运算符函数 |
| 比较运算 | `==`、`!=`、`<`、`<=`、`>`、`>=` | **否**——不涉及数值溢出 | 成员/非成员运算符函数 |
| 布尔运算 | `!`、`&&`、`||` | **否**——布尔类型不涉及数值溢出 | 成员/非成员运算符函数 |
| 前置/后置自增自减 | `++`、`--` | **是**（仅整数分量） | 成员运算符函数 |

**委托模式说明**：二元算术运算符（如 `Vec2 + Vec2`）可采用委托模式实现——内部调用对应的复合赋值运算符（`op=` + 拷贝），因此仅需在复合赋值运算符上标注 `@OverflowWrapping`，二元算术运算符自动继承 wrapping 语义，无需重复标注。例如：
```
// 仅对此函数标注
public operator func +=(rhs: Vec2<T>): Vec2<T> // @OverflowWrapping
// 委托函数无需额外标注
public operator func +(rhs: Vec2<T>): Vec2<T> { let tmp = copy(this); tmp += rhs; return tmp }
```

**委托模式性能开销说明**：上述"拷贝+复合赋值"委托模式每次二元运算产生一次 Vec 结构体拷贝（值类型复制）。以 `Vec4<Float32>` 为例（4×Float32=16字节），单次委托拷贝代价为 16 字节栈复制 + 复合赋值运算符内逐分量运算。与直接逐分量实现（`Vec4(v1[0]+v2[0], ..., v1[3]+v2[3])`）相比，委托模式增加 1 次结构体拷贝（约 16-32 字节栈复制，取决于分量数与类型）。在每帧百万级向量运算的高频场景下，该拷贝开销可能累积。**首轮策略**：以功能正确性优先，采用委托模式作为**首轮默认**方案；若后续性能剖析确认拷贝开销成为热点，可在性能优化轮次中改为直接逐分量实现（每个 Vec 类型独立实现二元运算，消除委托拷贝）。此优化不影响外部接口语义。

**标注工作量量化**：
- 4 个 Vec 类型（Vec1~Vec4）× 每个类型 4 个复合赋值运算符（`+=`、`-=`、`*=`、`/=`）+ 1 个 `%=`（部分类型可能不支持） + 2 个自增自减（`++`、`--`） ≈ **4 × (4 + 1 + 2) = 28 处标注**（最大值，含 `%=` 和自增自减）
- 若 Vec1 降级至第 2 轮，则降为 **3 × 7 = 21 处标注**
- 若仅保留算术复合赋值（`+=`、`-=`、`*=`、`/=`），不含 `%=` 和自增自减，则为 **4 × 4 = 16 处标注**（推荐最小值）
- 若利用泛型统一实现（通过 `where T <: Integer<T>` 约束仅在整数类型上定义带标注的运算符，浮点类型上不定义以避免无用标注），标注量在上述基础上不变但语义更精确

**浮点类型溢出说明**：浮点类型（`Float32`、`Float64`）在 CangJie 中不会触发溢出异常——浮点溢出产生 `±Infinity` 而非异常。因此 `@OverflowWrapping` 在浮点类型的 Vec 上语义上无影响（标注与否行为一致），技术上可批量标注简化实现，但建议通过泛型约束（`where T <: Integer<T>`）区分整数/浮点路径以消除浮点上的无用标注。

### 0.6 匿名组合类型

| 能力 | CangJie 支持情况 | 评估结论 |
|------|-----------------|---------|
| 匿名 `union`/`struct` 嵌套 | ❌ **不支持**：CangJie 无匿名 union/struct 语法 | `type_quat.hpp` 第 42-52 行的匿名 union + 匿名 struct 模式无直接等价实现。替代方案：① 使用具名成员 + 属性映射；② 使用 `VArray<T, N>` 替代对齐缓冲区。首轮不涉及 `type_quat.hpp`，此差异不影响首轮范围 |

### 0.7 C++ 标准库设施等效替代

| C++ 标准库 | 用途 | CangJie 等效 | 首轮影响 |
|-----------|------|-------------|---------|
| `<cassert>` | `setup.hpp` 中的断言 | 无内置 assert 关键字。可改用 `if (!cond) { throw Exception("assertion failed") }` 或使用 `std.unittest` 的 `@Assert`（仅测试场景） | 需在 shim layer 中提供等效的 `assert()` 函数 |
| `<cstddef>` | `setup.hpp`、`type_vec1-4.hpp` 中的 `size_t`、`ptrdiff_t`；`compute_vector_decl.hpp` 在 16 处用作非类型模板参数（`std::size_t Size`） | CangJie 中无直接等价。GLM 默认（非 `GLM_FORCE_SIZE_T_LENGTH`）下 `length_t` 为有符号 `int`，与 `size_t`（无符号）不同 | 首轮 `length_t` 统一映射为有符号 `Int64`，与 GLM 默认行为一致。`compute_vector_decl.hpp` 中 16 处 `std::size_t` 作为非类型模板参数，在 CangJie 中映射为 `Int64`。**shim_cstddef.cj 升级为强制项**——其中定义 `type SizeT = UInt64`（用于需要精确无符号语义的位运算场景）和 `type LengthT = Int64`（用于索引场景），以明确区分有符号/无符号使用场景 |
| `<limits>` | `compute_vector_relational.hpp`（第 5 行 `#include <limits>`，其模板定义中通过 `compute_equal` 模板参数引用 `std::numeric_limits<T>::is_iec559`）；`compute_vector_decl.hpp`（通过 `compute_vector_relational.hpp` 的包含链间接获得）；`type_vec1-4.inl`（通过 `compute_equal` 模板实参活跃使用）；矩阵类型中的 `std::numeric_limits<T>` | 无 `std::numeric_limits<T>` 等价设施。各数值类型提供 `.Max`、`.Min` 等静态属性（如 `Int64.Max`、`Float64.Max`、`Float64.NaN`）。可通过泛型函数 + `where T <: Number<T>` 约束实现类型限值查询 | 需在 shim layer 中为所用到的限值查询提供包装，或直接在代码中引用类型静态属性 |
| `<functional>` | `compute_vector_decl.hpp` 中的 `std::plus<T>` 等标准函数对象（非 `std::function` 类型擦除包装器） | CangJie 无 `std::function` 精确等价。支持函数类型（`(T) -> U`）和 Lambda 表达式。可通过泛型函数类型参数替代 | `compute_vector_decl.hpp` 中的 `std::plus<T>` 等函数对象依赖可改为泛型参数约束或直接使用 Lambda 表达式替代 |
| 整数溢出检测 | C++ 溢出为 UB | CangJie 溢出检测并报错（运行时异常） | 首轮向量算术运算需在每个运算符函数上标注 `@OverflowWrapping` 注解，替代 C++ 的 UB 语义。详见 0.5 节 |

### 0.7.1 `size_t`（无符号）→ `Int64`（有符号）语义差异分析

首轮将 `length_t` 及 `std::size_t` 的 CangJie 等效类型统一采用有符号 `Int64`。以下是此决策的语义影响分析：

| 场景 | C++ `size_t`（无符号）行为 | CangJie `Int64`（有符号）行为 | 影响评估 |
|------|--------------------------|-----------------------------|---------|
| **循环比较**：`for (i = 0; i < vec.length(); i++)` | `length()` 返回无符号，与 `i`（可能有符号）比较时编译器警告但语义正确 | `length()` 返回 `Int64`，与 `Int64` 索引比较完全一致 | **无影响**。GLM 默认 `length_t` 即有符号 `int` |
| **循环下溢**：`for (i = len-1; i >= 0; i--)` | `size_t` 为无符号时 `i >= 0` 恒真，导致死循环（经典陷阱） | `Int64` 为有符号，`i >= 0` 在 `i=-1` 时正常结束 | **提升安全性**——有符号避免了无符号循环下溢陷阱 |
| **位运算**：`mask << shift` 或 `size_t` 参与位宽掩码 | 无符号右移（逻辑右移），行为与位宽匹配 | `Int64` 右移为算术右移（符号扩展），可能在负索引上产生意外高位 1 | **需注意**。首轮范围中 `length_t` 参与位运算的场景极少（非索引位运算由其他 CangJie 类型处理），影响可控 |
| **边界检查**：`assert(i < vec.length())` | 无符号与有符号混合比较时，编译器可能在无符号→有符号隐式转换时产生意外结果 | 纯有符号比较，语义直接 | **无影响**。GLM 默认使用 `int`，实际边界检查已在首轮 `GLM_ASSERT_LENGTH` 中等效实现 |
| **数组大小与 `sizeof`**：`sizeof(T) * count` 涉及 `size_t` 乘法溢出 | 无符号乘法溢出为 modulo `2^n`（定义良好） | `Int64` 乘法溢出默认抛出异常（`@OverflowWrapping` 后为 wrapping） | **通过 `@OverflowWrapping` 可消除差异**。首轮 shim 中 `countof` 等效函数可标注 wrapping |
| **`compute_vector_decl.hpp` 中 `std::size_t Size` 作为模板参数**：16 处 `std::size_t` 用作偏特化选择 | `size_t` 为无符号整数类型，编译器按值匹配特化版本 | 映射为 `Int64` 后，`Size` 参数值域（0~64）不变，模板匹配不受有符号/无符号影响 | **无影响**。非类型模板参数的值不涉及符号相关重载决议 |

**结论**：首轮将 `size_t` → `Int64` 的主要影响是**正向的**——避免了无符号循环下溢陷阱，且与 GLM 默认 `length_t = int` 保持一致。唯一需注意的位运算差异场景在首轮范围中极少出现。**shim_cstddef.cj** 应升级为强制项，提供 `type SizeT = UInt64` 和 `type LengthT = Int64` 两个别名，分别用于需要明确无符号语义（位运算、缓冲区大小计算）和有符号语义（索引、长度）的场景，避免今后出现符号混淆。

### 0.7.2 C++ 标准库设施首轮 Shim 策略总表

| C++ 标准库 | 首轮策略 | Shim 文件 | 优先级 |
|-----------|---------|----------|--------|
| `<cassert>` | `if (!cond) { throw ... }` 模式替代 | `shim_assert.cj` | 强制 |
| `<cstddef>` | `Int64`/`UInt64` 双别名 | `shim_cstddef.cj` | **强制**（v9 升级） |
| `<limits>` | 类型静态属性（`.Max`、`.Min`、`.NaN`）+ 泛型查询 | `shim_limits.cj` | 强制 |
| `<functional>` | 泛型函数类型参数替代 `std::plus<T>` 等 | 内联到 `compute_vector_decl.hpp` 等效实现 | 非独立文件 |

### 0.8 关键适应性结论

| 能力 | 首轮是否需要 | 是否支持 | 迁移策略 |
|------|------------|---------|---------|
| 泛型 struct 定义 | 是 | ✅ | 各自定义 `Vec1<T,Q>` — `Vec4` 或宏生成 |
| 运算符重载 | 是 | ✅ | 直接映射 |
| 类型别名 | 是 | ✅ | 直接映射 |
| 固定位宽整数 | 是 | ✅ | 直接映射 |
| 编译期条件 | 是 | ✅（替代方案） | `const` 常量 + `if` 分支，或宏 |
| 模板偏特化 | 是 | ❌ | 分别定义各分量数结构体 |
| 匿名 union/struct | 否（第3轮） | ❌ | 首轮不涉及 |
| `<cassert>` 断言 | 是 | ⚠️ 需 shim | 首轮提供 shim 包装 |
| `<limits>` 限值 | 是 | ⚠️ 需 shim | 首轮提供 shim 包装 |
| `<functional>` | 是 | ⚠️ 需适配 | `compute_vector_decl.hpp` 为首轮范围文件且依赖 `<functional>` 中的 `std::plus<T>` 等函数对象，改用泛型参数约束或 Lambda 表达式替代 |
| `reinterpret_cast` | 否（_swizzle.hpp） | ❌ | 见 P5 处理方案 |
| 整数溢出语义差异 | 是（vec 算术运算） | ⚠️ 需策略选择 | C++ UB → CangJie 默认抛异常；首轮推荐在**复合赋值算术运算符**上标注 `@OverflowWrapping` 注解（约 16～28 处），利用委托模式减少标注量；浮点类型分量不受溢出影响无需标注。详见 0.5.1 节 |

---

## 1. GLM 类型层次概览

GLM 1.0.3 的类型体系分为四个依赖层次，每个层次向下依赖（上层依赖下层）：

### 层次 0 — 基础设施（无 GLM 内部依赖）

| 组件 | 说明 |
|------|------|
| `detail/setup.hpp` | 平台检测、编译器检测、配置宏、版本定义、`length_t` 类型定义（注：内部包含 `../simd/platform.h`，提供平台检测宏——该检测功能**作为能力**在首轮 `setup.hpp` 等价实现中以直接内联方式处理；其**作为独立文件结构**的拆分和完整实现可推迟至第 5 轮） |
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

上述断言对 `.hpp` 声明文件成立——向量类型的结构体声明仅依赖 `qualifier.hpp`。`.inl` 实现文件可能存在额外包含依赖（所有 `type_vec1.inl`-`type_vec4.inl` 均包含 `compute_vector_relational.hpp`；`type_vec3.inl` 和 `type_vec4.inl` 还额外包含 `compute_vector_decl.hpp`），但这类依赖不引入其他向量/矩阵类型，不影响首轮迁移的依赖闭合性。其中 `compute_vector_relational.hpp` 被所有 vec `.inl` 无条件包含。其模板定义中通过 `compute_equal` 模板参数引用 `std::numeric_limits<T>::is_iec559`（`<limits>` 等效替代是首轮编译的实际硬性需求，详见 0.7 节 shim_limits 分析），应随首轮向量类型同步迁移；`compute_vector_decl.hpp` 同理（其内部 `#include "_vectorize.hpp"` 引入 `_vectorize.hpp` 作为首轮额外辅助文件，该文件定义 `functor1`/`functor2` 等模板工具，无进一步 GLM 内部依赖）。

> **注**：每个 `type_vecN.hpp` 还会根据 `GLM_CONFIG_SWIZZLE` 条件包含 `_swizzle.hpp`（`GLM_SWIZZLE_OPERATOR` 模式）或 `_swizzle_func.hpp`（`GLM_SWIZZLE_FUNCTION` 模式），或在 `GLM_SWIZZLE_DISABLED` 时不包含任何 swizzle 文件。默认配置为 `GLM_SWIZZLE_OPERATOR`，但首轮范围以 `GLM_SWIZZLE_DISABLED` 模式运行——`_swizzle.hpp` **排除出**首轮范围（详见 4.5 节风险评估）。`_swizzle.hpp` 使用 `reinterpret_cast<T*>(_buffer)` 实现底层内存 reinterpret 操作，而 **CangJie 不直接支持 reinterpret_cast**，swizzle 功能待后续轮次重新设计。

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

> **注**：`type_quat.hpp` 在 struct 定义之前（第 7-14 行）无条件 `#include` 了上表第 2 列和第 3 列的全部 8 个头文件。所有 8 个文件均为编译期硬性依赖——缺失任何一个都会导致 `file not found` 编译错误。迁移 `type_quat.hpp` 时第 2 列和第 3 列的头文件必须一并处理，不存在"类型定义依赖"与"完整编译依赖"的可选区分。若确有分期迁移需求，可行方案为：① 修改 `type_quat.hpp` 的 `#include`，将 ext/gtc 依赖改为条件包含或前向声明替代；② 为 ext/gtc 头文件创建空桩文件以通过编译。
>
> **ext/gtc 传递依赖链**：上表第 3 列（完整编译额外依赖）中的 4 个头文件各自有传递依赖，需在迁移 `type_quat.hpp` 时一并评估依赖闭合性：
> - `ext/vector_relational.hpp` → `detail/qualifier.hpp`（向量运算函数声明，传递依赖闭合于层次 0-1，不引入矩阵/函数库）
> - `ext/quaternion_relational.hpp` → `../vector_relational.hpp` → `detail/qualifier.hpp`、`detail/setup.hpp`（传递依赖闭合于层次 0-1）
> - `gtc/constants.hpp` → `../ext/scalar_constants.hpp` → `detail/setup.hpp`（常量函数声明，传递依赖仅为基础设施层，最轻量）
> - `gtc/matrix_transform.hpp` 是依赖链中最重的文件：直接包含 `mat4x4.hpp`、`vec2.hpp`、`vec3.hpp`、`vec4.hpp`、`ext/matrix_projection.hpp`、`ext/matrix_clip_space.hpp`、`ext/matrix_transform.hpp`；其传递依赖通过 `.inl` 实现文件进一步引入 `geometric.hpp`、`trigonometric.hpp`、`matrix.hpp` 等全部核心函数库及所有矩阵类型。`gtc/matrix_transform.hpp` 的传递依赖链覆盖除 `qua` 和 `gtx/` 以外的几乎所有 GLM 类型层。若采用空桩策略，建议为 `gtc/matrix_transform.hpp`（及其间接依赖的 `ext/matrix_projection.hpp`、`ext/matrix_clip_space.hpp`、`ext/matrix_transform.hpp` 以及 `geometric.hpp`、`trigonometric.hpp`、`matrix.hpp`）创建空桩文件，因为这些文件跨越了多个函数库层面。
>
> **ext/gtc 范围弹性说明**：当 `type_quat.hpp` 纳入第 3 轮迁移范围时，其 `#include` 的 ext/gtc 头文件按传递依赖深度分为三类范围选项：`ext/vector_relational.hpp` 和 `gtc/constants.hpp` 依赖链最浅（均止于 `qualifier.hpp`/`setup.hpp`），属低附加范围；`ext/quaternion_relational.hpp` 依赖 `vector_relational.hpp`（函数库层），属中等附加范围；`gtc/matrix_transform.hpp` 传递依赖链覆盖全部 9 个矩阵类型、全部 4 个向量类型及多个核心函数库，属高附加范围。第 3 轮范围可依据对上述三类 ext/gtc 依赖的取舍弹性调整。

> **矩阵 `.inl` 实现依赖提示**：矩阵类型的 `.inl` 实现文件也可能引入函数库头文件——`type_mat2x2.inl` 引入 `../matrix.hpp`；`type_mat3x3.inl` 引入 `../matrix.hpp`、`../common.hpp`；`type_mat4x4.inl` 引入 `../matrix.hpp`、`../geometric.hpp`。经逐文件审查确认，非方阵 `.inl`（`type_mat2x3.inl`、`type_mat2x4.inl`、`type_mat2x3.inl`、`type_mat3x2.inl`、`type_mat3x4.inl`、`type_mat4x2.inl`、`type_mat4x3.inl`）均无额外函数库头文件引入，其实现仅操作列向量和矩阵结构内部数据。这些依赖在仅编译 `.hpp` 声明时不会触发，需在完整实现编译时处理。

### 函数库（各自由对应头文件提供，例如 trigonometric.hpp、exponential.hpp 等）

这些函数库操作上述类型，不是类型定义本身，不在本次类型迁移范围内。

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

### 2.2 文件级依赖分析

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

> **统计方法说明**：以上"被引用文件数"统计的是**直接引用**——即源文件中显式 `#include` 该头文件，不包括传递引用。统计范围为 `glm/` 目录下全部 `.hpp`、`.inl`、`.cpp` 源文件（不含测试和示例代码）。方法：对每个目标头文件，使用 `grep -r "#include.*<目标文件名>" glm/* --include="*.hpp" --include="*.inl" --include="*.cpp"` 搜索直接引用，然后统计唯一文件数。`glm/` 目录下源文件总计 421 个（280 个 `.hpp`、140 个 `.inl`、1 个 `.cpp`，不含测试和示例），其中首轮涉及的核心文件约 9 个（不含 shim 层）。

### 2.3 类型级依赖分析

文件级 include 引用数是类型依赖度的合理近似，因为 GLM 中类型定义和引用遵循"一个头文件一个类型模板"的惯例（`type_vecN.hpp` 对应 `vec<N,T,Q>`、`type_matMN.hpp` 对应 `mat<M,N,T,Q>`）。以下补充类型级分析，核查每个核心类型被多少**唯一类型定义**直接引用（而非文件数）：

| 核心类型 | 直接引用该类型的唯一类型数 | 引用方 | 与文件级数据一致性 |
|---------|-------------------------|-------|-----------------|
| `qualifier` 枚举 | 16 个核心类型（4 vec + 9 mat + 1 qua + 2 辅助存储） | 所有核心类型结构体定义 | 文件级 36 包含辅助文件、函数库的传递引用 |
| `vec<1, T, Q>` | 4 个矩阵类型（mat2x1 无、但 mat 均引用 vec1） | `type_mat2x1.hpp` 无，但 `ext/vector_float1.hpp` 等别名文件使用 | 类型级 4, 文件级 11 |
| `vec<2, T, Q>` | 7 个矩阵类型（mat2x2~4x2 等） | `type_mat2x2.hpp`、`type_mat2x3.hpp` 等 | 类型级 7, 文件级 17 |
| `vec<3, T, Q>` | 7 个矩阵类型 + `qua` | `type_mat2x3.hpp`、`type_mat3x3.hpp`、`type_quat.hpp` 等 | 类型级 8, 文件级 19 |
| `vec<4, T, Q>` | 7 个矩阵类型 + `qua` | `type_mat2x4.hpp`、`type_mat4x4.hpp`、`type_quat.hpp` 等 | 类型级 8, 文件级 18 |
| `mat<2,2,T,Q>` | 无其他核心类型（仅函数库和别名使用） | 函数库（type_mat2x2.inl 等操作该类型） | 类型级 0 核心类型引用, 文件级 6 |
| `mat<3,3,T,Q>` | 1（`qua`） | `type_quat.hpp` | 类型级 1, 文件级 7 |
| `mat<4,4,T,Q>` | 1（`qua`） | `type_quat.hpp` | 类型级 1, 文件级 8 |
| `qua<T,Q>` | 0（其他核心类型不依赖 qua） | 无其他核心类型引用 | 类型级 0, 文件级 4 |

> **说明**：类型级分析与文件级分析结论一致——`vec<N,T,Q>`（N=2,3,4）是其他核心类型中被引用最多的类型层，位于依赖拓扑的最核心位置。`vec1` 虽然被较少类型引用，但与 vec2-4 共享相同的模板实现模式，边际成本极低。向量类型在所有核心类型中的类型级被引用数（7-8 个独特类型使用者）显著高于矩阵（0-1 个）和四元数（0 个），确认了向量类型应当作为首轮迁移的核心。

### 2.4 依赖关系拓扑排序

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

### 2.5 最基础类型识别结论

综合第 1 节类型层次分析、第 2.2 节文件级依赖统计和第 2.3 节类型级依赖分析，以下按**依赖度降序**列出 GLM 中最基础、被最多其他类型依赖的核心类型：

| 排名 | 核心类型 | 被引用文件数 | 被引用唯一类型数 | 说明 |
|------|---------|-------------|---------------|------|
| 1 | `qualifier` 枚举 + `vec/mat/qua` 前向声明 | 36 | 16 | 绝对基础——所有 GLM 类型和函数库均依赖。首轮必须最先迁移 |
| 2 | `setup.hpp`（含 `length_t`、`GLM_CONFIG_*`） | 36 | — | 配置层，每个 GLM 文件均包含。作为基础设施首轮迁移 |
| 3 | `vec<3, T, Q>` | 19 | 8 | 向量类型中被引用最多的，所有 3/4 行矩阵+qua 依赖 |
| 4 | `vec<4, T, Q>` | 18 | 8 | 所有 4 列/4 行矩阵+qua 依赖 |
| 5 | `vec<2, T, Q>` | 17 | 7 | 所有 2 列/2 行矩阵依赖 |
| 6 | `vec<1, T, Q>` | 11 | 4 | 较少依赖（无矩阵列类型使用 vec1），但与 vec2-4 共享模板模式 |
| 7 | `mat<4,4,T,Q>` | 8 | 1（qua） | 矩阵中被引用最多的 |
| 8 | `mat<3,3,T,Q>` | 7 | 1（qua） | 仅 qua 直接依赖 |
| 9 | `mat<2,2,T,Q>` | 6 | 0 | 矩阵中引用数最低 |
| 10 | `qua<T,Q>` | 4 | 0 | 无其他核心类型依赖四元数 |

**关键发现**：

1. **向量类型（vec2/3/4）是所有核心类型中依赖度最高的类型层**——每个向量类型被 7-8 个其他唯一类型定义直接引用，而矩阵类型最多被 1 个，四元数为 0。这验证了向量类型应作为首轮迁移核心的结论。
2. **基础设施层（setup/qualifier）是无条件的绝对前置依赖**——全部 36 个 GLM 源文件均直接引用它们，首轮范围必须完整覆盖。
3. **vec1 是向量类型中依赖度最低的**——被 11 个文件引用，但加入首轮的边际成本极低（与 vec2-4 共享模板模式）。
4. **矩阵和四元数并非最基础类型**——它们的引用数仅为向量的 1/3 到 1/5，且自身不构成其他类型的依赖基础。应安排在后续轮次迁移。

**对首轮范围的直接影响**：基础设施 + vec1~vec4 + 标量类型别名 + 向量类型别名构成首轮迁移范围，与第 3 节推荐范围一致。矩阵和四元数推迟至第 2~3 轮。

---

## 3. 建议的首轮迁移范围

### 首轮迁移内容

#### A. 基础设施层（必须最先迁移）

1. **`setup.hpp` 对应的配置层** — 目标语言中的配置/平台抽象，包含 `length_t` 类型定义。定量评估：`setup.hpp` 共 1188 行 C++ 预处理器逻辑。首轮需移植的部分仅包括 `length_t` 定义、`GLM_CONFIG_*` 常量等效声明（约 10 个宏，其中 **`GLM_CONFIG_SIMD` 必须显式设为 `GLM_DISABLE`** 以避免 `type_vec3.inl`/`type_vec4.inl` 条件包含不在首轮范围内的 `type_vec_simd.inl`）、`uint` 类型别名、`countof` 辅助函数，合计约 50–100 行；剩余约 1000+ 行平台/编译器/架构检测代码应整体标记为"首轮无需直接迁移"，该检测功能的 CangJie 映射方案**尚待验证**——CangJie 不存在与 C++ 预处理器等价的平台/编译器/架构检测机制。建议：① 将该检测功能的完整实现列入后续轮次（第 5 轮及以后）；② 首轮 `setup.hpp` 等价实现中仅提供 `length_t` 定义、`GLM_CONFIG_*` 常量等效声明和基础类型别名，不包含平台/编译器/架构检测逻辑；③ 如有需要，可通过 CangJie 运行时接口（如 `std.env`、编译期常量宏等）在后续轮次按需补充平台检测能力
2. **`qualifier.hpp`** — 核心枚举 `qualifier`、`vec`/`mat`/`qua` 前向声明、`storage` 结构、`genTypeTrait` 等辅助设施

> **`storage` 的 SIMD 平台特化依赖**：`qualifier.hpp` 中的 `storage` 模板在条件编译块（`#if GLM_ARCH & GLM_ARCH_SSE2_BIT` 等）中提供了针对各平台 SIMD 类型的特化，特化版本引用 `glm_f32vec4`、`glm_i32vec4`、`glm_u32vec4` 等 SIMD 内部类型。CangJie 当前版本不提供 SIMD 基础类型，首轮 `storage` 始终使用非 SIMD 通用路径（即 `GLM_ARCH & GLM_ARCH_SSE2_BIT == 0` 的分支），不影响核心类型迁移的依赖闭合性。SIMD 平台特化推迟至后续轮次处理。
>
> > **`GLM_CONFIG_SIMD` 条件包含**：`type_vec3.inl`（第 833 行）和 `type_vec4.inl`（第 1023 行）底部各有一处 `#if GLM_CONFIG_SIMD == GLM_ENABLE` 条件编译块，在该条件下分别 `#include "type_vec_simd.inl"`。`type_vec_simd.inl` 不在首轮范围内。若保留默认值 `GLM_ENABLE`，`type_vec3.inl`/`type_vec4.inl` 编译必然因缺失 `type_vec_simd.inl` 而失败。首轮必须在 `setup.hpp` 等效实现的 `GLM_CONFIG_*` 常量声明中显式将 `GLM_CONFIG_SIMD` 设为 `GLM_DISABLE`。
>
> > **`GLM_CONFIG_*` 常量完整清单**：下表列出 `setup.hpp` 中所有 `GLM_CONFIG_*` 宏，完整枚举首轮需声明的 CangJie 等效常量及推荐初始值：
> >
> > | GLM 宏名 | CangJie 等效常量名 | 首轮推荐值 | 用途说明 |
> > |---------|------------------|-----------|---------|
> > | `GLM_CONFIG_SWIZZLE` | `const GLM_CONFIG_SWIZZLE: Int` | `GLM_SWIZZLE_DISABLED`（=2） | 控制 swizzle 操作：0=operator, 1=function, 2=disabled。首轮必须设为 disabled |
> > | `GLM_CONFIG_SIMD` | `const GLM_CONFIG_SIMD: Bool` | `false`（=GLM_DISABLE） | 控制 SIMD 指令集启用。首轮必须设为 false 以避免 `type_vec_simd.inl` 依赖 |
> > | `GLM_CONFIG_ALIGNED_GENTYPES` | `const GLM_CONFIG_ALIGNED_GENTYPES: Bool` | `false`（=GLM_DISABLE） | 控制对齐类型（aligned/packed）。首轮使用非对齐默认布局 |
> > | `GLM_CONFIG_ANONYMOUS_STRUCT` | `const GLM_CONFIG_ANONYMOUS_STRUCT: Bool` | `false`（=GLM_DISABLE） | 控制匿名 struct 特性。CangJie 不支持，首轮禁用 |
> > | `GLM_CONFIG_UNRESTRICTED_GENTYPE` | `const GLM_CONFIG_UNRESTRICTED_GENTYPE: Bool` | `false`（=GLM_DISABLE） | 控制泛型类型约束松弛。首轮遵循 GLSL 严格约束 |
> > | `GLM_CONFIG_UNRESTRICTED_FLOAT` | `const GLM_CONFIG_UNRESTRICTED_FLOAT: Bool` | `false`（=GLM_DISABLE） | 控制浮点类型约束松弛。首轮遵循 GLSL 严格约束 |
> > | `GLM_CONFIG_CLIP_CONTROL` | `const GLM_CONFIG_CLIP_CONTROL: Int` | `0x02`（=GLM_CLIP_CONTROL_RH_NO） | 裁剪空间约定（LH/RH, NO/ZO 位组合）。首轮使用默认 RH_NO |
> > | `GLM_CONFIG_CONSTEXP` | `const GLM_CONFIG_CONSTEXP: Bool` | `false`（=GLM_DISABLE） | 控制 constexpr 标识函数。CangJie 无 constexpr 概念，但 `const` 函数编译期求值可替代 |
> > | `GLM_CONFIG_XYZW_ONLY` | `const GLM_CONFIG_XYZW_ONLY: Bool` | `false`（=GLM_DISABLE） | 控制仅 xyzw 分量命名模式。首轮使用完整 rgba/stpq 命名 |
> > | `GLM_CONFIG_CTOR_INIT` | `const GLM_CONFIG_CTOR_INIT: Int` | `0`（=GLM_CTOR_INIT_DISABLE） | 控制构造函数初始化策略。首轮不依赖特定初始化 |
> > | `GLM_CONFIG_DEFAULTED_FUNCTIONS` | `const GLM_CONFIG_DEFAULTED_FUNCTIONS: Bool` | `false`（=GLM_DISABLE） | 控制 C++11 defaulted 函数 |
> > | `GLM_CONFIG_DEFAULTED_DEFAULT_CTOR` | `const GLM_CONFIG_DEFAULTED_DEFAULT_CTOR: Bool` | `false`（=GLM_DISABLE） | 控制 defaulted 默认构造函数 |
> > | `GLM_CONFIG_LENGTH_TYPE` | `const GLM_CONFIG_LENGTH_TYPE: Int` | `GLM_LENGTH_INT`（=1） | 控制 `length_t` 类型选择：1=int（有符号），2=size_t（无符号）。首轮使用有符号 Int64 |
> > | `GLM_CONFIG_PRECISION_BOOL` | `const GLM_CONFIG_PRECISION_BOOL: Int` | `GLM_HIGHP`（=3） | 控制 bool 类型默认精度等级 |
> > | `GLM_CONFIG_PRECISION_INT` | `const GLM_CONFIG_PRECISION_INT: Int` | `GLM_HIGHP`（=3） | 控制 int 类型默认精度等级 |
> > | `GLM_CONFIG_PRECISION_UINT` | `const GLM_CONFIG_PRECISION_UINT: Int` | `GLM_HIGHP`（=3） | 控制 uint 类型默认精度等级 |
> > | `GLM_CONFIG_PRECISION_FLOAT` | `const GLM_CONFIG_PRECISION_FLOAT: Int` | `GLM_HIGHP`（=3） | 控制 float 类型默认精度等级 |
> > | `GLM_CONFIG_PRECISION_DOUBLE` | `const GLM_CONFIG_PRECISION_DOUBLE: Int` | `GLM_HIGHP`（=3） | 控制 double 类型默认精度等级 |
> >
> > > **说明**：以上 18 个 `GLM_CONFIG_*` 宏对应 `setup.hpp` 中全部非临时性配置常量（不含 `#if`/`#ifdef` 临时检测宏如 `GLM_HAS_CONSTEXPR`、`GLM_ARCH` 等——这些属于平台检测范畴，首轮不直接迁移）。未显式列出的配置如 `GLM_CONFIG_NULLPTR` 已合并至 `GLM_CONFIG_CONSTEXP` 的处理中，无需独立声明。首轮推荐值全部选用最保守设置（禁用/关闭），以确保在最小依赖下通过编译验证。首轮 `setup.hpp` 等效实现的核心代码体约为 80-120 行（含 `length_t` 定义、`GLM_CONFIG_*` 常量声明、`uint` 别名、`countof` 辅助函数、`GLM_ASSERT_LENGTH`、坐标系检测帮助常量等），较之前估计的 50-100 行略有上升。
>
> 3. **标量类型系统** — 对应 `fwd.hpp` 第 1-178 行的标量类型别名，包含 10 个基础数值类型（int8-u64 8 个整数位宽 + float、double）及 bool 关键字，映射如下：
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
>
> 若为缩减首轮范围，可将其降级至第二轮，但建议优先纳入以保持模板逻辑完整性。
>
> **CangJie 模板特化说明**：CangJie 不支持 C++ 式偏特化，因此首轮中不采用分量数参数化的单一模板 `vec<N,T,Q>`，而是分别定义 `Vec1<T,Q>`、`Vec2<T,Q>`、`Vec3<T,Q>`、`Vec4<T,Q>` 四个独立泛型结构体，或使用宏生成。基本迁移策略不变，仅具名形式不同。

#### C. 向量类型别名（与类型定义同时提供）

对应 `fwd.hpp` 第 180-507 行的向量类型别名。首轮迁移的向量别名覆盖 16 个向量别名家族及其各精度变体。

> **别名数量精确计算**：16 个别名家族 × 4 个分量数（1/2/3/4） × 4 个精度变体（`lowp_`/`mediump_`/`highp_`/无前缀） = **256 个类型别名定义数**。此数量精确可算（16 家族：`bvec`、`ivec`、`uvec`、`vec`、`dvec`、`i8vec`、`i16vec`、`i32vec`、`i64vec`、`u8vec`、`u16vec`、`u32vec`、`u64vec`、`fvec`、`f32vec`、`f64vec`；4 分量数：1/2/3/4；4 精度标志：`lowp_`/`mediump_`/`highp_`/无前缀。16×4×4=256）。
>
> **重要说明**：256 是 **type alias 定义数**（即 `type Vec2f = Vec2<Float32>` 这样的别名语句数量），而非泛型结构体实际实例化数。实际泛型结构体实例化数量取决于 Vec1~Vec4 各结构体的类型参数组合：4 个分量数（Vec1~Vec4）× 每个分量数的类型参数组合数（bool + 8 整数 + 2 浮点 = 11 基础类型，若省略无用组合如 Vec2<Bool> 则更少）≈ 4×11 = 44 个最大结构体实例。别名相当于为同一结构体实例提供多个命名入口（如 `Vec2Float32` 和 `HighpVec2` 可能映射到同一结构体实例）。
>
> 向量别名依赖 `vec<N,T,Q>` 的完整结构体定义（在 3B 中完成迁移后方可导入），不可与标量类型别名（3A.3 仅依赖前向声明）同时编译。本部分共涉及 256 个 type alias 定义。虽有数量但均为简单的类型别名，工程实现量远小于一个向量模板特化的实现。

#### D. 首轮范围规模总结

| 类型 | 数量 |
|------|------|
| 配置/基础设施文件（`setup` + `qualifier`） | 2 个核心文件 |
| 标量类型：int8-u64 8 个整数位宽 + float、double，以及 bool 关键字 | 10 个基础数值类型 + bool + 精度变体 |
| 向量模板及特化 | 4 个模板结构体 + inline 实现 |
| 向量辅助文件（`compute_vector_relational.hpp`、`compute_vector_decl.hpp`、`_vectorize.hpp`） | 3 个辅助文件（随首轮 vec 类型同步迁移。`_swizzle.hpp` 已排除，见 4.5 节） |
| 向量 type alias（含精度变体） | 256 个类型别名 |
| 核心实现文件（子范围 1, 2a, 4-7） | 2 基础设施 + 4 vec 模板 + 3 辅助文件 = 9 个 |
| 别名/映射文件（子范围 2b, 8） | `fwd.hpp` 的 2 个子部分（标量别名 + 向量别名） |
| **合计 GLM 源文件** | **11 个**（9 核心实现 + 2 别名/映射），与 3G 节一致 |
| 合计类型别名定义数 | 256（16 家族 × 4 分量数 × 4 精度变体） |
| 泛型结构体实际实例化数 | ≤44（4 分量数 × 11 基础类型，忽略无用组合时更少） |

### 3E. 首轮迁移文件清单

以下清单按迁移子范围分组，每个条目包含源路径、类型说明、依赖关系和子范围编号，可直接作为实施依据：

| 序号 | 源文件路径（GLM 1.0.3） | 类型说明 | C++ 依赖 | Shim 依赖 | 子范围 |
|------|------------------------|---------|----------|----------|--------|
| 1 | `glm/detail/setup.hpp` | 配置/平台抽象 + `length_t` 类型定义 | 无内部 GLM 依赖；`<cassert>`（断言）、`<cstddef>`（size_t） | `shim_assert.cj`、`shim_cstddef.cj` | 1 |
| 2 | `glm/detail/qualifier.hpp` | `qualifier` 枚举、`vec/mat/qua` 前向声明、`storage` 结构 | `setup.hpp` | —（依赖传递至 setup 覆盖） | 1 |
| 3 | `glm/detail/compute_vector_relational.hpp` | 向量关系运算辅助函数实现（模板定义中通过 `compute_equal` 模板参数引用 `std::numeric_limits<T>::is_iec559`） | `setup.hpp`、`<limits>`（标准依赖——该文件自身模板代码引用 `std::numeric_limits<T>::is_iec559`，非仅传递包含） | `shim_limits.cj` | 2a |
| 4 | `glm/detail/compute_vector_decl.hpp` | 向量声明辅助模板（`functor` 等） | `setup.hpp` + `qualifier.hpp`（包含上下文中解析）、`<cstddef>`（`std::size_t` 非类型模板参数，16 处）、`<functional>`（`std::plus<T>` 等）、`<limits>`（经 `compute_vector_relational.hpp` 传递） | `shim_cstddef.cj`、`shim_limits.cj`（传递，由 compute_vector_relational 覆盖）；`<functional>` → 内联替代，无独立 shim 文件（详见 0.7.2 节） | 2a |
| 5 | `glm/detail/_vectorize.hpp` | 向量化工具模板（`functor1`/`functor2` 等） | 无 `#include`，使用 `length_t`/`qualifier` 作为模板参数 | — | 2a |
| 6 | `glm/detail/type_vec1.hpp` + `type_vec1.inl` | `vec<1,T,Q>` 结构体定义及 inline 实现 | `qualifier.hpp`、`compute_vector_relational.hpp`（.inl 引入）、`<cstddef>`（.hpp 第 12 行） | `shim_cstddef.cj` | 4 |
| 7 | `glm/detail/type_vec2.hpp` + `type_vec2.inl` | `vec<2,T,Q>` 结构体定义及 inline 实现 | `qualifier.hpp`、`compute_vector_relational.hpp`（.inl 引入）、`<cstddef>` | `shim_cstddef.cj` | 5 |
| 8 | `glm/detail/type_vec3.hpp` + `type_vec3.inl` | `vec<3,T,Q>` 结构体定义及 inline 实现 | `qualifier.hpp`、`compute_vector_relational.hpp`、`compute_vector_decl.hpp`（.inl 引入）、`<cstddef>`；`.inl` 第 833 行条件包含 `type_vec_simd.inl`（需 `GLM_CONFIG_SIMD == GLM_DISABLE` 消除） | `shim_cstddef.cj` | 6 |
| 9 | `glm/detail/type_vec4.hpp` + `type_vec4.inl` | `vec<4,T,Q>` 结构体定义及 inline 实现 | `qualifier.hpp`、`compute_vector_relational.hpp`、`compute_vector_decl.hpp`（.inl 引入）、`<cstddef>`；`.inl` 第 1023 行条件包含 `type_vec_simd.inl`（需 `GLM_CONFIG_SIMD == GLM_DISABLE` 消除） | `shim_cstddef.cj` | 7 |
| — | `glm/detail/_swizzle.hpp` | swizzle 操作符重载（条件包含于 type_vecN.hpp） | `vec<L,T,Q>` 完整类型定义 | — | **3（已排除，见 4.5 节）** |
| 10 | `glm/fwd.hpp`（标量别名部分第 1-178 行） | 标量类型别名定义 | `qualifier.hpp` | — | 2b |
| 11 | `glm/fwd.hpp`（向量别名部分第 180-507 行） | 向量类型别名定义（256 个别名） | 对应 `vec<N,T,Q>` 完整定义 | — | 8 |
| S1 | `glm/detail/shim_assert.cj`（新增） | CangJie shim 层：`assert()` 宏替代，替换 `<cassert>` 的断言功能 | 无（仅使用 `if` + `throw`） | — | S |
| S2 | `glm/detail/shim_limits.cj`（新增） | CangJie shim 层：`numeric_limits<T>` 替代，提供类型限值查询接口 | 依赖于各数值类型静态属性（`.Max`、`.Min`、`.NaN` 等） | — | S |
| S3 | `glm/detail/shim_cstddef.cj`（新增） | CangJie shim 层：`size_t`/`ptrdiff_t` 替代。提供 `type SizeT = UInt64`（无符号语义场景：位运算、缓冲区大小）和 `type LengthT = Int64`（有符号语义场景：索引、长度）双别名，明确区分有符号/无符号使用场景 | 无 | — | S |

> **子范围说明**：子范围编号对应 4.7 节的范围边界划分。1=基础设施层，2a=向量辅助文件，2b=标量类型别名，S=shim 层（新增 CangJie 适配文件），4-7=各 vec 类型特化，8=向量别名。"Shim 依赖"列标注每个 GLM 源文件所需的 CangJie shim 层文件，与 0.7.2 节 Shim 策略总表对应。
>
> **迁移顺序**：按子范围编号增序逐层迁移验证。子范围 1 + S（shim 层随基础设施同步迁移）→ 子范围 2a,2b（可并行）→ 子范围 4-7（可并行）→ 子范围 8。

> **`_swizzle.hpp` 迁移风险**（详见 4.5 节）：该文件使用 `reinterpret_cast<T*>(_buffer)` 和 `char _buffer[1]` 模式实现底层 reinterpret 访问。CangJie **不直接支持 reinterpret_cast**。首轮建议默认禁用 swizzle（配置 `GLM_SWIZZLE_DISABLED`），将 `_swizzle.hpp` 排除出首轮范围。swizzle 功能可在后续轮次通过 CFFI `unsafe` 块或替代 API 设计重新实现。
>
> **`fwd.hpp` 文件同一性说明**：上述清单中条目 10（标量别名部分第 1-178 行）和条目 11（向量别名部分第 180-507 行）均对应同一 C++ 源文件 `glm/fwd.hpp` 的不同节段。CangJie 中应根据包结构拆分为两个文件——标量别名部分归入 `package glm`（仅依赖 `qualifier.hpp` 前向声明），向量别名部分归入 `package glm`（需依赖 Vec1~Vec4 完整定义）。

> **首轮范围性质说明**：本节描述的首轮范围是**推荐范围**——在完整性和工作量之间取得平衡，并非最简可行范围。若需进一步缩减首轮规模，可按以下优先顺序裁减：① 降级 `vec1` 至第 2 轮（减少 1 个模板特化及对应约 16～64 个别名——16 为仅统计无前缀基础别名时的数量，含精度变体则为 64 个；本文档别名计量口径为含精度变体，全文统一按此口径）；② 将 4 个精度变体缩减为仅 `highp_` 变体（别名数量从 256 降至 64 个）；③ 将 `compute_vector_decl.hpp` 和 `_vectorize.hpp` 预留给第 2 轮（仅 `compute_vector_relational.hpp` 随 vec 类型迁移，`type_vec3.inl`/`type_vec4.inl` 中对 `compute_vector_decl` 的调用暂以 stub 占位）。
>
> **最简可行范围文件清单**：基础设施 + `vec<2-4,T,Q>` + `highp_` 精度别名 + `compute_vector_relational.hpp`，约 5 个核心文件及约 48 个别名。具体清单如下：
>
> | 序号 | 源文件路径 | 类型说明 | 与推荐范围的差异 |
> |------|-----------|---------|----------------|
> | 1 | `glm/detail/setup.hpp` | 配置/平台抽象 + `length_t` | 同推荐范围 |
> | 2 | `glm/detail/qualifier.hpp` | `qualifier` 枚举、前向声明 | 同推荐范围 |
> | 3 | `glm/detail/compute_vector_relational.hpp` | 向量关系运算辅助函数 | 同推荐范围 |
> | 4 | `glm/detail/type_vec2.hpp` + `type_vec2.inl` | `vec<2,T,Q>` 结构体及实现 | 同推荐范围 |
> | 5 | `glm/detail/type_vec3.hpp` + `type_vec3.inl` | `vec<3,T,Q>` 结构体及实现 | 同推荐范围 |
> | 6 | `glm/detail/type_vec4.hpp` + `type_vec4.inl` | `vec<4,T,Q>` 结构体及实现 | 同推荐范围 |
> | — | `glm/detail/type_vec1.hpp` | `vec<1,T,Q>` | **降级至第 2 轮**（最少引用的向量类型） |
> | — | `glm/detail/compute_vector_decl.hpp` | 向量声明辅助模板 | **以 stub 占位延至第 2 轮** |
> | — | `glm/detail/_vectorize.hpp` | 向量化工具模板 | **以 stub 占位延至第 2 轮** |
> | — | `glm/fwd.hpp`（向量别名） | 256 个别名 | **缩减为仅 `highp_` 变体（约 48 个）** |
>
> **最简范围别名数量**：16 个别名家族 × 3 个分量数（2/3/4，不含 vec1） × 1 个精度变体（`highp_`） = 48 个别名。若保留无前缀别名（即 `highp_` 为默认），则别名总数 = 16 × 3 × 1 = 48（不含精度前缀即为默认值）。

---

### 3F. 命名空间/包映射策略

GLM 中所有类型均定义在 `namespace glm` 内，部分内部实现位于 `namespace glm::detail`。CangJie 以包（package）为模块组织单位，无嵌套命名空间概念，但支持以 `.` 分隔的子包层次。首轮迁移采用如下映射策略：

| C++ 命名空间 | 对应 CangJie 包路径 | 适用文件（首轮） | 跨包引用策略 |
|-------------|-------------------|----------------|------------|
| `glm` | `package glm` | `fwd.hpp`（标量别名部分） | `glm` 包公开所有公共类型别名 |
| `glm::detail` | `package glm.detail` | `setup.hpp`、`qualifier.hpp`、`compute_vector_relational.hpp`、`compute_vector_decl.hpp`、`_vectorize.hpp`、`type_vec1.hpp`～`type_vec4.hpp` | `glm` 包中的别名类型引用 `glm.detail` 中的具体结构体时，需在 `glm` 包中使用 `import glm.detail.*` 导入 |
| `glm`（别名定义） | `package glm` | `fwd.hpp`（向量别名部分） | 引入 `glm.detail` 中的 Vec1～Vec4 具体类型后定义别名 |

**具体映射方案**：

1. 首轮共创建两个包：`glm.detail`（核心实现）和 `glm`（公共别名层），依赖关系为 `glm` → `glm.detail`
2. 所有首轮核心结构体定义（`qualifier` 枚举、`Vec1`～`Vec4` 结构体、辅助文件中的工具结构体）均放置在 `package glm.detail` 中
3. 标量类型别名和向量类型别名放置在 `package glm` 中，通过 `import glm.detail.*` 引入核心类型后定义
4. `glm.detail` 内的文件之间无需包引用——同包内类型直接可见
5. `package glm` 中的文件如需引用 `Vec1<T,Q>` 等类型，需显式 import，例如：
   ```
   package glm
   import glm.detail.{ Vec1, Vec2, Vec3, Vec4, qualifier }
   type Vec1f32 = Vec1<Float32, qualifier.packed_highp>
   ```
6. 后续轮次（矩阵、四元数、函数库）继续扩展 `glm.detail` 和 `glm` 两个包，或按目录结构新增 `glm.ext`、`glm.gtc`、`glm.gtx` 等子包

---

### 3G. 范围确认结论

本节统一汇总首轮迁移范围的确认结论，集中呈现核心文件清单、类型数据、验证标准摘要及依赖闭合性声明。

#### 核心文件清单

首轮迁移共涉及 **11 个 GLM 源文件**（不含 shim 层新增文件）：

| 序号 | 源文件路径 | 类型说明 | 子范围 |
|------|-----------|---------|--------|
| 1 | `glm/detail/setup.hpp` | 配置/平台抽象 + `length_t` 类型定义 | 1 |
| 2 | `glm/detail/qualifier.hpp` | `qualifier` 枚举、`vec/mat/qua` 前向声明、`storage` 结构 | 1 |
| 3 | `glm/detail/compute_vector_relational.hpp` | 向量关系运算辅助函数实现 | 2a |
| 4 | `glm/detail/compute_vector_decl.hpp` | 向量声明辅助模板（`functor` 等） | 2a |
| 5 | `glm/detail/_vectorize.hpp` | 向量化工具模板（`functor1`/`functor2` 等） | 2a |
| 6 | `glm/detail/type_vec1.hpp` + `type_vec1.inl` | `vec<1,T,Q>` 结构体定义及 inline 实现 | 4 |
| 7 | `glm/detail/type_vec2.hpp` + `type_vec2.inl` | `vec<2,T,Q>` 结构体定义及 inline 实现 | 5 |
| 8 | `glm/detail/type_vec3.hpp` + `type_vec3.inl` | `vec<3,T,Q>` 结构体定义及 inline 实现 | 6 |
| 9 | `glm/detail/type_vec4.hpp` + `type_vec4.inl` | `vec<4,T,Q>` 结构体定义及 inline 实现 | 7 |
| 10 | `glm/fwd.hpp`（标量别名部分第 1-178 行） | 标量类型别名定义 | 2b |
| 11 | `glm/fwd.hpp`（向量别名部分第 180-507 行） | 向量类型别名定义（256 个） | 8 |

同时新增 **3 个 CangJie shim 文件**（位于 `glm/detail/` 目录）：

| 文件 | 说明 |
|------|------|
| `shim_assert.cj` | `<cassert>` 断言功能替代 |
| `shim_limits.cj` | `<limits>` 类型限值查询替代 |
| `shim_cstddef.cj` | `<cstddef>`（`size_t`/`ptrdiff_t`）替代 |

**迁移顺序**：子范围 S（shim 层） → 子范围 1（基础设施） → 子范围 2a,2b（可并行） → 子范围 4-7（可并行） → 子范围 8（向量别名）。

#### 类型数量汇总

| 类型类别 | 数量 | 说明 |
|---------|------|------|
| Vec 泛型结构体 | 4 | `Vec1<T,Q>` ~ `Vec4<T,Q>`（不含 Vec1 则为 3） |
| 标量基础数值类型 | 10 | `Int8`~`UInt64` 8 整数 + `Float32` + `Float64` |
| bool 类型 | 1 | 映射自 C++ `bool` |
| 向量类型别名 | 256 | 16 家族 × 4 分量数 × 4 精度变体 |
| 扣除非 Vec1 别名（最简范围） | 48 | 16 家族 × 3 分量数（2/3/4）× 1 精度变体（仅 highp） |
| 泛型结构体实际实例化数 | ≤44 | 4 分量数 × 11 基础类型（忽略无用组合时更少） |

#### 验证标准摘要

详细验证步骤见 4.4 节。核心验收准则如下：

| 准则 | 判定条件 |
|------|---------|
| 依赖闭合性 | 11 个核心文件 + 3 个 shim 文件的 `#include` 依赖链不超出首轮范围。编译无 `file not found` 错误 |
| 独立可编译性 | 禁用全部 mat/qua/ext/gtc/gtx 后编译通过；可按子范围逐层编译 |
| 基础类型可用性 | Vec 类型支持构造、`[]` 分量访问、`+`/`-`/`*`/`/` 算术运算 |
| 类型别名可用性 | `Vec2Float32`、`DVec4` 等别名可正确实例化 |
| 溢出策略正确性 | 复合赋值算术运算符标注 `@OverflowWrapping`（约 16 处），二元运算符委托继承 wrapping 语义 |
| SIMD 条件编译消除 | `GLM_CONFIG_SIMD = GLM_DISABLE`，不引入 `type_vec_simd.inl` |

#### 依赖闭合性与独立可编译性声明

首轮范围满足以下性质：

1. **依赖闭合性**：所有 11 个核心文件的 `#include` 依赖链经过逐文件审查确认，不超出首轮声明的文件集合。C++ 标准库依赖（`<cassert>`、`<cstddef>`、`<limits>`、`<functional>`）均有对应的 CangJie 替代策略（shim 文件或内联替代）。`<functional>` 中的 `std::plus<T>` 等函数对象改用泛型参数约束或 Lambda 表达式内联替代，不产生独立 shim 文件。

2. **独立可编译性**：首轮范围可在不依赖任何矩阵、四元数、ext/、gtc/、gtx/ 组件的情况下独立通过编译。`GLM_CONFIG_SIMD` 设为禁用，消除 `type_vec_simd.inl` 的条件依赖；`GLM_CONFIG_SWIZZLE` 设为禁用，消除 `_swizzle.hpp` 的条件依赖。

3. **配置关联依赖**：首轮 `GLM_CONFIG_*` 常量（完整 18 项清单见 3A.1 节）全部选用最保守设置，不触发任何首轮范围外的条件包含。

---

## 后续轮次迁移规划

### 第 2 轮：矩阵类型 + `ext/` 别名文件

**依赖前提**：首轮完成（`vec<N,T,Q>` 及标量/向量别名就绪）

| 内容 | 角色 | 依赖 |
|------|------|------|
| 全部 9 个矩阵类型（`mat<2-4,2-4,T,Q>`） | 核心类型层 | 依赖对应的 `vec<N,T,Q>` |
| 矩阵类型别名 | `fwd.hpp` 中的矩阵别名（如 `mat2x2`、`mat4x4` 等） | 依赖矩阵类型完整定义 |
| `ext/` 下的向量/矩阵别名文件（如 `ext/vector_float2.hpp`、`ext/matrix_float4x4.hpp` 等） | 类型具现化，仅含 type alias 和精度变体 | 依赖向量/矩阵类型定义 |
| `type_float.hpp`、`type_half.hpp` | 可选基础设施（浮点类型标签） | 仅依赖 `setup.hpp`，可在本轮或更早独立迁移 |

> 矩阵类型本身不增加新的模板复杂度（实现模式与 `vec` 类似），且全部 9 个矩阵头文件间无相互依赖，可并行实现。
>
> 矩阵 `.inl` 实现中涉及的函数库头文件（`matrix.hpp`、`common.hpp`、`geometric.hpp`）暂不迁移——可在第 2 轮编译验证时通过 stub 空实现占位，待第 4 轮函数库迁移时替换。`.hpp` 声明文件可独立编译。

**验证标准**：
- 创建/访问矩阵（构造、行列访问、基本算术）
- `mat2x2`、`mat3x3`、`mat4x4` 各基本类型的实例化
- `ext/vector_float2.hpp` 等别名文件引用 `vec2` 成功

---

### 第 3 轮：四元数 + 附带 ext/gtc 依赖

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

> `type_quat.hpp` 第 7-14 行在 struct 定义之前无条件 `#include` 了上表所列的全部头文件（包含 ext/gtc 文件），所有文件均为编译期硬性依赖——不存在"类型结构可不依赖 ext/gtc"的选项。若确有分期迁移需求，可行方案为：① 修改 `type_quat.hpp` 的 `#include`，将 ext/gtc 依赖改为条件包含或前向声明替代；② 为 ext/gtc 头文件创建空桩文件以通过编译。
>
> **gtc/matrix_transform.hpp 隐式依赖链分析**：`gtc/matrix_transform.hpp` 的传递依赖链是最重的——直接包含 `mat4x4.hpp`、`vec2.hpp`、`vec3.hpp`、`vec4.hpp`、`ext/matrix_projection.hpp`、`ext/matrix_clip_space.hpp`、`ext/matrix_transform.hpp`。后三个 ext 文件进一步引入 `gtc/constants.hpp`、`geometric.hpp`、`trigonometric.hpp`、`matrix.hpp`。`.inl` 实现则额外引入 `geometric.hpp`、`trigonometric.hpp`、`matrix.hpp`。完整传递依赖链覆盖：全部 9 个矩阵类型、全部 4 个向量类型、基础设施层、以及多个核心函数库（geometric、trigonometric、matrix）。是 8 个 include 中依赖范围最广的文件。
>
> **ext/gtc 范围弹性说明**：第 3 轮范围可根据 type_quat 对 ext/gtc 依赖文件的处理方式弹性调整——`ext/vector_relational.hpp` 和 `gtc/constants.hpp` 依赖链最浅（均止于 `qualifier.hpp`/`setup.hpp`），属低附加范围；`ext/quaternion_relational.hpp` 依赖链涉及函数库层，属中等附加范围；`gtc/matrix_transform.hpp` 传递依赖链覆盖全部 9 个矩阵类型、全部 4 个向量类型及多个核心函数库，属高附加范围。

**验证标准**：
- 四元数构造、旋转、插值基本功能
- `quat` 类型别名的可用性

---

### 第 4 轮：函数库迁移

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

### 第 5 轮及以后：可选/平台特化

| 内容 | 说明 |
|------|------|
| SIMD 优化特化 | 平台相关，可在核心功能稳定后按需添加 |
| SIMD 检测头文件（`simd/platform.h`） | 其提供的平台检测宏**功能**已在首轮 `setup.hpp` 等价实现中以内联方式处理；该文件**作为独立文件结构**的拆分和完整实现推迟至此轮 |
| `gtx/` 实验性扩展 | 按实际需求选择性迁移 |

---

### 分层迁移总览

| 轮次 | 内容 | 依赖前提 | 风险等级 | 复杂度 |
|------|------|---------|---------|--------|
| 1 | 基础设施 + 标量 + `vec<N,T,Q>` + 向量别名 | 无 | 中低 | 中（模板核心） |
| 2 | 矩阵类型 + `ext/` 别名文件 | 第 1 轮 | 中 | 中（模式重复） |
| 3 | 四元数 + 附带的 ext/gtc 依赖 | 第 2 轮 | 中 | 中高（跨层次） |
| 4 | 函数库（common、matrix、geometric、ext、gtc） | 第 1-3 轮 | 低 | 高（量大面广） |
| 5+ | SIMD 特化、gtx 实验性扩展 | 第 4 轮 | 低 | 低（按需） |

---

## 4. 选择理由

### 4.1 为什么选这些类型作为首轮

1. **最小可编译集合**：`vec<N,T,Q>` 仅依赖 `qualifier` 枚举和标量类型。迁移这组类型后，编译/运行验证可立即验证类型系统的基础能力（模板、泛型、运算符重载、枚举等）。

2. **依赖关系要求**：`vec` 被所有其他类型（`mat`、`qua`、`ext/*`、`gtc/*`）依赖。必须先有 `vec`，才能迁移任何其他类型。

3. **实用价值**：向量类型是图形学数学最常用的类型。GLM 的核心价值在于提供类似 GLSL 的 `vec2`/`vec3`/`vec4`。

4. **风险控制**：首轮仅涉及 4 个向量模板 + 基础设施层，依赖链单一清晰，出错时可快速定位和修复。

### 4.2 定量依赖佐证

以下数据基于 GLM 源码中相关头文件被**直接引用**（显式 `#include`）的唯一文件数量统计：

```
基础设施层：
  setup.hpp:               36 个文件引用
  qualifier.hpp:           36 个文件引用

向量类型：
  vec<3,T,Q>: 19   vec<4,T,Q>: 18   vec<2,T,Q>: 17   vec<1,T,Q>: 11

矩阵类型：
  mat<4,4,T,Q>: 8   mat<3,3,T,Q>: 7   mat<2,2,T,Q>: 6
  mat<2,3,T,Q>: 5   mat<2,4,T,Q>: 5   mat<3,2,T,Q>: 5
  mat<3,4,T,Q>: 5   mat<4,2,T,Q>: 4   mat<4,3,T,Q>: 5

四元数：
  type_quat: 4
```

向量类型（vec2-4）的引用数是矩阵类型的 2-3 倍，是四元数的约 4 倍。这与拓扑依赖分析一致：向量位于依赖层次底部，是被依赖最多的类型层。

### 4.3 关于 `ext/` 和 `gtc/` 内容划分

首轮迁移范围限定在 `glm/detail/` 下的核心类型定义。`ext/` 和 `gtc/` 目录包含的内容可分为以下几类：

| 类别 | 示例 | 与首轮关系 |
|------|------|-----------|
| **类型别名/具现化文件** | `ext/vector_float2.hpp`、`ext/matrix_float4x4.hpp` | 依赖首轮核心类型，可在首轮完成后立即迁移，低风险 |
| **功能函数库** | `ext/matrix_transform.hpp`、`ext/scalar_common.hpp`、`gtc/matrix_transform.hpp` | 依赖核心类型和类型别名，推荐在类型别名就绪后迁移 |
| **扩展工具库** | `gtx/*`、`gtc/noise.hpp`、`gtc/random.hpp` | 无前置依赖约束，可最后处理 |

**首轮核心类型迁移完成后**，`ext/` 下的向量/矩阵别名文件（如 `ext/vector_float2.hpp`、`ext/matrix_float4x4.hpp`）可作为第二轮高优先级迁移内容，因为它们仅包含 type alias 和精度变体，范围边界清晰。

### 4.4 验证标准

首轮迁移范围应满足以下验收准则。本版为每条准则补充可执行的验证步骤和 CangJie 代码片段：

| 验收准则 | 范围级描述 | 可执行验证步骤 |
|---------|----------|--------------|
| 依赖闭合性 | 首轮范围内所有文件的 `#include` 依赖链不超出首轮范围声明的文件集合 | **步骤**：在 CangJie 空项目中创建 `src/glm/` 目录，将首轮迁移的 9 个核心文件 + 2~3 个 shim 文件共 11~12 个文件按依赖拓扑放入，每个文件头部添加对应的 `package glm.detail` 或 `package glm` 声明。执行 `cjpm build`，检查是否缺失任何未在首轮范围内的引用。**通过条件**：编译通过，无 `file not found` 错误 |
| 拓扑可编译性 | 首轮文件可按依赖拓扑顺序逐层编译，每层无遗漏外部依赖 | **步骤**：按子范围（1→2a,2b→4,5,6,7→8）顺序逐层创建临时包并编译。**验证脚本伪代码**：<br><pre>// 子范围 1 验证<br>package round1_sub1<br>// setup.cj (package glm.detail, 包含 qualifier 和 length_t 定义)<br>// qualifier.cj (package glm.detail, 包含 qualifier 枚举和前向声明)<br>// 编译: cjc src/glm/detail/setup.cj src/glm/detail/qualifier.cj ✓</pre> |
| 边界隔离性 | 首轮范围不依赖任何未迁移的 GLM 组件 | **步骤**：在编译环境中禁用全部 mat/qua/ext/gtc/gtx 头文件路径；仅提供首轮 9 个核心文件 + 2~3 个 shim 文件路径；执行编译。**通过条件**：编译通过，且编译错误信息中不包含任何首轮范围外的文件缺失提示 |
| 基础类型可用性 | 所有首轮向量类型支持构造、分量访问和基本算术运算 | **步骤**：在首轮编译通过后，编写如下 CangJie 测试代码并运行：<br><pre>package glm_test<br>import glm.detail.{ Vec4, qualifier }<br>main() {<br>    let v = Vec4&lt;Float32, qualifier.packed_highp&gt;(1.0f32, 2.0f32, 3.0f32, 4.0f32)<br>    println("${v[0]} ${v[1]} ${v[2]} ${v[3]}")  // 分量访问<br>    let sum = v + v  // 算术运算<br>    println("${sum[0] == 2.0f32}")<br>}</pre>**通过条件**：编译运行通过，输出符合预期 |
| 类型别名可用性 | 首轮声明的向量类型别名可正确实例化 | **步骤**：编写 CangJie 测试：<br><pre>package glm_test<br>import glm.{ Vec2Float32, Vec3Float32, DVec4 }<br>main() {<br>    let v2: Vec2Float32 = Vec2Float32(1.0f32, 2.0f32)<br>    let v3: Vec3Float32 = Vec3Float32(1.0f32, 2.0f32, 3.0f32)<br>    let v4: DVec4 = DVec4(1.0f64, 2.0f64, 3.0f64, 4.0f64)<br>    println("${v2[0]} ${v3[1]} ${v4[2]}")<br>}</pre>**通过条件**：编译运行通过 |
| 溢出策略正确性 | 复合赋值算术运算符（`+=`、`-=`、`*=`、`/=`）标注 `@OverflowWrapping`；二元算术运算符通过委托模式继承 wrapping 语义 | **步骤**：① 在编译环境中启用溢出策略检查；② 审查每个 Vec 类型上标注 `@OverflowWrapping` 的运算符函数数量是否符合预期（约 16 处——4 类型 × 4 复合赋值）；③ 编写测试用例验证 `Int32` 分量向量复合赋值运算在溢出时不抛出异常；④ 验证二元 `+`/`-`/`*` 等通过委托自动享有 wrapping 行为。**通过条件**：编译无溢出策略相关告警；运行时溢出行为符合 wrapping 语义，不抛出 ArithmeticException；浮点类型 Vec 运算不受影响 |
| SIMD 条件编译消除 | `GLM_CONFIG_SIMD` 设为 `GLM_DISABLE`，`type_vec3.inl`/`type_vec4.inl` 的条件包含块不引入 `type_vec_simd.inl` | **步骤**：在 `setup.hpp` 等效实现的 `GLM_CONFIG_*` 常量声明中确认 `GLM_CONFIG_SIMD = false`（或等效的 `GLM_DISABLE`）；编译 `type_vec3`/`type_vec4` 时验证编译器不查找 `type_vec_simd.inl`。**通过条件**：编译通过，无 `type_vec_simd.inl: No such file` 等缺失文件错误 |

> **包组织说明**：上述验证步骤假设首轮文件按以下目录结构组织：`src/glm/detail/` 目录存放子范围 1、2a、4-7 的所有类型定义文件（对应 `package glm.detail`）；`src/glm/` 目录存放子范围 2b 和 8 的别名文件（对应 `package glm`）。`package glm.detail` 中的文件声明如 `package glm.detail`；`package glm` 中的文件通过 `import glm.detail.*` 引用具体类型。验证时应在项目根目录的 `cjpm.toml` 中确保 `src/` 为源码根目录。

### 4.5 `_swizzle.hpp` CangJie 迁移可行性评估

**风险等级**：高

**核心问题**：`_swizzle.hpp` 使用了 `reinterpret_cast<T*>(_buffer)` 将 `char _buffer[1]` reinterpret 为元素类型指针以访问向量分量，这是 C++ 低层内存操作的惯用模式。

**CangJie 支持情况**：
- CangJie 没有 `reinterpret_cast`。CFFI 提供 `CPointer<T>` 和 `unsafe` 块用于 C 互操作，但这并非为同构类型内部内存 reinterpret 设计。
- CangJie struct 是值类型，赋值/传参时复制；VArray 是值类型固定长度数组。两者都不支持通过 `char` 缓冲区 reinterpret 为其他类型。

**备选方案**：

| 方案 | 说明 | 对首轮范围的影响 |
|------|------|----------------|
| **A. 首轮禁用 swizzle** | 配置 `GLM_SWIZZLE_DISABLED`，修改 `type_vecN.hpp` 中的条件包含为不包含 swizzle 文件。`GLM_SWIZZLE` 功能在首轮不提供 | `_swizzle.hpp` 排除出首轮范围，其余内容不变。推荐方案 |
| **B. 重新设计 swizzle 机制** | 放弃 reinterpret 模式，改用成员函数替代 swizzle 操作符（如 `.xy()`、`.xyz()` 等，返回新向量而非引用），避免低层 reinterpret | 首轮需额外工作量实现替代 API，但可纳入 `swizzle` 功能 |
| **C. 使用 CFFI unsafe 绕过** | 使用 `unsafe { CPointer<T>(addressOf(buffer)) }` 模式 | 不可行：CangJie struct 为值类型，`addressOf` 不存在；CFFI 的 unsafe 主要用于 C 互操作，非常规代码设计 |

**推荐结论**：首轮采用**方案 A**，默认关闭 swizzle 功能。swizzle 操作的语义等价可通过类型成员函数在后续轮次补充。在首轮范围中移除 `_swizzle.hpp` 文件，同时修改对应 `type_vecN.hpp` 中的条件包含逻辑。

### 4.6 首轮迁移风险评估

首轮风险评级从"低"调整为**"中低"**（v9 修正），理由为以下可量化的风险因素：

| 风险项 | 风险等级 | 说明 | 缓释措施 |
|--------|---------|------|---------|
| R1. 泛型偏特化不支持 | **中** | CangJie 不支持 C++ 式偏特化，`vec<N,T,Q>` 单模板方案不可行，需拆分为 Vec1~Vec4 四个独立结构体。拆分影响 `_vectorize.hpp` 的模板模板参数和 functor 结构 | 首轮采用独立结构体方案（4 个 Vec 类型 × 4 个 functor = 16 个定义），实现模式简单，工作量可预估 |
| R2. `setup.hpp` 平台检测映射待验证 | **中** | CangJie 无预处理器，`setup.hpp` 中 1000+ 行平台/编译器/架构检测无直接等价映射 | 首轮仅迁移基础配置（~100 行），平台检测映射列为第 5 轮任务。首轮编译验证不依赖此功能 |
| R3. Shim 层需语言专家确认 | **中** | `shim_assert.cj`、`shim_limits.cj`、`shim_cstddef.cj` 三个 shim 文件的 CangJie 实现（特别是 `numeric_limits` 等效替代的泛型接口设计）需仓颉语言最佳实践确认 | 首轮 shim 层实现遵循最简原则——assert 用 `if+throw`，limits 用类型静态属性 + 泛型 `where T <: Number<T>` 约束 |
| R4. `compute_vector_decl.hpp` 中 `std::size_t` 非类型模板参数映射 | **低-中** | 16 处 `std::size_t Size` 作为非类型模板参数，CangJie 中需确认非类型模板参数是否支持 `Int64` 类型 | `Int64` 作为 CangJie 默认整数类型，为非类型模板参数的合法类型。首轮验证即可确认 |
| R5. 整数溢出语义差异 | **低** | C++ UB → CangJie 抛异常，需在 ~16 处运算符函数上标注 `@OverflowWrapping` | 标注量明确（~16 处），委托模式可减少重复。浮点类型无影响 |
| R6. GLM 源码量 vs CangJie 实现量不可精确对应 | **低** | C++ 模板代码与 CangJie 泛型代码行数比例难以预估计，可能影响工作量预估 | 首轮 9 个核心文件 + 3 个 shim 文件体量有限（GLM 约 2000 行 C++ → CangJie 预估 1500-2500 行），可通过首轮实践校准后续轮次估算 |

**综合评级理由**：首轮的风险集中在 R1-R3 三项"中"级风险上——均非技术不可行（均有确定的替代方案），但需在首轮实施过程中验证替代方案的完备性。R4-R6 风险较低或有明确的处理方案。综合评估为**中低风险**——存在可管理的技术风险，但无不可逾越的障碍。

### 4.7 范围边界建议

首轮范围可按以下顺序界定其内部子范围，每个子范围的依赖关系独立闭合：

| 子范围 | 内容 | 范围边界 |
|--------|------|---------|
| S | Shim 层（新增 CangJie 适配文件：`shim_assert.cj`、`shim_limits.cj`、`shim_cstddef.cj`） | 边界闭合于自身，无 GLM 内部依赖，替代 C++ 标准库依赖 |
| 1 | 基础设施层（`setup.hpp` 配置 + `qualifier` 枚举 + `length_t`） | 边界闭合于自身，无外部 GLM 依赖 |
| 2a | 向量辅助文件（`compute_vector_relational.hpp` 依赖 `setup.hpp` + `<limits>`——其模板定义引用 `std::numeric_limits<T>::is_iec559`，详见 3E 文件清单；`compute_vector_decl.hpp` 和 `_vectorize.hpp` 需 `qualifier.hpp`/`setup.hpp` 作为包含上下文先被解析） | 边界闭合于基础设施层 + qualifier 前向声明 + shim 层，与 vec 完整类型定义无交叉依赖 |
| 2b | 标量类型别名（仅依赖 `qualifier.hpp` 前向声明） | 边界闭合于基础设施层 |
| 3 | `_swizzle.hpp`（**本轮排除**，见 4.5 风险说明） | — |
| 4 | `vec<1,T,Q>` + `vec1` 相关向量类型别名 | 边界：依赖基础设施层和标量类型，不引入其他核心类型 |
| 5 | `vec<2,T,Q>` | 同上 |
| 6 | `vec<3,T,Q>` | 同上 |
| 7 | `vec<4,T,Q>` | 同上 |
| 8 | `vec2`-`vec4` 相关公共 type alias | 边界：依赖对应 vec 类型定义，不超出首轮范围 |

> **注**：子范围 2a 的辅助文件在依赖拓扑上位于子范围 4-8 之前——`compute_vector_relational.hpp` 被全部 4 个 `type_vecN.inl` 无条件包含；`compute_vector_decl.hpp` 被 `type_vec3.inl` 和 `type_vec4.inl` 无条件包含。`compute_vector_relational.hpp` 的 `<limits>` 依赖（其模板定义引用 `std::numeric_limits<T>::is_iec559`）由 `shim_limits.cj` 覆盖（详见 3E 和 0.7 节）。`compute_vector_decl.hpp` 和 `_vectorize.hpp` 需 `qualifier.hpp`/`setup.hpp` 作为包含上下文先被解析（使用 `length_t`、`qualifier` 和 `std::size_t` 作为模板参数）。三者均无 vec 完整类型依赖，属于首轮范围的必要组成部分。

---

## 5. 类型依赖关系图（首轮范围）

```
setup.hpp 配置 (含 length_t 定义)
     │
     ├── 向量辅助文件（首轮必要，被 vec .inl 使用）───┐
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
> **`_swizzle.hpp` 排除说明**：首轮范围以 `GLM_SWIZZLE_DISABLED` 模式运行，`_swizzle.hpp` 不纳入首轮范围。swizzle 功能待后续轮次通过替代机制实现。
>
> **`_vectorize.hpp` 依赖链分析**：`_vectorize.hpp` 由 `compute_vector_decl.hpp` 无条件 `#include`（`compute_vector_decl.hpp:4`），位于 `compute_vector_decl.hpp` 的上游依赖位置。该文件自身不含任何 `#include` 指令，但使用 `length_t` 和 `qualifier` 作为模板参数，需 `qualifier.hpp`/`setup.hpp` 先被解析。定义 `functor1`、`functor2`、`functor2_vec_sca`、`functor2_vec_int` 四个模板工具结构体，属于纯类型工具文件，无进一步 GLM 内部依赖。首轮迁移中应随 `compute_vector_decl.hpp` 同步纳入。
>
> **`_swizzle.hpp` 依赖链分析**（本版已将其排除出首轮范围，此处为记录）：经审查确认，`_swizzle.hpp` 自身不含额外 `#include` 语句（仅定义 swizzle 构造器、重载操作符等纯类型工具），其依赖链闭合于首轮基础设施层——该文件不引入任何向量/矩阵/函数库类型。但 `_swizzle.hpp` 中定义的结构体继承自 `vec<L, T, Q>`，其编译需依赖 vec 的完整类型定义，因此随对应 `type_vecN.hpp` 一同编译而非独立编译。

首轮迁移完成后，所有向量的实例化类型均可用。后续轮次可以在此基础上添加矩阵、四元数及其他扩展。

---

## 修订说明（v2）

| 审查意见 | 处理方式 |
|---------|---------|
| P1. 缺少可直接执行的「核心文件清单」 | **修改**：在 3E 节新增完整的「首轮迁移文件清单」表格，包含源文件路径、类型说明、依赖关系、子范围编号和迁移顺序指引 |
| P2. CangJie 语言特性适应性分析缺失 | **修改**：将原第 0 节"目标语言能力假设"替换为基于 CangJie 官方文档的 "CangJie 语言特性适应性分析"（0.1-0.8 节），逐项给出明确结论（✅ 支持/⚠️ 需 shim/❌ 不支持+替代方案）。涉及泛型、运算符重载、类型别名、编译期条件、固定位宽整数、匿名组合类型、C++ 标准库等效替代等关键能力 |
| P3. 需求首项目标的度量标准偏差 | **修改**：在 2.3 节新增类型级依赖关系分析，统计每个核心类型被多少唯一类型定义直接引用，与文件级数据互为印证。分析结论与文件级数据一致 |
| P4. 验证标准过于抽象，缺乏可操作性 | **修改**：在 4.4 节为每条验收准则补充可执行验证步骤和 CangJie 代码片段/伪代码，包括编译命令、测试用例模板、通过/不通过判定条件 |
| P5. `_swizzle.hpp` 的 CangJie 迁移可行性未评估 | **修改**：在 4.5 节新增完整的 `_swizzle.hpp` 迁移可行性评估，分析 `reinterpret_cast` 在 CangJie 中不支持的结论，提供三种备选方案（A. 首轮禁用 swizzle / B. 重新设计 swizzle 机制 / C. CFFI unsafe），推荐方案 A。在 3E 清单和 5 节依赖图中相应标注排除 |
| P6. `compute_vector_relational.hpp` 的依赖描述不完整 | **修改**：在第 1 节（层次 1 描述）和第 3 节（子范围 2a 描述）中，将 `compute_vector_relational.hpp` 的依赖描述修正为"仅依赖 `setup.hpp` 和 C++ 标准库 `<limits>`（需 CangJie 等效替代）" |
| P7. 类型别名数量标注为"约"字不精确 | **修改**：将 3C 节和 3D 节中的"约 256 个"改为"256 个"，并在 3C 节以脚注形式给出 16 家族 × 4 分量数 × 4 精度变体 = 256 的完整计算过程 |

---

## 修订说明（v3）

| 审查意见 | 处理方式 |
|---------|---------|
| 问题1：交叉引用错误 — 子范围节号引用"4.5"应为"4.6" | **修改**：将 3E 节子范围说明中的"4.5 节"更正为"4.6 节"（第 4.6 节为范围边界建议表，子范围编号与之对应） |
| 问题2：VArray 语法符号不准确 — `$N` 为宏特定语法，非标准仓颉 | **修改**：将 0.1 节表格中 `VArray<T, $N>` 改为 `VArray<T, N>`（标准语法），并在括号内注明 `N` 为编译期常量 |
| 问题3：后续轮次规划内容依赖外部文件，文档自包含性不足 | **修改**：将此前"详细内容参见 a_v1_imported.md"的间接引用替换为后续轮次规划内容的完整内联正文，包括第 2～5 轮的全部内容、分层迁移总览表及验证标准，确保本文档可独立阅读 |
| 问题4：缺少 C++ 命名空间 → 仓颉包模块的映射策略 | **修改**：在 3E 节之后新增 3F 节"命名空间/包映射策略"，包含完整的 C++ 命名空间与 CangJie 包对照表、跨包引用策略说明、以及具体代码示例 |
| 问题5：第 0.8 节表格中 `Vec1<V.T,Q>` 语法错误 | **修改**：将 0.8 节表格中的 `Vec1<V.T,Q>` 更正为 `Vec1<T,Q>` |
| 问题6：验证步骤与仓颉编译模型的潜在不匹配 | **修改**：在 4.4 节为各验证步骤补充包组织说明——包括 `src/glm/detail/` 目录结构、`package glm.detail` / `package glm` 声明方式、测试代码中的 import 路径、`cjpm.toml` 源码根目录配置等 |

---

## 修订说明（v4）

| 审查意见 | 处理方式 |
|---------|---------|
| 问题1（严重）：3D 节辅助文件数量与 3E 节清单状态矛盾 — `_swizzle.hpp` 被计入 4 个辅助文件 | **修改**：在 3D 节将辅助文件从 4 个减为 3 个（移除 `_swizzle.hpp`），合计核心文件从 10 改为 9（2 基础设施 + 4 vec 模板 + 3 辅助文件） |
| 问题2（中）：`compute_vector_decl.hpp` 的 `<functional>` 和 `<limits>` 依赖未声明 | **修改**：在 3E 节文件清单第 4 行依赖列补充 `<functional>`（`std::plus<T>` 等函数对象）和 `<limits>`（`std::numeric_limits<T>::is_iec559`）；在 0.7 节 `<limits>` 行同步补充 |
| 问题3（轻微）：0.8 节 `<functional>` 的"首轮是否需要"写为"否（辅助文件）"自相矛盾 | **修改**：将 0.8 节 `<functional>` 行的首轮是否需要从"否（辅助文件）"改为"是"，迁移策略同步说明 `compute_vector_decl.hpp` 为首轮范围文件 |
| 问题4（中）：文件清单缺少 CangJie shim 层对应条目 | **修改**：在 3E 节文件清单新增 S1-S3 三行 shim 层条目（`shim_assert.cj`、`shim_limits.cj`、`shim_cstddef.cj`），新增子范围 S 说明，在 4.6 节范围边界表新增 S 行 |
| 问题5（轻微）：0.7 节将 `std::plus<T>` 等函数对象误称为 `std::function` | **修改**：将 0.7 节 `<functional>` 行的用途描述修正为"`std::plus<T>` 等标准函数对象（非 `std::function` 类型擦除包装器）"，替代方案更新为"泛型参数约束或 Lambda 表达式替代" |
| 问题6（轻微）：`compute_vector_decl.hpp` 对 `std::numeric_limits` 的依赖在 0.7 节被遗漏 | **修改**：在 0.7 节 `<limits>` 行用途描述补充 `compute_vector_decl.hpp`（`std::numeric_limits<T>::is_iec559`） |
| 问题7（轻微）：第 0 节未评估 `_vectorize.hpp` 中偏特化模式的 CangJie 适配影响 | **修改**：在 0.1 节末尾新增 `_vectorize.hpp` 偏特化说明，分析 `functor1`/`functor2` 等模板面临的相同 CangJie 限制及处理策略 |

```

---

## 修订说明（v5）

| 审查意见 | 处理方式 |
|---------|---------|
| 问题1（中等）：`type_vecN.hpp` 的 `<cstddef>` 直接依赖在依赖分析中被忽略 — 第 3E 节文件清单第 6–9 行的依赖列遗漏了各 `.hpp` 第 12 行的 `#include <cstddef>` | **修改**：在 3E 节文件清单第 6–9 行的依赖列补充 `+ <cstddef>`（需 CangJie shim；或通过 qualifier.hpp → setup.hpp 传递包含已覆盖） |
| 问题2（中等）：`setup.hpp` 的规模复杂度未被充分反映 — 第 3A 节仅以"目标语言中的配置/平台抽象"一言蔽之，未定量评估需手动转化的部分 | **修改**：在 3A.1 节补充定量评估 — 仅 `length_t` 定义、`GLM_CONFIG_*` 常量（约 10 个）、`uint` 类型别名、`countof` 辅助函数等约 50–100 行需要移植；剩余约 1000+ 行平台/编译器/架构检测代码标记为"首轮无需直接迁移" |
| 问题3（轻微）：`compute_vector_relational.hpp` 的 `<limits>` 依赖在首轮不需要 — 该文件活跃代码仅执行 `a == b`，不使用 `std::numeric_limits`；真正依赖 `<limits>` 的是 `compute_vector_decl.hpp` | **修改**：（1）在 0.7 节将 `compute_vector_relational.hpp` 从 `<limits>` 依赖方改为"包含但活跃代码未使用"；（2）在 3E 节文件清单第 3 行依赖列将 `+ <limits>` 改为 `setup.hpp`（`<limits>` 包含但未使用）；（3）在 4.6 节子范围 2a 说明和 5 节依赖图中同步更正 |
| 问题4（轻微）：C++ `int` → CangJie `Int32` 的映射未明确讨论 — 第 0.5 节和第 3A.3 节仅列出固定位宽类型映射 | **修改**：在 0.5 节结论行后补充一行："C++ `int`（`ivec` 等别名的默认分量类型）映射为 `Int32`，`unsigned int`（`uvec` 等别名的默认分量类型）映射为 `UInt32`" |

---

## 修订说明（v6）

| 审查意见 | 处理方式 |
|---------|---------|
| 问题1（中等）：`_vectorize.hpp` 中 C++ 模板模板参数（template template parameter）的 CangJie 迁移方案未被覆盖 — 文档建议的"分别定义独立结构体"方案无法应对 `functor1` 等模板的模板模板参数 | **修改**：在 0.1 节 `_vectorize.hpp` 说明中增补模板模板参数分析：(1) 明确指出 `_vectorize.hpp` 的 `functor1`/`functor2` 等模板使用 `template<length_t L, typename T, qualifier Q> class vec` 形式的模板模板参数；(2) 给出应对策略——为 Vec1~Vec4 分别定义独立 functor 结构体（`functor1_vec1`~`functor1_vec4` 等），或使用宏生成各分量数的 functor 版本；(3) 评估方案①将原 4 个 functor 扩展为 16 个，但实现模式简单，推荐首轮采用 |
| 问题2（中等）：`compute_vector_decl.hpp` 的 `std::size_t` 依赖在文件清单中遗漏 — 该文件在 16 处使用 `std::size_t` 作为模板参数，但文件清单依赖列未记录 `<cstddef>` | **修改**：(1) 在 3E 节文件清单第 4 行依赖列补充 `+ <cstddef>`（`std::size_t` 用作模板参数，16 处）；(2) 在 0.7 节 `<cstddef>` 行用途列补充 `compute_vector_decl.hpp` |
| 问题3（一般）：`compute_vector_relational.hpp` 的 `<limits>` 依赖描述存在误导——调用方代码活跃使用 `std::numeric_limits` | **修改**：(1) 在第 1 节将 `compute_vector_relational.hpp` 描述改为"自身活跃代码未直接使用，但其调用方 `type_vec1-4.inl` 和 `compute_vector_decl.hpp` 通过 `compute_equal` 模板实参活跃使用 `std::numeric_limits<T>::is_iec559`，因此 `<limits>` 等效替代为首轮编译必要依赖"；(2) 在 3E 节文件清单第 3 行依赖列同步更正；(3) 在 4.6 节子范围 2a 说明及 5 节依赖图图注中同步更正；(4) 在 0.7 节 `<limits>` 行用途描述同步更正 |
| 问题4（一般）：0.5 节固定位宽整数与 0.7 节缺失整数溢出处理策略的衔接 | **修改**：(1) 在 0.5 节末补充整数溢出语义说明行——C++ UB vs CangJie 抛出异常，建议首轮采用 wrapping 算术；(2) 在 0.8 节关键适应性结论表中增加"整数溢出语义差异"行 |

---

## 修订说明（v7）

| 审查意见 | 处理方式 |
|---------|---------|
| P1. 文档标题版本号与修订历史不一致 — 标题写为"(v4)"但实际已迭代至 v6 | **修改**：将标题中的"(v4)"更新为"(v7)" |
| P2. `setup.hpp` 平台检测能力的 CangJie 映射断言未经验证 — 声称 1000+ 行平台检测代码"功能由目标语言的运行时特性隐式提供"，但 CangJie 无预处理器等价平台检测机制 | **修改**：将断言改为待验证假设并标注"需 CangJie 语言专家确认"；提供三项具体建议（列入后续轮次、首轮仅提供基础配置、后续通过 `std.env` 等运行时接口补充）；在 3A.1 节同步更新 |
| P3. `storage` 结构体的 SIMD 平台特化可行性判断不完整 — 条件句"若目标语言不提供 SIMD 等价基础类型"未反映 CangJie 当前版本确无 SIMD 基础类型 | **修改**：将条件句改为明确结论："CangJie 当前版本不提供 SIMD 基础类型，首轮 `storage` 始终使用非 SIMD 通用路径。" |
| P4. vec1 降级可减少的别名数量存在计量矛盾 — "约 16 个别名"与 256 总和的计量口径不一致 | **修改**：改为"约 16～64 个别名"，注明 16 为无前缀基础别名数量、64 为含精度变体数量，并统一声明本文档计量口径为含精度变体 |
| P5. 子范围编号在文件清单与边界表之间的映射不够清晰 — `_swizzle.hpp` 排除项标注"见 P5 风险说明"而非子范围编号 | **修改**：改为"3（已排除，见 4.5 节）"，同时标注子范围编号和排除状态，实现者可直接关联到第 4.6 节中的子范围 3 |
| P6. 整数溢出策略建议缺少机制说明 — "全局采用 wrapping 算术"不可行，CangJie 不支持全局溢出策略设置 | **修改**：① 在 0.5 节将策略改为推荐在每个向量算术运算符函数上标注 `@OverflowWrapping`；② 在 0.7 节补充注解方案说明；③ 在 0.8 节同步更新溢出策略描述；④ 在 4.4 节验证标准中补充溢出策略验证步骤 |

---

## 修订说明（v8）

| 审查意见 | 处理方式 |
|---------|---------|
| 问题1（严重）：Section 1 中 `_swizzle.hpp` 范围状态与排除结论矛盾 — 注文前半句称"纳入范围"后半句称"禁用 swizzle"，与 3D/3E/4.5 节排除结论冲突 | **修改**：将 Section 1 注文改为明确首轮以 `GLM_SWIZZLE_DISABLED` 模式运行，`_swizzle.hpp` **排除出**首轮范围。删除"纳入范围"的表述，全文统一为排除状态 |
| 问题2（严重）：`GLM_CONFIG_SIMD` 条件包含未被覆盖 — `type_vec3.inl:833` 和 `type_vec4.inl:1023` 底部 `#if GLM_CONFIG_SIMD == GLM_ENABLE` 条件包含 `type_vec_simd.inl`（不在首轮范围内），保留默认 `GLM_ENABLE` 则构建必然失败 | **修改**：① 在 3A.1 节 `setup.hpp` 描述中明确 `GLM_CONFIG_SIMD` 必须设为 `GLM_DISABLE`；② 在 3A.1 节 `storage` 段落后新增 `GLM_CONFIG_SIMD` 条件包含说明框；③ 在 3E 节文件清单第 8-9 行（type_vec3/type_vec4）的依赖列补充条件性注释；④ 在 4.4 节验证标准新增 `GLM_CONFIG_SIMD` 配置检查项 |
| 问题3（中）：`compute_vector_decl.hpp` 的 `<limits>` 依赖类型描述不精确 — 该文件未直接 `#include <limits>`，`std::numeric_limits<T>::is_iec559` 经 `compute_vector_relational.hpp`（第 5 行）间接获得 | **修改**：① 将 3E 节文件清单第 4 行依赖列的 `+ <limits>` 改为 `+ <limits>`（经 `compute_vector_relational.hpp` 传递包含——第 5 行 `#include <limits>`，自身未直接 `#include`）；② 同步修正 0.7 节 `<limits>` 行描述 |
| 问题4（中）：`@OverflowWrapping` 标注范围缺乏量化指导和类别区分 — 未区分运算符类别、未量化工作量、未利用委托模式、未讨论浮点类型溢出语义 | **修改**：① 在 0.5 节后新增 0.5.1 节，包含运算符分类表（算术/位运算/比较/布尔/自增自减）、委托模式说明、标注工作量量化（16～28 处）、浮点类型溢出可忽略说明；② 更新 0.8 节溢出策略行指向 0.5.1 节；③ 更新 4.4 节验证标准溢出策略项，细化至复合赋值运算符验证 |

---

## 修订说明（v9）

| 审查意见 | 处理方式 |
|---------|---------|
| 1. `size_t`（无符号）→ `Int64`（有符号）的语义影响未评估 | **修改**：① 在 0.7 节 `<cstddef>` 行给出确定结论——`length_t` 统一映射为有符号 `Int64`，与 GLM 默认（`int`）一致；② 新增 0.7.1 节，分析 6 个场景（循环比较、循环下溢、位运算、边界检查、数组大小乘法溢出、非类型模板参数）的有符号/无符号语义差异，结论为主要影响为正向（避免无符号循环下溢陷阱），位运算差异在首轮范围极少出现；③ `shim_cstddef.cj` 升级为强制项，提供 `type SizeT = UInt64`（无符号场景）和 `type LengthT = Int64`（有符号场景）双别名；④ 新增 0.7.2 节，汇总全部 C++ 标准库设施的 shim 策略及优先级 |
| 2. 3D 节"合计可实例化类型 = 256"表述与别名性质矛盾 | **修改**：① 将 3D 节"合计可实例化类型"改为"合计类型别名定义数"并注明实际泛型结构体实例化数（约 44 个）；② 在 3C 节别名数量精确计算说明中新增"重要说明"框，区分 256 为 type alias 定义数与实际泛型结构体实例化数的差异 |
| 3. `GLM_CONFIG_*` 常量完整枚举缺失 | **修改**：在 3A.1 节新增完整 `GLM_CONFIG_*` 常量清单表格（18 个宏），包含 GLM 宏名、CangJie 等效常量名、首轮推荐值及用途说明。首轮推荐值全部选用最保守设置 |
| 4. 首轮风险评级"低"缺少量化评估依据 | **修改**：① 将分层迁移总览表中首轮风险等级从"低"调整为"中低"；② 新增 4.6 节，列出 6 项风险（R1-R6）——泛型偏特化不支持（中）、`setup.hpp` 平台检测映射待验证（中）、Shim 层需语言专家确认（中）、`std::size_t` 非类型模板参数映射（低-中）、整数溢出语义差异（低）、GLM 源码量 vs CangJie 实现量不可精确对应（低），及各自缓释措施；③ 综合评级为"中低"——存在可管理的技术风险，无不可逾越障碍 |
| 5. 任务一（最基础类型识别）的结论未独立呈现，混入首轮范围结论 | **修改**：在 2.5 节新增独立"最基础类型识别结论"小节，按依赖度降序排列核心类型（含排名表），给出 4 项关键发现，明确说明基础设施 + vec1~vec4 为首轮范围、矩阵和四元数推迟至后续轮次的结论，与第 3 节推荐范围一致 |

---

## 修订说明（v10）

| 审查意见 | 处理方式 |
|---------|---------|
| 问题1（中）：Task 3"范围确认结论"缺乏统一呈现，结论要素分散在三处（3E节文件清单、3D节类型数量、4.4节验证标准） | **修改**：在 3E 节之后新增 3G 节"范围确认结论"，汇总核心文件清单（11 个文件）、类型数量（4 Vec 结构体 + 256 个别名 + 10 标量类型 + bool）、验证标准摘要（6 项核心准则），并明确声明范围满足依赖闭合性和独立可编译性 |
| 问题2（中）：文件清单(3E)依赖列使用C++头文件符号，未与仓颉shim层建立显式关联 | **修改**：将 3E 节文件清单的"直接依赖"列拆分为"C++ 依赖"和"Shim 依赖"两列，为每个 GLM 源文件标注对应的 CangJie shim 层文件名（如 `shim_limits.cj`、`shim_cstddef.cj`、`shim_assert.cj`） |
| 问题3（中）：`compute_vector_relational.hpp`的`<limits>`依赖描述存在语义上的误导风险 | **修改**：统一修正全文对 `compute_vector_relational.hpp` 的 `<limits>` 依赖描述——该文件模板定义中引用 `std::numeric_limits<T>::is_iec559`，`<limits>` 属于标准依赖而非注释说明。涉及 0.7 节 `<limits>` 行、3E 节文件清单第 3 行、1 节层次描述、4.6 节子范围 2a、4.7 节注文、5 节依赖图图注共 6 处 |
| 问题4（低）：二元算术运算符委托模式的性能开销未讨论 | **修改**：在 0.5.1 节委托模式说明之后新增"委托模式性能开销说明"段落，量化单次委托拷贝代价（Vec4<Float32> 约 16 字节栈复制），说明首轮以功能正确性优先，标注此方案为"首轮默认"，并给出后续性能优化路径 |
| 问题5（低）：「最简可行范围」描述缺乏独立文件清单，不可直接对比 | **修改**：在 3E 节"首轮范围性质说明"中将"最简可行范围约含 5 个核心文件"的描述扩展为具体清单表格（6 项条目），列出每个文件的路径、类型说明、与推荐范围的差异，并补充最简范围别名数量计算 |
| 问题6（低）：文档行文冗余，相同依赖关系在 5+ 处重复描述 | **修改**：将核心依赖事实（`compute_vector_relational.hpp` 的 `<limits>` 依赖、`compute_vector_decl.hpp` 的依赖等）统一在 0.7 节和 3E 节文件清单中一次完整陈述，其余位置（1 节层次描述、4.6 节子范围 2a、4.7 节注文、5 节依赖图图注）改为交叉引用（"详见 3E 和 0.7 节"），消除重复描述 |

---

## 修订说明（v11）

| 审查意见 | 处理方式 |
|---------|---------|
| 问题1（严重）：编译期条件包含 `_swizzle.hpp` 替代方案存在事实盲区——"const 配置常量 + if 分支"被表述为首选策略但无法处理条件包含独立文件的场景 | **修改**：在 0.4 节将"无预处理器"行的映射方案表述降级为"有限映射"——明确标注仅适用于函数体内内联条件代码；新增关键限制说明——CangJie 中 `import` 必须是文件顶层声明，宏展开代码不能包含 `import`；明确该方案不适用于条件包含独立文件的场景；将"推荐首轮策略"更新为标注适用范围限制，并给出 swizzle 后续迁移路径指引 |
| 问题2（中）：3D 节"合计可实例化类型 = 256"表述未按 v9 修订计划修正 | **修改**：在 3D 节将"合计可实例化类型 | 256 个具现化类型"替换为"合计类型别名定义数 | 256（16 家族 × 4 分量数 × 4 精度变体）"，并新增"泛型结构体实际实例化数 | ≤44（4 分量数 × 11 基础类型）"行 |
| 问题3（中）：3E → 3G → 3F 章节顺序逻辑颠倒 | **修改**：将 3F 节（命名空间/包映射策略）前移至 3E 节之后、3G 节之前，使读者先了解包映射规则再阅读使用这些规则的汇总结论。当前子章节顺序为：3D → 3E → 3F → 3G |
| 问题4（中）：3E 文件清单第 4 行（`compute_vector_decl.hpp`）Shim 依赖列未对 `<functional>` 适配策略作任何标注 | **修改**：在 3E 节文件清单第 4 行 Shim 依赖列补充`<functional>` → 内联替代，无独立 shim 文件（详见 0.7.2 节）" |
| 问题5（低）：3D 节与 3G 节合计文件数口径不统一 | **修改**：在 3D 节将原"合计核心文件 = 9 个文件"拆分为"核心实现文件（9 个）+ 别名/映射文件（2 个子部分）= 合计 11 个 GLM 源文件"，与 3G 节口径一致 |
| 问题6（低）：3E 文件清单将 `fwd.hpp` 拆为两个条目未注明文件同一性 | **修改**：在 3E 节文件清单注文中新增"`fwd.hpp` 文件同一性说明"段落，注明条目 10 和 11 均对应同一物理文件 `glm/fwd.hpp` 的不同节段，CangJie 中应根据包结构拆分为两个文件 |
