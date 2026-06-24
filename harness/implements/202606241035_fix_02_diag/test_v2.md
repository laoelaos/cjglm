# 测试报告（v2）

## 概述
在 `test_scalar_mat_ops.cj` 中确认 24 个非方阵标量-矩阵运算单元测试函数（6 非方阵类型 × 4 运算，仅 Int64 类型）已编写完毕，覆盖详细设计所指定的全部覆盖率缺口。

## 测试文件
`cjglm/tests/glm/detail/test_scalar_mat_ops.cj`

## 测试函数清单

### add(s=3) 系列
| 测试函数 | 矩阵构造 | 标量 | 断言列数 | 状态 |
|---------|---------|------|---------|------|
| testScalarAddMat2x3Int64 | Mat2x3<Int64,Defaultp>(1,2,3,4,5,6) | Int64(3) | 2列 | ✅ |
| testScalarAddMat2x4Int64 | Mat2x4<Int64,Defaultp>(1,2,3,4,5,6,7,8) | Int64(3) | 2列 | ✅ |
| testScalarAddMat3x2Int64 | Mat3x2<Int64,Defaultp>(1,2,3,4,5,6) | Int64(3) | 3列 | ✅ |
| testScalarAddMat3x4Int64 | Mat3x4<Int64,Defaultp>(1,2,3,4,5,6,7,8,9,10,11,12) | Int64(3) | 3列 | ✅ |
| testScalarAddMat4x2Int64 | Mat4x2<Int64,Defaultp>(1,2,3,4,5,6,7,8) | Int64(3) | 4列 | ✅ |
| testScalarAddMat4x3Int64 | Mat4x3<Int64,Defaultp>(1,2,3,4,5,6,7,8,9,10,11,12) | Int64(3) | 4列 | ✅ |

### sub 系列
| 测试函数 | 矩阵构造 | 标量 | 断言列数 | 状态 |
|---------|---------|------|---------|------|
| testScalarSubMat2x3Int64 | Mat2x3<Int64,Defaultp>(1,2,3,4,5,6) | Int64(100) | 2列 | ✅ |
| testScalarSubMat2x4Int64 | Mat2x4<Int64,Defaultp>(1,2,3,4,5,6,7,8) | Int64(10) | 2列 | ✅ |
| testScalarSubMat3x2Int64 | Mat3x2<Int64,Defaultp>(1,2,3,4,5,6) | Int64(100) | 3列 | ✅ |
| testScalarSubMat3x4Int64 | Mat3x4<Int64,Defaultp>(1,2,3,4,5,6,7,8,9,10,11,12) | Int64(10) | 3列 | ✅ |
| testScalarSubMat4x2Int64 | Mat4x2<Int64,Defaultp>(1,2,3,4,5,6,7,8) | Int64(100) | 4列 | ✅ |
| testScalarSubMat4x3Int64 | Mat4x3<Int64,Defaultp>(1,2,3,4,5,6,7,8,9,10,11,12) | Int64(10) | 4列 | ✅ |

### mul 系列
| 测试函数 | 矩阵构造 | 标量 | 断言列数 | 状态 |
|---------|---------|------|---------|------|
| testScalarMulMat2x3Int64 | Mat2x3<Int64,Defaultp>(1,2,3,4,5,6) | Int64(3) | 2列 | ✅ |
| testScalarMulMat2x4Int64 | Mat2x4<Int64,Defaultp>(1,2,3,4,5,6,7,8) | Int64(2) | 2列 | ✅ |
| testScalarMulMat3x2Int64 | Mat3x2<Int64,Defaultp>(1,2,3,4,5,6) | Int64(3) | 3列 | ✅ |
| testScalarMulMat3x4Int64 | Mat3x4<Int64,Defaultp>(1,2,3,4,5,6,7,8,9,10,11,12) | Int64(2) | 3列 | ✅ |
| testScalarMulMat4x2Int64 | Mat4x2<Int64,Defaultp>(1,2,3,4,5,6,7,8) | Int64(3) | 4列 | ✅ |
| testScalarMulMat4x3Int64 | Mat4x3<Int64,Defaultp>(1,2,3,4,5,6,7,8,9,10,11,12) | Int64(2) | 4列 | ✅ |

### div 系列
| 测试函数 | 矩阵构造 | 标量 | 断言列数 | 状态 |
|---------|---------|------|---------|------|
| testScalarDivMat2x3Int64 | Mat2x3<Int64,Defaultp>(1,2,3,4,5,6) | Int64(30) | 2列 | ✅ |
| testScalarDivMat2x4Int64 | Mat2x4<Int64,Defaultp>(1,2,3,4,5,6,7,8) | Int64(60) | 2列 | ✅ |
| testScalarDivMat3x2Int64 | Mat3x2<Int64,Defaultp>(1,2,3,4,5,6) | Int64(30) | 3列 | ✅ |
| testScalarDivMat3x4Int64 | Mat3x4<Int64,Defaultp>(1,2,3,4,5,6,7,8,9,10,11,12) | Int64(60) | 3列 | ✅ |
| testScalarDivMat4x2Int64 | Mat4x2<Int64,Defaultp>(1,2,3,4,5,6,7,8) | Int64(30) | 4列 | ✅ |
| testScalarDivMat4x3Int64 | Mat4x3<Int64,Defaultp>(1,2,3,4,5,6,7,8,9,10,11,12) | Int64(60) | 4列 | ✅ |

## 断言覆盖统计
- 测试函数总数：24
- 正向用例：24（每个函数 1 个）
- 覆盖维度：正常路径（24/24）
- 断言总数：各函数按列优先逐分量断言，与详细设计完全一致

## 与设计偏差
无偏差。所有测试函数签名、矩阵构造参数、标量值、预期值均与详细设计严格一致。

## 文件位置
`cjglm/tests/glm/detail/test_scalar_mat_ops.cj`（第 233–583 行，在原有测试之后追加）
