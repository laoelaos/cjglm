# GLM 1.0.3 仓颉迁移首轮 OOD 设计方案（v15 — 审查迭代修订版）

> **版本变更摘要**：v15 基于 v14 迭代，根据 v15 审查反馈（发现1~发现4）进行针对性修复：在 §12.2 验收标准表新增 `componentAt` const 访问正确性验收项（发现1）、在 §11 新增 §11.10 标量在左运算的具名函数替换迁移成本评估（发现2）、在 §3.2 Hashable 实现策略补充泛型类型参数 T 的约束传递性验证并在 §10 新增对应验证依赖（发现3）、在 §2 依赖拓扑澄清和 §8.1 文件清单中标注 `scalar_vec_ops.cj` 对 `std.math.trunc` 的标准库依赖（发现4）。详见末尾修订说明。

---

## 1. 概述

### 范围可追溯性承诺

**范围可追溯性**：本方案全量映射 roadmap §3E/3G 定义的首轮迁移范围。§8 提供范围可追溯性对照表，逐项定位 roadmap 子范围编号对应的设计章节与迁移文件。

### 设计目标

将 GLM 1.0.3 首轮迁移范围内的 C++ 实现（基础设施层 + 向量类型系统 + 类型别名体系）以仓颉语言重新实现，提供一个在仓颉泛型系统和值类型语义下可独立编译运行的向量数学基础库。

### 核心抽象

| 抽象 | 角色 | 类型形态 |
|------|------|---------|
| `Qualifier` | 定义精度/对齐策略的多态契约 | 接口 |
| `PackedHighp` / `PackedMediump` / `PackedLowp` / `AlignedHighp` / 等 | 具体精度/对齐策略标记 | 空结构体（实现 `Qualifier`） |
| `Vec1<T,Q>` / `Vec2<T,Q>` / `Vec3<T,Q>` / `Vec4<T,Q>` | 表示数学向量的值对象 | 泛型结构体 |
| `Functor1` / `Functor2` / `Functor2VecSca` / `Functor2VecInt` | 逐分量标量函数映射工具（按分量数分别定义，为后续轮次预留） | 结构体（各分量数分别定义） |
| `ComputeVecAdd` / `ComputeVecSub` / 等 | 向量逐分量运算策略（为后续 SIMD 轮次预留） | 结构体 |
| `ComputeEqual<T>` | 分量相等比较策略 | 结构体 |
| 标量类型别名 | 仓颉原生整数/浮点类型的 GLM 兼容命名 | `type` 别名 |
| 向量类型别名 | 具现化 Vec 类型的便捷命名 | `type` 别名 |

### 整体架构思路

采用"双层包结构 + 独立具象化别名"的架构：`glm.detail` 包封装全部核心泛型类型定义和运算逻辑，`glm` 包通过类型别名暴露已具现化的常用向量类型。类型系统以 `Qualifier` 接口为精度/对齐策略的多态入口，四个 Vec 结构体作为独立泛型类型（而非分量数参数化的单一模板）承载向量数据与运算。

---

## 2. 模块划分

### 包组织

```
package glm.detail        — 核心实现层
  ├── setup.cj            — 配置常量
  ├── qualifier.cj        — Qualifier 接口及实现类型、前向声明
  ├── shim_assert.cj      — 断言替代
  ├── shim_limits.cj      — numeric_limits 等效
  ├── shim_cstddef.cj     — SizeT/LengthT 类型别名（VArray size 属性提供编译期长度查询）
  ├── compute_vector_relational.cj  — compute_equal
  ├── compute_vector_decl.cj        — compute_vec_add/sub/mul/div 等运算策略结构体（为后续轮次预留）
  ├── scalar_vec_ops.cj             — scalar-op-vec 方向辅助函数（add(s,v)/sub(s,v)/mul(s,v)/div(s,v)/mod(s,v)，首轮即被消费）
  ├── vectorize.cj                  — functor1/functor2/functor2_vec_sca/functor2_vec_int（为后续轮次预留）
  ├── type_vec1.cj                  — Vec1<T,Q> 结构体定义（含二元运算符 + 扩展块）
  ├── type_vec2.cj                  — Vec2<T,Q> 结构体定义（含二元运算符 + 扩展块）
  ├── type_vec3.cj                  — Vec3<T,Q> 结构体定义（含二元运算符 + 扩展块）
  └── type_vec4.cj                  — Vec4<T,Q> 结构体定义（含二元运算符 + 扩展块）

package glm               — 公共 API 面 + 别名层
  ├── lib.cj              — 公共 API 重导出（使用 public import 暴露 Vec/Qualifier 核心类型）
  └── fwd.cj              — 标量类型别名 + 向量类型别名
```

### 公共 API 面设计

`lib.cj`（`package glm`）通过 `public import` 将 `glm.detail` 中的核心类型和 `glm.fwd` 中的类型别名重新导出，下游消费者只需 `import glm.*` 即可使用所有公共 API 和类型别名，无需直接依赖 `glm.detail` 内部包或单独导入 `fwd.cj`。具体导出内容：

```
package glm
public import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }
public import glm.detail.{ Qualifier, PackedHighp, PackedMediump, PackedLowp }
public import glm.detail.{ Defaultp }
public import glm.detail.{ add, sub, mul, div, mod }
public import glm.fwd.*
// 后续轮次新增的矩阵/四元数类型在对应轮次追加至此文件
```

此设计确保：
- `package glm.detail` 中的内部实现类型（如 shim 文件、functor、compute_vector_decl 等）对下游不可见
- 下游消费者仅通过 `import glm.Vec2` 等获得类型，包路径中不含 `detail`
- `public import glm.fwd.*` 将 fwd.cj 中的 256 个别名一并暴露，使用者无需单独导入 fwd.cj。注：`scalar_vec_ops.cj` 声明了 `package glm.detail`，因此其中的函数通过 `glm.detail.{ add, sub, mul, div, mod }` 导入，路径中不包含文件名 `scalar_vec_ops`
- **命名空间占用声明**：`glm.detail` 包中约定**仅 `scalar_vec_ops.cj`** 定义名为 `add`、`sub`、`mul`、`div`、`mod` 的包级函数。`glm.detail` 包中的其他文件（如 `compute_vector_decl.cj`、`type_vecN.cj` 等）不得定义同名包级函数，以避免 `public import glm.detail.{ add, sub, mul, div, mod }` 产生导入歧义。此约定在 §7 D35 中正式记录为设计决策。
- 后续轮次扩展公共 API 面时只需在 `lib.cj` 追加对应的 `public import` 行

### 模块间依赖

```
glm.detail（内部无包引用，同包直接可见）
  setup 无依赖
  qualifier → setup
  shim_* 无依赖（仅使用仓颉原生类型）
  compute_vector_relational → shim_limits
  vectorize → qualifier（使用 LengthT / Qualifier 接口约束）
  compute_vector_decl → vectorize + qualifier
  scalar_vec_ops → qualifier（函数签名引用 Vec 类型，同包内由 Cangjie 包级编译模型自动包含，不构成独立编译依赖）
  type_vecN → qualifier + compute_vector_relational + scalar_vec_ops（按需）

glm
  lib.cj → glm.detail.{Vec1,Vec2,Vec3,Vec4,Qualifier 实现类型,scalar_vec_ops}
  fwd.cj → glm.detail.{Vec1,Vec2,Vec3,Vec4,Qualifier 实现类型}
```

`glm` 包单向依赖 `glm.detail`，反向无依赖。

### 项目初始化与构建基础设施

**前提准备**（编码启动前必须完成）：

1. **项目初始化**：使用 `cjpm init --type=static` 创建仓颉静态库项目，生成 `cjpm.toml` 骨架。
2. **最小 cjpm.toml 配置**：
   ```toml
   [package]
     cjc-version = "1.0.5"
     name = "glm"
     version = "0.1.0"
     output-type = "static"
     src-dir = "src"
   ```
3. **初始目录结构**：
   ```
    glm-cangjie/
    ├── cjpm.toml
    ├── src/
    │   └── glm/
    │       ├── lib.cj
    │       ├── fwd.cj
    │       └── detail/
    │           ├── setup.cj
    │           ├── qualifier.cj
    │           ├── shim_assert.cj
    │           ├── shim_limits.cj
    │           ├── shim_cstddef.cj
    │           ├── compute_vector_relational.cj
    │           ├── compute_vector_decl.cj
    │           ├── scalar_vec_ops.cj
    │           ├── vectorize.cj
    │           ├── type_vec1.cj
    │           ├── type_vec2.cj
    │           ├── type_vec3.cj
    │           └── type_vec4.cj
   ├── tests/
   │   └── glm/
   │       ├── test_lib.cj
   │       ├── test_fwd.cj
   │       └── detail/
   │           └── (测试文件，与 src 结构对应)
   └── target/               # 自动生成
   ```
4. **初始编译验证**：在项目根目录执行 `cjpm build` 确认基础编译链路正常。
5. **测试运行器配置**：执行 `cjpm test` 运行 `@Test` 标注的单元测试。测试文件可置于 `src/` 目录下（以 `_test.cj` 后缀命名）或独立的 `tests/` 目录中，`cjpm test` 自动发现并执行。
6. **首次编码前原型验证**：在开始正式编码前，按 §10 的设计阶段验证要求编写原型测试，确认编译器对 `const` 表达式链、`T(0)` const 构造、`is` 运算符在 const 泛型中的可用性、`@OverflowWrapping` 标注继承性等关键假设的支持程度。

### 依赖拓扑澄清

`setup.cj` 不包含 `LengthT`/`SizeT` 类型别名定义，这些归入 `shim_cstddef.cj`。`setup.cj` 仅包含 `const` 配置常量。`shim_cstddef.cj` 无任何依赖，所有 shim 文件与 `setup.cj` 之间不存在相互依赖。

首轮中 `compute_vector_decl.cj` 和 `vectorize.cj` 中的 `compute_vec_*` 策略结构体（如 `compute_vec_add`、`compute_vec_sub` 等）定义类型但不被 Vec 运算符实现消费，为后续轮次预留。`scalar-op-vec` 方向辅助函数（如 `add(s, v)`、`sub(s, v)` 等）已从 `compute_vector_decl.cj` 中独立为 `scalar_vec_ops.cj` 文件——它们属于首轮即被消费的例外，Vec 使用者需在 `scalar + vec` 等场景中调用它们。

**标准库依赖声明**：`scalar_vec_ops.cj` 的浮点取模路径（`mod(s, v)` 中 `T` 为浮点类型时）依赖 `std.math.trunc`（`Float64` 版本），通过 `Float32` 提升至 `Float64` 后调用 `trunc` 实现。编码阶段须在 `scalar_vec_ops.cj` 文件头部添加 `import std.math.{ trunc }`。此标准库依赖已在 §10 浮点 `mod` 验证依赖②中覆盖，§8.1 文件清单的"说明"列同步标注。

### §2.1 编码前验证检查清单

以下清单集中列出所有必须在编码前完成的设计阶段验证任务，确保编译器对关键语言特性的支持符合设计假设。每项验证通过后方可进入正式编码。

| 验证任务 | 章节位置 | 验证方法 | 通过标准 | 失败回退 |
|---------|---------|---------|---------|---------|
| ① 首次编码前原型验证 | §2 步骤 6 | 编写原型测试验证 `const` 表达式链、`T(0)` const 构造、`is` 在 const 泛型中的可用性、`@OverflowWrapping` 继承性 | 所有原型测试编译通过 | 根据失败项调整设计（详见对应章节的回退方案） |
| ② 参考实现前置验证 | §8.4 策略 0 | 确认参考实现目录结构完整，验证 `GLM_CONFIG_CLIP_CONTROL` 条件编译逻辑、`storage` 非 SIMD 路径、`type_vecN.inl` 构造函数宏展开 | 三项验证项均与设计描述一致 | 以参考实现为准更新设计文档 |
| ③ `isIec559Of` 核心依赖验证 | §10 依赖①②③ | 编写 `const` 泛型函数测试 `T(0)` const 构造 + `is` 运算符 + `abs()`/`epsilon()` const 兼容性 | 对 `Int32`/`Float32`/`Bool` 均编译通过 | 依赖①②失败 → 整体回退精确比较；依赖③单独失败 → 移除容差路径 |
| ④ 编译期 `if` 分支抑制验证 | §10 依赖点 A~E | 编写 `testConstIfSuppression<T>()` 统一原型测试，以 `Float32`/`Int32`/`Bool` 分别实例化 | 三项均编译通过 | 各依赖点按独立回退方案处理（详见 §10 回退表） |
| ⑤ `@OverflowWrapping` 继承性验证 | §7 D30 | 编写原型测试验证二元运算符标注 `@OverflowWrapping` 后，编译器自动生成的复合赋值版本是否继承 wrapping 语义 | 复合赋值在溢出时执行 wrapping | 切换到备选方案：在已有 20 个扩展成员函数上补充标注 |
| ⑥ 浮点 `mod` 边界值验证 | §10 mod 验证 | 编写原型测试覆盖 `Float32.Max % 1.0`、负操作数、`Inf`/`NaN` 等边界值 | 所有边界值行为与 C++ `std::fmod` 一致 | 拆分为 `modInt`/`modFloat` 非 `const` 具名函数 |
| ⑦ Vec1 跨类型 fill-from-Vec1 重载冲突验证 | §4.1/D31 | 原型测试验证 `Vec2( Vec1<Int32,PackedHighp> )` 编译无歧义 | 编译通过 | 移除跨类型 fill-from-Vec1 构造 |

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

**Aligned 系列的可见性策略**：
- **首轮可见性**：AlignedHighp/AlignedMediump/AlignedLowp 在 `qualifier.cj` 中声明为 **`internal`**（包级可见）。理由：首轮 `GLM_CONFIG_ALIGNED_GENTYPES = false`，对齐类型在 Vec 内部不被使用，无需对外暴露。下游消费者通过 `Packed` 系列和 `Defaultp` 即可满足所有使用场景。
- **后续轮次切换配置时的可见性变更**：当未来将 `GLM_CONFIG_ALIGNED_GENTYPES` 切换为 `true` 时：
  1. 将 AlignedHighp/AlignedMediump/AlignedLowp 的可见性从 `internal` 改为 `public`。
  2. 在 `lib.cj` 的 `public import` 列表新增对应的 Aligned 类型导出行。
  3. 评估是否需要为 Aligned 类型补充独立的行为约定文档（当前 Aligned 与 Packed 行为等价，切换配置后可能引入对齐差异）。
- **`lib.cj` 导出策略**：`lib.cj` 的当前 `public import` 列表仅导出 `PackedHighp`/`PackedMediump`/`PackedLowp` 和 `Defaultp`。Aligned 系列的导出交由后续轮次完成。

Vec 泛型结构体通过 `where Q <: Qualifier` 约束 Q 参数，确保精度标记的类型安全性。预定义的 `lowp_`/`mediump_`/`highp_` 别名等价于分别绑定不同的 Qualifier 实现类型。

**C++ `storage<L,T,Q>` 模板结构体说明**：GLM 的 `qualifier.hpp` 中定义了 `storage` 模板（`namespace detail`），用于根据 `L`（分量数）、`T`（分量类型）和 `is_aligned` 标志选择底层数据存储类型——在非 SIMD 路径下为 `T data[L]`，在 SIMD 路径下为 SIMD 内部类型（如 `glm_f32vec4`）。仓颉 Vec 结构体直接声明具名数据成员（`var x: T` 等），不依赖 C 数组或 SIMD 内部类型，因此 `storage` 抽象在首轮中**无需也不可映射**。Vec 的数据布局由编译器根据 struct 成员定义自动确定，与 `storage` 在 C++ 中角色等效。`storage` 的 SIMD 特化（SSE2/AVX/NEON 路径）待后续 SIMD 轮次重新设计。

**选择理由**：采用接口而非 sealed 枚举+匹配（enum），是因为泛型参数需要类型级区分以支持不同 Vec 实例的编译期类型区分，而非运行时分支分发。空结构体的零开销值与接口的泛型约束能力结合，是仓颉泛型系统下最直接的映射方案。

**Qualifier 运行时行为约定**：
- **跨 Q 赋值/转换规则（首轮）**：不同 Qualifier 之间**可相互赋值和转换**。由于首轮所有 Qualifier 实现类型（PackedHighp、PackedMediump、PackedLowp、AlignedHighp 等）均为空结构体，无运行时数据差异，跨 Q 赋值在数据语义上等价于同 Q 赋值。因此 Vec 的跨类型转换构造函数（`init<T2, Q2>(v: VecN<T2, Q2>) where Q2 <: Qualifier`）已在类型层面允许 Q2→Q 的转换——Q 参数仅影响编译期类型签名，不影响数据表示。首轮编码阶段无需对跨 Q 转换添加额外的静态断言或运行时检查。
- **跨 Q 赋值/转换规则（后续轮次）**：当后续轮次为不同 Qualifier 引入差异化行为（如 aligned 类型使用不同内存对齐策略、SIMD 变体使用不同内部数据布局）时，跨 Q 赋值的语义需要重新评估。届时可按需引入编译期静态检查（如通过仓颉宏或自定义注解）限制特定 Q 组合间的转换。此评估留待对应轮次的设计审议中处理。
- **Qualifier 差异引入路径的预期说明**：当前首轮设计将 Qualifier 定义为实现统一空接口的独立空结构体，它们在类型层面是不同的泛型参数但行为完全等价。后续轮次可通过以下路径逐步引入差异化：
  1. **对齐策略差异化**（第 2 轮）：`AlignedHighp` 等对齐类型可关联自定义对齐元数据（如通过仓颉 `@Align` 注解或包装结构体），在 `GLM_CONFIG_ALIGNED_GENTYPES = true` 时生效。
  2. **SIMD 路径差异化**（第 5+ 轮）：`PackedHighp` 可关联 SIMD 内部数据布局（如通过条件编译选择 `Vector128<T>` 等 SIMD 类型），在 `GLM_CONFIG_SIMD = true` 时生效。
  3. **精度语义差异化**（后续轮次）：`PackedLowp`/`PackedMediump` 可在函数库层面（如三角函数、标准化运算）通过 `if (isLowp<Q>())` 分支选择精度折衷算法路径。
  上述差异化路径均在当前接口+空结构体框架下兼容，无需改变类型形态。

### 3.2 Vec 结构体系

**角色**：表示 N 维数学向量，是 GLM 中最核心的领域实体。每个 Vec 是值类型（struct），支持构造、分量访问、算术运算、比较运算和位运算。

四个 Vec 类型（`Vec1<T,Q>`、`Vec2<T,Q>`、`Vec3<T,Q>`、`Vec4<T,Q>`）各自独立定义，而非使用分量数参数化的单一泛型模板。每个 Vec 有自己的：

- **数据成员**：声明为 `var`（可变，无初始值），命名约定如下：
  - `Vec1<T,Q>`：`var x: T`
  - `Vec2<T,Q>`：`var x: T, var y: T`
  - `Vec3<T,Q>`：`var x: T, var y: T, var z: T`
  - `Vec4<T,Q>`：`var x: T, var y: T, var z: T, var w: T`

  数据成员使用 `var` 而非 `let`。成员无初始值——仓颉 struct 允许 `var x: T` 形式。因此编译器不会为 Vec 结构体自动生成无参默认构造函数。所有 Vec 实例必须通过显式构造函数创建。（具体构造方式见 §4.1。）

- **`const public static func length(): Int64`** — 返回编译期常量：Vec1 返回 1，Vec2 返回 2，Vec3 返回 3，Vec4 返回 4。此函数是计算分量数的静态接口，替代 C++ `length_t` 参数在泛型运算中的角色。

- **`const init` 构造函数**：每个 Vec 定义一个 `const init(x: T, y: T, ...)` 构造函数，允许 `const` 实例成员函数（定义在 struct 体内部）的定义，同时其本身在非 const 上下文中也可用于运行时构造（const README §3.2 规则 5），因此不再需要同参数列表的普通 `init`。`const init` 的存在使得 `==` 等比较运算符可以声明为 `const` 函数，从而在函数体内使用 `const if` 实现编译期分支选择。「注意」仓颉 `extend` 块中不允许 `const` 修饰符，因此扩展成员函数（位运算符、具名函数 `increment`/`decrement`/`bitwiseNot`/`equalExact`/`logicalAnd`/`logicalOr` 等）须以非 `const` 形式定义。`const if` 编译期分支在非 `const` 函数中不可用，相关备选方案见 §7 修订。

- **类型参数显式指定**：仓颉泛型系统不支持类型参数默认值，Q 参数必须显式指定。`Vec2<Float32, PackedHighp>` 为完整合法写法。对于需要省略 Q 参数的场景，在 `fwd.cj` 中通过 `type` 别名提供常用具现化（如 `type Vec2f = Vec2<Float32, PackedHighp>`）。如需在泛型代码中编写 `Vec2<T>` 形式，可将不同精度包装为不同别名。

- **构造函数体系**（见 §4.1 完整清单）。
- **下标运算符 `[]`** 用于分量访问。有取值和赋值两种形式（见 §4.2）。
- **二元算术运算符**在 Vec 结构体内部定义（或通过 extend 块扩展），标注 `@OverflowWrapping`，直接实现逐分量运算。复合赋值运算符由编译器自动生成（仓颉在重载二元算术运算符且返回类型与左操作数类型匹配时自动生成对应的复合赋值版本）。
- **位运算符** — 二元位运算符（`&`、`|`、`^`、`<<`、`>>`）在 extend 块中定义。`~`（按位取反）不在仓颉可重载运算符列表中，改为提供具名函数 `bitwiseNot()`。
- **比较运算符** — `==` 通过 `ComputeEqual` 策略比较，声明为 `const` 函数以支持 `const if` 编译期分支。`!=` 定义为 `!(a == b)`。`<`/`<=`/`>`/`>=` 运算符的覆盖见 §4.5。
- **布尔逻辑运算**：`&&` 和 `||` 不在仓颉可重载运算符列表内，不可实现为运算符。改为提供具名函数 `logicalAnd()` 和 `logicalOr()`。各 VecN 类型分别定义对应版本，接收 `VecN<Bool, Q>` 并返回 `VecN<Bool, Q>`。
- **`%` 运算符**：在 Vec 结构体内部或 extend 块中定义，直接实现逐分量取模。当 `T` 为整数类型时编译通过；当 `T` 为浮点类型时，因仓颉原生浮点类型不支持 `%`，在实例化时产生编译错误。此行为与 D5（宽松泛型约束，延迟检查）一致。
- **`++`/`--` 运算符**：仓颉可重载运算符列表中不包含 `++`/`--`，因此无法为 Vec 类型重载。改为提供具名函数 `increment()`（返回逐分量加 1 的新向量）和 `decrement()`（返回逐分量减 1 的新向量）。这些函数标注 `@OverflowWrapping`，语义与 C++ GLM 的 `operator++`/`operator--` 返回新副本的行为一致（C++ 前缀形式返回引用，后缀返回副本；仓颉值类型统一返回副本）。注：`increment`/`decrement` 定义在 `extend` 块中，受仓颉扩展语法限制（仓颉扩展 §4.2），声明为非 `const` 函数。C++ 的后缀 `v++` 在迁移时需替换为 `v = v.increment()`，前缀 `++v` 替换为 `v = v.increment()` 后重新赋值。

**`VecN<Bool, Q>` 完整行为约定**（集中说明）：
- Bool 分量 Vec 支持构造、下标访问、`==`/`!=` 比较（返回 `bool`）、`!` 一元运算符（逐分量逻辑非）、`logicalAnd`/`logicalOr` 具名函数。
- 算术运算符（`+`/`-`/`*`/`/`/`%`）在 `VecN<Bool, Q>` 上实例化时报编译错误（`Bool` 不支持算术运算），与 D5 延迟检查语义一致。
- 位运算符（`&`/`|`/`^`）在 `VecN<Bool, Q>` 上可编译通过——仓颉 `Bool` 支持 `&`/`|`/`^`，语义为逐分量逻辑运算，与 C++ GLM 的 `bvec` 位运算行为等价。
- `<<`/`>>` 在 `VecN<Bool, Q>` 上实例化时报编译错误（`Bool` 不支持移位）。
- `increment()`/`decrement()` 在 `VecN<Bool, Q>` 上实例化时报编译错误。
- `bitwiseNot()` 在 `VecN<Bool, Q>` 上可编译通过——`!` 对 `Bool` 执行逻辑非。**不可消除的已知行为差异**：C++ GLM 的 `~bvec` 因整数提升机制（`bool` → `int` 按位取反 → `bool` 转换，非零即 `true`）对任一分量始终返回 `true`；而仓颉 `!Bool` 执行逻辑否定（`!true = false`），两种行为完全相反。此差异无法通过类型系统消除——仓颉不支持偏特化或负向约束条件性地为 `VecN<Bool, Q>` 排除 `bitwiseNot()`。迁移 `~bvec` 时需要人工审查并按上下文选择替换方式（详见 §11.4）。

**Hashable 实现策略**：
- 所有 Vec 类型统一通过 `@Derive[Hashable]` 自动派生 `hashCode(): Int64`。仓颉 `@Derive` 宏为所有字段类型已实现 `Hashable` 的实例化生成 `hashCode()`——此条件对所有数值类型（`Int32`、`Float32`、`Float64` 等）和 `Bool` 均满足。
- **泛型类型参数 T 的 `Hashable` 约束传递性**：`@Derive[Hashable]` 在泛型 struct `VecN<T, Q>` 上使用时，仓颉编译器要求所有实例化路径中 `T` 必须实现 `Hashable` 接口。对于 `T = Int32`/`Float32`/`Bool` 等已实现 `Hashable` 的类型，此条件自动满足；对于尚未实现 `Hashable` 的类型（如 `Float16` 若在后续轮次中引入），实例化将产生编译错误。此行为属于编译期约束检查，与默认构造函数是否存在无关。当前首轮范围中所有目标类型（`Int8`~`Int64`、`UInt8`~`UInt64`、`Float32`/`Float64`、`Bool`）均已实现 `Hashable`，因此对 `T` 的约束传递性验证在首轮无运行时风险，编码阶段仅需确认编译器对已实现 `Hashable` 的类型能正确生成 `hashCode()`（见 §10 验证依赖）。
- `hashCode()` 覆盖 Vec 的所有数据分量（Vec1 覆盖 x，Vec2 覆盖 x/y，Vec3 覆盖 x/y/z，Vec4 覆盖 x/y/z/w）。
- **浮点 Vec 的已知限制**：`Hashable` 契约要求 `hashCode()` 与 `==` 一致（`a == b ⇒ hashCode(a) == hashCode(b)`）。浮点 Vec 的 `==` 使用容差比较，而 `@Derive` 生成的 `hashCode()` 使用按位精确哈希——两个在容差范围内相等但按位不同的浮点向量可能产生不同的哈希值。此不一致是已知限制，需在文档中标注。在哈希集合/映射中使用浮点 Vec 时，若键值必须保证一致性，调用方应确保键值精确匹配或自行包装为自定义类型。

**字符串表示策略**：
- Vec 类型不实现自定义 `toString()` 或 `Format`/`Display`。首轮依赖仓颉编译器为 struct 生成的默认字符串表示——格式和内容由编译器确定，调用方不应依赖特定格式。
- 若下游需要格式化输出，可通过独立具名函数（如 `to_string(v: VecN<T, Q>): String`）在后续函数库轮次中提供。

**类型形态选择理由**：
- 使用 **struct** 而非 class：向量是纯值语义类型，按值传递/赋值应复制而非共享引用。Struct 的值语义与 C++ vec 的行为一致。
- 四个**独立结构体**而非单模板特化：仓颉不支持 C++ 偏特化，无法通过 `Vec<N, T, Q>` 单模板的分量数偏特化实现各分量数版本的差异化行为。四个独立类型虽然代码重复但实现模式简单直接。
- 数据成员声明为 `var` 且无初始值：`var` 使 `mut` 函数（在 `var` 绑定的变量上）可修改成员；无初始值意味着编译器不生成默认构造函数，调用方须显式构造。
- **二元算术运算符在 Vec 结构体内部定义为 `operator func`（非 `mut`），标注 `@OverflowWrapping`；复合赋值由编译器自动生成**。此策略替代了 v3 中"copy + op="委托模式——因复合赋值运算符（`+=` 等）不在仓颉可重载运算符列表中，无法显式定义。编译器在检测到返回类型匹配的二元运算符后自动生成复合赋值版本，`@OverflowWrapping` 标注在二元运算符上，复合赋值继承其 wrapping 语义。
- `scalar + vec`（标量在左、向量在右）不可作为运算符重载实现，因为左操作数 `scalar` 类型（如 `Float32`）的 `+` 运算符无法被本包扩展。替代方案是提供具名函数。`scalar / vec` 同理。
- `const init` 的引入：为支持 `const` 实例成员函数（如 `const` 版本的 `==` 运算符），需定义一个 `const init` 构造函数。仓颉要求：对于 struct，只有定义了 `const init` 才能定义 `const` 实例成员函数。`const init` 内可使用 `=` 赋值初始化 `var` 成员。数据成员声明为 `var` 与 `const init` 不冲突——`const init` 初始化成员，`const` 实例函数（如 `==`）非 `mut`，可正常访问 `var` 成员。`const init` 在非 const 上下文中同样可用于运行时构造（const README §3.2 规则 5），因此同参数列表的普通 `init` 不再需要——移除后仅保留 `const init` 可避免仓颉函数重载规则中因 `const` 修饰符不构成区分依据而导致的重复定义编译错误。
- **Q 参数显式指定**：仓颉泛型系统不支持类型参数默认值，Q 必须显式指定。使用 `type` 别名（如 `type Vec2f = Vec2<Float32, PackedHighp>`）提供常用具现化的简写形式，在 `glm` 包中通过别名隐藏 Q 参数细节。

### 3.3 Functor 体系

**角色**：封装"对标量函数逐分量映射到向量"的调用模式，是后续轮次 SIMD 优化或 swizzle 操作的基础设施。首轮 Functor 定义其类型但不被 Vec 运算符实现调用，为后续轮次预留。

C++ `_vectorize.hpp` 中的四个 functor 模板（`functor1`、`functor2`、`functor2_vec_sca`、`functor2_vec_int`）使用了模板模板参数。由于仓颉中 Vec1~Vec4 是四个独立结构体而非同一模板的特化，模板模板参数模式无法复用。

首轮按分量数拆分 functor——为 Vec1~Vec4 各定义四组独立的 functor 结构体：

- **`Functor1Vec1<R, T, Q>`** ~ **`Functor1Vec4<R, T, Q>`** — 一元映射（`Func(T) -> R`）
- **`Functor2Vec1<T, Q>`** ~ **`Functor2Vec4<T, Q>`** — 二元映射（`Func(T, T) -> T`）
- **`Functor2VecScaVec1<T, Q>`** ~ **`Functor2VecScaVec4<T, Q>`** — 向量-标量二元映射
- **`Functor2VecIntVec1<T, Q>`** ~ **`Functor2VecIntVec4<T, Q>`** — 向量-整数向量二元映射

每个 functor 提供一个静态 `call` 方法，接收一个仿函数/函数引用和向量操作数，返回向量结果。首轮这些类型仅定义为结构体，不产生消费代码。后续轮次可对 Vec 运算符实现进行优化，通过宏生成这些重复定义。

### 3.4 ComputeVec* 运算策略体系

**角色**：封装向量逐分量运算的具体实现，为后续轮次 SIMD 路径或特化提供扩展点。首轮 ComputeVec* 定义其类型但不被 Vec 运算符实现调用。

`compute_vector_decl.hpp` 中定义的 `compute_vec_add`、`compute_vec_sub`、`compute_vec_mul`、`compute_vec_div`、`compute_vec_mod`、`compute_vec_and`、`compute_vec_or`、`compute_vec_xor`、`compute_vec_shift_left`、`compute_vec_shift_right`、`compute_vec_equal`、`compute_vec_nequal`、`compute_vec_bitwise_not` 等结构体，在 C++ 中通过偏特化的参数进行 SIMD/非 SIMD 和整数/非整数的分支。

首轮设计简化策略：

- **所有 `UseSimd` 参数取 `false`**：`GLM_CONFIG_SIMD = false`，无 SIMD 路径。
- **整数/浮点运算直接在 Vec 运算符中通过泛型 `+`/`-`/`*`/`/` 等原生运算处理**，无需通过 ComputeVec* 委托。
- **相等比较通过 `ComputeEqual<T>` 策略处理**：简化后的 `ComputeEqual` 不再携带 `IsFloat` 参数，使用编译期 `if` 分支（详见 §3.5）。

首轮 ComputeVec* 结构体定义为无状态结构体（仅提供静态 `call` 方法），按分量数分别定义 Vec1~Vec4 版本。首轮这些类型仅定义但不被 Vec 运算符实现调用，为后续 SIMD 轮次预留。

### 3.5 ComputeEqual

**角色**：提供分量级别的相等比较策略，向量的 `==` 运算符委托此类型做逐分量比较。简化后的 `ComputeEqual<T>` 不再携带 `IsFloat` 参数。

`ComputeEqual<T>` 的 `isIec559` 判定依赖编译期 `if` 配合 `is` 运算符完成。`isIec559Of<T>()` 对所有 `T`（含 `Bool`）可用，非数值类型默认返回 `false`。

```
struct ComputeEqual<T> {
    static func call(a: T, b: T): Bool { a == b }
    // const 版本：通过 const if 实现编译期分支
    const static func callConst(a: T, b: T): Bool {
        if (isIec559Of<T>()) {
            // 浮点路径：使用 Epsilon 容差比较
            abs(a - b) <= epsilonOf<T>()
        } else {
            // 整数/Bool 路径：精确比较
            a == b
        }
    }
}
```

**`epsilonOf<T>()` 定义**：`ComputeEqual.callConst` 中引用的 `epsilonOf<T>()` 是定义于 `shim_limits.cj` 的 `const` 泛型函数。其签名为 `const func epsilonOf<T>(): T where T <: Number<T>`，内部实现委托给 `NumericLimits<T>.epsilon()` ——`Number<T>` 约束在此处合法，因为 `if (isIec559Of<T>())` 分支仅在浮点 `T` 上进入，而浮点类型（`Float32`/`Float64`）满足 `Number<T>` 约束。定义形式如下：

```
const func epsilonOf<T>(): T where T <: Number<T> {
    NumericLimits<T>.epsilon()
}
```

**`where T <: Number<T>` 约束兼容性验证**：`epsilonOf<T>()` 的 `Number<T>` 约束在非执行路径（`const if` 的 `else` 分支）上的编译器行为需要验证——虽然 `const if` 编译期分支确保仅浮点 `T` 进入容差比较路径，但编译器可能仍会对 `else` 分支（整数/Bool `T`）进行语法检查，检查 `epsilonOf<T>()` 的实例化是否满足 `Number<T>` 约束。若编译器在非执行路径上仍对泛型约束进行全面检查（而非延迟到实际调用点），则 `epsilonOf<Bool>()` 等实例化可能产生编译错误（`Bool` 不实现 `Number<T>`）。**兼容性策略**：若编码阶段验证发现非执行路径的编译器行为导致约束冲突，采用以下唯一策略：
- 移除 `epsilonOf<T>()` 的 `where T <: Number<T>` 约束，将 epsilon 逻辑内联到 `ComputeEqual.callConst` 的浮点分支中。内联形式为 `if (isIec559Of<T>()) { abs(a - b) <= T(1e-6) } else { a == b }`，使用固定容差值 `T(1e-6)` 替代 `NumericLimits<T>.epsilon()`。

`IsFloat` 参数不再需要——`if (isIec559Of<T>())` 在编译期直接查询 `T` 是否为 IEEE 754 浮点类型，零运行时开销地选择比较路径。`ComputeEqual` 的类型参数简化为单一 `T`。

**编译期判定路径**：
1. Vec 结构体定义 `const init` 构造函数。
2. Vec 的 `==` 运算符声明为 `const` 函数。
3. `const` 函数体内通过 `if (isIec559Of<T>())` 在编译期选择比较路径——浮点类型使用容差比较，整数/Bool 类型使用 `==` 直接比较。
4. `isIec559Of<T>()` 由 `shim_limits.cj` 提供。实现策略：在 `const` 函数体内使用 `is` 运算符对类型实例进行编译期类型检测——创建 `T` 类型的临时值并通过 `is` 判断其是否为 `Float32` 或 `Float64`。该模式在仓颉 `const` 函数上下文中可行，因为 `is` 属于可参与 `const` 表达式的运算符，且 `T(0)` 作为数值/布尔类型的 const 构造是合法的（数值类型构造函数、`Bool(0)` 均在 const 表达式中可用）。

**实现方案**：
```cangjie
const func isIec559Of<T>(): Bool {
    if (T(0) is Float64 || T(0) is Float32) { true } else { false }
}
```
此方案不依赖函数重载或模板特化——通过 `is` 运算符在编译期直接检测类型身份，完全符合仓颉泛型函数的重载规则（单一泛型函数，无非泛型部分的差异）。`T(0) is Float64` 中，`T(0)` 是合法的 const 表达式（数值/布尔类型的构造函数在 const 上下文中可用），`is` 是合法的 const 表达式运算符。

**备选路径**（若 `const init` 或 `const if` 在特定上下文不可用）：所有类型使用精确比较（`a == b`）。此路径不损失正确性——浮点数直接比较在大多数使用场景下足够。浮点容差比较通过独立的具名函数（如 `equalEpsilon`）提供给需要容差比较的场景。**回退路径一致性**：此备选路径与 §7 D29 定义的二值决策中的"回退路径"一致——若 `const` 表达式链验证失败，`==` 整体回退到精确比较路径，浮点容差比较由非 `const` 具名函数提供。

**`const operator ==` 表达式链兼容性**：`abs(a - b) <= epsilonOf<T>()` 表达式链中各环节（减法、`abs()`、`epsilonOf<T>()`、`<=` 比较）的 const 兼容性要求及验证状态详见 §7 D29。编码阶段需逐一验证后方可确认完整 const 路径的可行性。

### 3.6 Shim 层

**角色**：替代 GLM 所依赖的 C++ 标准库设施（`<cassert>`、`<cstddef>`、`<limits>`），是首轮范围的编译前提。

- **`shim_assert.cj`**：提供 `assert(condition: Bool, message?: String)` 函数，行为等价于 `if (!condition) { throw ... }`。这替代了 `setup.hpp` 中的 `assert()` 宏及其变体 `GLM_ASSERT_LENGTH`。首轮 Debug 模式下 `assert` 触发异常，Release 模式不做断言消除（两种模式均保留断言）。后续轮次可通过 `const` 配置 + `const if` 在 Release 模式下跳过断言检查。

- **`shim_limits.cj`**：提供数值极限查询功能。为避免 `NumericLimits<T>` 上的 `where T <: Number<T>` 约束与 D5（宽松泛型约束，允许 `Bool` 作为 `T`）冲突，将 `NumericLimits` 拆分为两个独立部分：
  - **`NumericLimits<T>` 结构体**（保留 `where T <: Number<T>` 约束）：提供 `static max(): T`、`static min(): T`、`static epsilon(): T` 等需要数值运算的支持接口。此结构体仅在需要数值极限的场景中使用（如 `ComputeEqual` 的浮点容差 `epsilon` 路径）。
  - **`isIec559Of<T>()` 函数**（无约束，`const` 函数）：提供编译期 `Bool` 常量，判断 `T` 是否为 IEEE 754 浮点类型。对任意 `T`（含 `Bool`）可用，非浮点类型默认返回 `false`。此函数由 `ComputeEqual.callConst` 中的 `const if` 分支使用，无 `Number<T>` 约束要求。

  `isIec559Of<T>()` 的实现策略：在 `shim_limits.cj` 中定义一个 `const` 泛型函数，函数体内使用编译期 `if` 配合 `is` 运算符检测类型：
  ```cangjie
  const func isIec559Of<T>(): Bool {
      if (T(0) is Float64 || T(0) is Float32) { true } else { false }
  }
  ```
  `T(0) is Float64` 在编译期求值——当 `T` 被实例化为具体类型后，`T(0)` 的值类型在编译期已完全确定，`is` 运算符可静态判定。此方案不依赖函数重载或模板特化，符合仓颉泛型系统的约束规则（类型变量约束不参与重载解析，但此处不涉及重载）。

- **`shim_cstddef.cj`**：定义 `type SizeT = UInt64`（无符号语义场景）和 `type LengthT = Int64`（索引/长度场景）两个类型别名，明确区分有符号/无符号使用场景，替代 C++ `size_t`/`ptrdiff_t`。VArray 的 `size` 属性提供编译期长度查询，等效于 C++ 中基于 `sizeof` 的数组元素计数宏。不单独定义 `countof` 函数——`VArray<T, $N>` 的 `$N` 必须是固定数值字面量，不可声明为值泛型参数。
- **`LengthT` 的使用边界**：`LengthT` 是通用长度/索引类型别名，**供下游消费者使用**——即需要以 `Int64` 类型表示向量维度或索引的通用代码场景。Vec 类型内部保持直接使用 `Int64` 作为 `length()` 返回类型和 `operator[]` 索引类型。理由：① Vec Vec1~Vec4 的 `length()` 返回值为编译期常量（1/2/3/4），`Int64` 字面量直接编码更清晰；② `operator[]` 的索引范围固定为 0~3，使用 `Int64` 无需类型别名间接引用；③ `LengthT` 的使用价值体现在下游泛型代码中——如编写一个接收任意 Vec 类型并输出其长度的函数时，可使用 `LengthT` 统一表示返回值类型。

### 3.7 标量类型别名

**角色**：在 `package glm` 中为仓颉原生数值类型提供与 GLM 兼容的命名体系。

映射规则：仓颉的 `Int8`/`Int16`/`Int32`/`Int64`/`UInt8`/`UInt16`/`UInt32`/`UInt64`/`Float32`/`Float64` 分别映射为 GLM 的 `int8`~`uint64`/`float`/`double`。此外为各类型提供 `lowp_`/`mediump_`/`highp_` 精度变体别名。

补充 `uint` 别名：`type uint = UInt32`，对应 C++ GLM 中的 `typedef unsigned int uint;`。

由于仓颉原生数值类型名称已足够简洁（如 `Int32` 比 `i32` 更清晰且是语言关键字），标量别名在 `package glm` 中定义以供需要 GLM 命名风格的代码使用，但 `package glm.detail` 内部直接使用仓颉原生类型名。

### 3.8 向量类型别名

**角色**：在 `package glm` 中为 Vec1~Vec4 的常用具现化提供简洁命名。

**别名数量**：16 个别名家族（bvec/ivec/uvec/vec/dvec/i8vec/i16vec/i32vec/i64vec/u8vec/u16vec/u32vec/u64vec/fvec/f32vec/f64vec）× 4 分量数（1/2/3/4）× 4 精度变体（`lowp_`/`mediump_`/`highp_`/无前缀） = **256 个别名**。此数量与 roadmap §3C/§3G 中明确的"256 个类型别名定义数"一致，是首轮强制交付标准，不存在其他替代数量。

**命名约定**（强制规则）：

1. **大小写风格**：统一采用 **大写驼峰（PascalCase）** 风格。GLM 原生小写名称（如 `bvec`、`i8vec`）在转换为别名时首字母大写（`BVec`、`I8Vec`）。所有别名首字母均大写。
2. **精度前缀**：无精度前缀的别名默认为 `highp_` 变体（等价于 `PackedHighp`）。精度前缀统一使用 **驼峰拼接**（无下划线分隔）：`Highp`、`Mediump`、`Lowp` 作为前缀直接拼接在家族名前。例如 `LowpBVec2`（非 `lowp_bvec2` 或 `Lowp_BVec2`）。
3. **格式模板**：`[Precision]FamilyName[Dimension]`，其中 `Precision` 为 `Highp`/`Mediump`/`Lowp` 之一（默认精度省略），`FamilyName` 为家族名的大写驼峰形式，`Dimension` 为 1/2/3/4。
4. **家族名到大写驼峰的映射规则**：
   - 单字母家族：`b`→`B`、`i`→`I`、`u`→`U`
   - 定长家族：`vec`→`Vec`、`dvec`→`DVec`、`fvec`→`FVec`
   - 数字前缀家族：`i8`→`I8`、`i16`→`I16`、`i32`→`I32`、`i64`→`I64`、`u8`→`U8`、`u16`→`U16`、`u32`→`U32`、`u64`→`U64`、`f32`→`F32`、`f64`→`F64`

**256 个别名格式示例表**（覆盖 4 个精度变体的完整模式）：

| GLM 原生名 | highp（无前缀） | highp | mediump | lowp |
|-----------|----------------|-------|---------|------|
| `bvec2` | `BVec2` | `HighpBVec2` | `MediumpBVec2` | `LowpBVec2` |
| `ivec3` | `IVec3` | `HighpIVec3` | `MediumpIVec3` | `LowpIVec3` |
| `vec4` | `Vec4` | `HighpVec4` | `MediumpVec4` | `LowpVec4` |
| `dvec2` | `DVec2` | `HighpDVec2` | `MediumpDVec2` | `LowpDVec2` |
| `i8vec3` | `I8Vec3` | `HighpI8Vec3` | `MediumpI8Vec3` | `LowpI8Vec3` |
| `u16vec4` | `U16Vec4` | `HighpU16Vec4` | `MediumpU16Vec4` | `LowpU16Vec4` |
| `f32vec2` | `F32Vec2` | `HighpF32Vec2` | `MediumpF32Vec2` | `LowpF32Vec2` |

每个别名的 `type` 定义形式如：

```
type BVec2 = Vec2<Bool, PackedHighp>
type LowpBVec2 = Vec2<Bool, PackedLowp>
type IVec3 = Vec3<Int32, PackedHighp>
type HighpDVec2 = Vec2<Float64, PackedHighp>
type LowpI8Vec2 = Vec2<Int8, PackedLowp>
```

**别名实用性分级（仅用于编码顺序规划，非交付标准）**：256 个别名可按使用频率分为三级，用于指导编码阶段的实现顺序而非定义交付边界：

| 级别 | 数量 | 涵盖范围 | 说明 |
|------|------|---------|------|
| **必备** | 64 | 4 标量家族（b/ i/ u/ vec）× 4 分量数 × 4 精度变体 | 最常用的布尔/整数/无符号/浮点向量全体精度 |
| **常用** | 48 | 3 标量家族（d/ i8/ u8）× 4 分量数 × 4 精度变体 | 双精度和 8 位整数向量全体精度 |
| **可选** | 144 | 其余 9 家族 × 4 分量数 × 4 精度变体 | 16/32/64 位整数及 fvec/f32/f64 向量全体精度 |
| **合计** | 256 | 16 家族 × 4 分量数 × 4 精度变体 | — |

**首轮实现策略**：
- **强制交付标准**：`fwd.cj` 中**全量定义 256 个别名**，此为首轮验收强制标准。
- **降级策略（可选，需触发范围变更评审）**：若首轮孵化阶段因进度或资源限制需要缩小范围，可将别名覆盖范围从 256 缩减至**无精度前缀别名 + `highp_` 精度变体**（16 家族 × 4 分量数 × 1 默认精度 = 64 个）。此缩编必须经过**范围变更评审**并由主 Agent 确认。降级后剩余的 192 个别名纳入第 2 轮范围，在首轮验收通过后立即实施。roadmap 中描述的"最简可行范围 48 个"（16 家族 × 3 分量数 × 1 精度变体，排除 Vec1 别名）可作为进一步缩编的边界参考，但同样需触发范围变更评审。
  - **缩编触发条件**：① 首轮编码完成全部 256 个别名后，经编译验证发现 256 个别名导致总编译时间超过项目可接受阈值（如 > 30 分钟）或生成产物大小超过预期（如静态库体积 > 5MB）；② 项目进度评估由主 Agent 认定首轮交付窗口期不足，需人工下调别名覆盖范围。**审批路径**：由实施者提出缩编申请 → 主 Agent 确认 → 记录于范围变更日志。**剩余别名补全期限**：缩编后剩余的 192 个别名须在首轮验收通过后的下一轮次（第 2 轮）内补全，不晚于首轮验收后 4 周。
- **外部脚本生成策略**：256 个别名的定义具有高度规律性（16 家族 × 4 分量数 × 4 精度变体 = 256 组合），推荐使用**外部脚本**自动生成 `fwd.cj` 的别名定义代码。脚本策略：① 使用 Python 或 Node.js 脚本枚举所有组合（家族名→分量类型映射、分量数→VecN 映射、精度→Qualifier 映射）；② 按命名约定模板 `[Precision]FamilyName[Dimension]` 生成 `type` 定义行；③ 按家族分组、分量数排序组织输出；④ 输出直接写入 `fwd.cj` 的别名区域。此策略减少手动编码错误、降低重复劳动，且后续轮次新增别名家族时只需更新脚本的映射表。
  - **脚本产出规范**：
    - 输出路径：`src/glm/fwd.cj`（覆盖该文件的别名定义区域，保留文件头注释和文件尾空行）
    - 格式约定：按 16 家族分组（每组以 `// === {FamilyName} family ===` 注释头分隔），组内按分量数递增排列（Vec1→Vec2→Vec3→Vec4），每组内按精度变体排列（无前缀→Highp→Mediump→Lowp）
    - 版本控制策略：生成的 `fwd.cj` 文件纳入版本控制，生成脚本（如 `scripts/gen_fwd_aliases.py`）同步纳入版本控制仓库
    - 产物审查要求：生成的 `fwd.cj` 必须通过人工审查——抽查至少 4 个家族（`B`/`I`/`U`/`Vec`）各一个精度变体的别名映射正确性；审查后执行 `cjpm build` 验证全量编译通过
  - **fwd.cj 预期文件结构**：
    ```
    // fwd.cj — GLM 兼容类型别名
    // 注意：此文件由脚本自动生成，手动修改请谨慎
    
    package glm
    import glm.detail.{ Vec1, Vec2, Vec3, Vec4 }
    import glm.detail.{ PackedHighp, PackedMediump, PackedLowp, Qualifier }
    
    // === Bool family ===
    type BVec1 = Vec1<Bool, PackedHighp>
    type HighpBVec1 = Vec1<Bool, PackedHighp>
    type MediumpBVec1 = Vec1<Bool, PackedMediump>
    type LowpBVec1 = Vec1<Bool, PackedLowp>
    type BVec2 = Vec2<Bool, PackedHighp>
    // ...（以下按模式重复）
    
    // === Int family ===
    type IVec1 = Vec1<Int32, PackedHighp>
    // ...
    ```
    256 个别名集中在单文件中不拆分多文件——`fwd.cj` 预期约 300-350 行（含分组注释和空行），在单文件范围内可管理。
- **编码顺序**：在 `fwd.cj` 中按标量家族分组组织，每组内按分量数递增排列。首轮编码时按"必备→常用→可选"顺序依次实现，每完成一组即编译验证。

选择将别名集中在 `fwd.cj`（`package glm`）中，而非分散在各 Vec 定义文件，以保持良好的关注点分离——Vec 结构体关心类型定义，别名层关心命名约定。

**命名差异的长期影响**：大写驼峰别名（`BVec2`、`IVec3`）与 C++ GLM 小写名（`bvec2`、`ivec3`）的差异引入持续的认知映射成本。下游使用者需在以下两种命名空间之间建立 mental mapping：① C++ GLM 文档和遗留代码中的小写原生名；② 仓颉代码中的 PascalCase 别名。此映射成本在前 1-3 个月的过渡期最为显著（开发者频繁查阅 GLM 官方文档时需进行大小写转换），之后随着代码库的使用趋于自动化。**缓解措施**：① 在项目 `CONTRIBUTING.md` 或编码规范文档中提供完整映射表（已包含在 §11.7 中）；② 编码阶段将 `fwd.cj` 的首行注释标注为"GLM 兼容类型别名，命名风格为大写驼峰（PascalCase）"，作为新开发者的即时提示；③ 对于高频使用的标量类型（`vec`/`ivec`/`uvec`/`bvec`），可考虑在团队内部编码规范中建立"GLM 名 → 仓颉别名"的快速参考卡片。**长期可维护性评估**：一旦代码库定型，PascalCase 别名的使用将成为仓颉项目的编码惯例，新代码开发时直接使用 PascalCase 名称不会产生额外的跨语言切换成本。此差异在首轮可接受，无需在后续轮次修正。

### 3.9 C++ 辅助设施省略说明

**`genTypeTrait` 和 `find_best_type` 等辅助设施**：
- C++ `qualifier.hpp` 的 `detail` 命名空间中定义了 `genTypeEnum` 枚举（`GENTYPE_VEC`/`GENTYPE_MAT`/`GENTYPE_QUAT`）、`genTypeTrait<genType>` 模板偏特化（查询类型是 VEC/MAT/QUAT）、`init_gentype<genType, type>` 模板（提供 `identity()` 静态方法），以及 `find_best_type` 等类型选择工具。
- 这些辅助设施在首轮中**不需要且不迁移**。理由：它们的功能服务于矩阵/四元数层的泛型代码（如 `init_gentype` 为矩阵和四元数提供单位值生成），当前首轮范围不包含矩阵和四元数类型。这些设施将在第 2-3 轮（矩阵/四元数迁移）时随对应实现一并引入。首轮保留 `qualifier.cj` 中的 `vec`/`mat`/`qua` 前向声明注释即可。

---

## 4. 关键行为契约

### 4.1 向量构造

- **默认构造**：**不可用**。数据成员无初始值，编译器不自动生成无参构造函数。需要默认值的场景应使用标量填充构造（传入 `T(0)`）。
- **标量填充构造**：接收单一标量，赋值给所有分量。对 Vec1~Vec4 均有效。也是事实上的"默认构造"替代。
- **逐分量构造**：接收与分量数相同数量的标量参数。Vec2 接收 `(x, y)`，Vec3 接收 `(x, y, z)`，Vec4 接收 `(x, y, z, w)`。
- **跨 Vec 转换构造**：从同分量数但不同 `T`/`Q` 的 Vec 构造，分量值通过 `T(v)` 显式类型构造函数转换。不使用 `where T2 <: T` 类型的泛型约束——仓颉原始数值类型间不存在子类型关系（`Int8` 不是 `Int32` 的子类型），因此 `where T2 <: T` 约束对于数值类型转换无效。改用无约束泛型参数配合分量级 `T(v2.components)` 显式转换实现。
- **跨分量数构造**：Vec4 可从 Vec2+Vec2、Vec3+标量、Vec1+Vec2+Vec1 等组合构造；Vec3 类似；Vec2 从 Vec1+标量等。遵循 GLSL 5.4.1 规范。
- **从 Vec1 显式构造**：所有 Vec 支持从 `Vec1<T, Q>` 显式构造，所有分量取 Vec1 的单一分量值。

**完整构造函数签名清单**（仓颉语法）：

**Vec1<T, Q> where Q <: Qualifier**：
```
// 注意：所有 `const init` 构造函数均显式声明为 `public`
// const 构造函数（同时作为运行时构造函数，const README §3.2 规则 5）
// 同时承担标量填充构造角色（等效于其他 VecN 的 init(scalar: T)）
public const init(x: T)
// 跨类型转换
public init<T2, Q2>(v: Vec1<T2, Q2>) where Q2 <: Qualifier
// 跨分量数截断构造
public init<T2, Q2>(v: Vec2<T2, Q2>) where Q2 <: Qualifier  // truncated from Vec2, take x
public init<T2, Q2>(v: Vec3<T2, Q2>) where Q2 <: Qualifier  // truncated from Vec3, take x
public init<T2, Q2>(v: Vec4<T2, Q2>) where Q2 <: Qualifier  // truncated from Vec4, take x
```
**Vec1 构造函数接口不对称性说明**：Vec1 仅提供 `const init(x: T)` 而无 `public init(scalar: T)`，与其他 VecN（Vec2~Vec4）同时提供 `public init(scalar: T)` 和 `const init(...)` 的构造模式不同。原因：Vec1 的 `const init(x: T)` 仅接收一个 `T` 参数，若同时定义 `public init(scalar: T)`，两者参数列表均为单 `T` 参数。仓颉函数重载规则中 `const` 修饰符不构成重载区分依据（const README §3.2 规则 7），因此 `const init(x: T)` 与 `public init(scalar: T)` 视为重复定义，编译将报错。此限制仅影响 Vec1（单分量 Vec 的 `const init` 天然具有与标量填充构造相同的参数签名），Vec2~Vec4 的 `const init(x, y, ...)` 参数数量与 `public init(scalar: T)` 不同，不受此影响。Vec1 的 `const init(x: T)` 在非 const 上下文中同样可用于运行时构造（const README §3.2 规则 5），等效于标量填充构造的功能。

**Vec2<T, Q> where Q <: Qualifier**：
```
// 标量填充
public init(scalar: T)
// const 构造函数（同时作为逐分量运行时构造函数）
public const init(x: T, y: T)
// 跨类型转换（同分量数）
public init<T2, Q2>(v: Vec2<T2, Q2>) where Q2 <: Qualifier
// Vec1 + 标量组合
public init<T2, Q2>(a: Vec1<T2, Q2>, b: T) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec1<T2, Q2>) where Q2 <: Qualifier
// Vec1 + Vec1 组合
public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>) where Q2 <: Qualifier
// 从 Vec1 填充全部分量（仅同类型，跨类型受限原因见 §7 D31）
public init(v: Vec1<T, Q>)
// 跨分量数截断构造
public init<T2, Q2>(v: Vec3<T2, Q2>) where Q2 <: Qualifier  // truncated from Vec3, take x,y
public init<T2, Q2>(v: Vec4<T2, Q2>) where Q2 <: Qualifier  // truncated from Vec4, take x,y
```

**Vec3<T, Q> where Q <: Qualifier**：
```
// 标量填充
public init(scalar: T)
// const 构造函数（同时作为逐分量运行时构造函数）
public const init(x: T, y: T, z: T)
// 跨类型转换（同分量数）
public init<T2, Q2>(v: Vec3<T2, Q2>) where Q2 <: Qualifier
// Vec2 + 标量组合
public init<T2, Q2>(a: Vec2<T2, Q2>, b: T) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec2<T2, Q2>) where Q2 <: Qualifier
// Vec1 + 2 标量组合
public init<T2, Q2>(a: Vec1<T2, Q2>, b: T, c: T) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec1<T2, Q2>, c: T) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: T, c: Vec1<T2, Q2>) where Q2 <: Qualifier
// Vec1 + Vec1 + 标量组合
public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>, c: T) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: T, c: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec1<T2, Q2>, c: Vec1<T2, Q2>) where Q2 <: Qualifier
// Vec1 + Vec1 + Vec1 组合
public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>, c: Vec1<T2, Q2>) where Q2 <: Qualifier
// Vec2 + Vec1 组合
public init<T2, Q2>(a: Vec2<T2, Q2>, b: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec2<T2, Q2>) where Q2 <: Qualifier
// 从 Vec1 填充全部分量（仅同类型，跨类型受限原因见 §7 D31）
public init(v: Vec1<T, Q>)
// 跨分量数截断构造
public init<T2, Q2>(v: Vec4<T2, Q2>) where Q2 <: Qualifier  // truncated from Vec4, take x,y,z
```

**Vec4<T, Q> where Q <: Qualifier**：
```
// 标量填充
public init(scalar: T)
// const 构造函数（同时作为逐分量运行时构造函数）
public const init(x: T, y: T, z: T, w: T)
// 跨类型转换（同分量数）
public init<T2, Q2>(v: Vec4<T2, Q2>) where Q2 <: Qualifier
// Vec3 + 标量组合
public init<T2, Q2>(a: Vec3<T2, Q2>, b: T) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec3<T2, Q2>, b: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec3<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec3<T2, Q2>) where Q2 <: Qualifier
// Vec2 + Vec2 组合
public init<T2, Q2>(a: Vec2<T2, Q2>, b: Vec2<T2, Q2>) where Q2 <: Qualifier
// Vec2 + 2 标量组合
public init<T2, Q2>(a: Vec2<T2, Q2>, b: T, c: T) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec2<T2, Q2>, c: T) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: T, c: Vec2<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec2<T2, Q2>, b: Vec1<T2, Q2>, c: T) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec2<T2, Q2>, b: T, c: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec2<T2, Q2>, c: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec2<T2, Q2>, c: T) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: T, c: Vec2<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec1<T2, Q2>, c: Vec2<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec2<T2, Q2>, b: Vec1<T2, Q2>, c: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec2<T2, Q2>, c: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>, c: Vec2<T2, Q2>) where Q2 <: Qualifier
// Vec1 + 3 标量组合
public init<T2, Q2>(a: Vec1<T2, Q2>, b: T, c: T, d: T) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec1<T2, Q2>, c: T, d: T) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: T, c: Vec1<T2, Q2>, d: T) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: T, c: T, d: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>, c: T, d: T) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: T, c: Vec1<T2, Q2>, d: T) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: T, c: T, d: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec1<T2, Q2>, c: Vec1<T2, Q2>, d: T) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec1<T2, Q2>, c: T, d: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: T, c: Vec1<T2, Q2>, d: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>, c: Vec1<T2, Q2>, d: T) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>, c: T, d: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: T, c: Vec1<T2, Q2>, d: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: T, b: Vec1<T2, Q2>, c: Vec1<T2, Q2>, d: Vec1<T2, Q2>) where Q2 <: Qualifier
public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>, c: Vec1<T2, Q2>, d: Vec1<T2, Q2>) where Q2 <: Qualifier
// 从 Vec1 填充全部分量（仅同类型，跨类型受限原因见 §7 D31）
public init(v: Vec1<T, Q>)
```

以上清单覆盖 GLSL 5.4.1 规范定义的构造语义。编码阶段按此清单实现每个 Vec 的构造函数，无需额外参考 C++ 源码中的宏展开。

**跨类型构造函数 T2 有效性范围**：所有跨类型构造函数（`public init<T2, Q2>(v: VecN<T2, Q2>) where Q2 <: Qualifier`）的 T2 参数在签名层面无约束——T2 可为任意类型，包括非数值类型（如 `Bool`）。T2 的类型有效性由构造函数体内的 `T(v.x)` 转换表达式在实例化时决定：若 `T2` 到 `T` 的类型转换合法（即仓颉原生类型构造函数 `T(T2_value)` 可编译），则实例化通过；反之产生编译错误。此行为与 D5（宽松泛型约束，延迟检查）一致。T2 到 T 各组合转换的详细边界约定见 §9.4 类型转换边界表——跨类型构造的具体转换行为（整数宽度提升/截断、无符号↔有符号、浮点↔整数、Bool↔数值等）以该表为准。编码阶段实现跨类型构造函数时须同步查阅 §9.4 确认各 T2-T 组合的预期行为。

**跨 Q 构造函数重载解析风险与约束验证**：
- 所有跨类型构造函数（`public init<T2, Q2>(...) where Q2 <: Qualifier`）在 Q 参数上使用相同的约束（`Q2 <: Qualifier`），当 Q2 被实例化为不同 Qualifier 类型时，重载解析按实际参数类型匹配。仓颉泛型函数重载解析规则：泛型参数不构成区分依据，实际参数类型匹配决定选择。
- **已知安全场景**：① 不同 VecN 分量数的构造函数不会冲突（参数类型不同：`Vec2<T2, Q2>` vs `Vec3<T2, Q2>`），重载解析按分量数区分；② 同分量数的跨类型构造函数（`init<T2, Q2>(v: VecN<T2, Q2>)`）与同类型 fill-from-Vec1 构造函数（`init(v: Vec1<T, Q>)`）的冲突已在 D31 中覆盖——fill-from-Vec1 仅保留同类型版；③ 标量参数类型（`T`）与 Vec 参数类型的构造函数不会冲突（参数个数和类型均不同）。
- **风险领域**：当调用方传递一个已部分具现化的 Vec 类型（如 `Vec2<Float32, PackedHighp>`）时，仓颉编译器可能同时匹配多个泛型构造函数模板。需编码阶段原型验证：对 `Vec4` 的 `init<T2, Q2>(v: Vec3<T2, Q2>, b: T)` 和 `init<T2, Q2>(v: Vec3<T2, Q2>, b: Vec1<T2, Q2>)`，当第二个参数为 `Vec1<T, Q>` 类型的变量时，两个构造函数的第一个参数匹配相同（`Vec3`），第二个参数 `T` vs `Vec1<T, Q>` 是否因类型结构不同而充分区分。若编码阶段发现重载歧义，策略为移除歧义分支或将模糊分支改为具名函数形式。

### 4.2 分量访问

- 通过 `operator []` 按索引访问（0 ~ N-1），带边界断言（`GLM_ASSERT_LENGTH` 等效）。仓颉 `[]` 运算符有两种形式：
  - **取值形式**：`public operator func [](i: Int64): T` — 返回第 i 分量。越界时触发断言。
  - **赋值形式**：`public mut operator func [](i: Int64, value!: T): Unit` — 将第 i 分量设为 value。`value` 为命名参数。必须声明为 `mut` 函数，因为 struct 的非 `mut` 实例成员函数不能修改实例成员。越界时触发断言。
- **const 上下文中的分量访问**：仓颉的 `const` 修饰符不构成函数重载的区分依据（const README §3.2 规则 7），因此无法同时定义 `const` 和非 `const` 两个版本的 `operator[]` 取值形式。对于需要在 `const` 实例成员函数中通过索引访问分量的场景，提供具名 const 函数：
  ```cangjie
  public const func componentAt(i: Int64): T
  ```
  该函数与 `operator[]` 取值形式的行为完全一致（含边界断言），但标注为 `const`，可在 `const` 实例成员函数体内使用。`componentAt` 在非 const 上下文中同样可用。
- 通过具名成员（`x`/`y`/`z`/`w`、`r`/`g`/`b`/`a`、`s`/`t`/`p`/`q`）直接访问。

断言行为：Debug/Release 模式下均保留断言检查（首轮简化策略）。后续轮次可通过 `const` 配置 + `const if` 在 Release 模式下跳过。

**`operator[]` 索引类型选择理由**：采用 `Int64` 作为索引类型。原因：① `shim_cstddef.cj` 中的 `LengthT` 别名定义为 `Int64`，`length()` 静态函数返回 `Int64`，索引类型与之保持一致可避免编译器在有符号/无符号比较时的告警；② `Int64` 是仓颉默认整数类型，在索引场景中覆盖所有可能的向量长度（当前 Vec1~Vec4 的最大索引为 3）；③ 与 GLM 默认 `length_t = int`（有符号）的行为一致。

### 4.3 算术运算

- **二元算术运算符**（`+`、`-`、`*`、`/`、`%`）：在 Vec 结构体内部定义为 `operator func`（非 `mut`），标注 `@OverflowWrapping`，内部实现为逐分量直接运算。支持 `vec + vec`、`vec + scalar` 等右操作数为标量或 Vec 的形式。
- **复合赋值运算符**（`+=`、`-=`、`*=`、`/=`、`%=`）：由仓颉编译器从对应的二元运算符自动生成。不需要也不允许在源码中显式定义。`@OverflowWrapping` 标注在二元运算符上，复合赋值继承 wrapping 语义。
- **一元运算符**（`+`、`-`）：`+v` 返回自身；`-v` 返回逐分量取反的新向量。
- **标量在左的运算替代方案**：`scalar + vec`、`scalar - vec`、`scalar / vec` 等左标量右向量的运算符重载不可实现。提供具名函数替代，包括双向重载覆盖两种操作数顺序：
  - `add(v: VecN<T,Q>, s: T): VecN<T,Q>`（扩展成员函数，声明为非 `const`）和 `add(s: T, v: VecN<T,Q>): VecN<T,Q>`（包级独立函数，声明为 `const`）
  - `sub(v: VecN<T,Q>, s: T): VecN<T,Q>`（扩展成员函数，声明为非 `const`）和 `sub(s: T, v: VecN<T,Q>): VecN<T,Q>`（包级独立函数，声明为 `const`）
  - `mul(v: VecN<T,Q>, s: T): VecN<T,Q>`（扩展成员函数，声明为非 `const`）和 `mul(s: T, v: VecN<T,Q>): VecN<T,Q>`（包级独立函数，声明为 `const`）
  - `div(v: VecN<T,Q>, s: T): VecN<T,Q>`（扩展成员函数，声明为非 `const`）和 `div(s: T, v: VecN<T,Q>): VecN<T,Q>`（包级独立函数，声明为 `const`）
  - `mod(v: VecN<T,Q>, s: T): VecN<T,Q>`（扩展成员函数，声明为非 `const`）和 `mod(s: T, v: VecN<T,Q>): VecN<T,Q>`（包级独立函数，声明为 `const`）
- **`const` 修饰符差异依据**：扩展成员函数（`vec-op-scalar` 方向）因定义在 `extend` 块中，仓颉扩展语法不允许 `const` 修饰符（仓颉扩展 §4.2）。包级独立函数（`scalar-op-vec` 方向）无此限制，声明为 `const` 以支持编译期调用。此差异对公共 API 的影响：`v.add(s)` 语法丢失编译期调用能力，而 `add(s, v)` 语法保留。编码阶段若需在 `const` 上下文中使用 `vec-op-scalar` 方向，可调用包级独立函数并交换操作数顺序（`add(s, v)`）。
- **具名函数的定义位置与形态**：
  - **`vec-op-scalar` 方向**（如 `add(v, s)`）：定义为 Vec 的 **扩展成员函数**（通过 `extend VecN<T,Q>` 块），定义在对应 `type_vecN.cj` 文件中。调用方通过 `v.add(s)` 语法调用，随 Vec 类型导入自动可见。
  - **`scalar-op-vec` 方向**（如 `add(s, v)`）：定义为 **包级独立函数**，集中定义在独立的 `scalar_vec_ops.cj` 文件中（与 ComputeVec* 运算策略 `compute_vector_decl.cj` 职责分离）。调用方通过 `import glm.detail.{ add, sub, mul, div, mod }` 或通过 `glm` 包统一引入。该方向无法定义为扩展成员函数（孤儿规则——标量类型如 `Int32`/`Float32` 不在本包中定义）。
  - **Vec1~Vec4 各自定义**：每个 `add`/`sub`/`mul`/`div`/`mod` 函数为 Vec1~Vec4 各定义四个版本（共 5 运算 × 4 Vec × 2 方向 = 40 个函数），通过函数重载按 Vec 类型参数区分。
  - **`@OverflowWrapping` 标注策略**：20 个 vec-op-scalar 方向扩展成员函数（`add(v,s)` 等，5 运算 × 4 Vec）的内部实现**委托给对应 Vec 的二元算术运算符**（`+`/`-`/`*`/`/`/`%`）。二元运算符已在 Vec 结构体内部直接标注 `@OverflowWrapping`（§4.6），因此扩展成员函数通过委托**隐式获得 wrapping 语义**，无需额外标注。委托实现模式示例：`func add(self: Vec2<T,Q>, s: T): Vec2<T,Q> { self + s }`（调用已标注 `@OverflowWrapping` 的 `+`）。此策略避免 20 处重复标注，且确保扩展成员函数与二元运算符的溢出行为完全一致（同一代码路径，仅调用入口不同）。
  - 后续轮次可通过**宏生成**自动产生上述具名函数的重复定义，减少手动编码量。
  - **命名空间污染风险评估**：`scalar-op-vec` 方向具名函数（`add(s, v)`、`sub(s, v)` 等）定义为 `package glm.detail` 中的包级独立函数，通过 `lib.cj` 的 `public import` 暴露到 `package glm` 命名空间。这些函数的名称（`add`、`sub`、`mul`、`div`、`mod`）是常见英文单词，在不同上下文中可能与其他库或用户代码中的同名函数发生冲突。**风险等级**：低-中。在单一项目中此类冲突概率较低；但在大型项目中，`add`/`sub` 等名称可能被多个模块定义。**调用方最佳实践**：① 优先使用 `vec-op-scalar` 方向的扩展成员函数（`v.add(s)`）以避免导入包级函数；② 若需使用 `scalar-op-vec` 方向函数，通过限定导入（`import glm.detail.{ add, sub, mul, div, mod }`）明确来源——注意 `scalar_vec_ops.cj` 声明了 `package glm.detail`，导入路径使用包名而非文件名；③ 若发生命名冲突，使用 `import glm` 的别名导入或通过局部函数包装消除歧义。
- **二元运算符与具名函数的关系及选择指南**：`vec-op-scalar` 方向具名函数（如 `add(v, s)`）与二元运算符 `v + s` 在功能上重叠——两者均执行逐分量加法运算。关系如下：① 二元运算符（`+`、`-`、`*`、`/`、`%`）是首选语法糖，适用于表达式链中需要运算符简洁性的场景（如 `a + b * c`）；② `vec-op-scalar` 方向扩展成员函数（`v.add(s)`）在功能上与 `v + s` 等价，适用于需要显式方法调用风格或未来需要替换为优化版本（如 SIMD 路径）的场景；③ `scalar-op-vec` 方向独立函数（`add(s, v)`）覆盖二元运算符无法表达的操作数顺序（标量在左），是运算符的**补充而非重复**。编码阶段建议：优先使用二元运算符，仅在需要 `scalar-op-vec` 方向或需要函数作为一等公民传递时使用具名函数。
- **`%` 运算的整数约束**：`%` 运算符在 Vec 上定义为逐分量取模。当 `T` 为整数类型时正常编译；当 `T` 为浮点类型时，因仓颉原生 `Float32`/`Float64` 不支持 `%`，在实例化时产生编译错误。此行为与 D5（宽松泛型约束）一致——错误触发于使用处而非定义处。对于需要浮点数取模的场景，使用具名函数 `mod`（属于首轮范围）。`mod` 对浮点类型 Vec 的实现策略：整数 T 场景直接使用 `%` 运算符（与 Vec 二元 `%` 运算符行为一致）；浮点 T 场景因仓颉原生 `Float32`/`Float64` 不支持 `%`，改用算术恒等式 `x - y * trunc(x / y)` 实现浮点取模——其中 `trunc` 取自 `std.math`。对于 `Float32` 分量，通过先提升至 `Float64` 计算截断再转换回 `Float32` 的方式实现（`std.math.trunc` 仅提供 `Float64` 版本，预期精度提升无损取模语义的正确性（需验证，详见 §10 浮点 `mod` 实现正确性验证依赖项②））。此双路径在函数体内通过 `if (isIec559Of<T>())` 实现编译期分支选择。仓颉中 `const if` 要求所在函数必须为 `const` 函数，因此 `mod` 的**包级独立函数**方向（`mod(s: T, v: VecN<T,Q>)`）声明为 `const`。**扩展成员函数**方向（`mod(v: VecN<T,Q>, s: T)`）因定义在 `extend` 块中，不支持 `const` 修饰符（仓颉扩展 §4.2），无法使用 `const if`。此方向的整数/浮点双路径方案不可行——回退方案：`mod` 扩展成员函数仅提供整数路径（使用 `%`），浮点路径由包级独立函数覆盖。`add`/`sub`/`mul`/`div` 的包级独立函数声明为 `const`，扩展成员函数声明为非 `const`。
- **`++`/`--` 替代方案**：`++`/`--` 不在仓颉可重载运算符列表中，不可实现为运算符重载。改为提供具名函数 `increment(): VecN<T,Q>` 和 `decrement(): VecN<T,Q>`（标注 `@OverflowWrapping`，因定义在 `extend` 块中声明为非 `const` 函数），返回逐分量加/减 1 的新向量。C++ 的 `v++`（后缀）迁移为 `v = v.increment()`，`++v`（前缀）迁移为 `v = v.increment()`。对于 `VecN<Bool, Q>`，`increment()`/`decrement()` 在实例化时因 `Bool` 不支持 `+`/`-` 产生编译错误，与 `%` 的整数约束行为一致。
- **跨类型操作**：二元运算符仅支持同类型操作数（`VecN<T, Q> op VecN<T, Q>` 及 `VecN<T, Q> op T`）。不支持跨类型操作数（如 `Vec2<Int32> + Vec2<Int16>`）。需要跨类型运算时，调用方应显式转换操作数类型（使用跨 Vec 转换构造函数）。此限制源自仓颉运算符重载不能为泛型的语言规则——运算符函数定义中无法声明额外的类型形参 `U`（运算符不能使用 `operator func +<U>(rhs: U)` 的形式引入新类型参数）。

### 4.4 位运算

仅整数分量 Vec 有意义。包括 `&`、`|`、`^`、`<<`、`>>`。逐分量运算。二元位运算符通过 `extend` 块定义为扩展成员函数。`extend` 块的完整语法示例如下：

```cangjie
// 以 Vec2<T, Q> 为例，在 type_vec2.cj 中定义位运算符
extend<T, Q> Vec2<T, Q> where Q <: Qualifier {
    @OverflowWrapping
    public operator func <<(shift: T): Vec2<T, Q> {
        Vec2(this.x << shift, this.y << shift)
    }
    public operator func &(rhs: Vec2<T, Q>): Vec2<T, Q> {
        Vec2(this.x & rhs.x, this.y & rhs.y)
    }
    public operator func |(rhs: Vec2<T, Q>): Vec2<T, Q> {
        Vec2(this.x | rhs.x, this.y | rhs.y)
    }
    public operator func ^(rhs: Vec2<T, Q>): Vec2<T, Q> {
        Vec2(this.x ^ rhs.x, this.y ^ rhs.y)
    }
    public operator func >>(shift: T): Vec2<T, Q> {
        Vec2(this.x >> shift, this.y >> shift)
    }
    public func bitwiseNot(): Vec2<T, Q> {
        Vec2(!this.x, !this.y)
    }
}
```
`extend` 块的类型参数声明语法与 struct 定义一致——`extend<T, Q> Vec2<T, Q> where Q <: Qualifier`。扩展成员函数默认可见性与被扩展类型一致（`internal`），可通过 `public` 提升为对外可见。`this` 关键字在扩展成员函数中指向被扩展的 Vec 实例。注：`extend` 块中的成员函数不支持 `const` 修饰符（仓颉扩展 §4.2），因此 `bitwiseNot` 在此声明为非 `const` 函数。

**溢出策略**：`&`、`|`、`^` 运算不会产生溢出（按位运算结果在位宽内）。`<<`（左移）可能溢出——仓颉中 `<<` 的默认溢出策略**属于编译器实现定义行为**，`ThrowingOp<T>` 标准库辅助接口不包含 `throwingShl`，因此无法依赖标准库接口保证其默认策略。编码阶段须通过原型测试确认目标编译器的实际行为：若默认抛异常则标注 `@OverflowWrapping` 匹配 C++ GLM 的高位丢弃语义；若默认已 wrapping 则无需额外标注。C++ GLM 中 `vec << scalar` 是定义良好的（高位丢弃），因此 `<<` 运算符在 Vec 的 extend 块中定义时优先标注 `@OverflowWrapping`，编码阶段验证后确认是否需要保留。`>>` 右移不会产生溢出异常（高位补符号位或 0），保持默认策略。

`~`（单目按位取反）不在仓颉可重载运算符列表内，不可实现为运算符重载。改为提供具名函数 `bitwiseNot(): VecN<T,Q>`，通过 `extend` 块定义为非 `const` 扩展成员函数（仓颉扩展语法不允许 `const` 修饰符，详见 §3.2）。实现方式：`!` 是仓颉可重载的一元运算符，且对整数类型执行按位取反、对 `Bool` 执行逻辑非。因此 `bitwiseNot()` 的内部实现统一对每个分量调用 `!` 即可——对于整数分量，`!` 执行按位取反（与 C++ GLM 的 `~` 语义一致）；对于 `Bool` 分量（`VecN<Bool, Q>` 场景），`!` 执行逻辑否定（`!true = false`），这与 C++ GLM 的 `~bvec` 因整数提升始终返回 `true` 的行为完全相反。详见 §3.2 `VecN<Bool, Q>` 行为约定的已知行为差异说明。

**浮点类型约束**：`bitwiseNot()` 在 `VecN<Float32, Q>` 或 `VecN<Float64, Q>` 实例上会产生编译错误。原因是仓颉浮点类型（`Float32`/`Float64`）不原生支持 `!` 一元运算符（`!` 仅定义于整数类型和 `Bool`）。当 `T = Float32` 时，`bitwiseNot()` 函数体内的 `!component` 表达式无法通过编译。此行为与 D5（宽松泛型约束，延迟检查到实例化处）一致——错误发生在 Vec 使用者实例化 `VecN<Float32, Q>.bitwiseNot()` 的调用处，而非 Vec 结构体定义处。

**`<<` 和 `>>` 的移位量参数**：仓颉运算符重载不能为泛型——即不能定义 `operator func <<<U>(rhs: U)` 引入新类型参数。因此移位量的类型必须是具体类型（不可为模板参数 `U`）。可选方案：
- **方案 A（采用）：移位量取 `T`** ——右操作数类型与分量类型相同。对于 `Vec2<UInt8> << UInt8(3)`，移位量为 `UInt8`。方案 A 与 C++ GLM 的 `operator<<(vec, T scalar)` 行为一致，且适用于所有整数 `T`。注意：当 `T = UInt8` 时，移位量范围受限（0~7），但 `UInt8(3)` 在语义上与 `Int64(3)` 等效。
- **方案 B（备选）：移位量取 `Int64`** ——右操作数为固定 `Int64` 类型，与分量类型无关。此方案使移位量类型与 `LengthT` 一致（均为 `Int64`），移位移位较大向量时无需类型转换。但无法用 VecN 作为右操作数（`vec << vec` 形式在 GLM 中存在但极少使用），且需为每个 VecN 单独定义接受 `Int64` 的 `<<` 运算符（无法复用分量类型 `T` 的运算符）。
- **决策**：首轮采用方案 A（移位量取 `T`），在 Vec 的 extend 块中定义为 `operator func <<(shift: T): VecN<T, Q>`。此方案与 D5（宽松泛型约束）一致——移位操作在整数 `T` 上正确编译，在非整数 `T` 上于实例化处报错。方案 B（`Int64` 移位量）作为备选，若后续编码阶段发现 `T` 类型移位量在位宽较窄时（如 `UInt8`）产生过多截断转换，可改为方案 B。

### 4.5 比较运算

**相等比较**：
- **`==`**：逐分量调用 `ComputeEqual<T>.callConst` 比较，全分量相等返回 `true`。声明为 `const` 函数，利用 Vec 的 `const init` 构造函数支持，在函数体内通过 `if (isIec559Of<T>())` 在编译期选择比较路径——浮点类型使用 Epsilon 容差比较，整数/Bool 类型使用 `==` 直接比较。
- **`!=`**：定义为对 `==` 结果取反——`!(a == b)`。任一分量不等返回 `true`。仓颉中无 `!==` 运算符概念，因此采用取反形式。
- **浮点精确相等比较**（`equalExact`）：为浮点分量 Vec 提供 `equalExact(other: VecN<T,Q>): Bool` 扩展成员函数（定义在 `extend` 块中，声明为非 `const`）。该函数跳过容差比较路径，直接使用仓颉原生 `==` 对每个分量做精确比较。适用于需要 IEEE 754 精确相等语义的场景（如 `Infinity == Infinity` 返回 `true`、`NaN == NaN` 返回 `false`）。`equalExact` 在各 `type_vecN.cj` 的 extend 块中定义，对整数/Bool 分量 Vec 其行为与 `==` 等价（整数/Bool 精确比较）。浮点类型在调用 `equalExact` 时不受 `==` 的 Epsilon 容差分支影响。`equalExact` 的 `@OverflowWrapping`/溢出策略：不涉及算术运算，无需标注。
- **`equalExact` 的 `const` 声明说明**：仓颉 `extend` 块不支持 `const` 修饰符（仓颉扩展 §4.2），因此 `equalExact` 在 `extend` 块中声明为非 `const` 函数。此限制不影响功能正确性——浮点 `==` 在非 `const` 上下文中同样可用，仅失去在 `const` 表达式中编译期调用的能力。若编码阶段需要在 `const` 上下文中调用 `equalExact`，可将其定义移至 struct 体内（各 Vec 结构体自身定义该函数），利用 `const init` 的存在声明为 `const` 实例成员函数（该备选方案不影响公共 API 签名）。
- **`==` 回退路径标注**：若 `ComputeEqual.callConst` 的 `const` 表达式链验证失败（§7 D29），`==` 整体回退到精确比较路径（所有类型使用 `a == b`）。在此回退路径下，`equalExact` 的行为与 `==` 完全等价（均使用精确比较），`equalExact` 作为独立具名函数保留以提供语义明确性和与 `==` 潜在未来差异化的扩展点。

**`<`/`<=`/`>`/`>=` 运算符**：
- **决策**：首轮**不定义** `<`/`<=`/`>`/`>=` 运算符。
- **理由**：C++ GLM 的 Vec 类型上未定义这四个运算符——`type_vecN.hpp` 中仅声明了 `==`、`!=`、`&&`、`||`。在 GLSL 语义中，向量的逐分量比较通过具名函数（`lessThan`、`greaterThan`、`lessThanEqual`、`greaterThanEqual`）完成，而非运算符。在仓颉中若定义这些运算符，需要明确语义选择——聚合比较（返回 `bool`，类似 `==`）与 C++ GLM 行为不一致，逐分量比较（返回 `VecN<Bool, Q>`）则无法在 `if` 中直接使用。因此首轮不提供，避免语义混淆。逐分量比较函数纳入后续函数库迁移轮次（从 `vector_relational.hpp` 迁移）。
- **替代方案**：需要逐分量比较时，使用 `ext/vector_relational.hpp` 中的具名函数（将来迁移）。

**布尔逻辑运算**：
- `&&` 和 `||` 不在仓颉可重载运算符列表内，不可实现为运算符重载。改为提供具名函数。各 VecN 类型分别定义对应版本：
  - `logicalAnd(a: VecN<Bool, Q>, b: VecN<Bool, Q>): VecN<Bool, Q>` — 定义为 **扩展成员函数**（通过 `extend VecN<Bool, Q>` 块），逐分量逻辑与（各 VecN 分别定义）。调用方使用 `v1.logicalAnd(v2)` 语法。注：`extend` 块不支持 `const` 修饰符，`logicalAnd` 声明为非 `const` 函数
  - `logicalOr(a: VecN<Bool, Q>, b: VecN<Bool, Q>): VecN<Bool, Q>` — 定义为 **扩展成员函数**（通过 `extend VecN<Bool, Q>` 块），逐分量逻辑或（各 VecN 分别定义）。调用方使用 `v1.logicalOr(v2)` 语法。注：与 `logicalAnd` 同理，声明为非 `const` 函数
  - 一元 `!` 可为 `VecN<Bool, Q>` 重载（`!` 在可重载运算符列表中）。

### 4.6 `@OverflowWrapping` 标注策略

本设计采用以下唯一确定的策略管理溢出标注：

**策略与 roadmap §0.5.1 的差异说明**：
- Roadmap §0.5.1 推荐的策略是：在**复合赋值运算符**（`+=`、`-=` 等）上标注 `@OverflowWrapping`，二元算术运算符委托给复合赋值实现，因此二元运算符无需标注。
- **本设计采用相反策略**：在**二元算术运算符**（`+`、`-`、`*`、`/`、`%`）上直接标注 `@OverflowWrapping`，复合赋值由编译器自动生成并继承标注语义。
- **理由**：仓颉的可重载运算符列表**不包含**复合赋值运算符（`+=`、`-=` 等），因此无法在源码中显式定义复合赋值函数，也就无法在其上直接标注 `@OverflowWrapping`。编译器在检测到返回类型与左操作数类型匹配的二元运算符后会自动生成对应的复合赋值版本，且自动生成时继承二元运算符上的 `@OverflowWrapping` 标注。因此将标注置于二元运算符上是唯一可行路径，且与 roadmap 在运行时语义上等价——wrapping 行为覆盖所有算术运算路径（包括复合赋值）。

具体标注分布：

- **二元算术运算符**（`+`、`-`、`*`、`/`、`%`）：在 Vec 结构体内部或 extend 块中定义为 `operator func`（非 `mut`），**直接标注 `@OverflowWrapping`**。`%` 虽整数取模不产生溢出，但标注 `@OverflowWrapping` 保持与所有算术运算符的一致性策略。共 5 个运算符 × 4 个 Vec 类型 = 20 处标注。运算符内部实现逐分量直接运算——不再使用"copy + op="委托模式（因复合赋值不可显式定义）。
- **`<<` 运算符**：在 extend 块中定义为位运算符，**标注 `@OverflowWrapping`**。仓颉中 `<<` 默认使用 `@OverflowThrowing` 策略（移位超出位宽抛 `ArithmeticException`），而 C++ GLM 的 `vec << scalar` 高位丢弃（wrapping 语义）。标注 `@OverflowWrapping` 可对齐行为。共 1 个运算符 × 4 个 Vec 类型 = 4 处标注。
- **`>>` 运算符**：右移不会产生溢出异常，不需要标注。
- **`&`、`|`、`^` 运算符**：按位运算不会产生溢出，不需要标注。
- **`increment()`/`decrement()` 具名函数**：作为 `++`/`--` 的替代，标注 `@OverflowWrapping`。共 2 个函数 × 4 个 Vec 类型 = 8 处标注。
- **vec-op-scalar 方向扩展成员函数**（`add(v,s)`/`sub(v,s)`/`mul(v,s)`/`div(v,s)`/`mod(v,s)`，共 5 运算 × 4 Vec = 20 个函数）：**无需直接标注**。这些函数的内部实现**委托给对应的二元算术运算符**（后者已标注 `@OverflowWrapping`），因此通过委托**隐式继承 wrapping 语义**。委托实现模式：`func add(self, s) { self + s }`（调用已标注的 `+`）。此策略避免重复标注，且确保扩展成员函数与二元运算符的溢出行为完全一致。
- **复合赋值运算符**（`+=`、`-=`、`*=`、`/=`、`%=`、`<<=`）：由仓颉编译器**自动生成**，不需要也不允许在源码中显式定义。编译器在检测到返回类型与左操作数类型匹配的二元运算符后自动生成对应的复合赋值版本。`@OverflowWrapping` 标注在二元运算符上，自动生成的复合赋值继承 wrapping 语义。
- **浮点类型无需标注**：浮点类型（`Float32`、`Float64`）在仓颉中不会触发溢出异常（浮点溢出产生 `±Infinity` 而非异常），因此 `@OverflowWrapping` 在浮点类型的 Vec 上语义无影响（标注与否行为一致）。首轮采用统一标注的简化策略——在所有 Vec 二元算术运算符上标注，无论 `T` 为何类型。
- **`%` 运算符的溢出行为**：`%` 的溢出行为与 C++ GLM 一致——整数取模不产生溢出（除零仍抛异常）。`@OverflowWrapping` 标注在 `%` 上主要是为了一致性，实际不影响取模运算的语义。

**总结**：`@OverflowWrapping` 在二元算术运算符（5 个：`+`、`-`、`*`、`/`、`%`）、`<<`（1 个）、`increment()`/`decrement()`（2 个）上直接标注，共约 32 处标注 = (5 + 1 + 2) × 4；20 个 vec-op-scalar 方向扩展成员函数通过委托间接继承 wrapping 语义，无需直接标注；复合赋值通过编译器自动生成继承标注语义。`@OverflowThrowing` 默认策略对 `>>`、`&`、`|`、`^` 保持原样（这些运算不产生溢出）。无内部矛盾的唯一决策。

**`@OverflowWrapping` 标注继承性验证要求**：当前策略断言编译器自动生成的复合赋值版本继承二元运算符上的 `@OverflowWrapping` 标注（见 §7 D30 验证计划）。**此行为依赖编译器的未文档化行为**——仓颉注解文档（§1.1）声明溢出注解"只能标记于函数声明上"，但未明确说明自动生成的复合赋值函数是否继承被委托二元运算符的注解。此继承性在仓颉语言层面既未确认也未否认，属于对编译器实现行为的推测。编码阶段需优先编写原型测试代码进行验证。若验证失败，切换到备选方案——**在已定义的 20 个 vec-op-scalar 方向扩展成员函数（§4.3 已纳入首轮范围）上直接标注 `@OverflowWrapping`**，二元运算符委托给这些已标注的函数。注意：由于 add/sub/mul/div/mod 的 vec-op-scalar 方向扩展成员函数已属于首轮范围（§4.3），D30 回退**无需新增函数定义**，仅需补充标注和修改委托目标。备选方案的额外工作量和成本已纳入 §11.6 迁移成本评估。

### 4.7 哈希契约

- Vec 类型通过 `@Derive[Hashable]` 统一实现 `Hashable` 接口。编译器自动为所有分量类型已实现 `Hashable` 的实例化生成 `hashCode(): Int64`，包括整数/Bool/浮点分量 Vec。
- `hashCode()` 覆盖 Vec 的所有数据分量（Vec1 覆盖 x，Vec2 覆盖 x/y，Vec3 覆盖 x/y/z，Vec4 覆盖 x/y/z/w）。
- **浮点 Vec 的 `Hashable` 限制**：`@Derive` 生成的按位 `hashCode()` 与浮点容差 `==` 不完全一致——两个在容差范围内相等但按位不同的浮点向量可能产生不同的哈希值。此限制在 §3.2 中详细说明。需要哈希容器键值一致性的场景，调用方应确保键值精确匹配或自行包装。

---

## 5. 错误处理策略

### 5.1 标准错误场景

| 场景 | 策略 |
|------|------|
| 下标越界（`operator[]`） | 在运行时检测索引范围，越界时调用 `assert()` 等效的 `if + throw` 模式。与 C++ `GLM_ASSERT_LENGTH` 行为一致。**注意语义差异**：C++ `GLM_ASSERT_LENGTH` 在 Release 模式下被宏定义移除（编译为空），而仓颉的 `if + throw` 无法通过编译消除（除非使用 `const` 配置常量 + `const if` 在 Release 模式下跳过断言检查）。首轮统一策略：Debug 和 Release 模式下均保留断言检查，Release 模式消除标记为后续轮次任务。 |
| 整数溢出 | 通过在二元算术运算符和 `<<` 运算符上标注 `@OverflowWrapping` 将溢出行为从"抛异常"改为"wrapping"，与 C++ UB 行为在数值结果上等价。`<<` 的默认行为是 `@OverflowThrowing`（超出位宽抛 `ArithmeticException`），标注 `@OverflowWrapping` 后与 C++ GLM 的高位丢弃行为一致。 |
| 除零 | 依赖底层仓颉运行时行为（整数除零抛 `ArithmeticException`，浮点除零返回 `±Inf`）。首轮不添加额外保护层。 |
| 位运算溢出 | `<<` 按 `@OverflowWrapping` 处理；`>>`、`&`、`|`、`^` 无溢出风险，保持默认策略。`increment()`/`decrement()` 按 `@OverflowWrapping` 处理。 |

### 5.2 异常场景和边界条件

首轮需明确约定以下边界行为：

| 场景 | 行为约定 |
|------|---------|
| 零向量标准化（`normalize(0,0,0)`） | 首轮不实现 `normalize` 函数，此约定适用于后续轮次。在算子层面，零向量的算术运算始终返回有效值（零向量加零向量得零向量，等）。 |
| 零向量除零保护 | 标量除零：`vec / 0` 对整数分量抛 `ArithmeticException`，对浮点分量返回包含 `±Inf`/`NaN` 的向量。与仓颉运行时行为一致，不做预防性检查。 |
| 浮点 NaN/Infinity 在各运算中的传播策略 | 所有算术运算直接委托给仓颉原生浮点运算，因此 NaN/Infinity 的传播行为与 IEEE 754 标准一致（NaN 参与的任何运算产生 NaN，Infinity 参与算术运算按 IEEE 754 规则传播）。首轮不引入 NaN 检测或特殊处理。 |
| 跨 Vec 转换中的精度损失 | 从较宽类型向较窄类型转换（如 `Float64` → `Int32`）时使用仓颉的类型构造函数转换语义。若为隐式转换不支持的场景（如 `Float64` → `Int32`），构造函数应要求调用方显式执行转换后传入。不默认截断或 saturate。 |

无 `Option`/`Result` 使用场景——向量算术运算始终返回有效值（在 wrapping 语义下），类型构造始终有效，不涉及可能失败的 I/O 或资源获取。

---

## 6. 并发设计

首轮范围无共享状态：Vec 结构体是值类型，所有运算不可变（产生新向量）或就地修改（复合赋值）。值类型的复制语义天然线程安全——不存在同一内存位置的并发写冲突。Vec 类型不做内部加锁，调用者负责在多线程场景下的值隔离（通过局部变量或消息传递）。

### 多线程场景覆盖

| 场景 | 行为约定 |
|------|---------|
| **Vec 在线程间传递** | Vec 为值类型，跨线程传递时通过复制实现——每个线程拥有独立的副本，无共享写冲突。通过 `spawn` 传递 Vec 变量时，捕获的 Vec 值被复制到新线程的栈上。 |
| **Vec 在并发容器中的行为** | Vec 可作为 `HashSet`/`HashMap` 键值使用（参见 §4.7 哈希契约）。在并发容器（如 `ConcurrentHashMap`）中使用时，Vec 作为不可变键值按值语义参与线程安全的容器操作。注意：`ConcurrentHashMap` 等容器内部已做同步，Vec 自身不做额外加锁。 |
| **复合赋值非原子性** | `v += other`（编译器自动生成的复合赋值）在并发场景下非原子——读取 v、逐分量运算、写回 v 三步骤不构成原子操作。若多个线程对同一 `var` 绑定的 Vec 变量执行复合赋值，可能产生竞争条件（丢失更新）。**约定**：对共享的 `var` Vec 变量执行复合赋值时，调用方需自行加锁（如使用 `Mutex`）或使用线程局部变量。此限制在 §9 异常场景中不重复声明，作为通用并发约束适用于所有 Vec 类型。 |
| **`@OverflowWrapping` 与并发** | 溢出标注不影响并发行为——`@OverflowWrapping` 仅控制算术运算的溢出语义（wrapping vs throwing），不影响数据竞争条件。在多线程复合赋值的竞争场景中，wrapping 行为仅保证每个分量的运算结果不抛异常，不保证分量的读写原子性。 |
| **const 函数与并发** | `const` 修饰符保证函数的只读语义（不修改实例成员），但不提供线程安全保证。在无共享可变状态的值类型场景中，const 函数的并发调用始终安全——多个线程对同一 Vec 副本调用 const 函数不会产生数据竞争。 |

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
- 接口 + 空结构体：零运行时开销（空结构体的大小为零或极小），类型参数 `Q <: Qualifier` 编译期约束保证了类型安全性。通过 `type` 别名在 `glm` 包中提供常用具现化的简写形式。

### D3. 二元运算符 `@OverflowWrapping` 直接标注 vs 委托模式

**决策**：二元算术运算符直接标注 `@OverflowWrapping`、直接实现逐分量运算；复合赋值由编译器自动生成。

**理由**：v3 中采用"copy + op="委托模式，但仓颉可重载运算符列表中不包含复合赋值运算符（`+=` 等），因此 `mut operator func +=` 无法显式定义。v4 将标注和实现重心从复合赋值移到二元运算符——二元运算符在定义时标注 `@OverflowWrapping`，编译器自动生成复合赋值版本。此方案消除了 v3 中的可行性错误，同时保持 wrapping 语义的精确可控。

关于 roadmap §0.5.1 的差异：roadmap 推荐在复合赋值上标注、二元运算符委托的模式在仓颉中不可行（复合赋值不可显式定义）。本设计采用的"二元运算符直接标注"方案与 roadmap 在运行时语义等价——标注继承机制确保复合赋值自动获得 wrapping 语义，与 roadmap 的最终效果一致。

### D4. 仓颉原生类型名 vs GLM 兼容别名

**决策**：`package glm.detail` 内部直接使用 `Int32`/`Float32` 等仓颉原生类型名；`package glm` 中通过 `type` 别名提供 `int32`/`f32` 等 GLM 兼容命名。

**理由**：`package glm.detail` 是内部实现，应遵循仓颉语言惯例和最佳实践。`package glm` 是公共 API，需保持与现有 GLM 用户代码的兼容性。适当分离内部实现命名和外部接口命名。

### D5. 泛型约束粒度

**决策**：Vec 的 `T` 参数不做紧约束（不要求 `T <: Number<T>`），仅约束 `Q <: Qualifier`。

**理由**：GLM 的 vec 类型在 C++ 中对分量类型几乎不做约束（通过 SFINAE 校验有效性）。在仓颉中若对 `T` 加 `Number<T>` 约束，排除了 `Bool` 类型向量。宽松约束允许编译器在运算符函数体中因类型不支持运算报错，而非在类型定义处报错，与 C++ 模板的延迟检查行为一致。`ComputeEqual` 的浮点判定（`isIec559Of<T>()`）与 `NumericLimits` 的 `Number<T>` 约束解耦后，不再与 D5 冲突——对任意 `T`（含 `Bool`）均可编译通过（详见 D18）。

### D6. GLM_CONFIG_* 配置常量采用 const 声明

**决策**：将 C++ `#define` 宏映射为仓颉 `const` 常量（编译期常量），在 `setup.cj` 中集中声明。首轮所有配置取最保守值。

**理由**：`const` 常量是仓颉编译时求值的基本机制，可被 `if` 分支用于消除死代码（const 求值优化）。**作用域限制**：`const` 常量可用于全局、局部或静态成员（不可在扩展中声明）。`const + if` 的分支消除仅适用于函数体内的内联条件代码——在函数体外部（如顶层类型选择或成员定义）无法使用此模式。因此编译期类型选择（如 `ComputeEqual` 的浮点判定）必须在函数体内通过 `const if` 实现，而非在泛型参数约束或类型定义层面。

**18 个 GLM_CONFIG_* 常量完整清单**（与 v3 一致，子常量均已替换为字面量）：

| GLM 宏名 | 仓颉等效常量名 | 首轮推荐值 | 用途说明 |
|---------|--------------|-----------|---------|
| `GLM_CONFIG_SWIZZLE` | `const GLM_CONFIG_SWIZZLE: Int64` | `2` | 控制 swizzle 操作：0=operator, 1=function, 2=disabled。首轮必须设为 disabled。对应 C++ `GLM_SWIZZLE_DISABLED`=2 |
| `GLM_CONFIG_SIMD` | `const GLM_CONFIG_SIMD: Bool` | `false` | 控制 SIMD 指令集启用。首轮必须设为 false 以避免 `type_vec_simd.inl` 依赖。对应 C++ `GLM_DISABLE` |
| `GLM_CONFIG_ALIGNED_GENTYPES` | `const GLM_CONFIG_ALIGNED_GENTYPES: Bool` | `false` | 控制对齐类型（aligned/packed）。首轮使用非对齐默认布局 |
| `GLM_CONFIG_ANONYMOUS_STRUCT` | `const GLM_CONFIG_ANONYMOUS_STRUCT: Bool` | `false` | 控制匿名 struct 特性。仓颉不支持，首轮禁用 |
| `GLM_CONFIG_UNRESTRICTED_GENTYPE` | `const GLM_CONFIG_UNRESTRICTED_GENTYPE: Bool` | `false` | 控制泛型类型约束松弛。首轮遵循 GLSL 严格约束 |
| `GLM_CONFIG_UNRESTRICTED_FLOAT` | `const GLM_CONFIG_UNRESTRICTED_FLOAT: Bool` | `false` | 控制浮点类型约束松弛。首轮遵循 GLSL 严格约束 |
| `GLM_CONFIG_CLIP_CONTROL` | `const GLM_CONFIG_CLIP_CONTROL: Int64` | `0x0A`（十进制 10） | 裁剪空间约定（LH/RH, NO/ZO 位组合）。对应 C++ `RH_BIT(8) \| NO_BIT(2)` = 0x0A，首轮使用默认 RH_NO。**默认值来源说明**：GLM 1.0.3 `setup.hpp` 中的 `GLM_CONFIG_CLIP_CONTROL` 默认值由两层条件编译决定——首先判断 `GLM_FORCE_DEPTH_ZERO_TO_ONE` 设置 `ZO_BIT`/`NO_BIT`，再判断 `GLM_FORCE_LEFT_HANDED` 设置 `LH_BIT`/`RH_BIT`。在无额外定义时，两层条件编译均走 `#else` 分支，最终等效于 `RH_NO = 0x0A`。**与 roadmap 差异说明**：roadmap §3A.1 记录该配置默认值为 `0x02`，但经分析 GLM 1.0.3 参考实现的条件编译逻辑，`GLM_FORCE_DEPTH_ZERO_TO_ONE` 和 `GLM_FORCE_LEFT_HANDED` 在默认未定义时均走非激活分支，最终值为 `RH_BIT(8) | NO_BIT(2) = 0x0A`。文档值 `0x0A` 已验证正确，roadmap 值 `0x02` 有误。此差异已在文档中标注，编码阶段以本设计文档为准 |
| `GLM_CONFIG_CONSTEXP` | `const GLM_CONFIG_CONSTEXP: Bool` | `false` | 控制 constexpr 标识函数。仓颉中 `const` 函数编译期求值可替代 |
| `GLM_CONFIG_XYZW_ONLY` | `const GLM_CONFIG_XYZW_ONLY: Bool` | `false` | 控制仅 xyzw 分量命名模式。首轮使用完整 rgba/stpq 命名 |
| `GLM_CONFIG_CTOR_INIT` | `const GLM_CONFIG_CTOR_INIT: Int64` | `0` | 控制构造函数初始化策略。首轮不依赖特定初始化。对应 C++ `GLM_CTOR_INIT_DISABLE`=0 |
| `GLM_CONFIG_DEFAULTED_FUNCTIONS` | `const GLM_CONFIG_DEFAULTED_FUNCTIONS: Bool` | `false` | 控制 C++11 defaulted 函数 |
| `GLM_CONFIG_DEFAULTED_DEFAULT_CTOR` | `const GLM_CONFIG_DEFAULTED_DEFAULT_CTOR: Bool` | `false` | 控制 defaulted 默认构造函数 |
| `GLM_CONFIG_LENGTH_TYPE` | `const GLM_CONFIG_LENGTH_TYPE: Int64` | `1` | 控制 `length_t` 类型选择：1=int（有符号），2=size_t（无符号）。对应 C++ `GLM_LENGTH_INT`=1，首轮使用有符号 Int64 |
| `GLM_CONFIG_PRECISION_BOOL` | `const GLM_CONFIG_PRECISION_BOOL: Int64` | `3` | 控制 bool 类型默认精度等级。对应 C++ `GLM_HIGHP`=3 |
| `GLM_CONFIG_PRECISION_INT` | `const GLM_CONFIG_PRECISION_INT: Int64` | `3` | 控制 int 类型默认精度等级。对应 C++ `GLM_HIGHP`=3 |
| `GLM_CONFIG_PRECISION_UINT` | `const GLM_CONFIG_PRECISION_UINT: Int64` | `3` | 控制 uint 类型默认精度等级。对应 C++ `GLM_HIGHP`=3 |
| `GLM_CONFIG_PRECISION_FLOAT` | `const GLM_CONFIG_PRECISION_FLOAT: Int64` | `3` | 控制 float 类型默认精度等级。对应 C++ `GLM_HIGHP`=3 |
| `GLM_CONFIG_PRECISION_DOUBLE` | `const GLM_CONFIG_PRECISION_DOUBLE: Int64` | `3` | 控制 double 类型默认精度等级。对应 C++ `GLM_HIGHP`=3 |

18 个常量集中在 `setup.cj` 中声明。首轮所有 `GLM_CONFIG_*` 取最保守值（如 `SIMD=false`、`SWIZZLE=2`），确保最小依赖闭合。`setup.cj` 不包含类型别名或 `assert` 函数（分别归入 `shim_cstddef.cj` 和 `shim_assert.cj`）。

**子常量编码策略**：上表中所有 C++ 宏常量（`GLM_SWIZZLE_DISABLED`、`GLM_DISABLE`、`GLM_HIGHP`、`GLM_LENGTH_INT`、`GLM_CTOR_INIT_DISABLE`、`RH_BIT(8)`、`NO_BIT(2)` 等）在首轮 `setup.cj` 中**统一采用字面量替换**，不定义对应的独立命名常量。理由：① 这些 C++ 宏在 GLM 中为 `#define` 整数值，在其余首轮源代码中不被直接引用（`GLM_CONFIG_*` 值仅在 `setup.cj` 中定义，首轮 Vec 运算符不依赖 C++ `GLM_ARCH`/`GLM_HAS_CONSTEXPR` 等检测宏的值）；② 后续轮次引入平台检测或 SIMD 路径时，如需引用这些子常量对应值，可在对应轮次的 `setup.cj` 更新中补充命名常量定义；③ 字面量直接写在配置表中，编码阶段无需查找外部宏定义即可获得完整常量值。

**`GLM_CONFIG_CLIP_CONTROL` 类型选择**：采用 `Int64` 而非自定义 enum。该配置值为位掩码（由 `LH_BIT`/`RH_BIT`/`ZO_BIT`/`NO_BIT` 按位或组合），`Int64` 类型直接匹配位运算语义。C++ GLM 中该宏定义为整数 `#define` 常量值的组合，映射到 `Int64` 是最直接的一对一对应。

### D7. Functor 不直接映射 C++ `<functional>` 中的 `std::plus<T>` 等

**决策**：functor 的 `call` 方法直接接受 lambda 或函数引用作为参数，不引入 `std::plus` 等函数对象的直接等效。

**理由**：仓颉无 `std::plus`，但函数类型 `(T, T) -> T` 和 lambda 表达式可直接作为参数传递。泛型 functor 接收 `F: (T, T) -> T` 类型的函数参数即可。对比 C++ 需要 `std::plus<T>`（一个标准函数对象类型），仓颉更简洁——直接在调用点使用 `{ a, b => a + b }` 或运算符引用。

### D8. var 数据成员对 let 绑定变量的影响

**决策**：Vec 结构体的数据成员全部声明为 `var`（无初始值）。

**理由**：编译器自动生成的复合赋值运算符需要能够修改 Vec 实例的成员。若使用 `let` 声明成员，则即使通过 `var` 绑定的结构体变量也无法执行复合赋值（`var` 绑定允许调用 `mut` 函数，但 `mut` 函数不能修改 `let` 成员）。将数据成员声明为 `var`，使得 `var v = Vec2(...)` 可以正常执行 `v += 1` 等自动生成的复合赋值。对于 `let v = Vec2(...)` 的变量，复合赋值触发编译错误，这与 C++ 中 `const` 向量不能执行 `op=` 的行为一致。

数据成员无初始值的决定：避免为默认构造函数引入不合理的约束。调用方需显式构造，使用标量填充构造 `Vec2(T(0))` 作为默认值替代。

### D9. `!=` 运算符的实现形态

**决策**：`!=` 定义为 `!(a == b)`。

**理由**：仓颉语言中不存在 `!==` 运算符。将 `!=` 重载为对 `==` 结果取反的语义是最直接且正确的实现。这一实现与 C++ GLM 中 `operator!=` 的语义等价。

### D10. 标量在左的运算无法重载

**决策**：不支持 `scalar + vec`、`scalar / vec` 等左标量右向量的运算符重载形式，以具名函数替代。

**理由**：仓颉的运算符重载要求运算符函数定义在左操作数类型的作用域内。标量类型（如 `Float32`）的 `+` 运算符无法由本包通过 `extend` 扩展（标量类型本身不在此包中定义，且扩展运算符重载也不被允许创建新的重载覆盖原生类型已有运算符）。因此 `scalar + vec` 模式不可实现。提供 `add(scalar, vec)` 和 `add(vec, scalar)` 双向具名函数覆盖两种操作数顺序。同样，`div`、`sub`、`mul`、`mod` 等也需提供双向重载。

### D11. 引入 `const init` 支持编译期分支

**决策**：为每个 Vec 结构体定义 `const init` 构造函数，移除与 `const init` 参数列表相同的普通 `init`。所有 `const init` 构造函数均显式声明为 `public`。

**理由**：仓颉语言要求仅当 struct 定义了 `const init` 时，才能定义 `const` 实例成员函数。`const` 实例成员函数（如 `==`）可以在函数体内使用 `const if` 实现编译期分支，零运行时开销地选择浮点容差比较路径或精确比较路径。`const init` 在非 const 上下文中同样可用于运行时构造（const README §3.2 规则 5），因此同参数列表的普通 `init` 不再需要。仓颉函数重载规则中 `const` 修饰符不构成区分依据（const README §3.2 规则 7），若同时保留二者将导致重复定义编译错误。移除冗余额外的普通 `init`，仅保留 `const init` 即可覆盖所有构造场景。

### D12. `&&`/`||`/`~` 以具名函数替代运算符重载

**决策**：`&&`、`||`、`~` 不可作为运算符重载，以具名函数 `logicalAnd`、`logicalOr`、`bitwiseNot` 替代。

**理由**：仓颉可重载运算符列表为：`()`、`[]`、`!`、`-`（一元）、`**`、`*`、`/`、`%`、`+`、`-`（二元）、`<<`、`>>`、`<`、`<=`、`>`、`>=`、`==`、`!=`、`&`、`^`、`|`。该列表不包含 `&&`、`||`、`~`，因此无法为 Vec 类型重载这些运算符。具名函数在语义上等价，且可通过函数重载支持多参数形式。

### D13. `%` 运算符的可用性约束

**决策**：`%` 在 Vec 结构体上定义为逐分量取模运算符。对于整数 `T` 实例正常编译；对于浮点 `T` 实例在实例化时产生编译错误（因仓颉原生浮点类型不支持 `%`）。

**理由**：采用 D5 的宽松约束策略——`T` 在 Vec 结构体上不做紧约束，`%` 运算符体中使用 `T % T` 表达式。编译器在定义处通过语法检查，在实例化处验证语义。此行为与 C++ 模板的延迟检查一致（`std::vector<float> v; v % v;` 在 C++ 中同样在实例化处报错）。对于需要浮点取模的场景，使用具名函数 `mod`（属于首轮范围）。

### D14. 跨 Vec 类型转换不使用子类型约束

**决策**：跨 Vec 转换构造不使用 `where T2 <: T` 约束，改用无约束泛型 + `T(v)` 显式转换。

**理由**：仓颉原始数值类型间不存在子类型关系。`Int8` 不是 `Int32` 的子类型，因此 `where T2 <: T` 约束无法用于数值类型的跨类型 Vec 构造。改为无约束泛型参数，在构造函数体内对各分量调用 `T(v2.x)` 等显式类型构造函数，由仓颉的类型构造函数转换规则处理数值类型间的转换。这种方式的语义与 C++ `static_cast` 更为一致。

### D15. 跨类型运算不支持

**决策**：二元运算符不支持跨类型操作数（如 `Vec2<Int32> + Vec2<Int16>`）。

**理由**：仓颉运算符重载不能为泛型（不能引入新类型参数）。Vec 的 `operator +` 只能接受 `VecN<T, Q>` 类型的右操作数（`T` 和 `Q` 与左操作数相同）。对于跨类型运算，调用方必须使用跨 Vec 转换构造函数先将操作数转为同一类型。此限制在迁移时需通过搜索替换规则处理（详见 §11 迁移成本评估）。

### D16. Functor/ComputeVec 首轮仅定义不消费；scalar-op-vec 辅助函数独立于 scalar_vec_ops.cj 首轮消费

**决策**：`vectorize.cj` 和 `compute_vector_decl.cj` 中的类型在首轮的行为分为两类：

1. **`compute_vec_*` 策略结构体**（如 `compute_vec_add`、`compute_vec_sub` 等）和 **Functor 类型**：首轮仅定义结构体，不被 Vec 运算符实现调用，为后续 SIMD 轮次预留。定义在 `compute_vector_decl.cj` 和 `vectorize.cj` 中。
2. **`scalar-op-vec` 方向辅助函数**（如 `add(s, v)`、`sub(s, v)` 等）：独立为 `scalar_vec_ops.cj` 文件，首轮即被消费——Vec 使用者在 `scalar + vec` 等场景中需调用它们。该文件与 `compute_vector_decl.cj` 职责清晰分离：前者专注方向辅助函数，后者专注策略结构体。

**理由**：首轮 Vec 运算符实现直接使用泛型算术运算符逐分量运算，无需通过 ComputeVec* 或 Functor 委托。方向辅助函数（`add(s, v)` 等）是 `scalar + vec` 运算符重载不可实现的替代方案，属于首轮公共 API 的必要部分。Functor 和 ComputeVec 为后续 SIMD 轮次、swizzle 操作轮次或性能优化轮次预留。将方向辅助函数独立为 `scalar_vec_ops.cj` 消除了 `compute_vector_decl.cj` 的双重角色架构层次模糊问题（§2 模块划分中独立文件的依赖关系更清晰）。首轮定义它们可以尽早验证其在仓颉类型系统中的可行性，但运算符代码不引用它们。后续轮次引入 SIMD 路径时，可将 Vec 运算符实现重构为通过 ComputeVec* 委托，利用 Functor 实现函数映射。

### D17. 跨类型赋值语义

**决策**：不提供跨类型 `=` 赋值（`VecN<Int32, Q> = VecN<Float32, Q>`）。跨类型赋值要求调用方显式使用跨 Vec 转换构造函数转换后赋值。

**理由**：仓颉 struct 的 `=` 赋值运算符由编译器自动生成，且仅接受完全相同类型的右操作数。无法为 Vec 泛型结构体重载自定义 `=` 以支持跨类型赋值。三种候选方案中：① 显式转换后赋值（采用）——调用方编写 `v = Vec2<Int32, Q>(w)` 将 `Vec2<Float32, Q>` 转换为 `Vec2<Int32, Q>` 后再赋值，转换语义清晰无歧义；② 定义泛型 `=` ——仓颉运算符不能为泛型，不可行；③ 记录为已知差异——在迁移成本评估中标注此差异。选用方案①，因为语义最明确且与 D14（跨 Vec 转换构造）和 D15（跨类型运算不支持）的设计一致。

### D18. `NumericLimits` 与宽松泛型约束的兼容性

**决策**：将 `NumericLimits<T>` 拆分为两个独立部分——保留 `NumericLimits<T> where T <: Number<T>` 用于数值极限查询，新增无约束的 `isIec559Of<T>()` 函数用于浮点类型判定。

**理由**：`ComputeEqual<T>` 的 `if (isIec559Of<T>())` 需要在不约束 `T` 的前提下判断 `T` 是否为浮点类型。若使用 `where T <: Number<T>` 约束，`Bool` 作为 `T` 时将编译失败（`Bool` 不实现 `Number<T>`）。将 `isIec559` 分离为独立的无约束函数，与 `NumericLimits` 的 `max()`/`min()`/`epsilon()` 等需要数值运算支持的功能解耦。此拆分后，`NumericLimits<T>` 仅在需要数值极限的浮点路径中被引用（由 `const if` 在编译期已排除非浮点分支），因此 `Number<T>` 约束在浮点 `T` 上自然满足，不会产生编译错误。

### D19. `isIec559Of<T>()` 的实现方案选择

**决策**：采用 `const if` 配合 `is` 运算符的值级类型检测方案。

**理由**：仓颉泛型函数的重载规则禁止按类型参数约束进行重载（类型变量约束不参与重载解析判断），因此 v5 描述的"为每类数值类型提供重载函数"的路径不可行。三种可行方案的分析：

| 方案 | 描述 | 评估 |
|------|------|------|
| ① `const if` + `is` 运算符值级检测（采用） | `if (T(0) is Float64 \|\| T(0) is Float32)` | 无重载依赖，完全在仓颉 const 表达式约束内——`is` 属于可参与 const 表达式的运算符，`T(0)` 为合法的 const 构造表达式（数值/布尔类型的构造函数在 const 上下文中可用）。编码阶段需验证所有目标类型是否支持 `T(0)` const 构造。 |
| ② 放弃编译期分支 | 所有类型统一使用 `==` 精确比较 | 功能正确但丢失浮点容差比较优势。可作为备选回退路径。 |
| ③ 反射或注解方式 | 运行时通过 `TypeInfo` 或自定义注解实现 | 引入运行时开销，背离编译期零开销的设计目标。 |

采用方案①，理由：保持编译期零开销类型分发，不依赖语言尚未确认的特性，实现模式与 `const if` 的现有语义一致。

### D20. `VecN<Bool, Q>` 的完整行为约定集中化

**决策**：在 §3.2 中集中描述 `VecN<Bool, Q>`（指 Vec1~Vec4 分别以 Bool 为 T 参数的实例）的完整行为约定，各运算符章节仅引用之。

**理由**：Bool 分量 Vec 在不同运算符类别中表现出不同的行为模式（部分可编译、部分不可编译），分散描述易导致遗漏或矛盾。统一在 Vec 结构体系的总体描述中给出完整表格，各运算符章节以"详见 §3.2 VecN<Bool, Q> 行为约定"方式引用，确保一处定义、各处同步。

### D21. `operator[]` 索引类型选择

**决策**：索引类型统一采用 `Int64`。

**理由**：① `LengthT` 别名为 `Int64`，`length()` 返回值也是 `Int64`，保持一致避免有符号/无符号比较告警；② `Int64` 为仓颉默认整数类型，在所有目标平台上覆盖所有有效索引范围（Vec1~Vec4 的索引 0~3）；③ 与 GLM 默认 `length_t = int`（有符号整数）行为一致。

### D22. `<`/`<=`/`>`/`>=` 运算符首轮不提供

**决策**：首轮不定义 `<`/`<=`/`>`/`>=` 运算符。

**理由**：C++ GLM 的 Vec 类型上未定义这些运算符。若在仓颉中定义则需要决定语义是聚合比较还是逐分量比较——前者与 GLM 行为不一致，后者在仓颉中（返回 `VecN<Bool, Q>`）无法直接用于 `if` 条件。首轮保留 `==` 和 `!=`（返回 `bool` 的聚合比较），逐分量比较功能随后续函数库轮次（`vector_relational.hpp` 的 `lessThan`/`greaterThan` 等具名函数）一并迁移。

### D23. C++ `storage<L,T,Q>` 模板省略理由

**决策**：首轮不映射 `storage<L,T,Q>` 模板结构体。

**理由**：`storage` 是 C++ 中用于在不同条件下（非对齐/对齐/SIMD）选择底层数据类型的辅助类型。仓颉 Vec 结构体的数据成员直接声明为 `var x: T` 等形式，编译器自动负责内存布局和对齐，无需手动选择存储类型。`storage` 的 SIMD 特化路径待后续 SIMD 支持轮次时重新设计。

### D24. `genTypeTrait`/`find_best_type` 等辅助设施省略理由

**决策**：首轮不迁移 `genTypeTrait`、`init_gentype`、`find_best_type` 等类型查询设施。

**理由**：这些设施服务于矩阵和四元数类型的泛型代码（如 `init_gentype` 为矩阵和四元数提供 `identity()` 方法），首轮范围不包含这些类型。这些辅助设施将在第 2-3 轮（矩阵/四元数迁移）时随对应类型定义一并引入。首轮 `qualifier.cj` 中保留 `vec`/`mat`/`qua` 的注释性前向声明即可。

### D25. `VecN<Bool,Q>.bitwiseNot()` 的行为差异认定

**决策**：`bitwiseNot()` 对 `VecN<Bool, Q>` 可编译通过，但声明为**不可消除的已知行为差异**而非语义等价。

**理由**：C++ GLM 中 `~bvec` 因整数提升机制（`bool` → `int` → 按位取反 → 转换回 `bool`，非零即 `true`）对任一分量始终返回 `true`。仓颉中 `!Bool` 执行逻辑否定（`!true = false`，`!false = true`），两种行为完全相反。此差异无法通过类型系统消除——仓颉不支持偏特化或负向约束（`where` 子句无法表达"当 T != Bool 时定义"），因此无法在类型层面条件性地为 `VecN<Bool, Q>` 排除 `bitwiseNot()`。将 `bitwiseNot()` 对 `Bool` 的行为认定为不可消除的已知差异而非等价迁移，迁移 `~bvec` 时需要人工审查并按上下文选择替换方式（详见 §11.4）。

### D26. 跨类型构造函数标量参数使用目标类型

**决策**：跨类型构造函数中的所有标量参数使用目标分量类型 `T`，而非源分量类型 `T2`。

**理由**：C++ GLM 的跨类型构造中，标量参数虽然声明为 `T2` 类型，但因 C++ 隐式类型转换规则自动转换到目标类型 `T`。仓颉无隐式数值类型转换，若标量参数保持 `T2` 类型，调用方必须将标量值显式构造为 `T2` 类型再传入，与 GLM 的"标量可自然使用目标类型字面量"的调用体验不一致。将标量参数改为 `T` 类型后，调用方可直接使用目标类型的字面量或变量，构造函数体内通过 `T(scalar)` 完成转换（若需跨类型转换）。Vec 类型参数（如 `Vec2<T2, Q2>`）保持 `T2` 不变，因构造函数体内需对 Vec 分量逐一调用 `T(v.x)` 进行类型转换。

### D27. Qualifier 跨 Q 赋值/转换行为约定

**决策**：首轮中不同 Qualifier 之间的赋值和转换默认允许，无运行时或编译期限制。后续轮次引入 Qualifier 差异化时重新评估此约定。

**理由**：首轮所有 Qualifier 实现类型（PackedHighp、PackedMediump、PackedLowp、AlignedHighp 等）均为空结构体，无运行时数据差异。跨 Q 赋值（如 `Vec2<Float32, PackedHighp>` 赋给 `Vec2<Float32, PackedLowp>` 类型变量）在数据语义上等价于同 Q 赋值——仅类型签名改变。Vec 的跨类型转换构造函数（`init<T2, Q2>(v: VecN<T2, Q2>) where Q2 <: Qualifier`）在类型层面已允许 Q2→Q 的转换。若在首轮禁止跨 Q 转换（如通过 `static assert` 限制特定 Q 组合），将增加不必要的复杂性且无实际收益。后续轮次引入差异化行为时，可按需通过编译期约束（如 `where` 条件、宏或自定义注解）重新限制跨 Q 转换路径。

### D28. `operator[]` const 取值形式与赋值形式

**决策**：`operator[]` 的取值形式不标注 `const`，另提供具名 const 函数 `componentAt(i: Int64): T` 满足 const 上下文中的分量访问；赋值形式声明为 `mut operator func`。

**理由**：
- **const 取值形式不可通过重载实现**：仓颉的函数重载规则中，`const` 修饰符不构成重载区分依据（const README §3.2 规则 7），因此无法同时定义 `const operator func [](i: Int64): T` 和 `operator func [](i: Int64): T` 两个版本的 `[]` 运算符。
- **`componentAt` 替代方案**：提供 `public const func componentAt(i: Int64): T` 具名函数，满足 const 实例成员函数中通过索引访问分量的需求。该函数支持 `const if` 编译期分支，与非 const 的 `operator[]` 取值形式共享同一实现体（含边界断言）。
- **赋值形式须为 `mut`**：仓颉 struct 的普通（非 `mut`）实例成员函数不能修改实例成员。`operator[]` 赋值形式需要修改第 i 分量的值，因此必须标注 `mut` 修饰符。否则 `v[i] = val` 将无法编译通过（struct 的 `let` 绑定变量上调用 `mut` 函数报错，`var` 绑定变量上调用非 `mut` 函数无法修改成员）。此规则同样适用于 extend 块中定义的 `[]` 赋值形式——extend 块中的 `operator func []` 赋值形式同样需要 `mut` 修饰符方可修改实例成员。

### D29. `const operator ==` 的表达式链 const 兼容性要求（含回退触发条件）

**决策**：`ComputeEqual<T>.callConst` 中 `const operator ==` 的完整表达式链需系统性标注每项的 const 兼容性。回退方案采用**二值决策**——验证通过则维持当前设计，否则整体回退到精确比较路径。

**理由**：`const operator ==` 体内表达式链 `abs(a - b) <= epsilonOf<T>()` 的每个环节必须支持在 `const` 函数上下文中编译通过。各环节的 const 兼容性要求及验证状态如下：

| 表达式环节 | const 兼容性要求 | 验证状态 | 回退方案 |
|-----------|----------------|---------|---------|
| `T(0) is Float64`（编译期类型检测） | 数值类型的 `T(0)` const 构造 + `is` 运算符 | 待验证（需原型测试，见 §10 设计阶段验证要求） | 任一环节不可用 → 整体回退到所有类型精确比较 `a == b` |
| `a - b`（浮点减法） | 仓颉 `Float32`/`Float64` 的二元 `-` 可在 const 函数体内调用 | 待验证（需原型测试） | 同上 |
| `abs(x)`（绝对值） | `Float32.abs()` / `Float64.abs()` 静态方法须为 `const` 函数 | 待验证（需原型测试） | 同上。若仅 `abs()` 非 const，可内联 `x >= T(0) ? x : -x` 尝试局部修复 |
| `epsilonOf<T>()`（获取 epsilon） | `NumericLimits<T>.epsilon()` 须为 `const` 函数。且 `NumericLimits<T> where T <: Number<T>` 的约束在此路径中自动满足（`const if` 确保仅浮点类型进入此分支） | 待验证（需原型测试） | 同上。若仅 `epsilon()` 非 const，可尝试固定容差值 `T(1e-6)` 局部修复 |
| `result <= epsilon`（比较） | `Float32`/`Float64` 的 `<=` 可在 const 函数体内调用 | 可确认（仓颉 `<=` 为原生比较运算符，在 const 上下文中可用） | 无 |

**验证决策**：编码阶段编写单一原型测试函数，在 `const` 上下文中一次性验证完整表达式链 `abs(a - b) <= epsilonOf<T>()` 的编译通过性。若编译通过 → 维持当前设计。若编译失败 →**整体回退到备选路径**（所有类型使用精确比较 `a == b`），浮点容差比较通过独立的非 `const` 具名函数（如 `equalEpsilon`）提供。不再细分逐级修复方案——`abs()` 内联或 `epsilon()` 固定值替代作为编码阶段的局部优化尝试，不属于设计层面的回退路径。

### D30. `@OverflowWrapping` 标注继承性验证计划

**决策**：在 §4.6 中补充备选方案——若 `@OverflowWrapping` 标注继承性经验证不成立，则在已有 20 个 vec-op-scalar 方向扩展成员函数（§4.3 首轮范围）上直接标注 `@OverflowWrapping`，二元运算符委托给这些函数。

**理由**：当前设计断言编译器自动生成的复合赋值版本继承二元运算符上的 `@OverflowWrapping` 标注。此行为**依赖编译器的未文档化行为**——仓颉注解文档声明溢出注解"只能标记于函数声明上"，但未说明自动生成的复合赋值函数是否继承源运算符的注解。此继承性在仓颉语言层面既未确认也未否认。因此需要：
1. **编码前验证**：编写原型测试代码，验证二元算术运算符上的 `@OverflowWrapping` 标注是否能被编译器自动生成的复合赋值版本继承。测试核心：对自定义 struct 定义标注 `@OverflowWrapping` 的 `+` 运算符，验证 `+=` 在溢出时执行 wrapping 而非 throwing。
2. **备选方案（若继承性不成立）**：在已有 20 个 vec-op-scalar 方向扩展成员函数（`add(v,s)`/`sub(v,s)`/`mul(v,s)`/`div(v,s)`/`mod(v,s)`，§4.3 已纳入首轮范围）上直接标注 `@OverflowWrapping`，二元运算符委托给这些已标注的函数。此方案无需新增函数定义——add/sub/mul/div/mod 的 vec-op-scalar 方向扩展成员函数已存在，仅需补充 `@OverflowWrapping` 标注并将运算符委托目标从"直接逐分量运算"改为"调用已标注的扩展成员函数"。此方案虽失去运算符语法糖，但确保溢出语义精确可控。备选方案的额外工作量已纳入 §11.6 迁移成本评估（由于函数已定义，实际工作量低于原评估的"新增 20 个函数"）。

**决策路径**：原型验证优先。若标注继承性成立，维持当前设计（二元运算符直接标注，复合赋值自动继承）。若不成立，切换到备选方案（具名函数 + 运算符委托）。

#### D30 与 D29 组合回退场景分析

D29（const 表达式链验证）和 D30（@OverflowWrapping 继承性验证）各自定义了独立回退方案。两者可能同时失败，需评估组合回退的交互影响。

**组合回退的三种可能状态**：

| D29 状态 | D30 状态 | 组合结果 | 影响评估 |
|---------|---------|---------|---------|
| ✅ 通过 | ✅ 通过 | 维持当前设计 | 无影响 |
| ❌ 回退 | ✅ 通过 | `==` 退至精确比较；算术运算符及复合赋值保持当前 `@OverflowWrapping` 标注策略 | 两项回退独立——D29 影响比较路径选择，D30 影响算术溢出策略，互不干扰 |
| 任意 | ❌ 回退 | 算术运算通过已有扩展成员函数实现（补充 `@OverflowWrapping` 标注）；`==` 依 D29 状态选择路径 | 扩展成员函数中的算术运算不受 D29 影响（比较与算术独立）；注意：add/sub/mul/div/mod 扩展成员函数已在 §4.3 中定义为首轮范围，回退仅需补充标注而非新增函数 |

**交互分析**：两项回退独立正交，无冲突。D29 控制比较语义（容差 vs 精确），D30 控制算术溢出策略（运算符标注 vs 扩展成员函数标注），影响的运算类别不重叠。当两者同时触发时，`==` 使用精确比较（非容差路径），算术运算通过已标注 `@OverflowWrapping` 的扩展成员函数实现。此组合在运行时语义上等价于"所有类型使用精确比较 + 算术运算通过扩展成员函数 wrapping"——虽损失容差比较优势和运算符语法糖，但功能正确性不受损。**复杂度成本**：编码阶段需同时实现 D29 的 `equalEpsilon` 独立函数和 D30 的补充标注（20 个已有函数补充 `@OverflowWrapping` + 修改 5 个运算符的委托目标），合计约 1-2 人天额外工作量（已在 §11.6 评估中覆盖）。注意：由于 add/sub/mul/div/mod 的 vec-op-scalar 方向扩展成员函数已在 §4.3 中定义为首轮范围，D30 回退**无需新增函数定义**。此前的"新增 20 个具名函数"评估已在 v9 中修正。**建议**：编码阶段按 D29 → D30 顺序逐项验证，一项失败后再进入下一项的组合验证，降低并行失败的信息熵。

#### 「const 在 extend 块中不可用」与 D30 交互说明

D30 备选方案（通过 extend 块中的具名函数实现 Vec 算术运算）中，算术具名函数因定义在 `extend` 块中已声明为非 `const` 函数（§4.3 明确区分了扩展成员函数为非 `const`、包级独立函数为 `const`）。此约束已由 §7 D32/D33 统一处理，D30 备选方案不依赖这些函数的 `const` 声明——`@OverflowWrapping` 标注与非 `const` 函数兼容（溢出注解语法独立于 `const` 修饰符），算术语义不受影响。因此 `const` 在 extend 块中不可用与 D30 回退路径无交互冲突。**组合回退场景的三种可能状态**扩展如下：

| D29 状态 | D30 状态 | const-in-extend 状态 | 组合结果 | 影响评估 |
|---------|---------|---------------------|---------|---------|
| ✅ 通过 | ✅ 通过 | 不可用（已确认） | 维持当前设计 | const-in-extend 限制已通过 D32/D33 统一处理，不影响设计与算术运算符 |
| ❌ 回退 | ✅ 通过 | 不可用（已确认） | `==` 退至精确比较；算术运算符及复合赋值保持当前 `@OverflowWrapping` 标注策略 | 两项独立，互不干扰 |
| 任意 | ❌ 回退 | 不可用（已确认） | 算术运算通过已有扩展成员函数实现（补充 `@OverflowWrapping` 标注）；`==` 依 D29 状态选择路径 | const-in-extend 不影响扩展成员函数的功能正确性——`@OverflowWrapping` 和非 `const` 函数兼容；注：add/sub/mul/div/mod 扩展成员函数已在 §4.3 中定义为首轮范围，回退无需新增 |

结论：`const` 在 extend 块中不可用的约束已由本设计的全局策略（所有扩展成员函数声明为非 `const`）统一处理，D30 回退路径中的算术扩展成员函数属于此策略覆盖范围，无需额外回退。

### D31. 跨类型 fill-from-Vec1 构造器的重载冲突约束

**决策**：Vec2~Vec4 的 fill-from-Vec1 构造器仅提供同类型版本 `public init(v: Vec1<T, Q>)`，不提供跨类型版本 `public init<T2, Q2>(v: Vec1<T2, Q2>)`。

**理由**：仓颉函数重载规则中，当泛型参数被实例化为具体类型时，重载解析按实际类型匹配。若同时存在 `public init(v: Vec1<T, Q>)` 和 `public init<T2, Q2>(v: Vec1<T2, Q2>) where Q2 <: Qualifier`，在 `T2 = T` 且 `Q2 = Q` 的场景下两个构造函数具有相同的参数列表（`Vec1<T, Q>`），导致重载冲突编译错误。受仓颉泛型实例化的重载解析规则限制，此冲突无法通过添加额外泛型约束（如 `where T2 != T`）解决——仓颉的 `where` 子句不支持否定约束或不等约束。

因此当前设计仅保留同类型版本，跨类型 fill-from-Vec1 场景可通过其他构造函数形式覆盖（如 Vec4 可通过 `Vec4(v1_x, v1_y, v1_z, v1_w)` 组合构造或通过 `init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>, ...)` 等形式间接实现）。若编码阶段需要跨类型 fill-from-Vec1 构造，可通过将 Vec 类型变量显式转换为目标类型后调用同类型版本实现（`let v = Vec2<T, Q>(Vec2<T2, Q2>(src).x)` 等模式）。

### D32. 具名函数（add/sub/mul/div/mod）的 const 声明策略

**决策**：`add`、`sub`、`mul`、`div`、`mod` 的 `scalar-op-vec` 方向（包级独立函数）声明为 `const`；`vec-op-scalar` 方向（扩展成员函数）声明为非 `const`。

**理由**：仓颉 `extend` 块不支持 `const` 修饰符（仓颉扩展 §4.2），因此 `vec-op-scalar` 方向扩展成员函数无法声明为 `const`。`scalar-op-vec` 方向包级独立函数无此限制。`mod` 的包级独立函数方向使用 `if (isIec559Of<T>())` 实现整数/浮点双路径编译期分支选择，仓颉要求 `const if` 所在函数必须标注 `const` 修饰符，因此仅包级独立函数方向可以承载 `const if` 分支。扩展成员函数方向 `mod(v, s)` 仅提供整数路径（使用 `%`），浮点路径由包级独立函数 `mod(s, v)` 覆盖。

**`add`/`sub`/`mul`/`div` 包级独立函数的 const 声明**：虽不直接使用 `const if`，但声明为 `const` 有以下益处：① 与 `mod` 的 API 签名一致；② 允许在 const 表达式中调用 `add(s, v)` 等；③ 为后续轮次引入 const 路径优化预留扩展点。扩展成员函数方向（`v.add(s)` 等）因 `extend` 块限制声明为非 `const`，功能等价。

**const 兼容性验证要求**：20 个包级独立函数的 `const` 声明依赖目标类型 `T` 的算术运算符在 const 函数体内的可用性。20 个扩展成员函数因非 `const` 无此约束。验证计划如下：

| 验证项 | 验证方法 | 回退方案 |
|--------|---------|---------|
| `add`/`sub`/`mul`/`div` 包级独立函数对 `Float32`/`Float64`/`Int32` 等核心类型的 `const` 兼容性 | 编写原型测试实例化 `add`/`sub`/`mul`/`div` 各一种，确认 const 编译通过 | 若核心类型失败 → 包级独立函数降级为非 `const` |
| `mod` 包级独立函数对核心类型的 `const` + `const if` 兼容性 | 编写原型测试分别以 `Int32` 和 `Float32` 实例化 `mod`，确认 const if 分支选择正确 | 若失败 → 拆分为独立包级函数 `modInt`（非 `const`，使用 `%`）和 `modFloat`（非 `const`，使用 `trunc` 恒等式） |
| 扩展成员函数（非 `const`）的功能正确性 | 编写原型测试验证 `v.add(s)` 等扩展成员函数在运行时正确性 | 若扩展成员函数因语法错误不通过 → 改为包级独立函数，调用方通过 `add(v, s)` 语法使用 |

### D33. increment()/decrement()/bitwiseNot() 的 const 声明策略

**决策**：`increment()`、`decrement()`、`bitwiseNot()` 因定义在 `extend` 块中，受仓颉扩展语法限制（仓颉扩展 §4.2——`extend` 块不允许 `const` 修饰符），声明为**非 `const`** 函数。

**理由**：此三函数与 D32 中的算术具名函数同为纯函数——仅读取 Vec 分量值并返回新 Vec，不修改实例成员。但因定义位置在 `extend` 块中，`const` 修饰符不可用。此限制的影响：① 失去在 `const` 表达式中编译期调用的能力，运行时行为不受影响；② `increment()`/`decrement()` 标注 `@OverflowWrapping` 与是否 `const` 无关——`@OverflowWrapping` 为非 `const` 函数同样可用；③ `bitwiseNot()` 不涉及算术运算，无溢出注解需求。**备选方案**：若编码阶段需要在 `const` 上下文中调用这些函数，可将其定义移至 struct 体内（各 Vec 结构体自身定义该函数），利用 `const init` 声明为 `const` 实例成员函数。此备选方案适用于 `bitwiseNot()`（不依赖分量数差异），对 `increment()`/`decrement()` 同样可行。评估应在编码阶段按需决定是否实施。

### D34. `const if (...)` 文档简写约定

**决策**：设计文档中所有出现的 `const if (...)` 统一改写为 `if (...)`，不再使用"const if"作为独立关键字表示。文档中涉及编译期分支抑制行为描述时，使用"`const` 函数体内的 `if` 表达式"或"编译期 `if` 分支"等表述，而非"`const if` 关键字"。

**理由**：仓颉语言中不存在 `const if` 独立关键字。`if` 表达式在 `const` 函数体内天然具有编译期分支抑制行为——编译器仅在实例化后选择被满足的分支进行代码生成，非选择分支的代码不参与实际编译（仅做语法检查）。此行为已在仓颉 const 特性文档中确认：`const` 函数中的 `if` 条件若可在编译期确定，则仅编译被执行分支。文档此前使用 `const if (...)` 作为简写形式，可能误导实施者编写不存在的 `const if` 关键字。本决策统一修正此简写，消除实施歧义。

**验证状态**：编译期 `if` 分支抑制行为是 `const` 函数的固有语义，不依赖独立的关键字支持。§10 中列出的所有依赖点（A~E）的验证计划保持不变——验证对象为"`const` 函数中 `if` 表达式的编译期分支抑制行为"，与 `const if` 的命名无关。验证方法（统一原型测试 `testConstIfSuppression<T>()`）和回退方案均不受本次命名修正影响。

### D35. `scalar_vec_ops.cj` 的包级函数名独占权约定

**决策**：约定 `glm.detail` 包中仅 `scalar_vec_ops.cj` 文件有权定义名为 `add`、`sub`、`mul`、`div`、`mod` 的包级函数。`glm.detail` 包中的其他文件不得定义同名包级函数。

**理由**：`lib.cj` 通过 `public import glm.detail.{ add, sub, mul, div, mod }` 将这些函数暴露到 `package glm` 公共命名空间。`glm.detail` 包由 12+ 个文件组成，若未来其他文件也在同一包中定义同名函数，`public import` 将因 `glm.detail` 范围内的重名导致导入歧义。此约定以设计决策形式记录命名空间占用规则，确保编码阶段实施者和后续轮次维护者明确知晓 `add`/`sub`/`mul`/`div`/`mod` 五个名称的独占归属。此约定已在 §2 公共 API 面设计的命名空间占用声明中同步记录。

**违规检测**：编码阶段可通过在 `glm.detail` 包的其他文件中尝试定义名为 `add` 的函数来验证规则——若与 `scalar_vec_ops.cj` 中已有函数冲突，编译器将报重复定义错误。此检测由编译器自动完成，无需额外测试步骤。

---

## 8. 迁移文件清单与依赖拓扑

### 8.1 文件清单与 roadmap 子范围映射

| 序号 | 文件（package glm.detail） | 依赖 | 说明 | Roadmap 子范围 | Roadmap §3E 序号 |
|------|---------------------------|------|------|---------------|-----------------|
| 1 | `setup.cj` | 无 | 18 个 `GLM_CONFIG_*` 编译期常量 | S | 1（前身为 C++ `setup.hpp` 映射，shim 配置层） |
| 2 | `qualifier.cj` | `setup.cj` | `Qualifier` 接口及实现类型、V 前向声明注释 | 1 | 2 |
| 3 | `shim_assert.cj` | 无 | `assert()` 函数 | S | S1 |
| 4 | `shim_limits.cj` | 无 | `NumericLimits<T>`（含 `isIec559Of<T>()` 无约束 const 函数，`max/min/epsilon` 受 `Number<T>` 约束） | S | S2 |
| 5 | `shim_cstddef.cj` | 无 | `SizeT`/`LengthT` 别名（`VArray` 的 `size` 属性提供编译期长度查询） | S | S3 |
| 6 | `compute_vector_relational.cj` | `shim_limits.cj` | `ComputeEqual<T>`（简化版，无 `IsFloat` 参数） | 2a | 3 |
| 7 | `vectorize.cj` | `qualifier.cj` | Functor1~4 的 Vec1~Vec4 版本（为后续轮次预留） | 2a | 5 |
| 8 | `compute_vector_decl.cj` | `vectorize.cj` | ComputeVecAdd/Sub/Mul/Div/...（为后续轮次预留） | 2a | 4 |
| 8a | `scalar_vec_ops.cj`（新增） | `qualifier.cj`、**`std.math`** | scalar-op-vec 方向辅助函数（add(s,v)/sub(s,v)/mul(s,v)/div(s,v)/mod(s,v)，首轮即被消费）。注：浮点 `mod` 路径依赖 `std.math.trunc` | 2a（随 Vec 运算） | 新增 |
| 9~12 | `type_vec1.cj`~`type_vec4.cj` | `qualifier.cj` + `compute_vector_relational.cj` + `scalar_vec_ops.cj` | Vec 结构体定义（含 `const init`、`@OverflowWrapping` 二元算术运算符、`@OverflowWrapping` 对 `<<`）、extend 块（位运算符 + 具名函数 `increment`/`decrement`/`bitwiseNot`/`logicalAnd`/`logicalOr`） | 4~7 | 6~9 |

| 序号 | 文件（package glm） | 依赖 | 说明 | Roadmap 子范围 | Roadmap §3E 序号 |
|------|--------------------|------|------|---------------|-----------------|
| 13 | `lib.cj`（新增） | `glm.detail.*` + `glm.fwd` | 公共 API 重导出——通过 `public import` 暴露 Vec 类型、Qualifier 类型、`scalar_vec_ops` 方向辅助函数及 `fwd.cj` 中所有别名 | 8（随向量别名） | 新增 |
| 14 | `fwd.cj` | `glm.detail.*` | 标量别名（含 `uint`）+ 256 个向量别名 | 2b（标量部分）+ 8（向量部分） | 10（标量部分）+ 11（向量部分） |

**对应测试文件清单**（与前序各序号一一对应）：

| 序号 | 测试文件（package glm.detail） | 被测文件 | 说明 |
|------|-------------------------------|---------|------|
| T1 | `test_setup.cj` | `setup.cj` | 验证 18 个 `GLM_CONFIG_*` 常量值正确性 |
| T2 | `test_qualifier.cj` | `qualifier.cj` | 验证 `Qualifier` 接口实现类型构造与约束检查 |
| T3~T5 | `test_shims.cj`（合并） | `shim_assert.cj` + `shim_limits.cj` + `shim_cstddef.cj` | 验证 assert 行为、`NumericLimits` 边界值、`isIec559Of` 类型判定 |
| T6 | `test_compute_vector_relational.cj` | `compute_vector_relational.cj` | 验证 `ComputeEqual` 对 `Int32`/`Float32`/`Bool` 的比较结果 |
| T7 | `test_vectorize.cj` | `vectorize.cj` | 验证 Functor 静态 `call` 方法编译通过（首轮仅定义不消费，编译通过即足） |
| T8 | `test_compute_vector_decl.cj` | `compute_vector_decl.cj` | 验证 compute_vec_* 结构体编译通过 |
| T8a | `test_scalar_vec_ops.cj` | `scalar_vec_ops.cj` | 验证 scalar-op-vec 方向辅助函数双向调用正确性 |
| T9~T12 | `test_type_vec1.cj`~`test_type_vec4.cj` | `type_vec1.cj`~`type_vec4.cj` | 验证各 Vec 类型的构造/算术/比较/位运算/边界行为 |
| T13 | `test_lib.cj`（package glm） | `lib.cj` | 验证 `import glm.*` 后可访问 Vec 类型及别名 |
| T14 | `test_fwd.cj`（package glm） | `fwd.cj` | 验证 256 个别名编译无重复定义，抽查 4 个家族的别名映射正确性 |

### 8.2 范围可追溯性对照表

以下对照表将 roadmap §3E/§3G 定义的首轮范围逐项映射到本设计的对应章节和迁移文件，确保无范围歧义或遗漏：

| Roadmap §3E 序号 | Roadmap 子范围 | GLM 源文件 | 本设计对应章节 | 本设计对应仓颉文件 | 偏离说明 |
|-----------------|--------------|-----------|--------------|----------------|---------|
| 1 | 1 | `setup.hpp` | §3.6 Shim 层、§7 D6 | `setup.cj` | 无偏离。C++ `setup.hpp` 中 1000+ 行平台/编译器检测宏首轮不迁移，仅迁移约 80-120 行配置常量（详见 roadmap 3A.1 说明）。此偏离已在 roadmap 中预声明 |
| 2 | 1 | `qualifier.hpp` | §3.1 Qualifier 体系 | `qualifier.cj` | 无偏离。C++ `storage<L,T,Q>` 模板在首轮无需映射（D23），`genTypeTrait`/`find_best_type` 等辅助设施已推迟至后续轮次（D24） |
| 3 | 2a | `compute_vector_relational.hpp` | §3.5 ComputeEqual | `compute_vector_relational.cj` | 无偏离。简化版 `ComputeEqual<T>` 移除 `IsFloat` 参数 |
| 4 | 2a | `compute_vector_decl.hpp` | §3.4 ComputeVec* 运算策略体系 | `compute_vector_decl.cj` | 无偏离。首轮仅定义类型，不被 Vec 运算符消费（D16） |
| 5 | 2a | `_vectorize.hpp` | §3.3 Functor 体系 | `vectorize.cj` | 无偏离。按分量数拆分 functor（4 × 4 = 16 个定义），首轮仅定义不消费（D16） |
| 6 | 4 | `type_vec1.hpp` + `type_vec1.inl` | §3.2 Vec 结构体系、§4 关键行为契约 | `type_vec1.cj` | 无偏离 |
| 7 | 5 | `type_vec2.hpp` + `type_vec2.inl` | §3.2 Vec 结构体系、§4 关键行为契约 | `type_vec2.cj` | 无偏离 |
| 8 | 6 | `type_vec3.hpp` + `type_vec3.inl` | §3.2 Vec 结构体系、§4 关键行为契约 | `type_vec3.cj` | 无偏离。`.inl` 中 `#if GLM_CONFIG_SIMD` 条件包含 `type_vec_simd.inl` 由 `GLM_CONFIG_SIMD=false` 消除 |
| 9 | 7 | `type_vec4.hpp` + `type_vec4.inl` | §3.2 Vec 结构体系、§4 关键行为契约 | `type_vec4.cj` | 无偏离。同上 SIMD 条件分支消除 |
| 10 | 2b | `fwd.hpp` 标量别名部分（第 1-178 行） | §3.7 标量类型别名 | `fwd.cj`（标量别名部分） | 无偏离 |
| 11 | 8 | `fwd.hpp` 向量别名部分（第 180-507 行） | §3.8 向量类型别名 | `fwd.cj`（向量别名部分） | 无偏离。256 个别名全量定义，与 roadmap §3C 一致 |
| S1 | S | `<cassert>` shim | §3.6 Shim 层 | `shim_assert.cj` | 无偏离。新增仓颉 shim 文件 |
| S2 | S | `<limits>` shim | §3.6 Shim 层 | `shim_limits.cj` | 无偏离。新增仓颉 shim 文件 |
| S3 | S | `<cstddef>` shim（不含 `countof`） | §3.6 Shim 层 | `shim_cstddef.cj` | **偏离**：GLM `countof` 宏基于 `sizeof(array) / sizeof(array[0])` 计算 C 数组元素个数。仓颉中无等价的 C 数组语义——VArray 的元素类型和长度在类型中编码，通过 `size` 属性即可获取编译期长度，无需独立的 `countof` 函数。调用方使用 `VArray` 的 `size` 属性或 `LengthT` 作为替代。§3.6 已声明此决策，但上一轮 §8.2 追溯表遗漏此偏离的记录，现补充标注 |
| — | 8（新增） | —（新增） | §2 模块划分 | `lib.cj` | **偏离说明**：新增 `lib.cj` 用于 `public import` 重导出核心类型和 `scalar-op-vec` 方向辅助函数（`add`/`sub`/`mul`/`div`/`mod`）。此文件不在 roadmap 原始清单中，但为满足公共 API 面封装性而新增，不引入新的类型定义或依赖，不影响范围完整性和依赖闭合性 |

### 8.3 迁移顺序与依赖说明

**迁移顺序**（含增量验证节点）：

| 阶段 | 步骤 | 文件 | 增量验证 |
|------|------|------|---------|
| 1 | 基础设施（可并行） | 1. setup.cj + 3. shim_assert.cj + 4. shim_limits.cj + 5. shim_cstddef.cj | 各文件独立编译通过；`cjpm build` 无报错 |
| 2 | 基础设施 | 2. qualifier.cj | 编译通过；确认 `Qualifier` 接口及 6 个实现类型定义正确 |
| 3 | 辅助工具（可并行） | 6. compute_vector_relational.cj + 7. vectorize.cj | 编译通过；`ComputeEqual` 对 `Int32`/`Float32`/`Bool` 各实例化一次确认 |
| 4 | 运算策略 | 8. compute_vector_decl.cj | 编译通过；确认 compute_vec_* 结构体定义正确（首轮仅定义不消费，编译通过即足） |
| 5 | Vec 类型（可并行） | 9~12. type_vec1.cj ~ type_vec4.cj + scalar_vec_ops.cj | 编译通过；对 `Vec4<Int32>` 和 `Vec4<Float32>` 各验证一次构造 + 算术 + 比较运算正确性 |
| 6 | 公共 API + 别名 | 13. lib.cj + 14. fwd.cj | 编译通过；验证 `import glm.*` 可正确使用 Vec 类型；验证所有 256 个别名编译无重复定义 |
| 7 | 测试运行 | — | `cjpm test` 运行全部 `@Test` 测试用例通过 |

**依赖说明**：
- `setup.cj` 包含 18 个 `GLM_CONFIG_*` 编译期常量定义，**不包含** `assert` 函数（归入 `shim_assert.cj`）或 `LengthT`/`SizeT` 类型别名（归入 `shim_cstddef.cj`）。
- `shim_cstddef.cj` 无任何依赖，与 `setup.cj` 无重叠职责。
- `VArray<T, $N>` 的 `size` 属性提供编译期长度查询，等效于 C++ 中的元素计数宏。`$N` 必须为固定数值字面量，不可声明为值泛型参数。
- `compute_vector_relational.cj` 定义简化后的 `ComputeEqual<T>`（无 `IsFloat` 参数）。
- `vectorize.cj` 和 `compute_vector_decl.cj` 首轮仅定义类型，不被 Vec 运算符消费。

### 8.4 参考实现使用策略

**参考实现目录**：`references/glm-1.0.3/` 包含 GLM 1.0.3 C++ 参考实现，在编码阶段按以下策略使用：

0. **前置验证**（编码启动前必须完成）：确认参考实现目录结构完整，关键路径的实现逻辑与设计假设一致。具体验证项包括：① 确认 `setup.hpp` 中 `GLM_CONFIG_CLIP_CONTROL` 的条件编译逻辑与 §7 D6 描述的决策分支一致（两层条件编译：`GLM_FORCE_DEPTH_ZERO_TO_ONE` 设置 `ZO_BIT`/`NO_BIT`，`GLM_FORCE_LEFT_HANDED` 设置 `LH_BIT`/`RH_BIT`，无额外定义时最终值为 `0x0A`）；② 确认 `qualifier.hpp` 中 `storage` 模板的非 SIMD 路径仅使用 `T data[L]` 数组（与 D23 省略理由一致）；③ 确认 `type_vecN.inl` 中构造函数宏展开后的参数列表与 §4.1 清单匹配（抽查 Vec2/Vec4 各一个）。若参考实现中的条件分支逻辑与当前设计描述不符，**以参考实现为准并更新 §7 D6 及对应设计章节**，同时记录于设计变更日志。
1. **行为确认**：当设计文档中的行为约定存在歧义时，以参考实现中对应 `.hpp`/`.inl` 文件的实现为最终行为参照。例如，确认 `type_vec4.inl` 中 `operator++` 的逐分量递增语义。
2. **构造函数清单验证**：§4.1 的构造函数清单已覆盖 GLSL 5.4.1 及 GLM 扩展的所有构造形态。编码阶段针对具体 VecN 类型时，应查阅参考实现中对应 `type_vecN.inl` 的构造函数宏展开，确认无遗漏的构造函数组合。
3. **运算符行为对标**：每个运算符迁移完成后，使用参考实现中的测试模式验证结果等价性——通过构造相同的输入值，对比仓颉输出与 C++ 参考实现的输出（可编写小型 C++ 测试程序编译执行，或人工对照 GLM 文档描述的数学语义）。
4. **配置宏确认**：`setup.cj` 中 18 个 `GLM_CONFIG_*` 常量的默认值以参考实现中 `setup.hpp` 的 `#define` 定义为准。当配置值与参考实现不一致时，以参考实现为准并更新设计文档中对应表格。**兜底条款**：若参考实现中的条件分支逻辑与当前描述不符（如嵌套 `#if`/`#elif`/`#else` 的条件组合产生与文档不同的计算结果），以参考实现的实际条件编译结果为准，同步更新 §7 D6 及相关章节中的配置描述。
5. **命名映射**：256 个别名与 `fwd.hpp` 中 GLM CV-qualified 类型名的映射关系以参考实现为准——编码阶段逐家族对照 `fwd.hpp` 的 `typedef` 行确认映射正确性。
6. **非首轮内容边界**：参考实现中属于后续轮次的内容（矩阵/四元数/函数库文件等）不应在首轮编码中引用。编码阶段若意外需要参考这些内容，应标记并推迟至对应轮次的设计审议。

---

## 9. 异常场景和边界条件补充

### 9.1 零向量相关行为

| 场景 | 行为约定 |
|------|---------|
| 零向量定义 | 所有分量为 `T(0)` 的 Vec 实例。对整数类型（`Int8`~`Int64`、`UInt8`~`UInt64`）和浮点类型（`Float32`/`Float64`）及 `Bool`（`false`）均适用。 |
| 零向量参与算术运算 | 零向量 + 向量 = 向量（与加法单位元一致）。零向量 - 向量 = 取负后的向量。零向量 × 标量 = 零向量。零向量 / 标量 = 零向量（除零情况按 §9.2 约定）。 |
| 零向量逐分量比较 | `ComputeEqual<T>` 在 `const if` 路径下对整数类型通过 `==` 直接比较，对浮点类型通过容差比较。零向量与自身比较始终返回 `true`。 |
| 零向量标准化 | 首轮不实现 `normalize` 函数。标准化场景中的零向量处理约定推迟到后续轮次定义。 |

### 9.2 除零行为

| 场景 | 行为约定 |
|------|---------|
| 整数 Vec / 标量 0 | 仓颉运行时抛 `ArithmeticException`（整数除零）。Vec 运算符不做预防性检查。 |
| 浮点 Vec / 标量 0 | 仓颉运行时返回 `±Inf`（IEEE 754 默认行为）。Vec 运算符不做预防性检查。 |
| Vec / Vec（全零分量） | 逐分量运算，每个分量独立按标量规则处理。 |
| Vec % 0（取模除零） | 整数取模除零抛 `ArithmeticException`。浮点 Vec 实例在编译期即因 `%` 不支持浮点类型而报错（§4.3 整数约束）。 |
| 零向量 / 零标量 | 与"任意向量 / 零标量"行为一致（整数抛异常，浮点返回 `±Inf`/`NaN`）。 |

### 9.3 NaN/Infinity 传播

| 场景 | 行为约定 |
|------|---------|
| NaN 参与算术运算 | 所有算术运算直接委托给仓颉原生浮点运算，严格遵循 IEEE 754 标准：`NaN + x = NaN`，`NaN - x = NaN`，`NaN * x = NaN`，`NaN / x = NaN`。 |
| NaN 参与比较运算 | `ComputeEqual` 的浮点容差比较路径使用 `abs(a - b) <= epsilonOf<T>()`。`NaN - x = NaN`，`abs(NaN) = NaN`，`NaN <= epsilon` 为 `false`，因此 `NaN == x`（对任意 x，含 NaN 自身）均返回 `false`。此行为与 IEEE 754 标准一致。 |
| Infinity 参与算术运算 | `Inf + Inf = Inf`，`Inf - Inf = NaN`，`Inf * 0 = NaN`，`Inf / Inf = NaN`，`Inf + finite = Inf`。严格遵循 IEEE 754 标准。 |
| Infinity 参与比较运算 | 浮点容差比较路径下，`Inf - Inf = NaN`，`abs(NaN) = NaN`，`NaN <= epsilon` 为 `false`。因此 `Inf == Inf` 在容差比较路径下返回 `false`（IEEE 754 标准行为：`Inf == Inf` 在 `==` 运算符层面返回 `true`，但在容差路径下因减法表达式产生 NaN 而被误判）。此为容差比较路径的已知局限性。**行为差异**：容差路径下 `Inf == Inf` 返回 `false`，与 C++ GLM 的 `==` 行为（返回 `true`）显著偏离。**补救措施**：对于需要 IEEE 754 精确相等语义的场景（含 Infinity/NaN 比较），使用 `equalExact()` 具名函数（§4.5），该函数跳过容差路径直接使用仓颉原生 `==` 做精确分量比较。若 `const operator ==` 的容差路径因验证失败而整体回退到精确比较（§7 D29），此差异自动消除——回退路径下 `Inf == Inf` 返回 `true`，与 C++ GLM 行为一致。首轮约定：`==` 的容差路径适用于有限值范围内的浮点比较，Infinity/NaN 的精确比较通过 `equalExact` 完成。

**`equalExact` 与 `==` 行为差异汇总**：容差路径下，`equalExact` 与 `==` 在以下场景存在行为差异：① 有限值的微差比较——`==` 使用 `abs(a-b) <= epsilon` 的容差判定，`equalExact` 使用精确 `==`，因此微小浮点误差在 `equalExact` 下为不等、在 `==` 下可能为相等；② `Inf == Inf`——容差路径下 `==` 返回 `false`（减法产生 NaN），`equalExact` 返回 `true`（IEEE 754 精确相等）；③ `NaN == x`——容差路径下 `==` 和 `equalExact` 均返回 `false`（NaN 与任何值均不相等），行为一致。整数/Bool Vec 上两者行为完全等价（精确比较路径）。容差回退路径下两者完全等价。 |
| `NumericLimits<T>.epsilon()` 与 Infinity | `epsilon()` 的语义：对于浮点分量的容差比较，`epsilonOf<T>()` 返回 `epsilon() * magnitude` 的缩放容差。当 `a` 或 `b` 为 `Inf`/`NaN` 时，缩放容差计算可能产生 `Inf` 或 `NaN`，导致比较结果不稳定。首轮约定：`ComputeEqual` 的容差路径适用于有限值范围内的浮点比较。Infinity/NaN 的相等性判断回退到仓颉原生 `==`（调用方可通过 `equalExact` 具名函数获取 IEEE 754 精确相等语义，已在 §4.5 定义且属于首轮范围）。 |

### 9.4 类型转换边界

| 转换场景 | 行为约定 |
|---------|---------|
| 整数宽度提升 | `Int8 → Int16 → Int32 → Int64` 等，无精度损失。 | 
| 整数宽度截断 | `Int64 → Int32 → Int16 → Int8` 等，高位截断。仓颉运行时在 Debug 模式可能产生溢出检测，但在 `@OverflowWrapping` 标注下截断语义与 C++ 隐式转换一致。 |
| 无符号 ↔ 有符号互转 | `UInt32 → Int32` 等。仓颉的类型构造函数直接处理。超出有符号范围的值按 wrapping 语义截断。 |
| 浮点 → 整数 | `Float64 → Int32` 等。仓颉的类型构造函数对溢出值抛 `ArithmeticException`。C++ 中此场景是 UB。设计约定：迁移代码中若涉及浮点到整数的 Vec 转换，应在调用处确保值在目标类型的表示范围内，或通过 `clamp` 等辅助函数处理（不属于首轮范围）。 |
| 整数 → 浮点 | `Int32 → Float32` 等。大整数可能因浮点精度限制而损失精度（`Float32` 的 mantissa 为 23 位，无法精确表示超过 2^24 的整数）。此行为与 C++ 隐式转换一致，不做特殊处理。 |
| 浮点宽度提升/截断 | `Float32 ↔ Float64`。宽度提升无损，宽度截断可能损失精度。 |
| `Bool` → 数值 | 跨 Vec 转换构造中 `Bool` 不可直接转换为数值类型（仓颉中 `Int32(Bool)` 不被支持）。泛型构造函数 `public init<T2, Q2>(v: VecN<T2, Q2>)` 不受限于 T2 的具体类型——当 `T2 = Bool` 且 `T` 为数值类型时，构造函数体内的 `T(v.x)` 尝试将 `Bool` 转换为数值，将产生编译错误。**约束策略**：仓颉 `is` 运算符用于值级运行时类型检测（`e is Type`），不可直接对泛型类型参数 `T2` 进行编译期类型查询——`T2 is Bool` 语法不可行。改用分量值检测方案：在 `init` 体内通过 `if (v.x is Bool)` 检测 Vec1 的分量值是否为 `Bool` 类型；当 `T2 = Vec1<Bool, Q2>` 时，`v.x` 的运行时类型为 `Bool`，`v.x is Bool` 返回 `true`。配合 `if (v.x is Int32 || v.x is Float32 || ...)` 对数值类型逐一排除。方案 B（运行时兜底，推荐优先采用）：在 `init` 体内通过 `if (v.x is Bool)` 运行时检测分支——`true → T(1)`，`false → T(0)`，此方案运行时开销对单分量可忽略。首轮采用方案 B（运行时兜底），理由：① 避免对仓颉 `const if` 类型参数检测行为的未知依赖；② 运行时分支仅对 `VecN<Bool, Q>`→`VecN<数值, Q>` 转换场景生效，非转换热路径；③ 方案 A 的分量值检测方案（`v.x is Bool`）可作为备选——在 `const init` 上下文中可用但具体可行性需编码阶段验证。 |
| `Vec1` → `Vec2`/`Vec3`/`Vec4` | 所有分量取 `Vec1` 的单一分量值。适用于标量传播构造场景。 |

---

## 10. `isIec559Of<T>()` 取值对照表

`isIec559Of<T>()` 在 `shim_limits.cj` 中以 `const` 泛型函数形式实现，函数体内使用编译期 `if` 配合 `is` 运算符进行类型检测。各类型取值如下：

| 类型 | `isIec559Of` 值 | 说明 |
|------|--------------|------|
| `Int8` | `false` | 整数类型，非 IEC 559 |
| `Int16` | `false` | 整数类型，非 IEC 559 |
| `Int32` | `false` | 整数类型，非 IEC 559 |
| `Int64` | `false` | 整数类型，非 IEC 559 |
| `UInt8` | `false` | 整数类型，非 IEC 559 |
| `UInt16` | `false` | 整数类型，非 IEC 559 |
| `UInt32` | `false` | 整数类型，非 IEC 559 |
| `UInt64` | `false` | 整数类型，非 IEC 559 |
| `Float16` | `false` | 因 `is` 运算符检测模式仅覆盖 `Float32`/`Float64`，`isIec559Of<Float16>()` 受限于此模式返回 `false`。若后续轮次引入 Float16 支持，应扩展检测条件或改用其他方案以正确返回 `true` |
| `Float32` | `true` | IEC 60559 单精度（需验证仓颉运行时符合性） |
| `Float64` | `true` | IEC 60559 双精度（需验证仓颉运行时符合性） |
| `Bool` | `false` | 布尔类型，非 IEC 559。`isIec559Of<Bool>()` 通过编译期 `if` 的 `else` 分支返回 `false` |

**实现方式**：
```cangjie
  const func isIec559Of<T>(): Bool {
      if (T(0) is Float64 || T(0) is Float32) { true } else { false }
  }
```
该函数为单一泛型函数，不涉及重载或特化。编译期实例化时，`T(0) is Float64` 等表达式在 const 上下文中求值，零运行时开销。

**注**：C++ `is_iec559` 判断类型是否完全符合 IEEE 754 标准。仓颉的 `Float32`/`Float64` 预期符合 IEC 60559（IEEE 754），但此符合性需在目标平台上验证。若平台浮点实现有偏差，`isIec559Of<Float32>()`/`isIec559Of<Float64>()` 应回退到 `false` 以使用精确比较路径。当前设计保持编译期判断，若需运行时动态判断则需改为反射方案（不属于首轮范围）。

**设计阶段验证要求**：`isIec559Of<T>()` 的 `if (T(0) is Float64 || T(0) is Float32)` 方案依赖三项核心假设，均须在设计阶段（而非编码阶段）完成编译器验证：

| 依赖项 | 描述 | 风险等级 | 验证方法 |
|-------|------|---------|---------|
| ① `T(0)` const 构造 | `T(0)` 在 const 上下文中对所有目标类型（`Int32`、`Float32`、`Bool` 等）合法 | **高** — 若失败则编译期 `if` 分支前提不成立，整体方案不可行 | 编写原型测试：`const func testT0<T>(): Bool { if (T(0) is Float64) { true } else { false } }`，分别对 `T = Int32, Float32, Bool` 验证编译通过 |
| ② `is` 在 const 泛型中的可用性 | `is` 运算符在 const 泛型函数中可参与编译期求值，对泛型类型参数 `T` 的实例化值执行类型检测 | **中** — 虽已在 const 表达式列表中确认可用，但泛型 `T` 的特殊性需单独确认 | 与依赖①合并验证（同一原型测试） |
| ③ `abs()` / `epsilon()` const 兼容性 | `Float32.abs()`、`NumericLimits<T>.epsilon()` 在 const 函数体内可调用 | **中** — 失败则容差路径不可用 | 编写原型测试：`const func testConstPath(a: Float64, b: Float64): Bool { abs(a - b) <= NumericLimits<Float64>.epsilon() }` 验证编译通过 |

**验证时序**：三项依赖应在设计阶段完成原型验证。若依赖①或②失败 → `if (T(0) is Float64)` 方案不可行，整体回退到备选路径（所有类型精确比较 `a == b`，§3.5 备选路径）。若依赖①和②通过但依赖③失败 → 浮点容差比较从 `const operator ==` 路径中移除，通过独立的非 `const` 具名函数（如 `equalEpsilon`）提供。**风险标注**：本方案的可行性最终取决于目标编译器对 `const` 泛型上下文中 `is` 运算符和 `T(0)` 构造的支持程度。编码阶段启动前必须完成上述原型验证，验证结果决定本设计的 `const` 路径是否可行。

### 编译期 `if` 分支抑制行为综合验证

编译期 `if` 分支的非选择分支抑制行为是本设计多处依赖的核心编译器行为。以下统一列出所有依赖点及其验证要求。

#### 依赖点清单

| 依赖点 | 所在章节 | 编译期 `if` 表达式 | 非选择分支内容 | 风险等级 | 对非 `const` 函数的适用性 |
|-------|---------|---------------|--------------|---------|------------------------|
| A. `ComputeEqual.callConst` | §3.5 | `if (isIec559Of<T>())` | 整数路径：`a == b`；浮点路径：`abs(a - b) <= epsilonOf<T>()` | **严重** — 失败则 `==` 整体回退到精确比较 | `callConst` 声明为 `const`；若编译期 `if` 抑制不成立，`==` 降级为非 `const` 精确比较 |
| B. `isIec559Of<T>()` | §3.6 | `if (T(0) is Float64 \|\| T(0) is Float32)` | 非浮点分支：`else { false }` | **严重** — 失败则编译期类型检测方案整体不可行 | 函数声明为 `const`；若失败 → 所有类型回退到精确比较 |
| C. `mod` 包级独立函数 | §4.3 | `if (isIec559Of<T>())` | 整数路径：`x % y`；浮点路径：`x - y * trunc(x / y)` | **严重** — 失败则双路径不可行 | 包级独立函数声明为 `const`；若失败 → 拆分为 `modInt`/`modFloat` 非 `const` 具名函数 |
| D. `ComputeEqual.callConst` + `isIec559Of` 组合 | §3.5+§3.6 | `if (T(0) is Float64)` 嵌套于 `callConst` 内 | 整数分支 `a == b` | **严重** — 两层编译期 `if` 嵌套的抑制行为 | 同上 A，`callConst` 为 `const`；若失败 → 整体回退 |
| E. 构造函数 Bool→数值检测 | §9.4 | `if (v.x is Bool)`（备选方案 A） | 数值分支：`T(1)/T(0)` | **低** — 已采用方案 B 运行时兜底 | `const init` 中可用（备选）；主方案为运行时分支 |

#### 统一验证方法

所有依赖点（A~E）的核心验证逻辑相同——验证编译期 `if` 在 `const` 上下文中的非选择分支抑制行为。建议采用以下统一原型测试验证：

```cangjie
// 统一验证：编译期 if 在 const 泛型函数中对非选择分支的编译抑制
const func testConstIfSuppression<T>(): Bool {
    if (T(0) is Float64 || T(0) is Float32) {
        // 浮点分支：使用仅浮点支持的运算
        true
    } else {
        // 整数/Bool 分支：使用仅整数支持的运算
        T(0) == T(0)
    }
}
```

验证方法：
1. 以 `Float32` 实例化：期望编译通过（进入浮点分支，`true` 对所有类型合法）
2. 以 `Int32` 实例化：期望编译通过（进入整数分支，`T(0) == T(0)` 合法）
3. 以 `Bool` 实例化：期望编译通过（进入整数/Bool 分支，`T(0)` 即 `Bool(0) = false`，`false == false` 合法）

若以上三项均编译通过 → 编译期 `if` 非选择分支抑制机制对所有依赖点 A~E 均成立。

若编译期 `if` 抑制不成立，各依赖点的独立回退方案：

| 依赖点 | 回退方案 |
|-------|---------|
| A. `ComputeEqual.callConst` | `==` 退至非 `const` 精确比较；浮点容差比较由独立非 `const` 具名函数 `equalEpsilon` 提供 |
| B. `isIec559Of<T>()` | 放弃编译期类型检测，`==` 退至精确比较（与 A 回退路径一致） |
| C. `mod` 双路径 | 拆分为 `modInt`（非 `const`，使用 `%`）和 `modFloat`（非 `const`，使用 `trunc` 恒等式），调用方按类型选择 |
| D. 嵌套编译期 `if` | 与 A 回退路径一致（整体 `==` 退至精确比较） |
| E. Bool 检测 | 采用方案 B 运行时分支（已为首选方案，无需变更） |

#### mod 函数边界值验证（独立于编译期 if 抑制）

若编译期 `if` 抑制验证通过，`mod` 的浮点路径还需额外验证恒等式的数值正确性：

| 验证项 | 描述 | 风险等级 | 验证方法 |
|-------|------|---------|---------|
| ① 浮点 `mod` 边界值 | `Float32.Max % Float32(1.0)`、`Float32.MinPositive % Float32(2.0)`、`0.0 % Float32(1.0)`、`Inf % Float32(1.0)`、`NaN % Float32(1.0)` | **中** | 编写原型测试覆盖边界值 |
| ② 负操作数符号 | `(-3.5f) % 2.0f`、`3.5f % (-2.0f)`、`(-3.5f) % (-2.0f)` | 中 | 编写原型测试验证负值场景 |

### 浮点 `mod` 实现正确性验证

`mod` 具名函数对浮点类型 Vec 的实现采用算术恒等式 `x - y * trunc(x / y)`，其中 `trunc` 取自 `std.math.trunc`（仅提供 `Float64` 版本）。对 `Float32` 分量，采用先提升至 `Float64` 计算截断再转换回 `Float32` 的精度策略。此实现策略涉及以下关键假设，均须在设计阶段验证：

| 依赖项 | 描述 | 风险等级 | 验证方法 |
|-------|------|---------|---------|
| ① `std.math.trunc(Float64) → Float64` 可用性 | `trunc` 函数签名和行为的正确性 | 低 — `std.math.trunc` 为标准库函数，签名已确认 | 查阅标准库文档确认 |
| ② `Float32` → `Float64` 提升 → `trunc` → `Float32` 降级无语义损失 | 恒等式 `x - y * trunc(x / y)` 在提升-截断-降级过程中保持正确性 | **中** — 精度提升无损，但边界值（`Float32.Max`、`Float32.MinPositive`、`0.0`、`±Inf`、`NaN`）的行为需验证 | 编写原型测试覆盖边界值：`Float32.Max % Float32(1.0)`、`Float32.MinPositive % Float32(2.0)`、`0.0 % Float32(1.0)`、`Inf % Float32(1.0)`、`NaN % Float32(1.0)` |
| ③ 恒等式对负操作数的正确性 | `trunc` 向零取整，`x - y * trunc(x / y)` 在负操作数时符号行为与 C++ GLM `std::fmod` 一致 | 中 | 编写原型测试验证负值场景：`(-3.5f) % 2.0f`、`3.5f % (-2.0f)`、`(-3.5f) % (-2.0f)` |
| ④ 整数 Vec `mod` 与浮点 `mod` 分支选择的编译期 `if` 正确性 | `if (isIec559Of<T>())` 正确区分整数/浮点路径 | 低 — 与 `ComputeEqual` 分支逻辑一致 | 确认 `isIec559Of<T>()` 对整数类型返回 `false`，对浮点类型返回 `true` |
| ⑤ `mod` 函数的 `const` 声明 | `mod` 的包级独立函数方向须声明为 `const`（仓颉中编译期 `if` 要求所在函数为 `const`）；扩展成员函数方向因 `extend` 块限制（仓颉扩展 §4.2）声明为非 `const`，且不承载编译期 `if` 分支 | 低 — 语法语义明确 | 编码阶段确认 `const` 修饰符出现在 `mod` 包级独立函数的签名中；同步确认 `add`/`sub`/`mul`/`div` 的包级独立函数也声明为 `const`（理由见 §7 D32） |

### `equalExact` 设计阶段验证

`equalExact` 具名函数（§4.5）跳过容差比较路径，直接使用仓颉原生 `==` 对每个分量做精确比较。其设计阶段验证依赖以下前提：

| 依赖项 | 描述 | 风险等级 | 验证方法 |
|-------|------|---------|---------|
| ① 组件级 `==` 在任意 Vec 实例化上可用 | 仓颉原生 `==` 对所有数值类型和 `Bool` 均支持，`equalExact` 体内的分量级 `a.x == b.x` 表达式对任意 `T`（`Int32`、`Float32`、`Bool` 等）合法 | 低 | 编写原型测试：分别对 `Vec2<Int32>`、`Vec2<Float32>`、`Vec2<Bool>` 调用 `equalExact()`，确认编译通过且返回正确类型 `Bool` |
| ② 容差路径与 `equalExact` 行为差异可观测 | 容差路径下 `==` 使用 `abs(a-b) <= epsilon`，`equalExact` 使用精确 `==`，两者的行为差异需在有限值微差场景中可区分 | 低 | 编写原型测试：构造两个浮点 Vec，其分量差值在 epsilon 范围内（如 `1.0` vs `1.0 + Float32.epsilon/2`），验证 `==` 返回 `true` 而 `equalExact` 返回 `false` |
| ③ `equalExact(Inf)` → `true` | `Inf == Inf` 使用仓颉原生 `==` 始终返回 `true` | 低 | 直接验证：仓颉中 `Float32.Infinity == Float32.Infinity` 返回 `true` 为语言定义行为，无需额外验证 |
| ④ `equalExact(NaN)` → `false` | `NaN == x` 使用仓颉原生 `==` 始终返回 `false` | 低 | 直接验证：仓颉中 `Float32.NaN == Float32.NaN` 返回 `false` 为 IEEE 754 标准行为，无需额外验证 |
| ⑤ 回退路径下 `==` 与 `equalExact` 等价性 | 若 §7 D29 触发回退，`==` 降级为精确比较，`equalExact` 行为保持不变，两者完全等价 | 低 | 编写原型测试：在模拟回退路径下（手动将 `==` 实现改为精确比较），验证 `==` 与 `equalExact` 对所有输入（含 Inf/NaN）的输出一致 |

**验证时机**：验证项①和②在 Vec 结构体编码完成后立即执行（作为构造-访问-运算验证的一部分）；验证项③④为语言定义行为，可作为编译确认项；验证项⑤仅在 D29 回退触发后执行（作为回退路径的回归测试）。`equalExact` 设计阶段验证通过的标准：所有依赖项均编译通过，无额外语法或语义风险。

### `@OverflowWrapping` 与 `const` 函数共存验证

`@OverflowWrapping` 溢出注解与 `const` 函数修饰符可在同一函数上共存。此共存性涉及以下验证依赖项：

| 依赖项 | 描述 | 风险等级 | 验证方法 |
|-------|------|---------|---------|
| ① 语法共存性 | 同一函数同时标注 `@OverflowWrapping` 和 `const` 修饰符（如 `@OverflowWrapping const func add(a: T, b: T): T`）在仓颉语法层面合法 | 低 — 注解与修饰符分属不同语法维度，仓颉语言中无禁止共存的规则 | 编写原型测试：`@OverflowWrapping const func add(a: Int32, b: Int32): Int32 { a + b }` 验证编译通过 |
| ② 语义兼容性 | `@OverflowWrapping` 在 `const` 函数体内对算术运算的 wrapping 行为与非 `const` 函数一致 | **中** — 若 `const` 函数路径下编译器对溢出注解的处理策略与非 `const` 路径不同，可能导致 wrapping 行为不一致 | 编写原型测试，覆盖三种代表性整数类型：在 `const` 函数中分别执行 `UInt8(255) + UInt8(1)`（期望 `0`）、`Int8(127) + Int8(1)`（期望 `-128`）、`Int64.Max + Int64(1)`（期望 `Int64.Min`），均标注 `@OverflowWrapping`，与同非 `const` 函数行为对照 |
| ③ 包级独立函数的 `const`+`@OverflowWrapping` 共存 | `scalar-op-vec` 方向包级独立函数（非 `extend` 块）同时标注 `@OverflowWrapping` 和声明为 `const`，语法合法 | 低 — 注解与修饰符分属不同语法维度 | 与依赖①合并验证（使用包级独立函数而非扩展成员函数） |

**验证建议**：将依赖①和②合并为单一原型测试函数，在 `const` 和 `non-const` 两种上下文中对比 `@OverflowWrapping` 标注的算术运算行为。若验证通过，则包级独立函数的 `const`+`@OverflowWrapping` 方案（§4.3）可行。若验证不通过（`@OverflowWrapping` 在 `const` 路径下 behavior 异常），则所有 `const` 算术包级函数降级为非 `const` 版本，同时保持 `@OverflowWrapping` 标注——功能正确性不受损，仅失去编译期调用能力。扩展成员函数（`add(v,s)` 等）因声明为非 `const`，不受此验证约束。

### `@Derive[Hashable]` 在泛型 struct 上的约束传递性验证

`@Derive[Hashable]` 在泛型 struct `VecN<T, Q>` 上的自动派生依赖类型参数 `T` 的 `Hashable` 约束传递性（§3.2）。虽然首轮所有目标类型均已实现 `Hashable`，仍需在编码阶段验证此约束传递性的编译器行为。

| 依赖项 | 描述 | 风险等级 | 验证方法 |
|-------|------|---------|---------|
| ① `@Derive[Hashable]` 在 `VecN<T, Q>` 上的编译通过性 | 对 `T = Int32`/`Float32`/`Bool` 等已实现 `Hashable` 的类型，`@Derive[Hashable]` 自动派生的 `hashCode()` 编译通过 | **低** — 首轮目标类型均已实现 `Hashable` | 编写原型测试：对 `Vec2<Int32, PackedHighp>`、`Vec2<Float32, PackedHighp>`、`Vec2<Bool, PackedHighp>` 分别调用 `.hashCode()`，确认编译通过 |
| ② `HashSet<VecN<T, Q>>` 的编译通过性 | 使用 `@Derive[Hashable]` 的 Vec 类型作为 `HashSet` 键值编译通过 | 低 | 编写原型测试：`HashSet<Vec2<Int32, PackedHighp>>`、`HashSet<Vec2<Float32, PackedHighp>>`、`HashSet<Vec2<Bool, PackedHighp>>` 均通过编译 |
| ③ 非 `Hashable` 类型参数的编译错误预期 | 当 `T` 未实现 `Hashable` 时（如自定义 struct），`@Derive[Hashable]` 应产生编译错误 | **低** — 仅用于确认编译器行为一致性，不构成首轮风险 | 编写负向测试：定义 `struct NonHashable {}`，尝试 `@Derive[Hashable] struct BadVec { var x: NonHashable }`，确认编译产生 `Hashable` 约束错误 |

---

## 11. 迁移成本评估

### 11.1 `&&`/`||` 具名函数迁移

C++ GLM 中 `&&` 和 `||` 是运算符重载，迁移到仓颉后需改为具名函数 `logicalAnd`/`logicalOr`。此语法变更对下游代码的影响和迁移模式如下：

#### 受影响的表达式模式

| C++ GLM 代码 | 仓颉等效代码 | 搜索规则 |
|-------------|-------------|---------|
| `a && b`（a,b 为 vec） | `a.logicalAnd(b)` | 在 Vec 类型变量上搜索 `&&` 替换为 `.logicalAnd()` |
| `a \|\| b`（a,b 为 vec） | `a.logicalOr(b)` | 在 Vec 类型变量上搜索 `\|\|` 替换为 `.logicalOr()` |
| `!a`（a 为 vec） | `!a` 或 `a.logicalNot()` | `!` 可重载，保持语法不变 |

#### 迁移模式

1. **纯语法替换**（机械可执行）：在 Vec 类型表达式中，将 `v1 && v2` 替换为 `v1.logicalAnd(v2)`，将 `v1 || v2` 替换为 `v1.logicalOr(v2)`。此替换可通过正则搜索完成，不涉及语义分析。
2. **短路语义丢失**：C++ 中 `&&`/`||` 的短路求值语义在具名函数中不保留——`logicalAnd(a, b)` 始终求值两个参数。在 GLM 向量运算场景中，所有参数均为纯表达式（无副作用），因此短路语义丢失不影响正确性。
3. **迁移影响范围**：仅影响使用 `bvec*`（`VecN<Bool, Q>`）类型布尔向量运算的代码。标量布尔值不受影响（仓颉原生 `&&`/`||` 保留）。

#### 自动迁移工具建议

可编写搜索脚本（基于正则表达式）处理以下模式：
- `(\w+)\s*&&\s*(\w+)` → `$1.logicalAnd($2)`
- `(\w+)\s*\|\|\s*(\w+)` → `$1.logicalOr($2)`

注意：此搜索替换需限定在 `bvec*` 类型变量范围内以避免误改标量 `Bool` 类型的 `&&` 表达式。在迁移实践中，建议在代码审查过程中手动标注 Vec 类型变量范围，或通过类型注解辅助搜索脚本。

### 11.2 `++`/`--` 具名函数迁移

C++ GLM 中 `++` 和 `--` 是前缀/后缀运算符重载，迁移到仓颉后需改为具名函数 `increment()`/`decrement()`。此语法变更对下游代码的影响和迁移模式如下：

#### 受影响的表达式模式

| C++ GLM 代码 | 仓颉等效代码 | 搜索规则 |
|-------------|-------------|---------|
| `++v`（前缀） | `v = v.increment()` | 在 Vec 类型变量上搜索前缀 `++` 替换为 `.increment()` |
| `v++`（后缀） | `v = v.increment()` | 在 Vec 类型变量上搜索后缀 `++` 替换为 `.increment()` |
| `--v`（前缀） | `v = v.decrement()` | 在 Vec 类型变量上搜索前缀 `--` 替换为 `.decrement()` |
| `v--`（后缀） | `v = v.decrement()` | 在 Vec 类型变量上搜索后缀 `--` 替换为 `.decrement()` |

#### 迁移模式

1. **前缀与后缀统一替换**：仓颉值类型中 `increment()` 和 `decrement()` 返回新向量（值语义的副本）。C++ 中前缀 `++v` 返回左值引用，后缀 `v++` 返回旧值副本。在仓颉中，两种形式均统一为 `v = v.increment()`（返回新向量后再赋值）。若原 C++ 代码依赖后缀 `++` 的"返回旧值"行为（如 `auto old = v++`），则需在迁移时拆分——`let old = v; v = v.increment()`。
2. **迁移影响范围**：影响所有使用 `vec++`、`++vec`、`vec--`、`--vec` 表达式的代码。通常用于循环计数或状态更新。
3. **`@OverflowWrapping` 继承**：`increment()`/`decrement()` 标注 `@OverflowWrapping`，行为与 C++ GLM 的 `operator++`（高位丢弃）一致。

#### C++ `++`/`--` 使用模式分类与映射

以下分类表涵盖 C++ 中 `++`/`--` 在 Vec 类型上的所有典型使用模式，逐一给出正确的仓颉映射方式和迁移工作量评估：

| 模式 | C++ 代码 | C++ 行为 | 仓颉等效代码 | 迁移工作量 | 说明 |
|------|---------|---------|-------------|-----------|------|
| **I. 独立语句（不依赖返回值）** | `v++;` `++v;` `v--;` `--v;` | 仅执行副作用（修改 v），返回值被忽略 | `v = v.increment()` / `v = v.decrement()` | 低（机械替换，搜索替换即可） | 前缀与后缀在仓颉中无差异。C++ 中前缀性能更优（无临时副本），仓颉中始终产生新向量 |
| **II. 作为右值（后缀返回旧值）** | `auto old = v++;` | old 获得 v 递增前的值，v 递增 | `let old = v; v = v.increment()` | 中（需拆分语句） | 必须解构为临时保存旧值和更新两步。不能简化为 `v.increment()` 的单一表达式 |
| **III. 作为右值（前缀返回新值）** | `auto newv = ++v;` | newv 获得 v 递增后的值，v 递增 | `v = v.increment(); let newv = v` 或 `let newv = v.increment()`（若可覆盖原变量） | 中（需拆分语句） | 若调用方只需新值且可丢弃原变量，可直接 `let newv = v.increment()` |
| **IV. 嵌套表达式** | `arr[++v] = val;` | v 先递增，然后用新值索引数组 | `v = v.increment(); arr[v] = val` | 中（需拆分表达式） | 仓颉表达式要求显式分步。可用复合赋值：`v = v.increment(); arr[v] = val` |
| **V. 循环计数** | `for(; condition; ++v) { ... }` | 循环的增量部分独立修改 v | `v = v.increment()` 作为循环增量表达式 | 低（机械替换） | 在循环的增量表达式中直接替换 |
| **VI. 函数参数** | `foo(v++);` | v 递增前的值传给 foo，然后 v 递增 | `let tmp = v; foo(tmp); v = v.increment()` | 中（需拆分语句） | 必须保存旧值副本后传递 |
| **VII. 后缀链式操作** | `v++->method();` | 对 v 递增前的旧值调用 method | `let tmp = v; v = v.increment(); tmp.method()` | 中（需拆分语句） | 通过临时变量交换方法调用方 |
| **VIII. 返回值传播** | `return v++;` `return ++v;` | 返回 v 递增前/后的值 | `let newv = v.increment(); return newv` 或 `return v.increment()` | 低-中（依赖返回值语义） | 若仅需新值，直接返回 `v.increment()`；若需旧值，先保存旧值再更新 |

**迁移工作量评估**：
- **低（机械替换）**：约占总出现次数的 60-70%。直接搜索替换即可，无需语义分析。
- **中（拆分语句）**：约占总出现次数的 30-40%。需要人工阅读上下文，理解返回值使用方式后拆分为多条语句。
- **高（涉及前缀/后缀语义差异）**：在 Vec 类型上不适用（前缀/后缀在仓颉中行为统一），但在非 Vec 标量类型场景中仍需区分。

**编码阶段建议**：
1. 先用正则搜索替换处理模式 I（独立语句）和模式 V（循环计数），覆盖大部分迁移工作。
2. 对模式 II-IV 和 VI-VIII，在代码审查中逐处人工识别并标注改造方式。
3. 对于 `Vec<Bool, Q>` 上的 `increment()`/`decrement()`，由于 Bool 不支持算术运算，在实例化时产生编译错误。迁移时需将涉及 `VecN<Bool>` 的 `++`/`--` 替换为逻辑非操作（`!`）或移除。

### 11.3 跨类型赋值差异

C++ GLM 允许从同分量数但不同分量类型的 Vec 赋值（如 `ivec2 = vec2` 通过隐式转换）。仓颉中 struct 自动生成的 `=` 仅接受完全相同类型的右操作数，跨类型赋值需显式转换：

| C++ GLM 代码 | 仓颉等效代码 | 说明 |
|-------------|-------------|------|
| `ivec2 a; vec2 b; a = b;` | `let a: IVec2; let b: Vec2Float32; a = IVec2(b);` | 显式使用跨 Vec 转换构造 |
| `uvec4 a; vec4 b; a = b;` | `let a: UVec4; let b: Vec4Float32; a = UVec4(b);` | 分量级类型转换在构造函数内完成 |

此差异为机械可替换的语法变化，通过搜索 `vecTypeName =` 后跟不同 Vec 类型的赋值模式进行替换。

### 11.4 `bitwiseNot()` 迁移影响（`VecN<Bool, Q>` 场景）

`bitwiseNot()` 对 `VecN<Bool, Q>` 的行为与 C++ GLM 的 `~bvec` 存在根本性差异（详见 §3.2 已知行为差异说明）：
- C++ GLM 中 `~bvec` 因整数提升机制（`bool` → `int` → 按位取反 → 转回 `bool`，非零即 `true`）对任一分量始终返回 `true`。
- 仓颉中 `bitwiseNot()` 对 `VecN<Bool, Q>` 调用 `!` 执行逻辑否定（`!true = false`，`!false = true`），行为完全相反。

**受影响的表达式模式**：

| C++ GLM 代码 | 仓颉等效代码 | 说明 |
|-------------|-------------|------|
| `~bvec`（布尔向量） | `!bvec` 或 `bvec.bitwiseNot()` | 行为完全相反。若需保持 C++ 行为，应替换为 `VecN<Bool, Q>(true)`（全 true）或按需使用 `logicalNot` |
| `~ivec`（整数向量） | `ivec.bitwiseNot()` | 语义等价（整数 `!` 为按位取反） |

**迁移规则**：
1. 整数分量 Vec 的 `~` 直接替换为 `.bitwiseNot()`，语义等价。
2. 布尔分量 Vec 的 `~` 需根据上下文选择替换方式：
   - 若期望行为是"全 false"（与仓颉 `!` 一致），替换为 `!bvec` 或 `bvec.logicalNot()`。
   - 若期望行为是"全 true"（与 C++ `~bvec` 一致），替换为 `VecN<Bool, Q>(true)`。
   - 若无法确定，应在代码审查中标记并手动确认。

**工作量评估**：影响范围较小（`~bvec` 使用频率低于整数/浮点向量位运算），主要在代码审查阶段人工识别处理。

### 11.5 `Inf == Inf` 容差比较路径行为差异

浮点容差比较路径下 `Inf == Inf` 返回 `false`，与 C++ GLM 的 `==` 行为（IEEE 754 `Inf == Inf` 返回 `true`）显著偏离。此差异的机理和迁移影响如下：

#### 差异机理
`ComputeEqual` 的容差比较路径执行 `abs(a - b) <= epsilonOf<T>()`。当 `a = Inf, b = Inf` 时：`Inf - Inf = NaN`，`abs(NaN) = NaN`，`NaN <= epsilon` 为 `false`。因此 `Inf == Inf` 在容差路径下误判为 `false`。

#### 受影响的表达式模式

| C++ GLM 代码 | 仓颉等效代码 | 说明 |
|-------------|-------------|------|
| `vec == vec`（涉及 Infinity 分量） | `v1.equalExact(v2)` | 使用 `equalExact` 跳容器差路径 |
| `any(equal(v1, v2))`（涉及 Infinity 分量） | `v1.equalExact(v2)` | 同上 |
| `v == Inf`（标量比较） | `v.equalExact(VecN(Inf))` | 通过 `equalExact` 获取 IEEE 754 精确语义 |

#### 迁移模式

1. **受影响范围**：仅影响浮点分量 Vec 在 `==` 运算符中涉及 `±Inf` 或 `NaN` 分量的比较。有限值范围内的比较不受影响。整数/Bool 分量 Vec 的 `==` 不受影响（走精确比较路径）。
2. **自动修复**：若 `const operator ==` 的容差路径因验证失败而整体回退到精确比较（见 §7 D29），本差异自动消除。
3. **手动修复**：需要 IEEE 754 精确相等语义的场景，将 `==` 替换为 `equalExact()`。

#### 搜索规则

| 搜索模式 | 替换目标 | 优先级 |
|---------|---------|--------|
| 浮点 Vec 变量上的 `==` 表达式，且操作数可能含 `±Inf`/`NaN` | 替换为 `.equalExact()` | 低（仅在关键路径中需要精确语义时执行） |
| `==` 用于 `VecN<Float32/64>` 的通用模式 | 保持原样（有限值范围内语义正确） | — |

#### 迁移工作量评估

- **低**：大多数 GLM 用户代码中浮点 Vec 的 `==` 比较涉及有限值范围，容差路径行为正确，无需修改。
- **中**：在涉及 Infinity/NaN 边界条件的数学计算中，需将 `==` 替换为 `equalExact()`。此类场景出现频率低，但人工审查成本高于机械替换。

### 11.6 `@OverflowWrapping` 标注继承性验证不通过的备选方案成本

当前设计假设编译器自动生成的复合赋值版本继承二元运算符上的 `@OverflowWrapping` 标注（§4.6、§7 D30）。此行为依赖编译器的未文档化行为。若验证不通过，需切换到备选方案——在已有 20 个 vec-op-scalar 方向扩展成员函数上补充 `@OverflowWrapping` 标注，二元运算符委托给这些函数。

**重要说明**：add/sub/mul/div/mod 的 vec-op-scalar 方向扩展成员函数（`add(v,s)` 等，5 运算 × 4 Vec = 20 个）已在 §4.3 中定义为首轮范围。因此 D30 回退**无需新增函数定义**，仅需完成以下变更。

#### 备选方案变更成本

| 变更项 | 影响范围 | 工作量评估 |
|-------|---------|-----------|
| 为已有 20 个 vec-op-scalar 方向扩展成员函数补充 `@OverflowWrapping` 标注 | 各 Vec 的 extend 块，共 5 函数 × 4 Vec = 20 处标注 | 低（20 处补充标注，机械添加，约 0.5 人天） |
| 二元运算符委托目标修改：从"直接逐分量运算"改为"调用已标注的扩展成员函数" | 各 Vec 结构体内的 5 个运算符实现，修改委托目标 | 低（5 处修改，机械替换，约 0.5 人天） |
| 复合赋值运算符消除 `@OverflowWrapping` 语义（运算符不再直接标注） | 由编译器自动生成，无需修改源码 | 无 |
| `increment()`/`decrement()` 已有 `@OverflowWrapping` 标注 | 已有覆盖，不受影响 | 无 |
| 下游代码影响 | 无——公共 API 签名不变（运算符语法糖不变） | 无 |

#### 迁移工作量合计

- **若标注继承性成立**：当前设计直接使用，无额外迁移成本。
- **若标注继承性不成立**：额外成本约 1 人天（20 处标注补充 + 5 处运算符委托目标修改）。注意：此评估已修正 v8 中将"新增 20 个具名函数"计入工作量的估算——由于函数已存在，实际工作量显著低于原评估。

### 11.7 别名命名约定偏离的迁移成本

本设计采用大写驼峰（PascalCase）别名命名约定（如 `BVec2`、`IVec3`），与 C++ GLM 的小写原生名（`bvec2`、`ivec3`）不一致。此偏离影响所有从 C++ GLM 向量类型名向仓颉别名的迁移代码。

#### 受影响的别名映射

以下完整映射表格覆盖所有 16 个家族 × 4 分量数的默认精度别名。精度前缀别名（`HighpXXX`/`MediumpXXX`/`LowpXXX`）的映射规则与默认精度别名一致——仅在基础名前加精度的 PascalCase 前缀。

| C++ GLM 原生名 | 仓颉 PascalCase 别名 | 映射规则 |
|---------------|---------------------|---------|
| `bvec{1,2,3,4}` | `BVec{1,2,3,4}` | 单字母家族首字母大写 |
| `ivec{1,2,3,4}` | `IVec{1,2,3,4}` | 同上 |
| `uvec{1,2,3,4}` | `UVec{1,2,3,4}` | 同上 |
| `vec{1,2,3,4}` | `Vec{1,2,3,4}` | 首字母大写（与 GLM 原生一致） |
| `dvec{1,2,3,4}` | `DVec{1,2,3,4}` | 首字母大写，保留双字母 |
| `i8vec{1,2,3,4}` | `I8Vec{1,2,3,4}` | 数字前缀家族：数字保持、字母大写 |
| `i16vec{1,2,3,4}` | `I16Vec{1,2,3,4}` | 同上 |
| `i32vec{1,2,3,4}` | `I32Vec{1,2,3,4}` | 同上 |
| `i64vec{1,2,3,4}` | `I64Vec{1,2,3,4}` | 同上 |
| `u8vec{1,2,3,4}` | `U8Vec{1,2,3,4}` | 同上 |
| `u16vec{1,2,3,4}` | `U16Vec{1,2,3,4}` | 同上 |
| `u32vec{1,2,3,4}` | `U32Vec{1,2,3,4}` | 同上 |
| `u64vec{1,2,3,4}` | `U64Vec{1,2,3,4}` | 同上 |
| `fvec{1,2,3,4}` | `FVec{1,2,3,4}` | 首字母大写 |
| `f32vec{1,2,3,4}` | `F32Vec{1,2,3,4}` | 数字前缀家族 |
| `f64vec{1,2,3,4}` | `F64Vec{1,2,3,4}` | 同上 |

#### 机械替换可行性

- **简单搜索替换不可行**：小写 GLM 名（如 `bvec2`）与 PascalCase 名（`BVec2`）无共同子串模式可被正则表达式安全匹配。简单的大小写不敏感搜索将误匹配到仓颉原生的 `Vec2` 等名称。
- **上下文感知替换策略**：推荐在迁移过程中，对每个源文件逐一识别 C++ GLM 原始类型声明并将其替换为对应的仓颉别名。由于 GLM 类型名在 C++ 代码中通常出现在变量声明、函数参数和模板具现化位置，可通过语义感知搜索（如识别类型上下文中的 `bvec`、`ivec` 等关键字）辅助批量替换。
- **迁移工具策略**：
  1. 建立完整映射表（如上表），覆盖 16 家族 × 4 分量数 × 4 精度变体。
  2. 编写搜索脚本，对 `glm/types/\*.hpp` 等源文件提取所有 GLM 类型名引用。
  3. 按映射表逐项替换为 PascalCase 形式（可使用字典映射而非正则搜索）。
  4. 替换完成后编译验证，对编译错误的人工检查漏网之鱼。

#### 迁移工作量评估

- **低**（机械可执行部分）：约 60% 的别名引用可通过上下文感知脚本安全替换（变量声明中的类型名、函数返回类型等），替换后编译验证。
- **中**（人工审查部分）：约 40% 的别名引用需要人工确认（涉及模板嵌套、宏展开、条件编译中的类型名），需逐个审查。总人工审查时间估计：对于中等规模代码库（~50 个源文件），约 0.5-1 人天。

### 11.8 跨 Q 赋值迁移模式

仓颉泛型系统不支持类型参数默认值，所有 Vec 类型的 Q 参数（Qualifier）必须显式写出。C++ GLM 中 `bvec2` 在底层模板化为 `vec<2, bool, defaultp>`，其中 `defaultp` 由默认模板参数隐式提供。迁移至仓颉后，需为每个 Vec 实例显式补全 Q 参数。

#### 需要显式补全 Q 的场景

| 场景 | C++ GLM 代码 | 仓颉等效代码 |
|------|-------------|-------------|
| 变量声明（默认精度） | `bvec2 v;` | `var v: BVec2`（通过别名隐藏 Q） |
| 变量声明（非默认精度） | `highp_bvec2 v;` | `var v: HighpBVec2`（通过别名隐藏 Q） |
| 泛型函数参数（默认精度） | `void foo(vec3 v)` | `func foo(v: Vec3<Float32, PackedHighp>)` 或 `func foo(v: Vec3Float32)` |
| 泛型函数参数（多精度） | `template<typename T, qualifier Q> void foo(vec<3, T, Q> v)` | `func foo<T, Q>(v: Vec3<T, Q>) where Q <: Qualifier` |
| 结构体/类成员 | `struct S { bvec3 v; };` | `struct S { var v: BVec3; }`（通过别名） |
| 容器元素类型 | `std::vector<bvec4>` | `ArrayList<BVec4>`（通过别名） |
| 运算符表达式中间结果 | `vec4 a = b + c;` | `var a: Vec4Float32 = b + c`（变量声明需显式类型，或通过别名） |

#### 可通过别名避免 Q 显式指定的场景

通过 `fwd.cj` 中定义的 256 个别名，以下场景可以隐藏 Q 参数：
- **局部变量声明**：`var v: BVec2 = BVec2(true, false)` — 别名自动绑定 `PackedHighp`。
- **函数返回值**：`func foo(): BVec2 { ... }` — 返回值类型使用别名。
- **容器类型**：`HashSet<BVec2>` — 泛型实参使用别名。
- **函数参数**（非泛型函数）：`func bar(v: BVec2)` — 参数类型使用别名。

#### 无法通过别名避免、必须显式写 Q 的场景

- **泛型函数**：`func foo<T, Q>(v: Vec2<T, Q>) where Q <: Qualifier` — 泛型参数必须作为类型形参传递，无法使用固定别名。
- **跨精度运算**：`let a: Vec2<Float32, PackedHighp> = v1; let b: Vec2<Float32, PackedLowp> = v2;` — 不同精度需要不同 Q 参数。
- **`VecN<T, Q>` 作为另一泛型类型的参数**：`func foo<T>(v: Vec2<T, PackedHighp>)` — 部分具现化时需显式写出 Q。

#### 搜索替换规则

| 搜索目标 | 搜索模式 | 替换策略 |
|---------|---------|---------|
| C++ GLM `bvec2` → 仓颉 `BVec2`（默认精度） | `bvec{1,2,3,4}` | 替换为 `BVec{1,2,3,4}`（PascalCase，如 §11.7 映射表） |
| C++ GLM `highp_bvec2` → 仓颉 `HighpBVec2` | `(lowp\|mediump\|highp)_(b\|i\|u\|vec\|dvec\|...)(1\|2\|3\|4)` | 替换为 `{Precision}{FamilyName}{Dim}` |
| C++ GLM 模板 `vec<2, float, highp>` → 仓颉 `Vec2<Float32, PackedHighp>` | `vec<(1\|2\|3\|4), (类型), (精度)>` | 替换为 `Vec{N}<{类型}, {Packed精度}>` |
| 跨 Vec 转换（Q 不同） | `Vec2<Float32, PackedHighp>` → `Vec2<Float32, PackedLowp>` | 通过泛型构造函数自动转换（`init<T2, Q2>(v: VecN<T2, Q2>)`） |

#### 自动化工具可行性

- **高可行性**：搜索替换规则中，C++ GLM 的小写别名（`bvec2`、`ivec3` 等）到仓颉 PascalCase 别名（`BVec2`、`IVec3`）的替换是完全机械的，可通过字典映射脚本安全执行。
- **中可行性**：模板形式（`vec<2, float, highp>` → `Vec2<Float32, PackedHighp>`）的替换需要语义解析（识别 GLM 类型名到仓颉类型的映射），建议使用 AST 级别的代码转换工具。
- **低可行性**：泛型函数参数中 `Q` 的传播（如 `template<typename Q> void foo(vec<2, float, Q>)` → `func foo<Q>(v: Vec2<Float32, Q>) where Q <: Qualifier`）需要理解 C++ 模板参数的传递关系，建议人工处理。

#### 迁移工作量评估

- **别名场景**（通过别名隐藏 Q，占 ~70%）：低，机械替换，约 0.5 人天。
- **泛型场景**（必须显式写出 Q，占 ~20%）：中，需人工确认泛型函数的 Q 参数传播，约 1-2 人天。
- **跨精度场景**（手动指定不同 Q，占 ~10%）：低-中，逐处审查，约 0.5 人天。
- **合计评估**：约 2-3 人天（包括脚本编写与审查）。

### 11.9 `equalExact` 迁移模式

C++ GLM 中 Vec 类型的 `==` 运算符使用 IEEE 754 精确相等语义——浮点分量直接通过 `==` 比较，`Inf == Inf` 返回 `true`，`NaN == NaN` 返回 `false`。迁移到仓颉后，`==` 默认使用容差比较路径（§4.5），`Inf == Inf` 因容差路径中的减法表达式产生 `NaN` 而返回 `false`。原 C++ 代码中依赖 IEEE 754 精确 `==` 语义的场景需要被识别并替换为 `equalExact()`。

#### 行为差异对照

| 比较场景 | C++ GLM `==`（IEEE 754 精确） | 仓颉 `==`（容差路径） | 仓颉 `equalExact()` |
|---------|------------------------------|---------------------|-------------------|
| 有限值微差比较 | 精确比较，微差视为不等 | 在 epsilon 范围内视为相等 | 精确比较，微差视为不等 |
| `Inf == Inf` | `true` | `false`（因 `Inf-Inf=NaN`） | `true` |
| `NaN == x`（任意 x，含 NaN） | `false` | `false`（`NaN <= epsilon` 恒 `false`） | `false` |
| 整数/Bool 比较 | 精确比较 | 精确比较（走 `else` 分支） | 精确比较（等价于 `==`） |

#### 需要替换的场景清单

| 场景 | 识别特征 | 替换策略 |
|------|---------|---------|
| **Infinity 边界值比较** | Vec 参与涉及 `±Inf` 的比较，如 `v == Vec4(Inf)` | 替换为 `v.equalExact(Vec4(Inf))` |
| **NaN 检测** | 使用 `v == VecN(NaN)` 检测 NaN（CNaN 检测在 IEEE 754 中永远返回 false，迁移后行为不变，无需替换） | 维持原样（行为一致）或不使用 `==` 检测 NaN |
| **精确相等语义要求** | 算法逻辑依赖 IEEE 754 精确比较（如坐标精确匹配判定） | 替换为 `v1.equalExact(v2)` |
| **整数/Bool Vec 比较** | 整数或 Bool 分量的 Vec `==` 比较 | 无需替换（行为等价） |
| **容差路径回退后** | 若 `const operator ==` 因 D29 回退到精确比较路径 | 无需替换（`==` 与 `equalExact` 行为完全等价） |

#### 搜索替换规则

| 搜索模式 | 替换目标 | 优先级 | 自动化可行性 |
|---------|---------|--------|-----------|
| 浮点 Vec 变量上的 `==` 表达式，且操作数可能含 `±Inf`/`NaN` | 替换为 `.equalExact()` | 中（仅在关键路径中需要精确语义时执行） | 低（需语义分析识别 Infinity/NaN 上下文） |
| 性能关键路径上的 `==`（需避免容差比较开销） | 替换为 `.equalExact()` | 低（可选优化） | 低（需人工识别） |
| 整数/Bool Vec 的 `==` | 维持原样 | — | — |

#### 迁移工作量评估

- **机械可替换部分**（有限值场景无需替换，占 ~80%）：无迁移成本——大多数浮点 Vec 的 `==` 比较涉及有限值范围，容差路径行为正确，无需修改。
- **人工审查部分**（涉及 Inf/NaN 或精确相等语义，占 ~20%）：需逐一审查代码中浮点 Vec `==` 的使用上下文，判断是否需要替换为 `equalExact()`。涉及 Inf/NaN 边界条件的数学计算、坐标精确匹配判定等场景需重点审查。对于中等规模代码库（~50 个源文件），人工审查时间约 0.5-1 人天。
- **回退路径豁免**：若 `const operator ==` 因 D29 回退到精确比较路径，`==` 与 `equalExact()` 行为完全等价，此模式下 §11.9 定义的替换策略可整体跳过（零迁移成本），但 `equalExact()` 仍保留作为语义明确的独立 API 供下游选择使用。
- **合计评估**：约 0.5-1 人天（人工审查），若触发 D29 回退则降为 0。

### 11.10 标量在左运算的具名函数替换

标量在左、向量在右的运算（`scalar + vec`、`scalar - vec`、`scalar / vec`）因仓颉运算符重载规则不可实现（§4.3、§7 D10），需替换为具名函数 `add(s, v)`、`sub(s, v)`、`div(s, v)` 等。

#### 受影响的表达式模式

| C++ GLM 代码 | 仓颉等效代码 | 搜索规则 |
|-------------|-------------|---------|
| `s + v`（s 为标量，v 为 Vec） | `add(s, v)` | 在 Vec 类型上下文中搜索标量在左、Vec 在右的 `+` |
| `s - v` | `sub(s, v)` | 同上 |
| `s * v` | `mul(s, v)` | 同上（注意：`v * s` 已在运算符层面支持，本项特指标量在左） |
| `s / v` | `div(s, v)` | 同上 |
| `s % v` | `mod(s, v)` | 同上 |

#### 与 vec-op-scalar 方向扩展成员函数的关系和选择指南

具名函数有两个方向，调用方应根据操作数顺序和上下文选择：

| 方向 | 语法 | 定义位置 | 适用场景 |
|------|------|---------|---------|
| vec-op-scalar（扩展成员函数） | `v.add(s)` | `type_vecN.cj` 的 `extend` 块 | 操作数顺序为 vec 在左、标量在右；与 `v + s` 功能等价 |
| scalar-op-vec（包级独立函数，本节主题） | `add(s, v)` | `scalar_vec_ops.cj` | 操作数顺序为标量在左、Vec 在右；覆盖二元运算符不可表达的顺序 |

**选择指南**：若 C++ 原代码中操作数顺序为 `vec + scalar`，优先使用仓颉二元运算符 `v + s`（语法最简洁）；若原代码为 `scalar + vec`，则必须使用 `add(s, v)`。`v.add(s)`（扩展成员函数）与 `v + s` 功能等价，仅在需要显式方法传递或为未来 SIMD 替换预留时使用。

#### 搜索替换规则

| 源模式 | 替换目标 | 自动化可行性 |
|-------|---------|-----------|
| 标量字面量在左（如 `3.0f + v`） | `add(3.0f, v)` | 中——可通过正则 `[0-9.]+[fF]?\s*[+\-*/%]\s*\w+` 识别 |
| 标量变量在左（如 `s + v`，s 为标量变量） | `add(s, v)` | 低——需类型推断确认左操作数为标量类型 |
| `s * v`（标量在左） | `mul(s, v)` | 中——通过左操作数非 Vec 类型的特征识别 |
| `s / v`（标量在左） | `div(s, v)` | 同 `*` |
| `s - v`（标量在左） | `sub(s, v)` | 同 `*` |
| `s % v`（标量在左） | `mod(s, v)` | 同 `*` |

#### 工作量评估

- **机械可替换部分**（标量字面量在左的场景，占 ~30%）：正则搜索替换，约 0.5 人天。
- **人工审查部分**（标量变量在左的场景，占 ~70%）：需逐处阅读代码上下文判断左操作数类型，约 1-2 人天。
- **合计评估**：约 1.5-2.5 人天，覆盖全部 5 个运算（add/sub/mul/div/mod）。

---

## 12. 实现验证与验收策略

### 12.1 验证层次

首轮实现完成后，从以下三个层次验证正确性：

#### 层次一：编译验证
- 每个 `.cj` 文件可独立通过 `cjc` 编译（包内依赖闭合）。
- `type_vecN.cj` 在 `T = Int32`、`Float32`、`Bool` 三种分量类型及 `Q = PackedHighp`、`PackedLowp` 两种精度策略下可实例化编译通过。
- `fwd.cj` 中全部 256 个别名编译后不产生重复定义错误。
- 验证命令：`cjpm build` 无报错。

#### 层次二：构造与访问验证
- 每种 Vec 类型（Vec1~Vec4）每种构造方式（标量填充、逐分量、跨 Vec 转换、跨分量数组合）至少构造一个实例。
- 下标运算符正/边界测试：索引 0 到 N-1 返回正确分量；索引越界触发断言。
- 具名分量访问（`x`/`y`/`z`/`w`）返回值正确。
- `componentAt` const 访问：在 `const` 函数体内调用 `componentAt(i)` 验证正确性，与 `operator[]` 取值形式行为一致。

#### 层次三：运算正确性验证
- **算术运算**：对 `Vec4<Int32>` 和 `Vec4<Float32>` 分别验证 `+`、`-`、`*`、`/`、`-`（一元）的正确性。验证 `Vec4<Int32>` 的 `%`。验证复合赋值（`+=`、`-=` 等）语义与二元运算符一致。
- **溢出验证**：验证 `@OverflowWrapping` 标注的二元算术运算在整数溢出时 wrapping 而非抛异常。构造 `Vec2<UInt8>(255, 128) + Vec2<UInt8>(1, 128)`，期望结果为 `(0, 0)`（wrapping）。
- **位运算**：对 `Vec4<Int32>` 验证 `&`、`|`、`^`、`<<`、`>>`。验证 `<<` 的 `@OverflowWrapping` 语义（`Vec2<UInt8>(1, 128) << 1` 期望 `(2, 0)`）。
- **`bitwiseNot()`/`increment()`/`decrement()`**：验证整数分量下的正确性。验证 `Vec4<Float32>.bitwiseNot()` 产生编译错误。
- **比较运算**：验证 `==` 在整数和浮点分量下的正确性（浮点容差比较）。验证 `!=` 为 `!(==)` 的等价性。
- **`equalExact`**：验证浮点 Vec 上 `equalExact(Infinity)` 返回 `true`；`equalExact(NaN)` 返回 `false`；整数/Bool Vec 上 `equalExact` 行为与 `==` 等价（均走精确比较路径）；验证 `equalExact` 与 `==` 在容差路径下的行为差异——对有限值 `equalExact` 使用精确比较（可能因浮点舍入将微差视为不等）而 `==` 使用容差比较（在 epsilon 范围内视为相等）。**回退路径等价性测试**：手动修改 `==` 实现为精确比较后，验证 `==` 与 `equalExact` 对所有输入（含 Inf/NaN）下的输出一致。
- **布尔逻辑**：对 `Vec2<Bool>` 验证 `logicalAnd`、`logicalOr`、`!` 的正确性。

#### 层次四：异常场景与边界验证（补充）
- **零向量算术**：`Vec3<Int32>(0,0,0) + Vec3<Int32>(1,2,3)` 返回 `(1,2,3)`。`Vec4<Float32>(0,0,0,0) * Float32(5)` 返回 `(0,0,0,0)`。
- **除零行为**：整数 Vec 除以 0 抛 `ArithmeticException`。浮点 Vec 除以 0 返回 `±Inf` 分量（无异常）。
- **NaN/Infinity 传播**：构造包含 `Float32.NaN` 分量的 Vec，验证 `+` 运算中 NaN 传播。构造包含 `Float32.Infinity` 分量的 Vec，验证算术运算。
- **类型转换边界**：`Vec2<Int64>(Int64.Max, Int64.Max)` 转为 `Vec2<Int32>` 验证 wrapping 截断。`Vec2<Float64>(1.79e308, -1.79e308)` 转为 `Vec2<Float32>` 验证 ±Inf 传播。
- **Bool Vec 行为**：验证 `Vec2<Bool>` 的 `&`/`|`/`^`/`!` 运算正确性。验证 `Vec2<Bool> + Vec2<Bool>` 产生编译错误。

### 12.2 验收标准

对照 roadmap §4.4 验证标准摘要：

| 验收项 | 标准 | 验证方法 |
|--------|------|---------|
| 编译通过性 | 全量编译无语法/类型错误 | `cjpm build` |
| 构造完备性 | 支持 §4.1 约定的所有构造函数形态 | 层次二测试覆盖 |
| 运算等价性 | 基本算术/位运算结果与 C++ GLM 对应类型一致（在绕过了运算符重载差异的前提下） | 层次三测试 + 与 C++ 等效代码逐值比较 |
| 溢出行为 | `@OverflowWrapping` 标注的运算在整数溢出时 wrapping 而非抛异常 | 层次三溢出验证 |
| 边界行为 | §9 约定的零向量、除零、NaN/Infinity 传播、类型转换边界行为与约定一致 | 层次四异常场景测试 |
| 别名覆盖 | `fwd.cj` 中**256 个别名全量正确定义和使用**，无重复定义或缺失错误。此为首轮强制交付标准，不可降级 | `cjpm build` + 确认每个别名家族（16 家族）至少各验证一个分量数和一个精度变体的可实例化 |
| equalExact 正确性 | 浮点 Vec 上 `equalExact(Inf)` 返回 `true`；`equalExact(NaN)` 返回 `false`；整数 Vec 上与 `==` 行为等价 | 层次三测试 + 边界值验证 |
| public const init 外部可构造 | 从独立测试包中通过 `import glm.Vec2` 导入后，`Vec2<Float32, PackedHighp>(1.0f, 2.0f)` 构造可编译通过 | 在独立测试包中编写 `import glm.Vec2` 并执行构造验证 |
| componentAt const 访问正确性 | const 函数体内调用 `componentAt(i)` 返回值与相同索引的 `operator[]` 取值形式一致；越界时触发断言 | §12.1 层次二 `componentAt` 验证项通过 |
| 公共 API 导入 | 下游消费者通过 `import glm.Vec2` 等直接导入向量类型，无需引用 `glm.detail` 包路径 | 在独立测试包中编写 `import glm.*` 测试代码，确认 `Vec2<Float32, PackedHighp>` 可通过 `glm` 包直接使用且类型完整 |
| 公共 API 重导出 | `lib.cj` 中的 `public import` 覆盖所有公共 API 类型（Vec1~Vec4、Qualifier 及实现类型） | 审查 `lib.cj` 的 `public import` 列表覆盖 §3.1 和 §3.2 中定义的公开类型；确认 `glm.detail` 内部类型（shim、functor、compute_vector_decl）对下游不可见 |
| 跨类型操作限制 | 跨类型运算（如 `Vec2<Int32> + Vec2<Int16>`）产生编译错误 | 编译测试 |
| `<`/`<=`/`>`/`>=` 缺失确认 | 使用这些运算符的 Vec 表达式产生编译错误 | 编译测试 |
| Bool Vec 行为一致性 | `VecN<Bool>` 各运算的行为与 §3.2 约定一致 | 层次三布尔逻辑测试 + 编译测试验证算术/移位报错 |
| Qualifier 跨 Q 转换 | 不同 Qualifier 之间（如 `PackedHighp` ↔ `PackedLowp`）的 Vec 转换构造可编译通过与正确运行 | 编写 `Vec2<Float32, PackedHighp>` 跨 Q 转换为 `Vec2<Float32, PackedLowp>` 的测试代码，验证构造及后续运算正确性 |
| 哈希集合可用性 | 整数/Bool/浮点分量 Vec 均可正常用作 `HashSet`/`HashMap` 键 | 编译测试：`HashSet<Vec2<Int32, PackedHighp>>`、`HashSet<Vec2<Float32, PackedHighp>>`、`HashSet<Vec2<Bool, PackedHighp>>` 均通过编译 |
| Hashable 契约限制文档化 | 浮点 Vec 的 Hashable 契约限制（`hashCode()` 与容差 `==` 不一致）在文档中被标注 | 审查 §3.2 Hashable 实现策略段落，确认包含浮点 Vec 的限制说明文本 |

### 12.3 测试工具

首轮验证使用仓颉内置 `@Test`/`@TestCase` 框架（`std.unittest`），编写端到端验证函数覆盖 §12.1 的验证层次。

**测试包组织结构**：
- 测试包命名空间与源码包一一对应：`tests/glm/detail/` 目录下的测试对应 `package glm.detail`，`tests/glm/` 目录下的测试对应 `package glm`。
- **对 `internal` 类型的访问策略**：需要测试 `glm.detail` 中 `internal` 可见性类型（如 AlignedHighp/AlignedMediump/AlignedLowp）的测试代码，放置在 `tests/glm/detail/` 包中，并显式 `import glm.detail.*`。此策略的假设：Cangjie 的包可见性规则允许同一包内的跨文件访问 `internal` 成员，因此测试代码可访问 `glm.detail` 中的 `internal` 声明而无需将测试目标提升为 `public`。**此假设未经验证**——依赖 Cangjie 编译器对 `internal` 可见性跨文件解析的实现策略。编码阶段需编写原型测试验证：在 `tests/glm.detail/` 目录下创建测试文件（声明 `package glm.detail`），尝试实例化 `AlignedHighp` 类型。若编译通过，假设成立；若失败，则需将 AlignedHighp/AlignedMediump/AlignedLowp 的可见性从 `internal` 提升为 `public`（或 `protected`），并相应更新 `lib.cj` 的导出列表。
- **公共 API 测试**：只需访问 `glm` 包公共 API 的测试放置在 `tests/glm/` 包中，通过 `import glm.*` 导入，遵循普通下游消费者的访问路径。
- **测试文件组织**：每个 `type_vecN.cj` 对应一个 `test_type_vecN.cj` 测试文件；shim 层的测试集中在 `test_shims.cj` 中；别名验证测试放置在 `test_fwd.cj` 中。

---

## 附录：历史修订说明

本附录集中存放历次迭代的修订记录，分属两个审议周期：

- **新审议轮次**（版本号 v2~v13，标识为"审查迭代修订版"或裸数字）：对应当前审议流程内的逐轮迭代修改。v2~v6 为早期轮次（倒序排），v7~v13 为后续轮次（正序排）。
- **旧审议轮次**（版本号 v7~v15，标识如"第二轮"或裸数字）：对应上一审议周期的历史记录。
两段之间以 `---` 分隔线加注释标题区分。

--- 新审议轮次（早期，v6~v2 倒序）---

### 修订说明（v6）

| 审查意见 | 修改措施 |
|---------|---------|
| **P1（严重）**：§3.2 Vec结构体系第154行`length()`函数声明缺少`const`修饰符 | 已在原文中确认 `const public static func length(): Int64`（已含 `const`），无需额外修改 |
| **P2（严重）**：§7设计决策节D31之后缺少D32（add/sub/mul/div/mod统一声明为const函数） | 已在原文中确认 D32 存在于 §7 正文（D31 之后），无需额外修改 |
| **P3（严重）**：§7 D13声明"浮点取模的具名函数方案不属于首轮范围"，但§4.3已将`mod`列为首轮具名函数并给出完整浮点取模实现策略 | §7 D13 理由末句修正：将"不属于首轮范围"改为"属于首轮范围"，并引用具名函数 `mod` 的名称，与 §4.3 保持一致 |
| **P4（中等）**：§7 D29（const路径验证）和§7 D30（@OverflowWrapping继承性验证）各自定义了独立的回退方案，但未考虑两者同时失败的组合场景 | 在 D30 决策路径之后新增"组合回退场景分析"子节，以状态表形式评估三项组合（通过+通过、回退+通过、任意+回退）的交互影响。结论：两项回退独立正交，无冲突 |
| **P5（中等）**：`increment()`/`decrement()`/`bitwiseNot()`未被声明为`const`函数，但与已声明`const`的`add()`/`sub()`等同样为纯函数，缺少对称性理由 | §7 新增 D33 设计决策，统一声明三者为 `const` 函数并给出理由（纯函数、API 一致性、const 上下文可用性） |
| **P6（中等）**：§3.8定义的大写驼峰别名未评估对新代码开发的长期认知负担 | §3.8 末尾新增"命名差异的长期影响"段落，评估过渡期映射成本及缓解措施 |
| **P7（一般）**：§3.5关于`epsilonOf<T>()`的兼容性策略仍使用"采取以下方案之一"的表述 | §3.5 兼容性策略修正：将"采取以下方案之一"改为"采用以下唯一策略" |
| **P8（一般）**：未建立原型测试验证`@OverflowWrapping`与`const`共存于同一函数的场景 | §10 新增"@OverflowWrapping 与 const 函数共存验证"子节 |

### 修订说明（v5）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题 1（中等）**：`mod` 具名函数使用 `const if` 但未标注 `const` 修饰符 | §4.3 将 `mod` 标注为 `const` 函数；同步将 `add`/`sub`/`mul`/`div` 统一声明为 `const`。§7 新增 D32 |
| **问题 2（一般）**：`length()` 缺少 `const` 修饰符 | 修正为 `const public static func length(): Int64` |

### 修订说明（v4 — 审查迭代修订版）

针对 `bitwiseNot()` 排除策略不可行、PascalCase 别名迁移成本未覆盖、跨 Q 赋值迁移模式未覆盖、`NumericLimits<Bool>` 特化不可行、const 版本 `operator[]` 缺失、浮点 `mod` 边界值验证不足等 6 项审查意见的修改。

### 修订说明（v3 — 审查迭代修订版）

针对 §8.1/§8.2 编号不一致、D25-D27 未纳入主决策节、`mod` 浮点实现方案缺失、Vec1 `const init` 角色不明确、测试组织结构缺失等 6 项审查意见的修改。

### 修订说明（v2 — 审查迭代修订版）

针对 `equalExact` const 声明验证、`Inf == Inf` 容差路径差异及迁移成本、`epsilonOf<T>()` 约束兼容性、`if (T(0) is Float64)` 核心依赖验证、`@OverflowWrapping` 继承性验证、命名空间污染风险评估等 12 项审查意见的修改。

--- 旧审议轮次（v15~v7 倒序）---

### 修订说明（v15）

针对 Vec1/Vec2/Vec3 截断构造函数缺失（6 个）、Vec3 Vec2+Vec1 组合构造缺失、`mod` 首轮可用性矛盾、`lib.cj` 导出 `scalar-op-vec` 函数、设计决策编号顺序混乱等 5 项审查意见的修改。

### 修订说明（v14）

针对 `equalExact` 改为 `const` 函数、`epsilonOf<T>()` 签名显式定义、`equalExact` 验证层次补充、Float16 对照表附注修正、文档版本标识更新等 5 项审查意见的修改。

### 修订说明（v13）

针对别名命名约定冲突、`scalar op vec` 具名函数定义位置未指定、Aligned* 可见性策略未明确、`compute_vector_relational.cj` 依赖声明错误、`LengthT` 使用边界、`equalExact` 函数、字符串表示策略等 7 项审查意见的修改。

### 修订说明（v12）

针对 Hashable 实现策略不可行（`@Derive[Hashable]` 自动覆盖浮点 Vec）的严重问题的修改。

### 修订说明（v11）

针对 Hashable 实现缺失、Vec2/Vec3 构造函数不完整、`ComputeEqual` 被 `public import` 暴露、Float16 验证风险、`bitwiseNot()` 迁移影响未评估、字符串表示未覆盖等 7 项审查意见的修改。

### 修订说明（v10）

针对 `operator[]` 赋值形式缺少 `mut`、`const operator ==` 表达式链 const 兼容性评估、`@OverflowWrapping` 继承性验证、`Vec<Bool, Q>` 抽象类型引用、跨类型 fill-from-Vec1 构造器限制、`increment()`/`decrement()` 迁移模式补充、配置常量 `Int` 类型修正等 7 项审查意见的修改。

### 修订说明（v9）

针对别名目标数量不一致（3 处）、`public import` 公共 API 面缺失、roadmap 范围可追溯性映射缺失、配置常量子常量引用不完整、Qualifier 运行时行为约定缺失等 5 项审查意见的修改。

### 修订说明（v8 — 第二轮）

针对 `const init` 与普通 `init` 重载冲突、`bitwiseNot()` Bool 行为表述矛盾的修改。

### 新增设计决策（v8）

新增 D25（`VecN<Bool,Q>.bitwiseNot()` 行为差异认定）、D26（跨类型构造函数标量参数使用目标类型）、D27（Qualifier 跨 Q 赋值/转换行为约定）三条设计决策。

### 修订说明（v8）

针对 `bitwiseNot()` Bool 行为等价性声明错误、`GLM_CONFIG_CLIP_CONTROL` 默认值错误、跨类型构造标量参数错误等 4 项审查意见的修改。

### 修订说明（v7 — 第二轮）

针对类型参数默认值语法不支持、`countof` 签名不合法的修改。

### 修订说明（v7）

针对 `<<` 运算符移位量类型、`@OverflowWrapping` 标注策略声明、构造函数体系自包含、别名分级表格数值、`<`/`<=`/`>`/`>=` 运算符覆盖、`storage<L,T,Q>` 省略理由、辅助设施省略理由、Vec 类型参数默认值、Bool Vec 行为约定、配置常量类型选择、`operator[]` 索引类型选择、NaN/Infinity 比较描述、迁移验证标准覆盖等 14 项审查意见的修改。

--- 新审议轮次（后续，v7~v13 正序）---

## 修订说明（v7 — 审查迭代修订版）

| 审查意见 | 修改措施 |
|---------|---------|
| **P1（严重）** — 文档版本标识自相矛盾：标题为 v5、路径名为 v6、修订说明序列混乱 | ① 文档标题统一为 v7；② 在标题下方新增版本变更摘要行；③ 历史修订说明全部移入附录，按时间倒序组织；④ 末尾追加本条当前修订说明 |
| **P2（严重）** — 缺少包构建基础设施定义，无法直接指导编码启动 | §2 新增「项目初始化与构建基础设施」子节，包含 cjpm.toml 模板、初始目录结构、cjpm build/test 命令、首次编码前原型验证要求 |
| **P3（严重）** — D32 声明 40 个算术函数为 const 但 const 兼容性验证计划（D29）未覆盖 | §7 D32 新增「const 兼容性验证要求」子节，包含核心类型验证、mod const if 验证、非核心类型延迟检查三张验证表和对应回退方案 |
| **P4（中等）** — compute_vector_decl.cj 的双重角色架构层次模糊 | 将 scalar-op-vec 方向辅助函数独立为 `scalar_vec_ops.cj` 文件。更新 §2 模块划分、模块依赖图、§4.3 函数定义位置、§7 D16 决策描述 |
| **P5（中等）** — Float16 的 T(0) const 构造兼容性未在验证计划中覆盖 | §10 设计阶段验证表依赖①的验证方法中，验证类型列表新增 `Float16` |
| **P6（中等）** — 缺少增量验证节点，迁移顺序无法作为编码质量门禁 | §8.3 重写为「迁移顺序（含增量验证节点）」表格，为每个迁移阶段定义增量验证标准 |
| **P7（一般）** — §9 异常场景表引用了 equalEpsilon 但该函数未在首轮范围内 | §9.3 `NumericLimits<T>.epsilon()` 与 Infinity 行将 `equalEpsilon` 替换为 `equalExact`，补充说明后者已在 §4.5 定义且属于首轮范围 |
| **P8（一般）** — 256 个别名降级策略的触发条件语焉不详 | §3.8 降级策略补充量化触发条件（编译时间 >30min 或产物 >5MB）、审批路径（实施者→主 Agent→范围变更日志）、剩余别名补全期限（首轮验收后 4 周内） |
| **P9（一般）** — lib.cj 的 public import 行在文档多处位置不一致 | §2 公共 API 面设计以完整代码块形式给出 lib.cj 全部内容，含 `public import glm.scalar_vec_ops.*` 和 `public import glm.fwd.*` |
| **P11（中等）** — lib.cj 未重导出 fwd.cj 的别名，下游导入路径不完整 | §2 lib.cj 新增 `public import glm.fwd.*` 行；公共 API 面设计说明同步更新 |
| **P12（中等）** — logicalAnd/logicalOr 的函数形态未明确指定 | §4.5 布尔逻辑运算中明确 `logicalAnd`/`logicalOr` 定义为扩展成员函数，给出调用语法 |
| **P13（一般）** — §6 并发设计过于简略，未覆盖 Vec 在并发容器中的行为、复合赋值非原子性等场景 | §6 扩展为多线程场景表格，覆盖 Vec 在线程间传递、并发容器行为、复合赋值非原子性、@OverflowWrapping 与并发、const 函数与并发等 5 项 |
| **P14（一般）** — §9.4 Bool 到数值类型转换约定与 D14 跨类型转换策略不一致 | §9.4 Bool→数值行重写：增加方案 A（编译期 `const if` 约束，优先）和方案 B（运行时 `if` 分支显式处理，兜底） |
| **P15（一般）** — 256 个别名的外部脚本生成策略缺少产出规范和验证要求 | §3.8 外部脚本生成策略补充：输出路径、格式约定、版本控制策略、产物审查要求 |
| **P16（严重）** — mod 函数的 const if 分支依赖编译期死代码消除，行为未经验证 | §10 新增「`const if` 编译抑制行为验证」子节，列 3 项验证依赖；验证项①为编码前原型验证（与 D29/D30 同级）；定义回退方案（拆分为 modInt/modFloat）；标注严重风险 |
| **P17（中等）** — 256 个别名在单文件中的组织方式未定义 | §3.8 新增 fwd.cj 预期文件结构示例，含分组注释、排序约定、文件头格式；明确 256 个别名集中在单文件 |
| **P18（中等）** — Hashable 契约冲突未在验收标准中充分体现 | §12.2 验收标准表新增"Hashable 契约限制文档化"项，验证注释中包含浮点 Vec 的 Hashable 契约限制说明 |
| **P19（一般）** — componentAt 函数未纳入 Vec 类型函数清单 | §4.2 中 componentAt 说明重写，以完整仓颉签名 `public const func componentAt(i: Int64): T` 显式列出 |
| **P20（一般）** — @OverflowWrapping 与 const 函数共存验证计划缺少宽类型边界用例 | §10 @OverflowWrapping 共存验证表依赖②验证方法扩展：覆盖 `UInt8(255)+1`、`Int8(127)+1`、`Int64.Max+1` 三种代表性类型 |

---

## 修订说明（v8 — 审查迭代修订版）

| 审查意见 | 修改措施 |
|---------|---------|
| **P1（严重）** — `const` 扩展成员函数的多处声明依据不足。仓颉 extend 块中允许的修饰符不包含 `const`，涉及 §4.4 bitwiseNot()、§4.5 equalExact()、logicalAnd/logicalOr 及 §7 D33 的 const 化决议 | ① §3.2 Vec 结构体系修正：删除"extend 块中也可定义 const 实例成员函数"的声明，改为说明 extend 块不允许 const 修饰符；② §4.4 bitwiseNot() 示例中移除 `const`，补充 extend 块不支持 `const` 的注释；③ §4.5 equalExact() 修正为声明为非 `const`，重写 const 声明验证段落，说明若需 const 调用可移至 struct 体内定义；④ §4.5 logicalAnd/logicalOr 标记为非 `const`；⑤ §4.3 vec-op-scalar 方向具名函数（add/sub/mul/div/mod 的扩展成员函数版本）标记为非 `const`，scalar-op-vec 方向（包级独立函数）保持 `const`；⑥ §7 D32 重写为"const 声明策略"——区分扩展成员函数（非 `const`）和包级独立函数（`const`）；验证计划更新为 20 个包级函数验证；扩展成员函数的回退方案；⑦ §7 D33 重写为"const 声明策略"——increment/decrement/bitwiseNot 因在 extend 块中声明为非 `const`；补充备选方案（移至 struct 体内声明为 `const`） |
| **P2（中等）** — §9.4 Bool→数值转换的 `if (T2 is Bool)` 语法可行性未验证——`is` 运算符是值级类型检测而非类型参数级检测 | §9.4 重写：明确说明 `T2 is Bool` 语法不可行（`is` 需要值表达式而非类型参数）；原方案 A 改为分量值检测方案（`if (v.x is Bool)`），但运行时分支（方案 B）为首选推荐路径；优先采用方案 B（运行时兜底），理由：避免 `const if` 依赖、非热路径、可行性有保障 |
| **P3（中等）** — §8.1 迁移文件清单未覆盖测试文件，编码启动指引存在缺口 | §8.1 新增"对应测试文件清单"子表（T1~T14），每个迁移文件对应独立测试文件，含验证说明 |
| **P4（中等）** — §4.4 `<<` 默认溢出策略的事实准确性依赖编译器行为验证——`ThrowingOp<T>` 不包含 `throwingShl` | §4.4 溢出策略重写：从"仓颉中 `<<` 默认使用 `@OverflowThrowing` 策略"改为"`<<` 的默认溢出策略属于编译器实现定义行为，`ThrowingOp<T>` 不包含 `throwingShl`"；标注为编码阶段待验证假设 |
| **P5（一般）** — 构造函数体系对 `Q` 参数的约束充分性存疑，跨 Q 类型构造的重载解析风险需验证 | §4.1 构造函数清单后新增"跨 Q 构造函数重载解析风险与约束验证"段落，分析已知安全场景和风险领域，定义编码阶段原型验证要求及回退策略 |
| **P6（一般）** — `const if` 编译期分支抑制依赖的综合评估未反映在验证计划中——§10 验证计划对 `const if` 非选择分支抑制的覆盖不完整 | §10 将原有的 `mod` 函数 const if 抑制验证扩展为"`const if` 编译抑制行为综合验证"子节，以统一清单形式列出所有 5 个依赖点（A~E），提供统一原型测试方法，为每个依赖点定义独立回退方案 |
| **P7（一般）** — 对"参考实现"的使用策略未说明——未定义编码阶段如何利用 `references/glm-1.0.3/` 目录验证设计正确性 | §8.3 后新增"§8.4 参考实现使用策略"，定义 6 条使用策略：行为确认、构造函数清单验证、运算符行为对标、配置宏确认、命名映射、非首轮内容边界 |

---

## 修订说明（v8 — 审查迭代修订版 v2）

| 审查意见 | 修改措施 |
|---------|---------|
| **P1（严重）** — §4.4 bitwiseNot() 仍声明为 `const` 扩展成员函数（"通过 `extend` 块定义为 `const` 扩展成员函数"），与确认的"extend 块不允许 `const` 修饰符"自相矛盾 | 将 §4.4 bitwiseNot() 描述修正为"通过 `extend` 块定义为非 `const` 扩展成员函数（仓颉扩展语法不允许 `const` 修饰符）"，与 §3.2、§4.5、§7 D32/D33 的策略保持全局一致 |
| **P（中等）** — D30 组合回退场景分析缺少"`const` 在 extend 块中不可用"与"`@OverflowWrapping` 继承性不成立"的交互分析——两者同时失败时，算术运算符既无法通过继承性自动获得 wrapping 语义，也无法通过 extend 块中的 const 具名函数实现 | 在 D30 组合回退场景分析后新增"「const 在 extend 块中不可用」与 D30 交互说明"子节，分析 const-in-extend × D30 的三维组合状态表；结论：本设计已全局将所有扩展成员函数声明为非 `const`，D30 备选方案的算术具名函数在此策略下无交互冲突 |

---

## 修订说明（v9 — 审查迭代修订版）

| 审查意见 | 修改措施 |
|---------|---------|
| **P1（严重）** — 扩展成员函数 add/sub/mul/div/mod（vec-op-scalar 方向）缺少 `@OverflowWrapping` 标注策略。§4.3 定义的扩展成员函数功能上与二元运算符等价，但 §4.6 标注分布表未覆盖这 20 个函数。文档未指定实现模式应委托给已标注的运算符还是独立标注，实施者面临歧义 | §4.3 `@OverflowWrapping` 标注策略新增独立段落：20 个 vec-op-scalar 方向扩展成员函数内部实现委托给对应 Vec 的二元算术运算符（后者已标注 `@OverflowWrapping`），通过委托隐式获得 wrapping 语义，无需额外标注。§4.6 标注分布表新增对应条目，§4.6 总结同步更新。全局一致：委托策略确保扩展成员函数与二元运算符的溢出行为完全一致 |
| **P2（中等）** — Vec1 构造函数接口的不对称性缺少说明。Vec1 仅提供 `const init(x: T)`，无 `public init(scalar: T)`（因参数列表相同、const 不构成重载区分依据），但文档未在任何位置解释此不对称性原因 | §4.1 Vec1 构造函数清单之后新增"Vec1 构造函数接口不对称性说明"段落，解释 `const init(x: T)` 与 `public init(scalar: T)` 参数列表冲突的技术原因（const 不构成重载区分依据），并说明 Vec2~Vec4 不受此影响的原因 |
| **P3（中等）** — `countof` 辅助函数的范围跟踪遗漏。§3.6 决定不映射 countof，但 §8.2 范围可追溯性对照表中该偏离标注为"无偏离"，存在内容完备性缺口 | §8.2 范围可追溯性对照表 S3 行修正：从"无偏离"改为"偏离"，补充 `countof` 不映射的理由说明（VArray 的 `$N` 须为固定字面量）及替代方案（`size` 属性/`LengthT`） |
| **P4（中等）** — 跨类型构造函数（`init<T2, Q2>(v: VecN<T2, Q2>)`）的 T2 有效性范围未集中归档。§4.1 构造函数清单对 T2 无任何约束，§9.4 的转换边界表补充了类型约束但两者分离，编码时需交叉查阅 | §4.1 构造函数清单之后新增"跨类型构造函数 T2 有效性范围"段落：说明 T2 在签名层面无约束的 D5 理由，补充指向 §9.4 类型转换边界表的交叉引用，要求编码阶段实现跨类型构造函数时同步查阅 §9.4 确认各 T2-T 组合的预期行为 |
| **P5（一般）** — `GLM_CONFIG_CLIP_CONTROL` 默认值与 roadmap 存在差异（文档值为 0x0A 已验证正确，roadmap 值为 0x02 有误），未标注此差异说明 | §7 D6 `GLM_CONFIG_CLIP_CONTROL` 配置行末尾新增"与 roadmap 差异说明"子句：标注 roadmap 值 `0x02` 有误，文档值 `0x0A` 已验证正确（与 GLM 1.0.3 参考实现一致），编码阶段以本设计文档为准 |
| **P6（一般）** — D30 回退方案的工作量评估（"新增 20 个具名函数"）与文档已有设计不一致——§4.3 已将 add/sub/mul/div/mod 的 vec-op-scalar 方向定义为首轮范围，D30 回退实际仅需补充标注和修改委托目标 | 共修正 5 处：① §4.6 验证要求段落：更新描述为"在已有 20 个函数上补充标注"，标注无需新增函数；② §7 D30 决策描述：同前；③ §7 D30 备选方案描述：明确函数已存在，只需补充标注；④ §7 D30 交互分析：复杂度成本从"新增 20 个函数"修正为"20 处补充标注 + 5 处委托修改"；⑤ §11.6 成本评估表：全表重写，变更项从"新增 20 个具名函数"改为"为已有 20 个函数补充标注"，工作量从 1-2 人天降至约 1 人天 |

---

## 修订说明（v10 — 审查迭代修订版）

| 审查意见 | 修改措施 |
|---------|---------|
| **P1（严重）** — `lib.cj` 的 `public import` 路径错误：`public import glm.detail.scalar_vec_ops.{...}` 应为 `public import glm.detail.{...}`，因为 `scalar_vec_ops.cj` 声明为 `package glm.detail`，Cangjie 中包路径跟随 `package` 声明而非文件名 | §2 `lib.cj` 代码块中修正 `public import` 路径：从 `glm.detail.scalar_vec_ops.{...}` 改为 `glm.detail.{...}`；同步修正 §2 公共 API 面设计说明和 §4.3 命名空间污染风险评估中的注释性引用 |
| **P2（严重）** — §7 D6 的 `GLM_CONFIG_CLIP_CONTROL` 配置行声称"经与 GLM 1.0.3 参考实现 `setup.hpp` 中 `#define GLM_CONFIG_CLIP_CONTROL GLM_CLIP_CONTROL_DISABLE` 的定义链验证"，但 `references/glm-1.0.3/glm/glm/detail/setup.hpp` 中不存在 `GLM_CLIP_CONTROL_DISABLE`。默认值实际由两个条件编译层决定，在无额外定义时等效于 RH_NO = 0x0A | §7 D6 重写默认值来源说明：删除错误的 `GLM_CLIP_CONTROL_DISABLE` 定义链声明，改为描述两个条件编译层（`GLM_FORCE_DEPTH_ZERO_TO_ONE` 和 `GLM_FORCE_LEFT_HANDED`）的决策逻辑，确认无额外定义时最终值等效于 `RH_NO = 0x0A` |
| **P3（中等）** — `equalExact` 在使用 `Inf == Inf` 时存在隐式比较路径依赖，但回退方案未定义可验证的测试标准。§9.3 建议使用 `equalExact()` 替代，但验证计划（§12.1）中缺少 NaN 返回 `false`、整数/Bool Vec 等价性、回退路径等价性等关键场景的测试覆盖 | §9.3 Infinity 补救措施段落后新增"`equalExact` 与 `==` 行为差异汇总"子节，列举容差路径下 3 类场景的差异（有限值微差比较、Inf 精确相等、NaN 比较）。§12.1 层次三 `equalExact` 验证项扩展：补充有限值微差的 `equalExact` vs `==` 行为差异测试和回退路径等价性测试 |
| **P4（中等）** — 测试组织中的包可见性假设未被验证。§12.3 声称测试文件通过声明 `package glm.detail` 可访问 `internal` 类型，但此假设依赖编译器包解析策略，未经验证 | §12.3 `internal` 类型访问策略段重写：明确标注"此假设未经验证"，补充编码阶段原型验证步骤（在 `tests/glm.detail/` 下创建测试文件验证 `internal` 类型可访问性），定义验证失败时的回退方案（提升可见性为 `public`/`protected` 并更新导出列表） |
| **P5（一般）** — 文档树形图存在结构不可能性（前轮已报，第 9 轮仍未修复）。§2 初始目录树形图仍显示两个同级的 `src/glm/` 条目 | §2 初始目录树形图修正：将 `src/├── glm/` 和 `src/└── glm/` 两个同级条目合并为单一的 `src/└── glm/`，`detail/` 作为 `glm/` 的子目录，反映真实的文件系统结构 |
| **P6（一般）** — `countof` 被标记为首轮偏离但未说明替代 API 的可用性。§8.2 S3 行将 `countof` 标注为偏离，但理由"VArray 的 `$N` 必须为固定数值字面量"与 `countof` 的实际功能（计算 C 数组长度）无关。偏离理由需修正 | §8.2 S3 行偏离理由重写：将理由从 `VArray` 字面量约束改为正确说明 `countof` 的实际功能（`sizeof(array)/sizeof(array[0])`）和仓颉中无等价 C 数组语义的实际情况；替代方案不变（`VArray.size` 属性/`LengthT`） |

---

## 修订说明（v11 — 审查迭代修订版）

| 审查意见 | 修改措施 |
|---------|---------|
| **P1（中等）** — `const if` 为文档简写而非语法关键字：全文在 `ComputeEqual.callConst`（§3.5）、`isIec559Of<T>()`（§3.6）、`mod` 双路径（§4.3）、`const if` 抑制验证（§10）等关键位置将 `const if` 当作已知的仓颉关键字使用。经查阅仓颉 const 特性文档，`const if` 并非独立关键字，而是对"`const` 函数中的 `if` 表达式"的简写 | ① 全文使用 `replaceAll` 将 `const if (...)` 统一改写为 `if (...)`，消除对不存在关键字的误导（§3.5/§3.6/§4.3/§10）；② §7 新增 D34 设计决策，记录此简写约定的理由及验证状态说明 |
| **P2（中等）** — `public import glm.detail.{ add, sub, mul, div, mod }` 存在潜在的命名冲突：`glm.detail` 包由 12+ 个文件组成，若未来其他文件也在同一包中定义了同名函数，`public import` 将因重名导致导入歧义 | ① §2 公共 API 面设计补充"命名空间占用声明"：约定 `glm.detail` 包中仅 `scalar_vec_ops.cj` 定义 `add`/`sub`/`mul`/`div`/`mod` 包级函数；② §7 新增 D35 设计决策，正式记录此独占权约定 |
| **P3（中等）** — §11 迁移成本评估缺少 `equalExact` 迁移模式的系统性覆盖：C++ GLM 中没有 `equalExact`——用户直接使用 `==` 进行 IEEE 754 精确比较。迁移到仓颉后，如果 `==` 默认使用容差比较，原 C++ 代码中依赖精确 `==` 语义的场景需要被识别并替换为 `equalExact()` | ① §11 新增子节"§11.9 `equalExact` 迁移模式"，覆盖行为差异对照、需要替换的场景清单、搜索替换规则、迁移工作量评估；② §10 新增"`equalExact` 设计阶段验证"子节，覆盖组件级 `==` 可用性、容差/精确路径差异可观测性、Inf/NaN 边界行为、回退路径等价性等 5 项依赖验证 |
| **P4（一般）** — 对 `references/glm-1.0.3/` 的引用基于假设其存在，但未验证关键路径的实现准确性。§7 D6 对 `GLM_CONFIG_CLIP_CONTROL` 默认值的修正依赖于对参考实现 `setup.hpp` 的解读，整个文档对参考实现的使用策略（§8.4）依赖于"参考实现存在且结构正确"的假设 | ① §8.4 参考实现使用策略新增"前置验证"步骤（策略 0），要求在编码启动前确认参考实现中条件编译逻辑与 §7 D6 描述的决策分支一致，并补充 3 项具体验证项；② §8.4 策略 4（配置宏确认）补充兜底条款：若条件分支逻辑与当前描述不符，以参考实现为准并更新 D6 |

---

## 修订说明（v12 — 审查迭代修订版）

| 审查意见 | 修改措施 |
|---------|---------|
| **P1（中等）** — §4.3 残留导入路径错误：`scalar-op-vec` 方向函数的导入方式仍表述为"通过 `import glm.detail.scalar_vec_ops.*`" | 将 §4.3 中 `import glm.detail.scalar_vec_ops.*` 改为 `import glm.detail.{ add, sub, mul, div, mod }`；全文 grep 确认无其他残余的 `glm.detail.scalar_vec_ops` 路径引用（修订说明中历史记录引用保留不变） |
| **P2（中等）** — 测试目录结构与仓颉包路径解析规则不匹配：`tests/glm.detail/` 应以路径分隔符组织子目录（`tests/glm/detail/`），且目录树缺少 `tests/glm/` | ① §2 初始目录树形图将 `tests/glm.detail/` 改为 `tests/glm/detail/`，同时补充 `tests/glm/` 目录条目（`test_lib.cj`/`test_fwd.cj`）；② §12.3 将 `tests/glm.detail/` 改为 `tests/glm/detail/` |
| **P3（一般）** — §1 出现重复的 `### 设计目标` 标题 | 将第一个 `### 设计目标` 改为 `### 范围可追溯性承诺`，与第二个设计目标标题区分 |
| **P4（一般）** — §3.4/§3.6 残留 `const if` 术语未按 D34 修正 | §3.4 `使用 const if 在编译期分支` 改为 `使用编译期 if 分支`；§3.6 `函数体内使用 const if 配合 is 运算符检测类型` 改为 `函数体内使用编译期 if 配合 is 运算符检测类型` |
| **P5（一般）** — §2 模块间依赖表 scalar_vec_ops 的依赖描述不完整：函数签名引用 Vec 类型但依赖表仅列 qualifier | 将依赖表 scalar_vec_ops 行从 `qualifier（无包内其他依赖）` 改为 `qualifier（函数签名引用 Vec 类型，同包内由 Cangjie 包级编译模型自动包含，不构成独立编译依赖）` |

---

## 修订说明（v13）

| 审查意见 | 修改措施 |
|---------|---------|
| **P1（一般）** — §10 多处残留"const if"独立术语，与 D34 约定不一致 | 对 §10 全文逐处替换：标题、首段、依赖点清单表、统一验证方法、mod 验证子节中所有 `const if` 短语改为"编译期 `if`"或"`if`"表述 |
| **P2（一般）** — §12.3 第 1718 行测试目录路径存在残余不一致 | 将 `` `tests/glm.detail/` `` 改为 `` `tests/glm/detail/` `` 目录路径 |
| **P3（中等）** — 编码前验证任务分散在多个章节，缺少集中清单 | 在 §2 末尾新增 "§2.1 编码前验证检查清单"，以表格形式集中列出 7 项验证任务及对应回退方案 |
| **P4（一般）** — §10 Float16 T(0) const 构造验证超出首轮范围 | 从验证表依赖①的验证类型列表中移除 `Float16`，保留 `isIec559Of` 取值对照表中对 Float16 的注释行 |
| **P5（一般）** — §4.3 mod 浮点实现将精度假设陈述为确定性断言 | 将"此精度提升无损取模语义的正确性"改为"预期精度提升无损取模语义的正确性（需验证，详见 §10）" |
| **P6（严重）** — `const init` 构造函数缺少显式 `public` 可见性声明，Vec1 可能无法从外部构造 | ① §4.1 所有 Vec 类型的 `const init` 签名前补充 `public` 修饰符，并在 Vec1 构造函数块首行添加注释声明"所有 `const init` 构造函数均显式声明为 `public`"；② §7 D11 决策声明末尾补充"所有 `const init` 构造函数均显式声明为 `public`"；③ §12.2 验收标准表新增"public const init 外部可构造"验收项 |

---

## 修订说明（v14）

| 审查意见 | 修改措施 |
|---------|---------|
| **发现1（中等）** — 修订历史附录结构混乱，版本追溯困难：附录混用两套版本编号体系（旧审议轮次v15→v8倒序、新审议轮次v6→v2倒序后接v7→v13正序），三段之间无明确分隔标记或说明 | ① 重写附录首段，新增版本体系说明区分两套编号；② 在附录内插入 `---` 分隔线并加注释标题（`--- 新审议轮次（早期，v6~v2 倒序）---`、`--- 旧审议轮次（v15~v7 倒序）---`、`--- 新审议轮次（后续，v7~v13 正序）---`），将三段清晰分割 |
| **发现2（一般）** — §10 `isIec559Of<T>()`取值对照表（第1257行）中 `Float16→false` 的附注暗示 Float16"应该"是 false，但实际上 Float16 是 IEC 60559 标准格式 | 将附注改写为"因 `is` 运算符检测模式仅覆盖 `Float32`/`Float64`，`isIec559Of<Float16>()` 受限于此模式返回 `false`。若后续轮次引入 Float16 支持，应扩展检测条件或改用其他方案以正确返回 `true`" |
| **发现3（一般）** — `componentAt` const 访问函数（§4.2）是 `const` 上下文中唯一的分量访问路径（§7 D28），但 §10 和 §12 的验证计划中未显式覆盖此函数的正确性验证 | 在 §12.1 层次二（构造与访问验证）中新增一项："`componentAt` const 访问：在 `const` 函数体内调用 `componentAt(i)` 验证正确性，与 `operator[]` 取值形式行为一致。" |
| **发现4（提示）** — §12.1 层次三 `equalExact` 验证项的回退路径等价性测试依赖条件编译开关设计，增加了编码前额外的实现决策成本 | 将验证方法改写为"手动修改 `==` 实现为精确比较后，验证 `==` 与 `equalExact` 对所有输入（含 Inf/NaN）下的输出一致"，移除"条件编译开关"的依赖描述 |

---

## 修订说明（v15）

| 审查意见 | 修改措施 |
|---------|---------|
| **发现1（中等）** — §12.1 层次二已新增 `componentAt` const 访问验证项，但 §12.2 验收标准表未同步增加对应的强制验收项。`componentAt` 的正确性验证仅停留在"测试项"层级（层次二），未升格为"验收标准"层级 | 在 §12.2 验收标准表中新增"componentAt const 访问正确性"验收行，标准为"const 函数体内调用 `componentAt(i)` 返回值与相同索引的 `operator[]` 取值形式一致；越界时触发断言"，验证方法为"§12.1 层次二 `componentAt` 验证项通过" |
| **发现2（中等）** — §11 缺少"标量在左运算的具名函数替换"迁移成本评估。§4.3/D10 已有充分分析，但 §11 未设立独立章节评估受影响表达式模式、搜索替换规则和工作量 | 在 §11 末尾新增子节"§11.10 标量在左运算的具名函数替换"，覆盖受影响表达式模式表、与 vec-op-scalar 方向扩展成员函数的关系和选择指南、搜索替换规则、工作量评估（约 1.5-2.5 人天） |
| **发现3（一般，经质询调整焦点）** — `@Derive[Hashable]` 在泛型 struct 上对类型参数 T 的约束传递性未验证。原始诊断中关于"仅 `const init` 无默认构造时编译器能否正确生成 hashCode"的假设经质询确认为无效假设（`@Derive[Hashable]` 不要求默认构造函数存在）。真实风险点是 T 未实现 `Hashable` 时派生行为 | ① §3.2 Hashable 实现策略新增"泛型类型参数 T 的 `Hashable` 约束传递性"独立条目，说明编译器要求所有实例化中 T 实现 `Hashable`，并确认首轮所有目标类型均已满足；② §10 新增"`@Derive[Hashable]` 在泛型 struct 上的约束传递性验证"子节，包含 3 项验证依赖（编译通过性、HashSet 可用性、非 Hashable 类型参数的负向测试）；③ §12.2 验收标准表"哈希集合可用性"行已验证包含 `HashSet<Vec2<Float32, PackedHighp>>`，无需额外修改 |
| **发现4（一般）** — §2 模块间依赖表 `scalar_vec_ops` 行仅列出 `qualifier` 依赖，未标注对 `std.math.trunc` 的标准库依赖。`mod` 浮点路径依赖 `std.math.trunc`（Float64 版本），Float32 路径涉及 Float64 提升后调用 `trunc` | ① §2 依赖拓扑澄清末尾新增"标准库依赖声明"段落，说明 `scalar_vec_ops.cj` 浮点 `mod` 路径依赖 `std.math.trunc`，编码阶段需在文件头部添加 `import std.math.{ trunc }`；② §8.1 文件清单 `scalar_vec_ops` 行的"依赖"列补充 `std.math`，"说明"列补充注脚 |
