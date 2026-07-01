# 任务指令（v4）

## 动作
NEW

## 任务描述
**替换 `src/detail/trigonometric.cj` 的 stub 为完整实现** — 15 个三角函数，每个标量+Vec1~Vec4 重载，共 75 个 public 函数。

函数列表（按现有 stub 声明）：
- 一元：`sin` / `cos` / `tan` / `asin` / `acos` / `atan` / `sinh` / `cosh` / `tanh` / `asinh` / `acosh` / `atanh` / `radians` / `degrees`
- 二元：`atan2`

标量实现直接调用 `stdmath_shim.cj` 中同名的 `xxxT` 泛型包装函数（`sinT` / `cosT` / `tanT` / `asinT` / `acosT` / `atanT` / `atan2T` / `sinhT` / `coshT` / `tanhT` / `asinhT` / `acoshT` / `atanhT`）。
- `radians<T>(x)` = `x * (T)pi / T(180)`
- `degrees<T>(x)` = `x * T(180) / (T)pi`

Vec1~Vec4 重载：逐分量调用标量版本，包裹在 `VecN(...)` 中（同 `exponential.cj` 和 `common.cj` 的模式）。

泛型约束：所有函数添加 `where T <: FloatingPoint<T>, Q <: Qualifier`。

## 选择理由
- 紧跟 Task 2+3（common.cj + exponential.cj）完成之后，是第三个 detail/ 核心数学模块
- trigonometric.cj 目前仍为全部 stub（`throw Exception("stub")`）
- 遵循与 common.cj / exponential.cj 完全相同的实现模式（标量委托 stdmath_shim + Vec 逐分量）
- 不依赖任何其他待实现模块，可独立构建和测试

## 任务上下文
- 目标文件：`src/detail/trigonometric.cj`（已有 stub 声明，共 93 行）
- 已有辅助：`src/detail/stdmath_shim.cj` 提供 `sinT`/`cosT`/`tanT`/`asinT`/`acosT`/`atanT`/`atan2T`/`sinhT`/`coshT`/`tanhT`/`asinhT`/`acoshT`/`atanhT` 共 13 个泛型包装函数
- pi 常量：`src/detail/scalar_constants.cj` 中的 `pi<T>()` 或 `std.math.pi`
- **注意：** 现有 `tests/glm/detail/trigonometric_stub_test.cj`（81 行）全部为 `@ExpectThrows[Exception]` 存根测试。替换为真实实现后，**该文件必须删除/替换**，否则测试将失败。需新建 `tests/glm/detail/trigonometric_test.cj` 编写真实测试（遵循 `exponential_test.cj` / `common_test.cj` 模式）。

## 已有代码上下文
`src/detail/exponential.cj` 的实现模式（61 行）直接可复用于本任务：

```cangjie
// scalar 实现
public func sin<T>(x: T): T where T <: FloatingPoint<T> { sinT(x) }

// Vec1~Vec4 重载
public func sin<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec1(sinT(x.x))
}
public func sin<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec2(sinT(x.x), sinT(x.y))
}
// ... Vec3, Vec4 同理
```

`radians`/`degrees` 的标量实现：
```
public func radians<T>(x: T): T where T <: FloatingPoint<T> {
    let p: T = (pi<Float64>() as T).getOrThrow()
    x * p / (Float64(180) as T).getOrThrow()
}
public func degrees<T>(x: T): T where T <: FloatingPoint<T> {
    let p: T = (pi<Float64>() as T).getOrThrow()
    x * (Float64(180) as T).getOrThrow() / p
}
```

## 测试计划

### 操作清单
| 操作 | 文件 | 说明 |
|------|------|------|
| 删除 | `tests/glm/detail/trigonometric_stub_test.cj` | 原存根测试（81 行，全部 `@ExpectThrows[Exception]`），已不适配真实实现 |
| 新建 | `tests/glm/detail/trigonometric_test.cj` | 真实行为测试，遵循 `exponential_test.cj` / `common_test.cj` 模式 |

### 测试覆盖要求
- **标量 (Float64/Float32/Float16)**：每个一元函数至少一个已知值断言（如 `sin(0) == 0`、`cos(0) == 1`、`radians(180) ≈ pi`、`degrees(pi) ≈ 180`）
- **Vec1~Vec4**：每个函数至少一个向量类型，逐分量断言
- **atan2**：覆盖 `(0,1)`、`(1,0)` 等典型象限
- **边界**：`asin(±1)`、`acos(±1)`、`atanh(0)` 等不抛异常

### 期望测试量
- 约 40-60 个 `@Test` 函数，与 `exponential_test.cj`（41 个 `@Test`）量级相当

## 修订说明（v4 r1）
| 审查意见 | 修改措施 |
|---------|---------|
| trigonometric 模块现有测试只覆盖存根行为（expect throws），替换为真实实现后测试会失败 | 删除 `trigonometric_stub_test.cj` 存根测试文件；新增 `trigonometric_test.cj` 真实行为测试计划；更新任务上下文中 "无需新建测试文件" 的错误描述 |
