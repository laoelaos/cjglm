# 任务指令（v1）

## 动作
NEW

## 任务描述
实现 detail 基础层：(a) 在 `detail/scalar_constants.cj` 中实现 3 个标量常量函数（epsilon<T>()、pi<T>()、cos_one_over_two<T>()），并在 `ext/scalar_constants.cj` 中通过 `public import glm.detail.{epsilon, pi, cos_one_over_two}` 重导出；(b) 在 `detail/trigonometric.cj` 中声明 75 个 stub 函数签名（所有函数体统一 `throw Exception("stub")`）

**预期文件**：
- `src/detail/scalar_constants.cj`（新建，package glm.detail）
- `src/ext/scalar_constants.cj`（新建，package glm.ext）
- `src/detail/trigonometric.cj`（新建，package glm.detail）
- `tests/glm/detail/test_scalar_constants.cj`（新建）
- `tests/glm/detail/test_trigonometric_stub.cj`（新建）

## 选择理由
底层依赖优先——scalar_constants 是 gtc/constants.cj、四元数三角函数的前置依赖；trigonometric stubs 是 slerp/angle/angleAxis 的传递依赖。两者均仅依赖已有 `setup.cj`，无交叉依赖，可合并为一轮实现，符合粒度优化要求（原 R1+R2 合并）。

## 任务上下文

### Part A: scalar_constants（OOD §3.12）
```cangjie
// detail/scalar_constants.cj — package glm.detail
public func epsilon<T>(): T where T <: FloatingPoint<T>
public func pi<T>(): T where T <: FloatingPoint<T>
public func cos_one_over_two<T>(): T where T <: FloatingPoint<T>
```

**实现策略**：
- 使用 `where T <: FloatingPoint<T>` 约束，整数类型编译期拒绝
- 函数体内通过 `match (T(Float64(0)))` 运行时分派
- `epsilon<T>()` 委托 `epsilonOf<T>(T(Float64(0)))`（复用 `shim_limits.cj:25` 的 `NumericLimits<T>.epsilon(hint)` 模式）
- `pi<T>()` 使用 `FloatingPoint<T>.getPI()` 静态方法
- `cos_one_over_two<T>()` 使用硬编码值（OOD §3.12 line 806），不调用 `std.math.cos`

**硬编码值（ground truth）**：

| 函数 | Float32 | Float64 |
|------|---------|---------|
| `epsilon<T>()` | `Float32(1.1920929e-7)` | `Float64(2.220446049250313e-16)` |
| `pi<T>()` | `Float32(3.14159265358979323846)` | `Float64(3.14159265358979323846)` |
| `cos_one_over_two<T>()` | `Float32(0.877582561890372716)` | `Float64(0.877582561890372716)` |

**ext/scalar_constants.cj 重导出**：
```cangjie
package glm.ext
public import glm.detail.{epsilon, pi, cos_one_over_two}
```

### Part B: trigonometric stubs（OOD §3.13.1）
75 个函数签名模板，每个函数体 `{ throw Exception("stub") }`。含 14 个单参数三角函数（cos/sin/tan/acos/asin/atan/tan/cosh/sinh/tanh/acosh/asinh/atanh/degrees/radians）× 5 签名（标量 + Vec1~Vec4）+ 1 个双参数 atan2 × 5 签名。

所有函数使用统一约束 `where T <: FloatingPoint<T>, Q <: Qualifier`。

**完整签名清单见 OOD §3.13.1（75 行可复制模板）**。

### 测试验证
- `test_scalar_constants.cj`：交叉验证与 `epsilonOf<T>(hint)` 返回值一致；验证 Float32/Float64 精度值；验证 Int64 实例化编译拒绝
- `test_trigonometric_stub.cj`：验证 75 个签名存在且调用均抛 `Exception("stub")`

## 已有代码上下文

- `src/detail/shim_limits.cj:25` — `epsilonOf<T>(hint: T): T where T <: Number<T>`，内部 `NumericLimits<T>.epsilon(hint)` 模式
- `src/detail/setup.cj` — 阶段一配置层
- `src/lib.cj:2-8` — 现有 7 行 public import
- OOD §3.12 描述了 scalar_constants 与 shim_limits.cj 的关系
- OOD §3.13.1 给出了 75 个 trigonometric 函数签名完整模板
- `tests/glm/detail/test_shim_limits.cj` — 已有 shim_limits 测试，含 epsilon ground truth
