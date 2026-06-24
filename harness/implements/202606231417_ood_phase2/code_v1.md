# 实现报告（v1）

## 概述
为阶段二的矩阵类型提供函数库依赖闭合。创建了两个纯 stub 文件 `common.cj`（12 个标量函数）和 `geometric.cj`（17 个几何函数重载），所有函数体为 `throw Exception("stub")`，供 type_mat3x3/type_mat4x4 等方阵类型的 .inl 实现编译链接。

## 文件变更清单
| 操作 | 文件路径 | 说明 |
|------|---------|------|
| 新建 | src/detail/common.cj | 12 个公共数学 stub 函数 |
| 新建 | src/detail/geometric.cj | 17 个几何 stub 函数 |

## 编译验证
`cjpm build` 成功，无错误。预期未使用变量警告（stub 函数不引用参数）。

## 设计偏差说明
无偏差。所有签名、约束、异常行为与详细设计完全一致。
