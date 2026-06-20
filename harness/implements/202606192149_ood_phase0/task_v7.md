# 任务指令（v7）

## 动作
NEW

## 任务描述
修复 `scalar_vec_ops.cj` 中所有 20 个函数的 `const` 关键字问题：将 `public const func` 改为 `public func`，移除 `const` 限定。

**影响文件**：
| 操作 | 文件 | 说明 |
|------|------|------|
| 修改 | `src/detail/scalar_vec_ops.cj` | 删除 20 处 `const` 关键字 |

**无需修改的文件**：
- `src/detail/scalar_vec_ops_test.cj` — 测试调用不变
- `src/lib.cj` — import 不受影响

## 选择理由
验证报告 v6 显示 50 个编译错误全部来自 `scalar_vec_ops.cj`，错误均为 `expected 'const' expression`。函数体 `return VecN(s + v.x, ...)` 中 `s` 和 `v` 是函数参数（运行时值），不满足 `const func` 的编译期求值要求。

本修复属于 R3 向量类型层残留问题。R5 已修复 type_vec1~4.cj（96 errors → 0），剩余 scalar_vec_ops.cj（50 errors）是同一轮次的不同故障点。

## 任务上下文
`scalar_vec_ops.cj` 提供标量在左的辅助函数（add/sub/mul/div/mod × Vec1~Vec4），共 20 个重载。所有函数签名均为 `public const func` 且标记 `@OverflowWrapping`。修改时仅需删除 `const` 关键字，保留 `public func`、`@OverflowWrapping`、泛型参数、返回类型和函数体不变。

## 已有代码上下文
当前 `scalar_vec_ops.cj:1-103` 的内容结构：
- 5 组操作（add / sub / mul / div / mod）
- 每组 4 个重载（Vec1 / Vec2 / Vec3 / Vec4）
- `mod` 使用 `T <: Integer<T>`，其余使用 `T <: Number<T>`
- 全部标注 `@OverflowWrapping` 和 `public const func`

测试文件 `scalar_vec_ops_test.cj` 已存在 20 个测试用例（测试 add/sub/mul/div/mod 各 4 个 + 部分额外），调用方式如 `add(Int64(3), v)`，不受 `const` 删除影响。

## 验证标准
1. `cjpm build -i` 编译通过，无 scalar_vec_ops.cj 相关错误
2. `cjpm test` 运行通过，scalar_vec_ops 测试全部通过
