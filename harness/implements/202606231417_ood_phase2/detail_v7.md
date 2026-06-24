# 详细设计（v7）

## 概述

创建 `src/detail/scalar_mat_ops.cj`（package glm.detail），实现 36 个标量-矩阵四则运算全局函数——add/sub/mul/div 各 9 重载（覆盖 Mat2x2~Mat4x4 全部 9 个矩阵类型）。同步创建测试文件 `tests/glm/detail/test_scalar_mat_ops.cj`。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| src/detail/scalar_mat_ops.cj | 新建 | 36 个顶层函数：add×9 + sub×9 + mul×9 + div×9 |
| tests/glm/detail/test_scalar_mat_ops.cj | 新建 | 覆盖全部 36 个函数的编译和执行验证 |

## 类型定义

本文件不定义新类型，仅提供顶层函数。所有数据类型已在同包 type_matNxN.cj 和 type_vecN.cj 中定义。

### 依赖的已有类型

| 类型 | 包路径 | 用途 |
|------|--------|------|
| Mat2x2<T,Q> ~ Mat4x4<T,Q> | glm.detail | 每个函数的第二参数和返回类型 |
| Vec2<T,Q> ~ Vec4<T,Q> | glm.detail | 矩阵类型成员的列向量类型 |
| Qualifier | glm.detail | 泛型约束 |
| Number<T> | std.math | 泛型算术约束 |

## 函数清单

全部 36 个函数遵循统一签名模式：

```cangjie
@OverflowWrapping
public func <op><T, Q>(s: T, m: Mat{C}x{R}<T, Q>): Mat{C}x{R}<T, Q>
    where T <: Number<T>, Q <: Qualifier
```

四个运算各 9 重载，覆盖以下矩阵类型：Mat2x2, Mat2x3, Mat2x4, Mat3x2, Mat3x3, Mat3x4, Mat4x2, Mat4x3, Mat4x4。

展开模式：`result.c_j[i] = s op m.c_j[i]`，即对矩阵每列的列向量逐分量应用标量运算，按属性访问 `.x/.y/.z/.w` 展开。

### add（9 重载）

| 签名 | 展开方式 |
|------|---------|
| `add<T, Q>(s: T, m: Mat2x2<T, Q>): Mat2x2<T, Q>` | `Mat2x2(Vec2(s+m.c0.x, s+m.c0.y), Vec2(s+m.c1.x, s+m.c1.y))` |
| `add<T, Q>(s: T, m: Mat2x3<T, Q>): Mat2x3<T, Q>` | `Mat2x3(Vec3(s+m.c0.x, s+m.c0.y, s+m.c0.z), Vec3(s+m.c1.x, s+m.c1.y, s+m.c1.z))` |
| `add<T, Q>(s: T, m: Mat2x4<T, Q>): Mat2x4<T, Q>` | `Mat2x4(Vec4(s+m.c0.x, s+m.c0.y, s+m.c0.z, s+m.c0.w), Vec4(s+m.c1.x, s+m.c1.y, s+m.c1.z, s+m.c1.w))` |
| `add<T, Q>(s: T, m: Mat3x2<T, Q>): Mat3x2<T, Q>` | `Mat3x2(Vec2(s+m.c0.x, s+m.c0.y), Vec2(s+m.c1.x, s+m.c1.y), Vec2(s+m.c2.x, s+m.c2.y))` |
| `add<T, Q>(s: T, m: Mat3x3<T, Q>): Mat3x3<T, Q>` | `Mat3x3(Vec3(s+m.c0.x, s+m.c0.y, s+m.c0.z), Vec3(s+m.c1.x, s+m.c1.y, s+m.c1.z), Vec3(s+m.c2.x, s+m.c2.y, s+m.c2.z))` |
| `add<T, Q>(s: T, m: Mat3x4<T, Q>): Mat3x4<T, Q>` | `Mat3x4(Vec4(s+m.c0.x, s+m.c0.y, s+m.c0.z, s+m.c0.w), Vec4(s+m.c1.x, s+m.c1.y, s+m.c1.z, s+m.c1.w), Vec4(s+m.c2.x, s+m.c2.y, s+m.c2.z, s+m.c2.w))` |
| `add<T, Q>(s: T, m: Mat4x2<T, Q>): Mat4x2<T, Q>` | `Mat4x2(Vec2(s+m.c0.x, s+m.c0.y), Vec2(s+m.c1.x, s+m.c1.y), Vec2(s+m.c2.x, s+m.c2.y), Vec2(s+m.c3.x, s+m.c3.y))` |
| `add<T, Q>(s: T, m: Mat4x3<T, Q>): Mat4x3<T, Q>` | `Mat4x3(Vec3(s+m.c0.x, s+m.c0.y, s+m.c0.z), Vec3(s+m.c1.x, s+m.c1.y, s+m.c1.z), Vec3(s+m.c2.x, s+m.c2.y, s+m.c2.z), Vec3(s+m.c3.x, s+m.c3.y, s+m.c3.z))` |
| `add<T, Q>(s: T, m: Mat4x4<T, Q>): Mat4x4<T, Q>` | `Mat4x4(Vec4(s+m.c0.x, s+m.c0.y, s+m.c0.z, s+m.c0.w), Vec4(s+m.c1.x, s+m.c1.y, s+m.c1.z, s+m.c1.w), Vec4(s+m.c2.x, s+m.c2.y, s+m.c2.z, s+m.c2.w), Vec4(s+m.c3.x, s+m.c3.y, s+m.c3.z, s+m.c3.w))` |

### sub（9 重载）

与 add 同构，运算符替换为 `-`。

| 签名 | 展开方式 |
|------|---------|
| `sub<T, Q>(s: T, m: Mat2x2<T, Q>): Mat2x2<T, Q>` | `Mat2x2(Vec2(s-m.c0.x, s-m.c0.y), Vec2(s-m.c1.x, s-m.c1.y))` |
| `sub<T, Q>(s: T, m: Mat2x3<T, Q>): Mat2x3<T, Q>` | `Mat2x3(Vec3(s-m.c0.x, s-m.c0.y, s-m.c0.z), Vec3(s-m.c1.x, s-m.c1.y, s-m.c1.z))` |
| `sub<T, Q>(s: T, m: Mat2x4<T, Q>): Mat2x4<T, Q>` | `Mat2x4(Vec4(s-m.c0.x, s-m.c0.y, s-m.c0.z, s-m.c0.w), Vec4(s-m.c1.x, s-m.c1.y, s-m.c1.z, s-m.c1.w))` |
| `sub<T, Q>(s: T, m: Mat3x2<T, Q>): Mat3x2<T, Q>` | `Mat3x2(Vec2(s-m.c0.x, s-m.c0.y), Vec2(s-m.c1.x, s-m.c1.y), Vec2(s-m.c2.x, s-m.c2.y))` |
| `sub<T, Q>(s: T, m: Mat3x3<T, Q>): Mat3x3<T, Q>` | `Mat3x3(Vec3(s-m.c0.x, s-m.c0.y, s-m.c0.z), Vec3(s-m.c1.x, s-m.c1.y, s-m.c1.z), Vec3(s-m.c2.x, s-m.c2.y, s-m.c2.z))` |
| `sub<T, Q>(s: T, m: Mat3x4<T, Q>): Mat3x4<T, Q>` | `Mat3x4(Vec4(s-m.c0.x, s-m.c0.y, s-m.c0.z, s-m.c0.w), Vec4(s-m.c1.x, s-m.c1.y, s-m.c1.z, s-m.c1.w), Vec4(s-m.c2.x, s-m.c2.y, s-m.c2.z, s-m.c2.w))` |
| `sub<T, Q>(s: T, m: Mat4x2<T, Q>): Mat4x2<T, Q>` | `Mat4x2(Vec2(s-m.c0.x, s-m.c0.y), Vec2(s-m.c1.x, s-m.c1.y), Vec2(s-m.c2.x, s-m.c2.y), Vec2(s-m.c3.x, s-m.c3.y))` |
| `sub<T, Q>(s: T, m: Mat4x3<T, Q>): Mat4x3<T, Q>` | `Mat4x3(Vec3(s-m.c0.x, s-m.c0.y, s-m.c0.z), Vec3(s-m.c1.x, s-m.c1.y, s-m.c1.z), Vec3(s-m.c2.x, s-m.c2.y, s-m.c2.z), Vec3(s-m.c3.x, s-m.c3.y, s-m.c3.z))` |
| `sub<T, Q>(s: T, m: Mat4x4<T, Q>): Mat4x4<T, Q>` | `Mat4x4(Vec4(s-m.c0.x, s-m.c0.y, s-m.c0.z, s-m.c0.w), Vec4(s-m.c1.x, s-m.c1.y, s-m.c1.z, s-m.c1.w), Vec4(s-m.c2.x, s-m.c2.y, s-m.c2.z, s-m.c2.w), Vec4(s-m.c3.x, s-m.c3.y, s-m.c3.z, s-m.c3.w))` |

### mul（9 重载）

与 add 同构，运算符替换为 `*`。

| 签名 | 展开方式 |
|------|---------|
| `mul<T, Q>(s: T, m: Mat2x2<T, Q>): Mat2x2<T, Q>` | `Mat2x2(Vec2(s*m.c0.x, s*m.c0.y), Vec2(s*m.c1.x, s*m.c1.y))` |
| `mul<T, Q>(s: T, m: Mat2x3<T, Q>): Mat2x3<T, Q>` | `Mat2x3(Vec3(s*m.c0.x, s*m.c0.y, s*m.c0.z), Vec3(s*m.c1.x, s*m.c1.y, s*m.c1.z))` |
| `mul<T, Q>(s: T, m: Mat2x4<T, Q>): Mat2x4<T, Q>` | `Mat2x4(Vec4(s*m.c0.x, s*m.c0.y, s*m.c0.z, s*m.c0.w), Vec4(s*m.c1.x, s*m.c1.y, s*m.c1.z, s*m.c1.w))` |
| `mul<T, Q>(s: T, m: Mat3x2<T, Q>): Mat3x2<T, Q>` | `Mat3x2(Vec2(s*m.c0.x, s*m.c0.y), Vec2(s*m.c1.x, s*m.c1.y), Vec2(s*m.c2.x, s*m.c2.y))` |
| `mul<T, Q>(s: T, m: Mat3x3<T, Q>): Mat3x3<T, Q>` | `Mat3x3(Vec3(s*m.c0.x, s*m.c0.y, s*m.c0.z), Vec3(s*m.c1.x, s*m.c1.y, s*m.c1.z), Vec3(s*m.c2.x, s*m.c2.y, s*m.c2.z))` |
| `mul<T, Q>(s: T, m: Mat3x4<T, Q>): Mat3x4<T, Q>` | `Mat3x4(Vec4(s*m.c0.x, s*m.c0.y, s*m.c0.z, s*m.c0.w), Vec4(s*m.c1.x, s*m.c1.y, s*m.c1.z, s*m.c1.w), Vec4(s*m.c2.x, s*m.c2.y, s*m.c2.z, s*m.c2.w))` |
| `mul<T, Q>(s: T, m: Mat4x2<T, Q>): Mat4x2<T, Q>` | `Mat4x2(Vec2(s*m.c0.x, s*m.c0.y), Vec2(s*m.c1.x, s*m.c1.y), Vec2(s*m.c2.x, s*m.c2.y), Vec2(s*m.c3.x, s*m.c3.y))` |
| `mul<T, Q>(s: T, m: Mat4x3<T, Q>): Mat4x3<T, Q>` | `Mat4x3(Vec3(s*m.c0.x, s*m.c0.y, s*m.c0.z), Vec3(s*m.c1.x, s*m.c1.y, s*m.c1.z), Vec3(s*m.c2.x, s*m.c2.y, s*m.c2.z), Vec3(s*m.c3.x, s*m.c3.y, s*m.c3.z))` |
| `mul<T, Q>(s: T, m: Mat4x4<T, Q>): Mat4x4<T, Q>` | `Mat4x4(Vec4(s*m.c0.x, s*m.c0.y, s*m.c0.z, s*m.c0.w), Vec4(s*m.c1.x, s*m.c1.y, s*m.c1.z, s*m.c1.w), Vec4(s*m.c2.x, s*m.c2.y, s*m.c2.z, s*m.c2.w), Vec4(s*m.c3.x, s*m.c3.y, s*m.c3.z, s*m.c3.w))` |

### div（9 重载）

与 add 同构，运算符替换为 `/`。

| 签名 | 展开方式 |
|------|---------|
| `div<T, Q>(s: T, m: Mat2x2<T, Q>): Mat2x2<T, Q>` | `Mat2x2(Vec2(s/m.c0.x, s/m.c0.y), Vec2(s/m.c1.x, s/m.c1.y))` |
| `div<T, Q>(s: T, m: Mat2x3<T, Q>): Mat2x3<T, Q>` | `Mat2x3(Vec3(s/m.c0.x, s/m.c0.y, s/m.c0.z), Vec3(s/m.c1.x, s/m.c1.y, s/m.c1.z))` |
| `div<T, Q>(s: T, m: Mat2x4<T, Q>): Mat2x4<T, Q>` | `Mat2x4(Vec4(s/m.c0.x, s/m.c0.y, s/m.c0.z, s/m.c0.w), Vec4(s/m.c1.x, s/m.c1.y, s/m.c1.z, s/m.c1.w))` |
| `div<T, Q>(s: T, m: Mat3x2<T, Q>): Mat3x2<T, Q>` | `Mat3x2(Vec2(s/m.c0.x, s/m.c0.y), Vec2(s/m.c1.x, s/m.c1.y), Vec2(s/m.c2.x, s/m.c2.y))` |
| `div<T, Q>(s: T, m: Mat3x3<T, Q>): Mat3x3<T, Q>` | `Mat3x3(Vec3(s/m.c0.x, s/m.c0.y, s/m.c0.z), Vec3(s/m.c1.x, s/m.c1.y, s/m.c1.z), Vec3(s/m.c2.x, s/m.c2.y, s/m.c2.z))` |
| `div<T, Q>(s: T, m: Mat3x4<T, Q>): Mat3x4<T, Q>` | `Mat3x4(Vec4(s/m.c0.x, s/m.c0.y, s/m.c0.z, s/m.c0.w), Vec4(s/m.c1.x, s/m.c1.y, s/m.c1.z, s/m.c1.w), Vec4(s/m.c2.x, s/m.c2.y, s/m.c2.z, s/m.c2.w))` |
| `div<T, Q>(s: T, m: Mat4x2<T, Q>): Mat4x2<T, Q>` | `Mat4x2(Vec2(s/m.c0.x, s/m.c0.y), Vec2(s/m.c1.x, s/m.c1.y), Vec2(s/m.c2.x, s/m.c2.y), Vec2(s/m.c3.x, s/m.c3.y))` |
| `div<T, Q>(s: T, m: Mat4x3<T, Q>): Mat4x3<T, Q>` | `Mat4x3(Vec3(s/m.c0.x, s/m.c0.y, s/m.c0.z), Vec3(s/m.c1.x, s/m.c1.y, s/m.c1.z), Vec3(s/m.c2.x, s/m.c2.y, s/m.c2.z), Vec3(s/m.c3.x, s/m.c3.y, s/m.c3.z))` |
| `div<T, Q>(s: T, m: Mat4x4<T, Q>): Mat4x4<T, Q>` | `Mat4x4(Vec4(s/m.c0.x, s/m.c0.y, s/m.c0.z, s/m.c0.w), Vec4(s/m.c1.x, s/m.c1.y, s/m.c1.z, s/m.c1.w), Vec4(s/m.c2.x, s/m.c2.y, s/m.c2.z, s/m.c2.w), Vec4(s/m.c3.x, s/m.c3.y, s/m.c3.z, s/m.c3.w))` |

## 错误处理

- 仅有算术运算，可能因整数溢出产生截断行为。所有函数标注 `@OverflowWrapping`（与 scalar_vec_ops.cj 一致）
- 整数除零在仓颉中引发运行时异常，属类型系统默认行为，无需额外处理

## 行为契约

- 所有函数为纯函数，不修改输入参数，返回新矩阵
- 运算逐分量应用标量到每个矩阵元素：`result[j][i] = s op m[j][i]`
- 结果类型与输入矩阵类型完全一致

## 依赖关系

| 依赖类型 | 依赖说明 |
|---------|---------|
| std.math.{ Number } | 泛型约束 `T <: Number<T>` |
| Mat2x2<T,Q> ~ Mat4x4<T,Q> | 所有 36 个函数的参数和返回类型 |
| Vec2<T,Q> ~ Vec4<T,Q> | 矩阵的列向量成员类型，用于构造返回值 |

不依赖同包任何其他 detail 文件（仅依赖矩阵类型结构体）。不依赖 common.cj、geometric.cj、matrix.cj 等文件。

## 测试设计

### test_scalar_mat_ops.cj（new file, package glm.detail）

| 类别 | 测试项 | 覆盖函数 | 验证方式 |
|------|--------|---------|---------|
| add Int64 | Mat2x2, Mat3x3, Mat4x4 三个尺寸 | `add(s, Mat2x2)`, `add(s, Mat3x3)`, `add(s, Mat4x4)` | 构造已知值矩阵，验证 `s + m[i][j]` 逐分量正确 |
| sub Int64 | Mat2x2, Mat3x3, Mat4x4 三个尺寸 | `sub(s, Mat2x2)`, `sub(s, Mat3x3)`, `sub(s, Mat4x4)` | 同上，验证 `s - m[i][j]` |
| mul Int64 | Mat2x2, Mat3x3, Mat4x4 三个尺寸 | `mul(s, Mat2x2)`, `mul(s, Mat3x3)`, `mul(s, Mat4x4)` | 同上，验证 `s * m[i][j]` |
| div Int64 | Mat2x2, Mat3x3, Mat4x4 三个尺寸 | `div(s, Mat2x2)`, `div(s, Mat3x3)`, `div(s, Mat4x4)` | 同上，验证 `s / m[i][j]` 整数截断 |
| div Float32 | Mat2x2 | `div(s, Mat2x2)` with Float32 | 验证浮点逐元素除法 |
| div Float64 | Mat2x2 | `div(s, Mat2x2)` with Float64 | 验证浮点逐元素除法 |
| div Int32 truncation | Mat2x2 | `div(s, Mat2x2)` with Int32 | 验证整数除法截断行为 |
| 与 scalar_vec_ops 一致性 | 任选一种 | `div(s, m)[0][0]` vs `div(s, v)[0]` 当 `m[0][0] == v[0]` | 矩阵分量与向量分量结果一致 |

具体测试维度：
- **add/sub/mul/div Int64**：构造 3 个代表性矩阵尺寸（Mat2x2、Mat3x3、Mat4x4），使用 Int64 精确算术，验证每个分量计算结果正确
- **div Float32/Float64**：使用 Mat2x2，构造浮点矩阵，验证逐元素除法结果
- **div Int32 truncation**：使用 Mat2x2 和 Int32，构造使除法产生非整数结果的值，验证结果截断向零
- **与 scalar_vec_ops 一致性**：取 `Mat2x2` 的 `(0,0)` 分量等于 `Vec1` 的 `x` 分量，验证 `div(s, m).c0.x == div(s, v).x`
- 测试元素类型统一使用 `Int64, Defaultp`（特殊标注除外）

## 文件头规范

```cangjie
package glm.detail

import std.math.{ Number }

@OverflowWrapping
public func add<T, Q>(s: T, m: Mat2x2<T, Q>): Mat2x2<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat2x2(Vec2(s + m.c0.x, s + m.c0.y), Vec2(s + m.c1.x, s + m.c1.y))
}
...
```

## 测试文件头规范

```cangjie
package glm.detail

import std.unittest.*
import std.unittest.testmacro.*
```
