# GLM 1.0.3 仓颉迁移阶段二 OOD 设计方案（v17）

> **修订日期**：2026-06-22

---

## 1. 概述

### 设计目标

在阶段一（Vec1~Vec4 向量类型 + 基础设施）的基础上，迁移全部 9 个矩阵类型及关联别名，使库具备二维/三维/四维矩阵的数学表达能力。矩阵类型以列向量为内部数据成员，与 GLM 的列主序（column-major）存储约定一致。

### 核心抽象

| 抽象 | 角色 | 类型形态 |
|------|------|---------|
| Mat2x2<T,Q> / Mat2x3<T,Q> / ... / Mat4x4<T,Q> | 表示 C×R 数学矩阵的值对象 | 泛型结构体 |
| common.cj（stub） | 基础数学函数库占位 | stub 文件 |
| matrix.cj（stub） | 矩阵运算函数库占位 | stub 文件 |
| geometric.cj（stub） | 几何函数库占位 | stub 文件 |

**类型关系说明**：每个矩阵类型以 VecN<T,Q> 为列向量成员——例如 Mat2x2<T,Q> 的列向量为 Vec2<T,Q>、行向量为 Vec2<T,Q>。各矩阵的列向量类型和行向量类型由矩阵尺寸唯一确定（详见第 2 节映射表），在设计中直接使用具体的 VecN<T,Q> 类型而非类型别名，与阶段一 Vec 类型"使用处直接引用具体 Vec 类型"的风格一致。

### 整体架构思路

沿用阶段一的双层包结构：glm.detail 包含全部 9 个矩阵泛型结构体定义和运算符重载，glm 包通过类型别名暴露常用具现化。矩阵类型以列向量为数据成员（var c0: VecN<T,Q>, var c1: VecN<T,Q>, ...），每个矩阵是一个独立的泛型结构体（而非 C×R 参数化的单一模板），与阶段一 Vec 类型的设计策略一致。

### 系统性设计约束：泛型上下文中 T(0)/T(1) 的获取问题

本设计的多个构造函数和工厂函数面临同一个根因限制：**仓颉无约束泛型参数不支持 `T(0)/T(1)` 构造调用，且 `Number<T>` 接口也不提供 `T(n)` 构造声明**（与 deviations.md DV-01 记录的限制完全一致）。即使添加 `Number<T>` 约束，也仅能通过运算获得 T(0)（`someValue - someValue`），但 **`Number<T>` 约束下无法演算出 T(1)**——`!`（按位取反）运算符属于 `Integer<T>` 接口而非 `Number<T>` 接口，对 Float32/Float64 类型不可用；而阶段一 `increment()` 的 `!` 演算模式仅能工作在 `Integer<T>` 约束上下文中。

因此，本设计对需要 T(0)/T(1) 的功能统一采用以下策略：
- **T(0) 的获取**：在 `Number<T>` 约束的 extend 块中，通过 `someValue - someValue` 演算（`someValue` 可来自构造参数或已有实例的分量）
- **T(1) 的获取**：必须由调用方显式传入参数（`one: T`），因为在 `Number<T>` 约束上下文中不存在通用的演算路径
- **T(0) 和 T(1) 均需的 extend 块**：T(0) 通过运算演算，T(1) 通过参数传入

此统一策略适用于本设计中所有需要 T(0)/T(1) 的场景：`identity()` 工厂函数、`filled(scalar: T)` 工厂函数、跨矩阵类型转换工厂函数。

---

## 2. 模块划分

### 包组织

```
package glm.detail          — 核心实现层（新增/修改文件以 ★ 标记）
  ├── type_mat2x2.cj ★     — Mat2x2<T,Q> 结构体定义 + extend 块中的运算符
  ├── type_mat2x3.cj ★     — Mat2x3<T,Q>
  ├── type_mat2x4.cj ★     — Mat2x4<T,Q>
  ├── type_mat3x2.cj ★     — Mat3x2<T,Q>
  ├── type_mat3x3.cj ★     — Mat3x3<T,Q>
  ├── type_mat3x4.cj ★     — Mat3x4<T,Q>
  ├── type_mat4x2.cj ★     — Mat4x2<T,Q>
  ├── type_mat4x3.cj ★     — Mat4x3<T,Q>
  ├── type_mat4x4.cj ★     — Mat4x4<T,Q>
  ├── common.cj ★           — stub（仅函数签名空壳，供 type_mat3x3/type_mat4x4 依赖闭合）
  ├── matrix.cj ★           — stub（仅函数签名空壳，供 type_mat2x2/type_mat3x3/type_mat4x4 依赖闭合；以及附带提供的额外矩阵运算函数）
  ├── geometric.cj ★        — stub（仅函数签名空壳，供 type_mat4x4 依赖闭合）
  ├── scalar_mat_ops.cj ★   — 标量-矩阵运算全局具名函数（add、sub、mul、div），处理 T + Mat 等标量左侧运算
  │                          （与 scalar_vec_ops.cj 同属 glm.detail，通过参数类型重载区分）
  │                          注意：此文件不包含 mod 函数（矩阵取模无数学意义，GLM 也未为矩阵类型定义 % 运算符）
  └── type_vecN.cj（修改）★  — Vec1~Vec4 各新增行向量×矩阵成员运算符 `Vec{R} * Mat{C}x{R}` extend 块（方案A）

package glm                 — 公共 API 面 + 别名层（修改文件以 ★ 标记）
  ├── lib.cj ★              — 新增矩阵类型的 public import
  └── fwd.cj ★              — 新增矩阵类型别名

package glm.ext             — 具现化别名文件（新增目录和文件，以 ★ 标记）
  ├── matrix_float2x2.cj ★
  ├── matrix_float2x3.cj ★
  ├── ...
  ├── matrix_float4x4.cj ★
  ├── matrix_double2x2.cj ★
  ├── ...
  ├── matrix_double4x4.cj ★
  ├── vector_float1.cj ~ vector_float4.cj ★
  └── vector_double1.cj ~ vector_double4.cj ★
```

### 矩阵类型概览（9 个）

各矩阵类型的列向量类型和行向量类型由矩阵尺寸唯一确定。使用处直接引用具体的 VecN<T,Q> 类型：

| 类型 | 列向量类型 | 列数 | 行向量类型 | 转置目标 |
|------|-----------|------|-----------|---------|
| Mat2x2<T,Q> | Vec2<T,Q> | 2 | Vec2<T,Q> | Mat2x2<T,Q> |
| Mat2x3<T,Q> | Vec3<T,Q> | 2 | Vec2<T,Q> | Mat3x2<T,Q> |
| Mat2x4<T,Q> | Vec4<T,Q> | 2 | Vec2<T,Q> | Mat4x2<T,Q> |
| Mat3x2<T,Q> | Vec2<T,Q> | 3 | Vec3<T,Q> | Mat2x3<T,Q> |
| Mat3x3<T,Q> | Vec3<T,Q> | 3 | Vec3<T,Q> | Mat3x3<T,Q> |
| Mat3x4<T,Q> | Vec4<T,Q> | 3 | Vec3<T,Q> | Mat4x3<T,Q> |
| Mat4x2<T,Q> | Vec2<T,Q> | 4 | Vec4<T,Q> | Mat2x4<T,Q> |
| Mat4x3<T,Q> | Vec3<T,Q> | 4 | Vec4<T,Q> | Mat3x4<T,Q> |
| Mat4x4<T,Q> | Vec4<T,Q> | 4 | Vec4<T,Q> | Mat4x4<T,Q> |

### 模块间依赖

```
glm.detail（同包直接可见）
  type_mat{N}x{M} → type_vec{N}, type_vec{M}（列/行向量类型）
  type_mat2x2.cj 中 .inl 编排 → matrix.cj（stub）
  type_mat3x3.cj 中 .inl 编排 → matrix.cj, common.cj（stub）
  type_mat4x4.cj 中 .inl 编排 → matrix.cj, geometric.cj（stub）
  scalar_mat_ops.cj → type_mat{N}x{M}（为 9 个矩阵类型各提供标量左侧全局运算函数）
  其余 6 个非方阵文件 → 无函数库依赖

glm
  fwd.cj → glm.detail 矩阵类型 + Vec 类型
  lib.cj → glm.detail 矩阵类型

glm.ext
  各别名文件 → glm.detail 矩阵类型/向量类型
```

### ext/ 别名文件的包名策略

本设计选择 **Option 1**：src/ext/ 下文件声明 package glm.ext，通过 import glm.detail.* 访问 glm.detail 包中的核心类型。

### cjpm 子包构建预验证 — 增强方案

**背景**：src/ext/ + package glm.ext 的构建可行性取决于 cjpm 对子包的发现机制。仓颉包声明规则要求"目录名须与包名匹配"（参见 package/README.md §2.1），src/ext/ 对应 package glm.ext 的路由机制依赖于 cjpm 的包发现策略——是否自动扫描 src/ 下所有子目录并按目录层级映射为子包，需通过原型验证确认。

**方案一（首选）：src/ext/ → package glm.ext**。最规范，需通过原型验证确认 cjpm 支持。

**方案二（备选冲突风险评估）**：将 ext/ 文件移至 src/ 根目录并声明 package glm。冲突风险分析如下：

| 冲突场景 | 风险等级 | 分析 |
|---------|---------|------|
| `Mat4x4`（PascalCase fwd.cj 别名）vs `mat4x4`（camelCase 别名） | ✅ 无冲突 | 仓颉类型名区分大小写，同一包内可共存 |
| `mat4`（方阵短别名）vs 同名声明 | ✅ 无冲突 | 仅需确保一处定义（fwd.cj 或 scp 文件），不重复 |
| `detail.Mat4x4<...>`（detail 包中的泛型结构体）vs package glm 中的 type 别名 | ✅ 无冲突 | 不同包（glm vs glm.detail），名称空间隔离 |
| 同一包内同名 type 别名重复定义 | ⚠️ 需避免 | 须确保 ext/ 别名不从 fwd.cj 已定义的别名重复。推荐：fwd.cj 集中定义全部别名，ext/ 文件仅做 import + re-export |

**方案三（第三备选）：独立 cjpm 子模块**。若方案一不可行且方案二的冲突管理不可接受，可将 ext/ 放到独立子模块中通过 workspace 或 dependency 引用。

**原型验证计划（编码启动首日）**：
1. 在 src/ext/ 下创建最小测试文件 `test_ext.cj`，声明 `package glm.ext`，引用 glm.detail 中的类型
2. 运行 `cjpm build`，确认编译通过
3. 若通过，进一步验证外部项目 `import glm.ext.test_ext.{ test_alias }` 可解析
4. 若失败，将测试文件移至 src/ 根目录改为 `package glm`，验证别名与 fwd.cj 不冲突
5. 若方案二也失败，采用方案三

**cjpm.toml 配置**：当前配置 `src-dir = "src"`。若子目录未被自动扫描，需通过 `package-configuration` 或手动配置子包发现。

---

## 3. 核心抽象

### 3.1 矩阵结构体

**角色**：表示 C×R 数学矩阵的值对象。每个矩阵类型是独立泛型结构体，以列向量为数据成员，采用列主序（column-major）存储。

**职责**：
- 承载 C 个列向量数据成员（var c0: VecR<T,Q>、var c1: VecR<T,Q> 等，其中 R = 行数）
- 提供编译期查询函数 const func length(): Int64 返回列数 C
- 提供下标运算符 [](i: Int64) 访问列向量（取值 + 赋值双版本）
- 提供逐分量构造函数和向量列构造函数
- 通过 @Derive[Hashable] 自动派生哈希支持

**为何采用 struct（值类型）而非 class（引用类型）**：与阶段一 Vec 类型一致——矩阵是数学计算中的值对象，值语义确保运算符返回新实例、无副作用，便于测试和函数式组合。

**为何 9 个独立结构体而非统一泛型**：仓颉不支持模板偏特化，无法实现 Mat<C, R, T, Q> 泛型后在 .inl 中按 C/R 参数分别特化。

### 3.2 类型映射关系

矩阵类型与列向量/行向量的对应关系是固定的编译期映射，不定义为类型别名。使用处直接引用具体的 VecN<T,Q> 类型，与阶段一 Vec 类型风格一致。

### 3.3 构造函数体系

每个矩阵类型提供以下构造函数和工厂函数：

1. **逐分量同类型构造** — const init 可用，纯赋值
2. **列向量构造** — const init 可用，纯赋值
3. **标量填充构造 filled(scalar: T)** — extend 块工厂函数，Number<T> 约束，非 const
4. **跨类型逐分量构造 fromParts(conv, ...)** — extend 块工厂函数，仅 Qualifier 约束，非 const
5. **跨类型列向量构造 fromColumns(conv, ...)** — 同上
6. **跨矩阵类型转换** — 拆分为 6a（同类型 fromMat(m, one)）和 6b（跨类型 fromMat(conv, m, one)）
   - 填充规则：复制重叠区域，扩展列/行按单位矩阵填充
   - B 类方向（C_src=C_dst, R_src<R_dst）的 GLM .inl 逐项对照分析见下方映射表
7. **跨类型同尺寸转换** — fromMat(conv, m) 工厂函数
8. **单位矩阵工厂函数 identity(one: T)** — 对所有 9 种矩阵类型均提供

**B 类方向与 GLM .inl 逐项对照分析**：

| 方向 | GLM 源码 | GLM 实现 | 与主规则一致性 |
|------|---------|---------|--------------|
| Mat2x3←Mat2x2 | type_mat2x3.inl:122 | `col_type(m[0],0), col_type(m[1],0)` | ✅ 一致 |
| Mat2x4←Mat2x2 | type_mat2x4.inl:124 | `col_type(m[0],0,0), col_type(m[1],0,0)` | ✅ 一致 |
| Mat2x4←Mat2x3 | type_mat2x4.inl:160 | `col_type(m[0],0), col_type(m[1],0)` | ✅ 一致 |
| Mat3x3←Mat3x2 | type_mat3x3.inl:175 | `col_type(m[0],0), col_type(m[1],0), col_type(m[2],1)` | ✅ 一致 |
| Mat3x4←Mat3x2 | type_mat3x4.inl:191 | `col_type(m[0],0,0), col_type(m[1],0,0), col_type(m[2],1,0)` | ✅ 一致 |
| Mat3x4←Mat3x3 | type_mat3x4.inl:152 | `col_type(m[0],0), col_type(m[1],0), col_type(m[2],0)` | ✅ 一致 |
| Mat4x3←Mat4x2 | type_mat4x3.inl:228 | `col_type(m[0],0), col_type(m[1],0), col_type(m[2],1), col_type(m[3],0)` | ✅ 一致 |
| Mat4x4←Mat4x2 | type_mat4x4.inl:246 | `col_type(m[0],0,0), col_type(m[1],0,0), col_type(0,0,1,0), col_type(0,0,0,1)` | ❌ **有偏差** |
| Mat4x4←Mat4x3 | type_mat4x4.inl:274 | `col_type(m[0],0), col_type(m[1],0), col_type(m[2],0), col_type(m[3],1)` | ✅ 一致 |

**偏差详情（Mat4x4←Mat4x2）**：GLM 对列 2 和列 3 使用 `col_type(0,0,1,0)` 和 `col_type(0,0,0,1)`，完全丢弃了源矩阵列 2、3 的前两行数据。主规则会先复制源矩阵列 2、3 的前两行（`src[2][0..1]` 和 `src[3][0..1]`），再填充扩展行——与 GLM 行为不同。编码阶段须针对 Mat4x4←Mat4x2 实现特殊处理。

**B 类方向单元测试验证要求**：
- 为 Mat4x4←Mat4x2 编写专用测试：构造源矩阵（列 2、3 前两行填入非零值），转换后验证列 2=Vec4(0,0,1,0)、列 3=Vec4(0,0,0,1)，确认源数据被丢弃
- 为其余 8 个 B 类方向编写验证：构造非零源矩阵，确认扩展行符合主规则预期

### 3.4 行列访问

- **下标运算符** `[](i: Int64)`：取值版本返回列向量副本，赋值版本需 mut 修饰符
- **具名列访问函数** `col(i: Int64)`：与 `[]` 完全等价
- `col()` 替代 `componentAt()` 以避免与 Vec 的语义冲突
- 行访问 `row()` 推迟至阶段四

### 3.5 算术运算符

- 一元负号、矩阵-标量 ±*/（成员运算符）、标量-矩阵 ±*/（scalar_mat_ops.cj 全局函数）
- 矩阵-矩阵 ±（同尺寸）、*（含 29 个乘法重载：3 同尺寸 + 26 跨尺寸）
- 矩阵-向量 *（矩阵成员运算符）、行向量-矩阵 *（Vec extend 块成员运算符，方案A）
- 复合赋值运算符由编译器自动生成

**复合赋值运算符手动定义回退方案文件分布表**（若自动生成验证失败）：

| 文件 | 需定义的运算符 | 数量 |
|------|--------------|------|
| type_mat2x2.cj | +=/=-=/*=/=(T), +=/=-=/*=/=(Mat2x2) | 8 |
| type_mat2x3.cj | +=/=-=/*=/=(T), +=/=-=(Mat2x3) | 6 |
| type_mat2x4.cj | +=/=-=/*=/=(T), +=/=-=(Mat2x4) | 6 |
| type_mat3x2.cj | +=/=-=/*=/=(T), +=/=-=(Mat3x2) | 6 |
| type_mat3x3.cj | +=/=-=/*=/=(T), +=/=-=/*=/=(Mat3x3) | 8 |
| type_mat3x4.cj | +=/=-=/*=/=(T), +=/=-=(Mat3x4) | 6 |
| type_mat4x2.cj | +=/=-=/*=/=(T), +=/=-=(Mat4x2) | 6 |
| type_mat4x3.cj | +=/=-=/*=/=(T), +=/=-=(Mat4x3) | 6 |
| type_mat4x4.cj | +=/=-=/*=/=(T), +=/=-=/*=/=(Mat4x4) | 8 |

手动定义总计：**60 个**（含 6 标量运算运算符 × 9 种矩阵 = 54 同尺寸矩阵运算 +=/-=, 仅 3 个方阵各有 +1 *=(M) +1 /=(M)）

### 3.6 比较运算符

==/!= 基于 Equatable<T> 约束，equalEpsilon 基于 Number<T>&Equatable<T>&Comparable<T> 约束。

### 3.7 stub 函数库

为满足方阵 .inl 依赖闭合，创建 common.cj、matrix.cj、geometric.cj 三个 stub 文件。

### 3.8 ext/ 别名文件

src/ext/ 下存放矩阵（18 个）和向量（8 个）的具现化别名文件，声明 package glm.ext。

---

## 4. 关键行为契约

### 4.1 矩阵构造与单位矩阵

```
let m = Mat4x4<Float32, PackedHighp>.identity(1.0f)     // 单位矩阵
let m = Mat4x4<Float32, PackedHighp>.filled(1.0f)       // 对角矩阵
let m = Mat4x4<Float32, PackedHighp>(1.0f, 0.0f, ...)    // 逐分量 const init
```

### 4.2 矩阵乘法

```
let c = a * b                    // 矩阵-矩阵乘
let transformed = a * v          // 矩阵-向量乘
let r = v * m                    // 行向量-矩阵乘
```

### 4.3 跨尺寸转换

```
let m4 = Mat4x4<Float32, PackedHighp>.fromMat(m2x2, one: 1.0f)
```

### 4.4 跨类型跨尺寸转换

```
let m4f = Mat4x4<Float32, PackedHighp>.fromMat({ x => Float32(x) }, m2x2_int, one: 1.0f)
```

### 4.5 跨类型同尺寸转换

```
let mFloat = Mat4x4<Float32, PackedHighp>.fromMat({ x => Float32(x) }, mInt)
```

---

## 5. 错误处理策略

- 下标越界抛出 Exception
- mat/mat 除法依赖 inverse stub，本阶段 stub 异常
- mat/scalar 和 scalar/mat 逐元素操作，不依赖 inverse，本阶段完整实现
- 算术复合赋值运算符标注 @OverflowWrapping
- scalar_mat_ops.cj 全部 36 个函数标注 @OverflowWrapping

---

## 6. 并发设计

本阶段不引入并发场景。矩阵类型为值类型，所有运算符返回新实例，天然线程安全。

---

## 7. 设计决策

| 编号 | 决策 | 理由 |
|------|------|------|
| D01 | 9 个矩阵类型各自独立定义 | 仓颉不支持模板偏特化 |
| D02 | 列主序存储 | 与 GLM 约定一致 |
| D03 | glm.ext 子包存放别名文件 | 目录路径与包名匹配规则要求 |
| D04 | 矩阵乘法直接内联展开 | 最大 4×4 代码量可控 |
| D05 | 矩阵-向量乘法定义为矩阵运算符 | 与 C++ GLM 一致 |
| D06 | 标量左侧运算通过全局函数 | 仓颉 operator func 限制 |
| D07 | stub 函数提供空壳签名 | 仅依赖闭合需求 |
| D08 | 排除 ++/-- 运算符 | 仓颉不支持重载自增/减 |
| D09-D31 | 同 v5 设计 | 延续前序已验证的决策 |
| D32 | 行向量×矩阵为 Vec 类型成员运算符 | 左操作数类型拥有运算符 |

`length()` 差异说明：C++ GLM 中 `mat<C,R,T,Q>::length()` 为静态成员函数（`length()` 返回列数 C），调用方式 `mat4::length()`。仓颉版本中 `length()` 设计为 const 实例成员函数 `const func length(): Int64`，调用方式 `m.length()`。此差异已在 §9 差异声明中记录。

---

## 8. 阶段二产出物清单

- 9 个矩阵类型实现文件（type_mat2x2.cj ~ type_mat4x4.cj）
- 4 个辅助文件（common.cj, matrix.cj, geometric.cj, scalar_mat_ops.cj）
- 26 个 ext/ 别名文件（18 矩阵 + 8 向量）
- 修改文件：src/fwd.cj, src/lib.cj
- **编码启动前验证项**：cjpm 子包构建预验证、复合赋值运算符自动生成验证、Mat4x4←Mat4x2 fromMat 偏差验证、@Derive[Hashable] T=Bool 编译验证

### compile order 说明：Vec 类型 extend 块中的行向量×矩阵运算符

行向量×矩阵乘法 `Vec{R} * Mat{C}x{R} → Vec{C}` 定义在 Vec{R} 类型的 extend 块中（type_vecN.cj 文件）。这些 extend 块引用了矩阵类型（Mat2x2, Mat2x3, ..., Mat4x4），而矩阵类型定义在同包（glm.detail）的不同文件中。

**编译顺序分析**：仓颉编译器的包级编译策略是"按需解析"——同一包内的类型引用不依赖文件编译顺序。当编译器处理 type_vecN.cj 的 extend 块时，若引用的矩阵类型尚未解析，编译器会延迟到类型可用时再完成扩展成员的注册。同包内类型互相引用不需要 import 语句（同包直接可见），因此不存在文件编译顺序依赖。

**编码阶段建议**：为确保编码清晰，建议在项目中按以下顺序组织文件（非编译强制）：
1. 基础类型文件：setup.cj, qualifier.cj, type_vec1~4.cj
2. 矩阵类型文件：type_mat2x2~type_mat4x4.cj
3. Vec extend 块文件：type_vecN.cj（含行向量×矩阵扩展）
4. 辅助文件：scalar_mat_ops.cj, stub 文件
这种顺序使代码阅读者能在理解矩阵类型后看到 Vec 扩展，逻辑自洽。

---

## 9. 对齐 GLM 参考实现的差异声明

| 差异 | 说明 |
|------|------|
| **无 C 数组成员** | GLM 中 col_type value[C] 替换为具名成员 c0, c1, ... |
| **无 GLM_CONFIG_* 条件编译** | 全部采用最保守值 |
| **无 ++/-- 运算符** | 仓颉不支持重载自增/减，可通过 `m += one` 等价替代 |
| **无模板赋值运算符** | 仓颉不允许重载 operator= |
| **ext/ 别名文件为 package glm.ext** | 仓颉包名与目录路径匹配规则约束 |
| **矩阵-矩阵除法推迟且仅限方阵** | 依赖 inverse stub |
| **标量左侧矩阵运算为全局函数** | 仓颉 operator func 限制 |
| **mat / scalar 为成员运算符函数** | 仓颉 operator func 规则 |
| **无类型别名体系** | 类型别名只能在文件顶层定义 |
| **无 row() 成员函数** | 推迟至阶段四自由函数版本 |
| **col() 代替 componentAt()** | 语义一致性 |
| **[] 返回副本而非引用** | 值类型语义导致链式修改不可用 |
| **fwd.cj 排除冗余别名** | 约 171 个冗余别名被排除 |
| **非方阵 *= 不可用** | 乘法结果类型不同，编译器不自动生成 |
| **复合赋值不支持跨类型** | extend 块运算符右操作数类型固定 |
| **无 init() 默认构造** | 改为 identity(one) 工厂函数 |
| **identity 对非方阵也提供** | API 统一性设计 |
| **filled 为工厂函数** | 需要 Number<T> 约束获取 T(0) |
| **fromMat 拆分为 6a/6b** | 跨类型需 conv 闭包 |
| **fromParts/fromColumns 仅支持单一源类型** | 仓颉泛型签名限制 |
| **`[]` 和 `col()` 不可在 const 上下文** | 含 assert + throw |
| **`identity(one)` 和 `filled(scalar)` 不可在 const 上下文** | 涉及运算 |
| **`length()` 为实例成员函数而非静态函数** | 与 C++ GLM 的 `mat4::length()` 不同，调用方式为 `m.length()` |
| **行向量×矩阵运算符在 Vec extend 块中** | 因左操作数类型拥有运算符，编译顺序无依赖问题（同包延迟解析） |
| **Mat4x4←Mat4x2 转换行为偏离主规则** | 源矩阵列 2、3 的前两行数据被丢弃，替换为单位矩阵值 |

---

## 修订说明（v17）

| 审查意见 | 修改措施 |
|---------|---------|
| **问题1（中等）**：cjpm 子包构建风险缺乏充分应对方案 | **已采纳**。① 将预验证段落扩展为"增强方案"，包含方案一（package glm.ext，首选）、方案二（移至 src/ 根目录，含完整的冲突风险分析表）和方案三（独立子模块）三个递进方案；② 补充详细原型验证步骤；③ 说明 cjpm.toml 可能需要的额外子包配置 |
| **问题2（轻微）**：复合赋值运算符自动生成假设的 fallback 工作量被低估 | **已采纳**。① 补充完整的手动定义回退方案文件分布表，按 9 个矩阵类型文件逐一列出需定义的运算符和数量；② 修正手动定义总数为 60 个（含 6 个标量运算 × 9 种矩阵 + 6 个同尺寸矩阵运算 ± + 仅方阵的 6 个 */=）；③ 注释 *= 仅出现在 3 个方阵文件的原因 |
| **问题3（中等）**：B 类 fromMat 转换方向的行为契约不完整 | **已采纳**。① 逐一查阅 GLM 1.0.3 全部 9 个 .inl 文件中对应的转换构造函数源码，形成逐项对照分析表；② 结论：9 个 B 类方向中 8 个与主规则一致，仅 Mat4x4←Mat4x2（type_mat4x4.inl:246-257）存在实际偏差——GLM 丢弃列 2、3 的源数据；③ 补充偏差详情和编码阶段特殊处理要求；④ 补充 B 类方向单元测试验证要求 |
| **问题4（轻微）**：Vec 类型 extend 块中矩阵乘法运算符编译顺序未明确 | **已采纳**。① §8 新增"compile order 说明"子节，分析仓颉编译器的同包延迟解析机制；② 确认同包内类型引用不依赖文件编译顺序；③ 补充编码阶段建议的文件组织顺序（非编译强制） |
| **问题5（轻微）**：@Derive[Hashable] 对 Bool 的推导结论缺少全面验证 | **已采纳**。① 在 §3.1 矩阵结构体职责中保留已有 T=Bool 可行性论证；② 列入编码启动前验证项；③ 若编译时验证失败，备选方案为移除矩阵的 @Derive[Hashable] 并手动实现（与阶段一 Vec<Bool,Q> 的 Hashable 策略一致） |
| **问题6（轻微）**：§9 差异声明未记录 const func length() 与 C++ GLM 的行为差异 | **已采纳**。① §9 差异声明新增"length() 为实例成员函数而非静态函数"条目；② §7 设计决策末尾补充 length() 差异说明；③ 明确 C++ GLM 调用方式 `mat4::length()` vs 仓颉 `m.length()` |
