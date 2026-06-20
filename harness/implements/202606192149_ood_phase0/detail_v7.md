# 详细设计（v7）

## 概述
修复 `scalar_vec_ops.cj` 中所有 20 个函数的 `const` 关键字问题。函数体使用运行时参数（`s` 和 `v`），不满足仓颉 `const func` 的编译期求值要求，导致 50 个 `expected 'const' expression` 编译错误。

## 文件规划
| 文件路径 | 操作 | 职责 |
|---------|------|------|
| `src/detail/scalar_vec_ops.cj` | 修改 | 删除 20 处 `public const func` 中的 `const` 关键字 |

## 修改规格

### 修改范围
文件 `scalar_vec_ops.cj` 共 103 行，包含 20 个顶层函数，分为 5 组，每组 4 个 Vec1~Vec4 重载：

| 组 | 行号范围 | 当前签名 | 修改后签名 |
|---|---------|---------|-----------|
| add×4 | 6, 11, 16, 21 | `public const func add<T, Q>(...)` | `public func add<T, Q>(...)` |
| sub×4 | 26, 31, 36, 41 | `public const func sub<T, Q>(...)` | `public func sub<T, Q>(...)` |
| mul×4 | 46, 51, 56, 61 | `public const func mul<T, Q>(...)` | `public func mul<T, Q>(...)` |
| div×4 | 66, 71, 76, 81 | `public const func div<T, Q>(...)` | `public func div<T, Q>(...)` |
| mod×4 | 86, 91, 96, 101 | `public const func mod<T, Q>(...)` | `public func mod<T, Q>(...)` |

### 保留不变的内容
- `@OverflowWrapping` 属性标注
- 泛型参数 `<T, Q>` 及约束 `where T <: Number<T> | Integer<T>, Q <: Qualifier`
- 函数参数 `(s: T, v: VecN<T, Q>)` 及返回类型 `VecN<T, Q>`
- 函数体 `return VecN(...)` 全部保留
- 包声明 `package glm.detail` 和 import 语句

### 具体修改操作
对第 6, 11, 16, 21, 26, 31, 36, 41, 46, 51, 56, 61, 66, 71, 76, 81, 86, 91, 96, 101 行，将 `public const func` 替换为 `public func`。

## 错误处理
无运行时错误处理变更。修复后满足仓颉编译器要求，函数参数 `s`、`v` 不再要求编译期常量。

## 行为契约
- 所有 20 个函数保持完全相同的语义、泛型约束、参数类型和返回值
- 仅移除函数上的 `const` 限定符，调用方代码无需任何修改

## 依赖关系
| 文件 | 依赖 | 说明 |
|------|------|------|
| `scalar_vec_ops.cj` | `type_vec1~4.cj` 中的 `Vec1~4` 类型 | 函数返回值和参数中使用 |
| `scalar_vec_ops_test.cj` | `scalar_vec_ops.cj` 中导出的 20 个函数 | 无需修改，调用签名不变 |
