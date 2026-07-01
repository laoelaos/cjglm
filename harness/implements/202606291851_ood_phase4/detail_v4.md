# 详细设计（v4）

## 概述

将 `src/detail/trigonometric.cj` 的 93 行 stub（全部 `throw Exception("stub")`）替换为完整实现。15 个三角函数，每个函数提供标量 + Vec1~Vec4 共 5 个重载，总计 75 个 `public` 函数。实现模式与 `exponential.cj` 完全一致：标量版本委托 `stdmath_shim.cj` 的包装函数，Vec 版本逐分量包裹在 `VecN(...)` 中。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| src/detail/trigonometric.cj | 修改 | 替换全部 stub 为完整实现（93 行 → 约 210 行） |
| tests/glm/detail/trigonometric_stub_test.cj | 删除 | 原有 81 行 `@ExpectThrows[Exception]` 存根测试，不再适用 |
| tests/glm/detail/trigonometric_test.cj | 新建 | 真实行为测试，约 40~60 个 `@Test`，遵循 common_test.cj/exponential_test.cj 模式 |

## 无新类型定义

本任务不新增任何 class/interface/enum/struct 类型，仅实现包级（package-level）自由函数。

## 函数设计总则

### 标量版本

```cangjie
// 一元：直接委托 stdmath_shim 的同名包装函数
public func sin<T>(x: T): T where T <: FloatingPoint<T> { sinT(x) }
public func cos<T>(x: T): T where T <: FloatingPoint<T> { cosT(x) }
// ... 同理

// asin/acos：需越界保护（std.math.asin/acos 在输入超出 [-1,1] 时抛异常而非返回 NaN）
public func asin<T>(x: T): T where T <: FloatingPoint<T> {
    if (x < -T(1) || x > T(1)) { return T.getNaN() }  // 越界返回 NaN，与 GLM 一致
    asinT(x)
}
// acos 同理

// radians/degrees：使用 pi<T>()，字面量通过 (Float64(n) as T).getOrThrow() 构造
public func radians<T>(x: T): T where T <: FloatingPoint<T> {
    let p: T = (pi<Float64>() as T).getOrThrow()
    x * p / (Float64(180) as T).getOrThrow()
}
public func degrees<T>(x: T): T where T <: FloatingPoint<T> {
    let p: T = (pi<Float64>() as T).getOrThrow()
    x * (Float64(180) as T).getOrThrow() / p
}
```

### Vec1~Vec4 版本

逐分量调用标量版本（或包装函数），包裹在 `VecN(...)` 中。多数函数通过 `xxxT` 直接委托，但 `asin`/`acos`/`radians`/`degrees` 需调用标量版本以获取越界保护或公式封装：

```cangjie
// 多数函数（sin/cos/tan/atan/sinh/cosh/tanh/asinh/acosh/atanh）：
// 逐分量调用 xxxT 直接委托，因为标量版本只是纯委托（无额外逻辑）
public func sin<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec1(sinT(x.x))
}
public func sin<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec2(sinT(x.x), sinT(x.y))
}
public func sin<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec3(sinT(x.x), sinT(x.y), sinT(x.z))
}
public func sin<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec4(sinT(x.x), sinT(x.y), sinT(x.z), sinT(x.w))
}

// asin/acos：调用标量版本 asin/acos（而非 asinT/acosT），
// 确保越界输入被标量版本的边界保护（x<-1||x>1→NaN）捕获
public func asin<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec1(asin(x.x))
}
public func asin<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec2(asin(x.x), asin(x.y))
}
public func asin<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec3(asin(x.x), asin(x.y), asin(x.z))
}
public func asin<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec4(asin(x.x), asin(x.y), asin(x.z), asin(x.w))
}
// acos Vec1~Vec4 同理调用标量 acos
```

`atan2` 是二元函数，Vec 版本取两个向量参数，标量版本为纯委托，Vec 可直接调用 `atan2T`：

```cangjie
public func atan2<T, Q>(y: Vec2<T, Q>, x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec2(atan2T(y.x, x.x), atan2T(y.y, x.y))
}
```

`radians`/`degrees` 的 Vec 版本逐分量调用标量版本的 `radians`/`degrees`（而非内联公式），因为标量版本已封装 pi 构造逻辑：

```cangjie
public func radians<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier {
    Vec2(radians(x.x), radians(x.y))
}
```

## 函数签名清单

### 一元标量（14 个函数）

| 函数 | 委托目标 | 特殊处理 |
|------|---------|---------|
| `sin<T>(x: T): T` | `sinT(x)` | 无 |
| `cos<T>(x: T): T` | `cosT(x)` | 无 |
| `tan<T>(x: T): T` | `tanT(x)` | 无 |
| `asin<T>(x: T): T` | `asinT(x)` | 前置：`x<-1||x>1→NaN` |
| `acos<T>(x: T): T` | `acosT(x)` | 前置：`x<-1||x>1→NaN` |
| `atan<T>(x: T): T` | `atanT(x)` | 无 |
| `sinh<T>(x: T): T` | `sinhT(x)` | 无 |
| `cosh<T>(x: T): T` | `coshT(x)` | 无 |
| `tanh<T>(x: T): T` | `tanhT(x)` | 无 |
| `asinh<T>(x: T): T` | `asinhT(x)` | 无 |
| `acosh<T>(x: T): T` | `acoshT(x)` | 无 |
| `atanh<T>(x: T): T` | `atanhT(x)` | 无 |
| `radians<T>(x: T): T` | 公式：`x * pi / 180` | 使用 `pi<T>()` + `(Float64(180) as T).getOrThrow()` |
| `degrees<T>(x: T): T` | 公式：`x * 180 / pi` | 同上 |

全部约束：`where T <: FloatingPoint<T>`

### 二元标量（1 个函数）

| 函数 | 委托目标 | 特殊处理 |
|------|---------|---------|
| `atan2<T>(y: T, x: T): T` | `atan2T(y, x)` | 无 |

约束：`where T <: FloatingPoint<T>`

### Vec 重载（15 个函数 × 4 维度 = 60 个函数）

每个标量函数对应 Vec1~Vec4 四个重载，签名模式与 `exponential.cj`/`common.cj` 一致：

```cangjie
// 多数函数：Vec 调用 xxxT 直接委托
public func sin<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func sin<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func sin<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func sin<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
// asin/acos: Vec 调用标量 asin/acos（含边界保护）
public func asin<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func asin<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func asin<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func asin<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
// radians/degrees: Vec 调用标量 radians/degrees（封装 pi 公式）
public func radians<T, Q>(x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func radians<T, Q>(x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func radians<T, Q>(x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func radians<T, Q>(x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
```

`atan2` 的 Vec 版本：

```cangjie
public func atan2<T, Q>(y: Vec1<T, Q>, x: Vec1<T, Q>): Vec1<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func atan2<T, Q>(y: Vec2<T, Q>, x: Vec2<T, Q>): Vec2<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func atan2<T, Q>(y: Vec3<T, Q>, x: Vec3<T, Q>): Vec3<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
public func atan2<T, Q>(y: Vec4<T, Q>, x: Vec4<T, Q>): Vec4<T, Q> where T <: FloatingPoint<T>, Q <: Qualifier
```

### 汇总

| 类别 | 函数数 | 标量 | Vec1 | Vec2 | Vec3 | Vec4 | 小计 |
|------|--------|------|------|------|------|------|------|
| 一元标量 | 14 | ✓(14) | ✓(14) | ✓(14) | ✓(14) | ✓(14) | 70 |
| 二元 | 1 | ✓(1) | ✓(1) | ✓(1) | ✓(1) | ✓(1) | 5 |
| **总计** | **15** | **15** | **15** | **15** | **15** | **15** | **75** |

### Vec 重载委托目标

| 标量函数 | Vec 委托目标 | 原因 |
|---------|-------------|------|
| `sin` / `cos` / `tan` / `atan` | `sinT` / `cosT` / `tanT` / `atanT` | 标量版本为纯委托，无额外逻辑 |
| `asin` / `acos` | 标量 `asin` / `acos` | 需经过标量版本的越界保护（`x<-1||x>1→NaN`） |
| `sinh` / `cosh` / `tanh` | `sinhT` / `coshT` / `tanhT` | 标量版本为纯委托，无额外逻辑 |
| `asinh` / `acosh` / `atanh` | `asinhT` / `acoshT` / `atanhT` | 标量版本为纯委托，无额外逻辑 |
| `radians` / `degrees` | 标量 `radians` / `degrees` | 需经过标量版本的 pi 构造封装 |
| `atan2` | `atan2T` | 标量版本为纯委托，无额外逻辑 |

## 错误处理

- 函数不抛出异常（stub 移除后，`IllegalArgumentException` 来源全部消除）。`asin`/`acos` 的越界保护将非法输入转化为 NaN 返回，与 GLM 1.0.3 一致
- 所有内部 `as T).getOrThrow()` 转换可能因类型溢出（如 Float64→Float16 转型）抛出异常，但这是浮点表示限制，非函数逻辑错误，与 exponential.cj/common.cj 行为一致

## 行为契约

1. 标量版本行为与 `std.math` 对应函数一致（经 `stdmath_shim.cj` 的 Float64 转型委托），仅 `asin`/`acos` 增加越界→NaN 保护
2. Vec 版本行为等价于逐分量应用标量版本
3. `radians(180)` ≈ `pi<T>()`，`degrees(pi<T>())` ≈ 180
4. `asin(±1)`/`acos(±1)` 返回 ±π/2 / 0/π 的数学正确值（不抛异常）
5. `atanh(0)` 返回 0（不抛异常）
6. 与 `exponential.cj` 和 `common.cj` 保持一致的泛型约束风格（`FloatingPoint<T>` + 必要时 `Qualifier`）

## 依赖关系

| 依赖 | 说明 |
|------|------|
| `stdmath_shim.cj` | 提供 `sinT`/`cosT`/`tanT`/`asinT`/`acosT`/`atanT`/`atan2T`/`sinhT`/`coshT`/`tanhT`/`asinhT`/`acoshT`/`atanhT` 共 13 个包装函数（同包，无需 import） |
| `scalar_constants.cj` | 提供 `pi<T>()` 函数，用于 `radians`/`degrees`（同包，无需 import） |
| `Vec1~Vec4` 类型 | 已存在于 `glm.detail` 包中 |
| `Qualifier` | 已存在于项目中 |

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

## 修订说明（v4 R1）
| 审查意见 | 修改措施 |
|---------|---------|
| Vec 版本的 asin/acos 调用 asinT/acosT 缺少越界保护（应调用标量 asin/acos 而非裸委托） | 1. Vec asin/acos 的委托目标从 `asinT`/`acosT` 改为标量 `asin`/`acos`，确保越界输入被标量版本的边界保护捕获<br>2. 新增 Vec 重载委托目标表格，明确每个函数的 Vec 委托策略<br>3. 移除原文第 74 行错误声明（"Vec 版本调用 asinT/acosT 时已通过标量版本获得越界保护"），替换为正确的 asin/acos Vec 代码示例 |
