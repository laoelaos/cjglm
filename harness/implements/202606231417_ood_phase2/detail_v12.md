# 详细设计（v12）

## 概述

为 9 个矩阵类型文件（`type_mat2x2.cj` ~ `type_mat4x4.cj`）各追加两个 extend 块，实现矩阵比较运算符（==/!=/equalExact/equalEpsilon）。同步创建测试文件 `test_type_mat_compare.cj`。

## 文件规划

| 文件路径 | 操作 | 职责 |
|---------|------|------|
| src/detail/type_mat2x2.cj | 修改 | 追加两个 extend 块：Equatable 约束下的 ==/!=/equalExact，Number&Equatable&Comparable 约束下的 equalEpsilon |
| src/detail/type_mat2x3.cj | 修改 | 同上 |
| src/detail/type_mat2x4.cj | 修改 | 同上 |
| src/detail/type_mat3x2.cj | 修改 | 同上 |
| src/detail/type_mat3x3.cj | 修改 | 同上 |
| src/detail/type_mat3x4.cj | 修改 | 同上 |
| src/detail/type_mat4x2.cj | 修改 | 同上 |
| src/detail/type_mat4x3.cj | 修改 | 同上 |
| src/detail/type_mat4x4.cj | 修改 | 同上 |
| tests/glm/detail/test_type_mat_compare.cj | 新建 | 覆盖所有 9 种矩阵类型的比较运算符测试 |

## 类型定义

### extend 块 1：Equatable 比较

**形态**：extend
**包路径**：glm.detail
**职责**：为 Mat{C}x{R}<T,Q> 提供 ==/!=/equalExact 运算符，当 T 满足 Equatable<T> 约束时可用。

```cangjie
extend<T, Q> Mat{C}x{R}<T, Q> where T <: Equatable<T>, Q <: Qualifier {
    public operator func ==(rhs: Mat{C}x{R}<T, Q>): Bool
    public operator func !=(rhs: Mat{C}x{R}<T, Q>): Bool
    public func equalExact(other: Mat{C}x{R}<T, Q>): Bool
}
```

**实现方式**：
- `==`：逐分量比较（列主序遍历所有列的所有分量），委托 `ComputeEqual<T>.call(a, b)`，各分量结果用 `&&` 连接
- `!=`：`!(this == rhs)`
- `equalExact`：与 `==` 语义等价，逐分量委托 `ComputeEqual<T>.call(a, b)`，各分量结果用 `&&` 连接

**分量序列（列主序）**：
- Mat2x2: `this.c0.x, rhs.c0.x`, `this.c0.y, rhs.c0.y`, `this.c1.x, rhs.c1.x`, `this.c1.y, rhs.c1.y`
- Mat2x3: `this.c0.x, rhs.c0.x`, `this.c0.y, rhs.c0.y`, `this.c0.z, rhs.c0.z`, `this.c1.x, rhs.c1.x`, `this.c1.y, rhs.c1.y`, `this.c1.z, rhs.c1.z`
- Mat2x4: `this.c0.x, rhs.c0.x`, `this.c0.y, rhs.c0.y`, `this.c0.z, rhs.c0.z`, `this.c0.w, rhs.c0.w`, `this.c1.x, rhs.c1.x`, `this.c1.y, rhs.c1.y`, `this.c1.z, rhs.c1.z`, `this.c1.w, rhs.c1.w`
- Mat3x2: `this.c0.x, rhs.c0.x`, `this.c0.y, rhs.c0.y`, `this.c1.x, rhs.c1.x`, `this.c1.y, rhs.c1.y`, `this.c2.x, rhs.c2.x`, `this.c2.y, rhs.c2.y`
- Mat3x3: `this.c0.x, rhs.c0.x`, `this.c0.y, rhs.c0.y`, `this.c0.z, rhs.c0.z`, `this.c1.x, rhs.c1.x`, `this.c1.y, rhs.c1.y`, `this.c1.z, rhs.c1.z`, `this.c2.x, rhs.c2.x`, `this.c2.y, rhs.c2.y`, `this.c2.z, rhs.c2.z`
- Mat3x4: `this.c0.x, rhs.c0.x`, `this.c0.y, rhs.c0.y`, `this.c0.z, rhs.c0.z`, `this.c0.w, rhs.c0.w`, `this.c1.x, rhs.c1.x`, `this.c1.y, rhs.c1.y`, `this.c1.z, rhs.c1.z`, `this.c1.w, rhs.c1.w`, `this.c2.x, rhs.c2.x`, `this.c2.y, rhs.c2.y`, `this.c2.z, rhs.c2.z`, `this.c2.w, rhs.c2.w`
- Mat4x2: `this.c0.x, rhs.c0.x`, `this.c0.y, rhs.c0.y`, `this.c1.x, rhs.c1.x`, `this.c1.y, rhs.c1.y`, `this.c2.x, rhs.c2.x`, `this.c2.y, rhs.c2.y`, `this.c3.x, rhs.c3.x`, `this.c3.y, rhs.c3.y`
- Mat4x3: `this.c0.x, rhs.c0.x`, `this.c0.y, rhs.c0.y`, `this.c0.z, rhs.c0.z`, `this.c1.x, rhs.c1.x`, `this.c1.y, rhs.c1.y`, `this.c1.z, rhs.c1.z`, `this.c2.x, rhs.c2.x`, `this.c2.y, rhs.c2.y`, `this.c2.z, rhs.c2.z`, `this.c3.x, rhs.c3.x`, `this.c3.y, rhs.c3.y`, `this.c3.z, rhs.c3.z`
- Mat4x4: `this.c0.x, rhs.c0.x`, `this.c0.y, rhs.c0.y`, `this.c0.z, rhs.c0.z`, `this.c0.w, rhs.c0.w`, `this.c1.x, rhs.c1.x`, `this.c1.y, rhs.c1.y`, `this.c1.z, rhs.c1.z`, `this.c1.w, rhs.c1.w`, `this.c2.x, rhs.c2.x`, `this.c2.y, rhs.c2.y`, `this.c2.z, rhs.c2.z`, `this.c2.w, rhs.c2.w`, `this.c3.x, rhs.c3.x`, `this.c3.y, rhs.c3.y`, `this.c3.z, rhs.c3.z`, `this.c3.w, rhs.c3.w`

### extend 块 2：Numerical 比较（equalEpsilon）

**形态**：extend
**包路径**：glm.detail
**职责**：为 Mat{C}x{R}<T,Q> 提供 equalEpsilon 浮点容差比较方法，当 T 满足 Number<T> & Equatable<T> & Comparable<T> 约束时可用。

```cangjie
extend<T, Q> Mat{C}x{R}<T, Q> where T <: Number<T> & Equatable<T> & Comparable<T>, Q <: Qualifier {
    public func equalEpsilon(other: Mat{C}x{R}<T, Q>): Bool
}
```

**实现方式**：逐分量委托 `ComputeEqualNumeric<T>.callConst(a, b)`，各分量结果用 `&&` 连接。

**分量序列**：与 extend 块 1 相同（列主序）。

## 错误处理

无新的错误处理需求。比较操作返回 Bool，不抛出异常。

## 行为契约

- `==` 和 `equalExact` 行为语义等价，均委托 `ComputeEqual<T>.call` 进行精确比较
- `!=` 是 `==` 的逻辑取反
- `equalEpsilon` 委托 `ComputeEqualNumeric<T>.callConst` 进行浮点容差比较（对于 IEC 559 浮点类型使用 epsilon 比较，否则回退到精确比较）
- Bool 矩阵支持 ==/!=/equalExact（因为 Bool 实现了 Equatable），但不支持 equalEpsilon（因为 Bool 不满足 Number 约束）
- 所有 extend 块追加在文件末尾已有 extend 块之后

## 依赖关系

- 依赖 `ComputeEqual<T>` 和 `ComputeEqualNumeric<T>`（定义于 `compute_vector_relational.cj`，同包直接可见）
- 依赖 `Equatable<T>`、`Number<T>`、`Comparable<T>`（标准库特性）
- 无需修改现有 import 语句（`std.math.{ Number, Integer }` 已存在）
- 测试文件依赖 `std.unittest` 框架

## 测试设计

新建 `tests/glm/detail/test_type_mat_compare.cj`，package 声明为 `glm.detail`。

### 测试覆盖要求

每个矩阵类型（9 种）至少覆盖：

1. **== true**：构造两个元素相同的矩阵，断言 `==` 返回 true
2. **== false**：构造两个元素不同的矩阵，断言 `==` 返回 false
3. **!= true**：使用不相等的矩阵，断言 `!=` 返回 true
4. **!= false**：使用相等的矩阵，断言 `!=` 返回 false
5. **equalExact true**（Float32）：两相等 Float32 矩阵，断言 `equalExact` 返回 true
6. **equalExact false**（Float32）：两不等 Float32 矩阵，断言 `equalExact` 返回 false
7. **equalEpsilon true**（Float32）：两相等 Float32 矩阵，断言 `equalEpsilon` 返回 true
8. **equalEpsilon false**（Float32）：两不等 Float32 矩阵，断言 `equalEpsilon` 返回 false
9. **Bool 矩阵 ==/!=**：验证 Bool 矩阵的比较操作正常

### 测试用例命名约定

```
test{C}x{R}EqualTrue / test{C}x{R}EqualFalse
test{C}x{R}NotEqualTrue / test{C}x{R}NotEqualFalse
test{C}x{R}EqualExactTrue / test{C}x{R}EqualExactFalse
test{C}x{R}EqualEpsilonTrue / test{C}x{R}EqualEpsilonFalse
testBool{C}x{R}Equal / testBool{C}x{R}NotEqual
```

### 测试数据

- Float32 矩阵使用 Defaultp 限定符
- Bool 矩阵使用 Defaultp 限定符
- 使用 `@Expect(a, b)` 断言
