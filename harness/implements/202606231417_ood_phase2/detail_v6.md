# 详细设计（v6）

## 概述

创建 `src/detail/matrix.cj`（package glm.detail），实现 33 个函数的混合型文件——27 个可直接实现的重载（transpose×9、matrixCompMult×9、outerProduct×9）和 6 个 stub 重载（determinant×3、inverse×3）。同步创建测试文件 `tests/glm/detail/test_matrix.cj`。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| src/detail/matrix.cj | 新建 | 27 个可直接实现重载 + 6 个 stub 重载 |
| tests/glm/detail/test_matrix.cj | 新建 | 覆盖全部 27 个非 stub 函数的编译和执行验证 |

## 类型定义

本文件不定义新类型，仅提供顶层函数。所有数据类型已在同包 type_matNxN.cj 和 type_vecN.cj 中定义。

### 依赖的已有类型

| 类型 | 包路径 | 用途 |
|------|--------|------|
| Mat2x2<T,Q> ~ Mat4x4<T,Q> | glm.detail | transpose/matrixCompMult 参数和返回；outerProduct 返回 |
| Vec2<T,Q> ~ Vec4<T,Q> | glm.detail | outerProduct 参数（列向量和行向量） |
| Qualifier | glm.detail | 泛型约束 |
| Number<T> | std.math | matrixCompMult/outerProduct/determinant/inverse 的泛型约束 |
| Exception | std | stub 函数体 |

## 函数清单

### transpose（9 重载，`where Q <: Qualifier`）

| 签名 | 转置映射 | 展开方式 |
|------|---------|---------|
| `public func transpose<T, Q>(m: Mat2x2<T, Q>): Mat2x2<T, Q> where Q <: Qualifier` | 2×2→2×2 | `Mat2x2(Vec2(m.c0.x,m.c1.x), Vec2(m.c0.y,m.c1.y))` |
| `public func transpose<T, Q>(m: Mat2x3<T, Q>): Mat3x2<T, Q> where Q <: Qualifier` | 2×3→3×2 | `Mat3x2(Vec2(m.c0.x,m.c1.x), Vec2(m.c0.y,m.c1.y), Vec2(m.c0.z,m.c1.z))` |
| `public func transpose<T, Q>(m: Mat2x4<T, Q>): Mat4x2<T, Q> where Q <: Qualifier` | 2×4→4×2 | `Mat4x2(Vec2(m.c0.x,m.c1.x), Vec2(m.c0.y,m.c1.y), Vec2(m.c0.z,m.c1.z), Vec2(m.c0.w,m.c1.w))` |
| `public func transpose<T, Q>(m: Mat3x2<T, Q>): Mat2x3<T, Q> where Q <: Qualifier` | 3×2→2×3 | `Mat2x3(Vec3(m.c0.x,m.c1.x,m.c2.x), Vec3(m.c0.y,m.c1.y,m.c2.y))` |
| `public func transpose<T, Q>(m: Mat3x3<T, Q>): Mat3x3<T, Q> where Q <: Qualifier` | 3×3→3×3 | `Mat3x3(Vec3(m.c0.x,m.c1.x,m.c2.x), Vec3(m.c0.y,m.c1.y,m.c2.y), Vec3(m.c0.z,m.c1.z,m.c2.z))` |
| `public func transpose<T, Q>(m: Mat3x4<T, Q>): Mat4x3<T, Q> where Q <: Qualifier` | 3×4→4×3 | `Mat4x3(Vec3(m.c0.x,m.c1.x,m.c2.x), Vec3(m.c0.y,m.c1.y,m.c2.y), Vec3(m.c0.z,m.c1.z,m.c2.z), Vec3(m.c0.w,m.c1.w,m.c2.w))` |
| `public func transpose<T, Q>(m: Mat4x2<T, Q>): Mat2x4<T, Q> where Q <: Qualifier` | 4×2→2×4 | `Mat2x4(Vec4(m.c0.x,m.c1.x,m.c2.x,m.c3.x), Vec4(m.c0.y,m.c1.y,m.c2.y,m.c3.y))` |
| `public func transpose<T, Q>(m: Mat4x3<T, Q>): Mat3x4<T, Q> where Q <: Qualifier` | 4×3→3×4 | `Mat3x4(Vec4(m.c0.x,m.c1.x,m.c2.x,m.c3.x), Vec4(m.c0.y,m.c1.y,m.c2.y,m.c3.y), Vec4(m.c0.z,m.c1.z,m.c2.z,m.c3.z))` |
| `public func transpose<T, Q>(m: Mat4x4<T, Q>): Mat4x4<T, Q> where Q <: Qualifier` | 4×4→4×4 | `Mat4x4(Vec4(m.c0.x,m.c1.x,m.c2.x,m.c3.x), Vec4(m.c0.y,m.c1.y,m.c2.y,m.c3.y), Vec4(m.c0.z,m.c1.z,m.c2.z,m.c3.z), Vec4(m.c0.w,m.c1.w,m.c2.w,m.c3.w))` |

通用规则：`src.c_i[j]`（第 i 列第 j 行）→ `dst.c_j[i]`（第 j 列第 i 行）。结果矩阵的列向量由源矩阵对应行的列向量元素收集而成，使用 `.x/.y/.z/.w` 属性访问。

### matrixCompMult（9 重载，`where T <: Number<T>, Q <: Qualifier`）

| 签名 | 展开方式 |
|------|---------|
| `public func matrixCompMult<T, Q>(x: Mat2x2<T, Q>, y: Mat2x2<T, Q>): Mat2x2<T, Q> where T <: Number<T>, Q <: Qualifier` | 逐分量乘：`Mat2x2(Vec2(x.c0.x*y.c0.x, x.c0.y*y.c0.y), Vec2(x.c1.x*y.c1.x, x.c1.y*y.c1.y))` |
| `public func matrixCompMult<T, Q>(x: Mat2x3<T, Q>, y: Mat2x3<T, Q>): Mat2x3<T, Q> where T <: Number<T>, Q <: Qualifier` | 同上模式，6 分量 |
| `public func matrixCompMult<T, Q>(x: Mat2x4<T, Q>, y: Mat2x4<T, Q>): Mat2x4<T, Q> where T <: Number<T>, Q <: Qualifier` | 同上模式，8 分量 |
| `public func matrixCompMult<T, Q>(x: Mat3x2<T, Q>, y: Mat3x2<T, Q>): Mat3x2<T, Q> where T <: Number<T>, Q <: Qualifier` | 同上模式，6 分量 |
| `public func matrixCompMult<T, Q>(x: Mat3x3<T, Q>, y: Mat3x3<T, Q>): Mat3x3<T, Q> where T <: Number<T>, Q <: Qualifier` | 同上模式，9 分量 |
| `public func matrixCompMult<T, Q>(x: Mat3x4<T, Q>, y: Mat3x4<T, Q>): Mat3x4<T, Q> where T <: Number<T>, Q <: Qualifier` | 同上模式，12 分量 |
| `public func matrixCompMult<T, Q>(x: Mat4x2<T, Q>, y: Mat4x2<T, Q>): Mat4x2<T, Q> where T <: Number<T>, Q <: Qualifier` | 同上模式，8 分量 |
| `public func matrixCompMult<T, Q>(x: Mat4x3<T, Q>, y: Mat4x3<T, Q>): Mat4x3<T, Q> where T <: Number<T>, Q <: Qualifier` | 同上模式，12 分量 |
| `public func matrixCompMult<T, Q>(x: Mat4x4<T, Q>, y: Mat4x4<T, Q>): Mat4x4<T, Q> where T <: Number<T>, Q <: Qualifier` | 同上模式，16 分量 |

通用规则：`dst.c_j[i] = x.c_j[i] * y.c_j[i]`，每列逐分量乘法，按属性访问展开。

### outerProduct（9 重载，`where T <: Number<T>, Q <: Qualifier`）

| 签名 | 结果尺寸 | 展开说明 |
|------|---------|---------|
| `public func outerProduct<T, Q>(c: Vec2<T, Q>, r: Vec2<T, Q>): Mat2x2<T, Q> where T <: Number<T>, Q <: Qualifier` | 2×2 | `M[j][i] = c[i] * r[j]` |
| `public func outerProduct<T, Q>(c: Vec2<T, Q>, r: Vec3<T, Q>): Mat3x2<T, Q> where T <: Number<T>, Q <: Qualifier` | 3×2 | 同上公式 |
| `public func outerProduct<T, Q>(c: Vec2<T, Q>, r: Vec4<T, Q>): Mat4x2<T, Q> where T <: Number<T>, Q <: Qualifier` | 4×2 | 同上公式 |
| `public func outerProduct<T, Q>(c: Vec3<T, Q>, r: Vec2<T, Q>): Mat2x3<T, Q> where T <: Number<T>, Q <: Qualifier` | 2×3 | 同上公式 |
| `public func outerProduct<T, Q>(c: Vec3<T, Q>, r: Vec3<T, Q>): Mat3x3<T, Q> where T <: Number<T>, Q <: Qualifier` | 3×3 | 同上公式 |
| `public func outerProduct<T, Q>(c: Vec3<T, Q>, r: Vec4<T, Q>): Mat4x3<T, Q> where T <: Number<T>, Q <: Qualifier` | 4×3 | 同上公式 |
| `public func outerProduct<T, Q>(c: Vec4<T, Q>, r: Vec2<T, Q>): Mat2x4<T, Q> where T <: Number<T>, Q <: Qualifier` | 2×4 | 同上公式 |
| `public func outerProduct<T, Q>(c: Vec4<T, Q>, r: Vec3<T, Q>): Mat3x4<T, Q> where T <: Number<T>, Q <: Qualifier` | 3×4 | 同上公式 |
| `public func outerProduct<T, Q>(c: Vec4<T, Q>, r: Vec4<T, Q>): Mat4x4<T, Q> where T <: Number<T>, Q <: Qualifier` | 4×4 | 同上公式 |

公式：`result[j][i] = c[i] * r[j]`（i 行索引 ∈ [0, R-1]，j 列索引 ∈ [0, C-1]），其中 R = len(c)，C = len(r)。结果矩阵的元素为列向量分量与行向量分量的逐对乘积。

以 `outerProduct(c: Vec3, r: Vec2) → Mat2x3` 为例：
```
Mat2x3<T, Q>(
  Vec3<T, Q>(c.x * r.x, c.y * r.x, c.z * r.x),   // 列 0：c 每个分量 × r.x
  Vec3<T, Q>(c.x * r.y, c.y * r.y, c.z * r.y))   // 列 1：c 每个分量 × r.y
```

### determinant（3 重载，stub）

| 签名 | 函数体 |
|------|--------|
| `public func determinant<T, Q>(m: Mat2x2<T, Q>): T where T <: Number<T>, Q <: Qualifier` | `throw Exception("stub")` |
| `public func determinant<T, Q>(m: Mat3x3<T, Q>): T where T <: Number<T>, Q <: Qualifier` | `throw Exception("stub")` |
| `public func determinant<T, Q>(m: Mat4x4<T, Q>): T where T <: Number<T>, Q <: Qualifier` | `throw Exception("stub")` |

### inverse（3 重载，stub）

| 签名 | 函数体 |
|------|--------|
| `public func inverse<T, Q>(m: Mat2x2<T, Q>): Mat2x2<T, Q> where T <: Number<T>, Q <: Qualifier` | `throw Exception("stub")` |
| `public func inverse<T, Q>(m: Mat3x3<T, Q>): Mat3x3<T, Q> where T <: Number<T>, Q <: Qualifier` | `throw Exception("stub")` |
| `public func inverse<T, Q>(m: Mat4x4<T, Q>): Mat4x4<T, Q> where T <: Number<T>, Q <: Qualifier` | `throw Exception("stub")` |

## 代码生成展开模板

### transpose 展开模式

通用模式：`src[i][j] → dst[j][i]`。对每个矩阵尺寸版本，结果列向量 = VecN(源矩阵各列的第 i 行元素收集)。

示例（Mat3x2→Mat2x3）：
```cangjie
public func transpose<T, Q>(m: Mat3x2<T, Q>): Mat2x3<T, Q> where Q <: Qualifier {
    Mat2x3<T, Q>(Vec3<T, Q>(m.c0.x, m.c1.x, m.c2.x),  // 源第 0 行 → 目标列 0
                 Vec3<T, Q>(m.c0.y, m.c1.y, m.c2.y))   // 源第 1 行 → 目标列 1
}
```

### matrixCompMult 展开模式

每列逐分量乘，Vec 构造器中对应分量相乘。

示例（Mat2x2）：
```cangjie
public func matrixCompMult<T, Q>(x: Mat2x2<T, Q>, y: Mat2x2<T, Q>): Mat2x2<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat2x2<T, Q>(Vec2<T, Q>(x.c0.x * y.c0.x, x.c0.y * y.c0.y),
                 Vec2<T, Q>(x.c1.x * y.c1.x, x.c1.y * y.c1.y))
}
```

### outerProduct 展开模式

每列 = 列向量 c 的分量逐个乘以 r 的对应分量。

示例（Vec3×Vec2→Mat2x3）：
```cangjie
public func outerProduct<T, Q>(c: Vec3<T, Q>, r: Vec2<T, Q>): Mat2x3<T, Q>
    where T <: Number<T>, Q <: Qualifier {
    Mat2x3<T, Q>(Vec3<T, Q>(c.x * r.x, c.y * r.x, c.z * r.x),
                 Vec3<T, Q>(c.x * r.y, c.y * r.y, c.z * r.y))
}
```

## 错误处理

- 27 个非 stub 函数：仅有算术运算，可能因类型系统约束导致整数溢出（标注 `@OverflowWrapping` 在各函数体运算中；但 matrix.cj 为顶层函数，无法标注属性——函数体内 `*` 运算在 `Number<T>` 约束下默认行为；若编译器要求，可在函数体内使用 `OverflowWrapping.wrappingMul` 等。暂按默认算术运算实现，编译器无强制要求时不做显式包装）
- 6 个 stub 函数：`throw Exception("stub")`

## 行为契约

- transpose：仅索引重排，不修改输入，返回新矩阵
- matrixCompMult：逐元素乘，输入矩阵尺寸必须相同
- outerProduct：列向量×行向量外积，结果矩阵尺寸 = len(c) 行 × len(r) 列
- determinant/inverse：stub 状态，任何调用抛出 Exception("stub")

## 依赖关系

| 依赖类型 | 依赖说明 |
|---------|---------|
| Mat2x2<T,Q> ~ Mat4x4<T,Q> | 所有 33 个函数的参数和返回类型 |
| Vec2<T,Q> ~ Vec4<T,Q> | outerProduct 的参数类型 |
| Number<T> | matrixCompMult/outerProduct/determinant/inverse 的泛型约束 |
| Qualifier | 所有 33 个函数的泛型约束 |
| Exception | stub 函数体抛出异常 |

不依赖 common.cj、geometric.cj 等 stub 文件。

## 测试设计

### test_matrix.cj（new file, package glm.detail）

| 类别 | 测试项 | 覆盖函数 | 验证方式 |
|------|--------|---------|---------|
| transpose 2×2 | 非对称矩阵转置→转置恢复 | `transpose(Mat2x2)` | 构造 2×2 矩阵，转置后验证分量交换，再次转置恢复原始值 |
| transpose 2×3 | 2×3→3×2 转置 | `transpose(Mat2x3)` | 构造非平凡 2×3 矩阵，验证尺寸变换和元素重排 |
| transpose 2×4 | 2×4→4×2 转置 | `transpose(Mat2x4)` | 同上 |
| transpose 3×2 | 3×2→2×3 转置 | `transpose(Mat3x2)` | 同上 |
| transpose 3×3 | 方阵转置对称验证 | `transpose(Mat3x3)` | 转置后对角线对称验证 |
| transpose 3×4 | 3×4→4×3 转置 | `transpose(Mat3x4)` | 同上 |
| transpose 4×2 | 4×2→2×4 转置 | `transpose(Mat4x2)` | 同上 |
| transpose 4×3 | 4×3→3×4 转置 | `transpose(Mat4x3)` | 同上 |
| transpose 4×4 | 方阵转置双重验证 | `transpose(Mat4x4)` | `transpose(transpose(m)) == m` |
| matrixCompMult 2×2 | 逐元素乘精确值 | `matrixCompMult(Mat2x2, Mat2x2)` | 构造已知值矩阵验证各分量乘积正确 |
| matrixCompMult 2×3 | 代表性尺寸 | `matrixCompMult(Mat2x3, Mat2x3)` | 同上 |
| matrixCompMult 4×4 | 最大尺寸 | `matrixCompMult(Mat4x4, Mat4x4)` | 同上 |
| outerProduct Vec2×Vec2 | 2×2 外积 | `outerProduct(Vec2, Vec2)` | 构造 c=(a,b), r=(c,d)，验证 M=[[a*c,a*d],[b*c,b*d]] |
| outerProduct Vec3×Vec2 | 2×3 外积 | `outerProduct(Vec3, Vec2)` | 同上公式 |
| outerProduct Vec4×Vec4 | 4×4 外积 | `outerProduct(Vec4, Vec4)` | 同上公式 |
| determinant 2×2 stub | 调用抛异常 | `determinant(Mat2x2)` | `@ExpectThrows[Exception]` |
| determinant 3×3 stub | 调用抛异常 | `determinant(Mat3x3)` | `@ExpectThrows[Exception]` |
| determinant 4×4 stub | 调用抛异常 | `determinant(Mat4x4)` | `@ExpectThrows[Exception]` |
| inverse 2×2 stub | 调用抛异常 | `inverse(Mat2x2)` | `@ExpectThrows[Exception]` |
| inverse 3×3 stub | 调用抛异常 | `inverse(Mat3x3)` | `@ExpectThrows[Exception]` |
| inverse 4×4 stub | 调用抛异常 | `inverse(Mat4x4)` | `@ExpectThrows[Exception]` |

具体测试维度：
- **transpose**：9 个尺寸各选择 1~2 个非平凡矩阵验证。对非方阵，构造源矩阵使每列各分量不同，验证转置后元素按行/列正确交换。方阵验证双重转置恢复恒等性
- **matrixCompMult**：选择 2~3 个代表性尺寸（Mat2x2、非方阵如 Mat2x3、Mat4x4），使用 Int64 类型（精确算术避免浮点误差），逐分量验证乘积正确
- **outerProduct**：选择 2~3 个维度组合，使用 Int64 类型，构造非平凡列向量和行向量，验证结果矩阵每列为 (c * r_j) 的列向量
- **determinant/inverse**：各选择 3 个方阵尺寸，使用 `@ExpectThrows[Exception]` 验证抛异常
- 测试元素类型统一使用 `Int64, Defaultp`（精确算术，避免浮点误差）

## 文件头规范

```cangjie
package glm.detail
```

matrix.cj 无需 import 语句（同包所有类型直接可见，std.Exception 无需显式 import？——需确认：`Exception` 在仓颉标准库中通常通过 `std` 包导入）。参考 common.cj 和 geometric.cj 的模式：common.cj 有 `import std.math.{ Number, Integer }`，geometric.cj 有 `import std.math.{ Number }`。Exception 在 common.cj/geometric.cj 中未显式 import（直接使用），说明 `Exception` 在 `std` 包中默认可见或无需额外 import。

## 测试文件头规范

```cangjie
package glm.detail

import std.unittest.*
import std.unittest.testmacro.*
```
