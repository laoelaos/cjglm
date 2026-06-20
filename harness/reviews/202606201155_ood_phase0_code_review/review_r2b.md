# R2B: Vec3/Vec4 OOD 设计一致性审查

审查时间：2026-06-20

### 审查范围

- `cjglm/src/detail/type_vec3.cj` — Vec3\<T,Q\> 结构体
- `cjglm/src/detail/type_vec3_test.cj` — Vec3 测试
- `cjglm/src/detail/type_vec4.cj` — Vec4\<T,Q\> 结构体
- `cjglm/src/detail/type_vec4_test.cj` — Vec4 测试

参考依据：`docs/02_ood_phase0.md` (OOD 设计方案)

### 发现

#### [一般] Vec3/Vec4 缺失跨类型转换构造函数 `init<T2,Q2>`

- **位置**：`type_vec3.cj:12-28`、`type_vec4.cj:13-32`
- **描述**：OOD §4.1 构造函数清单明确要求 Vec3 和 Vec4 提供 `public init<T2, Q2>(v: Vec3<T2, Q2> / Vec4<T2, Q2>) where Q2 <: Qualifier` 跨类型转换构造函数。当前实现仅包含 `init(scalar: T)`、`const init(x, y, ...)` 和 `init(v: Vec1<T, Q>)`，缺少跨类型版本。Vec3 还缺少 `init<T2, Q2>(v: Vec4<T2, Q2>)` 截断构造。这导致 `Vec3<Float32, Defaultp>(Vec3<Int32, Defaultp>(1,2,3))` 等跨类型转换无法编译。
- **建议**：按 OOD §4.1 清单补充 `public init<T2, Q2>(v: VecN<T2, Q2>) where Q2 <: Qualifier` 构造函数到 Vec3/Vec4 结构体定义中。函数体内通过 `T(v.x)` 逐分量显式转换。

#### [一般] Vec3/Vec4 缺失多元组合构造函数

- **位置**：`type_vec3.cj:12-28`、`type_vec4.cj:13-32`
- **描述**：OOD §4.1 为 Vec3 定义了 12 个多元组合构造函数（Vec2+标量、Vec1x3、Vec2+Vec1 等），为 Vec4 定义了约 30 个多元组合构造函数（Vec3+T、Vec3+Vec1、T+Vec3、Vec1+Vec3、Vec2+Vec2、Vec2+2标量、Vec1x4 等）。当前实现全部缺失。这限制了 GLM 代码迁移中常见的 `glm::vec4(glm::vec3(a,b,c), d)` 等构造模式的使用。
- **建议**：按 OOD §4.1 Vec3/Vec4 构造函数清单逐项补充。编码阶段可借助多光标编辑或脚本生成减少重复劳动。建议先补充最常用的 Vec3+标量/Vec3+Vec1 组合，其他组合按使用频率分批实现。

#### [一般] Vec3/Vec4 缺失 `increment()`/`decrement()` 具名函数

- **位置**：`type_vec3.cj` 和 `type_vec4.cj`（缺失）
- **描述**：OOD §3.2 和 §4.3 明确要求提供 `increment()`/`decrement()` 具名函数（标注 `@OverflowWrapping`）作为 `++`/`--` 运算符的替代。Vec1(`type_vec1.cj:41-93`) 和 Vec2(`type_vec2.cj:56-90`) 也未看到这些函数，但本次审查范围限定 Vec3/Vec4。当前 Vec3/Vec4 未定义这两个函数。
- **建议**：在 Vec3/Vec4 的 `extend<T, Q> VecN<T, Q> where T <: Number<T>, Q <: Qualifier` 块中补充 `increment()` 和 `decrement()`，实现为逐分量加/减 1 并标注 `@OverflowWrapping`。

#### [一般] `componentAt()` 未声明为 `const`

- **位置**：`type_vec3.cj:52`、`type_vec4.cj:58`
- **描述**：OOD §4.2 明确规定 `componentAt` 应声明为 `public const func componentAt(i: Int64): T`，以便在 const 实例成员函数体中通过索引访问分量。当前代码为 `public func componentAt(i: Int64): T`，缺失 `const` 修饰符。
- **建议**：在 `componentAt` 声明中添加 `const` 修饰符：`public const func componentAt(i: Int64): T`。

#### [一般] `==` 运算符使用 `ComputeEqual<T>.call`（精确比较）而非 `callConst`（Epsilon 容差比较）

- **位置**：`type_vec3.cj:133`、`type_vec4.cj:140`、`compute_vector_relational.cj:5-9`
- **描述**：OOD §3.5/§4.5 要求 `==` 逐分量调用 `ComputeEqual<T>.callConst`——对浮点类型使用 Epsilon 容差比较（`abs(a-b) <= epsilonOf<T>()`），对整数/Bool 使用精确 `==`。当前实现调用 `ComputeEqual<T>.call`（仅精确 `a == b`）。此外 `ComputeEqual<T>` 结构体本身也未提供 `callConst` 方法——Epsilon 容差比较被放置在独立结构体 `ComputeEqualNumeric<T>` 中，需 `Number<T> & Equatable<T> & Comparable<T>` 约束。这导致浮点 Vec 的 `==` 使用 IEEE 754 精确相等语义而非设计要求的 Epsilon 容差语义。
- **建议**：评估是否需要在 `==` 中引入浮点容差比较。若需要在 `==` 中使用 Epsilon 比较，需将 `==` 的 `extend` 块约束从 `T <: Equatable<T>` 提升至至少 `T <: Number<T> & Equatable<T> & Comparable<T>`，并将调用切换为 `ComputeEqualNumeric<T>.callConst`。注意此变更扩大 `==` 的约束范围，可能影响 `Bool` 分量 Vec 的 `==` 可用性——需验证兼容性。

#### [一般] Vec3 缺少 Vec4 截断构造函数

- **位置**：`type_vec3.cj:12-28`
- **描述**：OOD §4.1 Vec3 构造函数清单包含 `public init<T2, Q2>(v: Vec4<T2, Q2>) where Q2 <: Qualifier`，截取 Vec4 的 x/y/z 分量构造 Vec3。当前缺失。
- **建议**：补充 `public init<T2, Q2>(v: Vec4<T2, Q2>): Vec3 { this.x = T(v.x); this.y = T(v.y); this.z = T(v.z) }`。

#### [轻微] `testVec3Equal` / `testVec4Equal` 仅测试 Int64 类型的 `==`，未覆盖 Float 类型的 `==`

- **位置**：`type_vec3_test.cj:79-83`、`type_vec4_test.cj:86-90`
- **描述**：`==` 运算符的测试仅使用 `Vec3<Int64, Defaultp>` / `Vec4<Int64, Defaultp>`，未覆盖浮点类型（Float32/Float64）。由于当前 `==` 内部使用精确比较，对浮点类型的行为与整数一致，此缺失不影响发现缺陷，但与 OOD 设计提到的浮点容差路径无测试覆盖关联。
- **建议**：若 `==` 切换至 Epsilon 容差路径（见上一发现），补充 `==` 在 Float32/Float64 类型上的相等/近似相等测试用例。

#### [轻微] 测试未覆盖 `componentAt` 的 `const` 上下文调用

- **位置**：`type_vec3_test.cj:71-76`、`type_vec4_test.cj:77-83`
- **描述**：`componentAt` 的现有测试均在非 const 上下文中调用。若修复 `const` 修饰符缺失问题后，建议补充 const 上下文中的调用测试以验证 const 正确性。
- **建议**：在 const 初始化或 const 函数中调用 `componentAt` 作为回归测试。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 0 |
| 一般 | 6 |
| 轻微 | 2 |

### 总评

Vec3 和 Vec4 的核心结构体定义（数据成员 `x/y/z/w`、`const init` 构造函数、`length()` 静态函数、下标运算符 `[]` 取值/赋值形式、`@OverflowWrapping` 标注的二元算术运算符、`extend` 块中的位运算符、`bitwiseNot()`/`logicalAnd()`/`logicalOr()` 具名函数、`%` 运算符和 `mod` 具名函数）**均已正确实现**，与 OOD 设计一致。测试覆盖了大部分已实现功能的基本路径。

**主要缺口**集中在构造函数体系上：跨类型转换构造函数 `init<T2,Q2>` 和 OOD §4.1 定义的大量多元组合构造函数（Vec3+标量、Vec4 的 Vec3+T/Vec3+Vec1/Vec2+Vec2 等）完全缺失，这限制了 GLM 代码迁移中的灵活构造模式。此外 `increment()`/`decrement()` 具名函数也缺失。这些是 OOD 设计中明确列出的 API，建议在后续迭代中补充。

`componentAt()` 缺失 `const` 修饰符是一个语法级别的疏忽，修复成本极低。`==` 使用精确比较而非 Epsilon 容差比较是 OOD 设计偏离，但其行为实际上与 C++ GLM 1.0.3 的 `==` 语义一致（OOD §3.5 也承认 Epsilon 容差是"仓颉迁移新增的全量行为偏离"），可根据实际需求决定是否调整。
