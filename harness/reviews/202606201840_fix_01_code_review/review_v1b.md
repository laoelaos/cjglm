# R1B: Vec1/Vec2类型系统 + scalar_vec_ops + fromBoolVec 修复质量验证

审查时间：2026-06-20

### 审查范围

- `cjglm/src/detail/scalar_vec_ops.cj`
- `cjglm/src/detail/type_vec1.cj`
- `cjglm/src/detail/type_vec2.cj`
- `cjglm/src/detail/type_fromBoolVec.cj`

审查依据：`docs/02_ood_phase0.md` OOD 设计文档 §4.3（标量-向量运算）、§4.1（Vec构造函数）、§4.2（下标访问）、§4.5（比较运算）、§4.6（递增/递减）、§4.8（fromBoolVec），及前序审查 `harness/reviews/202606201155_ood_phase0_code_review/todo.md` 对应待办项。

### 待办项逐项验证

以下对照 `todo.md` 中与本次审查范围相关的待办项，逐一验证修复情况。

#### 一、scalar_vec_ops.cj

**① 所有 20 个包级函数缺少 `const` 修饰符**（todo.md R1C）
- **验证结果**：所有 add/sub/mul/div 共 16 个函数（行6-83）及整数 mod 4 个函数（行85-103）均仍为 `public func`，未添加 `const`。
- **说明**：OOD 设计 §4.3 已修订为"首轮不再将 `scalar-op-vec` 方向包级独立函数声明为 `const`"，偏差项 IF-02 已记录此限制。当前实现与修订后设计一致。
- **covered by**: IF-02（已知偏差，排除报告）

**② `mod` 函数仅实现整数路径，缺少浮点双路径**（todo.md R1C）
- **验证结果**：**已修复**。新增 12 个浮点具体类型重载：Float32（行105-119）、Float64（行121-135）、Float16（行137-151），各覆盖 Vec1~Vec4，内部使用 `std.math.fmod`。
- **说明**：实现方式为具体类型重载而非 OOD §4.3 的泛型编译期分支方案。偏差项 DV-02 记录了 `%` 整数限制，DEV-05（未验证）已指出此变化。
- **covered by**: DV-02/DEV-05（已知偏差，排除报告）

#### 二、type_vec1.cj

**③ Vec1 缺少跨类型转换构造函数**（todo.md R2A）
- **验证结果**：**未修复**。结构体（行7-39）仅包含 `public const init(x: T)`，OOD §4.1 规定的以下跨类型构造函数均缺失：
  - `public init<T2, Q2>(v: Vec1<T2, Q2>) where Q2 <: Qualifier`
  - `public init<T2, Q2>(v: Vec2<T2, Q2>) where Q2 <: Qualifier`
  - `public init<T2, Q2>(v: Vec3<T2, Q2>) where Q2 <: Qualifier`
  - `public init<T2, Q2>(v: Vec4<T2, Q2>) where Q2 <: Qualifier`

**④ 缺少 increment()/decrement() 具名函数**（todo.md R2A）
- **验证结果**：**部分修复**。increment（行145-148）和 decrement（行150-153）已定义，但签名与 OOD §4.6 不一致。
- **位置**：`type_vec1.cj:146-153`
- **问题**：设计要求 `increment(): Vec1<T,Q>` 和 `decrement(): Vec1<T,Q>`（返回新向量，非 `mut`），当前实现为 `mut func increment(): Unit`（原地修改，无返回值）。此差异改变调用约定——C++ 迁移中 `++v`/`v++` 应替换为 `v = v.increment()`，当前 `Unit` 返回使此模式不可用（调用方只能原地修改 `v.increment()`，无法链式传递）。
- **covered by**: 未在任何偏差项中记录

**⑤ componentAt 缺少 const 标注**（todo.md R2A）
- **验证结果**：**未修复**。行32仍为 `public func componentAt(i: Int64): T`。
- **covered by**: IF-03（已知偏差，排除报告）

**⑥ `==` 运算符定义在 extend 块中，丢失 const 能力**（todo.md R2A）
- **验证结果**：**未修复**。行156-160仍在 `extend<T, Q> Vec1<T, Q> where T <: Equatable<T>` 块中定义。
- **covered by**: DV-05（已知偏差，排除报告）

#### 三、type_vec2.cj

**⑦ Vec2 缺少跨类型转换构造函数**（todo.md R2A）
- **验证结果**：**未修复**。结构体（行7-54）仅包含 `init(scalar: T)`、`const init(x: T, y: T)`、`init(v: Vec1<T, Q>)` 三个构造器。OOD §4.1 规定的以下构造函数均缺失：
  - `public init<T2, Q2>(v: Vec2<T2, Q2>) where Q2 <: Qualifier`（跨类型）
  - `public init<T2, Q2>(a: Vec1<T2, Q2>, b: T) where Q2 <: Qualifier`
  - `public init<T2, Q2>(a: T, b: Vec1<T2, Q2>) where Q2 <: Qualifier`
  - `public init<T2, Q2>(a: Vec1<T2, Q2>, b: Vec1<T2, Q2>) where Q2 <: Qualifier`
  - `public init<T2, Q2>(v: Vec3<T2, Q2>) where Q2 <: Qualifier`
  - `public init<T2, Q2>(v: Vec4<T2, Q2>) where Q2 <: Qualifier`

**⑧ 缺少 increment()/decrement() 具名函数**（todo.md R2A）
- **验证结果**：**部分修复**。increment（行125-128）和 decrement（行129-132）已定义，但签名与 OOD §4.6 不一致。
- **位置**：`type_vec2.cj:125-134`
- **问题**：同 Vec1——设计要求返回 `Vec2<T,Q>`，当前为 `mut func increment(): Unit`。调用约定不匹配。

**⑨ componentAt 缺少 const 标注**（todo.md R2A）
- **验证结果**：**未修复**。行46仍为 `public func componentAt(i: Int64): T`。
- **covered by**: IF-03（已知偏差，排除报告）

**⑩ `==` 运算符定义在 extend 块中，丢失 const 能力**（todo.md R2A）
- **验证结果**：**未修复**。行137-140仍在 `extend<T, Q> Vec2<T, Q> where T <: Equatable<T>` 块中定义。
- **covered by**: DV-05（已知偏差，排除报告）

#### 四、type_fromBoolVec.cj

**⑪ fromBoolVec 函数签名与 OOD §4.8 不一致**（todo.md R2C）
- **验证结果**：当前 OOD §4.8（行1113-1150）已包含 `zero: T, one: T` 参数，实现（行3-33）完全匹配设计签名。偏差项 DV-01 记录的是与 C++ GLM 的行为差异，并非实现与设计的不一致。
- **covered by**: DV-01（已知偏差，排除报告）

### 发现

#### [一般] Vec1 跨类型转换构造函数仍全部缺失

- **位置**：`type_vec1.cj:7-39`
- **描述**：前序审查（R2A）发现的待办项未修复。OOD §4.1 规定的 4 个跨类型构造函数（Vec1/2/3/4 → Vec1）全部缺失。当前仅 `const init(x: T)` 可用，调用方无法从其他 Vec 类型或不同 T/Q 参数构造 Vec1。
- **建议**：按 OOD §4.1 签名清单逐个补充 `public init<T2, Q2>(v: VecN<T2, Q2>) where Q2 <: Qualifier`（N=1/2/3/4），函数体内使用 `T(v.x)` 转换。

#### [一般] Vec2 跨类型转换及组合构造函数仍全部缺失

- **位置**：`type_vec2.cj:7-54`
- **描述**：前序审查（R2A）发现的待办项未修复。OOD §4.1 规定的 6 个跨类型/组合构造函数（跨类型 Vec2、Vec1+标量、标量+Vec1、Vec1+Vec1、Vec3截断、Vec4截断）全部缺失。
- **建议**：按 OOD §4.1 签名清单逐个补充。

#### [一般] increment()/decrement() 签名与 OOD 设计不一致（Vec1/Vec2）

- **位置**：`type_vec1.cj:145-153`、`type_vec2.cj:125-134`
- **描述**：OOD §4.6 明确要求 `increment(): VecN<T,Q>` 和 `decrement(): VecN<T,Q>`（非 `mut`，返回新向量），以便 C++ GLM 迁移模式 `v = v.increment()` 生效。当前实现使用 `mut func increment(): Unit`，返回 Unit 而非 Vec，调用方无法通过 `v = v.increment()` 获得增/减后的新向量，仅可原地修改。此差异影响 C++ `++v`/`v++` 的迁移路径。
- **建议**：改为非 `mut` 形式 `public func increment(): Vec1<T, Q>`，返回 `Vec1(this.x + ...)` 而非原地修改。如因语言限制必须保留 `mut` 形式，至少将返回类型改为 `T`（返回加 1 后的值）或同时提供两种变体。

### 本轮统计

| 严重程度 | 数量 |
|---------|------|
| 严重 | 0 |
| 一般 | 3 |
| 轻微 | 0 |

### 总评

本次审查覆盖 4 个源文件对应的 11 个前序待办项。`mod` 浮点路径已成功补全（新增 12 个浮点重载），`increment`/`decrement` 具名函数已添加但签名与设计不符（返回 `Unit` 而非 `VecN<T,Q>`）。**两个重大缺口仍未修复**：Vec1 和 Vec2 的跨类型转换构造函数体系全部缺失（OOD §4.1 规定的 4+6 个构造函数未实现），这直接影响 `VecN<T, Q>` 类型体系中跨类型转换和组合构造的核心可用性。此外，`componentAt` const 标注、`==` const 能力、`scalar_vec_ops` const 修饰符等已知偏差已由 `docs/deviations.md`（IF-02/IF-03/DV-05）正式记录，按本次审查排除范围不重复报告。
