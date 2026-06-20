# 详细设计（v1）

## 概述

本设计对应 OOD Phase0 的任务 1——项目基础设施层。目标是搭建 `glm` 静态库项目的完整骨架和底层依赖模块，为后续 Vec 类型和运算层提供编译基础。范围包括：项目初始化、版本/配置常量、基础类型别名、断言工具、数值极限查询、Qualifier 精度体系，以及对应的单元测试。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `src/glm/lib.cj` | 新建 | `package glm` 占位文件，后续轮次通过 `public import` 暴露核心类型 |
| `src/glm/fwd.cj` | 新建 | `package glm` 占位文件，后续轮次存放 256 个类型别名 |
| `src/glm/detail/setup.cj` | 新建 | 版本常量 (`GLM_VERSION_*`) 和配置开关 (`GLM_CONFIG_*`) |
| `src/glm/detail/qualifier.cj` | 新建 | Qualifier 接口及 6 个实现结构体、Defaultp 别名 |
| `src/glm/detail/shim_assert.cj` | 新建 | `assert(condition, message)` 泛型断言函数 |
| `src/glm/detail/shim_limits.cj` | 新建 | `NumericLimits<T>` 结构体、`isIec559Of<T>()`、`epsilonOf<T>()` |
| `src/glm/detail/shim_cstddef.cj` | 新建 | `SizeT` 和 `LengthT` 类型别名 |
| `tests/glm/test_lib.cj` | 新建 | `package glm` 占位测试 |
| `tests/glm/test_fwd.cj` | 新建 | `package glm` 占位测试 |
| `tests/glm/detail/test_setup.cj` | 新建 | 版本常量值验证 |
| `tests/glm/detail/test_qualifier.cj` | 新建 | Qualifier 实例化和接口实现验证 |
| `tests/glm/detail/test_shim_assert.cj` | 新建 | assert 通过/失败行为验证 |
| `tests/glm/detail/test_shim_limits.cj` | 新建 | NumericLimits epsilon、isIec559Of、epsilonOf 验证 |

## 类型定义

### SizeT
**形态**：`type` 别名
**包路径**：`glm.detail`
**职责**：无符号大小类型，等效 C++ `size_t`
```
public type SizeT = UInt64
```

### LengthT
**形态**：`type` 别名
**包路径**：`glm.detail`
**职责**：有符号长度/索引类型，等效 C++ `length_t`
```
public type LengthT = Int64
```

### NumericLimits<T>
**形态**：struct
**包路径**：`glm.detail`
**职责**：数值极限查询，等效 C++ `std::numeric_limits`
```
public struct NumericLimits<T> where T <: Number<T> {
    public static func max(): T
    public static func min(): T
    public static func epsilon(): T
}
```
**公开接口**：
- `static func max(): T` —— 返回 `T.Max`（依赖编译器对具体类型静态属性的泛型解析；若编译失败可移除，因 phase0 无消费方）
- `static func min(): T` —— 返回 `T.Min`（同上）
- `static func epsilon(): T` —— 浮点机器 epsilon：`Float32` 返回 `1.1920929e-7`，`Float64` 返回 `2.220446049250313e-16`

**构造方式**：无实例构造，全部为静态方法
**类型关系**：泛型参数 `T` 受 `Number<T>` 约束

### Qualifier
**形态**：interface
**包路径**：`glm.detail`
**职责**：精度/对齐策略的多态契约标记
```
public interface Qualifier {}
```

### PackedHighp / PackedMediump / PackedLowp
**形态**：struct
**包路径**：`glm.detail`
**职责**：Packed 精度标记（紧缩存储），实现 `Qualifier` 接口
```
public struct PackedHighp <: Qualifier {}
public struct PackedMediump <: Qualifier {}
public struct PackedLowp <: Qualifier {}
```

### AlignedHighp / AlignedMediump / AlignedLowp
**形态**：struct
**包路径**：`glm.detail`
**职责**：Aligned 精度标记（对齐存储），实现 `Qualifier` 接口。首轮 `GLM_CONFIG_ALIGNED_GENTYPES = false`，标记为 `internal` 不对外暴露
```
internal struct AlignedHighp <: Qualifier {}
internal struct AlignedMediump <: Qualifier {}
internal struct AlignedLowp <: Qualifier {}
```

### Defaultp
**形态**：`type` 别名
**包路径**：`glm.detail`
**职责**：默认精度别名，指向 `PackedHighp`
```
public type Defaultp = PackedHighp
```

## 包级函数

### assert
**包路径**：`glm.detail`
**职责**：断言工具，条件不满足时抛 `Exception`
```
public func assert(condition: Bool, message: String = "Assertion failed"): Unit
```

### isIec559Of\<T\>
**包路径**：`glm.detail`
**职责**：编译期判断 T 是否为 IEEE 754 浮点类型
```
const func isIec559Of<T>(): Bool
```
**实现策略**：`T(0) is Float64 || T(0) is Float32`

### epsilonOf\<T\>
**包路径**：`glm.detail`
**职责**：返回 T 类型的机器 epsilon，委托给 `NumericLimits<T>.epsilon()`
```
const func epsilonOf<T>(): T where T <: Number<T>
```

## 错误处理

- `assert` 使用异常抛出的错误策略：`condition` 为 `false` 时 `throw Exception(message)`
- `NumericLimits` 不涉及运行时错误（全部为编译期常量查询）
- `isIec559Of<T>()` 和 `epsilonOf<T>()` 无运行时错误路径
- 测试中 `test_assert_fails` 通过 `try/catch` 验证 `assert(false)` 抛 `Exception`

## 行为契约

### setup.cj 常量
| 常量名 | 值 | 说明 |
|--------|-----|------|
| `GLM_VERSION_MAJOR` | `Int64(1)` | 主版本号 |
| `GLM_VERSION_MINOR` | `Int64(0)` | 次版本号 |
| `GLM_VERSION_PATCH` | `Int64(3)` | 修订号 |
| `GLM_VERSION` | `Int64(103)` | 编码版本号 |
| `GLM_CONFIG_SIMD` | `false` | SIMD 禁用 |
| `GLM_CONFIG_ALIGNED_GENTYPES` | `false` | 对齐类型禁用 |
| `GLM_CONFIG_CLIP_CONTROL` | `false` | 裁剪控制禁用 |

### assert 契约
- **前置条件**：无
- **后置条件**：`condition == true` 时正常返回；`condition == false` 时抛出 `Exception`
- **稳定性保证**：Debug 和 Release 模式下均保留断言行为

### NumericLimits\<T\> 契约
- **前置条件**：`T` 满足 `Number<T>` 约束
- **epsilon 精度保证**：`Float32` 返回 `1.1920929e-7`，`Float64` 返回 `2.220446049250313e-16`
- **max()/min() 可用性**：依赖编译器对泛型参数的静态属性解析能力；若 `T.Max`/`T.Min` 在泛型上下文中不可用，这两个方法可安全移除（phase0 无消费方）

### isIec559Of\<T\> 契约
- **对任意 T 可用**：非浮点 T 返回 `false`，不产生编译错误
- **编译期求值**：可在 `const` 函数体内使用

### epsilonOf\<T\> 契约
- **约束**：`where T <: Number<T>`，确保仅在数值类型上可用
- **若编译器对非选择分支中的泛型约束做全面检查**：`epsilonOf<Bool>()` 等无效实例化可能产生编译错误——此时需移除 `where` 约束或改用内联容差（路径 A/B 待编码阶段验证后选择）

### Qualifier 契约
- **跨 Q 赋值**：首轮所有 Qualifier 实现均为空结构体，跨 Q 赋值在运行时无数据差异，仅在编译期类型签名中区分
- **Aligned 系列**：首轮使用 `internal` 可见性，仅在 `glm.detail` 包内可见，不对外暴露

## 依赖关系

### 模块间依赖
| 文件 | 依赖 | 说明 |
|------|------|------|
| `setup.cj` | 无 | 纯常量定义 |
| `shim_cstddef.cj` | 无 | 纯类型别名 |
| `shim_assert.cj` | 无 | 仅使用标准库 `Exception` |
| `shim_limits.cj` | `std.math.{ Number }` | 用于 `Number<T>` 接口约束 |
| `qualifier.cj` | 无 | 纯接口和空结构体 |

### 测试依赖
| 文件 | 依赖 | 说明 |
|------|------|------|
| `test_setup.cj` | `glm.detail.*` | 引用 setup 常量 |
| `test_qualifier.cj` | `glm.detail.*` | 引用 Qualifier 体系 |
| `test_shim_assert.cj` | `glm.detail.*` | 引用 assert |
| `test_shim_limits.cj` | `glm.detail.*` | 引用 NumericLimits 等 |
| `test_lib.cj` | `glm.*` | 占位测试 |
| `test_fwd.cj` | `glm.*` | 占位测试 |

### 外部依赖
- `std.math.{ Number }` —— shim_limits 使用 `Number<T>` 约束泛型参数
- `std.unittest.*` —— 测试框架标注 `@Test` 和 `@Assert`

### 暴露给后续任务的接口
本层提供的所有类型均在 `glm.detail` 包中，后续 Vec 类型层依赖：
- `Qualifier` 接口和 `PackedHighp`/`PackedMediump`/`PackedLowp` —— 作为 Vec 泛型参数 `Q` 的约束
- `Defaultp` —— 默认精度别名
- `SizeT`/`LengthT` —— 基础类型别名
- `assert` —— 运行时边界检查
- `NumericLimits.epsilon()`/`isIec559Of<T>()`/`epsilonOf<T>()` —— `ComputeEqual.callConst` 和 `equalEpsilon` 的浮点容差比较依赖
