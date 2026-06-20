# 任务指令（v2）

## 动作
NEW

## 任务描述
实现核心抽象层（ComputeEqual + Functor + ComputeVecDecl），对应计划中的 **R2 02-核心抽象层**。

需要创建以下文件：

### `src/detail/compute_vector_relational.cj`
`package glm.detail`

定义 `ComputeEqual<T>` 结构体，提供分量级别的相等比较策略，Vec 的 `operator ==` 委托此类型做逐分量比较。

```
public struct ComputeEqual<T> {
    // 非 const 精确比较版本
    public static func call(a: T, b: T): Bool { a == b }

    // 运行时分支版本：通过非 const 运行时 if 实现浮点/整数双路径分支
    // 依赖 isIec559Of<T>(hint: T)（判断 T 是否 IEEE 754 浮点）
    // 依赖 epsilonOf<T>(hint: T)（获取机器 epsilon）
    // 依赖 std.math.abs（包级函数）
    public static func callConst(a: T, b: T): Bool {
        if (isIec559Of(a)) {
            abs(a - b) <= epsilonOf(a)
        } else {
            a == b
        }
    }
}
```

> **设计偏差说明**：OOD 设计文档原案中 `callConst` 声明为 `const static func`，期望通过编译期 `if` 分支在 const 上下文中实现双路径。R1 验证确认 `isIec559Of`/`epsilonOf` 在 `shim_limits.cj` 中的实现为非 const 函数（使用运行时 `match`/`is` 类型分发），const 函数体内无法调用非 const 函数。因此移除 `const` 修饰符，改为运行时分支路径。此偏差已与 R1 交付物对齐。

**依赖**：`shim_limits.cj`（`isIec559Of`/`epsilonOf`）、`std.math.{ abs }`

### `src/detail/vectorize.cj`
`package glm.detail`

定义 Functor 体系——封装"对标量函数逐分量映射到向量"的调用模式，为后续轮次 SIMD 优化或 swizzle 操作预留。按分量数拆分，Vec1~Vec4 各定义四组独立的 functor 结构体：

- **Functor1Vec1<R, T, Q>** ~ **Functor1Vec4<R, T, Q>** — 一元映射（`Func(T) -> R`），提供 `static call(callable: (T) -> R, v: VecN<T, Q>): VecN<R, Q>`
- **Functor2Vec1<T, Q>** ~ **Functor2Vec4<T, Q>** — 二元映射（`Func(T, T) -> T`），提供 `static call(callable: (T, T) -> T, a: VecN<T, Q>, b: VecN<T, Q>): VecN<T, Q>`
- **Functor2VecScaVec1<T, Q>** ~ **Functor2VecScaVec4<T, Q>** — 向量-标量二元映射，提供 `static call(callable: (T, T) -> T, v: VecN<T, Q>, s: T): VecN<T, Q>`
- **Functor2VecIntVec1<T, Q>** ~ **Functor2VecIntVec4<T, Q>** — 向量-整数向量二元映射，提供 `static call(callable: (T, Int64) -> T, v: VecN<T, Q>, i: Int64): VecN<T, Q>`

所有结构体均使用 `where Q <: Qualifier` 约束。首轮这些类型仅定义类型，不产生消费代码。

**依赖**：`qualifier.cj`（Qualifier 接口）、`shim_cstddef.cj`（LengthT）

### `src/detail/compute_vector_decl.cj`
`package glm.detail`

定义 `compute_vec_*` 运算策略结构体，封装向量逐分量运算的具体实现，为后续轮次 SIMD 路径或特化提供扩展点。首轮仅定义类型，不被 Vec 运算符实现调用。

按分量数分别定义 Vec1~Vec4 版本，每个结构体提供 `static call` 方法。包含以下策略结构体（各 Vec1~Vec4 四组）：

| 策略 | 职责 | call 签名 |
|------|------|-----------|
| `compute_vec_add<T, Q>` | 逐分量加法 | `(VecN<T,Q>, VecN<T,Q>) -> VecN<T,Q>` |
| `compute_vec_sub<T, Q>` | 逐分量减法 | `(VecN<T,Q>, VecN<T,Q>) -> VecN<T,Q>` |
| `compute_vec_mul<T, Q>` | 逐分量乘法 | `(VecN<T,Q>, VecN<T,Q>) -> VecN<T,Q>` |
| `compute_vec_div<T, Q>` | 逐分量除法 | `(VecN<T,Q>, VecN<T,Q>) -> VecN<T,Q>` |
| `compute_vec_mod<T, Q>` | 逐分量取模 | `(VecN<T,Q>, VecN<T,Q>) -> VecN<T,Q>` |
| `compute_vec_and<T, Q>` | 逐分量按位与 | `(VecN<T,Q>, VecN<T,Q>) -> VecN<T,Q>` |
| `compute_vec_or<T, Q>` | 逐分量按位或 | `(VecN<T,Q>, VecN<T,Q>) -> VecN<T,Q>` |
| `compute_vec_xor<T, Q>` | 逐分量按位异或 | `(VecN<T,Q>, VecN<T,Q>) -> VecN<T,Q>` |
| `compute_vec_shift_left<T, Q>` | 逐分量左移 | `(VecN<T,Q>, VecN<T,Q>) -> VecN<T,Q>` |
| `compute_vec_shift_right<T, Q>` | 逐分量右移 | `(VecN<T,Q>, VecN<T,Q>) -> VecN<T,Q>` |
| `compute_vec_equal<T, Q>` | 逐分量相等比较 | `(VecN<T,Q>, VecN<T,Q>) -> VecN<Bool, Q>` |
| `compute_vec_nequal<T, Q>` | 逐分量不等比较 | `(VecN<T,Q>, VecN<T,Q>) -> VecN<Bool, Q>` |
| `compute_vec_bitwise_not<T, Q>` | 逐分量按位取反 | `(VecN<T,Q>,) -> VecN<T,Q>` |

命名约定：`compute_vec_add1` ~ `compute_vec_add4`、`compute_vec_sub1` ~ `compute_vec_sub4` 等（数字后缀表示分量数）。

所有结构体使用 `where Q <: Qualifier` 约束。首轮 `call` 方法直接实现逐分量运算（非 SIMD 路径）。

**依赖**：`vectorize.cj`（Functor 类型）、`qualifier.cj`（Qualifier）

### 测试文件
按项目惯例，测试文件与源文件混排于 `src/` 下，以 `_test.cj` 后缀命名：

- `src/detail/compute_vector_relational_test.cj`：验证 `ComputeEqual</* 具体类型 */>.call(a, b)` 和 `.callConst(a, b)` 对 `Int32`、`Float32`、`Float64`、`Bool` 等类型的编译通过和运行时行为
- `src/detail/vectorize_test.cj`：验证 Functor 各结构体可正确实例化，Functor1 的 `call` 可调用一元函数映射
- `src/detail/compute_vector_decl_test.cj`：验证 ComputeVec* 各结构体可正确实例化，`call` 方法可执行逐分量运算

## 选择理由
R1 基础设施层已验证通过，本层定义向量运算的策略抽象层，是 Vec 结构体实现二元运算符和比较运算符的前置依赖。Functor 和 ComputeVecDecl 虽首轮不被消费（为后续 SIMD 轮次预留），但定义需在该层完成以维持编译通过。ComputeEqual 是 Vec 的 `operator ==` 直接依赖。

## 任务上下文
### 设计文档引用
- §3.3 Functor 体系（Functor1~Functor2VecInt 的设计方案）
- §3.4 ComputeVec* 运算策略体系（compute_vec_add/sub 等）
- §3.5 ComputeEqual（相等比较策略，编译期 `if` 双路径）
- §2 模块间依赖（compute_vector_relational → shim_limits, vectorize → qualifier, compute_vector_decl → vectorize + qualifier）

### 关键设计约束
1. `ComputeEqual.callConst` 使用运行时 `if` 分支，非 const 函数。`isIec559Of(hint: T)` 和 `epsilonOf(hint: T)` 均需 `hint` 入参，符合 R1 交付物接口
2. `ComputeEqual.callConst` 中的 `abs(a - b)` 调用 `std.math.abs` 包级函数（非 const 上下文），`epsilonOf<T>(a)` 调用 `shim_limits.cj` 中的非 const 泛型函数
3. Functor 和 ComputeVecDecl 结构体首轮无消费方，仅定义类型供后续轮次使用
4. 测试文件需声明 `package glm.detail`（与生产代码同包），以访问 `internal` 可见性类型

## 已有代码上下文
### R1 已验证通过的基础设施
- `src/detail/qualifier.cj`：`Qualifier` 接口 + `PackedHighp`/`PackedMediump`/`PackedLowp` + `Defaultp` 别名
- `src/detail/shim_limits.cj`：`NumericLimits<T>.epsilon()`、`isIec559Of<T>(hint: T): Bool`、`epsilonOf<T>(hint: T): T where T <: Number<T>`
- `src/detail/shim_cstddef.cj`：`SizeT`/`LengthT` 类型别名
- `src/detail/setup.cj`：版本/配置常量

### Vec 类型（后续层依赖）
本层定义的 `ComputeEqual` 将被 Vec1~Vec4 的 `operator ==` 调用；Functor 和 ComputeVecDecl 为后续 SIMD 轮次预留。

---

## 修订说明（v2 r1）
| 审查意见 | 修改措施 |
|---------|---------|
| 文件路径与项目实际结构不一致：task_v2.md 将所有新文件路径指定为 `src/glm/detail/`，但现有 R1 文件均直接位于 `src/detail/` | 将所有 `src/glm/detail/` 路径改为 `src/detail/`，与 R1 交付物保持一致 |
| `ComputeEqual.callConst` 接口签名与 R1 `shim_limits` 不兼容：使用无参数 `isIec559Of<T>()` 和 `epsilonOf<T>()`，但 R1 实现要求 `hint: T` 入参 | 更新 `callConst` 实现：`isIec559Of(a)` / `epsilonOf(a)` 传递 hint 参数 |
| const 函数体内调用非 const 函数导致编译不通过：`callConst` 声明为 `const` 但调用非 const 的 `isIec559Of`/`epsilonOf` | 移除 `callConst` 的 `const` 修饰符，改为运行时分支路径（非 const）。更新注释和设计约束说明以反映此偏差。此修正与 OOD 设计文档 §3.5 备选路径（回退到精确比较 + 浮点容差比较由非 const 函数提供）一致 |
