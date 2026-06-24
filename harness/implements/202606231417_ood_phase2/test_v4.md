# 测试报告（v4）

## 概述

对 6 个非方阵矩阵类型（Mat2x3、Mat2x4、Mat3x2、Mat3x4、Mat4x2、Mat4x3）的 4 个 extend 块进行了配套测试。测试文件已存在且通过编译验证。

## 测试文件清单

| 文件路径 | 行数 | 状态 |
|---------|------|------|
| tests/glm/detail/test_type_mat2x3.cj | 509 | 已存在 |
| tests/glm/detail/test_type_mat2x4.cj | 585 | 已存在 |
| tests/glm/detail/test_type_mat3x2.cj | 500 | 已存在 |
| tests/glm/detail/test_type_mat3x4.cj | 716 | 已存在 |
| tests/glm/detail/test_type_mat4x2.cj | 567 | 已存在 |
| tests/glm/detail/test_type_mat4x3.cj | 707 | 已存在 |

## 测试覆盖维度

每个测试文件覆盖以下类别（参照 test_type_mat2x2.cj 模式）：

| 类别 | 测试项 | 说明 |
|------|--------|------|
| 构造 | 标量填充 init | 全部分量等于 scalar |
| 构造 | 逐分量 const init | 按列主序匹配 |
| 构造 | 列向量 const init | 各列与传入一致 |
| length | length() | 返回 C（列数） |
| 下标 | 取值/赋值/越界 | 含负索引异常 |
| col | col() 取值/越界/越界异常/负索引异常 | 正常访问+越界+负索引 |
| 一元负号 | `-m` | 逐分量取反 |
| 矩阵-标量 | + - * / | 逐分量运算 |
| 矩阵-矩阵 ± | 同尺寸加减 | 逐分量 |
| 矩阵-矩阵 × | 3 个跨尺寸乘法重载 | 按乘法公式展开 |
| 矩阵×Vec | Mat×VecC | 结果 VecR |
| diagonal | 对角线填充 | 对角=scalar，非对角=0 |
| identity | 单位矩阵 | 对角=one，非对角=0 |
| fromParts | 跨类型逐分量 | 经 conv 转换 |
| fromColumns | 跨类型列向量 | 经 conv 转换 |
| fromMat 7 | 跨类型同尺寸 | 各分量 conv |
| fromMat 6a | 8 方向各选 1 代表 | 收缩/扩展正确 |
| fromMat 6b | 8 方向各选 1 代表 | 收缩+conv 正确 |

## 编译验证

`cjpm build` 成功，`cjpm test` 476 用例全部 PASSED。

## 设计偏差

实现报告中的偏差已在代码中处理：Extend 3/4 中 fromMat 的 6a/6b 实现使用 `Vec2<T,Q>(m.c0.x, m.c0.y)` 显式构造而非直接传递列向量，以解决 `SrcQ` 到 `Q` 的泛型转换问题。
