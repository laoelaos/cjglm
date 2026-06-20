# 实现报告（v9）

## 概述

在 `src/detail/scalar_vec_ops.cj` 中追加 12 个浮点具体类型 `mod` 函数重载（Float32/Float64/Float16 × Vec1/Vec2/Vec3/Vec4），同步追加对应测试用例和偏差文档更新。

## 文件变更清单

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 修改 | `src/detail/scalar_vec_ops.cj` | import 追加 `fmod`；追加 12 个浮点 `mod` 重载 |
| 修改 | `src/detail/scalar_vec_ops_test.cj` | 追加 12 个浮点正向测试 |
| 修改 | `tests/glm/detail/test_scalar_vec_ops.cj` | 追加 12 个正向测试 + 6 个边界测试 |
| 修改 | `docs/deviations.md` | 五、未验证的偏差删除 中追加 DEV-05 记录 |

## 编译验证

`cjpm build` 成功，仅输出 4 个与 `lib.cj` 中 `Vec1`-`Vec4` re-import shadow 相关的已有 warning。

## 设计偏差说明

- **函数签名 `where Q <: Qualifier` 编译错误**：设计中的函数签名（如 `public func mod(s: Float32, v: Vec1<Float32, Q>): Vec1<Float32, Q> where Q <: Qualifier`）缺少泛型参数 `<Q>`，编译器报 `unexpected 'where' in non-generic declaration`。实际实现为每个函数添加 `<Q>` 类型参数，如 `public func mod<Q>(s: Float32, v: Vec1<Float32, Q>): Vec1<Float32, Q> where Q <: Qualifier`。
- **`std.math.fmod` 调用改为 `fmod`**：设计中使用 `std.math.fmod` 全限定名，但 `fmod` 已通过 `import std.math.{ Number, Integer, fmod }` 直接导入当前作用域，`std` 在包作用域中不可见。实际调用改为 `fmod(s, v.x)`。
