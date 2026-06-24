# 实现报告（v4）

## 概述

对 6 个非方阵矩阵 skeleton 文件追加 4 个 extend 块（算术+工厂、跨类型构造、fromMat 6a×8、fromMat 6b×8），同步追加配套测试。完全复用 Mat2x2（v3 已验证 476 用例）的模式，仅尺寸和列向量类型差异。

## 文件变更清单

| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 修改 | src/detail/type_mat2x3.cj | Mat2x3<T,Q> 追加 4 个 extend 块 |
| 修改 | src/detail/type_mat2x4.cj | Mat2x4<T,Q> 追加 4 个 extend 块 |
| 修改 | src/detail/type_mat3x2.cj | Mat3x2<T,Q> 追加 4 个 extend 块 |
| 修改 | src/detail/type_mat3x4.cj | Mat3x4<T,Q> 追加 4 个 extend 块 |
| 修改 | src/detail/type_mat4x2.cj | Mat4x2<T,Q> 追加 4 个 extend 块 |
| 修改 | src/detail/type_mat4x3.cj | Mat4x3<T,Q> 追加 4 个 extend 块 |
| 修改 | tests/glm/detail/test_type_mat2x3.cj | 追加算术/工厂/跨类型/fromMat 测试 |
| 修改 | tests/glm/detail/test_type_mat2x4.cj | 追加算术/工厂/跨类型/fromMat 测试 |
| 修改 | tests/glm/detail/test_type_mat3x2.cj | 追加算术/工厂/跨类型/fromMat 测试 |
| 修改 | tests/glm/detail/test_type_mat3x4.cj | 追加算术/工厂/跨类型/fromMat 测试 |
| 修改 | tests/glm/detail/test_type_mat4x2.cj | 追加算术/工厂/跨类型/fromMat 测试 |
| 修改 | tests/glm/detail/test_type_mat4x3.cj | 追加算术/工厂/跨类型/fromMat 测试 |

## 编译验证

`cjpm build` 成功，`cjpm test` 476 用例全部 PASSED。

## 设计偏差说明

**偏差 1**：Extend 3/4 中 fromMat 的 6a/6b 实现中，当源矩阵列向量可以直接传递时（如 Mat3x2←Mat2x2 的 `m.c0` 列向量 Vec2 匹配目标行数），仍然使用 `Vec2<T,Q>(m.c0.x, m.c0.y)` 显式构造。原因：源矩阵的 qualifier 为 `SrcQ`，而目标矩阵的 qualifier 为 `Q`，直接传递 `m.c0` 会导致类型推断失败（"unable to infer generic argument"）。显式构造 Vec 解决了 `SrcQ` 到 `Q` 的泛型转换问题。其余无偏差。
