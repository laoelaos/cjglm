# R2a: Vec1 和 Vec2 类型实现与 OOD 设计一致性审查

审查时间：2026-06-20

### 审查范围

- `cjglm/src/detail/type_vec1.cj` — Vec1<T,Q> 结构体
- `cjglm/src/detail/type_vec1_test.cj` — Vec1 测试
- `cjglm/src/detail/type_vec2.cj` — Vec2<T,Q> 结构体
- `cjglm/src/detail/type_vec2_test.cj` — Vec2 测试

参考依据：`docs/02_ood_phase0.md` — GLM 1.0.3 仓颉迁移首轮 OOD 设计方案

### 发现

#### [一般] Vec1 缺少跨类型转换构造函数

- **位置**：`cjglm/src/detail/type_vec1.cj:7-12`
- **描述**：设计 §4.1 规定的 Vec1 跨类型转换构造函数均未实现。Vec1 应当提供以下四个构造函数：(a) `public init<T2, Q2>(v: Vec1<T2, Q2>) where Q2 <: Qualifier`，(b) `public init<T2, Q2>(v: Vec2<T2, Q2>) where Q2 <: Qualifier`，(c) `public init<T2, Q2>(v: Vec3<T2, Q2>) where Q2 <: Qualifier`，(d) `public init<T2, Q2>(v: Vec4<T2, Q2>) where Q2 <: Qualifier`。当前仅定义了 `const init(x: T)`。
- **建议**：按设计 §4.1 补充四个跨类型转换构造函数。注意跨类型构造函数必须为非 `const` 形式（因函数体含 `T(v.x)` 类型转换表达式）。

#### [一般] Vec2 缺少跨类型转换构造函数

- **位置**：`cjglm/src/detail/type_vec2.cj:7-54`
- **描述**：设计 §4.1 规定的 Vec2 构造函数体系未完整实现。缺少以下构造函数：(a) `public init<T2, Q2>(v: Vec2<T2, Q2>) where Q2 <: Qualifier`，(b) `public init<T2, Q2>(a: Vec1<T2, Q2>, b: T) where Q2 <: Qualifier`，(c) `public init<T2, Q2>(a: T, b: Vec1<T2, Q2>) where Q2 <: Qualifier`，(d) `public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>) where Q2 <: Qualifier`，(e) `public init<T2, Q2>(v: Vec3<T2, Q2>) where Q2 <: Qualifier`（从 Vec3 截断取 x,y），(f) `public init<T2, Q2>(v: Vec4<T2, Q2>) where Q2 <: Qualifier`（从 Vec4 截断取 x,y）。
- **建议**：按设计 §4.1 缺失的 6 个构造函数。特别注意 Vec2 的 fill-from-Vec1 构造函数已实现 `public init(v: Vec1<T, Q>)`（同类型），跨类型 fill-from-Vec1 按设计 §7 D31 约定仅保留同类型版本，不在此列。

#### [一般] 缺少 increment()/decrement() 具名函数

- **位置**：`cjglm/src/detail/type_vec1.cj:95-144`，`cjglm/src/detail/type_vec2.cj:92-123`
- **描述**：设计 §3.2 和 §4.6 要求提供 `increment(): VecN<T,Q>` 和 `decrement(): VecN<T,Q>` 具名函数作为 `++`/`--` 的替代，并标注 `@OverflowWrapping`。两个文件均未实现。设计明确标注这两函数应在 `extend<T, Q> VecN<T, Q> where T <: Integer<T>, Q <: Qualifier` 块中定义（与位运算符和 `%` 同块）。
- **建议**：在已有 `extend<T, Q> where T <: Integer<T>` 块中补充定义：
  ```
  @OverflowWrapping
  public func increment(): Vec1<T, Q> { Vec1(this.x + T(1)) }
  @OverflowWrapping
  public func decrement(): Vec1<T, Q> { Vec1(this.x - T(1)) }
  ```

#### [一般] componentAt 缺少 const 标注

- **位置**：`cjglm/src/detail/type_vec1.cj:32`，`cjglm/src/detail/type_vec2.cj:46`
- **描述**：设计 §4.2 明确规定 `componentAt` 应声明为 `public const func componentAt(i: Int64): T`，以便在 const 实例成员函数体内通过索引访问分量。当前代码中两个 Vec 的 `componentAt` 均无 `const` 修饰符，丧失了在 const 上下文中被调用的能力。
- **建议**：在 `componentAt` 函数签名中补加 `const` 修饰符。

#### [一般] `==` 运算符定义在 extend 块中而非 struct 体内，丢失 const 能力

- **位置**：`cjglm/src/detail/type_vec1.cj:146-148`，`cjglm/src/detail/type_vec2.cj:125-128`
- **描述**：设计 §3.2 和 §4.5 要求 `==` 声明为 `const` 函数（利用 Vec 的 `const init` 支持），定义在 struct 体外或体内均可但必须可 const。当前实现将 `==` 定义在 `extend<T, Q> where T <: Equatable<T>` 块中，而仓颉 extend 块不支持 `const` 修饰符（仓颉扩展 §4.2），导致 `==` 为非 const 函数，无法在 const 表达式中使用。
- **建议**：将 `==` 和 `!=` 运算符从 extend 块移至 struct 体内部定义，并声明为 `const`。注意：移入 struct 体后与 `const init` 配合使用，`==` 函数体内可直接调用分量成员。

#### [轻微] `==` 使用 ComputeEqual.call 而非 ComputeEqual.callConst

- **位置**：`cjglm/src/detail/type_vec1.cj:147`，`cjglm/src/detail/type_vec2.cj:126`
- **描述**：设计 §4.5 规定 `==` 应调用 `ComputeEqual<T>.callConst` 以通过 `isIec559Of<T>()` 编译期分支实现浮点容差比较路径。当前实现调用 `ComputeEqual<T>.call`（非 const 版本，仅执行原生 `a == b` 精确比较）。此偏差导致浮点 Vec 的 `==` 使用精确比较而非设计规定的容差比较。
- **建议**：在 `compute_vector_relational.cj` 中补充 `ComputeEqual<T>.callConst` 的 const 实现（包含 `isIec559Of` 分支逻辑），并将 Vec1/Vec2 的 `==` 实现改为调用 `.callConst`。

#### [轻微] equalEpsilon 实现偏离设计文档

- **位置**：`cjglm/src/detail/type_vec1.cj:153`，`cjglm/src/detail/type_vec2.cj:132`
- **描述**：设计 §4.5 规定的 `equalEpsilon` 实现为内联表达式 `abs(this.x - other.x) <= epsilonOf<T>()`。当前代码委托给 `ComputeEqualNumeric<T>.callConst(this.x, other.x)`，使用了一个设计文档中未定义的 `ComputeEqualNumeric` 结构体。虽然功能上可能等价，但偏离了设计文档的明确签名描述，且引入了一个设计未记录的额外依赖。
- **建议**：按设计文档 §4.5 中的显式模板实现（`abs(...) <= epsilonOf<T>()` 内联表达式），或确认偏离在编码记录中有同步修订注释。

#### [轻微] Vec1 测试缺少下标越界赋值测试

- **位置**：`cjglm/src/detail/type_vec1_test.cj:194-201`
- **描述**：现有 `testVec1IndexOutOfBoundsAccess` 仅测试取值形式（`v[Int64(1)]`）的越界行为，未测试赋值形式（`mut operator func []`）的越界行为。设计 §4.2 规定了两种形式的越界行为一致，但赋值形式的越界未被测试覆盖。
- **建议**：补充 `testVec1IndexOutOfBoundsMutate` 测试，验证越界赋值时抛 `Exception`。

#### [轻微] Vec2 缺少下标越界访问测试

- **位置**：`cjglm/src/detail/type_vec2_test.cj:69-80`
- **描述**：Vec2 的 `testVec2IndexAccess` 和 `testVec2IndexMutate` 仅测试正常边界内的访问/赋值，未覆盖越界场景（索引 < 0 或 >= 2）。相比之下 Vec1 有 `testVec1IndexOutOfBoundsAccess`。
- **建议**：补充 Vec2 的下标越界测试（取值和赋值两种形式）。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 0 |
| 一般 | 6 |
| 轻微 | 4 |

### 总评

Vec1 和 Vec2 的核心结构定义（数据成员、`const init`、`length()`、下标运算符 `[]`、算术运算符、位运算符、`%`/`mod`、`logicalAnd`/`logicalOr`、`==`/`!=`、`bitwiseNot`、`componentAt`、`equalExact`/`equalEpsilon`）在实现层面的功能正确性上总体良好，已实现的部分与设计一致。

主要缺口集中在以下三个方向：
1. **构造函数体系不完整**：Vec1 和 Vec2 均缺少设计规定的跨类型转换构造函数（`init<T2,Q2>`），Vec2 还缺少 Vec1+标量组合构造和截断构造。
2. **缺少 increment()/decrement()**：设计明确要求但两个文件均未实现。
3. **const 正确性不足**：`componentAt` 缺少 `const`、`==` 定义在 extend 块中导致非 const、使用了非 const 版本的 `ComputeEqual.call` 而非设计要求的 `ComputeEqual.callConst`。

这些缺口中有部分可能是阶段性编码进度所致（施工途中），但应在验收前按设计文档补齐。建议在修复后同步更新测试文件覆盖新增功能。
