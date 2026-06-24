# 详细设计（v8）

## 概述

在 type_vec2.cj、type_vec3.cj、type_vec4.cj 每个文件末尾追加一个 extend 块，实现行向量×矩阵乘法成员运算符（operator `*`）。同步创建测试文件 `tests/glm/detail/test_vec_mat_mul.cj`。

共 9 个重载（Vec2×3 + Vec3×3 + Vec4×3），每个重载标注 `@OverflowWrapping`，在 `Number<T>` 约束下实现。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| src/detail/type_vec2.cj | 修改 | 末尾追加 Vec2 extend 块（3 个 operator `*` 重载） |
| src/detail/type_vec3.cj | 修改 | 末尾追加 Vec3 extend 块（3 个 operator `*` 重载） |
| src/detail/type_vec4.cj | 修改 | 末尾追加 Vec4 extend 块（3 个 operator `*` 重载） |
| tests/glm/detail/test_vec_mat_mul.cj | 新建 | 9 个重载各至少 1 个测试用例 |

## 类型定义

本设计不定义新类型，仅向已有 Vec2/3/4 类型追加 extend 块。

### 依赖的已有类型

| 类型 | 包路径 | 用途 |
|------|--------|------|
| Vec2<T,Q>, Vec3<T,Q>, Vec4<T,Q> | glm.detail | 操作符所在的类型 |
| Mat2x2<T,Q> ~ Mat4x4<T,Q> | glm.detail | 乘法操作数矩阵类型 |
| Qualifier | glm.detail | 泛型约束 |
| Number<T> | std.math | 泛型算术约束 |

## extend 块设计

### Vec2 extend 块（追加至 type_vec2.cj 末尾）

```cangjie
extend<T, Q> Vec2<T, Q> where T <: Number<T>, Q <: Qualifier {
    @OverflowWrapping
    public operator func *(m: Mat2x2<T, Q>): Vec2<T, Q> {
        Vec2(this.x * m.c0.x + this.y * m.c0.y, this.x * m.c1.x + this.y * m.c1.y)
    }

    @OverflowWrapping
    public operator func *(m: Mat3x2<T, Q>): Vec3<T, Q> {
        Vec3(
            this.x * m.c0.x + this.y * m.c0.y,
            this.x * m.c1.x + this.y * m.c1.y,
            this.x * m.c2.x + this.y * m.c2.y)
    }

    @OverflowWrapping
    public operator func *(m: Mat4x2<T, Q>): Vec4<T, Q> {
        Vec4(
            this.x * m.c0.x + this.y * m.c0.y,
            this.x * m.c1.x + this.y * m.c1.y,
            this.x * m.c2.x + this.y * m.c2.y,
            this.x * m.c3.x + this.y * m.c3.y)
    }
}
```

### Vec3 extend 块（追加至 type_vec3.cj 末尾）

```cangjie
extend<T, Q> Vec3<T, Q> where T <: Number<T>, Q <: Qualifier {
    @OverflowWrapping
    public operator func *(m: Mat2x3<T, Q>): Vec2<T, Q> {
        Vec2(
            this.x * m.c0.x + this.y * m.c0.y + this.z * m.c0.z,
            this.x * m.c1.x + this.y * m.c1.y + this.z * m.c1.z)
    }

    @OverflowWrapping
    public operator func *(m: Mat3x3<T, Q>): Vec3<T, Q> {
        Vec3(
            this.x * m.c0.x + this.y * m.c0.y + this.z * m.c0.z,
            this.x * m.c1.x + this.y * m.c1.y + this.z * m.c1.z,
            this.x * m.c2.x + this.y * m.c2.y + this.z * m.c2.z)
    }

    @OverflowWrapping
    public operator func *(m: Mat4x3<T, Q>): Vec4<T, Q> {
        Vec4(
            this.x * m.c0.x + this.y * m.c0.y + this.z * m.c0.z,
            this.x * m.c1.x + this.y * m.c1.y + this.z * m.c1.z,
            this.x * m.c2.x + this.y * m.c2.y + this.z * m.c2.z,
            this.x * m.c3.x + this.y * m.c3.y + this.z * m.c3.z)
    }
}
```

### Vec4 extend 块（追加至 type_vec4.cj 末尾）

```cangjie
extend<T, Q> Vec4<T, Q> where T <: Number<T>, Q <: Qualifier {
    @OverflowWrapping
    public operator func *(m: Mat2x4<T, Q>): Vec2<T, Q> {
        Vec2(
            this.x * m.c0.x + this.y * m.c0.y + this.z * m.c0.z + this.w * m.c0.w,
            this.x * m.c1.x + this.y * m.c1.y + this.z * m.c1.z + this.w * m.c1.w)
    }

    @OverflowWrapping
    public operator func *(m: Mat3x4<T, Q>): Vec3<T, Q> {
        Vec3(
            this.x * m.c0.x + this.y * m.c0.y + this.z * m.c0.z + this.w * m.c0.w,
            this.x * m.c1.x + this.y * m.c1.y + this.z * m.c1.z + this.w * m.c1.w,
            this.x * m.c2.x + this.y * m.c2.y + this.z * m.c2.z + this.w * m.c2.w)
    }

    @OverflowWrapping
    public operator func *(m: Mat4x4<T, Q>): Vec4<T, Q> {
        Vec4(
            this.x * m.c0.x + this.y * m.c0.y + this.z * m.c0.z + this.w * m.c0.w,
            this.x * m.c1.x + this.y * m.c1.y + this.z * m.c1.z + this.w * m.c1.w,
            this.x * m.c2.x + this.y * m.c2.y + this.z * m.c2.z + this.w * m.c2.w,
            this.x * m.c3.x + this.y * m.c3.y + this.z * m.c3.z + this.w * m.c3.w)
    }
}
```

## 乘法语义

行向量 × 矩阵：`result[j] = sum over i of (this[i] * m.c_j[i])`

- Vec{N} × Mat{C}x{N}: 结果维度为 C（列数），每个分量 j 是行向量与第 j 列的列向量点积
- 属性访问使用 `.x/.y/.z/.w` 而非下标 `[]`，与已有代码风格一致

## 错误处理

- 整数算术溢出标注 `@OverflowWrapping`，与现有 extend 块一致
- 不产生新的错误类型，不抛出异常

## 行为契约

- 所有操作符为纯函数，不修改 this，返回新向量
- 操作符不改变 this 或矩阵参数

## 依赖关系

- 每个 extend 块仅依赖 `std.math.Number`（已有导入）和同包的矩阵类型
- Vec2 extend 依赖 Mat2x2、Mat3x2、Mat4x2
- Vec3 extend 依赖 Mat2x3、Mat3x3、Mat4x3
- Vec4 extend 依赖 Mat2x4、Mat3x4、Mat4x4
- 所有 9 个矩阵类型已在同包中完整实现
- 不依赖 common.cj、geometric.cj、matrix.cj 等文件

## 测试设计

### test_vec_mat_mul.cj（new file, package glm.detail）

覆盖全部 9 个重载，每个至少 1 个用例（Int64、Defaultp），构造已知向量和矩阵，手动计算结果并验证。

| 序号 | 用例函数 | 测试方向 | 向量值 | 矩阵值 | 期望结果 |
|------|---------|---------|--------|--------|---------|
| 1 | testVec2MulMat2x2 | Vec2 × Mat2x2 | (2,3) | c0(5,7),c1(9,11) | (2*5+3*7=31, 2*9+3*11=51) |
| 2 | testVec2MulMat3x2 | Vec2 × Mat3x2 | (2,3) | c0(5,7),c1(9,11),c2(13,17) | (31, 51, 2*13+3*17=77) |
| 3 | testVec2MulMat4x2 | Vec2 × Mat4x2 | (1,2) | c0(3,5),c1(7,9),c2(11,13),c3(15,17) | (13,25,37,49) |
| 4 | testVec3MulMat2x3 | Vec3 × Mat2x3 | (1,2,3) | c0(4,5,6),c1(7,8,9) | (32,50) |
| 5 | testVec3MulMat3x3 | Vec3 × Mat3x3 | (1,2,3) | c0(4,5,6),c1(7,8,9),c2(10,11,12) | (32,50,68) |
| 6 | testVec3MulMat4x3 | Vec3 × Mat4x3 | (1,2,3) | c0(4,5,6),c1(7,8,9),c2(10,11,12),c3(13,14,15) | (32,50,68,86) |
| 7 | testVec4MulMat2x4 | Vec4 × Mat2x4 | (1,2,3,4) | c0(5,6,7,8),c1(9,10,11,12) | (70,110) |
| 8 | testVec4MulMat3x4 | Vec4 × Mat3x4 | (1,2,3,4) | c0(5,6,7,8),c1(9,10,11,12),c2(13,14,15,16) | (70,110,150) |
| 9 | testVec4MulMat4x4 | Vec4 × Mat4x4 | (1,2,3,4) | c0(5,6,7,8),c1(9,10,11,12),c2(13,14,15,16),c3(17,18,19,20) | (70,110,150,190) |

测试矩阵构造使用 `Mat{C}x{R}(a00, a01, ..., a{C-1}{R-1})` 行列优先构造器。

测试文件头模式与已有测试文件一致：
```cangjie
package glm.detail

import std.unittest.*
import std.unittest.testmacro.*
```

## 文件修改说明

每个 vec 文件只追加一个 extend 块到文件末尾（在最后一个已有 extend 块之后），不修改任何已有代码。
